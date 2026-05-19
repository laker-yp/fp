# List Comprehensions

这些 notes 应该和我们 textbook Programming in Haskell 的 chapter 5 一起读。

## Note:
下面这个只是为了最后的 **The Caesar Cipher** 
```haskell
import Data.Char
```

## Basic Concepts

在 mathematics 里，_comprehension_ notation 可以用已有 sets 构造新的 sets。例如：

{x^2|x属于{1...5}}

它会产生 set {1, 4, 9, 16, 25}

也就是所有满足 x 属于 set {1...5} 的 x^2。

在 Haskell 里

```hs
> [x^2 | x <- [1..5]] 
[1,4,9,16,25]
```
Symbol `|` 读作 _such that_【使得】，`<-` 读作 _drawn from_，expression【来自于】 

`x <- [1..5]` 叫做 __generator__【生成器】。Generator 说明如何为 x 生成 values。

Comprehensions 可以有 多个生成器，用逗号分开。例如：

```hs
> [(x,y) | x <- [1,2,3],  y <- [4,5]]
    在这里x是外循环，y是循环
输出↓
[(1,4),(1,5),  (2,4),(2,5),  (3,4),(3,5)]
```

## Dependent Generators

后面的 generator 可以依赖前面 generator 引入的 variable：

```hs
> [(x,y) | x <- [1..3], y <- [x..3]]
x到2的时候，内循环y变成[2..3]了
[(1,1),(1,2),(1,3),(2,2),(2,3),(3,3)]
```

使用 dependent generator，我们可以定义一个 library function，用来 _concat_ 一个列表的列表：

```hs
concat :: [[a]] -> [a]
concat xss = [x | xs <- xss, x <- xs]
```
例如：
```hs
> concat [[1,2,3],[4,5],[6]]
[1,2,3,4,5,6]
```
Wildcard pattern `_` 在 generators 里有时很有用，可以用来丢弃 list 中某些 elements。例如，一个从 list of pairs 中选出所有 first components 的 function 可以这样定义：

```haskell
firsts :: [(a,b)] -> [a]
firsts ps = [x | (x, _) <- ps]
```

类似地，计算 list length 的 library function 可以通过把每个 element 替换成 1，然后对结果 list 求 sum 来定义：

```hs
length :: [a] -> Int
length xs = sum [1 | _ <- xs]
```

在上面这个 case 里，generator `_ <- xs` 只是当作 counter，用来控制生成正确数量的 ones。

## Guards

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=b18b42b5-0509-4976-a51c-ac3e01048c63)。

List comprehensions 可以使用 **guards** 来限制前面 generators 产生的 values。如果 guard 是 _true_，当前 values 会被保留；如果是 _false_，就会被丢弃。

例如：

```hs
> [x | x <- [1..10], even x]
[2,4,6,8,10]
```

类似地，一个把 positive integer 映射到它的 positive factors list 的 function 可以这样定义：

```haskell
factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]
```
例如：
```hs
> factors 15
[1,3,5,15]
```

一个 positive integer 如果它的 factors 只有 1 和它自己，那么它就是 prime。因此，使用 `factors`，我们可以定义一个判断某个 number 是否 prime 的 function：

```haskell
prime :: Int -> Bool
prime n = factors n == [1,n]
```
例如：

```hs
> prime 15
False

> prime 7
True
```

Note: 判断像 15 这样的 number 不是 prime，并不要求 function `prime` 产生它所有的 factors。因为在 lazy evaluation 下，只要产生了除了 1 和它自己之外的任何 factor，结果 `False` 就可以立刻返回。

使用 guard，我们现在可以定义一个 function，返回某个给定 limit 以内所有 primes 的 list：

```haskell
primes :: Int -> [Int]
primes n = [x | x <- [2..n], prime x]
```

例如：

```hs
> primes 40
[2,3,5,7,11,13,17,19,23,29,31,37]
```

## The Zip Function

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=aa33daea-3f09-40a7-9e74-ac3e01048ee7)。

一个很有用的 library function 是 `zip`，它把两个 lists 映射成一个 pairs list，每个 pair 由两个 lists 中对应位置的 elements 组成。

```hs
zip :: [a] -> [b] -> [(a,b)]
```
例如：

```hs
> zip ['a','b','c'] [1,2,3,4]
[('a',1),('b',2),('c',3)]
```
使用 `zip`，我们可以定义一个 function，返回一个 list 中所有 adjacent elements 的 pairs：

```haskell
pairs :: [a] -> [(a,a)]
pairs xs = zip xs (tail xs)
```

例如：
```hs
> pairs [1,2,3,4]
[(1,2),(2,3),(3,4)]
```

使用 `pairs`，我们可以定义一个 function，判断 list 中 elements 是否 sorted：

```haskell
sorted :: Ord a => [a] -> Bool
sorted xs = and [x <= y | (x,y) <- pairs xs]
```

例如：
```hs
> sorted [1,2,3,4]
True
> sorted [1,3,2,4]
False
```

使用 `zip`，我们可以定义一个 function，返回某个 value 在 list 中所有出现的位置：

```haskell
positions :: Eq a => a -> [a] -> [Int]
positions x xs =
   [i | (x',i) <- zip xs [0..], x == x']
```

例如：
```hs
> positions 0 [1,0,0,1,0,1,1,0]
[1,2,4,7]

> positions False [True, False, True, False]
[1,3]
```

## String Comprehensions

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=bd34ce3f-2698-4ee6-8c4a-ac3e0104a34e)。

String 是一串被 double quotes 包起来的 characters。不过在内部，strings 被表示为 characters 的 lists。

例如，string `"abc" :: String` 其实只是 list of characters `['a', 'b', 'c'] :: [Char]` 的 abbreviation。

因为 strings 本质上只是特殊的 lists，所以任何作用在 lists 上的 polymorphic function 也可以应用到 strings 上。例如：

```hs
> "abcde" !! 2
'c'
> take 3 "abcde"
"abc"
> length "abcde"
5
> zip "abc" [1,2,3,4]
[('a',1),('b',2),('c',3)]
```

类似地，list comprehensions 也可以用来定义 strings 上的 functions，比如计算某个 character 在 string 中出现了多少次：

```haskell
count :: Char -> String -> Int
count x xs = length [x' | x' <- xs, x == x']
```

例如：
```hs
> count 's' "Mississippi"
4
```

类似地，我们可以定义一个 function，返回 string 中 lower-case letters 和 particular characters 出现的数量：

```haskell
lowers :: String -> Int
lowers xs = length [x | x <- xs, x >= 'a' && x <= 'z']
```

例如：
```hs
> lowers "Haskell"
6
```

## Extended Programming Example - The Caesar Cipher

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=9b744b7b-a16b-4f6d-b901-ac3e0104c35d)。

Caesar cipher 是一种很有名的 strings encoding method，虽然它很 primitive。它做的事情很简单：把 string 中每个 letter 替换成 alphabet 中往后移动 _n_ 个位置，也就是 _shift factor_ 个位置的 letter；如果超过 alphabet 末尾，就从头绕回来。例如：

"haskell is fun" 在 n = 3 时会被 encoded 成 "kdvnhoo lv ixq"。

"haskell is fun" 在 n = 10 时会被 encoded 成 "rkcuovv sc pex"。

### Encoding and Decoding

在这个 example 里，我们会使用一些处理 characters 的 standard functions，它们由一个叫 `Data.Char` 的 library 提供。可以通过在 script 开头加入下面这个 declaration 来加载它：

```hs
import Data.Char
```

Note: 为了简单，我们只 encode string 里的 lower-case letters，其他 characters，比如 upper-case letters 和 punctuation，会保持不变。

我们先定义一个 function `let2int`，它把 lower-case letter 转换成 0 到 25 之间对应的 integer。我们也定义相反方向的 function `int2let`，把 number 转换成对应的 letter。

```haskell
let2int :: Char -> Int
let2int c = ord c - ord 'a'

int2let :: Int -> Char
int2let n = chr (ord 'a' + n)
```

例如：
```hs
> let2int 'a'
0

> int2let 0
'a'
```

使用上面两个 functions，我们可以定义 function `shift`。它对一个 lower-case letter 应用 shift factor：先把 letter 转换成对应 integer，加上 shift factor，再对 26 取余，最后把得到的 integer 转回 lower-case letter：

```haskell
shift :: Int -> Char -> Char
shift n c | isLower c = int2let ((let2int c + n) `mod` 26)
          | otherwise = c
```

例如：

```hs
> shift 3 'a'
'd'

> shift 3 'z'
'c'

> shift (-3) 'c'
'z'
```
现在我们可以定义 `encode` function，它在 list comprehension 里使用 shift function：

```haskell
encode :: Int -> String -> String
encode n xs = [shift n x | x <- xs]
```

例如：
```hs
> encode 3 "haskell is fun"
"kdvnhoo lv ixq"
```

我们不需要单独写一个 decode function。我们可以复用 `encode` function，然后给它一个 negative shift factor。

例如：
```hs
> encode (-3) "kdvnhoo lv ixq"
"haskell is fun"
```

### Frequency Tables

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=874a8714-47e2-45ea-bfe0-ac3e0104d9f2)。

破解 Caesar cipher 的关键观察是：English 中某些 letters 出现得比其他 letters 更频繁。通过分析大量 English text，我们可以得到下面这些 approximate percentage frequencies。

```haskell
table :: [Float]
table = [8.1, 1.5, 2.8, 4.2, 12.7, 2.2, 2.0, 6.1, 7.0,
         0.2, 0.8, 4.0, 2.4, 6.7, 7.5, 1.9, 0.1, 6.0, 
         6.3, 9.0, 2.8, 1.0, 2.4, 0.2, 2.0, 0.1]
```

比如 letter 'e' 出现得最多，频率是 12.7%；letters 'q' 和 'z' 出现得最少，各自是 0.1%。

我们定义一个 function，用来计算一个 integer 相对于另一个 integer 的 percentage：

```haskell
percent :: Int -> Int -> Float
percent n m = (fromIntegral n / fromIntegral m) * 100
```

例如：

```hs
> percent 5 15
33.333336
```

现在我们可以定义一个 function，为任意给定 string 返回 frequency table：

```haskell
freqs :: String -> [Float]
freqs xs = [percent (count x xs) n | x <- ['a'..'z']]
           where n = lowers xs
```

例如：

```hs
> freqs "abbcccddddeeeee"
[6.666667, 13.333334, 20.0, 26.666667, ..., 0.0]
```

### Cracking the Cipher

这一节也有一个 [video](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=29b5fe9f-ee0c-4f9b-b883-ac3e0104ff1f)。

比较 observed frequencies list _os_ 和 expected frequencies list _es_ 的一个 standard method 是 _chi-square statistic_，定义为下面这个 summation：

![chisquare](./images/eq_2.png)

其中 _n_ 表示两个 lists 的 length。

Note: 我们关心的是：它产生的 value 越小，两个 frequency lists 匹配得越好。上面的 formula 可以翻译成下面这个 function definition：

```haskell
chisqr :: [Float] -> [Float] -> Float
chisqr os es = sum [((o-e)^2)/e | (o,e) <- zip os es]
```

我们也定义 function `rotate`，它把 list 的 elements 向左 rotate _n_ 个位置，在 list 开头处 wrap around，并假设 integer argument _n_ 在 0 到 list length 之间：

```haskell
rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs
```

例如：
```hs
> rotate 3 [1,2,3,4,5]
[4,5,1,2,3]
```

_现在假设我们拿到了一个 encoded string，但是不知道 encode 它时使用的 shift factor。我们想确定这个 number，从而 decode 这个 string。怎么做？_

我们可以这样做：先生成 encoded string 的 frequency table，然后对这个 table 的每一种 possible rotation，都和 expected frequencies table 计算 chi-square statistic，最后把 minimum chi-square value 的位置作为 shift factor。

例如，如果我们令：
```hs
table' = freqs "kdvnhoo lv ixq"
```
那么：

```hs
[chisqr (rotate n table') table | n <- [0..25]]
```
会得到结果：

```hs
[1408.8524, 640.0218, 612.3969, 202.42024, ..., 626.4024]
```

其中出现在 position 3 的 value 202.42024 是 minimum value。于是我们得出结论：3 最可能是用来 encode 这个 string 的 shift factor，而我们也知道这确实是对的。

现在可以写出完整的 cracking cipher function：

```haskell
crack :: String -> String
crack xs = encode (-factor) xs
  where
     factor = head (positions (minimum chitab) chitab)
     chitab = [chisqr (rotate n table') table | n <- [0..25]]
     table' = freqs xs
```

例如：

```hs
> crack "kdvnhoo lv ixq"
"haskell is fun"

> crack "vscd mywzboroxcsyxc kbo ecopev"
"list comprehensions are useful"
```

Note: _crack_ function 可以 decode 大多数使用 Caesar cipher 产生的 strings，不过如果 string 太短，或者 letters 分布很 unusual，它可能不会成功。

例如：

```hs
> crack (encode 3 "haskell")
"piasmtt"

> crack (encode 3 "boxing wizards jump quickly")
"wjsdib rduvmyn ephk lpdxfgt"
```

## Exercises

(1) 一个 positive integers 的 triple (x,y,z) 如果满足 x^2 + y^2 = z^2，就叫做 pythagorean。使用 list comprehension，定义一个 function：

```hs
pyths :: Int -> [(Int,Int,Int)]
```
它把 integer n 映射到所有 components 都在 [1..n] 中的这种 triples。
例如：
```hs
> pyths 5
[(3,4,5),(4,3,5)]
```

(2) 一个 positive integer 如果等于它所有 factors 的和，并且 factors 不包括它自己，那么它就是 perfect。使用 list comprehension，定义一个 function：

```hs
perfects :: Int -> [Int]
```
它返回给定 limit 以内所有 perfect numbers 的 list。例如：
```hs
> perfects 500
[6,28,496]
```

(3) 两个 length 为 n 的 integers lists xs 和 ys 的 scalar product，等于对应位置 integers 的 products 的 sum：

![squarenumbers](./images/ex_3.png)

使用 list comprehension，定义一个 function，返回两个 lists 的 scalar product。
