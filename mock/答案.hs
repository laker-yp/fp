-- setting the "warn-incomplete-patterns" flag asks GHC to warn you
-- about possible missing cases in pattern-matching definitions
{-# OPTIONS_GHC -fwarn-incomplete-patterns -Wno-x-partial #-}

-- see https://wiki.haskell.org/Safe_Haskell
{-# LANGUAGE NoGeneralizedNewtypeDeriving, Safe #-}

module MockTestSolutions ( isNBranching
                         , prune
                         , applyNTimes
                         , gameOver
                         , takeTokens
                         , isMagicSquare
                         , circuit
                         ) where

import Types
import Data.List

---------------------------------------------------------------------------------
---------------- DO **NOT** MAKE ANY CHANGES ABOVE THIS LINE --------------------
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- QUESTION 1
---------------------------------------------------------------------------------

isNBranching :: Int -> Rose a -> Bool
isNBranching n (Leaf _)        = True
isNBranching n (Branch forest) = length forest == n && all (isNBranching n) forest


prune :: Int -> Rose a -> Rose a
prune n (Leaf x)        = Leaf x
prune n (Branch forest) = Branch $ take n $ map (prune n) forest

---------------------------------------------------------------------------------
-- QUESTION 2
---------------------------------------------------------------------------------

applyNTimes :: Monad m => m a -> (a -> m a) -> Int -> m [a]
applyNTimes mx mf n = reverse <$> go n
 where
  go 0 = (\x -> [x]) <$> mx
  go m = do
   xs <- go (m - 1)
   x  <- mf (head xs)
   pure (x : xs)
--简单版如下
applyNTimes :: Monad m => m a -> (a -> m a) -> Int -> m [a]
applyNTimes mx mf 0 = do
  x <- mx
  pure [x]

applyNTimes mx mf n = do
  x  <- mx
  xs <- applyNTimes (mf x) mf (n - 1)
  pure (x : xs)
---------------------------------------------------------------------------------
-- QUESTION 3
---------------------------------------------------------------------------------

gameOver :: NimGame Bool
gameOver = do (heap1,heap2) <- get
              return $ heap1 == 0 && heap2 == 0


takeTokens :: Int -> Heap -> NimGame ()
takeTokens i h = do (heap1,heap2) <- get
                    case h of
                      First -> put $ (max 0 (heap1 - i),heap2)
                      Second -> put $ (heap1,max 0 (heap2 - i))

---------------------------------------------------------------------------------
-- QUESTION 4
---------------------------------------------------------------------------------

diagonal :: [[Int]] -> [Int]
diagonal []       = []
diagonal (xs:xss) = head xs : diagonal (map tail xss)

rev :: [[Int]] -> [[Int]]
rev [] = []
rev (xs : xss) = reverse xs : rev xss

isMagicSquare :: [[Int]] -> Bool
isMagicSquare xss = all (\y -> y == diagonal2) allsums
 where
  rowsums    = map sum xss
  columnsums = map sum (transpose xss)
  diagonal1  = sum (diagonal xss)
  diagonal2  = sum (diagonal (rev xss))
  allsums    = diagonal1:rowsums ++ columnsums

---------------------------------------------------------------------------------
-- QUESTION 5
---------------------------------------------------------------------------------

circuit :: Expr -> Circuit
circuit (Var     x    ) = Input x
circuit (Not     e    ) = Nand (circuit e) (circuit e)
circuit (Or      e1 e2) = circuit (Not (And (Not e1) (Not e2)))
circuit (Implies e1 e2) = circuit (Or (Not e1) e2)
circuit (And     e1 e2) = let e = Nand (circuit e1) (circuit e2) in Nand e e
