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

























































