<a name="gametrees"></a>
# Game trees
* 前提：已知有两个type: boards 和 moves

* 对于任意给定的 board，我们都知道有哪些 possible moves，以及执行每个 move 之后会得到相应的 board
  
* 给定一个初始 board，我们就可以构造出一个 game tree，表示所有可能的 play：

```haskell
                   --Node 当前棋盘状态 [(一个move, 走完之后的子游戏树)]
data GameTree board move = Node board [(move, GameTree board move)] 
					deriving (Show)

gameTree ::(board -> [(move,board)]) -> board -> GameTree board move
gameTree plays board = Node board [(m, gameTree plays b) | (m,b) <- plays board]
```
**第一个输入**为(board -> [(move,board)])也就是plays

plays :: board -> [(move, board)]

      当前局面 -> [(走法 , 新局面)]
	  
plays board = [(m1, b1), (m2, b2), (m3, b3)]

  -意思是给你一个局面 board，返回所有合法走法and对应的新局面列表。
  
**第二个输入**入为board 也就是初始(当前)局面

**输出**：从这个初始局面开始的整棵game tree
[(m, gameTree plays b) | (m,b) <- plays board]

|右边是通过plays将初始board生成的一个个(m,b)，

把(m,b)一个个丢到|左边的(m, gameTree plays b)对m,b进行处理

处理方法：对每个 (m,b)，构造一个分支：m以及相应的分枝(从 b 开始继续生成的 game tree)

1先调用 plays board

2它会列出所有合法走法 (m,b)

  -m 是这一步怎么走
  -b 是走完后的新局面
3对每个 (m,b)，构造一个分支：
  -边标签是 m
  -子树是从 b 开始继续生成的 game tree

  **建议举例理解**
  
为了让这个更具体一些，我们把它应用到游戏 [Nim](https://en.wikipedia.org/wiki/Nim) 上。

在这个例子里，"board" 是若干 heap 组成的集合。由于只有数量重要，所以我们把它表示成一个 `Integer` list。一个 move 则表示为：选择某个 heap，并移除若干个对象，

因此我们把它表示成一个 pair：一个 `Int`（heap 的索引）和一个 `Integer`（要移除的对象个数）：

# Nim

```haskell
type NimBoard = [Integer]  --起别名
data NimMove = Remove Int Integer --定义新类型
  deriving (Show,Eq) 
```
* 第一行Nim的Board是什么意思？index代表第几heap，数字代表这个索引的heap有多少个石头

比如 [1,2,8]代表：
heap 0: 1 个石头

heap 1: 2 个石头

heap 2: 8 个石头

* 第二行Nim的Move什么意思？定义新type 【NimMove】

数据构造器为Remove，需要传入两个参数Int代表heap索引Integer代表要移除的石头数
```
Remove 2 8 --把第三堆的石头去掉搬走八个,所以这时候的board就为[1,2,0]
```
下面这个 `plays` 函数描述了：从给定 Nim position 出发，所有合法的 moves：

```haskell
--                    (Remove 2 8, [1,2,0])
nimPlays :: NimBoard -> [(NimMove,NimBoard)]
--   list comprehension [ 生成结果 | 枚举 i, 拆分 list, 枚举 k ]
nimPlays heaps = [(Remove i k, (hs ++ h-k : hs')) 
                 | i <- [0..length heaps-1], --【i被注入第一个堆(0)到最后一个堆(length heaps-1)的index】
                   let (hs, h:hs') = splitAt i heaps,  --【将heaps(board那个list)以i为基准分为左右两边】
                   k <- [1..h]] --【从当前 heap 里，可以拿走 1 到 h 个石头】
```
比如nimPlays [1,2,8] = [....(Remove 2 8, [1,2,0])....]

把它作为 `gameTree` 的第一个参数传进去，我们就可以计算从某个给定 Nim position 出发的整个 game tree：

(Remove i k, (hs ++ h-k : hs'))

(一个move  ,  对应的board那个list变为：i索引左边的hs ++ i索引的h个石头被拿走了k个 ：i索引右边的)

```haskell
nim :: [Integer] -> GameTree NimBoard NimMove
nim = gameTree nimPlays
```

（注意，这个定义是 "[point-free](https://wiki.haskell.org/Pointfree)" 的,和下面普通版本是等价的
```haskell
nim :: [Integer] -> GameTree NimBoard NimMove
nim initHeaps = gameTree nimPlays initHeaps --gameTree是生成当前局面会产生的所有哦(m,b)，后面两个是传入的参数，play和当前的局面
```
我们用 Nim 试一试：

```hs
> nim [2]
Node [2] [(Remove 0 1,Node [1] [(Remove 0 1,Node [0] [])]),(Remove 0 2,Node [0] [])]
> nim [2,1]
Node [2,1] [(Remove 0 1,Node [1,1] [(Remove 0 1,Node [0,1] [(Remove 1 1,Node [0,0] [])]),(Remove 1 1,Node [1,0] [(Remove 0 1,Node [0,0] [])])]),(Remove 0 2,Node [0,1] [(Remove 1 1,Node [0,0] [])]),(Remove 1 1,Node [2,0] [(Remove 0 1,Node [1,0] [(Remove 0 1,Node [0,0] [])]),(Remove 0 2,Node [0,0] [])])]
> nim [1,1,1]
Node [1,1,1] [(Remove 0 1,Node [0,1,1] [(Remove 1 1,Node [0,0,1] [(Remove 2 1,Node [0,0,0] [])]),(Remove 2 1,Node [0,1,0] [(Remove 1 1,Node [0,0,0] [])])]),(Remove 1 1,Node [1,0,1] [(Remove 0 1,Node [0,0,1] [(Remove 2 1,Node [0,0,0] [])]),(Remove 2 1,Node [1,0,0] [(Remove 0 1,Node [0,0,0] [])])]),(Remove 2 1,Node [1,1,0] [(Remove 0 1,Node [0,1,0] [(Remove 1 1,Node [0,0,0] [])]),(Remove 1 1,Node [1,0,0] [(Remove 0 1,Node [0,0,0] [])])])]
```

Nim 通常作为一个 two-player game 在 ["misère"](https://en.wikipedia.org/wiki/Mis%C3%A8re) 规则下进行：第一个**不能**走的人获胜；但它也可以按普通 two-player game 规则玩：第一个**不能**走的人失败。对于某个给定 position，先手是否有 *winning strategy*，这个问题完全可以封装进 game trees 的逻辑之中。

```haskell
isWinning, isLosing :: Bool -> GameTree board move -> Bool
isWinning isMisere (Node b mgs)
        | null mgs  = isMisere
        | otherwise = any (isLosing isMisere)  [g | (m,g) <- mgs]
isLosing  isMisere (Node b mgs)
        | null mgs  = not (isMisere)
        | otherwise = all (isWinning isMisere) [g | (m,g) <- mgs]
```

试试看：

```hs
> isWinning True (nim [2])
True
> isWinning True (nim [2,1])
True
> isWinning True (nim [1,1,1])
False
> isWinning False (nim [1,1,1])
True
```
