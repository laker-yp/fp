小笔记

`show` 123
-- "123"

`read` "True" :: Bool
-- True

type不一定是Int，Bool这种单个单词，也可以是(a,b)，Rose a，等等

x:xs 里面x不一定为单独一个单一元素，它代表的只是一个列表的第一个元素，如果列表元素为[[a]]，则x为[a]

case 里面为 结果的type， ->前面为具体的结果值

conjunction &&
disjunction ||


**tail**:去掉第一个元素之后剩下的 list。

tail[1,2,3]--输出[2,3]

**head**取 list 第一个元素的[1,2,3]--1

----
take n xs	保留前 n 个

drop n xs	删除前 n 个

**take**:从 list 前面取出前 n 个元素

take 3 [1,2,3,4,5]--输出[1,2,3]

**drop**：把前 n 个元素丢掉，返回剩下的 list。

drop 2 [1, 2, 3, 4, 5]--输出[4,5]

----

++ 两个list合并

:  把一个element加到list前面

  !!取出list索引为n的元素

  [10,20,30,40] !! 0  --10

----
sum[] 对list中的元素求和
