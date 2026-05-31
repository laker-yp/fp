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
hs版本
```
facHelper :: Integer -> State Integer ()
facHelper n
  | n > 1 = do
      y <- get
      put (y * n)
      facHelper (n - 1)
  | otherwise = return ()

--测试↓
factorial :: Integer -> Integer
factorial n = snd (runState (facHelper n) 1)
```


## Monadic Calculator

```haskell
get :: m s
put :: s -> m ()
modify :: MonadState s m => (s -> s) -> m ()

```


* `MonadError String m=>`意思是这个 m 必须会处理 String 错误
* `MonadState Int m =>`  意思是这个m，它里面有一个 Int 类型的状态 state


### Implementation Tasks

# 第一题，数学运算

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
eval (Val x) = return x

eval (Add e1 e2) = do
  x1 <- eval e1
  x2 <- eval e2
  return (x1 + x2)
  
eval (Sub e1 e2) = do
  x1 <- eval e1
  x2 <- eval e2
  return (x1 - x2)

eval (Mult e1 e2) = do
  x1 <- eval e1
  x2 <- eval e2
  return (x1 * x2)

eval (Div e1 e2) = do
  x1 <- eval e1
  x2 <- eval e2
  if x2 == 0  then throwError "Division by zero" else return (div x1 x2)
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
# 第二题：计算机
* `MonadState Int m =>`  意思是这个m，它里面有一个 Int 类型的状态 state
 * get :: MonadState Int m => m Int  --从当前 state 里面拿出一个 Int，作为结果返回
 * put 10 :: MonadState Int m => m () --把当前 state 改成 10
 * modify (+1) :: MonadState Int m => m () --把当前 state 加 1，结果也是 ()

  
1. Now let's imagine a calculator with an `integer state` which allows the user to `update` this state using
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
run EnterC = return()

run (StoreC n c) = do
  put n
  run c

run (AddC n c)   = do
  x <- get
  put (x+n)
  run c

run (MultC n c)  = do
  x <- get
  put (x*n)
  run c

run (DivC n c)   
  |n == 0    = throwError "Division by zero"
  |otherwise = do
    x <- get
    put (div x n)
    run c

run (SubC n c)   = do
  x <- get
  put (x-n)
  run c
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

# Using Monads to Manipulate Directories 中文版答案

## 题目：使用 Monad 操作目录结构

考虑下面的数据类型 `Dir`，它用来表示一个理想化的目录结构：

```haskell
data Dir = File String String
         | SubDir String [Dir]
         deriving Show
```

示例目录：

```haskell
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

下面有两个任务，用来练习 Haskell `Control.Monad` 包中预定义的 Monad。

---

## 任务 1：Writer Monad

使用 `Writer` Monad 记录遍历目录结构时的日志：

```haskell
logTraverse :: Dir -> Writer [String] ()
logTraverse = undefined
```

要求记录：

- 进入子目录
- 离开子目录
- 经过文件

例如在 GHCi 中：

```haskell
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

---

## 答案：Writer Monad

```haskell
import Control.Monad.Writer

data Dir = File String String
         | SubDir String [Dir]
         deriving Show

logTraverse :: Dir -> Writer [String] ()
logTraverse (File name _) = do
  tell ["Passing file: " ++ name]

logTraverse (SubDir name contents) = do
  tell ["Entering directory: " ++ name]
  mapM_ logTraverse contents
  tell ["Leaving directory: " ++ name]
```

---

## 任务 2：State Monad

现在使用 `State` Monad 实现一个带状态的计算，用来统计遍历目录结构时遇到的文件数量：

```haskell
countFiles :: Dir -> State Int ()
countFiles = undefined
```

例如：

```haskell
λ> execState (countFiles recipes) 0
6
```

---

## 答案：State Monad

```haskell
import Control.Monad.State

countFiles :: Dir -> State Int ()
countFiles (File _ _) = do
  modify (+1)

countFiles (SubDir _ contents) = do
  mapM_ countFiles contents
```

也可以写成 `get` 和 `put` 的版本：

```haskell
countFiles :: Dir -> State Int ()
countFiles (File _ _) = do
  n <- get
  put (n + 1)

countFiles (SubDir _ contents) = do
  mapM_ countFiles contents
```

---

# Functors 中文版答案

## 原文翻译

回忆一下列表中的 `map` 函数：

```haskell
map :: (a -> b) -> [a] -> [b]
```

它的直觉是：

> 把一个函数应用到列表中的每一个元素上。

当我们把这个思想从列表推广到任意类型构造器 `f` 时，就得到了 `Functor` 类型类：

```haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b
```

这里和 `Monad` 类型类一样，变量 `f` 不是一个具体类型，而是一个类型构造器。

例如：

```haskell
instance Functor Maybe where 
  fmap f Nothing  = Nothing
  fmap f (Just x) = Just (f x)
```

这说明 `Maybe` 是一个 Functor，因为我们可以自然地把函数应用到 `Maybe` 携带的数据上。

---

## 任务 3：二叉树的 Functor

考虑下面这个二叉树类型，数据存储在节点中：

```haskell
data Bin a = Lf
           | Nd a (Bin a) (Bin a)
```

为这个类型提供一个 `Functor` 实例。

---

## 答案：Bin 的 Functor

```haskell
data Bin a = Lf
           | Nd a (Bin a) (Bin a)
           deriving Show

instance Functor Bin where
  fmap f Lf = Lf
  fmap f (Nd a left right) =
    Nd (f a) (fmap f left) (fmap f right)
```

---

## 任务 4：FSum 的 Functor

考虑下面这个数据类型，它表示两个类型构造器的“和”：

```haskell
data FSum f g a = FLeft (f a) | FRight (g a)
  deriving Show
```

证明：如果 `f` 和 `g` 都是 Functor，那么 `FSum f g` 也是 Functor。

---

## 答案：FSum 的 Functor

```haskell
data FSum f g a = FLeft (f a) | FRight (g a)
  deriving Show

instance (Functor f, Functor g) => Functor (FSum f g) where
  fmap h (FLeft x)  = FLeft (fmap h x)
  fmap h (FRight y) = FRight (fmap h y)
```
