# Lazy natural numbers 

我们引入惰性自然数，并通过一个示例应用来让某个算法变得更快。

## Motivating example

以下code先算xs的全部长度，再拿长度与n比较
```haskell
checkLengthBiggerThan :: [a] -> Int -> Bool
checkLengthBiggerThan xs n = length xs > n
```
如果列表 `xs` 很大，下面的函数会很慢。而且，如果列表 `xs` 是无限的，则一直循环：

如length [0..]

改进:这样无论 `xs` 的长度是多少，它最多只需要 `n` 步：
```haskell
checkLengthBiggerThan' :: [a] -> Int -> Bool
checkLengthBiggerThan' []     0 = False
checkLengthBiggerThan' xs     0 = True
checkLengthBiggerThan' []     n = False
-----重点-----
checkLengthBiggerThan' (x:xs) n = checkLengthBiggerThan' xs (n-1)
--每次从list中拿走一个elem，每检查一次就把n--，直到最后n=0了，如果返回list还有剩余就意味着对应第二条
checkLengthBiggerThan' xs     0 = True
```
tips：忽略负数。

## Lazy natural numbers

还有另一种方式可以让上面的函数变快：在原始算法中，把类型 `Int` 替换为惰性自然数类型 `Nat`：

```haskell
data Nat = Zero | Succ Nat
         deriving (Eq,Ord)
```

这个想法是，它按如下方式表示自然数 0,1,2,3,...：
```hs
        0= Zero
        1= Succ Zero
        2= Succ (Succ Zero)
        3= Succ (Succ (Succ Zero))
           ...
```
我们可以在 Haskell 中这样定义：
```haskell
one, two, three :: Nat
one   = Succ Zero
two   = Succ one
three = Succ two
```
将Int转为Nat
```haskell
toNat :: Int -> Nat
toNat 0 = Zero
toNat n = Succ (toNat (n-1))
```
在类型 `Nat` 中存在无穷，所以不怕陷入死循环[1..]
```haskell
infty = Succ infty
```

这会永远计算下去，产生一个无限堆叠的 `Succ (Succ (Succ
(Succ ...` 后继构造器，但关键在于，这个计算是惰性的。

长度函数：
length' 返回的是一个递归结构：

Succ (Succ (Succ ...))
```haskell
length' :: [a] -> Nat
length' []     = Zero
length' (x:xs) = Succ (length' xs)
```
这个结构可以只展开前面几层，而不用一次性全部求完。

如果某个比较函数只需要知道“是不是至少有 4 层 Succ”，那它根本不必把后面全部算出来

例如，我们有：
   * `length [0..]` 会一直循环而不给出任何答案，但
   * `length' [0..] = infty`。

现在定义一个惰性的比较算法如下：
```haskell
biggerThan :: Nat -> Nat -> Bool
Zero     `biggerThan` y        = False
(Succ x) `biggerThan` Zero     = True
(Succ x) `biggerThan` (Succ y) = x `biggerThan` y
```
在这里不用n-1，因为从Succ x到x，已经是--了

核心！！！！递归直到一个列表空了，就可以进行比较了，所以前两行的base在code时也很重要

关键点在于，在第二个等式中，为了给出答案 `True`，并不需要对 `x` 进行求值。例如：

```hs
> infty `biggerThan` three
True
```

有了这个，第一个算法就变快了，而且也能处理无限列表：

```haskell
checkLengthBiggerThan'' :: [a] -> Int -> Bool
checkLengthBiggerThan'' xs n = (length' xs) `biggerThan` (toNat n)
```


但实际上由于我们派生了 `Ord`，我们还可以这样写：

```haskell
checkLengthBiggerThan''' :: [a] -> Int -> Bool
checkLengthBiggerThan''' xs n = length' xs > toNat n
```

而且这同样快，这说明 `Ord` 的派生机制一定会生成一个和我们自己的算法类似的惰性比较算法：

```hs
> checkLengthBiggerThan''' [1..10^9] 3
True
(0.01 secs, 70,200 bytes)
```

关键点在于，使用惰性自然数让这个自然的算法变快了，而它对于整数来说是很慢的。此外，使用惰性自然数的一个优点是：由于有惰性自然数 `infty`，无限列表的长度也变得有良好定义。
