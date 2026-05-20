# Types in Programming, types in Haskell



## Why are types useful?

在 programming languages 里，types 的作用就是**不允许**某些不合理的程序出现。
保证：我们传给一个 function 的 arguments，必须是这个 function 原本设计好能处理的那种东西。

Types 可以让我们在 compile time 就发现这种错误


### Type inference

合理的expression 都有一个 type，而且我们可以让 `ghci` 告诉我们这个 type。这就叫 **type inference**：
```hs
ghci> :type False  --False为expression
False :: Bool

ghci> :type True
True :: Bool
```
expression "False" 的 type 是 "Bool"

 `::` 可以读作 "has type"，比如 "False has type Bool"。

在 Haskell 里，我们也有 **function types**：
```hs
ghci> :type not  --not是一个function，有输入有输出
not :: Bool -> Bool
```

Haskell 调用函数不需要括号，也不需要逗号，直接把 function 和 argument 放在一起

```hs
ghci> :type not False  --在这里not是function，Falase是argument
not False :: Bool
```

### Type checking

我们可以让 `ghci` **confirm** 某个 expression 是否具有某个给定的 type：

```hs
--输入中“False :: Bool”的意思是给定Bool这个type于False这个expression
前面加上type用于检查是否具有某个给定的 type
ghci> :type False :: Bool  --
False :: Bool :: Bool

```
这就叫 **type checking**。

----

**type checking vs type inference**

在写 Haskell 程序的时候，更安全的做法是：
先告诉 Haskell，我们希望某个 expression 是什么 type（如4::Int），
然后让 Haskell 帮我们确认这个 type 是不是对的。（如:type 4::Int）
这样比让 Haskell 自己去推断functions 的 type 更稳。
一个好的 programmer 通常会先写下自己要构造的 function 的 type，然后再开始写 function 本身。

----

**Exercise**

用 `ghci` 找出下面这些 expressions 的 type：即用:t加上下列式子

1. `not (not (not False))`

1. `(True,False)` 输出(True,False) :: (Bool, Bool)

1. `['a', 'b', 'x']` 输出['a', 'b', 'x'] :: [Char]

1. `(++)`

用 `:t` 代替 `:type`。


----

## Type inference before evaluation

if True then 1 else "foo"

按理来说虽然1和foo不是一个type，但是if True根本看不到后面的foo，这样会报错吗？

明显永远返回 1 啊，为什么还管 "foo"？

原因是：Haskell 的 type checking 是在 evaluation 之前完成的。

也就是说，它不是边运行边检查，而是先整体检查。

----
**Exercise**

写几个ill-typed expressions

not 3

1 + True

"hello" && False

----

## Well-typed programs can fail

不是每一个 valid，也就是 well-typed 的 Haskell expression，都一定能顺利 evaluate 而不报错：
```hs
ghci> :t (!!)     --!!用于取出list的index为n的元素
(!!) :: [a] -> Int -> a

ghci> :t ["foo", "bar"] !! 5  --根本没有第五个index
["foo", "bar"] !! 5 :: [Char]  --但是type不管这些，只管符不符合type

ghci> ["foo", "bar"] !! 5
"*** 直接报错
```

----

**Exercise**

查看 [online documentation of Hackage: The Haskell Package Repository](https://hackage.haskell.org/)，找出 function `(!!)` 是做什么的。

Hint: 你可以在 [这里](https://hackage.haskell.org/package/base-4.14.0.0/docs/Data-List.html) 找到 list library 的 documentation。

----

## Tour of Haskell types

在这一节里，我们会看一些 Haskell types，包括 base types 和 composite types。
这一节配套的视频在 [这里](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=27d77c3a-fca7-4142-bda9-adab008c5cf4)。

### Base types

Haskell 的 base types：

1. `Bool`

1. `Char` 

1. `Int` -固定上限下限

1. `Integer` -无上下限

1. `Float` 

1. `Double` - 和 floats 类似，但是 precision 更高

```hs

ghci> :type "foo"
"foo" :: [Char]

ghci> :type 2 :: Int
2 :: Int :: Int

ghci> :type (sqrt 2)
(sqrt 2) :: Floating a => a

ghci> :type (sqrt 2) :: Float
(sqrt 2) :: Float :: Float

ghci> sqrt 2 :: Float
1.4142135

ghci> sqrt 2 :: Double
1.4142135623730951
```

### Composite types组合类型

我们可以用简单的 types 组合出更复杂的 types：

1. 如果 `a` 是一个 type，那么 `[a]` 就是由 `a` 里面的 values 组成的 list 的 type。

1. 如果 `a` 和 `b` 是 types，那么 `(a,b)` 就是 pair 的 type

1. 如果 `a` 和 `b` 是 types，那么 `a -> b` 就是从 `a` 到 `b` 的 functions 的 type。

```hs

ghci> :type []     -- Polymorphic function
。。。[a]

ghci> :type [['a', 'b'], ['c']]
。。。 [[Char]]

ghci> :type "How are you?"
。。。[Char]

ghci> :type (False, 'c')
。。。 (Bool, Char)

```

## Curried functions


```haskell

add :: (Integer, Integer) -> Integer
add (x,y) = x + y
```
一个 function 也可以 return 一个 function
↓
```haskell
add' :: Integer -> (Integer -> Integer)
add' x y = x + y
```
**Notes:**

1. `Integer -> (Integer -> Integer)`

可以直接写成 `Integer -> Integer -> Integer`。

1.`add' x y` 实际上的意思是 `(add' x) y`

这个原理可以推广到有两个以上 arguments 的 functions：
```haskell
add3 :: Integer -> Integer -> Integer -> Integer
add3 x y z = x + y + z
```
实际上等于add3 :: Integer -> (Integer -> (Integer -> Integer))
```
add3       :: Integer -> (Integer -> (Integer -> Integer))
add3 x     :: Integer -> (Integer -> Integer)
add3 x y   :: Integer -> Integer
add3 x y z :: Integer
```

如果想看某个 function 的 **body**

比如 function `not :: Bool -> Bool` 的具体 implementation。

要去看 source code，比如可以在 [Hackage](https://hackage.haskell.org/) 



## Summary

1. Haskell expressions 在被 evaluated 之前，会先经过 type-checked。

1. 只有 well-typed expressions 才可以被 evaluated。

1. Haskell 里仍然可能发生 run-time errors，但是不会发生和 typing 有关的 errors。

