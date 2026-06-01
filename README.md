小笔记

`show` 123
-- "123"

`read` "True" :: Bool
-- True

### maybe的转化
```
f :: Input -> Output
```
变成
```hs
fMaybe :: Input -> Maybe Output
fMaybe input
  | 成功条件  = Just 结果
  | 失败条件  = Nothing
```
```hs
findBST :: Ord a => a -> BT a -> Maybe a
findBST :: Ord a => a -> BT a -> Maybe a
findBST x Empty = Nothing

findBST x (Fork y l r)
  | x == y    = Just y
  | x < y     = findBST x l
  | otherwise = findBST x r
```

type不一定是Int，Bool这种单个单词，也可以是(a,b)，Rose a，等等

x:xs 里面x不一定为单独一个单一元素，它代表的只是一个列表的第一个元素，如果列表元素为[[a]]，则x为[a]

case 里面为 结果的type， ->前面为具体的结果值

conjunction &&
disjunction ||



----
sum[] 对list中的元素求和
