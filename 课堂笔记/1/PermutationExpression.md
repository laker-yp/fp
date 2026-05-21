<a name="ptrees"></a>
# Permutation trees, list permutations
## and paths in such trees (hard)

现在我们来考虑一种 list-branching trees：它们在边上而不是节点上带有 label，并且 leaf 由 empty branching 给出。它的意思是：我们不再像 binary trees 那样，恰好有两个 subtrees，而是拥有一个（可能为空的）subtrees list。如果这个 list 是空的，那么我们就得到一个 leaf。label 位于边上，像 game trees 一样，而不是像前面的 binary trees 那样位于节点上：

```haskell
data Tree a = EBranch [(a, Tree a)] deriving (Show)
```

于是 `EBranch []`（类型为 `Tree a`）就是一个 leaf。下面这个函数构造出从 root 到各个 leaf 的所有 path 的 list：

```haskell
fullPaths :: Tree a -> [[a]]
fullPaths (EBranch []) = [[]]
fullPaths (EBranch forest) = [x:p | (x,t) <- forest, p <- fullPaths t]
```

一个 forest 是类型 `[(a, Tree a)]` 的元素，也就是一个由“元素与树的 pair”构成的 list。下面这个函数给出从 root 到任意 node（包括 leaf） 的所有 path 的 list：

```haskell
paths :: Tree a -> [[a]]
paths (EBranch forest) =  [] : [x:p | (x,t) <- forest, p <- paths t]
```

现在我们构造一个 list 的 permutation tree，使得这棵树的 full paths 恰好就是给定 list 的所有 permutation：

```haskell
permTree :: Eq a => [a] -> Tree a
permTree xs = EBranch [ (x, permTree(xs \\\ x)) | x <- xs]
  where
    (\\\) :: Eq a => [a] -> a -> [a]
    []     \\\ _   = undefined
    (x:xs) \\\ y
      | x == y     = xs
      | otherwise  = x : (xs \\\ y)
```

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
