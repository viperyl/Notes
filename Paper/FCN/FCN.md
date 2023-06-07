Fully Convolutional Networks for Semantic Segmentation

通过一系列的卷积下采样最后可以得到一个深度为21的feature map，上采样feature map到和原图一样尺寸，但channel 为21。在channel维度上做softmax，可以得到每个像素在每个类别上的概率。

<img src="./Img/Screenshot 2022-02-04 113249.png" style="zoom:50%;" />



FCN-32s: 32x upsampled prediction 



# Architecture

FCN-32S

<img src="./Img/Screenshot 2022-02-04 123935.png" style="zoom:75%;" />

FCN-16S

<img src="./Img/Screenshot 2022-02-04 124036.png" style="zoom:75%;" />



FCN-8S

<img src="./Img/Screenshot 2022-02-04 124214.png" style="zoom:75%;" />





# Loss Calculation

Cross Entropy Loss





# Implementation

Pytorch 的Backbone 为ResNet-50, 也用到了膨胀卷积。

![](./Img/torch_fcn.png)























