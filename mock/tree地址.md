# Haskell 押题补充：Address / Rose Tree / Binary Tree 高频题答案版

目录下面是rose的地址问题
---

## 目录

- [A. Address 类最高命中押题](#a-address-类最高命中押题)
  - [A1. 返回所有合法 Address](#a1-返回所有合法-address)
  - [A2. 判断 Address 是否合法](#a2-判断-address-是否合法)
  - [A3. 根据 Address 取节点值](#a3-根据-address-取节点值)
  - [A4. 根据 Address 取子树](#a4-根据-address-取子树)
  - [A5. 返回所有叶子节点 Address](#a5-返回所有叶子节点-address)
  - [A6. 返回所有节点的 Address 和值](#a6-返回所有节点的-address-和值)
  - [A7. 修改某个 Address 上的值](#a7-修改某个-address-上的值)
  - [A8. 删除某个 Address 上的子树](#a8-删除某个-address-上的子树)
  - [A9. 插入一个子树到某个 Address 下](#a9-插入一个子树到某个-address-下)
  - [A10. 判断某个 Address 是否指向叶子节点](#a10-判断某个-address-是否指向叶子节点)
- [B. Rose Tree 基础必考模板](#b-rose-tree-基础必考模板)
  - [B1. 计算 Rose Tree 节点数量](#b1-计算-rose-tree-节点数量)
  - [B2. 计算 Rose Tree 高度](#b2-计算-rose-tree-高度)
  - [B3. 收集所有节点值](#b3-收集所有节点值)
  - [B4. 判断某个值是否出现](#b4-判断某个值是否出现)
  - [B5. mapRose](#b5-maprose)
  - [B6. Functor Rose](#b6-functor-rose)
  - [B7. 判断是否所有节点满足条件](#b7-判断是否所有节点满足条件)
  - [B8. 统计满足条件的节点数量](#b8-统计满足条件的节点数量)
- [C. Rose Tree 变化押题](#c-rose-tree-变化押题)
  - [C1. prune：剪掉超过深度 n 的部分](#c1-prune剪掉超过深度-n-的部分)
  - [C2. mirrorRose：反转每层孩子顺序](#c2-mirrorrose反转每层孩子顺序)
  - [C3. flattenRose：先根遍历](#c3-flattenrose先根遍历)
  - [C4. levels：按层返回节点](#c4-levels按层返回节点)
  - [C5. paths：返回所有根到叶子的路径](#c5-paths返回所有根到叶子的路径)
  - [C6. maxBranching：最大分支数](#c6-maxbranching最大分支数)
  - [C7. isNBranching：是否每个节点最多 n 个孩子](#c7-isnbranching是否每个节点最多-n-个孩子)
  - [C8. depthOf：查找某个值第一次出现的深度](#c8-depthof查找某个值第一次出现的深度)
  - [C9. replaceAll：替换所有指定值](#c9-replaceall替换所有指定值)
  - [C10. zipRoseWith：合并两棵同形 Rose Tree](#c10-ziprosewith合并两棵同形-rose-tree)
- [D. Binary Tree 基础高频题](#d-binary-tree-基础高频题)
  - [D1. BT 数据类型](#d1-bt-数据类型)
  - [D2. sizeBT：节点数量](#d2-sizebt节点数量)
  - [D3. heightBT：高度](#d3-heightbt高度)
  - [D4. occursBT：判断元素是否出现](#d4-occursbt判断元素是否出现)
  - [D5. mirrorBT：镜像二叉树](#d5-mirrorbt镜像二叉树)
  - [D6. mapBT：映射二叉树](#d6-mapbt映射二叉树)
  - [D7. inorder：中序遍历](#d7-inorder中序遍历)
  - [D8. preorder：先序遍历](#d8-preorder先序遍历)
  - [D9. postorder：后序遍历](#d9-postorder后序遍历)
  - [D10. leavesBT：返回所有叶子节点](#d10-leavesbt返回所有叶子节点)
- [E. Binary Search Tree 高频押题](#e-binary-search-tree-高频押题)
  - [E1. insertBST：插入元素](#e1-insertbst插入元素)
  - [E2. memberBST：查找元素](#e2-memberbst查找元素)
  - [E3. treeMin：最小值](#e3-treemin最小值)
  - [E4. treeMax：最大值](#e4-treemax最大值)
  - [E5. deleteBST：删除元素](#e5-deletebst删除元素)
  - [E6. isBST：判断是否是 BST](#e6-isbst判断是否是-bst)
  - [E7. fromListBST：从列表建 BST](#e7-fromlistbst从列表建-bst)
- [F. BT Address 类押题](#f-bt-address-类押题)
  - [F1. 二叉树方向类型](#f1-二叉树方向类型)
  - [F2. validAddressesBT：所有合法地址](#f2-validaddressesbt所有合法地址)
  - [F3. subtreeBT：根据地址取子树](#f3-subtreebt根据地址取子树)
  - [F4. getBT：根据地址取值](#f4-getbt根据地址取值)
  - [F5. updateBT：修改地址上的值](#f5-updatebt修改地址上的值)
  - [F6. leafAddressesBT：所有叶子地址](#f6-leafaddressesbt所有叶子地址)
- [G. Maybe / Either 安全树操作押题](#g-maybe--either-安全树操作押题)
  - [G1. nthMaybe](#g1-nthmaybe)
  - [G2. nthEither](#g2-ntheither)
  - [G3. getAtAddressEither](#g3-getataddresseither)
  - [G4. safeHead / safeTail](#g4-safehead--safetail)
- [H. 最可能直接考的综合题](#h-最可能直接考的综合题)
  - [H1. Rose Tree Address 综合模板](#h1-rose-tree-address-综合模板)
  - [H2. BT Address 综合模板](#h2-bt-address-综合模板)
  - [H3. BST 综合模板](#h3-bst-综合模板)

---
```hs
data Rose a = Branch a [Rose a]
  deriving (Eq, Show)

type Direction = Int
type Address = [Direction]

--返回全部合法address
validAddresses :: Rose a -> [Address]
validAddresses (Branch y xs) =
 []:[i:addr|(i, xs) <- zip [0..] xs, addr <- validAddresses xs]
 

--检查一个address是否合理
isValid :: Address -> Rose a -> Bool
isValid [] _ = True
isValid (d:ds) (Branch _ children)
  | d < 0 || d >= length children = False
  | otherwise                     = isValid ds (children !! d)
  

--根据address找node
getAtAddress :: Rose a -> Address -> Maybe a
getAtAddress (Branch x _) [] = Just x
getAtAddress (Branch _ children) (i:is) =
  case nthMaybe i children of
    Nothing    -> Nothing
    Just child -> getAtAddress child is

nthMaybe :: Int -> [a] -> Maybe a
nthMaybe _ [] = Nothing
nthMaybe n _
  | n < 0 = Nothing
nthMaybe 0 (x:_) = Just x
nthMaybe n (_:xs) = nthMaybe (n - 1) xs


--根据address找子树
subtree :: Address -> Rose a -> Maybe (Rose a)
subtree [] t = Just t

subtree (d:ds) (Branch _ children)
  | d < 0 || d >= length children = Nothing
  | otherwise = subtree ds (children !! d)

```

# A. Address 类最高命中押题

## A1. 返回所有合法 Address

```haskell
data Rose a = Branch a [Rose a]
  deriving (Eq, Show)

type Direction = Int
type Address = [Direction]

validAddresses :: Rose a -> [Address]
validAddresses (Branch _ children) =
  [] : [i : addr | (i, child) <- zip [0..] children,
                   addr <- validAddresses child]
```

---

## A2. 判断 Address 是否合法

```haskell
isValid :: Address -> Rose a -> Bool
isValid [] _ = True

isValid (d:ds) (Branch _ children)
  | d < 0 || d >= length children = False
  | otherwise = isValid ds (children !! d)
```

---

## A3. 根据 Address 取节点值

```haskell
getAtAddress :: Rose a -> Address -> Maybe a
getAtAddress (Branch x _) [] = Just x

getAtAddress (Branch _ children) (d:ds) =
  case nthMaybe d children of
    Nothing    -> Nothing
    Just child -> getAtAddress child ds
```

```haskell
nthMaybe :: Int -> [a] -> Maybe a
nthMaybe _ [] = Nothing
nthMaybe n _
  | n < 0 = Nothing
nthMaybe 0 (x:_) = Just x
nthMaybe n (_:xs) = nthMaybe (n - 1) xs
```

---

## A4. 根据 Address 取子树

```haskell
subtree :: Address -> Rose a -> Maybe (Rose a)
subtree [] t = Just t

subtree (d:ds) (Branch _ children)
  | d < 0 || d >= length children = Nothing
  | otherwise = subtree ds (children !! d)
```

---

## A5. 返回所有叶子节点 Address

```haskell
leafAddresses :: Rose a -> [Address]
leafAddresses (Branch _ []) = [[]]

leafAddresses (Branch _ children) =
  [i : addr | (i, child) <- zip [0..] children,
              addr <- leafAddresses child]
```

---

## A6. 返回所有节点的 Address 和值

```haskell
addressedValues :: Rose a -> [(Address, a)]
addressedValues (Branch x children) =
  ([], x) :
  [(i : addr, y) | (i, child) <- zip [0..] children,
                   (addr, y) <- addressedValues child]
```

---

## A7. 修改某个 Address 上的值

```haskell
updateAtAddress :: Address -> a -> Rose a -> Maybe (Rose a)
updateAtAddress [] new (Branch _ children) =
  Just (Branch new children)

updateAtAddress (d:ds) new (Branch x children)
  | d < 0 || d >= length children = Nothing
  | otherwise =
      case updateAtAddress ds new (children !! d) of
        Nothing -> Nothing
        Just newChild ->
          Just (Branch x (replaceNth d newChild children))
```

```haskell
replaceNth :: Int -> a -> [a] -> [a]
replaceNth _ _ [] = []
replaceNth 0 new (_:xs) = new : xs
replaceNth n new (x:xs) = x : replaceNth (n - 1) new xs
```

---

## A8. 删除某个 Address 上的子树

```haskell
deleteAtAddress :: Address -> Rose a -> Maybe (Rose a)
deleteAtAddress [] _ = Nothing

deleteAtAddress [d] (Branch x children)
  | d < 0 || d >= length children = Nothing
  | otherwise = Just (Branch x (removeNth d children))

deleteAtAddress (d:ds) (Branch x children)
  | d < 0 || d >= length children = Nothing
  | otherwise =
      case deleteAtAddress ds (children !! d) of
        Nothing -> Nothing
        Just newChild ->
          Just (Branch x (replaceNth d newChild children))
```

```haskell
removeNth :: Int -> [a] -> [a]
removeNth _ [] = []
removeNth 0 (_:xs) = xs
removeNth n (x:xs) = x : removeNth (n - 1) xs
```

---

## A9. 插入一个子树到某个 Address 下

```haskell
insertChildAt :: Address -> Rose a -> Rose a -> Maybe (Rose a)
insertChildAt [] newChild (Branch x children) =
  Just (Branch x (children ++ [newChild]))

insertChildAt (d:ds) newChild (Branch x children)
  | d < 0 || d >= length children = Nothing
  | otherwise =
      case insertChildAt ds newChild (children !! d) of
        Nothing -> Nothing
        Just updatedChild ->
          Just (Branch x (replaceNth d updatedChild children))
```

---

## A10. 判断某个 Address 是否指向叶子节点

```haskell
isLeafAt :: Address -> Rose a -> Bool
isLeafAt addr t =
  case subtree addr t of
    Nothing -> False
    Just (Branch _ children) -> null children
```

---

# B. Rose Tree 基础必考模板

## B1. 计算 Rose Tree 节点数量

```haskell
rsize :: Rose a -> Int
rsize (Branch _ children) =
  1 + sum (map rsize children)
```

---

## B2. 计算 Rose Tree 高度

叶子高度为 0：

```haskell
rheight :: Rose a -> Int
rheight (Branch _ []) = 0

rheight (Branch _ children) =
  1 + maximum (map rheight children)
```

如果题目定义叶子高度为 1：

```haskell
rheight1 :: Rose a -> Int
rheight1 (Branch _ []) = 1

rheight1 (Branch _ children) =
  1 + maximum (map rheight1 children)
```

---

## B3. 收集所有节点值

```haskell
values :: Rose a -> [a]
values (Branch x children) =
  x : concat (map values children)
```

---

## B4. 判断某个值是否出现

```haskell
occurs :: Eq a => a -> Rose a -> Bool
occurs y (Branch x children) =
  x == y || or (map (occurs y) children)
```

---

## B5. mapRose

```haskell
mapRose :: (a -> b) -> Rose a -> Rose b
mapRose f (Branch x children) =
  Branch (f x) (map (mapRose f) children)
```

---

## B6. Functor Rose

```haskell
instance Functor Rose where
  fmap f (Branch x children) =
    Branch (f x) (map (fmap f) children)
```

---

## B7. 判断是否所有节点满足条件

```haskell
allRose :: (a -> Bool) -> Rose a -> Bool
allRose p (Branch x children) =
  p x && all (allRose p) children
```

---

## B8. 统计满足条件的节点数量

```haskell
countRose :: (a -> Bool) -> Rose a -> Int
countRose p (Branch x children) =
  current + sum (map (countRose p) children)
  where
    current = if p x then 1 else 0
```

---

# C. Rose Tree 变化押题

## C1. prune：剪掉超过深度 n 的部分

保留根节点，深度 0 时只保留当前节点：

```haskell
prune :: Int -> Rose a -> Rose a
prune 0 (Branch x _) = Branch x []

prune n (Branch x children)
  | n <= 0 = Branch x []
  | otherwise = Branch x (map (prune (n - 1)) children)
```

---

## C2. mirrorRose：反转每层孩子顺序

```haskell
mirrorRose :: Rose a -> Rose a
mirrorRose (Branch x children) =
  Branch x (reverse (map mirrorRose children))
```

---

## C3. flattenRose：先根遍历

```haskell
flattenRose :: Rose a -> [a]
flattenRose (Branch x children) =
  x : concat (map flattenRose children)
```

---

## C4. levels：按层返回节点

```haskell
levels :: Rose a -> [[a]]
levels t = go [t]
  where
    go [] = []
    go ts =
      map root ts : go (concat (map childrenOf ts))

    root (Branch x _) = x

    childrenOf (Branch _ children) = children
```

---

## C5. paths：返回所有根到叶子的路径

```haskell
paths :: Rose a -> [[a]]
paths (Branch x []) = [[x]]

paths (Branch x children) =
  [x : path | child <- children,
              path <- paths child]
```

---

## C6. maxBranching：最大分支数

```haskell
maxBranching :: Rose a -> Int
maxBranching (Branch _ children) =
  maximum (length children : map maxBranching children)
```

---

## C7. isNBranching：是否每个节点最多 n 个孩子

```haskell
isNBranching :: Int -> Rose a -> Bool
isNBranching n (Branch _ children) =
  length children <= n && all (isNBranching n) children
```

---

## C8. depthOf：查找某个值第一次出现的深度

```haskell
depthOf :: Eq a => a -> Rose a -> Maybe Int
depthOf y (Branch x children)
  | x == y = Just 0
  | otherwise = addOne (firstJust (map (depthOf y) children))
```

```haskell
addOne :: Maybe Int -> Maybe Int
addOne Nothing = Nothing
addOne (Just n) = Just (n + 1)
```

```haskell
firstJust :: [Maybe a] -> Maybe a
firstJust [] = Nothing
firstJust (Nothing:xs) = firstJust xs
firstJust (Just x:_) = Just x
```

---

## C9. replaceAll：替换所有指定值

```haskell
replaceAll :: Eq a => a -> a -> Rose a -> Rose a
replaceAll old new (Branch x children) =
  Branch x' (map (replaceAll old new) children)
  where
    x' = if x == old then new else x
```

---

## C10. zipRoseWith：合并两棵同形 Rose Tree

如果结构不同，返回 Nothing：

```haskell
zipRoseWith :: (a -> b -> c) -> Rose a -> Rose b -> Maybe (Rose c)
zipRoseWith f (Branch x xs) (Branch y ys)
  | length xs /= length ys = Nothing
  | otherwise =
      case zipChildren f xs ys of
        Nothing -> Nothing
        Just zs -> Just (Branch (f x y) zs)
```

```haskell
zipChildren :: (a -> b -> c) -> [Rose a] -> [Rose b] -> Maybe [Rose c]
zipChildren _ [] [] = Just []

zipChildren f (x:xs) (y:ys) =
  case zipRoseWith f x y of
    Nothing -> Nothing
    Just z ->
      case zipChildren f xs ys of
        Nothing -> Nothing
        Just zs -> Just (z:zs)

zipChildren _ _ _ = Nothing
```

---

# D. Binary Tree 基础高频题

## D1. BT 数据类型

```haskell
data BT a = Empty
          | Fork a (BT a) (BT a)
          deriving (Eq, Show)
```

---

## D2. sizeBT：节点数量

```haskell
sizeBT :: BT a -> Int
sizeBT Empty = 0

sizeBT (Fork _ l r) =
  1 + sizeBT l + sizeBT r
```

---

## D3. heightBT：高度

空树高度为 0：

```haskell
heightBT :: BT a -> Int
heightBT Empty = 0

heightBT (Fork _ l r) =
  1 + max (heightBT l) (heightBT r)
```

如果题目定义叶子高度为 0：

```haskell
heightBT0 :: BT a -> Int
heightBT0 Empty = -1

heightBT0 (Fork _ l r) =
  1 + max (heightBT0 l) (heightBT0 r)
```

---

## D4. occursBT：判断元素是否出现

```haskell
occursBT :: Eq a => a -> BT a -> Bool
occursBT _ Empty = False

occursBT y (Fork x l r) =
  x == y || occursBT y l || occursBT y r
```

---

## D5. mirrorBT：镜像二叉树

```haskell
mirrorBT :: BT a -> BT a
mirrorBT Empty = Empty

mirrorBT (Fork x l r) =
  Fork x (mirrorBT r) (mirrorBT l)
```

---

## D6. mapBT：映射二叉树

```haskell
mapBT :: (a -> b) -> BT a -> BT b
mapBT _ Empty = Empty

mapBT f (Fork x l r) =
  Fork (f x) (mapBT f l) (mapBT f r)
```

---

## D7. inorder：中序遍历

```haskell
inorder :: BT a -> [a]
inorder Empty = []

inorder (Fork x l r) =
  inorder l ++ [x] ++ inorder r
```

---

## D8. preorder：先序遍历

```haskell
preorder :: BT a -> [a]
preorder Empty = []

preorder (Fork x l r) =
  x : preorder l ++ preorder r
```

更稳写法：

```haskell
preorder :: BT a -> [a]
preorder Empty = []

preorder (Fork x l r) =
  [x] ++ preorder l ++ preorder r
```

---

## D9. postorder：后序遍历

```haskell
postorder :: BT a -> [a]
postorder Empty = []

postorder (Fork x l r) =
  postorder l ++ postorder r ++ [x]
```

---

## D10. leavesBT：返回所有叶子节点

```haskell
leavesBT :: BT a -> [a]
leavesBT Empty = []

leavesBT (Fork x Empty Empty) = [x]

leavesBT (Fork _ l r) =
  leavesBT l ++ leavesBT r
```

---

# E. Binary Search Tree 高频押题

## E1. insertBST：插入元素

```haskell
insertBST :: Ord a => a -> BT a -> BT a
insertBST y Empty = Fork y Empty Empty

insertBST y (Fork x l r)
  | y <= x    = Fork x (insertBST y l) r
  | otherwise = Fork x l (insertBST y r)
```

---

## E2. memberBST：查找元素

```haskell
memberBST :: Ord a => a -> BT a -> Bool
memberBST _ Empty = False

memberBST y (Fork x l r)
  | y == x    = True
  | y < x     = memberBST y l
  | otherwise = memberBST y r
```

---

## E3. treeMin：最小值

```haskell
treeMin :: BT a -> Maybe a
treeMin Empty = Nothing

treeMin (Fork x Empty _) = Just x

treeMin (Fork _ l _) = treeMin l
```

---

## E4. treeMax：最大值

```haskell
treeMax :: BT a -> Maybe a
treeMax Empty = Nothing

treeMax (Fork x _ Empty) = Just x

treeMax (Fork _ _ r) = treeMax r
```

---

## E5. deleteBST：删除元素

```haskell
deleteBST :: Ord a => a -> BT a -> BT a
deleteBST _ Empty = Empty

deleteBST y (Fork x l r)
  | y < x = Fork x (deleteBST y l) r
  | y > x = Fork x l (deleteBST y r)
  | otherwise = deleteRoot (Fork x l r)
```

```haskell
deleteRoot :: BT a -> BT a
deleteRoot Empty = Empty

deleteRoot (Fork _ Empty r) = r

deleteRoot (Fork _ l Empty) = l

deleteRoot (Fork _ l r) =
  case treeMin r of
    Nothing -> l
    Just m  -> Fork m l (deleteBST m r)
```

---

## E6. isBST：判断是否是 BST

用上下界最稳：

```haskell
isBST :: Ord a => BT a -> Bool
isBST t = check Nothing Nothing t
```

```haskell
check :: Ord a => Maybe a -> Maybe a -> BT a -> Bool
check _ _ Empty = True

check low high (Fork x l r) =
  biggerThanLow && smallerThanHigh &&
  check low (Just x) l &&
  check (Just x) high r
  where
    biggerThanLow =
      case low of
        Nothing -> True
        Just lo -> x >= lo

    smallerThanHigh =
      case high of
        Nothing -> True
        Just hi -> x <= hi
```

如果老师要求严格 BST，不允许重复：

```haskell
isBSTStrict :: Ord a => BT a -> Bool
isBSTStrict t = checkStrict Nothing Nothing t
```

```haskell
checkStrict :: Ord a => Maybe a -> Maybe a -> BT a -> Bool
checkStrict _ _ Empty = True

checkStrict low high (Fork x l r) =
  biggerThanLow && smallerThanHigh &&
  checkStrict low (Just x) l &&
  checkStrict (Just x) high r
  where
    biggerThanLow =
      case low of
        Nothing -> True
        Just lo -> x > lo

    smallerThanHigh =
      case high of
        Nothing -> True
        Just hi -> x < hi
```

---

## E7. fromListBST：从列表建 BST

```haskell
fromListBST :: Ord a => [a] -> BT a
fromListBST [] = Empty

fromListBST (x:xs) =
  insertBST x (fromListBST xs)
```

更自然的 foldr 写法：

```haskell
fromListBST :: Ord a => [a] -> BT a
fromListBST = foldr insertBST Empty
```

---

# F. BT Address 类押题

## F1. 二叉树方向类型

```haskell
data DirectionBT = L | R
  deriving (Eq, Show)

type AddressBT = [DirectionBT]
```

---

## F2. validAddressesBT：所有合法地址

```haskell
validAddressesBT :: BT a -> [AddressBT]
validAddressesBT Empty = []

validAddressesBT (Fork _ l r) =
  [] :
  [L : addr | addr <- validAddressesBT l] ++
  [R : addr | addr <- validAddressesBT r]
```

---

## F3. subtreeBT：根据地址取子树

```haskell
subtreeBT :: AddressBT -> BT a -> Maybe (BT a)
subtreeBT _ Empty = Nothing

subtreeBT [] t = Just t

subtreeBT (L:ds) (Fork _ l _) =
  subtreeBT ds l

subtreeBT (R:ds) (Fork _ _ r) =
  subtreeBT ds r
```

---

## F4. getBT：根据地址取值

```haskell
getBT :: AddressBT -> BT a -> Maybe a
getBT addr t =
  case subtreeBT addr t of
    Nothing -> Nothing
    Just Empty -> Nothing
    Just (Fork x _ _) -> Just x
```

---

## F5. updateBT：修改地址上的值

```haskell
updateBT :: AddressBT -> a -> BT a -> Maybe (BT a)
updateBT _ _ Empty = Nothing

updateBT [] new (Fork _ l r) =
  Just (Fork new l r)

updateBT (L:ds) new (Fork x l r) =
  case updateBT ds new l of
    Nothing -> Nothing
    Just newLeft -> Just (Fork x newLeft r)

updateBT (R:ds) new (Fork x l r) =
  case updateBT ds new r of
    Nothing -> Nothing
    Just newRight -> Just (Fork x l newRight)
```

---

## F6. leafAddressesBT：所有叶子地址

```haskell
leafAddressesBT :: BT a -> [AddressBT]
leafAddressesBT Empty = []

leafAddressesBT (Fork _ Empty Empty) = [[]]

leafAddressesBT (Fork _ l r) =
  [L : addr | addr <- leafAddressesBT l] ++
  [R : addr | addr <- leafAddressesBT r]
```

---

# G. Maybe / Either 安全树操作押题

## G1. nthMaybe

```haskell
nthMaybe :: Int -> [a] -> Maybe a
nthMaybe _ [] = Nothing
nthMaybe n _
  | n < 0 = Nothing
nthMaybe 0 (x:_) = Just x
nthMaybe n (_:xs) = nthMaybe (n - 1) xs
```

---

## G2. nthEither

```haskell
nthEither :: Int -> [a] -> Either String a
nthEither _ [] = Left "Index out of range"

nthEither n _
  | n < 0 = Left "Negative index"

nthEither 0 (x:_) = Right x

nthEither n (_:xs) = nthEither (n - 1) xs
```

---

## G3. getAtAddressEither

```haskell
getAtAddressEither :: Rose a -> Address -> Either String a
getAtAddressEither (Branch x _) [] = Right x

getAtAddressEither (Branch _ children) (d:ds) =
  case nthEither d children of
    Left msg -> Left msg
    Right child -> getAtAddressEither child ds
```

---

## G4. safeHead / safeTail

```haskell
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x
```

```haskell
safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (_:xs) = Just xs
```

---

# H. 最可能直接考的综合题

## H1. Rose Tree Address 综合模板

如果考试出现：

```haskell
data Rose a = Branch a [Rose a]
type Direction = Int
type Address = [Direction]
```

优先准备这几个：

```haskell
validAddresses :: Rose a -> [Address]
validAddresses (Branch _ children) =
  [] : [i : addr | (i, child) <- zip [0..] children,
                   addr <- validAddresses child]
```

```haskell
subtree :: Address -> Rose a -> Maybe (Rose a)
subtree [] t = Just t

subtree (d:ds) (Branch _ children)
  | d < 0 || d >= length children = Nothing
  | otherwise = subtree ds (children !! d)
```

```haskell
getAtAddress :: Rose a -> Address -> Maybe a
getAtAddress (Branch x _) [] = Just x

getAtAddress (Branch _ children) (d:ds)
  | d < 0 || d >= length children = Nothing
  | otherwise = getAtAddress (children !! d) ds
```

```haskell
leafAddresses :: Rose a -> [Address]
leafAddresses (Branch _ []) = [[]]

leafAddresses (Branch _ children) =
  [i : addr | (i, child) <- zip [0..] children,
              addr <- leafAddresses child]
```

```haskell
addressedValues :: Rose a -> [(Address, a)]
addressedValues (Branch x children) =
  ([], x) :
  [(i : addr, y) | (i, child) <- zip [0..] children,
                   (addr, y) <- addressedValues child]
```

---

## H2. BT Address 综合模板

如果考试出现：

```haskell
data BT a = Empty | Fork a (BT a) (BT a)
data Direction = L | R
type Address = [Direction]
```

优先准备这几个：

```haskell
validAddresses :: BT a -> [Address]
validAddresses Empty = []

validAddresses (Fork _ l r) =
  [] :
  [L : addr | addr <- validAddresses l] ++
  [R : addr | addr <- validAddresses r]
```

```haskell
subtree :: Address -> BT a -> Maybe (BT a)
subtree _ Empty = Nothing

subtree [] t = Just t

subtree (L:ds) (Fork _ l _) = subtree ds l

subtree (R:ds) (Fork _ _ r) = subtree ds r
```

```haskell
getAtAddress :: Address -> BT a -> Maybe a
getAtAddress addr t =
  case subtree addr t of
    Nothing -> Nothing
    Just Empty -> Nothing
    Just (Fork x _ _) -> Just x
```

```haskell
leafAddresses :: BT a -> [Address]
leafAddresses Empty = []

leafAddresses (Fork _ Empty Empty) = [[]]

leafAddresses (Fork _ l r) =
  [L : addr | addr <- leafAddresses l] ++
  [R : addr | addr <- leafAddresses r]
```

---

## H3. BST 综合模板

如果考试出现 BST：

```haskell
data BT a = Empty | Fork a (BT a) (BT a)
```

优先准备这几个：

```haskell
insertBST :: Ord a => a -> BT a -> BT a
insertBST y Empty = Fork y Empty Empty

insertBST y (Fork x l r)
  | y <= x    = Fork x (insertBST y l) r
  | otherwise = Fork x l (insertBST y r)
```

```haskell
memberBST :: Ord a => a -> BT a -> Bool
memberBST _ Empty = False

memberBST y (Fork x l r)
  | y == x    = True
  | y < x     = memberBST y l
  | otherwise = memberBST y r
```

```haskell
treeMin :: BT a -> Maybe a
treeMin Empty = Nothing
treeMin (Fork x Empty _) = Just x
treeMin (Fork _ l _) = treeMin l
```

```haskell
deleteBST :: Ord a => a -> BT a -> BT a
deleteBST _ Empty = Empty

deleteBST y (Fork x l r)
  | y < x = Fork x (deleteBST y l) r
  | y > x = Fork x l (deleteBST y r)
  | otherwise = deleteRoot (Fork x l r)
```

```haskell
deleteRoot :: BT a -> BT a
deleteRoot Empty = Empty
deleteRoot (Fork _ Empty r) = r
deleteRoot (Fork _ l Empty) = l

deleteRoot (Fork _ l r) =
  case treeMin r of
    Nothing -> l
    Just m  -> Fork m l (deleteBST m r)
```

---

# I. 考场速记模板

## I1. Rose Tree 看到 children

```haskell
f (Branch x children) =
  -- 当前节点 x
  -- 子树列表 children
```

常用组合：

```haskell
map f children
sum (map f children)
or (map f children)
all f children
concat (map f children)
```

---

## I2. Address 看到 []

```haskell
f [] tree = ...
```

表示：地址走完了，当前 tree 就是目标。

---

## I3. Address 看到 d:ds

```haskell
f (d:ds) (Branch _ children)
  | d < 0 || d >= length children = ...
  | otherwise = f ds (children !! d)
```

这是 Rose Tree Address 万能模板。

---

## I4. BT 看到 Empty

```haskell
f Empty = ...
```

永远先处理空树。

---

## I5. BT 看到 Fork

```haskell
f (Fork x l r) =
  -- x 当前值
  -- l 左子树
  -- r 右子树
```

常用组合：

```haskell
1 + f l + f r
f l ++ [x] ++ f r
x : f l ++ f r
f l ++ f r ++ [x]
Fork x (f l) (f r)
```

---

## I6. Maybe 安全访问模板

```haskell
case something of
  Nothing -> Nothing
  Just x  -> ...
```

如果返回值是 `Maybe`，失败就继续返回 `Nothing`。

---

## I7. Either 错误信息模板

```haskell
case something of
  Left msg -> Left msg
  Right x  -> ...
```

如果题目要求错误原因，用 `Either String a`。

---

# J. 最后高命中排序

## 第一优先级

1. `validAddresses`
2. `isValid`
3. `getAtAddress`
4. `subtree`
5. `leafAddresses`
6. `addressedValues`

---

## 第二优先级

1. `rsize`
2. `rheight`
3. `values`
4. `occurs`
5. `mapRose`
6. `prune`

---

## 第三优先级

1. `sizeBT`
2. `heightBT`
3. `inorder`
4. `preorder`
5. `postorder`
6. `mirrorBT`

---

## 第四优先级

1. `insertBST`
2. `memberBST`
3. `treeMin`
4. `treeMax`
5. `deleteBST`
6. `isBST`

---

# K. 最容易丢分的地方

## K1. Rose Tree 的 `[]`

在 Address 里面：

```haskell
[]
```

表示当前节点，不是空树。

---

## K2. Rose Tree 没有 Empty

如果数据类型是：

```haskell
data Rose a = Branch a [Rose a]
```

那么没有：

```haskell
Empty
Leaf
```

叶子节点写成：

```haskell
Branch x []
```

---

## K3. BT 有 Empty

如果数据类型是：

```haskell
data BT a = Empty | Fork a (BT a) (BT a)
```

就必须先写：

```haskell
f Empty = ...
```

---

## K4. `children !! d` 不安全

如果直接用：

```haskell
children !! d
```

前面最好先检查：

```haskell
d < 0 || d >= length children
```

或者使用：

```haskell
nthMaybe d children
```

---

## K5. `map` 的对象是子树，不是值

对于 Rose Tree：

```haskell
map rsize children
```

可以。

但是不能写：

```haskell
map rsize x
```

因为 `x` 是当前节点值，不是列表。

---

## K6. Address 递归时必须从 `ds` 继续

```haskell
subtree (d:ds) (Branch _ children) =
  subtree ds (children !! d)
```

不能继续传：

```haskell
subtree (d:ds) (children !! d)
```

否则永远不会消耗 address。

---

# L. 一套完整可测试代码

```haskell
data Rose a = Branch a [Rose a]
  deriving (Eq, Show)

type Direction = Int
type Address = [Direction]

exampleRose :: Rose Char
exampleRose =
  Branch 'a'
    [ Branch 'b' []
    , Branch 'c'
        [ Branch 'd' []
        , Branch 'e' []
        ]
    , Branch 'f' []
    ]

nthMaybe :: Int -> [a] -> Maybe a
nthMaybe _ [] = Nothing
nthMaybe n _
  | n < 0 = Nothing
nthMaybe 0 (x:_) = Just x
nthMaybe n (_:xs) = nthMaybe (n - 1) xs

validAddresses :: Rose a -> [Address]
validAddresses (Branch _ children) =
  [] : [i : addr | (i, child) <- zip [0..] children,
                   addr <- validAddresses child]

isValid :: Address -> Rose a -> Bool
isValid [] _ = True

isValid (d:ds) (Branch _ children)
  | d < 0 || d >= length children = False
  | otherwise = isValid ds (children !! d)

getAtAddress :: Rose a -> Address -> Maybe a
getAtAddress (Branch x _) [] = Just x

getAtAddress (Branch _ children) (d:ds) =
  case nthMaybe d children of
    Nothing    -> Nothing
    Just child -> getAtAddress child ds

subtree :: Address -> Rose a -> Maybe (Rose a)
subtree [] t = Just t

subtree (d:ds) (Branch _ children)
  | d < 0 || d >= length children = Nothing
  | otherwise = subtree ds (children !! d)

leafAddresses :: Rose a -> [Address]
leafAddresses (Branch _ []) = [[]]

leafAddresses (Branch _ children) =
  [i : addr | (i, child) <- zip [0..] children,
              addr <- leafAddresses child]

addressedValues :: Rose a -> [(Address, a)]
addressedValues (Branch x children) =
  ([], x) :
  [(i : addr, y) | (i, child) <- zip [0..] children,
                   (addr, y) <- addressedValues child]

replaceNth :: Int -> a -> [a] -> [a]
replaceNth _ _ [] = []
replaceNth 0 new (_:xs) = new : xs
replaceNth n new (x:xs) = x : replaceNth (n - 1) new xs

updateAtAddress :: Address -> a -> Rose a -> Maybe (Rose a)
updateAtAddress [] new (Branch _ children) =
  Just (Branch new children)

updateAtAddress (d:ds) new (Branch x children)
  | d < 0 || d >= length children = Nothing
  | otherwise =
      case updateAtAddress ds new (children !! d) of
        Nothing -> Nothing
        Just newChild ->
          Just (Branch x (replaceNth d newChild children))
```

---

# M. 一套完整 BT 可测试代码

```haskell
data BT a = Empty
          | Fork a (BT a) (BT a)
          deriving (Eq, Show)

exampleBT :: BT Int
exampleBT =
  Fork 5
    (Fork 3
      (Fork 1 Empty Empty)
      (Fork 4 Empty Empty))
    (Fork 8
      Empty
      (Fork 10 Empty Empty))

sizeBT :: BT a -> Int
sizeBT Empty = 0

sizeBT (Fork _ l r) =
  1 + sizeBT l + sizeBT r

heightBT :: BT a -> Int
heightBT Empty = 0

heightBT (Fork _ l r) =
  1 + max (heightBT l) (heightBT r)

occursBT :: Eq a => a -> BT a -> Bool
occursBT _ Empty = False

occursBT y (Fork x l r) =
  x == y || occursBT y l || occursBT y r

mirrorBT :: BT a -> BT a
mirrorBT Empty = Empty

mirrorBT (Fork x l r) =
  Fork x (mirrorBT r) (mirrorBT l)

mapBT :: (a -> b) -> BT a -> BT b
mapBT _ Empty = Empty

mapBT f (Fork x l r) =
  Fork (f x) (mapBT f l) (mapBT f r)

inorder :: BT a -> [a]
inorder Empty = []

inorder (Fork x l r) =
  inorder l ++ [x] ++ inorder r

preorder :: BT a -> [a]
preorder Empty = []

preorder (Fork x l r) =
  [x] ++ preorder l ++ preorder r

postorder :: BT a -> [a]
postorder Empty = []

postorder (Fork x l r) =
  postorder l ++ postorder r ++ [x]

insertBST :: Ord a => a -> BT a -> BT a
insertBST y Empty = Fork y Empty Empty

insertBST y (Fork x l r)
  | y <= x    = Fork x (insertBST y l) r
  | otherwise = Fork x l (insertBST y r)

memberBST :: Ord a => a -> BT a -> Bool
memberBST _ Empty = False

memberBST y (Fork x l r)
  | y == x    = True
  | y < x     = memberBST y l
  | otherwise = memberBST y r
```
