# Parsing
```
import Control.Applicative --applicative functors
import Data.Char --characters
```
## What is a parser?

_parser_ 是一个 program：它接收一个 characters string 作为 input，然后产生某种 tree，让这个 string 的 syntactic structure 变得明确。

例如，string `2*3+4` 可以被 parsed 成下面这个 expression tree：

```hs
       +
      / \
     *   4
    / \
   2   3
```

这个 tree 的 structure 明确表示：`+` 和 `*` 都是有两个 arguments 的 operators，而且 `*` operator 的 precedence 高于 `+`。

**Example Parsers**: Calculator program that parses numeric expressions, GHC system for parsing Haskell programs.

在 Haskell 里，parser 可以看成一个 function：它接收 string，并产生 tree。于是我们可以定义 parser type：

```hs
type Parser = String -> Tree  --起别名
```

一般来说，parser 不一定会 consume 完全部 input string，所以还可以把没有被 consume 的 input string 一起返回：

```hs
type Parser = String -> (Tree, String)
                                ↑未处理的rest
```

类似地，parser 不一定总能成功 parse input，所以我们可以进一步 generalise parser type，让它返回 results list。返回 empty list 表示 failure，返回 singleton list 表示 success。

```hs
type Parser = String -> [(Tree, String)]
```

不同 parsers 可以返回不同种类的 trees，比如 integer value。因此最好把 return type 作为 Parser type 的一个 parameter：

```hs
type Parser a = String -> [(a, String)]
```

上面这个 declaration 的意思是：_一个 type 为 **a** 的 parser，是一个接收 input string 并产生 results list 的 function；每个 result 都是一个 pair，包含一个 type 为 **a** 的 result value 和一个 output string_。

# Definitions
用 newtype 重新定义它，并给一个 **P**：

(newtype其实就是只有一个parameter的data，在这的parameter是一个函数)

```haskell
newtype Parser a = P (String -> [(a, String)])
```

`Parser`：拆包装的函数，把数据构造器里面的函数取出来

```haskell
parse :: Parser a -> String -> [(a, String)]
parse (P p) inp = p inp 
```
* 给左边一个 parser`p`，一个 input string`inp`

* 右边把 parser 里的 function`p` 拿出来，应用到 input`inp`上

我们定义第一个 parsing primitive function，叫做 `item`。如果 input string 是 empty，它失败；否则它用第一个 character 作为 result value，并成功：

```haskell
item :: Parser Char
item = P (\inp -> case inp of
                     []     -> []  --失败直接返回[]，rest也不要
                     (x:xs) -> [(x,xs)])
```

Item parser 是所有其他 consume input characters 的 parsers 的 basic building block。

例如：
```hs
> parse item ""
[] 

> parse item "abc"
[('a',"bc")]
```
# 结合monads
### Sequencing and Making Choice between Parsers
因为parser有context`p`，拆包`paese`的过程，使用可以用到 monads

让 parser type 成为 functor、applicative 和 monad 这几个类型类的 instance

这样就可以用 **do notation** 把 parsers 按顺序结合起来了

## `Parser` functor

```haskell
instance Functor Parser where
  -- fmap :: (a -> b) -> Parser a -> Parser b
  fmap g p = P (\inp -> case parse p inp of
                           []        -> []
                           [(v,out)] -> [(g v, out)])
```
* parser失败，就 []
* parser成功，`fmap` 会把function`g` 应用到 parser 的 result`v`,得到[(g v, out)])

例如：
```hs
> parse (fmap toUpper item) "abc"
[('A',"bc")]

> parse (fmap toUpper item) ""
[]
```

## `Parser` applicative

```haskell
instance Applicative Parser where
  -- pure :: a -> Parser a
  pure v = P (\inp -> [(v,inp)]) --把v作为result，并且不消耗任何 input,这个parser永真

  -- <*> :: Parser (a -> b) -> Parser a -> Parser b
  pg <*> px = P (\inp -> case parse pg inp of
                   []         -> []
                   [(g, out)] -> parse (fmap g px) out)

```
对于pure
### 理解`pure`：就是普通的拆包(pure 1) 就是1
```hs
> parse (pure 1) "abc"
[(1,"abc")]
```
 `<*>` 的意思是：一个 parser 返回 function，另一个 parser 返回 argument，组合后得到一个 parser，它返回 function applied to argument 的结果；并且只有所有 components 都成功时它才成功
 
 例如，连续吃三个char、丢弃第二个、返回第一个和第三个作为 pair 的 parser 可以用 applicative style 定义：

```hs
three :: Parser (Char,Char)
three = pure g <*> item <*> item <*> item
        where g x y z = (x, z)
```
### 理解`<*>`：pure g <*> item 就是把g应用到item

例如：

```hs
> parse three "abcdef"
[(('a','c'),"def")]

> parse three "ab"
[]
```

## `Parser` monad：

```haskell
instance Monad Parser where
  -- (>>=) :: Parser a -> (a -> Parser b) -> Parser b
  p >>= f = P (\inp -> case parse p inp of
                          []        -> []
                          [(v,out)] -> parse (f v) out)
```

也就是说，如果 parser `p` 应用到 input string `inp` 上失败，那么 `p >>= f` 也失败；否则，把 function `f` 应用到 result value `v` 上，得到另一个 parser `f v`，再把它应用到第一个 parser 产生的 output string `out` 上，得到最终 result。

现在我们可以用 **do notation** 来 sequence parsers 并处理它们的 result values。例如：

```hs
three :: Parser (Char,Char)
three = do
  x <- item
  item
  z <- item
  pure (x,z)
```

另一种自然的 parser combination 是：先把一个 parser 应用到 input string 上；如果失败，就把另一个 parser 应用到同一个 input 上。这里我们可以用 `empty` 和 choice operator `<|>` 实现这个想法。`empty` parser 无论 input 是什么都失败，而 choice operator 如果第一个 parser 成功，就返回它的 result；否则对同一个 input 使用第二个 parser：

```haskell
instance Alternative Parser where
  -- empty :: Parser a
  empty = P (\inp -> [])

  -- (<|>) :: Parser a -> Parser a -> Parser a
  p <|> q = P (\inp -> case parse p inp of
                          []        -> parse q inp
                          [(v,out)] -> [(v,out)])
```

例如：

```hs
> parse empty "abc"
[]

> parse (item <|> pure 'd') "abc"
[('a',"bc")]

> parse (empty <|> pure 'd') "abc"
[('d',"abc")]
```

### Derived Primitives and Handling Spacing

使用目前定义的三个 basic parsers，也就是 `item`、`pure` 和 `empty`，再加上 sequencing 和 choice，我们可以定义其他 useful parsers。例如，下面定义 parser `sat p`，它 parse 满足某个 predicate `p` 的 single character：

```haskell
sat :: (Char -> Bool) -> Parser Char
sat p = do x <- item
           if p x then pure x else empty
```

类似地，我们可以定义下面这些 parsers，用来 parse single digits、lower-case letters、upper-case letters、arbitrary letters、alphanumeric characters 和 specific characters。

```haskell
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
char x = sat (==x)
```

例如：

```hs
> parse (char 'a') "abc"
[('a',"bc")]

> parse (char 'b') "abc"
[]
```

使用 `char`，我们可以定义 parser `string xs`，用来 parse characters string xs，并把 string 本身作为 result value 返回：

```haskell
string :: String -> Parser String
string []         = pure []
string (x:xs)     = do char x
                       string xs
                       pure (x:xs)
```

**Note:** 上面的 string parser 只有在整个 target string 都从 input 中被 consumed 时才成功。例如：

```hs
> parse (string "abc") "abcdef"
[("abc","def")]

> parse (string "abc") "ab1234"
[]
```

我们也可以使用来自 `Alternative` class definition 的 `many` 和 `some` parsers。`many p` 和 `some p` 会尽可能多次应用给定 parser `p`，直到它失败为止，并把每次成功的 result values 放进一个 list 返回。`many` 允许 zero or more 次应用，而 `some` 要求至少成功一次。例如：

```hs
> parse (many digit) "123abc"
[("123","abc")]

> parse (many digit) "abc"
[("","abc")]

> parse (some digit) "abc"
[]
```

现在，我们可以定义 parsers，用来 parse identifiers、natural numbers 和 spacing。Identifier 是 lower-case letter 后面跟着 zero or more alphanumeric characters；natural number 是 one or more digits；spacing 是 zero or more space、tab 和 newline characters。

```haskell
ident :: Parser String
ident = do x <- lower
           xs <- many alphanum
           pure (x:xs)

nat :: Parser Int
nat = do xs <- some digit
         pure (read xs)

space :: Parser ()
space = do many (sat isSpace)
           pure ()
```

例如：

```hs
> parse ident "abc def"
[("abc"," def")]

> parse nat "123 abc"
[(123," abc")]

> parse space "   abc"
[((),"abc")]
```

使用 `nat` parser，我们可以定义 integer values 的 parser：

```haskell
int :: Parser Int
int = do char '-'
         n <- nat
         pure (-n)
      <|> nat
```

例如：

```hs
> parse int "-123 abc"
[(-123," abc")]

> parse int "4567 abc"
[(4567," abc")]
```

#### Handling Spacing

大多数 real-life parsers 都允许 basic tokens 周围自由使用 spacing。例如，strings `1+2` 和 `1 + 2` 会被以同样的方式 parsed。我们可以定义一个新的 primitive，它会在应用某个 token parser 之前和之后忽略任意 spaces：

```haskell
token :: Parser a -> Parser a
token p = do space
             v <- p
             space
             pure v
```

使用 `token`，我们可以定义忽略 identifiers、natural numbers、integers 和 special symbols 周围 spacing 的 parsers：

```haskell
identifier :: Parser String
identifier = token ident

natural :: Parser Int
natural = token nat

integer :: Parser Int
integer = token int

symbol :: String -> Parser String
symbol xs = token (string xs)

-- a parser for a non-empty list of natural numbers that ignores spacing
nats :: Parser [Int]
nats = do symbol "["
          n <- natural
          ns <- many (do symbol ","
                         natural)
          symbol "]"
          pure (n:ns)
```

例如：

```hs
> parse nats "  [1, 2,  3]  "
[([1,2,3],"")]

> parse nats "  [ 10,   2  34  ] "
[]

> parse nats "  [ 10,   2,  ] "
[]
```

### Parsing Arithmetic Expressions

在这个 example 中，我们考虑 arithmetic expressions：它们由 natural numbers 通过 addition、multiplication 和 parentheses 构造出来。我们假设 addition 和 multiplication 都向右结合，并且 multiplication 的 priority，也就是 precedence，高于 addition。例如，`2+3+4` 表示 `2+(3+4)`，而 `2*3+4` 表示 `(2*3)+4`。

我们可以用 _grammar_ 描述任意 language 的 syntactic structure。Grammar 是一组 rules，说明这个 language 的 strings 如何被 constructed。例如，arithmetic expressions 的 grammar 可以写成：

```
expr ::= expr + expr | expr * expr | (expr) | nat
nat  ::= 0 | 1 | 2 | ...
```

对于 expression `2*3+4`，可以构造一个 _parse tree_，其中 expression 中的 tokens 出现在 leaves，而 grammatical rules 对应 branching structure。

不过，上面的 grammar 会允许同一个 expression 有多个 possible parse trees，比如把 `2*3+4` 错误解释成 `2*(3+4)`。问题在于 grammar 没有体现 multiplication 比 addition 有更高 priority。

我们可以修改 grammar，为每个 precedence level 单独写 rule：addition 最低，multiplication 中间，parentheses 和 numbers 最高。

```
expr   ::= expr + expr | term
term   ::= term * term | factor
factor ::= (expr) | nat
nat    ::= 0 | 1 | 2 | ...
```

这个 grammar 仍然没有体现 addition 和 multiplication 向右结合。例如，`2+3+4` 仍然可能对应 `(2+3)+4` 或 `2+(3+4)`。我们可以把 addition 和 multiplication 的 rules 改成在右侧递归：

```
expr   ::= term + expr | term
term   ::= factor * term | factor
factor ::= (expr) | nat
nat    ::= 0 | 1 | 2 | ...
```

新的 grammar 可以正确 parse `2+3+4`，只得到一个 parse tree，对应正确解释 `2+(3+4)`。

这个 grammar 是 _unambiguous_ 的，也就是说每个 well-formed expression 恰好有一个 parse tree。接下来我们可以把 grammar 简化，因为一些 expressions 有共同部分。例如，rule `expr ::= term + expr | term` 表示 expression 要么是 term 加 expression，要么就是 term。换句话说，一个 expression 总是以 term 开头，后面可能跟一个 addition of expression，也可能什么都没有。

![Final Grammar](./images/final_grammar_parsing.png)

上面的 grammar 可以直接翻译成 expression parser，只需要用 parsing primitives 重写 rules：

```haskell
expr :: Parser Int
expr = do t <- term
          do symbol "+"
             e <- expr
             pure (t + e)
           <|> pure t

term :: Parser Int
term = do f <- factor
          do symbol "*"
             t <- term
             pure (f * t)
           <|> pure f

factor :: Parser Int
factor = do symbol "("
            e <- expr
            symbol ")"
            pure e
          <|> natural
```

**Note:** 上面的 parsers 返回的是被 parsed expression 的 integer value，而不是某种 expression tree。

最后，使用 `expr`，我们定义一个 function：它 parse 并 evaluate 一个 expression，然后返回得到的 integer value。未被 consume 的 input 和 invalid input 会导致 error messages 和 program termination：

```haskell
eval :: String -> Int
eval xs = case parse expr xs of
             [(n,[])]  -> n
             [(_,out)] -> error ("Unused input " ++ out)
             []        -> error "Invalid input"
```

例如：

```hs
> eval "2*3+4"
10

> eval "2+3*4+2"
16

> eval "(2+3)*(4+2)"
30

> eval "one plus two"
*** Exception: Invalid input
```
