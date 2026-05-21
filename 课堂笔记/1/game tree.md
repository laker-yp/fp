在这个例子里，"board" 是若干 heap 组成的集合。由于只有数量重要，所以我们把它表示成一个 `Integer` list。一个 move 则表示为：选择某个 heap，并移除若干个对象，因此我们把它表示成一个 pair：一个 `Int`（heap 的索引）和一个 `Integer`（要移除的对象个数）：

```haskell
type NimBoard = [Integer]
data NimMove = Remove Int Integer  deriving (Show,Eq)
```

下面这个 `plays` 函数描述了：从给定 Nim position 出发，所有合法的 moves：

```haskell
nimPlays :: NimBoard -> [(NimMove,NimBoard)]
nimPlays heaps = [(Remove i k, (hs ++ h-k : hs'))
                 | i <- [0..length heaps-1],
                   let (hs, h:hs') = splitAt i heaps,
                   k <- [1..h]]
```

把它作为 `gameTree` 的第一个参数传进去，我们就可以计算从某个给定 Nim position 出发的整个 game tree：

```haskell
nim :: [Integer] -> GameTree NimBoard NimMove
nim = gameTree nimPlays
```

（注意，这个定义是 "[point-free](https://wiki.haskell.org/Pointfree)" 的，而且我们只对函数 `gameTree` 做了部分应用。上面的定义和 `nim initHeaps = gameTree nimPlays initHeaps` 完全等价，只是更简洁。）

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
