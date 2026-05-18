# Polymorphism

## Introduction

有些 functions 可以作用在不同 types 的 elements 上，而且不依赖这些 elements 具体长什么样。这就叫 **polymorphism**。
这个主题在 Canvas 上的 [video "Polymorphism - Introduction"](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=68f0b311-947c-40b0-9dc4-adab008c597d) 里有介绍。

## Example: the type family of lists
我们来看一下 lists 这个 datatype。我们在课本 Section 3.3 里已经见过，lists 里面可以装不同 types 的 elements：
```
ghci> :t ['a', 'b', 'c']   -- a list of characters
['a', 'b', 'c'] :: [Char]

ghci> :t [False, True, True, True]   -- a list of Booleans
[False, True, True, True] :: [Bool]

ghci> :t ["foo", "bar"]   -- a list of lists of characters, aka, a list of strings
["foo", "bar"] :: [[Char]]
```
对于任意 type `a`，我们都可以构造出 type `[a]`。它的 elements 就是由 type `a` 的 elements 组成的 lists。

## How to build lists

创建一个 list 有两种方式：

1. empty list 本身就是一个 list，写作 `[]`。

2. 对于一个已有的 list `xs`，我们可以在它前面加上一个 element `x`，写作 `x:xs`。


### The empty list

首先，对于任意 type `a`，都存在一个由 `a` 的 elements 组成的 empty list：
```
ghci> :t []
[] :: [a]
```
这里 `[] :: [a]` 里面的 `a` 是一个 **type variable**，也就是类型变量，它可以被替换成任意 type。比如说，`a` 可以被设成 `Integer`，也就是 GHC 里 integer numbers 的 type：
```
ghci> :t [] :: [Integer]
[] :: [Integer] :: [Integer]
```
在这个例子里，我们没有用 type _inference_，而是用了 type _checking_：我们先向 `ghci` 建议 `[]` 应该具有 type `[Integer]`，然后让 `ghci` 帮我们确认，结果它确实确认了。
类似地，`ghci` 也可以确认 `[]` 具有 type `[Char]`：
```
ghci> :t [] :: [Char]
[] :: [Char] :: [Char]
```
或者：
```
ghci> :t [] :: [[Char]]
[] :: [[Char]] :: [[Char]]
```
甚至也可以是：
```
ghci> :t [] :: [[[[[[[Char]]]]]]]
[] :: [[[[[[[Char]]]]]]] :: [[[[[[[Char]]]]]]]
```
----

**Exercise**

对于这些 examples，变量 `a` 分别被 instantiated 成了什么 type？

----
**Explanation:** Watch the [video "Polymorphism: empty list  []"](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=2c0c0300-4ccf-42c3-95c1-adab008c57ca) on Canvas.

----

### Adding an element to a list

我们也可以从一个更小的 list 构造出一个新的 list，方法是在开头加一个新的 element：
```
ghci> :t (:)
(:) :: a -> [a] -> [a]
```
注意，`:` 是一个 **infix** operator。意思是它用在两个 arguments **中间**，有点像加法里的 `+`：
```
ghci> :t False:[True, False]
False:[True, False] :: [Bool]
```
我们可以 evaluate expression `False:[True, False]`：
```
ghci> False:[True, False]
[False,True,False]
```

在 expression `x:xs` 里，如果 `x :: a`，`xs :: [a]`，那么这里的 **type `a` 必须是同一个 type**。
如果不是同一个 type，就会出现下面这种 failure：
```hs
ghci> 'a':[True, False]

<interactive>:11:6: error:
    • Couldn't match expected type ‘Char’ with actual type ‘Bool’
    • In the expression: True
      In the second argument of ‘(:)’, namely ‘[True, False]’
      In the expression: 'a' : [True, False]

<interactive>:11:12: error:
    • Couldn't match expected type ‘Char’ with actual type ‘Bool’
    • In the expression: False
      In the second argument of ‘(:)’, namely ‘[True, False]’
      In the expression: 'a' : [True, False]
```

----

**Exercise**

阅读上面 example 里的 error message，然后用你自己的话解释它是什么意思。

----
**Explanation:** Watch the [video "Polymorphism: consing (:)"](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=d9295418-77e6-4c5b-96d2-adab008c5855) on Canvas.

----

## Polymorphism

如果一个 function 的 type 里面包含一个或多个 type variables，那么这个 function 就是 [**polymorphic**](https://en.wikipedia.org/wiki/Polymorphism_(computer_science) "Wikipedia entry on Polymorphism") 的。
Functions `[]` 和 `(:)` 就是 polymorphic functions 的例子。

下面是一个 type 里面包含 **两个** type variables 的 function：
```hs
ghci> :t zip
zip :: [a] -> [b] -> [(a, b)]
```

## Exercises

1. 用你自己的话解释 function `zip` 是做什么的。在 expression `zip ['x', 'y'] [False]` 里，`zip :: [a] -> [b] -> [(a, b)]` 中的 type variables `a` 和 `b` 分别被 instantiated 成了什么？

2. 找出下面这些 functions 的 types。判断它们是不是 polymorphic。
    1. `fst`
    2. `(++)`
    3. `not`
    4. `head`
    5. `tail`
    6. `id`

3. 在 GHC standard library 里找一个 type 包含 3 个或更多 type variables 的 polymorphic function。

4. 阅读 Programming in Haskell 的 Section 3.7。把里面 examples 的 types 和 `ghci` 显示出来的 types 进行比较。（注意：`ghci` 显示的一些 types 会用到 "type classes"，这个会在下一节课里学。）

## Summary

1. 一个 **polymorphic** function，就是 type 里面包含 **type variables** 的 function。这些 type variables 通常叫做 `a`、`b` 等等。

2. 当我们把一个 polymorphic function 应用到某个 input 上时，type variables 会被合适地 **instantiated**。比如说，对于 `(++) : [a] -> [a] -> [a]`，如果它被应用到 `[True, False]` 和 `[False, False]` 上，那么 Haskell 就会把 `a` instantiated 成 `Bool`。
