







## VAE and multi-layer VAE



## Diffusion Model

$\Large x_0\sim q(x)$

### Forward

前向过程不含参数
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





Assume $\Large \alpha_t = \sqrt{1-\beta_t}$, $\Large \hat{\alpha}_t = \prod\alpha_i$
$$
\Large
\begin{align}
\bold{x}_t &= \sqrt{\alpha_t}\bold{x_{t-1}} \\
&= \sqrt{\alpha_t}
\end{align}
$$















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

