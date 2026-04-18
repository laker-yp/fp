# `data` 后面那些东西到底是什么

我现在很多题写不出来，根本原因之一，不是递归本身太难，而是我对下面这些基础概念还不够清晰：

- `data` 后面那一整行到底在说什么
- 什么叫构造器
- `a` 是什么
- 为什么有的后面带东西，有的什么都不带
- 为什么有时候会递归地出现自己

如果这里模糊，后面的 pattern matching、递归、写函数，都会很容易乱掉。

---

# 总纲

像这种定义：

```haskell
data Expr = Var Char | Not Expr | And Expr Expr
```

要理解成：

> 我在定义一种新的类型，名字叫 `Expr`。  
> 一个 `Expr` 类型的值，可以用几种不同的“方式”造出来。  
> 这些“造值的方法”就叫 **构造器**。

---

# 一、`data` 到底是在干嘛？

## 例子
```haskell
data Bool = False | True
```

这句话的意思不是“在计算”，而是：

> 我定义了一个新类型，叫 `Bool`。  
> 这个类型的值只有两种：
> - `False`
> - `True`

这里：

- `Bool` 是 **类型名**
- `False` 和 `True` 是 **构造器**

---

# 二、什么是构造器？

构造器可以先粗暴理解成：

## “造出这个类型的值的方法 / 形状”

比如：

```haskell
data Direction = L | R
```

这句话的意思是：

> `Direction` 类型的值，要么是 `L`，要么是 `R`

所以：

- `L` 是构造器
- `R` 是构造器

而且这里它们后面什么都没带。

这种叫：

## 不带参数的构造器

---

# 三、带参数的构造器是什么？

看这个：

```haskell
data Maybe a = Nothing | Just a
```

这里定义的是类型 `Maybe a`，它有两种造法：

- `Nothing`
- `Just a`

意思是：

- `Nothing`：直接就是一个值
- `Just a`：你要先给我一个 `a` 类型的东西，我才能造出一个 `Maybe a`

比如：

```haskell
Just 3
Just 'x'
```

所以：

## 构造器后面跟的东西，表示“造这个值时需要带上的内容”

---

# 四、`a` 到底是什么？

## `a` 是类型变量（type variable）

你可以先把它理解成：

> “先别管具体是什么类型，先留一个空位，以后再填”

---

## 例子 1

```haskell
data Maybe a = Nothing | Just a
```

这里的 `a` 不是某个具体值，也不是固定类型。  
它表示：

> `Maybe` 可以装任意类型

比如：

- `Maybe Int`
- `Maybe Char`
- `Maybe Bool`

对应的值可以是：

```haskell
Just 5       -- Maybe Int
Just 'p'     -- Maybe Char
Just True    -- Maybe Bool
Nothing      -- Maybe a
```

---

## 例子 2

```haskell
data Rose a = Leaf a | Branch [Rose a]
```

这里的 `a` 也是一样，表示：

> 这是一棵“装着某种类型内容”的树，但具体装什么还没定

比如：

- `Rose Int`
- `Rose Char`

如果是 `Rose Int`，那么：

```haskell
Leaf 3
```

就是合法的。

如果是 `Rose Char`，那么：

```haskell
Leaf 'x'
```

就是合法的。

---

# 五、为什么有时候有 `a`，有时候没有？

因为有的类型需要“留一个类型空位”，有的不需要。

---

## 没有 `a` 的例子

```haskell
data Direction = L | R
```

这里 `Direction` 就是固定的类型，不涉及“里面可以装别的类型”。  
所以不需要 `a`。

---

## 有 `a` 的例子

```haskell
data Box a = Box a
```

这里 `Box` 想表达的是：

> 一个盒子，里面可以装任意类型的东西

所以要写 `a`。

---

# 六、怎么判断谁是类型名，谁是构造器？

一个很好用的规律：

## 在 Haskell 里，类型名和构造器名通常都大写开头

比如：

```haskell
data Expr = Var Char | Not Expr
```

这里：

- `Expr` 是类型名
- `Var` 是构造器
- `Not` 是构造器
- `Char` 是一个已有的类型

---

# 七、怎么读一整行 `data` 定义？

这个一定要会。

---

## 例子 1

```haskell
data Expr = Var Char | Not Expr | And Expr Expr
```

读法：

> 定义一个新类型 `Expr`。  
> 一个 `Expr` 的值有三种可能：
> 1. `Var Char`：一个变量，里面带一个 `Char`
> 2. `Not Expr`：一个非，里面带一个 `Expr`
> 3. `And Expr Expr`：一个与，里面带两个 `Expr`

---

## 例子 2

```haskell
data Rose a = Leaf a | Branch [Rose a]
```

读法：

> 定义一个新类型 `Rose a`。  
> 一个 `Rose a` 的值有两种可能：
> 1. `Leaf a`：叶子，里面放一个 `a`
> 2. `Branch [Rose a]`：分支，里面放一个列表，列表中的每个元素都是 `Rose a`

这就是为什么它是树，因为 `Branch` 里面又出现了 `Rose a`，所以它是递归定义。

---

# 八、为什么有的构造器后面啥都没有？

比如：

```haskell
data Traffic = Red | Yellow | Green
```

这里：

- `Red`
- `Yellow`
- `Green`

后面什么都没带。

意思就是：

> 这个类型的值只有这三种，没别的信息了

这种构造器就像“枚举值”。

---

# 九、为什么有的构造器带一个，有的带两个？

因为它们要保存的信息量不同。

---

## 一个参数

```haskell
data Maybe a = Nothing | Just a
```

`Just` 需要带一个东西。

---

## 两个参数

```haskell
data Pair a b = Pair a b
```

`Pair` 需要带两个东西。

比如：

```haskell
Pair 3 'x'
```

---

## 递归两个参数

```haskell
data Expr = And Expr Expr
```

这里 `And` 的意思是：

> 一个“与”表达式，要有左右两个子表达式

所以带两个 `Expr`。

---

# 十、pattern matching 为什么能那样写？

因为你是在按构造器拆。

比如：

```haskell
data Expr = Var Char | Not Expr | And Expr Expr
```

那你写：

```haskell
f (Var c) = ...
f (Not e) = ...
f (And e1 e2) = ...
```

意思是：

- 如果输入是 `Var` 造出来的，就把里面的 `Char` 取出来，叫 `c`
- 如果输入是 `Not` 造出来的，就把里面的 `Expr` 取出来，叫 `e`
- 如果输入是 `And` 造出来的，就把里面两个 `Expr` 取出来，叫 `e1` 和 `e2`

所以这些名字不是提前定义的，而是：

## 你在拆构造器时，临时起的名字

---

# 十一、我现在最容易混淆的三个东西

这个必须分清。

---

## 1. 类型名
比如：

```haskell
Expr
Rose a
Maybe a
```

这是“这一类东西叫什么”。

---

## 2. 构造器
比如：

```haskell
Var
Not
And
Leaf
Branch
Just
Nothing
```

这是“怎么造出这种值”。

---

## 3. 构造器里装的参数
比如：

```haskell
Char
Expr
Expr Expr
a
[Rose a]
```

这是“造值时需要带的内容”。

---

# 十二、拿一个例子彻底拆开

## 例子

```haskell
data Rose a = Leaf a | Branch [Rose a]
```

分解：

### `data`
我要定义一个新类型

### `Rose a`
类型名叫 `Rose`，带一个类型变量 `a`

### `=`
下面开始列出这个类型有哪些构造器

### `Leaf a`
构造器 `Leaf`，它要带一个 `a`

### `|`
或者

### `Branch [Rose a]`
构造器 `Branch`，它要带一个 `[Rose a]`，也就是“树的列表”

---

# 十三、构造器也可以先理解成“函数”

这是一个很有用的理解方式。

比如：

```haskell
data Rose a = Leaf a | Branch [Rose a]
```

你可以把构造器先理解成：

```haskell
Leaf   :: a -> Rose a
Branch :: [Rose a] -> Rose a
```

意思是：

- 给 `Leaf` 一个 `a`，它会造出一个 `Rose a`
- 给 `Branch` 一个 `[Rose a]`，它会造出一个 `Rose a`

同理：

```haskell
data Expr = Var Char | Not Expr | And Expr Expr
```

可以先理解成：

```haskell
Var :: Char -> Expr
Not :: Expr -> Expr
And :: Expr -> Expr -> Expr
```

所以：

```haskell
Var 'p'
Not (Var 'p')
And (Var 'p') (Var 'q')
```

本质上就是“用构造器造值”。

---

# 十四、为什么有时候会递归出现自己？

比如：

```haskell
data Expr = Not Expr | And Expr Expr
```

这里构造器里面又出现了 `Expr`。

这表示：

> 一个 `Expr` 可以由更小的 `Expr` 组成

这就是递归数据类型。

再比如：

```haskell
data Rose a = Leaf a | Branch [Rose a]
```

这里 `Branch` 里面放的是 `[Rose a]`，说明：

> 一棵树里面可以放很多更小的树

所以它是树结构。

---

# 十五、我现在应该学会的读法模板

以后看到任何一行 `data`，都强迫自己说出下面四件事：

## 1. 类型名是什么？
## 2. 有几个构造器？
## 3. 每个构造器后面带什么？
## 4. 哪些地方是递归的？

---

## 例子

```haskell
data Expr = Var Char | Not Expr | And Expr Expr
```

我应该能立刻说：

- 类型名：`Expr`
- 构造器：`Var`、`Not`、`And`
- `Var` 带一个 `Char`
- `Not` 带一个 `Expr`
- `And` 带两个 `Expr`
- `Not` 和 `And` 都是递归的，因为里面又出现了 `Expr`

---

# 十六、最短最核心的总结

## `data` 定义 = 定义一种新类型

## `=` 后面列的是这个类型有哪些构造器

## 构造器后面跟的东西 = 造这个值时要带的内容

## `a` = 类型变量，表示“先留空，以后再决定具体类型”

## 没带参数的构造器 = 纯标签 / 枚举值

## 带参数的构造器 = 里面还装着数据

## 构造器里再次出现本类型 = 递归数据类型

---

# 十七、我现在最该补的不是做题，而是这个基本功

在真正做函数题之前，我应该先练这个：

## 看到一行 `data`，先把它翻译成人话

例如只做下面这件事：

- 拆出类型名
- 拆出构造器
- 看每个构造器带什么参数
- 找出递归点

把这个练熟以后，后面的 pattern matching、递归和写函数，都会轻松很多。

---

# 十八、一句提醒自己

我现在很多题写不出来，不一定是因为题太难。  
有时只是因为我对“类型名、构造器、参数、类型变量、递归定义”这几个最基础的概念还没完全站稳。

所以先把这一层补稳，是值得的，而且很关键。
