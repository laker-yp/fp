# Polymorphism

## Introduction

一个 function / expression 的 type 不是固定死的，而是可以适用于多种 type。

## Example: the type family of lists
lists 里面可以装不同 types 的 elements：
```
ghci> :t ['a', 'b', 'c']   --char的list
['a', 'b', 'c'] :: [Char]

ghci> :t ["foo", "bar"]   -- list的list, 也叫 a list of strings
["foo", "bar"] :: [[Char]]
```
不管你给我什么类型a，都可以造出“装这个类型的列表”[a]。

## How to build lists

创建一个 list 有两种方式：

1. 空列表 `[]`。

2. 在已有的列表xs前面加上一个 element `x`，写作 `x:xs`。


### The empty list

任意 type `a`，都存在一个由 `a` 的 elements 组成的 empty list：
```
ghci> :t []
[] :: [a]
```
这里 `[] :: [a]` 里面的 `a` 是类型变量，
它可以被替换成任意 type。

比如说，`a` 被赋予类型 `Integer`
```
ghci> :t [] :: [Integer]
[] :: [Integer] :: [Integer]
```
这里直接type _checking没有type _inference

向 `ghci` 建议 `[]` 被我们赋予type是`[Integer]`，然后让 `ghci` 帮我们确认

例
```
ghci> :t [] :: [[Char]] --将[char]作为列表的元素
[] :: [[Char]] :: [[Char]]
```

**Exercise**


### Adding an element to a list

在list开头加一个新的 element：
```
ghci> :t (:)
(:) :: a -> [a] -> [a]
```
注意，`:` 是一个 **infix** operator。意思是它用在两个 arguments **中间**
```
ghci> :t 'a':['b', 'c']
'a':['b', 'c'] :: [char]
```

 `x:xs` 必须是同一个 type**。

 错误示范
```hs
ghci> 'a':[True, False]
```
----

## Polymorphism

如果一个 function 的 type 里面包含一个或多个 type variables，那么这个 function 就是 [**polymorphic**]
Functions `[]` 和 `(:)` 就是 polymorphic functions 的例子。


下面是一个 type 里面包含 **两个** type variables 的 function：
```hs
ghci> :t zip
zip :: [a] -> [b] -> [(a, b)]--这里a和b可以为两个不同的任意type
```
zip [1, 2, 3] ['a', 'b', 'c']

输出

[(1,'a'), (2,'b'), (3,'c')]
## Exercises


## Summary

1. 一个 **polymorphic** function，就是 type 里面包含 **type variables** 的 function。这些 type variables 通常叫做 `a`、`b` 等等。

2. 当我们把一个 polymorphic function 应用到某个 input 上时，type variables 会被合适地 **instantiated**。比如说，对于 `(++) : [a] -> [a] -> [a]`，如果它被应用到 `[True, False]` 和 `[False, False]` 上，那么 Haskell 就会把 `a` instantiated 成 `Bool`。
