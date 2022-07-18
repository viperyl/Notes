# Table of Contents

1. [ArcFace](#ArcFace Loss)
2. [Example2](#example2)
3. [Third Example](#third-example)
4. [SoftMax](#SoftMax)



































## ArcFace Loss

Normalize the embeddings and weights

Calculate the dot product

Calculate the angles with arccos

Add a constant factor $m$ to the angle corresponding to the ground truth label

Turn angle back to the cosine

Use cross entropy on the new cosine values to calcualte loss


$$
\Large 
L = -\frac{1}{N} \sum\limits_{i=1}^{N} log\frac{e^{s(\cos(\theta_{y_i}+m))}}{e^{s(\cos(\theta_{y_i}+m))} + \sum\limits_{j=1,j\neq y_i}^{n}{e^{s\cos(\theta_j)}}}
$$


## Example2
## Third Example
## SoftMax

