---
title: Vim scripting
category: Vim
prism_languages: [vim]
layout: 2017/sheet
updated: 2017-08-30
weight: -10
tags: [Featurable]
---


:::::::::::::: {.parent}

## A Heading 2

::::::::::: {.h3-sections}
### TEst fir item

item 1 There is Some code here

You can either put this in a script (`script.vim`) and run it (`:source script.vim`), or you can type the commands individually in normal mode as `:let` and `:echo`.
```language-vim
for s in list " a loong - a long  - a long  - a long  - a long  - a long  - a long  - a long 
  echo s 
  continue  " jump to start of loop a long - a long - a long - a long - a long - a long -
  break     " breaks out of a loop
endfor
```

:::::::::::
::::::::::: {.h3-sections}
### TEst fir item

item 1 There is no code here jsut TODO and stuff higlighted (maybe)

item 2 There is no code here jsut TODO and stuff higlighted (maybe)

You can either put this in a script (`script.vim`) and run it (`:source script.vim`), or you can type the commands individually in normal mode as `:let` and `:echo`.

:::::::::::
::::::::::: {.h3-sections}
### Start hacking

```language-vim
let name = "John"
echo "Hello, " . name
```

You can either put this in a script (`script.vim`) and run it (`:source script.vim`), or you can type the commands individually in normal mode as `:let` and `:echo`.

:::::::::::
::::::::::: {.h3-sections}
### Learn by example

```language-vim
function! SuperTab()
  let l:part = strpart(getline('.'),col('.')-2,1)
  if (l:part=~'^\W\?$')
      return "\<Tab>"
  else
      return "\<C-n>"
  endif
endfunction

imap <Tab> <C-R>=SuperTab()<CR>
```

[Here](http://www.vimbits.com/bits/46)'s another example with [functions](#functions), [variables](#variables) and [mapping](#mapping).




:::::::::::

## Variables

::::::::::: {.h3-sections}
### Defining

```language-vim
let var = "hello"
```

:::::::::::
::::::::::: {.h3-sections}
### Variable prefixes

```language-vim
let g:ack_options = '-s -H'    " g: global
let s:ack_program = 'ack'      " s: local (to script)
let l:foo = 'bar'              " l: local (to function)
```

The `s:` prefix is also available in function names. See `:help local-variables`

:::::::::::
::::::::::: {.h3-sections}
### Other prefixes

```language-vim
let w:foo = 'bar'    " w: window
let b:state = 'on'   " b: buffer
let t:state = 'off'  " t: tab
echo v:var           " v: vim special
```

```language-vim
let @/ = ''          " @  register (this clears last search pattern)
echo $PATH           " $  env
```

:::::::::::
::::::::::: {.h3-sections}
### Vim options

```language-vim
echo 'tabstop is ' . &tabstop
if &insertmode
echo &g:option
echo &l:option
```

Prefix Vim options with `&`

:::::::::::
::::::::::: {.h3-sections}
### Operators

```language-vim
a + b             " numbers only!
'hello ' . name   " concat
```

```language-vim
let var -= 2
let var += 5
let var .= 'string'   " concat
```

:::::::::::
## Strings

::::::::::: {.h3-sections}
### Strings

```language-vim
let str = "String"
let str = "String with \n newline"

let literal = 'literal, no \ escaping'
let literal = 'that''s enough'  " double '' => '

echo "result = " . re   " concatenation
```

Also see `:help literal-string` and `:help expr-quote`.
See: [Strings](http://learnvimscriptthehardway.stevelosh.com/chapters/26.html)

:::::::::::
::::::::::: {.h3-sections}
### String functions

```language-vim
strlen(str)    " length
len(str)       " same
strchars(str)  " character length

split("one two three")       "=> ['one', 'two', 'three']
split("one.two.three", '.')  "=> ['one', 'two', 'three']

join(['a', 'b'], ',')  "=> 'a,b'

tolower('Hello')
toupper('Hello')
```

Also see `:help functions`
See: [String functions](http://learnvimscriptthehardway.stevelosh.com/chapters/27.html)

:::::::::::
## Functions

::::::::::: {.h3-sections}
### Functions

```language-vim
" prefix with s: for local script-only functions
function! s:Initialize(cmd, args)
  " a: prefix for arguments
  echo "Command: " . a:cmd

  return true
endfunction
```

See: [Functions](http://learnvimscriptthehardway.stevelosh.com/chapters/23.html)

:::::::::::
::::::::::: {.h3-sections}
### Namespacing

```language-vim
function! myplugin#hello()
```

:::::::::::
::::::::::: {.h3-sections}
### Calling functions

```language-vim
call s:Initialize()
call s:Initialize("hello")
```

:::::::::::
::::::::::: {.h3-sections}
### Consuming return values

```language-vim
echo "Result: " . s:Initialize()
```

:::::::::::
::::::::::: {.h3-sections}
### Abortable

```language-vim
function! myfunction() abort
endfunction
```

Aborts when an error occurs.

:::::::::::
::::::::::: {.h3-sections}
### Var arguments

```language-vim
function! infect(...)
  echo a:0    "=> 2
  echo a:1    "=> jake
  echo a:2    "=> bella

  for s in a:000  " a list
    echon ' ' . s
  endfor
endfunction

infect('jake', 'bella')
```

See `:help function-argument`.  See: [Var arguments](http://learnvimscriptthehardway.stevelosh.com/chapters/24.html)

:::::::::::
## Loops

::::::::::: {.h3-sections}
```language-vim
for s in list
  echo s
  continue  " jump to start of loop
  break     " breaks out of a loop
endfor
```

```language-vim
while x < 5
endwhile
```

:::::::::::
## Custom commands

::::::::::: {.h3-sections}
### Custom commands

```language-vim
command! Save :set fo=want tw=80 nowrap
```

Custom commands start with uppercase letters. The `!` redefines a command if it already exists.

:::::::::::
::::::::::: {.h3-sections}
### Commands calling functions

```language-vim
command! Save call <SID>foo()
```

```language-vim
function! s:foo()
  ...
endfunction
```

:::::::::::
::::::::::: {.h3-sections}
### Commands with arguments

```language-vim
command! -nargs=? Save call script#foo(<args>)
```

| What | What |
| ---- | ---- |
| `-nargs=0` | 0 arguments, default |
| `-nargs=1` | 1 argument, includes spaces |
| `-nargs=?` | 0 or 1 argument |
| `-nargs=*` | 0+ arguments, space separated |
| `-nargs=+` | 1+ arguments, space reparated |

Flow
----

:::::::::::
::::::::::: {.h3-sections}
### Conditionals

```language-vim
let char = getchar()
if char == "\<LeftMouse>"
  " ...
elseif char == "\<RightMouse>"
  " ...
else
  " ...
endif
```

:::::::::::
::::::::::: {.h3-sections}
### Truthiness

```language-vim
if 1 | echo "true"  | endif
if 0 | echo "false" | endif
```

```language-vim
if 1       "=> 1 (true)
if 0       "=> 0 (false)
if "1"     "=> 1 (true)
if "456"   "=> 1 (true)
if "xfz"   "=> 0 (false)
```

No booleans. `0` is false, `1` is true.
See: [Truthiness](http://learnvimscriptthehardway.stevelosh.com/chapters/21.html)

:::::::::::
::::::::::: {.h3-sections}
### Operators

```language-vim
if 3 > 2
if a && b
if (a && b) || (c && d)
if !c
```

See `:help expression-syntax`.
See: [Operators](http://learnvimscriptthehardway.stevelosh.com/chapters/22.html)

:::::::::::
::::::::::: {.h3-sections}
### Strings

```language-vim
if name ==# 'John'     " case-sensitive
if name ==? 'John'     " case-insensitive
if name == 'John'      " depends on :set ignorecase

" also: is#, is?, >=#, >=?, and so on
```

:::::::::::
::::::::::: {.h3-sections}
### Identity operators

```language-vim
a is b
a isnot b
```

Checks if it's the same instance object.

:::::::::::
::::::::::: {.h3-sections}
### Regexp matches

```language-vim
"hello" =~ '/x/'
"hello" !~ '/x/'
```

:::::::::::
::::::::::: {.h3-sections}
### Single line

```language-vim
if empty(a:path) | return [] | endif
a ? b : c
```

Use `|` to join lines together.

:::::::::::
::::::::::: {.h3-sections}
### Boolean logic

```language-vim
if g:use_dispatch && s:has_dispatch
  ···
endif
```

:::::::::::
## Lists

::::::::::: {.h3-sections}
### Lists

```language-vim
let mylist = [1, two, 3, "four"]

let first = mylist[0]
let last  = mylist[-1]

" Suppresses errors
let second = get(mylist, 1)
let second = get(mylist, 1, "NONE")
```

:::::::::::
::::::::::: {.h3-sections}
### Functions

```language-vim
len(mylist)
empty(mylist)

sort(list)
let sortedlist = sort(copy(list))

split('hello there world', ' ')
```

:::::::::::
::::::::::: {.h3-sections}
### Concatenation

```language-vim
let longlist = mylist + [5, 6]
let mylist += [7, 8]
```

:::::::::::
::::::::::: {.h3-sections}
### Sublists

```language-vim
let shortlist = mylist[2:-1]
let shortlist = mylist[2:]     " same

let shortlist = mylist[2:2]    " one item
```

:::::::::::
::::::::::: {.h3-sections}
### Push

```language-vim
let alist = [1, 2, 3]
let alist = add(alist, 4)
```

:::::::::::
::::::::::: {.h3-sections}
### Map

```language-vim
call map(files, "bufname(v:val)")  " use v:val for value
call filter(files, 'v:val != ""')
```

:::::::::::
## Dictionaries

::::::::::: {.h3-sections}
### Dictionaries

```language-vim
let colors = {
  \ "apple": "red",
  \ "banana": "yellow"
}

echo colors["a"]
echo get(colors, "apple")   " suppress error
```

See `:help dict`

:::::::::::
::::::::::: {.h3-sections}
### Using dictionaries

```language-vim
remove(colors, "apple")
```

```language-vim
" :help E715
if has_key(dict, 'foo')
if empty(dict)
keys(dict)
len(dict)
```

```language-vim
max(dict)
min(dict)
```

```language-vim
count(dict, 'x')
string(dict)
```

```language-vim
map(dict, '<>> " . v:val')
```

:::::::::::
::::::::::: {.h3-sections}
### Iteration

```language-vim
for key in keys(mydict)
  echo key . ': ' . mydict(key)
endfor
```

:::::::::::
::::::::::: {.h3-sections}
### Prefixes

```language-vim
keys(s:)
```

Prefixes (`s:`, `g:`, `l:`, etc) are actually dictionaries.

:::::::::::
::::::::::: {.h3-sections}
### Extending

```language-vim
" Extending with more
let extend(s:fruits, { ... })
```

:::::::::::
## Casting

::::::::::: {.h3-sections}
```language-vim
str2float("2.3")
str2nr("3")
float2nr("3.14")
```

:::::::::::
## Numbers

::::::::::: {.h3-sections}
### Numbers

```language-vim
let int = 1000
let int = 0xff
let int = 0755   " octal
```

See `:help Number`.
See: [Numbers](http://learnvimscriptthehardway.stevelosh.com/chapters/25.html)

:::::::::::
::::::::::: {.h3-sections}
### Floats

```language-vim
let fl = 100.1
let fl = 5.4e4
```

See `:help Float`

:::::::::::
::::::::::: {.h3-sections}
### Arithmetic

```language-vim
3 / 2     "=> 1, integer division
3 / 2.0   "=> 1.5
3 * 2.0   "=> 6.0
```

:::::::::::
::::::::::: {.h3-sections}
### Math functions

```language-vim
sqrt(100)
floor(3.5)
ceil(3.3)
abs(-3.4)

sin() cos() tan()
sinh() cosh() tanh()
asin() acos() atan()
```

:::::::::::
## Vim-isms

::::::::::: {.h3-sections}
### Execute a command

```language-vim
execute "vsplit"
execute "e " . fnameescape(filename)
```

Runs an ex command you typically run with `:`. Also see `:help execute`.
See: [Execute a command](http://learnvimscriptthehardway.stevelosh.com/chapters/28.html)

:::::::::::
::::::::::: {.h3-sections}
### Running keystrokes

```language-vim
normal G
normal! G   " skips key mappings

execute "normal! gg/foo\<cr>dd"
```

Use `:normal` to execute keystrokes as if you're typing them in normal mode. Combine with `:execute` for special keystrokes.
See: [Running keystrokes](http://learnvimscriptthehardway.stevelosh.com/chapters/29.html)

:::::::::::
::::::::::: {.h3-sections}
### Getting filenames

```language-vim
echo expand("%")      " path/file.txt
echo expand("%:t")    " file.txt
echo expand("%:p:h")  " /home/you/path/file.txt
echo expand("%:r")    " path/file
echo expand("%:e")    " txt
```

See `:help expand`

:::::::::::
::::::::::: {.h3-sections}
### Silencing

```language-vim
silent g/Aap/p
```

Suppresses output. See `:help silent`

:::::::::::
::::::::::: {.h3-sections}
### Echo

```language-vim
echoerr 'oh it failed'
echomsg 'hello there'
echo 'hello'

echohl WarningMsg | echomsg "=> " . a:msg | echohl None
```


:::::::::::
::::::::::: {.h3-sections}
### Settings

```language-vim
set number
set nonumber
set number!     " toggle
set numberwidth=5
set guioptions+=e
```

:::::::::::
::::::::::: {.h3-sections}
### Prompts

```language-vim
let result = confirm("Sure?")
execute "confirm q"
```

:::::::::::
::::::::::: {.h3-sections}
### Built-ins

```language-vim
has("feature")  " :h feature-list
executable("python")
globpath(&rtp, "syntax/c.vim")

exists("$ENV")
exists(":command")
exists("variable")
exists("+option")
exists("g:...")
```

:::::::::::
## Mapping

::::::::::: {.h3-sections}
### Mapping commands

```language-vim
nmap
vmap
imap
xmap
nnoremap
vnoremap
inoremap
xnoremap
...
```

:::::::::::
::::::::::: {.h3-sections}
### Explanation

```language-vim
[nvixso](nore)map
```

```
 │       └ don't recurse
 │
 └ normal, visual, insert,
   eX mode, select, operator-pending
```

:::::::::::
::::::::::: {.h3-sections}
### Arguments

| `<buffer>` | only in current buffer |
| `<silent>` | no echo |
| `<nowait>` | |

:::::::::::
## Syntax

::::::::::: {.h3-sections}
### Highlights

```language-vim
hi Comment
  term=bold,underline
  gui=bold
  ctermfg=4
  guifg=#80a0ff
```

:::::::::::
::::::::::: {.h3-sections}
### Filetype detection

```language-vim
augroup filetypedetect
  au! BufNewFile,BufRead *.json setf javascript
augroup END

au Filetype markdown setlocal spell
```

:::::::::::
::::::::::: {.h3-sections}
### Conceal

```language-vim
set conceallevel=2
syn match newLine "<br>" conceal cchar=}
hi newLine guifg=green
```

:::::::::::
::::::::::: {.h3-sections}
### Region conceal

```language-vim
syn region inBold concealends matchgroup=bTag start="<b>" end="</b>"
hi inBold gui=bold
hi bTag guifg=blue
```

:::::::::::
::::::::::: {.h3-sections}
### Syntax

```language-vim
syn match :name ":regex" :flags

syn region Comment  start="/\*"  end="\*/"
syn region String   start=+"+    end=+"+	 skip=+\\"+

syn cluster :name contains=:n1,:n2,:n3...

flags:
  keepend
  oneline
  nextgroup=
  contains=
  contained

hi def link markdownH1 htmlH1
```

:::::::::::
::::::::::: {.h3-sections}
### Include guards

```language-vim
if exists('g:loaded_myplugin')
  finish
endif

" ...

let g:loaded_myplugin = 1
```

:::::::::::
::::::::::::::

<script src="prism_vim_dark.js"></script>
