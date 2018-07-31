% Notes (from doc)


### Key

|       |   |
| ---   | --- |
| ga    | Caracter value, in unicode, ascii, hex octal |
| s     | cl: Change one char |
| C     | c$: Change full line |
| S     | ^C: Change line the end |
| <s-J> | paste next line at the end of current |
| <c-l> | redraw screen |
| 8g8   | see if some invalid utf8 char |
| gw i  | indent filter: like gq but not moving cursor |
| zt    | (zm, zb) puts current line to top of screen |
| z.    | or zz puts current line to center of screen |
| zb    | puts current line to bottom of screen |

# Jump

|               |   |
| ---           | --- |
| :jumps        | Display jump list |
| __1 Nice__    |   |
| %             | Matching bracket |
| <C-i>         | Next location, insert position |
| <C-o>         | Previous (older) location |
| '.            | To last inserted text |
| _ or ^        | move to first (non blank caracter) |
| gi            | Insert at last modified position |
| gI            | Insert at col 1 |
| -, +          | Insert at first non blank char at [count] lines before or after |
| gx            | xRef (html on browser) |
| gd, gD        | Local(function), Global (file) declaration (no syntax) |
| [I            | include-search of a word |
| gf            | open file name under cursor (SUPER) |
| __2 Not bad__ |   |
| g_            | Last non-blank character of the line |
| L M H         | Bottom, Middle, Top of screen |
| ge            | Backward to end of word |
| g; and g,     | Older and newer changes |
| __3 Keys__    |   |
| ( , )         | One sentence (sentences starts with .) |
| { , }         | One paragraph |
| fx            | Next occurrence of character x |
| tx            | Before next occurrence of character |
|               | Note: Capital letters and some chars are much rarer. |
|               | spot them |




# INSERT

|               |                             |
| ---           | ---                         |
| `i<c-h>`      | Delete Char                 |
| `i<c-w>`      | Delete Word                 |
| `i<c-u>`      | Delete Line                 |
| `i<c-v><c-m>` | Carriage return for windows |
| `i<c-k>c1 c2` | Insert unicode by digraph   |
| `i<c-t>`      | Indent current line         |
| `i<c-d>`      | Unindent current line       |

 

|                    |                                                        |
| ---                | ---                                                    |
| `i<c-s-u>nnnnnn`   | Insert unicode char                                    |
|                    | warning:    <c-u> in insert mode delete line           |
|                    | Cannot be undone but the content is in the . reg       |
| `i<c-v>nnn`        | Decimal value(with 000 <= nnn <= 255)                  |
| `i<c-v>onnn`       | Octal (000 <= nnn <= 377)                              |
| `i<c-v>Onnn`       |                                                        |
| `i<c-v>xnn`        | Hex value (00 <= nn <= FF)                             |
| `i<c-v>Xnn`        |                                                        |
| `i<c-v>unnnn`      | Hex for BMP unicode codepoint (0000 <= nnnn <= FFFF)   |
| `i<c-v>Unnnnnnnnn` | Hex value for any Unicode codepoint: ^VUnnnnnnnn (with |
|                    | 00000000 <= nnnnnnnn <= 7FFFFFFF)                      |



## Normal mode

### Registers

```vim
" IN COMMAND 
:registers  		"to view content 
:normal @a  		" to run macro a from ex command
:g/vim/ normal @a  	" run a for lines containing vim 
:call setreg('"', @", 'V') 
                    " the inverse fct is getreg
:<C-R>=getline(58)<CR>
                    " After that you will be back to command line editing, but it has inserted the contents of the 58th line.
:g/^foo/y A,
:g/bar/y A,
:let @+ = @a .      " Copy all lines beginning with foo, and afterwards all lines containing bar to clipboard, chain these commands: qaq (resets the a register storing an empty macro inside it), 
:let @" = expand("%:p") 
                    "put in the unamed register the full path
:let @b = substitute(@a,'\_s*\(.\{-}\)\_s*$','\1','')
                    " this give the output in reg b 
:%y+. 	            "Copy the entire buffer to the system clipboard of the file 
```
                                                             
### Register list

|     |   |
| --- | ----------------------------------------------------------------------- |
| a   | Named register |
| A   | Append |
| "   | Unamed register is the uname reg, everything going to a reg also go to this one |
| _   | is the black hole register, empty when reading but writable. |
|     | everything going to it go to /dev/null to avoid erase the standar register |
|     | when deleting something |
| -   | the small delete (lesss than one line for example thing you delete with 3x |
| .   | last inserted text |
| %   | filename |
| :   | command |
| /   | search |
| =   | expression # to take the result of an arbitrary expression |
| +   | and * are for interface with system clipboard "maybe install vimx |
| #   | name od atlernate file |





### Fold

|            |   |
| ---        | ----------------------------------------------------------------------- |
| __Create__ |   |
| zf         | Operator to create fold |
|            | zf10j, zf/string, zf'a |
| __Move__   |   |
| zj         | To the next fold. |
| zk         | To the previous fold. |
| ]z         | To end of open fold. |
| [z         | To start of open fold. |
| __Change__ |   |
| zo, zO     | Opens a (all) fold at the cursor. |
| zc, zC     | Close (all) |
| zm         | Increases the foldlevel by one. |
| zM         | Closes all open folds. |
| zr         | Decreases the foldlevel by one. |
| zR         | Decreases the foldlevel to zero -- all folds will be open. |
| zd         | Deletes the fold at the cursor. |
| zE         | Deletes all folds. |


```vim
:syn match comment "\v(^\s*//.*\n)+" fold
set "foldtext"              " witch show what you see when folded 
:set foldmethod=expr
:set foldexpr=empty(getline(v:lnum))?'=':indent(v:lnum)/4
```





## Ex mode

    
http://www.csb.yale.edu/userguides/wordprocess/vi-summary.html


|      |   |
| ---  | --- |
| :t$  | Copy current line to the end |
| :#   | Display current line number |
| :&   | Repeat last substitue |
| :42  | Jump to line 42, as does typing 42G. |
| :e . | Edit: Open integrated explorer |



### Advanced

:#n  and  :#<n      Are replaced by file buffer n or oldfiles n




#### Man (Read linux manual pages)

runtime! ftplugin/man.vim
:Man 3 printf
:h find-manpage 

#### Buffer

:argdel *           Delete the existing argument list
:bufdo argadd %     For each buffer, add the buffer's path to the list
:1,1000bd           Delete buffers 1 to 1000; probably there's a better way to do this
:argdo e            For each argument, edit that argument
:bufhiden           Can unload a buffer < then not visible
		            Very cool for scratch buufer (warning they are permanently
                    lost)

#### Diff

set diffopt+=iwhite  " ignore spacelines <br>
set diffexpr= <br>
:diffupdate <br>


#### Tips

:tab help foo <br>
:!tidy -mi -html -wrap 0 % <br>
:<n>,<m> w filename <br>
:ccl                Close it quickfix <br>



### Regex

VIM: NFA regular expression

Forget me and go to :h pattern (or :h regex) that is super well written.
At least for the first chapter


```
1. Regex 						|v-regex|
 1. Escape Characters 			|v-escape|
 2. Quantifiers Greedy or not 	|v-quantifier|
2. Search						|v-search|
 1. Commands                    |v-search-modifier|
 1. Search modifiers            |v-search-modifier|
3. Sustitute 					|v-substitute|
4. Global						|v-global|

# 1. Regex

http://vimregex.com/ (Vim Regular Expression 101)
                                                                    


### Escaped caracter or metecaratcter 
.  		    any character except new line 	  	 
\s 		    whitespace character 	
\S 		    no whitespace (upper case is the opposite)
\d 		    digit 	
\x 		    hex digit 	
\o 		    octal digit 	
\h 		    head of word character (a,b,c...z,A,B,C...Z and _) 	
\p 		    printable character 	
\w 		    word character 	
\a 		    alphabetic character 	
\l 		    lowercase character 	
\u 		    uppercase character


/\%x30 		Search hexa
/\%^, /\%$	Begining and end of document                                    
/\_.		Include newline
\@!         To negate ex: /^\(\(^.*cursor.*$\)\@!.*foo.*\)$


### Quantifiers 
* 		    matches 0 or more of the preceding characters, ranges or metacharacters .* matches everything including empty line
\+ 		    matches 1 or more of the preceding characters...
\= 		    matches 0 or 1 more of the preceding characters...
\{n,m} 	    matches from n to m of the preceding characters...
\{n} 	    matches exactly n times of the preceding characters...
\{,m} 	    matches at most m (from 0 to m) of the preceding characters...
\{n,} 	    matches at least n of of the preceding characters...
\{-} 	    matches 0 or more of the preceding atom, as few as possible
\{-n,m}     	matches 1 or more of the preceding characters...
\{-n,} 	    matches at lease or more of the preceding characters...
\{-,m} 	    matches 1 or more of the preceding characters... 
                where n and m are positive integers (>0) 

### Search 

``[v``]       Reselect paste text
*, #        Search current word (backward)
g*, g#      Without word delimiter 
:noh		No hightlight search 
/word 	    word from top to bottom
?word 	    word from bottom to top

### Example 
\ze \zs     Regex start, stop
/jo[ha]n 	john or joan
/fred\|joe 	fred or joe
/\<the 		the, theatre or then
/the\> 	    the or breathe
/\<the\> 	the
/\<\d\{4}\> exactly 4 digits
/^\n\{3} 	empty lines
/\cstring   Case insensitive 
:bufdo /searchstr/ 	Search in all open files
/\<[A-Z]\+\/        or
/\v<[A-Z]+>         or 
/\<\u\+\>           Find upper case words

### Search modifiers 
/joe/e              cursor set to End of match
3/joe/e+1           find 3rd joe cursor set to End of match plus 1 [C]
/joe/s-2            cursor set to Start of match minus 2
/joe/+3             find joe move cursor 3 lines down
/.*fred\&.*joe      Search for FRED AND JOE in any ORDER!

### Substite
:range s[ubstitute]/pattern/string/cgiI 
c                   Confirm each substitution
g                   Replace all occurrences in the line (without g - only first).
i                   Ignore case for the pattern.
I                   Don't ignore case for the pattern.

:%s//\=@0           replace last search with register 0 content 
:&                  repeat last substitute cmd 
g&                  to make a replacement on all file lines ( equivalent to :%s//~/& (or :%&&) 



:%s/.*\(string_to_keep\).*/\1
:%s/\<./\u&/g 	    Sets first letter of each word to uppercase
:%s/\<./\l&/g 	    Sets first letter of each word to lowercase
:%s/.*/\u& 	        Sets first letter of each line to uppercase
:%s/.*/\l& 	        Sets first letter of each line to lowercase

:%!/^#/d            Selete lines not begining with #
^\(-*[0-9]*\.[0-9]*\s\)\{21}   
                    Match the 21 first numbers like 12232.23 23.23 
%s/^/\=line(".") . ". "/g    
                    Substitute all lines by its line number 
:4,$s/\d\+/\=submatch(0) + 1/ 
                    Add one to every number

<ESC>:%s/.*/\L&/    Tranform everything to lowar case
<ESC>:%s/.*/\U&/    Upper
/\<[A-Z]\+\/ or /\v<[A-Z]+> or /\<\u\+\> # find upper case words

:%s/.*/\L&/         Tranform everything to lowar case
:%s/.*/\U&/         Upper

:%s/\r//g 	        Delete DOS carriage returns (^M)
:%s/\r/\r/g 	    Transform DOS carriage returns in returns
:%s#<[^>]\+>##g 	Delete HTML tags but keeps text
:%s/^\(.*\)\n\1$/\1/ 	
                    Delete lines which appears twice

:s:\(\a*\a\):"\1":g \1 is like submatch(1)
:%s/identifying text \zs\d\+\(.\d\+\)\=/\=(1.15+str2float(submatch(0)))/
:%s/pattern \(saved portion\)\zs/\=SaverFunc(submatch(1))[-1]
:%call setline(line('.'),substitute(getline('.'),'foo','bar','g'))
1025,$s:^\(\d\+\.*\d*\)\s\+\(\d*\.*\d*\):\=printf("%f\t%f",submatch(1)/3.0, submatch(2) /3.0)
1025,$s:^\(\d*\)\s\+\(\d*\):\=submatch(1) . "\t" . submatch(2)*200
1025,$s:^(d*):=submatch(1)*200
:s/helo/hello/g 4   Do the substitution in the next 4 lines
:%s/^/\=line('.') . "."/g       Substitute all line with its line number


### Range 

range 
  The '< Vim mark represents the beginning line of a visual region and the '> mark represents the ending line of the visual region


# REGEX MATCH NUMBER
" Integer with - + or nothing in front
syn match celNumber '\d\+'
syn match celNumber '[-+]\d\+'

" Floating point number with decimal no E or e (+,-)
syn match celNumber '\d\+\.\d*'
syn match celNumber '[-+]\d\+\.\d*'

" Floating point like number with E and no decimal point (+,-)
syn match celNumber '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match celNumber '\d[[:digit:]]*[eE][\-+]\=\d\+'

" Floating point like number with E and decimal point (+,-)
syn match celNumber '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match celNumber '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'



POWER of G  http://vim.wikia.com/wiki/Power_of_g
:v/./,/./-j					" delete duplicates
:g/{/ .+1,/}/-1 sort    	" sort lines betwenn { and }
:g/{/ .+1,/}/-1 >       	" indeent 
:g// 						" lists all lines containing the last search pattern, and :redir will capture the results. 
:g/pattern/m$			    " Move EOF
:g/^/m0			            " Reverse file
:g/pattern/y A		        " Yank appending to reg a
:v/string_to_keep/s/.*//    "
:g/^/put _                  " Double-space your file: 
:g/^/-put ='foo'.           "Add a line containing foo before each lineThis is
    " a clever use of the expression register. Here, - is a synonym for .-1 (cf.
    " :help :range). Since :put puts the text after the line, you have to explicitly
    " tell it to act on the previous one. aa


```


## Script
*v-script.txt*              Functions, scripts

### Function 
:help functions 
:help function-list
```vim
:echo expand('<cword>')                     "return the word under cursor 
:echo expand('%:p:h')
sfrtime
:let s=input('where to jump?')
```


### EXEC 
```vim
function Func()
    command1
    command2
endfunction
exec Func() 
call Func()
echo Func()
```

### Function2Command 

```
command! -nargs=1 MyCommand call s:MyFunc(<f-args>) " transform a function to user-command
```




lcd to cd for current windwo


### Script tips


set formatoptions +=at <br>
call append(line('$'), [variable]) <br>
call append(line('$'), split(variable, "\n")) <br>
set autoread <br>
help scrool-cursor <br>
htlp winrestcmd() <br>





