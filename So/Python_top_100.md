---
title: Python <- StackOverflow top 100
category: Python
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: Iterating over dictionaries using 'for' loops (score [4065148](https://stackoverflow.com/q/3294889) in 2017)

#### Question
I am a bit puzzled by the following code:  

```python
d = {'x': 1, 'y': 2, 'z': 3} 
for key in d:
    print key, 'corresponds to', d[key]
```

What I don't understand is the `key` portion. How does Python recognize that it needs only to read the key from the dictionary? Is `key` a special word in Python? Or is it simply a variable?  

#### Answer accepted (score 5011)
`key` is just a variable name.    

```python
for key in d:
```

will simply loop over the keys in the dictionary, rather than the keys and values.  To loop over both key and value you can use the following:  

For Python 2.x:  

```python
for key, value in d.iteritems():
```

For Python 3.x:  

```python
for key, value in d.items():
```

To test for yourself, change the word `key` to `poop`.  

<p>For Python 3.x, `iteritems()` has been replaced with simply `items()`, which returns a set-like view backed by the dict, like `iteritems()` but even better. 
This is also available in 2.7 as `viewitems()`. </p>

The operation `items()` will work for both 2 and 3, but in 2 it will return a list of the dictionary's `(key, value)` pairs, which will not reflect changes to the dict that happen after the `items()` call. If you want the 2.x behavior in 3.x, you can call `list(d.items())`.  

#### Answer 2 (score 401)
It's not that key is a special word, but that dictionaries implement the iterator protocol.  You could do this in your class, e.g. see <a href="https://stackoverflow.com/questions/19151/build-a-basic-python-iterator/24377#24377">this question</a> for how to build class iterators.  

In the case of dictionaries, it's implemented at the C level.  The details are available in <a href="http://www.python.org/dev/peps/pep-0234/" rel="noreferrer">PEP 234</a>.  In particular, the section titled "Dictionary Iterators":  

<blockquote>
  <ul>
  <li><p>Dictionaries implement a tp_iter slot that returns an efficient
  iterator that iterates over the keys of the dictionary. [...] This 
  means that we can write</p>

```python
for k in dict: ...
```
  
  which is equivalent to, but much faster than  

```python
for k in dict.keys(): ...
```
  
  <p>as long as the restriction on modifications to the dictionary
  (either by the loop or by another thread) are not violated.</p></li>
  <li><p>Add methods to dictionaries that return different kinds of
  iterators explicitly:</p>

```python
for key in dict.iterkeys(): ...

for value in dict.itervalues(): ...

for key, value in dict.iteritems(): ...
```
  
  <p>This means that `for x in dict` is shorthand for <code>for x in
   dict.iterkeys()</code>.</p></li>
  </ul>
</blockquote>

In Python 3, `dict.iterkeys()`, `dict.itervalues()` and `dict.iteritems()` are no longer supported. Use `dict.keys()`, `dict.values()` and `dict.items()` instead.  

#### Answer 3 (score 189)
Iterating over a `dict` iterates through its keys in no particular order, as you can see here:   

Edit: (This is <strong>no longer the case in <a href="https://stackoverflow.com/questions/39980323/dictionaries-are-ordered-in-python-3-6">Python3.6</a></strong>, but note that it's <strong>not guaranteed</strong> behaviour yet)  

```python
>>> d = {'x': 1, 'y': 2, 'z': 3} 
>>> list(d)
['y', 'x', 'z']
>>> d.keys()
['y', 'x', 'z']
```

For your example, it is a better idea to use `dict.items()`:  

```python
>>> d.items()
[('y', 2), ('x', 1), ('z', 3)]
```

This gives you a list of tuples. When you loop over them like this, each tuple is unpacked into `k` and `v` automatically:  

```python
for k,v in d.items():
    print(k, 'corresponds to', v)
```

Using `k` and `v` as variable names when looping over a `dict` is quite common if the body of the loop is only a few lines. For more complicated loops it may be a  good idea to use more descriptive names:  

```python
for letter, number in d.items():
    print(letter, 'corresponds to', number)
```

It's a good idea to get into the habit of using format strings:  

```python
for letter, number in d.items():
    print('{0} corresponds to {1}'.format(letter, number))
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: Does Python have a string 'contains' substring method? (score [3792442](https://stackoverflow.com/q/3437059) in 2017)

#### Question
I'm looking for a `string.contains` or `string.indexof` method in Python.  

I want to do:  

```python
if not somestring.contains("blah"):
   continue
```

#### Answer accepted (score 5757)
You can use the <a href="https://docs.python.org/reference/expressions.html#membership-test-details" rel="noreferrer">`in` operator</a>:  

```python
if "blah" not in somestring: 
    continue
```

#### Answer 2 (score 601)
If it's just a substring search you can use `string.find("substring")`.  

You do have to be a little careful with <a href="https://docs.python.org/library/stdtypes.html#str.find" rel="noreferrer">`find`</a>, <a href="https://docs.python.org/library/stdtypes.html#str.index" rel="noreferrer">`index`</a>, and <a href="https://docs.python.org/reference/expressions.html#membership-test-operations" rel="noreferrer">`in`</a> though, as they are substring searches. In other words, this:  

```python
s = "This be a string"
if s.find("is") == -1:
    print "No 'is' here!"
else:
    print "Found 'is' in the string."
```

It would print `Found 'is' in the string.` Similarly, `if "is" in s:` would evaluate to `True`. This may or may not be what you want.  

#### Answer 3 (score 161)
`if needle in haystack:` is the normal use, as @Michael says -- it relies on the <a href="https://docs.python.org/reference/expressions.html#membership-test-details" rel="noreferrer">`in`</a> operator, more readable and faster than a method call.  

If you truly need a method instead of an operator (e.g. to do some weird `key=` for a very peculiar sort...?), that would be <a href="https://docs.python.org/reference/datamodel.html#object.__contains__" rel="noreferrer">`'haystack'.__contains__`</a>.  But since your example is for use in an `if`, I guess you don't really mean what you say;-).  It's not good form (nor readable, nor efficient) to use special methods directly -- they're meant to be used, instead, through the operators and builtins that delegate to them.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How do I check whether a file exists without exceptions? (score [3681360](https://stackoverflow.com/q/82831) in 2018)

#### Question
How do I see if a file exists or not, without using the <a href="https://docs.python.org/3.6/reference/compound_stmts.html#try" rel="noreferrer">`try`</a> statement?  

#### Answer 2 (score 4830)
If the reason you're checking is so you can do something like `if file_exists: open_it()`, it's safer to use a `try` around the attempt to open it. Checking and then opening risks the file being deleted or moved or something between when you check and when you try to open it.  

If you're not planning to open the file immediately, you can use <a href="https://docs.python.org/library/os.path.html#os.path.isfile" rel="noreferrer">`os.path.isfile`</a>  

<blockquote>
  Return `True` if path is an existing regular file. This follows symbolic links, so both <a href="https://docs.python.org/library/os.path.html#os.path.islink" rel="noreferrer">islink()</a> and <a href="https://docs.python.org/library/os.path.html#os.path.isfile" rel="noreferrer">isfile()</a> can be true for the same path.  
</blockquote>

```python
import os.path
os.path.isfile(fname) 
```

if you need to be sure it's a file.  

Starting with Python 3.4, the <a href="https://docs.python.org/3/library/pathlib.html#pathlib.Path.is_file" rel="noreferrer">`pathlib` module</a> offers an object-oriented approach (backported to `pathlib2` in Python 2.7):  

```python
from pathlib import Path

my_file = Path("/path/to/file")
if my_file.is_file():
    # file exists
```

To check a directory, do:  

```python
if my_file.is_dir():
    # directory exists
```

To check whether a `Path` object exists independently of whether is it a file or directory, use `exists()`:  

```python
if my_file.exists():
    # path exists
```

You can also use `resolve(strict=True)` in a `try` block:  

```python
try:
    my_abs_path = my_file.resolve(strict=True)
except FileNotFoundError:
    # doesn't exist
else:
    # exists
```

#### Answer 3 (score 1993)
You have the <a href="https://docs.python.org/2/library/os.path.html#os.path.exists" rel="noreferrer">`os.path.exists`</a> function:  

```python
import os.path
os.path.exists(file_path)
```

This returns `True` for both files and directories but you can instead use  

```python
os.path.isfile(file_path)
```

to test if it's a file specifically. It follows symlinks.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How do I parse a string to a float or int? (score [3665519](https://stackoverflow.com/q/379906) in 2019)

#### Question
In Python, how can I parse a numeric string like `"545.2222"` to its corresponding float value, `545.2222`? Or parse the string `"31"` to an integer, `31`?  

I just want to know how to parse a <em>float</em> `str` to a `float`, and (separately) an <em>int</em> `str` to an `int`.  

#### Answer accepted (score 2443)
```python
>>> a = "545.2222"
>>> float(a)
545.22220000000004
>>> int(float(a))
545
```

#### Answer 2 (score 487)
```python
def num(s):
    try:
        return int(s)
    except ValueError:
        return float(s)
```

#### Answer 3 (score 477)
<h5>Python method to check if a string is a float:</h2>

```python
def is_float(value):
  try:
    float(value)
    return True
  except:
    return False
```

A longer and more accurate name for this function could be: `is_convertible_to_float(value)`  

<h5>What is, and is not a float in <a href="http://en.wikipedia.org/wiki/Python_%28programming_language%29" rel="noreferrer">Python</a> may surprise you:</h2>

```python
val                   is_float(val) Note
--------------------  ----------   --------------------------------
""                    False        Blank string
"127"                 True         Passed string
True                  True         Pure sweet Truth
"True"                False        Vile contemptible lie
False                 True         So false it becomes true
"123.456"             True         Decimal
"      -127    "      True         Spaces trimmed
"\t\n12\r\n"          True         whitespace ignored
"NaN"                 True         Not a number
"NaNanananaBATMAN"    False        I am Batman
"-iNF"                True         Negative infinity
"123.E4"              True         Exponential notation
".1"                  True         mantissa only
"1,234"               False        Commas gtfo
u'\x30'               True         Unicode is fine.
"NULL"                False        Null is not special
0x3fade               True         Hexadecimal
"6e7777777777777"     True         Shrunk to infinity
"1.797693e+308"       True         This is max value
"infinity"            True         Same as inf
"infinityandBEYOND"   False        Extra characters wreck it
"12.34.56"            False        Only one dot allowed
u'四'                 False        Japanese '4' is not a float.
"#56"                 False        Pound sign
"56%"                 False        Percent of what?
"0E0"                 True         Exponential, move dot 0 places
0**0                  True         0___0  Exponentiation
"-5e-5"               True         Raise to a negative number
"+1e1"                True         Plus is OK with exponent
"+1e1^5"              False        Fancy exponent not interpreted
"+1e1.3"              False        No decimals in exponent
"-+1"                 False        Make up your mind
"(1)"                 False        Parenthesis is bad
```

You think you know what numbers are? You are not so good as you think! Not big surprise.  

<h5>Don't use this code on life-critical software!</h2>

Catching broad exceptions this way, killing canaries and gobbling the exception creates a tiny chance that a valid float as string will return false.  The `float(...)` line of code can failed for any of a thousand reasons that have nothing to do with the contents of the string.  But if you're writing life-critical software in a duck-typing prototype language like Python, then you've got much larger problems.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: How do I list all files of a directory? (score [3621699](https://stackoverflow.com/q/3207219) in 2017)

#### Question
How can I list all files of a directory in Python and add them to a `list`?  

#### Answer 2 (score 3664)
<a href="https://docs.python.org/2/library/os.html#os.listdir" rel="noreferrer" title="os.listdir">`os.listdir()`</a> will get you everything that's in a directory - files and directories.  

If you want <em>just</em> files, you could either filter this down using <a href="https://docs.python.org/2/library/os.path.html#module-os.path" rel="noreferrer">`os.path`</a>:  

```python
from os import listdir
from os.path import isfile, join
onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
```

or you could use <a href="https://docs.python.org/2/library/os.html#os.walk" rel="noreferrer" title="os.walk">`os.walk()`</a> which will yield two lists for each directory it visits - splitting into files and dirs for you. If you only want the top directory you can just break the first time it yields  

```python
from os import walk

f = []
for (dirpath, dirnames, filenames) in walk(mypath):
    f.extend(filenames)
    break
```

#### Answer 3 (score 1475)
I prefer using the <a href="https://docs.python.org/library/glob.html" rel="noreferrer">`glob`</a> module, as it does pattern matching and expansion.  

```python
import glob
print(glob.glob("/home/adam/*.txt"))
```

It will return a list with the queried files:  

```python
['/home/adam/file1.txt', '/home/adam/file2.txt', .... ]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: Finding the index of an item given a list containing it in Python (score [3448930](https://stackoverflow.com/q/176918) in 2019)

#### Question
For a list `["foo", "bar", "baz"]` and an item in the list `"bar"`, how do I get its index (1) in Python?  

#### Answer accepted (score 4050)
```python
>>> ["foo", "bar", "baz"].index("bar")
1
```

Reference: <a href="http://docs.python.org/2/tutorial/datastructures.html#more-on-lists" rel="noreferrer">Data Structures > More on Lists</a>  

<h5>Caveats follow</h1>

Note that while this is perhaps the cleanest way to answer the question <em>as asked</em>, `index` is a rather weak component of the `list` API, and I can't remember the last time I used it in anger. It's been pointed out to me in the comments that because this answer is heavily referenced, it should be made more complete. Some caveats about `list.index` follow. It is probably worth initially taking a look at the docstring for it:  

```python
>>> print(list.index.__doc__)
L.index(value, [start, [stop]]) -> integer -- return first index of value.
Raises ValueError if the value is not present.
```

<h5>Linear time-complexity in list length</h2>

An `index` call checks every element of the list in order, until it finds a match. If your list is long, and you don't know roughly where in the list it occurs, this search could become a bottleneck. In that case, you should consider a different data structure. Note that if you know roughly where to find the match, you can give `index` a hint. For instance, in this snippet, `l.index(999_999, 999_990, 1_000_000)` is roughly five orders of magnitude faster than straight `l.index(999_999)`, because the former only has to search 10 entries, while the latter searches a million:  

```python
>>> import timeit
>>> timeit.timeit('l.index(999_999)', setup='l = list(range(0, 1_000_000))', number=1000)
9.356267921015387
>>> timeit.timeit('l.index(999_999, 999_990, 1_000_000)', setup='l = list(range(0, 1_000_000))', number=1000)
0.0004404920036904514
```

<h5>Only returns the index of the <em>first match</em> to its argument</h2>

A call to `index` searches through the list in order until it finds a match, and <em>stops there.</em> If you expect to need indices of more matches, you should use a list comprehension, or generator expression.  

```python
>>> [1, 1].index(1)
0
>>> [i for i, e in enumerate([1, 2, 1]) if e == 1]
[0, 2]
>>> g = (i for i, e in enumerate([1, 2, 1]) if e == 1)
>>> next(g)
0
>>> next(g)
2
```

Most places where I once would have used `index`, I now use a list comprehension or generator expression because they're more generalizable. So if you're considering reaching for `index`, take a look at these excellent python features.  

<h5>Throws if element not present in list</h2>

A call to `index` results in a `ValueError` if the item's not present.  

```python
>>> [1, 1].index(2)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: 2 is not in list
```

If the item might not be present in the list, you should either   

<ol>
<li>Check for it first with `item in my_list` (clean, readable approach), or</li>
<li>Wrap the `index` call in a `try/except` block which catches `ValueError` (probably faster, at least when the list to search is long, and the item is usually present.)</li>
</ol>

#### Answer 2 (score 861)
One thing that is really helpful in learning Python is to use the interactive help function:  

```python
>>> help(["foo", "bar", "baz"])
Help on list object:

class list(object)
 ...

 |
 |  index(...)
 |      L.index(value, [start, [stop]]) -> integer -- return first index of value
 |
```

which will often lead you to the method you are looking for.  

#### Answer 3 (score 511)
The majority of answers explain how to find <strong>a single index</strong>, but their methods do not return multiple indexes if the item is in the list multiple times. Use <a href="https://docs.python.org/3.6/library/functions.html#enumerate" rel="noreferrer">`enumerate()`</a>:  

```python
for i, j in enumerate(['foo', 'bar', 'baz']):
    if j == 'bar':
        print(i)
```

The `index()` function only returns the first occurrence, while `enumerate()` returns all occurrences.  

As a list comprehension:  

```python
[i for i, j in enumerate(['foo', 'bar', 'baz']) if j == 'bar']
```

<hr>

Here's also another small solution with <a href="http://docs.python.org/2/library/itertools.html#itertools.count" rel="noreferrer">`itertools.count()`</a> (which is pretty much the same approach as enumerate):  

```python
from itertools import izip as zip, count # izip for maximum efficiency
[i for i, j in zip(count(), ['foo', 'bar', 'baz']) if j == 'bar']
```

This is more efficient for larger lists than using `enumerate()`:  

```python
$ python -m timeit -s "from itertools import izip as zip, count" "[i for i, j in zip(count(), ['foo', 'bar', 'baz']*500) if j == 'bar']"
10000 loops, best of 3: 174 usec per loop
$ python -m timeit "[i for i, j in enumerate(['foo', 'bar', 'baz']*500) if j == 'bar']"
10000 loops, best of 3: 196 usec per loop
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: How to read a file line-by-line into a list? (score [3366083](https://stackoverflow.com/q/3277503) in 2018)

#### Question
How do I read every line of a file in Python and store each line as an element in a list?   

I want to read the file line by line and append each line to the end of the list.  

#### Answer 2 (score 2035)
```python
with open(filename) as f:
    content = f.readlines()
# you may also want to remove whitespace characters like `\n` at the end of each line
content = [x.strip() for x in content] 
```

#### Answer 3 (score 915)
See <a href="http://docs.python.org/tutorial/inputoutput.html#reading-and-writing-files" rel="noreferrer">Input and Ouput</a>:  

```python
with open('filename') as f:
    lines = f.readlines()
```

or with stripping the newline character:  

```python
lines = [line.rstrip('\n') for line in open('filename')]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: Calling an external command in Python (score [3202147](https://stackoverflow.com/q/89228) in 2019)

#### Question
How do you call an external command (as if I'd typed it at the Unix shell or Windows command prompt) from within a Python script?  

#### Answer accepted (score 4312)
Look at the <a href="https://docs.python.org/library/subprocess.html" rel="noreferrer">subprocess</a> module in the standard library:  

```python
import subprocess
subprocess.run(["ls", "-l"])
```

The advantage of `subprocess` vs. `system` is that it is more flexible (you can get the `stdout`, `stderr`, the "real" status code, better error handling, etc...).  

The <a href="https://docs.python.org/library/os.html#os.system" rel="noreferrer">official documentation</a> recommends the `subprocess` module over the alternative `os.system()`:  

<blockquote>
  The `subprocess` module provides more powerful facilities for spawning new processes and retrieving their results; using that module is preferable to using this function [<a href="https://docs.python.org/library/os.html#os.system" rel="noreferrer">`os.system()`</a>].  
</blockquote>

The <a href="https://docs.python.org/library/subprocess.html#replacing-older-functions-with-the-subprocess-module" rel="noreferrer">Replacing Older Functions with the subprocess Module</a> section in the `subprocess` documentation may have some helpful recipes.  

For versions of Python before 3.5, use `call`:  

```python
import subprocess
subprocess.call(["ls", "-l"])
```

#### Answer 2 (score 2852)
Here's a summary of the ways to call external programs and the advantages and disadvantages of each:  

<ol>
<li><p>`os.system("some_command with args")` passes the command and arguments to your system's shell.  This is nice because you can actually run multiple commands at once in this manner and set up pipes and input/output redirection.  For example:  </p>

```python
os.system("some_command < input_file | another_command > output_file")  
```</li>
</ol>

However, while this is convenient, you have to manually handle the escaping of shell characters such as spaces, etc.  On the other hand, this also lets you run commands which are simply shell commands and not actually external programs.  See <a href="https://docs.python.org/2/library/os.html#os.system" rel="noreferrer">the documentation</a>.  

<ol start="2">
<li><p>`stream = os.popen("some_command with args")` will do the same thing as `os.system` except that it gives you a file-like object that you can use to access standard input/output for that process.  There are 3 other variants of popen that all handle the i/o slightly differently.  If you pass everything as a string, then your command is passed to the shell; if you pass them as a list then you don't need to worry about escaping anything.  See <a href="https://docs.python.org/2/library/os.html#os.popen" rel="noreferrer">the documentation</a>.</p></li>
<li><p>The `Popen` class of the `subprocess` module.  This is intended as a replacement for `os.popen` but has the downside of being slightly more complicated by virtue of being so comprehensive.  For example, you'd say:</p>

```python
print subprocess.Popen("echo Hello World", shell=True, stdout=subprocess.PIPE).stdout.read()
```

instead of:   

```python
print os.popen("echo Hello World").read()
```

but it is nice to have all of the options there in one unified class instead of 4 different popen functions.  See <a href="https://docs.python.org/2/library/subprocess.html#popen-constructor" rel="noreferrer">the documentation</a>.  </li>
<li><p>The `call` function from the `subprocess` module.  This is basically just like the `Popen` class and takes all of the same arguments, but it simply waits until the command completes and gives you the return code.  For example:</p>

```python
return_code = subprocess.call("echo Hello World", shell=True)  
```

See <a href="https://docs.python.org/2/library/subprocess.html#subprocess.call" rel="noreferrer">the documentation</a>.  </li>
<li><p>If you're on Python 3.5 or later, you can use the new <a href="https://docs.python.org/3.5/library/subprocess.html#subprocess.run" rel="noreferrer">`subprocess.run`</a> function, which is a lot like the above but even more flexible and returns a <a href="https://docs.python.org/3.5/library/subprocess.html#subprocess.CompletedProcess" rel="noreferrer">`CompletedProcess`</a> object when the command finishes executing.</p></li>
<li><p>The os module also has all of the fork/exec/spawn functions that you'd have in a C program, but I don't recommend using them directly.</p></li>
</ol>

The `subprocess` module should probably be what you use.  

Finally please be aware that for all methods where you pass the final command to be executed by the shell as a string and you are responsible for escaping it. <strong>There are serious security implications</strong> if any part of the string that you pass can not be fully trusted. For example, if a user is entering some/any part of the string. If you are unsure, only use these methods with constants. To give you a hint of the implications consider this code:  

```python
print subprocess.Popen("echo %s " % user_input, stdout=PIPE).stdout.read()
```

and imagine that the user enters something "my mama didnt love me &amp;&amp; rm -rf /" which could erase the whole filesystem.  

#### Answer 3 (score 318)
Typical implementation:  

```python
import subprocess

p = subprocess.Popen('ls', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
for line in p.stdout.readlines():
    print line,
retval = p.wait()
```

You are free to do what you want with the `stdout` data in the pipe.  In fact, you can simply omit those parameters (`stdout=` and `stderr=`) and it'll behave like `os.system()`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: Converting integer to string? (score [3197810](https://stackoverflow.com/q/961632) in 2019)

#### Question
I want to convert an integer to a string in Python. I am typecasting it in vain:  

```python
d = 15
d.str()
```

When I try to convert it to string, it's showing an error like `int` doesn't have any attribute called `str`.  

#### Answer accepted (score 1966)
```python
>>> str(10)
'10'
>>> int('10')
10
```

Links to the documentation:  

<ul>
<li><a href="https://docs.python.org/2/library/functions.html#int" rel="noreferrer">`int()`</a>  </li>
<li><a href="https://docs.python.org/2/library/functions.html#str" rel="noreferrer">`str()`</a></li>
</ul>

Conversion to a string is done with the builtin `str()` function, which basically calls the <a href="https://docs.python.org/3/reference/datamodel.html#object.__str__" rel="noreferrer">`__str__()`</a> method of its parameter.  

#### Answer 2 (score 112)
Try this:  

```python
str(i)
```

#### Answer 3 (score 54)
There is not typecast and no type coercion in Python. You have to convert your variable in an explicit way.  

To convert an object in string you use the `str()` function. It works with any object that has a method  called `__str__()` defined. In fact  

```python
str(a)
```

is equivalent to  

```python
a.__str__()
```

The same if you want to convert something to int, float, etc.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: Add new keys to a dictionary? (score [3143556](https://stackoverflow.com/q/1024847) in 2019)

#### Question
Is it possible to add a key to a Python dictionary after it has been created? It doesn't seem to have an `.add()` method.  

#### Answer accepted (score 3128)
```python
d = {'key':'value'}
print(d)
# {'key': 'value'}
d['mynewkey'] = 'mynewvalue'
print(d)
# {'mynewkey': 'mynewvalue', 'key': 'value'}
```

#### Answer 2 (score 975)
To add multiple keys simultaneously:  

```python
>>> x = {1:2}
>>> print x
{1: 2}

>>> d = {3:4, 5:6, 7:8}
>>> x.update(d)
>>> print x
{1: 2, 3: 4, 5: 6, 7: 8}
```

For adding a single key, the accepted answer has less computational overhead.  

#### Answer 3 (score 838)
I feel like consolidating info about Python dictionaries:  

<h5>Creating an empty dictionary</h3>

```python
data = {}
# OR
data = dict()
```

<h5>Creating a dictionary with initial values</h3>

```python
data = {'a':1,'b':2,'c':3}
# OR
data = dict(a=1, b=2, c=3)
# OR
data = {k: v for k, v in (('a', 1),('b',2),('c',3))}
```

<h5>Inserting/Updating a single value</h3>

```python
data['a']=1  # Updates if 'a' exists, else adds 'a'
# OR
data.update({'a':1})
# OR
data.update(dict(a=1))
# OR
data.update(a=1)
```

<h5>Inserting/Updating multiple values</h3>

```python
data.update({'c':3,'d':4})  # Updates 'c' and adds 'd'
```

<h5>Creating a merged dictionary without modifying originals</h3>

```python
data3 = {}
data3.update(data)  # Modifies data3, not data
data3.update(data2)  # Modifies data3, not data2
```

<h5>Deleting items in dictionary</h3>

```python
del data[key]  # Removes specific element in a dictionary
data.pop(key)  # Removes the key & returns the value
data.clear()  # Clears entire dictionary
```

<h5>Check if a key is already in dictionary</h3>

```python
key in data
```

<h5>Iterate through pairs in a dictionary</h3>

```python
for key in data: # Iterates just through the keys, ignoring the values
for key, value in d.items(): # Iterates through the pairs
for key in d.keys(): # Iterates just through key, ignoring the values
for value in d.values(): # Iterates just through value, ignoring the keys
```

<h5>Create a dictionary from 2 lists</h3>

```python
data = dict(zip(list_with_keys, list_with_values))
```

<hr>

<h5>New to Python3</h1>

<h5>Creating a merged dictionary without modifying originals</h3>

```python
data = {**data1, **data2, **data3}
```

<hr>

Feel free to add more!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: Check if a given key already exists in a dictionary (score [3139063](https://stackoverflow.com/q/1602934) in 2013)

#### Question
<p>I wanted to test if a key exists in a dictionary before updating the value for the key.
I wrote the following code:</p>

```python
if 'key1' in dict.keys():
  print "blah"
else:
  print "boo"
```

I think this is not the best way to accomplish this task. Is there a better way to test for a key in the dictionary?  

#### Answer accepted (score 2923)
`in` is the intended way to test for the existence of a key in a `dict`.  

```python
d = dict()

for i in range(100):
    key = i % 10
    if key in d:
        d[key] += 1
    else:
        d[key] = 1
```

If you wanted a default, you can always use `dict.get()`:  

```python
d = dict()

for i in range(100):
    key = i % 10
    d[key] = d.get(key, 0) + 1
```

... and if you wanted to always ensure a default value for any key you can use `defaultdict` from the `collections` module, like so:  

```python
from collections import defaultdict

d = defaultdict(int)

for i in range(100):
    d[i % 10] += 1
```

... but in general, the `in` keyword is the best way to do it.  

#### Answer 2 (score 1454)
You don't have to call keys:  

```python
if 'key1' in dict:
  print "blah"
else:
  print "boo"
```

That will be much <a href="https://stackoverflow.com/a/30527984/452708">faster</a> as it uses the dictionary's hashing as opposed to doing a linear search, which calling keys would do.  

#### Answer 3 (score 258)
You can test for the presence of a key in a dictionary, using the <b>in</b> keyword:  

```python
d = {'a': 1, 'b': 2}
'a' in d # <== evaluates to True
'c' in d # <== evaluates to False
```

A common use for checking the existence of a key in a dictionary before mutating it is to default-initialize the value (e.g. if your values are lists, for example, and you want to ensure that there is an empty list to which you can append when inserting the first value for a key). In cases such as those, you may find the <a href="https://docs.python.org/2/library/collections.html#collections.defaultdict" rel="noreferrer">`collections.defaultdict()`</a> type to be of interest.  

In older code, you may also find some uses of `has_key()`, a deprecated method for checking the existence of keys in dictionaries (just use `key_name in dict_name`, instead).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How do I get the number of elements in a list? (score [3134575](https://stackoverflow.com/q/1712227) in 2019)

#### Question
Consider the following:  

```python
items = []
items.append("apple")
items.append("orange")
items.append("banana")

# FAKE METHOD:
items.amount()  # Should return 3
```

How do I get the number of elements in the list `items`?  

#### Answer accepted (score 2526)
The `len()` function can be used with several different types in Python - both built-in types and library types. For example:  

```python
>>> len([1,2,3])
3
```

<p>Official 2.x documentation is here: <a href="https://docs.python.org/2/library/functions.html#len" rel="noreferrer" title="len()">`len()`</a><br>
Official 3.x documentation is here: <a href="https://docs.python.org/3/library/functions.html#len" rel="noreferrer" title="len()">`len()`</a></p>

#### Answer 2 (score 216)
<blockquote>
  <h5>How to get the size of a list?</h1>
</blockquote>

To find the size of a list, use the builtin function, `len`:  

```python
items = []
items.append("apple")
items.append("orange")
items.append("banana")
```

And now:  

```python
len(items)
```

returns 3.  

<h5>Explanation</h2>

Everything in Python is an object, including lists. All objects have a header of some sort in the C implementation.   

Lists and other similar builtin objects with a "size" in Python, in particular, have an attribute called `ob_size`, where the number of elements in the object is cached. So checking the number of objects in a list is very fast.  

But if you're checking if list size is zero or not, don't use `len` - instead, <a href="https://stackoverflow.com/a/45778282/541136">put the list in a boolean context - it treated as False if empty, True otherwise</a>.  

<h5>From the <a href="https://docs.python.org/library/functions.html#len" rel="noreferrer">docs</a></h2>

<strong>`len(s)`</strong>  

<blockquote>
  <p>Return the length (the number of items) of an object. The argument may be a sequence (such as a string, bytes, tuple, list, or range) or
  a collection (such as a dictionary, set, or frozen set).</p>
</blockquote>

`len` is implemented with `__len__`, from the data model <a href="https://docs.python.org/reference/datamodel.html#object.__len__" rel="noreferrer">docs</a>:  

<strong>`object.__len__(self)`</strong>  

<blockquote>
  <p>Called to implement the built-in function `len()`. Should return the length of the object, an integer >= 0. Also, an object that doesn’t
  define a `__nonzero__()` [in Python 2 or `__bool__()` in Python 3] method and whose `__len__()` method returns zero
  is considered to be false in a Boolean context.</p>
</blockquote>

And we can also see that `__len__` is a method of lists:  

```python
items.__len__()
```

returns 3.  

<h5>Builtin types you can get the `len` (length) of</h2>

And in fact we see we can get this information for all of the described types:  

```python
>>> all(hasattr(cls, '__len__') for cls in (str, bytes, tuple, list, 
                                            xrange, dict, set, frozenset))
True
```

<h5>Do not use `len` to test for an empty or nonempty list</h2>

To test for a specific length, of course, simply test for equality:  

```python
if len(items) == required_length:
    ...
```

But there's a special case for testing for a zero length list or the inverse. In that case, do not test for equality.  

Also, do not do:  

```python
if len(items): 
    ...
```

Instead, simply do:  

```python
if items:     # Then we have some items, not empty!
    ...
```

or  

```python
if not items: # Then we have an empty list!
    ...
```

I <a href="https://stackoverflow.com/questions/53513/best-way-to-check-if-a-list-is-empty/45778282#45778282">explain why here</a> but in short, `if items` or `if not items` is both more readable and more performant.  

#### Answer 3 (score 72)
While this may not be useful due to the fact that it'd make a lot more sense as being "out of the box" functionality, a fairly simple hack would be to build a class with a `length` property:  

```python
class slist(list):
    @property
    def length(self):
        return len(self)
```

You can use it like so:  

```python
>>> l = slist(range(10))
>>> l.length
10
>>> print l
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

Essentially, it's exactly identical to a list object, with the added benefit of having an OOP-friendly `length` property.  

As always, your mileage may vary.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: Using global variables in a function (score [3043289](https://stackoverflow.com/q/423379) in 2018)

#### Question
How can I create or use a global variable in a function?  

If I create a global variable in one function, how can I use that global variable in another function? Do I need to store the global variable in a local variable of the function which needs its access?  

#### Answer accepted (score 4017)
You can use a global variable in other functions by declaring it as `global` in each function that assigns to it:  

```python
globvar = 0

def set_globvar_to_one():
    global globvar    # Needed to modify global copy of globvar
    globvar = 1

def print_globvar():
    print(globvar)     # No need for global declaration to read value of globvar

set_globvar_to_one()
print_globvar()       # Prints 1
```

I imagine the reason for it is that, since global variables are so dangerous, Python wants to make sure that you really know that's what you're playing with by explicitly requiring the `global` keyword.  

See other answers if you want to share a global variable across modules.  

#### Answer 2 (score 736)
If I'm understanding your situation correctly, what you're seeing is the result of how Python handles local (function) and global (module) namespaces.  

Say you've got a module like this:  

```python
# sample.py
myGlobal = 5

def func1():
    myGlobal = 42

def func2():
    print myGlobal

func1()
func2()
```

You might expecting this to print 42, but instead it prints 5.  As has already been mentioned, if you add a '`global`' declaration to `func1()`, then `func2()` will print 42.  

```python
def func1():
    global myGlobal
    myGlobal = 42
```

What's going on here is that Python assumes that any name that is <em>assigned to</em>, anywhere within a function, is local to that function unless explicitly told otherwise.  If it is only <em>reading</em> from a name, and the name doesn't exist locally, it will try to look up the name in any containing scopes (e.g. the module's global scope).  

When you assign 42 to the name `myGlobal`, therefore, Python creates a local variable that shadows the global variable of the same name.  That local goes out of scope and is <a href="http://www.digi.com/wiki/developer/index.php/Python_Garbage_Collection" rel="noreferrer">garbage-collected</a> when `func1()` returns; meanwhile, `func2()` can never see anything other than the (unmodified) global name.  Note that this namespace decision happens at compile time, not at runtime -- if you were to read the value of `myGlobal` inside `func1()` before you assign to it, you'd get an `UnboundLocalError`, because Python has already decided that it must be a local variable but it has not had any value associated with it yet.  But by using the '`global`' statement, you tell Python that it should look elsewhere for the name instead of assigning to it locally.  

(I believe that this behavior originated largely through an optimization of local namespaces -- without this behavior,  Python's VM would need to perform at least three name lookups each time a new name is assigned to inside a function (to ensure that the name didn't already exist at module/builtin level), which would significantly slow down a very common operation.)  

#### Answer 3 (score 201)
You may want to explore the notion of <a href="http://docs.python.org/reference/datamodel.html" rel="noreferrer">namespaces</a>. In Python, the <a href="http://docs.python.org/tutorial/modules.html" rel="noreferrer">module</a> is the natural place for <em>global</em> data:  

<blockquote>
  Each module has its own private symbol table, which is used as the global symbol table by all functions defined in the module. Thus, the author of a module can use global variables in the module without worrying about accidental clashes with a user’s global variables. On the other hand, if you know what you are doing you can touch a module’s global variables with the same notation used to refer to its functions, `modname.itemname`.  
</blockquote>

A specific use of global-in-a-module is described here - <a href="http://effbot.org/pyfaq/how-do-i-share-global-variables-across-modules.htm" rel="noreferrer">How do I share global variables across modules?</a>, and for completeness the contents are shared here:  

<blockquote>
  The canonical way to share information across modules within a single program is to create a special configuration module (often called <strong>config</strong> or <strong>cfg</strong>). Just import the configuration module in all modules of your application; the module then becomes available as a global name. Because there is only one instance of each module, any changes made to the module object get reflected everywhere. For example:    
  
  File: config.py  

```python
x = 0   # Default value of the 'x' configuration setting
```
  
  File: mod.py  

```python
import config
config.x = 1
```
  
  File: main.py  

```python
import config
import mod
print config.x
```
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: How to get the current time in Python (score [3001470](https://stackoverflow.com/q/415511) in 2018)

#### Question
What is the module/method used to get the current time?  

#### Answer accepted (score 2718)
Use:  

```python
>>> import datetime
>>> datetime.datetime.now()
datetime.datetime(2009, 1, 6, 15, 8, 24, 78915)

>>> print(datetime.datetime.now())
2018-07-29 09:17:13.812189
```

And just the time:  

```python
>>> datetime.datetime.now().time()
datetime.time(15, 8, 24, 78915)

>>> print(datetime.datetime.now().time())
09:17:51.914526
```

See <a href="https://docs.python.org/3/library/datetime.html" rel="noreferrer"><strong>the documentation</strong></a> for more information.  

To save typing, you can import the `datetime` object from the `datetime` module:  

```python
>>> from datetime import datetime
```

Then remove the leading `datetime.` from all of the above.  

#### Answer 2 (score 891)
You can use <a href="http://docs.python.org/3.3/library/time.html?highlight=time.strftime#time.strftime" rel="noreferrer">`time.strftime()`</a>:      

```python
>>> from time import gmtime, strftime
>>> strftime("%Y-%m-%d %H:%M:%S", gmtime())
'2009-01-05 22:14:39'
```

#### Answer 3 (score 531)
```python
from datetime import datetime
datetime.now().strftime('%Y-%m-%d %H:%M:%S')
```

For this example, the output will be like this: `'2013-09-18 11:16:32'`  

Here is the list of <a href="https://docs.python.org/3/library/time.html#time.strftime" rel="noreferrer">`strftime` directives</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: How do I install pip on Windows? (score [2887828](https://stackoverflow.com/q/4750806) in 2017)

#### Question
<a href="https://pip.pypa.io/en/stable/" rel="noreferrer">`pip`</a> is a replacement for <a href="http://setuptools.readthedocs.io/en/latest/easy_install.html" rel="noreferrer">`easy_install`</a>. But should I install `pip` using `easy_install` on Windows?  Is there a better way?  

#### Answer accepted (score 1779)
<h5>Python 2.7.9+ and 3.4+</h2>

Good news! <a href="https://docs.python.org/3/whatsnew/3.4.html" rel="noreferrer">Python 3.4</a> (released March 2014) and <a href="https://docs.python.org/2/whatsnew/2.7.html#pep-477-backport-ensurepip-pep-453-to-python-2-7" rel="noreferrer">Python 2.7.9</a> (released December 2014) ship with Pip. This is the best feature of any Python release. It makes the community's wealth of libraries accessible to everyone. Newbies are no longer excluded from using community libraries by the prohibitive difficulty of setup. In shipping with a package manager, Python joins <a href="http://en.wikipedia.org/wiki/Ruby_%28programming_language%29" rel="noreferrer">Ruby</a>, <a href="http://en.wikipedia.org/wiki/Node.js" rel="noreferrer">Node.js</a>, <a href="http://en.wikipedia.org/wiki/Haskell_%28programming_language%29" rel="noreferrer">Haskell</a>, <a href="http://en.wikipedia.org/wiki/Perl" rel="noreferrer">Perl</a>, <a href="http://en.wikipedia.org/wiki/Go_%28programming_language%29" rel="noreferrer">Go</a>&mdash;almost every other contemporary language with a majority open-source community. Thank you, Python.  

If you do find that pip is not available when using Python 3.4+ or Python 2.7.9+, simply execute e.g.:  

```python
py -3 -m ensurepip
```

Of course, that doesn't mean Python packaging is problem solved. The experience remains frustrating. I discuss this <a href="https://stackoverflow.com/questions/2436731/does-python-have-a-package-module-management-system/13445719#13445719">in the Stack Overflow question <em>Does Python have a package/module management system?</em></a>.  

And, alas for everyone using Python 2.7.8 or earlier (a sizable portion of the community). There's no plan to ship Pip to you. Manual instructions follow.  

<h5>Python 2 ≤ 2.7.8 and Python 3 ≤ 3.3</h2>

Flying in the face of its <a href="http://www.python.org/about/" rel="noreferrer">'batteries included'</a> motto, Python ships without a package manager. To make matters worse, Pip was&mdash;until recently&mdash;ironically difficult to install.  

<h5>Official instructions</h3>

Per <a href="https://pip.pypa.io/en/stable/installing/#do-i-need-to-install-pip" rel="noreferrer">https://pip.pypa.io/en/stable/installing/#do-i-need-to-install-pip</a>:  

Download <a href="https://bootstrap.pypa.io/get-pip.py" rel="noreferrer">`get-pip.py`</a>, being careful to save it as a `.py` file rather than `.txt`. Then, run it from the command prompt:  

```python
python get-pip.py
```

You possibly need an administrator command prompt to do this. Follow <em><a href="http://technet.microsoft.com/en-us/library/cc947813(v=ws.10).aspx" rel="noreferrer">Start a Command Prompt as an Administrator</a></em> (Microsoft TechNet).  

This installs the pip package, which (in Windows) contains ...\Scripts\pip.exe that path must be in PATH environment variable to use pip from the command line (see the second part of 'Alternative Instructions' for adding it to your PATH,  

<h5>Alternative instructions</h3>

The official documentation tells users to install Pip and each of its dependencies from source. That's tedious for the experienced and prohibitively difficult for newbies.  

For our sake, Christoph Gohlke prepares Windows installers (`.msi`) for popular Python packages. He builds installers for all Python versions, both 32 and 64 bit. You need to:  

<ol>
<li><a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/#setuptools" rel="noreferrer">Install setuptools</a></li>
<li><a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/#pip" rel="noreferrer">Install pip</a></li>
</ol>

For me, this installed Pip at `C:\Python27\Scripts\pip.exe`. Find `pip.exe` on your computer, then add its folder (for example, `C:\Python27\Scripts`) to your path (Start / Edit environment variables). Now you should be able to run `pip` from the command line. Try installing a package:  

```python
pip install httpie
```

There you go (hopefully)! Solutions for common problems are given below:  

<h5>Proxy problems</h3>

If you work in an office, you might be behind an HTTP proxy. If so, set the environment variables <a href="http://docs.python.org/2/library/urllib.html" rel="noreferrer">`http_proxy` and `https_proxy`</a>. Most Python applications (and other free software) respect these. Example syntax:  

```python
http://proxy_url:port
http://username:password@proxy_url:port
```

If you're really unlucky, your proxy might be a Microsoft <a href="https://en.wikipedia.org/wiki/NT_LAN_Manager" rel="noreferrer">NTLM</a> proxy. Free software can't cope. The only solution is to install a free software friendly proxy that forwards to the nasty proxy. <a href="http://cntlm.sourceforge.net/" rel="noreferrer">http://cntlm.sourceforge.net/</a>  

<h5>Unable to find vcvarsall.bat</h3>

Python modules can be partly written in C or C++. Pip tries to compile from source. If you don't have a C/C++ compiler installed and configured, you'll see this cryptic error message.  

<blockquote>
  Error: Unable to find vcvarsall.bat  
</blockquote>

You can fix that by <a href="https://stackoverflow.com/questions/2817869/error-unable-to-find-vcvarsall-bat">installing a C++ compiler</a> such as <a href="http://en.wikipedia.org/wiki/MinGW" rel="noreferrer">MinGW</a> or <a href="http://en.wikipedia.org/wiki/Visual_C%2B%2B#32-bit_versions" rel="noreferrer">Visual C++</a>. Microsoft actually ships one specifically for use with Python. Or try <em><a href="http://aka.ms/vcpython27" rel="noreferrer">Microsoft Visual C++ Compiler for Python 2.7</a></em>.  

Often though it's easier to check <a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/" rel="noreferrer">Christoph's site</a> for your package.  

#### Answer 2 (score 296)
<p><s>-- <strong>Outdated</strong> -- use distribute, not setuptools as described here. --</s><br>
-- <strong>Outdated #2</strong> -- use setuptools as distribute is deprecated.</p>

As you mentioned pip doesn't include an independent installer, but you can install it with its predecessor easy_install.  

So:  

<ol>
<li>Download the last pip version from here: <a href="http://pypi.python.org/pypi/pip#downloads" rel="noreferrer">http://pypi.python.org/pypi/pip#downloads</a></li>
<li>Uncompress it</li>
<li>Download the last easy installer for Windows: (<strong>download the .exe at the bottom of <a href="http://pypi.python.org/pypi/setuptools" rel="noreferrer">http://pypi.python.org/pypi/setuptools</a></strong> ). Install it.</li>
<li>copy the uncompressed pip folder <strong>content</strong> into `C:\Python2x\` folder (don't copy the whole folder into it, just the content), because python command doesn't work outside `C:\Python2x` folder and then run:  `python setup.py install`</li>
<li>Add your python `C:\Python2x\Scripts` to the path</li>
</ol>

You are done.   

Now you can use `pip install package` to easily install packages as in Linux :)  

#### Answer 3 (score 215)
<strong>2014 UPDATE:</strong>  

1) If you have installed Python 3.4 or later, pip is included with Python and should already be working on your system.  

2) If you are running a version below Python 3.4 or if pip was not installed with Python 3.4 for some reason, then you'd probably use pip's official installation script `get-pip.py`. The pip installer now grabs setuptools for you, and works regardless of architecture (32-bit or 64-bit).  

The installation <a href="http://www.pip-installer.org/en/latest/installing.html" rel="noreferrer">instructions are detailed here</a> and involve:  

<blockquote>
  To install or upgrade pip, securely download <a href="https://raw.github.com/pypa/pip/master/contrib/get-pip.py" rel="noreferrer">get-pip.py</a>.  
  
  Then run the following (which may require administrator access):  
</blockquote>

```python
python get-pip.py
```

<blockquote>
  To upgrade an existing setuptools (or distribute), run `pip install -U setuptools`  
</blockquote>

I'll leave the two sets of old instructions below for posterity.  

<strong>OLD Answers:</strong>  

For Windows editions of the <strong>64 bit</strong> variety - 64-bit Windows + Python used to require a separate installation method due to ez_setup, but I've tested the new distribute method on 64-bit Windows running 32-bit Python and 64-bit Python, and you can now use the same method for all versions of Windows/Python 2.7X:  

<strong>OLD Method 2</strong> using <a href="https://pypi.python.org/pypi/distribute" rel="noreferrer">distribute</a>:  

<ol>
<li>Download <a href="http://python-distribute.org/distribute_setup.py" rel="noreferrer">distribute</a> - I threw mine in `C:\Python27\Scripts` (feel free to create a `Scripts` directory if it doesn't exist.</li>
<li>Open up a command prompt (on Windows you should check out <a href="http://code.google.com/p/conemu-maximus5/" rel="noreferrer">conemu2</a> if you don't use <a href="http://en.wikipedia.org/wiki/Windows_PowerShell" rel="noreferrer">PowerShell</a>) and change (`cd`) to the directory you've downloaded `distribute_setup.py` to.</li>
<li>Run distribute_setup: `python distribute_setup.py` (This will not work if your python installation directory is not added to your path - <a href="https://stackoverflow.com/a/6318188/705198">go here for help</a>)</li>
<li>Change the current directory to the `Scripts` directory for your Python installation (`C:\Python27\Scripts`) or add that directory, as well as the Python base installation directory to your %PATH% environment variable.</li>
<li>Install pip using the newly installed setuptools: `easy_install pip`</li>
</ol>

The last step will not work unless you're either in the directory `easy_install.exe` is located in (C:\Python27\Scripts would be the default for Python 2.7), or you have that directory added to your path.  

<strong>OLD Method 1</strong> using ez_setup:  

<a href="http://pypi.python.org/pypi/setuptools#windows" rel="noreferrer">from the setuptools page</a> --  

<blockquote>
  Download <a href="http://peak.telecommunity.com/dist/ez_setup.py" rel="noreferrer">ez_setup.py</a> and run it; it will download the appropriate .egg file and install it for you. (Currently, the provided .exe installer does not support 64-bit versions of Python for Windows, due to a distutils installer compatibility issue.  
</blockquote>

After this, you may continue with:  

<ol start="2">
<li>Add `c:\Python2x\Scripts` to the Windows path (replace the `x` in `Python2x` with the actual version number you have installed)</li>
<li>Open a new (!) DOS prompt. From there run `easy_install pip`</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: How can I make a time delay in Python? (score [2839107](https://stackoverflow.com/q/510348) in 2018)

#### Question
I would like to know how to put a time delay in a Python script.  

#### Answer 2 (score 2835)
```python
import time
time.sleep(5)   # Delays for 5 seconds. You can also use a float value.
```

Here is another example where something is run approximately once a minute:  

```python
import time
while True:
    print("This prints once a minute.")
    time.sleep(60) # Delay for 1 minute (60 seconds).
```

#### Answer 3 (score 736)
You can use the <a href="https://docs.python.org/library/time.html#time.sleep" rel="noreferrer">`sleep()` function in the `time` module</a>. It can take a float argument for sub-second resolution.  

```python
from time import sleep
sleep(0.1) # Time in seconds
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: What is the difference between Python's list methods append and extend? (score [2798324](https://stackoverflow.com/q/252703) in 2019)

#### Question
What's the difference between the list methods `append()` and `extend()`?  

#### Answer accepted (score 4958)
<a href="https://docs.python.org/3/library/stdtypes.html#mutable-sequence-types" rel="noreferrer">`append`</a>: Appends object at the end.  

```python
x = [1, 2, 3]
x.append([4, 5])
print (x)
```

gives you: `[1, 2, 3, [4, 5]]`  

<hr>

<a href="https://docs.python.org/3/library/stdtypes.html#mutable-sequence-types" rel="noreferrer">`extend`</a>: Extends list by appending elements from the iterable.  

```python
x = [1, 2, 3]
x.extend([4, 5])
print (x)
```

gives you: `[1, 2, 3, 4, 5]`  

#### Answer 2 (score 606)
`append` adds an element to a list, and `extend` concatenates the first list with another list (or another iterable, not necessarily a list.)  

```python
>>> li = ['a', 'b', 'mpilgrim', 'z', 'example']
>>> li
['a', 'b', 'mpilgrim', 'z', 'example']

>>> li.append("new")
>>> li
['a', 'b', 'mpilgrim', 'z', 'example', 'new']

>>> li.append(["new", 2])
>>> li
['a', 'b', 'mpilgrim', 'z', 'example', 'new', ['new', 2]]

>>> li.insert(2, "new")
>>> li
['a', 'b', 'new', 'mpilgrim', 'z', 'example', 'new', ['new', 2]]

>>> li.extend(["two", "elements"])
>>> li
['a', 'b', 'new', 'mpilgrim', 'z', 'example', 'new', ['new', 2], 'two', 'elements']
```

#### Answer 3 (score 437)
<blockquote>
  <h5>What is the difference between the list methods append and extend?</h2>
</blockquote>

<ul>
<li>`append` adds its argument as a single element to the end of a list. The length of the list itself will increase by one.</li>
<li>`extend` iterates over its argument adding each element to the list, extending the list. The length of the list will increase by however many elements were in the iterable argument.</li>
</ul>

<h5>`append`</h2>

The `list.append` method appends an object to the end of the list.  

```python
my_list.append(object) 
```

Whatever the object is, whether a number, a string, another list, or something else, it gets added onto the end of `my_list` as a single entry on the list.   

```python
>>> my_list
['foo', 'bar']
>>> my_list.append('baz')
>>> my_list
['foo', 'bar', 'baz']
```

So keep in mind that a list is an object. If you append another list onto a list, the first list will be a single object at the end of the list (which may not be what you want):  

```python
>>> another_list = [1, 2, 3]
>>> my_list.append(another_list)
>>> my_list
['foo', 'bar', 'baz', [1, 2, 3]]
                     #^^^^^^^^^--- single item at the end of the list.
```

<h5>`extend`</h2>

The `list.extend` method extends a list by appending elements from an iterable:  

```python
my_list.extend(iterable)
```

So with extend, each element of the iterable gets appended onto the list. For example:  

```python
>>> my_list
['foo', 'bar']
>>> another_list = [1, 2, 3]
>>> my_list.extend(another_list)
>>> my_list
['foo', 'bar', 1, 2, 3]
```

Keep in mind that a string is an iterable, so if you extend a list with a string, you'll append each character as you iterate over the string (which may not be what you want):  

```python
>>> my_list.extend('baz')
>>> my_list
['foo', 'bar', 1, 2, 3, 'b', 'a', 'z']
```

<h5>Operator Overload, `__add__` (`+`) and `__iadd__` (`+=`)</h2>

Both `+` and `+=` operators are defined for `list`. They are semantically similar to extend.  

`my_list + another_list` creates a third list in memory, so you can return the result of it, but it requires that the second iterable be a list.   

`my_list += another_list` modifies the list in-place (it <em>is</em> the in-place operator, and lists are mutable objects, as we've seen) so it does not create a new list. It also works like extend, in that the second iterable can be any kind of iterable.  

Don't get confused - `my_list = my_list + another_list` is not equivalent to `+=` - it gives you a brand new list assigned to my_list.  

<h5>Time Complexity</h2>

Append has <a href="https://wiki.python.org/moin/TimeComplexity" rel="noreferrer">constant time complexity</a>, O(1).   

Extend has time complexity, O(k).   

Iterating through the multiple calls to `append` adds to the complexity, making it equivalent to that of extend, and since extend's iteration is implemented in C, it will always be faster if you intend to append successive items from an iterable onto a list.  

<h5>Performance</h2>

You may wonder what is more performant, since append can be used to achieve the same outcome as extend. The following functions do the same thing:  

```python
def append(alist, iterable):
    for item in iterable:
        alist.append(item)

def extend(alist, iterable):
    alist.extend(iterable)
```

So let's time them:  

```python
import timeit

>>> min(timeit.repeat(lambda: append([], "abcdefghijklmnopqrstuvwxyz")))
2.867846965789795
>>> min(timeit.repeat(lambda: extend([], "abcdefghijklmnopqrstuvwxyz")))
0.8060121536254883
```

<h5>Addressing a comment on timings</h3>

A commenter said:  

<blockquote>
  Perfect answer, I just miss the timing of comparing adding only one element  
</blockquote>

Do the semantically correct thing. If you want to append all elements in an iterable, use `extend`. If you're just adding one element, use `append`.  

Ok, so let's create an experiment to see how this works out in time:  

```python
def append_one(a_list, element):
    a_list.append(element)

def extend_one(a_list, element):
    """creating a new list is semantically the most direct
    way to create an iterable to give to extend"""
    a_list.extend([element])

import timeit
```

And we see that going out of our way to create an iterable just to use extend is a (minor) waste of time:  

```python
>>> min(timeit.repeat(lambda: append_one([], 0)))
0.2082819009956438
>>> min(timeit.repeat(lambda: extend_one([], 0)))
0.2397019260097295
```

We learn from this that there's nothing gained from using `extend` when we have only <em>one</em> element to append.  

Also, these timings are not that important. I am just showing them to make the point that, in Python, doing the semantically correct thing is doing things the <em>Right</em> Way™.  

It's conceivable that you might test timings on two comparable operations and get an ambiguous or inverse result. Just focus on doing the semantically correct thing.  

<h5>Conclusion</h2>

We see that `extend` is semantically clearer, and that it can run much faster than `append`, <em>when you intend to append each element in an iterable to a list.</em>   

If you only have a single element (not in an iterable) to add to the list, use `append`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: Limiting floats to two decimal points (score [2780835](https://stackoverflow.com/q/455612) in 2017)

#### Question
I want `a` to be rounded to <em>13.95</em>.  

```python
>>> a
13.949999999999999
>>> round(a, 2)
13.949999999999999
```

The <a href="https://docs.python.org/2/library/functions.html#round" rel="noreferrer">`round`</a> function does not work the way I expected.  

#### Answer 2 (score 1484)
You are running into the <a href="https://en.wikipedia.org/wiki/IEEE_754" rel="noreferrer">old problem</a> with floating point numbers that not all numbers can be represented exactly. The command line is just showing you the full floating point form from memory.  

With floating point representation, your rounded version is the same number. Since computers are binary, they store floating point numbers as an integer and then divide it by a power of two so 13.95 will be represented in a similar fashion to 125650429603636838/(2**53).  

Double precision numbers have 53 bits (16 digits) of precision and regular floats have 24 bits (8 digits) of precision. The <a href="http://docs.python.org/tutorial/floatingpoint.html" rel="noreferrer">floating point type in Python uses double precision</a> to store the values.  

For example,  

```python
  >>> 125650429603636838/(2**53)
  13.949999999999999

  >>> 234042163/(2**24)
  13.949999988079071

  >>> a=13.946
  >>> print(a)
  13.946
  >>> print("%.2f" % a)
  13.95
  >>> round(a,2)
  13.949999999999999
  >>> print("%.2f" % round(a,2))
  13.95
  >>> print("{0:.2f}".format(a))
  13.95
  >>> print("{0:.2f}".format(round(a,2)))
  13.95
  >>> print("{0:.15f}".format(round(a,2)))
  13.949999999999999
```

If you are after only two decimal places (to display a currency value, for example), then you have a couple of better choices:  

<ol>
<li>Use integers and store values in cents, not dollars and then divide by 100 to convert to dollars.</li>
<li>Or use a fixed point number like <a href="https://docs.python.org/library/decimal.html" rel="noreferrer">decimal</a>.</li>
</ol>

#### Answer 3 (score 525)
There are new format specifications, <a href="http://docs.python.org/library/string.html#format-specification-mini-language" rel="noreferrer"><strong>String Format Specification Mini-Language</strong></a>:  

You can do the same as:  

```python
"{0:.2f}".format(13.949999999999999)
```

<strong>Note</strong> that the above returns a string. In order to get as float, simply wrap with `float(...)`:  

```python
float("{0:.2f}".format(13.949999999999999))
```

<strong>Note</strong> that wrapping with `float()` doesn't change anything:  

```python
>>> x = 13.949999999999999999
>>> x
13.95
>>> g = float("{0:.2f}".format(x))
>>> g
13.95
>>> x == g
True
>>> h = round(x, 2)
>>> h
13.95
>>> x == h
True
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Converting string into datetime (score [2674955](https://stackoverflow.com/q/466345) in 2019)

#### Question
I've got a huge list of date-times like this as strings:  

```python
Jun 1 2005  1:33PM
Aug 28 1999 12:00AM
```

I'm going to be shoving these back into proper datetime fields in a database so I need to magic them into real datetime objects.   

This is going through Django's ORM so I can't use SQL to do the conversion on insert.  

#### Answer accepted (score 3174)
`datetime.strptime` is the main routine for parsing strings into datetimes. It can handle all sorts of formats, with the format determined by a format string you give it:  

```python
from datetime import datetime

datetime_object = datetime.strptime('Jun 1 2005  1:33PM', '%b %d %Y %I:%M%p')
```

The resulting `datetime` object is timezone-naive.  

Links:  

<ul>
<li><p>Python documentation for `strptime`: <a href="https://docs.python.org/2/library/datetime.html#datetime.datetime.strptime" rel="noreferrer" title="datetime.datetime.strptime">Python 2</a>, <a href="https://docs.python.org/3/library/datetime.html#datetime.datetime.strptime" rel="noreferrer">Python 3</a></p></li>
<li><p>Python documentation for `strptime`/`strftime` format strings: <a href="https://docs.python.org/2/library/datetime.html#strftime-and-strptime-behavior" rel="noreferrer" title="strftime-and-strptime-behavior">Python 2</a>, <a href="https://docs.python.org/3/library/datetime.html#strftime-and-strptime-behavior" rel="noreferrer">Python 3</a></p></li>
<li><p><a href="http://strftime.org/" rel="noreferrer">strftime.org</a> is also a really nice reference for strftime</p></li>
</ul>

Notes:  

<ul>
<li>`strptime` = "string parse time"</li>
<li>`strftime` = "string format time"</li>
<li>Pronounce it out loud today &amp; you won't have to search for it again in 6 months.</li>
</ul>

#### Answer 2 (score 757)
Use the third party <a href="https://dateutil.readthedocs.io" rel="nofollow noreferrer">dateutil</a> library:  

```python
from dateutil import parser
parser.parse("Aug 28 1999 12:00AM")  # datetime.datetime(1999, 8, 28, 0, 0)
```

It can handle most date formats, including the one you need to parse. It's more convenient than `strptime` as it can guess the correct format most of the time.  

It's very useful for writing tests, where readability is more important than performance.  

You can install it with:  

```python
pip install python-dateutil
```

#### Answer 3 (score 477)
Check out <a href="http://docs.python.org/3/library/time.html#time.strptime" rel="noreferrer">strptime</a> in the <a href="http://docs.python.org/3/library/time.html" rel="noreferrer">time</a> module.  It is the inverse of <a href="http://docs.python.org/3/library/time.html#time.strftime" rel="noreferrer">strftime</a>.  

```python
$ python
>>> import time
>>> time.strptime('Jun 1 2005  1:33PM', '%b %d %Y %I:%M%p')
time.struct_time(tm_year=2005, tm_mon=6, tm_mday=1,
                 tm_hour=13, tm_min=33, tm_sec=0,
                 tm_wday=2, tm_yday=152, tm_isdst=-1)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: How do I get a substring of a string in Python? (score [2671603](https://stackoverflow.com/q/663171) in 2019)

#### Question
Is there a way to substring a string in Python, to get a new string from the third character to the end of the string?  

Maybe like `myString[2:end]`?  

If leaving the second part means 'till the end', and if you leave the first part, does it start from the start?  

#### Answer accepted (score 2939)
```python
>>> x = "Hello World!"
>>> x[2:]
'llo World!'
>>> x[:2]
'He'
>>> x[:-2]
'Hello Worl'
>>> x[-2:]
'd!'
>>> x[2:-2]
'llo Worl'
```

Python calls this concept "slicing" and it works on more than just strings. Take a look <a href="https://stackoverflow.com/questions/509211/good-primer-for-python-slice-notation">here</a> for a comprehensive introduction.  

#### Answer 2 (score 361)
Just for completeness as nobody else has mentioned it.  The third parameter to an array slice is a step.  So reversing a string is as simple as:  

```python
some_string[::-1]
```

Or selecting alternate characters would be:  

```python
"H-e-l-l-o- -W-o-r-l-d"[::2] # outputs "Hello World"
```

The ability to step forwards and backwards through the string maintains consistency with being able to array slice from the start or end.  

#### Answer 3 (score 108)
Substr() normally (i.e. PHP and Perl) works this way:   

```python
s = Substr(s, beginning, LENGTH)
```

So the parameters are `beginning` and `LENGTH`.  

But Python's behaviour is different; it expects beginning and one after END (!). <strong>This is difficult to spot by beginners.</strong> So the correct replacement for Substr(s, beginning, LENGTH) is  

```python
s = s[ beginning : beginning + LENGTH]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: Find current directory and file's directory (score [2648748](https://stackoverflow.com/q/5137497) in 2016)

#### Question
In Python, what commands can I use to find:  

<ol>
<li>the current directory (where I was in the terminal when I ran the Python script), and</li>
<li>where the file I am executing is?</li>
</ol>

#### Answer accepted (score 3058)
To get the full path to the directory a Python file is contained in, write this in that file:  

```python
import os 
dir_path = os.path.dirname(os.path.realpath(__file__))
```

(Note that the incantation above won't work if you've already used `os.chdir()` to change your current working directory, since the value of the `__file__` constant is relative to the current working directory and is not changed by an `os.chdir()` call.)  

<hr>

To get the current working directory use   

```python
import os
cwd = os.getcwd()
```

<hr>

Documentation references for the modules, constants and functions used above:  

<ul>
<li>The <a href="https://docs.python.org/library/os.html">`os`</a> and <a href="https://docs.python.org/library/os.path.html#module-os.path">`os.path`</a> modules.</li>
<li>The <a href="https://docs.python.org/reference/datamodel.html">`__file__`</a> constant</li>
<li><a href="https://docs.python.org/library/os.path.html#os.path.realpath">`os.path.realpath(path)`</a> (returns <em>"the canonical path of the specified filename, eliminating any symbolic links encountered in the path"</em>)</li>
<li><a href="https://docs.python.org/library/os.path.html#os.path.dirname">`os.path.dirname(path)`</a> (returns <em>"the directory name of pathname `path`"</em>)</li>
<li><a href="https://docs.python.org/library/os.html#os.getcwd">`os.getcwd()`</a> (returns <em>"a string representing the current working directory"</em>)</li>
<li><a href="https://docs.python.org/library/os.html#os.chdir">`os.chdir(path)`</a> (<em>"change the current working directory to `path`"</em>)</li>
</ul>

#### Answer 2 (score 308)
Current Working Directory:  <a href="https://docs.python.org/2/library/os.html#os.getcwd" rel="noreferrer">`os.getcwd()`</a>  

And the <a href="http://docs.python.org/reference/datamodel.html" rel="noreferrer">`__file__` attribute</a>  can help you find out where the file you are executing is located.  This SO post explains everything:  <a href="https://stackoverflow.com/questions/2632199/how-do-i-get-the-path-of-the-current-executed-file-in-python">How do I get the path of the current executed file in Python?</a>  

#### Answer 3 (score 260)
You may find this useful as a reference:  

```python
import os

print("Path at terminal when executing this file")
print(os.getcwd() + "\n")

print("This file path, relative to os.getcwd()")
print(__file__ + "\n")

print("This file full path (following symlinks)")
full_path = os.path.realpath(__file__)
print(full_path + "\n")

print("This file directory and name")
path, filename = os.path.split(full_path)
print(path + ' --> ' + filename + "\n")

print("This file directory only")
print(os.path.dirname(full_path))
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: Why can't Python parse this JSON data? (score [2591542](https://stackoverflow.com/q/2835559) in 2019)

#### Question
I have this JSON in a file:  

```python
{
    "maps": [
        {
            "id": "blabla",
            "iscategorical": "0"
        },
        {
            "id": "blabla",
            "iscategorical": "0"
        }
    ],
    "masks": [
        "id": "valore"
    ],
    "om_points": "value",
    "parameters": [
        "id": "valore"
    ]
}
```

I wrote this script to print all of the JSON data:  

```python
import json
from pprint import pprint

with open('data.json') as f:
    data = json.load(f)

pprint(data)
```

This program raises an exception, though:  

```python
Traceback (most recent call last):
  File "<pyshell#1>", line 5, in <module>
    data = json.load(f)
  File "/usr/lib/python3.5/json/__init__.py", line 319, in loads
    return _default_decoder.decode(s)
  File "/usr/lib/python3.5/json/decoder.py", line 339, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib/python3.5/json/decoder.py", line 355, in raw_decode
    obj, end = self.scan_once(s, idx)
json.decoder.JSONDecodeError: Expecting ',' delimiter: line 13 column 13 (char 213)
```

How can I parse the JSON and extract its values?  

#### Answer accepted (score 2081)
Your data is not valid <a href="https://www.json.org/" rel="noreferrer">JSON</a> format. You have `[]` when you should have `{}`:  

<ul>
<li>`[]` are for JSON arrays, which are called `list` in Python</li>
<li>`{}` are for JSON objects, which are called `dict` in Python</li>
</ul>

Here's how your JSON file should look:  

```python
{
    "maps": [
        {
            "id": "blabla",
            "iscategorical": "0"
        },
        {
            "id": "blabla",
            "iscategorical": "0"
        }
    ],
    "masks": {
        "id": "valore"
    },
    "om_points": "value",
    "parameters": {
        "id": "valore"
    }
}
```

Then you can use your code:  

```python
import json
from pprint import pprint

with open('data.json') as f:
    data = json.load(f)

pprint(data)
```

With data, you can now also find values like so:  

```python
data["maps"][0]["id"]
data["masks"]["id"]
data["om_points"]
```

Try those out and see if it starts to make sense.  

#### Answer 2 (score 304)
Your `data.json` should look like this:  

```python
{
 "maps":[
         {"id":"blabla","iscategorical":"0"},
         {"id":"blabla","iscategorical":"0"}
        ],
"masks":
         {"id":"valore"},
"om_points":"value",
"parameters":
         {"id":"valore"}
}
```

Your code should be:  

```python
import json
from pprint import pprint

with open('data.json') as data_file:    
    data = json.load(data_file)
pprint(data)
```

Note that this only works in Python 2.6 and up, as it depends upon the <a href="http://docs.python.org/2/reference/compound_stmts.html#the-with-statement" rel="noreferrer">`with`-statement</a>. In Python 2.5 use `from __future__ import with_statement`, in Python &lt;= 2.4, see <a href="https://stackoverflow.com/a/2835672/906658">Justin Peel's answer</a>, which this answer is based upon.  

You can now also access single values like this:  

```python
data["maps"][0]["id"]  # will return 'blabla'
data["masks"]["id"]    # will return 'valore'
data["om_points"]      # will return 'value'
```

#### Answer 3 (score 64)
<a href="https://stackoverflow.com/a/2835672/906658">Justin Peel's answer</a> is really helpful, but if you are using Python 3 reading JSON should be done like this:  

```python
with open('data.json', encoding='utf-8') as data_file:
    data = json.loads(data_file.read())
```

Note: use `json.loads` instead of `json.load`. In Python 3, `json.loads` takes a string parameter. `json.load` takes a file-like object parameter. `data_file.read()` returns a string object.  

To be honest, I don't think it's a problem to load all json data into memory most cases.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: What does if __name__ == "__main__": do? (score [2531456](https://stackoverflow.com/q/419163) in 2018)

#### Question
What does the `if __name__ == "__main__":` do?  

```python
# Threading example
import time, thread

def myfunction(string, sleeptime, lock, *args):
    while True:
        lock.acquire()
        time.sleep(sleeptime)
        lock.release()
        time.sleep(sleeptime)

if __name__ == "__main__":
    lock = thread.allocate_lock()
    thread.start_new_thread(myfunction, ("Thread #: 1", 2, lock))
    thread.start_new_thread(myfunction, ("Thread #: 2", 2, lock))
```

#### Answer accepted (score 5891)
Whenever the Python interpreter reads a source file, it does two things:  

<ul>
<li><p>it sets a few special variables like `__name__`, and then</p></li>
<li><p>it executes all of the code found in the file.</p></li>
</ul>

Let's see how this works and how it relates to your question about the `__name__` checks we always see in Python scripts.  

<h5>Code Sample</h1>

Let's use a slightly different code sample to explore how imports and scripts work.  Suppose the following is in a file called `foo.py`.  

```python
# Suppose this is foo.py.

print("before import")
import math

print("before functionA")
def functionA():
    print("Function A")

print("before functionB")
def functionB():
    print("Function B {}".format(math.sqrt(100)))

print("before __name__ guard")
if __name__ == '__main__':
    functionA()
    functionB()
print("after __name__ guard")
```

<h5>Special Variables</h1>

When the Python interpeter reads a source file, it first defines a few special variables. In this case, we care about the `__name__` variable.  

<strong>When Your Module Is the Main Program</strong>  

If you are running your module (the source file) as the main program, e.g.  

```python
python foo.py
```

the interpreter will assign the hard-coded string `"__main__"` to the `__name__` variable, i.e.  

```python
# It's as if the interpreter inserts this at the top
# of your module when run as the main program.
__name__ = "__main__" 
```

<strong>When Your Module Is Imported By Another</strong>  

On the other hand, suppose some other module is the main program and it imports your module. This means there's a statement like this in the main program, or in some other module the main program imports:  

```python
# Suppose this is in some other main program.
import foo
```

In this case, the interpreter will look at the filename of your module, `foo.py`, strip off the `.py`, and assign that string to your module's `__name__` variable, i.e.  

```python
# It's as if the interpreter inserts this at the top
# of your module when it's imported from another module.
__name__ = "foo"
```

<h5>Executing the Module's Code</h1>

After the special variables are set up, the interpreter executes all the code in the module, one statement at a time. You may want to open another window on the side with the code sample so you can follow along with this explanation.  

<strong>Always</strong>  

<ol>
<li><p>It prints the string `"before import"` (without quotes).</p></li>
<li><p>It loads the `math` module and assigns it to a variable called `math`. This is equivalent to replacing `import math` with the following (note that `__import__` is a low-level function in Python that takes a string and triggers the actual import):</p></li>
</ol>

```python
# Find and load a module given its string name, "math",
# then assign it to a local variable called math.
math = __import__("math")
```

<ol start="3">
<li><p>It prints the string `"before functionA"`.</p></li>
<li><p>It executes the `def` block, creating a function object, then assigning that function object to a variable called `functionA`.</p></li>
<li><p>It prints the string `"before functionB"`.</p></li>
<li><p>It executes the second `def` block, creating another function object, then assigning it to a variable called `functionB`.</p></li>
<li><p>It prints the string `"before __name__ guard"`.</p></li>
</ol>

<strong>Only When Your Module Is the Main Program</strong>  

<ol start="8">
<li>If your module is the main program, then it will see that `__name__` was indeed set to `"__main__"` and it calls the two functions, printing the strings `"Function A"` and `"Function B 10.0"`.</li>
</ol>

<strong>Only When Your Module Is Imported by Another</strong>  

<ol start="8">
<li>(<strong>instead</strong>) If your module is not the main program but was imported by another one, then `__name__` will be `"foo"`, not `"__main__"`, and it'll skip the body of the `if` statement.</li>
</ol>

<strong>Always</strong>  

<ol start="9">
<li>It will print the string `"after __name__ guard"` in both situations.</li>
</ol>

<strong><em>Summary</em></strong>  

In summary, here's what'd be printed in the two cases:  

```python
# What gets printed if foo is the main program
before import
before functionA
before functionB
before __name__ guard
Function A
Function B 10.0
after __name__ guard
```

```python
# What gets printed if foo is imported as a regular module
before import
before functionA
before functionB
before __name__ guard
after __name__ guard
```

<h5>Why Does It Work This Way?</h1>

You might naturally wonder why anybody would want this.  Well, sometimes you want to write a `.py` file that can be both used by other programs and/or modules as a module, and can also be run as the main program itself.  Examples:  

<ul>
<li><p>Your module is a library, but you want to have a script mode where it runs some unit tests or a demo.</p></li>
<li><p>Your module is only used as a main program, but it has some unit tests, and the testing framework works by importing `.py` files like your script and running special test functions. You don't want it to try running the script just because it's importing the module.</p></li>
<li><p>Your module is mostly used as a main program, but it also provides a programmer-friendly API for advanced users.</p></li>
</ul>

Beyond those examples, it's elegant that running a script in Python is just setting up a few magic variables and importing the script. "Running" the script is a side effect of importing the script's module.  

<h5>Food for Thought</h1>

<ul>
<li><p>Question: Can I have multiple `__name__` checking blocks?  Answer: it's strange to do so, but the language won't stop you.</p></li>
<li><p>Suppose the following is in `foo2.py`.  What happens if you say `python foo2.py` on the command-line? Why?</p></li>
</ul>

```python
# Suppose this is foo2.py.

def functionA():
    print("a1")
    from foo2 import functionB
    print("a2")
    functionB()
    print("a3")

def functionB():
    print("b")

print("t1")
if __name__ == "__main__":
    print("m1")
    functionA()
    print("m2")
print("t2")
```

<ul>
<li>Now, figure out what will happen if you remove the `__name__` check in `foo3.py`:</li>
</ul>

```python
# Suppose this is foo3.py.

def functionA():
    print("a1")
    from foo3 import functionB
    print("a2")
    functionB()
    print("a3")

def functionB():
    print("b")

print("t1")
print("m1")
functionA()
print("m2")
print("t2")
```

<ul>
<li>What will this do when used as a script?  When imported as a module?</li>
</ul>

```python
# Suppose this is in foo4.py
__name__ = "__main__"

def bar():
    print("bar")

print("before __name__ guard")
if __name__ == "__main__":
    bar()
print("after __name__ guard")
```

#### Answer 2 (score 1696)
When your script is run by passing it as a command to the Python interpreter,  

```python
python myscript.py
```

all of the code that is at indentation level 0 gets executed.  Functions and classes that are defined are, well, defined, but none of their code gets run.  Unlike other languages, there's no `main()` function that gets run automatically - the `main()` function is implicitly all the code at the top level.  

In this case, the top-level code is an `if` block.  `__name__` is a built-in variable which evaluates to the name of the current module.  However, if a module is being run directly (as in `myscript.py` above), then `__name__` instead is set to the string `"__main__"`.  Thus, you can test whether your script is being run directly or being imported by something else by testing  

```python
if __name__ == "__main__":
    ...
```

If your script is being imported into another module, its various function and class definitions will be imported and its top-level code will be executed, but the code in the then-body of the `if` clause above won't get run as the condition is not met. As a basic example, consider the following two scripts:  

```python
# file one.py
def func():
    print("func() in one.py")

print("top-level in one.py")

if __name__ == "__main__":
    print("one.py is being run directly")
else:
    print("one.py is being imported into another module")
```



```python
# file two.py
import one

print("top-level in two.py")
one.func()

if __name__ == "__main__":
    print("two.py is being run directly")
else:
    print("two.py is being imported into another module")
```

Now, if you invoke the interpreter as  

```python
python one.py
```

The output will be  

```python
top-level in one.py
one.py is being run directly
```

If you run `two.py` instead:  

```python
python two.py
```

You get  

```python
top-level in one.py
one.py is being imported into another module
top-level in two.py
func() in one.py
two.py is being run directly
```

Thus, when module `one` gets loaded, its `__name__` equals `"one"` instead of `"__main__"`.  

#### Answer 3 (score 676)
The simplest explanation for the `__name__` variable (imho) is the following:  

Create the following files.  

```python
# a.py
import b
```

and  

```python
# b.py
print "Hello World from %s!" % __name__

if __name__ == '__main__':
    print "Hello World again from %s!" % __name__
```

Running them will get you this output:  

```python
$ python a.py
Hello World from b!
```

As you can see, when a module is imported, Python sets `globals()['__name__']` in this module to the module's name. Also, upon import all the code in the module is being run. As the `if` statement evaluates to `False` this part is not executed.  

```python
$ python b.py
Hello World from __main__!
Hello World again from __main__!
```

As you can see, when a file is executed, Python sets `globals()['__name__']` in this file to `"__main__"`. This time, the `if` statement evaluates to `True` and is being run.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: How do I check if a list is empty? (score [2462573](https://stackoverflow.com/q/53513) in 2018)

#### Question
For example, if passed the following:  

```python
a = []
```

How do I check to see if `a` is empty?  

#### Answer accepted (score 4944)
```python
if not a:
  print("List is empty")
```

Using the implicit booleanness of the empty `list` is quite pythonic.  

#### Answer 2 (score 1081)
The pythonic way to do it is from the <a href="https://www.python.org/dev/peps/pep-0008" rel="noreferrer">PEP 8 style guide</a> (where <strong>Yes</strong> means “recommended” and <strong>No</strong> means “not recommended”):  

<blockquote>
  <p>For sequences, (strings, lists, tuples), use the fact that empty sequences are false.
  </p>

```python
<b>Yes:</b> if not seq:
     if seq:

<b>No:</b>  if len(seq):
     if not len(seq):
```
</blockquote>

#### Answer 3 (score 693)
I prefer it explicitly:  

```python
if len(li) == 0:
    print('the list is empty')
```

This way it's 100% clear that `li` is a sequence (list) and we want to test its size. My problem with `if not li: ...` is that it gives the false impression that `li` is a boolean variable.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: How do I sort a dictionary by value? (score [2415416](https://stackoverflow.com/q/613183) in 2019)

#### Question
I have a dictionary of values read from two fields in a database: a string field and a numeric field. The string field is unique, so that is the key of the dictionary.  

I can sort on the keys, but how can I sort based on the values?  

Note: I have read Stack Overflow question here <em><a href="https://stackoverflow.com/questions/72899">How do I sort a list of dictionaries by a value of the dictionary?</a></em> and probably could change my code to have a list of dictionaries, but since I do not really need a list of dictionaries I wanted to know if there is a simpler solution to sort either in ascending or descending order.  

#### Answer accepted (score 4391)
It is not possible to sort a dictionary, only to get a representation of a dictionary that is sorted. Dictionaries are inherently orderless, but other types, such as lists and tuples, are not. So you need an ordered data type to represent sorted values, which will be a list—probably a list of tuples.  

For instance,  

```python
import operator
x = {1: 2, 3: 4, 4: 3, 2: 1, 0: 0}
sorted_x = sorted(x.items(), key=operator.itemgetter(1))
```

`sorted_x` will be a list of tuples sorted by the second element in each tuple. `dict(sorted_x) == x`.  

And for those wishing to sort on keys instead of values:  

```python
import operator
x = {1: 2, 3: 4, 4: 3, 2: 1, 0: 0}
sorted_x = sorted(x.items(), key=operator.itemgetter(0))
```

In Python3 since unpacking is not allowed <a href="https://stackoverflow.com/a/15712231/4293057">[1]</a> we can use   

```python
x = {1: 2, 3: 4, 4: 3, 2: 1, 0: 0}
sorted_x = sorted(x.items(), key=lambda kv: kv[1])
```

If you want the output as a dict, you can use <a href="https://docs.python.org/3/library/collections.html#collections.OrderedDict" rel="noreferrer">`collections.OrderedDict`</a>:  

```python
import collections

sorted_dict = collections.OrderedDict(sorted_x)
```

#### Answer 2 (score 1136)
<h5>As simple as: `sorted(dict1, key=dict1.get)`</h2>

Well, it is actually possible to do a "sort by dictionary values". Recently I had to do that in a Code Golf (Stack Overflow question <em><a href="https://stackoverflow.com/questions/3169051/code-golf-word-frequency-chart#3170549">Code golf: Word frequency chart</a></em>). Abridged, the problem was of the kind: given a text, count how often each word is encountered and display a list of the top words, sorted by decreasing frequency.   

If you construct a dictionary with the words as keys and the number of occurrences of each word as value, simplified here as:  

```python
from collections import defaultdict
d = defaultdict(int)
for w in text.split():
  d[w] += 1
```

then you can get a list of the words, ordered by frequency of use with `sorted(d, key=d.get)` - the sort iterates over the dictionary keys, using the number of word occurrences as a sort key .   

```python
for w in sorted(d, key=d.get, reverse=True):
  print w, d[w]
```

I am writing this detailed explanation to illustrate what people often mean by "I can easily sort a dictionary by key, but how do I sort by value" - and I think the OP was trying to address such an issue. And the solution is to do sort of list of the keys, based on the values, as shown above.  

#### Answer 3 (score 750)
You could use:  

```python
sorted(d.items(), key=lambda x: x[1])
```

This will sort the dictionary by the values of each entry within the dictionary from smallest to largest.  

To sort it in descending order just add `reverse=True`:  

```python
sorted(d.items(), key=lambda x: x[1], reverse=True)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How can I safely create a nested directory? (score [2407666](https://stackoverflow.com/q/273192) in 2019)

#### Question
What is the most elegant way to check if the directory a file is going to be written to exists, and if not, create the directory using Python? Here is what I tried:  

```python
import os

file_path = "/my/directory/filename.txt"
directory = os.path.dirname(file_path)

try:
    os.stat(directory)
except:
    os.mkdir(directory)       

f = file(filename)
```

Somehow, I missed `os.path.exists` (thanks kanja, Blair, and Douglas). This is what I have now:  

```python
def ensure_dir(file_path):
    directory = os.path.dirname(file_path)
    if not os.path.exists(directory):
        os.makedirs(directory)
```

Is there a flag for "open", that makes this happen automatically?  

#### Answer accepted (score 4670)
I see two answers with good qualities, each with a small flaw, so I will give my take on it:  

Try <a href="https://docs.python.org/2/library/os.path.html#os.path.exists" rel="noreferrer">`os.path.exists`</a>, and consider <a href="https://docs.python.org/2/library/os.html#os.makedirs" rel="noreferrer">`os.makedirs`</a> for the creation.  

```python
import os
if not os.path.exists(directory):
    os.makedirs(directory)
```

As noted in comments and elsewhere, there's a race condition &ndash; if the directory is created between the `os.path.exists` and the `os.makedirs` calls, the `os.makedirs` will fail with an `OSError`. Unfortunately, blanket-catching `OSError` and continuing is not foolproof, as it will ignore a failure to create the directory due to other factors, such as insufficient permissions, full disk, etc.  

One option would be to trap the `OSError` and examine the embedded error code (see <a href="https://stackoverflow.com/questions/273698/is-there-a-cross-platform-way-of-getting-information-from-pythons-oserror">Is there a cross-platform way of getting information from Python’s OSError</a>):  

```python
import os, errno

try:
    os.makedirs(directory)
except OSError as e:
    if e.errno != errno.EEXIST:
        raise
```

Alternatively, there could be a second `os.path.exists`, but suppose another created the directory after the first check, then removed it before the second one &ndash; we could still be fooled.   

Depending on the application, the danger of concurrent operations may be more or less than the danger posed by other factors such as file permissions. The developer would have to know more about the particular application being developed and its expected environment before choosing an implementation.  

Modern versions of Python improve this code quite a bit, both by exposing <a href="https://docs.python.org/3.3/library/exceptions.html?#FileExistsError" rel="noreferrer">`FileExistsError`</a> (in 3.3+)...  

```python
try:
    os.makedirs("path/to/directory")
except FileExistsError:
    # directory already exists
    pass
```

...and by allowing <a href="https://docs.python.org/3.2/library/os.html#os.makedirs" rel="noreferrer">a keyword argument to `os.makedirs` called `exist_ok`</a> (in 3.2+).  

```python
os.makedirs("path/to/directory", exist_ok=True)  # succeeds even if directory exists.
```

#### Answer 2 (score 1155)
<h5>Python 3.5+:</h2>

```python
import pathlib
pathlib.Path('/my/directory').mkdir(parents=True, exist_ok=True) 
```

<a href="https://docs.python.org/library/pathlib.html#pathlib.Path.mkdir" rel="noreferrer">`pathlib.Path.mkdir`</a> as used above recursively creates the directory and does not raise an exception if the directory already exists. If you don't need or want the parents to be created, skip the `parents` argument.  

<h5>Python 3.2+:</h2>

<strong>Using `pathlib`:</strong>  

If you can, install the current `pathlib` backport named <a href="https://pypi.python.org/pypi/pathlib2/" rel="noreferrer">`pathlib2`</a>. Do not install the older unmaintained backport named <a href="https://pypi.python.org/pypi/pathlib/" rel="noreferrer">`pathlib`</a>. Next, refer to the Python 3.5+ section above and use it the same.  

If using Python 3.4, even though it comes with `pathlib`, it is missing the useful `exist_ok` option. The backport is intended to offer a newer and superior implementation of `mkdir` which includes this missing option.  

<strong>Using `os`:</strong>  

```python
import os
os.makedirs(path, exist_ok=True)
```

<a href="https://docs.python.org/library/os.html#os.makedirs" rel="noreferrer">`os.makedirs`</a> as used above recursively creates the directory and does not raise an exception if the directory already exists. It has the optional `exist_ok` argument only if using Python 3.2+, with a default value of `False`. This argument does not exist in Python 2.x up to 2.7. As such, there is no need for manual exception handling as with Python 2.7.  

<h5>Python 2.7+:</h2>

<strong>Using `pathlib`:</strong>  

If you can, install the current `pathlib` backport named <a href="https://pypi.python.org/pypi/pathlib2/" rel="noreferrer">`pathlib2`</a>. Do not install the older unmaintained backport named <a href="https://pypi.python.org/pypi/pathlib/" rel="noreferrer">`pathlib`</a>. Next, refer to the Python 3.5+ section above and use it the same.  

<strong>Using `os`:</strong>  

```python
import os
try: 
    os.makedirs(path)
except OSError:
    if not os.path.isdir(path):
        raise
```

While a naive solution may first use <a href="https://docs.python.org/2/library/os.path.html#os.path.isdir" rel="noreferrer" title="os.path.isdir">`os.path.isdir`</a> followed by <a href="https://docs.python.org/2/library/os.html#os.makedirs" rel="noreferrer" title="os.makedirs">`os.makedirs`</a>, the solution above reverses the order of the two operations. In doing so, it prevents a common race condition having to do with a duplicated attempt at creating the directory, and also disambiguates files from directories.  

Note that capturing the exception and using `errno` is of limited usefulness because `OSError: [Errno 17] File exists`, i.e. `errno.EEXIST`, is raised for both files and directories. It is more reliable simply to check if the directory exists.  

<h5>Alternative:</h2>

<a href="https://docs.python.org/distutils/apiref.html#distutils.dir_util.mkpath" rel="noreferrer">`mkpath`</a> creates the nested directory, and does nothing if the directory already exists. This works in both Python 2 and 3.  

```python
import distutils.dir_util
distutils.dir_util.mkpath(path)
```

Per <a href="http://bugs.python.org/issue10948" rel="noreferrer">Bug 10948</a>, a severe limitation of this alternative is that it works only once per python process for a given path. In other words, if you use it to create a directory, then delete the directory from inside or outside Python, then use `mkpath` again to recreate the same directory, `mkpath` will simply silently use its invalid cached info of having previously created the directory, and will not actually make the directory again. In contrast, `os.makedirs` doesn't rely on any such cache. This limitation may be okay for some applications.  

<hr>

With regard to the directory's <em>mode</em>, please refer to the documentation if you care about it.  

#### Answer 3 (score 600)
Using try except and the right error code from errno module gets rid of the race condition and is cross-platform:  

```python
import os
import errno

def make_sure_path_exists(path):
    try:
        os.makedirs(path)
    except OSError as exception:
        if exception.errno != errno.EEXIST:
            raise
```

In other words, we try to create the directories, but if they already exist we ignore the error. On the other hand, any other error gets reported. For example, if you create dir 'a' beforehand and remove all permissions from it, you will get an `OSError` raised with `errno.EACCES` (Permission denied, error 13).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: How to remove an element from a list by index? (score [2347506](https://stackoverflow.com/q/627435) in 2019)

#### Question
How do I remove an element from a list by index in Python?  

I found the `list.remove` method, but say I want to remove the last element, how do I do this? It seems like the default remove searches the list, but I don't want any search to be performed.  

#### Answer accepted (score 1546)
Use `del` and specify the index of the element you want to delete:  

```python
>>> a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>>> del a[-1]
>>> a
[0, 1, 2, 3, 4, 5, 6, 7, 8]
```

Also supports slices:  

```python
>>> del a[2:4]
>>> a
[0, 1, 4, 5, 6, 7, 8, 9]
```

<a href="http://docs.python.org/tutorial/datastructures.html#the-del-statement" rel="noreferrer">Here</a> is the section from the tutorial.  

#### Answer 2 (score 595)
You probably want `pop`:  

```python
a = ['a', 'b', 'c', 'd']
a.pop(1)

# now a is ['a', 'c', 'd']
```

By default, `pop` without any arguments removes the last item:  

```python
a = ['a', 'b', 'c', 'd']
a.pop()

# now a is ['a', 'b', 'c']
```

#### Answer 3 (score 124)
Like others mentioned pop and del are <em>the</em> efficient ways to remove an item of given index. Yet just for the sake of completion (since the same thing can be done via many ways in Python):  

<strong>Using slices (this does not do in place removal of item from original list):</strong>  

(Also this will be the least efficient method when working with Python list, but this could be useful (but not efficient, I reiterate) when working with user defined objects that do not support pop, yet do define a `__getitem__` ):  

```python
>>> a = [1, 2, 3, 4, 5, 6]
>>> index = 3 # Only positive index

>>> a = a[:index] + a[index+1 :]
# a is now [1, 2, 3, 5, 6]
```

<strong>Note:</strong> Please note that this method does not modify the list in place like `pop` and `del`. It instead makes two copies of lists (one from the start until the index but without it (`a[:index]`) and one after the index till the last element (`a[index+1:]`)) and creates a new list object by adding both. This is then reassigned to the list variable (`a`). The old list object is hence dereferenced and hence garbage collected (provided the original list object is not referenced by any variable other than a).  

This makes this method very inefficient and it can also produce undesirable side effects (especially when other variables point to the original list object which remains un-modified).  

Thanks to @MarkDickinson for pointing this out ...  

<a href="https://stackoverflow.com/a/509295/3244627">This</a> Stack Overflow answer explains the concept of slicing.  

Also note that this works only with positive indices.  

While using with objects, the `__getitem__` method must have been defined and more importantly the <strong>`__add__`</strong> method must have been defined to return an object containing items from both the operands.  

In essence, this works with any object whose class definition is like:  

```python
class foo(object):
    def __init__(self, items):
        self.items = items

    def __getitem__(self, index):
        return foo(self.items[index])

    def __add__(self, right):
        return foo( self.items + right.items )
```

This works with `list` which defines `__getitem__` and `__add__` methods.  

<strong>Comparison of the three ways in terms of efficiency:</strong>  

Assume the following is predefined:  

```python
a = range(10)
index = 3
```

<strong>The `del object[index]` method:</strong>  

By far the most efficient method. It works will all objects that define a `__del__` method.  

The disassembly is as follows:  

Code:  

```python
def del_method():
    global a
    global index
    del a[index]
```

Disassembly:  

```python
 10    0 LOAD_GLOBAL     0 (a)
       3 LOAD_GLOBAL     1 (index)
       6 DELETE_SUBSCR   # This is the line that deletes the item
       7 LOAD_CONST      0 (None)
      10 RETURN_VALUE
None
```

<strong>`pop` method:</strong>  

It is less efficient than the del method and is used when you need to get the deleted item.  

Code:  

```python
def pop_method():
    global a
    global index
    a.pop(index)
```

Disassembly:  

```python
 17     0 LOAD_GLOBAL     0 (a)
        3 LOAD_ATTR       1 (pop)
        6 LOAD_GLOBAL     2 (index)
        9 CALL_FUNCTION   1
       12 POP_TOP
       13 LOAD_CONST      0 (None)
       16 RETURN_VALUE
```

<strong>The slice and add method.</strong>  

The least efficient.  

Code:  

```python
def slice_method():
    global a
    global index
    a = a[:index] + a[index+1:]
```

Disassembly:  

```python
 24     0 LOAD_GLOBAL    0 (a)
        3 LOAD_GLOBAL    1 (index)
        6 SLICE+2
        7 LOAD_GLOBAL    0 (a)
       10 LOAD_GLOBAL    1 (index)
       13 LOAD_CONST     1 (1)
       16 BINARY_ADD
       17 SLICE+1
       18 BINARY_ADD
       19 STORE_GLOBAL   0 (a)
       22 LOAD_CONST     0 (None)
       25 RETURN_VALUE
None
```

Note: In all three disassembles ignore the last two lines which basically are `return None`. Also the first two lines are loading the global values `a` and `index`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: Renaming columns in pandas (score [2283204](https://stackoverflow.com/q/11346283) in 2017)

#### Question
I have a DataFrame using pandas and column labels that I need to edit to replace the original column labels.   

I'd like to change the column names in a DataFrame `A` where the original column names are:  

```python
['$a', '$b', '$c', '$d', '$e'] 
```

to   

```python
['a', 'b', 'c', 'd', 'e'].
```

I have the edited column names stored it in a list, but I don't know how to replace the column names.  

#### Answer accepted (score 1585)
Just assign it to the `.columns` attribute:  

```python
>>> df = pd.DataFrame({'$a':[1,2], '$b': [10,20]})
>>> df.columns = ['a', 'b']
>>> df
   a   b
0  1  10
1  2  20
```

#### Answer 2 (score 2506)
<h5><strong>RENAME SPECIFIC COLUMNS</strong></h2>

Use the <a href="http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.rename.html" rel="noreferrer">`df.rename()`</a> function and refer the columns to be renamed. Not all the columns have to be renamed:  

```python
df = df.rename(columns={'oldName1': 'newName1', 'oldName2': 'newName2'})
# Or rename the existing DataFrame (rather than creating a copy) 
df.rename(columns={'oldName1': 'newName1', 'oldName2': 'newName2'}, inplace=True)
```

<strong>Minimal Code Example</strong>  

```python
df = pd.DataFrame('x', index=range(3), columns=list('abcde'))
df

   a  b  c  d  e
0  x  x  x  x  x
1  x  x  x  x  x
2  x  x  x  x  x
```

The following methods all work and produce the same output:  

```python
df2 = df.rename({'a': 'X', 'b': 'Y'}, axis=1)  # new method
df2 = df.rename({'a': 'X', 'b': 'Y'}, axis='columns')
df2 = df.rename(columns={'a': 'X', 'b': 'Y'})  # old method  

df2

   X  Y  c  d  e
0  x  x  x  x  x
1  x  x  x  x  x
2  x  x  x  x  x
```

Remember to assign the result back, as the modification is not-inplace. Alternatively, specify `inplace=True`:  

```python
df.rename({'a': 'X', 'b': 'Y'}, axis=1, inplace=True)
df

   X  Y  c  d  e
0  x  x  x  x  x
1  x  x  x  x  x
2  x  x  x  x  x
```

From v0.25, you can also specify `errors='raise'` to raise errors if an invalid column-to-rename is specified. See <a href="https://pandas-docs.github.io/pandas-docs-travis/reference/api/pandas.DataFrame.rename.html#pandas.DataFrame.rename" rel="noreferrer">v0.25 `rename()` docs</a>.  

<hr>

<h5>REASSIGN COLUMN HEADERS</h2>

Use <a href="https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.set_axis.html" rel="noreferrer">`df.set_axis()`</a> with `axis=1` and `inplace=False` (to return a copy).  

```python
df2 = df.set_axis(['V', 'W', 'X', 'Y', 'Z'], axis=1, inplace=False)
df2

   V  W  X  Y  Z
0  x  x  x  x  x
1  x  x  x  x  x
2  x  x  x  x  x
```

This returns a copy, but you can modify the DataFrame in-place by setting `inplace=True` (this is the default behaviour for versions &lt;=0.24 but is likely to change in the future).  

You can also assign headers directly:  

```python
df.columns = ['V', 'W', 'X', 'Y', 'Z']
df

   V  W  X  Y  Z
0  x  x  x  x  x
1  x  x  x  x  x
2  x  x  x  x  x
```

#### Answer 3 (score 364)
The <a href="http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.rename.html">`rename`</a> method can take a function, for example:  

```python
In [11]: df.columns
Out[11]: Index([u'$a', u'$b', u'$c', u'$d', u'$e'], dtype=object)

In [12]: df.rename(columns=lambda x: x[1:], inplace=True)

In [13]: df.columns
Out[13]: Index([u'a', u'b', u'c', u'd', u'e'], dtype=object)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: How to determine a Python variable's type? (score [2254676](https://stackoverflow.com/q/402504) in 2017)

#### Question
How do I see the type of a variable whether it is unsigned 32 bit, signed 16 bit, etc.?  

How do I view it?  

#### Answer 2 (score 1224)
Python doesn't have the same types as C/C++, which appears to be your question.  

Try this:  

```python
>>> i = 123
>>> type(i)
<type 'int'>
>>> type(i) is int
True
>>> i = 123456789L
>>> type(i)
<type 'long'>
>>> type(i) is long
True
>>> i = 123.456
>>> type(i)
<type 'float'>
>>> type(i) is float
True
```

The distinction between int and long goes away in Python 3.0, though.  

#### Answer 3 (score 403)
You may be looking for the `type()` function.  

See the examples below, but there's no "unsigned" type in Python just like Java.  

Positive integer:  

```python
>>> v = 10
>>> type(v)
<type 'int'>
```

<em>Large</em> positive integer:  

```python
>>> v = 100000000000000
>>> type(v)
<type 'long'>
```

Negative integer:  

```python
>>> v = -10
>>> type(v)
<type 'int'>
```

Literal sequence of characters:  

```python
>>> v = 'hi'
>>> type(v)
<type 'str'>
```

Floating point integer:  

```python
>>> v = 3.14159
>>> type(v)
<type 'float'>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: How do I lowercase a string in Python? (score [2241046](https://stackoverflow.com/q/6797984) in 2019)

#### Question
Is there a way to convert a string from uppercase, or even part uppercase to lowercase?   

For example, "Kilometers" → "kilometers".  

#### Answer accepted (score 2880)
Use `.lower()` - For example:  

```python
s = "Kilometer"
print(s.lower())
```

<p>The official 2.x documentation is here: <a href="https://docs.python.org/2/library/stdtypes.html?highlight=str.lower#str.lower" rel="noreferrer">`str.lower()`</a><br>
The official 3.x documentation is here: <a href="https://docs.python.org/3/library/stdtypes.html?highlight=str.lower#str.lower" rel="noreferrer">`str.lower()`</a></p>

#### Answer 2 (score 197)
<blockquote>
  <h5>How to convert string to lowercase in Python?</h1>
  
  Is there any way to convert an entire user inputted string from uppercase, or even part uppercase to lowercase?   
  
  E.g. Kilometers --> kilometers  
</blockquote>

The canonical Pythonic way of doing this is   

```python
>>> 'Kilometers'.lower()
'kilometers'
```

However, if the purpose is to do case insensitive matching, you should use case-folding:  

```python
>>> 'Kilometers'.casefold()
'kilometers'
```

Here's why:  

```python
>>> "Maße".casefold()
'masse'
>>> "Maße".lower()
'maße'
>>> "MASSE" == "Maße"
False
>>> "MASSE".lower() == "Maße".lower()
False
>>> "MASSE".casefold() == "Maße".casefold()
True
```

This is a str method in Python 3, but in Python 2, you'll want to look at the PyICU or py2casefold - <a href="https://stackoverflow.com/q/18271077/541136">several answers address this here</a>.  

<h5>Unicode Python 3</h2>

<a href="https://docs.python.org/3/howto/unicode.html" rel="noreferrer">Python 3</a> handles plain string literals as unicode:  

```python
>>> string = 'Километр'
>>> string
'Километр'
>>> string.lower()
'километр'
```

<h5>Python 2, plain string literals are bytes</h2>

In Python 2, the below, pasted into a shell, encodes the literal as a string of bytes, using <a href="https://docs.python.org/2/library/codecs.html#python-specific-encodings" rel="noreferrer">`utf-8`</a>.  

And `lower` doesn't map any changes that bytes would be aware of, so we get the same string.   

```python
>>> string = 'Километр'
>>> string
'\xd0\x9a\xd0\xb8\xd0\xbb\xd0\xbe\xd0\xbc\xd0\xb5\xd1\x82\xd1\x80'
>>> string.lower()
'\xd0\x9a\xd0\xb8\xd0\xbb\xd0\xbe\xd0\xbc\xd0\xb5\xd1\x82\xd1\x80'
>>> print string.lower()
Километр
```

In scripts, Python will object to non-ascii (as of Python 2.5, and warning in Python 2.4) bytes being in a string with no encoding given, since the intended coding would be ambiguous. For more on that, see the Unicode how-to in the <a href="https://docs.python.org/2/howto/unicode.html#unicode-literals-in-python-source-code" rel="noreferrer">docs</a> and <a href="https://www.python.org/dev/peps/pep-0263/" rel="noreferrer">PEP 263</a>  

<h5>Use Unicode literals, not `str` literals</h3>

So we need a `unicode` string to handle this conversion, accomplished easily with a unicode string literal, which disambiguates with a `u` prefix (and note the `u` prefix also works in Python 3):  

```python
>>> unicode_literal = u'Километр'
>>> print(unicode_literal.lower())
километр
```

Note that the bytes are completely different from the `str` bytes - the escape character is `'\u'` followed by the 2-byte width, or 16 bit representation of these `unicode` letters:  

```python
>>> unicode_literal
u'\u041a\u0438\u043b\u043e\u043c\u0435\u0442\u0440'
>>> unicode_literal.lower()
u'\u043a\u0438\u043b\u043e\u043c\u0435\u0442\u0440'
```

Now if we only have it in the form of a `str`, we need to convert it to `unicode`. Python's Unicode type is a universal encoding format that has many <a href="https://en.wikipedia.org/wiki/UTF-8#Advantages_and_disadvantages" rel="noreferrer">advantages</a> relative to most other encodings. We can either use the `unicode` constructor or `str.decode` method with the codec to convert the `str` to `unicode`:  

```python
>>> unicode_from_string = unicode(string, 'utf-8') # "encoding" unicode from string
>>> print(unicode_from_string.lower())
километр
>>> string_to_unicode = string.decode('utf-8') 
>>> print(string_to_unicode.lower())
километр
>>> unicode_from_string == string_to_unicode == unicode_literal
True
```

Both methods convert to the unicode type - and same as the unicode_literal.  

<h5>Best Practice, use Unicode</h2>

It is recommended that you always <a href="https://docs.python.org/2/howto/unicode.html#tips-for-writing-unicode-aware-programs" rel="noreferrer">work with text in Unicode</a>.  

<blockquote>
  Software should only work with Unicode strings internally, converting to a particular encoding on output.  
</blockquote>

<h5>Can encode back when necessary</h2>

However, to get the lowercase back in type `str`, encode the python string to `utf-8` again:  

```python
>>> print string
Километр
>>> string
'\xd0\x9a\xd0\xb8\xd0\xbb\xd0\xbe\xd0\xbc\xd0\xb5\xd1\x82\xd1\x80'
>>> string.decode('utf-8')
u'\u041a\u0438\u043b\u043e\u043c\u0435\u0442\u0440'
>>> string.decode('utf-8').lower()
u'\u043a\u0438\u043b\u043e\u043c\u0435\u0442\u0440'
>>> string.decode('utf-8').lower().encode('utf-8')
'\xd0\xba\xd0\xb8\xd0\xbb\xd0\xbe\xd0\xbc\xd0\xb5\xd1\x82\xd1\x80'
>>> print string.decode('utf-8').lower().encode('utf-8')
километр
```

So in Python 2, Unicode can encode into Python strings, and Python strings can decode into the Unicode type.  

#### Answer 3 (score 195)
With Python 2, this doesn't work for non-English words in UTF-8. In this case `decode('utf-8')` can help:  

```python
>>> s='Километр'
>>> print s.lower()
Километр
>>> print s.decode('utf-8').lower()
километр
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: How to convert list to string (score [2197422](https://stackoverflow.com/q/5618878) in 2019)

#### Question
How can I convert a list to a string using Python?  

#### Answer 2 (score 1203)
By using `''.join`  

```python
list1 = ['1', '2', '3']
str1 = ''.join(list1)
```

Or if the list is of integers, convert the elements before joining them.  

```python
list1 = [1, 2, 3]
str1 = ''.join(str(e) for e in list1)
```

#### Answer 3 (score 255)
```python
>>> L = [1,2,3]       
>>> " ".join(str(x) for x in L)
'1 2 3'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: Select rows from a DataFrame based on values in a column in pandas (score [2183835](https://stackoverflow.com/q/17071871) in 2019)

#### Question
How to select rows from a `DataFrame` based on values in some column in pandas?  

In <strong>SQL</strong>, I would use:  

```python
SELECT *
FROM table
WHERE colume_name = some_value
```

<em>I tried to look at pandas documentation but did not immediately find the answer.</em>  

#### Answer accepted (score 3029)
To select rows whose column value equals a scalar, `some_value`, use `==`:  

```python
df.loc[df['column_name'] == some_value]
```

To select rows whose column value is in an iterable, `some_values`, use `isin`:  

```python
df.loc[df['column_name'].isin(some_values)]
```

Combine multiple conditions with `&amp;`:   

```python
df.loc[(df['column_name'] >= A) & (df['column_name'] <= B)]
```

Note the parentheses. Due to Python's <a href="https://docs.python.org/3/reference/expressions.html#operator-precedence" rel="noreferrer">operator precedence rules</a>, `&amp;` binds more tightly than `&lt;=` and `&gt;=`. Thus, the parentheses in the last example are necessary. Without the parentheses   

```python
df['column_name'] >= A & df['column_name'] <= B
```

is parsed as   

```python
df['column_name'] >= (A & df['column_name']) <= B
```

which results in a <a href="https://stackoverflow.com/questions/36921951/truth-value-of-a-series-is-ambiguous-use-a-empty-a-bool-a-item-a-any-o">Truth value of a Series is ambiguous error</a>.  

<hr>

To select rows whose column value <em>does not equal</em> `some_value`, use `!=`:  

```python
df.loc[df['column_name'] != some_value]
```

`isin` returns a boolean Series, so to select rows whose value is <em>not</em> in `some_values`, negate the boolean Series using `~`:  

```python
df.loc[~df['column_name'].isin(some_values)]
```

<hr>

For example,  

```python
import pandas as pd
import numpy as np
df = pd.DataFrame({'A': 'foo bar foo bar foo bar foo foo'.split(),
                   'B': 'one one two three two two one three'.split(),
                   'C': np.arange(8), 'D': np.arange(8) * 2})
print(df)
#      A      B  C   D
# 0  foo    one  0   0
# 1  bar    one  1   2
# 2  foo    two  2   4
# 3  bar  three  3   6
# 4  foo    two  4   8
# 5  bar    two  5  10
# 6  foo    one  6  12
# 7  foo  three  7  14

print(df.loc[df['A'] == 'foo'])
```

yields  

```python
     A      B  C   D
0  foo    one  0   0
2  foo    two  2   4
4  foo    two  4   8
6  foo    one  6  12
7  foo  three  7  14
```

<hr>

<p>If you have multiple values you want to include, put them in a
list (or more generally, any iterable) and use `isin`:</p>

```python
print(df.loc[df['B'].isin(['one','three'])])
```

yields  

```python
     A      B  C   D
0  foo    one  0   0
1  bar    one  1   2
3  bar  three  3   6
6  foo    one  6  12
7  foo  three  7  14
```

<hr>

<p>Note, however, that if you wish to do this many times, it is more efficient to
make an index first, and then use `df.loc`:</p>

```python
df = df.set_index(['B'])
print(df.loc['one'])
```

yields  

```python
       A  C   D
B              
one  foo  0   0
one  bar  1   2
one  foo  6  12
```

or, to include multiple values from the index use `df.index.isin`:  

```python
df.loc[df.index.isin(['one','two'])]
```

yields  

```python
       A  C   D
B              
one  foo  0   0
one  bar  1   2
two  foo  2   4
two  foo  4   8
two  bar  5  10
one  foo  6  12
```

#### Answer 2 (score 244)
<h5>tl;dr</h3>

The pandas equivalent to   

```python
select * from table where column_name = some_value
```

is  

```python
table[table.column_name == some_value]
```

Multiple conditions:  

```python
table[(table.column_name == some_value) | (table.column_name2 == some_value2)]
```

or  

```python
table.query('column_name == some_value | column_name2 == some_value2')
```

<h5>Code example</h3>

```python
import pandas as pd

# Create data set
d = {'foo':[100, 111, 222], 
     'bar':[333, 444, 555]}
df = pd.DataFrame(d)

# Full dataframe:
df

# Shows:
#    bar   foo 
# 0  333   100
# 1  444   111
# 2  555   222

# Output only the row(s) in df where foo is 222:
df[df.foo == 222]

# Shows:
#    bar  foo
# 2  555  222
```

In the above code it is the line `df[df.foo == 222]` that gives the rows based on the column value, `222` in this case.  

Multiple conditions are also possible:  

```python
df[(df.foo == 222) | (df.bar == 444)]
#    bar  foo
# 1  444  111
# 2  555  222
```

But at that point I would recommend using the <a href="https://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.query.html" rel="noreferrer">query</a> function, since it's less verbose and yields the same result:  

```python
df.query('foo == 222 | bar == 444')
```

#### Answer 3 (score 205)
There are several ways to select rows from a pandas data frame:  

<ol>
<li><strong>Boolean indexing (`df[df['col'] == value`] )</strong></li>
<li><strong>Positional indexing (`df.iloc[...]`)</strong></li>
<li><strong>Label indexing (`df.xs(...)`)</strong></li>
<li><strong>`df.query(...)` API</strong></li>
</ol>

Below I show you examples of each, with advice when to use certain techniques. Assume our criterion is column `'A'` == `'foo'`  

(Note on performance: For each base type, we can keep things simple by using the pandas API or we can venture outside the API, usually into `numpy`, and speed things up.)  

<hr>

<p><strong>Setup</strong><br>
The first thing we'll need is to identify a condition that will act as our criterion for selecting rows.  We'll start with the OP's case `column_name == some_value`, and include some other common use cases.</p>

Borrowing from @unutbu:  

```python
import pandas as pd, numpy as np

df = pd.DataFrame({'A': 'foo bar foo bar foo bar foo foo'.split(),
                   'B': 'one one two three two two one three'.split(),
                   'C': np.arange(8), 'D': np.arange(8) * 2})
```

<hr>

<h5><strong>1. Boolean indexing</strong></h1>

... Boolean indexing requires finding the true value of each row's `'A'` column being equal to `'foo'`, then using those truth values to identify which rows to keep.  Typically, we'd name this series, an array of truth values, `mask`.  We'll do so here as well.  

```python
mask = df['A'] == 'foo'
```

We can then use this mask to slice or index the data frame  

```python
df[mask]

     A      B  C   D
0  foo    one  0   0
2  foo    two  2   4
4  foo    two  4   8
6  foo    one  6  12
7  foo  three  7  14
```

This is one of the simplest ways to accomplish this task and if performance or intuitiveness isn't an issue, this should be your chosen method.  However, if performance is a concern, then you might want to consider an alternative way of creating the `mask`.  

<hr>

<h5><strong>2. Positional indexing</strong></h1>

Positional indexing (`df.iloc[...]`) has its use cases, but this isn't one of them.  In order to identify where to slice, we first need to perform the same boolean analysis we did above.  This leaves us performing one extra step to accomplish the same task.  

```python
mask = df['A'] == 'foo'
pos = np.flatnonzero(mask)
df.iloc[pos]

     A      B  C   D
0  foo    one  0   0
2  foo    two  2   4
4  foo    two  4   8
6  foo    one  6  12
7  foo  three  7  14
```

<h5><strong>3. Label indexing</strong></h1>

<em>Label</em> indexing can be very handy, but in this case, we are again doing more work for no benefit  

```python
df.set_index('A', append=True, drop=False).xs('foo', level=1)

     A      B  C   D
0  foo    one  0   0
2  foo    two  2   4
4  foo    two  4   8
6  foo    one  6  12
7  foo  three  7  14
```

<h5><strong>4. `df.query()` API</strong></h1>

<em>`pd.DataFrame.query`</em> is a very elegant/intuitive way to perform this task, but is often slower. <strong>However</strong>, if you pay attention to the timings below, for large data, the query is very efficient.  More so than the standard approach and of similar magnitude as my best suggestion.  

```python
df.query('A == "foo"')

     A      B  C   D
0  foo    one  0   0
2  foo    two  2   4
4  foo    two  4   8
6  foo    one  6  12
7  foo  three  7  14
```

<hr>

My preference is to use the `Boolean` `mask`   

Actual improvements can be made by modifying how we create our `Boolean` `mask`.  

<p><strong>`mask` alternative 1</strong><br>
<em>Use the underlying `numpy` array and forgo the overhead of creating another `pd.Series`</em>  </p>

```python
mask = df['A'].values == 'foo'
```

I'll show more complete time tests at the end, but just take a look at the performance gains we get using the sample data frame.  First, we look at the difference in creating the `mask`  

```python
%timeit mask = df['A'].values == 'foo'
%timeit mask = df['A'] == 'foo'

5.84 µs ± 195 ns per loop (mean ± std. dev. of 7 runs, 100000 loops each)
166 µs ± 4.45 µs per loop (mean ± std. dev. of 7 runs, 10000 loops each)
```

Evaluating the `mask` with the `numpy` array is ~ 30 times faster.  This is partly due to `numpy` evaluation often being faster.  It is also partly due to the lack of overhead necessary to build an index and a corresponding `pd.Series` object.  

Next, we'll look at the timing for slicing with one `mask` versus the other.  

```python
mask = df['A'].values == 'foo'
%timeit df[mask]
mask = df['A'] == 'foo'
%timeit df[mask]

219 µs ± 12.3 µs per loop (mean ± std. dev. of 7 runs, 1000 loops each)
239 µs ± 7.03 µs per loop (mean ± std. dev. of 7 runs, 1000 loops each)
```

The performance gains aren't as pronounced.  We'll see if this holds up over more robust testing.  

<hr>

<p><strong>`mask` alternative 2</strong><br>
We could have reconstructed the data frame as well.  There is a big caveat when reconstructing a dataframe—you must take care of the `dtypes` when doing so!</p>

Instead of `df[mask]` we will do this  

```python
pd.DataFrame(df.values[mask], df.index[mask], df.columns).astype(df.dtypes)
```

If the data frame is of mixed type, which our example is, then when we get `df.values` the resulting array is of `dtype` `object` and consequently, all columns of the new data frame will be of `dtype` `object`.  Thus requiring the `astype(df.dtypes)` and killing any potential performance gains.  

```python
%timeit df[m]
%timeit pd.DataFrame(df.values[mask], df.index[mask], df.columns).astype(df.dtypes)

216 µs ± 10.4 µs per loop (mean ± std. dev. of 7 runs, 1000 loops each)
1.43 ms ± 39.6 µs per loop (mean ± std. dev. of 7 runs, 1000 loops each)
```

However, if the data frame is not of mixed type, this is a very useful way to do it.  

Given  

```python
np.random.seed([3,1415])
d1 = pd.DataFrame(np.random.randint(10, size=(10, 5)), columns=list('ABCDE'))

d1

   A  B  C  D  E
0  0  2  7  3  8
1  7  0  6  8  6
2  0  2  0  4  9
3  7  3  2  4  3
4  3  6  7  7  4
5  5  3  7  5  9
6  8  7  6  4  7
7  6  2  6  6  5
8  2  8  7  5  8
9  4  7  6  1  5    
```

<hr>

```python
%%timeit
mask = d1['A'].values == 7
d1[mask]

179 µs ± 8.73 µs per loop (mean ± std. dev. of 7 runs, 10000 loops each)
```

Versus  

```python
%%timeit
mask = d1['A'].values == 7
pd.DataFrame(d1.values[mask], d1.index[mask], d1.columns)

87 µs ± 5.12 µs per loop (mean ± std. dev. of 7 runs, 10000 loops each)
```

We cut the time in half.  

<hr>

<p><strong>`mask` alternative 3</strong><br>
@unutbu also shows us how to use `pd.Series.isin` to account for each element of `df['A']` being in a set of values.  This evaluates to the same thing if our set of values is a set of one value, namely `'foo'`.  But it also generalizes to include larger sets of values if needed.  Turns out, this is still pretty fast even though it is a more general solution.  The only real loss is in intuitiveness for those not familiar with the concept.</p>

```python
mask = df['A'].isin(['foo'])
df[mask]

     A      B  C   D
0  foo    one  0   0
2  foo    two  2   4
4  foo    two  4   8
6  foo    one  6  12
7  foo  three  7  14
```

However, as before, we can utilize `numpy` to improve performance while sacrificing virtually nothing.  We'll use `np.in1d`  

```python
mask = np.in1d(df['A'].values, ['foo'])
df[mask]

     A      B  C   D
0  foo    one  0   0
2  foo    two  2   4
4  foo    two  4   8
6  foo    one  6  12
7  foo  three  7  14
```

<hr>

<p><strong>Timing</strong><br>
I'll include other concepts mentioned in other posts as well for reference.<br>
<em>Code Below</em>  </p>

Each Column in this table represents a different length data frame over which we test each function. Each column shows relative time taken, with the fastest function given a base index of `1.0`.  

```python
res.div(res.min())

                         10        30        100       300       1000      3000      10000     30000
mask_standard         2.156872  1.850663  2.034149  2.166312  2.164541  3.090372  2.981326  3.131151
mask_standard_loc     1.879035  1.782366  1.988823  2.338112  2.361391  3.036131  2.998112  2.990103
mask_with_values      1.010166  1.000000  1.005113  1.026363  1.028698  1.293741  1.007824  1.016919
mask_with_values_loc  1.196843  1.300228  1.000000  1.000000  1.038989  1.219233  1.037020  1.000000
query                 4.997304  4.765554  5.934096  4.500559  2.997924  2.397013  1.680447  1.398190
xs_label              4.124597  4.272363  5.596152  4.295331  4.676591  5.710680  6.032809  8.950255
mask_with_isin        1.674055  1.679935  1.847972  1.724183  1.345111  1.405231  1.253554  1.264760
mask_with_in1d        1.000000  1.083807  1.220493  1.101929  1.000000  1.000000  1.000000  1.144175
```

You'll notice that fastest times seem to be shared between `mask_with_values` and `mask_with_in1d`  

```python
res.T.plot(loglog=True)
```

<a href="https://i.stack.imgur.com/ljeTd.png" rel="noreferrer"><img src="https://i.stack.imgur.com/ljeTd.png" alt="enter image description here"></a>  

<strong>Functions</strong>    

```python
def mask_standard(df):
    mask = df['A'] == 'foo'
    return df[mask]

def mask_standard_loc(df):
    mask = df['A'] == 'foo'
    return df.loc[mask]

def mask_with_values(df):
    mask = df['A'].values == 'foo'
    return df[mask]

def mask_with_values_loc(df):
    mask = df['A'].values == 'foo'
    return df.loc[mask]

def query(df):
    return df.query('A == "foo"')

def xs_label(df):
    return df.set_index('A', append=True, drop=False).xs('foo', level=-1)

def mask_with_isin(df):
    mask = df['A'].isin(['foo'])
    return df[mask]

def mask_with_in1d(df):
    mask = np.in1d(df['A'].values, ['foo'])
    return df[mask]
```

<hr>

<strong>Testing</strong>    

```python
res = pd.DataFrame(
    index=[
        'mask_standard', 'mask_standard_loc', 'mask_with_values', 'mask_with_values_loc',
        'query', 'xs_label', 'mask_with_isin', 'mask_with_in1d'
    ],
    columns=[10, 30, 100, 300, 1000, 3000, 10000, 30000],
    dtype=float
)

for j in res.columns:
    d = pd.concat([df] * j, ignore_index=True)
    for i in res.index:a
        stmt = '{}(d)'.format(i)
        setp = 'from __main__ import d, {}'.format(i)
        res.at[i, j] = timeit(stmt, setp, number=50)
```

<hr>

<p><strong>Special Timing</strong><br>
Looking at the special case when we have a single non-object `dtype` for the entire data frame.
<em>Code Below</em>  </p>

```python
spec.div(spec.min())

                     10        30        100       300       1000      3000      10000     30000
mask_with_values  1.009030  1.000000  1.194276  1.000000  1.236892  1.095343  1.000000  1.000000
mask_with_in1d    1.104638  1.094524  1.156930  1.072094  1.000000  1.000000  1.040043  1.027100
reconstruct       1.000000  1.142838  1.000000  1.355440  1.650270  2.222181  2.294913  3.406735
```

Turns out, reconstruction isn't worth it past a few hundred rows.  

```python
spec.T.plot(loglog=True)
```

<a href="https://i.stack.imgur.com/K1bNc.png" rel="noreferrer"><img src="https://i.stack.imgur.com/K1bNc.png" alt="enter image description here"></a>  

<strong>Functions</strong>    

```python
np.random.seed([3,1415])
d1 = pd.DataFrame(np.random.randint(10, size=(10, 5)), columns=list('ABCDE'))

def mask_with_values(df):
    mask = df['A'].values == 'foo'
    return df[mask]

def mask_with_in1d(df):
    mask = np.in1d(df['A'].values, ['foo'])
    return df[mask]

def reconstruct(df):
    v = df.values
    mask = np.in1d(df['A'].values, ['foo'])
    return pd.DataFrame(v[mask], df.index[mask], df.columns)

spec = pd.DataFrame(
    index=['mask_with_values', 'mask_with_in1d', 'reconstruct'],
    columns=[10, 30, 100, 300, 1000, 3000, 10000, 30000],
    dtype=float
)
```

<strong>Testing</strong>    

```python
for j in spec.columns:
    d = pd.concat([df] * j, ignore_index=True)
    for i in spec.index:
        stmt = '{}(d)'.format(i)
        setp = 'from __main__ import d, {}'.format(i)
        spec.at[i, j] = timeit(stmt, setp, number=50)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: How do you change the size of figures drawn with matplotlib? (score [2126797](https://stackoverflow.com/q/332289) in )

#### Question
How do you change the size of figure drawn with matplotlib?  

#### Answer 2 (score 940)
<a href="https://matplotlib.org/api/_as_gen/matplotlib.pyplot.figure.html#matplotlib.pyplot.figure" rel="noreferrer">figure</a> tells you the call signature:  

```python
from matplotlib.pyplot import figure
figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
```

`figure(figsize=(1,1))` would create an inch-by-inch image, which would be 80-by-80 pixels unless you also give a different dpi argument.  

#### Answer 3 (score 664)
If you've already got the figure created you can quickly do this:  

```python
fig = matplotlib.pyplot.gcf()
fig.set_size_inches(18.5, 10.5)
fig.savefig('test2png.png', dpi=100)
```

To propagate the size change to an existing gui window add `forward=True`  

```python
fig.set_size_inches(18.5, 10.5, forward=True)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: How do I concatenate two lists in Python? (score [2112225](https://stackoverflow.com/q/1720421) in 2019)

#### Question
How do I concatenate two lists in Python?  

Example:  

```python
listone = [1, 2, 3]
listtwo = [4, 5, 6]
```

Expected outcome:  

```python
>>> joinedlist
[1, 2, 3, 4, 5, 6]
```

#### Answer accepted (score 3460)
You can use the `+` operator to combine them:  

```python
listone = [1,2,3]
listtwo = [4,5,6]

joinedlist = listone + listtwo
```

Output:  

```python
>>> joinedlist
[1,2,3,4,5,6]
```

#### Answer 2 (score 277)
It's also possible to create a generator that simply iterates over the items in both lists. This allows you to chain lists (or any iterable) together for processing without copying the items to a new list:  

```python
import itertools
for item in itertools.chain(listone, listtwo):
   # Do something with each list item
```

#### Answer 3 (score 196)
You can use sets to obtain merged list of unique values  

```python
mergedlist = list(set(listone + listtwo))
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: What does the "yield" keyword do? (score [2091736](https://stackoverflow.com/q/231767) in 2019)

#### Question
What is the use of the `yield` keyword in Python? What does it do?  

For example, I'm trying to understand this code<sup><strong>1</strong></sup>:  

```python
def _get_child_candidates(self, distance, min_dist, max_dist):
    if self._leftchild and distance - max_dist < self._median:
        yield self._leftchild
    if self._rightchild and distance + max_dist >= self._median:
        yield self._rightchild  
```

And this is the caller:  

```python
result, candidates = [], [self]
while candidates:
    node = candidates.pop()
    distance = node._get_dist(obj)
    if distance <= max_dist and distance >= min_dist:
        result.extend(node._values)
    candidates.extend(node._get_child_candidates(distance, min_dist, max_dist))
return result
```

<p>What happens when the method `_get_child_candidates` is called?
Is a list returned? A single element? Is it called again? When will subsequent calls stop?</p>

<hr>

<p><sub>
1. This piece of code was written by Jochen Schulz (jrschulz), who made a great Python library for metric spaces. This is the link to the complete source: <a href="http://well-adjusted.de/~jrschulz/mspace/" rel="noreferrer">Module mspace</a>.</sub></p>

#### Answer accepted (score 13854)
To understand what `yield` does, you must understand what <em>generators</em> are. And before you can understand generators, you must understand <em>iterables</em>.  

<h5>Iterables</h2>

When you create a list, you can read its items one by one. Reading its items one by one is called iteration:  

```python
>>> mylist = [1, 2, 3]
>>> for i in mylist:
...    print(i)
1
2
3
```

`mylist` is an <em>iterable</em>. When you use a list comprehension, you create a list, and so an iterable:  

```python
>>> mylist = [x*x for x in range(3)]
>>> for i in mylist:
...    print(i)
0
1
4
```

Everything you can use "`for... in...`" on is an iterable; `lists`, `strings`, files...  

These iterables are handy because you can read them as much as you wish, but you store all the values in memory and this is not always what you want when you have a lot of values.  

<h5>Generators</h2>

Generators are iterators, a kind of iterable <strong>you can only iterate over once</strong>. Generators do not store all the values in memory, <strong>they generate the values on the fly</strong>:  

```python
>>> mygenerator = (x*x for x in range(3))
>>> for i in mygenerator:
...    print(i)
0
1
4
```

It is just the same except you used `()` instead of `[]`. BUT, you <strong>cannot</strong> perform `for i in mygenerator` a second time since generators can only be used once: they calculate 0, then forget about it and calculate 1, and end calculating 4, one by one.  

<h5>Yield</h2>

`yield` is a keyword that is used like `return`, except the function will return a generator.  

```python
>>> def createGenerator():
...    mylist = range(3)
...    for i in mylist:
...        yield i*i
...
>>> mygenerator = createGenerator() # create a generator
>>> print(mygenerator) # mygenerator is an object!
<generator object createGenerator at 0xb7555c34>
>>> for i in mygenerator:
...     print(i)
0
1
4
```

Here it's a useless example, but it's handy when you know your function will return a huge set of values that you will only need to read once.  

To master `yield`, you must understand that <strong>when you call the function, the code you have written in the function body does not run.</strong> The function only returns the generator object, this is a bit tricky :-)  

Then, your code will continue from where it left off each time `for` uses the generator.  

Now the hard part:  

The first time the `for` calls the generator object created from your function, it will run the code in your function from the beginning until it hits `yield`, then it'll return the first value of the loop. Then, each other call will run the loop you have written in the function one more time, and return the next value until there is no value to return.  

The generator is considered empty once the function runs, but does not hit `yield` anymore. It can be because the loop had come to an end, or because you do not satisfy an `"if/else"` anymore.  

<hr>

<h5>Your code explained</h2>

<em>Generator:</em>  

```python
# Here you create the method of the node object that will return the generator
def _get_child_candidates(self, distance, min_dist, max_dist):

    # Here is the code that will be called each time you use the generator object:

    # If there is still a child of the node object on its left
    # AND if the distance is ok, return the next child
    if self._leftchild and distance - max_dist < self._median:
        yield self._leftchild

    # If there is still a child of the node object on its right
    # AND if the distance is ok, return the next child
    if self._rightchild and distance + max_dist >= self._median:
        yield self._rightchild

    # If the function arrives here, the generator will be considered empty
    # there is no more than two values: the left and the right children
```

<em>Caller:</em>  

```python
# Create an empty list and a list with the current object reference
result, candidates = list(), [self]

# Loop on candidates (they contain only one element at the beginning)
while candidates:

    # Get the last candidate and remove it from the list
    node = candidates.pop()

    # Get the distance between obj and the candidate
    distance = node._get_dist(obj)

    # If distance is ok, then you can fill the result
    if distance <= max_dist and distance >= min_dist:
        result.extend(node._values)

    # Add the children of the candidate in the candidate's list
    # so the loop will keep running until it will have looked
    # at all the children of the children of the children, etc. of the candidate
    candidates.extend(node._get_child_candidates(distance, min_dist, max_dist))

return result
```

This code contains several smart parts:  

<ul>
<li><p>The loop iterates on a list, but the list expands while the loop is being iterated :-) It's a concise way to go through all these nested data even if it's a bit dangerous since you can end up with an infinite loop. In this case, `candidates.extend(node._get_child_candidates(distance, min_dist, max_dist))` exhaust all the values of the generator, but `while` keeps creating new generator objects which will produce different values from the previous ones since it's not applied on the same node.</p></li>
<li><p>The `extend()` method is a list object method that expects an iterable and adds its values to the list.</p></li>
</ul>

Usually we pass a list to it:  

```python
>>> a = [1, 2]
>>> b = [3, 4]
>>> a.extend(b)
>>> print(a)
[1, 2, 3, 4]
```

But in your code, it gets a generator, which is good because:  

<ol>
<li>You don't need to read the values twice.</li>
<li>You may have a lot of children and you don't want them all stored in memory.</li>
</ol>

And it works because Python does not care if the argument of a method is a list or not. Python expects iterables so it will work with strings, lists, tuples, and generators! This is called duck typing and is one of the reasons why Python is so cool. But this is another story, for another question...  

You can stop here, or read a little bit to see an advanced use of a generator:  

<h5>Controlling a generator exhaustion</h2>

```python
>>> class Bank(): # Let's create a bank, building ATMs
...    crisis = False
...    def create_atm(self):
...        while not self.crisis:
...            yield "$100"
>>> hsbc = Bank() # When everything's ok the ATM gives you as much as you want
>>> corner_street_atm = hsbc.create_atm()
>>> print(corner_street_atm.next())
$100
>>> print(corner_street_atm.next())
$100
>>> print([corner_street_atm.next() for cash in range(5)])
['$100', '$100', '$100', '$100', '$100']
>>> hsbc.crisis = True # Crisis is coming, no more money!
>>> print(corner_street_atm.next())
<type 'exceptions.StopIteration'>
>>> wall_street_atm = hsbc.create_atm() # It's even true for new ATMs
>>> print(wall_street_atm.next())
<type 'exceptions.StopIteration'>
>>> hsbc.crisis = False # The trouble is, even post-crisis the ATM remains empty
>>> print(corner_street_atm.next())
<type 'exceptions.StopIteration'>
>>> brand_new_atm = hsbc.create_atm() # Build a new one to get back in business
>>> for cash in brand_new_atm:
...    print cash
$100
$100
$100
$100
$100
$100
$100
$100
$100
...
```

<strong>Note:</strong> For Python 3, use`print(corner_street_atm.__next__())` or `print(next(corner_street_atm))`  

It can be useful for various things like controlling access to a resource.  

<h5>Itertools, your best friend</h2>

<p>The itertools module contains special functions to manipulate iterables. Ever wish to duplicate a generator?
Chain two generators? Group values in a nested list with a one-liner? `Map / Zip` without creating another list?</p>

Then just `import itertools`.  

An example? Let's see the possible orders of arrival for a four-horse race:  

```python
>>> horses = [1, 2, 3, 4]
>>> races = itertools.permutations(horses)
>>> print(races)
<itertools.permutations object at 0xb754f1dc>
>>> print(list(itertools.permutations(horses)))
[(1, 2, 3, 4),
 (1, 2, 4, 3),
 (1, 3, 2, 4),
 (1, 3, 4, 2),
 (1, 4, 2, 3),
 (1, 4, 3, 2),
 (2, 1, 3, 4),
 (2, 1, 4, 3),
 (2, 3, 1, 4),
 (2, 3, 4, 1),
 (2, 4, 1, 3),
 (2, 4, 3, 1),
 (3, 1, 2, 4),
 (3, 1, 4, 2),
 (3, 2, 1, 4),
 (3, 2, 4, 1),
 (3, 4, 1, 2),
 (3, 4, 2, 1),
 (4, 1, 2, 3),
 (4, 1, 3, 2),
 (4, 2, 1, 3),
 (4, 2, 3, 1),
 (4, 3, 1, 2),
 (4, 3, 2, 1)]
```

<h5>Understanding the inner mechanisms of iteration</h2>

<p>Iteration is a process implying iterables (implementing the `__iter__()` method) and iterators (implementing the `__next__()` method).
Iterables are any objects you can get an iterator from. Iterators are objects that let you iterate on iterables.</p>

There is more about it in this article about <a href="http://effbot.org/zone/python-for-statement.htm" rel="noreferrer">how `for` loops work</a>.  

#### Answer 2 (score 1872)
<h5>Shortcut to understanding `yield`</h2>

When you see a function with `yield` statements, apply this easy trick to understand what will happen:  

<ol>
<li>Insert a line `result = []` at the start of the function.</li>
<li>Replace each `yield expr` with `result.append(expr)`.</li>
<li>Insert a line `return result` at the bottom of the function.</li>
<li>Yay - no more `yield` statements! Read and figure out code.</li>
<li>Compare function to original definition.</li>
</ol>

This trick may give you an idea of the logic behind the function, but what actually happens with `yield` is significantly different that what happens in the list based approach. In many cases the yield approach will be a lot more memory efficient and faster too. In other cases this trick will get you stuck in an infinite loop, even though the original function works just fine. Read on to learn more...  

<h5>Don't confuse your Iterables, Iterators and Generators</h2>

First, the <strong>iterator protocol</strong> - when you write  

```python
for x in mylist:
    ...loop body...
```

Python performs the following two steps:  

<ol>
<li><p>Gets an iterator for `mylist`:</p>

Call `iter(mylist)` -> this returns an object with a `next()` method (or `__next__()` in Python 3).  

[This is the step most people forget to tell you about]  </li>
<li><p>Uses the iterator to loop over items:</p>

Keep calling the `next()` method on the iterator returned from step 1. The return value from `next()` is assigned to `x` and the loop body is executed. If an exception `StopIteration` is raised from within `next()`, it means there are no more values in the iterator and the loop is exited.  </li>
</ol>

The truth is Python performs the above two steps anytime it wants to <em>loop over</em> the contents of an object - so it could be a for loop, but it could also be code like `otherlist.extend(mylist)` (where `otherlist` is a Python list).  

Here `mylist` is an <em>iterable</em> because it implements the iterator protocol. In a user defined class, you can implement the `__iter__()` method to make instances of your class iterable. This method should return an <em>iterator</em>. An iterator is an object with a `next()` method. It is possible to implement both `__iter__()` and `next()` on the same class, and have `__iter__()` return `self`. This will work for simple cases, but not when you want two iterators looping over the same object at the same time.  

So that's the iterator protocol, many objects implement this protocol:  

<ol>
<li>Built-in lists, dictionaries, tuples, sets, files.</li>
<li>User defined classes that implement `__iter__()`.</li>
<li>Generators.</li>
</ol>

Note that a `for` loop doesn't know what kind of object it's dealing with - it just follows the iterator protocol, and is happy to get item after item as it calls `next()`. Built-in lists return their items one by one, dictionaries return the <em>keys</em> one by one, files return the <em>lines</em> one by one, etc. And generators return... well that's where `yield` comes in:  

```python
def f123():
    yield 1
    yield 2
    yield 3

for item in f123():
    print item
```

Instead of `yield` statements, if you had three `return` statements in `f123()` only the first would get executed, and the function would exit. But `f123()` is no ordinary function. When `f123()` is called, it <em>does not</em> return any of the values in the yield statements! It returns a generator object. Also, the function does not really exit - it goes into a suspended state. When the `for` loop tries to loop over the generator object, the function resumes from its suspended state at the very next line after the `yield` it previously returned from, executes the next line of code, in this case a `yield` statement, and returns that as the next item. This happens until the function exits, at which point the generator raises `StopIteration`, and the loop exits.   

So the generator object is sort of like an adapter - at one end it exhibits the iterator protocol, by exposing `__iter__()` and `next()` methods to keep the `for` loop happy. At the other end however, it runs the function just enough to get the next value out of it, and puts it back in suspended mode.  

<h5>Why Use Generators?</h2>

Usually you can write code that doesn't use generators but implements the same logic. One option is to use the temporary list 'trick' I mentioned before. That will not work in all cases, for e.g. if you have infinite loops, or it may make inefficient use of memory when you have a really long list. The other approach is to implement a new iterable class `SomethingIter` that keeps state in instance members and performs the next logical step in it's `next()` (or `__next__()` in Python 3) method. Depending on the logic, the code inside the `next()` method may end up looking very complex and be prone to bugs. Here generators provide a clean and easy solution.  

#### Answer 3 (score 504)
Think of it this way:  

An iterator is just a fancy sounding term for an object that has a `next()` method.  So a yield-ed function ends up being something like this:  

Original version:  

```python
def some_function():
    for i in xrange(4):
        yield i

for i in some_function():
    print i
```

This is basically what the Python interpreter does with the above code:  

```python
class it:
    def __init__(self):
        # Start at -1 so that we get 0 when we add 1 below.
        self.count = -1

    # The __iter__ method will be called once by the 'for' loop.
    # The rest of the magic happens on the object returned by this method.
    # In this case it is the object itself.
    def __iter__(self):
        return self

    # The next method will be called repeatedly by the 'for' loop
    # until it raises StopIteration.
    def next(self):
        self.count += 1
        if self.count < 4:
            return self.count
        else:
            # A StopIteration exception is raised
            # to signal that the iterator is done.
            # This is caught implicitly by the 'for' loop.
            raise StopIteration

def some_func():
    return it()

for i in some_func():
    print i
```

For more insight as to what's happening behind the scenes, the `for` loop can be rewritten to this:  

```python
iterator = some_func()
try:
    while 1:
        print iterator.next()
except StopIteration:
    pass
```

Does that make more sense or just confuse you more?  :)  

I should note that this <em>is</em> an oversimplification for illustrative purposes. :)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: How to define a two-dimensional array in Python (score [2033452](https://stackoverflow.com/q/6667201) in 2017)

#### Question
I want to define a two-dimensional array without an initialized length like this:  

```python
Matrix = [][]
```

but it does not work...  

I've tried the code below, but it is wrong too:  

```python
Matrix = [5][5]
```

<strong><em>Error:</em></strong>  

```python
Traceback ...

IndexError: list index out of range
```

What is my mistake?  

#### Answer accepted (score 916)
<p>You're technically trying to index an uninitialized array. You have to first initialize the outer list with lists before adding items; Python calls this
"list comprehension".</p>

```python
# Creates a list containing 5 lists, each of 8 items, all set to 0
w, h = 8, 5;
Matrix = [[0 for x in range(w)] for y in range(h)] 
```

<h5>You can now add items to the list:</h1>

```python
Matrix[0][0] = 1
Matrix[6][0] = 3 # error! range... 
Matrix[0][6] = 3 # valid
```

Note that the matrix is "y" address major, in other words, the "y index" comes before the "x index".  

```python
print Matrix[0][0] # prints 1
x, y = 0, 6 
print Matrix[x][y] # prints 3; be careful with indexing! 
```

Although you can name them as you wish, I look at it this way to avoid some confusion that could arise with the indexing, if you use "x" for both the inner and outer lists, and want a non-square Matrix.  

#### Answer 2 (score 373)
If you really want a matrix, you might be better off using `numpy`. Matrix operations in `numpy` most often use an array type with two dimensions. There are many ways to create a new array; one of the most useful is the `zeros` function, which takes a shape parameter and returns an array of the given shape, with the values initialized to zero:  

```python
>>> import numpy
>>> numpy.zeros((5, 5))
array([[ 0.,  0.,  0.,  0.,  0.],
       [ 0.,  0.,  0.,  0.,  0.],
       [ 0.,  0.,  0.,  0.,  0.],
       [ 0.,  0.,  0.,  0.,  0.],
       [ 0.,  0.,  0.,  0.,  0.]])
```

`numpy` provides a `matrix` type as well. It's less commonly used, and some people <a href="https://stackoverflow.com/a/3892639/577088">recommend against</a> using it. But it's useful for people coming to `numpy` from Matlab, and in some other contexts. I thought I'd include it since we're talking about matrices!  

```python
>>> numpy.matrix([[1, 2], [3, 4]])
matrix([[1, 2],
        [3, 4]])
```

Here are some other ways to create 2-d arrays and matrices (with output removed for compactness):  

```python
numpy.matrix('1 2; 3 4')                 # use Matlab-style syntax
numpy.arange(25).reshape((5, 5))         # create a 1-d range and reshape
numpy.array(range(25)).reshape((5, 5))   # pass a Python range and reshape
numpy.array([5] * 25).reshape((5, 5))    # pass a Python list and reshape
numpy.empty((5, 5))                      # allocate, but don't initialize
numpy.ones((5, 5))                       # initialize with ones
numpy.ndarray((5, 5))                    # use the low-level constructor
```

#### Answer 3 (score 310)
Here is a shorter notation for initializing a list of lists:  

```python
matrix = [[0]*5 for i in range(5)]
```

Unfortunately shortening this to something like `5*[5*[0]]` doesn't really work because you end up with 5 copies of the same list, so when you modify one of them they all change, for example:  

```python
>>> matrix = 5*[5*[0]]
>>> matrix
[[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]
>>> matrix[4][4] = 2
>>> matrix
[[0, 0, 0, 0, 2], [0, 0, 0, 0, 2], [0, 0, 0, 0, 2], [0, 0, 0, 0, 2], [0, 0, 0, 0, 2]]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: How do I install pip on macOS or OS X? (score [1952317](https://stackoverflow.com/q/17271319) in 2017)

#### Question
I spent most of the day yesterday searching for a clear answer for installing `pip` (package manager for Python). I can't find a good solution.  

How do I install it?  

#### Answer 2 (score 3197)
```python
easy_install pip
```

<hr>

If you need admin privileges to run this, try:  

```python
sudo easy_install pip
```

<hr>

<strong>UPDATE (Jan 2019):</strong>  

`easy_install` has been <a href="https://setuptools.readthedocs.io/en/latest/easy_install.html" rel="noreferrer">deprecated</a>. Please use <a href="https://pip.pypa.io/en/stable/installing/#installing-with-get-pip-py" rel="noreferrer">`get-pip.py`</a> instead.  

#### Answer 3 (score 542)
<blockquote>
  ⚡️ <strong>TL;DR</strong> — One line solution.  
</blockquote>

All you have to do is:  

```python
sudo easy_install pip
```

<blockquote>
  <strong>2019</strong>: ⚠️`easy_install` has been <a href="https://setuptools.readthedocs.io/en/latest/easy_install.html" rel="noreferrer">deprecated</a>. Check <strong>Method #2</strong> below for preferred installation!  
</blockquote>

<em>I made a gif, coz. why not?</em>  

<a href="https://ahmadawais.com/install-pip-macos-os-x-python/" rel="noreferrer"><img src="https://on.ahmda.ws/rsgI/c" alt="Install PIP on Mac"></a>  

<strong>Details:</strong>  

<blockquote>
  ⚡️ OK, I read the solutions given above, but here's an <strong>EASY</strong> solution to install `pip`.   
</blockquote>

MacOS comes with `Python` installed. But to make sure that you have `Python` installed open the terminal and run the following command.  

```python
python --version
```

If this command returns a version number that means `Python` exists. Which also means that you already have access to `easy_install` considering you are using `macOS/OSX`.  

ℹ️ Now, all you have to do is run the following command.  

```python
sudo easy_install pip
```

After that, `pip` will be installed and you'll be able to use it for installing other packages.  

Let me know if you have any problems installing `pip` this way.  

Cheers!   

P.S. I ended up blogging a post about it. <a href="https://ahmadawais.com/install-pip-macos-os-x-python/" rel="noreferrer">QuickTip: How Do I Install pip on macOS or OS X?</a>  

<hr>

<blockquote>
  ✅ <strong>UPDATE (Jan 2019): METHOD #2: Two line solution —</strong>  
</blockquote>

`easy_install` has been <a href="https://setuptools.readthedocs.io/en/latest/easy_install.html" rel="noreferrer">deprecated</a>. Please use <a href="https://pip.pypa.io/en/stable/installing/#installing-with-get-pip-py" rel="noreferrer">`get-pip.py`</a> instead.  

First of all download the `get-pip` file  

```python
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
```

Now run this file to install `pip`  

```python
python get-pip.py
```

That should do it.   

Another gif you said? Here ya go!  

<a href="https://i.stack.imgur.com/UXG0G.gif" rel="noreferrer"><img src="https://i.stack.imgur.com/UXG0G.gif" alt="Manual install of pip"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: Convert bytes to a string (score [1932306](https://stackoverflow.com/q/606191) in 2019)

#### Question
I'm using this code to get standard output from an external program:  

```python
>>> from subprocess import *
>>> command_stdout = Popen(['ls', '-l'], stdout=PIPE).communicate()[0]
```

The communicate() method returns an array of bytes:  

```python
>>> command_stdout
b'total 0\n-rw-rw-r-- 1 thomas thomas 0 Mar  3 07:03 file1\n-rw-rw-r-- 1 thomas thomas 0 Mar  3 07:03 file2\n'
```

However, I'd like to work with the output as a normal Python string. So that I could print it like this:  

```python
>>> print(command_stdout)
-rw-rw-r-- 1 thomas thomas 0 Mar  3 07:03 file1
-rw-rw-r-- 1 thomas thomas 0 Mar  3 07:03 file2
```

I thought that's what the <a href="http://docs.python.org/3.0/library/binascii.html?highlight=b2a#binascii.b2a_qp" rel="noreferrer">binascii.b2a_qp()</a> method is for, but when I tried it, I got the same byte array again:  

```python
>>> binascii.b2a_qp(command_stdout)
b'total 0\n-rw-rw-r-- 1 thomas thomas 0 Mar  3 07:03 file1\n-rw-rw-r-- 1 thomas thomas 0 Mar  3 07:03 file2\n'
```

How do I convert the bytes value back to string? I mean, using the "batteries" instead of doing it manually. And I'd like it to be OK with Python&nbsp;3.  

#### Answer accepted (score 3076)
You need to decode the bytes object to produce a string:  

```python
>>> b"abcde"
b'abcde'

# utf-8 is used here because it is a very common encoding, but you
# need to use the encoding your data is actually in.
>>> b"abcde".decode("utf-8") 
'abcde'
```

#### Answer 2 (score 173)
You need to decode the byte string and turn it in to a character (Unicode) string.  

On Python 2  

```python
encoding = 'utf-8'
'hello'.decode(encoding)
```

or  

```python
unicode('hello', encoding)
```

On Python 3  

```python
encoding = 'utf-8'
b'hello'.decode(encoding)
```

or  

```python
str(b'hello', encoding)
```

#### Answer 3 (score 159)
I think this way is easy:  

```python
bytes_data = [112, 52, 52]
"".join(map(chr, bytes_data))
>> p44
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: Correct way to write line to file? (score [1928059](https://stackoverflow.com/q/6159900) in 2017)

#### Question
I'm used to doing `print &gt;&gt;f, "hi there"`  

However, it seems that `print &gt;&gt;` is getting deprecated. What is the recommended way to do the line above?  

<p><b>Update</b>:
Regarding all those answers with `"\n"`...is this universal or Unix-specific? IE, should I be doing `"\r\n"` on Windows?</p>

#### Answer accepted (score 991)
This should be as simple as:  

```python
with open('somefile.txt', 'a') as the_file:
    the_file.write('Hello\n')
```

From The Documentation:  

<blockquote>
  Do not use `os.linesep` as a line terminator when writing files opened in text mode (the default); use a single '\n' instead, on all platforms.  
</blockquote>

Some useful reading:  

<ul>
<li><a href="http://docs.python.org/reference/compound_stmts.html#the-with-statement" rel="noreferrer">The `with` statement</a></li>
<li><a href="http://docs.python.org/library/functions.html?highlight=open#open" rel="noreferrer">`open()`</a>

<ul>
<li>'a' is for append, or use</li>
<li>'w' to write with truncation</li>
</ul></li>
<li><a href="http://docs.python.org/library/os.html" rel="noreferrer">`os`</a> (particularly <a href="http://docs.python.org/library/os.html?highlight=os.linesep#os.linesep" rel="noreferrer">`os.linesep`</a>)</li>
</ul>

#### Answer 2 (score 943)
You should use the `print()` function which is available since Python 2.6+  

```python
from __future__ import print_function  # Only needed for Python 2
print("hi there", file=f)
```

For Python 3 you don't need the `import`, since the  `print()` function is the default.  

The alternative would be to use:  

```python
f = open('myfile', 'w')
f.write('hi there\n')  # python will convert \n to os.linesep
f.close()  # you can omit in most cases as the destructor will call it
```

Quoting from <a href="https://docs.python.org/2/tutorial/inputoutput.html#reading-and-writing-files">Python documentation</a> regarding newlines:  

<blockquote>
  On output, if newline is None, any `'\n'` characters written are translated to the system default line separator, `os.linesep`. If newline is `''`, no translation takes place. If newline is any of the other legal values, any `'\n'` characters written are translated to the given string.  
</blockquote>

#### Answer 3 (score 107)
The <a href="http://docs.python.org/tutorial/inputoutput.html" rel="noreferrer">python docs</a> recommend this way:  

```python
with open('file_to_write', 'w') as f:
    f.write('file contents')
```

So this is the way I usually do it :)  

Statement from <a href="http://docs.python.org/tutorial/inputoutput.html" rel="noreferrer">docs.python.org</a>:  

<blockquote>
  <p>It is good practice to use the <strong>'with'</strong> keyword when dealing with file
  objects. This has the advantage that the file is properly closed after
  its suite finishes, even if an exception is raised on the way. It is
  also much shorter than writing equivalent try-finally blocks.</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: Accessing the index in 'for' loops? (score [1900009](https://stackoverflow.com/q/522563) in 2019)

#### Question
How do I access the index in a `for` loop like the following?  

```python
ints = [8, 23, 45, 12, 78]
for i in ints:
    print('item #{} = {}'.format(???, i))
```

I want to get this output:  

```python
item #1 = 8
item #2 = 23
item #3 = 45
item #4 = 12
item #5 = 78
```

When I loop through it using a `for` loop, how do I access the loop index, from 1 to 5 in this case?  

#### Answer accepted (score 5577)
Using an additional state variable, such as an index variable (which you would normally use in languages such as C or PHP), is considered non-pythonic.  

The better option is to use the built-in function <a href="https://docs.python.org/3/library/functions.html#enumerate" rel="noreferrer" title="enumerate">`enumerate()`</a>, available in both Python 2 and 3:  

```python
for idx, val in enumerate(ints):
    print(idx, val)
```

Check out <a href="https://www.python.org/dev/peps/pep-0279/" rel="noreferrer" title="PEP 279">PEP 279</a> for more.  

#### Answer 2 (score 700)
<blockquote>
  <h5>Using a for loop, how do I access the loop index, from 1 to 5 in this case?</h1>
</blockquote>

Use `enumerate` to get the index with the element as you iterate:  

```python
for index, item in enumerate(items):
    print(index, item)
```

And note that Python's indexes start at zero, so you would get 0 to 4 with the above. If you want the count, 1 to 5, do this:  

```python
for count, item in enumerate(items, start=1):
    print(count, item)
```

<h5>Unidiomatic control flow</h1>

What you are asking for is the Pythonic equivalent of the following, which is the algorithm most programmers of lower-level languages would use:  

<blockquote>
```python
index = 0            # Python's indexing starts at zero
for item in items:   # Python's for loops are a "for each" loop 
    print(index, item)
    index += 1
```
</blockquote>

Or in languages that do not have a for-each loop:  

<blockquote>
```python
index = 0
while index < len(items):
    print(index, items[index])
    index += 1
```
</blockquote>

or sometimes more commonly (but unidiomatically) found in Python:  

<blockquote>
```python
for index in range(len(items)):
    print(index, items[index])
```
</blockquote>

<h5>Use the Enumerate Function</h1>

Python's <a href="https://docs.python.org/2/library/functions.html#enumerate" rel="noreferrer">`enumerate` function</a> reduces the visual clutter by hiding the accounting for the indexes, and encapsulating the iterable into another iterable (an `enumerate` object) that yields a two-item tuple of the index and the item that the original iterable would provide. That looks like this:  

```python
for index, item in enumerate(items, start=0):   # default is zero
    print(index, item)
```

This code sample is fairly well the <a href="http://python.net/~goodger/projects/pycon/2007/idiomatic/handout.html#index-item-2-enumerate" rel="noreferrer">canonical</a> example of the difference between code that is idiomatic of Python and code that is not. Idiomatic code is sophisticated (but not complicated) Python, written in the way that it was intended to be used. Idiomatic code is expected by the designers of the language, which means that usually this code is not just more readable, but also more efficient.  

<h5>Getting a count</h2>

Even if you don't need indexes as you go, but you need a count of the iterations (sometimes desirable) you can start with `1` and the final number will be your count.  

```python
for count, item in enumerate(items, start=1):   # default is zero
    print(item)

print('there were {0} items printed'.format(count))
```

The count seems to be more what you intend to ask for (as opposed to index) when you said you wanted from 1 to 5.  

<hr>

<h5>Breaking it down - a step by step explanation</h2>

To break these examples down, say we have a list of items that we want to iterate over with an index:  

```python
items = ['a', 'b', 'c', 'd', 'e']
```

Now we pass this iterable to enumerate, creating an enumerate object:  

```python
enumerate_object = enumerate(items) # the enumerate object
```

We can pull the first item out of this iterable that we would get in a loop with the `next` function:  

```python
iteration = next(enumerate_object) # first iteration from enumerate
print(iteration)
```

And we see we get a tuple of `0`, the first index, and `'a'`, the first item:  

```python
(0, 'a')
```

we can use what is referred to as "<a href="https://docs.python.org/2/tutorial/datastructures.html#tuples-and-sequences" rel="noreferrer">sequence unpacking</a>" to extract the elements from this two-tuple:  

```python
index, item = iteration
#   0,  'a' = (0, 'a') # essentially this.
```

and when we inspect `index`, we find it refers to the first index, 0, and `item` refers to the first item, `'a'`.  

```python
>>> print(index)
0
>>> print(item)
a
```

<h5>Conclusion</h1>

<ul>
<li>Python indexes start at zero</li>
<li>To get these indexes from an iterable as you iterate over it, use the enumerate function</li>
<li>Using enumerate in the idiomatic way (along with tuple unpacking) creates code that is more readable and maintainable:</li>
</ul>

So do this:  

```python
for index, item in enumerate(items, start=0):   # Python indexes start at zero
    print(index, item)
```

#### Answer 3 (score 132)
It's pretty simple to start it from `1` other than `0`:  

```python
for index, item in enumerate(iterable, start=1):
   print index, item
```

<h5>Note</h2>

<p>Important hint, though a little misleading since `index` will be a `tuple` `(idx, item)` here.
Good to go.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: How to iterate over rows in a DataFrame in Pandas? (score [1869294](https://stackoverflow.com/q/16476924) in 2018)

#### Question
I have a `DataFrame` from pandas:  

```python
import pandas as pd
inp = [{'c1':10, 'c2':100}, {'c1':11,'c2':110}, {'c1':12,'c2':120}]
df = pd.DataFrame(inp)
print df
```

Output:  

```python
   c1   c2
0  10  100
1  11  110
2  12  120
```

Now I want to iterate over the rows of this frame. For every row I want to be able to access its elements (values in cells) by the name of the columns. For example:  

```python
for row in df.rows:
   print row['c1'], row['c2']
```

Is it possible to do that in pandas?  

I found this <a href="https://stackoverflow.com/questions/7837722/what-is-the-most-efficient-way-to-loop-through-dataframes-with-pandas">similar question</a>. But it does not give me the answer I need. For example, it is suggested there to use:  

```python
for date, row in df.T.iteritems():
```

or  

```python
for row in df.iterrows():
```

But I do not understand what the `row` object is and how I can work with it.  

#### Answer accepted (score 2033)
<a href="http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.iterrows.html#pandas.DataFrame.iterrows" rel="noreferrer">DataFrame.iterrows</a> is a generator which yield both index and row  

```python
import pandas as pd
import numpy as np

df = pd.DataFrame([{'c1':10, 'c2':100}, {'c1':11,'c2':110}, {'c1':12,'c2':120}])
```

  

```python
for index, row in df.iterrows():
    print(row['c1'], row['c2'])

Output: 
   10 100
   11 110
   12 120
```

#### Answer 2 (score 314)
First consider if you really need to <em>iterate</em> over rows in a DataFrame. See <a href="https://stackoverflow.com/a/55557758/3844376">this answer</a> for alternatives.  

If you still need to iterate over rows, you can use methods below. Note some  <strong>important caveats</strong> which are not mentioned in any of the other answers.  

<ul>
<li><p><a href="http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.iterrows.html" rel="noreferrer">DataFrame.iterrows()</a></p>

```python
for index, row in df.iterrows():
    print row["c1"], row["c2"]
```</li>
<li><p><a href="http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.itertuples.html" rel="noreferrer">DataFrame.itertuples()</a></p>

```python
for row in df.itertuples(index=True, name='Pandas'):
    print getattr(row, "c1"), getattr(row, "c2")
```</li>
</ul>

`itertuples()` is supposed to be faster than `iterrows()`  

But be aware, according to the docs (pandas 0.24.2 at the moment):  

<ul>
<li><p>iterrows: `dtype` might not match from row to row</p>

<blockquote>
  Because iterrows returns a Series for each row, it <strong>does not preserve</strong> dtypes across the rows (dtypes are preserved across columns for DataFrames). To preserve dtypes while iterating over the rows, it is better to use itertuples() which returns namedtuples of the values and which is generally much faster than iterrows()  
</blockquote></li>
<li><p>iterrows: Do not modify rows</p>

<blockquote>
  You should <strong>never modify</strong> something you are iterating over. This is not guaranteed to work in all cases. Depending on the data types, the iterator returns a copy and not a view, and writing to it will have no effect.  
</blockquote>

Use <a href="http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.apply.html" rel="noreferrer">DataFrame.apply()</a> instead:  

```python
new_df = df.apply(lambda x: x * 2)
```</li>
<li><p>itertuples: </p>

<blockquote>
  The column names will be renamed to positional names if they are invalid Python identifiers, repeated, or start with an underscore. With a large number of columns (>255), regular tuples are returned.  
</blockquote></li>
</ul>

See <a href="https://pandas.pydata.org/pandas-docs/stable/getting_started/basics.html#iteration" rel="noreferrer">pandas docs on iteration</a> for more details.  

#### Answer 3 (score 188)
You should use <a href="http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.iterrows.html">`df.iterrows()`</a>. Though iterating row-by-row is not especially efficient since Series objects have to be created.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: Selecting multiple columns in a pandas dataframe (score [1863876](https://stackoverflow.com/q/11285613) in 2018)

#### Question
I have data in different columns but I don't know how to extract it to save it in another variable.  

```python
index  a   b   c
1      2   3   4
2      3   4   5
```

How do I select `'a'`, `'b'` and save it in to df1?  

I tried   

```python
df1 = df['a':'b']
df1 = df.ix[:, 'a':'b']
```

None seem to work.  

#### Answer accepted (score 1472)
The column names (which are strings) cannot be sliced in the manner you tried.  

Here you have a couple of options. If you know from context which variables you want to slice out, you can just return a view of only those columns by passing a list into the `__getitem__` syntax (the []'s).  

```python
df1 = df[['a','b']]
```

Alternatively, if it matters to index them numerically and not by their name (say your code should automatically do this without knowing the names of the first two columns) then you can do this instead:  

```python
df1 = df.iloc[:,0:2] # Remember that Python does not slice inclusive of the ending index.
```

Additionally, you should familiarize yourself with the idea of a view into a Pandas object vs. a copy of that object. The first of the above methods will return a new copy in memory of the desired sub-object (the desired slices).   

Sometimes, however, there are indexing conventions in Pandas that don't do this and instead give you a new variable that just refers to the same chunk of memory as the sub-object or slice in the original object. This will happen with the second way of indexing, so you can modify it with the `copy()` function to get a regular copy. When this happens, changing what you think is the sliced object can sometimes alter the original object. Always good to be on the look out for this.  

```python
df1 = df.iloc[0,0:2].copy() # To avoid the case where changing df1 also changes df
```

To use `iloc`, you need to know the column positions (or indices). As the column positions may change, instead of hard-coding indices, you can use `iloc` along with `get_loc` function of `columns` method of dataframe object to obtain column indices.  

```python
{df.columns.get_loc(c):c for idx, c in enumerate(df.columns)}
```

Now you can use this dictionary to access columns through names and using `iloc`.   

#### Answer 2 (score 100)
<p>Assuming your column names (`df.columns`) are `['index','a','b','c']`, then the data you want is in the 
3rd &amp; 4th columns. If you don't know their names when your script runs, you can do this</p>

```python
newdf = df[df.columns[2:4]] # Remember, Python is 0-offset! The "3rd" entry is at slot 2.
```

As EMS points out in <a href="https://stackoverflow.com/a/11287278/623735">his answer</a>, `df.ix` slices columns a bit more concisely, but the `.columns` slicing interface might be more natural because it uses the vanilla 1-D python list indexing/slicing syntax.  

WARN: `'index'` is a bad name for a `DataFrame` column. That same label is also used for the real `df.index` attribute, a `Index` array. So your column is returned by `df['index']` and the real DataFrame index is returned by `df.index`. An `Index` is a special kind of `Series` optimized for lookup of it's elements' values. For df.index it's for looking up rows by their label. That `df.columns` attribute is also a `pd.Index` array, for looking up columns by their labels.  

#### Answer 3 (score 96)
As of version 0.11.0, columns <em>can be</em> sliced in the manner you tried using the <a href="http://pandas-docs.github.io/pandas-docs-travis/whatsnew/v0.11.0.html#selection-choices" rel="noreferrer">`.loc`</a> indexer:   

```python
df.loc[:, 'C':'E']
```

is equivalent of  

```python
df[['C', 'D', 'E']]  # or df.loc[:, ['C', 'D', 'E']]
```

and returns columns `C` through `E`.  

<hr>

A demo on a randomly generated DataFrame:  

```python
import pandas as pd
import numpy as np
np.random.seed(5)
df = pd.DataFrame(np.random.randint(100, size=(100, 6)), 
                  columns=list('ABCDEF'), 
                  index=['R{}'.format(i) for i in range(100)])
df.head()

Out: 
     A   B   C   D   E   F
R0  99  78  61  16  73   8
R1  62  27  30  80   7  76
R2  15  53  80  27  44  77
R3  75  65  47  30  84  86
R4  18   9  41  62   1  82
```

To get the columns from C to E (note that unlike integer slicing, 'E' is included in the columns):  

```python
df.loc[:, 'C':'E']

Out: 
      C   D   E
R0   61  16  73
R1   30  80   7
R2   80  27  44
R3   47  30  84
R4   41  62   1
R5    5  58   0
...
```

Same works for selecting rows based on labels. Get the rows 'R6' to 'R10' from those columns:  

```python
df.loc['R6':'R10', 'C':'E']

Out: 
      C   D   E
R6   51  27  31
R7   83  19  18
R8   11  67  65
R9   78  27  29
R10   7  16  94
```

`.loc` also accepts a boolean array so you can select the columns whose corresponding entry in the array is `True`. For example, `df.columns.isin(list('BCD'))` returns `array([False,  True,  True,  True, False, False], dtype=bool)` - True if the column name is in the list `['B', 'C', 'D']`; False, otherwise.  

```python
df.loc[:, df.columns.isin(list('BCD'))]

Out: 
      B   C   D
R0   78  61  16
R1   27  30  80
R2   53  80  27
R3   65  47  30
R4    9  41  62
R5   78   5  58
...
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Python's equivalent of && (logical-and) in an if-statement (score [1813435](https://stackoverflow.com/q/2485466) in 2018)

#### Question
Here's my code:  

```python
def front_back(a, b):
  # +++your code here+++
  if len(a) % 2 == 0 && len(b) % 2 == 0:
    return a[:(len(a)/2)] + b[:(len(b)/2)] + a[(len(a)/2):] + b[(len(b)/2):] 
  else:
    #todo! Not yet done. :P
  return
```

I'm getting an error in the IF conditional. What am I doing wrong?  

#### Answer accepted (score 1338)
You would want `and` instead of `&amp;&amp;`.  

#### Answer 2 (score 214)
Python uses `and` and `or` conditionals.  

i.e.  

```python
if foo == 'abc' and bar == 'bac' or zoo == '123':
  # do something
```

#### Answer 3 (score 36)
Two comments:  

<ul>
<li>Use `and` and `or` for logical operations in Python.</li>
<li>Use 4 spaces to indent instead of 2.  You will thank yourself later because your code will look pretty much the same as everyone else's code.  See <a href="http://www.python.org/dev/peps/pep-0008/" rel="noreferrer">PEP 8</a> for more details.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: Getting the last element of a list (score [1789328](https://stackoverflow.com/q/930397) in 2019)

#### Question
In Python, how do you get the last element of a list?  

#### Answer accepted (score 2780)
`some_list[-1]` is the shortest and most Pythonic.  

In fact, you can do much more with this syntax. The `some_list[-n]` syntax gets the nth-to-last element. So `some_list[-1]` gets the last element, `some_list[-2]` gets the second to last, etc, all the way down to `some_list[-len(some_list)]`, which gives you the first element.  

You can also set list elements in this way. For instance:  

```python
>>> some_list = [1, 2, 3]
>>> some_list[-1] = 5 # Set the last element
>>> some_list[-2] = 3 # Set the second to last element
>>> some_list
[1, 3, 5]
```

Note that getting a list item by index will raise an <a href="https://docs.python.org/3/library/exceptions.html#IndexError" rel="noreferrer">`IndexError`</a> if the expected item doesn't exist. This means that `some_list[-1]` will raise an exception if `some_list` is empty, because an empty list can't have a last element.  

#### Answer 2 (score 224)
If your `str()` or `list()` objects might end up being empty as so: `astr = ''` or `alist = []`, then you might want to use `alist[-1:]` instead of `alist[-1]` for object "sameness".  

The significance of this is:  

```python
alist = []
alist[-1]   # will generate an IndexError exception whereas 
alist[-1:]  # will return an empty list
astr = ''
astr[-1]    # will generate an IndexError exception whereas
astr[-1:]   # will return an empty str
```

Where the distinction being made is that returning an empty list object or empty str object is more "last element"-like then an exception object.  

#### Answer 3 (score 86)
You can also do:  

```python
alist.pop()
```

It depends on what you want to do with your list because the `pop()` method will delete the last element.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Adding new column to existing DataFrame in Python pandas (score [1789112](https://stackoverflow.com/q/12555323) in 2017)

#### Question
I have the following indexed DataFrame with named columns and rows not- continuous numbers:  

```python
          a         b         c         d
2  0.671399  0.101208 -0.181532  0.241273
3  0.446172 -0.243316  0.051767  1.577318
5  0.614758  0.075793 -0.451460 -0.012493
```

I would like to add a new column, `'e'`, to the existing data frame and do not want to change anything in the data frame (i.e., the new column always has the same length as the DataFrame).   

```python
0   -0.335485
1   -1.166658
2   -0.385571
dtype: float64
```

I tried different versions of `join`, `append`, `merge`, but I did not get the result I wanted, only errors at most. How can I add column `e` to the above example?   

#### Answer accepted (score 947)
Use the original df1 indexes to create the series:  

```python
df1['e'] = pd.Series(np.random.randn(sLength), index=df1.index)
```

<hr>

<p><strong>Edit 2015</strong><br>
Some reported getting the `SettingWithCopyWarning` with this code.<br>
However, the code still runs perfectly with the current pandas version 0.16.1.</p>

```python
>>> sLength = len(df1['a'])
>>> df1
          a         b         c         d
6 -0.269221 -0.026476  0.997517  1.294385
8  0.917438  0.847941  0.034235 -0.448948

>>> df1['e'] = pd.Series(np.random.randn(sLength), index=df1.index)
>>> df1
          a         b         c         d         e
6 -0.269221 -0.026476  0.997517  1.294385  1.757167
8  0.917438  0.847941  0.034235 -0.448948  2.228131

>>> p.version.short_version
'0.16.1'
```

The `SettingWithCopyWarning` aims to inform of a possibly invalid assignment on a copy of the Dataframe. It doesn't necessarily say you did it wrong (it can trigger false positives) but from 0.13.0 it let you know there are more adequate methods for the same purpose. Then, if you get the warning, just follow its advise: <em>Try using .loc[row_index,col_indexer] = value instead</em>  

```python
>>> df1.loc[:,'f'] = pd.Series(np.random.randn(sLength), index=df1.index)
>>> df1
          a         b         c         d         e         f
6 -0.269221 -0.026476  0.997517  1.294385  1.757167 -0.050927
8  0.917438  0.847941  0.034235 -0.448948  2.228131  0.006109
>>> 
```

In fact, this is currently the more efficient method as <a href="http://pandas.pydata.org/pandas-docs/stable/indexing.html#indexing-view-versus-copy" rel="noreferrer">described in pandas docs</a>  

<hr>

<strong>Edit 2017</strong>  

As indicated in the comments and by @Alexander, currently the best method to add the values of a Series as a new column of a DataFrame could be using `assign`:  

```python
df1 = df1.assign(e=pd.Series(np.random.randn(sLength)).values)
```

#### Answer 2 (score 199)
This is the simple way of adding a new column: `df['e'] = e`  

#### Answer 3 (score 138)
<blockquote>
  I would like to add a new column, 'e', to the existing data frame and do not change anything in the data frame. (The series always got the same length as a dataframe.)   
</blockquote>

I assume that the index values in `e` match those in `df1`.  

The easiest way to initiate a new column named `e`, and assign it the values from your series `e`:  

```python
df['e'] = e.values
```

<strong>assign (Pandas 0.16.0+)</strong>  

As of Pandas 0.16.0, you can also use <a href="http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.assign.html" rel="noreferrer">`assign`</a>, which assigns new columns to a DataFrame and returns a new object (a copy) with all the original columns in addition to the new ones.  

```python
df1 = df1.assign(e=e.values)
```

As per <a href="https://stackoverflow.com/questions/42101382/pandas-dataframe-assign-arguments">this example</a> (which also includes the source code of the `assign` function), you can also include more than one column:  

```python
df = pd.DataFrame({'a': [1, 2], 'b': [3, 4]})
>>> df.assign(mean_a=df.a.mean(), mean_b=df.b.mean())
   a  b  mean_a  mean_b
0  1  3     1.5     3.5
1  2  4     1.5     3.5
```

In context with your example:   

```python
np.random.seed(0)
df1 = pd.DataFrame(np.random.randn(10, 4), columns=['a', 'b', 'c', 'd'])
mask = df1.applymap(lambda x: x <-0.7)
df1 = df1[-mask.any(axis=1)]
sLength = len(df1['a'])
e = pd.Series(np.random.randn(sLength))

>>> df1
          a         b         c         d
0  1.764052  0.400157  0.978738  2.240893
2 -0.103219  0.410599  0.144044  1.454274
3  0.761038  0.121675  0.443863  0.333674
7  1.532779  1.469359  0.154947  0.378163
9  1.230291  1.202380 -0.387327 -0.302303

>>> e
0   -1.048553
1   -1.420018
2   -1.706270
3    1.950775
4   -0.509652
dtype: float64

df1 = df1.assign(e=e.values)

>>> df1
          a         b         c         d         e
0  1.764052  0.400157  0.978738  2.240893 -1.048553
2 -0.103219  0.410599  0.144044  1.454274 -1.420018
3  0.761038  0.121675  0.443863  0.333674 -1.706270
7  1.532779  1.469359  0.154947  0.378163  1.950775
9  1.230291  1.202380 -0.387327 -0.302303 -0.509652
```

The description of this new feature when it was first introduced can be found <a href="http://pandas.pydata.org/pandas-docs/stable/whatsnew/v0.16.0.html#dataframe-assign" rel="noreferrer">here</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Delete a file or folder (score [1779349](https://stackoverflow.com/q/6996603) in 2018)

#### Question
How to delete a file or folder in Python?  

#### Answer accepted (score 2966)
<a href="http://docs.python.org/library/os.html#os.remove" rel="noreferrer">`os.remove()`</a> removes a file.  

<a href="http://docs.python.org/library/os.html#os.rmdir" rel="noreferrer">`os.rmdir()`</a> removes an empty directory.  

<a href="http://docs.python.org/library/shutil.html#shutil.rmtree" rel="noreferrer">`shutil.rmtree()`</a> deletes a directory and all its contents.  

<hr>

<a href="https://docs.python.org/3/library/pathlib.html#pathlib.Path" rel="noreferrer">`Path`</a> objects from the Python 3.4+ <a href="https://docs.python.org/3/library/pathlib.html" rel="noreferrer">`pathlib`</a> module also expose these instance methods:  

<ul>
<li><p><a href="https://docs.python.org/3/library/pathlib.html#pathlib.Path.unlink" rel="noreferrer">`pathlib.Path.unlink()`</a> removes a file or symbolic link.</p></li>
<li><p><a href="https://docs.python.org/3/library/pathlib.html#pathlib.Path.rmdir" rel="noreferrer">`pathlib.Path.rmdir()`</a> removes an empty directory.</p></li>
</ul>

#### Answer 2 (score 219)
<h5>Python syntax to delete a file</h2>

```python
import os
os.remove("/tmp/<file_name>.txt")
```

Or  

```python
import os
os.unlink("/tmp/<file_name>.txt")
```

<h5>Best practice</h2>

<ol>
<li>First, check whether the file or folder exists or not then only delete that file. This can be achieved in two ways :<br>
a. `os.path.isfile("/path/to/file")`<br>
b. Use `exception handling.`<br></li>
</ol>

<strong>EXAMPLE</strong> for `os.path.isfile`  

```python
#!/usr/bin/python
import os
myfile="/tmp/foo.txt"

## If file exists, delete it ##
if os.path.isfile(myfile):
    os.remove(myfile)
else:    ## Show an error ##
    print("Error: %s file not found" % myfile)
```

<h5>Exception Handling</h3>

```python
#!/usr/bin/python
import os

## Get input ##
myfile= raw_input("Enter file name to delete: ")

## Try to delete the file ##
try:
    os.remove(myfile)
except OSError as e:  ## if failed, report it back to the user ##
    print ("Error: %s - %s." % (e.filename, e.strerror))
```

<h5>RESPECTIVE OUTPUT</h3>

<pre>
Enter file name to delete : demo.txt
Error: demo.txt - No such file or directory.

Enter file name to delete : rrr.txt
Error: rrr.txt - Operation not permitted.

Enter file name to delete : foo.txt
</pre>

<h5>Python syntax to delete a folder</h3>

```python
shutil.rmtree()
```

Example for `shutil.rmtree()`  

```python
#!/usr/bin/python
import os
import sys
import shutil

# Get directory name
mydir= raw_input("Enter directory name: ")

## Try to remove tree; if failed show an error using try...except on screen
try:
    shutil.rmtree(mydir)
except OSError as e:
    print ("Error: %s - %s." % (e.filename, e.strerror))
```

#### Answer 3 (score 72)
Use   

```python
shutil.rmtree(path[, ignore_errors[, onerror]])
```

(See complete documentation on <a href="http://docs.python.org/library/shutil.html" rel="noreferrer">shutil</a>) and/or  

```python
os.remove
```

and  

```python
os.rmdir
```

(Complete documentation on <a href="http://docs.python.org/library/os.html#os.remove" rel="noreferrer">os</a>.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Does Python have a ternary conditional operator? (score [1772957](https://stackoverflow.com/q/394809) in 2019)

#### Question
If Python does not have a ternary conditional operator, is it possible to simulate one using other language constructs?  

#### Answer accepted (score 6476)
Yes, it was <a href="https://mail.python.org/pipermail/python-dev/2005-September/056846.html" rel="noreferrer" title="[Python-Dev] Conditional Expression Resolution">added</a> in version 2.5. The expression syntax is:  

```python
a if condition else b
```

First `condition` is evaluated, then exactly one of either `a` or `b` is evaluated and returned based on the <a href="https://en.wikipedia.org/wiki/Boolean_data_type" rel="noreferrer" title="Boolean data type">Boolean</a> value of `condition`. If `condition` evaluates to `True`, then `a` is evaluated and returned but `b` is ignored, or else when `b` is evaluated and returned but `a` is ignored.  

This allows short-circuiting because when `condition` is true only `a` is evaluated and `b` is not evaluated at all, but when `condition` is false only `b` is evaluated and `a` is not evaluated at all.  

For example:  

```python
>>> 'true' if True else 'false'
'true'
>>> 'true' if False else 'false'
'false'
```

Note that conditionals are an <em>expression</em>, not a <em>statement</em>. This means you can't use assignment statements or `pass` or other <strong>statements</strong> within a conditional <strong>expression</strong>:  

```python
>>> pass if False else x = 3
  File "<stdin>", line 1
    pass if False else x = 3
          ^
SyntaxError: invalid syntax
```

You can, however, use conditional expressions to assign a variable like so:  

```python
x = a if True else b
```

Think of the conditional expression as switching between two values. It is very useful when you're in a 'one value or another' situation, it but doesn't do much else.  

If you need to use statements, you have to use a normal `if` <strong>statement</strong> instead of a conditional <strong>expression</strong>.  

<hr>

Keep in mind that it's frowned upon by some Pythonistas for several reasons:  

<ul>
<li>The order of the arguments is different from those of the classic `condition ? a : b` ternary operator from many other languages (such as C, C++, Go, Perl, Ruby, Java, Javascript, etc.), which may lead to bugs when people unfamiliar with Python's "surprising" behaviour use it (they may reverse the argument order).</li>
<li>Some find it "unwieldy", since it goes contrary to the normal flow of thought (thinking of the condition first and then the effects).</li>
<li>Stylistic reasons. (Although the 'inline `if`' can be <em>really</em> useful, and make your script more concise, it really does complicate your code)</li>
</ul>

If you're having trouble remembering the order, then remember that when read aloud, you (almost) say what you mean. For example, `x = 4 if b &gt; 8 else 9` is read aloud as `x will be 4 if b is greater than 8 otherwise 9`.  

Official documentation:       

<ul>
<li><a href="https://docs.python.org/3/reference/expressions.html#conditional-expressions" rel="noreferrer" title="Conditional expressions">Conditional expressions</a></li>
<li><a href="https://docs.python.org/3.3/faq/programming.html#is-there-an-equivalent-of-c-s-ternary-operator" rel="noreferrer" title="Is there an equivalent of C’s ”?:” ternary operator?">Is there an equivalent of C’s ”?:” ternary operator?</a></li>
</ul>

#### Answer 2 (score 725)
You can index into a tuple:  

```python
(falseValue, trueValue)[test]
```

<p>`test` needs to return <em>True</em> or <em>False</em>.<br>
It might be safer to always implement it as:</p>

```python
(falseValue, trueValue)[test == True]
```

or you can use the built-in <a href="https://docs.python.org/3.3/library/functions.html#bool" rel="noreferrer" title="bool">`bool()`</a> to assure a <a href="https://en.wikipedia.org/wiki/Boolean_data_type" rel="noreferrer" title="Boolean data type">Boolean</a> value:  

```python
(falseValue, trueValue)[bool(<expression>)]
```

#### Answer 3 (score 303)
For versions prior to 2.5, there's the trick:  

```python
[expression] and [on_true] or [on_false]
```

<p>It can give wrong results when `on_true` 
 has a false boolean value.<sup>1</sup><br>
Although it does have the benefit of evaluating expressions left to right, which is clearer in my opinion.</p>

<sub>1. <a href="http://docs.python.org/3.3/faq/programming.html#is-there-an-equivalent-of-c-s-ternary-operator" rel="noreferrer">Is there an equivalent of C’s ”?:” ternary operator?</a></sub>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: How to make a flat list out of list of lists? (score [1764924](https://stackoverflow.com/q/952914) in 2019)

#### Question
I wonder whether there is a shortcut to make a simple list out of list of lists in Python.  

I can do that in a `for` loop, but maybe there is some cool "one-liner"? I tried it with `reduce()`, but I get an error.  

<strong>Code</strong>  

```python
l = [[1, 2, 3], [4, 5, 6], [7], [8, 9]]
reduce(lambda x, y: x.extend(y), l)
```

<strong>Error message</strong>  

```python
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 1, in <lambda>
AttributeError: 'NoneType' object has no attribute 'extend'
```

#### Answer accepted (score 4134)
Given a list of lists `l`,  

`flat_list = [item for sublist in l for item in sublist]`  

which means:  

```python
flat_list = []
for sublist in l:
    for item in sublist:
        flat_list.append(item)
```

is faster than the shortcuts posted so far. (`l` is the list to flatten.)  

Here is the corresponding function:  

```python
flatten = lambda l: [item for sublist in l for item in sublist]
```

As evidence, you can use the `timeit` module in the standard library:  

```python
$ python -mtimeit -s'l=[[1,2,3],[4,5,6], [7], [8,9]]*99' '[item for sublist in l for item in sublist]'
10000 loops, best of 3: 143 usec per loop
$ python -mtimeit -s'l=[[1,2,3],[4,5,6], [7], [8,9]]*99' 'sum(l, [])'
1000 loops, best of 3: 969 usec per loop
$ python -mtimeit -s'l=[[1,2,3],[4,5,6], [7], [8,9]]*99' 'reduce(lambda x,y: x+y,l)'
1000 loops, best of 3: 1.1 msec per loop
```

Explanation: the shortcuts based on `+` (including the implied use in `sum`) are, of necessity, `O(L**2)` when there are L sublists -- as the intermediate result list keeps getting longer, at each step a new intermediate result list object gets allocated, and all the items in the previous intermediate result must be copied over (as well as a few new ones added at the end). So, for simplicity and without actual loss of generality, say you have L sublists of I items each: the first I items are copied back and forth L-1 times, the second I items L-2 times, and so on; total number of copies is I times the sum of x for x from 1 to L excluded, i.e., `I * (L**2)/2`.  

The list comprehension just generates one list, once, and copies each item over (from its original place of residence to the result list) also exactly once.  

#### Answer 2 (score 1360)
You can use <a href="http://docs.python.org/2/library/itertools.html#itertools.chain" rel="noreferrer">`itertools.chain()`</a>:  

```python
>>> import itertools
>>> list2d = [[1,2,3],[4,5,6], [7], [8,9]]
>>> merged = list(itertools.chain(*list2d))
```

or, on Python >=2.6, use <a href="http://docs.python.org/2/library/itertools.html#itertools.chain.from_iterable" rel="noreferrer">`itertools.chain.from_iterable()`</a> which doesn't require unpacking the list:  

```python
>>> import itertools
>>> list2d = [[1,2,3],[4,5,6], [7], [8,9]]
>>> merged = list(itertools.chain.from_iterable(list2d))
```

This approach is arguably more readable than `[item for sublist in l for item in sublist]` and appears to be faster too:  

```python
[me@home]$ python -mtimeit -s'l=[[1,2,3],[4,5,6], [7], [8,9]]*99;import itertools' 'list(itertools.chain.from_iterable(l))'
10000 loops, best of 3: 24.2 usec per loop
[me@home]$ python -mtimeit -s'l=[[1,2,3],[4,5,6], [7], [8,9]]*99' '[item for sublist in l for item in sublist]'
10000 loops, best of 3: 45.2 usec per loop
[me@home]$ python -mtimeit -s'l=[[1,2,3],[4,5,6], [7], [8,9]]*99' 'sum(l, [])'
1000 loops, best of 3: 488 usec per loop
[me@home]$ python -mtimeit -s'l=[[1,2,3],[4,5,6], [7], [8,9]]*99' 'reduce(lambda x,y: x+y,l)'
1000 loops, best of 3: 522 usec per loop
[me@home]$ python --version
Python 2.7.3
```

#### Answer 3 (score 807)
<strong>Note from the author</strong>: This is inefficient. But fun, because <a href="https://en.wikipedia.org/wiki/Monoid#Monoids_in_computer_science" rel="noreferrer">monoids</a> are awesome. It's not appropriate for production Python code.  

```python
>>> sum(l, [])
[1, 2, 3, 4, 5, 6, 7, 8, 9]
```

This just sums the elements of iterable passed in the first argument, treating second argument as the initial value of the sum (if not given, `0` is used instead and this case will give you an error).  

Because you are summing nested lists, you actually get `[1,3]+[2,4]` as a result of `sum([[1,3],[2,4]],[])`, which is equal to `[1,3,2,4]`.  

Note that only works on lists of lists. For lists of lists of lists, you'll need another solution.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: How to print without newline or space? (score [1755449](https://stackoverflow.com/q/493386) in 2019)

#### Question
The question is in the title.  

I'd like to do it in  <a href="/questions/tagged/python" class="post-tag" title="show questions tagged &#39;python&#39;" rel="tag">python</a>. What I'd like to do in this example in <a href="/questions/tagged/c" class="post-tag" title="show questions tagged &#39;c&#39;" rel="tag">c</a>:  

In C:  

```python
#include <stdio.h>

int main() {
    int i;
    for (i=0; i<10; i++) printf(".");
    return 0;
}
```

Output:  

```python
..........
```

In Python:  

```python
>>> for i in xrange(0,10): print '.'
.
.
.
.
.
.
.
.
.
.
>>> for i in xrange(0,10): print '.',
. . . . . . . . . .
```

In Python `print` will add a `\n` or space, how can I avoid that? Now, it's just an example. Don't tell me I can first build a string then print it. I'd like to know how to "append" strings to `stdout`.  

#### Answer accepted (score 2357)
<h5>General way</h2>

```python
import sys
sys.stdout.write('.')
```

You may also need to call  

```python
sys.stdout.flush()
```

to ensure `stdout` is flushed immediately.  

<h5>Python 2.6+</h2>

From Python 2.6 you can import the `print` function from Python 3:  

```python
from __future__ import print_function
```

This allows you to use the Python 3 solution below.  

<h5>Python 3</h2>

In Python 3, the `print` statement has been changed into a function. In Python 3, you can instead do:  

```python
print('.', end='')
```

This also works in Python 2, provided that you've used `from __future__ import print_function`.  

If you are having trouble with buffering, you can flush the output by adding `flush=True` keyword argument:  

```python
print('.', end='', flush=True)
```

However, note that the `flush` keyword is not available in the version of the `print` function imported from `__future__` in Python 2; it only works in Python 3, more specifically 3.3 and later. In earlier versions you'll still need to flush manually with a call to `sys.stdout.flush()`.  

<h5>Sources</h2>

<ol>
<li><a href="https://docs.python.org/2/library/functions.html#print" rel="noreferrer">https://docs.python.org/2/library/functions.html#print</a></li>
<li><a href="https://docs.python.org/2/library/__future__.html" rel="noreferrer">https://docs.python.org/2/library/__future__.html</a></li>
<li><a href="https://docs.python.org/3/library/functions.html#print" rel="noreferrer">https://docs.python.org/3/library/functions.html#print</a></li>
</ol>

#### Answer 2 (score 293)
It should be as simple as described at this link by Guido Van Rossum:  

Re: How does one print without a c/r ?  

<a href="http://legacy.python.org/search/hypermail/python-1992/0115.html" rel="noreferrer">http://legacy.python.org/search/hypermail/python-1992/0115.html</a>  

<blockquote>
  <p>Is it possible to print something but not automatically have a
  carriage return appended to it ?</p>
</blockquote>

<p>Yes, append a comma after the last argument to print. For instance,
this loop prints the numbers 0..9 on a line separated by spaces. Note
the parameterless "print" that adds the final newline:</p>

```python
>>> for i in range(10):
...     print i,
... else:
...     print
...
0 1 2 3 4 5 6 7 8 9
>>> 
```

#### Answer 3 (score 164)
<em>Note: The title of this question used to be something like "How to printf in python?"</em>  

Since people may come here looking for it based on the title, Python also supports printf-style substitution:  

```python
>>> strings = [ "one", "two", "three" ]
>>>
>>> for i in xrange(3):
...     print "Item %d: %s" % (i, strings[i])
...
Item 0: one
Item 1: two
Item 2: three
```

And, you can handily multiply string values:  

```python
>>> print "." * 10
..........
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: Generate random integers between 0 and 9 (score [1740843](https://stackoverflow.com/q/3996904) in 2018)

#### Question
How can I generate random integers between 0 and 9 (inclusive) in Python?  

For example, `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`  

#### Answer accepted (score 1891)
Try:  

```python
from random import randrange
print(randrange(10))
```

More info: <a href="http://docs.python.org/library/random.html#random.randrange" rel="noreferrer">http://docs.python.org/library/random.html#random.randrange</a>  

#### Answer 2 (score 371)
```python
import random
print(random.randint(0,9))
```

<hr>

```python
random.randint(a, b)
```

Return a random integer N such that a &lt;= N &lt;= b.  

Docs: <a href="https://docs.python.org/3.1/library/random.html#random.randint" rel="noreferrer">https://docs.python.org/3.1/library/random.html#random.randint</a>  

#### Answer 3 (score 111)
Try this:  

```python
from random import randrange, uniform

# randrange gives you an integral value
irand = randrange(0, 10)

# uniform gives you a floating-point value
frand = uniform(0, 10)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: How do I copy a file in Python? (score [1692227](https://stackoverflow.com/q/123198) in 2018)

#### Question
How do I copy a file in Python?  

I couldn't find anything under <a href="https://docs.python.org/2/library/os.html" rel="noreferrer">`os`</a>.  

#### Answer accepted (score 2597)
<a href="http://docs.python.org/3/library/shutil.html" rel="noreferrer">`shutil`</a> has many methods you can use. One of which is:  

```python
from shutil import copyfile

copyfile(src, dst)
```

Copy the contents of the file named `src` to a file named `dst`. The destination location must be writable; otherwise, an `IOError` exception will be raised. If `dst` already exists, it will be replaced. Special files such as character or block devices and pipes cannot be copied with this function. `src` and `dst` are path names given as strings.   

#### Answer 2 (score 976)
```python
┌──────────────────┬────────┬───────────┬───────┬────────────────┐
│     Function     │ Copies │   Copies  │Can use│   Destination  │
│                  │metadata│permissions│buffer │may be directory│
├──────────────────┼────────┼───────────┼───────┼────────────────┤
│shutil.copy       │   No   │    Yes    │   No  │      Yes       │
│shutil.copyfile   │   No   │     No    │   No  │       No       │
│shutil.copy2      │  Yes   │    Yes    │   No  │      Yes       │
│shutil.copyfileobj│   No   │     No    │  Yes  │       No       │
└──────────────────┴────────┴───────────┴───────┴────────────────┘
```

#### Answer 3 (score 681)
<a href="https://docs.python.org/2/library/shutil.html#shutil.copy2" rel="noreferrer">`copy2(src,dst)`</a> is often more useful than <a href="https://docs.python.org/2/library/shutil.html#shutil.copyfile" rel="noreferrer">`copyfile(src,dst)`</a> because:  

<ul>
<li>it allows `dst` to be a <em>directory</em> (instead of the complete target filename), in which case the <a href="https://docs.python.org/2/library/os.path.html#os.path.basename" rel="noreferrer">basename</a> of `src` is used for creating the new file;</li>
<li>it preserves the original modification and access info (mtime and atime) in the file metadata (however, this comes with a slight overhead).</li>
</ul>

Here is a short example:  

```python
import shutil
shutil.copy2('/src/dir/file.ext', '/dst/dir/newname.ext') # complete target filename given
shutil.copy2('/src/file.ext', '/dst/dir') # target filename is /dst/dir/file.ext
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: How to declare an array in Python? (score [1679894](https://stackoverflow.com/q/1514553) in 2014)

#### Question
How do I declare an array in <a href="http://en.wikipedia.org/wiki/Python_%28programming_language%29" rel="noreferrer">Python</a>?  

I can't find any reference to arrays in the documentation.   

#### Answer 2 (score 332)
```python
variable = []
```

Now `variable` refers to an empty list<sup>*</sup>.  

Of course this is an assignment, not a declaration. There's no way to say in Python "this variable should never refer to anything other than a list", since Python is dynamically typed.  

<hr>

<sup>*</sup>The default built-in Python type is called a <em>list</em>, not an array. It is an ordered container of arbitrary length that can hold a heterogenous collection of objects (their types do not matter and can be freely mixed). This should not be confused with the <a href="https://docs.python.org/2/library/array.html" rel="noreferrer">`array` module</a>, which offers a type closer to the C `array` type; the contents must be homogenous (all of the same type), but the length is still dynamic.  

#### Answer 3 (score 118)
You don't actually declare things, but this is how you create an array in Python:  

```python
from array import array
intarray = array('i')
```

For more info see the array module: <a href="http://docs.python.org/library/array.html" rel="noreferrer">http://docs.python.org/library/array.html</a>  

Now possible you don't want an array, but a list, but others have answered that already. :)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: How to split a string into a list? (score [1677830](https://stackoverflow.com/q/743806) in 2019)

#### Question
I want my Python function to split a sentence (input) and store each word in a list. My current code splits the sentence, but does not store the words as a list. How do I do that?  

```python
def split_line(text):

    # split the text
    words = text.split()

    # for each word in the line:
    for word in words:

        # print the word
        print(words)
```

#### Answer accepted (score 464)
```python
text.split()
```

This should be enough to store each word in a list.  `words` is already a list of the words from the sentence, so there is no need for the loop.  

Second, it might be a typo, but you have your loop a little messed up. If you really did want to use append, it would be:  

```python
words.append(word)
```

not   

```python
word.append(words)
```

#### Answer 2 (score 429)
Splits the string in `text` on any consecutive runs of whitespace.  

```python
words = text.split()      
```

Split the string in `text` on delimiter: `","`.  

```python
words = text.split(",")   
```

The words variable will be a `list` and contain the words from `text` split on the delimiter.  

#### Answer 3 (score 84)
<a href="https://docs.python.org/2/library/stdtypes.html#str.split" rel="noreferrer">str.split()</a>  

<blockquote>
  <p>Return a <strong>list of the words</strong> in the string, using sep as the delimiter 
  ... If sep is not specified or is None, a different splitting algorithm is applied: runs of consecutive whitespace are regarded as a single separator, and the result will contain no empty strings at the start or end if the string has leading or trailing whitespace. </p>
</blockquote>

```python
>>> line="a sentence with a few words"
>>> line.split()
['a', 'sentence', 'with', 'a', 'few', 'words']
>>> 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: Fastest way to check if a value exists in a list (score [1650273](https://stackoverflow.com/q/7571635) in 2019)

#### Question
What is the fastest way to know if a value exists in a list (a list with millions of values in it) and what its index is?  

I know that all values in the list are unique as in this example.  

<strong>The first method I try is (3.8 sec in my real code):</strong>  

```python
a = [4,2,3,1,5,6]

if a.count(7) == 1:
    b=a.index(7)
    "Do something with variable b"
```

<strong>The second method I try is (2x faster: 1.9 sec for my real code):</strong>  

```python
a = [4,2,3,1,5,6]

try:
    b=a.index(7)
except ValueError:
    "Do nothing"
else:
    "Do something with variable b"
```

<strong>Proposed methods from Stack Overflow user (2.74 sec for my real code):</strong>  

```python
a = [4,2,3,1,5,6]
if 7 in a:
    a.index(7)
```

<p>In my real code, the first method takes 3.81 sec and the second method takes 1.88 sec.
It's a good improvement, but:</p>

I'm a beginner with Python/scripting, and is there a faster way to do the same things and save more processing time?  

<strong>More specific explication for my application:</strong>  

In the Blender API I can access a list of particles:  

```python
particles = [1, 2, 3, 4, etc.]
```

From there, I can access a particle's location:  

```python
particles[x].location = [x,y,z]
```

And for each particle I test if a neighbour exists by searching each particle location like so:  

```python
if [x+1,y,z] in particles.location
    "Find the identity of this neighbour particle in x:the particle's index
    in the array"
    particles.index([x+1,y,z])
```

#### Answer accepted (score 1391)
```python
7 in a
```

Clearest and fastest way to do it.  

You can also consider using a `set`, but constructing that set from your list may take more time than faster membership testing will save. The only way to be certain is to benchmark well. (this also depends on what operations you require)  

#### Answer 2 (score 178)
As stated by others, `in` can be very slow for large lists. Here are some comparisons of the performances for `in`, `set` and `bisect`. Note the time (in second) is in log scale.  

<a href="https://i.stack.imgur.com/HSRgg.png" rel="noreferrer"><img src="https://i.stack.imgur.com/HSRgg.png" alt="enter image description here"></a>  

Code for testing:  

```python
import random
import bisect
import matplotlib.pyplot as plt
import math
import time

def method_in(a,b,c):
    start_time = time.time()
    for i,x in enumerate(a):
        if x in b:
            c[i] = 1
    return(time.time()-start_time)   

def method_set_in(a,b,c):
    start_time = time.time()
    s = set(b)
    for i,x in enumerate(a):
        if x in s:
            c[i] = 1
    return(time.time()-start_time)

def method_bisect(a,b,c):
    start_time = time.time()
    b.sort()
    for i,x in enumerate(a):
        index = bisect.bisect_left(b,x)
        if index < len(a):
            if x == b[index]:
                c[i] = 1
    return(time.time()-start_time)

def profile():
    time_method_in = []
    time_method_set_in = []
    time_method_bisect = []

    Nls = [x for x in range(1000,20000,1000)]
    for N in Nls:
        a = [x for x in range(0,N)]
        random.shuffle(a)
        b = [x for x in range(0,N)]
        random.shuffle(b)
        c = [0 for x in range(0,N)]

        time_method_in.append(math.log(method_in(a,b,c)))
        time_method_set_in.append(math.log(method_set_in(a,b,c)))
        time_method_bisect.append(math.log(method_bisect(a,b,c)))

    plt.plot(Nls,time_method_in,marker='o',color='r',linestyle='-',label='in')
    plt.plot(Nls,time_method_set_in,marker='o',color='b',linestyle='-',label='set')
    plt.plot(Nls,time_method_bisect,marker='o',color='g',linestyle='-',label='bisect')
    plt.xlabel('list size', fontsize=18)
    plt.ylabel('log(time)', fontsize=18)
    plt.legend(loc = 'upper left')
    plt.show()
```

#### Answer 3 (score 32)
You could put your items into a <a href="http://docs.python.org/library/stdtypes.html#set-types-set-frozenset" rel="noreferrer">`set`</a>. Set lookups are very efficient.  

Try:  

```python
s = set(a)
if 7 in s:
  # do stuff
```

<strong>edit</strong> In a comment you say that you'd like to get the index of the element. Unfortunately, sets have no notion of element position. An alternative is to pre-sort your list and then use <a href="https://stackoverflow.com/questions/212358/binary-search-in-python">binary search</a> every time you need to find an element.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: How do I merge two dictionaries in a single expression? (score [1648573](https://stackoverflow.com/q/38987) in 2019)

#### Question
I have two Python dictionaries, and I want to write a single expression that returns these two dictionaries, merged.  The `update()` method would be what I need, if it returned its result instead of modifying a dict in-place.  

```python
>>> x = {'a': 1, 'b': 2}
>>> y = {'b': 10, 'c': 11}
>>> z = x.update(y)
>>> print(z)
None
>>> x
{'a': 1, 'b': 10, 'c': 11}
```

How can I get that final merged dict in `z`, not `x`?  

(To be extra-clear, the last-one-wins conflict-handling of `dict.update()` is what I'm looking for as well.)  

#### Answer accepted (score 4917)
<blockquote>
  <h5>How can I merge two Python dictionaries in a single expression?</h2>
</blockquote>

For dictionaries `x` and `y`, `z` becomes a shallowly merged dictionary with values from `y` replacing those from `x`.  

<ul>
<li><p>In Python 3.5 or greater:</p>

```python
z = {**x, **y}
```</li>
<li><p>In Python 2, (or 3.4 or lower) write a function:</p>

```python
def merge_two_dicts(x, y):
    z = x.copy()   # start with x's keys and values
    z.update(y)    # modifies z with y's keys and values & returns None
    return z
```

and now:  

```python
z = merge_two_dicts(x, y)
```</li>
</ul>

<h5>Explanation</h3>

Say you have two dicts and you want to merge them into a new dict without altering the original dicts:  

```python
x = {'a': 1, 'b': 2}
y = {'b': 3, 'c': 4}
```

The desired result is to get a new dictionary (`z`) with the values merged, and the second dict's values overwriting those from the first.  

```python
>>> z
{'a': 1, 'b': 3, 'c': 4}
```

A new syntax for this, proposed in <a href="https://www.python.org/dev/peps/pep-0448" rel="noreferrer">PEP 448</a> and <a href="https://mail.python.org/pipermail/python-dev/2015-February/138564.html" rel="noreferrer">available as of Python 3.5</a>, is   

```python
z = {**x, **y}
```

And it is indeed a single expression.   

Note that we can merge in with literal notation as well:  

```python
z = {**x, 'foo': 1, 'bar': 2, **y}
```

and now:   

```python
>>> z
{'a': 1, 'b': 3, 'foo': 1, 'bar': 2, 'c': 4}
```

It is now showing as implemented in the <a href="https://www.python.org/dev/peps/pep-0478/#features-for-3-5" rel="noreferrer">release schedule for 3.5, PEP 478</a>, and it has now made its way into <a href="https://docs.python.org/dev/whatsnew/3.5.html#pep-448-additional-unpacking-generalizations" rel="noreferrer">What's New in Python 3.5</a> document.  

However, since many organizations are still on Python 2, you may wish to do this in a backwards compatible way. The classically Pythonic way, available in Python 2 and Python 3.0-3.4, is to do this as a two-step process:  

```python
z = x.copy()
z.update(y) # which returns None since it mutates z
```

In both approaches, `y` will come second and its values will replace `x`'s values, thus `'b'` will point to `3` in our final result.  

<h5>Not yet on Python 3.5, but want a <em>single expression</em></h2>

If you are not yet on Python 3.5, or need to write backward-compatible code, and you want this in a <em>single expression</em>, the most performant while correct approach is to put it in a function:  

```python
def merge_two_dicts(x, y):
    """Given two dicts, merge them into a new dict as a shallow copy."""
    z = x.copy()
    z.update(y)
    return z
```

and then you have a single expression:  

```python
z = merge_two_dicts(x, y)
```

You can also make a function to merge an undefined number of dicts, from zero to a very large number:  

```python
def merge_dicts(*dict_args):
    """
    Given any number of dicts, shallow copy and merge into a new dict,
    precedence goes to key value pairs in latter dicts.
    """
    result = {}
    for dictionary in dict_args:
        result.update(dictionary)
    return result
```

This function will work in Python 2 and 3 for all dicts. e.g. given dicts `a` to `g`:  

```python
z = merge_dicts(a, b, c, d, e, f, g) 
```

and key value pairs in `g` will take precedence over dicts `a` to `f`, and so on.  

<h5>Critiques of Other Answers</h2>

Don't use what you see in the formerly accepted answer:  

```python
z = dict(x.items() + y.items())
```

In Python 2, you create two lists in memory for each dict, create a third list in memory with length equal to the length of the first two put together, and then discard all three lists to create the dict. <strong>In Python 3, this will fail</strong> because you're adding two `dict_items` objects together, not two lists -   

```python
>>> c = dict(a.items() + b.items())
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unsupported operand type(s) for +: 'dict_items' and 'dict_items'
```

and you would have to explicitly create them as lists, e.g. `z = dict(list(x.items()) + list(y.items()))`. This is a waste of resources and computation power.   

Similarly, taking the union of `items()` in Python 3 (`viewitems()` in Python 2.7) will also fail when values are unhashable objects (like lists, for example). Even if your values are hashable, <strong>since sets are semantically unordered, the behavior is undefined in regards to precedence. So don't do this:</strong>  

```python
>>> c = dict(a.items() | b.items())
```

This example demonstrates what happens when values are unhashable:  

```python
>>> x = {'a': []}
>>> y = {'b': []}
>>> dict(x.items() | y.items())
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unhashable type: 'list'
```

Here's an example where y should have precedence, but instead the value from x is retained due to the arbitrary order of sets:  

```python
>>> x = {'a': 2}
>>> y = {'a': 1}
>>> dict(x.items() | y.items())
{'a': 2}
```

Another hack you should not use:  

```python
z = dict(x, **y)
```

This uses the `dict` constructor, and is very fast and memory efficient (even slightly more-so than our two-step process) but unless you know precisely what is happening here (that is, the second dict is being passed as keyword arguments to the dict constructor), it's difficult to read, it's not the intended usage, and so it is not Pythonic.   

Here's an example of the usage being <a href="https://code.djangoproject.com/attachment/ticket/13357/django-pypy.2.diff" rel="noreferrer">remediated in django</a>.  

Dicts are intended to take hashable keys (e.g. frozensets or tuples), but <strong>this method fails in Python 3 when keys are not strings.</strong>  

```python
>>> c = dict(a, **b)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: keyword arguments must be strings
```

From the <a href="https://mail.python.org/pipermail/python-dev/2010-April/099459.html" rel="noreferrer">mailing list</a>, Guido van Rossum, the creator of the language, wrote:  

<blockquote>
  <p>I am fine with
  declaring dict({}, **{1:3}) illegal, since after all it is abuse of
  the ** mechanism.</p>
</blockquote>

and   

<blockquote>
  <p>Apparently dict(x, **y) is going around as "cool hack" for "call
  x.update(y) and return x". Personally I find it more despicable than
  cool.</p>
</blockquote>

It is my understanding (as well as the understanding of the <a href="https://mail.python.org/pipermail/python-dev/2010-April/099485.html" rel="noreferrer">creator of the language</a>) that the intended usage for `dict(**y)` is for creating dicts for readability purposes, e.g.:  

```python
dict(a=1, b=10, c=11)
```

instead of   

```python
{'a': 1, 'b': 10, 'c': 11}
```

<h5>Response to comments</h2>

<blockquote>
  Despite what Guido says, `dict(x, **y)` is in line with the dict specification, which btw. works for both Python 2 and 3. The fact that this only works for string keys is a direct consequence of how keyword parameters work and not a short-comming of dict. Nor is using the ** operator in this place an abuse of the mechanism, in fact ** was designed precisely to pass dicts as keywords.   
</blockquote>

Again, it doesn't work for 3 when keys are non-strings. The implicit calling contract is that namespaces take ordinary dicts, while users must only pass keyword arguments that are strings. All other callables enforced it. `dict` broke this consistency in Python 2:  

```python
>>> foo(**{('a', 'b'): None})
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: foo() keywords must be strings
>>> dict(**{('a', 'b'): None})
{('a', 'b'): None}
```

This inconsistency was bad given other implementations of Python (Pypy, Jython, IronPython). Thus it was fixed in Python 3, as this usage could be a breaking change.  

I submit to you that it is malicious incompetence to intentionally write code that only works in one version of a language or that only works given certain arbitrary constraints.  

More comments:  

<blockquote>
  `dict(x.items() + y.items())` is still the most readable solution for Python 2. Readability counts.   
</blockquote>

My response: `merge_two_dicts(x, y)` actually seems much clearer to me, if we're actually concerned about readability. And it is not forward compatible, as Python 2 is increasingly deprecated.  

<blockquote>
  `{**x, **y}` does not seem to handle nested dictionaries. the contents of nested keys are simply overwritten, not merged [...] I ended up being burnt by these answers that do not merge recursively and I was surprised no one mentioned it. In my interpretation of the word "merging" these answers describe "updating one dict with another", and not merging.  
</blockquote>

Yes. I must refer you back to the question, which is asking for a <em>shallow</em> merge of <strong><em>two</em></strong> dictionaries, with the first's values being overwritten by the second's - in a single expression.  

Assuming two dictionary of dictionaries, one might recursively merge them in a single function, but you should be careful not to modify the dicts from either source, and the surest way to avoid that is to make a copy when assigning values. As keys must be hashable and are usually therefore immutable, it is pointless to copy them:  

```python
from copy import deepcopy

def dict_of_dicts_merge(x, y):
    z = {}
    overlapping_keys = x.keys() & y.keys()
    for key in overlapping_keys:
        z[key] = dict_of_dicts_merge(x[key], y[key])
    for key in x.keys() - overlapping_keys:
        z[key] = deepcopy(x[key])
    for key in y.keys() - overlapping_keys:
        z[key] = deepcopy(y[key])
    return z
```

Usage:  

```python
>>> x = {'a':{1:{}}, 'b': {2:{}}}
>>> y = {'b':{10:{}}, 'c': {11:{}}}
>>> dict_of_dicts_merge(x, y)
{'b': {2: {}, 10: {}}, 'a': {1: {}}, 'c': {11: {}}}
```

Coming up with contingencies for other value types is far beyond the scope of this question, so I will point you at <a href="https://stackoverflow.com/a/24088493/541136">my answer to the canonical question on a "Dictionaries of dictionaries merge"</a>.  

<h5>Less Performant But Correct Ad-hocs</h2>

<p>These approaches are less performant, but they will provide correct behavior.
They will be <em>much less</em> performant than `copy` and `update` or the new unpacking because they iterate through each key-value pair at a higher level of abstraction, but they <em>do</em> respect the order of precedence (latter dicts have precedence)</p>

You can also chain the dicts manually inside a dict comprehension:  

```python
{k: v for d in dicts for k, v in d.items()} # iteritems in Python 2.7
```

or in python 2.6 (and perhaps as early as 2.4 when generator expressions were introduced):  

```python
dict((k, v) for d in dicts for k, v in d.items())
```

`itertools.chain` will chain the iterators over the key-value pairs in the correct order:  

```python
import itertools
z = dict(itertools.chain(x.iteritems(), y.iteritems()))
```

<h5>Performance Analysis</h2>

I'm only going to do the performance analysis of the usages known to behave correctly.   

```python
import timeit
```

The following is done on Ubuntu 14.04  

In Python 2.7 (system Python):  

```python
>>> min(timeit.repeat(lambda: merge_two_dicts(x, y)))
0.5726828575134277
>>> min(timeit.repeat(lambda: {k: v for d in (x, y) for k, v in d.items()} ))
1.163769006729126
>>> min(timeit.repeat(lambda: dict(itertools.chain(x.iteritems(), y.iteritems()))))
1.1614501476287842
>>> min(timeit.repeat(lambda: dict((k, v) for d in (x, y) for k, v in d.items())))
2.2345519065856934
```

In Python 3.5 (deadsnakes PPA):  

```python
>>> min(timeit.repeat(lambda: {**x, **y}))
0.4094954460160807
>>> min(timeit.repeat(lambda: merge_two_dicts(x, y)))
0.7881555100320838
>>> min(timeit.repeat(lambda: {k: v for d in (x, y) for k, v in d.items()} ))
1.4525277839857154
>>> min(timeit.repeat(lambda: dict(itertools.chain(x.items(), y.items()))))
2.3143140770262107
>>> min(timeit.repeat(lambda: dict((k, v) for d in (x, y) for k, v in d.items())))
3.2069112799945287
```

<h5>Resources on Dictionaries</h2>

<ul>
<li><a href="https://stackoverflow.com/questions/327311/how-are-pythons-built-in-dictionaries-implemented/44509302#44509302">My explanation of Python's <strong>dictionary implementation</strong>, updated for 3.6.</a></li>
<li><a href="https://stackoverflow.com/questions/1024847/add-new-keys-to-a-dictionary/27208535#27208535">Answer on how to add new keys to a dictionary</a></li>
<li><a href="https://stackoverflow.com/questions/209840/map-two-lists-into-a-dictionary-in-python/33737067#33737067">Mapping two lists into a dictionary</a></li>
<li>The official Python <a href="https://docs.python.org/3/tutorial/datastructures.html#dictionaries" rel="noreferrer">docs on dictionaries</a> </li>
<li><a href="https://www.youtube.com/watch?v=66P5FMkWoVU" rel="noreferrer">The Dictionary Even Mightier</a> - talk by Brandon Rhodes at Pycon 2017</li>
<li><a href="https://www.youtube.com/watch?v=npw4s1QTmPg" rel="noreferrer">Modern Python Dictionaries, A Confluence of Great Ideas</a> - talk by Raymond Hettinger at Pycon 2017</li>
</ul>

#### Answer 2 (score 1554)
In your case, what you can do is:  

```python
z = dict(x.items() + y.items())
```

This will, as you want it, put the final dict in `z`, and make the value for key `b` be properly overridden by the second (`y`) dict's value:  

```python
>>> x = {'a':1, 'b': 2}
>>> y = {'b':10, 'c': 11}
>>> z = dict(x.items() + y.items())
>>> z
{'a': 1, 'c': 11, 'b': 10}
```

If you use Python 3, it is only a little more complicated.  To create `z`:  

```python
>>> z = dict(list(x.items()) + list(y.items()))
>>> z
{'a': 1, 'c': 11, 'b': 10}
```

#### Answer 3 (score 605)
An alternative:  

```python
z = x.copy()
z.update(y)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: Determine the type of an object? (score [1647494](https://stackoverflow.com/q/2225038) in 2017)

#### Question
Is there a simple way to determine if a variable is a list, dictionary, or something else? I am getting an object back that may be either type and I need to be able to tell the difference.  

#### Answer accepted (score 1876)
To get the type of an object, you can use the built-in <a href="http://docs.python.org/3/library/functions.html#type" rel="noreferrer">`type()`</a> function. Passing an object as the only parameter will return the type object of that object:  

```python
>>> type([]) is list
True
>>> type({}) is dict
True
>>> type('') is str
True
>>> type(0) is int
True
>>> type({})
<type 'dict'>
>>> type([])
<type 'list'>
```

This of course also works for custom types:  

```python
>>> class Test1 (object):
        pass
>>> class Test2 (Test1):
        pass
>>> a = Test1()
>>> b = Test2()
>>> type(a) is Test1
True
>>> type(b) is Test2
True
```

Note that `type()` will only return the immediate type of the object, but won’t be able to tell you about type inheritance.  

```python
>>> type(b) is Test1
False
```

To cover that, you should use the <a href="http://docs.python.org/3/library/functions.html#isinstance" rel="noreferrer">`isinstance`</a> function. This of course also works for built-in types:  

```python
>>> isinstance(b, Test1)
True
>>> isinstance(b, Test2)
True
>>> isinstance(a, Test1)
True
>>> isinstance(a, Test2)
False
>>> isinstance([], list)
True
>>> isinstance({}, dict)
True
```

`isinstance()` is usually the preferred way to ensure the type of an object because it will also accept derived types. So unless you actually need the type object (for whatever reason), using `isinstance()` is preferred over `type()`.  

The second parameter of `isinstance()` also accepts a tuple of types, so it’s possible to check for multiple types at once. `isinstance` will then return true, if the object is of any of those types:  

```python
>>> isinstance([], (tuple, list, set))
True
```

#### Answer 2 (score 157)
You can do that using `type()`:  

```python
>>> a = []
>>> type(a)
<type 'list'>
>>> f = ()
>>> type(f)
<type 'tuple'>
```

#### Answer 3 (score 40)
It might be more Pythonic to use a `try`...`except` block. That way, if you have a class which quacks like a list, or quacks like a dict, it will behave properly regardless of what its type <em>really</em> is.  

To clarify, the preferred method of "telling the difference" between variable types is with something called <a href="http://en.wikipedia.org/wiki/Duck_typing" rel="noreferrer">duck typing</a>: as long as the methods (and return types) that a variable responds to are what your subroutine expects, treat it like what you expect it to be. For example, if you have a class that overloads the bracket operators with `getattr` and `setattr`, but uses some funny internal scheme, it would be appropriate for it to behave as a dictionary if that's what it's trying to emulate.  

The other problem with the `type(A) is type(B)` checking is that if `A` is a subclass of `B`, it evaluates to `false` when, programmatically, you would hope it would be `true`. If an object is a subclass of a list, it should work like a list: checking the type as presented in the other answer will prevent this. (`isinstance` will work, however).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Is arr.__len__() the preferred way to get the length of an array in Python? (score [1645889](https://stackoverflow.com/q/518021) in 2018)

#### Question
In <a href="http://en.wikipedia.org/wiki/Python_%28programming_language%29" rel="noreferrer">Python</a>, is the following the only way to get the number of elements?  

```python
arr.__len__()
```

If so, why the strange syntax?  

#### Answer accepted (score 1204)
```python
my_list = [1,2,3,4,5]
len(my_list)
# 5
```

The same works for tuples:  

```python
my_tuple = (1,2,3,4,5)
len(my_tuple)
# 5
```

And strings, which are really just arrays of characters:  

```python
my_string = 'hello world'
len(my_string)
# 11
```

It was <a href="http://effbot.org/pyfaq/why-does-python-use-methods-for-some-functionality-e-g-list-index-but-functions-for-other-e-g-len-list.htm" rel="noreferrer">intentionally done this way</a> so that lists, tuples and other container types didn't all need to explicitly implement a public `.length()` method, instead you can just check the `len()` of anything that implements the 'magic' `__len__()` method.  

Sure, this may seem redundant, but length checking implementations can vary considerably, even within the same language. It's not uncommon to see one collection type use a `.length()` method while another type uses a `.length` property, while yet another uses `.count()`. Having a language-level keyword unifies the entry point for all these types. So even objects you may not consider to be lists of elements could still be length-checked.  This includes strings, queues, trees, etc.  

The functional nature of `len()` also lends itself well to functional styles of programming.  

```python
lengths = map(len, list_of_containers)
```

#### Answer 2 (score 51)
The way you take a length of anything for which that makes sense (a list, dictionary, tuple, string, ...) is to call `len` on it.  

```python
l = [1,2,3,4]
s = 'abcde'
len(l) #returns 4
len(s) #returns 5
```

The reason for the "strange" syntax is that internally python translates `len(object)` into `object.__len__()`. This applies to any object. So, if you are defining some class and it makes sense for it to have a length, just define a `__len__()` method on it and then one can call `len` on those instances.  

#### Answer 3 (score 23)
Python uses <a href="http://en.wikipedia.org/wiki/Duck_typing" rel="noreferrer">duck typing</a>: it doesn't care about what an object <em>is</em>, as long as it has the appropriate interface for the situation at hand. When you call the built-in function len() on an object, you are actually calling its internal __len__ method. A custom object can implement this interface and len() will return the answer, even if the object is not conceptually a sequence.  

For a complete list of interfaces, have a look here: <a href="http://docs.python.org/reference/datamodel.html#basic-customization" rel="noreferrer">http://docs.python.org/reference/datamodel.html#basic-customization</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: What IDE to use for Python? (score [1633282](https://stackoverflow.com/q/81584) in 2014)

#### Question
What IDEs ("GUIs/editors") do others use for Python coding?  

#### Answer 2 (score 1273)


<h5>Results</h2>

<a href="https://docs.google.com/spreadsheets/d/1l3x94P55qoxqYbq5GosWQ7IonZ4vR-4ZyCaImiVmCSk/pubhtml" rel="noreferrer">Spreadsheet version</a>  

<a href="https://docs.google.com/spreadsheets/d/1l3x94P55qoxqYbq5GosWQ7IonZ4vR-4ZyCaImiVmCSk/pubhtml" rel="noreferrer"><img src="https://i.stack.imgur.com/Jrc6C.png" alt="spreadsheet screenshot"></a>  

Alternatively, in plain text: (also available as a a <a href="https://i.stack.imgur.com/ItVKB.png" rel="noreferrer">screenshot</a>)  

```python
                         Bracket Matching -.  .- Line Numbering
                          Smart Indent -.  |  |  .- UML Editing / Viewing
         Source Control Integration -.  |  |  |  |  .- Code Folding
                    Error Markup -.  |  |  |  |  |  |  .- Code Templates
  Integrated Python Debugging -.  |  |  |  |  |  |  |  |  .- Unit Testing
    Multi-Language Support -.  |  |  |  |  |  |  |  |  |  |  .- GUI Designer (Qt, Eric, etc)
   Auto Code Completion -.  |  |  |  |  |  |  |  |  |  |  |  |  .- Integrated DB Support
     Commercial/Free -.  |  |  |  |  |  |  |  |  |  |  |  |  |  |  .- Refactoring
   Cross Platform -.  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |     
                  +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
Atom              |Y |F |Y |Y*|Y |Y |Y |Y |Y |Y |  |Y |Y |  |  |  |  |*many plugins
Editra            |Y |F |Y |Y |  |  |Y |Y |Y |Y |  |Y |  |  |  |  |  |
Emacs             |Y |F |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |  |  |  |
Eric Ide          |Y |F |Y |  |Y |Y |  |Y |  |Y |  |Y |  |Y |  |  |  |
Geany             |Y |F |Y*|Y |  |  |  |Y |Y |Y |  |Y |  |  |  |  |  |*very limited
Gedit             |Y |F |Y¹|Y |  |  |  |Y |Y |Y |  |  |Y²|  |  |  |  |¹with plugin; ²sort of
Idle              |Y |F |Y |  |Y |  |  |Y |Y |  |  |  |  |  |  |  |  |
IntelliJ          |Y |CF|Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |
JEdit             |Y |F |  |Y |  |  |  |  |Y |Y |  |Y |  |  |  |  |  |
KDevelop          |Y |F |Y*|Y |  |  |Y |Y |Y |Y |  |Y |  |  |  |  |  |*no type inference
Komodo            |Y |CF|Y |Y |Y |Y |Y |Y |Y |Y |  |Y |Y |Y |  |Y |  |
NetBeans*         |Y |F |Y |Y |Y |  |Y |Y |Y |Y |Y |Y |Y |Y |  |  |Y |*pre-v7.0
Notepad++         |W |F |Y |Y |  |Y*|Y*|Y*|Y |Y |  |Y |Y*|  |  |  |  |*with plugin
Pfaide            |W |C |Y |Y |  |  |  |Y |Y |Y |  |Y |Y |  |  |  |  |
PIDA              |LW|F |Y |Y |  |  |  |Y |Y |Y |  |Y |  |  |  |  |  |VIM based
PTVS              |W |F |Y |Y |Y |Y |Y |Y |Y |Y |  |Y |  |  |Y*|  |Y |*WPF bsed
PyCharm           |Y |CF|Y |Y*|Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |*JavaScript
PyDev (Eclipse)   |Y |F |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |Y |  |  |  |
PyScripter        |W |F |Y |  |Y |Y |  |Y |Y |Y |  |Y |Y |Y |  |  |  |
PythonWin         |W |F |Y |  |Y |  |  |Y |Y |  |  |Y |  |  |  |  |  |
SciTE             |Y |F¹|  |Y |  |Y |  |Y |Y |Y |  |Y |Y |  |  |  |  |¹Mac version is
ScriptDev         |W |C |Y |Y |Y |Y |  |Y |Y |Y |  |Y |Y |  |  |  |  |    commercial
Spyder            |Y |F |Y |  |Y |Y |  |Y |Y |Y |  |  |  |  |  |  |  |
Sublime Text      |Y |CF|Y |Y |  |Y |Y |Y |Y |Y |  |Y |Y |Y*|  |  |  |extensible w/Python,
TextMate          |M |F |  |Y |  |  |Y |Y |Y |Y |  |Y |Y |  |  |  |  |    *PythonTestRunner
UliPad            |Y |F |Y |Y |Y |  |  |Y |Y |  |  |  |Y |Y |  |  |  |
Vim               |Y |F |Y |Y |Y |Y |Y |Y |Y |Y |  |Y |Y |Y |  |  |  |
Visual Studio     |W |CF|Y |Y |Y |Y |Y |Y |Y |Y |? |Y |? |? |Y |? |Y |
Visual Studio Code|Y |F |Y |Y |Y |Y |Y |Y |Y |Y |? |Y |? |? |? |? |Y |uses plugins
WingIde           |Y |C |Y |Y*|Y |Y |Y |Y |Y |Y |  |Y |Y |Y |  |  |  |*support for C
Zeus              |W |C |  |  |  |  |Y |Y |Y |Y |  |Y |Y |  |  |  |  |
                  +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
   Cross Platform -'  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |     
     Commercial/Free -'  |  |  |  |  |  |  |  |  |  |  |  |  |  |  '- Refactoring
   Auto Code Completion -'  |  |  |  |  |  |  |  |  |  |  |  |  '- Integrated DB Support
    Multi-Language Support -'  |  |  |  |  |  |  |  |  |  |  '- GUI Designer (Qt, Eric, etc)
  Integrated Python Debugging -'  |  |  |  |  |  |  |  |  '- Unit Testing
                    Error Markup -'  |  |  |  |  |  |  '- Code Templates
         Source Control Integration -'  |  |  |  |  '- Code Folding
                          Smart Indent -'  |  |  '- UML Editing / Viewing
                         Bracket Matching -'  '- Line Numbering
```

<hr>

Acronyms used:  

```python
 L  - Linux
 W  - Windows
 M  - Mac
 C  - Commercial
 F  - Free
 CF - Commercial with Free limited edition
 ?  - To be confirmed
```

I don't mention basics like syntax highlighting as I expect these by default.  

<hr>

This is a just dry list reflecting your feedback and comments, I am not advocating any of these tools. I will keep updating this list as you keep posting your answers.  

<strong><em>PS. Can you help me to add features of the above editors to the list (like auto-complete, debugging, etc.)?</em></strong>  

We have a comprehensive wiki page for this question <a href="https://wiki.python.org/moin/IntegratedDevelopmentEnvironments" rel="noreferrer">https://wiki.python.org/moin/IntegratedDevelopmentEnvironments</a>  

<a href="https://docs.google.com/spreadsheets/d/1l3x94P55qoxqYbq5GosWQ7IonZ4vR-4ZyCaImiVmCSk/edit#gid=0&amp;fvid=1960281650" rel="noreferrer" title="Submit edits to the spreadsheet">Submit edits to the spreadsheet</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: How can I remove a trailing newline? (score [1623884](https://stackoverflow.com/q/275018) in 2019)

#### Question
What is the Python equivalent of Perl's `chomp` function, which removes the last character of a string if it is a newline?  

#### Answer 2 (score 1715)
Try the method `rstrip()` (see doc <a href="http://docs.python.org/2/library/stdtypes.html#str.rstrip" rel="noreferrer">Python 2</a> and <a href="https://docs.python.org/3/library/stdtypes.html#str.rstrip" rel="noreferrer">Python 3</a>)  

```python
>>> 'test string\n'.rstrip()
'test string'
```

Python's `rstrip()` method strips <em>all</em> kinds of trailing whitespace by default, not just one newline as Perl does with <a href="http://perldoc.perl.org/functions/chomp.html" rel="noreferrer">`chomp`</a>.  

```python
>>> 'test string \n \r\n\n\r \n\n'.rstrip()
'test string'
```

To strip only newlines:  

```python
>>> 'test string \n \r\n\n\r \n\n'.rstrip('\n')
'test string \n \r\n\n\r '
```

There are also the methods `lstrip()` and `strip()`:  

```python
>>> s = "   \n\r\n  \n  abc   def \n\r\n  \n  "
>>> s.strip()
'abc   def'
>>> s.lstrip()
'abc   def \n\r\n  \n  '
>>> s.rstrip()
'   \n\r\n  \n  abc   def'
```

#### Answer 3 (score 153)
And I would say the "pythonic" way to get lines without trailing newline characters is splitlines().  

```python
>>> text = "line 1\nline 2\r\nline 3\nline 4"
>>> text.splitlines()
['line 1', 'line 2', 'line 3', 'line 4']
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: How to convert strings into integers in Python? (score [1618410](https://stackoverflow.com/q/642154) in 2017)

#### Question
I have a tuple of tuples from a MySQL query like this:  

```python
T1 = (('13', '17', '18', '21', '32'),
      ('07', '11', '13', '14', '28'),
      ('01', '05', '06', '08', '15', '16'))
```

I'd like to convert all the string elements into integers and put them back into a list of lists:  

```python
T2 = [[13, 17, 18, 21, 32], [7, 11, 13, 14, 28], [1, 5, 6, 8, 15, 16]]
```

I tried to achieve it with `eval` but didn't get any decent result yet.  

#### Answer accepted (score 606)
<a href="https://docs.python.org/3/library/functions.html#int" rel="noreferrer">`int()`</a> is the Python standard built-in function to convert a string into an integer value. You call it with a string containing a number as the argument, and it returns the number converted to an integer:  

```python
print (int("1") + 1)
```

The above prints `2`.  

If you know the structure of your list, T1 (that it simply contains lists, only one level), you could do this in Python 2:  

```python
T2 = [map(int, x) for x in T1]
```

In Python 3:  

```python
T2 = [list(map(int, x)) for x in T1]
```

#### Answer 2 (score 28)
You can do this with a list comprehension:  

```python
T2 = [[int(column) for column in row] for row in T1]
```

The inner list comprehension (`[int(column) for column in row]`) builds a `list` of `int`s from a sequence of `int`-able objects, like decimal strings, in `row`. The outer list comprehension (`[... for row in T1])`) builds a list of the results of the inner list comprehension applied to each item in `T1`.  

The code snippet will fail if any of the rows contain objects that can't be converted by `int`. You'll need a smarter function if you want to process rows containing non-decimal strings.  

If you know the structure of the rows, you can replace the inner list comprehension with a call to a function of the row. Eg.  

```python
T2 = [parse_a_row_of_T1(row) for row in T1]
```

#### Answer 3 (score 16)
I would rather prefer using only comprehension lists:  

```python
[[int(y) for y in x] for x in T1]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Is there a simple way to delete a list element by value? (score [1596938](https://stackoverflow.com/q/2793324) in 2019)

#### Question
```python
a = [1, 2, 3, 4]
b = a.index(6)

del a[b]
print a
```

The above shows the following error:  

```python
Traceback (most recent call last):
  File "D:\zjm_code\a.py", line 6, in <module>
    b = a.index(6)
ValueError: list.index(x): x not in list
```

So I have to do this:  

```python
a = [1, 2, 3, 4]

try:
    b = a.index(6)
    del a[b]
except:
    pass

print a
```

But is there not a simpler way to do this?  

#### Answer accepted (score 1455)
To remove an element's first occurrence in a list, simply use `list.remove`:  

```python
>>> a = ['a', 'b', 'c', 'd']
>>> a.remove('b')
>>> print a
['a', 'c', 'd']
```

Mind that it does not remove all occurrences of your element. Use a list comprehension for that.  

```python
>>> a = [10, 20, 30, 40, 20, 30, 40, 20, 70, 20]
>>> a = [x for x in a if x != 20]
>>> print a
[10, 30, 40, 30, 40, 70]
```

#### Answer 2 (score 171)
Usually Python will throw an Exception if you tell it to do something it can't so you'll have to do either:  

```python
if c in a:
    a.remove(c)
```

or:  

```python
try:
    a.remove(c)
except ValueError:
    pass
```

An Exception isn't necessarily a bad thing as long as it's one you're expecting and handle properly.  

#### Answer 3 (score 76)
You can do  

```python
a=[1,2,3,4]
if 6 in a:
    a.remove(6)
```

but above need to search 6 in list a 2 times, so try except would be faster  

```python
try:
    a.remove(6)
except:
    pass
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: Python: Find in list (score [1578399](https://stackoverflow.com/q/9542738) in 2018)

#### Question
I have come across this:  

```python
item = someSortOfSelection()
if item in myList:
    doMySpecialFunction(item)
```

but sometimes it does not work with all my items, as if they weren't recognized in the list (when it's a list of string).  

Is this the most 'pythonic' way of finding an item in a list: `if x in l:`?  

#### Answer accepted (score 1039)
As for your first question: that code is perfectly fine and should work if `item` equals one of the elements inside `myList`. Maybe you try to find a string that does not <em>exactly</em> match one of the items or maybe you are using a float value which suffers from inaccuracy.  

As for your second question: There's actually several possible ways if "finding" things in lists.  

<h5>Checking if something is inside</h3>

This is the use case you describe: Checking whether something is inside a list or not. As you know, you can use the `in` operator for that:  

```python
3 in [1, 2, 3] # => True
```

<h5>Filtering a collection</h3>

That is, finding all elements in a sequence that meet a certain condition. You can use list comprehension or generator expressions for that:  

```python
matches = [x for x in lst if fulfills_some_condition(x)]
matches = (x for x in lst if x > 6)
```

The latter will return a <em>generator</em> which you can imagine as a sort of lazy list that will only be built as soon as you iterate through it. By the way, the first one is exactly equivalent to  

```python
matches = filter(fulfills_some_condition, lst)
```

in Python 2. Here you can see higher-order functions at work. In Python 3, `filter` doesn't return a list, but a generator-like object.  

<h5>Finding the first occurrence</h3>

If you only want the first thing that matches a condition (but you don't know what it is yet), it's fine to use a for loop (possibly using the `else` clause as well, which is not really well-known). You can also use  

```python
next(x for x in lst if ...)
```

which will return the first match or raise a `StopIteration` if none is found. Alternatively, you can use  

```python
next((x for x in lst if ...), [default value])
```

<h5>Finding the location of an item</h3>

For lists, there's also the `index` method that can sometimes be useful if you want to know <em>where</em> a certain element is in the list:  

```python
[1,2,3].index(2) # => 1
[1,2,3].index(4) # => ValueError
```

However, note that if you have duplicates, `.index` always returns the lowest index:......  

```python
[1,2,3,2].index(2) # => 1
```

If there are duplicates and you want all the indexes then you can use `enumerate()` instead:  

```python
[i for i,x in enumerate([1,2,3,2]) if x==2] # => [1, 3]
```

#### Answer 2 (score 168)
If you want to find one element or `None` use default in `next`, it won't raise `StopIteration` if the item was not found in the list:  

```python
first_or_default = next((x for x in lst if ...), None)
```

#### Answer 3 (score 18)
While the answer from Niklas B. is pretty comprehensive, when we want to find an item in a list it is sometimes useful to get its index:  

```python
next((i for i, x in enumerate(lst) if [condition on x]), [default value])
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: Manually raising (throwing) an exception in Python (score [1572164](https://stackoverflow.com/q/2052390) in 2019)

#### Question
How can I raise an exception in Python so that it can later be caught via an `except` block?  

#### Answer accepted (score 2620)
<blockquote>
  <h5>How do I manually throw/raise an exception in Python?</h2>
</blockquote>

<a href="https://docs.python.org/3/library/exceptions.html#exception-hierarchy" rel="noreferrer">Use the most specific Exception constructor that semantically fits your issue</a>.    

Be specific in your message, e.g.:  

```python
raise ValueError('A very specific bad thing happened.')
```

<h5>Don't raise generic exceptions</h2>

Avoid raising a generic Exception. To catch it, you'll have to catch all other more specific exceptions that subclass it.  

<h5>Problem 1: Hiding bugs</h3>

```python
raise Exception('I know Python!') # Don't! If you catch, likely to hide bugs.
```

For example:  

```python
def demo_bad_catch():
    try:
        raise ValueError('Represents a hidden bug, do not catch this')
        raise Exception('This is the exception you expect to handle')
    except Exception as error:
        print('Caught this error: ' + repr(error))

>>> demo_bad_catch()
Caught this error: ValueError('Represents a hidden bug, do not catch this',)
```

<h5>Problem 2: Won't catch</h3>

and more specific catches won't catch the general exception:  

```python
def demo_no_catch():
    try:
        raise Exception('general exceptions not caught by specific handling')
    except ValueError as e:
        print('we will not catch exception: Exception')


>>> demo_no_catch()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 3, in demo_no_catch
Exception: general exceptions not caught by specific handling
```

<h5>Best Practices: `raise` statement</h2>

<a href="https://docs.python.org/3/library/exceptions.html#exception-hierarchy" rel="noreferrer">Instead, use the most specific Exception constructor that semantically fits your issue</a>.  

```python
raise ValueError('A very specific bad thing happened')
```

which also handily allows an arbitrary number of arguments to be passed to the constructor:  

```python
raise ValueError('A very specific bad thing happened', 'foo', 'bar', 'baz') 
```

These arguments are accessed by the `args` attribute on the Exception object. For example:  

```python
try:
    some_code_that_may_raise_our_value_error()
except ValueError as err:
    print(err.args)
```

prints   

```python
('message', 'foo', 'bar', 'baz')    
```

In Python 2.5, an actual `message` attribute was added to BaseException in favor of encouraging users to subclass Exceptions and stop using `args`, but <a href="http://www.python.org/dev/peps/pep-0352/#retracted-ideas" rel="noreferrer">the introduction of `message` and the original deprecation of args has been retracted</a>.  

<h5>Best Practices: `except` clause</h2>

When inside an except clause, you might want to, for example, log that a specific type of error happened, and then re-raise. The best way to do this while preserving the stack trace is to use a bare raise statement. For example:  

```python
logger = logging.getLogger(__name__)

try:
    do_something_in_app_that_breaks_easily()
except AppError as error:
    logger.error(error)
    raise                 # just this!
    # raise AppError      # Don't do this, you'll lose the stack trace!
```

<h5>Don't modify your errors... but if you insist.</h3>

You can preserve the stacktrace (and error value) with `sys.exc_info()`, but <strong>this is way more error prone</strong> and <strong>has compatibility problems between Python 2 and 3</strong>, prefer to use a bare `raise` to re-raise.   

To explain - the `sys.exc_info()` returns the type, value, and traceback.   

```python
type, value, traceback = sys.exc_info()
```

This is the syntax in Python 2 - note this is not compatible with Python 3:  

```python
    raise AppError, error, sys.exc_info()[2] # avoid this.
    # Equivalently, as error *is* the second object:
    raise sys.exc_info()[0], sys.exc_info()[1], sys.exc_info()[2]
```

If you want to, you can modify what happens with your new raise - e.g. setting new args for the instance:  

```python
def error():
    raise ValueError('oops!')

def catch_error_modify_message():
    try:
        error()
    except ValueError:
        error_type, error_instance, traceback = sys.exc_info()
        error_instance.args = (error_instance.args[0] + ' <modification>',)
        raise error_type, error_instance, traceback
```

And we have preserved the whole traceback while modifying the args. Note that this is <strong>not a best practice</strong> and it is <strong>invalid syntax</strong> in Python 3 (making keeping compatibility much harder to work around).  

```python
>>> catch_error_modify_message()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 3, in catch_error_modify_message
  File "<stdin>", line 2, in error
ValueError: oops! <modification>
```

In <a href="https://docs.python.org/3/reference/simple_stmts.html#the-raise-statement" rel="noreferrer">Python 3</a>:  

```python
    raise error.with_traceback(sys.exc_info()[2])
```

Again: avoid manually manipulating tracebacks. It's <a href="https://docs.python.org/2/reference/simple_stmts.html#the-raise-statement" rel="noreferrer">less efficient</a> and more error prone. And if you're using threading and `sys.exc_info` you may even get the wrong traceback (especially if you're using exception handling for control flow - which I'd personally tend to avoid.)  

<h5>Python 3, Exception chaining</h3>

In Python 3, you can chain Exceptions, which preserve tracebacks:  

```python
    raise RuntimeError('specific message') from error
```

Be aware:  

<ul>
<li>this <em>does</em> allow changing the error type raised, and</li>
<li>this is <em>not</em> compatible with Python 2.</li>
</ul>

<h5>Deprecated Methods:</h3>

These can easily hide and even get into production code. You want to raise an exception, and doing them will raise an exception, <strong>but not the one intended!</strong>  

<a href="http://www.python.org/dev/peps/pep-3109/" rel="noreferrer">Valid in Python 2, but not in Python 3</a> is the following:  

```python
raise ValueError, 'message' # Don't do this, it's deprecated!
```

Only <a href="https://docs.python.org/2/whatsnew/2.5.html#pep-352-exceptions-as-new-style-classes" rel="noreferrer">valid in much older versions of Python</a> (2.4 and lower), you may still see people raising strings:  

```python
raise 'message' # really really wrong. don't do this.
```

In all modern versions, this will actually raise a TypeError, because you're not raising a BaseException type. If you're not checking for the right exception and don't have a reviewer that's aware of the issue, it could get into production.  

<h5>Example Usage</h2>

I raise Exceptions to warn consumers of my API if they're using it incorrectly:  

```python
def api_func(foo):
    '''foo should be either 'baz' or 'bar'. returns something very useful.'''
    if foo not in _ALLOWED_ARGS:
        raise ValueError('{foo} wrong, use "baz" or "bar"'.format(foo=repr(foo)))
```

<h5>Create your own error types when apropos</h2>

<blockquote>
  <strong>"I want to make an error on purpose, so that it would go into the except"</strong>  
</blockquote>

You can create your own error types, if you want to indicate something specific is wrong with your application, just subclass the appropriate point in the exception hierarchy:  

```python
class MyAppLookupError(LookupError):
    '''raise this when there's a lookup error for my app'''
```

and usage:  

```python
if important_key not in resource_dict and not ok_to_be_missing:
    raise MyAppLookupError('resource is missing, and that is not ok.')
```

#### Answer 2 (score 529)
<blockquote>
  <strong>DON'T DO THIS</strong>. Raising a bare `Exception` is absolutely <strong>not</strong> the right thing to do; see <a href="https://stackoverflow.com/a/24065533">Aaron Hall's excellent answer</a> instead.  
</blockquote>

Can't get much more pythonic than this:  

```python
raise Exception("I know python!")
```

See <a href="http://docs.python.org/reference/simple_stmts.html#the-raise-statement" rel="nofollow noreferrer">the raise statement docs</a> for python if you'd like more info.  

#### Answer 3 (score 41)
In Python3 there are 4 different syntaxes for rasing exceptions:   

```python
1. raise exception 
2. raise exception (args) 
3. raise
4. raise exception (args) from original_exception
```

<blockquote>
  <strong>1. raise exception vs. 2. raise exception (args)</strong>  
</blockquote>

If you use `raise exception (args)`  to raise an exception then the   `args` will be printed when you print the exception object - as shown in the example below.   

```python
  #raise exception (args)
    try:
        raise ValueError("I have raised an Exception")
    except ValueError as exp:
        print ("Error", exp)     # Output -> Error I have raised an Exception 



  #raise execption 
    try:
        raise ValueError
    except ValueError as exp:
        print ("Error", exp)     # Output -> Error 
```

<blockquote>
  <strong>3.raise</strong>  
</blockquote>

<p>`raise` statement without any arguments re-raises the last exception. 
This is useful if you need to perform some actions after catching the exception and  then want to re-raise it. But if there was no exception before, `raise` statement raises  `TypeError` Exception. </p>

```python
def somefunction():
    print("some cleaning")

a=10
b=0 
result=None

try:
    result=a/b
    print(result)

except Exception:            #Output ->
    somefunction()           #some cleaning
    raise                    #Traceback (most recent call last):
                             #File "python", line 8, in <module>
                             #ZeroDivisionError: division by zero
```

<blockquote>
  <strong>4. raise exception (args) from original_exception</strong>  
</blockquote>

This statement is used to create exception chaining in which an exception that is raised in response to another exception can contain the details of the original exception - as shown in the example below.  

```python
class MyCustomException(Exception):
pass

a=10
b=0 
reuslt=None
try:
    try:
        result=a/b

    except ZeroDivisionError as exp:
        print("ZeroDivisionError -- ",exp)
        raise MyCustomException("Zero Division ") from exp

except MyCustomException as exp:
        print("MyException",exp)
        print(exp.__cause__)
```

<strong>Output:</strong>  

```python
ZeroDivisionError --  division by zero
MyException Zero Division 
division by zero
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: How to access environment variable values? (score [1565338](https://stackoverflow.com/q/4906977) in 2019)

#### Question
I set an environment variable that I want to access in my Python application.  How do I get this value?  

#### Answer accepted (score 2745)
Environment variables are accessed through <a href="https://docs.python.org/library/os.html#os.environ" rel="noreferrer">os.environ</a>  

```python
import os
print(os.environ['HOME'])
```

Or you can see a list of all the environment variables using:  

```python
os.environ
```

As sometimes you might need to see a complete list!  

```python
# using get will return `None` if a key is not present rather than raise a `KeyError`
print(os.environ.get('KEY_THAT_MIGHT_EXIST'))

# os.getenv is equivalent, and can also give a default value instead of `None`
print(os.getenv('KEY_THAT_MIGHT_EXIST', default_value))
```

<a href="https://docs.python.org/install/index.html#how-installation-works" rel="noreferrer">Python default installation</a> on Windows is `C:\Python`. If you want to find out while running python you can do:  

```python
import sys
print(sys.prefix)
```

#### Answer 2 (score 209)
To check if the key exists (returns `True` or `False`)  

```python
'HOME' in os.environ
```

You can also use `get()` when printing the key; useful if you want to use a default.  

```python
print(os.environ.get('HOME', '/home/username/'))
```

where `/home/username/` is the default  

#### Answer 3 (score 48)
The original question (first part) was "how to check environment variables in Python."   

Here's how to check if $FOO is set:   

```python
try:  
   os.environ["FOO"]
except KeyError: 
   print "Please set the environment variable FOO"
   sys.exit(1)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: Understanding Python super() with __init__() methods (score [1561073](https://stackoverflow.com/q/576169) in 2018)

#### Question
I'm trying to understand the use of `super()`. From the looks of it, both child classes can be created, just fine.   

I'm curious to know about the actual difference between the following 2 child classes.  

```python
class Base(object):
    def __init__(self):
        print "Base created"

class ChildA(Base):
    def __init__(self):
        Base.__init__(self)

class ChildB(Base):
    def __init__(self):
        super(ChildB, self).__init__()

ChildA() 
ChildB()
```

#### Answer accepted (score 1703)
`super()` lets you avoid referring to the base class explicitly, which can be nice. But the main advantage comes with multiple inheritance, where all sorts of <a href="http://www.artima.com/weblogs/viewpost.jsp?thread=236275" rel="noreferrer">fun stuff</a> can happen. See the <a href="https://docs.python.org/2/library/functions.html#super" rel="noreferrer">standard docs on super</a> if you haven't already.  

Note that <a href="https://docs.python.org/3/library/functions.html#super" rel="noreferrer">the syntax changed in Python 3.0</a>: you can just say `super().__init__()` instead of `super(ChildB, self).__init__()` which IMO is quite a bit nicer. The standard docs also refer to a <a href="https://rhettinger.wordpress.com/2011/05/26/super-considered-super/" rel="noreferrer">guide to using super()</a> which is quite explanatory.  

#### Answer 2 (score 644)
<blockquote>
  <h5>I'm trying to understand `super()`</h2>
</blockquote>

The reason we use `super` is so that child classes that may be using cooperative multiple inheritance will call the correct next parent class function in the Method Resolution Order (MRO).  

In Python 3, we can call it like this:  

```python
class ChildB(Base):
    def __init__(self):
        super().__init__() 
```

In Python 2, we are required to use it like this:  

```python
super(ChildB, self).__init__()
```

Without super, you are limited in your ability to use multiple inheritance:  

```python
Base.__init__(self) # Avoid this.
```

I further explain below.  

<blockquote>
  <h5>"What difference is there actually in this code?:"</h2>
</blockquote>

```python
class ChildA(Base):
    def __init__(self):
        Base.__init__(self)

class ChildB(Base):
    def __init__(self):
        super(ChildB, self).__init__()
        # super().__init__() # you can call super like this in Python 3!
```

The primary difference in this code is that you get a layer of indirection in the `__init__` with `super`, which uses the current class to determine the next class's `__init__` to look up in the MRO.  

I illustrate this difference in an answer at the <a href="https://stackoverflow.com/a/33469090/541136">canonical question, How to use 'super' in Python?</a>, which demonstrates <strong>dependency injection</strong> and <strong>cooperative multiple inheritance</strong>.  

<h5>If Python didn't have `super`</h2>

Here's code that's actually closely equivalent to `super` (how it's implemented in C, minus some checking and fallback behavior, and translated to Python):  

```python
class ChildB(Base):
    def __init__(self):
        mro = type(self).mro()             # Get the Method Resolution Order.
        check_next = mro.index(ChildB) + 1 # Start looking after *this* class.
        while check_next < len(mro):
            next_class = mro[check_next]
            if '__init__' in next_class.__dict__:
                next_class.__init__(self)
                break
            check_next += 1
```

Written a little more like native Python:  

```python
class ChildB(Base):
    def __init__(self):
        mro = type(self).mro()
        for next_class in mro[mro.index(ChildB) + 1:]: # slice to end
            if hasattr(next_class, '__init__'):
                next_class.__init__(self)
                break
```

If we didn't have the `super` object, we'd have to write this manual code everywhere (or recreate it!) to ensure that we call the proper next method in the Method Resolution Order!  

How does super do this in Python 3 without being told explicitly which class and instance from the method it was called from?   

It gets the calling stack frame, and finds the class (implicitly stored as a local free variable, `__class__`, making the calling function a closure over the class) and the first argument to that function, which should be the instance or class that informs it which Method Resolution Order (MRO) to use.   

Since it requires that first argument for the MRO, <a href="https://bugs.python.org/issue31118" rel="noreferrer">using `super` with static methods is impossible</a>.  

<h5>Criticisms of other answers:</h2>

<blockquote>
  super() lets you avoid referring to the base class explicitly, which can be nice. . But the main advantage comes with multiple inheritance, where all sorts of fun stuff can happen. See the standard docs on super if you haven't already.  
</blockquote>

It's rather hand-wavey and doesn't tell us much, but the point of `super` is not to avoid writing the parent class. The point is to ensure that the next method in line in the method resolution order (MRO) is called. This becomes important in multiple inheritance.  

I'll explain here.  

```python
class Base(object):
    def __init__(self):
        print("Base init'ed")

class ChildA(Base):
    def __init__(self):
        print("ChildA init'ed")
        Base.__init__(self)

class ChildB(Base):
    def __init__(self):
        print("ChildB init'ed")
        super(ChildB, self).__init__()
```

And let's create a dependency that we want to be called after the Child:  

```python
class UserDependency(Base):
    def __init__(self):
        print("UserDependency init'ed")
        super(UserDependency, self).__init__()
```

Now remember, `ChildB` uses super, `ChildA` does not:  

```python
class UserA(ChildA, UserDependency):
    def __init__(self):
        print("UserA init'ed")
        super(UserA, self).__init__()

class UserB(ChildB, UserDependency):
    def __init__(self):
        print("UserB init'ed")
        super(UserB, self).__init__()
```

And `UserA` does not call the UserDependency method:  

```python
>>> UserA()
UserA init'ed
ChildA init'ed
Base init'ed
<__main__.UserA object at 0x0000000003403BA8>
```

But `UserB`, because `ChildB` uses `super`, does!:  

```python
>>> UserB()
UserB init'ed
ChildB init'ed
UserDependency init'ed
Base init'ed
<__main__.UserB object at 0x0000000003403438>
```

<h5>Criticism for another answer</h3>

In no circumstance should you do the following, which another answer suggests, as you'll definitely get errors when you subclass ChildB:  

```python
super(self.__class__, self).__init__() # Don't do this. Ever.
```

<sub>(That answer is not clever or particularly interesting, but in spite of direct criticism in the comments and over 17 downvotes, the answerer persisted in suggesting it until a kind editor fixed his problem.)</sub>  

Explanation: That answer suggested calling super like this:  

```python
super(self.__class__, self).__init__()
```

This is <em>completely</em> wrong. `super` lets us look up the next parent in the MRO (see the first section of this answer) for child classes. If you tell `super` we're in the child instance's method, it will then lookup the next method in line (probably this one) resulting in recursion, probably causing a logical failure (in the answerer's example, it does) or a `RuntimeError` when the recursion depth is exceeded.  

```python
>>> class Polygon(object):
...     def __init__(self, id):
...         self.id = id
...
>>> class Rectangle(Polygon):
...     def __init__(self, id, width, height):
...         super(self.__class__, self).__init__(id)
...         self.shape = (width, height)
...
>>> class Square(Rectangle):
...     pass
...
>>> Square('a', 10, 10)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 3, in __init__
TypeError: __init__() missing 2 required positional arguments: 'width' and 'height'
```

#### Answer 3 (score 248)
It's been noted that in Python 3.0+ you can use  

`super().__init__()`   

to make your call, which is concise and does not require you to reference the parent OR class names explicitly, which can be handy. I just want to add that for Python 2.7 or under, it is possible to get this name-insensitive behaviour by writing `self.__class__` instead of the class name, i.e.  

```python
super(self.__class__, self).__init__()
```

HOWEVER, this breaks calls to `super` for any classes that inherit from your class, where `self.__class__` could return a child class. For example:  

```python
class Polygon(object):
    def __init__(self, id):
        self.id = id

class Rectangle(Polygon):
    def __init__(self, id, width, height):
        super(self.__class__, self).__init__(id)
        self.shape = (width, height)

class Square(Rectangle):
    pass
```

Here I have a class `Square`, which is a sub-class of `Rectangle`. Say I don't want to write a separate constructor for `Square` because the constructor for `Rectangle` is good enough, but for whatever reason I want to implement a Square so I can reimplement some other method.  

When I create a `Square` using `mSquare = Square('a', 10,10)`, Python calls the constructor for `Rectangle` because I haven't given `Square` its own constructor. However, in the constructor for `Rectangle`, the call `super(self.__class__,self)` is going to return the superclass of `mSquare`, so it calls the constructor for `Rectangle` again. This is how the infinite loop happens, as was mentioned by @S_C. In this case, when I run `super(...).__init__()` I am calling the constructor for `Rectangle` but since I give it no arguments, I will get an error.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: Understanding slice notation (score [1550739](https://stackoverflow.com/q/509211) in 2019)

#### Question
I need a good explanation (references are a plus) on Python's slice notation.   

To me, this notation needs a bit of picking up.   

It looks extremely powerful, but I haven't quite got my head around it.  

#### Answer accepted (score 4014)
It's pretty simple really:  

```python
a[start:stop]  # items start through stop-1
a[start:]      # items start through the rest of the array
a[:stop]       # items from the beginning through stop-1
a[:]           # a copy of the whole array
```

There is also the `step` value, which can be used with any of the above:  

```python
a[start:stop:step] # start through not past stop, by step
```

The key point to remember is that the `:stop` value represents the first value that is <em>not</em> in the selected slice. So, the difference between `stop` and `start` is the number of elements selected (if `step` is 1, the default).  

The other feature is that `start` or `stop` may be a <em>negative</em> number, which means it counts from the end of the array instead of the beginning. So:  

```python
a[-1]    # last item in the array
a[-2:]   # last two items in the array
a[:-2]   # everything except the last two items
```

Similarly, `step` may be a negative number:  

```python
a[::-1]    # all items in the array, reversed
a[1::-1]   # the first two items, reversed
a[:-3:-1]  # the last two items, reversed
a[-3::-1]  # everything except the last two items, reversed
```

Python is kind to the programmer if there are fewer items than you ask for. For example, if you ask for `a[:-2]` and `a` only contains one element, you get an empty list instead of an error. Sometimes you would prefer the error, so you have to be aware that this may happen.  

<h5>Relation to `slice()` object</h3>

The slicing operator `[]` is actually being used in the above code with a `slice()` object using the `:` notation (which is only valid within `[]`), i.e.:  

```python
a[start:stop:step]
```

is equivalent to:  

```python
a[slice(start, stop, step)]
```

<p>Slice objects also behave slightly differently depending on the number of arguments, similarly to `range()`, i.e. both `slice(stop)` and `slice(start, stop[, step])` are supported.
To skip specifying a given argument, one might use `None`, so that e.g. `a[start:]` is equivalent to `a[slice(start, None)]` or `a[::-1]` is equivalent to `a[slice(None, None, -1)]`.</p>

While the `:`-based notation is very helpful for simple slicing, the explicit use of `slice()` objects simplifies the programmatic generation of slicing.  

#### Answer 2 (score 509)
The <a href="http://docs.python.org/tutorial/introduction.html#strings" rel="noreferrer">Python tutorial</a> talks about it (scroll down a bit until you get to the part about slicing).  

The ASCII art diagram is helpful too for remembering how slices work:  

```python
 +---+---+---+---+---+---+
 | P | y | t | h | o | n |
 +---+---+---+---+---+---+
 0   1   2   3   4   5   6
-6  -5  -4  -3  -2  -1
```

<blockquote>
  One way to remember how slices work is to think of the indices as pointing <em>between</em> characters, with the left edge of the first character numbered 0. Then the right edge of the last character of a string of <em>n</em> characters has index <em>n</em>.  
</blockquote>

#### Answer 3 (score 391)
Enumerating the possibilities allowed by the grammar:  

```python
>>> seq[:]                # [seq[0],   seq[1],          ..., seq[-1]    ]
>>> seq[low:]             # [seq[low], seq[low+1],      ..., seq[-1]    ]
>>> seq[:high]            # [seq[0],   seq[1],          ..., seq[high-1]]
>>> seq[low:high]         # [seq[low], seq[low+1],      ..., seq[high-1]]
>>> seq[::stride]         # [seq[0],   seq[stride],     ..., seq[-1]    ]
>>> seq[low::stride]      # [seq[low], seq[low+stride], ..., seq[-1]    ]
>>> seq[:high:stride]     # [seq[0],   seq[stride],     ..., seq[high-1]]
>>> seq[low:high:stride]  # [seq[low], seq[low+stride], ..., seq[high-1]]
```

Of course, if `(high-low)%stride != 0`, then the end point will be a little lower than `high-1`.  

If `stride` is negative, the ordering is changed a bit since we're counting down:  

```python
>>> seq[::-stride]        # [seq[-1],   seq[-1-stride],   ..., seq[0]    ]
>>> seq[high::-stride]    # [seq[high], seq[high-stride], ..., seq[0]    ]
>>> seq[:low:-stride]     # [seq[-1],   seq[-1-stride],   ..., seq[low+1]]
>>> seq[high:low:-stride] # [seq[high], seq[high-stride], ..., seq[low+1]]
```

Extended slicing (with commas and ellipses) are mostly used only by special data structures (like NumPy); the basic sequences don't support them.  

```python
>>> class slicee:
...     def __getitem__(self, item):
...         return repr(item)
...
>>> slicee()[0, 1:2, ::5, ...]
'(0, slice(1, 2, None), slice(None, None, 5), Ellipsis)'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: Get list from pandas DataFrame column headers (score [1535570](https://stackoverflow.com/q/19482970) in 2019)

#### Question
I want to get a list of the column headers from a pandas DataFrame.  The DataFrame will come from user input so I won't know how many columns there will be or what they will be called.  

For example, if I'm given a DataFrame like this:  

```python
>>> my_dataframe
    y  gdp  cap
0   1    2    5
1   2    3    9
2   8    7    2
3   3    4    7
4   6    7    7
5   4    8    3
6   8    2    8
7   9    9   10
8   6    6    4
9  10   10    7
```

I would want to get a list like this:  

```python
>>> header_list
['y', 'gdp', 'cap']
```

#### Answer accepted (score 1476)
You can get the values as a list by doing:  

```python
list(my_dataframe.columns.values)
```

Also you can simply use: (as shown in <a href="https://stackoverflow.com/a/19483602/4909087">Ed Chum's answer</a>):  

```python
list(my_dataframe)
```

#### Answer 2 (score 360)
There is a built in method which is the most performant:  

```python
my_dataframe.columns.values.tolist()
```

`.columns` returns an Index, `.columns.values` returns an array and this has a helper function `.tolist` to return a list.  

If performance is not as important to you, `Index` objects define a `.tolist()` method that you can call directly:  

```python
my_dataframe.columns.tolist()
```

The difference in performance is obvious:  

```python
%timeit df.columns.tolist()
16.7 µs ± 317 ns per loop (mean ± std. dev. of 7 runs, 100000 loops each)

%timeit df.columns.values.tolist()
1.24 µs ± 12.3 ns per loop (mean ± std. dev. of 7 runs, 1000000 loops each)
```

<hr>

For those who hate typing, you can just call `list` on `df`, as so:  

```python
list(df)
```

#### Answer 3 (score 80)
Did some quick tests, and perhaps unsurprisingly the built-in version using `dataframe.columns.values.tolist()` is the fastest:  

```python
In [1]: %timeit [column for column in df]
1000 loops, best of 3: 81.6 µs per loop

In [2]: %timeit df.columns.values.tolist()
10000 loops, best of 3: 16.1 µs per loop

In [3]: %timeit list(df)
10000 loops, best of 3: 44.9 µs per loop

In [4]: % timeit list(df.columns.values)
10000 loops, best of 3: 38.4 µs per loop
```

(I still really like the `list(dataframe)` though, so thanks EdChum!)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Find all files in a directory with extension .txt in Python (score [1534437](https://stackoverflow.com/q/3964681) in 2017)

#### Question
How can I find all the files in a directory having the extension `.txt` in python?  

#### Answer accepted (score 2086)
You can use <a href="https://docs.python.org/2/library/glob.html" rel="noreferrer">`glob`</a>:  

```python
import glob, os
os.chdir("/mydir")
for file in glob.glob("*.txt"):
    print(file)
```

or simply <a href="https://docs.python.org/2/library/os.html#os.listdir" rel="noreferrer">`os.listdir`</a>:  

```python
import os
for file in os.listdir("/mydir"):
    if file.endswith(".txt"):
        print(os.path.join("/mydir", file))
```

or if you want to traverse directory, use <a href="https://docs.python.org/2/library/os.html#os.walk" rel="noreferrer">`os.walk`</a>:  

```python
import os
for root, dirs, files in os.walk("/mydir"):
    for file in files:
        if file.endswith(".txt"):
             print(os.path.join(root, file))
```

#### Answer 2 (score 214)
Use <a href="http://docs.python.org/library/glob.html" rel="noreferrer">glob</a>.  

```python
>>> import glob
>>> glob.glob('./*.txt')
['./outline.txt', './pip-log.txt', './test.txt', './testingvim.txt']
```

#### Answer 3 (score 133)
Something like that should do the job  

```python
for root, dirs, files in os.walk(directory):
    for file in files:
        if file.endswith('.txt'):
            print file
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: UnicodeEncodeError: 'ascii' codec can't encode character u'\xa0' in position 20: ordinal not in range(128) (score [1532253](https://stackoverflow.com/q/9942594) in 2016)

#### Question
I'm having problems dealing with unicode characters from text fetched from different web pages (on different sites). I am using BeautifulSoup.   

The problem is that the error is not always reproducible; it sometimes works with some pages, and sometimes, it barfs by throwing a `UnicodeEncodeError`. I have tried just about everything I can think of, and yet I have not found anything that works consistently without throwing some kind of Unicode-related error.  

One of the sections of code that is causing problems is shown below:  

```python
agent_telno = agent.find('div', 'agent_contact_number')
agent_telno = '' if agent_telno is None else agent_telno.contents[0]
p.agent_info = str(agent_contact + ' ' + agent_telno).strip()
```

Here is a stack trace produced on SOME strings when the snippet above is run:  

```python
Traceback (most recent call last):
  File "foobar.py", line 792, in <module>
    p.agent_info = str(agent_contact + ' ' + agent_telno).strip()
UnicodeEncodeError: 'ascii' codec can't encode character u'\xa0' in position 20: ordinal not in range(128)
```

I suspect that this is because some pages (or more specifically, pages from some of the sites) may be encoded, whilst others may be unencoded. All the sites are based in the UK and provide data meant for UK consumption - so there are no issues relating to internalization or dealing with text written in anything other than English.  

Does anyone have any ideas as to how to solve this so that I can CONSISTENTLY fix this problem?  

#### Answer accepted (score 1284)
You need to read the Python <a href="https://docs.python.org/2.7/howto/unicode.html" rel="noreferrer">Unicode HOWTO</a>. This error is the <a href="https://docs.python.org/2.7/howto/unicode.html#the-unicode-type" rel="noreferrer">very first example</a>.  

Basically, stop using `str` to convert from unicode to encoded text / bytes.  

Instead, properly use <a href="http://docs.python.org/library/stdtypes.html#str.encode" rel="noreferrer">`.encode()`</a> to encode the string:  

```python
p.agent_info = u' '.join((agent_contact, agent_telno)).encode('utf-8').strip()
```

or work entirely in unicode.  

#### Answer 2 (score 421)
This is a classic python unicode pain point! Consider the following:  

```python
a = u'bats\u00E0'
print a
 => batsà
```

All good so far, but if we call str(a), let's see what happens:  

```python
str(a)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
UnicodeEncodeError: 'ascii' codec can't encode character u'\xe0' in position 4: ordinal not in range(128)
```

Oh dip, that's not gonna do anyone any good! To fix the error, encode the bytes explicitly with .encode and tell python what codec to use:  

```python
a.encode('utf-8')
 => 'bats\xc3\xa0'
print a.encode('utf-8')
 => batsà
```

Voil\u00E0!  

The issue is that when you call str(), python uses the default character encoding to try and encode the bytes you gave it, which in your case are sometimes representations of unicode characters. To fix the problem, you have to tell python how to deal with the string you give it by using .encode('whatever_unicode'). Most of the time, you should be fine using utf-8.  

For an excellent exposition on this topic, see Ned Batchelder's PyCon talk here: <a href="http://nedbatchelder.com/text/unipain.html">http://nedbatchelder.com/text/unipain.html</a>  

#### Answer 3 (score 200)
I found elegant work around for me to remove symbols and continue to keep string as string in follows:  

```python
yourstring = yourstring.encode('ascii', 'ignore').decode('ascii')
```

It's important to notice that using the ignore option is <strong>dangerous</strong> because it silently drops any unicode(and internationalization) support from the code that uses it, as seen here (convert unicode):  

```python
>>> u'City: Malmö'.encode('ascii', 'ignore').decode('ascii')
'City: Malm'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: How do I append one string to another in Python? (score [1511101](https://stackoverflow.com/q/4435169) in 2019)

#### Question
I want an efficient way to append one string to another in Python, other than the following.  

```python
var1 = "foo"
var2 = "bar"
var3 = var1 + var2
```

Is there any good built-in method to use?  

#### Answer accepted (score 580)
If you only have one reference to a string and you concatenate another string to the end, CPython now special cases this and tries to extend the string in place.  

The end result is that the operation is amortized O(n).  

e.g.  

```python
s = ""
for i in range(n):
    s+=str(i)
```

used to be O(n^2), but now it is O(n).  

From the source (bytesobject.c):  

```python
void
PyBytes_ConcatAndDel(register PyObject **pv, register PyObject *w)
{
    PyBytes_Concat(pv, w);
    Py_XDECREF(w);
}


/* The following function breaks the notion that strings are immutable:
   it changes the size of a string.  We get away with this only if there
   is only one module referencing the object.  You can also think of it
   as creating a new string object and destroying the old one, only
   more efficiently.  In any case, don't use this if the string may
   already be known to some other part of the code...
   Note that if there's not enough memory to resize the string, the original
   string object at *pv is deallocated, *pv is set to NULL, an "out of
   memory" exception is set, and -1 is returned.  Else (on success) 0 is
   returned, and the value in *pv may or may not be the same as on input.
   As always, an extra byte is allocated for a trailing \0 byte (newsize
   does *not* include that), and a trailing \0 byte is stored.
*/

int
_PyBytes_Resize(PyObject **pv, Py_ssize_t newsize)
{
    register PyObject *v;
    register PyBytesObject *sv;
    v = *pv;
    if (!PyBytes_Check(v) || Py_REFCNT(v) != 1 || newsize < 0) {
        *pv = 0;
        Py_DECREF(v);
        PyErr_BadInternalCall();
        return -1;
    }
    /* XXX UNREF/NEWREF interface should be more symmetrical */
    _Py_DEC_REFTOTAL;
    _Py_ForgetReference(v);
    *pv = (PyObject *)
        PyObject_REALLOC((char *)v, PyBytesObject_SIZE + newsize);
    if (*pv == NULL) {
        PyObject_Del(v);
        PyErr_NoMemory();
        return -1;
    }
    _Py_NewReference(*pv);
    sv = (PyBytesObject *) *pv;
    Py_SIZE(sv) = newsize;
    sv->ob_sval[newsize] = '\0';
    sv->ob_shash = -1;          /* invalidate cached hash value */
    return 0;
}
```

It's easy enough to verify empirically.  

<pre>
$ python -m timeit -s"s=''" "for i in xrange(10):s+='a'"
1000000 loops, best of 3: 1.85 usec per loop
$ python -m timeit -s"s=''" "for i in xrange(100):s+='a'"
10000 loops, best of 3: 16.8 usec per loop
$ python -m timeit -s"s=''" "for i in xrange(1000):s+='a'"
10000 loops, best of 3: 158 usec per loop
$ python -m timeit -s"s=''" "for i in xrange(10000):s+='a'"
1000 loops, best of 3: 1.71 msec per loop
$ python -m timeit -s"s=''" "for i in xrange(100000):s+='a'"
10 loops, best of 3: 14.6 msec per loop
$ python -m timeit -s"s=''" "for i in xrange(1000000):s+='a'"
10 loops, best of 3: 173 msec per loop
</pre>

<strong>It's important</strong> however to note that this optimisation isn't part of the Python spec. It's only in the cPython implementation as far as I know. The same empirical testing on pypy or jython for example might show the older O(n**2) performance .  

<pre>
$ pypy -m timeit -s"s=''" "for i in xrange(10):s+='a'"
10000 loops, best of 3: 90.8 usec per loop
$ pypy -m timeit -s"s=''" "for i in xrange(100):s+='a'"
1000 loops, best of 3: 896 usec per loop
$ pypy -m timeit -s"s=''" "for i in xrange(1000):s+='a'"
100 loops, best of 3: 9.03 msec per loop
$ pypy -m timeit -s"s=''" "for i in xrange(10000):s+='a'"
10 loops, best of 3: 89.5 msec per loop
</pre>

So far so good, but then,  

<pre>
$ pypy -m timeit -s"s=''" "for i in xrange(100000):s+='a'"
10 loops, best of 3: 12.8 sec per loop
</pre>

ouch even worse than quadratic. So pypy is doing something that works well with short strings, but performs poorly for larger strings.  

#### Answer 2 (score 274)
Don't prematurely optimize. If you have no reason to believe there's a speed bottleneck caused by string concatenations then just stick with `+` and `+=`:  

```python
s  = 'foo'
s += 'bar'
s += 'baz'
```

That said, if you're aiming for something like Java's StringBuilder, the canonical Python idiom is to add items to a list and then use `str.join` to concatenate them all at the end:  

```python
l = []
l.append('foo')
l.append('bar')
l.append('baz')

s = ''.join(l)
```

#### Answer 3 (score 38)
Don't.  

That is, for most cases you are better off generating the whole string in one go rather then appending to an existing string.  

For example, don't do: `obj1.name + ":" + str(obj1.count)`  

Instead: use `"%s:%d" % (obj1.name, obj1.count)`  

That will be easier to read and more efficient.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Sum a list of numbers in Python (score [1505579](https://stackoverflow.com/q/4362586) in 2018)

#### Question
<p>I have a list of numbers such as `[1,2,3,4,5...]`, and I want to calculate `(1+2)/2` and for the second, `(2+3)/2` and the third,
`(3+4)/2`, and so on. How can I do that?</p>

I would like to sum the first number with the second and divide it by 2, then sum the second with the third and divide by 2, and so on.  

Also, how can I sum a list of numbers?  

```python
a = [1, 2, 3, 4, 5, ...]
```

Is it:  

```python
b = sum(a)
print b
```

to get one number?  

This doesn't work for me.  

#### Answer 2 (score 259)
Question 1: So you want (element 0 + element 1) / 2, (element 1 + element 2) / 2, ... etc.  

We make two lists: one of every element except the first, and one of every element except the last. Then the averages we want are the averages of each pair taken from the two lists. We use `zip` to take pairs from two lists.  

I assume you want to see decimals in the result, even though your input values are integers. By default, Python does integer division: it discards the remainder. To divide things through all the way, we need to use floating-point numbers. Fortunately, dividing an int by a float will produce a float, so we just use `2.0` for our divisor instead of `2`.  

Thus:  

```python
averages = [(x + y) / 2.0 for (x, y) in zip(my_list[:-1], my_list[1:])]
```

Question 2:  

That use of `sum` should work fine. The following works:  

```python
a = range(10)
# [0,1,2,3,4,5,6,7,8,9]
b = sum(a)
print b
# Prints 45
```

Also, you don't need to assign everything to a variable at every step along the way. `print sum(a)` works just fine.  

You will have to be more specific about exactly what you wrote and how it isn't working.  

#### Answer 3 (score 102)
Sum list of numbers:  

```python
sum(list_of_nums)
```

Calculating half of n and n - 1 (if I have the pattern correct), using a <a href="http://docs.python.org/release/2.7/tutorial/datastructures.html#list-comprehensions" rel="noreferrer">list comprehension</a>:  

```python
[(x + (x - 1)) / 2 for x in list_of_nums]
```

Sum adjacent elements, e.g. ((1 + 2) / 2) + ((2 + 3) / 2) + ... using <a href="http://docs.python.org/release/2.7/tutorial/datastructures.html#functional-programming-tools" rel="noreferrer">reduce</a> and <a href="http://docs.python.org/release/2.7/tutorial/controlflow.html#lambda-forms" rel="noreferrer">lambdas</a>  

```python
reduce(lambda x, y: (x + y) / 2, list_of_nums)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: Remove all whitespace in a string in Python (score [1504934](https://stackoverflow.com/q/8270092) in 2018)

#### Question
I want to eliminate all the whitespace from a string, on both ends, and in between words.  

I have this Python code:  

```python
def my_handle(self):
    sentence = ' hello  apple  '
    sentence.strip()
```

But that only eliminates the whitespace on both sides of the string. How do I remove all whitespace?  

#### Answer accepted (score 1506)
If you want to remove leading and ending spaces, use <a href="http://docs.python.org/2/library/stdtypes.html#str.strip" rel="noreferrer">`str.strip()`</a>:   

```python
sentence = ' hello  apple'
sentence.strip()
>>> 'hello  apple'
```

If you want to remove all spaces, use <a href="http://docs.python.org/2/library/stdtypes.html#str.replace" rel="noreferrer">`str.replace()`</a>:  

```python
sentence = ' hello  apple'
sentence.replace(" ", "")
>>> 'helloapple'
```

If you want to remove duplicated spaces, use <a href="http://docs.python.org/2/library/stdtypes.html#str.split" rel="noreferrer">`str.split()`</a>:  

```python
sentence = ' hello  apple'
" ".join(sentence.split())
>>> 'hello apple'
```

#### Answer 2 (score 241)
To remove <em>only spaces</em> use <a href="http://docs.python.org/2/library/stdtypes.html#str.replace">`str.replace`</a>:  

```python
sentence = sentence.replace(' ', '')
```

To remove <em>all whitespace characters</em> (space, tab, newline, and so on) you can use <a href="http://docs.python.org/2/library/stdtypes.html#str.split">`split`</a> then <a href="http://docs.python.org/2/library/stdtypes.html#str.join">`join`</a>:  

```python
sentence = ''.join(sentence.split())
```

or a regular expression:  

```python
import re
pattern = re.compile(r'\s+')
sentence = re.sub(pattern, '', sentence)
```

If you want to only remove whitespace from the beginning and end you can use <a href="http://docs.python.org/2/library/stdtypes.html#str.strip">`strip`</a>:  

```python
sentence = sentence.strip()
```

You can also use <a href="http://docs.python.org/2/library/stdtypes.html#str.lstrip">`lstrip`</a> to remove whitespace only from the beginning of the string, and <a href="http://docs.python.org/2/library/stdtypes.html#str.rstrip">`rstrip`</a> to remove whitespace from the end of the string.  

#### Answer 3 (score 86)
An alternative is to use regular expressions and match <a href="http://en.wikipedia.org/wiki/Whitespace_character#Unicode" rel="noreferrer">these strange white-space characters</a> too. Here are some examples:  

<strong>Remove ALL spaces in a string, even between words:</strong>  

```python
import re
sentence = re.sub(r"\s+", "", sentence, flags=re.UNICODE)
```

<strong>Remove spaces in the BEGINNING of a string:</strong>  

```python
import re
sentence = re.sub(r"^\s+", "", sentence, flags=re.UNICODE)
```

<strong>Remove spaces in the END of a string:</strong>  

```python
import re
sentence = re.sub(r"\s+$", "", sentence, flags=re.UNICODE)
```

<strong>Remove spaces both in the BEGINNING and in the END of a string:</strong>  

```python
import re
sentence = re.sub("^\s+|\s+$", "", sentence, flags=re.UNICODE)
```

<strong>Remove ONLY DUPLICATE spaces:</strong>       

```python
import re
sentence = " ".join(re.split("\s+", sentence, flags=re.UNICODE))
```

(All examples work in both Python 2 and Python 3)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: Is there a "not equal" operator in Python? (score [1487533](https://stackoverflow.com/q/11060506) in 2018)

#### Question
How would you say does not equal?  

Like   

```python
if hi == hi:
    print "hi"
elif hi (does not equal) bye:
    print "no hi"
```

Is there something equivalent to `==` that means "not equal"?  

#### Answer accepted (score 585)
Use `!=`. See <a href="http://docs.python.org/release/2.5.2/lib/comparisons.html" rel="noreferrer">comparison operators</a>. For comparing object identities, you can use the keyword `is` and its negation `is not`.  

e.g.  

```python
1 == 1 #  -> True
1 != 1 #  -> False
[] is [] #-> False (distinct objects)
a = b = []; a is b # -> True (same object)
```

#### Answer 2 (score 56)
Not equal  `!=`  (vs equal `==`)  

Are you asking about something like this?  

```python
answer = 'hi'

if answer == 'hi':     # equal
   print "hi"
elif answer != 'hi':   # not equal
   print "no hi"
```

This <a href="http://www.tutorialspoint.com/python/python_basic_operators.htm" rel="noreferrer">Python - Basic Operators</a> chart might be helpful.  

#### Answer 3 (score 24)
There's the `!=` (not equal) operator that returns `True` when two values differ, though be careful with the types because `"1" != 1`. This will always return True and `"1" == 1` will always return False, since the types differ. Python is dynamically, but strongly typed, and other statically typed languages would complain about comparing different types.  

There's also the `else` clause:  

```python
# This will always print either "hi" or "no hi" unless something unforeseen happens.
if hi == "hi":     # The variable hi is being compared to the string "hi", strings are immutable in Python, so you could use the 'is' operator.
    print "hi"     # If indeed it is the string "hi" then print "hi"
else:              # hi and "hi" are not the same
    print "no hi"
```

The `is` operator is the <em>object identity</em> operator used to check if two objects in fact are the same:  

```python
a = [1, 2]
b = [1, 2]
print a == b # This will print True since they have the same values
print a is b # This will print False since they are different objects.
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: How do you append to a file in Python? (score [1477953](https://stackoverflow.com/q/4706499) in 2019)

#### Question
How do you append to the file instead of overwriting it? Is there a special function that appends to the file?  

#### Answer accepted (score 2219)
```python
with open("test.txt", "a") as myfile:
    myfile.write("appended text")
```

#### Answer 2 (score 183)
You need to open the file in append mode, by setting "a" or "ab" as the mode. See <em><a href="https://docs.python.org/2/library/functions.html#open" rel="noreferrer">open()</a></em>.  

When you open with "a" mode, the write position will <strong>always</strong> be at the end of the file (an append). You can open with "a+" to allow reading, seek backwards and read (but all writes will still be at the end of the file!).  

Example:  

```python
>>> with open('test1','wb') as f:
        f.write('test')
>>> with open('test1','ab') as f:
        f.write('koko')
>>> with open('test1','rb') as f:
        f.read()
'testkoko'
```

<strong>Note</strong>: Using 'a' is not the same as opening with 'w' and seeking to the end of the file - consider what might happen if another program opened the file and started writing between the seek and the write. On some operating systems, opening the file with 'a' guarantees that all your following writes will be appended atomically to the end of the file (even as the file grows by other writes).  

<hr>

A few more details about how the "a" mode operates (<em>tested on Linux only</em>). Even if you seek back, every write will append to the end of the file:  

```python
>>> f = open('test','a+') # Not using 'with' just to simplify the example REPL session
>>> f.write('hi')
>>> f.seek(0)
>>> f.read()
'hi'
>>> f.seek(0)
>>> f.write('bye') # Will still append despite the seek(0)!
>>> f.seek(0)
>>> f.read()
'hibye'
```

In fact, the `fopen` <a href="http://www.manpagez.com/man/3/fopen/" rel="noreferrer">manpage</a> states:  

<blockquote>
  <p>Opening a file in append mode (a as the first character of mode)
  causes all subsequent write operations to this stream to occur at
  end-of-file, as if preceded the call:</p>

```python
fseek(stream, 0, SEEK_END);
```
</blockquote>

<hr>

<h5>Old simplified answer (not using `with`):</h3>

Example: (<em>in a real program <strong>use `with` to close the file</strong> - see <a href="http://docs.python.org/2/whatsnew/2.6.html#pep-343-the-with-statement" rel="noreferrer">the documentation</a></em>)  

```python
>>> open("test","wb").write("test")
>>> open("test","a+b").write("koko")
>>> open("test","rb").read()
'testkoko'
```

#### Answer 3 (score 45)
I always do this,  

```python
f = open('filename.txt', 'a')
f.write("stuff")
f.close()
```

It's simple, but very useful.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: Replacements for switch statement in Python? (score [1472506](https://stackoverflow.com/q/60208) in 2018)

#### Question
I want to write a function in Python that returns different fixed values based on the value of an input index.    

In other languages I would use a `switch` or `case` statement, but Python does not appear to have a `switch` statement.  What are the recommended Python solutions in this scenario?  

#### Answer accepted (score 1395)
You could use a dictionary:  

```python
def f(x):
    return {
        'a': 1,
        'b': 2,
    }[x]
```

#### Answer 2 (score 1299)
If you'd like defaults you could use the dictionary <a href="https://docs.python.org/2/library/stdtypes.html#dict.get" rel="noreferrer">`get(key[, default])`</a> method:  

```python
def f(x):
    return {
        'a': 1,
        'b': 2
    }.get(x, 9)    # 9 is default if x not found
```

#### Answer 3 (score 364)
I've always liked doing it this way  

```python
result = {
  'a': lambda x: x * 5,
  'b': lambda x: x + 7,
  'c': lambda x: x - 2
}[value](x)
```

<a href="http://blog.simonwillison.net/post/57956755106/switch" rel="noreferrer">From here</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Why does comparing strings using either '==' or 'is' sometimes produce a different result? (score [1471340](https://stackoverflow.com/q/1504717) in 2019)

#### Question
I've got a Python program where two variables are set to the value `'public'`. In a conditional expression I have the comparison `var1 is var2` which fails, but if I change it to `var1 == var2` it returns `True`.  

Now if I open my Python interpreter and do the same "is" comparison, it succeeds.  

```python
>>> s1 = 'public'
>>> s2 = 'public'
>>> s2 is s1
True
```

What am I missing here?  

#### Answer accepted (score 1439)
`is` is identity testing, `==` is equality testing. what happens in your code would be emulated in the interpreter like this:  

```python
>>> a = 'pub'
>>> b = ''.join(['p', 'u', 'b'])
>>> a == b
True
>>> a is b
False
```

so, no wonder they're not the same, right?  

In other words: `is` is the `id(a) == id(b)`  

#### Answer 2 (score 534)
Other answers here are correct: `is` is used for <em>identity</em> comparison, while `==` is used for <em>equality</em> comparison. Since what you care about is equality (the two strings should contain the same characters), in this case the `is` operator is simply wrong and you should be using `==` instead.  

The reason `is` works interactively is that (most) string literals are <a href="https://en.wikipedia.org/wiki/String_interning" rel="noreferrer">interned</a> by default. From Wikipedia:  

<blockquote>
  <p>Interned strings speed up string
  comparisons, which are sometimes a
  performance bottleneck in applications
  (such as compilers and dynamic
  programming language runtimes) that
  rely heavily on hash tables with
  string keys. Without interning,
  checking that two different strings
  are equal involves examining every
  character of both strings. This is
  slow for several reasons: it is
  inherently O(n) in the length of the
  strings; it typically requires reads
  from several regions of memory, which
  take time; and the reads fills up the
  processor cache, meaning there is less
  cache available for other needs. With
  interned strings, a simple object
  identity test suffices after the
  original intern operation; this is
  typically implemented as a pointer
  equality test, normally just a single
  machine instruction with no memory
  reference at all.</p>
</blockquote>

So, when you have two string literals (words that are literally typed into your program source code, surrounded by quotation marks) in your program that have the same value, the Python compiler will automatically intern the strings, making them both stored at the same memory location.  (Note that this doesn't <em>always</em> happen, and the rules for when this happens are quite convoluted, so please don't rely on this behavior in production code!)  

Since in your interactive session both strings are actually stored in the same memory location, they have the same <em>identity</em>, so the `is` operator works as expected.  But if you construct a string by some other method (even if that string contains <em>exactly</em> the same characters), then the string may be <em>equal</em>, but it is not <em>the same string</em> -- that is, it has a different <em>identity</em>, because it is stored in a different place in memory.  

#### Answer 3 (score 101)
The `is` keyword is a test for object identity while `==` is a value comparison.  

If you use `is`, the result will be true if and only if the object is the same object. However, `==` will be true any time the values of the object are the same.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: How can I count the occurrences of a list item? (score [1467929](https://stackoverflow.com/q/2600191) in 2018)

#### Question
Given an item, how can I count its occurrences in a list in Python?  

#### Answer accepted (score 1702)
If you only want one item's count, use the `count` method:  

```python
>>> [1, 2, 3, 4, 1, 4, 1].count(1)
3
```

<strong>Don't</strong> use this if you want to count multiple items. Calling `count` in a loop requires a separate pass over the list for every `count` call, which can be catastrophic for performance. If you want to count all items, or even just multiple items, use `Counter`, as explained in the other answers.  

#### Answer 2 (score 1598)
If you are using Python 2.7 or 3 and you want number of occurrences for each element:  

```python
>>> from collections import Counter
>>> z = ['blue', 'red', 'blue', 'yellow', 'blue', 'red']
>>> Counter(z)
Counter({'blue': 3, 'red': 2, 'yellow': 1})
```

#### Answer 3 (score 237)
<strong>Counting the occurrences of one item in a list</strong>  

For counting the occurrences of just one list item you can use `count()`  

```python
>>> l = ["a","b","b"]
>>> l.count("a")
1
>>> l.count("b")
2
```

Counting the occurrences of <em>all</em> items in a list is also known as "tallying" a list, or creating a tally counter.  

<strong>Counting all items with count()</strong>  

To count the occurrences of items in `l` one can simply use a list comprehension and the `count()` method  

```python
[[x,l.count(x)] for x in set(l)]
```

(or similarly with a dictionary `dict((x,l.count(x)) for x in set(l))`)  

Example:   

```python
>>> l = ["a","b","b"]
>>> [[x,l.count(x)] for x in set(l)]
[['a', 1], ['b', 2]]
>>> dict((x,l.count(x)) for x in set(l))
{'a': 1, 'b': 2}
```

<strong>Counting all items with Counter()</strong>  

Alternatively, there's the faster `Counter` class from the `collections` library  

```python
Counter(l)
```

Example:  

```python
>>> l = ["a","b","b"]
>>> from collections import Counter
>>> Counter(l)
Counter({'b': 2, 'a': 1})
```

<strong>How much faster is Counter?</strong>  

I checked how much faster `Counter` is for tallying lists. I tried both methods out with a few values of `n` and it appears that `Counter` is faster by a constant factor of approximately 2.  

Here is the script I used:  

```python
from __future__ import print_function
import timeit

t1=timeit.Timer('Counter(l)', \
                'import random;import string;from collections import Counter;n=1000;l=[random.choice(string.ascii_letters) for x in range(n)]'
                )

t2=timeit.Timer('[[x,l.count(x)] for x in set(l)]',
                'import random;import string;n=1000;l=[random.choice(string.ascii_letters) for x in range(n)]'
                )

print("Counter(): ", t1.repeat(repeat=3,number=10000))
print("count():   ", t2.repeat(repeat=3,number=10000)
```

And the output:  

```python
Counter():  [0.46062711701961234, 0.4022796869976446, 0.3974247490405105]
count():    [7.779430688009597, 7.962715800967999, 8.420845870045014]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: How do you read from stdin? (score [1462727](https://stackoverflow.com/q/1450393) in 2018)

#### Question
I'm trying to do some of the <a href="http://en.wikipedia.org/wiki/Code_golf" rel="noreferrer">code golf</a> challenges, but they all require the input to be taken from `stdin`. How do I get that in Python?  

#### Answer 2 (score 899)
You could use the <a href="http://docs.python.org/library/fileinput.html" rel="noreferrer">`fileinput`</a> module:  

```python
import fileinput

for line in fileinput.input():
    pass
```

<a href="http://docs.python.org/library/fileinput.html" rel="noreferrer">`fileinput`</a> will loop through all the lines in the input specified as file names given in command-line arguments, or the standard input if no arguments are provided.  

Note: `line` will contain a trailing newline; to remove it use `line.rstrip()`  

#### Answer 3 (score 681)
There's a few ways to do it.  

<ul>
<li><p><a href="http://docs.python.org/library/sys.html#sys.stdin" rel="noreferrer">`sys.stdin`</a> is a file-like object on which you can call functions `read` or `readlines` if you want to read everything or you want to read everything and split it by newline automatically. (You need to `import sys` for this to work.)</p></li>
<li><p>If you want to <em>prompt</em> the user for input, you can use <a href="https://docs.python.org/2.7/library/functions.html?highlight=raw_input#raw_input" rel="noreferrer">`raw_input`</a> in Python 2.X, and just <a href="https://docs.python.org/3/library/functions.html#input" rel="noreferrer">`input`</a> in Python 3.  </p></li>
<li><p>If you actually just want to read command-line options, you can access them via the <a href="http://docs.python.org/library/sys.html#sys.argv" rel="noreferrer">sys.argv</a> list.</p></li>
</ul>

You will probably find <a href="http://en.wikibooks.org/wiki/Python_Programming/Input_and_output" rel="noreferrer">this Wikibook article on I/O in Python</a> to be a useful reference as well.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: How do I get the row count of a pandas DataFrame? (score [1456763](https://stackoverflow.com/q/15943769) in 2019)

#### Question
I'm trying to get the number of rows of dataframe df with Pandas, and here is my code.  

<h5>Method 1:</h3>

```python
total_rows = df.count
print total_rows +1
```

<h5>Method 2:</h3>

```python
total_rows = df['First_columnn_label'].count
print total_rows +1
```

Both the code snippets give me this error:  

<blockquote>
  TypeError: unsupported operand type(s) for +: 'instancemethod' and 'int'  
</blockquote>

What am I doing wrong?  

#### Answer accepted (score 1024)
You can use the `.shape` property or just `len(DataFrame.index)`. However, there are notable performance differences ( `len(DataFrame.index)` is fastest):  

```python
In [1]: import numpy as np

In [2]: import pandas as pd

In [3]: df = pd.DataFrame(np.arange(12).reshape(4,3))

In [4]: df
Out[4]: 
   0  1  2
0  0  1  2
1  3  4  5
2  6  7  8
3  9  10 11

In [5]: df.shape
Out[5]: (4, 3)

In [6]: timeit df.shape
2.77 µs ± 644 ns per loop (mean ± std. dev. of 7 runs, 100000 loops each)

In [7]: timeit df[0].count()
348 µs ± 1.31 µs per loop (mean ± std. dev. of 7 runs, 1000 loops each)

In [8]: len(df.index)
Out[8]: 4

In [9]: timeit len(df.index)
990 ns ± 4.97 ns per loop (mean ± std. dev. of 7 runs, 100000 loops each)
```

<h5><a href="https://i.stack.imgur.com/xoTgt.png" rel="noreferrer"><img src="https://i.stack.imgur.com/xoTgt.png" alt="enter image description here"></a></h2>

EDIT: As @Dan Allen noted in the comments `len(df.index)` and `df[0].count()` are not interchangeable as `count` excludes `NaN`s,  

#### Answer 2 (score 237)
Suppose `df` is your dataframe then:  

```python
count_row = df.shape[0]  # gives number of row count
count_col = df.shape[1]  # gives number of col count
```

Or, more succinctly,   

```python
r, c = df.shape
```

#### Answer 3 (score 120)
Use `len(df)`. This works as of pandas 0.11 or maybe even earlier.  

`__len__()` is currently (0.12) documented with `Returns length of index`. Timing info, set up the same way as in root's answer:  

```python
In [7]: timeit len(df.index)
1000000 loops, best of 3: 248 ns per loop

In [8]: timeit len(df)
1000000 loops, best of 3: 573 ns per loop
```

Due to one additional function call it is a bit slower than calling `len(df.index)` directly, but this should not play any role in most use cases.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Way to create multiline comments in Python? (score [1449100](https://stackoverflow.com/q/7696924) in 2019)

#### Question
I have recently started studying <a href="http://en.wikipedia.org/wiki/Python_%28programming_language%29" rel="noreferrer">Python</a>, but I couldn't find how to implement multi-line comments. Most languages have block comment symbols like   

```python
/* 

*/
```

I tried this in Python, but it throws an error, so this probably is not the correct way. Does Python actually have a multiline comment feature?  

#### Answer accepted (score 1672)
You can use triple-quoted strings. When they're not a docstring (first thing in a class/function/module), they are ignored.   

```python
'''
This is a multiline
comment.
'''
```

(Make sure to indent the leading `'''` appropriately to avoid an `IndentationError`.)  

Guido van Rossum (creator of Python) <a href="https://twitter.com/gvanrossum/status/112670605505077248" rel="noreferrer">tweeted this</a> as a "pro tip".  

However, Python's style guide, PEP8, <a href="http://www.python.org/dev/peps/pep-0008/#block-comments" rel="noreferrer">favors using consecutive single-line comments</a>, and this is also what you'll find in many projects. Editors usually have a shortcut to do this easily.  

#### Answer 2 (score 77)
Python does have a <a href="https://stackoverflow.com/a/7696966/190597">multiline string/comment syntax</a> in the sense that unless used as docstrings, <a href="https://twitter.com/gvanrossum/status/112670605505077248" rel="noreferrer">multiline strings <em>generate no bytecode</em></a> -- just like `#`-prepended comments. In effect, it acts exactly like a comment.   

<p>On the other hand, if you say this behavior must be documented in the official
docs to be a true comment syntax, then yes, you would be right to say it is not
guaranteed as part of the language specification.</p>

<p>In any case your editor should also be able to easily comment-out a selected
region (by placing a `#` in front of each line individually). If not, switch to
an editor that does.</p>

<p>Programming in Python without certain text editing features can be a painful
experience. Finding the right editor (and knowing how to use it) can make a big
difference in how the Python programming experience is perceived.</p>

<p>Not only should the editor be able to comment-out selected regions, it should
also be able to shift blocks of code to the left and right easily, and should
automatically place the cursor at the current indentation level when you press
Enter. Code folding can also be useful.</p>

<hr>

To protect against link decay, here is the content of <a href="https://twitter.com/gvanrossum/status/112670605505077248" rel="noreferrer">Guido van Rossum's tweet</a>:  

<blockquote>
  <a href="https://twitter.com/BSUCSClub" rel="noreferrer">@BSUCSClub</a> Python tip: You can use multi-line strings as multi-line comments. Unless used as docstrings, they generate no code! :-)  
</blockquote>

#### Answer 3 (score 41)
From the accepted answer...  

<blockquote>
  You can use triple-quoted strings. When they're not a docstring (first thing in a class/function/module), they are ignored.  
</blockquote>

This is simply not true. Unlike comments, triple-quoted strings are still parsed and must be syntactically valid, regardless of where they appear in the source code.  

If you try to run this code...  

```python
def parse_token(token):
    """
    This function parses a token.
    TODO: write a decent docstring :-)
    """

    if token == '\\and':
        do_something()

    elif token == '\\or':
        do_something_else()

    elif token == '\\xor':
        '''
        Note that we still need to provide support for the deprecated
        token \xor. Hopefully we can drop support in libfoo 2.0.
        '''
        do_a_different_thing()

    else:
        raise ValueError
```

You'll get either...  

```python
ValueError: invalid \x escape
```

...on Python 2.x or...  

```python
SyntaxError: (unicode error) 'unicodeescape' codec can't decode bytes in position 79-80: truncated \xXX escape
```

...on Python 3.x.  

The only way to do multi-line comments which are ignored by the parser is...  

```python
elif token == '\\xor':
    # Note that we still need to provide support for the deprecated
    # token \xor. Hopefully we can drop support in libfoo 2.0.
    do_a_different_thing()
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: How to clone or copy a list? (score [1446611](https://stackoverflow.com/q/2612802) in 2019)

#### Question
What are the options to clone or copy a list in Python?  

<p>While using `new_list = my_list`, any modifications to `new_list` changes `my_list` everytime.
Why is this?</p>

#### Answer accepted (score 2973)
With `new_list = my_list`, you don't actually have two lists. The assignment just copies the reference to the list, not the actual list, so both `new_list` and `my_list` refer to the same list after the assignment.  

To actually copy the list, you have various possibilities:  

<ul>
<li><p>You can use the builtin <a href="https://docs.python.org/3/library/stdtypes.html#mutable-sequence-types" rel="noreferrer">`list.copy()`</a> method (available since Python 3.3):</p>

```python
new_list = old_list.copy()
```</li>
<li><p>You can slice it: </p>

```python
new_list = old_list[:]
```

<a href="https://en.wikipedia.org/wiki/Alex_Martelli" rel="noreferrer" title="Alex Martelli">Alex Martelli's</a> opinion (at least <a href="https://www.youtube.com/watch?v=g7V89K8QfgQ" rel="noreferrer" title="Bay Area Python Interest Group August 2007 Meeting">back in 2007</a>) about this is, that <em>it is a weird syntax and it does not make sense to use it ever</em>. ;) (In his opinion, the next one is more readable).  </li>
<li><p>You can use the built in <a href="https://docs.python.org/2/library/functions.html#list" rel="noreferrer" title="list">`list()`</a> function:</p>

```python
new_list = list(old_list)
```</li>
<li><p>You can use generic <a href="https://docs.python.org/2/library/copy.html#copy.copy" rel="noreferrer" title="copy.copy">`copy.copy()`</a>:</p>

```python
import copy
new_list = copy.copy(old_list)
```

This is a little slower than `list()` because it has to find out the datatype of `old_list` first.  </li>
<li><p>If the list contains objects and you want to copy them as well, use generic <a href="https://docs.python.org/2/library/copy.html#copy.deepcopy" rel="noreferrer" title="copy.deepcopy">`copy.deepcopy()`</a>:</p>

```python
import copy
new_list = copy.deepcopy(old_list)
```

Obviously the slowest and most memory-needing method, but sometimes unavoidable.  </li>
</ul>

<strong>Example:</strong>  

```python
import copy

class Foo(object):
    def __init__(self, val):
         self.val = val

    def __repr__(self):
        return str(self.val)

foo = Foo(1)

a = ['foo', foo]
b = a.copy()
c = a[:]
d = list(a)
e = copy.copy(a)
f = copy.deepcopy(a)

# edit orignal list and instance 
a.append('baz')
foo.val = 5

print('original: %r\n list.copy(): %r\n slice: %r\n list(): %r\n copy: %r\n deepcopy: %r'
      % (a, b, c, d, e, f))
```

Result:  

```python
original: ['foo', 5, 'baz']
list.copy(): ['foo', 5]
slice: ['foo', 5]
list(): ['foo', 5]
copy: ['foo', 5]
deepcopy: ['foo', 1]
```

#### Answer 2 (score 551)
Felix already provided an excellent answer, but I thought I'd do a speed comparison of the various methods:  

<ol>
<li>10.59 sec (105.9us/itn) -  <a href="http://docs.python.org/library/copy.html#copy.deepcopy" rel="noreferrer">`copy.deepcopy(old_list)`</a></li>
<li>10.16 sec (101.6us/itn) - pure python `Copy()` method copying classes with deepcopy</li>
<li>1.488 sec (14.88us/itn) - pure python `Copy()` method not copying classes (only dicts/lists/tuples)</li>
<li>0.325 sec (3.25us/itn) - `for item in old_list: new_list.append(item)`</li>
<li>0.217 sec (2.17us/itn) - `[i for i in old_list]` (a <a href="http://docs.python.org/tutorial/datastructures.html#list-comprehensions" rel="noreferrer">list comprehension</a>)</li>
<li>0.186 sec (1.86us/itn) - <a href="http://docs.python.org/library/copy.html#copy.copy" rel="noreferrer">`copy.copy(old_list)`</a></li>
<li>0.075 sec (0.75us/itn) - `list(old_list)`</li>
<li>0.053 sec (0.53us/itn) - `new_list = []; new_list.extend(old_list)`</li>
<li>0.039 sec (0.39us/itn) - `old_list[:]` (<a href="http://docs.python.org/tutorial/introduction.html#lists" rel="noreferrer">list slicing</a>)</li>
</ol>

So the fastest is list slicing. But be aware that `copy.copy()`, `list[:]` and `list(list)`, unlike `copy.deepcopy()` and the python version don't copy any lists, dictionaries and class instances in the list, so if the originals change, they will change in the copied list too and vice versa.  

(Here's the script if anyone's interested or wants to raise any issues:)  

```python
from copy import deepcopy

class old_class:
    def __init__(self):
        self.blah = 'blah'

class new_class(object):
    def __init__(self):
        self.blah = 'blah'

dignore = {str: None, unicode: None, int: None, type(None): None}

def Copy(obj, use_deepcopy=True):
    t = type(obj)

    if t in (list, tuple):
        if t == tuple:
            # Convert to a list if a tuple to 
            # allow assigning to when copying
            is_tuple = True
            obj = list(obj)
        else: 
            # Otherwise just do a quick slice copy
            obj = obj[:]
            is_tuple = False

        # Copy each item recursively
        for x in xrange(len(obj)):
            if type(obj[x]) in dignore:
                continue
            obj[x] = Copy(obj[x], use_deepcopy)

        if is_tuple: 
            # Convert back into a tuple again
            obj = tuple(obj)

    elif t == dict: 
        # Use the fast shallow dict copy() method and copy any 
        # values which aren't immutable (like lists, dicts etc)
        obj = obj.copy()
        for k in obj:
            if type(obj[k]) in dignore:
                continue
            obj[k] = Copy(obj[k], use_deepcopy)

    elif t in dignore: 
        # Numeric or string/unicode? 
        # It's immutable, so ignore it!
        pass 

    elif use_deepcopy: 
        obj = deepcopy(obj)
    return obj

if __name__ == '__main__':
    import copy
    from time import time

    num_times = 100000
    L = [None, 'blah', 1, 543.4532, 
         ['foo'], ('bar',), {'blah': 'blah'},
         old_class(), new_class()]

    t = time()
    for i in xrange(num_times):
        Copy(L)
    print 'Custom Copy:', time()-t

    t = time()
    for i in xrange(num_times):
        Copy(L, use_deepcopy=False)
    print 'Custom Copy Only Copying Lists/Tuples/Dicts (no classes):', time()-t

    t = time()
    for i in xrange(num_times):
        copy.copy(L)
    print 'copy.copy:', time()-t

    t = time()
    for i in xrange(num_times):
        copy.deepcopy(L)
    print 'copy.deepcopy:', time()-t

    t = time()
    for i in xrange(num_times):
        L[:]
    print 'list slicing [:]:', time()-t

    t = time()
    for i in xrange(num_times):
        list(L)
    print 'list(L):', time()-t

    t = time()
    for i in xrange(num_times):
        [i for i in L]
    print 'list expression(L):', time()-t

    t = time()
    for i in xrange(num_times):
        a = []
        a.extend(L)
    print 'list extend:', time()-t

    t = time()
    for i in xrange(num_times):
        a = []
        for y in L:
            a.append(y)
    print 'list append:', time()-t

    t = time()
    for i in xrange(num_times):
        a = []
        a.extend(i for i in L)
    print 'generator expression extend:', time()-t
```

#### Answer 3 (score 138)
I've <a href="http://mail.python.org/pipermail/python-ideas/2013-July/022368.html" rel="noreferrer">been told</a> that Python 3.3+ <a href="http://bugs.python.org/issue10516" rel="noreferrer">adds `list.copy()`</a> method, which should be as fast as slicing:  

`newlist = old_list.copy()`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: Python add new item to dictionary (score [1441083](https://stackoverflow.com/q/6416131) in 2016)

#### Question
I want to add an item to an existing dictionary in python. For example, this is my dictionary:  

```python
default_data = {
            'item1': 1,
            'item2': 2,
}
```

I want to add new item such that:  

```python
default_data = default_data + {'item3':3}
```

How to achieve this?  

#### Answer accepted (score 1130)
```python
default_data['item3'] = 3
```

Easy as py.  

Another possible solution:  

```python
default_data.update({'item3': 3})
```

which is nice if you want to insert multiple items at once.  

#### Answer 2 (score 68)
It can be as simple as:  

```python
default_data['item3'] = 3
```

As <a href="https://stackoverflow.com/questions/6416131/python-add-new-item-to-dictionary/6416142#6416142">Chris' answer</a> says, you can use <a href="http://docs.python.org/library/stdtypes.html#dict.update" rel="noreferrer">update</a> to add more than one item.  An example:  

```python
default_data.update({'item4': 4, 'item5': 5})
```

Please see the docs about <a href="http://docs.python.org/tutorial/datastructures.html#dictionaries" rel="noreferrer">dictionaries as data structures</a> and <a href="http://docs.python.org/library/stdtypes.html#mapping-types-dict" rel="noreferrer">dictionaries as built-in types</a>.  

#### Answer 3 (score 23)
It occurred to me that you may have actually be asking how to implement the `+` operator for dictionaries, the following seems to work:  

```python
>>> class Dict(dict):
...     def __add__(self, other):
...         copy = self.copy()
...         copy.update(other)
...         return copy
...     def __radd__(self, other):
...         copy = other.copy()
...         copy.update(self)
...         return copy
... 
>>> default_data = Dict({'item1': 1, 'item2': 2})
>>> default_data + {'item3': 3}
{'item2': 2, 'item3': 3, 'item1': 1}
>>> {'test1': 1} + Dict(test2=2)
{'test1': 1, 'test2': 2}
```

Note that this is more overhead then using `dict[key] = value` or `dict.update()`, so I would recommend against using this solution unless you intend to create a new dictionary anyway.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: Delete column from pandas DataFrame (score [1437865](https://stackoverflow.com/q/13411544) in 2019)

#### Question
When deleting a column in a DataFrame I use:  

```python
del df['column_name']
```

And this works great. Why can't I use the following?  

```python
del df.column_name
```

<em>As you can access the column/Series as `df.column_name`, I expect this to work.</em>  

#### Answer accepted (score 670)
As you've guessed, the right syntax is   

```python
del df['column_name']
```

It's difficult to make `del df.column_name` work simply as the result of syntactic limitations in Python. `del df[name]` gets translated to `df.__delitem__(name)` under the covers by Python.  

#### Answer 2 (score 1873)
The best way to do this in pandas is to use <a href="http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.drop.html" rel="noreferrer">`drop`</a>:  

```python
df = df.drop('column_name', 1)
```

where `1` is the <em>axis</em> number (`0` for rows and `1` for columns.)  

To delete the column without having to reassign `df` you can do:  

```python
df.drop('column_name', axis=1, inplace=True)
```

Finally, to drop by column <em>number</em> instead of by column <em>label</em>, try this to delete, e.g. the 1st, 2nd and 4th columns:  

```python
df = df.drop(df.columns[[0, 1, 3]], axis=1)  # df.columns is zero-based pd.Index 
```

#### Answer 3 (score 216)
Use:  

```python
columns = ['Col1', 'Col2', ...]
df.drop(columns, inplace=True, axis=1)
```

This will delete one or more columns in-place. Note that `inplace=True` was added in pandas v0.13 and won't work on older versions. You'd have to assign the result back in that case:  

```python
df = df.drop(columns, axis=1)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: How to check if the string is empty? (score [1432962](https://stackoverflow.com/q/9573244) in 2019)

#### Question
Does Python have something like an empty string variable where you can do:  

```python
if myString == string.empty:
```

Regardless, what's the most elegant way to check for empty string values? I find hard coding `""` every time for checking an empty string not as good.  

#### Answer accepted (score 1844)
Empty strings are <a href="http://docs.python.org/2/library/stdtypes.html#truth-value-testing" rel="noreferrer">"falsy"</a> which means they are considered false in a Boolean context, so you can just do this:  

```python
if not myString:
```

This is the preferred way if you know that your variable is a string.  If your variable could also be some other type then you should use `myString == ""`.  See the documentation on <a href="http://docs.python.org/library/stdtypes.html#truth-value-testing" rel="noreferrer">Truth Value Testing</a> for other values that are false in Boolean contexts.  

#### Answer 2 (score 374)
From <a href="http://www.python.org/dev/peps/pep-0008/">PEP 8</a>, in the <a href="https://www.python.org/dev/peps/pep-0008/#programming-recommendations">“Programming Recommendations” section</a>:  

<blockquote>
  For sequences, (strings, lists, tuples), use the fact that empty sequences are false.  
</blockquote>

So you should use:  

```python
if not some_string:
```

or:  

```python
if some_string:
```

Just to clarify, sequences are <strong>evaluated</strong> to `False` or `True` in a Boolean context if they are empty or not. They are <strong>not equal</strong> to `False` or `True`.  

#### Answer 3 (score 211)
The most elegant way would probably be to simply check if its true or falsy, e.g.:  

```python
if not my_string:
```

However, you may want to strip white space because:  

```python
 >>> bool("")
 False
 >>> bool("   ")
 True
 >>> bool("   ".strip())
 False
```

You should probably be a bit more explicit in this however, unless you know for sure that this string has passed some kind of validation and is a string that can be tested this way.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: Difference between del, remove and pop on lists (score [1429816](https://stackoverflow.com/q/11520492) in 2012)

#### Question
```python
>>> a=[1,2,3]
>>> a.remove(2)
>>> a
[1, 3]
>>> a=[1,2,3]
>>> del a[1]
>>> a
[1, 3]
>>> a= [1,2,3]
>>> a.pop(1)
2
>>> a
[1, 3]
>>> 
```

Is there any difference between the above three methods to remove an element from a list?  

#### Answer accepted (score 1119)
Yes, `remove` removes the <em>first</em> matching <em>value</em>, not a specific index:  

```python
>>> a = [0, 2, 3, 2]
>>> a.remove(2)
>>> a
[0, 3, 2]
```

`del` removes the item at a specific index:  

```python
>>> a = [3, 2, 2, 1]
>>> del a[1]
>>> a
[3, 2, 1]
```

and `pop` removes the item at a specific index and returns it.  

```python
>>> a = [4, 3, 5]
>>> a.pop(1)
3
>>> a
[4, 5]
```

Their error modes are different too:  

```python
>>> a = [4, 5, 6]
>>> a.remove(7)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: list.remove(x): x not in list
>>> del a[7]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
IndexError: list assignment index out of range
>>> a.pop(7)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
IndexError: pop index out of range
```

#### Answer 2 (score 145)
Use `del` to remove an element by index, `pop()` to remove it by index if you need the returned value, and `remove()` to delete an element by value.  The latter requires searching the list, and raises `ValueError` if no such value occurs in the list.  

When deleting index `i` from a list of `n` elements, the computational complexities of these methods are  

```python
del     O(n - i)
pop     O(n - i)
remove  O(n)
```

#### Answer 3 (score 78)
Since no-one else has mentioned it, note that `del` (unlike `pop`) allows the removal of a range of indexes because of list slicing:  

```python
>>> lst = [3, 2, 2, 1]
>>> del lst[1:]
>>> lst
[3]
```

This also allows avoidance of an `IndexError` if the index is not in the list:  

```python
>>> lst = [3, 2, 2, 1]
>>> del lst[10:]
>>> lst
[3, 2, 2, 1]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: Delete an element from a dictionary (score [1418712](https://stackoverflow.com/q/5844672) in 2019)

#### Question
Is there a way to delete an item from a dictionary in Python?  

Additionally, how can I delete an item from a dictionary to return a copy (i.e., not modifying the original)?  

#### Answer accepted (score 1551)
The <a href="http://docs.python.org/reference/simple_stmts.html#the-del-statement" rel="noreferrer">`del` statement</a> removes an element:  

```python
del d[key]
```

However, this mutates the existing dictionary so the contents of the dictionary changes for anybody else who has a reference to the same instance. To return a <em>new</em> dictionary, make a copy of the dictionary:  

```python
def removekey(d, key):
    r = dict(d)
    del r[key]
    return r
```

The `dict()` constructor makes a <em>shallow copy</em>. To make a deep copy, see the <a href="https://docs.python.org/library/copy.html" rel="noreferrer">`copy` module</a>.  

<hr>

Note that making a copy for every dict `del`/assignment/etc. means you're going from constant time to linear time, and also using linear space. For small dicts, this is not a problem. But if you're planning to make lots of copies of large dicts, you probably want a different data structure, like a HAMT (as described in <a href="https://stackoverflow.com/a/50341031/908494">this answer</a>).  

#### Answer 2 (score 212)
<a href="https://docs.python.org/library/stdtypes.html#dict.pop" rel="noreferrer">`pop`</a> mutates the dictionary.  

```python
 >>>lol = {"hello":"gdbye"}
 >>>lol.pop("hello")
    'gdbye'
 >>> lol
     {}
```

If you want to keep the original you could just copy it.  

#### Answer 3 (score 70)
I think your solution is best way to do it. But if you want another solution, you can create a new dictionary with using the keys from old dictionary without including your specified key, like this:  

```python
>>> a
{0: 'zero', 1: 'one', 2: 'two', 3: 'three'}
>>> {i:a[i] for i in a if i!=0}
{1: 'one', 2: 'two', 3: 'three'}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: null object in Python? (score [1404774](https://stackoverflow.com/q/3289601) in 2013)

#### Question
How do I refer to the null object in Python?  

#### Answer accepted (score 1458)
In Python, the 'null' object is the singleton `None`.  

The best way to check things for "Noneness" is to use the identity operator, `is`:  

```python
if foo is None:
    ...
```

#### Answer 2 (score 100)
<h5>`None`, Python's null?</h1>

There's no `null` in Python, instead there's `None`. As stated already the most accurate way to test that something has been given `None` as a value is to use the `is` identity operator, which tests that two variables refer to the same object.  

```python
>>> foo is None
True
>>> foo = 'bar' 
>>> foo is None
False
```

<h5>The basics</h1>

<h5>There is and can only be one `None`</h2>

`None` is the sole instance of the class `NoneType` and any further attempts at instantiating that class will return the same object, which makes `None` a singleton. Newcomers to Python often see error messages that mention `NoneType` and wonder what it is. It's my personal opinion that these messages could simply just mention `None` by name because, as we'll see shortly, `None` leaves little room to ambiguity. So if you see some `TypeError` message that mentions that `NoneType` can't do this or can't do that, just know that it's simply the one `None` that was being used in a way that it can't.  

Also, `None` is a built-in constant, as soon as you start Python it's available to use from everywhere, whether in module, class, or function. `NoneType` by contrast is not, you'd need to get a reference to it first by querying `None` for its class.  

```python
>>> NoneType
NameError: name 'NoneType' is not defined
>>> type(None)
NoneType
```

You can check `None`'s uniqueness with Python's identity function `id()`. It returns the unique number assigned to an object, each object has one. If the id of two variables is the same, then they point in fact to the same object.  

```python
>>> NoneType = type(None)
>>> id(None)
10748000
>>> my_none = NoneType()
>>> id(my_none)
10748000
>>> another_none = NoneType()
>>> id(another_none)
10748000
>>> def function_that_does_nothing(): pass
>>> return_value = function_that_does_nothing()
>>> id(return_value)
10748000
```

<h5>`None` cannot be overwritten</h2>

In much older version of Python (before 2.4) it was possible to reassign `None`, but not anymore. Not even as a class attribute or in the confines of a function.  

```python
# In Python 2.7
>>> class SomeClass(object):
...     def my_fnc(self):
...             self.None = 'foo'
SyntaxError: cannot assign to None
>>> def my_fnc():
        None = 'foo'
SyntaxError: cannot assign to None

# In Python 3.5
>>> class SomeClass:
...     def my_fnc(self):
...             self.None = 'foo'
SyntaxError: invalid syntax
>>> def my_fnc():
        None = 'foo'
SyntaxError: cannot assign to keyword
```

It's therefore safe to assume that all `None` references are the same. There's no "custom" `None`.  

<h5>To test for `None` use the `is` operator</h2>

When writing code you might be tempted to test for <em>Noneness</em> like this:  

```python
if value==None:
    pass
```

Or to test for falsehood like this  

```python
if not value:
    pass
```

You need to understand the implications and why it's often a good idea to be explicit.  

<h5>Case 1: testing if a value is `None`</h3>

why do this  

```python
value is None
```

rather than   

```python
value==None
```

The first is equivalent to:  

```python
id(value)==id(None)
```

Whereas the expression `value==None` is in fact applied like this  

```python
value.__eq__(None)
```

if the value really is `None` then you'll get what you expected.  

```python
>>> nothing = function_that_does_nothing()
>>> nothing.__eq__(None)
True
```

In most common cases the outcome will be the same, but the `__eq__()` method opens a door that voids any guarantee of accuracy, since it can be overridden in a class to provide special behavior.  

Consider this class.  

```python
>>> class Empty(object):
...     def __eq__(self, other):
...         return not other
```

So you try it on `None` and it works  

```python
>>> empty = Empty()
>>> empty==None
True
```

But then it also works on the empty string  

```python
>>> empty==''
True
```

And yet  

```python
>>> ''==None
False
>>> empty is None
False
```

<h5>Case 2: Using `None` as a boolean</h3>

The following two tests  

```python
if value:
    # do something

if not value:
    # do something
```

are in fact evaluated as  

```python
if bool(value):
    # do something

if not bool(value):
    # do something
```

`None` is a "falsey", meaning that if cast to a boolean it will return `False` and if applied the `not` operator it will return `True`. Note however that it's not a property unique to `None`. In addition to `False` itself, the property is shared by empty lists, tuples, sets, dicts, strings, as well as 0, and all objects from classes that implement the `__bool__()` magic method to return `False`.  

```python
>>> bool(None)
False
>>> not None
True

>>> bool([])
False
>>> not []
True

>>> class MyFalsey(object):
...     def __bool__(self):
...         return False
>>> f = MyFalsey()
>>> bool(f)
False
>>> not f
True
```

So when testing for variables in the following way, be extra aware of what you're including or excluding from the test:  

```python
def some_function(value=None):
    if not value:
        value = init_value()
```

In the above, did you mean to call `init_value()` when the value is set specifically to `None`, or did you mean that a value set to `0`, or the empty string, or an empty list should also trigger the initialization. Like I said, be mindful. As it's often the case in Python <em>explicit is better than implicit</em>.  

<h5>`None` in practice</h1>

<h5>`None` used as a signal value</h2>

`None` has a special status in Python. It's a favorite baseline value because many algorithms treat it as an exceptional value. In such scenarios it can be used as a flag to signal that a condition requires some special handling (such as the setting of a default value).  

You can assign `None` to the keyword arguments of a function and then explicitly test for it.  

```python
def my_function(value, param=None):
    if param is None:
        # do something outrageous!
```

You can return it as the default when trying to get to an object's attribute and then explicitly test for it before doing something special.  

```python
value = getattr(some_obj, 'some_attribute', None)
if value is None:
    # do something spectacular!
```

By default a dictionary's `get()` method returns `None` when trying to access a non-existing key:  

```python
>>> some_dict = {}
>>> value = some_dict.get('foo')
>>> value is None
True
```

If you were to try to access it by using the subscript notation a `KeyError` would be raised  

```python
>>> value = some_dict['foo']
KeyError: 'foo'
```

Likewise if you attempt to pop a non-existing item  

```python
>>> value = some_dict.pop('foo')
KeyError: 'foo'
```

which you can suppress with a default value that is usually set to `None`  

```python
value = some_dict.pop('foo', None)
if value is None:
    # booom!
```

<h5>`None` used as both a flag and valid value</h2>

The above described uses of `None` apply when it is not considered a valid value, but more like a signal to do something special. There are situations however where it sometimes matters to know where `None` came from because even though it's used as a signal it could also be part of the data.  

When you query an object for its attribute with `getattr(some_obj, 'attribute_name', None)` getting back `None` doesn't tell you if the attribute you were trying to access was set to `None` or if it was altogether absent from the object. Same situation when accessing a key from a dictionary like `some_dict.get('some_key')`, you don't know if `some_dict['some_key']` is missing or if it's just set to `None`. If you need that information, the usual way to handle this is to directly attempt accessing the attribute or key from within a `try/except` construct:  

```python
try:
    # equivalent to getattr() without specifying a default
    # value = getattr(some_obj, 'some_attribute')
    value = some_obj.some_attribute
    # now you handle `None` the data here
    if value is None:
        # do something here because the attribute was set to None
except AttributeError:
    # we're now hanling the exceptional situation from here.
    # We could assign None as a default value if required.
    value = None 
    # In addition, since we now know that some_obj doesn't have the
    # attribute 'some_attribute' we could do something about that.
    log_something(some_obj)
```

Similarly with dict:  

```python
try:
    value = some_dict['some_key']
    if value is None:
        # do something here because 'some_key' is set to None
except KeyError:
    # set a default 
    value = None
    # and do something because 'some_key' was missing
    # from the dict.
    log_something(some_dict)
```

The above two examples show how to handle object and dictionary cases, what about functions? Same thing, but we use the double asterisks keyword argument to that end:  

```python
def my_function(**kwargs):
    try:
        value = kwargs['some_key'] 
        if value is None:
            # do something because 'some_key' is explicitly 
            # set to None
    except KeyError:
        # we assign the default
        value = None
        # and since it's not coming from the caller.
        log_something('did not receive "some_key"')
```

<h5>`None` used only as a valid value</h2>

If you find that your code is littered with the above `try/except` pattern simply to differentiate between `None` flags and `None` data, then just use another test value. There's a pattern where a value that falls outside the set of valid values is inserted as part of the data in a data structure and is used to control and test special conditions (e.g. boundaries, state, etc). Such a value is called a <em>sentinel</em> and it can be used the way `None` is used as a signal. It's trivial to create a sentinel in Python.  

```python
undefined = object()
```

The `undefined` object above is unique and doesn't do much of anything that might be of interest to a program, it's thus an excellent replacement for `None` as a flag. Some caveats apply, more about that after the code.  

With function  

```python
def my_function(value, param1=undefined, param2=undefined):
    if param1 is undefined:
        # we know nothing was passed to it, not even None
        log_something('param1 was missing')
        param1 = None


    if param2 is undefined:
        # we got nothing here either
        log_something('param2 was missing')
        param2 = None
```

With dict  

```python
value = some_dict.get('some_key', undefined)
if value is None:
    log_something("'some_key' was set to None")

if value is undefined:
    # we know that the dict didn't have 'some_key'
    log_something("'some_key' was not set at all")
    value = None
```

With an object  

```python
value = getattr(obj, 'some_attribute', undefined) 
if value is None:
    log_something("'obj.some_attribute' was set to None")
if value is undefined:
    # we know that there's no obj.some_attribute
    log_something("no 'some_attribute' set on obj")
    value = None
```

As I mentioned earlier custom sentinels come with some caveats. First, they're not keywords like `None`, so python doesn't protect them. You can overwrite your `undefined` above at any time, anywhere in the module it's defined, so be careful how you expose and use them. Next, the instance returned by `object()` is not a singleton, if you make that call 10 times you get 10 different objects. Finally, usage of a sentinel is highly idiosyncratic. A sentinel is specific to the library it's used in and as such its scope should generally be limited to the library's internals. It shouldn't "leak" out. External code should only become aware of it, if their purpose is to extend or supplement the library's API.  

#### Answer 3 (score 64)
It's not called null as in other languages, but <a href="http://docs.python.org/library/constants.html?highlight=none#None" rel="noreferrer">`None`</a>. There is always only one instance of this object, so you can check for equivalence with `x is None` (identity comparison) instead of `x == None`, if you want.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: How can I do a line break (line continuation) in Python? (score [1403503](https://stackoverflow.com/q/53162) in 2018)

#### Question
I have a long line of code that I want to break up among multiple lines. What do I use and what is the syntax?  

For example, adding a bunch of strings,  

```python
e = 'a' + 'b' + 'c' + 'd'
```

and have it in two lines like this:  

```python
e = 'a' + 'b' +
    'c' + 'd'
```

#### Answer accepted (score 1092)
What is the line?  You can just have arguments on the next line without any problems:  

```python
a = dostuff(blahblah1, blahblah2, blahblah3, blahblah4, blahblah5, 
            blahblah6, blahblah7)
```

Otherwise you can do something like this:  

```python
if a == True and \
   b == False
```

Check the <a href="http://www.python.org/dev/peps/pep-0008/" rel="noreferrer">style guide</a> for more information.  

From your example line:  

```python
a = '1' + '2' + '3' + \
    '4' + '5'
```

Or:  

```python
a = ('1' + '2' + '3' +
    '4' + '5')
```

Note that the style guide says that using the implicit continuation with parentheses is preferred, but in this particular case just adding parentheses around your expression is probably the wrong way to go.  

#### Answer 2 (score 211)
From <em><a href="http://www.python.org/dev/peps/pep-0008/" rel="nofollow noreferrer">PEP 8 -- Style Guide for Python Code</a></em>:  

<blockquote>
  <strong>The preferred way of wrapping long lines is by using Python's implied line continuation inside parentheses, brackets and braces.</strong> Long lines can be broken over multiple lines by wrapping expressions in parentheses. These should be used in preference to using a backslash for line continuation.  
  
  Backslashes may still be appropriate at times. For example, long, multiple with-statements cannot use implicit continuation, so backslashes are acceptable:  

```python
with open('/path/to/some/file/you/want/to/read') as file_1, \
        open('/path/to/some/file/being/written', 'w') as file_2:
    file_2.write(file_1.read())
```
  
  Another such case is with assert statements.  
  
  Make sure to indent the continued line appropriately. The preferred place to break around a binary operator is <strong>after</strong> the operator, not before it. Some examples:  

```python
class Rectangle(Blob):

    def __init__(self, width, height,
                 color='black', emphasis=None, highlight=0):
        if (width == 0 and height == 0 and
                color == 'red' and emphasis == 'strong' or
                highlight > 100):
            raise ValueError("sorry, you lose")
        if width == 0 and height == 0 and (color == 'red' or
                                           emphasis is None):
            raise ValueError("I don't think so -- values are %s, %s" %
                             (width, height))
        Blob.__init__(self, width, height,
                      color, emphasis, highlight)
```
</blockquote>

PEP8 now recommends the <em>opposite convention</em> (for breaking at binary operations) used by mathematicians and their publishers to improve readability.  

Donald Knuth's style of breaking <strong>before</strong> a binary operator aligns operators vertically, thus reducing the eye's workload when determining which items are added and subtracted.  

From <a href="http://legacy.python.org/dev/peps/pep-0008/#should-a-line-break-before-or-after-a-binary-operator" rel="nofollow noreferrer">PEP8: <em>Should a line break before or after a binary operator?</em></a>:  

<blockquote>
  Donald Knuth explains the traditional rule in his Computers and Typesetting series: "Although formulas within a paragraph always break after binary operations and relations, displayed formulas always break before binary operations"[3].  
  
  Following the tradition from mathematics usually results in more readable code:  

```python
# Yes: easy to match operators with operands
income = (gross_wages
          + taxable_interest
          + (dividends - qualified_dividends)
          - ira_deduction
          - student_loan_interest)
```
  
  In Python code, it is permissible to break before or after a binary operator, as long as the convention is consistent locally. For new code Knuth's style is suggested.  
</blockquote>

[3]: Donald Knuth's The TeXBook, pages 195 and 196  

#### Answer 3 (score 67)
The danger in using a backslash to end a line is that if whitespace is added after the backslash (which, of course, is very hard to see), the backslash is no longer doing what you thought it was.  

See Python Idioms and Anti-Idioms (for <a href="https://docs.python.org/2/howto/doanddont.html#using-backslash-to-continue-statements" rel="noreferrer">Python 2</a> or <a href="https://docs.python.org/3.1/howto/doanddont.html#using-backslash-to-continue-statements" rel="noreferrer">Python 3</a>) for more.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Save plot to image file instead of displaying it using Matplotlib (score [1400228](https://stackoverflow.com/q/9622163) in 2018)

#### Question
I am writing a quick-and-dirty script to generate plots on the fly. I am using the code below (from <a href="http://en.wikipedia.org/wiki/Matplotlib" rel="noreferrer">Matplotlib</a> documentation) as a starting point:  

```python
from pylab import figure, axes, pie, title, show

# Make a square figure and axes
figure(1, figsize=(6, 6))
ax = axes([0.1, 0.1, 0.8, 0.8])

labels = 'Frogs', 'Hogs', 'Dogs', 'Logs'
fracs = [15, 30, 45, 10]

explode = (0, 0.05, 0, 0)
pie(fracs, explode=explode, labels=labels, autopct='%1.1f%%', shadow=True)
title('Raining Hogs and Dogs', bbox={'facecolor': '0.8', 'pad': 5})

show()  # Actually, don't show, just save to foo.png
```

I don't want to display the plot on a GUI, instead, I want to save the plot to a file (say foo.png), so that, for example, it can be used in batch scripts. How do I do that?  

#### Answer accepted (score 1267)
While the question has been answered, I'd like to add some useful tips when using <a href="https://matplotlib.org/api/_as_gen/matplotlib.pyplot.savefig.html#matplotlib.pyplot.savefig" rel="noreferrer">matplotlib.pyplot.savefig</a>. The file format can be specified by the extension:  

```python
from matplotlib import pyplot as plt

plt.savefig('foo.png')
plt.savefig('foo.pdf')
```

Will give a rasterized or vectorized output respectively, both which could be useful. In addition, you'll find that `pylab` leaves a generous, often undesirable, whitespace around the image. Remove it with:  

```python
savefig('foo.png', bbox_inches='tight')
```

#### Answer 2 (score 178)
As others have said, `plt.savefig()` or `fig1.savefig()` is indeed the way to save an image.  

However I've found that in certain cases <strong>the figure is always shown</strong>. (eg. with Spyder having `plt.ion()`: interactive mode = On.)  I work around this by forcing the closing of the figure window in my giant loop with `plt.close(figure_object)` (see <a href="https://matplotlib.org/3.1.1/api/_as_gen/matplotlib.pyplot.close.html" rel="nofollow noreferrer">documentation</a>), so I don't have a million open figures during the loop:  

```python
import matplotlib.pyplot as plt
fig, ax = plt.subplots( nrows=1, ncols=1 )  # create figure & 1 axis
ax.plot([0,1,2], [10,20,3])
fig.savefig('path/to/save/image/to.png')   # save the figure to file
plt.close(fig)    # close the figure window
```

You should be able to re-open the figure later if needed to with `fig.show()` (didn't test myself).  

#### Answer 3 (score 156)
The solution is:   

```python
pylab.savefig('foo.png')
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: How do I check what version of Python is running my script? (score [1394392](https://stackoverflow.com/q/1093322) in 2011)

#### Question
How can I check what version of the Python Interpreter is interpreting my script?  

#### Answer accepted (score 1281)
This information is available in the <a href="http://docs.python.org/2/library/sys.html#sys.version" rel="noreferrer">sys.version</a> string in the <a href="http://docs.python.org/2/library/sys.html" rel="noreferrer">sys</a> module:  

```python
>>> import sys
```

Human readable:  

```python
>>> print(sys.version)  # parentheses necessary in python 3.       
2.5.2 (r252:60911, Jul 31 2008, 17:28:52) 
[GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]
```

For further processing:  

```python
>>> sys.version_info
(2, 5, 2, 'final', 0)
# or
>>> sys.hexversion
34014192
```

To ensure a script runs with a minimal version requirement of the Python interpreter add this to your code:  

```python
assert sys.version_info >= (2, 5)
```

This compares major and minor version information. Add micro (=`0`, `1`, etc) and even releaselevel (=`'alpha'`,`'final'`, etc) to the tuple as you like. Note however, that it is almost always better to "duck" check if a certain feature is there, and if not, workaround (or bail out). Sometimes features go away in newer releases, being replaced by others.  

#### Answer 2 (score 344)
From the command line (note the capital 'V'):  

```python
python -V
```

This is documented in 'man python'.  

#### Answer 3 (score 95)
I like `sys.hexversion` for stuff like this.  

<a href="http://docs.python.org/library/sys.html#sys.hexversion" rel="noreferrer">http://docs.python.org/library/sys.html#sys.hexversion</a>  

```python
>>> import sys
>>> sys.hexversion
33883376
>>> '%x' % sys.hexversion
'20504f0'
>>> sys.hexversion < 0x02060000
True
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: Writing a list to a file with Python (score [1386411](https://stackoverflow.com/q/899103) in 2016)

#### Question
Is this the cleanest way to write a list to a file, since `writelines()` doesn't insert newline characters?  

```python
file.writelines(["%s\n" % item  for item in list])
```

It seems like there would be a standard way...  

#### Answer accepted (score 793)
You can use a loop:  

```python
with open('your_file.txt', 'w') as f:
    for item in my_list:
        f.write("%s\n" % item)
```

In Python 2, you can also use  

```python
with open('your_file.txt', 'w') as f:
    for item in my_list:
        print >> f, item
```

If you're keen on a single function call, at least remove the square brackets `[]`, so that the strings to be printed get made one at a time (a genexp rather than a listcomp) -- no reason to take up all the memory required to materialize the whole list of strings.  

#### Answer 2 (score 341)
What are you going to do with the file? Does this file exist for humans, or other programs with clear interoperability requirements?  

If you are just trying to serialize a list to disk for later use by the same python app, you should be <a href="http://docs.python.org/library/pickle.html" rel="noreferrer">pickleing</a> the list.  

```python
import pickle

with open('outfile', 'wb') as fp:
    pickle.dump(itemlist, fp)
```

To read it back:  

```python
with open ('outfile', 'rb') as fp:
    itemlist = pickle.load(fp)
```

#### Answer 3 (score 254)
The simpler way is:  

```python
outfile.write("\n".join(itemlist))
```

You could ensure that all items in item list are strings using a generator expression:  

```python
outfile.write("\n".join(str(item) for item in itemlist))
```

Remember that all `itemlist` list need to be in memory, so, take care about the memory consumption.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: How to delete a character from a string using Python (score [1381554](https://stackoverflow.com/q/3559559) in 2018)

#### Question
There is a string, for example. `EXAMPLE`.  

How can I remove the middle character, i.e., `M` from it? I don't need the code. I want to know:  

<ul>
<li>Do strings in Python end in any special character?</li>
<li>Which is a better way - shifting everything right to left starting from the middle character OR creation of a new string and not copying the middle character?</li>
</ul>

#### Answer accepted (score 583)
In Python, strings are immutable, so you have to create a new string.  You have a few options of how to create the new string.  If you want to remove the 'M' wherever it appears:  

```python
newstr = oldstr.replace("M", "")
```

If you want to remove the central character:  

```python
midlen = len(oldstr)/2   # //2 in python 3
newstr = oldstr[:midlen] + oldstr[midlen+1:]
```

You asked if strings end with a special character.  No, you are thinking like a C programmer.  In Python, strings are stored with their length, so any byte value, including `\0`, can appear in a string.  

#### Answer 2 (score 64)
This is probably the best way:  

```python
original = "EXAMPLE"
removed = original.replace("M", "")
```

Don't worry about shifting characters and such. Most Python code takes place on a much higher level of abstraction.  

#### Answer 3 (score 57)
To replace a specific position:  

```python
s = s[:pos] + s[(pos+1):]
```

To replace a specific character:  

```python
s = s.replace('M','')
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: How to comment out a block of code in Python (score [1371641](https://stackoverflow.com/q/675442) in 2018)

#### Question
Is there a mechanism to comment out large blocks of Python code?  

Right now, the only ways I can see of commenting out code are to either start every line with a `#`, or to enclose the code in triple quotes: `"""`.  

The problem with these is that inserting `#` before every line is cumbersome and `"""` makes the string I want to use as a comment show up in generated documentation.  

After reading all comments, the answer seems to be "No".  

#### Answer accepted (score 414)
Python does not have such a mechanism. Prepend a `#` to each line to block comment. For more information see <a href="http://www.python.org/dev/peps/pep-0008/" rel="noreferrer">PEP 8</a>. Most Python IDEs support a mechanism to do the block-commenting-with-pound-signs automatically for you. For example, in IDLE on my machine, it's <kbd>Alt</kbd>+<kbd>3</kbd> and <kbd>Alt</kbd>+<kbd>4</kbd>.  

<strong>Don't use triple-quotes;</strong> as you discovered, this is for documentation strings not block comments, although it has a similar effect. If you're just commenting things out temporarily, this is fine as a temporary measure.  

#### Answer 2 (score 92)
The only cure I know for this is a good editor. Sorry.   

#### Answer 3 (score 75)
Hide the triple quotes in a context that won't be mistaken for a docstring, eg:  

```python
'''
...statements...
''' and None
```

or:  

```python
if False: '''
...statements...
'''
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Terminating a Python script (score [1362795](https://stackoverflow.com/q/73663) in 2016)

#### Question
I am aware of the `die()` command in PHP which stops a script early.  

How can I do this in Python?  

#### Answer accepted (score 1281)
```python
import sys
sys.exit()
```

details from the <a href="https://docs.python.org/2/library/constants.html#exit" rel="noreferrer" title="exit">`sys` module documentation</a>:  

<blockquote>
  `sys.<strong>exit</strong>([<em>arg</em>])`  
  
  <blockquote>
    <p>Exit from Python. This is implemented by raising the
    <a href="https://docs.python.org/2/library/exceptions.html#SystemExit" rel="noreferrer" title="SystemExit">`SystemExit`</a> exception, so cleanup actions specified by finally clauses
    of <a href="https://docs.python.org/2/reference/compound_stmts.html#try" rel="noreferrer" title="try">`try`</a> statements are honored, and it is possible to intercept the
    exit attempt at an outer level.</p>
    
    <p>The optional argument <em>arg</em> can be an integer giving the exit status
    (defaulting to zero), or another type of object. If it is an integer,
    zero is considered “successful termination” and any nonzero value is
    considered “abnormal termination” by shells and the like. Most systems
    require it to be in the range 0-127, and produce undefined results
    otherwise. Some systems have a convention for assigning specific
    meanings to specific exit codes, but these are generally
    underdeveloped; Unix programs generally use 2 for command line syntax
    errors and 1 for all other kind of errors. If another type of object
    is passed, None is equivalent to passing zero, and any other object is
    printed to <a href="https://docs.python.org/2/library/sys.html#sys.stderr" rel="noreferrer" title="sys.stderr">`stderr`</a> and results in an exit code of 1. In particular,
    `sys.exit("some error message")` is a quick way to exit a program when
    an error occurs.</p>
    
    <p>Since <a href="https://docs.python.org/2/library/constants.html#exit" rel="noreferrer" title="exit">`exit()`</a> ultimately “only” raises an exception, it will only exit
    the process when called from the main thread, and the exception is not
    intercepted.</p>
  </blockquote>
</blockquote>

Note that this is the 'nice' way to exit.  @<a href="https://stackoverflow.com/questions/73663/terminating-a-python-script#76374">glyphtwistedmatrix</a> below points out that if you want a 'hard exit', you can use os._exit(<em>errorcode</em>), though it's likely os-specific to some extent (it might not take an errorcode under windows, for example), and it definitely is less friendly since it doesn't let the interpreter do any cleanup before the process dies.  

#### Answer 2 (score 292)
A simple way to terminate a Python script early is to use the built-in function quit(). There is no need to import any library, and it is efficient and simple.  

Example:  

```python
#do stuff
if this == that:
  quit()
```

#### Answer 3 (score 113)
Another way is:  

```python
raise SystemExit
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: How to import other Python files? (score [1351747](https://stackoverflow.com/q/2349991) in 2018)

#### Question
How do I import other files in Python?  

<ol>
<li>How exactly can I import a specific python file like `import file.py`?</li>
<li>How can I import a folder instead of a specific file?</li>
<li>I want to load a Python file dynamically at runtime, based on user
input.</li>
<li>I want to know how to load just one specific part from the file.</li>
</ol>

For example, in `main.py` I have:  

```python
from extra import * 
```

Although this gives me all the definitions in `extra.py`, when maybe all I want is a single definition:  

```python
def gap():
    print
    print
```

What do I add to the `import` statement to just get `gap` from `extra.py`?  

#### Answer accepted (score 382)
<p>`importlib` is recent addition in Python to programmatically import a module. It just a wrapper around `__import__` 
See <a href="https://docs.python.org/3/library/importlib.html#module-importlib" rel="noreferrer">https://docs.python.org/3/library/importlib.html#module-importlib</a></p>

```python
import importlib

moduleName = input('Enter module name:')
importlib.import_module(moduleName)
```

<hr>

<strong>Update: Answer below is outdated</strong>. Use the more recent alternative above.  

<ol>
<li><p>Just `import file` without the '.py' extension.</p></li>
<li><p>You can mark a folder as a package, by adding an empty file named `__init__.py`.</p></li>
<li><p>You can use the `__import__` function. It takes the module name as a string. (Again: module name without the '.py' extension.)</p>

```python
pmName = input('Enter module name:')
pm = __import__(pmName)
print(dir(pm))
```

Type `help(__import__)` for more details.  </li>
</ol>

#### Answer 2 (score 914)
<h5>There are many ways to import a python file, all with their pros and cons.</h2>

Don't just hastily pick the first import strategy that works for you or else you'll have to rewrite the codebase later on when you find it doesn't meet your needs.    

I'll start out explaining the easiest example #1, then I'll move toward the most professional and robust example #7  

<strong>Example 1, Import a python module with python interpreter:</strong>  

<ol>
<li><p>Put this in /home/el/foo/fox.py:</p>

```python
def what_does_the_fox_say():
  print("vixens cry")
```</li>
<li><p>Get into the python interpreter: </p>

```python
el@apollo:/home/el/foo$ python
Python 2.7.3 (default, Sep 26 2013, 20:03:06) 
>>> import fox
>>> fox.what_does_the_fox_say()
vixens cry
>>> 
```

You imported fox through the python interpreter, invoked the python function `what_does_the_fox_say()` from within fox.py.    </li>
</ol>

<strong>Example 2, Use `execfile` or (<a href="https://stackoverflow.com/q/6357361/55075">`exec` in Python 3</a>) in a script to execute the other python file in place:</strong>  

<ol>
<li><p>Put this in /home/el/foo2/mylib.py:</p>

```python
def moobar():
  print("hi")
```</li>
<li><p>Put this in /home/el/foo2/main.py:</p>

```python
execfile("/home/el/foo2/mylib.py")
moobar()
```</li>
<li><p>run the file:</p>

```python
el@apollo:/home/el/foo$ python main.py
hi
```

The function moobar was imported from mylib.py and made available in main.py  </li>
</ol>

<strong>Example 3, Use from ... import ... functionality:</strong>  

<ol>
<li><p>Put this in /home/el/foo3/chekov.py:</p>

```python
def question():
  print "where are the nuclear wessels?"
```</li>
<li><p>Put this in /home/el/foo3/main.py:</p>

```python
from chekov import question
question()
```</li>
<li><p>Run it like this:</p>

```python
el@apollo:/home/el/foo3$ python main.py 
where are the nuclear wessels?
```

If you defined other functions in chekov.py, they would not be available unless you `import *`  </li>
</ol>

<strong>Example 4, Import riaa.py if it's in a different file location from where it is imported</strong>  

<ol>
<li><p>Put this in /home/el/foo4/stuff/riaa.py:</p>

```python
def watchout():
  print "computers are transforming into a noose and a yoke for humans"
```</li>
<li><p>Put this in /home/el/foo4/main.py:</p>

```python
import sys 
import os
sys.path.append(os.path.abspath("/home/el/foo4/stuff"))
from riaa import *
watchout()
```</li>
<li><p>Run it:</p>

```python
el@apollo:/home/el/foo4$ python main.py 
computers are transforming into a noose and a yoke for humans
```

That imports everything in the foreign file from a different directory.  </li>
</ol>

<strong>Example 5, use `os.system("python yourfile.py")`</strong>  

```python
import os
os.system("python yourfile.py")
```

<strong>Example 6, import your file via piggybacking the python startuphook:</strong>  

<strong>Update:</strong> This example used to work for both python2 and 3, but now only works for python2.  python3 got rid of this user startuphook feature set because it was abused by low-skill python library writers, using it to impolitely inject their code into the global namespace, before all user-defined programs.  If you want this to work for python3, you'll have to get more creative.  If I tell you how to do it, python developers will disable that feature set as well, so you're on your own.    

See: <a href="https://docs.python.org/2/library/user.html" rel="noreferrer">https://docs.python.org/2/library/user.html</a>  

Put this code into your home directory in `~/.pythonrc.py`  

```python
class secretclass:
    def secretmessage(cls, myarg):
        return myarg + " is if.. up in the sky, the sky"
    secretmessage = classmethod( secretmessage )

    def skycake(cls):
        return "cookie and sky pie people can't go up and "
    skycake = classmethod( skycake )
```

Put this code into your main.py (can be anywhere):  

```python
import user
msg = "The only way skycake tates good" 
msg = user.secretclass.secretmessage(msg)
msg += user.secretclass.skycake()
print(msg + " have the sky pie! SKYCAKE!")
```

Run it, you should get this:  

```python
$ python main.py
The only way skycake tates good is if.. up in the sky, 
the skycookie and sky pie people can't go up and  have the sky pie! 
SKYCAKE!
```

If you get an error here: `ModuleNotFoundError: No module named 'user'` then it means you're using python3, startuphooks are disabled there by default.  

Credit for this jist goes to: <a href="https://github.com/docwhat/homedir-examples/blob/master/python-commandline/.pythonrc.py" rel="noreferrer">https://github.com/docwhat/homedir-examples/blob/master/python-commandline/.pythonrc.py</a>  Send along your up-boats.  

<strong>Example 7, Most Robust: Import files in python with the bare import command:</strong>  

<ol>
<li>Make a new directory `/home/el/foo5/`</li>
<li>Make a new directory `/home/el/foo5/herp`</li>
<li><p>Make an empty file named `__init__.py` under herp:</p>

```python
el@apollo:/home/el/foo5/herp$ touch __init__.py
el@apollo:/home/el/foo5/herp$ ls
__init__.py
```</li>
<li><p>Make a new directory /home/el/foo5/herp/derp</p></li>
<li><p>Under derp, make another `__init__.py` file:</p>

```python
el@apollo:/home/el/foo5/herp/derp$ touch __init__.py
el@apollo:/home/el/foo5/herp/derp$ ls
__init__.py
```</li>
<li><p>Under /home/el/foo5/herp/derp make a new file called `yolo.py` Put this in there:</p>

```python
def skycake():
  print "SkyCake evolves to stay just beyond the cognitive reach of " +
  "the bulk of men. SKYCAKE!!"
```</li>
<li><p>The moment of truth, Make the new file `/home/el/foo5/main.py`, put this in there;</p>

```python
from herp.derp.yolo import skycake
skycake()
```</li>
<li><p>Run it:</p>

```python
el@apollo:/home/el/foo5$ python main.py
SkyCake evolves to stay just beyond the cognitive reach of the bulk 
of men. SKYCAKE!!
```

The empty `__init__.py` file communicates to the python interpreter that the developer intends this directory to be an importable package.  </li>
</ol>

If you want to see my post on how to include ALL .py files under a directory see here: <a href="https://stackoverflow.com/a/20753073/445131">https://stackoverflow.com/a/20753073/445131</a>  

#### Answer 3 (score 55)
To import a specific Python file at 'runtime' with a known name:  

```python
import os
import sys
```

...  

```python
scriptpath = "../Test/MyModule.py"

# Add the directory containing your module to the Python path (wants absolute paths)
sys.path.append(os.path.abspath(scriptpath))

# Do the import
import MyModule
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: How can I reverse a list in Python? (score [1346403](https://stackoverflow.com/q/3940128) in 2018)

#### Question
How can I do the following in Python?  

```python
array = [0, 10, 20, 40]
for (i = array.length() - 1; i >= 0; i--)
```

I need to have the elements of an array, but from the end to the beginning.  

#### Answer accepted (score 1203)
You can make use of the <a href="https://www.python.org/dev/peps/pep-0322/" rel="noreferrer">`reversed`</a> function for this as:  

```python
>>> array=[0,10,20,40]
>>> for i in reversed(array):
...     print(i)
```

Note that `reversed(...)` does not return a list. You can get a reversed list using `list(reversed(array))`.  

#### Answer 2 (score 1175)
```python
>>> L = [0,10,20,40]
>>> L[::-1]
[40, 20, 10, 0]
```

Extended slice syntax is explained well in the Python <a href="http://docs.python.org/release/2.3.5/whatsnew/section-slices.html" rel="noreferrer">What's new Entry for release `2.3.5`</a>  

By special request in a comment <a href="http://docs.python.org/library/functions.html#slice" rel="noreferrer">this is the most current slice documentation</a>.  

#### Answer 3 (score 346)
```python
>>> L = [0,10,20,40]
>>> L.reverse()
>>> L
[40, 20, 10, 0]
```

Or   

```python
>>> L[::-1]
[40, 20, 10, 0]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: How do I specify new lines on Python, when writing on files? (score [1343781](https://stackoverflow.com/q/11497376) in 2019)

#### Question
In comparison to Java (in a String), you would do something like `"First Line\r\nSecond Line"`.  

So how would you do that in Python, for purposes of writing multiple lines on a regular file?  

#### Answer accepted (score 312)
It depends on how correct you want to be. `\n` will usually do the job. If you really want to get it right, you look up the newline character in the <a href="http://docs.python.org/library/os.html" rel="noreferrer">`os` package</a>. (It's actually called `linesep`.)  

Note: when writing to files using the Python API, do not use the `os.linesep`. Just use `\n`; Python automatically translates that to the proper newline character for your platform.  

#### Answer 2 (score 43)
The new line character is `\n`. It is used inside a string.  

Example:   

```python
    print 'First line \n Second line' 
```

where `\n` is the newline character.  

This would yield the result:  

```python
First line
 Second line
```

#### Answer 3 (score 18)
You can either write in the new lines separately or within a single string, which is easier.  

<h5>Example 1</h1>

<h5>Input</h2>

```python
line1 = "hello how are you"
line2 = "I am testing the new line escape sequence"
line3 = "this seems to work"
```

You can write the '\n' separately:  

```python
file.write(line1)
file.write("\n")
file.write(line2)
file.write("\n")
file.write(line3)
file.write("\n")
```

<h5>Output</h2>

```python
hello how are you
I am testing the new line escape sequence
this seems to work
```

<h5>Example 2</h1>

<h5>Input</h2>

As others have pointed out in the previous answers, place the \n at the relevant points in your string:  

```python
line = "hello how are you\nI am testing the new line escape sequence\nthis seems to work"

file.write(line)
```

<h5>Output</h2>

```python
hello how are you
I am testing the new line escape sequence
this seems to work
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: Removing duplicates in lists (score [1337045](https://stackoverflow.com/q/7961363) in 2019)

#### Question
Pretty much I need to write a program to check if a list has any duplicates and if it does it removes them and returns a new list with the items that weren't duplicated/removed. This is what I have but to be honest I do not know what to do.  

```python
def remove_duplicates():
    t = ['a', 'b', 'c', 'd']
    t2 = ['a', 'c', 'd']
    for t in t2:
        t.append(t.remove())
    return t
```

#### Answer accepted (score 1446)
The common approach to get a unique collection of items is to use a <a href="http://docs.python.org/3/library/stdtypes.html#set-types-set-frozenset" rel="noreferrer">`set`</a>. Sets are <em>unordered</em> collections of <em>distinct</em> objects. To create a set from any iterable, you can simply pass it to the built-in <a href="http://docs.python.org/3/library/functions.html#func-set" rel="noreferrer">`set()`</a> function. If you later need a real list again, you can similarly pass the set to the <a href="http://docs.python.org/3/library/functions.html#func-list" rel="noreferrer">`list()`</a> function.  

The following example should cover whatever you are trying to do:  

```python
>>> t = [1, 2, 3, 1, 2, 5, 6, 7, 8]
>>> t
[1, 2, 3, 1, 2, 5, 6, 7, 8]
>>> list(set(t))
[1, 2, 3, 5, 6, 7, 8]
>>> s = [1, 2, 3]
>>> list(set(t) - set(s))
[8, 5, 6, 7]
```

As you can see from the example result, <em>the original order is not maintained</em>. As mentioned above, sets themselves are unordered collections, so the order is lost. When converting a set back to a list, an arbitrary order is created.  

<h5>Maintaining order</h3>

If order is important to you, then you will have to use a different mechanism. A very common solution for this is to rely on <a href="https://docs.python.org/3/library/collections.html#collections.OrderedDict" rel="noreferrer">`OrderedDict`</a> to keep the order of keys during insertion:  

```python
>>> from collections import OrderedDict
>>> list(OrderedDict.fromkeys(t))
[1, 2, 3, 5, 6, 7, 8]
```

<a href="https://mail.python.org/pipermail/python-dev/2017-December/151283.html" rel="noreferrer">Starting with Python 3.7</a>, the built-in dictionary is guaranteed to maintain the insertion order as well, so you can also use that directly if you are on Python 3.7 or later (or CPython 3.6):  

```python
>>> list(dict.fromkeys(t))
[1, 2, 3, 5, 6, 7, 8]
```

Note that this has the overhead of creating a dictionary first, and then creating a list from it. If you don’t actually need to preserve the order, you’re better off using a set. Check out <a href="https://stackoverflow.com/q/480214/216074">this question</a> for more details and alternative ways to preserve the order when removing duplicates.  

<hr>

Finally note that both the `set` as well as the `OrderedDict`/`dict` solutions require your items to be <em>hashable</em>. This usually means that they have to be immutable. If you have to deal with items that are not hashable (e.g. list objects), then you will have to use a slow approach in which you will basically have to compare every item with every other item in a nested loop.  

#### Answer 2 (score 383)
<strong>In Python 2.7</strong>, the new way of removing duplicates from an iterable while keeping it in the original order is:  

```python
>>> from collections import OrderedDict
>>> list(OrderedDict.fromkeys('abracadabra'))
['a', 'b', 'r', 'c', 'd']
```

<strong>In Python 3.5</strong>, the OrderedDict has a C implementation. My timings show that this is now both the fastest and shortest of the various approaches for Python 3.5.  

<strong>In Python 3.6</strong>, the regular dict became both ordered and compact.  (This feature is holds for CPython and PyPy but may not present in other implementations).  That gives us a new fastest way of deduping while retaining order:  

```python
>>> list(dict.fromkeys('abracadabra'))
['a', 'b', 'r', 'c', 'd']
```

<strong>In Python 3.7</strong>, the regular dict is guaranteed to both ordered across all implementations.  <strong>So, the shortest and fastest solution is:</strong>  

```python
>>> list(dict.fromkeys('abracadabra'))
['a', 'b', 'r', 'c', 'd']
```

#### Answer 3 (score 180)
It's a one-liner: `list(set(source_list))` will do the trick.  

A `set` is something that can't possibly have duplicates.  

Update: an order-preserving approach is two lines:  

```python
from collections import OrderedDict
OrderedDict((x, True) for x in source_list).keys()
```

Here we use the fact that `OrderedDict` remembers the insertion order of keys, and does not change it when a value at a particular key is updated. We insert `True` as values, but we could insert anything, values are just not used. (`set` works a lot like a `dict` with ignored values, too.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Get unique values from a list in python (score [1335592](https://stackoverflow.com/q/12897374) in 2019)

#### Question
I want to get the unique values from the following list:  

```python
['nowplaying', 'PBS', 'PBS', 'nowplaying', 'job', 'debate', 'thenandnow']
```

The output which I require is:  

```python
['nowplaying', 'PBS', 'job', 'debate', 'thenandnow']
```

This code works:  

```python
output = []
for x in trends:
    if x not in output:
        output.append(x)
print(output)
```

is there a better solution I should use?  

#### Answer 2 (score 894)
First declare your list properly, separated by commas. You can get the unique values by converting the list to a set.  

```python
mylist = ['nowplaying', 'PBS', 'PBS', 'nowplaying', 'job', 'debate', 'thenandnow']
myset = set(mylist)
print(myset)
```

If you use it further as a list, you should convert it back to a list by doing:  

```python
mynewlist = list(myset)
```

Another possibility, probably faster would be to use a set from the beginning, instead of a list. Then your code should be:  

```python
output = set()
for x in trends:
    output.add(x)
print(output)
```

As it has been pointed out, sets do not maintain the original order. If you need that, you should look for an <a href="http://code.activestate.com/recipes/576694/" rel="noreferrer">ordered set</a> implementation (see <a href="https://stackoverflow.com/questions/1653970/does-python-have-an-ordered-set">this question</a> for more).  

#### Answer 3 (score 290)
To be consistent with the type I would use:  

```python
mylist = list(set(mylist))
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Python error "ImportError: No module named" (score [1319040](https://stackoverflow.com/q/338768) in 2017)

#### Question
Python is installed in a local directory.    

My directory tree looks like this:  

```python
(local directory)/site-packages/toolkit/interface.py
```

My code is in here:  

```python
(local directory)/site-packages/toolkit/examples/mountain.py
```

To run the example, I write `python mountain.py`, and in the code I have:  

```python
from toolkit.interface import interface
```

And I get the error:  

```python
Traceback (most recent call last):
  File "mountain.py", line 28, in ?
    from toolkit.interface import interface
ImportError: No module named toolkit.interface
```

I have already checked `sys.path` and there I have the directory `/site-packages`. Also, I have the file `__init__.py.bin` in the toolkit folder to indicate to Python that this is a package. I also have a `__init__.py.bin` in the examples directory.  

I do not know why Python cannot find the file when it is in `sys.path`.  Any ideas?  Can it be a permissions problem?  Do I need some execution permission?  

#### Answer accepted (score 246)
Based on your comments to orip's post, I guess this is what happened:  

<ol>
<li>You edited `__init__.py` on windows.</li>
<li>The windows editor added something non-printing, perhaps a carriage-return (end-of-line in Windows is CR/LF; in unix it is LF only), or perhaps a CTRL-Z (windows end-of-file).</li>
<li>You used WinSCP to copy the file to your unix box.</li>
<li>WinSCP thought: "This has something that's not basic text; I'll put a .bin extension to indicate binary data."</li>
<li>The missing `__init__.py` (now called `__init__.py.bin`) means python doesn't understand toolkit as a package.</li>
<li>You create `__init__.py` in the appropriate directory and everything works... ?</li>
</ol>

#### Answer 2 (score 64)
Does  

```python
(local directory)/site-packages/toolkit
```

have a `__init__.py`?  

To make import <em>walk</em> through your directories every directory must have a `__init__.py` file.  

#### Answer 3 (score 42)
I ran into something very similar when I did this exercise in LPTHW; I could never get Python to recognise that I had files in the directory I was calling from. But I was able to get it to work in the end. What I did, and what I recommend, is to try this:  

(NOTE: From your initial post, I am assuming you are using an *NIX-based machine and are running things from the command line, so this advice is tailored to that. Since I run Ubuntu, this is what I did)   

1) Change directory (cd) to the directory <em>above</em> the directory where your files are. In this case, you're trying to run the `mountain.py` file, and trying to call the `toolkit.interface.py` module, which are in separate directories. In this case, you would go to the directory that contains paths to both those files (or in other words, the closest directory that the paths of both those files share). Which in this case is the `toolkit` directory.  

2) When you are in the `tookit` directory, enter this line of code on your command line:  

`export PYTHONPATH=.`  

This sets your PYTHONPATH to ".", which basically means that your PYTHONPATH will now look for any called files within the directory you are currently in, (and more to the point, in the <em>sub-directory branches</em> of the directory you are in. So it doesn't just look in your current directory, but in all the directories that are <strong>in</strong> your current directory).  

3) After you've set your PYTHONPATH in the step above, run your module from your current directory (the `toolkit` directory). Python should now find and load the modules you specified.  

Hope this helps. I was quite frustrated with this myself.   
</section>

