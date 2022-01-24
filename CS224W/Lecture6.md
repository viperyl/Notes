# 1 Graph Neural Networks

## 1. 1 Recap

Node Embeddings intuition: Map nodes to d-dimensional embeddings such that similar nodes in the graph are embedded close together.

![](./Img/Screenshot from 2022-01-24 14-40-22.png)

Goal: similarity $(u, v) \approx \bold{z}_v^T\bold{z}_u$

![](./Img/Screenshot from 2022-01-24 14-42-29.png)



Simplest encoding approach: encoder is just an embedding-lookup.

This lecture will present the deep learning encoder.

<img src="./Img/Screenshot from 2022-01-24 14-49-16.png" style="zoom:50%;" />

## 1.2 Task in Graph Neural Networks

1. Node classification: Predict a type of a given node
2. Link prediction: Predict whether two nodes are linked
3. Community detection: Identify densely linked clusters of nodes
4. Network similarity: How similar are two sub networks

Modern machine learning toolbox is designed for simple sequence and grids. Means the data is linear sequences or fixed size grid.

![](./Img/Screenshot from 2022-01-24 14-55-12.png)





# 2. Local Network neighborhoods

Assume we have a graph $\bold{G}$

$V$ is the vertex set

$\bold{A}$ is the adjacency matrix

$\bold{X}\in \mathbb{R}^{m\times |V|}$ is a matrix of nodes features

$v$ is a node in $V$

$N(v)$ is set of neighbors of $v$

**Node features**

1. Social networks: User profile, User image
2. Biological networks: Gene expression profiles, gene functional information
3. When there is no node feature in the graph dataset: indicator vectors (one-hot encoding of a node); Vector of a constant 1 ({1, 1, 1, …, 1})

## 2.1 Naive Approach

Joint adjacency matrix and features, feed them into a neural network:

![](./Img/Screenshot from 2022-01-24 16-10-13.png)

 Issues with this idea

1. $O(|V|)$ parameters
2. Not applicable to graphs of different sizes
3. Sensitive to node ordering

Idea is coming from the convolution neural network.

Goal is to generalize convolutions beyonds simple lattices Leverage node  features/attributes.

## 2.2 From Images to Graphs 

Single convolution neural network Layer with $3\times3$ filter

Idea is transform information at the neighbors and combine it:

1. Transform “Messages” $h_i$ from neighbors: $W_i h_i$
2. Add them up: $\sum\limits_{i} W_ih_i$

![](./Img/Screenshot from 2022-01-24 16-23-17.png)

Graph convolution Network idea: Node’s neighborhood defines a computation graph. Learn how to propagate information across the graph to compute node features, how to create new message that then the next node up the chain can again aggregate.

Two step process:

1. Determine node computation graph
2. Propagate and transform information



## 2.3 Aggregate Neighbors

Key idea: Generate node embeddings based on local network neighborhoods.

![](./Img/Screenshot from 2022-01-24 16-45-56.png)



Network neighborhood defines a computation graph. Every node defines a computation graph based on its neighbors.

![](./Img/Screenshot from 2022-01-24 16-49-10.png)





































