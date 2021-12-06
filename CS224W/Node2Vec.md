# Word2Vec

Word2Vec is a shallow, two-layer neural network that is trained to reconstruct linguistic contexts of words. The objective of the word2vec is to produce a word representation given a text corpus



Word2Vec is inspired by the skip-gram model.

# Skip-gram model

The skip-gram model predicts the context for a given word. The context is defined as the adjacent words to the term.

![](./img/1_IAvi1IEavTmXTxE9uegEfw.png)

The input is a one-hot vector, the first layer has $N$ neurons, and each neuron has $V$ weights.

The output of the first neuron is $N\times1$ vector. Then pass into the next layer, which has V neurons, and output is same as the initial input. 

The training dataset is context, while it determined by context window slide.

The activation function is linearly. What we want is the first layer’s weights. Because the first layer map the word from a $V$-dim space to a $N$-dim space.

![](./img/v2-f78f0d03da8564e57480d53e07c464e0_720w.png)

for “The”, [the, quick], [the, brown] is so called positive samples.

If take [the, quick] as input, the SoftMax result is give 1 probability to “quick”.

Negative samples are other combinations with a probability of 0, like [The, fox], [The, jumps], [The, over], [The, the] and etc.

In Node2Vec, the negative sample means non-existent edge.

For undirected graph, there is no difference between edge [0, 1] and [1, 0].

# Implementation

We only need to calculate the embedding layer for $(u, v)$. Then apply the sigmoid function to map value to the interval $[0, 1]$. For the positive sample, we want it close to the 1 and for the negative value we want it approximate to 0.

Assume our graph have $N$ nodes, and we want to embed it to a $D$ vector. And assume $(U_1, V_1)$ is a positive sample pair.

1. Embedding node $U_1$ and $V_1$ separately. the result are $U_1^{emb}: 1\times D$ and $V_1^{emb}: 1\times D$ .
2. Apply elementwise multiplication. The results is $1\times D$ vector.
3. Sum the result vector at axis 1, the result is a scale $1\times1$ value.
4. Pass the scale and label to the loss function.
5. Iterate until network convergence.

 















































