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

## 1.3 Region Merging

At start region == pixels; Iteratively merge regions; similarity measure $M$

$M$ difference of 1 between gray levels

Input: image gray level image (1 - 10)

Iteration 1: Identifies regions of the same gray level and merges them.

Iteration 2: merges are looked for with gray level difference of 1

Iteration N: ....

result: Image segmented into two distinct objects

## 1.4 Splitting

top-down method, start from whole image.

