# Writer Monad 押题答案集（按命中率排序）

> 主题：Haskell `Writer` Monad  
> 风格：标题 + 答案代码为主，少解释  
> 重点：`tell`、`mapM_`、`runWriter`、`execWriter`、`Writer [String] ()`、递归遍历结构、日志记录

---

## 目录

- [A区：最高命中率 Writer 基础遍历题](#a区最高命中率-writer-基础遍历题)
  - [A1. 遍历目录结构并记录进入/离开文件夹](#a1-遍历目录结构并记录进入离开文件夹)
  - [A2. 遍历目录，只记录文件名](#a2-遍历目录只记录文件名)
  - [A3. 遍历目录，记录完整路径](#a3-遍历目录记录完整路径)
  - [A4. 遍历目录，记录缩进日志](#a4-遍历目录记录缩进日志)
  - [A5. 统计文件数量，使用 Writer Sum](#a5-统计文件数量使用-writer-sum)
- [B区：高命中率 Tree + Writer](#b区高命中率-tree--writer)
  - [B1. 遍历二叉树并记录访问节点](#b1-遍历二叉树并记录访问节点)
  - [B2. 中序遍历二叉树并记录日志](#b2-中序遍历二叉树并记录日志)
  - [B3. 在树中查找元素并记录路径](#b3-在树中查找元素并记录路径)
  - [B4. 计算树大小并记录经过的节点](#b4-计算树大小并记录经过的节点)
- [C区：高命中率 List + Writer](#c区高命中率-list--writer)
  - [C1. 对 list 每个元素执行操作并记录日志](#c1-对-list-每个元素执行操作并记录日志)
  - [C2. 过滤 list 并记录保留/丢弃](#c2-过滤-list-并记录保留丢弃)
  - [C3. foldM 风格累加并记录每一步](#c3-foldm-风格累加并记录每一步)
  - [C4. mapM_ 版本只记录不收集结果](#c4-mapm_-版本只记录不收集结果)
- [D区：Writer + Maybe / Either 混合题](#d区writer--maybe--either-混合题)
  - [D1. 安全除法并记录步骤，失败用 Maybe](#d1-安全除法并记录步骤失败用-maybe)
  - [D2. Either 报错 + Writer 记录成功步骤](#d2-either-报错--writer-记录成功步骤)
  - [D3. 查找文件，找不到返回 Nothing，但记录经过路径](#d3-查找文件找不到返回-nothing但记录经过路径)
- [E区：Writer 常用函数押题](#e区writer-常用函数押题)
  - [E1. runWriter / execWriter / evalWriter](#e1-runwriter--execwriter--evalwriter)
  - [E2. tell 的最小例子](#e2-tell-的最小例子)
  - [E3. listen 的用法](#e3-listen-的用法)
  - [E4. censor 的用法](#e4-censor-的用法)
- [F区：完整可背模板](#f区完整可背模板)
  - [F1. Writer [String] () 模板](#f1-writer-string--模板)
  - [F2. Writer [String] a 模板](#f2-writer-string-a-模板)
  - [F3. Writer (Sum Int) a 模板](#f3-writer-sum-int-a-模板)
  - [F4. 递归结构 + Writer 模板](#f4-递归结构--writer-模板)

---

# A区：最高命中率 Writer 基础遍历题

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

运行：

```haskell
runWriter (logTraverse recipes)
execWriter (logTraverse recipes)
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

## A3. 遍历目录，记录完整路径

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

## A4. 遍历目录，记录缩进日志

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

## A5. 统计文件数量，使用 Writer Sum

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

运行：

```haskell
getSum (execWriter (countFiles recipes))
```

---

# B区：高命中率 Tree + Writer

---

## B1. 遍历二叉树并记录访问节点

```haskell
import Control.Monad.Writer

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            deriving Show

logTree :: Show a => Tree a -> Writer [String] ()
logTree Empty = do
  tell ["Empty"]

logTree (Node l x r) = do
  tell ["Visit: " ++ show x]
  logTree l
  logTree r
```

---

## B2. 中序遍历二叉树并记录日志

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
  left  <- inorderLog l
  tell ["Visit: " ++ show x]
  right <- inorderLog r
  return (left ++ [x] ++ right)
```

---

## B3. 在树中查找元素并记录路径

```haskell
import Control.Monad.Writer

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            deriving Show

findLog :: Eq a => a -> Tree a -> Writer [String] Bool
findLog target Empty = do
  tell ["Reached Empty"]
  return False

findLog target (Node l x r) = do
  tell ["Checking node"]
  if target == x
    then do
      tell ["Found target"]
      return True
    else do
      tell ["Go left"]
      foundLeft <- findLog target l
      if foundLeft
        then return True
        else do
          tell ["Go right"]
          findLog target r
```

---

## B4. 计算树大小并记录经过的节点

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
  leftSize  <- sizeLog l
  rightSize <- sizeLog r
  return (1 + leftSize + rightSize)
```

---

# C区：高命中率 List + Writer

---

## C1. 对 list 每个元素执行操作并记录日志

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

## C2. 过滤 list 并记录保留/丢弃

```haskell
import Control.Monad.Writer

filterLog :: (Show a) => (a -> Bool) -> [a] -> Writer [String] [a]
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

## C3. foldM 风格累加并记录每一步

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

## C4. mapM_ 版本只记录不收集结果

```haskell
import Control.Monad.Writer

printLog :: Show a => a -> Writer [String] ()
printLog x = do
  tell ["Saw: " ++ show x]

logAll :: Show a => [a] -> Writer [String] ()
logAll xs = do
  mapM_ printLog xs
```

---

# D区：Writer + Maybe / Either 混合题

---

## D1. 安全除法并记录步骤，失败用 Maybe

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

## D2. Either 报错 + Writer 记录成功步骤

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

## D3. 查找文件，找不到返回 Nothing，但记录经过路径

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
      tell ["Found file: " ++ name]
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

# E区：Writer 常用函数押题

---

## E1. runWriter / execWriter / evalWriter

```haskell
import Control.Monad.Writer

example :: Writer [String] Int
example = do
  tell ["Start"]
  tell ["Calculating"]
  return 42
```

```haskell
runWriter example
-- (42, ["Start", "Calculating"])

evalWriter example
-- 42

execWriter example
-- ["Start", "Calculating"]
```

---

## E2. tell 的最小例子

```haskell
import Control.Monad.Writer

helloLog :: Writer [String] ()
helloLog = do
  tell ["Hello"]
  tell ["World"]
```

运行：

```haskell
runWriter helloLog
-- ((), ["Hello", "World"])
```

---

## E3. listen 的用法

```haskell
import Control.Monad.Writer

exampleListen :: Writer [String] (Int, [String])
exampleListen = do
  listen $ do
    tell ["A"]
    tell ["B"]
    return 10
```

运行：

```haskell
runWriter exampleListen
-- ((10, ["A", "B"]), ["A", "B"])
```

---

## E4. censor 的用法

```haskell
import Control.Monad.Writer

exampleCensor :: Writer [String] Int
exampleCensor = do
  censor (map ("LOG: " ++)) $ do
    tell ["Start"]
    tell ["End"]
    return 100
```

运行：

```haskell
runWriter exampleCensor
-- (100, ["LOG: Start", "LOG: End"])
```

---

# F区：完整可背模板

---

## F1. Writer [String] () 模板

```haskell
import Control.Monad.Writer

function :: InputType -> Writer [String] ()
function input = do
  tell ["some log"]
  return ()
```

更常见：

```haskell
function :: InputType -> Writer [String] ()
function input = do
  tell ["some log"]
```

---

## F2. Writer [String] a 模板

```haskell
import Control.Monad.Writer

function :: InputType -> Writer [String] ResultType
function input = do
  tell ["some log"]
  return result
```

---

## F3. Writer (Sum Int) a 模板

```haskell
import Control.Monad.Writer
import Data.Monoid

function :: InputType -> Writer (Sum Int) ResultType
function input = do
  tell (Sum 1)
  return result
```

取结果：

```haskell
getSum (execWriter (function input))
```

---

## F4. 递归结构 + Writer 模板

```haskell
import Control.Monad.Writer

function :: Structure -> Writer [String] ()
function BaseCase = do
  tell ["base case"]

function (RecursiveCase x xs) = do
  tell ["before recursion"]
  mapM_ function xs
  tell ["after recursion"]
```

---

# 最容易考的核心答案总结

```haskell
tell ["message"]
```

表示：

```haskell
往 Writer 的日志里面添加一条 message
```

---

```haskell
Writer [String] ()
```

表示：

```haskell
这个计算不返回重要值，只负责记录 String 日志
```

---

```haskell
Writer [String] a
```

表示：

```haskell
这个计算返回一个 a，同时记录 String 日志
```

---

```haskell
mapM_ f xs
```

表示：

```haskell
对 xs 里面每个元素执行 monadic action f，但不收集返回值
```

---

```haskell
mapM f xs
```

表示：

```haskell
对 xs 里面每个元素执行 monadic action f，并收集返回值
```

---

```haskell
runWriter action
```

返回：

```haskell
(result, log)
```

---

```haskell
evalWriter action
```

返回：

```haskell
result
```

---

```haskell
execWriter action
```

返回：

```haskell
log
```

---

# 考试优先级排序

## 最高优先级

```haskell
Dir + Writer [String] ()
```

```haskell
tell ["Entering ..."]
mapM_ recursiveFunction contents
tell ["Leaving ..."]
```

---

## 第二优先级

```haskell
Tree + Writer [String] a
```

常见套路：

```haskell
left <- recursiveFunction l
tell [...]
right <- recursiveFunction r
return (...)
```

---

## 第三优先级

```haskell
List + mapM / mapM_
```

常见套路：

```haskell
mapM function xs
mapM_ function xs
```

---

## 第四优先级

```haskell
Writer (Sum Int)
```

常见套路：

```haskell
tell (Sum 1)
getSum (execWriter ...)
```

---

## 第五优先级

```haskell
Writer + Maybe / Either
```

常见套路：

```haskell
return Nothing
return (Just x)

return (Left "error")
return (Right x)
```

---

# 最推荐背下来的完整版本

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

