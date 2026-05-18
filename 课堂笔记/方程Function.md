# Functions in Haskell

* Read also Chapter 4 of the text book "Programming in Haskell.

## Overview

在这一课里，我们会学习 Haskell 里定义 functions 的几种不同方式。
我们会学习下面这些方式：

1. Composition of existing functions
2. Conditionals (`if _ then _ else _ `)
3. Guarded equations
4. Pattern matching
5. Lambda expressions

最后，我们还会看一下 **operators**，也就是像 `++` 这种 infix function symbols，以及怎么把它们变成普通 functions。


## Composing functions

这一节的视频，包括 exercise 的讲解，在 [这里](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=fbf5d940-700b-46ab-aee2-ac3e016514bd)。

我们可以把已有的 functions 组合起来，得到新的 functions。
比如：
```haskell
removeLast :: [a] -> [a]
removeLast xs = reverse (tail (reverse xs))

removeElem :: Int -> [a] -> [a]
removeElem n xs = removeLast (take n xs) ++ drop n xs
```

**Exercise:** 使用上面的 functions，写一个 function，把一个 list 的第一个和最后一个 element 都删掉。

## Conditionals

Haskell 提供了 `if _ then _ else _`。它的 type 是 `Bool -> a -> a -> a`，而且是 polymorphic 的。
```haskell
abs' :: Integer -> Integer
abs' n = if n >= 0 then n else -n
```
**Note:** `else` branch 是必须写的。

我们可以嵌套使用 `if _ then _ else _`：
```haskell
howMuchDoYouLikeHaskell :: Int -> String
howMuchDoYouLikeHaskell x = if x < 3 then "I dislike it!" else
                               if x < 7 then "It's ok!" else
                                 "It's fun!"
```
不过这样写很难读；guarded equations，也就是下面会讲的写法，通常会更清楚。
所以我们会尽量避免使用 conditionals。

**Exercise:** 阅读 Haskell wiki 上关于 [`if _ then _ else _ ` 的讨论](https://wiki.haskell.org/If-then-else)。


## Guarded equations

这一节的视频，包括 exercise 的讲解，在 [这里](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=b80a3cd6-5293-4d0b-8177-ac3e01692c24)。

Guarded equations 是 `if _ then _ else _` expressions 的另一种写法。它们通常更容易读：
```haskell
abs :: Int -> Int
abs n | n >= 0    = n
      | otherwise = -n
```
这里，`n >= 0` 和 `otherwise` 叫做 **guards**；它们都是 Booleans。
这个 function 会返回第一个 evaluate 成 `True` 的 **guard** 后面的 value。

Guarded equations 通常比 `if _ then _ else _` 更方便：
```haskell
howMuchDoYouLikeHaskell2 :: Int -> String
howMuchDoYouLikeHaskell2 x | x < 3       = "I dislike it!"
                           | x < 7       = "It's ok!"
                           | otherwise   = "It's fun!"
```

**Exercise:** 使用 guarded equations，写一个 type 为 `Int -> Int -> Bool` 的 function。如果第一个 argument 大于第二个 argument，并且小于第二个 argument 的两倍，就返回 `True`。


## Pattern matching

**Pattern matching** 的意思是：根据 input 是怎么构造出来的，来分析这个 input。
Input 会依次和一组 patterns 进行匹配；第一个匹配成功的 pattern 会决定这个 function 的 output。

### Overview

Boolean value 只有两种可能：`True` 或 `False`。
所以只要给这两种情况分别写 pattern 就够了：
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

最简单的 patterns 之一，就是对 Booleans 进行匹配。

如果 input 只有一个 Boolean，那么只有两种 patterns：
```haskell
notB' :: Bool -> Bool
notB' False = True
notB' True = False
```
如果一个 function 接收两个 Booleans 作为 input，那么就有 2^2 = 4 种 patterns：
```haskell
andB :: Bool -> Bool -> Bool
andB True True = True
andB True False = False
andB False True = False
andB False False = False
```
最后三个 patterns 可以合并。这里，wildcard pattern `_` 可以匹配任何东西，并且会把它丢掉，也就是后面不再使用它：
```haskell
andB' :: Bool -> Bool -> Bool
andB' True True = True
andB' _ _      = False
```
这两个版本之间有一个区别：在后一个版本里，如果第一个 argument 是 `False`，那么第二个 argument 根本不需要被 evaluated，function 会立刻返回 `False`。

在下一个例子里，pattern `b` 可以匹配任何东西。不过，和 `_` 不一样的是，**我们可以在 `=` 右边使用 `b`**：
```haskell
andB'' :: Bool -> Bool -> Bool
andB'' True b  = b
andB'' False _ = False
```

**Exercise:** 写一个 function `orB :: Bool -> Bool -> Bool`，如果至少一个 argument 是 `True`，就返回 `True`。


### Non-exhaustive patterns

考虑下面这个例子：
```haskell
isTrue :: Bool -> Bool
isTrue True = True
```
**Question:** `isTrue False` 会 evaluate 成什么？

**Answer:** 这是一个 non-exhaustive pattern，也就是 pattern 没有覆盖所有情况，所以 `isTrue False` 会抛出一个 exception：
```hs
> isTrue False
*** Exception: defining-functions.hs:36:1-18: Non-exhaustive patterns in function isTrue
```
我们也可以选择主动抛出一个 custom-made exception：
```haskell
isTrue' :: Bool -> Bool
isTrue' True = True
isTrue' False = error "not True"
```


### On tuples

如果我们正在定义的 function 期待一个 **tuple** 作为 input，那么我们可以直接对 tuple 里的各个 components 做匹配：

```haskell
fst :: (a,b) -> a
fst (x,y) = x
```
实际上，我们在这个 function 的 output 里没有用到 `y`，所以也可以写成 `fst (x,_) = x`。
类似地：
```haskell
snd :: (a,b) -> b
snd (_,y) = y
```
这个思路可以推广到有三个或更多 components 的 tuples：
```haskell
third :: (a, b, c) -> c
third (_, _, z) = z
```
我们也可以同时匹配多个 tuples：
```haskell
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)
```

**Exercise:** 写一个 function `swap :: (a, b) -> (b, a)`，交换一个 pair 里的两个 elements。

### On lists

也可以看这个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=3eebebd8-9a8c-49ef-8a85-ac3f0003b4ee)。

所有 lists 都是通过不断在已有 list 前面加 elements，也就是用 `(:)`，一步一步构造出来的，最开始是 empty list `[]`。
这意味着 list `[1, 2, 3]` 可以看成是 `1:[2,3]` 得到的，等等。更完整地说，`[1, 2, 3]` 其实是 `1:(2:(3:[]))` 的简写。
换句话说，`[a]` 里的每一个 list，要么是：
1. empty list；或者
2. 形如 `x:xs`，其中 `x :: a`，`xs :: [a]`。

```haskell
isEmpty' :: [a] -> Bool
isEmpty' [] = True
isEmpty' (x:xs) = False
```
在第二个 pattern 的 output 里，我们其实没有用到 `x` 或者 `xs`，所以这个 function 可以写得更简单：
```haskell
isEmpty'' :: [a] -> Bool
isEmpty'' [] = True
isEmpty'' (_:_) = False
```
注意，第二个 pattern 里的 `_:_` 外面的 parentheses 是必须的！

我们也可以写更复杂的 list patterns。比如要返回一个 list 的第二个 element：
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
