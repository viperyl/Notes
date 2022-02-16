







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
2. Compute residual between estimated state and measurement 
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

# Ch 05: Multivariate Gaussian

univariate normal
$$
\Large \mathcal{N}(\mu, \sigma^2)
$$
for `N` dimensions, we need `N` means. $\mu = [\mu_1, \mu_2, ..., \mu_n]^T$ and `N` variance $\sigma^2 = [\sigma_1^2, ..., \sigma_n^2]$

**Correlation and Co-variance**

co-variance
$$
\Large \text{COV}(X, Y) = \sigma_{xy} = \mathbb{E}[(X - \mu_x)(Y - \mu_y)]
$$

$$
\Large \text{COV}(X, X) =\begin{bmatrix}\sigma_1^2 & \sigma_{12}&...&\sigma_{1n}\\\sigma_{21}&\sigma_2^2&...&\sigma_{2n}\\...&...&...&...\\\sigma_{n1}&\sigma_{n2}&...&\sigma_{n}^2 \end{bmatrix}
$$
`0` means no linear correlation

biased estimator over $1/(N+1)$, unbiased estimator over $1/N$

Multivariate Normal Distribution
$$
\Large \begin{equation}
f(x, \bold{\mu}, \bold{\Sigma}) = \frac{1}{\sqrt{(2\pi)^2|\Sigma|}} \exp\left[-\frac{1}{2}(x -\mu)^T\Sigma^{-1}(x-\mu)\right]
\end{equation}
$$
**Joint probability**

$P(x, y)$, the probability of both $x$ and $y$ happening. Above equation is joint probability density function

marginal probability is the probability of an event happening without regard of any other event.

 

**Pearson’s Correlation Coefficient**
$$
\Large \rho_{xy} = \frac{\text{COV}(X,Y)}{\sigma_x\sigma_y}
$$
$\Large \rho_{xy} > 0$: positive correlation

$\Large \rho_{xy} == 0$: no correlation

$\Large \rho_{xy} < 0$ : negative correlation



**Multivariate Gaussian Multiply**
$$
\Large\begin{align}
\mu &= \Sigma_2(\Sigma_1 + \Sigma_2)^{-1}\mu_1 + \Sigma_1(\Sigma_1 + \Sigma_2)^{-1}\mu_2\\
\Sigma &= \Sigma_1(\Sigma_1 + \Sigma_2)^{-1}\Sigma_2
\end{align}
$$


**Multivariate Gaussian sum**
$$
\Large\begin{align}
\mu &= \frac{\Sigma_2\mu_1 + \Sigma_1\mu_2}{\Sigma_1 + \Sigma_2} \\
\Sigma &= \frac{\Sigma_1\Sigma_2}{\Sigma_1 + \Sigma_2}
\end{align}
$$

# Ch 06: Multivariate Kalman Filter

**predict**

| Uni-variate                                                  | Kalman Form                         | Kalman Form                                                  |
| ------------------------------------------------------------ | ----------------------------------- | ------------------------------------------------------------ |
| $\bar{\mu} = \mu +\mu_{f}\\\bar{\sigma}^2 = \sigma^2 + \sigma_f^2$ | $\bar{x} = x + dx\\\bar{P} = P + Q$ | $\bar{\bold{X}} = \bold{Fx} + \bold{Bu}\\ \bold{P} = \bold{FPF}^T + \bold{Q}$ |

$\bold{x, P}$: state mean and variance, correspond to $x, \sigma^2$

$\bold{F}$: state transition function, when multiplied by $\bold{x}$ it computes the prior

$\bold{Q}$: process variance, correspond to $\sigma_f^2$

$\bold{B, u}$ represent the model control

**Update**

| Uni-variate                                                  | Kalman Form                                                  | Kalman Form                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| $\mu = \frac{\bar\sigma^2\mu_z + \sigma_z^2\bar{\mu}}{\sigma_1^2 + \sigma_2^2}\\\sigma^2 = \frac{\sigma_1^2\sigma_2^2}{\sigma_1^2+\sigma_2^2}$ | $y = z - \bar{x}\\K = \frac{\bar{P}}{\bar{P} + R}\\x = \bar{x} + Ky\\ P = (1 - K)\bar{P}$ | $\begin{align}\bold{y} &= \bold{z} - \bold{Hx}\\ \bold{K} &= \bold{PH}^T(\bold{HPH}^T + \bold{R})^{-1}\\ x&= \bar{x} + \bold{Ky}\\ \bold{P} &= (\bold{I - KH})\bold{P}\end{align}$ |



$\bold{H}$: measurement function

$\bold{z, R}$: measurement mean and variance

$y$: residual

$K$: Kalman gain



# Ch 10. Unscented Kalman Filter

weighted mean
$$
\Large \mu = \sum\limits_{i}w_if(\mathcal{X}_i)
$$
$\mathcal{X}$ is the sigma points

we need the sums of the weights to equal one. we also need sum of the weighted co-variance to equal one.

Constraints
$$
\Large \begin{align}
1 &= \sum\limits_{i}w_i^m\\
1 &= \sum\limits_{i}w_i^c\\
\mu &= \sum\limits_{i}w_i^mf(\mathcal{X}_i)\\
\Sigma &= \sum\limits_{i}w_i^c(f(\mathcal{X})_i - \mu)(f(\mathcal{X})_i - \mu)^T

\end{align}
$$
These constraints do not form a unique solution. 



Core of the UKF
$$
\Large \mathcal{Y} = f(\mathcal{X})
$$

The mean and covariance of the sigma point are computed as
$$
\Large
\begin{align}
\mu &= \sum\limits_{i=0}^{2n}w_i^m\mathcal{Y}_i\\
\Sigma &= \sum\limits_{i=0}^{2n}w_i^c(\mathcal{Y}_i - \mu)(\mathcal{Y}_i - \mu)^T
\end{align}
$$
The UKF transform takes points sampled from some arbitrary probability distribution, passes them through an arbitrary, non-linear function and produces a Gaussian for each transformed points.



#### Predict

computes the prior using the process model $f(\cdot)$. We generate sigma points $\mathcal{X}$ and their corresponding weights $W^m, W^c$ according to some function.
$$
\Large
\begin{align}
\mathcal{X} &= \text{sigma-function}(\bold{x}, \bold{P})\\
W^m, W^c &= \text{weight-function}(n, \text{parameters})
\end{align}
$$
pass each sigma point through $f(x, \Delta t)$,  set of the sigma point is $\mathcal{Y}$.
$$
\Large \mathcal{Y} = f(\mathcal{X}, \Delta t)
$$
compute the mean and variance of the prior using the `unscented transform`  on transformed sigma points.
$$
\Large
\bold{x}, \bold{P} = \text{UT}(\mathcal{Y}, w_m, w_c, \bold{Q})
$$
question for the `unscented transform`
$$
\Large\begin{align}
\bold{x} &= \sum\limits_{i=0}^{2n} w_i^m\bold{\mathcal{Y}_i}\\
\bold{P} &= \sum\limits_{i=0}^{2n} w_i^c(\bold{\mathcal{Y}}_i - \mu) (\bold{\mathcal{Y}}_i - \mu)^T

\end{align}
$$

#### Update

convert sigma points of the prior into measurement using a measurement functions $h(x)$.
$$
\Large \mathcal{Z} = h(\mathcal{Y})
$$
compute the mean and variance of these points using the `unscented transform` . The `z` subscript denotes that these are the mean and covariance of the measurement sigma points.
$$
\Large
\begin{align}
\bold{\mu}_z, \bold{P}_z &= \text{UT}(\mathcal{Z}, w_m, w_c, \bold{R})\\
\bold{\mu}_z &= \sum\limits_{i=0}^{2n} w_i^m\mathcal{Z}_i\\
\bold{P}_z &= \sum\limits_{i=0}^{2n}w_i^c(\mathcal{Z}_i - \bold{\mu}_z)(\mathcal{Z}_i - \bold{\mu}_z)^\intercal + \bold{R}

\end{align}
$$
Next compute the residual and Kalman gain
$$
\Large y = z - \mu_z
$$
compute cross covariance
$$
\Large \bold{P}_{xz} = \sum\limits_{i=0}^{2n}w_i^c(\mathcal{Y}_i - x)(\mathcal{Z}_i - \bold{\mu}_z)^\intercal
$$

$$
\Large \bold{K} = \bold{P}_{xz}\bold{P}_z^{-1}
$$

Finally, compute the new state estimate using the residual and Kalman gain
$$
\Large x = \bar{x} + \bold{K}y
$$
compute new covariance
$$
\Large \bold{P} = \bold{P} - \bold{KP}_z\bold{K}^\intercal
$$

#### KF vs UKF

| Kalman Filter                                                | Unscented Kalman Filter |
| ------------------------------------------------------------ | ----------------------- |
| $\begin{align}  x &= Fx\\ \bold{P} &= \bold{FPF}^\intercal + \bold{Q}\end{align}$ |                         |
|                                                              |                         |



#### Sigma point computation

The first point is the mean of the input, denote as $\mathcal{X}_0$.
$$
\Large \mathcal{X}_0 = \mu
$$
we define $\lambda = \alpha^2(n+k)-n$, where $n$ is the dimension of $\bold{x}$. The remaining sigma point are computed as
$$
\Large \mathcal{X}_i = \begin{cases}\mu + \left[\sqrt{(n+\lambda)\Sigma}\right]_i, \text{for i=1..n}\\
\mu - \left[\sqrt{(n+\lambda)\Sigma}\right]_i, \text{for i=(n+1)..2n}

\end{cases}
$$


#### Weight computation

$$
\Large W_0^m = \frac{\lambda}{n + \lambda}
$$



# CH 11. Extended Kalman Filter

EKF linearize the nonlinear equation at the point of the current estimates. First order Taylor expansion.



















#### Example

Radar given the `slant` and `bearing`
$$
\Large
\begin{align}
\epsilon &= \text{tan}^{-1}\frac{y}{x}\\
r^2 &= x^2 + y^2
\end{align}
$$
we want to track the position of an aircraft.
$$
\Large
x = \begin{bmatrix} \text{distance}\\ \text{velocity}\\ \text{altitude}\end{bmatrix} = 
\begin{bmatrix}x\\\dot{x}\\y \end{bmatrix}
$$

$$
\Large \bold{F} = \begin{bmatrix}
1 & \Delta t & 0\\
0 & 1 & 0\\
0 & 0  & 1
\end{bmatrix}
$$

Design the measurement model, which takes the state estimate of the prior $\bar{x}$ and turn it into a measurement of the slant range distance.
$$
\Large h(\bar{x}) = \sqrt{x^2 + y^2}
$$

$$
\Large \frac{\partial \bold{H}}{\partial \bar{x}}  = \begin{bmatrix}
\frac{\partial h_1}{\partial x_1} &...& \frac{\partial h_1}{\partial x_n}\\
...&...&...\\
\frac{\partial h_m}{\partial x_1}&...&\frac{\partial h_m}{\partial x_n}
\end{bmatrix} = \begin{bmatrix}
\frac{\partial h}{\partial x_1} & ...  &\frac{\partial h}{\partial x_n}
\end{bmatrix}
$$

Here, we can derive the measurement matrix
$$
\Large \bold{H} =\begin{bmatrix}
\frac{\partial h}{\partial x} & \frac{\partial h}{\partial \dot{x}}  &\frac{\partial h}{\partial y}
\end{bmatrix} = \begin{bmatrix}
\frac{x}{\sqrt{x^2 + y^2}} & 0 & \frac{y}{\sqrt{x^2 + y^2}} 
\end{bmatrix}
$$




















| Linear Kalman Filter | Extended Kalman Filter                                       |
| -------------------- | ------------------------------------------------------------ |
|                      | $\bold{F} = \frac{\partial f(\bold{x}_t, \bold{u}_t)}{\partial x}\vert_{x_t,u_t}$ |
|                      |                                                              |





































EKF





