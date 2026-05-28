module Parsing where

import Control.Applicative
import Data.Char
--================================================
-- 1. Parser
--================================================

newtype Parser a = P (String -> [(a, String)])

--==============================================
-- 2. Parse
================================================
parse :: Parser a -> String -> [(a, String)]
parse (P p) inp = p inp
--===============================================
-- 3. item
--===============================================

item :: Parser Char
item = P (\inp -> case inp of
                    []     -> []
                    (x:xs) -> [(x, xs)])

--================================================
-- 4. Functor Instance
--================================================

instance Functor Parser where
  fmap g p = P (\inp -> case parse p inp of
                          []        -> []
                          [(v,out)] -> [(g v, out)])

--============================================
-- 5. Applicative Instance
--============================================

instance Applicative Parser where
  pure v = P (\inp -> [(v, inp)])

  pg <*> px = P (\inp -> case parse pg inp of
                           []         -> []
                           [(g, out)] -> parse (fmap g px) out)


--============================================
-- 6. Monad Instance
--================================================

instance Monad Parser where
  p >>= f = P (\inp -> case parse p inp of
                         []        -> []
                         [(v,out)] -> parse (f v) out)

--===========================================
-- 7. Alternative Instance
--==============================================

instance Alternative Parser where
  empty = P (\_ -> [])

  p <|> q = P (\inp -> case parse p inp of
                         []        -> parse q inp
                         [(v,out)] -> [(v,out)])


--==============================================
-- 8. Simple Parser Examples
--==============================================

threeApplicative :: Parser (Char, Char)
threeApplicative = pure g <*> item <*> item <*> item
  where
    g x y z = (x, z)

threeMonad :: Parser (Char, Char)
threeMonad = do
  x <- item
  item
  z <- item
  pure (x, z)


--==============================================
-- 9. Derived Primitive Parsers
--=========================================

sat :: (Char -> Bool) -> Parser Char
sat p = do
  x <- item
  if p x then pure x else empty

digit :: Parser Char
digit = sat isDigit

lower :: Parser Char
lower = sat isLower

upper :: Parser Char
upper = sat isUpper

letter :: Parser Char
letter = sat isAlpha

alphanum :: Parser Char
alphanum = sat isAlphaNum

char :: Char -> Parser Char
char x = sat (== x)


--===============================================
-- 10. String Parser
---===========================================

string :: String -> Parser String
string [] = pure []
string (x:xs) = do
  char x
  string xs
  pure (x:xs)


-- ================--=========================
-- 11. Identifiers, Numbers, and Spaces
-- ============-=========================

ident :: Parser String
ident = do
  x <- lower
  xs <- many alphanum
  pure (x:xs)

nat :: Parser Int
nat = do
  xs <- some digit
  pure (read xs)

space :: Parser ()
space = do
  many (sat isSpace)
  pure ()

int :: Parser Int
int =
  do
    char '-'
    n <- nat
    pure (-n)
  <|> nat


-- =============-=================================
-- 12. Token Parsers
-- ================-============================

token :: Parser a -> Parser a
token p = do
  space
  v <- p
  space
  pure v

identifier :: Parser String
identifier = token ident

natural :: Parser Int
natural = token nat

integer :: Parser Int
integer = token int

symbol :: String -> Parser String
symbol xs = token (string xs)

nats :: Parser [Int]
nats = do
  symbol "["
  n <- natural
  ns <- many (do
    symbol ","
    natural)
  symbol "]"
  pure (n:ns)


-- ============-==================================
-- 13. Arithmetic Expression Parser
-- ============-===============================

expr :: Parser Int
expr = do
  t <- term
  (do
    symbol "+"
    e <- expr
    pure (t + e))
    <|> pure t

term :: Parser Int
term = do
  f <- factor
  (do
    symbol "*"
    t <- term
    pure (f * t))
    <|> pure f

factor :: Parser Int
factor =
  do
    symbol "("
    e <- expr
    symbol ")"
    pure e
  <|> natural


-- ============================================================
-- 14. Evaluate Expression
-- ============================================================

eval :: String -> Int
eval xs = case parse expr xs of
  [(n, [])]  -> n
  [(_, out)] -> error ("Unused input " ++ out)
  []         -> error "Invalid input"
