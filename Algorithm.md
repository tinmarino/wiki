

### Sorting

    
#### Comparaison

| Algorithm      | Best-case  | Worst-case | Average-case | Space            | Stable? |
| ---            | ---        | ---        | ---          | ---              | --- |
| Merge Sort     | O(n log n) | O(n log n) | O(n log n)   | O(n)             | Yes |
| Insertion Sort | O(n)       | O(n2)      | O(n2)        | O(1)             | Yes |
| Bubble Sort    | O(n)       | O(n2)      | O(n2)        | O (1)            | Yes |
| Quicksort      | O(n log n) | O(n2)      | O(n log n)   | log n best n avg | Usually not |
| Heapsort       | O(n log n) | O(n log n) | O(n log n )  [|](|) O(1)             | No |
| Counting Sort  | O(k+n)     | O(k+n)     | O(k+n)       | O(k+n)           | Yes |

#### Merge sort

* Merge pre sorted

Mergesort is a comparison-based algorithm that focuses on how to merge together two pre-sorted arrays such that the resulting array is also sorted. 

#### Bubble Sort

* Swap pairs
* $O(n^2)$ worst, $0(n)$ best, $0(1)$ space 

Bubble sort is a comparison​-based algorithm that compares each pair of elements in an array and swaps them if they are out of order until the entire array is sorted. For each element in the list, the algorithm compares every pair of elements. 

### Quick Sort

* Divide and conquer

Quicksort is a comparison-based algorithm that uses divide-and-conquer to sort an array. The algorithm picks a pivot element, A[q]A[q]A[q], and then rearranges the array into two subarrays A[p…q−1]A[p \dots q-1]A[p…q−1], such that all elements are less than A[q]A[q]A[q], and A[q+1…r]A[q+1 \dots r]A[q+1…r], such that all elements are greater than or equal to A[q]A[q]A[q]. 

* Selection Sort.
* Merge Sort.
* Insertion Sort.
* Heap Sort.

#### Heap sort

* Binary tree

Heapsort is a comparison-based algorithm that uses a binary heap data structure to sort elements. It divides its input into a sorted and an unsorted region, and it iteratively shrinks the unsorted region by extracting the largest element and moving that to the sorted region. 

#### Integer sort linear time

O(n), or linear, sorting algorithms for lists of integers, such as radix, bucket and counting sorts, which may be suitable depending on the nature of the integers in your lists.

#### Link

[[https://brilliant.org/wiki/sorting-algorithms/]]
[[https://docs.python.org/3.7/howto/sorting.html]]
