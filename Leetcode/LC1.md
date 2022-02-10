

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



### No. 547

Solution 1. Breadth first search

```
class Solution:
    def findCircleNum(self, isConnected: List[List[int]]) -> int:
        def bfs(grid, i, j, visited):
            queue = [i, j]
            while queue != []:
                pos = queue.pop()
                if pos not in visited:
                    visited.add(pos)
                else:
                    continue
                for k in range(n):
                    if grid[pos][k] == 1:
                        queue.append(k)


        n = len(isConnected)
        res = 0
        visited = set()
        for i in range(n):
            for j in range(i, n):
                if j in visited:
                    continue
                if isConnected[i][j] == 1:
                    res += 1
                    bfs(isConnected, i, j, visited)
                    break
        return res
```





### No. 1091

Solution 1. Depth first search, time limited

```
class Solution:
    def shortestPathBinaryMatrix(self, grid: List[List[int]]) -> int:
        if grid[0][0] == 1 or grid[-1][-1] == 1:
            return -1
        n = len(grid)
        directions = [(i-1, j-1) for i in range(3) for j in range(3)]
        directions = directions[:4] + directions[5:]
        queue = [(0, 0, -1)]
        while queue != []:
            x, y, step = queue.pop()
            step *= -1
            cur_step = -grid[x][y]
            if cur_step == 0:
                grid[x][y] = -step
            elif step < cur_step and cur_step != 0:
                grid[x][y] = -step
            else:
                continue
            if x == n-1 and y == n-1:
                continue


            for direction in directions:
                x_i, y_i = direction
                new_x, new_y = x + x_i, y+y_i
                if 0 <= new_x <= n-1 and 0<= new_y <= n-1 and grid[new_x][new_y] != 1:
                    queue.append((new_x, new_y, -step-1))


        if grid[-1][-1] == 0:
            return -1

        return -grid[-1][-1]
```

Solution 2: Breadth first search

```
from collections import deque
def shortestPathBinaryMatrix(grid) -> int:
    if grid[0][0] == 1 or grid[-1][-1] == 1:
        return -1
    n = len(grid)
    queue = deque()
    visited = dict()
    queue.append((0,0))
    visited[(0, 0)] = True
    start = 1
    directions = [(i-1, j-1) for i in range(3) for j in range(3)]
    directions = directions[:4] + directions[5:]
    while queue:
        for _ in range(len(queue)):
            ind, con = queue.pop()
            for pos_h, pos_w in directions:
                new_ind = ind + pos_h
                new_con = con + pos_w

                if 0<= new_ind <= n-1 and 0 <= new_con <= n-1 and grid[new_ind][new_con] == 0 and not visited.get((new_ind, new_con)):
                    if new_ind == n-1 and new_con == n-1:
                        return start + 1
                    queue.appendleft((new_ind, new_con))
                    visited[(new_ind, new_con)] = True
        start += 1
    return -1
```

Solution 2.1 BFS (myself)

```
```













