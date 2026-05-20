# Functions in Haskell

## Overview

学习下面这些方式：

1. Composition of existing functions
2. Conditionals (`if _ then _ else _ `)
3. Guarded equations
4. Pattern matching
5. Lambda expressions

学习 **++**，这种 infix怎么把它们变成普通 functions。


## Composing functions
把已有的 functions 组合起来，得到新的 functions。
比如：
**tail**:去掉第一个元素之后剩下的 list。
tail[1,2,3]--输出[2,3]

**drop**：把前 n 个元素丢掉，返回剩下的 list。
drop 2 [1, 2, 3, 4, 5]--输出[4,5]

**take**:从 list 前面取出前 n 个元素
take 3 [1,2,3,4,5]--输出[1,2,3]
```haskell
removeLast :: [a] -> [a]
removeLast xs = reverse (tail (reverse xs))

removeElem :: Int -> [a] -> [a]
removeElem n xs = removeLast (take n xs) ++ drop n xs
```

**Exercise:** 写function，把一个 list 的第一个和最后一个 element 都删掉。
```
function :: [a] ->[a]
function xs = tail(reverse (tail (reverse xs)))
```
## Conditionals

 `if _ then _ else _`是 polymorphic
```haskell
abs' :: Integer -> Integer
abs' n = if n >= 0 then n else -n
```

可以嵌套使用 `if _ then _ else _`但不方便
```haskell
x = if x < 3 then "I dislike it!" else
                               if x < 7 then "It's ok!" else
                                 "It's fun!"
```

## Guarded equations

```haskell
abs :: Int -> Int
abs n | n >= 0    = n
      | otherwise = -n
```
这里，|后面的`n >= 0` 和 `otherwise` 叫做 **guards**；

每个guard都是 Booleans，可判断TF

function 会返回第一个为T的**guard** 后面的 value。

Guarded equations 通常比 `if _ then _ else _` 更方便：
```haskell
howMuchDoYouLikeHaskell2 :: Int -> String
howMuchDoYouLikeHaskell2 x | x < 3       = "I dislike it!"
                           | x < 7       = "It's ok!"
                           | otherwise   = "It's fun!"
```

## Pattern matching

input 是由哪些pattern构造出来的，把它们列出来

Input 会依次和一组 patterns 进行匹配；

第一个匹配成功的 pattern 会决定这个 function 的 output。

### Overview
比如function **not** 的input是Bool

Bool，有两种pattern：`True` 或 `False`组成
```haskell
notB :: Bool -> Bool
notB False = True
notB True = False
```

Pair 只有一种构造方式：
```haskell
swap :: (a, b) -> (b, a)
swap (x,y) = (y,x)
```

List 有两种构造方式：
```haskell
isEmpty :: [a] -> Bool
isEmpty []     = True
isEmpty (x:xs) = False
```
接下来我们会详细看这些情况。

### On Booleans
and的input为两个Bool，每个Bool有两个pattern

那么and这个function就有 2^2 = 4 种 patterns：
```haskell
and :: Bool -> Bool -> Bool
and True True = True
and True False = False
and False True = False
and False False = False
```
但最后三个 patterns 可以合并。这里，wildcard pattern `_` 可以匹配任何东西
```haskell
and :: Bool -> Bool -> Bool
and True True = True
and _ _      = False --意思是无论_里面是什么，输出都是False
```
在下一个例子里，pattern `b`和上面的_一样 可以匹配任何东西。
但_只能用在input里面
而**我们可以在 `=` 右边使用 `b`**：
```haskell
and :: Bool -> Bool -> Bool
and True b  = b
and False _ = False
```

**Exercise:** 写一个 function `orB :: Bool -> Bool -> Bool`，如果至少一个 argument 是 `True`，就返回 `True`。
```haskell
orB :: Bool -> Bool -> Bool
orB True _ = True
orB _ True = True
orB _ _ = False  --Haskell 会从上到下依次匹配，不会直接跳到最后，
                            上面的pattern匹配成功了都不用看这行
```

### Non-exhaustive（不完全覆盖） patterns

考虑下面这个例子：
```haskell
isTrue :: Bool -> Bool
isTrue True = True
```
 pattern 没有覆盖所有情况，所以 `isTrue False` 会抛出一个 exception：

我们也可以选择主动抛出一个exception：
```haskell
isTrue' False = error "not True"
```
### On tuples
这个
function 把 **tuple** 作为 input

那么我们可以直接对 tuple 里的各个 components 做匹配：

```haskell
third :: (a, b, c) -> c
third (_, _, z) = z
```

### On lists


所有 lists 都是通过用 `(:)`，一步一步构造出来的，最开始是 empty list `[]`。
`[1, 2, 3]` 其实是 `1:(2:(3:[]))`

换句话说，`[a]` 里的每一个 list，只有两种case：
1. []
2. 形如 `x:xs`，其中

   `x :: a`
 
   `xs :: [a]`。

```haskell
isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty (x:xs) = False --其实没有用到 `x` 和 `xs`
变简单↓
isEmpty (_:_)  = False
          ↑
    这个pattern外面的括号是必须的！
```


aim: 返回一个 list 的第二个 element
```haskell
sndElem :: [a] -> a
sndElem (_:x:_) = x
```

### Case expressions

通过 `case` expressions 来写pattern

```haskell
isEmpty2 :: [a] -> Bool
isEmpty2 x = case x of [] -> True
                       (_:_) -> False
```
所有patterns 必须完全对齐，也就是说 `[]` 和 `(_:_)` 必须从同一列开始。

## Lambda expressions

Lambda expressions 是**没有名字的** functions
\x -> x * 2 是个可以直接使用的function，不过没有名字

使用：ghci (\x -> x * 2) 5

 Lambda:
 
形式是         `function名字 = \输入的变量 -> 输出`。

返回自身 double 的 function ：  \x -> 2 * x

                                ↑
                                
                              input为x

```haskell
double :: Int -> Int
double = \x -> 2 * x
```
**多个** input 变量：
```haskell
mult' :: Int -> Int -> Int
mult' = \x y -> x * y
```
pattern 可以忽略 input 的一部分，lambda expression 也可以
```haskell
alwaysZero :: Bool -> Int
alwaysZero = \_ -> 0  --无论input什么output都为0
```

Lambda的一个重要用途是 **higher-order functions**

functions 可以作为 arguments 传给其他 functions

考虑：apply 接收一个 function 和一个 value，然后把这个 function 用在这个 value 上。
```haskell
apply :: (a -> b) -> a -> b
apply f x = f x
```

```hs
> apply (\_ -> 5) 'r'
5
--这里面input的f是将任何东西变成5，输入的a是'r'

> apply (\ x -> if x < 0 then "小于零" else "大于等于0") (-3)
--输入3放进输入的判断function中，输出：
"小于0"
```


## Operators and sections

当一个 function 有两个 arguments，比如 `(:)`

我们可以把它写成 infix，也就是放在两个 arguments 中间 1:[2,3]

一个以 infix 方式使用的 function，也就是必须是 binary(两个参数的意思) 的 function，叫做 **operator**。

比如div 10 2，div这个function就是operator

1. binary function 通过加 `` 变成一个 运算符
   比如 `div 7 2` 可以写成 ``7 `div` 2``。
2. 反过来，任意 operator 也可以通过加（）变成 prefix 形式
   比如`1:[2,3]`变成 `(:) 1 [2,3]`。

每一个 operator `⊗`，如果它的 inputs 类型分别是 `a` 和 `b`，output 类型是 `c`，那么都可以产生三种 **sections**：
1. `(⊗) :: a -> b -> c`。
   `(⊗) = \x y -> x ⊗ y`
   
3. `(x ⊗) :: b -> c`，其中 `x :: a`。
   `(x ⊗) = \y -> x ⊗ y`
   
5. `(⊗ y) :: a -> c`，其中 `y :: b`。
   `(⊗ y) = \x -> x ⊗ y`
   
一个例子看明白

(>5) = \x -> x > 5

(5>) = \y -> 5 > y

Sections 可以用来简洁地定义 functions：
```haskell
square :: Int -> Int
square = (^2)

reci :: Fractional a => a -> a
reci = (1 /)
```


## Exercises
(Adapted and expanded from the book "Programming in Haskell)
1. 定义 function `third :: [a] -> a` 的三个版本，让它返回任意长度足够的 list 里的第三个 element，分别使用：
    1. `head` and `tail`
    2. list indexing `!!`
    3. pattern matching
```haskell
third1 :: [a] -> a
third1 xs = head(tail(tail xs))

third2 :: [a] -> a
third2 xs = xs !! 2

third3 :: [a] -> a
third3 (_:_:x:_)=x
```
2. 定义一个 function `safetail :: [a] -> [a]`，它的行为和 tail 类似,返回第一个elem之外的list
   但它会把 `[]` 映射到 `[]`，而不是抛出 error
   使用 `tail` 和 `isEmpty（其实就是null方程，换了个名而已） :: [a] -> Bool`，
   分别用下面三种方式定义 `safetail`：
   -- 假设已经有：

isEmpty :: [a] -> Bool

isEmpty xs = null xs

   1. a conditional expression
   2. guarded equations
   3. pattern matching
```haskell
safetail1 :: [a] -> [a]
safetail1 xs =if null xs then [] else tail xs

safetail2 ::[a] ->[a]
safetail2 xs
	|null xs = []
	|otherwise=tail xs

safetail3 :: [a] -> [a]
safetail3 [] = []
safetail3 xs =tail xs
--也可以 (_:xs) = xs
```

## Summary
1.  functions 的方式：composition, conditionals, guard equations, pattern matching, lambda expressions。
2. 当 patterns 不是 exhaustive 的时候，只要没有任何 pattern 匹配成功，function 就会抛出 exception。为了避免这个问题，可以在最后加一个 catch-all `otherwise` pattern。
3. 任意 pattern matching 都可以用 `case` expression 表达。
4. Anonymous functions 可以用 lambda expressions 简洁地写出来。
