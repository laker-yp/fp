# Expression Tree Practice Questions with Answers

## 目录

- [Question 1 - 重要Basic Arithmetic Eval](#question-1---basic-arithmetic-eval)
- [Question 2 - Count Values](#question-2---count-values)
- [Question 3 - Height of Expression Tree](#question-3---height-of-expression-tree)
- [Question 4 - Count Operators](#question-4---count-operators)
- [Question 5 - Show Expression with Full Parentheses](#question-5---show-expression-with-full-parentheses)
- [Question 6 - Pretty Print with Fewer Parentheses](#question-6---pretty-print-with-fewer-parentheses)
- [Question 7 - Evaluate with Division Using Maybe](#question-7---evaluate-with-division-using-maybe)
- [Question 8 - Boolean and Integer Expression Eval](#question-8---boolean-and-integer-expression-eval)
- [Question 9 - 重要Safe Boolean and Integer Eval Using Maybe](#question-9---safe-boolean-and-integer-eval-using-maybe)
- [Question 10 - If Expression](#question-10---if-expression)
- [Question 11 - 重要Variables with Environment](#question-11---variables-with-environment)
- [Question 12 - Multiple Variable Bindings](#question-12---multiple-variable-bindings)
- [Question 13 - Substitute a Variable](#question-13---substitute-a-variable)
- [Question 14 - Free Variables](#question-14---free-variables)
- [Question 15 - Increment All Integer Values](#question-15---increment-all-integer-values)
- [Question 16 - Map over Values](#question-16---map-over-values)
- [Question 17 - Constant Folding](#question-17---constant-folding)
- [Question 18 - Algebraic Simplification](#question-18---algebraic-simplification)
- [Question 19 - Fold for Expression Trees](#question-19---fold-for-expression-trees)
- [Question 20 - Rebuild Eval Using Fold](#question-20---rebuild-eval-using-fold)
- [Question 21 - Logical Expression Evaluation](#question-21---logical-expression-evaluation)
- [Question 22 - Logical Expression Variables](#question-22---logical-expression-variables)
- [Question 23 - 重要Convert Logical Expr to Nand Circuit](#question-23---convert-logical-expr-to-nand-circuit)
- [Question 24 - 重要Evaluate Nand Circuit](#question-24---evaluate-nand-circuit)
- [Question 25 - Check Expr and Circuit Equivalence](#question-25---check-expr-and-circuit-equivalence)
- [Question 26 - De Morgan Transformation](#question-26---de-morgan-transformation)
- [Question 27 - Remove Implies](#question-27---remove-implies)
- [Question 28 - Negation Normal Form](#question-28---negation-normal-form)
- [Question 29 - Expression Tree as List of Leaves](#question-29---expression-tree-as-list-of-leaves)
- [Question 30 - Parse Very Simple Arithmetic Expressions](#question-30---parse-very-simple-arithmetic-expressions)
- [Question 31 - Read Tree from Fully Parenthesised String](#question-31---read-tree-from-fully-parenthesised-string)
- [Question 32 - Compare Two Expressions by Evaluation](#question-32---compare-two-expressions-by-evaluation)
- [Question 33 - Expression Depth with Variables](#question-33---expression-depth-with-variables)
- [Question 34 - Replace All Add with Mul](#question-34---replace-all-add-with-mul)
- [Question 35 - Exam-Style Mixed Evaluator](#question-35---exam-style-mixed-evaluator)

---

## Question 1 - Basic Arithmetic Eval

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

eval :: Expr -> Int
eval = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

eval :: Expr -> Int
eval (Val n)     = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Mul e1 e2) = eval e1 * eval e2
```

---

## Question 2 - Count Values

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

countVals :: Expr -> Int
countVals = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

countVals :: Expr -> Int
countVals (Val _)     = 1
countVals (Add e1 e2) = countVals e1 + countVals e2
countVals (Mul e1 e2) = countVals e1 + countVals e2
```

---

## Question 3 - Height of Expression Tree

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

height :: Expr -> Int
height = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

height :: Expr -> Int
height (Val _)     = 0
height (Add e1 e2) = 1 + max (height e1) (height e2)
height (Mul e1 e2) = 1 + max (height e1) (height e2)
```

---

## Question 4 - Count Operators

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

countOps :: Expr -> Int
countOps = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

countOps :: Expr -> Int
countOps (Val _)     = 0
countOps (Add e1 e2) = 1 + countOps e1 + countOps e2
countOps (Mul e1 e2) = 1 + countOps e1 + countOps e2
```

---

## Question 5 - Show Expression with Full Parentheses

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

showExpr :: Expr -> String
showExpr = undefined
```

Example:

```haskell
showExpr (Add (Val 3) (Mul (Val 4) (Val 5)))
-- "(3+(4*5))"
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

showExpr :: Expr -> String
showExpr (Val n)     = show n
showExpr (Add e1 e2) = "(" ++ showExpr e1 ++ "+" ++ showExpr e2 ++ ")"
showExpr (Mul e1 e2) = "(" ++ showExpr e1 ++ "*" ++ showExpr e2 ++ ")"
```

---

## Question 6 - Pretty Print with Fewer Parentheses

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

showPretty :: Expr -> String
showPretty = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

showPretty :: Expr -> String
showPretty = showPrecExpr 0

showPrecExpr :: Int -> Expr -> String
showPrecExpr _ (Val n) = show n

showPrecExpr p (Add e1 e2) =
  parensIf (p > 6) $
    showPrecExpr 6 e1 ++ "+" ++ showPrecExpr 6 e2

showPrecExpr p (Mul e1 e2) =
  parensIf (p > 7) $
    showPrecExpr 8 e1 ++ "*" ++ showPrecExpr 8 e2

parensIf :: Bool -> String -> String
parensIf True s  = "(" ++ s ++ ")"
parensIf False s = s
```

---

## Question 7 - Evaluate with Division Using Maybe

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Div Expr Expr
          deriving (Show, Eq)

eval :: Expr -> Maybe Int
eval = undefined
```

Division by zero should return `Nothing`.

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Div Expr Expr
          deriving (Show, Eq)

eval :: Expr -> Maybe Int
eval (Val n) = Just n

eval (Add e1 e2) =
  case (eval e1, eval e2) of
    (Just x, Just y) -> Just (x + y)
    _                -> Nothing

eval (Div e1 e2) =
  case (eval e1, eval e2) of
    (Just _, Just 0) -> Nothing
    (Just x, Just y) -> Just (x `div` y)
    _                -> Nothing
```

---

## Question 8 - Boolean and Integer Expression Eval

### Question

```haskell
data Value = IVal Int
           | BVal Bool
           deriving (Show, Eq)

data Expr = Val Value
          | Add Expr Expr
          | Mul Expr Expr
          | Lt Expr Expr
          | And Expr Expr
          | Not Expr
          deriving (Show, Eq)

eval :: Expr -> Value
eval = undefined
```

### Answer

```haskell
data Value = IVal Int
           | BVal Bool
           deriving (Show, Eq)

data Expr = Val Value
          | Add Expr Expr
          | Mul Expr Expr
          | Lt Expr Expr
          | And Expr Expr
          | Not Expr
          deriving (Show, Eq)

eval :: Expr -> Value
eval (Val v) = v

eval (Add e1 e2) =
  case (eval e1, eval e2) of
    (IVal x, IVal y) -> IVal (x + y)

eval (Mul e1 e2) =
  case (eval e1, eval e2) of
    (IVal x, IVal y) -> IVal (x * y)

eval (Lt e1 e2) =
  case (eval e1, eval e2) of
    (IVal x, IVal y) -> BVal (x < y)

eval (And e1 e2) =
  case (eval e1, eval e2) of
    (BVal x, BVal y) -> BVal (x && y)

eval (Not e) =
  case eval e of
    BVal x -> BVal (not x)
```

---

## Question 9 - Safe Boolean and Integer Eval Using Maybe

### Question

```haskell
data Value = IVal Int
           | BVal Bool
           deriving (Show, Eq)

data Expr = Val Value
          | Add Expr Expr
          | Mul Expr Expr
          | Lt Expr Expr
          | And Expr Expr
          | Not Expr
          deriving (Show, Eq)

eval :: Expr -> Maybe Value
eval = undefined
```

### Answer

```haskell
data Value = IVal Int
           | BVal Bool
           deriving (Show, Eq)

data Expr = Val Value
          | Add Expr Expr
          | Mul Expr Expr
          | Lt Expr Expr
          | And Expr Expr
          | Not Expr
          deriving (Show, Eq)

eval :: Expr -> Maybe Value
eval (Val v) = Just v

eval (Add e1 e2) =
  case (eval e1, eval e2) of
    (Just (IVal x), Just (IVal y)) -> Just (IVal (x + y))
    _                              -> Nothing

eval (Mul e1 e2) =
  case (eval e1, eval e2) of
    (Just (IVal x), Just (IVal y)) -> Just (IVal (x * y))
    _                              -> Nothing

eval (Lt e1 e2) =
  case (eval e1, eval e2) of
    (Just (IVal x), Just (IVal y)) -> Just (BVal (x < y))
    _                              -> Nothing

eval (And e1 e2) =
  case (eval e1, eval e2) of
    (Just (BVal x), Just (BVal y)) -> Just (BVal (x && y))
    _                              -> Nothing

eval (Not e) =
  case eval e of
    Just (BVal x) -> Just (BVal (not x))
    _             -> Nothing
```

---

## Question 10 - If Expression

### Question

```haskell
data Value = IVal Int
           | BVal Bool
           deriving (Show, Eq)

data Expr = Val Value
          | Add Expr Expr
          | Lt Expr Expr
          | If Expr Expr Expr
          deriving (Show, Eq)

eval :: Expr -> Maybe Value
eval = undefined
```

### Answer

```haskell
data Value = IVal Int
           | BVal Bool
           deriving (Show, Eq)

data Expr = Val Value
          | Add Expr Expr
          | Lt Expr Expr
          | If Expr Expr Expr
          deriving (Show, Eq)

eval :: Expr -> Maybe Value
eval (Val v) = Just v

eval (Add e1 e2) =
  case (eval e1, eval e2) of
    (Just (IVal x), Just (IVal y)) -> Just (IVal (x + y))
    _                              -> Nothing

eval (Lt e1 e2) =
  case (eval e1, eval e2) of
    (Just (IVal x), Just (IVal y)) -> Just (BVal (x < y))
    _                              -> Nothing

eval (If cond eThen eElse) =
  case eval cond of
    Just (BVal True)  -> eval eThen
    Just (BVal False) -> eval eElse
    _                 -> Nothing
```

---

## Question 11 - Variables with Environment

### Question

```haskell
data Value = IVal Int
           | BVal Bool
           deriving (Show, Eq)

data Expr = Val Value
          | Var String
          | Add Expr Expr
          | Lt Expr Expr
          | If Expr Expr Expr
          deriving (Show, Eq)

type Env = String -> Maybe Value

eval :: Env -> Expr -> Maybe Value
eval = undefined
```

### Answer

```haskell
data Value = IVal Int
           | BVal Bool
           deriving (Show, Eq)

data Expr = Val Value
          | Var String
          | Add Expr Expr
          | Lt Expr Expr
          | If Expr Expr Expr
          deriving (Show, Eq)

type Env = String -> Maybe Value

emptyEnv :: Env
emptyEnv _ = Nothing

bind :: Env -> String -> Value -> Env
bind env name value name'
  | name == name' = Just value
  | otherwise     = env name'

eval :: Env -> Expr -> Maybe Value
eval env (Val v) = Just v

eval env (Var name) = env name

eval env (Add e1 e2) =
  case (eval env e1, eval env e2) of
    (Just (IVal x), Just (IVal y)) -> Just (IVal (x + y))
    _                              -> Nothing

eval env (Lt e1 e2) =
  case (eval env e1, eval env e2) of
    (Just (IVal x), Just (IVal y)) -> Just (BVal (x < y))
    _                              -> Nothing

eval env (If cond eThen eElse) =
  case eval env cond of
    Just (BVal True)  -> eval env eThen
    Just (BVal False) -> eval env eElse
    _                 -> Nothing
```

---

## Question 12 - Multiple Variable Bindings

### Question

```haskell
type Env = String -> Maybe Int

emptyEnv :: Env
emptyEnv = undefined

bind :: Env -> String -> Int -> Env
bind = undefined
```

### Answer

```haskell
type Env = String -> Maybe Int

emptyEnv :: Env
emptyEnv _ = Nothing

bind :: Env -> String -> Int -> Env
bind env name value query
  | name == query = Just value
  | otherwise     = env query
```

---

## Question 13 - Substitute a Variable

### Question

```haskell
data Expr = Val Int
          | Var String
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

subst :: String -> Expr -> Expr -> Expr
subst = undefined
```

`subst name replacement expr` replaces every `Var name` in `expr` by `replacement`.

### Answer

```haskell
data Expr = Val Int
          | Var String
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

subst :: String -> Expr -> Expr -> Expr
subst name replacement (Val n) = Val n

subst name replacement (Var x)
  | name == x  = replacement
  | otherwise  = Var x

subst name replacement (Add e1 e2) =
  Add (subst name replacement e1) (subst name replacement e2)

subst name replacement (Mul e1 e2) =
  Mul (subst name replacement e1) (subst name replacement e2)
```

---

## Question 14 - Free Variables

### Question

```haskell
data Expr = Val Int
          | Var String
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

vars :: Expr -> [String]
vars = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Var String
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

vars :: Expr -> [String]
vars (Val _)     = []
vars (Var x)     = [x]
vars (Add e1 e2) = vars e1 ++ vars e2
vars (Mul e1 e2) = vars e1 ++ vars e2
```

---

## Question 15 - Increment All Integer Values

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

incAll :: Expr -> Expr
incAll = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

incAll :: Expr -> Expr
incAll (Val n)     = Val (n + 1)
incAll (Add e1 e2) = Add (incAll e1) (incAll e2)
incAll (Mul e1 e2) = Mul (incAll e1) (incAll e2)
```

---

## Question 16 - Map over Values

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

mapExpr :: (Int -> Int) -> Expr -> Expr
mapExpr = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

mapExpr :: (Int -> Int) -> Expr -> Expr
mapExpr f (Val n)     = Val (f n)
mapExpr f (Add e1 e2) = Add (mapExpr f e1) (mapExpr f e2)
mapExpr f (Mul e1 e2) = Mul (mapExpr f e1) (mapExpr f e2)
```

---

## Question 17 - Constant Folding

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

simplify :: Expr -> Expr
simplify = undefined
```

Example:

```haskell
simplify (Mul (Val 2) (Add (Val 3) (Val 4)))
-- Val 14
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

simplify :: Expr -> Expr
simplify (Val n) = Val n

simplify (Add e1 e2) =
  case (simplify e1, simplify e2) of
    (Val x, Val y) -> Val (x + y)
    (s1, s2)       -> Add s1 s2

simplify (Mul e1 e2) =
  case (simplify e1, simplify e2) of
    (Val x, Val y) -> Val (x * y)
    (s1, s2)       -> Mul s1 s2
```

---

## Question 18 - Algebraic Simplification

### Question

```haskell
data Expr = Val Int
          | Var String
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

simplify :: Expr -> Expr
simplify = undefined
```

Rules:

```haskell
x + 0 = x
0 + x = x
x * 1 = x
1 * x = x
x * 0 = 0
0 * x = 0
```

### Answer

```haskell
data Expr = Val Int
          | Var String
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

simplify :: Expr -> Expr
simplify (Val n) = Val n
simplify (Var x) = Var x

simplify (Add e1 e2) =
  case (simplify e1, simplify e2) of
    (Val 0, e)       -> e
    (e, Val 0)       -> e
    (Val x, Val y)   -> Val (x + y)
    (s1, s2)         -> Add s1 s2

simplify (Mul e1 e2) =
  case (simplify e1, simplify e2) of
    (Val 0, _)       -> Val 0
    (_, Val 0)       -> Val 0
    (Val 1, e)       -> e
    (e, Val 1)       -> e
    (Val x, Val y)   -> Val (x * y)
    (s1, s2)         -> Mul s1 s2
```

---

## Question 19 - Fold for Expression Trees

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

foldExpr :: (Int -> a) -> (a -> a -> a) -> (a -> a -> a) -> Expr -> a
foldExpr = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

foldExpr :: (Int -> a) -> (a -> a -> a) -> (a -> a -> a) -> Expr -> a
foldExpr fVal fAdd fMul (Val n) =
  fVal n

foldExpr fVal fAdd fMul (Add e1 e2) =
  fAdd (foldExpr fVal fAdd fMul e1)
       (foldExpr fVal fAdd fMul e2)

foldExpr fVal fAdd fMul (Mul e1 e2) =
  fMul (foldExpr fVal fAdd fMul e1)
       (foldExpr fVal fAdd fMul e2)
```

---

## Question 20 - Rebuild Eval Using Fold

### Question

Using `foldExpr`, define:

```haskell
eval :: Expr -> Int
countVals :: Expr -> Int
height :: Expr -> Int
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

foldExpr :: (Int -> a) -> (a -> a -> a) -> (a -> a -> a) -> Expr -> a
foldExpr fVal fAdd fMul (Val n) =
  fVal n

foldExpr fVal fAdd fMul (Add e1 e2) =
  fAdd (foldExpr fVal fAdd fMul e1)
       (foldExpr fVal fAdd fMul e2)

foldExpr fVal fAdd fMul (Mul e1 e2) =
  fMul (foldExpr fVal fAdd fMul e1)
       (foldExpr fVal fAdd fMul e2)

eval :: Expr -> Int
eval = foldExpr id (+) (*)

countVals :: Expr -> Int
countVals = foldExpr (\_ -> 1) (+) (+)

height :: Expr -> Int
height = foldExpr (\_ -> 0)
                  (\h1 h2 -> 1 + max h1 h2)
                  (\h1 h2 -> 1 + max h1 h2)
```

---

## Question 21 - Logical Expression Evaluation

### Question

```haskell
data Expr = Var     Char
          | Not     Expr
          | And     Expr Expr
          | Or      Expr Expr
          | Implies Expr Expr
          deriving (Eq, Show)

type Env = Char -> Bool

eval :: Env -> Expr -> Bool
eval = undefined
```

### Answer

```haskell
data Expr = Var     Char
          | Not     Expr
          | And     Expr Expr
          | Or      Expr Expr
          | Implies Expr Expr
          deriving (Eq, Show)

type Env = Char -> Bool

eval :: Env -> Expr -> Bool
eval env (Var c)         = env c
eval env (Not e)         = not (eval env e)
eval env (And e1 e2)     = eval env e1 && eval env e2
eval env (Or e1 e2)      = eval env e1 || eval env e2
eval env (Implies e1 e2) = not (eval env e1) || eval env e2
```

---

## Question 22 - Logical Expression Variables

### Question

```haskell
data Expr = Var     Char
          | Not     Expr
          | And     Expr Expr
          | Or      Expr Expr
          | Implies Expr Expr
          deriving (Eq, Show)

vars :: Expr -> [Char]
vars = undefined
```

### Answer

```haskell
data Expr = Var     Char
          | Not     Expr
          | And     Expr Expr
          | Or      Expr Expr
          | Implies Expr Expr
          deriving (Eq, Show)

vars :: Expr -> [Char]
vars (Var c)         = [c]
vars (Not e)         = vars e
vars (And e1 e2)     = vars e1 ++ vars e2
vars (Or e1 e2)      = vars e1 ++ vars e2
vars (Implies e1 e2) = vars e1 ++ vars e2
```

---

## Question 23 - Convert Logical Expr to Nand Circuit

### Question

```haskell
data Expr = Var     Char
          | Not     Expr
          | And     Expr Expr
          | Or      Expr Expr
          | Implies Expr Expr
          deriving (Eq, Show)

data Circuit = Input Char
             | Nand Circuit Circuit
             deriving (Eq, Show)

circuit :: Expr -> Circuit
circuit = undefined
```

Facts:

```haskell
not p     = p nand p
p and q   = not (p nand q)
p or q    = not ((not p) and (not q))
p implies q = (not p) or q
```

### Answer

```haskell
data Expr = Var     Char
          | Not     Expr
          | And     Expr Expr
          | Or      Expr Expr
          | Implies Expr Expr
          deriving (Eq, Show)

data Circuit = Input Char
             | Nand Circuit Circuit
             deriving (Eq, Show)

nandNot :: Circuit -> Circuit
nandNot p = Nand p p

nandAnd :: Circuit -> Circuit -> Circuit
nandAnd p q =
  nandNot (Nand p q)

nandOr :: Circuit -> Circuit -> Circuit
nandOr p q =
  nandNot (nandAnd (nandNot p) (nandNot q))

nandImplies :: Circuit -> Circuit -> Circuit
nandImplies p q =
  nandOr (nandNot p) q

circuit :: Expr -> Circuit
circuit (Var c) =
  Input c

circuit (Not e) =
  nandNot (circuit e)

circuit (And e1 e2) =
  nandAnd (circuit e1) (circuit e2)

circuit (Or e1 e2) =
  nandOr (circuit e1) (circuit e2)

circuit (Implies e1 e2) =
  nandImplies (circuit e1) (circuit e2)
```

---

## Question 24 - Evaluate Nand Circuit

### Question

```haskell
data Circuit = Input Char
             | Nand Circuit Circuit
             deriving (Eq, Show)

type Env = Char -> Bool

evalCircuit :: Env -> Circuit -> Bool
evalCircuit = undefined
```

### Answer

```haskell
data Circuit = Input Char
             | Nand Circuit Circuit
             deriving (Eq, Show)

type Env = Char -> Bool

evalCircuit :: Env -> Circuit -> Bool
evalCircuit env (Input c) =
  env c

evalCircuit env (Nand c1 c2) =
  not (evalCircuit env c1 && evalCircuit env c2)
```

---

## Question 25 - Check Expr and Circuit Equivalence

### Question

```haskell
data Expr = Var     Char
          | Not     Expr
          | And     Expr Expr
          | Or      Expr Expr
          | Implies Expr Expr
          deriving (Eq, Show)

data Circuit = Input Char
             | Nand Circuit Circuit
             deriving (Eq, Show)

type Env = Char -> Bool

evalExpr :: Env -> Expr -> Bool
evalCircuit :: Env -> Circuit -> Bool
circuit :: Expr -> Circuit

equiv :: Env -> Expr -> Bool
equiv = undefined
```

### Answer

```haskell
data Expr = Var     Char
          | Not     Expr
          | And     Expr Expr
          | Or      Expr Expr
          | Implies Expr Expr
          deriving (Eq, Show)

data Circuit = Input Char
             | Nand Circuit Circuit
             deriving (Eq, Show)

type Env = Char -> Bool

evalExpr :: Env -> Expr -> Bool
evalExpr env (Var c)         = env c
evalExpr env (Not e)         = not (evalExpr env e)
evalExpr env (And e1 e2)     = evalExpr env e1 && evalExpr env e2
evalExpr env (Or e1 e2)      = evalExpr env e1 || evalExpr env e2
evalExpr env (Implies e1 e2) = not (evalExpr env e1) || evalExpr env e2

evalCircuit :: Env -> Circuit -> Bool
evalCircuit env (Input c) =
  env c

evalCircuit env (Nand c1 c2) =
  not (evalCircuit env c1 && evalCircuit env c2)

nandNot :: Circuit -> Circuit
nandNot p = Nand p p

nandAnd :: Circuit -> Circuit -> Circuit
nandAnd p q =
  nandNot (Nand p q)

nandOr :: Circuit -> Circuit -> Circuit
nandOr p q =
  nandNot (nandAnd (nandNot p) (nandNot q))

nandImplies :: Circuit -> Circuit -> Circuit
nandImplies p q =
  nandOr (nandNot p) q

circuit :: Expr -> Circuit
circuit (Var c)         = Input c
circuit (Not e)         = nandNot (circuit e)
circuit (And e1 e2)     = nandAnd (circuit e1) (circuit e2)
circuit (Or e1 e2)      = nandOr (circuit e1) (circuit e2)
circuit (Implies e1 e2) = nandImplies (circuit e1) (circuit e2)

equiv :: Env -> Expr -> Bool
equiv env e =
  evalExpr env e == evalCircuit env (circuit e)
```

---

## Question 26 - De Morgan Transformation

### Question

```haskell
data Expr = Var Char
          | Not Expr
          | And Expr Expr
          | Or Expr Expr
          deriving (Eq, Show)

deMorgan :: Expr -> Expr
deMorgan = undefined
```

Transform:

```haskell
Not (And p q) = Or (Not p) (Not q)
Not (Or p q)  = And (Not p) (Not q)
```

### Answer

```haskell
data Expr = Var Char
          | Not Expr
          | And Expr Expr
          | Or Expr Expr
          deriving (Eq, Show)

deMorgan :: Expr -> Expr
deMorgan (Var c) = Var c

deMorgan (Not (And e1 e2)) =
  Or (deMorgan (Not e1)) (deMorgan (Not e2))

deMorgan (Not (Or e1 e2)) =
  And (deMorgan (Not e1)) (deMorgan (Not e2))

deMorgan (Not e) =
  Not (deMorgan e)

deMorgan (And e1 e2) =
  And (deMorgan e1) (deMorgan e2)

deMorgan (Or e1 e2) =
  Or (deMorgan e1) (deMorgan e2)
```

---

## Question 27 - Remove Implies

### Question

```haskell
data Expr = Var     Char
          | Not     Expr
          | And     Expr Expr
          | Or      Expr Expr
          | Implies Expr Expr
          deriving (Eq, Show)

removeImplies :: Expr -> Expr
removeImplies = undefined
```

Rule:

```haskell
p ==> q = not p || q
```

### Answer

```haskell
data Expr = Var     Char
          | Not     Expr
          | And     Expr Expr
          | Or      Expr Expr
          | Implies Expr Expr
          deriving (Eq, Show)

removeImplies :: Expr -> Expr
removeImplies (Var c) =
  Var c

removeImplies (Not e) =
  Not (removeImplies e)

removeImplies (And e1 e2) =
  And (removeImplies e1) (removeImplies e2)

removeImplies (Or e1 e2) =
  Or (removeImplies e1) (removeImplies e2)

removeImplies (Implies e1 e2) =
  Or (Not (removeImplies e1)) (removeImplies e2)
```

---

## Question 28 - Negation Normal Form

### Question

```haskell
data Expr = Var Char
          | Not Expr
          | And Expr Expr
          | Or Expr Expr
          deriving (Eq, Show)

nnf :: Expr -> Expr
nnf = undefined
```

Negations should only appear directly before variables.

### Answer

```haskell
data Expr = Var Char
          | Not Expr
          | And Expr Expr
          | Or Expr Expr
          deriving (Eq, Show)

nnf :: Expr -> Expr
nnf (Var c) =
  Var c

nnf (And e1 e2) =
  And (nnf e1) (nnf e2)

nnf (Or e1 e2) =
  Or (nnf e1) (nnf e2)

nnf (Not (Var c)) =
  Not (Var c)

nnf (Not (Not e)) =
  nnf e

nnf (Not (And e1 e2)) =
  Or (nnf (Not e1)) (nnf (Not e2))

nnf (Not (Or e1 e2)) =
  And (nnf (Not e1)) (nnf (Not e2))
```

---

## Question 29 - Expression Tree as List of Leaves

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

leaves :: Expr -> [Int]
leaves = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

leaves :: Expr -> [Int]
leaves (Val n)     = [n]
leaves (Add e1 e2) = leaves e1 ++ leaves e2
leaves (Mul e1 e2) = leaves e1 ++ leaves e2
```

---

## Question 30 - Parse Very Simple Arithmetic Expressions

### Question

Only parse expressions of the form:

```haskell
"3+4"
"7*8"
"9"
```

Use:

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

parseSimple :: String -> Maybe Expr
parseSimple = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

parseSimple :: String -> Maybe Expr
parseSimple [c]
  | c >= '0' && c <= '9' = Just (Val (read [c]))
  | otherwise            = Nothing

parseSimple [c1, '+', c2]
  | isDigitChar c1 && isDigitChar c2 =
      Just (Add (Val (read [c1])) (Val (read [c2])))
  | otherwise =
      Nothing

parseSimple [c1, '*', c2]
  | isDigitChar c1 && isDigitChar c2 =
      Just (Mul (Val (read [c1])) (Val (read [c2])))
  | otherwise =
      Nothing

parseSimple _ = Nothing

isDigitChar :: Char -> Bool
isDigitChar c = c >= '0' && c <= '9'
```

---

## Question 31 - Read Tree from Fully Parenthesised String

### Question

For strings like:

```haskell
"(3+4)"
"(2*(3+4))"
```

write a simple parser.

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

parseExpr :: String -> Maybe Expr
parseExpr = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

parseExpr :: String -> Maybe Expr
parseExpr s =
  case parse s of
    Just (e, "") -> Just e
    _            -> Nothing

parse :: String -> Maybe (Expr, String)
parse [] = Nothing

parse (c:cs)
  | c >= '0' && c <= '9' =
      Just (Val (read [c]), cs)

parse ('(':cs) =
  case parse cs of
    Just (e1, '+':rest1) ->
      case parse rest1 of
        Just (e2, ')':rest2) -> Just (Add e1 e2, rest2)
        _                   -> Nothing

    Just (e1, '*':rest1) ->
      case parse rest1 of
        Just (e2, ')':rest2) -> Just (Mul e1 e2, rest2)
        _                   -> Nothing

    _ -> Nothing

parse _ = Nothing
```

---

## Question 32 - Compare Two Expressions by Evaluation

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

sameValue :: Expr -> Expr -> Bool
sameValue = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

eval :: Expr -> Int
eval (Val n)     = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Mul e1 e2) = eval e1 * eval e2

sameValue :: Expr -> Expr -> Bool
sameValue e1 e2 =
  eval e1 == eval e2
```

---

## Question 33 - Expression Depth with Variables

### Question

```haskell
data Expr = Val Int
          | Var String
          | Add Expr Expr
          | Mul Expr Expr
          | Neg Expr
          deriving (Show, Eq)

depth :: Expr -> Int
depth = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Var String
          | Add Expr Expr
          | Mul Expr Expr
          | Neg Expr
          deriving (Show, Eq)

depth :: Expr -> Int
depth (Val _)     = 0
depth (Var _)     = 0
depth (Neg e)     = 1 + depth e
depth (Add e1 e2) = 1 + max (depth e1) (depth e2)
depth (Mul e1 e2) = 1 + max (depth e1) (depth e2)
```

---

## Question 34 - Replace All Add with Mul

### Question

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

addToMul :: Expr -> Expr
addToMul = undefined
```

### Answer

```haskell
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
          deriving (Show, Eq)

addToMul :: Expr -> Expr
addToMul (Val n)     = Val n
addToMul (Add e1 e2) = Mul (addToMul e1) (addToMul e2)
addToMul (Mul e1 e2) = Mul (addToMul e1) (addToMul e2)
```

---

## Question 35 - Exam-Style Mixed Evaluator

### Question

```haskell
data Expr = N Int
          | B Bool
          | Add Expr Expr
          | Eq Expr Expr
          | If Expr Expr Expr
          deriving (Show, Eq)

data Value = NumV Int
           | BoolV Bool
           deriving (Show, Eq)

eval :: Expr -> Maybe Value
eval = undefined
```

Rules:

```haskell
N n                -> Just (NumV n)
B b                -> Just (BoolV b)
Add e1 e2          both sides must be NumV
Eq e1 e2           both sides must have same type
If cond e1 e2      cond must be BoolV
```

### Answer

```haskell
data Expr = N Int
          | B Bool
          | Add Expr Expr
          | Eq Expr Expr
          | If Expr Expr Expr
          deriving (Show, Eq)

data Value = NumV Int
           | BoolV Bool
           deriving (Show, Eq)

eval :: Expr -> Maybe Value
eval (N n) =
  Just (NumV n)

eval (B b) =
  Just (BoolV b)

eval (Add e1 e2) =
  case (eval e1, eval e2) of
    (Just (NumV x), Just (NumV y)) -> Just (NumV (x + y))
    _                              -> Nothing

eval (Eq e1 e2) =
  case (eval e1, eval e2) of
    (Just (NumV x),  Just (NumV y))  -> Just (BoolV (x == y))
    (Just (BoolV x), Just (BoolV y)) -> Just (BoolV (x == y))
    _                                -> Nothing

eval (If cond eThen eElse) =
  case eval cond of
    Just (BoolV True)  -> eval eThen
    Just (BoolV False) -> eval eElse
    _                  -> Nothing
```
