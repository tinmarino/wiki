---
title: Vim Advanced cheatsheet
category: Vim
css: ../Css/code_prism_dark.css
css: ../Css/color_dark_solarized.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
---


## Commands

### Edit
|                  |   |
| ---              | --- |
| `T,c,`           | Delete between coma |
| `:b#<bar>bd#`    | delete buffer |
| `C`              | = `c$`: Change to end of line |
| `S`              | = `^C`: Change from first non blank to EOL |
| `gq`motion       | Filter format |
| `g=`motion       | Filter indent |
| `!<motion><cmd>` | Filter <Motion> by <cmd> |

### Move
|                  |   |
| ---              | --- |
| `'.`             | Last edit location |
| `g-`             | Last non blank character (Vs `_` or `^`) |
| `gm`             | Middle of line |
| `n<bar>`         | Column n of current line |
| `ab` `aB`        | Select a block ( ), a block { } |
| `-` `+`          | line up, down on first non-blank character |

### Move cursor

|                  |   |
| ---              | --- |
| `zl, zh, zL, zH` | Scrool horizontally, one char or screen |
| `zt`, `zz`, `zb` | Cursor top middle, bottom |
| `<C-W>Z`         | `:pc[lose]`: Close previw window |
| `1gt`            | Goto tab 1 |


### Ex tips 1/2

|                             |   |
| ---                         | --- |
| `:w !sudo tee %`            | Save as root |
| `:set nrformat+=alpha`      | `<C-A>` works with alphabet chars |
| `:sort [u] [n]`             | Sort [Unique] [Numerals (so 100 after 20) |
| `:echo 5e9x20`              | Simple Math |
| `:q:`, `q/`                 | Ex, Search Windows |
| `normal @a`                 | Execute register a in this line |
| `g/{/_.+1,/-1 sort`         | Sort between { and } |
| `:sort n/\(\S\+\s\+\)\{2}/` | Sort by 2nd column |

### Ex tips 2/2

|                                     |   |
| ---                                 | --- |
| `:%s/^/\=printf('%-4d', line('.'))` | Prefix line by line number |
| `:set fo+=t`                        | Autowrap (`h formatoption`) |
| `:bro[wse] ol[dfiles][!]`           | Prompt which file to choose |
| `:earlier 12h`                      | Change file to how it was 12h ago |
| `:%! column -t`                     | align columns |
| `:syntax sync fromstart`            | Reload syntax |
| `set cul!`                          | if scrooling slow for a long line |
| `set lazyredraw`                    | can be usefull too |
| `h ttyfast`                         |   |


### Ex tips 3/2

|               |   |
| ---           | --- |
| `:v/./,/./-j` | Compress multiple blank lines into on |

### Ex tips 4/2

Some usefull function
* __Function:__ sort(list), put, getline(int), setlone(int, list) join(list), split(string), len(list), get, getpid()

* __Command:__ :retab, 

### Sort line accroding to line length

```vim
:%s/.*/\=printf("%03d", len(submatch(0)) . "|" . submatch(0)/ | sor n | %s/..../  
```

### Reverse line order
```vim
:%!tac
:%!tail -r
```
*   g/^/m0

### Man
```vim
runtime! ftplugin/man.vim
:Man 3 printf
```

### Auto cd %
```vim
set autochdir  " auto chdir to current file
:tabdo lcd /dir/
```

### Substitute without escaping the replcement
```vim
:%sno/search_string/replace_string/g
:s/</\='&lt;'/g
```

### Delete everything except text
  * `:%s/\(^\|\(text\)\@<=\).\{-}\($\|text\)\@=//g`
    ```text
    \(^\|\(text\)\@<=\)     # means start of line, or some point preceded by “text”
    .\{-}                   # as few characters as possible
    \($\|text\)\@=          # without globbing characters, checking that we reached either end of line or occurrence of “text”.
    ```
  * Another way to do it:
    * Create a function that count matches of a pattern in a string (see :help match() to help you design that)
    * Use: `:%s/.*/\=repeat('text', matchcount('text', submatch(0)))`

### Remove duplicate lines 
```vim
:g/\v^([^ -=]+)\n\_.*%(^\1$)/d
```


### Select and Search

|                                   |   |
| ---                               | --- |
| `vo`, `vO`                        | Goto other side of visual selection |
| `gv`                              | Reselect las selection |
| `g*`, `g#`                        | Search word under cursor but without delimiter |
| `/.\{-}toto`                      | Non greedy, get first occurent of toto |
| `:&`                              | Repeat las substitution |
|                                   |   |

```vim
:hi visu ctermgg=Cyan
:match visu /\%<13c/
:h /\%
```

### Binary editing

|         |   |
| ---     | --- |
| `222go` | Goto byte 222 |

#### Xxd
* `xxd` -r (reverse, from hex to string) -p (output in ps := raw) -c 8 (bytes per line) -g 1 (bytes per column)

#### No newline at end of file
*   `vim -b file` or `set binary`
*   `:set noeol` or `set nofixendofline`


### File encoding

* set fileencoding=utf-8
* set bomb
* :w ++enc=utf-8 %
* wchar encoding
  :e ++enc=utf-16
* args *

### Ctags 
  * `ctags -R -f ./.git/tags .`
  * `:tag function_name`
  * `C-}` : see all tags
  * `C-]` : jump to tag
  * `:tn | :tp` : jump to next | previous tag
  * `:ts` : tag select : get a list

## Search

### Negative regex

TODO

### Search examples

|            |   |
| ---        | --- |
| `/\%xYY`   | YY hex ord(ascii) |
| `/\%uYYYY` | hex ord(unicode) |
| `[[=a=]]   | Character (a) equivalentce class (so get à) |
| `/\I`      | Match letters in latin see `:echo &isident` |
| `s/\%V`    | Substitute within selection |
| `/\%<13c`  | Before 13 virtual column |

* French accents `/^[a-zàâçéèêëîïôûùüÿñæœ .-]*$/i`

## Vimscript

### Get|Set (ou|in)tput from ex commands

* `:!`: Get last output
*

```vim
redir @a
echo toto
redir END
```

* `let @a=getcwd()`
	
* `:@"`: Execute what is yanked

```vim
"Examples: 
":call Exec('buffers')
"This will include the output of :buffers into the current buffer.
"Also try: ":call Exec('ls')
":call Exec('autocmd')
funct! Exec(command)
    redir =>output
    silent exec a:command
    redir END
    let @o = output
    execute "put o"
endfunct! 
```

### Inspect, Debug

TODO
### Inspect syntax highlight [(link)](https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor)
```vim
map K :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
```



### Display environment

To find the script file defining a map : `:verbose map <c-z>`.
But `map` can ber replaced by:

* `abbreviate`, `autocmd`, `command`, `function`, `let`, `set all`.
* `jumps`, `marks`, `args`, `changes`
* `digraphs`, `highlight`, `reg`, `scriptnames`, `spellinfo`, `syntax

* Find where root runtime is 
  * `:echo $VIMRUNTIME` -> `/usr/share/vim/vim74`
  
* Source autoload file
  * `:call example#BadFunction()`

#### Get filetype of a buffer
	* `:let bufFiletype = getbufvar(bufNr, '&filetype')`

#### Show highlight sytnax type
  * `:echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')`

#### Get filetype of a buffer
  * `:let bufFiletype = getbufvar(bufNr, '&filetype')`



### Vimrc tips

* `:au FileTypepyrhon setlocal formatprg=autopep8\ -`
* `xnoremap p pgvy` : Copy without yanking selection in visual

### Vimrc: GVim Remove useless bars

```vim
:set guioptions-=m " remove menu bar
:set guioptions-=T " remove toobar
:set guioptions-=r " remove right hand scrool bar 
:set guioptions-=L " remove lefthand scrooll bar
```




## Ex one char


### Ex 1 char (1/3)

|       |   |
| ---   | --- |
| `ab`  | abbrev |
| `a`   | append |
| `ar`  | args |
| `c`   | change |
| `co`  | copy |
| `t`   | Copy line to |
| `d`   | delete |
| `e`   | edit |
| `f`   | file |
| `g`   | global |
| `i`   | insert |
| `j`   | join |
| `l`   | list |
| `maa` | map |
| `ma`  | mark |

### Ex 1 char (2/3)

|       |   |
| ---   | --- |
| `m`   | move |
| `n`   | next |
| `nu`  | number |
| `o`   | open |
| `pre` | preserve |
| `p`   | print |
| `pu`  | put |
| `q`   | quit |
| `re`  | read |
| `rec` | recover |
| `rew` | rewind |
| `se`  | set |
| `sh`  | shell |
| `so`  | source |
| `st`  | stop |

### Ex 1 char (3/3)

|       |   |
| ---   | --- |
| `s`   | substitute |
| `una` | unabbrev |
| `u`   | undo |
| `unm` | unmap |
| `ve`  | version |
| `vi`  | visual |
| `w`   | write |
| `x`   | xit |
| `ya`  | yank |
| `z`   | window |
| `!`   | escape |
| `CR`  | print next |
| `&`   | resubst |
| `>`   | rshift |
| `^D`  | scroll |


## Command line

* `vim -u NONE -N` # No (User) vimrc, Non-compatible

### Pipe

* `echo toto | vim -` : take arguments from stdin
* `echo foo | vim -e '+%print' '+q!' /dev/stdin` : exmode to not consume stdin and not clear output on quit
* `vim <(echo toto)` : process substitution command (BaSh)
* `:w !tee` : write to stdout
* `:w !sh` : write to shell input


### Remote 
```bash
vim --servername DEMO
vim --servername DEMO --remote file.txt
vim --servername DEMO  --remote-send ":3d<CR>"
:!vim --servername DEMO --remote-tab "%"   " Send current buffer to remote vim
```

__Dos2Unix__: `for file in * ; do vi +':w ++ff=unix' +':q' $file`  

### C-s

* Can lock the terminal : <c-q> to unlock
* stty -ixon # for a permanent solution


<script src="../Css/js_prism_vim.js"></script>
