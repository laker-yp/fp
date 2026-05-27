# Problem Sheet for Week 9

## Computing Factorial with the State Monad

Consider the following Java method:
```java
int fac (int n) {
  int y = 1;
  while (n > 1} {
   y = y * n;
   n--;
   }
  }
  return y;
```
Write this as a Haskell function using the state monad:
```
facHelper :: Integer -> State Integer ()
facHelper = undefined

factorial :: Integer -> Integer
factorial n = snd (runState (facHelper n) 1)
```
Hint: See how we define `fib'` using the state monad in the [monads handout](../LectureNotes/Sections/monads.md#fibstate).

## Monadic Calculator

### Background Material

The modules `Control.Monad.Except` and `Control.Monad.State` contain
definitions of various extensions of the `Monad` class.  We can use these
to write functions which work for **any** monad `m` satisfying the correct
interface.

For example, the `MonadError` class, defined [here](https://hackage.haskell.org/package/mtl-2.3.1/docs/Control-Monad-Error-Class.html#t:MonadError),
adds a method
```haskell
throwError :: e -> m a
```
allowing you to return an error of type `e`.

Similarly, the `MonadState` class, defined [here](https://hackage.haskell.org/package/mtl-2.3.1/docs/Control-Monad-State-Class.html#t:MonadState) adds
methods
```haskell
get :: m s
put :: s -> m ()
modify :: MonadState s m => (s -> s) -> m ()
```
which allow you to manipulate the state carried by the monad `m`.

### Implementation Tasks

1. Consider the following type of calculator expressions:

	```haskell
	data CalcExpr = Val Int
                  | Add CalcExpr CalcExpr
                  | Mult CalcExpr CalcExpr
                  | Div CalcExpr CalcExpr
                  | Sub CalcExpr CalcExpr
	```
	Write an evaluator which runs in any monad supporting exceptions and which throws an error when it
	encounters a division by zero.

    ```haskell
	eval :: MonadError String m => CalcExpr -> m Int
	```
	Notice how we have specialized the error type `e` from `MonadError` to `String` here.  This means that
	when you encounter a divide by zero, you should return an error message as a string.

Examples

```hs
> eval (Add (Val 5) (Mult (Val 3) (Val 2))) :: Either String Int
Right 11

> eval (Div (Val 5) (Val 0)) :: Either String Int
Left "Division by zero"
```

1. Now let's imagine a calculator with an integer state which allows the user to update this state using
   commands. Here is a data type describing a list of commands:
    ```haskell
    data CalcCmd = EnterC
                 | StoreC Int CalcCmd
                 | AddC Int CalcCmd
                 | MultC Int CalcCmd
                 | DivC Int CalcCmd
                 | SubC Int CalcCmd
	```
	Write a function
	```hs
	run :: (MonadState Int m, MonadError String m) => CalcCmd -> m ()
	```
	which runs the given sequence of commands in any monad supporting state and exceptions.
    Each of the `AddC`, `MultC`, `DivC` and `SubC` commands should apply
    the corresponding operation on the provided argument and whatever
    the current state is.  The `StoreC` command manually updates the
    state. Finally, `EnterC` terminates the calculation, returning the
    unit type.

### Examples

1. Here are two calculator expressions:

	```haskell
	expr1 = Mult (Add (Val 4) (Val 7)) (Div (Val 10) (Val 2))
	expr2 = Sub (Val 10) (Div (Val 14) (Val 0))
	```

	The `Either` type implements the required monadic interface.  Hence we can evaluate using
	this type as follows:
	```
	ghci> eval expr1 :: Either String Int
	Right 55
	ghci> eval expr2 :: Either String Int
	Left "Divide by zero!"
	ghci>
	```

2. Now here are two command sequences:

    ```haskell
	cmd1 = StoreC 7 (AddC 14 (DivC 3 EnterC))
	cmd2 = StoreC 10 (MultC 2 (DivC 0 EnterC))
	```
	To run these, we will need to choose an implementation of the state monad to use.  We can do this
	by introducting the following type synonym:
	```haskell
	type CS a = StateT Int (Either String) a
	```
	Now we can do:
	```
	ghci> runStateT (run cmd1 :: CS ()) (0 :: Int)
	Right ((),7)
	ghci> runStateT (run cmd2 :: CS ()) (0 :: Int)
	Left "Divide by zero!"
	```
	The value `7` in `Right ((),7)` is showing us the resulting state of the calculator after the
	sequence of commands.  This makes sense: we first store `7`, then add `14` to the stored value
	and then divide by `3`, leaving a result of `7`.

## Using Monads to Manipulate Directories

Cnsider the following datatype `Dir` to represent an idealized directory structure:

```hs
data Dir = File String String
         | SubDir String [Dir]
         deriving Show

recipes :: Dir
recipes = SubDir "Recipes" [ SubDir "Tex-Mex" [ File "Tacos" "meat, cheese, tomato"
                                              , File "Burrito" "tortilla, rice, beans"
                                              ]
                           , SubDir "Italian" [ File "Pizza" "dough, sauce, pepperoni"
                                              , File "Bolognese" "pasta, ground beef, tomato sauce"
                                              ]
                           , SubDir "French"  [ File "Ratatouille" "tomato, bell peppers, eggplant"
                                              , File "Croque Monsieur" "toast, cheese, ham"
                                              ]
                           ]
```

Here are two more tasks to practice using the pre-defined Monads fount in Haskell's `Control.Monad` packaged:

1.  Use the `Writer` monad (documentation [here](https://hackage.haskell.org/package/mtl-2.3.1/docs/Control-Monad-Writer-Lazy.html)) to record a log of entering and exiting subdirectories and passing files while traversing a directory strucure:

```hs
logTraverse :: Dir -> Writer [String] ()
logTraverse = undefined
```
For example, in `ghci` we have the following:

```
λ> putStr $ unlines $ execWriter $ logTraverse recipes
Entering directory: Recipes
Entering directory: French
Passing file: Croque Monsieur
Passing file: Ratatouille
Leaving directory: French
Entering directory: Italian
Passing file: Bolognese
Passing file: Pizza
Leaving directory: Italian
Entering directory: Tex-Mex
Passing file: Burrito
Passing file: Tacos
Leaving directory: Tex-Mex
Leaving directory: Recipes
```

1. Now use the `State` monad (documentation [here](https://hackage.haskell.org/package/mtl-2.3.1/docs/Control-Monad-State-Lazy.html)) to implement a stateful computation which counts the number of files encountered on a traversal through the directory structure:

```hs
countFiles :: Dir -> State Int ()
countFiles = undefined
```
For example:

```
λ> execState (countFiles recipes) 0
6
```

## Functors 

Recall the `map` function on lists which has type

```hs
map :: (a -> b) -> [a] -> [b]
```

The intuition for this higher-order function is that it "applies the function to each element of the list".  When we generalize this idea from lists to arbirary type constructors `f`, we obtain the `Functor` type class:

```hs
class Functor f where
  fmap :: (a -> b) -> f a -> f b
```

Here, as in the `Monad` type class, the variable `f` is not a type, but a *type constructor*.  For example, we have 

```hs
instance Functor Maybe where 
  fmap f Nothing = Nothing
  fmap f (Just x) = Just (f x) 
```

We again see the same intution: `Maybe` is a functor because there is a natural way to apply a function to the data carried by the type constructor.

1. Consider the following type of binary trees with data carried at the nodes:

	```hs
	data Bin a = Lf
	           | Nd a (Bin a) (Bin a)
	```

	Provide a `Functor` instance for this data type.

1. Consider the following data type which takes the "sum" of two type constructors:

    ```hs
	data FSum f g a = FLeft (f a) | FRight (g a)
	  deriving Show
	```

    Show that if both `f` and `g` are functors, then so is `FSum f g`. 
