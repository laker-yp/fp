# Expression Tree 

---

## 目录

- [A区：Arithmetic Expression Tree 基础算术表达式树](#a区arithmetic-expression-tree-基础算术表达式树)
  - [A1. Basic eval](#a1-basic-eval)
  - [A2. Count values](#a2-count-values)
  - [A3. Count operators](#a3-count-operators)
  - [A4. Height / depth](#a4-height--depth)
  - [A5. Number of leaves](#a5-number-of-leaves)
  - [A6. Number of Add nodes](#a6-number-of-add-nodes)
  - [A7. Number of Mul nodes](#a7-number-of-mul-nodes)
  - [A8. Sum of all values](#a8-sum-of-all-values)
  - [A9. Product of all values](#a9-product-of-all-values)
  - [A10. Maximum value in expression](#a10-maximum-value-in-expression)
  - [A11. Minimum value in expression](#a11-minimum-value-in-expression)
  - [A12. Leaves list](#a12-leaves-list)
  - [A13. Operators list](#a13-operators-list)
  - [A14. Mirror expression](#a14-mirror-expression)
  - [A15. Same value comparison](#a15-same-value-comparison)
- [B区：Show / Pretty Print 显示表达式](#b区show--pretty-print-显示表达式)
  - [B1. Full parentheses showExpr](#b1-full-parentheses-showexpr)
  - [B2. Show with spaces](#b2-show-with-spaces)
  - [B3. Prefix notation](#b3-prefix-notation)
  - [B4. Postfix notation](#b4-postfix-notation)
  - [B5. Pretty print fewer parentheses](#b5-pretty-print-fewer-parentheses)
  - [B6. Pretty print with Neg](#b6-pretty-print-with-neg)
  - [B7. Show instance](#b7-show-instance)
  - [B8. Fully parenthesised Bool expression](#b8-fully-parenthesised-bool-expression)
- [C区：Maybe / Either 安全求值](#c区maybe--either-安全求值)
  - [C1. Division using Maybe](#c1-division-using-maybe)
  - [C2. Division using Either](#c2-division-using-either)
  - [C3. Safe Add/Mul with Maybe](#c3-safe-addmul-with-maybe)
  - [C4. Safe Boolean and Integer eval Maybe](#c4-safe-boolean-and-integer-eval-maybe)
  - [C5. Safe Boolean and Integer eval Either](#c5-safe-boolean-and-integer-eval-either)
  - [C6. If expression Maybe](#c6-if-expression-maybe)
  - [C7. If expression Either](#c7-if-expression-either)
  - [C8. Maybe do-notation eval](#c8-maybe-do-notation-eval)
  - [C9. Either do-notation eval](#c9-either-do-notation-eval)
  - [C10. Safe equality operator](#c10-safe-equality-operator)
- [D区：Variables / Environment 变量环境求值](#d区variables--environment-变量环境求值)
  - [D1. Env as function](#d1-env-as-function)
  - [D2. emptyEnv](#d2-emptyenv)
  - [D3. bind one variable](#d3-bind-one-variable)
  - [D4. bind many variables](#d4-bind-many-variables)
  - [D5. lookup in association list](#d5-lookup-in-association-list)
  - [D6. eval with variables Maybe](#d6-eval-with-variables-maybe)
  - [D7. eval with variables Either](#d7-eval-with-variables-either)
  - [D8. substitute variable](#d8-substitute-variable)
  - [D9. substitute many variables](#d9-substitute-many-variables)
  - [D10. free variables](#d10-free-variables)
  - [D11. unique free variables](#d11-unique-free-variables)
  - [D12. all variables defined](#d12-all-variables-defined)
- [E区：Transform / Simplify 表达式变换与化简](#e区transform--simplify-表达式变换与化简)
  - [E1. Increment all values](#e1-increment-all-values)
  - [E2. Map over values](#e2-map-over-values)
  - [E3. Replace Add with Mul](#e3-replace-add-with-mul)
  - [E4. Replace Mul with Add](#e4-replace-mul-with-add)
  - [E5. Negate all values](#e5-negate-all-values)
  - [E6. Constant folding](#e6-constant-folding)
  - [E7. Algebraic simplification](#e7-algebraic-simplification)
  - [E8. Simplify with subtraction](#e8-simplify-with-subtraction)
  - [E9. Simplify double negation](#e9-simplify-double-negation)
  - [E10. Normalize expression](#e10-normalize-expression)
- [F区：Fold Expression Tree 高阶抽象](#f区fold-expression-tree-高阶抽象)
  - [F1. foldExpr for Val/Add/Mul](#f1-foldexpr-for-valaddmul)
  - [F2. eval using foldExpr](#f2-eval-using-foldexpr)
  - [F3. countVals using foldExpr](#f3-countvals-using-foldexpr)
  - [F4. height using foldExpr](#f4-height-using-foldexpr)
  - [F5. showExpr using foldExpr](#f5-showexpr-using-foldexpr)
  - [F6. leaves using foldExpr](#f6-leaves-using-foldexpr)
  - [F7. mapExpr using foldExpr](#f7-mapexpr-using-foldexpr)
  - [F8. foldExpr with Var](#f8-foldexpr-with-var)
- [G区：Logical Expression 逻辑表达式树](#g区logical-expression-逻辑表达式树)
  - [G1. Logical eval](#g1-logical-eval)
  - [G2. Logical vars](#g2-logical-vars)
  - [G3. Remove duplicates from vars](#g3-remove-duplicates-from-vars)
  - [G4. Truth table environments](#g4-truth-table-environments)
  - [G5. Tautology check](#g5-tautology-check)
  - [G6. Contradiction check](#g6-contradiction-check)
  - [G7. Satisfiable check](#g7-satisfiable-check)
  - [G8. Remove Implies](#g8-remove-implies)
  - [G9. De Morgan](#g9-de-morgan)
  - [G10. Negation Normal Form](#g10-negation-normal-form)
  - [G11. Simplify logical expressions](#g11-simplify-logical-expressions)
- [H区：NAND Circuit 超高命中率](#h区nand-circuit-超高命中率)
  - [H1. Circuit datatype](#h1-circuit-datatype)
  - [H2. nandNot](#h2-nandnot)
  - [H3. nandAnd](#h3-nandand)
  - [H4. nandOr](#h4-nandor)
  - [H5. nandImplies](#h5-nandimplies)
  - [H6. Convert Expr to Circuit](#h6-convert-expr-to-circuit)
  - [H7. evalCircuit](#h7-evalcircuit)
  - [H8. equivalence check](#h8-equivalence-check)
  - [H9. Count Nand gates](#h9-count-nand-gates)
  - [H10. Circuit inputs](#h10-circuit-inputs)
  - [H11. Pretty print circuit](#h11-pretty-print-circuit)
- [I区：Parser / Read Expression 解析表达式](#i区parser--read-expression-解析表达式)
  - [I1. parse single digit](#i1-parse-single-digit)
  - [I2. parse simple 3-char expression](#i2-parse-simple-3-char-expression)
  - [I3. parse fully parenthesised Add/Mul](#i3-parse-fully-parenthesised-addmul)
  - [I4. parse with Maybe pair](#i4-parse-with-maybe-pair)
  - [I5. parse spaces](#i5-parse-spaces)
  - [I6. readMaybe Int helper](#i6-readmaybe-int-helper)
  - [I7. parse negative value](#i7-parse-negative-value)
  - [I8. parse bool expression simple](#i8-parse-bool-expression-simple)
- [J区：Mixed Exam Style 综合混合题](#j区mixed-exam-style-综合混合题)
  - [J1. Mixed Num/Bool evaluator Maybe](#j1-mixed-numbool-evaluator-maybe)
  - [J2. Mixed Num/Bool evaluator Either](#j2-mixed-numbool-evaluator-either)
  - [J3. Variables + If + Add](#j3-variables--if--add)
  - [J4. Simplify then eval](#j4-simplify-then-eval)
  - [J5. eval and count steps](#j5-eval-and-count-steps)
  - [J6. eval with Writer log](#j6-eval-with-writer-log)
  - [J7. eval with State counter](#j7-eval-with-state-counter)
  - [J8. eval with Reader env](#j8-eval-with-reader-env)
- [K区：考试最后速背骨架](#k区考试最后速背骨架)
  - [K1. 递归遍历骨架](#k1-递归遍历骨架)
  - [K2. Maybe eval 骨架](#k2-maybe-eval-骨架)
  - [K3. Either eval 骨架](#k3-either-eval-骨架)
  - [K4. Env lookup 骨架](#k4-env-lookup-骨架)
  - [K5. Simplify 骨架](#k5-simplify-骨架)
  - [K6. NAND 骨架](#k6-nand-骨架)
  - [K7. Parser 骨架](#k7-parser-骨架)

---

# A区：Arithmetic Expression Tree 基础算术表达式树

---

## A1. Basic eval

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

## A2. Count values

```haskell
countVals :: Expr -> Int
countVals (Val _)     = 1
countVals (Add e1 e2) = countVals e1 + countVals e2
countVals (Mul e1 e2) = countVals e1 + countVals e2
```

---

## A3. Count operators

```haskell
countOps :: Expr -> Int
countOps (Val _)     = 0
countOps (Add e1 e2) = 1 + countOps e1 + countOps e2
countOps (Mul e1 e2) = 1 + countOps e1 + countOps e2
```

---

## A4. Height / depth

```haskell
height :: Expr -> Int
height (Val _)     = 0
height (Add e1 e2) = 1 + max (height e1) (height e2)
height (Mul e1 e2) = 1 + max (height e1) (height e2)
```

---

## A5. Number of leaves

```haskell
numLeaves :: Expr -> Int
numLeaves (Val _)     = 1
numLeaves (Add e1 e2) = numLeaves e1 + numLeaves e2
numLeaves (Mul e1 e2) = numLeaves e1 + numLeaves e2
```

---

## A6. Number of Add nodes

```haskell
countAdds :: Expr -> Int
countAdds (Val _)     = 0
countAdds (Add e1 e2) = 1 + countAdds e1 + countAdds e2
countAdds (Mul e1 e2) = countAdds e1 + countAdds e2
```

---

## A7. Number of Mul nodes

```haskell
countMuls :: Expr -> Int
countMuls (Val _)     = 0
countMuls (Add e1 e2) = countMuls e1 + countMuls e2
countMuls (Mul e1 e2) = 1 + countMuls e1 + countMuls e2
```

---

## A8. Sum of all values

```haskell
sumVals :: Expr -> Int
sumVals (Val n)     = n
sumVals (Add e1 e2) = sumVals e1 + sumVals e2
sumVals (Mul e1 e2) = sumVals e1 + sumVals e2
```

---

## A9. Product of all values

```haskell
productVals :: Expr -> Int
productVals (Val n)     = n
productVals (Add e1 e2) = productVals e1 * productVals e2
productVals (Mul e1 e2) = productVals e1 * productVals e2
```

---

## A10. Maximum value in expression

```haskell
maxVal :: Expr -> Int
maxVal (Val n)     = n
maxVal (Add e1 e2) = max (maxVal e1) (maxVal e2)
maxVal (Mul e1 e2) = max (maxVal e1) (maxVal e2)
```

---

## A11. Minimum value in expression

```haskell
minVal :: Expr -> Int
minVal (Val n)     = n
minVal (Add e1 e2) = min (minVal e1) (minVal e2)
minVal (Mul e1 e2) = min (minVal e1) (minVal e2)
```

---

## A12. Leaves list

```haskell
leaves :: Expr -> [Int]
leaves (Val n)     = [n]
leaves (Add e1 e2) = leaves e1 ++ leaves e2
leaves (Mul e1 e2) = leaves e1 ++ leaves e2
```

---

## A13. Operators list

```haskell
operators :: Expr -> [Char]
operators (Val _)     = []
operators (Add e1 e2) = '+' : operators e1 ++ operators e2
operators (Mul e1 e2) = '*' : operators e1 ++ operators e2
```

---

## A14. Mirror expression

```haskell
mirror :: Expr -> Expr
mirror (Val n)     = Val n
mirror (Add e1 e2) = Add (mirror e2) (mirror e1)
mirror (Mul e1 e2) = Mul (mirror e2) (mirror e1)
```

---

## A15. Same value comparison

```haskell
sameValue :: Expr -> Expr -> Bool
sameValue e1 e2 =
  eval e1 == eval e2
```

---

# B区：Show / Pretty Print 显示表达式

---

## B1. Full parentheses showExpr

```haskell
showExpr :: Expr -> String
showExpr (Val n)     = show n
showExpr (Add e1 e2) = "(" ++ showExpr e1 ++ "+" ++ showExpr e2 ++ ")"
showExpr (Mul e1 e2) = "(" ++ showExpr e1 ++ "*" ++ showExpr e2 ++ ")"
```

---

## B2. Show with spaces

```haskell
showExprSpaces :: Expr -> String
showExprSpaces (Val n)     = show n
showExprSpaces (Add e1 e2) = "(" ++ showExprSpaces e1 ++ " + " ++ showExprSpaces e2 ++ ")"
showExprSpaces (Mul e1 e2) = "(" ++ showExprSpaces e1 ++ " * " ++ showExprSpaces e2 ++ ")"
```

---

## B3. Prefix notation

```haskell
prefix :: Expr -> String
prefix (Val n)     = show n
prefix (Add e1 e2) = "+ " ++ prefix e1 ++ " " ++ prefix e2
prefix (Mul e1 e2) = "* " ++ prefix e1 ++ " " ++ prefix e2
```

---

## B4. Postfix notation

```haskell
postfix :: Expr -> String
postfix (Val n)     = show n
postfix (Add e1 e2) = postfix e1 ++ " " ++ postfix e2 ++ " +"
postfix (Mul e1 e2) = postfix e1 ++ " " ++ postfix e2 ++ " *"
```

---

## B5. Pretty print fewer parentheses

```haskell
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

## B6. Pretty print with Neg

```haskell
data ExprN = NVal Int
           | NAdd ExprN ExprN
           | NMul ExprN ExprN
           | NNeg ExprN
           deriving (Show, Eq)

showPrettyN :: ExprN -> String
showPrettyN = go 0
  where
    go _ (NVal n) = show n

    go p (NNeg e) =
      parensIf (p > 9) $
        "-" ++ go 9 e

    go p (NAdd e1 e2) =
      parensIf (p > 6) $
        go 6 e1 ++ "+" ++ go 6 e2

    go p (NMul e1 e2) =
      parensIf (p > 7) $
        go 8 e1 ++ "*" ++ go 8 e2
```

---

## B7. Show instance

```haskell
instance Show Expr where
  show (Val n)     = show n
  show (Add e1 e2) = "(" ++ show e1 ++ "+" ++ show e2 ++ ")"
  show (Mul e1 e2) = "(" ++ show e1 ++ "*" ++ show e2 ++ ")"
```

注意：如果 data 已经 `deriving Show`，就不要再手写 `instance Show Expr`，否则会重复定义。

---

## B8. Fully parenthesised Bool expression

```haskell
data BExpr = BVal Bool
           | BNot BExpr
           | BAnd BExpr BExpr
           | BOr BExpr BExpr
           deriving (Show, Eq)

showBExpr :: BExpr -> String
showBExpr (BVal b)      = show b
showBExpr (BNot e)      = "not(" ++ showBExpr e ++ ")"
showBExpr (BAnd e1 e2)  = "(" ++ showBExpr e1 ++ "&&" ++ showBExpr e2 ++ ")"
showBExpr (BOr e1 e2)   = "(" ++ showBExpr e1 ++ "||" ++ showBExpr e2 ++ ")"
```

---

# C区：Maybe / Either 安全求值

---

## C1. Division using Maybe

```haskell
data ExprD = DVal Int
           | DAdd ExprD ExprD
           | DDiv ExprD ExprD
           deriving (Show, Eq)

evalD :: ExprD -> Maybe Int
evalD (DVal n) = Just n

evalD (DAdd e1 e2) =
  case (evalD e1, evalD e2) of
    (Just x, Just y) -> Just (x + y)
    _                -> Nothing

evalD (DDiv e1 e2) =
  case (evalD e1, evalD e2) of
    (Just _, Just 0) -> Nothing
    (Just x, Just y) -> Just (x `div` y)
    _                -> Nothing
```

---

## C2. Division using Either

```haskell
evalDE :: ExprD -> Either String Int
evalDE (DVal n) = Right n

evalDE (DAdd e1 e2) =
  case (evalDE e1, evalDE e2) of
    (Right x, Right y) -> Right (x + y)
    (Left err, _)      -> Left err
    (_, Left err)      -> Left err

evalDE (DDiv e1 e2) =
  case (evalDE e1, evalDE e2) of
    (_, Right 0)       -> Left "Division by zero"
    (Right x, Right y) -> Right (x `div` y)
    (Left err, _)      -> Left err
    (_, Left err)      -> Left err
```

---

## C3. Safe Add/Mul with Maybe

```haskell
data Value = IVal Int
           | BVal Bool
           deriving (Show, Eq)

data MExpr = MVal Value
           | MAdd MExpr MExpr
           | MMul MExpr MExpr
           deriving (Show, Eq)

evalM :: MExpr -> Maybe Value
evalM (MVal v) = Just v

evalM (MAdd e1 e2) =
  case (evalM e1, evalM e2) of
    (Just (IVal x), Just (IVal y)) -> Just (IVal (x + y))
    _                              -> Nothing

evalM (MMul e1 e2) =
  case (evalM e1, evalM e2) of
    (Just (IVal x), Just (IVal y)) -> Just (IVal (x * y))
    _                              -> Nothing
```

---

## C4. Safe Boolean and Integer eval Maybe

```haskell
data ExprBI = ValBI Value
            | AddBI ExprBI ExprBI
            | MulBI ExprBI ExprBI
            | LtBI ExprBI ExprBI
            | AndBI ExprBI ExprBI
            | NotBI ExprBI
            deriving (Show, Eq)

evalBI :: ExprBI -> Maybe Value
evalBI (ValBI v) = Just v

evalBI (AddBI e1 e2) =
  case (evalBI e1, evalBI e2) of
    (Just (IVal x), Just (IVal y)) -> Just (IVal (x + y))
    _                              -> Nothing

evalBI (MulBI e1 e2) =
  case (evalBI e1, evalBI e2) of
    (Just (IVal x), Just (IVal y)) -> Just (IVal (x * y))
    _                              -> Nothing

evalBI (LtBI e1 e2) =
  case (evalBI e1, evalBI e2) of
    (Just (IVal x), Just (IVal y)) -> Just (BVal (x < y))
    _                              -> Nothing

evalBI (AndBI e1 e2) =
  case (evalBI e1, evalBI e2) of
    (Just (BVal x), Just (BVal y)) -> Just (BVal (x && y))
    _                              -> Nothing

evalBI (NotBI e) =
  case evalBI e of
    Just (BVal x) -> Just (BVal (not x))
    _             -> Nothing
```

---

## C5. Safe Boolean and Integer eval Either

```haskell
evalBIE :: ExprBI -> Either String Value
evalBIE (ValBI v) = Right v

evalBIE (AddBI e1 e2) =
  case (evalBIE e1, evalBIE e2) of
    (Right (IVal x), Right (IVal y)) -> Right (IVal (x + y))
    _                                -> Left "Add expects two integers"

evalBIE (MulBI e1 e2) =
  case (evalBIE e1, evalBIE e2) of
    (Right (IVal x), Right (IVal y)) -> Right (IVal (x * y))
    _                                -> Left "Mul expects two integers"

evalBIE (LtBI e1 e2) =
  case (evalBIE e1, evalBIE e2) of
    (Right (IVal x), Right (IVal y)) -> Right (BVal (x < y))
    _                                -> Left "Lt expects two integers"

evalBIE (AndBI e1 e2) =
  case (evalBIE e1, evalBIE e2) of
    (Right (BVal x), Right (BVal y)) -> Right (BVal (x && y))
    _                                -> Left "And expects two booleans"

evalBIE (NotBI e) =
  case evalBIE e of
    Right (BVal x) -> Right (BVal (not x))
    _              -> Left "Not expects a boolean"
```

---

## C6. If expression Maybe

```haskell
data IfExpr = IfVal Value
            | IfAdd IfExpr IfExpr
            | IfLt IfExpr IfExpr
            | If IfExpr IfExpr IfExpr
            deriving (Show, Eq)

evalIf :: IfExpr -> Maybe Value
evalIf (IfVal v) = Just v

evalIf (IfAdd e1 e2) =
  case (evalIf e1, evalIf e2) of
    (Just (IVal x), Just (IVal y)) -> Just (IVal (x + y))
    _                              -> Nothing

evalIf (IfLt e1 e2) =
  case (evalIf e1, evalIf e2) of
    (Just (IVal x), Just (IVal y)) -> Just (BVal (x < y))
    _                              -> Nothing

evalIf (If cond eThen eElse) =
  case evalIf cond of
    Just (BVal True)  -> evalIf eThen
    Just (BVal False) -> evalIf eElse
    _                 -> Nothing
```

---

## C7. If expression Either

```haskell
evalIfE :: IfExpr -> Either String Value
evalIfE (IfVal v) = Right v

evalIfE (IfAdd e1 e2) =
  case (evalIfE e1, evalIfE e2) of
    (Right (IVal x), Right (IVal y)) -> Right (IVal (x + y))
    _                                -> Left "Add expects two integers"

evalIfE (IfLt e1 e2) =
  case (evalIfE e1, evalIfE e2) of
    (Right (IVal x), Right (IVal y)) -> Right (BVal (x < y))
    _                                -> Left "Lt expects two integers"

evalIfE (If cond eThen eElse) =
  case evalIfE cond of
    Right (BVal True)  -> evalIfE eThen
    Right (BVal False) -> evalIfE eElse
    _                  -> Left "If condition must be boolean"
```

---

## C8. Maybe do-notation eval

```haskell
evalDDo :: ExprD -> Maybe Int
evalDDo (DVal n) = Just n

evalDDo (DAdd e1 e2) = do
  x <- evalDDo e1
  y <- evalDDo e2
  return (x + y)

evalDDo (DDiv e1 e2) = do
  x <- evalDDo e1
  y <- evalDDo e2
  if y == 0
    then Nothing
    else return (x `div` y)
```

---

## C9. Either do-notation eval

```haskell
evalDDoE :: ExprD -> Either String Int
evalDDoE (DVal n) = Right n

evalDDoE (DAdd e1 e2) = do
  x <- evalDDoE e1
  y <- evalDDoE e2
  return (x + y)

evalDDoE (DDiv e1 e2) = do
  x <- evalDDoE e1
  y <- evalDDoE e2
  if y == 0
    then Left "Division by zero"
    else return (x `div` y)
```

---

## C10. Safe equality operator

```haskell
data EqExpr = EqVal Value
            | EqAdd EqExpr EqExpr
            | EqOp EqExpr EqExpr
            deriving (Show, Eq)

evalEqExpr :: EqExpr -> Maybe Value
evalEqExpr (EqVal v) = Just v

evalEqExpr (EqAdd e1 e2) =
  case (evalEqExpr e1, evalEqExpr e2) of
    (Just (IVal x), Just (IVal y)) -> Just (IVal (x + y))
    _                              -> Nothing

evalEqExpr (EqOp e1 e2) =
  case (evalEqExpr e1, evalEqExpr e2) of
    (Just (IVal x), Just (IVal y))   -> Just (BVal (x == y))
    (Just (BVal x), Just (BVal y))   -> Just (BVal (x == y))
    _                                -> Nothing
```

---

# D区：Variables / Environment 变量环境求值

---

## D1. Env as function

```haskell
type Env = String -> Maybe Value
```

---

## D2. emptyEnv

```haskell
emptyEnv :: Env
emptyEnv _ = Nothing
```

---

## D3. bind one variable

```haskell
bind :: Env -> String -> Value -> Env
bind env name value query
  | name == query = Just value
  | otherwise     = env query
```

---

## D4. bind many variables

```haskell
bindMany :: Env -> [(String, Value)] -> Env
bindMany env [] = env

bindMany env ((name, value):xs) =
  bindMany (bind env name value) xs
```

---

## D5. lookup in association list

```haskell
type EnvList = [(String, Value)]

lookupEnv :: String -> EnvList -> Maybe Value
lookupEnv name [] = Nothing

lookupEnv name ((x, v):xs)
  | name == x  = Just v
  | otherwise  = lookupEnv name xs
```

---

## D6. eval with variables Maybe

```haskell
data VExpr = VVal Value
           | VVar String
           | VAdd VExpr VExpr
           | VLt VExpr VExpr
           | VIf VExpr VExpr VExpr
           deriving (Show, Eq)

evalV :: Env -> VExpr -> Maybe Value
evalV env (VVal v) = Just v

evalV env (VVar name) = env name

evalV env (VAdd e1 e2) =
  case (evalV env e1, evalV env e2) of
    (Just (IVal x), Just (IVal y)) -> Just (IVal (x + y))
    _                              -> Nothing

evalV env (VLt e1 e2) =
  case (evalV env e1, evalV env e2) of
    (Just (IVal x), Just (IVal y)) -> Just (BVal (x < y))
    _                              -> Nothing

evalV env (VIf cond eThen eElse) =
  case evalV env cond of
    Just (BVal True)  -> evalV env eThen
    Just (BVal False) -> evalV env eElse
    _                 -> Nothing
```

---

## D7. eval with variables Either

```haskell
evalVE :: Env -> VExpr -> Either String Value
evalVE env (VVal v) = Right v

evalVE env (VVar name) =
  case env name of
    Just v  -> Right v
    Nothing -> Left ("Unbound variable: " ++ name)

evalVE env (VAdd e1 e2) =
  case (evalVE env e1, evalVE env e2) of
    (Right (IVal x), Right (IVal y)) -> Right (IVal (x + y))
    _                                -> Left "Add expects integers"

evalVE env (VLt e1 e2) =
  case (evalVE env e1, evalVE env e2) of
    (Right (IVal x), Right (IVal y)) -> Right (BVal (x < y))
    _                                -> Left "Lt expects integers"

evalVE env (VIf cond eThen eElse) =
  case evalVE env cond of
    Right (BVal True)  -> evalVE env eThen
    Right (BVal False) -> evalVE env eElse
    _                  -> Left "If condition must be boolean"
```

---

## D8. substitute variable

```haskell
data ExprVar = EVal Int
             | EVar String
             | EAdd ExprVar ExprVar
             | EMul ExprVar ExprVar
             deriving (Show, Eq)

subst :: String -> ExprVar -> ExprVar -> ExprVar
subst name replacement (EVal n) = EVal n

subst name replacement (EVar x)
  | name == x  = replacement
  | otherwise  = EVar x

subst name replacement (EAdd e1 e2) =
  EAdd (subst name replacement e1) (subst name replacement e2)

subst name replacement (EMul e1 e2) =
  EMul (subst name replacement e1) (subst name replacement e2)
```

---

## D9. substitute many variables

```haskell
substMany :: [(String, ExprVar)] -> ExprVar -> ExprVar
substMany [] e = e

substMany ((name, replacement):xs) e =
  substMany xs (subst name replacement e)
```

---

## D10. free variables

```haskell
vars :: ExprVar -> [String]
vars (EVal _)     = []
vars (EVar x)     = [x]
vars (EAdd e1 e2) = vars e1 ++ vars e2
vars (EMul e1 e2) = vars e1 ++ vars e2
```

---

## D11. unique free variables

```haskell
unique :: Eq a => [a] -> [a]
unique [] = []
unique (x:xs)
  | x `elem` xs = unique xs
  | otherwise   = x : unique xs

freeVars :: ExprVar -> [String]
freeVars e = unique (vars e)
```

---

## D12. all variables defined

```haskell
allDefined :: Env -> ExprVar -> Bool
allDefined env e =
  and [isJust (env x) | x <- freeVars e]

isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust Nothing  = False
```

---

# E区：Transform / Simplify 表达式变换与化简

---

## E1. Increment all values

```haskell
incAll :: Expr -> Expr
incAll (Val n)     = Val (n + 1)
incAll (Add e1 e2) = Add (incAll e1) (incAll e2)
incAll (Mul e1 e2) = Mul (incAll e1) (incAll e2)
```

---

## E2. Map over values

```haskell
mapExpr :: (Int -> Int) -> Expr -> Expr
mapExpr f (Val n)     = Val (f n)
mapExpr f (Add e1 e2) = Add (mapExpr f e1) (mapExpr f e2)
mapExpr f (Mul e1 e2) = Mul (mapExpr f e1) (mapExpr f e2)
```

---

## E3. Replace Add with Mul

```haskell
addToMul :: Expr -> Expr
addToMul (Val n)     = Val n
addToMul (Add e1 e2) = Mul (addToMul e1) (addToMul e2)
addToMul (Mul e1 e2) = Mul (addToMul e1) (addToMul e2)
```

---

## E4. Replace Mul with Add

```haskell
mulToAdd :: Expr -> Expr
mulToAdd (Val n)     = Val n
mulToAdd (Add e1 e2) = Add (mulToAdd e1) (mulToAdd e2)
mulToAdd (Mul e1 e2) = Add (mulToAdd e1) (mulToAdd e2)
```

---

## E5. Negate all values

```haskell
negateVals :: Expr -> Expr
negateVals (Val n)     = Val (-n)
negateVals (Add e1 e2) = Add (negateVals e1) (negateVals e2)
negateVals (Mul e1 e2) = Mul (negateVals e1) (negateVals e2)
```

---

## E6. Constant folding

```haskell
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

## E7. Algebraic simplification

```haskell
data ExprS = SVal Int
           | SVar String
           | SAdd ExprS ExprS
           | SMul ExprS ExprS
           deriving (Show, Eq)

simplifyS :: ExprS -> ExprS
simplifyS (SVal n) = SVal n
simplifyS (SVar x) = SVar x

simplifyS (SAdd e1 e2) =
  case (simplifyS e1, simplifyS e2) of
    (SVal 0, e)       -> e
    (e, SVal 0)       -> e
    (SVal x, SVal y)  -> SVal (x + y)
    (s1, s2)          -> SAdd s1 s2

simplifyS (SMul e1 e2) =
  case (simplifyS e1, simplifyS e2) of
    (SVal 0, _)       -> SVal 0
    (_, SVal 0)       -> SVal 0
    (SVal 1, e)       -> e
    (e, SVal 1)       -> e
    (SVal x, SVal y)  -> SVal (x * y)
    (s1, s2)          -> SMul s1 s2
```

---

## E8. Simplify with subtraction

```haskell
data ExprSub = SubVal Int
             | SubAdd ExprSub ExprSub
             | SubSub ExprSub ExprSub
             | SubMul ExprSub ExprSub
             deriving (Show, Eq)

simplifySub :: ExprSub -> ExprSub
simplifySub (SubVal n) = SubVal n

simplifySub (SubAdd e1 e2) =
  case (simplifySub e1, simplifySub e2) of
    (SubVal 0, e) -> e
    (e, SubVal 0) -> e
    (SubVal x, SubVal y) -> SubVal (x + y)
    (s1, s2) -> SubAdd s1 s2

simplifySub (SubSub e1 e2) =
  case (simplifySub e1, simplifySub e2) of
    (e, SubVal 0) -> e
    (SubVal x, SubVal y) -> SubVal (x - y)
    (s1, s2) -> SubSub s1 s2

simplifySub (SubMul e1 e2) =
  case (simplifySub e1, simplifySub e2) of
    (SubVal 0, _) -> SubVal 0
    (_, SubVal 0) -> SubVal 0
    (SubVal 1, e) -> e
    (e, SubVal 1) -> e
    (SubVal x, SubVal y) -> SubVal (x * y)
    (s1, s2) -> SubMul s1 s2
```

---

## E9. Simplify double negation

```haskell
data ExprNeg = NegVal Int
             | Neg ExprNeg
             | NegAdd ExprNeg ExprNeg
             deriving (Show, Eq)

simplifyNeg :: ExprNeg -> ExprNeg
simplifyNeg (NegVal n) = NegVal n

simplifyNeg (Neg (Neg e)) =
  simplifyNeg e

simplifyNeg (Neg e) =
  Neg (simplifyNeg e)

simplifyNeg (NegAdd e1 e2) =
  NegAdd (simplifyNeg e1) (simplifyNeg e2)
```

---

## E10. Normalize expression

```haskell
normalize :: ExprS -> ExprS
normalize e =
  simplifyS e
```

---

# F区：Fold Expression Tree 高阶抽象

---

## F1. foldExpr for Val/Add/Mul

```haskell
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

## F2. eval using foldExpr

```haskell
evalFold :: Expr -> Int
evalFold = foldExpr id (+) (*)
```

---

## F3. countVals using foldExpr

```haskell
countValsFold :: Expr -> Int
countValsFold = foldExpr (\_ -> 1) (+) (+)
```

---

## F4. height using foldExpr

```haskell
heightFold :: Expr -> Int
heightFold =
  foldExpr
    (\_ -> 0)
    (\h1 h2 -> 1 + max h1 h2)
    (\h1 h2 -> 1 + max h1 h2)
```

---

## F5. showExpr using foldExpr

```haskell
showExprFold :: Expr -> String
showExprFold =
  foldExpr
    show
    (\s1 s2 -> "(" ++ s1 ++ "+" ++ s2 ++ ")")
    (\s1 s2 -> "(" ++ s1 ++ "*" ++ s2 ++ ")")
```

---

## F6. leaves using foldExpr

```haskell
leavesFold :: Expr -> [Int]
leavesFold =
  foldExpr
    (\n -> [n])
    (++)
    (++)
```

---

## F7. mapExpr using foldExpr

```haskell
mapExprFold :: (Int -> Int) -> Expr -> Expr
mapExprFold f =
  foldExpr
    (\n -> Val (f n))
    Add
    Mul
```

---

## F8. foldExpr with Var

```haskell
data ExprV = VInt Int
           | VName String
           | VPlus ExprV ExprV
           | VTimes ExprV ExprV
           deriving (Show, Eq)

foldExprV :: (Int -> a)
          -> (String -> a)
          -> (a -> a -> a)
          -> (a -> a -> a)
          -> ExprV
          -> a

foldExprV fInt fVar fAdd fMul (VInt n) =
  fInt n

foldExprV fInt fVar fAdd fMul (VName x) =
  fVar x

foldExprV fInt fVar fAdd fMul (VPlus e1 e2) =
  fAdd (foldExprV fInt fVar fAdd fMul e1)
       (foldExprV fInt fVar fAdd fMul e2)

foldExprV fInt fVar fAdd fMul (VTimes e1 e2) =
  fMul (foldExprV fInt fVar fAdd fMul e1)
       (foldExprV fInt fVar fAdd fMul e2)
```

---

# G区：Logical Expression 逻辑表达式树

---

## G1. Logical eval

```haskell
data LExpr = LVar Char
           | LNot LExpr
           | LAnd LExpr LExpr
           | LOr LExpr LExpr
           | LImplies LExpr LExpr
           deriving (Eq, Show)

type BEnv = Char -> Bool

evalL :: BEnv -> LExpr -> Bool
evalL env (LVar c)         = env c
evalL env (LNot e)         = not (evalL env e)
evalL env (LAnd e1 e2)     = evalL env e1 && evalL env e2
evalL env (LOr e1 e2)      = evalL env e1 || evalL env e2
evalL env (LImplies e1 e2) = not (evalL env e1) || evalL env e2
```

---

## G2. Logical vars

```haskell
varsL :: LExpr -> [Char]
varsL (LVar c)         = [c]
varsL (LNot e)         = varsL e
varsL (LAnd e1 e2)     = varsL e1 ++ varsL e2
varsL (LOr e1 e2)      = varsL e1 ++ varsL e2
varsL (LImplies e1 e2) = varsL e1 ++ varsL e2
```

---

## G3. Remove duplicates from vars

```haskell
uniqueChars :: [Char] -> [Char]
uniqueChars [] = []
uniqueChars (x:xs)
  | x `elem` xs = uniqueChars xs
  | otherwise   = x : uniqueChars xs

freeVarsL :: LExpr -> [Char]
freeVarsL e = uniqueChars (varsL e)
```

---

## G4. Truth table environments

```haskell
bools :: Int -> [[Bool]]
bools 0 = [[]]
bools n =
  [b:bs | b <- [False, True], bs <- bools (n - 1)]

envFrom :: [Char] -> [Bool] -> BEnv
envFrom names values c =
  case lookup c (zip names values) of
    Just b  -> b
    Nothing -> False

allEnvs :: [Char] -> [BEnv]
allEnvs names =
  [envFrom names values | values <- bools (length names)]
```

---

## G5. Tautology check

```haskell
tautology :: LExpr -> Bool
tautology e =
  and [evalL env e | env <- allEnvs (freeVarsL e)]
```

---

## G6. Contradiction check

```haskell
contradiction :: LExpr -> Bool
contradiction e =
  and [not (evalL env e) | env <- allEnvs (freeVarsL e)]
```

---

## G7. Satisfiable check

```haskell
satisfiable :: LExpr -> Bool
satisfiable e =
  or [evalL env e | env <- allEnvs (freeVarsL e)]
```

---

## G8. Remove Implies

```haskell
removeImplies :: LExpr -> LExpr
removeImplies (LVar c) =
  LVar c

removeImplies (LNot e) =
  LNot (removeImplies e)

removeImplies (LAnd e1 e2) =
  LAnd (removeImplies e1) (removeImplies e2)

removeImplies (LOr e1 e2) =
  LOr (removeImplies e1) (removeImplies e2)

removeImplies (LImplies e1 e2) =
  LOr (LNot (removeImplies e1)) (removeImplies e2)
```

---

## G9. De Morgan

```haskell
deMorgan :: LExpr -> LExpr
deMorgan (LVar c) = LVar c

deMorgan (LNot (LAnd e1 e2)) =
  LOr (deMorgan (LNot e1)) (deMorgan (LNot e2))

deMorgan (LNot (LOr e1 e2)) =
  LAnd (deMorgan (LNot e1)) (deMorgan (LNot e2))

deMorgan (LNot e) =
  LNot (deMorgan e)

deMorgan (LAnd e1 e2) =
  LAnd (deMorgan e1) (deMorgan e2)

deMorgan (LOr e1 e2) =
  LOr (deMorgan e1) (deMorgan e2)

deMorgan (LImplies e1 e2) =
  deMorgan (removeImplies (LImplies e1 e2))
```

---

## G10. Negation Normal Form

```haskell
nnf :: LExpr -> LExpr
nnf (LVar c) =
  LVar c

nnf (LAnd e1 e2) =
  LAnd (nnf e1) (nnf e2)

nnf (LOr e1 e2) =
  LOr (nnf e1) (nnf e2)

nnf (LImplies e1 e2) =
  nnf (removeImplies (LImplies e1 e2))

nnf (LNot (LVar c)) =
  LNot (LVar c)

nnf (LNot (LNot e)) =
  nnf e

nnf (LNot (LAnd e1 e2)) =
  LOr (nnf (LNot e1)) (nnf (LNot e2))

nnf (LNot (LOr e1 e2)) =
  LAnd (nnf (LNot e1)) (nnf (LNot e2))

nnf (LNot (LImplies e1 e2)) =
  nnf (LNot (removeImplies (LImplies e1 e2)))
```

---

## G11. Simplify logical expressions

```haskell
data LExprS = SBool Bool
            | SVar Char
            | SNot LExprS
            | SAnd LExprS LExprS
            | SOr LExprS LExprS
            deriving (Eq, Show)

simplifyL :: LExprS -> LExprS
simplifyL (SBool b) = SBool b
simplifyL (SVar c)  = SVar c

simplifyL (SNot e) =
  case simplifyL e of
    SBool b -> SBool (not b)
    s       -> SNot s

simplifyL (SAnd e1 e2) =
  case (simplifyL e1, simplifyL e2) of
    (SBool False, _) -> SBool False
    (_, SBool False) -> SBool False
    (SBool True, e)  -> e
    (e, SBool True)  -> e
    (s1, s2)         -> SAnd s1 s2

simplifyL (SOr e1 e2) =
  case (simplifyL e1, simplifyL e2) of
    (SBool True, _)  -> SBool True
    (_, SBool True)  -> SBool True
    (SBool False, e) -> e
    (e, SBool False) -> e
    (s1, s2)         -> SOr s1 s2
```

---

# H区：NAND Circuit 超高命中率

---

## H1. Circuit datatype

```haskell
data Circuit = Input Char
             | Nand Circuit Circuit
             deriving (Eq, Show)
```

---

## H2. nandNot

```haskell
nandNot :: Circuit -> Circuit
nandNot p =
  Nand p p
```

---

## H3. nandAnd

```haskell
nandAnd :: Circuit -> Circuit -> Circuit
nandAnd p q =
  nandNot (Nand p q)
```

---

## H4. nandOr

```haskell
nandOr :: Circuit -> Circuit -> Circuit
nandOr p q =
  nandNot (nandAnd (nandNot p) (nandNot q))
```

更短版：

```haskell
nandOr p q =
  Nand (nandNot p) (nandNot q)
```

因为：

```haskell
p or q = (not p) nand (not q)
```

---

## H5. nandImplies

```haskell
nandImplies :: Circuit -> Circuit -> Circuit
nandImplies p q =
  nandOr (nandNot p) q
```

更短版：

```haskell
nandImplies p q =
  Nand p (nandNot q)
```

因为：

```haskell
p ==> q = not p or q
```

---

## H6. Convert Expr to Circuit

```haskell
circuit :: LExpr -> Circuit
circuit (LVar c) =
  Input c

circuit (LNot e) =
  nandNot (circuit e)

circuit (LAnd e1 e2) =
  nandAnd (circuit e1) (circuit e2)

circuit (LOr e1 e2) =
  nandOr (circuit e1) (circuit e2)

circuit (LImplies e1 e2) =
  nandImplies (circuit e1) (circuit e2)
```

---

## H7. evalCircuit

```haskell
evalCircuit :: BEnv -> Circuit -> Bool
evalCircuit env (Input c) =
  env c

evalCircuit env (Nand c1 c2) =
  not (evalCircuit env c1 && evalCircuit env c2)
```

---

## H8. equivalence check

```haskell
equiv :: BEnv -> LExpr -> Bool
equiv env e =
  evalL env e == evalCircuit env (circuit e)
```

---

## H9. Count Nand gates

```haskell
countNand :: Circuit -> Int
countNand (Input _) = 0
countNand (Nand c1 c2) =
  1 + countNand c1 + countNand c2
```

---

## H10. Circuit inputs

```haskell
inputs :: Circuit -> [Char]
inputs (Input c) = [c]
inputs (Nand c1 c2) = inputs c1 ++ inputs c2
```

---

## H11. Pretty print circuit

```haskell
showCircuit :: Circuit -> String
showCircuit (Input c) =
  [c]

showCircuit (Nand c1 c2) =
  "(" ++ showCircuit c1 ++ " NAND " ++ showCircuit c2 ++ ")"
```

---

# I区：Parser / Read Expression 解析表达式

---

## I1. parse single digit

```haskell
parseDigit :: String -> Maybe (Expr, String)
parseDigit [] = Nothing

parseDigit (c:cs)
  | c >= '0' && c <= '9' = Just (Val (read [c]), cs)
  | otherwise            = Nothing
```

---

## I2. parse simple 3-char expression

```haskell
parseSimple :: String -> Maybe Expr
parseSimple [c]
  | isDigitChar c = Just (Val (read [c]))
  | otherwise     = Nothing

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

## I3. parse fully parenthesised Add/Mul

```haskell
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
        _                    -> Nothing

    Just (e1, '*':rest1) ->
      case parse rest1 of
        Just (e2, ')':rest2) -> Just (Mul e1 e2, rest2)
        _                    -> Nothing

    _ -> Nothing

parse _ = Nothing
```

---

## I4. parse with Maybe pair

```haskell
parseFull :: String -> Maybe Expr
parseFull s =
  case parse s of
    Just (e, rest) | rest == "" -> Just e
    _                           -> Nothing
```

---

## I5. parse spaces

```haskell
removeSpaces :: String -> String
removeSpaces [] = []
removeSpaces (' ':xs) = removeSpaces xs
removeSpaces (x:xs) = x : removeSpaces xs

parseExprSpaces :: String -> Maybe Expr
parseExprSpaces s =
  parseExpr (removeSpaces s)
```

---

## I6. readMaybe Int helper

```haskell
import Text.Read

parseInt :: String -> Maybe Int
parseInt s =
  readMaybe s
```

---

## I7. parse negative value

```haskell
parseNegVal :: String -> Maybe Expr
parseNegVal ('-':c:[])
  | isDigitChar c = Just (Val (-(read [c])))
  | otherwise     = Nothing

parseNegVal [c]
  | isDigitChar c = Just (Val (read [c]))
  | otherwise     = Nothing

parseNegVal _ = Nothing
```

---

## I8. parse bool expression simple

```haskell
data SimpleBool = SBVal Bool
                | SBAnd SimpleBool SimpleBool
                | SBOr SimpleBool SimpleBool
                deriving (Show, Eq)

parseBoolSimple :: String -> Maybe SimpleBool
parseBoolSimple "T" = Just (SBVal True)
parseBoolSimple "F" = Just (SBVal False)
parseBoolSimple ['T','&','T'] = Just (SBAnd (SBVal True) (SBVal True))
parseBoolSimple ['T','&','F'] = Just (SBAnd (SBVal True) (SBVal False))
parseBoolSimple ['F','&','T'] = Just (SBAnd (SBVal False) (SBVal True))
parseBoolSimple ['F','&','F'] = Just (SBAnd (SBVal False) (SBVal False))
parseBoolSimple ['T','|','T'] = Just (SBOr (SBVal True) (SBVal True))
parseBoolSimple ['T','|','F'] = Just (SBOr (SBVal True) (SBVal False))
parseBoolSimple ['F','|','T'] = Just (SBOr (SBVal False) (SBVal True))
parseBoolSimple ['F','|','F'] = Just (SBOr (SBVal False) (SBVal False))
parseBoolSimple _ = Nothing
```

---

# J区：Mixed Exam Style 综合混合题

---

## J1. Mixed Num/Bool evaluator Maybe

```haskell
data MixExpr = N Int
             | B Bool
             | MixAdd MixExpr MixExpr
             | MixEq MixExpr MixExpr
             | MixIf MixExpr MixExpr MixExpr
             deriving (Show, Eq)

data MixValue = NumV Int
              | BoolV Bool
              deriving (Show, Eq)

evalMix :: MixExpr -> Maybe MixValue
evalMix (N n) = Just (NumV n)

evalMix (B b) = Just (BoolV b)

evalMix (MixAdd e1 e2) =
  case (evalMix e1, evalMix e2) of
    (Just (NumV x), Just (NumV y)) -> Just (NumV (x + y))
    _                              -> Nothing

evalMix (MixEq e1 e2) =
  case (evalMix e1, evalMix e2) of
    (Just (NumV x),  Just (NumV y))  -> Just (BoolV (x == y))
    (Just (BoolV x), Just (BoolV y)) -> Just (BoolV (x == y))
    _                                -> Nothing

evalMix (MixIf cond eThen eElse) =
  case evalMix cond of
    Just (BoolV True)  -> evalMix eThen
    Just (BoolV False) -> evalMix eElse
    _                  -> Nothing
```

---

## J2. Mixed Num/Bool evaluator Either

```haskell
evalMixE :: MixExpr -> Either String MixValue
evalMixE (N n) = Right (NumV n)

evalMixE (B b) = Right (BoolV b)

evalMixE (MixAdd e1 e2) =
  case (evalMixE e1, evalMixE e2) of
    (Right (NumV x), Right (NumV y)) -> Right (NumV (x + y))
    _                                -> Left "Add expects two numbers"

evalMixE (MixEq e1 e2) =
  case (evalMixE e1, evalMixE e2) of
    (Right (NumV x),  Right (NumV y))  -> Right (BoolV (x == y))
    (Right (BoolV x), Right (BoolV y)) -> Right (BoolV (x == y))
    _                                  -> Left "Eq expects same types"

evalMixE (MixIf cond eThen eElse) =
  case evalMixE cond of
    Right (BoolV True)  -> evalMixE eThen
    Right (BoolV False) -> evalMixE eElse
    _                   -> Left "If condition must be boolean"
```

---

## J3. Variables + If + Add

```haskell
data FullExpr = FVal Value
              | FVar String
              | FAdd FullExpr FullExpr
              | FLt FullExpr FullExpr
              | FIf FullExpr FullExpr FullExpr
              deriving (Show, Eq)

evalFull :: Env -> FullExpr -> Maybe Value
evalFull env (FVal v) = Just v

evalFull env (FVar x) = env x

evalFull env (FAdd e1 e2) =
  case (evalFull env e1, evalFull env e2) of
    (Just (IVal x), Just (IVal y)) -> Just (IVal (x + y))
    _                              -> Nothing

evalFull env (FLt e1 e2) =
  case (evalFull env e1, evalFull env e2) of
    (Just (IVal x), Just (IVal y)) -> Just (BVal (x < y))
    _                              -> Nothing

evalFull env (FIf cond eThen eElse) =
  case evalFull env cond of
    Just (BVal True)  -> evalFull env eThen
    Just (BVal False) -> evalFull env eElse
    _                 -> Nothing
```

---

## J4. Simplify then eval

```haskell
evalSimplified :: Expr -> Int
evalSimplified e =
  eval (simplify e)
```

---

## J5. eval and count steps

```haskell
evalCount :: Expr -> (Int, Int)
evalCount (Val n) =
  (n, 1)

evalCount (Add e1 e2) =
  let (x, c1) = evalCount e1
      (y, c2) = evalCount e2
  in (x + y, 1 + c1 + c2)

evalCount (Mul e1 e2) =
  let (x, c1) = evalCount e1
      (y, c2) = evalCount e2
  in (x * y, 1 + c1 + c2)
```

---

## J6. eval with Writer log

```haskell
import Control.Monad.Writer

evalLog :: Expr -> Writer [String] Int
evalLog (Val n) = do
  tell ["Value: " ++ show n]
  return n

evalLog (Add e1 e2) = do
  x <- evalLog e1
  y <- evalLog e2
  tell ["Add"]
  return (x + y)

evalLog (Mul e1 e2) = do
  x <- evalLog e1
  y <- evalLog e2
  tell ["Mul"]
  return (x * y)
```

---

## J7. eval with State counter

```haskell
import Control.Monad.State

evalStateCount :: Expr -> State Int Int
evalStateCount (Val n) = do
  modify (+1)
  return n

evalStateCount (Add e1 e2) = do
  modify (+1)
  x <- evalStateCount e1
  y <- evalStateCount e2
  return (x + y)

evalStateCount (Mul e1 e2) = do
  modify (+1)
  x <- evalStateCount e1
  y <- evalStateCount e2
  return (x * y)
```

---

## J8. eval with Reader env

```haskell
import Control.Monad.Reader

type REnv = String -> Maybe Int

data RExpr = RVal Int
           | RVar String
           | RAdd RExpr RExpr
           deriving (Show, Eq)

evalReader :: RExpr -> Reader REnv (Maybe Int)
evalReader (RVal n) =
  return (Just n)

evalReader (RVar x) = do
  env <- ask
  return (env x)

evalReader (RAdd e1 e2) = do
  r1 <- evalReader e1
  r2 <- evalReader e2
  case (r1, r2) of
    (Just x, Just y) -> return (Just (x + y))
    _                -> return Nothing
```

---

# K区：考试最后速背骨架

---

## K1. 递归遍历骨架

```haskell
f :: Expr -> Result
f (Val n) =
  baseResult

f (Add e1 e2) =
  combineAdd (f e1) (f e2)

f (Mul e1 e2) =
  combineMul (f e1) (f e2)
```

---

## K2. Maybe eval 骨架

```haskell
eval :: Expr -> Maybe Int
eval (Val n) = Just n

eval (Add e1 e2) =
  case (eval e1, eval e2) of
    (Just x, Just y) -> Just (x + y)
    _                -> Nothing
```

---

## K3. Either eval 骨架

```haskell
eval :: Expr -> Either String Int
eval (Val n) = Right n

eval (Add e1 e2) =
  case (eval e1, eval e2) of
    (Right x, Right y) -> Right (x + y)
    (Left err, _)      -> Left err
    (_, Left err)      -> Left err
```

---

## K4. Env lookup 骨架

```haskell
type Env = String -> Maybe Value

eval env (Var x) =
  env x
```

---

## K5. Simplify 骨架

```haskell
simplify (Add e1 e2) =
  case (simplify e1, simplify e2) of
    (Val 0, e) -> e
    (e, Val 0) -> e
    (Val x, Val y) -> Val (x + y)
    (s1, s2) -> Add s1 s2
```

---

## K6. NAND 骨架

```haskell
nandNot p = Nand p p

nandAnd p q =
  nandNot (Nand p q)

nandOr p q =
  Nand (nandNot p) (nandNot q)

nandImplies p q =
  nandOr (nandNot p) q
```

---

## K7. Parser 骨架

```haskell
parseExpr s =
  case parse s of
    Just (e, "") -> Just e
    _            -> Nothing

parse (c:cs)
  | isDigitChar c = Just (Val (read [c]), cs)

parse ('(':cs) =
  case parse cs of
    Just (e1, '+':rest1) ->
      case parse rest1 of
        Just (e2, ')':rest2) -> Just (Add e1 e2, rest2)
        _ -> Nothing
    _ -> Nothing
```

---

# 最可能命中的 30 个代码骨架

## 1. eval

```haskell
eval (Val n) = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Mul e1 e2) = eval e1 * eval e2
```

## 2. count

```haskell
count (Val _) = 1
count (Add e1 e2) = count e1 + count e2
count (Mul e1 e2) = count e1 + count e2
```

## 3. height

```haskell
height (Val _) = 0
height (Add e1 e2) = 1 + max (height e1) (height e2)
```

## 4. full show

```haskell
showExpr (Add e1 e2) =
  "(" ++ showExpr e1 ++ "+" ++ showExpr e2 ++ ")"
```

## 5. Maybe division

```haskell
case (eval e1, eval e2) of
  (Just _, Just 0) -> Nothing
  (Just x, Just y) -> Just (x `div` y)
  _ -> Nothing
```

## 6. Either error

```haskell
Left "Division by zero"
```

## 7. Add type check

```haskell
(Just (IVal x), Just (IVal y)) -> Just (IVal (x + y))
```

## 8. Bool type check

```haskell
(Just (BVal x), Just (BVal y)) -> Just (BVal (x && y))
```

## 9. If eval

```haskell
case eval cond of
  Just (BVal True) -> eval eThen
  Just (BVal False) -> eval eElse
  _ -> Nothing
```

## 10. Env lookup

```haskell
eval env (Var name) = env name
```

## 11. bind env

```haskell
bind env name value query
  | name == query = Just value
  | otherwise = env query
```

## 12. substitution

```haskell
subst name replacement (Var x)
  | name == x = replacement
  | otherwise = Var x
```

## 13. vars

```haskell
vars (Var x) = [x]
vars (Add e1 e2) = vars e1 ++ vars e2
```

## 14. mapExpr

```haskell
mapExpr f (Val n) = Val (f n)
```

## 15. simplify constant folding

```haskell
(Val x, Val y) -> Val (x + y)
```

## 16. algebraic simplification

```haskell
(Val 0, e) -> e
(e, Val 0) -> e
```

## 17. foldExpr

```haskell
foldExpr fVal fAdd fMul (Add e1 e2) =
  fAdd (foldExpr fVal fAdd fMul e1)
       (foldExpr fVal fAdd fMul e2)
```

## 18. eval with fold

```haskell
eval = foldExpr id (+) (*)
```

## 19. logical eval

```haskell
eval env (Implies e1 e2) =
  not (eval env e1) || eval env e2
```

## 20. remove implies

```haskell
Implies e1 e2 ->
  Or (Not e1) e2
```

## 21. De Morgan

```haskell
Not (And p q) ->
  Or (Not p) (Not q)
```

## 22. NNF double negation

```haskell
nnf (Not (Not e)) = nnf e
```

## 23. nandNot

```haskell
nandNot p = Nand p p
```

## 24. nandAnd

```haskell
nandAnd p q = nandNot (Nand p q)
```

## 25. nandOr

```haskell
nandOr p q = Nand (nandNot p) (nandNot q)
```

## 26. circuit Var

```haskell
circuit (Var c) = Input c
```

## 27. evalCircuit

```haskell
evalCircuit env (Nand c1 c2) =
  not (evalCircuit env c1 && evalCircuit env c2)
```

## 28. parse digit

```haskell
parse (c:cs)
  | c >= '0' && c <= '9' =
      Just (Val (read [c]), cs)
```

## 29. parse parenthesised

```haskell
parse ('(':cs) =
  case parse cs of
    Just (e1, '+':rest1) -> ...
```

## 30. Writer eval log

```haskell
evalLog (Val n) = do
  tell ["Value: " ++ show n]
  return n
```

