# Problem Sheet for Week 2

## Ill-typed Expressions

1. Write five ill-typed expressions in Haskell.

2. Check their types in `ghci` - what does `ghci` say?

3. What happens when you try to evaluate that expression?

## Types

Translate the following English language descriptions into Haskell type expressions

1. The type of pairs consisting of a list of integers and string
1. The type of lists of functions from an arbitrary type to the booleans
1. The type of functions from pairs of strings to lists of booleans
1. The type of functions taking a predicate on integers to an integer
   (Recall that a **predicate** on a type `a` is a function from `a` to the booleans).
1. The type of functions taking a function from an arbitrary type to
itself and returning a function from that same type to itself.

## Polymorphism

1. (Requires Section [Polymorphism](../LectureNotes/Sections/polymorphism.md))
   Find out the types of the following functions. Decide if they are polymorphic.

   1. `fst`
   2. `(++)`
   3. `not`
   4. `head`
   5. `tail`
   6. `id`

2. Explain, in your own words, what the function `zip` does. In the expression `zip ['x', 'y'] [False]`, what are the type variables `a` and `b` of `zip :: [a] -> [b] -> [(a, b)]` instantiated by?

3. Find a polymorphic function in the GHC [standard library](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html) whose type contains 3 type variables or more.

4. Read Section 3.7 of [Programming in Haskell](https://rl.talis.com/3/bham/lists/B8EC8CB3-9A35-6677-9416-A2FB63C60D88.html). Compare the types of the examples given there with the types `ghci` indicates. (Note: some of the types that `ghci` shows use "type classes" - you will learn about these in the next lesson.)

## Standard Library Functions and Hoogle

Look up the following functions for manipulating lists on
[Hoogle](https://hoogle.haskell.org/) and write down their types.  For
each function, read the description and try the function on a sample list.

1. length
1. reverse
1. tail
1. head
1. take
1. drop
1. takeWhile *
1. dropWhile *
1. filter *
1. all *
1. any *
1. map **

The functions marked (*) additionally take a **predicate** `p :: a -> Bool`.  You can think of such a function `p` as a "yes or no question" about elements of the type `a`.  Examples are the following:
```
odd :: Int -> Bool
even :: Int -> Bool
isUpper :: Char -> Bool
isLower :: Char -> Bool
```
Try combining some of the starred functions with these predicates to get an idea for what each function does.

**Note**.  You will need to first type `import Data.Char` in `ghci` or add this line to the top of your source file in order to have access to the last two.

The `map` function (marked **) additionally takes an arbitrary function `f :: a -> b`.  This function is extremely useful for modifying the contents of a list.

# Functions in Haskell 简短中文题目 + 答案

## 1. 写一个 `orB`，只要有一个参数是 `True` 就返回 `True`

```haskell
orB :: Bool -> Bool -> Bool
orB x y = x || y
```

## 2. 写一个 `swap`，交换 pair 里的两个元素

```haskell
swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)
```

## 3. 写一个函数，删除 list 的第一个和最后一个元素

```haskell
removeFirstLast :: [a] -> [a]
removeFirstLast xs = init (tail xs)
```

## 4. 如果 list 长度大于 7，就反转它

```haskell
reverseIfLong :: [a] -> [a]
reverseIfLong xs
  | length xs > 7 = reverse xs
  | otherwise     = xs
```

## 5. 修改上题，让 cutoff length 变成参数

```haskell
reverseIfLongerThan :: Int -> [a] -> [a]
reverseIfLongerThan n xs
  | length xs > n = reverse xs
  | otherwise     = xs
```

## 6. 把 `[Int]` 里所有元素翻倍，然后只保留大于 10 的元素

```haskell
doubleAndFilter :: [Int] -> [Int]
doubleAndFilter xs = filter (>10) (map (*2) xs)
```

## 7. 返回一个字符串的反转，并把所有字母变成大写

```haskell
import Data.Char

reverseUpper :: String -> String
reverseUpper xs = reverse (map toUpper xs)
```

# Writing More Functions 简短中文题目 + 答案

## 8. 把 list 中每个元素和它的 index 配对

```haskell
pairWithIndex :: [a] -> [(Int, a)]
pairWithIndex xs = zip [0..] xs
```

## 9. 用 guard 写函数：如果第一个数大于第二个数，并且小于第二个数的两倍，就返回 `True`

```haskell
between :: Int -> Int -> Bool
between x y
  | x > y && x < 2 * y = True
  | otherwise          = False
```

## 10. 写三个版本的 `third`，返回 list 的第三个元素

### 10.1 用 `head` 和 `tail`

```haskell
third1 :: [a] -> a
third1 xs = head (tail (tail xs))
```

### 10.2 用 `!!`

```haskell
third2 :: [a] -> a
third2 xs = xs !! 2
```

### 10.3 用 pattern matching

```haskell
third3 :: [a] -> a
third3 (_:_:x:_) = x
```

## 11. 写 `safetail`，像 `tail` 一样，但 `[]` 返回 `[]`

### 11.1 先定义 `isEmpty`

```haskell
isEmpty :: [a] -> Bool
isEmpty xs = length xs == 0
```

### 11.2 用 conditional expression

```haskell
safetail1 :: [a] -> [a]
safetail1 xs = if isEmpty xs then [] else tail xs
```

### 11.3 用 guarded equations

```haskell
safetail2 :: [a] -> [a]
safetail2 xs
  | isEmpty xs = []
  | otherwise  = tail xs
```

### 11.4 用 pattern matching

```haskell
safetail3 :: [a] -> [a]
safetail3 []     = []
safetail3 (_:xs) = xs
```

   1. a conditional expression

   1. guarded equations

   1. pattern matching
