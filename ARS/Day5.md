

## Preliminaries



Task allocation Problem
$$
\Large \underset{S\in\mathcal{I}}{\text{opt}} \sum\limits_{a\in\mathcal{A}} f_a(S_a)
$$
$\Large \mathcal{S} \in \mathcal{A}\times\mathcal{T}$: The agent-task allocation set

$\Large S_a$: the task allocation subset for agent $\Large a (S = \cup_{a\in\mathcal{A}}S_a)$

$\Large \mathcal{I}$: a collection of independent sets

**Key mathematical properties for Task Allocation Problem**

1. Submodularity
2. Monotonicity
3. Matroid constraint 

### Definition

#### Marginal Gain

For a set function $\Large f: 2^\mathcal{N} \rightarrow \mathbb{R}, S\subseteq \mathcal{N}, u\in \mathcal{N}$ , define the `marginal gain` of $\Large f$ at $\Large S$ with respect to $\Large u$ as
$$
\Large \Delta f(u\vert S) := f(S\cup\{u\}) - f(S)
$$
<img src="./Img/Screenshot from 2022-02-18 103625.png" style="zoom:50%;" />





#### Submodularity

Let $\Large \mathcal{N}$ denote the ground set which is finite, A real-valued set function $\Large f: 2^\mathcal{N} \rightarrow \mathbb{R}$ is submodular if for all $\Large A\subseteq B\subseteq \mathcal{N}$ and $\Large u\in \mathcal{N}\backslash B$
$$
\Large \Delta f(u\vert A) \geq \Delta A(u\vert B)
$$

#### Remark (Diminishing return)

The marginal gain of a given element $u$ will never increase as more elements have already been added into the set $\Large S$



#### Equivalent characterizations for submodularity

**Diminishing gains**

for all $\Large A\subseteq B$
$$
\Large f(A\cup u) - f(A) \geq f(B\cup u) - f(B)
$$
This is intuitive, place a sensor to small sensor amount room is much useful than large sensor amount room

**Union-intersection**

for all $\Large A, B \subseteq \mathcal{N}$
$$
\Large 
\begin{align}
f(A)+ f(B) \geq f(A\cup B) + f(A\cap B)\\
r(A) + r(B \geq r(A\cup B) + r(A\cap B)


\end{align}
$$


**Concavity**

for all $\Large a \leq b$ and $\Large  u > 0$
$$
\Large f(a + u) - f(a) \geq f(b+s) - f(b)
$$


#### Matroids

A matroid is a pair $\Large \mathcal{M} = (\mathcal{N}), \mathcal{I}$, where $\Large \mathcal{N}$ is a finite set and $\large \mathcal{I} \subseteq 2^{\mathcal{N}}$ is a collection of independent sets, satisfying:
$$
\Large \begin{align}
\varnothing \in \mathcal{I}\\
A\subseteq B, B\subseteq \mathcal{I} \rightarrow A\in \mathcal{I}\\
A,B\in \mathcal{I}, |A| < |B| \rightarrow \exist i\in B\backslash A \text{ such that} A\cup\{i\}\in \mathcal{I}

\end{align}
$$
 





\Large 

\mathcal

\mathbb













