

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

#### Submodularity

Let $\Large \mathcal{N}$ denote the ground set which is finite, A real-valued set function $\Large f: 2^\mathcal{N} \rightarrow \mathbb{R}$ is submodular if for all $\Large A\subseteq B\subseteq \mathcal{N}$ and $\Large u\in \mathcal{N}\backslash B$
$$
\Large \Delta f(u\vert A) \geq \Delta A(u\vert B)
$$

#### Remark (Diminishing return)

The marginal gain of a given element $u$ will never increase as more elements have already been added into the set $\Large S$





\Large 

\mathcal

\mathbb













