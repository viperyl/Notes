

### No.258

Assume a number
$$
\Large a_0\times10^0 + ... + a_{n-1}\times10^{n-1}
$$
sum of every digits
$$
\Large a_0 + a_1 + ... + a_{n-1}
$$
mod 9 for original digits
$$
\begin{align}

&(a_0\;mod\;9)(10^0\;mod\;9) + ... + (a_{n-1}\;mod\;9)(10^{n-1}\;mod\;9)\\
&= (a_0\;mod\;9) + (a_1\;mod\;9) + ... + (a_{n-2}\;mod\;9) + (a_{n-1}\;mod\;9)\\
&= (a_0 + a_1 + ... + a_{n-2} + a_{n-1})\;mod\;9

\end{align}
$$
we build a connection between above original numbers and sum of its digits





### No.560

Solution 1: Brute force, Prefix sum

```
class Solution:
    def subarraySum(self, nums: List[int], k: int) -> int:
        preSum = [nums[0]] * len(nums)
        res = 0
        for i in range(1, len(nums)):
            preSum[i] = preSum[i-1] + nums[i]
        for i in range(len(nums)):
            if preSum[i] == k:
                res += 1
            for j in range(i+1, len(nums)):
                if preSum[j] - preSum[i] == k:
                    res += 1

        return res
```



Solution 2: Prefix sum with hashmap

```
class Solution:
    def subarraySum(self, nums: List[int], k: int) -> int:
        prefixHash = collections.defaultdict(int)
        prefixHash[0] = 1
        prefixSum = 0
        res = 0
        for i in range(len(nums)):
            prefixSum += nums[i]
            if prefixSum - k in prefixHash:
                res += prefixHash[prefixSum - k]
            prefixHash[prefixSum] += 1
        return res
```















