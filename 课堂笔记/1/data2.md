
## Binary search trees
左子树的每一个node都小于root，右子树大于

<a name="bstops"></a>
### Operations on binary search trees

我们从上一篇 [handout](/files/LectureNotes/Sections/Data1.md) 导入 Haskell 代码：

```haskell
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

module Data2 where

import Data1
import System.Random
```

下面这个函数检查一棵 binary tree是否是 BST
**isBST**
```haskell
isBST :: Ord a => BT a -> Bool
isBST Empty        = True
--/重点///////////////
isBST (Fork x l r) = allSmaller x l
                  && allBigger  x r --测左右与当前root
                  && isBST l --去测左子树
                  && isBST r

--/子函数：检查左边的所有node是否都小于一个数x（在isBST中是root）
allSmaller :: Ord a => a -> BT a -> Bool
allSmaller x Empty        = True
allSmaller x (Fork y l r) = y < x   --/当前的root比x小
                         && allSmaller x l  --/ a && b 意为a通过了就进行b，这里去测左子树了
                         && allSmaller x r

--allBigger同理
```

这不是检查BST性质的高效方法（它运行时间是 quadratic time）n的平方


一种更好的检查 BST 性质的方法（linear time）是先生成它的 in-order traversal。结果表明：一棵树具有 BST 性质，当且仅当它的 in-order traversal 是一个 sorted list

```haskell
isBST' :: Ord a => BT a -> Bool
isBST' t = isIncreasing (treeInOrder t)

isIncreasing :: Ord a => [a] -> Bool
isIncreasing []       = True
isIncreasing (x:[])   = True
--/重点///////////
isIncreasing (x:y:zs) = x < y && isIncreasing (y:zs)
```
比如[1,2,3,4,5]先比1,2然后2,3...

**Puzzle**. 你能不能写出另一个版本的 `isBST`，它也能在 linear time 内运行，但又**不**把 in-order traversal list 作为中间结果显式构造出来？

正如你会记得的，binary search trees 的意义在于：如果它们足够平衡，那么它们就可以被快速搜索O（log n）：

**occurs**

```haskell
occurs :: Ord a => a -> BT a -> Bool
occurs x Empty        = False
---重点---
occurs x (Fork y l r) = x == y
                     || (x < y && occurs x l) --如果比目标值x小就去L
                     || (x > y && occurs x r)
                                               --||意为满足一个即可
```

**insert** —— 往 BST 里插入元素
必须保证插完以后，BST 的顺序性质不能被破坏

```haskell
insert :: Ord a => a -> BT a -> BT a
insert x Empty                    = Fork x Empty Empty
---重点---
insert x (Fork y l r) | x < y     = Fork y (insert x l) r  --情况1：插入的node x比当前root小，那就去左边遍历
                      | x > y     = Fork y l (insert x r)  --同上，直到出现base case 比较的目标为Empty了，以x作为node
                      | otherwise = Fork y l r  --如果要插入的元素已经在树中，那么我们就返回同一棵树
```

其他做法: 使用 `Maybe` return type
Just newTree：表示插入成功，并给出新树
Nothing：表示插入失败，因为元素已经存在

```haskell
insert' :: Ord a => a -> BT a -> Maybe (BT a)
insert' x Empty                    = Just (Fork x Empty Empty)
-----重点---
insert' x (Fork y l r) | x < y     = case insert' x l of
                                       Nothing -> Nothing --说明左子树里插入失败了
                                       Just l' -> Just (Fork y l' r) --说明左子树插入成功，得到新左子树 l'
                                                                     --此时整棵树为:Just (Fork y l' r)
                       | x > y     = case insert' x r of
                                       Nothing -> Nothing
                                       Just r' -> Just (Fork y l r')
                       | otherwise = Nothing
```
例
插入 6：
6 > 5，往右走
到 7
6 < 7，往左走
左边空，插进去
```
    5
   / \
  3   7
     /
    6
```

结果：

这段代码还可以稍微简化一点，因为 `Maybe` 是一个 monad，不过我们之后才会讲到这一点。

**delete**
对于 BST 来说，最难的函数是 deletion：

```haskell
delete :: Ord a => a -> BT a -> BT a
delete x Empty = Empty

delete x (Fork y l r) | x < y                = Fork y (delete x l) r --要删的元素x<当前y，递归删L，然后拼回整棵树
                      | x > y                = Fork y l (delete x r)
                      | x == y && l == Empty = r  --找到了目标，而且左子树空,
                                                  --则当前节点就是要删的节点，并且没有左子树。
                                                  --那删掉它以后，直接用右子树顶上来就行。图解在下面【图解1】
                      | x == y && r == Empty = l
                       --最麻烦:左右子树都存在
                      | otherwise            = Fork (largestOf l) (withoutLargest l) r
                           --                    左子树最大的元素    去除左最大后的左子树  原来的r
子函数1：返回一棵 BST 中最大的元素
largestOf :: Ord a => BT a -> a
largestOf Empty            = undefined
---重点---
largestOf (Fork x l Empty) = x  --没有R了，说明本node为MAX
largestOf (Fork x l r)     = largestOf r --如果右子树不空，那最大值还在更右边，于是递归找右子树最大值。

子函数2：返回“删掉最大元素之后的那棵树
withoutLargest :: Ord a => BT a -> BT a
withoutLargest Empty            = undefined
---重点---
withoutLargest (Fork x l Empty) = l --如果当前node的R为空，那当前node就是最大元素，直接返回本node的L
withoutLargest (Fork x l r)     = Fork x l (withoutLargest r)
--R存在，  那最大值在R。当前node和L保留,       R变成“删去最大值后的右子树”
```
为什么要选“左子树最大值”？
因为如果当前节点是 y：
  左子树所有元素都 < y
  右子树所有元素都 > y
那你找左子树最大值 m，它一定满足：
  m < y
而且 m 已经是左边最大的了
所以左子树剩下的元素都 <= m 的问题不会出现，因为没有重复，实际上都 < m

当然，也可以选右子树最小值然后同样的方法
```
【图解1】
  5  
   \   ->
    8         只剩8，直接顶上去
```
* 你能不能写一个 `delete'` 函数，使用 `Maybe` return type 来表示“没有东西可以删除”？

* 你能不能把最后这两个函数 `largestOf` 和 `withoutLargest` 合并成一个函数，并用 pair type 作为结果，这样就可以得到一个更高效的 delete 函数？然后再进一步结合 `Maybe`，从而避免使用 `undefined`？

<a name="bsttest"></a>
# Other kinds of trees

<a name="rosetrees"></a>
## Rose trees
可理解为**多叉树**
在 binary trees 中有零分支（像 `Empty`）和二分支（像 `Fork`）。
```haskell
data BT a = Empty | Fork a (BT a)(BT a)
```
而在这里，我们可以有任意多个分支，分支数取决于下面定义中 list 的长度：

```haskell
data Rose a = Branch a [Rose a]
--            Branch是一个构造器，表示为当前的node，有两个值根节点a和根节点的subtree列表
```
例：
```haskell
        A
      / | \
     B  C  D
       / \
      E   F
Branch 'A'
  [ Branch 'B' []  --子树列表第一个为B，B的子树列表为[]
  , Branch 'C'     --子树列表第二个为C
      [ Branch 'E' [] --C的子树列表为EF...
      , Branch 'F' []
      ]
  , Branch 'D' []
  ]
```
注意，这里没有 empty rose tree，但是存在一种 rose tree：它有一个 label，同时没有任何 subtree（更准确地说，它的 subtrees 是一个空 list）。例如，rose tree 的 size 可以定义如下，因此它总是一个正数：
**rose大小**
```haskell
rsize :: Rose a -> Integer
rsize (Branch _ ts) = 1 + sum [rsize t | t <- ts]
--       不关心_,ts为子树列表
```

它也可以等价地写成：

```haskell
rsize' :: Rose a -> Integer
rsize' (Branch _ ts) = 1 + sum (map rsize' ts)
```
把函数 rsize' 应用到列表 ts 的每个元素上

**rose 高**
错误示范
```hs
rheight :: Rose a -> Integer
rheight (Branch _ ts) = 1 + maximum [rheight t | t <- ts] -- 错
```
是行不通的，因为空 list 的 maximum ：maximum[]是没有定义的
正确的定义：
```haskell
rheight :: Rose a -> Integer
rheight (Branch _ []) = 0
----重点--------------
rheight (Branch _ ts) = 1 + maximum [rheight t | t <- ts]
```
例子
```
BDEF都是叶子，h=0
        A        A的高度为1+max[0,1,0]=2
      / | \
     B  C  D     C的高度为 1+max[0,0] = 1
       / \
      E   F
```
第二个定义可以这样理解。在一个表达式 `Branch x ts` 中，我们把 `x` 称为 tree 的 root，把 subtrees 的 list `ts` 称为一个 `forest`。那么 forest `ts` 的 height 就是：

`maximum (0 : [rheight' t | t <- ts])`

特别地，如果 `ts` 是空的，那么它的 height 就是 0，这和之前的约定一样。但 `Branch x ts` 的 height 要比 forest `ts` 的 height 多 1，因为还要把 root node `x` 这一层算进去。

> **Note:** 术语 "[rose tree](https://en.wikipedia.org/wiki/Rose_tree)" 在 functional programming 中非常常见。在数学和计算机科学的其他领域里，这类树更常被称为 "rooted planar trees" 或者 "rooted ordered trees"。

<a name="gametrees"></a>
## Game trees

有一个讨论这一节的视频，[available on Canvas](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=369be201-6656-4702-a221-ac6200e86be3)。

假设我们有一个 boards 的 type 和一个 moves 的 type，并且对于任意给定的 board，我们都知道有哪些 possible moves，以及执行每个 move 之后会得到哪个 board。给定一个初始 board，我们就可以构造出一个 game tree，表示所有可能的 play：

```haskell
data GameTree board move = Node board [(move, GameTree board move)] 
					deriving (Show)

gameTree :: (board -> [(move,board)]) -> board -> GameTree board move
gameTree plays board = Node board [(m, gameTree plays b) | (m,b) <- plays board]
```
**第一个输**入为(board -> [(move,board)])也就是plays

plays :: board -> [(move, board)]

        输入一个局面，输出可以走的方式以及对应的局面

  -意思是给你一个局面 board，返回所有合法走法and对应的新局面列表。
  
**第二个输**入为board 也就是初始局面

**输出**：从这个初始局面开始的整棵game tree
[(m, gameTree plays b) | (m,b) <- plays board]

1先调用 plays board

2它会列出所有合法走法 (m,b)

  -m 是这一步怎么走
  -b 是走完后的新局面
3对每个 (m,b)，构造一个分支：
  -边标签是 m
  -子树是从 b 开始继续生成的 game tree

  **建议举例理解**
  
为了让这个更具体一些，我们把它应用到游戏 [Nim](https://en.wikipedia.org/wiki/Nim) 上。
Nim内容在最后面


<a name="ptrees"></a>
## Permutation trees, list permutations, and paths in such trees (hard)

有一个讨论这一节的视频，[available on Canvas](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=f90ddf8c-9d5f-4be6-88f5-ac6200efc923)。

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
## Expression trees

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

### Testing and experimenting with the BST code

学会如何 [test](https://en.wikipedia.org/wiki/Software_testing) 你的代码（检验其 correctness），以及如何对代码进行 experiment（考察其 efficiency），是非常重要的。这一点不仅对这门 module 很重要，对你未来如果想把 software developer 作为职业，也同样非常重要。下面给出一些起步想法，帮助你为这门 module 中你写的代码设计你自己的 tests。最核心的一点是：你要写代码去测试“本来应该为真的东西是否真的成立”，并且测试运行时间。

稍后我们会学到 random monad。现在我们暂时使用一个 infinite list 的 [pseudo random](https://en.wikipedia.org/wiki/Pseudorandomness) integers（需要在 Haskell 文件顶部写 `import System.Random`）：

```haskell
randomInts :: [Int]
randomInts = randomRs (minBound,maxBound) (mkStdGen seed)
             where seed = 42
```

我们可以这样把很多元素插入一棵树中：

```haskell
inserts :: Ord a => [a] -> BT a -> BT a
inserts []     t = t
inserts (x:xs) t = inserts xs (insert x t)
```

然后我们定义测试和 experiment 用的数据：

```haskell
aBigBST :: BT Int
aBigBST = inserts (take (10^6) randomInts) Empty

itsHeight = height aBigBST
itsSize   = size aBigBST
itsBST    = isBST aBigBST
itsBST'   = isBST' aBigBST
```

现在我们在 `ghci` 中这样进行测试和 experiment（实际上，更合理的做法是我们应该专门写一个文件来装这些代码）：

```hs
> :set +s -- ask ghci to print time and space usage
> itsHeight
49
(20.66 secs, 11,618,092,240 bytes)
> itsHeight      -- again
49
(0.01 secs, 0 bytes)  -- fast because it got stored (part of what laziness is)
> itsSize
1000000
(0.50 secs, 248,066,824 bytes) -- fast because the tree is already computed
> itsBST
True
(12.84 secs, 8,691,110,224 bytes) -- slow because of inefficient algorithm
> itsBST'
True
(1.10 secs, 1,198,200,632 bytes) -- the alternative algorithm is much more efficient
>
```

注意，这棵树的 height 并不是最优的（最优应该是 `log2(10^6)`，大约等于 20），但它确实更高（即 49），也就是说，在这棵树上进行 search 最多需要 49 步。尽管如此，search operation 仍然会非常快，即使你要查找的元素其实并不在树中：

```hs
> occurs 17 aBigBST
False
(0.01 secs, 0 bytes)
```

从一棵树中删除很多元素：

```haskell
deletes :: Ord a => [a] -> BT a -> BT a
deletes []     t = t
deletes (x:xs) t = deletes xs (delete x t)
```

删除我们刚才插入进去的一半元素：

```haskell
aSmallerTree :: BT Int
aSmallerTree = deletes (take (5 * (10^5)) randomInts) aBigBST
```

由于 lazy evaluation，这棵树在真正被用到之前是不会被计算出来的。下面这个命令会强制所有 deletion 都被真正执行。

```hs
> height aSmallerTree
45
(8.88 secs, 5,515,246,520 bytes)
```

然后，作为一个 sanity check，我们检验一下 deletion algorithm 是否破坏了 BST 性质：

```hs
> isBST' aSmallerTree
True
(0.52 secs, 583,510,072 bytes)
```

很好。

```haskell
evenBigger :: BT Int
evenBigger = inserts (take (10^7) randomInts) Empty
```

糟糕：

```hs
> height evenBigger
*** Exception: stack overflow
```

你可以在运行 ghci 时使用一个选项来增加 stack 的大小：

```hs
$  ghci data.hs +RTS -K1G -RTS
GHCi, version 8.0.2: http://www.haskell.org/ghc/  :? for help
[1 of 1] Compiling Main             ( data.hs, interpreted )
Ok, modules loaded: Main.
> :set +s
> height evenBigger
58
(269.24 secs, 134,999,934,888 bytes)
> 269.24 / 60
4.487333333333334
>
```

这意味着在我的机器上大约需要 4.49 分钟。但是，一旦这棵树第一次被计算出来，它就会保持已经计算好的状态，因此例如我们会得到：

```hs
> height evenBigger
58
(4.24 secs, 2,506,734,080 bytes)
> occurs 17 evenBigger
False
(0.01 secs, 92,952 bytes) -- magic? :-)
```

如果在刚加载文件之后、这棵树还没有被计算出来之前，就立刻执行最后这个表达式，那么它会花很长时间：

```hs
> isBST' evenBigger
True
(15.38 secs, 13,271,069,712 bytes)
```

所以我们得到了一棵有 10,000,000 个元素的 BST，它的 height 是 58，因此它仍然可以被快速搜索。我们还可以很容易地得到更大的树。现在考虑：

```haskell
fullBST :: Integer -> Integer -> BT Integer
fullBST x y | x == y    = Fork x Empty Empty
            | x+1 == y  = Fork y (Fork x Empty Empty) Empty
            | x+1 <  y  = Fork m (fullBST x (m-1)) (fullBST (m+1) y)
            | otherwise = undefined
  where m = (x + y) `div` 2
```

这个函数做了什么？你应该说服自己：如果 `x<=y`，那么 `treeInOrder (fullBST x y) = [x..y]`。例如：

```hs
    treeInOrder (fullBST 2 11) = [2,3,4,5,6,7,8,9,10,11]
```

在下面这些表达式里，由于树没有被绑定到某个变量上，因此每一次都会重新计算（当然，只会按“需要的程度”去计算）同一棵树：

```hs
> occurs 17 (fullBST 1 (10^8))
True
(0.01 secs, 0 bytes)
> occurs 17 (delete 17 (fullBST 1 (10^8)))
False
(0.01 secs, 0 bytes)
> height (fullBST 1 (10^8))
27
(123.90 secs, 63,316,811,920 bytes)
> 123.90 / 60
2.065
```

这大约是两分钟。要判断 17 在不在上面的树里，其实并不需要把整棵树都构造出来（因为 Haskell 是 lazy 的），所以这就是为什么这个操作比计算 height 更快。

最后：

```hs
> deletes (take (10^5) randomInts) (inserts (take (10^5) randomInts) Empty)
Empty
(2.74 secs, 1,686,246,488 bytes)
> deletes (take (10^6) randomInts) (inserts (take (10^6) randomInts) Empty)
Empty
(42.25 secs, 20,813,980,136 bytes)
```

<a name="bstsort"></a>
### BST sort, quick sort and merge sort

当然，正如你已经知道的，你可以利用这个来对 list 排序，但是它会去掉重复元素，因为 binary search trees 不允许重复元素（这一点由我们的 `insert` 和 `inserts` 的定义体现出来）：

```haskell
bstsort :: Ord a => [a] -> [a]
bstsort xs = treeInOrder (inserts xs Empty)
```

一种形式的 quick sort 很容易写出来：

```haskell
qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort [l | l <- xs, l < x]
            ++ [x]
            ++ qsort [r | r <- xs, r >= x]
```

你可以很容易地修改这个函数，使得结果中的 sorted list 去除重复元素（试试看）。Merge sort 可以定义如下。这里我们把一个 list 分成偶数位置和奇数位置的元素，而不是前一半和后一半，目的是让定义更简单，同时也更高效：

```haskell
merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y    = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys

eosplit :: [a] -> ([a],[a])
eosplit []       = ([],[])
eosplit [x]      = ([x],[])
eosplit (e:o:xs) = case eosplit xs of
                     (es,os) -> (e:es, o:os)

msort :: Ord a => [a] -> [a]
msort xs | length xs <= 1 =  xs
         | otherwise      = merge (msort es) (msort os)
                            where (es, os) = eosplit xs
```

正如你所知道的，对于已经排好序或者逆序的 list，quick sort 会很慢（quadratic time）。所以你最好不要去尝试例如：

```hs
    sum (qsort [1..(10^5)])
```

因为它将花费 `(10^5)^2` 步，也就是 `10^10`，即 100 亿步。`bstsort` 也会发生同样的事情。不过，对于 random lists，它们的表现会更好，其中 `qsort` 会比 `bstsort` 更快。回忆一下，`msort` 始终都是 `n * log n`。为了简洁起见（这些 notes 已经够长了），我们没有测试 `msort`，不过你完全可以自己做这些实验。

```haskell
bigList  = take (10^5) randomInts
hugeList = take (10^6) randomInts
```

我们这样测试：

```hs
> length bigList
100000
(0.02 secs, 4,522,952 bytes)
> length (qsort bigList )
100000
(1.71 secs, 465,819,512 bytes)
> length (bstsort bigList )
100000
(2.45 secs, 1,013,907,712 bytes)
> length hugeList
1000000
(0.02 secs, 0 bytes)
> length (qsort hugeList)
1000000
(21.94 secs, 7,578,153,768 bytes)
> length (bstsort hugeList)
1000000
(37.34 secs, 12,514,195,728 bytes)
> qsort hugeList == bstsort hugeList
True
(58.45 secs, 18,272,526,856 bytes)
>
```

你也许会想自己去对 merge sort 做一些测试和实验。

<a name="moretrees"></a>

还有一种 *update syntax*：例如，如果 `p` 是一个 point，那么 `p {pointx = 2}` 就表示一个新的 point，其中 field `pointx` 被替换成了 `2`，而 `pointy` field 保持不变。

------------------nim-----------------
在这个例子里，"board" 是若干 heap 组成的集合。由于只有数量重要，所以我们把它表示成一个 `Integer` list。一个 move 则表示为：选择某个 heap，并移除若干个对象，因此我们把它表示成一个 pair：一个 `Int`（heap 的索引）和一个 `Integer`（要移除的对象个数）：

```haskell
type NimBoard = [Integer]
data NimMove = Remove Int Integer  deriving (Show,Eq)
```

下面这个 `plays` 函数描述了：从给定 Nim position 出发，所有合法的 moves：

```haskell
nimPlays :: NimBoard -> [(NimMove,NimBoard)]
nimPlays heaps = [(Remove i k, (hs ++ h-k : hs'))
                 | i <- [0..length heaps-1],
                   let (hs, h:hs') = splitAt i heaps,
                   k <- [1..h]]
```

把它作为 `gameTree` 的第一个参数传进去，我们就可以计算从某个给定 Nim position 出发的整个 game tree：

```haskell
nim :: [Integer] -> GameTree NimBoard NimMove
nim = gameTree nimPlays
```

（注意，这个定义是 "[point-free](https://wiki.haskell.org/Pointfree)" 的，而且我们只对函数 `gameTree` 做了部分应用。上面的定义和 `nim initHeaps = gameTree nimPlays initHeaps` 完全等价，只是更简洁。）

我们用 Nim 试一试：

```hs
> nim [2]
Node [2] [(Remove 0 1,Node [1] [(Remove 0 1,Node [0] [])]),(Remove 0 2,Node [0] [])]
> nim [2,1]
Node [2,1] [(Remove 0 1,Node [1,1] [(Remove 0 1,Node [0,1] [(Remove 1 1,Node [0,0] [])]),(Remove 1 1,Node [1,0] [(Remove 0 1,Node [0,0] [])])]),(Remove 0 2,Node [0,1] [(Remove 1 1,Node [0,0] [])]),(Remove 1 1,Node [2,0] [(Remove 0 1,Node [1,0] [(Remove 0 1,Node [0,0] [])]),(Remove 0 2,Node [0,0] [])])]
> nim [1,1,1]
Node [1,1,1] [(Remove 0 1,Node [0,1,1] [(Remove 1 1,Node [0,0,1] [(Remove 2 1,Node [0,0,0] [])]),(Remove 2 1,Node [0,1,0] [(Remove 1 1,Node [0,0,0] [])])]),(Remove 1 1,Node [1,0,1] [(Remove 0 1,Node [0,0,1] [(Remove 2 1,Node [0,0,0] [])]),(Remove 2 1,Node [1,0,0] [(Remove 0 1,Node [0,0,0] [])])]),(Remove 2 1,Node [1,1,0] [(Remove 0 1,Node [0,1,0] [(Remove 1 1,Node [0,0,0] [])]),(Remove 1 1,Node [1,0,0] [(Remove 0 1,Node [0,0,0] [])])])]
```

Nim 通常作为一个 two-player game 在 ["misère"](https://en.wikipedia.org/wiki/Mis%C3%A8re) 规则下进行：第一个**不能**走的人获胜；但它也可以按普通 two-player game 规则玩：第一个**不能**走的人失败。对于某个给定 position，先手是否有 *winning strategy*，这个问题完全可以封装进 game trees 的逻辑之中。

```haskell
isWinning, isLosing :: Bool -> GameTree board move -> Bool
isWinning isMisere (Node b mgs)
        | null mgs  = isMisere
        | otherwise = any (isLosing isMisere)  [g | (m,g) <- mgs]
isLosing  isMisere (Node b mgs)
        | null mgs  = not (isMisere)
        | otherwise = all (isWinning isMisere) [g | (m,g) <- mgs]
```

试试看：

```hs
> isWinning True (nim [2])
True
> isWinning True (nim [2,1])
True
> isWinning True (nim [1,1,1])
False
> isWinning False (nim [1,1,1])
True
```

当然，这一切都还值得进一步讨论。不过在这份 notes 中，我们只是想借此说明：这又是另一类我们可能想在 Haskell 中定义和操作的 tree，也更一般地说明，在 functional 或 non-functional programming 中，我们都可能会碰到这种 tree。
