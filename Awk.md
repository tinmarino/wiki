% Awk

# Tips

* Print part of each line
	awk '{print substr($0, 2, 6)'} file.txt


# USAGE

awk [ - v var=val ] 'program' [file1 file2...] <br>
awk [ - v var=val ] 'program' [file1 file2...]

### Structure of an awk program 

```
# comments
pattern { action }  A sequence of pattern-action statements
pattern { action }
```

```
For each file,
   For each input line,
      For each pattern,
         If pattern matches input line, do the action.
```

### "pattern" 

BEGIN   :executes “action” before starting to view the input file <br>
END     :executes “action” after ending to view the input file <br>
Other   :regular, numeric or string expression or combination <br>

### "action" is executable code

if (expression) statement1 else statement2 <br>
while (expression) statement <br>
for (expr1;expr2;expr3) statement <br>
do statement while (expression) <br>
break / continue :immediately leave / start next iteration of innermost
enclosing loop <br>
exit / exit expression : go immediately to the END action; if within the END
action, exit program <br>


# BUILT-IN VARIABLES

| Variable         | Value                                                          |
| ---------------- | -------------------------------------------------------------- |
| $0               | Whole line,                                                    |
| $1, $2 ... $NF   | first, second... last field                                    |
| ARGC             | Number of command line arguments                               |
| ARGV             | Array of command line arguments                                |
| FILENAME         | Name of current input file                                     |
| FS, RS           | Input field / record separator (def: one space, \n)            |
| NF               | Number of fields in current record                             |
| NR, FNR          | Number of record read so far / in current file                 |
| OFMT             | Output format for numbers (default: %.6g)                      |
| OFS, ORS         | Output field / rec. separator (def: one space, \n)             |
| RESTART, RLENGTH | Start / Length of string matched by match function (see below) |
| SUBSEP           | Subscript separator (default: \034)                            |


# BUILT-IN FUNCTIONS

r: regex ; s,t: strings ; n,p: integers



|                               |                                                    |
| ----------------------        | -----------------------------                      |
| int(n), sqrt(n), exp(n)       |                                                    |
| log(n), sin(n), cos(n)        |                                                    |
| rand()                        | Random number between 0 and 1                      |
| close(file or command)        |                                                    |
|                               |                                                    |
| getline [var]                 | Read next line from input file, from a specific    |
| getline [var] < file          | file, or from a pipe                               |
| command  <pipe> getline [var] | Return 1 (record found), 0 (end of file), -1       |
|                               | (error)                                            |
| gsub(r,s)                     | Substitute s for r globally in $0 / string t;      |
| gsub(r,s,t)                   | return # of subs made                              |
|                               |                                                    |
| index(s,t)                    | Return first position of string t in s, or 0 if t  |
|                               | is not present                                     |
| length(s)                     | Return number of characters in s                   |
| match(s,r)                    | Test whether s contains a substring matched by r;  |
|                               | return index or 0; sets RSTART and RLENGTH         |
| split(s,a)                    | Split s into array a on FS / field separaror fs;   |
| split(s,a,fs)                 | return # of fields                                 |
|                               |                                                    |
| sprintf(fmt,expr-list)        | Return expr-list formatted according to format     |
|                               | string fmt                                         |
| sub(r,s)                      | Substitute s for the leftmost longest substring of |
| sub(r,s,t)                    | $0 / t matched by r; return # of subs made         |
|                               |                                                    |
| substr(s,p)                   | Return substring of s (of length n)starting at     |
| substr(s,p,n)                 | position p                                         |
|                               |                                                    |
| tolower(s), toupper(s)        | Lower and upper cases                              |


# FORMATTED OUTPUT

{ printf (“FORMAT”,value1,value2,value3,...) }


|                        |                                                                  |
| ---------------------- | -----------------------------                                    |
| %c  %s                 | Print as character, as string                                    |
| %-8s                   | Print as 8 characters, left aligned                              |
| %f %6.2f               | Print as float number,with 6 digits (4 as integer, 2 as decimal) |
| `\n`                   | Line feed and carriage return                                    |


# OPERATORS


|                                   |                                                   |
| ----------------------            | -----------------------------                     |
| &&  <pipe> <pipe> !               | Logical operators. Ex: !($2<4 <pipe><pipe> $3<20) |
| <  <=  == !=  >=  >~  !~          | Comparing operators matched by, not               |
| selector?if-true-exp:if-false-exp |                                                   |


# EXAMPLE

```
{ print NR, $0 }        Precede each line by line #
{ $1 = NR; print }      Replace first field by line #
{ $2 = log($2); $3 =”” ; print }
                        Replace the 2nd field by its logarithm, zap field 3
NF > 0                  Print non-empty lines
NF > 0 {print $1, $NF}  Print first field and last one of non-empty lines
$NF > 4                 Print if last field greater than 4
NR%2==0                 Print even-numbered lines
NR==10, NR==20          Print lines 10 to 20
/start/, /end /         Print lines between patterns
/regex/, EOF            Print from pattern to end of file
/regex/ {print $1}      Print first field of lines matching regex
$1 ~ /regex/            Print lines where first field matches
ORS=NR%5?”,”:”\n”       Concatenate every 5 lines of input, using comma separator
/regex/ {x++}END        Count and print the number of lines matching /regex/
{print x}
{ nc += length($0) + 1; nw += NF }
END { print NR, "lines", nw, "words", nc, "characters" }
                        wc command
{ sum += $1 }
END { print sum, sum/NR }
                        Print sum and average
{ x[NR] = $0 }
END {for (i = NR; i > 0; i--) print x[i]}
                        Reverse a file
{ a[$1] += $2 }
END { for (i in a) print (i,":",a[i]) }
                        Group by field 1, and sum field 2
function pwr(a,b) { return exp(b*log(a)) }
NF >= 2 { print pwr($1,$2) }
                        User defined function
BEGIN { RS=””; FS=”\n” }
{ print “Name: “,$1
print “Address: “,$2 }
                        Multi-line records. Leading and trailing newlines are
                        ignored
```

# Dump

```bash
jq -r .results[]._links.download < /tmp/academy-attachment.json \
  | awk -F/ '{
    split($5, a_filename,"?");
    print( \
      "mkdir", \
      "attachment/" $4 ";", \
      "wget", \
      "--no-check-certificate", \
      "\"'"$url_base/"'" $0 "\"", \
      "-O", \
      "attachment/" $4 "/" a_filename[1])
    }'
```



from: http://www.cheat-sheets.org/saved-copy/awk_quickref.pdf
