# Image segmentation

## 1.1 Regions: growing and splitting

**Merging**:

1. Start with individual pixels and iteratively combine into consistent image regions
2. bottom up approach

**Splitting**

1. Start with the entire image and iteratively sub-divide into consistent image regions.
2. top down approach

segment approach $\rightarrow$ similarity

1. intensity
2. color 
3. texture 
4. motion



## 1.2 Region Growing

Input: set of unassigned pixels

Output: consistently labelled regions.

common variations

1. add all consistent neighbors at one (fast convergence)
2. maintain statistics of each region



