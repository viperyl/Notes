# 1. Attention

可以并行化

设输入的时序数据为$[x_1,x_2,...]$

step 1. Embedding 层将时许数据映射为一个高维向量
$$
\Large x_1 \xrightarrow{f(x)} a_1
$$
step 2. 将$a_1$分别与$W^q, W^k, W_v$相乘得到结果$q^1, k^1, v^1$. 这三个参数矩阵是对整个网络共享的。
$$
\Large a_1W^q = q^1; a_1W^k=k^1; a_1W^v = v^1
$$
q: query (to match others)

k: key (to be matched)

v: information to be extracted

并行化：
$$
\Large Q = \begin{bmatrix} q^1\\q^2\end{bmatrix} = \begin{bmatrix} a_1\\a_2\end{bmatrix} W^q
$$

$$
\Large K = \begin{bmatrix} k^1\\k^2\end{bmatrix} = \begin{bmatrix} a_1\\a_2\end{bmatrix} W^k
$$

$$
\Large V = \begin{bmatrix} v^1\\v^2\end{bmatrix} = \begin{bmatrix} a_1\\a_2\end{bmatrix} W^v
$$

step 3. scaled dot-product Attention
$$
\Large \alpha_{1, 1} = q^1 \cdot k^1/ \sqrt{d}\\
\Large \alpha_{1, 2} = q^1 \cdot k^2/\sqrt{d}
$$
d is dimension of $k$.
$$
\Large \hat\alpha_{1,i} = \frac{e^\alpha_{1, i}}{\sum\limits_{j}e^{\alpha_{1,j}}}
$$
step 4. scaled dot-product Attention
$$
\Large \alpha_{2,1} = q^2 \cdot k^1/ \sqrt{d}\\
\Large \alpha_{2, 2} = q^2 \cdot k^2/\sqrt{d}
$$
此步骤也可以并行化
$$
\Large \begin{bmatrix} \hat\alpha_{1,1} & \hat\alpha_{1,2}\\\hat\alpha_{2,1} & \hat\alpha_{2,2}\end{bmatrix} =  \begin{bmatrix} \alpha_{1,1} & \alpha_{1,2}\\ \alpha_{2,1}, & \alpha_{2,2}\end{bmatrix} =  \begin{bmatrix} q^1\\q_2\end{bmatrix}\begin{bmatrix}k^1 & k^2 \end{bmatrix}/\sqrt{d}
$$




step 5. the last step
$$
\Large \begin{bmatrix} b_1\\b_2\end{bmatrix} =  \begin{bmatrix} \hat\alpha_{1,1} & \hat\alpha_{1,2}\\\hat\alpha_{2,1} & \hat\alpha_{2,2}\end{bmatrix}\begin{bmatrix} v^1\\v^2\end{bmatrix}
$$


Summary:
$$
\Large Attention(Q,K,V) = softmax(\frac{QK^T}{\sqrt{d_k}})V
$$

# 2. Multi head Self-Attention

基本架构与上述类似

若我们求得的$q^1 = [1, 1, 0, 1]$

将其分为两个head: $q^{1,1} = [1,1]; q^{1,2} = [0, 1]$

源代码中是直接均分处理，论文中则是采用线性映射。

因此我们可得如下的head
$$
\Large q^{1,1}, q^{1,2}, k^{1,1}, k^{1,2}, v^{1,1}, v^{1,2},  q^{2,1}, q^{2,2}, k^{2,1}, k^{2,2}, v^{2,1}, v^{2,2}
$$
将$q^{1,1}, k^{1,1}, v^{1,1}; q^{2,1}, k^{2,1}, v^{2,1}$ 归为head 1, 将第二个下标为2的归为head 2.

因此可得$b_{1,1}, b_{1,2}, b_{2,1}, b_{2,2}$

再将每个head 做拼接处理 $[b_{1,1}, b_{1,2}], [b_{2,1}, b_{2,2}]$

最后通过$W^O$ 将数据融合
$$
\Large \begin{bmatrix}b_1\\ b_2 \end{bmatrix} = \begin{bmatrix} b_{1,1}&b_{1,2}\\b_{2,1}&b_{2,2}\end{bmatrix}W^o
$$


# 3. Positional Encoding

如果输入为$[a_1, a_2, a_3]$， multi head self-Attention 的结果为$[b_1, b_2, b_3]$.

如果将上述的输入变换位置$[a_1, a_3, a_2]$， 则multi head self-Attention 的结果为$[b_1, b_3, b_2]$.

这个结果不符合直觉。因此我们需要为每个输入加上一个位置编码
$$
\Large a_i \rightarrow pe_i + a_i
$$
论文中给出计算公式和可训练的位置编码方法。









