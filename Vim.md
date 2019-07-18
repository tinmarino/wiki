* [Vim Menu](Vim-Menu)

* [Tips](Tips) : advanced commands

# Tips

* Show highlight sytnax type
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

* Check variable, set default
	let g:pluginname_setting = get(g: | 'pluginname_setting', "default")
	if exists('g:pymode') | echo 'exists' | endif

* Copy without yanking selection in visual
	xnoremap p pgvy`

* Read man files
	runtime! ftplugin/man.vim  an Man 3 printf

* Script : Get filetype of a buffer
	:let bufFiletype = getbufvar(bufNr, '&filetype')

* Substitute without escaping the replcement
  * `:%sno/search_string/replace_string/g`
  * `:s/</\='&lt;'/g`

* Delete everything except text
  * `:%s/\(^\|\(text\)\@<=\).\{-}\($\|text\)\@=//g`
  *
    ```
    \(^\|\(text\)\@<=\)     # means start of line, or some point preceded by “text”
    .\{-}                   # as few characters as possible
    \($\|text\)\@=          # without globbing characters, checking that we reached either end of line or occurrence of “text”.
    ```
  * Another way to do it:

  * Create a function that count matches of a pattern in a string (see :help match() to help you design that)
  * Use: :%s/.*/\=repeat('text', matchcount('text', submatch(0)))


* Find where root runtime is 
	* `:echo $VIMRUNTIME` -> `/usr/share/vim/vim74`
	
* Source autoload file
	* `:call example#BadFunction()`

* Find where a map has been defined (in which script)
	* `:verbose map <c-z>` 

* Use `s/\%V` to substitude within selection and not full lines

:h formatoptions  :set fo+=t # to autowrap
:match visu /\%7l\|%10l/
:hi visu ctermbg=darked

## Client -- Server
	vim --servernbame DEMO		# Open with name DEMO
	vim --servername DEOM --remote some-file.txt  # Send some file
	vim --servername DEMO --remote-send ':3d<CR>' # Send command
	

## Fast buffer switching
	* `:oldfiles`
	* `:bro[wse] ol[dfiles] [!]`
	* `:changes`
	* `'0 '1 '2 '3 ... '9`
	* `CtrlP` pluggin

## Ctags 
	* `ctags -R -f ./.git/tags .`
	* `:tag function_name`
	* `C-}` : see all tags
	* `C-]` : jump to tag
	* `:tn | :tp` : jump to next | previous tag
	* `:ts`	: tag select : get a list

## From work

* `:%! clumn -t` align columns
* set fileencoding=utf-8
* set bomb
* :w ++enc=utf-8 %
* args *
* wchar encoding
  :e ++enc=utf-16
*	`1gt` goto tab 1
*   `set cul!` if scrooling slow for a long line
*   `set lazyredraw` can be usefull too
*   h ttyfast
*   222go  go to byte 222

### Work with binary
	xxd -r 		# reverse
		-p		
		-c56
		-g 1 	# bytes per line


### Save with sudo
*   `:w !sudo tee %


### Sort lines according to line length
*   :%s/.*/\=printf("%03d", len(submatch(0)) . "|" . submatch(0)/ | sor n | %s/..../  
    To sort all lines according to line lenght, otherwise, use awk with filter
    
    
### Reverse line order
*   :%!tac
*   :%!tail -r
*   g/^/m0


### No newline at end of file
*   `vim -b file` or `set binary`
*   `:set noeol` or `set nofixendofline`

### Environment

* echo $PATH
* let myvar = $PATH
* let $PATH = '/foo:/bar'
* i<c-r>=$PATH


### C-s

* Can lock the terminal : <c-q> to unlock
* stty -ixon # for a permanent solution

### GVim

:set guioptions-=m " remove menu bar
:set guioptions-=T " remove toobar
:set guioptions-=r " remove right hand scrool bar 
:set guioptions-=L " remove lefthand scrooll bar

Note: 'go' is an abbr for guioptions

### Plugin

#### Ctrlp

* `let g:ctrlp_cache_dir = $HOME . '/cache/ctrlp'`

## FRom before

set autochdir to auto chdir to current file
:tabdo lcd /dir/
Another useful setting is set tags=./tags,tags;$HOME which tells Vim to look
    for a tags file in the directory of the current file, then in the "current
    directory" and up and up until it reaches your ~/. 
getpid()
vim —cmd 'cd `pwd`'
	

CTRL-W z        CTRL-W_z
CTRL-W CTRL-Z   CTRL-W_CTRL-Z
:pc :pclose
:pc[lose][!]    Close any "Preview" window currently open.  When the 'hidden'
                option is set, or when the buffer was changed and the [!] is
                used, the buffer becomes hidden (unless there is another
                window editing it).  The command fails if any "Preview" buffer
                cannot be closed.  See also :close.

:earlier 12h
:help undo-branches
Gundo | undotree

Paste stay on place
The safest way without destroying a register is to do the following:

p`[

If you want to create a shortcut, just use any of vim's map functions that are suitable for you, eg:

noremap p p`[



-> h iskeyword /\k /[:alpha:] [:alnum:]

Something likelet $vimfiles = "c:\\ldigas-home\\gvim72\\vim\\vimfiles"so when I go cd $vimfiles  it puts me inc:\ldigas-home\gvim72\\vim\vimfilesOr did you have so



set shell=/bin/bash\ -i

Vim's default CTRL-T is a good alternative to mashing CTRL-O, because it is coarser grained: it moves back through tag jumps only

Exec cmd
"Examples: ":call Exec('buffers') "This will include the output of :buffers into the current buffer. " "Also try: ":call Exec('ls') ":call Exec('autocmd') " funct! Exec(command) redir =>output silent exec a:command redir END let @o = output execute "put o" endfunct! 

:'<,'>:w !command<CR>
:'<,'>!command<CR>



[](-)> h iskeyword /\k /[:alpha:] [:alnum:]


vi <(man $1)
man ls | vi -
runtime! ftplugin/man.vim
:Man 3 printf

CTRL-W z        CTRL-W_z
CTRL-W CTRL-Z   CTRL-W_CTRL-Z
:pc :pclose
:pc[lose][!]    Close any "Preview" window currently open.  When the 'hidden'
                option is set, or when the buffer was changed and the [!] is
                used, the buffer becomes hidden (unless there is another
                window editing it).  The command fails if any "Preview" buffer
                cannot be closed.  See also :close.
				
				
				
# Q / A

## How to trace back all changes done to file during the day
	:earlier 12h
	There are also plugins like Gundo and undotree.vim, which visualize the undo tree and allow to navigate it.



TEXT object
vimtextobject for function argument
vim-indent-obejct for indent



