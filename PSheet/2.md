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

## Functions in Haskell

Here are some example functions which you can try to implement to get started using both the concepts from the lecture as well as the library functions you found above.

1. Write a function `orB :: Bool -> Bool -> Bool` that returns `True` if at least one argument is `True`.

1. Write a function `swap :: (a, b) -> (b, a)` that swaps the elements of a pair.

1. Write a function that removes both the first and the last element of a list.

1. Write a function which returns the reverse of a list if its length is greater than 7.  Now modify the function so that the cutoff length is a parameter.

1. Write a function which doubles all the elements of a list `l :: [Int]` and then keeps only those which are greater than 10.

1. Write a function to return the reverse of a string with all its alphabetic elements capitalized. (The function `toUpper :: Char -> Char` in the `Data.Char` library may be useful here.)

## Writing More Functions

1. Write a function to pair each element of a list with its index. For example, `[76,4,17]` should result in `[(0,76),(1,4),(2,17)]`.

1. Using guarded equations, write a function of type `Int -> Int -> Bool` that returns `True` if the first argument is greater than the second and less than twice the second.

1. (Adapted and expanded from the book "Programming in Haskell)
   Define three variants of a function `third :: [a] -> a` that returns the third element in any list that contains at least 3 elements, using

   1. `head` and `tail`

   1. list indexing `!!`

   1. pattern matching

1. (Adapted and expanded from the book "Programming in Haskell)
   Define a function `safetail :: [a] -> [a]` that behaves like tail except that it maps `[]` to `[]` (instead of throwing an error). Using `tail` and `isEmpty :: [a] -> Bool`,
   define `safetail` using

   1. a conditional expression

   1. guarded equations

   1. pattern matching
