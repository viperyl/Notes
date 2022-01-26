# Image Transformation

Type of the Transformation

1. Point transformation
2. Local transformation
3. Global transformation

Aims

1. remove image degradations
2. improve image appearance
3. identify image features
4. transform image to alternative representations

Transform space: Real or Fourier

Real space filters: Linear processes which operate on the image data directly in real space (pixel)

Fourier space filters: Operate on the image transformed using the Discrete Fourier Transform (DFT)

To change representation transform it

from representation A to representation B using transform T(). $B=T(A)$

If transform is invertible. $A = T^{-1}(B)$



## 1. Basic transformation

Performed as an operation, denoted $O$, between two images, $I_A$ and $I_B$, or between image and a constant value $C$.
$$
\Large I_O = I_A O I_B\;\;\;\; I_O = I_A O C
$$
pixel location in the output image is computed as follows:
$$
\Large I_O(i,j) = I_A(i,j) O I_B(i, j)\;\;\;\; I_O(i,j) = I_A(i,j) OC
$$


### 1.1 Arithmetic Operation: Addition

adding a value to each image pixel.

Contrast Adjustment: adding a +ve constant value to each pixel increases brightness.

Blending: adding image together produces a composite image of both inputs.



### 1.2 Arithmetic Operation: Subtraction

Subtracting a value to each image pixel.

Contrast adjustment: as per addition

Image differencing: subtracting one image from another shows us the difference between images.

## 1.3 Arithmetic Operations: Division

dividing each pixel value.

Contrast Adjustment: uniformly scale image contrast

Image differencing is dividing image by another: result == 1 where the image pixel values are identical; value != 1 where a value differences occur.

## 1.4 Arithmetic Operations: Multiplication

Multiplying each pixel value.

Contrast Adjustment: image color scaling as per division.

## 1.5 Image Blending

For $N$ image they can be blended in equal proportion as:
$$
\Large I_{output} = \sum\limits_{i}^{N}\frac{1}{N}I_i
$$
alternatively different weights can be used between images to enhance or suppress the features of different images in the final result.

Image can also have an $\alpha$ channel indexed as $\alpha(i,j)$
$$
\Large I_{display}(i,j) = (1 - \alpha(i,j)) * background(i,j) + \alpha(i,j) * I(i,j)
$$

## 1.6 Logical Operations: Inverse (NOT)

Inverts the image.

For grayscale dark areas become light and vice versa.

color images differs due to RGB colors -- photographic negative effect

For 8-bit image
$$
\Large I_{out} = 255 - I_{in}
$$

## 1.7 Logical Operations: AND

logical AND: $A\and B$ is 1 if A and B are both true

Used for detecting differences in images

highlighting appropriate regions with a mask.

producing big-planes through an image.

## 1.8 Logical Operations: OR

Logical OR: $A\or B$ is 0 if A and B are both false

useful for processing binary images 

also to detect common or moved objects.

## 1.9 Logical Operations: XOR

logical XOR: if A and B are same, the result is false.

logical XNOR: if A and B are same, the result is true.

A very useful tool in efficiently detecting image differences. Highlights only where changes occur.



# 2. Color transformaiton

## 2.1 Color to grayscale

RGB color image $I_c$

Grayscale image  $I_g$
$$
\Large I_g = \alpha I_c(R) + \beta I_c(G) + \gamma I_c(B)
$$
normalized standard co-eff are:
$$
\Large \begin{align}
\alpha &= 0.2989\\
\beta &= 0.5870\\
\gamma &= 0.1140
\end{align}
$$

## 2.2 Grayscale to binary

Thresholding

output 1 or 0 depending by pixel comparison to chosen threshold.

**common variations**

Using two threshold to separate values in a given range: upper/lower threshold.



## 2.3 Image histograms

Visualization of statistical distribution of the image pixel values.

Histogram is statistical distribution of image content.

1. No structural representation
2. Different images have very different histograms
3. similar images have similar histograms

**Histogram Distances**

Correction
$$
\Large d(H_1, H_2) = \frac{\sum\limits_{i=1}^{N}H^{'}_1(i) - H^{'}_2(i)}{\sqrt{\sum\limits_{i=1}^{N}[H_1^{'}(i)]^2\sum\limits_{i=1}^{N}[H_2^{'}(i)]^2}}
$$
Chi-squared: (result of 0 means image similarity)
$$
\Large d(H_1, H_2) = \sum\limits_{i=1}^{N}\frac{H_1(i) - H_2(i)}{H_1(i) + H_2(i)}
$$
Interaction:
$$
\Large d(H_1, H_2) = \sum\limits_{i=1}^{N}min(H_1(i), H_2(i))
$$
Bhattacharyya:
$$
\Large d(H_1, H_2) = \sqrt{1 - \sqrt{\sum\limits_{i=1}^{N}H_1(i) - H_2(i)}}
$$

## 2.4 Neighborhoods

Neighborhood Transforms are real space filters (moving window).

Finite Impulse Response or FIR filer:
$$
\Large S_{ij} = \sum\limits_{c}\sum\limits_{r}p_{i-c, j-r}f_{cr}
$$
It can also used for 3D volume image.

## 2.5 Adaptive Thresholding

Use a different local threshold at each pixel location

Derive threshold from the local pixel neighborhood

Threshold value $t$ based on local $N\times N$ neighborhood statistics:

1. t = mean
2. t = median
3. t = (max - min)/2

Choice of N also crucial:

1. large enough to cover sufficient background and foreground
2. but not to large as to let global illumination have bad effects.



## 2.6 Fourier transform

Fourier transform of an image is a global transform

Produces a representation of the image in Fourier space. (frequency domain)

Performed by Discrete Fourier Transform (DFT) operator.

FT can decompose the image into sine and cosine frequency components

### 2.6.1 Discrete Convolution Theorem





















































