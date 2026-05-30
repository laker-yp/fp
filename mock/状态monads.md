```hs
State s r
```
`a` 是 state 的类型

`r`是最终 return 出来的 value 的类型

* get 作用：读取当前 state
* put 直接替换整个state，比如put(0,0)
* modify f 把function f套到state上面
 * modify = get 后立刻 put 一个修改后的版本。
# Haskell State Monad 练习答案整理

## 目录

- [Part 1：Nim 最相关预测题](#part-1nim-最相关预测题)
  - [1. gameOver](#1-gameover)
  - [2. firstHeap](#2-firstheap)
  - [3. heapSize](#3-heapsize)
  - [4. clearHeap](#4-clearheap)
  - [5. clearBoard](#5-clearboard)
  - [6. takeTokens](#6-taketokens)
  - [7. takeTokensModify](#7-taketokensmodify)
  - [8. totalTokens](#8-totaltokens)
  - [9. onlyOneHeapLeft](#9-onlyoneheapleft)
  - [10. moveAndCheck](#10-moveandcheck)
  - [11. twoMoves](#11-twomoves)
  - [12. beforeAfter](#12-beforeafter)
  - [13. moveReturnOldBoard](#13-movereturnoldboard)
  - [14. moveReturnNewBoard](#14-movereturnnewboard)
  - [15. takeIfNotOver](#15-takeifnotover)
- [Part 2：非 Nim State Monad 押题](#part-2非-nim-state-monad-押题)
  - [16. counterGet](#16-counterget)
  - [17. counterInc](#17-counterinc)
  - [18. counterAdd](#18-counteradd)
  - [19. counterReset](#19-counterreset)
  - [20. counterAddAndReturnOld](#20-counteraddandreturnold)
  - [21. counterAddAndReturnNew](#21-counteraddandreturnnew)
  - [22. stackPush](#22-stackpush)
  - [23. stackPop](#23-stackpop)
  - [24. stackTop](#24-stacktop)
  - [25. stackSize](#25-stacksize)
  - [26. stackIsEmpty](#26-stackisempty)
  - [27. sumWithState](#27-sumwithstate)
  - [28. labelList](#28-labellist)
  - [29. replaceCharCount](#29-replacecharcount)
  - [30. runExamples](#30-runexamples)

---

# Part 1：Nim 最相关预测题

## 1. gameOver

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

## 2. firstHeap

```haskell
firstHeap :: NimGame Int
firstHeap = do
  (h1, _) <- get
  return h1
```

## 3. heapSize

```haskell
heapSize :: Heap -> NimGame Int
heapSize First = do
  (h1, _) <- get
  return h1

heapSize Second = do
  (_, h2) <- get
  return h2
```

## 4. clearHeap

```haskell
clearHeap :: Heap -> NimGame ()
clearHeap First = do
  (_, h2) <- get
  put (0, h2)

clearHeap Second = do
  (h1, _) <- get
  put (h1, 0)
```

## 5. clearBoard

```haskell
clearBoard :: NimGame ()
clearBoard = do
  put (0, 0)
```

## 6. takeTokens

```haskell
takeTokens :: Int -> Heap -> NimGame ()
takeTokens i First = do
  (h1, h2) <- get
  put (max 0 (h1 - i), h2)

takeTokens i Second = do
  (h1, h2) <- get
  put (h1, max 0 (h2 - i))
```

## 7. takeTokensModify

```haskell
takeTokensModify :: Int -> Heap -> NimGame ()
takeTokensModify i First =
  modify (\(h1, h2) -> (max 0 (h1 - i), h2))

takeTokensModify i Second =
  modify (\(h1, h2) -> (h1, max 0 (h2 - i)))
```

## 8. totalTokens

```haskell
totalTokens :: NimGame Int
totalTokens = do
  (h1, h2) <- get
  return (h1 + h2)
```

## 9. onlyOneHeapLeft

```haskell
onlyOneHeapLeft :: NimGame Bool
onlyOneHeapLeft = do
  (h1, h2) <- get
  return ((h1 > 0 && h2 == 0) || (h1 == 0 && h2 > 0))
```

## 10. moveAndCheck

```haskell
moveAndCheck :: Int -> Heap -> NimGame Bool
moveAndCheck i h = do
  takeTokens i h
  gameOver
```

## 11. twoMoves

```haskell
twoMoves :: NimGame Bool
twoMoves = do
  takeTokens 1 First
  takeTokens 2 Second
  gameOver
```

## 12. beforeAfter

```haskell
beforeAfter :: Int -> Heap -> NimGame (Int, Int)
beforeAfter i h = do
  before <- totalTokens
  takeTokens i h
  after <- totalTokens
  return (before, after)
```

## 13. moveReturnOldBoard

```haskell
moveReturnOldBoard :: Int -> Heap -> NimGame NimBoard
moveReturnOldBoard i h = do
  oldBoard <- get
  takeTokens i h
  return oldBoard
```

## 14. moveReturnNewBoard

```haskell
moveReturnNewBoard :: Int -> Heap -> NimGame NimBoard
moveReturnNewBoard i h = do
  takeTokens i h
  get
```

## 15. takeIfNotOver

```haskell
takeIfNotOver :: NimGame ()
takeIfNotOver = do
  over <- gameOver
  if over
    then return ()
    else takeTokens 1 First
```

---

# Part 2：非 Nim State Monad 押题

## 16. counterGet

```haskell
type Counter a = State Int a

counterGet :: Counter Int
counterGet = do
  n <- get
  return n
```

## 17. counterInc

```haskell
counterInc :: Counter ()
counterInc = do
  n <- get
  put (n + 1)
```

## 18. counterAdd

```haskell
counterAdd :: Int -> Counter ()
counterAdd x = do
  n <- get
  put (n + x)
```

## 19. counterReset

```haskell
counterReset :: Counter ()
counterReset = do
  put 0
```

## 20. counterAddAndReturnOld

```haskell
counterAddAndReturnOld :: Int -> Counter Int
counterAddAndReturnOld x = do
  old <- get
  put (old + x)
  return old
```

## 21. counterAddAndReturnNew

```haskell
counterAddAndReturnNew :: Int -> Counter Int
counterAddAndReturnNew x = do
  old <- get
  let new = old + x
  put new
  return new
```

## 22. stackPush

```haskell
type Stack a = State [Int] a

stackPush :: Int -> Stack ()
stackPush x = do
  xs <- get
  put (x : xs)
```

## 23. stackPop

```haskell
stackPop :: Stack (Maybe Int)
stackPop = do
  xs <- get
  case xs of
    []     -> return Nothing
    y : ys -> do
      put ys
      return (Just y)
```

## 24. stackTop

```haskell
stackTop :: Stack (Maybe Int)
stackTop = do
  xs <- get
  case xs of
    []    -> return Nothing
    y : _ -> return (Just y)
```

## 25. stackSize

```haskell
stackSize :: Stack Int
stackSize = do
  xs <- get
  return (length xs)
```

## 26. stackIsEmpty

```haskell
stackIsEmpty :: Stack Bool
stackIsEmpty = do
  xs <- get
  return (null xs)
```

## 27. sumWithState

```haskell
type SumState a = State Int a

addOneNumber :: Int -> SumState ()
addOneNumber x = do
  total <- get
  put (total + x)

sumWithState :: [Int] -> SumState Int
sumWithState [] = do
  total <- get
  return total

sumWithState (x:xs) = do
  addOneNumber x
  sumWithState xs
```

## 28. labelList

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

## 29. replaceCharCount

```haskell
type CountState a = State Int a

replaceCharCount :: Char -> Char -> String -> CountState String
replaceCharCount old new [] = return []

replaceCharCount old new (c:cs)
  | c == old = do
      count <- get
      put (count + 1)
      rest <- replaceCharCount old new cs
      return (new : rest)
  | otherwise = do
      rest <- replaceCharCount old new cs
      return (c : rest)
```

## 30. runExamples

```haskell
-- Nim
-- runState gameOver (0, 0)
-- runState (takeTokens 2 First) (5, 3)
-- runState (moveAndCheck 3 First) (3, 0)

-- Counter
-- runState counterInc 0
-- runState (counterAddAndReturnNew 5) 10

-- Stack
-- runState (stackPush 3) []
-- runState stackPop [1, 2, 3]

-- Sum
-- runState (sumWithState [1, 2, 3, 4]) 0

-- Label
-- runState (labelList ["a", "b", "c"]) 0

-- Replace char count
-- runState (replaceCharCount 'a' 'x' "banana") 0
```
