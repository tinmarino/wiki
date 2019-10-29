---
title: Bash <- StackOverflow top 100
category: bash
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How to concatenate string variables in Bash (score [3365295](https://stackoverflow.com/q/4181703) in 2018)

#### Question
In PHP, strings are concatenated together as follows:  

```sh
$foo = "Hello";
$foo .= " World";
```

Here, `$foo` becomes "Hello World".  

How is this accomplished in Bash?  

#### Answer accepted (score 3477)
```sh
foo="Hello"
foo="${foo} World"
echo "${foo}"
> Hello World
```

In general to concatenate two variables you can just write them one after another:  

```sh
a='Hello'
b='World'
c="${a} ${b}"
echo "${c}"
> Hello World
```

#### Answer 2 (score 1067)
Bash also supports a `+=` operator as shown in this code:  

```sh
$ A="X Y"
$ A+=" Z"
$ echo "$A"
X Y Z
```

#### Answer 3 (score 917)
<h5>Bash first</h1>

As this question stand specifically for <a href="http://en.wikipedia.org/wiki/Bash_%28Unix_shell%29" rel="noreferrer">Bash</a>, my first part of the answer would present different ways of doing this properly:  

<h5>`+=`: Append to variable</h2>

The syntax <strong>`+=`</strong> may be used in different ways:  

<h5>Append to string `var+=...`</h3>

(Because I am frugal, I will only use two variables `foo` and `a` and then re-use the same in the whole answer. ;-)  

```sh
a=2
a+=4
echo $a
24
```

Using the <em>Stack&nbsp;Overflow question</em> syntax,  

```sh
foo="Hello"
foo+=" World"
echo $foo
Hello World
```

works fine!  

<h5>Append to an integer `((var+=...))`</h3>

variable `a` is a string, but also an integer  

```sh
echo $a
24
((a+=12))
echo $a
36
```

<h5>Append to an array `var+=(...)`</h3>

Our `a` is also an array of only one element.  

```sh
echo ${a[@]}
36

a+=(18)

echo ${a[@]}
36 18
echo ${a[0]}
36
echo ${a[1]}
18
```

Note that between parentheses, there is a <em>space separated array</em>. If you want to store a string containing spaces in your array, you have to enclose them:  

```sh
a+=(one word "hello world!" )
bash: !": event not found
```

Hmm.. <a href="https://serverfault.com/a/208266/142978">this is not a bug, but a feature</a>... To prevent bash to try to develop `!"`, you could:  

```sh
a+=(one word "hello world"! 'hello world!' $'hello world\041')

declare -p a
declare -a a='([0]="36" [1]="18" [2]="one" [3]="word" [4]="hello world!" [5]="h
ello world!" [6]="hello world!")'
```

<h5>`printf`: Re-construct variable using the <em>builtin</em> command</h2>

The `printf` <em>builtin</em> command gives a powerful way of drawing string format. As this is a Bash <em>builtin</em>, there is a option for sending formatted string to a variable instead of printing on `stdout`:  

```sh
echo ${a[@]}
36 18 one word hello world! hello world! hello world!
```

There are seven <em>strings</em> in this array. So we could build a formatted string containing exactly seven positional arguments:  

```sh
printf -v a "%s./.%s...'%s' '%s', '%s'=='%s'=='%s'" "${a[@]}"
echo $a
36./.18...'one' 'word', 'hello world!'=='hello world!'=='hello world!'
```

Or we could use <em>one argument format string</em> which will be repeated as many argument submitted...  

Note that our `a` is still an array! Only first element is changed!  

```sh
declare -p a
declare -a a='([0]="36./.18...'\''one'\'' '\''word'\'', '\''hello world!'\''=='\
''hello world!'\''=='\''hello world!'\''" [1]="18" [2]="one" [3]="word" [4]="hel
lo world!" [5]="hello world!" [6]="hello world!")'
```

Under bash, when you access a variable name without specifying index, you always address first element only!  

So to retrieve our seven field array, we only need to re-set 1st element:  

```sh
a=36
declare -p a
declare -a a='([0]="36" [1]="18" [2]="one" [3]="word" [4]="hello world!" [5]="he
llo world!" [6]="hello world!")'
```

One argument format string with many argument passed to:  

```sh
printf -v a[0] '<%s>\n' "${a[@]}"
echo "$a"
<36>
<18>
<one>
<word>
<hello world!>
<hello world!>
<hello world!>
```

<h5>Using the <em>Stack&nbsp;Overflow question</em> syntax:</h3>

```sh
foo="Hello"
printf -v foo "%s World" $foo
echo $foo
Hello World
```

Nota: The use of <em>double-quotes</em> may be useful for manipulating strings that contain `spaces`, `tabulations` and/or `newlines`  

```sh
printf -v foo "%s World" "$foo"
```

<h5>Shell now</h1>

Under <em>POSIX</em> shell, you could not use <em>bashisms</em>, so there is no <em>builtin</em> `printf`.  

<h5>Basically</h3>

But you could simply do:  

```sh
foo="Hello"
foo="$foo World"
echo $foo
Hello World
```

<h5>Formatted, using <em>forked</em> `printf`</h3>

If you want to use more sophisticated constructions you have to use a <em>fork</em> (new child process that make the job and return the result via `stdout`):  

```sh
foo="Hello"
foo=$(printf "%s World" "$foo")
echo $foo
Hello World
```

Historically, you could use <em>backticks</em> for retrieving result of a <em>fork</em>:  

```sh
foo="Hello"
foo=`printf "%s World" "$foo"`
echo $foo
Hello World
```

But this is not easy for <em>nesting</em>:  

```sh
foo="Today is: "
foo=$(printf "%s %s" "$foo" "$(date)")
echo $foo
Today is: Sun Aug 4 11:58:23 CEST 2013
```

with backticks, you have to escape inner forks with <em>backslashes</em>:  

```sh
foo="Today is: "
foo=`printf "%s %s" "$foo" "\`date\`"`
echo $foo
Today is: Sun Aug 4 11:59:10 CEST 2013
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How do I tell if a regular file does not exist in Bash? (score [2390567](https://stackoverflow.com/q/638975) in 2017)

#### Question
I've used the following script to see if a file exists:  

```sh
#!/bin/bash

FILE=$1     
if [ -f $FILE ]; then
   echo "File $FILE exists."
else
   echo "File $FILE does not exist."
fi
```

What's the correct syntax to use if I only want to check if the file does <strong>not</strong> exist?  

```sh
#!/bin/bash

FILE=$1     
if [ $FILE does not exist ]; then
   echo "File $FILE does not exist."
fi
```

#### Answer accepted (score 4255)
The <a href="http://man7.org/linux/man-pages/man1/test.1.html" rel="noreferrer">test</a> command (`[` here) has a "not" logical operator which is the exclamation point (similar to many other languages). Try this:  

```sh
if [ ! -f /tmp/foo.txt ]; then
    echo "File not found!"
fi
```

#### Answer 2 (score 607)
<strong>Bash File Testing</strong>  

<p>`-b filename` - Block special file<br>
`-c filename` - Special character file<br>
`-d directoryname` - Check for directory Existence<br>
`-e filename` - Check for file existence, regardless of type (node, directory, socket, etc.)<br>
`-f filename` - Check for regular file existence not a directory<br>
`-G filename` - Check if file exists and is owned by effective group ID<br>
`-G filename set-group-id` - True if file exists and is set-group-id<br>
`-k filename` - Sticky bit<br>
`-L filename` - Symbolic link<br>
`-O filename` - True if file exists and is owned by the effective user id<br>
`-r filename` - Check if file is a readable<br>
`-S filename` - Check if file is socket<br>
`-s filename` - Check if file is nonzero size<br>
`-u filename` - Check if file set-user-id bit is set<br>
`-w filename` - Check if file is writable<br>
`-x filename` - Check if file is executable</p>

<strong>How to use:</strong>  

```sh
#!/bin/bash
file=./file
if [ -e "$file" ]; then
    echo "File exists"
else 
    echo "File does not exist"
fi 
```

A <em>test expression</em> can be negated by using the `!` operator  

```sh
#!/bin/bash
file=./file
if [ ! -e "$file" ]; then
    echo "File does not exist"
else 
    echo "File exists"
fi 
```

#### Answer 3 (score 280)
You can negate an expression with "!":  

```sh
#!/bin/bash
FILE=$1

if [ ! -f "$FILE" ]
then
    echo "File $FILE does not exist"
fi
```

The relevant man page is `man test` or, equivalently, `man [` -- or `help test` or `help [` for the built-in bash command.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How do I split a string on a delimiter in Bash? (score [1998122](https://stackoverflow.com/q/918886) in 2018)

#### Question
I have this string stored in a variable:  

```sh
IN="bla@some.com;john@home.com"
```

Now I would like to split the strings by `;` delimiter so that I have:  

```sh
ADDR1="bla@some.com"
ADDR2="john@home.com"
```

I don't necessarily need the `ADDR1` and `ADDR2` variables. If they are elements of an array that's even better.  

<hr>

After suggestions from the answers below, I ended up with the following which is what I was after:  

```sh
#!/usr/bin/env bash

IN="bla@some.com;john@home.com"

mails=$(echo $IN | tr ";" "\n")

for addr in $mails
do
    echo "> [$addr]"
done
```

Output:  

```sh
> [bla@some.com]
> [john@home.com]
```

There was a solution involving setting <a href="http://en.wikipedia.org/wiki/Internal_field_separator" rel="noreferrer">Internal_field_separator</a> (IFS) to `;`. I am not sure what happened with that answer, how do you reset `IFS` back to default?  

RE: `IFS` solution, I tried this and it works, I keep the old `IFS` and then restore it:  

```sh
IN="bla@some.com;john@home.com"

OIFS=$IFS
IFS=';'
mails2=$IN
for x in $mails2
do
    echo "> [$x]"
done

IFS=$OIFS
```

BTW, when I tried   

```sh
mails2=($IN)
```

I only got the first string when printing it in loop, without brackets around `$IN` it works.  

#### Answer accepted (score 1126)
You can set the <a href="http://en.wikipedia.org/wiki/Internal_field_separator" rel="noreferrer">internal field separator</a> (IFS) variable, and then let it parse into an array. When this happens in a command, then the assignment to `IFS` only takes place to that single command's environment (to `read` ). It then parses the input according to the `IFS` variable value into an array, which we can then iterate over.  

```sh
IFS=';' read -ra ADDR <<< "$IN"
for i in "${ADDR[@]}"; do
    # process "$i"
done
```

It will parse one line of items separated by `;`, pushing it into an array. Stuff for processing whole of `$IN`, each time one line of input separated by `;`:  

```sh
 while IFS=';' read -ra ADDR; do
      for i in "${ADDR[@]}"; do
          # process "$i"
      done
 done <<< "$IN"
```

#### Answer 2 (score 886)
Taken from <em><a href="http://www.linuxquestions.org/questions/programming-9/bash-shell-script-split-array-383848/#post3270796" rel="noreferrer">Bash shell script split array</a></em>:  

```sh
IN="bla@some.com;john@home.com"
arrIN=(${IN//;/ })
```

Explanation:  

This construction replaces all occurrences of `';'` (the initial `//` means global replace) in the string `IN` with `' '` (a single space), then interprets the space-delimited string as an array (that's what the surrounding parentheses do).   

The syntax used inside of the curly braces to replace each `';'` character with a `' '` character is called <a href="https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html" rel="noreferrer">Parameter Expansion</a>.  

There are some common gotchas:  

<ol>
<li>If the original string has spaces, you will need to use <a href="https://unix.stackexchange.com/questions/184863/what-is-the-meaning-of-ifs-n-in-bash-scripting">IFS</a>:

<ul>
<li>`IFS=':'; arrIN=($IN); unset IFS;`</li>
</ul></li>
<li>If the original string has spaces <em>and</em> the delimiter is a new line, you can set <a href="https://unix.stackexchange.com/questions/184863/what-is-the-meaning-of-ifs-n-in-bash-scripting">IFS</a> with:

<ul>
<li>`IFS=$'\n'; arrIN=($IN); unset IFS;`</li>
</ul></li>
</ol>

#### Answer 3 (score 227)
If you don't mind processing them immediately, I like to do this:  

```sh
for i in $(echo $IN | tr ";" "\n")
do
  # process
done
```

You could use this kind of loop to initialize an array, but there's probably an easier way to do it. Hope this helps, though.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: Echo newline in Bash prints literal \n (score [1869228](https://stackoverflow.com/q/8467424) in 2016)

#### Question
In Bash, tried this:  

```sh
echo -e "hello\nworld"
```

But it doesn't print a newline, only `\n`. How can I make it print the newline?  

I'm using Ubuntu 11.04.  

#### Answer accepted (score 2592)
You could use `printf` instead:  

```sh
printf "hello\nworld\n"
```

`printf` has more consistent behavior than `echo`. The behavior of `echo` varies greatly between different versions.  

#### Answer 2 (score 1562)
Are you sure you are in bash? Works for me, all three ways:  

```sh
echo -e "Hello\nworld"
echo -e 'Hello\nworld'
echo Hello$'\n'world
```

#### Answer 3 (score 538)
```sh
echo $'hello\nworld'
```

prints  

```sh
hello
world
```

`$''` strings use <a href="http://www.gnu.org/software/bash/manual/html_node/ANSI_002dC-Quoting.html" rel="noreferrer">ANSI C Quoting</a>:  

<blockquote>
  Words of the form `$'<i>string</i>'` are treated specially. The word expands to <i>string</i>, with backslash-escaped characters replaced as specified by the ANSI C standard.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: How to check if a string contains a substring in Bash (score [1843858](https://stackoverflow.com/q/229551) in 2018)

#### Question
I have a string in Bash:  

```sh
string="My string"
```

How can I test if it contains another string?  

```sh
if [ $string ?? 'foo' ]; then
  echo "It's there!"
fi
```

Where `??` is my unknown operator. Do I use echo and `grep`?  

```sh
if echo "$string" | grep 'foo'; then
  echo "It's there!"
fi
```

That looks a bit clumsy.  

#### Answer accepted (score 3248)
You can use <a href="https://stackoverflow.com/a/229585/3755692">Marcus's answer (* wildcards)</a> outside a case statement, too, if you use double brackets:  

```sh
string='My long string'
if [[ $string == *"My long"* ]]; then
  echo "It's there!"
fi
```

Note that spaces in the needle string need to be placed between double quotes, and the `*` wildcards should be outside.  

#### Answer 2 (score 514)
If you prefer the regex approach:  

```sh
string='My string';

if [[ $string =~ "My" ]]
then
   echo "It's there!"
fi
```

#### Answer 3 (score 316)
I am not sure about using an if statement, but you can get a similar effect with a case statement:  

```sh
case "$string" in 
  *foo*)
    # Do stuff
    ;;
esac
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: How do I set a variable to the output of a command in Bash? (score [1657843](https://stackoverflow.com/q/4651437) in 2019)

#### Question
I have a pretty simple script that is something like the following:  

```sh
#!/bin/bash

VAR1="$1"
MOREF='sudo run command against $VAR1 | grep name | cut -c7-'

echo $MOREF
```

When I run this script from the command line and pass it the arguments, I am not getting any output.  However, when I run the commands contained within the `$MOREF` variable, I am able to get output.  

How can one take the results of a command that needs to be run within a script, save it to a variable, and then output that variable on the screen?  

#### Answer accepted (score 2159)
In addition to backticks `&#96;command&#96;` you can use `$(command)` or `"$(command)"` which I find easier to read, and allow for nesting.  

```sh
OUTPUT="$(ls -1)"
echo "${OUTPUT}"

MULTILINE=$(ls \
   -1)
echo "${MULTILINE}"
```

Quoting (`"`) does matter to preserve multi-line values.  

#### Answer 2 (score 259)
The right way is   

```sh
$(sudo run command)
```

<hr>

If you're going to use an apostrophe, you need ```, not `'`. This character is called "backticks" (or "grave accent").  

Like this:  

```sh
#!/bin/bash

VAR1="$1"
VAR2="$2"

MOREF=`sudo run command against "$VAR1" | grep name | cut -c7-`

echo "$MOREF"
```

#### Answer 3 (score 70)
As they have already indicated to you, you should use 'backticks'.  

<p>The alternative proposed `$(command)` works as well, and it also easier to read, but note that it is valid only with Bash or KornShell (and shells derived from those),
so if your scripts have to be really portable on various Unix systems, you should prefer the old backticks notation.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: How to create a file in Linux from terminal window? (score [1564036](https://stackoverflow.com/q/9381463) in 2018)

#### Question
What's the easiest way to create a file in Linux terminal?  

#### Answer accepted (score 548)
Depending on what you want the file to contain:  

<ul>
<li>`touch /path/to/file` for an empty file</li>
<li><p>`somecommand &gt; /path/to/file` for a file containing the output of some command.</p>

```sh
  eg: grep --help > randomtext.txt
      echo "This is some text" > randomtext.txt
```</li>
<li><p>`nano /path/to/file` or `vi /path/to/file` (or `any other editor emacs,gedit etc`)<br>
It either opens the existing one for editing or creates &amp; opens the empty file to enter, if it doesn't exist</p></li>
</ul>

#### Answer 2 (score 118)
Use <a href="http://en.wikipedia.org/wiki/Touch_(Unix)" rel="noreferrer">touch</a>  

```sh
touch filename
```

#### Answer 3 (score 85)
<strong>Create the file using `cat`</strong>  

`$ cat &gt; myfile.txt`  

Now, just type whatever you want in the file:  

`Hello World!`  

CTRL-D to save and exit  

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: Get the source directory of a Bash script from within the script itself (score [1552214](https://stackoverflow.com/q/59895) in 2019)

#### Question
How do I get the path of the directory in which a <a href="http://en.wikipedia.org/wiki/Bash_%28Unix_shell%29" rel="noreferrer">Bash</a> script is located, <em>inside</em> that script?  

For instance, let's say I want to use a Bash script as a launcher for another application. I want to change the working directory to the one where the Bash script is located, so I can operate on the files in that directory, like so:   

<pre>$ ./application</pre>

#### Answer accepted (score 6107)
```sh
#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
```

is a useful one-liner which will give you the full directory name of the script no matter where it is being called from.  

It will work as long as the last component of the path used to find the script is not a symlink (directory links are OK).  If you also want to resolve any links to the script itself, you need a multi-line solution:  

```sh
#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
```

This last one will work with any combination of aliases, `source`, `bash -c`, symlinks, etc.  

Beware: if you `cd` to a different directory before running this snippet, the result may be incorrect!   

Also, watch out for <a href="http://bosker.wordpress.com/2012/02/12/bash-scripters-beware-of-the-cdpath/" rel="noreferrer">`$CDPATH` gotchas</a>, and stderr output side effects if the user has smartly overridden cd to redirect output to stderr instead (including escape sequences, such as when calling `update_terminal_cwd &gt;&amp;2` on Mac). Adding `&gt;/dev/null 2&gt;&amp;1` at the end of your `cd` command will take care of both possibilities.  

To understand how it works, try running this more verbose form:  

```sh
#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "$SOURCE")"
  if [[ $TARGET == /* ]]; then
    echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'"
    SOURCE="$TARGET"
  else
    DIR="$( dirname "$SOURCE" )"
    echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$DIR')"
    SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done
echo "SOURCE is '$SOURCE'"
RDIR="$( dirname "$SOURCE" )"
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
if [ "$DIR" != "$RDIR" ]; then
  echo "DIR '$RDIR' resolves to '$DIR'"
fi
echo "DIR is '$DIR'"
```

And it will print something like:  

```sh
SOURCE './scriptdir.sh' is a relative symlink to 'sym2/scriptdir.sh' (relative to '.')
SOURCE is './sym2/scriptdir.sh'
DIR './sym2' resolves to '/home/ubuntu/dotfiles/fo fo/real/real1/real2'
DIR is '/home/ubuntu/dotfiles/fo fo/real/real1/real2'
```

#### Answer 2 (score 808)
Use `dirname "$0"`:  

```sh
#!/bin/bash
echo "The script you are running has basename `basename "$0"`, dirname `dirname "$0"`"
echo "The present working directory is `pwd`"
```

using `pwd` alone will not work if you are not running the script from the directory it is contained in.  

```sh
[matt@server1 ~]$ pwd
/home/matt
[matt@server1 ~]$ ./test2.sh
The script you are running has basename test2.sh, dirname .
The present working directory is /home/matt
[matt@server1 ~]$ cd /tmp
[matt@server1 tmp]$ ~/test2.sh
The script you are running has basename test2.sh, dirname /home/matt
The present working directory is /tmp
```

#### Answer 3 (score 455)
The dirname command is the most basic, simply parsing the path up to the filename off of the $0 (script name) variable:  

```sh
dirname "$0"
```

But, as <strong>matt b</strong> pointed out, the path returned is different depending on how the script is called. pwd doesn't do the job because that only tells you what the current directory is, not what directory the script resides in. Additionally, if a symbolic link to a script is executed, you're going to get a (probably relative) path to where the link resides, not the actual script.   

Some others have mentioned the <strong>readlink</strong> command, but at its simplest, you can use:  

```sh
dirname "$(readlink -f "$0")"
```

readlink will resolve the script path to an absolute path from the root of the filesystem. So, any paths containing single or double dots, tildes and/or symbolic links will be resolved to a full path.  

Here's a script demonstrating each of these, <strong>whatdir.sh:</strong>  

```sh
#!/bin/bash
echo "pwd: `pwd`"
echo "\$0: $0"
echo "basename: `basename $0`"
echo "dirname: `dirname $0`"
echo "dirname/readlink: $(dirname $(readlink -f $0))"
```

Running this script in my home dir, using a relative path:  

```sh
>>>$ ./whatdir.sh 
pwd: /Users/phatblat
$0: ./whatdir.sh
basename: whatdir.sh
dirname: .
dirname/readlink: /Users/phatblat
```

Again, but using the full path to the script:  

```sh
>>>$ /Users/phatblat/whatdir.sh 
pwd: /Users/phatblat
$0: /Users/phatblat/whatdir.sh
basename: whatdir.sh
dirname: /Users/phatblat
dirname/readlink: /Users/phatblat
```

Now changing directories:  

```sh
>>>$ cd /tmp
>>>$ ~/whatdir.sh 
pwd: /tmp
$0: /Users/phatblat/whatdir.sh
basename: whatdir.sh
dirname: /Users/phatblat
dirname/readlink: /Users/phatblat
```

And finally using a symbolic link to execute the script:  

```sh
>>>$ ln -s ~/whatdir.sh whatdirlink.sh
>>>$ ./whatdirlink.sh 
pwd: /tmp
$0: ./whatdirlink.sh
basename: whatdirlink.sh
dirname: .
dirname/readlink: /Users/phatblat
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: Read a file line by line assigning the value to a variable (score [1529494](https://stackoverflow.com/q/10929453) in 2019)

#### Question
I have the following .txt file:  

 ```sh
Marco
Paolo
Antonio
```

I want to read it line-by-line, and for each line I want to assign a .txt line value to a variable. Supposing my variable is `$name`, the flow is:  

<ul>
<li>Read first line from file</li>
<li>Assign `$name` = "Marco"</li>
<li>Do some tasks with `$name`</li>
<li>Read second line from file</li>
<li>Assign `$name` = "Paolo"</li>
</ul>

#### Answer accepted (score 1240)
The following reads a file passed as an argument line by line:  

```sh
#!/bin/bash
while IFS= read -r line; do
    echo "Text read from file: $line"
done < "$1"
```

This is the <a href="http://mywiki.wooledge.org/BashFAQ/001" rel="noreferrer">standard form</a> for reading lines from a file in a loop. Explanation:  

<ul>
<li>`IFS=` (or `IFS=''`) prevents leading/trailing whitespace from being trimmed.</li>
<li>`-r` prevents backslash escapes from being interpreted.</li>
</ul>

If the above is saved to a script with filename `readfile`, it can be run as follows:  

```sh
chmod +x readfile
./readfile filename.txt
```

If the file isn’t a <a href="https://stackoverflow.com/a/729795/1968">standard POSIX text file</a> (= not terminated by a newline character), the loop can be modified to handle trailing partial lines:  

```sh
while IFS= read -r line || [[ -n "$line" ]]; do
    echo "Text read from file: $line"
done < "$1"
```

Here, `|| [[ -n $line ]]` prevents the last line from being ignored if it doesn't end with a `\n` (since `read` returns a non-zero exit code when it encounters EOF).  

If the commands inside the loop also read from standard input, the file descriptor used by `read` can be chanced to something else (avoid the <a href="https://en.wikipedia.org/wiki/File_descriptor" rel="noreferrer">standard file descriptors</a>), e.g.:  

```sh
while IFS= read -r -u3 line; do
    echo "Text read from file: $line"
done 3< "$1"
```

(Non-Bash shells might not know `read -u3`; use `read &lt;&amp;3` instead.)  

#### Answer 2 (score 299)
I encourage you to use the `-r` flag for `read` which stands for:  

```sh
-r  Do not treat a backslash character in any special way. Consider each
    backslash to be part of the input line.
```

I am citing from `man 1 read`.  

Another thing is to take a filename as an argument.  

Here is updated code:  

```sh
#!/usr/bin/bash
filename="$1"
while read -r line; do
    name="$line"
    echo "Name read from file - $name"
done < "$filename"
```

#### Answer 3 (score 126)
Using the following Bash template should allow you to read one value at a time from a file and process it.  

```sh
while read name; do
    # Do what you want to $name
done < filename
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: How to permanently set $PATH on Linux/Unix? (score [1467227](https://stackoverflow.com/q/14637979) in 2018)

#### Question
I'm trying to add a directory to my path so it will always be in my Linux path. I've tried:  

```sh
export PATH=$PATH:/path/to/dir
```

This works, however each time I exit the terminal and start a new terminal instance, this path is lost, and I need to run the export command again.  

How can I do it so this will be set permanently?  

#### Answer accepted (score 998)
<strong>You need to add it to your `~/.profile` or `~/.bashrc` file.</strong>&nbsp;  

```sh
export PATH="$PATH:/path/to/dir"
```

Depending on what you're doing, you also may want to symlink to binaries:  

```sh
cd /usr/bin
sudo ln -s /path/to/binary binary-name
```

<strong>Note that this will not automatically update your path for the remainder of the session.</strong> To do this, you should run:  

```sh
source ~/.profile 
or
source ~/.bashrc
```

#### Answer 2 (score 237)
<p>In Ubuntu, edit `/etc/environment`. Its sole purpose is to store Environment Variables. Originally the $PATH variable is defined here.
This is a paste from my `/etc/environment` file:</p>

```sh
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
```

So you can just open up this file as root and add whatever you want.  

<p>For Immediate results,
Run (try as normal user <em>and</em> root):</p>

```sh
source /etc/environment && export PATH
```

<strong>UPDATE:</strong>  

If you use `zsh` (a.k.a Z Shell), add this line right after the comments in `/etc/zsh/zshenv`:  

```sh
source /etc/environment
```

<em>I encountered this little quirk on Ubuntu 15.10, but if your <strong>zsh</strong> is not getting the correct <strong>PATH</strong>, this could be why</em>  

#### Answer 3 (score 152)
There are multiple ways to do it. The actual solution depends on the purpose.  

The variable values are usually stored in either a list of assignments or a shell script that is run at the start of the system or user session. In case of the shell script you must use a specific shell syntax.  

<h5>System wide</h2>

<ol>
<li>`/etc/environment` List of unique assignments. Perfect for adding system-wide directories like `/usr/local/something/bin` to `PATH` variable or defining `JAVA_HOME`.</li>
<li>`/etc/xprofile` Shell script executed while starting X Window System session. This is run for every user that logs into X Window System. It is a good choice for `PATH` entries that are valid for every user like `/usr/local/something/bin`. The file is included by other script so use POSIX shell syntax not the syntax of your user shell.</li>
<li>`/etc/profile` and `/etc/profile.d/*` Shell script. This is a good choice for shell-only systems. Those files are read only by shells.</li>
<li>`/etc/&lt;shell&gt;.&lt;shell&gt;rc`. Shell script. This is a poor choice because it is single shell specific.</li>
</ol>

<h5>User session</h2>

<ol>
<li>`~/.pam_environment`. List of unique assignments. Loaded by <a href="http://www.linux-pam.org/" rel="noreferrer">PAM</a> at the start of every user session irrelevant if it is an X Window System session or shell. You cannot reference other variable including `HOME` or `PATH` so it has limited use.</li>
<li>`~/.xprofile` Shell script. This is executed when the user logs into X Window System system. The variables defined here are visible to every X application. Perfect choice for extending `PATH` with values such as `~/bin` or `~/go/bin` or defining user specific `GOPATH` or `NPM_HOME`. The file is included by other script so use POSIX shell syntax not the syntax of your user shell. Your graphical text editor or IDE started by shortcut will see those values.</li>
<li>`~/.profile` Shell script. It will be visible only for programs started from terminal or terminal emulator. It is a good choice for shell-only systems.</li>
<li>`~/.&lt;shell&gt;rc`. Shell script. This is a poor choice because it is single shell specific.</li>
</ol>

<h5>Distribution specific documentation</h2>

<ul>
<li><a href="https://help.ubuntu.com/community/EnvironmentVariables#Persistent_environment_variables" rel="noreferrer">Ubuntu</a></li>
<li><a href="https://wiki.archlinux.org/index.php/Environment_variables" rel="noreferrer">archlinux</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: Looping through the content of a file in Bash (score [1415142](https://stackoverflow.com/q/1521462) in 2018)

#### Question
How do I iterate through each line of a text file with <a href="http://en.wikipedia.org/wiki/Bash" rel="noreferrer">Bash</a>?  

With this script:  

```sh
echo "Start!"
for p in (peptides.txt)
do
    echo "${p}"
done
```

I get this output on the screen:  

```sh
Start!
./runPep.sh: line 3: syntax error near unexpected token `('
./runPep.sh: line 3: `for p in (peptides.txt)'
```

(Later I want to do something more complicated with `$p` than just output to the screen.)  

<hr>

The environment variable <strong>SHELL</strong> is (from env):  

```sh
SHELL=/bin/bash
```

`/bin/bash --version` output:  

```sh
GNU bash, version 3.1.17(1)-release (x86_64-suse-linux-gnu)
Copyright (C) 2005 Free Software Foundation, Inc.
```

`cat /proc/version` output:  

```sh
Linux version 2.6.18.2-34-default (geeko@buildhost) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #1 SMP Mon Nov 27 11:46:27 UTC 2006
```

The file peptides.txt contains:  

```sh
RKEKNVQ
IPKKLLQK
QYFHQLEKMNVK
IPKKLLQK
GDLSTALEVAIDCYEK
QYFHQLEKMNVKIPENIYR
RKEKNVQ
VLAKHGKLQDAIN
ILGFMK
LEDVALQILL
```

#### Answer accepted (score 1891)
One way to do it is:  

```sh
while read p; do
  echo "$p"
done <peptides.txt
```

As pointed out in the comments, this has the side effects of trimming leading whitespace, interpretting backslash sequences, and skipping the trailing line if it's missing a terminating linefeed. If these are concerns, you can do:  

```sh
while IFS="" read -r p || [ -n "$p" ]
do
  printf '%s\n' "$p"
done < peptides.txt
```

<hr>

Exceptionally, if the <a href="https://unix.stackexchange.com/questions/107800/using-while-loop-to-ssh-to-multiple-servers">loop body may read from standard input</a>, you can open the file using a different file descriptor:  

```sh
while read -u 10 p; do
  ...
done 10<peptides.txt
```

Here, 10 is just an arbitrary number (different from 0, 1, 2).  

#### Answer 2 (score 374)
```sh
cat peptides.txt | while read line
do
   # do something with $line here
done
```

and the one-liner variant:  

```sh
cat peptides.txt | while read line; do something_with_$line_here; done
```

#### Answer 3 (score 137)
<strong>Option 1a:</strong> While loop:  Single line at a time:  Input redirection  

```sh
#!/bin/bash
filename='peptides.txt'
echo Start
while read p; do 
    echo $p
done < $filename
```

<p><strong>Option 1b:</strong> While loop:  Single line at a time:<br>
Open the file, read from a file descriptor (in this case file descriptor #4).  </p>

```sh
#!/bin/bash
filename='peptides.txt'
exec 4<$filename
echo Start
while read -u4 p ; do
    echo $p
done
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: Extract filename and extension in Bash (score [1405400](https://stackoverflow.com/q/965053) in 2018)

#### Question
I want to get the filename (without extension) and the extension separately.  

The best solution I found so far is:  

```sh
NAME=`echo "$FILE" | cut -d'.' -f1`
EXTENSION=`echo "$FILE" | cut -d'.' -f2`
```

This is wrong because it doesn't work if the file name contains multiple `.` characters. If, let's say, I have `a.b.js`, it will consider `a` and `b.js`, instead of `a.b` and `js`.  

It can be easily done in Python with  

```sh
file, ext = os.path.splitext(path)
```

but I'd prefer not to fire up a Python interpreter just for this, if possible.  

Any better ideas?  

#### Answer accepted (score 3271)
First, get file name without the path:  

```sh
filename=$(basename -- "$fullfile")
extension="${filename##*.}"
filename="${filename%.*}"
```

Alternatively, you can focus on the last '/' of the path instead of the '.' which should work even if you have unpredictable file extensions:  

```sh
filename="${fullfile##*/}"
```

You may want to check the documentation :  

<ul>
<li>On the web at section "<a href="http://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html" rel="noreferrer">3.5.3 Shell Parameter Expansion</a>"</li>
<li>In the bash manpage at section called "Parameter Expansion"</li>
</ul>

#### Answer 2 (score 602)
```sh
~% FILE="example.tar.gz"
~% echo "${FILE%%.*}"
example
~% echo "${FILE%.*}"
example.tar
~% echo "${FILE#*.}"
tar.gz
~% echo "${FILE##*.}"
gz
```

For more details, see <a href="https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html" rel="noreferrer">shell parameter expansion</a> in the Bash manual.  

#### Answer 3 (score 362)
Usually you already know the extension, so you might wish to use:  

```sh
basename filename .extension
```

for example:  

```sh
basename /path/to/dir/filename.txt .txt
```

and we get  

```sh
filename
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How do I parse command line arguments in Bash? (score [1334093](https://stackoverflow.com/q/192249) in 2019)

#### Question
Say, I have a script that gets called with this line:  

```sh
./myscript -vfd ./foo/bar/someFile -o /fizz/someOtherFile
```

or this one:  

```sh
./myscript -v -f -d -o /fizz/someOtherFile ./foo/bar/someFile 
```

What's the accepted way of parsing this such that in each case (or some combination of the two) `$v`, `$f`, and  `$d` will all be set to `true` and `$outFile` will be equal to `/fizz/someOtherFile` ?  

#### Answer accepted (score 2416)
<strong>Update:</strong> It's been more than 5 years since I started this answer. Thank you for LOTS of great edits/comments/suggestions. In order save maintenance time, I've modified the code block to be 100% copy-paste ready. Please do not post comments like "What if you changed X to Y…". Instead, copy-paste the code block, see the output, make the change, rerun the script, and comment "I changed X to Y and…" I don't have time to test your ideas and tell you if they work.  

<hr>

<h5>Method #1: Using bash without getopt[s]</h1>

Two common ways to pass key-value-pair arguments are:  

<h5>Bash Space-Separated (e.g., `--option argument`) (without getopt[s])</h2>

Usage `demo-space-separated.sh -e conf -s /etc -l /usr/lib /etc/hosts`  



```sh
cat >/tmp/demo-space-separated.sh <<'EOF'
#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -e|--extension)
    EXTENSION="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--searchpath)
    SEARCHPATH="$2"
    shift # past argument
    shift # past value
    ;;
    -l|--lib)
    LIBPATH="$2"
    shift # past argument
    shift # past value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

echo "FILE EXTENSION  = ${EXTENSION}"
echo "SEARCH PATH     = ${SEARCHPATH}"
echo "LIBRARY PATH    = ${LIBPATH}"
echo "DEFAULT         = ${DEFAULT}"
echo "Number files in SEARCH PATH with EXTENSION:" $(ls -1 "${SEARCHPATH}"/*."${EXTENSION}" | wc -l)
if [[ -n $1 ]]; then
    echo "Last line of file specified as non-opt/last argument:"
    tail -1 "$1"
fi
EOF

chmod +x /tmp/demo-space-separated.sh

/tmp/demo-space-separated.sh -e conf -s /etc -l /usr/lib /etc/hosts
```

output from copy-pasting the block above:  

```sh
FILE EXTENSION  = conf
SEARCH PATH     = /etc
LIBRARY PATH    = /usr/lib
DEFAULT         =
Number files in SEARCH PATH with EXTENSION: 14
Last line of file specified as non-opt/last argument:
#93.184.216.34    example.com
```

<h5>Bash Equals-Separated (e.g., `--option=argument`) (without getopt[s])</h2>

Usage `demo-equals-separated.sh -e=conf -s=/etc -l=/usr/lib /etc/hosts`  

```sh
cat >/tmp/demo-equals-separated.sh <<'EOF'
#!/bin/bash

for i in "$@"
do
case $i in
    -e=*|--extension=*)
    EXTENSION="${i#*=}"
    shift # past argument=value
    ;;
    -s=*|--searchpath=*)
    SEARCHPATH="${i#*=}"
    shift # past argument=value
    ;;
    -l=*|--lib=*)
    LIBPATH="${i#*=}"
    shift # past argument=value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument with no value
    ;;
    *)
          # unknown option
    ;;
esac
done
echo "FILE EXTENSION  = ${EXTENSION}"
echo "SEARCH PATH     = ${SEARCHPATH}"
echo "LIBRARY PATH    = ${LIBPATH}"
echo "DEFAULT         = ${DEFAULT}"
echo "Number files in SEARCH PATH with EXTENSION:" $(ls -1 "${SEARCHPATH}"/*."${EXTENSION}" | wc -l)
if [[ -n $1 ]]; then
    echo "Last line of file specified as non-opt/last argument:"
    tail -1 $1
fi
EOF

chmod +x /tmp/demo-equals-separated.sh

/tmp/demo-equals-separated.sh -e=conf -s=/etc -l=/usr/lib /etc/hosts
```

output from copy-pasting the block above:  

```sh
FILE EXTENSION  = conf
SEARCH PATH     = /etc
LIBRARY PATH    = /usr/lib
DEFAULT         =
Number files in SEARCH PATH with EXTENSION: 14
Last line of file specified as non-opt/last argument:
#93.184.216.34    example.com
```

To better understand `${i#*=}` search for "Substring Removal" in <a href="http://tldp.org/LDP/abs/html/string-manipulation.html" rel="noreferrer">this guide</a>. It is functionally equivalent to ``sed 's/[^=]*=//' &lt;&lt;&lt; "$i"`` which calls a needless subprocess or ``echo "$i" | sed 's/[^=]*=//'`` which calls <em>two</em> needless subprocesses.   

<h5>Method #2: Using bash with getopt[s]</h1>

from: <a href="http://mywiki.wooledge.org/BashFAQ/035#getopts" rel="noreferrer">http://mywiki.wooledge.org/BashFAQ/035#getopts</a>  

<strong>getopt(1) limitations</strong> (older, relatively-recent `getopt` versions):   

<ul>
<li>can't handle arguments that are empty strings</li>
<li>can't handle arguments with embedded whitespace</li>
</ul>

More recent `getopt` versions don't have these limitations.  

Additionally, the POSIX shell (and others) offer `getopts` which doesn't have these limitations. I've included a simplistic `getopts` example.  

Usage `demo-getopts.sh -vf /etc/hosts foo bar`  

```sh
cat >/tmp/demo-getopts.sh <<'EOF'
#!/bin/sh

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
output_file=""
verbose=0

while getopts "h?vf:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    v)  verbose=1
        ;;
    f)  output_file=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

echo "verbose=$verbose, output_file='$output_file', Leftovers: $@"
EOF

chmod +x /tmp/demo-getopts.sh

/tmp/demo-getopts.sh -vf /etc/hosts foo bar
```

output from copy-pasting the block above:  

```sh
verbose=1, output_file='/etc/hosts', Leftovers: foo bar
```

The advantages of `getopts` are:  

<ol>
<li>It's more portable, and will work in other shells like `dash`.  </li>
<li>It can handle multiple single options like `-vf filename` in the typical Unix way, automatically.</li>
</ol>

The disadvantage of `getopts` is that it can only handle short options (`-h`, not `--help`) without additional code.  

There is a <a href="http://wiki.bash-hackers.org/howto/getopts_tutorial" rel="noreferrer">getopts tutorial</a> which explains what all of the syntax and variables mean.  In bash, there is also `help getopts`, which might be informative.  

#### Answer 2 (score 490)
<strong>No answer mentions <em>enhanced getopt</em>. And the <a href="https://stackoverflow.com/a/14203146/825924">top-voted answer</a> is misleading:</strong> It either ignores `-⁠vfd` style short options (requested by the OP) or options after positional arguments (also requested by the OP); and it ignores parsing-errors. Instead:  

<ul>
<li><strong>Use enhanced `getopt` from util-linux or formerly GNU glibc</strong>.<sup><sub>1</sub></sup></li>
<li>It works with `getopt_long()` the C function of GNU glibc.</li>
<li>Has <em>all</em> useful distinguishing features (the others don’t have them):

<ul>
<li>handles spaces, quoting characters and even binary in arguments<sup><sub>2</sub></sup> (non-enhanced `getopt` can’t do this)</li>
<li>it can handle options at the end: `script.sh -o outFile file1 file2 -v` (`getopts` doesn’t do this)</li>
<li>allows `=`-style long options: `script.sh --outfile=fileOut --infile fileIn` (allowing both is lengthy if self parsing)</li>
<li>allows combined short options, e.g. `-vfd` (real work if self parsing)</li>
<li>allows touching option-arguments, e.g. `-oOutfile` or `-vfdoOutfile`</li>
</ul></li>
<li>Is so old already<sup><sub>3</sub></sup> that no GNU system is missing this (e.g. any Linux has it).</li>
<li>You can test for its existence with: `getopt --test` → return value 4.</li>
<li>Other `getopt` or shell-builtin `getopts` are of limited use.</li>
</ul>

The following calls  

```sh
myscript -vfd ./foo/bar/someFile -o /fizz/someOtherFile
myscript -v -f -d -o/fizz/someOtherFile -- ./foo/bar/someFile
myscript --verbose --force --debug ./foo/bar/someFile -o/fizz/someOtherFile
myscript --output=/fizz/someOtherFile ./foo/bar/someFile -vfd
myscript ./foo/bar/someFile -df -v --output /fizz/someOtherFile
```

all return  

```sh
verbose: y, force: y, debug: y, in: ./foo/bar/someFile, out: /fizz/someOtherFile
```

with the following `myscript`  

```sh
#!/bin/bash
# saner programming env: these switches turn some bugs into errors
set -o errexit -o pipefail -o noclobber -o nounset

# -allow a command to fail with !’s side effect on errexit
# -use return value from ${PIPESTATUS[0]}, because ! hosed $?
! getopt --test > /dev/null 
if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
    echo 'I’m sorry, `getopt --test` failed in this environment.'
    exit 1
fi

OPTIONS=dfo:v
LONGOPTS=debug,force,output:,verbose

# -regarding ! and PIPESTATUS see above
# -temporarily store output to be able to check for errors
# -activate quoting/enhanced mode (e.g. by writing out “--options”)
# -pass arguments only via   -- "$@"   to separate them correctly
! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    # e.g. return value is 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi
# read getopt’s output this way to handle the quoting right:
eval set -- "$PARSED"

d=n f=n v=n outFile=-
# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        -d|--debug)
            d=y
            shift
            ;;
        -f|--force)
            f=y
            shift
            ;;
        -v|--verbose)
            v=y
            shift
            ;;
        -o|--output)
            outFile="$2"
            shift 2
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Programming error"
            exit 3
            ;;
    esac
done

# handle non-option arguments
if [[ $# -ne 1 ]]; then
    echo "$0: A single input file is required."
    exit 4
fi

echo "verbose: $v, force: $f, debug: $d, in: $1, out: $outFile"
```

<hr>

<p><sup><sub>1</sub></sup> enhanced getopt is available on most “bash-systems”, including Cygwin; on OS X try <a href="https://stackoverflow.com/a/37485578/825924">brew install gnu-getopt</a> or `sudo port install getopt`<br>
<sup><sub>2</sub></sup> the POSIX `exec()` conventions have no reliable way to pass binary NULL in command line arguments; those bytes prematurely end the argument<br>
<sup><sub>3</sub></sup> first version released in 1997 or before (I only tracked it back to 1997)</p>

#### Answer 3 (score 123)
from : <a href="https://web.archive.org/web/20120818044047/http://www.digitalpeer.com/id/parsing" rel="noreferrer">digitalpeer.com</a> with minor modifications  

Usage     ` myscript.sh -p=my_prefix -s=dirname -l=libname`  

```sh
#!/bin/bash
for i in "$@"
do
case $i in
    -p=*|--prefix=*)
    PREFIX="${i#*=}"

    ;;
    -s=*|--searchpath=*)
    SEARCHPATH="${i#*=}"
    ;;
    -l=*|--lib=*)
    DIR="${i#*=}"
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
            # unknown option
    ;;
esac
done
echo PREFIX = ${PREFIX}
echo SEARCH PATH = ${SEARCHPATH}
echo DIRS = ${DIR}
echo DEFAULT = ${DEFAULT}
```

To better understand `${i#*=}` search for "Substring Removal" in <a href="http://tldp.org/LDP/abs/html/string-manipulation.html" rel="noreferrer">this guide</a>. It is functionally equivalent to ``sed 's/[^=]*=//' &lt;&lt;&lt; "$i"`` which calls a needless subprocess or ``echo "$i" | sed 's/[^=]*=//'`` which calls <em>two</em> needless subprocesses.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: YYYY-MM-DD format date in shell script (score [1310931](https://stackoverflow.com/q/1401482) in 2018)

#### Question
I tried using `$(date)` in my bash shell script, however I want the date in YYYY-MM-DD format. How do I get this?  

#### Answer accepted (score 1725)
In bash (>=4.2) it is preferable to use printf's built-in date formatter (part of bash) rather than the external `date` (usually GNU date).  

As such:  

```sh
# put current date as yyyy-mm-dd in $date
# -1 -> explicit current date, bash >=4.3 defaults to current time if not provided
# -2 -> start time for shell
printf -v date '%(%Y-%m-%d)T\n' -1 

# put current date as yyyy-mm-dd HH:MM:SS in $date
printf -v date '%(%Y-%m-%d %H:%M:%S)T\n' -1 

# to print directly remove -v flag, as such:
printf '%(%Y-%m-%d)T\n' -1
# -> current date printed to terminal
```

In bash (&lt;4.2):   

```sh
# put current date as yyyy-mm-dd in $date
date=$(date '+%Y-%m-%d')

# put current date as yyyy-mm-dd HH:MM:SS in $date
date=$(date '+%Y-%m-%d %H:%M:%S')

# print current date directly
echo $(date '+%Y-%m-%d')
```

Other available date formats can be viewed from the <a href="http://man7.org/linux/man-pages/man1/date.1.html" rel="noreferrer">date man pages</a> (for external non-bash specific command):  

```sh
man date
```

#### Answer 2 (score 313)
Try: `$(date +%F)`  

#### Answer 3 (score 80)
You can do something like this:  

```sh
$ date +'%Y-%m-%d'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: How to count lines in a document? (score [1222035](https://stackoverflow.com/q/3137094) in 2015)

#### Question
I have lines like these, and I want to know how many lines I actually have...  

```sh
09:16:39 AM  all    2.00    0.00    4.00    0.00    0.00    0.00    0.00    0.00   94.00
09:16:40 AM  all    5.00    0.00    0.00    4.00    0.00    0.00    0.00    0.00   91.00
09:16:41 AM  all    0.00    0.00    4.00    0.00    0.00    0.00    0.00    0.00   96.00
09:16:42 AM  all    3.00    0.00    1.00    0.00    0.00    0.00    0.00    0.00   96.00
09:16:43 AM  all    0.00    0.00    1.00    0.00    1.00    0.00    0.00    0.00   98.00
09:16:44 AM  all    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
09:16:45 AM  all    2.00    0.00    6.00    0.00    0.00    0.00    0.00    0.00   92.00
```

Is there a way to count them all using linux commands?  

#### Answer accepted (score 1840)
Use `wc`:  

```sh
wc -l <filename>
```

This will output the number of lines in `&lt;filename&gt;`:  

```sh
$ wc -l /dir/file.txt
3272485 /dir/file.txt
```

Or, to omit the `&lt;filename&gt;` from the result use `wc -l &lt; &lt;filename&gt;`:  

```sh
$ wc -l < /dir/file.txt
3272485
```

You can also pipe data to `wc` as well:  

```sh
$ cat /dir/file.txt | wc -l
3272485
$ curl yahoo.com --silent | wc -l
63
```

#### Answer 2 (score 133)
To count all lines use:  

```sh
$ wc -l file
```

To filter and count only lines with pattern use:  

```sh
$ grep -w "pattern" -c file  
```

Or use -v to invert match:  

```sh
$ grep -w "pattern" -c -v file 
```

See the grep man page to take a look at the -e,-i and -x args...  

#### Answer 3 (score 70)
```sh
wc -l <file.txt>
```

Or  

```sh
command | wc -l
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: How to trim whitespace from a Bash variable? (score [1215318](https://stackoverflow.com/q/369758) in 2018)

#### Question
I have a shell script with this code:  

```sh
var=`hg st -R "$path"`
if [ -n "$var" ]; then
    echo $var
fi
```

But the conditional code always executes, because `hg st` always prints at least one newline character.  

<ul>
<li>Is there a simple way to strip whitespace from `$var` (like `trim()` in <a href="http://en.wikipedia.org/wiki/PHP" rel="noreferrer">PHP</a>)?</li>
</ul>

or  

<ul>
<li>Is there a standard way of dealing with this issue?</li>
</ul>

I could use <a href="http://en.wikipedia.org/wiki/Sed" rel="noreferrer">sed</a> or <a href="http://en.wikipedia.org/wiki/AWK" rel="noreferrer">AWK</a>, but I'd like to think there is a more elegant solution to this problem.  

#### Answer 2 (score 961)
Let's define a variable containing leading, trailing, and intermediate whitespace:  

```sh
FOO=' test test test '
echo -e "FOO='${FOO}'"
# > FOO=' test test test '
echo -e "length(FOO)==${#FOO}"
# > length(FOO)==16
```

<hr>

How to remove all whitespace (denoted by `[:space:]` in `tr`):  

```sh
FOO=' test test test '
FOO_NO_WHITESPACE="$(echo -e "${FOO}" | tr -d '[:space:]')"
echo -e "FOO_NO_WHITESPACE='${FOO_NO_WHITESPACE}'"
# > FOO_NO_WHITESPACE='testtesttest'
echo -e "length(FOO_NO_WHITESPACE)==${#FOO_NO_WHITESPACE}"
# > length(FOO_NO_WHITESPACE)==12
```

<hr>

How to remove leading whitespace only:  

```sh
FOO=' test test test '
FOO_NO_LEAD_SPACE="$(echo -e "${FOO}" | sed -e 's/^[[:space:]]*//')"
echo -e "FOO_NO_LEAD_SPACE='${FOO_NO_LEAD_SPACE}'"
# > FOO_NO_LEAD_SPACE='test test test '
echo -e "length(FOO_NO_LEAD_SPACE)==${#FOO_NO_LEAD_SPACE}"
# > length(FOO_NO_LEAD_SPACE)==15
```

<hr>

How to remove trailing whitespace only:  

```sh
FOO=' test test test '
FOO_NO_TRAIL_SPACE="$(echo -e "${FOO}" | sed -e 's/[[:space:]]*$//')"
echo -e "FOO_NO_TRAIL_SPACE='${FOO_NO_TRAIL_SPACE}'"
# > FOO_NO_TRAIL_SPACE=' test test test'
echo -e "length(FOO_NO_TRAIL_SPACE)==${#FOO_NO_TRAIL_SPACE}"
# > length(FOO_NO_TRAIL_SPACE)==15
```

<hr>

How to remove both leading and trailing spaces--chain the `sed`s:  

```sh
FOO=' test test test '
FOO_NO_EXTERNAL_SPACE="$(echo -e "${FOO}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
echo -e "FOO_NO_EXTERNAL_SPACE='${FOO_NO_EXTERNAL_SPACE}'"
# > FOO_NO_EXTERNAL_SPACE='test test test'
echo -e "length(FOO_NO_EXTERNAL_SPACE)==${#FOO_NO_EXTERNAL_SPACE}"
# > length(FOO_NO_EXTERNAL_SPACE)==14
```

Alternatively, if your bash supports it, you can replace `echo -e "${FOO}" | sed ...` with `sed ... &lt;&lt;&lt;${FOO}`, like so (for trailing whitespace):  

```sh
FOO_NO_TRAIL_SPACE="$(sed -e 's/[[:space:]]*$//' <<<${FOO})"
```

#### Answer 3 (score 858)
A simple answer is:  

```sh
echo "   lol  " | xargs
```

<a href="http://en.wikipedia.org/wiki/Xargs">Xargs</a> will do the trimming for you. It's one command/program, no parameters, returns the trimmed string, easy as that!  

Note: this doesn't remove the internal spaces so `"foo bar"` stays the same. It does NOT become `"foobar"`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: How to check if a variable is set in Bash? (score [1161315](https://stackoverflow.com/q/3601515) in 2016)

#### Question
How do I know if a variable is set in Bash?  

For example, how do I check if the user gave the first parameter to a function?  

```sh
function a {
    # if $1 is set ?
}
```

#### Answer accepted (score 2067)
<h5>(Usually) The right way</h2>

```sh
if [ -z ${var+x} ]; then echo "var is unset"; else echo "var is set to '$var'"; fi
```

where `${var+x}` is a <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02" rel="noreferrer">parameter expansion</a> which evaluates to nothing if `var` is unset, and substitutes the string `x` otherwise.  

<h5>Quotes Digression</h3>

Quotes can be omitted (so we can say `${var+x}` instead of `"${var+x}"`) because this syntax &amp; usage guarantees this will only expand to something that does not require quotes (since it either expands to `x` (which contains no word breaks so it needs no quotes), or to nothing (which results in `[ -z  ]`, which conveniently evaluates to the same value (true) that `[ -z "" ]` does as well)).  

However, while quotes can be safely omitted, and it was not immediately obvious to all (it wasn't even apparent to <a href="https://stackoverflow.com/users/2255628/destiny-architect">the first author of this quotes explanation</a> who is also a major Bash coder), it would sometimes be better to write the solution with quotes as `[ -z "${var+x}" ]`, at the very small possible cost of an O(1) speed penalty.  The first author also added this as a comment next to the code using this solution giving the URL to this answer, which now also includes the explanation for why the quotes can be safely omitted.  

<h5>(Often) The wrong way</h2>

```sh
if [ -z "$var" ]; then echo "var is blank"; else echo "var is set to '$var'"; fi
```

This is often wrong because it doesn't distinguish between a variable that is unset and a variable that is set to the empty string. That is to say, if `var=''`, then the above solution will output "var is blank".   

The distinction between unset and "set to the empty string" is essential in situations where the user has to specify an extension, or additional list of properties, and that not specifying them defaults to a non-empty value, whereas specifying the empty string should make the script use an empty extension or list of additional properties.  

The distinction may not be essential in every scenario though. In those cases  `[ -z "$var" ]` will be just fine.   

  

#### Answer 2 (score 816)
To check for non-null/non-zero string variable, i.e. if set, use  

```sh
if [ -n "$1" ]
```

It's the opposite of `-z`.  I find myself using `-n` more than `-z`.  

You would use it like:   

```sh
if [ -n "$1" ]; then
  echo "You supplied the first parameter!"
else
  echo "First parameter not supplied."
fi
```

#### Answer 3 (score 440)
Here's how to test whether a parameter is <strong>unset</strong>, or <strong>empty ("Null")</strong> or <strong>set with a value</strong>:  

```sh
+--------------------+----------------------+-----------------+-----------------+
|                    |       parameter      |     parameter   |    parameter    |
|                    |   Set and Not Null   |   Set But Null  |      Unset      |
+--------------------+----------------------+-----------------+-----------------+
| ${parameter:-word} | substitute parameter | substitute word | substitute word |
| ${parameter-word}  | substitute parameter | substitute null | substitute word |
| ${parameter:=word} | substitute parameter | assign word     | assign word     |
| ${parameter=word}  | substitute parameter | substitute null | assign word     |
| ${parameter:?word} | substitute parameter | error, exit     | error, exit     |
| ${parameter?word}  | substitute parameter | substitute null | error, exit     |
| ${parameter:+word} | substitute word      | substitute null | substitute null |
| ${parameter+word}  | substitute word      | substitute word | substitute null |
+--------------------+----------------------+-----------------+-----------------+
```

Source: <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02">POSIX: Parameter Expansion</a>:  

<blockquote>
  In all cases shown with "substitute", the expression is replaced with the value shown. In all cases shown with "assign", parameter is assigned that value, which also replaces the expression.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: How to compare strings in Bash (score [1126175](https://stackoverflow.com/q/2237080) in 2018)

#### Question
How do I compare a variable to a string (and do something if they match)?  

#### Answer accepted (score 1265)
<h5>Using variables in if statements</h1>

```sh
if [ "$x" = "valid" ]; then
  echo "x has the value 'valid'"
fi
```

If you want to do something when they don't match, replace `=` with `!=`. You can read more about <a href="http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-11.html#ss11.1" rel="noreferrer">string operations</a> and <a href="http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-11.html#ss11.3" rel="noreferrer">arithmetic operations</a> in their respective documentation.  

<h5>Why do we use quotes around `$x`?</h3>

You want the quotes around `$x`, because if it is empty, your bash script encounters a syntax error as seen below:  

```sh
if [ = "valid" ]; then
```

<hr>

<h5>Non-standard use of `==` operator</h3>

Note that `bash` allows `==` to be used for equality with `[`, but <a href="http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-6.html" rel="noreferrer">this is not standard</a>.  

Use either the first case wherein the quotes around `$x` are optional:  

```sh
if [[ "$x" == "valid" ]]; then
```

or use the second case:  

```sh
if [ "$x" = "valid" ]; then
```

#### Answer 2 (score 132)
Or, if you don't need else clause:  

```sh
[ "$x" == "valid" ] && echo "x has the value 'valid'"
```

#### Answer 3 (score 70)
```sh
a="abc"
b="def"

# Equality Comparison
if [ "$a" == "$b" ]; then
    echo "Strings match"
else
    echo "Strings don't match"
fi

# Lexicographic (greater than, less than) comparison.
if [ "$a" \< "$b" ]; then
    echo "$a is lexicographically smaller then $b"
elif [ "$a" \> "$b" ]; then
    echo "$b is lexicographically smaller than $a"
else
    echo "Strings are equal"
fi
```

<strong>Notes:</strong>  

<ol>
<li>Spaces between `if` and `[` and `]` are important</li>
<li>`&gt;` and `&lt;` are redirection operators so escape it with `\&gt;` and `\&lt;` respectively for strings.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Extract substring in Bash (score [1122542](https://stackoverflow.com/q/428109) in 2017)

#### Question
Given a filename in the form `someletters_12345_moreleters.ext`, I want to extract the 5 digits and put them into a variable.  

So to emphasize the point, I have a filename with x number of characters then a five digit sequence surrounded by a single underscore on either side then another set of x number of characters.  I want to take the 5 digit number and put that into a variable.  

I am very interested in the number of different ways that this can be accomplished.  

#### Answer accepted (score 638)
Use <a href="http://www.manpagez.com/man/1/cut/" rel="noreferrer">cut</a>:  

```sh
echo 'someletters_12345_moreleters.ext' | cut -d'_' -f 2
```

More generic:  

```sh
INPUT='someletters_12345_moreleters.ext'
SUBSTRING=$(echo $INPUT| cut -d'_' -f 2)
echo $SUBSTRING
```

#### Answer 2 (score 1012)
If <em>x</em> is constant, the following parameter expansion performs substring extraction:  

```sh
b=${a:12:5}
```

where <strong>12</strong> is the offset (zero-based) and <strong>5</strong> is the length  

If the underscores around the digits are the only ones in the input, you can strip off the prefix and suffix (respectively) in two steps:  

```sh
tmp=${a#*_}   # remove prefix ending in "_"
b=${tmp%_*}   # remove suffix starting with "_"
```

If there are other underscores, it's probably feasible anyway, albeit more tricky.  If anyone knows how to perform both expansions in a single expression, I'd like to know too.  

Both solutions presented are pure bash, with no process spawning involved, hence very fast.  

#### Answer 3 (score 91)
Generic solution where the number can be anywhere in the filename, using the first of such sequences:  

```sh
number=$(echo $filename | egrep -o '[[:digit:]]{5}' | head -n1)
```

Another solution to extract exactly a part of a variable:  

```sh
number=${filename:offset:length}
```

If your filename always have the format `stuff_digits_...` you can use awk:  

```sh
number=$(echo $filename | awk -F _ '{ print $2 }')
```

Yet another solution to remove everything except digits, use  

```sh
number=$(echo $filename | tr -cd '[[:digit:]]')
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: Check existence of input argument in a Bash shell script (score [1105101](https://stackoverflow.com/q/6482377) in 2018)

#### Question
I need to check the existence of an input argument. I have the following script  

```sh
if [ "$1" -gt "-1" ]
  then echo hi
fi
```

I get  

```sh
[: : integer expression expected
```

How do I check the input argument1 first to see if it exists?  

#### Answer accepted (score 2060)
It is:  

```sh
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
fi
```

The `$#` variable will tell you the number of input arguments the script was passed.  

Or you can check if an argument is an empty string or not like:  

```sh
if [ -z "$1" ]
  then
    echo "No argument supplied"
fi
```

The `-z` switch will test if the expansion of "$1" is a null string or not. If it is a null string then the body is executed.  

#### Answer 2 (score 305)
It is better to demonstrate this way  

```sh
if [[ $# -eq 0 ]] ; then
    echo 'some message'
    exit 1
fi
```

You normally need to exit if you have too few arguments.  

#### Answer 3 (score 92)
In some cases you need to check whether the user passed an argument to the script and if not, fall back to a default value. Like in the script below:  

```sh
scale=${2:-1}
emulator @$1 -scale $scale
```

Here if the user hasn't passed `scale` as a 2nd parameter, I launch Android emulator with `-scale 1` by default. `${varname:-word}` is an expansion operator. There are other expansion operators as well:  

<ul>
<li>`${varname:=word}` which <em>sets</em> the undefined `varname` instead of returning the `word` value;</li>
<li>`${varname:?message}` which either returns `varname` if it's defined and is not null or prints the `message` and aborts the script (like the first example);</li>
<li>`${varname:+word}` which returns `word` only if `varname` is defined and is not null; returns null otherwise.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: Loop through an array of strings in Bash? (score [1090850](https://stackoverflow.com/q/8880603) in 2019)

#### Question
I want to write a script that loops through 15 strings (array possibly?) Is that possible?  

Something like:  

```sh
for databaseName in listOfNames
then
  # Do something
end
```

#### Answer accepted (score 2144)
You can use it like this:  

```sh
## declare an array variable
declare -a arr=("element1" "element2" "element3")

## now loop through the above array
for i in "${arr[@]}"
do
   echo "$i"
   # or do whatever with individual element of the array
done

# You can access them using echo "${arr[0]}", "${arr[1]}" also
```

Also works for multi-line array declaration  

```sh
declare -a arr=("element1" 
                "element2" "element3"
                "element4"
                )
```

#### Answer 2 (score 709)
That is possible, of course.  

```sh
for databaseName in a b c d e f; do
  # do something like: echo $databaseName
done 
```

See <a href="http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-7.html" rel="noreferrer">Bash Loops for, while and until</a> for details.  

#### Answer 3 (score 179)
None of those answers include a counter...  

```sh
#!/bin/bash
## declare an array variable
declare -a array=("one" "two" "three")

# get length of an array
arraylength=${#array[@]}

# use for loop to read all values and indexes
for (( i=1; i<${arraylength}+1; i++ ));
do
  echo $i " / " ${arraylength} " : " ${array[$i-1]}
done
```

Output:  

```sh
1  /  3  :  one
2  /  3  :  two
3  /  3  :  three
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: In the shell, what does " 2>&1 " mean? (score [1016179](https://stackoverflow.com/q/818255) in 2018)

#### Question
In a Unix shell, if I want to combine `stderr` and `stdout` into the `stdout` stream for further manipulation, I can append the following on the end of my command:  

```sh
2>&1
```

So, if I want to use `head` on the output from `g++`, I can do something like this:  

```sh
g++ lots_of_errors 2>&1 | head
```

so I can see only the first few errors.   

I always have trouble remembering this, and I constantly have to go look it up, and it is mainly because I don't fully understand the syntax of this particular trick.  

Can someone break this up and explain character by character what `2&gt;&amp;1`  means?  

#### Answer accepted (score 2329)
<p>File descriptor 1 is the standard output (`stdout`).<br>
File descriptor 2 is the standard error (`stderr`).</p>

Here is one way to remember this construct (although it is not entirely accurate): at first, `2&gt;1` may look like a good way to redirect `stderr` to `stdout`. However, it will actually be interpreted as "redirect `stderr` to a file named `1`". `&amp;` indicates that what follows is a file descriptor and not a filename. So the construct becomes: `2&gt;&amp;1`.  

#### Answer 2 (score 577)
```sh
echo test > afile.txt
```

redirects stdout to `afile.txt`. This is the same as doing  

```sh
echo test 1> afile.txt
```

To redirect stderr, you do:  

```sh
echo test 2> afile.txt
```

`&gt;&amp;` is the syntax to redirect a stream to another file descriptor - 0 is stdin, 1 is stdout, and 2 is stderr.  

You can redirect stdout to stderr by doing:  

```sh
echo test 1>&2 # or echo test >&2
```

Or vice versa:  

```sh
echo test 2>&1
```

So, in short... `2&gt;` redirects stderr to an (unspecified) file, appending `&amp;1` redirects stderr to stdout.  

#### Answer 3 (score 304)


<h5>Some tricks about redirection</h2>

Some syntax particularity about this may have important behaviours. There is some little samples about redirections, `STDERR`, `STDOUT`, and arguments <strong>ordering</strong>.  

<h5>1  - Overwriting or appending? </h3>

Symbol `&gt;` mean <em>redirection</em>.  

<ul>
<li>`&gt;` mean <em>send to as a whole completed file</em>, overwriting target if exist (see `noclobber` bash feature at <em>#3</em> later).</li>
<li>`&gt;&gt;` mean <em>send in addition to</em> would append to target if exist.</li>
</ul>

In any case, the file would be created if they not exist.  

<h5>2  - The <em>shell command line</em> is order dependent!!</h3>

For testing this, we need <em>a simple command which will send something on both outputs</em>:  

```sh
$ ls -ld /tmp /tnt
ls: cannot access /tnt: No such file or directory
drwxrwxrwt 118 root root 196608 Jan  7 11:49 /tmp

$ ls -ld /tmp /tnt >/dev/null
ls: cannot access /tnt: No such file or directory

$ ls -ld /tmp /tnt 2>/dev/null
drwxrwxrwt 118 root root 196608 Jan  7 11:49 /tmp
```

(Expecting you don't have a directory named `/tnt`, of course ;). Well, we have it!!  

So, let's see:  

```sh
$ ls -ld /tmp /tnt >/dev/null
ls: cannot access /tnt: No such file or directory

$ ls -ld /tmp /tnt >/dev/null 2>&1

$ ls -ld /tmp /tnt 2>&1 >/dev/null
ls: cannot access /tnt: No such file or directory
```

The last command line dumps `STDERR` to the console, and it seem not to be the expected behaviour... But...  

If you want to make some <em>post filtering</em> about one output, the other or both:  

```sh
$ ls -ld /tmp /tnt | sed 's/^.*$/<-- & --->/'
ls: cannot access /tnt: No such file or directory
<-- drwxrwxrwt 118 root root 196608 Jan  7 12:02 /tmp --->

$ ls -ld /tmp /tnt 2>&1 | sed 's/^.*$/<-- & --->/'
<-- ls: cannot access /tnt: No such file or directory --->
<-- drwxrwxrwt 118 root root 196608 Jan  7 12:02 /tmp --->

$ ls -ld /tmp /tnt >/dev/null | sed 's/^.*$/<-- & --->/'
ls: cannot access /tnt: No such file or directory

$ ls -ld /tmp /tnt >/dev/null 2>&1 | sed 's/^.*$/<-- & --->/'

$ ls -ld /tmp /tnt 2>&1 >/dev/null | sed 's/^.*$/<-- & --->/'
<-- ls: cannot access /tnt: No such file or directory --->
```

Notice that the last command line in this paragraph is exactly same as in previous paragraph, where I wrote <em>seem not to be the expected behaviour</em> (so, this could even be an expected behaviour).  

<p>Well, there is a little tricks about redirections, for
<strong>doing different operation on both outputs</strong>:</p>

```sh
$ ( ls -ld /tmp /tnt | sed 's/^/O: /' >&9 ) 9>&2  2>&1  | sed 's/^/E: /'
O: drwxrwxrwt 118 root root 196608 Jan  7 12:13 /tmp
E: ls: cannot access /tnt: No such file or directory
```

Nota: `&amp;9` descriptor would occur spontaneously because of `) 9&gt;&amp;2`.  

<strong>Addendum: nota!</strong> With the new version of <a href="/questions/tagged/bash" class="post-tag" title="show questions tagged &#39;bash&#39;" rel="tag">bash</a> (`&gt;4.0`) there is a new feature and more sexy syntax for doing this kind of things:  

```sh
$ ls -ld /tmp /tnt 2> >(sed 's/^/E: /') > >(sed 's/^/O: /')
O: drwxrwxrwt 17 root root 28672 Nov  5 23:00 /tmp
E: ls: cannot access /tnt: No such file or directory
```

And finally for such a cascading output formatting:  

```sh
$ ((ls -ld /tmp /tnt |sed 's/^/O: /' >&9 ) 2>&1 |sed 's/^/E: /') 9>&1| cat -n
     1  O: drwxrwxrwt 118 root root 196608 Jan  7 12:29 /tmp
     2  E: ls: cannot access /tnt: No such file or directory
```

<strong>Addendum: nota!</strong> Same new syntax, in both ways:  

```sh
$ cat -n <(ls -ld /tmp /tnt 2> >(sed 's/^/E: /') > >(sed 's/^/O: /'))
     1  O: drwxrwxrwt 17 root root 28672 Nov  5 23:00 /tmp
     2  E: ls: cannot access /tnt: No such file or directory
```

Where `STDOUT` go through a specific filter, `STDERR` to another and finally both outputs merged go through a third command filter.  

<h5>3 - A word about `noclobber` option and `&gt;|` syntax</h3>

That's about <strong>overwriting</strong>:  

While `set -o noclobber` instruct bash to <strong>not</strong> overwrite any existing file, the `&gt;|` syntax let you pass through this limitation:  

```sh
$ testfile=$(mktemp /tmp/testNoClobberDate-XXXXXX)

$ date > $testfile ; cat $testfile
Mon Jan  7 13:18:15 CET 2013

$ date > $testfile ; cat $testfile
Mon Jan  7 13:18:19 CET 2013

$ date > $testfile ; cat $testfile
Mon Jan  7 13:18:21 CET 2013
```

The file is overwritten each time, well now:  

```sh
$ set -o noclobber

$ date > $testfile ; cat $testfile
bash: /tmp/testNoClobberDate-WW1xi9: cannot overwrite existing file
Mon Jan  7 13:18:21 CET 2013

$ date > $testfile ; cat $testfile
bash: /tmp/testNoClobberDate-WW1xi9: cannot overwrite existing file
Mon Jan  7 13:18:21 CET 2013
```

Pass through with `&gt;|`:  

```sh
$ date >| $testfile ; cat $testfile
Mon Jan  7 13:18:58 CET 2013

$ date >| $testfile ; cat $testfile
Mon Jan  7 13:19:01 CET 2013
```

Unsetting this option and/or inquiring if already set.  

```sh
$ set -o | grep noclobber
noclobber           on

$ set +o noclobber

$ set -o | grep noclobber
noclobber           off

$ date > $testfile ; cat $testfile
Mon Jan  7 13:24:27 CET 2013

$ rm $testfile
```

<h5>4 - Last trick and more...</h3>

For redirecting <strong>both</strong> output from a given command, we see that a right syntax could be:  

```sh
$ ls -ld /tmp /tnt >/dev/null 2>&1
```

for this <em>special</em> case, there is a shortcut syntax: `&amp;&gt;` ... or `&gt;&amp;`  

```sh
$ ls -ld /tmp /tnt &>/dev/null

$ ls -ld /tmp /tnt >&/dev/null
```

Nota: if <strong>`2&gt;&amp;1`</strong> exist, <strong>`1&gt;&amp;2`</strong> is a correct syntax too:  

```sh
$ ls -ld /tmp /tnt 2>/dev/null 1>&2
```

<h5>4b- Now, I will let you think about:</h3>

```sh
$ ls -ld /tmp /tnt 2>&1 1>&2  | sed -e s/^/++/
++/bin/ls: cannot access /tnt: No such file or directory
++drwxrwxrwt 193 root root 196608 Feb  9 11:08 /tmp/

$ ls -ld /tmp /tnt 1>&2 2>&1  | sed -e s/^/++/
/bin/ls: cannot access /tnt: No such file or directory
drwxrwxrwt 193 root root 196608 Feb  9 11:08 /tmp/
```

<h5>4c- If you're interested in <em>more</em> information</h3>

You could read the fine manual by hitting:  

```sh
man -Len -Pless\ +/^REDIRECTION bash
```

in a <a href="/questions/tagged/bash" class="post-tag" title="show questions tagged &#39;bash&#39;" rel="tag">bash</a> console ;-)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: Redirect all output to file (score [1007650](https://stackoverflow.com/q/6674327) in 2015)

#### Question
I know that in Linux, to redirect output from the screen to a file, I can either use the `&gt;` or `tee`. However, I'm not sure why part of the output is still output to the screen and not written to the file.   

Is there a way to redirect all output to file?  

#### Answer accepted (score 1122)
That part is written to stderr, use `2&gt;` to redirect it. For example:  

```sh
foo > stdout.txt 2> stderr.txt
```

or if you want in same file:  

```sh
foo > allout.txt 2>&1
```

Note: this works in (ba)sh, check your shell for proper syntax  

#### Answer 2 (score 141)
All POSIX operating systems <a href="http://en.wikipedia.org/wiki/Standard_streams" rel="noreferrer">have 3 streams</a>: stdin, stdout, and stderr. stdin is the input, which can accept the stdout or stderr. stdout is the primary output, which is redirected with `&gt;`, `&gt;&gt;`, or `|`. stderr is the error output, which is handled separately so that any exceptions do not get passed to a command or written to a file that it might break; normally, this is sent to a log of some kind, or dumped directly, even when the stdout is redirected. To redirect both to the same place, use:  

<strike>`<em>command</em> &amp;> /some/file`</strike>  

<strong>EDIT</strong>: thanks to Zack for pointing out that the above solution is not portable--use instead:      

```sh
*command* > file 2>&1 
```

If you want to silence the error, do:  

```sh
*command* 2> /dev/null
```

#### Answer 3 (score 84)
To get the output on the console AND in a file `file.txt` for example.  

```sh
make 2>&1 | tee file.txt
```

Note: `&amp;` (in `2&gt;&amp;1`) specifies that `1` is not a file name but a file descriptor.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: How do I compare two string variables in an 'if' statement in Bash? (score [1001718](https://stackoverflow.com/q/4277665) in 2018)

#### Question
I'm trying to get an `if` statement to work in <a href="http://en.wikipedia.org/wiki/Bash_%28Unix_shell%29" rel="noreferrer">Bash</a> (using <a href="http://en.wikipedia.org/wiki/Ubuntu_%28operating_system%29" rel="noreferrer">Ubuntu</a>):  

```sh
#!/bin/bash

s1="hi"
s2="hi"

if ["$s1" == "$s2"]
then
  echo match
fi
```

I've tried various forms of the `if` statement, using `[["$s1" == "$s2"]]`, with and without quotes, using `=`, `==` and `-eq`, but I still get the following error:  

<blockquote>
  [hi: command not found  
</blockquote>

I've looked at various sites and tutorials and copied those, but it doesn't work - what am I doing wrong?  

Eventually, I want to say if `$s1` contains `$s2`, so how can I do that?  

I did just work out the spaces bit.. :/ How do I say contains?  

I tried  

```sh
if [[ "$s1" == "*$s2*" ]]
```

but it didn't work.  

#### Answer accepted (score 789)
For string comparison, use:  

```sh
if [ "$s1" == "$s2" ]
```

For the `a` contains `b`, use:  

```sh
if [[ $s1 == *"$s2"* ]]
```

(and make sure to add spaces between the symbols):  

bad:  

```sh
if ["$s1" == "$s2"]
```

good:  

```sh
if [ "$s1" == "$s2" ]
```

#### Answer 2 (score 156)
You need spaces:  

```sh
if [ "$s1" == "$s2" ]
```

#### Answer 3 (score 139)
You should be careful to leave a space between the sign of '[' and double quotes where the variable contains this:  

```sh
if [ "$s1" == "$s2" ]; then
#   ^     ^  ^     ^
   echo match
fi
```

The `^`s show the blank spaces you need to leave.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: How do I iterate over a range of numbers defined by variables in Bash? (score [997426](https://stackoverflow.com/q/169511) in 2018)

#### Question
How do I iterate over a range of numbers in Bash when the range is given by a variable?  

I know I can do this (called "sequence expression" in the Bash <a href="http://www.gnu.org/software/bash/manual/bashref.html#Brace-Expansion" rel="noreferrer">documentation</a>):  

```sh
 for i in {1..5}; do echo $i; done
```

Which gives:  

<blockquote>
  <p>1 <br/>
  2 <br/>
  3 <br/>
  4 <br/>
  5</p>
</blockquote>

Yet, how can I replace either of the range endpoints with a variable? This doesn't work:  

```sh
END=5
for i in {1..$END}; do echo $i; done
```

Which prints:  

<blockquote>
  {1..5}  
</blockquote>

#### Answer accepted (score 1536)
```sh
for i in $(seq 1 $END); do echo $i; done```

edit: I prefer `seq` over the other methods because I can actually remember it ;)  

#### Answer 2 (score 407)
The `seq` method is the simplest, but Bash has built-in arithmetic evaluation.  

```sh
END=5
for ((i=1;i<=END;i++)); do
    echo $i
done
# ==> outputs 1 2 3 4 5 on separate lines
```

The `for ((expr1;expr2;expr3));` construct works just like `for (expr1;expr2;expr3)` in C and similar languages, and like other `((expr))` cases, Bash treats them as arithmetic.  

#### Answer 3 (score 178)
<h5>discussion</h3>

Using `seq` is fine, as Jiaaro suggested. Pax Diablo suggested a Bash loop to avoid calling a subprocess, with the additional advantage of being more memory friendly if $END is too large. Zathrus spotted a typical bug in the loop implementation, and also hinted that since `i` is a text variable, continuous conversions to-and-fro numbers are performed with an associated slow-down.  

<h5>integer arithmetic</h3>

This is an improved version of the Bash loop:  

```sh
typeset -i i END
let END=5 i=1
while ((i<=END)); do
    echo $i
    …
    let i++
done
```

If the only thing that we want is the `echo`, then we could write `echo $((i++))`.  

<a href="https://stackoverflow.com/questions/169511/how-do-i-iterate-over-a-range-of-numbers-in-bash#171041">ephemient</a> taught me something: Bash allows `for ((expr;expr;expr))` constructs. Since I've never read the whole man page for Bash (like I've done with the Korn shell (`ksh`) man page, and that was a long time ago), I missed that.  

So,  

```sh
typeset -i i END # Let's be explicit
for ((i=1;i<=END;++i)); do echo $i; done
```

seems to be the most memory-efficient way (it won't be necessary to allocate memory to consume `seq`'s output, which could be a problem if END is very large), although probably not the “fastest”.  

<h5>the initial question</h3>

eschercycle noted that the {<em>a</em>..<em>b</em>} Bash notation works only with literals; true, accordingly to the Bash manual. One can overcome this obstacle with a single (internal) `fork()` without an `exec()` (as is the case with calling `seq`, which being another image requires a fork+exec):  

```sh
for i in $(eval echo "{1..$END}"); do
```

Both `eval` and `echo` are Bash builtins, but a `fork()` is required for the command substitution (the `$(…)` construct).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: Passing parameters to a Bash function (score [960488](https://stackoverflow.com/q/6212219) in 2017)

#### Question
I am trying to search how to pass parameters in a Bash function, but what comes up is always how to pass parameter from the command line.   

I would like to pass parameters within my script. I tried:  

```sh
myBackupFunction("..", "...", "xx")

function myBackupFunction($directory, $options, $rootPassword) {
     ...
}
```

But the syntax is not correct, how to pass a parameter to my function?  

#### Answer accepted (score 1473)
There are two typical ways of declaring a function. I prefer the second approach.  

```sh
function function_name {
   command...
} 
```

or   

```sh
function_name () {
   command...
} 
```

To call a function with arguments:  

```sh
function_name "$arg1" "$arg2"
```

The function refers to passed arguments by their position (not by name), that is $1, $2, and so forth. <strong>$0</strong> is the name of the script itself.  

Example:  

```sh
function_name () {
   echo "Parameter #1 is $1"
}
```

Also, you need to call your function <strong>after</strong> it is declared.   

```sh
#!/usr/bin/env sh

foo 1  # this will fail because foo has not been declared yet.

foo() {
    echo "Parameter #1 is $1"
}

foo 2 # this will work.
```

<strong>Output:</strong>  

```sh
./myScript.sh: line 2: foo: command not found
Parameter #1 is 2
```

<a href="http://tldp.org/LDP/abs/html/complexfunct.html" rel="noreferrer">Reference: Advanced Bash-Scripting Guide</a>.  

#### Answer 2 (score 58)
Knowledge of high level programming languages (C/C++/Java/PHP/Python/Perl ...) would suggest to the layman that bash functions should work like they do in those other languages. <em>Instead</em>, bash functions work like shell commands and expect arguments to be passed to them in the same way one might pass an option to a shell command (ls -l). In effect, <em>function arguments</em> in bash are treated as <em>positional parameters</em> (`$1, $2..$9, ${10}, ${11}`, and so on). This is no surprise considering how `getopts` works. Parentheses are not required to call a function in bash.  

<hr>

(<strong>Note</strong>: I happen to be working on Open Solaris at the moment.)  

```sh
# bash style declaration for all you PHP/JavaScript junkies. :-)
# $1 is the directory to archive
# $2 is the name of the tar and zipped file when all is done.
function backupWebRoot ()
{
    tar -cvf - $1 | zip -n .jpg:.gif:.png $2 - 2>> $errorlog &&
        echo -e "\nTarball created!\n"
}


# sh style declaration for the purist in you. ;-)
# $1 is the directory to archive
# $2 is the name of the tar and zipped file when all is done.
backupWebRoot ()
{
    tar -cvf - $1 | zip -n .jpg:.gif:.png $2 - 2>> $errorlog &&
        echo -e "\nTarball created!\n"
}


#In the actual shell script
#$0               $1            $2

backupWebRoot ~/public/www/ webSite.tar.zip
```

#### Answer 3 (score 42)
If you prefer named parameters, it's possible (with a few tricks) to actually pass named parameters to functions (also makes it possible to pass arrays and references).  

The method I developed allows you to define named parameters passed to a function like this:  

```sh
function example { args : string firstName , string lastName , integer age } {
  echo "My name is ${firstName} ${lastName} and I am ${age} years old."
}
```

You can also annotate arguments as @required or @readonly, create ...rest arguments, create arrays from sequential arguments (using e.g. `string[4]`) and optionally list the arguments in multiple lines:  

```sh
function example {
  args
    : @required string firstName
    : string lastName
    : integer age
    : string[] ...favoriteHobbies

  echo "My name is ${firstName} ${lastName} and I am ${age} years old."
  echo "My favorite hobbies include: ${favoriteHobbies[*]}"
}
```

In other words, not only you can call your parameters by their names (which makes up for a more readable core), you can actually pass arrays (and references to variables - this feature works only in bash 4.3 though)! Plus, the mapped variables are all in the local scope, just as $1 (and others).   

The code that makes this work is pretty light and works both in bash 3 and bash 4 (these are the only versions I've tested it with). If you're interested in more tricks like this that make developing with bash much nicer and easier, you can take a look at my <a href="https://github.com/niieani/bash-oo-framework" rel="noreferrer">Bash Infinity Framework</a>, the code below is available as one of its functionalities.  

```sh
shopt -s expand_aliases

function assignTrap {
  local evalString
  local -i paramIndex=${__paramIndex-0}
  local initialCommand="${1-}"

  if [[ "$initialCommand" != ":" ]]
  then
    echo "trap - DEBUG; eval \"${__previousTrap}\"; unset __previousTrap; unset __paramIndex;"
    return
  fi

  while [[ "${1-}" == "," || "${1-}" == "${initialCommand}" ]] || [[ "${#@}" -gt 0 && "$paramIndex" -eq 0 ]]
  do
    shift # first colon ":" or next parameter's comma ","
    paramIndex+=1
    local -a decorators=()
    while [[ "${1-}" == "@"* ]]
    do
      decorators+=( "$1" )
      shift
    done

    local declaration=
    local wrapLeft='"'
    local wrapRight='"'
    local nextType="$1"
    local length=1

    case ${nextType} in
      string | boolean) declaration="local " ;;
      integer) declaration="local -i" ;;
      reference) declaration="local -n" ;;
      arrayDeclaration) declaration="local -a"; wrapLeft= ; wrapRight= ;;
      assocDeclaration) declaration="local -A"; wrapLeft= ; wrapRight= ;;
      "string["*"]") declaration="local -a"; length="${nextType//[a-z\[\]]}" ;;
      "integer["*"]") declaration="local -ai"; length="${nextType//[a-z\[\]]}" ;;
    esac

    if [[ "${declaration}" != "" ]]
    then
      shift
      local nextName="$1"

      for decorator in "${decorators[@]}"
      do
        case ${decorator} in
          @readonly) declaration+="r" ;;
          @required) evalString+="[[ ! -z \$${paramIndex} ]] || echo \"Parameter '$nextName' ($nextType) is marked as required by '${FUNCNAME[1]}' function.\"; " >&2 ;;
          @global) declaration+="g" ;;
        esac
      done

      local paramRange="$paramIndex"

      if [[ -z "$length" ]]
      then
        # ...rest
        paramRange="{@:$paramIndex}"
        # trim leading ...
        nextName="${nextName//\./}"
        if [[ "${#@}" -gt 1 ]]
        then
          echo "Unexpected arguments after a rest array ($nextName) in '${FUNCNAME[1]}' function." >&2
        fi
      elif [[ "$length" -gt 1 ]]
      then
        paramRange="{@:$paramIndex:$length}"
        paramIndex+=$((length - 1))
      fi

      evalString+="${declaration} ${nextName}=${wrapLeft}\$${paramRange}${wrapRight}; "

      # continue to the next param:
      shift
    fi
  done
  echo "${evalString} local -i __paramIndex=${paramIndex};"
}

alias args='local __previousTrap=$(trap -p DEBUG); trap "eval \"\$(assignTrap \$BASH_COMMAND)\";" DEBUG;'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: How to specify the private SSH-key to use when executing shell command on Git? (score [927267](https://stackoverflow.com/q/4565700) in 2018)

#### Question
A rather unusual situation perhaps, but I want to specify a private SSH-key to use when executing a shell (git) command from the local computer.  

Basically like this:   

```sh
git clone git@github.com:TheUser/TheProject.git -key "/home/christoffer/ssh_keys/theuser"
```

Or even better (in Ruby):  

```sh
with_key("/home/christoffer/ssh_keys/theuser") do
  sh("git clone git@github.com:TheUser/TheProject.git")
end
```

I have seen examples of connecting to a remote server with Net::SSH that uses a specified private key, but this is a local command. Is it possible?  

#### Answer accepted (score 690)
Something like this should work (suggested by orip):  

```sh
ssh-agent bash -c 'ssh-add /somewhere/yourkey; git clone git@github.com:user/project.git'
```

if you prefer subshells, you could try the following (though it is more fragile):  

```sh
ssh-agent $(ssh-add /somewhere/yourkey; git clone git@github.com:user/project.git)
```

Git will invoke SSH which will find its agent by environment variable; this will, in turn, have the key loaded.  

Alternatively, setting `HOME` may also do the trick, provided you are willing to setup a directory that contains only a `.ssh` directory as `HOME`; this may either contain an identity.pub, or a <a href="http://linux.die.net/man/5/ssh_config" rel="noreferrer">config file</a> setting IdentityFile.  

#### Answer 2 (score 1075)
None of these solutions worked for me.   

Instead, I elaborate on @Martin v. Löwis  's mention of setting a `config` file for SSH.  

SSH will look for the user's `~/.ssh/config` file. I have mine setup as:  

```sh
Host gitserv
    Hostname remote.server.com
    IdentityFile ~/.ssh/id_rsa.github
    IdentitiesOnly yes # see NOTES below
```

And I add a remote git repository:  

```sh
git remote add origin git@gitserv:myrepo.git
```

And then git commands work normally for me.  

```sh
git push -v origin master
```

<strong>NOTES</strong>  

<ul>
<li>The `IdentitiesOnly yes` is required to <a href="https://serverfault.com/questions/450796/how-could-i-stop-ssh-offering-a-wrong-key/450807#450807" title="foo">prevent the SSH default behavior</a> of sending the identity file matching the default filename for each protocol. If you have a file named `~/.ssh/id_rsa` that will get tried BEFORE your `~/.ssh/id_rsa.github` without this option.</li>
</ul>

<strong>References</strong>  

<ul>
<li><a href="https://stackoverflow.com/questions/2419566/best-way-to-use-multiple-ssh-private-keys-on-one-client">Best way to use multiple SSH private keys on one client</a></li>
<li><a href="https://serverfault.com/questions/450796/how-could-i-stop-ssh-offering-a-wrong-key/450807#450807" title="foo">How could I stop ssh offering a wrong key</a></li>
</ul>

#### Answer 3 (score 390)
Other people's suggestions about `~/.ssh/config` are extra complicated. It can be as simple as:  

```sh
Host github.com
  IdentityFile ~/.ssh/github_rsa
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: How do I prompt for Yes/No/Cancel input in a Linux shell script? (score [926403](https://stackoverflow.com/q/226703) in 2016)

#### Question
I want to pause input in a shell script, and prompt the user for choices. The standard 'Yes, No, or Cancel' type question. How do I accomplish this in a typical bash prompt?  

#### Answer accepted (score 1490)
The simplest and most widely available method to get user input at a shell prompt is the <a href="http://www.gnu.org/software/bash/manual/bashref.html#index-read" rel="noreferrer">`read`</a> command. The best way to illustrate its use is a simple demonstration:  

```sh
while true; do
    read -p "Do you wish to install this program?" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
```

Another method, <a href="https://stackoverflow.com/a/226946/9084">pointed out</a> by <a href="https://stackoverflow.com/users/28604/steven-huwig">Steven Huwig</a>, is Bash's <a href="http://www.gnu.org/software/bash/manual/bashref.html#index-select" rel="noreferrer">`select`</a> command. Here is the same example using `select`:  

```sh
echo "Do you wish to install this program?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) make install; break;;
        No ) exit;;
    esac
done
```

With `select` you don't need to sanitize the input &ndash; it displays the available choices, and you type a number corresponding to your choice. It also loops automatically, so there's no need for a `while true` loop to retry if they give invalid input.  

Also, <a href="https://stackoverflow.com/users/7939871/l%c3%a9a-gris">Léa Gris</a> demonstrated a way to make the request language agnostic in <a href="https://stackoverflow.com/a/57739142/9084">her answer</a>. Adapting my first example to better serve multiple languages might look like this:  

```sh
set -- $(locale LC_MESSAGES)
yesptrn="$1"; noptrn="$2"; yesword="$3"; noword="$4"

while true; do
    read -p "Install (${yesword} / ${noword})? " yn
    case $yn in
        ${yesptrn##^} ) make install; break;;
        ${noptrn##^} ) exit;;
        * ) echo "Answer ${yesword} / ${noword}.";;
    esac
done
```

Obviously other communication strings remain untranslated here (Install, Answer) which would need to be addressed in a more fully completed translation, but even a partial translation would be helpful in many cases.  

Finally, please check out the <a href="https://stackoverflow.com/a/27875395/9084">excellent answer</a> by <a href="https://stackoverflow.com/users/1765658/f-hauri">F. Hauri</a>.  

#### Answer 2 (score 483)
<h5>At least five answers for one generic question.</h1>

Depending on  

<ul>
<li><a href="/questions/tagged/posix" class="post-tag" title="show questions tagged &#39;posix&#39;" rel="tag">posix</a> compliant: could work on poor systems with generic <a href="/questions/tagged/shell" class="post-tag" title="show questions tagged &#39;shell&#39;" rel="tag">shell</a> environments</li>
<li><a href="/questions/tagged/bash" class="post-tag" title="show questions tagged &#39;bash&#39;" rel="tag">bash</a> specific: using so called <em>bashisms</em></li>
</ul>

and if you want  

<ul>
<li>simple ``in line'' question / answer (generic solutions)</li>
<li>pretty formatted interfaces, like <a href="/questions/tagged/ncurses" class="post-tag" title="show questions tagged &#39;ncurses&#39;" rel="tag">ncurses</a> or more graphical using libgtk or libqt...</li>
<li>use powerful readline history capability</li>
</ul>

<h5>1. POSIX generic solutions</h2>

You could use the `read` command, followed by `if ... then ... else`:  

```sh
echo -n "Is this a good question (y/n)? "
read answer
```

<s>  

```sh
# if echo "$answer" | grep -iq "^y" ;then
```

</s>  

```sh
if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo Yes
else
    echo No
fi
```

(Thanks to <a href="https://stackoverflow.com/posts/comments/86532780?noredirect=1">Adam Katz's comment</a>: Replaced the test above with one that is more portable and avoids one fork:)  

<h5>POSIX, but single key feature</h3>

But if you don't want the user to have to hit <kbd>Return</kbd>, you could write:  

(<strong>Edited:</strong> As @JonathanLeffler rightly suggest, <em>saving</em> stty's configuration could be better than simply force them to <em>sane</em>.)  

```sh
echo -n "Is this a good question (y/n)? "
old_stty_cfg=$(stty -g)
stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg # Careful playing with stty
if echo "$answer" | grep -iq "^y" ;then
    echo Yes
else
    echo No
fi
```

<strong>Note:</strong> This was tested under <a href="/questions/tagged/sh" class="post-tag" title="show questions tagged &#39;sh&#39;" rel="tag">sh</a>, <a href="/questions/tagged/bash" class="post-tag" title="show questions tagged &#39;bash&#39;" rel="tag">bash</a>, <a href="/questions/tagged/ksh" class="post-tag" title="show questions tagged &#39;ksh&#39;" rel="tag">ksh</a>, <a href="/questions/tagged/dash" class="post-tag" title="show questions tagged &#39;dash&#39;" rel="tag">dash</a> and <a href="/questions/tagged/busybox" class="post-tag" title="show questions tagged &#39;busybox&#39;" rel="tag">busybox</a>!  

Same, but waiting explicitly for <kbd>y</kbd> or <kbd>n</kbd>:  

```sh
#/bin/sh
echo -n "Is this a good question (y/n)? "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
    echo Yes
else
    echo No
fi
```

<h5>Using dedicated tools</h3>

There are many tools which were built using `libncurses`, `libgtk`, `libqt` or other graphical libraries. For example, using `whiptail`:  

```sh
if whiptail --yesno "Is this a good question" 20 60 ;then
    echo Yes
else
    echo No
fi
```

Depending on your system, you may need to replace `whiptail` with another similiar tool:  

```sh
dialog --yesno "Is this a good question" 20 60 && echo Yes

gdialog --yesno "Is this a good question" 20 60 && echo Yes

kdialog --yesno "Is this a good question" 20 60 && echo Yes
```

where `20` is height of dialog box in number of lines and `60` is width of  the dialog box. These tools all have <em>near same</em> syntax.  

```sh
DIALOG=whiptail
if [ -x /usr/bin/gdialog ] ;then DIALOG=gdialog ; fi
if [ -x /usr/bin/xdialog ] ;then DIALOG=xdialog ; fi
...
$DIALOG --yesno ...
```

<h5>2. Bash specific solutions</h2>

<h5>Basic <em>in line</em> method</h3>

```sh
read -p "Is this a good question (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        echo Yes
    ;;
    * )
        echo No
    ;;
esac
```

I prefer to use `case` so I could even test for `yes | ja | si | oui` if needed...  

<h5><em>in line</em> with <em>single key</em> feature</h3>

Under bash, we can specify the length of intended input for for the `read` command:  

```sh
read -n 1 -p "Is this a good question (y/n)? " answer
```

Under bash, `read` command accepts a <em>timeout</em> parameter, which could be useful.  

```sh
read -t 3 -n 1 -p "Is this a good question (y/n)? " answer
[ -z "$answer" ] && answer="Yes"  # if 'yes' have to be default choice
```

<h5>Some tricks for <em>dedicated tools</em></h3>

More sophisticated dialog boxes, beyond simple <em>`yes - no`</em> purposes:  

```sh
dialog --menu "Is this a good question" 20 60 12 y Yes n No m Maybe
```

Progress bar:  

```sh
dialog --gauge "Filling the tank" 20 60 0 < <(
    for i in {1..100};do
        printf "XXX\n%d\n%(%a %b %T)T progress: %d\nXXX\n" $i -1 $i
        sleep .033
    done
) 
```

Little demo:  

```sh
#!/bin/sh
while true ;do
    [ -x "$(which ${DIALOG%% *})" ] || DIALOG=dialog
    DIALOG=$($DIALOG --menu "Which tool for next run?" 20 60 12 2>&1 \
            whiptail       "dialog boxes from shell scripts" >/dev/tty \
            dialog         "dialog boxes from shell with ncurses" \
            gdialog        "dialog boxes from shell with Gtk" \
            kdialog        "dialog boxes from shell with Kde" ) || exit
    clear;echo "Choosed: $DIALOG."
    for i in `seq 1 100`;do
        date +"`printf "XXX\n%d\n%%a %%b %%T progress: %d\nXXX\n" $i $i`"
        sleep .0125
      done | $DIALOG --gauge "Filling the tank" 20 60 0
    $DIALOG --infobox "This is a simple info box\n\nNo action required" 20 60
    sleep 3
    if $DIALOG --yesno  "Do you like this demo?" 20 60 ;then
        AnsYesNo=Yes; else AnsYesNo=No; fi
    AnsInput=$($DIALOG --inputbox "A text:" 20 60 "Text here..." 2>&1 >/dev/tty)
    AnsPass=$($DIALOG --passwordbox "A secret:" 20 60 "First..." 2>&1 >/dev/tty)
    $DIALOG --textbox /etc/motd 20 60
    AnsCkLst=$($DIALOG --checklist "Check some..." 20 60 12 \
        Correct "This demo is useful"        off \
        Fun        "This demo is nice"        off \
        Strong        "This demo is complex"        on 2>&1 >/dev/tty)
    AnsRadio=$($DIALOG --radiolist "I will:" 20 60 12 \
        " -1" "Downgrade this answer"        off \
        "  0" "Not do anything"                on \
        " +1" "Upgrade this anser"        off 2>&1 >/dev/tty)
    out="Your answers:\nLike: $AnsYesNo\nInput: $AnsInput\nSecret: $AnsPass"
    $DIALOG --msgbox "$out\nAttribs: $AnsCkLst\nNote: $AnsRadio" 20 60
  done
```

More sample? Have a look at <a href="https://stackoverflow.com/questions/50560500/linux-shell-get-device-id-from-user-input/50577400#50577400">Using whiptail for choosing USB device</a> and <a href="https://unix.stackexchange.com/questions/119759/removable-usb-stick-listed-as-non-removable-in-sys-block/119816#119816">USB removable storage selector: USBKeyChooser</a>  

<h5>5. Using readline's history</h3>

Example:  

```sh
#!/bin/bash

set -i
HISTFILE=~/.myscript.history
history -c
history -r

myread() {
    read -e -p '> ' $1
    history -s ${!1}
}
trap 'history -a;exit' 0 1 2 3 6

while myread line;do
    case ${line%% *} in
        exit )  break ;;
        *    )  echo "Doing something with '$line'" ;;
      esac
  done
```

This will create a file `.myscript.history` in your `$HOME` directory, than you could use readline's history commands, like <kbd>Up</kbd>,  <kbd>Down</kbd>, <kbd>Ctrl</kbd>+<kbd>r</kbd> and others.  

#### Answer 3 (score 346)
```sh
echo "Please enter some input: "
read input_variable
echo "You entered: $input_variable"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: How to do a logical OR operation in shell scripting (score [896876](https://stackoverflow.com/q/4111475) in 2019)

#### Question
I am trying to do a simple condition check, but it doesn't seem to work.  

If `$#` is equal to `0` or is greater than `1` then say hello.  

I have tried the following syntax with no success:  

```sh
if [ "$#" == 0 -o "$#" > 1 ] ; then
 echo "hello"
fi

if [ "$#" == 0 ] || [ "$#" > 1 ] ; then
 echo "hello"
fi
```

#### Answer accepted (score 959)
This should work:  

```sh
#!/bin/bash

if [ "$#" -eq 0 ] || [ "$#" -gt 1 ] ; then
    echo "hello"
fi
```

I'm not sure if this is different in other shells but if you wish to use &lt;, >, you need to put them inside double parenthesis like so:   

```sh
if (("$#" > 1))
 ...
```

#### Answer 2 (score 55)
This code works for me:  

```sh
#!/bin/sh

argc=$#
echo $argc
if [ $argc -eq 0 -o $argc -eq 1 ]; then
  echo "foo"
else
  echo "bar"
fi
```

I don't think sh supports "==". Use "=" to compare strings and -eq to compare ints.  

```sh
man test
```

for more details.  

#### Answer 3 (score 33)
If you are using the bash exit code status <strong>$?</strong> as variable, it's better to do this:  

```sh
if [ $? -eq 4 -o $? -eq 8 ] ; then  
   echo "..."
fi
```

Because if you do:  

```sh
if [ $? -eq 4 ] || [ $? -eq 8 ] ; then  
```

The <strong>left part of the OR</strong> alters the <strong>$?</strong> variable, so the <strong>right part of the OR</strong> doesn't have the original <strong>$?</strong> value.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: How to change the output color of echo in Linux (score [896232](https://stackoverflow.com/q/5947742) in 2017)

#### Question
I am trying to print a text in the terminal using echo command.   

I want to print the text in a red color. How can I do that?  

#### Answer 2 (score 2055)
You can use these <a href="https://en.wikipedia.org/wiki/ANSI_escape_code" rel="noreferrer">ANSI escape codes</a>:  

```sh
Black        0;30     Dark Gray     1;30
Red          0;31     Light Red     1;31
Green        0;32     Light Green   1;32
Brown/Orange 0;33     Yellow        1;33
Blue         0;34     Light Blue    1;34
Purple       0;35     Light Purple  1;35
Cyan         0;36     Light Cyan    1;36
Light Gray   0;37     White         1;37
```

And then use them like this in your script:  

```sh
#    .---------- constant part!
#    vvvv vvvv-- the code from above
RED='\033[0;31m'
NC='\033[0m' # No Color
printf "I ${RED}love${NC} Stack Overflow\n"
```

which prints `love` in red.  

From @james-lim's comment, <strong>if you are using the `echo` command, be sure to use the -e flag to allow backslash escapes</strong>.  

```sh
# Continued from above example
echo -e "I ${RED}love${NC} Stack Overflow"
```

(don't add `"\n"` when using echo unless you want to add additional empty line)  

#### Answer 3 (score 868)
You can use the awesome `tput` command (suggested in <a href="https://stackoverflow.com/a/5947788/24874">Ignacio's answer</a>) to produce terminal control codes for all kinds of things.  

<hr>

<h5>Usage</h1>

Specific `tput` sub-commands are discussed later.  

<h5>Direct</h3>

Call `tput` as part of a sequence of commands:  

```sh
tput setaf 1; echo "this is red text"
```

Use `;` instead of `&amp;&amp;` so if `tput` errors the text still shows.  

<h5>Shell variables</h3>

Another option is to use shell variables:  

```sh
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
echo "${red}red text ${green}green text${reset}"
```

`tput` produces character sequences that are interpreted by the terminal as having a special meaning. They will not be shown themselves. Note that they can still be saved into files or processed as input by programs other than the terminal.  

<h5>Command substitution</h3>

It may be more convenient to insert `tput`'s output directly into your `echo` strings using <a href="http://tldp.org/LDP/abs/html/commandsub.html" rel="noreferrer">command substitution</a>:  

```sh
echo "$(tput setaf 1)Red text $(tput setab 7)and white background$(tput sgr 0)"
```

<hr>

<h5>Example</h1>

The above command produces this on Ubuntu:  

<img src="https://i.stack.imgur.com/6tYnk.png" alt="Screenshot of colour terminal text">  

<hr>

<h5>Foreground &amp; background colour commands</h1>

```sh
tput setab [1-7] # Set the background colour using ANSI escape
tput setaf [1-7] # Set the foreground colour using ANSI escape
```

Colours are as follows:  

```sh
Num  Colour    #define         R G B

0    black     COLOR_BLACK     0,0,0
1    red       COLOR_RED       1,0,0
2    green     COLOR_GREEN     0,1,0
3    yellow    COLOR_YELLOW    1,1,0
4    blue      COLOR_BLUE      0,0,1
5    magenta   COLOR_MAGENTA   1,0,1
6    cyan      COLOR_CYAN      0,1,1
7    white     COLOR_WHITE     1,1,1
```

There are also non-ANSI versions of the colour setting functions (`setb` instead of `setab`, and `setf` instead of `setaf`) which use different numbers, not given here.  

<h5>Text mode commands</h1>

```sh
tput bold    # Select bold mode
tput dim     # Select dim (half-bright) mode
tput smul    # Enable underline mode
tput rmul    # Disable underline mode
tput rev     # Turn on reverse video mode
tput smso    # Enter standout (bold) mode
tput rmso    # Exit standout mode
```

<h5>Cursor movement commands</h1>

```sh
tput cup Y X # Move cursor to screen postion X,Y (top left is 0,0)
tput cuf N   # Move N characters forward (right)
tput cub N   # Move N characters back (left)
tput cuu N   # Move N lines up
tput ll      # Move to last line, first column (if no cup)
tput sc      # Save the cursor position
tput rc      # Restore the cursor position
tput lines   # Output the number of lines of the terminal
tput cols    # Output the number of columns of the terminal
```

<h5>Clear and insert commands</h1>

```sh
tput ech N   # Erase N characters
tput clear   # Clear screen and move the cursor to 0,0
tput el 1    # Clear to beginning of line
tput el      # Clear to end of line
tput ed      # Clear to end of screen
tput ich N   # Insert N characters (moves rest of line forward!)
tput il N    # Insert N lines
```

<h5>Other commands</h1>

```sh
tput sgr0    # Reset text format to the terminal's default
tput bel     # Play a bell
```

With <a href="https://extensions.gnome.org/extension/669/wobbly-windows/" rel="noreferrer">compiz wobbly windows</a>, the `bel` command makes the terminal wobble for a second to draw the user's attention.  

<hr>

<h5>Scripts</h1>

`tput` accepts scripts containing one command per line, which are executed in order before `tput` exits.  

Avoid temporary files by echoing a multiline string and piping it:  

```sh
echo -e "setf 7\nsetb 1" | tput -S  # set fg white and bg red
```

<hr>

<h5>See also</h1>

<ul>
<li>See <a href="http://unixhelp.ed.ac.uk/CGI/man-cgi?tput+1" rel="noreferrer">`man 1 tput`</a></li>
<li>See <a href="http://www.manpagez.com/man/5/terminfo/" rel="noreferrer">`man 5 terminfo`</a> for the complete list of commands and more details on these options. (The corresponding `tput` command is listed in the `Cap-name` column of the huge table that starts at line 81.)</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: How to call shell script from another shell script? (score [876027](https://stackoverflow.com/q/8352851) in 2016)

#### Question
I have two shell scripts, `a.sh` and `b.sh`.  

How can I call `b.sh` from within the shell script `a.sh`?  

#### Answer 2 (score 856)
There are a couple of different ways you can do this:  

<ol>
<li><p>Make the other script executable, add the `#!/bin/bash` line at the top, and the path where the file is to the $PATH environment variable. Then you can call it as a normal command;</p></li>
<li><p>Or call it with the `source` command (alias is `.`) like this: `source /path/to/script`;</p></li>
<li><p>Or use the `bash` command to execute it: `/bin/bash /path/to/script`;</p></li>
</ol>

<p>The first and third methods execute the script as another process, so variables and functions in the other script will not be accessible.<br>
The second method executes the script in the first script's process, and pulls in variables and functions from the other script so they are usable from the calling script. </p>

In the second method, if you are using `exit` in second script, it will exit the first script as well. Which will not happen in first and third methods.  

#### Answer 3 (score 195)
Check this out.  

```sh
#!/bin/bash
echo "This script is about to run another script."
sh ./script.sh
echo "This script has just run another script."
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: How do I reload .bashrc without logging out and back in? (score [855839](https://stackoverflow.com/q/2518127) in 2018)

#### Question
If I make changes to `.bashrc`, how do I reload it without logging out and back in?  

#### Answer accepted (score 2385)
You just have to enter the command:  

```sh
source ~/.bashrc
```

or you can use the shorter version of the command:  

```sh
. ~/.bashrc
```

#### Answer 2 (score 246)
or you could use;  

```sh
exec bash
```

does the same thing. (and easier to remember, at least for me)  

<strong><em>exec</em></strong> command replaces the shell with given program, in our example, it replaces our shell with bash (with the updated configuration files)  

#### Answer 3 (score 111)
To <strong>complement and contrast</strong> the two most popular answers, <a href="https://stackoverflow.com/a/2518150/45375">`. ~/.bashrc`</a> and <a href="https://stackoverflow.com/a/9584378/45375">`exec bash`</a>:  

Both solutions <em>effectively</em> reload `~/.bashrc`, but there are differences:  

<ul>
<li><p>`. ~/.bashrc` or `source ~/.bashrc` will <strong><em>preserve</em> your current shell</strong>:</p>

<ul>
<li>Except for the modifications that reloading `~/.bashrc` into the current shell (<em>sourcing</em>) makes, <strong>the <em>current shell and its state</em> are <em>preserved</em></strong>, which includes environment variables, shell variables, shell options, shell functions, and command history.</li>
</ul></li>
<li><p>`exec bash`, or, more robustly, `exec "$BASH"`<sup>[1]</sup>,
will <strong><em>replace</em> your current shell</strong> with a new instance, and therefore <strong><em>only</em> preserve your current shell's <em>environment variables</strong></em> (including ones you've defined ad-hoc).</p>

<ul>
<li>In other words: Any ad-hoc changes to the current shell in terms of shell variables, shell functions, shell options, command history are lost.</li>
</ul></li>
</ul>

Depending on your needs, one or the other approach may be preferred.  

<hr>

<p><sup>[1] `exec bash` could in theory execute a <em>different</em> `bash` executable than the one that started the current shell, if it happens to exist in a directory listed earlier in the `$PATH`. Since special variable `$BASH` always contains the full path of the executable that started the current shell, `exec "$BASH"` is guaranteed to use the <em>same</em> executable.<br>
A note re `"..."` around `$BASH`: double-quoting ensures that the variable value is used as-is, without interpretation by Bash; if the value has no embedded spaces or other shell metacharacters (which is not likely in this case), you don't strictly need double quotes, but using them is a good habit to form.</sup></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: Parsing JSON with Unix tools (score [847637](https://stackoverflow.com/q/1955505) in 2018)

#### Question
I'm trying to parse JSON returned from a curl request, like so:  

```sh
curl 'http://twitter.com/users/username.json' |
    sed -e 's/[{}]/''/g' | 
    awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}'
```

The above splits the JSON into fields, for example:  

```sh
% ...
"geo_enabled":false
"friends_count":245
"profile_text_color":"000000"
"status":"in_reply_to_screen_name":null
"source":"web"
"truncated":false
"text":"My status"
"favorited":false
% ...
```

How do I print a specific field (denoted by the `-v k=text`)?  

#### Answer accepted (score 943)
There are a number of tools specifically designed for the purpose of manipulating JSON from the command line, and will be a lot easier and more reliable than doing it with Awk, such as <a href="https://stedolan.github.io/jq/" rel="noreferrer">`jq`</a>:  

```sh
curl -s 'https://api.github.com/users/lambda' | jq -r '.name'
```

You can also do this with tools that are likely already installed on your system, like Python using the <a href="https://docs.python.org/2/library/json.html" rel="noreferrer">`json` module</a>, and so avoid any extra dependencies, while still having the benefit of a proper JSON parser. The following assume you want to use UTF-8, which the original JSON should be encoded in and is what most modern terminals use as well:  

Python 2:  

```sh
export PYTHONIOENCODING=utf8
curl -s 'https://api.github.com/users/lambda' | \
    python -c "import sys, json; print json.load(sys.stdin)['name']"
```

Python 3:  

```sh
curl -s 'https://api.github.com/users/lambda' | \
    python3 -c "import sys, json; print(json.load(sys.stdin)['name'])"
```

<h5>Historical notes</h3>

This answer originally recommended <a href="http://github.com/micha/jsawk" rel="noreferrer">jsawk</a>, which should still work, but is a little more cumbersome to use than `jq`, and depends on a standalone JavaScript interpreter being installed which is less common than a Python interpreter, so the above answers are probably preferable:  

```sh
curl -s 'https://api.github.com/users/lambda' | jsawk -a 'return this.name'
```

This answer also originally used the Twitter API from the question, but that API no longer works, making it hard to copy the examples to test out, and the new Twitter API requires API keys, so I've switched to using the GitHub API which can be used easily without API keys.  The first answer for the original question would be:  

```sh
curl 'http://twitter.com/users/username.json' | jq -r '.text'
```

#### Answer 2 (score 266)
To quickly extract the values for a particular key, I personally like to use "grep -o", which only returns the regex's match.  For example, to get the "text" field from tweets, something like:  

```sh
grep -Po '"text":.*?[^\\]",' tweets.json
```

This regex is more robust than you might think; for example, it deals fine with strings having embedded commas and escaped quotes inside them. I think with a little more work you could make one that is actually guaranteed to extract the value, if it's atomic.  (If it has nesting, then a regex can't do it of course.)  

And to further clean (albeit keeping the string's original escaping) you can use something like: `| perl -pe 's/"text"://; s/^"//; s/",$//'`.  (I did this for <a href="https://gist.github.com/1024217" rel="noreferrer">this analysis</a>.)  

To all the haters who insist you should use a real JSON parser -- yes, that is essential for correctness, but  

<ol>
<li>To do a really quick analysis, like counting values to check on data cleaning bugs or get a general feel for the data, banging out something on the command line is faster.  Opening an editor to write a script is distracting.</li>
<li>`grep -o` is orders of magnitude faster than the Python standard `json` library, at least when doing this for tweets (which are ~2 KB each).  I'm not sure if this is just because `json` is slow (I should compare to yajl sometime); but in principle, a regex should be faster since it's finite state and much more optimizable, instead of a parser that has to support recursion, and in this case, spends lots of CPU building trees for structures you don't care about.  (If someone wrote a finite state transducer that did proper (depth-limited) JSON parsing, that would be fantastic!  In the meantime we have "grep -o".)</li>
</ol>

To write maintainable code, I always use a real parsing library.  I haven't tried <a href="https://github.com/micha/jsawk" rel="noreferrer">jsawk</a>, but if it works well, that would address point #1.  

One last, wackier, solution: I wrote a script that uses Python `json` and extracts the keys you want, into tab-separated columns; then I pipe through a wrapper around `awk` that allows named access to columns.  <a href="https://github.com/brendano/tsvutils" rel="noreferrer">In here: the json2tsv and tsvawk scripts</a>.  So for this example it would be:  

```sh
json2tsv id text < tweets.json | tsvawk '{print "tweet " $id " is: " $text}'
```

This approach doesn't address #2, is more inefficient than a single Python script, and it's a little brittle: it forces normalization of newlines and tabs in string values, to play nice with awk's field/record-delimited view of the world.  But it does let you stay on the command line, with more correctness than `grep -o`.  

#### Answer 3 (score 163)
On the basis that some of the recommendations here (esp in the comments) suggested the use of Python, I was disappointed not to find an example.  

So, here's a one liner to get a single value from some JSON data. It assumes that you are piping the data in (from somewhere) and so should be useful in a scripting context.   

```sh
echo '{"hostname":"test","domainname":"example.com"}' | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["hostname"]'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: How can I add numbers in a bash script (score [844322](https://stackoverflow.com/q/6348902) in 2019)

#### Question
<p>I have this bash script and I had a problem in line 16.
How can I take the previous result of line 15 and add
it to the variable in line 16?</p>

```sh
#!/bin/bash

num=0
metab=0

for ((i=1; i<=2; i++)); do      
    for j in `ls output-$i-*`; do
        echo "$j"

        metab=$(cat $j|grep EndBuffer|awk '{sum+=$2} END { print sum/120}') (line15)
        num= $num + $metab   (line16)
    done
    echo "$num"
 done
```

#### Answer 2 (score 899)
<em>For integers</em>:  

<ul>
<li><p>Use <a href="http://tldp.org/LDP/abs/html/arithexp.html">arithmetic expansion</a>: `$((EXPR))`</p>

```sh
num=$((num1 + num2))
num=$(($num1 + $num2))       # also works
num=$((num1 + 2 + 3))        # ...
num=$[num1+num2]             # old, deprecated arithmetic expression syntax
```</li>
<li><p>Using the external `expr` utility. Note that this is only needed for really old systems.</p>

```sh
num=`expr $num1 + $num2`     # whitespace for expr is important
```</li>
</ul>

<hr>

<em>For floating point</em>:  

Bash doesn't directly support this, but there's a couple of external tools you can use:  

```sh
num=$(awk "BEGIN {print $num1+$num2; exit}")
num=$(python -c "print $num1+$num2")
num=$(perl -e "print $num1+$num2")
num=$(echo $num1 + $num2 | bc)   # whitespace for echo is important
```

You can also use scientific notation (e.g.: `2.5e+2`)  

<hr>

<em>Common pitfalls</em>:  

<ul>
<li><p>When setting a variable, you cannot have whitespace on either side of `=`, otherwise it will force the shell to interpret the first word as the name of the application to run (eg: `num=` or `num`)</p>

<strike>`num= 1`</strike> <strike>`num =2`</strike>  </li>
<li><p>`bc` and `expr` expect each number and operator as a separate argument, so whitespace is important. They cannot process arguments like `3+` `+4`.</p>

<strike>`num=`expr $num1+ $num2``</strike>  </li>
</ul>

#### Answer 3 (score 89)
Use the `$(( ))` arithmetic expansion.  

```sh
num=$(( $num + $metab ))
```

See <a href="http://tldp.org/LDP/abs/html/arithexp.html" rel="noreferrer">http://tldp.org/LDP/abs/html/arithexp.html</a> for more information.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: How to run a shell script on a Unix console or Mac terminal? (score [838291](https://stackoverflow.com/q/733824) in 2017)

#### Question
I know it, forget it and relearn it again. Time to write it down.  

#### Answer accepted (score 918)
To run a non-executable `sh` script, use:  

```sh
sh myscript
```

To run a non-executable `bash` script, use:  

```sh
bash myscript
```

To start an executable (which is any file with executable permission); you just specify it by its path:  

```sh
/foo/bar
/bin/bar
./bar
```

To make a script executable, give it the necessary permission:  

```sh
chmod +x bar
./bar
```

When a file is executable, the <strong>kernel</strong> is responsible for figuring out how to execte it.  For non-binaries, this is done by looking at the first line of the file.  It should contain a `hashbang`:  

```sh
#! /usr/bin/env bash
```

The hashbang tells the kernel what program to run (in this case the command `/usr/bin/env` is ran with the argument `bash`).  Then, the script is passed to the program (as second argument) along with all the arguments you gave the script as subsequent arguments.  

That means <strong>every script that is executable should have a hashbang</strong>.  If it doesn't, you're not telling the kernel what it <em>is</em>, and therefore the kernel doesn't know what program to use to interprete it.  It could be `bash`, `perl`, `python`, `sh`, or something else.  (In reality, the kernel will often use the user's default shell to interprete the file, which is very dangerous because it might not be the right interpreter at all or it might be able to parse some of it but with subtle behavioural differences such as is the case between `sh` and `bash`).  

<h5>A note on `/usr/bin/env`</h1>

Most commonly, you'll see hash bangs like so:  

```sh
#!/bin/bash
```

The result is that the kernel will run the program `/bin/bash` to interpret the script.  Unfortunately, `bash` is not always shipped by default, and it is not always available in `/bin`.  While on Linux machines it usually is, there are a range of other POSIX machines where `bash` ships in various locations, such as `/usr/xpg/bin/bash` or `/usr/local/bin/bash`.  

To write a portable bash script, we can therefore not rely on hard-coding the location of the `bash` program.  POSIX already has a mechanism for dealing with that: `PATH`.  The idea is that you install your programs in one of the directories that are in `PATH` and the system should be able to find your program when you want to run it by name.  

Sadly, you <strong><em>cannot</em></strong> just do this:  

```sh
#!bash
```

The kernel won't (some might) do a `PATH` search for you.  There is a program that can do a `PATH` search for you, though, it's called `env`.  Luckily, nearly all systems have an `env` program installed in `/usr/bin`.  So we start `env` using a hardcoded path, which then does a `PATH` search for `bash` and runs it so that it can interpret your script:  

```sh
#!/usr/bin/env bash
```

This approach has one downside: According to POSIX, the hashbang can have <strong>one argument</strong>.  In this case, we use `bash` as the argument to the `env` program.  That means we have no space left to pass arguments to `bash`.  So there's no way to convert something like `#!/bin/bash -exu` to this scheme.  You'll have to put `set -exu` after the hashbang instead.  

This approach also has another advantage: Some systems may ship with a `/bin/bash`, but the user may not like it, may find it's buggy or outdated, and may have installed his own `bash` somewhere else.  This is often the case on OS X (Macs) where Apple ships an outdated `/bin/bash` and users install an up-to-date `/usr/local/bin/bash` using something like Homebrew.  When you use the `env` approach which does a `PATH` search, you take the user's preference into account and use his preferred bash over the one his system shipped with.  

#### Answer 2 (score 80)
To start the shell-script 'file.sh':  

```sh
sh file.sh

bash file.sh
```

Another option is set executable permission using chmod command:  

```sh
chmod +x file.sh
```

Now run .sh file as follows:  

```sh
./file.sh
```

#### Answer 3 (score 15)
For the bourne shell:  

```sh
sh myscript.sh
```

For bash:  

```sh
bash myscript.sh
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: How to declare and use boolean variables in shell script? (score [818063](https://stackoverflow.com/q/2953646) in 2014)

#### Question
I tried to declare a boolean variable in a shell script using the following syntax:  

```sh
variable=$false

variable=$true
```

Is this correct? Also, if I wanted to update that variable would I use the same syntax? Finally, is the following syntax for using boolean variables as expressions correct:  

```sh
if [ $variable ]

if [ !$variable ]
```

#### Answer accepted (score 1064)
<strong>Revised Answer (Feb 12, 2014)</strong>  

```sh
the_world_is_flat=true
# ...do something interesting...
if [ "$the_world_is_flat" = true ] ; then
    echo 'Be careful not to fall off!'
fi
```

<hr>

<strong>Original Answer</strong>  

Caveats: <a href="https://stackoverflow.com/a/21210966/89391">https://stackoverflow.com/a/21210966/89391</a>  

```sh
the_world_is_flat=true
# ...do something interesting...
if $the_world_is_flat ; then
    echo 'Be careful not to fall off!'
fi
```

From: <a href="https://github.com/aperezdc/perezdecastro.org/blob/master/stash/using-boolean-variables-in-bash.markdown" rel="noreferrer">Using boolean variables in Bash</a>  

<em>The reason the original answer is included here is because the comments before the revision on Feb 12, 2014 pertain only to the original answer, and many of the comments are wrong when associated with the revised answer. For example, Dennis Williamson's comment about bash builtin `true` on Jun 2, 2010 only applies to the original answer, not the revised.</em>  

#### Answer 2 (score 719)
<h5>TL;DR</h2>

```sh
bool=true

if [ "$bool" = true ]
```

<hr>

<h5>Issues with Miku's (<a href="https://stackoverflow.com/revisions/2953673/5">original</a>) answer</h2>

I do <strong>not</strong> recommend the accepted answer<sup>1</sup>. Its syntax is pretty but it has some flaws.  

Say we have the following condition.  

```sh
if $var; then
  echo 'Muahahaha!'
fi
```

In the following cases<sup>2</sup>, this condition will evaluate to <strong>true</strong> and execute the nested command.  

```sh
# Variable var not defined beforehand. Case 1
var=''  # Equivalent to var="".        Case 2
var=    #                              Case 3
unset var  #                           Case 4
var='<some valid command>'  #          Case 5
```

Typically you only want your condition to evaluate to true when your "boolean" variable, `var` in this example, is explicitly set to true. All the others cases are dangerously misleading!  

The last case (#5) is especially naughty because it will execute the command contained in the variable (which is why the condition evaluates to true for valid commands<sup>3, 4</sup>).  

Here is a harmless example:  

```sh
var='echo this text will be displayed when the condition is evaluated'
if $var; then
  echo 'Muahahaha!'
fi

# Outputs:
# this text will be displayed when the condition is evaluated
# Muahahaha!
```

Quoting your variables is safer, e.g. `if "$var"; then`. In the above cases, you should get a warning that the command is not found. But we can still do better (see my recommendations at the bottom).  

<sup><a href="https://stackoverflow.com/a/21768067/72321">Also see Mike Holt's explanation of Miku's original answer.</a></sup>  

<h5>Issues with Hbar's answer</h2>

This approach also has unexpected behaviour.  

```sh
var=false
if [ $var ]; then
  echo "This won't print, var is false!"
fi

# Outputs:
# This won't print, var is false!
```

You would expect the above condition to evaluate to false, thus never executing the nested statement. Surprise!  

Quoting the value (`"false"`), quoting the variable (`"$var"`), or using `test` or `[[` instead of `[`, do not make a difference.  

<h5>What I DO recommend:</h2>

Here are ways I recommend you check your "booleans". They work as expected.  

```sh
bool=true

if [ "$bool" = true ]; then
if [ "$bool" = "true" ]; then

if [[ "$bool" = true ]]; then
if [[ "$bool" = "true" ]]; then
if [[ "$bool" == true ]]; then
if [[ "$bool" == "true" ]]; then

if test "$bool" = true; then
if test "$bool" = "true"; then
```

They're all pretty much equivalent. You'll have to type a few more keystrokes than the approaches in the other answers<sup>5</sup> but your code will be more defensive.  

<hr>

<h5>Footnotes</h3>

<ol>
<li>Miku's answer has since been edited and no longer contains (known) flaws.</li>
<li>Not an exhaustive list.</li>
<li>A valid command in this context means a command that exists. It doesn't matter if the command is used correctly or incorrectly. E.g. `man woman` would still be considered a valid command, even if no such man page exists.</li>
<li>For invalid (non-existent) commands, Bash will simply complain that the command wasn't found.</li>
<li>If you care about length, the first recommendation is the shortest.</li>
</ol>

#### Answer 3 (score 156)
There seems to be some misunderstanding here about the Bash builtin `true`, and more specifically, about how Bash expands and interprets expressions inside brackets.  

The code in <a href="https://stackoverflow.com/questions/2953646/how-to-declare-and-use-boolean-variables-in-shell-script/2953673#2953673">miku's answer</a> has absolutely nothing to do with the Bash builtin `true`, nor `/bin/true`, nor any other flavor of the `true` command. In this case, `true` is nothing more than a simple character string, and no call to the `true` command/builtin is ever made, neither by the variable assignment, nor by the evaluation of the conditional expression.  

The following code is functionally identical to the code in the miku's answer:  

```sh
the_world_is_flat=yeah
if [ "$the_world_is_flat" = yeah ]; then
    echo 'Be careful not to fall off!'
fi
```

The <strong>only</strong> difference here is that the four characters being compared are 'y', 'e', 'a', and 'h' instead of 't', 'r', 'u', and 'e'. That's it. There's no attempt made to call a command or builtin named `yeah`, nor is there (in miku's example) any sort of special handling going on when Bash parses the token `true`. It's just a string, and a completely arbitrary one at that.  

<strong>Update (2014-02-19):</strong> After following the link in miku's answer, now I see where some of the confusion is coming from. Miku's answer uses single brackets, but the code snippet he links to does not use brackets. It's just:  

```sh
the_world_is_flat=true
if $the_world_is_flat; then
  echo 'Be careful not to fall off!'
fi
```

Both code snippets will <em>behave</em> the same way, but the brackets completely change what's going on under the hood.   

Here's what Bash is doing in each case:  

<strong>No brackets:</strong>  

<ol>
<li>Expand the variable `$the_world_is_flat` to the string `"true"`.</li>
<li>Attempt to parse the string `"true"` as a command.</li>
<li>Find and run the `true` command (either a builtin or `/bin/true`, depending on the Bash version).</li>
<li>Compare the exit code of the `true` command (which is always 0) with 0. Recall that in most shells, an exit code of 0 indicates success and anything else indicates failure.</li>
<li>Since the exit code was 0 (success), execute the `if` statement's `then` clause</li>
</ol>

<strong>Brackets:</strong>  

<ol>
<li>Expand the variable `$the_world_is_flat` to the string `"true"`.</li>
<li>Parse the now-fully-expanded conditional expression, which is of the form `string1 = string2`. The `=` operator is bash's <em>string comparison</em> operator. So...</li>
<li>Do a string comparison on `"true"` and `"true"`.</li>
<li>Yep, the two strings were the same, so the value of the conditional is true.</li>
<li>Execute the `if` statement's `then` clause.</li>
</ol>

The no-brackets code works, because the `true` command returns an exit code of 0, which indicates success. The bracketed code works, because the value of `$the_world_is_flat` is identical to the string literal `true` on the right side of the `=`.  

Just to drive the point home, consider the following two snippets of code:   

This code (if run with root privileges) will reboot your computer:  

```sh
var=reboot
if $var; then
  echo 'Muahahaha! You are going down!'
fi
```

This code just prints "Nice try." The reboot command is not called.  

```sh
var=reboot
if [ $var ]; then
  echo 'Nice try.'
fi
```

<strong>Update (2014-04-14)</strong> To answer the question in the comments regarding the difference between `=` and `==`: AFAIK, there is no difference. The `==` operator is a Bash-specific synonym for `=`, and as far as I've seen, they work exactly the same in all contexts.  

Note, however, that I'm specifically talking about the `=` and `==` string comparison operators used in either `[ ]` or `[[ ]]` tests. I'm not suggesting that `=` and `==` are interchangeable <em>everywhere</em> in bash.  

For example, you obviously can't do variable assignment with `==`, such as `var=="foo"` (well technically you <em>can</em> do this, but the value of `var` will be `"=foo"`, because Bash isn't seeing an `==` operator here, it's seeing an `=` (assignment) operator, followed by the literal value `="foo"`, which just becomes `"=foo"`).  

Also, although `=` and `==` are interchangeable, you should keep in mind that how those tests work <em>does</em> depend on whether you're using it inside `[ ]` or `[[ ]]`, and also on whether or not the operands are quoted. You can read more about that in <em><a href="http://www.tldp.org/LDP/abs/html/comparison-ops.html" rel="noreferrer">Advanced Bash Scripting Guide: 7.3 Other Comparison Operators</a></em> (scroll down to the discussion of `=` and `==`).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: How to convert a string to lower case in Bash? (score [812250](https://stackoverflow.com/q/2264428) in 2018)

#### Question
Is there a way in <a href="/questions/tagged/bash" class="post-tag" title="show questions tagged &#39;bash&#39;" rel="tag">bash</a> to convert a string into a lower case string?  

For example, if I have:  

```sh
a="Hi all"
```

I want to convert it to:  

```sh
"hi all"
```

#### Answer accepted (score 1988)
The are various ways:  

<h5><a href="https://en.wikipedia.org/wiki/POSIX" rel="noreferrer">POSIX standard</a></h2>

<h5><a href="http://en.wikipedia.org/wiki/Tr_%28Unix%29" rel="noreferrer">tr</a></h3>

```sh
$ echo "$a" | tr '[:upper:]' '[:lower:]'
hi all
```

<h5><a href="http://en.wikipedia.org/wiki/AWK" rel="noreferrer">AWK</a></h3>

```sh
$ echo "$a" | awk '{print tolower($0)}'
hi all
```

<h5>Non-POSIX</h2>

You may run into portability issues with the following examples:  

<h5><a href="https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29" rel="noreferrer">Bash 4.0</a></h3>

```sh
$ echo "${a,,}"
hi all
```

<h5><a href="http://en.wikipedia.org/wiki/Sed" rel="noreferrer">sed</a></h3>

```sh
$ echo "$a" | sed -e 's/\(.*\)/\L\1/'
hi all
# this also works:
$ sed -e 's/\(.*\)/\L\1/' <<< "$a"
hi all
```

<h5><a href="http://en.wikipedia.org/wiki/Perl" rel="noreferrer">Perl</a></h3>

```sh
$ echo "$a" | perl -ne 'print lc'
hi all
```

<h5><a href="https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29" rel="noreferrer">Bash</a></h3>

```sh
lc(){
    case "$1" in
        [A-Z])
        n=$(printf "%d" "'$1")
        n=$((n+32))
        printf \\$(printf "%o" "$n")
        ;;
        *)
        printf "%s" "$1"
        ;;
    esac
}
word="I Love Bash"
for((i=0;i<${#word};i++))
do
    ch="${word:$i:1}"
    lc "$ch"
done
```

Note: YMMV on this one. Doesn't work for me (GNU bash version 4.2.46 and 4.0.33 (and same behaviour 2.05b.0 but nocasematch is not implemented)) even with using `shopt -u nocasematch;`. Unsetting that nocasematch causes [[ "fooBaR" == "FOObar" ]] to match OK BUT inside case weirdly [b-z] are incorrectly matched by [A-Z]. Bash is confused by the double-negative ("unsetting nocasematch")! :-)  

#### Answer 2 (score 411)
In Bash 4:  

To lowercase  

```sh
$ string="A FEW WORDS"
$ echo "${string,}"
a FEW WORDS
$ echo "${string,,}"
a few words
$ echo "${string,,[AEIUO]}"
a FeW WoRDS

$ string="A Few Words"
$ declare -l string
$ string=$string; echo "$string"
a few words
```

To uppercase  

```sh
$ string="a few words"
$ echo "${string^}"
A few words
$ echo "${string^^}"
A FEW WORDS
$ echo "${string^^[aeiou]}"
A fEw wOrds

$ string="A Few Words"
$ declare -u string
$ string=$string; echo "$string"
A FEW WORDS
```

Toggle (undocumented, but optionally configurable at compile time)  

```sh
$ string="A Few Words"
$ echo "${string~~}"
a fEW wORDS
$ string="A FEW WORDS"
$ echo "${string~}"
a FEW WORDS
$ string="a few words"
$ echo "${string~}"
A few words
```

Capitalize (undocumented, but optionally configurable at compile time)  

```sh
$ string="a few words"
$ declare -c string
$ string=$string
$ echo "$string"
A few words
```

Title case:  

```sh
$ string="a few words"
$ string=($string)
$ string="${string[@]^}"
$ echo "$string"
A Few Words

$ declare -c string
$ string=(a few words)
$ echo "${string[@]}"
A Few Words

$ string="a FeW WOrdS"
$ string=${string,,}
$ string=${string~}
$ echo "$string"
A few words
```

To turn off a `declare` attribute, use `+`. For example, `declare +c string`. This affects subsequent assignments and not the current value.  

The `declare` options change the attribute of the variable, but not the contents. The reassignments in my examples update the contents to show the changes.  

<strong>Edit:</strong>  

Added "toggle first character by word" (`${var~}`) as suggested by <strong>ghostdog74</strong>.  

<strong>Edit:</strong> Corrected tilde behavior to match Bash 4.3.  

#### Answer 3 (score 120)
```sh
echo "Hi All" | tr "[:upper:]" "[:lower:]"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How does "cat << EOF" work in bash? (score [797520](https://stackoverflow.com/q/2500436) in 2017)

#### Question
I needed to write a script to enter multi-line input to a program (`psql`).  

After a bit of googling, I found the following syntax works:  

```sh
cat << EOF | psql ---params
BEGIN;

`pg_dump ----something`

update table .... statement ...;

END;
EOF
```

This correctly constructs the multi-line string (from `BEGIN;` to `END;`, inclusive) and pipes it as an input to `psql`.  

But I have no idea how/why it works, can some one please explain?  

I'm referring mainly to `cat &lt;&lt; EOF`, I know `&gt;` outputs to a file, `&gt;&gt;` appends to a file, `&lt;` reads input from file.   

What does `&lt;&lt;` exactly do?  

And is there a man page for it?  

#### Answer accepted (score 466)
This is called <strong><em>heredoc</strong> format</em> to provide a string into stdin. See <a href="https://en.wikipedia.org/wiki/Here_document#Unix_shells" rel="noreferrer">https://en.wikipedia.org/wiki/Here_document#Unix_shells</a> for more details.  

<hr>

From `man bash`:  

<blockquote>
  <h5>Here Documents</h2>
  
  <p>This type of redirection instructs the shell to read input from
  the current source until a line
  containing only word (with no trailing
  blanks)  is  seen.</p>
  
  <p>All of the lines read up to that point are then used as the
  standard input for a command.</p>
  
  The format of here-documents is:  

```sh
          <<[-]word
                  here-document
          delimiter
```
  
  <p>No parameter expansion, command substitution, arithmetic expansion, or
  pathname expansion is performed on
  <strong>word</strong>.  If any characters in <strong>word</strong> are
  quoted, the
  <strong>delimiter</strong> is the result of quote removal on <strong>word</strong>, and the lines
  in the <strong>here-document</strong> are not expanded.
  If <strong>word</strong> is unquoted, all lines of  the
  <strong>here-document</strong>  are  subjected  to  parameter  expansion,  command
  substitution, and arithmetic
  expansion.  In the latter case, the
  character sequence `\&lt;newline&gt;` is
  ignored, and `\` must be used to quote the characters `\`, `$`, and ```.</p>
  
  <p>If the redirection operator is `&lt;&lt;-`, then all leading tab characters
  are stripped from input lines and the
  line containing <strong>delimiter</strong>.   This 
  allows  here-documents within shell scripts to be indented in a natural fashion.</p>
</blockquote>

#### Answer 2 (score 441)
The `cat &lt;&lt;EOF` syntax is very useful when working with multi-line text in Bash, eg. when assigning multi-line string to a shell variable, file or a pipe.  

<h5>Examples of `cat &lt;&lt;EOF` syntax usage in Bash:</h1>

<h5>1. Assign multi-line string to a shell variable</h2>



```sh
$ sql=$(cat <<EOF
SELECT foo, bar FROM db
WHERE foo='baz'
EOF
)
```

<em>The `$sql` variable now holds the new-line characters too. You can verify with `echo -e "$sql"`.</em>  

<h5>2. Pass multi-line string to a file in Bash</h2>

```sh
$ cat <<EOF > print.sh
#!/bin/bash
echo \$PWD
echo $PWD
EOF
```

<em>The `print.sh` file now contains:</em>  

```sh
#!/bin/bash
echo $PWD
echo /home/user
```

<h5>3. Pass multi-line string to a pipe in Bash</h2>

```sh
$ cat <<EOF | grep 'b' | tee b.txt
foo
bar
baz
EOF
```

<em>The `b.txt` file contains `bar` and `baz` lines. The same output is printed to `stdout`.</em>  

#### Answer 3 (score 215)
In your case, "EOF" is known as a "Here Tag". Basically `&lt;&lt;Here` tells the shell that you are going to enter a multiline string until the "tag" `Here`. You can name this tag as you want, it's often `EOF` or `STOP`.  

Some rules about the Here tags:  

<ol>
<li>The tag can be any string, uppercase or lowercase, though most people use uppercase by convention.</li>
<li>The tag will not be considered as a Here tag if there are other words in that line. In this case, it will merely be considered part of the string. The tag should be by itself on a separate line, to be considered a tag.</li>
<li>The tag should have no leading or trailing spaces in that line to be considered a tag. Otherwise it will be considered as part of the string.</li>
</ol>

example:   

```sh
$ cat >> test <<HERE
> Hello world HERE <-- Not by itself on a separate line -> not considered end of string
> This is a test
>  HERE <-- Leading space, so not considered end of string
> and a new line
> HERE <-- Now we have the end of the string
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: How do I pause my shell script for a second before continuing? (score [794111](https://stackoverflow.com/q/21620406) in 2017)

#### Question
I have only found how to wait for user input. However, I only want to pause so that my `while true` doesn't crash my computer.   

I tried `pause(1)`, but it says `-bash: syntax error near unexpected token '1'`. How can it be done?  

#### Answer 2 (score 1092)
Use the `sleep` command.  

Example:  

```sh
sleep .5 # Waits 0.5 second.
sleep 5  # Waits 5 seconds.
sleep 5s # Waits 5 seconds.
sleep 5m # Waits 5 minutes.
sleep 5h # Waits 5 hours.
sleep 5d # Waits 5 days.
```

One can also employ decimals when specifying a time unit; e.g. `sleep 1.5s`  

#### Answer 3 (score 66)
And what about:  

```sh
read -p "Press enter to continue"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: Split string into an array in Bash (score [769103](https://stackoverflow.com/q/10586153) in 2018)

#### Question
In a Bash script I would like to split a line into pieces and store them in an array.  

The line:  

```sh
Paris, France, Europe
```

I would like to have them in an array like this:  

```sh
array[0] = Paris
array[1] = France
array[2] = Europe
```

I would like to use simple code, the command's speed doesn't matter. How can I do it?  

#### Answer accepted (score 984)
```sh
IFS=', ' read -r -a array <<< "$string"
```

Note that the characters in `$IFS` are treated individually as separators so that in this case fields may be separated by <em>either</em> a comma or a space rather than the sequence of the two characters. Interestingly though, empty fields aren't created when comma-space appears in the input because the space is treated specially.  

To access an individual element:  

```sh
echo "${array[0]}"
```

To iterate over the elements:  

```sh
for element in "${array[@]}"
do
    echo "$element"
done
```

To get both the index and the value:  

```sh
for index in "${!array[@]}"
do
    echo "$index ${array[index]}"
done
```

The last example is useful because Bash arrays are sparse. In other words, you can delete an element or add an element and then the indices are not contiguous.  

```sh
unset "array[1]"
array[42]=Earth
```

To get the number of elements in an array:  

```sh
echo "${#array[@]}"
```

As mentioned above, arrays can be sparse so you shouldn't use the length to get the last element. Here's how you can in Bash 4.2 and later:  

```sh
echo "${array[-1]}"
```

in any version of Bash (from somewhere after 2.05b):  

```sh
echo "${array[@]: -1:1}"
```

Larger negative offsets select farther from the end of the array. Note the space before the minus sign in the older form. It is required.  

#### Answer 2 (score 261)
All of the answers to this question are wrong in one way or another.  

<hr>

<a href="https://stackoverflow.com/a/10586169/4272464"><strong><em>Wrong answer #1</em></strong></a>  

```sh
IFS=', ' read -r -a array <<< "$string"
```

<strong>1:</strong> This is a misuse of `$IFS`. The value of the `$IFS` variable is <strong>not</strong> taken as a <em>single variable-length</em> string separator, rather it is taken as a <em>set</em> of <em>single-character</em> string separators, where each field that `read` splits off from the input line can be terminated by <em>any</em> character in the set (comma <strong>or</strong> space, in this example).  

Actually, for the real sticklers out there, the full meaning of `$IFS` is slightly more involved. From the <a href="https://www.gnu.org/software/bash/manual/html_node/Word-Splitting.html#Word-Splitting" rel="noreferrer">bash manual</a>:  

<blockquote>
  The shell treats each character of <strong>IFS</strong> as a delimiter, and splits the results of the other expansions into words using these characters as field terminators. If <strong>IFS</strong> is unset, or its value is exactly <strong>&lt;space&gt;&lt;tab&gt;&lt;newline&gt;</strong>, the default, then sequences of <strong>&lt;space&gt;</strong>, <strong>&lt;tab&gt;</strong>, and <strong>&lt;newline&gt;</strong> at the beginning and end of the results of the previous expansions are ignored, and any sequence of <strong>IFS</strong> characters not at the beginning or end serves to delimit words. If <strong>IFS</strong> has a value other than the default, then sequences of the whitespace characters <strong>&lt;space&gt;</strong>, <strong>&lt;tab&gt;</strong>, and <strong>&lt;newline&gt;</strong> are ignored at the beginning and end of the word, as long as the whitespace character is in the value of <strong>IFS</strong> (an <strong>IFS</strong> whitespace character). Any character in <strong>IFS</strong> that is not <strong>IFS</strong> whitespace, along with any adjacent <strong>IFS</strong> whitespace characters, delimits a field. A sequence of <strong>IFS</strong> whitespace characters is also treated as a delimiter. If the value of <strong>IFS</strong> is null, no word splitting occurs.  
</blockquote>

Basically, for non-default non-null values of `$IFS`, fields can be separated with either (1) a sequence of one or more characters that are all from the set of "IFS whitespace characters" (that is, whichever of <strong>&lt;space&gt;</strong>, <strong>&lt;tab&gt;</strong>, and <strong>&lt;newline&gt;</strong> ("newline" meaning <a href="https://en.wikipedia.org/wiki/Newline" rel="noreferrer">line feed (LF)</a>) are present anywhere in `$IFS`), or (2) any non-"IFS whitespace character" that's present in `$IFS` along with whatever "IFS whitespace characters" surround it in the input line.  

For the OP, it's possible that the second separation mode I described in the previous paragraph is exactly what he wants for his input string, but we can be pretty confident that the first separation mode I described is not correct at all. For example, what if his input string was `'Los Angeles, United States, North America'`?  

```sh
IFS=', ' read -ra a <<<'Los Angeles, United States, North America'; declare -p a;
## declare -a a=([0]="Los" [1]="Angeles" [2]="United" [3]="States" [4]="North" [5]="America")
```

<strong>2:</strong> Even if you were to use this solution with a single-character separator (such as a comma by itself, that is, with no following space or other baggage), if the value of the `$string` variable happens to contain any LFs, then `read` will stop processing once it encounters the first LF. The `read` builtin only processes one line per invocation. This is true even if you are piping or redirecting input <em>only</em> to the `read` statement, as we are doing in this example with the <a href="https://www.gnu.org/software/bash/manual/html_node/Redirections.html#Here-Strings" rel="noreferrer">here-string</a> mechanism, and thus unprocessed input is guaranteed to be lost. The code that powers the `read` builtin has no knowledge of the data flow within its containing command structure.  

You could argue that this is unlikely to cause a problem, but still, it's a subtle hazard that should be avoided if possible. It is caused by the fact that the `read` builtin actually does two levels of input splitting: first into lines, then into fields. Since the OP only wants one level of splitting, this usage of the `read` builtin is not appropriate, and we should avoid it.  

<strong>3:</strong> A non-obvious potential issue with this solution is that `read` always drops the trailing field if it is empty, although it preserves empty fields otherwise. Here's a demo:  

```sh
string=', , a, , b, c, , , '; IFS=', ' read -ra a <<<"$string"; declare -p a;
## declare -a a=([0]="" [1]="" [2]="a" [3]="" [4]="b" [5]="c" [6]="" [7]="")
```

Maybe the OP wouldn't care about this, but it's still a limitation worth knowing about. It reduces the robustness and generality of the solution.  

This problem can be solved by appending a dummy trailing delimiter to the input string just prior to feeding it to `read`, as I will demonstrate later.  

<hr>

<a href="https://stackoverflow.com/a/15400047/4272464"><strong><em>Wrong answer #2</em></strong></a>  

```sh
string="1:2:3:4:5"
set -f                     # avoid globbing (expansion of *).
array=(${string//:/ })
```

<a href="https://stackoverflow.com/a/31405855/4272464">Similar idea:</a>  

```sh
t="one,two,three"
a=($(echo $t | tr ',' "\n"))
```

(Note: I added the missing parentheses around the command substitution which the answerer seems to have omitted.)  

<a href="https://stackoverflow.com/a/37618160/4272464">Similar idea:</a>  

```sh
string="1,2,3,4"
array=(`echo $string | sed 's/,/\n/g'`)
```

These solutions leverage word splitting in an array assignment to split the string into fields. Funnily enough, just like `read`, general word splitting also uses the `$IFS` special variable, although in this case it is implied that it is set to its default value of <strong>&lt;space&gt;&lt;tab&gt;&lt;newline&gt;</strong>, and therefore any sequence of one or more IFS characters (which are all whitespace characters now) is considered to be a field delimiter.  

This solves the problem of two levels of splitting committed by `read`, since word splitting by itself constitutes only one level of splitting. But just as before, the problem here is that the individual fields in the input string can already contain `$IFS` characters, and thus they would be improperly split during the word splitting operation. This happens to not be the case for any of the sample input strings provided by these answerers (how convenient...), but of course that doesn't change the fact that any code base that used this idiom would then run the risk of blowing up if this assumption were ever violated at some point down the line. Once again, consider my counterexample of `'Los Angeles, United States, North America'` (or `'Los Angeles:United States:North America'`).  

Also, word splitting is normally followed by <a href="https://www.gnu.org/software/bash/manual/html_node/Filename-Expansion.html#Filename-Expansion" rel="noreferrer">filename expansion</a> (<em>aka</em> pathname expansion <em>aka</em> globbing), which, if done, would potentially corrupt words containing the characters `*`, `?`, or `[` followed by `]` (and, if `extglob` is set, parenthesized fragments preceded by `?`, `*`, `+`, `@`, or `!`) by matching them against file system objects and expanding the words ("globs") accordingly. The first of these three answerers has cleverly undercut this problem by running `set -f` beforehand to disable globbing. Technically this works (although you should probably add `set +f` afterward to reenable globbing for subsequent code which may depend on it), but it's undesirable to have to mess with global shell settings in order to hack a basic string-to-array parsing operation in local code.  

Another issue with this answer is that all empty fields will be lost. This may or may not be a problem, depending on the application.  

Note: If you're going to use this solution, it's better to use the `${string//:/ }` "pattern substitution" form of <a href="https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html#Shell-Parameter-Expansion" rel="noreferrer">parameter expansion</a>, rather than going to the trouble of invoking a command substitution (which forks the shell), starting up a pipeline, and running an external executable (`tr` or `sed`), since parameter expansion is purely a shell-internal operation. (Also, for the `tr` and `sed` solutions, the input variable should be double-quoted inside the command substitution; otherwise word splitting would take effect in the `echo` command and potentially mess with the field values. Also, the `$(...)` form of command substitution is preferable to the old ``...`` form since it simplifies nesting of command substitutions and allows for better syntax highlighting by text editors.)  

<hr>

<a href="https://stackoverflow.com/a/39474755/4272464"><strong><em>Wrong answer #3</em></strong></a>  

```sh
str="a, b, c, d"  # assuming there is a space after ',' as in Q
arr=(${str//,/})  # delete all occurrences of ','
```

This answer is almost the same as <strong>#2</strong>. The difference is that the answerer has made the assumption that the fields are delimited by two characters, one of which being represented in the default `$IFS`, and the other not. He has solved this rather specific case by removing the non-IFS-represented character using a pattern substitution expansion and then using word splitting to split the fields on the surviving IFS-represented delimiter character.  

This is not a very generic solution. Furthermore, it can be argued that the comma is really the "primary" delimiter character here, and that stripping it and then depending on the space character for field splitting is simply wrong. Once again, consider my counterexample: `'Los Angeles, United States, North America'`.  

Also, again, filename expansion could corrupt the expanded words, but this can be prevented by temporarily disabling globbing for the assignment with `set -f` and then `set +f`.  

Also, again, all empty fields will be lost, which may or may not be a problem depending on the application.  

<hr>

<a href="https://stackoverflow.com/a/13196466/4272464"><strong><em>Wrong answer #4</em></strong></a>  

```sh
string='first line
second line
third line'

oldIFS="$IFS"
IFS='
'
IFS=${IFS:0:1} # this is useful to format your code with tabs
lines=( $string )
IFS="$oldIFS"
```

This is similar to <strong>#2</strong> and <strong>#3</strong> in that it uses word splitting to get the job done, only now the code explicitly sets `$IFS` to contain only the single-character field delimiter present in the input string. It should be repeated that this cannot work for multicharacter field delimiters such as the OP's comma-space delimiter. But for a single-character delimiter like the LF used in this example, it actually comes close to being perfect. The fields cannot be unintentionally split in the middle as we saw with previous wrong answers, and there is only one level of splitting, as required.  

One problem is that filename expansion will corrupt affected words as described earlier, although once again this can be solved by wrapping the critical statement in `set -f` and `set +f`.  

Another potential problem is that, since LF qualifies as an "IFS whitespace character" as defined earlier, all empty fields will be lost, just as in <strong>#2</strong> and <strong>#3</strong>. This would of course not be a problem if the delimiter happens to be a non-"IFS whitespace character", and depending on the application it may not matter anyway, but it does vitiate the generality of the solution.  

So, to sum up, assuming you have a one-character delimiter, and it is either a non-"IFS whitespace character" or you don't care about empty fields, and you wrap the critical statement in `set -f` and `set +f`, then this solution works, but otherwise not.  

(Also, for information's sake, assigning a LF to a variable in bash can be done more easily with the `$'...'` syntax, e.g. `IFS=$'\n';`.)  

<hr>

<a href="https://stackoverflow.com/a/41225957/4272464"><strong><em>Wrong answer #5</em></strong></a>  

```sh
countries='Paris, France, Europe'
OIFS="$IFS"
IFS=', ' array=($countries)
IFS="$OIFS"
```

<a href="https://stackoverflow.com/a/30744597/4272464">Similar idea:</a>  

```sh
IFS=', ' eval 'array=($string)'
```

This solution is effectively a cross between <strong>#1</strong> (in that it sets `$IFS` to comma-space) and <strong>#2-4</strong> (in that it uses word splitting to split the string into fields). Because of this, it suffers from most of the problems that afflict all of the above wrong answers, sort of like the worst of all worlds.  

Also, regarding the second variant, it may seem like the `eval` call is completely unnecessary, since its argument is a single-quoted string literal, and therefore is statically known. But there's actually a very non-obvious benefit to using `eval` in this way. Normally, when you run a simple command which consists of a variable assignment <em>only</em>, meaning without an actual command word following it, the assignment takes effect in the shell environment:  

```sh
IFS=', '; ## changes $IFS in the shell environment
```

This is true even if the simple command involves <em>multiple</em> variable assignments; again, as long as there's no command word, all variable assignments affect the shell environment:  

```sh
IFS=', ' array=($countries); ## changes both $IFS and $array in the shell environment
```

But, if the variable assignment is attached to a command name (I like to call this a "prefix assignment") then it does <em>not</em> affect the shell environment, and instead only affects the environment of the executed command, regardless whether it is a builtin or external:  

```sh
IFS=', ' :; ## : is a builtin command, the $IFS assignment does not outlive it
IFS=', ' env; ## env is an external command, the $IFS assignment does not outlive it
```

Relevant quote from the <a href="https://www.gnu.org/software/bash/manual/html_node/Simple-Command-Expansion.html#Simple-Command-Expansion" rel="noreferrer">bash manual</a>:  

<blockquote>
  If no command name results, the variable assignments affect the current shell environment. Otherwise, the variables are added to the environment of the executed command and do not affect the current shell environment.  
</blockquote>

It is possible to exploit this feature of variable assignment to change `$IFS` only temporarily, which allows us to avoid the whole save-and-restore gambit like that which is being done with the `$OIFS` variable in the first variant. But the challenge we face here is that the command we need to run is itself a mere variable assignment, and hence it would not involve a command word to make the `$IFS` assignment temporary. You might think to yourself, well why not just add a no-op command word to the statement like the <a href="https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#Bourne-Shell-Builtins" rel="noreferrer">`: builtin`</a> to make the `$IFS` assignment temporary? This does not work because it would then make the `$array` assignment temporary as well:  

```sh
IFS=', ' array=($countries) :; ## fails; new $array value never escapes the : command
```

So, we're effectively at an impasse, a bit of a catch-22. But, when `eval` runs its code, it runs it in the shell environment, as if it was normal, static source code, and therefore we can run the `$array` assignment inside the `eval` argument to have it take effect in the shell environment, while the `$IFS` prefix assignment that is prefixed to the `eval` command will not outlive the `eval` command. This is exactly the trick that is being used in the second variant of this solution:  

```sh
IFS=', ' eval 'array=($string)'; ## $IFS does not outlive the eval command, but $array does
```

So, as you can see, it's actually quite a clever trick, and accomplishes exactly what is required (at least with respect to assignment effectation) in a rather non-obvious way. I'm actually not against this trick in general, despite the involvement of `eval`; just be careful to single-quote the argument string to guard against security threats.  

But again, because of the "worst of all worlds" agglomeration of problems, this is still a wrong answer to the OP's requirement.  

<hr>

<a href="https://stackoverflow.com/a/35789043/4272464"><strong><em>Wrong answer #6</em></strong></a>  

```sh
IFS=', '; array=(Paris, France, Europe)

IFS=' ';declare -a array=(Paris France Europe)
```

Um... what? The OP has a string variable that needs to be parsed into an array. This "answer" starts with the verbatim contents of the input string pasted into an array literal. I guess that's one way to do it.  

It looks like the answerer may have assumed that the `$IFS` variable affects all bash parsing in all contexts, which is not true. From the bash manual:  

<blockquote>
  <strong>IFS</strong>&nbsp;&nbsp;&nbsp;&nbsp;The Internal Field Separator that is used for word splitting after expansion and to split lines into words with the <strong>read</strong> builtin command. The default value is <strong>&lt;space&gt;&lt;tab&gt;&lt;newline&gt;</strong>.  
</blockquote>

So the `$IFS` special variable is actually only used in two contexts: (1) word splitting that is performed <em>after expansion</em> (meaning <em>not</em> when parsing bash source code) and (2) for splitting input lines into words by the `read` builtin.  

Let me try to make this clearer. I think it might be good to draw a distinction between <em>parsing</em> and <em>execution</em>. Bash must first <em>parse</em> the source code, which obviously is a <em>parsing</em> event, and then later it <em>executes</em> the code, which is when expansion comes into the picture. Expansion is really an <em>execution</em> event. Furthermore, I take issue with the description of the `$IFS` variable that I just quoted above; rather than saying that word splitting is performed <em>after expansion</em>, I would say that word splitting is performed <em>during</em> expansion, or, perhaps even more precisely, word splitting is <em>part of</em> the expansion process. The phrase "word splitting" refers only to this step of expansion; it should never be used to refer to the parsing of bash source code, although unfortunately the docs do seem to throw around the words "split" and "words" a lot. Here's a relevant excerpt from the <a href="https://linux.die.net/man/1/bash#Expansion" rel="noreferrer">linux.die.net version</a> of the bash manual:  

<blockquote>
  Expansion is performed on the command line after it has been split into words. There are seven kinds of expansion performed: <em>brace expansion</em>, <em>tilde expansion</em>, <em>parameter and variable expansion</em>, <em>command substitution</em>, <em>arithmetic expansion</em>, <em>word splitting</em>, and <em>pathname expansion</em>.  
  
  The order of expansions is: brace expansion; tilde expansion, parameter and variable expansion, arithmetic expansion, and command substitution (done in a left-to-right fashion); word splitting; and pathname expansion.  
</blockquote>

You could argue the <a href="https://www.gnu.org/software/bash/manual/html_node/Shell-Expansions.html#Shell-Expansions" rel="noreferrer">GNU version</a> of the manual does slightly better, since it opts for the word "tokens" instead of "words" in the first sentence of the Expansion section:  

<blockquote>
  Expansion is performed on the command line after it has been split into tokens.  
</blockquote>

The important point is, `$IFS` does not change the way bash parses source code. Parsing of bash source code is actually a very complex process that involves recognition of the various elements of shell grammar, such as command sequences, command lists, pipelines, parameter expansions, arithmetic substitutions, and command substitutions. For the most part, the bash parsing process cannot be altered by user-level actions like variable assignments (actually, there are some minor exceptions to this rule; for example, see the various <a href="https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html#The-Shopt-Builtin" rel="noreferrer">`compatxx` shell settings</a>, which can change certain aspects of parsing behavior on-the-fly). The upstream "words"/"tokens" that result from this complex parsing process are then expanded according to the general process of "expansion" as broken down in the above documentation excerpts, where word splitting of the expanded (expanding?) text into downstream words is simply one step of that process. Word splitting only touches text that has been spit out of a preceding expansion step; it does not affect literal text that was parsed right off the source bytestream.  

<hr>

<a href="https://stackoverflow.com/a/31620022/4272464"><strong><em>Wrong answer #7</em></strong></a>  

```sh
string='first line
        second line
        third line'

while read -r line; do lines+=("$line"); done <<<"$string"
```

This is one of the best solutions. Notice that we're back to using `read`. Didn't I say earlier that `read` is inappropriate because it performs two levels of splitting, when we only need one? The trick here is that you can call `read` in such a way that it effectively only does one level of splitting, specifically by splitting off only one field per invocation, which necessitates the cost of having to call it repeatedly in a loop. It's a bit of a sleight of hand, but it works.  

But there are problems. First: When you provide at least one <em>NAME</em> argument to `read`, it automatically ignores leading and trailing whitespace in each field that is split off from the input string. This occurs whether `$IFS` is set to its default value or not, as described earlier in this post. Now, the OP may not care about this for his specific use-case, and in fact, it may be a desirable feature of the parsing behavior. But not everyone who wants to parse a string into fields will want this. There is a solution, however: A somewhat non-obvious usage of `read` is to pass zero <em>NAME</em> arguments. In this case, `read` will store the entire input line that it gets from the input stream in a variable named `$REPLY`, and, as a bonus, it does <em>not</em> strip leading and trailing whitespace from the value. This is a very robust usage of `read` which I've exploited frequently in my shell programming career. Here's a demonstration of the difference in behavior:  

```sh
string=$'  a  b  \n  c  d  \n  e  f  '; ## input string

a=(); while read -r line; do a+=("$line"); done <<<"$string"; declare -p a;
## declare -a a=([0]="a  b" [1]="c  d" [2]="e  f") ## read trimmed surrounding whitespace

a=(); while read -r; do a+=("$REPLY"); done <<<"$string"; declare -p a;
## declare -a a=([0]="  a  b  " [1]="  c  d  " [2]="  e  f  ") ## no trimming
```

The second issue with this solution is that it does not actually address the case of a custom field separator, such as the OP's comma-space. As before, multicharacter separators are not supported, which is an unfortunate limitation of this solution. We could try to at least split on comma by specifying the separator to the `-d` option, but look what happens:  

```sh
string='Paris, France, Europe';
a=(); while read -rd,; do a+=("$REPLY"); done <<<"$string"; declare -p a;
## declare -a a=([0]="Paris" [1]=" France")
```

Predictably, the unaccounted surrounding whitespace got pulled into the field values, and hence this would have to be corrected subsequently through trimming operations (this could also be done directly in the while-loop). But there's another obvious error: Europe is missing! What happened to it? The answer is that `read` returns a failing return code if it hits end-of-file (in this case we can call it end-of-string) without encountering a final field terminator on the final field. This causes the while-loop to break prematurely and we lose the final field.  

Technically this same error afflicted the previous examples as well; the difference there is that the field separator was taken to be LF, which is the default when you don't specify the `-d` option, and the `&lt;&lt;&lt;` ("here-string") mechanism automatically appends a LF to the string just before it feeds it as input to the command. Hence, in those cases, we sort of <em>accidentally</em> solved the problem of a dropped final field by unwittingly appending an additional dummy terminator to the input. Let's call this solution the "dummy-terminator" solution. We can apply the dummy-terminator solution manually for any custom delimiter by concatenating it against the input string ourselves when instantiating it in the here-string:  

```sh
a=(); while read -rd,; do a+=("$REPLY"); done <<<"$string,"; declare -p a;
declare -a a=([0]="Paris" [1]=" France" [2]=" Europe")
```

There, problem solved. Another solution is to only break the while-loop if both (1) `read` returned failure and (2) `$REPLY` is empty, meaning `read` was not able to read any characters prior to hitting end-of-file. Demo:  

```sh
a=(); while read -rd,|| [[ -n "$REPLY" ]]; do a+=("$REPLY"); done <<<"$string"; declare -p a;
## declare -a a=([0]="Paris" [1]=" France" [2]=$' Europe\n')
```

This approach also reveals the secretive LF that automatically gets appended to the here-string by the `&lt;&lt;&lt;` redirection operator. It could of course be stripped off separately through an explicit trimming operation as described a moment ago, but obviously the manual dummy-terminator approach solves it directly, so we could just go with that. The manual dummy-terminator solution is actually quite convenient in that it solves both of these two problems (the dropped-final-field problem and the appended-LF problem) in one go.  

So, overall, this is quite a powerful solution. It's only remaining weakness is a lack of support for multicharacter delimiters, which I will address later.  

<hr>

<a href="https://stackoverflow.com/a/31620022/4272464"><strong><em>Wrong answer #8</em></strong></a>  

```sh
string='first line
        second line
        third line'

readarray -t lines <<<"$string"
```

(This is actually from the same post as <strong>#7</strong>; the answerer provided two solutions in the same post.)  

The `readarray` builtin, which is a synonym for `mapfile`, is ideal. It's a builtin command which parses a bytestream into an array variable in one shot; no messing with loops, conditionals, substitutions, or anything else. And it doesn't surreptitiously strip any whitespace from the input string. And (if `-O` is not given) it conveniently clears the target array before assigning to it. But it's still not perfect, hence my criticism of it as a "wrong answer".  

First, just to get this out of the way, note that, just like the behavior of `read` when doing field-parsing, `readarray` drops the trailing field if it is empty. Again, this is probably not a concern for the OP, but it could be for some use-cases. I'll come back to this in a moment.  

Second, as before, it does not support multicharacter delimiters. I'll give a fix for this in a moment as well.  

Third, the solution as written does not parse the OP's input string, and in fact, it cannot be used as-is to parse it. I'll expand on this momentarily as well.  

For the above reasons, I still consider this to be a "wrong answer" to the OP's question. Below I'll give what I consider to be the right answer.  

<hr>

<strong>Right answer</strong>  

Here's a naïve attempt to make <strong>#8</strong> work by just specifying the `-d` option:  

```sh
string='Paris, France, Europe';
readarray -td, a <<<"$string"; declare -p a;
## declare -a a=([0]="Paris" [1]=" France" [2]=$' Europe\n')
```

We see the result is identical to the result we got from the double-conditional approach of the looping `read` solution discussed in <strong>#7</strong>. We can <em>almost</em> solve this with the manual dummy-terminator trick:  

```sh
readarray -td, a <<<"$string,"; declare -p a;
## declare -a a=([0]="Paris" [1]=" France" [2]=" Europe" [3]=$'\n')
```

The problem here is that `readarray` preserved the trailing field, since the `&lt;&lt;&lt;` redirection operator appended the LF to the input string, and therefore the trailing field was <em>not</em> empty (otherwise it would've been dropped). We can take care of this by explicitly unsetting the final array element after-the-fact:  

```sh
readarray -td, a <<<"$string,"; unset 'a[-1]'; declare -p a;
## declare -a a=([0]="Paris" [1]=" France" [2]=" Europe")
```

The only two problems that remain, which are actually related, are (1) the extraneous whitespace that needs to be trimmed, and (2) the lack of support for multicharacter delimiters.  

The whitespace could of course be trimmed afterward (for example, see <a href="https://stackoverflow.com/questions/369758/how-to-trim-whitespace-from-a-bash-variable">How to trim whitespace from a Bash variable?</a>). But if we can hack a multicharacter delimiter, then that would solve both problems in one shot.  

Unfortunately, there's no <em>direct</em> way to get a multicharacter delimiter to work. The best solution I've thought of is to preprocess the input string to replace the multicharacter delimiter with a single-character delimiter that will be guaranteed not to collide with the contents of the input string. The only character that has this guarantee is the <a href="https://en.wikipedia.org/wiki/Null_character" rel="noreferrer">NUL byte</a>. This is because, in bash (though not in zsh, incidentally), variables cannot contain the NUL byte. This preprocessing step can be done inline in a process substitution. Here's how to do it using <a href="https://www.gnu.org/software/gawk/" rel="noreferrer">awk</a>:  

```sh
readarray -td '' a < <(awk '{ gsub(/, /,"\0"); print; }' <<<"$string, "); unset 'a[-1]';
declare -p a;
## declare -a a=([0]="Paris" [1]="France" [2]="Europe")
```

There, finally! This solution will not erroneously split fields in the middle, will not cut out prematurely, will not drop empty fields, will not corrupt itself on filename expansions, will not automatically strip leading and trailing whitespace, will not leave a stowaway LF on the end, does not require loops, and does not settle for a single-character delimiter.  

<hr>

<strong>Trimming solution</strong>  

Lastly, I wanted to demonstrate my own fairly intricate trimming solution using the obscure `-C callback` option of `readarray`. Unfortunately, I've run out of room against Stack Overflow's draconian 30,000 character post limit, so I won't be able to explain it. I'll leave that as an exercise for the reader.  

```sh
function mfcb { local val="$4"; "$1"; eval "$2[$3]=\$val;"; };
function val_ltrim { if [[ "$val" =~ ^[[:space:]]+ ]]; then val="${val:${#BASH_REMATCH[0]}}"; fi; };
function val_rtrim { if [[ "$val" =~ [[:space:]]+$ ]]; then val="${val:0:${#val}-${#BASH_REMATCH[0]}}"; fi; };
function val_trim { val_ltrim; val_rtrim; };
readarray -c1 -C 'mfcb val_trim a' -td, <<<"$string,"; unset 'a[-1]'; declare -p a;
## declare -a a=([0]="Paris" [1]="France" [2]="Europe")
```

#### Answer 3 (score 211)
Here is a way without setting IFS:  

```sh
string="1:2:3:4:5"
set -f                      # avoid globbing (expansion of *).
array=(${string//:/ })
for i in "${!array[@]}"
do
    echo "$i=>${array[i]}"
done
```

The idea is using string replacement:  

```sh
${string//substring/replacement}
```

to replace all matches of $substring with white space and then using the substituted string to initialize a array:  

```sh
(element1 element2 ... elementN)
```

Note: this answer makes use of the <a href="https://unix.stackexchange.com/q/108963/79743">split+glob operator</a>. Thus, to prevent expansion of some characters (such as `*`) it is a good idea to pause globbing for this script.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: Comparing numbers in Bash (score [765855](https://stackoverflow.com/q/18668556) in 2019)

#### Question
I'm starting to learn about writing scripts for the bash terminal, but I can't work out how to get the comparisons to work properly. The script I'm using is:  

```sh
echo "enter two numbers";
read a b;

echo "a=$a";
echo "b=$b";

if [ $a \> $b ];
then 
    echo "a is greater than b";
else
    echo "b is greater than a";
fi;
```

The problem is that it compares the number from the first digit on, i.e. 9 is bigger than 10, but 1 is greater than 09.  

How can I convert the numbers into a type to do a true comparison?  

#### Answer accepted (score 759)
In bash, you should do your check in <a href="http://mywiki.wooledge.org/ArithmeticExpression">arithmetic context</a>:  

```sh
if (( a > b )); then
    ...
fi
```

For POSIX shells that don't support `(())`, you can use `-lt` and `-gt`.  

```sh
if [ "$a" -gt "$b" ]; then
    ...
fi
```

You can get a full list of comparison operators with `help test`.  

#### Answer 2 (score 145)
Plain and simple  

```sh
#!/bin/bash

a=2462620
b=2462620

if [ "$a" -eq "$b" ];then
  echo "They're equal";
fi
```

You can check out <a href="https://devhints.io/bash" rel="noreferrer">this cheatsheet</a> if you want more number comparsions in the wonderful world of Bash Scripting.  

Shortly, integers can only be compared with:  

```sh
-eq # equal
-ne # not equal
-lt # less than
-le # less than or equal
-gt # greater than
-ge # greater than or equal
```

#### Answer 3 (score 36)
There is also one nice thing some people might not know about:  

```sh
echo $(( a < b ? a : b ))
```

This code will print the smallest number out of `a` and `b`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: Listing only directories using ls in bash: An examination (score [761868](https://stackoverflow.com/q/14352290) in 2015)

#### Question
This command lists directories in the current path: `ls -d */`  

What exactly does the pattern `*/` do?  

And how can we give the absolute path in the above command (e.g. `ls -d /home/alice/Documents`) for listing only directories in that path?  

#### Answer accepted (score 914)
`*/` is a pattern that matches all of the subdirectories in the current directory (`*` would match all files <em>and</em> subdirectories; the `/` restricts it to directories). Similarly, to list all subdirectories under /home/alice/Documents, use `ls -d /home/alice/Documents/*/`  

#### Answer 2 (score 456)
<h5>Four ways to get this done, each with a different output format</h2>

<h5>1. Using `echo`</h3>

<p>Example: `echo */`, `echo */*/`<br/>
Here is what I got: </p>

```sh
cs/ draft/ files/ hacks/ masters/ static/  
cs/code/ files/images/ static/images/ static/stylesheets/  
```

<h5>2. Using `ls` only</h3>

<p>Example: `ls -d */`<br/>
Here is exactly what I got: </p>

```sh
cs/     files/      masters/  
draft/  hacks/      static/  
```

Or as list (with detail info): `ls -dl */`    

<h5>3. Using `ls` and `grep`</h3>

<p>Example: `ls -l | grep "^d"`
Here is what I got:</p>

```sh
drwxr-xr-x  24 h  staff     816 Jun  8 10:55 cs  
drwxr-xr-x   6 h  staff     204 Jun  8 10:55 draft  
drwxr-xr-x   9 h  staff     306 Jun  8 10:55 files  
drwxr-xr-x   2 h  staff      68 Jun  9 13:19 hacks  
drwxr-xr-x   6 h  staff     204 Jun  8 10:55 masters  
drwxr-xr-x   4 h  staff     136 Jun  8 10:55 static  
```

<h5>4. Bash Script (Not recommended for filename containing spaces)</h3>

<p>Example: `for i in $(ls -d */); do echo ${i%%/}; done`<br/>
Here is what I got:</p>

```sh
cs  
draft  
files  
hacks  
masters  
static
```

If you like to have '/' as ending character, the command will be: `for i in $(ls -d */); do echo ${i}; done`  

```sh
cs/  
draft/  
files/  
hacks/  
masters/  
static/
```

#### Answer 3 (score 90)
I use:  

```sh
ls -d */ | cut -f1 -d'/'
```

This creates a single column with no trailing slash - useful in scripts.  

My two cents.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: How to represent multiple conditions in a shell if statement? (score [751876](https://stackoverflow.com/q/3826425) in 2017)

#### Question
I want to represent multiple conditions like this:  

```sh
if [ ( $g -eq 1 -a "$c" = "123" ) -o ( $g -eq 2 -a "$c" = "456" ) ]   
then  
    echo abc;  
else  
    echo efg;   
fi  
```

but when I execute the script, it shows  

```sh
syntax error at line 15: `[' unexpected, 
```

where line 15 is the one showing if ....    

What is wrong with this condition? I guess something is wrong with the `()`.  

#### Answer accepted (score 351)
Classic technique (escape metacharacters):  

```sh
if [ \( "$g" -eq 1 -a "$c" = "123" \) -o \( "$g" -eq 2 -a "$c" = "456" \) ]
then echo abc
else echo efg
fi
```

I've enclosed the references to `$g` in double quotes; that's good practice, in general.  Strictly, the parentheses aren't needed because the precedence of `-a` and `-o` makes it correct even without them.  

Note that the `-a` and `-o` operators are part of the POSIX specification for <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html" rel="noreferrer">`test`</a>, aka `[`, mainly for backwards compatibility (since they were a part of `test` in 7th Edition UNIX, for example), but they are explicitly marked as 'obsolescent' by POSIX.  Bash (see <a href="http://www.gnu.org/software/bash/manual/bash.html#Bash-Conditional-Expressions" rel="noreferrer">conditional expressions</a>) seems to preempt the classic and POSIX meanings for `-a` and `-o` with its own alternative operators that take arguments.  

<hr>

With some care, you can use the more modern `[[` operator, but be aware that the versions in Bash and Korn Shell (for example) need not be identical.  

```sh
for g in 1 2 3
do
    for c in 123 456 789
    do
        if [[ ( "$g" -eq 1 && "$c" = "123" ) || ( "$g" -eq 2 && "$c" = "456" ) ]]
        then echo "g = $g; c = $c; true"
        else echo "g = $g; c = $c; false"
        fi
    done
done
```

Example run, using Bash 3.2.57 on Mac OS X:  

```sh
g = 1; c = 123; true
g = 1; c = 456; false
g = 1; c = 789; false
g = 2; c = 123; false
g = 2; c = 456; true
g = 2; c = 789; false
g = 3; c = 123; false
g = 3; c = 456; false
g = 3; c = 789; false
```

You don't need to quote the variables in `[[` as you do with `[` because it is not a separate command in the same way that `[` is.  

<hr>

<blockquote>
  Isn't it a classic question?  
</blockquote>

I would have thought so.  However, there is another alternative, namely:  

```sh
if [ "$g" -eq 1 -a "$c" = "123" ] || [ "$g" -eq 2 -a "$c" = "456" ]
then echo abc
else echo efg
fi
```

Indeed, if you read the 'portable shell' guidelines for the `autoconf` tool or related packages, this notation — using '`||`' and '`&amp;&amp;`' — is what they recommend.  I suppose you could even go so far as:  

```sh
if [ "$g" -eq 1 ] && [ "$c" = "123" ]
then echo abc
elif [ "$g" -eq 2 ] && [ "$c" = "456" ]
then echo abc
else echo efg
fi
```

Where the actions are as trivial as echoing, this isn't bad.  When the action block to be repeated is multiple lines, the repetition is too painful and one of the earlier versions is preferable — or you need to wrap the actions into a function that is invoked in the different `then` blocks.  

#### Answer 2 (score 174)
In Bash:  

```sh
if [[ ( $g == 1 && $c == 123 ) || ( $g == 2 && $c == 456 ) ]]
```

#### Answer 3 (score 30)
Using `/bin/bash` the following will work:  

```sh
if [ "$option" = "Y" ] || [ "$option" = "y" ]; then
    echo "Entered $option"
fi
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: How to count all the lines of code in a directory recursively? (score [718292](https://stackoverflow.com/q/1358540) in 2012)

#### Question
We've got a PHP application and want to count all the lines of code under a specific directory and its subdirectories.  We don't need to ignore comments, as we're just trying to get a rough idea.   

```sh
wc -l *.php 
```

That command works great within a given directory, but ignores subdirectories.  I was thinking this might work, but it is returning 74, which is definitely not the case...  

```sh
find . -name '*.php' | wc -l
```

What's the correct syntax to feed in all the files?    

#### Answer accepted (score 2494)
<strong>Try:</strong>  

```sh
find . -name '*.php' | xargs wc -l
```

<strong><a href="http://www.dwheeler.com/sloccount/" rel="noreferrer">The SLOCCount tool</a></strong> may help as well.  

<p>It'll give an accurate source lines of code count for whatever
hierarchy you point it at, as well as some additional stats.</p>

<strong>Sorted output:</strong> `find . -name '*.php' | xargs wc -l | sort -nr`  

#### Answer 2 (score 450)
For another one-liner:  

```sh
( find ./ -name '*.php' -print0 | xargs -0 cat ) | wc -l
```

works on names with spaces, only outputs one number.  

#### Answer 3 (score 383)
If using a decently recent version of Bash (or ZSH), it's much simpler:  

```sh
wc -l **/*.php
```

In the Bash shell this requires the `globstar` option to be set, otherwise the `**` glob-operator is not recursive. To enable this setting, issue  

```sh
shopt -s globstar
```

To make this permanent, add it to one of the initialization files (`~/.bashrc`, `~/.bash_profile` etc.).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Replace one substring for another string in shell script (score [712335](https://stackoverflow.com/q/13210880) in 2015)

#### Question
I have "I love Suzi and Marry" and I want to change "Suzi" to "Sara".  

```sh
#!/bin/bash
firstString="I love Suzi and Marry"
secondString="Sara"
# do something...
```

The result must be like this:  

```sh
firstString="I love Sara and Marry"
```

#### Answer accepted (score 1112)
To replace the <em>first</em> occurrence of a pattern with a given string, use `${<em>parameter</em>/<em>pattern</em>/<em>string</em>}`:  

```sh
#!/bin/bash
firstString="I love Suzi and Marry"
secondString="Sara"
echo "${firstString/Suzi/$secondString}"    
# prints 'I love Sara and Marry'
```

To replace <em>all</em> occurrences, use `${<em>parameter</em>//<em>pattern</em>/<em>string</em>}`:  

```sh
message='The secret code is 12345'
echo "${message//[0-9]/X}"           
# prints 'The secret code is XXXXX'
```

(This is documented in <a href="https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion" rel="noreferrer">the <em>Bash Reference Manual</em>, &sect;3.5.3 "Shell Parameter Expansion"</a>.)  

Note that this feature is not specified by POSIX &mdash; it's a Bash extension &mdash; so not all Unix shells implement it. For the relevant POSIX documentation, see <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02" rel="noreferrer"><em>The Open Group Technical Standard Base Specifications, Issue 7</em>, the <em>Shell &amp; Utilities</em> volume, &sect;2.6.2 "Parameter Expansion"</a>.  

#### Answer 2 (score 176)
This can be done entirely with bash string manipulation:  

```sh
first="I love Suzy and Mary"
second="Sara"
first=${first/Suzy/$second}
```

That will replace only the first occurrence; to replace them all, double the first slash:  

```sh
first="Suzy, Suzy, Suzy"
second="Sara"
first=${first//Suzy/$second}
# first is now "Sara, Sara, Sara"
```

#### Answer 3 (score 60)
try this:  

```sh
 sed "s/Suzi/$secondString/g" <<<"$firstString"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Setting environment variables on OS X (score [696397](https://stackoverflow.com/q/135688) in 2018)

#### Question
What is the proper way to modify environment variables like PATH in OS&nbsp;X?  

I've looked on Google a little bit and found three different files to edit:  

<ul>
<li>/etc/paths</li>
<li>~/.profile</li>
<li>~/.tcshrc</li>
</ul>

I don't even have some of these files, and I'm pretty sure that <em>.tcshrc</em> is wrong, since OS&nbsp;X uses bash now. Where are these variables, especially PATH, defined?  

I'm running <a href="http://en.wikipedia.org/wiki/Mac_OS_X_Leopard" rel="noreferrer">OS&nbsp;X&nbsp;v10.5</a> (Leopard).  

#### Answer 2 (score 644)
Bruno is right on track. I've done extensive research and if you want to set variables that are available in all GUI applications, your only option is `/etc/launchd.conf`.  

Please note that <a href="https://web.archive.org/web/20100212232552/https://www.digitaledgesw.com/node/31" rel="noreferrer">environment.plist does not work for applications launched via Spotlight. This is documented by Steve Sexton here</a>.  

<ol>
<li><p>Open a terminal prompt</p></li>
<li><p>Type `sudo vi /etc/launchd.conf` (note: this file might not yet exist)</p></li>
<li><p>Put contents like the following into the file</p>

```sh
# Set environment variables here so they are available globally to all apps
# (and Terminal), including those launched via Spotlight.
#
# After editing this file run the following command from the terminal to update
# environment variables globally without needing to reboot.
# NOTE: You will still need to restart the relevant application (including
# Terminal) to pick up the changes!
# grep -E "^setenv" /etc/launchd.conf | xargs -t -L 1 launchctl
#
# See http://www.digitaledgesw.com/node/31
# and http://stackoverflow.com/questions/135688/setting-environment-variables-in-os-x/
#
# Note that you must hardcode the paths below, don't use environment variables.
# You also need to surround multiple values in quotes, see MAVEN_OPTS example below.
#
setenv JAVA_VERSION 1.6
setenv JAVA_HOME /System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
setenv GROOVY_HOME /Applications/Dev/groovy
setenv GRAILS_HOME /Applications/Dev/grails
setenv NEXUS_HOME /Applications/Dev/nexus/nexus-webapp
setenv JRUBY_HOME /Applications/Dev/jruby

setenv ANT_HOME /Applications/Dev/apache-ant
setenv ANT_OPTS -Xmx512M

setenv MAVEN_OPTS "-Xmx1024M -XX:MaxPermSize=512m"
setenv M2_HOME /Applications/Dev/apache-maven

setenv JMETER_HOME /Applications/Dev/jakarta-jmeter
```</li>
<li><p>Save your changes in vi and reboot your Mac. Or use the <a href="http://linux.die.net/man/1/grep" rel="noreferrer">`grep`</a>/<a href="https://linux.die.net/man/1/xargs" rel="noreferrer">`xargs`</a> command which is shown in the code comment above.</p></li>
<li><p>Prove that your variables are working by opening a Terminal window and typing `export` and you should see your new variables.  These will also be available in IntelliJ IDEA and other GUI applications you launch via Spotlight.</p></li>
</ol>

#### Answer 3 (score 256)
<h5>How to set the environment for new processes started by Spotlight (without needing to reboot)</h1>

You can set the environment used by launchd (and, by extension, anything started from Spotlight) with `launchctl setenv`. For example to set the path:  

```sh
launchctl setenv PATH /opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
```

Or if you want to set up your path in `.bashrc` or similar, then have it mirrored in launchd:  

```sh
PATH=/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
launchctl setenv PATH $PATH
```

<strong>There's no need to reboot</strong> though you will need to restart an app if you want it to pick up the changed environment.  

This includes any shells already running under Terminal.app, although if you're there you can set the environment more directly, e.g. with `export PATH=/opt/local/bin:/opt/local/sbin:$PATH` for bash or zsh.  

<h5>How to keeping changes after a reboot</h1>

To <strong>keep changes after a reboot</strong> you can set the environment variables from `/etc/launchd.conf`, like so:  

```sh
setenv PATH /opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
```

`launchd.conf` is executed automatically when you reboot.  

If you want these changes to take effect now, you should use this command to reprocess `launchctl.conf` (thanks @mklement for the tip!)  

```sh
egrep -v '^\s*#' /etc/launchd.conf | launchctl
```

You can find out more about `launchctl` and how it loads `launchd.conf` with the command `man launchctl`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Check number of arguments passed to a Bash script (score [696353](https://stackoverflow.com/q/18568706) in 2019)

#### Question
I would like my Bash script to print an error message if the required argument count is not met.  

I tried the following code:  

```sh
#!/bin/bash
echo Script name: $0
echo $# arguments 
if [$# -ne 1]; 
    then echo "illegal number of parameters"
fi
```

For some unknown reason I've got the following error:  

```sh
test: line 4: [2: command not found
```

What am I doing wrong?  

#### Answer accepted (score 973)
Just like any other simple command, `[ ... ]` or `test` requires spaces between its arguments.  

```sh
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
fi
```

Or  

```sh
if test "$#" -ne 1; then
    echo "Illegal number of parameters"
fi
```

<h5>Suggestions</h3>

When in Bash, prefer using `[[ ]]` instead as it doesn't do word splitting and pathname expansion to its variables that quoting may not be necessary unless it's part of an expression.  

```sh
[[ $# -ne 1 ]]
```

It also has some other features like unquoted condition grouping, pattern matching (extended pattern matching with `extglob`) and regex matching.  

The following example checks if arguments are valid. It allows a single argument or two.  

```sh
[[ ($# -eq 1 || ($# -eq 2 && $2 == <glob pattern>)) && $1 =~ <regex pattern> ]]
```

For pure arithmetic expressions, using `(( ))` to some may still be better, but they are still possible in `[[ ]]` with its arithmetic operators like `-eq`, `-ne`, `-lt`, `-le`, `-gt`, or `-ge` by placing the expression as a single string argument:  

```sh
A=1
[[ 'A + 1' -eq 2 ]] && echo true  ## Prints true.
```

That should be helpful if you would need to combine it with other features of `[[ ]]` as well.  

<h5>Exiting the script</h3>

It's also logical to make the script exit when invalid parameters are passed to it.  This has already been suggested in the <a href="https://stackoverflow.com/questions/18568706/check-number-of-arguments-passed-to-a-bash-script#comment50847987_18568706">comments</a> by <a href="https://stackoverflow.com/users/1102730/ekangas">ekangas</a> but someone edited this answer to have it with `-1` as the returned value, so I might as well do it right.  

`-1` though accepted by Bash as an argument to `exit` is not explicitly documented and is not right to be used as a common suggestion.  `64` is also the most formal value since it's defined in `sysexits.h` with `#define EX_USAGE 64 /* command line usage error */`.  Most tools like `ls` also return `2` on invalid arguments.  I also used to return `2` in my scripts but lately I no longer really cared, and simply used `1` in all errors.  But let's just place `2` here since it's most common and probably not OS-specific.  

```sh
if [[ $# -ne 1 ]]; then
    echo "Illegal number of parameters"
    exit 2
fi
```

<h5>References</h3>

<ul>
<li><a href="https://www.gnu.org/software/bash/manual/bash.html#Bash-Conditional-Expressions" rel="noreferrer">Bash Conditional Expressions</a></li>
<li><a href="https://www.gnu.org/software/bash/manual/bash.html#Conditional-Constructs" rel="noreferrer">Conditional Constructs</a></li>
<li><a href="https://www.gnu.org/software/bash/manual/bash.html#Pattern-Matching" rel="noreferrer">Pattern Matching</a></li>
<li><a href="https://www.gnu.org/software/bash/manual/bash.html#Word-Splitting" rel="noreferrer">Word Splitting</a></li>
<li><a href="https://www.gnu.org/software/bash/manual/bash.html#Filename-Expansion" rel="noreferrer">Filename Expansion (prev. Pathname Expansion)</a></li>
<li><a href="https://www.gnu.org/software/bash/manual/html_node/Simple-Commands.html" rel="noreferrer">Simple Commands</a></li>
</ul>

#### Answer 2 (score 66)
It might be a good idea to use <a href="http://wiki.bash-hackers.org/syntax/arith_expr" rel="noreferrer">arithmetic expressions</a> if you're dealing with numbers.  

```sh
if (( $# != 1 )); then
    echo "Illegal number of parameters"
fi
```

#### Answer 3 (score 38)
On []: !=, =, == ... are <em>string</em> comparison operators and -eq, -gt ... are <em>arithmetic</em> binary ones.  

I would use:  

```sh
if [ "$#" != "1" ]; then
```

Or:  

```sh
if [ $# -eq 1 ]; then
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: How can I redirect and append both stdout and stderr to a file with Bash? (score [692374](https://stackoverflow.com/q/876239) in 2015)

#### Question
To redirect <em>stdout</em> to a truncated file in Bash, I know to use:  

```sh
cmd > file.txt
```

To redirect <em>stdout</em> in Bash, appending to a file, I know to use:  

```sh
cmd >> file.txt
```

To redirect both <em>stdout</em> and <em>stderr</em> to a truncated file, I know to use:  

```sh
cmd &> file.txt
```

How do I redirect both <em>stdout</em> and <em>stderr</em> appending to a file? `cmd &amp;&gt;&gt; file.txt` did not work for me.  

#### Answer accepted (score 1853)
```sh
cmd >>file.txt 2>&1
```

Bash executes the redirects from left to right as follows:  

<ol>
<li>`&gt;&gt;file.txt`: Open `file.txt` in append mode and redirect `stdout` there.</li>
<li>`2&gt;&amp;1`: Redirect `stderr` to <em>"where `stdout` is currently going"</em>. In this case, that is a file opened in append mode. In other words, the `&amp;1` reuses the file descriptor which `stdout` currently uses.</li>
</ol>

#### Answer 2 (score 344)
There are two ways to do this, depending on your Bash version.  

The classic and portable (<strong>Bash pre-4</strong>) way is:  

```sh
cmd >> outfile 2>&1
```

A nonportable way, starting with <strong>Bash 4</strong> is  

```sh
cmd &>> outfile
```

(analog to `&amp;&gt; outfile`)  

For good coding style, you should  

<ul>
<li>decide if portability is a concern (then use classic way)</li>
<li>decide if portability even to Bash pre-4 is a concern (then use classic way)</li>
<li>no matter which syntax you use, not change it within the same script (confusion!)</li>
</ul>

If your script already starts with `#!/bin/sh` (no matter if intended or not), then the Bash 4 solution, and in general any Bash-specific code, is not the way to go.  

Also remember that Bash 4 `&amp;&gt;&gt;` is just shorter syntax — it does not introduce any new functionality or anything like that.  

The syntax is (beside other redirection syntax) described here: <a href="http://bash-hackers.org/wiki/doku.php/syntax/redirection#appending_redirected_output_and_error_output" rel="noreferrer">http://bash-hackers.org/wiki/doku.php/syntax/redirection#appending_redirected_output_and_error_output</a>  

#### Answer 3 (score 84)
In Bash you can also explicitly specify your redirects to different files:  

```sh
cmd >log.out 2>log_error.out
```

Appending would be:  

```sh
cmd >>log.out 2>>log_error.out
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: How to reload .bash_profile from the command line? (score [682357](https://stackoverflow.com/q/4608187) in 2014)

#### Question
<p>How can I reload `.bash_profile` from the command line? 
I can get the shell to recognize changes to `.bash_profile` by exiting and logging back in but I would like to be able to do it on demand.</p>

#### Answer accepted (score 1712)
Simply type `source ~/.bash_profile`  

Alternatively, if you like saving keystrokes you can type `. ~/.bash_profile`  

#### Answer 2 (score 98)
```sh
. ~/.bash_profile
```

Just make sure you don't have any dependencies on the current state in there.  

#### Answer 3 (score 30)
Simply type:  

```sh
. ~/.bash_profile
```

However, if you want to source it to run automatically when terminal starts instead of running it every time you open terminal, you might add `. ~/.bash_profile` to `~/.bashrc` file.  

<strong>Note:</strong>  

When you open a terminal, the terminal starts bash in (non-login) interactive mode, which means it will source `~/.bashrc`.  

`~/.bash_profile` is only sourced by bash when started in <strong>interactive login mode</strong>. That is typically only when you login at the console (<kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>F1</kbd>..<kbd>F6</kbd>), or connecting via `ssh`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: How to loop over files in directory and change path and add suffix to filename (score [670034](https://stackoverflow.com/q/20796200) in 2019)

#### Question
I need to write a script that starts my program with different arguments, but I'm new to Bash. I start my program with:  

`./MyProgram.exe Data/data1.txt [Logs/data1_Log.txt]`.  

Here is the pseudocode for what I want to do:  

```sh
for each filename in /Data do
  for int i = 0, i = 3, i++
    ./MyProgram.exe Data/filename.txt Logs/filename_Log{i}.txt
  end for
end for
```

So I'm really puzzled how to create second argument from the first one, so it looks like dataABCD_Log1.txt and start my program.   

#### Answer accepted (score 660)
A couple of notes first: when you use `Data/data1.txt` as an argument, should it really be `/Data/data1.txt` (with a leading slash)? Also, should the outer loop scan only for .txt files, or all files in /Data? Here's an answer, assuming `/Data/data1.txt` and .txt files only:  

```sh
#!/bin/bash
for filename in /Data/*.txt; do
    for ((i=0; i<=3; i++)); do
        ./MyProgram.exe "$filename" "Logs/$(basename "$filename" .txt)_Log$i.txt"
    done
done
```

Notes:  

<ul>
<li>`/Data/*.txt` expands to the paths of the text files in /Data (<em>including</em> the /Data/ part)</li>
<li>`$( ... )` runs a shell command and inserts its output at that point in the command line</li>
<li>`basename somepath .txt` outputs the base part of somepath, with .txt removed from the end (e.g. `/Data/file.txt` -> `file`)</li>
</ul>

If you needed to run MyProgram with `Data/file.txt` instead of `/Data/file.txt`, use `"${filename#/}"` to remove the leading slash. On the other hand, if it's really `Data` not `/Data` you want to scan, just use `for filename in Data/*.txt`.  

#### Answer 2 (score 295)
Sorry for necromancing the thread, but whenever you iterate over files by globbing, it's good practice to avoid the corner case where the glob does not match (which makes the loop variable expand to the (un-matching) glob pattern string itself).  

For example:   

```sh
for filename in Data/*.txt; do
    [ -e "$filename" ] || continue
    # ... rest of the loop body
done
```

Reference: <a href="http://mywiki.wooledge.org/BashPitfalls#line-57" rel="noreferrer">Bash Pitfalls</a>  

#### Answer 3 (score 71)
```sh
for file in Data/*.txt
do
    for ((i = 0; i < 3; i++))
    do
        name=${file##*/}
        base=${name%.txt}
        ./MyProgram.exe "$file" Logs/"${base}_Log$i.txt"
    done
done
```

The `name=${file##*/}` substitution (<a href="http://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion">shell parameter expansion</a>) removes the leading pathname up to the last `/`.  

The `base=${name%.txt}` substitution removes the trailing `.txt`.  It's a bit trickier if the extensions can vary.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: Redirect stderr and stdout in Bash (score [652646](https://stackoverflow.com/q/637827) in 2017)

#### Question
I want to redirect both stdout and stderr of a process to a single file. How do I do that in Bash?  

#### Answer accepted (score 717)
Take a look <a href="http://tldp.org/LDP/abs/html/io-redirection.html" rel="noreferrer">here</a>. Should be:  

```sh
yourcommand &>filename
```

(redirects both `stdout` and `stderr` to filename).  

#### Answer 2 (score 437)
```sh
do_something 2>&1 | tee -a some_file
```

This is going to redirect stderr to stdout and stdout to `some_file` <strong>and</strong> print it to stdout.  

#### Answer 3 (score 234)
You can redirect <em>stderr</em> to <em>stdout</em> and the <em>stdout</em> into a file:  

```sh
some_command >file.log 2>&1 
```

See <a href="http://tldp.org/LDP/abs/html/io-redirection.html" rel="noreferrer">http://tldp.org/LDP/abs/html/io-redirection.html</a>  

This format is preferred than the most popular &amp;> format that only work in bash.  In Bourne shell it could be interpreted as running the command in background. Also the format is more readable 2 (is STDERR) redirected to 1 (STDOUT).    

EDIT: changed the order as pointed out in the comments  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: How to echo shell commands as they are executed (score [644659](https://stackoverflow.com/q/2853803) in 2019)

#### Question
In a shell script, how do I echo all shell commands called and expand any variable names?  

For example, given the following line:  

```sh
ls $DIRNAME
```

I would like the script to run the command and display the following  

```sh
ls /full/path/to/some/dir
```

The purpose is to save a log of all shell commands called and their arguments. Is there perhaps a better way of generating such a log?  

#### Answer accepted (score 894)
`set -x` or `set -o xtrace` expands variables and prints a little + sign before the line.  

`set -v` or `set -o verbose` does not expand the variables before printing.  

Use `set +x` and `set +v` to turn off the above settings.  

On the first line of the script, one can put `#!/bin/sh -x` (or `-v`) to have the same effect as `set -x` (or `-v`) later in the script.  

The above also works with `/bin/sh`.  

See the bash-hackers' wiki on <a href="https://wiki.bash-hackers.org/commands/builtin/set#attributes" rel="noreferrer">`set` attributes</a>, and on <a href="https://wiki.bash-hackers.org/scripting/debuggingtips" rel="noreferrer">debugging</a>.  

```sh
$ cat shl
#!/bin/bash                                                                     

DIR=/tmp/so
ls $DIR

$ bash -x shl 
+ DIR=/tmp/so
+ ls /tmp/so
$
```

#### Answer 2 (score 288)
`set -x` will give you what you want.  

Here is an example shell script to demonstrate:  

```sh
#!/bin/bash
set -x #echo on

ls $PWD
```

This expands all variables and prints the full commands before output of the command.  

output:  

```sh
+ ls /home/user/
file1.txt file2.txt
```

#### Answer 3 (score 83)
You can also toggle this for select lines in your script by wrapping them in `set -x` and `set +x`  e.g.  

```sh
#!/bin/bash
...
if [[ ! -e $OUT_FILE ]];
then
   echo "grabbing $URL"
   set -x
   curl --fail --noproxy $SERV -s -S $URL -o $OUT_FILE
   set +x
fi
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: Get current directory name (without full path) in a Bash script (score [626208](https://stackoverflow.com/q/1371261) in 2018)

#### Question
How would I get just the current working directory name in a bash script, or even better, just a terminal command.  

`pwd` gives the full path of the current working directory, e.g. `/opt/local/bin` but I only want `bin`  

#### Answer accepted (score 1017)
No need for basename, and especially no need for a subshell running pwd (which <A HREF="http://mywiki.wooledge.org/SubShell" rel="noreferrer">adds an extra, and expensive, fork operation</A>); the shell can do this internally using <A HREF="http://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html" rel="noreferrer">parameter expansion</A>:  

```sh
result=${PWD##*/}          # to assign to a variable

printf '%s\n' "${PWD##*/}" # to print to stdout
                           # ...more robust than echo for unusual names
                           #    (consider a directory named -e or -n)

printf '%q\n' "${PWD##*/}" # to print to stdout, quoted for use as shell input
                           # ...useful to make hidden characters readable.
```

<hr>

Note that if you're applying this technique in other circumstances (not `PWD`, but some other variable holding a directory name), you might need to trim any trailing slashes. The below uses bash's <a href="http://wiki.bash-hackers.org/syntax/pattern#extended_pattern_language" rel="noreferrer">extglob support</a> to work even with multiple trailing slashes:  

```sh
dirname=/path/to/somewhere//
shopt -s extglob           # enable +(...) glob syntax
result=${dirname%%+(/)}    # trim however many trailing slashes exist
result=${result##*/}       # remove everything before the last / that still remains
printf '%s\n' "$result"
```

Alternatively, without `extglob`:  

```sh
dirname="/path/to/somewhere//"
result="${dirname%"${dirname##*[!/]}"}" # extglob-free multi-trailing-/ trim
result="${result##*/}"                  # remove everything before the last /
```

#### Answer 2 (score 280)
Use the <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/basename.html" rel="noreferrer">`basename`</a> program.  For your case:  

```sh
% basename "$PWD"
bin
```

#### Answer 3 (score 132)
```sh
$ echo "${PWD##*/}"
```

&#8203;&#8203;&#8203;&#8203;&#8203;  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: if, elif, else statement issues in Bash (score [625671](https://stackoverflow.com/q/16034749) in 2018)

#### Question
I can't seem to work out what the issue with the following `if` statement is in regards to the `elif` and `then`. Keep in mind the `printf` is still under development I just haven't been able to test it yet in the statement so is more than likely wrong.  

The error I'm getting is:  

```sh
./timezone_string.sh: line 14: syntax error near unexpected token `then'
./timezone_string.sh: line 14: `then'
```

And the statement is like so.  

```sh
if [ "$seconds" -eq 0 ];then
   $timezone_string="Z"
elif[ "$seconds" -gt 0 ]
then
   $timezone_string=`printf "%02d:%02d" $seconds/3600 ($seconds/60)%60`
else
   echo "Unknown parameter"
fi
```

#### Answer accepted (score 407)
There is a space missing between `elif` and `[`:  

```sh
elif[ "$seconds" -gt 0 ]
```

should be  

```sh
elif [ "$seconds" -gt 0 ]
```

<hr>

As I see this question is getting a lot of views, it is important to indicate that the syntax to follow is:  

```sh
if [ conditions ]
# ^ ^          ^
```

meaning that <strong>spaces are needed around the brackets</strong>. Otherwise, it won't work. This is because `[` itself <em>is</em> a command.  

The reason why you are not seeing something like `elif[: command not found` (or similar) is that after seeing `if` and `then`, the shell is looking for either `elif`, `else`, or `fi`.  However it finds another `then` (after the mis-formatted `elif[`).  Only <em>after</em> having parsed the statement it would be executed (and an error message like `elif[: command not found` would be output).  

#### Answer 2 (score 266)
You have some syntax issues with your script. Here is a fixed version:  

```sh
#!/bin/bash

if [ "$seconds" -eq 0 ]; then
   timezone_string="Z"
elif [ "$seconds" -gt 0 ]; then
   timezone_string=$(printf "%02d:%02d" $((seconds/3600)) $(((seconds / 60) % 60)))
else
   echo "Unknown parameter"
fi
```



#### Answer 3 (score 23)
`[` is a command (or a builtin in some shells). It must be separated by whitespace from the preceding statement:  

```sh
elif [
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Find and Replace Inside a Text File from a Bash Command (score [614510](https://stackoverflow.com/q/525592) in 2017)

#### Question
What's the simplest way to do a find and replace for a given input string, say `abc`, and replace with another string, say `XYZ` in file `/tmp/file.txt`?  

I am writting an app and using IronPython to execute commands through SSH &mdash; but I don't know Unix that well and don't know what to look for.  

I have heard that Bash, apart from being a command line interface, can be a very powerful scripting language. So, if this is true, I assume you can perform actions like these.  

Can I do it with bash, and what's the simplest (one line) script to achieve my goal?  

#### Answer accepted (score 864)
The easiest way is to use sed (or perl):  

```sh
sed -i -e 's/abc/XYZ/g' /tmp/file.txt
```

Which will invoke sed to do an in-place edit due to the `-i` option.  This can be called from bash.  

If you really really want to use just bash, then the following can work:  

```sh
while read a; do
    echo ${a//abc/XYZ}
done < /tmp/file.txt > /tmp/file.txt.t
mv /tmp/file.txt{.t,}
```

This loops over each line, doing a substitution, and writing to a temporary file (don't want to clobber the input).  The move at the end just moves temporary to the original name.  

#### Answer 2 (score 157)
File manipulation isn't normally done by Bash, but by programs invoked by Bash, e.g.:  

```sh
perl -pi -e 's/abc/XYZ/g' /tmp/file.txt
```

The `-i` flag tells it to do an in-place replacement.  

See `man perlrun` for more details, including how to take a backup of the original file.  

#### Answer 3 (score 66)
I was surprised because i stumbled over this...  

There is a <strong>"replace"</strong> command which ships with the package <strong>"mysql-server"</strong>, so if you have installed it try it out:  

```sh
# replace string abc to XYZ in files
replace "abc" "XYZ" -- file.txt file2.txt file3.txt

# or pipe an echo to replace
echo "abcdef" |replace "abc" "XYZ"
```

See <strong>man replace</strong> for more on this...  

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: How to check if a program exists from a Bash script? (score [603726](https://stackoverflow.com/q/592620) in 2018)

#### Question
How would I validate that a program exists, in a way that will either return an error and exit, or continue with the script?  

It seems like it should be easy, but it's been stumping me.  

#### Answer accepted (score 2766)
<h5>Answer</h2>

POSIX compatible:  

```sh
command -v <the_command>
```

For `bash` specific environments:  

```sh
hash <the_command> # For regular commands. Or...
type <the_command> # To check built-ins and keywords
```

<h5>Explanation</h2>

Avoid `which`.  Not only is it an external process you're launching for doing very little (meaning builtins like `hash`, `type` or `command` are way cheaper), you can also rely on the builtins to actually do what you want, while the effects of external commands can easily vary from system to system.  

Why care?  

<ul>
<li>Many operating systems have a `which` that <strong>doesn't even set an exit status</strong>, meaning the `if which foo` won't even work there and will <strong>always</strong> report that `foo` exists, even if it doesn't (note that some POSIX shells appear to do this for `hash` too).</li>
<li>Many operating systems make `which` do custom and evil stuff like change the output or even hook into the package manager.</li>
</ul>

So, don't use `which`.  Instead use one of these:  

```sh
$ command -v foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
$ type foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
$ hash foo 2>/dev/null || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
```

(Minor side-note: some will suggest `2&gt;&amp;-` is the same `2&gt;/dev/null` but shorter – <em>this is untrue</em>.  `2&gt;&amp;-` closes FD 2 which causes an <strong>error</strong> in the program when it tries to write to stderr, which is very different from successfully writing to it and discarding the output (and dangerous!))  

If your hash bang is `/bin/sh` then you should care about what POSIX says.  `type` and `hash`'s exit codes aren't terribly well defined by POSIX, and `hash` is seen to exit successfully when the command doesn't exist (haven't seen this with `type` yet).  `command`'s exit status is well defined by POSIX, so that one is probably the safest to use.  

If your script uses `bash` though, POSIX rules don't really matter anymore and both `type` and `hash` become perfectly safe to use.  `type` now has a `-P` to search just the `PATH` and `hash` has the side-effect that the command's location will be hashed (for faster lookup next time you use it), which is usually a good thing since you probably check for its existence in order to actually use it.  

As a simple example, here's a function that runs `gdate` if it exists, otherwise `date`:  

```sh
gnudate() {
    if hash gdate 2>/dev/null; then
        gdate "$@"
    else
        date "$@"
    fi
}
```

#### Answer 2 (score 459)
The following is a portable way to check whether a command exists in `$PATH` <em>and</em> is executable:  

```sh
[ -x "$(command -v foo)" ]
```

Example:  

```sh
if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi
```

The executable check is needed because bash returns a non-executable file if no executable file with that name is found in `$PATH`.  

Also note that if a non-executable file with the same name as the executable exists earlier in `$PATH`, dash returns the former, even though the latter would be executed. This is a bug and is in violation of the POSIX standard. [<a href="https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=874264" rel="noreferrer">Bug report</a>] [<a href="http://pubs.opengroup.org/onlinepubs/009696899/utilities/command.html" rel="noreferrer">Standard</a>]  

In addition, this will fail if the command you are looking for has been defined as an alias.  

#### Answer 3 (score 199)
I agree with lhunath to discourage use of `which`, and his solution is perfectly valid <em>for BASH users</em>. However, to be more portable, `command -v` shall be used instead:  

```sh
$ command -v foo >/dev/null 2>&1 || { echo "I require foo but it's not installed.  Aborting." >&2; exit 1; }
```

Command `command` is POSIX compliant, see here for its specification: <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html" rel="noreferrer">http://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html</a>  

Note: `type` is POSIX compliant, but `type -P` is not.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Syntax for a single-line Bash infinite while loop (score [601934](https://stackoverflow.com/q/1289026) in 2017)

#### Question
I am having trouble coming up with the right combination of semicolons and/or braces. I'd like to do this, but as a one-liner from the command line:  

```sh
while [ 1 ]
do
    foo
    sleep 2
done
```

#### Answer accepted (score 1121)
```sh
while true; do foo; sleep 2; done
```

By the way, if you type it as a multiline (as you are showing) at the command prompt and then call the history with arrow up, you will get it on a single line, correctly punctuated.  

```sh
$ while true
> do
>    echo "hello"
>    sleep 2
> done
hello
hello
hello
^C
$ <arrow up> while true; do    echo "hello";    sleep 2; done
```

#### Answer 2 (score 159)
It's also possible to use sleep command in while's condition. Making one-liner looking more clean imho.  

```sh
while sleep 2; do echo thinking; done
```

#### Answer 3 (score 67)
Colon is always "true":  

```sh
while :; do foo; sleep 2; done
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: Ubuntu says "bash: ./program Permission denied" (score [599338](https://stackoverflow.com/q/18960689) in 2017)

#### Question
I am running Ubuntu on computer 1 and computer 2. I compiled a C++ program on computer 1, and I can execute it from the terminal using `./program_name`. It runs fine.  

However, when I try to do this on computer 2, it says: `bash: ./program_name: permission denied`  

What's wrong and what can I do about it?  

#### Answer accepted (score 349)
`chmod u+x program_name`. Then execute it.  

If that does not work, copy the program from the USB device to a native volume on the system. Then `chmod u+x program_name` on the local copy and execute that.  

Unix and Unix-like systems generally will not execute a program unless it is marked with permission to execute. The way you copied the file from one system to another (or mounted an external volume) may have turned off execute permission (as a safety feature). The command `chmod u+x name` adds permission for the user that owns the file to execute it.  

That command only changes the permissions associated with the file; it does not change the security controls associated with the entire volume. If it is security controls on the volume that are interfering with execution (for example, a `noexec` option may be specified for a volume in the Unix `fstab` file, which says not to allow execute permission for files on the volume), then you can remount the volume with options to allow execution. However, copying the file to a local volume may be a quicker and easier solution.  

#### Answer 2 (score 28)
Try this:  

```sh
sudo chmod +x program_name
./program_name 
```

#### Answer 3 (score 10)
Sounds like you don't have the execute flag set on the file permissions, try:   

```sh
chmod u+x program_name
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: How do I test if a variable is a number in Bash? (score [596633](https://stackoverflow.com/q/806906) in 2017)

#### Question
I just can't figure out how do I make sure an argument passed to my script is a number or not.  

All I want to do is something like this:  

```sh
test *isnumber* $1 && VAR=$1 || echo "need a number"
```

Any help?  

#### Answer accepted (score 720)
One approach is to use a regular expression, like so:  

```sh
re='^[0-9]+$'
if ! [[ $yournumber =~ $re ]] ; then
   echo "error: Not a number" >&2; exit 1
fi
```

If the value is not necessarily an integer, consider amending the regex appropriately; for instance:  

```sh
^[0-9]+([.][0-9]+)?$
```

...or, to handle numbers with a sign:  

```sh
^[+-]?[0-9]+([.][0-9]+)?$
```

#### Answer 2 (score 257)
Without bashisms (works even in the System V sh),  

```sh
case $string in
    ''|*[!0-9]*) echo bad ;;
    *) echo good ;;
esac
```

This rejects empty strings and strings containing non-digits, accepting everything else.  

Negative or floating-point numbers need some additional work. An idea is to exclude `-` / `.` in the first "bad" pattern and add more "bad" patterns containing the inappropriate uses of them (`?*-*` / `*.*.*`)  

#### Answer 3 (score 170)
The following solution can also be used in basic shells such as Bourne without the need for regular expressions.  Basically any numeric value evaluation operations using non-numbers will result in an error which will be implicitly considered as false in shell:  

```sh
"$var" -eq "$var"
```

as in:  

```sh
#!/bin/bash

var=a

if [ -n "$var" ] && [ "$var" -eq "$var" ] 2>/dev/null; then
  echo number
else
  echo not a number
fi
```

You can can also test for $? the return code of the operation which is more explicit:  

```sh
[ -n "$var" ] && [ "$var" -eq "$var" ] 2>/dev/null
if [ $? -ne 0 ]; then
   echo $var is not number
fi
```

Redirection of standard error is there to hide the "integer expression expected" message that bash prints out in case we do not have a number.  

<strong>CAVEATS</strong> (thanks to the comments below):  

<ul>
<li>Numbers with decimal points are <em>not</em> identified as valid "numbers"</li>
<li>Using `[[ ]]` instead of `[ ]` will always evaluate to `true`</li>
<li>Most non-Bash shells will always evaluate this expression as `true`</li>
<li>The behavior in Bash is undocumented and may therefore change without warning</li>
<li>If the value includes spaces after the number (e.g. "1 a") produces error, like `bash: [[: 1 a: syntax error in expression (error token is "a")`</li>
<li>If the value is the same as var-name (e.g. i="i"), produces error, like `bash: [[: i: expression recursion level exceeded (error token is "i")`</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: Open and write data to text file using Bash? (score [586748](https://stackoverflow.com/q/11162406) in 2019)

#### Question
How can I write data to a text file automatically by shell scripting in Linux?  

I was able to open the file. However, I don't know how to write data to it.  

#### Answer accepted (score 338)
```sh
echo "some data for the file" >> fileName
```

#### Answer 2 (score 126)
```sh
#!/bin/sh

FILE="/path/to/file"

/bin/cat <<EOM >$FILE
text1
text2 # This comment will be inside of the file.
The keyword EOM can be any text, but it must start the line and be alone.
 EOM # This will be also inside of the file, see the space in front of EOM.
EOM # No comments and spaces around here, or it will not work.
text4 
EOM
```

#### Answer 3 (score 52)
You can redirect the output of a command to a file:  

```sh
$ cat file > copy_file
```

or append to it  

```sh
$ cat file >> copy_file
```

If you want to write directly the command is `echo 'text'`  

```sh
$ echo 'Hello World' > file
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: How to run the sftp command with a password from Bash script? (score [581214](https://stackoverflow.com/q/5386482) in 2017)

#### Question
I need to transfer a log file to a remote host using <a href="http://en.wikipedia.org/wiki/Secure_file_transfer_program" rel="noreferrer">sftp</a> from a Linux host. I have been provided credentials for the same from my operations group. However, since I don't have control over other host, I cannot generate and share RSA keys with the other host.   

So is there a way to run the `sftp` command (with the username/password provided) from inside the Bash script through a <a href="http://en.wikipedia.org/wiki/Cron" rel="noreferrer">cron</a> job?  

I found a similar Stack Overflow question, <em><a href="https://stackoverflow.com/questions/5268865">Specify password to sftp in a Bash script</a></em>, but there was no satisfactory answer to my problem.  

#### Answer accepted (score 167)
You have a few options other than using public key authentication:  

<ol>
<li>Use <a href="http://www.cyberciti.biz/faq/ssh-passwordless-login-with-keychain-for-scripts/" rel="noreferrer">keychain</a> </li>
<li>Use <a href="http://www.cyberciti.biz/faq/noninteractive-shell-script-ssh-password-provider/" rel="noreferrer">sshpass</a> (less secured but probably that meets your requirement)</li>
<li>Use <a href="http://www.linux-bsd-central.com/index.php/content/view/26/29/" rel="noreferrer">expect</a> (least secured and more coding needed)</li>
</ol>

If you decide to give sshpass a chance here is a working script snippet to do so:  

```sh
export SSHPASS=your-password-here
sshpass -e sftp -oBatchMode=no -b - sftp-user@remote-host << !
   cd incoming
   put your-log-file.log
   bye
!
```

#### Answer 2 (score 89)
Another way would be to use lftp:  

```sh
lftp sftp://user:password@host  -e "put local-file.name; bye"
```

The disadvantage of this method is that other users on the computer can read the password from tools like `ps` and that the password can become part of your shell history.   

A more secure alternative which is available since LFTP 4.5.0 is setting the `LFTP_PASSWORD`environment variable and executing lftp with `--env-password`. Here's a full example:  

```sh
LFTP_PASSWORD="just_an_example"
lftp --env-password sftp://user@host  -e "put local-file.name; bye"
```

LFTP also includes a cool mirroring feature (can include delete after confirmed transfer '--Remove-source-files'):  

```sh
lftp -e 'mirror -R /local/log/path/ /remote/path/' --env-password -u user sftp.foo.com
```

#### Answer 3 (score 47)
Expect is a great program to use.  

On Ubuntu install it with:  

```sh
sudo apt-get install expect
```

On a CentOS Machine install it with:  

```sh
yum install expect
```

Lets say you want to make a connection to  a sftp server and then upload a local file from your local machine to the remote sftp server  

```sh
#!/usr/bin/expect

spawn sftp username@hostname.com
expect "password:"
send "yourpasswordhere\n"
expect "sftp>"
send "cd logdirectory\n"
expect "sftp>"
send "put /var/log/file.log\n"
expect "sftp>"
send "exit\n"
interact
```

This opens a sftp connection with your password to the server.  

Then it goes to the directory where you want to upload your file, in this case "logdirectory"  

This uploads a log file from the  local directory found at /var/log/ with the files name being file.log to the "logdirectory" on the remote server  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: In a Bash script, how can I exit the entire script if a certain condition occurs? (score [580639](https://stackoverflow.com/q/1378274) in 2017)

#### Question
I'm writing a script in Bash to test some code. However, it seems silly to run the tests if compiling the code fails in the first place, in which case I'll just abort the tests.  

Is there a way I can do this without wrapping the entire script inside of a while loop and using breaks? Something like a <strong>dun dun dun</strong> goto?  

#### Answer accepted (score 702)
Try this statement:  

```sh
exit 1
```

Replace `1` with appropriate error codes. See also <a href="http://www.tldp.org/LDP/abs/html/exitcodes.html" rel="noreferrer">Exit Codes With Special Meanings</a>.  

#### Answer 2 (score 651)
Use <strong>set -e</strong>  

```sh
#!/bin/bash

set -e

/bin/command-that-fails
/bin/command-that-fails2
```

The script will terminate after the first line that fails (returns nonzero exit code).  In this case, <em>command-that-fails2</em> will not run.  

If you were to check the return status of every single command, your script would look like this:  

```sh
#!/bin/bash

# I'm assuming you're using make

cd /project-dir
make
if [[ $? -ne 0 ]] ; then
    exit 1
fi

cd /project-dir2
make
if [[ $? -ne 0 ]] ; then
    exit 1
fi
```

With <strong>set -e</strong> it would look like:  

```sh
#!/bin/bash

set -e

cd /project-dir
make

cd /project-dir2
make
```

Any command that fails will cause the entire script to fail and return an exit status you can check with <strong>$?</strong>.  If your script is very long or you're building a lot of stuff it's going to get pretty ugly if you add return status checks everywhere.  

#### Answer 3 (score 206)
A bad-arse SysOps guy once taught me the Three-Fingered Claw technique:  

```sh
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }
```

These functions are *NIX OS and shell flavor-robust. Put them at the beginning of your script (bash or otherwise), `try()` your statement and code on.  

<h5>Explanation</h3>

(based on  <a href="https://stackoverflow.com/users/247482/flying-sheep">flying sheep</a> comment).  

<ul>
<li>`yell`: print the script name and all arguments to `stderr`:

<ul>
<li>`$0` is the path to the script ;</li>
<li>`$*` are all arguments. </li>
<li>`&gt;&amp;2` means <em>`&gt;` redirect stdout to &amp; pipe `2`</em>. <em>pipe `1`</em> would be `stdout` itself. </li>
</ul></li>
<li>`die` does the same as `yell`, but exits with a <em>non-0 exit status</em>, which means “fail”. </li>
<li>`try` uses the `||` (boolean `OR`), which only evaluates the right side if the left one failed. 

<ul>
<li>`$@` is all arguments again, but <a href="https://stackoverflow.com/q/9915610/802365">different</a>. </li>
</ul></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: How to iterate over arguments in a Bash script (score [574001](https://stackoverflow.com/q/255898) in 2017)

#### Question
I have a complex command that I'd like to make a shell/bash script of.  I can write it in terms of `$1` easily:  

```sh
foo $1 args -o $1.ext
```

I want to be able to pass multiple input names to the script. What's the right way to do it?    

And, of course, I want to handle filenames with spaces in them.  

#### Answer accepted (score 1351)
Use `"$@"` to represent all the arguments:  

```sh
for var in "$@"
do
    echo "$var"
done
```

This will iterate over each argument and print it out on a separate line.  $@ behaves like $* except that when quoted the arguments are broken up properly if there are spaces in them:  

```sh
sh test.sh 1 2 '3 4'
1
2
3 4
```

#### Answer 2 (score 227)
<sup><em>Rewrite of a now-deleted <a href="https://stackoverflow.com/a/255939/">answer</a> by <a href="https://stackoverflow.com/users/6309/vonc">VonC</a>.</em></sup>  

<p>Robert Gamble's succinct answer deals directly with the question.
This one amplifies on some issues with filenames containing spaces.</p>

See also: <a href="https://stackoverflow.com/questions/154625/1-in-binsh">${1:+"$@"} in /bin/sh</a>  

<p><strong>Basic thesis:</strong> `"$@"` is correct, and `$*` (unquoted) is almost always wrong.
This is because `"$@"` works fine when arguments contain spaces, and
works the same as `$*` when they don't.
In some circumstances, `"$*"` is OK too, but `"$@"` usually (but not
always) works in the same places.
Unquoted, `$@` and `$*` are equivalent (and almost always wrong).</p>

<p>So, what is the difference between `$*`, `$@`, `"$*"`, and `"$@"`?  They are all related to 'all the arguments to the shell', but they do different things. When unquoted, `$*` and `$@` do the same thing.  They treat each 'word' (sequence of non-whitespace) as a separate argument.  The quoted forms are quite different, though: `"$*"` treats the argument list as a single space-separated string, whereas `"$@"` treats the arguments almost exactly as they were when specified on the command line.
`"$@"` expands to nothing at all when there are no positional arguments; `"$*"` expands to an empty string &mdash; and yes, there's a difference, though it can be hard to perceive it.
See more information below, after the introduction of the (non-standard) command `al`.</p>

<p><strong>Secondary thesis:</strong> if you need to process arguments with spaces and then
pass them on to other commands, then you sometimes need non-standard
tools to assist. (Or you should use arrays, carefully: `"${array[@]}"` behaves analogously to `"$@"`.)</p>

<em>Example:</em>  

```sh
    $ mkdir "my dir" anotherdir
    $ ls
    anotherdir      my dir
    $ cp /dev/null "my dir/my file"
    $ cp /dev/null "anotherdir/myfile"
    $ ls -Fltr
    total 0
    drwxr-xr-x   3 jleffler  staff  102 Nov  1 14:55 my dir/
    drwxr-xr-x   3 jleffler  staff  102 Nov  1 14:55 anotherdir/
    $ ls -Fltr *
    my dir:
    total 0
    -rw-r--r--   1 jleffler  staff  0 Nov  1 14:55 my file

    anotherdir:
    total 0
    -rw-r--r--   1 jleffler  staff  0 Nov  1 14:55 myfile
    $ ls -Fltr "./my dir" "./anotherdir"
    ./my dir:
    total 0
    -rw-r--r--   1 jleffler  staff  0 Nov  1 14:55 my file

    ./anotherdir:
    total 0
    -rw-r--r--   1 jleffler  staff  0 Nov  1 14:55 myfile
    $ var='"./my dir" "./anotherdir"' && echo $var
    "./my dir" "./anotherdir"
    $ ls -Fltr $var
    ls: "./anotherdir": No such file or directory
    ls: "./my: No such file or directory
    ls: dir": No such file or directory
    $
```

<p>Why doesn't that work?
It doesn't work because the shell processes quotes before it expands
variables.
So, to get the shell to pay attention to the quotes embedded in `$var`,
you have to use `eval`:</p>

```sh
    $ eval ls -Fltr $var
    ./my dir:
    total 0
    -rw-r--r--   1 jleffler  staff  0 Nov  1 14:55 my file

    ./anotherdir:
    total 0
    -rw-r--r--   1 jleffler  staff  0 Nov  1 14:55 myfile
    $ 
```

<p>This gets really tricky when you have file names such as "<code>He said,
"Don't do this!"</code>" (with quotes and double quotes and spaces).</p>

```sh
    $ cp /dev/null "He said, \"Don't do this!\""
    $ ls
    He said, "Don't do this!"       anotherdir                      my dir
    $ ls -l
    total 0
    -rw-r--r--   1 jleffler  staff    0 Nov  1 15:54 He said, "Don't do this!"
    drwxr-xr-x   3 jleffler  staff  102 Nov  1 14:55 anotherdir
    drwxr-xr-x   3 jleffler  staff  102 Nov  1 14:55 my dir
    $ 
```

<p>The shells (all of them) do not make it particularly easy to handle such
stuff, so (funnily enough) many Unix programs do not do a good job of
handling them.
On Unix, a filename (single component) can contain any characters except
slash and NUL `'\0'`.
However, the shells strongly encourage no spaces or newlines or tabs
anywhere in a path names.
It is also why standard Unix file names do not contain spaces, etc.</p>

<p>When dealing with file names that may contain spaces and other
troublesome characters, you have to be extremely careful, and I found
long ago that I needed a program that is not standard on Unix.
I call it `escape` (version 1.1 was dated 1989-08-23T16:01:45Z).</p>

<p>Here is an example of `escape` in use - with the SCCS control system.
It is a cover script that does both a `delta` (think <em>check-in</em>) and a
`get` (think <em>check-out</em>).
Various arguments, especially `-y` (the reason why you made the change)
would contain blanks and newlines.
Note that the script dates from 1992, so it uses back-ticks instead of
`$(cmd ...)` notation and does not use `#!/bin/sh` on the first line.</p>

```sh
:   "@(#)$Id: delget.sh,v 1.8 1992/12/29 10:46:21 jl Exp $"
#
#   Delta and get files
#   Uses escape to allow for all weird combinations of quotes in arguments

case `basename $0 .sh` in
deledit)    eflag="-e";;
esac

sflag="-s"
for arg in "$@"
do
    case "$arg" in
    -r*)    gargs="$gargs `escape \"$arg\"`"
            dargs="$dargs `escape \"$arg\"`"
            ;;
    -e)     gargs="$gargs `escape \"$arg\"`"
            sflag=""
            eflag=""
            ;;
    -*)     dargs="$dargs `escape \"$arg\"`"
            ;;
    *)      gargs="$gargs `escape \"$arg\"`"
            dargs="$dargs `escape \"$arg\"`"
            ;;
    esac
done

eval delta "$dargs" && eval get $eflag $sflag "$gargs"
```

<p>(I would probably not use escape quite so thoroughly these days - it is
not needed with the `-e` argument, for example - but overall, this is
one of my simpler scripts using `escape`.)</p>

<p>The `escape` program simply outputs its arguments, rather like `echo`
does, but it ensures that the arguments are protected for use with
`eval` (one level of `eval`; I do have a program which did remote shell
execution, and that needed to escape the output of `escape`).</p>

```sh
    $ escape $var
    '"./my' 'dir"' '"./anotherdir"'
    $ escape "$var"
    '"./my dir" "./anotherdir"'
    $ escape x y z
    x y z
    $ 
```

<p>I have another program called `al` that lists its arguments one per line
(and it is even more ancient: version 1.1 dated 1987-01-27T14:35:49).
It is most useful when debugging scripts, as it can be plugged into a
command line to see what arguments are actually passed to the command.</p>

```sh
    $ echo "$var"
    "./my dir" "./anotherdir"
    $ al $var
    "./my
    dir"
    "./anotherdir"
    $ al "$var"
    "./my dir" "./anotherdir"
    $
```

<p>[<em>Added:</em>
And now to show the difference between the various `"$@"` notations, here is one more example:</p>

```sh
$ cat xx.sh
set -x
al $@
al $*
al "$*"
al "$@"
$ sh xx.sh     *      */*
+ al He said, '"Don'\''t' do 'this!"' anotherdir my dir xx.sh anotherdir/myfile my dir/my file
He
said,
"Don't
do
this!"
anotherdir
my
dir
xx.sh
anotherdir/myfile
my
dir/my
file
+ al He said, '"Don'\''t' do 'this!"' anotherdir my dir xx.sh anotherdir/myfile my dir/my file
He
said,
"Don't
do
this!"
anotherdir
my
dir
xx.sh
anotherdir/myfile
my
dir/my
file
+ al 'He said, "Don'\''t do this!" anotherdir my dir xx.sh anotherdir/myfile my dir/my file'
He said, "Don't do this!" anotherdir my dir xx.sh anotherdir/myfile my dir/my file
+ al 'He said, "Don'\''t do this!"' anotherdir 'my dir' xx.sh anotherdir/myfile 'my dir/my file'
He said, "Don't do this!"
anotherdir
my dir
xx.sh
anotherdir/myfile
my dir/my file
$
```

Notice that nothing preserves the original blanks between the `*` and `*/*` on the command line.  Also, note that you can change the 'command line arguments' in the shell by using:  

```sh
set -- -new -opt and "arg with space"
```

<p>This sets 4 options, '`-new`', '`-opt`', '`and`', and '`arg with space`'.
<br>
]</p>

<p>Hmm, that's quite a long <em>answer</em> - perhaps <em>exegesis</em> is the better term.
Source code for `escape` available on request (email to firstname dot
lastname at gmail dot com).
The source code for `al` is incredibly simple:</p>

```sh
#include <stdio.h>
int main(int argc, char **argv)
{
    while (*++argv != 0)
        puts(*argv);
    return(0);
}
```

That's all.  It is equivalent to the `test.sh` script that Robert Gamble showed, and could be written as a shell function (but shell functions didn't exist in the local version of Bourne shell when I first wrote `al`).  

Also note that you can write `al` as a simple shell script:  

```sh
[ $# != 0 ] && printf "%s\n" "$@"
```

The conditional is needed so that it produces no output when passed no arguments.  The `printf` command will produce a blank line with only the format string argument, but the C program produces nothing.  

#### Answer 3 (score 124)
Note that Robert's answer is correct, and it works in `sh` as well.  You can (portably) simplify it even further:  

```sh
for i in "$@"
```

is equivalent to:  

```sh
for i
```

I.e., you don't need anything!  

Testing (`$` is command prompt):  

```sh
$ set a b "spaces here" d
$ for i; do echo "$i"; done
a
b
spaces here
d
$ for i in "$@"; do echo "$i"; done
a
b
spaces here
d
```

I first read about this in <em>Unix Programming Environment</em> by Kernighan and Pike.  

In `bash`, `help for` documents this:  

<blockquote>
  `for NAME [in WORDS ... ;] do COMMANDS; done`  
  
  If `'in WORDS ...;'` is not present, then `'in "$@"'` is assumed.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: Why do you need to put #!/bin/bash at the beginning of a script file? (score [573690](https://stackoverflow.com/q/8967902) in 2018)

#### Question
I have made <a href="http://en.wikipedia.org/wiki/Bash_%28Unix_shell%29" rel="noreferrer">Bash</a> scripts before and they all ran fine without this at the beginning. What's the point of putting it in? Would things be any different?  

Also, how do you pronounce `#`? I know that `!` is pronounced as "bang."  

How is `#!` pronounced?  

#### Answer accepted (score 398)
It's a convention so the *nix shell knows what kind of interpreter to run.  

For example, older flavors of ATT defaulted to <em>sh</em> (the Bourne shell), while older versions of BSD defaulted to <em>csh</em> (the C shell).  

Even today (where most systems run bash, the <em>"Bourne Again Shell"</em>), scripts can be in bash, python, perl, ruby, PHP, etc, etc.  For example, you might see `#!/bin/perl` or `#!/bin/perl5`.  

<p>PS:
The exclamation mark (`!`) is affectionately called <em>"bang"</em>.  The shell comment symbol (`#`) is sometimes called <em>"hash"</em>.</p>

<p>PPS:
Remember - under *nix, associating a suffix with a file type is merely a <em>convention</em>, not a <em>"rule"</em>.  An <em>executable</em> can be a binary program, any one of a million script types and other things as well. Hence the need for `#!/bin/bash`.</p>

#### Answer 2 (score 124)
To be more precise the <a href="https://en.wikipedia.org/wiki/Shebang_%28Unix%29" rel="noreferrer">shebang</a> `#!`, when it is the first two bytes of an <em>executable</em> (`x` <a href="https://en.wikipedia.org/wiki/Modes_%28Unix%29" rel="noreferrer">mode</a>) file, is interpreted by the <a href="http://linux.die.net/man/2/execve" rel="noreferrer">execve(2)</a> system call (which execute programs). But <a href="http://pubs.opengroup.org/onlinepubs/009695299/functions/execve.html" rel="noreferrer">POSIX specification for `execve`</a> don't mention the shebang.  

It must be followed by a file path of an interpreter executable (which BTW could even be relative, but most often is absolute).  

A nice trick (or perhaps <a href="https://unix.stackexchange.com/a/29620/50557">not so nice</a> one) to find an interpreter (e.g. `python`) in the user's `$PATH` is to use the `env` program (always at `/usr/bin/env` on all Linux) like e.g.  

```sh
 #!/usr/bin/env python
```

Any ELF executable can be an interpreter. You could even use `#!/bin/cat` or `#!/bin/true` if you wanted to! (but that would be often useless)  

#### Answer 3 (score 47)
It's called a <a href="http://en.wikipedia.org/wiki/Shebang_%28Unix%29">shebang</a>. In unix-speak, # is called sharp (like in music) or hash (like hashtags on twitter), and ! is called bang. (You can actually reference your previous shell command with !!, called bang-bang). So when put together, you get haSH-BANG, or shebang.  

The part after the #! tells Unix what program to use to run it. If it isn't specified, it will try with bash (or sh, or zsh, or whatever your $SHELL variable is) but if it's there it will use that program. Plus, # is a comment in most languages, so the line gets ignored in the subsequent execution.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: How to obtain the number of CPUs/cores in Linux from the command line? (score [571310](https://stackoverflow.com/q/6481005) in 2015)

#### Question
I have this script, but I do not know how to get the last element in the printout:  

```sh
cat /proc/cpuinfo | awk '/^processor/{print $3}'
```

The last element should be the number of CPUs, minus 1.  

#### Answer accepted (score 595)
```sh
cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l
```

or simply  

```sh
grep -c ^processor /proc/cpuinfo     
```

which will count the number of lines starting with "processor" in `/proc/cpuinfo`  

For systems with hyper-threading, you can use  

```sh
grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}' 
```

which should return (for example) `8` (whereas the command above would return `16`)  

#### Answer 2 (score 596)
Processing the contents of `/proc/cpuinfo` is needlessly baroque. Use <a href="http://www.gnu.org/software/coreutils/manual/html_node/nproc-invocation.html" rel="noreferrer"><strong>nproc</strong></a> which is part of coreutils, so it should be available on most Linux installs.  

Command `nproc` prints the number of processing units available to the current process, which may be less than the number of online processors.  

To find the number of all installed cores/processors use `nproc --all`  

On my 8-core machine:  

```sh
$ nproc --all
8
```

#### Answer 3 (score 243)
The most portable solution I have found is the `getconf` command:  

```sh
getconf _NPROCESSORS_ONLN
```

This works on both Linux and Mac OS X. Another benefit of this over some of the other approaches is that getconf has been around for a long time. Some of the older Linux machines I have to do development on don't have the `nproc` or `lscpu` commands available, but they have `getconf`.  

<p><sup>Editor's note: While <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/getconf.html" rel="noreferrer">the `getconf` <em>utility</em> is POSIX-mandated</a>, the specific `_NPROCESSORS_ONLN` and `_NPROCESSORS_CONF` <em>values</em> are not. 
That said, as stated, they work on Linux platforms as well as on macOS; on FreeBSD/PC-BSD, you must omit the leading `_`.</sup></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: How to redirect output to a file and stdout (score [560328](https://stackoverflow.com/q/418896) in 2014)

#### Question
In bash, calling `foo` would display any output from that command on the stdout.  

Calling `foo &gt; output` would redirect any output from that command to the file specified (in this case 'output').  

Is there a way to redirect output to a file <em>and</em> have it display on stdout?  

#### Answer accepted (score 1200)
The command you want is named <strong><a href="http://www.gnu.org/software/coreutils/manual/html_node/tee-invocation.html" rel="noreferrer">`tee`</a></strong>:  

```sh
foo | tee output.file
```

For example, if you only care about stdout:  

```sh
ls -a | tee output.file
```

If you want to include stderr, do:  

```sh
program [arguments...] 2>&1 | tee outfile
```

`2&gt;&amp;1` redirects channel 2 (stderr/standard error) into channel 1 (stdout/standard output), such that both is written as stdout. It is also directed to the given output file as of the `tee` command.  

Furthermore, if you want to <em>append</em> to the log file, use `tee -a` as:  

```sh
program [arguments...] 2>&1 | tee -a outfile
```

#### Answer 2 (score 481)
```sh
$ program [arguments...] 2>&1 | tee outfile
```

<p>`2&gt;&amp;1` dumps the stderr and stdout streams.
`tee outfile` takes the stream it gets and writes it to the screen and to the file "outfile".</p>

This is probably what most people are looking for. The likely situation is some program or script is working hard for a long time and producing a lot of output. The user wants to check it periodically for progress, but also wants the output written to a file.  

The problem (especially when mixing stdout and stderr streams) is that there is reliance on the streams being flushed by the program. If, for example, all the writes to stdout are <em>not</em> flushed, but all the writes to stderr <em>are</em> flushed, then they'll end up out of chronological order in the output file and on the screen.  

It's also bad if the program only outputs 1 or 2 lines every few minutes to report progress. In such a case, if the output was not flushed by the program, the user wouldn't even see any output on the screen for hours, because none of it would get pushed through the pipe for hours.  

Update: The program `unbuffer`, part of the `expect` package, will solve the buffering problem. This will cause stdout and stderr to write to the screen and file immediately and keep them in sync when being combined and redirected to `tee`. E.g.:  

```sh
$ unbuffer program [arguments...] 2>&1 | tee outfile
```

#### Answer 3 (score 117)
Another way that works for me is,   

```sh
<command> |& tee  <outputFile>
```

as shown in <a href="http://www.gnu.org/software/bash/manual/bashref.html#Pipelines" rel="noreferrer">gnu bash manual</a>  

Example:  

```sh
ls |& tee files.txt
```

<blockquote>
  <em>If ‘|&amp;’ is used, command1’s <strong>standard error</strong>, in addition to its <strong>standard output</strong>, is connected to command2’s standard input through the pipe; it is <strong>shorthand for 2>&amp;1</strong> |. This implicit redirection of the standard error to the standard output is performed after any redirections specified by the command.</em>   
</blockquote>

For more information, refer <a href="http://www.gnu.org/software/bash/manual/bashref.html#Redirections" rel="noreferrer">redirection</a>   

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: In bash, how can I check if a string begins with some value? (score [554528](https://stackoverflow.com/q/2172352) in 2016)

#### Question
I would like to check if a string begins with "node" e.g. "node001". Something like  

```sh
if [ $HOST == user* ]  
  then  
  echo yes  
fi
```

How can I do it correctly？  

<hr>

I further need to combine expressions to check if HOST is either "user1" or begins with "node"  

```sh
if [ [[ $HOST == user1 ]] -o [[ $HOST == node* ]] ];  
then  
echo yes 
fi

> > > -bash: [: too many arguments
```

How to do it correctly?  

#### Answer accepted (score 941)
This snippet on the <a href="http://tldp.org/LDP/abs/html/comparison-ops.html" rel="noreferrer">Advanced Bash Scripting Guide</a> says:  

```sh
# The == comparison operator behaves differently within a double-brackets
# test than within single brackets.

[[ $a == z* ]]   # True if $a starts with a "z" (wildcard matching).
[[ $a == "z*" ]] # True if $a is equal to z* (literal matching).
```

So you had it <em>nearly</em> correct; you needed <em>double</em> brackets, not single brackets.  

<hr>

With regards to your second question, you can write it this way:  

```sh
HOST=user1
if  [[ $HOST == user1 ]] || [[ $HOST == node* ]] ;
then
    echo yes1
fi

HOST=node001
if [[ $HOST == user1 ]] || [[ $HOST == node* ]] ;
then
    echo yes2
fi
```

Which will echo  

```sh
yes1
yes2
```

Bash's `if` syntax is hard to get used to (IMO).  

#### Answer 2 (score 183)
If you're using a recent bash (v3+), I suggest bash regex comparison operator `=~`, i.e.  

```sh
if [[ "$HOST" =~ ^user.* ]]; then
    echo "yes"
fi
```

<hr>

To match `this or that` in a regex use `|`, i.e.  

```sh
if [[ "$HOST" =~ ^user.*|^host1 ]]; then
    echo "yes"
fi
```

Note - this is 'proper' regular expression syntax.  

<ul>
<li>`user*` means `use` and zero-or-more occurrences of `r`, so `use` and `userrrr` will match.</li>
<li>`user.*` means `user` and zero-or-more occurrences of any character, so `user1`, `userX` will match.</li>
<li>`^user.*` means match the pattern `user.*` at the begin of $HOST.</li>
</ul>

If you're not familiar with regular expression syntax, try referring to <a href="http://www.regular-expressions.info/reference.html" rel="noreferrer">this resource</a>.  

Note - it's better if you ask each new question as a new question, it makes stackoverflow tidier and more useful. You can always include a link back to a previous question for reference.  

#### Answer 3 (score 118)
I always try to stick with POSIX sh instead of using bash extensions, since one of the major points of scripting is portability. (Besides <strong>connecting</strong> programs, not replacing them)  

In sh, there is an easy way to check for an "is-prefix" condition.  

```sh
case $HOST in node*)
    your code here
esac
```

Given how old, arcane and crufty sh is (and bash is not the cure: It's more complicated, less consistent and less portable), I'd like to point out a very nice functional aspect: While some syntax elements like `case` are built-in, the resulting constructs are no different than any other job. They can be composed in the same way:  

```sh
if case $HOST in node*) true;; *) false;; esac; then
    your code here
fi
```

Or even shorter  

```sh
if case $HOST in node*) ;; *) false;; esac; then
    your code here
fi
```

Or <em>even</em> shorter (just to present `!` as a language element -- but this is bad style now)  

```sh
if ! case $HOST in node*) false;; esac; then
    your code here
fi
```

If you like being explicit, build your own language element:  

```sh
beginswith() { case $2 in "$1"*) true;; *) false;; esac; }
```

Isn't this actually quite nice?  

```sh
if beginswith node "$HOST"; then
    your code here
fi
```

And since sh is basically only jobs and string-lists (and internally processes, out of which jobs are composed), we can now even do some light functional programming:  

```sh
beginswith() { case $2 in "$1"*) true;; *) false;; esac; }
checkresult() { if [ $? = 0 ]; then echo TRUE; else echo FALSE; fi; }

all() {
    test=$1; shift
    for i in "$@"; do
        $test "$i" || return
    done
}

all "beginswith x" x xy xyz ; checkresult  # prints TRUE
all "beginswith x" x xy abc ; checkresult  # prints FALSE
```

This is elegant. Not that I'd advocate using sh for anything serious -- it breaks all too quickly on real world requirements (no lambdas, so must use strings. But nesting function calls with strings is not possible, pipes are not possible...)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: ls command: how can I get a recursive full-path listing, one line per file? (score [549377](https://stackoverflow.com/q/1767384) in 2013)

#### Question
How can I get ls to spit out a flat list of recursive one-per-line paths?  

For example, I just want a flat listing of files with their full paths:  

```sh
/home/dreftymac/.
/home/dreftymac/foo.txt
/home/dreftymac/bar.txt
/home/dreftymac/stackoverflow
/home/dreftymac/stackoverflow/alpha.txt
/home/dreftymac/stackoverflow/bravo.txt
/home/dreftymac/stackoverflow/charlie.txt
```

`ls -a1` almost does what I need, but I do not want path fragments, I want full paths.  

#### Answer accepted (score 362)
If you really want to use `ls`, then format its output using awk:  

```sh
ls -R /path | awk '
/:$/&&f{s=$0;f=0}
/:$/&&!f{sub(/:$/,"");s=$0;f=1;next}
NF&&f{ print s"/"$0 }'
```

#### Answer 2 (score 527)
Use find:  

```sh
find .
find /home/dreftymac
```

If you want files only (omit directories, devices, etc):  

```sh
find . -type f
find /home/dreftymac -type f
```

#### Answer 3 (score 71)
`ls -ld $(find .)`  

if you want to sort your output by modification time:  

`ls -ltd $(find .)`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: How do I run a shell script without using "sh" or "bash" commands? (score [530846](https://stackoverflow.com/q/8779951) in 2013)

#### Question
I have a shell script which I want to run without using the "sh" or "bash" commands. For example:  

Instead of: `sh script.sh`  

I want to use: `script.sh`  

How can I do this?  

P.S. (i) I don't use shell script much and I tried reading about aliases, but I did not understand how to use them.   

(ii) I also read about linking the script with another file in the PATH variables. I am using my  university server and I don't have permissions to create a file in those locations.   

#### Answer accepted (score 414)
Add a "shebang" at the top of your file:  

```sh
#!/bin/bash
```

And make your file executable (`chmod +x script.sh`).  

Finally, modify your path to add the directory where your script is located:  

```sh
export PATH=$PATH:/appropriate/directory
```

(typically, you want `$HOME/bin` for storing your own scripts)  

#### Answer 2 (score 66)
These are some of the prerequisites of directly using the script name:  

<ol>
<li>Add the `she-bang (#!/bin/bash)` line at the very top.</li>
<li>Using `chmod u+x scriptname` make the script executable. (where `scriptname` is the name of your script) </li>
<li>Place the script under `/usr/local/bin` folder.</li>
<li>Run the script using just the name of the script. </li>
</ol>

<strong>Note:</strong> The reason I suggested to place it under `/usr/local/bin` folder is because most likely that will be path already added to your `PATH variable`.   

<h5>Update:</h3>

If you don't have access to the `/usr/local/bin` folder then do the following:  

<ol>
<li>Create a folder in your home directory and let's call it `myscripts`.</li>
<li>Do `ls -lart` on your home directory, to identify the start-up script your shell is using. It should either be `.profile` or `.bashrc`. </li>
<li>Once you have identified the start up script, add the following line in your script -
`export set PATH=$PATH:~/myscript`.</li>
<li>Once added, source your start-up script or log out and log back in. </li>
<li>Execute your script using `scriptname`. </li>
</ol>

#### Answer 3 (score 20)
Just make sure it is executable, using `chmod +x`.  By default, the current directory is not on your PATH, so you will need to execute it as `./script.sh` - or otherwise reference it by a qualified path.  Alternatively, if you truly need just `script.sh`, you would need to add it to your PATH.  (You may not have access to modify the system path, but you can almost certainly modify the PATH of your own current environment.)  This also assumes that your script starts with something like `#!/bin/sh`.  

You could also still use an alias, which is not really related to shell scripting but just the shell, and is simple as:  

```sh
alias script.sh='sh script.sh'
```

Which would allow you to use just simply `script.sh` (literally - this won't work for any other `*.sh` file) instead of `sh script.sh`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: How to test if string exists in file with Bash? (score [526448](https://stackoverflow.com/q/4749330) in 2018)

#### Question
I have a file that contains directory names:  

`my_list.txt` :  

```sh
/tmp
/var/tmp
```

I'd like to check in Bash before I'll add a directory name if that name already exists in the file.  

#### Answer accepted (score 584)
```sh
grep -Fxq "$FILENAME" my_list.txt
```

The exit status is 0 (true) if the name was found, 1 (false) if not, so:  

```sh
if grep -Fxq "$FILENAME" my_list.txt
then
    # code if found
else
    # code if not found
fi
```

<h5>Explanation</h3>

Here are the relevant sections of <a href="https://linux.die.net/man/1/grep" rel="noreferrer">the man page for `grep`</a>:  

<blockquote>
```sh
grep [options] PATTERN [FILE...]
```
  
  `-F`, `--fixed-strings`  
  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Interpret PATTERN as a list of fixed strings, separated by  newlines, any of which is to be matched.  
  
  `-x`, `--line-regexp`  
  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Select only those matches that exactly match the whole line.  
  
  `-q`, `--quiet`, `--silent`  
  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quiet; do not write anything to standard output. Exit immediately  with  zero status if any match is found, even if an error  was detected. Also see the `-s` or `--no-messages` option.  
</blockquote>

<h5>Error handling</h3>

As rightfully pointed out in the comments, the above approach silently treats error cases as if the string was found. If you want to handle errors in a different way, you'll have to omit the `-q` option, and detect errors based on the exit status:  

<blockquote>
  Normally, the exit status is 0 if selected lines are found and 1 otherwise. But the exit status is 2 if an error occurred, unless the `-q` or `--quiet` or `--silent` option is used and a selected line is found. Note, however, that POSIX only mandates, for programs such as `grep`, `cmp`, and `diff`, that the exit status in case of error be greater than 1; it is therefore advisable, for the sake of portability, to use logic that tests for this general condition instead of strict equality with 2.  
</blockquote>

To suppress the normal output from `grep`, you can redirect it to `/dev/null`. Note that standard error remains undirected, so any error messages that `grep` might print will end up on the console as you'd probably want.  

To handle the three cases, we can use a `case` statement:  

```sh
case `grep -Fx "$FILENAME" "$LIST" >/dev/null; echo $?` in
  0)
    # code if found
    ;;
  1)
    # code if not found
    ;;
  *)
    # code if an error occurred
    ;;
esac
```

#### Answer 2 (score 86)
Regarding the following solution:  

```sh
grep -Fxq "$FILENAME" my_list.txt
```

In case you are wondering (as I did) what `-Fxq` means in plain English:  

<ul>
<li>`F`: Affects how PATTERN is interpreted (fixed string instead of a regex)</li>
<li>`x`: Match whole line</li>
<li>`q`: Shhhhh... minimal printing</li>
</ul>

From the man file:  

```sh
-F, --fixed-strings
    Interpret  PATTERN  as  a  list of fixed strings, separated by newlines, any of which is to be matched.
    (-F is specified by POSIX.)
-x, --line-regexp
    Select only those matches that exactly match the whole line.  (-x is specified by POSIX.)
-q, --quiet, --silent
    Quiet; do not write anything to standard output.  Exit immediately with zero status  if  any  match  is
          found,  even  if  an error was detected.  Also see the -s or --no-messages option.  (-q is specified by
          POSIX.)
```

#### Answer 3 (score 38)
Three methods in my mind:<br>  

1) Short test for a name in a path (I'm not sure this might be your case)  

```sh
ls -a "path" | grep "name"
```

<p><br>
2) Short test for a string in a file</p>

```sh
grep -R "string" "filepath"
```

<p><br>
3) Longer bash script using regex:</p>

```sh
#!/bin/bash

declare file="content.txt"
declare regex="\s+string\s+"

declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]] # please note the space before and after the file content
    then
        echo "found"
    else
        echo "not found"
fi

exit
```

This should be <strong>quicker</strong> if you have <strong>to test multiple string on a file</strong> content using a loop for example changing the regex at any cicle.<br>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Add a new element to an array without specifying the index in Bash (score [525121](https://stackoverflow.com/q/1951506) in 2017)

#### Question
Is there a way to do something like PHPs `$array[] = 'foo';` in bash vs doing:  

```sh
array[0] = 'foo'
array[1] = 'bar'
```

#### Answer accepted (score 1405)
Yes there is:  

```sh
ARRAY=()
ARRAY+=('foo')
ARRAY+=('bar')
```

<a href="http://www.gnu.org/software/bash/manual/bashref.html#Shell-Parameters" rel="noreferrer">Bash Reference Manual</a>:  

<blockquote>
  In the context where an assignment statement is assigning a value to a shell variable or array index (see Arrays), the ‘+=’ operator can be used to append to or add to the variable's previous value.  
</blockquote>

#### Answer 2 (score 72)
As <strong>Dumb Guy</strong> points out, it's important to note whether the array starts at zero and is sequential. Since you can make assignments to and unset non-contiguous indices `${#array[@]}` is not always the next item at the end of the array.  

```sh
$ array=(a b c d e f g h)
$ array[42]="i"
$ unset array[2]
$ unset array[3]
$ declare -p array     # dump the array so we can see what it contains
declare -a array='([0]="a" [1]="b" [4]="e" [5]="f" [6]="g" [7]="h" [42]="i")'
$ echo ${#array[@]}
7
$ echo ${array[${#array[@]}]}
h
```

Here's how to get the last index:  

```sh
$ end=(${!array[@]})   # put all the indices in an array
$ end=${end[@]: -1}    # get the last one
$ echo $end
42
```

That illustrates how to get the last element of an array. You'll often see this:  

```sh
$ echo ${array[${#array[@]} - 1]}
g
```

As you can see, because we're dealing with a sparse array, this isn't the last element. This works on both sparse and contiguous arrays, though:  

```sh
$ echo ${array[@]: -1}
i
```

#### Answer 3 (score 47)
```sh
$ declare -a arr
$ arr=("a")
$ arr=("${arr[@]}" "new")
$ echo ${arr[@]}
a new
$ arr=("${arr[@]}" "newest")
$ echo ${arr[@]}
a new newest
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: Create timestamp variable in bash script (score [514810](https://stackoverflow.com/q/17066250) in 2013)

#### Question
I am trying to create a timestamp variable in a shell script to make the logging a little easier. I want to create the variable at the beginning of the script and have it print out the current time whenever I issue `echo $timestamp`. It proving to be more difficult then I thought. Here are some things I've tried:  

`timestamp="(date +"%T")"` echo prints out `(date +"%T")`  

`timestamp="$(date +"%T")"` echo prints the time when the variable was initialized.  

Other things I've tried are just slight variations that didn't work any better. Does anyone know how to accomplish what I'm trying to do?  

#### Answer accepted (score 267)
In order to get the current timestamp and not the time of when a fixed variable is defined, the trick is to use a function and <strong>not</strong> a variable:  

```sh
#!/bin/bash

# Define a timestamp function
timestamp() {
  date +"%T"
}

# do something...
timestamp # print timestamp
# do something else...
timestamp # print another timestamp
# continue...
```

If you don't like the format given by the `%T` specifier you can combine the other time conversion specifiers accepted by `date`.  For GNU `date`, you can find the complete list of these specifiers in the official documentation here: <a href="https://www.gnu.org/software/coreutils/manual/html_node/Time-conversion-specifiers.html#Time-conversion-specifiers">https://www.gnu.org/software/coreutils/manual/html_node/Time-conversion-specifiers.html#Time-conversion-specifiers</a>  

#### Answer 2 (score 511)
If you want to get unix timestamp, then you need to use:  

```sh
timestamp=$(date +%s)
```

`%T` will give you just the time; same as `%H:%M:%S` (via <a href="http://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/" rel="noreferrer">http://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/</a>)  

#### Answer 3 (score 52)
```sh
DATE=`date "+%Y%m%d"`

DATE_WITH_TIME=`date "+%Y%m%d-%H%M%S"` #add %3N as we want millisecond too
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: How to run .sh on Windows Command Prompt? (score [510971](https://stackoverflow.com/q/26522789) in )

#### Question
How can I run .sh on Windows 7 Command Prompt? I always get this error when I try to run this line in it,  

```sh
app/build/build.sh
```

error,  

```sh
'app' is not recognized...
```

or,  

```sh
bash app/build/build.sh
```

error,  

```sh
'bash' is not recognized...
```

Any ideas what have I missed?   

<p>Here the screen grab,
<img src="https://i.stack.imgur.com/0mcPj.jpg" alt="enter image description here"></p>

#### Answer accepted (score 51)
The error message indicates that you have not installed `bash`, or it is not in your `PATH`.  

The top Google hit is <a href="http://win-bash.sourceforge.net/">http://win-bash.sourceforge.net/</a> but you also need to understand that most Bash scripts expect a Unix-like environment; so just installing Bash is probably unlikely to allow you to run a script you found on the net, unless it was specifically designed for this particular usage scenario.  The usual solution to that is <a href="https://www.cygwin.com/">https://www.cygwin.com/</a> but there are many possible alternatives, depending on what exactly it is that you want to accomplish.  

If Windows is not central to your usage scenario, installing a free OS (perhaps virtualized) might be the simplest way forward.  

The second error message is due to the fact that Windows nominally accepts forward slash as a directory separator, but in this context, it is being interpreted as a switch separator.  In other words, Windows parses your command line as `app /build /build.sh` (or, to paraphrase with Unix option conventions, `app --build --build.sh`).  You could try `app\build\build.sh` but it is unlikely to work, because of the circumstances outlined above.  

#### Answer 2 (score 111)
Install <a href="https://git-scm.com/downloads" rel="noreferrer">GIT</a>. During installation of GIT, add GIT Bash to windows context menu by selecting its option. After installation right click in your folder select `GIT Bash Here` (see attached pic) and use your sh command like for example:  

```sh
sh test.sh
```

<a href="https://i.stack.imgur.com/soecn.png" rel="noreferrer"><img src="https://i.stack.imgur.com/soecn.png" alt="enter image description here"></a>  

#### Answer 3 (score 47)
The most common way to run a <a href="http://en.wikipedia.org/wiki/Bourne_shell" rel="noreferrer"><strong>.sh</strong></a> file is using the <strong>sh</strong> command:  

```sh
C:\>sh my-script-test.sh 
```

other good option is installing <a href="https://www.cygwin.com/" rel="noreferrer"><strong>CygWin</strong></a>  

in `Windows` the `home` is located in:   

```sh
C:\cygwin64\home\[user]
```

for example i execute my `my-script-test.sh` file using the <a href="http://linux.about.com/library/cmd/blcmdl1_bash.htm" rel="noreferrer"><strong>bash</strong></a> command as:  

```sh
jorgesys@INT024P ~$ bash /home/[user]/my-script-test.sh 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Changing default shell in Linux (score [504666](https://stackoverflow.com/q/13046192) in 2019)

#### Question
How is it possible to change the default shell? The `env` command currently says:  

```sh
SHELL=/bin/tcsh
```

and I want to change that to Bash.  

#### Answer accepted (score 391)
Try linux command `chsh`.  

<p>The detailed command is `chsh -s /bin/bash`.
It will prompt you to enter your password.
Your default login shell is `/bin/bash` now. <strong>You must log out and log back in to see this change.</strong></p>

The following is quoted from man page:  

<blockquote>
  <p>The chsh command changes the user login shell. This determines the
  name
         of the users initial login command. A normal user may only change the
         login shell for her own account, the superuser may change the login
         shell for any account</p>
</blockquote>

This command will change the default login shell permanently.  

Note: If your user account is remote such as on Kerberos authentication (e.g. Enterprise RHEL) then you will not be able to use `chsh`.   

#### Answer 2 (score 142)
You can change the passwd file directly for the particular user or use the below command  

```sh
chsh -s /usr/local/bin/bash username
```

<strong>Then log out and log in</strong>  

#### Answer 3 (score 16)
You should have a 'skeleton' somewhere in `/etc`, probably `/etc/skeleton`, or check the default settings, probably `/etc/default` or something. Those are scripts that define standard environment variables getting set during a login.   

If it is just for your own account: check the (hidden) file `~/.profile` and `~/.login`. Or generate them, if they don't exist. These are also evaluated by the login process.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: echo that outputs to stderr (score [493483](https://stackoverflow.com/q/2990414) in 2014)

#### Question
Is there a standard Bash tool that acts like echo but outputs to stderr rather than stdout?  

I know I can do `echo foo 1&gt;&amp;2` but it's kinda ugly and, I suspect, error prone (e.g. more likely to get edited wrong when things change).   

#### Answer accepted (score 1283)
You could do this, which facilitates reading:  

```sh
>&2 echo "error"
```

`&gt;&amp;2` copies file descriptor #2 to file descriptor #1. Therefore, after this redirection is performed, both file descriptors will refer to the same file: the one file descriptor #2 was <strong>originally</strong> referring to. For more information see the <a href="http://wiki.bash-hackers.org/howto/redirection_tutorial" rel="noreferrer">Bash Hackers Illustrated Redirection Tutorial</a>.  

#### Answer 2 (score 398)
You could define a function:  

```sh
echoerr() { echo "$@" 1>&2; }
echoerr hello world
```

This would be faster than a script and have no dependencies.  

Camilo Martin's bash specific suggestion uses a "here string" and will print anything you pass to it, including arguments (-n) that echo would normally swallow:  

```sh
echoerr() { cat <<< "$@" 1>&2; }
```

Glenn Jackman's solution also avoids the argument swallowing problem:  

```sh
echoerr() { printf "%s\n" "$*" >&2; }
```

#### Answer 3 (score 230)
Since `1` is the standard output, you do not have to explicitly name it in front of an output redirection like `&gt;` but instead can simply type:  

<pre>
echo This message goes to stderr >&2
</pre>

Since you seem to be worried that `1&gt;&amp;2` will be difficult for you to reliably type, the elimination of the redundant `1` might be a slight encouragement to you!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Bash if statement with multiple conditions throws an error (score [493173](https://stackoverflow.com/q/16203088) in 2017)

#### Question
I'm trying to write a script that will check two error flags, and in case one flag (or both) are changed it'll echo-- error happened. My script:  

```sh
my_error_flag=0
my_error_flag_o=0
do something.....
if [[ "$my_error_flag"=="1" || "$my_error_flag_o"=="2" ] || [ "$my_error_flag"="1" &&     "$my_error_flag_o"="2" ]]; then
    echo "$my_error_flag"
else
    echo "no flag"
fi
```

Basically, it should be, something along:  

```sh
if ((a=1 or b=2) or (a=1 and b=2))
  then
     display error
else
     no error
fi
```

The error I get is:  

```sh
 line 26: conditional binary operator expected
 line 26: syntax error near `]'
 line 26: `if [[ "$my_error_flag"=="1" || "$my_error_flag_o"=="2" ] || [ "$my_error_flag"="1" && "$my_error_flag_o"="2" ]]; then'
```

Are my brackets messed up?  

#### Answer accepted (score 211)
Use `-a` (for and) and `-o` (for or) operations.  

<a href="http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html">tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html</a>  

Update  

Actually you could still use `&amp;&amp;` and `||` with the `-eq` operation. So your script would be like this:  

```sh
my_error_flag=1
my_error_flag_o=1
if [ $my_error_flag -eq 1 ] ||  [ $my_error_flag_o -eq 2 ] || ([ $my_error_flag -eq 1 ] && [ $my_error_flag_o -eq 2 ]); then
      echo "$my_error_flag"
else
    echo "no flag"
fi
```

Although in your case you can discard the last two expressions and just stick with one or operation like this:  

```sh
my_error_flag=1
my_error_flag_o=1
if [ $my_error_flag -eq 1 ] ||  [ $my_error_flag_o -eq 2 ]; then
      echo "$my_error_flag"
else
    echo "no flag"
fi
```

#### Answer 2 (score 58)
You can use either `[[` or `((` keyword. When you use `[[` keyword, you have to use string operators such as `-eq`, `-lt`. I think, `((` is most preferred for arithmetic, because you can directly use operators such as `==`, `&lt;` and `&gt;`.  

Using `[[` operator  

```sh
a=$1
b=$2
if [[ a -eq 1 || b -eq 2 ]] || [[ a -eq 3 && b -eq 4 ]]
then
     echo "Error"
else
     echo "No Error"
fi
```

Using `((` operator  

```sh
a=$1
b=$2
if (( a == 1 || b == 2 )) || (( a == 3 && b == 4 ))
then
     echo "Error"
else
     echo "No Error"
fi
```

Do not use `-a` or `-o` operators Since it is not Portable.  

#### Answer 3 (score 7)
Please try following  

```sh
if ([ $dateR -ge 234 ] && [ $dateR -lt 238 ]) || ([ $dateR -ge 834 ] && [ $dateR -lt 838 ]) || ([ $dateR -ge 1434 ] && [ $dateR -lt 1438 ]) || ([ $dateR -ge 2034 ] && [ $dateR -lt 2038 ]) ;
then
    echo "WORKING"
else
    echo "Out of range!"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: How to use ":" as awk field separator? (score [491168](https://stackoverflow.com/q/2609552) in 2010)

#### Question
Given following command:  

```sh
echo "1: " | awk '/1/ -F ":" {print $1}'
```

why does awk output:  

```sh
1: 
```

#### Answer accepted (score 348)
"-F" is a command line argument not awk syntax, try:     

```sh
 echo "1: " | awk -F  ":" '/1/ {print $1}'
```

#### Answer 2 (score 59)
If you want to do it programatically, you can use the `FS` variable:  

```sh
echo "1: " | awk 'BEGIN { FS=":" } /1/ { print $1 }'
```

Note that if you change it in the main loop rather than the `BEGIN` loop, it takes affect for the <em>next</em> line read in, since the current line has already been split.  

#### Answer 3 (score 27)
You have multiple ways to set `:` as separator:  

```sh
awk -F: '{print $1}'

awk -v FS=: '{print $1}'

awk '{print $1}' FS=:

awk 'BEGIN{FS=":"} {print $1}'
```

All of them are equivalent and for an will return `1` for a sample input "1:2:3":  

```sh
$ awk -F: '{print $1}' <<< "1:2:3"
1
$ awk -v FS=: '{print $1}' <<< "1:2:3"
1
$ awk '{print $1}' FS=: <<< "1:2:3"
1
$ awk 'BEGIN{FS=":"} {print $1}' <<< "1:2:3"
1
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: How can I remove the first line of a text file using bash/sed script? (score [486346](https://stackoverflow.com/q/339483) in 2011)

#### Question
I need to repeatedly remove the first line from a huge text file using a bash script.  

Right now I am using `sed -i -e "1d" $FILE` - but it takes around a minute to do the deletion.  

Is there a more efficient way to accomplish this?  

#### Answer accepted (score 948)
Try <a href="http://man7.org/linux/man-pages/man1/tail.1.html" rel="noreferrer">tail</a>:  

```sh
tail -n +2 "$FILE"
```

`-n x`: Just print the last `x` lines. `tail -n 5` would give you the last 5 lines of the input. The `+` sign kind of inverts the argument and make `tail` print anything but the first `x-1` lines. `tail -n +1` would print the whole file, `tail -n +2` everything but the first line, etc.  

GNU `tail` is much faster than `sed`. `tail` is also available on BSD and the `-n +2` flag is consistent across both tools. Check the <a href="https://www.freebsd.org/cgi/man.cgi?query=tail" rel="noreferrer">FreeBSD</a> or <a href="https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/tail.1.html" rel="noreferrer">OS X</a> man pages for more.   

The BSD version can be much slower than `sed`, though. I wonder how they managed that; `tail` should just read a file line by line while `sed` does pretty complex operations involving interpreting a script, applying regular expressions and the like.  

Note: You may be tempted to use  

```sh
# THIS WILL GIVE YOU AN EMPTY FILE!
tail -n +2 "$FILE" > "$FILE"
```

but this will give you an <strong>empty file</strong>. The reason is that the redirection (`&gt;`) happens before `tail` is invoked by the shell:  

<ol>
<li>Shell truncates file `$FILE`</li>
<li>Shell creates a new process for `tail`</li>
<li>Shell redirects stdout of the `tail` process to `$FILE`</li>
<li>`tail` reads from the now empty `$FILE`</li>
</ol>

If you want to remove the first line inside the file, you should use:  

```sh
tail -n +2 "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
```

The `&amp;&amp;` will make sure that the file doesn't get overwritten when there is a problem.  

#### Answer 2 (score 152)
You can use -i to update the file without using '>' operator. The following command will delete the first line from the file and save it to the file.  

```sh
sed -i '1d' filename
```

#### Answer 3 (score 71)
For those who are on SunOS which is non-GNU, the following code will help:  

```sh
sed '1d' test.dat > tmp.dat 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: ./configure : /bin/sh^M : bad interpreter (score [480455](https://stackoverflow.com/q/2920416) in 2010)

#### Question
I've been trying to install lpng142 on my fed 12 system. Seems like a problem to me. I get this error  

```sh
[root@localhost lpng142]# ./configure
bash: ./configure: /bin/sh^M: bad interpreter: No such file or directory
[root@localhost lpng142]# 
```

How do I fix this? The `/etc/fstab` file:  

```sh
#
# /etc/fstab
# Created by anaconda on Wed May 26 18:12:05 2010
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/VolGroup-lv_root /                       ext4    defaults        1 1
UUID=ce67cf79-22c3-45d4-8374-bd0075617cc8 /boot                   ext4    
defaults        1 2
/dev/mapper/VolGroup-lv_swap swap                    swap    defaults        0 0
tmpfs                   /dev/shm                tmpfs   defaults        0 0
devpts                  /dev/pts                devpts  gid=5,mode=620  0 0
sysfs                   /sys                    sysfs   defaults        0 0
proc                    /proc                   proc    defaults        0 0
```

#### Answer accepted (score 717)
To fix, open your script with vi or vim and enter in vi command mode (key <KBD>Esc</KBD>), then type this:  

```sh
:set fileformat=unix
```

Finally save it  

`:x!` or `:wq!`  

#### Answer 2 (score 360)
Looks like you have a dos line ending file. The clue is the `^M`.  

You need to re-save the file using Unix line endings.  

You might have a `dos2unix` command line utility that will also do this for you.  

#### Answer 3 (score 94)
Or if you want to do this with a script:  

```sh
sed -i 's/\r//' filename
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: How to do a recursive find/replace of a string with awk or sed? (score [478857](https://stackoverflow.com/q/1583219) in 2018)

#### Question
How do I find and replace every occurrence of:  

```sh
subdomainA.example.com
```

with   

```sh
subdomainB.example.com
```

in every text file under the `/home/www/` directory tree recursively?  

#### Answer 2 (score 809)
```sh
find /home/www \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i 's/subdomainA\.example\.com/subdomainB.example.com/g'
```

From `man find`:  

<blockquote>
  <strong>-print0</strong> (GNU `find` only) tells `find` to use the null character (`\0`) instead of whitespace as the output delimiter between pathnames found. This is a safer option if your files can contain blanks or other special characters. It is recommended to use the `-print0` argument to `find` if you use `-exec &lt;command&gt;` or `xargs` (the `-0` argument is needed in `xargs`.)  
</blockquote>

#### Answer 3 (score 238)
<strong>Note</strong>: Do not run this command on a folder including a git repo - changes to .git could corrupt your git index.  

```sh
find /home/www/ -type f -exec \
    sed -i 's/subdomainA\.example\.com/subdomainB.example.com/g' {} +
```

Compared to other answers here, this is simpler than most and uses sed instead of perl, which is what the original question asked for.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: How to get the primary IP address of the local machine on Linux and OS X? (score [477129](https://stackoverflow.com/q/13322485) in 2019)

#### Question
I am looking for a command line solution that would return me the primary (first) IP address of the localhost, other than 127.0.0.1  

The solution should work at least for Linux (Debian and RedHat) and OS X 10.7+  

I am aware that `ifconfig` is available on both but its output is not so consistent between these platforms.  

#### Answer accepted (score 447)
Use `grep` to filter IP address from `ifconfig`:   

`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`  

Or with `sed`:  

`ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'`  

If you are only interested in certain interfaces, wlan0, eth0, etc. then:  

`ifconfig wlan0 | ...`  

You can alias the command in your `.bashrc` to <em>create</em> your own command called `myip` for instance.  

`alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"`  

A much simpler way is `hostname -I` (`hostname -i` for older versions of `hostname` but see comments). However, this is on Linux only.   

#### Answer 2 (score 214)
For linux machines (not OS X) :  

```sh
hostname --ip-address
```

#### Answer 3 (score 210)
The following will work on Linux but not OSX.  

This doesn't rely on DNS at all, and it works even if `/etc/hosts` is not set correctly (`1` is shorthand for `1.0.0.0`):  

```sh
ip route get 1 | awk '{print $NF;exit}'
```

or avoiding `awk` and using Google's public DNS at `8.8.8.8` for obviousness:  

```sh
ip route get 8.8.8.8 | head -1 | cut -d' ' -f8
```

A less reliable way: (see comment below)  

```sh
hostname -I | cut -d' ' -f1
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: How to append output to the end of a text file (score [475123](https://stackoverflow.com/q/6207573) in 2018)

#### Question
How do I append the output of a command to the end of a text file?  

#### Answer 2 (score 582)
Use `&gt;&gt;` instead of `&gt;` when directing output to a file:  

```sh
your_command >> file_to_append_to
```

If `file_to_append_to` does not exist, it will be created.  

<strong>Example:</strong>  

```sh
$ echo "hello" > file
$ echo "world" >> file
$ cat file 
hello
world
```

#### Answer 3 (score 74)
To `append` a file use  `&gt;&gt;`  

<blockquote>
```sh
echo "hello world"  >> read.txt   
cat read.txt     
echo "hello siva" >> read.txt   
cat read.txt
```
  
  then the output should be  

```sh
hello world   # from 1st echo command
hello world   # from 2nd echo command
hello siva
```
</blockquote>

To `overwrite` a file use  `&gt;`  

<blockquote>
```sh
echo "hello tom" > read.txt
cat read.txt  
```
  
  then the out put is     
  
  `hello tom`  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: Given two directory trees, how can I find out which files differ? (score [474513](https://stackoverflow.com/q/4997693) in )

#### Question
If I want find the differences between two directory trees, I usually just execute:  

```sh
diff -r dir1/ dir2/
```

This outputs exactly what the differences are between corresponding files.  I'm interested in just getting a list of corresponding files whose content differs.  I assumed that this would simply be a matter of passing a command line option to `diff`, but I couldn't find anything on the man page.  

Any suggestions?  

#### Answer accepted (score 1052)
You said Linux, so you luck out (at least it should be available, not sure when it was added):  

```sh
diff --brief --recursive dir1/ dir2/ # GNU long options
diff -qr dir1/ dir2/ # common short options
```

Should do what you need.  

If you also want to see differences for files that may not exist in either directory:  

```sh
diff --brief --recursive --new-file dir1/ dir2/ # GNU long options
diff -qrN dir1/ dir2/ # common short options
```

#### Answer 2 (score 284)
The command I use is:  

```sh
diff -qr dir1/ dir2/
```

It is exactly the same as Mark's :) But his answer bothered me as it uses different <em>types</em> of flags, and it made me look twice. Using Mark's more verbose flags it would be:  

```sh
diff  --brief --recursive dir1/ dir2/
```

<sub>I apologise for posting when the other answer is perfectly acceptable. Could not stop myself... working on being less pedantic.</sub>   

#### Answer 3 (score 96)
I like to use `git diff --no-index dir1/ dir2/`, because it can show the differences in color (if you have that option set in your git config) and because it shows all of the differences in a long paged output using "less".  

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: How can I exclude all "permission denied" messages from "find"? (score [470044](https://stackoverflow.com/q/762348) in 2015)

#### Question
I need to hide all <em>permission denied</em> messages from:  

```sh
find . > files_and_folders
```

I am experimenting when such message arises. I need to gather all folders and files, to which it does not arise.   

Is it possible to direct the permission levels to the `files_and_folders` file?   

How can I hide the errors at the same time?  

#### Answer accepted (score 246)
<p><sup>Note:<br>
* This answer probably goes deeper than the use case warrants, and `find 2&gt;/dev/null` may be good enough in many situations. It may still be of interest for a cross-platform perspective and for its discussion of some advanced shell techniques in the interest of finding a solution that is as robust as possible, even though the cases guarded against may be largely hypothetical.<br>
* <strong>If your system is configured to show <em>localized</em> error messages</strong>, prefix the `find` calls below with `LC_ALL=C` (`LC_ALL=C find ...`) to ensure that <em>English</em> messages are reported, so that `grep -v 'Permission denied'` works as intended. Invariably, however, any error messages that <em>do</em> get displayed will then be in English as well.  </p>

If your <strong>shell is `bash` or `zsh`</strong>, there's <strong>a solution that is robust while being reasonably simple</strong>, using <strong>only POSIX-compliant `find` features</strong>; while `bash` itself is not part of POSIX, most modern Unix platforms come with it, making this solution widely portable:  

```sh
find . > files_and_folders 2> >(grep -v 'Permission denied' >&2)
```

Note: There's a small chance that some of `grep`'s output may arrive <em>after</em> `find` completes, because the overall command doesn't wait for the command inside `&gt;(...)` to finish. In `bash`, you can prevent this by appending `| cat` to the command.</sup>  

<ul>
<li><p>`&gt;(...)` is a (rarely used) <em>output</em> <a href="http://mywiki.wooledge.org/ProcessSubstitution" rel="noreferrer">process substitution</a> that allows redirecting output (in this case, <em>stderr</em> output (`2&gt;`) to the stdin of the command inside `&gt;(...)`.<br>
In addition to `bash` and `zsh`, `ksh` supports them as well <em>in principle</em>, but trying to combine them with redirection from <em>stderr</em>, as is done here (`2&gt; &gt;(...)`), appears to be silently ignored (in `ksh 93u+`).</p>

<ul>
<li>`grep -v 'Permission denied'` filters <em>out</em> (`-v`) all lines (from the `find` command's stderr stream) that contain the phrase `Permission denied` and outputs the remaining lines to stderr (`&gt;&amp;2`).</li>
</ul></li>
</ul>

This approach is:  

<ul>
<li><p><strong>robust</strong>: `grep` is only applied to <em>error messages</em> (and not to a combination of file paths and error messages, potentially leading to false positives), and error messages other than permission-denied ones are passed through, to stderr.</p></li>
<li><p><strong>side-effect free</strong>: `find`'s exit code is preserved: the inability to access at least one of the filesystem items encountered results in exit code `1` (although that won't tell you whether errors <em>other</em> than permission-denied ones occurred (too)).</p></li>
</ul>

<hr>

<h5>POSIX-compliant solutions:</h3>

Fully POSIX-compliant solutions either have limitations or require additional work.  

<strong>If `find`'s output is to be captured in a <em>file</em> anyway</strong> (or suppressed altogether), then the pipeline-based solution from <a href="https://stackoverflow.com/a/762360/45375">Jonathan Leffler's answer</a> is simple, robust, and POSIX-compliant:  

```sh
find . 2>&1 >files_and_folders | grep -v 'Permission denied' >&2
```

Note that the order of the redirections matters: `2&gt;&amp;1` must come <em>first</em>.  

Capturing stdout output in a file up front allows `2&gt;&amp;1` to send <em>only</em> error messages through the pipeline, which `grep` can then unambiguously operate on.  

<p>The <strong>only downside is that the <em>overall exit code</em> will be the `grep` command's</strong>, not `find`'s, which in this case means: if there are <em>no</em> errors at all or <em>only</em> permission-denied errors, the exit code will be `1` (signaling <em>failure</em>), otherwise (errors other than permission-denied ones) `0` - which is the opposite of the intent.<br>
<strong>That said, `find`'s exit code is rarely used anyway</strong>, as it often conveys little information beyond <em>fundamental</em> failure such as passing a non-existent path.<br>
However, the specific case of even only <em>some</em> of the input paths being inaccessible due to lack of permissions <em>is</em> reflected in `find`'s exit code (in both GNU and BSD `find`): if a permissions-denied error occurs for <em>any</em> of the files processed, the exit code is set to `1`.</p>

The following variation addresses that:  

```sh
find . 2>&1 >files_and_folders | { grep -v 'Permission denied' >&2; [ $? -eq 1 ]; }
```

<p>Now, the exit code indicates whether any errors <em>other than</em> `Permission denied` occurred: `1` if so, `0` otherwise.<br>
In other words: the exit code now reflects the true intent of the command: success (`0`) is reported, if no errors at all or <em>only</em> permission-denied errors occurred.<br>
This is arguably even better than just passing `find`'s exit code through, as in the solution at the top.</p>

<hr>

<a href="https://stackoverflow.com/users/1815797/gniourf-gniourf">gniourf_gniourf</a> in the comments proposes a (still POSIX-compliant) <strong>generalization of this solution using sophisticated redirections</strong>, which <strong>works even with the default behavior of printing the file paths to <em>stdout</em></strong>:  

```sh
{ find . 3>&2 2>&1 1>&3 | grep -v 'Permission denied' >&3; } 3>&2 2>&1
```

In short: Custom file descriptor `3` is used to temporarily swap stdout (`1`) and stderr (`2`), so that error messages <em>alone</em> can be piped to `grep` via stdout.  

Without these redirections, both data (file paths) <em>and</em> error messages would be piped to `grep` via stdout, and `grep` would then not be able to distinguish between <em>error message</em> `Permission denied` and a (hypothetical) <em>file whose name happens to contain</em> the phrase `Permission denied`.  

As in the first solution, however, the the exit code reported will be `grep`'s, not `find`'s, but the same fix as above can be applied.  

<hr>

<h5>Notes on the existing answers:</h3>

<ul>
<li><p>There are several points to note about <a href="https://stackoverflow.com/a/25234419/45375">Michael Brux's answer</a>, `find . ! -readable -prune -o -print`:</p>

<ul>
<li><p>It requires <em>GNU</em> `find`; notably, it won't work on macOS. Of course, if you only ever need the command to work with GNU `find`, this won't be a problem for you.</p></li>
<li><p>Some `Permission denied` errors may <em>still</em> surface: `find ! -readable -prune` reports such errors for the <em>child</em> items of directories for which the current user does have `r` permission, but lacks `x` (executable) permission. The reason is that because the directory itself <em>is</em> readable, `-prune` is not executed, and the attempt to descend <em>into</em> that directory then triggers the error messages. That said, the <em>typical</em> case is for the `r` permission to be missing.</p></li>
<li><p>Note: The following point is a matter of philosophy and/or specific use case, and you may decide it is not relevant to you and that the command fits your needs well, especially if simply <em>printing</em> the paths is all you do:</p>

<ul>
<li><em>If</em> you conceptualize the filtering of the permission-denied error messages a <em>separate</em> task that you want to be able to apply to <em>any</em> `find` command, then the opposite approach of proactively <em>preventing</em> permission-denied errors requires introducing "noise" into the `find` command, which also introduces complexity and logical <em>pitfalls</em>.</li>
<li>For instance, the most up-voted comment on Michael's answer (as of this writing) attempts to show how to <em>extend</em> the command by including a `-name` filter, as follows:<br>
`find . ! -readable -prune -o -name '*.txt'`<br>
This, however, does <em>not</em> work as intended, because the trailing `-print` action is <em>required</em> (an explanation can be found in <a href="https://stackoverflow.com/questions/1489277/how-to-use-prune-option-of-find-in-sh">this answer</a>). Such subtleties can introduce bugs.</li>
</ul></li>
</ul></li>
<li><p>The first solution in <a href="https://stackoverflow.com/a/762360/45375">Jonathan Leffler's answer</a>, `find . 2&gt;/dev/null &gt; files_and_folders`, as he himself states,  <strong>blindly silences <em>all</em> error messages</strong> (and the workaround is cumbersome and not fully robust, as he also explains). <strong>Pragmatically speaking</strong>, however, it is the <strong>simplest solution</strong>, as you may be content to assume that any and all errors would be permission-related.</p></li>
<li><p><a href="https://stackoverflow.com/a/27503763/45375">mist's answer</a>, `sudo find . &gt; files_and_folders`, <strong>is concise and pragmatic, but ill-advised for anything other than merely <em>printing</em> filenames</strong>, for security reasons: because you're running as the <em>root</em> user, "you risk having your whole system being messed up by a bug in find or a malicious version, or an incorrect invocation which writes something unexpectedly, which could not happen if you ran this with normal privileges" (from a comment on mist's answer by <a href="https://stackoverflow.com/users/874188/tripleee">tripleee</a>).  </p></li>
<li><p>The 2nd solution in <a href="https://stackoverflow.com/a/762377/45375">viraptor's answer</a>, `find . 2&gt;&amp;1 | grep -v 'Permission denied' &gt; some_file` runs the risk of false positives (due to sending a mix of stdout and stderr through the pipeline), and, potentially, instead of reporting <em>non</em>-permission-denied errors via stderr, captures them alongside the output paths in the output file.</p></li>
</ul>

#### Answer 2 (score 533)
Use:  

```sh
find . 2>/dev/null > files_and_folders
```

This hides not just the `Permission denied` errors, of course, but all error messages.  

If you really want to keep other possible errors, such as too many hops on a symlink, but not the permission denied ones, then you'd probably have to take a flying guess that you don't have many files called 'permission denied' and try:  

```sh
find . 2>&1 | grep -v 'Permission denied' > files_and_folders
```

<hr>

If you strictly want to filter just standard error, you can use the more elaborate construction:  

```sh
find . 2>&1 > files_and_folders | grep -v 'Permission denied' >&2
```

<p>The I/O redirection on the `find` command is: `2&gt;&amp;1 &gt; files_and_folders |`.
The pipe redirects standard output to the `grep` command and is applied first.  The `2&gt;&amp;1` sends standard error to the same place as standard output (the pipe). The `&gt; files_and_folders` sends standard output (but not standard error) to a file.  The net result is that messages written to standard error are sent down the pipe and the regular output of `find` is written to the file.  The `grep` filters the standard output (you can decide how selective you want it to be, and may have to change the spelling depending on locale and O/S) and the final `&gt;&amp;2` means that the surviving error messages (written to standard output) go to standard error once more. The final redirection could be regarded as optional at the terminal, but would be a very good idea to use it in a script so that error messages appear on standard error.</p>

There are endless variations on this theme, depending on what you want to do.  This will work on any variant of Unix with any Bourne shell derivative (Bash, Korn, …) and any POSIX-compliant version of <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/find.html" rel="noreferrer">`find`</a>.  

If you wish to adapt to the specific version of `find` you have on your system, there may be alternative options available.  GNU `find` in particular has a myriad options not available in other versions — see the currently accepted answer for one such set of options.  

#### Answer 3 (score 277)
Use:  

```sh
find . ! -readable -prune -o -print
```

or more generally  

```sh
find <paths> ! -readable -prune -o <other conditions like -name> -print
```

<ul>
<li>to avoid "Permission denied" </li>
<li>AND do NOT suppress (other) error messages</li>
<li>AND get exit status 0 ("all files are processed successfully")</li>
</ul>

<p>Works with: find (GNU findutils) 4.4.2.
Background:</p>

<ul>
<li>The `-readable` test matches readable files. The `!` operator returns true, when test is false. And `! -readable` matches not readable directories (&amp;files).</li>
<li>The `-prune` action does not descend into directory.</li>
<li>`! -readable -prune` can be translated to: if directory is not readable, do not descend into it.</li>
<li>The `-readable` test takes into account access control lists and other permissions artefacts  which  the `-perm` test ignores.</li>
</ul>

See also <a href="http://man7.org/linux/man-pages/man1/find.1.html" rel="noreferrer">`find`(1) manpage</a> for many more details.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: How to wait in bash for several subprocesses to finish and return exit code !=0 when any subprocess ends with code !=0? (score [469941](https://stackoverflow.com/q/356100) in 2018)

#### Question
How to wait in a bash script for several subprocesses spawned from that script to finish and return exit code !=0 when any of the subprocesses ends with code !=0 ?  

Simple script:  

```sh
#!/bin/bash
for i in `seq 0 9`; do
  doCalculations $i &
done
wait
```

The above script will wait for all 10 spawned subprocesses, but it will always give exit status 0 (see `help wait`). How can I modify this script so it will discover exit statuses of spawned subprocesses and return exit code 1 when any of subprocesses ends with code !=0?  

Is there any better solution for that than collecting PIDs of the subprocesses, wait for them in order and sum exit statuses?  

#### Answer accepted (score 460)
<p><a href="https://www.gnu.org/software/bash/manual/html_node/Job-Control-Builtins.html#index-wait" rel="noreferrer">`wait`</a> also (optionally) takes the PID of the process to wait for, and with $! you get the PID of the last command launched in background.
Modify the loop to store the PID of each spawned sub-process into an array, and then loop again waiting on each PID.</p>

```sh
# run processes and store pids in array
for i in $n_procs; do
    ./procs[${i}] &
    pids[${i}]=$!
done

# wait for all pids
for pid in ${pids[*]}; do
    wait $pid
done
```

#### Answer 2 (score 273)
<a href="http://jeremy.zawodny.com/blog/archives/010717.html" rel="noreferrer">http://jeremy.zawodny.com/blog/archives/010717.html</a> :  

```sh
#!/bin/bash

FAIL=0

echo "starting"

./sleeper 2 0 &
./sleeper 2 1 &
./sleeper 3 0 &
./sleeper 2 0 &

for job in `jobs -p`
do
echo $job
    wait $job || let "FAIL+=1"
done

echo $FAIL

if [ "$FAIL" == "0" ];
then
echo "YAY!"
else
echo "FAIL! ($FAIL)"
fi
```

#### Answer 3 (score 46)
If you have GNU Parallel installed you can do:  

```sh
# If doCalculations is a function
export -f doCalculations
seq 0 9 | parallel doCalculations {}
```

GNU Parallel will give you exit code:  

<ul>
<li><p>0 - All jobs ran without error.</p></li>
<li><p>1-253 - Some of the jobs failed. The exit status gives the number of failed jobs</p></li>
<li><p>254 - More than 253 jobs failed.</p></li>
<li><p>255 - Other error.</p></li>
</ul>

Watch the intro videos to learn more: <a href="http://pi.dk/1" rel="nofollow noreferrer">http://pi.dk/1</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: Extract file basename without path and extension in bash (score [465033](https://stackoverflow.com/q/2664740) in 2017)

#### Question
Given file names like these:  

```sh
/the/path/foo.txt
bar.txt
```

I hope to get:  

```sh
foo
bar
```

Why this doesn't work?  

```sh
#!/bin/bash

fullfile=$1
fname=$(basename $fullfile)
fbname=${fname%.*}
echo $fbname
```

What's the right way to do it?  

#### Answer accepted (score 587)
You don't have to call the external `basename` command. Instead, you could use the following commands:  

```sh
$ s=/the/path/foo.txt
$ echo ${s##*/}
foo.txt
$ s=${s##*/}
$ echo ${s%.txt}
foo
$ echo ${s%.*}
foo
```

Note that this solution should work in all recent (<em>post 2004</em>) <em>POSIX</em> compliant shells, (e.g. `bash`, `dash`, `ksh`, etc.).  

Source: <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02" rel="noreferrer">Shell Command Language 2.6.2 Parameter Expansion</a>  

More on bash String Manipulations:  <a href="http://tldp.org/LDP/LG/issue18/bash.html" rel="noreferrer">http://tldp.org/LDP/LG/issue18/bash.html</a>  

#### Answer 2 (score 267)
The <a href="http://opengroup.org/onlinepubs/007908799/xcu/basename.html">basename</a> command has two different invocations; in one, you specify just the path, in which case it gives you the last component, while in the other you also give a suffix that it will remove. So, you can simplify your example code by using the second invocation of basename. Also, be careful to correctly quote things:  

<pre>
fbname=$(basename "$1" .txt)
echo "$fbname"
</pre>

#### Answer 3 (score 57)
A combination of basename and cut works fine, even in case of double ending like `.tar.gz`:  

```sh
fbname=$(basename "$fullfile" | cut -d. -f1)
```

Would be interesting if this solution needs less arithmetic power than Bash Parameter Expansion.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: Make a Bash alias that takes a parameter? (score [463475](https://stackoverflow.com/q/7131670) in 2017)

#### Question
I used to use CShell (<a href="/questions/tagged/csh" class="post-tag" title="show questions tagged &#39;csh&#39;" rel="tag">csh</a>), which lets you make an alias that takes a parameter. The notation was something like  

```sh
alias junk="mv \\!* ~/.Trash"
```

In Bash, this does not seem to work. Given that Bash has a multitude of useful features, I would assume that this one has been implemented but I am wondering how.  

#### Answer accepted (score 1928)
Bash alias does not directly accept parameters. You will have to create a function.  

`alias` does not accept parameters but a function can be called just like an alias. For example:  

```sh
myfunction() {
    #do things with parameters like $1 such as
    mv "$1" "$1.bak"
    cp "$2" "$1"
}


myfunction old.conf new.conf #calls `myfunction`
```

By the way, Bash functions defined in your `.bashrc` and other files are available as commands within your shell. So for instance you can call the earlier function like this   

```sh
$ myfunction original.conf my.conf
```

#### Answer 2 (score 193)
Refining the answer above, you can get 1-line syntax like you can for aliases, which is more convenient for ad-hoc definitions in a shell or .bashrc files:  

```sh
bash$ myfunction() { mv "$1" "$1.bak" && cp -i "$2" "$1"; }

bash$ myfunction original.conf my.conf
```

Don't forget the semi-colon before the closing right-bracket. Similarly, for the actual question:  

```sh
csh% alias junk="mv \\!* ~/.Trash"

bash$ junk() { mv "$@" ~/.Trash/; }
```

Or:  

```sh
bash$ junk() { for item in "$@" ; do echo "Trashing: $item" ; mv "$item" ~/.Trash/; done; }
```

#### Answer 3 (score 105)
The question is simply asked wrong.  You don't make an alias that takes parameters because `alias` just adds a second name for something that already exists.  The functionality the OP wants is the `function` command to create a new function.  You do not need to alias the function as the function already has a name.  

I think you want something like this :  

```sh
function trash() { mv "$@" ~/.Trash; }
```

That's it!  You can use parameters $1, $2, $3, etc, or just stuff them all with $@  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: Find all storage devices attached to a Linux machine (score [460866](https://stackoverflow.com/q/200960) in 2013)

#### Question
I have a need to find all of the writable storage devices attached to a given machine, <strong>whether or not</strong> they are mounted.  

The dopey way to do this would be to <em>try</em> every entry in `/dev` that corresponds to a writable devices (`hd* and sd*`)......  

Is there a better solution, or should I stick with this one?  

#### Answer accepted (score 78)
`/proc/partitions` will list all the block devices and partitions that the system recognizes.  You can then try using `file -s &lt;device&gt;` to determine what kind of filesystem is present on the partition, if any.  

#### Answer 2 (score 71)
You can always do `fdisk -l` which seems to work pretty well, even on strange setups such as EC2 xvda devices.  

Here is a dump for a m1.large instance:  

```sh
root@ip-10-126-247-82:~# fdisk -l

Disk /dev/xvda1: 10.7 GB, 10737418240 bytes
255 heads, 63 sectors/track, 1305 cylinders, total 20971520 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

Disk /dev/xvda1 doesn't contain a valid partition table

Disk /dev/xvda2: 365.0 GB, 365041287168 bytes
255 heads, 63 sectors/track, 44380 cylinders, total 712971264 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

Disk /dev/xvda2 doesn't contain a valid partition table

Disk /dev/xvda3: 939 MB, 939524096 bytes
255 heads, 63 sectors/track, 114 cylinders, total 1835008 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

Disk /dev/xvda3 doesn't contain a valid partition table
```

While `mount` says:  

```sh
root@ip-10-126-247-82:~# mount
/dev/xvda1 on / type ext4 (rw)
proc on /proc type proc (rw,noexec,nosuid,nodev)
sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
fusectl on /sys/fs/fuse/connections type fusectl (rw)
none on /sys/kernel/debug type debugfs (rw)
none on /sys/kernel/security type securityfs (rw)
udev on /dev type devtmpfs (rw,mode=0755)
devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
tmpfs on /run type tmpfs (rw,noexec,nosuid,size=10%,mode=0755)
none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=5242880)
none on /run/shm type tmpfs (rw,nosuid,nodev)
/dev/xvda2 on /mnt type ext3 (rw)
```

And `/proc/partitions` says:  

```sh
root@ip-10-126-247-82:~# cat /proc/partitions
major minor  #blocks  name

 202        1   10485760 xvda1
 202        2  356485632 xvda2
 202        3     917504 xvda3
```

<h5>Side Note</h1>

How `fdisk -l` works is something I would love to know myself.  

#### Answer 3 (score 35)
you can also try <strong>lsblk</strong> ... is in util-linux ... but i have a question too  

```sh
fdisk -l /dev/sdl
```

no result  

```sh
grep sdl /proc/partitions      
   8      176   15632384 sdl
   8      177   15628288 sdl1

lsblk | grep sdl
sdl       8:176  1  14.9G  0 disk  
`-sdl1    8:177  1  14.9G  0 part  
```

fdisk is good but not that good ... seems like it cannot "see" everything  

in my particular example i have a stick that have also a card reader build in it and i can see only the stick using fdisk:  

```sh
fdisk -l /dev/sdk

Disk /dev/sdk: 15.9 GB, 15931539456 bytes
255 heads, 63 sectors/track, 1936 cylinders, total 31116288 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xbe24be24

   Device Boot      Start         End      Blocks   Id  System
/dev/sdk1   *        8192    31116287    15554048    c  W95 FAT32 (LBA)
```

but not the card (card being /dev/sdl)  

also, file -s is inefficient ...   

```sh
file -s /dev/sdl1
/dev/sdl1: sticky x86 boot sector, code offset 0x52, OEM-ID "NTFS    ", sectors/cluster 8, reserved sectors 0, Media descriptor 0xf8, heads 255, hidden sectors 8192, dos < 4.0 BootSector (0x0)
```

that's nice ... BUT  

```sh
fdisk -l /dev/sdb
/dev/sdb1            2048   156301487    78149720   fd  Linux raid autodetect
/dev/sdb2       156301488   160086527     1892520   82  Linux swap / Solaris

file -s /dev/sdb1
/dev/sdb1: sticky \0
```

to see information about a disk that cannot be accesed by fdisk, you can use parted:  

```sh
parted /dev/sdl print

Model: Mass Storage Device (scsi)
Disk /dev/sdl: 16.0GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type     File system  Flags
 1      4194kB  16.0GB  16.0GB  primary  ntfs




arted /dev/sdb print 
Model: ATA Maxtor 6Y080P0 (scsi)
Disk /dev/sdb: 82.0GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type     File system     Flags
 1      1049kB  80.0GB  80.0GB  primary                  raid
 2      80.0GB  82.0GB  1938MB  primary  linux-swap(v1)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Length of string in bash (score [460216](https://stackoverflow.com/q/17368067) in 2017)

#### Question
How do you get the length of a string stored in a variable and assign that to another variable?  

```sh
myvar="some string"
echo ${#myvar}  
# 11
```

How do you set another variable to the output `11`?  

#### Answer accepted (score 234)
<h5>UTF-8 string length</h3>

In addition to <a href="https://stackoverflow.com/a/17368090/1983854">fedorqui's correct answer</a>, I would like to show the difference between string length and byte length:  

```sh
myvar='Généralités'
chrlen=${#myvar}
oLang=$LANG oLcAll=$LC_ALL
LANG=C LC_ALL=C
bytlen=${#myvar}
LANG=$oLang LC_ALL=$oLcAll
printf "%s is %d char len, but %d bytes len.\n" "${myvar}" $chrlen $bytlen
```

will render:  

```sh
Généralités is 11 char len, but 14 bytes len.
```

you could even have a look at stored chars:  

```sh
myvar='Généralités'
chrlen=${#myvar}
oLang=$LANG oLcAll=$LC_ALL
LANG=C LC_ALL=C
bytlen=${#myvar}
printf -v myreal "%q" "$myvar"
LANG=$oLang LC_ALL=$oLcAll
printf "%s has %d chars, %d bytes: (%s).\n" "${myvar}" $chrlen $bytlen "$myreal"
```

will answer:  

```sh
Généralités has 11 chars, 14 bytes: ($'G\303\251n\303\251ralit\303\251s').
```

<strong>Nota:</strong> According to <a href="https://stackoverflow.com/questions/17368067/length-of-string-in-bash/31009961#comment69945980_31009961">Isabell Cowan's comment</a>, I've added setting to `$LC_ALL` along with `$LANG`.  

<h5>Length of an argument</h3>

Argument work same as regular variables  

```sh
strLen() {
    local bytlen sreal oLang=$LANG oLcAll=$LC_ALL
    LANG=C LC_ALL=C
    bytlen=${#1}
    printf -v sreal %q "$1"
    LANG=$oLang LC_ALL=$oLcAll
    printf "String '%s' is %d bytes, but %d chars len: %s.\n" "$1" $bytlen ${#1} "$sreal"
}
```

will work as  

```sh
strLen théorème
String 'théorème' is 10 bytes, but 8 chars len: $'th\303\251or\303\250me'
```

<h5>Useful `printf` correction tool:</h3>

If you:  

```sh
for string in Généralités Language Théorème Février  "Left: ←" "Yin Yang ☯";do
    printf " - %-14s is %2d char length\n" "'$string'"  ${#string}
done

 - 'Généralités' is 11 char length
 - 'Language'     is  8 char length
 - 'Théorème'   is  8 char length
 - 'Février'     is  7 char length
 - 'Left: ←'    is  7 char length
 - 'Yin Yang ☯' is 10 char length
```

Not really <em>pretty</em>... For this, there is a little function:  

```sh
strU8DiffLen () { 
    local bytlen oLang=$LANG oLcAll=$LC_ALL
    LANG=C LC_ALL=C
    bytlen=${#1}
    LANG=$oLang LC_ALL=$oLcAll
    return $(( bytlen - ${#1} ))
}
```

Then now:  

```sh
for string in Généralités Language Théorème Février  "Left: ←" "Yin Yang ☯";do
    strU8DiffLen "$string"
    printf " - %-$((14+$?))s is %2d chars length, but uses %2d bytes\n" \
        "'$string'" ${#string} $((${#string}+$?))
  done 

 - 'Généralités'  is 11 chars length, but uses 14 bytes
 - 'Language'     is  8 chars length, but uses  8 bytes
 - 'Théorème'     is  8 chars length, but uses 10 bytes
 - 'Février'      is  7 chars length, but uses  8 bytes
 - 'Left: ←'      is  7 chars length, but uses  9 bytes
 - 'Yin Yang ☯'   is 10 chars length, but uses 12 bytes
```

But there left some strange UTF-8 behaviour, like double-spaced chars, zero spaced chars, reverse deplacement and other that could not be as simple... Have a look at <a href="https://f-hauri.ch/vrac/diffU8test.sh" rel="noreferrer">diffU8test.sh</a> or <a href="https://f-hauri.ch/vrac/diffU8test.sh.txt" rel="noreferrer">diffU8test.sh.txt</a> for more limitations.  

#### Answer 2 (score 442)
To get the length of a string stored in a variable, say:  

```sh
myvar="some string"
size=${#myvar} 
```

To confirm it was properly saved, `echo` it:  

```sh
$ echo "$size"
11
```

#### Answer 3 (score 22)
You can use:  

```sh
MYSTRING="abc123"
MYLENGTH=$(printf "%s" "$MYSTRING" | wc -c)
```

<ul>
<li>`wc -c` or `wc --bytes` for byte counts = Unicode characters are counted with 2, 3 or more bytes.</li>
<li>`wc -m` or `wc --chars` for character counts = Unicode characters are counted single until they use more bytes.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Get current time in seconds since the Epoch on Linux, Bash (score [459374](https://stackoverflow.com/q/1092631) in 2018)

#### Question
I need something simple like `date`, but in seconds since 1970 instead of the current date, hours, minutes, and seconds.  

`date` doesn't seem to offer that option. Is there an easy way?  

#### Answer accepted (score 1026)
This should work:  

```sh
date +%s
```

#### Answer 2 (score 119)
<p>Just to add.<br><BR>
Get the seconds since epoch(Jan 1 1970) for any given date(e.g Oct 21 1973).</p>

```sh
date -d "Oct 21 1973" +%s
```

<p><br>
 Convert the number of seconds back to date</p>

```sh
date --date @120024000
```

<p><br>
  The command `date` is pretty versatile. Another cool thing you can do with date(shamelessly copied from `date --help`).
  Show the local time for 9AM next Friday on the west coast of the US</p>

```sh
date --date='TZ="America/Los_Angeles" 09:00 next Fri'
```

<p>Better yet, take some time to read the man page 
<a href="http://man7.org/linux/man-pages/man1/date.1.html" rel="noreferrer">http://man7.org/linux/man-pages/man1/date.1.html</a></p>

#### Answer 3 (score 36)
So far, all the answers use the external program `date`.  

Since Bash 4.2, `printf` has a new modifier `%(dateformat)T` that, when used with argument `-1` outputs the current date with format given by `dateformat`, handled by `strftime(3)` (`man 3 strftime` for informations about the formats).  

So, for a pure Bash solution:  

```sh
printf '%(%s)T\n' -1
```

or if you need to store the result in a variable `var`:  

```sh
printf -v var '%(%s)T' -1
```

No external programs and no subshells!  

Since Bash 4.3, it's even possible to not specify the `-1`:  

```sh
printf -v var '%(%s)T'
```

(but it might be wiser to always give the argument `-1` nonetheless).  

If you use `-2` as argument instead of `-1`, Bash will use the time the shell was started instead of the current date (but why would you want this?).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: How do I edit $PATH (.bash_profile) on OSX? (score [458023](https://stackoverflow.com/q/30461201) in 2019)

#### Question
I am trying to edit an entry to PATH, as I did something wrong.   

I am using Mac OS X 10.10.3   

I have tried:   

```sh
> touch ~/.bash_profile; open ~/.bash_profile
```

But the file editor opens with nothing inside.  

My problem:  

I am trying to install ANDROID_HOME to my PATH  

I misspelled it, but when I closed the terminal and went back it was gone, so I tried again:  

<blockquote>
```sh
export ANDROID_HOME=/<installation location>/android-sdk-macosx
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```
</blockquote>

This time, I typed the command correctly but, when I closed the terminal, my settings disappeared again.  

How do I execute my desired settings?  

If I was to edit bash.profile, how would I enter the above code?   

Thanks!  

#### Answer accepted (score 300)
You have to open that file with a text editor and then save it.  

```sh
touch ~/.bash_profile; open ~/.bash_profile
```

It will open the file with TextEdit, paste your things and then save it. If you open it again you'll find your edits.  

You can use other editors:  

```sh
nano ~/.bash_profile
mate ~/.bash_profile
vim ~/.bash_profile
```

But if you don't know how to use them, it's easier to use the `open` approach.  

<hr>

Alternatively, you can rely on `pbpaste`. Copy  

```sh
export ANDROID_HOME=/<installation location>/android-sdk-macosx
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

in the system clipboard and then in a shell run  

```sh
pbpaste > ~/.bash_profile
```

<hr>

Or alternatively you can also use `cat`  

```sh
cat > ~/.bash_profile
```

(now `cat` waits for input: paste the two export definitions and then hit ctrl-D).  

#### Answer 2 (score 64)
A bit more detailed for beginners:  

First, make sure the <strong>.bash_profile file is existing?</strong> Remember that the .bash_profile file isn't there by default. You have to create it on your own.  

<p>Go into your <strong>user folder in finder</strong>.
The .bash_profile file should be findable there.
-> <strong>HD/Users/[USERNAME]</strong></p>

Remember: Files with a point at the beginning <strong>'.' are hidden</strong> by default.  

To show hidden files in Mac OS Finder:  

```sh
Press: Command + Shift + .
```

If it's not existing, <strong>you have to create .bash_profile</strong> on your own.  

<strong>Open terminal</strong> app and switch into <strong>user folder</strong> with simple command:  

```sh
cd
```

If it's not existing, use this <strong>command to create the file</strong>:  

```sh
touch .bash_profile
```

Second, if you can't memorise the nerdy commands for save and close in vim, nano etc (the way recommended above) the easiest way to edit is to open .bash_profile file in your favored code editor (Sublime etc.).  

Finder -> User folder. Right click -> open with : Sublime Text (or other code editor). Or drag it on app in dock.  

… and there you can edit it, pass export commands in new lines.  

#### Answer 3 (score 8)
For beginners: To create your `.bash_profile` file in your home directory on MacOS, run:  

`nano ~/.bash_profile`  

Then you can paste in the following:  

<a href="https://gist.github.com/mocon/0baf15e62163a07cb957888559d1b054" rel="noreferrer">https://gist.github.com/mocon/0baf15e62163a07cb957888559d1b054</a>  

As you can see, it includes some example aliases and an environment variable at the bottom.  

One you're done making your changes, follow the instructions at the bottom of the Nano editor window to WriteOut (`Ctrl-O`) and Exit (`Ctrl-X`). Then quit your Terminal and reopen it, and you will be able to use your newly defined aliases and environment variables.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: Bash script and /bin/bash^M: bad interpreter: No such file or directory (score [456363](https://stackoverflow.com/q/14219092) in 2019)

#### Question
I'm learning through this tutorial to learn <a href="http://linuxcommand.org/wss0010.php" rel="noreferrer">bash scripts</a> to automate a few tasks for me. I'm connecting to a server using putty.  

The script, located in `.../Documents/LOG`, is:  

```sh
#!/bin/bash
# My first script
echo "Hello World!"
```

And I executed the following for read/write/execute permissions  

```sh
chmod 755 my_script
```

Then, when I enter `./my_script`, I'm getting the error given in the title.  

Some similar questions wanted to see these, so I think they might help:  

```sh
which bash
```

<blockquote>
  /bin/bash  
</blockquote>

and  

```sh
echo $PATH
```

<blockquote>
  /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/bin/mh  
</blockquote>

I tried adding current directory to `PATH`, but that doesn't work..  

#### Answer accepted (score 501)
I have seen this issue when creating scripts in Windows env and then porting over to run on a Unix environment.  

Try running `dos2unix`  on the script:  

<a href="http://dos2unix.sourceforge.net/" rel="noreferrer">http://dos2unix.sourceforge.net/</a>  

Or just rewrite the script in your Unix env using `vi` and test.  

Unix uses different line endings so can't read the file you created on Windows. Hence it is seeing ^M as an illegal character.  

If you want to write a file on Windows and then port over, make sure your editor is set to create files in UNIX format.  

In notepad++ in the bottom right of the screen, it tells you the document format. By default, it will say `Dos\Windows`. To change it go to   

<ul>
<li>settings->preferences </li>
<li>new document / default directory tab</li>
<li>select the format as unix and close</li>
<li>create a new document</li>
</ul>

#### Answer 2 (score 430)
Run following command in terminal  

```sh
sed -i -e 's/\r$//' scriptname.sh
```

Then try   

```sh
./scriptname.sh
```

It should work.  

#### Answer 3 (score 116)
If you use <strong>Sublime Text</strong> on Windows or Mac to edit your scripts:  

Click on `View &gt; Line Endings &gt; Unix` and <strong>save</strong> the file again.  

<img src="https://i.stack.imgur.com/jkZER.png" alt="enter image description here">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: Check if a Bash array contains a value (score [456169](https://stackoverflow.com/q/3685970) in 2017)

#### Question
In Bash, what is the simplest way to test if an array contains a certain value?      

<strong>Edit</strong>: With help from the answers and the comments, after some testing, I came up with this:  

```sh
function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo "y"
            return 0
        fi
    }
    echo "n"
    return 1
}

A=("one" "two" "three four")
if [ $(contains "${A[@]}" "one") == "y" ]; then
    echo "contains one"
fi
if [ $(contains "${A[@]}" "three") == "y" ]; then
    echo "contains three"
fi
```

I'm not sure if it's the best solution, but it seems to work.  

#### Answer accepted (score 7)
There is <a href="http://tldp.org/LDP/abs/html/arrays.html#ARRAYSTROPS" rel="nofollow noreferrer">sample code that shows how to replace a substring from an array</a>.  You can make a copy of the array and try to remove the target value from the copy.  If the copy and original are then different, then the target value exists in the original string.  

The straightforward (but potentially more time-consuming) solution is to simply iterate through the entire array and check each item individually.  This is what I typically do because it is easy to implement and you can wrap it in a function (see <a href="http://www.faqs.org/docs/abs/HTML/assortedtips.html#ARRFUNC" rel="nofollow noreferrer">this info on passing an array to a function</a>).  

#### Answer 2 (score 368)
This approach has the advantage of not needing to loop over all the elements (at least not explicitly).  But since `array_to_string_internal()` in <a href="http://git.savannah.gnu.org/cgit/bash.git/tree/array.c" rel="noreferrer">array.c</a> still loops over array elements and concatenates them into a string, it's probably not more efficient than the looping solutions proposed, but it's more readable.  

```sh
if [[ " ${array[@]} " =~ " ${value} " ]]; then
    # whatever you want to do when arr contains value
fi

if [[ ! " ${array[@]} " =~ " ${value} " ]]; then
    # whatever you want to do when arr doesn't contain value
fi
```

Note that in cases where the value you are searching for is one of the words in an array element with spaces, it will give false positives.  For example  

```sh
array=("Jack Brown")
value="Jack"
```

The regex will see `Jack` as being in the array even though it isn't.  So you'll have to change `IFS` and the separator characters on your regex if you want still to use this solution, like this  

```sh
IFS=$'\t'
array=("Jack Brown\tJack Smith")
unset IFS

value="Jack Smith"

if [[ "\t${array[@]}\t" =~ "\t${value}\t" ]]; then
    echo "yep, it's there"
fi
```

#### Answer 3 (score 366)
Below is a small function for achieving this. The search string is the first argument and the rest are the array elements:  

```sh
containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}
```

A test run of that function could look like:  

```sh
$ array=("something to search for" "a string" "test2000")
$ containsElement "a string" "${array[@]}"
$ echo $?
0
$ containsElement "blaha" "${array[@]}"
$ echo $?
1
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Find and kill a process in one line using bash and regex (score [456080](https://stackoverflow.com/q/3510673) in 2010)

#### Question
I often need to kill a process during programming.  

The way I do it now is:  

```sh
[~]$ ps aux | grep 'python csp_build.py'
user    5124  1.0  0.3 214588 13852 pts/4    Sl+  11:19   0:00 python csp_build.py
user    5373  0.0  0.0   8096   960 pts/6    S+   11:20   0:00 grep python csp_build.py
[~]$ kill 5124
```

How can I extract the process id automatically and kill it in the same line?  

Like this:  

```sh
[~]$ ps aux | grep 'python csp_build.py' | kill <regex that returns the pid>
```

#### Answer accepted (score 1287)
In `bash`, you should be able to do:  

```sh
kill $(ps aux | grep '[p]ython csp_build.py' | awk '{print $2}')
```

Details on its workings are as follows:  

<ul>
<li>The `ps` gives you the list of all the processes.</li>
<li>The `grep` filters that based on your search string, `[p]` is a trick to stop you picking up the actual `grep` process itself.</li>
<li>The `awk` just gives you the second field of each line, which is the PID.</li>
<li>The `$(x)` construct means to execute `x` then take its output and put it on the command line. The output of that `ps` pipeline inside that construct above is the list of process IDs so you end up with a command like `kill 1234 1122 7654`.</li>
</ul>

Here's a transcript showing it in action:  

```sh
pax> sleep 3600 &
[1] 2225
pax> sleep 3600 &
[2] 2226
pax> sleep 3600 &
[3] 2227
pax> sleep 3600 &
[4] 2228
pax> sleep 3600 &
[5] 2229
pax> kill $(ps aux | grep '[s]leep' | awk '{print $2}')
[5]+  Terminated              sleep 3600
[1]   Terminated              sleep 3600
[2]   Terminated              sleep 3600
[3]-  Terminated              sleep 3600
[4]+  Terminated              sleep 3600
```

and you can see it terminating all the sleepers.  

<hr>

Explaining the `grep '[p]ython csp_build.py'` bit in a bit more detail:  

When you do `sleep 3600 &amp;` followed by `ps -ef | grep sleep`, you tend to get <em>two</em> processes with `sleep` in it, the `sleep 3600` and the `grep sleep` (because they both have `sleep` in them, that's not rocket science).  

However, `ps -ef | grep '[s]leep'` won't create a process with `sleep` in it, it instead creates `grep '[s]leep'` and here's the tricky bit: the `grep` doesn't find it because it's looking for the regular expression "any character from the character class `[s]` (which is `s`) followed by `leep`.  

In other words, it's looking for `sleep` but the grep process is `grep '[s]leep'` which doesn't have `sleep` in it.  

When I was shown this (by someone here on SO), I immediately started using it because  

<ul>
<li>it's one less process than adding `| grep -v grep`; and</li>
<li>it's elegant <em>and</em> sneaky, a rare combination :-)</li>
</ul>

#### Answer 2 (score 125)
if you have pkill,   

```sh
pkill -f csp_build.py
```

If you only want to grep against the process name (instead of the full argument list) then leave off `-f`.  

#### Answer 3 (score 82)
<h5>One liner:</h2>

<strong>`ps aux  |  grep -i csp_build  |  awk '{print $2}'  |  xargs sudo kill -9`</strong>  

<ul>
<li>Print out column 2:  `awk '{print $2}'` </li>
<li><strong>`sudo`</strong> is optional</li>
<li>Run `kill -9 5124`, `kill -9 5373` etc (kill -15 is more graceful but slightly slower)</li>
</ul>

<hr>

<h5>Bonus:</h2>

<p>I also have 2 shortcut functions defined in my .bash_profile
(~/.bash_profile is for osx, you have to see what works for your *nix machine).</p>

<ol>
<li><strong>p</strong> <em>keyword</em>

<ul>
<li>lists out all <strong>P</strong>rocesses containing keyword</li>
<li>usage e.g: `p csp_build` , `p python` etc</li>
</ul></li>
</ol>

<em>bash_profile code:</em>  

```sh
# FIND PROCESS
function p(){
        ps aux | grep -i $1 | grep -v grep
}
```

<ol start="2">
<li><strong>ka</strong> <em>keyword</em>

<ul>
<li><strong>K</strong>ills <strong>A</strong>ll processes that have this keyword</li>
<li>usage e.g: `ka csp_build` , `ka python` etc</li>
<li>optional kill level e.g: `ka csp_build 15`, `ka python 9`</li>
</ul></li>
</ol>

<em>bash_profile code:</em>  

```sh
# KILL ALL
function ka(){

    cnt=$( p $1 | wc -l)  # total count of processes found
    klevel=${2:-15}       # kill level, defaults to 15 if argument 2 is empty

    echo -e "\nSearching for '$1' -- Found" $cnt "Running Processes .. "
    p $1

    echo -e '\nTerminating' $cnt 'processes .. '

    ps aux  |  grep -i $1 |  grep -v grep   | awk '{print $2}' | xargs sudo kill -klevel
    echo -e "Done!\n"

    echo "Running search again:"
    p "$1"
    echo -e "\n"
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: How to determine the current shell I'm working on? (score [455839](https://stackoverflow.com/q/3327013) in 2013)

#### Question
How can I determine the current shell I am working on?   

Would the output of the `ps` command alone be sufficient?  

How can this be done in different flavors of UNIX?  

#### Answer accepted (score 738)
<ul>
<li><p>There are 3 approaches to finding the <strong>name</strong> of the current shell's executable:</p>

Please note that all 3 approaches can be fooled if the executable of the shell is `/bin/sh` but it's really a renamed `bash`, for example (which frequently happens).   

<em>Thus your second question of whether `ps` output will do is answered with "<strong>not always</strong>".</em>  

<ol>
<li><p>`echo $0` - will print the program name... which in the case of shell is the actual shell</p></li>
<li><p>`ps  -ef | grep $$ | grep -v grep`  - This will look for the current process ID in the list of running processes. Since the current process is shell, it will be included. </p>

This is not 100% reliable, as you might have OTHER processes whose `ps` listing includes the same number as shell's process ID, especially if that ID is a small # (e.g. if shell's PID is "5", you may find processes called "java5" or "perl5" in the same `grep` output!). <em>This is the second problem with the "ps" approach, on top of not being able to rely on the shell name.</em>  </li>
<li><p>`echo $SHELL` - The path to the current shell is stored as the `SHELL` variable for any shell. The caveat for this one is that if you launch a shell explicitly as a subprocess (e.g. it's not your login shell), you will get your login shell's value instead. If that's a possibility, use the `ps` or `$0` approach.</p></li>
</ol>

<hr></li>
<li><p>If, however, the executable doesn't match your actual shell (e.g. `/bin/sh` is actually bash or ksh), you need heuristics. Here are some environmental variables specific to various shells:</p>

<ul>
<li><p>`$version` is set on tcsh</p></li>
<li><p>`$BASH` is set on bash</p></li>
<li><p>`$shell` (lowercase) is set to actual shell name in csh or tcsh </p></li>
<li><p>`$ZSH_NAME` is set on zsh</p></li>
<li><p>ksh has `$PS3` and `$PS4` set, whereas normal Bourne shell (`sh`) only has `$PS1` and `$PS2` set. This generally seems like the hardest to distinguish - the ONLY difference in entire set of envionmental variables between `sh` and `ksh` we have installed on Solaris boxen is `$ERRNO`, `$FCEDIT`, `$LINENO`, `$PPID`, `$PS3`, `$PS4`, `$RANDOM`, `$SECONDS`, `$TMOUT`.</p></li>
</ul></li>
</ul>

#### Answer 2 (score 89)
`ps -p $$`  

should work anywhere that the solutions involving `ps -ef` and `grep` do (on any Unix variant which supports <a href="http://www.opengroup.org/onlinepubs/009695399/utilities/ps.html" rel="noreferrer">POSIX options for `ps`</a>) and will not suffer from the false positives introduced by grepping for a sequence of digits which may appear elsewhere.  

#### Answer 3 (score 38)
Try  

```sh
ps -p $$ -oargs=
```

or  

```sh
ps -p $$ -ocomm=
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: Running Bash commands in Python (score [452753](https://stackoverflow.com/q/4256107) in 2019)

#### Question
On my local machine, I run a python script which contains this line  

```sh
bashCommand = "cwm --rdf test.rdf --ntriples > test.nt"
os.system(bashCommand)
```

This works fine.  

Then I run the same code on a server and I get the following error message  

```sh
'import site' failed; use -v for traceback
Traceback (most recent call last):
File "/usr/bin/cwm", line 48, in <module>
from swap import  diag
ImportError: No module named swap
```

So what I did then is I inserted a `print bashCommand` which prints me than the command in the terminal before it runs it with `os.system()`.  

Of course, I get again the error (caused by `os.system(bashCommand)`) but before that error it prints the command in the terminal. Then I just copied that output and did a copy paste into the terminal and hit enter and it works...  

Does anyone have a clue what's going on?  

#### Answer 2 (score 276)
Don't use `os.system`. It has been deprecated in favor of <a href="http://docs.python.org/library/subprocess.html" rel="noreferrer">subprocess</a>. From the <a href="https://docs.python.org/3/library/subprocess.html" rel="noreferrer">docs</a>: "This module intends to replace several older modules and functions: `os.system`, `os.spawn`".  

Like in your case:  

```sh
bashCommand = "cwm --rdf test.rdf --ntriples > test.nt"
import subprocess
process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
output, error = process.communicate()
```

#### Answer 3 (score 101)
To somewhat expand on the earlier answers here, there are a number of details which are commonly overlooked.  

<ul>
<li>Prefer `subprocess.run()` over `subprocess.check_call()` and friends over `subprocess.call()` over `subprocess.Popen()` over `os.system()` over `os.popen()`</li>
<li>Understand and probably use `text=True`, aka `universal_newlines=True`.</li>
<li>Understand the meaning of `shell=True` or `shell=False` and how it changes quoting and the availability of shell conveniences.</li>
<li>Understand differences between `sh` and Bash</li>
<li>Understand how a subprocess is separate from its parent, and generally cannot change the parent.</li>
<li>Avoid running the Python interpreter as a subprocess of Python.</li>
</ul>

These topics are covered in some more detail below.  

<h5>Prefer `subprocess.run()` or `subprocess.check_call()`</h1>

The `subprocess.Popen()` function is a low-level workhorse but it is tricky to use correctly and you end up copy/pasting multiple lines of code ... which conveniently already exist in the standard library as a set of higher-level wrapper functions for various purposes, which are presented in more detail in the following.  

Here's a paragraph from the <a href="https://docs.python.org/3/library/subprocess.html#using-the-subprocess-module" rel="noreferrer">documentation</a>:  

<blockquote>
  The recommended approach to invoking subprocesses is to use the `run()` function for all use cases it can handle. For more advanced use cases, the underlying `Popen` interface can be used directly.  
</blockquote>

Unfortunately, the availability of these wrapper functions differs between Python versions.  

<ul>
<li>`subprocess.run()` was officially introduced in Python 3.5. It is meant to replace all of the following.</li>
<li>`subprocess.check_output()` was introduced in Python 2.7 / 3.1. It is basically equivalent to `subprocess.run(..., check=True, stdout=subprocess.PIPE).stdout`</li>
<li>`subprocess.check_call()` was introduced in Python 2.5.  It is basically equivalent to `subprocess.run(..., check=True)`</li>
<li>`subprocess.call()` was introduced in Python 2.4 in the original `subprocess` module (<a href="https://www.python.org/dev/peps/pep-0324/" rel="noreferrer">PEP-324</a>). It is basically equivalent to `subprocess.run(...).returncode`</li>
</ul>

<h5>High-level API vs `subprocess.Popen()`</h3>

The refactored and extended `subprocess.run()` is more logical and more versatile than the older legacy functions it replaces.  It returns a <a href="https://docs.python.org/3/library/subprocess.html#subprocess.CompletedProcess" rel="noreferrer">`CompletedProcess`</a> object which has various methods which allow you to retrieve the exit status, the standard output, and a few other results and status indicators from the finished subprocess.  

`subprocess.run()` is the way to go if you simply need a program to run and return control to Python. For more involved scenarios (background processes, perhaps with interactive I/O with the Python parent program) you still need to use `subprocess.Popen()` and take care of all the plumbing yourself. This requires a fairly intricate understanding of all the moving parts and should not be undertaken lightly.  The simpler <a href="https://docs.python.org/3/library/subprocess.html#subprocess.Popen" rel="noreferrer">`Popen` object</a> represents the (possibly still-running) process which needs to be managed from your code for the remainder of the lifetime of the subprocess.  

It should perhaps be emphasized that just `subprocess.Popen()` merely creates a process. If you leave it at that, you have a subprocess running concurrently alongside with Python, so a "background" process. If it doesn't need to do input or output or otherwise coordinate with you, it can do useful work in parallel with your Python program.  

<h5>Avoid `os.system()` and `os.popen()`</h3>

Since time eternal (well, since Python 2.5) the <a href="https://docs.python.org/release/2.5.2/lib/os-process.html" rel="noreferrer">`os` module documentation</a> has contained the recommendation to prefer `subprocess` over `os.system()`:  

<blockquote>
  The `subprocess` module provides more powerful facilities for spawning new processes and retrieving their results; using that module is preferable to using this function.  
</blockquote>

The problems with `system()` are that it's obviously system-dependent and doesn't offer ways to interact with the subprocess. It simply runs, with standard output and standard error outside of Python's reach. The only information Python receives back is the exit status of the command (zero means success, though the meaning of non-zero values is also somewhat system-dependent).  

<a href="https://www.python.org/dev/peps/pep-0324/" rel="noreferrer">PEP-324</a> (which was already mentioned above) contains a more detailed rationale for why `os.system` is problematic and how `subprocess` attempts to solve those issues.  

`os.popen()` used to be even more <a href="https://docs.python.org/2/library/os.html#os.popen" rel="noreferrer">strongly discouraged</a>:  

<blockquote>
  <em>Deprecated since version 2.6:</em> This function is obsolete. Use the `subprocess` module.  
</blockquote>

However, since sometime in Python 3, it has been reimplemented to simply use `subprocess`, and redirects to the `subprocess.Popen()` documentation for details.  

<h5>Understand and usually use `check=True`</h3>

You'll also notice that `subprocess.call()` has many of the same limitations as `os.system()`. In regular use, you should generally check whether the process finished successfully, which `subprocess.check_call()` and `subprocess.check_output()` do (where the latter also returns the standard output of the finished subprocess). Similarly, you should usually use `check=True` with `subprocess.run()` unless you specifically need to allow the subprocess to return an error status.  

In practice, with `check=True` or `subprocess.check_*`, Python will throw a <a href="https://docs.python.org/3/library/subprocess.html#subprocess.CalledProcessError" rel="noreferrer">`CalledProcessError` exception</a> if the subprocess returns a nonzero exit status.  

A common error with `subprocess.run()` is to omit `check=True` and be surprised when downstream code fails if the subprocess failed.  

On the other hand, a common problem with `check_call()` and `check_output()` was that users who blindly used these functions were surprised when the exception was raised e.g. when `grep` did not find a match. (You should probably replace `grep` with native Python code anyway, as outlined below.)  

All things counted, you need to understand how shell commands return an exit code, and under what conditions they will return a non-zero (error) exit code, and make a conscious decision how exactly it should be handled.  

<h5>Understand and probably use `text=True` aka `universal_newlines=True`</h1>

Since Python 3, strings internal to Python are Unicode strings. But there is no guarantee that a subprocess generates Unicode output, or strings at all.  

(If the differences are not immediately obvious, Ned Batchelder's <a href="https://nedbatchelder.com/text/unipain.html" rel="noreferrer">Pragmatic Unicode</a> is recommended, if not outright obligatory, reading. There is a 36-minute video presentation behind the link if you prefer, though reading the page yourself will probably take significantly less time.)  

Deep down, Python has to fetch a `bytes` buffer and interpret it somehow. If it contains a blob of binary data, it <em>shouldn't</em> be decoded into a Unicode string, because that's error-prone and bug-inducing behavior - precisely the sort of pesky behavior which riddled many Python 2 scripts, before there was a way to properly distinguish between encoded text and binary data.  

With `text=True`, you tell Python that you, in fact, expect back textual data in the system's default encoding, and that it should be decoded into a Python (Unicode) string to the best of Python's ability (usually UTF-8 on any moderately up to date system, except perhaps Windows?)  

If that's <em>not</em> what you request back, Python will just give you `bytes` strings in the `stdout` and `stderr` strings. Maybe at some later point you <em>do</em> know that they were text strings after all, and you know their encoding. Then, you can decode them.  

```sh
normal = subprocess.run([external, arg],
    stdout=subprocess.PIPE, stderr=subprocess.PIPE,
    check=True,
    text=True)
print(normal.stdout)

convoluted = subprocess.run([external, arg],
    stdout=subprocess.PIPE, stderr=subprocess.PIPE,
    check=True)
# You have to know (or guess) the encoding
print(convoluted.stdout.decode('utf-8'))
```

Python 3.7 introduced the shorter and more descriptive and understandable alias `text` for the keyword argument which was previously somewhat misleadingly called `universal_newlines`.  

<h5>Understand `shell=True` vs `shell=False`</h1>

With `shell=True` you pass a single string to your shell, and the shell takes it from there.  

With `shell=False` you pass a list of arguments to the OS, bypassing the shell.  

When you don't have a shell, you save a process and get rid of a <a href="/questions/3172470/actual-meaning-of-shell-true-in-subprocess">fairly substantial amount of hidden complexity, which may or may not harbor bugs or even security problems.</a>  

On the other hand, when you don't have a shell, you don't have redirection, wildcard expansion, job control, and a large number of other shell features.  

A common mistake is to use `shell=True` and then still pass Python a list of tokens, or vice versa. This happens to work in some cases, but is really ill-defined and could break in interesting ways.  

```sh
# XXX AVOID THIS BUG
buggy = subprocess.run('dig +short stackoverflow.com')

# XXX AVOID THIS BUG TOO
broken = subprocess.run(['dig', '+short', 'stackoverflow.com'],
    shell=True)

# XXX DEFINITELY AVOID THIS
pathological = subprocess.run(['dig +short stackoverflow.com'],
    shell=True)

correct = subprocess.run(['dig', '+short', 'stackoverflow.com'],
    # Probably don't forget these, too
    check=True, text=True)

# XXX Probably better avoid shell=True
# but this is nominally correct
fixed_but_fugly = subprocess.run('dig +short stackoverflow.com',
    shell=True,
    # Probably don't forget these, too
    check=True, text=True)
```

The common retort "but it works for me" is not a useful rebuttal unless you understand exactly under what circumstances it could stop working.  

<h5>Refactoring Example</h3>

Very often, the features of the shell can be replaced with native Python code.  Simple Awk or `sed` scripts should probably simply be translated to Python instead.  

To partially illustrate this, here is a typical but slightly silly example which involves many shell features.  

```sh
cmd = '''while read -r x;
   do ping -c 3 "$x" | grep 'round-trip min/avg/max'
   done <hosts.txt'''

# Trivial but horrible
results = subprocess.run(
    cmd, shell=True, universal_newlines=True, check=True)
print(results.stdout)

# Reimplement with shell=False
with open('hosts.txt') as hosts:
    for host in hosts:
        host = host.rstrip('\n')  # drop newline
        ping = subprocess.run(
             ['ping', '-c', '3', host],
             text=True,
             stdout=subprocess.PIPE,
             check=True)
        for line in ping.stdout.split('\n'):
             if 'round-trip min/avg/max' in line:
                 print('{}: {}'.format(host, line))
```

Some things to note here:  

<ul>
<li>With `shell=False` you don't need the quoting that the shell requires around strings. Putting quotes anyway is probably an error.</li>
<li>It often makes sense to run as little code as possible in a subprocess. This gives you more control over execution from within your Python code.</li>
<li>Having said that, complex shell pipelines are tedious and sometimes challenging to reimplement in Python.</li>
</ul>

The refactored code also illustrates just how much the shell really does for you with a very terse syntax -- for better or for worse. Python says <em>explicit is better than implicit</em> but the Python code <em>is</em> rather verbose and arguably looks more complex than this really is. On the other hand, it offers a number of points where you can grab control in the middle of something else, as trivially exemplified by the enhancement that we can easily include the host name along with the shell command output. (This is by no means challenging to do in the shell, either, but at the expense of yet another diversion and perhaps another process.)  

<h5>Common Shell Constructs</h3>

For completeness, here are brief explanations of some of these shell features, and some notes on how they can perhaps be replaced with native Python facilities.  

<ul>
<li>Globbing aka wildcard expansion can be replaced with `glob.glob()` or very often with simple Python string comparisons like `for file in os.listdir('.'): if not file.endswith('.png'): continue`.  Bash has various other expansion facilities like `.{png,jpg}` brace expansion and `{1..100}` as well as tilde expansion (`~` expands to your home directory, and more generally `~account` to the home directory of another user)</li>
<li>Shell variables like `$SHELL` or `$my_exported_var` can sometimes simply be replaced with Python variables. Exported shell variables are available as e.g. `os.environ['SHELL']` (the meaning of `export` is to make the variable available to subprocesses -- a variable which is not available to subprocesses will obviously not be available to Python running as a subprocess of the shell, or vice versa. The `env=` keyword argument to `subprocess` methods allows you to define the environment of the subprocess as a dictionary, so that's one way to make a Python variable visible to a subprocess). With `shell=False` you will need to understand how to remove any quotes; for example, `cd "$HOME"` is equivalent to `os.chdir(os.environ['HOME'])` without quotes around the directory name. (Very often `cd` is not useful or necessary anyway, and many beginners omit the double quotes around the variable and get away with it <a href="/questions/10067266/when-to-wrap-quotes-around-a-shell-variable">until one day ...</a>)</li>
<li>Redirection allows you to read from a file as your standard input, and write your standard output to a file. `grep 'foo' &lt;inputfile &gt;outputfile` opens `outputfile` for writing and `inputfile` for reading, and passes its contents as standard input to `grep`, whose standard output then lands in `outputfile`. This is not generally hard to replace with native Python code.</li>
<li>Pipelines are a form of redirection. `echo foo | nl` runs two subprocesses, where the standard output of `echo` is the standard input of `nl` (on the OS level, in Unix-like systems, this is a single file handle). If you cannot replace one or both ends of the pipeline with native Python code, perhaps think about using a shell after all, especially if the pipeline has more than two or three processes  (though look at the <a href="https://docs.python.org/3.7/library/pipes.html" rel="noreferrer">`pipes` module in the Python standard library</a> or a number of more modern and versatile third-party competitors).</li>
<li>Job control lets you interrupt jobs, run them in the background, return them to the foreground, etc.  The basic Unix signals to stop and continue a process are of course available from Python, too. But jobs are a higher-level abstraction in the shell which involve process groups etc which you have to understand if you want to do something like this from Python.</li>
</ul>

<h5>Understand differences between `sh` and Bash</h1>

`subprocess` runs your shell commands with `/bin/sh` unless you specifically request otherwise (except of course on Windows, where it uses the value of the `COMSPEC` variable). This means that <a href="/a/42666651/874188">various Bash-only features like arrays, `[[` etc</a> are not available.  

<p>If you need to use Bash-only syntax, you can 
pass in the path to the shell as `executable='/bin/bash'` (where of course if your Bash is installed somewhere else, you need to adjust the path).</p>

```sh
subprocess.run('''
    # This for loop syntax is Bash only
    for((i=1;i<=$#;i++)); do
        # Arrays are Bash-only
        array[i]+=123
    done''',
    shell=True, check=True,
    executable='/bin/bash')
```

<h5>A `subprocess` is separate from its parent, and cannot change it</h1>

A somewhat common mistake is doing something like  

```sh
subprocess.run('foo=bar', shell=True)
subprocess.run('echo "$foo"', shell=True)  # Doesn't work
```

which aside from the lack of elegance also betrays a fundamental lack of understanding of the "sub" part of the name "subprocess".  

A child process runs completely separate from Python, and when it finishes, Python has no idea what it did (apart from the vague indicators that it can infer from the exit status and output from the child process).  A child generally cannot change the parent's environment; it cannot set a variable, change the working directory, or, in so many words, communicate with its parent without cooperation from the parent.  

The immediate fix in this particular case is to run both commands in a single subprocess;  

```sh
subprocess.run('foo=bar; echo "$foo"', shell=True)
```

though obviously this particular use case doesn't require the shell at all.  Remember, you can manipulate the environment of the current process (and thus also its children) via  

```sh
os.environ['foo'] = 'bar'
```

or pass an environment setting to a child process with  

```sh
subprocess.run('echo "$foo"', shell=True, env={'foo': 'bar'})
```

(not to mention the obvious refactoring `subprocess.run(['echo', 'bar'])`; but `echo` is a poor example of something to run in a subprocess in the first place, of course).  

<h5>Don't run Python from Python</h1>

This is slightly dubious advice; there are certainly situations where it does make sense or is even an absolute requirement to run the Python interpreter as a subprocess from a Python script. But very frequently, the correct approach is simply to `import` the other Python module into your calling script and call its functions directly.  

If the other Python script is under your control, and it isn't a module, consider <a href="/questions/15746675/how-to-write-a-python-module-package">turning it into one</a>.  (This answer is too long already so I will not delve into details here.)  

If you need parallelism, you can run Python functions in subprocesses with the <a href="https://docs.python.org/3/library/multiprocessing.html?highlight=multiprocessing" rel="noreferrer">`multiprocessing` module.</a>  There is also <a href="https://docs.python.org/3/library/threading.html#module-threading" rel="noreferrer">`threading`</a> which runs multiple tasks in a single process (which is more lightweight and gives you more control, but also more constrained in that threads within a process are tightly coupled, and bound to a single <a href="https://docs.python.org/3/glossary.html#term-global-interpreter-lock" rel="noreferrer">GIL</a>.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: Pipe to/from the clipboard in Bash script (score [452594](https://stackoverflow.com/q/749544) in 2018)

#### Question
Is it possible to pipe to/from the clipboard in Bash?  

Whether it is piping to/from a device handle or using an auxiliary application, I can't find anything.  

For example, if `/dev/clip` was a device linking to the clipboard we could do:  

```sh
cat /dev/clip        # Dump the contents of the clipboard
cat foo > /dev/clip  # Dump the contents of "foo" into the clipboard
```

#### Answer accepted (score 793)
There's a wealth of clipboards you could be dealing with.  I expect you're probably a Linux user who wants to put stuff in the X Windows primary clipboard.  Usually, the clipboard you want to talk to has a utility that lets you talk to it.  

In the case of X, there's `xclip` (and others). `xclip -selection c` will send data to the clipboard that works with <kbd>Ctrl + C</kbd>, <kbd>Ctrl + V</kbd> in most applications.  

If you're on Mac OS X, there's `pbcopy`.  

If you're in Linux terminal mode (no X) then look into `gpm` or <a href="http://www.gnu.org/software/screen/" rel="noreferrer">screen</a> which has a clipboard.  Try the `screen` command `readreg`.  

Under Windows 10+ or cygwin, use `/dev/clipboard` or `clip`.  

#### Answer 2 (score 257)
<p>Make sure you are using alias `xclip="xclip -selection c"`
otherwise you can't just use to <kbd>Ctrl</kbd>+<kbd>v</kbd> to paste it back in a different place.</p>

```sh
echo test | xclip    
```

<kbd>Ctrl</kbd>+<kbd>v</kbd> `=== test`  

#### Answer 3 (score 165)
<h5>Install</h1>

```sh
# You can install xclip using `apt-get`
apt-get install xclip

# or `pacman`
pacman -S xclip

# or `dnf`
dnf install xclip
```

If you do not have access to `apt-get` nor `pacman`, nor `dnf`, the sources are available on <a href="http://sourceforge.net/projects/xclip/" rel="noreferrer">sourceforge</a>.  

<h5>Set-up</h1>

<h5>Bash</h2>

In `~/.bash_aliases`, add:  

```sh
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"
```

<em>Do not forget to load your new configuration using `. ~/.bash_aliases` or by restarting your profile.</em>  

<h5>Fish</h2>

In `~/.config/fish/config.fish`, add:  

```sh
abbr setclip "xclip -selection c"
abbr getclip "xclip -selection c -o"
```

<em>Do not forget to restart your fish instance by restarting your terminal for changes to apply.</em>  

<h5>Usage</h1>

You can now use `setclip` and `getclip`, e.g:  

```sh
$ echo foo | setclip
$ getclip
foo
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: How do I use shell variables in an awk script? (score [452441](https://stackoverflow.com/q/19075671) in 2018)

#### Question
I found some ways to pass external shell variables to an `awk` script, but I'm confused about `'` and `"`.  

First, I tried with a shell script:  

```sh
$ v=123test
$ echo $v
123test
$ echo "$v"
123test
```

Then tried awk:  

```sh
$ awk 'BEGIN{print "'$v'"}'
$ 123test
$ awk 'BEGIN{print '"$v"'}'
$ 123
```

Why is the difference?  

Lastly I tried this:  

```sh
$ awk 'BEGIN{print " '$v' "}'
$  123test
$ awk 'BEGIN{print ' "$v" '}'
awk: cmd. line:1: BEGIN{print
awk: cmd. line:1:             ^ unexpected newline or end of string 
```

I'm confused about this.  

#### Answer accepted (score 437)
<blockquote>
  <h5>Getting shell variables into `awk`</h1>
  
  may be done in several ways. Some are better than others. This should cover most of them.  If you have a comment, please leave below.  
</blockquote>

<hr>

<h5>Using `-v`  (The best way, most portable)</h2>

Use the `-v` option: (P.S. use a space after `-v` or it will be less portable. E.g., `awk -v var=` not `awk -vvar=`)  

```sh
variable="line one\nline two"
awk -v var="$variable" 'BEGIN {print var}'
line one
line two
```

This should be compatible with most `awk`, and the variable is available in the `BEGIN` block as well:  

If you have multiple variables:  

```sh
awk -v a="$var1" -v b="$var2" 'BEGIN {print a,b}'
```

<strong>Warning</strong>.  As Ed Morton writes, escape sequences will be interpreted so `\t` becomes a real `tab` and not `\t` if that is what you search for. Can be solved by using `ENVIRON[]` or access it via `ARGV[]`  

<strong>PS</strong> If you like three vertical bar as separator `|||`, it can't be escaped, so use `-F"[|][|][|]"`  

<blockquote>
  Example on getting data from a program/function inn to `awk` (here date is used)  
</blockquote>

```sh
awk -v time="$(date +"%F %H:%M" -d '-1 minute')" 'BEGIN {print time}'
```

<hr>

<h5>Variable after code block</h2>

Here we get the variable after the `awk` code. This will work fine as long as you do not need the variable in the `BEGIN` block:  

```sh
variable="line one\nline two"
echo "input data" | awk '{print var}' var="${variable}"
or
awk '{print var}' var="${variable}" file
```

<p>This also works with multiple variables
`awk '{print a,b,$0}' a="$var1" b="$var2" file`</p>

Using variable this way does not work in `BEGIN` block:  

```sh
echo "input data" | awk 'BEGIN {print var}' var="${variable}"
```

<hr>

<h5>Here-string</h2>

Variable can also be added to `awk` using a <a href="http://en.wikipedia.org/wiki/Here_document" rel="noreferrer">here-string</a> from shells that support them (including Bash):  

```sh
awk '{print $0}' <<< "$variable"
test
```

This is the same as:  

```sh
printf '%s' "$variable" | awk '{print $0}'
```

P.S. this treats the variable as a file input.  

<hr>

<h5>`ENVIRON` input</h2>

<p>As TrueY writes, you can use the `ENVIRON` to print <strong>Environment Variables</strong>.
Setting a variable before running AWK, you can print it out like this:</p>

```sh
X=MyVar
awk 'BEGIN{print ENVIRON["X"],ENVIRON["SHELL"]}'
MyVar /bin/bash
```

<hr>

<h5>`ARGV` input</h2>

As Steven Penny writes, you can use `ARGV` to get the data into awk:  

```sh
v="my data"
awk 'BEGIN {print ARGV[1]}' "$v"
my data
```

To get the data into the code itself, not just the BEGIN:  

```sh
v="my data"
echo "test" | awk 'BEGIN{var=ARGV[1];ARGV[1]=""} {print var, $0}' "$v"
my data test
```

<hr>

<h5>Variable within the code: USE WITH CAUTION</h2>

You can use a variable within the `awk` code, but it's messy and hard to read, and as `Charles Duffy` points out, this version may also be a victim of code injection.  If someone adds bad stuff to the variable, it will be executed as part of the `awk` code.  

This works by extracting the variable within the code, so it becomes a part of it.  

If you want to make an `awk` that changes dynamically with use of variables, you can do it this way, but DO NOT use it for normal variables.  

```sh
variable="line one\nline two"
awk 'BEGIN {print "'"$variable"'"}'
line one
line two
```

Here is an example of code injection:  

```sh
variable='line one\nline two" ; for (i=1;i<=1000;++i) print i"'
awk 'BEGIN {print "'"$variable"'"}'
line one
line two
1
2
3
.
.
1000
```

You can add lots of commands to `awk` this way.  Even make it crash with non valid commands.  

<hr>

<h5>Extra info:</h2>

<h5>Use of double quote</h3>

<p>It's always good to double quote variable `"$variable"`<br>
If not, multiple lines will be added as a long single line.</p>

Example:  

```sh
var="Line one
This is line two"

echo $var
Line one This is line two

echo "$var"
Line one
This is line two
```

Other errors you can get without double quote:  

```sh
variable="line one\nline two"
awk -v var=$variable 'BEGIN {print var}'
awk: cmd. line:1: one\nline
awk: cmd. line:1:    ^ backslash not last character on line
awk: cmd. line:1: one\nline
awk: cmd. line:1:    ^ syntax error
```

And with single quote, it does not expand the value of the variable:  

```sh
awk -v var='$variable' 'BEGIN {print var}'
$variable
```

<h5>More info about AWK and variables</h3>

<a href="http://cfajohnson.com/shell/cus-faq-2.html#Q24" rel="noreferrer">Read this faq</a>.  

#### Answer 2 (score 26)
It seems that the good-old `ENVIRON` <a href="/questions/tagged/awk" class="post-tag" title="show questions tagged &#39;awk&#39;" rel="tag">awk</a> built-in hash is not mentioned at all. An example of its usage:  

```sh
$ X=Solaris awk 'BEGIN{print ENVIRON["X"], ENVIRON["TERM"]}'
Solaris rxvt
```

#### Answer 3 (score 9)
Use either of these depending how you want backslashes in the shell variables handled (`avar` is an awk variable, `svar` is a shell variable):  

```sh
awk -v avar="$svar" '... avar ...' file
awk 'BEGIN{avar=ARGV[1];ARGV[1]=""}... avar ...' "$svar" file
```

See <a href="http://cfajohnson.com/shell/cus-faq-2.html#Q24">http://cfajohnson.com/shell/cus-faq-2.html#Q24</a> for details and other options. The first method above is almost always your best option and has the most obvious semantics.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: How to make "if not true condition"? (score [449960](https://stackoverflow.com/q/10552711) in 2018)

#### Question
I would like to have the `echo` command executed when `cat /etc/passwd | grep "sysa"` is not true.  

What am I doing wrong?  

```sh
if ! [ $(cat /etc/passwd | grep "sysa") ]; then
        echo "ERROR - The user sysa could not be looked up"
        exit 2
fi
```

#### Answer accepted (score 411)
try  

```sh
if ! grep -q sysa /etc/passwd ; then
```

`grep` returns `true` if it finds the search target, and `false` if it doesn't.  

So NOT `false` == `true`.  

`if` evaluation in shells are designed to be very flexible, and many times doesn't require chains of commands (as you have written).   

Also, looking at your code as is, your use of the `$( ... )` form of cmd-substitution is to be commended, but think about what is coming out of the process. Try `echo $(cat /etc/passwd | grep "sysa")` to see what I mean. You can take that further by using the `-c` (count) option to grep and then do `if ! [ $(grep -c "sysa" /etc/passwd) -eq 0 ] ; then` which works but is rather old school.  

BUT, you could use the newest shell features (arithmetic evaluation) like  

```sh
if ! (( $(grep -c "sysa" /etc/passwd) == 0 )) ; then ...`
```

which also gives you the benefit of using the c-lang based comparison operators, `==,&lt;,&gt;,&gt;=,&lt;=,%` and maybe a few others.  

In this case, per a comment by  Orwellophile, the arithmetic evaluation can be pared down even further, like  

```sh
if ! (( $(grep -c "sysa" /etc/passwd) )) ; then ....
```

OR  

```sh
if (( ! $(grep -c "sysa" /etc/passwd) )) ; then ....
```

Finally, there is an <em>award</em> called the `Useless Use of Cat (UUOC)`. :-) Some people will jump up and down and cry gothca! I'll just say that `grep` can take a file name on its cmd-line, so why invoke extra processes and pipe constructions when you don't have to? ;-)   

I hope this helps.  

#### Answer 2 (score 30)
I think it can be simplified into:  

```sh
grep sysa /etc/passwd || {
    echo "ERROR - The user sysa could not be looked up"
    exit 2
}
```

or in a single command line  

`$ grep sysa /etc/passwd || { echo "ERROR - The user sysa could not be looked up"; exit 2; }`  

#### Answer 3 (score 6)
<blockquote>
  What am I doing wrong?  
</blockquote>

`$(...)` holds the <strong>value</strong>, not the exit status, that is why this approach is wrong. However, in this specific case, it does indeed work because `sysa` will be printed which makes the test statement come true. However, `if ! [ $(true) ]; then echo false; fi` would always print `false` because the `true` command does not write anything to stdout (even though the exit code is 0). That is why it needs to be rephrased to `if ! grep ...; then`.  

An alternative would be `cat /etc/passwd | grep "sysa" || echo error`. Edit: As Alex pointed out, <a href="https://stackoverflow.com/questions/11710552/useless-use-of-cat">cat is useless here</a>: `grep "sysa" /etc/passwd || echo error`.  

Found the other answers rather confusing, hope this helps someone.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: What's the difference between .bashrc, .bash_profile, and .environment? (score [448999](https://stackoverflow.com/q/415403) in )

#### Question
I've used a number of different *nix-based systems of the years, and it seems like every flavor of Bash I use has a different algorithm for deciding which startup scripts to run.  For the purposes of tasks like setting up environment variables and aliases and printing startup messages (e.g. MOTDs), which startup script is the appropriate place to do these?  

What's the difference between putting things in `.bashrc`, `.bash_profile`, and `.environment`?  I've also seen other files such as `.login`, `.bash_login`, and `.profile`; are these ever relevant?  What are the differences in which ones get run when logging in physically, logging in remotely via ssh, and opening a new terminal window?  Are there any significant differences across platforms (including Mac OS X (and its Terminal.app) and Cygwin Bash)?  

#### Answer accepted (score 73)
The main difference with shell config files is that some are only read by "login" shells (eg. when you login from another host, or login at the text console of a local unix machine). these are the ones called, say, `.login` or `.profile` or `.zlogin` (depending on which shell you're using).  

Then you have config files that are read by "interactive" shells (as in, ones connected to a terminal (or pseudo-terminal in the case of, say, a terminal emulator running under a windowing system). these are the ones with names like `.bashrc`, `.tcshrc`, `.zshrc`, etc.  

`bash` complicates this in that `.bashrc` is <strong>only read by a shell that's both <em>interactive</em> and <em>non-login</em></strong>, so you'll find most people end up telling their `.bash_profile` to also read `.bashrc` with something like  

`[[ -r ~/.bashrc ]] &amp;&amp; . ~/.bashrc`  

Other shells behave differently - eg with `zsh`, `.zshrc` is always read for an interactive shell, whether it's a login one or not.  

The manual page for bash explains the circumstances under which each file is read. Yes, behaviour is generally consistent between machines.  

`.profile` is simply the login script filename originally used by `/bin/sh`. `bash`, being generally backwards-compatible with `/bin/sh`, will read `.profile` if one exists.  

#### Answer 2 (score 48)
That's simple. It's explained in `man bash`:  

```sh
/bin/bash
       The bash executable
/etc/profile
       The systemwide initialization file, executed for login shells
~/.bash_profile
       The personal initialization file, executed for login shells
~/.bashrc
       The individual per-interactive-shell startup file
~/.bash_logout
       The individual login shell cleanup file, executed when a login shell exits
~/.inputrc
       Individual readline initialization file
```

Login shells are the ones that are read one you login (so, they are not executed when merely starting up xterm, for example). There are other ways to login. For example using an X display manager. Those have other ways to read and export environment variables at login time.  

Also read the `INVOCATION` chapter in the manual. It says <em>"The  following  paragraphs  describe  how  bash  executes its startup files."</em>, i think that's a spot-on :) It explains what an "interactive" shell is too.  

Bash does not know about `.environment`. I suspect that's a file of your distribution, to set environment variables independent of the shell that you drive.   

#### Answer 3 (score 9)
Classically, `~/.profile` is used by Bourne Shell, and is probably supported by Bash as a legacy measure.  Again, `~/.login` and `~/.cshrc` were used by C Shell - I'm not sure that Bash uses them at all.  

The `~/.bash_profile` would be used once, at login.  The `~/.bashrc` script is read every time a shell is started.  This is analogous to `/.cshrc` for C Shell.  

One consequence is that stuff in `~/.bashrc` should be as lightweight (minimal) as possible to reduce the overhead when starting a non-login shell.  

I believe the `~/.environment` file is a compatibility file for Korn Shell.  
</section>

