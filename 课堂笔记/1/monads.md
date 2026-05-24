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

# Monads原理

### The general definition of the `Monad` class

要定义 `Monad`，我们需要先定义 `Applicative`，而要定义 `Applicative`，又要先定义 `Functor`：

首先知道`m a`带某种 effect/context/盒子 的 a，比如m是maybe，m a就可能是just a或nothing
### 类型类Functor--有`fmap`函数
*  fmap = map函数的升级版，能处理【m a】
```hs
class Functor f where
 fmap :: (a -> b) -> f a -> f b
```
`fmap :: (a -> b) -> f a -> f b`

* 你给我一个普通函数 a -> b，我可以把它应用到 context 里面的值上
* 比如说`(+1) :: Int -> Int`这个函数作为输入，fmap(+1) (Just 5)就等于Just 11，其中`contextm a`是【Maybe a】

### 类型类Applicative--有`pure`和`<*>`函数, 继承Functor
*  `pure`= 把一个普通值放进 context 里面
*  `<*>`和fmap差不多，不过fmap处理普通函数，`<*>`处理的函数也在 context 里面
```hs
class Functor f => Applicative f where
 pure  :: a -> f a
 (<*>) :: f (a -> b) -> f a -> f b
```
比如Just (+1)的类型就是 Maybe (Integer -> Integer)

Just (+1) <*> Just 10 的第一个输入为带着maybe盒子的(+1)函数，第二个输入为带着maybe盒的int
### 类型类Monads--有`reture`和`>>=`继承Applicative，
```hs
class Applicative m => Monad m where
 return :: a -> m a
 (>>=)  :: m a -> (a -> m b) -> m b

 return = pure
```
* `reture`就相当于pure
* `>>=`把`m a`拆包提取a，放进一个处理普通a生成带盒b的f，得到带盒b
 * maybe时`Just x  >>= f = f x`
 * safeDiv 10 2 >>= \x ->  --本身得到just 5，拆包得到5，放入x
 * safeDiv x 5  这里的x是第一步得到的拆包后的5
do的底层逻辑演示
```hs
do
  x <- action1      action1 >>= \x ->
  y <- action2      action2 >>= \y ->
  pure (x+y)        pure (x+y)
```
# 各种Monads类型的原理
。
## `list` monad原理


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
 gs <*> xs = [ g x | g <- gs, x <- xs] --分别把gs的g提出来，xs的x提出来，依次g x
--可以写成
gs >>= \g ->
xs >>= \x ->
pure (g x)
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
xs >>= f = [y | x <- xs, y <- f x]  --这个最重要
```
对 list 里的每个 x 都调用 f，最后把所有结果合并成一个 list。
##  `Maybe` monad原理

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

## `Writer` monad原理

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

## `State` monad原理

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

##  `do` 和 `>>=` 的转化

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

