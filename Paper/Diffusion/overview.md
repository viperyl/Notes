







## VAE and multi-layer VAE



## Diffusion Model

$\Large x_0\sim q(x)$

### Forward

前向过程不含参数，**迭代计算**如下
$$
\Large
\begin{equation}
q(\bold{x_t}|\bold{x_{t-1}}) = \mathcal{N}(\bold{x_t}; \sqrt{1-\beta_t}\bold{x_{t-1}}, \beta_t\bold{I})
\end{equation}
$$

$$
\Large
\begin{equation}
q(\bold{x}_{1:T}\vert \bold{x}_0) = \prod\limits_{t=1}^{T}q(\bold{x}_{t}\vert \bold{x}_{t-1})
\end{equation}
$$



当 $\Large T\rightarrow \infty$ 的时候，结果等同于  Isotropic Gaussian Distribution



**解析解如下**

Let $\Large \alpha_t = 1 - \beta_t, \bar{\alpha_t}= \prod\limits_{i=1}^{T}\alpha_i, z\sim\mathcal{N}(0, \bold{I})$
$$
\Large
\begin{align}
\bold{x}_t &= \sqrt{1-\beta_t}\bold{x}_{t-1} + \sqrt{\beta_t}\bold{z}_{t-1}\\
&= \sqrt{\alpha_t}\bold{x}_{t-1} + \sqrt{1-\alpha_t}\bold{z}_{t-1}\\
&= \sqrt{\alpha_t\alpha_{t-1}}\bold{x}_{t-2} + (\sqrt{\alpha_t}\sqrt{1-\alpha_{t-1}}\bold{z}_{t-2} + \sqrt{1-\alpha_t}\bold{z}_{t-1})\\
&= \sqrt{\alpha_t\alpha_{t-1}}\bold{x}_{t-2} + \sqrt{1-\alpha_t\alpha_{t-1}}\bold{\bar{z}}_{t-2}\\
&= \sqrt{\bar{\alpha}_t}\bold{x}_0 + \sqrt{1-\bar{a}_t} \bold{z}\\
q(\bold{x}_t\vert \bold{x}_0) &= \mathcal{N}\left(\bold{x}_t \Bigg\vert \sqrt{\bar{\alpha}_t}\bold{x}_0, (1-\bar{\alpha}_t)\bold{I} \right)
\end{align}
$$

Usually, we can afford a larger update step when the sample gets  noisier, so
$$
\Large
\begin{align}
\beta_1 < \beta_2 < \cdots < \beta_T \\
\bar{\alpha}_1 > \bar{\alpha}_2 > \cdots > \bar{\alpha}_T
\end{align}
$$


### Reverse process

逆过程是从高斯噪声中恢复原始数据，














```
\Large
\begin{equation}

\end{equation}
```






























```
\Large
\begin{equation}



\end{equation}
```

