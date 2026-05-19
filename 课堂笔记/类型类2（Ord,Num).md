# More on type classes and instances
目录：

1. Type class `Ord`，用于 ordered types。
2. Type class `Num`，用于 numeric types。

我们也会学习一个 *instance declaration with constraints* 的例子：`instance Ord a => Ord [a]`。
这个 instance 告诉我们：只要 `a` 是 `Ord` 的 instance，那么 `[a]` 也会是 `Ord` 的 instance。



## The type `Ordering` and the typeclass `Ord`

Type class `Ord` 实现的是这样一个想法：某个 type 的 elements 不仅可以比较是否相等(满足Eq)，还可以比较 **less than / greater than**。
在 type `a` 上进行比较，可以看作一个 map：`compare : a -> a -> Ordering`，其中 type `Ordering` 定义如下：
```hs
data  Ordering  =  LT | EQ | GT
          deriving (Eq, Ord, Enum, Read, Show, Bounded)
```
这里，`LT` 表示 *less than*，`EQ` 表示 *equal*，`GT` 表示 *greater than*。

下面这段代码定义了 `Ord` class，适用于那些已经在 `Eq` class 里的 types `a`：
```hs
class  (Eq a) => Ord a  where
    compare              :: a -> a -> Ordering
    (<), (<=), (>=), (>) :: a -> a -> Bool
    max, min             :: a -> a -> a

        -- Minimal complete definition:
        --      (<=) or compare
        -- Using compare can be more efficient for complex types.
    compare x y
         | x == y    =  EQ
         | x <= y    =  LT
         | otherwise =  GT

    x <= y           =  compare x y /= GT
    x <  y           =  compare x y == LT
    x >= y           =  compare x y /= LT
    x >  y           =  compare x y == GT

-- note that (min x y, max x y) = (x,y) or (y,x)
    max x y
         | x <= y    =  y
         | otherwise =  x
    min x y
         | x <= y    =  x
         | otherwise =  y
```

`Ordering` 和 `Ord` 的 definition 之间看起来有一点 circularity，也就是它们互相引用了对方。我们可以把它理解成 mutually recursive definition。


比如，对 `a` 上的 lists 使用 `compare` function，也就是当 `a` 已经有一个 `compare` function 时，list 的比较可以这样实现：
```hs
instance (Ord a) => Ord [a] where
  compare [] []         = EQ
  compare [] (_:_)      = LT
  compare (_:_) []      = GT
  compare (x:xs) (y:ys) = case compare x y of
                              EQ    -> compare xs ys
                              other -> other
```

----

**Exercises**

1. 通过阅读代码，解释两个 lists 是怎么被比较的。
2. 运行一些 list comparisons 的 examples，来确认或反驳你的解释。

这个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=a6abe9f7-b812-4af3-91b7-ac4200b9b26c) 解释了 `compare :: [a] -> [a] -> Ordering` 的 implementation。

----



## The type class `Num`

考虑下面这些 examples：
```hs
ghci> 5 + 3
8
ghci> 3.14159 + 2.71828
5.85987
```
这里，operator `+` 可以作用在任何属于 `Num` typeclass 的 type 上。对于任何这样的 type `a`，function `(+)` 的 type 是 `a -> a -> a`，并且它以 infix operator 的形式使用。

我们可以用 `:info` command 来查看 `Num` typeclass 提供了哪些 operations：

```hs
ghci> :info Num
class Num a where
  (+) :: a -> a -> a
  (-) :: a -> a -> a
  (*) :: a -> a -> a
  negate :: a -> a
  abs :: a -> a
  signum :: a -> a
  fromInteger :: Integer -> a
  {-# MINIMAL (+), (*), abs, signum, fromInteger, (negate | (-)) #-}
  	-- Defined in ‘GHC.Num’
instance Num Word -- Defined in ‘GHC.Num’
instance Num Integer -- Defined in ‘GHC.Num’
instance Num Int -- Defined in ‘GHC.Num’
instance Num Float -- Defined in ‘GHC.Float’
instance Num Double -- Defined in ‘GHC.Float’
```
这说明：任何 type `a`，只要它是 `Num` 的 instance，就会带有 operations `(+)`、`(-)`、`(*)`、`fromInteger` 等等。
特别注意：没有 type annotation 的 `1` 并不是固定意义上的 integer，而是任何 type `a` 的 element，只要 `a` 是 `Num` 的 instance。更具体地说，`1` 是 integer `1 :: Integer` 在 function `fromInteger :: Integer -> a` 下的 image。

我们也看到 type class `Num` 已经定义了五个 **instances**，分别是 `Word`、`Integer`、`Int`、`Float` 和 `Double`。
当我们想把 `1` 看成某个特定 numeric type 的 element 时，可以通过 **annotating** 它的 type 来做到，比如：
```hs
ghci> :type 1 :: Word
1 :: Word :: Word
```
这里，我们是在 **check** `1 :: Word`，而不是让 `ghci` 帮我们 **infer** `1` 的 type。`ghci` 只需要检查 `Word` 是不是 `Num` 的 instance。
类似地，对于 `(+)`，我们也可以检查：
```
ghci> :type (+) :: Integer -> Integer -> Integer
(+) :: Integer -> Integer -> Integer
  :: Integer -> Integer -> Integer
```
如果某个 type 没有被声明为 `Num` 的 instance，这个 check 就会失败，比如 `Char`：
```hs
ghci> :type (+) :: Char -> Char -> Char

<interactive>:1:1: error:
    • No instance for (Num Char) arising from a use of ‘+’
    • In the expression: (+) :: Char -> Char -> Char
```

## See also

3. A blog post comparing Java and Haskell: https://mmhaskell.com/blog/2019/1/28/why-haskell-iv-typeclasses-vs-inheritance. Do you agree with it? Why (not)?

## Summary

1. 我们详细学习了一个 function，它同时使用了 pattern matching on lists 和 `case` expression，而 `case` expression 是更一般的 pattern matching 形式。
1. 我们看到了 instances 如何通过其他 instances 自动 derived 出来，例子是 `instance Ord a => Ord [a]`。
1. 我们看了用于 number types 的 type class `Num`。
1. 我们看到了如何使用 type annotation 来强制一个 Haskell expression 具有某个特定 type，比如 `1 :: Word`。
