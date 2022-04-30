# Slide

## Introduction

Facial expressions are an important channel for interpersonal communication, and recognizing facial expressions can facilitate the understanding of people's mental states and emotions. Unlike conventional facial expressions, 
Micro-expressions are special facial movements that can be used as an important basis for judging people's subjective emotions and have a wide range of applications in public security and psychotherapy. Because micro-expressions
Because micro-expressions are characterized by small amplitude and short duration, the manual recognition of micro-expressions requires professional training and the recognition rate is low. In recent years, many researchers have started to
In recent years, many researchers have started to use computer vision technology to automatically recognize micro-expressions, which has greatly improved the feasibility of micro-expression application. In this paper, we review the definition and research status of facial micro-expression recognition, and summarize
In this paper, we review the definition and research status of micro-expression recognition, summarize some key techniques in micro-expression recognition, and discuss potential problems and possible research directions.









# Notes

Macro-expressions tend to be large and distinct, whereas micro-expressions are very quick and subtle muscle movements.

Only trained people or expert can possible detected Facial micro-expressions.



**Hard in Dataset**

1. Compare with the Macro-expression, Micro-expression is hard to induce.
2. Macro-expression can be recorded by the standard camera. Due to the Micro-expression duration is short, the high-speed camera is required. However, the high-speed camera brings a large amount of data, which increase difficulties for post image processing 



**Dataset**

Marco-expression dataset in the form of video or image. For image, we only detect the static muscle position.

Micro-expression dataset in the form of image, because of the micro-expression reveals the abnormal emotion over a period of time.









CASME II: 640×480@200

| Emotion    | Frequency |
| ---------- | --------- |
| Happiness  | 33        |
| Disgust    | 60        |
| Surprise   | 25        |
| Repression | 27        |
| Others     | 102       |

SMIC: 640×480@100



# Feature Learning

## 3D HOG

### HOG: Histogram of gradient

**1 pre-processing**

Scale the image to  $64\times 128$

optional: binarization and gamma correction.

**2 image gradient**

Use 1D Sobel to calculate the gradient of the image.
$$
\Large 
\begin{align}
G_x &= \text{img}(i+1,j) - \text{img}(i-1,j)\\
G_y &= \text{img}(i,j+1) - \text{img}(i,j-1)\\
G &= \sqrt{G_x^2 + G_t^2}\\
\theta &= \tan^{-1}\left(\frac{G_y}{G_x}\right)
\end{align}
$$
**3 Gradient Histogram**

make $8\times8$ partition form $64\times128$ gradient image. The gradient image contains gradient direction and magnitude.

calculate the histogram of the gradient image, and map the gradient magnitude to the bins.












