# Mock Test

## Marking table

The exercises are defined so that it is hard to get a first-class mark.

| Mark         | Cut-off            |
| ------------ | ------------------ |
| 1st          | 35 marks and above |
| upper second | 30-34 marks        |
| lower second | 25-29 marks        |
| third        | 20-24 marks        |
| fail         | 0-19 marks         |

All questions have equal weight, with ten marks each, with a total of 50 marks.

## Preparation

* The test must be completed **on vLab** in the directory `fp-learning-2025/files/Tests/MockTest`
* Run `git pull` on vLab to make sure you have the latest version of the course repository which will include the directory above.
* Do __not__ modify either the file `Types.hs` or the file `MockTest-Template.hs`.
* Copy the file `MockTest-Template.hs` to a new file called `MockTest.hs` and write your solutions in `MockTest.hs`.

  __Don't change the header of this file, including the module declaration, and, moreover, don't change the type signature of any of the given functions for you to complete.__
  
  __If you do make changes, then we will not be able to mark your submission and hence it will receive zero marks!__
  
* Solve the exercises below in the file `MockTest.hs` by replacing the default function implementation of `undefined` with your own function.

## Submission procedure

* Before submitting your work, **you must run the command** `./presubmit.sh MockTest` **on vLab** in the terminal (in the same folder as your submission)
* This will check that your submission is in the correct format for marking.
* We cannot mark code which does not pass `presubmit.sh` so this step is of **fundamental importance**.
* If your file passes the presubmit script, you may submit it on Canvas.
* Please check that Canvas shows a submission for the `MockTest` assignment.  If it does not, please try again.
* You may submit as often as you like and we will mark your last submission. Do not worry if Canvas renames the file.
* If your submission doesn't compile or fails to pass the presubmit script on vLab, it will get zero marks.
* If your code does not pass the presubmit script, fix it and repeat the presubmission procedure.
* The official submission deadline is 11am (for the 9am session) and 2pm (for the 12pm session).
* Late submissions will not be accepted.

## Additional Information

* The file `Types.hs` has various definitions and functions which you are welcome to use when completing the questions.  
* This file is already in scope when you load `MockTest.hs` in the folder `fp-learning-2025/files/Tests/MockTest`.
* This is an open book test.
* You may consult your own notes, the course materials, the official book or [Hoogle](https://hoogle.haskell.org/).
* You may **not** consult other sources such as StackOverflow, Google and ChatGPT.  You may **not** collaborate with other students.
* Feel free to write helper functions whenever convenient.
* All the exercises may be solved without importing additional modules. Do **not** import any modules, as it will interfere with the marking.

## Plagiarism

Plagiarism will not be tolerated. Copying and contract cheating have led to full loss of marks, and even module or degree failure, in the past.

By submitting, you acknowledge that you understand the plagiarism rules and are abiding by them.

## Question 1 (10 marks)

Consider the following type of Rose trees with explicit leaves.

```haskell
data Rose a = Leaf a
            | Branch [ Rose a ]
```

**Task**: Write a predicate `isNBranching :: Int -> Rose a -> Bool` which decides
if every branch of the provided tree has exactly `n` children.
  
```haskell
isNBranching :: Int -> Rose a -> Bool
isNBranching n t = undefined
```

**Task**: Write a function `prune :: Int -> Rose a -> Rose a` which
ensures that every branch has at most `n` children by keeping the
first `n` branches and removing any excess branches from the end of the list.

```hs
prune :: Int -> Rose a -> Rose a
prune n t = undefined
```

## Question 2 (10 marks)

**Task**: Implement the following function which given `mx :: m a`, a
function `mf :: a -> m b` and a non-negative integer `n`, will iterate
applying `mf` to `mx` exactly `n` times and returns the list
containing the results of all iterations (including both `mx` and the
final output so that there are `n+1` values in total).
  
```haskell
applyNTimes :: Monad m => m a -> (a -> m a) -> Int -> m [a]
applyNTimes mx mf n = undefined
```
  
As you can see from the following example using `addAndPrint`, we execute all
of the intermediate monadic actions exactly once and end by returning all
intermediate values.
  
```hs
addAndPrint :: Int -> IO Int
addAndPrint n = do putStrLn $ "Intermediate value: " ++ show n
                   return $ n + 2 
```
When we run `applyNTimes` with `addAndPrint` we get

```
ghci> applyNTimes (return 0) addAndPrint 4
Intermediate value: 0
Intermediate value: 2
Intermediate value: 4
Intermediate value: 6
[0,2,4,6,8]
```
Notice the final value of this function is the list, and that the number `8` is not printed since it is returned after the print statement takes place.

## Question 3 (10 marks)

The game of [Nim](https://en.wikipedia.org/wiki/Nim) consists of a
collection of "heaps" containing an arbitrary number of tokens.  When
it is their turn, a player chooses a heap and take as many of the
tokens as they like.  The game is over when there are no tokens left 
to take and the player whose turn it is at this point is the loser.

We will play the game inside a state monad where the current state of 
the game is given by the number of tokens in each heap.  For concreteness 
we will play with two heaps.
```hs 
type NimBoard = (Int,Int)
type NimGame a = State NimBoard a 

data Heap = First | Second
```

**Task**: Write a function `gameOver :: NimGame Bool` which decides if the game is over.
```hs
gameOver :: NimGame Bool
gameOver = undefined
```

**Task**: Write a function `takeTokens :: Int -> Heap -> NimGame ()` which changes the game state appropriately when provided with a number of tokens to take and which heap to take them from.  If a player tries to take more tokens then are currently in a given heap, leave that heap empty.

```hs
takeTokens :: Int -> Heap -> NimGame ()
takeTokens i h = undefined
```

For example, given the game sequence
```hs
example :: NimGame Bool
example = do takeTokens 5 First
             takeTokens 3 Second
             takeTokens 1 Second
             gameOver
```

we have

```
λ> runState example (5,4)
(True,(0,0))
λ> runState example (6,10)
(False,(1,6))
λ> runState example (1,1)
(True,(0,0))
```

## Question 4 (10 marks)

A magic square is an n by n grid of integers where every row, column and main diagonal add up the _same_ number. For example, the following is a magic square 
with n = 3, such that every row, column and diagonal adds up to 15.

|  |  |  |
| -- | -- | -- |
| 8 | 1 | 6 |
| 3 | 5 | 7 |
| 4 | 9 | 2 |

The two "main diagonals" in the above square are `8,5,2` and `4,5,6`.

**Task**: Write a function

```haskell
isMagicSquare :: [[Int]] -> Bool
isMagicSquare = undefined
```

which takes a list of a list of integers (representing a square), and returns

1. `True` if the input represents a magic square
    * i.e every column, square and main diagonal add up to the same number,
1. `False` if the input is _not_ a representation of a magic square

You may assume that the function will receive inputs of size (n * n)
for some positive integer n. We will not test the function on empty magic
squares (i.e the empty list).

### Examples

```hs
ghci> isMagicSquare [[8,1,6],[3,5,7],[4,9,2]]
True
ghci> isMagicSquare [[1,2,3],[4,5,6],[7,8,9]]
False
```

## Question 5 (10 marks)

We can represent logical expressions with the following datatype:

```haskell
data Expr = Var     Char
          | Not     Expr
          | And     Expr Expr
          | Or      Expr Expr
          | Implies Expr Expr
          deriving (Eq, Show)
```

Some examples:
  - The singleton formula `p` would be represented as `Var 'p'`.
  - The formula `p && q` would be represented as `And (Var 'p') (Var 'q')`.
  - The expression `p && (q || (r ==> q))` would be expressed as
    `And (Var 'p') (Or (Var 'q') (Implies (Var 'r') (Var 'q')))`.

The implementation of logical expressions using digital circuits is
usually done using _only one_ type of logical operation, the so-called
Nand operation, due to ease of manufacturing and power consumption
(among other reasons).  In other words, circuit manufacturers use the
following alternate representation of logical expressions, which we will call *circuits*.

```haskell
data Circuit = Input Char
             | Nand  Circuit Circuit
             deriving (Eq, Show)
```

We use the symbol `_⊼_` to denote the `Nand` operation, which is the Boolean
function given by the following table:

| `p` | `q` | `p ⊼ q`    |
|-----|-----|------------|
| 0   | 0   |    1       |
| 0   | 1   |    1       |
| 1   | 0   |    1       |
| 1   | 1   |    0       |

Your task in this question is to write a function transforming an expression
into a circuit given the following elementary facts about Boolean logic.

  1. The expression `¬ p` is equivalent to `p ⊼ p`.
  1. The expression `p ∧ q` is equivalent to `¬ (p ⊼ q)`.
  1. The expression `p ∨ q` is equivalent to `¬ ((¬ p) ∧ (¬ q))`.
  1. The expression `p ⇒ q` is equivalent to `(¬ p) ∨ q`.

No other logical facts are needed to complete this question.

**Task** Implement the following function `circuit` that transforms a logical
expression into an equivalent circuit.

```haskell
circuit :: Expr -> Circuit
circuit exp = undefined
```

For example:
```hs
> circuit (Not (Var 'p'))
Nand (Input 'p') (Input 'p')
> circuit (And (Var 'p') (Var 'q'))
Nand (Nand (Input 'p') (Input 'q')) (Nand (Input 'p') (Input 'q'))
> circuit (Or (Not (Var 'p')) (Var 'q'))
Nand (Nand (Nand (Nand (Nand (Input 'p') (Input 'p')) (Nand (Input 'p') (Input 'p'))) (Nand (Input 'q') (Input 'q'))) (Nand (Nand (Nand (Input 'p') (Input 'p')) (Nand (Input 'p') (Input 'p'))) (Nand (Input 'q') (Input 'q')))) (Nand (Nand (Nand (Nand (Input 'p') (Input 'p')) (Nand (Input 'p') (Input 'p'))) (Nand (Input 'q') (Input 'q'))) (Nand (Nand (Nand (Input 'p') (Input 'p')) (Nand (Input 'p') (Input 'p'))) (Nand (Input 'q') (Input 'q'))))
```
