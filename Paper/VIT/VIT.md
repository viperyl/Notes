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

拼接 class token： $Cat([1, 768], [196, 768]) \rightarrow [197, 768]$     [1, 768]是可训练的

叠加Position Embedding：$[197,768] + [197, 768] \rightarrow [197, 768]$



# 2. Position Embedding

![](./Img/Screenshot 2022-01-31 031952.png)

原论文给出了不同的Position embedding 的结果。

无position embedding的准确率是0.61382.使用了一个一维的位置编码会提升3个百分点。

```
The difference in how to encode spatial information is less important
```

<img src="./Img/Screenshot 2022-01-31 032507.png" style="zoom:45%;" />

每个token 都会叠加一个position encoding。对每个patches 都会有一个自己的位置编码，将一个patch的位置编码和其他的位置编码做一个余弦相似度计算就会得到上述的图。自身和自身的相似度为1.
$$
\Large cos(A,B) = \frac{A \cdot B}{|A| |B|} 
$$


# 3. Transformer Encoder

<img src="./Img/Screenshot 2022-01-31 130436.png" style="zoom:50%;" />











