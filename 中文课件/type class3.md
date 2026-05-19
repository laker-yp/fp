# Type classes in more detail

## Some Haskell options we will use in this file

我们会使用下面这个 Haskell option，让我们在定义东西的时候有更大的 flexibility：

```haskell
{-# Language FlexibleInstances #-}
```

我们也会使用下面这个 option：
```haskell
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
```
它的作用是让 `ghc` 在我们用 pattern matching 定义东西但 patterns 不够完整时，给出 warning。

## Motivation

考虑下面在 `ghci` command prompt 里的 interaction：
```hs
ghci> "abcd" == "ab" ++ "cd"
True
ghci> "abcd" == reverse ("ab" ++ "cd")
False
ghci>
```
很好。我们成功比较了一些 strings 是否 equality。

但现在考虑下面这段 Haskell code：
```haskell
f1, f2, f3 :: Bool -> Bool
f1 x = if x then False else True
f2 x = not x
f3 x = x
```
然后试着在 `ghci` prompt 里看看这两个 functions 是否相等：
```hs
ghci> f1 == f2

<interactive>:14:1: error:
```
为什么会得到 error？因为 Haskell 不知道怎么比较 functions 是否相等。在这个具体例子里，我们很容易*看出*这两个 functions 是相等的。但是从 Computability Theory 里我们知道，很遗憾，一般情况下，并不存在一个 algorithm 可以判断任意两个给定 functions 是否相等。

不过 Haskell 给我们的 error message 看起来会更 cryptic：
```hs
   • No instance for (Eq (Bool -> Bool)) arising from a use of ‘==’
        (maybe you haven't applied a function to enough arguments?)
    • In the expression: f1 == f2
      In an equation for ‘it’: it = f1 == f2
```
这是什么意思？意思是：对于 function type `Bool -> Bool`，并没有定义 equality function `==`。

对于这个特殊 type `Bool -> Bool`，比较 functions 是否 equality 其实很简单，我们可以自己实现：
```hs
instance Eq (Bool -> Bool) where
  f == g = f True == g True && f False == g False
```
现在我们就可以在 `ghci` prompt 里成功比较 functions `f1, f2, f3` 是否相等：
```hs
> f1 == f2
True
> f1 == f3
False
```
我们还可以做得更好，也就是写得更 general：
```haskell
instance Eq a => Eq (Bool -> a) where
  f == g = f True == g True && f False == g False
```

用 English 来说，它的意思是：

 * 如果我们知道怎么比较 type `a` 的 elements 是否 equality，
 * 那么我们也可以用 algorithm `f True == g True && f False == g False` 来比较 functions `f,g :: Bool -> a` 是否 equality。


## Self-contained example

下面这段 Haskell code 是 self-contained 的，而且故意不使用任何 Haskell library，甚至连 prelude 都不用，这样我们就能完整清楚地看到：

 * type classes 是什么，
 * 它们有什么用，
 * 以及它们是怎么被使用的。

## Example 1

我们现在从零开始定义自己的 equality class。

我们只在 definition 里包含一个 equality function，写作 `===`：

```haskell
class MyEq a where
  (===) :: a -> a -> Bool
```
我们为一些 types 实现这个 equality。先从 Booleans 开始：
```haskell
instance MyEq Bool where
  False === False = True
  True  === True  = True
  _     === _     = False
```
现在看 pairs。这里不同的是：假设我们已经在 types `a` 和 `b` 上有 equality，那么我们就可以为 pair type `(a,b)` 定义 equality：
```haskell

instance (MyEq a , MyEq b) => MyEq (a , b) where
  (x , y) === (u , v) = x === u && y === v
```
类似地，如果我们在 type `a` 里有 equality，那么就可以在由 type `a` 的 elements 组成的 list type `[a]` 里定义 equality：
```haskell
instance MyEq a => MyEq [a] where
  []     === []     = True
  (x:xs) === (y:ys) = x === y && xs === ys
  _      === _      = False

instance MyEq a => MyEq (Bool -> a) where
  f === g = f True === g True && f False === g False
```
下面是一些使用上面 definitions 的 function examples：
```haskell
allEqual :: MyEq a => [a] -> Bool
allEqual []       = True
allEqual (x:[])   = True
allEqual (x:y:zs) = x === y && allEqual (y:zs)

someDifferent :: MyEq a => [a] -> Bool
someDifferent []       = False
someDifferent (x:[])   = False
someDifferent (x:y:zs) = not (x === y) || someDifferent (y:zs)
```

你可以自己说服自己：对于所有 lists `xs :: [a]`，`allEqual xs === not (someDifferent xs)` 都是 `True`。之后在这个 module 里，我们会讨论 induction on lists，并且能严格证明这个结论。

## Example 2

我们现在说明 default methods：
```haskell
class YourEq a where
  (====) :: a -> a -> Bool      -- (1)
  (=//=) :: a -> a -> Bool      -- (2)

  a ==== b = not (a =//= b)     -- Default definition of (1) using (2)
  a =//= b = not (a ==== b)     -- Default definition of (2) using (1)
```
最后两行是 *default* definitions：

 * 如果我们定义了 (1)，那么就不需要定义 (2)。
 * 如果我们定义了 (2)，那么就不需要定义 (1)。
 * 但如果愿意，也可以两个都定义。


下面是一些 examples：

* 只定义 (1)：

```haskell
instance YourEq Bool where
  False ==== False = True
  True  ==== True  = True
  _     ==== _     = False
```
* 我们只定义 (2)：
```haskell
instance (YourEq a , YourEq b) => YourEq (a , b) where
  (x , y) =//= (u , v) = x =//= u || y =//= v
```
* 我们只定义 (1)：
```haskell
instance YourEq a => YourEq [a] where
  []     ==== []     = True
  (x:xs) ==== (y:ys) = x ==== y && xs ==== ys
  _      ==== _      = False
```
我们同时定义 (1) 和 (2)：
```haskell
instance YourEq a => YourEq (Bool -> a) where

  f ==== g = f True ==== g True && f False ==== g False

  f =//= g = f True =//= g True || f False =//= g False
```

## Example - adding `Bool` to the type class `Num`

考虑下面这个 example：
```hs
ghci> True + 0

<interactive>:1:6: error: [GHC-39999]
    • No instance for ‘Num Bool’ arising from a use of ‘+’
    • In the expression: True + 0
      In an equation for ‘it’: it = True + 0
```

这句话的意思是：`True + 0` 需要 type `Bool` 属于 type class `Num`，但它并不属于。不过如果我们愿意，也可以把 `Bool` 加入 type class `Num`，如下：
```haskell
instance Num Bool where

  False + y  = y
  True  + y = not y

  (*)    = (&&)
  negate = id
  abs    = id
  signum = id

  fromInteger 0 = False
  fromInteger _ = True
```
这里我们是在说：addition 是 `exclusive or`，multiplication 是 `and`，而 boolean 的 negative 就是它自己。
注意，我们像 programming language `C` 那样，把 booleans 编码成 integers。
这些 operations 构成所谓的 [Boolean ring](https://en.wikipedia.org/wiki/Boolean_ring)。我们可以像下面这样检查 Boolean ring equations：
```haskell
bools = [False,True]

testPlusAssoc = and [ (x + y) + z == x + (y + z)   | x <- bools, y <- bools, z <-bools]
testMulAssoc  = and [ (x * y) * z == x * (y * z)   | x <- bools, y <- bools, z <-bools]
testPlusComm  = and [ x + y == y + x               | x <- bools, y <- bools]
testMulComm   = and [ x * y == y * x               | x <- bools, y <- bools]
testNeg       = and [ x + (- x) == 0               | x <- bools]
testBoolean   = and [ x * x == x                   | x <- bools]
test0         = and [ x + 0 == x                   | x <- bools]
test1         = and [ x * 1 == x                   | x <- bools]
testDistrL    = and [ a * (x + y) == a * x + a * y | a <- bools, x <- bools, y <- bools]
testDistrR    = and [ (x + y) * a == x * a + y * a | a <- bools, x <- bools, y <- bools]
```
Operations `abs` 和 `signum` 不是 Boolean ring definition 的一部分，但它们需要满足下面这个 equation：
```haskell
testSignum    = and [ abs x * signum x == x        | x <- bools]
```
我们可以像下面这样测试全部内容：
```haskell
testAll = and [testPlusAssoc, testMulAssoc, testPlusComm, testMulComm,
               testNeg, testBoolean, test0, test1 , testDistrL , testDistrR ,
               testSignum]
```
这个 expression evaluate 成 `True`，说明上面的 equations 都成立。
```hs
ghci> testAll
True
```
现在当我们执行 `True + 0` 时，就不会再得到 error 了。这个 expression 会 evaluate 成 `True`：
```hs
ghci> True + 0
True
```
