 

马尔可夫链
$$
\Large P(X_t|X_{t-1}) = P(X_t|X_{t-1},X_{t-2},X_{t-3},..., X_{1})
$$
若转移概率分布与时间无关，则为时间齐次的马尔可夫链 (Time homogeneous Markov chain)
$$
\Large P(X_{t+s}|X_{t+s-1}) = P(X_{t}|X_{t-1}) 
$$

## 离散状态的和马尔可夫链

若马尔可夫链在时刻 $t-1$ 处于状态 $j$， 在时刻 $t$ 移动到状态 $i$， 将转移概率记做
$$
\Large p_{ij} = (X_t = i| X_{t-1} =j), i=1,2,...; j=1,2,...;
$$
满足
$$
\Large p_{ij} \geq 0; \sum\limits_{i} p_{ij} = 1
$$
马尔可夫链的转移概率 $p_{ij}$ 可以由矩阵表示。满足上述两个条件的矩阵叫做随机矩阵 (stochastic matrix)。
$$
\Large \begin{bmatrix}
p_{11} & p_{12} & p_{13}, ...\\
p_{21} & p_{22} & p_{23}, ...\\
p_{31} & p_{32} & p_{33}, ...\\
... & ... & ..., ...
\end{bmatrix}
$$


考虑马尔可夫链 $X$ 在时刻 $t$ 的概率分布，成为时刻 $t$ 的概率分布，记作
$$
\Large  \pi(t) = [\pi_1(t), \pi_2(t), ..., \pi_n(t)]^\intercal
$$
其中 $\pi_i(t)$ 表示时刻 $t$ 状态 $i$ 的概率 $P(X_t = i)$
$$
\Large \pi_i(t) = P(X_t=i), i = 1,2,...
$$


## 平稳分布

若
$$
\Large \pi = \Large P\pi
$$
则称 $\pi$ 为马尔可夫链 $X$ 的平稳分布。

**引理**：给定连一个马尔可夫链 $X$， 状态空间 $S$， 转移概率矩阵为 $P = (p_{ij})$， 则分布 $\pi=(\pi_1,\pi_2,...)^\intercal$ 为 $X$ 的平稳分布的充分必要条件是 $\pi=(\pi_1,\pi_2,...)^\intercal$为下列方程的解
$$
\Large \begin{align}
x_i &= \sum\limits_{j} p_{ij}x_j, i=1,2,...\\
x_i &\geq 0, i = 1,2,...\\
\sum\limits_{i}x_i &= 1
\end{align}
$$

## 连续状态马尔可夫链

连续状态马尔可夫链 $X$, 随机变量 $X_t$， 定义在连续空间 $S$，转移概率分布由概率转移核 (transition kernel) 表示

设 $S$ 是连续状态空间，对任意 $x\in S, A\subset S$，转移核 $P(x, A)$ 定义为
$$
\Large \begin{align}
P(x, A) = \int_A p(x, y) dy
\end{align}
$$
其中 $p(x, \cdot)$ 是概率密度函数， 满足 
$$
\Large \begin{align}
p(x, \cdot)\geq0, p(x, S) = \int_S p(x,y) dy = 1
\end{align}
$$
转移核 $p(x, A)$ 表示以 $x\sim A$ 的转移概率
$$
\Large \begin{align}
P(X_t =A| X_{t-1} = x) = P(x, A)
\end{align}
$$


















```
\Large \begin{align}

\end{align}
```



















