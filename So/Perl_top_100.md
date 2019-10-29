---
title: Perl <- StackOverflow top 100
category: Perl
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: Find size of an array in Perl (score [559516](https://stackoverflow.com/q/7406807) in 2015)

#### Question
I seem to have come across several different ways to find the size of an array. What is the difference between these three methods?  

```perl
my @arr = (2);
print scalar @arr; # First way to print array size

print $#arr; # Second way to print array size

my $arrSize = @arr;
print $arrSize; # Third way to print array size
```

#### Answer accepted (score 228)
The first and third ways are the same: they evaluate an array in scalar context. I would consider this to be the standard way to get an array's size.  

The second way actually returns the last index of the array, which is not (usually) the same as the array size.  

#### Answer 2 (score 40)
First, the second is not equivalent to the other two. `$#array` returns the last index of the array, which is one less than the size of the array.  

The other two are virtually the same. You are simply using two different means to create scalar context. It comes down to a question of readability.  

I personally prefer the following:  

```perl
say 0+@array;          # Represent @array as a number
```

I find it clearer than  

```perl
say scalar(@array);    # Represent @array as a scalar
```

and  

```perl
my $size = @array;
say $size;
```

The latter looks quite clear alone like this, but I find that the extra line takes away from clarity when part of other code. It's useful for teaching what `@array` does in scalar context, and maybe if you want to use `$size` more than once.  

#### Answer 3 (score 27)
This gets the size by forcing the array into a scalar context, in which it is evaluated as its size:  

```perl
print scalar @arr;
```

This is another way of forcing the array into a scalar context, since it's being assigned to a scalar variable:  

```perl
my $arrSize = @arr;
```

This gets the index of the last element in the array, so it's actually the size minus 1 (assuming indexes start at 0, which is adjustable in Perl although doing so is usually a bad idea):  

```perl
print $#arr;
```

This last one isn't really good to use for getting the array size. It would be useful if you just want to get the last element of the array:  

```perl
my $lastElement = $arr[$#arr];
```

Also, as you can see here on Stack&nbsp;Overflow, this construct isn't handled correctly by most syntax highlighters...  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How do I break out of a loop in Perl? (score [547733](https://stackoverflow.com/q/303216) in 2014)

#### Question
I'm trying to use a `break` statement in a `for` loop, but since I'm also using strict subs in my Perl code, I'm getting an error saying:  

<blockquote>
  <p>Bareword "break" not allowed while
  "strict subs" in use at ./final.pl
  line 154.</p>
</blockquote>

Is there a workaround for this (besides disabling strict subs)?  

My code is formatted as follows:  

```perl
for my $entry (@array){
    if ($string eq "text"){
         break;
    }
}
```

#### Answer accepted (score 425)
Oh, I found it.  You use <a href="http://perldoc.perl.org/functions/last.html" rel="noreferrer">last</a> instead of <a href="https://perldoc.perl.org/functions/break.html" rel="noreferrer">break</a>  

```perl
for my $entry (@array){
    if ($string eq "text"){
         last;
    }
}
```

#### Answer 2 (score 174)
Additional data (in case you have more questions):  

```perl
FOO: {
       for my $i ( @listone ){
          for my $j ( @listtwo ){
                 if ( cond( $i,$j ) ){

                    last FOO;  # --->
                                   # |
                 }                 # |
          }                        # |
       }                           # |
 } # <-------------------------------
```

#### Answer 3 (score 17)
Simply `last` would work here:  

```perl
for my $entry (@array){
    if ($string eq "text"){
         last;
    }
}
```

If you have nested loops, then `last` will exit from the innermost. Use labels in this case:  

```perl
LBL_SCORE: {
       for my $entry1 ( @array1 ){
          for my $entry2 ( @array2 ){
                 if ( $entry1 eq $entry2 ){   # or any condition
                    last LBL_SCORE;
                 }
          }
       }
 }
```

Given `last` statement will make compiler to come out from both the loops. Same can be done in any number of loops, and labels can be fixed anywhere.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How to fix a locale setting warning from Perl? (score [488557](https://stackoverflow.com/q/2499794) in 2016)

#### Question
When I run `perl`, I get the warning:  

<pre>perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
    LANGUAGE = (unset),
    LC_ALL = (unset),
    LANG = "en_US.UTF-8"
are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").</pre>

How do I fix it?  

#### Answer accepted (score 419)
Your OS doesn't know about `en_US.UTF-8`.  

You didn't mention a specific platform, but I can reproduce your problem:  

<pre>% uname -a
OSF1 hunter2 V5.1 2650 alpha
% perl -e exit
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
    LC_ALL = (unset),
    LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").</pre>

My guess is you used ssh to connect to this older host from a newer desktop machine. It's common for `/etc/ssh/sshd_config` to contain  

```perl
AcceptEnv LANG LC_*
```

which allows clients to propagate the values of those environment variables into new sessions.  

The warning gives you a hint about how to squelch it if you don't require the full-up locale:  

<pre>% env LANG=C perl -e exit
%</pre>

or with bash:  

<pre>$ LANG=C perl -e exit
$ </pre>

For a permanent fix, choose one of  

<ol>
<li>On the older host, set the `LANG` environment variable in your shell's initialization file.</li>
<li>Modify your environment on the client side, <em>e.g.</em>, rather than `ssh hunter2`, use the command `LANG=C ssh hunter2`.</li>
<li>If you have admin rights, stop ssh from sending the environment variables by commenting out the `SendEnv LANG LC_*` line in the <em>local</em> `/etc/ssh/ssh_config` file. (Thanks to <a href="https://askubuntu.com/questions/144235/locale-variables-have-no-effect-in-remote-shell-perl-warning-setting-locale-f/144448#144448">this answer</a>. See <a href="https://bugzilla.mindrot.org/show_bug.cgi?id=1285#c2" rel="noreferrer">Bug 1285</a> for OpenSSH for more.)</li>
</ol>

#### Answer 2 (score 454)
Here is how to solve it on Mac OS Lion (10.7) or Cygwin (Windows 10):   

Add the following lines to your bashrc or bash_profile on the host machine:  

```perl
# Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

If you are using zsh, edit zshrc:  

```perl
# Setting for the new UTF-8 terminal support in Lion
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8
```

#### Answer 3 (score 194)
If you are creating a rootfs using debootstrap you will need to generate the locales.  You can do this by running:  

```perl
# (optional) enable missing locales
sudo nano /etc/locale.gen

# then regenerate
sudo locale-gen
```

This tip comes from, <a href="https://help.ubuntu.com/community/Xen" rel="noreferrer">https://help.ubuntu.com/community/Xen</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How can I check if a Perl array contains a particular value? (score [389390](https://stackoverflow.com/q/2860226) in 2010)

#### Question
I am trying to figure out a way of checking for the existence of a value in an array without iterating through the array.  

I am reading a file for a parameter.  I have a long list of parameters I do not want to deal with. I placed these unwanted parameters in an array `@badparams`.  

I want to read a new parameter and if it does not exist in `@badparams`, process it. If it does exist in `@badparams`, go to the next read.  

#### Answer accepted (score 181)
Simply turn the array into a hash:  

```perl
my %params = map { $_ => 1 } @badparams;

if(exists($params{$someparam})) { ... }
```

You can also add more (unique) params to the list:  

```perl
$params{$newparam} = 1;
```

And later get a list of (unique) params back:  

```perl
@badparams = keys %params;
```

#### Answer 2 (score 211)
Best general purpose - Especially short arrays (1000 items or less) and coders that are unsure of what optimizations best suit their needs.  

```perl
# $value can be any regex. be safe
if ( grep( /^$value$/, @array ) ) {
  print "found it";
}
```

It has been mentioned that grep passes through all values even if the first value in the array matches.  This is true, however <b>grep is still extremely fast for most cases</b>.  If you're talking about short arrays (less than 1000 items) then most algorithms are going to be pretty fast anyway.  If you're talking about very long arrays (1,000,000 items) grep is acceptably quick regardless of whether the item is the first or the middle or last in the array.  

<b>Optimization Cases for longer arrays:</b>  

<b>If your array is sorted</b>, use a "binary search".  

If the <b>same array is repeatedly searched</b> many times, copy it into a hash first and then check the hash.  If memory is a concern, then move each item from the array into the hash. More memory efficient but destroys the original array.  

If <b>same values are searched repeatedly</b> within the array, lazily build a cache. (as each item is searched, first check if the search result was stored in a persisted hash. if the search result is not found in the hash, then search the array and put the result in the persisted hash so that next time we'll find it in the hash and skip the search).  

Note: these optimizations will only be faster when dealing with long arrays.  Don't over optimize.  

#### Answer 3 (score 117)
You can use smartmatch feature in <em>Perl 5.10</em> as follows:  

For literal value lookup doing below will do the trick.  

```perl
if ( "value" ~~ @array ) 
```

For scalar lookup, doing below will work as above.  

```perl
if ($val ~~ @array)
```

For inline array doing below, will work as above.  

```perl
if ( $var ~~ ['bar', 'value', 'foo'] ) 
```

In <em>Perl 5.18</em> smartmatch is flagged as experimental therefore you need to turn off the warnings by turning on <a href="https://metacpan.org/pod/experimental">experimental</a> pragma by adding below to your script/module:  

```perl
use experimental 'smartmatch';
```

Alternatively if you want to avoid the use of smartmatch - then as Aaron said use:  

```perl
if ( grep( /^$value$/, @array ) ) {
  #TODO:
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: How do I compare two strings in Perl? (score [361902](https://stackoverflow.com/q/1175390) in 2009)

#### Question
How do I compare two strings in Perl?  

I am learning Perl, I had this basic question looked it up here on StackOverflow and found no good answer so I thought I would ask.  

#### Answer accepted (score 172)
See <a href="https://metacpan.org/pod/perlop#Equality-Operators" rel="noreferrer">perldoc perlop</a>. Use `lt`, `gt`, `eq`, `ne`, and `cmp` as appropriate for string comparisons:  

<blockquote>
  Binary `eq` returns true if the left argument is stringwise equal to the right argument.  
  
  Binary `ne` returns true if the left argument is stringwise not equal to the right argument.  
  
  Binary `cmp` returns -1, 0, or 1 depending on whether the left argument is stringwise less than, equal to, or greater than the right argument.  
  
  Binary `~~` does a smartmatch between its arguments. ...  
  
  `lt`, `le`, `ge`, `gt` and `cmp` use the collation (sort) order specified by the current locale if a legacy use locale (but not `use locale ':not_characters'`) is in effect. See <a href="https://metacpan.org/pod/perllocale" rel="noreferrer">perllocale</a>. Do not mix these with Unicode, only with legacy binary encodings. The standard <a href="https://metacpan.org/pod/Unicode::Collate" rel="noreferrer">Unicode::Collate</a> and <a href="https://metacpan.org/pod/Unicode::Collate::Locale" rel="noreferrer">Unicode::Collate::Locale</a> modules offer much more powerful solutions to collation issues.  
</blockquote>

#### Answer 2 (score 132)
<ul>
<li><p>`cmp` Compare</p>

```perl
'a' cmp 'b' # -1
'b' cmp 'a' #  1
'a' cmp 'a' #  0
```</li>
<li><p>`eq` Equal to</p>

```perl
'a' eq  'b' #  0
'b' eq  'a' #  0
'a' eq  'a' #  1
```</li>
<li><p>`ne` Not-Equal to</p>

```perl
'a' ne  'b' #  1
'b' ne  'a' #  1
'a' ne  'a' #  0
```</li>
<li><p>`lt` Less than</p>

```perl
'a' lt  'b' #  1
'b' lt  'a' #  0
'a' lt  'a' #  0
```</li>
<li><p>`le` Less than or equal to</p>

```perl
'a' le  'b' #  1
'b' le  'a' #  0
'a' le  'a' #  1
```</li>
<li><p>`gt` Greater than</p>

```perl
'a' gt  'b' #  0
'b' gt  'a' #  1
'a' gt  'a' #  0
```</li>
<li><p>`ge` Greater than or equal to</p>

```perl
'a' ge  'b' #  0
'b' ge  'a' #  1
'a' ge  'a' #  1
```</li>
</ul>

See <a href="http://perldoc.perl.org/perlop.html#Equality-Operators" rel="noreferrer">`perldoc perlop`</a> for more information.  

( I'm simplifying this a little bit as all but `cmp` return a value that is both an empty string, and a numerically zero value instead of `0`, and a value that is both the string `'1'` and the numeric value `1`. These are the same values you will always get from boolean operators in Perl. You should really only be using the return values for boolean or numeric operations, in which case the difference doesn't really matter. )  

#### Answer 3 (score 17)
In addtion to Sinan Ünür comprehensive listing of string comparison operators, Perl 5.10 adds the smart match operator.  

The smart match operator compares two items based on their type.  See the chart below for the 5.10 behavior (I believe this behavior is changing slightly in 5.10.1):  

<h5><a href="http://perldoc.perl.org/perlsyn.html#Smart-matching-in-detail" rel="noreferrer">`perldoc perlsyn` "Smart matching in detail"</a>:</h3>

<blockquote><p>
The behaviour of a smart match depends on what type of thing its arguments are. It is always commutative, i.e. `$a ~~ $b` behaves the same as `$b ~~ $a` . The behaviour is determined by the following table: the first row that applies, in either order, determines the match behaviour.

<pre>
  $a      $b        Type of Match Implied    Matching Code
  ======  =====     =====================    =============
  (overloading trumps everything)

  Code[+] Code[+]   referential equality     $a == $b   
  Any     Code[+]   scalar sub truth         $b−>($a)   

  Hash    Hash      hash keys identical      [sort keys %$a]~~[sort keys %$b]
  Hash    Array     hash slice existence     grep {exists $a−>{$_}} @$b
  Hash    Regex     hash key grep            grep /$b/, keys %$a
  Hash    Any       hash entry existence     exists $a−>{$b}

  Array   Array     arrays are identical[*]
  Array   Regex     array grep               grep /$b/, @$a
  Array   Num       array contains number    grep $_ == $b, @$a 
  Array   Any       array contains string    grep $_ eq $b, @$a 

  Any     undef     undefined                !defined $a
  Any     Regex     pattern match            $a =~ /$b/ 
  Code()  Code()    results are equal        $a−>() eq $b−>()
  Any     Code()    simple closure truth     $b−>() # ignoring $a
  Num     numish[!] numeric equality         $a == $b   
  Any     Str       string equality          $a eq $b   
  Any     Num       numeric equality         $a == $b   

  Any     Any       string equality          $a eq $b   

+ − this must be a code reference whose prototype (if present) is not ""
(subs with a "" prototype are dealt with by the 'Code()' entry lower down) 
* − that is, each element matches the element of same index in the other
array. If a circular reference is found, we fall back to referential 
equality.   
! − either a real number, or a string that looks like a number
</pre>

The "matching code" doesn't represent the real matching code, of course: it's just there to explain the intended meaning. Unlike grep, the smart match operator will short-circuit whenever it can.

Custom matching via overloading
You can change the way that an object is matched by overloading the `~~` operator. This trumps the usual smart match semantics. See <a href="http://perldoc.perl.org/overload.html" rel="noreferrer">`overload`</a>.

</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: How can I pass command-line arguments to a Perl program? (score [338119](https://stackoverflow.com/q/361752) in 2012)

#### Question
I'm working on a Perl script. How can I pass command line parameters to it?  

Example:  

```perl
script.pl "string1" "string2"
```

#### Answer accepted (score 188)
Depends on what you want to do. If you want to use the two arguments as input files, you can just pass them in and then use `&lt;&gt;` to read their contents.  

If they have a different meaning, you can use `GetOpt::Std` and `GetOpt::Long` to process them easily. `GetOpt::Std` supports only single-character switches and `GetOpt::Long` is much more flexible. From <a href="http://perldoc.perl.org/Getopt/Long.html" rel="noreferrer">`GetOpt::Long`</a>:   

```perl
use Getopt::Long;
my $data   = "file.dat";
my $length = 24;
my $verbose;
$result = GetOptions ("length=i" => \$length,    # numeric
                    "file=s"   => \$data,      # string
                    "verbose"  => \$verbose);  # flag
```

Alternatively, `@ARGV` is a special variable that contains all the command line arguments. `$ARGV[0]` is the first (ie. `"string1"` in your case) and `$ARGV[1]` is the second argument. You don't need a special module to access `@ARGV`.  

#### Answer 2 (score 60)
You pass them in just like you're thinking, and in your script, you get them from the array `@ARGV`.  Like so:  

```perl
my $numArgs = $#ARGV + 1;
print "thanks, you gave me $numArgs command-line arguments.\n";

foreach my $argnum (0 .. $#ARGV) {

   print "$ARGV[$argnum]\n";

}
```

From <a href="http://www.devdaily.com/perl/edu/qanda/plqa00001.shtml" rel="noreferrer">here</a>.  

#### Answer 3 (score 29)
```perl
foreach my $arg (@ARGV) {
    print $arg, "\n";
}
```

will print each argument.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: How do you round a floating point number in Perl? (score [322891](https://stackoverflow.com/q/178539) in 2008)

#### Question
How can I round a decimal number (floating point) to the nearest integer?   

e.g.  

```perl
1.2 = 1
1.7 = 2
```

#### Answer accepted (score 192)
Output of <a href="http://perldoc.perl.org/perlfaq4.html#Does-Perl-have-a-round%28)-function%3f--What-about-ceil()-and-floor()%3f--Trig-functions%3f" rel="noreferrer">`perldoc -q round`</a>  

<blockquote>
Does Perl have a round() function?  What about ceil() and floor()?
Trig functions?

Remember that <a href="http://perldoc.perl.org/functions/int.html" rel="noreferrer">`int()`</a> merely truncates toward `0`.  For rounding to a certain number of digits, <a href="http://perldoc.perl.org/functions/sprintf.html" rel="noreferrer">`sprintf()`</a> or <a href="http://perldoc.perl.org/functions/printf.html" rel="noreferrer">`printf()`</a> is usually the easiest
route.

```perl
    printf("%.3f", 3.1415926535);       # prints 3.142
```

The <a href="http://perldoc.perl.org/POSIX.html" rel="noreferrer">`POSIX`</a> module (part of the standard Perl distribution) implements
`ceil()`, `floor()`, and a number of other mathematical and trigonometric
functions.

```perl
    use POSIX;
    $ceil   = ceil(3.5);                        # 4
    $floor  = floor(3.5);                       # 3
```

In 5.000 to 5.003 perls, trigonometry was done in the <a href="http://perldoc.perl.org/Math/Complex.html" rel="noreferrer">`Math::Complex`</a>
module.  With 5.004, the <a href="http://perldoc.perl.org/Math/Trig.html" rel="noreferrer">`Math::Trig`</a> module (part of the standard Perl
distribution) implements the trigonometric functions. Internally it
uses the <a href="http://perldoc.perl.org/Math/Complex.html" rel="noreferrer">`Math::Complex`</a> module and some functions can break out from the
real axis into the complex plane, for example the inverse sine of 2.

Rounding in financial applications can have serious implications, and
the rounding method used should be specified precisely.  In these
cases, it probably pays not to trust whichever system rounding is being
used by Perl, but to instead implement the rounding function you need
yourself.

To see why, notice how you'll still have an issue on half-way-point
alternation:

```perl
    for ($i = 0; $i < 1.01; $i += 0.05) { printf "%.1f ",$i}

    0.0 0.1 0.1 0.2 0.2 0.2 0.3 0.3 0.4 0.4 0.5 0.5 0.6 0.7 0.7
    0.8 0.8 0.9 0.9 1.0 1.0
```

Don't blame Perl.  It's the same as in C.  IEEE says we have to do
this.  Perl numbers whose absolute values are integers under `2**31` (on
32 bit machines) will work pretty much like mathematical integers.
Other numbers are not guaranteed.

</blockquote>

#### Answer 2 (score 127)
Whilst not disagreeing with the complex answers about half-way marks and so on, for the more common (and possibly trivial) use-case:  

`my $rounded = int($float + 0.5);`  

<strong>UPDATE</strong>  

If it's possible for your `$float` to be negative, the following variation will produce the correct result:  

`my $rounded = int($float + $float/abs($float*2 || 1));`  

With this calculation -1.4 is rounded to -1, and -1.6 to -2, and zero won't explode.  

#### Answer 3 (score 71)
You can either use a module like <A href="http://search.cpan.org/dist/Math-Round" rel="noreferrer">Math::Round</a>:  

```perl
use Math::Round;
my $rounded = round( $float );
```

Or you can do it the crude way:  

```perl
my $rounded = sprintf "%.0f", $float;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: How can I print the contents of a hash in Perl? (score [306215](https://stackoverflow.com/q/1162245) in 2016)

#### Question
<p>I keep printing my hash as # of buckets / # allocated.
How do I print the contents of my hash? </p>

Without using a `while` loop would be most preferable (for example, a <a href="https://en.wikipedia.org/wiki/One-liner_program" rel="noreferrer">one-liner</a> would be best).  

#### Answer 2 (score 240)
<a href="http://perldoc.perl.org/Data/Dumper.html" rel="noreferrer">Data::Dumper</a> is your friend.  

```perl
use Data::Dumper;
my %hash = ('abc' => 123, 'def' => [4,5,6]);
print Dumper(\%hash);
```

will output  

```perl
$VAR1 = {
          'def' => [
                     4,
                     5,
                     6
                   ],
          'abc' => 123
        };
```

#### Answer 3 (score 60)
Easy:   

```perl
print "$_ $h{$_}\n" for (keys %h);
```

Elegant, but actually 30% slower (!):  

```perl
while (my ($k,$v)=each %h){print "$k $v\n"}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: Check whether a string contains a substring (score [302935](https://stackoverflow.com/q/7283274) in 2017)

#### Question
How can I check whether a given string contains a certain substring, using Perl?  

More specifically, I want to see whether `s1.domain.com` is present in the given string variable.  

#### Answer accepted (score 219)
To find out if a string contains substring you can use the <a href="http://perldoc.perl.org/functions/index.html" rel="noreferrer">`index`</a> function:  

```perl
if (index($str, $substr) != -1) {
    print "$str contains $substr\n";
} 
```

It will return the position of the first occurrence of `$substr` in `$str`, or -1 if the substring is not found.  

#### Answer 2 (score 54)
Another possibility is to use <a href="http://perldoc.perl.org/perlre.html" rel="noreferrer">regular expressions</a> which is what Perl is famous for:  

```perl
if ($mystring =~ /s1\.domain\.com/) {
   print qq("$mystring" contains "s1.domain.com"\n);
}
```

The backslashes are needed because a `.` can match any character. You can get around this by using the `\Q` and `\E` operators.  

```perl
my $substring = "s1.domain.com";
    if ($mystring =~ /\Q$substring\E/) {
   print qq("$mystring" contains "$substring"\n);
}
```

<p>Or, you can do as <a href="https://stackoverflow.com/users/244297/eugene-y">eugene y</a> stated and use the <a href="http://perldoc.perl.org/functions/index.html" rel="noreferrer">index</a> function. 
Just a word of warning: Index returns a `-1` when it can't find a match instead of an `undef` or `0`.</p>

Thus, this is an error:  

```perl
my $substring = "s1.domain.com";
if (not index($mystring, $substr)) {
    print qq("$mystring" doesn't contains "$substring"\n";
} 
```

This will be wrong if `s1.domain.com` is at the beginning of your string. I've personally been burned on this more than once.  

#### Answer 3 (score 14)
<strong>Case Insensitive Substring Example</strong>  

This is an extension of Eugene's answer, which converts the strings to lower case before checking for the substring:  

```perl
if (index(lc($str), lc($substr)) != -1) {
    print "$str contains $substr\n";
} 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: String compare in Perl with "eq" vs "==" (score [301040](https://stackoverflow.com/q/14046669) in 2016)

#### Question
I am (a complete Perl newbie) doing string compare in an `if` statement:  

If I do following:  

```perl
if ($str1 == "taste" && $str2 == "waste") { }
```

I see the correct result (i.e. if the condition matches, it evaluates the "then" block). But I see these warnings:  

<blockquote>
  <p>Argument "taste" isn't numeric in numeric eq (==) at line number x. <br/>
  Argument "waste" isn't numeric in numeric eq (==) at line number x.</p>
</blockquote>

But if I do:  

```perl
if ($str1 eq "taste" && $str2 eq "waste") { }
```

Even if the if condition is satisfied, it doesn't evaluate the "then" block.  

Here, `$str1` is `taste` and `$str2` is `waste`.  

How should I fix this?  

#### Answer accepted (score 104)
First, <strong>eq</strong> is for comparing strings; <strong>==</strong> is for comparing numbers.  

<blockquote>
  Even if the "if" condition is satisfied, it doesn't evaluate the "then" block.  
</blockquote>

I think your problem is that your variables don't contain what you think they do. I think your `$str1` or `$str2` contains something like "taste\n" or so. Check them by printing before your <strong>if</strong>: `print "str1='$str1'\n";`.  

The trailing newline can be removed with the `chomp($str1);` function.  

#### Answer 2 (score 28)
`==` does a numeric comparison: it converts both arguments to a number and then compares them.  As long as `$str1` and `$str2` both evaluate to 0 as numbers, the condition will be satisfied.  

`eq` does a string comparison: the two arguments must match lexically (case-sensitive) for the condition to be satisfied.  

```perl
"foo" == "bar";   # True, both strings evaluate to 0.
"foo" eq "bar";   # False, the strings are not equivalent.
"Foo" eq "foo";   # False, the F characters are different cases.
"foo" eq "foo";   # True, both strings match exactly.
```

#### Answer 3 (score 5)
Did you try to chomp the `$str1` and `$str2`?  

I found a similar issue with using (another) `$str1` eq 'Y' and it only went away when I first did:  

```perl
chomp($str1);
if ($str1 eq 'Y') {
....
}
```

works after that.   

Hope that helps.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: Perl read line by line (score [273520](https://stackoverflow.com/q/4505381) in 2012)

#### Question
I have a simple Perl script to read a file line by line. Code is below. I want to display two lines and break the loop. But it doesn't work. Where is the bug?  

```perl
$file='SnPmaster.txt';
open(INFO, $file) or die("Could not open  file.");

$count = 0; 
foreach $line (<INFO>)  {   
    print $line;    
    if ($++counter == 2){
      last;
    }
}
close(INFO);
```

#### Answer accepted (score 118)
If you had `use strict` turned on, you would have found out that `$++foo` doesn't make any sense.   

Here's how to do it:  

```perl
use strict;
use warnings;

my $file = 'SnPmaster.txt';
open my $info, $file or die "Could not open $file: $!";

while( my $line = <$info>)  {   
    print $line;    
    last if $. == 2;
}

close $info;
```

This takes advantage of the special variable `$.` which keeps track of the line number in the current file. (See <a href="http://perldoc.perl.org/perlvar.html" rel="noreferrer">perlvar</a>)  

If you want to use a counter instead, use  

```perl
my $count = 0;
while( my $line = <$info>)  {   
    print $line;    
    last if ++$count == 2;
}
```

#### Answer 2 (score 12)
With these types of complex programs, it's better to let Perl generate the Perl code for you:  

```perl
$ perl -MO=Deparse -pe'exit if $.>2'
```

Which will gladly tell you the answer,  

```perl
LINE: while (defined($_ = <ARGV>)) {
    exit if $. > 2;
}
continue {
    die "-p destination: $!\n" unless print $_;
}
```

Alternatively, you can simply run it as such from the command line,  

```perl
$ perl -pe'exit if$.>2' file.txt
```

#### Answer 3 (score 5)
you need to use `++$counter`, <em>not</em> `$++counter`, hence the reason it isn't working..    

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How can I check if a file exists in Perl? (score [269401](https://stackoverflow.com/q/2601027) in 2013)

#### Question
I have a relative path   

```perl
   $base_path = "input/myMock.TGZ";
```

<p>`myMock.TGZ` is the file name located in input folder.
The filename can change. But the path is always stored in `$base_path`.</p>

I need to check if the file exists in `$base_path`.  

#### Answer accepted (score 170)
Test whether <em>something</em> exists at given path using the `-e` file-test operator.  

```perl
print "$base_path exists!\n" if -e $base_path;
```

However, this test is probably broader than you intend. The code above will generate output if a plain file exists at that path, but it will also fire for a directory, a named pipe, a symlink, or a more exotic possibility. <a href="http://perldoc.perl.org/functions/-X.html" rel="noreferrer">See the documentation</a> for details.  

Given the extension of `.TGZ` in your question, it seems that you expect a <em>plain file</em> rather than the alternatives. The `-f` file-test operator asks whether a path leads to a plain file.  

```perl
print "$base_path is a plain file!\n" if -f $base_path;
```

The perlfunc documentation covers the long list of <a href="http://perldoc.perl.org/functions/-X.html" rel="noreferrer">Perl's file-test operators</a> that covers many situations you will encounter in practice.  

<blockquote>
  <ul>
  <li><strong>`-r`</strong><br>
  File is readable by effective uid/gid.</li>
  <li><strong>`-w`</strong><br>
  File is writable by effective uid/gid.</li>
  <li><strong>`-x`</strong><br>
  File is executable by effective uid/gid.</li>
  <li><strong>`-o`</strong><br>
  File is owned by effective uid.</li>
  <li><strong>`-R`</strong><br>
  File is readable by real uid/gid.</li>
  <li><strong>`-W`</strong><br>
  File is writable by real uid/gid.</li>
  <li><strong>`-X`</strong><br>
  File is executable by real uid/gid.</li>
  <li><strong>`-O`</strong><br>
  File is owned by real uid.</li>
  <li><strong>`-e`</strong><br>
  File exists.</li>
  <li><strong>`-z`</strong><br>
  File has zero size (is empty).</li>
  <li><strong>`-s`</strong><br>
  File has nonzero size (returns size in bytes).</li>
  <li><strong>`-f`</strong><br>
  File is a plain file.</li>
  <li><strong>`-d`</strong><br>
  File is a directory.</li>
  <li><strong>`-l`</strong><br>
  File is a symbolic link (false if symlinks aren’t supported by the file system).</li>
  <li><strong>`-p`</strong><br>
  File is a named pipe (FIFO), or Filehandle is a pipe.</li>
  <li><strong>`-S`</strong><br>
  File is a socket.</li>
  <li><strong>`-b`</strong><br>
  File is a block special file.</li>
  <li><strong>`-c`</strong><br>
  File is a character special file.</li>
  <li><strong>`-t`</strong><br>
  Filehandle is opened to a tty.</li>
  <li><strong>`-u`</strong><br>
  File has setuid bit set.</li>
  <li><strong>`-g`</strong><br>
  File has setgid bit set.</li>
  <li><strong>`-k`</strong><br>
  File has sticky bit set.</li>
  <li><strong>`-T`</strong><br>
  File is an ASCII or UTF-8 text file (heuristic guess).</li>
  <li><strong>`-B`</strong><br>
  File is a “binary” file (opposite of `-T`).</li>
  <li><strong>`-M`</strong><br>
  Script start time minus file modification time, in days.</li>
  <li><strong>`-A`</strong><br>
  Same for access time.</li>
  <li><strong>`-C`</strong><br>
  Same for inode change time (Unix, may differ for other platforms)</li>
  </ul>
</blockquote>

#### Answer 2 (score 29)
You might want a variant of exists ...    perldoc -f "-f"  

```perl
      -X FILEHANDLE
       -X EXPR
       -X DIRHANDLE
       -X      A file test, where X is one of the letters listed below.  This unary operator takes one argument,
               either a filename, a filehandle, or a dirhandle, and tests the associated file to see if something is
               true about it.  If the argument is omitted, tests $_, except for "-t", which tests STDIN.  Unless
               otherwise documented, it returns 1 for true and '' for false, or the undefined value if the file
               doesn’t exist.  Despite the funny names, precedence is the same as any other named unary operator.
               The operator may be any of:

                   -r  File is readable by effective uid/gid.
                   -w  File is writable by effective uid/gid.
                   -x  File is executable by effective uid/gid.
                   -o  File is owned by effective uid.

                   -R  File is readable by real uid/gid.
                   -W  File is writable by real uid/gid.
                   -X  File is executable by real uid/gid.
                   -O  File is owned by real uid.

                   -e  File exists.
                   -z  File has zero size (is empty).
                   -s  File has nonzero size (returns size in bytes).

                   -f  File is a plain file.
                   -d  File is a directory.
                   -l  File is a symbolic link.
                   -p  File is a named pipe (FIFO), or Filehandle is a pipe.
                   -S  File is a socket.
                   -b  File is a block special file.
                   -c  File is a character special file.
                   -t  Filehandle is opened to a tty.

                   -u  File has setuid bit set.
                   -g  File has setgid bit set.
                   -k  File has sticky bit set.

                   -T  File is an ASCII text file (heuristic guess).
                   -B  File is a "binary" file (opposite of -T).

                   -M  Script start time minus file modification time, in days.
```

#### Answer 3 (score 15)
```perl
if (-e $base_path)
{ 
 # code
}
```

`-e` is the 'existence' operator in Perl.  

You can check permissions and other attributes using the code on <a href="http://www.pageresource.com/cgirec/ptut17.htm" rel="noreferrer">this page</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How can I convert a string to a number in Perl? (score [264988](https://stackoverflow.com/q/288900) in 2012)

#### Question
How would I convert a string holding a number into its numeric value in Perl?  

#### Answer accepted (score 89)
You don't need to convert it at all:  

```perl
% perl -e 'print "5.45" + 0.1;'
5.55
```

#### Answer 2 (score 69)
This is a simple solution:  

Example 1  

```perl
my $var1 = "123abc";
print $var1 + 0;
```

Result  

```perl
123
```

Example 2  

```perl
my $var2 = "abc123";
print $var2 + 0;
```

Result  

```perl
0
```

#### Answer 3 (score 40)
Perl is a context-based language. It doesn't do its work according to the data you give it. Instead, it figures out how to treat the data based on the operators you use and the context in which you use them. If you do numbers sorts of things, you get numbers:  

```perl
# numeric addition with strings:
my $sum = '5.45' + '0.01'; # 5.46
```

If you do strings sorts of things, you get strings:  

```perl
# string replication with numbers:
my $string = ( 45/2 ) x 4; # "22.522.522.522.5"
```

Perl mostly figures out what to do and it's mostly right. Another way of saying the same thing is that Perl cares more about the verbs than it does the nouns.  

Are you trying to do something and it isn't working?  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: How do I enter a multi-line comment in Perl? (score [250429](https://stackoverflow.com/q/3828205) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://stackoverflow.com/questions/3608957">What are the common workarounds for multi-line comments in Perl?</a>  </p>
</blockquote>



How do I add a multi-line comment to Perl source code?  

#### Answer accepted (score 136)
```perl
POD is the official way to do multi line comments in Perl,
```

<ul>
<li>see <strong><a href="http://www.perlmonks.org/?node_id=560985" rel="noreferrer">Multi-line comments in perl
code</a></strong> and</li>
<li><strong><a href="http://www.perlmonks.org/?node_id=100344" rel="noreferrer">Better ways to make multi-line comments in Perl</a></strong> for more
detail.</li>
</ul>

From faq.perl.org[<strong>perlfaq7</strong>]  

<ul>
<li><a href="http://faq.perl.org/perlfaq7.html" rel="noreferrer">How can I comment out a large block
of Perl code?</a></li>
</ul>

<blockquote>
  <p>The quick-and-dirty way to comment out more than one line of Perl is
  to surround those lines with Pod directives. You have to put these
  directives at the beginning of the line and somewhere where Perl
  expects a new statement (so not in the middle of statements like the #
  comments). You end the comment with `=cut`, ending the Pod section:</p>
</blockquote>

```perl
=pod

my $object = NotGonnaHappen->new();

ignored_sub();

$wont_be_assigned = 37;

=cut
```

<blockquote>
  <p>The quick-and-dirty method only works well when you don't plan to
  leave the commented code in the source. If a Pod parser comes along,
  your multiline comment is going to show up in the Pod translation. A
  better way hides it from Pod parsers as well.</p>
  
  <p>The `=begin` directive can mark a section for a particular purpose. If
  the Pod parser doesn't want to handle it, it just ignores it. Label
  the comments with `comment`. End the comment using `=end` with the
  same label. You still need the `=cut` to go back to Perl code from the
  Pod comment:</p>
</blockquote>

```perl
=begin comment

my $object = NotGonnaHappen->new();

ignored_sub();

$wont_be_assigned = 37;

=end comment

=cut
```

#### Answer 2 (score 24)
I found it. Perl has multi-line comments:  

```perl
#!/usr/bin/perl

use strict;

use warnings;

=for comment

Example of multiline comment.

Example of multiline comment.

=cut

print "Multi Line Comment Example \n";
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: How do I use boolean variables in Perl? (score [243622](https://stackoverflow.com/q/1036347) in 2009)

#### Question
I have tried:  

```perl
$var = false;
$var = FALSE;
$var = False;
```

None of these work. I get the error message  

<pre>Bareword "false" not allowed while "strict subs" is in use.</pre>

#### Answer accepted (score 280)
In Perl, the following evaluate to false in conditionals:  

```perl
0
'0'
undef
''  # Empty scalar
()  # Empty list
('')
```

The rest are true. There are no barewords for `true` or `false`.  

#### Answer 2 (score 69)
The most complete, concise definition of false I've come across is:  

<blockquote>Anything that stringifies to the empty string or the string `0` is false. Everything else is true.</blockquote>

Therefore, the following values are false:  

<ul>
<li>The empty string</li>
<li>Numerical value zero</li>
<li>An undefined value</li>
<li>An object with an overloaded boolean operator that evaluates one of the above.</li>
<li>A magical variable that evaluates to one of the above on fetch.</li>
</ul>

Keep in mind that an empty list literal evaluates to an undefined value in scalar context, so it evaluates to something false.  

<hr>

<strong>A note on "true zeroes"</strong>  

While numbers that stringify to `0` are false, strings that numify to zero aren't necessarily. The only false strings are `0` and the empty string. Any other string, even if it numifies to zero, is true.  

The following are strings that are true as a boolean and zero as a number.  

<ul>
<li>Without a warning:
<ul>
<li>`"0.0"`</li>
<li>`"0E0"`</li>
<li>`"00"`</li>
<li>`"+0"`</li>
<li>`"-0"`</li>
<li>`" 0"`</li>
<li>`"0\n"`</li>
<li>`".0"`</li>
<li>`"0."`</li>
<li>`"0 but true"`</li>
<li>`"\t00"`</li>
<li>`"\n0e1"`</li>
<li>`"+0.e-9"`</li>
</ul></li>
<li>With a warning:
<ul>
<li>Any string for which `Scalar::Util::looks_like_number` returns false. (e.g. `"abc"`)</li>
</ul></li>
</ul>

#### Answer 3 (score 57)
Perl doesn't have a native boolean type, but you can use comparison of integers or strings in order to get the same behavior. Alan's example is a nice way of doing that using comparison of integers. Here's an example  

```perl
my $boolean = 0;
if ( $boolean ) {
    print "$boolean evaluates to true\n";
} else {
    print "$boolean evaluates to false\n";
}
```

One thing that I've done in some of my programs is added the same behavior using a constant:  

```perl
#!/usr/bin/perl

use strict;
use warnings;

use constant false => 0;
use constant true  => 1;

my $val1 = true;
my $val2 = false;

print $val1, " && ", $val2;
if ( $val1 && $val2 ) {
    print " evaluates to true.\n";
} else {
    print " evaluates to false.\n";
}

print $val1, " || ", $val2;
if ( $val1 || $val2 ) {
    print " evaluates to true.\n";
} else {
    print " evaluates to false.\n";
}
```

The lines marked in "use constant" define a constant named true that always evaluates to 1, and a constant named false that always evaluates by 0. Because of the way that constants are defined in Perl, the following lines of code fails as well:  

```perl
true = 0;
true = false;
```

The error message should say something like "Can't modify constant in scalar assignment."  

I saw that in one of the comments you asked about comparing strings. You should know that because Perl combines strings and numeric types in scalar variables, you have different syntax for comparing strings and numbers:  

```perl
my $var1 = "5.0";
my $var2 = "5";

print "using operator eq\n";
if ( $var1 eq $var2 ) {
    print "$var1 and $var2 are equal!\n";
} else {
    print "$var1 and $var2 are not equal!\n";
}

print "using operator ==\n";
if ( $var1 == $var2 ) {
    print "$var1 and $var2 are equal!\n";
} else {
    print "$var1 and $var2 are not equal!\n";
}
```

The difference between these operators is a very common source of confusion in Perl.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: Easy way to print Perl array? (with a little formatting) (score [242206](https://stackoverflow.com/q/5741101) in 2017)

#### Question
Is there an <strong>easy</strong> way to print out a Perl array with commas in between each element?  

Writing a for loop to do it is pretty easy but not quite elegant....if that makes sense.  

#### Answer accepted (score 143)
Just use <a href="http://perldoc.perl.org/functions/join.html" rel="noreferrer">`join()`</a>:  

```perl
# assuming @array is your array:
print join(", ", @array);
```

#### Answer 2 (score 29)
You can use <a href="http://search.cpan.org/perldoc?Data::Dump" rel="noreferrer">`Data::Dump`</a>:  

```perl
use Data::Dump qw(dump);
my @a = (1, [2, 3], {4 => 5});
dump(@a);
```

Produces:  

```perl
"(1, [2, 3], { 4 => 5 })"
```

#### Answer 3 (score 18)
If you're coding for the kind of clarity that would be understood by someone who is just starting out with Perl, the traditional this construct says what it means, with a high degree of clarity and legibility:  

```perl
$string = join ', ', @array;
print "$string\n";
```

This construct is documented in `perldoc -f`<a href="http://perldoc.perl.org/functions/join.html" rel="nofollow noreferrer">`join`</a>.  

However, I've always liked how simple `$,` makes it.  The special variable  `$"` is for interpolation, and the special variable `$,` is for lists.  Combine either one with dynamic scope-constraining '`local`' to avoid having ripple effects throughout the script:  

```perl
use 5.012_002;
use strict;
use warnings;

my @array = qw/ 1 2 3 4 5 /;

{
    local $" = ', ';
    print "@array\n"; # Interpolation.
}
```

OR with $,:  

```perl
use feature q(say);
use strict;
use warnings;

my @array = qw/ 1 2 3 4 5 /;
{
    local $, = ', ';
    say @array; # List
}
```

The special variables `$,` and `$"` are documented in <a href="http://perldoc.perl.org/perlvar.html" rel="nofollow noreferrer">perlvar</a>. The `local` keyword, and how it can be used to constrain the effects of altering a global punctuation variable's value is probably best described in <a href="http://perldoc.perl.org/perlsub.html#Temporary-Values-via-local()" rel="nofollow noreferrer">perlsub</a>.  

Enjoy!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: What's the easiest way to install a missing Perl module? (score [241111](https://stackoverflow.com/q/65865) in 2015)

#### Question
I get this error:  

`Can't locate Foo.pm in @INC`  

Is there an easier way to install it than downloading, untarring, making, etc?  

#### Answer accepted (score 211)
<strong>On Unix</strong>:  

usually you start <em>cpan</em> in your shell:  

`# cpan`  

and type  

`install Chocolate::Belgian`  

or in short form:  

`cpan Chocolate::Belgian`  

<strong>On Windows</strong>:  

<blockquote>
  If you're using ActivePerl on Windows, the <a href="http://docs.activestate.com/activeperl/5.10/faq/ActivePerl-faq2.html#pkg_operations" rel="noreferrer">PPM (Perl Package Manager)</a> has much of the same functionality as CPAN.pm.  
</blockquote>

Example:  

<p>`# ppm`<br/>
 `ppm&gt; search net-smtp`<br/>
 `ppm&gt; install Net-SMTP-Multipart`</p>

<strong>see <a href="http://www.cpan.org/misc/cpan-faq.html#How_install_Perl_modules" rel="noreferrer">How do I install Perl modules?</a> in the CPAN FAQ</strong>  

Many distributions ship a lot of perl modules as packages.  

<ul>
<li>Debian/Ubuntu: `apt-cache search 'perl$'`</li>
<li>Arch Linux: `pacman -Ss '^perl-'`</li>
<li>Gentoo: category `dev-perl`</li>
</ul>

You should <em>always</em> prefer them as you benefit from automatic (security) <strong>updates</strong> and the ease of <strong>removal</strong>. This can be pretty tricky with the <em>cpan</em> tool itself.  

For Gentoo there's a nice tool called <strong><a href="https://wiki.gentoo.org/wiki/Project:Perl/g-cpan" rel="noreferrer">g-cpan</a></strong> which builds/installs the module from CPAN and creates a Gentoo package (<a href="http://en.wikipedia.org/wiki/Ebuild" rel="noreferrer">ebuild</a>) for you.  

#### Answer 2 (score 61)
Try <a href="http://search.cpan.org/perldoc/App::cpanminus" rel="noreferrer">App::cpanminus</a>:  

```perl
# cpanm Chocolate::Belgian
```

It's great for just getting stuff installed. It provides none of the more complex functionality of CPAN or CPANPLUS, so it's easy to use, provided you know which module you want to install. If you haven't already got cpanminus, just type:  

```perl
# cpan App::cpanminus
```

to install it.  

It is also possible to install it without using cpan at all.  The basic bootstrap procedure is,  

```perl
curl -L http://cpanmin.us | perl - --sudo App::cpanminus
```

For more information go to the App::cpanminus page and look at the section on installation.  

#### Answer 3 (score 29)
I note some folks suggesting one run cpan under sudo. That used to be necessary to install into the system directory, but modern versions of the CPAN shell allow you to configure it to use sudo <strong>just</strong> for installing. This is much safer, since it means that tests don't run as root.  

If you have an old CPAN shell, simply install the new cpan ("install CPAN") and when you reload the shell, it should prompt you to configure these new directives.  

Nowadays, when I'm on a system with an old CPAN, the first thing I do is update the shell and set it up to do this so I can do most of my cpan work as a normal user.  

Also, I'd strongly suggest that Windows users investigate <a href="http://strawberryperl.com" rel="noreferrer">strawberry Perl</a>. This is a version of Perl that comes packaged with a pre-configured CPAN shell as well as a compiler. It also includes some hard-to-compile Perl modules with their external C library dependencies, notably XML::Parser. This means that you can do the same thing as every other Perl user when it comes to installing modules, and things tend to "just work" a lot more often.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: Regex to match any character including new lines (score [222128](https://stackoverflow.com/q/8303488) in )

#### Question
Is there a regex to match "all characters including newlines"?   

For example, in the regex below, there is no output from `$2` because `(.+?)` doesn't include new lines when matching.  

```perl
$string = "START Curabitur mollis, dolor ut rutrum consequat, arcu nisl ultrices diam, adipiscing aliquam ipsum metus id velit. Aenean vestibulum gravida felis, quis bibendum nisl euismod ut. 

Nunc at orci sed quam pharetra congue. Nulla a justo vitae diam eleifend dictum. Maecenas egestas ipsum elementum dui sollicitudin tempus. Donec bibendum cursus nisi, vitae convallis ante ornare a. Curabitur libero lorem, semper sit amet cursus at, cursus id purus. Cras varius metus eu diam vulputate vel elementum mauris tempor. 

Morbi tristique interdum libero, eu pulvinar elit fringilla vel. Curabitur fringilla bibendum urna, ullamcorper placerat quam fermentum id. Nunc aliquam, nunc sit amet bibendum lacinia, magna massa auctor enim, nec dictum sapien eros in arcu. 

Pellentesque viverra ullamcorper lectus, a facilisis ipsum tempus et. Nulla mi enim, interdum at imperdiet eget, bibendum nec END";

$string =~ /(START)(.+?)(END)/;

print $2;
```

#### Answer accepted (score 170)
Add the <a href="http://perldoc.perl.org/perlre.html#Modifiers" rel="noreferrer">`s` modifier</a> to your regex to cause `.` to match newlines:  

```perl
$string =~ /(START)(.+?)(END)/s;
```

#### Answer 2 (score 287)
If you don't want add the `/s` regex modifier (perhaps you still want `.` to retain its original meaning elsewhere in the regex), you may also use a character class.  One possibility:  

```perl
[\S\s]
```

a character which is not a space or is a space… in other words, any character.  

You can also change modifiers locally in a small part of the regex, like so:  

```perl
(?s:.)
```

#### Answer 3 (score 8)
Yeap, you just need to make `.` match newline :   

```perl
$string =~ /(START)(.+?)(END)/s;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Best way to iterate through a Perl array (score [214532](https://stackoverflow.com/q/10487316) in 2013)

#### Question
Which is the best implementation(in terms of speed and memory usage) for iterating through a Perl array? Is there any better way? (`@Array` need not be retained).  

<h5>Implementation 1</h3>

```perl
foreach (@Array)
{
      SubRoutine($_);
}
```

<h5>Implementation 2</h3>

```perl
while($Element=shift(@Array))
{
      SubRoutine($Element);
}
```

<h5>Implementation 3</h3>

```perl
while(scalar(@Array) !=0)
{
      $Element=shift(@Array);
      SubRoutine($Element);
}
```

<h5>Implementation 4</h3>

```perl
for my $i (0 .. $#Array)
{
      SubRoutine($Array[$i]);
}
```

<h5>Implementation 5</h3>

```perl
map { SubRoutine($_) } @Array ;
```

#### Answer accepted (score 75)
<ul>
<li><p>In terms of speed: #1 and #4, but not by much in most instances.</p>

You could write a benchmark to confirm, but I suspect you'll find #1 and #4 to be slightly faster because the iteration work is done in C instead of Perl, and no needless copying of the array elements occurs. (`$_` is <em>aliased</em> to the element in #1, but #2 and #3 actually <em>copy</em> the scalars from the array.)  

&#35;5 might be similar.  </li>
<li><p>In terms memory usage: They're all the same except for #5.</p>

`for (@a)` is special-cased to avoid flattening the array. The loop iterates over the indexes of the array.  </li>
<li><p>In terms of readability: #1.</p></li>
<li><p>In terms of flexibility: #1/#4 and #5.</p>

&#35;2 does not support elements that are false. #2 and #3 are destructive.  </li>
</ul>

#### Answer 2 (score 24)
If you only care about the elements of `@Array`, use:  

```perl
for my $el (@Array) {
# ...
}
```

or   

If the indices matter, use:  

```perl
for my $i (0 .. $#Array) {
# ...
}
```

Or, as of `perl` 5.12.1, you can use:  

```perl
while (my ($i, $el) = each @Array) {
# ...
}
```

If you need both the element and its index in the body of the loop, <del>I would expect</del> using `each` <del>to be the fastest, but then</del> you'll be giving up compatibility with pre-5.12.1 `perl`s.  

Some other pattern than these might be appropriate under certain circumstances.  

#### Answer 3 (score 3)
IMO, implementation #1 is typical and being short and idiomatic for Perl trumps the others for that alone.  A benchmark of the three choices might offer you insight into speed, at least.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: What's the difference between Perl's backticks, system, and exec? (score [212862](https://stackoverflow.com/q/799968) in 2010)

#### Question
Can someone please help me? In Perl, what is the difference between:  

```perl
exec "command";
```

and  

```perl
system("command");
```

and  

```perl
print `command`;
```

Are there other ways to run shell commands too?  

#### Answer accepted (score 257)
<h5><strong>exec</strong></h2>

<p>executes a command and <em>never returns</em>.
  It's like a `return` statement in a function.</p>

<p>If the command is not found `exec` returns false.
  It never returns true, because if the command is found it never returns at all.
  There is also no point in returning `STDOUT`, `STDERR` or exit status of the command.
  You can find documentation about it in  <a href="http://perldoc.perl.org/functions/exec.html" rel="noreferrer"><strong>`perlfunc`</strong></a>, 
  because it is a function.</p>

<h5><strong>system</strong></h2>

executes a command and your Perl script is continued after the command has finished.  

<p>The return value is the exit status of the command.
  You can find documentation about it in  <a href="http://perldoc.perl.org/functions/system.html" rel="noreferrer"><strong>`perlfunc`</strong></a>.</p>

<h5><strong>backticks</strong></h2>

like `system` executes a command and your perl script is continued after the command has finished.  

<p>In contrary to <strong>`system`</strong> the return value is `STDOUT` of the command.
  `qx//` is equivalent to backticks.
  You can find documentation about it in <a href="http://perldoc.perl.org/perlop.html#Quote-Like-Operators" rel="noreferrer"><strong>`perlop`</strong></a>, because unlike `system` and `exec`it is an operator.</p>

<hr>

<h5><strong>Other ways</strong></h2>

<p>What is missing from the above is a way to execute a command asynchronously.
That means your perl script and your command run simultaneously.
This can be accomplished with <a href="http://perldoc.perl.org/functions/open.html" rel="noreferrer"><strong>`open`</strong></a>.
It allows you to read `STDOUT`/`STDERR` and write to `STDIN` of your command.
It is platform dependent though.</p>

<p>There are also several modules which can ease this tasks.
There is `IPC::Open2` and `IPC::Open3` and `IPC::Run`, as well as
`Win32::Process::Create` if you are on windows.</p>

#### Answer 2 (score 165)
In general I use `system`, `open`, `IPC::Open2`, or `IPC::Open3` depending on what I want to do.  The `qx//` operator, while simple, is too constraining in its functionality to be very useful outside of quick hacks.  I find `open` to much handier.  

<h5><a href="http://perldoc.perl.org/functions/system.html" rel="noreferrer">`system`</a>: run a command and wait for it to return</h2>

Use `system` when you want to run a command, don't care about its output, and don't want the Perl script to do anything until the command finishes.  

```perl
#doesn't spawn a shell, arguments are passed as they are
system("command", "arg1", "arg2", "arg3");
```

or  

```perl
#spawns a shell, arguments are interpreted by the shell, use only if you
#want the shell to do globbing (e.g. *.txt) for you or you want to redirect
#output
system("command arg1 arg2 arg3");
```

<h5><a href="http://perldoc.perl.org/perlop.html#qx/STRING/" rel="noreferrer">`qx//` or ``</a>: run a command and capture its STDOUT</h2>

Use `qx//` when you want to run a command, capture what it writes to STDOUT, and don't want the Perl script to do anything until the command finishes.  

```perl
#arguments are always processed by the shell

#in list context it returns the output as a list of lines
my @lines = qx/command arg1 arg2 arg3/;

#in scalar context it returns the output as one string
my $output = qx/command arg1 arg2 arg3/;
```

<h5><a href="http://perldoc.perl.org/functions/exec.html" rel="noreferrer">`exec`</a>: replace the current process with another process.</h2>

Use `exec` along with <a href="http://perldoc.perl.org/functions/fork.html" rel="noreferrer">`fork`</a> when you want to run a command, don't care about its output, and don't want to wait for it to return.  `system` is really just   

```perl
sub my_system {
    die "could not fork\n" unless defined(my $pid = fork);
    return waitpid $pid, 0 if $pid; #parent waits for child
    exec @_; #replace child with new process
}
```

You may also want to read the <a href="http://perldoc.perl.org/functions/waitpid.html" rel="noreferrer">`waitpid`</a> and <a href="http://perldoc.perl.org/perlipc.html" rel="noreferrer">`perlipc`</a> manuals.  

<h5><a href="http://perldoc.perl.org/functions/open.html" rel="noreferrer">`open`</a>: run a process and create a pipe to its STDIN or STDERR</h2>

Use `open` when you want to write data to a process's STDIN or read data from a process's STDOUT (but not both at the same time).  

```perl
#read from a gzip file as if it were a normal file
open my $read_fh, "-|", "gzip", "-d", $filename
    or die "could not open $filename: $!";

#write to a gzip compressed file as if were a normal file
open my $write_fh, "|-", "gzip", $filename
    or die "could not open $filename: $!";
```

<h5><a href="http://perldoc.perl.org/IPC/Open2.html" rel="noreferrer">IPC::Open2</a>: run a process and create a pipe to both STDIN and STDOUT</h2>

Use `IPC::Open2` when you need to read from and write to a process's STDIN and STDOUT.  

```perl
use IPC::Open2;

open2 my $out, my $in, "/usr/bin/bc"
    or die "could not run bc";

print $in "5+6\n";

my $answer = <$out>;
```

<h5><a href="http://perldoc.perl.org/IPC/Open3.html" rel="noreferrer">IPC::Open3</a>: run a process and create a pipe to STDIN, STDOUT, and STDERR</h2>

use `IPC::Open3` when you need to capture all three standard file handles of the process. I would write an example, but it works mostly the same way IPC::Open2 does, but with a slightly different order to the arguments and a third file handle.  

#### Answer 3 (score 17)
<h5>Let me quote the manuals first:</h3>

<a href="http://perldoc.perl.org/functions/exec.html" rel="noreferrer">perldoc exec()</a>:  

<blockquote>
  The exec function executes a system command and <strong>never returns</strong>-- use <em>system</em> instead of <em>exec</em> if you want it to return  
</blockquote>

<a href="http://perldoc.perl.org/functions/system.html" rel="noreferrer">perldoc system()</a>:  

<blockquote>
  Does exactly the same thing as exec LIST , except that <strong>a fork is done</strong> first, and the parent process waits for the child process to complete.  
</blockquote>

In contrast to <em>exec</em> and <em>system</em>, backticks don't give you the return value but the collected STDOUT.  

<a href="http://perldoc.perl.org/perlop.html#%60STRING%60" rel="noreferrer">perldoc &#x0060;String&#x0060;</a>:  

<blockquote>
  A string which is (possibly) interpolated and then executed as a system command with <em>/bin/sh</em> or its equivalent. Shell wildcards, pipes, and redirections will be honored. The collected <strong>standard output of the command is returned</strong>; standard error is unaffected.  
</blockquote>

<hr>

<h5>Alternatives:</h2>

In more complex scenarios, where you want to fetch STDOUT, STDERR or the return code, you can use well known standard modules like <a href="http://perldoc.perl.org/IPC/Open2.html" rel="noreferrer">IPC::Open2</a> and <a href="http://perldoc.perl.org/IPC/Open3.html" rel="noreferrer">IPC::Open3</a>.  

Example:  

```perl
use IPC::Open2;
my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'some', 'cmd', 'and', 'args');
waitpid( $pid, 0 );
my $child_exit_status = $? >> 8;
```

Finally, <a href="http://search.cpan.org/dist/IPC::Run/" rel="noreferrer">IPC::Run</a> from the CPAN is also worth looking at…  

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: Show a PDF files in users browser via PHP/Perl (score [211415](https://stackoverflow.com/q/4679756) in 2012)

#### Question
I want to show my users PDF files. The reason why I use cgi to show the pdf is I want to track the clicks for the pdf, and cloak the real location of the saved pdf.  

I've been searching on the Internet and only found how to show save dialog to the users and creating a pdf, not show the files to the users.  

<p>What I wanted for is <strong>show</strong> the users my pdf files, <strong>not creating or download</strong> the pdf.
Here is what I got form the official php documentation:</p>

```perl
<?php
header('Content-type: application/pdf');
readfile('the.pdf');
?>
```

Also my google-search-result perl code:  

```perl
open(PDF, "the.pdf") or die "could not open PDF [$!]";
binmode PDF;
my $output = do { local $/; <PDF> };
close (PDF);

print "Content-Type: application/pdf\n";
print "Content-Length: " .length($output) . "\n\n";
print $output
```

if you do it on ruby, please say it to me. But I'm not sure if my server support rails.  

Sorry if my code is too far away from the method to show the pdf, since I don't know anything about pdf processing and how to implement this problem.  

Lets assume that the users have the Adobe Reader plug-in. So, how to fix my problem?  

<strong>edit</strong> : I want to show plain pdf file. My primary purpose: track my pdf files and use some fancy urls.  

<strong>edit</strong> : Here's my main php code:  

```perl
<?php
$file='/files/the.pdf';
header('Content-type: application/pdf');
header('Content-Disposition: inline; filename="the.pdf"');
@readfile($file);
?>
```

<strong>edit</strong> : Now the code is working. But the loading progress bar (on Adobe Reader X plugin) doesn't shows up. Why? Anyone can help me? Here's my main code:  

```perl
<?php
$file='./files/the.pdf';
header('Content-type: application/pdf');
header('Content-Disposition: inline; filename="the.pdf"');
header('Content-Transfer-Encoding: binary');
header('Content-Length: ' . filesize($file));
@readfile($file);
?>
```

<strong>edit</strong> : All my problems solved. Here's the final code:  

```perl
<?php
$file = './path/to/the.pdf';
$filename = 'Custom file name for the.pdf'; /* Note: Always use .pdf at the end. */

header('Content-type: application/pdf');
header('Content-Disposition: inline; filename="' . $filename . '"');
header('Content-Transfer-Encoding: binary');
header('Content-Length: ' . filesize($file));
header('Accept-Ranges: bytes');

@readfile($file);
?>
```

Thanks! :)  

#### Answer 2 (score 49)
I assume you want the PDF to display in the browser, rather than forcing a download. If that is the case, try setting the `Content-Disposition` header with a value of `inline`.  

Also remember that this will also be affected by browser settings - some browsers may be configured to <strong>always</strong> download PDF files or open them in a different application (e.g. Adobe Reader)  

#### Answer 3 (score 14)
```perl
    $url ="https://yourFile.pdf";
    $content = file_get_contents($url);

    header('Content-Type: application/pdf');
    header('Content-Length: ' . strlen($content));
    header('Content-Disposition: inline; filename="YourFileName.pdf"');
    header('Cache-Control: private, max-age=0, must-revalidate');
    header('Pragma: public');
    ini_set('zlib.output_compression','0');

    die($content);
```

Tested and works fine. If you want the file to download instead, replace  

```perl
    Content-Disposition: inline
```

with  

```perl
    Content-Disposition: attachment
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How do I get a list of installed CPAN modules? (score [207546](https://stackoverflow.com/q/115425) in )

#### Question
Aside from trying  

```perl
perldoc <module name>
```

individually for any CPAN module that takes my fancy or going through the file system and looking at the directories I have no idea what modules we have installed.   

What's the easiest way to just get a big list of every CPAN module installed? From the command line or otherwise.  

#### Answer accepted (score 62)
This is answered in the Perl FAQ, the answer which can be quickly found with `perldoc -q installed`.  In short, it comes down to using `ExtUtils::Installed` or using `File::Find`, variants of both of which have been covered previously in this thread.  

You can also find the FAQ entry <a href="http://perldoc.perl.org/perlfaq3.html#How-do-I-find-which-modules-are-installed-on-my-system%3f" rel="noreferrer">"How do I find which modules are installed on my system?"</a> in perlfaq3. You can see a list of all FAQ answers by looking in <a href="http://perldoc.perl.org/perlfaq.html" rel="noreferrer">perlfaq</a>  

#### Answer 2 (score 34)
```perl
perldoc perllocal
```

Edit: There's a (little) more info about it in the <a href="http://www.cpan.org/misc/cpan-faq.html#How_installed_modules" rel="noreferrer">CPAN FAQ</a>  

#### Answer 3 (score 24)
`perldoc -q installed`  

claims that `cpan -l` will do the trick, however it's not working for me. The other option:  

`cpan -a`  

does spit out a nice list of installed packages and has the nice side effect of writing them to a file.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: How do I remove duplicate items from an array in Perl? (score [206565](https://stackoverflow.com/q/7651) in 2014)

#### Question
I have an array in Perl:  

```perl
my @my_array = ("one","two","three","two","three");
```

How do I remove the duplicates from the array?  

#### Answer accepted (score 159)
You can do something like this as demonstrated in <a href="http://perldoc.perl.org/perlfaq4.html#How-can-I-remove-duplicate-elements-from-a-list-or-array%3f" rel="noreferrer">perlfaq4</a>:  

```perl
sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

my @array = qw(one two three two three);
my @filtered = uniq(@array);

print "@filtered\n";
```

Outputs:  

```perl
one two three
```

If you want to use a module, try the `uniq` function from <a href="https://metacpan.org/pod/List::MoreUtils" rel="noreferrer">`List::MoreUtils`</a>  

#### Answer 2 (score 119)
The Perl documentation comes with a nice collection of FAQs.  Your question is frequently asked:  

```perl
% perldoc -q duplicate
```

The answer, copy and pasted from the output of the command above, appears below:  

<pre>Found in /usr/local/lib/perl5/5.10.0/pods/perlfaq4.pod
 How can I remove duplicate elements from a list or array?
   (contributed by brian d foy)

   Use a hash. When you think the words "unique" or "duplicated", think
   "hash keys".

   If you don't care about the order of the elements, you could just
   create the hash then extract the keys. It's not important how you
   create that hash: just that you use "keys" to get the unique elements.

       my %hash   = map { $_, 1 } @array;
       # or a hash slice: @hash{ @array } = ();
       # or a foreach: $hash{$_} = 1 foreach ( @array );

       my @unique = keys %hash;

   If you want to use a module, try the "uniq" function from
   "List::MoreUtils". In list context it returns the unique elements,
   preserving their order in the list. In scalar context, it returns the
   number of unique elements.

       use List::MoreUtils qw(uniq);

       my @unique = uniq( 1, 2, 3, 4, 4, 5, 6, 5, 7 ); # 1,2,3,4,5,6,7
       my $unique = uniq( 1, 2, 3, 4, 4, 5, 6, 5, 7 ); # 7

   You can also go through each element and skip the ones you've seen
   before. Use a hash to keep track. The first time the loop sees an
   element, that element has no key in %Seen. The "next" statement creates
   the key and immediately uses its value, which is "undef", so the loop
   continues to the "push" and increments the value for that key. The next
   time the loop sees that same element, its key exists in the hash and
   the value for that key is true (since it's not 0 or "undef"), so the
   next skips that iteration and the loop goes to the next element.

       my @unique = ();
       my %seen   = ();

       foreach my $elem ( @array )
       {
         next if $seen{ $elem }++;
         push @unique, $elem;
       }

   You can write this more briefly using a grep, which does the same
   thing.

       my %seen = ();
       my @unique = grep { ! $seen{ $_ }++ } @array;
</pre>

#### Answer 3 (score 67)
Install <a href="http://search.cpan.org/dist/List-MoreUtils/" rel="noreferrer">List::MoreUtils</a> from CPAN  

Then in your code:  

```perl
use strict;
use warnings;
use List::MoreUtils qw(uniq);

my @dup_list = qw(1 1 1 2 3 4 4);

my @uniq_list = uniq(@dup_list);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: Perl - If string contains text? (score [204940](https://stackoverflow.com/q/7011524) in 2015)

#### Question
I want to use curl to view the source of a page and if that source contains a word that matches the string then it will execute a print. How would I do a `if $string contains`?  

In VB it would be like.  

```perl
dim string1 as string = "1"
If string1.contains("1") Then
Code here...
End If
```

Something similar to that but in Perl.  

#### Answer 2 (score 90)
If you just need to search for one string within another, use the <a href="http://perldoc.perl.org/functions/index.html" rel="noreferrer">`index`</a> function (or <a href="http://perldoc.perl.org/functions/rindex.html" rel="noreferrer">`rindex`</a> if you want to start scanning from the end of the string):  

```perl
if (index($string, $substring) != -1) {
   print "'$string' contains '$substring'\n";
}
```

To search a string for a <a href="http://perldoc.perl.org/perlre.html" rel="noreferrer">pattern</a> match, use the match operator <a href="http://perldoc.perl.org/functions/m.html" rel="noreferrer">`m//`</a>:  

```perl
if ($string =~ m/pattern/) {
    print "'$string' matches the pattern\n";       
}
```

#### Answer 3 (score 29)
```perl
if ($string =~ m/something/) {
   # Do work
}
```

Where `something` is a regular expression.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: How to extract string following a pattern with grep, regex or perl (score [193684](https://stackoverflow.com/q/5080988) in 2018)

#### Question
I have a file that looks something like this:  

```perl
<table name="content_analyzer" primary-key="id">
  <type="global" />
</table>
<table name="content_analyzer2" primary-key="id">
  <type="global" />
</table>
<table name="content_analyzer_items" primary-key="id">
  <type="global" />
</table>
```

I need to extract anything within the quotes that follow `name=`, i.e., `content_analyzer`, `content_analyzer2` and `content_analyzer_items`.  

I am doing this on a Linux box, so a solution using sed, perl, grep or bash is fine.  

#### Answer accepted (score 143)
<p>Since you need to match content without including it in the result (must
match `name="`  but it's not  part of the  desired result) some  form of
zero-width matching  or group  capturing is required.  This can  be done
easily with the following tools:</p>

<h5>Perl</h3>

<p>With Perl you  could use the `n`  option to loop line by  line and print
the content of a capturing group if it matches:</p>

```perl
perl -ne 'print "$1\n" if /name="(.*?)"/' filename
```

<h5>GNU grep</h3>

<p>If you have an improved version of  grep, such as GNU grep, you may have
the  `-P` option  available. This  option will  enable Perl-like  regex,
allowing you to use `\K` which  is a shorthand lookbehind. It will reset
the match position, so anything before it is zero-width.</p>

```perl
grep -Po 'name="\K.*?(?=")' filename
```

<p>The `o`  option makes grep print  only the matched text,  instead of the
whole line.</p>

<h5>Vim - Text Editor</h3>

<p>Another way  is to  use a  text editor  directly. With  Vim, one  of the
various  ways of  accomplishing this  would be  to delete  lines without
`name=` and then extract the content from the resulting lines:</p>

```perl
:v/.*name="\v([^"]+).*/d|%s//\1
```

<hr>

<h5>Standard grep</h3>

<p>If you  don't have  access to  these tools,  for some  reason, something
similar could be achieved with  standard grep. However, without the look
around it will require some cleanup later:</p>

```perl
grep -o 'name="[^"]*"' filename
```

<hr>

<h5>A note about saving results</h3>

<p>In all of the commands above the  results will be sent to `stdout`. It's
important to remember  that you can always  save them by piping  it to a
file by appending:</p>

```perl
> result
```

to the end of the command.  

#### Answer 2 (score 5)
If you're using Perl, download a module to parse the XML: <a href="http://search.cpan.org/~grantm/XML-Simple-2.18/lib/XML/Simple.pm" rel="noreferrer">XML::Simple</a>, <a href="http://search.cpan.org/~mirod/XML-Twig-3.37/Twig_pm.slow" rel="noreferrer">XML::Twig</a>, or <a href="http://search.cpan.org/~pajas/XML-LibXML-1.70/LibXML.pod" rel="noreferrer">XML::LibXML</a>.  Don't re-invent the wheel.  

#### Answer 3 (score 5)
If you're using Perl, download a module to parse the XML: <a href="http://search.cpan.org/~grantm/XML-Simple-2.18/lib/XML/Simple.pm" rel="noreferrer">XML::Simple</a>, <a href="http://search.cpan.org/~mirod/XML-Twig-3.37/Twig_pm.slow" rel="noreferrer">XML::Twig</a>, or <a href="http://search.cpan.org/~pajas/XML-LibXML-1.70/LibXML.pod" rel="noreferrer">XML::LibXML</a>.  Don't re-invent the wheel.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How can I call a shell command in my Perl script? (score [190411](https://stackoverflow.com/q/3200801) in 2019)

#### Question
What would be an example of how I can call a shell command, say '`ls -a`' in a Perl script and the way to retrieve the output of the command as well?  

#### Answer accepted (score 69)
<a href="http://www.perlmonks.org/?node_id=78523" rel="noreferrer">How to run a shell script from a Perl program</a>  

<blockquote>
  1. Using system system($command, @arguments);  
  
  For example:   
  
  `system("sh", "script.sh", "--help" );`  
  
  `system("sh script.sh --help");`  
  
  <p>System will execute the $command with
  @arguments and return to your script when finished. You may check $!
  for certain errors passed to the OS by the external application. Read
  the documentation for system for the nuances of how various
  invocations are slightly different.</p>
  
  2. Using exec   
  
  <p>This is very similar to the use of <a href="http://perldoc.perl.org/functions/system.html" rel="noreferrer">system</a>, but it will
  terminate your script upon execution. Again, read the documentation
  for <a href="http://perldoc.perl.org/functions/exec.html" rel="noreferrer">exec</a> for more.</p>
  
  3. Using backticks or qx//   
  
  `my $output = `script.sh --option`;`  
  
  `my $output = qx/script.sh --option/;`  
  
  <p>The backtick operator and it's equivalent qx// excute the command and options inside the operator and
  return that commands output to STDOUT when it finishes. </p>
  
  <p>There are also
  ways to run external applications through creative use of <a href="http://perldoc.perl.org/functions/open.html" rel="noreferrer">open</a>, but
  this is advanced use; read the documentation for more.</p>
</blockquote>

#### Answer 2 (score 15)
From <a href="http://www.perlhowto.com/executing_external_commands" rel="noreferrer">Perl HowTo</a>, the most common ways to execute external commands from Perl are:  

<ul>
<li>`my $files = `ls -la`` — captures the output of the command in `$files`</li>
<li>`system "touch ~/foo"` — if you don't want to capture the command's output</li>
<li>`exec "vim ~/foo"` — if you don't want to return to the script after executing the command</li>
<li>`open(my $file, '|-', "grep foo"); print $file "foo\nbar"` — if you want to pipe input into the command</li>
</ul>

#### Answer 3 (score 12)
<h5>Examples</h2>

<ol>
<li>``ls -l`;`  </li>
<li>`system("ls -l");`</li>
<li>`exec("ls -l");`</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: The program can't start because api-ms-win-crt-runtime-l1-1-0.dll is missing while starting Apache server on my computer (score [184586](https://stackoverflow.com/q/34740438) in 2017)

#### Question
In order to quickly set up my PHP/Perl development environment, I installed <a href="https://www.apachefriends.org/index.html" rel="noreferrer">xampp</a>. Specifically, I attempted to install using: `xampp-win32-7.0.1-0-VC14-installer`.  

When I started the program, I ran into an error related to a `dll` file. I also tried the suggestions in <a href="https://stackoverflow.com/questions/33265663/api-ms-win-crt-runtime-l1-1-0-dll-is-missing-when-open-office-file">this question</a> that sounded like fixes to the same problem.  

The problem is still not fixed after trying the above.  

<img src="https://i.stack.imgur.com/i65rH.png" alt="screenshot of error">  

#### Answer accepted (score 10)
<p>I was facing the same issue.
After many tries below solution worked for me.</p>

<p>Before installing VC++ install your windows updates.
  1. Go to Start - Control Panel - Windows Update
  2. Check for the updates.
  3. Install all updates.
  4. Restart your system.</p>

After that you can follow the below steps.  

@ABHI KUMAR   

Download the Visual C++ Redistributable 2015  

Visual C++ Redistributable for Visual Studio 2015 (64-bit)  

Visual C++ Redistributable for Visual Studio 2015 (32-bit)   

(Reinstal if already installed) then restart your computer or use windows updates for download auto.   

For link download <a href="https://www.microsoft.com/de-de/download/details.aspx?id=48145" rel="nofollow noreferrer">https://www.microsoft.com/de-de/download/details.aspx?id=48145</a>.  

#### Answer 2 (score 9)
Download the Visual C++ Redistributable 2015  

Updated links to VC++  file:  

<a href="http://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe" rel="noreferrer">For Windows 64-bit</a>   

<a href="http://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x86.exe" rel="noreferrer">For Windows 32-bit</a>   

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: "inappropriate ioctl for device" (score [183560](https://stackoverflow.com/q/1605195) in 2016)

#### Question
I have a Perl script running in an AIX box.   

The script tries to open a file from a certain directory and it fails to read the file because file has no read permission, but I get a different error saying `inappropriate ioctl for device`.   

Shouldn't it say something like `no read permissions for file` or something similar?  

What does this `inappropriate ioctl for device` message mean?  

How can I fix it?  

EDIT: This is what I found when I did `strace`.  

<pre>
open("/local/logs/xxx/xxxxServer.log", O_WRONLY|O_CREAT|O_APPEND|O_LARGEFILE, 
    0666) = 4 _llseek(4, 0, [77146], SEEK_END) = 0
ioctl(4, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbffc14f8) = -1 ENOTTY 
    (Inappropriate ioctl for  device)
</pre>

#### Answer accepted (score 37)
Most likely it means that the open <em>didn't fail</em>.  

When Perl opens a file, it checks whether or not the file is a TTY (so that it can answer the `-T $fh` filetest operator) by issuing the `TCGETS` ioctl against it. If the file is a regular file and not a tty, the ioctl fails and sets errno to `ENOTTY` (string value: "Inappropriate ioctl for device"). As ysth says, the most common reason for seeing an unexpected value in `$!` is checking it when it's not valid -- that is, anywhere <em>other</em> than immediately after a syscall failed, so testing the result codes of your operations is critically important.  

If `open` actually did return false for you, and you found `ENOTTY` in `$!` then I would consider this a small bug (giving a useless value of `$!`) but I would also be very curious as to how it happened. Code and/or truss output would be nifty.  

#### Answer 2 (score 21)
Odd errors like "inappropriate ioctl for device" are usually a result of checking $! at some point other than just after a system call failed.  If you'd show your code, I bet someone would rapidly point out your error.  

#### Answer 3 (score 5)
"files" in *nix type systems are very much an abstract concept.  

They can be areas on disk organized by a file system, but they could equally well be a network connection, a bit of shared memory, the buffer output from another process, a screen or a keyboard.  

In order for perl to be really useful it mirrors this model very closely, and does not treat files by emulating a magnetic tape as many 4gls do.  

So it tried an "IOCTL" operation 'open for write' on a file handle which does not allow write operations which is an inappropriate IOCTL operation for that device/file.  

The easiest thing to do is stick an " `or die 'Cannot open $myfile'`  statement at the end of you open and you can choose your own meaningful message.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: What is the proper way to check if a string is empty in Perl? (score [182537](https://stackoverflow.com/q/2045644) in 2010)

#### Question
I've just been using this code to check if a string is empty:  

```perl
if ($str == "")
{
  // ...
}
```

And also the same with the not equals operator...  

```perl
if ($str != "")
{
  // ...
}
```

This seems to work (I think), but I'm not sure it's the correct way, or if there are any unforeseen drawbacks. Something just doesn't feel right about it.  

#### Answer accepted (score 123)
For string comparisons in Perl, use `eq` or `ne`:  

```perl
if ($str eq "")
{
  // ...
}
```

The `==` and `!=` operators are <em>numeric</em> comparison operators. They will attempt to convert both operands to integers before comparing them.  

See the <a href="http://perldoc.perl.org/perlop.html" rel="noreferrer">perlop</a> man page for more information.  

#### Answer 2 (score 88)
<ol>
<li><p>Due to the way that strings are stored in Perl, getting the length of a string is optimized.<br>
`if (length $str)` is a good way of checking that a string is non-empty.</p></li>
<li><p>If you're in a situation where you haven't already guarded against `undef`, then the catch-all for "non-empty" that won't warn is `if (defined $str and length $str)`.</p></li>
</ol>

#### Answer 3 (score 9)
As already mentioned by several people, `eq` is the right operator here.  

If you `use warnings;` in your script, you'll get warnings about this (and many other useful things); I'd recommend `use strict;` as well.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: How do I perform a Perl substitution on a string while keeping the original? (score [181742](https://stackoverflow.com/q/22836) in 2013)

#### Question
In Perl, what is a good way to perform a replacement on a string using a regular expression and store the value in a different variable, without changing the original?  

I usually just copy the string to a new variable then bind it to the `s///` regex that does the replacement on the new string, but I was wondering if there is a better way to do this?  

```perl
$newstring = $oldstring;
$newstring =~ s/foo/bar/g;
```

#### Answer accepted (score 239)
This is the idiom I've always used to get a modified copy of a string without changing the original:  

```perl
(my $newstring = $oldstring) =~ s/foo/bar/g;
```

In perl 5.14.0 or later, you can use the new `/r` <a href="http://search.cpan.org/~flora/perl-5.14.2/pod/perl5140delta.pod#Non-destructive_substitution" rel="noreferrer">non-destructive substitution modifier:</a>  

```perl
my $newstring = $oldstring =~ s/foo/bar/gr; 
```

<hr>

Note: The above solutions work without `g` too. They also work with any other modifiers.  

#### Answer 2 (score 42)
The statement:  

```perl
(my $newstring = $oldstring) =~ s/foo/bar/g;
```

Which is equivalent to:  

```perl
my $newstring = $oldstring;
$newstring =~ s/foo/bar/g;
```

Alternatively, as of Perl 5.13.2 you can use `/r` to do a non destructive substitution:  

```perl
use 5.013;
#...
my $newstring = $oldstring =~ s/foo/bar/gr;
```

#### Answer 3 (score 21)
Under `use strict`, say:  

```perl
(my $new = $original) =~ s/foo/bar/;
```

instead.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: In Perl, how can I concisely check if a $variable is defined and contains a non zero length string? (score [177567](https://stackoverflow.com/q/1480066) in 2009)

#### Question
I currently use the following Perl to check if a variable is defined and contains text. I have to check `defined` first to avoid an 'uninitialized value' warning:  

```perl
if (defined $name && length $name > 0) {
    # do something with $name
}
```

Is there a better (presumably more concise) way to write this?  

#### Answer accepted (score 72)
You often see the check for definedness so you don't have to deal with the warning for using an undef value (and in Perl 5.10 it tells you the offending variable):  

```perl
 Use of uninitialized value $name in ...
```

So, to get around this warning, people come up with all sorts of code, and that code starts to look like an important part of the solution rather than the bubble gum and duct tape that it is. Sometimes, it's better to show what you are doing by explicitly turning off the warning that you are trying to avoid:  

```perl
 {
 no warnings 'uninitialized';

 if( length $name ) {
      ...
      }
 }
```

In other cases, use some sort of null value instead of the data. With <a href="http://www.effectiveperlprogramming.com/2010/10/set-default-values-with-the-defined-or-operator/" rel="noreferrer">Perl 5.10's defined-or operator</a>, you can give `length` an explicit empty string (defined, and give back zero length) instead of the variable that will trigger the warning:  

```perl
 use 5.010;

 if( length( $name // '' ) ) {
      ...
      }
```

In Perl 5.12, it's a bit easier because <a href="http://www.effectiveperlprogramming.com/2010/09/in-perl-v5-12-lengthundef-returns-undef/" rel="noreferrer">`length` on an undefined value also returns undefined</a>. That might seem like a bit of silliness, but that pleases the mathematician I might have wanted to be. That doesn't issue a warning, which is the reason this question exists.  

```perl
use 5.012;
use warnings;

my $name;

if( length $name ) { # no warning
    ...
    }
```

#### Answer 2 (score 23)
As mobrule indicates, you could use the following instead for a small savings:  

```perl
if (defined $name && $name ne '') {
    # do something with $name
}
```

You could ditch the defined check and get something even shorter, e.g.:  

```perl
if ($name ne '') {
    # do something with $name
}
```

But in the case where `$name` is not defined, although the logic flow will work just as intended, if you are using `warnings` (and you should be), then you'll get the following admonishment:  

<pre>Use of uninitialized value in string ne</pre>

So, if there's a chance that `$name` might not be defined, you really do need to check for definedness first and foremost in order to avoid that warning.  As Sinan Ünür points out, you can use <a href="http://search.cpan.org/dist/Scalar-MoreUtils/" rel="noreferrer">Scalar::MoreUtils</a> to get code that does exactly that (checks for definedness, then checks for zero length) out of the box, via the `empty()` method:  

```perl
use Scalar::MoreUtils qw(empty);
if(not empty($name)) {
    # do something with $name 
}
```

#### Answer 3 (score 14)
First, since `length` always returns a non-negative number,  

```perl
if ( length $name )
```

and   

```perl
if ( length $name > 0 )
```

are equivalent.   

If you are OK with replacing an undefined value with an empty string, you can use Perl 5.10's `//=` operator which assigns the RHS to the LHS unless the LHS is defined:  

```perl
#!/usr/bin/perl

use feature qw( say );
use strict; use warnings;

my $name;

say 'nonempty' if length($name //= '');
say "'$name'";
```

Note the absence of warnings about an uninitialized variable as `$name` is assigned the empty string if it is undefined.  

However, if you do not want to depend on 5.10 being installed, use the functions provided by <a href="http://search.cpan.org/perldoc/Scalar::MoreUtils" rel="noreferrer">Scalar::MoreUtils</a>. For example, the above can be written as:  

```perl
#!/usr/bin/perl

use strict; use warnings;

use Scalar::MoreUtils qw( define );

my $name;

print "nonempty\n" if length($name = define $name);
print "'$name'\n";
```

If you don't want to clobber `$name`, use `default`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: How do I search a Perl array for a matching string? (score [176905](https://stackoverflow.com/q/2925604) in 2010)

#### Question
What is the smartest way of searching through an array of strings for a matching string in Perl?  

One caveat, I would like the search to be case-insensitive  

so `"aAa"` would be in `("aaa","bbb")`  

#### Answer accepted (score 29)
I guess  

```perl
@foo = ("aAa", "bbb");
@bar = grep(/^aaa/i, @foo);
print join ",",@bar;
```

would do the trick.  

#### Answer 2 (score 143)
It depends on what you want the search to do:  

<ul>
<li><p>if you want to find <strong>all matches</strong>, use the built-in <a href="http://perldoc.perl.org/functions/grep.html" rel="noreferrer">grep</a>:</p>

```perl
my @matches = grep { /pattern/ } @list_of_strings;
```</li>
<li><p>if you want to find the <strong>first match</strong>, use `first` in <a href="http://search.cpan.org/perldoc?List::Util" rel="noreferrer">List::Util</a>:</p>

```perl
use List::Util 'first';  
my $match = first { /pattern/ } @list_of_strings;
```</li>
<li><p>if you want to find the <strong>count of all matches</strong>, use `true` in <a href="http://search.cpan.org/perldoc?List::MoreUtils" rel="noreferrer">List::MoreUtils</a>:</p>

```perl
use List::MoreUtils 'true';
my $count = true { /pattern/ } @list_of_strings;
```</li>
<li><p>if you want to know the <strong>index of the first match</strong>, use `first_index` in <a href="http://search.cpan.org/perldoc?List::MoreUtils" rel="noreferrer">List::MoreUtils</a>:</p>

```perl
use List::MoreUtils 'first_index'; 
my $index = first_index { /pattern/ } @list_of_strings;
```</li>
<li><p>if you want to simply know <strong>if there was a match</strong>, but you don't care which element it was or its value, use `any` in <a href="http://search.cpan.org/perldoc?List::MoreUtils" rel="noreferrer">List::Util</a>:</p>

```perl
use List::Util 1.33 'any';
my $match_found = any { /pattern/ } @list_of_strings;
```</li>
</ul>

All these examples do similar things at their core, but their implementations have been heavily optimized to be fast, and will be faster than any pure-perl implementation that you might write yourself with <a href="http://perldoc.perl.org/functions/grep.html" rel="noreferrer">grep</a>, <a href="http://perldoc.perl.org/functions/map.html" rel="noreferrer">map</a> or a <a href="http://perldoc.perl.org/perlsyn.html#For-Loops" rel="noreferrer">for loop</a>.  

<hr>

Note that the algorithm for doing the looping is a separate issue than performing the individual matches.  To match a string case-insensitively, you can simply use the `i` flag in the pattern:  `/pattern/i`.  You should definitely read through <a href="http://perldoc.perl.org/perlre.html" rel="noreferrer">perldoc perlre</a> if you have not previously done so.  

#### Answer 3 (score 29)
Perl 5.10+ contains the 'smart-match' operator `~~`, which returns true if a certain element is contained in an array or hash, and false if it doesn't (see <a href="http://perldoc.perl.org/perlfaq4.html#How-can-I-tell-whether-a-certain-element-is-contained-in-a-list-or-array%3f" rel="noreferrer">perlfaq4</a>):  

The nice thing is that it also supports regexes, meaning that your case-insensitive requirement can easily be taken care of:  

```perl
use strict;
use warnings;
use 5.010;

my @array  = qw/aaa bbb/;
my $wanted = 'aAa';

say "'$wanted' matches!" if /$wanted/i ~~ @array;   # Prints "'aAa' matches!"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: How do I get the full path to a Perl script that is executing? (score [175554](https://stackoverflow.com/q/84932) in 2015)

#### Question
I have Perl script and need to determine the full path and filename of the script during execution. I discovered that depending on how you call the script `$0` varies and sometimes contains the `fullpath+filename` and sometimes just `filename`. Because the working directory can vary as well I can't think of a way to reliably get the `fullpath+filename` of the script.  

Anyone got a solution?  

#### Answer accepted (score 237)
There are a few ways:  

<ul>
<li><a href="http://perldoc.perl.org/perlvar.html#$0" rel="noreferrer">`$0`</a> is the currently executing script as provided by POSIX, relative to the current working directory if the script is at or below the CWD</li>
<li>Additionally, `cwd()`, `getcwd()` and `abs_path()` are provided by the <a href="http://perldoc.perl.org/Cwd.html" rel="noreferrer">`Cwd`</a> module and tell you where the script is being run from</li>
<li>The module <a href="http://perldoc.perl.org/FindBin.html" rel="noreferrer">`FindBin`</a> provides the `$Bin` &amp; `$RealBin` variables that <em>usually</em> are the path to the executing script; this module also provides `$Script` &amp; `$RealScript` that are the name of the script</li>
<li><a href="http://perldoc.perl.org/perldata.html#Special-Literals" rel="noreferrer">`__FILE__`</a> is the actual file that the Perl interpreter deals with during compilation, including its full path.</li>
</ul>

I've seen the first three (<a href="http://perldoc.perl.org/perlvar.html#$0" rel="noreferrer">`$0`</a>, the <a href="http://perldoc.perl.org/Cwd.html" rel="noreferrer">`Cwd`</a> module and the <a href="http://perldoc.perl.org/FindBin.html" rel="noreferrer">`FindBin`</a> module) fail under `mod_perl` spectacularly, producing worthless output such as `'.'` or an empty string.  In such environments, I use <a href="http://perldoc.perl.org/perldata.html#Special-Literals" rel="noreferrer">`__FILE__`</a> and get the path from that using the <a href="http://perldoc.perl.org/File/Basename.html" rel="noreferrer">`File::Basename`</a> module:  

```perl
use File::Basename;
my $dirname = dirname(__FILE__);
```

#### Answer 2 (score 144)
$0 is typically the name of your program, so how about this?  

```perl
use Cwd 'abs_path';
print abs_path($0);
```

Seems to me that this should work as abs_path knows if you are using a relative or absolute path.  

<strong>Update</strong> For anyone reading this years later, you should read <a href="https://stackoverflow.com/a/90721/2877364">Drew's answer</a>. It's much better than mine.  

#### Answer 3 (score 35)
```perl
Use File::Spec;
File::Spec->rel2abs( __FILE__ );
```

<a href="http://perldoc.perl.org/File/Spec/Unix.html" rel="noreferrer">http://perldoc.perl.org/File/Spec/Unix.html</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: Difference between \w and \b regular expression meta characters (score [174237](https://stackoverflow.com/q/11874234) in 2019)

#### Question
Can anyone explain the difference between `\b` and `\w` regular expression metacharacters? It is my understanding that both these metacharacters are used for word boundaries. Apart from this, which meta character is efficient for multilingual content?  

#### Answer accepted (score 242)
The metacharacter `\b` is an anchor like the caret and the dollar sign. It matches at a position that is called a <strong>"word boundary"</strong>. This match is zero-length.  

There are three different positions that qualify as word boundaries:  

<ul>
<li>Before the first character in the string, if the first character is
a word character.</li>
<li>After the last character in the string, if the
last character is a word character.</li>
<li>Between two characters in the
string, where one is a word character and the other is not a word character. </li>
</ul>

Simply put: `\b` allows you to perform a <strong>"whole words only"</strong> search using a regular expression in the form of `\bword\b`. A <strong>"word character"</strong> is a character that can be used to form words. All characters that are not <strong>"word characters"</strong> are <strong>"non-word characters"</strong>.  

In all flavors, the characters `[a-zA-Z0-9_]` are word characters. These are also matched by the short-hand character class `\w`. Flavors showing <strong>"ascii"</strong> for word boundaries in the flavor comparison recognize only these as word characters.  

`\w` stands for <strong>"word character"</strong>, usually `[A-Za-z0-9_]`. Notice the inclusion of the underscore and digits.  

`\B` is the negated version of `\b`. `\B` matches at every position where `\b` does not. Effectively, `\B` matches at any position between two word characters as well as at any position between two non-word characters.  

`\W` is short for `[^\w]`, the negated version of `\w`.  

#### Answer 2 (score 20)
`\w` matches a word character. `\b` is a zero-width match that matches a position character that has a word character on one side, and something that's not a word character on the other. (Examples of things that aren't word characters include whitespace, beginning and end of the string, etc.)  

<p>`\w` matches `a`, `b`, `c`, `d`, `e`, and `f` in `"abc def"`<br>
`\b` matches the (zero-width) position before `a`, after `c`, before `d`, and after `f` in `"abc def"`</p>

See: <a href="http://www.regular-expressions.info/reference.html/" rel="noreferrer">http://www.regular-expressions.info/reference.html/</a>  

#### Answer 3 (score 8)
@Mahender, you probably meant the difference between `\W` (instead of `\w`) and `\b`. If not, then I would agree with @BoltClock and @jwismar above. Otherwise continue reading.  

`\W` would match any non-word character and so its easy to try to use it to match word boundaries. The problem is that it will not match the start or end of a line. `\b` is more suited for matching word boundaries as it will also match the start or end of a line. Roughly speaking (more experienced users can correct me here) `\b` can be thought of as `(\W|^|$)`. [Edit: as @Ωmega mentions below, `\b` is a zero-length match so `(\W|^|$)` is not strictly correct, but hopefully helps explain the diff]  

Quick example: For the string `Hello World`, `.+\W` would match `Hello_` (with the space) but will not match `World`. `.+\b` would match both `Hello` and `World`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: In Perl, how can I read an entire file into a string? (score [171157](https://stackoverflow.com/q/953707) in 2014)

#### Question
I'm trying to open an .html file as one big long string.  This is what I've got:  

```perl
open(FILE, 'index.html') or die "Can't read file 'filename' [$!]\n";  
$document = <FILE>; 
close (FILE);  
print $document;
```

which results in:   

<blockquote>
  `&lt;!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN`  
</blockquote>

However, I want the result to look like:   

<blockquote>
  <p><code>&lt;!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"<br>
  "http://www.w3.org/TR/html4/loose.dtd"&gt;<br>
  &lt;html&gt;<br>
  &lt;head&gt;<br>
  &lt;meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"&gt;
  </code></p>
</blockquote>

This way I can search the entire document more easily.  

#### Answer accepted (score 76)
Add:  

```perl
 local $/;
```

before reading from the file handle. See <em><a href="https://metacpan.org/pod/perlfaq5#How-can-I-read-in-an-entire-file-all-at-once" rel="noreferrer">How can I read in an entire file all at once?</a></em>, or   

<pre>$ perldoc -q "entire file"</pre>

See <em><a href="https://metacpan.org/pod/perlvar#Variables-related-to-filehandles" rel="noreferrer">Variables related to filehandles</a></em> in `perldoc perlvar` and <a href="https://metacpan.org/pod/perlfunc#local-EXPR" rel="noreferrer">`perldoc -f local`</a>.  

Incidentally, if you can put your script on the server, you can have all the modules you want. See <em><a href="https://metacpan.org/pod/perlfaq8#How-do-I-keep-my-own-module-library-directory" rel="noreferrer">How do I keep my own module/library directory?</a></em>.  

In addition, <a href="https://metacpan.org/pod/Path::Class::File" rel="noreferrer">Path::Class::File</a> allows you to <a href="https://metacpan.org/pod/Path::Class::File#file-slurp" rel="noreferrer">slurp</a> and <a href="https://metacpan.org/pod/Path::Class::File#file-spew-content" rel="noreferrer">spew</a>.  

<a href="https://metacpan.org/pod/Path::Tiny" rel="noreferrer">Path::Tiny</a> gives even more convenience methods such as <a href="https://metacpan.org/pod/Path::Tiny#slurp-slurp_raw-slurp_utf8" rel="noreferrer">`slurp`, `slurp_raw`, `slurp_utf8`</a> as well as their <a href="https://metacpan.org/pod/Path::Tiny#spew-spew_raw-spew_utf8" rel="noreferrer">`spew`</a> counterparts.  

#### Answer 2 (score 93)
I would do it like this:  

```perl
my $file = "index.html";
my $document = do {
    local $/ = undef;
    open my $fh, "<", $file
        or die "could not open $file: $!";
    <$fh>;
};
```

Note the use of the three-argument version of open. It is much safer than the old two- (or one-) argument versions. Also note the use of a lexical filehandle. Lexical filehandles are nicer than the old bareword variants, for many reasons. We are taking advantage of one of them here: they close when they go out of scope.  

#### Answer 3 (score 75)
With <a href="https://metacpan.org/module/File::Slurp" rel="noreferrer">File::Slurp</a>:  

```perl
use File::Slurp;
my $text = read_file('index.html');
```

<a href="http://www.perlmonks.org/?node_id=693828" rel="noreferrer">Yes, even you can use CPAN</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: How to match any non white space character except a particular one? (score [168481](https://stackoverflow.com/q/6125098) in 2014)

#### Question
In Perl `\S` matches any non-whitespace character.  

How can I match any non-whitespace character except a backslash `\`?  

#### Answer accepted (score 136)
You can use a <a href="http://www.regular-expressions.info/charclass.html" rel="noreferrer">character class</a>:  

```perl
/[^\s\\]/
```

matches anything that is not a whitespace character nor a `\`.  Here's another example:  

`[abc]` means "match `a`, `b` or `c`"; `[^abc]` means "match any character except `a`, `b` or `c`".  

#### Answer 2 (score 12)
You can use a lookahead:  

```perl
/(?=\S)[^\\]/
```

#### Answer 3 (score 2)
This worked for me using <strong>sed</strong> [<strong>Edit:</strong> comment below points out sed doesn't support \s]  

```perl
[^ ]
```

while  

```perl
[^\s] 
```

didn't  

```perl
# Delete everything except space and 'g'
echo "ghai ghai" | sed "s/[^\sg]//g"
gg

echo "ghai ghai" | sed "s/[^ g]//g"
g g
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: no pg_hba.conf entry for host (score [161302](https://stackoverflow.com/q/1406025) in 2016)

#### Question
I get following error when I try to connect using DBI  

<pre>
DBI connect('database=chaosLRdb;host=192.168.0.1;port=5433','postgres',...) 
failed: FATAL:  no pg_hba.conf entry for host "192.168.0.1", user "postgres", database "chaosLRdb", SSL off
</pre>

Here is my pg_hba.conf file:  

```perl
# "local" is for Unix domain socket connections only
local   all         all                               md5
# IPv4 local connections:
host    all         all         127.0.0.1/32          md5
# IPv6 local connections:
host    all         all         ::1/128               md5

host    all         postgres    127.0.0.1/32          trust

host    all        postgres     192.168.0.1/32        trust

host    all        all         192.168.0.1/32        trust

host    all        all         192.168.0.1/128        trust

host    all        all         192.168.0.1/32        md5

host    chaosLRdb    postgres         192.168.0.1/32      md5
local    all        all         192.168.0.1/32        trust
```

My perl code is   

```perl
#!/usr/bin/perl-w
use DBI;
use FileHandle;

print "Start connecting to the DB...\n";

@ary = DBI->available_drivers(true);
%drivers = DBI->installed_drivers();
my $dbh = DBI->connect("DBI:PgPP:database=chaosLRdb;host=192.168.0.1;port=5433", "postgres", "chaos123");
```

May I know what i miss here?  

#### Answer 2 (score 34)
In your pg_hba.conf file, I see some incorrect and confusing lines:  

```perl
# fine, this allows all dbs, all users, to be trusted from 192.168.0.1/32
# not recommend because of the lax permissions
host    all        all         192.168.0.1/32        trust

# wrong, /128 is an invalid netmask for ipv4, this line should be removed
host    all        all         192.168.0.1/128       trust

# this conflicts with the first line
# it says that that the password should be md5 and not plaintext
# I think the first line should be removed
host    all        all         192.168.0.1/32        md5

# this is fine except is it unnecessary because of the previous line
# which allows any user and any database to connect with md5 password
host    chaosLRdb  postgres    192.168.0.1/32        md5

# wrong, on local lines, an IP cannot be specified
# remove the 4th column
local   all        all         192.168.0.1/32        trust
```

I suspect that if you md5'd the password, this might work if you trim the lines.  To get the md5 you can use perl or the following shell script:  

```perl
 echo -n 'chaos123' | md5sum
 > d6766c33ba6cf0bb249b37151b068f10  -
```

So then your connect line would like something like:  

```perl
my $dbh = DBI->connect("DBI:PgPP:database=chaosLRdb;host=192.168.0.1;port=5433",
    "chaosuser", "d6766c33ba6cf0bb249b37151b068f10");
```

For more information, here's the <a href="http://www.postgresql.org/docs/8.0/interactive/client-authentication.html" rel="nofollow noreferrer">documentation of postgres 8.X's pg_hba.conf file</a>.  

#### Answer 3 (score 18)
If you can change this line:  

```perl
host    all        all         192.168.0.1/32        md5
```

With this:  

```perl
host    all        all         all                   md5
```

You can see if this solves the problem.  

But another consideration is your postgresql port(5432) is very open to password attacks with hackers (maybe they can brute force the password). You can change your postgresql port 5432 to '33333' or another value, so they can't know this configuration.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: Array initialization in Perl (score [161143](https://stackoverflow.com/q/3251495) in 2015)

#### Question
How do I initialize an array to 0?  

I have tried this.  

```perl
my @arr = ();
```

But it always throws me a warning, <em>"Use of uninitialized value"</em>. I do not know the size of the array beforehand. I fill it dynamically. I thought the above piece of code was supposed to initialize it to 0.  

How do I do this?  

#### Answer accepted (score 51)
If I understand you, perhaps you don't need an array of zeroes; rather, you need a <strong>hash</strong>. The hash keys will be the values in the other array and the hash values will be the number of times the value exists in the other array:  

```perl
use strict;
use warnings;

my @other_array = (0,0,0,1,2,2,3,3,3,4);
my %tallies;
$tallies{$_} ++ for @other_array;

print "$_ => $tallies{$_}\n" for sort {$a <=> $b} keys %tallies;    
```

Output:  

```perl
0 => 3
1 => 1
2 => 2
3 => 3
4 => 1
```

To answer your specific question more directly, to create an array populated with a bunch of zeroes, you can use the technique in these two examples:  

```perl
my @zeroes = (0) x 5;            # (0,0,0,0,0)

my @zeroes = (0) x @other_array; # A zero for each item in @other_array.
                                 # This works because in scalar context
                                 # an array evaluates to its size.
```

#### Answer 2 (score 18)
What do you mean by "initialize an array to zero"?  Arrays don't contain "zero" -- they can contain "zero elements", which is the same as "an empty list".  Or, you could have an array with one element, where that element is a zero: `my @array = (0);`  

`my @array = ();` should work just fine -- it allocates a new array called `@array`, and then assigns it the empty list, `()`.  Note that this is identical to simply saying `my @array;`, since the initial value of a new array is the empty list anyway.  

Are you sure you are getting an error from this line, and not somewhere else in your code?  Ensure you have `use strict; use warnings;` in your module or script, and check the line number of the error you get.  (Posting some contextual code here might help, too.)  

#### Answer 3 (score 3)
To produce the output in your comment to your post, this will do it:  

```perl
use strict;
use warnings;

my @other_array = (0,0,0,1,2,2,3,3,3,4);
my @array;
my %uniqs;

$uniqs{$_}++ for @other_array;

foreach (keys %uniqs) { $array[$_]=$uniqs{$_} }

print "array[$_] = $array[$_]\n" for (0..$#array);
```

Output:  

```perl
   array[0] = 3
   array[1] = 1
   array[2] = 2
   array[3] = 3
   array[4] = 1
```

This is different than your stated algorithm of producing a parallel array with zero values, but it is a more Perly way of doing it...  

If you must have a parallel array that is the same size as your first array with the elements initialized to 0, this statement will dynamically do it: `@array=(0) x scalar(@other_array);` but really, you don't need to do that.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: How do I configure Apache 2 to run Perl CGI scripts? (score [157915](https://stackoverflow.com/q/560749) in 2016)

#### Question
I would like to configure Apache 2 running on `Kubuntu` to execute Perl CGI scripts. I've tried some steps that I came across by googling, but nothing seems to work.  

What is the right way of achieving this?  

#### Answer 2 (score 24)
This post is intended to rescue the people who are suffering from *not being able to properly setup Apache2 for Perl on Ubuntu. (The system configurations specific to your Linux machine will be mentioned within square brackets, like [this]).  

Possible outcome of an improperly setup Apache 2:  

<ol>
<li>Browser trying to download the .pl file instead of executing and giving out the result.</li>
<li>Forbidden.</li>
<li>Internal server error.</li>
</ol>

If one follows the steps described below with a reasonable intelligence, he/she can get through the errors mentioned above.  

Before starting the steps. Go to `/etc/hosts` file and add IP address / domain-name` for example:  

```perl
127.0.0.1 www.BECK.com
```

<p>Step 1: Install `apache2`
Step 2: Install `mod_perl`
Step 3: Configure `apache2`</p>

open `sites-available/default` and add the following,  

```perl
<Files ~ "\.(pl|cgi)$">
    SetHandler perl-script
    PerlResponseHandler ModPerl::PerlRun
    Options +ExecCGI
    PerlSendHeader On
</Files>

<Directory />
    Options FollowSymLinks
    AllowOverride None
</Directory>
<Directory [path-to-store-your-website-files-like-.html-(perl-scripts-should-be-stored-in-cgi-bin] >
####(The Perl/CGI scripts can be stored out of the cgi-bin directory, but that's a story for another day. Let's concentrate on washing out the issue at hand)
####
    Options Indexes FollowSymLinks MultiViews
    AllowOverride None
    Order allow,deny
    allow from all
</Directory>

ScriptAlias /cgi-bin/ [path-where-you-want-your-.pl-and-.cgi-files]

<Directory [path-where-you-want-your-.pl-and-.cgi-files]>
    AllowOverride None
    Options ExecCGI -MultiViews +SymLinksIfOwnerMatch
    AddHandler cgi-script .pl
    Order allow,deny
    allow from all
</Directory>
<Files ~ "\.(pl|cgi)$">
    SetHandler perl-script
    PerlResponseHandler ModPerl::PerlRun
    Options +ExecCGI
    PerlSendHeader On
</Files>

<Directory />
    Options FollowSymLinks
    AllowOverride None
</Directory>
<Directory [path-to-store-your-website-files-like-.html-(perl-scripts-should-be-stored-in-cgi-bin] >
####(The Perl/CGI scripts can be stored out of the cgi-bin directory, but that's a story for another day. Let's concentrate on washing out the issue at hand)
####
    Options Indexes FollowSymLinks MultiViews
    AllowOverride None
    Order allow,deny
    allow from all
</Directory>

ScriptAlias /cgi-bin/ [path-where-you-want-your-.pl-and-.cgi-files]

<Directory [path-where-you-want-your-.pl-and-.cgi-files]>
    AllowOverride None
    Options ExecCGI -MultiViews +SymLinksIfOwnerMatch
    AddHandler cgi-script .pl
    Order allow,deny
    allow from all
</Directory>
```

<h5>Step 4:</h3>

Add the following lines to your `/etc/apache2/apache2.conf` file.  

```perl
AddHandler cgi-script .cgi .pl
<Files ~ "\.pl$">
Options +ExecCGI
</Files>
<Files ~ "\.cgi$">
Options +ExecCGI
</Files>

<IfModule mod_perl.c>
<IfModule mod_alias.c>
Alias /perl/ /home/sly/host/perl/
</IfModule>
<Location /perl>
SetHandler perl-script
PerlHandler Apache::Registry
Options +ExecCGI
</Location>
</IfModule>

<Files ~ "\.pl$">
Options +ExecCGI
</Files>
```

<h5>Step 5:</h3>

<strong>Very important</strong>, or at least I guess so, only after doing this step, I got it to work.  

`AddHandler cgi-script .cgi .pl`  

```perl
<Files ~ "\.pl$">
Options +ExecCGI
</Files>
<Files ~ "\.cgi$">
Options +ExecCGI
</Files>

<IfModule mod_perl.c>
<IfModule mod_alias.c>
Alias /perl/ /home/sly/host/perl/
</IfModule>
<Location /perl>
SetHandler perl-script
PerlHandler Apache::Registry
Options +ExecCGI
</Location>
</IfModule>

<Files ~ "\.pl$">
Options +ExecCGI
</Files>
```

<h5>Step 6</h3>

<strong>Very important</strong>, or at least I guess so, only after doing this step, I got it to work.  

Add the following to you `/etc/apache2/sites-enabled/000-default` file  

```perl
<Files ~ "\.(pl|cgi)$">
SetHandler perl-script
PerlResponseHandler ModPerl::PerlRun
Options +ExecCGI
PerlSendHeader On
</Files>
```

<h5>Step 7:</h3>

Now add, your Perl script as test.pl in the place where you mentioned before in step 3 as [<em>path-where-you-want-your-.pl-and-.cgi-files</em>].  

Give permissions to the `.pl` file using `chmod` and then, type the `webaddress/cgi-bin/test.pl` in the address bar of the browser, there you go, you got it.  

(Now, many of the things would have been redundant in this post. Kindly ignore it.)  

#### Answer 3 (score 19)
You'll need to take a look at your Apache error log to see what the "internal server error" is. The four most likely cases, in my experience would be:  

<ol>
<li><p>The CGI program is in a directory which does not have CGI execution enabled. Solution:  Add the `ExecCGI` option to that directory via either httpd.conf or a .htaccess file.</p></li>
<li><p>Apache is only configured to run CGIs from a dedicated `cgi-bin` directory. Solution: Move the CGI program there or add an `AddHandler cgi-script .cgi` statement to httpd.conf.</p></li>
<li><p>The CGI program is not set as executable. Solution (assuming a *nix-type operating system): `chmod +x my_prog.cgi`</p></li>
<li><p>The CGI program is exiting without sending headers. Solution: Run the program from the command line and verify that a) it actually runs rather than dying with a compile-time error and b) it generates the correct output, which should include, at the very minimum, a `Content-Type` header and a blank line following the last of its headers.</p></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: How can I check if a Perl module is installed on my system from the command line? (score [157845](https://stackoverflow.com/q/1039107) in 2009)

#### Question
I tried to check if XML::Simple is installed in my system or not.  

```perl
perl -e 'while (<@INC>) { while (<$_/*.pm>) { print "$_\n"; } }'
```

The above one-liner was used for listing all modules installed in my system. However, it is not listing XML modules.  

However, the following executes fine.  

```perl
perl -e "use XML::Simple "
```

What might be the issue?  

#### Answer accepted (score 93)
You can check for a module's installation path by:  

```perl
perldoc -l XML::Simple
```

The problem with your one-liner is that, it is not recursively traversing directories/sub-directories. Hence, you get only pragmatic module names as output.  

#### Answer 2 (score 39)
Quick and dirty:  

```perl
$ perl -MXML::Simple -e 1
```

#### Answer 3 (score 17)
<pre>$ perl -MXML::Simple -le 'print $INC{"XML/Simple.pm"}'</pre>

From the <a href="http://perldoc.perl.org/perlvar.html" rel="noreferrer">perlvar</a> entry on <a href="http://perldoc.perl.org/perlvar.html#%INC" rel="noreferrer">`%INC`</a>:  

<blockquote>
  <ul>
  <li><strong>%INC</strong></li>
  </ul>
  
  The hash `%INC` contains entries for each filename included via the `do`, `require`, or `use` operators. The key is the filename you specified (with module names converted to pathnames), and the value is the location of the file found. The `require` operator uses this hash to determine whether a particular file has already been included.  
  
  If the file was loaded via a hook (e.g. a subroutine reference, see <a href="http://perldoc.perl.org/functions/require.html" rel="noreferrer">require</a> for a description of these hooks), this hook is by default inserted into `%INC` in place of a filename. Note, however, that the hook may have set the %INC entry by itself to provide some more specific info.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: Escaping a forward slash in a regular expression (score [156283](https://stackoverflow.com/q/6076229) in 2011)

#### Question
My question is a simple one, and it is about regular expression escaping. Do you have to escape a forward slash `/` in a regular expression? And how would you go about doing it?  

#### Answer accepted (score 79)
What context/language?  Some languages use `/` as the pattern delimiter, so yes, you need to escape it, depending on which language/context.  You escape it by putting a backward slash in front of it: `\/` For some languages (like PHP) you can use other characters as the delimiter and therefore you don't need to escape it. But AFAIK in all languages, the only special significance the `/` has is it may be the designated pattern delimiter.   

#### Answer 2 (score 35)
Here are a few options:  

<ul>
<li><p>In Perl, you can choose alternate delimiters.  You're not confined to `m//`.  You could choose another, such as `m{}`.  Then escaping isn't necessary.  As a matter of fact, Damian Conway in "Perl Best Practices" asserts that `m{}` is the only alternate delimiter that ought to be used, and this is reinforced by Perl::Critic (on CPAN).  While you can get away with using a variety of alternate delimiter characters, `//` and `{}` seem to be the clearest to decipher later on.  However, if either of those choices result in too much escaping, choose whichever one lends itself best to legibility.  Common examples are `m(...)`, `m[...]`, and `m!...!`.</p></li>
<li><p>In cases where you either cannot or prefer not to use alternate delimiters, you can escape the forward slashes with a backslash:  `m/\/[^/]+$/` for example (using an alternate delimiter that could become `m{/[^/]+$}`, which may read more clearly).  Escaping the slash with a backslash is common enough to have earned a name and a wikipedia page: <a href="https://en.wikipedia.org/wiki/Leaning_toothpick_syndrome" rel="noreferrer">Leaning Toothpick Syndrome</a>.  In regular expressions where there's just a single instance, escaping a slash might not rise to the level of being considered a hindrance to legibility, but if it starts to get out of hand, and if your language permits alternate delimiters as Perl does, that would be the preferred solution.</p></li>
</ul>

#### Answer 3 (score 9)
<p>Use the backslash `\` or choose a different delimiter, ie `m#.\d#` instead of `/.\d/`
"In Perl, you can change the / regular expression delimiter to almost any other special character if you preceed it with the letter m (for match);"</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How to print variables in Perl (score [148908](https://stackoverflow.com/q/6181381) in 2017)

#### Question
I have some code that looks like  

```perl
my ($ids,$nIds);
while (<myFile>){
    chomp;
    $ids.= $_ . " ";
    $nIds++;
}
```

This should concatenate every line in my `myFile`, and `nIds` should be my number of lines. How do I print out my `$ids` and `$nIds`?  

I tried simply `print $ids`, but Perl complains.  

```perl
my ($ids, $nIds)
```

is a list, right? With two elements?  

#### Answer accepted (score 33)
```perl
print "Number of lines: $nids\n";
print "Content: $ids\n";
```

How did Perl complain?  `print $ids` should work, though you probably want a newline at the end, either explicitly with `print` as above or implicitly by using `say` or <a href="http://perldoc.perl.org/perlrun.html#*-l*%5B_octnum_%5D" rel="noreferrer">-l</a>/<a href="http://perldoc.perl.org/perlvar.html#$%5C" rel="noreferrer">$\</a>.  

If you want to interpolate a variable in a string and have something immediately after it that would looks like part of the variable but isn't, enclose the variable name in `{}`:  

```perl
print "foo${ids}bar";
```

#### Answer 2 (score 11)
You should always include all relevant code when asking a question. In this case, the print statement that is the center of your question. The print statement is probably the most crucial piece of information. The second most crucial piece of information is the error, which you also did not include. Next time, include both of those.  

`print $ids` should be a fairly hard statement to mess up, but it is possible. Possible reasons:  

<ol>
<li>`$ids` is undefined. Gives the warning `undefined value in print`</li>
<li>`$ids` is out of scope. With <code>use
strict</code>, gives fatal warning <code>Global
variable $ids needs explicit package
name</code>, and otherwise the undefined
warning from above.</li>
<li>You forgot a semi-colon at the end of
the line.</li>
<li>You tried to do `print $ids $nIds`,
in which case perl thinks that `$ids`
is supposed to be a filehandle, and
you get an error such as <code>print to
unopened filehandle</code>.</li>
</ol>

<strong>Explanations</strong>  

1: Should not happen. It <em>might</em> happen if you do something like this (assuming you are not using `strict`):  

```perl
my $var;
while (<>) {
    $Var .= $_;
}
print $var;
```

Gives the warning for undefined value, because `$Var` and `$var` are two different variables.   

2: Might happen, if you do something like this:  

```perl
if ($something) {
    my $var = "something happened!";
}
print $var;
```

`my` declares the variable inside the current block. Outside the block, it is out of scope.  

3: Simple enough, common mistake, easily fixed. Easier to spot with `use warnings`.  

4: Also a common mistake. There are a number of ways to correctly print two variables in the same `print` statement:  

```perl
print "$var1 $var2";  # concatenation inside a double quoted string
print $var1 . $var2;  # concatenation
print $var1, $var2;   # supplying print with a list of args
```

<hr>

Lastly, some perl magic tips for you:  

```perl
use strict;
use warnings;

# open with explicit direction '<', check the return value
# to make sure open succeeded. Using a lexical filehandle.
open my $fh, '<', 'file.txt' or die $!;

# read the whole file into an array and
# chomp all the lines at once
chomp(my @file = <$fh>);
close $fh;

my $ids  = join(' ', @file);
my $nIds = scalar @file;
print "Number of lines: $nIds\n";
print "Text:\n$ids\n";
```

Reading the whole file into an array is suitable for small files only, otherwise it uses a lot of memory. Usually, line-by-line is preferred.  

Variations:  

<ul>
<li>`print "@file"` is equivalent to
`$ids = join(' ',@file); print $ids;`</li>
<li>`$#file` will return the last index
in `@file`. Since arrays usually start at 0,
`$#file + 1` is equivalent to `scalar @file`. </li>
</ul>

You can also do:  

```perl
my $ids;
do {
    local $/;
    $ids = <$fh>;
}
```

By temporarily "turning off" `$/`, the input record separator, i.e. newline, you will make `&lt;$fh&gt;` return the entire file. What `&lt;$fh&gt;` really does is read until it finds `$/`, then return that string. Note that this will preserve the newlines in `$ids`.  

Line-by-line solution:  

```perl
open my $fh, '<', 'file.txt' or die $!; # btw, $! contains the most recent error
my $ids;
while (<$fh>) {
    chomp;
    $ids .= "$_ "; # concatenate with string
}
my $nIds = $.; # $. is Current line number for the last filehandle accessed.
```

#### Answer 3 (score 9)
<blockquote>How do I print out my $ids and $nIds?</blockquote>

```perl
print "$ids\n";
print "$nIds\n";
```

<blockquote>I tried simply `print $ids`, but Perl complains.</blockquote>

Complains about what? Uninitialised value? Perhaps your loop was never entered due to an error opening the file. Be sure to check if `open` returned an error, and make sure you are using `use strict; use warnings;`.  

<blockquote>`my ($ids, $nIds)` is a list, right? With two elements?</blockquote>

It's a (very special) function call. `$ids,$nIds` is a list with two elements.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: What is the best way to delete a value from an array in Perl? (score [144303](https://stackoverflow.com/q/174292) in 2014)

#### Question
The array has lots of data and I need to delete two elements.   

Below is the code snippet I am using,  

```perl
my @array = (1,2,3,4,5,5,6,5,4,9);
my $element_omitted = 5;
@array = grep { $_ != $element_omitted } @array;
```

#### Answer accepted (score 85)
Use splice if you already know the index of the element you want to delete.  

Grep works if you are searching.  

If you need to do a lot of these, you will get much better performance if you keep your array in sorted order, since you can then do binary search to find the necessary index.  

If it makes sense in your context, you may want to consider using a "magic value" for deleted records, rather then deleting them, to save on data movement -- set deleted elements to undef, for example.  Naturally, this has its own issues (if you need to know the number of "live" elements, you need to keep track of it separately, etc), but may be worth the trouble depending on your application.  

<strong>Edit</strong> Actually now that I take a second look -- don't use the grep code above. It would be more efficient to find the index of the element you want to delete, then use splice to delete it (the code you have accumulates all the non-matching results..)  

```perl
my $index = 0;
$index++ until $arr[$index] eq 'foo';
splice(@arr, $index, 1);
```

<p>That will delete the first occurrence.
Deleting all occurrences is very similar, except you will want to get all indexes in one pass:</p>

```perl
my @del_indexes = grep { $arr[$_] eq 'foo' } 0..$#arr;
```

The rest is left as an excercise for the reader -- remember that the array changes as you splice it!  

<strong>Edit2</strong> John Siracusa correctly pointed out I had a bug in my example.. fixed, sorry about that.  

#### Answer 2 (score 13)
<a href="http://www.perlmonks.org/?node=perlfunc%3Asplice" rel="noreferrer">splice</a> will remove array element(s) by index.  Use grep, as in your example, to search and remove.  

#### Answer 3 (score 8)
Is this something you are going to be doing a lot?  If so, you may want to consider a different data structure.  Grep is going to search the entire array every time and for a large array could be quite costly.  If speed is an issue then you may want to consider using a Hash instead.  

In your example, the key would be the number and the value would be the count of elements of that number.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: How is Perl's @INC constructed? (aka What are all the ways of affecting where Perl modules are searched for?) (score [141297](https://stackoverflow.com/q/2526804) in 2017)

#### Question
<p>What are all the ways of affecting where Perl modules are searched for?
or, <strong>How is Perl's @INC constructed</strong>? </p>

As we know, <a href="https://stackoverflow.com/questions/2526520/how-does-a-perl-program-know-where-to-find-the-file-containing-perl-module-it-use">Perl uses `@INC` array containing directory names to determine where to search for Perl module files</a>.   

There does not seem to be a comprehensive "@INC" FAQ-type post on StackOverflow, so this question is intended as one.   

#### Answer accepted (score 252)
We will look at how the contents of this array are constructed and can be manipulated to affect where the Perl interpreter will find the module files.  

<ol>
<li><p>Default `@INC`</p>

Perl interpreter is <a href="http://search.cpan.org/perldoc/INSTALL" rel="noreferrer">compiled with a specific `@INC` default value</a>. To find out this value, run `env -i perl -V` command (`env -i` ignores the `PERL5LIB` environmental variable - see #2) and in the output you will see something like this:  

<blockquote>
```perl
$ env -i perl -V
...
@INC:
 /usr/lib/perl5/site_perl/5.18.0/x86_64-linux-thread-multi-ld
 /usr/lib/perl5/site_perl/5.18.0
 /usr/lib/perl5/5.18.0/x86_64-linux-thread-multi-ld
 /usr/lib/perl5/5.18.0
 .
```
</blockquote></li>
</ol>

Note `.` at the end; this is the current directory (which is not necessarily the same as the script's directory). It is missing in Perl 5.26+, and when Perl runs with <a href="http://perldoc.perl.org/perlrun.html#*-T*" rel="noreferrer">`-T` (taint checks enabled)</a>.  

To change the default path when configuring Perl binary compilation, set the configuration option <a href="http://search.cpan.org/perldoc?INSTALL#otherlibdirs" rel="noreferrer">`otherlibdirs`</a>:  

<blockquote>
  `Configure -Dotherlibdirs=/usr/lib/perl5/site_perl/5.16.3`  
</blockquote>

<ol start="2">
<li><p>Environmental variable `PERL5LIB` (or `PERLLIB`)</p>

Perl pre-pends `@INC` with a list of directories (colon-separated) contained in `PERL5LIB` (if it is not defined, `PERLLIB` is used) environment variable of your shell. To see the contents of `@INC` after `PERL5LIB` and `PERLLIB` environment variables have taken effect, run `perl -V`.  

<blockquote>
```perl
$ perl -V
...
%ENV:
  PERL5LIB="/home/myuser/test"
@INC:
 /home/myuser/test
 /usr/lib/perl5/site_perl/5.18.0/x86_64-linux-thread-multi-ld
 /usr/lib/perl5/site_perl/5.18.0
 /usr/lib/perl5/5.18.0/x86_64-linux-thread-multi-ld
 /usr/lib/perl5/5.18.0
 .
```
</blockquote></li>
<li><p>`-I` command-line option</p>

Perl pre-pends `@INC` with a list of directories (colon-separated) passed as value of the `-I` command-line option. This can be done in three ways, as usual with Perl options:  

<ul>
<li><p>Pass it on command line:</p>

```perl
perl -I /my/moduledir your_script.pl
```</li>
<li><p>Pass it via the first line (shebang) of your Perl script:</p>

```perl
#!/usr/local/bin/perl -w -I /my/moduledir
```</li>
<li><p>Pass it as part of `PERL5OPT` (or `PERLOPT`) environment variable (see chapter 19.02 in <a href="http://oreilly.com/catalog/9780596004927" rel="noreferrer">Programming Perl</a>)</p></li>
</ul></li>
<li><p>Pass it via the <a href="http://perldoc.perl.org/lib.html" rel="noreferrer">`lib` pragma</a></p>

Perl pre-pends `@INC` with a list of directories passed in to it via `use lib`.  

In a program:  

```perl
use lib ("/dir1", "/dir2");
```

On the command line:  

```perl
perl -Mlib=/dir1,/dir2
```

You can also <a href="http://perldoc.perl.org/lib.html#Deleting-directories-from-@INC" rel="noreferrer">remove the directories from `@INC` via `no lib`</a>.  </li>
<li><p>You can directly manipulate `@INC` as a regular Perl array.</p>

Note: Since `@INC` is used during the compilation phase, this must be done inside of a `BEGIN {}` block, which precedes the `use MyModule` statement.  

<ul>
<li><p>Add directories to the beginning via `unshift @INC, $dir`.</p></li>
<li><p>Add directories to the end via `push @INC, $dir`.</p></li>
<li><p>Do anything else you can do with a Perl array.</p></li>
</ul></li>
</ol>

Note: The directories are <em>unshifted</em> onto `@INC` in the order listed in this answer, e.g. default `@INC` is last in the list, preceded by `PERL5LIB`, preceded by `-I`, preceded by `use lib` and direct `@INC` manipulation, the latter two mixed in whichever order they are in Perl code.  

<h5>References:</h3>

<ul>
<li><a href="http://perldoc.perl.org/perlmod.html#Perl-Modules" rel="noreferrer">perldoc perlmod</a></li>
<li><a href="http://perldoc.perl.org/lib.html" rel="noreferrer">perldoc lib</a></li>
<li><a href="http://world.std.com/~swmcd/steven/perl/module_mechanics.html" rel="noreferrer">Perl Module Mechanics - a great guide containing practical HOW-TOs</a></li>
<li><a href="https://stackoverflow.com/questions/185114/how-do-i-use-a-perl-module-in-a-directory-not-in-inc">How do I 'use' a Perl module in a directory not in `@INC`?</a></li>
<li><a href="https://rads.stackoverflow.com/amzn/click/com/0596000278" rel="noreferrer" rel="nofollow noreferrer">Programming Perl</a> - chapter 31 part 13, ch 7.2.41</li>
<li><a href="https://stackoverflow.com/questions/2526520/how-does-a-perl-program-know-where-to-find-the-file-containing-perl-module-it-use">How does a Perl program know where to find the file containing Perl module it uses?</a></li>
</ul>

There does not seem to be a comprehensive `@INC` FAQ-type post on Stack Overflow, so this question is intended as one.  

<h5>When to use each approach?</h3>

<ul>
<li><p>If the modules in a directory need to be used by many/all scripts on your site, especially run by multiple users, that directory should be included in the default `@INC` compiled into the Perl binary.</p></li>
<li><p>If the modules in the directory will be used exclusively by a specific user for all the scripts that user runs (or if recompiling Perl is not an option to change default `@INC` in previous use case), set the users' `PERL5LIB`, usually during user login.</p>

<em>Note: Please be aware of the usual Unix environment variable pitfalls - e.g. in certain cases running the scripts as a particular user does not guarantee running them with that user's environment set up, e.g. via `su`.</em>  </li>
<li><p>If the modules in the directory need to be used only in specific circumstances (e.g. when the script(s) is executed in development/debug mode, you can either set `PERL5LIB` manually, or pass the `-I` option to perl.</p></li>
<li><p>If the modules need to be used only for specific scripts, by <em>all</em> users using them, use `use lib`/`no lib` pragmas in the program itself. It also should be used when the directory to be searched needs to be dynamically determined during runtime - e.g. from the script's command line parameters or script's path (see the <a href="http://p3rl.org/FindBin" rel="noreferrer">FindBin</a> module for very nice use case).</p></li>
<li><p>If the directories in `@INC` need to be manipulated according to some complicated logic, either impossible to too unwieldy to implement by combination of `use lib`/`no lib` pragmas, then use direct `@INC` manipulation inside `BEGIN {}` block or inside a special purpose library designated for `@INC` manipulation, which must be used by your script(s) before any other modules are used.</p>

<p>An example of this is automatically switching between libraries in prod/uat/dev directories, with waterfall library pickup in prod if it's missing from dev and/or UAT (the last condition makes the standard "use lib + FindBin" solution fairly complicated.
A detailed illustration of this scenario is in <a href="https://stackoverflow.com/questions/2474588/how-do-i-use-beta-perl-modules-from-beta-perl-scripts"><em>How do I use beta Perl modules from beta Perl scripts?</em></a>.</p></li>
<li><p>An additional use case for directly manipulating `@INC` is to be able to add subroutine references or object references (yes, Virginia, `@INC` can contain custom Perl code and not just directory names, as explained in <a href="https://stackoverflow.com/questions/2541119/when-is-a-subroutine-reference-in-inc-called"><em>When is a subroutine reference in @INC called?</em></a>).</p></li>
</ul>

#### Answer 2 (score 17)
In addition to the locations listed above, the OS X version of Perl also has two more ways:  

<ol start="6">
<li><p>The /Library/Perl/x.xx/AppendToPath file.  Paths listed in this file are appended to @INC at runtime.</p></li>
<li><p>The /Library/Perl/x.xx/PrependToPath file.  Paths listed in this file are prepended to @INC at runtime.</p></li>
</ol>

#### Answer 3 (score 6)
As it was said already @INC is an array and you're free to add anything you want.  

My CGI REST script looks like:  

```perl
#!/usr/bin/perl
use strict;
use warnings;
BEGIN {
    push @INC, 'fully_qualified_path_to_module_wiht_our_REST.pm';
}
use Modules::Rest;
gone(@_);
```

Subroutine gone is exported by Rest.pm.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: What is the meaning of @_ in Perl? (score [140281](https://stackoverflow.com/q/4563485) in 2010)

#### Question
What is the meaning of `@_` in Perl?  

#### Answer accepted (score 114)
<a href="http://perldoc.perl.org/perlvar.html#@ARG" rel="noreferrer">perldoc perlvar</a> is the first place to check for any special-named Perl variable info.   

Quoting:  

<blockquote>
  `@_`: Within a subroutine the array `@_` contains the parameters passed to that subroutine.  
</blockquote>

More details can be found in <a href="http://perldoc.perl.org/perlsub.html" rel="noreferrer">perldoc perlsub (Perl subroutines)</a> linked from the perlvar:  

<blockquote>
  <p>Any arguments passed in show up in the
  array `@_` . </p>
  
  <p>Therefore, if you called a function with two arguments, those
  would be stored in `$_[0]` and `$_[1]`.</p>
  
  <p>The array `@_` is a <strong>local array</strong>, but its
  elements are <strong>aliases for the actual scalar parameters</strong>. 
  In particular, if
  an element $_[0] is updated, the
  corresponding argument is updated (or
  an error occurs if it is not
  updatable). </p>
  
  <p>If an argument is an array
  or hash element which did not exist
  when the function was called, that
  element is created only when (and if)
  it is modified or a reference to it is
  taken. (Some earlier versions of Perl
  created the element whether or not the
  element was assigned to.) Assigning to
  the whole array @_ removes that
  aliasing, and does not update any
  arguments.</p>
</blockquote>

#### Answer 2 (score 25)
Usually, you expand the parameters passed to a <em>sub</em> using the `@_` variable:  

```perl
sub test{
  my ($a, $b, $c) = @_;
  ...
}

# call the test sub with the parameters
test('alice', 'bob', 'charlie');
```

That's the way claimed to be correct by <a href="http://www.perlcritic.org/" rel="noreferrer">perlcritic</a>.  

#### Answer 3 (score 10)
The question was what `@_` <em>means</em> in Perl. The answer to that question is that, insofar as `$_` means <strong>it</strong> in Perl, `@_` similarly means <strong>they</strong>.  

No one seems to have mentioned this critical aspect of <em>its</em> meaning — as well as <em>theirs</em>.  

They’re consequently both  used as pronouns, or sometimes as topicalizers.   

They typically have nominal antecedents, although not always.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Submit form and stay on same page? (score [139638](https://stackoverflow.com/q/5733808) in )

#### Question
I have a form that looks like this  

```perl
<form action="receiver.pl" method="post">
  <input name="signed" type="checkbox">
  <input value="Save" type="submit">
</form>
```

and I would like to stay on the same page, when Submit is clicked, but still have `receiver.pl` executed.  

How should that be done?  

#### Answer accepted (score 63)
The easiest answer: jQuery. Do something like this:  

```perl
$(document).ready(function(){
   var $form = $('form');
   $form.submit(function(){
      $.post($(this).attr('action'), $(this).serialize(), function(response){
            // do something here on success
      },'json');
      return false;
   });
});
```

If you want to add content dynamically and still need it to work, and also with more than one form, you can do this:  

```perl
   $('form').live('submit', function(){
      $.post($(this).attr('action'), $(this).serialize(), function(response){
            // do something here on success
      },'json');
      return false;
   });
```

#### Answer 2 (score 63)
99% of the time I would use <a href="https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest" rel="noreferrer">XMLHttpRequest</a> or <a href="https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API" rel="noreferrer">fetch</a> for something like this. However, there's an alternative solution which doesn't require javascript...  

You could include a hidden iframe on your page and set the target attribute of your form to point to that iframe.  

```perl
<style>
  .hide { position:absolute; top:-1px; left:-1px; width:1px; height:1px; }
</style>

<iframe name="hiddenFrame" class="hide"></iframe>

<form action="receiver.pl" method="post" target="hiddenFrame">
  <input name="signed" type="checkbox">
  <input value="Save" type="submit">
</form>
```

There are very few scenarios where I would choose this route. Generally handling it with javascript is better because, with javascript you can...  

<ul>
<li>gracefully handle errors (e.g. retry)</li>
<li>provide UI indicators (e.g. loading, processing, success, failure)</li>
<li>run logic before the request is sent, or run logic after the response is received.</li>
</ul>

#### Answer 3 (score 35)
The HTTP/CGI way to do this would be for your program to return an HTTP status code of 204 (No Content).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Today's Date in Perl in MM/DD/YYYY format (score [138594](https://stackoverflow.com/q/11020812) in 2012)

#### Question
I'm working on a Perl program at work and stuck on (what I think is) a trivial problem. I simply need to build a string in the format '06/13/2012' (always 10 characters, so 0's for numbers less than 10).  

Here's what I have so far:  

```perl
use Time::localtime;
$tm=localtime;
my ($day,$month,$year)=($tm->mday,$tm->month,$tm->year);
```

#### Answer accepted (score 56)
You can do it fast, only using one <a href="http://p3rl.org/POSIX" rel="noreferrer">POSIX</a> function. If you have bunch of tasks with dates, see the module <a href="http://p3rl.org/DateTime" rel="noreferrer">DateTime</a>.  

```perl
use POSIX qw(strftime);

my $date = strftime "%m/%d/%Y", localtime;
print $date;
```

#### Answer 2 (score 54)
You can use <a href="https://metacpan.org/module/Time::Piece" rel="noreferrer">`Time::Piece`</a>, which shouldn't need installing as it is a core module and has been distributed with Perl 5 since version 10.  

```perl
use Time::Piece;

my $date = localtime->strftime('%m/%d/%Y');
print $date;
```

<strong>output</strong>  

```perl
06/13/2012
```

<h5><br/></h2>

<h5>Update</h3>

You may prefer to use the `dmy` method, which takes a single parameter which is the separator to be used between the fields of the result, and avoids having to specify a full date/time format  

```perl
my $date = localtime->dmy('/');
```

This produces an identical result to that of my original solution  

#### Answer 3 (score 12)
```perl
use DateTime qw();
DateTime->now->strftime('%m/%d/%Y')   
```

expression returns `06/13/2012`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: How do I include a Perl module that's in a different directory? (score [138552](https://stackoverflow.com/q/841785) in 2016)

#### Question
How do I include a Perl module that's in a different directory?  It needs to be a relative path from the module that's including it.  

I've tried   

```perl
push ( @INC,"directory_path/more_path");
```

also  

```perl
push ( @INC,"directory_path\\more_path");
```

#### Answer accepted (score 68)
EDIT: Putting the right solution first, originally from <a href="https://stackoverflow.com/questions/185114/how-do-i-use-a-perl-module-in-a-directory-not-in-inc">this question</a>.  It's the only one that searches relative to the <strong>module</strong> directory:  

```perl
use FindBin;                 # locate this script
use lib "$FindBin::Bin/..";  # use the parent directory
use yourlib;
```

There's many other ways that search for libraries relative to the <strong>current</strong> directory.  You can invoke perl with the -I argument, passing the directory of the other module:  

```perl
perl -I.. yourscript.pl
```

You can include a line near the top of your perl script:  

```perl
use lib '..';
```

You can modify the environment variable PERL5LIB before you run the script:  

```perl
export PERL5LIB=$PERL5LIB:..
```

The push(@INC) strategy can also work, but it has to be wrapped in BEGIN{} to make sure that the push is run before the module search:  

```perl
BEGIN {push @INC, '..'}
use yourlib;
```

#### Answer 2 (score 14)
Most likely the reason your push did not work is order of execution.  

`use` is a compile time directive.  You `push` is done at execution time:  

```perl
push ( @INC,"directory_path/more_path");
use Foo.pm;  # In directory path/more_path
```

You can use a BEGIN block to get around this problem:  

```perl
BEGIN {
    push ( @INC,"directory_path/more_path");
}
use Foo.pm;  # In directory path/more_path
```

IMO, it's clearest, and therefore best to `use lib`:  

```perl
use lib "directory_path/more_path";
use Foo.pm;  # In directory path/more_path
```

See <a href="http://perldoc.perl.org/perlmod.html#BEGIN%2c-UNITCHECK%2c-CHECK%2c-INIT-and-END" rel="nofollow noreferrer">perlmod</a> for information about BEGIN and other special blocks and when they execute.  

<strong>Edit</strong>  

For loading code relative to your script/library, I strongly endorse <a href="https://metacpan.org/pod/File::FindLib" rel="nofollow noreferrer">File::FindLib</a>  

You can say `use File::FindLib 'my/test/libs';` to look for a library directory anywhere above your script in the path.    

Say your work is structured like this:  

```perl
   /home/me/projects/
    |- shared/
    |   |- bin/
    |   `- lib/
    `- ossum-thing/
       `- scripts 
           |- bin/
           `- lib/
```

Inside a script in `ossum-thing/scripts/bin`:  

```perl
use File::FindLib 'lib/';
use File::FindLib 'shared/lib/';
```

Will find your library directories and add them to your `@INC`.  

It's also useful to create a module that contains all the environment set-up needed to run your suite of tools and just load it in all the executables in your project.  

```perl
use File::FindLib 'lib/MyEnvironment.pm'
```

#### Answer 3 (score 10)
'use lib' can also take a single string value...  

```perl
#!/usr/bin/perl
use lib '<relative-path>';
use <your lib>;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: Find everything between two XML tags with RegEx (score [137341](https://stackoverflow.com/q/13241615) in 2018)

#### Question
In `RegEx`, I want to find the tag and everything between two `XML tags`, like the following:  

```perl
<primaryAddress>
    <addressLine>280 Flinders Mall</addressLine>
    <geoCodeGranularity>PROPERTY</geoCodeGranularity>
    <latitude>-19.261365</latitude>
    <longitude>146.815585</longitude>
    <postcode>4810</postcode>
    <state>QLD</state>
    <suburb>Townsville</suburb>
    <type>PHYSICAL</type>
</primaryAddress>
```

I want to find the tag and everything between `primaryAddress`, and erase that.   

Everything between the `primaryAddress` tag is a variable, but I want to remove the entire tag and sub-tags whenever I get `primaryAddress`.  

Anyone have any idea how to do that?  

#### Answer accepted (score 109)
<h5>It is not a good idea to use regex for HTML/XML parsing...</h3>

However, if you want to do it anyway, search for regex pattern   

```perl
<primaryAddress>[\s\S]*?<\/primaryAddress>
```

and replace it with empty string...  

#### Answer 2 (score 15)
You should be able to match it with: `/&lt;primaryAddress&gt;(.+?)&lt;\/primaryAddress&gt;/`  

The content between the tags will be in the matched group.  

#### Answer 3 (score 6)
<p>It is not good to use this method but if you really want to split it with regex


```perl
<primaryAddress.*>((.|\n)*?)<\/primaryAddress>
```


the verified answer returns the tags but this just return the value between tags.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: Programmatically read from STDIN or input file in Perl (score [135677](https://stackoverflow.com/q/3138649) in )

#### Question
What is the slickest way to programatically read from stdin or an input file (if provided) in Perl?  

#### Answer accepted (score 81)
```perl
while (<>) {
print;
}
```

will read either from a file specified on the command line or from stdin if no file is given  

If you are required this loop construction in command line, then you may use <a href="http://perldoc.perl.org/perlrun.html#*-n*" rel="noreferrer">`-n`</a> option:  

```perl
$ perl -ne 'print;'
```

Here you just put code between `{}` from first example into `''` in second  

#### Answer 2 (score 44)
This provides a named variable to work with:  

```perl
foreach my $line ( <STDIN> ) {
    chomp( $line );
    print "$line\n";
}
```

To read a file, pipe it in like this:  

```perl
program.pl < inputfile
```

#### Answer 3 (score 14)
The "slickest" way in certain situations is to take advantage of the <a href="http://perldoc.perl.org/perlrun.html#Command-Switches">`-n` switch</a>.  It implicitly wraps your code with a `while(&lt;&gt;)` loop and handles the input flexibly.  

In `slickestWay.pl`:  

<pre>
#!/usr/bin/perl -n

BEGIN: {
  # do something once here
}

# implement logic for a single line of input
print $result;
</pre>

At the command line:  

```perl
chmod +x slickestWay.pl
```

Now, depending on your input do one of the following:  

<ol>
<li><p>Wait for user input</p>

```perl
./slickestWay.pl
```</li>
<li><p>Read from file(s) named in arguments (no redirection required)</p>

```perl
./slickestWay.pl input.txt
./slickestWay.pl input.txt moreInput.txt
```</li>
<li><p>Use a pipe</p>

```perl
someOtherScript | ./slickestWay.pl 
```</li>
</ol>

The `BEGIN` block is necessary if you need to initialize some kind of object-oriented interface, such as Text::CSV or some such, which you can add to the shebang with `-M`.  

`-l` and `-p` are also your friends.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: How can I quickly sum all numbers in a file? (score [134412](https://stackoverflow.com/q/2702564) in 2010)

#### Question
I have a file which contains several thousand numbers, each on it's own line:  

```perl
34
42
11
6
2
99
...
```

I'm looking to write a script which will print the sum of all numbers in the file. I've got a solution, but it's not very efficient. (It takes several minutes to run.) I'm looking for a more efficient solution. Any suggestions?  

#### Answer accepted (score 105)
For a Perl one-liner, it's basically the same thing as the `awk` solution in <a href="https://stackoverflow.com/questions/2702564/script-to-sum-all-numbers-in-a-file-linux/2702577#2702577">Ayman Hourieh's answer</a>:  

```perl
 % perl -nle '$sum += $_ } END { print $sum'
```

If you're curious what Perl one-liners do, you can deparse them:  

```perl
 %  perl -MO=Deparse -nle '$sum += $_ } END { print $sum'
```

The result is a more verbose version of the program, in a form that no one would ever write on their own:  

```perl
BEGIN { $/ = "\n"; $\ = "\n"; }
LINE: while (defined($_ = <ARGV>)) {
    chomp $_;
    $sum += $_;
}
sub END {
    print $sum;
}
-e syntax OK
```

Just for giggles, I tried this with a file containing 1,000,000 numbers (in the range 0 - 9,999). On my Mac Pro, it returns virtually instantaneously. That's too bad, because I was hoping using `mmap` would be really fast, but it's just the same time:  

```perl
use 5.010;
use File::Map qw(map_file);

map_file my $map, $ARGV[0];

$sum += $1 while $map =~ m/(\d+)/g;

say $sum;
```

#### Answer 2 (score 348)
You can use awk:  

```perl
awk '{ sum += $1 } END { print sum }' file
```

#### Answer 3 (score 91)
None of the solution thus far use `paste`.  Here's one:  

```perl
paste -sd+ filename | bc
```

As an example, calculate Σn where 1&lt;=n&lt;=100000:  

```perl
$ seq 100000 | paste -sd+ | bc -l
5000050000
```

(For the curious, `seq n` would print a sequence of numbers from `1` to `n` given a positive number `n`.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: What does $1 mean in Perl? (score [133432](https://stackoverflow.com/q/1036285) in 2009)

#### Question
<p>What does $1 mean in Perl? Further, what does $2 mean?
How many $number variables are there?</p>

#### Answer accepted (score 65)
The `$number` variables contain the parts of the string that matched the <em><a href="https://perldoc.perl.org/perlre.html#Capture-groups" rel="noreferrer">capture groups</a></em> `( ... )` in the pattern for your last regex match if the match was successful.  

For example, take the following string:  

```perl
$text = "the quick brown fox jumps over the lazy dog.";
```

After the statement  

```perl
$text =~ m/ (b.+?) /;
```

`$1` equals the text "`brown`".  

#### Answer 2 (score 35)
The number variables are the matches from the last <em>successful</em> match or substitution operator you applied:  

```perl
my $string = 'abcdefghi';

if( $string =~ /(abc)def(ghi)/ ) {
    print "I found $1 and $2\n";
    }
```

Always test that the match or substitution was successful before using $1 and so on. Otherwise, you might pick up the leftovers from another operation.  

Perl regular expressions are documented in <a href="http://perldoc.perl.org/perlre.html" rel="noreferrer">perlre</a>.  

#### Answer 3 (score 11)
$1, $2, etc will contain the value of captures from the last <strong>successful</strong> match - it's important to check whether the match succeeded before accessing them, i.e.  

```perl
 if ( $var =~ m/( )/ ) { # use $1 etc... }
```

An example of the problem - $1 contains 'Quick' in both print statements below:  

```perl
#!/usr/bin/perl

'Quick brown fox' =~ m{ ( quick ) }ix;
print "Found: $1\n";

'Lazy dog' =~ m{ ( quick ) }ix;
print "Found: $1\n";
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: Quickly getting to YYYY-mm-dd HH:MM:SS in Perl (score [133065](https://stackoverflow.com/q/1814196) in 2009)

#### Question
When writing Perl scripts I frequently find the need to obtain the current time represented as a string formatted as `YYYY-mm-dd HH:MM:SS` (say `2009-11-29 14:28:29`).  

In doing this I find myself taking this quite cumbersome path:  

<ul>
<li>`man perlfunc`</li>
<li>`/localtime` to search for localtime - repeat five times (`/` + `\n`) to reach the relevant section of the manpage</li>
<li>Copy the string `($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);` from the manpage to my script.</li>
<li>Try with `my $now = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $year, $mon, $mday, $hour, $min, $sec);`</li>
<li>Remember gotcha #1: Must add 1900 to $year to get current year.</li>
<li>Try with `my $now = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $year+1900, $mon, $mday, $hour, $min, $sec);`</li>
<li>Remember gotcha #2: Must add 1 to $mon to get current month.</li>
<li>Try with `my $now = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $year+1900, $mon+1, $mday, $hour, $min, $sec);`</li>
<li>Seems ok. Done!</li>
</ul>

While the process outlined above works it is far from optimal. I'm sure there is a smarter way, so my question is simply:  

<b>What is the easiest way to obtain a `YYYY-mm-dd HH:MM:SS` of the current date/time in Perl?</b>  

Where "easy" encompasses both "easy-to-write" and "easy-to-remember".  

#### Answer accepted (score 72)
Use `strftime` in the standard <a href="http://perldoc.perl.org/POSIX.html" rel="noreferrer">`POSIX`</a> module. The arguments to <a href="https://perldoc.perl.org/POSIX.html#strftime" rel="noreferrer">`strftime`</a> in Perl’s binding were designed to align with the return values from <a href="https://perldoc.perl.org/functions/localtime.html" rel="noreferrer">`localtime`</a> and <a href="https://perldoc.perl.org/functions/gmtime.html" rel="noreferrer">`gmtime`</a>. Compare  

```perl
strftime(fmt, sec, min, hour, mday, mon, year, wday = -1, yday = -1, isdst = -1)
```

with  

```perl
my          ($sec,$min,$hour,$mday,$mon,$year,$wday,     $yday,     $isdst) = gmtime(time);
```

Example command-line use is  

```perl
$ perl -MPOSIX -le 'print strftime "%F %T", localtime $^T'
```

or from a source file as in  

```perl
use POSIX;

print strftime "%F %T", localtime time;
```

Some systems do not support the `%F` and `%T` shorthands, so you will have to be explicit with  

```perl
print strftime "%Y-%m-%d %H:%M:%S", localtime time;
```

or  

```perl
print strftime "%Y-%m-%d %H:%M:%S", gmtime time;
```

Note that <a href="https://perldoc.perl.org/functions/time.html" rel="noreferrer">`time`</a> returns the current time when called whereas <a href="https://perldoc.perl.org/perlvar.html#%24BASETIME" rel="noreferrer">`$^T`</a> is fixed to the time when your program started. With <a href="https://perldoc.perl.org/functions/gmtime.html" rel="noreferrer">`gmtime`</a>, the return value is the current time in GMT. Retrieve time in your local timezone with <a href="https://perldoc.perl.org/functions/localtime.html" rel="noreferrer">`localtime`</a>.  

#### Answer 2 (score 32)
What not use the `DateTime` module to do the dirty work for you? It's easy to write <em>and</em> remember!  

```perl
use strict;
use warnings;
use DateTime;

my $dt   = DateTime->now;   # Stores current date and time as datetime object
my $date = $dt->ymd;   # Retrieves date as a string in 'yyyy-mm-dd' format
my $time = $dt->hms;   # Retrieves time as a string in 'hh:mm:ss' format

my $wanted = "$date $time";   # creates 'yyyy-mm-dd hh:mm:ss' string
print $wanted;
```

Once you know what's going on, you can get rid of the temps and save a few lines of code:  

```perl
use strict;
use warnings;
use DateTime;

my $dt = DateTime->now;
print join ' ', $dt->ymd, $dt->hms;
```

#### Answer 3 (score 30)
Try this:  

```perl
use POSIX qw/strftime/;
print strftime('%Y-%m-%d',localtime);
```

the `strftime` method does the job effectively for me. Very simple and efficient.  

<hr>

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: How do I get a file's last modified time in Perl? (score [131340](https://stackoverflow.com/q/509576) in )

#### Question
Suppose I have a filehandle `$fh`.  I can check its existence with `-e $fh` or its file size with `-s $fh` or <a href="http://perldoc.perl.org/functions/-X.html" rel="noreferrer" title="Perl -X operands">a slew of additional information about the file</a>.  How can I get its last modified time stamp?  

#### Answer accepted (score 97)
You can use the built-in module `File::stat` (included as of Perl 5.004).  

Calling `stat($fh)` returns an array with the following information about the file handle passed in (from the <a href="http://www.perl.com/doc/manual/html/pod/perlfunc/stat.html" rel="nofollow noreferrer">perlfunc man page for `stat`</a>):  

```perl
  0 dev      device number of filesystem
  1 ino      inode number
  2 mode     file mode  (type and permissions)
  3 nlink    number of (hard) links to the file
  4 uid      numeric user ID of file's owner
  5 gid      numeric group ID of file's owner
  6 rdev     the device identifier (special files only)
  7 size     total size of file, in bytes
  8 atime    last access time since the epoch
  9 mtime    last modify time since the epoch
 10 ctime    inode change time (NOT creation time!) since the epoch
 11 blksize  preferred block size for file system I/O
 12 blocks   actual number of blocks allocated
```

Element number 9 in this array will give you the last modified time since the epoch (<em>00:00 January 1, 1970 GMT</em>).  From that you can determine the local time:  

```perl
my $epoch_timestamp = (stat($fh))[9];
my $timestamp       = localtime($epoch_timestamp);
```

To avoid the <strong>magic number</strong> 9 needed in the previous example, additionally use `Time::localtime`, another built-in module (also included as of Perl 5.004).  This requires some (arguably) more legible code:  

```perl
use File::stat;
use Time::localtime;
my $timestamp = ctime(stat($fh)->mtime);
```

#### Answer 2 (score 24)
Use the builtin <a href="http://perldoc.perl.org/functions/stat.html" rel="noreferrer">stat</a> function. Or more specifically:  

```perl
my $modtime = (stat($fh))[9]
```

#### Answer 3 (score 18)
```perl
my @array = stat($filehandle);
```

The modification time is stored in Unix format in $array[9].  

Or explicitly:  

```perl
my ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size,
    $atime, $mtime, $ctime, $blksize, $blocks) = stat($filepath);

  0 dev      Device number of filesystem
  1 ino      inode number
  2 mode     File mode  (type and permissions)
  3 nlink    Number of (hard) links to the file
  4 uid      Numeric user ID of file's owner
  5 gid      Numeric group ID of file's owner
  6 rdev     The device identifier (special files only)
  7 size     Total size of file, in bytes
  8 atime    Last access time in seconds since the epoch
  9 mtime    Last modify time in seconds since the epoch
 10 ctime    inode change time in seconds since the epoch
 11 blksize  Preferred block size for file system I/O
 12 blocks   Actual number of blocks allocated
```

The epoch was at 00:00 January 1, 1970 GMT.  

More information is in <em><a href="http://perldoc.perl.org/functions/stat.html" rel="nofollow noreferrer">stat</a></em>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Perl regular expression (using a variable as a search string with Perl operator characters included) (score [131154](https://stackoverflow.com/q/4616395) in 2018)

#### Question
```perl
$text_to_search = "example text with [foo] and more";
$search_string = "[foo]";

if ($text_to_search =~ m/$search_string/)
    print "wee";
```

Please observe the above code. For some reason I would like to find the text "[foo]" in the $text_to_search variable and print "wee" if I find it. To do this I would have to ensure that the [ and ] is substituted with [ and ] to make Perl treat it as characters instead of operators.  

How can I do this without having to first replace `[` and `]` with `\[` and `\]` using a `s///` expression?  

#### Answer 2 (score 62)
Use `\Q` to autoescape any potentially problematic characters in your variable.  

```perl
if($text_to_search =~ m/\Q$search_string/) print "wee";
```

#### Answer 3 (score 46)
Use the <a href="http://perldoc.perl.org/functions/quotemeta.html" rel="noreferrer">`quotemeta`</a> function:  

```perl
$text_to_search = "example text with [foo] and more";
$search_string = quotemeta "[foo]";

print "wee" if ($text_to_search =~ /$search_string/);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: Turning multiple lines into one line with comma separated (Perl/Sed/AWK) (score [126035](https://stackoverflow.com/q/15758814) in )

#### Question
I have the following data in multiple lines:  

```perl
foo
bar
qux
zuu
sdf
sdfasdf
```

What I want to do is to convert them with one line and comma separated:  

```perl
foo,bar,qux,zuu,sdf,sdfasdf
```

What's the best unix one-liner to do that?  

#### Answer accepted (score 133)
Using paste command:  

```perl
paste -d, -s file
```

#### Answer 2 (score 65)
<h5>file</h3>

```perl
aaa
bbb
ccc
ddd
```

<h5>xargs</h3>

```perl
cat file | xargs
```

<h5>result</h3>

```perl
aaa bbb ccc ddd 
```

<h5>xargs improoved</h3>

```perl
cat file | xargs | sed -e 's/ /,/g'
```

<h5>result</h3>

```perl
aaa,bbb,ccc,ddd 
```

#### Answer 3 (score 10)
`xargs -a your_file | sed 's/ /,/g'`  

This is a shorter way.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Perl: function to trim string leading and trailing whitespace (score [125433](https://stackoverflow.com/q/4597937) in 2011)

#### Question
Is there a built-in function to trim leading and trailing whitespace such that `trim(" hello world ") eq "hello world"`?  

#### Answer 2 (score 82)
Here's one approach using a regular expression:  

```perl
$string =~ s/^\s+|\s+$//g ;     # remove both leading and trailing whitespace
```

Perl 6 will include a trim function:  

```perl
$string .= trim;
```

Source: <a href="http://en.wikipedia.org/wiki/Trim_%28programming%29#Perl" rel="noreferrer">Wikipedia</a>  

#### Answer 3 (score 81)
This is available in <a href="https://metacpan.org/pod/String::Util" rel="noreferrer">String::Util</a> with the `trim` method:  

<sup>Editor's note: `String::Util` is not a core module, but you can install it from <a href="http://cpan.org" rel="noreferrer">CPAN</a> with `[sudo] cpan String::Util`.</sup>  

```perl
use String::Util 'trim';
my $str = "  hello  ";
$str = trim($str);
print "string is now: '$str'\n";
```

prints:  

<blockquote>
  string is now 'hello'  
</blockquote>

However it is easy enough to do yourself:  

```perl
$str =~ s/^\s+//;
$str =~ s/\s+$//;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: How do I tell if a variable has a numeric value in Perl? (score [125334](https://stackoverflow.com/q/12647) in 2009)

#### Question
Is there a simple way in Perl that will allow me to determine if a given variable is numeric?  Something along the lines of:  

```perl
if (is_number($x))
{ ... }
```

would be ideal.  A technique that won't throw warnings when the `-w` switch is being used is certainly preferred.  

#### Answer accepted (score 122)
<p>Use `Scalar::Util::looks_like_number()` which uses the internal Perl C API's looks_like_number() function, which is probably the most efficient way to do this.
Note that the strings "inf" and "infinity" are treated as numbers.</p>

<h5>Example:</h2>

```perl
#!/usr/bin/perl

use warnings;
use strict;

use Scalar::Util qw(looks_like_number);

my @exprs = qw(1 5.25 0.001 1.3e8 foo bar 1dd inf infinity);

foreach my $expr (@exprs) {
    print "$expr is", looks_like_number($expr) ? '' : ' not', " a number\n";
}
```

Gives this output:  

```perl
1 is a number
5.25 is a number
0.001 is a number
1.3e8 is a number
foo is not a number
bar is not a number
1dd is not a number
inf is a number
infinity is a number
```

<h5>See also:</h2>

<ul>
<li><a href="http://perldoc.perl.org/Scalar/Util.html" rel="noreferrer">perldoc Scalar::Util</a></li>
<li><a href="http://perldoc.perl.org/perlapi.html#SV-Body-Allocation" rel="noreferrer">perldoc perlapi</a> for `looks_like_number`</li>
</ul>

#### Answer 2 (score 23)
Check out the CPAN module <a href="http://search.cpan.org/dist/Regexp-Common" rel="noreferrer">Regexp::Common</a>. I think it does exactly what you need and handles all the edge cases (e.g. real numbers, scientific notation, etc). e.g.  

```perl
use Regexp::Common;
if ($var =~ /$RE{num}{real}/) { print q{a number}; }
```

#### Answer 3 (score 22)
The original question was how to tell if a variable was numeric, not if it "has a numeric value".  

There are a few operators that have separate modes of operation for numeric and string operands, where "numeric" means anything that was originally a number or was ever used in a numeric context (e.g. in `$x = "123"; 0+$x`, before the addition, `$x` is a string, afterwards it is considered numeric).  

One way to tell is this:  

```perl
if ( length( do { no warnings "numeric"; $x & "" } ) ) {
    print "$x is numeric\n";
}
```

If the bitwise feature is enabled, that makes `&amp;` only a numeric operator and adds a separate string `&amp;.` operator, you must disable it:  

```perl
if ( length( do { no if $] >= 5.022, "feature", "bitwise"; no warnings "numeric"; $x & "" } ) ) {
    print "$x is numeric\n";
}
```

(bitwise is available in perl 5.022 and above, and enabled by default if you `use 5.028;` or above.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: Match whitespace but not newlines (score [125061](https://stackoverflow.com/q/3469080) in 2016)

#### Question
I sometimes want to match whitespace but not newline.  

So far I've been resorting to `[ \t]`.  Is there a less awkward way?  

#### Answer accepted (score 162)


Perl versions 5.10 and later support subsidiary vertical and horizontal character classes, `\v` and `\h`, as well as the generic whitespace character class `\s`  

The cleanest solution is to use the <em>horizontal whitespace</em> character class `\h`. This will match tab and space from the ASCII set, non-breaking space from extended ASCII, or any of these Unicode characters  

```perl
U+0009 CHARACTER TABULATION
U+0020 SPACE
U+00A0 NO-BREAK SPACE (not matched by \s)

U+1680 OGHAM SPACE MARK
U+2000 EN QUAD
U+2001 EM QUAD
U+2002 EN SPACE
U+2003 EM SPACE
U+2004 THREE-PER-EM SPACE
U+2005 FOUR-PER-EM SPACE
U+2006 SIX-PER-EM SPACE
U+2007 FIGURE SPACE
U+2008 PUNCTUATION SPACE
U+2009 THIN SPACE
U+200A HAIR SPACE
U+202F NARROW NO-BREAK SPACE
U+205F MEDIUM MATHEMATICAL SPACE
U+3000 IDEOGRAPHIC SPACE
```

The <em>vertical space</em> pattern `\v` is less useful, but matches these characters  

```perl
U+000A LINE FEED
U+000B LINE TABULATION
U+000C FORM FEED
U+000D CARRIAGE RETURN
U+0085 NEXT LINE (not matched by \s)

U+2028 LINE SEPARATOR
U+2029 PARAGRAPH SEPARATOR
```

There are seven vertical whitespace characters which match `\v` and eighteen horizontal ones which match `\h`. `\s` matches twenty-three characters  

All whitespace characters are either <em>vertical</em> or <em>horizontal</em> with no overlap, but they are not proper subsets because `\h` also matches U+00A0 NO-BREAK SPACE, and `\v` also matches U+0085 NEXT LINE, neither of which are matched by `\s`  

#### Answer 2 (score 335)
Use a double-negative:  

```perl
/[^\S\r\n]/
```

That is, not-not-whitespace (the capital S complements) or not-carriage-return or not-newline. Distributing the outer not (<em>i.e.</em>, the complementing `^` in the character class) with <a href="http://en.wikipedia.org/wiki/De_Morgan&#39;s_laws" rel="noreferrer">De Morgan's law</a>, this is equivalent to “whitespace but not carriage return or newline.” Including both `\r` and `\n` in the pattern correctly handles all of Unix (LF), classic Mac OS (CR), and DOS-ish (CR&nbsp;LF) <a href="https://en.wikipedia.org/wiki/Newline#Representation" rel="noreferrer">newline conventions</a>.   

No need to take my word for it:  

```perl
#! /usr/bin/env perl

use strict;
use warnings;

use 5.005;  # for qr//

my $ws_not_crlf = qr/[^\S\r\n]/;

for (' ', '\f', '\t', '\r', '\n') {
  my $qq = qq["$_"];
  printf "%-4s => %s\n", $qq,
    (eval $qq) =~ $ws_not_crlf ? "match" : "no match";
}
```

Output:  

<pre>" "  => match
"\f" => match
"\t" => match
"\r" => no match
"\n" => no match</pre>

Note the exclusion of vertical tab, but this is <a href="http://search.cpan.org/dist/perl-5.18.0/pod/perldelta.pod#Vertical_tabs_are_now_whitespace" rel="noreferrer">addressed in v5.18</a>.  

Before objecting too harshly, the Perl documentation uses the same technique. A footnote in the <a href="https://perldoc.perl.org/perlrecharclass.html#Whitespace" rel="noreferrer">“Whitespace” section of perlrecharclass</a> reads  

<blockquote>
  Prior to Perl v5.18, `\s` did not match the vertical tab. `[^\S\cK]` (obscurely) matches what `\s` traditionally did.  
</blockquote>

The <a href="https://perldoc.perl.org/perlrecharclass.html#Whitespace" rel="noreferrer">same section of perlrecharclass</a> also suggests other approaches that won’t offend language teachers’ opposition to double-negatives.  

Outside locale and Unicode rules or when the `/a` switch is in effect, “`\s` matches `[\t\n\f\r ]` and, starting in Perl v5.18, the vertical tab, `\cK`.” Discard `\r` and `\n` to leave `/[\t\f\cK ]/` for matching whitespace but not newline.  

If your text is Unicode, use code similar to the sub below to construct a pattern from the table in <a href="https://perldoc.perl.org/perlrecharclass.html#Whitespace" rel="noreferrer">the aforementioned documentation section</a>.  

```perl
sub ws_not_nl {
  local($_) = <<'EOTable';
0x0009        CHARACTER TABULATION   h s
0x000a              LINE FEED (LF)    vs
0x000b             LINE TABULATION    vs  [1]
0x000c              FORM FEED (FF)    vs
0x000d        CARRIAGE RETURN (CR)    vs
0x0020                       SPACE   h s
0x0085             NEXT LINE (NEL)    vs  [2]
0x00a0              NO-BREAK SPACE   h s  [2]
0x1680            OGHAM SPACE MARK   h s
0x2000                     EN QUAD   h s
0x2001                     EM QUAD   h s
0x2002                    EN SPACE   h s
0x2003                    EM SPACE   h s
0x2004          THREE-PER-EM SPACE   h s
0x2005           FOUR-PER-EM SPACE   h s
0x2006            SIX-PER-EM SPACE   h s
0x2007                FIGURE SPACE   h s
0x2008           PUNCTUATION SPACE   h s
0x2009                  THIN SPACE   h s
0x200a                  HAIR SPACE   h s
0x2028              LINE SEPARATOR    vs
0x2029         PARAGRAPH SEPARATOR    vs
0x202f       NARROW NO-BREAK SPACE   h s
0x205f   MEDIUM MATHEMATICAL SPACE   h s
0x3000           IDEOGRAPHIC SPACE   h s
EOTable

  my $class;
  while (/^0x([0-9a-f]{4})\s+([A-Z\s]+)/mg) {
    my($hex,$name) = ($1,$2);
    next if $name =~ /\b(?:CR|NL|NEL|SEPARATOR)\b/;
    $class .= "\\N{U+$hex}";
  }

  qr/[$class]/u;
}
```

<hr>

<h5>Other Applications</h2>

The double-negative trick is also handy for matching alphabetic characters too. Remember that `\w` matches “word characters,” alphabetic characters <em>and</em> digits and underscore. We ugly-Americans sometimes want to write it as, say,  

```perl
if (/[A-Za-z]+/) { ... }
```

but a double-negative character-class can respect the locale:  

```perl
if (/[^\W\d_]+/) { ... }
```

Expressing “a word character but not digit or underscore” this way is a bit opaque. A POSIX character-class communicates the intent more directly  

```perl
if (/[[:alpha:]]+/) { ... }
```

or with a Unicode property as <a href="https://stackoverflow.com/users/415428/szbalint">szbalint</a> suggested  

```perl
if (/\p{Letter}+/) { ... }
```

#### Answer 3 (score 44)
A variation on <a href="https://stackoverflow.com/a/3469155/578288">Greg’s answer</a> that includes carriage returns too:  

```perl
/[^\S\r\n]/
```

This regex is safer than `/[^\S\n]/` with no `\r`. My reasoning is that Windows uses `\r\n` for newlines, and Mac OS 9 used `\r`. You’re unlikely to find `\r` without `\n` nowadays, but if you do find it, it couldn’t mean anything but a newline. Thus, since `\r` can mean a newline, we should exclude it too.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: How can Perl's print add a newline by default? (score [124937](https://stackoverflow.com/q/2899367) in 2010)

#### Question
In Perl most of my `print` statements take the form  

```perl
print "hello." . "\n";
```

Is there a nice way to avoid keeping all the pesky "\n"s lying around?  

I know I could make a new function such as `myprint` that automatically appends \n, but it would be nice if I could override the existing `print`.  

#### Answer accepted (score 95)
Perl 6 has the `say` function that automatically appends `\n`.  

You can also use `say` in Perl 5.10 or 5.12 if you add  

```perl
use feature qw(say);
```

to the beginning of your program.  Or you can use <a href="http://search.cpan.org/~chromatic/Modern-Perl-1.03/lib/Modern/Perl.pm" rel="noreferrer">Modern::Perl</a> to get this and other features.  

See <a href="http://perldoc.perl.org/feature.html#The-%27say%27-feature" rel="noreferrer">perldoc feature</a> for more details.  

#### Answer 2 (score 33)
You can use the `-l` option in the she-bang header:   

```perl
#!/usr/bin/perl -l

$text = "hello";

print $text;
print $text;
```

<strong>Output:</strong>  

```perl
hello
hello
```

#### Answer 3 (score 24)
If Perl 5.10+ is not an option, here is a quick and dirty approximation.  It's not exactly the same, since say has some magic when its first arg is a handle, but for printing to STDOUT:  

```perl
sub say {print @_, "\n"}

say 'hello';
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Negative regex for Perl string pattern match (score [124513](https://stackoverflow.com/q/6361312) in 2017)

#### Question
I have this regex:  

```perl
if($string =~ m/^(Clinton|[^Bush]|Reagan)/i)
  {print "$string\n"};
```

I want to match with Clinton and Reagan, but not Bush.  

It's not working.  

#### Answer accepted (score 27)
Sample text:  

<blockquote>
  <p>Clinton said<br>
  Bush used crayons<bR>
  Reagan forgot<br></p>
</blockquote>

Just omitting a Bush match:  

```perl
$ perl -ne 'print if /^(Clinton|Reagan)/' textfile
Clinton said
Reagan forgot
```

Or if you really want to specify:  

```perl
$ perl -ne 'print if /^(?!Bush)(Clinton|Reagan)/' textfile
Clinton said
Reagan forgot
```

#### Answer 2 (score 132)
Your regex does not work because [] defines a character class, but what you want is a lookahead:  

```perl
(?=) - Positive look ahead assertion foo(?=bar) matches foo when followed by bar
(?!) - Negative look ahead assertion foo(?!bar) matches foo when not followed by bar
(?<=) - Positive look behind assertion (?<=foo)bar matches bar when preceded by foo
(?<!) - Negative look behind assertion (?<!foo)bar matches bar when NOT preceded by foo
(?>) - Once-only subpatterns (?>\d+)bar Performance enhancing when bar not present
(?(x)) - Conditional subpatterns
(?(3)foo|fu)bar - Matches foo if 3rd subpattern has matched, fu if not
(?#) - Comment (?# Pattern does x y or z)
```

So try: (?!bush)  

#### Answer 3 (score 17)
Your regex says the following:  

```perl
/^         - if the line starts with
(          - start a capture group
Clinton|   - "Clinton" 
|          - or
[^Bush]    - Any single character except "B", "u", "s" or "h"
|          - or
Reagan)   - "Reagan". End capture group.
/i         - Make matches case-insensitive 
```

So, in other words, your middle part of the regex is screwing you up. As it is a "catch-all" kind of group, it will allow any line that does not begin with any of the upper or lower case letters in "Bush". For example, these lines would match your regex:  

```perl
Our president, George Bush
In the news today, pigs can fly
012-3123 33
```

You either make a negative look-ahead, as suggested earlier, or you simply make two regexes:  

```perl
if( ($string =~ m/^(Clinton|Reagan)/i) and
    ($string !~ m/^Bush/i) ) {
   print "$string\n";
}
```

As <a href="https://stackoverflow.com/users/11095/mirod">mirod</a> has pointed out in the comments, the second check is quite unnecessary when using the caret (`^`) to match only beginning of lines, as lines that begin with "Clinton" or "Reagan" could never begin with "Bush".  

However, it would be valid without the carets.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: In Perl, how do I create a hash whose keys come from a given array? (score [121882](https://stackoverflow.com/q/95820) in 2015)

#### Question
Let's say I have an array, and I know I'm going to be doing a lot of "Does the array contain X?" checks. The efficient way to do this is to turn that array into a hash, where the keys are the array's elements, and then you can just say <pre>if($hash{X}) { ... }</pre>  

Is there an easy way to do this array-to-hash conversion? Ideally, it should be versatile enough to take an anonymous array and return an anonymous hash.  

#### Answer accepted (score 114)
```perl
%hash = map { $_ => 1 } @array;
```

It's not as short as the "@hash{@array} = ..." solutions, but those ones require the hash and array to already be defined somewhere else, whereas this one can take an anonymous array and return an anonymous hash.  

What this does is take each element in the array and pair it up with a "1". When this list of (key, 1, key, 1, key 1) pairs get assigned to a hash, the odd-numbered ones become the hash's keys, and the even-numbered ones become the respective values.  

#### Answer 2 (score 42)
```perl
 @hash{@array} = (1) x @array;
```

It's a hash slice, a list of values from the hash, so it gets the list-y @ in front.  

From <a href="http://perldoc.perl.org/perldata.html#Slices" rel="noreferrer">the docs</a>:  

<blockquote>
  <p>If you're confused about why you use
  an '@' there on a hash slice instead
  of a '%', think of it like this. The
  type of bracket (square or curly)
  governs whether it's an array or a
  hash being looked at. On the other
  hand, the leading symbol ('$' or '@')
  on the array or hash indicates whether
  you are getting back a singular value
  (a scalar) or a plural one (a list).</p>
</blockquote>

#### Answer 3 (score 37)
```perl
@hash{@keys} = undef;
```

The syntax here where you are referring to the hash with an `@` is a hash slice.  We're basically saying `$hash{$keys[0]}` AND `$hash{$keys[1]}` AND `$hash{$keys[2]}` ... is a list on the left hand side of the =, an lvalue, and we're assigning to that list, which actually goes into the hash and sets the values for all the named keys.  In this case, I only specified one value, so that value goes into `$hash{$keys[0]}`, and the other hash entries all auto-vivify (come to life) with undefined values.  [My original suggestion here was set the expression = 1, which would've set that one key to 1 and the others to `undef`.  I changed it for consistency, but as we'll see below, the exact values do not matter.]  

When you realize that the lvalue, the expression on the left hand side of the =, is a list built out of the hash, then it'll start to make some sense why we're using that `@`.  [Except I think this will change in Perl 6.]  

The idea here is that you are using the hash as a set.  What matters is not the value I am assigning; it's just the existence of the keys.  So what you want to do is not something like:  

```perl
if ($hash{$key} == 1) # then key is in the hash
```

instead:  

```perl
if (exists $hash{$key}) # then key is in the set
```

It's actually more efficient to just run an `exists` check than to bother with the value in the hash, although to me the important thing here is just the concept that you are representing a set just with the keys of the hash.  Also, somebody pointed out that by using `undef` as the value here, we will consume less storage space than we would assigning a value.  (And also generate less confusion, as the value does not matter, and my solution would assign a value only to the first element in the hash and leave the others `undef`, and some other solutions are turning cartwheels to build an array of values to go into the hash; completely wasted effort).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: How can I see if a Perl hash already has a certain key? (score [120275](https://stackoverflow.com/q/1003632) in 2015)

#### Question
I have a Perl script that is counting the number of occurrences of various strings in a text file. I want to be able to check if a certain string is not yet a key in the hash. Is there a better way of doing this altogether?  

Here is what I am doing:  

```perl
foreach $line (@lines){
    if(($line =~ m|my regex|) )
    {
        $string = $1;
        if ($string is not a key in %strings) # "strings" is an associative array
        {
            $strings{$string} = 1;
        }
        else
        {
            $n = ($strings{$string});
            $strings{$string} = $n +1;
        }
    }
}
```

#### Answer accepted (score 112)
I believe to check if a key exists in a hash you just do  

```perl
if (exists $strings{$string}) {
    ...
} else {
    ...
}
```

#### Answer 2 (score 10)
I would counsel against using `if ($hash{$key})` since it will not do what you expect if the key exists but its value is zero or empty.  

#### Answer 3 (score 9)
Well, your whole code can be limited to:  

```perl
foreach $line (@lines){
        $strings{$1}++ if $line =~ m|my regex|;
}
```

If the value is not there, ++ operator will assume it to be 0 (and then increment to 1). If it is already there - it will simply be incremented.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: How do I convert a date/time to epoch time (unix time/seconds since 1970) in Perl? (score [119553](https://stackoverflow.com/q/95492) in 2018)

#### Question
Given a date/time as an array of (year, month, day, hour, minute, second), how would you convert it to epoch time, i.e., the number of seconds since 1970-01-01 00:00:00 GMT?  

Bonus question: If given the date/time as a string, how would you first parse it into the (y,m,d,h,m,s) array?  

#### Answer accepted (score 20)
This is the simplest way to get unix time:  

```perl
use Time::Local;
timelocal($second,$minute,$hour,$day,$month-1,$year);
```

<p>Note the reverse order of the arguments and that January is month 0.
For many more options, see the <a href="https://metacpan.org/pod/DateTime" rel="noreferrer">DateTime</a> module from CPAN.  </p>

As for parsing, see the <a href="https://metacpan.org/pod/Date::Parse" rel="noreferrer">Date::Parse</a> module from CPAN.  If you really need to get fancy with date parsing, the <a href="https://metacpan.org/pod/Date::Manip" rel="noreferrer">Date::Manip</a> may be helpful, though its own documentation warns you away from it since it carries a lot of baggage (it knows things like common business holidays, for example) and other solutions are much faster.  

If you happen to know something about the format of the date/times you'll be parsing then a simple regular expression may suffice but you're probably better off using an appropriate CPAN module.  For example, if you know the dates will always be in YMDHMS order, use the CPAN module <a href="https://metacpan.org/pod/DateTime::Format::ISO8601" rel="noreferrer">DateTime::Format::ISO8601</a>.  

<hr>

For my own reference, if nothing else, below is a function I use for an application where I know the dates will always be in YMDHMS order with all or part of the "HMS" part optional.  It accepts any delimiters (eg, "2009-02-15" or "2009.02.15").  It returns the corresponding unix time (seconds since 1970-01-01 00:00:00 GMT) or -1 if it couldn't parse it (which means you better be sure you'll never legitimately need to parse the date 1969-12-31 23:59:59).  It also presumes two-digit years XX up to "69" refer to "20XX", otherwise "19XX" (eg, "50-02-15" means 2050-02-15 but "75-02-15" means 1975-02-15).  

```perl
use Time::Local;

sub parsedate { 
  my($s) = @_;
  my($year, $month, $day, $hour, $minute, $second);

  if($s =~ m{^\s*(\d{1,4})\W*0*(\d{1,2})\W*0*(\d{1,2})\W*0*
                 (\d{0,2})\W*0*(\d{0,2})\W*0*(\d{0,2})}x) {
    $year = $1;  $month = $2;   $day = $3;
    $hour = $4;  $minute = $5;  $second = $6;
    $hour |= 0;  $minute |= 0;  $second |= 0;  # defaults.
    $year = ($year<100 ? ($year<70 ? 2000+$year : 1900+$year) : $year);
    return timelocal($second,$minute,$hour,$day,$month-1,$year);  
  }
  return -1;
}
```

#### Answer 2 (score 34)
If you're using the <a href="https://metacpan.org/pod/DateTime" rel="nofollow noreferrer">DateTime</a> module, you can call the <a href="https://metacpan.org/pod/DateTime#METHODS" rel="nofollow noreferrer">epoch()</a> method on a DateTime object, since that's what you think of as unix time.  

Using DateTimes allows you to convert fairly easily from epoch, to date objects.  

Alternativly, <a href="http://perldoc.perl.org/functions/localtime.html" rel="nofollow noreferrer">localtime</a> and gmtime will convert an epoch into an array containing day month and year, and timelocal and timegm from the <a href="https://metacpan.org/pod/Time::Local" rel="nofollow noreferrer">Time::Local module</a> will do the opposite, converting an array of time elements (seconds, minutes, ..., days, months etc.) into an epoch.  

#### Answer 3 (score 17)
To parse a date, look at <a href="https://metacpan.org/pod/Date::Parse" rel="noreferrer">Date::Parse</a> in CPAN.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: How can I start an interactive console for Perl? (score [117894](https://stackoverflow.com/q/73667) in 2015)

#### Question
How can I start an interactive console for Perl, similar to the `irb` command for Ruby or `python` for Python?  

#### Answer accepted (score 285)
You can use the perl debugger on a trivial program, like so:  

```perl
perl -de1
```

Alternatively there's <a href="http://search.cpan.org/~sukria/perlconsole-0.4/perlconsole" rel="noreferrer"><em>Alexis Sukrieh</em>'s Perl Console</a> application, but I haven't used it.  

#### Answer 2 (score 59)
Not only did Matt Trout write an article about a REPL, he actually wrote one - <a href="http://search.cpan.org/dist/Devel-REPL" rel="noreferrer">Devel::REPL</a>  

I've used it a bit and it works fairly well, and it's under active development.  

BTW, I have no idea why someone modded down the person who mentioned using "perl -e" from the console. This isn't really a REPL, true, but it's fantastically useful, and I use it all the time.  

#### Answer 3 (score 35)
I wrote a script I call "psh":  

```perl
#! /usr/bin/perl

while (<>) {
  chomp;
  my $result = eval;
  print "$_ = $result\n";
}
```

Whatever you type in, it evaluates in Perl:  

```perl
> gmtime(2**30)
gmtime(2**30) = Sat Jan 10 13:37:04 2004

> $x = 'foo'
$x = 'foo' = foo

> $x =~ s/o/a/g
$x =~ s/o/a/g = 2

> $x
$x = faa
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: How can I output UTF-8 from Perl? (score [115758](https://stackoverflow.com/q/627661) in 2013)

#### Question
I am trying to write a Perl script using the "utf8" pragma, and I'm getting unexpected results.  I'm using Mac OS X 10.5 (Leopard), and I'm editing with TextMate.  All of my settings for both my editor and operating system are defaulted to writing files in utf-8 format.  

However, when I enter the following into a text file, save it as a ".pl", and execute it, I get the friendly "diamond with a question mark" in place of the non-ASCII characters.  

```perl
#!/usr/bin/env perl -w

use strict;
use utf8;

my $str = 'Çirçös';
print( "$str\n" );
```

Any idea what I'm doing wrong? I expect to get 'Çirçös' in the output, but I get '�ir��s' instead.  

#### Answer accepted (score 154)
`use utf8;` does not enable Unicode <em>output</em> - it enables you to type Unicode in your program. Add this to the program, before your `print()` statement:  

```perl
binmode(STDOUT, ":utf8");
```

See if that helps. That should make `STDOUT` output in UTF-8 instead of ordinary ASCII.  

#### Answer 2 (score 82)
You can use the <a href="http://perldoc.perl.org/open.html" rel="noreferrer">open pragma</a>.    

For eg. below sets STDOUT, STDIN &amp; STDERR to use UTF-8....  

```perl
use open qw/:std :utf8/;
```

#### Answer 3 (score 64)
<a href="http://www.perlfoundation.org/perl5/index.cgi?tmtowtdi" rel="noreferrer">TMTOWTDI</a>, chose the method that best fits how you work.  I use the environment method so I don't have to think about it.  

In the <a href="http://perldoc.perl.org/perlrun.html#PERL_UNICODE" rel="noreferrer">environment</a>:  

```perl
export PERL_UNICODE=SDL
```

on the <a href="http://perldoc.perl.org/perlrun.html#*-C-[_number/list_]*" rel="noreferrer">command line</a>:  

```perl
perl -CSDL -le 'print "\x{1815}"';
```

or with <a href="http://perldoc.perl.org/functions/binmode.html" rel="noreferrer">binmode</a>:  

```perl
binmode(STDOUT, ":utf8");          #treat as if it is UTF-8
binmode(STDIN, ":encoding(utf8)"); #actually check if it is UTF-8
```

or with <a href="http://perldoc.perl.org/PerlIO.html" rel="noreferrer">PerlIO</a>:  

```perl
open my $fh, ">:utf8", $filename
    or die "could not open $filename: $!\n";

open my $fh, "<:encoding(utf-8)", $filename
    or die "could not open $filename: $!\n";
```

or with the <a href="http://perldoc.perl.org/open.html" rel="noreferrer">open pragma</a>:  

```perl
use open ":encoding(utf8)";
use open IN => ":encoding(utf8)", OUT => ":utf8";
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: How can I install a CPAN module into a local directory? (score [115048](https://stackoverflow.com/q/540640) in 2017)

#### Question
<p>I'm using a hosted Linux machine so I don't have permissions to write
into the `/usr/lib` directory.</p>

When I try to install a CPAN module by doing the usual:  

```perl
perl Makefile.PL
make test
make install
```

<p>That module is extracted to a `blib/lib/` folder. I have kept <code>use
blib/lib/ModuleName</code> but it still the compiler says module can not be
found. I have tried copying the .pm file into local directory and kept
`require ModuleName` but still it gives me some error.</p>

How can I install a module into some other directory and use it?  

#### Answer accepted (score 36)
I had a similar problem, where I couldn't even install local::lib  

I created an installer that installed the module somewhere relative to the .pl files  

The install goes like:  

```perl
perl Makefile.PL PREFIX=./modulos
make
make install
```

Then, in the .pl file that requires the module, which is in ./  

```perl
use lib qw(./modulos/share/perl/5.8.8/); # You may need to change this path
use module::name;
```

The rest of the files (makefile.pl, module.pm, etc) require no changes.  

You can call the .pl file with just  

```perl
perl file.pl
```

#### Answer 2 (score 61)
Other answers already on Stackoverflow:  

<ul>
<li><a href="https://stackoverflow.com/questions/102850/how-can-i-install-cpan-modules-locally-without-root-access-dynaloader-pm-line-22">How do I install modules locally without root access...</a></li>
<li><a href="https://stackoverflow.com/questions/251705/how-can-i-use-a-new-perl-module-without-install-permissions">How can I use a new Perl module without install permissions?</a></li>
</ul>

From perlfaq8:  

<p><hr>
<a href="http://learn.perl.org/faq/perlfaq8.html#How-do-I-keep-my-own-module-library-directory" rel="noreferrer">How do I keep my own module/library directory?</a></p>

When you build modules, tell Perl where to install the modules.  

For Makefile.PL-based distributions, use the INSTALL_BASE option when generating Makefiles:  

```perl
perl Makefile.PL INSTALL_BASE=/mydir/perl
```

You can set this in your CPAN.pm configuration so modules automatically install in your private library directory when you use the CPAN.pm shell:  

```perl
% cpan
cpan> o conf makepl_arg INSTALL_BASE=/mydir/perl
cpan> o conf commit
```

For Build.PL-based distributions, use the --install_base option:  

```perl
perl Build.PL --install_base /mydir/perl
```

You can configure CPAN.pm to automatically use this option too:  

```perl
% cpan
cpan> o conf mbuildpl_arg '--install_base /mydir/perl'
cpan> o conf commit
```

#### Answer 3 (score 19)
<a href="http://search.cpan.org/perldoc?local::lib" rel="noreferrer">local::lib</a> will help you.  It will convince "make install" (and "Build install") to install to a directory you can write to, and it will tell `perl` how to get at those modules.  

In general, if you want to use a module that is in a blib/ directory, you want to say `perl -Mblib ...` where `...` is how you would normally invoke your script.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: The correct way to read a data file into an array (score [114674](https://stackoverflow.com/q/8963400) in 2014)

#### Question
I have a data file, with each line having one number, like  

```perl
10
20
30
40
```

How do I read this file and store the data into an array?   

So that I can conduct some operations on this array.  

#### Answer accepted (score 77)
Just reading the file into an array, one line per element, is trivial:  

```perl
open my $handle, '<', $path_to_file;
chomp(my @lines = <$handle>);
close $handle;
```

Now the lines of the file are in the array `@lines`.  

If you want to make sure there is error handling for `open` and `close`, do something like this (in the snipped below, we <a href="https://perldoc.perl.org/Encode.html#Encoding-via-PerlIO" rel="noreferrer">open the file in UTF-8 mode</a>, too):  

```perl
my $handle;
unless (open $handle, "<:encoding(utf8)", $path_to_file) {
   print STDERR "Could not open file '$path_to_file': $!\n";
   # we return 'undefined', we could also 'die' or 'croak'
   return undef
}
chomp(my @lines = <$handle>);
unless (close $handle) {
   # what does it mean if close yields an error and you are just reading?
   print STDERR "Don't care error while closing '$path_to_file': $!\n";
} 
```

#### Answer 2 (score 11)
There is the easiest method, using `File::Slurp` module:  

```perl
use File::Slurp;
my @lines = read_file("filename", chomp => 1); # will chomp() each line
```

If you need some validation for each line you can use `grep` in front of `read_file`.  

For example, filter lines which contain only integers:  

```perl
my @lines = grep { /^\d+$/ } read_file("filename", chomp => 1);
```

#### Answer 3 (score 10)
I like...  

```perl
@data = `cat /var/tmp/somefile`;
```

It's not as glamorous as others, but, it works all the same.  And...  

```perl
$todays_data = '/var/tmp/somefile' ;
open INFILE, "$todays_data" ; 
@data = <INFILE> ; 
close INFILE ;
```

Cheers.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: How to see if a directory exists or not in Perl? (score [113090](https://stackoverflow.com/q/4486951) in )

#### Question
To see if a file exists before using it, we can use:  

```perl
if (-e "filename.cgi")
{
 #proceed with your code
} 
```

But how to indentify a directory exists or not?  

#### Answer accepted (score 93)
Use `-d` (<a href="http://perldoc.perl.org/functions/-X.html">full list of file tests</a>)  

```perl
if (-d "cgi-bin") {
    # directory called cgi-bin exists
}
elsif (-e "cgi-bin") {
    # cgi-bin exists but is not a directory
}
else {
    # nothing called cgi-bin exists
}
```

As a note, `-e` doesn't distinguish between files and directories.  To check if something exists and is a plain file, use `-f`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: How to efficiently calculate a running standard deviation? (score [113026](https://stackoverflow.com/q/1174984) in 2019)

#### Question
I have an array of lists of numbers, e.g.:  

```perl
[0] (0.01, 0.01, 0.02, 0.04, 0.03)
[1] (0.00, 0.02, 0.02, 0.03, 0.02)
[2] (0.01, 0.02, 0.02, 0.03, 0.02)
     ...
[n] (0.01, 0.00, 0.01, 0.05, 0.03)
```

What I would like to do is efficiently calculate the mean and standard deviation at each index of a list, across all array elements.  

To do the mean, I have been looping through the array and summing the value at a given index of a list. At the end, I divide each value in my "averages list" by `n` (I am working with a population, not a sample from the population).  

To do the standard deviation, I loop through again, now that I have the mean calculated.  

I would like to avoid going through the array twice, once for the mean and then once for the SD (after I have a mean).   

Is there an efficient method for calculating both values, only going through the array once? Any code in an interpreted language (e.g. Perl or Python) or pseudocode is fine.  

#### Answer accepted (score 106)
The answer is to use Welford's algorithm, which is very clearly defined after the "naive methods" in:  

<ul>
<li>Wikipedia: <a href="http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance" rel="noreferrer">Algorithms for calculating variance</a>
</ul>

It's more numerically stable than either the two-pass or online simple sum of squares collectors suggested in other responses.  The stability only really matters when you have lots of values that are close to each other as they lead to what is known as "<a href="https://introcs.cs.princeton.edu/java/91float/" rel="noreferrer">catastrophic cancellation</a>" in the floating point literature.  

You might also want to brush up on the difference between dividing by the number of samples (N) and N-1 in the variance calculation (squared deviation).  Dividing by N-1 leads to an unbiased estimate of variance from the sample, whereas dividing by N on average underestimates variance (because it doesn't take into account the variance between the sample mean and the true mean).  

I wrote two blog entries on the topic which go into more details, including how to delete previous values online:  

<ul>
<li><a href="http://lingpipe-blog.com/2009/03/19/computing-sample-mean-variance-online-one-pass/" rel="noreferrer">Computing Sample Mean and Variance Online in One Pass</a>
<li><a href="http://lingpipe-blog.com/2009/07/07/welford-s-algorithm-delete-online-mean-variance-deviation/" rel="noreferrer">Deleting Values in Welford’s Algorithm for Online Mean and Variance</a>
</ul>

You can also take a look at my Java implement; the javadoc, source, and unit tests are all online:  

<ul>
<li><a href="http://alias-i.com/lingpipe/docs/api/com/aliasi/stats/OnlineNormalEstimator.html" rel="noreferrer">Javadoc: `stats.OnlineNormalEstimator`</a>
<li><a href="http://alias-i.com/lingpipe/src/com/aliasi/stats/OnlineNormalEstimator.java" rel="noreferrer">Source: `stats.OnlineNormalEstimator.java`</a>
<li><a href="http://alias-i.com/lingpipe/src/com/aliasi/test/unit/stats/OnlineNormalEstimatorTest.java" rel="noreferrer">JUnit Source: `test.unit.stats.OnlineNormalEstimatorTest.java`</a>
<li><a href="http://alias-i.com/lingpipe" rel="noreferrer">LingPipe Home Page</a>
</ul>

#### Answer 2 (score 70)
The basic answer is to accumulate the sum of both <em>x</em> (call it 'sum_x1') and <em>x</em><sup>2</sup> (call it 'sum_x2') as you go.  The value of the standard deviation is then:  

```perl
stdev = sqrt((sum_x2 / n) - (mean * mean)) 
```

where  

```perl
mean = sum_x / n
```

This is the sample standard deviation; you get the population standard deviation using 'n' instead of 'n - 1' as the divisor.  

You may need to worry about the numerical stability of taking the difference between two large numbers if you are dealing with large samples.  Go to the external references in other answers (Wikipedia, etc) for more information.  

#### Answer 3 (score 26)
Perhaps not what you were asking, but ... If you use a numpy array, it will do the work for you, efficiently:  

```perl
from numpy import array

nums = array(((0.01, 0.01, 0.02, 0.04, 0.03),
              (0.00, 0.02, 0.02, 0.03, 0.02),
              (0.01, 0.02, 0.02, 0.03, 0.02),
              (0.01, 0.00, 0.01, 0.05, 0.03)))

print nums.std(axis=1)
# [ 0.0116619   0.00979796  0.00632456  0.01788854]

print nums.mean(axis=1)
# [ 0.022  0.018  0.02   0.02 ]
```

By the way, there's some interesting discussion in this blog post and comments on one-pass methods for computing means and variances:  

<ul>
<li><a href="http://lingpipe-blog.com/2009/03/19/computing-sample-mean-variance-online-one-pass/" rel="noreferrer">http://lingpipe-blog.com/2009/03/19/computing-sample-mean-variance-online-one-pass/</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Counting array elements in Perl (score [112206](https://stackoverflow.com/q/863426) in 2016)

#### Question
How do I get the total items in an array, NOT the last id?  

None of two ways I found to do this works:  

```perl
my @a;
# Add some elements (no consecutive ids)
$a[0]= '1';
$a[5]= '2';
$a[23]= '3';

print $#a, "\n"; # Prints 23
print scalar(@a), "\n"; # Prints 24
```

I expected to get 3...  

#### Answer accepted (score 39)
<strong>Edit: Hash versus Array</strong>  

As cincodenada correctly pointed out in the comment, ysth gave a better answer: I should have answered your question with another question:  "Do you really want to use a Perl array? A hash may be more appropriate."  

An array allocates memory for all possible indices up to the largest used so-far.  In your example, you allocate 24 cells (but use only 3).  By contrast, a hash only allocates space for those fields that are actually used.  

<strong>Array solution: scalar grep</strong>  

Here are two possible solutions (see below for explanation):  

```perl
print scalar(grep {defined $_} @a), "\n";  # prints 3
print scalar(grep $_, @a), "\n";            # prints 3
```

Explanation: After adding `$a[23]`, your array really contains 24 elements --- but most of them are undefined (which also evaluates as false).  You can count the number of defined elements (as done in the first solution) or the number of true elements (second solution).  

What is the difference? If you set `$a[10]=0`, then the first solution will count it, but the second solution won't (because 0 is false but defined).  If you set `$a[3]=undef`, none of the solutions will count it.  

<strong>Hash solution (by yst)</strong>  

As suggested by another solution, you can work with a hash and avoid all the problems:  

```perl
$a{0}  = 1;
$a{5}  = 2;
$a{23} = 3;
print scalar(keys %a), "\n";  # prints 3
```

This solution counts zeros and undef values.  

#### Answer 2 (score 16)
It sounds like you want a <a href="http://en.wikipedia.org/wiki/Sparse_array" rel="nofollow noreferrer">sparse array</a>.  A normal array would have 24 items in it, but a sparse array would have 3.  In Perl we emulate sparse arrays with hashes:  

```perl
#!/usr/bin/perl

use strict;
use warnings;

my %sparse;

@sparse{0, 5, 23} = (1 .. 3);

print "there are ", scalar keys %sparse, " items in the sparse array\n",
    map { "\t$sparse{$_}\n" } sort { $a <=> $b } keys %sparse;
```

The `keys` function in scalar context will return the number of items in the sparse array.  The only downside to using a hash to emulate a sparse array is that you must sort the keys before iterating over them if their order is important.  

You must also remember to use the <a href="http://perldoc.perl.org/functions/delete.html" rel="nofollow noreferrer">`delete`</a> function to remove items from the sparse array (just setting their value to undef is not enough).  

#### Answer 3 (score 14)
Maybe you want a hash instead (or in addition).  Arrays are an ordered set of elements; if you create `$foo[23]`, you implicitly create `$foo[0]` through `$foo[22]`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: Better way to remove specific characters from a Perl string (score [110624](https://stackoverflow.com/q/9847554) in 2015)

#### Question
I have dynamically generated strings like `@#@!efq@!#!`, and I want to remove specific characters from the string using Perl.  

Currently I am doing something this (replacing the characters with nothing):  

```perl
$varTemp =~ s/['\$','\#','\@','\~','\!','\&','\*','\(','\)','\[','\]','\;','\.','\,','\:','\?','\^',' ', '\`','\\','\/']//g;
```

Is there a better way of doing this? I am fooking for something clean.  

#### Answer accepted (score 24)
You've misunderstood how <a href="http://www.regular-expressions.info/charclass.html" rel="noreferrer">character classes</a> are used:  

```perl
$varTemp =~ s/[\$#@~!&*()\[\];.,:?^ `\\\/]+//g;
```

does the same as your regex (assuming you didn't mean to remove `'` characters from your strings).   

Edit: The `+` allows several of those "special characters" to match at once, so it should also be faster.  

#### Answer 2 (score 17)
You could use the tr instead:   

```perl
       $p =~ tr/fo//d;
```

will delete every f and every o from `$p`. In your case it should be:  

```perl
       $p =~ tr/\$#@~!&*()[];.,:?^ `\\\///d
```

#### Answer 3 (score 7)
With a character class this big it is easier to say what you want to keep. A caret in the first position of a character class inverts its sense, so you can write  

```perl
$varTemp =~ s/[^"%'+\-0-9<=>a-z_{|}]+//gi
```

or, using the more efficient `tr`  

```perl
$varTemp =~ tr/"%'+\-0-9<=>A-Z_a-z{|}//cd
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: how to remove the first two columns in a file using shell (awk, sed, whatever) (score [109506](https://stackoverflow.com/q/13446255) in 2016)

#### Question
<p>I have a file with many lines
in each line there are many columns(fields) separated by blank " "
the numbers of columns in each line are different
I want to remove the first two columns
how to?</p>

#### Answer 2 (score 138)
You can do it with `cut`:  

```perl
cut -d " " -f 3- input_filename > output_filename
```

<strong>Explanation:</strong>  

<ul>
<li>`cut`: invoke the cut command</li>
<li>`-d " "`: use a single space as the delimiter (`cut` uses TAB by default)</li>
<li>`-f`: specify fields to keep</li>
<li>`3-`: all the fields starting with field 3</li>
<li>`input_filename`: use this file as the input</li>
<li>`&gt; output_filename`: write the output to this file.</li>
</ul>

Alternatively, you can do it with `awk`:  

```perl
awk '{$1=""; $2=""; sub("  ", " "); print}' input_filename > output_filename
```

<strong>Explanation:</strong>  

<ul>
<li>`awk`: invoke the awk command</li>
<li>`$1=""; $2="";`: set field 1 and 2 to the empty string</li>
<li>`sub(...);`: clean up the output fields because fields 1 &amp; 2 will still be delimited by " "</li>
<li>`print`: print the modified line</li>
<li>`input_filename &gt; output_filename`: same as above.</li>
</ul>

#### Answer 3 (score 22)
Here's one way to do it with Awk that's relatively easy to understand:  

```perl
awk '{print substr($0, index($0, $3))}'
```

This is a simple awk command with no pattern, so action inside `{}` is run for every input line.   

The action is to simply prints the substring starting with the position of the 3rd field.  

<ul>
<li>`$0`: the whole input line</li>
<li>`$3`: 3rd field</li>
<li>`index(in, find)`: returns the position of `find` in string `in`</li>
<li>`substr(string, start)`: return a substring starting at index `start`</li>
</ul>

If you want to use a different delimiter, such as comma, you can specify it with the -F option:  

```perl
awk -F"," '{print substr($0, index($0, $3))}'
```

You can also operate this on a subset of the input lines by specifying a pattern before the action in `{}`. Only lines matching the pattern will have the action run.  

```perl
awk 'pattern{print substr($0, index($0, $3))}'
```

Where pattern can be something such as:  

<ul>
<li>`/abcdef/`: use regular expression, operates on $0 by default.</li>
<li>`$1 ~ /abcdef/`: operate on a specific field.</li>
<li>`$1 == blabla`: use string comparison</li>
<li>`NR &gt; 1`: use record/line number</li>
<li>`NF &gt; 0`: use field/column number</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: What's the safest way to iterate through the keys of a Perl hash? (score [109288](https://stackoverflow.com/q/3033) in 2008)

#### Question
If I have a Perl hash with a bunch of (key, value) pairs, what is the preferred method of iterating through all the keys?  I have heard that using `each` may in some way have unintended side effects.  So, is that true, and is one of the two following methods best, or is there a better way?  

```perl
# Method 1
while (my ($key, $value) = each(%hash)) {
    # Something
}

# Method 2
foreach my $key (keys(%hash)) {
    # Something
}
```

#### Answer accepted (score 192)
The rule of thumb is to use the function most suited to your needs.  

If you just want the keys and do not plan to ever <em>read</em> any of the values, use keys():  

```perl
foreach my $key (keys %hash) { ... }
```

If you just want the values, use values():  

```perl
foreach my $val (values %hash) { ... }
```

If you need the keys <em>and</em> the values, use each():  

```perl
keys %hash; # reset the internal iterator so a prior each() doesn't affect the loop
while(my($k, $v) = each %hash) { ... }
```

If you plan to change the keys of the hash in any way <em>except</em> for deleting the current key during the iteration, then you must not use each().  For example, this code to create a new set of uppercase keys with doubled values works fine using keys():  

```perl
%h = (a => 1, b => 2);

foreach my $k (keys %h)
{
  $h{uc $k} = $h{$k} * 2;
}
```

producing the expected resulting hash:  

```perl
(a => 1, A => 2, b => 2, B => 4)
```

But using each() to do the same thing:  

```perl
%h = (a => 1, b => 2);

keys %h;
while(my($k, $v) = each %h)
{
  $h{uc $k} = $h{$k} * 2; # BAD IDEA!
}
```

produces incorrect results in hard-to-predict ways.  For example:  

```perl
(a => 1, A => 2, b => 2, B => 8)
```

This, however, is safe:  

```perl
keys %h;
while(my($k, $v) = each %h)
{
  if(...)
  {
    delete $h{$k}; # This is safe
  }
}
```

All of this is described in the perl documentation:  

```perl
% perldoc -f keys
% perldoc -f each
```

#### Answer 2 (score 25)
<p>One thing you should be aware of when using <strong>`each`</strong> is that it has
the side effect of adding "state" to your hash (the hash has to remember
what the "next" key is). When using code like the snippets posted above,
which iterate over the whole hash in one go, this is usually not a
problem. However, you will run into hard to track down problems (I speak from
experience ;), when using `each` together with statements like
`last` or `return` to exit from the `while ... each` loop before you
have processed all keys.</p>

<p>In this case, the hash will remember which keys it has already returned, and
when you use `each` on it the next time (maybe in a totaly unrelated piece of
code), it will continue at this position. </p>

Example:  

```perl
my %hash = ( foo => 1, bar => 2, baz => 3, quux => 4 );

# find key 'baz'
while ( my ($k, $v) = each %hash ) {
    print "found key $k\n";
    last if $k eq 'baz'; # found it!
}

# later ...

print "the hash contains:\n";

# iterate over all keys:
while ( my ($k, $v) = each %hash ) {
    print "$k => $v\n";
}
```

This prints:  

```perl
found key bar
found key baz
the hash contains:
quux => 4
foo => 1
```

<p>What happened to keys "bar" and baz"? They're still there, but the
second `each` starts where the first one left off, and stops when it reaches the end of the hash, so we never see them in the second loop.</p>

#### Answer 3 (score 20)
The place where `each` can cause you problems is that it's a true, non-scoped iterator.  By way of example:  

```perl
while ( my ($key,$val) = each %a_hash ) {
    print "$key => $val\n";
    last if $val; #exits loop when $val is true
}

# but "each" hasn't reset!!
while ( my ($key,$val) = each %a_hash ) {
    # continues where the last loop left off
    print "$key => $val\n";
}
```

If you need to be sure that `each` gets all the keys and values, you need to make sure you use `keys` or `values` first (as that resets the iterator).  See the <a href="http://perldoc.perl.org/functions/each.html" rel="noreferrer">documentation for each</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: What is the difference between my and our in Perl? (score [107621](https://stackoverflow.com/q/845060) in 2015)

#### Question
I know what `my` is in Perl.  It defines a variable that exists only in the scope of the block in which it is defined.  What does `our` do?  How does `our` differ from `my`?  

#### Answer accepted (score 211)
Great question: How does <strong><em>`our`</em></strong> differ from <strong><em>`my`</em></strong> and what does <em>`our`</em> do?  

In Summary:   

Available since Perl 5, <strong><em>`my`</em></strong> is a way to declare:   

<ul>
<li>non-package variables, that are</li>
<li>private, </li>
<li><em>new</em>, </li>
<li><em>non-global</em> variables,  </li>
<li>separate from any package. So that the variable <em>cannot</em> be accessed in the form of `$package_name::variable`.</li>
</ul>

<br>  

On the other hand, <strong><em>`our`</em></strong> variables are:  

<ul>
<li>package variables, and thus automatically </li>
<li><em>global</em> variables, </li>
<li>definitely <em>not private</em>, </li>
<li>nor are they necessarily new; and they </li>
<li><em>can</em> be accessed outside the package (or lexical scope) with the
qualified namespace, as `$package_name::variable`.</li>
</ul>

<br>  

Declaring a variable with <strong><em>`our`</em></strong> allows you to predeclare variables in order to use them under <em>`use strict`</em> without getting typo warnings or compile-time errors. Since Perl 5.6, it has replaced the obsolete <em>`use vars`</em>, which was only file-scoped, and not lexically scoped as is <strong><em>`our`</em></strong>.  

For example, the formal, qualified name for variable `$x` inside `package main` is `$main::x`. Declaring <strong><em>`our $x`</em></strong> allows you to use the bare `$x` variable without penalty (i.e., without a resulting error), in the scope of the declaration, when the script uses <em>`use strict`</em> or <em>`use strict "vars"`</em>. The scope might be one, or two, or more packages, or one small block.  

#### Answer 2 (score 59)
The PerlMonks and PerlDoc links from cartman and Olafur are a great reference - below is my crack at a summary:  

`my` variables are lexically scoped within a single block defined by `{}` or within the  same file if not in `{}`s.  They are not accessible from packages/subroutines defined outside of the same lexical scope / block.  

`our` variables are scoped within a package/file and accessible from any code that `use` or `require` that package/file - name conflicts are resolved between packages by prepending the appropriate namespace.  

Just to round it out, `local` variables are "dynamically" scoped, differing from `my` variables in that they are also accessible from subroutines called within the same block.  

#### Answer 3 (score 48)
An example:  

```perl
use strict;

for (1 .. 2){
    # Both variables are lexically scoped to the block.
    our ($o);  # Belongs to 'main' package.
    my  ($m);  # Does not belong to a package.

    # The variables differ with respect to newness.
    $o ++;
    $m ++;
    print __PACKAGE__, " >> o=$o m=$m\n";  # $m is always 1.

    # The package has changed, but we still have direct,
    # unqualified access to both variables, because the
    # lexical scope has not changed.
    package Fubb;
    print __PACKAGE__, " >> o=$o m=$m\n";
}

# The our() and my() variables differ with respect to privacy.
# We can still access the variable declared with our(), provided
# that we fully qualify its name, but the variable declared
# with my() is unavailable.
print __PACKAGE__, " >> main::o=$main::o\n";  # 2
print __PACKAGE__, " >> main::m=$main::m\n";  # Undefined.

# Attempts to access the variables directly won't compile.
# print __PACKAGE__, " >> o=$o\n";
# print __PACKAGE__, " >> m=$m\n";

# Variables declared with use vars() are like those declared
# with our(): belong to a package; not private; and not new.
# However, their scoping is package-based rather than lexical.
for (1 .. 9){
    use vars qw($uv);
    $uv ++;
}

# Even though we are outside the lexical scope where the
# use vars() variable was declared, we have direct access
# because the package has not changed.
print __PACKAGE__, " >> uv=$uv\n";

# And we can access it from another package.
package Bubb;
print __PACKAGE__, " >> main::uv=$main::uv\n";
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: How can I list all of the files in a directory with Perl? (score [107466](https://stackoverflow.com/q/1045792) in 2014)

#### Question
<p>Is there a function in Perl that lists all the files and directories in a directory?
I remember that Java has the `File.list()` to do this? Is there a comparable method in Perl?</p>

#### Answer accepted (score 83)
If you want to get content of given directory, and only it (i.e. no subdirectories), the best way is to use opendir/readdir/closedir:  

```perl
opendir my $dir, "/some/path" or die "Cannot open directory: $!";
my @files = readdir $dir;
closedir $dir;
```

You can also use:  

```perl
my @files = glob( $dir . '/*' );
```

But in my opinion it is not as good - mostly because glob is quite complex thing (can filter results automatically) and using it to get all elements of directory seems as a too simple task.  

On the other hand, if you need to get content from all of the directories and subdirectories, there is basically one standard solution:  

```perl
use File::Find;

my @content;
find( \&wanted, '/some/path');
do_something_with( @content );

exit;

sub wanted {
  push @content, $File::Find::name;
  return;
}
```

#### Answer 2 (score 12)
readdir() does that.  

Check <a href="http://perldoc.perl.org/functions/readdir.html" rel="noreferrer">http://perldoc.perl.org/functions/readdir.html</a>  

```perl
opendir(DIR, $some_dir) || die "can't opendir $some_dir: $!";
@dots = grep { /^\./ && -f "$some_dir/$_" } readdir(DIR);
closedir DIR;
```

#### Answer 3 (score 11)
Or <a href="http://search.cpan.org/~nwclark/perl-5.8.9/lib/File/Find.pm" rel="noreferrer">File::Find</a>  

```perl
use File::Find;
finddepth(\&wanted, '/some/path/to/dir');
sub wanted { print };
```

It'll go through subdirectories if they exist.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: How do I sleep for a millisecond in Perl? (score [107325](https://stackoverflow.com/q/896904) in 2012)

#### Question
How do I sleep for shorter than a second in Perl?  

#### Answer accepted (score 104)
From the Perldoc page on <a href="http://perldoc.perl.org/functions/sleep.html" rel="noreferrer">sleep</a>:  

<blockquote>
  For delays of finer granularity than one second, the <a href="http://perldoc.perl.org/Time/HiRes.html" rel="noreferrer">Time::HiRes</a> module (from CPAN, and starting from Perl 5.8 part of the standard distribution) provides usleep().  
</blockquote>

Actually, it provides `usleep()` (which sleeps in microseconds) and `nanosleep()` (which sleeps in nanoseconds). You may want `usleep()`, which should let you deal with easier numbers. 1 millisecond sleep (using each):  

```perl
use strict;
use warnings;

use Time::HiRes qw(usleep nanosleep);

# 1 millisecond == 1000 microseconds
usleep(1000);
# 1 microsecond == 1000 nanoseconds
nanosleep(1000000);
```

If you don't want to (or can't) load a module to do this, you may also be able to use the built-in <a href="http://perldoc.perl.org/functions/select.html" rel="noreferrer">`select()`</a> function:  

```perl
# Sleep for 250 milliseconds
select(undef, undef, undef, 0.25);
```

#### Answer 2 (score 34)
Time::HiRes:  

```perl
  use Time::HiRes;
  Time::HiRes::sleep(0.1); #.1 seconds
  Time::HiRes::usleep(1); # 1 microsecond.
```

<a href="http://perldoc.perl.org/Time/HiRes.html" rel="noreferrer">http://perldoc.perl.org/Time/HiRes.html</a>  

#### Answer 3 (score 12)
From <a href="http://faq.perl.org/perlfaq8.html#How_can_I_sleep_or_a" rel="noreferrer">perlfaq8</a>:  

<hr>

<strong>How can I sleep() or alarm() for under a second?</strong>  

If you want finer granularity than the 1 second that the sleep() function provides, the easiest way is to use the select() function as documented in select in perlfunc. Try the Time::HiRes and the BSD::Itimer modules (available from CPAN, and starting from Perl 5.8 Time::HiRes is part of the standard distribution).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: In Perl, how to remove ^M from a file? (score [106742](https://stackoverflow.com/q/650743) in 2017)

#### Question
I have a script that is appending new fields to an existing CSV, however `^M` characters are appearing at the end of the old lines so the new fields end up on a new row instead of the same one. How do I remove `^M` characters from a CSV file using Perl?  

#### Answer accepted (score 14)
You found out you can also do this:  

```perl
$line=~ tr/\015//d;
```

#### Answer 2 (score 46)
^M is carriage return. You can do this:  

```perl
$str =~ s/\r//g
```

#### Answer 3 (score 23)
Or a 1-liner:  

```perl
perl -p -i -e 's/\r\n$/\n/g' file1.txt file2.txt ... filen.txt
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: Split a string into array in Perl (score [106685](https://stackoverflow.com/q/16872340) in 2018)

#### Question
```perl
my $line = "file1.gz file2.gz file3.gz";
my @abc = split('', $line);
print "@abc\n";
```

Expected output:  

```perl
file1.gz
file2.gz
file3.gz
```

I want the output to be `file1.gz` in `$abc[0]`, `file2.gz` in `$abc[1]`, and  `file3.gz` in `$abc[2]`. How do I split `$line`?  

#### Answer accepted (score 15)
Splitting a string by whitespace is very simple:  

```perl
print $_, "\n" for split ' ', 'file1.gz file1.gz file3.gz';
```

This is a special form of `split` actually (as this function usually takes patterns instead of strings):  

<blockquote>
  <p>As another special case, `split` emulates the default behavior of the
  command line tool `awk` when the `PATTERN` is either omitted or a literal
  string composed of a single space character (such as `' '` or `"\x20"`). In this case, any leading whitespace in `EXPR` is
  removed before splitting occurs, and the `PATTERN` is instead treated as
  if it were `/\s+/`; in particular, this means that any contiguous
  whitespace (not just a single space character) is used as a separator.</p>
</blockquote>

<hr>

Here's an answer for the original question (with a simple string without any whitespace):  

Perhaps you want to split on `.gz` extension:  

```perl
my $line = "file1.gzfile1.gzfile3.gz";
my @abc = split /(?<=\.gz)/, $line;
print $_, "\n" for @abc;
```

Here I used `(?&lt;=...)` construct, which is <a href="http://perldoc.perl.org/perlre.html#Look-Around-Assertions">look-behind assertion</a>, basically making split at each point in the line preceded by `.gz` substring.  

If you work with the fixed set of extensions, you can extend the pattern to include them all:  

```perl
my $line = "file1.gzfile2.txtfile2.gzfile3.xls";
my @exts = ('txt', 'xls', 'gz');
my $patt = join '|', map { '(?<=\.' . $_ . ')' } @exts;
my @abc = split /$patt/, $line;
print $_, "\n" for @abc;
```

#### Answer 2 (score 10)
Having `$line` as it is now, you can simply split the string based on at least one whitespace separator  

```perl
my @answer = split(' ', $line); # creates an @answer array
```

then   

```perl
print("@answer\n");               # print array on one line
```

or  

```perl
print("$_\n") for (@answer);      # print each element on one line
```

I prefer using `()` for `split`, `print` and `for`.  

#### Answer 3 (score -1)
I found this one to be very simple!  

```perl
my $line = "file1.gz file2.gz file3.gz";

my @abc =  ($line =~ /(\w+[.]\w+)/g);

print $abc[0],"\n";
print $abc[1],"\n";
print $abc[2],"\n";
```

output:  

```perl
file1.gz 
file2.gz 
file3.gz
```

Here take a look at this tutorial to find more on <a href="http://perldoc.perl.org/perlrequick.html" rel="nofollow noreferrer">Perl regular expression</a> and scroll down to <strong>More matching</strong> section.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Printing everything except the first field with awk (score [105846](https://stackoverflow.com/q/4198138) in 2018)

#### Question
I have a file that looks like this:  

```perl
AE  United Arab Emirates
AG  Antigua & Barbuda
AN  Netherlands Antilles
AS  American Samoa
BA  Bosnia and Herzegovina
BF  Burkina Faso
BN  Brunei Darussalam
```

And I 'd like to invert the order, printing first everything except $1 and then $1:  

```perl
United Arab Emirates AE
```

How can I do the "everything except field 1" trick?  

#### Answer accepted (score 81)
Assigning `$1` works but it will leave a leading space: `awk '{first = $1; $1 = ""; print $0, first; }'`  

You can also find the number of columns in `NF` and use that in a loop.  

#### Answer 2 (score 101)
`$1=""` leaves a space as Ben Jackson mentioned, so use a `for` loop:  

```perl
awk '{for (i=2; i<=NF; i++) print $i}' filename
```

So if your string was "one two three", the output will be:  

<p>two <br/>
three</p>

If you want the result in one row, you could do as follows:  

```perl
awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}' filename
```

This will give you: "two three"  

#### Answer 3 (score 62)
Use the `cut` command with the `--complement` option:  

```perl
$ echo a b c | cut -f 1 -d ' '
a
$ echo a b c | cut -f 1,2 -d ' '
a b
$ echo a b c | cut -f 1 -d ' ' --complement
b c
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: "End of script output before headers" error in Apache (score [105429](https://stackoverflow.com/q/22307610) in 2014)

#### Question
Apache on Windows gives me the following error when I try to access my Perl script:  

```perl
Server error!

The server encountered an internal error and was unable to complete your request.

Error message: 
End of script output before headers: sample.pl

If you think this is a server error, please contact the webmaster.

Error 500

localhost
Apache/2.4.4 (Win32) OpenSSL/1.0.1e PHP/5.5.3
```

this is my sample script  

```perl
#!"C:\xampp\perl\bin\perl.exe"
print "Hello World";
```

but not working on browser  

#### Answer 2 (score 18)
Check file permissions.  

I had exactly the same error on a Linux machine with the wrong permissions set.  

`chmod 755 myfile.pl`  

solved the problem.  

#### Answer 3 (score 15)
If this is a CGI script for the web, then you must output your header:  

```perl
#!"C:\xampp\perl\bin\perl.exe"

print "Content-Type: text/html\n\n";
print "Hello World";
```

The following error message tells you this `End of script output before headers: sample.pl`  

Or even better, use the <a href="http://search.cpan.org/search?query=CGI&amp;mode=all" rel="nofollow noreferrer">CGI</a> module to output the header:  

```perl
#!"C:\xampp\perl\bin\perl.exe"

use strict;
use warnings;

use CGI;

print CGI::header();
print "Hello World";
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: Neatest way to remove linebreaks in Perl (score [105050](https://stackoverflow.com/q/881779) in 2009)

#### Question
I'm maintaining a script that can get its input from various sources, and works on it per line. Depending on the actual source used, linebreaks might be Unix-style, Windows-style or even, for some aggregated input, mixed(!).  

When reading from a file it goes something like this:  

```perl
@lines = <IN>;
process(\@lines);

...

sub process {
    @lines = shift;
    foreach my $line (@{$lines}) {
        chomp $line;
        #Handle line by line
    }
}
```

<p>So, what I need to do is replace the chomp with something that removes either Unix-style or Windows-style linebreaks.
I'm coming up with way too many ways of solving this, one of the usual drawbacks of Perl :)</p>

What's your opinion on the neatest way to chomp off generic linebreaks? What would be the most efficient?  

Edit: A small clarification - the method 'process' gets a list of lines from somewhere, <em>not nessecarily read from a file</em>. Each line might have  

<ul>
<li>No trailing linebreaks</li>
<li>Unix-style linebreaks</li>
<li>Windows-style linebreaks</li>
<li>Just Carriage-Return (when original data has Windows-style linebreaks and is read with $/ = '\n')</li>
<li>An aggregated set where lines have different styles</li>
</ul>

#### Answer accepted (score 88)
After digging a bit through the <a href="http://perldoc.perl.org/perlre.html" rel="noreferrer">perlre</a> docs a bit, I'll present my best suggestion so far that seems to work pretty good. Perl 5.10 added the \R character class as a generalized linebreak:  

```perl
$line =~ s/\R//g;
```

It's the same as:  

```perl
(?>\x0D\x0A?|[\x0A-\x0C\x85\x{2028}\x{2029}])
```

I'll keep this question open a while yet, just to see if there's more nifty ways waiting to be suggested.  

#### Answer 2 (score 12)
Whenever I go through input and want to remove or replace characters I run it through little subroutines like this one.  

```perl
sub clean {

    my $text = shift;

    $text =~ s/\n//g;
    $text =~ s/\r//g;

    return $text;
}
```

It may not be fancy but this method has been working flawless for me for years.  

#### Answer 3 (score 7)
Reading <a href="http://perldoc.perl.org/5.8.8/perlport.html#Newlines" rel="noreferrer">perlport</a> I'd suggest something like  

```perl
$line =~ s/\015?\012?$//;
```

to be safe for whatever platform you're on and whatever linefeed style you may be processing because what's in \r and \n may differ through different Perl flavours.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: Grep to find item in Perl array (score [105013](https://stackoverflow.com/q/7898499) in 2017)

#### Question
Every time I input something the code always tells me that it exists. But I know some of the inputs do not exist. What is wrong?  

```perl
#!/usr/bin/perl

@array = <>;
print "Enter the word you what to match\n";
chomp($match = <STDIN>);

if (grep($match, @array)) {
    print "found it\n";
}
```

#### Answer accepted (score 30)
The first arg that you give to grep needs to evaluate as true or false to indicate whether there was a match. So it should be:  

```perl
# note that grep returns a list, so $matched needs to be in brackets to get the 
# actual value, otherwise $matched will just contain the number of matches
if (my ($matched) = grep $_ eq $match, @array) {
    print "found it: $matched\n";
}
```

If you need to match on a lot of different values, it might also be worth for you to consider putting the `array` data into a `hash`, since hashes allow you to do this efficiently without having to iterate through the list.  

```perl
# convert array to a hash with the array elements as the hash keys and the values are simply 1
my %hash = map {$_ => 1} @array;

# check if the hash contains $match
if (defined $hash{$match}) {
    print "found it\n";
}
```

#### Answer 2 (score 27)
You seem to be using `grep()` like the Unix `grep` utility, which is wrong.  

<p>Perl's <a href="http://perldoc.perl.org/functions/grep.html" rel="noreferrer">`grep()`</a> in scalar context evaluates the expression for each element of a list and returns the number of times the expression was true.
So when `$match` contains any "true" value, `grep($match, @array)` in scalar context will always return the number of elements in `@array`.</p>

Instead, try using the pattern matching operator:  

```perl
if (grep /$match/, @array) {
    print "found it\n";
}
```

#### Answer 3 (score 2)
In addition to what eugene and stevenl posted, you might encounter problems with using both `&lt;&gt;` and `&lt;STDIN&gt;` in one script: `&lt;&gt;` iterates through (=concatenating) all files given as command line arguments.  

However, should a user ever forget to specify a file on the command line, it will read from STDIN, and your code will wait forever on input  

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: automatically get loop index in foreach loop in perl (score [104712](https://stackoverflow.com/q/974656) in )

#### Question
If I have the following array in Perl:  

```perl
@x = qw(a b c);
```

and I iterate over it with `foreach`, then `$_` will refer to the current <em>element</em> in the array:  

```perl
foreach (@x) {
    print;
}
```

will print:  

```perl
abc
```

Is there a similar way to get the <em>index</em> of the current element, without manually updating a counter?  Something such as:  

```perl
foreach (@x) {
    print $index;
}
```

where `$index` is updated like `$_` to yield the output:  

```perl
012
```

#### Answer accepted (score 106)
Like codehead said, you'd have to iterate over the array indices instead of its elements. I prefer this variant over the C-style for loop:  

```perl
for my $i (0 .. $#x) {
    print "$i: $x[$i]\n";
}
```

#### Answer 2 (score 43)
In Perl prior to 5.10, you can say  

```perl
#!/usr/bin/perl

use strict;
use warnings;

my @a = qw/a b c d e/;

my $index;
for my $elem (@a) {
    print "At index ", $index++, ", I saw $elem\n";
}

#or

for my $index (0 .. $#a) {
    print "At index $index I saw $a[$elem]\n";
}    
```

In Perl 5.10, you use <a href="http://perldoc.perl.org/functions/state.html" rel="noreferrer">state</a> to declare a variable that never gets reinitialized (unlike ones create with <a href="http://perldoc.perl.org/functions/my.html" rel="noreferrer">my</a>).  This lets you keep the `$index` variable in a smaller scope, but can lead to bugs (if you enter the loop a second time it will still have the last value):  

```perl
#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

my @a = qw/a b c d e/;

for my $elem (@a) {
    state $index;
    say "At index ", $index++, ", I saw $elem";
}
```

In Perl 5.12 you can say  

```perl
#!/usr/bin/perl

use 5.012; #this enables strict
use warnings;

my @a = qw/a b c d e/;

while (my ($index, $elem) = each @a) {
    say "At index $index I saw $elem";
}
```

But be warned: you there are <a href="http://perldoc.perl.org/functions/each.html" rel="noreferrer">restrictions</a> to what you are allowed to do with `@a` while iterating over it with `each`.  

It won't help you now, but in Perl 6 you will be able to say  

```perl
#!/usr/bin/perl6

my @a = <a b c d e>;
for @a Z 0 .. Inf -> $elem, $index {
    say "at index $index, I saw $elem"
}
```

The `Z` operator zips the two lists together (i.e. it takes one element from the first list, then one element from the second, then one element from the first, and so on).  The second list is a <a href="http://en.wikipedia.org/wiki/Lazy_evaluation" rel="noreferrer">lazy</a> list that contains every integer from 0 to infinity (at least theoretically).  The `-&gt; $elem, $index` says that we are taking two values at a time from the result of the zip.  The rest should look normal to you (unless you are not familiar with the <a href="http://perldoc.perl.org/functions/say.html" rel="noreferrer">`say`</a> function from 5.10 yet).  

#### Answer 3 (score 22)
`perldoc perlvar` does not seem to suggest any such variable.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: Search and replace a particular string in a file using Perl (score [104110](https://stackoverflow.com/q/8224490) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://stackoverflow.com/questions/6994947/how-to-replace-a-string-in-an-existing-file-in-perl">How to replace a string in an existing file in Perl?</a>  </p>
</blockquote>



I need to create a subroutine that does a search and replace in file.    

Here's the contents of myfiletemplate.txt:    

```perl
CATEGORY1=youknow_<PREF>  
CATEGORY2=your/<PREF>/goes/here/
```

Here's my replacement string: `ABCD`    

I need to replace all instances of `&lt;PREF&gt;` to `ABCD`    

#### Answer accepted (score 22)
Quick and dirty:  

```perl
#!/usr/bin/perl -w

use strict;

open(FILE, "</tmp/yourfile.txt") || die "File not found";
my @lines = <FILE>;
close(FILE);

foreach(@lines) {
   $_ =~ s/<PREF>/ABCD/g;
}

open(FILE, ">/tmp/yourfile.txt") || die "File not found";
print FILE @lines;
close(FILE);
```

Perhaps it i a good idea not to write the result back to your original file; instead write it to a copy and check the result first.  

#### Answer 2 (score 41)
A one liner:  

```perl
perl -pi.back -e 's/<PREF>/ABCD/g;' inputfile
```

#### Answer 3 (score 16)
You could also do this:  

```perl
#!/usr/bin/perl

use strict;
use warnings;

$^I = '.bak'; # create a backup copy 

while (<>) {
   s/<PREF>/ABCD/g; # do the replacement
   print; # print to the modified file
}
```

Invoke the script with by  

```perl
./script.pl input_file
```

You will get a file named `input_file`, containing your changes, and a file named `input_file.bak`, which is simply a copy of the original file.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: How do I update all my CPAN modules to their latest versions? (score [103764](https://stackoverflow.com/q/3727795) in 2016)

#### Question
How do I update all my CPAN modules to their latest versions?  

#### Answer accepted (score 139)
An alternative method to using `upgrade` from the default CPAN shell is to use <a href="https://search.cpan.org/dist/App-cpanminus/lib/App/cpanminus.pm" rel="noreferrer">`cpanminus`</a> and <a href="https://search.cpan.org/dist/App-cpanoutdated/bin/cpan-outdated" rel="noreferrer">`cpan-outdated`</a>.  

These are so easy and nimble to use that I hardly ever go back to CPAN shell. To upgrade all of your modules in one go, the command is:  

```perl
cpan-outdated -p | cpanm
```

I recommend you install `cpanminus` like the docs describe:  

```perl
curl -L https://cpanmin.us | perl - App::cpanminus
```

And then install `cpan-outdated` along with all other CPAN modules using `cpanm`:  

```perl
cpanm App::cpanoutdated
```

BTW: If you are using `perlbrew` then you will need to repeat this for every Perl you have installed under it.  

You can find out more about `cpanminus` and `cpan-outdated` at the Github repos here:  

<ul>
<li><a href="https://github.com/miyagawa/cpanminus" rel="noreferrer">https://github.com/miyagawa/cpanminus</a></li>
<li><a href="https://github.com/tokuhirom/cpan-outdated" rel="noreferrer">https://github.com/tokuhirom/cpan-outdated</a></li>
</ul>

#### Answer 2 (score 48)
An easy way to upgrade all Perl packages (CPAN modules) is the following way:  

```perl
cpan upgrade /(.*)/
```

cpan will recognize the regular expression like this and will update/upgrade all packages installed.  

#### Answer 3 (score 31)
For Strawberry Perl, try:  

```perl
cpan -u
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: How should I do integer division in Perl? (score [103299](https://stackoverflow.com/q/539797) in 2009)

#### Question
What is a good way to <strong>always</strong> do integer division in Perl?  

For example, I want:  

```perl
real / int = int

int / real = int

int / int = int
```

#### Answer accepted (score 44)
You can cast ints in Perl:  

```perl
int(5/1.5) = 3;
```

#### Answer 2 (score 83)
The lexically scoped <a href="http://perldoc.perl.org/integer.html" rel="noreferrer">`integer` pragma</a> forces Perl to use integer arithmetic in its scope:  

```perl
print 3.0/2.1 . "\n";    # => 1.42857142857143
{
  use integer;
  print 3.0/2.1 . "\n";  # => 1
}
print 3.0/2.1 . "\n";    # => 1.42857142857143
```

#### Answer 3 (score 5)
`int(x+.5)` will round <em>positive</em> values toward the nearest integer. Rounding up is harder.  

To round toward zero:  

`int($x)`  

For the solutions below, include the following statement:  

`use POSIX;`  

To round down: `POSIX::floor($x)`  

To round up: `POSIX::ceil($x)`  

To round away from zero: `POSIX::floor($x) - int($x) + POSIX::ceil($x)`  

To round off to the nearest integer: `POSIX::floor($x+.5)`  

Note that `int($x+.5)` fails badly for negative values. `int(-2.1+.5)` is `int(-1.6)`, which is -1.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: Rename Files and Directories (Add Prefix) (score [101108](https://stackoverflow.com/q/4787413) in 2011)

#### Question
I would like to add prefix on all folders and directories.  

Example:  

I have  

```perl
Hi.jpg
1.txt
folder/
this.file_is.here.png
another_folder.ok/
```

I would like to add prefix "PRE_"  

```perl
PRE_Hi.jpg
PRE_1.txt
PRE_folder/
PRE_this.file_is.here.png
PRE_another_folder.ok/
```

Regards,  

#### Answer 2 (score 192)
Thanks to <a href="https://stackoverflow.com/users/31799/peter-van-der-heijden">Peter van der Heijden</a>, here's one that'll work for filenames with spaces in them:  

```perl
for f in * ; do mv -- "$f" "PRE_$f" ; done
```

<em>("--" is needed to succeed with files that begin with dashes, whose names would otherwise be interpreted as switches for the mv command)</em>  

#### Answer 3 (score 76)
Use <a href="http://training.perl.com/scripts/rename">the <em>rename</em> script</a> this way:  

```perl
$ rename 's/^/PRE_/' *
```

There are no problems with metacharacters or whitespace in filenames.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: How can I extract substrings from a string in Perl? (score [98783](https://stackoverflow.com/q/1444009) in 2009)

#### Question
Consider the following strings:  

1) Scheme ID: <strong>abc-456-hu5t10</strong> (<strong>High priority</strong>) *****  

2) Scheme ID: <strong>frt-78f-hj542w</strong> (<strong>Balanced</strong>)  

3) Scheme ID: <strong>23f-f974-nm54w</strong> (<strong>super formula run</strong>) *****  

and so on in the above format - the parts in bold are changes across the strings.  

<p>==> <em>Imagine I've many strings of format Shown above.</em>
     I want to pick 3 substrings (As shown in BOLD below) from the each of the above strings.</p>

<ul>
<li>1st substring containing the alphanumeric value (in eg above it's "abc-456-hu5t10")</li>
<li>2nd substring containing the word (in eg above it's "High priority")</li>
<li>3rd substring containing * (`IF` * is present at the end of the string `ELSE` leave it )</li>
</ul>

How do I pick these 3 substrings from each string shown above? I know it can be done using regular expressions in Perl... Can you help with this?  

#### Answer accepted (score 32)
You could do something like this:  

```perl
my $data = <<END;
1) Scheme ID: abc-456-hu5t10 (High priority) *
2) Scheme ID: frt-78f-hj542w (Balanced)
3) Scheme ID: 23f-f974-nm54w (super formula run) *
END

foreach (split(/\n/,$data)) {
  $_ =~ /Scheme ID: ([a-z0-9-]+)\s+\(([^)]+)\)\s*(\*)?/ || next;
  my ($id,$word,$star) = ($1,$2,$3);
  print "$id $word $star\n";
}
```

The key thing is the Regular expression:  

```perl
Scheme ID: ([a-z0-9-]+)\s+\(([^)]+)\)\s*(\*)?
```

Which breaks up as follows.  

The fixed String "Scheme ID: ":  

```perl
Scheme ID: 
```

Followed by one or more of the characters a-z, 0-9 or -.  We use the brackets to capture it as $1:  

```perl
([a-z0-9-]+)
```

Followed by one or more whitespace characters:  

```perl
\s+
```

Followed by an opening bracket (which we escape) followed by any number of characters which aren't a close bracket, and then a closing bracket (escaped).  We use unescaped brackets to capture the words as $2:  

```perl
\(([^)]+)\)
```

Followed by some spaces any maybe a *, captured as $3:  

```perl
\s*(\*)?
```

#### Answer 2 (score 4)
You could use a regular expression such as the following:  

```perl
/([-a-z0-9]+)\s*\((.*?)\)\s*(\*)?/
```

So for example:  

```perl
$s = "abc-456-hu5t10 (High priority) *";
$s =~ /([-a-z0-9]+)\s*\((.*?)\)\s*(\*)?/;
print "$1\n$2\n$3\n";
```

prints  

<pre>abc-456-hu5t10
High priority
*
</pre>

#### Answer 3 (score 3)
```perl
(\S*)\s*\((.*?)\)\s*(\*?)


(\S*)    picks up anything which is NOT whitespace
\s*      0 or more whitespace characters
\(       a literal open parenthesis
(.*?)    anything, non-greedy so stops on first occurrence of...
\)       a literal close parenthesis
\s*      0 or more whitespace characters
(\*?)    0 or 1 occurances of literal *
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Why does modern Perl avoid UTF-8 by default? (score [97673](https://stackoverflow.com/q/6162484) in 2018)

#### Question
I wonder why most modern solutions built using Perl don't enable <a href="http://en.wikipedia.org/wiki/UTF-8" rel="noreferrer">UTF-8</a> by default.  

I understand there are many legacy problems for core Perl scripts, where it may break things. But, from my point of view, in the 21<sup>st</sup> century, big new projects (or projects with a big perspective) should make their software UTF-8 proof from scratch. Still I don't see it happening. For example, <a href="http://en.wikipedia.org/wiki/Moose_%28Perl%29" rel="noreferrer">Moose</a> enables strict and warnings, but not <a href="http://en.wikipedia.org/wiki/Unicode" rel="noreferrer">Unicode</a>. <a href="http://search.cpan.org/~chromatic/Modern-Perl-1.03/lib/Modern/Perl.pm" rel="noreferrer">Modern::Perl</a> reduces boilerplate too, but no UTF-8 handling.  

Why? Are there some reasons to avoid UTF-8 in modern Perl projects in the year 2011?  

<hr>

Commenting @tchrist got too long, so I'm adding it here.  

It seems that I did not make myself clear. Let me try to add some things.  

<strong>tchrist</strong> and I see situation pretty similarly, but our conclusions are completely in opposite ends. I agree, the situation with Unicode is complicated, but this is why we (Perl users and coders) need some layer (or pragma) which makes UTF-8 handling as easy as it must be nowadays.  

<strong>tchrist</strong> pointed to many aspects to cover, I will read and think about them for days or even weeks. Still, this is not my point. <strong>tchrist</strong> tries to prove that there is not one single way "to enable UTF-8". I have not so much knowledge to argue with that. So, I stick to live examples.  

I played around with <a href="http://en.wikipedia.org/wiki/Rakudo_Perl" rel="noreferrer">Rakudo</a> and UTF-8 was just there <strong>as I needed</strong>. I didn't have any problems, it just worked. Maybe there are some limitation somewhere deeper, but at start, all I tested worked as I expected.  

Shouldn't that be a goal in modern Perl&nbsp;5 too? I stress it more: I'm not suggesting UTF-8 as the default character set for core Perl, I suggest the possibility to trigger it <strong>with a snap</strong> for those who develop <strong>new</strong> projects.  

Another example, but with a more negative tone. Frameworks should make development easier. Some years ago, I tried web frameworks, but just threw them away because "enabling UTF-8" was so obscure. I did not find how and where to hook Unicode support. It was so time-consuming that I found it easier to go the old way. Now I saw here there was a bounty to deal with the same problem with <a href="http://en.wikipedia.org/wiki/Mason_%28Perl%29" rel="noreferrer">Mason</a> 2: <em><a href="https://stackoverflow.com/questions/5858596/how-to-make-mason2-utf8-clean">How to make Mason2 UTF-8 clean?</a></em>. So, it is pretty new framework, but using it with UTF-8 needs deep knowledge of its internals. It is like a big red sign: STOP, don't use me!  

I really like Perl. But dealing with Unicode is painful. I still find myself running against walls. Some way <strong>tchrist</strong> is right and answers my questions: new projects don't attract UTF-8 because it is too complicated in Perl&nbsp;5.  

#### Answer accepted (score 1134)
<hr>

<h5> 🌴 🐪🐫🐪🐫🐪 🌞 <em>𝕲𝖔  𝕿𝖍𝖔𝖚  𝖆𝖓𝖉  𝕯𝖔  𝕷𝖎𝖐𝖊𝖜𝖎𝖘𝖊</em> 🌞 🐪🐫🐪 🐁</h1>

<hr>

<h5>𝓔𝓭𝓲𝓽 :  𝙎𝙞𝙢𝙥𝙡𝙚𝙨𝙩 <em>℞</em>:   𝟕 𝘿𝙞𝙨𝙘𝙧𝙚𝙩𝙚  𝙍𝙚𝙘𝙤𝙢𝙢𝙚𝙣𝙙𝙖𝙩𝙞𝙤𝙣𝙨</h2>

<ol>
<li><p>Set your `PERL_UNICODE` envariable to `AS`. This makes all Perl scripts decode `@ARGV` as UTF‑8 strings, and sets the encoding of all three of stdin, stdout, and stderr to UTF‑8. Both these are global effects, not lexical ones.</p></li>
<li><p>At the top of your source file (program, module, library, `do`hickey), prominently assert that you are running perl version 5.12 or better via:</p>

```perl
use v5.12;  # minimal for unicode string feature
use v5.14;  # optimal for unicode string feature
```</li>
<li><p>Enable warnings, since the previous declaration only enables strictures and features, not warnings. I also suggest promoting Unicode warnings into exceptions, so use both these lines, not just one of them.  Note however that under v5.14, the `utf8` warning class comprises three other subwarnings which can all be separately enabled: `nonchar`, `surrogate`, and `non_unicode`. These you may wish to exert greater control over.</p>

```perl
use warnings;
use warnings qw( FATAL utf8 );
```</li>
<li><p>Declare that this source unit is encoded as UTF‑8. Although once upon a time this pragma did other things, it now serves this one singular purpose alone and no other:</p>

```perl
use utf8;
```</li>
<li><p>Declare that anything that opens a filehandle <em>within this lexical scope but not elsewhere</em> is to assume that that stream is encoded in UTF‑8 unless you tell it otherwise. That way you do not affect other module’s or other program’s code.</p>

```perl
use open qw( :encoding(UTF-8) :std );
```</li>
<li><p>Enable named characters via `\N{CHARNAME}`.</p>

```perl
use charnames qw( :full :short );
```</li>
<li><p>If you have a `DATA` handle, you must explicitly set its encoding. If you want this to be UTF‑8, then say:</p>

```perl
binmode(DATA, ":encoding(UTF-8)");
```</li>
</ol>

There is of course no end of other matters with which you may eventually find yourself concerned, but these will suffice to approximate the state goal to “make everything just work with UTF‑8”, albeit for a somewhat weakened sense of those terms.   

One other pragma, although it is not Unicode related, is:  

```perl
      use autodie;
```

It is strongly recommended.  

<hr>

<h5>                     🎅      𝕹 𝖔   𝕸 𝖆 𝖌 𝖎 𝖈   𝕭 𝖚 𝖑 𝖑 𝖊 𝖙    🎅</h1>

<hr>

Saying that “Perl should [<strong>somehow!</strong>] enable Unicode by default” doesn’t even start to begin to think about getting around to saying enough to be even marginally useful in some sort of rare and isolated case.  Unicode is much much more than just a larger character repertoire; it’s also how those characters all interact in many, many ways.  

Even the simple-minded minimal measures that (some) people seem to think they want are guaranteed to miserably break millions of lines of code, code that has no chance to “upgrade” to your spiffy new <em>Brave New World</em> modernity.   

It is way way way more complicated than people pretend.  I’ve thought about this a huge, whole lot over the past few years.  I would love to be shown that I am wrong.  But I don’t think I am.  Unicode is fundamentally more complex than the model that you would like to impose on it, and there is complexity here that you can never sweep under the carpet. If you try, you’ll break either your own code or somebody else’s.  At some point, you simply have to break down and learn what Unicode is about.  You cannot pretend it is something it is not.   

🐪  goes out of its way to make Unicode easy, far more than anything else I’ve ever used. If you think this is bad, try something else for a while. Then come back to 🐪: either you will have returned to a better world, or else you will bring knowledge of the same with you so that we can make use of your new knowledge to make 🐪  better at these things.  

<hr>

<h5>         💡     𝕴𝖉𝖊𝖆𝖘       𝖋𝖔𝖗    𝖆       𝖀𝖓𝖎𝖈𝖔𝖉𝖊 ⸗ 𝕬𝖜𝖆𝖗𝖊    🐪    𝕷𝖆𝖚𝖓𝖉𝖗𝖞    𝕷𝖎𝖘𝖙      💡</h2>

<hr>

At a minimum, here  are some things that would appear to be required for 🐪 to “enable Unicode by default”, as you put it:  

<ol>
<li><p>All 🐪  source code should be in UTF-8 by default.  You can get that with `use utf8` or `export PERL5OPTS=-Mutf8`.</p></li>
<li><p>The 🐪  `DATA` handle should be UTF-8. You will have to do this on a per-package basis, as in `binmode(DATA, ":encoding(UTF-8)")`.</p></li>
<li><p>Program arguments to 🐪  scripts should be understood to be UTF-8 by default.  `export PERL_UNICODE=A`, or `perl -CA`, or `export PERL5OPTS=-CA`.</p></li>
<li><p>The standard input, output, and error streams should default to UTF-8. `export PERL_UNICODE=S` for all of them, or `I`, `O`, and/or `E` for just some of them. This is like `perl -CS`.</p></li>
<li><p>Any other handles opened by 🐪 should be considered UTF-8 unless declared otherwise; `export PERL_UNICODE=D` or with `i` and `o` for particular ones of these; `export PERL5OPTS=-CD` would work.  That makes `-CSAD` for all of them.</p></li>
<li><p>Cover both bases plus all the streams you open with `export PERL5OPTS=-Mopen=:utf8,:std`. See <a href="http://training.perl.com/scripts/uniquote" rel="noreferrer"><em>uniquote</em></a>.</p></li>
<li><p>You don’t want to miss UTF-8 encoding errors. Try `export PERL5OPTS=-Mwarnings=FATAL,utf8`.  And make sure your input streams are always `binmode`d to `:encoding(UTF-8)`, not just to `:utf8`.</p></li>
<li><p>Code points between 128–255 should be understood by 🐪 to be the corresponding Unicode code points, not just unpropertied binary values.  `use feature "unicode_strings"` or `export PERL5OPTS=-Mfeature=unicode_strings`.  That will make `uc("\xDF") eq "SS"` and `"\xE9" =~ /\w/`.  A simple `export PERL5OPTS=-Mv5.12` or better will also get that.</p></li>
<li><p>Named Unicode characters are not by default enabled, so add `export PERL5OPTS=-Mcharnames=:full,:short,latin,greek` or some such. See <a href="http://training.perl.com/scripts/uninames" rel="noreferrer"><em>uninames</em></a> and <a href="http://training.perl.com/scripts/tcgrep" rel="noreferrer">tcgrep</a>.</p></li>
<li><p>You almost always need access to the functions from <a href="http://search.cpan.org/perldoc?Unicode::Normalize" rel="noreferrer">the standard `Unicode::Normalize` module</a> various types of decompositions.  `export PERL5OPTS=-MUnicode::Normalize=NFD,NFKD,NFC,NFKD`, and then always run incoming stuff through NFD and outbound stuff from NFC. There’s no I/O layer for these yet that I’m aware of, but see <a href="http://training.perl.com/scripts/nfc" rel="noreferrer"><em>nfc</em></a>, <a href="http://training.perl.com/scripts/nfd" rel="noreferrer"><em>nfd</em></a>, <a href="http://training.perl.com/scripts/nfkd" rel="noreferrer"><em>nfkd</em></a>, and <a href="http://training.perl.com/scripts/nfkc" rel="noreferrer"><em>nfkc</em></a>.</p></li>
<li><p>String comparisons in 🐪 using `eq`, `ne`, `lc`, `cmp`, `sort`, &amp;c&amp;cc are always wrong.  So instead of `@a = sort @b`, you need `@a = Unicode::Collate-&gt;new-&gt;sort(@b)`.  Might as well add that to your `export PERL5OPTS=-MUnicode::Collate`. You can cache the key for binary comparisons.</p></li>
<li><p>🐪 built-ins like `printf` and `write` do the wrong thing with Unicode data.  You need to use <a href="http://search.cpan.org/perldoc?Unicode::GCString" rel="noreferrer">the `Unicode::GCString` module</a> for the former, and both that and also <a href="http://search.cpan.org/perldoc?Unicode::LineBreak" rel="noreferrer">the `Unicode::LineBreak` module</a> as well for the latter. See <a href="http://training.perl.com/scripts/uwc" rel="noreferrer"><em>uwc</em></a> and <a href="http://training.perl.com/scripts/ucsort" rel="noreferrer"><em>unifmt</em></a>.</p></li>
<li><p>If you want them to count as integers, then you are going to have to run your `\d+` captures through <a href="http://search.cpan.org/~jesse/perl-5.14.0/lib/Unicode/UCD.pm#num" rel="noreferrer">the `Unicode::UCD::num` function</a> because 🐪’s built-in <em>atoi</em>(3) isn’t currently clever enough.</p></li>
<li><p>You are going to have filesystem issues on 👽 filesystems. Some filesystems silently enforce a conversion to NFC; others silently enforce a conversion to NFD. And others do something else still. Some even ignore the matter altogether, which leads to even greater problems. So you have to do your own NFC/NFD handling to keep sane.</p></li>
<li><p>All your 🐪  code involving `a-z` or `A-Z` and such <strong>MUST BE CHANGED</strong>, including `m//`, `s///`, and `tr///`. It’s should stand out as a screaming red flag that your code is broken. But it is not clear how it must change. Getting the right properties, and understanding their casefolds, is harder than you might think. I use <a href="http://training.perl.com/scripts/unichars" rel="noreferrer"><em>unichars</em></a> and <a href="http://training.perl.com/scripts/uniprops" rel="noreferrer"><em>uniprops</em></a> every single day.</p></li>
<li><p>Code that uses `\p{Lu}` is almost as wrong as code that uses `[A-Za-z]`.  You need to use `\p{Upper}` instead, and know the reason why. Yes, `\p{Lowercase}` and `\p{Lower}` are different from `\p{Ll}` and `\p{Lowercase_Letter}`.</p></li>
<li><p>Code that uses `[a-zA-Z]` is even worse.  And it can’t use `\pL` or `\p{Letter}`; it needs to use `\p{Alphabetic}`. Not all alphabetics are letters, you know!</p></li>
<li><p>If you are looking for 🐪 variables with `/[\$\@\%]\w+/`, then you have a problem.  You need to look for `/[\$\@\%]\p{IDS}\p{IDC}*/`, and even that isn’t thinking about the punctuation variables or package variables.</p></li>
<li><p>If you are checking for whitespace, then you should choose between `\h` and `\v`, depending.  And you should never use `\s`, since it <strong>DOES NOT MEAN</strong> `[\h\v]`, contrary to popular belief.</p></li>
<li><p>If you are using `\n` for a line boundary, or even `\r\n`, then you are doing it wrong.  You have to use `\R`, which is not the same!</p></li>
<li><p>If you don’t know when and whether to call <a href="http://search.cpan.org/perldoc?Unicode::Stringprep" rel="noreferrer">Unicode::Stringprep</a>, then you had better learn.</p></li>
<li><p>Case-insensitive comparisons need to check for whether two things are the same letters no matter their diacritics and such.  The easiest way to do that is with the <a href="http://search.cpan.org/perldoc?Unicode::Collate" rel="noreferrer">standard Unicode::Collate</a> module. `Unicode::Collate-&gt;new(level =&gt; 1)-&gt;cmp($a, $b)`.  There are also `eq` methods and such, and you should probably learn about the `match` and `substr` methods, too. These are have distinct advantages over the 🐪  built-ins.</p></li>
<li><p>Sometimes that’s still not enough, and you need <a href="http://search.cpan.org/perldoc?Unicode::Collate::Locale" rel="noreferrer">the Unicode::Collate::Locale</a> module instead, as in  `Unicode::Collate::Locale-&gt;new(locale =&gt; "de__phonebook", level =&gt; 1)-&gt;cmp($a, $b)` instead.   Consider that `Unicode::Collate::-&gt;new(level =&gt; 1)-&gt;eq("d", "ð")` is true, but `Unicode::Collate::Locale-&gt;new(locale=&gt;"is",level =&gt; 1)-&gt;eq("d", " ð")` is false. Similarly, "ae" and "æ" are `eq` if you don’t use locales, or if you use the English one, but they are different in the Icelandic locale.  Now what? It’s tough, I tell you.  You can play with  <a href="http://training.perl.com/scripts/ucsort" rel="noreferrer"><em>ucsort</em></a> to test some of these things out.</p></li>
<li><p>Consider how to match the pattern CVCV (consonsant, vowel, consonant, vowel)  in the string “<em>niño</em>”.  Its NFD form — which you had darned well better have remembered to put it in — becomes “nin\x{303}o”.  Now what are you going to do?  Even pretending that a vowel is `[aeiou]` (which is wrong, by the way), you won’t be able to do something like `(?=[aeiou])\X)` either, because even in NFD a code point like ‘ø’ <strong>does not decompose</strong>!  However, it will test equal to an ‘o’ using the UCA comparison I just showed you. You can’t rely on NFD, you have to rely on UCA. </p></li>
</ol>

<hr>

<h5>                💩          𝔸 𝕤 𝕤 𝕦 𝕞 𝕖   𝔹 𝕣 𝕠 𝕜 𝕖 𝕟 𝕟 𝕖 𝕤 𝕤           💩</h2>

<hr>

And that’s not all. There are million broken assumptions that people make about Unicode. Until they understand these things, their  🐪 code will be broken.  

<ol>
<li><p>Code that assumes it can open a text file without specifying the encoding is broken.</p></li>
<li><p>Code that assumes the default encoding is some sort of native platform encoding is broken.</p></li>
<li><p>Code that assumes that web pages in Japanese or Chinese take up less space in UTF‑16 than in UTF‑8 is wrong.</p></li>
<li><p>Code that assumes Perl uses UTF‑8 internally is wrong.</p></li>
<li><p>Code that assumes that encoding errors will always raise an exception is wrong.</p></li>
<li><p>Code that assumes Perl code points are limited to 0x10_FFFF is wrong.</p></li>
<li><p>Code that assumes you can set `$/` to something that will work with any valid line separator is wrong.</p></li>
<li><p>Code that assumes roundtrip equality on casefolding, like `lc(uc($s)) eq $s` or `uc(lc($s)) eq $s`, is completely broken and wrong.  Consider that the `uc("σ")` and `uc("ς")`  are both `"Σ"`, but `lc("Σ")` cannot possibly return both of those.</p></li>
<li><p>Code that assumes every lowercase code point has a distinct uppercase one, or vice versa, is broken. For example, `"ª"` is a lowercase letter with no uppercase; whereas both `"ᵃ"` and `"ᴬ"` are letters, but they are not lowercase letters; however, they are both lowercase code points without corresponding uppercase versions. Got that? They are <strong>not</strong> `\p{Lowercase_Letter}`, despite being both `\p{Letter}` and `\p{Lowercase}`.</p></li>
<li><p>Code that assumes changing the case doesn’t change the length of the string is broken.</p></li>
<li><p>Code that assumes there are only two cases is broken. There’s also titlecase.</p></li>
<li><p>Code that assumes only letters have case is broken. Beyond just letters, it turns out that numbers, symbols, and even marks have case. In fact, changing the case can even make something change its main general category, like a `\p{Mark}` turning into a `\p{Letter}`. It can also make it switch from one script to another.</p></li>
<li><p>Code that assumes that case is never locale-dependent is broken.</p></li>
<li><p>Code that assumes Unicode gives a fig about POSIX locales is broken.</p></li>
<li><p>Code that assumes you can remove diacritics to get at base ASCII letters is evil, still, broken, brain-damaged, wrong, and justification for capital punishment.</p></li>
<li><p>Code that assumes that diacritics `\p{Diacritic}` and marks `\p{Mark}` are the same thing is broken.</p></li>
<li><p>Code that assumes `\p{GC=Dash_Punctuation}` covers as much as `\p{Dash}` is broken.</p></li>
<li><p>Code that assumes dash, hyphens, and minuses are the same thing as each other, or that there is only one of each, is broken and wrong.</p></li>
<li><p>Code that assumes every code point takes up no more than one print column is broken.</p></li>
<li><p>Code that assumes that all `\p{Mark}` characters take up zero print columns is broken.</p></li>
<li><p>Code that assumes that characters which look alike <em>are</em> alike is broken.</p></li>
<li><p>Code that assumes that characters which do <em>not</em> look alike are <em>not</em> alike is broken.</p></li>
<li><p>Code that assumes there is a limit to the number of code points in a row that just one `\X` can match is wrong.</p></li>
<li><p>Code that assumes `\X` can never start with a `\p{Mark}` character is wrong.</p></li>
<li><p>Code that assumes that `\X` can never hold two non-`\p{Mark}` characters is wrong.</p></li>
<li><p>Code that assumes that it cannot use `"\x{FFFF}"` is wrong.</p></li>
<li><p>Code that assumes a non-BMP code point that requires two UTF-16 (surrogate) code units will encode to two separate UTF-8 characters, one per code unit, is wrong. It doesn’t: it encodes to single code point.</p></li>
<li><p>Code that transcodes from UTF‐16 or UTF‐32 with leading BOMs into UTF‐8 is broken if it puts a BOM at the start of the resulting UTF-8.  This is so stupid the engineer should have their eyelids removed.</p></li>
<li><p>Code that assumes the CESU-8 is a valid UTF encoding is wrong. Likewise, code that thinks encoding U+0000 as `"\xC0\x80"` is UTF-8 is broken and wrong. These guys also deserve the eyelid treatment.</p></li>
<li><p>Code that assumes characters like `&gt;` always points to the right and `&lt;` always points to the left are wrong — because they in fact do not.</p></li>
<li><p>Code that assumes if you first output character `X` and then character `Y`, that those will show up as `XY` is wrong. Sometimes they don’t.</p></li>
<li><p><strong>Code that assumes that ASCII is good enough for writing English properly is stupid, shortsighted, illiterate, broken, evil, and wrong.</strong>  Off with their heads! If that seems too extreme, we can compromise: henceforth they may type only with their big toe from one foot (the rest still be ducktaped).</p></li>
<li><p>Code that assumes that all `\p{Math}` code points are visible characters is wrong.</p></li>
<li><p>Code that assumes `\w` contains only letters, digits, and underscores is wrong.</p></li>
<li><p>Code that assumes that `^` and `~` are punctuation marks is wrong.</p></li>
<li><p>Code that assumes that `ü` has an umlaut is wrong.</p></li>
<li><p>Code that believes things like `₨` contain any letters in them is wrong.</p></li>
<li><p>Code that believes `\p{InLatin}` is the same as `\p{Latin}` is  heinously broken. </p></li>
<li><p>Code that believe that `\p{InLatin}` is almost ever useful is almost certainly wrong.</p></li>
<li><p>Code that believes that given `$FIRST_LETTER` as the first letter in some alphabet and `$LAST_LETTER` as the last letter in that same alphabet, that `[${FIRST_LETTER}-${LAST_LETTER}]` has any meaning whatsoever is almost always complete broken and wrong and meaningless.</p></li>
<li><p>Code that believes someone’s name can only contain certain characters is stupid, offensive, and wrong.</p></li>
<li><p>Code that tries to reduce Unicode to ASCII is not merely wrong, its perpetrator should never be allowed to work in programming again. Period. I’m not even positive they should even be allowed to see again, since it obviously hasn’t done them much good so far.</p></li>
<li><p>Code that believes there’s some way to pretend textfile encodings don’t exist is broken and dangerous. Might as well poke the other eye out, too.</p></li>
<li><p>Code that converts unknown characters to `?` is broken, stupid, braindead, and runs contrary to the standard recommendation, which says <strong>NOT TO DO THAT!</strong> RTFM for why not.</p></li>
<li><p>Code that believes it can reliably guess the encoding of an unmarked textfile is guilty of a fatal mélange of hubris and naïveté that only a lightning bolt from  Zeus will fix.</p></li>
<li><p>Code that believes you can use 🐪 `printf` widths to pad and justify Unicode data is broken and wrong.</p></li>
<li><p>Code that believes once you successfully create a file by a given name, that when you run `ls` or `readdir` on its enclosing directory, you’ll actually find that file with the name you created it under is buggy, broken, and wrong. Stop being surprised by this!</p></li>
<li><p>Code that believes UTF-16 is a fixed-width encoding is stupid, broken, and wrong. Revoke their programming licence.</p></li>
<li><p>Code that treats code points from one plane one whit differently than those from any other plane is <em>ipso facto</em> broken and wrong. Go back to school.</p></li>
<li><p>Code that believes that stuff like `/s/i` can only match `"S"` or `"s"` is broken and wrong.  You’d be surprised.</p></li>
<li><p>Code that uses `\PM\pM*` to find grapheme clusters instead of using `\X` is broken and wrong.</p></li>
<li><p>People who want to go back to the ASCII world should be whole-heartedly encouraged to do so, and in honor of their glorious upgrade they should be provided <em>gratis</em> with a pre-electric manual typewriter for all their data-entry needs.  Messages sent to them should be send via an ᴀʟʟᴄᴀᴘs telegraph at 40 characters per line and hand-delivered by a courier.  STOP.</p></li>
</ol>

<hr>

<h5>        🎁   🐪       𝕭𝖔𝖎𝖑𝖊𝖗⸗𝖕𝖑𝖆𝖙𝖊  𝖋𝖔𝖗   𝖀𝖓𝖎𝖈𝖔𝖉𝖊⸗𝕬𝖜𝖆𝖗𝖊    𝕮𝖔𝖉𝖊        🐪    🎁</h2>

<hr>

My own boilerplate these days tends to look like this:  

```perl
use 5.014;

use utf8;
use strict;
use autodie;
use warnings; 
use warnings    qw< FATAL  utf8     >;
use open        qw< :std  :utf8     >;
use charnames   qw< :full >;
use feature     qw< unicode_strings >;

use File::Basename      qw< basename >;
use Carp                qw< carp croak confess cluck >;
use Encode              qw< encode decode >;
use Unicode::Normalize  qw< NFD NFC >;

END { close STDOUT }

if (grep /\P{ASCII}/ => @ARGV) { 
   @ARGV = map { decode("UTF-8", $_) } @ARGV;
}

$0 = basename($0);  # shorter messages
$| = 1;

binmode(DATA, ":utf8");

# give a full stack dump on any untrapped exceptions
local $SIG{__DIE__} = sub {
    confess "Uncaught exception: @_" unless $^S;
};

# now promote run-time warnings into stackdumped exceptions
#   *unless* we're in an try block, in which 
#   case just generate a clucking stackdump instead
local $SIG{__WARN__} = sub {
    if ($^S) { cluck   "Trapped warning: @_" } 
    else     { confess "Deadly warning: @_"  }
};

while (<>)  {
    chomp;
    $_ = NFD($_);
    ...
} continue {
    say NFC($_);
}

__END__
```

<hr>

<h5>                        😱      𝕾 𝖀 𝕸 𝕸 𝕬 𝕽 𝖄     😱</h1>

<hr>

I don’t know how much more “default Unicode in 🐪” you can get than what I’ve written. Well, yes I do: you should be using `Unicode::Collate` and `Unicode::LineBreak`, too.  And probably more.  

As you see, there are far too many Unicode things that you really <em>do</em> have to worry about for there to <em>ever</em> exist any such thing as “default to Unicode”.  

What you’re going to discover, just as we did back in 🐪 5.8, that it is simply impossible to impose all these things on code that hasn’t been designed right from the beginning to account for them. Your well-meaning selfishness just broke the entire world.  

And even once you do, there are still critical issues that require a great deal of thought to get right.  There is no switch you can flip.  Nothing but brain, and I mean <em>real brain</em>, will suffice here. There’s a heck of a lot of stuff you have to learn. Modulo the retreat to the manual typewriter, you simply cannot hope to sneak by in ignorance. This is the 21ˢᵗ century, and you cannot wish Unicode away by willful ignorance.   

You have to learn it. Period. It will never be so easy that “everything just works”, because that will guarantee that a lot of things <strong>don’t</strong> work — which invalidates the assumption that there can ever be a way to “make it all work”.   

You may be able to get a few reasonable defaults for a very few and very limited operations, but not without thinking about things a whole lot more than I think you have.  

As just one example, canonical ordering is going to cause some real headaches. 😭`"\x{F5}"` <strong>‘õ’</strong>, `"o\x{303}"` <strong>‘õ’</strong>, `"o\x{303}\x{304}"` <strong>‘ȭ’</strong>, and `"o\x{304}\x{303}"` <strong>‘ō̃’</strong> should all match <strong>‘õ’</strong>, but how in the world are you going to do that? This is harder than it looks, but it’s something you need to account for.  💣   

If there’s one thing I know about Perl, it is what its Unicode bits do and do not do, and this thing I promise you:  <strong>“   ̲ᴛ̲ʜ̲ᴇ̲ʀ̲ᴇ̲ ̲ɪ̲s̲ ̲ɴ̲ᴏ̲ ̲U̲ɴ̲ɪ̲ᴄ̲ᴏ̲ᴅ̲ᴇ̲ ̲ᴍ̲ᴀ̲ɢ̲ɪ̲ᴄ̲ ̲ʙ̲ᴜ̲ʟ̲ʟ̲ᴇ̲ᴛ̲ ̲  ”</strong>  😞   

You cannot just change some defaults and get smooth sailing.  It’s true that I run 🐪 with `PERL_UNICODE` set to `"SA"`, but that’s all, and even that is mostly for command-line stuff.  For real work, I go through all the many steps outlined above, and I do it very, ** very** carefully.  

<hr>

<h5>  😈 ¡ƨdləɥ ƨᴉɥʇ ədoɥ puɐ ʻλɐp əɔᴉu ɐ əʌɐɥ ʻʞɔnl poo⅁   😈</h1>

#### Answer 2 (score 95)
There are two stages to processing Unicode text. The first is "how can I input it and output it without losing information". The second is "how do I treat text according to local language conventions".  

tchrist's post covers both, but the second part is where 99% of the text in his post comes from. Most programs don't even handle I/O correctly, so it's important to understand that before you even begin to worry about normalization and collation.  

This post aims to solve that first problem  

When you read data into Perl, it doesn't care what encoding it is. It allocates some memory and stashes the bytes away there. If you say `print $str`, it just blits those bytes out to your terminal, which is probably set to assume everything that is written to it is UTF-8, and your text shows up.  

Marvelous.  

Except, it's not. If you try to treat the data as text, you'll see that Something Bad is happening. You need go no further than `length` to see that what Perl thinks about your string and what you think about your string disagree. Write a one-liner like: `perl -E 'while(&lt;&gt;){ chomp; say length }'` and type in `文字化け` and you get 12... not the correct answer, 4.  

That's because Perl assumes your string is not text. You have to tell it that it's text before it will give you the right answer.  

That's easy enough; the Encode module has the functions to do that. The generic entry point is `Encode::decode` (or `use Encode qw(decode)`, of course). That function takes some string from the outside world (what we'll call "octets", a fancy of way of saying "8-bit bytes"), and turns it into some text that Perl will understand. The first argument is a character encoding name, like "UTF-8" or "ASCII" or "EUC-JP". The second argument is the string. The return value is the Perl scalar containing the text.  

(There is also `Encode::decode_utf8`, which assumes UTF-8 for the encoding.)  

If we rewrite our one-liner:  

```perl
perl -MEncode=decode -E 'while(<>){ chomp; say length decode("UTF-8", $_) }'
```

We type in 文字化け and get "4" as the result. Success.  

That, right there, is the solution to 99% of Unicode problems in Perl.  

The key is, whenever any text comes into your program, you must decode it. The Internet cannot transmit characters. Files cannot store characters. There are no characters in your database. There are only octets, and you can't treat octets as characters in Perl. You must decode the encoded octets into Perl characters with the Encode module.  

The other half of the problem is getting data out of your program. That's easy to; you just say `use Encode qw(encode)`, decide what the encoding your data will be in (UTF-8 to terminals that understand UTF-8, UTF-16 for files on Windows, etc.), and then output the result of `encode($encoding, $data)` instead of just outputting `$data`.  

This operation converts Perl's characters, which is what your program operates on, to octets that can be used by the outside world. It would be a lot easier if we could just send characters over the Internet or to our terminals, but we can't: octets only. So we have to convert characters to octets, otherwise the results are undefined.  

To summarize: encode all outputs and decode all inputs.  

Now we'll talk about three issues that make this a little challenging. The first is libraries. Do they handle text correctly? The answer is... they try. If you download a web page, LWP will give you your result back as text. If you call the right method on the result, that is (and that happens to be `decoded_content`, not `content`, which is just the octet stream that it got from the server.) Database drivers can be flaky; if you use DBD::SQLite with just Perl, it will work out, but if some other tool has put text stored as some encoding other than UTF-8 in your database... well... it's not going to be handled correctly until you write code to handle it correctly.  

Outputting data is usually easier, but if you see "wide character in print", then you know you're messing up the encoding somewhere. That warning means "hey, you're trying to leak Perl characters to the outside world and that doesn't make any sense". Your program appears to work (because the other end usually handles the raw Perl characters correctly), but it is very broken and could stop working at any moment. Fix it with an explicit `Encode::encode`!  

The second problem is UTF-8 encoded source code. Unless you say `use utf8` at the top of each file, Perl will not assume that your source code is UTF-8. This means that each time you say something like `my $var = 'ほげ'`, you're injecting garbage into your program that will totally break everything horribly. You don't have to "use utf8", but if you don't, you <em>must</em> not use any non-ASCII characters in your program.  

The third problem is how Perl handles The Past. A long time ago, there was no such thing as Unicode, and Perl assumed that everything was Latin-1 text or binary. So when data comes into your program and you start treating it as text, Perl treats each octet as a Latin-1 character. That's why, when we asked for the length of "文字化け", we got 12. Perl assumed that we were operating on the  Latin-1 string "æå­åã" (which is 12 characters, some of which are non-printing).  

This is called an "implicit upgrade", and it's a perfectly reasonable thing to do, but it's not what you want if your text is not Latin-1. That's why it's critical to explicitly decode input: if you don't do it, Perl will, and it might do it wrong.  

People run into trouble where half their data is a proper character string, and some is still binary. Perl will interpret the part that's still binary as though it's Latin-1 text and then combine it with the correct character data. This will make it look like handling your characters correctly broke your program, but in reality, you just haven't fixed it enough.  

Here's an example: you have a program that reads a UTF-8-encoded text file, you tack on a Unicode `PILE OF POO` to each line, and you print it out. You write it like:  

```perl
while(<>){
    chomp;
    say "$_ 💩";
}
```

And then run on some UTF-8 encoded data, like:  

```perl
perl poo.pl input-data.txt
```

It prints the UTF-8 data with a poo at the end of each line. Perfect, my program works!  

But nope, you're just doing binary concatenation. You're reading octets from the file, removing a `\n` with chomp, and then tacking on the bytes in the UTF-8 representation of the `PILE OF POO` character. When you revise your program to decode the data from the file and encode the output, you'll notice that you get garbage ("ð©") instead of the poo. This will lead you to believe that decoding the input file is the wrong thing to do. It's not.  

The problem is that the poo is being implicitly upgraded as latin-1. If you `use utf8` to make the literal text instead of binary, then it will work again!  

(That's the number one problem I see when helping people with Unicode. They did part right and that broke their program. That's what's sad about undefined results: you can have a working program for a long time, but when you start to repair it, it breaks. Don't worry; if you are adding encode/decode statements to your program and it breaks, it just means you have more work to do. Next time, when you design with Unicode in mind from the beginning, it will be much easier!)  

That's really all you need to know about Perl and Unicode. If you tell Perl what your data is, it has the best Unicode support among all popular programming languages. If you assume it will magically know what sort of text you are feeding it, though, then you're going to trash your data irrevocably. Just because your program works today on your UTF-8 terminal doesn't mean it will work tomorrow on a UTF-16 encoded file. So make it safe now, and save yourself the headache of trashing your users' data!  

The easy part of handling Unicode is encoding output and decoding input. The hard part is finding all your input and output, and determining which encoding it is. But that's why you get the big bucks :)  

#### Answer 3 (score 48)
<p>We're all in agreement that it is a difficult problem for many reasons,
but that's precisely the reason to try to make it easier on everybody.</p>

There is a recent module on CPAN, <a href="http://search.cpan.org/perldoc?utf8::all" rel="noreferrer">utf8::all</a>, that attempts to "turn on Unicode. All of it".  

As has been pointed out, you can't magically make the entire system (outside programs, external web requests, etc.) use Unicode as well, but we can work together to make sensible tools that make doing common problems easier.  That's the reason that we're programmers.  

If utf8::all doesn't do something you think it should, let's improve it to make it better. Or let's make additional tools that together can suit people's varying needs as well as possible.  

`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: How can I remove text within parentheses with a regex? (score [97531](https://stackoverflow.com/q/640001) in 2009)

#### Question
I'm trying to handle a bunch of files, and I need to alter then to remove extraneous information in the filenames; notably, I'm trying to remove text inside parentheses. For example:  

```perl
filename = "Example_file_(extra_descriptor).ext"
```

and I want to regex a whole bunch of files where the parenthetical expression might be in the middle or at the end, and of variable length.  

What would the regex look like?  Perl or Python syntax would be preferred.  

#### Answer accepted (score 103)
```perl
s/\([^)]*\)//
```

So in Python, you'd do:  

```perl
re.sub(r'\([^)]*\)', '', filename)
```

#### Answer 2 (score 36)
The pattern that matches substrings in parentheses <em>having no other `(` and `)` characters in between</em> (like `(xyz 123)` in `Text (abc(xyz 123)`) is  

```perl
\([^()]*\)
```

<strong>Details</strong>:  

<ul>
<li>`\(` - an opening round bracket (note that in POSIX BRE, `(` should be used, see `sed` example below)</li>
<li>`[^()]*` - zero or more (due to the `*` <a href="http://www.regular-expressions.info/repeat.html" rel="noreferrer">Kleene star quantifier</a>) characters <em>other than</em> those defined in the <a href="http://www.regular-expressions.info/charclass.html#negated" rel="noreferrer"><em>negated character class</em>/<em>POSIX bracket expression</em></a>, that is, any chars other than `(` and `)`</li>
<li>`\)` - a closing round bracket (no escaping in POSIX BRE allowed)</li>
</ul>

Removing code snippets:  

<ul>
<li><strong>JavaScript</strong>: `string.replace(/\([^()]*\)/g, '')`</li>
<li><strong>PHP</strong>: `preg_replace('~\([^()]*\)~', '', $string)`</li>
<li><strong>Perl</strong>: `$s =~ s/\([^()]*\)//g`</li>
<li><strong>Python</strong>: `re.sub(r'\([^()]*\)', '', s)`</li>
<li><strong>C#</strong>: `Regex.Replace(str, @"\([^()]*\)", string.Empty)`</li>
<li><strong>VB.NET</strong>: `Regex.Replace(str, "\([^()]*\)", "")`</li>
<li><strong>Java</strong>: `s.replaceAll("\\([^()]*\\)", "")`</li>
<li><strong>Ruby</strong>: `s.gsub(/\([^()]*\)/, '')`</li>
<li><strong>R</strong>: `gsub("\\([^()]*\\)", "", x)`</li>
<li><strong>Lua</strong>: `string.gsub(s, "%([^()]*%)", "")`</li>
<li><strong>Bash/sed</strong>: `sed 's/([^()]*)//g'`</li>
<li><strong>Tcl</strong>: `regsub -all {\([^()]*\)} $s "" result`</li>
<li><strong>C++ `std::regex`</strong>: `std::regex_replace(s, std::regex(R"(\([^()]*\))"), "")`</li>
<li><strong>Objective-C</strong>: <br/><code>NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\([^()]*\\)" options:NSRegularExpressionCaseInsensitive error:&amp;error];
NSString *modifiedString = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@""];</code></li>
<li><strong>Swift</strong>: `s.replacingOccurrences(of: "\\([^()]*\\)", with: "", options: [.regularExpression])`</li>
</ul>

#### Answer 3 (score 21)
I would use:  

```perl
\([^)]*\)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: How can I store the result of a system command in a Perl variable? (score [97221](https://stackoverflow.com/q/3854651) in 2013)

#### Question
```perl
$ cat test.pl
my $pid = 5892;
my $not = system("top -H -p $pid -n 1 | grep myprocess | wc -l");
print "not = $not\n";
$ perl test.pl
11
not = 0
$
```

I want to capture the result i.e. `11` into a variable. How can I do that?  

#### Answer accepted (score 50)
From <a href="http://perldoc.perl.org/perlfaq8.html#Why-can&#39;t-I-get-the-output-of-a-command-with-system()%3f" rel="noreferrer">Perlfaq8</a>:  

You're confusing the purpose of <a href="http://p3rl.org/system" rel="noreferrer">system()</a> and <a href="http://p3rl.org/op#qx%2fSTRING%2f" rel="noreferrer">backticks</a> (``). system() runs a command and returns exit status information (as a 16 bit value: the low 7 bits are the signal the process died from, if any, and the high 8 bits are the actual exit value). Backticks (``) run a command and return what it sent to STDOUT.  

```perl
$exit_status   = system("mail-users");
    $output_string = `ls`;
```

There are many ways to execute external commands from Perl. The most commons with their meanings are:  

<ul>
<li><strong><a href="http://perldoc.perl.org/functions/system.html" rel="noreferrer">system()</a></strong> : you want to execute a command and don't want to capture its output</li>
<li><strong><a href="http://perldoc.perl.org/functions/exec.html" rel="noreferrer">exec</a></strong>: you don't want to return to the
calling perl script</li>
<li><strong><a href="http://perldoc.perl.org/perlop.html#qx%2fSTRING%2f" rel="noreferrer">backticks</a></strong> : you want to capture the
output of the command</li>
<li><strong><a href="http://perldoc.perl.org/functions/open.html" rel="noreferrer">open</a>:</strong> you want to pipe the command (as
input or output) to your script</li>
</ul>

Also see <a href="http://perldoc.perl.org/perlfaq8.html#How-can-I-capture-STDERR-from-an-external-command%3f" rel="noreferrer">How can I capture STDERR from an external command?</a>  

#### Answer 2 (score 11)
The easiest way is to use the ```` feature in Perl. This will execute what is inside and return what was printed to stdout:  

```perl
 my $pid = 5892;
 my $var = `top -H -p $pid -n 1 | grep myprocess | wc -l`;
 print "not = $var\n";
```

This should do it.  

#### Answer 3 (score 7)
Try using `qx{command}` rather than backticks. To me, it's a bit better because: you can do SQL with it and not worry about escaping quotes and such. Depending on the editor and screen, my old eyes tend to miss the tiny back ticks, and it shouldn't ever have an issue with being overloaded like using angle brackets versus glob.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: How can I compile my Perl script so it can be executed on systems without perl installed? (score [96840](https://stackoverflow.com/q/1237286) in 2009)

#### Question
I have a `.pl` file and I want to execute that file in any system even though `perl` is not installed. How can i achieve it?  

Can any one let me know with some good examples to do that?   

#### Answer 2 (score 43)
<a href="http://search.cpan.org/perldoc/pp" rel="noreferrer">pp</a> can create an executable that includes perl and your script (and any module dependencies), but it will be specific to your architecture, so you couldn't run it on both Windows and linux for instance.  

From its doc:  

<blockquote>
  To make a stand-alone executable, suitable for running on a machine that doesn't have perl installed:  

```perl
   % pp -o packed.exe source.pl        # makes packed.exe
   # Now, deploy 'packed.exe' to target machine...
   $ packed.exe                        # run it
```
</blockquote>

(% and $ there are command prompts on different machines).  

#### Answer 3 (score 29)
<ol>
<li><p>Install <a href="http://search.cpan.org/perldoc?PAR::Packer" rel="noreferrer">`PAR::Packer`</a>. Example for *nix:</p>

<pre>sudo cpan -i PAR::Packer</pre>

For Strawberry Perl for Windows or for ActivePerl and MSVC installed:  

<pre>cpan -i PAR::Packer</pre></li>
<li><p>Pack it with <a href="http://search.cpan.org/perldoc?pp" rel="noreferrer">`pp`</a>. It will create an executable named "example" or "example.exe" on Windows.</p>

<pre>pp -o example example.pl</pre></li>
</ol>

This would work only on the OS where it was built.  

<em>P.S. It is really hard to find a Unix clone without Perl. Did you mean Windows?</em>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: How can I delete a newline if it is the last character in a file? (score [96750](https://stackoverflow.com/q/1654021) in 2017)

#### Question
I have some files that I'd like to delete the last newline if it is the last character in a file.  `od -c` shows me that the command I run does write the file with a trailing new line:  

```perl
0013600   n   t  >  \n
```

I've tried a few tricks with sed but the best I could think of isn't doing the trick:  

```perl
sed -e '$s/\(.*\)\n$/\1/' abc
```

Any ideas how to do this?  

#### Answer accepted (score 212)
```perl
perl -pe 'chomp if eof' filename >filename2
```

or, to edit the file in place:  

```perl
perl -pi -e 'chomp if eof' filename
```

<sup>[Editor's note: `-pi -e` was originally `-pie`, but, as noted by several commenters and explained by @hvd, the latter doesn't work.]</sup>  

This was described as a 'perl blasphemy' on the awk website I saw.  

But, in a test, it worked.  

#### Answer 2 (score 54)
You can take advantage of the fact that <strong>shell <a href="http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_06_03" rel="noreferrer">command substitutions</a> remove trailing newline characters</strong>:  

Simple form that works in bash, ksh, zsh:  

```perl
printf %s "$(< in.txt)" > out.txt
```

Portable (POSIX-compliant) alternative (slightly less efficient):  

```perl
printf %s "$(cat in.txt)" > out.txt
```

Note:  

<ul>
<li><strong>If `in.txt` ends with <em>multiple</em> newline characters, the command substitution removes <em>all</em> of them</strong> - thanks, @Sparhawk. (It doesn't remove whitespace characters other than trailing newlines.)</li>
<li>Since this approach <strong>reads the entire input file into memory</strong>, it is only advisable for smaller files.</li>
<li>`printf %s` ensures that no newline is appended to the output (it is the POSIX-compliant alternative to the nonstandard `echo -n`; see <a href="http://pubs.opengroup.org/onlinepubs/009696799/utilities/echo.html" rel="noreferrer">http://pubs.opengroup.org/onlinepubs/009696799/utilities/echo.html</a> and <a href="https://unix.stackexchange.com/a/65819">https://unix.stackexchange.com/a/65819</a>)</li>
</ul>

<hr>

A <strong>guide to the other answers</strong>:  

<ul>
<li><p>If <strong>Perl</strong> is available, go for the <a href="https://stackoverflow.com/a/1654042/45375">accepted answer</a> - it is <strong>simple and memory-efficient</strong> (doesn't read the whole input file at once).</p></li>
<li><p>Otherwise, consider <a href="https://stackoverflow.com/a/1654115/45375">ghostdog74's <strong>Awk</strong> answer</a> - it's <strong>obscure, but also memory-efficient</strong>; a <strong>more readable equivalent</strong> (POSIX-compliant) is:</p>

<ul>
<li>`awk 'NR &gt; 1 { print prev } { prev=$0 } END { ORS=""; print }' in.txt`</li>
<li>Printing is delayed by one line so that the final line can be handled in the `END` block, where it is printed without a trailing `\n` due to setting the output-record separator (`OFS`) to an empty string.</li>
</ul></li>
<li><p>If you want a <strong>verbose, but fast and robust solution that <em>truly edits in-place</em></strong> (as opposed to creating a temp. file that then replaces the original), consider <a href="https://stackoverflow.com/a/1658873/45375">jrockway's <strong>Perl script</strong></a>.</p></li>
</ul>

#### Answer 3 (score 45)
You can do this with `head` from GNU coreutils, it supports arguments that are relative to the end of the file. So to leave off the last byte use:  

```perl
head -c -1
```

To test for an ending newline you can use `tail` and `wc`. The following example saves the result to a temporary file and subsequently overwrites the original:  

```perl
if [[ $(tail -c1 file | wc -l) == 1 ]]; then
  head -c -1 file > file.tmp
  mv file.tmp file
fi
```

You could also use `sponge` from `moreutils` to do "in-place" editing:  

```perl
[[ $(tail -c1 file | wc -l) == 1 ]] && head -c -1 file | sponge file
```

<hr>

You can also make a general reusable function by stuffing this in your `.bashrc` file:  

```perl
# Example:  remove-last-newline < multiline.txt
function remove-last-newline(){
    local file=$(mktemp)
    cat > $file
    if [[ $(tail -c1 $file | wc -l) == 1 ]]; then
        head -c -1 $file > $file.tmp
        mv $file.tmp $file
    fi
    cat $file
}
```

<h5>Update</h3>

As noted by <em>KarlWilbur</em> in the comments and used in <a href="https://stackoverflow.com/a/40569742/1331399"><em>Sorentar's</em> answer</a>, `truncate --size=-1` can replace `head -c-1` and supports in-place editing.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: How to compile a Perl script to a Windows executable with Strawberry Perl? (score [96303](https://stackoverflow.com/q/2948405) in 2016)

#### Question
What would be the easiest way to compile a simple Perl script to an executable under Windows with Strawberry Perl (as I understand it's possible and free)?  

In the past I've used ActiveState compiler and perl2exe and was simple enough. However, now after a few computer changes and OS updates I've lost the licenses and I'd like to find a better/permanent solution.  

#### Answer accepted (score 27)
Install <a href="https://metacpan.org/pod/PAR::Packer" rel="noreferrer">PAR::Packer from CPAN (it is free)</a> and use pp utility.  

#### Answer 2 (score 16)
```perl
  :: short answer :
  :: perl -MCPAN -e "install PAR::Packer" 
  pp -o <<DesiredExeName>>.exe <<MyFancyPerlScript>> 

  :: long answer - create the following cmd , adjust vars to your taste ...
  :: next_line_is_templatized
  :: file:compile-morphus.1.2.3.dev.ysg.cmd v1.0.0
  :: disable the echo
  @echo off

  :: this is part of the name of the file - not used
  set _Action=run

  :: the name of the Product next_line_is_templatized
  set _ProductName=morphus

  :: the version of the current Product next_line_is_templatized
  set _ProductVersion=1.2.3

  :: could be dev , test , dev , prod next_line_is_templatized
  set _ProductType=dev

  :: who owns this Product / environment next_line_is_templatized
  set _ProductOwner=ysg

  :: identifies an instance of the tool ( new instance for this version could be created by simply changing the owner )   
  set _EnvironmentName=%_ProductName%.%_ProductVersion%.%_ProductType%.%_ProductOwner%

  :: go the run dir
  cd %~dp0

  :: do 4 times going up
  for /L %%i in (1,1,5) do pushd ..

  :: The BaseDir is 4 dirs up than the run dir
  set _ProductBaseDir=%CD%
  :: debug echo BEFORE _ProductBaseDir is %_ProductBaseDir%
  :: remove the trailing \

  IF %_ProductBaseDir:~-1%==\ SET _ProductBaseDir=%_ProductBaseDir:~0,-1%
  :: debug echo AFTER _ProductBaseDir is %_ProductBaseDir%
  :: debug pause


  :: The version directory of the Product 
  set _ProductVersionDir=%_ProductBaseDir%\%_ProductName%\%_EnvironmentName%

  :: the dir under which all the perl scripts are placed
  set _ProductVersionPerlDir=%_ProductVersionDir%\sfw\perl

  :: The Perl script performing all the tasks
  set _PerlScript=%_ProductVersionPerlDir%\%_Action%_%_ProductName%.pl

  :: where the log events are stored 
  set _RunLog=%_ProductVersionDir%\data\log\compile-%_ProductName%.cmd.log

  :: define a favorite editor 
  set _MyEditor=textpad

  ECHO Check the variables 
  set _
  :: debug PAUSE
  :: truncate the run log
  echo date is %date% time is %time% > %_RunLog%


  :: uncomment this to debug all the vars 
  :: debug set  >> %_RunLog%

  :: for each perl pm and or pl file to check syntax and with output to logs
  for /f %%i in ('dir %_ProductVersionPerlDir%\*.pl /s /b /a-d' ) do echo %%i >> %_RunLog%&perl -wc %%i | tee -a  %_RunLog% 2>&1


  :: for each perl pm and or pl file to check syntax and with output to logs
  for /f %%i in ('dir %_ProductVersionPerlDir%\*.pm /s /b /a-d' ) do echo %%i >> %_RunLog%&perl -wc %%i | tee -a  %_RunLog% 2>&1

  :: now open the run log
  cmd /c start /max %_MyEditor% %_RunLog%


  :: this is the call without debugging
  :: old 
  echo CFPoint1  OK The run cmd script %0 is executed >> %_RunLog%
  echo CFPoint2  OK  compile the exe file  STDOUT and STDERR  to a single _RunLog file >> %_RunLog%
  cd %_ProductVersionPerlDir%

  pp -o %_Action%_%_ProductName%.exe %_PerlScript% | tee -a %_RunLog% 2>&1 

  :: open the run log
  cmd /c start /max %_MyEditor% %_RunLog%

  :: uncomment this line to wait for 5 seconds
  :: ping localhost -n 5

  :: uncomment this line to see what is happening 
  :: PAUSE

  ::
  :::::::
  :: Purpose: 
  :: To compile every *.pl file into *.exe file under a folder 
  :::::::
  :: Requirements : 
  :: perl , pp , win gnu utils tee 
  :: perl -MCPAN -e "install PAR::Packer" 
  :: text editor supporting <<textEditor>> <<FileNameToOpen>> cmd call syntax
  :::::::
  :: VersionHistory
  :: 1.0.0 --- 2012-06-23 12:05:45 --- ysg --- Initial creation from run_morphus.cmd
  :::::::
  :: eof file:compile-morphus.1.2.3.dev.ysg.cmd v1.0.0
```

#### Answer 3 (score 5)
There are three packagers, and two compilers:  

<p>free packager: PAR<br>
commercial packagers: perl2exe, perlapp<br>
compilers: B::C, B::CC</p>

<a href="http://search.cpan.org/dist/B-C/perlcompile.pod" rel="nofollow">http://search.cpan.org/dist/B-C/perlcompile.pod</a>  

<em>(Note: perlfaq3 is still wrong)</em>  

For strawberry you need perl-5.16 and B-C from git master (1.43), as B-C-1.42 does not support 5.16.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: How to use a variable in the replacement side of the Perl substitution operator? (score [96218](https://stackoverflow.com/q/392643) in 2008)

#### Question
I would like to do the following:  

```perl
$find="start (.*) end";
$replace="foo \1 bar";

$var = "start middle end";
$var =~ s/$find/$replace/;
```

I would expect $var to contain "foo middle bar", but it does not work. Neither does:  

```perl
$replace='foo \1 bar';
```

Somehow I am missing something regarding the escaping.  

<hr>

I fixed the missing 's'  

#### Answer accepted (score 76)
On the replacement side, you must use $1, not \1.  

And you can only do what you want by making replace an evalable expression that gives the result you want and telling s/// to eval it with the /ee modifier like so:  

```perl
$find="start (.*) end";
$replace='"foo $1 bar"';

$var = "start middle end";
$var =~ s/$find/$replace/ee;

print "var: $var\n";
```

To see why the "" and double /e are needed, see the effect of the double eval here:  

```perl
$ perl
$foo = "middle";
$replace='"foo $foo bar"';
print eval('$replace'), "\n";
print eval(eval('$replace')), "\n";
__END__
"foo $foo bar"
foo middle bar
```

(Though as ikegami notes, a single /e or the first /e of a double e isn't really an `eval()`; rather, it tells the compiler that the substitution is code to compile, not a string.  Nonetheless, `eval(eval(...))` still demonstrates why you need to do what you need to do to get /ee to work as desired.)  

#### Answer 2 (score 12)
Deparse tells us this is what is  being executed:   

```perl
$find = 'start (.*) end';
$replace = "foo \cA bar";
$var = 'start middle end';
$var =~ s/$find/$replace/;
```

However,   

```perl
 /$find/foo \1 bar/
```

Is interpreted as :  

```perl
$var =~ s/$find/foo $1 bar/;
```

Unfortunately it appears there is no  easy way to do this.    

You can do it with a string eval, but thats dangerous.   

The most sane solution that works for me was this:   

```perl
$find = "start (.*) end"; 
$replace = 'foo \1 bar';

$var = "start middle end"; 

sub repl { 
    my $find = shift; 
    my $replace = shift; 
    my $var = shift;

    # Capture first 
    my @items = ( $var =~ $find ); 
    $var =~ s/$find/$replace/; 
    for( reverse 0 .. $#items ){ 
        my $n = $_ + 1; 
        #  Many More Rules can go here, ie: \g matchers  and \{ } 
        $var =~ s/\\$n/${items[$_]}/g ;
        $var =~ s/\$$n/${items[$_]}/g ;
    }
    return $var; 
}

print repl $find, $replace, $var; 
```

<h5>A rebuttal against the ee technique:</h3>

As I said in my answer, I avoid evals for a reason.   

```perl
$find="start (.*) end";
$replace='do{ print "I am a dirty little hacker" while 1; "foo $1 bar" }';

$var = "start middle end";
$var =~ s/$find/$replace/ee;

print "var: $var\n";
```

this code does exactly what you think it does.   

If your substitution string is in a web application, you just opened the door to arbitrary code execution.   

Good Job.   

Also, it <strong>WON'T</strong> work with taints turned on for this very reason.  

```perl
$find="start (.*) end";
$replace='"' . $ARGV[0] . '"';

$var = "start middle end";
$var =~ s/$find/$replace/ee;

print "var: $var\n"


$ perl /tmp/re.pl  'foo $1 bar'
var: foo middle bar
$ perl -T /tmp/re.pl 'foo $1 bar' 
Insecure dependency in eval while running with -T switch at /tmp/re.pl line 10.
```

However, the more careful technique is sane, safe, secure, <em>and</em> doesn't fail taint. ( Be assured tho, the string it emits is still tainted, so you don't lose any security. )  

#### Answer 3 (score 7)
```perl
# perl -de 0
$match="hi(.*)"
$sub='$1'
$res="hi1234"
$res =~ s/$match/$sub/gee
p $res
  1234
```

Be careful, though. This causes two layers of `eval` to occur, one for each `e` at the end of the regex:  

<ol>
<li>$sub --> $1</li>
<li>$1   --> final value, in the example, 1234</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: What exactly does Perl's "bless" do? (score [96108](https://stackoverflow.com/q/392135) in 2008)

#### Question
I understand one uses the "bless" keyword in Perl inside a class's "new" method:  

```perl
sub new {
    my $self = bless { };
    return $self;
}    
```

But what exactly is "bless" doing to that hash reference ?   

#### Answer accepted (score 138)
In general, `bless` associates an object with a class.  

```perl
package MyClass;
my $object = { };
bless $object, "MyClass";
```

Now when you invoke a method on `$object`, Perl know which package to search for the method.  

If the second argument is omitted, as in your example, the current package/class is used.  

For the sake of clarity, your example might be written as follows:  

```perl
sub new { 
  my $class = shift; 
  my $self = { }; 
  bless $self, $class; 
} 
```

EDIT: See <a href="https://stackoverflow.com/users/11260/kixx">kixx</a>'s good <a href="https://stackoverflow.com/questions/392135/what-exactly-does-perls-bless-do#392194">answer</a> for a little more detail.  

#### Answer 2 (score 77)
`bless` associates a reference with a package.   

It doesn't matter what the reference is to, it can be to a hash (most common case), to an array (not so common), to a scalar (usually this indicates an <a href="https://web.archive.org/web/20071024192241/http://www.perlfoundation.org/perl5/index.cgi?inside_out_object" rel="noreferrer">inside-out object</a>), to a regular expression, subroutine or TYPEGLOB (see the book <a href="https://www.goodreads.com/book/show/86378.Object_Oriented_Perl" rel="noreferrer">Object Oriented Perl: A Comprehensive Guide to Concepts and Programming Techniques by Damian Conway</a> for useful examples) or even a reference to a file or directory handle (least common case).  

The effect `bless`-ing has is that it allows you to apply special syntax to the blessed reference.   

For example, if a blessed reference is stored in `$obj` (associated by `bless` with package "Class"), then `$obj-&gt;foo(@args)` will call a subroutine `foo` and pass as first argument the reference `$obj` followed by the rest of the arguments (`@args`). The subroutine should be defined in package "Class". If there is no subroutine `foo` in package "Class", a list of other packages (taken form the array `@ISA` in the package "Class") will be searched and the first subroutine `foo` found will be called.  

#### Answer 3 (score 9)
Short version: it's marking that hash as attached to the current package namespace (so that that package provides its class implementation).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: How can I ssh inside a Perl script? (score [94512](https://stackoverflow.com/q/2848725) in 2015)

#### Question
I want to SSH to a server and execute a simple command like "id" and get the output of it and store it to a file on my primary server. I do not have privileges to install <a href="http://search.cpan.org/dist/Net-SSH" rel="nofollow noreferrer">Net::SSH</a> which would make my task very easy. Please provide me a solution for this. I tried using <em>back-ticks</em> but I am not able to store the output on the machine from which my script runs.  

#### Answer 2 (score 14)
The best way to run commands remotely using SSH is  

```perl
$ ssh user@host "command" > output.file
```

You can use this either in bash or in perl. However, If you want to use perl you can install the perl modules in your local directory path as suggested by brian in his comment or from Perl FAQ at "<a href="http://perldoc.perl.org/perlfaq8.html#How-do-I-keep-my-own-module/library-directory?" rel="nofollow noreferrer">How do I keep my own module/library directory?</a>". Instead of using Net::SSH I would suggest to use Net::SSH::Perl with the below example.  

```perl
#!/usr/bin/perl -w
use strict;
use lib qw("/path/to/module/");

use Net::SSH::Perl;

my $hostname = "hostname";
my $username = "username";
my $password = "password";

my $cmd = shift;

my $ssh = Net::SSH::Perl->new("$hostname", debug=>0);
$ssh->login("$username","$password");
my ($stdout,$stderr,$exit) = $ssh->cmd("$cmd");
print $stdout;
```

#### Answer 3 (score 8)
You can always install modules locally, and that is the method you should look into; however, you should be able to get away with  

```perl
#!/usr/bin/perl

use strict;
use warnings;

my $id = qx/ssh remotehost id 2>&1/;

chomp $id;

print "id is [$id]\n"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: In Perl, what is the difference between a .pm (Perl module) and .pl (Perl script) file? (score [94271](https://stackoverflow.com/q/3402821) in 2012)

#### Question
What is the Difference between `.pm` (Perl module) and `.pl` (Perl script) file?  

Please also tell me why we return `1` from file. If return 2 or anything else, it's not generating any error, so why do we return `1` from Perl module?  

#### Answer 2 (score 74)
At the very core, the file extension you use makes no difference as to how `perl` interprets those files.  

However, putting modules in `.pm` files following a certain directory structure that follows the package name provides a convenience. So, if you have a module `Example::Plot::FourD` and you put it in a directory `Example/Plot/FourD.pm` in a path in your <a href="http://perldoc.perl.org/perlvar.html#%40INC" rel="noreferrer">`@INC`</a>, then <a href="http://perldoc.perl.org/functions/use.html" rel="noreferrer">`use`</a> and <a href="http://perldoc.perl.org/functions/require.html" rel="noreferrer">`require`</a> will do the right thing when given the package name as in `use Example::Plot::FourD`.  

<blockquote>
  The file must return true as the last statement to indicate successful execution of any initialization code, so it's customary to end such a file with `1;`  unless you're sure it'll return true otherwise. But it's better just to put the `1;`, in case you add more statements.  
  
  If `EXPR` is a bareword, the `require` assumes a ".pm" extension and replaces "::" with "/" in the filename for you, to make it easy to load standard modules. This form of loading of modules does not risk altering your namespace.  
</blockquote>

All `use` does is to figure out the filename from the package name provided, `require` it in a `BEGIN` block and invoke `import` on the package. There is nothing preventing you from not using `use` but taking those steps manually.  

For example, below I put the `Example::Plot::FourD` package in a file called `t.pl`, loaded it in a script in file `s.pl`.  

```perl
C:\Temp> cat t.pl
package Example::Plot::FourD;

use strict; use warnings;

sub new { bless {} => shift }

sub something { print "something\n" }

"Example::Plot::FourD"

C:\Temp> cat s.pl
#!/usr/bin/perl
use strict; use warnings;

BEGIN {
    require 't.pl';
}

my $p = Example::Plot::FourD->new;
$p->something;


C:\Temp> s
something
```

This example shows that module files do not have to end in `1`, any true value will do.  

#### Answer 3 (score -2)
A .pl is a single script.  

In .pm (<a href="http://world.std.com/~swmcd/steven/perl/module_mechanics.html" rel="nofollow noreferrer">Perl Module</a>) you have functions that you can use from other Perl scripts:  

<blockquote>
  A Perl module is a self-contained piece of Perl code that can be used by a Perl program or by other Perl modules. It is conceptually similar to a C link library, or a C++ class.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Perl - Multiple condition if statement without duplicating code? (score [94162](https://stackoverflow.com/q/21759169) in )

#### Question
This is a Perl program, run using a terminal (Windows Command Line). I am trying to create an "if this and this is true, or this and this is true" if statement using the same block of code for both conditions without having to repeat the code.  

```perl
if ($name eq "tom" and $password eq "123!") elsif ($name eq "frank" and $password eq "321!") {

print "You have gained access.";

} else {

print "Access denied!";

}
```

#### Answer accepted (score 20)
Simple:  

```perl
if ( $name eq 'tom' && $password eq '123!'
    || $name eq 'frank' && $password eq '321!'
) {
```

(use the high-precedence `&amp;&amp;` and `||` in expressions, reserving `and` and `or` for flow control, to avoid common precedence errors)  

Better:  

```perl
my %password = (
    'tom' => '123!',
    'frank' => '321!',
);

if ( exists $password{$name} && $password eq $password{$name} ) {
```

#### Answer 2 (score 3)
I don't recommend storing passwords in a script, but this is a way to what you indicate:  

```perl
use 5.010;
my %user_table = ( tom => '123!', frank => '321!' );

say ( $user_table{ $name } eq $password ? 'You have gained access.'
    :                                     'Access denied!'
    );
```

Any time you want to enforce an association like this, it's a good idea to think of a <em>table</em>, and the most common form of table in perl is the hash.   

#### Answer 3 (score 1)
```perl
if (   ($name eq "tom" and $password eq "123!")
    or ($name eq "frank" and $password eq "321!")) {
    print "You have gained access.";
}
else {
    print "Access denied!";
}
```

(Other people: I'm pretty sure John Doe here isn't actually hardcoding passwords; he's just using it as an example.)  
</section>

