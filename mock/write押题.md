# Writer Monad 超加强押题答案集（多题型覆盖版）

> 主题：Haskell `Writer` Monad  
> 用法：考前直接背模板 / 改变量名套题  
> 风格：**标题 + 答案代码为主**，少解析  
> 排序：从最高命中率到扩展押题  
> 核心关键词：`Writer`、`tell`、`runWriter`、`execWriter`、`evalWriter`、`mapM`、`mapM_`、`foldM`、`listen`、`censor`

---

## 目录

- [A区：最高命中率 Dir / Directory 结构题](#a区最高命中率-dir--directory-结构题)
  - [A1. 遍历目录结构并记录进入/离开文件夹](#a1-遍历目录结构并记录进入离开文件夹)
  - [A2. 遍历目录，只记录文件名](#a2-遍历目录只记录文件名)
  - [A3. 遍历目录，只记录文件内容长度](#a3-遍历目录只记录文件内容长度)
  - [A4. 遍历目录，记录完整路径](#a4-遍历目录记录完整路径)
  - [A5. 遍历目录，记录缩进日志](#a5-遍历目录记录缩进日志)
  - [A6. 遍历目录，统计文件数量 Writer Sum](#a6-遍历目录统计文件数量-writer-sum)
  - [A7. 遍历目录，统计文件夹数量 Writer Sum](#a7-遍历目录统计文件夹数量-writer-sum)
  - [A8. 遍历目录，同时返回所有文件名](#a8-遍历目录同时返回所有文件名)
  - [A9. 查找指定文件并记录搜索过程](#a9-查找指定文件并记录搜索过程)
  - [A10. 查找指定文件完整路径并记录过程](#a10-查找指定文件完整路径并记录过程)
  - [A11. 删除/过滤文件名时记录保留与删除](#a11-删除过滤文件名时记录保留与删除)
  - [A12. 将目录树扁平化为文件路径列表并记录过程](#a12-将目录树扁平化为文件路径列表并记录过程)
- [B区：Tree + Writer 高命中率题](#b区tree--writer-高命中率题)
  - [B1. 前序遍历二叉树并记录访问节点](#b1-前序遍历二叉树并记录访问节点)
  - [B2. 中序遍历二叉树并记录访问节点](#b2-中序遍历二叉树并记录访问节点)
  - [B3. 后序遍历二叉树并记录访问节点](#b3-后序遍历二叉树并记录访问节点)
  - [B4. 计算树大小并记录每个节点](#b4-计算树大小并记录每个节点)
  - [B5. 计算树高度并记录递归过程](#b5-计算树高度并记录递归过程)
  - [B6. 判断元素是否存在并记录搜索过程](#b6-判断元素是否存在并记录搜索过程)
  - [B7. BST 查找并记录向左/向右](#b7-bst-查找并记录向左向右)
  - [B8. 树 map，并记录每次修改](#b8-树-map并记录每次修改)
  - [B9. 收集叶子节点并记录经过节点](#b9-收集叶子节点并记录经过节点)
  - [B10. Rose Tree 遍历并记录日志](#b10-rose-tree-遍历并记录日志)
- [C区：List + Writer 高命中率题](#c区list--writer-高命中率题)
  - [C1. mapM：对每个数翻倍并记录](#c1-mapm对每个数翻倍并记录)
  - [C2. mapM_：只记录每个元素，不收集结果](#c2-mapm_只记录每个元素不收集结果)
  - [C3. filterLog：过滤列表并记录保留/丢弃](#c3-filterlog过滤列表并记录保留丢弃)
  - [C4. foldM：累加求和并记录每一步](#c4-foldm累加求和并记录每一步)
  - [C5. foldM：累乘并记录每一步](#c5-foldm累乘并记录每一步)
  - [C6. 找最大值并记录比较过程](#c6-找最大值并记录比较过程)
  - [C7. 安全取 head 并记录空/非空](#c7-安全取-head-并记录空非空)
  - [C8. 安全取 nth 元素并记录过程](#c8-安全取-nth-元素并记录过程)
  - [C9. partitionLog：分组并记录](#c9-partitionlog分组并记录)
  - [C10. 去重并记录重复元素](#c10-去重并记录重复元素)
  - [C11. 排序插入并记录比较](#c11-排序插入并记录比较)
  - [C12. insertion sort with Writer](#c12-insertion-sort-with-writer)
- [D区：Maybe / Either + Writer 混合押题](#d区maybe--either--writer-混合押题)
  - [D1. 安全除法 Maybe + Writer](#d1-安全除法-maybe--writer)
  - [D2. 安全除法 Either + Writer](#d2-安全除法-either--writer)
  - [D3. 多步计算 Maybe + Writer](#d3-多步计算-maybe--writer)
  - [D4. 多步计算 Either + Writer](#d4-多步计算-either--writer)
  - [D5. 查找元素 Maybe + Writer](#d5-查找元素-maybe--writer)
  - [D6. validate password Either + Writer](#d6-validate-password-either--writer)
  - [D7. parse Int Either + Writer](#d7-parse-int-either--writer)
- [E区：State / Writer 对比型押题](#e区state--writer-对比型押题)
  - [E1. 用 State 写计数器](#e1-用-state-写计数器)
  - [E2. 用 Writer 写日志计数](#e2-用-writer-写日志计数)
  - [E3. State + Writer 分开写计算器](#e3-state--writer-分开写计算器)
  - [E4. Calculator with Writer log](#e4-calculator-with-writer-log)
  - [E5. Nim move with Writer log](#e5-nim-move-with-writer-log)
- [F区：Reader / Writer / State 区分题](#f区reader--writer--state-区分题)
  - [F1. Reader 读取环境](#f1-reader-读取环境)
  - [F2. Writer 记录日志](#f2-writer-记录日志)
  - [F3. State 修改状态](#f3-state-修改状态)
  - [F4. 三者一句话区别](#f4-三者一句话区别)
- [G区：Writer 常用函数押题](#g区writer-常用函数押题)
  - [G1. runWriter / evalWriter / execWriter](#g1-runwriter--evalwriter--execwriter)
  - [G2. tell 最小例子](#g2-tell-最小例子)
  - [G3. listen 用法](#g3-listen-用法)
  - [G4. listens 用法](#g4-listens-用法)
  - [G5. censor 用法](#g5-censor-用法)
  - [G6. pass 用法](#g6-pass-用法)
- [H区：Writer 日志类型变化题](#h区writer-日志类型变化题)
  - [H1. Writer [String]](#h1-writer-string)
  - [H2. Writer String](#h2-writer-string)
  - [H3. Writer (Sum Int)](#h3-writer-sum-int)
  - [H4. Writer (Product Int)](#h4-writer-product-int)
  - [H5. Writer (Any)](#h5-writer-any)
  - [H6. Writer (All)](#h6-writer-all)
- [I区：Applicative / Monad 风格 Writer](#i区applicative--monad-风格-writer)
  - [I1. do 版本](#i1-do-版本)
  - [I2. bind 版本](#i2-bind-版本)
  - [I3. fmap 版本](#i3-fmap-版本)
  - [I4. applicative 版本](#i4-applicative-版本)
- [J区：考试最后速背模板](#j区考试最后速背模板)
  - [J1. Writer [String] ()](#j1-writer-string-)
  - [J2. Writer [String] a](#j2-writer-string-a)
  - [J3. mapM 模板](#j3-mapm-模板)
  - [J4. mapM_ 模板](#j4-mapm_-模板)
  - [J5. foldM 模板](#j5-foldm-模板)
  - [J6. 递归结构 Writer 模板](#j6-递归结构-writer-模板)

---

# A区：最高命中率 Dir / Directory 结构题

---

## A1. 遍历目录结构并记录进入/离开文件夹

```haskell
import Control.Monad.Writer

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

logTraverse :: Dir -> Writer [String] ()
logTraverse (File name _) = do
  tell ["Passing file: " ++ name]

logTraverse (SubDir name contents) = do
  tell ["Entering directory: " ++ name]
  mapM_ logTraverse contents
  tell ["Leaving directory: " ++ name]
```

---

## A2. 遍历目录，只记录文件名

```haskell
import Control.Monad.Writer

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

recordFiles :: Dir -> Writer [String] ()
recordFiles (File name _) = do
  tell [name]

recordFiles (SubDir _ contents) = do
  mapM_ recordFiles contents
```

---

## A3. 遍历目录，只记录文件内容长度

```haskell
import Control.Monad.Writer

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

logFileLengths :: Dir -> Writer [String] ()
logFileLengths (File name content) = do
  tell [name ++ " has length " ++ show (length content)]

logFileLengths (SubDir _ contents) = do
  mapM_ logFileLengths contents
```

---

## A4. 遍历目录，记录完整路径

```haskell
import Control.Monad.Writer

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

recordPaths :: Dir -> Writer [String] ()
recordPaths dir = go "" dir
  where
    go path (File name _) = do
      tell [path ++ "/" ++ name]

    go path (SubDir name contents) = do
      let newPath = path ++ "/" ++ name
      mapM_ (go newPath) contents
```

---

## A5. 遍历目录，记录缩进日志

```haskell
import Control.Monad.Writer

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

logIndented :: Dir -> Writer [String] ()
logIndented dir = go 0 dir
  where
    indent n = replicate (2 * n) ' '

    go n (File name _) = do
      tell [indent n ++ "File: " ++ name]

    go n (SubDir name contents) = do
      tell [indent n ++ "Directory: " ++ name]
      mapM_ (go (n + 1)) contents
```

---

## A6. 遍历目录，统计文件数量 Writer Sum

```haskell
import Control.Monad.Writer
import Data.Monoid

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

countFiles :: Dir -> Writer (Sum Int) ()
countFiles (File _ _) = do
  tell (Sum 1)

countFiles (SubDir _ contents) = do
  mapM_ countFiles contents
```

```haskell
getSum (execWriter (countFiles recipes))
```

---

## A7. 遍历目录，统计文件夹数量 Writer Sum

```haskell
import Control.Monad.Writer
import Data.Monoid

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

countDirs :: Dir -> Writer (Sum Int) ()
countDirs (File _ _) = do
  return ()

countDirs (SubDir _ contents) = do
  tell (Sum 1)
  mapM_ countDirs contents
```

---

## A8. 遍历目录，同时返回所有文件名

```haskell
import Control.Monad.Writer

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

collectFiles :: Dir -> Writer [String] [String]
collectFiles (File name _) = do
  tell ["Found file: " ++ name]
  return [name]

collectFiles (SubDir name contents) = do
  tell ["Entering: " ++ name]
  files <- mapM collectFiles contents
  tell ["Leaving: " ++ name]
  return (concat files)
```

---

## A9. 查找指定文件并记录搜索过程

```haskell
import Control.Monad.Writer

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

findFile :: String -> Dir -> Writer [String] (Maybe String)
findFile target (File name content) = do
  tell ["Checking file: " ++ name]
  if target == name
    then do
      tell ["Found: " ++ name]
      return (Just content)
    else do
      return Nothing

findFile target (SubDir name contents) = do
  tell ["Entering directory: " ++ name]
  results <- mapM (findFile target) contents
  tell ["Leaving directory: " ++ name]
  return (firstJust results)

firstJust :: [Maybe a] -> Maybe a
firstJust [] = Nothing
firstJust (Just x : _) = Just x
firstJust (Nothing : xs) = firstJust xs
```

---

## A10. 查找指定文件完整路径并记录过程

```haskell
import Control.Monad.Writer

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

findPath :: String -> Dir -> Writer [String] (Maybe String)
findPath target dir = go "" dir
  where
    go path (File name _) = do
      tell ["Checking file: " ++ name]
      if target == name
        then return (Just (path ++ "/" ++ name))
        else return Nothing

    go path (SubDir name contents) = do
      let newPath = path ++ "/" ++ name
      tell ["Entering: " ++ newPath]
      results <- mapM (go newPath) contents
      tell ["Leaving: " ++ newPath]
      return (firstJust results)

firstJust :: [Maybe a] -> Maybe a
firstJust [] = Nothing
firstJust (Just x : _) = Just x
firstJust (Nothing : xs) = firstJust xs
```

---

## A11. 删除/过滤文件名时记录保留与删除

```haskell
import Control.Monad.Writer

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

filterFiles :: (String -> Bool) -> Dir -> Writer [String] (Maybe Dir)
filterFiles p (File name content)
  | p name = do
      tell ["Keeping file: " ++ name]
      return (Just (File name content))
  | otherwise = do
      tell ["Removing file: " ++ name]
      return Nothing

filterFiles p (SubDir name contents) = do
  tell ["Entering directory: " ++ name]
  newContents <- mapM (filterFiles p) contents
  tell ["Leaving directory: " ++ name]
  return (Just (SubDir name (removeNothings newContents)))

removeNothings :: [Maybe a] -> [a]
removeNothings [] = []
removeNothings (Nothing : xs) = removeNothings xs
removeNothings (Just x : xs) = x : removeNothings xs
```

---

## A12. 将目录树扁平化为文件路径列表并记录过程

```haskell
import Control.Monad.Writer

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

flattenDir :: Dir -> Writer [String] [String]
flattenDir dir = go "" dir
  where
    go path (File name _) = do
      let fullPath = path ++ "/" ++ name
      tell ["Adding file: " ++ fullPath]
      return [fullPath]

    go path (SubDir name contents) = do
      let newPath = path ++ "/" ++ name
      tell ["Entering: " ++ newPath]
      paths <- mapM (go newPath) contents
      tell ["Leaving: " ++ newPath]
      return (concat paths)
```

---

# B区：Tree + Writer 高命中率题

---

## B1. 前序遍历二叉树并记录访问节点

```haskell
import Control.Monad.Writer

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            deriving Show

preorderLog :: Show a => Tree a -> Writer [String] [a]
preorderLog Empty = do
  tell ["Empty"]
  return []

preorderLog (Node l x r) = do
  tell ["Visit: " ++ show x]
  left <- preorderLog l
  right <- preorderLog r
  return ([x] ++ left ++ right)
```

---

## B2. 中序遍历二叉树并记录访问节点

```haskell
import Control.Monad.Writer

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            deriving Show

inorderLog :: Show a => Tree a -> Writer [String] [a]
inorderLog Empty = do
  tell ["Empty"]
  return []

inorderLog (Node l x r) = do
  left <- inorderLog l
  tell ["Visit: " ++ show x]
  right <- inorderLog r
  return (left ++ [x] ++ right)
```

---

## B3. 后序遍历二叉树并记录访问节点

```haskell
import Control.Monad.Writer

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            deriving Show

postorderLog :: Show a => Tree a -> Writer [String] [a]
postorderLog Empty = do
  tell ["Empty"]
  return []

postorderLog (Node l x r) = do
  left <- postorderLog l
  right <- postorderLog r
  tell ["Visit: " ++ show x]
  return (left ++ right ++ [x])
```

---

## B4. 计算树大小并记录每个节点

```haskell
import Control.Monad.Writer

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            deriving Show

sizeLog :: Show a => Tree a -> Writer [String] Int
sizeLog Empty = do
  tell ["Empty contributes 0"]
  return 0

sizeLog (Node l x r) = do
  tell ["Counting node: " ++ show x]
  leftSize <- sizeLog l
  rightSize <- sizeLog r
  return (1 + leftSize + rightSize)
```

---

## B5. 计算树高度并记录递归过程

```haskell
import Control.Monad.Writer

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            deriving Show

heightLog :: Show a => Tree a -> Writer [String] Int
heightLog Empty = do
  tell ["Empty has height 0"]
  return 0

heightLog (Node l x r) = do
  tell ["At node: " ++ show x]
  leftHeight <- heightLog l
  rightHeight <- heightLog r
  let h = 1 + max leftHeight rightHeight
  tell ["Height at " ++ show x ++ " is " ++ show h]
  return h
```

---

## B6. 判断元素是否存在并记录搜索过程

```haskell
import Control.Monad.Writer

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            deriving Show

containsLog :: (Eq a, Show a) => a -> Tree a -> Writer [String] Bool
containsLog target Empty = do
  tell ["Reached Empty"]
  return False

containsLog target (Node l x r) = do
  tell ["Checking: " ++ show x]
  if target == x
    then do
      tell ["Found: " ++ show x]
      return True
    else do
      leftFound <- containsLog target l
      if leftFound
        then return True
        else containsLog target r
```

---

## B7. BST 查找并记录向左/向右

```haskell
import Control.Monad.Writer

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            deriving Show

bstFindLog :: (Ord a, Show a) => a -> Tree a -> Writer [String] Bool
bstFindLog target Empty = do
  tell ["Reached Empty"]
  return False

bstFindLog target (Node l x r)
  | target == x = do
      tell ["Found: " ++ show x]
      return True

  | target < x = do
      tell ["At " ++ show x ++ ", go left"]
      bstFindLog target l

  | otherwise = do
      tell ["At " ++ show x ++ ", go right"]
      bstFindLog target r
```

---

## B8. 树 map，并记录每次修改

```haskell
import Control.Monad.Writer

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            deriving Show

mapTreeLog :: Show a => (a -> b) -> Tree a -> Writer [String] (Tree b)
mapTreeLog f Empty = do
  tell ["Empty"]
  return Empty

mapTreeLog f (Node l x r) = do
  tell ["Mapping value: " ++ show x]
  newLeft <- mapTreeLog f l
  newRight <- mapTreeLog f r
  return (Node newLeft (f x) newRight)
```

---

## B9. 收集叶子节点并记录经过节点

```haskell
import Control.Monad.Writer

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            deriving Show

leavesLog :: Show a => Tree a -> Writer [String] [a]
leavesLog Empty = do
  return []

leavesLog (Node Empty x Empty) = do
  tell ["Leaf: " ++ show x]
  return [x]

leavesLog (Node l x r) = do
  tell ["Internal node: " ++ show x]
  leftLeaves <- leavesLog l
  rightLeaves <- leavesLog r
  return (leftLeaves ++ rightLeaves)
```

---

## B10. Rose Tree 遍历并记录日志

```haskell
import Control.Monad.Writer

data Rose a = Rose a [Rose a]
  deriving Show

roseLog :: Show a => Rose a -> Writer [String] [a]
roseLog (Rose x children) = do
  tell ["Visit: " ++ show x]
  childResults <- mapM roseLog children
  return (x : concat childResults)
```

---

# C区：List + Writer 高命中率题

---

## C1. mapM：对每个数翻倍并记录

```haskell
import Control.Monad.Writer

doubleLog :: Int -> Writer [String] Int
doubleLog x = do
  tell ["Doubling " ++ show x]
  return (2 * x)

doubleAllLog :: [Int] -> Writer [String] [Int]
doubleAllLog xs = do
  mapM doubleLog xs
```

---

## C2. mapM_：只记录每个元素，不收集结果

```haskell
import Control.Monad.Writer

seeLog :: Show a => a -> Writer [String] ()
seeLog x = do
  tell ["Saw: " ++ show x]

seeAllLog :: Show a => [a] -> Writer [String] ()
seeAllLog xs = do
  mapM_ seeLog xs
```

---

## C3. filterLog：过滤列表并记录保留/丢弃

```haskell
import Control.Monad.Writer

filterLog :: Show a => (a -> Bool) -> [a] -> Writer [String] [a]
filterLog p [] = do
  return []

filterLog p (x:xs)
  | p x = do
      tell ["Keeping " ++ show x]
      rest <- filterLog p xs
      return (x : rest)

  | otherwise = do
      tell ["Discarding " ++ show x]
      filterLog p xs
```

---

## C4. foldM：累加求和并记录每一步

```haskell
import Control.Monad.Writer
import Control.Monad

addLog :: Int -> Int -> Writer [String] Int
addLog acc x = do
  tell ["Adding " ++ show x ++ " to " ++ show acc]
  return (acc + x)

sumLog :: [Int] -> Writer [String] Int
sumLog xs = do
  foldM addLog 0 xs
```

---

## C5. foldM：累乘并记录每一步

```haskell
import Control.Monad.Writer
import Control.Monad

multLog :: Int -> Int -> Writer [String] Int
multLog acc x = do
  tell ["Multiplying " ++ show acc ++ " by " ++ show x]
  return (acc * x)

productLog :: [Int] -> Writer [String] Int
productLog xs = do
  foldM multLog 1 xs
```

---

## C6. 找最大值并记录比较过程

```haskell
import Control.Monad.Writer

maxLog :: Ord a => Show a => [a] -> Writer [String] (Maybe a)
maxLog [] = do
  tell ["Empty list"]
  return Nothing

maxLog (x:xs) = do
  m <- go x xs
  return (Just m)
  where
    go current [] = do
      tell ["Maximum is " ++ show current]
      return current

    go current (y:ys)
      | y > current = do
          tell [show y ++ " is bigger than " ++ show current]
          go y ys

      | otherwise = do
          tell [show y ++ " is not bigger than " ++ show current]
          go current ys
```

---

## C7. 安全取 head 并记录空/非空

```haskell
import Control.Monad.Writer

safeHeadLog :: Show a => [a] -> Writer [String] (Maybe a)
safeHeadLog [] = do
  tell ["Empty list"]
  return Nothing

safeHeadLog (x:_) = do
  tell ["Head is " ++ show x]
  return (Just x)
```

---

## C8. 安全取 nth 元素并记录过程

```haskell
import Control.Monad.Writer

nthLog :: Show a => Int -> [a] -> Writer [String] (Maybe a)
nthLog _ [] = do
  tell ["Index too large"]
  return Nothing

nthLog 0 (x:_) = do
  tell ["Found element: " ++ show x]
  return (Just x)

nthLog n (_:xs) = do
  tell ["Skipping one element"]
  nthLog (n - 1) xs
```

---

## C9. partitionLog：分组并记录

```haskell
import Control.Monad.Writer

partitionLog :: Show a => (a -> Bool) -> [a] -> Writer [String] ([a], [a])
partitionLog p [] = do
  return ([], [])

partitionLog p (x:xs)
  | p x = do
      tell ["Left group: " ++ show x]
      (ys, zs) <- partitionLog p xs
      return (x:ys, zs)

  | otherwise = do
      tell ["Right group: " ++ show x]
      (ys, zs) <- partitionLog p xs
      return (ys, x:zs)
```

---

## C10. 去重并记录重复元素

```haskell
import Control.Monad.Writer

uniqueLog :: Eq a => Show a => [a] -> Writer [String] [a]
uniqueLog xs = go [] xs
  where
    go seen [] = do
      return []

    go seen (x:xs)
      | x `elem` seen = do
          tell ["Duplicate: " ++ show x]
          go seen xs

      | otherwise = do
          tell ["Keeping: " ++ show x]
          rest <- go (x:seen) xs
          return (x:rest)
```

---

## C11. 排序插入并记录比较

```haskell
import Control.Monad.Writer

insertLog :: Int -> [Int] -> Writer [String] [Int]
insertLog x [] = do
  tell ["Insert " ++ show x ++ " at end"]
  return [x]

insertLog x (y:ys)
  | x <= y = do
      tell [show x ++ " <= " ++ show y ++ ", insert here"]
      return (x:y:ys)

  | otherwise = do
      tell [show x ++ " > " ++ show y ++ ", keep looking"]
      rest <- insertLog x ys
      return (y:rest)
```

---

## C12. insertion sort with Writer

```haskell
import Control.Monad.Writer

insertLog :: Int -> [Int] -> Writer [String] [Int]
insertLog x [] = do
  tell ["Insert " ++ show x ++ " into empty list"]
  return [x]

insertLog x (y:ys)
  | x <= y = do
      tell [show x ++ " inserted before " ++ show y]
      return (x:y:ys)

  | otherwise = do
      tell [show x ++ " passes " ++ show y]
      rest <- insertLog x ys
      return (y:rest)

isortLog :: [Int] -> Writer [String] [Int]
isortLog [] = do
  return []

isortLog (x:xs) = do
  sorted <- isortLog xs
  insertLog x sorted
```

---

# D区：Maybe / Either + Writer 混合押题

---

## D1. 安全除法 Maybe + Writer

```haskell
import Control.Monad.Writer

safeDivLog :: Int -> Int -> Writer [String] (Maybe Int)
safeDivLog x 0 = do
  tell ["Cannot divide by zero"]
  return Nothing

safeDivLog x y = do
  tell ["Dividing " ++ show x ++ " by " ++ show y]
  return (Just (x `div` y))
```

---

## D2. 安全除法 Either + Writer

```haskell
import Control.Monad.Writer

safeDivEitherLog :: Int -> Int -> Writer [String] (Either String Int)
safeDivEitherLog x 0 = do
  tell ["Division failed"]
  return (Left "Division by zero")

safeDivEitherLog x y = do
  tell ["Division succeeded"]
  return (Right (x `div` y))
```

---

## D3. 多步计算 Maybe + Writer

```haskell
import Control.Monad.Writer

stepDiv :: Int -> Int -> Writer [String] (Maybe Int)
stepDiv _ 0 = do
  tell ["Failed: divide by zero"]
  return Nothing

stepDiv x y = do
  tell ["Dividing " ++ show x ++ " by " ++ show y]
  return (Just (x `div` y))

calcMaybeLog :: Int -> Writer [String] (Maybe Int)
calcMaybeLog x = do
  r1 <- stepDiv x 2
  case r1 of
    Nothing -> return Nothing
    Just y -> stepDiv y 3
```

---

## D4. 多步计算 Either + Writer

```haskell
import Control.Monad.Writer

stepDivE :: Int -> Int -> Writer [String] (Either String Int)
stepDivE _ 0 = do
  tell ["Failed division"]
  return (Left "Division by zero")

stepDivE x y = do
  tell ["Dividing " ++ show x ++ " by " ++ show y]
  return (Right (x `div` y))

calcEitherLog :: Int -> Writer [String] (Either String Int)
calcEitherLog x = do
  r1 <- stepDivE x 2
  case r1 of
    Left err -> return (Left err)
    Right y -> stepDivE y 3
```

---

## D5. 查找元素 Maybe + Writer

```haskell
import Control.Monad.Writer

findElemLog :: Eq a => Show a => a -> [a] -> Writer [String] (Maybe a)
findElemLog target [] = do
  tell ["Not found"]
  return Nothing

findElemLog target (x:xs) = do
  tell ["Checking " ++ show x]
  if target == x
    then do
      tell ["Found " ++ show x]
      return (Just x)
    else findElemLog target xs
```

---

## D6. validate password Either + Writer

```haskell
import Control.Monad.Writer
import Data.Char

validatePassword :: String -> Writer [String] (Either String String)
validatePassword pwd
  | length pwd < 8 = do
      tell ["Password too short"]
      return (Left "Too short")

  | not (any isDigit pwd) = do
      tell ["Password has no digit"]
      return (Left "No digit")

  | not (any isUpper pwd) = do
      tell ["Password has no uppercase letter"]
      return (Left "No uppercase letter")

  | otherwise = do
      tell ["Password accepted"]
      return (Right pwd)
```

---

## D7. parse Int Either + Writer

```haskell
import Control.Monad.Writer
import Text.Read

parseIntLog :: String -> Writer [String] (Either String Int)
parseIntLog s =
  case readMaybe s of
    Nothing -> do
      tell ["Failed to parse: " ++ s]
      return (Left "Not an integer")

    Just n -> do
      tell ["Parsed integer: " ++ show n]
      return (Right n)
```

---

# E区：State / Writer 对比型押题

---

## E1. 用 State 写计数器

```haskell
import Control.Monad.State

tick :: State Int ()
tick = do
  n <- get
  put (n + 1)
```

---

## E2. 用 Writer 写日志计数

```haskell
import Control.Monad.Writer
import Data.Monoid

tickLog :: Writer (Sum Int) ()
tickLog = do
  tell (Sum 1)
```

---

## E3. State + Writer 分开写计算器

```haskell
import Control.Monad.Writer

data CalcCmd = EnterC
             | AddC Int CalcCmd
             | SubC Int CalcCmd
             | MultC Int CalcCmd
             deriving Show

runCalcLog :: Int -> CalcCmd -> Writer [String] Int
runCalcLog acc EnterC = do
  tell ["Enter: " ++ show acc]
  return acc

runCalcLog acc (AddC n next) = do
  tell ["Add " ++ show n]
  runCalcLog (acc + n) next

runCalcLog acc (SubC n next) = do
  tell ["Subtract " ++ show n]
  runCalcLog (acc - n) next

runCalcLog acc (MultC n next) = do
  tell ["Multiply by " ++ show n]
  runCalcLog (acc * n) next
```

---

## E4. Calculator with Writer log

```haskell
import Control.Monad.Writer

data CalcCmd = EnterC
             | StoreC Int CalcCmd
             | AddC Int CalcCmd
             | MultC Int CalcCmd
             | DivC Int CalcCmd
             | SubC Int CalcCmd
             deriving Show

run :: Int -> CalcCmd -> Writer [String] (Either String Int)
run x EnterC = do
  tell ["Final value: " ++ show x]
  return (Right x)

run x (StoreC n c) = do
  tell ["Store " ++ show n]
  run n c

run x (AddC n c) = do
  tell ["Add " ++ show n]
  run (x + n) c

run x (MultC n c) = do
  tell ["Multiply by " ++ show n]
  run (x * n) c

run x (SubC n c) = do
  tell ["Subtract " ++ show n]
  run (x - n) c

run x (DivC 0 c) = do
  tell ["Division by zero"]
  return (Left "Division by zero")

run x (DivC n c) = do
  tell ["Divide by " ++ show n]
  run (x `div` n) c
```

---

## E5. Nim move with Writer log

```haskell
import Control.Monad.Writer

type NimBoard = (Int, Int)

data Heap = First | Second
  deriving Show

takeTokensLog :: Int -> Heap -> NimBoard -> Writer [String] NimBoard
takeTokensLog i First (h1, h2) = do
  tell ["Taking " ++ show i ++ " from first heap"]
  return (max 0 (h1 - i), h2)

takeTokensLog i Second (h1, h2) = do
  tell ["Taking " ++ show i ++ " from second heap"]
  return (h1, max 0 (h2 - i))
```

---

# F区：Reader / Writer / State 区分题

---

## F1. Reader 读取环境

```haskell
import Control.Monad.Reader

askName :: Reader String String
askName = do
  name <- ask
  return ("Hello " ++ name)
```

---

## F2. Writer 记录日志

```haskell
import Control.Monad.Writer

writeLog :: Writer [String] Int
writeLog = do
  tell ["Starting"]
  tell ["Returning 10"]
  return 10
```

---

## F3. State 修改状态

```haskell
import Control.Monad.State

changeState :: State Int ()
changeState = do
  x <- get
  put (x + 1)
```

---

## F4. 三者一句话区别

```haskell
Reader r a
-- 读取环境 r，返回 a

Writer w a
-- 产生日志 w，返回 a

State s a
-- 修改状态 s，返回 a
```

---

# G区：Writer 常用函数押题

---

## G1. runWriter / evalWriter / execWriter

```haskell
import Control.Monad.Writer

example :: Writer [String] Int
example = do
  tell ["Start"]
  tell ["Calculate"]
  return 42
```

```haskell
runWriter example
-- (42, ["Start", "Calculate"])

evalWriter example
-- 42

execWriter example
-- ["Start", "Calculate"]
```

---

## G2. tell 最小例子

```haskell
import Control.Monad.Writer

helloLog :: Writer [String] ()
helloLog = do
  tell ["Hello"]
  tell ["World"]
```

```haskell
runWriter helloLog
-- ((), ["Hello", "World"])
```

---

## G3. listen 用法

```haskell
import Control.Monad.Writer

exampleListen :: Writer [String] (Int, [String])
exampleListen = do
  listen $ do
    tell ["A"]
    tell ["B"]
    return 10
```

```haskell
runWriter exampleListen
-- ((10, ["A", "B"]), ["A", "B"])
```

---

## G4. listens 用法

```haskell
import Control.Monad.Writer

exampleListens :: Writer [String] (Int, Int)
exampleListens = do
  listens length $ do
    tell ["A"]
    tell ["B"]
    tell ["C"]
    return 10
```

```haskell
runWriter exampleListens
-- ((10, 3), ["A", "B", "C"])
```

---

## G5. censor 用法

```haskell
import Control.Monad.Writer

exampleCensor :: Writer [String] Int
exampleCensor = do
  censor (map ("LOG: " ++)) $ do
    tell ["Start"]
    tell ["End"]
    return 100
```

```haskell
runWriter exampleCensor
-- (100, ["LOG: Start", "LOG: End"])
```

---

## G6. pass 用法

```haskell
import Control.Monad.Writer

examplePass :: Writer [String] Int
examplePass = do
  pass $ do
    tell ["hello"]
    return (10, map (++ "!"))
```

```haskell
runWriter examplePass
-- (10, ["hello!"])
```

---

# H区：Writer 日志类型变化题

---

## H1. Writer [String]

```haskell
import Control.Monad.Writer

logStrings :: Writer [String] ()
logStrings = do
  tell ["one"]
  tell ["two"]
```

---

## H2. Writer String

```haskell
import Control.Monad.Writer

logString :: Writer String ()
logString = do
  tell "hello "
  tell "world"
```

```haskell
runWriter logString
-- ((), "hello world")
```

---

## H3. Writer (Sum Int)

```haskell
import Control.Monad.Writer
import Data.Monoid

countOne :: Writer (Sum Int) ()
countOne = do
  tell (Sum 1)
```

```haskell
getSum (execWriter countOne)
-- 1
```

---

## H4. Writer (Product Int)

```haskell
import Control.Monad.Writer
import Data.Monoid

multiplyLog :: Writer (Product Int) ()
multiplyLog = do
  tell (Product 2)
  tell (Product 3)
```

```haskell
getProduct (execWriter multiplyLog)
-- 6
```

---

## H5. Writer (Any)

```haskell
import Control.Monad.Writer
import Data.Monoid

anyLog :: Writer Any ()
anyLog = do
  tell (Any False)
  tell (Any True)
```

```haskell
getAny (execWriter anyLog)
-- True
```

---

## H6. Writer (All)

```haskell
import Control.Monad.Writer
import Data.Monoid

allLog :: Writer All ()
allLog = do
  tell (All True)
  tell (All False)
```

```haskell
getAll (execWriter allLog)
-- False
```

---

# I区：Applicative / Monad 风格 Writer

---

## I1. do 版本

```haskell
import Control.Monad.Writer

addDo :: Writer [String] Int
addDo = do
  tell ["Getting x"]
  let x = 3
  tell ["Getting y"]
  let y = 4
  return (x + y)
```

---

## I2. bind 版本

```haskell
import Control.Monad.Writer

addBind :: Writer [String] Int
addBind =
  tell ["Getting x"] >>
  return 3 >>= \x ->
  tell ["Getting y"] >>
  return 4 >>= \y ->
  return (x + y)
```

---

## I3. fmap 版本

```haskell
import Control.Monad.Writer

valueLog :: Writer [String] Int
valueLog = do
  tell ["Value is 10"]
  return 10

plusOneLog :: Writer [String] Int
plusOneLog = fmap (+1) valueLog
```

---

## I4. applicative 版本

```haskell
import Control.Monad.Writer

xLog :: Writer [String] Int
xLog = do
  tell ["x = 3"]
  return 3

yLog :: Writer [String] Int
yLog = do
  tell ["y = 4"]
  return 4

addApplicative :: Writer [String] Int
addApplicative = (+) <$> xLog <*> yLog
```

---

# J区：考试最后速背模板

---

## J1. Writer [String] ()

```haskell
import Control.Monad.Writer

f :: Input -> Writer [String] ()
f x = do
  tell ["some message"]
```

---

## J2. Writer [String] a

```haskell
import Control.Monad.Writer

f :: Input -> Writer [String] Output
f x = do
  tell ["some message"]
  return result
```

---

## J3. mapM 模板

```haskell
f :: a -> Writer [String] b
f x = do
  tell ["processing"]
  return result

g :: [a] -> Writer [String] [b]
g xs = do
  mapM f xs
```

---

## J4. mapM_ 模板

```haskell
f :: a -> Writer [String] ()
f x = do
  tell ["processing"]

g :: [a] -> Writer [String] ()
g xs = do
  mapM_ f xs
```

---

## J5. foldM 模板

```haskell
import Control.Monad.Writer
import Control.Monad

step :: acc -> x -> Writer [String] acc
step acc x = do
  tell ["one step"]
  return newAcc

f :: [x] -> Writer [String] acc
f xs = do
  foldM step initialValue xs
```

---

## J6. 递归结构 Writer 模板

```haskell
import Control.Monad.Writer

f :: Structure -> Writer [String] Result
f BaseCase = do
  tell ["base case"]
  return baseResult

f (RecursiveCase x children) = do
  tell ["before recursion"]
  results <- mapM f children
  tell ["after recursion"]
  return finalResult
```

---

# 最后：Writer 高频考点一句话背诵

```haskell
tell log
```

把 `log` 加进 Writer。

---

```haskell
runWriter action
```

得到：

```haskell
(result, log)
```

---

```haskell
evalWriter action
```

只要结果：

```haskell
result
```

---

```haskell
execWriter action
```

只要日志：

```haskell
log
```

---

```haskell
mapM f xs
```

执行每个 monadic action，并收集返回值。

---

```haskell
mapM_ f xs
```

执行每个 monadic action，但不收集返回值。

---

```haskell
Writer [String] ()
```

最常见：只记录日志，不返回有用值。

---

```haskell
Writer [String] a
```

记录日志，同时返回一个真正结果。

---

```haskell
Writer (Sum Int) ()
```

最常见：用 Writer 统计数量。

---

# 最可能直接出原题的 10 个代码骨架

## 1

```haskell
logTraverse (File name _) = tell [...]
logTraverse (SubDir name contents) = do
  tell [...]
  mapM_ logTraverse contents
  tell [...]
```

## 2

```haskell
collectFiles (File name _) = do
  tell [...]
  return [name]

collectFiles (SubDir name contents) = do
  files <- mapM collectFiles contents
  return (concat files)
```

## 3

```haskell
findFile target (File name content) = do
  tell [...]
  if target == name
    then return (Just content)
    else return Nothing
```

## 4

```haskell
inorderLog Empty = return []
inorderLog (Node l x r) = do
  left <- inorderLog l
  tell [...]
  right <- inorderLog r
  return (left ++ [x] ++ right)
```

## 5

```haskell
filterLog p (x:xs)
  | p x = do
      tell [...]
      rest <- filterLog p xs
      return (x:rest)
  | otherwise = do
      tell [...]
      filterLog p xs
```

## 6

```haskell
foldM step initial xs
```

## 7

```haskell
tell (Sum 1)
```

## 8

```haskell
runWriter action
evalWriter action
execWriter action
```

## 9

```haskell
listen action
```

## 10

```haskell
censor f action
```

