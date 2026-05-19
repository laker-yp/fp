# List Comprehensions

这些 notes 应该和我们 textbook Programming in Haskell 的 chapter 5 一起读。

## Note:
下面这个只是为了最后的 **The Caesar Cipher** 
```haskell
import Data.Char
```

## Basic Concepts

#### 在 mathematics 里

{x^2|x属于{1...5}}

它会产生 set {1, 4, 9, 16, 25}

也就是所有满足 x 属于 set {1...5} 的 x^2。

#### 在 Haskell 里

```hs
> [x^2 | x <- [1..5]]
把[1..5]中每个元素依次输入到x，然后进行平方
得到一个个新的元素，最后自动用[]括起来成为一个list
[1,4,9,16,25]
```
Symbol `|` 读作 _such that_【使得】，`<-` 读作 _drawn from_，expression【来自于】 

`x <- [1..5]` 叫做 __generator__【生成器】。Generator 说明如何为 x 生成 values。

##### 可以有 多个生成器，用逗号分开。例如：

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
```
x   -- 一个元素
xs  -- 一串 x，也就是 list
xss -- 一串 xs，也就是 list of lists
```
知道xss后开始↓
```hs
concat :: [[a]] -> [a]
concat xss = [x | xs <- xss, x <- xs]
```
例如：
```hs
> concat [[1,2,3],[4,5],[6]]
[1,2,3,4,5,6]
```
 `_` 在 generators 用来丢弃 list 中某些元素
 
 例如这个方程，从 pairs的list 中选出所有第一个元素

```haskell
firsts :: [(a,b)] -> [a]
firsts ps = [x | (x, _) <- ps]
```

计算length的function：通过把每个elem替换成 1，然后对结果 list 求 sum 来定义：

```hs
length :: [a] -> Int
length xs = sum [1 | _ <- xs]
```

在上面这个 case 里，generator `_ <- xs` 只是当作 counter，用来控制生成正确数量的 ones。

## Guards

使用 **guards** 来限制前面 generators 产生的 values

只保留待输入[]中复合guard条件的值

例如：

```hs
> [x | x <- [1..10], even x]
[2,4,6,8,10]
```

类似地，一个把正int映射到它的 positive factors（正因子） list 的 function 可以这样定义：

```haskell
factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]
```
例如：
```hs
> factors 6
[1,2,3,6]
```

使用 `factors`，我们可以定义一个判断某个 number 是否为 prime 

```haskell
prime :: Int -> Bool
prime n = 【factors n == [1,n]】
```

Note: 判断一个非质数并不要求 function `prime` 产生它所有的 factors。因为在 lazy evaluation 下，只要产生了除了 1 和它自己之外的任何 factor，结果 `False` 就可以立刻返回。

返回某个给定 从0到n中所有 primes 的 list：

```haskell
primes :: Int -> [Int]
primes n = [x | x <- [2..n], prime x]
```

## The Zip Function

 `zip`把两个 lists 映射成一个pair的list，每个 pair 由两个 lists 中对应位置的元素组成
```hs
zip :: [a] -> [b] -> [(a,b)]
```
例如：

```hs
> zip ['a','b','c'] [1,2,3,4]  --4直接丢掉了
[('a',1),('b',2),('c',3)]
```
使用 `zip`，我们可以定义一个 function

返回一个 list 中所有 adjacent(相邻) elements的 pairs：

```haskell
pairs :: [a] -> [(a,a)]
pairs xs = zip xs (tail xs)
```

例如：
```hs
> pairs [1,2,3,4]   ==zip[1,2,3,4][2,3,4]
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
String 是一串被双引号包起来的 char。不过在内部，string被表示为char的lists。

例如             `"abc" :: String` 

其实只是`['a', 'b', 'c'] :: [Char]` 的缩写

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

计算某个 char在string中出现了多少次：

```haskell
count :: Char -> String -> Int
count x xs = length [x' | x' <- xs, x == x']
```

例如：
```hs
> count 's' "Mississippi"
4
```

计算string 中小写和 particular characters 出现的数量：

x 是否属于 'a' 到 'z'的写法是：

x >= 'a' && x <= 'z'

```haskell
lowers :: String -> Int
lowers xs = length [x | x <- xs, 【x >= 'a' && x <= 'z'】]
```

例如：
```hs
> lowers "Hiii"
3
```

## 凯撒密码

Caesar cipher 是一种很有名的 string加密，虽然它很垃圾

目的：把 string 中每个 letter 替换成 alphabet 中往后移动 _n_ 个位置

也就是 _shift factor_ 个位置的 letter；如果超过 alphabet 末尾，就从头绕回来

### Encoding and Decoding

在 script 开头加入下面这个 code 来加载一些方法

ord :: Char -> Int //把一个 Char 转成它对应的数字编码

chr 97  -- 'a'

```hs
import Data.Char
```

Note: 为了简单，我们只 encode string 里的 lower-case letters，其他比如 upper大写和 punctuation标点，会保持不变。

`let2int`，它把 小写字母 转换成 0 到 25 之间对应的 integer

`int2let`，把 number 转换成对应的 letter。

```haskell
let2int :: Char -> Int
let2int c = ord c - ord 'a'  --已0为base，a等于0

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

定义`shift`。它对一个小写char应用 shift factor：

1先把 letter 转换成对应 integer

2加上 shift factor

3再对 26 取余

4最后把得到的 num 转回 小写char：

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
> encode 3 "fun"
"ixq"
```

直接复用 `encode` 然后给它一个 negative shift factor 就可以变成decode方法了

例如：
```hs
> encode (-3) "ixq"
"fun"
```

### Frequency Tables

破解 Caesar cipher 的关键观察是：English 中某些 letters 出现得比其他 letters 更频繁。通过分析大量 English text，我们可以得到下面这些 approximate percentage frequencies。

```haskell
...
e 出现频率约 12.7%
...
z 出现频率约 0.1%
```

比如 letter 'e' 出现得最多

我们定义一个 function，用来计算一个 integer 相对于另一个 integer 的 百分比：

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
