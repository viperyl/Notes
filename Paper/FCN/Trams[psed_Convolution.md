# Transposed Convolution

转置卷积

Fractionally-stride convolution; Deconvolution

作用： upsampling

对于一个$4\times4$的图片，使用$3\times3$, stride = 1, padding = 0 的卷积核，所得的结果为$2\times2$

对于一个$2\times2$的图片， 使用$3\times3$，stride =1, padding = 2 的卷积核，所得的结果为$4\times4$

如此就实现了上采样



对于上述的操作

对于下采样：padding = 0， strides = 1， convolution

对于上采样：padding = 0， strides = 1，transposed convolution

# Work

step 1. 在输入的特征图元素间填充$s-1$ 行，列 $0$

step 2. 在输入特征图元素间填充 $k-p-1$行，列$0$

step 3. 将卷积核参数上下，左右翻转

step 4. 做普通的卷积运算，strides = 1, padding = 0



最终的图尺寸为
$$
\Large
H_{out} = (H_{in} - 1)\times stride[0] - 2 \times padding[0] + kernelSize[0]\\
\Large
W_{out} = (W_{in} - 1)\times stride[1] -2\times padding[1] + kernelSize[1]
$$
 若输入的feature map 为$\Large \begin{bmatrix}2&3\\1&3 \end{bmatrix}$

卷积核为$\Large \begin{bmatrix}0&1 & 1\\0 &1 & 0\\ 1 & 0 & 1 \end{bmatrix}$, 上下左右翻转后为$\Large \begin{bmatrix}1&0 & 1\\0 &1 & 0\\ 1 & 1 & 0 \end{bmatrix}$, 执行普通的卷积操作后结果为$\Large \begin{bmatrix}0&2 & 5&3\\0 &3&7 & 3\\ 2 & 4 & 5 &3\\1&3&1&3\end{bmatrix}$



`torch.nn.ConvTranspose2d`



## 卷积计算

若卷积核为$\Large \begin{bmatrix}0&1 & 1\\0 &1 & 0\\ 1 & 0 & 1 \end{bmatrix}$. 若feature map 为$\Large \begin{bmatrix}1&0&1 & 0\\0 &0&1 & 1\\ 1 & 0&0 & 1\\0&1&0&0 \end{bmatrix}$, 构建等效卷积核

$\Large \begin{bmatrix}0&1&1 & 0\\0 &1&0 & 0\\ 1 & 0&1 & 0\\0&0&0&0 \end{bmatrix}$​ $\Large \begin{bmatrix}0&0&1 & 1\\0 &0&1 & 0\\ 0 & 1&0 & 1\\0&0&0&0 \end{bmatrix}$​ $\Large \begin{bmatrix}0&0&0 & 0\\0 &1&1 & 0\\ 0 & 1&0 & 0\\1&0&1&0 \end{bmatrix}$​ $\Large \begin{bmatrix}0&0&0 & 0\\0 &0&1 & 1\\ 0 & 0&1 & 0\\0&1&0&1 \end{bmatrix}$ 



将上述的矩阵flatten
$$
\Large \bold{C} = \begin{bmatrix} 0&1&1&0&0&1&0&0&1&0&1&0&0&0&0&0\\
0&0&1 & 1&0 &0&1 & 0& 0 & 1&0 & 1&0&0&0&0\\
0&0&0 & 0&0 &1&1 & 0& 0 & 1&0 & 0&1&0&1&0\\
0&0&0 & 0&0 &0&1 & 1& 0 & 0&1 & 0&0&1&0&1

\end{bmatrix}
$$
将feature map flatten
$$
\Large \bold{I} = \begin{bmatrix}1&0&1 & 0&0 &0&1 & 1& 1 & 0&0 & 1&0&1&0& \end{bmatrix}
$$


再展平我们的feature map， 二者相乘可得结果，
$$
\Large \bold{I}^{1\times16}\bold{C}^{16\times4} = \bold{O}^{1\times4}
$$
















