# 1. Image 

**Image color resolution**

binary image has 2 colors (black or white)

grayscale commonly has 256 grey levels

color commonly 256 values for each channels

**Temporal resolution**

number of images captured in a given time period (frame per seconds, fps).

**Pixel co-ordinates**

<img src="./Img/Screenshot 2022-01-24 025315.png" style="zoom:50%;" />

For grayscale images, each point represent grayscale value. For color image, each point represent three color values.

Normally, c is equal to x axis, and r is y-axis.



# 2. Sampling

Image digitization: analogue image quantized into an 2D array or matrix of numbers.

Two levels of quantization sampling:

1. Sample or Spatial Quantization (discrete image $C\times R$ resolution)
2. Color or intensity Quantization (discrete number of  gray or color levels)

Summarized as:

1. Continuous to Discrete
2. Analogue to Digital

Digitalization maps the continuous real-world into a discrete computational form (2D image)



## 2.1 Spatial Quantization

Sampling of the image at a number of points. Usually a $C\times R$ rectangular grid
$$
\Large f_{ij} \rightarrow f(x_i, y_i)
$$


Each element of the array $f_{ij}$ is refereed to as a pixel.



## 2.2 Sampling Theorum



















