# Haskell State Monad

---

## 目录

- [0. State Monad 最小必背](#0-state-monad-最小必背)
  - [0.1 State s a 是什么](#01-state-s-a-是什么)
  - [0.2 get / put / modify 类型](#02-get--put--modify-类型)
  - [0.3 runState / evalState / execState](#03-runstate--evalstate--execstate)
  - [0.4 return () 是什么](#04-return--是什么)
- [A区：Nim 最高命中率押题](#a区nim-最高命中率押题)
  - [A1. gameOver](#a1-gameover)
  - [A2. firstHeap](#a2-firstheap)
  - [A3. secondHeap](#a3-secondheap)
  - [A4. heapSize](#a4-heapsize)
  - [A5. totalTokens](#a5-totaltokens)
  - [A6. clearHeap](#a6-clearheap)
  - [A7. clearBoard](#a7-clearboard)
  - [A8. takeTokens get/put版](#a8-taketokens-getput版)
  - [A9. takeTokens modify版](#a9-taketokens-modify版)
  - [A10. addTokens](#a10-addtokens)
  - [A11. setHeap](#a11-setheap)
  - [A12. swapHeaps](#a12-swapheaps)
  - [A13. onlyOneHeapLeft](#a13-onlyoneheapleft)
  - [A14. legalMove](#a14-legalmove)
  - [A15. takeIfLegal](#a15-takeiflegal)
  - [A16. takeIfNotOver](#a16-takeifnotover)
  - [A17. moveAndCheck](#a17-moveandcheck)
  - [A18. twoMoves](#a18-twomoves)
  - [A19. beforeAfter](#a19-beforeafter)
  - [A20. moveReturnOldBoard](#a20-movereturnoldboard)
  - [A21. moveReturnNewBoard](#a21-movereturnnewboard)
  - [A22. playMoves](#a22-playmoves)
  - [A23. playMovesReturnFinal](#a23-playmovesreturnfinal)
  - [A24. countMovesUntilOver](#a24-countmovesuntilover)
  - [A25. winnerSimple](#a25-winnersimple)
- [B区：Counter / Int State 押题](#b区counter--int-state-押题)
  - [B1. counterGet](#b1-counterget)
  - [B2. counterInc get/put版](#b2-counterinc-getput版)
  - [B3. counterInc modify版](#b3-counterinc-modify版)
  - [B4. counterDec](#b4-counterdec)
  - [B5. counterAdd](#b5-counteradd)
  - [B6. counterSub](#b6-countersub)
  - [B7. counterReset](#b7-counterreset)
  - [B8. counterAddAndReturnOld](#b8-counteraddandreturnold)
  - [B9. counterAddAndReturnNew](#b9-counteraddandreturnnew)
  - [B10. counterTwice](#b10-countertwice)
  - [B11. counterMany](#b11-countermany)
  - [B12. countListLength](#b12-countlistlength)
  - [B13. countPositive](#b13-countpositive)
  - [B14. countChar](#b14-countchar)
  - [B15. countPredicate](#b15-countpredicate)
- [C区：Stack State 押题](#c区stack-state-押题)
  - [C1. stackPush](#c1-stackpush)
  - [C2. stackPop Maybe](#c2-stackpop-maybe)
  - [C3. stackTop](#c3-stacktop)
  - [C4. stackSize](#c4-stacksize)
  - [C5. stackIsEmpty](#c5-stackisempty)
  - [C6. stackClear](#c6-stackclear)
  - [C7. stackPushMany](#c7-stackpushmany)
  - [C8. stackPopTwo](#c8-stackpoptwo)
  - [C9. stackReplaceTop](#c9-stackreplacetop)
  - [C10. stackDuplicateTop](#c10-stackduplicatetop)
  - [C11. stackSwapTopTwo](#c11-stackswaptoptwo)
  - [C12. stackSumAll](#c12-stacksumall)
- [D区：List / Traversal + State 押题](#d区list--traversal--state-押题)
  - [D1. sumWithState](#d1-sumwithstate)
  - [D2. productWithState](#d2-productwithstate)
  - [D3. labelList 从0开始](#d3-labellist-从0开始)
  - [D4. labelList 从1开始](#d4-labellist-从1开始)
  - [D5. labelList mapM版](#d5-labellist-mapm版)
  - [D6. numberStringChars](#d6-numberstringchars)
  - [D7. replaceCharCount](#d7-replacecharcount)
  - [D8. removeCharCount](#d8-removecharcount)
  - [D9. partitionCount](#d9-partitioncount)
  - [D10. collectEveryNth](#d10-collecteverynth)
  - [D11. runningSums](#d11-runningsums)
  - [D12. runningProducts](#d12-runningproducts)
  - [D13. assignFreshIds](#d13-assignfreshids)
  - [D14. zipWithIndex](#d14-zipwithindex)
  - [D15. mapAccumulate](#d15-mapaccumulate)
- [E区：Tree + State 押题](#e区tree--state-押题)
  - [E1. countNodesState](#e1-countnodesstate)
  - [E2. countLeavesState](#e2-countleavesstate)
  - [E3. labelTree](#e3-labeltree)
  - [E4. labelTreeInorder](#e4-labeltreeinorder)
  - [E5. replaceTreeValuesWithState](#e5-replacetreevalueswithstate)
  - [E6. treeSumState](#e6-treesumstate)
  - [E7. treeMapCount](#e7-treemapcount)
  - [E8. findInTreeCountSteps](#e8-findintreecountsteps)
  - [E9. BST insert count comparisons](#e9-bst-insert-count-comparisons)
  - [E10. pathToValue with State](#e10-pathtovalue-with-state)
- [F区：Calculator 高命中率押题](#f区calculator-高命中率押题)
  - [F1. 基础 CalcCmd run](#f1-基础-calccmd-run)
  - [F2. modify版 Calculator](#f2-modify版-calculator)
  - [F3. 加入 DivC 防止除0 Maybe](#f3-加入-divc-防止除0-maybe)
  - [F4. MonadError + MonadState 标准版](#f4-monaderror--monadstate-标准版)
  - [F5. 返回最终值](#f5-返回最终值)
  - [F6. 返回旧值与新值](#f6-返回旧值与新值)
  - [F7. 执行命令列表](#f7-执行命令列表)
  - [F8. Calculator runExamples](#f8-calculator-runexamples)
- [G区：Maybe / Either + State 押题](#g区maybe--either--state-押题)
  - [G1. safePop Maybe](#g1-safepop-maybe)
  - [G2. safeDivState Maybe](#g2-safedivstate-maybe)
  - [G3. safeDivState Either](#g3-safedivstate-either)
  - [G4. takeTokens Either](#g4-taketokens-either)
  - [G5. validateAndModify](#g5-validateandmodify)
  - [G6. State 中返回 Maybe 的通用模板](#g6-state-中返回-maybe-的通用模板)
  - [G7. State 中返回 Either 的通用模板](#g7-state-中返回-either-的通用模板)
- [H区：State 与 Writer / Reader 区分题](#h区state-与-writer--reader-区分题)
  - [H1. State：修改状态](#h1-state修改状态)
  - [H2. Writer：记录日志](#h2-writer记录日志)
  - [H3. Reader：读取环境](#h3-reader读取环境)
  - [H4. 三者对比表](#h4-三者对比表)
  - [H5. 同一个任务三种写法](#h5-同一个任务三种写法)
- [I区：runState 输出预测题](#i区runstate-输出预测题)
  - [I1. get 不改变状态](#i1-get-不改变状态)
  - [I2. put 替换状态](#i2-put-替换状态)
  - [I3. modify 修改状态](#i3-modify-修改状态)
  - [I4. return 只返回值](#i4-return-只返回值)
  - [I5. 连续 put](#i5-连续-put)
  - [I6. get 后 put](#i6-get-后-put)
  - [I7. old/new 输出](#i7-oldnew-输出)
  - [I8. Nim 输出预测](#i8-nim-输出预测)
  - [I9. Stack 输出预测](#i9-stack-输出预测)
  - [I10. evalState / execState](#i10-evalstate--execstate)
- [J区：do / >>= / fmap / applicative 风格](#j区do----fmap--applicative-风格)
  - [J1. do版](#j1-do版)
  - [J2. bind版](#j2-bind版)
  - [J3. fmap版](#j3-fmap版)
  - [J4. applicative版](#j4-applicative版)
- [K区：考试最后速背模板](#k区考试最后速背模板)
  - [K1. 只读状态模板](#k1-只读状态模板)
  - [K2. 修改状态模板](#k2-修改状态模板)
  - [K3. 修改后返回旧状态模板](#k3-修改后返回旧状态模板)
  - [K4. 修改后返回新状态模板](#k4-修改后返回新状态模板)
  - [K5. 递归 State 模板](#k5-递归-state-模板)
  - [K6. mapM + State 模板](#k6-mapm--state-模板)
  - [K7. Maybe + State 模板](#k7-maybe--state-模板)
  - [K8. Either + State 模板](#k8-either--state-模板)

---

# 0. State Monad 最小必背

`mapM_` 可以理解成：

对列表里的每个元素，依次执行一个 Monad 操作，但不要收集结果

---
## 0.1 State s a 是什么

```haskell
State s a
```

```haskell
s = state 的类型
a = 最后 return 出来的 value 的类型
```

例子：

```haskell
State Int Bool
-- state 是 Int
-- 最后返回 Bool

State (Int, Int) ()
-- state 是 (Int, Int)
-- 最后返回 ()
```

---

## 0.2 get / put / modify 类型

```haskell
get :: State s s
```

```haskell
put :: s -> State s ()
```

```haskell
modify :: (s -> s) -> State s ()
```

更通用的课件版本：

```haskell
get :: MonadState s m => m s
put :: MonadState s m => s -> m ()
modify :: MonadState s m => (s -> s) -> m ()
```

---

## 0.3 runState / evalState / execState

```haskell
runState action initialState
-- (returnValue, finalState)
```

```haskell
evalState action initialState
-- returnValue
```

```haskell
execState action initialState
-- finalState
```

---

## 0.4 return () 是什么

```haskell
return ()
```

意思是：

```haskell
不返回有用值，只是结束这个 State action
```

类似 Java：

```java
void
```

---

# A区：Nim 最高命中率押题

---

## A1. gameOver

```haskell
import Control.Monad.State

type NimBoard = (Int, Int)
type NimGame a = State NimBoard a

data Heap = First | Second
  deriving (Show, Eq)

gameOver :: NimGame Bool
gameOver = do
  (h1, h2) <- get
  return (h1 == 0 && h2 == 0)
```

---

## A2. firstHeap

```haskell
firstHeap :: NimGame Int
firstHeap = do
  (h1, _) <- get
  return h1
```

---

## A3. secondHeap

```haskell
secondHeap :: NimGame Int
secondHeap = do
  (_, h2) <- get
  return h2
```

---

## A4. heapSize

```haskell
heapSize :: Heap -> NimGame Int
heapSize First = do
  (h1, _) <- get
  return h1

heapSize Second = do
  (_, h2) <- get
  return h2
```

---

## A5. totalTokens

```haskell
totalTokens :: NimGame Int
totalTokens = do
  (h1, h2) <- get
  return (h1 + h2)
```

---

## A6. clearHeap

```haskell
clearHeap :: Heap -> NimGame ()
clearHeap First = do
  (_, h2) <- get
  put (0, h2)

clearHeap Second = do
  (h1, _) <- get
  put (h1, 0)
```

---

## A7. clearBoard

```haskell
clearBoard :: NimGame ()
clearBoard = do
  put (0, 0)
```

---

## A8. takeTokens get/put版

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

## A9. takeTokens modify版

```haskell
takeTokensModify :: Int -> Heap -> NimGame ()
takeTokensModify i First =
  modify (\(h1, h2) -> (max 0 (h1 - i), h2))

takeTokensModify i Second =
  modify (\(h1, h2) -> (h1, max 0 (h2 - i)))
```

---

## A10. addTokens

```haskell
addTokens :: Int -> Heap -> NimGame ()
addTokens i First = do
  (h1, h2) <- get
  put (h1 + i, h2)

addTokens i Second = do
  (h1, h2) <- get
  put (h1, h2 + i)
```

---

## A11. setHeap

```haskell
setHeap :: Int -> Heap -> NimGame ()
setHeap n First = do
  (_, h2) <- get
  put (n, h2)

setHeap n Second = do
  (h1, _) <- get
  put (h1, n)
```

---

## A12. swapHeaps

```haskell
swapHeaps :: NimGame ()
swapHeaps = do
  (h1, h2) <- get
  put (h2, h1)
```

---

## A13. onlyOneHeapLeft

```haskell
onlyOneHeapLeft :: NimGame Bool
onlyOneHeapLeft = do
  (h1, h2) <- get
  return ((h1 > 0 && h2 == 0) || (h1 == 0 && h2 > 0))
```

---

## A14. legalMove

```haskell
legalMove :: Int -> Heap -> NimGame Bool
legalMove i First = do
  (h1, _) <- get
  return (i > 0 && i <= h1)

legalMove i Second = do
  (_, h2) <- get
  return (i > 0 && i <= h2)
```

---

## A15. takeIfLegal

```haskell
takeIfLegal :: Int -> Heap -> NimGame Bool
takeIfLegal i h = do
  ok <- legalMove i h
  if ok
    then do
      takeTokens i h
      return True
    else return False
```

---

## A16. takeIfNotOver

```haskell
takeIfNotOver :: Int -> Heap -> NimGame ()
takeIfNotOver i h = do
  over <- gameOver
  if over
    then return ()
    else takeTokens i h
```

---

## A17. moveAndCheck

```haskell
moveAndCheck :: Int -> Heap -> NimGame Bool
moveAndCheck i h = do
  takeTokens i h
  gameOver
```

---

## A18. twoMoves

```haskell
twoMoves :: NimGame Bool
twoMoves = do
  takeTokens 1 First
  takeTokens 2 Second
  gameOver
```

---

## A19. beforeAfter

```haskell
beforeAfter :: Int -> Heap -> NimGame (Int, Int)
beforeAfter i h = do
  before <- totalTokens
  takeTokens i h
  after <- totalTokens
  return (before, after)
```

---

## A20. moveReturnOldBoard

```haskell
moveReturnOldBoard :: Int -> Heap -> NimGame NimBoard
moveReturnOldBoard i h = do
  oldBoard <- get
  takeTokens i h
  return oldBoard
```

---

## A21. moveReturnNewBoard

```haskell
moveReturnNewBoard :: Int -> Heap -> NimGame NimBoard
moveReturnNewBoard i h = do
  takeTokens i h
  get
```

---

## A22. playMoves

```haskell
type Move = (Int, Heap)

playMoves :: [Move] -> NimGame ()
playMoves [] = return ()

playMoves ((i, h):ms) = do
  takeTokens i h
  playMoves ms
```

---

## A23. playMovesReturnFinal

```haskell
type Move = (Int, Heap)

playMovesReturnFinal :: [Move] -> NimGame NimBoard
playMovesReturnFinal [] = get

playMovesReturnFinal ((i, h):ms) = do
  takeTokens i h
  playMovesReturnFinal ms
```

---

## A24. countMovesUntilOver

```haskell
type Move = (Int, Heap)

countMovesUntilOver :: [Move] -> NimGame Int
countMovesUntilOver [] = return 0

countMovesUntilOver ((i, h):ms) = do
  over <- gameOver
  if over
    then return 0
    else do
      takeTokens i h
      rest <- countMovesUntilOver ms
      return (1 + rest)
```

---

## A25. winnerSimple

```haskell
type Move = (Int, Heap)

winnerSimple :: [Move] -> NimGame Bool
winnerSimple [] = gameOver

winnerSimple ((i, h):ms) = do
  takeTokens i h
  winnerSimple ms
```

---

# B区：Counter / Int State 押题

---

## B1. counterGet

```haskell
import Control.Monad.State

type Counter a = State Int a

counterGet :: Counter Int
counterGet = do
  n <- get
  return n
```

---

## B2. counterInc get/put版

```haskell
counterInc :: Counter ()
counterInc = do
  n <- get
  put (n + 1)
```

---

## B3. counterInc modify版

```haskell
counterIncModify :: Counter ()
counterIncModify = do
  modify (+1)
```

---

## B4. counterDec

```haskell
counterDec :: Counter ()
counterDec = do
  modify (\x -> x - 1)
```

也可以：

```haskell
counterDec :: Counter ()
counterDec = do
  modify (subtract 1)
```

---

## B5. counterAdd

```haskell
counterAdd :: Int -> Counter ()
counterAdd x = do
  modify (+ x)
```

---

## B6. counterSub

```haskell
counterSub :: Int -> Counter ()
counterSub x = do
  modify (subtract x)
```

---

## B7. counterReset

```haskell
counterReset :: Counter ()
counterReset = do
  put 0
```

---

## B8. counterAddAndReturnOld

```haskell
counterAddAndReturnOld :: Int -> Counter Int
counterAddAndReturnOld x = do
  old <- get
  put (old + x)
  return old
```

---

## B9. counterAddAndReturnNew

```haskell
counterAddAndReturnNew :: Int -> Counter Int
counterAddAndReturnNew x = do
  old <- get
  let new = old + x
  put new
  return new
```

---

## B10. counterTwice

```haskell
counterTwice :: Counter ()
counterTwice = do
  counterInc
  counterInc
```

---

## B11. counterMany

```haskell
counterMany :: Int -> Counter ()
counterMany n
  | n <= 0 = return ()
  | otherwise = do
      counterInc
      counterMany (n - 1)
```

---

## B12. countListLength

```haskell
countListLength :: [a] -> Counter Int
countListLength [] = get

countListLength (_:xs) = do
  modify (+1)
  countListLength xs
```

---

## B13. countPositive

```haskell
countPositive :: [Int] -> Counter Int
countPositive [] = get

countPositive (x:xs)
  | x > 0 = do
      modify (+1)
      countPositive xs

  | otherwise = do
      countPositive xs
```

---

## B14. countChar

```haskell
countChar :: Char -> String -> Counter Int
countChar target [] = get

countChar target (c:cs)
  | c == target = do
      modify (+1)
      countChar target cs

  | otherwise = countChar target cs
```

---

## B15. countPredicate

```haskell
countPredicate :: (a -> Bool) -> [a] -> Counter Int
countPredicate p [] = get

countPredicate p (x:xs)
  | p x = do
      modify (+1)
      countPredicate p xs

  | otherwise = countPredicate p xs
```

---

# C区：Stack State 押题

---

## C1. stackPush

```haskell
import Control.Monad.State

type Stack a = State [Int] a

stackPush :: Int -> Stack ()
stackPush x = do
  xs <- get
  put (x : xs)
```

modify 版：

```haskell
stackPush :: Int -> Stack ()
stackPush x = do
  modify (x :)
```

---

## C2. stackPop Maybe

```haskell
stackPop :: Stack (Maybe Int)
stackPop = do
  xs <- get
  case xs of
    [] -> return Nothing
    y:ys -> do
      put ys
      return (Just y)
```

---

## C3. stackTop

```haskell
stackTop :: Stack (Maybe Int)
stackTop = do
  xs <- get
  case xs of
    [] -> return Nothing
    y:_ -> return (Just y)
```

---

## C4. stackSize

```haskell
stackSize :: Stack Int
stackSize = do
  xs <- get
  return (length xs)
```

---

## C5. stackIsEmpty

```haskell
stackIsEmpty :: Stack Bool
stackIsEmpty = do
  xs <- get
  return (null xs)
```

---

## C6. stackClear

```haskell
stackClear :: Stack ()
stackClear = do
  put []
```

---

## C7. stackPushMany

```haskell
stackPushMany :: [Int] -> Stack ()
stackPushMany [] = return ()

stackPushMany (x:xs) = do
  stackPush x
  stackPushMany xs
```

mapM_ 版：

```haskell
stackPushMany :: [Int] -> Stack ()
stackPushMany xs = do
  mapM_ stackPush xs
```

---

## C8. stackPopTwo

```haskell
stackPopTwo :: Stack (Maybe (Int, Int))
stackPopTwo = do
  a <- stackPop
  b <- stackPop
  case (a, b) of
    (Just x, Just y) -> return (Just (x, y))
    _ -> return Nothing
```

---

## C9. stackReplaceTop

```haskell
stackReplaceTop :: Int -> Stack Bool
stackReplaceTop x = do
  xs <- get
  case xs of
    [] -> return False
    _:ys -> do
      put (x:ys)
      return True
```

---

## C10. stackDuplicateTop

```haskell
stackDuplicateTop :: Stack Bool
stackDuplicateTop = do
  xs <- get
  case xs of
    [] -> return False
    y:ys -> do
      put (y:y:ys)
      return True
```

---

## C11. stackSwapTopTwo

```haskell
stackSwapTopTwo :: Stack Bool
stackSwapTopTwo = do
  xs <- get
  case xs of
    x:y:ys -> do
      put (y:x:ys)
      return True
    _ -> return False
```

---

## C12. stackSumAll

```haskell
stackSumAll :: Stack Int
stackSumAll = do
  xs <- get
  return (sum xs)
```

---

# D区：List / Traversal + State 押题

---

## D1. sumWithState

```haskell
import Control.Monad.State

type SumState a = State Int a

addOneNumber :: Int -> SumState ()
addOneNumber x = do
  total <- get
  put (total + x)

sumWithState :: [Int] -> SumState Int
sumWithState [] = get

sumWithState (x:xs) = do
  addOneNumber x
  sumWithState xs
```

---

## D2. productWithState

```haskell
type ProductState a = State Int a

multiplyOneNumber :: Int -> ProductState ()
multiplyOneNumber x = do
  total <- get
  put (total * x)

productWithState :: [Int] -> ProductState Int
productWithState [] = get

productWithState (x:xs) = do
  multiplyOneNumber x
  productWithState xs
```

---

## D3. labelList 从0开始

```haskell
type LabelState a = State Int a

freshLabel :: LabelState Int
freshLabel = do
  n <- get
  put (n + 1)
  return n

labelList :: [a] -> LabelState [(Int, a)]
labelList [] = return []

labelList (x:xs) = do
  label <- freshLabel
  rest <- labelList xs
  return ((label, x) : rest)
```

---

## D4. labelList 从1开始

```haskell
type LabelState a = State Int a

freshLabel1 :: LabelState Int
freshLabel1 = do
  n <- get
  put (n + 1)
  return (n + 1)

labelList1 :: [a] -> LabelState [(Int, a)]
labelList1 [] = return []

labelList1 (x:xs) = do
  label <- freshLabel1
  rest <- labelList1 xs
  return ((label, x) : rest)
```

---

## D5. labelList mapM版

```haskell
type LabelState a = State Int a

labelOne :: a -> LabelState (Int, a)
labelOne x = do
  n <- get
  put (n + 1)
  return (n, x)

labelListMapM :: [a] -> LabelState [(Int, a)]
labelListMapM xs = do
  mapM labelOne xs
```

---

## D6. numberStringChars

```haskell
type LabelState a = State Int a

numberChar :: Char -> LabelState (Int, Char)
numberChar c = do
  n <- get
  put (n + 1)
  return (n, c)

numberStringChars :: String -> LabelState [(Int, Char)]
numberStringChars s = do
  mapM numberChar s
```

---

## D7. replaceCharCount

```haskell
type CountState a = State Int a

replaceCharCount :: Char -> Char -> String -> CountState String
replaceCharCount old new [] = return []

replaceCharCount old new (c:cs)
  | c == old = do
      modify (+1)
      rest <- replaceCharCount old new cs
      return (new : rest)

  | otherwise = do
      rest <- replaceCharCount old new cs
      return (c : rest)
```

---

## D8. removeCharCount

```haskell
type CountState a = State Int a

removeCharCount :: Char -> String -> CountState String
removeCharCount target [] = return []

removeCharCount target (c:cs)
  | c == target = do
      modify (+1)
      removeCharCount target cs

  | otherwise = do
      rest <- removeCharCount target cs
      return (c : rest)
```

---

## D9. partitionCount

```haskell
type CountState a = State Int a

partitionCount :: (a -> Bool) -> [a] -> CountState ([a], [a])
partitionCount p [] = return ([], [])

partitionCount p (x:xs)
  | p x = do
      modify (+1)
      (ys, zs) <- partitionCount p xs
      return (x:ys, zs)

  | otherwise = do
      (ys, zs) <- partitionCount p xs
      return (ys, x:zs)
```

---

## D10. collectEveryNth

```haskell
type IndexState a = State Int a

collectEveryNth :: Int -> [a] -> IndexState [a]
collectEveryNth n [] = return []

collectEveryNth n (x:xs) = do
  i <- get
  put (i + 1)
  rest <- collectEveryNth n xs
  if i `mod` n == 0
    then return (x : rest)
    else return rest
```

---

## D11. runningSums

```haskell
type SumState a = State Int a

runningSums :: [Int] -> SumState [Int]
runningSums [] = return []

runningSums (x:xs) = do
  total <- get
  let newTotal = total + x
  put newTotal
  rest <- runningSums xs
  return (newTotal : rest)
```

---

## D12. runningProducts

```haskell
type ProductState a = State Int a

runningProducts :: [Int] -> ProductState [Int]
runningProducts [] = return []

runningProducts (x:xs) = do
  total <- get
  let newTotal = total * x
  put newTotal
  rest <- runningProducts xs
  return (newTotal : rest)
```

---

## D13. assignFreshIds

```haskell
type IdState a = State Int a

freshId :: IdState Int
freshId = do
  n <- get
  put (n + 1)
  return n

assignFreshIds :: [String] -> IdState [(String, Int)]
assignFreshIds [] = return []

assignFreshIds (x:xs) = do
  i <- freshId
  rest <- assignFreshIds xs
  return ((x, i) : rest)
```

---

## D14. zipWithIndex

```haskell
type IndexState a = State Int a

zipWithIndex :: [a] -> IndexState [(a, Int)]
zipWithIndex [] = return []

zipWithIndex (x:xs) = do
  i <- get
  put (i + 1)
  rest <- zipWithIndex xs
  return ((x, i) : rest)
```

---

## D15. mapAccumulate

```haskell
type AccState s a = State s a

mapAccumulate :: (s -> a -> (s, b)) -> [a] -> AccState s [b]
mapAccumulate f [] = return []

mapAccumulate f (x:xs) = do
  s <- get
  let (newState, y) = f s x
  put newState
  ys <- mapAccumulate f xs
  return (y:ys)
```

---

# E区：Tree + State 押题

---

## E1. countNodesState

```haskell
import Control.Monad.State

data Tree a = Empty
            | Node (Tree a) a (Tree a)
            deriving Show

type CountState a = State Int a

countNodesState :: Tree a -> CountState ()
countNodesState Empty = return ()

countNodesState (Node l _ r) = do
  modify (+1)
  countNodesState l
  countNodesState r
```

---

## E2. countLeavesState

```haskell
countLeavesState :: Tree a -> CountState ()
countLeavesState Empty = return ()

countLeavesState (Node Empty _ Empty) = do
  modify (+1)

countLeavesState (Node l _ r) = do
  countLeavesState l
  countLeavesState r
```

---

## E3. labelTree

```haskell
type LabelState a = State Int a

freshLabel :: LabelState Int
freshLabel = do
  n <- get
  put (n + 1)
  return n

labelTree :: Tree a -> LabelState (Tree (Int, a))
labelTree Empty = return Empty

labelTree (Node l x r) = do
  label <- freshLabel
  newLeft <- labelTree l
  newRight <- labelTree r
  return (Node newLeft (label, x) newRight)
```

---

## E4. labelTreeInorder

```haskell
type LabelState a = State Int a

freshLabel :: LabelState Int
freshLabel = do
  n <- get
  put (n + 1)
  return n

labelTreeInorder :: Tree a -> LabelState (Tree (Int, a))
labelTreeInorder Empty = return Empty

labelTreeInorder (Node l x r) = do
  newLeft <- labelTreeInorder l
  label <- freshLabel
  newRight <- labelTreeInorder r
  return (Node newLeft (label, x) newRight)
```

---

## E5. replaceTreeValuesWithState

```haskell
type ReplaceState a b = State [b] a

replaceTreeValues :: Tree a -> ReplaceState (Tree b) b
replaceTreeValues Empty = return Empty

replaceTreeValues (Node l _ r) = do
  newLeft <- replaceTreeValues l
  xs <- get
  case xs of
    [] -> return Empty
    y:ys -> do
      put ys
      newRight <- replaceTreeValues r
      return (Node newLeft y newRight)
```

---

## E6. treeSumState

```haskell
type SumState a = State Int a

treeSumState :: Tree Int -> SumState Int
treeSumState Empty = get

treeSumState (Node l x r) = do
  modify (+ x)
  treeSumState l
  treeSumState r
```

---

## E7. treeMapCount

```haskell
type CountState a = State Int a

treeMapCount :: (a -> b) -> Tree a -> CountState (Tree b)
treeMapCount f Empty = return Empty

treeMapCount f (Node l x r) = do
  modify (+1)
  newLeft <- treeMapCount f l
  newRight <- treeMapCount f r
  return (Node newLeft (f x) newRight)
```

---

## E8. findInTreeCountSteps

```haskell
type StepState a = State Int a

findInTreeCountSteps :: Eq a => a -> Tree a -> StepState Bool
findInTreeCountSteps target Empty = return False

findInTreeCountSteps target (Node l x r) = do
  modify (+1)
  if target == x
    then return True
    else do
      left <- findInTreeCountSteps target l
      if left
        then return True
        else findInTreeCountSteps target r
```

---

## E9. BST insert count comparisons

```haskell
type CompareState a = State Int a

bstInsertCount :: Ord a => a -> Tree a -> CompareState (Tree a)
bstInsertCount x Empty = do
  return (Node Empty x Empty)

bstInsertCount x (Node l y r)
  | x <= y = do
      modify (+1)
      newLeft <- bstInsertCount x l
      return (Node newLeft y r)

  | otherwise = do
      modify (+1)
      newRight <- bstInsertCount x r
      return (Node l y newRight)
```

---

## E10. pathToValue with State

```haskell
data Direction = GoLeft | GoRight
  deriving Show

type PathState a = State [Direction] a

pathToValue :: Eq a => a -> Tree a -> PathState Bool
pathToValue target Empty = return False

pathToValue target (Node l x r)
  | target == x = return True
  | otherwise = do
      modify (++ [GoLeft])
      foundLeft <- pathToValue target l
      if foundLeft
        then return True
        else do
          modify (++ [GoRight])
          pathToValue target r
```

---

# F区：Calculator 高命中率押题

---

## F1. 基础 CalcCmd run

```haskell
import Control.Monad.State

data CalcCmd = EnterC
             | StoreC Int CalcCmd
             | AddC Int CalcCmd
             | MultC Int CalcCmd
             | DivC Int CalcCmd
             | SubC Int CalcCmd
             deriving Show

run :: CalcCmd -> State Int ()
run EnterC = return ()

run (StoreC n c) = do
  put n
  run c

run (AddC n c) = do
  x <- get
  put (x + n)
  run c

run (MultC n c) = do
  x <- get
  put (x * n)
  run c

run (SubC n c) = do
  x <- get
  put (x - n)
  run c

run (DivC n c) = do
  x <- get
  put (x `div` n)
  run c
```

---

## F2. modify版 Calculator

```haskell
runModify :: CalcCmd -> State Int ()
runModify EnterC = return ()

runModify (StoreC n c) = do
  put n
  runModify c

runModify (AddC n c) = do
  modify (+ n)
  runModify c

runModify (MultC n c) = do
  modify (* n)
  runModify c

runModify (SubC n c) = do
  modify (subtract n)
  runModify c

runModify (DivC n c) = do
  modify (`div` n)
  runModify c
```

---

## F3. 加入 DivC 防止除0 Maybe

```haskell
runMaybe :: CalcCmd -> State Int (Maybe ())
runMaybe EnterC = return (Just ())

runMaybe (StoreC n c) = do
  put n
  runMaybe c

runMaybe (AddC n c) = do
  modify (+ n)
  runMaybe c

runMaybe (MultC n c) = do
  modify (* n)
  runMaybe c

runMaybe (SubC n c) = do
  modify (subtract n)
  runMaybe c

runMaybe (DivC 0 c) = do
  return Nothing

runMaybe (DivC n c) = do
  modify (`div` n)
  runMaybe c
```

---

## F4. MonadError + MonadState 标准版

```haskell
import Control.Monad.State
import Control.Monad.Except

runGeneric :: (MonadState Int m, MonadError String m) => CalcCmd -> m ()
runGeneric EnterC = return ()

runGeneric (StoreC n c) = do
  put n
  runGeneric c

runGeneric (AddC n c) = do
  modify (+ n)
  runGeneric c

runGeneric (MultC n c) = do
  modify (* n)
  runGeneric c

runGeneric (SubC n c) = do
  modify (subtract n)
  runGeneric c

runGeneric (DivC 0 c) = do
  throwError "Division by zero"

runGeneric (DivC n c) = do
  modify (`div` n)
  runGeneric c
```

---

## F5. 返回最终值

```haskell
runReturnFinal :: CalcCmd -> State Int Int
runReturnFinal EnterC = get

runReturnFinal (StoreC n c) = do
  put n
  runReturnFinal c

runReturnFinal (AddC n c) = do
  modify (+ n)
  runReturnFinal c

runReturnFinal (MultC n c) = do
  modify (* n)
  runReturnFinal c

runReturnFinal (SubC n c) = do
  modify (subtract n)
  runReturnFinal c

runReturnFinal (DivC n c) = do
  modify (`div` n)
  runReturnFinal c
```

---

## F6. 返回旧值与新值

```haskell
applyAddReturnOldNew :: Int -> State Int (Int, Int)
applyAddReturnOldNew n = do
  old <- get
  let new = old + n
  put new
  return (old, new)
```

---

## F7. 执行命令列表

```haskell
data SimpleCmd = Add Int | Sub Int | Mul Int | Store Int
  deriving Show

runOne :: SimpleCmd -> State Int ()
runOne (Add n) = modify (+ n)
runOne (Sub n) = modify (subtract n)
runOne (Mul n) = modify (* n)
runOne (Store n) = put n

runList :: [SimpleCmd] -> State Int ()
runList [] = return ()

runList (c:cs) = do
  runOne c
  runList cs
```

mapM_ 版：

```haskell
runList :: [SimpleCmd] -> State Int ()
runList cs = do
  mapM_ runOne cs
```

---

## F8. Calculator runExamples

```haskell
-- runState (run (AddC 3 (MultC 2 EnterC))) 10
-- ((), 26)

-- runState (runModify (SubC 3 (AddC 10 EnterC))) 20
-- ((), 27)

-- runState (runReturnFinal (AddC 5 (MultC 2 EnterC))) 10
-- (30, 30)

-- runState (runList [Add 3, Mul 2, Sub 1]) 10
-- ((), 25)
```

---

# G区：Maybe / Either + State 押题

---

## G1. safePop Maybe

```haskell
type Stack a = State [Int] a

safePop :: Stack (Maybe Int)
safePop = do
  xs <- get
  case xs of
    [] -> return Nothing
    y:ys -> do
      put ys
      return (Just y)
```

---

## G2. safeDivState Maybe

```haskell
safeDivState :: Int -> State Int (Maybe ())
safeDivState 0 = do
  return Nothing

safeDivState n = do
  modify (`div` n)
  return (Just ())
```

---

## G3. safeDivState Either

```haskell
safeDivStateE :: Int -> State Int (Either String ())
safeDivStateE 0 = do
  return (Left "Division by zero")

safeDivStateE n = do
  modify (`div` n)
  return (Right ())
```

---

## G4. takeTokens Either

```haskell
takeTokensEither :: Int -> Heap -> NimGame (Either String ())
takeTokensEither i h = do
  ok <- legalMove i h
  if ok
    then do
      takeTokens i h
      return (Right ())
    else return (Left "Illegal move")
```

---

## G5. validateAndModify

```haskell
validateAndModify :: (Int -> Bool) -> (Int -> Int) -> State Int Bool
validateAndModify p f = do
  x <- get
  if p x
    then do
      put (f x)
      return True
    else return False
```

---

## G6. State 中返回 Maybe 的通用模板

```haskell
stateMaybeTemplate :: State Int (Maybe Int)
stateMaybeTemplate = do
  x <- get
  if x < 0
    then return Nothing
    else do
      put (x + 1)
      return (Just x)
```

---

## G7. State 中返回 Either 的通用模板

```haskell
stateEitherTemplate :: State Int (Either String Int)
stateEitherTemplate = do
  x <- get
  if x < 0
    then return (Left "Negative state")
    else do
      put (x + 1)
      return (Right x)
```

---

# H区：State 与 Writer / Reader 区分题

---

## H1. State：修改状态

```haskell
import Control.Monad.State

stateExample :: State Int Int
stateExample = do
  x <- get
  put (x + 1)
  return x
```

---

## H2. Writer：记录日志

```haskell
import Control.Monad.Writer

writerExample :: Writer [String] Int
writerExample = do
  tell ["Start"]
  tell ["Return 10"]
  return 10
```

---

## H3. Reader：读取环境

```haskell
import Control.Monad.Reader

readerExample :: Reader String String
readerExample = do
  name <- ask
  return ("Hello " ++ name)
```

---

## H4. 三者对比表

```haskell
State s a
-- 可以 get / put / modify
-- 适合：计数器、栈、游戏状态、计算器

Writer w a
-- 可以 tell
-- 适合：日志、统计、记录过程

Reader r a
-- 可以 ask
-- 适合：读取配置、环境变量
```

---

## H5. 同一个任务三种写法

State 版本：

```haskell
stateCount :: State Int ()
stateCount = do
  modify (+1)
```

Writer 版本：

```haskell
import Data.Monoid

writerCount :: Writer (Sum Int) ()
writerCount = do
  tell (Sum 1)
```

Reader 版本：

```haskell
readerUseConfig :: Reader Int Int
readerUseConfig = do
  n <- ask
  return (n + 1)
```

---

# I区：runState 输出预测题

---

## I1. get 不改变状态

```haskell
ex1 :: State Int Int
ex1 = do
  x <- get
  return x
```

```haskell
runState ex1 10
-- (10, 10)
```

---

## I2. put 替换状态

```haskell
ex2 :: State Int ()
ex2 = do
  put 100
```

```haskell
runState ex2 10
-- ((), 100)
```

---

## I3. modify 修改状态

```haskell
ex3 :: State Int ()
ex3 = do
  modify (+5)
```

```haskell
runState ex3 10
-- ((), 15)
```

---

## I4. return 只返回值

```haskell
ex4 :: State Int String
ex4 = do
  return "hello"
```

```haskell
runState ex4 10
-- ("hello", 10)
```

---

## I5. 连续 put

```haskell
ex5 :: State Int ()
ex5 = do
  put 1
  put 2
  put 3
```

```haskell
runState ex5 10
-- ((), 3)
```

---

## I6. get 后 put

```haskell
ex6 :: State Int Int
ex6 = do
  x <- get
  put (x + 1)
  return x
```

```haskell
runState ex6 10
-- (10, 11)
```

---

## I7. old/new 输出

```haskell
ex7 :: State Int (Int, Int)
ex7 = do
  old <- get
  put (old * 2)
  new <- get
  return (old, new)
```

```haskell
runState ex7 10
-- ((10, 20), 20)
```

---

## I8. Nim 输出预测

```haskell
runState gameOver (0, 0)
-- (True, (0, 0))

runState gameOver (3, 0)
-- (False, (3, 0))

runState (takeTokens 2 First) (5, 4)
-- ((), (3, 4))

runState (takeTokens 10 Second) (5, 4)
-- ((), (5, 0))

runState (beforeAfter 2 First) (5, 4)
-- ((9, 7), (3, 4))
```

---

## I9. Stack 输出预测

```haskell
runState (stackPush 3) []
-- ((), [3])

runState stackPop [1,2,3]
-- (Just 1, [2,3])

runState stackTop [1,2,3]
-- (Just 1, [1,2,3])

runState stackSize [1,2,3]
-- (3, [1,2,3])

runState stackPop []
-- (Nothing, [])
```

---

## I10. evalState / execState

```haskell
evalState ex7 10
-- (10, 20)

execState ex7 10
-- 20
```

---

# J区：do / >>= / fmap / applicative 风格

---

## J1. do版

```haskell
addStateDo :: State Int Int
addStateDo = do
  x <- get
  put (x + 1)
  return x
```

---

## J2. bind版

```haskell
addStateBind :: State Int Int
addStateBind =
  get >>= \x ->
  put (x + 1) >>
  return x
```

---

## J3. fmap版

```haskell
readPlusOne :: State Int Int
readPlusOne = fmap (+1) get
```

---

## J4. applicative版

```haskell
pairState :: State Int (Int, Int)
pairState = (,) <$> get <*> get
```

---

# K区：考试最后速背模板

---

## K1. 只读状态模板

```haskell
f :: State s a
f = do
  state <- get
  return result
```

---

## K2. 修改状态模板

```haskell
f :: State s ()
f = do
  old <- get
  put new
```

---

## K3. 修改后返回旧状态模板

```haskell
f :: State s s
f = do
  old <- get
  put new
  return old
```

---

## K4. 修改后返回新状态模板

```haskell
f :: State s s
f = do
  old <- get
  let new = ...
  put new
  return new
```

或者：

```haskell
f :: State s s
f = do
  modify update
  get
```

---

## K5. 递归 State 模板

```haskell
f :: [a] -> State s b
f [] = do
  state <- get
  return result

f (x:xs) = do
  old <- get
  put new
  f xs
```

---

## K6. mapM + State 模板

```haskell
one :: a -> State s b
one x = do
  state <- get
  put newState
  return result

many :: [a] -> State s [b]
many xs = do
  mapM one xs
```

---

## K7. Maybe + State 模板

```haskell
f :: State s (Maybe a)
f = do
  state <- get
  if bad
    then return Nothing
    else do
      put newState
      return (Just result)
```

---

## K8. Either + State 模板

```haskell
f :: State s (Either String a)
f = do
  state <- get
  if bad
    then return (Left "error message")
    else do
      put newState
      return (Right result)
```

---

# 最可能直接命中的 20 个骨架

## 1. Nim gameOver

```haskell
gameOver = do
  (h1, h2) <- get
  return (h1 == 0 && h2 == 0)
```

## 2. Nim takeTokens

```haskell
takeTokens i First = do
  (h1, h2) <- get
  put (max 0 (h1 - i), h2)
```

## 3. Nim modify

```haskell
modify (\(h1, h2) -> (max 0 (h1 - i), h2))
```

## 4. Counter increment

```haskell
modify (+1)
```

## 5. Counter subtract

```haskell
modify (subtract n)
```

## 6. Stack push

```haskell
modify (x :)
```

## 7. Stack pop

```haskell
xs <- get
case xs of
  [] -> return Nothing
  y:ys -> do
    put ys
    return (Just y)
```

## 8. Label list

```haskell
n <- get
put (n + 1)
return (n, x)
```

## 9. Replace char count

```haskell
if c == old
  then modify (+1)
  else return ()
```

## 10. Running sums

```haskell
total <- get
let newTotal = total + x
put newTotal
```

## 11. Tree count nodes

```haskell
modify (+1)
recursive left
recursive right
```

## 12. Tree label

```haskell
label <- freshLabel
newLeft <- labelTree l
newRight <- labelTree r
return (Node newLeft (label, x) newRight)
```

## 13. Calculator Store

```haskell
put n
run c
```

## 14. Calculator Add

```haskell
modify (+ n)
run c
```

## 15. Calculator Sub

```haskell
modify (subtract n)
run c
```

## 16. Calculator Div

```haskell
modify (`div` n)
run c
```

## 17. Division by zero

```haskell
throwError "Division by zero"
```

## 18. runState 结果

```haskell
runState action initial
-- (returnValue, finalState)
```

## 19. evalState

```haskell
evalState action initial
-- returnValue
```

## 20. execState

```haskell
execState action initial
-- finalState
```

