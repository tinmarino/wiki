### Tips

* `cur = curs.pop(0)` to remove first. Wanring not cur.pop()
* In loops, you will fail at first try -> print
* Don't hesitate to comment, especially math
* Represent the cas of arry and not the bound : arr[0] is first case not first frontier
* `UNIQUE` <- grep this keyword, then pre-uniquify anything: can fasten a lot combinatory
* `42.2 // 2` <- `int(42.2/2)` or `math.floor(42.2/2)` but the result is float
* Do not dickotomize by hand !!! Use bisect

#### Memoize function return value (cache)
```python
@functools.lru_cache(maxsize=100, typed=False)
```

#### Increase recursion depth
```python
print(sys.getrecursionlimit())  # gives me 1000
sys.setrecursionlimit(3000) 
```

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




## Some HackerRank solutions

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

1. del

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
