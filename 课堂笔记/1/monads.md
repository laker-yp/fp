# Monads

# 序幕

1. 我们先讨论如何 *use* 已经存在的 monads。

1. 然后解释 monads 是什么、它们如何工作，以及如何定义新的 monads。

1. 最后讨论 parsing monad。这里故意设计成 self-learning section，所以这部分 notes 没有 video recordings，对应 textbook 的 Chapter 13。

我们会使用下面这些 language "pragma" 和 imports，后面会解释它们：
```haskell
{-# LANGUAGE MonadComprehensions #-}
{-# OPTIONS_GHC -Wno-noncanonical-monad-instances #-}
{-# OPTIONS_GHC -Wno-x-partial #-}

import Control.Monad.Writer
import Control.Monad.State

import Control.Applicative
import Data.Char
```
# Motivation

考虑下面这个 Java program：略

在 Haskell 里，一个 type 为：
```hs
fac :: Int -> Int
```
的 function 按设计不能有 side-effects。Haskell 的 functions 是 "pure" 的，也就是没有 side-effects。不过，如果我们确实想要 side-effect，也可以做到。我们只需要改变 function 的 type，明确告诉 Haskell 这个 function 会带有这种 effect：
```hs
--它不是直接返回 Int，而是返回一个带 IO 副作用的计算过程，最后结果是 Int。
fac :: Int -> IO Int
fac n | n == 0    = pure 1
      | otherwise = do
                     putStrLn ("n = " ++ show n)
                     y <- fac (n-1)
                     pure (y * n)
```
`pure`相当于老版的return，把a放进a的context里面，比如maybe a的时候，pure 3就把3放进得到just 3

`<-`意思是把右边的context拆开得到纯元素比如`x <- just` 5那么x就等于5

这里 `IO` 是一个 **monad**。不同 monads 用来表示不同种类的 side-effects。Monads 也可以被组合起来，不过这个 module 不讲这个主题。

# monads的使用

### 最基础的fib
也有list comprehension notation版本的，略
```haskell
fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n-2) + fib (n-1)
```
### monads版本的fib（未具体定义的骨架）
我们把 function `fib` 改写成 *monadic form*，用到 `pure` 和 `do`：

不过这里默认的还是普通的Int，因为m还没被具体定义
```haskell
--                输入一个 Int，然后返回一个被某种 Monad m
fibm :: Monad m => Integer -> m Integer
fibm 0 = pure 0
fibm 1 = pure 1
fibm n = do                --do把多个 Monad actions 按顺序串起来运行，
          x <- fibm (n-2)  --用 <- 提取出右边里面的结果
          y <- fibm (n-1)
          pure (x+y)
```
我们先通过运行来理解 `fibm` 做了什么：
```hs
> fibm 11 :: Maybe Integer
Just 89
> fibm 11 :: [Integer]
[89]
```
意思是同样的fibm使用不同的 "monads"类型，结果的context就会不一样：

  * `m a = Maybe a`
  * `m a = [a]`
就会得到不同的结果（把a放进不同context）

对应地：

  * `pure x = Just x`
  * `pure x = [x]`
### The `Maybe` and list monads
回顾recall fibm骨架版
```haskell
fibm :: Monad m => Integer -> m Integer
fibm 0 = pure 0  --每个人的定义不同
fibm 1 = pure 1
fibm n = do               
          x <- fibm (n-2)  
          y <- fibm (n-1)
          pure (x+y)
```
分别给上面的骨架赋予不同的monads类型
```haskell
fib_maybe :: Integer -> Maybe Integer
fib_maybe = fibm

fib_list :: Integer -> [Integer] --也可以用list comprehension【略】
fib_list = fibm
```
### What are monads good for?
`fib`变成`fibm` 之后，一个很有用的事情是：把它分配到不同 monads，然后进行修改，从而得到不同的 "effects"

比如原本只能输出`21`，现在可以`[21]`也可以`just 21`

-
### 整合到一起写（ 当m = Maybe a ）
有一个麻烦的版本用case的我把他省【略】了
```haskell
fib1' :: Integer -> Maybe Integer
fib1' n | n <  0 = Nothing  --处理负数
        | n == 0 = pure 0  
        | n == 1 = pure 1
        | n >= 2 = do
                     x <- fib1' (n-2)
                     y <- fib1' (n-1)
                     pure (x+y)
```
### 整合到一起写（ 当m = list ）
和上面的区别就是 `[]` 代替 `Nothing`，用 `[x]` 代替 `Just x`
```haskell
fib2 :: Integer -> [Integer]
fib2 n | n <  0 = []    -处理负数
       | n == 0 = pure 0
       | n == 1 = pure 1
       | n >= 2 = do
                    x <- fib2 (n-2)
                    y <- fib2 (n-1)
                    pure (x+y)
```

### 整合到一起写（ 当m = IO ）

```haskell
fib3 :: Integer -> IO Integer
fib3 n | n <  0 = error ("invalid input " ++ show n) --处理负数
       | n == 0 = pure 0
       | n == 1 = pure 1
       | n >= 2 = do
                    putStrLn ("调用 n = " ++ show n) --多了这一行输出打印
                    x <- fib3 (n-2)
                    y <- fib3 (n-1)
                    pure (x+y)
```
当我们想在 computation 中进行 input/output，同时最后还要交付一个 result 时，就使用 `IO` monad：

Function `putStrLn` 只能在 `IO` monad 里使用。

用IO边计算边打印就知道fib有多低效了，输出一大堆中间的重复的流程

*Puzzle.*data1的时候accumulators 的高效实现。另一种实现，使用 无限list，也就是 lazy lists：
```haskell
fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

` zipWith (+) fibs (tail fibs)`意思是把`fibs`和`tail fibs`用+来zip

比如[1,1,2,3]和[1,2,3,5]用+来zip就得到[2,3,5,8...],最后再放到`0 : 1 :`前面
```
例如：
```hs
> take 20 fibs
[0,1,1,2,3,5, 。。。,4181]
> fibs !! 100
354224848179261915075
```
使用原始方法这辈子都不可能，因为它是 exponential time。

##  `Writer` monad
生成计算日志computation log

其实就像IO那样记录recursive的每一个过程，但不是把它们 print 出来，而是收集到一个list(也叫log）
```haskell
fib4 :: Integer -> Writer [Integer] Integer
fib4 n | n <  0 = error ("invalid input " ++ show n)
       | n == 0 = pure 0
       | n == 1 = pure 1
       | n >= 2 = do
                    tell [n]  --每一次都把当前的n放进这个list
                    x <- fib4 (n-2)
                    y <- fib4 (n-1)
                    pure (x+y)
```
`runWriter`从 `Writer` monad 的 element 中提取 resul
```hs
> runWriter (fib4 11)
(89,[11....0])
```

## `State` monad
计算递归的次数

模拟C、Java里的变量count++

在我们的例子里，state 是一个 `Int`

result 还是之前的 `Integer`。在 recursive calls 中，我们通过给 `Int` 加 1 来改变state：
```haskell
fib5 :: Integer -> State Int Integer
fib5 n | n <  0 = error ("invalid input " ++ show n)
       | n == 0 = pure 0
       | n == 1 = pure 1
       | n >= 2 = do
                    modify (+1)  --每一次都对counter进行++
                    x <- fib5 (n-2)
                    y <- fib5 (n-1)
                    pure (x+y)
```
`function `runState` 用来 initialize state，在这里初始值是 `0`意思是从0开始计算，然后运行 computation：
```hs
> runState (fib5 11) 0
(89,143)
```
计算结果是 89

counter 被++了 143 次 = recursive calls 的次数

### Using the state monad to get another algorithm for the Fibonacci function

考虑下面这个 Java method，用来计算 non-negative `n` 的第 `n` 个 Fibonacci number。如果 `n` 是 negative，它会无限 loop：
```java
static int fib (int n) {
  int x = 0;
  int y = 1;
  while (n != 0) {
    int tmp = x+y;
    x = y;
    y = tmp;
    n--;
  }
  return x;
}
```
我们可以用 state monad 在 Haskell 中模拟它。这里用 pair `(x,y)` 作为 state，而且不需要 temporary variable `tmp`。Helper function `f` 的 return type 是 `()`，因为我们只关心 state。Initial state 是 `(0,1)`。
```haskell
fib' :: Integer -> Integer
fib' n = x
 where
  f :: Integer -> State (Integer, Integer) ()
  f 0 = pure ()
  f n = do
         modify (\(x,y) -> (y, x+y))
         f (n-1)

  ((),(x,y)) = runState (f n) (0,1)
```
这很快也很 efficient，并且等价于 [data1] 中讨论过的 accumulators 方法。
```hs
> fib' 11
89
```

## What monads are, how they work, and how to define new ones

### The general definition of the `Monad` class

要定义 `Monad`，我们需要先定义 `Applicative`，而要定义 `Applicative`，又要先定义 `Functor`：

```hs
class Functor f where
 fmap :: (a -> b) -> f a -> f b

class Functor f => Applicative f where
 pure  :: a -> f a
 (<*>) :: f (a -> b) -> f a -> f b

class Applicative m => Monad m where
 return :: a -> m a
 (>>=)  :: m a -> (a -> m b) -> m b

 return = pure
```

### Example: the `list` monad

这一部分有对应的 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=4cd39e86-9b25-4340-8836-ac6d00c5daab)。

List type former 在 `Functor` class 里有一个 instance，定义如下：
```hs
instance Functor [] where
 fmap = map
```
回忆一下，`map` 在 prelude 中定义，并且满足下面的 equations：
```hs
map :: (a -> b) -> [a] -> [b]
map f []     = []
map f (x:xs) = f x : map f xs
```
List type former 在 `Applicative` class 里也有一个 instance，定义如下：
```hs
instance Applicative [] where
 pure x = [x]
 gs <*> xs = [ g x | g <- gs, x <- xs]
```
Example. 下面这个 list 有 `2 * 5` 个 elements：
```hs
> [(+1),(*10)] <*> [1..5]
[2,3,4,5,6,10,20,30,40,50]
```
它把 functions "add one" 和 "multiply by 10" 应用到 numbers from 1 to 5 的 list 上。

最后，list monad 定义如下：
```hs
(>>=) :: [a] -> (a -> [b]) -> [b]
xs >>= f = [y | x <- xs, y <- f x]
```

### Example: the `Maybe` monad

这一部分有对应的 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=01e4469d-9d09-4694-82ba-ac6d00c62c61)。

`Maybe` type former 在 `Functor` class 里有一个 instance，定义如下：
```hs
instance Functor Maybe where
 fmap g Nothing  = Nothing
 fmap g (Just x) = Just (g x)
```
`Maybe` type former 在 `Applicative` class 里有一个 instance，定义如下：
```hs
instance Applicative Maybe where
 pure x = Just x
 Nothing <*> xm = Nothing
 Just g  <*> xm = fmap g xm
```
Examples：
```hs
> Just (+1) <*> Nothing
Nothing
> Just (+1) <*> Just 100
Just 101
> Nothing <*> Just 100
Nothing
> Nothing <*> Nothing
Nothing
```

最后，`Maybe` monad 定义如下：
```hs
(>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
Nothing >>= f = Nothing
Just x  >>= f = f x
```

### Example: the `Writer` monad

`Writer'` monad 已经被定义好了，所以我们定义自己的 version `Write'`。

```haskell
data Writer' a = Result a String
                deriving Show

instance Monad Writer' where
  return x = Result x ""
  xm >>= f = case xm of
               Result x s -> case f x of
                               Result y t -> Result y (s ++ t)

-- Boiler plate:

instance Functor Writer' where
  fmap f xm = do x <- xm
                 pure (f x)

instance Applicative Writer' where
      pure = return
      fm <*> xm = do f <- fm
                     x <- xm
                     pure (f x)
```

## Example: the `State` monad

`State` monad 已经被定义好了，所以我们定义自己的 version `State'`。

`State` monad 让我们可以模拟 storage 里的 variables。更抽象地说，我们有一个 state，并且可以在 computation 过程中 modify 这个 state。如果我们处在某个 given state，我们想产生：

 * 一个 result；
 * 一个 new state。

做这件事的 process 叫做 *transition function*。所以我们用字母 `T` 作为 constructor。

```haskell
data State' s a = T (s -> (a,s))
```
我们会使用这些 letters：

  * `x`, `y`, `z` 表示 type `a` 的 values；
  * `u`, `v`, `w` 表示 type `s` 的 states；
  * `p`, `q` 表示 type `s -> (a,s)` 的 transition functions。

Destructor，也就是 constructor `T` 的反方向 function，传统上叫做 `runState`：
```haskell
runState' :: State' s a -> (s -> (a, s))
runState' (T p) = p
```
注意，不是 `State'` 本身是 monad，而是对于某个 state type `s` 来说，`State' s` 才是 monad。
```haskell
instance Monad (State' s) where
  return x = T (\u -> (x,u))
  -- (>>=) :: State' s a -> (a -> State' s b) -> State' s b
  xm >>= f = case xm of
               T p -> T (\u -> case p u of
                                (x, v) -> case f x of
                                            T q -> q v)
```

 * `pure` function 给定一个 value `x`，会创建一个 transition function。这个 transition function 不改变当前 state `u`，只是把 `x` 和 `u` 配成一对。

 * Bind function `>>=` 更复杂：

    * 给定 `xm :: State' s a` 和 `f :: a -> State' s b`，我们需要产生一个 type 为 `State' s b` 的东西。
    * 我们先用 `case` 从 `xm` 中 extract transition function，也就是 `p`。（也可以用 `runState'`。）
    * 然后用 constructor `T` 创建 result 的 transition function。
    * 从 state `u` 开始，把 `p` 应用到 `u`。
    * 这会给出一个 pair，再用 `case` inspect。
    * Pair 的第一个东西是 value `x`，把它交给 `f`。
    * `f` 会产生 transition function `q`，然后我们把 state `v` 传给 `q`。

根据 Haskell 里 new-style definition of monads，我们还需要 boiler-plate code：
```haskell
instance Functor (State' s) where
  fmap f xm = do x <- xm
                 pure (f x)

instance Applicative (State' s) where
      pure = return
      fm <*> xm = do f <- fm
                     x <- xm
                     pure (f x)
```
上面定义了 monad。我们还需要定义三个 side-effects functions。

这个读取 state：
```haskell
get' :: State' s s
get' = T (\s -> (s,s))
```
这个用给定 state 替换当前 state：
```haskell
put' :: s -> State' s ()
put' s = T (\_ -> ((), s))
```
这个通过把一个 function 应用到当前 state 上来 modify state：
```haskell
modify' :: (s -> s) -> State' s ()
modify' f = T(\s -> ((), f s))
```

### Translating `do` notation to `>>=`

`do` notation 本质上只是 `>>=` 的 syntax sugar。例如，上面的 definition：
```hs
fibm :: Monad m => Integer -> m Integer
fibm 0 = pure 0
fibm 1 = pure 1
fibm n = do
          x <- fibm (n-2)
          y <- fibm (n-1)
          pure (x+y)
```
会 desugar 成：
```haskell
fibm'' :: Monad m => Integer -> m Integer
fibm'' 0 = pure 0
fibm'' 1 = pure 1
fibm'' n = fibm'' (n-2) >>= (\x ->
           fibm'' (n-1) >>= (\y ->
           pure (x+y)))
```

更多细节可以看 textbook 和网站 [All About Monads](https://wiki.haskell.org/All_About_Monads)。



## Monadic Parsing

### What is a parser?

_parser_ 是一个 program：它接收一个 characters string 作为 input，然后产生某种 tree，让这个 string 的 syntactic structure 变得明确。

例如，string `2*3+4` 可以被 parsed 成下面这个 expression tree：

```hs
       +
      / \
     *   4
    / \
   2   3
```

这个 tree 的 structure 明确表示：`+` 和 `*` 都是有两个 arguments 的 operators，而且 `*` operator 的 precedence 高于 `+`。

**Example Parsers**: Calculator program that parses numeric expressions, GHC system for parsing Haskell programs.

在 Haskell 里，parser 可以看成一个 function：它接收 string，并产生 tree。于是我们可以定义 parser type：

```hs
type Parser = String -> Tree
```

一般来说，parser 不一定会 consume 完全部 input string，所以还可以把没有被 consume 的 input string 一起返回：

```hs
type Parser = String -> (Tree, String)
```

类似地，parser 不一定总能成功 parse input，所以我们可以进一步 generalise parser type，让它返回 results list。返回 empty list 表示 failure，返回 singleton list 表示 success。

```hs
type Parser = String -> [(Tree, String)]
```

不同 parsers 可以返回不同种类的 trees，比如 integer value。因此最好把 return type 作为 Parser type 的一个 parameter：

```hs
type Parser a = String -> [(a, String)]
```

上面这个 declaration 的意思是：_一个 type 为 **a** 的 parser，是一个接收 input string 并产生 results list 的 function；每个 result 都是一个 pair，包含一个 type 为 **a** 的 result value 和一个 output string_。

### Basic Definitions

实现 parser 会用到下面两个 standard libraries：一个处理 applicative functors，一个处理 characters：

```hs
import Control.Applicative
import Data.Char
```

为了让 Parser type 可以成为 classes 的 instances，我们先用 newtype 重新定义它，并给一个 dummy constructor，叫 **P**：

```haskell
newtype Parser a = P (String -> [(a, String)])
```

这种 Parser 可以通过一个简单移除 dummy constructor 的 function 应用到 input string 上：

```haskell
parse :: Parser a -> String -> [(a, String)]
parse (P p) inp = p inp
```

我们定义第一个 parsing primitive function，叫做 `item`。如果 input string 是 empty，它失败；否则它用第一个 character 作为 result value，并成功：

```haskell
item :: Parser Char
item = P (\inp -> case inp of
                     []     -> []
                     (x:xs) -> [(x,xs)])
```

Item parser 是所有其他 consume input characters 的 parsers 的 basic building block。

例如：
```hs
> parse item ""
[]

> parse item "abc"
[('a',"bc")]
```

### Sequencing and Making Choice between Parsers

现在我们会让 parser type 成为 functor、applicative 和 monad classes 的 instance，这样就可以用 **do notation** 把 parsers 按顺序 combine 起来。我们也会考虑 parser 可能 parsing failure 的情况。

先让 `Parser` type 成为 functor：

```haskell
instance Functor Parser where
  -- fmap :: (a -> b) -> Parser a -> Parser b
  fmap g p = P (\inp -> case parse p inp of
                           []        -> []
                           [(v,out)] -> [(g v, out)])
```

也就是说，如果 parser 成功，`fmap` 会把一个 function 应用到 parser 的 result value 上；如果 parser 失败，就传播 failure。

例如：
```hs
> parse (fmap toUpper item) "abc"
[('A',"bc")]

> parse (fmap toUpper item) ""
[]
```

现在，我们可以让 `Parser` type 成为 applicative functor：

```haskell
instance Applicative Parser where
  -- pure :: a -> Parser a
  pure v = P (\inp -> [(v,inp)])

  -- <*> :: Parser (a -> b) -> Parser a -> Parser b
  pg <*> px = P (\inp -> case parse pg inp of
                   []         -> []
                   [(g, out)] -> parse (fmap g px) out)

```

这里 applicative function `pure` 会把一个 value 转成一个 parser。这个 parser 总是成功，并且把这个 value 当作 result，而且不 consume input string：

```hs
> parse (pure 1) "abc"
[(1,"abc")]
```

Applicative primitive `<*>` 的意思是：一个 parser 返回 function，另一个 parser 返回 argument，组合后得到一个 parser，它返回 function applied to argument 的结果；并且只有所有 components 都成功时它才成功。例如，一个 consume 三个 characters、丢弃第二个、返回第一个和第三个作为 pair 的 parser 可以用 applicative style 定义：

```hs
three :: Parser (Char,Char)
three = pure g <*> item <*> item <*> item
        where g x y z = (x, z)
```

例如：

```hs
> parse three "abcdef"
[(('a','c'),"def")]

> parse three "ab"
[]
```

最后，我们让 `Parser` type 成为 monad：

```haskell
instance Monad Parser where
  -- (>>=) :: Parser a -> (a -> Parser b) -> Parser b
  p >>= f = P (\inp -> case parse p inp of
                          []        -> []
                          [(v,out)] -> parse (f v) out)
```

也就是说，如果 parser `p` 应用到 input string `inp` 上失败，那么 `p >>= f` 也失败；否则，把 function `f` 应用到 result value `v` 上，得到另一个 parser `f v`，再把它应用到第一个 parser 产生的 output string `out` 上，得到最终 result。

现在我们可以用 **do notation** 来 sequence parsers 并处理它们的 result values。例如：

```hs
three :: Parser (Char,Char)
three = do x <- item
           item
           z <- item
           pure (x,z)
```

另一种自然的 parser combination 是：先把一个 parser 应用到 input string 上；如果失败，就把另一个 parser 应用到同一个 input 上。这里我们可以用 `empty` 和 choice operator `<|>` 实现这个想法。`empty` parser 无论 input 是什么都失败，而 choice operator 如果第一个 parser 成功，就返回它的 result；否则对同一个 input 使用第二个 parser：

```haskell
instance Alternative Parser where
  -- empty :: Parser a
  empty = P (\inp -> [])

  -- (<|>) :: Parser a -> Parser a -> Parser a
  p <|> q = P (\inp -> case parse p inp of
                          []        -> parse q inp
                          [(v,out)] -> [(v,out)])
```

例如：

```hs
> parse empty "abc"
[]

> parse (item <|> pure 'd') "abc"
[('a',"bc")]

> parse (empty <|> pure 'd') "abc"
[('d',"abc")]
```

### Derived Primitives and Handling Spacing

使用目前定义的三个 basic parsers，也就是 `item`、`pure` 和 `empty`，再加上 sequencing 和 choice，我们可以定义其他 useful parsers。例如，下面定义 parser `sat p`，它 parse 满足某个 predicate `p` 的 single character：

```haskell
sat :: (Char -> Bool) -> Parser Char
sat p = do x <- item
           if p x then pure x else empty
```

类似地，我们可以定义下面这些 parsers，用来 parse single digits、lower-case letters、upper-case letters、arbitrary letters、alphanumeric characters 和 specific characters。

```haskell
digit :: Parser Char
digit = sat isDigit

lower :: Parser Char
lower = sat isLower

upper :: Parser Char
upper = sat isUpper

letter :: Parser Char
letter = sat isAlpha

alphanum :: Parser Char
alphanum = sat isAlphaNum

char :: Char -> Parser Char
char x = sat (==x)
```

例如：

```hs
> parse (char 'a') "abc"
[('a',"bc")]

> parse (char 'b') "abc"
[]
```

使用 `char`，我们可以定义 parser `string xs`，用来 parse characters string xs，并把 string 本身作为 result value 返回：

```haskell
string :: String -> Parser String
string []         = pure []
string (x:xs)     = do char x
                       string xs
                       pure (x:xs)
```

**Note:** 上面的 string parser 只有在整个 target string 都从 input 中被 consumed 时才成功。例如：

```hs
> parse (string "abc") "abcdef"
[("abc","def")]

> parse (string "abc") "ab1234"
[]
```

我们也可以使用来自 `Alternative` class definition 的 `many` 和 `some` parsers。`many p` 和 `some p` 会尽可能多次应用给定 parser `p`，直到它失败为止，并把每次成功的 result values 放进一个 list 返回。`many` 允许 zero or more 次应用，而 `some` 要求至少成功一次。例如：

```hs
> parse (many digit) "123abc"
[("123","abc")]

> parse (many digit) "abc"
[("","abc")]

> parse (some digit) "abc"
[]
```

现在，我们可以定义 parsers，用来 parse identifiers、natural numbers 和 spacing。Identifier 是 lower-case letter 后面跟着 zero or more alphanumeric characters；natural number 是 one or more digits；spacing 是 zero or more space、tab 和 newline characters。

```haskell
ident :: Parser String
ident = do x <- lower
           xs <- many alphanum
           pure (x:xs)

nat :: Parser Int
nat = do xs <- some digit
         pure (read xs)

space :: Parser ()
space = do many (sat isSpace)
           pure ()
```

例如：

```hs
> parse ident "abc def"
[("abc"," def")]

> parse nat "123 abc"
[(123," abc")]

> parse space "   abc"
[((),"abc")]
```

使用 `nat` parser，我们可以定义 integer values 的 parser：

```haskell
int :: Parser Int
int = do char '-'
         n <- nat
         pure (-n)
      <|> nat
```

例如：

```hs
> parse int "-123 abc"
[(-123," abc")]

> parse int "4567 abc"
[(4567," abc")]
```

#### Handling Spacing

大多数 real-life parsers 都允许 basic tokens 周围自由使用 spacing。例如，strings `1+2` 和 `1 + 2` 会被以同样的方式 parsed。我们可以定义一个新的 primitive，它会在应用某个 token parser 之前和之后忽略任意 spaces：

```haskell
token :: Parser a -> Parser a
token p = do space
             v <- p
             space
             pure v
```

使用 `token`，我们可以定义忽略 identifiers、natural numbers、integers 和 special symbols 周围 spacing 的 parsers：

```haskell
identifier :: Parser String
identifier = token ident

natural :: Parser Int
natural = token nat

integer :: Parser Int
integer = token int

symbol :: String -> Parser String
symbol xs = token (string xs)

-- a parser for a non-empty list of natural numbers that ignores spacing
nats :: Parser [Int]
nats = do symbol "["
          n <- natural
          ns <- many (do symbol ","
                         natural)
          symbol "]"
          pure (n:ns)
```

例如：

```hs
> parse nats "  [1, 2,  3]  "
[([1,2,3],"")]

> parse nats "  [ 10,   2  34  ] "
[]

> parse nats "  [ 10,   2,  ] "
[]
```

### Parsing Arithmetic Expressions

在这个 example 中，我们考虑 arithmetic expressions：它们由 natural numbers 通过 addition、multiplication 和 parentheses 构造出来。我们假设 addition 和 multiplication 都向右结合，并且 multiplication 的 priority，也就是 precedence，高于 addition。例如，`2+3+4` 表示 `2+(3+4)`，而 `2*3+4` 表示 `(2*3)+4`。

我们可以用 _grammar_ 描述任意 language 的 syntactic structure。Grammar 是一组 rules，说明这个 language 的 strings 如何被 constructed。例如，arithmetic expressions 的 grammar 可以写成：

```
expr ::= expr + expr | expr * expr | (expr) | nat
nat  ::= 0 | 1 | 2 | ...
```

对于 expression `2*3+4`，可以构造一个 _parse tree_，其中 expression 中的 tokens 出现在 leaves，而 grammatical rules 对应 branching structure。

不过，上面的 grammar 会允许同一个 expression 有多个 possible parse trees，比如把 `2*3+4` 错误解释成 `2*(3+4)`。问题在于 grammar 没有体现 multiplication 比 addition 有更高 priority。

我们可以修改 grammar，为每个 precedence level 单独写 rule：addition 最低，multiplication 中间，parentheses 和 numbers 最高。

```
expr   ::= expr + expr | term
term   ::= term * term | factor
factor ::= (expr) | nat
nat    ::= 0 | 1 | 2 | ...
```

这个 grammar 仍然没有体现 addition 和 multiplication 向右结合。例如，`2+3+4` 仍然可能对应 `(2+3)+4` 或 `2+(3+4)`。我们可以把 addition 和 multiplication 的 rules 改成在右侧递归：

```
expr   ::= term + expr | term
term   ::= factor * term | factor
factor ::= (expr) | nat
nat    ::= 0 | 1 | 2 | ...
```

新的 grammar 可以正确 parse `2+3+4`，只得到一个 parse tree，对应正确解释 `2+(3+4)`。

这个 grammar 是 _unambiguous_ 的，也就是说每个 well-formed expression 恰好有一个 parse tree。接下来我们可以把 grammar 简化，因为一些 expressions 有共同部分。例如，rule `expr ::= term + expr | term` 表示 expression 要么是 term 加 expression，要么就是 term。换句话说，一个 expression 总是以 term 开头，后面可能跟一个 addition of expression，也可能什么都没有。

![Final Grammar](./images/final_grammar_parsing.png)

上面的 grammar 可以直接翻译成 expression parser，只需要用 parsing primitives 重写 rules：

```haskell
expr :: Parser Int
expr = do t <- term
          do symbol "+"
             e <- expr
             pure (t + e)
           <|> pure t

term :: Parser Int
term = do f <- factor
          do symbol "*"
             t <- term
             pure (f * t)
           <|> pure f

factor :: Parser Int
factor = do symbol "("
            e <- expr
            symbol ")"
            pure e
          <|> natural
```

**Note:** 上面的 parsers 返回的是被 parsed expression 的 integer value，而不是某种 expression tree。

最后，使用 `expr`，我们定义一个 function：它 parse 并 evaluate 一个 expression，然后返回得到的 integer value。未被 consume 的 input 和 invalid input 会导致 error messages 和 program termination：

```haskell
eval :: String -> Int
eval xs = case parse expr xs of
             [(n,[])]  -> n
             [(_,out)] -> error ("Unused input " ++ out)
             []        -> error "Invalid input"
```

例如：

```hs
> eval "2*3+4"
10

> eval "2+3*4+2"
16

> eval "(2+3)*(4+2)"
30

> eval "one plus two"
*** Exception: Invalid input
```
