
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
