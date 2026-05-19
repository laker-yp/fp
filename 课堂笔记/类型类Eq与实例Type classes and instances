# Type classes and instances

* See the [prelude for the current version of the language](https://hackage.haskell.org/package/base-4.12.0.0/docs/Prelude.html) for all predefined classes and their instances.

## Introduction

**Video:** 这个 introduction 也有对应的 [recording](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=0495c024-653b-48da-87df-ac3d0154eaf9)。

我们经常想检查 Haskell 里的两个 values 是否相等。

**Observation:** 我们只想比较两个**相同 type** 的 values 是否相等。
比如说，问一个 Boolean 是否等于一个 character，这本身没有什么意义。

所以我们可能会想写一个 **polymorphic function**：
```hs
(==) : a -> a -> Bool
```
但是，并不是对任意给定 type 的两个 values，我们都能判断它们是否相等。

**Exercise:** 找一个 type `a`，它的 values 不能用 Boolean function `a -> a -> Bool` 来比较 equality。

视频里给出了一个这样的 type。

这个问题的解决方案就是 **type classes**：

1. 一个 **type class** 是一个 interface，用来描述一个或多个 types 上的一组 operations。

1. 一个 type class 的 **instance**，就是任何已经实现了这个 interface 的 type。

在 Haskell 里，operation `(==)` 有下面这个 type：
```hs
ghci> :type (==)
(==) :: Eq a => a -> a -> Bool
```
这里：

1. `Eq` 是一个 **type class**。

1. 对任意 type `a`，如果它是 type class `Eq` 的一个 **instance**，那么 `(==)` 就是一个 type 为 `a -> a -> Bool` 的 function；但注意，只对这样的 `a` 才成立。

1. `Eq a => a -> a -> Bool` 里的 `Eq a` 是一个 **class constraint**。

----

**Exercise**

1. 在 `ghci` 里运行并理解下面这些 examples：
    1. `False == 'c'`
    2. `False == True`
    3. `False == not`
    4. `False == not True`
    5. `not == id`
    6. `[not] == [ (id :: Bool -> Bool) ]`

**Explanation:** See the [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=d808dc3f-e37b-4e3a-8197-ac3d015b9ced)。

对于 example 6，Haskell 会理解成：它应该去找 `Eq [Bool -> Bool]` 这个 instance。因为存在一个 generic instance：`Eq a => Eq [a]`，所以 Haskell 会继续去找 `Eq (Bool -> Bool)` 这个 instance。可惜，正如 example 5 里看到的，这个 instance 不存在。

2. 用你自己的话解释，为什么 `(++)` 不需要任何 class constraints，但是 `(==)` 需要。
----

## The type class `Eq`

**Video:** See [here](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=02d9fdae-ae5f-4d3e-bf5e-ac3d0165178a)。

我们可以用下面这种方式获得关于 type class `Eq` 的信息。为了更容易阅读，下面删掉了一些文字：
```hs
ghci> :info Eq
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
  {-# MINIMAL (==) | (/=) #-}
  	-- Defined in ‘GHC.Classes’
instance (Eq a, Eq b) => Eq (Either a b)
  -- Defined in ‘Data.Either’
instance Eq a => Eq [a] -- Defined in ‘GHC.Classes’
instance Eq Word -- Defined in ‘GHC.Classes’
instance Eq Ordering -- Defined in ‘GHC.Classes’
instance Eq Int -- Defined in ‘GHC.Classes’
instance Eq Float -- Defined in ‘GHC.Classes’
instance Eq Double -- Defined in ‘GHC.Classes’
instance Eq Char -- Defined in ‘GHC.Classes’
instance Eq Bool -- Defined in ‘GHC.Classes’
...
instance (Eq a, Eq b, Eq c) => Eq (a, b, c)
  -- Defined in ‘GHC.Classes’
instance (Eq a, Eq b) => Eq (a, b) -- Defined in ‘GHC.Classes’
instance Eq () -- Defined in ‘GHC.Classes’
instance Eq Integer
  -- Defined in ‘integer-gmp-1.0.2.0:GHC.Integer.Type’
instance Eq a => Eq (Maybe a) -- Defined in ‘GHC.Base’
```
这告诉我们下面这些事情：

1. Type class `Eq` 提供两个 functions：`(==)` 和 `(/=)`。

1. 如果想在某个 type `a` 上实现这个 type class，我们至少要实现 `(==) :: a -> a -> Bool` 或者 `(/=) :: a -> a -> Bool` 其中一个。

1. 很多 `Eq` 的 instances 已经被实现好了，比如 `Word`、`Ordering`、`Int` 等等。
   此外，还有一些 **derived** instances：

   1. 如果 types `a` 和 `b` 是 instances，那么 pair type `(a,b)`，也就是由 `a` 和 `b` 里的 values 组成的 pair，也会是 instance。

   2. 类似地，如果 `a` 是 `Eq` 的 instance，那么由 `a` 的 values 组成的 list type `[a]` 也是 `Eq` 的 instance。

上面没有打印出来的额外信息：

1. 当 user 在实现 instance 时，只提供 `(==)` 和 `(/=)` 其中一个，另一个会自动被定义成它的 **negation**，比如：
   `x /= y = not (x == y)`。

1. 这些信息并没有告诉我们每个 instance 里 `(==)` 的具体 implementation 是什么。如果想知道具体实现，需要去看 source code。


## Summary: type classes and instances

* Haskell 里的 `class` 有点像 Java 里的 `interface`。

* 在 Haskell 里，我们用 keyword `instance` 来实现一个 `class`。

* 只有用 `data` 或者 `newtype` 引入的 types，才能被做成 classes 的 instances，不过 GHC 有一些 extensions 可以绕开这个限制。

* 对于任何给定的 `data` type 或者 `newtype`，同一个 class 只能声明**一个** instance，不过 GHC 也有一些 extensions 可以绕开这个限制。

* 在 function type 里，`=>` 前面的所有东西都是 **class constraint**：这个 function 只对那些是所提到 classes 的 instances 的 types 可用。

## Inheritance: Extending a type class

就像 Java interface 可以 extend 一个 interface 一样，type class 也可以 extend 一个 type class。
考虑下面这个例子：
```hs
ghci> :i Ord
class Eq a => Ord a where
...
```
这里，type class `Ord`，也就是下面会详细看的东西，extends type class `Eq`。换句话说，如果想把一个 type `a` 变成 `Ord` 的 instance，那么首先需要把它变成 `Eq` 的 instance。
这个之后会更详细地学习。

## Exercises

1. 找出 GHC Prelude 里定义的 type class `Bounded` 的所有 basic instances，也就是启动 `ghci` 时默认加载的 libraries 里的 instances，不需要 import 额外 libraries。找出每个 instance 的 `minBound` 和 `maxBound` 是什么。

1. Type classes `Fractional`、`Floating`、`Integral` 分别 extend 了哪些 type classes？它们提供了哪些 functions？如果要实现 trigonometric calculus，你会选择实现哪个 type class？

1. 另一个 type class：

    1. 哪个 type class 定义了 function `enumFromTo`？

    1. 在这个 type class 的每个 instance 的 elements 上 evaluate `enumFromTo`。

    1. 解释 `:type enumFromTo 4 8` 和 `:type enumFromTo 4 (8 :: Int)` 的输出为什么不同。如果不确定答案，可以在 Discord server 上问。

1. 为什么 Haskell 对于一个给定 type，只允许它拥有某个 type class 的**一个** instance？
