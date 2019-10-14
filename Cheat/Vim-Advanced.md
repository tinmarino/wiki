---
title: Vim Advanced cheatsheet
category: Vim
css: ../Css/prism_dark.css
css: ../Css/solarized_dark.css
css: ../Css/layout_grid.css
---

## Commands

|               |   |
| ---           | --- |
| `T,c,`        | Delete between coma |
| `:b#<bar>bd#` | delete buffer |
| `C`           | = `c$`: Change to end of line |
| `S`           | = `^C`: Change from first non blank to EOL |
|               |   |

|                  |   |
| ---              | --- |
| `zl, zh, zL, zH` | Scrool horizontally |
| `'.`             | Goto last edit location |
| `g-`             | Goto last non blank character (Vs `_` or `^`) |
| `gq`motion       | Filter format |
| `g=`motion       | Filter indent |

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

### Ex one char

|               |   |
| ---           | --- |
| `:t` | Copy line to |
| `:m` | Move line |

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
