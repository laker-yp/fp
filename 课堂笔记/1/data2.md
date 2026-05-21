
# 【BST】 Binary search trees

- [isBST](##isBST)
- [sort](#sort)
- [testing](#Testing)
- [Rose](#Rose-trees)

左子树的每一个node都小于root，右子树大于

<a name="bstops"></a>
## 前情提要
```haskell
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

module Data2 where

import Data1
import System.Random
```
下面这个函数检查一棵 binary tree是否是 BST(低效的方法O(n^2)）
## isBST
```haskell
isBST :: Ord a => BT a -> Bool
isBST Empty        = True
--重点///////////////
isBST (Fork x l r) =    allSmaller x l
                     && allBigger  x r
                     && isBST l
                     && isBST r
--子函数：检查左边的所有node是否都小于一个数x（root）
allSmaller :: Ord a => a -> BT a -> Bool
allSmaller x Empty        = True
allSmaller x (Fork y l r) = y < x   --当前的root比x小
                         && allSmaller x l  -- a && b 意为a通过了就进行b，这里去测左子树了
                         && allSmaller x r
--allBigger同理
```
根据BST的性质，它的 in-order traversal 是一个 sorted list

所以我们先把`t`以in-order遍历成list

然后检查这个list是否为递增

```haskell
isBST' :: Ord a => BT a -> Bool
isBST' t = isIncreasing (treeInOrder t)

isIncreasing :: Ord a => [a] -> Bool
isIncreasing []       = True
isIncreasing (x:[])   = True
--重点///////////
isIncreasing (x:y:zs) = x < y && isIncreasing (y:zs)
```
比如[1,2,3,4,5]先比1,2然后2,3...

**Puzzle**（hard）. 你能不能写出另一个版本的 `isBST`，它也能在 linear time 内运行，但又**不**把 in-order traversal list 作为中间结果显式构造出来？

正如你会记得的，binary search trees 的意义在于：如果它们足够平衡，那么它们就可以被快速搜索O（log n）：

## **occurs**判断某个值是否出现在一棵二叉搜索树里

```haskell
occurs :: Ord a => a -> BT a -> Bool
occurs x Empty        = False
---重点---
occurs x (Fork y l r) = x == y
                     || (x < y && occurs x l) --如果比目标值x小就去L
                     || (x > y && occurs x r)
                                               --||意为满足一个即可
```

## **insert**往BST里插入元素
必须保证插完以后，BST 的顺序性质不能被破坏

```haskell
insert :: Ord a => a -> BT a -> BT a
insert v Empty = Fork v Empty Empty
insert v (Fork x l r)
  | v == x    = Fork x l r            --情况1：插入的node x比当前root小，那就去左边遍历
  | v < x     = Fork x (insert v l) r --直到出现base case比较的目标为Empty了,以x作为node
  | otherwise = Fork x l (insert v r) --要插入的元素已经在树中，那么我们就返回同一棵树
                     
```

### 使用 `Maybe`来insert
Just newTree：表示插入成功，并给出新树
Nothing：表示插入失败，因为元素已经存在

```haskell
insert' :: Ord a => a -> BT a -> Maybe (BT a)
insert' v Empty = Just (Fork v Empty Empty)
insert' v (Fork x l r)
  | v < x = case insert' v l of
              Nothing -> Nothing
              Just l' -> Just (Fork x l' r)

  | v > x = case insert' v r of
              Nothing -> Nothing
              Just r' -> Just (Fork x l r')

  | otherwise = Nothing

先算 insert' v l
如果结果是 Nothing：
    返回 Nothing
如果结果是 Just l'：
    说明成功得到了新的左子树 l'
    返回 Just (Fork x l' r)
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

## **delete**
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

--子函数1：返回一棵 BST 中最大的元素
largestOf :: Ord a => BT a -> a
largestOf Empty            = undefined
---重点---
largestOf (Fork x l Empty) = x  --没有R了，说明本node为MAX
largestOf (Fork x l r)     = largestOf r --如果右子树不空，那最大值还在更右边，于是递归找右子树最大值。

--子函数2：返回“删掉最大元素之后的那棵树
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
  
# sort
## BST sort： quick sort 和 merge sort

当然，正如你已经知道的，你可以利用这个来对 list 排序，但是它会去掉重复元素，因为 binary search trees 不允许重复元素（这一点由我们的 `insert` 和 `inserts` 的定义体现出来）：

```haskell
bstsort :: Ord a => [a] -> [a]
bstsort xs = treeInOrder (inserts xs Empty)
```

一种形式的 quick sort 很容易写出来：

```haskell
qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort [l | l <- xs, l < x] l这个list为xs中全部比x小的元素
            ++ [x]
            ++ qsort [r | r <- xs, r >= x]
```

你可以很容易地修改这个函数，使得结果中的 sorted list 去除重复元素（试试看）。Merge sort 可以定义如下。这里我们把一个 list 分成偶数位置和奇数位置的元素，而不是前一半和后一半，目的是让定义更简单，同时也更高效：

```haskell
--合并两个已经排好序的 list
merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y    = x : merge xs (y:ys) --递归思想，先复制，(x:xs)变成xs，需要处理的x是否需要留下，当然!所以放在前头用:链接
  | otherwise = y : merge (x:xs) ys --每次都对两个list的头进行对比，把小的那个放前头，剩下的继续递归

--把一个 list 拆成两个 list
eosplit :: [a] -> ([a],[a])
eosplit []       = ([],[])
eosplit [x]      = ([x],[])
eosplit (e:o:xs) = case eosplit xs of    --先把剩下的 xs 拆好，再把当前的 e 放进第一组，把当前的 o 放进第二组。
                     (es,os) -> (e:es, o:os)  --case是根据output的形状进行匹配，(es,os)就是一个输出的形状，设为新的临时变量

--msort：递归排序，再 merge 回来
msort :: Ord a => [a] -> [a]
msort xs | length xs <= 1 =  xs
         | otherwise      = merge (msort es) (msort os)  --其实就是把它一直拆开拆到最后一个个元素自己为一个list的时候，进行merge
                            where (es, os) = eosplit xs  --where的作用是对上式的新变量进行说明
```

正如你所知道的，对于已经排好序或者逆序的 list，quick sort 会很慢（quadratic time）

<a name="bsttest"></a>
# Other kinds of trees

<a name="rosetrees"></a>
# Rose trees
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
## **rose大小**
```haskell
rsize :: Rose a -> Integer
rsize (Branch _ ts) = 1 + sum [rsize t | t <- ts]
--                得到的是一个list [1, 3, 1]，要用sum把它加起来
```

它也可以等价地写成：

```haskell
rsize' :: Rose a -> Integer
rsize' (Branch _ ts) = 1 + sum (map rsize' ts)
```
把函数 rsize' 应用到列表 ts 的每个元素上

## **rose 高**
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
rheight (Branch _ ts) = 1 + maximum 0:[rheight t | t <- ts]  --0是为了在[]的时候仍可以计算
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
> **Note:** 术语 "[rose tree](https://en.wikipedia.org/wiki/Rose_tree)" 在 functional programming 中非常常见。在数学和计算机科学的其他领域里，这类树更常被称为 "rooted planar trees" 或者 "rooted ordered trees"。


# Testing

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
=========================================================
## 下面是sort的test
。所以你最好不要去尝试例如：

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

