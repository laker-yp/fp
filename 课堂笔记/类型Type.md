# Types in Programming, types in Haskell



## Why are types useful?

在 programming languages 里，types 的作用就是**不允许**某些不合理的程序出现。
保证：我们传给一个 function 的 arguments，必须是这个 function 原本设计好能处理的那种东西。

Types 可以让我们在 compile time 就发现这种错误


### Type inference

合理的expression 都有一个 type，而且我们可以让 `ghci` 告诉我们这个 type。这就叫 **type inference**：
```hs
ghci> :type False
False :: Bool

ghci> :type True
True :: Bool
```
这里的 double colon `::` 可以读作 "has type"，比如 "False has type Bool"。

在 Haskell 里，我们也有 **function types**：
```hs
ghci> :type not
not :: Bool -> Bool
```

在 Haskell 里，function application 直接把 function 和 argument 放在一起写就行了。如果你把一个合适 type 的 argument 传给一个 function，那么 output type 也就很自然地能看出来：
```hs
ghci> :type not False
not False :: Bool
```

### Type checking

我们可以让 `ghci` **confirm** 某个 expression 是否具有某个给定的 type：
```hs
ghci> :type False :: Bool
False :: Bool :: Bool

ghci> :type not False :: Bool
not False :: Bool :: Bool
```
这就叫 **type checking**。

----

**Remark on type checking vs type inference**

在写 Haskell 程序的时候，更安全的做法是：我们先告诉 Haskell，我们希望某个 expression 是什么 type，然后让 Haskell 帮我们确认这个 type 是不是对的。这样比完全让 Haskell 自己去推断我们正在写的 functions 的 type 更稳。
一个好的 programmer 通常会先写下自己要构造的 function 的 type，然后再开始写 function 本身。

----

**Exercise**

用 `ghci` 找出下面这些 expressions 的 type：

1. `not (not (not False))`

1. `(True,False)` (see Section 3.4 of Programming in Haskell)

1. `['a', 'b', 'x']` (see Section 3.3 of Programming in Haskell)

1. `(++)` (What is strange about this type? See "polymorphic functions" discussed later.)

Tip: 为了更简洁，你可以用 `:t` 代替 `:type`。

**Explanation**: Watch this [video "Type-inference in Haskell using ghci"](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=5a13e413-dc73-44ab-976d-adab008c569e) on Canvas.

----

## Type inference before evaluation

很重要的一点是：Haskell expression 的 type 是在这个 expression 被 evaluated **之前**就 infer 出来的。
如果一个 expression 没有 type，那么它就不是一个 valid Haskell expression，Haskell 也不会去 evaluate 它。
比如说，expression `if True then 1 else "foo"` 就没有一个 valid type，因为 `1` 和 `"foo"` 不是同一种 type，所以这个 expression 会被拒绝。
拒绝的原因是：如果情况更复杂一点，`True` 被换成了一个更复杂的、type 为 `Bool` 的 expression，那么 Haskell 就无法保证最终 return type 到底是什么。它可能是一个 `Integer`，也可能是一个 `[Char]`。这就意味着 Haskell 不能保证 **type safety**：也就是 type errors 只会发生在 compilation 阶段，而不会发生在 evaluation，也就是 runtime 阶段。

----
**Exercise**

- 写出五个 ill-typed expressions in Haskell。
- 在 `ghci` 里 check 它们的 types，看看 `ghci` 会说什么。
- 当你尝试 evaluate 这些 expressions 的时候，会发生什么？

**Explanation**: Watch this [video "Ill-typed expressions in Haskell"](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=664d2900-c2d3-4ed6-b8da-adab008c574c) on Canvas.

----

## Well-typed programs can fail

不是每一个 valid，也就是 well-typed 的 Haskell expression，都一定能顺利 evaluate 而不报错：
```hs
ghci> :type (!!)
(!!) :: [a] -> Int -> a

ghci> :type ["foo", "bar"] !! 5
["foo", "bar"] !! 5 :: [Char]

ghci> ["foo", "bar"] !! 5
"*** Exception: Prelude.!!: index too large
```
另一个例子是 division by zero：
```hs
ghci> :type 1 `div` 0
1 `div` 0 :: Integral a => a
ghci> 1 `div` 0
*** Exception: divide by zero
```

----

**Exercise**

使用 `ghci`，或者查看 [online documentation of Hackage: The Haskell Package Repository](https://hackage.haskell.org/)，找出 function `(!!)` 是做什么的。

Hint: 你可以在 [这里](https://hackage.haskell.org/package/base-4.14.0.0/docs/Data-List.html) 找到 list library 的 documentation。

----

## Tour of Haskell types

在这一节里，我们会看一些 Haskell types，包括 base types 和 composite types。
这一节配套的视频在 [这里](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=27d77c3a-fca7-4142-bda9-adab008c5cf4)。

### Base types

Haskell 有很多种 base types：

1. `Bool` - Booleans 的 type

1. `Char` - characters 的 type

1. `Int` - fixed-precision integers，也就是固定精度整数，范围大概在 -(2^63) 到 (2^63)-1 之间；要注意 buffer overflows！

1. `Integer` - arbitrary-precision integers，也就是任意精度整数

1. `Float` - 带 decimal point 的 numbers

1. `Double` - 和 floats 类似，但是 precision 更高

```hs
ghci> :type False
False :: Bool

ghci> :type 'c'
'c' :: Char

ghci> :type "foo"
"foo" :: [Char]

ghci> :type 2 :: Int
2 :: Int :: Int

ghci> :type 2 :: Integer
2 :: Integer :: Integer

ghci> :type (sqrt 2)
(sqrt 2) :: Floating a => a

ghci> :type (sqrt 2) :: Float
(sqrt 2) :: Float :: Float

ghci> :type (sqrt 2) :: Double
(sqrt 2) :: Double :: Double

ghci> sqrt 2 :: Float
1.4142135

ghci> sqrt 2 :: Double
1.4142135623730951
```

### Composite types

我们可以用简单的 types 组合出更复杂的 types：

1. 如果 `a` 是一个 type，那么 `[a]` 就是由 `a` 里面的 values 组成的 list 的 type。

1. 如果 `a` 和 `b` 是 types，那么 `(a,b)` 就是 pair 的 type，里面第一个 value 来自 `a`，第二个 value 来自 `b`。

1. 把上面这个点推广一下，我们也可以构造 triples `(a, b, c)`，quadruples `(a, b, c, d)`，等等。

1. 如果 `a` 和 `b` 是 types，那么 `a -> b` 就是从 `a` 到 `b` 的 functions 的 type。

```hs
ghci> :type [True, False]
[True, False] :: [Bool]

ghci> :type []     -- Polymorphic function
[] :: [a]

ghci> :type [['a', 'b'], ['c']]
[['a', 'b'], ['c']] :: [[Char]]

ghci> :type "How are you?"
"How are you?" :: [Char]

ghci> :type (False, 'c')
(False, 'c') :: (Bool, Char)

ghci> :type not
not :: Bool -> Bool

ghci> :type (++)
(++) :: [a] -> [a] -> [a] -- Polymorphic function
```

## Curried functions

(See also Chapter 3.6 of "Programming in Haskell")

这一节在这个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=60ca35b8-6c4c-46c6-897d-adab008c5c55) 里有讲。
这个 video 也讲了本节最后的 exercise。

考虑这个 function：
```haskell

add :: (Integer, Integer) -> Integer
add (x,y) = x + y
```
因为一个 function 也可以 return 一个 function，所以我们也可以把这个 function 写成下面这样：
```haskell
add' :: Integer -> (Integer -> Integer)
add' x y = x + y
```
**Notes:**

1. 这个原理和 propositional logic 里证明 `A → B → C` 等价于证明 `A ∧ B → C` 是同一个思路！

1. `Integer -> (Integer -> Integer)` 里的 parentheses 不是必须的；我们可以直接写成 `Integer -> Integer -> Integer`。

1. 类似地，`add' x y` 实际上的意思是 `(add' x) y`；这里的 parentheses 也不需要写出来。不过，如果我们想写类似 `f (g x)` 这种东西，那 parentheses 就是需要的。

这个原理可以推广到有两个以上 arguments 的 functions：
```haskell
add3 :: Integer -> Integer -> Integer -> Integer
add3 x y z = x + y + z
```
**Exercise:** 把这个 function 和它的 type annotation 里所有被省略的 parentheses 都补回来。

这个 section 的 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=60ca35b8-6c4c-46c6-897d-adab008c5c55) 里给出了 solution。

## A useful `ghci` command: `:info`

除了 `:type` 之外，另一个非常有用的 command 是 `:info`：
```hs
ghci> :info Bool
data Bool = False | True 	-- Defined in ‘GHC.Types’
instance Eq Bool -- Defined in ‘GHC.Classes’
instance Ord Bool -- Defined in ‘GHC.Classes’
instance Show Bool -- Defined in ‘GHC.Show’
instance Read Bool -- Defined in ‘GHC.Read’
instance Enum Bool -- Defined in ‘GHC.Enum’
instance Bounded Bool -- Defined in ‘GHC.Enum’
```
第一行给出了 datatype `Bool` 的 definition，以及它的两个 values：`False` 和 `True`。后面那些以 `instance` 开头的行是什么意思，会在 [type classes](../4_Type_classes_and_instances/typeclasses.md) 这一课里解释。

```hs
ghci> :info not
not :: Bool -> Bool 	-- Defined in ‘GHC.Classes’
```

可惜的是，`ghci` 目前好像没有一个 command 可以直接显示某个 function 的 **body**，比如 function `not :: Bool -> Bool` 的具体 implementation。
如果你想看这个，就需要去看 source code，比如可以在 [Hackage](https://hackage.haskell.org/) 上看。


## Exercise
阅读 "Programming in Haskell" 的 Chapters 3.2-3.6，并且把 examples 输入到 `ghci` 里试一试。在探索的时候，多用 `:type` 和 `:info`。

## Summary

1. Haskell expressions 在被 evaluated 之前，会先经过 type-checked。

1. 只有 well-typed expressions 才可以被 evaluated。

1. Haskell 里仍然可能发生 run-time errors，但是不会发生和 typing 有关的 errors。

1. 在 `ghci` 里，`:type` (= `:t`) 和 `:info` (= `:i`) 可以用来了解更多关于 types 和 expressions 的信息。
