<a name="ptrees"></a>
# Permutation trees, list permutations
## and paths in such trees (hard)
Permutation tree 的每一层是在选一个还没用过的元素；每一条从 root 到 leaf 的路径就是一个完整排列。

比如[1,2,3]的排列=[1,2,3]
[1,3,2]
[2,1,3]
[2,3,1]
[3,1,2]
[3,2,1]

list-branching trees：
* label在边上而不是节点上
* 并且 leaf 由 empty branching 给出
* 拥有一个（可能为空的）subtrees list
* 如果这个 list 是空的，那么我们就得到一个 leaf
* label 位于边上，像 game trees 一样，比如：•── a1 --> •

```haskell
data Tree a = EBranch [(a, Tree a)]

   deriving (Show)
```
```
t1 :: Tree Char                    •
t1 =                               ├── a --> •
  EBranch                          └── b --> •
    [ ('a', EBranch [])                      ├── c --> •
    , ('b', EBranch                          └── d --> •
        [ ('c', EBranch [])        所有路径只有三条
        , ('d', EBranch [])        ["a", "bc", "bd"]
        ])
    ]
```
```
fullPaths :: Tree a -> [[a]]
fullPaths (EBranch []) = [[]]
fullPaths (EBranch forest) = [x:p | (x,t) <- forest, p <- fullPaths t]
```

`forest` 是一个 list，里面每个元素的类型是 (a, Tree a)

`(x,t) <- forest` 是把一个个[...(x, t)...]给取出来

比如`├── a --> •`那么x = 'a' t = EBranch []

`p <- fullPaths t` 是对于每一条 branch (x,t)，我们去算fullPaths t

比如fullPaths t = [[1,2], [3,4], [5]]

那么p就依次等于[1,2]...
                    
`x:p`就是把x：到那一条path上


forest就是一个由“元素与树的 pair”构成的 list。

下面这个函数给出从 root 到任意 node（包括 leaf） 的所有 path 的 list：

```haskell
paths :: Tree a -> [[a]]
paths (EBranch forest) =  [] : [x:p | (x,t) <- forest, p <- paths t]
```

现在我们构造一个 list 的 permutation tree，使得这棵树的 full paths 恰好就是给定 list 的所有 permutation：

比如permTree [1,2,3]要造一棵这样的tree
```
•
├── 1 --> permTree [2,3]..继续递归..
├── 2 --> permTree [1,3]
└── 3 --> permTree [1,2]
```
```haskell
permTree :: Eq a => [a] -> Tree a
permTree xs = EBranch [ (v, permTree(xs \\\ v)) | v <- xs]
  where  --从 list 里面删除第一个等于a的元素
    (\\\) :: Eq a => [a] -> a -> [a]
    []     \\\ _   = undefined
    (x:xs) \\\ y
      | x == y     = xs
      | otherwise  = x : (xs \\\ y)
```
`permTree(xs \\\ v))` 生成把v去掉后的xs

利用这个，我们就可以计算给定 list 的所有 permutation：

```haskell
permutations :: Eq a => [a] -> [[a]]
permutations = fullPaths . permTree
```

你知道 `n! = 1 * 2 * 3 * ... * n`。这就是 `n` 的 [factorial](https://en.wikipedia.org/wiki/Factorial)，它恰好等于一个含有 `n` 个不同元素的 list 的 permutation 个数。因此，计算 factorial function 的一种（低效的！）方式是：

```haskell
factorial n = length (permutations [1..n])
```

下面定义的函数 `removals` 有比较差的 time complexity（quadratic?）。而下面定义的函数 `removals2` 在概念上更复杂一些，但是它运行在 linear time。它需要一个函数：给定一个 list，产生一个 list of pairs，其中第一部分是“被移除的元素”，第二部分是“移除该元素之后剩下的 list”。我们给出两个版本（一个更直观清晰，另一个没有那么直观但速度快得多）：

```haskell
removals, removals2 :: [a] -> [(a,[a])]
removals [] = []
removals (x:xs) = (x,xs) : map (\(y,ys) -> (y,x:ys)) (removals xs)
```

下面是 lists 的另一种表示方式，它可以让某些 list operation 更快（这种表示叫 difference lists）。

```haskell
type DList a = [a] -> [a]

removals' :: DList a -> [a] -> [(a,[a])]
removals' f [] = []
removals' f (x:xs) = (x, f xs) : removals' (f.(x:)) xs

removals2 = removals' (\xs -> xs)
```

有了这个，我们就可以在不依赖 equality constraints 的情况下构造 permutation trees：

```haskell
permTree2 :: [a] -> Tree a
permTree2 xs = EBranch [(y, permTree2 ys) | (y,ys) <- removals2 xs]

permutations2 :: [a] -> [[a]]
permutations2 = fullPaths . permTree2
```

但是，正如上面讨论过的那样，这个算法为什么正确，就没有那么显然了。也就是说，它为什么确实做到了我们声称的事情，不像前一个版本那样一眼就能看明白。

* Self-learning: 去了解一下，不通过 trees，如何直接计算给定 list 的所有 permutations。

* 你应该说服自己：我们这种借助 trees 的方法，对应于那些“不借助 trees 的方法”中的某些方案。

<a name="exprtrees"></a>
# Expression trees

有一个讨论这一节的视频，[available on Canvas](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=5a578db9-e6bd-486b-9ab4-ac6200f3a2b2)。

有时候，使用一种更专门化的 tree data type 会很有用，因为它是为某个具体问题量身定做的。例如，很多 compiler 会先把字符串解析成 *expression trees*，然后再处理这些树以生成代码。

这里我们定义一个简单的 numerical expression trees data type，并给出一个 *evaluation* function，它会处理 expression trees 并产生对应的值。

```haskell
data Expr a = Value a
            | FromInteger Integer
            | Negate (Expr a)
            | Abs (Expr a)
            | SigNum (Expr a)
            | Add (Expr a) (Expr a)
            | Mul (Expr a) (Expr a)
```

这个定义模仿了 prelude 中的 `Num` class：

```hs
class Num a where
  (+) :: a -> a -> a
  (-) :: a -> a -> a
  (*) :: a -> a -> a
  negate :: a -> a
  abs :: a -> a
  signum :: a -> a
  fromInteger :: Integer -> a
```

然后我们这样定义 evaluation：

```haskell
eval :: Num a => Expr a -> a
eval (Value x)       = x
eval (FromInteger n) = fromInteger n
eval (Negate e)      = negate (eval e)
eval (Abs e)         = abs(eval e)
eval (SigNum e)      = signum(eval e)
eval (Add e e')      = eval e + eval e'
eval (Mul e e')      = eval e * eval e'
```

在看例子之前，这次我们不让 Haskell 用 `deriving` 机制自动生成 `show`，而是自己定义 `show` function。粗略地说，prelude 中的 `Show` class 可以写成：

```hs
class Show a where
  show :: a -> String
```

（如果写得完整一点，`Show` class 实际上还规定了[更多函数](https://hackage.haskell.org/package/base-4.10.0.0/docs/src/GHC.Show.html#Show)，不过它们都可以从 `show` 推导出来。）

我们为 expression trees 定义 `show` function，如下：

```haskell
instance Show a => Show(Expr a) where
  show (Value x)       = show x
  show (FromInteger n) = "fromInteger(" ++ show n ++ ")"
  show (Negate e)      = "negate(" ++ show e  ++ ")"
  show (Abs e)         = "abs(" ++ show e ++ ")"
  show (SigNum e)      = "signum(" ++ show e ++ ")"
  show (Add e e')      = "(" ++ show e ++ "+" ++ show e' ++ ")"
  show (Mul e e')      = "(" ++ show e ++ "*" ++ show e' ++ ")"
```

例子：

```hs
> eval (Mul (Value 3) (Add (Value 7) (Value 6)))
39
> Mul (Value 3) (Add (Value 7) (Value 6))
(3*(7+6))
> show (Mul (Value 3) (Add (Value 7) (Value 6)))
"(3*(7+6))"
```

<a name="newtype"></a>
# Types with a single constructor

如果一个 type 只有一个 constructor，并且这个 constructor 只有一个 argument，那么它可以用 `newtype` 来定义。参见书上的 Section 8.3（印刷版第 95 页）。不过，用 `newtype` 和用对应的 `data` declaration 来定义，在语义上有一个比较微妙的差别，这一点在 [haskell wiki](https://wiki.haskell.org/Newtype) 中有讨论。

如果一个 data type 只有一个 constructor，但这个 constructor 可以有任意多个 arguments，那么它可以用 *field labels* 来定义。下面是 [A Gentle Introduction to Haskell, Version 98](https://www.haskell.org/tutorial/moretypes.html) 中的一个例子：

```hs
data Point = Pt Float Float

pointx, pointy :: Point -> Float
pointx (Pt x _) = x
pointy (Pt _ y) = y
```

使用 field labels，它可以等价地写成：

```hs
data Point = Pt {pointx, pointy :: Float}
```

你可以把这句话理解为：`Point` 有两个 field，一个叫 `pointx`，另一个叫 `pointy`，并且它们的 type 都是 `Float`。这样一来，`Pt 1 2` 和 `Pt {pointx=1, pointy=2}` 都是这个 type 的合法值，而且它们是等价的。你也可以在 pattern matching 里这样写：

```hs
norm (Pt {pointx = x, pointy = y}) = sqrt (x*x+y*y).
```
`size`
```
size :: Tree a -> Int
size (EBranch xs) = sum [1 + size t | (_, t) <- xs]
```
`leaves`
```
leaves :: Tree a -> Int
leaves (EBranch []) = 1
leaves (EBranch xs) = sum [leaves t | (_, t) <- xs]
```
`insert`
```
insert :: Eq a => [a] -> Tree a -> Tree a
insert [] tree = tree
insert (x:xs) (EBranch branches) =
  EBranch (insertBranch x xs branches)

insertBranch :: Eq a => a -> [a] -> [(a, Tree a)] -> [(a, Tree a)]
insertBranch x xs [] =
  [(x, insert xs (EBranch []))]

insertBranch x xs ((y,t):branches)
  | x == y    = (y, insert xs t) : branches
  | otherwise = (y,t) : insertBranch x xs branches
```
于是 `EBranch []`（类型为 `Tree a`）就是一个 leaf。下面这个函数构造出从 root 到各个 leaf 的所有 path 的 list：

```haskell
fullPaths :: Tree a -> [[a]]
fullPaths (EBranch []) = [[]]
fullPaths (EBranch forest) = [x:p | (x,t) <- forest, p <- fullPaths t]
```
