# User defined data types - part 1
## Contents

* [Type synonyms](#Type-synonyms类型的别名) 直接点这里开始吧
* [自定义data type](#datatypes)
  * [Bool type的复习](#booleans)
  * [Type isomorphisms同构](#typeisos)
  * [Weekdays例子](#weekdays)

* [type constructors](#logic)
  * [ `Maybe` ](#maybe)
  * [retracts](#retracts)
  * [ `Either` ](#either)
  * [ `And` , （自己定义）](#and)

* [Lists revisited](#lists)
  * [Implementing some basic operations on lists](#listops)
  * [An aside on accumulators](#accum)


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
如果你用 data 定义了一个类型，那么你之后写function来处理这个类型时

直接看它是由哪个 constructor 构造出来的，然后分别 **pattern-matching** （简单来说就是把每个construct列出来分别写pattern

比如，在 Haskell 里，&&：
```hs
(&&) :: Bool -> Bool -> Bool
```
定义如下：
```hs
False && _ = False
True  && x = x
```
再比如List 本质上也可以理解成
```
data [a] = [] | a : [a]
```
那么在写f的pattern的时候也是先对[]做，再对a : [a]做

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

Either 最常见的实际用途就是：

表示一个结果可能成功，也可能失败，而且失败时可以带错误信息，不像nothing，失败了只显示Nothing

所以我理解为Either就相当于Maybe改版，同样是二选一不过把nothing给改成了一个具体的输出

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
## Either具体例子
```
myDiv :: Int -> Int -> 【Either String Int】
myDiv x 0 = Left "c n m"
myDiv x y = Right (x `div` y)--括号内是一个Int类
```
核心想法是：Left 和 Right 是一个标签，通过这个可以理解*Maybe a*的Maybe也只是一个标签

<a name="and"></a>
# `And` type constructor, 自定义

其实就是pair, (a,b)

下面这个东西有一个 isomorphic version 已经在 language 里预定义好了，我们很快会看到：
```haskell
data And a b = Both a b
```
`And`是一个有*两个参数*的 类型构造器

`Both` 是一个数据构造器，也是一个function：
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
当然，And a b 等价于 a `And` b

isomorphic：
```haskell
type SaverMenu' = And MainDish (Either Dessert Drink)
```
其实根本不需要定义and，pair就是它的 isomorphism：
```haskell
and2pair :: And a b -> (a,b)
and2pair (Both x y) = (x,y)

pair2and :: (a,b) -> And a b
pair2and (x,y) = Both x y
```
所以下面这个版本的也是完全一样的：

(And MainDish Dessert)等价于(MainDish , Dessert)

<a name="lists"></a>
# Lists revisited

lists 的 type 可以看作是这样定义的（单纯为了学习）
```hs
data [a] = [] | a : [a] 
```
`a` 的 list 要么是 empty，要么是一个 `a` : `a` 的 list

这是一个 *recursive* data type definition 的例子

List 的两个数据构造器如下
```hs
    []  :: [a]
    (:) :: a -> [a] -> [a]
```
另一个版本version（只是为了学习）

Nil = 空 list
```haskell
data Mylist a = Nil | Cons a (List a)
```
数据构造器是：
```hs
   Nil  :: List a
   Cons :: a -> List a -> List a
```
list `[1,2,3]` 在mylist里写作 `Cons 1 (Cons 2 (Cons 3 Nil))`

通过定义 isomorphism，让这件事更清楚：
```haskell
list2mylist :: [a] -> List a
list2mylist []     = Nil
list2mylist (x:xs) = Cons x (list2mylist xs)

mylist2list :: List a -> [a]
mylist2list Nil         = []
mylist2list (Cons x xs) = x:mylist2list xs
```
注意，这些 coercions 是 recursively 定义的，这对应了 data type 本身也是 recursively 定义的这个事实。

<a name="listops"></a>
## Implementing some basic operations on lists

有了mylist我们来写自己的就是 "append"，以及 reverse方程

```haskell
data List a = Nil | Cons a (List a)    --为了方便理解，把Cons想成":"然后放在a和List a之间

append :: List a -> List a -> List a
append Nil         ys = ys
append (Cons x xs) ys = Cons x (append xs ys)

rev :: List a -> List a
rev Nil         = Nil
rev (Cons x xs) = rev xs `append` (Cons x Nil)
```
通过来下面的测色来看看是不是做对了。这里用到 `List a` 和 `[a]` 之间的 isomorphism。

```hs
> let xs = [1..5]
> let ys = [6..10]

> ourlist2nativelist (append (nativelist2ourlist xs) (nativelist2ourlist ys)) == xs ++ ys
True
> ourlist2nativelist (rev (nativelist2ourlist xs)) == reverse xs
True  --成功啦
```
问题是，rev和append都超级慢，要O(n方)，可以通过
fastrev :: List a -> List a

fastrev xs = revapp xs Nil 来提升速度，【stack模拟】，详细的我省略了

```hs
> let xs = [1..10^5]
> length (reverse xs)  -- this is fast 
100000
> length (ourlist2nativelist (rev (nativelist2ourlist xs)))  -- this is really slow
```
有一个更 efficient 的 reverse，方法是引入一个带额外参数的helper function：
```haskell
fastrev :: List a -> List a
fastrev xs = revapp xs Nil
  where
    revapp :: List a -> List a -> List a
    revapp (Cons x xs) ys = revapp xs (Cons x ys)
    revapp Nil         ys = ys
```
-1 理解 `revapp` 的 第二个参数看成一个 stack，最开始设置为 `Nil`
-2这个 function recursively scan 第一个 argument 的 input，把每个 element push 到 stack，也就是 second argument 上。
-3当没有更多 input elements 时，stack 会直接被 popped 到 output，此时 original list 的所有 elements 都已经是 reverse order。

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
