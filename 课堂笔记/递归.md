# Recursive Functions

这些 notes 应该和我们 textbook Programming in Haskell 的 chapter 6 一起读。

* 为了教学目的，我们会讨论一些来自 [Haskell'98 standard prelude](https://www.haskell.org/onlinereport/standard-prelude.html) 的 examples。

* See the [prelude for the current version of the language](https://hackage.haskell.org/package/base-4.12.0.0/docs/Prelude.html) for all predefined classes and their instances.


## Basic Concepts

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=48fbd212-bfcd-4f05-9630-ac4f012526fb)。

正如我们已经看到的，很多 functions 可以很自然地用其他 functions 来定义。例如，一个返回 non-negative integer 的 factorial 的 function，可以通过 library functions 计算 1 到给定 number 之间所有 integers 的 product 来定义：

```hs
fac :: Int -> Int
fac n = product [1..n]
```

Expressions 是通过一步一步把 functions 应用到它们的 arguments 上来 evaluated 的。

例如：

```hs
fac 5
= product [1..5]
= product [1,2,3,4,5]
= 1*2*3*4*5
= 120
```

在 Haskell 里，functions 也可以用它们自己来定义。这样的 functions 叫做 __recursive__。

```haskell
fac :: Int -> Int
fac 0 = 1
fac n = n * fac (n-1)
```
Function __fac__ 把 0 映射到 1，这叫 _base case_；把其他 integer 映射到它自己和前一个数的 factorial 的 product，这叫 _recursive case_。

例如：

```hs
fac 3
= 3 * fac 2
= 3 * (2 * fac 1)
= 3 * (2 * (1 * fac 0))
= 3 * (2 * (1 * 1))
= 3 * (2 * 1)
= 3 * 2
= 6
```

Note:

* `fac 0 = 1` 是合理的，因为 1 是 multiplication 的 identity：1 * x = x = x * 1。

* 这个 recursive definition 在 integers < 0 时会 diverge，因为 base case 永远到不了：

```hs
> fac (-1)
*** Exception: stack overflow
```

### Why is Recursion Useful?

* 有些 functions，比如 factorial，用其他 functions 来定义会更简单。

* 不过正如我们后面会看到的，很多 functions 可以很自然地用它们自己来定义。

* 使用 recursion 定义的 functions 的 properties，可以用一种简单但很强大的 mathematical technique 来证明，也就是 _induction_。

## Recursion on Lists

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=8f28b057-a77c-4b81-8769-ac4f01252b5a)。

Recursion 不只限于 numbers，也可以用来定义 lists 上的 functions。

```haskell
product' :: Num a => [a] -> a
product' []     = 1
product' (n:ns) = n * product' ns
```

`product'` function 把 empty list 映射到 1，也就是 _base case_；把任何 non-empty list 映射到它的 head 乘以它的 tail 的 `product'`，也就是 _recursive case_。

例如：

```hs
product' [2,3,4]
= 2 * product' [3,4]
= 2 * (3 * product' [4])
= 2 * (3 * (4 * product' []))
= 2 * (3 * (4 * 1))
= 24
```

Note: Haskell 里的 lists 实际上是通过 __cons__ operator 一个 element 一个 element 构造出来的。因此，[2,3,4] 只是 2:(3:(4:[])) 的 abbreviation。

使用和 `product'` 相同的 recursion pattern，我们可以定义 list 上的 length function。

```hs
length :: [a] -> Int
length []     = 0
length (_:xs) = 1 + length xs
```

Length function 把 empty list 映射到 0，也就是 _base case_；把任何 non-empty list 映射到它的 tail 的 length 的 successor，也就是 _recursive case_。

例如：

```hs
length [1,2,3]
= 1 + length [2,3]
= 1 + (1 + length [3])
= 1 + (1 + (1 + length []))
= 1 + (1 + (1 + 0))
= 3
```

使用类似的 recursion pattern，我们可以定义 list 上的 reverse function。

```hs
reverse :: [a] -> [a]
reverse []     = []
reverse (x:xs) = reverse xs ++ [x]
```

Function reverse 把 empty list 映射到 empty list，把任何 non-empty list 映射到它的 tail 的 reverse，再 append 它的 head。

例如：

```hs
reverse [1,2,3]
= reverse [2,3] ++ [1]
= (reverse [3] ++ [2]) ++ [1]
= ((reverse [] ++ [3]) ++ [2]) ++ [1]
= (([] ++ [3]) ++ [2]) ++ [1]
= [3,2,1]
```

有意思的是，上面例子中用到的 append operator `++` 也可以用 recursion 来定义。

```hs
(++) :: [a] -> [a] -> [a]
[]     ++ ys = ys
(x:xs) ++ ys = x : (xs ++ ys)
```

例如：

```hs
[1,2,3] ++ [4,5]
= 1 : ([2,3] ++ [4,5])
= 1 : (2 : ([3] ++ [4,5]))
= 1 : (2 : (3 : ([] ++ [4,5])))
= 1 : (2 : (3 : [4,5]))
= [1,2,3,4,5]))
```

`++` 的 recursive definition formalises 了这样一个想法：要 append 两个 lists，就从第一个 list 里不断复制 elements，直到第一个 list 被耗尽，然后把第二个 list 接到末尾。

## Multiple Arguments

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=dcc491f3-e715-4223-a9b7-ac4f01252e28)。

有多个 arguments 的 functions 也可以用 recursion 来定义。

* Zipping 两个 lists 的 elements：

```hs
zip :: [a] -> [b] -> [(a,b)]
zip []     _      = []
zip _      []     = []
zip (x:xs) (y:ys) = (x,y) : zip xs ys
```
For example:

```hs
zip ['a', 'b', 'c'] [1,2,3,4]
= ('a',1) : zip ['b', 'c'] [2,3,4]
= ('a',1) : ('b',2) : zip ['c'] [3,4]
= ('a',1) : ('b',2) : ('c',3) : zip [] [4]
= ('a',1) : ('b',2) : ('c',3) : []
= [('a',1), ('b',2), ('c',3)]
```

* 从 list 中 remove 前 n 个 elements：

```hs
drop :: Int -> [a] -> [a]
drop 0 xs     = xs
drop _ []     = []
drop n (_:xs) = drop (n-1) xs
```
例如：

```hs
drop 3 [4,6,8,10,12]
= drop 2 [6,8,10,12]
= drop 1 [8,10,12]
= drop 0 [10,12]
[10,12]
```

## Multiple Recursion

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=1ebd39f3-edad-4c4d-b777-ac4f01253209)。

Functions 也可以用 _multiple recursion_ 来定义，也就是一个 function 在自己的 definition 里被应用多次。

一个计算第 n 个 Fibonacci number 的 function，可以用 double recursion 定义如下，其中 Fibonacci sequence 是 0, 1, 1, 2, 3, 5, 8, 13, ...，并且 n >= 0：

```haskell
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-2) + fib (n-1)
```

例如：

```hs
fib 4
= fib (2) + fib (3)
= fib (0) + fib (1) + fib (1) + fib (2)
= 0 + 1 + 1 + fib (0) + fib (1)
= 0 + 1 + 1 + 0 + 1
= 3
```

## Mutual Recursion

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=88804dd0-9656-4969-af7d-ac4f01253d4c)。

Functions 也可以用 _mutual recursion_ 来定义，也就是两个或更多 functions 互相递归地定义对方。对于 non-negative integers，我们可以用 mutual recursion 定义 even 和 odd numbers。

```hs
even :: Int -> Bool
even 0 = True
even n = odd (n-1)

odd :: Int -> Bool
odd 0 = False
odd n = even (n-1)
```

例如：

```hs
even 4
= odd 3
= even 2
= odd 1
= even 0
= True
```

类似地，选择 list 中所有 even positions 和 odd positions 的 elements 的 functions，也可以这样定义。这里 positions 从 0 开始数：

```haskell
evens :: [a] -> [a]
evens []     = []
evens (x:xs) = x : odds xs

odds :: [a] -> [a]
odds []     = []
odds (_:xs) = evens xs
```
例如：

```hs
evens "abcde"
= 'a' : odds "bcde"
= 'a' : evens "cde"
= 'a' : 'c' : odds "de"
= 'a' : 'c' : evens "e"
= 'a' : 'c' : 'e' : odds []
= 'a' : 'c' : 'e' : []
= "ace"
```

## Programming Example - Quicksort

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=e818b628-dc42-4b7f-96ca-ac4f012557da)。

Quicksort algorithm 用来 sort 一个 values list，可以由下面两条 rules 来说明：

* Empty list 已经是 sorted 的。

* Non-empty lists 可以这样 sort：先 sort tail 中 <= head 的 values，再 sort tail 中 > head 的 values，然后把结果 lists append 到 head value 两边。

Using recursion, this specification can be translated directly into an implementation:

```haskell
qsort :: Ord a => [a] -> [a]
qsort []     = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
               where
                 smaller = [a | a <- xs, a <= x]
                 larger  = [b | b <- xs, b > x]
```
Note: 这可能是所有 programming language 里最简单的 quicksort implementation！

例如，下面把 qsort 简写成 q：

![qsortexample](./images/qsort.png)

## Advice on Recursion

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=a733c6a0-01c7-4769-95f0-ac4f01256f33)。

在这一节里，我们会给出一些建议，说明如何定义 functions，尤其是 recursive functions。这里使用一个 five-step process。

Example - drop：它会从一个 list 的开头 remove 给定数量的 elements。

* Step 1: define the type

Drop function 接收一个 integer 和一个由某种 type `a` 的 values 组成的 list，然后产生另一个同样由这种 values 组成的 list。

```hs
drop :: Int -> [a] -> [a]
```
在定义这个 type 时，我们已经做了四个 design decisions：

(i) 使用 integers，而不是更 general 的 numeric type，这是为了 simplicity。

(ii) 使用 currying，而不是把 arguments 放进 pair 里，这是为了 flexibility。

(iii) 把 integer argument 放在 list argument 前面，这是为了 readability，也就是 _drop_ __n__ _elements from_ __xs__。

(iv) 让 function 在 list elements 的 type 上是 _polymorphic_，这是为了 generality。

* Step 2: enumerate the cases

我们总共有四种 possible cases，也就是 integer argument 有两种可能 values（0 和 n），list argument 有两种可能（[] 和 (x:xs)），于是得到四种 possible combinations：

```hs
drop 0 []     = 
drop 0 (x:xs) = 
drop n []     = 
drop n (x:xs) = 
```

* Step 3: define the simple cases

根据 definition，从任何 list 开头 remove zero elements，都会得到同一个 list。

```hs
drop 0 []     = []
drop 0 (x:xs) = x:xs
drop n []     = 
drop n (x:xs) = 
```

尝试从 empty list 中 remove 一个或多个 elements 是 invalid 的，所以第三种情况可以省略，这样如果发生这种情况就会产生 error。不过这里我们选择避免产生 error，而是在这种情况下返回 empty list：

```hs
drop 0 []     = []
drop 0 (x:xs) = x:xs
drop n []     = []
drop n (x:xs) = 
```

* Step 4: define the other cases

对于从 non-empty list 中 remove 一个或多个 elements，我们先 drop 掉 list 的 head，然后对 list 的 tail recursive call 自己，并且数量比之前少 1。

```hs
drop 0 []     = []
drop 0 (x:xs) = x:xs
drop n []     = []
drop n (x:xs) = drop (n-1) xs
```

* Step 5: generalise and simplify

Drop 的前两个 equations 可以合并成一个 equation，表示从任何 list 中 remove zero elements，都会得到原 list：

```hs
drop 0 xs     = xs
drop n []     = []
drop n (x:xs) = drop (n-1) xs
```

第二个 equation 里的 variable n 和第三个 equation 里的 x 可以被 wildcard pattern `_` 替换，因为这些 variables 在 equation bodies 中没有被使用。

```hs
drop :: Int -> [a] -> [a]
drop 0 xs     = xs
drop _ []     = []
drop n (_:xs) = drop (n-1) xs
```
这正好就是 standard prelude 里 available 的 drop function 的 definition。

## Exercises

(1) 不要看 standard prelude，用 recursion 定义下面这些 library functions：

* 判断 list 中所有 logical values 是否都是 true：

```hs
and :: [Bool] -> Bool
```
* Concatenate 一个 list of lists：

```hs
concat :: [[a]] -> [a]
```
* 生成一个包含 n 个相同 elements 的 list：

```hs
replicate :: Int -> a -> [a]
```

* 选择 list 的 nth element：

```hs
(!!) :: [a] -> Int -> a
```

* 判断一个 value 是否是 list 的 element：

```hs
elem :: Eq a => a -> [a] -> Bool
```

(2) 定义一个 recursive function：

```hs
merge :: Ord a => [a] -> [a] -> [a]
```
它把两个 sorted lists of values merge 成一个 single sorted list。

例如：

```hs
> merge [2,5,6] [1,3,4]
[1,2,3,4,5,6]
```
