







# Ch 03: Probabilities, Gaussians, and bayes’s Theorem

Mean 
$$
\Large \mu = \frac{1}{n}\sum\limits_{i=1}^{n}x_i
$$
Expect value
$$
\Large \mathbb{E}[X] = \sum\limits_{i=1}^{n}p_ix_i = \int\limits_{a}^{b}xf(x)dx
$$
Variance
$$
\Large VAR(X)  = \mathbb{E}[(X - \mu)^2]  = \frac{1}{n}\sum\limits_{i=1}^{n}(x_i - \mu)^2
$$
Standard deviation
$$
\Large \sigma = \sqrt{VAR(X)}
$$
Gaussian Distribution
$$
\Large f(x, \mu, \sigma) = \frac{1}{\sigma\sqrt{2\pi}}exp[-\frac{(x-\mu)^2}{2\sigma^2}]
$$
$\sigma$ represents the strength of the belief, for the same $\mu$, the smaller the $\sigma$, the narrower curve. Which indicates the stronger belief.

$\mu \pm \sigma$: 0.68

$\mu\pm2\sigma$:0.95

$\mu\pm3\sigma$: 0.997



## Gaussian Computational properties

Sum of two independent Gaussian is another Gaussian
$$
\Large g_1 \sim \mathcal{N}(\mu_1, \sigma_1^2)\;\;\;g_2\sim\mathcal{N}(\mu_2, \sigma_2^2)
$$
the product of above two Gaussian is
$$
\Large \mu = \frac{\sigma_1^2\mu_2 + \sigma_2^2\mu_1}{\sigma_1^2+\sigma_2^2}\\
\Large \sigma^2 = \frac{\sigma_1^2\sigma_2^2}{\sigma_1^2+\sigma_2^2}
$$
the sum of above two Gaussian is
$$
\Large \mu = \mu_1 + \mu_2\\
\Large \sigma^2 = \sigma_1^2 + \sigma_2^2
$$


Bayes Theorem
$$
\Large \text{posterior} = \frac{\text{likelihood}\times \text{prior}}{\text{normalization}}
$$

$$
\Large P(A|B) = \frac{P(B|A)P(A)}{P(B)}
$$

$$
\Large p(A|B) = \frac{p(B|A)p(A)}{\int p(B|A_j)p(A_j)dA_j}
$$

`B`  is the evidence, `A` is prior, `P(B|A)` is likelihood, `P(A|B)` is posterior

Total Probability Theorem
$$
\Large P(X_i^t) = \sum\limits_{j}P(X_j^{t-1})P(x_i|x_j)
$$

# Ch 04: One-dimensional Kalman filter

$$
\Large \bar{x} = x * f_x(\cdot)\\
\Large x = \mathcal{L} \cdot \bar{x}
$$

$\bar{x}$: prior

$\mathcal{L}$: likelihood of a measurement given the prior $\bar{x}$

$f_x(\cdot)$: process model

$*$: convolution

If dog in 10 m, and speed it 15 m/s, the epoch is 2 seconds. 
$$
\Large \bar{x}_k =x_{k-1} + v_k\Delta t = x_{k-1} + f_x
$$
dog position standard deviation is 0.2 m, $x\sim \mathcal{N}(10, 0.2^2)$

velocity uncertainty is 0.7 m/s, $x\sim \mathcal{N}(15, 0.7^2)$
$$
\Large \bar{x}_k \sim \mathcal{N}(25, 0.53)
$$
if we sense the dog position is 24 with uncertainty $0.6^2$, $\text{likelihood} \sim \mathcal{N}(24, 0.6^2)$

then perform update. which is Gaussian multiply.



## Kalman gain

the posterior is
$$
\Large x = \mathcal{L} \cdot \bar{x}
$$
the mean of the posterior is
$$
\Large \mu = \frac{\bar{\sigma}^2\mu_z + \sigma_z^2\bar{\mu}}{\bar{\sigma}^2 + \sigma_z^2}
$$
subscript `z` denote the measurement
$$
\Large \mu = \frac{\bar{\sigma}^2}{\bar{\sigma}^2 + \sigma_z^2}\mu_z + \frac{\sigma_z^2}{\bar{\sigma}^2 + \sigma_z^2}\bar{\mu}
$$
We scaling the measurement and the prior by weights:
$$
\Large \mu = W_1 \mu_z + W_2\bar{\mu}
$$
the weights sum to one, assume $K = W_1$
$$
\Large \mu = K\mu_z + (1-K)\bar{\mu} = \bar{\mu} + K(\mu_z - \bar{\mu})
$$
where
$$
\Large K = \frac{\bar{\sigma}^2}{\bar{\sigma}^2 + \sigma_z^2}
$$
`K` is the Kalman Gain
$$
\Large \sigma^2 = \frac{\bar{\sigma}^2\sigma_z^2}{\bar{\sigma}^2 + \sigma_z^2} = K\sigma_z^2 = (1-K)\bar{\sigma}^2
$$





## Description

**Initialization**

1. Initialize the state of the filter
2. Initialize the belief of the state

**Predict**

1. Use system behavior to predict state at the next time step
2. Adjust belief to account for the uncertainty in prediction

**Update**

1. Get a measurement and associated belief about its accuracy
2. Coompute residual between estimated state and measurement 
3. Compute scaling factor based on whether the measurement or prediction is more accurate
4. set state between the prediction and measurement based on scaling factor
5. update belief in the state based on how certain we are in the measurement







Predict

| Equation            | Implementation                                               | Kalman Form                         |
| ------------------- | ------------------------------------------------------------ | ----------------------------------- |
| $\bar{x} = x + f_x$ | $\bar{\mu} = \mu + \mu_{f}\\ \bar{\sigma}^2 = \sigma^2+\sigma_f^2$ | $\bar{x} = x +dx\\\bar{P} =  P + Q$ |

Update

| Equation                     | Implementation                                               | Kalman Form                                                  |
| ---------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| $x = ||\mathcal{L}\bar{x}||$ | $y = z - \bar{\mu}\\ K = \frac{\bar{\sigma}^2}{\bar{\sigma}^2 + \sigma_z^2}\\ \mu = \bar{\mu} + Ky\\ \sigma^2 = \frac{\bar{\mu}^2\sigma_z^2}{\sigma_z^2 + \bar{\sigma}^2}$ | $y = z - \bar{x}\\ K = \frac{\bar{P}}{\bar{P} + R}\\x = \bar{x} + Ky\\P = (1 - K)\bar{P}$ |

# Ch 05: Multivariate Gaussians



































