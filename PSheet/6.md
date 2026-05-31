# Problem Sheet for Week 6 中文整理版

## 目录

- [Binary Search Trees](#binary-search-trees)
- [Rose 地址题](#rose-trees)
- [Game Trees](#game-trees)
- [Exercise 1 - Applying Functions to Trees](#exercise-1---applying-functions-to-trees)
- [Exercise 2 - Updating Nodes Along a Route](#exercise-2---updating-nodes-along-a-route)

---

## Binary Search Trees

下面这些挑战来自 LectureNotes 的 **Binary Search Trees** 部分。

### 题目 1

写另一个版本的 `isBST`，要求在线性时间内运行，并且不要先生成 `in-order traversal list`。

### 答案

```haskell
-- 假设 BST 的定义如下：
data BST a = Empty | Node (BST a) a (BST a)
  deriving (Eq, Show)

isBST :: Ord a => BST a -> Bool
isBST t = check Nothing Nothing t
  where
    check :: Ord a => Maybe a -> Maybe a -> BST a -> Bool
    check _ _ Empty = True
    check lo hi (Node l x r) =
      biggerThanLo lo x && smallerThanHi hi x
      && check lo (Just x) l
      && check (Just x) hi r

    biggerThanLo :: Ord a => Maybe a -> a -> Bool
    biggerThanLo Nothing  _ = True
    biggerThanLo (Just m) x = x > m

    smallerThanHi :: Ord a => Maybe a -> a -> Bool
    smallerThanHi Nothing  _ = True
    smallerThanHi (Just m) x = x < m
```

---

### 题目 2

写一个 `delete'`，返回类型用 `Maybe`，用来表示没有东西可以删除。

### 答案

```haskell
delete' :: Ord a => a -> BST a -> Maybe (BST a)
delete' _ Empty = Nothing
delete' y (Node l x r)
  | y < x = case delete' y l of
              Nothing -> Nothing
              Just l' -> Just (Node l' x r)
  | y > x = case delete' y r of
              Nothing -> Nothing
              Just r' -> Just (Node l x r')
  | otherwise = Just (deleteRoot (Node l x r))


deleteRoot :: BST a -> BST a
deleteRoot Empty = Empty
deleteRoot (Node Empty _ r) = r
deleteRoot (Node l _ Empty) = l
deleteRoot (Node l _ r) =
  let (largest, l') = removeLargest l
  in Node l' largest r
```

---

### 题目 3

把 `largestOf` 和 `withoutLargest` 合并成一个函数，返回 pair，这样可以写出更高效的 `delete`，并且结合 `Maybe`，不要用 `undefined`。

### 答案

```haskell
removeLargest :: BST a -> (a, BST a)
removeLargest Empty = error "empty tree has no largest value"
removeLargest (Node l x Empty) = (x, l)
removeLargest (Node l x r) =
  let (largest, r') = removeLargest r
  in (largest, Node l x r')


deleteMaybe :: Ord a => a -> BST a -> Maybe (BST a)
deleteMaybe _ Empty = Nothing
deleteMaybe y (Node l x r)
  | y < x = case deleteMaybe y l of
              Nothing -> Nothing
              Just l' -> Just (Node l' x r)
  | y > x = case deleteMaybe y r of
              Nothing -> Nothing
              Just r' -> Just (Node l x r')
  | otherwise = Just (deleteRootMaybe (Node l x r))


deleteRootMaybe :: BST a -> BST a
deleteRootMaybe Empty = Empty
deleteRootMaybe (Node Empty _ r) = r
deleteRootMaybe (Node l _ Empty) = l
deleteRootMaybe (Node l _ r) =
  let (largest, l') = removeLargest l
  in Node l' largest r
```

---

# Rose Trees

回忆 **Rose Trees** 的定义：

```haskell
data Rose a = Branch a [Rose a]
  deriving (Eq, Show)
```

和 binary tree 一样，Rose tree 也有 **direction** 和 **address**。

这里定义一个 **direction** 为 `Int`，表示在 children list 中的位置；一个 **address** 是 direction 的 list。

```haskell
type Direction = Int
type Address = [Direction]
```

### 题目 答案

```haskell
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

---

## Game Trees

### 题目

为 **Naughts and Crosses** 写 board 和 move 的数据类型，并实现类似 `nimPlays` 的函数。

### 答案

```haskell
data Player = Naught | Cross
  deriving (Eq, Show)

data Cell = EmptyCell | Taken Player
  deriving (Eq, Show)

type Board = [[Cell]]
type Move = (Int, Int)


other :: Player -> Player
other Naught = Cross
other Cross  = Naught


emptyBoard :: Board
emptyBoard = replicate 3 (replicate 3 EmptyCell)


naughtsCrossesPlays :: Player -> Board -> [(Move, Board)]
naughtsCrossesPlays p board =
  [ ((i, j), makeMove p (i, j) board)
  | i <- [0..2]
  , j <- [0..2]
  , board !! i !! j == EmptyCell
  ]


makeMove :: Player -> Move -> Board -> Board
makeMove p (row, col) board =
  [ [ if i == row && j == col then Taken p else cell
    | (j, cell) <- zip [0..] cells
    ]
  | (i, cells) <- zip [0..] board
  ]
```

---

## Exercise 1 - Applying Functions to Trees

### Background Material

这里使用一种 binary tree，它在 fork 和 leaf 上存不同类型的数据：

```haskell
data Tree a b = Leaf b | Fork (Tree a b) a (Tree a b)
  deriving (Eq, Show)
```

这个 tree 在每个 fork 存一个 `a` 类型的值，在每个 leaf 存一个 `b` 类型的值。

---

### Implementation Task

实现 higher-order function `applyfuns`：

- `f :: a -> c` 用来处理 fork 上的值
- `g :: b -> d` 用来处理 leaf 上的值
- 最后把 `Tree a b` 变成 `Tree c d`

### 答案

```haskell
applyfuns :: (a -> c) -> (b -> d) -> Tree a b -> Tree c d
applyfuns f g (Leaf x) = Leaf (g x)
applyfuns f g (Fork l x r) =
  Fork (applyfuns f g l) (f x) (applyfuns f g r)
```

---

### Examples

定义两个函数：

```haskell
str2int :: String -> Int
str2int xs = length xs

int2bool :: Int -> Bool
int2bool n = n /= 0
```

第一个例子：

```haskell
example1 :: Tree String Int
example1 =
  Fork
    (Fork (Leaf 2) "Oliver" (Leaf 4))
    "John"
    (Fork (Leaf 0) "Benjamin" (Leaf 6))

result1 :: Tree Int Bool
result1 = applyfuns str2int int2bool example1
```

运行结果：

```haskell
Fork (Fork (Leaf True) 6 (Leaf True)) 4 (Fork (Leaf False) 8 (Leaf True))
```

第二个例子：

```haskell
example2 :: Tree String Int
example2 =
  Fork
    (Fork
      (Fork (Leaf 0) "London" (Leaf 10))
      "Paris"
      (Leaf 14))
    "New York"
    (Fork
      (Leaf 5)
      "Dubai"
      (Fork (Leaf 0) "Shanghai" (Leaf 21)))

result2 :: Tree Int Bool
result2 = applyfuns str2int int2bool example2
```

运行结果：

```haskell
Fork (Fork (Fork (Leaf False) 6 (Leaf True)) 5 (Leaf True)) 8 (Fork (Leaf True) 5 (Fork (Leaf False) 8 (Leaf True)))
```

---

## Exercise 2 - Updating Nodes Along a Route

### Background Material

这里使用一种只在 node 存数据的 binary tree：

```haskell
data BinTree a = Empty | Node (BinTree a) a (BinTree a)
  deriving (Eq, Show)
```

定义 `Route`，用来表示从 root 出发的路线：

```haskell
data Direction = GoLeft | GoRight
  deriving (Eq, Show, Bounded, Enum)

type Route = [Direction]
```

`Route` 是 direction 的 list，用来说明每一步往左还是往右。

例如：

1. 到 root 的 route 是 `[] :: Route`。
2. 如果 tree 是：

```text
               'a'
               / \
              /   \
            'b'   'c'
                  / \
                 /   \
               'd'   'e'
```

那么：

- `[GoLeft]` 到 `'b'`
- `[GoRight, GoLeft]` 到 `'d'`
- `[GoRight, GoRight]` 到 `'e'`

---

### Implementation Task

实现 `updateNodes`，让它把函数 `f` 应用到 route 经过的所有 node 上，包括 root。

### 答案

```haskell
updateNodes :: Route -> (a -> a) -> BinTree a -> BinTree a
updateNodes _ _ Empty = Empty
updateNodes [] f (Node l x r) = Node l (f x) r
updateNodes (GoLeft:ds) f (Node l x r) =
  Node (updateNodes ds f l) (f x) r
updateNodes (GoRight:ds) f (Node l x r) =
  Node l (f x) (updateNodes ds f r)
```

---

### 规则说明

1. 如果 route 用完了，就停下，不继续修改下面的 subtree。
2. 如果 route 太长，已经走到 `Empty`，就停下，剩下的 direction 直接忽略。
3. `updateNodes` 会修改 route 经过的所有 node，包括 root。

---

### Examples

定义测试 tree：

```haskell
t :: BinTree Int
t = Node
      (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty))
      1
      (Node Empty 99 (Node Empty 100 Empty))
```

运行例子：

```haskell
updateNodes [] (*8) t
-- Node (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty)) 8 (Node Empty 99 (Node Empty 100 Empty))
```

```haskell
updateNodes [GoRight] (*8) t
-- Node (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty)) 8 (Node Empty 792 (Node Empty 100 Empty))
```

```haskell
updateNodes [GoRight, GoLeft] (*8) t
-- Node (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty)) 8 (Node Empty 792 (Node Empty 100 Empty))
```

```haskell
updateNodes [GoRight, GoRight] (*8) t
-- Node (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty)) 8 (Node Empty 792 (Node Empty 800 Empty))
```

```haskell
updateNodes [GoRight, GoRight, GoLeft] (*8) t
-- Node (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty)) 8 (Node Empty 792 (Node Empty 800 Empty))
```

```haskell
updateNodes [GoLeft, GoLeft, GoLeft] (*15) t
-- Node (Node (Node Empty 45 Empty) 30 (Node Empty 4 Empty)) 15 (Node Empty 99 (Node Empty 100 Empty))
```
