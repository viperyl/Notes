 

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
若马尔可夫链的状态空间 $S$ 上的概率分布满足条件
$$
\Large \begin{align}
\pi(y) = \int p(x, y)\pi(x)dx, \forall y \in S
\end{align}
$$
则称分布 $\pi(x)$ 为该马尔可夫链的平稳分布。等价地
$$
\Large \begin{align}
\pi(A) = \int p(x, A)\pi(x)dx, \forall A \in S
\end{align}
$$


## 马尔可夫链性质

### 不可约

设有马尔可夫链 $X$，状态空间为 $S$，对于任意状态 $i,j\in S$， 如果存在一个时刻 $t (t>0)$ 满足
$$
\Large \begin{align}
P(X_t=i|X_0=j) >0 
\end{align}
$$
也就是说，时刻 $0$ 从状态 $j$ 出发，时刻 $t$ 到达状态 $i$ 的概率大于 $0$，则说明此马尔可夫链是不可约的 (irreducible)，否则是可约的 (reducible)。

一个不可约的马尔可夫链可以在从任意状态出发，在经历过充分长的时间后可以到达任意状态。






$$
\Large
\begin{bmatrix}
-1 & 0 & 0\\
0 & 0 & 0\\
1 & 2 & 2\\
1 & 9 & 0
\end{bmatrix}
$$

### 非周期性

如果时刻 $0$ 从状态 $i$ 出发，$t$ 时刻返回状态的所有时长 $\{t:P(X_t=i|X_0=i)>0\}$的最大公约数是1，则称此马尔可夫链为非周期性的 (aperiodic)，否则则是周期性的 (periodic)。

直观上，一个非周期性的马尔可夫链不存在一个状态，从这个状态出发，再返回到这个状态所经历的时间长呈现一定的周期性。

### 正常返

设有马尔可夫链 $X$，状态空间为 $S$，对于任意状态 $i, j\in S$，定义概率 $p_{ij}^t$ 为时刻 $0$ 从状态 $j$ 出发，时刻 $t$ 首次到达状态 $i$ 的概率。即 
$$
\Large p_{ij}^t = P(X_t=i, X_s \neq i, s=1,2,...,t-1|X_0=j), t=1,2,...
$$
若所有的状态都满足
$$
\Large \lim\limits_{t\rightarrow \infty} p_{ij}^t > 0
$$


则称马尔可夫链为正常返 (positive recurrent)。

直观上，一个正常返的马尔可夫链从任意一个状态出发，当时间趋向于无穷时，首次达到这个状态的概率不为0。

### 定理

不可约，非周期且正常返的马尔可夫链有唯一平稳分布存在。

### 可逆马尔可夫链

若有状态分布 $\pi = (\pi_1, \pi_2, ...)^\intercal$，对于任意状态 $i,j\in S$，对于任意一个时刻 $t$ 都有
$$
\Large
P(X_t = i|X_{t-1}=j)\pi_j = P(X_{t-1}=j |X_t =i) \pi_i, i,j=1,2,...
$$
则称此链为可逆马尔可夫链 (reversible)
$$
\Large p_{ij}\pi_j = p_{ji}\pi_i
$$
直观上一个可逆的马尔可夫链以平稳分布作为初始分布，进行随机状态转移，无论是面向过去还是面向未来，任何一个时刻的该分布都是该平稳分布。

上式又叫细致平稳方程 (detailed balanced equation)



### 马尔可夫链蒙特卡罗法

Step1

首先在随机变量 $X$ 的状态空间 $S$ 上构造一个满足遍历定理的马尔可夫链，使其平衡分布为目标分布 $p(x)$。

Step 2

从某一点 $x_0$ 出发，用构造的马尔可夫链进行随机游走，产生样本序列 $\{x_0, x_1, x_2, ..., x_t, ...\}$。

Step 3

应用马尔可夫链的遍历定理，确定正整数 $m$ 和 $n$，得到样本集合 $\{x_{m+1},x_{m+2}, ..., x_n\}$，求得函数均值
$$
\Large \hat{E}_f = \frac{1}{n-m}\sum\limits_{i=m+1}^{n}f(x_i)
$$


### Bayesian Theorem

$$
\Large \begin{align}
p(A|B) = \frac{p(B|A)p(A)}{p(B)}
\end{align}
$$




$$
\Large \begin{align}
p(x|y) = \frac{p(x)p(y|x)}{\int_{X}p(y|x^{'})p(x^{'})dx^{'}}
\end{align}
$$












```
\Large \begin{align}

\end{align}
```



















