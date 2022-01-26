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

Convolution in the frequency domain reduces to multiplication in the spatial domain

Multiplication in the frequency domain reduces to convolution in the spatial domain
$$
\Large s_{ij} = \sum\limits_{c}\sum\limits_{r}p_{i-c, j-r}f_{cr} == DFT^{-1}(S_{ij} = P_{ij}F_{ij})
$$
Left is spatial and right is Frequency.

If $p_{ij}$ is small, then we can compute convolution directly in real space.

 if $p_{ij}$ is large, using Fast Fourier Transform is more efficient to obtain a Fourier space version the image $f_{ij}$. Then perform the convolution-based filtering as multiplication in Fourier space.

2D formulations are separable to gain computational efficiency

2D DFT can be expressed as a series of 2N 1D DFT. ordinary 1D DFT is O($N^2$). Fast Fourier Transforms is $O(Nlog_2N)$

### 2.6.2 DFT inverse

Image can always be transformed from Spatial to Frequency and back again using FFT.

inverse examples:

1. removing image blurring
2. noise by establishing the noise function



### 2.6.3 DFT compute

The DFT of an 1D N-point vector is given by:
$$
\Large F_m = \sum\limits_{n=0}^{N-1}f_n e^{\frac{-2\pi inm}{N}}
$$


Extend to 2D:
$$
\Large F_m = \sum\limits_{n=0}W_N^{nm} f_n e^{\frac{-2\pi inm}{N}}\;\; W_N = e^{\frac{-2\pi i}{N}}
$$
DFT essentially multiplying an N-point vector $f_n$ by an $N\times N$ matrix of co-efficient given by a constant $W_n$ to the power of $nm$.

Thus the standard DFT is $O(N^2)$

FFT: recursive sub-division 

### 2.6.4 Visualization

DFT output
$$
\Large F_{nm} = G_{nm} + iH_{nm}
$$
Amplitude Spectrum: $|F_{nm}| = \sqrt{G_{nm}^2 + H_{nm}^2}$

Phase Spectrum: $\phi_{nm} = tan^{-1}(\frac{H_{nm}}{G_{nm}})$

Power Spectrum: $|F_{nm}|^2$

## 2.7 Why Fourier 

Enables complex operation in image space to be computed  as simple operations in Fourier Space such as:

1. Convolution
2. Correlation
3. De-convolution

In Fourier space above operation are computationally more efficient.

## 2.8 High Pass Filtering

remove low frequency components from the image. Set frequencies below a certain threshold to zero.
$$
\Large
H(k_x, k_y) = 
\begin{cases}
0,\;\; \sqrt{k_x^2+k_y^2} \leq K\\
1,\;\; \sqrt{k_x^2+k_y^2} > K
\end{cases}
$$
frequency in map means the distance between the point and middle point.
$$
\Large S(k_x, k_y) = H(k_x, k_y) F(k_x, k_y)
$$
uses to detect edges or enhance the edges.

## 2.9 Butterworth High pass filter

Approximation to the ideal high pass filter because of computational cost.

a piecewise continuous circularly symmetric filter given by:
$$
\Large B(k_x, k_y) = \frac{1}{1 + (\frac{K}{\sqrt{k_x^2 + k_y^2}})^{2n}}
$$


## 2.10 Low Pass Filtering

Remove high frequency components from the image. Set frequencies above a certain threshold to zero.
$$
\Large
H(k_x, k_y) = 
\begin{cases}
1,\;\; \sqrt{k_x^2+k_y^2} \leq K\\
0,\;\; \sqrt{k_x^2+k_y^2} > K
\end{cases}
$$




used to noise removal and image smoothing. but ringing effects. 

Solution: LPF which are piecewise continuous functions in the spectral domain.

## 2.11 Gaussian Low Pass Filter

$$
\Large G(k_x, k_y) = exp(-\frac{k_x^2 + k_y^2}{2\sigma^2})
$$

where $\alpha$ is the width of the filter





## 2.12 Butterworth Low Pass Filter

$$
\Large B(k_x, k_y) = \frac{1}{1 + (\frac{k_x^2 + k_y^2}{\sqrt{K}})^{2n}}
$$

## 2.13 Band Pass Filtering

A filter with two frequency thresholds that passes frequencies within a given range

## 2.14 Fourier Space Correlation

Operation: find all the regions with certain properties

Process: transform image and mask into Fourier space and multiply. Frequencies in mask remain, whilst others set zero.

# 3. Color 

## 3.1 RGB

Colors represented as Red, Green and Blue intensities.

Lightness: average value of three R, G and B channels. $L = (R+G+B)/3$

Chromaticity: Normalizes the current RGB values for differences in lighting. $(r,g,b) = (R/(R+G+B), G/(R+G+B), B/(R+G+B))$

## 3.2 HSV

Hue: dominant wavelength of colour

Saturation: amount of Hue present

Value: brightness of color

Hue: $0^\circ \rightarrow 260^\circ$

Saturation: $0\rightarrow 1$

Value: $0\rightarrow 1$

## 3.3 RGB to HSV

$$
\Large
\begin{cases}
R^{'} &= R/255\\
G^{'} &= G/255\\
B^{'} &= B/255\\
C_{max} &= max(R^{'}, G^{'}, B^{'})\\
C_{min}&= min(R^{'}, G^{'}, B^{'})\\
\Delta& = C_{max} - C_{min}\\

\end{cases}
$$

Hue calculation
$$
\Large H =
\begin{cases}
60^\circ (\frac{G^{'} - B^{'}}{\Delta}mod\;6), C_{max} = R^{'}\\
60^\circ (\frac{B^{'} - R^{'}}{\Delta}+2), C_{max} = G^{'}\\
60^\circ (\frac{R^{'} - G^{'}}{\Delta}+4), C_{max} = B^{'}
\end{cases}
$$
Saturation Calculation
$$
\Large
S = \begin{cases}
0, \Delta = 0\\
\frac{\Delta}{C_{max}}, \Delta \neq 0
\end{cases}
$$


Value Calculation
$$
\Large
V = C_{max}
$$
Easier to color threshold in HSV space than RGB.























































