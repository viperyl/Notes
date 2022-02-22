### No.169

Solution 1: Moore voting

```
class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        mostCount = 1
        for i in range(1, len(nums)):
            if nums[i] == nums[0]:
                mostCount += 1
            else:
                mostCount -= 1
                if mostCount == 0:
                    nums[0] = nums[i]
                    mostCount += 1
        return nums[0]

        
```

### No. 116

Solution 1: BFS modified

```
class Solution:
    def connect(self, root: 'Optional[Node]') -> 'Optional[Node]':
        if root == None:
            return root
        curLayer = [root]
        root.next = None
        while curLayer != []:
            nextLayer = []
            for item in curLayer:
                if item.left:
                    nextLayer.append(item.left)
                if item.right:
                    nextLayer.append(item.right)
            if nextLayer == []:
                break
            curNode = nextLayer[0]
            for i in range(1, len(nextLayer)):
                curNode.next = nextLayer[i]
                curNode = nextLayer[i]
            curNode.next = None
            curLayer = nextLayer
            nextLayer = []
        return root
```



### No. 117

Solution 1: Same as `No.116`, BFS with modified 

```
class Solution:
    def connect(self, root: 'Optional[Node]') -> 'Optional[Node]':
        if root == None:
            return root
        curLayer = [root]
        root.next = None
        while curLayer != []:
            nextLayer = []
            for item in curLayer:
                if item.left:
                    nextLayer.append(item.left)
                if item.right:
                    nextLayer.append(item.right)
            if nextLayer == []:
                break
            curNode = nextLayer[0]
            for i in range(1, len(nextLayer)):
                curNode.next = nextLayer[i]
                curNode = nextLayer[i]
            curNode.next = None
            curLayer = nextLayer
            nextLayer = []
        return root
```



### No. 876

Solution 1: Two pointer

```
class Solution:
    def middleNode(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if head == None or head.next == None:
            return head
        p1, p2 = head, head
        tag = True
        while tag:
            for i in range(2):
                if p2.next != None:
                    p2 = p2.next
                else:
                    tag = False
                    break
            p1 = p1.next
            if p2.next == None:
                break
        return p1
```





### No. 237

Solution 1: Stupid question

```
class Solution:
    def deleteNode(self, node):
        """
        :type node: ListNode
        :rtype: void Do not return anything, modify node in-place instead.
        """
        while True:
            node.val = node.next.val
            if node.next.next == None:
                break
            node = node.next
        node.next = None
```





### No. 707

Solution 1: Based on the python build-in list

```
class MyLinkedList:
    def __init__(self):
        self.length = 0
        self.data = []

    def get(self, index: int) -> int:
        if 0 <= index < self.length:
            return self.data[index]
        else:
            return -1
        

    def addAtHead(self, val: int) -> None:
        self.data = [val] + self.data
        self.length += 1
        

    def addAtTail(self, val: int) -> None:
        self.data.append(val)
        self.length += 1
        

    def addAtIndex(self, index: int, val: int) -> None:
        if 0<= index < self.length:
            self.data.insert(index, val)
            self.length += 1
        elif index == self.length:
            self.addAtTail(val)
        

    def deleteAtIndex(self, index: int) -> None:
        if 0 <= index < self.length:
            del self.data[index]
            self.length -= 1
```



### No. 1721

Solution 1: two pointers

```
class Solution:
    def swapNodes(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        p1, p2 = head,  head
        length = 1
        while p1.next != None:
            p1 = p1.next
            length  += 1
        p1 = head
        counter = 1
        minimum, maximum = min(k, length - k +1), max(k, length - k +1)
        while counter != minimum:
            p1 = p1.next
            counter += 1
        p2 = p1
        while counter != maximum:
            p2 = p2.next
            counter += 1
        p1.val, p2.val = p2.val, p1.val
        return head
```

### No. 2095

Solution 1: Triple pointer, find the mid point, find the point before the mid point.

```
class Solution:
    def deleteMiddle(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if head.next == None:
            return None
        p1, p2, p3 = head, head, None
        tag = True
        while tag:
            for i in range(2):
                if p2.next.next != None:
                    p2 = p2.next
                else:
                    tag = False
                    break
            p3 = p1
            p1 = p1.next
            if tag == False:
                break
        p3.next = p1.next
        return head
            
```



### No. 338

Solution 1: odd number `i` is same as `i-1`. even number `i` is same as `i//2`  

```
class Solution:
    def countBits(self, n: int) -> List[int]:
        dp = [0 for _ in range(n +1)]
        for i in range(1, n+1):
            if i % 2 == 0:
                dp[i] = dp[i//2]
            else:
                dp[i] = dp[i-1] + 1
        return dp
                
        
```

### No. 746

Solution 1: DP

```
class Solution:
    def minCostClimbingStairs(self, cost: List[int]) -> int:
        dp = [0 for _ in range(len(cost)+2)]
        dp[0] = 0
        dp[1] = 0
        dp[2] = 0
        for  i in range(3, len(cost)+2):
            dp[i] = min(dp[i-1] + cost[i-2], dp[i-2] + cost[i-3])

        return dp[-1]
        
```



### No. 392

Solution 1: No need DP, string match

```
class Solution:
    def isSubsequence(self, s: str, t: str) -> bool:
        if s == "":
            return True
        if len(s) > len(t):
            return False
        p1 = 0
        for i in range(len(t)):
            if t[i] == s[p1]:
                p1 += 1
                if p1 == len(s):
                    return True
        return False
        
```

### No. 119

Solution 1: DP

```
class Solution:
    def getRow(self, rowIndex: int) -> List[int]:
        if rowIndex <= 1:
            return [1] * (rowIndex + 1)
        dp = [[0 for _ in range(rowIndex + 1)] for _ in range(2)]
        dp[1][0] = 1
        dp[1][1] = 1
        for i in range(2, rowIndex+1):
            dp[i%2][0] = 1
            dp[i%2][i] = 1
            for j in range(1, i):
                dp[i%2][j] = dp[(i-1)%2][j-1] + dp[(i-1)%2][j]
        return dp[rowIndex%2]
```































