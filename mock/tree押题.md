# Haskell 线下编程押题模板整理

> 重点：Tree / List / Predicate / Transformer / Aggregator 题型  
> 使用方式：考前直接背模板，不需要逐句解释。

---

## 目录

- [1. 带显式叶子的 Rose Tree](#1-rose-tree-with-explicit-leaves)
  - [1.1 判断是否每个分支都有 n 个孩子：isNBranching](#11-isnbranching)
  - [1.2 剪枝：prune](#12-prune)
  - [1.3 判断是否每个分支最多有 n 个孩子：isAtMostNBranching](#13-isatmostnbranching)
  - [1.4 判断是否每个分支至少有 n 个孩子：isAtLeastNBranching](#14-isatleastnbranching)
  - [1.5 判断是否没有空分支：noEmptyBranches](#15-noemptybranches)
  - [1.6 统计叶子数量：countLeaves](#16-countleaves)
  - [1.7 统计分支数量：countBranches](#17-countbranches)
  - [1.8 统计 Rose Tree 总大小：sizeRose](#18-sizerose)
  - [1.9 计算 Rose Tree 高度：heightRose](#19-heightrose)
  - [1.10 收集所有叶子值：leaves](#110-leaves)
  - [1.11 判断元素是否出现：occursRose](#111-occursrose)
  - [1.12 对所有叶子值做映射：mapRose](#112-maprose)
  - [1.13 镜像 Rose Tree：mirrorRose](#113-mirrorrose)
  - [1.14 按深度裁剪：trimDepth](#114-trimdepth)
  - [1.15 删除空分支：removeEmptyBranches](#115-removeemptybranches)
- [2. Binary Tree 二叉树](#2-binary-tree)
  - [2.1 统计节点数量：sizeBT](#21-sizebt)
  - [2.2 计算高度：heightBT](#22-heightbt)
  - [2.3 判断元素是否出现：occursBT](#23-occursbt)
  - [2.4 镜像二叉树：mirrorBT](#24-mirrorbt)
  - [2.5 中序遍历：inorder](#25-inorder)
  - [2.6 前序遍历：preorder](#26-preorder)
  - [2.7 后序遍历：postorder](#27-postorder)
  - [2.8 对所有节点做映射：mapBT](#28-mapbt)
  - [2.9 判断所有节点是否满足条件：allBT](#29-allbt)
  - [2.10 判断是否存在节点满足条件：anyBT](#210-anybt)
  - [2.11 简单判断是否平衡：isBalancedSimple](#211-isbalancedsimple)
  - [2.12 统计某一深度的节点数量：countNodesAtDepth](#212-countnodesatdepth)
- [3. Binary Search Tree 二叉搜索树](#3-binary-search-tree)
  - [3.1 插入元素：insertBST](#31-insertbst)
  - [3.2 查找元素：occursBST](#32-occursbst)
  - [3.3 判断是否是 BST：isBST](#33-isbst)
  - [3.4 找最大值：largest](#34-largest)
  - [3.5 删除最大值：deleteLargest](#35-deletelargest)
- [4. 叶子带值的二叉树 BinL](#4-leaf-labelled-binary-tree)
  - [4.1 显示树结构：showBin](#41-showbin)
  - [4.2 统计叶子数量：countLf](#42-countlf)
  - [4.3 对叶子值做映射：mapBinL](#43-mapbinl)
  - [4.4 计算深度：depthBinL](#44-depthbinl)
- [5. Expression Tree 表达式树](#5-expression-tree)
  - [5.1 计算表达式值：evalExpr](#51-evalexpr)
  - [5.2 统计表达式大小：sizeExpr](#52-sizeexpr)
  - [5.3 简单显示表达式：showExprSimple](#53-showexprsimple)
  - [5.4 映射表达式中的值：mapValuesExpr](#54-mapvaluesexpr)
- [6. List Predicate 列表判断题型](#6-list-predicate-题型)
  - [6.1 判断所有元素满足条件：all'](#61-all)
  - [6.2 判断是否存在元素满足条件：any'](#62-any)
  - [6.3 判断列表是否有序：isSorted](#63-issorted)
  - [6.4 判断所有元素是否相等：allEqual](#64-allequal)
  - [6.5 判断是否有重复元素：containsDuplicate](#65-containsduplicate)
- [7. List Transformer 列表变换题型](#7-list-transformer-题型)
  - [7.1 自己实现 map：map'](#71-map)
  - [7.2 自己实现 filter：filter'](#72-filter)
  - [7.3 自己实现 take：take'](#73-take)
  - [7.4 自己实现 drop：drop'](#74-drop)
  - [7.5 删除第一个匹配元素：removeFirst](#75-removefirst)
  - [7.6 删除所有匹配元素：removeAll](#76-removeall)
  - [7.7 每 n 个元素切分一次：splitEveryN](#77-spliteveryn)
- [8. List Aggregator 列表聚合题型](#8-list-aggregator-题型)
  - [8.1 自己实现 sum：sum'](#81-sum)
  - [8.2 自己实现 product：product'](#82-product)
  - [8.3 自己实现 length：length'](#83-length)
  - [8.4 自己实现 concat：concat'](#84-concat)
  - [8.5 安全求最大值：maximumMaybe](#85-maximummaybe)
- [9. Maybe / Either 题型](#9-maybe--either-题型)
  - [9.1 安全取头元素：safeHead](#91-safehead)
  - [9.2 安全取尾部：safeTail](#92-safetail)
  - [9.3 安全 take：takeMaybe](#93-takemaybe)
  - [9.4 安全 zip：zipEither](#94-zipeither)
  - [9.5 安全查找：lookupMaybe](#95-lookupmaybe)
- [10. Game Tree / General Tree 模板](#10-game-tree--general-tree-模板)
  - [10.1 GameTree 类型定义](#101-gametree-type)
  - [10.2 统计 GameTree 大小：treeSizeGT](#102-treesizegt)
  - [10.3 计算 GameTree 深度：treeDepthGT](#103-treedepthgt)
  - [10.4 收集所有路径：allPathsGT](#104-allpathsgt)
- [11. 考场万能模板](#11-考场万能模板)
---

# 1. Rose Tree with Explicit Leaves

```haskell
data Rose a = Leaf a
            | Branch [Rose a]
```

---

## 1.1 isNBranching

```haskell
isNBranching :: Int -> Rose a -> Bool
isNBranching n (Leaf _) = True
isNBranching n (Branch xs) =
  length xs == n && all (isNBranching n) xs
```

笨写法：

```haskell
isNBranching :: Int -> Rose a -> Bool
isNBranching n (Leaf _) = True
isNBranching n (Branch xs) =
  length xs == n && and [isNBranching n x | x <- xs]
```

---

## 1.2 prune

```haskell
prune :: Int -> Rose a -> Rose a
prune n (Leaf x) = Leaf x
prune n (Branch xs) =
  Branch [prune n x | x <- take n xs]
```

或者：

```haskell
prune :: Int -> Rose a -> Rose a
prune n (Leaf x) = Leaf x
prune n (Branch xs) =
  Branch (map (prune n) (take n xs))
```

---

## 1.3 isAtMostNBranching

```haskell
isAtMostNBranching :: Int -> Rose a -> Bool
isAtMostNBranching n (Leaf _) = True
isAtMostNBranching n (Branch xs) =
  length xs <= n && all (isAtMostNBranching n) xs
```

---

## 1.4 isAtLeastNBranching

```haskell
isAtLeastNBranching :: Int -> Rose a -> Bool
isAtLeastNBranching n (Leaf _) = True
isAtLeastNBranching n (Branch xs) =
  length xs >= n && all (isAtLeastNBranching n) xs
```

---

## 1.5 noEmptyBranches

```haskell
noEmptyBranches :: Rose a -> Bool
noEmptyBranches (Leaf _) = True
noEmptyBranches (Branch xs) =
  not (null xs) && all noEmptyBranches xs
```

---

## 1.6 countLeaves

```haskell
countLeaves :: Rose a -> Int
countLeaves (Leaf _) = 1
countLeaves (Branch xs) =
  sum [countLeaves x | x <- xs]
```

---

## 1.7 countBranches

```haskell
countBranches :: Rose a -> Int
countBranches (Leaf _) = 0
countBranches (Branch xs) =
  1 + sum [countBranches x | x <- xs]
```

---

## 1.8 sizeRose

```haskell
sizeRose :: Rose a -> Int
sizeRose (Leaf _) = 1
sizeRose (Branch xs) =
  1 + sum [sizeRose x | x <- xs]
```

---

## 1.9 heightRose

版本 A：Leaf 高度为 0。

```haskell
heightRose :: Rose a -> Int
heightRose (Leaf _) = 0
heightRose (Branch []) = 1
heightRose (Branch xs) =
  1 + maximum [heightRose x | x <- xs]
```

版本 B：Leaf 高度为 1。

```haskell
heightRose :: Rose a -> Int
heightRose (Leaf _) = 1
heightRose (Branch []) = 1
heightRose (Branch xs) =
  1 + maximum [heightRose x | x <- xs]
```

---

## 1.10 leaves

```haskell
leaves :: Rose a -> [a]
leaves (Leaf x) = [x]
leaves (Branch xs) =
  concat [leaves x | x <- xs]
```

---

## 1.11 occursRose

```haskell
occursRose :: Eq a => a -> Rose a -> Bool
occursRose y (Leaf x) = y == x
occursRose y (Branch xs) =
  any (occursRose y) xs
```

笨写法：

```haskell
occursRose :: Eq a => a -> Rose a -> Bool
occursRose y (Leaf x) = y == x
occursRose y (Branch xs) =
  or [occursRose y x | x <- xs]
```

---

## 1.12 mapRose

```haskell
mapRose :: (a -> b) -> Rose a -> Rose b
mapRose f (Leaf x) = Leaf (f x)
mapRose f (Branch xs) =
  Branch [mapRose f x | x <- xs]
```

---

## 1.13 mirrorRose

```haskell
mirrorRose :: Rose a -> Rose a
mirrorRose (Leaf x) = Leaf x
mirrorRose (Branch xs) =
  Branch [mirrorRose x | x <- reverse xs]
```

---

## 1.14 trimDepth

```haskell
trimDepth :: Int -> Rose a -> Rose a
trimDepth _ (Leaf x) = Leaf x
trimDepth 0 (Branch xs) = Branch []
trimDepth n (Branch xs) =
  Branch [trimDepth (n-1) x | x <- xs]
```

---

## 1.15 removeEmptyBranches

```haskell
removeEmptyBranches :: Rose a -> Rose a
removeEmptyBranches (Leaf x) = Leaf x
removeEmptyBranches (Branch xs) =
  Branch [removeEmptyBranches x | x <- xs, not (isEmptyBranch x)]
  where
    isEmptyBranch (Branch []) = True
    isEmptyBranch _           = False
```

---

# 2. Binary Tree

```haskell
data BinTree a = Empty
               | Node (BinTree a) a (BinTree a)
               deriving (Eq, Show)
```

---

## 2.1 sizeBT

```haskell
sizeBT :: BinTree a -> Int
sizeBT Empty = 0
sizeBT (Node l x r) =
  1 + sizeBT l + sizeBT r
```

---

## 2.2 heightBT

```haskell
heightBT :: BinTree a -> Int
heightBT Empty = 0
heightBT (Node l x r) =
  1 + max (heightBT l) (heightBT r)
```

---

## 2.3 occursBT

```haskell
occursBT :: Eq a => a -> BinTree a -> Bool
occursBT y Empty = False
occursBT y (Node l x r) =
  y == x || occursBT y l || occursBT y r
```

---

## 2.4 mirrorBT

```haskell
mirrorBT :: BinTree a -> BinTree a
mirrorBT Empty = Empty
mirrorBT (Node l x r) =
  Node (mirrorBT r) x (mirrorBT l)
```

---

## 2.5 inorder

```haskell
inorder :: BinTree a -> [a]
inorder Empty = []
inorder (Node l x r) =
  inorder l ++ [x] ++ inorder r
```

---

## 2.6 preorder

```haskell
preorder :: BinTree a -> [a]
preorder Empty = []
preorder (Node l x r) =
  [x] ++ preorder l ++ preorder r
```

---

## 2.7 postorder

```haskell
postorder :: BinTree a -> [a]
postorder Empty = []
postorder (Node l x r) =
  postorder l ++ postorder r ++ [x]
```

---

## 2.8 mapBT

```haskell
mapBT :: (a -> b) -> BinTree a -> BinTree b
mapBT f Empty = Empty
mapBT f (Node l x r) =
  Node (mapBT f l) (f x) (mapBT f r)
```

---

## 2.9 allBT

```haskell
allBT :: (a -> Bool) -> BinTree a -> Bool
allBT p Empty = True
allBT p (Node l x r) =
  p x && allBT p l && allBT p r
```

---

## 2.10 anyBT

```haskell
anyBT :: (a -> Bool) -> BinTree a -> Bool
anyBT p Empty = False
anyBT p (Node l x r) =
  p x || anyBT p l || anyBT p r
```

---

## 2.11 isBalancedSimple

```haskell
isBalancedSimple :: BinTree a -> Bool
isBalancedSimple Empty = True
isBalancedSimple (Node l x r) =
  abs (heightBT l - heightBT r) <= 1
  && isBalancedSimple l
  && isBalancedSimple r
```

---

## 2.12 countNodesAtDepth

```haskell
countNodesAtDepth :: Int -> BinTree a -> Int
countNodesAtDepth n Empty = 0
countNodesAtDepth 0 (Node l x r) = 1
countNodesAtDepth n (Node l x r) =
  countNodesAtDepth (n-1) l + countNodesAtDepth (n-1) r
```

---

# 3. Binary Search Tree

```haskell
data BST a = E
           | T (BST a) a (BST a)
           deriving (Eq, Show)
```

---

## 3.1 insertBST

```haskell
insertBST :: Ord a => a -> BST a -> BST a
insertBST y E = T E y E
insertBST y (T l x r)
  | y < x     = T (insertBST y l) x r
  | y > x     = T l x (insertBST y r)
  | otherwise = T l x r
```

---

## 3.2 occursBST

```haskell
occursBST :: Ord a => a -> BST a -> Bool
occursBST y E = False
occursBST y (T l x r)
  | y == x    = True
  | y < x     = occursBST y l
  | otherwise = occursBST y r
```

---

## 3.3 isBST

```haskell
isBST :: Ord a => BST a -> Bool
isBST t = isSorted (inorderBST t)
  where
    inorderBST E = []
    inorderBST (T l x r) = inorderBST l ++ [x] ++ inorderBST r

    isSorted [] = True
    isSorted [_] = True
    isSorted (x:y:xs) = x < y && isSorted (y:xs)
```

---

## 3.4 largest

```haskell
largest :: BST a -> Maybe a
largest E = Nothing
largest (T l x E) = Just x
largest (T l x r) = largest r
```

---

## 3.5 deleteLargest

```haskell
deleteLargest :: BST a -> BST a
deleteLargest E = E
deleteLargest (T l x E) = l
deleteLargest (T l x r) = T l x (deleteLargest r)
```

---

# 4. Leaf-labelled Binary Tree

```haskell
data BinL a = Lf a
            | Nd (BinL a) (BinL a)
            deriving (Eq, Show)
```

---

## 4.1 showBin

```haskell
showBin :: Show a => BinL a -> String
showBin (Lf x) = "(" ++ show x ++ ")"
showBin (Nd l r) =
  "(" ++ showBin l ++ showBin r ++ ")"
```

---

## 4.2 countLf

```haskell
countLf :: BinL a -> Int
countLf (Lf _) = 1
countLf (Nd l r) =
  countLf l + countLf r
```

---

## 4.3 mapBinL

```haskell
mapBinL :: (a -> b) -> BinL a -> BinL b
mapBinL f (Lf x) = Lf (f x)
mapBinL f (Nd l r) =
  Nd (mapBinL f l) (mapBinL f r)
```

---

## 4.4 depthBinL

```haskell
depthBinL :: BinL a -> Int
depthBinL (Lf _) = 0
depthBinL (Nd l r) =
  1 + max (depthBinL l) (depthBinL r)
```

---

# 5. Expression Tree

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          | Neg Expr
          deriving (Eq, Show)
```

---

## 5.1 evalExpr

```haskell
evalExpr :: Expr -> Int
evalExpr (Val n) = n
evalExpr (Add e1 e2) = evalExpr e1 + evalExpr e2
evalExpr (Mul e1 e2) = evalExpr e1 * evalExpr e2
evalExpr (Neg e) = negate (evalExpr e)
```

---

## 5.2 sizeExpr

```haskell
sizeExpr :: Expr -> Int
sizeExpr (Val _) = 1
sizeExpr (Add e1 e2) = 1 + sizeExpr e1 + sizeExpr e2
sizeExpr (Mul e1 e2) = 1 + sizeExpr e1 + sizeExpr e2
sizeExpr (Neg e) = 1 + sizeExpr e
```

---

## 5.3 showExprSimple

```haskell
showExprSimple :: Expr -> String
showExprSimple (Val n) = show n
showExprSimple (Add e1 e2) =
  "(" ++ showExprSimple e1 ++ "+" ++ showExprSimple e2 ++ ")"
showExprSimple (Mul e1 e2) =
  "(" ++ showExprSimple e1 ++ "*" ++ showExprSimple e2 ++ ")"
showExprSimple (Neg e) =
  "-" ++ showExprSimple e
```

---

## 5.4 mapValuesExpr

```haskell
mapValuesExpr :: (Int -> Int) -> Expr -> Expr
mapValuesExpr f (Val n) = Val (f n)
mapValuesExpr f (Add e1 e2) =
  Add (mapValuesExpr f e1) (mapValuesExpr f e2)
mapValuesExpr f (Mul e1 e2) =
  Mul (mapValuesExpr f e1) (mapValuesExpr f e2)
mapValuesExpr f (Neg e) =
  Neg (mapValuesExpr f e)
```

---

# 6. List Predicate 题型

---

## 6.1 all'

```haskell
all' :: (a -> Bool) -> [a] -> Bool
all' p [] = True
all' p (x:xs) =
  p x && all' p xs
```

---

## 6.2 any'

```haskell
any' :: (a -> Bool) -> [a] -> Bool
any' p [] = False
any' p (x:xs) =
  p x || any' p xs
```

---

## 6.3 isSorted

```haskell
isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [_] = True
isSorted (x:y:xs) =
  x <= y && isSorted (y:xs)
```

---

## 6.4 allEqual

```haskell
allEqual :: Eq a => [a] -> Bool
allEqual [] = True
allEqual [_] = True
allEqual (x:y:xs) =
  x == y && allEqual (y:xs)
```

---

## 6.5 containsDuplicate

```haskell
containsDuplicate :: Eq a => [a] -> Bool
containsDuplicate [] = False
containsDuplicate (x:xs) =
  x `elem` xs || containsDuplicate xs
```

---

# 7. List Transformer 题型

---

## 7.1 map'

```haskell
map' :: (a -> b) -> [a] -> [b]
map' f [] = []
map' f (x:xs) =
  f x : map' f xs
```

---

## 7.2 filter'

```haskell
filter' :: (a -> Bool) -> [a] -> [a]
filter' p [] = []
filter' p (x:xs)
  | p x       = x : filter' p xs
  | otherwise = filter' p xs
```

---

## 7.3 take'

```haskell
take' :: Int -> [a] -> [a]
take' 0 xs = []
take' n [] = []
take' n (x:xs) =
  x : take' (n-1) xs
```

---

## 7.4 drop'

```haskell
drop' :: Int -> [a] -> [a]
drop' 0 xs = xs
drop' n [] = []
drop' n (x:xs) =
  drop' (n-1) xs
```

---

## 7.5 removeFirst

```haskell
removeFirst :: Eq a => a -> [a] -> [a]
removeFirst y [] = []
removeFirst y (x:xs)
  | y == x    = xs
  | otherwise = x : removeFirst y xs
```

---

## 7.6 removeAll

```haskell
removeAll :: Eq a => a -> [a] -> [a]
removeAll y [] = []
removeAll y (x:xs)
  | y == x    = removeAll y xs
  | otherwise = x : removeAll y xs
```

---

## 7.7 splitEveryN

```haskell
splitEveryN :: Int -> [a] -> [[a]]
splitEveryN n [] = []
splitEveryN n xs =
  take n xs : splitEveryN n (drop n xs)
```

---

# 8. List Aggregator 题型

---

## 8.1 sum'

```haskell
sum' :: Num a => [a] -> a
sum' [] = 0
sum' (x:xs) =
  x + sum' xs
```

---

## 8.2 product'

```haskell
product' :: Num a => [a] -> a
product' [] = 1
product' (x:xs) =
  x * product' xs
```

---

## 8.3 length'

```haskell
length' :: [a] -> Int
length' [] = 0
length' (x:xs) =
  1 + length' xs
```

---

## 8.4 concat'

```haskell
concat' :: [[a]] -> [a]
concat' [] = []
concat' (xs:xss) =
  xs ++ concat' xss
```

---

## 8.5 maximumMaybe

```haskell
maximumMaybe :: Ord a => [a] -> Maybe a
maximumMaybe [] = Nothing
maximumMaybe [x] = Just x
maximumMaybe (x:xs) =
  case maximumMaybe xs of
    Nothing -> Just x
    Just y  -> Just (max x y)
```

---

# 9. Maybe / Either 题型

---

## 9.1 safeHead

```haskell
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:xs) = Just x
```

---

## 9.2 safeTail

```haskell
safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (x:xs) = Just xs
```

---

## 9.3 takeMaybe

```haskell
takeMaybe :: Int -> [a] -> Maybe [a]
takeMaybe 0 xs = Just []
takeMaybe n [] = Nothing
takeMaybe n (x:xs) =
  case takeMaybe (n-1) xs of
    Nothing -> Nothing
    Just ys -> Just (x:ys)
```

---

## 9.4 zipEither

```haskell
zipEither :: [a] -> [b] -> Either String [(a,b)]
zipEither [] [] = Right []
zipEither [] ys = Left "first list too short"
zipEither xs [] = Left "second list too short"
zipEither (x:xs) (y:ys) =
  case zipEither xs ys of
    Left err -> Left err
    Right zs -> Right ((x,y):zs)
```

---

## 9.5 lookupMaybe

```haskell
lookupMaybe :: Eq a => a -> [(a,b)] -> Maybe b
lookupMaybe key [] = Nothing
lookupMaybe key ((k,v):xs)
  | key == k  = Just v
  | otherwise = lookupMaybe key xs
```

---

# 10. Game Tree / General Tree 模板

---

## 10.1 GameTree type

```haskell
data GameTree board move = Node board [(move, GameTree board move)]
  deriving (Eq, Show)
```

---

## 10.2 treeSizeGT

```haskell
treeSizeGT :: GameTree board move -> Int
treeSizeGT (Node b xs) =
  1 + sum [treeSizeGT t | (m,t) <- xs]
```

---

## 10.3 treeDepthGT

```haskell
treeDepthGT :: GameTree board move -> Int
treeDepthGT (Node b []) = 0
treeDepthGT (Node b xs) =
  1 + maximum [treeDepthGT t | (m,t) <- xs]
```

---

## 10.4 allPathsGT

```haskell
allPathsGT :: GameTree board move -> [[move]]
allPathsGT (Node b []) = [[]]
allPathsGT (Node b xs) =
  [m:path | (m,t) <- xs, path <- allPathsGT t]
```

---

# 11. 考场万能模板

## Predicate：every / all 类型

```haskell
f (Leaf _) = True
f (Branch xs) =
  当前条件 && all f xs
```

带参数：

```haskell
f n (Leaf _) = True
f n (Branch xs) =
  当前条件 && all (f n) xs
```

---

## Predicate：exists / any 类型

```haskell
f target (Leaf x) = target == x
f target (Branch xs) =
  any (f target) xs
```

---

## Transformer：返回同类型 Tree

```haskell
g (Leaf x) = Leaf x
g (Branch xs) =
  Branch [g x | x <- xs]
```

带参数：

```haskell
g n (Leaf x) = Leaf x
g n (Branch xs) =
  Branch [g n x | x <- 修改 xs]
```

---

## Aggregator：返回 Int

```haskell
f (Leaf _) = 基础数字
f (Branch xs) =
  combine [f x | x <- xs]
```

常见 combine：

```haskell
sum
maximum
minimum
length
```

---

## Aggregator：返回 List

```haskell
f (Leaf x) = [x]
f (Branch xs) =
  concat [f x | x <- xs]
```

---

## Binary Tree 模板

```haskell
f Empty = base
f (Node l x r) =
  combine x (f l) (f r)
```

---

## List 模板

```haskell
f [] = base
f (x:xs) =
  use x and f xs
```

---

## 带 n 的递归模板

当 `n` 变小：

```haskell
f 0 xs = base
f n [] = base
f n (x:xs) =
  ... f (n-1) xs ...
```

当 `n` 不变，只是条件参数：

```haskell
f n (Leaf _) = base
f n (Branch xs) =
  condition n xs && all (f n) xs
```

---

## all / any / and / or 速记

```haskell
all p xs == and [p x | x <- xs]
any p xs == or  [p x | x <- xs]
```

```haskell
and [] == True
or  [] == False
```

---

## 最常用括号

```haskell
all (isNBranching n) xs
any (occursRose y) xs
map (prune n) xs
map (mapRose f) xs
```

---

## 考场检查顺序

1. 先写 type signature
2. 看 data constructors
3. 每个 constructor 写一个 pattern
4. 递归对象是谁，就对谁变小
5. Bool 用 `all` / `any`
6. Int 用 `sum` / `maximum`
7. List 用 `concat`
8. Tree transformer 用 `map` 或 list comprehension


