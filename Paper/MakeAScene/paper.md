

## Solved

1. Enabling a simple control mechanism complementary to text in the form of a scene,
2.  Introducing elements that substantially improve the tokenization process by employing domain-specific knowledge
   over key image regions (faces and salient objects)
3. Adapting classifier-free guidance for the transformer use case. 



## Methods

### 1 Scene representation and tokenization

网络会先学习一个语义的laout，并在最终生成图片的时候调整它

文中作者使用了 VQ-SEG 来学习segmentation layout。网络的输入输出都有m个channels，代表着所有的分割组
$$
\Large
m = m_p + m_h + m_f + 1
$$
$m_p, m_h, m_f$ 分别代表全景分割的物品类别。额外的一个channel代表不同class和instance之间的edge。并且强调了具有稀缺重要性的指标，比如对于不同尺寸的物体，总像素数量所带来的偏置比周长带来的偏执更大



Overcoming out-of-distribution text prompts with scene control. By introducing simple scene sketches as additional
inputs, our method is able to overcome unusual objects and scenarios presented as failure cases in previous methods.



### 2 Adhering to human emphasis in the token space

VQ图片重建间的质量内在的迁移到了生成图片的transformer上了 (observed).



### 3 Face-aware vector quantization


$$
\Large
\mathcal{L}_{\text{Face}} = \sum\limits_{k}\sum\limits_{l} \alpha_f^l \lVert \text{FE}^l(\hat{c}_f^k) - \text{FE}^l(c_f^k)\rVert 
$$
其中index $l$用于表示人脸embedding网络特定层的空间激活的大小 

$\hat{c}, c$ 





### 3 Scene-based transforme







### 4 Transformer classifier-free guidance

















