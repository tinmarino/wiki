---
title: Css tests (title)
category: Css
css: ../Css/layout_radio.css
---


<script src="../Css/js_css_chooser.js"></script>


# Start Css test (h1)



### 1 TOC

This tutorial provides a brief information on all 32 keywords in C programming.  


| Head1    | Head 2   | Head 3   | Head 4 |
| ---      | ---      | ---      | --- |
| auto     | break    | case     | char |
| const    | continue | default  | do |
| double   | else     | enum     | extern |
| float    | for      | goto     | if |
| int      | long     | register | return |
| short    | signed   | sizeof   | static |
| struct   | switch   | typedef  | union |
| unsigned | void     | volatile | while |


[auto](#auto)
[break](#break_continue)
[case](#switch_case_default)
[char](#char)
[const](#const)
[continue](#break_continue)
[default](#switch_case_default)
[do](#do_while)
[double](#double_float)
[else](#if_else)
[enum](#enum)
[extern](#extern)
[float](#double_float)
[for](#for)
[goto](#goto)
[if](#if_else)
[int](#int)
[long](#short_long_signed_unsigned)
[register](#register)
[return](#return)
[short](#short_long_signed_unsigned)
[signed](#short_long_signed_unsigned)
[sizeof](#sizeof)
[static](#static)
[struct](#struct)
[switch](#switch_case_default)
[typedef](#typedef)
[union](#union)
[unsigned](#short_long_signed_unsigned)
[void](#void)
[volatile](#volatile)
[while](#do_while)

### 2 Solarized table


| SOLARIZED | HEX     | 16/8 | TERMCOL   | XTERM | HEX     | L  | A   | B   | R | G   | B   | H   | S   | B  |
| --------- | ------- | ---- | -------   | ----  | ---     | -  | -   | -   | - | -   | -   | -   | -   | -  |
| base03    | #002b36 | 8/4  | brblack   | 234   | #1c1c1c | 15 | -12 | -12 | 0 | 43  | 54  | 193 | 100 | 21 |
| base02    | #073642 | 0/4  | black     | 235   | #262626 | 20 | -12 | -12 | 7 | 54  | 66  | 192 | 90  | 26 |
| base01    | #586e75 | 10/7 | brgreen   | 240   | #585858 | 45 | -07 | -07 | 88 | 110 | 117 | 194 | 25  | 46 |
| base00    | #657b83 | 11/7 | bryellow  | 241   | #626262 | 50 | -07 | -07 | 101 | 123 | 131 | 195 | 23  | 51 |
| base0     | #839496 | 12/6 | brblue    | 244   | #808080 | 60 | -06 | -03 | 131 | 148 | 150 | 186 | 13  | 59 |
| base1     | #93a1a1 | 14/4 | brcyan    | 245   | #8a8a8a | 65 | -05 | -02 | 147 | 161 | 161 | 180 | 9   | 63 |
| base2     | #eee8d5 | 7/7  | white     | 254   | #e4e4e4 | 92 | -00 | 10  | 238 | 232 | 213 | 44  | 11  | 93 |
| base3     | #fdf6e3 | 15/7 | brwhite   | 230   | #ffffd7 | 97 | 00  | 10  | 253 | 246 | 227 | 44  | 10  | 99 |
| yellow    | #b58900 | 3/3  | yellow    | 136   | #af8700 | 60 | 10  | 65  | 181 | 137 | 0   | 45  | 100 | 71 |
| orange    | #cb4b16 | 9/3  | brred     | 166   | #d75f00 | 50 | 50  | 55  | 203 | 75  | 22  | 18  | 89  | 80 |
| red       | #dc322f | 1/1  | red       | 160   | #d70000 | 50 | 65  | 45  | 220 | 50  | 47  | 1   | 79  | 86 |
| magenta   | #d33682 | 5/5  | magenta   | 125   | #af005f | 50 | 65  | -05 | 211 | 54  | 130 | 331 | 74  | 83 |
| violet    | #6c71c4 | 13/5 | brmagenta | 61    | #5f5faf | 50 | 15  | -45 | 108 | 113 | 196 | 237 | 45  | 77 |
| blue      | #268bd2 | 4/4  | blue      | 33    | #0087ff | 55 | -10 | -45 | 38 | 139 | 210 | 205 | 82  | 82 |
| cyan      | #2aa198 | 6/6  | cyan      | 37    | #00afaf | 60 | -35 | -05 | 42 | 161 | 152 | 175 | 74  | 63 |
| green     | #859900 | 2/2  | green     | 64    | #5f8700 | 60 | -20 | 65  | 133 | 153 | 0   | 68  | 100 | 60 |



### 3 []{#auto}auto

The auto keyword declares automatic variables. For example:

```C
auto int var1;
```

This statement suggests that var1 is a variable of storage class auto
and type int.

Variables declared within function bodies are automatic by default. They
are recreated each time a function is executed.

Since, automatic variables are local to a function, they are also called
local variables. To learn more visit [C storage
class](/c-programming/c-storage-class "C storage class").

------------------------------------------------------------------------

### 4 []{#break_continue}break and continue

The break statement makes program jump out of the innermost enclosing
loop (while, do, for or switch statements) explicitly.

The continue statement skips the certain statements inside the loop.

```C
for (i=1;i<=10;++i)
{
   if (i==3)
   continue;
   if (i==7)
   break;
   printf("%d ",i);
} 
```

<div id="block-inject-1" class="block-inject block-inject-1">

<div id="block-block-123" class="block block-block">

<div class="content">

<div id="div-gpt-ad-1527670353707-0">

</div>

<div id="div-gpt-ad-1527670429257-0">

</div>

</div>

</div>

</div>

<div class="clearfix">

</div>

**Output**

    1 2 4 5 6

When i is equal to 3, continue statement comes into effect and skips 3.
When i is equal to 7, break statement comes into effect and terminates
the for loop. To learn more, visit [C break and continue
statement](/c-programming/c-break-continue-statement)

------------------------------------------------------------------------

### 5 []{#switch_case_default}switch, case and default

The switch and case statement is used when a block of statements has to
be executed among many blocks. For example:

```C
switch(expression)
{
    case '1':
    //some statements to execute when 1
    break;
    case '5':
    //some statements to execute when 5
    break;
    default:
    //some statements to execute when default;
}
```

Visit [C switch
statement](/c-programming/c-switch-case-statement "C switch statement")
to learn more.

------------------------------------------------------------------------

### 7 []{#char}char

The char keyword declares a character variable. For example:

```C
char alphabet;
```

Here, alphabet is a character type variable.

To learn more, visit [C data
types](/c-programming/c-data-types "C data types").

------------------------------------------------------------------------

### 8 []{#const}const

An identifier can be declared constant by using const keyword.

    const int a = 5;

To learn more, visit[C variables and
constants](/c-programming/c-variables-constants "C programming variables and constants").

------------------------------------------------------------------------

### 9 []{#do_while}do...while

    int i;
    do 
    {
       print("%d ",i);
       i++;
    }
    while (i<10)

To learn more, visit [C do...while
loop](/c-programming/c-do-while-loops "C do while loop")

------------------------------------------------------------------------



### 10 []{#double_float}double and float

Keywords double and float are used for declaring floating type
variables. For example:

```C
float number;
double longNumber;
```

Here, number is single precision floating type variable whereas,
longNumber is a double precision floating type variable.

To learn more, visit [C data
types](/c-programming/c-data-types "C data types").

------------------------------------------------------------------------

## Here a break 1

### 11 []{#if_else}if and else

In C programming, if and else are used to make decisions.

    if (i == 1)
       printf("i is 1.")
    else
       prinf("i is not 1.")

If value of i is other than 1, output will be :

    i is not 1

To learn more, visit [C if...else
statement](/c-programming/c-if-else-statement "C if else").

------------------------------------------------------------------------

### 12 []{#enum}enum

Enumeration types are declared in C programming using keyword enum. For
example:

```C
enum suit
{
    hearts;
    spades;
    clubs;
    diamonds;
};
```

Here, a enumerated variable suit is created having tags: hearts, spades,
clubs and diamonds.

To learn more, visit [C enum](/c-programming/c-enumeration "C enum").

------------------------------------------------------------------------

### 13 []{#extern}extern

The extern keyword declares that a variable or a function has external
linkage outside of the file it is declared.

To learn more, visit [C storage
type](/c-programming/c-storage-class "C storage type").

------------------------------------------------------------------------

### 14 []{#for}for

There are three types of loops in C programming. The for loop is written
in C programming using keyword for. For example:

    for (i=0; i< 9;++i)
    {
      printf("%d ",i);
    }

**Output**

    0 1 2 3 4 5 6 7 8

To learn more, visit [C for
loop](/c-programming/c-for-loop "C for loop").

------------------------------------------------------------------------

### 15 []{#goto}goto

The goto keyword is used for unconditional jump to a labeled statement
inside a function. For example:

    for(i=1; i<5; ++i)
    {
        if (i==10)
        goto error;
    }
    printf("i is not 10");
    error:
        printf("Error, count cannot be 10.");

**Output**

    Error, count cannot be 10.

To learn more, visit [C goto](/c-programming/c-goto-statement "C goto").

------------------------------------------------------------------------

### 16 []{#int}int

The int keyword declares integer type variable. For example:

    int count;

Here, count is a integer variable.

To learn more, visit [C data
types](/c-programming/c-data-types "C data types").

------------------------------------------------------------------------

## Here a break 2

### 17 []{#short_long_signed_unsigned}short, long, signed and unsigned

The short, long, signed and unsigned keywodrs are type modifiers that
alters the meaning of a base data type to yield a new type.

    short int smallInteger;
    long int bigInteger;
    signed int normalInteger;
    unsigned int positiveInteger;

  Data types     Range
  -------------- --------------------------
  short int      -32768 to 32767
  long int       -2147483648 to 214743648
  signed int     -32768 to 32767
  unsigned int   0 to 65535

  : Range of int type data types

### 18 []{#return}return

The return keyword terminates the function and returns the value.

```C
int func()
{
    int b = 5;
    return b;
}
```

This function `func()` returns 5 to the calling function. To learn more,
visit [C user-defined
functions](/c-programming/c-user-defined-functions "C user defined functions").

------------------------------------------------------------------------

### 19 []{#sizeof}sizeof

The sizeof keyword evaluates the size of data (a variable or a
constant).

    #include <stdio.h>
    int main()
    {
        printf("%u bytes.",sizeof(char));
    }

To learn more, visit [C
operators](/c-programming/c-operators "C operators").

**Output**

    1 bytes.

------------------------------------------------------------------------

### 20 []{#register}register

The register keyword creates register variables which are much faster
than normal variables.

```C
register int var1;
```

------------------------------------------------------------------------

### 21 []{#static}static

The static keyword creates static variable. The value of the static
variables persists until the end of the program. For example:

```C
static int var;
```

------------------------------------------------------------------------

### 22 []{#struct}struct

The struct keyword is used for declaring a structure. A structure can
hold variables of different types under a single name.

```C
struct student{
    char name[80];
     float marks;
     int age;
}s1, s2;
```

To learn more, visit [C
structures](/c-programming/c-structures "C structures").

------------------------------------------------------------------------

### 23 []{#typedef}typedef

The typedef keyword is used to explicitly associate a type with an
identifier.

```C
typedef float kg;
kg bear, tiger;
```

------------------------------------------------------------------------

### 24 []{#union}union

A Union is used for grouping different types of variable under a single
name.

```C
union student 
{
    char name[80];
    float marks;
    int age;
}
```

To learn more, visit [C unions](/c-programming/c-unions "C unions").

------------------------------------------------------------------------

### 25 []{#void}void

The void keyword indicates that a function doesn't return any value.

```C
void testFunction(int a)
{
  .....
}
```

Here, function `testFunction( )` cannot return a value because the
return type is void.

------------------------------------------------------------------------

### 26 []{#volatile}volatile

The volatile keyword is used for creating volatile objects. A volatile
object can be modified in an unspecified way by the hardware.

    const volatile number

Here, number is a volatile object.

Since, number is a constant variable, the program cannot change it.
However, hardware can change it since it is a volatile object.

### 27 Vim test



* French accents `/^[a-zàâçéèêëîïôûùüÿñæœ .-]*$/i`

duplicate
azeaze
azeazea

duplicate

azeaz
duplicate
duplicate
duplicate
g/\v^([^ -=]+)\n\_.*%(^\1$)/d

--------------------------------------------------------------------------------
Donloaded from : https://www.programiz.com/c-programming/list-all-keywords-c-language  
