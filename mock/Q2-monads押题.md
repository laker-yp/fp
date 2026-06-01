# Question 2 Monad applyNTimes 超详细押题文件

> 主题：`applyNTimes :: Monad m => m a -> (a -> m a) -> Int -> m [a]`  
> 目标：专门押 **Monad 递归题、`do` 语法、`<-`、`return`、Maybe/IO/Writer/State 变体**  
> 风格：按命中率排序，A/B/C 大区，1/2/3 小节，主要给答案模板，少废话，考前可直接背。

---

# 目录

## A区：最高命中率原题区

- [A1. 原题 applyNTimes 标准答案](#a1-原题-applyntimes-标准答案)
- [A2. 原题执行流程：为什么打印 0 2 4 6，不打印 8](#a2-原题执行流程为什么打印-0-2-4-6不打印-8)
- [A3. 原题类型拆解：`mx`、`mf x`、`xs` 分别是什么](#a3-原题类型拆解mxmf-xxs-分别是什么)
- [A4. 原题最容易写错的版本](#a4-原题最容易写错的版本)
- [A5. 原题 helper 写法](#a5-原题-helper-写法)
- [A6. 原题 fmap / `<$>` 写法](#a6-原题-fmap--写法)
- [A7. 原题 foldM 写法，低频但可识别](#a7-原题-foldm-写法低频但可识别)

## B区：固定次数递归变体区

- [B1. collectN：参数顺序变化](#b1-collectn参数顺序变化)
- [B2. applyNTimesBefore：不包含最终值](#b2-applyntimesbefore不包含最终值)
- [B3. applyNTimesAfter：不包含初始值](#b3-applyntimesafter不包含初始值)
- [B4. applyNTimesLast：只返回最终值](#b4-applyntimeslast只返回最终值)
- [B5. applyNTimesPair：返回所有值和最终值](#b5-applyntimespair返回所有值和最终值)
- [B6. applyNTimesCount：返回执行次数和结果](#b6-applyntimescount返回执行次数和结果)
- [B7. applyNTimesWhile：固定次数但提前停止](#b7-applyntimeswhile固定次数但提前停止)

## C区：until / condition 条件停止区

- [C1. repeatUntil：直到满足条件，包含最后值](#c1-repeatuntil直到满足条件包含最后值)
- [C2. repeatBefore：直到满足条件，不包含最后值](#c2-repeatbefore直到满足条件不包含最后值)
- [C3. untilValue：只返回最终满足条件的值](#c3-untilvalue只返回最终满足条件的值)
- [C4. repeatWhile：只要条件成立就继续，包含失败前值](#c4-repeatwhile只要条件成立就继续包含失败前值)
- [C5. repeatWhileBefore：只收集满足条件的值](#c5-repeatwhilebefore只收集满足条件的值)
- [C6. repeatUntilLimit：条件停止 + 最大次数限制](#c6-repeatuntillimit条件停止--最大次数限制)
- [C7. repeatUntilEither：成功停止或错误停止](#c7-repeatuntileither成功停止或错误停止)

## D区：Maybe 高命中率偷袭区

- [D1. Maybe 版 applyNTimes](#d1-maybe-版-applyntimes)
- [D2. Maybe 版 repeatUntil](#d2-maybe-版-repeatuntil)
- [D3. Maybe 失败前返回普通 list](#d3-maybe-失败前返回普通-list)
- [D4. safeApplyNTimes：中途 Nothing 则失败](#d4-safeapplyntimes中途-nothing-则失败)
- [D5. takeUntilNothing：一直执行直到 Nothing](#d5-takeuntilnothing一直执行直到-nothing)
- [D6. Maybe + 条件 + 最大次数](#d6-maybe--条件--最大次数)
- [D7. Maybe 常见测试函数](#d7-maybe-常见测试函数)

## E区：IO 高命中率变体区

- [E1. readUntilStop：输入直到 stop](#e1-readuntilstop输入直到-stop)
- [E2. readNLines：读取 n 行](#e2-readnlines读取-n-行)
- [E3. readUntilEmpty：输入直到空行](#e3-readuntilempty输入直到空行)
- [E4. printApplyNTimes：每次打印当前值](#e4-printapplyntimes每次打印当前值)
- [E5. askUntilValid：直到输入满足条件](#e5-askuntilvalid直到输入满足条件)
- [E6. IO 中为什么最后值不打印](#e6-io-中为什么最后值不打印)
- [E7. IO 递归万能模板](#e7-io-递归万能模板)

## F区：Writer 押题区

- [F1. Writer 版 addAndLog](#f1-writer-版-addandlog)
- [F2. applyNTimes + Writer 原题套用](#f2-applyntimes--writer-原题套用)
- [F3. Writer 记录每次值](#f3-writer-记录每次值)
- [F4. Writer 记录执行次数](#f4-writer-记录执行次数)
- [F5. Writer + repeatUntil](#f5-writer--repeatuntil)
- [F6. Writer 易错点](#f6-writer-易错点)

## G区：State 押题区

- [G1. State 版 stepCount](#g1-state-版-stepcount)
- [G2. applyNTimes + State 原题套用](#g2-applyntimes--state-原题套用)
- [G3. State 版 repeatUntil](#g3-state-版-repeatuntil)
- [G4. State 中 get/put/modify 对应写法](#g4-state-中-getputmodify-对应写法)
- [G5. State 统计执行次数](#g5-state-统计执行次数)
- [G6. State 保存历史 list](#g6-state-保存历史-list)

## H区：Either / MonadError 偷袭区

- [H1. Either 版 applyNTimes](#h1-either-版-applyntimes)
- [H2. 遇到错误就停止](#h2-遇到错误就停止)
- [H3. MonadError 版 safeRepeat](#h3-monaderror-版-saferepeat)
- [H4. 除法 calculator 风格变体](#h4-除法-calculator-风格变体)
- [H5. Either 和 Maybe 区别](#h5-either-和-maybe-区别)

## I区：List Monad 偷袭区

- [I1. List Monad 版 applyNTimes](#i1-list-monad-版-applyntimes)
- [I2. 每一步多个可能结果](#i2-每一步多个可能结果)
- [I3. collectPaths 风格题](#i3-collectpaths-风格题)
- [I4. List Monad 易错点](#i4-list-monad-易错点)

## J区：考试易错点速查

- [J1. `return` 不是结束函数](#j1-return-不是结束函数)
- [J2. `x <- mx` 左右两边类型](#j2-x---mx-左右两边类型)
- [J3. 为什么递归结果要写 `xs <-`](#j3-为什么递归结果要写-xs--)
- [J4. 什么时候要 `else do`](#j4-什么时候要-else-do)
- [J5. base case 为什么是 `[x]`](#j5-base-case-为什么是-x)
- [J6. 为什么不能写 `mf mx`](#j6-为什么不能写-mf-mx)
- [J7. `return (x:xs)` 和 `x : return xs` 区别](#j7-return-xxs-和-x--return-xs-区别)
- [J8. 负数 n 怎么处理](#j8-负数-n-怎么处理)

## K区：考场万能模板区

- [K1. 固定次数 + 收集结果模板](#k1-固定次数--收集结果模板)
- [K2. 条件停止 + 包含最后值模板](#k2-条件停止--包含最后值模板)
- [K3. 条件停止 + 不包含最后值模板](#k3-条件停止--不包含最后值模板)
- [K4. 条件停止 + 只返回最终值模板](#k4-条件停止--只返回最终值模板)
- [K5. IO 输入递归模板](#k5-io-输入递归模板)
- [K6. Maybe 递归模板](#k6-maybe-递归模板)
- [K7. State 递归模板](#k7-state-递归模板)
- [K8. Writer 递归模板](#k8-writer-递归模板)

---

# A区：最高命中率原题区

## A1. 原题 applyNTimes 标准答案

```haskell
applyNTimes :: Monad m => m a -> (a -> m a) -> Int -> m [a]
applyNTimes mx mf 0 = do
  x <- mx
  return [x]

applyNTimes mx mf n = do
  x  <- mx
  xs <- applyNTimes (mf x) mf (n - 1)
  return (x : xs)
```

这是最应该背的版本。

---

## A2. 原题执行流程：为什么打印 0 2 4 6，不打印 8

```haskell
addAndPrint :: Int -> IO Int
addAndPrint n = do
  putStrLn $ "Intermediate value: " ++ show n
  return $ n + 2
```

运行：

```haskell
applyNTimes (return 0) addAndPrint 4
```

实际执行：

```haskell
x0 <- return 0       -- x0 = 0，不打印
x1 <- addAndPrint 0  -- 打印 0，返回 2
x2 <- addAndPrint 2  -- 打印 2，返回 4
x3 <- addAndPrint 4  -- 打印 4，返回 6
x4 <- addAndPrint 6  -- 打印 6，返回 8
```

返回：

```haskell
[0,2,4,6,8]
```

不会打印 `8`，因为没有执行：

```haskell
addAndPrint 8
```

---

## A3. 原题类型拆解：`mx`、`mf x`、`xs` 分别是什么

```haskell
mx :: m a
mf :: a -> m a
n  :: Int
```

进入 `do`：

```haskell
x <- mx
```

所以：

```haskell
x :: a
```

然后：

```haskell
mf x :: m a
```

递归调用：

```haskell
applyNTimes (mf x) mf (n - 1) :: m [a]
```

所以：

```haskell
xs <- applyNTimes (mf x) mf (n - 1)
```

此时：

```haskell
xs :: [a]
```

最后：

```haskell
x : xs :: [a]
return (x : xs) :: m [a]
```

---

## A4. 原题最容易写错的版本

错误 1：

```haskell
applyNTimes mx mf n = do
  x <- mx
  applyNTimes (mf x) mf (n - 1)
  return (x : xs)
```

错因：`xs` 没有定义。

正确：

```haskell
xs <- applyNTimes (mf x) mf (n - 1)
```

---

错误 2：

```haskell
applyNTimes mx mf 0 = return []
```

错因：原题要求有 `n + 1` 个值，所以 `n = 0` 时也要返回初始值。

正确：

```haskell
applyNTimes mx mf 0 = do
  x <- mx
  return [x]
```

---

错误 3：

```haskell
applyNTimes mx mf n = do
  x <- mx
  xs <- applyNTimes x mf (n - 1)
  return (x : xs)
```

错因：

```haskell
x :: a
```

但是 `applyNTimes` 第一个参数需要：

```haskell
m a
```

应该传：

```haskell
mf x :: m a
```

---

## A5. 原题 helper 写法

```haskell
applyNTimes :: Monad m => m a -> (a -> m a) -> Int -> m [a]
applyNTimes mx mf n = do
  x <- mx
  go x n
  where
    go x 0 = return [x]
    go x n = do
      y  <- mf x
      ys <- go y (n - 1)
      return (x : ys)
```

这个版本更像“普通递归”。

---

## A6. 原题 fmap / `<$>` 写法

```haskell
applyNTimes :: Monad m => m a -> (a -> m a) -> Int -> m [a]
applyNTimes mx mf 0 = do
  x <- mx
  return [x]

applyNTimes mx mf n = do
  x <- mx
  (x :) <$> applyNTimes (mf x) mf (n - 1)
```

等价于：

```haskell
do
  xs <- applyNTimes (mf x) mf (n - 1)
  return (x : xs)
```

不会写 `<$>` 没关系，考试最稳用 `do`。

---

## A7. 原题 foldM 写法，低频但可识别

```haskell
import Control.Monad

applyNTimes :: Monad m => m a -> (a -> m a) -> Int -> m [a]
applyNTimes mx mf n = do
  x <- mx
  foldM step [x] [1..n]
  where
    step xs _ = do
      y <- mf (last xs)
      return (xs ++ [y])
```

这个不推荐考场写，因为 `last` 和 `++` 不够优雅，但可以识别。

---

# B区：固定次数递归变体区

## B1. collectN：参数顺序变化

```haskell
collectN :: Monad m => Int -> m a -> (a -> m a) -> m [a]
collectN 0 mx mf = do
  x <- mx
  return [x]

collectN n mx mf = do
  x  <- mx
  xs <- collectN (n - 1) (mf x) mf
  return (x : xs)
```

---

## B2. applyNTimesBefore：不包含最终值

执行 `mf` n 次，但结果只包含前 n 个值，不包含最后输出。

```haskell
applyNTimesBefore :: Monad m => m a -> (a -> m a) -> Int -> m [a]
applyNTimesBefore mx mf 0 = return []

applyNTimesBefore mx mf n = do
  x  <- mx
  xs <- applyNTimesBefore (mf x) mf (n - 1)
  return (x : xs)
```

例子从 0 开始加 2，n=4：

```haskell
[0,2,4,6]
```

---

## B3. applyNTimesAfter：不包含初始值

```haskell
applyNTimesAfter :: Monad m => m a -> (a -> m a) -> Int -> m [a]
applyNTimesAfter mx mf 0 = return []

applyNTimesAfter mx mf n = do
  x  <- mx
  y  <- mf x
  ys <- applyNTimesAfter (return y) mf (n - 1)
  return (y : ys)
```

例子从 0 开始加 2，n=4：

```haskell
[2,4,6,8]
```

---

## B4. applyNTimesLast：只返回最终值

```haskell
applyNTimesLast :: Monad m => m a -> (a -> m a) -> Int -> m a
applyNTimesLast mx mf 0 = mx

applyNTimesLast mx mf n = do
  x <- mx
  applyNTimesLast (mf x) mf (n - 1)
```

或者：

```haskell
applyNTimesLast :: Monad m => m a -> (a -> m a) -> Int -> m a
applyNTimesLast mx mf 0 = mx
applyNTimesLast mx mf n = mx >>= \x -> applyNTimesLast (mf x) mf (n - 1)
```

---

## B5. applyNTimesPair：返回所有值和最终值

```haskell
applyNTimesPair :: Monad m => m a -> (a -> m a) -> Int -> m ([a], a)
applyNTimesPair mx mf n = do
  xs <- applyNTimes mx mf n
  return (xs, last xs)
```

更安全但稍长：

```haskell
applyNTimesPair :: Monad m => m a -> (a -> m a) -> Int -> m ([a], a)
applyNTimesPair mx mf 0 = do
  x <- mx
  return ([x], x)

applyNTimesPair mx mf n = do
  x       <- mx
  (xs, y) <- applyNTimesPair (mf x) mf (n - 1)
  return (x : xs, y)
```

---

## B6. applyNTimesCount：返回执行次数和结果

```haskell
applyNTimesCount :: Monad m => m a -> (a -> m a) -> Int -> m (Int, [a])
applyNTimesCount mx mf n = do
  xs <- applyNTimes mx mf n
  return (n, xs)
```

如果要求“实际执行 mf 的次数”，就是 `n`。

如果要求“结果 list 长度”，就是 `n + 1`。

---

## B7. applyNTimesWhile：固定次数但提前停止

```haskell
applyNTimesWhile :: Monad m => m a -> (a -> Bool) -> (a -> m a) -> Int -> m [a]
applyNTimesWhile mx p mf 0 = do
  x <- mx
  return [x]

applyNTimesWhile mx p mf n = do
  x <- mx
  if p x
    then return [x]
    else do
      xs <- applyNTimesWhile (mf x) p mf (n - 1)
      return (x : xs)
```

意思：最多做 n 次，但如果 `p x` 提前成立，就停止。

---

# C区：until / condition 条件停止区

## C1. repeatUntil：直到满足条件，包含最后值

```haskell
repeatUntil :: Monad m => m a -> (a -> Bool) -> (a -> m a) -> m [a]
repeatUntil mx p mf = do
  x <- mx
  if p x
    then return [x]
    else do
      xs <- repeatUntil (mf x) p mf
      return (x : xs)
```

---

## C2. repeatBefore：直到满足条件，不包含最后值

```haskell
repeatBefore :: Monad m => m a -> (a -> Bool) -> (a -> m a) -> m [a]
repeatBefore mx p mf = do
  x <- mx
  if p x
    then return []
    else do
      xs <- repeatBefore (mf x) p mf
      return (x : xs)
```

---

## C3. untilValue：只返回最终满足条件的值

```haskell
untilValue :: Monad m => m a -> (a -> Bool) -> (a -> m a) -> m a
untilValue mx p mf = do
  x <- mx
  if p x
    then return x
    else untilValue (mf x) p mf
```

这里 `else` 后面不用 `do`，因为没有：

```haskell
xs <- ...
return ...
```

---

## C4. repeatWhile：只要条件成立就继续，包含失败前值

```haskell
repeatWhile :: Monad m => m a -> (a -> Bool) -> (a -> m a) -> m [a]
repeatWhile mx p mf = do
  x <- mx
  if p x
    then do
      xs <- repeatWhile (mf x) p mf
      return (x : xs)
    else return [x]
```

这题和 `repeatUntil` 条件方向相反。

---

## C5. repeatWhileBefore：只收集满足条件的值

```haskell
repeatWhileBefore :: Monad m => m a -> (a -> Bool) -> (a -> m a) -> m [a]
repeatWhileBefore mx p mf = do
  x <- mx
  if p x
    then do
      xs <- repeatWhileBefore (mf x) p mf
      return (x : xs)
    else return []
```

---

## C6. repeatUntilLimit：条件停止 + 最大次数限制

```haskell
repeatUntilLimit :: Monad m => Int -> m a -> (a -> Bool) -> (a -> m a) -> m [a]
repeatUntilLimit 0 mx p mf = do
  x <- mx
  return [x]

repeatUntilLimit n mx p mf = do
  x <- mx
  if p x
    then return [x]
    else do
      xs <- repeatUntilLimit (n - 1) (mf x) p mf
      return (x : xs)
```

---

## C7. repeatUntilEither：成功停止或错误停止

```haskell
repeatUntilEither :: Monad m => m a -> (a -> Either String Bool) -> (a -> m a) -> m (Either String [a])
repeatUntilEither mx p mf = do
  x <- mx
  case p x of
    Left err -> return (Left err)
    Right True -> return (Right [x])
    Right False -> do
      r <- repeatUntilEither (mf x) p mf
      case r of
        Left err -> return (Left err)
        Right xs -> return (Right (x : xs))
```

低频，但可能作为 `case + monad` 综合题出现。

---

# D区：Maybe 高命中率偷袭区

## D1. Maybe 版 applyNTimes

```haskell
applyNTimesMaybe :: Maybe a -> (a -> Maybe a) -> Int -> Maybe [a]
applyNTimesMaybe mx mf 0 = do
  x <- mx
  return [x]

applyNTimesMaybe mx mf n = do
  x  <- mx
  xs <- applyNTimesMaybe (mf x) mf (n - 1)
  return (x : xs)
```

其实就是原题把 `m` 固定成 `Maybe`。

---

## D2. Maybe 版 repeatUntil

```haskell
repeatUntilMaybe :: Maybe a -> (a -> Bool) -> (a -> Maybe a) -> Maybe [a]
repeatUntilMaybe mx p mf = do
  x <- mx
  if p x
    then return [x]
    else do
      xs <- repeatUntilMaybe (mf x) p mf
      return (x : xs)
```

中途 `Nothing`，整体就是 `Nothing`。

---

## D3. Maybe 失败前返回普通 list

```haskell
repeatMaybe :: Maybe a -> (a -> Maybe a) -> [a]
repeatMaybe Nothing mf = []

repeatMaybe (Just x) mf =
  x : repeatMaybe (mf x) mf
```

注意返回类型是普通 list：

```haskell
[a]
```

不是：

```haskell
Maybe [a]
```

所以不需要 `do`。

---

## D4. safeApplyNTimes：中途 Nothing 则失败

```haskell
safeApplyNTimes :: Maybe a -> (a -> Maybe a) -> Int -> Maybe [a]
safeApplyNTimes mx mf 0 = do
  x <- mx
  return [x]

safeApplyNTimes mx mf n = do
  x  <- mx
  xs <- safeApplyNTimes (mf x) mf (n - 1)
  return (x : xs)
```

和 D1 一样，只是题目名字可能不同。

---

## D5. takeUntilNothing：一直执行直到 Nothing

```haskell
takeUntilNothing :: Maybe a -> (a -> Maybe a) -> [a]
takeUntilNothing Nothing mf = []

takeUntilNothing (Just x) mf =
  x : takeUntilNothing (mf x) mf
```

---

## D6. Maybe + 条件 + 最大次数

```haskell
maybeUntilLimit :: Int -> Maybe a -> (a -> Bool) -> (a -> Maybe a) -> Maybe [a]
maybeUntilLimit 0 mx p mf = do
  x <- mx
  return [x]

maybeUntilLimit n mx p mf = do
  x <- mx
  if p x
    then return [x]
    else do
      xs <- maybeUntilLimit (n - 1) (mf x) p mf
      return (x : xs)
```

---

## D7. Maybe 常见测试函数

```haskell
nextMaybe :: Int -> Maybe Int
nextMaybe x
  | x >= 10   = Nothing
  | otherwise = Just (x + 2)
```

```haskell
repeatUntilMaybe (Just 0) (>= 6) nextMaybe
-- Just [0,2,4,6]
```

```haskell
repeatUntilMaybe (Just 0) (>= 12) nextMaybe
-- Nothing
```

---

# E区：IO 高命中率变体区

## E1. readUntilStop：输入直到 stop

```haskell
readUntilStop :: IO [String]
readUntilStop = do
  line <- getLine
  if line == "stop"
    then return []
    else do
      xs <- readUntilStop
      return (line : xs)
```

---

## E2. readNLines：读取 n 行

```haskell
readNLines :: Int -> IO [String]
readNLines 0 = return []

readNLines n = do
  line <- getLine
  xs <- readNLines (n - 1)
  return (line : xs)
```

---

## E3. readUntilEmpty：输入直到空行

```haskell
readUntilEmpty :: IO [String]
readUntilEmpty = do
  line <- getLine
  if line == ""
    then return []
    else do
      xs <- readUntilEmpty
      return (line : xs)
```

---

## E4. printApplyNTimes：每次打印当前值

```haskell
printApplyNTimes :: Show a => a -> (a -> a) -> Int -> IO [a]
printApplyNTimes x f 0 = do
  print x
  return [x]

printApplyNTimes x f n = do
  print x
  xs <- printApplyNTimes (f x) f (n - 1)
  return (x : xs)
```

---

## E5. askUntilValid：直到输入满足条件

```haskell
askUntilValid :: (String -> Bool) -> IO String
askUntilValid p = do
  line <- getLine
  if p line
    then return line
    else askUntilValid p
```

如果要保存所有输入：

```haskell
askUntilValidList :: (String -> Bool) -> IO [String]
askUntilValidList p = do
  line <- getLine
  if p line
    then return [line]
    else do
      xs <- askUntilValidList p
      return (line : xs)
```

---

## E6. IO 中为什么最后值不打印

如果函数是：

```haskell
addAndPrint n = do
  print n
  return (n + 2)
```

它打印的是输入 `n`，不是返回值 `n + 2`。

所以最后一次：

```haskell
addAndPrint 6
```

打印：

```haskell
6
```

返回：

```haskell
8
```

但没有下一次：

```haskell
addAndPrint 8
```

所以不打印 8。

---

## E7. IO 递归万能模板

```haskell
ioLoop :: IO [a]
ioLoop = do
  x <- someIOAction
  if stopCondition x
    then return []
    else do
      xs <- ioLoop
      return (x : xs)
```

---

# F区：Writer 押题区

## F1. Writer 版 addAndLog

```haskell
import Control.Monad.Writer

addAndLog :: Int -> Writer [String] Int
addAndLog n = do
  tell ["Intermediate value: " ++ show n]
  return (n + 2)
```

---

## F2. applyNTimes + Writer 原题套用

```haskell
runWriter (applyNTimes (return 0) addAndLog 4)
```

结果：

```haskell
([0,2,4,6,8],
 ["Intermediate value: 0",
  "Intermediate value: 2",
  "Intermediate value: 4",
  "Intermediate value: 6"])
```

---

## F3. Writer 记录每次值

```haskell
logValues :: Show a => a -> (a -> a) -> Int -> Writer [String] [a]
logValues x f 0 = do
  tell ["Value: " ++ show x]
  return [x]

logValues x f n = do
  tell ["Value: " ++ show x]
  xs <- logValues (f x) f (n - 1)
  return (x : xs)
```

---

## F4. Writer 记录执行次数

```haskell
countLog :: a -> Writer [String] a
countLog x = do
  tell ["Step executed"]
  return x
```

配合：

```haskell
applyNTimes (return 0) (\x -> countLog (x + 1)) 3
```

会记录 3 次 `Step executed`，不是 4 次。

---

## F5. Writer + repeatUntil

```haskell
repeatUntilWriter :: (Show a) => a -> (a -> Bool) -> (a -> a) -> Writer [String] [a]
repeatUntilWriter x p f = do
  tell ["Current: " ++ show x]
  if p x
    then return [x]
    else do
      xs <- repeatUntilWriter (f x) p f
      return (x : xs)
```

---

## F6. Writer 易错点

`Writer` 里面：

```haskell
tell ["log"]
```

只记录信息，不产生普通值。

如果要返回结果，仍然要：

```haskell
return value
```

---

# G区：State 押题区

## G1. State 版 stepCount

```haskell
import Control.Monad.State

stepCount :: Int -> State Int Int
stepCount x = do
  modify (+1)
  return (x + 2)
```

---

## G2. applyNTimes + State 原题套用

```haskell
runState (applyNTimes (return 0) stepCount 4) 0
```

结果：

```haskell
([0,2,4,6,8],4)
```

解释：

- list 有 5 个值
- `mf` 执行 4 次
- state 从 0 加到 4

---

## G3. State 版 repeatUntil

```haskell
repeatUntilState :: State Int [Int]
repeatUntilState = repeatUntil get (>= 5) next
  where
    next x = do
      put (x + 1)
      get
```

运行：

```haskell
runState repeatUntilState 1
```

结果：

```haskell
([1,2,3,4,5],5)
```

---

## G4. State 中 get/put/modify 对应写法

```haskell
get    :: State s s
put    :: s -> State s ()
modify :: (s -> s) -> State s ()
```

常见写法：

```haskell
do
  x <- get
  put (x + 1)
```

等价于：

```haskell
modify (+1)
```

---

## G5. State 统计执行次数

```haskell
countStep :: a -> State Int a
countStep x = do
  modify (+1)
  return x
```

如果：

```haskell
applyNTimes (return 10) (\x -> countStep (x + 1)) 5
```

最终 state 是：

```haskell
5
```

因为 `mf` 执行 5 次。

---

## G6. State 保存历史 list

```haskell
recordStep :: Int -> State [Int] Int
recordStep x = do
  modify (++ [x])
  return (x + 1)
```

运行：

```haskell
runState (applyNTimes (return 0) recordStep 4) []
```

结果中 state 记录的是被传入 `recordStep` 的值：

```haskell
[0,1,2,3]
```

不是 `[0,1,2,3,4]`。

原因同原题：最后值 `4` 是返回值，没有再传入 `recordStep`。

---

# H区：Either / MonadError 偷袭区

## H1. Either 版 applyNTimes

```haskell
applyNTimesEither :: Either String a -> (a -> Either String a) -> Int -> Either String [a]
applyNTimesEither mx mf 0 = do
  x <- mx
  return [x]

applyNTimesEither mx mf n = do
  x  <- mx
  xs <- applyNTimesEither (mf x) mf (n - 1)
  return (x : xs)
```

---

## H2. 遇到错误就停止

```haskell
safeNext :: Int -> Either String Int
safeNext x
  | x >= 10   = Left "too large"
  | otherwise = Right (x + 2)
```

```haskell
applyNTimesEither (Right 0) safeNext 4
-- Right [0,2,4,6,8]
```

```haskell
applyNTimesEither (Right 0) safeNext 6
-- Left "too large"
```

---

## H3. MonadError 版 safeRepeat

```haskell
import Control.Monad.Except

safeRepeat :: MonadError String m => a -> (a -> Bool) -> (a -> m a) -> m [a]
safeRepeat x p mf =
  if p x
    then return [x]
    else do
      y  <- mf x
      ys <- safeRepeat y p mf
      return (x : ys)
```

---

## H4. 除法 calculator 风格变体

```haskell
safeDivStep :: MonadError String m => Int -> Int -> m Int
safeDivStep x n
  | n == 0    = throwError "Division by zero"
  | otherwise = return (x `div` n)
```

如果题目把 `mf` 写成可能报错的函数，就用 `do` 串起来。

---

## H5. Either 和 Maybe 区别

```haskell
Maybe a
```

失败时只有：

```haskell
Nothing
```

```haskell
Either String a
```

失败时可以有错误信息：

```haskell
Left "error message"
```

---

# I区：List Monad 偷袭区

## I1. List Monad 版 applyNTimes

原题本身支持 list monad：

```haskell
applyNTimes [0] (\x -> [x + 1, x + 2]) 2
```

会产生多种可能结果。

---

## I2. 每一步多个可能结果

```haskell
nextList :: Int -> [Int]
nextList x = [x + 1, x + 2]
```

```haskell
applyNTimes [0] nextList 2
```

结果会是多条路径组成的结果 list。

理解重点：

- `[]` 作为 monad 表示“多个可能”
- `<-` 会枚举每个可能值

---

## I3. collectPaths 风格题

```haskell
collectPaths :: Monad m => m a -> (a -> m a) -> Int -> m [a]
collectPaths mx mf 0 = do
  x <- mx
  return [x]

collectPaths mx mf n = do
  x  <- mx
  xs <- collectPaths (mf x) mf (n - 1)
  return (x : xs)
```

其实就是换名字的 `applyNTimes`。

---

## I4. List Monad 易错点

在 list monad 中：

```haskell
x <- [1,2,3]
```

意思不是“取出一个固定 x”，而是枚举：

```haskell
x = 1
x = 2
x = 3
```

---

# J区：考试易错点速查

## J1. `return` 不是结束函数

Haskell 里：

```haskell
return x
```

意思是把普通值放进 monad。

例如：

```haskell
return 3 :: Maybe Int
-- Just 3
```

```haskell
return 3 :: IO Int
-- 一个返回 3 的 IO action
```

---

## J2. `x <- mx` 左右两边类型

如果：

```haskell
mx :: m a
```

那么：

```haskell
x <- mx
```

得到：

```haskell
x :: a
```

`<-` 左边永远是“脱掉一层 monad 后的普通值”。

---

## J3. 为什么递归结果要写 `xs <-`

因为：

```haskell
applyNTimes (mf x) mf (n - 1) :: m [a]
```

你想拿到里面的：

```haskell
xs :: [a]
```

就必须写：

```haskell
xs <- applyNTimes (mf x) mf (n - 1)
```

---

## J4. 什么时候要 `else do`

需要在 `else` 里执行多步时：

```haskell
else do
  xs <- ...
  return ...
```

如果 `else` 只是直接返回一个 monadic action：

```haskell
else untilValue (mf x) p mf
```

就不需要 `do`。

---

## J5. base case 为什么是 `[x]`

原题要求：

```haskell
n + 1
```

个值。

所以：

```haskell
n = 0
```

时也要返回一个值：

```haskell
[x]
```

---

## J6. 为什么不能写 `mf mx`

因为：

```haskell
mf :: a -> m a
mx :: m a
```

`mf` 需要普通值 `a`，不是 `m a`。

必须先：

```haskell
x <- mx
```

再：

```haskell
mf x
```

---

## J7. `return (x:xs)` 和 `x : return xs` 区别

正确：

```haskell
return (x : xs)
```

因为：

```haskell
x : xs :: [a]
return (x : xs) :: m [a]
```

错误：

```haskell
x : return xs
```

因为：

```haskell
return xs :: m [a]
```

不是 list，不能用 `(:)` 拼。

---

## J8. 负数 n 怎么处理

题目说：

```haskell
non-negative integer n
```

所以不用处理负数。

如果想防御性写法：

```haskell
applyNTimes mx mf n
  | n <= 0 = do
      x <- mx
      return [x]
  | otherwise = do
      x  <- mx
      xs <- applyNTimes (mf x) mf (n - 1)
      return (x : xs)
```

但考试中按题意写 `0` base case 就够。

---

# K区：考场万能模板区

## K1. 固定次数 + 收集结果模板

```haskell
f mx mf 0 = do
  x <- mx
  return [x]

f mx mf n = do
  x  <- mx
  xs <- f (mf x) mf (n - 1)
  return (x : xs)
```

---

## K2. 条件停止 + 包含最后值模板

```haskell
f mx p mf = do
  x <- mx
  if p x
    then return [x]
    else do
      xs <- f (mf x) p mf
      return (x : xs)
```

---

## K3. 条件停止 + 不包含最后值模板

```haskell
f mx p mf = do
  x <- mx
  if p x
    then return []
    else do
      xs <- f (mf x) p mf
      return (x : xs)
```

---

## K4. 条件停止 + 只返回最终值模板

```haskell
f mx p mf = do
  x <- mx
  if p x
    then return x
    else f (mf x) p mf
```

---

## K5. IO 输入递归模板

```haskell
f = do
  x <- getLine
  if stop x
    then return []
    else do
      xs <- f
      return (x : xs)
```

---

## K6. Maybe 递归模板

```haskell
f Nothing mf = []

f (Just x) mf =
  x : f (mf x) mf
```

如果返回 `Maybe [a]`：

```haskell
f mx mf = do
  x <- mx
  xs <- f (mf x) mf
  return (x : xs)
```

注意第二个版本必须有停止条件，不然会无限递归。

---

## K7. State 递归模板

```haskell
f 0 = do
  s <- get
  return [s]

f n = do
  s <- get
  modify step
  xs <- f (n - 1)
  return (s : xs)
```

---

## K8. Writer 递归模板

```haskell
f x 0 = do
  tell ["Value: " ++ show x]
  return [x]

f x n = do
  tell ["Value: " ++ show x]
  xs <- f (step x) (n - 1)
  return (x : xs)
```

---

# 最终背诵版

## 原题必背

```haskell
applyNTimes :: Monad m => m a -> (a -> m a) -> Int -> m [a]
applyNTimes mx mf 0 = do
  x <- mx
  return [x]

applyNTimes mx mf n = do
  x  <- mx
  xs <- applyNTimes (mf x) mf (n - 1)
  return (x : xs)
```

---

## 条件停止必背

```haskell
repeatUntil :: Monad m => m a -> (a -> Bool) -> (a -> m a) -> m [a]
repeatUntil mx p mf = do
  x <- mx
  if p x
    then return [x]
    else do
      xs <- repeatUntil (mf x) p mf
      return (x : xs)
```

---

## 最核心一句话

> 看到 `m a`，先用 `<-` 拿出 `a`；  
> 看到递归结果是 `m [a]`，就用 `xs <- ...` 拿出 `[a]`；  
> 想保存当前结果，就写 `return (x : xs)`。
