# 1. Score

生成模型的目标是给定一个、

并且生成的样本的分布和所选数据集的分布一样



## 1.2 Sampling with Langevin dynamics

Langevin 可以通过score function $\large \nabla_x \log p(\bold{x})$ 来生成probability density $\large p(\bold{x})$。 给定一个固定步长 $\large \epsilon > 0$和初始值 $\large \bar{\bold{x}}_0\sim \pi(\bold{x})$ ，$\large\pi$是先验分布 (高斯分布，均匀分布等)。Langevin 回溯计算如下
$$
\Large
\bar{\bold{x}}_t = \bar{\bold{x}}_{t-1} + \frac{\epsilon}{2}\nabla_x \log p(\bar{\bold{x}}_{t-1}) + \sqrt{\epsilon}\bold{z}_t
$$
 其中$\large\bold{z}_t \sim \mathcal{N}(0,\bold{I})$。

当$\large\epsilon \rightarrow 0$ 和$\large T\rightarrow \infty$ 时 $\large\bar{\bold{x}}_t$ 等于 $\large p(\bold{x})$。$\large \bar{\bold{x}}_T$可以被在某种限制条件下的$\large p(\bold{x})$ 的采样。通常，若$\epsilon > 0, T< \infty$，则需要使用 Metropolis-Hastings 来纠正上式的错误，这个误差一般被忽略。在SDM中当 $\large\epsilon$ 的值小且 $\large T$ 较大的时候我们可忽略误差

采样仅取决于score function $\large \nabla_x \log p(\bold{x})$， 因此，为得到 $\large p_{\text{data}}(\bold{x})$ 的样本我们train $\large s_\theta(\bold{x}) \approx \nabla_x \log p_{\text{data}}(\bold{x})$ 并且使用Langevin dynamics $\large s_\theta(\bold{x})$

## 1.3 Score Matching

Score Matching 最早用于学习非标准化的统计模型基于 从未知数据分布采集而来的I.I.D 样本。 使用Score Matching，我们可以train一个score network $\large s_{\theta}(x)$ 来估计$\large \nabla_x \log p_{data}(x)$ 而无需train 模型来先估计 $\large p_{data}(x)$。
$$
\Large
\mathbb{E}_{p_{data}(\bold{x})} \left[  \text{tr}(\nabla_x s_{\theta}(x)) + \frac{1}{2}\vert\vert s_{\theta}(x)\vert\vert_2^2 \right]
$$




## 1.4









# Reference



1. 先筛选一下图片是否符合效果

2. 数量可观的话可以先train
3. Score Diffusion Model
4. PITI + stable diffusion
5. dream booth
