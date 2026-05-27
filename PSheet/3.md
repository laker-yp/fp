# Problem Sheet for Week 3


## Type Classes and Instances

1. Run, and understand, the following examples:
    1. `False == 'c'`
    2. `False == True`
    3. `False == not`
    4. `False == not True`
    5. `not == id`
    6. `[not] == [ (id :: Bool -> Bool) ]`

1. Find all the basic instances of the type class `Bounded` that are defined in the GHC Prelude (the libraries that are loaded when starting `ghci`, without importing any additional libraries). Find out what `minBound` and `maxBound` are for each of the instances.

1. What type classes do the type classes `Fractional`, `Floating`, `Integral` extend? What functions do they provide? Which type class would you choose to implement a trigonometric calculus?

1. The simplest example of a tuple type is the empty tuple type, which has only one element, namely the empty tuple:

   `() :: ()`

The type `[()]` of lists of empty tuples can be used to encode the non-negative integers (also called natural numbers). For example, addition becomes concatenation. Your task is to add `[()]` to the `Num` type class. Hint. See how we added the type `Bool` to this class in the handout [even more type classes](../LectureNotes/Sections/even-more-typeclasses.md).

## 99 Haskell Problems

  A number of useful exercises (with solutions) can be found at the site [99 Haskell Problems](https://wiki.haskell.org/H-99:_Ninety-Nine_Haskell_Problems).  You are encouraged to do as many of these as necessary in order to get comfortable writing Haskell functions.

  At this stage, the following exercises should be doable using the ideas you have already learned:

  1. [Lists](https://wiki.haskell.org/99_questions/1_to_10)
  2. [Lists continued](https://wiki.haskell.org/99_questions/11_to_20)
  3. [Lists again](https://wiki.haskell.org/99_questions/21_to_28)
  4. [Arithmetic](https://wiki.haskell.org/99_questions/31_to_41)
  5. [Logic and Codes](https://wiki.haskell.org/99_questions/46_to_50)
