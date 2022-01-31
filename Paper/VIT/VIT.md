# Vision Transformer

<img src="./Img/Screenshot 2022-01-31 025605.png" style="zoom:55%;" />

首先将图片分解为多个块(patch)，然后美个快会被送入 Linear Projection of Flattened Patches 中。

实际上的作用与Embedding 层类似，得到的结果称之为Token。此外我们还需要加一个额外的Token，用于分类的class Token。

此外我们还需要加上一个位置信息，也就是Position encoder， 论文中的Position encoder 是使用可训练的参数。

所得到的Token会进入Transformer Encoder。其中Class Token 的结果会进入到MLP head 中用于网络的类别预测。

 

# 1. Embedding

对于标准的Transformer模块，要求输入的是Token 序列，即为二维矩阵 [num_token, token_dim].

代码实现中，直接通过一个卷积层来实现 ViT-B/16为例，使用卷积核大小$16\times16$,stride 为16，卷积核768
$$
\Large [224, 224,3] \rightarrow [14,14,768] \rightarrow [196, 768]
$$
在输入Transformer Encoder 之前需要加上 class token 和position embedding， 原论文中都是可训练数据。

拼接 class token： $Cat([1, 768], [196, 768]) \rightarrow [197, 768]$

叠加Position Embedding：$[197,768] \rightarrow [197, 768]$



















