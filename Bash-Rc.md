
#avoid c-s freezing
#Under UNIX/Linux, in a console or terminal, CTRL-S sends the signal SIGSTOP, which stops the process in foreground until SIGCONT is sent; this is done by CTRL-Q
stty -ixon
