# Image Information

# 1. Noise source

Noise in capture

1. variations in lighting
2. sensor temperature
3. electrical sensor noise
4. sensor non-uniformity
5. dust in the environment
6. vibration
7. lens distortion
8. focus limitations
9. sensor saturation (too much light)
10. under exposure (too little light)

Noise in sampling

1. limitations in sampling and intensity quantization (aliasing)

Noise in processing

1. limitations in numerical precision (floating point number)
2. potential integer overflow
3. mathematical approximations

Noise from lighting

1. sunlight changes
2. varying artificial light sources
3. interior light sources oscillate with power supply frequency
4. object cast shadows, they move shadows change. 

Noise from Occlusion

1. object  obscured by other objects

Noise from image Encoding

1. lossy image compression techniques remove information from image to safe space.

# 2. Salt and Pepper Noise

It is random white or block value pixels into the image. It less common in modern image sensors but present in cheap sensors.

can effect single color channels, and also known as impulse noise.

# 3. Gaussian Noise

It is random variation of the image signal around its true value following the Gaussian or normal distribution.

Most common used noise model in DIP (digital image processing)

# 4. Image Information

## 4.1 Image Geometry

image objects/features have position, scale and orientation.

position $(c, r)$ in the image. Distance between points in the image can be described by following two methods.

1. Euclidean distance in pixels
2. changes in position (manhattan distance)

orientation is 2D rotation within the image co-ordinate system.  the rotation $\theta$ is:
$$
R = \begin{bmatrix}cos(\theta) & -sin(\theta)\\ sin(\theta) & cos(\theta)\end{bmatrix}
$$


image measurement $(c,r)$ within the image related to positions $(x,y)$ in real world measurements (Scale).



## 4.2 Image Connectivity

connectivity choice are 4 or 8 connectivity.



# 5. Geometrical operation on Images

## 5.1 Image Scaling

Image reduction: decrease in image scale (sub-sampling)

Image zooming: increase in image scale (interpolation or pixel replication)

For image sub-sampling, the "linear" method is fast and provide basic effects. "bi-cubic" is slow but good effects.

## 5.2 Image Rotation

input position $(c_1, r_1)$ to output image position $(c_2, r_2)$ as follows (rotation matrix):

$$
\Large c_2 = cos(\theta)(c_1 - c_{origin}) - sin(\theta)(r_1-r_{origin}) + c_{origin}\\
\Large r_2 = sin(\theta)(c_1 - c_{origin}) + cos(\theta)(r_1-r_{origin}) + r_{origin}
$$


## 5.3 Image Translation

input position $(c_1, r_1)$ to output image position $(c_2, r_2)$ as follows:
$$
\Large c_2 = c_1 + C_t\\
\Large r_2 = r_1 + R_t
$$

## 5.4 Image  Reflection

Reflection around a vertical axis with column co-ordinate $C_R$
$$
\Large c_2 = -c_1 + 2*C_R\\
\Large r_2 = r_1
$$
Reflection around a horizontal axis with column co-ordinate $C_R$

$$
\Large c_2 = c_1\\
\Large r_2 = -r_1 + 2 * R_R
$$
Reflection around an axis and passing through
$$
\Large c_2 = c_1 - 2\Delta sin(\theta)\\
\Large r_2 = r_1 + 2\Delta cos(\theta)\\
\Large \Delta = (c_1-C_R)sin(\theta) - (r_1 - r_R)cos(\theta)
$$

## 5.5 Image Information: formal

Image: a discrete set of independent grey levels $g_k$, each occur in image with probability $p_k$

The information represented by $g_k$ can be defined as
$$
\Large I_k = -log_2(p_k) bits\\
\Large \sum\limits_{k=1}^{L}p_k = 1, p_k \leq 1, I_k \geq 0
$$

## 5.6 Image Entropy

Entropy is another measurement of image information

Entropy: minimum channel capacity required to encode the information in a binary form
$$
\Large E = -\sum\limits_{k=1}^{L}p_klog(p_k)
$$
From entropy, define **redundancy** of a given encoding as:
$$
\Large r = b - E
$$
b is minimum numbers of bits required for encoding.

# 6. Types of image data

## 6.1 Color/grayscale

Pixel values contain: encoding wavelength (color) or intensity of light

Issues: perspective projection (3D information in 2D form) is not invertible

## 6.2 Infra-red

Pixel values contain: Infra-red EM intensity

Issues: near and infra-red (different wavelengths); visualization using color mapping.



## 6.3 Medical CT/MRI

Pixel values contain: Values proportional to the absorption characteristics of tissue in relation to a signal projected through the body

Issues: Segmentation; visualization of volumetric data

## 6.4 Radar

Pixel values contain: Value proportional to target distance from the sensor and associated signal reflectivity

Issues: calibrating values to determine distance; noise

## 6.5 3D Imaging

Pixel values contain: distance of object/ surface from sensor

Issues:

1. Explicit 3D information rathe than just a 2D projection
2. partial view of the captured 3D object

## 6.6  Scientific

Pixel values contain: measurements from a given sensor





# Mathematical background

s: Data               p: Point Spread Function                o: Object function                  n: Noise

$\bigotimes$: 1D convolution                  $\bigotimes\bigotimes$: 2D convolution             $\bigoplus$: 1D correlation              $\bigoplus\bigoplus$: 2D correlation

Image data = (Point Spread Function) $\bigotimes$ (Object Function) + Noise

$s = p \bigotimes o + n$

**Point Spread Function**

1. Information of the object function is spread when recoding the data
2. Deterministic characteristic of the imaging instrument (camera)

**Object Function**

1. The object that is being imaged
2. The way light is reflected from that structure to the imaging instrument

**Noise**

1. non-deterministic, stochastic function of all external disturbances
2. best described in terms of a statistical noise distribution

**Convolution Operator**

1. A mathematical operation with "smears" one function with another.

## 7.1 Operation: Convolution

Convolution in 1D 



































  































