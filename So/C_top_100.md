---
title: C <- StackOverflow top 100
category: C
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How to initialize all members of an array to the same value? (score [1778177](https://stackoverflow.com/q/201101) in 2017)

#### Question
I have a large array in C (not C++ if that makes a difference). I want to initialize all members to the same value. I could swear I once knew a simple way to do this. I could use `memset()` in my case, but isn't there a way to do this that is built right into the C syntax?  

#### Answer accepted (score 1184)
<p>Unless that value is 0 (in which case you can omit some part of the initializer
and the corresponding elements will be initialized to 0), there's no easy way.</p>

Don't overlook the obvious solution, though:  

```c
int myArray[10] = { 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 };
```

Elements with missing values will be initialized to 0:  

```c
int myArray[10] = { 1, 2 }; // initialize to 1,2,0,0,0...
```

So this will initialize all elements to 0:  

```c
int myArray[10] = { 0 }; // all elements 0
```

<p>In C++, an empty initialization list will also initialize every element to 0.
This is <a href="https://stackoverflow.com/a/17589839">not allowed</a> with C:</p>

```c
int myArray[10] = {}; // all elements 0 in C++
```

<p>Remember that objects with static storage duration will initialize to 0 if no
initializer is specified:</p>

```c
static int myArray[10]; // all elements 0
```

<p>And that "0" doesn't necessarily mean "all-bits-zero", so using the above is
better and more portable than memset(). (Floating point values will be
initialized to +0, pointers to null value, etc.)</p>

#### Answer 2 (score 383)
If your compiler is GCC you can use following syntax:  

```c
int array[1024] = {[0 ... 1023] = 5};
```

<p>Check out detailed description:
<a href="http://gcc.gnu.org/onlinedocs/gcc-4.1.2/gcc/Designated-Inits.html" rel="noreferrer">http://gcc.gnu.org/onlinedocs/gcc-4.1.2/gcc/Designated-Inits.html</a></p>

#### Answer 3 (score 176)
For statically initializing a large array with the same value, without multiple copy-paste, you can use macros:  

```c
#define VAL_1X     42
#define VAL_2X     VAL_1X,  VAL_1X
#define VAL_4X     VAL_2X,  VAL_2X
#define VAL_8X     VAL_4X,  VAL_4X
#define VAL_16X    VAL_8X,  VAL_8X
#define VAL_32X    VAL_16X, VAL_16X
#define VAL_64X    VAL_32X, VAL_32X

int myArray[53] = { VAL_32X, VAL_16X, VAL_4X, VAL_1X };
```

If you need to change the value, you have to do the replacement at only one place.  

<h5>Edit: possible useful extensions</h2>

(courtesy of <a href="https://stackoverflow.com/users/15168/jonathan-leffler">Jonathan Leffler</a>)  

You can easily generalize this with:  

```c
#define VAL_1(X) X
#define VAL_2(X) VAL_1(X), VAL_1(X)
/* etc. */
```

A variant can be created using:  

```c
#define STRUCTVAL_1(...) { __VA_ARGS__ }
#define STRUCTVAL_2(...) STRUCTVAL_1(__VA_ARGS__), STRUCTVAL_1(__VA_ARGS__)
/*etc */ 
```

that works with structures or compound arrays.  

```c
#define STRUCTVAL_48(...) STRUCTVAL_32(__VA_ARGS__), STRUCTVAL_16(__VA_ARGS__)

struct Pair { char key[16]; char val[32]; };
struct Pair p_data[] = { STRUCTVAL_48("Key", "Value") };
int a_data[][4] = { STRUCTVAL_48(12, 19, 23, 37) };
```

macro names are negotiable.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How do I determine the size of my array in C? (score [1765256](https://stackoverflow.com/q/37538) in 2013)

#### Question
How do I determine the size of my array in C?   

That is, the number of elements the array can hold?  

#### Answer accepted (score 1120)
<strong>Executive summary:</strong>  

```c
int a[17];
size_t n = sizeof(a)/sizeof(a[0]);
```

<hr>

<strong>Full answer:</strong>  

<p>To determine the size of your array in bytes, you can use the `sizeof`
operator:</p>

```c
int a[17];
size_t n = sizeof(a);
```

On my computer, ints are 4 bytes long, so n is 68.  

<p>To determine the number of elements in the array, we can divide
the total size of the array by the size of the array element.
You could do this with the type, like this:</p>

```c
int a[17];
size_t n = sizeof(a) / sizeof(int);
```

<p>and get the proper answer (68 / 4 = 17), but if the type of
`a` changed you would have a nasty bug if you forgot to change
the `sizeof(int)` as well.</p>

<p>So the preferred divisor is `sizeof(a[0])`, the size of the
zeroeth element of the array.</p>

```c
int a[17];
size_t n = sizeof(a) / sizeof(a[0]);
```

<p>Another advantage is that you can now easily parameterize
the array name in a macro and get:</p>

```c
#define NELEMS(x)  (sizeof(x) / sizeof((x)[0]))

int a[17];
size_t n = NELEMS(a);
```

#### Answer 2 (score 743)
The `sizeof` way is the right way <a href="https://en.wikipedia.org/wiki/If_and_only_if" rel="noreferrer"><em>iff</em></a> you are dealing with arrays not received as parameters. An array sent as a parameter to a function is treated as a pointer, so `sizeof` will return the pointer's size, instead of the array's.  

Thus, inside functions this method does not work. Instead, always pass an additional parameter `size_t size` indicating the number of elements in the array.  

Test:  

```c
#include <stdio.h>
#include <stdlib.h>

void printSizeOf(int intArray[]);
void printLength(int intArray[]);

int main(int argc, char* argv[])
{
    int array[] = { 0, 1, 2, 3, 4, 5, 6 };

    printf("sizeof of array: %d\n", (int) sizeof(array));
    printSizeOf(array);

    printf("Length of array: %d\n", (int)( sizeof(array) / sizeof(array[0]) ));
    printLength(array);
}

void printSizeOf(int intArray[])
{
    printf("sizeof of parameter: %d\n", (int) sizeof(intArray));
}

void printLength(int intArray[])
{
    printf("Length of parameter: %d\n", (int)( sizeof(intArray) / sizeof(intArray[0]) ));
}
```

Output (in a 64-bit Linux OS):  

```c
sizeof of array: 28
sizeof of parameter: 8
Length of array: 7
Length of parameter: 2
```

Output (in a 32-bit windows OS):  

```c
sizeof of array: 28
sizeof of parameter: 4
Length of array: 7
Length of parameter: 1
```

#### Answer 3 (score 126)
It is worth noting that `sizeof` doesn't help when dealing with an array value that has decayed to a pointer: even though it points to the start of an array, to the compiler it is the same as a pointer to a single element of that array. A pointer does not "remember" anything else about the array that was used to initialize it.  

```c
int a[10];
int* p = a;

assert(sizeof(a) / sizeof(a[0]) == 10);
assert(sizeof(p) == sizeof(int*));
assert(sizeof(*p) == sizeof(int));
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: Convert char to int in C and C++ (score [1516373](https://stackoverflow.com/q/5029840) in 2011)

#### Question
How do I convert a `char` to an `int` in C and C++?  

#### Answer 2 (score 466)
Depends on what you want to do:  

to read the value as an ascii code, you can write  

```c
char a = 'a';
int ia = (int)a; 
/* note that the int cast is not necessary -- int ia = a would suffice */
```

to convert the character `'0' -&gt; 0`, `'1' -&gt; 1`, etc, you can write  

```c
char a = '4';
int ia = a - '0';
/* check here if ia is bounded by 0 and 9 */
```

<p><strong>Explanation</strong>:<br>
`a - '0'` is equivalent to `((int)a) - ((int)'0')`, which means the ascii values of the characters are subtracted from each other. Since `0` comes directly before `1` in the ascii table (and so on until `9`), the difference between the two gives the number that the character `a` represents.</p>

#### Answer 3 (score 78)
Well, in ASCII code, the numbers (digits) start from <strong>48</strong>. All you need to do is:  

```c
int x = (int)character - 48;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How to generate a random int in C? (score [1515123](https://stackoverflow.com/q/822323) in 2018)

#### Question
Is there a function to generate a random int number in C?  Or will I have to use a third party library?  

#### Answer accepted (score 639)
<blockquote>
  <strong>Note</strong>: Don't use `rand()` for security. If you need a cryptographically secure number, <a href="https://stackoverflow.com/a/39475626/2224584">see this answer</a> instead.  
</blockquote>

```c
#include <time.h>
#include <stdlib.h>

srand(time(NULL));   // Initialization, should only be called once.
int r = rand();      // Returns a pseudo-random integer between 0 and RAND_MAX.
```

<em>Edit</em>: On Linux, you might prefer to use <a href="https://linux.die.net/man/3/random" rel="noreferrer">random and srandom</a>.  

#### Answer 2 (score 229)
The `rand()` function in `&lt;stdlib.h&gt;` returns a  pseudo-random integer between 0 and `RAND_MAX`. You can use `srand(unsigned int seed)` to set a seed.  

It's common practice to use the `%` operator in conjunction with `rand()` to get a different range (though bear in mind that this throws off the uniformity somewhat). For example:  

```c
/* random int between 0 and 19 */
int r = rand() % 20;
```

If you <em>really</em> care about uniformity you can do something like this:  

```c
/* Returns an integer in the range [0, n).
 *
 * Uses rand(), and so is affected-by/affects the same seed.
 */
int randint(int n) {
  if ((n - 1) == RAND_MAX) {
    return rand();
  } else {
    // Supporting larger values for n would requires an even more
    // elaborate implementation that combines multiple calls to rand()
    assert (n <= RAND_MAX)

    // Chop off all of the values that would cause skew...
    int end = RAND_MAX / n; // truncate skew
    assert (end > 0);
    end *= n;

    // ... and ignore results from rand() that fall above that limit.
    // (Worst case the loop condition should succeed 50% of the time,
    // so we can expect to bail out of this loop pretty quickly.)
    int r;
    while ((r = rand()) >= end);

    return r % n;
  }
}
```

#### Answer 3 (score 51)
<h5>If you need secure random characters or integers:</h3>

As addressed in <a href="https://paragonie.com/blog/2016/05/how-generate-secure-random-numbers-in-various-programming-languages#c-csprng" rel="noreferrer">how to safely generate random numbers in various programming languages</a>, you'll want to do one of the following:  

<ul>
<li>Use <a href="https://github.com/jedisct1/libsodium" rel="noreferrer">libsodium</a>'s `randombytes` API</li>
<li>Re-implement what you need from <a href="https://github.com/jedisct1/libsodium/blob/master/src/libsodium/randombytes/sysrandom/randombytes_sysrandom.c" rel="noreferrer">libsodium's sysrandom implementation</a> yourself, very carefully</li>
<li>More broadly, <a href="http://sockpuppet.org/blog/2014/02/25/safely-generate-random-numbers/" rel="noreferrer">use `/dev/urandom`</a>, not `/dev/random`. Not OpenSSL (or other userspace PRNGs).</li>
</ul>

For example:  

```c
#include "sodium.h"

int foo()
{
    char myString[32];
    uint32_t myInt;

    if (sodium_init() < 0) {
        /* panic! the library couldn't be initialized, it is not safe to use */
        return 1; 
    }


    /* myString will be an array of 32 random bytes, not null-terminated */        
    randombytes_buf(myString, 32);

    /* myInt will be a random number between 0 and 9 */
    myInt = randombytes_uniform(10);
}
```

`randombytes_uniform()` is cryptographically secure and unbiased.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Using boolean values in C (score [1246473](https://stackoverflow.com/q/1921539) in 2016)

#### Question
C doesn't have any built-in boolean types. What's the best way to use them in C?  

#### Answer accepted (score 981)
From best to worse:  

<strong>Option 1 (C99)</strong>  

```c
#include <stdbool.h>
```

<strong>Option 2</strong>  

```c
typedef enum { false, true } bool;
```

<strong>Option 3</strong>  

```c
typedef int bool;
enum { false, true };
```

<strong>Option 4</strong>  

```c
typedef int bool;
#define true 1
#define false 0
```

<h5>Explanation</h1>

<ul>
<li>Option 1 will work only if you use C99 and it's the "standard way" to do it. Choose this if possible.</li>
<li>Options 2, 3 and 4 will have in practice the same identical behavior. #2 and #3 don't use #defines though, which in my opinion is better.</li>
</ul>

If you are undecided, go with #1!  

#### Answer 2 (score 229)
A few thoughts on booleans in C:  

I'm old enough that I just use plain `int`s as my boolean type without any typedefs or special defines or enums for true/false values.  If you follow my suggestion below on never comparing against boolean constants, then you only need to use 0/1 to initialize the flags anyway.  However, such an approach may be deemed too reactionary in these modern times.  In that case, one should definitely use `&lt;stdbool.h&gt;` since it at least has the benefit of being standardized.  

Whatever the boolean constants are called, use them only for initialization.  Never ever write something like  

```c
if (ready == TRUE) ...
while (empty == FALSE) ...
```

These can always be replaced by the clearer   

```c
if (ready) ...
while (!empty) ...
```

Note that these can actually reasonably and understandably be read out loud.  

Give your boolean variables positive names, ie `full` instead of `notfull`.  The latter leads to code that is difficult to read easily.  Compare  

```c
if (full) ...
if (!full) ...
```

with  

```c
if (!notfull) ...
if (notfull) ...
```

Both of the former pair read naturally, while `!notfull` is awkward to read even as it is, and becomes much worse in more complex boolean expressions.  

Boolean arguments should generally be avoided.  Consider a function defined like this  

```c
void foo(bool option) { ... }
```

Within the body of the function, it is very clear what the argument means since it has a convenient, and hopefully meaningful, name.  But, the call sites look like  

```c
foo(TRUE);
foo(FALSE):
```

Here, it's essentially impossible to tell what the parameter meant without always looking at the function definition or declaration, and it gets much worse as soon if you add even more boolean parameters.  I suggest either  

```c
typedef enum { OPT_ON, OPT_OFF } foo_option;
void foo(foo_option option);
```

or  

```c
#define OPT_ON true
#define OPT_OFF false
void foo(bool option) { ... }
```

In either case, the call site now looks like  

```c
foo(OPT_ON);
foo(OPT_OFF);
```

which the reader has at least a chance of understanding without dredging up the definition of `foo`.  

#### Answer 3 (score 83)
A boolean in C is an integer: zero for false and non-zero for true.  

See also <a href="https://en.wikipedia.org/wiki/Boolean_data_type#C.2C_C.2B.2B.2C_Objective-C.2C_AWK" rel="noreferrer"><em>Boolean data type</em>, section <em>C, C++, Objective-C, AWK</em></a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: How do you set, clear, and toggle a single bit? (score [1095506](https://stackoverflow.com/q/47981) in 2019)

#### Question
How do you set, clear, and toggle a bit?  

#### Answer accepted (score 3407)
<h5>Setting a bit</h1>

Use the bitwise OR operator (`|`) to set a bit.  

```c
number |= 1UL << n;
```

That will set the `n`th bit of `number`. `n` should be zero, if you want to set the `1`st bit and so on upto `n-1`, if you want to set the `n`th bit.  

Use `1ULL` if `number` is wider than `unsigned long`; promotion of `1UL &lt;&lt; n` doesn't happen until after evaluating `1UL &lt;&lt; n` where it's undefined behaviour to shift by more than the width of a `long`.  The same applies to all the rest of the examples.  

<h5>Clearing a bit</h1>

Use the bitwise AND operator (`&amp;`) to clear a bit.  

```c
number &= ~(1UL << n);
```

That will clear the `n`th bit of `number`. You must invert the bit string with the bitwise NOT operator (`~`), then AND it.  

<h5>Toggling a bit</h1>

The XOR operator (`^`) can be used to toggle a bit.  

```c
number ^= 1UL << n;
```

That will toggle the `n`th bit of `number`.  

<h5>Checking a bit</h1>

You didn't ask for this, but I might as well add it.  

To check a bit, shift the number n to the right, then bitwise AND it:  

```c
bit = (number >> n) & 1U;
```

That will put the value of the `n`th bit of `number` into the variable `bit`.  

<h5>Changing the <em>n</em>th bit to <em>x</em></h1>

Setting the `n`th bit to either `1` or `0` can be achieved with the following on a 2's complement C++ implementation:  

```c
number ^= (-x ^ number) & (1UL << n);
```

Bit `n` will be set if `x` is `1`, and cleared if `x` is `0`.  If `x` has some other value, you get garbage.  `x = !!x` will booleanize it to 0 or 1.  

To make this independent of 2's complement negation behaviour (where `-1` has all bits set, unlike on a 1's complement or sign/magnitude C++ implementation), use unsigned negation.  

```c
number ^= (-(unsigned long)x ^ number) & (1UL << n);
```

or  

```c
unsigned long newbit = !!x;    // Also booleanize to force 0 or 1
number ^= (-newbit ^ number) & (1UL << n);
```

It's generally a good idea to use unsigned types for portable bit manipulation.  

or  

```c
number = (number & ~(1UL << n)) | (x << n);
```

`(number &amp; ~(1UL &lt;&lt; n))` will clear the `n`th bit and `(x &lt;&lt; n)` will set the `n`th bit to `x`.  

It's also generally a good idea to not to copy/paste code in general and so many people use preprocessor macros (like <a href="https://stackoverflow.com/a/263738/52074">the community wiki answer further down</a>) or some sort of encapsulation.  

#### Answer 2 (score 438)
Using the Standard C++ Library: <a href="http://en.cppreference.com/w/cpp/utility/bitset" rel="noreferrer">`std::bitset&lt;N&gt;`</a>.  

Or the <a href="http://en.wikipedia.org/wiki/Boost_%28C%2B%2B_libraries%29" rel="noreferrer">Boost</a> version: <a href="http://www.boost.org/doc/libs/release/libs/dynamic_bitset/dynamic_bitset.html" rel="noreferrer">`boost::dynamic_bitset`</a>.  

There is no need to roll your own:  

```c
#include <bitset>
#include <iostream>

int main()
{
    std::bitset<5> x;

    x[1] = 1;
    x[2] = 0;
    // Note x[0-4]  valid

    std::cout << x << std::endl;
}
```

<hr>

```c
[Alpha:] > ./a.out
00010
```

The Boost version allows a runtime sized bitset compared with a <a href="https://en.wikipedia.org/wiki/C%2B%2B_Standard_Library" rel="noreferrer">standard library</a> compile-time sized bitset.  

#### Answer 3 (score 234)
The other option is to use bit fields:  

```c
struct bits {
    unsigned int a:1;
    unsigned int b:1;
    unsigned int c:1;
};

struct bits mybits;
```

defines a 3-bit field (actually, it's three 1-bit felds). Bit operations now become a bit (haha) simpler:  

To set or clear a bit:  

```c
mybits.b = 1;
mybits.c = 0;
```

To toggle a bit:  

```c
mybits.a = !mybits.a;
mybits.b = ~mybits.b;
mybits.c ^= 1;  /* all work */
```

Checking a bit:  

```c
if (mybits.c)  //if mybits.c is non zero the next line below will execute
```

This only works with fixed-size bit fields. Otherwise you have to resort to the bit-twiddling techniques described in previous posts.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: How do I concatenate const/literal strings in C? (score [964267](https://stackoverflow.com/q/308695) in 2017)

#### Question
I'm working in C, and I have to concatenate a few things.  

Right now I have this:  

```c
message = strcat("TEXT ", var);

message2 = strcat(strcat("TEXT ", foo), strcat(" TEXT ", bar));
```

Now if you have experience in C I'm sure you realize that this gives you a segmentation fault when you try to run it. So how do I work around that?  

#### Answer accepted (score 351)
In C, "strings" are just plain `char` arrays. Therefore, you can't directly concatenate them with other "strings".   

You can use the `strcat` function, which appends the string pointed to by `src` to the end of the string pointed to by `dest`:  

```c
char *strcat(char *dest, const char *src);
```

Here is an <a href="http://www.cplusplus.com/reference/clibrary/cstring/strcat.html" rel="noreferrer">example from cplusplus.com</a>:  

```c
char str[80];
strcpy(str, "these ");
strcat(str, "strings ");
strcat(str, "are ");
strcat(str, "concatenated.");
```

For the first parameter, you need to provide the destination buffer itself.  The destination buffer must be a char array buffer.  E.g.: `char buffer[1024];`  

<strong>Make sure</strong> that the first parameter has enough space to store what you're trying to copy into it.  If available to you, it is safer to use functions like: `strcpy_s` and `strcat_s` where you explicitly have to specify the size of the destination buffer.   

<em>Note</em>: A string literal cannot be used as a buffer, since it is a constant. Thus, you always have to allocate a char array for the buffer.  

The return value of `strcat` can simply be ignored, it merely returns the same pointer as was passed in as the first argument. It is there for convenience, and allows you to chain the calls into one line of code:  

```c
strcat(strcat(str, foo), bar);
```

So your problem could be solved as follows:  

```c
char *foo = "foo";
char *bar = "bar";
char str[80];
strcpy(str, "TEXT ");
strcat(str, foo);
strcat(str, bar);
```

#### Answer 2 (score 236)
Avoid using <a href="http://en.cppreference.com/w/cpp/string/byte/strcat" rel="noreferrer">`strcat`</a> in C code. The cleanest and, most importantly, the safest way is to use <a href="http://en.cppreference.com/w/cpp/io/c/snprintf" rel="noreferrer">`snprintf`</a>:  

```c
char buf[256];
snprintf(buf, sizeof buf, "%s%s%s%s", str1, str2, str3, str4);
```

Some commenters raised an issue that the number of arguments may not match the format string and the code will still compile, but most compilers already issue a warning if this is the case.  

#### Answer 3 (score 24)
<p>Folks, use str<b>n</b>cpy(), str<b>n</b>cat(), or s<b>n</b>printf().
<br>Exceeding your buffer space will trash whatever else follows in memory!
<br>(And remember to allow space for the trailing null '\0' character!)</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: How to convert integer to string in C? (score [945144](https://stackoverflow.com/q/9655202) in 2018)

#### Question
I tried this example:  

```c
/* itoa example */
#include <stdio.h>
#include <stdlib.h>

int main ()
{
    int i;
    char buffer [33];
    printf ("Enter a number: ");
    scanf ("%d",&i);
    itoa (i,buffer,10);
    printf ("decimal: %s\n",buffer);
    itoa (i,buffer,16);
    printf ("hexadecimal: %s\n",buffer);
    itoa (i,buffer,2);
    printf ("binary: %s\n",buffer);
    return 0;
}
```

but the example there doesn't work (it says the function `itoa` doesn't exist).  

#### Answer accepted (score 274)
Use <a href="http://en.cppreference.com/w/c/io/fprintf" rel="noreferrer">`sprintf()`</a>:  

```c
int someInt = 368;
char str[12];
sprintf(str, "%d", someInt);
```

All numbers that are representable by `int` will fit in a 12-char-array without overflow, unless your compiler is somehow using more than 32-bits for `int`. When using numbers with greater bitsize, e.g. `long` with most 64-bit compilers, you need to increase the array size—at least 21 characters for 64-bit types.  

#### Answer 2 (score 51)
Making your own `itoa` is also easy, try this :  

```c
char* itoa(int i, char b[]){
    char const digit[] = "0123456789";
    char* p = b;
    if(i<0){
        *p++ = '-';
        i *= -1;
    }
    int shifter = i;
    do{ //Move to where representation ends
        ++p;
        shifter = shifter/10;
    }while(shifter);
    *p = '\0';
    do{ //Move back, inserting digits as u go
        *--p = digit[i%10];
        i = i/10;
    }while(i);
    return b;
}
```

or use the standard `sprintf()` function.  

#### Answer 3 (score 44)
That's because `itoa` isn't a standard function. Try `snprintf` instead.  

```c
char str[LEN];
snprintf(str, LEN, "%d", 42);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: What is the difference between float and double? (score [936859](https://stackoverflow.com/q/2386772) in 2018)

#### Question
I've read about the difference between double precision and single precision. However, in most cases, `float` and `double` seem to be interchangeable, i.e. using one or the other does not seem to affect the results. Is this really the case? When are floats and doubles interchangeable? What are the differences between them?  

#### Answer accepted (score 466)
Huge difference.  

As the name implies, a <a href="http://en.wikipedia.org/wiki/Double_precision_floating-point_format" rel="noreferrer">`double`</a> has 2x the precision of <a href="http://en.wikipedia.org/wiki/Single_precision_floating-point_format" rel="noreferrer">`float`</a><sup>[1]</sup>. In general a `double` has 15 decimal digits of precision, while `float` has 7.  

Here's how the number of digits are calculated:  

<blockquote>
  `double` has 52 mantissa bits + 1 hidden bit: log(2<sup>53</sup>)÷log(10) = 15.95 digits  
  
  `float` has 23 mantissa bits + 1 hidden bit: log(2<sup>24</sup>)÷log(10) = 7.22 digits  
</blockquote>

This precision loss could lead to greater truncation errors being accumulated when repeated calculations are done, e.g.  

```c
float a = 1.f / 81;
float b = 0;
for (int i = 0; i < 729; ++ i)
    b += a;
printf("%.7g\n", b); // prints 9.000023
```

while  

```c
double a = 1.0 / 81;
double b = 0;
for (int i = 0; i < 729; ++ i)
    b += a;
printf("%.15g\n", b); // prints 8.99999999999996
```

Also, the maximum value of float is about `3e38`, but double is about `1.7e308`, so using `float` can hit "infinity" (i.e. a special floating-point number) much more easily than `double` for something simple, e.g. computing the factorial of 60.  

During testing, maybe a few test cases contain these huge numbers, which may cause your programs to fail if you use floats.  

<hr>

Of course, sometimes, even `double` isn't accurate enough, hence we sometimes have `long double`<sup>[1]</sup> (the above example gives 9.000000000000000066 on Mac), but all floating point types suffer from <em>round-off errors</em>, so if precision is very important (e.g. money processing) you should use `int` or a fraction class.  

<hr>

Furthermore, don't use `+=` to sum lots of floating point numbers, as the errors accumulate quickly. If you're using Python, use `fsum`. Otherwise, try to implement the <a href="http://en.wikipedia.org/wiki/Kahan_summation_algorithm" rel="noreferrer">Kahan summation algorithm</a>.  

<hr>

<sup>[1]: The C and C++ standards do not specify the representation of `float`, `double` and `long double`. It is possible that all three are implemented as IEEE double-precision. Nevertheless, for most architectures (gcc, MSVC; x86, x64, ARM) `float` <em>is</em> indeed a IEEE single-precision floating point number (binary32), and `double` <em>is</em> a IEEE double-precision floating point number (binary64).</sup>  

#### Answer 2 (score 54)
Here is what the standard C99 (ISO-IEC 9899 6.2.5 §10) or C++2003 (ISO-IEC 14882-2003 3.1.9 §8) standards say:  

<blockquote>
  There are three floating point types: `float`, `double`, and `long double`. The type `double` provides at least as much precision as `float`, and the type `long double` provides at least as much precision as `double`. The set of values of the type `float` is a subset of the set of values of the type `double`; the set of values of the type `double` is a subset of the set of values of the type `long double`.  
</blockquote>

The C++ standard adds:  

<blockquote>
  The value representation of floating-point types is implementation-defined.  
</blockquote>

I would suggest having a look at the excellent <a href="http://docs.sun.com/source/806-3568/ncg_goldberg.html" rel="noreferrer">What Every Computer Scientist Should Know About Floating-Point Arithmetic</a> that covers the IEEE floating-point standard in depth. You'll learn about the representation details and you'll realize there is a tradeoff between magnitude and precision. The precision of the floating point representation increases as the magnitude decreases, hence floating point numbers between -1 and 1 are those with the most precision.  

#### Answer 3 (score 26)
Given a quadratic equation: <em>x</em><sup>2</sup>&nbsp;&minus;&nbsp;4.0000000&nbsp;<em>x</em>&nbsp;+&nbsp;3.9999999&nbsp;=&nbsp;0, the exact roots to 10 significant digits are, <em>r</em><sub>1</sub>&nbsp;=&nbsp;2.000316228 and <em>r</em><sub>2</sub>&nbsp;=&nbsp;1.999683772.  

Using `float` and `double`, we can write a test program:  

```c
#include <stdio.h>
#include <math.h>

void dbl_solve(double a, double b, double c)
{
    double d = b*b - 4.0*a*c;
    double sd = sqrt(d);
    double r1 = (-b + sd) / (2.0*a);
    double r2 = (-b - sd) / (2.0*a);
    printf("%.5f\t%.5f\n", r1, r2);
}

void flt_solve(float a, float b, float c)
{
    float d = b*b - 4.0f*a*c;
    float sd = sqrtf(d);
    float r1 = (-b + sd) / (2.0f*a);
    float r2 = (-b - sd) / (2.0f*a);
    printf("%.5f\t%.5f\n", r1, r2);
}   

int main(void)
{
    float fa = 1.0f;
    float fb = -4.0000000f;
    float fc = 3.9999999f;
    double da = 1.0;
    double db = -4.0000000;
    double dc = 3.9999999;
    flt_solve(fa, fb, fc);
    dbl_solve(da, db, dc);
    return 0;
}  
```

Running the program gives me:  

```c
2.00000 2.00000
2.00032 1.99968
```

Note that the numbers aren't large, but still you get cancellation effects using `float`.  

(In fact, the above is not the best way of solving quadratic equations using either single- or double-precision floating-point numbers, but the answer remains unchanged even if one uses a <a href="http://en.wikipedia.org/wiki/Quadratic_equation#Floating_point_implementation" rel="noreferrer">more stable method</a>.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: Correct format specifier for double in printf (score [936300](https://stackoverflow.com/q/4264127) in 2019)

#### Question
What is the correct format specifier for `double` in printf? Is it `%f` or is it `%lf`? I believe it's `%f`, but I am not sure.  

<h5>Code sample</h3>

```c
#include <stdio.h>

int main()
{
   double d = 1.4;
   printf("%lf", d); // Is this wrong?
}
```

#### Answer accepted (score 576)
`"%f"` is the (or at least one) correct format for a double. There <em>is</em> no format for a `float`, because if you attempt to pass a `float` to `printf`, it'll be promoted to `double` before `printf` receives it<sup>1</sup>. `"%lf"` is also acceptable under the current standard -- the `l` is specified as having no effect if followed by the `f` conversion specifier (among others).  

Note that this is one place that `printf` format strings differ substantially from `scanf` (and `fscanf`, etc.) format strings. For output, you're passing a <em>value</em>, which will be promoted from `float` to `double` when passed as a variadic parameter. For input you're passing a <em>pointer</em>, which is not promoted, so you have to tell `scanf` whether you want to read a `float` or a `double`, so for `scanf`, `%f` means you want to read a `float` and `%lf` means you want to read a `double` (and, for what it's worth, for a `long double`, you use `%Lf` for either `printf` or `scanf`).  

<hr>

<p><sub>
1. C99, §6.5.2.2/6: "If the expression that denotes the called function has a type that does not include a prototype, the integer promotions are performed on each argument, and arguments that have type float are promoted to double. These are called the default argument promotions." In C++ the wording is somewhat different (e.g., it doesn't use the word "prototype") but the effect is the same: all the variadic parameters undergo default promotions before they're received by the function.
</sub></p>

#### Answer 2 (score 61)
<p>Given the <a href="http://en.wikipedia.org/wiki/C99" rel="noreferrer">C99</a> standard (namely, the <em>N1256</em> draft), the rules depend on the
function kind: fprintf (printf, sprintf, ...) or scanf.</p>

Here are relevant parts extracted:  

<blockquote>
  <strong>Foreword</strong>  
  
  <p>This second edition cancels and replaces the first edition, ISO/IEC 9899:1990, as amended and corrected by ISO/IEC 9899/COR1:1994, ISO/IEC 9899/AMD1:1995, and ISO/IEC 9899/COR2:1996.
  Major changes from the previous edition include:</p>
  
  <ul>
  <li>`%lf` conversion specifier allowed in `printf`</li>
  </ul>
  
  <strong>7.19.6.1 The `fprintf` function</strong>  
  
  <strong>7</strong> The length modifiers and their meanings are:  
  
  <em>l</em> (ell) Specifies that (...) has no effect on a following a, A, e, E, f, F, g, or G conversion specifier.  
  
  <em>L</em> Specifies that a following a, A, e, E, f, F, g, or G conversion specifier applies to a long double argument.  
</blockquote>

The same rules specified for `fprintf` apply for `printf`, `sprintf` and similar functions.  

<blockquote>
  <strong>7.19.6.2 The `fscanf` function</strong>  
  
  <strong>11</strong> The length modifiers and their meanings are:  
  
  <em>l</em> (ell) Specifies that (...) that a following a, A, e, E, f, F, g, or G conversion specifier applies to an argument with type pointer to double;  
  
  <p><em>L</em> Specifies that a following a, A, e, E, f, F, g, or G conversion
  specifier applies to an argument with type pointer to long double.</p>
  
  <p><strong>12</strong> The conversion specifiers and their meanings are:
       a,e,f,g Matches an optionally signed floating-point number, (...)</p>
  
  <strong>14</strong> The conversion specifiers A, E, F, G, and X are also valid and behave the same as, respectively, a, e, f, g, and x.  
</blockquote>

The long story short, for `fprintf` the following specifiers and corresponding types are specified:  

<ul>
<li>`%f`  -> double</li>
<li>`%Lf` -> long double.</li>
</ul>

and for `fscanf` it is:  

<ul>
<li>`%f`  -> float</li>
<li>`%lf` -> double</li>
<li>`%Lf` -> long double.</li>
</ul>

#### Answer 3 (score 20)
It can be `%f`, `%g` or `%e` depending on how you want the number to be formatted. See <a href="http://en.wikipedia.org/wiki/Printf">here</a> for more details. The `l` modifier is required in `scanf` with `double`, but not in `printf`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: C: What is the difference between ++i and i++? (score [933182](https://stackoverflow.com/q/24853) in 2019)

#### Question
In C, what is the difference between using `++i` and `i++`, and which should be used in the incrementation block of a `for` loop?  

#### Answer accepted (score 985)
<ul>
<li><p>`++i` will increment the value of `i`, and then return the incremented value.</p>

```c
 i = 1;
 j = ++i;
 (i is 2, j is 2)
```</li>
<li><p>`i++` will increment the value of `i`, but return the original value that `i` held before being incremented.</p>

```c
 i = 1;
 j = i++;
 (i is 2, j is 1)
```</li>
</ul>

For a `for` loop, either works. `++i` seems more common, perhaps because that is what is used in <a href="https://en.wikipedia.org/wiki/The_C_Programming_Language" rel="noreferrer">K&amp;R</a>.  

In any case, follow the guideline "prefer `++i` over `i++`" and you won't go wrong.  

There's a couple of comments regarding the efficiency of `++i` and `i++`. In any non-student-project compiler, there will be no performance difference.  You can verify this by looking at the generated code, which will be identical.  

<p>The efficiency question is interesting... here's my attempt at an answer:
<a href="https://stackoverflow.com/questions/24886/is-there-a-performance-difference-between-i-and-i">Is there a performance difference between i++ and ++i in C?</a></p>

As <em>On Freund</em> notes, it's different for a C++ object, since `operator++()` is a function and the compiler can't know to optimize away the creation of a temporary object to hold the intermediate value.  

#### Answer 2 (score 159)
<strong>i++</strong> is known as <strong>Post Increment</strong> whereas <strong>++i</strong> is called <strong>Pre Increment.</strong>  

<strong>`i++`</strong>  

`i++` is post increment because it increments `i`'s value by 1 after the operation is over.  

Lets see the following example:  

```c
int i = 1, j;
j = i++;
```

Here value of `j = 1` but `i = 2`. Here value of `i` will be assigned to `j` first then `i` will be incremented.  

<strong>`++i`</strong>   

<p>`++i` is pre increment because it increments `i`'s value by 1 before the operation.
It means `j = i;` will execute after `i++`. </p>

Lets see the following example:  

```c
int i = 1, j;
j = ++i;
```

<p>Here value of `j = 2` but `i = 2`. Here value of `i` will be assigned to `j` after the `i`  incremention of `i`.
Similarly `++i` will be executed before `j=i;`.</p>

For your question  <strong>which should be used in the incrementation block of a for loop?</strong> the answer is, you can use any one.. doesn't matter. It will execute your for loop same no. of times.  

```c
for(i=0; i<5; i++)
   printf("%d ",i);
```

And  

```c
for(i=0; i<5; ++i)
   printf("%d ",i);
```

Both the loops will produce same output. ie `0 1 2 3 4`.  

It only matters where you are using it.  

```c
for(i = 0; i<5;)
    printf("%d ",++i);
```

In this case output will be `1 2 3 4 5`.  

#### Answer 3 (score 38)
Please don't worry about the "efficiency" (speed, really) of which one is faster.  We have compilers these days that take care of these things.  Use whichever one makes sense to use, based on which more clearly shows your intent.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How do I create an array of strings in C? (score [916965](https://stackoverflow.com/q/1088622) in 2018)

#### Question
I am trying to create an array of strings in C.  If I use this code:  

```c
char (*a[2])[14];
a[0]="blah";
a[1]="hmm";
```

gcc gives me "warning: assignment from incompatible pointer type".  What is the correct way to do this?  

edit: I am curious why this should give a compiler warning since if I do `printf(a[1]);`, it correctly prints "hmm".  

#### Answer 2 (score 211)
If you don't want to change the strings, then you could simply do  

```c
const char *a[2];
a[0] = "blah";
a[1] = "hmm";
```

When you do it like this you will allocate an array of two pointers to `const char`. These pointers will then be set to the addresses of the static strings `"blah"` and `"hmm"`.  

If you do want to be able to change the actual string content, the you have to do something like  

```c
char a[2][14];
strcpy(a[0], "blah");
strcpy(a[1], "hmm");
```

This will allocate two consecutive arrays of 14 `char`s each, after which the content of the static strings will be copied into them.  

#### Answer 3 (score 167)
There are several ways to create an array of strings in C.  If all the strings are going to be the same length (or at least have the same maximum length), you simply declare a 2-d array of char and assign as necessary:  

```c
char strs[NUMBER_OF_STRINGS][STRING_LENGTH+1];
...
strcpy(strs[0], aString); // where aString is either an array or pointer to char
strcpy(strs[1], "foo");
```

You can add a list of initializers as well:  

```c
char strs[NUMBER_OF_STRINGS][STRING_LENGTH+1] = {"foo", "bar", "bletch", ...};
```

This assumes the size and number of strings in the initializer match up with your array dimensions.  In this case, the contents of each string literal (which is itself a zero-terminated array of char) are copied to the memory allocated to strs.  The problem with this approach is the possibility of internal fragmentation; if you have 99 strings that are 5 characters or less, but 1 string that's 20 characters long, 99 strings are going to have at least 15 unused characters; that's a waste of space.  

Instead of using a 2-d array of char, you can store a 1-d array of pointers to char:  

```c
char *strs[NUMBER_OF_STRINGS];
```

Note that in this case, you've only allocated memory to hold the pointers to the strings; the memory for the strings themselves must be allocated elsewhere (either as static arrays or by using `malloc()` or `calloc()`).  You can use the initializer list like the earlier example:  

```c
char *strs[NUMBER_OF_STRINGS] = {"foo", "bar", "bletch", ...};
```

Instead of copying the contents of the string constants, you're simply storing the pointers to them.  Note that string constants may not be writable; you can reassign the pointer, like so:  

```c
strs[i] = "bar";
strs[i] = "foo"; 
```

But you may not be able to change the string's contents; i.e.,  

```c
strs[i] = "bar";
strcpy(strs[i], "foo");
```

may not be allowed.    

You can use `malloc()` to dynamically allocate the buffer for each string and copy to that buffer:  

```c
strs[i] = malloc(strlen("foo") + 1);
strcpy(strs[i], "foo");
```

BTW,   

```c
char (*a[2])[14];
```

Declares a as a 2-element array of pointers to 14-element arrays of char.    

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How to convert a string to integer in C? (score [897704](https://stackoverflow.com/q/7021725) in 2018)

#### Question
I am trying to find out if there is an alternative way of converting string to integer in C.  

I regularly pattern the following in my code.  

```c
char s[] = "45";

int num = atoi(s);
```

So, is there a better way or another way?  

#### Answer accepted (score 165)
There is <a href="http://en.cppreference.com/w/c/string/byte/strtol" rel="noreferrer">`strtol`</a> which is better IMO. Also I have taken a liking in <a href="http://www.freebsd.org/cgi/man.cgi?query=strtonum" rel="noreferrer">`strtonum`</a>, so use it if you have it (but remember it's not portable):  

```c
long long
     strtonum(const char *nptr, long long minval, long long maxval,
     const char **errstr);
```

<h5>EDIT</h3>

You might also be interested in <a href="http://en.cppreference.com/w/c/string/byte/strtoimax" rel="noreferrer">`strtoumax` and `strtoimax`</a> which are standard functions in C99. For example you could say:  

```c
uintmax_t num = strtoumax(s, NULL, 10);
if (num == UINTMAX_MAX && errno == ERANGE)
    /* Could not convert. */
```

Anyway, stay away from `atoi`:  

<blockquote>
  The call atoi(str) shall be equivalent to:  

```c
(int) strtol(str, (char **)NULL, 10)
```
  
  <p>except that the handling of errors may differ. <strong>If the value cannot be
  represented, the behavior is undefined</strong>.</p>
</blockquote>

#### Answer 2 (score 24)
<strong>Robust C89 `strtol`-based solution</strong>  

With:  

<ul>
<li>no undefined behavior (as could be had with the `atoi` family)</li>
<li>a stricter definition of integer than `strtol` (e.g. no leading whitespace nor trailing trash chars)</li>
<li>classification of the error case (e.g. to give useful error messages to users)</li>
<li>a "testsuite"</li>
</ul>



```c
#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

typedef enum {
    STR2INT_SUCCESS,
    STR2INT_OVERFLOW,
    STR2INT_UNDERFLOW,
    STR2INT_INCONVERTIBLE
} str2int_errno;

/* Convert string s to int out.
 *
 * @param[out] out The converted int. Cannot be NULL.
 *
 * @param[in] s Input string to be converted.
 *
 *     The format is the same as strtol,
 *     except that the following are inconvertible:
 *
 *     - empty string
 *     - leading whitespace
 *     - any trailing characters that are not part of the number
 *
 *     Cannot be NULL.
 *
 * @param[in] base Base to interpret string in. Same range as strtol (2 to 36).
 *
 * @return Indicates if the operation succeeded, or why it failed.
 */
str2int_errno str2int(int *out, char *s, int base) {
    char *end;
    if (s[0] == '\0' || isspace(s[0]))
        return STR2INT_INCONVERTIBLE;
    errno = 0;
    long l = strtol(s, &end, base);
    /* Both checks are needed because INT_MAX == LONG_MAX is possible. */
    if (l > INT_MAX || (errno == ERANGE && l == LONG_MAX))
        return STR2INT_OVERFLOW;
    if (l < INT_MIN || (errno == ERANGE && l == LONG_MIN))
        return STR2INT_UNDERFLOW;
    if (*end != '\0')
        return STR2INT_INCONVERTIBLE;
    *out = l;
    return STR2INT_SUCCESS;
}

int main(void) {
    int i;
    /* Lazy to calculate this size properly. */
    char s[256];

    /* Simple case. */
    assert(str2int(&i, "11", 10) == STR2INT_SUCCESS);
    assert(i == 11);

    /* Negative number . */
    assert(str2int(&i, "-11", 10) == STR2INT_SUCCESS);
    assert(i == -11);

    /* Different base. */
    assert(str2int(&i, "11", 16) == STR2INT_SUCCESS);
    assert(i == 17);

    /* 0 */
    assert(str2int(&i, "0", 10) == STR2INT_SUCCESS);
    assert(i == 0);

    /* INT_MAX. */
    sprintf(s, "%d", INT_MAX);
    assert(str2int(&i, s, 10) == STR2INT_SUCCESS);
    assert(i == INT_MAX);

    /* INT_MIN. */
    sprintf(s, "%d", INT_MIN);
    assert(str2int(&i, s, 10) == STR2INT_SUCCESS);
    assert(i == INT_MIN);

    /* Leading and trailing space. */
    assert(str2int(&i, " 1", 10) == STR2INT_INCONVERTIBLE);
    assert(str2int(&i, "1 ", 10) == STR2INT_INCONVERTIBLE);

    /* Trash characters. */
    assert(str2int(&i, "a10", 10) == STR2INT_INCONVERTIBLE);
    assert(str2int(&i, "10a", 10) == STR2INT_INCONVERTIBLE);

    /* int overflow.
     *
     * `if` needed to avoid undefined behaviour
     * on `INT_MAX + 1` if INT_MAX == LONG_MAX.
     */
    if (INT_MAX < LONG_MAX) {
        sprintf(s, "%ld", (long int)INT_MAX + 1L);
        assert(str2int(&i, s, 10) == STR2INT_OVERFLOW);
    }

    /* int underflow */
    if (LONG_MIN < INT_MIN) {
        sprintf(s, "%ld", (long int)INT_MIN - 1L);
        assert(str2int(&i, s, 10) == STR2INT_UNDERFLOW);
    }

    /* long overflow */
    sprintf(s, "%ld0", LONG_MAX);
    assert(str2int(&i, s, 10) == STR2INT_OVERFLOW);

    /* long underflow */
    sprintf(s, "%ld0", LONG_MIN);
    assert(str2int(&i, s, 10) == STR2INT_UNDERFLOW);

    return EXIT_SUCCESS;
}
```

<a href="https://github.com/cirosantilli/cpp-cheat/blob/c6087065b6b499b949360830aa2edeb4ec2ab276/c/string_to_int.c" rel="nofollow noreferrer">GitHub upstream</a>.  

Based on: <a href="https://stackoverflow.com/a/6154614/895245">https://stackoverflow.com/a/6154614/895245</a>  

#### Answer 3 (score 22)
Don't use functions from `ato...` group. These are broken and virtually useless. A moderately better solution would be to use `sscanf`, although it is not perfect either.  

To convert string to integer, functions from `strto...` group should be used. In your specific case it would be `strtol` function.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: max value of integer (score [847436](https://stackoverflow.com/q/15004944) in 2017)

#### Question
<p>In C, the integer (for 32 bit machine) is 32 bits, and it ranges from -32,768 to +32,767.
In Java, the integer is also 32 bits, but ranges from -2,147,483,648 to +2,147,483,647.</p>

I do not understand how the range is different in Java, even though the number of bits is the same. Can someone explain this?  

#### Answer 2 (score 356)
<strong>In <em>C</em>,</strong> the language itself does not determine the representation of certain datatypes. It can vary from machine to machine, on embedded systems the `int` can be 16 bit wide, though usually it is 32 bit.   

The only requirement is that `short int` &lt;= `int` &lt;= `long int` by size. Also, there is a recommendation that <strong>`int` should represent the native capacity of the processor</strong>.  

All types are signed. The `unsigned` modifier allows you to use the highest bit as part of the value (otherwise it is reserved for the sign bit).  

Here's a short table of the possible values for the possible data types:  

```c
          width                     minimum                         maximum
signed    8 bit                        -128                            +127
signed   16 bit                     -32 768                         +32 767
signed   32 bit              -2 147 483 648                  +2 147 483 647
signed   64 bit  -9 223 372 036 854 775 808      +9 223 372 036 854 775 807
unsigned  8 bit                           0                            +255
unsigned 16 bit                           0                         +65 535
unsigned 32 bit                           0                  +4 294 967 295
unsigned 64 bit                           0     +18 446 744 073 709 551 615
```

<strong>In <em>Java</em>,</strong> the <a href="https://docs.oracle.com/javase/specs/jls/se7/html/jls-4.html#jls-4.2" rel="noreferrer">Java Language Specification</a> determines the representation of the data types.  

The order is: `byte` 8 bits, `short` 16 bits, `int` 32 bits, `long` 64 bits. All of these types are <em>signed</em>, there are no unsigned versions. However, bit manipulations treat the numbers as they were unsigned (that is, handling all bits correctly).  

The character data type `char` is 16 bits wide, <em>unsigned</em>, and holds characters using UTF-16 encoding (however, it is possible to assign a `char` an arbitrary unsigned 16 bit integer that represents an invalid character codepoint)  

```c
          width                     minimum                         maximum

SIGNED
byte:     8 bit                        -128                            +127
short:   16 bit                     -32 768                         +32 767
int:     32 bit              -2 147 483 648                  +2 147 483 647
long:    64 bit  -9 223 372 036 854 775 808      +9 223 372 036 854 775 807

UNSIGNED
char     16 bit                           0                         +65 535
```

#### Answer 3 (score 71)
<blockquote>
  In C, the integer(for 32 bit machine) is 32 bit and it ranges from -32768 to +32767.  
</blockquote>

Wrong. 32-bit signed integer in 2's complement representation has the range -2<sup>31</sup> to 2<sup>31</sup>-1 which is equal to  -2,147,483,648 to 2,147,483,647.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: What does "static" mean in C? (score [846258](https://stackoverflow.com/q/572547) in 2017)

#### Question
I've seen the word `static` used in different places in C code; is this like a static function/class in C# (where the implementation is shared across objects)?    

#### Answer accepted (score 1425)
<ol>
<li>A static variable inside a function keeps its value between invocations.</li>
<li>A static global variable or a function is "seen" only in the file it's declared in</li>
</ol>

(1) is the more foreign topic if you're a newbie, so here's an example:  

```c
#include <stdio.h>

void foo()
{
    int a = 10;
    static int sa = 10;

    a += 5;
    sa += 5;

    printf("a = %d, sa = %d\n", a, sa);
}


int main()
{
    int i;

    for (i = 0; i < 10; ++i)
        foo();
}
```

This prints:  

```c
a = 15, sa = 15
a = 15, sa = 20
a = 15, sa = 25
a = 15, sa = 30
a = 15, sa = 35
a = 15, sa = 40
a = 15, sa = 45
a = 15, sa = 50
a = 15, sa = 55
a = 15, sa = 60
```

This is useful for cases where a function needs to keep some state between invocations, and you don't want to use global variables. Beware, however, this feature should be used very sparingly - it makes your code not thread-safe and harder to understand.  

(2) Is used widely as an "access control" feature. If you have a .c file implementing some functionality, it usually exposes only a few "public" functions to users. The rest of its functions should be made `static`, so that the user won't be able to access them. This is encapsulation, a good practice.  

Quoting <a href="http://en.wikipedia.org/wiki/Static_variable" rel="noreferrer">Wikipedia</a>:  

<blockquote>
  <p>In the C programming language, static
  is used with global variables and
  functions to set their scope to the
  containing file. In local variables,
  static is used to store the variable
  in the statically allocated memory
  instead of the automatically allocated
  memory. While the language does not
  dictate the implementation of either
  type of memory, statically allocated
  memory is typically reserved in data
  segment of the program at compile
  time, while the automatically
  allocated memory is normally
  implemented as a transient call stack.</p>
</blockquote>

See <a href="http://os.camden.rutgers.edu/c_resources/c_manual/C/CONCEPT/storage_class.html" rel="noreferrer">here</a> and <a href="http://os.camden.rutgers.edu/c_resources/c_manual/C/SYNTAX/static.htm" rel="noreferrer">here</a> for more details.  

And to answer your second question, it's not like in C#.  

In C++, however, `static` is also used to define class attributes (shared between all objects of the same class) and methods. In C there are no classes, so this feature is irrelevant.  

#### Answer 2 (score 217)
There is one more use not covered here, and that is as part of an array type declaration as an argument to a function:  

```c
int someFunction(char arg[static 10])
{
    ...
}
```

In this context, this specifies that arguments passed to this function must be an array of type `char` with at least 10 elements in it. For more info see my question <a href="https://stackoverflow.com/questions/3430315/purpose-of-static-keyword-in-array-parameter-of-function">here</a>.  

#### Answer 3 (score 160)
Short answer ... <strong>it depends.</strong>  

<ol>
<li><p>Static defined local variables do not lose their value between function calls. In other words they are global variables, but scoped to the local function they are defined in.</p></li>
<li><p>Static global variables are not visible outside of the C file they are defined in.</p></li>
<li><p>Static functions are not visible outside of the C file they are defined in.</p></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: How can I get the list of files in a directory using C or C++? (score [806406](https://stackoverflow.com/q/612097) in 2018)

#### Question
How can I determine the list of files in a directory from inside my C or C++ code?  

I'm not allowed to execute the `ls` command and parse the results from within my program.  

#### Answer accepted (score 749)
In small and simple tasks I do not use boost, I use <strong>dirent.h</strong> which is also available for windows:  

```c
DIR *dir;
struct dirent *ent;
if ((dir = opendir ("c:\\src\\")) != NULL) {
  /* print all the files and directories within directory */
  while ((ent = readdir (dir)) != NULL) {
    printf ("%s\n", ent->d_name);
  }
  closedir (dir);
} else {
  /* could not open directory */
  perror ("");
  return EXIT_FAILURE;
}
```

It is just a small header file and does most of the simple stuff you need without using a big template-based approach like boost(no offence, I like boost!).  

The author of the windows compatibility layer is Toni Ronkko. In Unix, it is a standard header.  

<strong>UPDATE 2017</strong>:  

In C++17 there is now an official way to list files of your file system: `std::filesystem`. There is an excellent answer from <a href="https://stackoverflow.com/a/37494654/23264"><strong>Shreevardhan</strong></a> below with this source code:  

```c
#include <string>
#include <iostream>
#include <filesystem>
namespace fs = std::filesystem;

int main()
{
    std::string path = "/path/to/directory";
    for (const auto & entry : fs::directory_iterator(path))
        std::cout << entry.path() << std::endl;
}
```

#### Answer 2 (score 285)
C++17 now has a <a href="http://en.cppreference.com/w/cpp/filesystem/directory_iterator" rel="noreferrer">`std::filesystem::directory_iterator`</a>, which can be used as  

```c
#include <string>
#include <iostream>
#include <filesystem>
namespace fs = std::filesystem;

int main() {
    std::string path = "/path/to/directory";
    for (const auto & entry : fs::directory_iterator(path))
        std::cout << entry.path() << std::endl;
}
```

Also, <a href="http://en.cppreference.com/w/cpp/filesystem/recursive_directory_iterator" rel="noreferrer">`std::filesystem::recursive_directory_iterator`</a> can iterate the subdirectories as well.  

#### Answer 3 (score 227)
Unfortunately the C++ standard does not define a standard way of working with files and folders in this way.   

Since there is no cross platform way, the best cross platform way is to use a library such as the <a href="http://www.boost.org/doc/libs/1_38_0/libs/filesystem/doc/index.htm" rel="noreferrer">boost filesystem module</a>.  

<strong>Cross platform boost method:</strong>  

<blockquote>
  The following function, given a directory path and a file name, recursively searches the directory and its sub-directories for the file name, returning a bool, and if successful, the path to the file that was found.   

```c
bool find_file(const path & dir_path,         // in this directory,
               const std::string & file_name, // search for this name,
               path & path_found)             // placing path here if found
{
    if (!exists(dir_path)) 
        return false;

    directory_iterator end_itr; // default construction yields past-the-end

    for (directory_iterator itr(dir_path); itr != end_itr; ++itr)
    {
        if (is_directory(itr->status()))
        {
            if (find_file(itr->path(), file_name, path_found)) 
                return true;
        }
        else if (itr->leaf() == file_name) // see below
        {
            path_found = itr->path();
            return true;
        }
    }
    return false;
}
```
</blockquote>

Source from the boost page mentioned above.  

<strong>For Unix/Linux based systems:</strong>   

You can use <a href="http://www.manpagez.com/man/3/opendir/" rel="noreferrer">opendir</a> / <a href="http://www.manpagez.com/man/3/readdir/" rel="noreferrer">readdir</a> / <a href="http://www.manpagez.com/man/3/closedir/" rel="noreferrer">closedir</a>.   

<blockquote>
  Sample code which searches a directory for entry ``name'' is:  

```c
len = strlen(name);
dirp = opendir(".");
while ((dp = readdir(dirp)) != NULL)
        if (dp->d_namlen == len && !strcmp(dp->d_name, name)) {
                (void)closedir(dirp);
                return FOUND;
        }
(void)closedir(dirp);
return NOT_FOUND;
```
</blockquote>

Source code from the above man pages.  

<strong>For a windows based systems:</strong>   

You can use the Win32 API <a href="http://msdn.microsoft.com/en-us/library/aa364418(VS.85).aspx" rel="noreferrer">FindFirstFile</a> / <a href="http://msdn.microsoft.com/en-us/library/aa364428(VS.85).aspx" rel="noreferrer">FindNextFile</a> / <a href="http://msdn.microsoft.com/en-us/library/aa364413(VS.85).aspx" rel="noreferrer">FindClose</a> functions.  

<blockquote>
  The following C++ example shows you a minimal use of FindFirstFile.  

```c
#include <windows.h>
#include <tchar.h>
#include <stdio.h>

void _tmain(int argc, TCHAR *argv[])
{
   WIN32_FIND_DATA FindFileData;
   HANDLE hFind;

   if( argc != 2 )
   {
      _tprintf(TEXT("Usage: %s [target_file]\n"), argv[0]);
      return;
   }

   _tprintf (TEXT("Target file is %s\n"), argv[1]);
   hFind = FindFirstFile(argv[1], &FindFileData);
   if (hFind == INVALID_HANDLE_VALUE) 
   {
      printf ("FindFirstFile failed (%d)\n", GetLastError());
      return;
   } 
   else 
   {
      _tprintf (TEXT("The first file found is %s\n"), 
                FindFileData.cFileName);
      FindClose(hFind);
   }
}
```
</blockquote>

Source code from the above msdn pages.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: How do function pointers in C work? (score [766864](https://stackoverflow.com/q/840501) in )

#### Question
I had some experience lately with function pointers in C.  

So going on with the tradition of answering your own questions, I decided to make a small summary of the very basics, for those who need a quick dive-in to the subject.  

#### Answer accepted (score 1396)
<h5>Function pointers in C</h1>

Let's start with a basic function which we will be <em>pointing to</em>:  

```c
int addInt(int n, int m) {
    return n+m;
}
```

First thing, let's define a pointer to a function which receives 2 `int`s and returns an `int`:  

```c
int (*functionPtr)(int,int);
```

Now we can safely point to our function:  

```c
functionPtr = &addInt;
```

Now that we have a pointer to the function, let's use it:  

```c
int sum = (*functionPtr)(2, 3); // sum == 5
```

Passing the pointer to another function is basically the same:  

```c
int add2to3(int (*functionPtr)(int, int)) {
    return (*functionPtr)(2, 3);
}
```

We can use function pointers in return values as well (try to keep up, it gets messy):  

```c
// this is a function called functionFactory which receives parameter n
// and returns a pointer to another function which receives two ints
// and it returns another int
int (*functionFactory(int n))(int, int) {
    printf("Got parameter %d", n);
    int (*functionPtr)(int,int) = &addInt;
    return functionPtr;
}
```

But it's much nicer to use a `typedef`:  

```c
typedef int (*myFuncDef)(int, int);
// note that the typedef name is indeed myFuncDef

myFuncDef functionFactory(int n) {
    printf("Got parameter %d", n);
    myFuncDef functionPtr = &addInt;
    return functionPtr;
}
```

#### Answer 2 (score 292)
<strong>Function pointers in C can be used to perform object-oriented programming in C.</strong>  

For example, the following lines is written in C:  

```c
String s1 = newString();
s1->set(s1, "hello");
```

Yes, the `-&gt;` and the lack of a `new` operator is a dead give away, but it sure seems to imply that we're setting the text of some `String` class to be `"hello"`.  

By using function pointers, <strong>it is possible to emulate methods in C</strong>.  

How is this accomplished?  

The `String` class is actually a `struct` with a bunch of function pointers which act as a way to simulate methods. The following is a partial declaration of the `String` class:  

```c
typedef struct String_Struct* String;

struct String_Struct
{
    char* (*get)(const void* self);
    void (*set)(const void* self, char* value);
    int (*length)(const void* self);
};

char* getString(const void* self);
void setString(const void* self, char* value);
int lengthString(const void* self);

String newString();
```

As can be seen, the methods of the `String` class are actually function pointers to the declared function. In preparing the instance of the `String`, the `newString` function is called in order to set up the function pointers to their respective functions:  

```c
String newString()
{
    String self = (String)malloc(sizeof(struct String_Struct));

    self->get = &getString;
    self->set = &setString;
    self->length = &lengthString;

    self->set(self, "");

    return self;
}
```

For example, the `getString` function that is called by invoking the `get` method is defined as the following:  

```c
char* getString(const void* self_obj)
{
    return ((String)self_obj)->internal->value;
}
```

One thing that can be noticed is that there is no concept of an instance of an object and having methods that are actually a part of an object, so a "self object" must be passed in on each invocation. (And the `internal` is just a hidden `struct` which was omitted from the code listing earlier -- it is a way of performing information hiding, but that is not relevant to function pointers.)  

So, rather than being able to do `s1-&gt;set("hello");`, one must pass in the object to perform the action on `s1-&gt;set(s1, "hello")`.   

With that minor explanation having to pass in a reference to yourself out of the way, we'll move to the next part, which is <strong>inheritance in C</strong>.  

Let's say we want to make a subclass of `String`, say an `ImmutableString`. In order to make the string immutable, the `set` method will not be accessible, while maintaining access to `get` and `length`, and force the "constructor" to accept a `char*`:  

```c
typedef struct ImmutableString_Struct* ImmutableString;

struct ImmutableString_Struct
{
    String base;

    char* (*get)(const void* self);
    int (*length)(const void* self);
};

ImmutableString newImmutableString(const char* value);
```

Basically, for all subclasses, the available methods are once again function pointers. This time, the declaration for the `set` method is not present, therefore, it cannot be called in a `ImmutableString`.  

As for the implementation of the `ImmutableString`, the only relevant code is the "constructor" function, the `newImmutableString`:  

```c
ImmutableString newImmutableString(const char* value)
{
    ImmutableString self = (ImmutableString)malloc(sizeof(struct ImmutableString_Struct));

    self->base = newString();

    self->get = self->base->get;
    self->length = self->base->length;

    self->base->set(self->base, (char*)value);

    return self;
}
```

In instantiating the `ImmutableString`, the function pointers to the `get` and `length` methods actually refer to the `String.get` and `String.length` method, by going through the `base` variable which is an internally stored `String` object.  

The use of a function pointer can achieve inheritance of a method from a superclass.  

We can further continue to <strong>polymorphism in C</strong>.  

If for example we wanted to change the behavior of the `length` method to return `0` all the time in the `ImmutableString` class for some reason, all that would have to be done is to:  

<ol>
<li>Add a function that is going to serve as the overriding `length` method.</li>
<li>Go to the "constructor" and set the function pointer to the overriding `length` method.</li>
</ol>

Adding an overriding `length` method in `ImmutableString` may be performed by adding an `lengthOverrideMethod`:  

```c
int lengthOverrideMethod(const void* self)
{
    return 0;
}
```

Then, the function pointer for the `length` method in the constructor is hooked up to the `lengthOverrideMethod`:  

```c
ImmutableString newImmutableString(const char* value)
{
    ImmutableString self = (ImmutableString)malloc(sizeof(struct ImmutableString_Struct));

    self->base = newString();

    self->get = self->base->get;
    self->length = &lengthOverrideMethod;

    self->base->set(self->base, (char*)value);

    return self;
}
```

Now, rather than having an identical behavior for the `length` method in `ImmutableString` class as the `String` class, now the `length` method will refer to the behavior defined in the `lengthOverrideMethod` function.  

I must add a disclaimer that I am still learning how to write with an object-oriented programming style in C, so there probably are points that I didn't explain well, or may just be off mark in terms of how best to implement OOP in C. But my purpose was to try to illustrate one of many uses of function pointers.  

For more information on how to perform object-oriented programming in C, please refer to the following questions:  

<ul>
<li><a href="https://stackoverflow.com/questions/415452/object-orientation-in-c">Object-Orientation in C?</a></li>
<li><a href="https://stackoverflow.com/questions/351733/can-you-write-object-oriented-code-in-c">Can you write object oriented code in C?</a></li>
</ul>

#### Answer 3 (score 218)
The guide to getting fired: How to abuse function pointers in GCC on x86 machines by compiling your code by hand:  

These string literals are bytes of 32-bit x86 machine code.  `0xC3` is <a href="http://felixcloutier.com/x86/RET.html" rel="noreferrer">an x86 `ret` instruction</a>.  

You wouldn't normally write these by hand, you'd write in assembly language and then use an assembler like `nasm` to assemble it into a flat binary which you hexdump into a C string literal.  

<ol>
<li><p>Returns the current value on the EAX register</p>

```c
int eax = ((int(*)())("\xc3 <- This returns the value of the EAX register"))();
```</li>
<li><p>Write a swap function</p>

```c
int a = 10, b = 20;
((void(*)(int*,int*))"\x8b\x44\x24\x04\x8b\x5c\x24\x08\x8b\x00\x8b\x1b\x31\xc3\x31\xd8\x31\xc3\x8b\x4c\x24\x04\x89\x01\x8b\x4c\x24\x08\x89\x19\xc3 <- This swaps the values of a and b")(&a,&b);
```</li>
<li><p>Write a for-loop counter to 1000, calling some function each time</p>

```c
((int(*)())"\x66\x31\xc0\x8b\x5c\x24\x04\x66\x40\x50\xff\xd3\x58\x66\x3d\xe8\x03\x75\xf4\xc3")(&function); // calls function with 1->1000
```</li>
<li><p>You can even write a recursive function that counts to 100</p>

```c
const char* lol = "\x8b\x5c\x24\x4\x3d\xe8\x3\x0\x0\x7e\x2\x31\xc0\x83\xf8\x64\x7d\x6\x40\x53\xff\xd3\x5b\xc3\xc3 <- Recursively calls the function at address lol.";
i = ((int(*)())(lol))(lol);
```</li>
</ol>

Note that compilers place string literals in the `.rodata` section (or `.rdata` on Windows), which is linked as part of the text segment (along with code for functions).  

The text segment has Read+Exec permission, so casting string literals to function pointers works without needing `mprotect()` or `VirtualProtect()` system calls like you'd need for dynamically allocated memory.  (Or `gcc -z execstack` links the program with stack + data segment + heap executable, as a quick hack.)  

<hr>

To disassemble these, you can compile this to put a label on the bytes, and use a disassembler.  

```c
// at global scope
const char swap[] = "\x8b\x44\x24\x04\x8b\x5c\x24\x08\x8b\x00\x8b\x1b\x31\xc3\x31\xd8\x31\xc3\x8b\x4c\x24\x04\x89\x01\x8b\x4c\x24\x08\x89\x19\xc3 <- This swaps the values of a and b";
```

Compiling with `gcc -c -m32 foo.c` and disassembling with `objdump -D -rwC -Mintel`, we can get the assembly, and find out that this code violates the ABI by clobbering EBX (a call-preserved register) and is generally inefficient.  

```c
00000000 <swap>:
   0:   8b 44 24 04             mov    eax,DWORD PTR [esp+0x4]   # load int *a arg from the stack
   4:   8b 5c 24 08             mov    ebx,DWORD PTR [esp+0x8]   # ebx = b
   8:   8b 00                   mov    eax,DWORD PTR [eax]       # dereference: eax = *a
   a:   8b 1b                   mov    ebx,DWORD PTR [ebx]
   c:   31 c3                   xor    ebx,eax                # pointless xor-swap
   e:   31 d8                   xor    eax,ebx                # instead of just storing with opposite registers
  10:   31 c3                   xor    ebx,eax
  12:   8b 4c 24 04             mov    ecx,DWORD PTR [esp+0x4]  # reload a from the stack
  16:   89 01                   mov    DWORD PTR [ecx],eax     # store to *a
  18:   8b 4c 24 08             mov    ecx,DWORD PTR [esp+0x8]
  1c:   89 19                   mov    DWORD PTR [ecx],ebx
  1e:   c3                      ret    

  not shown: the later bytes are ASCII text documentation
  they're not executed by the CPU because the ret instruction sends execution back to the caller
```

This machine code will (probably) work in 32-bit code on Windows, Linux, OS X, and so on: the default calling conventions on all those OSes pass args on the stack instead of more efficiently in registers.  But EBX is call-preserved in all the normal calling conventions, so using it as a scratch register without saving/restoring it can easily make the caller crash.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: How can I get a file's size in C? (score [735156](https://stackoverflow.com/q/238603) in 2019)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://stackoverflow.com/questions/8236/how-do-you-determine-the-size-of-a-file-in-c">How do you determine the size of a file in C?</a>  </p>
</blockquote>



<p>How can I find out the size of a file I opened with an application written in C ? 
I would like to know the size, because I want to put the content of the loaded file into a string, which I allocate using `malloc()`. Just writing `malloc(10000*sizeof(char));` is IMHO a bad idea. </p>

#### Answer accepted (score 479)
You need to seek to the end of the file and then ask for the position:  

```c
fseek(fp, 0L, SEEK_END);
sz = ftell(fp);
```

You can then seek back, e.g.:  

```c
fseek(fp, 0L, SEEK_SET);
```

or (if seeking to go to the beginning)  

```c
rewind(fp);
```

#### Answer 2 (score 359)
<h5>Using standard library:</h2>

Assuming that your implementation meaningfully supports SEEK_END:  

```c
fseek(f, 0, SEEK_END); // seek to end of file
size = ftell(f); // get current file pointer
fseek(f, 0, SEEK_SET); // seek back to beginning of file
// proceed with allocating memory and reading the file
```

<h5>Linux/POSIX:</h2>

You can use `stat` (if you know the filename), or `fstat` (if you have the file descriptor).  

Here is an example for stat:  

```c
#include <sys/stat.h>
struct stat st;
stat(filename, &st);
size = st.st_size;
```

<h5>Win32:</h2>

You can use <a href="https://msdn.microsoft.com/en-us/library/windows/desktop/aa364955(v=vs.85).aspx" rel="noreferrer">GetFileSize</a> or <a href="https://msdn.microsoft.com/en-us/library/windows/desktop/aa364957(v=vs.85).aspx" rel="noreferrer">GetFileSizeEx</a>.  

#### Answer 3 (score 104)
If you have the file descriptor `fstat()` returns a stat structure which contain the file size.  

```c
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

// fd = fileno(f); //if you have a stream (e.g. from fopen), not a file descriptor.
struct stat buf;
fstat(fd, &buf);
off_t size = buf.st_size;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Is there a printf converter to print in binary format? (score [717928](https://stackoverflow.com/q/111928) in )

#### Question
I can print with printf as a hex or octal number.  Is there a format tag to print as binary, or arbitrary base?    

I am running gcc.  

```c
printf("%d %x %o\n", 10, 10, 10); //prints "10 A 12\n"
print("%b\n", 10); // prints "%b\n"
```

#### Answer 2 (score 240)
Hacky but works for me:  

```c
#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0') 
```



```c
printf("Leading text "BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(byte));
```

For multi-byte types   

```c
printf("m: "BYTE_TO_BINARY_PATTERN" "BYTE_TO_BINARY_PATTERN"\n",
  BYTE_TO_BINARY(m>>8), BYTE_TO_BINARY(m));
```

You need all the extra quotes unfortunately. This approach has the efficiency risks of macros (don't pass a function as the argument to `BYTE_TO_BINARY`) but avoids the memory issues and multiple invocations of strcat in some of the other proposals here.  

#### Answer 3 (score 195)
<strong>Print Binary for Any Datatype</strong>  

```c
//assumes little endian
void printBits(size_t const size, void const * const ptr)
{
    unsigned char *b = (unsigned char*) ptr;
    unsigned char byte;
    int i, j;

    for (i=size-1;i>=0;i--)
    {
        for (j=7;j>=0;j--)
        {
            byte = (b[i] >> j) & 1;
            printf("%u", byte);
        }
    }
    puts("");
}
```

test  

```c
int main(int argv, char* argc[])
{
        int i = 23;
        uint ui = UINT_MAX;
        float f = 23.45f;
        printBits(sizeof(i), &i);
        printBits(sizeof(ui), &ui);
        printBits(sizeof(f), &f);
        return 0;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: How do you format an unsigned long long int using printf? (score [717617](https://stackoverflow.com/q/2844) in 2018)

#### Question
```c
#include <stdio.h>
int main() {
    unsigned long long int num = 285212672; //FYI: fits in 29 bits
    int normalInt = 5;
    printf("My number is %d bytes wide and its value is %ul. A normal number is %d.\n", sizeof(num), num, normalInt);
    return 0;
}
```

Output:  

```c
My number is 8 bytes wide and its value is 285212672l. A normal number is 0.
```

I assume this unexpected result is from printing the `unsigned long long int`. How do you `printf()` an `unsigned long long int`?  

#### Answer accepted (score 455)
Use the ll (el-el) long-long modifier with the u (unsigned) conversion. (Works in windows, GNU).  

```c
printf("%llu", 285212672);
```

#### Answer 2 (score 84)
<p>You may want to try using the inttypes.h library that gives you types such as
`int32_t`, `int64_t`, `uint64_t` etc.
You can then use its macros such as:</p>

```c
uint64_t x;
uint32_t y;

printf("x: %"PRId64", y: %"PRId32"\n", x, y);
```

This is "guaranteed" to not give you the same trouble as `long`, `unsigned long long` etc, since you don't have to guess how many bits are in each data type.  

#### Answer 3 (score 61)
`%d`--> for `int`  

`%u`--> for `unsigned int`  

`%ld`--> for `long int`  

`%lu`--> for `unsigned long int`  

`%lld`--> for `long long int`  

`%llu`--> for `unsigned long long int`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: How to initialize a struct in accordance with C programming language standards (score [712842](https://stackoverflow.com/q/330793) in 2018)

#### Question
I want to initialize a struct element, split in declaration and initialization. This is what I have:  

```c
typedef struct MY_TYPE {
  bool flag;
  short int value;
  double stuff;
} MY_TYPE;

void function(void) {
  MY_TYPE a;
  ...
  a = { true, 15, 0.123 }
}
```

Is this the way to declare and initialize a local variable of `MY_TYPE` in accordance with C programming language standards (C89, C90, C99, C11, etc.)? Or is there anything better or at least working?  

<strong>Update</strong> I ended up having a static initialization element where I set every subelement according to my needs.  

#### Answer accepted (score 687)
In (ANSI) C99, you can use a <strong>designated initializer</strong> to initialize a structure:   

```c
MY_TYPE a = { .flag = true, .value = 123, .stuff = 0.456 };
```

Edit: Other members are initialized as zero: "Omitted field members are implicitly initialized the same as objects that have static storage duration." (<a href="https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html" rel="noreferrer">https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html</a>)  

#### Answer 2 (score 188)
You can do it with a <a href="http://gcc.gnu.org/onlinedocs/gcc-4.3.2/gcc/Compound-Literals.html" rel="noreferrer">compound literal</a>. According to that page, it works in C99 (which also counts as <a href="http://en.wikipedia.org/wiki/ANSI_C" rel="noreferrer">ANSI C</a>).  

```c
MY_TYPE a;

a = (MY_TYPE) { .flag = true, .value = 123, .stuff = 0.456 };
...
a = (MY_TYPE) { .value = 234, .stuff = 1.234, .flag = false };
```

The designations in the initializers are optional; you could also write:  

```c
a = (MY_TYPE) { true,  123, 0.456 };
...
a = (MY_TYPE) { false, 234, 1.234 };
```

#### Answer 3 (score 88)
<p>I see you've already received an answer about ANSI C 99, so I'll throw a bone about ANSI C 89.
ANSI C 89 allows you to initialize a struct this way:</p>

```c
typedef struct Item {
    int a;
    float b;
    char* name;
} Item;

int main(void) {
    Item item = { 5, 2.2, "George" };
    return 0;
}
```

An important thing to remember, at the moment you initialize even one object/ variable in the struct, all of its other variables will be initialized to default value.  

If you don't initialize the values in your struct, all variables will contain "garbage values".  

Good luck!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: What is the effect of extern "C" in C++? (score [709916](https://stackoverflow.com/q/1041866) in 2018)

#### Question
What exactly does putting `extern "C"` into C++ code do?  

For example:  

```c
extern "C" {
   void foo();
}
```

#### Answer accepted (score 1442)
extern "C" makes a function-name in C++ have 'C' linkage (compiler does not mangle the name) so that client C code can link to (i.e use) your function using a 'C' compatible header file that contains just the declaration of your function. Your function definition is contained in a binary format (that was compiled by your C++ compiler) that the client 'C' linker will then link to using the 'C' name.  

Since C++ has overloading of function names and C does not, the C++ compiler cannot just use the function name as a unique id to link to, so it mangles the name by adding information about the arguments.  A C compiler does not need to mangle the name since you can not overload function names in C.  When you state that a function has extern "C" linkage in C++, the C++ compiler does not add argument/parameter type information to the name used for linkage.  

Just so you know, you can specify "C" linkage to each individual declaration/definition explicitly or use a block to group a sequence of declarations/definitions to have a certain linkage:  

```c
extern "C" void foo(int);
extern "C"
{
   void g(char);
   int i;
}
```

If you care about the technicalities, they are listed in section 7.5 of the C++03 standard, here is a brief summary (with emphasis on extern "C"):  

<ul>
<li>extern "C" is a linkage-specification</li>
<li>Every compiler is <em>required</em> to provide "C" linkage</li>
<li>a linkage specification shall occur only in namespace scope</li>
<li><strike> all function types, function names and variable names have a language linkage </strike> <b><a href="https://stackoverflow.com/questions/1041866/in-c-source-what-is-the-effect-of-extern-c#comment20842899_1041880">See Richard's Comment:</a></b> Only function names and variable names with external linkage have a language linkage</li>
<li>two function types with distinct language linkages are distinct types even if otherwise identical</li>
<li>linkage specs nest, inner one determines the final linkage</li>
<li>extern "C" is ignored for class members </li>
<li>at most one function with a particular name can have "C" linkage (regardless of namespace)</li>
<li><strike> extern "C" forces a function to have external linkage (cannot make it static) </strike> <b> <a href="https://stackoverflow.com/questions/1041866/what-is-the-effect-of-extern-c-in-c?rq=1#comment20842893_1041880">See Richard's comment:</a> </b>   'static' inside 'extern "C"' is valid; an entity so declared has internal linkage, and so does not have a language linkage </li>
<li>Linkage from C++ to objects defined in other languages and to objects defined in C++ from other languages is implementation-defined and language-dependent. Only where the object layout strategies of two language implementations are similar enough can such linkage be achieved  </li>
</ul>

#### Answer 2 (score 295)
Just wanted to add a bit of info, since I haven't seen it posted yet.  

You'll very often see code in C headers like so:  

```c
#ifdef __cplusplus
extern "C" {
#endif

// all of your legacy C code here

#ifdef __cplusplus
}
#endif
```

What this accomplishes is that it allows you to use that C header file with your C++ code, because the macro "__cplusplus" will be defined. But you can <em>also</em> still use it with your legacy C code, where the macro is <em>NOT</em> defined, so it won't see the uniquely C++ construct.  

Although, I have also seen C++ code such as:  

```c
extern "C" {
#include "legacy_C_header.h"
}
```

which I imagine accomplishes much the same thing.  

Not sure which way is better, but I have seen both.  

#### Answer 3 (score 210)
<strong>Decompile a `g++` generated binary to see what is going on</strong>  

main.cpp  

```c
void f() {}
void g();

extern "C" {
    void ef() {}
    void eg();
}

/* Prevent g and eg from being optimized away. */
void h() { g(); eg(); }
```

Compile and disassemble the generated <a href="https://stackoverflow.com/questions/26294034/how-to-make-an-executable-elf-file-in-linux-using-a-hex-editor/30648229#30648229">ELF</a> output:  

```c
g++ -c -std=c++11 -Wall -Wextra -pedantic -o main.o main.cpp
readelf -s main.o
```

The output contains:  

```c
     8: 0000000000000000     7 FUNC    GLOBAL DEFAULT    1 _Z1fv
     9: 0000000000000007     7 FUNC    GLOBAL DEFAULT    1 ef
    10: 000000000000000e    17 FUNC    GLOBAL DEFAULT    1 _Z1hv
    11: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND _GLOBAL_OFFSET_TABLE_
    12: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND _Z1gv
    13: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND eg
```

<strong>Interpretation</strong>  

We see that:  

<ul>
<li><p>`ef` and `eg` were stored in symbols with the same name as in the code</p></li>
<li><p>the other symbols were mangled. Let's unmangle them:</p>

```c
$ c++filt _Z1fv
f()
$ c++filt _Z1hv
h()
$ c++filt _Z1gv
g()
```</li>
</ul>

Conclusion: both of the following symbol types were <em>not</em> mangled:  

<ul>
<li>defined</li>
<li>declared but undefined (`Ndx = UND`), to be provided at link or run time from another object file</li>
</ul>

So you will need `extern "C"` both when calling:  

<ul>
<li>C from C++: tell `g++` to expect unmangled symbols produced by `gcc`</li>
<li>C++ from C: tell `g++` to generate unmangled symbols for `gcc` to use</li>
</ul>

<strong>Things that do not work in extern C</strong>  

It becomes obvious that any C++ feature that requires name mangling will not work inside `extern C`:  

```c
extern "C" {
    // Overloading.
    // error: declaration of C function ‘void f(int)’ conflicts with
    void f();
    void f(int i);

    // Templates.
    // error: template with C linkage
    template <class C> void f(C i) { }
}
```

<strong>Minimal runnable C from C++ example</strong>  

For the sake of completeness and for the newbs out there, see also: <a href="https://stackoverflow.com/questions/13694605/how-to-use-c-source-files-in-a-c-project/51912672#51912672">How to use C source files in a C++ project?</a>  

Calling C from C++ is pretty easy: each C function only has one possible non-mangled symbol, so no extra work is required.  

main.cpp  

```c
#include <cassert>

#include "c.h"

int main() {
    assert(f() == 1);
}
```

c.h  

```c
#ifndef C_H
#define C_H

/* This ifdef allows the header to be used from both C and C++. */
#ifdef __cplusplus
extern "C" {
#endif
int f();
#ifdef __cplusplus
}
#endif

#endif
```

c.c  

```c
#include "c.h"

int f(void) { return 1; }
```

Run:  

```c
g++ -c -o main.o -std=c++98 main.cpp
gcc -c -o c.o -std=c89 c.c
g++ -o main.out main.o c.o
./main.out
```

Without `extern "C"` the link fails with:  

```c
main.cpp:6: undefined reference to `f()'
```

because `g++` expects to find a mangled `f`, which `gcc` did not produce.  

<a href="https://github.com/cirosantilli/cpp-cheat/tree/bf5f48628d0b01ba6a3fcea6f1162b28539654c9/c-from-cpp" rel="noreferrer">Example on GitHub</a>.  

<strong>Minimal runnable C++ from C example</strong>  

Calling C++ from C is a bit harder: we have to manually create non-mangled versions of each function we want to expose.  

Here we illustrate how to expose C++ function overloads to C.  

main.c  

```c
#include <assert.h>

#include "cpp.h"

int main(void) {
    assert(f_int(1) == 2);
    assert(f_float(1.0) == 3);
    return 0;
}
```

cpp.h  

```c
#ifndef CPP_H
#define CPP_H

#ifdef __cplusplus
// C cannot see these overloaded prototypes, or else it would get confused.
int f(int i);
int f(float i);
extern "C" {
#endif
int f_int(int i);
int f_float(float i);
#ifdef __cplusplus
}
#endif

#endif
```

cpp.cpp  

```c
#include "cpp.h"

int f(int i) {
    return i + 1;
}

int f(float i) {
    return i + 2;
}

int f_int(int i) {
    return f(i);
}

int f_float(float i) {
    return f(i);
}
```

Run:  

```c
gcc -c -o main.o -std=c89 -Wextra main.c
g++ -c -o cpp.o -std=c++98 cpp.cpp
g++ -o main.out main.o cpp.o
./main.out
```

Without `extern "C"` it fails with:  

```c
main.c:6: undefined reference to `f_int'
main.c:7: undefined reference to `f_float'
```

because `g++` generated mangled symbols which `gcc` cannot find.  

<a href="https://github.com/cirosantilli/cpp-cheat/tree/bf5f48628d0b01ba6a3fcea6f1162b28539654c9/cpp-from-c" rel="noreferrer">Example on GitHub</a>.  

Tested in Ubuntu 18.04.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: C read file line by line (score [708636](https://stackoverflow.com/q/3501338) in )

#### Question
I wrote this function to read a line from a file:  

```c
const char *readLine(FILE *file) {

    if (file == NULL) {
        printf("Error: file pointer is null.");
        exit(1);
    }

    int maximumLineLength = 128;
    char *lineBuffer = (char *)malloc(sizeof(char) * maximumLineLength);

    if (lineBuffer == NULL) {
        printf("Error allocating memory for line buffer.");
        exit(1);
    }

    char ch = getc(file);
    int count = 0;

    while ((ch != '\n') && (ch != EOF)) {
        if (count == maximumLineLength) {
            maximumLineLength += 128;
            lineBuffer = realloc(lineBuffer, maximumLineLength);
            if (lineBuffer == NULL) {
                printf("Error reallocating space for line buffer.");
                exit(1);
            }
        }
        lineBuffer[count] = ch;
        count++;

        ch = getc(file);
    }

    lineBuffer[count] = '\0';
    char line[count + 1];
    strncpy(line, lineBuffer, (count + 1));
    free(lineBuffer);
    const char *constLine = line;
    return constLine;
}
```

The function reads the file correctly, and using printf I see that the constLine string did get read correctly as well.  

However, if I use the function e.g. like this:  

```c
while (!feof(myFile)) {
    const char *line = readLine(myFile);
    printf("%s\n", line);
}
```

printf outputs gibberish. Why?  

#### Answer 2 (score 276)
If your task is not to invent the line-by-line reading function, but just to read the file line-by-line, you may use a typical code snippet involving the `getline()` function (see the manual page <a href="http://linux.die.net/man/3/getline" rel="noreferrer">here</a>):  

```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    FILE * fp;
    char * line = NULL;
    size_t len = 0;
    ssize_t read;

    fp = fopen("/etc/motd", "r");
    if (fp == NULL)
        exit(EXIT_FAILURE);

    while ((read = getline(&line, &len, fp)) != -1) {
        printf("Retrieved line of length %zu:\n", read);
        printf("%s", line);
    }

    fclose(fp);
    if (line)
        free(line);
    exit(EXIT_SUCCESS);
}
```

#### Answer 3 (score 20)
In your `readLine` function, you return a pointer to the `line` array (Strictly speaking, a pointer to its first character, but the difference is irrelevant here). Since it's an automatic variable (i.e., it's “on the stack”), the memory is reclaimed when the function returns. You see gibberish because `printf` has put its own stuff on the stack.  

You need to return a dynamically allocated buffer from the function. You already have one, it's `lineBuffer`; all you have to do is truncate it to the desired length.  

```c
    lineBuffer[count] = '\0';
    realloc(lineBuffer, count + 1);
    return lineBuffer;
}
```

<strong>ADDED</strong> (response to follow-up question in comment): `readLine` returns a pointer to the characters that make up the line. This pointer is what you need to work with the contents of the line. It's also what you must pass to `free` when you've finished using the memory taken by these characters. Here's how you might use the `readLine` function:  

```c
char *line = readLine(file);
printf("LOG: read a line: %s\n", line);
if (strchr(line, 'a')) { puts("The line contains an a"); }
/* etc. */
free(line);
/* After this point, the memory allocated for the line has been reclaimed.
   You can't use the value of `line` again (though you can assign a new value
   to the `line` variable if you want). */
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: What is the argument for printf that formats a long? (score [707746](https://stackoverflow.com/q/38561) in 2018)

#### Question
The `printf` function takes an argument type, such as `%d` or `%i` for a `signed int`. However, I don't see anything for a `long` value.  

#### Answer accepted (score 581)
Put an `l` (lowercased letter L) directly before the specifier.    

```c
unsigned long n;
long m;

printf("%lu %ld", n, m);
```

#### Answer 2 (score 187)
I think you mean:  

```c
unsigned long n;
printf("%lu", n);   // unsigned long
```

or  

```c
long n;
printf("%ld", n);   // signed long
```

#### Answer 3 (score 66)
On most platforms, `long` and `int` are the same size (32 bits). Still, it does have its own format specifier:  

```c
long n;
unsigned long un;
printf("%ld", n); // signed
printf("%lu", un); // unsigned
```

For 64 bits, you'd want a `long long`:  

```c
long long n;
unsigned long long un;
printf("%lld", n); // signed
printf("%llu", un); // unsigned
```

Oh, and of course, it's different in Windows:  

```c
printf("%l64d", n); // signed
printf("%l64u", un); // unsigned
```

Frequently, when I'm printing 64-bit values, I find it helpful to print them in hex (usually with numbers that big, they are pointers or bit fields).  

```c
unsigned long long n;
printf("0x%016llX", n); // "0x" followed by "0-padded", "16 char wide", "long long", "HEX with 0-9A-F"
```

will print:  

```c
0x00000000DEADBEEF
```

Btw, "long" doesn't mean that much anymore (on mainstream x64).  "int" is the platform default int size, typically 32 bits.  "long" is usually the same size.  However, they have different portability semantics on older platforms (and modern embedded platforms!).  "long long" is a 64-bit number and usually what people meant to use unless they really really knew what they were doing editing a piece of x-platform portable code.  Even then, they probably would have used a macro instead to capture the semantic meaning of the type (eg uint64_t).  

```c
char c;       // 8 bits
short s;      // 16 bits
int i;        // 32 bits (on modern platforms)
long l;       // 32 bits
long long ll; // 64 bits 
```

Back in the day, "int" was 16 bits.  You'd think it would now be 64 bits, but no, that would have caused insane portability issues.  Of course, even this is a simplification of the arcane and history-rich truth.  See <a href="http://en.wikipedia.org/wiki/Integer_(computer_science)" rel="noreferrer">wiki:Integer</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: Rounding Number to 2 Decimal Places in C (score [690219](https://stackoverflow.com/q/1343890) in 2012)

#### Question
How can I round a float (such as 37.777779) to two decimal places (37.78) in C?  

#### Answer 2 (score 385)
If you just want to round the number for output purposes, then the `"%.2f"` format string is indeed the correct answer.  However, if you actually want to round the floating point value for further computation, something like the following works:  

```c
#include <math.h>

float val = 37.777779;

float rounded_down = floorf(val * 100) / 100;   /* Result: 37.77 */
float nearest = roundf(val * 100) / 100;  /* Result: 37.78 */
float rounded_up = ceilf(val * 100) / 100;      /* Result: 37.78 */
```

Notice that there are three different rounding rules you might want to choose: round down (ie, truncate after two decimal places), rounded to nearest, and round up.  Usually, you want round to nearest.  

As several others have pointed out, due to the quirks of floating point representation, these rounded values may not be exactly the "obvious" decimal values, but they will be very very close.  

For much (much!) more information on rounding, and especially on tie-breaking rules for rounding to nearest, see <a href="http://en.wikipedia.org/wiki/Rounding" rel="noreferrer">the Wikipedia article on Rounding</a>.  

#### Answer 3 (score 72)
Using <strong>%.2f</strong> in printf. It only print 2 decimal points.  

Example:  

```c
printf("%.2f", 37.777779);
```

Output:  

```c
37.77
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: What is size_t in C? (score [666997](https://stackoverflow.com/q/2550774) in 2013)

#### Question
I am getting confused with `size_t` in C. I know that it is returned by the `sizeof` operator. But what exactly is it? Is it a data type?  

Let's say I have a `for` loop:  

```c
for(i = 0; i < some_size; i++)
```

Should I use `int i;` or `size_t i;`?  

#### Answer accepted (score 437)
<a href="http://en.wikipedia.org/wiki/Size_t" rel="noreferrer">From Wikipedia</a>:  

<blockquote>
  <p>According to the 1999 ISO C standard
  (C99), `size_t` is an unsigned integer
  type of at least 16 bit (see sections
  7.17 and 7.18.3).</p>
  
  <p>`size_t`is an unsigned data type
  defined by several C/C++ standards,
  e.g. the C99 ISO/IEC 9899 standard,
  that is defined in `stddef.h`.<a href="http://en.wikipedia.org/wiki/Size_t" rel="noreferrer">1</a> It can
  be further imported by inclusion of
  `stdlib.h` as this file internally sub
  includes `stddef.h`.</p>
  
  <p>This type is used to represent the
  size of an object. Library functions
  that take or return sizes expect them
  to be of type or have the return type
  of `size_t`. Further, the most
  frequently used compiler-based
  operator sizeof should evaluate to a
  constant value that is compatible with
  `size_t`.</p>
</blockquote>

As an implication, `size_t` is a type guaranteed to hold any array index.  

#### Answer 2 (score 211)
`size_t` is an unsigned type.  So, it cannot represent any negative values(&lt;0).  You use it when you are counting something, and are sure that it cannot be negative.  For example, <a href="http://devdocs.io/c/string/byte/strlen" rel="noreferrer">`strlen()`</a> returns a `size_t` because the length of a string has to be at least 0.  

In your example, if your loop index is going to be always greater than 0, it might make sense to use `size_t`, or any other unsigned data type.  

When you use a `size_t` object, you have to make sure that in all the contexts it is used, including arithmetic, you want non-negative values.  For example, let's say you have:  

```c
size_t s1 = strlen(str1);
size_t s2 = strlen(str2);
```

and you want to find the difference of the lengths of `str2` and `str1`.  You cannot do:  

```c
int diff = s2 - s1; /* bad */
```

This is because the value assigned to `diff` is always going to be a positive number, even when `s2 &lt; s1`, because the calculation is done with unsigned types.  In this case, depending upon what your use case is, you might be better off using `int` (or `long long`) for `s1` and `s2`.  

There are some functions in C/POSIX that could/should use `size_t`, but don't because of historical reasons.  For example, the second parameter to `fgets` should ideally be `size_t`, but is `int`.  

#### Answer 3 (score 69)
`size_t` is a type that can hold any array index.  

Depending on the implementation, it can be any of:  

`unsigned char`  

`unsigned short`  

`unsigned int`  

`unsigned long`  

`unsigned long long`  

Here's how `size_t` is defined in `stddef.h` of my machine:  

```c
typedef unsigned long size_t;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: How do I use extern to share variables between source files? (score [665535](https://stackoverflow.com/q/1433204) in 2017)

#### Question
I know that global variables in C sometimes have the `extern` keyword. What is an `extern` variable? What is the declaration like? What is its scope?  

This is related to sharing variables across source files, but how does that work precisely? Where do I use `extern`?  

#### Answer 2 (score 1667)
<p>Using `extern` is only of relevance when the program you're building
consists of multiple source files linked together, where some of the
variables defined, for example, in source file `file1.c` need to be
referenced in other source files, such as `file2.c`.</p>

<p>It is important to <a href="https://stackoverflow.com/questions/1410563">understand the difference between <em>defining</em> a
variable and <em>declaring</em> a
variable</a>:</p>

<ul>
<li>A variable is <strong>declared</strong> when the compiler is informed that a
variable exists (and this is its type); it does not allocate the
storage for the variable at that point.</li>
<li>A variable is <strong>defined</strong> when the compiler allocates the storage for
the variable.</li>
</ul>

<p>You may declare a variable multiple times (though once is sufficient);
you may only define it once within a given scope.
A variable definition is also a declaration, but not all variable
declarations are definitions.</p>

<h5>Best way to declare and define global variables</h2>

<p>The clean, reliable way to declare and define global variables is to use
a header file to contain an `extern` <em>declaration</em> of the variable.</p>

<p>The header is included by the one source file that defines the variable
and by all the source files that reference the variable.
For each program, one source file (and only one source file) defines the
variable.
Similarly, one header file (and only one header file) should declare the
variable.
The header file is crucial; it enables cross-checking between
independent TUs (translation units — think source files) and ensures
consistency.</p>

<p>Although there are other ways of doing it, this method is simple and
reliable.
It is demonstrated by `file3.h`, `file1.c` and `file2.c`:</p>

<h5>file3.h</h3>

```c
extern int global_variable;  /* Declaration of the variable */
```

<h5>file1.c</h3>

```c
#include "file3.h"  /* Declaration made available here */
#include "prog1.h"  /* Function declarations */

/* Variable defined here */
int global_variable = 37;    /* Definition checked against declaration */

int increment(void) { return global_variable++; }
```

<h5>file2.c</h3>

```c
#include "file3.h"
#include "prog1.h"
#include <stdio.h>

void use_it(void)
{
    printf("Global variable: %d\n", global_variable++);
}
```

That's the best way to declare and define global variables.  

<hr>

<em>The next two files complete the source for `prog1`:</em>  

<p>The complete programs shown use functions, so function declarations have
crept in.
Both C99 and C11 require functions to be declared or defined before they
are used (whereas C90 did not, for good reasons).
I use the keyword `extern` in front of function declarations in headers
for consistency — to match the `extern` in front of variable
declarations in headers.
Many people prefer not to use `extern` in front of function
declarations; the compiler doesn't care — and ultimately, neither do I
as long as you're consistent, at least within a source file.</p>

<h5>prog1.h</h3>

```c
extern void use_it(void);
extern int increment(void);
```

<h5>prog1.c</h3>

```c
#include "file3.h"
#include "prog1.h"
#include <stdio.h>

int main(void)
{
    use_it();
    global_variable += 19;
    use_it();
    printf("Increment: %d\n", increment());
    return 0;
}
```

<ul>
<li>`prog1` uses `prog1.c`, `file1.c`, `file2.c`, `file3.h` and `prog1.h`.</li>
</ul>

<p>The file `prog1.mk` is a makefile for `prog1` only.
It will work with most versions of `make` produced since about the turn
of the millennium.
It is not tied specifically to GNU Make.</p>

<h5>prog1.mk</h3>

```c
# Minimal makefile for prog1

PROGRAM = prog1
FILES.c = prog1.c file1.c file2.c
FILES.h = prog1.h file3.h
FILES.o = ${FILES.c:.c=.o}

CC      = gcc
SFLAGS  = -std=c11
GFLAGS  = -g
OFLAGS  = -O3
WFLAG1  = -Wall
WFLAG2  = -Wextra
WFLAG3  = -Werror
WFLAG4  = -Wstrict-prototypes
WFLAG5  = -Wmissing-prototypes
WFLAGS  = ${WFLAG1} ${WFLAG2} ${WFLAG3} ${WFLAG4} ${WFLAG5}
UFLAGS  = # Set on command line only

CFLAGS  = ${SFLAGS} ${GFLAGS} ${OFLAGS} ${WFLAGS} ${UFLAGS}
LDFLAGS =
LDLIBS  =

all:    ${PROGRAM}

${PROGRAM}: ${FILES.o}
    ${CC} -o $@ ${CFLAGS} ${FILES.o} ${LDFLAGS} ${LDLIBS}

prog1.o: ${FILES.h}
file1.o: ${FILES.h}
file2.o: ${FILES.h}

# If it exists, prog1.dSYM is a directory on macOS
DEBRIS = a.out core *~ *.dSYM
RM_FR  = rm -fr

clean:
    ${RM_FR} ${FILES.o} ${PROGRAM} ${DEBRIS}
```

<hr>

<h5>Guidelines</h2>

Rules to be broken by experts only, and only with good reason:  

<ul>
<li>A header file only contains `extern` declarations of variables — never
`static` or unqualified variable definitions.</li>
<li>For any given variable, only one header file declares it (SPOT —
Single Point of Truth).</li>
<li>A source file never contains `extern` declarations of variables —
source files always include the (sole) header that declares them.</li>
<li>For any given variable, exactly one source file defines the variable,
preferably initializing it too.  (Although there is no need to
initialize explicitly to zero, it does no harm and can do some good,
because there can be only one initialized definition of a particular
global variable in a program).</li>
<li>The source file that defines the variable also includes the header to
ensure that the definition and the declaration are consistent.</li>
<li>A function should never need to declare a variable using `extern`.</li>
<li>Avoid global variables whenever possible — use functions instead.</li>
</ul>

<p><sup><em>The source code and text of this answer are available in my
      <a href="https://github.com/jleffler/soq" rel="noreferrer">SOQ</a> (Stack Overflow Questions)
      repository on GitHub in the
      <a href="https://github.com/jleffler/soq/tree/master/src/so-0143-3204" rel="noreferrer">src/so-0143-3204</a>
      sub-directory.</em>
</sup></p>

<p><sup><em>If you're not an experienced C programmer, you could (and perhaps
       should) stop reading here.</em>
</sup></p>

<h5>Not so good way to define global variables</h2>

<p>With some (indeed, many) C compilers, you can get away with what's
called a 'common' definition of a variable too.
'Common', here, refers to a technique used in Fortran for sharing
variables between source files, using a (possibly named) COMMON block.
What happens here is that each of a number of files provides a tentative
definition of the variable.
As long as no more than one file provides an initialized definition,
then the various files end up sharing a common single definition of the
variable:</p>

<h5>file10.c</h3>

```c
#include "prog2.h"

int i;   /* Do not do this in portable code */

void inc(void) { i++; }
```

<h5>file11.c</h3>

```c
#include "prog2.h"

int i;   /* Do not do this in portable code */

void dec(void) { i--; }
```

<h5>file12.c</h3>

```c
#include "prog2.h"
#include <stdio.h>

int i = 9;   /* Do not do this in portable code */

void put(void) { printf("i = %d\n", i); }
```

<p>This technique does not conform to the letter of the C standard and the
'one definition rule' — it is officially undefined behaviour:</p>

<blockquote>
  <strong><a href="http://port70.net/~nsz/c/c11/n1570.html#J.2" rel="noreferrer">J.2 Undefined behavior</a></strong>  
  
  <p>An identifier with external linkage is used, but in the program there
  does not exist exactly one external definition for the identifier, or
  the identifier is not used and there exist multiple external
  definitions for the identifier (6.9).</p>
  
  <strong><a href="http://port70.net/~nsz/c/c11/n1570.html#6.9p5" rel="noreferrer">§6.9 External definitions ¶5</a></strong>  
  
  <p>An <em>external definition</em> is an external declaration that is also a
  definition of a function (other than an inline definition) or an
  object.
  If an identifier declared with external linkage is used in an
  expression (other than as part of the operand of a `sizeof` or
  `_Alignof` operator whose result is an integer constant), somewhere in
  the entire program there shall be exactly one external definition for
  the identifier; otherwise, there shall be no more than
  one.<sup>161)</sup></p>
  
  <p><sup>161)</sup> Thus, if an identifier declared with external linkage
  is not used in an expression, there need be no external definition for
  it.</p>
</blockquote>

<p>However, the C standard also lists it in informative Annex J as one of
the <a href="http://port70.net/~nsz/c/c11/n1570.html#J.5" rel="noreferrer">Common extensions</a>.</p>

<blockquote>
  <a href="http://port70.net/~nsz/c/c11/n1570.html#J.5.11" rel="noreferrer">J.5.11 Multiple external definitions</a>  
  
  <p>There may be more than one external definition for the identifier of
  an object, with or without the explicit use of the keyword extern; if
  the definitions disagree, or more than one is initialized, the
  behavior is undefined (6.9.2).</p>
</blockquote>

<p>Because this technique is not always supported, it is best to avoid
using it, <em>especially if your code needs to be portable</em>.
Using this technique, you can also end up with unintentional type
punning.
If one of the files declared `i` as a `double` instead of as an `int`,
C's type-unsafe linkers probably would not spot the mismatch.
If you're on a machine with 64-bit `int` and `double`, you'd not even
get a warning; on a machine with 32-bit `int` and 64-bit `double`, you'd
probably get a warning about the different sizes — the linker would
use the largest size, exactly as a Fortran program would take the
largest size of any common blocks.</p>

<hr>

<em>The next two files complete the source for `prog2`:</em>  

<h5>prog2.h</h3>

```c
extern void dec(void);
extern void put(void);
extern void inc(void);
```

<h5>prog2.c</h3>

```c
#include "prog2.h"
#include <stdio.h>

int main(void)
{
    inc();
    put();
    dec();
    put();
    dec();
    put();
}
```

<ul>
<li>`prog2` uses `prog2.c`, `file10.c`, `file11.c`, `file12.c`, `prog2.h`.</li>
</ul>

<hr>

<h5>Warning</h3>

<p>As noted in comments here, and as stated in my answer to a similar
<a href="https://stackoverflow.com/questions/1490693">question</a>, using multiple
definitions for a global variable leads to undefined behaviour (J.2;
§6.9), which is the standard's way of saying "anything could happen".
One of the things that can happen is that the program behaves as you
expect; and J.5.11 says, approximately, "you might be lucky more often
than you deserve".
But a program that relies on multiple definitions of an extern variable
— with or without the explicit 'extern' keyword — is not a strictly
conforming program and not guaranteed to work everywhere.
Equivalently: it contains a bug which may or may not show itself.</p>

<h5>Violating the guidelines</h2>

<p>There are, of course, many ways in which these guidelines can be broken.
Occasionally, there may be a good reason to break the guidelines, but
such occasions are extremely unusual.</p>

<h5>faulty_header.h</h3>

```c
int some_var;    /* Do not do this in a header!!! */
```

<p>Note 1: if the header defines the variable without the `extern` keyword,
then each file that includes the header creates a tentative definition
of the variable.
As noted previously, this will often work, but the C standard does not
guarantee that it will work.</p>

<h5>broken_header.h</h3>

```c
int some_var = 13;    /* Only one source file in a program can use this */
```

<p>Note 2: if the header defines and initializes the variable, then only
one source file in a given program can use the header.
Since headers are primarily for sharing information, it is a bit silly
to create one that can only be used once.</p>

<h5>seldom_correct.h</h3>

```c
static int hidden_global = 3;   /* Each source file gets its own copy  */
```

<p>Note 3: if the header defines a static variable (with or without
initialization), then each source file ends up with its own private
version of the 'global' variable.</p>

<p>If the variable is actually a complex array, for example, this can lead
to extreme duplication of code.  It can, very occasionally, be a
sensible way to achieve some effect, but that is very unusual.</p>

<hr>

<h5>Summary</h2>

<p>Use the header technique I showed first.
It works reliably and everywhere.
Note, in particular, that the header declaring the `global_variable` is
included in every file that uses it — including the one that defines it.
This ensures that everything is self-consistent.</p>

<p>Similar concerns arise with declaring and defining functions —
analogous rules apply.
But the question was about variables specifically, so I've kept the
answer to variables only.</p>

<h5>End of Original Answer</h3>

<sup><em>If you're not an experienced C programmer, you probably should stop reading here.</em></sup>  

<hr>

<em>Late Major Addition</em>  

<h5>Avoiding Code Duplication</h1>

<p>One concern that is sometimes (and legitimately) raised about the
'declarations in headers, definitions in source' mechanism described
here is that there are two files to be kept synchronized — the header
and the source.  This is usually followed up with an observation that a
macro can be used so that the header serves double duty — normally
declaring the variables, but when a specific macro is set before the
header is included, it defines the variables instead.</p>

<p>Another concern can be that the variables need to be defined in each of
a number of 'main programs'.  This is normally a spurious concern; you
can simply introduce a C source file to define the variables and link
the object file produced with each of the programs.</p>

<p>A typical scheme works like this, using the original global variable
illustrated in `file3.h`:</p>

<h5>file3a.h</h3>

```c
#ifdef DEFINE_VARIABLES
#define EXTERN /* nothing */
#else
#define EXTERN extern
#endif /* DEFINE_VARIABLES */

EXTERN int global_variable;
```

<h5>file1a.c</h3>

```c
#define DEFINE_VARIABLES
#include "file3a.h"  /* Variable defined - but not initialized */
#include "prog3.h"

int increment(void) { return global_variable++; }
```

<h5>file2a.c</h3>

```c
#include "file3a.h"
#include "prog3.h"
#include <stdio.h>

void use_it(void)
{
    printf("Global variable: %d\n", global_variable++);
}
```

<hr>

<em>The next two files complete the source for `prog3`:</em>  

<h5>prog3.h</h3>

```c
extern void use_it(void);
extern int increment(void);
```

<h5>prog3.c</h3>

```c
#include "file3a.h"
#include "prog3.h"
#include <stdio.h>

int main(void)
{
    use_it();
    global_variable += 19;
    use_it();
    printf("Increment: %d\n", increment());
    return 0;
}
```

<ul>
<li>`prog3` uses `prog3.c`, `file1a.c`, `file2a.c`, `file3a.h`, `prog3.h`.</li>
</ul>

<hr>

<h5>Variable initialization</h2>

<p>The problem with this scheme as shown is that it does not provide for
initialization of the global variable.  With C99 or C11 and variable argument
lists for macros, you could define a macro to support initialization too.
(With C89 and no support for variable argument lists in macros, there is no
easy way to handle arbitrarily long initializers.)</p>

<h5>file3b.h</h3>

```c
#ifdef DEFINE_VARIABLES
#define EXTERN                  /* nothing */
#define INITIALIZER(...)        = __VA_ARGS__
#else
#define EXTERN                  extern
#define INITIALIZER(...)        /* nothing */
#endif /* DEFINE_VARIABLES */

EXTERN int global_variable INITIALIZER(37);
EXTERN struct { int a; int b; } oddball_struct INITIALIZER({ 41, 43 });
```

<p><sup>Reverse contents of `#if` and `#else` blocks, fixing bug identified by
<a href="https://stackoverflow.com/users/369317/denis-kniazhev">Denis Kniazhev</a></sup></p>

<h5>file1b.c</h3>

```c
#define DEFINE_VARIABLES
#include "file3b.h"  /* Variables now defined and initialized */
#include "prog4.h"

int increment(void) { return global_variable++; }
int oddball_value(void) { return oddball_struct.a + oddball_struct.b; }
```

<h5>file2b.c</h3>

```c
#include "file3b.h"
#include "prog4.h"
#include <stdio.h>

void use_them(void)
{
    printf("Global variable: %d\n", global_variable++);
    oddball_struct.a += global_variable;
    oddball_struct.b -= global_variable / 2;
}
```

<p>Clearly, the code for the oddball structure is not what you'd normally
write, but it illustrates the point.  The first argument to the second
invocation of `INITIALIZER` is `{ 41` and the remaining argument
(singular in this example) is `43 }`.  Without C99 or similar support
for variable argument lists for macros, initializers that need to
contain commas are very problematic.</p>

<p><sup>Correct header `file3b.h` included (instead of `fileba.h`) per
<a href="https://stackoverflow.com/users/369317/denis-kniazhev">Denis Kniazhev</a></sup></p>

<hr>

<em>The next two files complete the source for `prog4`:</em>  

<h5>prog4.h</h3>

```c
extern int increment(void);
extern int oddball_value(void);
extern void use_them(void);
```

<h5>prog4.c</h3>

```c
#include "file3b.h"
#include "prog4.h"
#include <stdio.h>

int main(void)
{
    use_them();
    global_variable += 19;
    use_them();
    printf("Increment: %d\n", increment());
    printf("Oddball:   %d\n", oddball_value());
    return 0;
}
```

<ul>
<li>`prog4` uses `prog4.c`, `file1b.c`, `file2b.c`, `prog4.h`, `file3b.h`.</li>
</ul>

<hr>

<h5>Header Guards</h2>

<p>Any header should be protected against reinclusion, so that type
definitions (enum, struct or union types, or typedefs generally) do not
cause problems.  The standard technique is to wrap the body of the
header in a header guard such as:</p>

```c
#ifndef FILE3B_H_INCLUDED
#define FILE3B_H_INCLUDED

...contents of header...

#endif /* FILE3B_H_INCLUDED */
```

<p>The header might be included twice indirectly.  For example, if
`file4b.h` includes `file3b.h` for a type definition that isn't shown,
and `file1b.c` needs to use both header `file4b.h` and `file3b.h`, then
you have some more tricky issues to resolve.  Clearly, you might revise
the header list to include just `file4b.h`.  However, you might not be
aware of the internal dependencies — and the code should, ideally,
continue to work.</p>

<p>Further, it starts to get tricky because you might include `file4b.h`
before including `file3b.h` to generate the definitions, but the normal
header guards on `file3b.h` would prevent the header being reincluded.</p>

<p>So, you need to include the body of `file3b.h` at most once for
declarations, and at most once for definitions, but you might need both
in a single translation unit (TU — a combination of a source file and
the headers it uses).</p>

<h5>Multiple inclusion with variable definitions</h2>

<p>However, it can be done subject to a not too unreasonable constraint.
Let's introduce a new set of file names:</p>

<ul>
<li>`external.h` for the EXTERN macro definitions, etc.</li>
<li>`file1c.h` to define types (notably, `struct oddball`, the type of `oddball_struct`).</li>
<li>`file2c.h` to define or declare the global variables.</li>
<li>`file3c.c` which defines the global variables.</li>
<li>`file4c.c` which simply uses the global variables.</li>
<li>`file5c.c` which shows that you can declare and then define the global variables.</li>
<li>`file6c.c` which shows that you can define and then (attempt to) declare the global variables.</li>
</ul>

<p>In these examples, `file5c.c` and `file6c.c` directly include the header
`file2c.h` several times, but that is the simplest way to show that the
mechanism works.  It means that if the header was indirectly included
twice, it would also be safe.</p>

The restrictions for this to work are:  

<ol>
<li>The header defining or declaring the global variables may not itself
define any types.</li>
<li>Immediately before you include a header that should define variables,
you define the macro DEFINE_VARIABLES.</li>
<li>The header defining or declaring the variables has stylized contents.</li>
</ol>

<h5>external.h</h3>

```c
/*
** This header must not contain header guards (like <assert.h> must not).
** Each time it is invoked, it redefines the macros EXTERN, INITIALIZE
** based on whether macro DEFINE_VARIABLES is currently defined.
*/
#undef EXTERN
#undef INITIALIZE

#ifdef DEFINE_VARIABLES
#define EXTERN              /* nothing */
#define INITIALIZE(...)     = __VA_ARGS__
#else
#define EXTERN              extern
#define INITIALIZE(...)     /* nothing */
#endif /* DEFINE_VARIABLES */
```

<h5>file1c.h</h3>

```c
#ifndef FILE1C_H_INCLUDED
#define FILE1C_H_INCLUDED

struct oddball
{
    int a;
    int b;
};

extern void use_them(void);
extern int increment(void);
extern int oddball_value(void);

#endif /* FILE1C_H_INCLUDED */
```

<h5>file2c.h</h3>

```c
/* Standard prologue */
#if defined(DEFINE_VARIABLES) && !defined(FILE2C_H_DEFINITIONS)
#undef FILE2C_H_INCLUDED
#endif

#ifndef FILE2C_H_INCLUDED
#define FILE2C_H_INCLUDED

#include "external.h"   /* Support macros EXTERN, INITIALIZE */
#include "file1c.h"     /* Type definition for struct oddball */

#if !defined(DEFINE_VARIABLES) || !defined(FILE2C_H_DEFINITIONS)

/* Global variable declarations / definitions */
EXTERN int global_variable INITIALIZE(37);
EXTERN struct oddball oddball_struct INITIALIZE({ 41, 43 });

#endif /* !DEFINE_VARIABLES || !FILE2C_H_DEFINITIONS */

/* Standard epilogue */
#ifdef DEFINE_VARIABLES
#define FILE2C_H_DEFINITIONS
#endif /* DEFINE_VARIABLES */

#endif /* FILE2C_H_INCLUDED */
```

<h5>file3c.c</h3>

```c
#define DEFINE_VARIABLES
#include "file2c.h"  /* Variables now defined and initialized */

int increment(void) { return global_variable++; }
int oddball_value(void) { return oddball_struct.a + oddball_struct.b; }
```

<h5>file4c.c</h3>

```c
#include "file2c.h"
#include <stdio.h>

void use_them(void)
{
    printf("Global variable: %d\n", global_variable++);
    oddball_struct.a += global_variable;
    oddball_struct.b -= global_variable / 2;
}
```

<h5>file5c.c</h3>

```c
#include "file2c.h"     /* Declare variables */

#define DEFINE_VARIABLES
#include "file2c.h"  /* Variables now defined and initialized */

int increment(void) { return global_variable++; }
int oddball_value(void) { return oddball_struct.a + oddball_struct.b; }
```

<h5>file6c.c</h3>

```c
#define DEFINE_VARIABLES
#include "file2c.h"     /* Variables now defined and initialized */

#include "file2c.h"     /* Declare variables */

int increment(void) { return global_variable++; }
int oddball_value(void) { return oddball_struct.a + oddball_struct.b; }
```

<hr>

<em>The next source file completes the source (provides a main program) for `prog5`, `prog6` and `prog7`:</em>  

<h5>prog5.c</h3>

```c
#include "file2c.h"
#include <stdio.h>

int main(void)
{
    use_them();
    global_variable += 19;
    use_them();
    printf("Increment: %d\n", increment());
    printf("Oddball:   %d\n", oddball_value());
    return 0;
}
```

<ul>
<li>`prog5` uses `prog5.c`, `file3c.c`, `file4c.c`, `file1c.h`, `file2c.h`, `external.h`.</li>
<li>`prog6` uses `prog5.c`, `file5c.c`, `file4c.c`, `file1c.h`, `file2c.h`, `external.h`.</li>
<li>`prog7` uses `prog5.c`, `file6c.c`, `file4c.c`, `file1c.h`, `file2c.h`, `external.h`.</li>
</ul>

<hr>

<p>This scheme avoids most problems.  You only run into a problem if a
header that defines variables (such as `file2c.h`) is included by
another header (say `file7c.h`) that defines variables.  There isn't an
easy way around that other than "don't do it".</p>

<p>You can partially work around the problem by revising `file2c.h` into
`file2d.h`:</p>

<h5>file2d.h</h3>

```c
/* Standard prologue */
#if defined(DEFINE_VARIABLES) && !defined(FILE2D_H_DEFINITIONS)
#undef FILE2D_H_INCLUDED
#endif

#ifndef FILE2D_H_INCLUDED
#define FILE2D_H_INCLUDED

#include "external.h"   /* Support macros EXTERN, INITIALIZE */
#include "file1c.h"     /* Type definition for struct oddball */

#if !defined(DEFINE_VARIABLES) || !defined(FILE2D_H_DEFINITIONS)

/* Global variable declarations / definitions */
EXTERN int global_variable INITIALIZE(37);
EXTERN struct oddball oddball_struct INITIALIZE({ 41, 43 });

#endif /* !DEFINE_VARIABLES || !FILE2D_H_DEFINITIONS */

/* Standard epilogue */
#ifdef DEFINE_VARIABLES
#define FILE2D_H_DEFINITIONS
#undef DEFINE_VARIABLES
#endif /* DEFINE_VARIABLES */

#endif /* FILE2D_H_INCLUDED */
```

<p>The issue becomes 'should the header include `#undef DEFINE_VARIABLES`?'
If you omit that from the header and wrap any defining invocation with
`#define` and `#undef`:</p>

```c
#define DEFINE_VARIABLES
#include "file2c.h"
#undef DEFINE_VARIABLES
```

<p>in the source code (so the headers never alter the value of
`DEFINE_VARIABLES`), then you should be clean.  It is just a nuisance to
have to remember to write the the extra line.  An alternative might be:</p>

```c
#define HEADER_DEFINING_VARIABLES "file2c.h"
#include "externdef.h"
```

<h5>externdef.h</h3>

```c
/*
** This header must not contain header guards (like <assert.h> must not).
** Each time it is included, the macro HEADER_DEFINING_VARIABLES should
** be defined with the name (in quotes - or possibly angle brackets) of
** the header to be included that defines variables when the macro
** DEFINE_VARIABLES is defined.  See also: external.h (which uses
** DEFINE_VARIABLES and defines macros EXTERN and INITIALIZE
** appropriately).
**
** #define HEADER_DEFINING_VARIABLES "file2c.h"
** #include "externdef.h"
*/

#if defined(HEADER_DEFINING_VARIABLES)
#define DEFINE_VARIABLES
#include HEADER_DEFINING_VARIABLES
#undef DEFINE_VARIABLES
#undef HEADER_DEFINING_VARIABLES
#endif /* HEADER_DEFINING_VARIABLES */
```

<p>This is getting a tad convoluted, but seems to be secure (using the
`file2d.h`, with no `#undef DEFINE_VARIABLES` in the `file2d.h`).</p>

<h5>file7c.c</h3>

```c
/* Declare variables */
#include "file2d.h"

/* Define variables */
#define HEADER_DEFINING_VARIABLES "file2d.h"
#include "externdef.h"

/* Declare variables - again */
#include "file2d.h"

/* Define variables - again */
#define HEADER_DEFINING_VARIABLES "file2d.h"
#include "externdef.h"

int increment(void) { return global_variable++; }
int oddball_value(void) { return oddball_struct.a + oddball_struct.b; }
```

<h5>file8c.h</h3>

```c
/* Standard prologue */
#if defined(DEFINE_VARIABLES) && !defined(FILE8C_H_DEFINITIONS)
#undef FILE8C_H_INCLUDED
#endif

#ifndef FILE8C_H_INCLUDED
#define FILE8C_H_INCLUDED

#include "external.h"   /* Support macros EXTERN, INITIALIZE */
#include "file2d.h"     /* struct oddball */

#if !defined(DEFINE_VARIABLES) || !defined(FILE8C_H_DEFINITIONS)

/* Global variable declarations / definitions */
EXTERN struct oddball another INITIALIZE({ 14, 34 });

#endif /* !DEFINE_VARIABLES || !FILE8C_H_DEFINITIONS */

/* Standard epilogue */
#ifdef DEFINE_VARIABLES
#define FILE8C_H_DEFINITIONS
#endif /* DEFINE_VARIABLES */

#endif /* FILE8C_H_INCLUDED */
```

<h5>file8c.c</h3>

```c
/* Define variables */
#define HEADER_DEFINING_VARIABLES "file2d.h"
#include "externdef.h"

/* Define variables */
#define HEADER_DEFINING_VARIABLES "file8c.h"
#include "externdef.h"

int increment(void) { return global_variable++; }
int oddball_value(void) { return oddball_struct.a + oddball_struct.b; }
```

<hr>

<em>The next two files complete the source for `prog8` and `prog9`:</em>  

<h5>prog8.c</h3>

```c
#include "file2d.h"
#include <stdio.h>

int main(void)
{
    use_them();
    global_variable += 19;
    use_them();
    printf("Increment: %d\n", increment());
    printf("Oddball:   %d\n", oddball_value());
    return 0;
}
```

<h5>file9c.c</h3>

```c
#include "file2d.h"
#include <stdio.h>

void use_them(void)
{
    printf("Global variable: %d\n", global_variable++);
    oddball_struct.a += global_variable;
    oddball_struct.b -= global_variable / 2;
}
```

<ul>
<li>`prog8` uses `prog8.c`, `file7c.c`, `file9c.c`.</li>
<li>`prog9` uses `prog8.c`, `file8c.c`, `file9c.c`.</li>
</ul>

<hr>

<p>However, the problems are relatively unlikely to occur in practice,
especially if you take the standard advice to</p>

<h5>Avoid global variables</h1>

<hr>

Does this exposition miss anything?  

<p><em>Confession</em>: The 'avoiding duplicated code' scheme outlined here was
developed because the issue affects some code I work on (but don't own),
and is a niggling concern with the scheme outlined in the first part of
the answer.  However, the original scheme leaves you with just two
places to modify to keep variable definitions and declarations
synchronized, which is a big step forward over having exernal variable
declarations scattered throughout the code base (which really matters
when there are thousands of files in total).  However, the code in the
files with the names `fileNc.[ch]` (plus `external.h` and `externdef.h`)
shows that it can be made to work.  Clearly, it would not be hard to
create a header generator script to give you the standardized template
for a variable defining and declaring header file.</p>

<p><em>NB</em> These are toy programs with just barely enough code to make them
marginally interesting.  There is repetition within the examples that
could be removed, but isn't to simplify the pedagogical explanation.
(For example: the difference between `prog5.c` and `prog8.c` is the name
of one of the headers that are included.  It would be possible to
reorganize the code so that the `main()` function was not repeated, but
it would conceal more than it revealed.)</p>

#### Answer 3 (score 122)
An `extern` variable is a declaration (thanks to sbi for the correction) of a variable which is defined in another translation unit. That means the storage for the variable is allocated in another file.  

Say you have two `.c`-files `test1.c` and `test2.c`. If you define a global variable `int test1_var;` in `test1.c` and you'd like to access this variable in `test2.c` you have to use `extern int test1_var;` in `test2.c`.  

Complete sample:  

```c
$ cat test1.c 
int test1_var = 5;
$ cat test2.c
#include <stdio.h>

extern int test1_var;

int main(void) {
    printf("test1_var = %d\n", test1_var);
    return 0;
}
$ gcc test1.c test2.c -o test
$ ./test
test1_var = 5
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: MIN and MAX in C (score [655315](https://stackoverflow.com/q/3437404) in 2015)

#### Question
Where are `MIN` and `MAX` defined in C, if at all?  

What is the best way to implement these, as generically and type safely as possible? (Compiler extensions/builtins for mainstream compilers preferred.)  

#### Answer accepted (score 348)
<blockquote>
  Where are `MIN` and `MAX` defined in C, if at all?  
</blockquote>

They aren't.  

<blockquote>
  What is the best way to implement these, as generically and type safe as possible (compiler extensions/builtins for mainstream compilers preferred).  
</blockquote>

As functions. I wouldn't use macros like `#define MIN(X, Y) (((X) &lt; (Y)) ? (X) : (Y))`, especially if you plan to deploy your code. Either write your own, use something like standard <a href="http://en.cppreference.com/w/c/numeric/math/fmax" rel="noreferrer">`fmax`</a> or <a href="http://en.cppreference.com/w/c/numeric/math/fmin" rel="noreferrer">`fmin`</a>, or fix the macro using <a href="http://gcc.gnu.org/onlinedocs/gcc-4.9.2/gcc/Typeof.html#Typeof" rel="noreferrer">GCC's typeof</a> (you get typesafety bonus too):  

```c
 #define max(a,b) \
   ({ __typeof__ (a) _a = (a); \
       __typeof__ (b) _b = (b); \
     _a > _b ? _a : _b; })
```

Everyone says "oh I know about double evaluation, it's no problem" and a few months down the road, you'll be debugging the silliest problems for hours on end.  

Note the use of `__typeof__` instead of `typeof`:  

<blockquote>
  <p>If you are writing a header file that
  must work when included in ISO C
  programs, write `__typeof__` instead of
  `typeof`.</p>
</blockquote>

#### Answer 2 (score 84)
It's also provided in the GNU libc (Linux) and FreeBSD versions of sys/param.h, and has the definition provided by dreamlax.  

<hr>

On Debian:  

```c
$ uname -sr
Linux 2.6.11

$ cat /etc/debian_version
5.0.2

$ egrep 'MIN\(|MAX\(' /usr/include/sys/param.h
#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

$ head -n 2 /usr/include/sys/param.h | grep GNU
This file is part of the GNU C Library.
```

On FreeBSD:  

```c
$ uname -sr
FreeBSD 5.5-STABLE

$ egrep 'MIN\(|MAX\(' /usr/include/sys/param.h
#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))
```

<hr>

The source repositories are here:  

<ul>
<li><a href="http://sources.redhat.com/git/gitweb.cgi?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/sys/param.h" rel="noreferrer">GNU C Library</a></li>
<li><a href="http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/sys/param.h?rev=1.455;content-type=text/plain" rel="noreferrer">FreeBSD</a></li>
</ul>

#### Answer 3 (score 69)
There's a `std::min` and `std::max` in C++, but AFAIK, there's no equivalent in the C standard library.  You can define them yourself with macros like  

```c
#define MAX(x, y) (((x) > (y)) ? (x) : (y))
#define MIN(x, y) (((x) < (y)) ? (x) : (y))
```

But this causes problems if you write something like `MAX(++a, ++b)`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: typedef struct vs struct definitions (score [645139](https://stackoverflow.com/q/1675351) in 2018)

#### Question
I'm a beginner in C programming, but I was wondering what's the difference between using `typedef` when defining a structure versus not using `typedef`. It seems to me like there's really no difference, they accomplish the same goal.  

```c
struct myStruct{
    int one;
    int two;
};
```

vs.  

```c
typedef struct{
    int one;
    int two;
}myStruct;
```

#### Answer accepted (score 942)
The common idiom is using both:   

```c
typedef struct X { 
    int x; 
} X;
```

They are different definitions. To make the discussion clearer I will split the sentence:  

```c
struct S { 
    int x; 
};

typedef struct S S;
```

In the first line you are defining the identifier `S` within the struct name space (not in the C++ sense). You can use it and define variables or function arguments of the newly defined type by defining the type of the argument as `struct S`:  

```c
void f( struct S argument ); // struct is required here
```

The second line adds a type alias `S` in the global name space and thus allows you to just write:  

```c
void f( S argument ); // struct keyword no longer needed
```

Note that since both identifier name spaces are different, defining `S` both in the structs and global spaces is not an error, as it is not redefining the same identifier, but rather creating a different identifier in a different place.  

To make the difference clearer:  

```c
typedef struct S { 
    int x; 
} T;

void S() { } // correct

//void T() {} // error: symbol T already defined as an alias to 'struct S'
```

You can define a function with the same name of the struct as the identifiers are kept in different spaces, but you cannot define a function with the same name as a `typedef` as those identifiers collide.  

In C++, it is slightly different as the rules to locate a symbol have changed subtly. C++ still keeps the two different identifier spaces, but unlike in C, when you only define the symbol within the class identifier space, you are not required to provide the struct/class keyword:  

```c
 // C++
struct S { 
    int x; 
}; // S defined as a class

void f( S a ); // correct: struct is optional
```

What changes are the search rules, not where the identifiers are defined. The compiler will search the global identifier table and after `S` has not been found it will search for `S` within the class identifiers.  

The code presented before behaves in the same way:  

```c
typedef struct S { 
    int x; 
} T;

void S() {} // correct [*]

//void T() {} // error: symbol T already defined as an alias to 'struct S'
```

After the definition of the `S` function in the second line, the struct S cannot be resolved automatically by the compiler, and to create an object or define an argument of that type you must fall back to including the `struct` keyword:  

```c
// previous code here...
int main() {
    S(); 
    struct S s;
}
```

#### Answer 2 (score 117)
`struct` and `typedef` are two very different things.  

The `struct` keyword is used to define, or to refer to, a structure type. For example, this:  

```c
struct foo {
    int n;
};
```

creates a new type called `struct foo`. The name `foo` is a <em>tag</em>; it's meaningful only when it's immediately preceded by the `struct` keyword, because tags and other identifiers are in distinct <em>name spaces</em>. (This is similar to, but much more restricted than, the C++ concept of `namespace`s.)  

A `typedef`, in spite of the name, does not define a new type; it merely creates a new name for an existing type. For example, given:  

```c
typedef int my_int;
```

`my_int` is a new name for `int`; `my_int` and `int` are <em>exactly</em> the same type. Similarly, given the `struct` definition above, you can write:  

```c
typedef struct foo foo;
```

The type already has a name, `struct foo`.  The `typedef` declaration gives the same type a new name, `foo`.  

The syntax allows you to combine a `struct` and `typedef` into a single declaration:  

```c
typedef struct bar {
    int n;
} bar;
```

This is a common idiom. Now you can refer to this structure type either as `struct bar` or just as `bar`.  

Note that the typedef name doesn't become visible until the end of the declaration. If the structure contains a pointer to itself, you have use the `struct` version to refer to it:  

```c
typedef struct node {
    int data;
    struct node *next; /* can't use just "node *next" here */
} node;
```

Some programmers will use distinct identifiers for the struct tag and for the typedef name. In my opinion, there's no good reason for that; using the same name is perfectly legal and makes it clearer that they're the same type.  If you must use different identifiers, at least use a consistent convention:  

```c
typedef struct node_s {
    /* ... */
} node;
```

(Personally, I prefer to omit the `typedef` and refer to the type as `struct bar`. The `typedef` save a little typing, but it hides the fact that it's a structure type.  If you want the type to be opaque, this can be a good thing. If client code is going to be referring to the member `n` by name, then it's not opaque; it's visibly a structure, and in my opinion it makes sense to refer to it as a structure. But plenty of smart programmers disagree with me on this point. Be prepared to read and understand code written either way.)  

(C++ has different rules. Given a declaration of `struct blah`, you can refer to the type as just `blah`, even without a typedef. Using a typedef might make your C code a little more C++-like -- if you think that's a good thing.)  

#### Answer 3 (score 89)
Another difference not pointed out is that giving the struct a name (i.e. struct myStruct) also enables you to provide forward declarations of the struct.  So in some other file, you could write:  

```c
struct myStruct;
void doit(struct myStruct *ptr);
```

without having to have access to the definition.  What I recommend is you combine your two examples:  

```c
typedef struct myStruct{
    int one;
    int two;
} myStruct;
```

This gives you the convenience of the more concise typedef name but still allows you to use the full struct name if you need.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: How to printf "unsigned long" in C? (score [640953](https://stackoverflow.com/q/3209909) in 2017)

#### Question
I can never understand how to print `unsigned long` datatype in C.  

Suppose `unsigned_foo` is an `unsigned long`, then I try:  

<ul>
<li>`printf("%lu\n", unsigned_foo)`</li>
<li>`printf("%du\n", unsigned_foo)`</li>
<li>`printf("%ud\n", unsigned_foo)`</li>
<li>`printf("%ll\n", unsigned_foo)`</li>
<li>`printf("%ld\n", unsigned_foo)`</li>
<li>`printf("%dl\n", unsigned_foo)`</li>
</ul>

And all of them print some kind of `-123123123` number instead of `unsigned long` that I have.  

#### Answer accepted (score 473)
`%lu` is the correct format for `unsigned long`. Sounds like there are other issues at play here, such as memory corruption or an uninitialized variable. Perhaps show us a larger picture?  

#### Answer 2 (score 28)
<ul>
<li>`%lu` for <strong>unsigned long</strong></li>
<li>`%llu` for <strong>unsigned long long</strong></li>
</ul>

#### Answer 3 (score 23)
Out of all the combinations you tried, `%ld` and `%lu` are the only ones which are valid printf format specifiers at all. `%lu` (long unsigned decimal), `%lx` or `%lX` (long hex with lowercase or uppercase letters), and `%lo` (long octal) are the only valid format specifiers for a variable of type unsigned long (of course you can add field width, precision, etc modifiers between the `%` and the `l`).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: what is Segmentation fault (core dumped)? (score [587699](https://stackoverflow.com/q/19641597) in 2013)

#### Question
I am trying to write a C program in linux that having sqrt of the argument, Here's the code:  

```c
#include<stdlib.h>
#include<stdio.h>
#include<math.h>

int main(char *argv[]){
    float k;
    printf("this is consumer\n");
    k=(float)sqrt(atoi(argv[1]));
    printf("%s\n",k);
    return 0;
}
```

After I type in my input at the "shell> " prompt, gcc gives me the following error:  

```c
Segmentation fault (core dumped)
```

#### Answer accepted (score 117)
"Segmentation fault" means that you tried to access memory that you do not have access to.  

The first problem is with your arguments of `main`. The `main` function should be `int main(int argc, char *argv[])`, and you should check that `argc` is at least 2 before accessing `argv[1]`.  

Also, since you're passing in a `float` to `printf` (which, by the way, gets converted to a `double` when passing to `printf`), you should use the `%f` format specifier. The `%s` format specifier is for strings (`'\0'`-terminated character arrays).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: In C, how should I read a text file and print all strings (score [582393](https://stackoverflow.com/q/3463426) in 2010)

#### Question
I have a text file named `test.txt`  

I want to write a C program that can read this file and print the content to the console (assume the file contains only ASCII text).  

I don't know how to get the size of my string variable. Like this:  

```c
char str[999];
FILE * file;
file = fopen( "test.txt" , "r");
if (file) {
    while (fscanf(file, "%s", str)!=EOF)
        printf("%s",str);
    fclose(file);
}
```

The size `999` doesn't work because the string returned by `fscanf` can be larger than that.  How can I solve this?  

#### Answer accepted (score 120)
The simplest way is to read a character, and print it right after reading:  

```c
int c;
FILE *file;
file = fopen("test.txt", "r");
if (file) {
    while ((c = getc(file)) != EOF)
        putchar(c);
    fclose(file);
}
```

`c` is `int` above, since `EOF` is a negative number, and a plain `char` may be `unsigned`.  

If you want to read the file in chunks, but without dynamic memory allocation, you can do:  

```c
#define CHUNK 1024 /* read 1024 bytes at a time */
char buf[CHUNK];
FILE *file;
size_t nread;

file = fopen("test.txt", "r");
if (file) {
    while ((nread = fread(buf, 1, sizeof buf, file)) > 0)
        fwrite(buf, 1, nread, stdout);
    if (ferror(file)) {
        /* deal with error */
    }
    fclose(file);
}
```

The second method above is essentially how you will read a file with a dynamically allocated array:  

```c
char *buf = malloc(chunk);

if (buf == NULL) {
    /* deal with malloc() failure */
}

/* otherwise do this.  Note 'chunk' instead of 'sizeof buf' */
while ((nread = fread(buf, 1, chunk, file)) > 0) {
    /* as above */
}
```

Your method of `fscanf()` with `%s` as format loses information about whitespace in the file, so it is not exactly copying a file to `stdout`.  

#### Answer 2 (score 54)
There are plenty of good answers here about reading it in chunks, I'm just gonna show you a little trick that reads all the content at once to a buffer and prints it.  

I'm not saying it's better. It's not, and as Ricardo sometimes it can be bad, but I find it's a nice solution for the simple cases.  

I sprinkled it with comments because there's a lot going on.  

```c
#include <stdio.h>
#include <stdlib.h>

char* ReadFile(char *filename)
{
   char *buffer = NULL;
   int string_size, read_size;
   FILE *handler = fopen(filename, "r");

   if (handler)
   {
       // Seek the last byte of the file
       fseek(handler, 0, SEEK_END);
       // Offset from the first to the last byte, or in other words, filesize
       string_size = ftell(handler);
       // go back to the start of the file
       rewind(handler);

       // Allocate a string that can hold it all
       buffer = (char*) malloc(sizeof(char) * (string_size + 1) );

       // Read it all in one operation
       read_size = fread(buffer, sizeof(char), string_size, handler);

       // fread doesn't set it so put a \0 in the last position
       // and buffer is now officially a string
       buffer[string_size] = '\0';

       if (string_size != read_size)
       {
           // Something went wrong, throw away the memory and set
           // the buffer to NULL
           free(buffer);
           buffer = NULL;
       }

       // Always remember to close the file.
       fclose(handler);
    }

    return buffer;
}

int main()
{
    char *string = ReadFile("yourfile.txt");
    if (string)
    {
        puts(string);
        free(string);
    }

    return 0;
}
```

Let me know if it's useful or you could learn something from it :)  

#### Answer 3 (score 12)
Instead just directly print the characters onto the console because the text file maybe very large and you may require a lot of memory.  

```c
#include <stdio.h>
#include <stdlib.h>

int main() {

    FILE *f;
    char c;
    f=fopen("test.txt","rt");

    while((c=fgetc(f))!=EOF){
        printf("%c",c);
    }

    fclose(f);
    return 0;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: warning: implicit declaration of function (score [575586](https://stackoverflow.com/q/8440816) in 2011)

#### Question
My compiler (GCC) is giving me the warning:  

<blockquote>
  warning: implicit declaration of function  
</blockquote>

Please help me understand why is it coming.  

#### Answer accepted (score 202)
You are using a function for which the compiler has not seen a declaration ("<em>prototype</em>") yet.  

For example:  

```c
int main()
{
    fun(2, "21"); /* The compiler has not seen the declaration. */       
    return 0;
}

int fun(int x, char *p)
{
    /* ... */
}
```

You need to declare your function before main, like this, either directly or in a header:  

```c
int fun(int x, char *p);
```

#### Answer 2 (score 17)
The right way is to declare function prototype in header.  

<h5> Example </h1>

<strong>main.h</strong>  

```c
#ifndef MAIN_H
#define MAIN_H

int some_main(const char *name);

#endif
```

<strong>main.c</strong>  

```c
#include "main.h"

int main()
{
    some_main("Hello, World\n");
}

int some_main(const char *name)
{
    printf("%s", name);
}
```

<strong>Alternative with one file (main.c)</strong>  

```c
static int some_main(const char *name);

int some_main(const char *name)
{
    // do something
}
```

#### Answer 3 (score 7)
<p>When you do your #includes in main.c, put the #include reference to the file that contains the referenced function at the top of the include list.
e.g. Say this is main.c and your referenced function is in "SSD1306_LCD.h" </p>

```c
#include "SSD1306_LCD.h"    
#include "system.h"        #include <stdio.h>
#include <stdlib.h>
#include <xc.h>
#include <string.h>
#include <math.h>
#include <libpic30.h>       // http://microchip.wikidot.com/faq:74
#include <stdint.h>
#include <stdbool.h>
#include "GenericTypeDefs.h"  // This has the 'BYTE' type definition
```

The above will not generate the "implicit declaration of function" error, but below will-   

```c
#include "system.h"        
#include <stdio.h>
#include <stdlib.h>
#include <xc.h>
#include <string.h>
#include <math.h>
#include <libpic30.h>       // http://microchip.wikidot.com/faq:74
#include <stdint.h>
#include <stdbool.h>
#include "GenericTypeDefs.h"     // This has the 'BYTE' type definition
#include "SSD1306_LCD.h"    
```

Exactly the same #include list, just different order.  

Well, it did for me.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: What is the printf format specifier for bool? (score [575382](https://stackoverflow.com/q/17307275) in )

#### Question
Since ANSI C99 there is `_Bool` or `bool` via `stdbool.h`. But is there also a `printf` format specifier for bool?  

I mean something like in that pseudo code:  

```c
bool x = true;
printf("%B\n", x);
```

which would print:  

```c
true
```

#### Answer accepted (score 615)
There isn't. But since any integral type shorter than `int` is promoted to `int` when passed down to `printf()`s variadic arguments, you can use `%d`:  

```c
bool x = true;
printf("%d\n", x); // prints 1
```

But why not  

```c
printf(x ? "true" : "false");
```

or better  

```c
printf("%s", x ? "true" : "false");
```

or even better  

```c
fputs(x ? "true" : "false", stdout);
```

instead?  

#### Answer 2 (score 39)
There is no format specifier for bool. You can print it using some of the existing specifiers for printing integral types or do something more fancy:  

```c
 printf("%s", x?"true":"false");
```

#### Answer 3 (score 30)
ANSI C99/C11 don't include an extra printf conversion specifier for `bool`.  

But the <a href="http://www.gnu.org/software/libc/manual/html_node/Customizing-Printf.html">GNU C library provides an API for adding custom specifiers</a>.  

An example:  

```c
#include <stdio.h>
#include <printf.h>
#include <stdbool.h>

static int bool_arginfo(const struct printf_info *info, size_t n,
    int *argtypes, int *size)
{
  if (n) {
    argtypes[0] = PA_INT;
    *size = sizeof(bool);
  }
  return 1;
}
static int bool_printf(FILE *stream, const struct printf_info *info,
    const void *const *args)
{
  bool b =  *(const bool*)(args[0]);
  int r = fputs(b ? "true" : "false", stream);
  return r == EOF ? -1 : (b ? 4 : 5);
}
static int setup_bool_specifier()
{
  int r = register_printf_specifier('B', bool_printf, bool_arginfo);
  return r;
}
int main(int argc, char **argv)
{
  int r = setup_bool_specifier();
  if (r) return 1;
  bool b = argc > 1;
  r = printf("The result is: %B\n", b);
  printf("(written %d characters)\n", r);
  return 0;
}
```

Since it is a glibc extensions the GCC warns about that custom specifier:  

<pre>
$ gcc -Wall -g    main.c   -o main
main.c: In function ‘main’:
main.c:34:3: warning: unknown conversion type character ‘B’ in format [-Wformat=]
   r = printf("The result is: %B\n", b);
   ^
main.c:34:3: warning: too many arguments for format [-Wformat-extra-args]
</pre>

Output:  

<pre>
$ ./main
The result is: false
(written 21 characters)
$ ./main 1
The result is: true
(written 20 characters)
</pre>

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: How to convert integer to char in C? (score [574458](https://stackoverflow.com/q/2279379) in 2015)

#### Question
How to convert integer to char in C?  

#### Answer 2 (score 82)
A char in C is already a number (the character's ASCII code), no conversion required.  

If you want to convert a digit to the corresponding character, you can simply add '0':  

```c
c = i +'0';
```

The '0' is a character in the ASCll table.   

#### Answer 3 (score 22)
<p>You can try atoi() library function.
Also sscanf() and sprintf() would help.</p>

Here is a small example to show converting integer to character string:  

```c
main()
{
  int i = 247593;
  char str[10];

  sprintf(str, "%d", i);
  // Now str contains the integer as characters
} 
```

Here for another Example  

```c
#include <stdio.h>

int main(void)
{
   char text[] = "StringX";
   int digit;
   for (digit = 0; digit < 10; ++digit)
   {
      text[6] = digit + '0';
      puts(text);
   }
   return 0;
}

/* my output
String0
String1
String2
String3
String4
String5
String6
String7
String8
String9
*/
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: Split string with delimiters in C (score [572995](https://stackoverflow.com/q/9210528) in 2013)

#### Question
How do I write a function to split and return an array for a string with delimiters in the C programming language?  

```c
char* str = "JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC";
str_split(str,',');
```

#### Answer accepted (score 154)
You can use the <a href="http://en.cppreference.com/w/c/string/byte/strtok">`strtok()`</a> function to split a string (and specify the delimiter to use). Note that `strtok()` will modify the string passed into it. If the original string is required elsewhere make a copy of it and pass the copy to `strtok()`.  

EDIT:  

Example (note it does not handle consecutive delimiters, "JAN,,,FEB,MAR" for example):  

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

char** str_split(char* a_str, const char a_delim)
{
    char** result    = 0;
    size_t count     = 0;
    char* tmp        = a_str;
    char* last_comma = 0;
    char delim[2];
    delim[0] = a_delim;
    delim[1] = 0;

    /* Count how many elements will be extracted. */
    while (*tmp)
    {
        if (a_delim == *tmp)
        {
            count++;
            last_comma = tmp;
        }
        tmp++;
    }

    /* Add space for trailing token. */
    count += last_comma < (a_str + strlen(a_str) - 1);

    /* Add space for terminating null string so caller
       knows where the list of returned strings ends. */
    count++;

    result = malloc(sizeof(char*) * count);

    if (result)
    {
        size_t idx  = 0;
        char* token = strtok(a_str, delim);

        while (token)
        {
            assert(idx < count);
            *(result + idx++) = strdup(token);
            token = strtok(0, delim);
        }
        assert(idx == count - 1);
        *(result + idx) = 0;
    }

    return result;
}

int main()
{
    char months[] = "JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC";
    char** tokens;

    printf("months=[%s]\n\n", months);

    tokens = str_split(months, ',');

    if (tokens)
    {
        int i;
        for (i = 0; *(tokens + i); i++)
        {
            printf("month=[%s]\n", *(tokens + i));
            free(*(tokens + i));
        }
        printf("\n");
        free(tokens);
    }

    return 0;
}
```

Output:  

```c
$ ./main.exe
months=[JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC]

month=[JAN]
month=[FEB]
month=[MAR]
month=[APR]
month=[MAY]
month=[JUN]
month=[JUL]
month=[AUG]
month=[SEP]
month=[OCT]
month=[NOV]
month=[DEC]
```

#### Answer 2 (score 66)
I think `strsep` is still the best tool for this:  

```c
while ((token = strsep(&str, ","))) my_fn(token);
```

That is literally one line that splits a string.  

The extra parentheses are a stylistic element to indicate that we're intentionally testing the result of an assignment, not an equality operator `==`.  

For that pattern to work, `token` and `str` both have type `char *`. If you started with a string literal, then you'd want to make a copy of it first:  

```c
// More general pattern:
const char *my_str_literal = "JAN,FEB,MAR";
char *token, *str, *tofree;

tofree = str = strdup(my_str_literal);  // We own str's memory now.
while ((token = strsep(&str, ","))) my_fn(token);
free(tofree);
```

If two delimiters appear together in `str`, you'll get a `token` value that's the empty string. The value of `str` is modified in that each delimiter encountered is overwritten with a zero byte - another good reason to copy the string being parsed first.  

In a comment, someone suggested that `strtok` is better than `strsep` because `strtok` is more portable. Ubuntu and Mac OS X have `strsep`; it's safe to guess that other unixy systems do as well. Windows lacks `strsep`, but it has `strbrk` which enables this short and sweet `strsep` replacement:  

```c
char *strsep(char **stringp, const char *delim) {
  if (*stringp == NULL) { return NULL; }
  char *token_start = *stringp;
  *stringp = strpbrk(token_start, delim);
  if (*stringp) {
    **stringp = '\0';
    (*stringp)++;
  }
  return token_start;
}
```

<a href="https://stackoverflow.com/a/7219504/3561">Here</a> is a good explanation of `strsep` vs `strtok`. The pros and cons may be judged subjectively; however, I think it's a telling sign that `strsep` was designed as a replacement for `strtok`.  

#### Answer 3 (score 25)
String tokenizer this code should put you in the right direction.  

```c
int main(void) {
  char st[] ="Where there is will, there is a way.";
  char *ch;
  ch = strtok(st, " ");
  while (ch != NULL) {
  printf("%s\n", ch);
  ch = strtok(NULL, " ,");
  }
  getch();
  return 0;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: How to convert an int to string in C? (score [565158](https://stackoverflow.com/q/8257714) in 2018)

#### Question
How do you convert an `int` (integer) to a string? I'm trying to make a function that converts the data of a `struct` into a string to save it in a file.  

#### Answer accepted (score 75)
<strong>EDIT:</strong>  As pointed out in the comment, `itoa()` is not a standard, so better use sprintf() approach suggested in the rivaling answer!  

<hr>

You can use `itoa()` function to <strong>convert</strong> your integer value to a string.  

Here is an example:  

```c
int num = 321;
char snum[5];

// convert 123 to string [buf]
itoa(num, snum, 10);

// print our string
printf("%s\n", snum);
```

<hr>

If you want to output your structure into a file there is no need to convert any value beforehand. You can just use the <a href="http://www.cplusplus.com/reference/clibrary/cstdio/printf/" rel="noreferrer">printf format specification</a> to indicate how to output your values and use any of the operators from <a href="http://www.tenouk.com/clabworksheet/labworksheet4.html" rel="noreferrer">printf family</a> to output your data.  

#### Answer 2 (score 176)
You can use `sprintf` to do it, or maybe `snprintf` if you have it:  

```c
char str[ENOUGH];
sprintf(str, "%d", 42);
```

Where the number of characters (plus terminating char) in the `str` can be calculated using:  

```c
(int)((ceil(log10(num))+1)*sizeof(char))
```

#### Answer 3 (score 49)
The short answer is:  

```c
snprintf( str, size, "%d", x );
```

The longer is: first you need to find out sufficient size. `snprintf` tells you length if you call it with `NULL, 0` as first parameters:  

```c
snprintf( NULL, 0, "%d", x );
```

Allocate one character more for null-terminator.  

```c
int x = -42;
int length = snprintf( NULL, 0, "%d", x );
char* str = malloc( length + 1 );
snprintf( str, length + 1, "%d", x );
...
free(str);
```

If works for every format string, so you can convert float or double to string by using `"%g"`, you can convert int to hex using `"%x"`, and so on.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: Write to .txt file? (score [558915](https://stackoverflow.com/q/11573974) in 2014)

#### Question
<p>How can I write a little piece of text into a `.txt` file?
I've been Googling for over 3-4 hours, but can't find out how to do it.</p>

`fwrite();` has so many arguments, and I don't know how to use it.  

What's the easiest function to use when you only want to write a name and a few numbers to a `.txt` file?  

Edit: Added a piece of my code.  

```c
    char name;
    int  number;
    FILE *f;
    f = fopen("contacts.pcl", "a");

    printf("\nNew contact name: ");
    scanf("%s", &name);
    printf("New contact number: ");
    scanf("%i", &number);


    fprintf(f, "%c\n[ %d ]\n\n", name, number);
    fclose(f);
```

#### Answer accepted (score 251)
```c
FILE *f = fopen("file.txt", "w");
if (f == NULL)
{
    printf("Error opening file!\n");
    exit(1);
}

/* print some text */
const char *text = "Write this to the file";
fprintf(f, "Some text: %s\n", text);

/* print integers and floats */
int i = 1;
float py = 3.1415927;
fprintf(f, "Integer: %d, float: %f\n", i, py);

/* printing single chatacters */
char c = 'A';
fprintf(f, "A character: %c\n", c);

fclose(f);
```

#### Answer 2 (score 20)
```c
FILE *fp;
char* str = "string";
int x = 10;

fp=fopen("test.txt", "w");
if(fp == NULL)
    exit(-1);
fprintf(fp, "This is a string which is written to a file\n");
fprintf(fp, "The string has %d words and keyword %s\n", x, str);
fclose(fp);
```

#### Answer 3 (score -1)
Well, you need to first get a good book on C and understand the language.  

```c
FILE *fp;
fp = fopen("c:\\test.txt", "wb");
if(fp == null)
   return;
char x[10]="ABCDEFGHIJ";
fwrite(x, sizeof(x[0]), sizeof(x)/sizeof(x[0]), fp);
fclose(fp);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: Undefined reference to pthread_create in Linux (score [550266](https://stackoverflow.com/q/1662909) in 2017)

#### Question
I picked up the following demo off the web from <a href="https://computing.llnl.gov/tutorials/pthreads/" rel="noreferrer">https://computing.llnl.gov/tutorials/pthreads/</a>  

```c
#include <pthread.h>
#include <stdio.h>
#define NUM_THREADS     5

void *PrintHello(void *threadid)
{
   long tid;
   tid = (long)threadid;
   printf("Hello World! It's me, thread #%ld!\n", tid);
   pthread_exit(NULL);
}

int main (int argc, char *argv[])
{
   pthread_t threads[NUM_THREADS];
   int rc;
   long t;
   for(t=0; t<NUM_THREADS; t++){
      printf("In main: creating thread %ld\n", t);
      rc = pthread_create(&threads[t], NULL, PrintHello, (void *)t);
      if (rc){
         printf("ERROR; return code from pthread_create() is %d\n", rc);
         exit(-1);
      }
   }
   pthread_exit(NULL);
}
```

But when I compile it on my machine (running Ubuntu Linux 9.04) I get the following error:  

```c
corey@ubuntu:~/demo$ gcc -o term term.c
term.c: In function ‘main’:
term.c:23: warning: incompatible implicit declaration of built-in function ‘exit’
/tmp/cc8BMzwx.o: In function `main':
term.c:(.text+0x82): undefined reference to `pthread_create'
collect2: ld returned 1 exit status
```

This doesn't make any sense to me, because the header includes `pthread.h`, which should have the `pthread_create` function. Any ideas what's going wrong?  

#### Answer 2 (score 630)
<p>Both answers to this question so far are <em>incorrect</em>.<br>
For Linux the correct command is:</p>

```c
gcc -pthread -o term term.c
```

In general, libraries should follow sources and objects on command line, and `-lpthread` is not an "option", it's a library specification. On a system with only `libpthread.a` installed,   

```c
gcc -lpthread ...
```

will fail to link.  

#### Answer 3 (score 35)
in eclipse   

properties->c/c++Build->setting->GCC C++ linker->libraries in top part add "pthread"  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: Fastest way to check if a file exist using standard C++/C++11/C? (score [550079](https://stackoverflow.com/q/12774207) in 2017)

#### Question
I would like to find the fastest way to check if a file exist in standard C++11, C++, or C. I have thousands of files and before doing something on them I need to check if all of them exist. What can I write instead of `/* SOMETHING */` in the following function?    

```c
inline bool exist(const std::string& name)
{
    /* SOMETHING */
}
```

#### Answer accepted (score 694)
Well I threw together a test program that ran each of these methods 100,000 times, half on files that existed and half on files that didn't.  

```c
#include <sys/stat.h>
#include <unistd.h>
#include <string>
#include <fstream>

inline bool exists_test0 (const std::string& name) {
    ifstream f(name.c_str());
    return f.good();
}

inline bool exists_test1 (const std::string& name) {
    if (FILE *file = fopen(name.c_str(), "r")) {
        fclose(file);
        return true;
    } else {
        return false;
    }   
}

inline bool exists_test2 (const std::string& name) {
    return ( access( name.c_str(), F_OK ) != -1 );
}

inline bool exists_test3 (const std::string& name) {
  struct stat buffer;   
  return (stat (name.c_str(), &buffer) == 0); 
}
```

Results for total time to run the 100,000 calls averaged over 5 runs,  

```c
Method exists_test0 (ifstream): **0.485s**
Method exists_test1 (FILE fopen): **0.302s**
Method exists_test2 (posix access()): **0.202s**
Method exists_test3 (posix stat()): **0.134s**
```

The `stat()` function provided the best performance on my system (Linux, compiled with `g++`), with a standard `fopen` call being your best bet if you for some reason refuse to use POSIX functions.  

#### Answer 2 (score 118)
Remark : in C++14 and as soon as the <a href="http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n4099.html" rel="noreferrer">filesystem TS</a> will be finished and adopted, the solution will be to use:  

```c
std::experimental::filesystem::exists("helloworld.txt");
```

and since C++17, only:  

```c
std::filesystem::exists("helloworld.txt");
```

#### Answer 3 (score 104)
I use this piece of code, it works OK with me so far. This does not use many fancy features of C++:  

```c
bool is_file_exist(const char *fileName)
{
    std::ifstream infile(fileName);
    return infile.good();
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: What is a "static" function? (score [546371](https://stackoverflow.com/q/558122) in 2017)

#### Question
The question was about plain <a href="/questions/tagged/c" class="post-tag" title="show questions tagged &#39;c&#39;" rel="tag">c</a> functions, not <a href="/questions/tagged/c%2b%2b" class="post-tag" title="show questions tagged &#39;c++&#39;" rel="tag">c++</a> `static` methods, as clarified in comments.  

Ok, I understand what a `static` variable is, but what is a `static` function?  

And why is it that if I declare a function, let's say `void print_matrix`, in let's say `a.c` (WITHOUT `a.h`) and include `"a.c"` -  I get `"print_matrix@@....) already defined in a.obj"`, BUT if I declare it as `static void print_matrix` then it compiles?  

<strong>UPDATE</strong> Just to clear things up - I know that including `.c` is bad, as many of you pointed out. I just do it to temporarily clear space in `main.c` until I have a better idea of how to group all those functions into proper `.h` and `.c` files. Just a temporary, quick solution.  

#### Answer accepted (score 629)
`static` functions are functions that are only visible to other functions in the same file (more precisely <em>the same <a href="http://en.wikipedia.org/wiki/Translation_unit_%28programming%29" rel="noreferrer">translation unit</a></em>).  

<strong>EDIT</strong>: For those who thought, that the author of the questions meant a 'class method': As the question is tagged `C` he means a plain old C function. For (C++/Java/...) class methods, `static` means that this method can be called on the class itself, no instance of that class necessary.  

#### Answer 2 (score 189)
There is a big difference between static functions in C and static member functions in C++.  In C, a static function is not visible outside of its translation unit, which is the object file it is compiled into.  In other words, making a function static limits its scope.  You can think of a static function as being "private" to its *.c file (although that is not strictly correct).  

In C++, "static" can also apply to member functions and data members of classes.  A static data member is also called a "class variable", while a non-static data member is an "instance variable". This is Smalltalk terminology.  This means that there is only one copy of a static data member shared by all objects of a class, while each object has its own copy of a non-static data member.  So a static data member is essentially a global variable, that is a member of a class.  

Non-static member functions can access all data members of the class: static and non-static.  Static member functions can only operate on the static data members.  

One way to think about this is that in C++ static data members and static member functions do not belong to any object, but to the entire class.  

#### Answer 3 (score 75)
There are two uses for the keyword static when it comes to functions in C++.  

The first is to mark the function as having internal linkage so it cannot be referenced in other translation units. This usage is deprecated in C++. Unnamed namespaces are preferred for this usage.  

```c
// inside some .cpp file:

static void foo();    // old "C" way of having internal linkage

// C++ way:
namespace
{
   void this_function_has_internal_linkage()
   {
      // ...
   }
}
```

The second usage is in the context of a class. If a class has a static member function, that means the function is a member of the class (and has the usual access to other members), but it doesn't need to be invoked through a particular object. In other words, inside that function, there is no "this" pointer.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: What is a segmentation fault? (score [539500](https://stackoverflow.com/q/2346806) in 2016)

#### Question
What is a segmentation fault? Is it different in C and C++? How are segmentation faults and dangling pointers related?  

#### Answer accepted (score 610)
Segmentation fault is a specific kind of error caused by accessing memory that “does not belong to you.” It’s a helper mechanism that keeps you from corrupting the memory and introducing hard-to-debug memory bugs. Whenever you get a segfault you know you are doing something wrong with memory – accessing variable that has already been freed, writing to a read-only portion of the memory, etc. Segmentation fault is essentially the same in most languages that let you mess with the memory management, there is no principial difference between segfaults in C and C++.  

There are many ways to get a segfault, at least in the lower-level languages such as C(++). A common way to get a segfault is to dereference a null pointer:  

```c
int *p = NULL;
*p = 1;
```

Another segfault happens when you try to write to a portion of memory that was marked as read-only:  

```c
char *str = "Foo"; // Compiler marks the constant string as read-only
*str = 'b'; // Which means this is illegal and results in a segfault
```

Dangling pointer points to a thing that does not exist any more, like here:  

```c
char *p = NULL;
{
    char c;
    p = &c;
}
// Now p is dangling
```

The pointer `p` dangles because it points to character variable `c` that ceased to exist after the block ended. And when you try to dereference dangling pointer (like `*p='A'`), you would probably get a segfault.  

#### Answer 2 (score 106)
It would be worth noting that segmentation fault isn't caused by directly accessing another process memory (this is what I'm hearing sometimes), as it is simply not possible. With virtual memory every process has its own virtual address space and there is no way to access another one using any value of pointer. Exception to this can be shared libraries which are same physical address space mapped to (possibly) different virtual addresses and kernel memory which is even mapped in the same way in every process (to avoid TLB flushing on syscall, I think). And things like shmat ;) - these are what I count as 'indirect' access. One can, however, check that they are usually located long way from process code and we are usually able to access them (this is why they are there, nevertheless accessing them in a improper way will produce segmentation fault).  

Still, segmentation fault can occur in case of accessing our own (process) memory in improper way (for instance trying to write to non-writable space). But the most common reason for it is the access to the part of the virtual address space that is <em>not mapped</em> to physical one at all.  

And all of this with respect to virtual memory systems.  

#### Answer 3 (score 33)
A segmentation fault is caused by a request for a page that the process does not have listed in its descriptor table, or an invalid request for a page that it does have listed (e.g. a write request on a read-only page).  

A dangling pointer is a pointer that may or may not point to a valid page, but does point to an "unexpected" segment of memory.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: What is an unsigned char? (score [539232](https://stackoverflow.com/q/75191) in 2016)

#### Question
In C/C++, what an `unsigned char` is used for? How is it different from a regular `char`?  

#### Answer accepted (score 523)
In C++, there are three <em>distinct</em> character types:  

<ul>
<li>`char`</li>
<li>`signed char`</li>
<li>`unsigned char`</li>
</ul>

If you are using character types for <em>text</em>, use the unqualified `char`:  

<ul>
<li>it is the type of character literals like `'a'` or `'0'`.</li>
<li>it is the type that makes up C strings like `"abcde"`</li>
</ul>

It also works out as a number value, but it is unspecified whether that value is treated as signed or unsigned. Beware character comparisons through inequalities - although if you limit yourself to ASCII (0-127) you're just about safe.  

If you are using character types as <em>numbers</em>, use:  

<ul>
<li>`signed char`, which gives you <em>at least</em> the -127 to 127 range. (-128 to 127 is common)</li>
<li>`unsigned char`, which gives you <em>at least</em> the 0 to 255 range.</li>
</ul>

"At least", because the C++ standard only gives the minimum range of values that each numeric type is required to cover. `sizeof (char)` is required to be 1 (i.e. one byte), but a byte could in theory be for example 32 bits. <strong>`sizeof` would still be report its size as `1`</strong> - meaning that you <em>could</em> have `sizeof (char) == sizeof (long) == 1`.  

#### Answer 2 (score 84)
This is implementation dependent, as the C standard does NOT define the signed-ness of `char`.  Depending on the platform, char may be `signed` or `unsigned`, so you need to explicitly ask for `signed char` or `unsigned char` if your implementation depends on it.  Just use `char` if you intend to represent characters from strings, as this will match what your platform puts in the string.  

The difference between `signed char` and `unsigned char` is as you'd expect.  On most platforms, `signed char` will be an 8-bit two's complement number ranging from `-128` to `127`, and `unsigned char` will be an 8-bit unsigned integer (`0` to `255`).  Note the standard does NOT require that `char` types have 8 bits, only that `sizeof(char)` return `1`.  You can get at the number of bits in a char with `CHAR_BIT` in `limits.h`.  There are few if any platforms today where this will be something other than `8`, though.  

There is a nice summary of this issue <a href="http://www.arm.linux.org.uk/docs/faqs/signedchar.php" rel="noreferrer">here</a>.  

As others have mentioned since I posted this, you're better off using `int8_t` and `uint8_t` if you really want to represent small integers.  

#### Answer 3 (score 34)
Because i feel it's really called for, i just want to state some rules of C and C++ (they are the same in this regard). First, <em>all bits</em> of `unsigned char` participate in determining the value if any unsigned char object. Second, `unsigned char` is explicitly stated unsigned.  

Now, i had a discussion with someone about what happens when you convert the value `-1` of type int to `unsigned char`. He refused the idea that the resulting `unsigned char` has all its bits set to 1, because he was worried about sign representation. But he don't have to. It's immediately following out of this rule that the conversion does what is intended:  

<blockquote>
  <p>If the new type is unsigned, the value is converted by repeatedly adding or
  subtracting one more than the maximum value that can be represented in the new type
  until the value is in the range of the new type. (`6.3.1.3p2` in a C99 draft)</p>
</blockquote>

That's a mathematical description. C++ describes it in terms of modulo calculus, which yields to the same rule. Anyway, what is <em>not</em> guaranteed is that all bits in the integer `-1` are one before the conversion. So, what do we have so we can claim that the resulting `unsigned char` has all its `CHAR_BIT` bits turned to 1?  

<ol>
<li>All bits participate in determining its value - that is, no padding bits occur in the object. </li>
<li>Adding only one time `UCHAR_MAX+1` to `-1` will yield a value in range, namely `UCHAR_MAX`</li>
</ol>

That's enough, actually! So whenever you want to have an `unsigned char` having all its bits one, you do  

```c
unsigned char c = (unsigned char)-1;
```

It also follows that a conversion is <em>not</em> just truncating higher order bits. The fortunate event for <em>two's complement</em> is that it is just a truncation there, but the same isn't necessarily true for other sign representations.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: What is the difference between #include <filename> and #include "filename"? (score [537618](https://stackoverflow.com/q/21593) in 2016)

#### Question
In the C and C++ programming languages, what is the difference between using angle brackets and using quotes in an `include` statement, as follows?  

<ol>
<li>`#include &lt;filename&gt;` </li>
<li>`#include "filename"`</li>
</ol>

#### Answer 2 (score 1283)
In practice, the difference is in the location where the preprocessor searches for the included file.   

For `#include &lt;filename&gt;` the preprocessor searches in an implementation dependent manner, normally in search directories pre-designated by the compiler/IDE. This method is normally used to include standard library header files.  

For `#include "filename"` the preprocessor searches first in the same directory as the file containing the directive, and then follows the search path used for the `#include &lt;filename&gt;` form. This method is normally used to include programmer-defined header files.  

A more complete description is available in the GCC <a href="https://gcc.gnu.org/onlinedocs/cpp/Search-Path.html" rel="noreferrer">documentation on search paths</a>.  

#### Answer 3 (score 674)
The only way to know is to read your implementation's documentation.  

In <a href="http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf#page=182" rel="noreferrer">the C standard</a>, section 6.10.2, paragraphs 2 to 4 state:  

<blockquote>
  <ul>
  <li><p>A preprocessing directive of the form</p>

```c
#include <h-char-sequence> new-line
```
  
  searches a sequence of implementation-defined places for a <strong>header</strong> identified uniquely by the specified sequence between the `&lt;` and `&gt;` delimiters, and causes the replacement of that directive by the entire contents of the <strong>header</strong>. How the places are specified or the header identified is implementation-defined.  </li>
  <li><p>A preprocessing directive of the form</p>

```c
#include "q-char-sequence" new-line
```
  
  causes the replacement of that directive by the entire contents of the <strong>source file</strong> identified by the specified sequence between the `"` delimiters. The named <strong>source file</strong> is searched for in an implementation-defined manner. If this search is not supported, or if the search fails, the directive is reprocessed as if it read  

```c
#include <h-char-sequence> new-line
```
  
  <p>with the identical contained sequence (including `&gt;` characters, if any) from the original
  directive.</p></li>
  <li><p>A preprocessing directive of the form</p>

```c
#include pp-tokens new-line
```
  
  (that does not match one of the two previous forms) is permitted. The preprocessing tokens after `include` in the directive are processed just as in normal text. (Each identifier currently defined as a macro name is replaced by its replacement list of preprocessing tokens.) The directive resulting after all replacements shall match one of the two previous forms. The method by which a sequence of preprocessing tokens between a `&lt;` and a `&gt;` preprocessing token pair or a pair of `"` characters is combined into a single header name preprocessing token is implementation-defined.  </li>
  </ul>
  
  <h5>Definitions:</h3>
  
  <ul>
  <li><p>h-char: any member of the source character set except the new-line character and `&gt;`</p></li>
  <li><p>q-char: any member of the source character set except the new-line character and `"`</p></li>
  </ul>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Use of exit() function (score [533873](https://stackoverflow.com/q/2425167) in 2013)

#### Question
I want to know how and when can I use the `exit()` function like the program in my book:  

```c
#include<stdio.h>

void main()
{
    int goals;
    printf("enter number of goals scored");
    scanf("%d",&goals);

    if(goals<=5)
        goto sos;
    else
    {
        printf("hehe");
        exit( );
    }
    sos:
    printf("to err is human");
}
```

When I run it, it shows ERROR: <em>call to undefined function exit()</em>.  

Also, I want to know how I can create an option to close the window in which the program runs? For example, I made a menu-driven program which had several options and one of them was <em>"exit the menu"</em>. How can I make this exit the program (i.e. close the window)?  

#### Answer accepted (score 159)
Try using `exit(0);` instead. The <a href="http://man7.org/linux/man-pages/man3/exit.3.html" rel="noreferrer">`exit`</a> function expects an integer parameter. And don't forget to `#include &lt;stdlib.h&gt;`.  

#### Answer 2 (score 80)
The `exit` function is declared in the stdlib header, so you need to have  

```c
#include <stdlib.h>
```

at the top of your program to be able to use `exit`.  

Note also that `exit` takes an integer argument, so you can't call it like `exit()`, you have to call as `exit(0)` or `exit(42)`. 0 usually means your program completed successfully, and nonzero values are used as error codes.  

There are also predefined macros `EXIT_SUCCESS` and `EXIT_FAILURE`, e.g. `exit(EXIT_SUCCESS);`  

#### Answer 3 (score 11)
`exit(int code);` is declared in `stdlib.h` so you need an  

```c
#include <stdlib.h>
```

<p>Also:<br>
- You have no parameter for the `exit()`, it requires an `int` so provide one.<br>
- Burn this book, it uses `goto` which is (for everyone but linux kernel hackers) bad, very, <em>very</em>, VERY bad.</p>

<p>Edit:<br>
Oh, and</p>

```c
void main()
```

is bad, too, it's:  

```c
int main(int argc, char *argv[])
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Is the size of C "int" 2 bytes or 4 bytes? (score [523652](https://stackoverflow.com/q/11438794) in 2014)

#### Question
Does an Integer variable in C occupy 2 bytes or 4 bytes? What are the factors that it depends on?  

<p>Most of the textbooks say integer variables occupy 2 bytes.
But when I run a program printing the successive addresses of an array of integers it shows the difference of 4.</p>

#### Answer 2 (score 160)
I know it's equal to `sizeof(int)`. The size of an `int` is really compiler dependent. Back in the day, when processors were 16 bit, an `int` was 2 bytes. Nowadays, it's most often 4 bytes on a 32-bit as well as 64-bit systems.   

Still, using `sizeof(int)` is the best way to get the size of an integer for the specific system the program is executed on.  

<strong>EDIT:</strong> Fixed wrong statement that `int` is 8 bytes on most 64-bit systems. For example, it is 4 bytes on 64-bit GCC.  

#### Answer 3 (score 97)
This is one of the points in C that can be confusing at first, but the C standard only specifies a <em>minimum range</em> for integer types that is guaranteed to be supported. `int` is guaranteed to be able to hold -32767 to 32767, which requires 16 bits. In that case, `int`, is 2 bytes. However, implementations are free to go beyond that minimum, as you will see that many modern compilers make `int` 32-bit (which also means 4 bytes pretty ubiquitously).  

The reason your book says 2 bytes is most probably because it's old.  At one time, this was the norm. In general, you should always use the `sizeof` operator if you need to find out how many bytes it is on the platform you're using.  

To address this, C99 added new types where you can explicitly ask for a certain sized integer, for example `int16_t` or `int32_t`.  Prior to that, there was no universal way to get an integer of a specific width (although most platforms provided similar types on a per-platform basis).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: C char array initialization (score [523179](https://stackoverflow.com/q/18688971) in 2015)

#### Question
I'm not sure what will be in the char array after initialization in the following ways.      

<p>1.`char buf[10] = "";`<br>
2. `char buf[10] = " ";`<br>
3. `char buf[10] = "a";`  </p>

For case 2, I think `buf[0]` should be `' '`, `buf[1]` should be `'\0'`, and from `buf[2]` to `buf[9]` will be random content. For case 3, I think `buf[0]` should be `'a'`, `buf[1]` should be '\0', and from `buf[2]` to `buf[9]` will be random content.  

Is that correct?  

And for the case 1, what will be in the `buf`? `buf[0] == '\0'` and from `buf[1]` to `buf[9]` will be random content?  

#### Answer accepted (score 193)
This is not how you initialize an array, but for:  

<ol>
<li><p>The first declaration:</p>

```c
char buf[10] = "";
```

is equivalent to  

```c
char buf[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
```</li>
<li><p>The second declaration:</p>

```c
char buf[10] = " ";
```

is equivalent to  

```c
char buf[10] = {' ', 0, 0, 0, 0, 0, 0, 0, 0, 0};
```</li>
<li><p>The third declaration:</p>

```c
char buf[10] = "a";
```

is equivalent to  

```c
char buf[10] = {'a', 0, 0, 0, 0, 0, 0, 0, 0, 0};
```</li>
</ol>

As you can see, no random content: if there are fewer initializers, the remaining of the array is initialized with `0`. This the case even if the array is declared inside a function.  

#### Answer 2 (score 22)
<em>Edit: OP (or an editor) silently changed some of the single quotes in the original question to double quotes at some point after I provided this answer.</em>   

Your code will result in compiler errors. Your first code fragment:  

```c
char buf[10] ; buf = ''
```

is doubly illegal. First, in C, there is no such thing as an empty `char`. You can use double quotes to designate an empty string, as with:  

```c
char* buf = ""; 
```

That will give you a pointer to a `NUL` string, i.e., a single-character string with only the `NUL` character in it. But you cannot use single quotes with nothing inside them--that is undefined. If you need to designate the `NUL` character, you have to specify it:  

```c
char buf = '\0';
```

The backslash is necessary to disambiguate from character `'0'`.   

```c
char buf = 0;
```

accomplishes the same thing, but the former is a tad less ambiguous to read, I think.   

Secondly, you cannot initialize arrays after they have been defined.   

```c
char buf[10];
```

declares and defines the array. The array identifier `buf` is now an address in memory, and you cannot change where `buf` points through assignment. So   

```c
buf =     // anything on RHS
```

is illegal. Your second and third code fragments are illegal for this reason.  

To initialize an array, you have to do it at the time of definition:  

```c
char buf [10] = ' ';
```

will give you a 10-character array with the first char being the space `'\040'` and the rest being `NUL`, i.e., `'\0'`. When an array is declared and defined with an initializer, the array elements (if any) past the ones with specified initial values are automatically padded with `0`. There will not be any "random content".  

If you declare and define the array but don't initialize it, as in the following:  

```c
char buf [10];
```

you will have random content in all the elements.   

#### Answer 3 (score 19)
<ol>
<li><p>These are equivalent</p>

```c
char buf[10] = "";
char buf[10] = {0};
char buf[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
```</li>
<li><p>These are equivalent</p>

```c
char buf[10] = " ";
char buf[10] = {' '};
char buf[10] = {' ', 0, 0, 0, 0, 0, 0, 0, 0, 0};
```</li>
<li><p>These are equivalent</p>

```c
char buf[10] = "a";
char buf[10] = {'a'};
char buf[10] = {'a', 0, 0, 0, 0, 0, 0, 0, 0, 0};
```</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: What does "dereferencing" a pointer mean? (score [519585](https://stackoverflow.com/q/4955198) in 2017)

#### Question
Please include an example with the explanation.  

#### Answer accepted (score 676)
<h5>Reviewing the basic terminology</h2>

It's <em>usually</em> good enough - unless you're programming assembly - to envisage a <strong><em>pointer</em></strong> containing a numeric memory address, with 1 referring to the second byte in the process's memory, 2 the third, 3 the fourth and so on....  

<ul>
<li>What happened to 0 and the first byte?  Well, we'll get to that later - see <em>null pointers</em> below.</li>
<li>For a more accurate definition of what pointers store, and how memory and addresses relate, see <em>"More about memory addresses, and why you probably don't need to know"</em>.</li>
</ul>

When you want to access the data/value in the memory that the pointer points to - the contents of the address with that numerical index - then you <strong><em>dereference</em></strong> the pointer.  

Different computer languages have different notations to tell the compiler or interpreter that you're now interested in the pointed-to value - I focus below on C and C++.  

<h5>A pointer scenario</h2>

Consider in C, given a pointer such as `p` below...  

```c
const char* p = "abc";
```

...four bytes with the numerical values used to encode the letters 'a', 'b', 'c', and a 0 byte to denote the end of the textual data, are stored somewhere in memory and the numerical address of that data is stored in `p`.  

For example, if the string literal happened to be at address 0x1000 and `p` a 32-bit pointer at 0x2000, the memory content would be:  

```c
Memory Address (hex)    Variable name    Contents
1000                                     'a' == 97 (ASCII)
1001                                     'b' == 98
1002                                     'c' == 99
1003                                     0
...
2000-2003               p                1000 hex
```

Note that there is no variable name/identifier for address 0x1000, but we can indirectly refer to the string literal using a pointer storing its address: `p`.  

<h5>Dereferencing the pointer</h2>

To refer to the characters `p` points to, we dereference `p` using one of these notations (again, for C):  

```c
assert(*p == 'a');  // The first character at address p will be 'a'
assert(p[1] == 'b'); // p[1] actually dereferences a pointer created by adding
                     // p and 1 times the size of the things to which p points:
                     // In this case they're char which are 1 byte in C...
assert(*(p + 1) == 'b');  // Another notation for p[1]
```

You can also move pointers through the pointed-to data, dereferencing them as you go:  

```c
++p;  // Increment p so it's now 0x1001
assert(*p == 'b');  // p == 0x1001 which is where the 'b' is...
```

If you have some data that can be written to, then you can do things like this:  

```c
int x = 2;
int* p_x = &x;  // Put the address of the x variable into the pointer p_x
*p_x = 4;       // Change the memory at the address in p_x to be 4
assert(x == 4); // Check x is now 4
```

Above, you must have known at compile time that you would need a variable called `x`, and the code asks the compiler to arrange where it should be stored, ensuring the address will be available via `&amp;x`.  

<h5>Dereferencing and accessing a structure data member</h2>

In C, if you have a variable that is a pointer to a structure with data members, you can access those members using the `-&gt;` dereferencing operator:  

```c
typedef struct X { int i_; double d_; } X;
X x;
X* p = &x;
p->d_ = 3.14159;  // Dereference and access data member x.d_
(*p).d_ *= -1;    // Another equivalent notation for accessing x.d_
```

<h5>Multi-byte data types</h2>

To use a pointer, a computer program also needs some insight into the type of data that is being pointed at - if that data type needs more than one byte to represent, then the pointer normally points to the lowest-numbered byte in the data.  

So, looking at a slightly more complex example:  

```c
double sizes[] = { 10.3, 13.4, 11.2, 19.4 };
double* p = sizes;
assert(p[0] == 10.3);  // Knows to look at all the bytes in the first double value
assert(p[1] == 13.4);  // Actually looks at bytes from address p + 1 * sizeof(double)
                       // (sizeof(double) is almost always eight bytes)
assert(++p);           // Advance p by sizeof(double)
assert(*p == 13.4);    // The double at memory beginning at address p has value 13.4
*(p + 2) = 29.8;       // Change sizes[3] from 19.4 to 29.8
                       // Note: earlier ++p and + 2 here => sizes[3]
```

<h5>Pointers to dynamically allocated memory</h2>

Sometimes you don't know how much memory you'll need until your program is running and sees what data is thrown at it... then you can dynamically allocate memory using `malloc`. It is common practice to store the address in a pointer...  

```c
int* p = malloc(sizeof(int)); // Get some memory somewhere...
*p = 10;            // Dereference the pointer to the memory, then write a value in
fn(*p);             // Call a function, passing it the value at address p
(*p) += 3;          // Change the value, adding 3 to it
free(p);            // Release the memory back to the heap allocation library
```

In C++, memory allocation is normally done with the `new` operator, and deallocation with `delete`:  

```c
int* p = new int(10); // Memory for one int with initial value 10
delete p;

p = new int[10];      // Memory for ten ints with unspecified initial value
delete[] p;

p = new int[10]();    // Memory for ten ints that are value initialised (to 0)
delete[] p;
```

See also <em>C++ smart pointers</em> below.  

<h5>Losing and leaking addresses</h2>

Often a pointer may be the only indication of where some data or buffer exists in memory. If ongoing use of that data/buffer is needed, or the ability to call `free()` or `delete` to avoid leaking the memory, then the programmer must operate on a copy of the pointer...  

```c
const char* p = asprintf("name: %s", name);  // Common but non-Standard printf-on-heap

// Replace non-printable characters with underscores....
for (const char* q = p; *q; ++q)
    if (!isprint(*q))
        *q = '_';

printf("%s\n", p); // Only q was modified
free(p);
```

...or carefully orchestrate reversal of any changes...  

```c
const size_t n = ...;
p += n;
...
p -= n;  // Restore earlier value...
```

<h5>C++ smart pointers</h2>

In C++, it's best practice to use <a href="http://en.wikipedia.org/wiki/Smart_pointer" rel="noreferrer">smart pointer</a> objects to store and manage the pointers, automatically deallocating them when the smart pointers' destructors run. Since C++11 the Standard Library provides two, <a href="http://en.cppreference.com/w/cpp/memory/unique_ptr" rel="noreferrer">`unique_ptr`</a> for when there's a single owner for an allocated object...  

```c
{
    std::unique_ptr<T> p{new T(42, "meaning")};
    call_a_function(p);
    // The function above might throw, so delete here is unreliable, but...
} // p's destructor's guaranteed to run "here", calling delete
```

...and <a href="http://en.cppreference.com/w/cpp/memory/shared_ptr" rel="noreferrer">`shared_ptr`</a> for share ownership (using <a href="http://en.wikipedia.org/wiki/Reference_counting" rel="noreferrer">reference counting</a>)...  

```c
{
    std::shared_ptr<T> p(new T(3.14, "pi"));
    number_storage.may_add(p); // Might copy p into its container
} // p's destructor will only delete the T if number_storage didn't copy
```

<h5>Null pointers</h2>

In C, `NULL` and `0` - and additionally in C++ `nullptr` - can be used to indicate that a pointer doesn't currently hold the memory address of a variable, and shouldn't be dereferenced or used in pointer arithmetic. For example:  

```c
const char* p_filename = NULL; // Or "= 0", or "= nullptr" in C++
char c;
while ((c = getopt(argc, argv, "f:")) != EOF)
    switch (c) {
      case f: p_filename = optarg; break;
    }
if (p_filename)  // Only NULL converts to false
    ...   // Only get here if -f flag specified
```

In C and C++, just as inbuilt numeric types don't necessarily default to `0`, nor `bools` to `false`, pointers are not always set to `NULL`. All these are set to 0/false/NULL when they're `static` variables or (C++ only) direct or indirect member variables of static objects or their bases, or undergo zero initialisation (e.g. `new T();` and `new T(x, y, z);` perform zero-initialisation on T's members including pointers, whereas `new T;` does not).  

Further, when you assign `0`, `NULL` and `nullptr` to a pointer the bits in the pointer are not necessarily all reset: the pointer may not contain "0" at the hardware level, or refer to address 0 in your virtual address space. The compiler is allowed to store something else there if it has reason to, but whatever it does - if you come along and compare the pointer to `0`, `NULL`, `nullptr` or another pointer that was assigned any of those, the comparison must work as expected. So, below the source code at the compiler level, "NULL" is potentially a bit "magical" in the C and C++ languages...  

<h5>More about memory addresses, and why you probably don't need to know</h2>

More strictly, initialised pointers store a bit-pattern identifying either `NULL` or a (often <a href="http://en.wikipedia.org/wiki/Virtual_address_space" rel="noreferrer">virtual</a>) memory address.  

The simple case is where this is a numeric offset into the process's entire virtual address space; in more complex cases the pointer may be relative to some specific memory area, which the CPU may select based on CPU "segment" registers or some manner of segment id encoded in the bit-pattern, and/or looking in different places depending on the machine code instructions using the address.  

For example, an `int*` properly initialised to point to an `int` variable might - after casting to a `float*` - access a value in "GPU" memory quite distinct from the `int` variable, then once cast to a function pointer might refer to distinct memory holding the machine opcodes for the function.  

3GL programming languages like C and C++ tend to hide this complexity, such that:  

<ul>
<li><p>If the compiler gives you a pointer to a variable or function, you can dereference it freely (as long as the variable's not destructed/deallocated meanwhile) and it's the compiler's problem whether e.g. a particular CPU register needs to be restored beforehand, or a distinct machine code instruction used</p></li>
<li><p>If you get a pointer to an element in an array, you can use pointer arithmetic to move anywhere else in the array, or even to form an address one-past-the-end of the array that's legal to compare with other pointers to elements in the array (or that have similarly been moved by pointer arithmetic to the same one-past-the-end value); again in C and C++, it's up to the compiler to ensure this "just works"</p></li>
<li><p>Specific OS functions, e.g. shared memory mapping, may give you pointers, and they'll "just work" within the range of addresses that makes sense for them</p></li>
<li><p>Attempts to move legal pointers beyond these boundaries, or to cast arbitrary numbers to pointers, or use pointers cast to unrelated types, typically have <a href="http://en.wikipedia.org/wiki/Undefined_behavior" rel="noreferrer"><em>undefined behaviour</em></a>, so should be avoided in higher level libraries and applications, but code for OSes, device drivers, etc. may need to rely on behaviour left undefined by C or C++, that is nevertheless well defined by their specific hardware.</p></li>
</ul>

#### Answer 2 (score 90)
Dereferencing a pointer means getting the value that is stored in the memory location pointed by the pointer. The operator * is used to do this, and is called the dereferencing operator.  

```c
int a = 10;
int* ptr = &a;

printf("%d", *ptr); // With *ptr I'm dereferencing the pointer. 
                    // Which means, I am asking the value pointed at by the pointer.
                    // ptr is pointing to the location in memory of the variable a.
                    // In a's location, we have 10. So, dereferencing gives this value.

// Since we have indirect control over a's location, we can modify its content using the pointer. This is an indirect way to access a.

 *ptr = 20;         // Now a's content is no longer 10, and has been modified to 20.
```

#### Answer 3 (score 16)
A pointer is a "reference" to a value.. much like a library call number is a reference to a book. "Dereferencing" the call number is physically going through and retrieving that book.  

```c
int a=4 ;
int *pA = &a ;
printf( "The REFERENCE/call number for the variable `a` is %p\n", pA ) ;

// The * causes pA to DEREFERENCE...  `a` via "callnumber" `pA`.
printf( "%d\n", *pA ) ; // prints 4.. 
```

If the book isn't there, the librarian starts shouting, shuts the library down, and a couple of people are set to investigate the cause of a person going to find a book that isn't there.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: printf() formatting for hex (score [506267](https://stackoverflow.com/q/14733761) in )

#### Question
This is more of a curious query than an important question, but why when printing hex as an 8 digit number with leading zeros, does this `%#08X` Not display the same result as `0x%08X`?  

When I try to use the former, the `08` formatting flag is removed, and it doesn't work with just `8`.  

Again I was just curious.   

#### Answer 2 (score 252)
The `#` part gives you a `0x` in the output string. The `0` and the `x` count against your "8" characters listed in the `08` part. You need to ask for 10 characters if you want it to be the same.  

```c
int i = 7;

printf("%#010x\n", i);  // gives 0x00000007
printf("0x%08x\n", i);  // gives 0x00000007
printf("%#08x\n", i);   // gives 0x000007
```

Also changing the case of `x`, affects the casing of the outputted characters.  

```c
printf("%04x", 4779); // gives 12ab
printf("%04X", 4779); // gives 12AB
```

#### Answer 3 (score 51)
The "0x" counts towards the eight character count. You need `"%#010x"`.  

Note that `#` does <em>not</em> append the 0x to 0 - the result will be `0000000000` - so you probably actually should just use `"0x%08x"` anyway.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: How do you pass a function as a parameter in C? (score [506257](https://stackoverflow.com/q/9410) in 2016)

#### Question
I want to create a function that performs a function passed by parameter on a set of data. How do you pass a function as a parameter in C?  

#### Answer accepted (score 686)
<strong>Declaration</strong>  

A prototype for a function which takes a function parameter looks like the following:  

```c
void func ( void (*f)(int) );
```

This states that the parameter `f` will be a pointer to a function which has a `void` return type and which takes a single `int` parameter. The following function (`print`) is an example of a function which could be passed to `func` as a parameter because it is the proper type:  

```c
void print ( int x ) {
  printf("%d\n", x);
}
```

<strong>Function Call</strong>  

When calling a function with a function parameter, the value passed must be a pointer to a function. Use the function's name (without parentheses) for this:  

```c
func(print);
```

would call `func`, passing the print function to it.  

<strong>Function Body</strong>  

As with any parameter, func can now use the parameter's name in the function body to access the value of the parameter. Let's say that func will apply the function it is passed to the numbers 0-4. Consider, first, what the loop would look like to call print directly:  

```c
for ( int ctr = 0 ; ctr < 5 ; ctr++ ) {
  print(ctr);
}
```

Since `func`'s parameter declaration says that `f` is the name for a pointer to the desired function, we recall first that if `f` is a pointer then `*f` is the thing that `f` points to (i.e. the function `print` in this case). As a result, just replace every occurrence of print in the loop above with `*f`:  

```c
void func ( void (*f)(int) ) {
  for ( int ctr = 0 ; ctr < 5 ; ctr++ ) {
    (*f)(ctr);
  }
}
```

From <a href="http://math.hws.edu/bridgeman/courses/331/f05/handouts/c-c++-notes.html" rel="noreferrer">http://math.hws.edu/bridgeman/courses/331/f05/handouts/c-c++-notes.html</a>  

#### Answer 2 (score 119)
This question already has the answer for defining function pointers, however they can get very messy, especially if you are going to be passing them around your application. To avoid this unpleasantness I would recommend that you typedef the function pointer into something more readable. For example.  

```c
typedef void (*functiontype)();
```

Declares a function that returns void and takes no arguments. To create a function pointer to this type you can now do:  

```c
void dosomething() { }

functiontype func = &dosomething;
func();
```

For a function that returns an int and takes a char you would do  

```c
typedef int (*functiontype2)(char);
```

and to use it  

```c
int dosomethingwithchar(char a) { return 1; }

functiontype2 func2 = &dosomethingwithchar
int result = func2('a');
```

There are libraries that can help with turning function pointers into nice readable types. The <a href="http://www.boost.org/doc/libs/1_36_0/doc/html/function.html" rel="noreferrer">boost function</a> library is great and is well worth the effort!  

```c
boost::function<int (char a)> functiontype2;
```

is so much nicer than the above.  

#### Answer 3 (score 60)
Since C++11 you can use the <a href="http://www.cplusplus.com/reference/functional/function/function/" rel="noreferrer">functional library</a> to do this in a succinct and generic fashion. The syntax is, e.g.,  

```c
std::function<bool (int)>
```

where `bool` is the return type here of a one-argument function whose first argument is of type `int`.  

I have included an example program below:  

```c
// g++ test.cpp --std=c++11
#include <functional>

double Combiner(double a, double b, std::function<double (double,double)> func){
  return func(a,b);
}

double Add(double a, double b){
  return a+b;
}

double Mult(double a, double b){
  return a*b;
}

int main(){
  Combiner(12,13,Add);
  Combiner(12,13,Mult);
}
```

Sometimes, though, it is more convenient to use a template function:  

```c
// g++ test.cpp --std=c++11

template<class T>
double Combiner(double a, double b, T func){
  return func(a,b);
}

double Add(double a, double b){
  return a+b;
}

double Mult(double a, double b){
  return a*b;
}

int main(){
  Combiner(12,13,Add);
  Combiner(12,13,Mult);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: Get a substring of a char* (score [504615](https://stackoverflow.com/q/4214314) in 2015)

#### Question
For example, I have this  

```c
char *buff = "this is a test string";
```

and want to get `"test"`. How can I do that?  

#### Answer accepted (score 202)
```c
char subbuff[5];
memcpy( subbuff, &buff[10], 4 );
subbuff[4] = '\0';
```

Job done :)  

#### Answer 2 (score 81)
Assuming you know the position and the length of the substring:  

```c
char *buff = "this is a test string";
printf("%.*s", 4, buff + 10);
```

You could achieve the same thing by copying the substring to another memory destination, but it's not reasonable since you already have it in memory.  

This is a good example of avoiding unnecessary copying by using pointers.  

#### Answer 3 (score 62)
Use `char* strncpy(char* dest, char* src, int n)` from `&lt;cstring&gt;`. In your case you will need to use the following code:  

```c
char* substr = malloc(4);
strncpy(substr, buff+10, 4);
```

Full documentation on the `strncpy` function <a href="http://www.cplusplus.com/reference/clibrary/cstring/strncpy/" rel="noreferrer">here</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: Difference between malloc and calloc? (score [499399](https://stackoverflow.com/q/1538420) in 2013)

#### Question
What is the difference between doing:  

```c
ptr = (char **) malloc (MAXELEMS * sizeof(char *));
```

or:  

```c
ptr = (char **) calloc (MAXELEMS, sizeof(char*));
```

When is it a good idea to use calloc over malloc or vice versa?  

#### Answer accepted (score 808)
`calloc()` zero-initializes the buffer, while `malloc()` leaves the memory uninitialized.  

<strong>EDIT:</strong>  

Zeroing out the memory may take a little time, so you probably want to use `malloc()` if that performance is an issue.  If initializing the memory is more important, use `calloc()`.  For example, `calloc()` might save you a call to `memset()`.  

#### Answer 2 (score 354)
A less known difference is that in operating systems with optimistic memory allocation, like Linux, the pointer returned by `malloc` isn't backed by real memory until the program actually touches it.  

`calloc` does indeed touch the memory (it writes zeroes on it) and thus you'll be sure the OS is backing the allocation with actual RAM (or swap). This is also why it is slower than malloc (not only does it have to zero it, the OS must also find a suitable memory area by possibly swapping out other processes)  

See for instance <a href="https://stackoverflow.com/questions/911860/does-malloc-lazily-create-the-backing-pages-for-an-allocation-on-linux-and-other">this SO question</a> for further discussion about the behavior of malloc  

#### Answer 3 (score 105)
One often-overlooked advantage of `calloc` is that (conformant implementations of) it will help protect you against integer overflow vulnerabilities. Compare:  

```c
size_t count = get_int32(file);
struct foo *bar = malloc(count * sizeof *bar);
```

vs.  

```c
size_t count = get_int32(file);
struct foo *bar = calloc(count, sizeof *bar);
```

The former could result in a tiny allocation and subsequent buffer overflows, if `count` is greater than `SIZE_MAX/sizeof *bar`. The latter will automatically fail in this case since an object that large cannot be created.  

Of course you may have to be on the lookout for non-conformant implementations which simply ignore the possibility of overflow... If this is a concern on platforms you target, you'll have to do a manual test for overflow anyway.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: How to compile and run C/C++ in a Unix console/Mac terminal? (score [496686](https://stackoverflow.com/q/221185) in 2018)

#### Question
How can I compile/run C or C++ in Unix console or a Mac terminal?  

(I know it, forget it, and relearn it again. Time to write it down.)  

#### Answer accepted (score 173)
If it is a simple single source program:  

```c
make foo
```

where the source file is foo.c or foo.cpp, etc.  

You dont even need a makefile. Make has enough built-in rules to build your source file into an executable of the same name, minus extension.  

Running the executable just built is the same as running any program - but you will most often need to specify the path to the executable as the shell will only search what is in `$PATH` to find executables, and most often that does not include the current directory (`.`).  

So to run the built executable `foo`:  

```c
./foo
```

#### Answer 2 (score 107)
```c
gcc main.cpp -o main.out  
./main.out
```

#### Answer 3 (score 67)
This is the command that works on all Unix machines... I use it on Linux/Ubuntu, but it works in OS&nbsp;X as well. Type the following command in <strong>Terminal.app</strong>.  

```c
$ g++ -o lab21 iterative.cpp
```

`-o` is the letter O not zero  

`lab21` will be your executable file  

`iterative.cpp` is your c++ file  

After you run that command type the following in terminal to run your program:  

```c
$ ./lab21
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: Reading string from input with space character? (score [492341](https://stackoverflow.com/q/6282198) in 2018)

#### Question
<p>I'm using Ubuntu and I'm also using Geany and CodeBlock as my IDE.
What I'm trying to do is reading a string (like `"Barack Obama"`) and put it in a variable:</p>

```c
#include <stdio.h>

int main(void)
{
    char name[100];

    printf("Enter your name: ");
    scanf("%s", name);
    printf("Your Name is: %s", name);

    return 0;
}
```

Output:  

```c
Enter your name: Barack Obama
Your Name is: Barack
```

How can I make the program read the whole name?  

#### Answer accepted (score 166)
Use:  

```c
fgets (name, 100, stdin);
```

`100` is the max length of the buffer. You should adjust it as per your need.  

Use:  

```c
scanf ("%[^\n]%*c", name);
```

The `[]` is the scanset character. `[^\n]` tells that while the input is <em>not</em> a newline (`'\n'`) take input. Then with the `%*c` it reads the newline character from the input buffer (which is not read), and the `*` indicates that this read in input is discarded (assignment suppression), as you do not need it, and this newline in the buffer does not create any problem for next inputs that you might take.  

Read here about the <a href="http://pubs.opengroup.org/onlinepubs/009695399/functions/scanf.html">scanset</a> and the <a href="http://pubs.opengroup.org/onlinepubs/009695399/functions/scanf.html">assignment suppression</a> operators.  

Note you can also use `gets` but ....  

<blockquote>
  Never use `gets()`.  Because it is impossible to tell without knowing the data  in  advance  how  many  characters  gets() will read, and because `gets()` will continue to store characters past the end of the buffer, it is  extremely  dangerous  to  use.   It has been used to break computer security. Use `fgets()` instead.  
</blockquote>

#### Answer 2 (score 21)
Try this:  

```c
scanf("%[^\n]s",name);
```

`\n` just sets the delimiter for the scanned string.  

#### Answer 3 (score 6)
Here is an example of how you can get input containing spaces by using the `fgets` function.   

```c
#include <stdio.h>

int main()
{
    char name[100];
    printf("Enter your name: ");
    fgets(name, 100, stdin); 
    printf("Your Name is: %s", name);
    return 0;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Reading a string with scanf (score [489645](https://stackoverflow.com/q/5406935) in 2018)

#### Question
I'm a little bit confused about something. I was under the impression that the correct way of reading a C string with `scanf()` went along the lines of  

(never mind the possible buffer overflow, it's just a simple example)  

```c
char string[256];
scanf( "%s" , string );
```

However, the following seems to work too,  

```c
scanf( "%s" , &string );
```

Is this just my compiler (gcc), pure luck, or something else?  

#### Answer accepted (score 130)
An array "decays" into a pointer to its first element, so `scanf("%s", string)` is equivalent to `scanf("%s", &amp;string[0])`. On the other hand, `scanf("%s", &amp;string)` passes a pointer-to-`char[256]`, but it points to the same place.  

Then `scanf`, when processing the tail of its argument list, will try to pull out a `char *`. That's the Right Thing when you've passed in `string` or `&amp;string[0]`, but when you've passed in `&amp;string` you're depending on something that the language standard doesn't guarantee, namely that the pointers `&amp;string` and `&amp;string[0]` -- pointers to objects of different types and sizes that start at the same place -- are represented the same way.  

I don't believe I've ever encountered a system on which that doesn't work, and in practice you're probably safe. None the less, it's wrong, and it could fail on some platforms. (Hypothetical example: a "debugging" implementation that includes type information with every pointer. I <em>think</em> the C implementation on the Symbolics "Lisp Machines" did something like this.)  

#### Answer 2 (score -7)
<p>I think that this below is accurate and it may help. 
Feel free to correct it if you find any errors. I'm new at C.</p>

```c
char str[]  
```

<ol>
<li>array of values of type char, with its own address in memory</li>
<li>array of values of type char, with its own address in memory
as many consecutive addresses as elements in the array</li>
<li><p>including termination null character `'\0'` `&amp;str`, `&amp;str[0]` and `str`, all three represent the same location in memory which is address of the first element of the array `str`</p>

char *strPtr = &amp;str[0]; //declaration and initialization  </li>
</ol>

alternatively, you can split this in two:   

```c
char *strPtr; strPtr = &str[0];
```

<ol start="4">
<li>`strPtr` is a pointer to a `char`</li>
<li>`strPtr` points at array `str`</li>
<li>`strPtr` is a variable with its own address in memory</li>
<li>`strPtr` is a variable that stores value of address `&amp;str[0]`</li>
<li>`strPtr` own address in memory is different from the memory address that it stores (address of array in memory a.k.a &amp;str[0])</li>
<li>`&amp;strPtr` represents the address of strPtr  itself</li>
</ol>

I think that you could declare a pointer to a pointer as:  

```c
char **vPtr = &strPtr;  
```

declares and initializes with address of strPtr pointer  

Alternatively you could split in two:  

```c
char **vPtr;
*vPtr = &strPtr
```

<ol start="10">
<li>`*vPtr` points at strPtr pointer</li>
<li>`*vPtr` is a variable with its own address in memory</li>
<li>`*vPtr` is a variable that stores value of address &amp;strPtr</li>
<li>final comment:  you can not do `str++`, `str` address is a `const`,  but
you can do `strPtr++`   </li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: Why should we typedef a struct so often in C? (score [487703](https://stackoverflow.com/q/252780) in 2016)

#### Question
I have seen many programs consisting of structures like the one below  

```c
typedef struct 
{
    int i;
    char k;
} elem;

elem user;
```

Why is it needed so often? Any specific reason or applicable area?  

#### Answer accepted (score 433)
As Greg Hewgill said, the typedef means you no longer have to write `struct` all over the place. That not only saves keystrokes, it also can make the code cleaner since it provides a smidgen more abstraction.  

Stuff like  

```c
typedef struct {
  int x, y;
} Point;

Point point_new(int x, int y)
{
  Point a;
  a.x = x;
  a.y = y;
  return a;
}
```

becomes cleaner when you don't need to see the "struct" keyword all over the place, it looks more as if there really is a type called "Point" in your language. Which, after the `typedef`, is the case I guess.  

Also note that while your example (and mine) omitted naming the `struct`  itself, actually naming it is also useful for when you want to provide an opaque type. Then you'd have code like this in the header, for instance:  

```c
typedef struct Point Point;

Point * point_new(int x, int y);
```

and then provide the `struct` definition in the implementation file:  

```c
struct Point
{
  int x, y;
};

Point * point_new(int x, int y)
{
  Point *p;
  if((p = malloc(sizeof *p)) != NULL)
  {
    p->x = x;
    p->y = y;
  }
  return p;
}
```

In this latter case, you cannot return the Point by value, since its definition is hidden from users of the header file. This is a technique used widely in <a href="http://www.gtk.org/" rel="noreferrer">GTK+</a>, for instance.  

<strong>UPDATE</strong> Note that there are also highly-regarded C projects where this use of `typedef` to hide `struct` is considered a bad idea, the Linux kernel is probably the most well-known such project. See Chapter 5 of <a href="https://www.kernel.org/doc/html/latest/process/coding-style.html#typedefs" rel="noreferrer">The Linux Kernel CodingStyle document</a> for Linus' angry words. :) My point is that the "should" in the question is perhaps not set in stone, after all.  

#### Answer 2 (score 198)
It's amazing how many people get this wrong. PLEASE don't typedef structs in C, it needlessly pollutes the global namespace which is typically very polluted already in large C programs.  

Also, typedef'd structs without a tag name are a major cause of needless imposition of ordering relationships among header files.  

Consider:  

```c
#ifndef FOO_H
#define FOO_H 1

#define FOO_DEF (0xDEADBABE)

struct bar; /* forward declaration, defined in bar.h*/

struct foo {
  struct bar *bar;
};

#endif
```

With such a definition, not using typedefs, it is possible for a compiland unit to include foo.h to get at the `FOO_DEF` definition.  If it doesn't attempt to dereference  the 'bar' member of the `foo` struct then there will be no need to include the "bar.h" file.  

Also, since the namespaces are different between the tag names and the member names, it is possible to write very readable code such as:  

```c
struct foo *foo;

printf("foo->bar = %p", foo->bar);
```

Since the namespaces are separate, there is no conflict in naming variables coincident with their struct tag name.  

If I have to maintain your code, I will remove your typedef'd structs.  

#### Answer 3 (score 137)
From an old article by Dan Saks (<a href="http://www.ddj.com/cpp/184403396?pgno=3" rel="noreferrer">http://www.ddj.com/cpp/184403396?pgno=3</a>):  

<hr>

<blockquote>
  <p>The C language rules for naming
  structs are a little eccentric, but
  they're pretty harmless. However, when
  extended to classes in C++, those same
  rules open little cracks for bugs to
  crawl through.</p>
  
  In C, the name s appearing in  

```c
struct s
    {
    ...
    };
```
  
  <p>is a tag. A tag name is not a type
  name. Given the definition above,
  declarations such as</p>

```c
s x;    /* error in C */
s *p;   /* error in C */
```
  
  <p>are errors in C. You must write them
  as</p>

```c
struct s x;     /* OK */
struct s *p;    /* OK */
```
  
  <p>The names of unions and enumerations
  are also tags rather than types.</p>
  
  <p>In C, tags are distinct from all other
  names (for functions, types,
  variables, and enumeration constants).
  C compilers maintain tags in a symbol
  table that's conceptually if not
  physically separate from the table
  that holds all other names. Thus, it
  is possible for a C program to have
  both a tag and an another name with
  the same spelling in the same scope.
  For example,</p>

```c
struct s s;
```
  
  <p>is a valid declaration which declares
  variable s of type struct s. It may
  not be good practice, but C compilers
  must accept it. I have never seen a
  rationale for why C was designed this
  way. I have always thought it was a
  mistake, but there it is.</p>
  
  <p>Many programmers (including yours
  truly) prefer to think of struct names
  as type names, so they define an alias
  for the tag using a typedef. For
  example, defining</p>

```c
struct s
    {
    ...
    };
typedef struct s S;
```
  
  <p>lets you use S in place of struct s,
  as in</p>

```c
S x;
S *p;
```
  
  <p>A program cannot use S as the name of
  both a type and a variable (or
  function or enumeration constant):</p>

```c
S S;    // error
```
  
  This is good.  
  
  <p>The tag name in a struct, union, or
  enum definition is optional. Many
  programmers fold the struct definition
  into the typedef and dispense with the
  tag altogether, as in:</p>

```c
typedef struct
    {
    ...
    } S;
```
</blockquote>

<hr>

The linked article also has a discussion about how the C++ behavior of not requireing a `typedef` can cause subtle name hiding problems.  To prevent these problems, it's a good idea to `typedef` your classes and structs in C++, too, even though at first glance it appears to be unnecessary.  In C++, with the `typedef` the name hiding become an error that the compiler tells you about rather than a hidden source of potential problems.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: How to convert char to integer in C? (score [487261](https://stackoverflow.com/q/868496) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicates:</strong><br>
  <a href="https://stackoverflow.com/questions/439573/how-to-convert-a-single-char-into-an-int">How to convert a single char into an int</a><br>
  <a href="https://stackoverflow.com/questions/628761/character-to-integer-in-c">Character to integer in C</a></p>
</blockquote>

Can any body tell me how to convert a `char` to `int`?  

```c
char c[]={'1',':','3'};

int i=int(c[0]);

printf("%d",i);
```

When I try this it gives 49.  

#### Answer 2 (score 152)
In the old days, when we could assume that most computers used ASCII, we would just do  

```c
int i = c[0] - '0';
```

<strike>But in these days of Unicode, it's not a good idea.  It was never a good idea if your code had to run on a non-ASCII computer.</strike>  

Edit: Although it looks hackish, evidently it <em>is</em> guaranteed by the standard to work.  Thanks @Earwicker.  

#### Answer 3 (score 38)
The standard function `atoi()` will likely do what you want.   

A simple example using "atoi":  

```c
#include <unistd.h>

int main(int argc, char *argv[])
{
    int useconds = atoi(argv[1]); 
    usleep(useconds);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: How to define an enumerated type (enum) in C? (score [487173](https://stackoverflow.com/q/1102542) in 2011)

#### Question
I'm not sure what is the proper syntax for using C enums. I have the following code:  

```c
enum {RANDOM, IMMEDIATE, SEARCH} strategy;
strategy = IMMEDIATE;
```

But this does not compile, with the following error:  

```c
error: conflicting types for ‘strategy’
error: previous declaration of ‘strategy’ was here
```

What am I doing wrong?  

#### Answer accepted (score 367)
Declaring an enum variable is done like this:  

```c
enum strategy {RANDOM, IMMEDIATE, SEARCH};
enum strategy my_strategy = IMMEDIATE;
```

However, you can use a `typedef` to shorten the variable declarations, like so:  

```c
typedef enum {RANDOM, IMMEDIATE, SEARCH} strategy;
strategy my_strategy = IMMEDIATE;
```

Having a naming convention to distinguish between types and variables is a good idea:  

```c
typedef enum {RANDOM, IMMEDIATE, SEARCH} strategy_type;
strategy_type my_strategy = IMMEDIATE;
```

#### Answer 2 (score 447)
It's worth pointing out that you don't <em>need</em> a `typedef`. You can just do it like the following  

```c
enum strategy { RANDOM, IMMEDIATE, SEARCH };
enum strategy my_strategy = IMMEDIATE;
```

It's a style question whether you prefer `typedef`. Without it, if you want to refer to the enumeration type, you need to use `enum strategy`. With it, you can just say `strategy`.  

Both ways have their pro and cons. The one is more wordy, but keeps type identifiers into the tag-namespace where they won't conflict with ordinary identifiers (think of `struct stat` and the `stat` function: these don't conflict either), and where you immediately see that it's a type. The other is shorter, but brings type identifiers into the ordinary namespace.   

#### Answer 3 (score 57)
You're trying to declare `strategy` twice, and that's why you're getting the above error. The following works without any complaints (compiled with `gcc -ansi -pendantic -Wall`):  

```c
#include <stdio.h>

enum { RANDOM, IMMEDIATE, SEARCH } strategy = IMMEDIATE;

int main(int argc, char** argv){
    printf("strategy: %d\n", strategy);

    return 0;
}
```

If instead of the above, the second line were changed to:  

```c
...
enum { RANDOM, IMMEDIATE, SEARCH } strategy;
strategy = IMMEDIATE;
...
```

From the warnings, you could easily see your mistake:  

```c
enums.c:5:1: warning: data definition has no type or storage class [enabled by default]
enums.c:5:1: warning: type defaults to ‘int’ in declaration of ‘strategy’ [-Wimplicit-int]
enums.c:5:1: error: conflicting types for ‘strategy’
enums.c:4:36: note: previous declaration of ‘strategy’ was here
```

So the compiler took `strategy = IMMEDIATE` for a declaration of a variable called `strategy` with default type `int`, but there was already a previous declaration of a variable with this name.  

However, if you placed the assignment in the `main()` function, it would be a valid code:  

```c
#include <stdio.h>

enum { RANDOM, IMMEDIATE, SEARCH } strategy = IMMEDIATE;

int main(int argc, char** argv){
    strategy=SEARCH;
    printf("strategy: %d\n", strategy);

    return 0;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: What's the best way to check if a file exists in C? (score [483699](https://stackoverflow.com/q/230062) in 2019)

#### Question
Is there a better way than simply trying to open the file?  

```c
int exists(const char *fname)
{
    FILE *file;
    if ((file = fopen(fname, "r")))
    {
        fclose(file);
        return 1;
    }
    return 0;
}
```

#### Answer accepted (score 535)
Look up the `access()` function, found in `unistd.h`. You can replace your function with  

```c
if( access( fname, F_OK ) != -1 ) {
    // file exists
} else {
    // file doesn't exist
}
```

You can also use `R_OK`, `W_OK`, and `X_OK` in place of `F_OK` to check for read permission, write permission, and execute permission (respectively) rather than existence, and you can OR any of them together (i.e. check for both read <em>and</em> write permission using `R_OK|W_OK`)  

<em>Update</em>: Note that on Windows, you can't use `W_OK` to reliably test for write permission, since the access function does not take DACLs into account. `access( fname, W_OK )` may return 0 (success) because the file does not have the read-only attribute set, but you still may not have permission to write to the file.  

#### Answer 2 (score 109)
Use stat like this:  

```c
bool file_exist (char *filename)
{
  struct stat   buffer;   
  return (stat (filename, &buffer) == 0);
}
```

and call it like this:  

```c
if (file_exist ("myfile.txt"))
{
  printf ("It exists\n");
}
```

#### Answer 3 (score 77)
Usually when you want to check if a file exists, it's because you want to <em>create</em> that file if it doesn't.  Graeme Perrow's answer is good if you <strong>don't</strong> want to create that file, but it's vulnerable to a race condition if you do: another process could create the file in between you checking if it exists, and you actually opening it to write to it.  (Don't laugh... this could have <strong>bad</strong> security implications if the file created was a symlink!)  

If you want to check for existence <em>and</em> create the file if it doesn't exist, <strong>atomically</strong> so that there are no race conditions, then use this:  

```c
#include <fcntl.h>
#include <errno.h>

fd = open(pathname, O_CREAT | O_WRONLY | O_EXCL, S_IRUSR | S_IWUSR);
if (fd < 0) {
  /* failure */
  if (errno == EEXIST) {
    /* the file already existed */
    ...
  }
} else {
  /* now you can use the file */
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: How do I get the directory that a program is running from? (score [477268](https://stackoverflow.com/q/143174) in 2013)

#### Question
Is there a platform-agnostic and filesystem-agnostic method to obtain the full path of the directory from where a program is running using C/C++? Not to be confused with the current working directory. (Please don't suggest libraries unless they're standard ones like clib or STL.)  

(If there's no platform/filesystem-agnostic method, suggestions that work in Windows and Linux for specific filesystems are welcome too.)  

#### Answer accepted (score 171)
Here's code to get the full path to the executing app:  

Windows:  

```c
int bytes = GetModuleFileName(NULL, pBuf, len);
if(bytes == 0)
    return -1;
else
    return bytes;
```

Linux:  

```c
char szTmp[32];
sprintf(szTmp, "/proc/%d/exe", getpid());
int bytes = MIN(readlink(szTmp, pBuf, len), len - 1);
if(bytes >= 0)
    pBuf[bytes] = '\0';
return bytes;
```

#### Answer 2 (score 165)
If you fetch the current directory when your program first starts, then you effectively have the directory your program was started from. Store the value in a variable and refer to it later in your program. This is distinct from <a href="https://stackoverflow.com/q/933850/33732">the directory that holds the current executable program file</a>. It isn't necessarily the same directory; if someone runs the program from a command prompt, then the program is being <em>run from</em> the command prompt's current working directory even though the program file lives elsewhere.  

getcwd is a POSIX function and supported out of the box by all POSIX compliant platforms. You would not have to do anything special (apart from incliding the right headers unistd.h on Unix and direct.h on windows).  

Since you are creating a C program it will link with the default c run time library which is linked to by ALL processes in the system (specially crafted exceptions avoided) and it will include this function by default. The CRT is never considered an external library because that provides the basic standard compliant interface to the OS.  

On windows getcwd function has been deprecated in favour of _getcwd. I think you could use it in this fashion.  

```c
#include <stdio.h>  /* defines FILENAME_MAX */
#ifdef WINDOWS
    #include <direct.h>
    #define GetCurrentDir _getcwd
#else
    #include <unistd.h>
    #define GetCurrentDir getcwd
 #endif

 char cCurrentPath[FILENAME_MAX];

 if (!GetCurrentDir(cCurrentPath, sizeof(cCurrentPath)))
     {
     return errno;
     }

cCurrentPath[sizeof(cCurrentPath) - 1] = '\0'; /* not really required */

printf ("The current working directory is %s", cCurrentPath);
```

#### Answer 3 (score 39)
This is from the <a href="http://www.cplusplus.com/forum/general/11104/">cplusplus forum</a>  

<strong>On windows:</strong>  

```c
#include <string>
#include <windows.h>

std::string getexepath()
{
  char result[ MAX_PATH ];
  return std::string( result, GetModuleFileName( NULL, result, MAX_PATH ) );
}
```

<strong>On Linux:</strong>  

```c
#include <string>
#include <limits.h>
#include <unistd.h>

std::string getexepath()
{
  char result[ PATH_MAX ];
  ssize_t count = readlink( "/proc/self/exe", result, PATH_MAX );
  return std::string( result, (count > 0) ? count : 0 );
}
```

<strong>On HP-UX:</strong>  

```c
#include <string>
#include <limits.h>
#define _PSTAT64
#include <sys/pstat.h>
#include <sys/types.h>
#include <unistd.h>

std::string getexepath()
{
  char result[ PATH_MAX ];
  struct pst_status ps;

  if (pstat_getproc( &ps, sizeof( ps ), 0, getpid() ) < 0)
    return std::string();

  if (pstat_getpathname( result, PATH_MAX, &ps.pst_fid_text ) < 0)
    return std::string();

  return std::string( result );
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Regarding 'main(int argc, char *argv[])' (score [474856](https://stackoverflow.com/q/3898021) in 2018)

#### Question
<blockquote>
  <p><strong>Possible Duplicates:</strong><br>
  <a href="https://stackoverflow.com/questions/3734111/what-are-the-arguments-to-main-for">What are the arguments to main() for?</a><br>
  <a href="https://stackoverflow.com/questions/3024197/what-does-int-argc-char-argv-mean">What does int argc, char *argv[] mean?</a>  </p>
</blockquote>



Every program is starting with the `main(int argc, char *argv[])` definition.   

I don't understand what it means. I would be very glad if somebody could explain why we use these arguments if we don't use them in the program? Why not just: `int main()`?  

Is the name of the program one of the elements of `*argv[]` and `argc` is the count of the number of arguments in `*argv[]`? What are the other arguments sent to `*argv[]`? How do we send them?  

#### Answer accepted (score 114)
The arguments `argc` and `argv` of `main` is used as a way to send arguments to a program, the possibly most familiar way is to use the good ol' terminal where an user could type <kbd>`cat file`</kbd>. Here the word `cat` is a program that takes a file and outputs it to standard output (`stdout`).  

The program receives the number of arguments in `argc` and the vector of arguments in `argv`, in the above the <strong>arg</strong>ument <strong>c</strong>ount would be two (The program name counts as the first argument) and the <strong>arg</strong>ument <strong>v</strong>ector would contain [`cat`,`file`,<em>null</em>]. While the last element being a null-pointer.  

Commonly, you would write it like this:  

```c
int  // Specifies that type of variable the function returns.
     // main() must return an integer
main ( int argc, char **argv ) {
     // code
     return 0; // Indicates that everything went well.
}
```

If your program does not require any arguments, it is equally valid to write a `main`-function in the following fashion:  

```c
int main() {
  // code
  return 0; // Zero indicates success, while any 
  // Non-Zero value indicates a failure/error
}
```

In the early versions of the C language, there was no `int` before `main` as this was implied. Today, this is considered to be an error.  

On <strong>POSIX</strong>-compliant systems (and Windows), there exists the possibility to use a third parameter `char **envp` which contains a vector of the programs <a href="http://en.wikipedia.org/wiki/Environment_variable" rel="noreferrer"><strong>env</strong>ironment  variables</a>. Further variations of the argument list of the `main` function exists, but I will not detail it here since it is non-standard.  

Also, the naming of the variables is a <em>convention</em> and has no actual meaning. It is always a good idea to adhere to this so that you do not confuse others, but it would be equally valid to define `main` as  

```c
int main(int c, char **v, char **e) {
   // code
   return 0;
}
```

And for your second question, there are several ways to send arguments to a program. I would recommend you to look at the <a href="http://linux.die.net/man/3/exec" rel="noreferrer">`exec*()`family of functions</a> which is <strong>POSIX</strong>-standard, but it is probably <strong>easier</strong> to just use <a href="http://linux.die.net/man/3/system" rel="noreferrer">`system`</a>`("command arg1 arg2")`, but the use of `system()` is usually frowned upon as it is not guaranteed to work on every system. I have not tested it myself; but if there is no `bash`,`zsh`, or other shell installed on a *NIX-system, `system()` will fail.  

#### Answer 2 (score 58)
Those are for passing arguments to your program, for example from command line, when a program is invoked  

```c
$ gcc mysort.c -o mysort

$ mysort 2 8 9 1 4 5
```

Above, the program `mysort` is executed with some command line parameters. Inside `main( int argc, char * argv[])`, this would result in  

```c
Argument Count, argc = 7 
```

since there are 7 arguments (counting the program), and   

```c
Argument Vector, argv[] = { "mysort", "2", "8", "9", "1", "4", "5" };
```

Following is a complete example.  

```c
$ cat mysort.c
#include <stdio.h>
int main( int argc, char * argv [] ) {
    printf( "argc = %d\n", argc );
    for( int i = 0; i < argc; ++i ) {
        printf( "argv[ %d ] = %s\n", i, argv[ i ] );
    }
}

$ gcc mysort.c -o mysort

$ ./mysort 2 8 9 1 4 5
argc = 7
argv[ 0 ] = ./mysort
argv[ 1 ] = 2
argv[ 2 ] = 8
argv[ 3 ] = 9
argv[ 4 ] = 1
argv[ 5 ] = 4
argv[ 6 ] = 5
```

[The `char` strings "2", "8" etc. can be converted to number using some character to number conversion function, e.g. `atol()` <a href="http://www.cplusplus.com/reference/clibrary/cstdlib/atol/" rel="noreferrer">(link</a>)]  

#### Answer 3 (score 15)
With `argc` (argument count) and `argv` (argument vector) you can get the number and the values of passed arguments when your application has been launched.  

This way you can use parameters (such as `-version`) when your application is started to act a different way.  

But you can also use `int main(void)` as a prototype in C.  

There is a third (less known and nonstandard) prototype with a third argument which is `envp`. It contains environment variables.  

<hr>

<strong>Resources:</strong>  

<ul>
<li><a href="http://en.wikipedia.org/wiki/Main_function_(programming)#C_and_C.2B.2B" rel="noreferrer">Wikipedia - Main function, C and C++</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: Easily measure elapsed time (score [469449](https://stackoverflow.com/q/2808398) in 2013)

#### Question
I am trying to use <a href="http://en.cppreference.com/w/cpp/chrono/c/time" rel="noreferrer">time()</a> to measure various points of my program.  

What I don't understand is why the values in the before and after are the same?  I understand this is not the best way to profile my program, I just want to see how long something take.    

```c
printf("**MyProgram::before time= %ld\n", time(NULL));

doSomthing();
doSomthingLong();

printf("**MyProgram::after time= %ld\n", time(NULL));
```

I have tried:  

```c
struct timeval diff, startTV, endTV;

gettimeofday(&startTV, NULL); 

doSomething();
doSomethingLong();

gettimeofday(&endTV, NULL); 

timersub(&endTV, &startTV, &diff);

printf("**time taken = %ld %ld\n", diff.tv_sec, diff.tv_usec);
```

How do I read a result of `**time taken = 0 26339`?  Does that mean 26,339 nanoseconds = 26.3 msec?  

What about `**time taken = 4 45025`, does that mean 4 seconds and 25 msec?  

#### Answer 2 (score 263)
```c
#include <ctime>

void f() {
  using namespace std;
  clock_t begin = clock();

  code_to_time();

  clock_t end = clock();
  double elapsed_secs = double(end - begin) / CLOCKS_PER_SEC;
}
```

The `time()` function is only accurate to within a second, but there are <a href="http://en.cppreference.com/w/cpp/chrono/c/CLOCKS_PER_SEC" rel="noreferrer">`CLOCKS_PER_SEC`</a> "clocks" within a second.  This is an easy, portable measurement, even though it's over-simplified.  

#### Answer 3 (score 261)
You can <strong>abstract the time measuring mechanism</strong> and have each callable's run time measured with <strong>minimal extra code</strong>, just by being called through a timer structure. Plus, at compile time you can <strong>parametrize the timing type</strong> (milliseconds, nanoseconds etc).   

<p><sup>Thanks to the review by <a href="https://stackoverflow.com/users/14065/loki-astari">Loki Astari</a> and the suggestion to use variadic templates.</sup>
<sup><a href="https://stackoverflow.com/q/31253334/2567683">This</a> is why the forwarded function call.</sup></p>

```c
#include <iostream>
#include <chrono>

template<typename TimeT = std::chrono::milliseconds>
struct measure
{
    template<typename F, typename ...Args>
    static typename TimeT::rep execution(F&& func, Args&&... args)
    {
        auto start = std::chrono::steady_clock::now();
        std::forward<decltype(func)>(func)(std::forward<Args>(args)...);
        auto duration = std::chrono::duration_cast< TimeT> 
                            (std::chrono::steady_clock::now() - start);
        return duration.count();
    }
};

int main() {
    std::cout << measure<>::execution(functor(dummy)) << std::endl;
}
```

<a href="http://ideone.com/JbUkPq" rel="noreferrer"><kbd><strong>Demo</strong></kbd></a>  

According to the comment by <a href="https://stackoverflow.com/users/576911/howard-hinnant"><strong>Howard Hinnant</strong></a> it's best not to escape out of the chrono system until we have to. So the above class could give the user the choice to call `count` manually by providing an extra static method (shown in C++14)  

```c
template<typename F, typename ...Args>
static auto duration(F&& func, Args&&... args)
{
    auto start = std::chrono::steady_clock::now();
    std::forward<decltype(func)>(func)(std::forward<Args>(args)...);
    return std::chrono::duration_cast<TimeT>(std::chrono::steady_clock::now()-start);
} 

// call .count() manually later when needed (eg IO)
auto avg = (measure<>::duration(func) + measure<>::duration(func)) / 2.0;
```

and be most useful for clients that   

<blockquote>
  "want to post-process a bunch of durations prior to I/O (e.g. average)"  
</blockquote>

<hr>

The complete <a href="https://github.com/picanumber/bureaucrat/blob/master/time_lapse.h" rel="noreferrer"><strong>code can be found here</strong></a>. My attempt to build a <strong>benchmarking tool</strong> based on chrono is recorded <a href="https://isocpp.org/blog/2015/04/https-ngathanasiou.wordpress.com-2015-04-01-benchmarking-in-c" rel="noreferrer"><strong>here</strong></a>.  

<hr>

If C++17's <a href="http://en.cppreference.com/w/cpp/utility/functional/invoke" rel="noreferrer">`std::invoke`</a> is available, the invocation of the callable in `execution` could be done like this :   

```c
invoke(forward<decltype(func)>(func), forward<Args>(args)...);
```

to provide for callables that are pointers to member functions.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: Strings and character with printf (score [465676](https://stackoverflow.com/q/8019615) in 2013)

#### Question
I was confused with usage of `%c` and `%s` in the following C program  

```c
#include<stdio.h>

    void main()
    {
     char name[]="siva";
     printf("%s\n",name);
     printf("%c\n",*name);
    }
```

Output is  

```c
siva
s
```

Why we need to use pointer to display a character %c, and pointer is not needed for a string  

I am getting error when i use  

```c
printf("%c\n", name);
```

Error i got is  

```c
str.c: In function ‘main’:
str.c:9:2: warning: format ‘%c’ expects type ‘int’, but argument 2 has type ‘char *’
```

#### Answer accepted (score 70)
If you try this:  

```c
#include<stdio.h>

void main()
{
 char name[]="siva";
 printf("name = %p\n", name);
 printf("&name[0] = %p\n", &name[0]);
 printf("name printed as %%s is %s\n",name);
 printf("*name = %c\n",*name);
 printf("name[0] = %c\n", name[0]);
}
```

Output is:  

```c
name = 0xbff5391b  
&name[0] = 0xbff5391b
name printed as %s is siva
*name = s
name[0] = s
```

So 'name' is actually a pointer to the array of characters in memory. If you try reading the first four bytes at 0xbff5391b, you will see 's', 'i', 'v' and 'a'  

```c
Location     Data
=========   ======

0xbff5391b    0x73  's'  ---> name[0]
0xbff5391c    0x69  'i'  ---> name[1]
0xbff5391d    0x76  'v'  ---> name[2]
0xbff5391e    0x61  'a'  ---> name[3]
0xbff5391f    0x00  '\0' ---> This is the NULL termination of the string
```

To print a character you need to pass the value of the character to printf. The value can be referenced as name[0] or *name (since for an array name = &amp;name[0]).  

To print a string you need to pass a pointer to the string to printf (in this case 'name' or '&amp;name[0]').  

#### Answer 2 (score 11)
```c
%c
```

is designed for a single character a char, so it print only one element.Passing the char array as a pointer you are passing the address of the first element of the array(that is a single char) and then will be printed :   

<strong>s</strong>  

```c
printf("%c\n",*name++);
```

will print   

<strong>i</strong>   

and so on ...  

Pointer is not needed for the %s because it can work directly with String of characters.  

#### Answer 3 (score 6)
<p>You're confusing the dereference operator * with pointer type annotation *.
Basically, in C * means different things in different places:</p>

<ul>
<li>In a type, * means a pointer. int is an integer type, int* is a pointer to integer type</li>
<li>As a prefix operator, * means 'dereference'. name is a pointer, *name is the result of dereferencing it (i.e. getting the value that the pointer points to)</li>
<li>Of course, as an infix operator, * means 'multiply'.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: What is the difference between const int*, const int * const, and int const *? (score [459578](https://stackoverflow.com/q/1143262) in 2017)

#### Question
I always mess up how to use `const int*`, `const int * const`, and `int const *` correctly. Is there a set of rules defining what you can and cannot do?  

I want to know all the do's and all don'ts in terms of assignments, passing to the functions, etc.  

#### Answer accepted (score 2072)
Read it backwards (as driven by <a href="http://c-faq.com/decl/spiral.anderson.html" rel="noreferrer">Clockwise/Spiral Rule</a>):  

<ul>
<li>`int*` - pointer to int</li>
<li>`int const *` - pointer to const int</li>
<li>`int * const` - const pointer to int</li>
<li>`int const * const` - const pointer to const int</li>
</ul>

Now the first `const` can be on either side of the type so:  

<ul>
<li>`const int *` == `int const *`</li>
<li>`const int * const` == `int const * const`</li>
</ul>

If you want to go really crazy you can do things like this:  

<ul>
<li>`int **` - pointer to pointer to int</li>
<li>`int ** const` - a const pointer to a pointer to an int</li>
<li>`int * const *` - a pointer to a const pointer to an int</li>
<li>`int const **` - a pointer to a pointer to a const int</li>
<li>`int * const * const` - a const pointer to a const pointer to an int</li>
<li>...</li>
</ul>

And to make sure we are clear on the meaning of const  

```c
const int* foo;
int *const bar; //note, you actually need to set the pointer 
                //here because you can't change it later ;)
```

`foo` is a variable pointer to a constant integer. This lets you change what you point to but not the value that you point to. Most often this is seen with C-style strings where you have a pointer to a `const char`. You may change which string you point to but you can't change the content of these strings. This is important when the string itself is in the data segment of a program and shouldn't be changed.  

`bar` is a constant or fixed pointer to a value that can be changed. This is like a reference without the extra syntactic sugar. Because of this fact, usually you would use a reference where you would use a `T* const` pointer unless you need to allow `NULL` pointers.  

#### Answer 2 (score 322)
<p>For those who don't know about Clockwise/Spiral Rule:
Start from the name of the variable, move clockwisely (in this case, move backward) to the next <strong>pointer</strong> or <strong>type</strong>. Repeat until expression ends.</p>

Here is a demo:  

<img src="https://i.stack.imgur.com/sT6ng.png" alt="pointer to int">  

<img src="https://i.stack.imgur.com/Zt0G2.png" alt="const pointer to int const">  

<img src="https://i.stack.imgur.com/kXH8P.png" alt="pointer to int const">  

<img src="https://i.stack.imgur.com/UeqZO.png" alt="pointer to const int">  

<img src="https://i.stack.imgur.com/f5ftV.png" alt="const pointer to int">  

#### Answer 3 (score 137)
I think everything is answered here already, but I just want to add that you should beware of `typedef`s! They're NOT just text replacements.  

For example:  

```c
typedef char *ASTRING;
const ASTRING astring;
```

The type of `astring` is `char * const`, not `const char *`. This is one reason I always tend to put `const` to the right of the type, and never at the start.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: 'float' vs. 'double' precision (score [457932](https://stackoverflow.com/q/5098558) in 2017)

#### Question
The code  

```c
float x  = 3.141592653589793238;
double z = 3.141592653589793238;
printf("x=%f\n", x);
printf("z=%f\n", z);
printf("x=%20.18f\n", x);
printf("z=%20.18f\n", z);
```

will give you the output  

```c
x=3.141593
z=3.141593
x=3.141592741012573242
z=3.141592653589793116
```

where on the third line of output `741012573242` is garbage and on the fourth line `116` is garbage. Do doubles always have 16 significant figures while floats always have 7 significant figures? Why don't doubles have 14 significant figures?  

#### Answer accepted (score 138)
Floating point numbers in C use <a href="http://en.wikipedia.org/wiki/IEEE_754-2008" rel="noreferrer">IEEE 754</a> encoding.  

This type of encoding uses a sign, a significand, and an exponent.  

Because of this encoding, many numbers will have small changes to allow them to be stored.  

Also, the number of significant digits can change slightly since it is a binary representation, not a decimal one.  

Single precision (float) gives you 23 bits of significand, 8 bits of exponent, and 1 sign bit.  

Double precision (double) gives you 52 bits of significand, 11 bits of exponent, and 1 sign bit.  

#### Answer 2 (score 38)
<blockquote>
  <p>Do doubles always have 16 significant
  figures while floats always have 7
  significant figures? </p>
</blockquote>

No.  Doubles always have 53 significant <strong>bits</strong> and floats always have 24 significant <strong>bits</strong> (except for denormals, infinities, and NaN values, but those are subjects for a different question).  These are binary formats, and you can only speak clearly about the precision of their representations in terms of binary digits (bits).  

This is analogous to the question of how many digits can be stored in a binary integer: an unsigned 32 bit integer can store integers with up to 32 bits, which doesn't precisely map to any number of decimal digits: all integers of up to 9 decimal digits can be stored, but a lot of 10-digit numbers can be stored as well.  

<blockquote>
  <p>Why don't doubles
  have 14 significant figures?</p>
</blockquote>

The encoding of a double uses 64 bits (1 bit for the sign, 11 bits for the exponent, 52 explicit significant bits and one implicit bit), which is <em>double</em> the number of bits used to represent a float (32 bits).  

#### Answer 3 (score 11)
<strong><em>float : 23 bits of significand, 8 bits of exponent, and 1 sign bit.</em></strong>  

<strong><em>double : 52 bits of significand, 11 bits of exponent, and 1 sign bit.</em></strong>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: How do you make an array of structs in C? (score [438475](https://stackoverflow.com/q/10468128) in 2019)

#### Question
I'm trying to make an array of structs where each struct represents a celestial body.  

I don't have that much experience with structs, which is why I decided to try to use them instead of a whole bunch of arrays. However, I keep on running into numerous different errors. I've tried to implement the techniques that I've seen on various threads and on StackOverflow (such as <a href="https://stackoverflow.com/questions/2575921/array-of-structs-in-c">Array of structs in C</a> and <a href="https://stackoverflow.com/questions/4173518/c-initialize-array-of-structs">C - initialize array of structs</a>), however not all of them were applicable.  

Further information for those who have read this far: I don't need any of this to be dynamic, I know/define the size of everything beforehand.  I also need this to be a global array as I'm accessing this in several different methods which have defined arguments (i.e. GLUT methods).    

This is how I'm defining the struct in my header:  

```c
struct body
{
    double p[3];//position
    double v[3];//velocity
    double a[3];//acceleration
    double radius;
    double mass;
};
```

I have a list of other global variables that I'm defining before I define the interior of the struct, and one of those is the array of this struct (basically, if I'm being too unclear in my fogged speak, the line below is above the stuff above):  

```c
struct body bodies[n];
```

Just so you know, `n` is something that I've legitimately defined (i.e. `#define n 1`).    

I use this array in several different methods, but the easiest and least space consuming one is a simplified form of my main. Here I initialize all of the variables in each of the structs, just to set the variables for certain before I modify them in some way:  

```c
  int a, b;
 for(a = 0; a < n; a++)
 {
        for(b = 0; b < 3; b++)
        {
            bodies[a].p[b] = 0;
            bodies[a].v[b] = 0;
            bodies[a].a[b] = 0;
        }
        bodies[a].mass = 0;
        bodies[a].radius = 1.0;
 }
```

The current error that I'm facing is `nbody.c:32:13: error: array type has incomplete element type` where line 32 is where I'm making the array of the structs.  

One last clarification, by header I mean the space above `int main(void)` but in the same `*.c` file.    

#### Answer accepted (score 97)
```c
#include<stdio.h>
#define n 3
struct body
{
    double p[3];//position
    double v[3];//velocity
    double a[3];//acceleration
    double radius;
    double mass;
};

struct body bodies[n];

int main()
{
    int a, b;
     for(a = 0; a < n; a++)
     {
            for(b = 0; b < 3; b++)
            {
                bodies[a].p[b] = 0;
                bodies[a].v[b] = 0;
                bodies[a].a[b] = 0;
            }
            bodies[a].mass = 0;
            bodies[a].radius = 1.0;
     }

    return 0;
}
```

this works fine. your question was not very clear by the way, so match the layout of your source code with the above.  

#### Answer 2 (score 11)
I think you could write it that way too. I am also a student so I understand your struggle. A bit late response but ok .  

```c
#include<stdio.h>
#define n 3

struct {
    double p[3];//position
    double v[3];//velocity
    double a[3];//acceleration
    double radius;
    double mass;
}bodies[n];
```

#### Answer 3 (score 10)
So to put it all together by using `malloc()`:  

```c
int main(int argc, char** argv) {
    typedef struct{
        char* firstName;
        char* lastName;
        int day;
        int month;
        int year;

    }STUDENT;

    int numStudents=3;
    int x;
    STUDENT* students = malloc(numStudents * sizeof *students);
    for (x = 0; x < numStudents; x++){
        students[x].firstName=(char*)malloc(sizeof(char*));
        scanf("%s",students[x].firstName);
        students[x].lastName=(char*)malloc(sizeof(char*));
        scanf("%s",students[x].lastName);
        scanf("%d",&students[x].day);
        scanf("%d",&students[x].month);
        scanf("%d",&students[x].year);
    }

    for (x = 0; x < numStudents; x++)
        printf("first name: %s, surname: %s, day: %d, month: %d, year: %d\n",students[x].firstName,students[x].lastName,students[x].day,students[x].month,students[x].year);

    return (EXIT_SUCCESS);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: What can be the reasons of connection refused errors? (score [436704](https://stackoverflow.com/q/2333400) in 2017)

#### Question
<p>I'm trying to write a server program in C, 
using another client, I get this error when I try to connect through port 2080 for example.</p>

```c
connection refused
```

What can be the reasons of this error?  

#### Answer accepted (score 78)
There could be many reasons, but the most common are:  

<ol>
<li><p>The port is not open on the destination machine.</p></li>
<li><p>The port is open on the destination machine, but its backlog of pending connections is full.</p></li>
<li><p>A firewall between the client and server is blocking access (also check local firewalls).</p></li>
</ol>

After checking for firewalls and that the port is open, use telnet to connect to the ip/port to test connectivity. This removes any potential issues from your application.  

#### Answer 2 (score 66)
The error means the OS of the listening socket recognized the inbound connection request but chose to intentionally reject it.    

Assuming an intermediate firewall is not getting in the way, there are only two reasons (that I know of) for the OS to reject an inbound connection request.  One reason has already been mentioned several times - the listening port being connected to is not open.    

There is another reason that has not been mentioned yet - the listening port is actually open and actively being used, but its backlog of queued inbound connection requests has reached its maximum so there is no room available for the inbound connection request to be queued at that moment.  The server code has not called accept() enough times yet to finish clearing out available slots for new queue items.    

Wait a moment or so and try the connection again.  Unfortunately, there is no way to differentiate between "the port is not open at all" and "the port is open but too busy right now".  They both use the same generic error code.  

#### Answer 3 (score 19)
If you try to open a TCP connection to another host and see the error "Connection refused," it means that  

<ol>
<li>You sent a TCP SYN packet to the other host.</li>
<li>Then you received a TCP RST packet in reply. </li>
</ol>

RST is a bit on the TCP packet which indicates that the connection should be reset. Usually it means that the other host has received your connection attempt and is actively refusing your TCP connection, but sometimes an intervening firewall may block your TCP SYN packet and send a TCP RST back to you.  

See <a href="https://tools.ietf.org/html/rfc793" rel="noreferrer">https://tools.ietf.org/html/rfc793</a> page 69:  

<blockquote>
  SYN-RECEIVED STATE  

```c
   If the RST bit is set

     If this connection was initiated with a passive OPEN (i.e.,
     came from the LISTEN state), then return this connection to
     LISTEN state and return.  The user need not be informed.  If
     this connection was initiated with an active OPEN (i.e., came
     from SYN-SENT state) then the connection was refused, signal
     the user "connection refused".  In either case, all segments
     on the retransmission queue should be removed.  And in the
     active OPEN case, enter the CLOSED state and delete the TCB,
     and return.
```
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Arrow operator (->) usage in C (score [433083](https://stackoverflow.com/q/2575048) in 2019)

#### Question
I am reading a book called "Teach Yourself C in 21 Days" (I have already learned Java and C# so I am moving at a much faster pace). I was reading the chapter on pointers and the `-&gt;` (arrow) <em>operator</em> came up without explanation. I think that it is used to call members and functions (like the equivalent of the `.` (dot) operator, but for pointers instead of members). But I am not entirely sure.  

Could I please get an explanation and a code sample?  

#### Answer accepted (score 432)
`foo-&gt;bar` is equivalent to `(*foo).bar`, i.e. it gets the member called `bar` from the struct that `foo` points to.  

#### Answer 2 (score 116)
Yes, that's it.  

It's just the dot version when you want to access elements of a struct/class that is a pointer instead of a reference.  

```c
struct foo
{
  int x;     // 5
  float y;
};

struct foo var;
struct foo* pvar;
pvar = malloc(sizeof(pvar));

var.x = 5;   // var.x is 5
(&var)->y = 14.3;
pvar->y = 22.4;
(*pvar).x = 6;   // (*pvar).x is 5
```

That's it!  

#### Answer 3 (score 31)
`a-&gt;b` is just short for `(*a).b` in every way (same for functions: `a-&gt;b()` is short for `(*a).b()`).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: Preventing console window from closing on Visual Studio C/C++ Console application (score [425965](https://stackoverflow.com/q/1775865) in 2013)

#### Question
This is a probably an embarasing question as no doubt the answer is blindingly obvious.  

I've used Visual Studio for years, but this is the first time I've done any 'Console Application' development.  

When I run my application the console window pops up, the program output appears and then the window closes as the application exits.  

Is there a way to either keep it open until I have checked the output, or view the results after the window has closed?  

#### Answer accepted (score 446)
If you run without debugging (Ctrl+F5) then by default it prompts your to press return to close the window. If you want to use the debugger, you should put a breakpoint on the last line.  

#### Answer 2 (score 218)
Right click on your project   

<blockquote>
  Properties > Configuration Properties > Linker > System  
</blockquote>

Select <strong>Console (/SUBSYSTEM:CONSOLE)</strong> in `SubSystem` option or you can just type <strong>Console</strong> in the text field!  

Now try it...it should work  

#### Answer 3 (score 45)
Here is a way for C/C++:  

```c
#include <stdlib.h>

#ifdef _WIN32
    #define WINPAUSE system("pause")
#endif
```

Put this at the top of your program, and IF it is on a Windows system (`#ifdef _WIN32`), then it will create a macro called `WINPAUSE`. Whenever you want your program to pause, call `WINPAUSE;` and it will pause the program, using the DOS command. For other systems like Unix/Linux, the console should not quit on program exit anyway.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: How to declare strings in C (score [424760](https://stackoverflow.com/q/8732325) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://stackoverflow.com/questions/4680431/memory-allocation-char-and-char">Memory Allocation char* and char[]</a>  </p>
</blockquote>



Can anyone explain me what is a difference between these lines of code  

```c
char *p = "String";
char p2[] = "String";
char p3[7] = "String";
```

In what case should I use each of the above ?  

#### Answer accepted (score 44)
<a href="http://www.lysator.liu.se/c/c-faq/c-2.html" rel="noreferrer">This link</a> should satisfy your curiosity.  

Basically (forgetting your third example which is bad), the different between 1 and 2 is that 1 allocates space for a pointer to the array.  

But in the code, you can manipulate them as pointers all the same -- only thing, you cannot reallocate the second.  

#### Answer 2 (score 40)
Strings in C are represented as arrays of characters.  

```c
char *p = "String";
```

You are declaring a pointer that points to a string stored some where in your program (modifying this string is undefined behavior) according to the C programming language 2 ed.  

```c
char p2[] = "String";
```

You are declaring an array of char initialized with the string "String" leaving to the compiler the job to count the size of the array.  

```c
char p3[5] = "String";
```

You are declaring an array of size 5 and initializing it with "String". This is an error be cause "String" don't fit in 5 elements.  

`char p3[7] = "String";` is the correct declaration ('\0' is the terminating character in c strings).  

<a href="http://c-faq.com/~scs/cclass/notes/sx8.html" rel="noreferrer">http://c-faq.com/~scs/cclass/notes/sx8.html</a>  

#### Answer 3 (score 21)
You shouldn't use the third one because its wrong. "String" takes 7 bytes, not 5.  

The first one is a pointer (can be reassigned to a different address), the other two are declared as arrays, and cannot be reassigned to different memory locations (but their content may change, use `const` to avoid that).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: How to print the array? (score [420176](https://stackoverflow.com/q/9726922) in 2012)

#### Question
```c
int main() {  
  int my array[3][3] =
    10, 23, 42,    
    1, 654, 0,  
    40652, 22, 0  
  };  

  printf("%d\n", my_array[3][3]);  
  return 0;
}
```

I am not able to get the array to print.. Any ideas why? I am a beginning programmer so any words of advice are appreciated.   

#### Answer accepted (score 27)
What you are doing is printing the value in the array at spot [3][3], which is invalid for a 3by3 array, you need to loop over all the spots and print them.  

```c
for(int i = 0; i < 3; i++) {
    for(int j = 0; j < 3; j++) {
        printf("%d ", array[i][j]);
    }
    printf("\n");
} 
```

This will print it in the following format  

```c
10 23 42
1 654 0
40652 22 0
```

if you want more exact formatting you'll have to change how the printf is formatted.  

#### Answer 2 (score 11)
There is no .length property in C.  The .length property can only be applied to arrays in object oriented programming (OOP) languages.  The .length property is inherited from the object class; the class all other classes &amp; objects inherit from in an OOP language.  Also, one would use .length-1 to return the number of the last index in an array; using just the .length will return the total length of the array.  

I would suggest something like this:  

```c
int index;
int jdex;
for( index = 0; index < (sizeof( my_array ) / sizeof( my_array[0] )); index++){
   for( jdex = 0; jdex < (sizeof( my_array ) / sizeof( my_array[0] )); jdex++){
        printf( "%d", my_array[index][jdex] );
        printf( "\n" );
   }
}
```

The line (sizeof( my_array ) / sizeof( my_array[0] )) will give you the size of the array in question.  The sizeof property will return the length in bytes, so one must divide the total size of the array in bytes by how many bytes make up each element, each element takes up 4 bytes because each element is of type int, respectively. The array is of total size 16 bytes and each element is of 4 bytes so 16/4 yields 4 the total number of elements in your array because indexing starts at 0 and not 1.  

#### Answer 3 (score 3)
It looks like you have a typo on your array, it should read:  

```c
int my_array[3][3] = {...
```

You don't have the `_` or the `{`.  

Also `my_array[3][3]` is an invalid location. Since computers begin counting at `0`, you are accessing position `4`. (Arrays are weird like that).  

If you want just the last element:  

```c
printf("%d\n", my_array[2][2]);
```

If you want the entire array:  

```c
for(int i = 0; i < my_array.length; i++) {
  for(int j = 0; j < my_array[i].length; j++)
    printf("%d ", my_array[i][j]);
  printf("\n");
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: Convert a character digit to the corresponding integer in C (score [415138](https://stackoverflow.com/q/628761) in 2017)

#### Question
Is there a way to convert a character to an integer in C?   

For example, from `'5'` to 5?  

#### Answer accepted (score 126)
As per other replies, this is fine:  

```c
char c = '5';
int x = c - '0';
```

Also, for error checking, you may wish to check isdigit(c) is true first. Note that you cannot completely portably do the same for letters, for example:  

```c
char c = 'b';
int x = c - 'a'; // x is now not necessarily 1
```

The standard guarantees that the char values for the digits '0' to '9' are contiguous, but makes no guarantees for other characters like letters of the alphabet.  

#### Answer 2 (score 39)
Subtract '0' like this:  

```c
int i = c - '0';
```

The C Standard guarantees each digit in the range `'0'..'9'` is one greater than its previous digit (in section `5.2.1/3` of the <a href="http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1124.pdf" rel="noreferrer">C99 draft</a>). The same counts for C++.  

#### Answer 3 (score 27)
If, by some crazy coincidence, you want to convert a <em>string</em> of characters to an integer, you can do that too!  

```c
char *num = "1024";
int val = atoi(num); // atoi = ASCII TO Int
```

`val` is now 1024. Apparently `atoi()` is fine, and what I said about it earlier only applies to me (on OS X (maybe (insert Lisp joke here))). I have heard it is a macro that maps roughly to the next example, which uses `strtol()`, a more general-purpose function, to do the conversion instead:  

```c
char *num = "1024";
int val = (int)strtol(num, (char **)NULL, 10); // strtol = STRing TO Long
```

`strtol()` works like this:  

```c
long strtol(const char *str, char **endptr, int base);
```

It converts `*str` to a `long`, treating it as if it were a base `base` number. If `**endptr` isn't null, it holds the first non-digit character `strtol()` found (but who cares about that).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: Get the current time in C (score [411745](https://stackoverflow.com/q/5141960) in 2016)

#### Question
I want to get the current time of my system. For that I'm using the following code in C:  

```c
time_t now;
struct tm *mytime = localtime(&now); 
if ( strftime(buffer, sizeof buffer, "%X", mytime) )
{
    printf("time1 = \"%s\"\n", buffer);
}
```

The problem is that this code is giving some random time. Also, the random time is different everytime. I want the current time of my system.  

#### Answer accepted (score 115)
Copy-pasted from <a href="http://www.cplusplus.com/reference/clibrary/ctime/localtime/" rel="noreferrer">here</a>:  

```c
/* localtime example */
#include <stdio.h>
#include <time.h>

int main ()
{
  time_t rawtime;
  struct tm * timeinfo;

  time ( &rawtime );
  timeinfo = localtime ( &rawtime );
  printf ( "Current local time and date: %s", asctime (timeinfo) );

  return 0;
}
```

(just add "void" to the main() arguments list in order for this to work in C)  

#### Answer 2 (score 63)
Initialize your `now` variable.  

```c
time_t now = time(0); // Get the system time
```

The `localtime` function is used to convert the time value in the passed `time_t` to a `struct tm`, it doesn't actually retrieve the system time.  

#### Answer 3 (score 33)
Easy way:   

```c
#include <time.h>
#include <stdio.h>

int main(void)
{
    time_t mytime = time(NULL);
    char * time_str = ctime(&mytime);
    time_str[strlen(time_str)-1] = '\0';
    printf("Current Time : %s\n", time_str);

    return 0;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: C compiler for Windows? (score [405559](https://stackoverflow.com/q/116368) in 2013)

#### Question
I'm fine working on Linux using gcc as my C compiler but would like a Windows solution. Any ideas? I've looked at <a href="http://en.wikipedia.org/wiki/Dev-C%2B%2B" rel="noreferrer">Dev-C++ from Bloodshed</a> but looking for more options.  

#### Answer accepted (score 78)
You can use GCC on Windows by downloading <a href="http://www.mingw.org/" rel="nofollow noreferrer">MingW</a> (<em>discontinued</em>) or its successor <a href="https://mingw-w64.org/" rel="nofollow noreferrer">Mingw-w64</a>.  

#### Answer 2 (score 36)
You can get <a href="http://www.microsoft.com/express/vc/" rel="noreferrer">Visual C++ Express Edition</a> straight from Microsoft, if you want something targeting Win32. Otherwise MinGW or lcc, as suggested elsewhere.  

#### Answer 3 (score 24)
GCC is ubiquitous. It is trusted and well understood by thousands of folks across dozens of communities.  

Visual Studio is perhaps the best IDE ever developed. It has a great compiler underneath it. But it is strictly Windows-only.  

If you're just playing, get GCC --it's free. If you're concerned about multiple platfroms, it's GCC. If you're talking serious Windows development, get Visual Studio.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: How do I properly compare strings? (score [401772](https://stackoverflow.com/q/8004237) in 2017)

#### Question
I am trying to get a program to let a user enter a word or character, store it, and then print it until the user types it again, exiting the program. My code looks like this:  

```c
#include <stdio.h>

int main()
{
    char input[40];
    char check[40];
    int i=0;
    printf("Hello!\nPlease enter a word or character:\n");
    gets(input);
    printf("I will now repeat this until you type it back to me.\n");

    while (check != input)
    {
        printf("%s\n", input);
        gets(check); 
    }

    printf("Good bye!");


    return 0;
}
```

The problem is that I keep getting the printing of the input string, even when the input by the user (check) matches the original (input). Am I comparing the two incorrectly?  

#### Answer accepted (score 252)
You can't (usefully) compare strings using `!=` or `==`, you need to use `strcmp`:  

```c
while (strcmp(check,input) != 0)
```

The reason for this is because `!=` and `==` will only compare the base addresses of those strings. Not the contents of the strings themselves.  

#### Answer 2 (score 31)
Ok a few things: `gets` is unsafe and should be replaced with `fgets(input, sizeof(input), stdin)` so that you don't get a buffer overflow.  

Next, to compare strings, you must use `strcmp`, where a return value of 0 indicates that the two strings match. Using the equality operators (ie. `!=`) compares the address of the two strings, as opposed to the individual `char`s inside them.  

And also note that, while in this example it won't cause a problem, `fgets` stores the newline character, `'\n'` in the buffers also; `gets()` does not. If you compared the user input from `fgets()` to a string literal such as `"abc"` it would never match (unless the buffer was too small so that the `'\n'` wouldn't fit in it).  

EDIT: and beaten by the super fast Mysticial once again.  

#### Answer 3 (score 8)
Use <a href="http://www.tutorialspoint.com/c_standard_library/c_function_strcmp.htm" rel="noreferrer">`strcmp`</a>.  

This is in `string.h` library, and is very popular. `strcmp` return 0 if the strings are equal. See <a href="https://stackoverflow.com/questions/34824838/what-does-strcmp-exactly-returns-in-c/34825545#34825545">this</a> for an better explanation of what `strcmp` returns.  

Basically, you have to do:  

```c
while (strcmp(check,input) != 0)
```

or  

```c
while (!strcmp(check,input))
```

or   

```c
while (strcmp(check,input))
```

You can check <a href="http://www.programiz.com/c-programming/library-function/string.h/strcmp" rel="noreferrer">this</a>, a tutorial on `strcmp`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Debug vs Release in CMake (score [398790](https://stackoverflow.com/q/7724569) in 2018)

#### Question
In a GCC compiled project,  

<ul>
<li>How do I run CMake for each target type (debug/release)?</li>
<li>How do I specify debug and release C/C++ flags using CMake?</li>
<li>How do I express that the main executable will be compiled with `g++` and one nested library with `gcc`?</li>
</ul>

#### Answer accepted (score 602)
With CMake, it's generally recommended to do an <a href="https://gitlab.kitware.com/cmake/community/wikis/FAQ#out-of-source-build-trees" rel="noreferrer">"out of source" build</a>. Create your `CMakeLists.txt` in the root of your project. Then from the root of your project:  

```c
mkdir Release
cd Release
cmake -DCMAKE_BUILD_TYPE=Release ..
make
```

And for `Debug` (again from the root of your project):  

```c
mkdir Debug
cd Debug
cmake -DCMAKE_BUILD_TYPE=Debug ..
make
```

`Release` / `Debug` will add the appropriate flags for your compiler. There are also `RelWithDebInfo` and `MinSizeRel` build configurations.  

<hr>

You can modify/add to the flags by specifying a <a href="https://cmake.org/cmake/help/v3.6/manual/cmake-toolchains.7.html" rel="noreferrer">toolchain file</a> in which you can add `CMAKE_C_FLAGS_DEBUG` and `CMAKE_C_FLAGS_RELEASE` variables, e.g.:  

```c
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Wall")
```

See <a href="https://cmake.org/cmake/help/latest/variable/CMAKE_BUILD_TYPE.html" rel="noreferrer">CMAKE_BUILD_TYPE</a> for more details.  

<hr>

As for your third question, I'm not sure what you are asking exactly. CMake should automatically detect and use the compiler appropriate for your different source files.  

#### Answer 2 (score 21)
For debug/release flags, see the `CMAKE_BUILD_TYPE` variable (you pass it as `cmake -DCMAKE_BUILD_TYPE=value`). It takes values like `Release`, `Debug`, etc.  

<a href="http://cmake.org/Wiki/CMake_Useful_Variables#Compilers_and_Tools" rel="noreferrer">http://cmake.org/Wiki/CMake_Useful_Variables#Compilers_and_Tools</a>  

cmake uses the extension to choose the compiler, so just name your files .c.  

You can override this with various settings:  

For example:  

```c
set_source_files_properties(yourfile.c LANGUAGE CXX) 
```

Would compile .c files with g++. The link above also shows how to select a specific compiler for C/C++.  

#### Answer 3 (score 14)
Instead of manipulating the `CMAKE_CXX_FLAGS` strings directly (which could be done more nicely using `string(APPEND CMAKE_CXX_FLAGS_DEBUG " -g3")` btw), you can use `add_compiler_options`:  

```c
add_compile_options(
  "-Wall" "-Wpedantic" "-Wextra" "-fexceptions"
  "$<$<CONFIG:DEBUG>:-O0;-g3;-ggdb>"
)
```

This would add the specified warnings to all build types, but only the given debugging flags to the `DEBUG` build. Note that compile options are stored as a CMake list, which is just a string separating its elements by semicolons `;`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: The Definitive C Book Guide and List (score [398612](https://stackoverflow.com/q/562303) in 2019)

#### Question
This question attempts to collect a community-maintained list of <strong><em>quality</em></strong> books on the <a href="/questions/tagged/c" class="post-tag" title="show questions tagged &#39;c&#39;" rel="tag">c</a> programming language, targeted at various skill levels.  

C is a complex programming language that is difficult to pick up on-the-go by reading online tutorials. A comprehensive book is often the best way to learn the language, and finding a good book is the first step. It is important to avoid badly-written books, and even more importantly, books that contain serious technical errors.  

Please suggest edits to the accepted answer to add quality books, with an approximate skill level and a short blurb/description about each book. (<em>Note that the question is locked, so no new answers will be accepted. A single answer is being maintained with the list</em>)  

Feel free to debate book choices, quality, headings, summaries, skill levels, and anything else you see that is wrong. Books that are deemed satisfactory by the C community here will stick around on the list; the rest will be regularly removed.  

For books that have reviews by the Association of C and C++ Users (ACCU), a link to those reviews should be added along with the book.  

See also:  

<ul>
<li>Other C-related resources in the <a href="/questions/tagged/c" class="post-tag" title="show questions tagged &#39;c&#39;" rel="tag">c</a> <a href="https://stackoverflow.com/tags/c/info">tag wiki</a></li>
<li>A similar list for <a href="/questions/tagged/c%2b%2b" class="post-tag" title="show questions tagged &#39;c++&#39;" rel="tag">c++</a>: <a href="https://stackoverflow.com/questions/388242/the-definitive-c-book-guide-and-list">The Definitive C++ Book Guide and List</a></li>
</ul>

<hr>

<sub>This question was discussed on <a href="https://meta.stackoverflow.com/a/378475">Meta</a> as part of the <a href="https://meta.stackoverflow.com/questions/378437/deleted-question-audit-2018">Deleted Questions Audit 2018</a>.<br>The consensus was to keep it undeleted and actively maintained.</sub>  

#### Answer 2 (score 471)


<sup><strong><em>Warning</em></strong></sup>  

<p><sup>
This is a list of random books of diverse quality. In the view of some people (with some justification), it is no longer a list of recommended books. Some of the listed books contain blatantly incorrect statements or teach wrong/harmful practices.  People who are aware of such books can edit this answer to help improve it.
See <a href="https://meta.stackoverflow.com/questions/355588/the-c-book-list-has-gone-haywire-what-to-do-with-it">The C book list has gone haywire. What to do with it?</a>, and also <a href="https://meta.stackoverflow.com/questions/378437/deleted-question-audit-2018">Deleted question audit 2018</a>.
</sup></p>

<h5>Reference (All Levels)</h1>

<ul>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0131103628" rel="nofollow noreferrer" rel="nofollow noreferrer">The C Programming Language (2nd Edition)</a> - Brian W. Kernighan and Dennis M. Ritchie (1988). Still a good, short but complete introduction to C (C90, not C99 or later versions), written by the inventor of C.  However, the language has changed and good C style has developed in the last 25 years, and there are parts of the book that show its age.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/013089592X" rel="nofollow noreferrer" rel="nofollow noreferrer">C: A Reference Manual (5th Edition)</a> - Samuel P. Harbison and Guy R. Steele (2002).  An excellent reference book on C, up to and including C99. It is not a tutorial, and probably unfit for beginners. It's great if you need to write a compiler for C, as the authors had to do when they started.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0596004362" rel="nofollow noreferrer" rel="nofollow noreferrer">C Pocket Reference (O'Reilly)</a> - Peter Prinz and Ulla Kirch-Prinz (2002).</p></li>
<li><p><a href="http://c-faq.com/" rel="nofollow noreferrer">The comp.lang.c FAQ</a> - Steve Summit. Web site with answers to many questions about C.</p></li>
<li><p>Various versions of the C language standards can be found <a href="http://www.iso-9899.info/wiki/The_Standard" rel="nofollow noreferrer">here</a>.  There is an online version of the <a href="http://port70.net/~nsz/c/c11/n1570.html" rel="nofollow noreferrer">draft C11 standard</a>.</p></li>
<li><p><a href="http://www.knosof.co.uk/cbook/cbook.html" rel="nofollow noreferrer">The new C standard - an annotated reference</a> (Free PDF) - Derek M. Jones (2009).  The "new standard" referred to is the old C99 standard rather than C11.</p></li>
<li><p><a href="http://www.open-std.org/JTC1/SC22/WG14/www/C99RationaleV5.10.pdf" rel="nofollow noreferrer">Rationale for C99 Standard</a>.</p></li>
</ul>

<hr>

<h5>Beginner</h1>

<ul>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0321776410" rel="nofollow noreferrer" rel="nofollow noreferrer">Programming in C (4th Edition)</a> - Stephen Kochan (2014). A good general introduction and tutorial.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0672326965" rel="nofollow noreferrer" rel="nofollow noreferrer">C Primer Plus (5th Edition)</a> - Stephen Prata (2004)</p></li>
<li><p><a href="http://knking.com/books/c2/index.html" rel="nofollow noreferrer">C Programming: A Modern Approach (2nd Edition)</a> - K. N. King (2008).  A good book for learning C.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201183994" rel="nofollow noreferrer" rel="nofollow noreferrer">A Book on C</a> - Al Kelley/Ira Pohl (1998).</p></li>
<li><p><a href="http://publications.gbdirect.co.uk/c_book/" rel="nofollow noreferrer">The C Book</a> (Free Online) - Mike Banahan, Declan Brady, and Mark Doran (1991).</p></li>
<li><p><a href="https://www.amazon.com//dp/0133976890" rel="nofollow noreferrer">C: How to Program (8th Edition)</a> - Paul Deitel and Harvey M. Deitel (2015). Lots of good tips and best practices for beginners. The index is very good and serves as a decent reference (just not fully comprehensive, and very shallow).</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/1449399916" rel="nofollow noreferrer" rel="nofollow noreferrer">Head First C</a> - David Griffiths and Dawn Griffiths (2012).</p></li>
<li><p><a href="https://www.apress.com/book/9781430248811" rel="nofollow noreferrer">Beginning C (5th Edition)</a> - Ivor Horton (2013). Very good explanation of pointers, using lots of small but complete programs.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0672324482" rel="nofollow noreferrer" rel="nofollow noreferrer">Sams Teach Yourself C in 21 Days</a> - Bradley L. Jones and Peter Aitken (2002). Very good introductory stuff.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0023611413" rel="nofollow noreferrer" rel="nofollow noreferrer">Applications Programming in ANSI C</a> - Richard Johnsonbaugh and Martin Kalin (1996).</p></li>
</ul>

<h5>Intermediate</h1>

<ul>
<li><p><a href="http://www.planetpdf.com/codecuts/pdfs/ooc.pdf" rel="nofollow noreferrer">Object-oriented Programming with ANSI-C</a> (Free PDF) - Axel-Tobias Schreiner (1993).
The code gets a bit convoluted.  If you want C++, use C++.</p></li>
<li><p><a href="http://www.cs.princeton.edu/software/cii/" rel="nofollow noreferrer">C Interfaces and Implementations</a> - David R. Hanson (1997). Provides information on how to define a boundary between an interface and implementation in C in a generic and reusable fashion. It also demonstrates this principle by applying it to the implementation of common mechanisms and data structures in C, such as lists, sets, exceptions, string manipulation, memory allocators, and more. Basically, Hanson took all the code he'd written as part of building <a href="http://www.cs.arizona.edu/icon" rel="nofollow noreferrer">Icon</a> and <a href="http://www.cs.princeton.edu/software/lcc/" rel="nofollow noreferrer">lcc</a> and pulled out the best bits in a form that other people could reuse for their own projects. It's a model of good C programming using modern design techniques (including Liskov's data abstraction), showing how to organize a big C project as a bunch of useful libraries.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201604612" rel="nofollow noreferrer" rel="nofollow noreferrer">The C Puzzle Book</a> - Alan R. Feuer (1998)</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0131315099" rel="nofollow noreferrer" rel="nofollow noreferrer">The Standard C Library</a> - P.J. Plauger (1992). It contains the complete source code to an implementation of the C89 standard library, along with extensive discussion about the design and why the code is designed as shown.</p>

</li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/1449327141" rel="nofollow noreferrer" rel="nofollow noreferrer">21st Century C: C Tips from the New School</a> - Ben Klemens (2012). In addition to the C language, the book explains gdb, valgrind, autotools, and git. The comments on style are found in the last part (Chapter 6 and beyond).</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201314525" rel="nofollow noreferrer" rel="nofollow noreferrer">Algorithms in C</a> - Robert Sedgewick (1997). Gives you a real grasp of implementing algorithms in C. Very lucid and clear; will probably make you want to throw away all of your other algorithms books and keep this one.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0673999866" rel="nofollow noreferrer" rel="nofollow noreferrer">Pointers on C</a> - Kenneth Reek (1997).</p></li>
<li><p><a href="http://www.apress.com/9781430259114" rel="nofollow noreferrer">Pointers in C</a> - Naveen Toppo and Hrishikesh Dewan (2013).</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0321535421" rel="nofollow noreferrer" rel="nofollow noreferrer">Problem Solving and Program Design in C (6th Edition)</a> - Jeri R. Hanly and Elliot B. Koffman (2009).</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/B00101Y58Q" rel="nofollow noreferrer" rel="nofollow noreferrer">Data Structures - An Advanced Approach Using C</a> - Jeffrey Esakov and Tom Weiss (1989).</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0672318962" rel="nofollow noreferrer" rel="nofollow noreferrer">C Unleashed</a> - Richard Heathfield, Lawrence Kirby, et al. (2000). Not ideal, but it is worth intermediate programmers practicing problems written in this book. This is a good cookbook-like approach suggested by comp.lang.c contributors.</p></li>
</ul>



<ul>
<li><a href="http://icube-icps.unistra.fr/index.php/File:ModernC.pdf" rel="nofollow noreferrer">Modern C</a> — Jens Gustedt (2017).  Covers C in 5 levels (encounter, acquaintance, cognition, experience, ambition) from beginning C to advanced C.  It covers C11 threads and atomic access, which few other books do and not all compilers recognize in all environments.</li>
</ul>

<h5>Expert</h1>

<ul>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0131774298" rel="nofollow noreferrer" rel="nofollow noreferrer">Expert C Programming: Deep C Secrets</a> - Peter van der Linden (1994). Lots of interesting information and war stories from the Sun compiler team, but a little dated in places. </p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0534951406" rel="nofollow noreferrer" rel="nofollow noreferrer">Advanced C Programming by Example</a> - John W. Perry (1998).</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0321637739" rel="nofollow noreferrer" rel="nofollow noreferrer">Advanced Programming in the UNIX Environment</a> - Richard W. Stevens and Stephen A. Rago (2013).  Comprehensive description of how to use the Unix APIs from C code, but not so much about the mechanics of C coding.</p></li>
</ul>







<hr>

<h5>Uncategorized</h1>

<ul>
<li><p><a href="http://cslibrary.stanford.edu/101/EssentialC.pdf" rel="nofollow noreferrer">Essential C</a> (Free PDF) - Nick Parlante (2003). Note that this describes the C90 language at several points (<em>e.g.</em>, in discussing `//` comments and placement of variable declarations at arbitrary points in the code), so it should be treated with some caution.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201845199" rel="nofollow noreferrer" rel="nofollow noreferrer">C Programming FAQs: Frequently Asked Questions</a> - Steve Summit (1995).  This is the book of the web site listed earlier.  It doesn't cover C99 or the later standards.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0596006977" rel="nofollow noreferrer" rel="nofollow noreferrer">C in a Nutshell</a> - Peter Prinz and Tony Crawford (2005). Excellent book if you need a reference for C99.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201419505" rel="nofollow noreferrer" rel="nofollow noreferrer">Functional C</a> - Pieter Hartel and Henk Muller (1997). Teaches modern practices that are invaluable for low-level programming, with concurrency and modularity in mind.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/020161586X" rel="nofollow noreferrer" rel="nofollow noreferrer">The Practice of Programming</a> - Brian W. Kernighan and Rob Pike (1999). A very good book to accompany K&amp;R. It uses C++ and Java too.</p></li>
</ul>



<ul>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201179288" rel="nofollow noreferrer" rel="nofollow noreferrer">C Traps and Pitfalls</a> by A. Koenig (1989). Very good, but the C style pre-dates standard C, which makes it less recommendable these days.</p>

<sup>Some have argued for the removal of 'Traps and Pitfalls' from this list because it has trapped some people into making mistakes; others continue to argue for its inclusion.  Perhaps it should be regarded as an 'expert' book because it requires a moderately extensive knowledge of C to understand what's changed since it was published.</sup>  </li>
</ul>









<ul>
<li><p><a href="http://www.buildyourownlisp.com/" rel="nofollow noreferrer">Build Your Own Lisp</a> — Daniel Holden (2014). An enjoyable way to learn C.</p></li>
<li><p><a href="http://www.misra-c.com/Activities/MISRAC/tabid/160/Default.aspx" rel="nofollow noreferrer">MISRA-C</a> - industry standard published and maintained by the Motor Industry Software Reliability Association. Covers C89 and C99.</p>

<p><sup>Although this isn't a book as such, many programmers recommend reading and implementing as much of it as possible. MISRA-C was originally intended as guidelines for safety-critical applications in particular, but it applies to any area of application where stable, bug-free C code is desired (who doesn't want fewer bugs?). MISRA-C is becoming the de facto standard in the whole embedded industry and is getting increasingly popular even in other programming branches. There are (at least) three publications of the standard (1998, 2004, and the current version from 2012). There is also a MISRA Compliance Guidelines document from 2016, and MISRA C:2012 Amendment 1 — Additional Security Guidelines for MISRA C:2012 (published in April 2016).<br>
Note that some of the strictures in the MISRA rules are not appropriate to every context. For example, directive 4.12 states "Dynamic memory allocation shall not be used". This is appropriate in the embedded systems for which the MISRA rules are designed; it is not appropriate everywhere. (Compilers, for instance, generally use dynamic memory allocation for things like symbol tables, and to do without dynamic memory allocation would be difficult, if not preposterous.)</sup></p></li>
<li><p>Archived lists of ACCU-reviewed books on <a href="https://web.archive.org/web/20071105015557/http://www.accu.informika.ru/bookreviews/public/reviews/0sb/beginner_s_c.htm" rel="nofollow noreferrer">Beginner's C</a> (116 titles) from 2007 and <a href="https://web.archive.org/web/20081020081215/http://www.accu.informika.ru/bookreviews/public/reviews/0sb/advanced_c.htm" rel="nofollow noreferrer">Advanced C</a> (76 titles) from 2008. Most of these don't look to be on the main site anymore, and you can't browse that by subject anyway.</p></li>
</ul>

<hr>

<h5>Warnings</h1>

Be wary of books written by <a href="http://catb.org/~esr/jargon/html/B/bullschildt.html" rel="nofollow noreferrer">Herbert Schildt</a>. In particular, you should stay away from <a href="https://rads.stackoverflow.com/amzn/click/com/0072121246" rel="nofollow noreferrer" rel="nofollow noreferrer">C: The Complete Reference</a> (4th Edition, 2000), known in some circles as C: The Complete Nonsense.  

Also do not use the book <a href="https://smile.amazon.com/dp/9387284492/" rel="nofollow noreferrer">Let Us C</a> (16<sup>th</sup> Edition, 2017) by Yashwant Kanetkar. Many people view it as an outdated book that teaches Turbo C and has lots of obsolete, misleading and incorrect material. For example, page 137 discusses the expected output from `printf("%d %d %d\n", a, ++a, a++)` and does not categorize it as <a href="https://stackoverflow.com/questions/949433/why-are-these-constructs-using-pre-and-post-increment-undefined-behavior">undefined behaviour</a> as it should.  

<p><a href="https://learncodethehardway.org/c/" rel="nofollow noreferrer">Learn C The Hard Way</a> (2015) by Zed Shaw. A book with mixed reviews.
  <a href="http://hentenaar.com/dont-learn-c-the-wrong-way" rel="nofollow noreferrer">A critique of this book</a> by Tim Hentenaar:</p>

<blockquote>
  To summarize my views, which are laid out below, the author presents the material in a greatly oversimplified and misleading way, the whole corpus is a bundled mess, and some of the opinions and analyses he offers are just plain wrong. I've tried to view this book through the eyes of a novice, but unfortunately I am biased by years of experience writing code in C. It's obvious to me that either the author has a flawed understanding of C, or he's deliberately oversimplifying to the point where he's actually misleading the reader (intentionally or otherwise.)  
</blockquote>

"Learn C The Hard Way" is not a book that I could recommend to someone who is both learning to program and learning C.  If you're already a competent programmer in some other related language, then it represents an interesting and unusual exposition on C, though I have reservations about parts of the book.  <sub><em>Jonathan Leffler</em></sub>  

<hr>

<h5>Outdated</h1>

<ul>
<li><a href="https://rads.stackoverflow.com/amzn/click/com/1565923065" rel="nofollow noreferrer" rel="nofollow noreferrer">Practical C Programming (3rd Edition)</a> - Steve Oualline (1997)(Beginner)</li>
</ul>

<hr>

<p><sub><strong>Other contributors</strong>, not necessarily credited in the revision history, include:<br>
<a href="https://stackoverflow.com/users/844882/alex-lockwood">Alex Lockwood</a>,
<a href="https://stackoverflow.com/users/479989/ben-jackson">Ben Jackson</a>,
<a href="https://stackoverflow.com/users/631423/bubbles">Bubbles</a>,
<a href="https://stackoverflow.com/users/193653/claws">claws</a>,
<a href="https://stackoverflow.com/users/14463/coledot">coledot</a>,
<a href="https://stackoverflow.com/users/3161/dana-robinson">Dana Robinson</a>,
<a href="https://stackoverflow.com/users/1322636/daniel-holden">Daniel Holden</a>,
<a href="https://stackoverflow.com/users/50305/dervin-thunk">Dervin Thunk</a>,
<a href="https://stackoverflow.com/users/57301/dwc">dwc</a>,
<a href="https://stackoverflow.com/users/2226524/eric-hou">Erci Hou</a>,
<a href="https://stackoverflow.com/users/102600/garen">Garen</a>,
<a href="https://stackoverflow.com/users/714232/haziz">haziz</a>,
<a href="https://stackoverflow.com/users/1029106/johan-bezem">Johan Bezem</a>,
<a href="https://stackoverflow.com/users/15168/jonathan-leffler">Jonathan Leffler</a>,
<a href="https://stackoverflow.com/users/141186/joshua-partogi">Joshua Partogi</a>,
<a href="https://stackoverflow.com/users/74660/lucas">Lucas</a>,
<a href="https://stackoverflow.com/users/584518/lundin">Lundin</a>,
<a href="https://stackoverflow.com/users/52734/mattk">Matt K.</a>,
<a href="https://stackoverflow.com/users/487623/mossplix">mossplix</a>,
<a href="https://stackoverflow.com/users/147192/matthieu-m">Matthieu M.</a>,
<a href="https://stackoverflow.com/users/3991400/midor">midor</a>,
<a href="https://stackoverflow.com/users/39892/nietzche-jou">Nietzche-jou</a>,
<a href="https://stackoverflow.com/users/41661/norman-ramsey">Norman Ramsey</a>,
<a href="https://stackoverflow.com/users/416623/r3st0r3">r3st0r3</a>,
<a href="https://stackoverflow.com/users/2395058/ridthyself">ridthyself</a>,
<a href="https://stackoverflow.com/users/71074/robert-s-barnes">Robert S. Barnes</a>,
<a href="https://stackoverflow.com/users/3923896/steve-summit">Steve Summit</a>,
<a href="https://stackoverflow.com/users/3685/tim-ring">Tim Ring</a>,
<a href="https://stackoverflow.com/users/207003/tony-bai">Tony Bai</a>,
<a href="https://stackoverflow.com/users/213550/vmatm">VMAtm</a>
</sub></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: Execution time of C program (score [396880](https://stackoverflow.com/q/5248915) in 2016)

#### Question
I have a C program that aims to be run in parallel on several processors. I need to be able to record the execution time (which could be anywhere from 1 second to several minutes). I have searched for answers, but they all seem to suggest using the `clock()` function, which then involves calculating the number of clocks the program took divided by the `Clocks_per_second` value.  

I'm not sure how the `Clocks_per_second` value is calculated?   

In Java, I just take the current time in milliseconds before and after execution.   

Is there a similar thing in C? I've had a look, but I can't seem to find a way of getting anything better than a second resolution.   

I'm also aware a profiler would be an option, but am looking to implement a timer myself.  

Thanks  

#### Answer accepted (score 314)
`CLOCKS_PER_SEC` is a constant which is declared in `&lt;time.h&gt;`. To get the CPU time used by a task within a C application, use:  

```c
clock_t begin = clock();

/* here, do your time-consuming job */

clock_t end = clock();
double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
```

Note that this returns the time as a floating point type. This can be more precise than a second (e.g. you measure 4.52 seconds). Precision depends on the architecture; on modern systems you easily get 10ms or lower, but on older Windows machines (from the Win98 era) it was closer to 60ms.  

`clock()` is standard C; it works "everywhere". There are system-specific functions, such as `getrusage()` on Unix-like systems.  

Java's `System.currentTimeMillis()` does not measure the same thing. It is a "wall clock": it can help you measure how much time it took for the program to execute, but it does not tell you how much CPU time was used. On a multitasking systems (i.e. all of them), these can be widely different.  

#### Answer 2 (score 107)
If you are using the Unix shell for running, you can use the time command.  

doing   

```c
$ time ./a.out
```

assuming a.out as the executable will give u the time taken to run this  

#### Answer 3 (score 58)
You functionally want this:  

```c
#include <sys/time.h>

struct timeval  tv1, tv2;
gettimeofday(&tv1, NULL);
/* stuff to do! */
gettimeofday(&tv2, NULL);

printf ("Total time = %f seconds\n",
         (double) (tv2.tv_usec - tv1.tv_usec) / 1000000 +
         (double) (tv2.tv_sec - tv1.tv_sec));
```

Note that this measures in microseconds, not just seconds.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: makefile:4: *** missing separator. Stop (score [394642](https://stackoverflow.com/q/16931770) in 2013)

#### Question
This is my makefile:  

```c
all:ll

ll:ll.c   
  gcc  -c  -Wall -Werror -02 c.c ll.c  -o  ll  $@  $<

clean :
  \rm -fr ll
```

When I try to `make clean` or `make make`, I get this error:  

```c
:makefile:4: *** missing separator.  Stop.
```

How can I fix it?  

#### Answer accepted (score 808)
makefile has a very stupid relation with tabs, all actions of every rule are identified by tabs ...... and No 4 spaces don't make a tab, only a tab makes a tab...  

to check I use the command `cat -e -t -v makefile_name`  

It shows the presence of tabs with `^I` and line endings with `$` both are vital to ensure that dependencies end properly and tabs mark the action for the rules so that they are easily identifiable to the make utility.....  

Example:  

```c
Kaizen ~/so_test $ cat -e -t -v  mk.t
all:ll$      ## here the $ is end of line ...                   
$
ll:ll.c   $
^Igcc  -c  -Wall -Werror -02 c.c ll.c  -o  ll  $@  $<$ 
## the ^I above means a tab was there before the action part, so this line is ok .
 $
clean :$
   \rm -fr ll$
## see here there is no ^I which means , tab is not present .... 
## in this case you need to open the file again and edit/ensure a tab 
## starts the action part
```

hope this helps !!  

#### Answer 2 (score 26)
You should always write command after a "tab" and not white space.  

This applies to "gcc" line (line #4) in your case. You need to insert tab before gcc.  

Also replace    \rm -fr ll with "rm -fr ll". Insert tabs before this command too  

#### Answer 3 (score 23)
On VS Code, just click the "Space: 4" on the downright corner and change it to tab when editing your Makefile.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Initialization of a normal array with one default value (score [390258](https://stackoverflow.com/q/1065774) in 2016)

#### Question
<a href="http://www.fredosaurus.com/notes-cpp/arrayptr/array-initialization.html" rel="noreferrer">C++ Notes: Array Initialization</a> has a nice list over initialization of arrays. I have a  

```c
int array[100] = {-1};
```

expecting it to be full with -1's but its not, only first value is and the rest are 0's mixed with random values.  

The code  

```c
int array[100] = {0};
```

works just fine and sets each element to 0.  

What am I missing here.. Can't one initialize it if the value isn't zero ?  

2: Is the default initialization (as above ) faster than the usual loop through the whole array and assign a value or does it do the same thing?  

#### Answer accepted (score 328)
Using the syntax that you used,  

```c
int array[100] = {-1};
```

says "set the first element to `-1` and the rest to `0`" since all omitted elements are set to `0`.  

In C++, to set them all to `-1`, you can use something like <a href="http://en.cppreference.com/w/cpp/algorithm/fill_n" rel="noreferrer">`std::fill_n`</a> (from `&lt;algorithm&gt;`):  

```c
std::fill_n(array, 100, -1);
```

In portable C, you have to roll your own loop. There are compiler-extensions or you can depend on implementation-defined behavior as a shortcut if that's acceptable.  

#### Answer 2 (score 130)
There is an extension to the gcc compiler which allows the syntax:  

```c
int array[100] = { [0 ... 99] = -1 };
```

This would set all of the elements to -1.  

This is known as "Designated Initializers" see <a href="http://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html" rel="noreferrer">here</a> for further information.  

Note this isn't implemented for the gcc c++ compiler.  

#### Answer 3 (score 31)
The page you linked to already gave the answer to the first part:  

<blockquote>
  <p>If an explicit array size is
  specified, but an shorter
  initiliazation list is specified, the
  unspecified elements are set to zero.</p>
</blockquote>

There is no built-in way to initialize the entire array to some non-zero value.  

As for which is faster, the usual rule applies: "The method that gives the compiler the most freedom is probably faster".  

```c
int array[100] = {0};
```

simply tells the compiler "set these 100 ints to zero", which the compiler can optimize freely.  

```c
for (int i = 0; i < 100; ++i){
  array[i] = 0;
}
```

is a lot more specific. It tells the compiler to create an iteration variable `i`, it tells it the <em>order</em> in which the elements should be initialized, and so on. Of course, the compiler is likely to optimize that away, but the point is that here you are overspecifying the problem, forcing the compiler to work harder to get to the same result.  

Finally, if you want to set the array to a non-zero value, you should (in C++, at least) use `std::fill`:  

```c
std::fill(array, array+100, 42); // sets every value in the array to 42
```

Again, you could do the same with an array, but this is more concise, and gives the compiler more freedom. You're just saying that you want the entire array filled with the value 42. You don't say anything about in which order it should be done, or anything else.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: Check substring exists in a string in C (score [385439](https://stackoverflow.com/q/12784766) in 2017)

#### Question
I'm trying to check whether a string contains a substring in C like:  

```c
char *sent = "this is my sample example";
char *word = "sample";
if (/* sentence contains word */) {
    /* .. */
}
```

What is something to use instead of `string::find` in C++?  

#### Answer accepted (score 241)
```c
if(strstr(sent, word) != NULL) {
    /* ... */
}
```

Note that `strstr` returns a pointer to the start of the word in `sent` if the word `word` is found.  

#### Answer 2 (score 29)
Use `strstr` for this.  

<a href="http://www.cplusplus.com/reference/clibrary/cstring/strstr/">http://www.cplusplus.com/reference/clibrary/cstring/strstr/</a>  

So, you'd write it like..  

```c
char *sent = "this is my sample example";
char *word = "sample";

char *pch = strstr(sent, word);

if(pch)
{
    ...
}
```

#### Answer 3 (score 11)
Try to use pointers...  

```c
#include <stdio.h>
#include <string.h>

int main()
{

  char str[] = "String1 subString1 Strinstrnd subStr ing1subString";
  char sub[] = "subString";

  char *p1, *p2, *p3;
  int i=0,j=0,flag=0;

  p1 = str;
  p2 = sub;

  for(i = 0; i<strlen(str); i++)
  {
    if(*p1 == *p2)
      {
          p3 = p1;
          for(j = 0;j<strlen(sub);j++)
          {
            if(*p3 == *p2)
            {
              p3++;p2++;
            } 
            else
              break;
          }
          p2 = sub;
          if(j == strlen(sub))
          {
             flag = 1;
            printf("\nSubstring found at index : %d\n",i);
          }
      }
    p1++; 
  }
  if(flag==0)
  {
       printf("Substring NOT found");
  }
return (0);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: How do I concatenate two strings in C? (score [384554](https://stackoverflow.com/q/8465006) in 2017)

#### Question
How do I add two strings?  

I tried `name = "derp" + "herp";`, but I got an error:  

<blockquote>
  Expression must have integral or enum type  
</blockquote>

#### Answer accepted (score 153)
C does not have the support for strings that some other languages have. A string in C is just a pointer to an array of `char` that is terminated by the first null character. There is no string concatenation operator in C.  

Use `strcat` to concatenate two strings. You could use the following function to do it:  

```c
#include <stdlib.h>
#include <string.h>

char* concat(const char *s1, const char *s2)
{
    char *result = malloc(strlen(s1) + strlen(s2) + 1); // +1 for the null-terminator
    // in real code you would check for errors in malloc here
    strcpy(result, s1);
    strcat(result, s2);
    return result;
}
```

This is not the fastest way to do this, but you shouldn't be worrying about that now. Note that the function returns a block of heap allocated memory to the caller and passes on ownership of that memory. It is the responsibility of the caller to `free` the memory when it is no longer needed.  

Call the function like this:  

```c
char* s = concat("derp", "herp");
// do things with s
free(s); // deallocate the string
```

If you did happen to be bothered by performance then you would want to avoid repeatedly scanning the input buffers looking for the null-terminator.  

```c
char* concat(const char *s1, const char *s2)
{
    const size_t len1 = strlen(s1);
    const size_t len2 = strlen(s2);
    char *result = malloc(len1 + len2 + 1); // +1 for the null-terminator
    // in real code you would check for errors in malloc here
    memcpy(result, s1, len1);
    memcpy(result + len1, s2, len2 + 1); // +1 to copy the null-terminator
    return result;
}
```

If you are planning to do a lot of work with strings then you may be better off using a different language that has first class support for strings.  

#### Answer 2 (score 16)
```c
#include <stdio.h>

int main(){
    char name[] =  "derp" "herp";
    printf("\"%s\"\n", name);//"derpherp"
    return 0;
}
```

#### Answer 3 (score 13)
David Heffernan <a href="https://stackoverflow.com/a/8465083/471214">explained</a> the issue in his answer, and I wrote the improved code. See below.  

<h5>A generic function</h1>

We can write a useful <a href="http://en.wikipedia.org/wiki/Variadic_function" rel="nofollow noreferrer">variadic function</a> to concatenate any number of strings:  

```c
#include <stdlib.h>       // calloc
#include <stdarg.h>       // va_*
#include <string.h>       // strlen, strcpy

char* concat(int count, ...)
{
    va_list ap;
    int i;

    // Find required length to store merged string
    int len = 1; // room for NULL
    va_start(ap, count);
    for(i=0 ; i<count ; i++)
        len += strlen(va_arg(ap, char*));
    va_end(ap);

    // Allocate memory to concat strings
    char *merged = calloc(sizeof(char),len);
    int null_pos = 0;

    // Actually concatenate strings
    va_start(ap, count);
    for(i=0 ; i<count ; i++)
    {
        char *s = va_arg(ap, char*);
        strcpy(merged+null_pos, s);
        null_pos += strlen(s);
    }
    va_end(ap);

    return merged;
}
```

<h5>Usage</h1>

```c
#include <stdio.h>        // printf

void println(char *line)
{
    printf("%s\n", line);
}

int main(int argc, char* argv[])
{
    char *str;

    str = concat(0);             println(str); free(str);
    str = concat(1,"a");         println(str); free(str);
    str = concat(2,"a","b");     println(str); free(str);
    str = concat(3,"a","b","c"); println(str); free(str);

    return 0;
}
```

Output:  

```c
  // Empty line
a
ab
abc
```

<h5>Clean-up</h1>

Note that you should free up the allocated memory when it becomes unneeded to avoid memory leaks:  

```c
char *str = concat(2,"a","b");
println(str);
free(str);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: Why are #ifndef and #define used in C++ header files? (score [381732](https://stackoverflow.com/q/1653958) in 2019)

#### Question
I have been seeing code like this usually in the start of header files:  

```c
#ifndef HEADERFILE_H
#define HEADERFILE_H
```

And at the end of the file is  

```c
#endif
```

What is the purpose of this?  

#### Answer accepted (score 488)
Those are called <a href="http://en.wikipedia.org/wiki/Include_guard" rel="noreferrer">#include guards</a>.  

Once the header is included, it checks if a unique value (in this case `HEADERFILE_H`) is defined. Then if it's not defined, it defines it and continues to the rest of the page.  

When the code is included again, the first `ifndef` fails, resulting in a blank file.  

That prevents double declaration of any identifiers such as types, enums and static variables.  

#### Answer 2 (score 31)
```c
#ifndef <token>
/* code */
#else
/* code to include if the token is defined */
#endif
```

`#ifndef` checks whether the given token has been `#defined` earlier in the file or in an included file; if not, it includes the code between it and the closing `#else` or, if no `#else` is present, `#endif` statement. `#ifndef` is often used to make header files idempotent by defining a token once the file has been included and checking that the token was not set at the top of that file.  

```c
#ifndef _INCL_GUARD
#define _INCL_GUARD
#endif
```

#### Answer 3 (score 8)
This prevent from the multiple inclusion of same header file multiple time.  

```c
#ifndef __COMMON_H__
#define __COMMON_H__
//header file content
#endif
```

<p>Suppose you have included this header file in multiple files. So first time 
__COMMON_H__ is not defined, it will get defined and header file included.</p>

Next time __COMMON_H__ is defined, so it will not include again.    

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: C pointer to array/array of pointers disambiguation (score [380998](https://stackoverflow.com/q/859634) in 2014)

#### Question
What is the difference between the following declarations:  

```c
int* arr1[8];
int (*arr2)[8];
int *(arr3[8]);
```

What is the general rule for understanding more complex declarations?  

#### Answer accepted (score 424)
```c
int* arr[8]; // An array of int pointers.
int (*arr)[8]; // A pointer to an array of integers
```

The third one is same as the first.  

The general rule is <a href="http://unixwiz.net/techtips/reading-cdecl.html" rel="noreferrer">operator precedence</a>. It can get even much more complex as function pointers come into the picture.  

#### Answer 2 (score 260)
Use the <a href="http://cdecl.org/" rel="noreferrer">cdecl</a> program, as suggested by K&amp;R.  



```c
$ cdecl
Type `help' or `?' for help
cdecl> explain int* arr1[8];
declare arr1 as array 8 of pointer to int
cdecl> explain int (*arr2)[8]
declare arr2 as pointer to array 8 of int
cdecl> explain int *(arr3[8])
declare arr3 as array 8 of pointer to int
cdecl>
```

It works the other way too.  

```c
cdecl> declare x as pointer to function(void) returning pointer to float
float *(*x)(void )
```

#### Answer 3 (score 124)
I don't know if it has an official name, but I call it the Right-Left Thingy(TM).  

Start at the variable, then go right, and left, and right...and so on.  

```c
int* arr1[8];
```

<em>arr1 is an array of 8 pointers to integers.</em>  

```c
int (*arr2)[8];
```

<em>arr2 is a pointer (the parenthesis block the right-left) to an array of 8 integers.</em>  

```c
int *(arr3[8]);
```

<em>arr3 is an array of 8 pointers to integers.</em>  

This should help you out with complex declarations.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: Calling C/C++ from Python? (score [380797](https://stackoverflow.com/q/145270) in 2017)

#### Question
What would be the quickest way to construct a Python binding to a C or C++ library?  

(I am using Windows if this matters.)  

#### Answer accepted (score 154)
You should have a look at <a href="http://www.boost.org/doc/libs/1_49_0/libs/python/doc/" rel="noreferrer">Boost.Python</a>. Here is the short introduction taken from their website:  

<blockquote>
  <p>The Boost Python Library is a framework for interfacing Python and
  C++. It allows you to quickly and seamlessly expose C++ classes
  functions and objects to Python, and vice-versa, using no special
  tools -- just your C++ compiler. It is designed to wrap C++ interfaces
  non-intrusively, so that you should not have to change the C++ code at
  all in order to wrap it, making Boost.Python ideal for exposing
  3rd-party libraries to Python. The library's use of advanced
  metaprogramming techniques simplifies its syntax for users, so that
  wrapping code takes on the look of a kind of declarative interface
  definition language (IDL).</p>
</blockquote>

#### Answer 2 (score 616)
<a href="http://docs.python.org/2/library/ctypes.html" rel="noreferrer">ctypes</a> is part of the standard library, and therefore is more stable and widely available than <a href="http://www.swig.org/" rel="noreferrer">swig</a>, which always tended to give me <a href="http://groups.google.com/group/comp.lang.python/browse_thread/thread/d94badd9847fe43a?pli=1" rel="noreferrer">problems</a>.  

With ctypes, you need to satisfy any compile time dependency on python, and your binding will work on any python that has ctypes, not just the one it was compiled against.  

Suppose you have a simple C++ example class you want to talk to in a file called foo.cpp:  

```c
#include <iostream>

class Foo{
    public:
        void bar(){
            std::cout << "Hello" << std::endl;
        }
};
```

Since ctypes can only talk to C functions, you need to provide those declaring them as extern "C"  

```c
extern "C" {
    Foo* Foo_new(){ return new Foo(); }
    void Foo_bar(Foo* foo){ foo->bar(); }
}
```

Next you have to compile this to a shared library  

```c
g++ -c -fPIC foo.cpp -o foo.o
g++ -shared -Wl,-soname,libfoo.so -o libfoo.so  foo.o
```

And finally you have to write your python wrapper (e.g. in fooWrapper.py)  

```c
from ctypes import cdll
lib = cdll.LoadLibrary('./libfoo.so')

class Foo(object):
    def __init__(self):
        self.obj = lib.Foo_new()

    def bar(self):
        lib.Foo_bar(self.obj)
```

Once you have that you can call it like  

```c
f = Foo()
f.bar() #and you will see "Hello" on the screen
```

#### Answer 3 (score 51)
The quickest way to do this is using <a href="http://www.swig.org/" rel="noreferrer">SWIG</a>.  

Example from SWIG <a href="http://www.swig.org/tutorial.html" rel="noreferrer">tutorial</a>:  

```c
/* File : example.c */
int fact(int n) {
    if (n <= 1) return 1;
    else return n*fact(n-1);
}
```

Interface file:  

```c
/* example.i */
%module example
%{
/* Put header files here or function declarations like below */
extern int fact(int n);
%}

extern int fact(int n);
```

Building a Python module on Unix:  

```c
swig -python example.i
gcc -fPIC -c example.c example_wrap.c -I/usr/local/include/python2.7
gcc -shared example.o example_wrap.o -o _example.so
```

Usage:  

```c
>>> import example
>>> example.fact(5)
120
```

Note that you have to have python-dev. Also in some systems python header files will be in /usr/include/python2.7 based on the way you have installed it.  

From the tutorial:  

<blockquote>
  SWIG is a fairly complete C++ compiler with support for nearly every language feature. This includes preprocessing, pointers, classes, inheritance, and even C++ templates. SWIG can also be used to package structures and classes into proxy classes in the target language — exposing the underlying functionality in a very natural manner.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: Improve INSERT-per-second performance of SQLite? (score [379997](https://stackoverflow.com/q/1711631) in 2019)

#### Question
Optimizing SQLite is tricky. Bulk-insert performance of a C application can vary from 85 inserts per second to over 96,000 inserts per second!  

<strong>Background:</strong> We are using SQLite as part of a desktop application. We have large amounts of configuration data stored in XML files that are parsed and loaded into an SQLite database for further processing when the application is initialized. SQLite is ideal for this situation because it's fast, it requires no specialized configuration, and the database is stored on disk as a single file.  

<strong>Rationale:</strong> <em>Initially I was disappointed with the performance I was seeing.</em> It turns-out that the performance of SQLite can vary significantly (both for bulk-inserts and selects) depending on how the database is configured and how you're using the API. It was not a trivial matter to figure out what all of the options and techniques were, so I thought it prudent to create this community wiki entry to share the results with Stack&nbsp;Overflow readers in order to save others the trouble of the same investigations.  

<strong>The Experiment:</strong> Rather than simply talking about performance tips in the general sense (i.e. <em>"Use a transaction!"</em>), I thought it best to write some C code and <em>actually measure</em> the impact of various options. We're going to start with some simple data:  

<ul>
<li>A 28 MB TAB-delimited text file (approximately 865,000 records) of the <a href="http://www.toronto.ca/open/datasets/ttc-routes" rel="nofollow noreferrer">complete transit schedule for the city of Toronto</a></li>
<li>My test machine is a 3.60 GHz P4 running Windows XP.</li>
<li>The code is compiled with <a href="http://en.wikipedia.org/wiki/Visual_C%2B%2B#32-bit_versions" rel="nofollow noreferrer">Visual C++</a> 2005 as "Release" with "Full Optimization" (/Ox) and Favor Fast Code (/Ot).</li>
<li>I'm using the SQLite "Amalgamation", compiled directly into my test application. The SQLite version I happen to have is a bit older (3.6.7), but I suspect these results will be comparable to the latest release (please leave a comment if you think otherwise).</li>
</ul>

<em>Let's write some code!</em>  

<strong>The Code:</strong> A simple C program that reads the text file line-by-line, splits the string into values and then inserts the data into an SQLite database. In this "baseline" version of the code, the database is created, but we won't actually insert data:  

```c
/*************************************************************
    Baseline code to experiment with SQLite performance.

    Input data is a 28 MB TAB-delimited text file of the
    complete Toronto Transit System schedule/route info
    from http://www.toronto.ca/open/datasets/ttc-routes/

**************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include "sqlite3.h"

#define INPUTDATA "C:\\TTC_schedule_scheduleitem_10-27-2009.txt"
#define DATABASE "c:\\TTC_schedule_scheduleitem_10-27-2009.sqlite"
#define TABLE "CREATE TABLE IF NOT EXISTS TTC (id INTEGER PRIMARY KEY, Route_ID TEXT, Branch_Code TEXT, Version INTEGER, Stop INTEGER, Vehicle_Index INTEGER, Day Integer, Time TEXT)"
#define BUFFER_SIZE 256

int main(int argc, char **argv) {

    sqlite3 * db;
    sqlite3_stmt * stmt;
    char * sErrMsg = 0;
    char * tail = 0;
    int nRetCode;
    int n = 0;

    clock_t cStartClock;

    FILE * pFile;
    char sInputBuf [BUFFER_SIZE] = "\0";

    char * sRT = 0;  /* Route */
    char * sBR = 0;  /* Branch */
    char * sVR = 0;  /* Version */
    char * sST = 0;  /* Stop Number */
    char * sVI = 0;  /* Vehicle */
    char * sDT = 0;  /* Date */
    char * sTM = 0;  /* Time */

    char sSQL [BUFFER_SIZE] = "\0";

    /*********************************************/
    /* Open the Database and create the Schema */
    sqlite3_open(DATABASE, &db);
    sqlite3_exec(db, TABLE, NULL, NULL, &sErrMsg);

    /*********************************************/
    /* Open input file and import into Database*/
    cStartClock = clock();

    pFile = fopen (INPUTDATA,"r");
    while (!feof(pFile)) {

        fgets (sInputBuf, BUFFER_SIZE, pFile);

        sRT = strtok (sInputBuf, "\t");     /* Get Route */
        sBR = strtok (NULL, "\t");            /* Get Branch */
        sVR = strtok (NULL, "\t");            /* Get Version */
        sST = strtok (NULL, "\t");            /* Get Stop Number */
        sVI = strtok (NULL, "\t");            /* Get Vehicle */
        sDT = strtok (NULL, "\t");            /* Get Date */
        sTM = strtok (NULL, "\t");            /* Get Time */

        /* ACTUAL INSERT WILL GO HERE */

        n++;
    }
    fclose (pFile);

    printf("Imported %d records in %4.2f seconds\n", n, (clock() - cStartClock) / (double)CLOCKS_PER_SEC);

    sqlite3_close(db);
    return 0;
}
```

<hr>

<h5>The "Control"</h2>

Running the code as-is doesn't actually perform any database operations, but it will give us an idea of how fast the raw C file I/O and string processing operations are.  

<blockquote>
  <p>Imported 864913 records in 0.94
  seconds</p>
</blockquote>

Great! We can do 920,000 inserts per second, provided we don't actually do any inserts :-)  

<hr>

<h5>The "Worst-Case-Scenario"</h2>

We're going to generate the SQL string using the values read from the file and invoke that SQL operation using sqlite3_exec:  

```c
sprintf(sSQL, "INSERT INTO TTC VALUES (NULL, '%s', '%s', '%s', '%s', '%s', '%s', '%s')", sRT, sBR, sVR, sST, sVI, sDT, sTM);
sqlite3_exec(db, sSQL, NULL, NULL, &sErrMsg);
```

This is going to be slow because the SQL will be compiled into VDBE code for every insert and every insert will happen in its own transaction. <em>How slow?</em>  

<blockquote>
  <p>Imported 864913 records in 9933.61
  seconds</p>
</blockquote>

Yikes! 2 hours and 45 minutes! That's only <strong>85 inserts per second.</strong>  

<h5>Using a Transaction</h2>

By default, SQLite will evaluate every INSERT / UPDATE statement within a unique transaction. If performing a large number of inserts, it's advisable to wrap your operation in a transaction:  

```c
sqlite3_exec(db, "BEGIN TRANSACTION", NULL, NULL, &sErrMsg);

pFile = fopen (INPUTDATA,"r");
while (!feof(pFile)) {

    ...

}
fclose (pFile);

sqlite3_exec(db, "END TRANSACTION", NULL, NULL, &sErrMsg);
```

<blockquote>
  <p>Imported 864913 records in 38.03
  seconds</p>
</blockquote>

That's better. Simply wrapping all of our inserts in a single transaction improved our performance to <strong>23,000 inserts per second.</strong>  

<h5>Using a Prepared Statement</h2>

Using a transaction was a huge improvement, but recompiling the SQL statement for every insert doesn't make sense if we using the same SQL over-and-over. Let's use `sqlite3_prepare_v2` to compile our SQL statement once and then bind our parameters to that statement using `sqlite3_bind_text`:  

```c
/* Open input file and import into the database */
cStartClock = clock();

sprintf(sSQL, "INSERT INTO TTC VALUES (NULL, @RT, @BR, @VR, @ST, @VI, @DT, @TM)");
sqlite3_prepare_v2(db,  sSQL, BUFFER_SIZE, &stmt, &tail);

sqlite3_exec(db, "BEGIN TRANSACTION", NULL, NULL, &sErrMsg);

pFile = fopen (INPUTDATA,"r");
while (!feof(pFile)) {

    fgets (sInputBuf, BUFFER_SIZE, pFile);

    sRT = strtok (sInputBuf, "\t");   /* Get Route */
    sBR = strtok (NULL, "\t");        /* Get Branch */
    sVR = strtok (NULL, "\t");        /* Get Version */
    sST = strtok (NULL, "\t");        /* Get Stop Number */
    sVI = strtok (NULL, "\t");        /* Get Vehicle */
    sDT = strtok (NULL, "\t");        /* Get Date */
    sTM = strtok (NULL, "\t");        /* Get Time */

    sqlite3_bind_text(stmt, 1, sRT, -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 2, sBR, -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 3, sVR, -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 4, sST, -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 5, sVI, -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 6, sDT, -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 7, sTM, -1, SQLITE_TRANSIENT);

    sqlite3_step(stmt);

    sqlite3_clear_bindings(stmt);
    sqlite3_reset(stmt);

    n++;
}
fclose (pFile);

sqlite3_exec(db, "END TRANSACTION", NULL, NULL, &sErrMsg);

printf("Imported %d records in %4.2f seconds\n", n, (clock() - cStartClock) / (double)CLOCKS_PER_SEC);

sqlite3_finalize(stmt);
sqlite3_close(db);

return 0;
```

<blockquote>
  <p>Imported 864913 records in 16.27
  seconds</p>
</blockquote>

Nice! There's a little bit more code (don't forget to call `sqlite3_clear_bindings` and `sqlite3_reset`), but we've more than doubled our performance to <strong>53,000 inserts per second.</strong>  

<h5>PRAGMA synchronous = OFF</h2>

By default, SQLite will pause after issuing a OS-level write command. This guarantees that the data is written to the disk. By setting `synchronous = OFF`, we are instructing SQLite to simply hand-off the data to the OS for writing and then continue. There's a chance that the database file may become corrupted if the computer suffers a catastrophic crash (or power failure) before the data is written to the platter:  

```c
/* Open the database and create the schema */
sqlite3_open(DATABASE, &db);
sqlite3_exec(db, TABLE, NULL, NULL, &sErrMsg);
sqlite3_exec(db, "PRAGMA synchronous = OFF", NULL, NULL, &sErrMsg);
```

<blockquote>
  <p>Imported 864913 records in 12.41
  seconds</p>
</blockquote>

The improvements are now smaller, but we're up to <strong>69,600 inserts per second.</strong>  

<h5>PRAGMA journal_mode = MEMORY</h2>

Consider storing the rollback journal in memory by evaluating `PRAGMA journal_mode = MEMORY`. Your transaction will be faster, but if you lose power or your program crashes during a transaction you database could be left in a corrupt state with a partially-completed transaction:  

```c
/* Open the database and create the schema */
sqlite3_open(DATABASE, &db);
sqlite3_exec(db, TABLE, NULL, NULL, &sErrMsg);
sqlite3_exec(db, "PRAGMA journal_mode = MEMORY", NULL, NULL, &sErrMsg);
```

<blockquote>
  <p>Imported 864913 records in 13.50
  seconds</p>
</blockquote>

A little slower than the previous optimization at <strong>64,000 inserts per second.</strong>  

<h5>PRAGMA synchronous = OFF <em>and</em> PRAGMA journal_mode = MEMORY</h2>

Let's combine the previous two optimizations. It's a little more risky (in case of a crash), but we're just importing data (not running a bank):  

```c
/* Open the database and create the schema */
sqlite3_open(DATABASE, &db);
sqlite3_exec(db, TABLE, NULL, NULL, &sErrMsg);
sqlite3_exec(db, "PRAGMA synchronous = OFF", NULL, NULL, &sErrMsg);
sqlite3_exec(db, "PRAGMA journal_mode = MEMORY", NULL, NULL, &sErrMsg);
```

<blockquote>
  <p>Imported 864913 records in 12.00
  seconds</p>
</blockquote>

Fantastic! We're able to do <strong>72,000 inserts per second.</strong>  

<h5>Using an In-Memory Database</h2>

Just for kicks, let's build upon all of the previous optimizations and redefine the database filename so we're working entirely in RAM:  

```c
#define DATABASE ":memory:"
```

<blockquote>
  <p>Imported 864913 records in 10.94
  seconds</p>
</blockquote>

It's not super-practical to store our database in RAM, but it's impressive that we can perform <strong>79,000 inserts per second.</strong>  

<h5>Refactoring C Code</h2>

Although not specifically an SQLite improvement, I don't like the extra `char*` assignment operations in the `while` loop. Let's quickly refactor that code to pass the output of `strtok()` directly into `sqlite3_bind_text()`, and let the compiler try to speed things up for us:  

```c
pFile = fopen (INPUTDATA,"r");
while (!feof(pFile)) {

    fgets (sInputBuf, BUFFER_SIZE, pFile);

    sqlite3_bind_text(stmt, 1, strtok (sInputBuf, "\t"), -1, SQLITE_TRANSIENT); /* Get Route */
    sqlite3_bind_text(stmt, 2, strtok (NULL, "\t"), -1, SQLITE_TRANSIENT);    /* Get Branch */
    sqlite3_bind_text(stmt, 3, strtok (NULL, "\t"), -1, SQLITE_TRANSIENT);    /* Get Version */
    sqlite3_bind_text(stmt, 4, strtok (NULL, "\t"), -1, SQLITE_TRANSIENT);    /* Get Stop Number */
    sqlite3_bind_text(stmt, 5, strtok (NULL, "\t"), -1, SQLITE_TRANSIENT);    /* Get Vehicle */
    sqlite3_bind_text(stmt, 6, strtok (NULL, "\t"), -1, SQLITE_TRANSIENT);    /* Get Date */
    sqlite3_bind_text(stmt, 7, strtok (NULL, "\t"), -1, SQLITE_TRANSIENT);    /* Get Time */

    sqlite3_step(stmt);        /* Execute the SQL Statement */
    sqlite3_clear_bindings(stmt);    /* Clear bindings */
    sqlite3_reset(stmt);        /* Reset VDBE */

    n++;
}
fclose (pFile);
```

<strong>Note: We are back to using a real database file. In-memory databases are fast, but not necessarily practical</strong>  

<blockquote>
  <p>Imported 864913 records in 8.94
  seconds</p>
</blockquote>

A slight refactoring to the string processing code used in our parameter binding has allowed us to perform <strong>96,700 inserts per second.</strong> I think it's safe to say that this is <em>plenty fast</em>. As we start to tweak other variables (i.e. page size, index creation, etc.) this will be our benchmark.  

<hr>

<h5>Summary (so far)</h2>

<em>I hope you're still with me!</em> The reason we started down this road is that bulk-insert performance varies so wildly with SQLite, and it's not always obvious what changes need to be made to speed-up our operation. Using the same compiler (and compiler options), the same version of SQLite and the same data we've optimized our code and our usage of SQLite to go <strong>from a worst-case scenario of 85 inserts per second to over 96,000 inserts per second!</strong>  

<hr>

<h5>CREATE INDEX then INSERT vs. INSERT then CREATE INDEX</h2>

Before we start measuring `SELECT` performance, we know that we'll be creating indices. It's been suggested in one of the answers below that when doing bulk inserts, it is faster to create the index after the data has been inserted (as opposed to creating the index first then inserting the data). Let's try:  

<strong>Create Index then Insert Data</strong>  

```c
sqlite3_exec(db, "CREATE  INDEX 'TTC_Stop_Index' ON 'TTC' ('Stop')", NULL, NULL, &sErrMsg);
sqlite3_exec(db, "BEGIN TRANSACTION", NULL, NULL, &sErrMsg);
...
```

<blockquote>
  <p>Imported 864913 records in 18.13
  seconds</p>
</blockquote>

<strong>Insert Data then Create Index</strong>  

```c
...
sqlite3_exec(db, "END TRANSACTION", NULL, NULL, &sErrMsg);
sqlite3_exec(db, "CREATE  INDEX 'TTC_Stop_Index' ON 'TTC' ('Stop')", NULL, NULL, &sErrMsg);
```

<blockquote>
  <p>Imported 864913 records in 13.66
  seconds</p>
</blockquote>

As expected, bulk-inserts are slower if one column is indexed, but it does make a difference if the index is created after the data is inserted. Our no-index baseline is 96,000 inserts per second. <strong>Creating the index first then inserting data gives us 47,700 inserts per second, whereas inserting the data first then creating the index gives us 63,300 inserts per second.</strong>  

<hr>

I'd gladly take suggestions for other scenarios to try... And will be compiling similar data for SELECT queries soon.  

#### Answer accepted (score 746)
Several tips:  

<ol>
<li>Put inserts/updates in a transaction.</li>
<li>For older versions of SQLite - Consider a less paranoid journal mode (`pragma journal_mode`). There is `NORMAL`, and then there is `OFF`, which can significantly increase insert speed if you're not too worried about the database possibly getting corrupted if the OS crashes. If your application crashes the data should be fine. Note that in newer versions, the `OFF/MEMORY` settings are not safe for application level crashes.</li>
<li>Playing with page sizes makes a difference as well (`PRAGMA page_size`). Having larger page sizes can make reads and writes go a bit faster as larger pages are held in memory. Note that more memory will be used for your database.</li>
<li>If you have indices, consider calling `CREATE INDEX` after doing all your inserts. This is significantly faster than creating the index and then doing your inserts.</li>
<li>You have to be quite careful if you have concurrent access to SQLite, as the whole database is locked when writes are done, and although multiple readers are possible, writes will be locked out. This has been improved somewhat with the addition of a WAL in newer SQLite versions.</li>
<li>Take advantage of saving space...smaller databases go faster. For instance, if you have key value pairs, try making the key an `INTEGER PRIMARY KEY` if possible, which will replace the implied unique row number column in the table.</li>
<li>If you are using multiple threads, you can try using the <a href="http://sqlite.org/c3ref/enable_shared_cache.html" rel="noreferrer">shared page cache</a>, which will allow loaded pages to be shared between threads, which can avoid expensive I/O calls.</li>
<li><a href="https://stackoverflow.com/q/5431941/6850771">Don't use `!feof(file)`!</a></li>
</ol>

I've also asked similar questions <a href="https://stackoverflow.com/questions/784173/what-are-the-performance-characteristics-of-sqlite-with-very-large-database-files">here</a> and <a href="https://stackoverflow.com/questions/768708/are-there-known-issues-with-using-sqlite-and-file-locking-on-different-platforms">here</a>.  

#### Answer 2 (score 129)
Try using `SQLITE_STATIC` instead of `SQLITE_TRANSIENT` for those inserts.   

`SQLITE_TRANSIENT` will cause SQLite to copy the string data before returning.   

`SQLITE_STATIC` tells it that the memory address you gave it will be valid until the query has been performed (which in this loop is always the case). This will save you several allocate, copy and deallocate operations per loop. Possibly a large improvement.  

#### Answer 3 (score 97)
<strong>Avoid <a href="https://www.sqlite.org/c3ref/clear_bindings.html" rel="nofollow noreferrer">`sqlite3_clear_bindings(stmt)`</a>.</strong>  

The code in the test sets the bindings every time through which should be enough.  

The <a href="https://www.sqlite.org/cintro.html" rel="nofollow noreferrer">C API intro</a> from the SQLite docs says:  

<blockquote>
  <p>Prior to calling <a href="https://www.sqlite.org/c3ref/step.html" rel="nofollow noreferrer">sqlite3_step()</a> for the first time or immediately
  after <a href="https://www.sqlite.org/c3ref/reset.html" rel="nofollow noreferrer">sqlite3_reset()</a>, the application can invoke the
  <a href="https://www.sqlite.org/c3ref/bind_blob.html" rel="nofollow noreferrer">sqlite3_bind()</a> interfaces to attach values to the parameters. Each
  call to <a href="https://www.sqlite.org/c3ref/bind_blob.html" rel="nofollow noreferrer">sqlite3_bind()</a> overrides prior bindings on the same parameter</p>
</blockquote>

There is nothing in the docs for <a href="https://www.sqlite.org/c3ref/clear_bindings.html" rel="nofollow noreferrer">`sqlite3_clear_bindings`</a> saying you must call it in addition to simply setting the bindings.  

More detail: <a href="http://www.hoogli.com/blogs/micro/index.html#Avoid_sqlite3_clear_bindings%28%29" rel="nofollow noreferrer">Avoid_sqlite3_clear_bindings()</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: strdup() - what does it do in C? (score [379908](https://stackoverflow.com/q/252782) in 2013)

#### Question
What is the purpose of the `strdup()` function in C?  

#### Answer accepted (score 356)
Exactly what it sounds like, assuming you're used to the abbreviated way in which C and UNIX assigns words, it <strong><em>duplicates strings</em></strong> :-)  

Keeping in mind it's actually not part of the ISO C standard itself<sup>(a)</sup> (it's a POSIX thing), it's effectively doing the same as the following code:  

```c
char *strdup(const char *src) {
    char *dst = malloc(strlen (src) + 1);  // Space for length plus nul
    if (dst == NULL) return NULL;          // No memory
    strcpy(dst, src);                      // Copy the characters
    return dst;                            // Return the new string
}
```

In other words:  

<ol>
<li><p>It tries to allocate enough memory to hold the old string (plus a '\0' character to mark the end of the string).</p></li>
<li><p>If the allocation failed, it sets `errno` to `ENOMEM` and returns `NULL` immediately. Setting of `errno` to `ENOMEM` is something `malloc` does in POSIX so we don't need to explicitly do it in our `strdup`. If you're <em>not</em> POSIX compliant, ISO C doesn't actually mandate the existence of `ENOMEM` so I haven't included that here<sup>(b)</sup>.</p></li>
<li><p>Otherwise the allocation worked so we copy the old string to the new string<sup>(c)</sup> and return the new address (which the caller is responsible for freeing at some point).</p></li>
</ol>

Keep in mind that's the conceptual definition. Any library writer worth their salary may have provided heavily optimised code targeting the particular processor being used.  

<hr>

<sup>(a)</sup> However, functions starting with `str` and a lower case letter are reserved by the standard for future directions. From `C11 7.1.3 Reserved identifiers`:  

<blockquote>
  Each header declares or defines all identifiers listed in its associated sub-clause, and *optionally declares or defines identifiers listed in its associated future library directions sub-clause.**  
</blockquote>

The future directions for `string.h` can be found in `C11 7.31.13 String handling &lt;string.h&gt;`:  

<blockquote>
  Function names that begin with `str`, `mem`, or `wcs` and a lowercase letter may be added to the declarations in the `&lt;string.h&gt;` header.  
</blockquote>

So you should probably call it something else if you want to be safe.  

<hr>

<sup>(b)</sup> The change would basically be replacing `if (d == NULL) return NULL;` with:  

```c
if (d == NULL) {
    errno = ENOMEM;
    return NULL;
}
```

<hr>

<sup>(c)</sup> Note that I use `strcpy` for that since that clearly shows the intent. In some implementations, it may be faster (since you already know the length) to use `memcpy`, as they may allow for transferring the data in larger chunks, or in parallel. Or it may not :-) Optimisation mantra #1: "measure, don't guess".  

In any case, should you decide to go that route, you would do something like:  

```c
char *strdup(const char *src) {
    size_t len = strlen(src) + 1;       // String plus '\0'
    char *dst = malloc(len);            // Allocate space
    if (dst == NULL) return NULL;       // No memory
    memcpy (dst, src, len);             // Copy the block
    return dst;                         // Return the new string
}
```

#### Answer 2 (score 85)
```c
char * strdup(const char * s)
{
  size_t len = 1+strlen(s);
  char *p = malloc(len);

  return p ? memcpy(p, s, len) : NULL;
}
```

Maybe the code is a bit faster than with `strcpy()` as the `\0` char doesn't need to be searched again (It already was with `strlen()`).  

#### Answer 3 (score 51)
No point repeating the other answers, but please note that `strdup()` can do anything it wants from a C perspective, since it is not part of any C standard. It is however defined by POSIX.1-2001.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: C: printf a float value (score [379409](https://stackoverflow.com/q/8345581) in 2012)

#### Question
I want to print a float value which has 2 integer digits and 6 decimal digits after the comma. If I just use `printf("%f", myFloat)` I'm getting a truncated value.  

I don't know if this always happens in C, or it's just because I'm using C for microcontrollers (CCS to be exact), but at the reference it tells that `%f` get just that: a truncated float.  

If my float is `44.556677`, I'm printing out `"44.55"`, only the first two decimal digits.  

So the question is... how can I print my 6 digits (and just the six of them, just in case I'm having zeros after that or something)?  

#### Answer accepted (score 113)
You can do it like this:  

```c
printf("%.6f", myFloat);
```

6 represents the number of digits after the dot.  

P.S. Thanks <strong>@caf</strong> for correcting me.  

#### Answer 2 (score 15)
`printf("%9.6f", myFloat)` specifies a format with 9 total characters: 2 digits before the dot, the dot itself, and six digits after the dot.  

#### Answer 3 (score 6)
```c
printf("%.<number>f", myFloat) //where <number> - digit after comma
```

<a href="http://www.cplusplus.com/reference/clibrary/cstdio/printf/" rel="nofollow noreferrer">http://www.cplusplus.com/reference/clibrary/cstdio/printf/</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Unit Testing C Code (score [375093](https://stackoverflow.com/q/65820) in 2019)

#### Question
I worked on an embedded system this summer written in straight C.  It was an existing project that the company I work for had taken over.  I have become quite accustomed to writing unit tests in Java using JUnit but was at a loss as to the best way to write unit tests for existing code (which needed refactoring) as well as new code added to the system.  

Are there any projects out there that make unit testing plain C code as easy as unit testing Java code with JUnit?  Any insight that would apply specifically to embedded development (cross-compiling to arm-linux platform) would be greatly appreciated.  

#### Answer accepted (score 479)
One unit testing framework in C is <a href="https://libcheck.github.io/check/" rel="noreferrer">Check</a>; a list of unit testing frameworks in C can be found <a href="http://check.sourceforge.net/doc/check_html/check_2.html#SEC3" rel="noreferrer">here</a> and is reproduced below.  Depending on how many standard library functions your runtime has, you may or not be able to use one of those.  

<blockquote>
  <h5>AceUnit</h3>
  
  AceUnit (Advanced C and Embedded Unit) bills itself as a comfortable C code unit test framework. It tries to mimick JUnit 4.x and includes reflection-like capabilities. AceUnit can be used in resource constraint environments, e.g. embedded software development, and importantly it runs fine in environments where you cannot include a single standard header file and cannot invoke a single standard C function from the ANSI / ISO C libraries. It also has a Windows port. It does not use forks to trap signals, although the authors have expressed interest in adding such a feature. See the <a href="http://aceunit.sourceforge.net/" rel="noreferrer">AceUnit homepage</a>.  
  
  <h5>GNU Autounit</h3>
  
  Much along the same lines as Check, including forking to run unit tests in a separate address space (in fact, the original author of Check borrowed the idea from GNU Autounit). GNU Autounit uses GLib extensively, which means that linking and such need special options, but this may not be a big problem to you, especially if you are already using GTK or GLib. See the <a href="http://autounit.tigris.org/" rel="noreferrer">GNU Autounit homepage</a>.  
  
  <h5>cUnit</h3>
  
  Also uses GLib, but does not fork to protect the address space of unit tests.  
  
  <h5>CUnit</h3>
  
  Standard C, with plans for a Win32 GUI implementation. Does not currently fork or otherwise protect the address space of unit tests. In early development. See the <a href="http://cunit.sourceforge.net/" rel="noreferrer">CUnit homepage</a>.  
  
  <h5>CuTest</h3>
  
  A simple framework with just one .c and one .h file that you drop into your source tree. See the <a href="http://cutest.sourceforge.net/" rel="noreferrer">CuTest homepage</a>.  
  
  <h5>CppUnit</h3>
  
  The premier unit testing framework for C++; you can also use it to test C code. It is stable, actively developed, and has a GUI interface. The primary reasons not to use CppUnit for C are first that it is quite big, and second you have to write your tests in C++, which means you need a C++ compiler. If these don’t sound like concerns, it is definitely worth considering, along with other C++ unit testing frameworks. See the <a href="http://cppunit.sourceforge.net/doc/cvs/index.html" rel="noreferrer">CppUnit homepage</a>.  
  
  <h5>embUnit</h3>
  
  embUnit (Embedded Unit) is another unit test framework for embedded systems. This one appears to be superseded by AceUnit. <a href="http://sourceforge.net/projects/embunit/" rel="noreferrer">Embedded Unit homepage</a>.  
  
  <h5>MinUnit</h3>
  
  A minimal set of macros and that’s it! The point is to show how easy it is to unit test your code. See the <a href="http://www.jera.com/techinfo/jtns/jtn002.html" rel="noreferrer">MinUnit homepage</a>.  
  
  <h5>CUnit for Mr. Ando</h3>
  
  A CUnit implementation that is fairly new, and apparently still in early development. See the <a href="http://park.ruru.ne.jp/ando/work/CUnitForAndo/html/" rel="noreferrer">CUnit for Mr. Ando homepage</a>.  
  
  <em>This list was last updated in March 2008.</em>  
</blockquote>

<h5>More frameworks:</h2>

<h5>CMocka</h3>

CMocka is a test framework for C with support for mock objects. It's easy to use and setup.  

See <a href="https://cmocka.org/" rel="noreferrer">the CMocka homepage</a>.  

<h5>Criterion</h3>

Criterion is a cross-platform C unit testing framework supporting automatic test registration, parameterized tests, theories, and that can output to multiple formats, including TAP and JUnit XML. Each test is run in its own process, so signals and crashes can be reported or tested if needed.  

See the <a href="https://github.com/Snaipe/Criterion" rel="noreferrer">Criterion homepage</a> for more information.  

<h5>HWUT</h3>

HWUT is a general Unit Test tool with great support for C. It can help to create Makefiles, generate massive test cases coded in minimal 'iteration tables', walk along state machines, generate C-stubs and more. The general approach is pretty unique: Verdicts are based on 'good stdout/bad stdout'. The comparison function, though, is flexible. Thus, any type of script may be used for checking. It may be applied to any language that can produce standard output.  

See <a href="http://hwut.sourceforge.net/" rel="noreferrer">the HWUT homepage</a>.  

<h5>CGreen</h3>

A modern, portable, cross-language unit testing and mocking framework for C and C++. It offers an optional BDD notation, a mocking library, the ability to run it in a single process (to make debugging easier). A test runner which discover automatically the test functions is available. But you can create your own programmatically.  

All those features (and more) are explained in <a href="https://cgreen-devs.github.io/" rel="noreferrer">the CGreen manual</a>.  

Wikipedia gives a detailed list of C unit testing frameworks under <a href="https://en.wikipedia.org/wiki/List_of_unit_testing_frameworks#C" rel="noreferrer">List of unit testing frameworks: C</a>  



#### Answer 2 (score 158)
Personally I like the <a href="http://code.google.com/p/googletest/" rel="noreferrer">Google Test framework</a>.    

The real difficulty in testing C code is breaking the dependencies on external modules so you can isolate code in units.  This can be especially problematic when you are trying to get tests around legacy code.  In this case I often find myself using the linker to use stubs functions in tests.  

This is what people are referring to when they talk about "<strong>seams</strong>".  In C your only option really is to use the pre-processor or the linker to mock out your dependencies.  

A typical test suite in one of my C projects might look like this:  

```c
#include "myimplementationfile.c"
#include <gtest/gtest.h>

// Mock out external dependency on mylogger.o
void Logger_log(...){}

TEST(FactorialTest, Zero) {
    EXPECT_EQ(1, Factorial(0));
}
```

<strong>Note that you are actually including the C file and not the header file</strong>.  This gives the advantage of access to all the static data members.  Here I mock out my logger (which might be in logger.o and give an empty implementation.  This means that the test file compiles and links independently from the rest of the code base and executes in isolation.  

As for cross-compiling the code, for this to work you need good facilities on the target.  I have done this with googletest cross compiled to Linux on a PowerPC architecture.    This makes sense because there you have a full shell and os to gather your results.  For less rich environments (which I classify as anything without a full OS) you should just build and run on the host.  You should do this anyway so you can run the tests automatically as part of the build.  

I find testing C++ code is generally much easier due to the fact that OO code is in general much less coupled than procedural (of course this depends a lot on coding style).  Also in C++ you can use tricks like dependency injection and method overriding to get seams into code that is otherwise encapsulated.  

Michael Feathers has an <a href="https://rads.stackoverflow.com/amzn/click/com/0131177052" rel="noreferrer" rel="nofollow noreferrer">excellent book about testing legacy code</a>.  In one chapter he covers techniques for dealing with non-OO code which I highly recommend.  

<strong>Edit</strong>: I've written a <a href="http://meekrosoft.wordpress.com/2009/11/09/unit-testing-c-code-with-the-googletest-framework/" rel="noreferrer">blog post</a> about unit testing procedural code, with <a href="http://github.com/meekrosoft/helloc" rel="noreferrer">source available on GitHub</a>.  

<strong>Edit</strong>: There is a <a href="http://pragprog.com/titles/jgade/test-driven-development-for-embedded-c" rel="noreferrer">new book coming out from the Pragmatic Programmers</a> that specifically addresses unit testing C code which <a href="http://meekrosoft.wordpress.com/2011/03/25/book-review-test-driven-development-for-embedded-c-beta/" rel="noreferrer">I highly recommend</a>.  

#### Answer 3 (score 130)
<p><a href="http://www.jera.com/techinfo/jtns/jtn002.html" rel="noreferrer">Minunit</a> is an incredibly simple unit testing framework.
I'm using it to unit test c microcontroller code for avr.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Typedef function pointer? (score [373780](https://stackoverflow.com/q/4295432) in 2019)

#### Question
I'm learning how to dynamically load DLL's but what I don't understand is this line  

```c
typedef void (*FunctionFunc)();
```

I have a few questions. If someone is able to answer them I would be grateful.  

<ol>
<li>Why is `typedef` used?</li>
<li>The syntax looks odd; after `void` should there not be a function name or something? It looks like an anonymous function.</li>
<li>Is a function pointer created to store the memory address of a function?</li>
</ol>

So I'm confused at the moment; can you clarify things for me?  

#### Answer accepted (score 432)
<p>`typedef` is a language construct that associates a name to a type.<br/>
You use it the same way you would use the original type, for instance</p>

```c
  typedef int myinteger;
  typedef char *mystring;
  typedef void (*myfunc)();
```

using them like  

```c
  myinteger i;   // is equivalent to    int i;
  mystring s;    // is the same as      char *s;
  myfunc f;      // compile equally as  void (*f)();
```

As you can see, you could just replace the <em>typedefed</em> name with its definition given above.<br/>  

The difficulty lies in the pointer to functions syntax and readability in C and C++, and the `typedef` can improve the readability of such declarations. However, the syntax is appropriate, since functions - unlike other simpler types - may have a return value and parameters, thus the sometimes lengthy and complex declaration of a pointer to function.  

The readability may start to be really tricky with pointers to functions arrays, and some other even more indirect flavors.  

To answer your three questions  

<ul>
<li><p><strong>Why is typedef used?</strong>
To ease the reading of the code - especially for pointers to functions, or structure names. </p></li>
<li><p><strong>The syntax looks odd (in the pointer to function declaration)</strong>
That syntax is not obvious to read, at least when beginning. Using a `typedef` declaration instead eases the reading</p></li>
<li><p><strong>Is a function pointer created to store the memory address of a function?</strong>
Yes, a function pointer stores the address of a function. This has nothing to do with the `typedef` construct which only ease the writing/reading of a program ; the compiler just expands the typedef definition before compiling the actual code.</p></li>
</ul>

Example:  

```c
typedef int (*t_somefunc)(int,int);

int product(int u, int v) {
  return u*v;
}

t_somefunc afunc = &product;
...
int x2 = (*afunc)(123, 456); // call product() to calculate 123*456
```

#### Answer 2 (score 178)
<ol>
<li><p>`typedef` is used to alias types; in this case you're aliasing `FunctionFunc` to `void(*)()`.</p></li>
<li><p>Indeed the syntax does look odd, have a look at this:</p>

```c
typedef   void      (*FunctionFunc)  ( );
//         ^                ^         ^
//     return type      type name  arguments
```</li>
<li><p>No, this simply tells the compiler that the `FunctionFunc` type will be a function pointer, it doesn't <em>define</em> one, like this:</p>

```c
FunctionFunc x;
void doSomething() { printf("Hello there\n"); }
x = &doSomething;

x(); //prints "Hello there"
```</li>
</ol>

#### Answer 3 (score 31)
Without the `typedef` word, in C++ the declaration would declare a variable `FunctionFunc` of type pointer to function of no arguments, returning `void`.  

With the `typedef` it instead defines `FunctionFunc` as a name for that type.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: How to copy a char array in C? (score [372836](https://stackoverflow.com/q/16645583) in 2017)

#### Question
In C, I have two char arrays:  

```c
char array1[18] = "abcdefg";
char array2[18];
```

How to copy the value of `array1` to `array2` ? Can I just do this: `array2 = array1`?  

#### Answer accepted (score 77)
You can't directly do `array2 = array1`, because in this case you would manipulate the addresses (`char *`) of the arrays and not their values.  

For this kind of situation, it is recommended to use <a href="http://www.cplusplus.com/reference/cstring/strncpy/?kw=strncpy" rel="noreferrer">`strncpy`</a> to avoid a <a href="http://en.wikipedia.org/wiki/Buffer_overflow" rel="noreferrer">buffer overflow</a>, especially if `array1` is filled from user input (keyboard, network, etc.). Like so:  

```c
// Will copy 18 characters from array1 to array2
strncpy(array2, array1, 18);
```

As @Prof. Falken mentioned in a comment, `strncpy` <a href="http://blogs.msdn.com/b/michael_howard/archive/2004/11/02/251296.aspx" rel="noreferrer">can be evil</a>. Make sure your target buffer is big enough to contain the source buffer (including the `\0` at the end of the string).  

#### Answer 2 (score 26)
<p>If your arrays are not string arrays, use:
`memcpy(array2, array1, sizeof(array2));`</p>

#### Answer 3 (score 24)
If you want to guard against non-terminated strings, which can cause all sorts of problems, copy your string like this:  

```c
char array1[18] = {"abcdefg"};
char array2[18];

size_t destination_size = sizeof (array2);

strncpy(array2, array1, destination_size);
array2[destination_size - 1] = '\0';
```

That last line is actually important, because `strncpy()` does not always <a href="https://www.securecoding.cert.org/confluence/display/seccode/STR32-C.+Null-terminate+byte+strings+as+required" rel="noreferrer">null terminate</a> strings. (If the destination buffer is too small to contain the whole source string, sntrcpy() will not null terminate the destination string.)  

The manpage for strncpy() even states <em>"Warning: If there is no null byte among the first n bytes of src, the string placed in dest will not be null-terminated."</em>  

The reason strncpy() behaves this somewhat odd way, is because it was not actually originally intended as a safe way to copy strings.  

Another way is to use snprintf() as a safe replacement for strcpy():  

```c
snprintf(array2, destination_size, "%s", array1);
```

<sub>(Thanks <a href="https://stackoverflow.com/users/315052/jxh">jxh</a> for the tip.)</sub>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: Printing prime numbers from 1 through 100 (score [366862](https://stackoverflow.com/q/5200879) in 2011)

#### Question
This c++ code prints out the following prime numbers:   <strong>3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97.</strong>  

But I don't think that's the way my book wants it to be written. It mentions something about square root of a number. So I did try changing my 2nd loop to `for (int j=2; j&lt;sqrt(i); j++)` but it did not give me the result I needed.  

How would I need to change this code to the way my book wants it to be?  

```c
int main () 
{
    for (int i=2; i<100; i++) 
        for (int j=2; j<i; j++)
        {
            if (i % j == 0) 
                break;
            else if (i == j+1)
                cout << i << " ";

        }   
    return 0;
}
```

<blockquote>
  <p>A prime integer number is one that has
  exactly two different divisors, 
  namely 1 and the number itself. Write,
  run, and test a C++ program that 
  finds and prints all the prime numbers
  less than 100. (Hint: 1 is a  prime
  number. For each number from 2 to 100,
  find Remainder = Number % n, where n
  ranges from 2 to sqrt(number). \ If n
  is greater than sqrt(number), the
  number is not equally divisible by n. 
  Why? If any Remainder equals 0, the
  number is no a prime number.)</p>
</blockquote>

#### Answer accepted (score 28)
Three ways:  

1.  

```c
int main () 
{
    for (int i=2; i<100; i++) 
        for (int j=2; j*j<=i; j++)
        {
            if (i % j == 0) 
                break;
            else if (j+1 > sqrt(i)) {
                cout << i << " ";

            }

        }   

    return 0;
}
```

2.  

```c
int main () 
{
    for (int i=2; i<100; i++) 
    {
        bool prime=true;
        for (int j=2; j*j<=i; j++)
        {
            if (i % j == 0) 
            {
                prime=false;
                break;    
            }
        }   
        if(prime) cout << i << " ";
    }
    return 0;
}
```

3.  

```c
#include <vector>
int main()
{
    std::vector<int> primes;
    primes.push_back(2);
    for(int i=3; i < 100; i++)
    {
        bool prime=true;
        for(int j=0;j<primes.size() && primes[j]*primes[j] <= i;j++)
        {
            if(i % primes[j] == 0)
            {
                prime=false;
                break;
            }
        }
        if(prime) 
        {
            primes.push_back(i);
            cout << i << " ";
        }
    }

    return 0;
}
```

Edit: In the third example, we keep track of all of our previously calculated primes. If a number is divisible by a non-prime number, there is also some prime &lt;= that divisor which it is also divisble by. This reduces computation by a factor of primes_in_range/total_range.  

#### Answer 2 (score 16)
If `j` is <em>equal</em> to `sqrt(i)` it might also be a valid factor, not only if it's <em>smaller</em>.  

To iterate up to and including `sqrt(i)` in your inner loop, you could write:  

```c
for (int j=2; j*j<=i; j++)
```

(Compared to using `sqrt(i)` this has the advantage to not need conversion to floating point numbers.)   

#### Answer 3 (score 12)
If a number has divisors, at least one of them must be less than or equal to the square root of the number. When you check divisors, you only need to check up to the square root, not all the way up to the number being tested.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: How to print a int64_t type in C (score [365851](https://stackoverflow.com/q/9225567) in 2013)

#### Question
C99 standard has integer types with bytes size like int64_t. I am using the following code:  

```c
#include <stdio.h>
#include <stdint.h>
int64_t my_int = 999999999999999999;
printf("This is my_int: %I64d\n", my_int);
```

and I get this compiler warning:  

```c
warning: format ‘%I64d’ expects type ‘int’, but argument 2 has type ‘int64_t’
```

I tried with:  

```c
printf("This is my_int: %lld\n", my_int); // long long decimal
```

But I get the same warning. I am using this compiler:  

```c
~/dev/c$ cc -v
Using built-in specs.
Target: i686-apple-darwin10
Configured with: /var/tmp/gcc/gcc-5664~89/src/configure --disable-checking --enable-werror --prefix=/usr --mandir=/share/man --enable-languages=c,objc,c++,obj-c++ --program-transform-name=/^[cg][^.-]*$/s/$/-4.2/ --with-slibdir=/usr/lib --build=i686-apple-darwin10 --program-prefix=i686-apple-darwin10- --host=x86_64-apple-darwin10 --target=i686-apple-darwin10 --with-gxx-include-dir=/include/c++/4.2.1
Thread model: posix
gcc version 4.2.1 (Apple Inc. build 5664)
```

Which format should I use to print my_int variable without having a warning?  

#### Answer accepted (score 389)
For `int64_t` type:  

```c
#include <inttypes.h>
int64_t t;
printf("%" PRId64 "\n", t);
```

for `uint64_t` type:  

```c
#include <inttypes.h>
uint64_t t;
printf("%" PRIu64 "\n", t);
```

you can also use `PRIx64` to print in hexadecimal.  

<a href="http://en.cppreference.com/w/cpp/types/integer" rel="noreferrer">cppreference.com has a full listing</a> of available macros for all types including `intptr_t` (`PRIxPTR`).  There are separate macros for scanf, like `SCNd64`.  

<hr>

A typical definition of PRIu16 would be `"hu"`, so implicit string-constant concatenation happens at compile time.  

For your code to be fully portable, you must use `PRId32` and so on for printing `int32_t`, and `"%d"` or similar for printing `int`.  

#### Answer 2 (score 60)
The C99 way is  

```c
#include <inttypes.h>
int64_t my_int = 999999999999999999;
printf("%" PRId64 "\n", my_int);
```

Or you could cast!  

```c
printf("%ld", (long)my_int);
printf("%lld", (long long)my_int); /* C89 didn't define `long long` */
printf("%f", (double)my_int);
```

If you're stuck with a C89 implementation (notably Visual Studio) you can perhaps use an open source `&lt;inttypes.h&gt;` (and `&lt;stdint.h&gt;`): <a href="http://code.google.com/p/msinttypes/" rel="noreferrer">http://code.google.com/p/msinttypes/</a>  

#### Answer 3 (score 14)
With C99 the `%j` length modifier can also be used with the printf family of functions to print values of type `int64_t` and `uint64_t`:  

```c
#include <stdio.h>
#include <stdint.h>

int main(int argc, char *argv[])
{
    int64_t  a = 1LL << 63;
    uint64_t b = 1ULL << 63;

    printf("a=%jd (0x%jx)\n", a, a);
    printf("b=%ju (0x%jx)\n", b, b);

    return 0;
}
```

Compiling this code with `gcc -Wall -pedantic -std=c99` produces no warnings, and the program prints the expected output:  

```c
a=-9223372036854775808 (0x8000000000000000)
b=9223372036854775808 (0x8000000000000000)
```

This is according to `printf(3)` on my Linux system (the man page specifically says that `j` is used to indicate a conversion to an `intmax_t` or `uintmax_t`; in my stdint.h, both `int64_t` and `intmax_t` are typedef'd in exactly the same way, and similarly for `uint64_t`). I'm not sure if this is perfectly portable to other systems.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: clearing a char array c (score [364411](https://stackoverflow.com/q/632846) in 2012)

#### Question
I thought by setting the first element to a null would clear the entire contents of a char array.  

```c
char my_custom_data[40] = "Hello!";
my_custom_data[0] = '\0';
```

However, this only sets the first element to null.  

or  

```c
my_custom_data[0] = 0; 
```

rather than use `memset`, I thought the 2 examples above should clear all the data.  

#### Answer accepted (score 110)
It depends on how you want to view the array.  If you are viewing the array as a series of chars, then the only way to clear out the data is to touch every entry. `memset` is probably the most effective way to achieve this.  

On the other hand, if you are choosing to view this as a C/C++ null terminated string, setting the first byte to 0 will effectively clear the string.  

#### Answer 2 (score 69)
An array in C is just a memory location, so indeed, your `my_custom_data[0] = '\0';` assignment simply sets the first element to zero and leaves the other elements intact.  

If you want to clear all the elements of the array, you'll have to visit each element. That is what `memset` is for:  

```c
memset(&arr[0], 0, sizeof(arr));
```

This is generally the fastest way to take care of this. If you can use C++, consider std::fill instead:  

```c
char *begin = &arr;
char *end = begin + sizeof(arr);
std::fill(begin, end, 0);
```

#### Answer 3 (score 22)
<p>Why would you think setting a single element would clear the entire array?
In C, especially, little ever happens without the programmer explicitly programming it.  If you set the first element to zero (or any value), then you have done exactly that, and nothing more.</p>

When initializing you can set an array to zero:  

```c
char mcd[40] = {0}; /* sets the whole array */
```

Otherwise, I don't know any technique other than memset, or something similar.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: How to open, read, and write from serial port in C? (score [364263](https://stackoverflow.com/q/6947413) in 2018)

#### Question
I am a little bit confused about reading and writing to a serial port. I have a USB device in Linux that uses the FTDI USB serial device converter driver. When I plug it in, it creates: /dev/ttyUSB1.   

I thought itd be simple to open and read/write from it in C. I know the baud rate and parity information, but it seems like there is no standard for this?  

Am I missing something, or can someone point me in the right direction?  

#### Answer accepted (score 234)
I wrote this a long time ago (<a href="https://stackoverflow.com/questions/25996171/linux-blocking-vs-non-blocking-serial-read/26006680#comment70743914_26006680">from years 1985-1992, with just a few tweaks since then</a>), and just copy and paste the bits needed into each project.  

```c
#include <errno.h>
#include <fcntl.h> 
#include <string.h>
#include <termios.h>
#include <unistd.h>

int
set_interface_attribs (int fd, int speed, int parity)
{
        struct termios tty;
        memset (&tty, 0, sizeof tty);
        if (tcgetattr (fd, &tty) != 0)
        {
                error_message ("error %d from tcgetattr", errno);
                return -1;
        }

        cfsetospeed (&tty, speed);
        cfsetispeed (&tty, speed);

        tty.c_cflag = (tty.c_cflag & ~CSIZE) | CS8;     // 8-bit chars
        // disable IGNBRK for mismatched speed tests; otherwise receive break
        // as \000 chars
        tty.c_iflag &= ~IGNBRK;         // disable break processing
        tty.c_lflag = 0;                // no signaling chars, no echo,
                                        // no canonical processing
        tty.c_oflag = 0;                // no remapping, no delays
        tty.c_cc[VMIN]  = 0;            // read doesn't block
        tty.c_cc[VTIME] = 5;            // 0.5 seconds read timeout

        tty.c_iflag &= ~(IXON | IXOFF | IXANY); // shut off xon/xoff ctrl

        tty.c_cflag |= (CLOCAL | CREAD);// ignore modem controls,
                                        // enable reading
        tty.c_cflag &= ~(PARENB | PARODD);      // shut off parity
        tty.c_cflag |= parity;
        tty.c_cflag &= ~CSTOPB;
        tty.c_cflag &= ~CRTSCTS;

        if (tcsetattr (fd, TCSANOW, &tty) != 0)
        {
                error_message ("error %d from tcsetattr", errno);
                return -1;
        }
        return 0;
}

void
set_blocking (int fd, int should_block)
{
        struct termios tty;
        memset (&tty, 0, sizeof tty);
        if (tcgetattr (fd, &tty) != 0)
        {
                error_message ("error %d from tggetattr", errno);
                return;
        }

        tty.c_cc[VMIN]  = should_block ? 1 : 0;
        tty.c_cc[VTIME] = 5;            // 0.5 seconds read timeout

        if (tcsetattr (fd, TCSANOW, &tty) != 0)
                error_message ("error %d setting term attributes", errno);
}


...
char *portname = "/dev/ttyUSB1"
 ...
int fd = open (portname, O_RDWR | O_NOCTTY | O_SYNC);
if (fd < 0)
{
        error_message ("error %d opening %s: %s", errno, portname, strerror (errno));
        return;
}

set_interface_attribs (fd, B115200, 0);  // set speed to 115,200 bps, 8n1 (no parity)
set_blocking (fd, 0);                // set no blocking

write (fd, "hello!\n", 7);           // send 7 character greeting

usleep ((7 + 25) * 100);             // sleep enough to transmit the 7 plus
                                     // receive 25:  approx 100 uS per char transmit
char buf [100];
int n = read (fd, buf, sizeof buf);  // read up to 100 characters if ready to read
```

The values for speed are `B115200`, `B230400`, `B9600`, `B19200`, `B38400`, `B57600`, `B1200`, `B2400`, `B4800`, etc.  The values for parity are `0` (meaning no parity), `PARENB|PARODD` (enable parity and use odd), `PARENB` (enable parity and use even), `PARENB|PARODD|CMSPAR` (mark parity), and `PARENB|CMSPAR` (space parity).  

"Blocking" sets whether a `read()` on the port waits for the specified number of characters to arrive.  Setting <em>no blocking</em> means that a `read()` returns however many characters are available without waiting for more, up to the buffer limit.  

<hr>

Addendum:  

`CMSPAR` is needed only for choosing mark and space parity, which is uncommon.  For most applications, it can be omitted.  My header file `/usr/include/bits/termios.h` enables definition of `CMSPAR` only if the preprocessor symbol `__USE_MISC` is defined.  That definition occurs (in `features.h`) with  

```c
#if defined _BSD_SOURCE || defined _SVID_SOURCE
 #define __USE_MISC     1
#endif
```

The introductory comments of `&lt;features.h&gt;` says:  

```c
/* These are defined by the user (or the compiler)
   to specify the desired environment:

...
   _BSD_SOURCE          ISO C, POSIX, and 4.3BSD things.
   _SVID_SOURCE         ISO C, POSIX, and SVID things.
...
 */
```

#### Answer 2 (score 43)
<p>For demo code that conforms to POSIX standard as described in <a href="http://www.chemie.fu-berlin.de/chemnet/use/info/libc/libc_12.html#SEC237" rel="nofollow noreferrer">Setting Terminal Modes Properly</a>
and <a href="http://www.cmrr.umn.edu/~strupp/serial.html" rel="nofollow noreferrer">Serial Programming Guide for POSIX Operating Systems</a>, the following is offered.<br>
It's essentially derived from the other answer, but inaccurate and misleading comments have been corrected.</p>

```c
#include <errno.h>
#include <fcntl.h> 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>

int set_interface_attribs(int fd, int speed)
{
    struct termios tty;

    if (tcgetattr(fd, &tty) < 0) {
        printf("Error from tcgetattr: %s\n", strerror(errno));
        return -1;
    }

    cfsetospeed(&tty, (speed_t)speed);
    cfsetispeed(&tty, (speed_t)speed);

    tty.c_cflag |= (CLOCAL | CREAD);    /* ignore modem controls */
    tty.c_cflag &= ~CSIZE;
    tty.c_cflag |= CS8;         /* 8-bit characters */
    tty.c_cflag &= ~PARENB;     /* no parity bit */
    tty.c_cflag &= ~CSTOPB;     /* only need 1 stop bit */
    tty.c_cflag &= ~CRTSCTS;    /* no hardware flowcontrol */

    /* setup for non-canonical mode */
    tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR | IGNCR | ICRNL | IXON);
    tty.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
    tty.c_oflag &= ~OPOST;

    /* fetch bytes as they become available */
    tty.c_cc[VMIN] = 1;
    tty.c_cc[VTIME] = 1;

    if (tcsetattr(fd, TCSANOW, &tty) != 0) {
        printf("Error from tcsetattr: %s\n", strerror(errno));
        return -1;
    }
    return 0;
}

void set_mincount(int fd, int mcount)
{
    struct termios tty;

    if (tcgetattr(fd, &tty) < 0) {
        printf("Error tcgetattr: %s\n", strerror(errno));
        return;
    }

    tty.c_cc[VMIN] = mcount ? 1 : 0;
    tty.c_cc[VTIME] = 5;        /* half second timer */

    if (tcsetattr(fd, TCSANOW, &tty) < 0)
        printf("Error tcsetattr: %s\n", strerror(errno));
}


int main()
{
    char *portname = "/dev/ttyUSB0";
    int fd;
    int wlen;

    fd = open(portname, O_RDWR | O_NOCTTY | O_SYNC);
    if (fd < 0) {
        printf("Error opening %s: %s\n", portname, strerror(errno));
        return -1;
    }
    /*baudrate 115200, 8 bits, no parity, 1 stop bit */
    set_interface_attribs(fd, B115200);
    //set_mincount(fd, 0);                /* set to pure timed read */

    /* simple output */
    wlen = write(fd, "Hello!\n", 7);
    if (wlen != 7) {
        printf("Error from write: %d, %d\n", wlen, errno);
    }
    tcdrain(fd);    /* delay for output */


    /* simple noncanonical input */
    do {
        unsigned char buf[80];
        int rdlen;

        rdlen = read(fd, buf, sizeof(buf) - 1);
        if (rdlen > 0) {
#ifdef DISPLAY_STRING
            buf[rdlen] = 0;
            printf("Read %d: \"%s\"\n", rdlen, buf);
#else /* display hex */
            unsigned char   *p;
            printf("Read %d:", rdlen);
            for (p = buf; rdlen-- > 0; p++)
                printf(" 0x%x", *p);
            printf("\n");
#endif
        } else if (rdlen < 0) {
            printf("Error from read: %d: %s\n", rdlen, strerror(errno));
        } else {  /* rdlen == 0 */
            printf("Timeout from read\n");
        }               
        /* repeat read to get full message */
    } while (1);
}
```

To make the program treat the received data as ASCII codes, compile the program with the symbol DISPLAY_STRING, e.g.    

```c
 cc -DDISPLAY_STRING demo.c
```

<hr>

If the received data is ASCII text (rather than binary data) and you want to read it as lines terminated by the newline character, then see <a href="https://stackoverflow.com/questions/57152937/canonical-mode-linux-serial-port/57155531#57155531">this answer</a> for a sample program.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: What does void mean in C, C++, and C#? (score [360403](https://stackoverflow.com/q/1043034) in 2018)

#### Question
Looking to get the fundamentals on where the term "<em>void</em>" comes from, and why it is called void. The intention of the question is to assist someone who has no C experience, and is suddenly looking at a C-based codebase.   

#### Answer accepted (score 217)
Basically it means "nothing" or "no type"  

There are 3 basic ways that void is used:  

<ol>
<li><p>Function argument: `int myFunc(void)`
-- the function takes nothing. </p></li>
<li><p>Function return value: `void myFunc(int)`
-- the function returns nothing</p></li>
<li><p>Generic data pointer: `void* data`
-- 'data' is a pointer to data of unknown type, and cannot be dereferenced</p></li>
</ol>

Note: the `void` in a function argument is optional in C++, so `int myFunc()` is exactly the same as `int myFunc(void)`, and it is left out completely in C#. It is always required for a return value.  

#### Answer 2 (score 31)
I have always taken it to mean <em>absent</em>. Here are four cases in the C language that matches to this use of <em>absent</em>  

<ul>
<li>`R f(void)` - Function parameters are <em>absent</em></li>
<li>`void f(P)` - Return value is <em>absent</em></li>
<li>`void *p` - Type of what is pointed to is <em>absent</em></li>
<li>`(void) p` - Usage of value is <em>absent</em></li>
</ul>

Other C descendants use it for other things. The `D` programming language uses it for cases where an initializer is <em>absent</em>  

<ul>
<li>`T t = void;` - initializing value is <em>absent</em></li>
</ul>

#### Answer 3 (score 13)
There are two ways to use void:  

```c
void foo(void);
```

or  

```c
void *bar(void*);
```

The first indicates that no argument is being passed or that no argument is being returned.  

The second tells the compiler that there is no type associated with the data effectively meaning that the you can't make use of the data pointed to until it is cast to a known type.  

For example you will see `void*` used a lot when you have an interface which calls a function whose parameters can't be known ahead of time.  

For example, in the Linux Kernel when deferring work you will setup a function to be run at a latter time by giving it a pointer to the function to be run and a pointer to the data to be passed to the function:  

```c
struct _deferred_work {
sruct list_head mylist;
.worker_func = bar;
.data        = somedata;
} deferred_work;
```

Then a kernel thread goes over a list of deferred work and when it get's to this node it effectively executes:  

```c
bar(somedata);
```

Then in bar you have:  

```c
void bar(void* mydata) {
    int *data = mydata;
    /* do something with data */;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: Stack smashing detected (score [356971](https://stackoverflow.com/q/1345670) in 2012)

#### Question
I am executing my a.out file. After execution the program runs for some time then exits with the message:  

```c
**** stack smashing detected ***: ./a.out terminated*
*======= Backtrace: =========*
*/lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)Aborted*
```

What could be the possible reasons for this and how do I rectify it?  

#### Answer accepted (score 309)
Stack Smashing here is actually caused due to a protection mechanism used by gcc to detect buffer overflow errors. For example in the following snippet:  

```c
#include <stdio.h>

void func()
{
    char array[10];
    gets(array);
}

int main(int argc, char **argv)
{
    func();
}
```

The compiler, (in this case gcc) adds protection variables (called canaries) which have known values. An input string of size greater than 10 causes corruption of this variable resulting in SIGABRT to terminate the program.  

To get some insight, you can try disabling this protection of gcc using option  ` -fno-stack-protector ` while compiling. In that case you will get a different error, most likely a segmentation fault as you are trying to access an illegal memory location.  Note that `-fstack-protector` should always be turned on for release builds as it is a security feature.  

You can get some information about the point of overflow by running the program with a debugger. Valgrind doesn't work well with stack-related errors, but like a debugger, it may help you pin-point the location and reason for the crash.  

#### Answer 2 (score 24)
<strong>Minimal reproduction example with disassembly analysis</strong>  

main.c  

```c
void myfunc(char *const src, int len) {
    int i;
    for (i = 0; i < len; ++i) {
        src[i] = 42;
    }
}

int main(void) {
    char arr[] = {'a', 'b', 'c', 'd'};
    int len = sizeof(arr);
    myfunc(arr, len + 1);
    return 0;
}
```

<a href="https://github.com/cirosantilli/linux-kernel-module-cheat/blob/e0fb39c92ae071a444cb92fbb2d0c1977fa7af51/userland/c/smash_stack.c" rel="nofollow noreferrer">GitHub upstream</a>.  

Compile and run:  

```c
gcc -fstack-protector -g -O0 -std=c99 main.c
ulimit -c unlimited && rm -f core
./a.out
```

fails as desired:  

```c
*** stack smashing detected ***: ./a.out terminated
Aborted (core dumped)
```

Tested on Ubuntu 16.04, GCC 6.4.0.  

<strong>Disassembly</strong>  

Now we look at the disassembly:  

```c
objdump -D a.out
```

which contains:  

```c
int main (void){
  400579:       55                      push   %rbp
  40057a:       48 89 e5                mov    %rsp,%rbp

  # Allocate 0x10 of stack space.
  40057d:       48 83 ec 10             sub    $0x10,%rsp

  # Put the 8 byte canary from %fs:0x28 to -0x8(%rbp),
  # which is right at the bottom of the stack.
  400581:       64 48 8b 04 25 28 00    mov    %fs:0x28,%rax
  400588:       00 00 
  40058a:       48 89 45 f8             mov    %rax,-0x8(%rbp)

  40058e:       31 c0                   xor    %eax,%eax
    char arr[] = {'a', 'b', 'c', 'd'};
  400590:       c6 45 f4 61             movb   $0x61,-0xc(%rbp)
  400594:       c6 45 f5 62             movb   $0x62,-0xb(%rbp)
  400598:       c6 45 f6 63             movb   $0x63,-0xa(%rbp)
  40059c:       c6 45 f7 64             movb   $0x64,-0x9(%rbp)
    int len = sizeof(arr);
  4005a0:       c7 45 f0 04 00 00 00    movl   $0x4,-0x10(%rbp)
    myfunc(arr, len + 1);
  4005a7:       8b 45 f0                mov    -0x10(%rbp),%eax
  4005aa:       8d 50 01                lea    0x1(%rax),%edx
  4005ad:       48 8d 45 f4             lea    -0xc(%rbp),%rax
  4005b1:       89 d6                   mov    %edx,%esi
  4005b3:       48 89 c7                mov    %rax,%rdi
  4005b6:       e8 8b ff ff ff          callq  400546 <myfunc>
    return 0;
  4005bb:       b8 00 00 00 00          mov    $0x0,%eax
}
```



```c
  # Check that the canary at -0x8(%rbp) hasn't changed after calling myfunc.
  # If it has, jump to the failure point __stack_chk_fail.
  4005c0:       48 8b 4d f8             mov    -0x8(%rbp),%rcx
  4005c4:       64 48 33 0c 25 28 00    xor    %fs:0x28,%rcx
  4005cb:       00 00 
  4005cd:       74 05                   je     4005d4 <main+0x5b>
  4005cf:       e8 4c fe ff ff          callq  400420 <__stack_chk_fail@plt>

  # Otherwise, exit normally.
  4005d4:       c9                      leaveq 
  4005d5:       c3                      retq   
  4005d6:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
  4005dd:       00 00 00 
```

Notice the handy comments automatically added by `objdump`'s <a href="https://en.wikipedia.org/wiki/Joke" rel="nofollow noreferrer">artificial intelligence module</a>.  

If you run this program multiple times through GDB, you will see that:  

<ul>
<li>the canary gets a different random value every time</li>
<li>the last loop of `myfunc` is exactly what modifies the address of the canary</li>
</ul>

The canary randomized by setting it with `%fs:0x28`, which contains a random value as explained at:  

<ul>
<li><a href="https://unix.stackexchange.com/questions/453749/what-sets-fs0x28-stack-canary">https://unix.stackexchange.com/questions/453749/what-sets-fs0x28-stack-canary</a></li>
<li><a href="https://stackoverflow.com/questions/10325713/why-does-this-memory-address-fs0x28-fs0x28-have-a-random-value">Why does this memory address %fs:0x28 ( fs[0x28] ) have a random value?</a></li>
</ul>

<strong>Debug attempts</strong>  

From now on, we modify the code:  

```c
    myfunc(arr, len + 1);
```

to be instead:  

```c
    myfunc(arr, len);
    myfunc(arr, len + 1); /* line 12 */
    myfunc(arr, len);
```

to be more interesting.  

We will then try to see if we can pinpoint the culprit `+ 1` call with a method more automated than just reading and understanding the entire source code.  

<strong>`gcc -fsanitize=address` to enable Google's Address Sanitizer (ASan)</strong>  

If you recompile with this flag and run the program, it outputs:  

```c
#0 0x4008bf in myfunc /home/ciro/test/main.c:4
#1 0x40099b in main /home/ciro/test/main.c:12
#2 0x7fcd2e13d82f in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
#3 0x400798 in _start (/home/ciro/test/a.out+0x40079
```

followed by some more colored output.  

This clearly pinpoints the problematic line 12.  

The source code for this is at: <a href="https://github.com/google/sanitizers" rel="nofollow noreferrer">https://github.com/google/sanitizers</a> but as we saw from the example it is already upstreamed into GCC.  

ASan can also detect other memory problems such as memory leaks: <a href="https://stackoverflow.com/questions/6261201/how-to-find-memory-leak-in-a-c-code-project/57877190#57877190">How to find memory leak in a C++ code/project?</a>  

<strong>Valgrind SGCheck</strong>  

As <a href="https://stackoverflow.com/a/1345689/895245">mentioned by others</a>, Valgrind is not good at solving this kind of problem.  

It does have an experimental tool <a href="http://valgrind.org/docs/manual/sg-manual.html" rel="nofollow noreferrer">called SGCheck</a>:  

<blockquote>
  SGCheck is a tool for finding overruns of stack and global arrays. It works by using a heuristic approach derived from an observation about the likely forms of stack and global array accesses.  
</blockquote>

So I was not very surprised when it did not find the error:  

```c
valgrind --tool=exp-sgcheck ./a.out
```

The error message should look like this apparently: <a href="https://stackoverflow.com/questions/36997537/valgrind-missing-error/36997685#36997685">Valgrind missing error</a>  

<strong>GDB</strong>  

An important observation is that if you run the program through GDB, or examine the `core` file after the fact:  

```c
gdb -nh -q a.out core
```

then, as we saw on the assembly, GDB should point you to the end of the function that did the canary check:  

```c
(gdb) bt
#0  0x00007f0f66e20428 in __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:54
#1  0x00007f0f66e2202a in __GI_abort () at abort.c:89
#2  0x00007f0f66e627ea in __libc_message (do_abort=do_abort@entry=1, fmt=fmt@entry=0x7f0f66f7a49f "*** %s ***: %s terminated\n") at ../sysdeps/posix/libc_fatal.c:175
#3  0x00007f0f66f0415c in __GI___fortify_fail (msg=<optimized out>, msg@entry=0x7f0f66f7a481 "stack smashing detected") at fortify_fail.c:37
#4  0x00007f0f66f04100 in __stack_chk_fail () at stack_chk_fail.c:28
#5  0x00000000004005f6 in main () at main.c:15
(gdb) f 5
#5  0x00000000004005f6 in main () at main.c:15
15      }
(gdb)
```

And therefore the problem is likely in one of the calls that this function made.  

Next we try to pinpoint the exact failing call by first single stepping up just after the canary is set:  

```c
  400581:       64 48 8b 04 25 28 00    mov    %fs:0x28,%rax
  400588:       00 00 
  40058a:       48 89 45 f8             mov    %rax,-0x8(%rbp)
```

and watching the address:  

```c
(gdb) p $rbp - 0x8
$1 = (void *) 0x7fffffffcf18
(gdb) watch 0x7fffffffcf18
Hardware watchpoint 2: *0x7fffffffcf18
(gdb) c
Continuing.

Hardware watchpoint 2: *0x7fffffffcf18

Old value = 1800814336
New value = 1800814378
myfunc (src=0x7fffffffcf14 "*****?Vk\266", <incomplete sequence \355\216>, len=5) at main.c:3
3           for (i = 0; i < len; ++i) {
(gdb) p len
$2 = 5
(gdb) p i
$3 = 4
(gdb) bt
#0  myfunc (src=0x7fffffffcf14 "*****?Vk\266", <incomplete sequence \355\216>, len=5) at main.c:3
#1  0x00000000004005cc in main () at main.c:12
```

Now, this does leaves us at the right offending instruction: `len = 5` and `i = 4`, and in this particular case, did point us to the culprit line 12.  

However, the backtrace is corrupted, and contains some trash. A correct backtrace would look like:  

```c
#0  myfunc (src=0x7fffffffcf14 "abcd", len=4) at main.c:3
#1  0x00000000004005b8 in main () at main.c:11
```

so maybe this could corrupt the stack and prevent you from seeing the trace.  

Also, this method requires knowing what is the last call of the canary checking function otherwise you will have false positives, which will not always be feasible, unless you <a href="https://stackoverflow.com/questions/1206872/how-to-go-to-the-previous-line-in-gdb/46996380#46996380">use reverse debugging</a>.  

#### Answer 3 (score 16)
Please look at the following situation:  

```c
ab@cd-x:$ cat test_overflow.c 
#include <stdio.h>
#include <string.h>

int check_password(char *password){
    int flag = 0;
    char buffer[20];
    strcpy(buffer, password);

    if(strcmp(buffer, "mypass") == 0){
        flag = 1;
    }
    if(strcmp(buffer, "yourpass") == 0){
        flag = 1;
    }
    return flag;
}

int main(int argc, char *argv[]){
    if(argc >= 2){
        if(check_password(argv[1])){
            printf("%s", "Access granted\n");
        }else{
            printf("%s", "Access denied\n");
        }
    }else{
        printf("%s", "Please enter password!\n");
    }
}
ab@cd-x:$ gcc -g -fno-stack-protector test_overflow.c 
ab@cd-x:$ ./a.out mypass
Access granted
ab@cd-x:$ ./a.out yourpass
Access granted
ab@cd-x:$ ./a.out wepass
Access denied
ab@cd-x:$ ./a.out wepassssssssssssssssss
Access granted

ab@cd-x:$ gcc -g -fstack-protector test_overflow.c 
ab@cd-x:$ ./a.out wepass
Access denied
ab@cd-x:$ ./a.out mypass
Access granted
ab@cd-x:$ ./a.out yourpass
Access granted
ab@cd-x:$ ./a.out wepassssssssssssssssss
*** stack smashing detected ***: ./a.out terminated
======= Backtrace: =========
/lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0xce0ed8]
/lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x0)[0xce0e90]
./a.out[0x8048524]
./a.out[0x8048545]
/lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe6)[0xc16b56]
./a.out[0x8048411]
======= Memory map: ========
007d9000-007f5000 r-xp 00000000 08:06 5776       /lib/libgcc_s.so.1
007f5000-007f6000 r--p 0001b000 08:06 5776       /lib/libgcc_s.so.1
007f6000-007f7000 rw-p 0001c000 08:06 5776       /lib/libgcc_s.so.1
0090a000-0090b000 r-xp 00000000 00:00 0          [vdso]
00c00000-00d3e000 r-xp 00000000 08:06 1183       /lib/tls/i686/cmov/libc-2.10.1.so
00d3e000-00d3f000 ---p 0013e000 08:06 1183       /lib/tls/i686/cmov/libc-2.10.1.so
00d3f000-00d41000 r--p 0013e000 08:06 1183       /lib/tls/i686/cmov/libc-2.10.1.so
00d41000-00d42000 rw-p 00140000 08:06 1183       /lib/tls/i686/cmov/libc-2.10.1.so
00d42000-00d45000 rw-p 00000000 00:00 0 
00e0c000-00e27000 r-xp 00000000 08:06 4213       /lib/ld-2.10.1.so
00e27000-00e28000 r--p 0001a000 08:06 4213       /lib/ld-2.10.1.so
00e28000-00e29000 rw-p 0001b000 08:06 4213       /lib/ld-2.10.1.so
08048000-08049000 r-xp 00000000 08:05 1056811    /dos/hacking/test/a.out
08049000-0804a000 r--p 00000000 08:05 1056811    /dos/hacking/test/a.out
0804a000-0804b000 rw-p 00001000 08:05 1056811    /dos/hacking/test/a.out
08675000-08696000 rw-p 00000000 00:00 0          [heap]
b76fe000-b76ff000 rw-p 00000000 00:00 0 
b7717000-b7719000 rw-p 00000000 00:00 0 
bfc1c000-bfc31000 rw-p 00000000 00:00 0          [stack]
Aborted
ab@cd-x:$ 
```

When I disabled the stack smashing protector no errors were detected, which should have happened when I used "./a.out wepassssssssssssssssss" <br/>  

So to answer your question above, the message "** stack smashing detected : xxx" was displayed because your stack smashing protector was active and found that there is stack overflow in your program.  

Just find out where that occurs, and fix it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: How to do scanf for single char in C (score [356225](https://stackoverflow.com/q/13542055) in 2014)

#### Question
<p>In C:
I'm trying to get char from the user with `scanf` and when I run it the program don't wait for the user to type anything...</p>

This is the code:  

```c
char ch;
printf("Enter one char");
scanf("%c", &ch);
printf("%c\n",ch);
```

Why is not working?  

#### Answer 2 (score 209)
The `%c` conversion specifier won't automatically skip any leading whitespace, so if there's a stray newline in the input stream (from a previous entry, for example) the `scanf` call will consume it immediately.  

One way around the problem is to put a blank space before the conversion specifier in the format string:  

```c
scanf(" %c", &c);
```

The blank in the format string tells `scanf` to skip leading whitespace, and the first non-whitespace character will be read with the `%c` conversion specifier.    

#### Answer 3 (score 14)
First of all, avoid `scanf()`. Using it is not worth the pain.  

See: <a href="http://c-faq.com/stdio/scanfprobs.html" rel="noreferrer">Why does everyone say not to use scanf? What should I use instead?</a>  

Using a whitespace character in `scanf()` would ignore any number of whitespace characters left in the input stream, what if you need to read more inputs? Consider:  

```c
#include <stdio.h>

int main(void)
{
   char ch1, ch2;

   scanf("%c", &ch1);  /* Leaves the newline in the input */
   scanf(" %c", &ch2); /* The leading whitespace ensures it's the
                          previous newline is ignored */
   printf("ch1: %c, ch2: %c\n", ch1, ch2);

   /* All good so far */

   char ch3;
   scanf("%c", &ch3); /* Doesn't read input due to the same problem */
   printf("ch3: %c\n", ch3);

   return 0;
}
```

<p>While the 3rd scanf() can be fixed in the same way using a leading whitespace, it's not always going to that simple as above.
Another major problem is, `scanf()` will not discard any input in the input stream if it doesn't match the format. For example, if you input `abc` for an `int` such as: `scanf("%d", &amp;int_var);` then `abc` will have to read and discarded. Consider:</p>

```c
#include <stdio.h>

int main(void)
{
    int i;

    while(1) {
        if (scanf("%d", &i) != 1) { /* Input "abc" */
            printf("Invalid input. Try again\n");
        } else {
            break;
        }
    }

    printf("Int read: %d\n", i);
    return 0;
}
```

Another common problem is mixing `scanf()` and `fgets()`. Consider:  

```c
#include <stdio.h>

int main(void)
{
    int age;
    char name[256];
    printf("Input your age:");
    scanf("%d", &age); /* Input 10 */
    printf("Input your full name [firstname lastname]");
    fgets(name, sizeof name, stdin); /* Doesn't read! */
    return 0;
}
```

The call to `fgets()` doesn't wait for input because the newline left by the previous scanf() call is read and fgets() terminates input reading when it encounters a newline.  

There are many other similar problems associated with `scanf()`. That's why it's generally recommended to avoid it.  

So, what's the alternative? Use <a href="http://man7.org/linux/man-pages/man3/fgetc.3.html" rel="noreferrer">`fgets()`</a> function instead in the following fashion to read a single character:  

```c
#include <stdio.h>

int main(void)
{
    char line[256];
    char ch;

    if (fgets(line, sizeof line, stdin) == NULL) {
        printf("Input error.\n");
        exit(1);
    }

    ch = line[0];
    printf("Character read: %c\n", ch);
    return 0;
}
```

One detail to be aware of when using `fgets()` will read in the newline character if there's enough room in the inut buffer. If it's not desirable then you can remove it:  

```c
char line[256];

if (fgets(line, sizeof line, stdin) == NULL) {
    printf("Input error.\n");
    exit(1);
}

line[strcpsn(line, "\n")] = 0; /* removes the trailing newline, if present */
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: How do I check if an integer is even or odd? (score [355377](https://stackoverflow.com/q/160930) in 2015)

#### Question
How can I check if a given number is even or odd in C?  

#### Answer accepted (score 449)
Use the modulo (%) operator to check if there's a remainder when dividing by 2:  

```c
if (x % 2) { /* x is odd */ }
```

A few people have criticized my answer above stating that using x &amp; 1 is "faster" or "more efficient". I do not believe this to be the case.   

Out of curiosity, I created two trivial test case programs:  

```c
/* modulo.c */
#include <stdio.h>

int main(void)
{
    int x;
    for (x = 0; x < 10; x++)
        if (x % 2)
            printf("%d is odd\n", x);
    return 0;
}

/* and.c */
#include <stdio.h>

int main(void)
{
    int x;
    for (x = 0; x < 10; x++)
        if (x & 1)
            printf("%d is odd\n", x);
    return 0;
}
```

I then compiled these with gcc 4.1.3 on one of my machines 5 different times:  

<ul>
<li>With no optimization flags.</li>
<li>With -O</li>
<li>With -Os</li>
<li>With -O2</li>
<li>With -O3</li>
</ul>

I examined the assembly output of each compile (using gcc -S) and found that in each case, the output for and.c and modulo.c were identical (they both used the andl $1, %eax instruction). I doubt this is a "new" feature, and I suspect it dates back to ancient versions. I also doubt any modern (made in the past 20 years) non-arcane compiler, commercial or open source, lacks such optimization. I would test on other compilers, but I don't have any available at the moment.  

If anyone else would care to test other compilers and/or platform targets, and gets a different result, I'd be very interested to know.  

Finally, the modulo version is <strong>guaranteed</strong> by the standard to work whether the integer is positive, negative or zero, regardless of the implementation's representation of signed integers. The bitwise-and version is not. Yes, I realise two's complement is somewhat ubiquitous, so this is not really an issue.  

#### Answer 2 (score 208)
You guys are waaaaaaaay too efficient. What you really want is:  

```c
public boolean isOdd(int num) {
  int i = 0;
  boolean odd = false;

  while (i != num) {
    odd = !odd;
    i = i + 1;
  }

  return odd;
}
```

Repeat for `isEven`.  

Of course, that doesn't work for negative numbers. But with brilliance comes sacrifice...  

#### Answer 3 (score 97)
Use bit arithmetic:  

```c
if((x & 1) == 0)
    printf("EVEN!\n");
else
    printf("ODD!\n");
```

This is faster than using division or modulus.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Difference between "while" loop and "do while" loop (score [349762](https://stackoverflow.com/q/3625759) in 2010)

#### Question
What is the difference between while loop and do while loop. I used to think both are completely same.Then I came across following piece of code :  

```c
do {
        printf("Word length... ");
        scanf("%d", &wdlen);
    } while(wdlen<2);
```

This code works perfectly. It prints word length and tascans the input. But when I changed it to  

```c
while(wdlen<2){
        printf("Word length... ");
        scanf("%d", &wdlen);
    } 
```

It gives a blank screen. It do not work. So there is some functional difference between both loops. Can anybody explain it? Thanks in advance.  

EDIT : Is there any other difference in these two ?  

#### Answer accepted (score 57)
The <strong>do while</strong> loop executes the content of the loop once before checking the condition of the while.   

Whereas a <strong>while</strong> loop will check the condition first before executing the content.  

In this case you are waiting for user input with scanf(), which will never execute in the <strong>while</strong> loop as wdlen is not initialized and may just contain a garbage value which may be greater than 2.  

#### Answer 2 (score 18)
<strong>While</strong> : your condition is at the begin of the loop block, and makes possible <em>to never enter the loop</em>.  

<strong>Do While</strong> : your condition is at the end of the loop block, and makes obligatory <em>to enter the loop at least one time</em>.  

#### Answer 3 (score 3)
```c
do {
    printf("Word length... ");
    scanf("%d", &wdlen);
} while(wdlen<2);
```

A `do-while` loop guarantees the execution of the loop at least once because it checks the loop condition AFTER the loop iteration. Therefore it'll print the string and call scanf, thus updating the wdlen variable.  

```c
while(wdlen<2){
    printf("Word length... ");
    scanf("%d", &wdlen);
} 
```

As for the `while` loop, it evaluates the loop condition BEFORE the loop body is executed. `wdlen` probably starts off as more than 2 in your code that's why you never reach the loop body.  
</section>

