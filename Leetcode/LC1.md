

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



### No. 104

Solution 1: BFS

```
class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if root == None:
            return 0
        res = 0
        queue = [(root, 1)]
        while queue != []:
            curNode, depth = queue.pop()
            res = max(res, depth)
            if curNode.left:
                queue.append((curNode.left, depth + 1))
            if curNode.right:
                queue.append((curNode.right, depth + 1))
        return res
```



### No. 213

Solution 1: DP

```
class Solution:
    def rob(self, nums: List[int]) -> int:
        if len(nums) <= 3:
            return max(nums)
        dp1 = [0] * (len(nums) - 1)
        dp2 = [0] * (len(nums) - 1)
        dp1[0] = nums[0]
        dp2[0] = nums[1]
        for i in range(len(nums) - 1):
            dp1[i] = max(dp1[i-2] + nums[i], dp1[i-1])
            dp2[i] = max(dp2[i-2] + nums[i+1], dp2[i-1])
        return max(dp1[-1], dp2[-1])
```



### No. 53

Solution 1: DP

```
class Solution:
    def canJump(self, nums: List[int]) -> bool:
        maxLength = nums[0]
        pos = 0
        while pos <= maxLength and pos < len(nums):
            maxLength = max(maxLength, nums[pos] + pos)
            pos += 1
        if maxLength >= len(nums) -1:
            return True
        else:
            return False
        
```



### No.17

```
class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        if digits == "":
            return []
        orig = ["abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]
        hashmap = dict()
        for i, val in enumerate(orig):
            hashmap[str(i+2)] = val
        
        def backtracking(string, index):
            if index == len(digits):
                res.append(string)
                return
            
            for substr in hashmap[digits[index]]:
                backtracking(string + substr, index+1)
                
        
        res = []
        backtracking("", 0)
        return res
```



### No. 15

Solution 1: Brute force, build map and visited set to avoid repeatance.

```
class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        if len(nums) < 3:
            return []
        nums.sort()
        if nums[0] > 0:
            return []
        if nums[-1] < 0:
            return []
        hashmap = dict()
        for i in range(len(nums)):
            if nums[i] not in hashmap:
                hashmap[nums[i]] = 1
            else:
                hashmap[nums[i]] += 1
        mapping = dict()
        counter = 0
        visited = set()
        res = []
        for k, v in hashmap.items():
            mapping[k] = counter
            counter += 1
        for k1, v1 in hashmap.items():
            for k2, v2 in hashmap.items():
                if k1 == k2 and v1 >= 2:
                    target = 0 - 2 * k1
                elif k1 != k2:
                    target = 0 - k1 - k2
                else:
                    continue
                if target in hashmap:
                    if target == k1 and v1 == 1:
                        continue
                    if target == k2 and v2 == 1:
                        continue
                    if target == k1 and target == k2 and v1 == 2:
                        continue
                    temp = ["0"] * len(hashmap)
                    temp[mapping[k1]] = str(int(temp[mapping[k1]]) + 1)
                    temp[mapping[k2]] = str(int(temp[mapping[k2]]) + 1)
                    temp[mapping[target]] = str(int(temp[mapping[target]]) + 1)
                    encode = "".join(temp)
                    if encode not in visited:
                        visited.add(encode)
                        res.append([k1, k2, target])
        return res
        
```





### No.143

Solution 1: Brute Force, divide the part Linked list to three part: initial part, left part and right part. then break the link for each part. Assign left part and right part to initial part till all part are null.

````
class Solution:
    def reorderList(self, head: Optional[ListNode]) -> None:
        def reverse(start):
            if start == None or start.next == None:
                return start
            pp1 = None
            p1 = start
            np1 = start.next
            while np1 != None:
                p1.next = pp1
                pp1, p1 = p1, np1
                np1 = np1.next
            p1.next = pp1
            return p1
        if head == None or head.next == None or head.next.next == None:
            return
        leftStart = head.next
        leftEnd, rightStart = head, head
        breakdone = False
        while True:
            for _ in range(2):
                if rightStart.next != None:
                    rightStart = rightStart.next
                else:
                    breakdone = True
                    break
            if breakdone:
                break
            leftEnd = leftEnd.next

        rightEnd = leftEnd.next
        leftEnd.next = None
        head.next = None
        rightStart = reverse(rightEnd)

        while rightStart != None:
            if rightStart != None:
                cur_R = rightStart
                rightStart = rightStart.next
                cur_R.next = None
                head.next = cur_R
                head = head.next
            if leftStart != None:
                cur_L = leftStart
                leftStart = leftStart.next
                cur_L.next = None
                head.next = cur_L
                head = head.next
````





### No. 817

Solution 1: Brute Force, list to check element existence

```
class Solution:
    def numComponents(self, head: Optional[ListNode], nums: List[int]) -> int:
        res = 0
        allset = [0] * 10**4
        for i in nums:
            allset[i] += 1
        cur = 0
        total_cur = 0
        while total_cur != len(nums) and head != None:
            if allset[head.val] == 1:
                cur += 1
                total_cur += 1
                allset[head.val] = 0
            elif allset[head.val] == 0 and cur != 0:
                cur = 0
                res += 1
            head = head.next
        # print(res, cur, total_cur, head)
        if cur != 0:
            res += 1
        return res

        
```

Solution 2: Brute Force, set to check existence

```
class Solution:
    def numComponents(self, head: Optional[ListNode], nums: List[int]) -> int:
        res = 0
        allset = set(nums)
        cur = 0
        while len(allset) != 0:
            if head.val in allset:
                cur += 1
                allset.remove(head.val)
            elif head.val not in allset and cur != 0:
                cur = 0
                res += 1
            head = head.next
        if cur != 0:
            res += 1
        return res
        
```

### No. 21

```
class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:
        start = ListNode("asdada")
        # if list1.val < list2.val:
        #     start = list1
        #     list1 = list1.next
        #     start.next = None
        p1 = start
        while list1 != None and list2 != None:
            if list1.val <= list2.val:
                p1.next = list1
                list1 = list1.next
                p1 = p1.next
            else:
                p1.next = list2
                list2 = list2.next
                p1 = p1.next
        if list1 != None:
            p1.next = list1
        if list2 != None:
            p1.next = list2
        return start.next
```



### No. 1290

Solutuon 1: left operator

if value == 0, left shift a bit

if value == 1, left shift a bit then add one to our demical

```
class Solution:
    def getDecimalValue(self, head: ListNode) -> int:
        res = 0
        while head != None:
            if head.val == 0:
                res = res << 1
            else:
                res = res << 1
                res += 1
            head = head.next
        return res
```



### No. 1669

Solution 1: two pointer

```
class Solution:
    def mergeInBetween(self, list1: ListNode, a: int, b: int, list2: ListNode) -> ListNode:
        counter = 0
        left = list1
        while counter != a-1:
            left = left.next
            counter += 1
        right = left
        while counter != b+1:
            right = right.next
            counter += 1
        endList2 = list2
        while endList2.next != None:
            endList2 = endList2.next
        left.next = list2
        endList2.next = right
        return list1
```



### No.114

Solution: DFS and add node to ordered list. Then tranverse the order list to build a new tree in-place

```
class Solution:
    def flatten(self, root: Optional[TreeNode]) -> None:
        """
        Do not return anything, modify root in-place instead.
        """
        def dfs(node):
            orderlist.append(node)
            if node.left == None and node.right == None:
                return
            if node.left:
                dfs(node.left)
            if node.right:
                dfs(node.right)
        
        if root == None:
            return 
        orderlist = []
        dfs(root)
        
        for i in range(1, len(orderlist)):
            orderlist[i-1].left = None
            orderlist[i-1].right = orderlist[i]
```



### No. 430

Solution 1: Brute Force

```
class Solution:
    def flatten(self, head: 'Optional[Node]') -> 'Optional[Node]':
        start = head
        group = []
        while start!= None:
            if start.child:
                group.append([start, start.child, start.next])
                start = start.child
            else:
                start = start.next
        for i in range(len(group)):
            p1 ,p2 ,p3 = group[i]
            if p3 == None:
                p4 = p1.next
            p1.child = None
            p1.next = p2
            p2.prev = p1
            while p2.next != None:
                p2 = p2.next
            p2.next = p3
            if p3 != None:
                p3.prev = p2
            else:
                p2.next = p4
                if p4 == None:
                    continue
                else:
                    p4.prev = p2
                
        return head
```

```
class Solution:
    def flatten(self, head: 'Optional[Node]') -> 'Optional[Node]':
        start = head
        group = []
        while start!= None:
            if start.child:
                group.append((start, start.child, start.next))
                start = start.child
            else:
                start = start.next
        for i in range(len(group)):
            p1 ,p2 ,p3 = group[i]
            if p3 == None:
                p4 = p1.next
            p1.child = None
            p1.next = p2
            p2.prev = p1
            while p2.next != None:
                p2 = p2.next
            p2.next = p3
            if p3 != None:
                p3.prev = p2
            else:
                p2.next = p4
                if p4 == None:
                    continue
                else:
                    p4.prev = p2
                
        return head
```





### No. 160

Solution 1: two pointer, walk through same path, check any interaction

```
class Solution:
    def getIntersectionNode(self, headA: ListNode, headB: ListNode) -> Optional[ListNode]:
        a1 = headA
        a2 = headB
        counter = 0
        while a1 != a2 and counter < 3:
            a1 = a1.next
            a2 = a2.next
            if a1 == None:
                a1 = headB
                counter += 1
            if a2 == None:
                a2 = headA
                counter += 1
        if a1 == a2:
            return a1
        else:
            return 
```

### No. 1367

Solution 1: Transver the tree, if find the node, using dfs

```
class Solution:
    def isSubPath(self, head: Optional[ListNode], root: Optional[TreeNode]) -> bool:
        def findResult(ListNODE, treeNode):
            if ListNODE.next == None:
                return True
            if treeNode.left and treeNode.left.val == ListNODE.next.val:
                 if findResult(ListNODE.next, treeNode.left):
                    return True
            if treeNode.right and treeNode.right.val == ListNODE.next.val:
                if findResult(ListNODE.next, treeNode.right):
                    return True
            
            
            
        queue = [root]
        temp_head = head
        while queue != []:
            curNode = queue.pop()
            # print(curNode.val)
            if curNode.val == head.val:
                # List, tree
                if findResult(temp_head, curNode):
                    return True
            
            if curNode.left:
                queue.append(curNode.left)
            if curNode.right:
                queue.append(curNode.right)
        return False
```



### No. 2058

Solution 1: list record

```
class Solution:
    def nodesBetweenCriticalPoints(self, head: Optional[ListNode]) -> List[int]:
        if head.next.next == None:
            return [-1, -1]
        res = []
        minDistance = 10 ** 10
        p1 = head
        p2 = head.next
        p3 = p2.next
        counter = 1
        while p3 != None:
            if (p2.val > p1.val and p2.val > p3.val) or (p2.val < p1.val and p2.val < p3.val):
                res.append(counter)
                if len(res) >=2:
                    minDistance = min(minDistance, res[-1]-res[-2])

            counter += 1
            p1, p2, p3 = p1.next, p2.next, p3.next
            
        if len(res) <= 1:
            return [-1, -1]
        else:
            return [minDistance, res[-1]-res[0]]
```



### No. 24

Soluton 1: in-place

```
class Solution:
    def swapPairs(self, head: Optional[ListNode]) -> Optional[ListNode]:
        p1 = ListNode(114514)
        p2 = ListNode(114514)
        pp1, pp2 = p1, p2
        counter = 1
        while head != None:
            if counter % 2 == 1:
                pp1.next = head
                head = head.next
                pp1 = pp1.next
                pp1.next = None
            else:
                pp2.next = head
                head = head.next
                pp2 = pp2.next
                pp2.next = None
            counter += 1
        start = ListNode(114514)
        cstart = start
        p1 = p1.next
        p2 = p2.next
        print(p1)
        print(p2)
        for i in range(counter//2):
            if p2 != None:
                cstart.next = p2
                p2 = p2.next
                cstart = cstart.next
            if p1 != None:
                cstart.next = p1
                p1 = p1.next
                cstart = cstart.next
        return start.next
            
        
```



Solution 2: inplace without any additional Linked list

```
class Solution:
    def swapPairs(self, head: Optional[ListNode]) -> Optional[ListNode]:
        start = ListNode(114514)
        cstart = start
        while head != None:
            p1 = head
            p2 = head.next
            for i in range(2):
                if head:
                    head = head.next
            if p2 != None:
                p2.next = None
                cstart.next = p2
                cstart = cstart.next
            if p1 != None:
                p1.next = None
                cstart.next = p1
                cstart = cstart.next
            
        return start.next
```

### No.328

```
class Solution:
    def oddEvenList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        odd, even = ListNode(), ListNode()
        p1, p2 = odd, even
        counter = 1
        while head != None:
            if counter % 2 == 0:
                p2.next = head
                p2 = p2.next
                head = head.next
            else:
                p1.next = head
                p1 = p1.next
                head = head.next
            counter += 1
        p2.next = None
        p1.next = even.next
        return odd.next
        
```



### No.695

Solution 1: BFS

```
class Solution:
    def maxAreaOfIsland(self, grid: List[List[int]]) -> int:
        n = len(grid)
        m = len(grid[0])
        max_area = 0
        directions = [(-1,0), (1,0), (0,-1), (0,1)]
        for i in range(n):
            for j in range(m):
                if grid[i][j] == 1:
                    area = 0
                    queue = [(i,j)]
                    while queue != []:
                        x, y = queue.pop()
                        if grid[x][y] == 0:
                            continue
                        grid[x][y] = 0
                        area += 1
                        for direction in directions:
                            new_x = x + direction[0]
                            new_y = y + direction[1]
                            if 0 <= new_x < n and 0<= new_y < m and grid[new_x][new_y] == 1:
                                queue.append((new_x, new_y))
                    max_area = max(max_area, area)
                    
        return max_area
                    
        
```

### No. 413

Solution 1: Mathemtical

Calculate the consecutive difference in list `A`, then statistics the  consecutive number in list `A`. If we find a consecutive same number sub-array `B`, then add it to our result.
$$
\Large \frac{(\text{fisrt val + last val})\times\text{length of sub array}}{2}
$$

```
class Solution:
    def numberOfArithmeticSlices(self, nums: List[int]) -> int:
        if len(nums) < 3:
            return 0
        condiff = [0 for _ in range(len(nums))]
        condiff[-1] = 123456789
        for i in range(len(nums) -1):
            condiff[i] = nums[i+1] - nums[i]

        curVal = 114514
        counter = 1
        res = 0
        for i in range(len(nums)):
            if curVal != condiff[i]:
                if counter >= 2:
                    res += counter * (counter-1)//2
                counter = 1
                curVal = condiff[i]
            else:
                counter += 1
        return res
        
```

Solution 2: standard DP

```
class Solution:
    def numberOfArithmeticSlices(self, nums: List[int]) -> int:
        if len(nums) < 3:
            return 0
        dp = [0 for i in range(len(nums))]
        curVal = nums[1] - nums[0]
        counter = 1
        for i in range(2, len(nums)):
            curDiff = nums[i] - nums[i - 1]
            if curVal == curDiff:
                counter += 1
                dp[i] = dp[i - 1]
            else:
                dp[i-1] = dp[i - 2] + (counter - 1) * counter // 2
                dp[i] = dp[i-1]
                curVal = curDiff
                counter = 1
        if counter != 0:
            dp[-1] = dp[-2] + (counter - 1) * counter // 2
        return dp[-1]
```

Solution 3: work space compression DP 

```
class Solution:
    def numberOfArithmeticSlices(self, nums: List[int]) -> int:
        if len(nums) < 3:
            return 0
        dp = 0
        curVal = nums[1] - nums[0]
        counter = 1
        for i in range(2, len(nums)):
            curDiff = nums[i] - nums[i-1]
            if curVal == curDiff:
                counter += 1
            else:
                dp += (counter - 1) * counter //2
                curVal = curDiff
                counter = 1
        if counter != 0:
            dp += (counter - 1) * counter // 2
        return dp
```



### No. 91

Solution 1: DP

special case is `0`

if current char is `0`, we need consider the front char. 

1. If the front number is greater than `2` or equal to `0`, there are no valid decoding method
2. If the front  number is not less or equal than `0` but greater than `0`, we have one decoding way.

```
class Solution:
    def numDecodings(self, s: str) -> int:
        if s[0] == "0":
            return 0
        dp = [0 for _ in range(len(s) + 1)]
        dp[0] = 1
        dp[1] = 1
        A = set([str(i) for i in range(3,10)])
        for i in range(1, len(s)):
            if s[i-1] != "0":
                if s[i] == "0":
                    if s[i-1] in A:
                        return 0
                    else:
                        dp[i+1] = dp[i-1]
                elif 0 < int(s[i-1:i+1]) <= 26:
                    dp[i+1] = dp[i] + dp[i-1]
                else:
                    dp[i+1] = dp[i]
            else:
                if int(s[i-1:i+1]) == 0:
                    return 0
                else:
                    dp[i+1] = dp[i]
                
        return dp[-1]
```



### No. 300

Solution: Brute force DP

```
class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        dp = [1 for _ in range(len(nums))]
        maximum = 1
        for i in range(1, len(nums)):
            for j in range(i):
                if nums[i] > nums[j]:
                    dp[i] = max(dp[i], dp[j] + 1)
                    maximum = max(maximum, dp[i])
        return maximum
        
        
```









































