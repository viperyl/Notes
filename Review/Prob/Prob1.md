# Ch 01 

## 1.5.1 独立事件

$$
\Large
\begin{split}
P(AB) &= P(A) P(B)\\
P(A\bar{B}) &= P(A)P(\bar{B})\\
P(ABC) &= P(A) P(B) P(C)
\end{split}
$$



# Ch 02

## 2.1.1 分布函数

$$
\Large
\begin{split}
F(x) &= P(X \leq x)\\
X &\sim F(x)
\end{split}
$$

单调，有界，右连续



## 2.1.2 概率密度函数

$$
\Large
\begin{split}
F(x) = \int\limits_{-\infin}^{x}p(t)dt
\end{split}
$$

$p(x)$为 $X$的概率密度函数



## 2.2.1 随机变量的数学期望

$$
\Large
\begin{split}
E(X) &= \sum\limits_{i=1}^{N}x_p(x_i)\\
E(X) &= \int\limits_{-\infin}^{\infin}xp(x)dx\\
\end{split}
$$

性质
$$
\Large
\begin{split}
E(c) &= c\\
E(\alpha X) &= \alpha E(X)\\
E[g_1(x) \pm g_2(x)] &= E[g_1(x)] \pm E[g_2(x)]
\end{split}
$$

## 2.3.1 随机变量的方差

$$
\Large
\begin{split}
\text{Var} &= E(X - E(X))^2\\
\text{Var} &= \sum\limits_{i}(x_i - E(X))^2p(x_i)   \\
\text{Var} &= \int\limits_{-\infin}^{+\infin}(x - E(X))^2p(x) dx\\
\text{Var} &= E(X^2) - E(X)^2
\end{split}
$$

性质
$$
\Large
\begin{split}
\text{Var}(aX+b) &= a^2\text{Var}(X)\\

\end{split}
$$

## 2.3.2 切比雪夫不等式

对任意常数 $\epsilon$
$$
\Large
\begin{split}
P(\vert X - E(X)\vert \geq \epsilon) \leq \frac{\text{Var}(X)}{\epsilon^2}
\end{split}
$$


## 2.4.1 二项分布

$$
\Large
\begin{split}
X &\sim b(n, p)\\
E(X) &= np\\
E(X^2) &= n(n-1)p^2 + np\\
\text{Var} &= np(1-p)
\end{split}
$$

## 2.4.2 

$$
\Large
\begin{split}
X &\sim P(\lambda)\\
P(X=k) &= \frac{\lambda^k}{k!}e^{-\lambda}, k = 0, 1, ..., n\\
E(X) &= \lambda\\
E(X^2) &= \lambda^2 + \lambda\\
\text{Var} &= \lambda
\end{split}
$$










$$
\Large
\begin{split}

\end{split}
$$
