# Algorithm, data structure and languages

Basically theorical computing

# Graph algo

#### Dijkstra's algorithm: O(|E|+|V|log|V|)

Find shortest path by visiting neighbourg iteratively

1. Initialize all vertices with an infinite distance value, except for the starting vertex, which is assigned a distance of 0. We also create a set of unvisited vertices.
2. While there are unvisited vertices, select the vertex with the smallest distance from the starting vertex. This vertex is now considered visited.
3. For each unvisited neighbor of the current vertex, calculate the tentative distance to the neighbor by adding the weight of the edge between the current vertex and the neighbor to the distance of the current vertex. If this tentative distance is less than the current distance of the neighbor, update the neighbor's distance value to the tentative distance.
4. Repeat steps 2 and 3 until all vertices have been visited.

#### Bellman-Ford algorithm: O(|V|*|E|)

Shortest path from a vertex

Therefore, the Bellman-Ford algorithm is usually used when negative weights exist in the graph, and Dijkstra's algorithm is used when all the weights are non-negative.

1. Initialize all vertices with an infinite distance value, except for the starting vertex, which is assigned a distance of 0.
2. Relax all the edges in the graph (in any order) |V|-1 times, where |V| is the number of vertices in the graph. During each iteration, for each edge (u, v) in the graph, if the distance of the source vertex u plus the weight of the edge is less than the distance of the target vertex v, update the distance of vertex v to the new shorter distance.
3. After the |V|-1 iterations, check for any negative-weight cycles in the graph. To check for a negative-weight cycle, we can perform one more iteration of relaxation. If any distance value is updated during this iteration, then the graph contains a negative-weight cycle.

#### Floyd-Warshall algorithm: O(|V|^3)

Shortest path from a vertex

It works by building a matrix of the shortest path distances between every pair of vertices in the graph.

In addition to the distance matrix, the Floyd-Warshall algorithm can also construct a matrix P that stores the intermediate vertices along the shortest paths. This matrix can be used to reconstruct the actual paths between any pair of vertices.


#### Topological Sort: O(|V| + |E|)

Output: a linear ordering of its vertices such that if there is an edge from vertex u to vertex v, then u comes before v in the ordering.

Topological sort is an algorithm for ordering the vertices in a directed acyclic graph (DAG) such that every edge goes from a vertex earlier in the order to a vertex later in the order.

Algo: just walk down the stream!

1. First, select any vertex in the graph that has no incoming edges, and add it to the output list.
2. Next, remove the selected vertex and all its outgoing edges from the graph.
3. Repeat steps 1 and 2 until all the vertices have been added to the output list.


#### Minimum Spanning Tree (MST): O(E log E)

MST is an algorithm for finding the minimum-weighted tree that spans all the vertices in a connected, undirected graph.

Kruskal's algorithm builds up the minimum spanning tree by iteratively adding edges to the tree in order of increasing weight, as long as the edge being added does not create a cycle.

The time complexity of Kruskal's algorithm is O(E log E), where E is the number of edges in the graph. This is because the algorithm involves sorting the edges by weight, which takes O(E log E) time, and then iterating through the edges and checking whether they create a cycle, which takes O(E log* V) time using a disjoint-set data structure (where V is the number of vertices in the graph). Since E is typically proportional to V2 in dense graphs, the overall time complexity of the algorithm is O(V2 log V).

#### Maximum Flow

Maximum flow is an algorithm for finding the maximum flow that can be sent through a network of edges and vertices.

The algorithm works by finding the maximum amount of flow that can be sent from a source node to a sink node through a network of interconnected nodes and edges.

# Sorting

    
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

#### Quick Sort

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

# Object Oriented Design

1. Agents and Community:
  * Agent: Every object in the community acts as an agent (i.e.) from the above example, we can say that Geek, Google, and the other extra objects are known to be agents. Every agent performs some actions and those actions are being utilized by other members of the community to solve the problem.
  * Community: It is created by actions. In the above example, we can say that the search engine community has been formed.
2. Messages and Methods:
  * Messages: Every message may be a request or response that is being passed to other members of the community.
  * Methods Every method is used to perform an action in the community, that action will be used by other members of the community to solve various problems.
3. Responsibilities: From the above example, we can observe that once the Geek passes a request to Google, it will accept the request and it performs various actions to give him the desired result. It means if the request accepted by an agent, it is the responsibility of the agent to carry out the request until the problem is solved.


# Object Oriented programming

The main aim of OOP is to bind together the data and the functions that operate on them so that no other part of the code can access this data except that function

### Abstraction

Abstraction in general means hiding. Asked to fly but client do not care how you fly.

Abstraction is the methodology of hiding the implementation details from the user and only providing the functionality to the users. 

In Java, the abstraction is implemented through the use of interface and abstract classes. We can achieve complete abstraction with the use of Interface whereas a partial or a complete abstraction can be achieved with the use of abstract classes

1. It reduces the complexity of viewing things.
2. Avoids code duplication and increases reusability.
3. Helps to increase security of an application or program as only important details are provided to the user.

### Encapsulation => Getter and Setter

Encapsulation in Java is a mechanism of wrapping up the data and code together as a single unit.

The idea is to simply enclose the initialization and retrieval of the attributes in a method instead of directly referring the attribute directly. This also gives an advantage because the setters give us complete control in setting the value to the attribute and help us to restrict the unnecessary changes

### Inheritance => Extends

Inheritance is a process where one class acquires the properties of another.

Inheritance means creating new classes based on existing ones. A class that inherits from another class can reuse the methods and fields of that class. In addition, you can add new fields and methods to your current class as well.

### Polymorphism

Polymorphism is the ability of a variable, function or object to take multiple forms.

There are two types of polymorphism:

    Compile Time Polymorphism: It is also known as static polymorphism. This type of polymorphism is achieved by function overloading or operator overloading. It occurs when we define multiple methods with different signatures and the compiler knows which method needs to be executed based on the method signatures.
    Run Time Polymorphism: It is also known as Dynamic Method Dispatch. It is a process in which a function call to the overridden method is resolved at Runtime. This type of polymorphism is achieved by Method Overriding. When the same method with the same parameters is overridden with different contexts, the compiler doesn’t have any idea that the method is overridden. It simply checks if the method exists and during the runtime, it executes the functions which have been overridden.

### Virtual methods

A virtual method is a method defined on a class which is designed to be overridden by subclasses. Virtual methods allow a program to call methods that may not exist at the moment the code is compiled by employing dynamic dispatch to determine what concrete method to invoke at runtime. 


### Aggregation vs Composition 

1. Dependency: Aggregation implies a relationship where the child can exist independently of the parent. For example, Bank and Employee, delete the Bank and the Employee still exist. whereas Composition implies a relationship where the child cannot exist independent of the parent. Example: Human and heart, heart don’t exist separate to a Human

2. Type of Relationship: Aggregation relation is “has-a” and composition is “part-of” relation.

3. Type of association: Composition is a strong Association whereas Aggregation is a weak Association.


### Abstract and final

In java, you will never see a class or method declared with both final and abstract keywords. For classes, final is used to prevent inheritance whereas abstract classes depends upon their child classes for complete implementation. In cases of methods, final is used to prevent overriding whereas abstract methods needs to be overridden in sub-classes.

If a class contains at least one abstract method then compulsory should declare a class as abstract 
If the Child class is unable to provide implementation to all abstract methods of the Parent class then we should declare that Child class as abstract so that the next level Child class should provide implementation to the remaining abstract method

In Java, the abstract keyword is used to define abstract classes and methods. Here are some of its key characteristics:

    Abstract classes cannot be instantiated: An abstract class is a class that cannot be instantiated directly. Instead, it is meant to be extended by other classes, which can provide concrete implementations of its abstract methods.
    Abstract methods do not have a body: An abstract method is a method that does not have an implementation. It is declared using the abstract keyword and ends with a semicolon instead of a method body. Subclasses of an abstract class must provide a concrete implementation of all abstract methods defined in the parent class.
    Abstract classes can have both abstract and concrete methods: Abstract classes can contain both abstract and concrete methods. Concrete methods are implemented in the abstract class itself and can be used by both the abstract class and its subclasses.
    Abstract classes can have constructors: Abstract classes can have constructors, which are used to initialize instance variables and perform other initialization tasks. However, because abstract classes cannot be instantiated directly, their constructors are typically called by constructors in concrete subclasses.
    Abstract classes can contain instance variables: Abstract classes can contain instance variables, which can be used by both the abstract class and its subclasses. Subclasses can access these variables directly, just like any other instance variables.
    Abstract classes can implement interfaces: Abstract classes can implement interfaces, which define a set of methods that must be implemented by any class that implements the interface. In this case, the abstract class must provide concrete implementations of all methods defined in the interface.

Overall, the abstract keyword is a powerful tool for defining abstract classes and methods in Java. By declaring a class or method as abstract, developers can provide a structure for subclassing and ensure that certain methods are implemented in a consistent way across all subclasses.

# Data structures top 100

Here are 100 common data structures:

1. Array
2. Linked List
3. Stack
4. Queue
5. Tree
6. Binary Search Tree
7. Heap
8. Hash Table
9. Trie
10. Graph
11. Adjacency List
12. Adjacency Matrix
13. Set
14. Map
15. Red-Black Tree
16. AVL Tree
17. B-Tree
18. B+ Tree
19. Skip List
20. Bloom Filter
21. Segment Tree
22. Fenwick Tree
23. Disjoint Set Union
24. Suffix Tree
25. Suffix Array
26. Cartesian Tree
27. K-D Tree: for k dimensional tree, spliting the space dichotomically at each layer
28. Quadtree
29. Octree
30. Interval Tree
31. Treap
32. Rope
33. Circular Buffer
34. Priority Queue
35. Double Ended Priority Queue
36. Deque
37. Circular Queue
38. Circular Linked List
39. Fibonacci Heap
40. Binomial Heap
41. Radix Tree
42. Radix Sort
43. Counting Bloom Filter
44. Counting Sort
45. Bucket Sort
46. Topological Sort
47. Minimum Spanning Tree
48. Shortest Path Tree
49. B-heap
50. Splay Tree
51. Wavelet Tree
52. X-fast Trie
53. Y-fast Trie
54. Hybrid Trie
55. Ternary Search Tree
56. Van Emde Boas Tree
57. Hash Trie
58. Dancing Links
59. Skip Graph
60. Perfect Hashing
61. Cuckoo Hashing
62. Linear Hashing
63. External Sorting
64. Van Emde Boas Layout
65. Deterministic Skip List
66. Fibonacci Skip List
67. Multiway Trie
68. Suffix Automaton
69. Finite Automaton
70. Pushdown Automaton
71. Deterministic Finite Automaton
72. Non-Deterministic Finite Automaton
73. Turing Machine
74. Multi-Dimensional Array
75. Multi-Dimensional Binary Search Tree
76. Sparse Matrix
77. Quadtree-based Matrix
78. Octree-based Matrix
79. Huffman Tree
80. LRU Cache
81. LFU Cache
82. ARC Cache
83. LIRS Cache
84. Bloomier Filter
85. Binary Heap
86. Fibonacci Queue
87. Binomial Queue
88. Cartesian Product
89. Fibonacci Search Tree
90. Multiway Search Tree
91. B-trie
92. Cache-oblivious Data Structures
93. Fully-functional Data Structures
94. Hash Array Mapped Tries
95. Generalized Suffix Tree
96. Generalized Suffix Array
97. GeoHash
98. R-Tree
99. X-tree
100. Z-order Curve


# Link

[[https://brilliant.org/wiki/sorting-algorithms/]]
[[https://docs.python.org/3.7/howto/sorting.html]]
