# Type classes and instances

## Introduction

我们经常想检查 Haskell 里的两个 values 是否相等。

我们只想比较两个**相同 type** 的 values 是否相等。
if问一个 Bool 是否等于一个 char，这本身没有什么意义。

所以我们可能会想写一个 **polymorphic function**：
```hs
(==) : a -> a -> Bool
```
但是，并不是对任意给定 type 的两个 values，我们都能判断它们是否相等。

**Exercise:** 找一个 type `a`，它的 values 不能用 Boolean function `a -> a -> Bool` 来比较 equality。

比如a = Int -> Int中，a是一个function，即使两个f为同类型他们也无法比较

## 这个问题的解决方案就是 **type classes**：

*. **type class** 是一个 interface

   规定某些 types 必须支持哪些 operations。

   例如：**Eq** 规定一个 type 如果属于 Eq，就应该支持：

   (==)
   (/=)这两个operation
   

*. type class 的 **instance**，就是某个已经实现了这些 operations 的 type

   比如**Int**就是一个instance，这个具体的type已经实现了type class中支持的operation（==）（!=）

   在 Haskell 里，operation `(==)` 有下面这个 type：
```hs
ghci> :type (==)
(==) :: Eq a => a -> a -> Bool
```
这里：

1. `Eq` 是一个 **type class**。

1. 对任意 type `a`，如果它是 type class `Eq` 的一个 **instance**，
   
   那么 `(==)` 就可以接收两个 a 类型的值，并返回一个 Bool

1. `Eq a => a -> a -> Bool` 里的 `Eq a` 是一个 **class constraint**。
   Eq a => a表示对a赋予constraint，这个type为Eq的一个instance

----
[not] == [ (id :: Bool -> Bool) ]
 因为用了（==）
Haskell 会理解成：它应该去找 `Eq 里面[Bool -> Bool]` 这个 instance。
发现有一个instance：`Eq a => Eq [a]`，
所以 Haskell 会继续去找 `Eq (Bool -> Bool)` 这个 instance。
可惜这个 instance 不存在。

2. 用你自己的话解释，为什么 `(++)` 不需要任何 class constraints，但是 `(==)` 需要。
   
(++) 只操作 list 结构，不关心里面的 a 是什么；

(==) 要操作 value 的 equality，所以必须要求 a 支持 equality，也就是：Eq a =>

----

## The type class `Eq`

**Video:** See [here](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=02d9fdae-ae5f-4d3e-bf5e-ac3d0165178a)。

我们可以用下面这种方式获得关于 type class `Eq` 的信息。为了更容易阅读，下面删掉了一些文字：
```hs
ghci> :info Eq
class Eq a where
  (==) :: a -> a -> Bool --这两行告诉你Type class Eq 提供两个 functions：(==) 和 (/=)
  (/=) :: a -> a -> Bool --如果想在某个 type `a` 上实现这个 type class，那么至少要实现 `(==) 或 `(/=)`其中一个
。。。
instance (Eq a, Eq b) => Eq (Either a b)
。。。
instance Eq a => Eq [a] 
instance Eq Word --很多 `Eq` 的 instances 已经被实现好了，比如 `Word`、`Ordering` 等等
instance Eq Ordering 
instance Eq Int 
。。。
instance (Eq a, Eq b, Eq c) => Eq (a, b, c)

instance (Eq a, Eq b) => Eq (a, b) --如果 types `a` 和 `b` 是 instances，那么由 `a` 和 `b` 里的组成的 pair也是instance
同理果 `a` 是 `Eq` 的 instance，那么由 `a` 的 values 组成的 list type `[a]` 也是 `Eq` 的 instance
```
tips：当 user 在实现 instance 时，只提供 `(==)` 和 `(/=)` 其中一个，另一个会自动被定义成它的 **negation**，比如：
   `x /= y = not (x == y)`。

## Summary: type classes and instances

* 对于任何给定的 `data` type 或者 `newtype`，同一个 class 只能声明**一个** instance

* 在 function type 里，`=>` 前面的所有东西都是 **class constraint**：这个 function 只对那些是所提到 classes 的 instances 的 types 可用。

##继承: Extending a type class
type class 也可以 extend 一个 type class。
考虑下面这个例子：
```hs
ghci> :i Ord
class Eq a => Ord a where
...
```
Ord 这个 type class 继承Eq

如果一个 type 想成为 Ord 的 instance，它必须先是 Eq 的 instance。

## Exercises

1. 另一个 type class：

    1. 哪个 type class 定义了 function `enumFromTo`？
       答案是：

        Enum

        GHCi 里：

        :t enumFromTo

        会看到：enumFromTo :: Enum a => a -> a -> [a]

        意思是：只要 a 是 Enum 的 instance，就可以从一个值枚举到另一个值。

 enumFromTo 4 8
 
 [4,5,6,7,8]

    1. 解释 `:type enumFromTo 4 8` 和 `:type enumFromTo 4 (8 :: Int)` 的输出为什么不同
    
    因为第一个没有指定具体数字类型，所以 Haskell 保持 polymorphic；
    第二个明确指定了 Int，所以结果固定成 [Int]。

1. 为什么 Haskell 对于一个给定 type，只允许它拥有某个 type class 的**一个** instance？
   
   因为 Haskell 需要保证：

    instance resolution 是确定的。
## 12. 最终总结

1. **Type class** 是一组 operations 的 interface。

2. **Instance** 是某个具体 type 对这些 operations 的实现。

3. `Eq a =>` 是 **class constraint**，表示 `a` 必须是 `Eq` 的 instance。

4. `(++)` 不需要 constraint，因为它只拼接 list structure。

5. `(==)` 需要 `Eq a`，因为它必须比较 values 是否相等。

6. `Eq` 提供 `(==)` 和 `(/=)`。

7. 如果 `a` 是 `Eq` 的 instance，那么 `[a]` 也是 `Eq` 的 instance。

8. 如果 `a` 和 `b` 都是 `Eq` 的 instances，那么 `(a, b)` 也是 `Eq` 的 instance。

9. `Ord` extends `Eq`，因为能比较大小的 type 也应该能比较相等。

10. `Enum` 定义了 `enumFromTo`。

11. Haskell 对同一个 type 和 type class 只允许一个 instance，是为了保证 instance resolution 不产生歧义。

