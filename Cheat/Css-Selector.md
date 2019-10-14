---
title: Css tests
category: Css
css: ../Css/layout_radio.css
---






<script>
function disableAll () {
    document
      .querySelectorAll('link[rel=stylesheet].alternate')
      .forEach(function (node) {node.disabled = true;} );
}

// If press css: color | layout button
function onRadioCss(check, id) {
    var style = document.createElement('link');
    style.rel  = 'stylesheet';
    style.type = 'text/css';
    style.disabled = true;
    style.class = 'alterante';
    style.media = 'all';
    style.id = id;
    style.href = id + '.css';
    document.body.appendChild(style);
  
    var css = document.getElementById(id);
    console.log('Css ', id, 'is ', check.checked);
    if (check.checked == true){
      css.disabled = false;
    } else {
      css.disabled = true;
    }
}

// If press font button
function onRadioFont(check, id){
    console.log('Font ', id, 'is ', check.checked);
  
    if (check.checked == false){
      return;
    }
      
    // TODO suffix by cursive
    var font_url = "https://fonts.googleapis.com/css?family=";
    font_url += id.replace(/ /g, "+") + "&display=swap";
    console.log('Font url', font_url);
    var link = document.createElement('link');
    link.rel  = 'stylesheet';
    link.href = font_url;
    document.head.appendChild(link);
  
    // Body choose font
    document.body.style.fontFamily = id;
}



function addStylesheet(parent, id, onRadioCallback) {
    // Create stylesheet
    if (onRadioCallback == onRadioCss) {
    }
    
    // Create clickable link
    // 1/ Label
    var label = document.createElement('label');
    label.textContent = id;
    label.className = "radio";
    // 2/ Input
    var input = document.createElement('input');
    input.type = 'checkbox';
    input.onchange = function () { onRadioCallback(this, id); };
    // 3 Span
    var span = document.createElement('span');
    span.className = 'checkmark';
    
    // Append
    label.appendChild(input);
    label.appendChild(span);
    parent.appendChild(document.createElement("br"));
    parent.appendChild(label)
  
}

// Fill radio button: Define lists
function start() {
    // Fill color
    var div_color = document.getElementById('div_color');
    var a_color = [
        '../Css/color_dark_blue_striking_and_simple',
        '../Css/color_light_solarized',
        '../Css/color_dark_solarized',
        '../Css/color_dark_jason23',
    ];
    a_color.forEach(function (item, index) {
        console.log('Color: ', item, index);
        addStylesheet(div_color, item, onRadioCss);
    });
  
    // Fill layout
    var div_layout = document.getElementById('div_layout');
    var a_layout = [
        '../Css/layout_grid',
        '../Css/layout_solarized',
    ];
    a_layout.forEach(function (item, index) {
        console.log('Layout: ', item, index);
        addStylesheet(div_layout, item, onRadioCss);
    });
    
    //Fill font
    var div_font = document.getElementById('div_font');
    var a_font = [
       'Ubuntu', 
       'Arial',
      
       'Monotone',
       'Alegreya',
       'Tangerine',
       'Liu Jian Mao Cao',
       'IBM Plex Serif',
       'Yatra One',
       'Source Sans Pro',
    ];
    a_font.forEach(function (item, index) {
        console.log('Font: ', item, index);
        addStylesheet(div_font, item, onRadioFont);
    });
}

window.onload = start

</script>

  <link href="https://fonts.googleapis.com/css?family=Monoton&display=swap" rel="stylesheet"> 

<div id='div_color' style='width:400px; float:left;'>
 <h2>Color</h2>
</div>

<div id='div_layout' style='width:400px; float:left; overflow:hidden;'>
 <h2>Layout</h2>
</div>
  
<div id='div_font' style='width:400px; float:left; overflow:hidden;'>
 <h2>Font</h2>
</div>

<div id='div_clear' style='clear:both;'> </div>
  


# Start test

This tutorial provides a brief information on all 32 keywords in C programming.  


|          |          |          |        |
| ---      | ---      | ---      | ---    |
| auto     | break    | case     | char   |
| const    | continue | default  | do     |
| double   | else     | enum     | extern |
| float    | for      | goto     | if     |
| int      | long     | register | return |
| short    | signed   | sizeof   | static |
| struct   | switch   | typedef  | union  |
| unsigned | void     | volatile | while  |


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


### Colors 
* Protanopia
* Dueteranopia
* Tritanopia
* Achromatopsia

### []{#auto}auto

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

### []{#break_continue}break and continue

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

### []{#switch_case_default}switch, case and default

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

### []{#char}char

The char keyword declares a character variable. For example:

```C
char alphabet;
```

Here, alphabet is a character type variable.

To learn more, visit [C data
types](/c-programming/c-data-types "C data types").

------------------------------------------------------------------------

### []{#const}const

An identifier can be declared constant by using const keyword.

    const int a = 5;

To learn more, visit[C variables and
constants](/c-programming/c-variables-constants "C programming variables and constants").

------------------------------------------------------------------------

### []{#do_while}do...while

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

### []{#double_float}double and float

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

### []{#if_else}if and else

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

### []{#enum}enum

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

### []{#extern}extern

The extern keyword declares that a variable or a function has external
linkage outside of the file it is declared.

To learn more, visit [C storage
type](/c-programming/c-storage-class "C storage type").

------------------------------------------------------------------------

### []{#for}for

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

### []{#goto}goto

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

### []{#int}int

The int keyword declares integer type variable. For example:

    int count;

Here, count is a integer variable.

To learn more, visit [C data
types](/c-programming/c-data-types "C data types").

------------------------------------------------------------------------

### []{#short_long_signed_unsigned}short, long, signed and unsigned

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

### []{#return}return

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

### []{#sizeof}sizeof

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

### []{#register}register

The register keyword creates register variables which are much faster
than normal variables.

```C
register int var1;
```

------------------------------------------------------------------------

### []{#static}static

The static keyword creates static variable. The value of the static
variables persists until the end of the program. For example:

```C
static int var;
```

------------------------------------------------------------------------

### []{#struct}struct

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

### []{#typedef}typedef

The typedef keyword is used to explicitly associate a type with an
identifier.

```C
typedef float kg;
kg bear, tiger;
```

------------------------------------------------------------------------

### []{#union}union

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

### []{#void}void

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

### []{#volatile}volatile

The volatile keyword is used for creating volatile objects. A volatile
object can be modified in an unspecified way by the hardware.

    const volatile number

Here, number is a volatile object.

Since, number is a constant variable, the program cannot change it.
However, hardware can change it since it is a volatile object.

--------------------------------------------------------------------------------
Donloaded from : https://www.programiz.com/c-programming/list-all-keywords-c-language  
