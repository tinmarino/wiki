[TOINSTALL](TOINSTALL)

	

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
