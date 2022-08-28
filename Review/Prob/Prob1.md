# Ch 01 

### 1.5.1 独立事件

$$
\Large
\begin{split}
P(AB) &= P(A) P(B)\\
P(A\bar{B}) &= P(A)P(\bar{B})\\
P(ABC) &= P(A) P(B) P(C)
\end{split}
$$



# Ch 02

### 2.1.1 分布函数

$$
\Large
\begin{split}
F(x) &= P(X \leq x)\\
X &\sim F(x)
\end{split}
$$

单调，有界，右连续

### 2.1.2 概率密度函数

$$
\Large
\begin{split}
F(x) = \int\limits_{-\infin}^{x}p(t)dt
\end{split}
$$

$p(x)$为 $X$的概率密度函数

### 2.2.1 随机变量的数学期望

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

### 2.3.1 随机变量的方差

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

### 2.3.2 切比雪夫不等式

对任意常数 $\epsilon$
$$
\Large
\begin{split}
P(\vert X - E(X)\vert \geq \epsilon) \leq \frac{\text{Var}(X)}{\epsilon^2}
\end{split}
$$

### 2.4.1 二项分布 Binomial distribution

$$
\Large
\begin{split}
X &\sim b(n, p)\\
p(X=x) &= p^x(1-p)^{1-x} \\
E(X) &= np\\
E(X^2) &= n(n-1)p^2 + np\\
\text{Var} &= np(1-p)
\end{split}
$$

### 2.4.2 泊松分布 Poisson distribution

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

### 2.4.3  超几何分布 Hypergeometric distribution

$$
\Large
\begin{split}
X &\sim h(n, N, M) \\
P &= \frac{\binom Mk \binom{N-M}{n-k}}{\binom Nn}\\
E(X) &= n\frac{M}{N} \\
\text{Var} &= \frac{nM(N-M)(N-a)}{N^2(N-1)}
\end{split}
$$

### 2.4.4 几何分布 Geometric distribution

$$
\Large
\begin{split}
X &\sim Ge(p) \\
P(X=k) &= (1-p)^{k-1}p \\
E(X) &= \frac{1}{p}\\
\text{Var} &=  \frac{1-p}{p^2}\\
P(X> m+n \vert X>m) &= P(X>n)
\end{split}
$$

### 2.5.1 正太分布

$$
\Large
\begin{split}
X &\sim N(\mu, \sigma^2) \\
p(x) &= \frac{1}{\sqrt{2\pi} \sigma}e^{-\frac{(x-\mu)^2}{2\sigma^2}}, -\infty < x < \infty\\
F(x) &= \frac{1}{\sqrt{2\pi} \sigma}\int\limits_{-\infty}^{x}e^{-\frac{(x-\mu)^2}{2\sigma^2}} dt
\end{split}
$$

### 2.5.2 均匀分布

$$
\Large
\begin{split}
p(x) &=  \begin{cases}\frac{1}{b-a} &, a<x<b\\ 0&, \text{others}\end{cases}\\
X &\sim U(a, b) \\
F(x) &= \begin{cases}0 &,x<a\\ \frac{x-a}{b-a} &, a \leq x < b \\ 1 &, b\geq 1 \end{cases}\\
E(X) &= \frac{b-a}{2}\\
\text{Var}(X) &= \frac{(b-a)^3}{12}
\end{split}
$$

### 2.5.3 指数分布

$$
\Large
\begin{split}
p(x) &= \begin{cases}\lambda e^{-\lambda x} &, x\geq 0\\ 0 &,x<0 \end{cases}\\
F(x) &= \begin{cases}1-e^{-\lambda x} &, x\geq 0\\ 0&,x<0 \end{cases} \\
X &\sim \text{Exp}(\lambda) \\
E(X) &= \frac{1}{\lambda}\\
\text{Var}(X) &= \frac{1}{\lambda^2}
\end{split}
$$

### 2.5.4 Gamma 分布

$$
\Large
\begin{split}
\Gamma 
\end{split}
$$





# Ch03













$$
\Large
\begin{split}

\end{split}
$$
