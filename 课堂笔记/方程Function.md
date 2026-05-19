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

前面提到的 patterns 是一些特殊形式，比如针对 Booleans 和 lists 的写法。
更一般的 pattern matching 形式，是通过 `case` expressions 来写：

```haskell
isEmpty2 :: [a] -> Bool
isEmpty2 x = case x of [] -> True
                       (_:_) -> False
```
这里很重要的一点是：所有 patterns 必须完全对齐，也就是说 `[]` 和 `(_:_)` 必须从同一列开始。

## Lambda expressions

Lambda expressions 是**没有名字的** functions。它们在 **higher-order functions** 里特别有用，而 higher-order functions 会在后面的课里讲。
这一节配套的视频在 [这里](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=5734065c-57af-43b0-a5be-ac400000eb9c)。

Lambda expressions 的形式是 `\<input variables> -> <output>`。
比如，我们可以把一个返回自身 double 的 function 定义成 `\x -> 2 * x`。
这里，input variable 用 backslash `\` 表示。箭头 `->` 后面写的是这个 function 的 output。
`\` 代表希腊字母 λ，也就是 lambda，见 [Wikipedia](https://en.wikipedia.org/wiki/Lambda)。
所以，下面这两个 definitions 是等价的：
```haskell
double :: Int -> Int
double x = 2 * x

double' :: Int -> Int
double' = \x -> 2 * x
```
Lambda expressions 可以有**多个** input variables：
```haskell
mult :: Int -> Int -> Int
mult x y = x * y

mult' :: Int -> Int -> Int
mult' = \x y -> x * y
```
这里，第二种写法其实是下面这种写法的简写：
```haskell
mult'' :: Int -> (Int -> Int)
mult'' = \x -> (\y -> x * y)
```
就像 pattern 可以忽略 input 的一部分一样，lambda expression 也可以忽略它的 input：
```haskell
alwaysZero :: Bool -> Int
alwaysZero = \_ -> 0
```

Lambda expressions 的一个重要用途是 **higher-order functions**，也就是 functions 可以作为 arguments 传给其他 functions。
考虑：
```haskell
apply :: (a -> b) -> a -> b
apply f x = f x
```

```hs
> apply (\_ -> 5) 'r'
5
> apply (\ x -> if x < 0 then "Less than zero!" else "Greater or equal than zero!") (-3)
"Less than zero!"
```


## Operators and sections

关于 operators and sections，也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=361993f2-6410-4be3-8f23-ac46017605da)。

当一个 function 有两个 arguments，比如 `(:)`，我们可以把它写成 infix，也就是放在两个 arguments 中间。
一个以 infix 方式使用的 function，也就是必须是 binary 的 function，叫做 **operator**。
1. 任意 binary function 都可以通过加 backticks 变成一个 operator。比如 `div 7 2` 可以写成 ``7 `div` 2``。
2. 反过来，任意 operator 也可以通过加 parentheses 变成 prefix 形式，比如 `(:) 1 [2,3]`。

每一个 operator `⊗`，如果它的 inputs 类型分别是 `a` 和 `b`，output 类型是 `c`，那么都可以产生三种 **sections**：
1. `(⊗) :: a -> b -> c`。这里，`(⊗) = \x y -> x ⊗ y`。
2. `(x ⊗) :: b -> c`，其中 `x :: a`。这里，`(x ⊗) = \y -> x ⊗ y`。
3. `(⊗ y) :: a -> c`，其中 `y :: b`。这里，`(⊗ y) = \x -> x ⊗ y`。

Sections 可以用来简洁地定义 functions：
```haskell
square :: Int -> Int
square = (^2)

reci :: Fractional a => a -> a
reci = (1 /)
```
Remarks:
1. 一个 operator `⊗` 单独出现时，不是一个 valid Haskell expression：它必须作为 section 使用，比如 `(⊗)`。
2. Sections 在写 higher-order functions 的时候很有用，这个会在后面的 lesson 里继续用到。


## Exercises
(Adapted and expanded from the book "Programming in Haskell)
1. 定义 function `third :: [a] -> a` 的三个版本，让它返回任意长度足够的 list 里的第三个 element，分别使用：
    1. `head` and `tail`
    2. list indexing `!!`
    3. pattern matching
2. 定义一个 function `safetail :: [a] -> [a]`，它的行为和 tail 类似，但它会把 `[]` 映射到 `[]`，而不是抛出 error。使用 `tail` 和 `isEmpty :: [a] -> Bool`，
   分别用下面三种方式定义 `safetail`：
   1. a conditional expression
   2. guarded equations
   3. pattern matching

## See also
1. [Chapter 3, "Syntax in Functions" of "Learn You a Haskell"](/files/Resources/LearnYouaHaskell/LearnYouaHaskell.pdf)
2. Haskell Wiki on [Sections](https://wiki.haskell.org/Section_of_an_infix_operator)

## Summary
1. 我们已经看到了几种定义 functions 的方式：composition, conditionals, guard equations, pattern matching, lambda expressions。
2. 当 patterns 不是 exhaustive 的时候，只要没有任何 pattern 匹配成功，function 就会抛出 exception。为了避免这个问题，可以在最后加一个 catch-all `otherwise` pattern。
3. 任意 pattern matching 都可以用 `case` expression 表达。
4. Anonymous functions 可以用 lambda expressions 简洁地写出来。
