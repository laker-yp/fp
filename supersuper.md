# Haskell 课堂笔记超级大总合

> 目标：只保留 **标题 + 简短介绍 + 相关核心代码**。  
> 风格：复习/考试前速查版，不做长篇解释。

---

## 目录

- [1. Haskell 基础类型与类型系统](#1-haskell-基础类型与类型系统)
  - [1.1 Type inference / Type checking](#11-type-inference--type-checking)
  - [1.2 Base types](#12-base-types)
  - [1.3 Composite types](#13-composite-types)
  - [1.4 Curried functions](#14-curried-functions)
  - [1.5 Well-typed programs can still fail](#15-well-typed-programs-can-still-fail)
- [2. Polymorphism 多态](#2-polymorphism-多态)
  - [2.1 Type variables](#21-type-variables)
  - [2.2 Polymorphic list constructors](#22-polymorphic-list-constructors)
  - [2.3 zip](#23-zip)
- [3. Functions in Haskell](#3-functions-in-haskell)
  - [3.1 Function composition](#31-function-composition)
  - [3.2 Conditionals](#32-conditionals)
  - [3.3 Guards](#33-guards)
  - [3.4 Pattern matching](#34-pattern-matching)
  - [3.5 Lambda expressions](#35-lambda-expressions)
  - [3.6 Infix / prefix operators](#36-infix--prefix-operators)
- [4. Recursive Functions](#4-recursive-functions)
  - [4.1 Base case + recursive case](#41-base-case--recursive-case)
  - [4.2 Recursion on lists](#42-recursion-on-lists)
  - [4.3 Multiple arguments](#43-multiple-arguments)
  - [4.4 Quicksort](#44-quicksort)
- [5. List Comprehensions](#5-list-comprehensions)
  - [5.1 Basic list comprehension](#51-basic-list-comprehension)
  - [5.2 Multiple generators](#52-multiple-generators)
  - [5.3 Dependent generators](#53-dependent-generators)
  - [5.4 Guards in list comprehension](#54-guards-in-list-comprehension)
  - [5.5 factors / prime / primes](#55-factors--prime--primes)
  - [5.6 zip / pairs / sorted](#56-zip--pairs--sorted)
  - [5.7 Caesar cipher](#57-caesar-cipher)
- [6. Higher-order Functions](#6-higher-order-functions)
  - [6.1 Higher-order function](#61-higher-order-function)
  - [6.2 map](#62-map)
  - [6.3 filter](#63-filter)
  - [6.4 foldr](#64-foldr)
  - [6.5 foldl](#65-foldl)
  - [6.6 Function composition operator](#66-function-composition-operator)
  - [6.7 all / any / takeWhile / dropWhile](#67-all--any--takewhile--dropwhile)
- [7. User-defined Data Types](#7-user-defined-data-types)
  - [7.1 Type synonyms](#71-type-synonyms)
  - [7.2 data types](#72-data-types)
  - [7.3 Type isomorphisms](#73-type-isomorphisms)
  - [7.4 WeekDay](#74-weekday)
  - [7.5 Maybe](#75-maybe)
  - [7.6 Either](#76-either)
  - [7.7 Custom pair / product type](#77-custom-pair--product-type)
- [8. Type Classes and Instances](#8-type-classes-and-instances)
  - [8.1 Eq](#81-eq)
  - [8.2 Class constraints](#82-class-constraints)
  - [8.3 Ord](#83-ord)
  - [8.4 Ordering](#84-ordering)
  - [8.5 Num](#85-num)
  - [8.6 Enum](#86-enum)
  - [8.7 Custom type class](#87-custom-type-class)
  - [8.8 Instance with constraints](#88-instance-with-constraints)
- [9. Binary Trees](#9-binary-trees)
  - [9.1 BT definition](#91-bt-definition)
  - [9.2 mirror / size / leaves / height](#92-mirror--size--leaves--height)
  - [9.3 Directions / Address / subtree](#93-directions--address--subtree)
  - [9.4 Traversals](#94-traversals)
  - [9.5 Inverting traversals](#95-inverting-traversals)
- [10. Binary Search Trees](#10-binary-search-trees)
  - [10.1 BST property](#101-bst-property)
  - [10.2 isBST](#102-isbst)
  - [10.3 isBST by inorder](#103-isbst-by-inorder)
  - [10.4 occurs](#104-occurs)
  - [10.5 insert](#105-insert)
  - [10.6 insert with Maybe](#106-insert-with-maybe)
  - [10.7 delete](#107-delete)
  - [10.8 sorting by BST](#108-sorting-by-bst)
- [11. Rose Trees](#11-rose-trees)
  - [11.1 Rose tree definition](#111-rose-tree-definition)
  - [11.2 rsize / rheight](#112-rsize--rheight)
- [12. Permutation Trees](#12-permutation-trees)
  - [12.1 Edge-labelled tree](#121-edge-labelled-tree)
  - [12.2 fullPaths / paths](#122-fullpaths--paths)
  - [12.3 permTree / permutations](#123-permtree--permutations)
  - [12.4 removals](#124-removals)
- [13. Game Trees and Nim](#13-game-trees-and-nim)
  - [13.1 GameTree definition](#131-gametree-definition)
  - [13.2 Nim board and moves](#132-nim-board-and-moves)
  - [13.3 nimPlays](#133-nimplays)
  - [13.4 nim](#134-nim)
  - [13.5 winning / losing strategy](#135-winning--losing-strategy)
- [14. Laziness and Lazy Natural Numbers](#14-laziness-and-lazy-natural-numbers)
  - [14.1 Motivating example](#141-motivating-example)
  - [14.2 Nat](#142-nat)
  - [14.3 Infinite Nat](#143-infinite-nat)
  - [14.4 Lazy length](#144-lazy-length)
  - [14.5 biggerThan](#145-biggerthan)
- [15. Memoization](#15-memoization)
  - [15.1 Inefficient fib](#151-inefficient-fib)
  - [15.2 fix / fixed point](#152-fix--fixed-point)
  - [15.3 fibstep](#153-fibstep)
  - [15.4 memoList](#154-memolist)
  - [15.5 fixml](#155-fixml)
- [16. Monads](#16-monads)
  - [16.1 IO monad](#161-io-monad)
  - [16.2 Monad-style fib](#162-monad-style-fib)
  - [16.3 Maybe monad](#163-maybe-monad)
  - [16.4 List monad](#164-list-monad)
  - [16.5 Writer monad](#165-writer-monad)
  - [16.6 State monad](#166-state-monad)
- [17. Parser Combinators](#17-parser-combinators)
  - [17.1 Parser type](#171-parser-type)
  - [17.2 parse / item](#172-parse--item)
  - [17.3 Functor instance](#173-functor-instance)
  - [17.4 Applicative instance](#174-applicative-instance)
  - [17.5 Monad instance](#175-monad-instance)
  - [17.6 Alternative instance](#176-alternative-instance)
  - [17.7 Basic parsers](#177-basic-parsers)
  - [17.8 Expression parser skeleton](#178-expression-parser-skeleton)
- [18. 常用考试代码模板](#18-常用考试代码模板)

---

# 1. Haskell 基础类型与类型系统

## 1.1 Type inference / Type checking

**Type inference**：GHCi 自动推断 expression 的 type。  
**Type checking**：手动给 expression 标注 type，让 GHCi 检查是否成立。

```haskell
:t False
-- False :: Bool

:t not
-- not :: Bool -> Bool

:t False :: Bool
-- False :: Bool :: Bool
```

## 1.2 Base types

Haskell 常见基础类型：`Bool`、`Char`、`Int`、`Integer`、`Float`、`Double`。

```haskell
True  :: Bool
'a'   :: Char
123   :: Int
123   :: Integer
1.2   :: Float
1.2   :: Double
```

## 1.3 Composite types

Composite types 是由已有 types 组合出来的新 type。

```haskell
[Char]              -- String
[Int]               -- list of Int
(Bool, Char)        -- pair
Int -> Bool         -- function type
Integer -> Integer  -- function type
```

```haskell
:t "hello"
-- "hello" :: [Char]

:t (False, 'c')
-- (False, 'c') :: (Bool, Char)
```

## 1.4 Curried functions

Haskell 默认函数是 curried：多个参数本质上是连续返回函数。

```haskell
add :: (Integer, Integer) -> Integer
add (x,y) = x + y

add' :: Integer -> Integer -> Integer
add' x y = x + y

add3 :: Integer -> Integer -> Integer -> Integer
add3 x y z = x + y + z
```

## 1.5 Well-typed programs can still fail

Type 正确不代表运行一定安全。

```haskell
:t (!!)
-- (!!) :: [a] -> Int -> a

["foo", "bar"] !! 5
-- runtime error
```

---

# 2. Polymorphism 多态

## 2.1 Type variables

Polymorphic function 的 type 里含有 type variables，例如 `a`、`b`。

```haskell
id :: a -> a
id x = x
```

## 2.2 Polymorphic list constructors

空列表和 cons `(:)` 都是 polymorphic。

```haskell
[]  :: [a]
(:) :: a -> [a] -> [a]
```

```haskell
'a' : ['b','c']
-- "abc"
```

## 2.3 zip

`zip` 可以把两个不同 element type 的 list 合成 pair list。

```haskell
zip :: [a] -> [b] -> [(a,b)]

zip [1,2,3] ['a','b','c']
-- [(1,'a'),(2,'b'),(3,'c')]
```

---

# 3. Functions in Haskell

## 3.1 Function composition

用已有 functions 组合出新 function。

```haskell
removeLast :: [a] -> [a]
removeLast xs = reverse (tail (reverse xs))

removeElem :: Int -> [a] -> [a]
removeElem n xs = removeLast (take n xs) ++ drop n xs
```

## 3.2 Conditionals

`if _ then _ else _` 的两个分支必须是同一 type。

```haskell
abs' :: Integer -> Integer
abs' n = if n >= 0 then n else -n
```

## 3.3 Guards

Guards 用于多条件分支。

```haskell
absG :: Int -> Int
absG n | n >= 0    = n
       | otherwise = -n

howMuch :: Int -> String
howMuch x | x < 3     = "I dislike it!"
          | x < 7     = "It's ok!"
          | otherwise = "It's fun!"
```

## 3.4 Pattern matching

Pattern matching 根据 input 的构造形式分情况处理。

```haskell
notB :: Bool -> Bool
notB False = True
notB True  = False

swap :: (a,b) -> (b,a)
swap (x,y) = (y,x)

isEmpty :: [a] -> Bool
isEmpty []     = True
isEmpty (_:_)  = False
```

## 3.5 Lambda expressions

匿名函数，用 `\` 写。

```haskell
(\x -> x + 1) 3
-- 4

map (\x -> x * 2) [1,2,3]
-- [2,4,6]
```

## 3.6 Infix / prefix operators

Operator 可以中缀用，也可以前缀用。

```haskell
1 + 2
(+) 1 2

[1,2] ++ [3,4]
(++) [1,2] [3,4]
```

---

# 4. Recursive Functions

## 4.1 Base case + recursive case

递归核心：必须有 base case，并且 recursive case 要逐步靠近 base case。

```haskell
fac :: Int -> Int
fac 0 = 1
fac n = n * fac (n-1)
```

## 4.2 Recursion on lists

List 常见递归结构：`[]` 和 `(x:xs)`。

```haskell
sum' :: Num a => [a] -> a
sum' []     = 0
sum' (x:xs) = x + sum' xs

product' :: Num a => [a] -> a
product' []     = 1
product' (x:xs) = x * product' xs

length' :: [a] -> Int
length' []     = 0
length' (_:xs) = 1 + length' xs
```

## 4.3 Multiple arguments

递归可以同时处理多个参数。

```haskell
zip' :: [a] -> [b] -> [(a,b)]
zip' [] _          = []
zip' _ []          = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys
```

## 4.4 Quicksort

经典递归排序。

```haskell
qsort :: Ord a => [a] -> [a]
qsort []     = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
  where
    smaller = [a | a <- xs, a <= x]
    larger  = [b | b <- xs, b >  x]
```

---

# 5. List Comprehensions

## 5.1 Basic list comprehension

```haskell
[x^2 | x <- [1..5]]
-- [1,4,9,16,25]
```

## 5.2 Multiple generators

多个 generators 类似嵌套循环。

```haskell
[(x,y) | x <- [1,2,3], y <- [4,5]]
-- [(1,4),(1,5),(2,4),(2,5),(3,4),(3,5)]
```

## 5.3 Dependent generators

后面的 generator 可以依赖前面的变量。

```haskell
[(x,y) | x <- [1..3], y <- [x..3]]
-- [(1,1),(1,2),(1,3),(2,2),(2,3),(3,3)]
```

```haskell
concat' :: [[a]] -> [a]
concat' xss = [x | xs <- xss, x <- xs]
```

## 5.4 Guards in list comprehension

Guard 用来筛选 generator 产生的 values。

```haskell
[x | x <- [1..10], even x]
-- [2,4,6,8,10]
```

## 5.5 factors / prime / primes

```haskell
factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]

prime :: Int -> Bool
prime n = factors n == [1,n]

primes :: Int -> [Int]
primes n = [x | x <- [2..n], prime x]
```

## 5.6 zip / pairs / sorted

```haskell
pairs :: [a] -> [(a,a)]
pairs xs = zip xs (tail xs)

sorted :: Ord a => [a] -> Bool
sorted xs = and [x <= y | (x,y) <- pairs xs]
```

## 5.7 Caesar cipher

```haskell
import Data.Char

let2int :: Char -> Int
let2int c = ord c - ord 'a'

int2let :: Int -> Char
int2let n = chr (ord 'a' + n)

shift :: Int -> Char -> Char
shift n c | isLower c = int2let ((let2int c + n) `mod` 26)
          | otherwise = c

encode :: Int -> String -> String
encode n xs = [shift n x | x <- xs]
```

---

# 6. Higher-order Functions

## 6.1 Higher-order function

Higher-order function：接收 function 作为参数，或返回 function。

```haskell
twice :: (a -> a) -> a -> a
twice f x = f (f x)
```

## 6.2 map

`map` 把 function 应用到 list 每个 element 上。

```haskell
map' :: (a -> b) -> [a] -> [b]
map' f []     = []
map' f (x:xs) = f x : map' f xs
```

## 6.3 filter

`filter` 保留满足 predicate 的 elements。

```haskell
filter' :: (a -> Bool) -> [a] -> [a]
filter' p [] = []
filter' p (x:xs)
  | p x       = x : filter' p xs
  | otherwise = filter' p xs
```

## 6.4 foldr

`foldr` 封装右递归模式。

```haskell
foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' f v []     = v
foldr' f v (x:xs) = f x (foldr' f v xs)
```

```haskell
sumF :: Num a => [a] -> a
sumF = foldr (+) 0

productF :: Num a => [a] -> a
productF = foldr (*) 1

andF :: [Bool] -> Bool
andF = foldr (&&) True

lengthF :: [a] -> Int
lengthF = foldr (\_ n -> 1 + n) 0

reverseF :: [a] -> [a]
reverseF = foldr (\x xs -> xs ++ [x]) []

appendF :: [a] -> [a] -> [a]
appendF xs ys = foldr (:) ys xs
```

## 6.5 foldl

`foldl` 从左向右累积，常用于 accumulator。

```haskell
foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' f acc []     = acc
foldl' f acc (x:xs) = foldl' f (f acc x) xs

reverseL :: [a] -> [a]
reverseL = foldl (\acc x -> x : acc) []
```

## 6.6 Function composition operator

```haskell
(.) :: (b -> c) -> (a -> b) -> a -> c
(f . g) x = f (g x)
```

```haskell
oddSquares :: [Int] -> [Int]
oddSquares = map (^2) . filter odd
```

## 6.7 all / any / takeWhile / dropWhile

```haskell
all' :: (a -> Bool) -> [a] -> Bool
all' p = foldr (\x acc -> p x && acc) True

any' :: (a -> Bool) -> [a] -> Bool
any' p = foldr (\x acc -> p x || acc) False

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' p [] = []
takeWhile' p (x:xs)
  | p x       = x : takeWhile' p xs
  | otherwise = []

dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' p [] = []
dropWhile' p xs@(x:xs')
  | p x       = dropWhile' p xs'
  | otherwise = xs
```

---

# 7. User-defined Data Types

## 7.1 Type synonyms

`type` 只是给已有 type 起别名。

```haskell
type String = [Char]
type Lst a = [a]
type Pos = (Int, Int)
```

## 7.2 data types

`data` 定义真正的新 type。

```haskell
data Bool' = False' | True'

data Shape = Circle Float | Rect Float Float
```

```haskell
area :: Shape -> Float
area (Circle r) = pi * r * r
area (Rect w h) = w * h
```

## 7.3 Type isomorphisms

两个 type 如果可以互相转换且互为 inverse，就是 isomorphic。

```haskell
data BW = Black | White

data Bit = Zero | One

bw2bool :: BW -> Bool
bw2bool Black = False
bw2bool White = True

bool2bw :: Bool -> BW
bool2bw False = Black
bool2bw True  = White
```

## 7.4 WeekDay

```haskell
data WeekDay = Mon | Tue | Wed | Thu | Fri | Sat | Sun
  deriving (Show, Read, Eq, Ord, Enum, Bounded)
```

```haskell
succ Mon
pred Tue
minBound :: WeekDay
maxBound :: WeekDay
[Mon .. Sun]
```

## 7.5 Maybe

`Maybe a` 表示可能成功，也可能失败。

```haskell
data Maybe a = Nothing | Just a
```

```haskell
safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x
```

## 7.6 Either

`Either a b` 表示两种可能之一，常用于带错误信息的返回。

```haskell
data Either a b = Left a | Right b
```

```haskell
safeDiv :: Int -> Int -> Either String Int
safeDiv _ 0 = Left "division by zero"
safeDiv x y = Right (x `div` y)
```

## 7.7 Custom pair / product type

```haskell
data And a b = Both a b

fstA :: And a b -> a
fstA (Both x _) = x

sndA :: And a b -> b
sndA (Both _ y) = y
```

---

# 8. Type Classes and Instances

## 8.1 Eq

`Eq` 表示支持 equality operations。

```haskell
(==) :: Eq a => a -> a -> Bool
(/=) :: Eq a => a -> a -> Bool
```

```haskell
data Colour = Red | Blue | Green
  deriving (Eq, Show)
```

## 8.2 Class constraints

`Eq a =>` 表示 type `a` 必须是 `Eq` 的 instance。

```haskell
member :: Eq a => a -> [a] -> Bool
member x [] = False
member x (y:ys) = x == y || member x ys
```

## 8.3 Ord

`Ord` 表示 type 可以比较大小，并且继承 `Eq`。

```haskell
class Eq a => Ord a where
  compare :: a -> a -> Ordering
  (<), (<=), (>), (>=) :: a -> a -> Bool
  max, min :: a -> a -> a
```

## 8.4 Ordering

```haskell
data Ordering = LT | EQ | GT
  deriving (Eq, Ord, Enum, Read, Show, Bounded)
```

```haskell
compare 3 5
-- LT
```

## 8.5 Num

`Num` 表示 numeric types。

```haskell
(+) :: Num a => a -> a -> a
(-) :: Num a => a -> a -> a
(*) :: Num a => a -> a -> a
```

```haskell
:t 1
-- 1 :: Num p => p

:t 1 :: Int
-- 1 :: Int :: Int
```

## 8.6 Enum

`Enum` 支持枚举。

```haskell
enumFromTo :: Enum a => a -> a -> [a]

[1..5]
['a'..'e']
```

## 8.7 Custom type class

```haskell
class MyEq a where
  (===) :: a -> a -> Bool

instance MyEq Bool where
  False === False = True
  True  === True  = True
  _     === _     = False
```

## 8.8 Instance with constraints

如果 `a` 和 `b` 都能比较，那么 pair 也能比较。

```haskell
instance (MyEq a, MyEq b) => MyEq (a,b) where
  (x,y) === (u,v) = x === u && y === v
```

List 的 equality：

```haskell
instance MyEq a => MyEq [a] where
  []     === []     = True
  (x:xs) === (y:ys) = x === y && xs === ys
  _      === _      = False
```

Function equality on finite domain `Bool`：

```haskell
{-# LANGUAGE FlexibleInstances #-}

instance Eq a => Eq (Bool -> a) where
  f == g = f True == g True && f False == g False
```

---

# 9. Binary Trees

## 9.1 BT definition

```haskell
data BT a = Empty | Fork a (BT a) (BT a)
  deriving (Show, Read, Eq, Ord)
```

Example：

```haskell
bt1 :: BT Integer
bt1 = Fork 8
        (Fork 4 (Fork 2 Empty Empty) Empty)
        (Fork 16 Empty (Fork 20 Empty Empty))
```

## 9.2 mirror / size / leaves / height

```haskell
mirror :: BT a -> BT a
mirror Empty = Empty
mirror (Fork x l r) = Fork x (mirror r) (mirror l)

size :: BT a -> Integer
size Empty        = 0
size (Fork _ l r) = 1 + size l + size r

leaves :: BT a -> Integer
leaves Empty        = 1
leaves (Fork _ l r) = leaves l + leaves r

height :: BT a -> Integer
height Empty        = 0
height (Fork _ l r) = 1 + max (height l) (height r)
```

## 9.3 Directions / Address / subtree

```haskell
data Direction = L | R
  deriving (Show, Eq)

type Address = [Direction]

subtree :: Address -> BT a -> Maybe (BT a)
subtree [] t = Just t
subtree (_:_) Empty = Nothing
subtree (L:ds) (Fork _ l _) = subtree ds l
subtree (R:ds) (Fork _ _ r) = subtree ds r
```

## 9.4 Traversals

```haskell
treePreOrder :: BT a -> [a]
treePreOrder Empty = []
treePreOrder (Fork x l r) = [x] ++ treePreOrder l ++ treePreOrder r

treeInOrder :: BT a -> [a]
treeInOrder Empty = []
treeInOrder (Fork x l r) = treeInOrder l ++ [x] ++ treeInOrder r

treePostOrder :: BT a -> [a]
treePostOrder Empty = []
treePostOrder (Fork x l r) = treePostOrder l ++ treePostOrder r ++ [x]
```

## 9.5 Inverting traversals

根据 traversal list 重新生成 tree 的核心思想：递归拆 root / left / right。

```haskell
splitAtValue :: Eq a => a -> [a] -> ([a],[a])
splitAtValue x xs = (takeWhile (/= x) xs, tail (dropWhile (/= x) xs))
```

---

# 10. Binary Search Trees

## 10.1 BST property

BST：左子树所有值 `< root`，右子树所有值 `> root`。

```haskell
-- data BT a = Empty | Fork a (BT a) (BT a)
```

## 10.2 isBST

低效版本：每个 node 都检查左边全小、右边全大。

```haskell
isBST :: Ord a => BT a -> Bool
isBST Empty        = True
isBST (Fork x l r) = allSmaller x l
                  && allBigger  x r
                  && isBST l
                  && isBST r

allSmaller :: Ord a => a -> BT a -> Bool
allSmaller _ Empty = True
allSmaller x (Fork y l r) = y < x && allSmaller x l && allSmaller x r

allBigger :: Ord a => a -> BT a -> Bool
allBigger _ Empty = True
allBigger x (Fork y l r) = y > x && allBigger x l && allBigger x r
```

## 10.3 isBST by inorder

BST 的 inorder traversal 应该是 increasing list。

```haskell
isBST' :: Ord a => BT a -> Bool
isBST' t = isIncreasing (treeInOrder t)

isIncreasing :: Ord a => [a] -> Bool
isIncreasing []       = True
isIncreasing [_]      = True
isIncreasing (x:y:zs) = x < y && isIncreasing (y:zs)
```

Linear bound-checking version：

```haskell
isBSTLinear :: Ord a => BT a -> Bool
isBSTLinear t = check Nothing Nothing t
  where
    check _ _ Empty = True
    check lower upper (Fork x l r) =
      withinLower lower x &&
      withinUpper upper x &&
      check lower (Just x) l &&
      check (Just x) upper r

    withinLower Nothing _ = True
    withinLower (Just lo) x = lo < x

    withinUpper Nothing _ = True
    withinUpper (Just hi) x = x < hi
```

## 10.4 occurs

BST 搜索，平均平衡时 `O(log n)`。

```haskell
occurs :: Ord a => a -> BT a -> Bool
occurs _ Empty = False
occurs x (Fork y l r) = x == y
                     || (x < y && occurs x l)
                     || (x > y && occurs x r)
```

## 10.5 insert

```haskell
insert :: Ord a => a -> BT a -> BT a
insert v Empty = Fork v Empty Empty
insert v (Fork x l r)
  | v == x    = Fork x l r
  | v < x     = Fork x (insert v l) r
  | otherwise = Fork x l (insert v r)
```

## 10.6 insert with Maybe

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
```

## 10.7 delete

删除 node：最难情况是左右子树都存在，用左子树最大值替代 root。

```haskell
delete :: Ord a => a -> BT a -> BT a
delete _ Empty = Empty
delete x (Fork y l r)
  | x < y                = Fork y (delete x l) r
  | x > y                = Fork y l (delete x r)
  | x == y && l == Empty = r
  | x == y && r == Empty = l
  | otherwise            = Fork (largestOf l) (withoutLargest l) r

largestOf :: Ord a => BT a -> a
largestOf Empty = undefined
largestOf (Fork x _ Empty) = x
largestOf (Fork _ _ r)     = largestOf r

withoutLargest :: Ord a => BT a -> BT a
withoutLargest Empty = undefined
withoutLargest (Fork _ l Empty) = l
withoutLargest (Fork x l r)     = Fork x l (withoutLargest r)
```

## 10.8 sorting by BST

```haskell
insertAll :: Ord a => [a] -> BT a
insertAll = foldr insert Empty

sortBST :: Ord a => [a] -> [a]
sortBST xs = treeInOrder (insertAll xs)
```

---

# 11. Rose Trees

## 11.1 Rose tree definition

Rose tree：每个 node 可以有任意数量 children。

```haskell
data Rose a = Branch a [Rose a]
  deriving (Show, Eq)
```

## 11.2 rsize / rheight

```haskell
rsize :: Rose a -> Integer
rsize (Branch _ ts) = 1 + sum (map rsize ts)

rheight :: Rose a -> Integer
rheight (Branch _ []) = 1
rheight (Branch _ ts) = 1 + maximum (map rheight ts)
```

---

# 12. Permutation Trees

## 12.1 Edge-labelled tree

label 在边上；leaf 是 `EBranch []`。

```haskell
data Tree a = EBranch [(a, Tree a)]
  deriving (Show)
```

## 12.2 fullPaths / paths

`fullPaths`：只返回 root 到 leaf 的完整路径。  
`paths`：返回 root 到任意 node 的路径。

```haskell
fullPaths :: Tree a -> [[a]]
fullPaths (EBranch []) = [[]]
fullPaths (EBranch forest) = [x:p | (x,t) <- forest, p <- fullPaths t]

paths :: Tree a -> [[a]]
paths (EBranch forest) = [] : [x:p | (x,t) <- forest, p <- paths t]
```

## 12.3 permTree / permutations

Permutation tree：每层选一个没用过的元素。

```haskell
permTree :: Eq a => [a] -> Tree a
permTree xs = EBranch [(v, permTree (xs \\\ v)) | v <- xs]
  where
    (\\\) :: Eq a => [a] -> a -> [a]
    []     \\\ _ = undefined
    (x:xs) \\\ y
      | x == y    = xs
      | otherwise = x : (xs \\\ y)

permutations' :: Eq a => [a] -> [[a]]
permutations' = fullPaths . permTree
```

## 12.4 removals

返回每种“移除一个元素后”的结果。

```haskell
removals :: [a] -> [(a,[a])]
removals [] = []
removals (x:xs) = (x,xs) : [(y, x:ys) | (y,ys) <- removals xs]

perms :: [a] -> [[a]]
perms [] = [[]]
perms xs = [x:p | (x,ys) <- removals xs, p <- perms ys]
```

---

# 13. Game Trees and Nim

## 13.1 GameTree definition

Game tree：node 是当前 board；每条边是 move；子树是 move 后的新局面。

```haskell
data GameTree board move = Node board [(move, GameTree board move)]
  deriving (Show)

gameTree :: (board -> [(move, board)]) -> board -> GameTree board move
gameTree plays board = Node board [(m, gameTree plays b) | (m,b) <- plays board]
```

## 13.2 Nim board and moves

```haskell
type NimBoard = [Integer]

data NimMove = Remove Int Integer
  deriving (Show, Eq)
```

## 13.3 nimPlays

从一个 Nim board 生成所有合法下一步。

```haskell
nimPlays :: NimBoard -> [(NimMove, NimBoard)]
nimPlays heaps =
  [(Remove i k, hs ++ (h-k) : hs')
    | i <- [0 .. length heaps - 1],
      let (hs, h:hs') = splitAt i heaps,
      k <- [1..h]]
```

## 13.4 nim

```haskell
nim :: [Integer] -> GameTree NimBoard NimMove
nim = gameTree nimPlays

-- equivalent:
-- nim initHeaps = gameTree nimPlays initHeaps
```

## 13.5 winning / losing strategy

`isWinning`：存在一步让对手进入 losing。  
`isLosing`：所有可走步都会让对手 winning。

```haskell
isWinning, isLosing :: Bool -> GameTree board move -> Bool

isWinning isMisere (Node _ mgs)
  | null mgs  = isMisere
  | otherwise = any (isLosing isMisere) [g | (_,g) <- mgs]

isLosing isMisere (Node _ mgs)
  | null mgs  = not isMisere
  | otherwise = all (isWinning isMisere) [g | (_,g) <- mgs]
```

---

# 14. Laziness and Lazy Natural Numbers

## 14.1 Motivating example

普通 `length xs > n` 会先算完整 list 长度；无限 list 会卡住。

```haskell
checkLengthBiggerThan :: [a] -> Int -> Bool
checkLengthBiggerThan xs n = length xs > n
```

手写提前停止版本：

```haskell
checkLengthBiggerThan' :: [a] -> Int -> Bool
checkLengthBiggerThan' []     0 = False
checkLengthBiggerThan' xs     0 = True
checkLengthBiggerThan' []     n = False
checkLengthBiggerThan' (_:xs) n = checkLengthBiggerThan' xs (n-1)
```

## 14.2 Nat

Lazy natural number。

```haskell
data Nat = Zero | Succ Nat
  deriving (Eq, Ord)

one, two, three :: Nat
one   = Succ Zero
two   = Succ one
three = Succ two
```

```haskell
toNat :: Int -> Nat
toNat 0 = Zero
toNat n = Succ (toNat (n-1))
```

## 14.3 Infinite Nat

```haskell
infty :: Nat
infty = Succ infty
```

## 14.4 Lazy length

```haskell
lengthN :: [a] -> Nat
lengthN []     = Zero
lengthN (_:xs) = Succ (lengthN xs)
```

## 14.5 biggerThan

比较时只需要展开必要的 `Succ` 层数。

```haskell
biggerThan :: Nat -> Nat -> Bool
Zero     `biggerThan` _        = False
(Succ _) `biggerThan` Zero     = True
(Succ x) `biggerThan` (Succ y) = x `biggerThan` y

checkLengthBiggerThanN :: [a] -> Int -> Bool
checkLengthBiggerThanN xs n = lengthN xs `biggerThan` toNat n
```

---

# 15. Memoization

## 15.1 Inefficient fib

```haskell
fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n-2) + fib (n-1)
```

## 15.2 fix / fixed point

`fix f` 返回 `f` 的 fixed point。

```haskell
fix :: (a -> a) -> a
fix f = x
  where
    x = f x
```

## 15.3 fibstep

把 recursion step 抽出来。

```haskell
fibstep :: (Integer -> Integer) -> (Integer -> Integer)
fibstep g = h
  where
    h 0 = 1
    h 1 = 1
    h n = g (n-2) + g (n-1)

fibFix :: Integer -> Integer
fibFix = fix fibstep
```

## 15.4 memoList

用 lazy infinite list 做 memo table。

```haskell
store :: (Integer -> a) -> [a]
store f = [f i | i <- [0..]]

fetch :: [a] -> Integer -> a
fetch (x:_)  0 = x
fetch (_:xs) n = fetch xs (n-1)
fetch []     _ = undefined

memoList :: (Integer -> a) -> (Integer -> a)
memoList = fetch . store
```

## 15.5 fixml

Memoizing fixed-point combinator。

```haskell
fixml :: ((Integer -> a) -> (Integer -> a)) -> Integer -> a
fixml f = g
  where
    g = f (memoList g)

fibml :: Integer -> Integer
fibml = fixml fibstep
```

---

# 16. Monads

## 16.1 IO monad

`IO a` 表示带 input/output effect 的 computation，最终产生 `a`。

```haskell
facIO :: Int -> IO Int
facIO n
  | n == 0    = pure 1
  | otherwise = do
      putStrLn ("n = " ++ show n)
      y <- facIO (n-1)
      pure (y * n)
```

## 16.2 Monad-style fib

```haskell
fibm :: Monad m => Integer -> m Integer
fibm 0 = pure 0
fibm 1 = pure 1
fibm n = do
  x <- fibm (n-2)
  y <- fibm (n-1)
  pure (x+y)
```

## 16.3 Maybe monad

`Maybe` 用于失败处理。

```haskell
fibMaybe :: Integer -> Maybe Integer
fibMaybe n
  | n < 0     = Nothing
  | n == 0    = pure 0
  | n == 1    = pure 1
  | otherwise = do
      x <- fibMaybe (n-2)
      y <- fibMaybe (n-1)
      pure (x+y)
```

## 16.4 List monad

List monad 表示 multiple results / nondeterminism。

```haskell
pairsM :: [a] -> [b] -> [(a,b)]
pairsM xs ys = do
  x <- xs
  y <- ys
  pure (x,y)
```

## 16.5 Writer monad

Writer 用于在 computation 中附带 log。

```haskell
import Control.Monad.Writer

facW :: Int -> Writer [String] Int
facW 0 = do
  tell ["fac 0 = 1"]
  pure 1
facW n = do
  tell ["fac " ++ show n]
  y <- facW (n-1)
  pure (n*y)
```

## 16.6 State monad

State 用于带状态的 computation。

```haskell
import Control.Monad.State

tick :: State Int Int
tick = do
  n <- get
  put (n+1)
  pure n
```

---

# 17. Parser Combinators

## 17.1 Parser type

Parser：输入 `String`，返回 parse result 和剩余 string。

```haskell
newtype Parser a = P (String -> [(a, String)])
```

## 17.2 parse / item

```haskell
parse :: Parser a -> String -> [(a, String)]
parse (P p) inp = p inp

item :: Parser Char
item = P (\inp -> case inp of
                    []     -> []
                    (x:xs) -> [(x,xs)])
```

## 17.3 Functor instance

```haskell
instance Functor Parser where
  fmap g p = P (\inp -> case parse p inp of
                          []        -> []
                          [(v,out)] -> [(g v,out)])
```

## 17.4 Applicative instance

```haskell
instance Applicative Parser where
  pure v = P (\inp -> [(v,inp)])

  pg <*> px = P (\inp -> case parse pg inp of
                           []        -> []
                           [(g,out)] -> parse (fmap g px) out)
```

```haskell
three :: Parser (Char, Char)
three = pure g <*> item <*> item <*> item
  where
    g x y z = (x,z)
```

## 17.5 Monad instance

```haskell
instance Monad Parser where
  p >>= f = P (\inp -> case parse p inp of
                         []        -> []
                         [(v,out)] -> parse (f v) out)
```

Example：

```haskell
threeM :: Parser (Char, Char)
threeM = do
  x <- item
  item
  z <- item
  pure (x,z)
```

## 17.6 Alternative instance

```haskell
import Control.Applicative

instance Alternative Parser where
  empty = P (\_ -> [])

  p <|> q = P (\inp -> case parse p inp of
                         []        -> parse q inp
                         [(v,out)] -> [(v,out)])
```

## 17.7 Basic parsers

```haskell
sat :: (Char -> Bool) -> Parser Char
sat p = do
  x <- item
  if p x then pure x else empty

digit :: Parser Char
digit = sat isDigit

lower :: Parser Char
lower = sat isLower

upper :: Parser Char
upper = sat isUpper

letter :: Parser Char
letter = sat isAlpha

alphanum :: Parser Char
alphanum = sat isAlphaNum

char :: Char -> Parser Char
char x = sat (== x)

string :: String -> Parser String
string []     = pure []
string (x:xs) = do
  char x
  string xs
  pure (x:xs)
```

Repetition：

```haskell
many' :: Parser a -> Parser [a]
many' p = some' p <|> pure []

some' :: Parser a -> Parser [a]
some' p = do
  x <- p
  xs <- many' p
  pure (x:xs)
```

Numbers：

```haskell
nat :: Parser Int
nat = do
  xs <- some digit
  pure (read xs)

space :: Parser ()
space = do
  many (sat isSpace)
  pure ()

token :: Parser a -> Parser a
token p = do
  space
  v <- p
  space
  pure v

natural :: Parser Int
natural = token nat

symbol :: String -> Parser String
symbol xs = token (string xs)
```

## 17.8 Expression parser skeleton

经典表达式 parser：处理 precedence，例如 `*` 高于 `+`。

```haskell
expr :: Parser Int
expr = do
  t <- term
  do symbol "+"
     e <- expr
     pure (t + e)
   <|> pure t

term :: Parser Int
term = do
  f <- factor
  do symbol "*"
     t <- term
     pure (f * t)
   <|> pure f

factor :: Parser Int
factor = do
  symbol "("
  e <- expr
  symbol ")"
  pure e
  <|> natural
```

---

# 18. 常用考试代码模板

## 18.1 Safe tail 三种写法

```haskell
isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty _  = False

safetailIf :: [a] -> [a]
safetailIf xs = if isEmpty xs then [] else tail xs

safetailGuard :: [a] -> [a]
safetailGuard xs
  | isEmpty xs = []
  | otherwise  = tail xs

safetailPM :: [a] -> [a]
safetailPM []     = []
safetailPM (_:xs) = xs
```

## 18.2 map / filter with foldr and foldl

```haskell
mapFoldr :: (a -> b) -> [a] -> [b]
mapFoldr f = foldr (\x acc -> f x : acc) []

filterFoldr :: (a -> Bool) -> [a] -> [a]
filterFoldr p = foldr (\x acc -> if p x then x:acc else acc) []

mapFoldl :: (a -> b) -> [a] -> [b]
mapFoldl f = foldl (\acc x -> acc ++ [f x]) []

filterFoldl :: (a -> Bool) -> [a] -> [a]
filterFoldl p = foldl (\acc x -> if p x then acc ++ [x] else acc) []
```

## 18.3 concat with recursion / comprehension / foldr

```haskell
concatRec :: [[a]] -> [a]
concatRec []       = []
concatRec (xs:xss) = xs ++ concatRec xss

concatComp :: [[a]] -> [a]
concatComp xss = [x | xs <- xss, x <- xs]

concatFoldr :: [[a]] -> [a]
concatFoldr = foldr (++) []
```

## 18.4 Function composition examples

```haskell
removeFirstLast :: [a] -> [a]
removeFirstLast = init . tail

countEvens :: [Int] -> Int
countEvens = length . filter even

sumSquares :: Num a => [a] -> a
sumSquares = sum . map (^2)
```

## 18.5 Maybe pattern

```haskell
lookupMaybe :: Eq a => a -> [(a,b)] -> Maybe b
lookupMaybe _ [] = Nothing
lookupMaybe k ((x,y):xys)
  | k == x    = Just y
  | otherwise = lookupMaybe k xys
```

## 18.6 Tree route update template

```haskell
data BinTree a = Empty | Node (BinTree a) a (BinTree a)
  deriving (Eq, Show)

data Direction = GoLeft | GoRight
  deriving (Eq, Show, Bounded, Enum)

type Route = [Direction]

updateAt :: Route -> (a -> a) -> BinTree a -> BinTree a
updateAt [] f Empty = Empty
updateAt [] f (Node l x r) = Node l (f x) r
updateAt (_:_) _ Empty = Empty
updateAt (GoLeft:ds) f (Node l x r) = Node (updateAt ds f l) x r
updateAt (GoRight:ds) f (Node l x r) = Node l x (updateAt ds f r)
```

## 18.7 Phone keypad template

```haskell
type Button = Char
type Presses = Int
type Text = String

buttonChars :: Button -> String
buttonChars '2' = "ABC"
buttonChars '3' = "DEF"
buttonChars '4' = "GHI"
buttonChars '5' = "JKL"
buttonChars '6' = "MNO"
buttonChars '7' = "PQRS"
buttonChars '8' = "TUV"
buttonChars '9' = "WXYZ"
buttonChars '0' = " "
buttonChars '#' = ".,"
buttonChars _   = ""

pressToChar :: (Button, Presses) -> Char
pressToChar (b,p) = chars !! ((p-1) `mod` length chars)
  where
    chars = buttonChars b

phoneToString :: [(Button, Presses)] -> Text
phoneToString [] = ""
phoneToString (('*',_):(b,p):xs) = toLower (pressToChar (b,p)) : phoneToString xs
phoneToString (x:xs) = pressToChar x : phoneToString xs
```

## 18.8 Expression tree pretty printing template

```haskell
data Expr = Value Int | Add Expr Expr | Mul Expr Expr
  deriving (Show, Eq)

showExpr :: Expr -> String
showExpr = showWithPrec 0

showWithPrec :: Int -> Expr -> String
showWithPrec _ (Value n) = show n
showWithPrec p (Add e1 e2) = paren (p > 1) (showWithPrec 1 e1 ++ "+" ++ showWithPrec 1 e2)
showWithPrec p (Mul e1 e2) = paren (p > 2) (showWithPrec 2 e1 ++ "*" ++ showWithPrec 2 e2)

paren :: Bool -> String -> String
paren True  s = "(" ++ s ++ ")"
paren False s = s
```

---

# 19. 一句话总复习

- **Type**：限制 expression 能不能合法组合。
- **Polymorphism**：一个 function 可以适用于多种 type。
- **Type class**：规定某类 type 必须支持哪些 operations。
- **Instance**：某个具体 type 对 type class 的实现。
- **Pattern matching**：按 constructor 分情况写 function。
- **Recursion**：base case + recursive case。
- **List comprehension**：用 generator + guard 构造 list。
- **Higher-order function**：function 作为参数或返回值。
- **foldr**：把 list 的 `(:)` 和 `[]` 替换成你给的东西。
- **Binary tree**：`Empty` 或 `Fork root left right`。
- **BST**：左小右大，搜索/插入/删除依赖 ordering。
- **Game tree**：当前局面 + 每个 move 后的子游戏树。
- **Laziness**：只算需要的部分。
- **Memoization**：用 laziness 保存已计算结果。
- **Monad**：把普通 value 放进带 context/effect 的 computation。
- **Parser**：`String -> [(result, rest)]`。


