---
title: Vim Advanced cheatsheet
category: Vim
css: ../Css/code_prism_dark.css
css: ../Css/color_dark_solarized.css
css: ../Css/layout_grid.css
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
| `zl, zh, zL, zH` | Scrool horizontally |
| `'.`             | Last edit location |
| `g-`             | Last non blank character (Vs `_` or `^`) |
| `gm`             | Middle of line |
| `n<bar>`         | Column n of current line |
| `ab` `aB`        | Select a block ( ), a block { } |
| `-` `+`          | line up, down on first non-blank character |

### Ex tips

|               |   |
| ---           | --- |
| `:w !sudo tee %`       | Save as root |
| `:set nrformat+=alpha` | `<C-A>` works with alphabet chars |
| `:sort [u] [n]`        | Sort [Unique] [Numerals (so 100 after 20) |
| `:echo 5e9x20`         | Simple Math |
| `:q:`, `q/`            | Ex, Search Windows |
| `normal @a`            | Execute register a in this line |
| `g/{/_.+1,/-1 sort`    | Sort between { and } |

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



### Search and Select

| `vo`, `vO`   | Goto other side of visual selection |
| `gv`         | Reselect las selection |
| `g*`, `g#`   | Search word under cursor but without delimiter |
| `/.\{-}toto` | Non greedy, get first occurent of toto |
| `:&`         | Repeat las substitution |
|              |   |



## Search

### Negative regex

TODO

### Search examples

/\%xYY					# YY hex ord(ascii)
/\%uYYYY				# YYYYY hex ord(unicode)

## Vimscript

### Get output from ex commands

* Command stdout redirection
	:!		# get last output
	redir @a
	echo toto
	redir END
	let @a=getcwd() 
	
### Set input to ex

:@"						# Execute what is yanked

### Inspect, Debug



### Display environment

To find the script file defining a map : `:verbose map <c-z>` . But `map` can ber replaced by: `abbreviate`, `autocmd`, `command`, `function`, `let`, `set all`.

* Script : Get filetype of a buffer
	* `:let bufFiletype = getbufvar(bufNr, '&filetype')`

## Command line

`vim -u NONE -N` # No (User) vimrc, Non-compatible

* Pipeline
	* `echo toto | vim -` : take arguments from stdin
	* `echo foo | vim -e '+%print' '+q!' /dev/stdin` : exmode to not consume stdin and not clear output on quit
	* `vim <(echo toto)` : process substitution command (BaSh)
	* `:w !tee` : write to stdout
  * `:w !sh` : write to shell input

| digraphs    | digraphs |
| highlight   | highlight groups |
| reg         | registers |
| scriptnames | all scripts sourced so far |
| spellinfo   | spellfiles used |
| syntax      | syntax items |

* Remote 
	vim --servername DEMO
	vim --servername DEMO --remote file.txt
	vim --servername DEMO  --remote-send ":3d<CR>"
	:!vim --servername DEMO --remote-tab "%"   " Send current buffer to remote vim
