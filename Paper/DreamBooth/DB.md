![](./Img/Screenshot 2022-09-10 at 07-44-50 2208.12242.pdf.png)

使用3-5张有着subject的图片和对应的subject名称作为输入。经过fine-tine 后会生成一个模型，这个模型将unique identifier 编码了。在inference阶段，我们将unique identifier 植入不同的句子中来获得语义信息不同的语句。

![](./Img/Screenshot 2022-09-10 at 09-11-37 2208.12242.pdf.png)

目标是在给定几张有着特定主题的图像和文字提示下生成高保真和变化主题的新图像。我们希望可以改变主体的某个属性，颜色，种类，形状。或修改主题的动作，姿态，材料等其他语义信息。

首先，我们需要将subject instance 嵌入到output domain里面，并将subject instance和unique identifier bind 到一起。第二个要减轻language dift 问题 （language drift 指的是模型缓慢的失去语言的句法和语义特性，由于专注于finetune task）。

解决方法分为两个步骤

1. 使用image-text pairs finetune 低分辨率的 text-to-image 模型，其中text prompts 需要包含unique identifier。同时，使用 class-specific prior preservation loss 来利用模型上的语义先验信息并且鼓励模型产生多样的属于text prompt 的结果。学习universal feature 跟 specific feature
2. fine-tune SR 模型 by 低分辨率图（模型生成）和高分辨率图（数据集），增强保真度和细节。

## Representing the Subject with a Rare-token Identifier







