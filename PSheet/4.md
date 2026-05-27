# Problem Sheet for Week 4

## List Comprehensions

Please read the following handout before proceeding further [List Comprehensions](/files/LectureNotes/Sections/list_comprehensions.md)

1. A triple (x,y,z) of positive integers is called pythagorean if
x^2 + y^2 = z^2 . Using a list comprehension, define a function:

    ```hs
    pyths :: Int -> [(Int,Int,Int)]
    ```

    that maps an integer n to all such triples with components in
    [1..n]. For example:

    ```hs
    > pyths 5
    [(3,4,5),(4,3,5)]
    ```

1. A positive integer is perfect if it equals the sum of all of its
   factors, excluding the number itself. Using a list comprehension,
   define a function

    ```hs
    perfects :: Int -> [Int]
    ```

    that returns the list of all perfect numbers up to a given limit. For example:

    ```hs
    > perfects 500
    [6,28,496]
    ```

	Many variations of this exercise are possible:

    * A number which is less than the sum of its proper divisors is called [abundant](https://en.wikipedia.org/wiki/Abundant_number).
    * A number which is greater than the sum of its proper divisions is called [deficient](https://en.wikipedia.org/wiki/Deficient_number).
    * A number for which the sum of all its divisors (including itself) is greater than
	the sum of the divisors of any smaller number is called [highly abundant](https://en.wikipedia.org/wiki/Highly_abundant_number).

	For each of these variations, write a function which finds all the numbers with the
	stated property below a given number.

1. The scalar product of two lists of integers xs and ys of length n is give by the sum of the products of the corresponding integers:

    ![dot product](./assets/dot-prod.png)

    Using a list comprehension, define a function that returns the scalar product of two lists.

1.  **Harder** Implement [matrix multiplication](https://en.wikipedia.org/wiki/Matrix_multiplication) where matrices are represented by lists of lists of integers.  One possibility, for example, would be to take the dimensions of the matrices as arguments, so that your function would have type:

    ```hs
	  matrix_mul :: Int -> Int -> Int -> [[Int]] -> [[Int]] -> [[Int]]
    ```

## Recursive Functions

1. Without looking at the standard prelude, define the following library functions using recursion:

	* Decide if all logical values in a list are true:

		```hs
		and :: [Bool] -> Bool
		```
	* Concatenate a list of lists:

		```hs
		concat :: [[a]] -> [a]
		```
	* Produce a list with n identical elements:

		```hs
		replicate :: Int -> a -> [a]
		```

	* Select the nth element of a list:

		```hs
		(!!) :: [a] -> Int -> a
		```

	* Decide if a value is an element of a list:

		```hs
		elem :: Eq a => a -> [a] -> Bool
		```

1. Define a recursive function

	```hs
	merge :: Ord a => [a] -> [a] -> [a]
	```
	that merges two sorted lists of values to give a single sorted list.

	For example:

	```hs
	> merge [2,5,6] [1,3,4]
	[1,2,3,4,5,6]
	```


## List comprehensions and higher-order functions

1. Express the comprehension `[f x | x <- xs, p x]` using the functions `map` and `filter`. The function type is given as:
	```hs
	fun :: Num a => (a -> a) -> (a -> Bool) -> [a] -> [a]
	```
	For example:
	```
	> fun (^2) even [1..20]
	[4,16,36,64,100,144,196,256,324,400]

	> fun (^2) odd [1..20]
	[1,9,25,49,81,121,169,225,289,361]
	```
1. Redefine `map f` and `filter p` using `foldr` and `foldl`. For your reference, here are the definitions of `map` and `filter` from lecture notes. HINT. Read about the `foldr` and `foldl` functions in the handout [higher-order functions](/files/LectureNotes/Sections/higher-order_functions.md) and Chapter 7.3 and 7.4 of [Programming in Haskell](https://bham.rl.talis.com/link?url=https%3A%2F%2Fapp.kortext.com%2FShibboleth.sso%2FLogin%3FentityID%3Dhttps%253A%252F%252Fidp.bham.ac.uk%252Fshibboleth%26target%3Dhttps%253A%252F%252Fapp.kortext.com%252Fborrow%252F382335&sig=70da9a4ff905dba3523840088f10e61e90877af4795f3070b3775767fa856348).
	```hs
	map :: (a -> b) -> [a] -> [b]
	map f []     = []
	map f (x:xs) = f x : map f xs

	filter :: (a -> Bool) -> [a] -> [a]
	filter p [] = []
	filter p (x:xs)
	   | p x       = x : filter p xs
	   | otherwise = filter p xs
	```

1. Define a function `altMap :: (a -> b) -> (a -> b) -> [a] -> [b]` that alternatively applies the two argument functions to successive elements in a list.

	For example:
	```hs
	> altMap (+10) (+100) [0,1,2,3,4]
	[10,101,12,103,14]
	```

1. **Harder** Church Numerals

	It is possible to represent the natural numbers (i.e. 0,1,2,...) using higher
	order functions of type

	```hs
	(a -> a) -> (a -> a)
	```

	These are called **Church Numerals**. The encoding works like
	this: the input to a function of the above type is an element `f`
	of type `a -> a`.  Since such a function takes input values of
	type `a` and also produces output values of type `a`, this means
	it can be *iterated*.  So we will represent the numeral `n` by a
	the element of type `(a -> a) -> (a -> a)` which iterates its
	argument n times.

	To see the idea, the first few examples of numerals are written like
    this:

	```hs
	zero :: (a -> a) -> (a -> a)
	zero f x = x

	one :: (a -> a) -> (a -> a)
	one f x = f x

	two :: (a -> a) -> (a -> a)
	two f x = f (f x)

    three :: (a -> a) -> (a -> a)
	three f x = f (f (f x))
	```

	* Write a function to implement *addition* of Church numerals
    * Write a function to implement *multiplication* of Church numerals

## Defining the prelude `concat` function in four different ways

The prelude function `concat` concatenates a list of lists, getting a single list. You will define it in four different ways, and test your implementations for correctness and efficiency.

1. Define it with comprehensions and no recursion. HINT: You will need two generators, one to extract a list xs from the list of lists xss, and another to extract an element x from the list xs, and put this in the result of the comprehension.

	```hs
        concat1 :: [[a]] -> [a]
	```

1. Define the same function using recursion instead. HINT. Find and use the prelude function `++`.

	```hs
        concat2 :: [[a]] -> [a]
	```

1. Define the same function using `foldr` and `foldl`, and without recursion or list comprehensions.

	```hs
        concat3 :: [[a]] -> [a]
        concat4 :: [[a]] -> [a]
	```


## Testing your `concat` functions

1. We can test the above functions as follows:

	```hs
        list = [[2,3,4],[5,6,7],[8,9,10]]
        concat1_test = concat1 list == concat list
        concat2_test = concat2 list == concat list
        concat3_test = concat3 list == concat list
        concat4_test = concat4 list == concat list
	```

   Run the above tests under `ghci`. Write also tests for the empty list. Do your functions work with the empty list?

1. Test for speed

	```hs
        biglist = replicate 1000 [1..1000]
        concat1_test2 = concat1 biglist == concat biglist
        concat2_test2 = concat2 biglist == concat biglist
        concat3_test2 = concat3 biglist == concat biglist
        concat4_test2 = concat4 biglist == concat biglist
	```

   Now run `:set +s` at the `ghci` prompt. This asks `ghci` to print time and memory usage statistics.

1. Better run-time test. Check how time increases when n increases in the following tests.

	```hs
        nlist n = replicate n [1..n]
        concat1_test3 n = concat1 (nlist n) == concat (nlist n)
        concat2_test3 n = concat2 (nlist n) == concat (nlist n)
        concat3_test3 n = concat3 (nlist n) == concat (nlist n)
        concat4_test3 n = concat4 (nlist n) == concat (nlist n)
	```

Which implementation(s) are more efficient? Some of them run in linear time and other(s) in quadratic time. Which ones?

## 99 Haskell Problems

  Continue working on the [99 Haskell Problems](https://wiki.haskell.org/H-99:_Ninety-Nine_Haskell_Problems) for extra practice.  You will find that defining functions by recursion and using higher-order functions are invaluable tools for completing these exercises.

  1. [Lists](https://wiki.haskell.org/99_questions/1_to_10)
  2. [Lists continued](https://wiki.haskell.org/99_questions/11_to_20)
  3. [Lists again](https://wiki.haskell.org/99_questions/21_to_28)
  4. [Arithmetic](https://wiki.haskell.org/99_questions/31_to_41)
  5. [Logic and Codes](https://wiki.haskell.org/99_questions/46_to_50)
