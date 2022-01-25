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

input position $(c_1, r_1)$ to output image position $(c_2, r_2)$ as follows:









