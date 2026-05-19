# More on type classes and instances
目录：

1. Type class `Ord`，用于 ordered types。
2. Type class `Num`，用于 numeric types。

我们也会学习一个 *instance declaration with constraints* 的例子：`instance Ord a => Ord [a]`。
这个 instance 告诉我们：只要 `a` 是 `Ord` 的 instance，那么 `[a]` 也会是 `Ord` 的 instance。


## The type `Ordering` and the typeclass `Ord`

Type class `Ord` 实现的是这样一个想法：

某个 type 的 elements 不仅可以比较是否相等(满足Eq)，还可以比较 **less than / greater than**。

目标是让Int，Char，Bool...都属于type class 【Ord】的instance，然后就可以进行下面的operation了
3 < 5---
'a' < 'z'---
True > False

在 type `a` 上进行比较，可以看作一个 map：`compare : a -> a -> Ordering`，其中 type `Ordering` 定义如下：
```hs
data  Ordering  =  LT | EQ | GT
          deriving (Eq, Ord, Enum, Read, Show, Bounded)
```
这里，`LT` 表示 *less than*，`EQ` 表示 *equal*，`GT` 表示 *greater than*。

下面的的代码是用于定义type class的，具体来说是 `Ord` 这个type class
```hs
class  (Eq a) => Ord a  where   --types `a`继承 `Eq` 这个type class

下面三段是在规定 Ord 里面有哪些【functions】，意思是如果类型a是Ord，那么应该支持下面这三个【operation】
1    compare              :: a -> a -> Ordering
2    (<), (<=), (>=), (>) :: a -> a -> Bool
3    max, min             :: a -> a -> a

        如果你要让一个自定义 type 成为 Ord，你不用把所有 functions 都写出来。
        至少定义 <= 或者 compare 其中一个就好了，其他Haskell可以自己推出来

定义Ord支持的operation【1】
    compare x y
         | x == y    =  EQ
         | x <= y    =  LT
         | otherwise =  GT

定义Ord支持的operation【2】
    x <= y           =  compare x y /= GT  【如果x跟y比，不是GT，那就说明x没有大于y，也就是x <= y】
    x <  y           =  compare x y == LT  
    x >= y           =  compare x y /= LT
    x >  y           =  compare x y == GT

定义Ord支持的operation【3】
-- note that (min x y, max x y) = (x,y) or (y,x)
    max x y
         | x <= y    =  y
         | otherwise =  x
    min x y
         | x <= y    =  x
         | otherwise =  y
```

`Ordering` 和 `Ord` 的 definition 之间看起来有一点 circularity，也就是它们互相引用了对方。我们可以把它理解成 mutually recursive definition。

Ordering 作为一个 data type，先被定义出来=>
然后 Ord 使用这个 type 作为返回值=>
再然后 Ordering 可以被声明成 Ord 的一个 instance。


对 `a` 上的 lists 使用 `compare` function

前提：`a` 已经满足了Ord,所以能使用 `compare` function了时

那么list 的比较可以这样实现：
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
  (*) :: a -> a -> a  --这些是支持的operation
  negate :: a -> a
  abs :: a -> a
。。。
instance Num Word 
instance Num Integer 
instance Num Int 
instance Num Float
。。。
```
这说明：任何 type `a`，只要它是 `Num` 的 instance，就会支持`(+)`、`(-)`、`(*)` 等等operations

1 如果没有写死是哪个type，就不一定是 Integer

它可以是任何“Num”类型类里的 1，前提是那个 type 属于 Num，如Int,Float..

更直白地说：

1 本质上先是一个 Integer 里的整数 1，然后 Haskell 会通过 fromInteger 把它转换成你需要的数字类型，比如 Int、Float、Double 等。

也就是说，1 可以根据场景变成不同 numeric type 里的 1。
```hs
ghci> :t 1 :: Word 【这里的“1 :: Word”将1的类型变成Word】
1 :: Word :: Word
```
这里，我们是在 **check** `1 :: Word`！而不是让 `ghci` 帮我们 **infer** `1` 的 type

类似地，对于 `(+)`，我们也可以检查：
```
ghci> :type (+) :: Int -> Int -> Int
(+) :: Int -> Int -> Int :: Int -> Int -> Int
```
如果某个 type 没有被声明为 `Num` 的 instance，这个 check 就会失败，比如 `Char`：
```hs
ghci> :type (+) :: Char -> Char -> Char

<interactive>:1:1: error:
   
```

## See also
Haskell 的 type class 确实有点像 Java 的 interface，因为它们都规定“某个东西必须支持哪些操作”

但是它不像 Java 的 inheritance 那样强调继承代码

Haskell 的 type class 更像是在说：“这个 type 有某种能力。”
## Summary

1. 我们详细学习了一个 function，它同时使用了 pattern matching on lists 和 `case` expression，而 `case` expression 是更一般的 pattern matching 形式。
1. 我们看到了 instances 如何通过其他 instances 自动 derived 出来，例子是 `instance Ord a => Ord [a]`这里a能比大小那么[a]也能
1. 我们看了用于 number types 的 type class `Num`。
1. 我们看到了如何使用 type annotation 来强制一个 Haskell expression 具有某个特定 type，比如 `1 :: Word`。
