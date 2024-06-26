```
# From https://unix.stackexchange.com/questions/32907/what-characters-do-i-need-to-escape-when-using-sed-in-a-sh-script
$.*[\^  # Quote
(){}+?|  # Not quote
```

* Get submatch 1 for all lines
    *   
        ```bash
        echo -e "Bla\nBla\nImportant1: One \nBla\nImportant2: Two\nBla\nBla" | \
           sed -n 's/^Important1: *\([^ ]*\) */\1/p'

        OUTPUT:
        one
        ```
    *   `-n` means silent


* Replace a multi-line string
  https://unix.stackexchange.com/questions/26284/how-can-i-use-sed-to-replace-a-multi-line-string?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
    *
    ```bash
    sed '/^a test$/{
       $!{ N        # append the next line when not on the last line
         s/^a test\nPlease do not$/not a test\nBe/
                    # now test for a successful substitution, otherwise
                    #+  unpaired "a test" lines would be mis-handled
         t sub-yes  # branch_on_substitute (goto label :sub-yes)
         :sub-not   # a label (not essential; here to self document)
                    # if no substituion, print only the first line
         P          # pattern_first_line_print
         D          # pattern_ltrunc(line+nl)_top/cycle
         :sub-yes   # a label (the goto target of the 't' branch)
                    # fall through to final auto-pattern_print (2 lines)
       }    
     }' alpha.txt         
     ```








* Multiline pattern
  *
  ```bash
   sed -n '/[{]/,/[}]/{
   p
   /[}]/a\
    end of block matching brace

   }' *.txt 
  ```
  * `-n` means 'no default print lines as processed'.
    * `'p'` means now print the line.
    * `/[{]/,/[}]/` is a range expression. It means scan until you find something that matches the first pattern (/[{]/) AND then scan until you find the 2nd pattern (/[}]/) THEN perform whatever actions you find in between the { } in the sed code. In this case 'p' and the debugging code. (not explained here, use it, mod it or take it out as works best for you).


* Read a file
  * `sed -i -e '/fox/{r f.html' -e 'd}'`
  
  
* Append (line after pattern)
  * 
  ```bash
  sed -i '/pattern/a \
  line1 \
  line2' inputfile
  ```
  * `sed -i '/SearchPattern/aNew Text' SomeFile.txt`
  
  
* Prepend (line before pattern)
  * 
  ```bash
  sed -i '/pattern/i \
  line1 \
  line2' inputfile
  ```
  
  


* Cheat
  ```
  :  # label
  =  # line_number
  a  # append_text_to_stdout_after_flush
  b  # branch_unconditional             
  c  # range_change                     
  d  # pattern_delete_top/cycle          
  D  # pattern_ltrunc(line+nl)_top/cycle 
  g  # pattern=hold                      
  G  # pattern+=nl+hold                  
  h  # hold=pattern                      
  H  # hold+=nl+pattern                  
  i  # insert_text_to_stdout_now         
  l  # pattern_list                       
  n  # pattern_flush=nextline_continue   
  N  # pattern+=nl+nextline              
  p  # pattern_print                     
  P  # pattern_first_line_print          
  q  # flush_quit                        
  r  # append_file_to_stdout_after_flush 
  s  # substitute                                          
  t  # branch_on_substitute              
  w  # append_pattern_to_file_now         
  x  # swap_pattern_and_hold             
  y  # transform_chars    
  ```

```
.---------------------------------------------------------------------.
|                                                                     |
|                            UNIX Stream Editor                       |
|                             Sed Cheat Sheet                         |
|                                                                     |
'---------------------------------------------------------------------'
| Created by Peter Krumins (peter@catonmat.net, @pkrumins on twitter) |
| www.catonmat.net -- good coders code, great coders reuse            |
'---------------------------------------------------------------------'

 ==================== How Commands Affect Streams ====================

   .---------.-----------.-----------------------------------------.
   |         |           |           Modifications to:             |
   |         |  Address  '---------.---------.---------.-----------'
   | Command | or Range  | Input   | Output  | Pattern |   Hold    |
   |         |           | Stream  | Stream  | Space   |   Buffer  |
   '---------+-----------+---------+---------+---------+-----------'
   |    =    |     -     |    -    |    +    |    -    |     -     |
   |    a    |     1     |    -    |    +    |    -    |     -     |
   |    b    |     2     |    -    |    -    |    -    |     -     |
   |    c    |     2     |    -    |    +    |    -    |     -     |
   |    d    |     2     |    +    |    -    |    +    |     -     |
   |    D    |     2     |    +    |    -    |    +    |     -     |
   |    g    |     2     |    -    |    -    |    +    |     -     |
   |    G    |     2     |    -    |    -    |    +    |     -     |
   |    h    |     2     |    -    |    -    |    -    |     +     |
   |    H    |     2     |    -    |    -    |    -    |     +     |
   |    i    |     1     |    -    |    +    |    -    |     -     |
   |    l    |     1     |    -    |    +    |    -    |     -     |
   |    n    |     2     |    +    |    *    |    -    |     -     |
   |    N    |     2     |    +    |    -    |    +    |     -     |
   |    p    |     2     |    -    |    +    |    -    |     -     |
   |    P    |     2     |    -    |    +    |    -    |     -     |
   |    q    |     1     |    -    |    -    |    -    |     -     |
   |    r    |     1     |    -    |    +    |    -    |     -     |
   |    s    |     2     |    -    |    -    |    +    |     -     |
   |    t    |     2     |    -    |    -    |    -    |     -     |
   |    w    |     2     |    -    |    +    |    -    |     -     |
   |    x    |     2     |    -    |    -    |    +    |     +     |
   |    y    |     2     |    -    |    -    |    +    |     -     |
   '---------'-----------'---------'---------'---------'-----------'

    Modifications to:

    1    Command takes single address or pattern.
    2    Command takes pair of addresses.
    -    Command does not modify the buffer.
    +    Command modifies the buffer.
    *    The ``n'' command may or may not generate output depending
         on the ``-n'' command option.


 ========================== Command Summary ==========================

.----------------.----------------------------------------------------.
|                |                                                    |
| Command        | Description                                        |
|                |                                                    |
'----------------+----------------------------------------------------'
| #              | Adds a comment.                                    |
'----------------+----------------------------------------------------'
| =              | The "=" command prints the current line number to  |
|                | standard output.                                   |
'----------------+----------------------------------------------------'
| a \            | The "a" command appends text after the             |
| text           | range or pattern.                                  |
'----------------+----------------------------------------------------'
| b label        | The "b" command branches to the label. You can     |
|                | specify a label with a text string followed by a   |
|                | colon. If no label is there, branch to the end of  |
|                | the script.                                        |
'----------------+----------------------------------------------------'
| c \            | The "c" command changes the current line with      |
| text           | text.                                              |
'----------------+----------------------------------------------------'
| d              | The "d" command deletes the current pattern space, |
|                | reads in the next line, puts the new line into the |
|                | pattern space, and aborts the current command, and |
|                | starts execution at the first sed command.         |
'----------------+----------------------------------------------------'
| D              | The "D" command deletes the first portion of the   |
|                | pattern space, up to the new line character,       |
|                | leaving the rest of the pattern alone.             |
'----------------+----------------------------------------------------'
| g              | Instead of exchanging (the "x" command) the hold   |
|                | space with the pattern space, you can copy the     |
|                | hold space to the pattern space with the "g"       |
|                | command.                                           |
'----------------+----------------------------------------------------'
| G              | If you want to append to the pattern space, use    |
|                | the "G" command.                                   |
'----------------+----------------------------------------------------'
| h              | The "h" command copies the pattern buffer into the |
|                | hold buffer.                                       |
'----------------+----------------------------------------------------'
| H              | The "H" command allows you to combine several      |
|                | lines in the hold buffer. It acts like the "N"     |
|                | command as lines are appended to the buffer, with  |
|                | a "\n" between the lines. You can save several     |
|                | lines in the hold buffer, and print them only if a |
|                | particular pattern is found later.                 |
'----------------+----------------------------------------------------'
| i \            | You can insert text before the pattern with        |
| text           | the "i" command.                                   |
'----------------+----------------------------------------------------'
| l              | The "l" command prints the current pattern space.  |
|                | It is therefore useful in debugging sed scripts.   |
|                | It also converts unprintable characters into       |
|                | printing characters by outputting the value in     |
|                | octal preceded by a "\" character.                 |
'----------------+----------------------------------------------------'
| n              | The "n" command will print out the current pattern |
|                | space (unless the "-n" flag is used), empty the    |
|                | current pattern space, and read in the next        |
|                | line of input.                                     |
'----------------+----------------------------------------------------'
| N              | The "N" command does not print out the current     |
|                | pattern space and does not empty the pattern       |
|                | space. It reads in the next line, but appends a    |
|                | new line character along with the input line       |
|                | itself to the pattern space.                       |
'----------------+----------------------------------------------------'
| p              | Another useful command is the print command: "p".  |
|                | If sed wasn't started with an "-n" option, the "p" |
|                | command will duplicate the input. The "p" command  |
|                | prints the entire pattern space.                   |
'----------------+----------------------------------------------------'
| P              | The "P" command only prints the first part of the  |
|                | pattern space, up to the NEWLINE character.        |
'----------------+----------------------------------------------------'
| q              | There is one more simple command that can restrict |
|                | the changes to a set of lines. It is the "q"       |
|                | command: quit. This command is most useful when    |
|                | you wish to abort the editing after some condition |
|                | is reached.                                        |
'----------------+----------------------------------------------------'
| r filename     | The "r" command will append text from filename     |
|                | after the range or pattern.                        |
'----------------+----------------------------------------------------'
| s/regex/repl/  | The substitute command replaces all occurrences of |
|                | the regular expression (regex) with repl(acement)  |
'----------------+----------------------------------------------------'
| t label        | You can execute a branch if a pattern is found.    |
|                | You may want to execute a branch only if a         |
|                | substitution is made. The command "t label" will   |
|                | branch to the label if the last substitute command |
|                | modified the pattern space.                        |
'----------------+----------------------------------------------------'
| w filename     | With this command, you can specify a filename that |
|                | will receive the modified data.                    |
'----------------+----------------------------------------------------'
| x              | The "x" command exchanges the hold buffer and the  |
|                | pattern buffer.                                    |
'----------------+----------------------------------------------------'
| y/source/dest/ | Transliterate the characters in the pattern space, |
|                | which appear in source to the corresponding        |
|                | character in dest(ination).                        |
'----------------'----------------------------------------------------'


 ======================== Command Extensions =========================

.----------------.----------------------------------------------------.
|                |                                                    |
| Command        | Description                                        |
|                |                                                    |
'----------------+----------------------------------------------------'
| Q              | Immediately quit the sed script without processing |
|                | any more input. (zero or one address command)      |
'----------------+----------------------------------------------------'
| R filename     | Append a line read from filename. (zero or one     |
|                | address command).                                  |
'----------------+----------------------------------------------------'
| T label        | If no s/// has done a successful substitution      |
|                | since the last input line was read and since the   |
|                | last t or T command, then branch to label;         |
|                | if label is omitted, branch to end of script.      |
|                | (accepts address range).                           |
'----------------+----------------------------------------------------'
| W filename     | Write the first line of the current pattern space  |
|                | to filename. (accepts address range).              |
'----------------'----------------------------------------------------'


 ======================= Address Range Summary =======================

.----------------.----------------------------------------------------.
|                |                                                    |
| Format         | Description                                        |
|                |                                                    |
'----------------+----------------------------------------------------'
| number         | Match only the specified line number.              |
'----------------+----------------------------------------------------'
| first~step     | Match every step'th line starting with line first. |
'----------------+----------------------------------------------------'
| $              | Match the last line.                               |
'----------------+----------------------------------------------------'
| 0, addr2       | Start out in "matched first address" state,        |
|                | until addr2 is found.                              |
'----------------+----------------------------------------------------'
| /regex/        | Match lines matching the regular expression regex. |
'----------------+----------------------------------------------------'
| addr1,+N       | Will match addr1 and the N lines following addr1.  |
'----------------+----------------------------------------------------'
| \cregexc       | Match lines matching the regular expression regex. |
|                | The c may be any character.                        |
'----------------+----------------------------------------------------'
| addr1,~N       | Will match addr1 and the lines following addr1     |
|                | until the next line whose input line number        |
|                | is a multiple of N.                                |
'----------------'----------------------------------------------------'


 ============== GNU Sed's Command Line Argument Summary ==============

.---------------------.-----------------------------------------------.
|                     |                                               |
| Argument            | Description                                   |
|                     |                                               |
'---------------------+-----------------------------------------------'
| -n                  |                                               |
| --quiet             | Suppress automatic printing of pattern space. |
| --silent            |                                               |
'---------------------+-----------------------------------------------'
| -e script           |                                               |  
| --expression=script | Add the script to the commands to be executed.|
|                     |                                               |
'---------------------+-----------------------------------------------'
| -f script-file      | Add the contents of script-file to the        |
| --file=script-file  | commands to be executed.                      |
'---------------------+-----------------------------------------------'
| -i[suffix]          | Sdit files in place (makes backup if          |
| --in-place[=suffix] | extension supplied).                          |
'---------------------+-----------------------------------------------'
| -l N                | Specify the desired line-wrap length for      |
| --line-length=N     | the `l' command.                              |
'---------------------+-----------------------------------------------'
| -r                  | Use extended regular expressions in the       |
| --regexp-extended   | script.                                       |
'---------------------+-----------------------------------------------'
| -s                  | Consider files as separate rather than as a   |
| --separate          | single continuous long stream.                |
'---------------------+-----------------------------------------------'
| -u                  | Load minimal amounts of data from the input   |
| --unbuffered        | files and flush the output buffers more often.|
'---------------------+-----------------------------------------------'
| --help              | Display this help and exit                    |
'---------------------+-----------------------------------------------'
| -V                  | Output version information and exit           |
| --version           |                                               |
'---------------------'-----------------------------------------------'

 =====================================================================

.---------------------------------------------------------------------.
| Created by Peter Krumins (peter@catonmat.net, @pkrumins on twitter) |
| www.catonmat.net -- good coders code, great coders reuse            |
'---------------------------------------------------------------------'
```

# Regex Atoms and multipliers

From: https://www.gnu.org/software/sed/manual/html_node/Regular-Expressions.html

```
To know how to use sed, people should understand regular expressions (regexp for short). A regular expression is a pattern that is matched against a subject string from left to right. Most characters are ordinary: they stand for themselves in a pattern, and match the corresponding characters in the subject. As a trivial example, the pattern

     The quick brown fox

matches a portion of a subject string that is identical to itself. The power of regular expressions comes from the ability to include alternatives and repetitions in the pattern. These are encoded in the pattern by the use of special characters, which do not stand for themselves but instead are interpreted in some special way. Here is a brief description of regular expression syntax as used in sed.

char
    A single ordinary character matches itself.
*
    Matches a sequence of zero or more instances of matches for the preceding regular expression, which must be an ordinary character, a special character preceded by \, a ., a grouped regexp (see below), or a bracket expression. As a GNU extension, a postfixed regular expression can also be followed by *; for example, a** is equivalent to a*. POSIX 1003.1-2001 says that * stands for itself when it appears at the start of a regular expression or subexpression, but many nonGNU implementations do not support this and portable scripts should instead use \* in these contexts.
\+
    As *, but matches one or more. It is a GNU extension.
\?
    As *, but only matches zero or one. It is a GNU extension.
\{i\}
    As *, but matches exactly i sequences (i is a decimal integer; for portability, keep it between 0 and 255 inclusive).
\{i,j\}
    Matches between i and j, inclusive, sequences.
\{i,\}
    Matches more than or equal to i sequences.
\(regexp\)
    Groups the inner regexp as a whole, this is used to:

        Apply postfix operators, like \(abcd\)*: this will search for zero or more whole sequences of ‘abcd’, while abcd* would search for ‘abc’ followed by zero or more occurrences of ‘d’. Note that support for \(abcd\)* is required by POSIX 1003.1-2001, but many non-GNU implementations do not support it and hence it is not universally portable.
        Use back references (see below). 


.
    Matches any character, including newline.
^
    Matches the null string at beginning of the pattern space, i.e. what appears after the circumflex must appear at the beginning of the pattern space.

    In most scripts, pattern space is initialized to the content of each line (see How sed works). So, it is a useful simplification to think of ^#include as matching only lines where ‘#include’ is the first thing on line—if there are spaces before, for example, the match fails. This simplification is valid as long as the original content of pattern space is not modified, for example with an s command.

    ^ acts as a special character only at the beginning of the regular expression or subexpression (that is, after \( or \|). Portable scripts should avoid ^ at the beginning of a subexpression, though, as POSIX allows implementations that treat ^ as an ordinary character in that context.
$
    It is the same as ^, but refers to end of pattern space. $ also acts as a special character only at the end of the regular expression or subexpression (that is, before \) or \|), and its use at the end of a subexpression is not portable.
[list]
[^list]
    Matches any single character in list: for example, [aeiou] matches all vowels. A list may include sequences like char1-char2, which matches any character between (inclusive) char1 and char2.

    A leading ^ reverses the meaning of list, so that it matches any single character not in list. To include ] in the list, make it the first character (after the ^ if needed), to include - in the list, make it the first or last; to include ^ put it after the first character.

    The characters $, *, ., [, and \ are normally not special within list. For example, [\*] matches either ‘\’ or ‘*’, because the \ is not special here. However, strings like [.ch.], [=a=], and [:space:] are special within list and represent collating symbols, equivalence classes, and character classes, respectively, and [ is therefore special within list when it is followed by ., =, or :. Also, when not in POSIXLY_CORRECT mode, special escapes like \n and \t are recognized within list. See Escapes.
regexp1\|regexp2
    Matches either regexp1 or regexp2. Use parentheses to use complex alternative regular expressions. The matching process tries each alternative in turn, from left to right, and the first one that succeeds is used. It is a GNU extension.
regexp1regexp2
    Matches the concatenation of regexp1 and regexp2. Concatenation binds more tightly than \|, ^, and $, but less tightly than the other regular expression operators.
\digit
    Matches the digit-th \(...\) parenthesized subexpression in the regular expression. This is called a back reference. Subexpressions are implicity numbered by counting occurrences of \( left-to-right.
\n
    Matches the newline character.
\char
    Matches char, where char is one of $, *, ., [, \, or ^. Note that the only C-like backslash sequences that you can portably assume to be interpreted are \n and \\; in particular \t is not portable, and matches a ‘t’ under most implementations of sed, rather than a tab character. 

Note that the regular expression matcher is greedy, i.e., matches are attempted from left to right and, if two or more matches are possible starting at the same character, it selects the longest.

Examples:

‘abcdef’
    Matches ‘abcdef’.
‘a*b’
    Matches zero or more ‘a’s followed by a single ‘b’. For example, ‘b’ or ‘aaaaab’.
‘a\?b’
    Matches ‘b’ or ‘ab’.
‘a\+b\+’
    Matches one or more ‘a’s followed by one or more ‘b’s: ‘ab’ is the shortest possible match, but other examples are ‘aaaab’ or ‘abbbbb’ or ‘aaaaaabbbbbbb’.
‘.*’
‘.\+’
    These two both match all the characters in a string; however, the first matches every string (including the empty string), while the second matches only strings containing at least one character.
‘^main.*(.*)’
    This matches a string starting with ‘main’, followed by an opening and closing parenthesis. The ‘n’, ‘(’ and ‘)’ need not be adjacent.
‘^#’
    This matches a string beginning with ‘#’.
‘\\$’
    This matches a string ending with a single backslash. The regexp contains two backslashes for escaping.
‘\$’
    Instead, this matches a string consisting of a single dollar sign, because it is escaped.
‘[a-zA-Z0-9]’
    In the C locale, this matches any ASCII letters or digits.
‘[^ tab]\+’
    (Here tab stands for a single tab character.) This matches a string of one or more characters, none of which is a space or a tab. Usually this means a word.
‘^\(.*\)\n\1$’
    This matches a string consisting of two equal substrings separated by a newline.
‘.\{9\}A$’
    This matches nine characters followed by an ‘A’.
‘^.\{15\}A’
    This matches the start of a string that contains 16 characters, the last of which is an ‘A’. 
```

# Sed by example

```
sed gets input stream (usually file) line by line, modify each line accordingly to rules in sed's script file and print the result to output stream.

Following is example of command

sed [options] '{script}' [file(s)]

If there is no file as input then sed reads input stream or pipeline. If you want the result in a text file, you can either redirect it via the regular method:

sed [options] '{script}' [inputfile] > [output]

Or use the option -i that will directly edit the input file

sed -i [options] '{script}' [inputfile]

Search
Command 	Description
sed -n "3p" file.txt 	print 3rd line
sed -n '1,3p' file.txt 	print strings from 1st to 3rd
sed -n "/[media]/,/[public]/p" smb.conf 	print strings from 1st to 3rd which contains specified string
sed -n '/[media]/,$p' smb.conf 	print strings from first mention of media till end of file
sed 5,15d file.txt 	show all of file.txt except for lines from 5 to 15
sed '/pattern/q' file.txt 	print all lines till pattern
sed -n '/pattern/p' file.txt 	print do matched strings (emulates grep)
sed -n '/pattern/!p' file.txt 	print do NOT matched strings (emulates grep -v)
sed -n 's/unix/linux/p' file.txt 	printing only the replaced lines
sed -n '/X/!p' file.txt 	print lines which does not contain 'X'
sed -n '2~5p' file.txt 	print every 5th line starting with the second
sed '/AAA.*BBB.*CCC/!d' file.txt 	grep for AAA and BBB and CCC (in that order)
sed '/AAA/!d; /BBB/!d; /CCC/!d' file.txt 	grep for AAA and BBB and CCC (in any order)

Modify
Command 	Description
sed 's/foo/boo/' file.txt 	replace first entrance foo with boo
sed 's|http://|www|' file.txt 	replace first entrance foo with boo (another divider)
sed 's/foo/boo/g' file.txt 	replace all entrances foo with boo
sed 's/foo/boo/3' file.txt 	replace first three entrances foo with boo
sed 's/foo/[&]/' file.txt 	wrap foo with [ ]
sed 's/pattern1|pattern2/foo/g' file.txt 	replace pattern1 or pattern2 with foo
sed 's/\(foo\)\(boo\)/\2\1/' file.txt 	replace fooboo with boofoo
sed 's/^../XX/' file.txt 	replace the first two characters of a string or a line with "XX"
sed -e 's/unix/linux/' -e 's/os/system/' file.txt 	-e option provieds to run multiple sed commands in a single sed command
sed '3 s/foo/boo/' file.txt 	replace string on a specific line number
sed '1,3 s/foo/boo/' file.txt 	replace string on a range of lines
sed '/pattern/ s/foo/boo/' file.txt 	replace on a lines which matches a pattern
sed '1i HEAD1, HEAD2' file.txt 	insert a header line
sed -i '1a -------' file.txt 	add a line '-------' at the 1st line
sed '5!s/foo/boo/' file.txt 	replace foo with boo in file.txt except in the 5th line
sed '/pattern/!s/foo/boo/' file.txt 	unless pattern is found replace foo with boo
sed '/pattern/s/foo/boo/g' file.txt 	only if line contains pattern, substitute foo with boo
sed '1d;$d' file.txt 	delete the first line AND the last line of a file
sed '/^$/d' file.txt 	delete all blank lines in the file
sed '/foo/,$d' file.txt 	delete the lines starting from the pattern 'foo' till the last line
sed '1,4{/foo/d;}' file.txt 	delete the lines containing the pattern 'foo' only if it is present in the lines from 1 to 4
sed '1,20 s/foo/boo/g' file.txt 	replace foo with boo only on lines between 1 and 20
sed '1,20 !s/foo/boo/g' file.txt 	the above reversed (match all except lines 1-20)
sed '/pattern/G' file.txt 	insert blank line below every line that match pattern
sed 'n;n;n;n;G;' file.txt 	add a blank line every 5 lines (after lines 5, 10, 15, 20, etc.)
sed 's/^/ /' file.txt 	insert 5 blank spaces at beginning of each line (make page offset)
sed '/foo/ a "boo"' file.txt 	add a line after a match
sed '/foo/ i "boo"' file.txt 	add a line before a match
sed '/foo/ c "boo"' file.txt 	replace an entire line with a new line
sed ‘s/^/\t/’ file.txt 	insert a tab at beginning of each line
sed -e 's/#.*//' file.txt 	delete all the comment lines from a file
$sed 's/.$//' file.txt 	convert DOS newlines (CR/LF) to Unix format
sed -e '$r 2.txt' 1.txt 	insert file 2.txt at the end of 1.txt
sed 's/\t/ /g' file.txt 	replace tab with spaces
find ~/projects/ -type f -exec sed -i 's/nodejs/django/g' {} \; 	replace in all found files
find ~/projects/ -name "*.js" -print | xargs sed -i 's/nodejs/django/g' 	replace in multiple files

Delete
Command 	Description
sed -n "3,10d" file.txt 	delete all lines from line 3 till 10
sed '17,/foo/d' file.txt 	delete all lines from line 17 to 'foo'
sed 's/^[ ^t]*//' file.txt 	delete all spaces in front of every line of file.txt
sed 's/[ ^t]*$//' file.txt 	delete all spaces at the end of every line of file.txt
sed 's/^[ ^t]*//;s/[ ^]*$//' file.txt 	delete all spaces in front and at the end of every line of file.txt
sed '1~3d' file.txt 	delete every third line, starting with the first
sed ‘/^$/d’ in.txt > out.txt 	delete all the blank lines from a file
sed '0,/pattern_to_delete/{//d;}' file.txt 	delete only first match from a file
```
