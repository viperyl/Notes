# 1. Image Enhancement

Make the image look better, view and process the visual information with greater clarity.

Dynamic range of an image: largest possible signal divided by the smallest possible signal it can generate.

Dynamic range: Range of possible pixel values of a given image or sensor.

Increasing the dynamic range improves contrast.



## 1.1 Logarithmic Transform

Compress dynamic range of image

Replaces each pixel value with its logarithm
$$
\Large I_{output} (i,j) = ln(I_{inpu}(i,j))
$$
In practice:
$$
\Large I_{output}(i,j) = c * ln[1 + (e^\sigma - 1)I_{input}(i,j)]
$$
Scaling factor $\sigma$ and $c$:

1. $\sigma$ controls the input range to the logarithmic function
2. $c$ scales the output to the range $(0, 255)$

R us the maximum value in $I_{input}$
$$
\Large c = \frac{255}{log(1 + |R|)}
$$

## 1.2 Square-Root Transform

$$
\Large I_{ouput}(i,j) = \sqrt{I_{input}(i,j)}
$$

Compress high value pixel ranges; Spreads out low value pixel ranges.

## 1.3 Exponential Transform

Inverse of logarithmic transform

1. compress dynamic range differently
2. replaces each pixel value with its exponent.

$$
\Large I_{output}(i,j) = exp(I_{input}(i,j))
$$

In practice, we need incorporate with scaling factors $c$ and basis $\alpha$
$$
\Large I_{output}(i,j) = c[(1+\alpha)^{I_{input}(i,j)} - 1]
$$
It can decreases the dynamic range of dark regions whilst increasing the dynamic range in light regions.

## 1.4 Raise to Power

raise each pixel value to fixed power.
$$
\Large I_{output}(i,j) = c[I_{input}(i,j)]^r
$$
For $r > 1$: enhances high value portions of the image at the expense of low value regions.

For $r < 1$: enhances low pixel values whilst compressing high intensity values.

This transform is similar to logarithmic if $r < 1$, or similar to exponential if $r > 1$.



## 1.5 Gamma Correction

monitor output is not linear function of input, and relationship is in fact exponential
$$
\Large I_{output} = (I_{input})^{\gamma}
$$

## 1.6 Contrast Stretch

Stretches the pixel range over a larger dynamic range (normalization).
$$
\Large I_{output}(i,j) = [I_{input}(i,j) - c] (\frac{a-b}{c-d})  + a
$$
Contrast stretch may introduce the **Salt & Pepper** noise.

Solution: A robust method to select $c$ and $d$

1. Select $c$ and $d$ at the 5-th and 95-th percentile points of distribution
2. find the most frequently image value; select a cut-off as a percentage of the peak; scan down from peak in either direction until last values above cut-off are reached. Select these as $c$ and $d$

## 1.7 Histogram Equalization

modifying an image dynamic range so its histogram conforms to a given shape.

Use a monotonic, non-linear mapping so input pixels are mapped to an output image with a uniform hisogram distribution.



**Cumulative histogram**

each histogram entry is density of a given intensity value. a normalized histogram is probability distribution of image intensity.

Assume histogram is  $g()$

cumulative histogram is  $\Large C(i) = \sum\limits_{i=0}^{k=i}g(k)$

$C(i)$ record the frequency of all grey levels upto and including $g(i)$

$C$ is single valued and monotoincally increasing funciton. 

**Idealized case**: resulting equalized image will contain an equal number of pixels at each intensity level.

**General case**: mapping between input pixel value $i$, and output pixel value $j$, as follows.
$$
\Large C(i) = jN/L
$$

# 2. Homomorphic Filtering

simultaneous dynamic range compression and contrast enhancement via Fourier space filtering.

Based on principle that image $f(x, y)$ is constituted of two primary components. 

1. illumination: the amount of light incident onto the scene $i(x, y)$
2. reflectance: the amount of light reflected from objects within the scene $r(x, y)$

$$
\Large f(x,y) = i(x, y) r(x, y)
$$

Logarithm allow us deal them separately.
$$
\Large ln[f(x,y)] = ln[i(x,y)] + ln[r(x,y)]
$$
Then into Fourier space.
$$
\Large F(ln\;f(x,y)) = F(ln\; i(x,y)) + F(ln\; r(x,y))\rightarrow F_f(u,v) = F_i(u,v) + F_r(u,v)
$$
Homomorphic filter $H(u,v)$:
$$
\Large H(u,v)F_f(u,v) = H(u,v)F_i(u,v) + H(u,v)F_j(u,v)
$$
Post processing:

1. inverse DFT to get spatial logarithmic image.
2. exponential transforms to recover now filtered spatial image

In Fourier space:

1. Illumination == low frequency ranges
2. Reflection == high frequency ranges

There are two frequency threshsold $h$ and $l$ are used to achieve separation.

if $h < 1$ and $l > 1$:

1. filter amplifies the contribution made by reflectance
2. reduces the contribution made by illumination component

# 3. Laplacian of Gaussian filtering

highlight areas of rapid intensity change.

Laplacian: sum of partial derivatives of image.
$$
\Large I_{laplacian}(x,y) = \frac{\partial^2I_{input}(x,y)}{\partial x^2} + \frac{\partial^2I_{input}(x,y)}{\partial y^2}
$$
commonly implemented via discrete convolution filters (an example below)
$$
\Large  L = \begin{bmatrix} 
0 & -1 & 0 \\
-1& 4 & -1 \\
0 & -1 & 0
\end{bmatrix}
$$


image gradient equal to Edges.

A second order derivative is very sensitive to noise, thus we need  combine with prior stage of Gaussian smoothing as convolution is associative (combining into single kernel).
$$
\Large Log(x,y) = -\frac{1}{\pi\sigma^4}[1 - \frac{x^2 + y^2}{2\sigma^2}] exp(-\frac{x^2+y^2}{2\sigma^2})
$$


Laplacian of Gaussian operator: combination of the Laplacian second order kernels and the Gaussian kernel

1. Area of uniform image intensity: zero
2. areas of a change:  non zero
3. For line/edge/contour/intensity change: +ve on the darker side, -ve on the light side

# 4. Unsharpened Filter: edge enhancement

Subtract smooth version of image to emphasis or enhance the high frequency information
$$
\Large I_{edge}(c,r) = I_{origin}(c,r) - I_{smoothed}(c,r)
$$
Extending:
$$
\Large I_{enhances}(c,r) = I_{original}(c,r) + K[I_{origin}(c,r) - I_{smoothed}(c,r)]
$$
scaling factor $K$ generally in $[0.2, 0.7]$ intervals. Ensure the result within the image range.

In practice: use any low-pass technique to get smoothed image then add it to original.

# 5. Noise reduction

Noise variety of unwanted disturbances due to interference from external sources.

White Noise: Noise signal with a broad spectrum.

Colored Noise: Noise signal confined to a particular band.

Aim: enhance the visual quality of an image by eliminating features which are random and uncorrelated.

## 5.1 Low pass filter

Usual image noise is high frequency effect. 

Corrupts data where the energy of the spectrum is low.

We can apply Low pass filter in Fourier space or by a simple statistical processing.



## 5.2 Mean Filter

Replace a given pixel with the mean of its $N\times N$ (example below)
$$
\Large K = \frac{1}{9}\begin{bmatrix}
1 & 1 & 1\\
1 & 1 & 1\\
1 & 1 & 1
\end{bmatrix}
$$


Eliminates sudden intensity jumps

The kernel shape is $N\times M$, normally $N == M$. 

Drawbacks

1. Not robust enough to large noise deviations.
2. Cause edge blurring.

It also a general low pass filter

## 5.3 Median Filter

replace a given pixel with the median of its $N\times N$ image neighborhood.

**Effect**

1. Eliminates sudden intensity jumps
2. Blurred image

## 5.4 Conservative Smoothing

compare pixel value to min and max of $N\times N$ neighborhood.

replace by min if it less then min; replace by max if it large than max;

**Effect**

1. Eliminating isolated outliers.



## 5.5 Crimmins Speckle detector

Aim: algorithmic noise spike removal

For a $3\times 3$ kernel, for each 8 neighbors.

1. Increase the value of pixels that are darker than their surrounding pixel neighborhood.
2. decrease the value of pixels that are brighter than their surrounding pixel nieghbohood.



















































