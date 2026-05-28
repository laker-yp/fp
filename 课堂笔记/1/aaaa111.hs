{-# LANGUAGE MonadComprehensions #-}
{-# OPTIONS_GHC -Wno-noncanonical-monad-instances #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
module MonadExamples where

import Control.Monad.Writer
import Control.Monad.State

import Control.Applicative
import Data.Char


-- Maybe Monad: safeDiv

safeDiv :: Int -> Int -> Maybe Int
safeDiv x 0 = Nothing
safeDiv x y = Just (x `div` y)

-- 定义--
--- m为Monad这个类型类的，比如Maybe a
-- (>>=) :: Monad m => m a -> (a -> m b) -> m b
-- 第一个输入m a  , 把a取出来 放进(a -> m b)这个函数最后输出m b
-- Maybe Monad: using >>=

exampleBind1 :: Maybe Int
exampleBind1 =
  safeDiv 100 2 >>= \x ->  --先算 safeDiv 100 2，如果成功，把结果just x 提取出来叫做 x
  safeDiv x 5    --然后再把pure的x 放进function里面计算

exampleBind2 :: Maybe Int
exampleBind2 =
  safeDiv 100 0 >>= \x ->
  safeDiv x 5


-- Maybe Monad: using 【do】 notation
--怎么理解【<-】 : 相当于把右边的context拆包提出pure的元素

exampleDo1 :: Maybe Int
exampleDo1 = do
  a <- safeDiv 100 2  --先算 safeDiv 100 2，如果成功，把结果just a 提取出来叫做 a
  b <- safeDiv a 5  --然后把a放到这个function继续 safeDiv x 5 , 吧结果just b提出出来变成b
  return b  --把b放回context Maybe里面

exampleDo2 :: Maybe Int
exampleDo2 = do
  a <- safeDiv 100 0  ---这里Maybe a的结果是nothing所以直接整个function nothing
  b <- safeDiv a 5
  return b


-- pure in Maybe

pureMaybe :: Maybe Integer
pureMaybe = pure 89


-- pure in List

pureList :: [Integer]
pureList = pure 89


-- Monad-polymorphic Fibonacci 【fibm】的小 m 代表monads

fibm :: Monad m => Integer -> m Integer
fibm 0 = pure 1  --注意这里定义f 0是1
fibm 1 = pure 1
fibm n = do   ----比如在这里do就是把最后那一行的递归case给拆解，从上到下依次运行
  x <- fibm (n - 2)
  y <- fibm (n - 1)
  pure (x + y)

--使用具体的的m类型放进fibm,就是把【Integer -> m Integer】中的 m 改为你的目标类型
fib_maybe :: Integer -> Maybe Integer
fib_maybe = fibm

-----maybe    【fibM】的大 M 代表 Maybe
fibM :: Integer -> Maybe Integer
fibM n | n <  0 = Nothing
        | n == 0 = pure 0
        | n == 1 = pure 1
        | n >= 2 = do
                     x <- fibM (n-2)
                     y <- fibM (n-1)
                     pure (x+y)
------list
fib2 :: Integer -> [Integer]
fib2 n | n <  0 = []
       | n == 0 = pure 0
       | n == 1 = pure 1
       | n >= 2 = do
                    x <- fib2 (n-2)
                    y <- fib2 (n-1)
                    pure (x+y)

------------IO
fib3 :: Integer -> IO Integer
fib3 n | n <  0 = error ("invalid input " ++ show n) --处理负数
       | n == 0 = pure 0
       | n == 1 = pure 1
       | n >= 2 = do
                    putStrLn ("call with n = " ++ show n) --多了这一行输出打印
                    x <- fib3 (n-2)
                    y <- fib3 (n-1)
                    pure (x+y)
------------Write
fib4 :: Integer -> Writer [Integer] Integer
fib4 n | n <  0 = error ("invalid input " ++ show n)
       | n == 0 = pure 0
       | n == 1 = pure 1
       | n >= 2 = do
                    tell [n]  --把recursive call 的参数 n 写进 log
                    x <- fib4 (n-2)
                    y <- fib4 (n-1)
                    pure (x+y)
-------------state
fib5 :: Integer -> State Int Integer
fib5 n | n <  0 = error ("invalid input " ++ show n)
       | n == 0 = pure 0
       | n == 1 = pure 1
       | n >= 2 = do
                    modify (+1)  --每次进行到这里，state就+1
                    x <- fib5 (n-2)
                    y <- fib5 (n-1)
                    pure (x+y)

-- List Monad

listExample :: [(Int, Int)]
listExample = do
  x <- [1, 2, 3]
  y <- [10, 20]
  return (x, y)


-- List Comprehension equivalent

listComprehensionExample :: [(Int, Int)]
listComprehensionExample =
  [(x, y) | x <- [1, 2, 3], y <- [10, 20]]
