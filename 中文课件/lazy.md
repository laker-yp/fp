# Lazy natural numbers 

我们引入惰性自然数，并通过一个示例应用来让某个算法变得更快。

## Motivating example

如果列表 `xs` 很大，下面的函数会很慢。而且，如果列表 `xs` 是无限的，它会一直循环而不给出答案：
```haskell
checkLengthBiggerThan :: [a] -> Int -> Bool
checkLengthBiggerThan xs n = length xs > n
```
示例：
```hs
> :set +s
> checkLengthBiggerThan [1..10^6] 3
True
(0.04 secs, 72,067,432 bytes)
> checkLengthBiggerThan [1..10^7] 3
True
(0.19 secs, 720,067,488 bytes)
> checkLengthBiggerThan [1..10^8] 3
True
(1.47 secs, 7,200,067,600 bytes)
> checkLengthBiggerThan [1..10^9] 3
True
(14.35 secs, 72,000,067,640 bytes)
```

我们可以像下面这样让它变快，这样无论 `xs` 的长度是多少，它最多只需要 `n` 步：
```haskell
checkLengthBiggerThan' :: [a] -> Int -> Bool
checkLengthBiggerThan' []     0 = False
checkLengthBiggerThan' xs     0 = True
checkLengthBiggerThan' []     n = False
checkLengthBiggerThan' (x:xs) n = checkLengthBiggerThan' xs (n-1)
```
我们忽略负数。

示例：
```hs
> checkLengthBiggerThan' [1..10^9] 3
True
(0.01 secs, 68,408 bytes)
```

## Lazy natural numbers

还有另一种方式可以让上面的函数变快：在原始算法中，把类型 `Int` 替换为惰性自然数类型 `Nat`：

```haskell
data Nat = Zero | Succ Nat deriving (Eq,Ord)
```

这个想法是，它按如下方式表示自然数 0,1,2,3,...：
```hs
         Zero
         Succ Zero
         Succ (Succ Zero)
         Succ (Succ (Succ Zero))
         ...
```
我们可以在 Haskell 中这样定义：
```haskell
one, two, three :: Nat
one   = Succ Zero
two   = Succ one
three = Succ two
```
此外，我们还可以像下面这样把一个非负整数转换为惰性自然数：
```haskell
toNat :: Int -> Nat
toNat 0 = Zero
toNat n = Succ (toNat (n-1))
```
而且，在类型 `Nat` 中我们还有无穷：
```haskell
infty = Succ infty
```

这会永远计算下去，产生一个无限堆叠的 `Succ (Succ (Succ
(Succ ...` 后继构造器，但关键在于，这个计算是惰性的。

现在我们可以如下定义一个长度函数：
```haskell
length' :: [a] -> Nat
length' []     = Zero
length' (x:xs) = Succ (length' xs)
```
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
例如：
```hs
> checkLengthBiggerThan'' [1..10^9] 3
True
(0.02 secs, 69,032 bytes)
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
