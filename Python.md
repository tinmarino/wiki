
* [Keywords](Py-Keywords)

*   Use stdout and restore
    sys.stdout = openb("tmp", "w")
    sys.stdout = sys.__stdout__

*   Hexadeciaml outputs
    get_ipython().display_formatter.formatters['text/plain'].for_type([[int,]] lambda n, p, cycle : p.text("0x%x" %n))
    
*   With Statement : 2 one the same line
    with open('a', 'w') as a, open ('b', 'w') as b :
        do_stuff()
        


==============================================================================
STATEMENTS                                               *c-python-statement*

If-Statement ~
if expression:
  statements
elif expression:
  statements
else:
  statements

While-Loop ~
while expression:
  statements

For-Loop ~
for var in collection:
  statements

Counting-For-Loop ~
for i in range(start, end [, step]):
  statements
    -> (start is included; end is not)
    
with context_manager_classs as cr ~
a Context Manager class must have `__enter__` and `__exit__` methods


FUNCTION DEFINITIONS                                       *c-python-function*
def name(arg1, arg2, ...):
  statements
  return expr
ret = name(arg1, arg2)

EXCEPTION                                                 *c-python-exception*
try:
  statements
except [exception type [as var]]:
  statements
finally:
  statements


==============================================================================
TYPES                                                         *c-python-types*

Integer             -256, 15
Float               253.23, 1.253e-10
String              "Hello", 'Goodbye', """Multiline"""
Boolean             True, False
List                [ value, ... ]
Tuple               ( value, ... )       
    -> Parentheses usually optional
Dictionary          { key: value, ... }
Set                 { value:, value, ... }
    -> Create an empty set with set()


==============================================================================
OPERATORS                                                 *c-python-operators*

Arithmetic Operators ~
x + y               Add 
x - y               Subtract
x * y               Multiply
x / y               Divide 
x \% y              Modulus 
x ** y              Exponent
Assignment shortcuts: x op= y
Example: x += 1 increments x

Comparison Operators ~
x < y               Less
x <= y              Less or eq
x > y               Greater
x >= y              Greater or eq
x == y              Equal
x != y              Not equal

Boolean Operators ~
not x  
x and y 
x or y


==============================================================================
MISC                                                           *c-python-misc*

Conversion Functions ~
int(expr)           Converts expr to integer
float(expr)         Converts expr to float
str(expr)           Converts expr to string
chr(num)            ASCII char num

String / List / Tuple Operations ~
len(s)              Length of s
s[i]                Ith item in s (0-based)
s[start : end]      Slice of s from start (included) to end (excluded)
x in s              true if x is contained in s
x not in s          true if x is not contained in s
s + t               The concatenation of s with t
s * n               n copies of s concatenated
sorted(s)           A sorted copy of s
s.index(item)       Position in s of item

More String Operations ~
s.lower()           Lowercase copy of s
s.replace(old, new) Copy of s with old replaced with new
s.split( delim )    List of substrings delimited by delim
s.strip()           Copy of s with whitespace trimmed
s.upper()           Uppercase copy of s
    -> See also http://docs.python.org/library/stdtypes.html\#string-methgds


Mutating List Operations ~
del lst[i]          Deletes ith item from lst
lst.append(e)       Appends e to lst
lst.insert(i, e)    Inserts e before ith item in lst
lst.sort()          Sorts lst
    -> See also http://docs.python.org/library/stdtypes.html\#typesseq-mutable

Dictionary Operations ~
len(d)              Number of items in d
del d[key]          Removes key from d
key in d            True if d contains key
d.keys()            Returns a list of keys in d
    -> See also http://docs.python.org/library/stdtypes.html\#mapping-types-dict


Environment ~
sys.argv            List of command line arguments (argv[0] is executable)
os.environ          Dictionary of environment variables
os.curdir           String with path of current directory
    -> import sys; print(sys.argv)
    -> or
    -> from sys import argv; print(argv)}

String Formatting ~
 "Hello, {0} {1}".format("abe", "jones")
    -> Hello, abe jones
 "Hello, {fn} {ln}".format(fn="abe", ln="jones")
    -> Hello, abe jones
 "You owe me ${0:,.2f}".format(253422.3)
    -> You owe me $253,422.30
 now = datetime.now()
 '\{:\%Y-\%m-\%d \%H:\%M:\%S\}'.format(now)
    -> 2012-05-16 15:04:33
    -> See http://docs.python.org/library/string.html\#format-specification-mini-language

Useful Functions ~
exit( num )         Terminate program with exit num
raw_input("prompt") Print prompt and readline() from stdin
    -> Use input("prompt") in Python 3




==============================================================================
SYS                                                             *c-python-sys*

Python sys Variables ~
argv                Command line args
builtin_module_names    Linked C modules
byteorder           Native byte order
check_interval      Signal check frequency
exec_prefix         Root directory
executable          Name of executable
exitfunc            Exit function name
modules             Loaded modules
path                Search path
platform            Current platform
stdin, stdout, stderr   File objects for I/O
version_info        Python version info
winver              Version number

Python sys.argv ~
    -> sys.argv for the command:
    -> python foo.py bar -c qux --h
sys.argv[0]         foo.py
sys.argv[1]         bar
sys.argv[2]         -c
sys.argv[3]         qux
sys.argv[4]         --h


==============================================================================
OS                                                               *c-python-os*

altsep              Alternative sep
curdir              Current dir string
defpath             Default search path
devnull             Path of null device
extsep              Extension separator
linesep             Line separator
name                Name of OS
pardir              Parent dir string
pathsep             Patch separator
sep                 Path separator
    -> Registered OS names: "posix", "nt", "mac", "os2", "ce", "java", "riscos"


==============================================================================
CLASS                                                         *c-python-class*

Python Class Special Methods ~
__new__(cls) 
__init__(self, args) 
__del__(self) 
__repr__(self) 
__str__(self) 
__cmp__(self, other) 
__index__(self) 
__hash__(self)
__getattr__(self, name)
__getattribute__(self}, name)
__setattr__(self, name, attr)
__delattr__(self, name)
__call__(self, args, kwargs)
__lt__(self, other)
__le__(self, other)
__gt__(self, other)
__ge__(self, other)
__eq__(self, other)
__ne__(self, other)
__nonzero__(self)

Python List Methods ~
append(item) 
count(item) 
extend(list) 
index(item) 
insert(position, item)
remove(item)
pop(position)
reverse()
sort()

Python String Methods ~
capitalize() *            lstrip()
center(width)             partition(sep)
count(sub, start, end)    replace(old, new)
decode()                  rfind(sub, start ,end)
encode()                  rindex(sub, start, end)
endswith(sub)             rjust(width)
expandtabs()              rpartition(sep)
find(sub, start, end)     rsplit(sep)
index(sub, start, end)    rstrip()
isalnum() *               split(sep)
isalpha() *               splitlines()
isdigit() *               startswith(sub)
islower() *               strip()
isspace() *               swapcase() *
istitle() *               title() *
isupper() *               translate(table)
join()                    upper() *
ljust(width)              zfill(width)
lower() *
    -> Methods marked * are locale dependant for 8-bit strings.

Python File Methods ~
close()          readlines(size)
flush()          seek(offset)
fileno()         tell()
isatty()         truncate(size)
next()           write(string)
read(size)       writelines(list)
readline(size)

Python Indexes and Slices ~
    -> Indexes and Slices of a=[0,1,2,3,4,5]
len(a)      = 6
a[0]        = 0
a[5]        = 5
a[-1]       = 5
a[-2]       = 4
a[1:]       = [1,2,3,4,5]
a[:5]       = [0,1,2,3,4]
a[:-2]      = [0,1,2,3]
a[1:3]      = [1,2]
a[1:-1]     = [1,2,3,4]
b=a[:]      = Shallow copy of a


==============================================================================
DATE                                                           *c-python-date*

Python Datetime Methods ~
today()                 fromordinal(ordinal)
now(timezoneinfo)       combine(date, time)
utcnow()                strptime(date, format)
fromtimestamp(timestamp)
utcfromtimestamp(timestamp)

Python Time Methods ~
replace()        utcoffset()
isoformat()      dst()
__str__()        tzname()
strftime(format)

Python Date Formatting ~
%a      Abbreviated weekday (Sun)
%A      Weekday (Sunday)
%b      Abbreviated month name (Jan)
%B      Month name (January)
%c      Date and time
%d      Day (leading zeros) (01 to 31)
%H      24 hour (leading zeros) (00 to 23)
%I      12 hour (leading zeros) (01 to 12)
%j      Day of year (001 to 366)
%m      Month (01 to 12)
%M      Minute (00 to 59)
%p      AM or PM
%S      Second {4}
%U      Week number {1} (00 to 53)
%w      Weekday {2} (0 to 6)
%W      Week number {3} (00 to 53)
%x      Date
%X      Time
%y      Year without century (00 to 99)
%Y      Year (2008)
%Z      Time zone (GMT)
%%      A literal "\%" character (\%)
    -> 1. Sunday as start of week. All days in a new year preceding the first Sunday are considered to be in week 0.
    -> 2. 0 is Sunday, 6 is Saturday.
    -> 3. Monday as start of week. All days in a new year preceding the first Monday are considered to be in week 0.
    -> 4. This is not a mistake. Range takes account of leap and double-leap seconds.} 


==============================================================================
EXAMPLES                                                   *c-python-examples*
>python
#Loop-Over-Sequence
for index, value in enumerate(seq):
  print("{} : {}".format(index, value))

#Loop-Over-Dictionary
for key in sorted(dict):
  print(dict[key])

#Read-a-File
with open("filename", "r") as f:
  for line in f:
    line = line.rstrip("\textbackslash{}n") # Strip newline
    print(line)
<python

==============================================================================
Thanks ~
sschaub     https://www.cheatography.com/sschaub/cheat-sheets/essential-python/
davechild   https://www.cheatography.com/davechild/cheat-sheets/python/



vim: ft=myhelp
