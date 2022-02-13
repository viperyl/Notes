

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





### No. 567

Solution 1: sliding windows

```
class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        if len(s2) < len(s1):
            return False
        s1_hash = [0] * 26
        s2_hash = [0] * 26
        for s in s1:
            s1_hash[ord(s) - ord("a")] += 1
        left, right = 0, len(s2) - 1

        for right in range(len(s1)):
            s2_hash[ord(s2[right]) - ord("a")] += 1


        while True:
            if s1_hash == s2_hash:
                return True

            left += 1
            right += 1
            if right >= len(s2):
                return False

            s2_hash[ord(s2[right]) - ord("a")] += 1
            s2_hash[ord(s2[left - 1]) - ord("a")] -= 1
```



### No. 78

Solution 1: Back tracking

```
class Solution:
    def subsets(self, nums: List[int]) -> List[List[int]]:
        res = []
        n = len(nums)
        def backtracking(i, tmp):
            res.append(tmp)
            for j in range(i, n):
                backtracking(j + 1, tmp + [nums[j]])
        backtracking(0, [])
        return res
        
```



Solution 2: build-in function

```
class Solution:
    def subsets(self, nums: List[int]) -> List[List[int]]:
        res = []
        for i in range(len(nums) + 1):
            for tmp in itertools.combinations(nums, i):
                res.append(tmp)
        return res
```



### No.47

Solution 1: back tracking

```
class Solution:
    def permuteUnique(self, nums: List[int]) -> List[List[int]]:
        def backtracking(cur, tmp):
            if (len(cur) == len(nums)):
                string_cur = [str(i) for i in cur]
                hashlist = "".join(string_cur)
                if hashlist in visited:
                    return
                else:
                    visited.add(hashlist)
                    res.append(cur)
                    return


            for i in range(len(tmp)):
                if tmp[0:i] == []:
                    backtracking(cur + [tmp[i]], tmp[i+1:])
                elif tmp[i+1:] == []:
                    backtracking(cur + [tmp[i]], tmp[0:i])
                else:
                    backtracking(cur + [tmp[i]], tmp[0:i] + tmp[i + 1:])
        visited = set()
        res = []
        backtracking([], nums)
        return res
        
        
```





### No. 39

Solution 1. Back tracking

```
class Solution:
    def combinationSum(self, candidates: List[int], target: int) -> List[List[int]]:
        def backtracking(currSum, index, path):
            if currSum == target:
                res.append(path)
                return
            for i in range(index, n):
                newSum = candidates[i] + currSum
                if newSum <= target:
                    backtracking(newSum, i, [candidates[i]] + path)

        candidates.sort()
        res = []
        n = len(candidates)
        backtracking(0, 0, [])
        return res
        
```



### No. 2

Solution 1: new a linked list for adding operation

```
class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        start = ListNode(0)
        temp = start
        up = 0
        while l1 != None and l2 != None:
            curNode = ListNode(0)
            curNode.val = l1.val + l2.val + up
            if curNode.val >= 10:
                up = 1
                curNode.val %= 10
            else:
                up = 0
            temp.next =  curNode
            temp = temp.next
            l1 = l1.next
            l2 = l2.next
        if l1 == None and l2 == None:
            if up == 1:
                temp.next = ListNode(1)
            return start.next
        elif l1 == None:
            res = l2
        elif l2 == None:
            res = l1
        
        if up == 0:
            temp.next = res
        else:
            while res != None:
                curNode = ListNode(0)
                curNode.val = res.val + up
                if curNode.val >= 10:
                    curNode.val %= 10
                    up = 1
                else:
                    up = 0
                res = res.next
                temp.next = curNode
                temp = temp.next
                if up == 0:
                    temp.next = res
        if up == 1:
            temp.next = ListNode(1)
        return start.next
                
```







### No. 19

Solution 1: two pointer

```
class Solution:
    def removeNthFromEnd(self, head: Optional[ListNode], n: int) -> Optional[ListNode]:
        l1, l2 = head, head
        if l1.next == None:
            return None
        pre_l1 = None
        while n != 1:
            l2 = l2.next
            n = n-1
        if l2.next == None:
            return head.next
        
        while l2.next != None:
            pre_l1 = l1
            l1 = l1.next
            l2 = l2.next
        pre_l1.next = l1.next
        return head
            
```







### No.83

Solution 1: Two Adjacent pointer

```
class Solution:
    def deleteDuplicates(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if head == None:
            return head
        cur = head
        nextN = head.next
        while nextN != None:
            if nextN.val == cur.val:
                nextN = nextN.next
                cur.next = nextN
            else:
                cur = cur.next
                nextN = nextN.next
        return head
                
```









### No. 24

Solution 1: quad pointer

```
class Solution:
    def swapPairs(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if head == None or head.next == None:
            return head
        l1 = head
        l2 = l1.next
        l3 = l2.next
        l1.next, l2.next = None, None
        l2.next = l1
        l1.next = l3
        start = l2
        l1, l2 = l2, l1
        while l3 != None:
            prel1 = l2
            l1 = l1.next.next
            l2 = l2.next.next
            for i in range(2):
                if l3 == None:
                    return start
                l3 = l3.next
            l1.next, l2.next = None, None
            l1, l2 = l2, l1
            prel1.next, l1.next, l2.next = l1, l2, l3

        return start
```



### No. 61

Solution 1: Brute force

```
class Solution:
    def rotateRight(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        if head == None or head.next == None:
            return head
        p1, counter = head, 0
        p4 = None
        while p1 != None:
            p4 = p1
            p1 = p1.next
            counter += 1
        k = k % counter
        if k == 0:
            return head
        
        p1, p2 = head, head
        counter1 = 1
        while counter1 != counter - k:
            p2 = p2.next
            counter1 += 1
        p3 = p2.next
        p2.next = None
        p4.next = head
        return p3
```



### No. 86

Solution 1:  in-plane change every node

```
class Solution:
    def partition(self, head: Optional[ListNode], x: int) -> Optional[ListNode]:
        if head == None or head.next == None:
            return head
        start1 = ListNode()
        start2 = ListNode()
        ps1, ps2 = start1, start2
        p1 = head
        while p1 != None:
            if p1.val < x:
                ps1.next = p1
                p1 = p1.next
                ps1 = ps1.next
                ps1.next = None
            else:
                ps2.next = p1
                p1 = p1.next
                ps2 = ps2.next
                ps2.next = None
        if start1.next == None:
            return start2.next
        if start2.next == None:
            return start1.next
        start1 = start1.next
        start2 = start2.next
        ps1.next = start2
        return start1
```







### No. 92

Solution 1: brute force

find the starting node and ending node for sorting. then perform ascending sort.

to prevent starting node in the start of the linked list or ending node in the end of the linked list, we need add assistant node to prevent `None` value, because None value don't has the `val` and `next` attribute.

```
class Solution:
    def reverseBetween(self, head: Optional[ListNode], left: int, right: int) -> Optional[ListNode]:
        start = ListNode(0)
        start.next = head
        if left == right:
            return head
        p1, pp1 = head, start
        counter = 1
        while counter != left:
            pp1 = p1
            p1 = p1.next
            counter += 1
        p2, np2 = p1, p1.next
        while counter != right:
            np2 = np2.next
            p2 = p2.next
            counter += 1
        if np2 == None:
            p2.next = ListNode(114514)
            np2 = p2.next
        pp1.next = None
        p2.next = None
        s1 = None
        s2 = p1
        s3 = p1.next
        while s3 != None:
            s2.next = s1
            s1 = s2
            s2 = s3
            s3 = s3.next
        s2.next = s1
        pp1.next = s2
        if np2.val != 114514:
            p1.next = np2
        return start.next
```



### No. 445

Solution 1: Brute Force, reverse the first list and the second list, then performing adding operation. Finally return the reversed adding result 

```
class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        def reverseList(start):
            s1 = None
            s2 = start
            s3 = start.next
            while s3 != None:
                s2.next = s1
                s1 = s2
                s2 = s3
                s3 = s3.next
            s2.next = s1
            return s2
        if l1 == None:
            return l2
        if l2 == None:
            return l1
        rl1 = reverseList(l1)
        rl2 = reverseList(l2)
        
        s1 = ListNode(0)
        copys1 = s1
        up = 0
        while rl1 != None and rl2 != None:
            curVal = rl1.val + rl2.val + up
            if curVal >= 10:
                curVal %= 10
                up = 1
            else:
                up = 0
            rl1 = rl1.next
            rl2 = rl2.next
            curNode = ListNode(curVal)
            copys1.next = curNode
            copys1 = copys1.next
        if rl1 == None and rl2 != None:
            res = rl2
        elif rl1 != None and rl2 == None:
            res = rl1
        else:
            res = None
        while res != None:
            curVal = res.val + up
            if curVal >= 10:
                curVal = curVal % 10
                up = 1
            else:
                up = 0
            res = res.next
            curNode = ListNode(curVal)
            copys1.next = curNode
            copys1 = copys1.next
        if up == 1:
            copys1.next = ListNode(1)
        s1 = s1.next
        vsda = reverseList(s1)
        return vsda
```



### No. 23

Solution 1: Brute froce

```
class Solution:
    def mergeKLists(self, lists: List[Optional[ListNode]]) -> Optional[ListNode]:
        start = ListNode(0)
        copystart = start
        while lists != [None] * len(lists):
            # val, counting, index
            adding = [10**10, []]
            for i in range(len(lists)):
                curList = lists[i]
                if curList == None:
                    continue
                if curList.val < adding[0]:
                    adding[0] = curList.val
                    adding[1] = [i]
                elif curList.val == adding[0]:
                    adding[1].append(i)
            
            removed = []
            for visit in adding[1]:
                lists[visit] = lists[visit].next
                if lists[visit] == None:
                    removed.append(visit)
                curNode = ListNode(adding[0])
                copystart.next = curNode
                copystart = copystart.next
                
            # print(start)
        return start.next
            
```







