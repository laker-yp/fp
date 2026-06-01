# Haskell Tree / Rose Tree 押题强化版（A/B/C 分区更多预测）

> 版本：加强版  
> 范围：Tree / Rose Tree / Binary Tree / BST / Address  
> 难度：主要对齐 Mock Question 1，也加入少量略高一档的变体。  
> 要求：只给 **标题 + 类型 + 答案**，不写长解析。  
> 排序：A 区最高命中，B 区中高命中，C 区拔高防偷袭。

---

## 目录

- [A 区：最高命中，最像 Mock Question 1](#a-区最高命中最像-mock-question-1)
  - [A1. exactlyNBranching：每个 Branch 正好 n 个孩子](#a1-exactlynbranching每个-branch-正好-n-个孩子)
  - [A2. atMostNBranching：每个 Branch 最多 n 个孩子](#a2-atmostnbranching每个-branch-最多-n-个孩子)
  - [A3. atLeastNBranching：每个 Branch 至少 n 个孩子](#a3-atleastnbranching每个-branch-至少-n-个孩子)
  - [A4. prune：每个 Branch 最多保留前 n 个孩子](#a4-prune每个-branch-最多保留前-n-个孩子)
  - [A5. pruneFromEnd：每个 Branch 最多保留最后 n 个孩子](#a5-prunefromend每个-branch-最多保留最后-n-个孩子)
  - [A6. removeEmptyBranches：删除空 Branch](#a6-removeemptybranches删除空-branch)
  - [A7. collapseSingletonBranches：压缩只有一个孩子的 Branch](#a7-collapsesingletonbranches压缩只有一个孩子的-branch)
  - [A8. leaves：收集所有叶子](#a8-leaves收集所有叶子)
  - [A9. countLeaves：统计叶子数量](#a9-countleaves统计叶子数量)
  - [A10. countBranches：统计 Branch 数量](#a10-countbranches统计-branch-数量)
  - [A11. treeSize：统计所有节点数量](#a11-treesize统计所有节点数量)
  - [A12. heightRose：Rose Tree 高度](#a12-heightrose-rose-tree-高度)
  - [A13. mapRose：对所有叶子做函数映射](#a13-maprose对所有叶子做函数映射)
  - [A14. allLeaves：所有叶子是否满足条件](#a14-allleaves所有叶子是否满足条件)
  - [A15. anyLeaf：是否存在叶子满足条件](#a15-anyleaf是否存在叶子满足条件)
  - [A16. branchingFactors：返回所有 Branch 的孩子数量](#a16-branchingfactors返回所有-branch-的孩子数量)
  - [A17. isBalancedByHeight：所有直接子树高度差不超过 1](#a17-isbalancedbyheight所有直接子树高度差不超过-1)
  - [A18. mirrorRose：翻转每个 Branch 的孩子顺序](#a18-mirrorrose翻转每个-branch-的孩子顺序)

- [B 区：中高命中，Address / Maybe / Subtree 类](#b-区中高命中address--maybe--subtree-类)
  - [B1. isValid：判断 Address 是否合法](#b1-isvalid判断-address-是否合法)
  - [B2. getAtAddress：根据 Address 取值](#b2-getataddress根据-address-取值)
  - [B3. getSubtree：根据 Address 取子树](#b3-getsubtree根据-address-取子树)
  - [B4. validAddresses：返回所有合法地址](#b4-validaddresses返回所有合法地址)
  - [B5. updateAtAddress：修改 Address 处的值](#b5-updateataddress修改-address-处的值)
  - [B6. insertChildAt：在 Address 处添加一个孩子](#b6-insertchildat在-address-处添加一个孩子)
  - [B7. deleteChildAt：删除 Address 指向的孩子](#b7-deletechildat删除-address-指向的孩子)
  - [B8. pathValues：返回路径上的所有值](#b8-pathvalues返回路径上的所有值)
  - [B9. addressOf：查找某个值的第一个 Address](#b9-addressof查找某个值的第一个-address)
  - [B10. depthAtAddress：合法地址返回深度](#b10-depthataddress合法地址返回深度)
  - [B11. subtreeSizeAt：返回 Address 处子树大小](#b11-subtreesizeat返回-address-处子树大小)
  - [B12. replaceSubtree：替换 Address 处的整棵子树](#b12-replacesubtree替换-address-处的整棵子树)
  - [B13. safeNth：安全 list 索引](#b13-safenth安全-list-索引)
  - [B14. collectAtDepth：收集指定深度的节点值](#b14-collectatdepth收集指定深度的节点值)
  - [B15. deepestAddresses：返回所有最深叶子的地址](#b15-deepestaddresses返回所有最深叶子的地址)

- [C 区：拔高防偷袭，Binary Tree / BST / 综合变体](#c-区拔高防偷袭binary-tree--bst--综合变体)
  - [C1. isFull：每个节点有 0 或 2 个孩子](#c1-isfull每个节点有-0-或-2-个孩子)
  - [C2. pruneBT：二叉树按深度剪枝](#c2-prunebt二叉树按深度剪枝)
  - [C3. leavesBT：二叉树叶子列表](#c3-leavesbt二叉树叶子列表)
  - [C4. heightBT：二叉树高度](#c4-heightbt二叉树高度)
  - [C5. mirrorBT：翻转二叉树](#c5-mirrorbt翻转二叉树)
  - [C6. level：返回第 k 层节点](#c6-level返回第-k-层节点)
  - [C7. findBST：BST Maybe 查找](#c7-findbstbst-maybe-查找)
  - [C8. insertBST：BST 插入且不重复](#c8-insertbstbst-插入且不重复)
  - [C9. isBST：范围法判断 BST](#c9-isbst范围法判断-bst)
  - [C10. fromListBST：list 建 BST](#c10-fromlistbstlist-建-bst)
  - [C11. largestBST：找最大值](#c11-largestbst找最大值)
  - [C12. deleteLargest：删除最大值](#c12-deletelargest删除最大值)
  - [C13. deleteBST：BST 删除节点](#c13-deletebstbst-删除节点)
  - [C14. treeInOrder：中序遍历](#c14-treeinorder中序遍历)
  - [C15. isSorted：判断 list 是否严格升序](#c15-issorted判断-list-是否严格升序)
  - [C16. isBSTByInOrder：用中序判断 BST](#c16-isbstbyinorder用中序判断-bst)
  - [C17. pathsBT：返回所有根到叶路径](#c17-pathsbt返回所有根到叶路径)
  - [C18. mapMaybeTree：可能失败的树映射](#c18-mapmaybetree可能失败的树映射)

---

# A 区：最高命中，最像 Mock Question 1

本区默认 Rose Tree 类型：

```haskell
data Rose a = Leaf a
            | Branch [Rose a]
            deriving (Eq, Show)
```

---

## A1. exactlyNBranching：每个 Branch 正好 n 个孩子

```haskell
exactlyNBranching :: Int -> Rose a -> Bool
exactlyNBranching n (Leaf _) = True
exactlyNBranching n (Branch xs) =
  length xs == n && all (exactlyNBranching n) xs
```

---

## A2. atMostNBranching：每个 Branch 最多 n 个孩子

```haskell
atMostNBranching :: Int -> Rose a -> Bool
atMostNBranching n (Leaf _) = True
atMostNBranching n (Branch xs) =
  length xs <= n && all (atMostNBranching n) xs
```

---

## A3. atLeastNBranching：每个 Branch 至少 n 个孩子

```haskell
atLeastNBranching :: Int -> Rose a -> Bool
atLeastNBranching n (Leaf _) = True
atLeastNBranching n (Branch xs) =
  length xs >= n && all (atLeastNBranching n) xs
```

---

## A4. prune：每个 Branch 最多保留前 n 个孩子

```haskell
prune :: Int -> Rose a -> Rose a
prune n (Leaf x) = Leaf x
prune n (Branch xs) =
  Branch (map (prune n) (take n xs))
```

---

## A5. pruneFromEnd：每个 Branch 最多保留最后 n 个孩子

```haskell
pruneFromEnd :: Int -> Rose a -> Rose a
pruneFromEnd n (Leaf x) = Leaf x
pruneFromEnd n (Branch xs) =
  Branch (map (pruneFromEnd n) (drop extra xs))
  where
    extra = max 0 (length xs - n)
```

---

## A6. removeEmptyBranches：删除空 Branch

返回一个 forest，因为如果整棵树本身是空 Branch，也可能被删掉。

```haskell
removeEmptyBranches :: Rose a -> [Rose a]
removeEmptyBranches (Leaf x) = [Leaf x]
removeEmptyBranches (Branch []) = []
removeEmptyBranches (Branch xs) =
  [Branch (concatMap removeEmptyBranches xs)]
```

---

## A7. collapseSingletonBranches：压缩只有一个孩子的 Branch

```haskell
collapseSingletonBranches :: Rose a -> Rose a
collapseSingletonBranches (Leaf x) = Leaf x
collapseSingletonBranches (Branch [t]) =
  collapseSingletonBranches t
collapseSingletonBranches (Branch xs) =
  Branch (map collapseSingletonBranches xs)
```

---

## A8. leaves：收集所有叶子

```haskell
leaves :: Rose a -> [a]
leaves (Leaf x) = [x]
leaves (Branch xs) = concatMap leaves xs
```

---

## A9. countLeaves：统计叶子数量

```haskell
countLeaves :: Rose a -> Int
countLeaves (Leaf _) = 1
countLeaves (Branch xs) = sum (map countLeaves xs)
```

---

## A10. countBranches：统计 Branch 数量

```haskell
countBranches :: Rose a -> Int
countBranches (Leaf _) = 0
countBranches (Branch xs) =
  1 + sum (map countBranches xs)
```

---

## A11. treeSize：统计所有节点数量

```haskell
treeSize :: Rose a -> Int
treeSize (Leaf _) = 1
treeSize (Branch xs) =
  1 + sum (map treeSize xs)
```

---

## A12. heightRose：Rose Tree 高度

这里规定 `Leaf` 高度为 `0`。

```haskell
heightRose :: Rose a -> Int
heightRose (Leaf _) = 0
heightRose (Branch []) = 1
heightRose (Branch xs) =
  1 + maximum (map heightRose xs)
```

---

## A13. mapRose：对所有叶子做函数映射

```haskell
mapRose :: (a -> b) -> Rose a -> Rose b
mapRose f (Leaf x) = Leaf (f x)
mapRose f (Branch xs) =
  Branch (map (mapRose f) xs)
```

---

## A14. allLeaves：所有叶子是否满足条件

```haskell
allLeaves :: (a -> Bool) -> Rose a -> Bool
allLeaves p (Leaf x) = p x
allLeaves p (Branch xs) =
  all (allLeaves p) xs
```

---

## A15. anyLeaf：是否存在叶子满足条件

```haskell
anyLeaf :: (a -> Bool) -> Rose a -> Bool
anyLeaf p (Leaf x) = p x
anyLeaf p (Branch xs) =
  any (anyLeaf p) xs
```

---

## A16. branchingFactors：返回所有 Branch 的孩子数量

```haskell
branchingFactors :: Rose a -> [Int]
branchingFactors (Leaf _) = []
branchingFactors (Branch xs) =
  length xs : concatMap branchingFactors xs
```

---

## A17. isBalancedByHeight：所有直接子树高度差不超过 1

```haskell
isBalancedByHeight :: Rose a -> Bool
isBalancedByHeight (Leaf _) = True
isBalancedByHeight (Branch []) = True
isBalancedByHeight (Branch xs) =
  maximum hs - minimum hs <= 1 && all isBalancedByHeight xs
  where
    hs = map heightRose xs
```

---

## A18. mirrorRose：翻转每个 Branch 的孩子顺序

```haskell
mirrorRose :: Rose a -> Rose a
mirrorRose (Leaf x) = Leaf x
mirrorRose (Branch xs) =
  Branch (reverse (map mirrorRose xs))
```

---

# B 区：中高命中，Address / Maybe / Subtree 类

本区默认 Rose Tree 类型：

```haskell
data Rose a = Branch a [Rose a]
            deriving (Eq, Show)

type Direction = Int
type Address = [Direction]
```

---

## B1. isValid：判断 Address 是否合法

```haskell
isValid :: Address -> Rose a -> Bool
isValid [] _ = True
isValid (i:is) (Branch _ children)
  | i < 0 || i >= length children = False
  | otherwise = isValid is (children !! i)
```

---

## B2. getAtAddress：根据 Address 取值

```haskell
getAtAddress :: Address -> Rose a -> Maybe a
getAtAddress [] (Branch x _) = Just x
getAtAddress (i:is) (Branch _ children)
  | i < 0 || i >= length children = Nothing
  | otherwise = getAtAddress is (children !! i)
```

---

## B3. getSubtree：根据 Address 取子树

```haskell
getSubtree :: Address -> Rose a -> Maybe (Rose a)
getSubtree [] t = Just t
getSubtree (i:is) (Branch _ children)
  | i < 0 || i >= length children = Nothing
  | otherwise = getSubtree is (children !! i)
```

---

## B4. validAddresses：返回所有合法地址

```haskell
validAddresses :: Rose a -> [Address]
validAddresses (Branch _ children) =
  [] : [ i : addr
       | (i, child) <- zip [0..] children
       , addr <- validAddresses child
       ]
```

---

## B5. updateAtAddress：修改 Address 处的值

```haskell
updateAtAddress :: Address -> (a -> a) -> Rose a -> Maybe (Rose a)
updateAtAddress [] f (Branch x children) =
  Just (Branch (f x) children)

updateAtAddress (i:is) f (Branch x children)
  | i < 0 || i >= length children = Nothing
  | otherwise =
      case updateAtAddress is f (children !! i) of
        Nothing -> Nothing
        Just newChild ->
          Just (Branch x (replaceAt i newChild children))
```

辅助函数：

```haskell
replaceAt :: Int -> a -> [a] -> [a]
replaceAt 0 y (_:xs) = y : xs
replaceAt n y (x:xs) = x : replaceAt (n - 1) y xs
replaceAt _ _ [] = []
```

---

## B6. insertChildAt：在 Address 处添加一个孩子

```haskell
insertChildAt :: Address -> Rose a -> Rose a -> Maybe (Rose a)
insertChildAt [] newChild (Branch x children) =
  Just (Branch x (children ++ [newChild]))

insertChildAt (i:is) newChild (Branch x children)
  | i < 0 || i >= length children = Nothing
  | otherwise =
      case insertChildAt is newChild (children !! i) of
        Nothing -> Nothing
        Just changed ->
          Just (Branch x (replaceAt i changed children))
```

---

## B7. deleteChildAt：删除 Address 指向的孩子

这里 `[]` 表示根，根不能删除，所以返回 `Nothing`。

```haskell
deleteChildAt :: Address -> Rose a -> Maybe (Rose a)
deleteChildAt [] _ = Nothing

deleteChildAt [i] (Branch x children)
  | i < 0 || i >= length children = Nothing
  | otherwise = Just (Branch x (deleteAt i children))

deleteChildAt (i:is) (Branch x children)
  | i < 0 || i >= length children = Nothing
  | otherwise =
      case deleteChildAt is (children !! i) of
        Nothing -> Nothing
        Just changed ->
          Just (Branch x (replaceAt i changed children))
```

辅助函数：

```haskell
deleteAt :: Int -> [a] -> [a]
deleteAt 0 (_:xs) = xs
deleteAt n (x:xs) = x : deleteAt (n - 1) xs
deleteAt _ [] = []
```

---

## B8. pathValues：返回路径上的所有值

```haskell
pathValues :: Address -> Rose a -> Maybe [a]
pathValues [] (Branch x _) = Just [x]
pathValues (i:is) (Branch x children)
  | i < 0 || i >= length children = Nothing
  | otherwise =
      case pathValues is (children !! i) of
        Nothing -> Nothing
        Just xs -> Just (x : xs)
```

---

## B9. addressOf：查找某个值的第一个 Address

```haskell
addressOf :: Eq a => a -> Rose a -> Maybe Address
addressOf target (Branch x children)
  | target == x = Just []
  | otherwise   = search 0 children
  where
    search _ [] = Nothing
    search i (t:ts) =
      case addressOf target t of
        Just addr -> Just (i : addr)
        Nothing   -> search (i + 1) ts
```

---

## B10. depthAtAddress：合法地址返回深度

```haskell
depthAtAddress :: Address -> Rose a -> Maybe Int
depthAtAddress addr tree
  | isValid addr tree = Just (length addr)
  | otherwise         = Nothing
```

---

## B11. subtreeSizeAt：返回 Address 处子树大小

```haskell
subtreeSizeAt :: Address -> Rose a -> Maybe Int
subtreeSizeAt addr tree =
  case getSubtree addr tree of
    Nothing -> Nothing
    Just t  -> Just (sizeRose t)

sizeRose :: Rose a -> Int
sizeRose (Branch _ children) =
  1 + sum (map sizeRose children)
```

---

## B12. replaceSubtree：替换 Address 处的整棵子树

```haskell
replaceSubtree :: Address -> Rose a -> Rose a -> Maybe (Rose a)
replaceSubtree [] newTree _ = Just newTree

replaceSubtree (i:is) newTree (Branch x children)
  | i < 0 || i >= length children = Nothing
  | otherwise =
      case replaceSubtree is newTree (children !! i) of
        Nothing -> Nothing
        Just changed ->
          Just (Branch x (replaceAt i changed children))
```

---

## B13. safeNth：安全 list 索引

```haskell
safeNth :: Int -> [a] -> Maybe a
safeNth _ [] = Nothing
safeNth n (x:xs)
  | n < 0     = Nothing
  | n == 0    = Just x
  | otherwise = safeNth (n - 1) xs
```

---

## B14. collectAtDepth：收集指定深度的节点值

```haskell
collectAtDepth :: Int -> Rose a -> [a]
collectAtDepth n (Branch x children)
  | n < 0     = []
  | n == 0    = [x]
  | otherwise = concatMap (collectAtDepth (n - 1)) children
```

---

## B15. deepestAddresses：返回所有最深叶子的地址

```haskell
deepestAddresses :: Rose a -> [Address]
deepestAddresses tree =
  [ addr | addr <- validAddresses tree
         , length addr == maxDepth
  ]
  where
    addrs = validAddresses tree
    maxDepth = maximum (map length addrs)
```

---

# C 区：拔高防偷袭，Binary Tree / BST / 综合变体

本区默认 Binary Tree 类型：

```haskell
data BT a = Empty
          | Fork a (BT a) (BT a)
          deriving (Eq, Show)
```

---

## C1. isFull：每个节点有 0 或 2 个孩子

```haskell
isFull :: BT a -> Bool
isFull Empty = True
isFull (Fork _ Empty Empty) = True
isFull (Fork _ Empty _) = False
isFull (Fork _ _ Empty) = False
isFull (Fork _ l r) =
  isFull l && isFull r
```

---

## C2. pruneBT：二叉树按深度剪枝

```haskell
pruneBT :: Int -> BT a -> BT a
pruneBT n Empty = Empty
pruneBT n (Fork x l r)
  | n <= 0    = Empty
  | otherwise = Fork x (pruneBT (n - 1) l) (pruneBT (n - 1) r)
```

---

## C3. leavesBT：二叉树叶子列表

```haskell
leavesBT :: BT a -> [a]
leavesBT Empty = []
leavesBT (Fork x Empty Empty) = [x]
leavesBT (Fork _ l r) =
  leavesBT l ++ leavesBT r
```

---

## C4. heightBT：二叉树高度

```haskell
heightBT :: BT a -> Int
heightBT Empty = 0
heightBT (Fork _ l r) =
  1 + max (heightBT l) (heightBT r)
```

---

## C5. mirrorBT：翻转二叉树

```haskell
mirrorBT :: BT a -> BT a
mirrorBT Empty = Empty
mirrorBT (Fork x l r) =
  Fork x (mirrorBT r) (mirrorBT l)
```

---

## C6. level：返回第 k 层节点

根节点是第 `0` 层。

```haskell
level :: Int -> BT a -> [a]
level k Empty = []
level k (Fork x l r)
  | k < 0     = []
  | k == 0    = [x]
  | otherwise = level (k - 1) l ++ level (k - 1) r
```

---

## C7. findBST：BST Maybe 查找

```haskell
findBST :: Ord a => a -> BT a -> Maybe a
findBST x Empty = Nothing
findBST x (Fork y l r)
  | x == y    = Just y
  | x < y     = findBST x l
  | otherwise = findBST x r
```

---

## C8. insertBST：BST 插入且不重复

```haskell
insertBST :: Ord a => a -> BT a -> BT a
insertBST x Empty = Fork x Empty Empty
insertBST x (Fork y l r)
  | x == y    = Fork y l r
  | x < y     = Fork y (insertBST x l) r
  | otherwise = Fork y l (insertBST x r)
```

---

## C9. isBST：范围法判断 BST

```haskell
isBST :: Ord a => BT a -> Bool
isBST t = check Nothing Nothing t

check :: Ord a => Maybe a -> Maybe a -> BT a -> Bool
check low high Empty = True
check low high (Fork x l r) =
  biggerThanLow low x &&
  smallerThanHigh high x &&
  check low (Just x) l &&
  check (Just x) high r

biggerThanLow :: Ord a => Maybe a -> a -> Bool
biggerThanLow Nothing _ = True
biggerThanLow (Just low) x = x > low

smallerThanHigh :: Ord a => Maybe a -> a -> Bool
smallerThanHigh Nothing _ = True
smallerThanHigh (Just high) x = x < high
```

---

## C10. fromListBST：list 建 BST

```haskell
fromListBST :: Ord a => [a] -> BT a
fromListBST [] = Empty
fromListBST (x:xs) =
  insertBST x (fromListBST xs)
```

更常见 foldr 版本：

```haskell
fromListBST :: Ord a => [a] -> BT a
fromListBST xs = foldr insertBST Empty xs
```

---

## C11. largestBST：找最大值

```haskell
largestBST :: BT a -> Maybe a
largestBST Empty = Nothing
largestBST (Fork x _ Empty) = Just x
largestBST (Fork _ _ r) = largestBST r
```

---

## C12. deleteLargest：删除最大值

```haskell
deleteLargest :: BT a -> BT a
deleteLargest Empty = Empty
deleteLargest (Fork _ l Empty) = l
deleteLargest (Fork x l r) =
  Fork x l (deleteLargest r)
```

---

## C13. deleteBST：BST 删除节点

```haskell
deleteBST :: Ord a => a -> BT a -> BT a
deleteBST x Empty = Empty
deleteBST x (Fork y l r)
  | x < y     = Fork y (deleteBST x l) r
  | x > y     = Fork y l (deleteBST x r)
  | otherwise = combine l r

combine :: BT a -> BT a -> BT a
combine Empty r = r
combine l Empty = l
combine l r =
  Fork m (deleteLargest l) r
  where
    Just m = largestBST l
```

---

## C14. treeInOrder：中序遍历

```haskell
treeInOrder :: BT a -> [a]
treeInOrder Empty = []
treeInOrder (Fork x l r) =
  treeInOrder l ++ [x] ++ treeInOrder r
```

---

## C15. isSorted：判断 list 是否严格升序

```haskell
isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [_] = True
isSorted (x:y:xs) =
  x < y && isSorted (y:xs)
```

---

## C16. isBSTByInOrder：用中序判断 BST

```haskell
isBSTByInOrder :: Ord a => BT a -> Bool
isBSTByInOrder t =
  isSorted (treeInOrder t)
```

---

## C17. pathsBT：返回所有根到叶路径

```haskell
pathsBT :: BT a -> [[a]]
pathsBT Empty = []
pathsBT (Fork x Empty Empty) = [[x]]
pathsBT (Fork x l r) =
  map (x :) (pathsBT l ++ pathsBT r)
```

---

## C18. mapMaybeTree：可能失败的树映射

只要某个节点转换失败，整棵树失败。

```haskell
mapMaybeTree :: (a -> Maybe b) -> BT a -> Maybe (BT b)
mapMaybeTree f Empty = Just Empty
mapMaybeTree f (Fork x l r) =
  case f x of
    Nothing -> Nothing
    Just y ->
      case mapMaybeTree f l of
        Nothing -> Nothing
        Just l' ->
          case mapMaybeTree f r of
            Nothing -> Nothing
            Just r' -> Just (Fork y l' r')
```

---

# 最终背诵优先级

## 第一梯队：必须会

```haskell
exactlyNBranching :: Int -> Rose a -> Bool
exactlyNBranching n (Leaf _) = True
exactlyNBranching n (Branch xs) =
  length xs == n && all (exactlyNBranching n) xs
```

```haskell
prune :: Int -> Rose a -> Rose a
prune n (Leaf x) = Leaf x
prune n (Branch xs) =
  Branch (map (prune n) (take n xs))
```

```haskell
leaves :: Rose a -> [a]
leaves (Leaf x) = [x]
leaves (Branch xs) = concatMap leaves xs
```

```haskell
heightRose :: Rose a -> Int
heightRose (Leaf _) = 0
heightRose (Branch []) = 1
heightRose (Branch xs) =
  1 + maximum (map heightRose xs)
```

---

## 第二梯队：很可能作为变体

```haskell
isValid :: Address -> Rose a -> Bool
isValid [] _ = True
isValid (i:is) (Branch _ children)
  | i < 0 || i >= length children = False
  | otherwise = isValid is (children !! i)
```

```haskell
getAtAddress :: Address -> Rose a -> Maybe a
getAtAddress [] (Branch x _) = Just x
getAtAddress (i:is) (Branch _ children)
  | i < 0 || i >= length children = Nothing
  | otherwise = getAtAddress is (children !! i)
```

```haskell
validAddresses :: Rose a -> [Address]
validAddresses (Branch _ children) =
  [] : [ i : addr
       | (i, child) <- zip [0..] children
       , addr <- validAddresses child
       ]
```

---

## 第三梯队：防难题

```haskell
findBST :: Ord a => a -> BT a -> Maybe a
findBST x Empty = Nothing
findBST x (Fork y l r)
  | x == y    = Just y
  | x < y     = findBST x l
  | otherwise = findBST x r
```

```haskell
insertBST :: Ord a => a -> BT a -> BT a
insertBST x Empty = Fork x Empty Empty
insertBST x (Fork y l r)
  | x == y    = Fork y l r
  | x < y     = Fork y (insertBST x l) r
  | otherwise = Fork y l (insertBST x r)
```

```haskell
level :: Int -> BT a -> [a]
level k Empty = []
level k (Fork x l r)
  | k < 0     = []
  | k == 0    = [x]
  | otherwise = level (k - 1) l ++ level (k - 1) r
```

---

# 考场模板总结

## 判断类

```haskell
f (Leaf _) = True
f (Branch xs) =
  condition xs && all f xs
```

---

## 变形类

```haskell
f (Leaf x) = Leaf x
f (Branch xs) =
  Branch (map f xs)
```

---

## 剪枝类

```haskell
f n (Leaf x) = Leaf x
f n (Branch xs) =
  Branch (map (f n) (take n xs))
```

---

## Maybe 查找类

```haskell
f target Empty = Nothing
f target current
  | found     = Just result
  | otherwise = f target smallerPart
```

---

## Address 类

```haskell
f [] tree = Just result
f (i:is) (Branch x children)
  | i < 0 || i >= length children = Nothing
  | otherwise = f is (children !! i)
```

---

## 替换 list 第 i 项

```haskell
replaceAt :: Int -> a -> [a] -> [a]
replaceAt 0 y (_:xs) = y : xs
replaceAt n y (x:xs) = x : replaceAt (n - 1) y xs
replaceAt _ _ [] = []
```
