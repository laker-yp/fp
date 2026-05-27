# Problem Sheet for Week 6

## Binary Search Trees

The following challenges occur in the LectureNotes on [Binary search trees](../LectureNotes/Sections/Data2.md#binary-search-trees).  See if you can solve them:

1. Can you write another version of isBST that runs in linear time without producing the in-order traversal list as an intermediate step?

2. Can you write a function delete' with a Maybe return type to indicate that there is nothing to delete?

3. Can you combine the last two functions largestOf and withoutLargest into a single one, using a pair type as the result, so as to get a more efficient version of the delete function? And then this together with Maybe rather than using undefined?

## Rose Trees

Recall the definition of [Rose trees](../LectureNotes/Sections/Data2.md#rose-trees):

```hs
data Rose a = Branch a [Rose a]
```

Just as binary trees have a notion of "direction" and "address" which allows us to access specific nodes in the tree (See [here](../LectureNotes/Sections/Data1.md#directions-addresses-and-paths-in-binary-trees)), so do Rose trees.

Let us defined a **direction** as an `Int` representing the position in the list of descendants and an **address** as a list of directions.

```haskell
type Direction = Int
type Address = [Direction]
```
1. Write a function `validAddresses :: Rose a -> [Address]` which returns all the valid addresses in a given tree.
2. Write a function `getAtAddress :: Rose a -> Address -> Maybe a` which returns the value found at the node specified by the given
address provided that it is valid.

## Game Trees

1. Define datatypes for representing Naughts and Crosses boards and moves and implement the analog of the `nimPlays` function described in the section of [Game Trees](../LectureNotes/Sections/Data2.md#game-trees) for this game.

## Exercise 1 - Applying Functions to Trees

### Background Material

There are many possible variants of the type of binary trees
introduced in the Lecture Notes.  For example, consider the following
definition:

```haskell
data Tree a b = Leaf b | Fork (Tree a b) a (Tree a b)
  deriving (Eq, Show)
```
Notice how now, the tree stores two different types
of data: an element of type `a` at each fork and an element of type
`b` at each leaf.

### Implementation Task

Your task is to write a higher-order function `applyfuns` that takes
two functions `f :: a -> b` and `g :: b -> d`, as well as an element
of type `Tree a b` as input and applies the first function to the
values found at the forks, and the second function to the values found
at the leaves.  That is, implement the function:

```haskell
applyfuns :: (a -> c) -> (b -> d) -> Tree a b -> Tree c d
applyfuns = undefined
```
### Examples

Lets consider the following two functions:

```haskell
str2int :: String -> Int
str2int xs = length xs

int2bool :: Int -> Bool
int2bool n = n /= 0
```

and the following binary tree:
```
       "John"
       /    \
      /      \
  "Oliver" "Benjamin"
   /   \      /   \
  /     \    /     \
 2       4  0       6
```

Then the expression `applyfuns str2int int2bool` should return the tree
```
          4
       /    \
      /      \
     6          8
   /   \      /   \
  /     \    /     \
True   True False  True
```

```hs
*Main> applyfuns str2int int2bool (Fork (Fork (Leaf 2) "Oliver" (Leaf 4)) "John" (Fork (Leaf 0) "Benjamin" (Leaf 6)))
Fork (Fork (Leaf True) 6 (Leaf True)) 4 (Fork (Leaf False) 8 (Leaf True))

```

As a second example, the tree
```
                   "New York"
                    /      \
                   /        \
              "Paris"      "Dubai"
              /    \	   /    \
             /      \     /      \
        "London"    14   5    "Shanghai"
           /   \                /     \
          /     \              /       \
         0      10            0        21
```
is transformed into the tree
```
                       8
                    /      \
                   /        \
                 5           5
              /    \	   /    \
             /      \     /      \
             6     True True       8
           /   \                /     \
          /     \              /       \
        False  True          False     True
```

```hs
*Main> applyfuns str2int int2bool (Fork (Fork (Fork (Leaf 0) "London" (Leaf 10)) "Paris" (Leaf 14)) "New York" (Fork (Leaf 5) "Dubai" (Fork (Leaf 0) "Shanghai" (Leaf 21))))
Fork (Fork (Fork (Leaf False) 6 (Leaf True)) 5 (Leaf True)) 8 (Fork (Leaf True) 5 (Fork (Leaf False) 8 (Leaf True)))

```

## Exercise 2 - Updating Nodes Along a Route

### Background Material

In this exercise, we return to a version of binary trees which stores data only at the nodes.  We will use the following definition:
```haskell
data BinTree a = Empty | Node (BinTree a) a (BinTree a)
  deriving (Eq, Show)
```

Next, we define a type `Route` which will describe the "route" one must take to arrive at a particular node in one of our trees.

```haskell
data Direction = GoLeft | GoRight
  deriving (Eq, Show, Bounded, Enum)

type Route = [Direction]
```

So a route is a list of directions, which tell you whether to go left or right,
starting from the root of the binary tree. For example,

1. The route to the root of any binary tree is `[] :: Route`.
1. In the tree `Node (Node Empty 'b' Empty) 'a' (Node (Node Empty 'd'
   Empty) 'c' (Node Empty 'e' Empty))`, pictured below, the route `[GoLeft]`
   takes you to the node with value 'b', while the routes to the nodes
   with values 'd' and 'e' are `[GoRight,GoLeft]` and
   `[GoRight,GoRight]` respectively.
   ```
                  'a'
                  / \
                 /   \
               'b'   'c'
                     / \
                    /   \
                  'd'   'e'
   ```

### Implementation Task

Your task is to implement the function
```haskell
updateNodes :: Route -> (a -> a) -> BinTree a -> BinTree a
updateNodes = undefined
```
such that `updateNodes r f t` applies `f` to the values of all nodes along the route `r` in the tree `t`.

**NB**:
1. If you run out of directions before hitting a leaf, e.g. if running
`updateNodes` on the route `[GoRight]` in the tree above, then you
stop and do **not** modify the remainder of the tree (the values `'d'`
and `'e'` in the example).
1. If the route is too long, e.g. if running `updateNodes` on the
route `[GoLeft,GoLeft]` in the tree above, then you discard the
remainder of the route (so in the example, you would only update the
values `'a'` and `'b'` and then stop).

The examples given below should also help to clarify these points.

### Examples

For the following binary tree:
```
       1
      / \
     2   \
    / \	  99
   /   \   \
  3     4   \
            100
```

```hs
*Main> let t = Node (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty)) 1 (Node Empty 99 (Node Empty 100 Empty))
*Main> updateNodes [] (*8) t
Node (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty)) 8 (Node Empty 99 (Node Empty 100 Empty))
*Main> updateNodes [GoRight] (*8) t
Node (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty)) 8 (Node Empty 792 (Node Empty 100 Empty))
*Main> updateNodes [GoRight,GoLeft] (*8) t
Node (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty)) 8 (Node Empty 792 (Node Empty 100 Empty))
*Main> updateNodes [GoRight,GoRight] (*8) t
Node (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty)) 8 (Node Empty 792 (Node Empty 800 Empty))
*Main> updateNodes [GoRight,GoRight,GoLeft] (*8) t
Node (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty)) 8 (Node Empty 792 (Node Empty 800 Empty))
*Main> updateNodes [GoLeft,GoLeft,GoLeft] (*15) t
Node (Node (Node Empty 45 Empty) 30 (Node Empty 4 Empty)) 15 (Node Empty 99 (Node Empty 100 Empty))
```

**NB**: Remember that we are not storing the results of running `updateNodes`
above, so all examples above are run on the same tree
`t = Node (Node (Node Empty 3 Empty) 2 (Node Empty 4 Empty)) 1 (Node Empty 99 (Node Empty 100 Empty))`.
