---
description: |
    C programming has various operators to perform tasks including
    arithmetic, conditional and bitwise operations. You will learn about
    various C operators and how to use them in this tutorial.
generator: 'Drupal 7 (http://drupal.org)'
google-site-verification: '17JZPeRuYVi-HGRJIG06Wx4uVrQSGPSGk7RLbZ7LaTA'
msvalidate.01: AC4EA77B0980B7169F9EEC142ADCC15B
viewport: 'width=device-width, initial-scale=1'
title: 'C Operators: Arithmetic, Logical, Conditional and more'
category: C
wiki_css: ../Css/solarized_dark.css, ../Css/layout_grid.css
---


An operator is a symbol which operates on a value or a variable. For
example: + is an operator to perform addition.

C programming has wide range of operators to perform various operations.
For better understanding of operators, these operators can be classified
as:

  Operators in C programming
  -------------------------------------------------
  [Arithmetic Operators](#arithmetic)
  [Increment and Decrement Operators](#increment)
  [Assignment Operators](#assignment)
  [Relational Operators](#relational)
  [Logical Operators](#logical)
  [Conditional Operators](#conditional)
  [Bitwise Operators](#bitwise)
  [Special Operators](#other)

### []{#arithmetic}C Arithmetic Operators

An arithmetic operator performs mathematical operations such as
addition, subtraction and multiplication on numerical values (constants
and variables).

  Operator   Meaning of Operator
  ---------- --------------------------------------------
  +          addition or unary plus
  -          subtraction or unary minus
  \*         multiplication
  /          division
  %          remainder after division( modulo division)

### Example \#1: Arithmetic Operators

```c
    // C Program to demonstrate the working of arithmetic operators
    #include <stdio.h>
    int main()
    {
        int a = 9,b = 4, c;
        
        c = a+b;
        printf("a+b = %d \n",c);

        c = a-b;
        printf("a-b = %d \n",c);
        
        c = a*b;
        printf("a*b = %d \n",c);
        
        c=a/b;
        printf("a/b = %d \n",c);
        
        c=a%b;
        printf("Remainder when a divided by b = %d \n",c);
        
        return 0;
    }
```

**Output**

```
    a+b = 13
    a-b = 5
    a*b = 36
    a/b = 2
    Remainder when a divided by b=1
```

The operators +, - and \* computes addition, subtraction and
multiplication respectively as you might have expected.

In normal calculation, `9/4 = 2.25`. However, the output is 2 in the
program.

It is because both variables a and b are integers. Hence, the output is
also an integer. The compiler neglects the term after decimal point and
shows answer 2 instead of 2.25.

The modulo operator % computes the remainder. When `a = 9` is divided by
`b = 4`, the remainder is 1. The % operator can only be used with
integers.

    Suppose a = 5.0, b = 2.0, c = 5 and d = 2. Then in C programming,

    a/b = 2.5  // Because both operands are floating-point variables
    a/d = 2.5  // Because one operand is floating-point variable
    c/b = 2.5  // Because one operand is floating-point variable
    c/d = 2     // Because both operands are integers

### []{#increment}Increment and decrement operators {#increment-and-decrement-operators .note}

C programming has two operators increment ++ and decrement -- to change
the value of an operand (constant or variable) by 1.

Increment ++ increases the value by 1 whereas decrement -- decreases the
value by 1. These two operators are unary operators, meaning they only
operate on a single operand.

### Example \#2: Increment and Decrement Operators

```c
    // C Program to demonstrate the working of increment and decrement operators
    #include <stdio.h>
    int main()
    {
        int a = 10, b = 100;
        float c = 10.5, d = 100.5;

        printf("++a = %d \n", ++a);

        printf("--b = %d \n", --b);

        printf("++c = %f \n", ++c);

        printf("--d = %f \n", --d);

        return 0;
    }
```

**Output**

```
    ++a = 11
    --b = 99
    ++c = 11.500000
    ++d = 99.500000
```

Here, the operators ++ and -- are used as prefix. These two operators
can also be used as postfix like `a++` and `a--`. Visit this page to
learn more on how [increment and decrement operators work when used as
postfix](/article/increment-decrement-operator-difference-prefix-postfix "Increment Operator as postfix").

### []{#assignment}C Assignment Operators

An assignment operator is used for assigning a value to a variable. The
most common assignment operator is =

  Operator   Example   Same as
  ---------- --------- ----------
  =          a = b     a = b
  +=         a += b    a = a+b
  -=         a -= b    a = a-b
  \*=        a \*= b   a = a\*b
  /=         a /= b    a = a/b
  %=         a %= b    a = a%b

#### Example \#3: Assignment Operators

```c
    // C Program to demonstrate the working of assignment operators
    #include <stdio.h>
    int main()
    {
        int a = 5, c;

        c = a;
        printf("c = %d \n", c);

        c += a; // c = c+a
        printf("c = %d \n", c);

        c -= a; // c = c-a
        printf("c = %d \n", c);

        c *= a; // c = c*a
        printf("c = %d \n", c);

        c /= a; // c = c/a
        printf("c = %d \n", c);

        c %= a; // c = c%a
        printf("c = %d \n", c);

        return 0;
    }
```

**Output**

```
    c = 5 
    c = 10 
    c = 5 
    c = 25 
    c = 5 
    c = 0
```

### []{#relational}C Relational Operators

A relational operator checks the relationship between two operands. If
the relation is true, it returns 1; if the relation is false, it returns
value 0.

Relational operators are used in [decision
making](/c-programming/c-if-else-statement "C if else") and
[loops](/c-programming/c-for-loop "C for loop").

  Operator   Meaning of Operator        Example
  ---------- -------------------------- ---------------------
  ==         Equal to                   5 == 3 returns 0
  &gt;       Greater than               5 &gt; 3 returns 1
  &lt;       Less than                  5 &lt; 3 returns 0
  !=         Not equal to               5 != 3 returns 1
  &gt;=      Greater than or equal to   5 &gt;= 3 returns 1
  &lt;=      Less than or equal to      5 &lt;= 3 return 0

### Example \#4: Relational Operators

```c
    // C Program to demonstrate the working of arithmetic operators
    #include <stdio.h>
    int main()
    {
        int a = 5, b = 5, c = 10;

        printf("%d == %d = %d \n", a, b, a == b); // true
        printf("%d == %d = %d \n", a, c, a == c); // false

        printf("%d > %d = %d \n", a, b, a > b); //false
        printf("%d > %d = %d \n", a, c, a > c); //false


        printf("%d < %d = %d \n", a, b, a < b); //false
        printf("%d < %d = %d \n", a, c, a < c); //true


        printf("%d != %d = %d \n", a, b, a != b); //false
        printf("%d != %d = %d \n", a, c, a != c); //true


        printf("%d >= %d = %d \n", a, b, a >= b); //true
        printf("%d >= %d = %d \n", a, c, a >= c); //false


        printf("%d <= %d = %d \n", a, b, a <= b); //true
        printf("%d <= %d = %d \n", a, c, a <= c); //true

        return 0;

    }
```

**Output**

```
    5 == 5 = 1
    5 == 10 = 0
    5 > 5 = 0
    5 > 10 = 0
    5 < 5 = 0
    5 < 10 = 1
    5 != 5 = 0
    5 != 10 = 1
    5 >= 5 = 1
    5 >= 10 = 0
    5 <= 5 = 1
    5 <= 10 = 1 
```

### []{#logical}C Logical Operators

An expression containing logical operator returns either 0 or 1
depending upon whether expression results true or false. Logical
operators are commonly used in [decision making in C
programming](/c-programming/c-if-else-statement "C if else").

  Operator   Meaning of Operator                                   Example
  ---------- ----------------------------------------------------- --------------------------------------------------------------------------
  &&         Logial AND. True only if all operands are true        If c = 5 and d = 2 then, expression `((c == 5) && (d > 5))` equals to 0.
  ||         Logical OR. True only if either one operand is true   If c = 5 and d = 2 then, expression `((c == 5) || (d > 5))` equals to 1.
  !          Logical NOT. True only if the operand is 0            If c = 5 then, expression `! (c == 5)` equals to 0.

### Example \#5: Logical Operators

```c
    // C Program to demonstrate the working of logical operators

    #include <stdio.h>
    int main()
    {
        int a = 5, b = 5, c = 10, result;

        result = (a == b) && (c > b);
        printf("(a == b) && (c > b) equals to %d \n", result);

        result = (a == b) && (c < b);
        printf("(a == b) && (c < b) equals to %d \n", result);

        result = (a == b) || (c < b);
        printf("(a == b) || (c < b) equals to %d \n", result);

        result = (a != b) || (c < b);
        printf("(a != b) || (c < b) equals to %d \n", result);

        result = !(a != b);
        printf("!(a == b) equals to %d \n", result);

        result = !(a == b);
        printf("!(a == b) equals to %d \n", result);

        return 0;
    }
```

**Output**

```
    (a == b) && (c > b) equals to 1 
    (a == b) && (c < b) equals to 0 
    (a == b) || (c < b) equals to 1 
    (a != b) || (c < b) equals to 0 
    !(a != b) equals to 1 
    !(a == b) equals to 0 
```

**Explanation of logical operator program**

-   `(a == b) && (c > 5)` evaluates to 1 because both operands
    `(a == b)` and `(c > b)` is 1 (true).
-   `(a == b) && (c < b)` evaluates to 0 because operand `(c < b)` is 0
    (false).
-   `(a == b) || (c < b)` evaluates to 1 because `(a = b)` is 1 (true).
-   `(a != b) || (c < b)` evaluates to 0 because both operand `(a != b)`
    and `(c < b)` are 0 (false).
-   `!(a != b)` evaluates to 1 because operand `(a != b)` is 0 (false).
    Hence, !(a != b) is 1 (true).
-   `!(a == b)` evaluates to 0 because `(a == b)` is 1 (true). Hence,
    `!(a == b)` is 0 (false).

### []{#bitwise}Bitwise Operators

During computation, mathematical operations like: addition, subtraction,
addition and division are converted to bit-level which makes processing
faster and saves power.

Bitwise operators are used in C programming to perform bit-level
operations.

  Operators   Meaning of operators
  ----------- ----------------------
  &           Bitwise AND
  |           Bitwise OR
  \^          Bitwise exclusive OR
  \~          Bitwise complement
  &lt;&lt;    Shift left
  &gt;&gt;    Shift right

Visit [bitwise operator in
C](/c-programming/bitwise-operators "C bitwise operators") to learn
more.

### []{#other}Other Operators

#### Comma Operator

Comma operators are used to link related expressions together. For
example:

```c
    int a, c = 5, d;
```

#### The sizeof operator

The `sizeof` is an unary operator which returns the size of data
(constant, variables, array, structure etc).

#### Example \#6: sizeof Operator

```c
    #include <stdio.h>
    int main()
    {
        int a, e[10];
        float b;
        double c;
        char d;
        printf("Size of int=%lu bytes\n",sizeof(a));
        printf("Size of float=%lu bytes\n",sizeof(b));
        printf("Size of double=%lu bytes\n",sizeof(c));
        printf("Size of char=%lu byte\n",sizeof(d));
        printf("Size of integer type array having 10 elements = %lu bytes\n", sizeof(e));
        return 0;
    }
```

**Output**

```
    Size of int = 4 bytes
    Size of float = 4 bytes
    Size of double = 8 bytes
    Size of char = 1 byte
    Size of integer type array having 10 elements = 40 bytes
```

### []{#conditional} C Ternary Operator (?:)

A conditional operator is a ternary operator, that is, it works on 3
operands.

#### Conditional Operator Syntax

    conditionalExpression ? expression1 : expression2

The conditional operator works as follows:

-   The first expression conditionalExpression is evaluated first. This
    expression evaluates to 1 if it's true and evaluates to 0 if it's
    false.
-   If conditionalExpression is true, expression1 is evaluated.
-   If conditionalExpression is false, expression2 is evaluated.

#### Example \#7: C conditional Operator

```c
    #include <stdio.h>
    int main(){
       char February;
       int days;
       printf("If this year is leap year, enter 1. If not enter any integer: ");
       scanf("%c",&February);

       // If test condition (February == 'l') is true, days equal to 29.
       // If test condition (February =='l') is false, days equal to 28. 
       days = (February == '1') ? 29 : 28;

       printf("Number of days in February = %d",days);
       return 0;
    }
```
**Output**

```
    If this year is leap year, enter 1. If not enter any integer: 1
    Number of days in February = 29
```

Other operators such as & (reference operator), \* (dereference
operator) and -&gt; (member selection) operator will be discussed in [C
pointers](/c-programming/c-pointers "C Pointers").
