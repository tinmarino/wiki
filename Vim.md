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
