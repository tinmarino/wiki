\(External.*\)\@<!mem


[TOINSTALL](TOINSTALL)

*	[Practical_Vim](Practical_Vim)
* 	[Vimstyle](Vimstyle) (from Google)
*   [VimStory](VimStory)
* 	[BordelVim](BordelVim)
* 	[CheatVim](CheatVim)
* [Environment](V-Environment)
* 	[Plugin](Plugin)
* 	[Tips](Tips)

## From work

*   `set cul!` if scrooling slow for a long line
*   `set lazyredraw` can be usefull too
*   h ttyfast
*   222go  go to byte 222

## No newline at end of file

*   `vim -b file` or `set binary`
*   `:set noeol` or `set nofixendofline`

## Environment

* echo $PATH
* let myvar = $PATH
* let $PATH = '/foo:/bar'
* i<c-r>=$PATH


## C-s

* Can lock the terminal : <c-q> to unlock
* stty -ixon # for a permanent solution

## GVim

:set guioptions-=m " remove menu bar
:set guioptions-=T " remove toobar
:set guioptions-=r " remove right hand scrool bar 
:set guioptions-=L " remove lefthand scrooll bar

Note: 'go' is an abbr for guioptions

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



