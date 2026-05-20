# User defined data types - part 1
## Contents

* [Type synonyms](#Type-synonyms类型的别名) 直接点这里开始吧
* [自定义data type](#datatypes)
  * [Bool type的复习](#booleans)
  * [Type isomorphisms同构](#typeisos)
  * [Weekdays例子](#weekdays)

* [type constructors](#logic)
  * [The `Maybe` type constructor](#maybe)
  * [Type retracts](#retracts)
  * [The `Either` type constructor](#either)
  * [The `And` type constructor, defined by ourselves](#and)

* [Lists revisited](#lists)
  * [Implementing some basic operations on lists](#listops)
  * [An aside on accumulators](#accum)

* [Binary trees](#bintrees)
  * [Basic functions on binary trees](#bintreefns)
  * [Directions, addresses and paths in binary trees](#bintreeaddr)
  * [Proofs on binary trees by induction](#bintreepf)
  * [Traversals in binary trees](#traversals)
  * [Inverting traversals (generating trees)](#gentree)

<a name="typesynonyms"></a>

## Level of difficulty of this handout

这份 handout 里包含 easy、medium、hard 和 advanced level 的材料。如果有些内容感觉很难，那很可能是因为它本来就难，而不是你的问题。这也意味着：如果你想在这个 module 里拿到 high mark，就需要认真下功夫；这和其他 modules 是一样的。

<a name="videolectures"></a>
## Video lectures for this handout

为了方便你学习，下面这些 videos 也会在本 handout 里对应的位置再次链接。

1. [Introduction, the booleans revisited, isomorphisms, Weekdays and the new `Maybe` type constructor](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=98b350c3-ec60-47c4-b2fb-ac610127b135) (35 min)
1. [Type retracts](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=c78bfae6-79d6-4a09-bc70-ac6200c363c9) (13 min)
1. [Either and And and pairs](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=a2cf8bd9-109b-43d9-ae30-ac620091d8bc) (9 min)
1. [Lists revisited](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=985bb5d7-a2a2-4511-a6fb-ac620095003d) (9 min)
1. [Binary trees](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=dbfdfb07-23e8-4b8b-a167-ac6200988381) (12 min)
1. [Directions, addresses and paths in binary trees](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=0904c115-0ad1-486c-945f-ac62009d2772) (15 min)
1. [Traversals in binary trees](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=e194464a-dc4d-4fd5-8e03-ac6200a0ae73) (10 min)
1. [Inverting traversals](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=e2c84108-de51-42ce-a42b-ac6200bcd280) (18 min)

Total 2hrs.

## Experimenting with the Haskell code included here

你应该自己运行并实验这些 notes 里的 Haskell code，这样才能真正理解。也就是说，你不只是读代码，还要跑代码，并且可以在里面加一些东西，比如 exercises 和 puzzles 的 solutions，或者你自己的 brilliant ideas。

这些 lecture notes 是 [markdown](https://docs.gitlab.com/ee/user/markdown.html) format，里面包含 Haskell code。为了把 markdown 里的 Haskell code 抽出来，我们可以使用 [Resources](/Resources) directory 里的 program [`mdtohs.hs`](Resources/mdtohs.hs)。在 Unix/Linux terminal 里可以这样写：
```
$ cat Data1.md | runhaskell ../../Resources/mdtohs.hs > Data1.hs
```
这句话的意思是：把 file `Data1.md` 的内容复制到 Haskell program `mdtohs.hs` 的 standard input，然后把这个 program 的 output 存到 file `Data1.hs` 里。它也可以等价地写成：
```
$ runhaskell ../../Resources/mdtohs.hs < Data1.md > Data1.hs
```
这样会删除所有 markdown code，只保留 Haskell code，所以我们就可以直接拿它来工作。

我们已经帮你运行过一次了，file [Data1.hs](/files/LectureNotes/Sections/Data1.hs) 已经在这个 GitLab repository 里。你应该自己做一个 **copy**，这样之后我们更新文件时不会和你的版本冲突。

## Haskell imports in these lecture notes

任何需要的 library imports 都应该在 file 顶部这里说明。为了生成 random inputs 来 testing，我们需要下面这些内容：
```haskell
module Data1 where

import System.Random
```


# Type synonyms类型的别名

给一个已经存在的 type 起一个新名字

比如string 被定义成 characters 的 list：
```hs
type String = [Char]
```
所以能用在char list的所有function都能用在string
```hs
> "abc" ++ ['d','e','f']
```
type的形式可以有很多种，而且不一定像Int那样只有一个单词组成

比如Lst a也是一个type，表示Lst这个【类型构造器】可以带上一种a的类型

比如：
```haskell
type Lst a = [a]

表示为给[a]这个类型取一个名字，叫做“Lst a”，其中a为构建这个type需要带上的参数

```

<a name="datatypes"></a>
# User defined data types

<a name="booleans"></a>
## The booleans revisited

## 不带参数的type
```hs
data Bool = False | True
```
这定义了一个 type，叫做 `Bool`，它有两个 elements( *constructor，准确来说是数据构造器*)，分别叫 `False` 和 `True`：
```hs
所以和两个elem（数据构造器）的类型都是Bool
   False :: Bool
   True  :: Bool
```
一个 data type 上的 functions 可以很方便地通过对它的 constructors 做 **pattern-matching** 来定义。
比如，在 Haskell 里，&&：
```hs
(&&) :: Bool -> Bool -> Bool
```
定义如下：
```hs
False && _ = False
True  && x = x
```
Haskell 里 pattern-matching 的 semantics 有一个稍微 subtle 的地方：

1. 不同的pattern-matching会从*上到下*依次尝试。
2. 看 input 能不能和这一行左边的 pattern 匹配
3. 甚至不会看后面任何pattern

第二个问题【short-circuit】，input匹配成功后，如匹配到False && _ = False

那么Haskell在看到参数False的时候就直接输出结果False了，根本在乎_里面是什么，符不符合方法中要求的type

下面这个 && 不管第一个 argument 是什么，第二个 argument 都会被 evaluated
```haskell
&& :: Bool -> Bool -> Bool
&& False False = False
&& False True  = False
&& True  False = False
&& True  True  = True
```

<a name="typeisos"></a>
## Type isomorphisms同构

我们引入另一个 data type `BW`：
```haskell
data BW   = Black | White
```
这个 type 和 `Bool` 是 *isomorphic* 的
```haskell
data Bool = True | False
```

可以通过下面这两个 functions 互相转换：
```haskell
bw2bool :: BW -> Bool
bw2bool Black = False
bw2bool White = True

bool2bw :: Bool -> BW
bool2bw False = Black
bool2bw True  = White
```
说 pair of functions `(bw2bool,bool2bw)` 是一个 isomorphism，意思是它们互为 inverse。也就是说：
```hs
   bw2bool(bool2bw b) = b
```
对所有 `b :: Bool` 都成立，并且：
```hs
   bool2bw(bw2bool c) = c
```
对所有 `c :: BW` 都成立。

Tips:Type 同构 不要和 type 同名 混淆。

某方法要求 `Bool` 那就不能用`BW` 的value

Black && True 是错的

bw2bool Black && True 才可以

当然，`Black` 和 `White` 这些 names 是 arbitrary 的所以不一定Black就是F

 `Bool` 和 `BW` 也和下面这个type isomorphic
```haskell
data Bit = Zero | One
```

> **Note:** type的name必须大写

<a name="weekdays"></a>
## Weekdays

另一个 data type 的例子是：
```haskell
data WeekDay = Mon | Tue | Wed | Thu | Fri | Sat | Sun
               deriving (Show, Read, Eq, Ord, Enum, Bounded)
```
这会自动把 type `WeekDay` 加入这六个 type classes

并且给出对应的 这些类型类所支持的operation(functions)：
```hs
   show :: WeekDay -> String  --toString
   read :: String -> WeekDay  --与toString相反
   (==) :: WeekDay -> WeekDay -> Bool
   (<), (>), (<=), (>=) :: WeekDay -> WeekDay -> Bool
   succ, pred :: WeekDay -> WeekDay
   minBound, maxBound :: Weekday
```
一些 examples：
```hs
> show Tue
"Tue"
> read "Tue" :: WeekDay
Tue
> Mon < Tue
True
> succ Mon
Tue
> [Mon .. Fri]
[Mon,Tue,Wed,Thu,Fri]
```
Monday 没有 pred，Sunday 没有 succ

更多：
```
> minBound :: WeekDay
Mon
> maxBound :: WeekDay
Sun
```
------------------------------------------------------------------
<a name="logic"></a>
# type constructors

<a name="maybe"></a>
## The `Maybe` type constructor

有时候一个 function 可能无法给出 result，我们希望它明确说“保持沉默”
```hs
data Maybe a = Nothing | Just a
```
这里 `a` 是一个 type parameter，`Nothing` 和 `Just` 有下面这些 types：

```hs
   Nothing :: Maybe a
```
 `Nothing`是一个不带参数的构造器，本身技术
 
```
  Just    :: a -> Maybe a
```
 `Just` 这个构造器本质是一个 function。它把type为`a` 的参数构造成一个type为`Maybe a`的变量
 
 例如：
```hs
   Just 17 :: Maybe Integer
```

## Maybe Example

### div 函数

如果 denominator分母 是 0，那么 result 是 `Nothing`

如果 division 可以执行，我们就直接进行 division，并且用 type conversion function `Just` 把得到的 `Int` 转成 `Maybe Int`，这就给出了 function `dive` 的 result：
```haskell
myDiv :: Int -> Int -> Maybe Int
x `myDive` y = if 【y == 0】 then 【Nothing】 else 【Just (x `div` y)】
```
例如：
```hs
> 10 `dive` 2
Just 5
> 10 `dive` 0
Nothing
```
### 让【maybe Int】也能被计算
但现在假设你想做 ``3 + (10 `dive` 0)``。你可能期待得到 `Nothing`，但是输出为error

因为`+` 需要它右边的参数是 `Int`而我们写的是``(10 `div` 0)`` 是一个 `Maybe Int`

那我们就自己写一个+来让maybe a这个type也能被运算

```haskell
adde :: Maybe Int -> Maybe Int -> Maybe Int
adde Nothing  Nothing  = Nothing
adde Nothing  (Just y) = Nothing
adde (Just x) Nothing  = Nothing
adde (Just x) (Just y) = Just (x + y)
```
简洁↓
```haskell
adde :: Maybe Int -> Maybe Int -> Maybe Int
adde (Just x) (Just y) = Just (x+y)
adde _       _         = Nothing
```
试一下↓
```hs
> Just 3 `adde` (10 `dive` 2)
Just 8
> Just 3 `adde` (10 `dive` 0)
Nothing
```
用 `case` 来定义：
```haskell
adde'' :: Maybe Int -> Maybe Int -> Maybe Int
adde'' xm ym = case xm of
                Nothing -> Nothing
                Just x  -> case ym of
                            Nothing -> Nothing
                            Just y  -> Just (x+y)
```

之后我们会看到一种更简洁的方式，用 *monads* 来写这种 definitions。但现在我们先继续使用 pattern matching 和 cases。

### Example: 找出a在[a]中出现的第一个位置

```haskell
firstPosition :: Eq a => a -> [a] -> Maybe Int
firstPosition v []     = Nothing
firstPosition v (x:xs)
           | v == x    = Just 0
           | otherwise = case firstPosition v xs of
                           Nothing -> Nothing
                           Just n  -> Just (n+1)

->的意思是:表示“匹配到这个 pattern，就返回这个结果”
```
例如：
```hd
> firstPosition 'c' ['a'..'z']
Just 2
> firstPosition '!' ['a'..'z']
Nothing
```
检查某元素v是否在list里面
```haskell
testFirstPosition :: Eq a => a -> [a] -> Bool
testFirstPosition v xs =  case firstPosition v xs of
                           Nothing -> and [ xs !! i /= v | i <- [0 .. length xs - 1]]
                           Just n  -> xs !! n == v
```
```hs
> testFirstPosition 'w' ['a'..'z']
True
```
*Task*. 定义`allPositions :: Eq a => a -> [a] -> [Int]`，找出一个 element 在 list 中出现的所有index

`allPositions 7 [111,7,7,666] = [1,2]`

```
allPositions :: Eq a => a -> [a] -> [Int]
allPositions v xs = findPositions v xs 0

findPositions :: Eq a => a -> [a] -> Int -> [Int]
findPositions v [] n = []
findPositions v (x:xs) n
  | v == x     = n : findPositions v xs (n+1) --如果v=x了，那就把n放在list前面，再递归xs
  | otherwise  =     findPositions v xs (n+1)  --否则直接无视x，去递归xs
```

<a name="retracts"></a>
# Type retracts

## Bool是Int的retract

## Bool能变int再回Bool
## Int 变 Bool再回Int 就回不到原来的值了，只能输出0，1

如果，types `a` 和 `b` 的 isomorphism 是一对 functions：
```
f :: a -> b
g :: b -> a
```
满足：
 * 对所有 `y :: b`，`f (g y) = y`。
 * 对所有 `x :: a`，`g (f x) = x`。

这两个 functions 是 *mutually inverse*。这意味着我们可以在 type `a` 的 变量 和 type `b` 的 变量 之间来回转换

另一种：一个 type `b` 可以“live” inside 另一个 type `a`

                 ↑Int                              ↑Bool

type `Bool` 在 type `Int` 里面有一个 copy：

```haskell
bool2Int :: Bool -> Int
bool2Int False = 0
bool2Int True  = 1
```
可以从T F 变成 1 0

然后可以直接从把1 0变成T F
```haskell
int2Bool :: Int -> Bool
int2Bool n | n == 0    = False
           | otherwise = True
```
note：不仅仅 `1` 会被转换回 `True`，是所有非 `0` 的东西都会被转换成 `True`。

我们有：
```
   int2Bool (bool2Int y) = y
```
这个f对每个 `y :: Bool` 都成立
```
 bool2Int (int2Bool x) = x
```
但这个f不是对每个 `x :: Int` 成立

比如 `x = 17` 时就失败了，因为 `bool2Int (int2Bool 17)` 是 `1`，不是 `17`，外层bool2Int只输出1/0

我们可以说：int 这个 type 有足够空间容纳 bool 这个 type 的一个 copy，但是 booleans 这个 type 没有足够空间容纳 integers 这个 type 的一个 copy。

当有 functions：
```
a为Int; b为Bool

f :: a -> b    int2Bool
g :: b -> a    Bool2Int
```
满足：
 * 对所有 `y :: b`，`f (g y) = y`
   
           y :: Bool

但不一定满足对所有 `x :: a` 有 `g (f x) = x` 时

我们说 type `b` 是 type `a` 的一个 *retract*。


但注意，type `Bool` 不一定对应0和1，这只是取决于个人的想法，不过无论如何只能对应两个值

**Task**. 证明 type `Maybe a` 是 type `[a]` 的一个 retract

`Nothing` 对应 empty list `[]`

`Just x` 对应 one-element list `[x]`
```
toList :: Maybe a -> [a]
toList Nothing  = []
toList (Just x) = [x]

fromList :: [a] -> Maybe a
fromList []    = Nothing
fromList (x:_) = Just x
```

如果我们有一个 type retraction `(f,g)`，如上所述，那么：

 * `f` 是一个 __surjection__。

    这意味着：对每个 `y :: b`，至少存在一个 `x :: a` 使得 `f x = y`。

    例如，在 bool 作为 int 的 retract ，每个 boolean 至少由一个 integer code。

 * `g` 是一个 __injection__。

   这意味着：对每个 `x :: a`，最多存在一个 `y :: b` 使得 `g y = x`。

   在 booleans 作为 integers 的 retract 
    * 对于 `x = 0`，恰好有一个 `y` 满足 `bool2Int y = x`，也就是 `y=False`。
    * 对于 `x = 1`，恰好有一个 `y` 满足 `bool2Int y = x`，也就是 `y=True`。
    * 对于不同于 `0` 和 `1` 的 `x`，没有任何 `y` 满足 `bool2Int y = x`。

   所以对每个 `x`，最多只有一个这样的 `y`，也就是 exactly one or none。

**Task**. 
证明 type `WorkingWeekDay` 是 type `WeekDay` 的一个 retract
```
data WeekDay = Mon | Tue | Wed | Thu | Fri | Sat | Sun

data WorkingWeekDay = Mon' | Tue' | Wed' | Thu' | Fri'

work2week :: WorkingWeekDay -> WeekDay
work2week Mon' = Mon
work2week Tue' = Tue
work2week Wed' = Wed
work2week Thu' = Thu
work2week Fri' = Fri

week2work :: WeekDay -> WorkingWeekDay
week2work Mon = Mon'
week2work Tue = Tue'
week2work Wed = Wed'
week2work Thu = Thu'
week2work Fri = Fri'
week2work Sat = Fri'
week2work Sun = Fri'
```
这里有一个puzzle练习，我把它放最后了

<a name="either"></a>
# The `Either` type constructor
一个 value 要么来自 type a，要么来自 type b

它在 prelude 里定义如下：
```hs
data Either a b = Left a | Right b
```
数据构造器（构造type的方法）
```hs
    Left  :: a -> Either a b
    Right :: b -> Either a b
```
例如：
```hs
    Left 17     :: Either Integer String
    Right "abd" :: Either Integer String
```
核心想法是：Left 和 Right 是一个标签

如用 `Right` 给 `b` 的 参数 打 tag

<a name="and"></a>
## The `And` type constructor, defined by ourselves

下面这个东西有一个 isomorphic version 已经在 language 里预定义好了，我们很快会看到：
```haskell
data And a b = Both a b
```
这是一个有两个 parameters 的 type constructor，并且有一个 element constructor `Both`。`Both` 是一个 function：
```hs
   Both :: a -> b -> And a b
```

例如，假设我们已经定义了 types `MainDish`、`Dessert`、`Drink`：
```haskell
data MainDish = Chicken | Pasta | Vegetarian
data Dessert = Cake | IceCream | Fruit
data Drink = Tea | Coffee | Beer
```
我们可以定义：
```haskell
type SaverMenu = Either (And MainDish Dessert) (And MainDish Drink)
```
它也可以等价地写成：
```hs
type SaverMenu = Either (MainDish `And` Dessert) (MainDish `And` Drink)
```
你可以选择自己更喜欢的 definition form。Haskell 两种都接受。

所以 saver menu 里可选的是：要么 main dish 加 dessert，要么 main dish 加 drink。直觉上，这显然和下面这个 type isomorphic：
```haskell
type SaverMenu' = And MainDish (Either Dessert Drink)
```
意思是：你有一个 main dish，并且 dessert 或 drink 二选一。这个直觉可以通过下面的 isomorphism 精确表达：
```haskell
prime :: SaverMenu -> SaverMenu'
prime (Left (Both m d)) = Both m (Left  d)
prime (Right(Both m d)) = Both m (Right d)

unprime :: SaverMenu' -> SaverMenu
unprime (Both m (Left  d)) = Left (Both m d)
unprime (Both m (Right d)) = Right(Both m d)
```
所以，作为 software developer，你可以选择 `SaverMenu` 作为 implementation，也可以选择 `SaverMenu'`。它们不同，但本质上 equivalent。

我们其实不需要自己定义 `And`，因为 Haskell 里已经有一个 equivalent type constructor，也就是 pairs 的 type。我们有下面这个 isomorphism：
```haskell
and2pair :: And a b -> (a,b)
and2pair (Both x y) = (x,y)

pair2and :: (a,b) -> And a b
pair2and (x,y) = Both x y
```
所以 saver menu type 还有更多 isomorphic versions：
```haskell
type SaverMenu''  = Either (MainDish, Dessert) (MainDish, Drink)
type SaverMenu''' = (MainDish, Either Dessert Drink)
```
去 book 里查一下 pairs，也就是 tuple types 的 type，并阅读相关内容。

<a name="lists"></a>
# Lists revisited

接下来几个 sections 的 video 可以在 [Canvas](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=985bb5d7-a2a2-4511-a6fb-ac620095003d) 上看。

稍微不严格地说，lists 的 type 可以看作是这样预定义的：
```hs
data [a] = [] | a : [a]  -- not quite a Haskell definition
```
它的意思是：一个 `a` 的 list 要么是 empty，要么是一个 type `a` 的 element 后面跟着一个 `a` 的 list，中间用 `:` 表示。
这是一个 *recursive* data type definition 的例子。List constructors 的 types 如下：
```hs
    []  :: [a]
    (:) :: a -> [a] -> [a]
```

虽然上面这个 not-quite-a-Haskell-definition 在 semantics 上是正确的，但在 syntax 上是错的，因为 Haskell 很遗憾不接受这种 syntactical definition。
如果我们不关心 syntax，可以定义一个 isomorphic version：
```haskell
data List a = Nil | Cons a (List a)
```
那么 constructors 的 types 是：
```hs
   Nil  :: List a
   Cons :: a -> List a -> List a
```
例如，native list `[1,2,3]` 在我们这个 isomorphic version 里写作 `Cons 1 (Cons 2 (Cons 3 Nil))`。我们来定义 isomorphism，让这件事更清楚：
```haskell
nativelist2ourlist :: [a] -> List a
nativelist2ourlist []     = Nil
nativelist2ourlist (x:xs) = Cons x (nativelist2ourlist xs)

ourlist2nativelist :: List a -> [a]
ourlist2nativelist Nil         = []
ourlist2nativelist (Cons x xs) = x:ourlist2nativelist xs
```
注意，这些 coercions 是 recursively 定义的，这对应了 data type 本身也是 recursively 定义的这个事实。

<a name="listops"></a>
## Implementing some basic operations on lists

我们来写自己的 list concatenation，也就是 "append"，以及 reverse operations，它们在 prelude 里也有：

```haskell
append :: List a -> List a -> List a
append Nil         ys = ys
append (Cons x xs) ys = Cons x (append xs ys)

rev :: List a -> List a
rev Nil         = Nil
rev (Cons x xs) = rev xs `append` (Cons x Nil)
```

我们可以通过把它们和 Haskell prelude 里的 list concatenation 和 reversal implementations 比较，来 test 它们是不是做对了。这里用到 `List a` 和 `[a]` 之间的 isomorphism。
也就是说，我们期待：
```hs
ourlist2nativelist (append (nativelist2ourlist xs) (nativelist2ourlist ys)) == xs ++ ys
```
以及：
```hs
ourlist2nativelist (rev (nativelist2ourlist xs)) == reverse xs
```
对所有 native lists `xs, ys :: [a]` 都 evaluate 成 `True`。
我们来 test 这些 properties：
```hs
> let xs = [1..5]
> let ys = [6..10]
> ourlist2nativelist (append (nativelist2ourlist xs) (nativelist2ourlist ys)) == xs ++ ys
True
> ourlist2nativelist (rev (nativelist2ourlist xs)) == reverse xs
True
```
当然，这里我们只在几个 examples 上 test 了，但它在 general 情况下也是真的。（Question: 你会怎么 *prove* 这个？）

虽然我们的 definitions 在 functionally 上是 correct 的，但 `rev` 的 implementation 有一个更 subtle 的问题。
通过检查代码可以看出，`append xs ys` 计算两个 lists 的 concatenation 需要 O(n) time，其中 n 是 `xs` 的 length，因为 `append` 的每次 recursive call 都让 `xs` 的 length 减少一，而且 `Cons` calls 是 constant time。
另一方面，用同样的 argument，`rev` 是 O(n²)，因为 `rev` 的每次 recursive call 都让 `xs` 的 length 减少一，而每次 call `append` 都是 O(n)。

这不只是 theoretical problem。如果我们比较用 native `reverse` function 和上面实现的 `rev` 来 reverse 一个 reasonably large list，很快就会撞到这个问题：
```hs
> let xs = [1..10^5]
> length (reverse xs)  -- this is fast (we return the length of the reversed list in order to keep the output small)
100000
> length (ourlist2nativelist (rev (nativelist2ourlist xs)))  -- this is really slow, so we give up and hit Control-C
  C-c C-cInterrupted.
```
有一个更 efficient 的 reversal implementation，方法是引入一个带额外 argument 的 helper function：
```haskell
fastrev :: List a -> List a
fastrev xs = revapp xs Nil
  where
    revapp :: List a -> List a -> List a
    revapp (Cons x xs) ys = revapp xs (Cons x ys)
    revapp Nil         ys = ys
```
理解 helper function `revapp` 的 second argument 的一种方式是：把它看成一个 stack，最开始设置为空，也就是 `Nil`。
这个 function recursively scan 第一个 argument 的 input，把每个 element push 到 stack，也就是 second argument 上。
当没有更多 input elements 时，stack 会直接被 popped 到 output，此时 original list 的所有 elements 都已经是 reverse order。

下面是一个 concrete illustration，展开 `fastrev` 和 `revapp` 的 definitions，reverse 一个 four-element list：

```hs
  fastrev (Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil))))
= revapp (Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil)))) Nil
= revapp (Cons 2 (Cons 3 (Cons 4 Nil))) (Cons 1 Nil)
= revapp (Cons 3 (Cons 4 Nil)) (Cons 2 (Cons 1 Nil))
= revapp (Cons 4 Nil) (Cons 3 (Cons 2 (Cons 1 Nil)))
= revapp Nil (Cons 4 (Cons 3 (Cons 2 (Cons 1 Nil))))
= Cons 4 (Cons 3 (Cons 2 (Cons 1 Nil)))
```

理解 function `revapp` 的另一个方式来自它的名字：给定两个 lists `xs` 和 `ys`，`revapp xs ys` 计算的是 `xs` 的 reversal *appended* with `ys`。
不难看出，这个 binary operation `revapp` 比原来的 unary reversal operation 更 *general*：原来的 reversal 可以通过取 `ys = Nil` 恢复出来。
另一方面，`revapp` 比我们原来的 function `rev` efficient 得多，它只需要 O(n) time，其中 n 是它第一个 argument `xs` 的 length。

这种 pattern 在 functional programming 中反复出现：我们通过把一个问题替换成一个更 general、看起来似乎更 difficult 的问题，反而成功解决了原问题，或者更 efficient 地解决了它。

<a name="accum"></a>
## An aside on accumulators

我们在 helper function `revapp` 里使用的 extra argument `ys` 有时叫做 "accumulator"，因为它 accumulates 一个最终会传到 output 的 value。
上面我们看到 accumulator 可以把 list reversal 的 O(n²) algorithm 变成 O(n) algorithm。
再看一个更明显的例子：计算 [Fibonacci numbers](https://en.wikipedia.org/wiki/Fibonacci_number) Fₙ。

Wikipedia 里 Fibonacci sequence 的 mathematical definition 可以直接翻译成下面的 Haskell code：

```haskell
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)
```

虽然这个 definition 是 correct 的，但它 extremely inefficient！

如果我们尝试用上面的 definition 计算前 32 个 Fibonacci numbers，就已经可以看到问题：

```hs
> :set +s -- ask ghci to print time and space usage
> [fib n | n <- [0..31]]
[0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765,10946,17711,28657,46368,75025,121393,196418,317811,514229,832040,1346269]
(10.23 secs, 4,086,282,024 bytes)
```

计算 32 个 Fibonacci numbers 居然超过十秒！
实际上，`fib n` 的 running time 大约是 O(2ⁿ)，因为 recursive case 会 call 两次 `fib`，但每次只让 `n` 减少 1 或 2。

下面是一个 alternative，而且 efficient 得多的 implementation，使用一对 accumulators `x` 和 `y`：

```haskell
fastfib n = fibAcc n 0 1
  where
    fibAcc 0 x y = x
    fibAcc 1 x y = y
    fibAcc n x y = fibAcc (n-1) y (x+y)
```

用这个 implementation，我们可以在 fraction of a second 内轻松计算前 100 个 Fibonacci numbers：

```hs
> [fastfib n | n <- [0..99]]
[0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765,10946,17711,28657,46368,75025,121393,196418,317811,514229,832040,1346269,2178309,3524578,5702887,9227465,14930352,24157817,39088169,63245986,102334155,165580141,267914296,433494437,701408733,1134903170,1836311903,2971215073,4807526976,7778742049,12586269025,20365011074,32951280099,53316291173,86267571272,139583862445,225851433717,365435296162,591286729879,956722026041,1548008755920,2504730781961,4052739537881,6557470319842,10610209857723,17167680177565,27777890035288,44945570212853,72723460248141,117669030460994,190392490709135,308061521170129,498454011879264,806515533049393,1304969544928657,2111485077978050,3416454622906707,5527939700884757,8944394323791464,14472334024676221,23416728348467685,37889062373143906,61305790721611591,99194853094755497,160500643816367088,259695496911122585,420196140727489673,679891637638612258,1100087778366101931,1779979416004714189,2880067194370816120,4660046610375530309,7540113804746346429,12200160415121876738,19740274219868223167,31940434634990099905,51680708854858323072,83621143489848422977,135301852344706746049,218922995834555169026]
(0.02 secs, 3,057,552 bytes)
```

为了看清楚发生了什么，我们同样可以在一个 concrete example 上 unroll definitions：

```hs
  fastfib 7
= fibAcc 7 0 1
= fibAcc 6 1 1
= fibAcc 5 1 2
= fibAcc 4 2 3
= fibAcc 3 3 5
= fibAcc 2 5 8
= fibAcc 1 8 13
= 13
```

我们可以看到，用一对 accumulator arguments `x` 和 `y` 实现 Fibonacci numbers 的这个 functional implementation，和在 Java 里用 loop 更新一对 variables `x` 和 `y` 的方式非常相似：

```java
static int fastfib(int n) {
  int x = 0, y = 1;
  while (n > 1) {
     int z = x+y;
     x = y;
     y = z;
     n = n-1;
  }
  return (n == 0 ? x : y);
}
```

除了这种 low-level view，也就是 `fastfib` 和 `fibAcc` 到底在做什么之外，还有一个更 high-level view，就像之前 `revapp` 的 case 一样。
你能不能找出一种意义，在这种意义下 helper function `fibAcc n x y` 计算的是比 `fib n` 更 *general* 的 function？

<a name="bintrees"></a>
# Binary trees

接下来几个 sections 的 video 可以在 [Canvas](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=dbfdfb07-23e8-4b8b-a167-ac6200988381) 上看。


Type `a` 上的 binary tree 要么是 empty，要么由一个被 type `a` 的 element 标记的 root 加上两个 binary trees 组成，这两个 trees 叫做 left subtree 和 right subtree：
```hs
data BT a = Empty | Fork a (BT a) (BT a)
```
* 我们有 empty tree，叫做 `Empty`。
  我们约定 empty trees 画成 dangling leaves。
  ```
                              |
  ```


* 给定两个 trees `l` 和 `r`，以及一个 element `x::a`，我们有一个 new tree：
  ```
                              x
                             / \
                            /   \
                           l     r
  ```
  写作 `Fork x l r`。

例如，tree：
```
                             8
                            / \
                           /   \
                          4     16
                         / \   / \
                        2        20
                       / \      /  \
```
用这个 notation 写作：
```haskell
btexample = Fork 8 (Fork 4 (Fork 2 Empty Empty) Empty) (Fork 16 Empty (Fork 20 Empty Empty))
```

我们可以像前面一样让 Haskell 通过 deriving 帮我们做一些工作：

```haskell
data BT a = Empty
          | Fork a (BT a) (BT a) deriving (Show, Read, Eq, Ord)
```

我们有：
```hs
   Empty :: BT a
   Fork  :: a -> BT a -> BT a -> BT a
```

**Puzzle**. Automatically derived 的 `Show`、`Read` 和 `Eq` 做什么应该比较清楚。但是你觉得用 `Ord` derived 出来的 trees 上的 order 应该是什么？*Hint.* 这是一个 non-trivial question。所以先考察 lists 的 type。在 lists 的 case 里，automatically derived order 是 [lexicographic order](https://en.wikipedia.org/wiki/Lexicographic_order)，也就是类似 dictionary order。


<a name="bintreefns"></a>
## Basic functions on binary trees

一开始，我们先 mirror trees。比如从上面的 tree 得到：
```
                             8
                            / \
                           /   \
                          16    4
                         / \   / \
                        20        2
                       / \       / \
```
做法如下：
```haskell
mirror :: BT a -> BT a
mirror Empty = Empty
mirror (Fork x l r) = Fork x (mirror r) (mirror l)
```
在上面的 example 上运行后得到：
```hs
    mirror btexample = Fork 8 (Fork 16 (Fork 20 Empty Empty) Empty) (Fork 4 Empty (Fork 2 Empty Empty))
```
这种 tree notation 不太适合 visualize trees，你也能看出来，但它很适合 computation。

我们把 tree 的 *size* 定义成它的 nodes 总数：
```haskell
size :: BT a -> Integer
size Empty        = 0
size (Fork x l r) = 1 + size l + size r
```
因为我们考虑的是 binary trees，所以 size，也就是 nodes 的数量，也等于 leaves 的数量减一：
```haskell
leaves :: BT a -> Integer
leaves Empty        = 1
leaves (Fork x l r) = leaves l + leaves r
```
我们把 tree 的 *height* 定义成从 root 出发的 longest path 的 length，用 nodes 数量来衡量：
```haskell
height :: BT a -> Integer
height Empty        = 0
height (Fork x l r) = 1 + max (height l) (height r)
```
一个 balanced binary tree 的 height 大约是它 size 的 log；而一个非常 unbalanced 的 binary tree，比如：
```
                            20
                           / \
                          16
                         / \
                        8
                       / \
                      4
                     / \
                    2
                   / \
```
```haskell
btleft = Fork 20 (Fork 16 (Fork 8 (Fork 4 (Fork 2 Empty Empty) Empty) Empty) Empty) Empty
```
它的 height 大约等于它的 size。

<a name="bintreeaddr"></a>
## Directions, addresses and paths in binary trees

接下来几个 sections 的 video 可以在 [Canvas](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=0904c115-0ad1-486c-945f-ac62009d2772) 上看。


为了从 binary tree 里选出某个 subtree，我们会连续向 left 或 right 走，直到找到它。但可能给出了错误的 directions list，这里叫做 address，所以 output 需要使用 `Maybe` type：
```haskell
data Direction = L | R deriving (Show)
type Address   = [Direction]

subtree :: Address -> BT a -> Maybe(BT a)
subtree []     t            = Just t
subtree (_:_)  Empty        = Nothing
subtree (L:ds) (Fork _ l _) = subtree ds l
subtree (R:ds) (Fork _ _ r) = subtree ds r
```
沿用上面的 pattern，我们可以定义一个 function，检查一个 address 在给定 tree 里是否 valid：
```haskell
isValid :: Address -> BT a -> Bool
isValid []     _            = True
isValid (_:_)  Empty        = False
isValid (L:ds) (Fork _ l _) = isValid ds l
isValid (R:ds) (Fork _ _ r) = isValid ds r
```
所有 valid addresses for subtrees 的 list 可以这样计算：
```haskell
validAddresses :: BT a -> [Address]
validAddresses Empty        = [[]]
validAddresses (Fork _ l r) = [[]]
                           ++ [L:ds | ds <- validAddresses l]
                           ++ [R:ds | ds <- validAddresses r]
```
List comprehensions 总是可以被消除。在这个 example 中，它们会变成：
```haskell
validAddresses' :: BT a -> [Address]
validAddresses' Empty        = [[]]
validAddresses' (Fork _ l r) = [[]]
                            ++ (map (L:) (validAddresses' l))
                            ++ (map (R:) (validAddresses' r))
```


我们期待：
```hs
    isValid ds t = ds `elem` (validAddresses t)
```
或者用文字说，一个 address 是 valid，当且仅当它是 valid addresses list 的一个 element。这在 intuition 上应该清楚吗？Statement 本身是清楚的。但考虑到我们的 definitions，这个 fact 我觉得并不是直接 obvious 的。我会说它需要一个 convincing argument。无论如何，intuition 是我们基于学到的 convincing arguments 慢慢发展出来的。

所有从 root 到 leaf 的 paths 的 list 也有类似的 definition：
```haskell
btpaths :: BT a -> [[a]]
btpaths Empty        = [[]]
btpaths (Fork x l r) = [x:xs | xs <- btpaths l]
                    ++ [x:xs | xs <- btpaths r]
```

<a name="bintreepf"></a>
## Proofs on binary trees by induction

如果我们有一个关于 trees 的 property `P`，并且想证明对所有 trees `t`，`P(t)` 都成立，那么可以用 *induction on trees*：

* 证明 `P(Empty)` 成立。
* 证明如果对给定 trees `l` 和 `r`，`P(l)` 和 `P(r)` 都成立，那么对 arbitrary `x`，`P(Fork x l r)` 也成立。

我们不会在这个 module 里特别强调 proofs，但当某些 claims 确实需要 proofs 时，我们会指出来。而且，我们会尽量精确地说明我们写的 programs 的 specifications。

经常会有这种情况：别人给我们展示了一个 clever algorithm，而我们因为不理解它而觉得自己很笨。但这种感觉是错的。如果我们不理解一个 algorithm，缺少的是 proof。Proof 就是 explanation。这就是 proof 的意思。为了理解一个 algorithm，我们需要：

  * algorithm 本身；
  * 它 intended to do 的 precise description；
  * 一个 convincing explanation，说明这个 algorithm 确实做到了它 intended to do 的事情。

Programs alone 是不够的。我们需要知道它们 intended to accomplish 什么，也想知道一个 explanation 来 justify 它们完成了我们 promise 的事情。这个 promise 叫做 algorithm / program 的 *specification*。Program correctness 意味着 “the promise is fulfilled”。尝试证明 promise 被 fulfilled 的一种方式是 *test* program。但实际上，testing 能做的只是通过找到 counterexamples 来说明 promise *not* fulfilled。当好的 examples 工作时，我们有某种 evidence 说明 algorithm works，但不是 full confidence，因为我们可能漏掉了会产生 wrong outputs 的 inputs。Full confidence 只能来自 convincing explanation，也就是 *proof*。如果你曾经问过自己 "proof" 到底是什么意思，ultimate answer 就是 "convincing argument"。

### Functional proofs

Dependently typed language [Agda](http://wiki.portal.chalmers.se/agda/pmwiki.php) 允许我们写 functional programs 以及它们的 correctness proofs，其中 [proofs themselves are written as functional programs](https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence)。
例如，[这里有一个 computer-checked proof](http://www.cs.bham.ac.uk/~mhe/fp-learning-2017-2018/html/Agda-in-a-Hurry.html)，证明了上面 `isValid` 和 `validAddresses` 之间的 relation，在 Agda 里完成。
这部分不 examinable，只是为了 illustration。

<a name="traversals"></a>
## Traversals in binary trees

接下来几个 sections 的 video 可以在 [Canvas](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=e194464a-dc4d-4fd5-8e03-ac6200a0ae73) 上看。


我们现在定义 standard in-order 和 pre-order [traversals](https://en.wikipedia.org/wiki/Tree_traversal)：
```haskell
treeInOrder :: BT a -> [a]
treeInOrder Empty = []
treeInOrder (Fork x l r) = treeInOrder l ++ [x] ++ treeInOrder r

treePreOrder :: BT a -> [a]
treePreOrder Empty = []
treePreOrder (Fork x l r) = [x] ++ treePreOrder l ++ treePreOrder r
```
例如，对于上面考虑过的 tree `btexample`：
```
                             8
                            / \
     btexample =           /   \
                          4     16
                         / \   / \
                        2        20
                       / \      /  \
```
我们得到：
```hs
> (treeInOrder btexample, treePreOrder btexample)
([2,4,8,16,20],[8,4,2,16,20])
```
而对于 `btleft`：
```
                            20
                           / \
                          16
                         / \
        btleft =        8
                       / \
                      4
                     / \
                    2
                   / \
```
我们得到：
```hs
> (treeInOrder btleft, treePreOrder btleft)
([2,4,8,16,20],[20,16,8,4,2])
```

[Breadth-first traversal](https://en.wikipedia.org/wiki/Breadth-first_search) 更 tricky。我们先定义一个 function，它接收一个 tree，然后产生一个 lists of lists：第一个 list 是 level zero 的 nodes，也就是 root；然后是 level one 的 nodes，也就是 root 的 successors；然后是 level two 的 nodes，以此类推：
```haskell
levels :: BT a -> [[a]]
levels Empty        = []
levels (Fork x l r) = [[x]] ++ zipappend (levels l) (levels r)
  where
    zipappend []       yss      = yss
    zipappend xss      []       = xss
    zipappend (xs:xss) (ys:yss) = (xs ++ ys) : zipappend xss yss
```
可以把 `zipappend` 和 prelude function [zipWith](https://hackage.haskell.org/package/base-4.12.0.0/docs/src/GHC.List.html#zipWith) 作比较。
例如：
```hs
> levels btexample
[[8],[4,16],[2,20]]
> levels btleft
[[20],[16],[8],[4],[2]]
```
有了这个，我们可以定义：
```haskell
treeBreadthFirst :: BT a -> [a]
treeBreadthFirst = concat . levels
```
其中 `.` 表示 function composition，可以在 textbook 里查；prelude function `concat :: [[a]] -> [a]` 会 concatenate 一个 list of lists，比如从 `[[8],[4,16],[2,20]]` 得到 `[8,4,16,2,20]`。关于 breadth-first search 的进一步讨论，可以看 [The under-appreciated unfold](https://dl.acm.org/citation.cfm?doid=289423.289455)，free version 在 [authors' web page](http://www.cs.ox.ac.uk/jeremy.gibbons/publications/unfold.ps.gz)，但这大概率超出了你们目前大多数人的 level。

<a name="gentree"></a>
## Inverting traversals (generating trees)

接下来几个 sections 的 video 可以在 [Canvas](https://bham.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=e2c84108-de51-42ce-a42b-ac6200bcd280) 上看。

很多不同的 trees 可以有相同的 in-order / pre-order / breadth-first traversal。上面我们已经看到了 `btexample` 和 `btleft`，它们有相同的 in-order traversal。
换句话说，所有这些 functions：
```hs
treeInOrder, treePreOrder, treeBreadthFirst :: BT a -> [a]
```
都是 *non-injective*，因此 non-invertible。
不过，一个有趣而且可以处理的问题是：尝试构造一个 binary tree，使它具有给定的 in-order / pre-order / breadth-first traversal；甚至可以尝试生成具有某个 traversal 的 *all possible binary trees*。

例如，下面这个 function 会根据一个 in-order traversal 产生一个 *balanced* binary tree。如果 input 是 sorted 的，那么它会是一个 binary *search* tree：
```haskell
balancedTree :: [a] -> BT a
balancedTree [] = Empty
balancedTree xs = let (ys, x:zs) = splitAt (length xs `div` 2) xs in
                  Fork x (balancedTree ys) (balancedTree zs)
```
Prelude function [`splitAt`](http://hackage.haskell.org/package/base-4.10.0.0/docs/Prelude.html#v:splitAt) 会在给定 position 把一个 list 分成两个 lists。
这个 function 满足 equation：
```hs
    treeInOrder (balancedTree xs) = xs
```
对所有 `xs :: [a]` 都成立。
反过来，下面这个肯定 **不** 成立：
```hs
    balancedTree (treeInOrder t) = t
```
并不是对所有 `t :: BT a` 都成立。例如：
```hs
balancedTree (treeInOrder btleft) = Fork 8 (Fork 4 (Fork 2 Empty Empty) Empty) (Fork 20 (Fork 16 Empty Empty) Empty)
```
它并不等于 `btleft`。
事实上，composite function：
```haskell
balance :: BT a -> BT a
balance = balancedTree . treeInOrder
```
也就是先把 `treeInOrder` 应用到 tree 上，再把 `balancedTree` 应用到 resulting list 上，可以看作一个 rebalancing binary tree 的 operation。

现在，使用 list comprehensions，从上面的 `balancedTree` function 到一个生成具有给定 in-order traversal 的 *all* binary trees 的 function，只差很小一步：
```haskell
inOrderTree :: [a] -> [BT a]
inOrderTree [] = [Empty]
inOrderTree xs = [Fork x l r | i <- [0..length xs-1],
                               let (ys, x:zs) = splitAt i xs,
                               l <- inOrderTree ys, r <- inOrderTree zs]
```
它满足这个 property：
```hs
elem t (inOrderTree xs)
```
当且仅当：
```hs
treeInOrder t = xs
```
对所有 `t :: BT a` 和 `xs :: [a]` 都成立。
例如，运行：
```hs
> inOrderTree [1..3]
[Fork 1 Empty (Fork 2 Empty (Fork 3 Empty Empty)),Fork 1 Empty (Fork 3 (Fork 2 Empty Empty) Empty),Fork 2 (Fork 1 Empty Empty) (Fork 3 Empty Empty),Fork 3 (Fork 1 Empty (Fork 2 Empty Empty)) Empty,Fork 3 (Fork 2 (Fork 1 Empty Empty) Empty) Empty]
```
会成功计算出所有五个 in-order traversal 是 `[1,2,3]` 的 binary search trees：
```
   1
  / \
     2
    / \
       3
      / \
Fork 1 Empty (Fork 2 Empty (Fork 3 Empty Empty))

   1
  / \
     3
    / \
   2
  / \
Fork 1 Empty (Fork 3 (Fork 2 Empty Empty) Empty)

     2
    / \
   /   \
  1     3
 / \   / \
Fork 2 (Fork 1 Empty Empty) (Fork 3 Empty Empty)

    3
   / \
  1
 / \
    2
   / \
Fork 3 (Fork 1 Empty (Fork 2 Empty Empty)) Empty

      3
     / \
    2
   / \
  1
 / \
Fork 3 (Fork 2 (Fork 1 Empty Empty) Empty) Empty
```

**Task:** 写一个 function `preOrderTree :: [a] -> [BT a]`，满足这个 property：对所有 `t :: BT a` 和 `xs :: [a]`，`elem t (preOrderTree xs)` 当且仅当 `treePreOrder t = xs`。

**Very hard task:** 写一个 function `breadthFirstTree :: [a] -> [BT a]`，满足这个 property：对所有 `t :: BT a` 和 `xs :: [a]`，`elem t (breadthFirstTree xs)` 当且仅当 `treeBreadthFirst t = xs`。[solution](https://patternsinfp.wordpress.com/2015/03/05/breadth-first-traversal/))

[1]: https://git.cs.bham.ac.uk/mhe/fp-learning-2021-2022/-/blob/master/Assignments/Formative2/README.md
--------
**Puzzle**. 考虑 function：
```hs
g :: Integer -> (Integer -> Bool)
g y = \x -> x == y
```
我们可以用下面的 table 来 visualize `g`：

|  | ... | -5 | -4 | ... | -1 | 0 | 1 | ... | 4 | 5 | ... |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| g(-5)= | ... | `True` | False | ... | False | False | False | ... | False | False | ... |
| g(-4)= | ... | False | `True` | ... | False | False | False | ... | False | False | ... |
| ... |
| g(-1)= | ... | False | False | ... | `True` | False | False | ... | False | False | ... |
| g(0)= | ... | False | False | ... | False | `True` | False | ... | False | False | ... |
| g(1)= | ... | False | False | ... | False | False | `True` | ... | False | False | ... |
| ... |
| g(4)= | ... | False | False | ... | False | False | False | ... | `True` | False | ... |
| g(5)= | ... | False | False | ... | False | False | False | ... | False | `True` | ... |

也就是说，function `g` 把 integer `y` code 成一个 function `h`，其中 `h y = True`，而对于不等于 `y` 的其他 `x`，都有 `h x = False`。你可以自己说服自己，function `g` 是一个 injection。从这个意义上说，type `Integer` live inside function type `Integer -> Bool`。你觉得 `g` 有没有一个 companion `f : (Integer -> Bool) -> Integer`，可以把 functions `Integer -> Bool` “decode” 回 integers，并且对于 integer `y` 的任意 code `g y`，都有 `f (g y) = y`？如果有，请给出这样一个 `f` 的 Haskell definition，并说服自己确实对所有 integers `y` 都有 `f (g y) = y`。如果没有，为什么？这个 puzzle 相当 tricky，而且这个问题无论回答 "yes" 还是 "no"，都不是 obvious 的。
