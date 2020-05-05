---
title: Python HackerRank tips
category: Python
wiki_css: Css/color_dark_solarized.css, Css/layout_toc.css
header-includes: <script type="text/javascript" src="Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

# Contents

    - [Tips](#Tips)
      - [Memoize function return value (cache)](#Tips#Memoize function return value (cache))
      - [Increase recursion depth](#Tips#Increase recursion depth)
  - [Classes tips](#Classes tips)
    - [String](#Classes tips#String)
    - [List](#Classes tips#List)
    - [Dictionary](#Classes tips#Dictionary)
    - [Golf](#Classes tips#Golf)
    - [StdIn / StdOut](#Classes tips#StdIn / StdOut)
    - [Sorting](#Classes tips#Sorting)
    - [Idioms](#Classes tips#Idioms)
  - [Some HackerRank solutions](#Some HackerRank solutions)
    - [Rotate left list](#Some HackerRank solutions#Rotate left list)
    - [Count triplet](#Some HackerRank solutions#Count triplet)
    - [Solution: Reverse Shuffle Merge](#Some HackerRank solutions#Solution: Reverse Shuffle Merge)
    - [Fraudulent Activity Notifications](#Some HackerRank solutions#Fraudulent Activity Notifications)
    - [Sherlock and Anagrams](#Some HackerRank solutions#Sherlock and Anagrams)
    - [String: Sub count](#Some HackerRank solutions#String: Sub count)
      - [1 My solution with too many if](#Some HackerRank solutions#String: Sub count#1 My solution with too many if)
      - [2 Can be replaced with regex !!](#Some HackerRank solutions#String: Sub count#2 Can be replaced with regex !!)
      - [3 Can mutualize some if](#Some HackerRank solutions#String: Sub count#3 Can mutualize some if)
    - [String: Longest Common substring problem](#Some HackerRank solutions#String: Longest Common substring problem)
    - [Tree: Swap Node](#Some HackerRank solutions#Tree: Swap Node)
    - [Array : max sum in subarray (Max Array Sum)](#Some HackerRank solutions#Array : max sum in subarray (Max Array Sum))
    - [Pairs (of equal difference)](#Some HackerRank solutions#Pairs (of equal difference))
    - [Triple sum (find unique)](#Some HackerRank solutions#Triple sum (find unique))
    - [Minimum Time Required](#Some HackerRank solutions#Minimum Time Required)
    - [Balanced parenthesis (Stack of course)](#Some HackerRank solutions#Balanced parenthesis (Stack of course))
    - [Maze: Castle on the Grid](#Some HackerRank solutions#Maze: Castle on the Grid)
    - [Array Largest rectangle](#Some HackerRank solutions#Array Largest rectangle)
    - [Recursion: Davis' Staircase](#Some HackerRank solutions#Recursion: Davis' Staircase)
    - [Binary Tree: Height](#Some HackerRank solutions#Binary Tree: Height)
    - [Binary Tree: Lowest Common Ancestor](#Some HackerRank solutions#Binary Tree: Lowest Common Ancestor)
    - [Trees: Is This a Binary Search Tree?](#Some HackerRank solutions#Trees: Is This a Binary Search Tree?)
    - [Tree: Huffman Decoding](#Some HackerRank solutions#Tree: Huffman Decoding)
    - [Dynamic Programming: Abbreviation](#Some HackerRank solutions#Dynamic Programming: Abbreviation)
    - [Dynamic programming: candies](#Some HackerRank solutions#Dynamic programming: candies)
    - [Find A Sub-Word (Regex list)](#Some HackerRank solutions#Find A Sub-Word (Regex list))
    - [Regex: Alien Username](#Some HackerRank solutions#Regex: Alien Username)

<section class="level2">


### Tips

* Dynamic programming is like fire propagation. The dp array is keeping the position of the fire
* `cur = curs.pop(0)` to remove first. Wanring not cur.pop()
* In loops, you will fail at first try -> print
* Don't hesitate to comment, especially math
* Represent the case of array and not the bound : arr[0] is first case not first frontier
* `UNIQUE` <- grep this keyword, then pre-uniquify anything: can fasten a lot combinatory
* `42.2 // 2` -> `int(42.2/2)` or `math.floor(42.2/2)` but the result is float
* Do not dickotomize by hand: use bisect
* Use differential or integral of an array can sometime helps
  * differential can be used to work on range input
  * integral can be used to find the max of subarray % some_integer, there they are called array prefix and sum(arr[i..j]) = prefix(j) - prefix(i) which can be sorted


#### Memoize function return value (cache)

* lru_cache <- Least Recently Used

```python
@functools.lru_cache(maxsize=100, typed=False)
@functools.lru_cache(maxsize=None)
```

```python
# Fibonacci numbers
@lru_cache(maxsize=None)
def fib(n):
    if n < 2:
        return n
    return fib(n-1) + fib(n-2)

>>> print([fib(n) for n in range(16)])
[0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]

>>> print(fib.cache_info())
CacheInfo(hits=28, misses=16, maxsize=None, currsize=16)
```

#### Increase recursion depth
```python
print(sys.getrecursionlimit())  # gives me 1000
sys.setrecursionlimit(3000) 
```

</section>

## Classes tips

<section class="level2">

### String

* __repr__:
  * __repr__ goal is to be unambiguous
  * __str__ goal is to be readable
  * Container’s __str__ uses contained objects’ __repr__

```python
# Reverse string
"Hello World"[::-1]

# Find last char 
"Hello".rfind('l')

# Get alphbet
from string import ascii_lowercase

# Find all index match
s = "ababdfegtduab"
[m.start() for m in re.finditer(r"ab",s)]  # -> [0, 2, 11]

```

### List

* deque is short for Double Ended Queue

```python
# Find last elt of list
li = ["a", "b", "a", "c", "x", "d", "a", "6"]
''.join(li).rindex('a')
len(li) - 1 - li[::-1].index('a')

# Find index
# # All of whatever condition
indexes = [i for i,x in enumerate(xs) if x == 'foo']
# # First (surround with try catch)
["foo", "bar", "baz"].index("bar")

# Contains only hi
all(elem == "hi" for elem in bag)

# Equality
import collections
collections.Counter(x) == collections.Counter(y)
# # or
sorted(x) == sorted(y)
# # or if unique
set(x) == set(y)

# Reverse
reversed([1, 2, 3])

# append multiple items
l = [1, 2, 3]
l.extends([4, 5, 6])
# " Better
l += [4, 5, 6]

# Enumerate, very usefull

# Set
# # intersection
z = x.intersection(y) 

# Copy nested list (2 dimension)
y = [row[:] for row in x]

```


### Dictionary

```python
# Add 2 dict
dic3 = {**dic1, **dic2}
z = x.copy()   # start with x's keys and values
z.update(y)    # modifies z with y's keys and values & returns None

# Auto vivication
from collections import defaultdict
d = defaultdict(int)
d[3] += 1  # -> defaultdict(int, {3: 1})
```

### Golf

```python
for i in [1,2,3]:
    print(i)
    if i==3:
        break
else:
    print("for loop was not broken")
```
### StdIn / StdOut

```python
fptr = open(os.environ['OUTPUT_PATH'], 'w')

n = int(input())

s = input()

result = substrCount(n, s)

fptr.write(str(result) + '\n')

fptr.close()
```

Or more complex

```python
fptr = open(os.environ['OUTPUT_PATH'], 'w')

q = int(input().strip())

queries = []

for _ in range(q):
    queries.append(list(map(int, input().rstrip().split())))

ans = freqQuery(queries)

fptr.write('\n'.join(map(str, ans)))
fptr.write('\n')

fptr.close()
```



### Sorting

```python
# Eumerate function
l1 = ["eat","sleep","repeat"] 
s1 = "geek"
print list(enumerate(l1)) 
  
# changing start index to 2 from 0 
print list(enumerate(s1,2)) 

# Map lambda
new_list = map(lambda x: x%num, old_list)
new_list = [ x%num for x in old_list]

# Swap (with 'tuple-unpacking')
arr[i], arr[j] = arr[j], arr[i]

```

### Idioms

* tuple-unpacking:
```python
foo, boo, moo = boo[0], moo[0], foo[0] = moo[0], foo[0], boo[0] = [0], [0], [0]`
```

* Get from dict (of dict):
```python
value = d.get(key, {}).get(key2, "empty")
```


</section>

## Some HackerRank solutions

<section class="level2">


### Rotate left list

* Using modular arithmetic to calculate new pos

```java
for(int i = 0; i < lengthOfArray; i++){
    int newLocation = (i + (lengthOfArray - shiftAmount)) % lengthOfArray;
    a[newLocation] = in.nextInt();
}
```

* Slicing
```python
def rotLeft(a, d): return a[d:]+a[:d]
```

* Deque in python support that
```python
from collections import deque

def rotLeft(a, d):
    deq = deque(a)
    deq.rotate(-d)
    return list(deq)
```


### Count triplet

Count number of geometric progression in array [x, x*k, x*k*k]. K is given, read the rules !

```python
def countTriplets(arr, r):
    count = 0; dic1 = {}; dic2 = {}

    for i3 in range(len(arr)):
        # get
        val3 = arr[i3]
        val2 = val3 / r

        # count
        count += dic2.get(val2, 0)

        # update
        dic2[val3] = dic2.get(val3, 0) + dic1.get(val2, 0)
        dic1[val3] = dic1.get(val3, 0) + 1

    return count
```

```python
from collections import defaultdict
def countTriplets(arr, r):
    v2 = defaultdict(int)
    v3 = defaultdict(int)
    count = 0
    for k in arr:
        count += v3[k]
        v3[k*r] += v2[k]
        v2[k*r] += 1

    return count
```




### Solution: Reverse Shuffle Merge

Note : I did not manage in 3h. When tired, get really bad + no paper to note => Must concentrate

```python
def reverseShuffleMerge(s):
    # Total character counts in s
    char_count = Counter(s)
    
    # Character counts we need in our final string
    string_chars = { 
        char: int(count / 2) for char, count in char_count.items() 
    }
        
    # Character counts we need in the shuffled 
    # version of our original string 
    shuffled_chars = { 
        char: int(count / 2) for char, count in char_count.items() 
    }
    
    string = []
		
    for char in reversed(s):
        if string_chars[char] > 0:
            # See if this character should appear before any 
            # previous ones. Basically, if this char is smaller 
            # than the previous char, and the previous char 
            # still occurs in the chars of the shuffled string, 
            # we can the safely replace the previous char 
            # with this one. That's so because we should be 
            # able to still create a valid string which contains
            # both characters although the order will differs.
            while string and string[-1] > char and shuffled_chars[string[-1]] > 0:
                removed = string.pop()
                string_chars[removed] += 1
                shuffled_chars[removed] -= 1
            
            string.append(char)
            string_chars[char] -= 1
        else:
            shuffled_chars[char] -= 1

    return ''.join(string)
```

### Fraudulent Activity Notifications

Explanation of @eduasinco:

1. bisect_left:

```python
ix = bisect_left(v, de)
del v[ix]
```
you could `remove v[de]` but it would take O(n) time to find de whereas bisect_left assume a sorted list and find the index in O(log(n)).


--------

2. enumerate

gives you an index (i) used to remove the last income


--------

3. del

This is the slow version O(n): The end of the list must be copied. Here we are lucky, please explain to me !! This also work: `l_sorted.remove(index)`


---------


```python
from bisect import insort, bisect_left

def activityNotifications(expenditure, d):
    # Check in
    if len(expenditure) < d : return 0

    # Usefull var
    res = 0
    half = int(d / 2)
    is_impair = d % 2 == 0 

    # Prepare, sort
    l_sorted = sorted(expenditure[:d])

    for i, current in enumerate(expenditure[d:]):
        # Add point
        if is_impair: med2 = l_sorted[half] + l_sorted[half-1]
        else: med2 = l_sorted[half] * 2
        if current >= med2:  res += 1

        # Remove last
        last = expenditure[i]
        index = bisect_left(l_sorted, last)
        del l_sorted[index]
				
        # Add new
        insort(l_sorted, current)

    return res
```


### Sherlock and Anagrams

```python
# Complete the sherlockAndAnagrams function below.
def sherlockAndAnagrams(s):
    res = 0; i_l = len(s)

    # Loop letter number 1 .. i_l - 1
    for i_letter in range(1, i_l):
        # Loop i_c: 0 .. i_l - letter and sort i_c:i_c+letter
        a_sort1 = sorted(s[:i_letter - 1])
        for i_c in range(i_l - i_letter + 1):
            insort(a_sort1, s[i_c+i_letter-1])

            # Loop j_c: i_c+1: i_l - letter and sort j_c:j_c+letter
            blacklist = []
            a_sort2 = sorted(s[i_c+1 : i_c+1 + i_letter-1])
            for j_c in range( i_c+1, i_l -i_letter + 1):
                if j_c in blacklist: continue
                insort(a_sort2, s[j_c+i_letter-1])

                # Match
                if a_sort1 == a_sort2:
                    res += 1
                    blacklist.append(j_c)

                ix2 = bisect_left(a_sort2, s[j_c])
                del a_sort2[ix2]                

            ix1 = bisect_left(a_sort1, s[i_c])
            del a_sort1[ix1]

    return res
```
    
### String: Sub count


* Replace loop over string

```python
for i_start in range(n):
    c_start = s[i_start]
```
```python
 for i_start, c_start in enumerate(s):
```

#### 1 My solution with too many if

```python
def substrCount(n, s):
    count = n

    for i_start in range(n):
        c_start = s[i_start]

        i_middle = 0
        for i_end in range(i_start+1, n):
            if s[i_end] != c_start:
                if not i_middle:
                    i_middle = i_end
                    continue
                break

            if not i_middle:
                count += 1
                continue

            if i_end - i_middle == i_middle - i_start:
                count += 1
                break

    return count
```

#### 2 Can be replaced with regex !!

```python
count = len(s)

# With middle
exp1 = r'(([a-z])\2*)(?!\1)(?=[a-z]\1)'
m = re.finditer(exp1,s)
count += sum([len(x.group(0)) for x in m])

# Just repeated seqs
exp2 = r'([a-z])\1+'
m = re.finditer(exp2,s)
count += sum([triangular_number(len(x.group(0))-1) for x in m])

return count

def triangular_number(n):
    """Count xxxx for any submatch xx xxx x .. so 4 + 3 + 2 + 1"""
    return (pow(n,2)+n)//2
```

#### 3 Can mutualize some if

```python
def substrCount(n, s):
    tot = 0
    count_sequence = 0
    prev = ''
    for i,v in enumerate(s):
        # first increase counter for all seperate characters
        count_sequence += 1
        if i and (prev != v):
            # if this is not the first char in the string 
            # and it is not same as previous char, 
            # we should check for sequence x.x, xx.xx, xxx.xxx etc
            # and we know it cant be longer on the right side than
            # the sequence we already found on the left side.
            j = 1
            while ((i-j) >= 0) and ((i+j) < len(s)) and j <= count_sequence:
                # make sure the chars to the right and left are equal
                # to the char in the previous found squence
                if s[i-j] == prev == s[i+j]:
                    # if so increase total score and step one step further out
                    tot += 1
                    j += 1
                else:
                    # no need to loop any further if this loop did 
                    # not find an x.x  pattern
                    break
            #if the current char is different from previous, reset counter to 1
            count_sequence = 1  
        tot += count_sequence            
        prev = v
  return tot	
```


### String: Longest Common substring problem

* https://en.wikipedia.org/wiki/Longest_common_subsequence_problem
* Linked to the edit distance (you know, article with the snake path for yadiff)

```python
def commonChild(s1, s2):
    m, n = len(s1), len(s2)
    prev, cur = [0]*(n+1), [0]*(n+1)
    for i in range(1, m+1):
        for j in range(1, n+1):
            if s1[i-1] == s2[j-1]:
                cur[j] = 1 + prev[j-1]
            else:
                if cur[j-1] > prev[j]:
                    cur[j] = cur[j-1]
                else:
                    cur[j] = prev[j]
        cur, prev = prev, cur
    return prev[n]
```

### Tree: Swap Node

My solution:

```python
class Tree:
    def __init__(self, i):
        self.id = i
        self.left = None
        self.right = None
    
    @staticmethod
    def build(id, nexts):
        """Helper: create a tree and if not null append to next"""
        if id == -1: return None
        tree = Tree(id)
        nexts.append(tree)
        return Tree(id)

    def __str__(self):
        return f"Tree:{self.id}"


def traverse(tree):
    if tree is None: return []
    # Traverse the left subtree
    res = traverse(tree.left)

    # Visit root
    res.append(tree.id)

    # Traverse the right subtree
    return res + traverse(tree.right)


def swapNodes(indexes, queries):
    # Some test go far in recursion but just onces fct(fct(fct ....))
    sys.setrecursionlimit(3000) 

    # Create tree
    root = Tree(1)
    # Memoize depth
    depths = []

    # Build
    nexs = [root]; curs = []
    for left, right in indexes:
        if len(curs) == 0:
            depths.append(nexs)
            curs = nexs.copy()
            nexs = []

        cur = curs.pop(0)
        cur.left = Tree.build(left, nexs)
        cur.right = Tree.build(right, nexs)


    # Swap
    res = []
    for query in queries:
        for depth in range(query, len(depths), query):
            for tree in depths[depth - 1]:
                tree.left, tree.right = tree.right, tree.left
        res.append(traverse(root))

    return res
```


### Array : max sum in subarray (Max Array Sum)

See __Dynamic Programming:__ https://www.geeksforgeeks.org/dynamic-programming/

Max sum of non adjacent element in array

```python
def maxSubsetSum(arr):
    n = len(arr)
    dp = [0]*n
    dp[0] = arr[0]
    dp[1] = max(arr[1], dp[0])
    for i in range(2,n):
        dp[i] = max(arr[i], dp[i-1], arr[i] + dp[i-2])
    return dp[-1]
```

Intro: Since we know it's DP, we can solve the problem by solving subproblems of smaller size.

Because of the condition. No two adjacent elements can be picked. Therefore we can either take one and then skip one, or skip one and run the subroutine.

we can solve this problem in linear time and constant space ;)

Idea: store solutions for problem of size i-2 and i-1, where i is the size of the subproblem. The solution for problem of size i is either solution for problem i-1, or solution for problem i-2, or solution of problem i-2 + arr[i], or ar[i]. Iterate for every i. Start with 0, 0 for problems of size - 2 and -1

```python
def maxSubsetSum(coll):
    a,b = 0,0
    
    for val in coll:
        a,b = b, max(a, a + val, b, val) 
    
    return b
```

### Pairs (of equal difference)

* My solution

```python
def pairs(k, arr):
    res = 0
    ct = Counter(arr)
    for val1 in ct:
        # val1 - val2 = +/- k 
        res += ct[val1] * (ct[val1-k] + ct[val1+k])
    return int(res / 2)
```

* One liner !
* Had to note the constraint: each integer of arr will be unique

```python
return len(set(arr) & set([item + k for item in set(arr)])) 
```


### Triple sum (find unique)


```python
from bisect import bisect_left

def triplets(a, b, c):
    res = 0

    # Uniquely sort
    a = sorted(set(a))
    b = sorted(set(b))
    c = sorted(set(c))

    # Check if usefull to loop
    if b[-1] < a[0] or b[-1] < c[0]:
        return 0
        
    # Find possible combinations
    lowa = lowc = 0   # Fasten bisect search with low bound, known a priory
    for i in b:
        lowa = bisect_left(a, i+0.5, lo=lowa)
        lowc = bisect_left(c, i+0.5, lo=lowc)
        res += lowc * lowa

    return res
```


### Minimum Time Required

My dichotomic bad solution

```python
def in_day(n, ct):
    # in n days they build ct[val1] * int(n / val) = items
    item = 0
    for val in ct:
        if val > n : continue
        item += ct[val] * int(n/val)
    return item

# Complete the minTime function below.
def minTime(machines, goal):
    ct = Counter(machines)

    high = 999999999999999
    day = 1000
    low = 0
    n1 = -1
    while True:
        n1 = in_day(day, ct)

        print(day, high , low , n1)

        # Lucky
        if low >= high -1:
            if in_day(low, ct) >= goal:
                return low
            else:
                return high

        # May increase
        if n1 < goal:
            low, day = day, day + int(abs(day - high) / 2)
            continue

        # Now find minimum
        high, day = day, day - int(abs(day - low) / 2)
```

* Other O(log(n) x machines)
* __Note:__ Instead of doing dichotomy by hand, use bisect left with a yielder and mindays, maxDays

```python
from bisect import bisect_left
class Yeild:
    def __init__(self, machines):
        self.machines_ = machines
    def __getitem__(self, days):
        production = 0
        for d in machines:
            production += int(days/d)
        return production

def minTime(machines, goal):
    machines.sort()
    minDays = 0
    maxDays = goal * machines[0]
    days = bisect_left(Yeild(machines), goal, minDays, maxDays)
    return days
```

* With harmonic mean, what I wanted first.
* He just calculate a low bound, then add one by one: should not be so long

```python
import heapq
import statistics 
def minTime(machines, goal):
    minDays = math.ceil(goal*statistics.harmonic_mean(machines)/len(machines))
    totalManufactured = sum([minDays//x for x in machines])
    nextTimes = [(x*(minDays//x)+x,x) for x in machines]
    heapq.heapify(nextTimes)
    popped=None
    while totalManufactured<goal:
        popped= heapq.heappop(nextTimes)
        heapq.heappush(nextTimes, (popped[0]+popped[1], popped[1]))
        totalManufactured+=1
    return minDays if not popped else popped[0]
```


### Balanced parenthesis (Stack of course)

* My first

```python
def isBalanced(s):
    if len(s) == 0: return "YES"
    stack = []
    for i in s:
        if i in ('(', '[', '{'):
            stack.append(i)
            continue
        if not len(stack): return "NO"
        j = stack.pop()
        if (j,i) not in (('(', ')'), ('[', ']'), ('{', '}')):
            return "NO"

    return "YES" if len(stack) == 0 else "NO"
```

* Shorter one by someone

```python
def isBalanced(s):
    stack = []
    closer = {'{': '}', '[': ']', '(': ')'}
    for bracket in s:
        if bracket in closer:
            stack.append(bracket)
            continue
        if not stack or closer[stack.pop()] != bracket:
            return "NO"
    return "NO" if stack else "YES"
```


### Maze: Castle on the Grid

* My solution, kind of dirty: I thought you had to move until the end

```python
# Complete the minimumMoves function below.
def minimumMoves(grid, startX, startY, goalX, goalY):
    res = 1

    pos = [ [startX, startY, (0, 0)] ]

    # Create visited bool array to avoid looping
    visited = []
    for line in grid:
        visited.append([False]* len(line))
    next_pos = []

    while True:
        for x0, y0, last_move in pos:
            # Check and mark as visited
            if (x0, y0) == (goalX, goalY): return res
            if visited[x0][y0]: continue
            visited[x0][y0] = True

            # Move any number one direction ...
            for moves in ((-1, 0), (0, 1), (1, 0), (0, -1) ):
                if moves in (last_move, (-last_move[0], -last_move[1])):
                    continue
                x, y = x0, y0

                # ... any number of step
                while (0 <= x + moves[0] < len(grid)
                        and 0 <= y + moves[1] < len(grid[0])
                        and grid[x + moves[0]][y + moves[1]] != 'X'
                        ):
                    x += moves[0]
                    y += moves[1]
                    
                    # Return ?
                    if (x,y) == (goalX, goalY): return res
                
                    # Break: comming to late: my line and col is visited already
                    if visited[x][y]: break

                    # Add this point for a next walk
                    next_pos.append([x, y, moves])
            
        print(next_pos)            
        pos = next_pos
        next_pos = []
        res += 1

```



* Explore bfs-wise, and only increase the level when changing direction

```python
from collections import deque

def minimumMoves(grid, startX, startY, goalX, goalY):
    """standard bfs
    """
    start, goal = (startX, startY), (goalX, goalY)
    # special case: dtart == goal
    if start == goal: return 0
    # set-up bfs
    q = deque([(start, 0)])
    parents = {}
    moves = {'right':lambda n: (n[0], n[1]+1),
            'down':lambda n: (n[0]+1, n[1]),
            'left':lambda n: (n[0], n[1]-1),
            'up':lambda n: (n[0]-1, n[1])
            }
    def is_valid(node):
        x, y = node
        return (x < len(grid) and y < len(grid)
                and x >= 0 and y >= 0
                and grid[x][y] == '.')
    while q:
        current_node, level = q.pop()
        # match? we are done...
        if current_node == goal: return level
        # explore... bfs wise
        for move in 'up', 'right', 'down', 'left':
            next_node = moves[move](current_node)
            while is_valid(next_node):
                # no revisiting...
                if next_node not in parents:
                    q.appendleft((next_node, level+1))
                    parents[next_node] = current_node
                next_node = moves[move](next_node)
    raise ValueError('unreachable')
```


### Array Largest rectangle

* A rectangle in min(arr[i...j]) * j - i
* Solution, cut at the min, or return full size * min

```python
def largestRectangle(h):
    if(len(h)==0):return
    if(len(h)==1):
        if(h[0]>largestRectangle.max):
            largestRectangle.max=n
        return
    v=min(h)
    if(v*len(h)>largestRectangle.max):
        largestRectangle.max=len(h)*v
    largestRectangle(h[0:h.index(v)])
    largestRectangle(h[h.index(v)+1:len(h)])
    return largestRectangle.max
    
largestRectangle.max=0
```

* For each cell, extend the  left and right
* Only one cell, should be smallest and never stop

```python
def largestRectangle(h):
    
    x=[]
    for i in range(len(h)):
        l=1
        b=0
        c=h[i]
        while(i-b-1>=0 and h[i-b-1]>=c):
            b+=1
        while(i+l<len(h)and h[i+l]>c):
            l+=1
        l=l+b
        s=l*c
        x.append(s)
    return max(x)
```

* Even the n^2 works here ! Meaning my solution was even worse -> start simple

```python
def largestRectangle(h):
    sumi, maxi = 0, 0
    for i in range(len(h)):
        sumi = 0
        for j in range(i, len(h)):
            if h[j] >= h[i]:
                sumi += h[i]
            else:
                break
        for j in range(i-1, -1, -1):
            if h[j] >= h[i]:
                sumi += h[i]
            else:
                break
        maxi = max(maxi, sumi)
    return maxi
```

### Recursion: Davis' Staircase

* Close to combinations (my first solution)

```python
from math import factorial
def comb(k, n):
    return factorial(n) // factorial(k) // factorial(n-k)

# Complete the stepPerms function below.
def stepPerms(n):
    if n == 0 : return 0
    res = 0
    trees = (n // 3)
    for tree in range(trees+1):
        tree_rest = n - tree * 3
        twos = tree_rest // 2
        for two in range(twos+1):
            one = tree_rest - two * 2
            res += comb(tree, tree + two)
            
    return res % 10000000007
```

* Recursive

```python
from functools import lru_cache
@lru_cache(None)
def stepPerms(n):
    if n == 0: return 1  # NA
    if n == 1: return 1  # 1
    if n == 2: return 2  # 2 / 1,1

    # 3 / 2, .. / 1, ..
    return  stepPerms(n-3) + stepPerms(n-2) + stepPerms(n-1)
```

* Iterativ, Dynamic programming

```python
def stepPerms(n):
    dp = []
    dp.append(1)  # NA
    dp.append(1)  # 1
    dp.append(2)  # 2 / 1,1

    for i in range(3, n+1):
        dp.append(dp[i-3] + dp[i-2] + dp[i-1])
        
    return dp[n]
```

* Dynamic progaming keeping just last values (reduce space complexity)

```python
def stepPerms(n):
    dp = [1, 1, 2]  # NA, 1, 2 / 1.1

    for _ in range(3, n+1):
        new = dp[2] + dp[1] + dp[0]
        dp[0], dp[1], dp[2] = dp[1], dp[2], new
    return dp[n] if n < 3 else dp[-1]
```


### Binary Tree: Height

```python
def height(root):
    if root is None or root.left is None and root.right is None : return 0
    return 1 + max(height(root.left), height(root.right))
```


### Binary Tree: Lowest Common Ancestor

My sol

```python
sol = None
def who_in(root, v1, v2):
    """Reeturns list [], [v1, v2]"""
    global sol
    if root == None: return []

    # print('Visiting', root.info)

    res = []
    if root.info in (v1, v2):
        res.append(root.info)
    res.extend(who_in(root.left, v1, v2))
    res.extend(who_in(root.right, v1, v2))

    # print("  res", res)
    if sol is None and v1 in res and v2 in res:
        sol = root
    return res


def lca(root, v1, v2):
    who_in(root, v1, v2)
    return sol

```

Solution understanding that values are ordered (lower, highter), hence the binary search

```python
def lca(root, v1, v2):
    cur = root
    while cur:
        if v1<cur.info and v2<cur.info:
            cur = cur.left
        elif v1>cur.info and v2>cur.info:
            cur = cur.right
        elif max(v1, v2)>=cur.info and cur.info>=min(v1,v2):
            return cur
```

Problem tester code

```python
# Python 3 iterative solution
def lca(root , v1 , v2):
    # make sure v2 > v1
    if v1 > v2: v1, v2 = v2, v1
    # traverse until terminal
    while True:
        if v1 < root.info and v2 < root.info:
            root = root.left
        elif v1 > root.info and v2 > root.info:
            root = root.right
        else:
            return(root)
```

Tree class and parser (from problem itself

```python
class Node:
    def __init__(self, info): 
        self.info = info  
        self.left = None  
        self.right = None 
        self.level = None 

    def __str__(self):
        return str(self.info) 

class BinarySearchTree:
    def __init__(self): 
        self.root = None

    def create(self, val):  
        if self.root == None:
            self.root = Node(val)
        else:
            current = self.root
         
            while True:
                if val < current.info:
                    if current.left:
                        current = current.left
                    else:
                        current.left = Node(val)
                        break
                elif val > current.info:
                    if current.right:
                        current = current.right
                    else:
                        current.right = Node(val)
                        break
                else:
                    break

# Enter your code here. Read input from STDIN. Print output to STDOUT
'''
class Node:
      def __init__(self,info): 
          self.info = info  
          self.left = None  
          self.right = None 
           

       // this is a node of the tree , which contains info as data, left , right
'''

tree = BinarySearchTree()
t = int(input())

arr = list(map(int, input().split()))

for i in range(t):
    tree.create(arr[i])

v = list(map(int, input().split()))

ans = lca(tree.root, v[0], v[1])
print (ans.info)

```


### Trees: Is This a Binary Search Tree?

```python
def checkBST(root, i_left=-1, i_right=10001):
    if root is None: return True
    if root.data >= i_right or root.data <= i_left: return False
    res = checkBST(root.left, i_left, root.data)
    res &= checkBST(root.right, root.data, i_right)
    return res
```

### Tree: Huffman Decoding

My solution, note that reading a String + Visiting a tree, the recursive solution could not be the shortest: because you have to pass many variables (at least 2) and one is often unchanged, or changed together so why bother: just reloop + I know when it is finished: when the string_in is completely consumed

```python
def readChar(sub, s):
    # Finish
    if sub.data != '\0':
        return (sub.data, 0)

    # Go deeper, I know s is not null 
    sub = sub.left if s[0] == '0' else sub.right
    s_new, i_more = readChar(sub, s[1:])
    return s_new, i_more + 1
    
    
# Enter your code here. Read input from STDIN. Print output to STDOUT
def decodeHuff(root, s, p=True):
    if root is None or len(s) == 0: return ''

    # Get char and res
    res, i_more = readChar(root, s)
    res += decodeHuff(root, s[i_more:], p=False)

    # Print is called by the test program
    if p: print(res)
    return res
```

Keep reading

```java
void decode(String S, Node root)
{
    StringBuilder sb = new StringBuilder();
    Node c = root;
    for (int i = 0; i < S.length(); i++) {
        c = S.charAt(i) == '1' ? c.right : c.left;
        if (c.left == null && c.right == null) {
            sb.append(c.data);
            c = root;
        }
    }
    System.out.print(sb);
}
```

Or in python, a simple, visiting loop, restoring root when getting a char

```python
def decodeHuff(root, s):
    ans=''
    curr=root
    for i in range(0,len(s)):
        if(s[i]=='0'):
            curr=curr.left
        else:
            curr=curr.right
        if(curr.left== None and curr.right== None):
            ans=ans+curr.data
            curr=root
    print(ans)
```

Solution from Team

```cpp
void decode_huff(node * root,string s)
{
    string ans="";
    node *curr=root;
    for(int i=0;i<s.size();i++){
        if(s[i]=='0') curr = curr->left;
        else curr = curr->right;
        if(!curr->left and !curr->right){ //reached leaf node
            ans=ans + curr->data;
            curr=root;
        }
    }
    cout<<ans<<endl;
}
```


### Dynamic Programming: Abbreviation

My timeout

```python
sys.setrecursionlimit(5000)
@lru_cache(None)
def abbreviation_wrap(a, b):
    if len(a) == 0: return len(b) == 0
    if len(b) == 0: return a.islower()

    if a[0] == b[0]:
        return abbreviation_wrap(a[1:], b[1:])

    if not a[0].islower():
        return False

    # Capitalize
    res = a[0].capitalize() == b[0] and abbreviation_wrap(a[1:], b[1:])
    res |= abbreviation_wrap(a[1:], b)
    return res
```

This works

```python
def abbreviation(a, b):
    m, n = len(a), len(b)
    dp = [[False]*(m+1) for _ in range(n+1)]
    dp[0][0] = True
    for i in range(n+1):
        for j in range(1,m+1):
            if a[j-1] == b[i-1]:
                dp[i][j] = dp[i-1][j-1]
            elif a[j-1].upper() == b[i-1]:
                dp[i][j] = dp[i-1][j-1] or dp[i][j-1]
            elif a[j-1].islower():
                dp[i][j] = dp[i][j-1]   
    return "YES" if dp[n][m] else "NO"
```


### Dynamic programming: candies

* My first working shot

```python
def candies(n, arr):
    if len(arr) < 2: return len(arr)
    res = [1] * n

    for i in range(len(arr)):
        # If in valley
        if ((i <= 0 or arr[i] <= arr[i-1]) 
                and (i >= len(arr)-1 or arr[i] <= arr[i+1])):
            print("In valley", i)
            # up
            j = i
            while j < len(arr)-1 and arr[j+1] > arr[j]:
                res[j+1] = max(res[j+1], res[j] + 1)
                j += 1

            # down
            j = i
            while j > 0 and arr[j-1] > arr[j]:
                res[j-1] = max(res[j-1], res[j] + 1)
                j -= 1

    print(res)        
    return sum(res)
```

* Mutualize fire up and fire down
* Remove anti-pattern

```python
def candies(n, arr):
    if len(arr) < 2: return len(arr)
    # Minimum 1 candy for each
    res = [1] * n

    for i in range(len(arr)):
        # Do Not work out of  valley
        in_valley = ((i <= 0 or arr[i] <= arr[i-1]) 
            and (i >= len(arr)-1 or arr[i] <= arr[i+1]))
        if not in_valley: continue

        # Fire
        for sens, bound in ((1, len(arr) - 1), (-1, 0)):
            for j in range(i, bound, sens):
                if arr[j+sens] <= arr[j]: break
                res[j+sens] = max(res[j+sens], res[j] + 1)
                
    # Return total number of cadies
    return sum(res)
```

* Without dp: burn left then burn right. take advantage of 1 d propagation that is linear

```python
def candies(n, arr):
    """naive approach
    """
    candies = [1] * len(arr)
    # left -> right
    for i in range(len(arr)-1):
        if arr[i] < arr[i+1]:
            candies[i+1] = max(candies[i+1], candies[i] + 1)
    # right -> left
    for i in reversed(range(1, len(arr))):
        if arr[i] < arr[i-1]:
            candies[i-1] = max(candies[i-1], candies[i] + 1)
    return sum(candies)
```

Some definitions:

```text
  /           \         /\
 /   RISE      \ FALL  /  \  PEAK   \  /   VALLEY
/               \                    \/
```


### Find A Sub-Word (Regex list)

```python
# Enter your code here. Read input from STDIN. Print output to STDOUT
import os
import re

def work(ss, sq):
    res = []
    for query in sq:
        w = r'[0-9a-zA-Z_]+'
        query = r'\b' + w + query + w + r'\b'
        print(query, ss, re.findall(query, ss[0]))

        # lambda x: 
        num = sum(list(map(lambda x: len((re.findall(query, x))),  ss)))
        res.append(num)
    return res


fptr = open(os.environ['OUTPUT_PATH'], 'w')
s = int(input().strip())
strings = []
for _ in range(s):
    strings.append(input())
q = int(input().strip())
queries = []
for _ in range(q):
    queries.append(input())

ans = work(strings, queries)

fptr.write('\n'.join(map(str, ans)))
fptr.write('\n')
```

* Minimized

```python
#!/usr/bin/env python3

import re

n = int(input())
text = "\n".join(input() for _ in range(n))
t = int(input())
for _ in range(t):
    print(len(re.findall(r'\w%s\w' % input().strip(), text)))
```

### Regex: Alien Username

```python
import re

r_user = r'^[_.][0-9]+[a-zA-Z]*_?$'
n = int(input())
for _ in range(n):
    print('VALID' if re.match(r_user, input()) else 'INVALID')
```


</section>
