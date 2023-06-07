## 什么是语义分割

1. 语义分割 Semantic segmentation, FCN
2.  实例分割 Instance segmentation, Mask R-CNN
3. 全景分割 Panoramic segmentation, Panoptic FPN

## 数据集格式

Pascal VOC 提供了PNG图片，为调色板模式，仅有单通道，0-255 分别映射了不同的颜色。

MSCOCO 给出了多个坐标用以构建一个多边形

## 语义分割结果

Palette mask 蒙版，我们会得到一个单通道的图片，每个像素代表一个颜色。

## 语义分割评价指标

Pixel Accuracy (global Accuracy):
$$
\Large \frac{\sum\limits_{i}n_{ii}}{\sum\limits_{i}t_i}
$$
$n_{ii}$：类别$i$ 被预测为$i$的个数

$t_i$： 图片的总像素个数



Mean Accuracy:
$$
\Large \frac{1}{n_{cls}}\cdot\sum\limits_{i}\frac{n_{ii}}{t_i}
$$
$\Large t_i = \sum\limits_{j}n_{ij}$, 目标类别$i$的总像素个数（真实标签）

$n_{cls}$ : 目标类别个数（包含背景）

对每个类别$i$ 预测正确的像素比例求和后再除以所有的类别数。



Mean IoU
$$
\Large \frac{1}{n_{cls}}\cdot\sum\limits_{i}\frac{n_{ii}}{t_i + \sum\limits_{j}n_{ji} -n_{ii}}
$$
对于类别$i$ 而言，计算正确分类的像素数目 $A$

类别$i$的总像素加上这个类别下的误分类像素总额和 减去正确分类的像素数据A 得到B

用A除以B并求所有类别上的和后除以类别数目。

<img src="./Img/Screenshot 2022-02-04 002710.png" style="zoom:75%;" />

构建一个confuse matrix

<img src="./Img/Screenshot 2022-02-04 002940.png" style="zoom:75%;" />

Global Accuracy:
$$
\Large \frac{16+3+16+12+8}{64} \approx 0.859
$$
class 0 accuracy: $16/20$

class 1 accuracy: $3/4$

class 2 accuracy: $16/16$

class 3 accuracy: $12/16$

class 8 accuracy: $8/8$

class 0 IOU: $\Large\frac{16}{20 + (16+2) - 16}$

class 1 IOU: $\Large\frac{3}{4 + (3+1) - 3}$

class 2 IOU: $\Large\frac{16}{16 + (16+1+1)-16}$

class 3 IOU: $\Large\frac{12}{16 + (12) - 12}$

class 4 IOU: $\Large\frac{8}{8  + (8+2+2)-8}$



## 语义分割标注工具

[Labelme]([wkentaro/labelme: Image Polygonal Annotation with Python (polygon, rectangle, circle, line, point and image-level flag annotation). (github.com)](https://github.com/wkentaro/labelme))

[EISeg]([PaddleCV-SIG/EISeg: 高效交互式语义分割标注软件EISeg 『Efficient and intelligent interactive segmentation annotation software』 (github.com)](https://github.com/PaddleCV-SIG/EISeg))









