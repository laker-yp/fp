# Haskell Mock Q4 全面押题加强版：Magic Square / Matrix / Board / Maybe / Recursion

## 使用说明

这份是围绕 Mock Question 4：`isMagicSquare :: [[Int]] -> Bool` 的全面押题版。

特点：

- 按照命中率从高到低排序
- 覆盖二维列表、矩阵、棋盘、对角线、Maybe/Either、安全索引、递归、fold、list comprehension
- 每题只给标题和答案为主
- 不写长解析
- 适合考前直接背模板

---

## 目录

- [第一部分：最高命中率 Magic Square 原题与直接变体](#第一部分最高命中率-magic-square-原题与直接变体)
  - [1. isMagicSquare 标准版](#1-ismagicsquare-标准版)
  - [2. isMagicSquare 笨方法版](#2-ismagicsquare-笨方法版)
  - [3. isMagicSquare 使用 transpose 版](#3-ismagicsquare-使用-transpose-版)
  - [4. magicSum 返回 magic square 的公共和](#4-magicsum-返回-magic-square-的公共和)
  - [5. isMagicSquareMaybe 返回 Maybe Int](#5-ismagicsquaremaybe-返回-maybe-int)
  - [6. isMagicSquareEither 返回错误信息](#6-ismagicsquareeither-返回错误信息)
  - [7. allSame 判断列表元素是否全部相同](#7-allsame-判断列表元素是否全部相同)
  - [8. allSumsSame 判断多个列表的 sum 是否相同](#8-allsumssame-判断多个列表的-sum-是否相同)
  - [9. allLines 取所有行列和对角线](#9-alllines-取所有行列和对角线)
  - [10. magicSquareLines 只返回所有需要检查的线](#10-magicsquarelines-只返回所有需要检查的线)

- [第二部分：二维列表 / 矩阵基础高频题](#第二部分二维列表--矩阵基础高频题)
  - [11. isSquare 判断是否是正方形矩阵](#11-issquare-判断是否是正方形矩阵)
  - [12. numRows 返回行数](#12-numrows-返回行数)
  - [13. numCols 返回列数](#13-numcols-返回列数)
  - [14. getRow 取第 i 行](#14-getrow-取第-i-行)
  - [15. getColumn 取第 j 列](#15-getcolumn-取第-j-列)
  - [16. transpose 矩阵转置](#16-transpose-矩阵转置)
  - [17. transpose 递归版](#17-transpose-递归版)
  - [18. rowSums 所有行的和](#18-rowsums-所有行的和)
  - [19. colSums 所有列的和](#19-colsums-所有列的和)
  - [20. diagonal 取主对角线](#20-diagonal-取主对角线)
  - [21. antiDiagonal 取副对角线](#21-antidiagonal-取副对角线)
  - [22. diagonalSums 返回两条对角线的和](#22-diagonalsums-返回两条对角线的和)
  - [23. flatten 二维列表展开](#23-flatten-二维列表展开)
  - [24. matrixSum 矩阵所有元素求和](#24-matrixsum-矩阵所有元素求和)
  - [25. matrixSize 返回矩阵尺寸](#25-matrixsize-返回矩阵尺寸)

- [第三部分：List Comprehension 押题模板](#第三部分list-comprehension-押题模板)
  - [26. positions 返回所有坐标](#26-positions-返回所有坐标)
  - [27. valuesWithPositions 返回坐标和值](#27-valueswithpositions-返回坐标和值)
  - [28. findValue 找出某个值的所有坐标](#28-findvalue-找出某个值的所有坐标)
  - [29. greaterThanPositions 找出大于 target 的坐标](#29-greaterthanpositions-找出大于-target-的坐标)
  - [30. evenValues 返回矩阵中所有偶数](#30-evenvalues-返回矩阵中所有偶数)
  - [31. countValue 统计某个值出现次数](#31-countvalue-统计某个值出现次数)
  - [32. replaceAt 替换一维列表某个位置](#32-replaceat-替换一维列表某个位置)
  - [33. updateGrid 更新二维矩阵某个位置](#33-updategrid-更新二维矩阵某个位置)
  - [34. removeRow 删除一行](#34-removerow-删除一行)
  - [35. removeCol 删除一列](#35-removecol-删除一列)

- [第四部分：Tic-Tac-Toe / Board 棋盘类高频变体](#第四部分tic-tac-toe--board-棋盘类高频变体)
  - [36. hasWon 判断玩家是否赢](#36-haswon-判断玩家是否赢)
  - [37. winner 返回赢家 Maybe Char](#37-winner-返回赢家-maybe-char)
  - [38. boardFull 判断棋盘是否满](#38-boardfull-判断棋盘是否满)
  - [39. gameOver 判断井字棋是否结束](#39-gameover-判断井字棋是否结束)
  - [40. validBoard 判断棋盘只含指定字符](#40-validboard-判断棋盘只含指定字符)
  - [41. countPlayer 统计棋子数量](#41-countplayer-统计棋子数量)
  - [42. nextPlayer 判断下一步是谁走](#42-nextplayer-判断下一步是谁走)
  - [43. emptyPositions 找出空位](#43-emptypositions-找出空位)
  - [44. makeMove 落子](#44-makemove-落子)
  - [45. winningLines 返回所有获胜线](#45-winninglines-返回所有获胜线)

- [第五部分：Maybe / Either 安全索引与安全矩阵](#第五部分maybe--either-安全索引与安全矩阵)
  - [46. safeIndex 安全取下标](#46-safeindex-安全取下标)
  - [47. safeGet2D 安全取二维坐标](#47-safeget2d-安全取二维坐标)
  - [48. safeRow 安全取行](#48-saferow-安全取行)
  - [49. safeColumn 安全取列](#49-safecolumn-安全取列)
  - [50. safeDiagonal 安全取主对角线](#50-safediagonal-安全取主对角线)
  - [51. safeAntiDiagonal 安全取副对角线](#51-safeantidiagonal-安全取副对角线)
  - [52. safeTranspose 安全转置](#52-safetranspose-安全转置)
  - [53. safeIsSquare](#53-safeissquare)
  - [54. safeUpdateGrid](#54-safeupdategrid)
  - [55. Either 版本 safeGet2D](#55-either-版本-safeget2d)

- [第六部分：递归 / fold / map / filter 版本押题](#第六部分递归--fold--map--filter-版本押题)
  - [56. allEqual 递归版](#56-allequal-递归版)
  - [57. allEqual foldr 版](#57-allequal-foldr-版)
  - [58. rowSums 递归版](#58-rowsums-递归版)
  - [59. flatten 递归版](#59-flatten-递归版)
  - [60. flatten foldr 版](#60-flatten-foldr-版)
  - [61. matrixMap](#61-matrixmap)
  - [62. matrixFilter](#62-matrixfilter)
  - [63. countIf](#63-countif)
  - [64. anyRow](#64-anyrow)
  - [65. allRows](#65-allrows)

- [第七部分：数据类型版本押题](#第七部分数据类型版本押题)
  - [66. 自定义 Cell 类型](#66-自定义-cell-类型)
  - [67. 自定义 Player 类型](#67-自定义-player-类型)
  - [68. hasWon 使用 Player 类型](#68-haswon-使用-player-类型)
  - [69. Move 类型](#69-move-类型)
  - [70. makeMove 使用 Move 类型](#70-makemove-使用-move-类型)

- [第八部分：更难矩阵扩展题](#第八部分更难矩阵扩展题)
  - [71. symmetric 判断矩阵是否对称](#71-symmetric-判断矩阵是否对称)
  - [72. rotate90 顺时针旋转矩阵](#72-rotate90-顺时针旋转矩阵)
  - [73. rotate180 旋转 180 度](#73-rotate180-旋转-180-度)
  - [74. reverseRows 每一行反转](#74-reverserows-每一行反转)
  - [75. reverseCols 行顺序反转](#75-reversecols-行顺序反转)
  - [76. addMatrices 矩阵加法](#76-addmatrices-矩阵加法)
  - [77. scalarMultiply 矩阵乘常数](#77-scalarmultiply-矩阵乘常数)
  - [78. dotProduct 点积](#78-dotproduct-点积)
  - [79. matrixMultiply 矩阵乘法](#79-matrixmultiply-矩阵乘法)
  - [80. identity 生成单位矩阵](#80-identity-生成单位矩阵)

- [第九部分：Latin Square / Sudoku / Grid Validity 扩展押题](#第九部分latin-square--sudoku--grid-validity-扩展押题)
  - [81. sameElements 判断两个列表元素集合相同](#81-sameelements-判断两个列表元素集合相同)
  - [82. noDuplicates 判断没有重复元素](#82-noduplicates-判断没有重复元素)
  - [83. isLatinSquare](#83-islatinsquare)
  - [84. validSudokuRow](#84-validsudokurow)
  - [85. chunksOf 分组](#85-chunksof-分组)
  - [86. boxes 取 Sudoku 九宫格](#86-boxes-取-sudoku-九宫格)
  - [87. validSudoku 简化版](#87-validsudoku-简化版)

- [第十部分：考试常见坑题与模板](#第十部分考试常见坑题与模板)
  - [88. 防止空列表 head 报错版本](#88-防止空列表-head-报错版本)
  - [89. 判断每一行长度相同](#89-判断每一行长度相同)
  - [90. 判断矩阵是否合法](#90-判断矩阵是否合法)
  - [91. isMagicSquare 完整防御版](#91-ismagicsquare-完整防御版)
  - [92. 不用 list comprehension 的 isMagicSquare](#92-不用-list-comprehension-的-ismagicsquare)
  - [93. 使用 import Data.List 的版本](#93-使用-import-datalist-的版本)
  - [94. 不使用 import 的版本](#94-不使用-import-的版本)
  - [95. 最后必背模板](#95-最后必背模板)

---

# 第一部分：最高命中率 Magic Square 原题与直接变体

## 1. isMagicSquare 标准版

```haskell
isMagicSquare :: [[Int]] -> Bool
isMagicSquare xs = all (== target) sums
  where
    n = length xs
    target = sum (head xs)

    rows = xs
    cols = [[ row !! i | row <- xs ] | i <- [0..n-1]]
    diag1 = [ xs !! i !! i | i <- [0..n-1]]
    diag2 = [ xs !! i !! (n - 1 - i) | i <- [0..n-1]]

    sums = map sum (rows ++ cols ++ [diag1, diag2])
```

---

## 2. isMagicSquare 笨方法版

```haskell
isMagicSquare :: [[Int]] -> Bool
isMagicSquare square =
  rowsOK && colsOK && diag1OK && diag2OK
  where
    n = length square
    target = sum (head square)

    rowsOK =
      all (\row -> sum row == target) square

    colsOK =
      all (\i -> sum [ row !! i | row <- square ] == target) [0..n-1]

    diag1OK =
      sum [ square !! i !! i | i <- [0..n-1] ] == target

    diag2OK =
      sum [ square !! i !! (n - 1 - i) | i <- [0..n-1] ] == target
```

---

## 3. isMagicSquare 使用 transpose 版

```haskell
transpose :: [[a]] -> [[a]]
transpose xs = [[ row !! i | row <- xs ] | i <- [0..n-1]]
  where
    n = length (head xs)

isMagicSquare :: [[Int]] -> Bool
isMagicSquare xs =
  all (== target) (map sum allLines)
  where
    n = length xs
    target = sum (head xs)

    diag1 = [ xs !! i !! i | i <- [0..n-1]]
    diag2 = [ xs !! i !! (n - 1 - i) | i <- [0..n-1]]

    allLines = xs ++ transpose xs ++ [diag1, diag2]
```

---

## 4. magicSum 返回 magic square 的公共和

```haskell
magicSum :: [[Int]] -> Int
magicSum xs = sum (head xs)
```

---

## 5. isMagicSquareMaybe 返回 Maybe Int

```haskell
isMagicSquareMaybe :: [[Int]] -> Maybe Int
isMagicSquareMaybe xs
  | isMagicSquare xs = Just (sum (head xs))
  | otherwise        = Nothing
```

---

## 6. isMagicSquareEither 返回错误信息

```haskell
isMagicSquareEither :: [[Int]] -> Either String Int
isMagicSquareEither [] = Left "empty grid"
isMagicSquareEither xs
  | not (isSquare xs)   = Left "not a square"
  | isMagicSquare xs    = Right (sum (head xs))
  | otherwise           = Left "not a magic square"
```

---

## 7. allSame 判断列表元素是否全部相同

```haskell
allSame :: Eq a => [a] -> Bool
allSame [] = True
allSame (x:xs) = all (== x) xs
```

---

## 8. allSumsSame 判断多个列表的 sum 是否相同

```haskell
allSumsSame :: [[Int]] -> Bool
allSumsSame [] = True
allSumsSame xss = allSame (map sum xss)
```

---

## 9. allLines 取所有行列和对角线

```haskell
allLines :: [[a]] -> [[a]]
allLines xs = rows ++ cols ++ [diag1, diag2]
  where
    n = length xs

    rows = xs
    cols = [[ row !! i | row <- xs ] | i <- [0..n-1]]
    diag1 = [ xs !! i !! i | i <- [0..n-1]]
    diag2 = [ xs !! i !! (n - 1 - i) | i <- [0..n-1]]
```

---

## 10. magicSquareLines 只返回所有需要检查的线

```haskell
magicSquareLines :: [[Int]] -> [[Int]]
magicSquareLines xs = xs ++ cols ++ [diag1, diag2]
  where
    n = length xs

    cols =
      [[ row !! i | row <- xs ] | i <- [0..n-1]]

    diag1 =
      [ xs !! i !! i | i <- [0..n-1]]

    diag2 =
      [ xs !! i !! (n - 1 - i) | i <- [0..n-1]]
```

---

# 第二部分：二维列表 / 矩阵基础高频题

## 11. isSquare 判断是否是正方形矩阵

```haskell
isSquare :: [[a]] -> Bool
isSquare [] = False
isSquare xs = all (\row -> length row == n) xs
  where
    n = length xs
```

---

## 12. numRows 返回行数

```haskell
numRows :: [[a]] -> Int
numRows xs = length xs
```

---

## 13. numCols 返回列数

```haskell
numCols :: [[a]] -> Int
numCols [] = 0
numCols xs = length (head xs)
```

---

## 14. getRow 取第 i 行

```haskell
getRow :: Int -> [[a]] -> [a]
getRow i xs = xs !! i
```

---

## 15. getColumn 取第 j 列

```haskell
getColumn :: Int -> [[a]] -> [a]
getColumn j xs = [ row !! j | row <- xs ]
```

---

## 16. transpose 矩阵转置

```haskell
transpose :: [[a]] -> [[a]]
transpose xs =
  [[ row !! j | row <- xs ] | j <- [0..n-1]]
  where
    n = length (head xs)
```

---

## 17. transpose 递归版

```haskell
transposeRec :: [[a]] -> [[a]]
transposeRec [] = []
transposeRec ([]:_) = []
transposeRec xs = map head xs : transposeRec (map tail xs)
```

---

## 18. rowSums 所有行的和

```haskell
rowSums :: [[Int]] -> [Int]
rowSums xs = map sum xs
```

---

## 19. colSums 所有列的和

```haskell
colSums :: [[Int]] -> [Int]
colSums xs =
  [ sum [ row !! j | row <- xs ] | j <- [0..n-1] ]
  where
    n = length (head xs)
```

---

## 20. diagonal 取主对角线

```haskell
diagonal :: [[a]] -> [a]
diagonal xs =
  [ xs !! i !! i | i <- [0..n-1] ]
  where
    n = length xs
```

---

## 21. antiDiagonal 取副对角线

```haskell
antiDiagonal :: [[a]] -> [a]
antiDiagonal xs =
  [ xs !! i !! (n - 1 - i) | i <- [0..n-1] ]
  where
    n = length xs
```

---

## 22. diagonalSums 返回两条对角线的和

```haskell
diagonalSums :: [[Int]] -> (Int, Int)
diagonalSums xs =
  (sum (diagonal xs), sum (antiDiagonal xs))
```

---

## 23. flatten 二维列表展开

```haskell
flatten :: [[a]] -> [a]
flatten xs = concat xs
```

---

## 24. matrixSum 矩阵所有元素求和

```haskell
matrixSum :: [[Int]] -> Int
matrixSum xs = sum (concat xs)
```

---

## 25. matrixSize 返回矩阵尺寸

```haskell
matrixSize :: [[a]] -> (Int, Int)
matrixSize [] = (0, 0)
matrixSize xs = (length xs, length (head xs))
```

---

# 第三部分：List Comprehension 押题模板

## 26. positions 返回所有坐标

```haskell
positions :: [[a]] -> [(Int, Int)]
positions xs =
  [(i,j) | i <- [0..rows-1], j <- [0..cols-1]]
  where
    rows = length xs
    cols = length (head xs)
```

---

## 27. valuesWithPositions 返回坐标和值

```haskell
valuesWithPositions :: [[a]] -> [((Int, Int), a)]
valuesWithPositions xs =
  [ ((i,j), xs !! i !! j)
  | i <- [0..rows-1]
  , j <- [0..cols-1]
  ]
  where
    rows = length xs
    cols = length (head xs)
```

---

## 28. findValue 找出某个值的所有坐标

```haskell
findValue :: Eq a => a -> [[a]] -> [(Int, Int)]
findValue x grid =
  [ (i,j)
  | i <- [0..rows-1]
  , j <- [0..cols-1]
  , grid !! i !! j == x
  ]
  where
    rows = length grid
    cols = length (head grid)
```

---

## 29. greaterThanPositions 找出大于 target 的坐标

```haskell
greaterThanPositions :: Int -> [[Int]] -> [(Int, Int)]
greaterThanPositions target grid =
  [ (i,j)
  | i <- [0..rows-1]
  , j <- [0..cols-1]
  , grid !! i !! j > target
  ]
  where
    rows = length grid
    cols = length (head grid)
```

---

## 30. evenValues 返回矩阵中所有偶数

```haskell
evenValues :: [[Int]] -> [Int]
evenValues grid =
  [ x | row <- grid, x <- row, even x ]
```

---

## 31. countValue 统计某个值出现次数

```haskell
countValue :: Eq a => a -> [[a]] -> Int
countValue x grid =
  length [ y | row <- grid, y <- row, y == x ]
```

---

## 32. replaceAt 替换一维列表某个位置

```haskell
replaceAt :: Int -> a -> [a] -> [a]
replaceAt _ _ [] = []
replaceAt 0 new (_:xs) = new : xs
replaceAt n new (x:xs) =
  x : replaceAt (n - 1) new xs
```

---

## 33. updateGrid 更新二维矩阵某个位置

```haskell
updateGrid :: Int -> Int -> a -> [[a]] -> [[a]]
updateGrid i j new grid =
  replaceAt i newRow grid
  where
    oldRow = grid !! i
    newRow = replaceAt j new oldRow
```

---

## 34. removeRow 删除一行

```haskell
removeRow :: Int -> [[a]] -> [[a]]
removeRow i grid =
  take i grid ++ drop (i + 1) grid
```

---

## 35. removeCol 删除一列

```haskell
removeCol :: Int -> [[a]] -> [[a]]
removeCol j grid =
  [ take j row ++ drop (j + 1) row | row <- grid ]
```

---

# 第四部分：Tic-Tac-Toe / Board 棋盘类高频变体

## 36. hasWon 判断玩家是否赢

```haskell
hasWon :: Char -> [[Char]] -> Bool
hasWon player board =
  any (all (== player)) linesToCheck
  where
    n = length board

    rows = board
    cols = [[ row !! i | row <- board ] | i <- [0..n-1]]
    diag1 = [ board !! i !! i | i <- [0..n-1]]
    diag2 = [ board !! i !! (n - 1 - i) | i <- [0..n-1]]

    linesToCheck = rows ++ cols ++ [diag1, diag2]
```

---

## 37. winner 返回赢家 Maybe Char

```haskell
winner :: [[Char]] -> Maybe Char
winner board
  | hasWon 'X' board = Just 'X'
  | hasWon 'O' board = Just 'O'
  | otherwise        = Nothing
```

---

## 38. boardFull 判断棋盘是否满

```haskell
boardFull :: [[Char]] -> Bool
boardFull board =
  all (/= ' ') (concat board)
```

---

## 39. gameOver 判断井字棋是否结束

```haskell
gameOver :: [[Char]] -> Bool
gameOver board =
  boardFull board || winner board /= Nothing
```

---

## 40. validBoard 判断棋盘只含指定字符

```haskell
validBoard :: [[Char]] -> Bool
validBoard board =
  all (`elem` "XO ") (concat board)
```

---

## 41. countPlayer 统计棋子数量

```haskell
countPlayer :: Char -> [[Char]] -> Int
countPlayer player board =
  length [ c | row <- board, c <- row, c == player ]
```

---

## 42. nextPlayer 判断下一步是谁走

```haskell
nextPlayer :: [[Char]] -> Char
nextPlayer board
  | countPlayer 'X' board <= countPlayer 'O' board = 'X'
  | otherwise                                      = 'O'
```

---

## 43. emptyPositions 找出空位

```haskell
emptyPositions :: [[Char]] -> [(Int, Int)]
emptyPositions board =
  [ (i,j)
  | i <- [0..rows-1]
  , j <- [0..cols-1]
  , board !! i !! j == ' '
  ]
  where
    rows = length board
    cols = length (head board)
```

---

## 44. makeMove 落子

```haskell
makeMove :: Char -> Int -> Int -> [[Char]] -> [[Char]]
makeMove player i j board =
  updateGrid i j player board
```

---

## 45. winningLines 返回所有获胜线

```haskell
winningLines :: [[Char]] -> [[Char]]
winningLines board =
  rows ++ cols ++ [diag1, diag2]
  where
    n = length board

    rows = board
    cols = [[ row !! i | row <- board ] | i <- [0..n-1]]
    diag1 = [ board !! i !! i | i <- [0..n-1]]
    diag2 = [ board !! i !! (n - 1 - i) | i <- [0..n-1]]
```

---

# 第五部分：Maybe / Either 安全索引与安全矩阵

## 46. safeIndex 安全取下标

```haskell
safeIndex :: Int -> [a] -> Maybe a
safeIndex _ [] = Nothing
safeIndex n _
  | n < 0 = Nothing
safeIndex 0 (x:_) = Just x
safeIndex n (_:xs) = safeIndex (n - 1) xs
```

---

## 47. safeGet2D 安全取二维坐标

```haskell
safeGet2D :: Int -> Int -> [[a]] -> Maybe a
safeGet2D i j grid = do
  row <- safeIndex i grid
  safeIndex j row
```

---

## 48. safeRow 安全取行

```haskell
safeRow :: Int -> [[a]] -> Maybe [a]
safeRow i grid = safeIndex i grid
```

---

## 49. safeColumn 安全取列

```haskell
safeColumn :: Int -> [[a]] -> Maybe [a]
safeColumn j grid =
  sequence [ safeIndex j row | row <- grid ]
```

---

## 50. safeDiagonal 安全取主对角线

```haskell
safeDiagonal :: [[a]] -> Maybe [a]
safeDiagonal grid =
  sequence [ safeGet2D i i grid | i <- [0..n-1] ]
  where
    n = length grid
```

---

## 51. safeAntiDiagonal 安全取副对角线

```haskell
safeAntiDiagonal :: [[a]] -> Maybe [a]
safeAntiDiagonal grid =
  sequence [ safeGet2D i (n - 1 - i) grid | i <- [0..n-1] ]
  where
    n = length grid
```

---

## 52. safeTranspose 安全转置

```haskell
safeTranspose :: [[a]] -> Maybe [[a]]
safeTranspose [] = Just []
safeTranspose grid
  | not (allSame (map length grid)) = Nothing
  | otherwise =
      Just [[ row !! j | row <- grid ] | j <- [0..cols-1]]
  where
    cols = length (head grid)
```

---

## 53. safeIsSquare

```haskell
safeIsSquare :: [[a]] -> Maybe Bool
safeIsSquare [] = Nothing
safeIsSquare grid = Just (isSquare grid)
```

---

## 54. safeUpdateGrid

```haskell
safeUpdateGrid :: Int -> Int -> a -> [[a]] -> Maybe [[a]]
safeUpdateGrid i j new grid = do
  row <- safeIndex i grid
  _ <- safeIndex j row
  let newRow = replaceAt j new row
  return (replaceAt i newRow grid)
```

---

## 55. Either 版本 safeGet2D

```haskell
safeGet2DEither :: Int -> Int -> [[a]] -> Either String a
safeGet2DEither i j grid =
  case safeGet2D i j grid of
    Just x  -> Right x
    Nothing -> Left "index out of range"
```

---

# 第六部分：递归 / fold / map / filter 版本押题

## 56. allEqual 递归版

```haskell
allEqual :: Eq a => [a] -> Bool
allEqual [] = True
allEqual [_] = True
allEqual (x:y:xs)
  | x == y    = allEqual (y:xs)
  | otherwise = False
```

---

## 57. allEqual foldr 版

```haskell
allEqualFold :: Eq a => [a] -> Bool
allEqualFold [] = True
allEqualFold (x:xs) =
  foldr (\y acc -> y == x && acc) True xs
```

---

## 58. rowSums 递归版

```haskell
rowSumsRec :: [[Int]] -> [Int]
rowSumsRec [] = []
rowSumsRec (row:rows) =
  sum row : rowSumsRec rows
```

---

## 59. flatten 递归版

```haskell
flattenRec :: [[a]] -> [a]
flattenRec [] = []
flattenRec (xs:xss) =
  xs ++ flattenRec xss
```

---

## 60. flatten foldr 版

```haskell
flattenFoldr :: [[a]] -> [a]
flattenFoldr xss =
  foldr (++) [] xss
```

---

## 61. matrixMap

```haskell
matrixMap :: (a -> b) -> [[a]] -> [[b]]
matrixMap f grid =
  map (map f) grid
```

---

## 62. matrixFilter

```haskell
matrixFilter :: (a -> Bool) -> [[a]] -> [[a]]
matrixFilter p grid =
  map (filter p) grid
```

---

## 63. countIf

```haskell
countIf :: (a -> Bool) -> [a] -> Int
countIf p xs =
  length (filter p xs)
```

---

## 64. anyRow

```haskell
anyRow :: ([a] -> Bool) -> [[a]] -> Bool
anyRow p rows =
  any p rows
```

---

## 65. allRows

```haskell
allRows :: ([a] -> Bool) -> [[a]] -> Bool
allRows p rows =
  all p rows
```

---

# 第七部分：数据类型版本押题

## 66. 自定义 Cell 类型

```haskell
data Cell = Empty | X | O
  deriving (Eq, Show)
```

---

## 67. 自定义 Player 类型

```haskell
data Player = PlayerX | PlayerO
  deriving (Eq, Show)
```

---

## 68. hasWon 使用 Player 类型

```haskell
hasWonPlayer :: Player -> [[Maybe Player]] -> Bool
hasWonPlayer player board =
  any (all (== Just player)) linesToCheck
  where
    n = length board

    rows = board
    cols = [[ row !! i | row <- board ] | i <- [0..n-1]]
    diag1 = [ board !! i !! i | i <- [0..n-1]]
    diag2 = [ board !! i !! (n - 1 - i) | i <- [0..n-1]]

    linesToCheck = rows ++ cols ++ [diag1, diag2]
```

---

## 69. Move 类型

```haskell
data Move = Move Int Int
  deriving (Eq, Show)
```

---

## 70. makeMove 使用 Move 类型

```haskell
makeMovePlayer :: Player -> Move -> [[Maybe Player]] -> [[Maybe Player]]
makeMovePlayer player (Move i j) board =
  updateGrid i j (Just player) board
```

---

# 第八部分：更难矩阵扩展题

## 71. symmetric 判断矩阵是否对称

```haskell
symmetric :: Eq a => [[a]] -> Bool
symmetric xs =
  xs == transpose xs
```

---

## 72. rotate90 顺时针旋转矩阵

```haskell
rotate90 :: [[a]] -> [[a]]
rotate90 xs =
  [ reverse col | col <- transpose xs ]
```

---

## 73. rotate180 旋转 180 度

```haskell
rotate180 :: [[a]] -> [[a]]
rotate180 xs =
  reverse (map reverse xs)
```

---

## 74. reverseRows 每一行反转

```haskell
reverseRows :: [[a]] -> [[a]]
reverseRows xs =
  map reverse xs
```

---

## 75. reverseCols 行顺序反转

```haskell
reverseCols :: [[a]] -> [[a]]
reverseCols xs =
  reverse xs
```

---

## 76. addMatrices 矩阵加法

```haskell
addMatrices :: [[Int]] -> [[Int]] -> [[Int]]
addMatrices a b =
  zipWith (zipWith (+)) a b
```

---

## 77. scalarMultiply 矩阵乘常数

```haskell
scalarMultiply :: Int -> [[Int]] -> [[Int]]
scalarMultiply k grid =
  map (map (* k)) grid
```

---

## 78. dotProduct 点积

```haskell
dotProduct :: [Int] -> [Int] -> Int
dotProduct xs ys =
  sum (zipWith (*) xs ys)
```

---

## 79. matrixMultiply 矩阵乘法

```haskell
matrixMultiply :: [[Int]] -> [[Int]] -> [[Int]]
matrixMultiply a b =
  [[ dotProduct row col | col <- transpose b ] | row <- a ]
```

---

## 80. identity 生成单位矩阵

```haskell
identity :: Int -> [[Int]]
identity n =
  [[ if i == j then 1 else 0 | j <- [0..n-1] ] | i <- [0..n-1] ]
```

---

# 第九部分：Latin Square / Sudoku / Grid Validity 扩展押题

## 81. sameElements 判断两个列表元素集合相同

```haskell
sameElements :: Eq a => [a] -> [a] -> Bool
sameElements xs ys =
  all (`elem` ys) xs && all (`elem` xs) ys
```

---

## 82. noDuplicates 判断没有重复元素

```haskell
noDuplicates :: Eq a => [a] -> Bool
noDuplicates [] = True
noDuplicates (x:xs) =
  not (x `elem` xs) && noDuplicates xs
```

---

## 83. isLatinSquare

```haskell
isLatinSquare :: Eq a => [[a]] -> Bool
isLatinSquare grid =
  isSquare grid && rowsOK && colsOK
  where
    symbols = head grid

    rowsOK =
      all (\row -> sameElements row symbols) grid

    colsOK =
      all (\col -> sameElements col symbols) (transpose grid)
```

---

## 84. validSudokuRow

```haskell
validSudokuRow :: [Int] -> Bool
validSudokuRow row =
  length row == 9 &&
  sameElements row [1..9] &&
  noDuplicates row
```

---

## 85. chunksOf 分组

```haskell
chunksOf :: Int -> [a] -> [[a]]
chunksOf _ [] = []
chunksOf n xs =
  take n xs : chunksOf n (drop n xs)
```

---

## 86. boxes 取 Sudoku 九宫格

```haskell
boxes :: [[a]] -> [[a]]
boxes grid =
  [ concat [ take 3 (drop c row) | row <- take 3 (drop r grid) ]
  | r <- [0,3,6]
  , c <- [0,3,6]
  ]
```

---

## 87. validSudoku 简化版

```haskell
validSudoku :: [[Int]] -> Bool
validSudoku grid =
  rowsOK && colsOK && boxesOK
  where
    rowsOK = all validSudokuRow grid
    colsOK = all validSudokuRow (transpose grid)
    boxesOK = all validSudokuRow (boxes grid)
```

---

# 第十部分：考试常见坑题与模板

## 88. 防止空列表 head 报错版本

```haskell
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x
```

---

## 89. 判断每一行长度相同

```haskell
sameRowLengths :: [[a]] -> Bool
sameRowLengths [] = True
sameRowLengths rows =
  all (== firstLength) (map length rows)
  where
    firstLength = length (head rows)
```

---

## 90. 判断矩阵是否合法

```haskell
validMatrix :: [[a]] -> Bool
validMatrix [] = False
validMatrix rows =
  sameRowLengths rows
```

---

## 91. isMagicSquare 完整防御版

```haskell
isMagicSquareSafe :: [[Int]] -> Bool
isMagicSquareSafe [] = False
isMagicSquareSafe xs
  | not (isSquare xs) = False
  | otherwise         = all (== target) sums
  where
    n = length xs
    target = sum (head xs)

    rows = xs
    cols = [[ row !! i | row <- xs ] | i <- [0..n-1]]
    diag1 = [ xs !! i !! i | i <- [0..n-1]]
    diag2 = [ xs !! i !! (n - 1 - i) | i <- [0..n-1]]

    sums = map sum (rows ++ cols ++ [diag1, diag2])
```

---

## 92. 不用 list comprehension 的 isMagicSquare

```haskell
isMagicSquareNoComp :: [[Int]] -> Bool
isMagicSquareNoComp xs =
  all (== target) (map sum allLines)
  where
    n = length xs
    target = sum (head xs)

    rows = xs

    cols =
      map (\i -> map (!! i) xs) [0..n-1]

    diag1 =
      map (\i -> xs !! i !! i) [0..n-1]

    diag2 =
      map (\i -> xs !! i !! (n - 1 - i)) [0..n-1]

    allLines =
      rows ++ cols ++ [diag1, diag2]
```

---

## 93. 使用 import Data.List 的版本

```haskell
import Data.List

isMagicSquareDataList :: [[Int]] -> Bool
isMagicSquareDataList xs =
  all (== target) (map sum allLines)
  where
    n = length xs
    target = sum (head xs)

    diag1 = [ xs !! i !! i | i <- [0..n-1]]
    diag2 = [ xs !! i !! (n - 1 - i) | i <- [0..n-1]]

    allLines = xs ++ transpose xs ++ [diag1, diag2]
```

---

## 94. 不使用 import 的版本

```haskell
transpose' :: [[a]] -> [[a]]
transpose' xs =
  [[ row !! i | row <- xs ] | i <- [0..n-1]]
  where
    n = length (head xs)

isMagicSquareNoImport :: [[Int]] -> Bool
isMagicSquareNoImport xs =
  all (== target) (map sum linesToCheck)
  where
    n = length xs
    target = sum (head xs)

    diag1 = [ xs !! i !! i | i <- [0..n-1]]
    diag2 = [ xs !! i !! (n - 1 - i) | i <- [0..n-1]]

    linesToCheck =
      xs ++ transpose' xs ++ [diag1, diag2]
```

---

## 95. 最后必背模板

### 95.1 行

```haskell
rows = xs
```

### 95.2 第 i 列

```haskell
[ row !! i | row <- xs ]
```

### 95.3 所有列

```haskell
[[ row !! i | row <- xs ] | i <- [0..n-1]]
```

### 95.4 主对角线

```haskell
[ xs !! i !! i | i <- [0..n-1]]
```

### 95.5 副对角线

```haskell
[ xs !! i !! (n - 1 - i) | i <- [0..n-1]]
```

### 95.6 所有线

```haskell
rows ++ cols ++ [diag1, diag2]
```

### 95.7 检查所有 sum 相同

```haskell
all (== target) (map sum allLines)
```

### 95.8 二维坐标遍历

```haskell
[(i,j) | i <- [0..rows-1], j <- [0..cols-1]]
```

### 95.9 安全二维索引

```haskell
safeGet2D i j grid = do
  row <- safeIndex i grid
  safeIndex j row
```

---

# 最终押题排序

## 第一梯队：最可能考，必须背

1. `isMagicSquare`
2. `diagonal`
3. `antiDiagonal`
4. `getColumn`
5. `transpose`
6. `rowSums`
7. `colSums`
8. `isSquare`
9. `allSame`
10. `allSumsSame`

---

## 第二梯队：很像原题变体

1. `magicSumMaybe`
2. `isMagicSquareEither`
3. `safeIndex`
4. `safeGet2D`
5. `safeDiagonal`
6. `safeColumn`
7. `positions`
8. `valuesWithPositions`
9. `countValue`
10. `updateGrid`

---

## 第三梯队：棋盘类变体

1. `hasWon`
2. `winner`
3. `boardFull`
4. `gameOver`
5. `emptyPositions`
6. `makeMove`
7. `validBoard`
8. `countPlayer`
9. `nextPlayer`

---

## 第四梯队：矩阵扩展

1. `symmetric`
2. `rotate90`
3. `rotate180`
4. `addMatrices`
5. `scalarMultiply`
6. `matrixMultiply`
7. `identity`

---

## 第五梯队：难题/扩展题

1. `isLatinSquare`
2. `validSudokuRow`
3. `boxes`
4. `validSudoku`
5. `sameElements`
6. `noDuplicates`

---

# 考试最后 30 秒背这个

```haskell
isMagicSquare :: [[Int]] -> Bool
isMagicSquare xs =
  all (== target) (map sum allLines)
  where
    n = length xs
    target = sum (head xs)

    rows = xs
    cols = [[ row !! i | row <- xs ] | i <- [0..n-1]]

    diag1 = [ xs !! i !! i | i <- [0..n-1]]
    diag2 = [ xs !! i !! (n - 1 - i) | i <- [0..n-1]]

    allLines = rows ++ cols ++ [diag1, diag2]
```

---

# 如果考试不让用 import，就写这个 transpose

```haskell
transpose :: [[a]] -> [[a]]
transpose xs =
  [[ row !! i | row <- xs ] | i <- [0..n-1]]
  where
    n = length (head xs)
```

---

# 如果考试要求 Maybe，就写这个套路

```haskell
safeIndex :: Int -> [a] -> Maybe a
safeIndex _ [] = Nothing
safeIndex n _
  | n < 0 = Nothing
safeIndex 0 (x:_) = Just x
safeIndex n (_:xs) = safeIndex (n - 1) xs

safeGet2D :: Int -> Int -> [[a]] -> Maybe a
safeGet2D i j grid = do
  row <- safeIndex i grid
  safeIndex j row
```

---

# 如果考试变成 Tic-Tac-Toe，就写这个核心

```haskell
hasWon :: Char -> [[Char]] -> Bool
hasWon player board =
  any (all (== player)) linesToCheck
  where
    n = length board

    rows = board
    cols = [[ row !! i | row <- board ] | i <- [0..n-1]]
    diag1 = [ board !! i !! i | i <- [0..n-1]]
    diag2 = [ board !! i !! (n - 1 - i) | i <- [0..n-1]]

    linesToCheck = rows ++ cols ++ [diag1, diag2]
