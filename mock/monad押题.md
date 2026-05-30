# Haskell FP 期末押题答案合集（按命中率从高到低）

> 只包含标题和答案代码，不包含题目解析。  
> 排序原则：先放最像考试会出的核心题，再放变化题和扩展押题。

---

# 目录

- [A. Monad / do notation 最高频押题](#a-monad--do-notation-最高频押题)
  - [A1. applyNTimes：Monad 迭代 n 次并收集中间值](#a1-applyntimesmonad-迭代-n-次并收集中间值)
  - [A2. applyNTimes：先写 helper 的版本](#a2-applyntimes先写-helper-的版本)
  - [A3. replicateM'：重复执行同一个 monadic action](#a3-replicatem重复执行同一个-monadic-action)
  - [A4. sequence'：把 `[m a]` 变成 `m [a]`](#a4-sequence把-m-a-变成-m-a)
  - [A5. mapM'：对列表中每个元素执行 monadic function](#a5-mapm对列表中每个元素执行-monadic-function)
  - [A6. filterM'：monadic predicate 过滤列表](#a6-filtermmonadic-predicate-过滤列表)
  - [A7. foldM'：monadic accumulator](#a7-foldmmonadic-accumulator)
  - [A8. zipWithM'：两个列表上的 monadic zipWith](#a8-zipwithm两个列表上的-monadic-zipwith)
- [B. Maybe Monad 高频押题](#b-maybe-monad-高频押题)
  - [B1. safeHead](#b1-safehead)
  - [B2. safeTail](#b2-safetail)
  - [B3. safeIndex：安全取第 n 个元素](#b3-safeindex安全取第-n-个元素)
  - [B4. secondElement：用 do notation 取第二个元素](#b4-secondelement用-do-notation-取第二个元素)
  - [B5. addMaybes：两个 Maybe Int 相加](#b5-addmaybes两个-maybe-int-相加)
  - [B6. sequenceMaybe：`[Maybe a] -> Maybe [a]`](#b6-sequencemaybemaybe-a---maybe-a)
  - [B7. mapMaybeM：Maybe 版本 mapM](#b7-mapmaybemmaybe-版本-mapm)
  - [B8. applyMaybeNTimes](#b8-applymaybentimes)
  - [B9. lookupMaybe：安全查表](#b9-lookupmaybe安全查表)
  - [B10. safeDivMaybe：安全除法](#b10-safedivmaybe安全除法)
  - [B11. chainDivMaybe：连续安全除法](#b11-chaindivmaybe连续安全除法)
- [C. State Monad 高频押题](#c-state-monad-高频押题)
  - [C1. tick：返回旧状态并加一](#c1-tick返回旧状态并加一)
  - [C2. tickN：执行 n 次 tick](#c2-tickn执行-n-次-tick)
  - [C3. getAndAdd：取出状态并增加指定值](#c3-getandadd取出状态并增加指定值)
  - [C4. applyStateNTimes：State 中重复更新状态并记录](#c4-applystatentimesstate-中重复更新状态并记录)
  - [C5. countList：统计列表长度到 State](#c5-countlist统计列表长度到-state)
  - [C6. sumState：把列表元素加到 State](#c6-sumstate把列表元素加到-state)
  - [C7. labelTree：给二叉树节点编号](#c7-labeltree给二叉树节点编号)
- [D. Nim / State Game 最高相关押题](#d-nim--state-game-最高相关押题)
  - [D1. Nim 类型定义](#d1-nim-类型定义)
  - [D2. gameOver：判断游戏结束](#d2-gameover判断游戏结束)
  - [D3. takeTokens：从指定 heap 拿 token](#d3-taketokens从指定-heap-拿-token)
  - [D4. takeTokens：使用 modify 的版本](#d4-taketokens使用-modify-的版本)
  - [D5. validMove：判断能不能拿](#d5-validmove判断能不能拿)
  - [D6. playMove：合法才更新](#d6-playmove合法才更新)
  - [D7. exampleGame：一串 Nim 操作](#d7-examplegame一串-nim-操作)
  - [D8. Nim 多堆版本 gameOver](#d8-nim-多堆版本-gameover)
  - [D9. Nim 多堆版本 takeTokens](#d9-nim-多堆版本-taketokens)
- [E. Either Monad 押题](#e-either-monad-押题)
  - [E1. safeDivEither](#e1-safediveither)
  - [E2. chainDivEither](#e2-chaindiveither)
  - [E3. safeHeadEither](#e3-safeheadeither)
  - [E4. safeIndexEither](#e4-safeindexeither)
  - [E5. sequenceEither](#e5-sequenceeither)
  - [E6. mapEitherM](#e6-mapeitherm)
  - [E7. validatePositive](#e7-validatepositive)
  - [E8. validateAllPositive](#e8-validateallpositive)
- [F. List Monad / nondeterminism 押题](#f-list-monad--nondeterminism-押题)
  - [F1. pairs：所有二元组合](#f1-pairs所有二元组合)
  - [F2. triples：所有三元组合](#f2-triples所有三元组合)
  - [F3. chooseTwo：选择两个不同元素](#f3-choosetwo选择两个不同元素)
  - [F4. pythagoreanTriples](#f4-pythagoreantriples)
  - [F5. allResults：对每个元素产生多个结果](#f5-allresults对每个元素产生多个结果)
  - [F6. guard 风格过滤](#f6-guard-风格过滤)
- [G. Functor / Applicative 押题](#g-functor--applicative-押题)
  - [G1. fmapMaybe](#g1-fmapmaybe)
  - [G2. applyMaybe](#g2-applymaybe)
  - [G3. liftA2Maybe](#g3-lifta2maybe)
  - [G4. Applicative 组合 Maybe](#g4-applicative-组合-maybe)
  - [G5. fmapTree](#g5-fmaptree)
  - [G6. Functor instance for BinTree](#g6-functor-instance-for-bintree)
- [H. Parser Monad 押题](#h-parser-monad-押题)
  - [H1. Parser 类型](#h1-parser-类型)
  - [H2. item](#h2-item)
  - [H3. Functor Parser](#h3-functor-parser)
  - [H4. Applicative Parser](#h4-applicative-parser)
  - [H5. Monad Parser](#h5-monad-parser)
  - [H6. three：读取三个字符](#h6-three读取三个字符)
  - [H7. sat / digit / char](#h7-sat--digit--char)
  - [H8. string](#h8-string)
- [I. Fold / map / filter 经典押题](#i-fold--map--filter-经典押题)
  - [I1. map with foldr](#i1-map-with-foldr)
  - [I2. filter with foldr](#i2-filter-with-foldr)
  - [I3. concat with foldr](#i3-concat-with-foldr)
  - [I4. length with foldr](#i4-length-with-foldr)
  - [I5. reverse with foldl](#i5-reverse-with-foldl)
  - [I6. sum with foldl](#i6-sum-with-foldl)
  - [I7. all with foldr](#i7-all-with-foldr)
  - [I8. any with foldr](#i8-any-with-foldr)
- [J. Tree / Recursive Data 高频押题](#j-tree--recursive-data-高频押题)
  - [J1. BinTree 类型](#j1-bintree-类型)
  - [J2. size](#j2-size)
  - [J3. height](#j3-height)
  - [J4. mirror](#j4-mirror)
  - [J5. occurs](#j5-occurs)
  - [J6. inorder](#j6-inorder)
  - [J7. mapTree](#j7-maptree)
  - [J8. insert BST](#j8-insert-bst)
  - [J9. isBST](#j9-isbst)
  - [J10. validRoute / subtree](#j10-validroute--subtree)
- [K. GameTree / Rose Tree 押题](#k-gametree--rose-tree-押题)
  - [K1. GameTree 类型](#k1-gametree-类型)
  - [K2. gameTree](#k2-gametree)
  - [K3. paths](#k3-paths)
  - [K4. Rose Tree size](#k4-rose-tree-size)
  - [K5. Rose Tree height](#k5-rose-tree-height)
  - [K6. prune](#k6-prune)
- [L. Typeclass / Instance 押题](#l-typeclass--instance-押题)
  - [L1. Eq instance for custom type](#l1-eq-instance-for-custom-type)
  - [L2. Ord instance for WeekDay](#l2-ord-instance-for-weekday)
  - [L3. Show instance for expression tree](#l3-show-instance-for-expression-tree)
  - [L4. Num Bool instance](#l4-num-bool-instance)
- [M. 小函数保底押题](#m-小函数保底押题)
  - [M1. safetail 三种写法](#m1-safetail-三种写法)
  - [M2. third 三种写法](#m2-third-三种写法)
  - [M3. factors](#m3-factors)
  - [M4. isPrime](#m4-isprime)
  - [M5. merge](#m5-merge)
  - [M6. msort](#m6-msort)
  - [M7. cycleOf](#m7-cycleof)
  - [M8. isPerm](#m8-isperm)

---

# A. Monad / do notation 最高频押题

## A1. applyNTimes：Monad 迭代 n 次并收集中间值

```haskell
applyNTimes :: Monad m => m a -> (a -> m a) -> Int -> m [a]
applyNTimes mx mf 0 = do
  x <- mx
  return [x]

applyNTimes mx mf n = do
  x <- mx
  xs <- applyNTimes (mf x) mf (n - 1)
  return (x : xs)
```

---

## A2. applyNTimes：先写 helper 的版本

```haskell
applyNTimes :: Monad m => m a -> (a -> m a) -> Int -> m [a]
applyNTimes mx mf n = do
  x <- mx
  go x n
  where
    go x 0 = return [x]
    go x n = do
      y <- mf x
      ys <- go y (n - 1)
      return (x : ys)
```

---

## A3. replicateM'：重复执行同一个 monadic action

```haskell
replicateM' :: Monad m => Int -> m a -> m [a]
replicateM' 0 mx = return []

replicateM' n mx = do
  x <- mx
  xs <- replicateM' (n - 1) mx
  return (x : xs)
```

---

## A4. sequence'：把 `[m a]` 变成 `m [a]`

```haskell
sequence' :: Monad m => [m a] -> m [a]
sequence' [] = return []

sequence' (mx:mxs) = do
  x <- mx
  xs <- sequence' mxs
  return (x : xs)
```

---

## A5. mapM'：对列表中每个元素执行 monadic function

```haskell
mapM' :: Monad m => (a -> m b) -> [a] -> m [b]
mapM' f [] = return []

mapM' f (x:xs) = do
  y <- f x
  ys <- mapM' f xs
  return (y : ys)
```

---

## A6. filterM'：monadic predicate 过滤列表

```haskell
filterM' :: Monad m => (a -> m Bool) -> [a] -> m [a]
filterM' p [] = return []

filterM' p (x:xs) = do
  b <- p x
  ys <- filterM' p xs
  if b
    then return (x : ys)
    else return ys
```

---

## A7. foldM'：monadic accumulator

```haskell
foldM' :: Monad m => (b -> a -> m b) -> b -> [a] -> m b
foldM' f acc [] = return acc

foldM' f acc (x:xs) = do
  acc' <- f acc x
  foldM' f acc' xs
```

---

## A8. zipWithM'：两个列表上的 monadic zipWith

```haskell
zipWithM' :: Monad m => (a -> b -> m c) -> [a] -> [b] -> m [c]
zipWithM' f [] [] = return []

zipWithM' f (x:xs) (y:ys) = do
  z <- f x y
  zs <- zipWithM' f xs ys
  return (z : zs)

zipWithM' f _ _ = return []
```

---

# B. Maybe Monad 高频押题

## B1. safeHead

```haskell
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:xs) = Just x
```

---

## B2. safeTail

```haskell
safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (x:xs) = Just xs
```

---

## B3. safeIndex：安全取第 n 个元素

```haskell
safeIndex :: [a] -> Int -> Maybe a
safeIndex [] n = Nothing

safeIndex (x:xs) 0 = Just x

safeIndex (x:xs) n
  | n < 0     = Nothing
  | otherwise = safeIndex xs (n - 1)
```

---

## B4. secondElement：用 do notation 取第二个元素

```haskell
secondElement :: [a] -> Maybe a
secondElement xs = do
  ys <- safeTail xs
  safeHead ys
```

---

## B5. addMaybes：两个 Maybe Int 相加

```haskell
addMaybes :: Maybe Int -> Maybe Int -> Maybe Int
addMaybes mx my = do
  x <- mx
  y <- my
  return (x + y)
```

---

## B6. sequenceMaybe：`[Maybe a] -> Maybe [a]`

```haskell
sequenceMaybe :: [Maybe a] -> Maybe [a]
sequenceMaybe [] = Just []

sequenceMaybe (mx:mxs) = do
  x <- mx
  xs <- sequenceMaybe mxs
  return (x : xs)
```

---

## B7. mapMaybeM：Maybe 版本 mapM

```haskell
mapMaybeM :: (a -> Maybe b) -> [a] -> Maybe [b]
mapMaybeM f [] = Just []

mapMaybeM f (x:xs) = do
  y <- f x
  ys <- mapMaybeM f xs
  return (y : ys)
```

---

## B8. applyMaybeNTimes

```haskell
applyMaybeNTimes :: Maybe a -> (a -> Maybe a) -> Int -> Maybe [a]
applyMaybeNTimes mx mf 0 = do
  x <- mx
  return [x]

applyMaybeNTimes mx mf n = do
  x <- mx
  xs <- applyMaybeNTimes (mf x) mf (n - 1)
  return (x : xs)
```

---

## B9. lookupMaybe：安全查表

```haskell
lookupMaybe :: Eq a => a -> [(a,b)] -> Maybe b
lookupMaybe k [] = Nothing

lookupMaybe k ((x,y):xys)
  | k == x    = Just y
  | otherwise = lookupMaybe k xys
```

---

## B10. safeDivMaybe：安全除法

```haskell
safeDivMaybe :: Int -> Int -> Maybe Int
safeDivMaybe x 0 = Nothing
safeDivMaybe x y = Just (x `div` y)
```

---

## B11. chainDivMaybe：连续安全除法

```haskell
chainDivMaybe :: Int -> [Int] -> Maybe Int
chainDivMaybe x [] = Just x

chainDivMaybe x (y:ys) = do
  z <- safeDivMaybe x y
  chainDivMaybe z ys
```

---

# C. State Monad 高频押题

## C1. tick：返回旧状态并加一

```haskell
import Control.Monad.State

tick :: State Int Int
tick = do
  n <- get
  put (n + 1)
  return n
```

---

## C2. tickN：执行 n 次 tick

```haskell
tickN :: Int -> State Int [Int]
tickN 0 = return []

tickN n = do
  x <- tick
  xs <- tickN (n - 1)
  return (x : xs)
```

---

## C3. getAndAdd：取出状态并增加指定值

```haskell
getAndAdd :: Int -> State Int Int
getAndAdd k = do
  n <- get
  put (n + k)
  return n
```

---

## C4. applyStateNTimes：State 中重复更新状态并记录

```haskell
applyStateNTimes :: (s -> s) -> Int -> State s [s]
applyStateNTimes f 0 = do
  s <- get
  return [s]

applyStateNTimes f n = do
  s <- get
  put (f s)
  ss <- applyStateNTimes f (n - 1)
  return (s : ss)
```

---

## C5. countList：统计列表长度到 State

```haskell
countList :: [a] -> State Int ()
countList [] = return ()

countList (x:xs) = do
  n <- get
  put (n + 1)
  countList xs
```

---

## C6. sumState：把列表元素加到 State

```haskell
sumState :: [Int] -> State Int ()
sumState [] = return ()

sumState (x:xs) = do
  n <- get
  put (n + x)
  sumState xs
```

---

## C7. labelTree：给二叉树节点编号

```haskell
import Control.Monad.State

data BinTree a = Empty | Node (BinTree a) a (BinTree a)
  deriving Show

labelTree :: BinTree a -> State Int (BinTree (Int, a))
labelTree Empty = return Empty

labelTree (Node l x r) = do
  l' <- labelTree l
  n <- get
  put (n + 1)
  r' <- labelTree r
  return (Node l' (n, x) r')
```

---

# D. Nim / State Game 最高相关押题

## D1. Nim 类型定义

```haskell
import Control.Monad.State

type NimBoard = (Int, Int)
type NimGame a = State NimBoard a

data Heap = First | Second
  deriving Show
```

---

## D2. gameOver：判断游戏结束

```haskell
gameOver :: NimGame Bool
gameOver = do
  (h1, h2) <- get
  return (h1 == 0 && h2 == 0)
```

---

## D3. takeTokens：从指定 heap 拿 token

```haskell
takeTokens :: Int -> Heap -> NimGame ()
takeTokens i First = do
  (h1, h2) <- get
  put (max 0 (h1 - i), h2)

takeTokens i Second = do
  (h1, h2) <- get
  put (h1, max 0 (h2 - i))
```

---

## D4. takeTokens：使用 modify 的版本

```haskell
takeTokens :: Int -> Heap -> NimGame ()
takeTokens i First =
  modify (\(h1, h2) -> (max 0 (h1 - i), h2))

takeTokens i Second =
  modify (\(h1, h2) -> (h1, max 0 (h2 - i)))
```

---

## D5. validMove：判断能不能拿

```haskell
validMove :: Int -> Heap -> NimGame Bool
validMove i First = do
  (h1, h2) <- get
  return (i > 0 && h1 >= i)

validMove i Second = do
  (h1, h2) <- get
  return (i > 0 && h2 >= i)
```

---

## D6. playMove：合法才更新

```haskell
playMove :: Int -> Heap -> NimGame Bool
playMove i h = do
  ok <- validMove i h
  if ok
    then do
      takeTokens i h
      return True
    else return False
```

---

## D7. exampleGame：一串 Nim 操作

```haskell
exampleGame :: NimGame Bool
exampleGame = do
  takeTokens 2 First
  takeTokens 1 Second
  takeTokens 10 First
  gameOver
```

---

## D8. Nim 多堆版本 gameOver

```haskell
type NimBoardN = [Int]
type NimGameN a = State NimBoardN a

gameOverN :: NimGameN Bool
gameOverN = do
  heaps <- get
  return (all (== 0) heaps)
```

---

## D9. Nim 多堆版本 takeTokens

```haskell
takeTokensN :: Int -> Int -> NimGameN ()
takeTokensN i heapIndex = do
  heaps <- get
  put (takeFrom heapIndex heaps)
  where
    takeFrom 0 (h:hs) = max 0 (h - i) : hs
    takeFrom n (h:hs) = h : takeFrom (n - 1) hs
    takeFrom n []     = []
```

---

# E. Either Monad 押题

## E1. safeDivEither

```haskell
safeDivEither :: Int -> Int -> Either String Int
safeDivEither x 0 = Left "cannot divide by zero"
safeDivEither x y = Right (x `div` y)
```

---

## E2. chainDivEither

```haskell
chainDivEither :: Int -> [Int] -> Either String Int
chainDivEither x [] = Right x

chainDivEither x (y:ys) = do
  z <- safeDivEither x y
  chainDivEither z ys
```

---

## E3. safeHeadEither

```haskell
safeHeadEither :: [a] -> Either String a
safeHeadEither [] = Left "empty list"
safeHeadEither (x:xs) = Right x
```

---

## E4. safeIndexEither

```haskell
safeIndexEither :: [a] -> Int -> Either String a
safeIndexEither [] n = Left "index out of bounds"

safeIndexEither (x:xs) 0 = Right x

safeIndexEither (x:xs) n
  | n < 0     = Left "negative index"
  | otherwise = safeIndexEither xs (n - 1)
```

---

## E5. sequenceEither

```haskell
sequenceEither :: [Either e a] -> Either e [a]
sequenceEither [] = Right []

sequenceEither (mx:mxs) = do
  x <- mx
  xs <- sequenceEither mxs
  return (x : xs)
```

---

## E6. mapEitherM

```haskell
mapEitherM :: (a -> Either e b) -> [a] -> Either e [b]
mapEitherM f [] = Right []

mapEitherM f (x:xs) = do
  y <- f x
  ys <- mapEitherM f xs
  return (y : ys)
```

---

## E7. validatePositive

```haskell
validatePositive :: Int -> Either String Int
validatePositive x
  | x > 0     = Right x
  | otherwise = Left "not positive"
```

---

## E8. validateAllPositive

```haskell
validateAllPositive :: [Int] -> Either String [Int]
validateAllPositive [] = Right []

validateAllPositive (x:xs) = do
  y <- validatePositive x
  ys <- validateAllPositive xs
  return (y : ys)
```

---

# F. List Monad / nondeterminism 押题

## F1. pairs：所有二元组合

```haskell
pairs :: [a] -> [b] -> [(a,b)]
pairs xs ys = do
  x <- xs
  y <- ys
  return (x, y)
```

---

## F2. triples：所有三元组合

```haskell
triples :: [a] -> [b] -> [c] -> [(a,b,c)]
triples xs ys zs = do
  x <- xs
  y <- ys
  z <- zs
  return (x, y, z)
```

---

## F3. chooseTwo：选择两个不同元素

```haskell
chooseTwo :: Eq a => [a] -> [(a,a)]
chooseTwo xs = do
  x <- xs
  y <- xs
  if x /= y
    then return (x, y)
    else []
```

---

## F4. pythagoreanTriples

```haskell
pythagoreanTriples :: Int -> [(Int, Int, Int)]
pythagoreanTriples n = do
  a <- [1..n]
  b <- [1..n]
  c <- [1..n]
  if a * a + b * b == c * c
    then return (a, b, c)
    else []
```

---

## F5. allResults：对每个元素产生多个结果

```haskell
allResults :: (a -> [b]) -> [a] -> [b]
allResults f [] = []

allResults f (x:xs) = do
  y <- f x
  ys <- allResults f xs
  return y ++ [ys]
```

---

## F6. guard 风格过滤

```haskell
guard' :: Bool -> [()]
guard' True = [()]
guard' False = []

evens :: [Int] -> [Int]
evens xs = do
  x <- xs
  guard' (even x)
  return x
```

---

# G. Functor / Applicative 押题

## G1. fmapMaybe

```haskell
fmapMaybe :: (a -> b) -> Maybe a -> Maybe b
fmapMaybe f Nothing = Nothing
fmapMaybe f (Just x) = Just (f x)
```

---

## G2. applyMaybe

```haskell
applyMaybe :: Maybe (a -> b) -> Maybe a -> Maybe b
applyMaybe Nothing mx = Nothing
applyMaybe mf Nothing = Nothing
applyMaybe (Just f) (Just x) = Just (f x)
```

---

## G3. liftA2Maybe

```haskell
liftA2Maybe :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
liftA2Maybe f mx my = do
  x <- mx
  y <- my
  return (f x y)
```

---

## G4. Applicative 组合 Maybe

```haskell
addThreeMaybe :: Maybe Int -> Maybe Int -> Maybe Int -> Maybe Int
addThreeMaybe mx my mz =
  pure (\x y z -> x + y + z) <*> mx <*> my <*> mz
```

---

## G5. fmapTree

```haskell
data Tree a = Leaf a | Branch (Tree a) (Tree a)
  deriving Show

fmapTree :: (a -> b) -> Tree a -> Tree b
fmapTree f (Leaf x) = Leaf (f x)

fmapTree f (Branch l r) =
  Branch (fmapTree f l) (fmapTree f r)
```

---

## G6. Functor instance for BinTree

```haskell
data BinTree a = Empty | Node (BinTree a) a (BinTree a)
  deriving Show

instance Functor BinTree where
  fmap f Empty = Empty
  fmap f (Node l x r) =
    Node (fmap f l) (f x) (fmap f r)
```

---

# H. Parser Monad 押题

## H1. Parser 类型

```haskell
newtype Parser a = P (String -> [(a, String)])
```

---

## H2. item

```haskell
item :: Parser Char
item = P (\input ->
  case input of
    []     -> []
    (x:xs) -> [(x, xs)])
```

---

## H3. Functor Parser

```haskell
instance Functor Parser where
  fmap f (P p) =
    P (\input -> [(f x, rest) | (x, rest) <- p input])
```

---

## H4. Applicative Parser

```haskell
instance Applicative Parser where
  pure x = P (\input -> [(x, input)])

  (P pf) <*> (P px) =
    P (\input -> [(f x, rest2) |
      (f, rest1) <- pf input,
      (x, rest2) <- px rest1])
```

---

## H5. Monad Parser

```haskell
instance Monad Parser where
  (P p) >>= f =
    P (\input -> concat [parse (f x) rest | (x, rest) <- p input])
```

```haskell
parse :: Parser a -> String -> [(a, String)]
parse (P p) input = p input
```

---

## H6. three：读取三个字符

```haskell
three :: Parser (Char, Char)
three = do
  x <- item
  item
  z <- item
  return (x, z)
```

---

## H7. sat / digit / char

```haskell
sat :: (Char -> Bool) -> Parser Char
sat p = do
  x <- item
  if p x
    then return x
    else P (\input -> [])
```

```haskell
digit :: Parser Char
digit = sat (`elem` ['0'..'9'])
```

```haskell
char :: Char -> Parser Char
char c = sat (== c)
```

---

## H8. string

```haskell
string :: String -> Parser String
string [] = return []

string (x:xs) = do
  char x
  string xs
  return (x:xs)
```

---

# I. Fold / map / filter 经典押题

## I1. map with foldr

```haskell
map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs
```

---

## I2. filter with foldr

```haskell
filter' :: (a -> Bool) -> [a] -> [a]
filter' p xs =
  foldr (\x acc -> if p x then x : acc else acc) [] xs
```

---

## I3. concat with foldr

```haskell
concat' :: [[a]] -> [a]
concat' xss = foldr (++) [] xss
```

---

## I4. length with foldr

```haskell
length' :: [a] -> Int
length' xs = foldr (\x acc -> acc + 1) 0 xs
```

---

## I5. reverse with foldl

```haskell
reverse' :: [a] -> [a]
reverse' xs = foldl (\acc x -> x : acc) [] xs
```

---

## I6. sum with foldl

```haskell
sum' :: Num a => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs
```

---

## I7. all with foldr

```haskell
all' :: (a -> Bool) -> [a] -> Bool
all' p xs = foldr (\x acc -> p x && acc) True xs
```

---

## I8. any with foldr

```haskell
any' :: (a -> Bool) -> [a] -> Bool
any' p xs = foldr (\x acc -> p x || acc) False xs
```

---

# J. Tree / Recursive Data 高频押题

## J1. BinTree 类型

```haskell
data BinTree a = Empty | Node (BinTree a) a (BinTree a)
  deriving (Eq, Show)
```

---

## J2. size

```haskell
size :: BinTree a -> Int
size Empty = 0

size (Node l x r) =
  1 + size l + size r
```

---

## J3. height

```haskell
height :: BinTree a -> Int
height Empty = 0

height (Node l x r) =
  1 + max (height l) (height r)
```

---

## J4. mirror

```haskell
mirror :: BinTree a -> BinTree a
mirror Empty = Empty

mirror (Node l x r) =
  Node (mirror r) x (mirror l)
```

---

## J5. occurs

```haskell
occurs :: Eq a => a -> BinTree a -> Bool
occurs x Empty = False

occurs x (Node l y r) =
  x == y || occurs x l || occurs x r
```

---

## J6. inorder

```haskell
inorder :: BinTree a -> [a]
inorder Empty = []

inorder (Node l x r) =
  inorder l ++ [x] ++ inorder r
```

---

## J7. mapTree

```haskell
mapTree :: (a -> b) -> BinTree a -> BinTree b
mapTree f Empty = Empty

mapTree f (Node l x r) =
  Node (mapTree f l) (f x) (mapTree f r)
```

---

## J8. insert BST

```haskell
insert :: Ord a => a -> BinTree a -> BinTree a
insert x Empty = Node Empty x Empty

insert x (Node l y r)
  | x <= y    = Node (insert x l) y r
  | otherwise = Node l y (insert x r)
```

---

## J9. isBST

```haskell
isBST :: Ord a => BinTree a -> Bool
isBST t = ordered (inorder t)
  where
    ordered [] = True
    ordered [x] = True
    ordered (x:y:xs) = x <= y && ordered (y:xs)
```

---

## J10. validRoute / subtree

```haskell
data Direction = GoLeft | GoRight
  deriving (Eq, Show)

type Route = [Direction]
```

```haskell
validRoute :: Route -> BinTree a -> Bool
validRoute [] Empty = False
validRoute [] (Node l x r) = True

validRoute (GoLeft:ds) (Node l x r) =
  validRoute ds l

validRoute (GoRight:ds) (Node l x r) =
  validRoute ds r

validRoute ds Empty = False
```

```haskell
subtree :: Route -> BinTree a -> Maybe (BinTree a)
subtree [] Empty = Nothing
subtree [] t = Just t

subtree (GoLeft:ds) (Node l x r) =
  subtree ds l

subtree (GoRight:ds) (Node l x r) =
  subtree ds r

subtree ds Empty = Nothing
```

---

# K. GameTree / Rose Tree 押题

## K1. GameTree 类型

```haskell
data GameTree board move =
  Node board [(move, GameTree board move)]
  deriving Show
```

---

## K2. gameTree

```haskell
gameTree :: (board -> [(move, board)]) -> board -> GameTree board move
gameTree plays board =
  Node board [(m, gameTree plays b) | (m, b) <- plays board]
```

---

## K3. paths

```haskell
paths :: GameTree board move -> [[move]]
paths (Node board []) = [[]]

paths (Node board moves) =
  [m : path | (m, tree) <- moves, path <- paths tree]
```

---

## K4. Rose Tree size

```haskell
data Rose a = Leaf a | Branch [Rose a]
  deriving Show

rsize :: Rose a -> Int
rsize (Leaf x) = 1

rsize (Branch ts) =
  1 + sum (map rsize ts)
```

---

## K5. Rose Tree height

```haskell
rheight :: Rose a -> Int
rheight (Leaf x) = 1

rheight (Branch []) = 1

rheight (Branch ts) =
  1 + maximum (map rheight ts)
```

---

## K6. prune

```haskell
prune :: Int -> Rose a -> Rose a
prune 0 t = Branch []

prune n (Leaf x) = Leaf x

prune n (Branch ts) =
  Branch (map (prune (n - 1)) ts)
```

---

# L. Typeclass / Instance 押题

## L1. Eq instance for custom type

```haskell
data Colour = Red | Green | Blue

instance Eq Colour where
  Red == Red = True
  Green == Green = True
  Blue == Blue = True
  _ == _ = False
```

---

## L2. Ord instance for WeekDay

```haskell
data WeekDay =
    Mon | Tue | Wed | Thu | Fri | Sat | Sun
    deriving (Eq, Show)

instance Ord WeekDay where
  compare Mon Mon = EQ
  compare Mon _   = LT

  compare Tue Mon = GT
  compare Tue Tue = EQ
  compare Tue _   = LT

  compare Wed Mon = GT
  compare Wed Tue = GT
  compare Wed Wed = EQ
  compare Wed _   = LT

  compare Thu Fri = LT
  compare Thu Sat = LT
  compare Thu Sun = LT
  compare Thu Thu = EQ
  compare Thu _   = GT

  compare Fri Sat = LT
  compare Fri Sun = LT
  compare Fri Fri = EQ
  compare Fri _   = GT

  compare Sat Sun = LT
  compare Sat Sat = EQ
  compare Sat _   = GT

  compare Sun Sun = EQ
  compare Sun _   = GT
```

---

## L3. Show instance for expression tree

```haskell
data Expr =
    Val Int
  | Add Expr Expr
  | Mul Expr Expr

instance Show Expr where
  show (Val n) = show n
  show (Add e1 e2) =
    "(" ++ show e1 ++ "+" ++ show e2 ++ ")"
  show (Mul e1 e2) =
    "(" ++ show e1 ++ "*" ++ show e2 ++ ")"
```

---

## L4. Num Bool instance

```haskell
instance Num Bool where
  False + False = False
  _ + _ = True

  True * True = True
  _ * _ = False

  negate x = x

  abs x = x

  signum x = x

  fromInteger 0 = False
  fromInteger _ = True
```

---

# M. 小函数保底押题

## M1. safetail 三种写法

```haskell
safetail1 :: [a] -> [a]
safetail1 xs =
  if null xs then [] else tail xs
```

```haskell
safetail2 :: [a] -> [a]
safetail2 xs
  | null xs   = []
  | otherwise = tail xs
```

```haskell
safetail3 :: [a] -> [a]
safetail3 [] = []
safetail3 (x:xs) = xs
```

---

## M2. third 三种写法

```haskell
third1 :: [a] -> a
third1 xs = head (tail (tail xs))
```

```haskell
third2 :: [a] -> a
third2 xs = xs !! 2
```

```haskell
third3 :: [a] -> a
third3 (_:_:x:_) = x
```

---

## M3. factors

```haskell
factors :: Int -> [Int]
factors n =
  [x | x <- [1..n], n `mod` x == 0]
```

---

## M4. isPrime

```haskell
isPrime :: Int -> Bool
isPrime n =
  factors n == [1, n]
```

---

## M5. merge

```haskell
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs

merge (x:xs) (y:ys)
  | x <= y    = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys
```

---

## M6. msort

```haskell
msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]

msort xs =
  merge (msort left) (msort right)
  where
    mid = length xs `div` 2
    left = take mid xs
    right = drop mid xs
```

---

## M7. cycleOf

```haskell
type Perm = [Int]

cycleOf :: Int -> Perm -> [Int]
cycleOf k p = go k []
  where
    go current seen
      | current `elem` seen = reverse seen
      | otherwise = go (p !! current) (current : seen)
```

---

## M8. isPerm

```haskell
type Perm = [Int]

isPerm :: [Int] -> Bool
isPerm xs =
  and [k `elem` xs | k <- [0 .. length xs - 1]]
```
