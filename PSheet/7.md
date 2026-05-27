# Problem Sheet for Week 7

## Improving Show for Expression Trees

Recall the type of expressions for the `Num` typeclass from the [lecture notes](https://git.cs.bham.ac.uk/fp/fp-learning-2024/-/blob/main/files/LectureNotes/Sections/Data2.md#expression-trees).

```haskell
data NumExpr a = Value a
            | FromInteger Integer
            | Negate (NumExpr a)
            | Abs (NumExpr a)
            | SigNum (NumExpr a)
            | Add (NumExpr a) (NumExpr a)
            | Mul (NumExpr a) (NumExpr a)
```

We can provide expressions with a helpful `Show` instance as follows:

```haskell
instance Show a => Show(NumExpr a) where
  show (Value x)       = show x
  show (FromInteger n) = "fromInteger(" ++ show n ++ ")"
  show (Negate e)      = "negate(" ++ show e  ++ ")"
  show (Abs e)         = "abs(" ++ show e ++ ")"
  show (SigNum e)      = "signum(" ++ show e ++ ")"
  show (Add e e')      = "(" ++ show e ++ "+" ++ show e' ++ ")"
  show (Mul e e')      = "(" ++ show e ++ "*" ++ show e' ++ ")"
```

This implementation is unnecessarily verbose given the usual rules of
operator precedence.  For example, the following expressions

```haskell
ex1 :: NumExpr Int
ex1 = Abs $ Add (FromInteger 6) (Value 9)

ex2 :: NumExpr Int 
ex2 = Add (Add (Value 4) (Value 5)) (Add (Value 6) (Value 7)) 

ex3 :: NumExpr Int 
ex3 = Mul (Add (Value 4) (Value 5)) (Add (Value 6) (Value 7)) 

ex4 :: NumExpr Int 
ex4 = Add (Mul (Value 4) (Value 5)) (Add (Value 6) (Value 7)) 
```

are displayed as follow:

```haskell
λ> ex1
abs((fromInteger(6)+9))
λ> ex2
((4+5)+(6+7))
λ> ex3
((4+5)*(6+7))
λ> ex4
((4*5)+(6+7))
```

But with a refined implementation, they are displayed as 

```haskell
λ> ex1
abs(fromInteger(6)+9)
λ> ex2
4+5+6+7
λ> ex3
(4+5)*(6+7)
λ> ex4
4*5+6+7
```

**Task** Try to improve this implementation of `Show` to take into
account precedence and to avoid duplicating parentheses for function applications.

## Expressions in an Environment 

Let's consider some more sophisticated expressions.  First, we'll
define a **value** to be either an `Int` or a `Bool`:

```haskell
data Value = BVal Bool
           | IVal Int
           deriving (Show,Eq)
```

Now we'll have expressions which can denote either of these kinds of values:
		   
```haskell
data Expr = Val Value 
          | Var String
          | Plus Expr Expr
          | Times Expr Expr 
          | If Expr Expr Expr 
          | And Expr Expr
          | Or Expr Expr
          | Not Expr 
          | Lt Expr Expr
          deriving (Show,Eq)
```

So for example, in the `If` constructor, the first argument should be
an expression which evaluates to a `Bool` in order that we can select
one of the two branches.

Additionally, we have added **variables** which are provided with a
name in the form of a string.

All together, we can now write things like:

```haskell 
exprEx :: Expr
exprEx = If (Lt (Var "x") (Val $ IVal 7)) (Plus (Var "x") (Val $ IVal 14)) (Val $ IVal 0) 
```

corresponding the informal expression "if x < 7 then (x + 14) else 0".

If we naively start writing an evaluation function, we'll see that we
need something new for variables, since we'll have a case like this:

```
eval :: Expr -> Value 
eval ....
eval (Var nm) = ???? 
eval ....
```

This is because expressions with variables must be evaluated in an
**environment**, that is, an assignment of values to each of the
variables.  So let's define

```haskell
type Env = String -> Maybe Value
           
emptyEnv :: Env
emptyEnv _ = Nothing 

bind :: Env -> String -> Value -> Env 
bind env nm v nm' | nm == nm' = Just v
bind env nm v nm' | otherwise = env nm' 
```

The function `bind` takes an "old" environment and returns the "new"
environment in which the provided variable has been bound to the given
value.  We can lookup variables just by applying the function:

```haskell
lookupEnv :: Env -> String -> Maybe Value
lookupEnv env nm = env nm 
```

Here are some examples

```
λ> lookupEnv emptyEnv "x"
Nothing
λ> lookupEnv (bind emptyEnv "x" (IVal 7)) "x"
Just (IVal 7)
λ> lookupEnv (bind emptyEnv "y" (IVal 7)) "x"
Nothing
λ> lookupEnv (bind (bind emptyEnv "y" (IVal 7)) "z" (IVal 14)) "z"
Just (IVal 14)
```

**Task** Write an evaluator for `Expr` of the following type

```haskell
eval :: Env -> Expr -> Maybe Value 
```

For example:

```
λ> eval emptyEnv exprEx
Nothing
λ> eval (bind emptyEnv "x" (IVal 13)) exprEx
Just (IVal 0)
λ> eval (bind emptyEnv "x" (IVal 3)) exprEx
Just (IVal 17)
λ> eval (bind emptyEnv "x" (IVal 1)) exprEx
Just (IVal 15)
```

Notice that there are a number of ways the evaluation might fail:

  1. A variable name could be missing from the environment
  1. There could be a typing error.  For example, in an `If`
     expression, evaluating the conditional returns an `Int`
     instead of a `Bool`
	 
**Extra Task** Now modify the type of the evaluator to return an error message
describing why the evaluation failed.

## Cycle Decomposition 

Let's define a **permutation** to be a permutation, in the sense of
the [lecture](../LectureNotes/Sections/Data2.md#ptrees), of the list `[0..n]` for some `n`. This means that it 
is an element of `[Int]` which has the property that **every** number 
from `0` to `n` occurs.  We can easily check this condition as follow:

```haskell
type Perm = [Int] 

isPerm :: [Int] -> Bool
isPerm ns = and [ elem k ns | k <- [0..length ns -1] ]
```

For example, consider the following:

```haskell
p :: Perm
p = [5,2,4,0,1,3]

q :: Perm
q = [7,3,2,0,8,9,1,4,6,5]

r :: [Int]
r = [0,3,2] 
```

Then we have 

```
λ> isPerm p
True
λ> isPerm q
True
λ> isPerm r
False
```

In `r`, we see that `1` is missing.

Now, if `p` is a permutatation and `k` is an element of `[0..length p-1]`, 
then this `k` generates a **cycle** by repeatedly replacing `k` with the 
value found at the index `k`.  For example, taking `p` as above and `k = 1`
we get the sequence 1 -> 2 -> 4 -> 1.  Every such cycle will eventually return 
where it started simply because the list is finite.

**Task**  Define a function `cycleOf` which finds the cycle of a given index in a permutation:

```haskell
cycleOf :: Int -> Perm -> [Int]
```

For example:
```
λ> cycleOf 1 p
[4,2,1]
λ> cycleOf 2 q
[2]
λ> cycleOf 3 q
[1,6,8,4,7,0,3]
```

**Note** This implementation is return the cycles in reverse order from the
notation above, but that's okay.

**Task** Now write a function which finds *all* the cycles of a permutation.  This is 
called its **cycle decomposition**.

```haskell
cycles :: Perm -> [[Int]]
```

Here are the results for `p` and `q`:

```
λ> cycles p
[[4,2,1],[3,5,0]]
λ> cycles q
[[9,5],[2],[3,1,6,8,4,7,0]]
```

