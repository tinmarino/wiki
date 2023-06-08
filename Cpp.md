[Cpp Hackerrank](Cpp-Hackerrank.md)
[Cpp Header](Cpp-Header.md)


# Notes

* unordered_map to get HashDictionary with O(1)
* map is a binary search tree, so search in O(log(n))

# Template

```cpp
template <class T> T f(T t);// Overload f for all types

template <class T, class U=T, int n=0>
class X {// Class with type parameter T
  X(T t);
};        

X<int, int, 0> x(3);
```
