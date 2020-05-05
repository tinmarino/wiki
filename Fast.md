
JOBS                                                   *mlinux-cd* *mlinux-jobs*

This resume the work, commands I discover while trying to cd to vim's pwd when
pressing <c-z> and fg

JOBS ~
jobs -l

IPC (Inter-Process-Communication) ~
/proc/{PID}/cwd         is as symlink the pwd of the current process 
bash 
    local -i PID=${${${(s.:.)${(v)jobstates[1]}}[3]}%\=*}
    cd $(readlink /proc/$PID/cwd)
alias fg="$VIM --remote-send ':cd $PWD<CR>'; fg"
xdotool 
kill -l  # to see the trap list
    # 20 for ctrl-z sigstp
!./ttyecho -n /dev/pts/22 "echo hello"
-> Give to me the write to read and write at tty or ioctl 
disown %2
gdb retpy tmux screen to reatach 
 :e **/palette.cpp
stty -a show shell shortcut for SIGNALS
kill -SIGSTOP `vim > /dev/pts/22`
exec vi (rplace shell by vim last shell command)
REad : export PROMPT_COMMAND="ls -a > /dev/pts/23"
echo -en '\x12\x02' > /dev/ttyS0
sudo chmod o-rw /dev/tty23
open /usr/share/doc/base-passwd/users-and-groups.html
( echo $$; echo $BASHPID )
$$ -> Expands to the process ID of the (current) shell.
$! -> Expands to the process ID of the most recently executed background command.
ps ax | grep pts/16
ps -f ax | grep pts/16
ps --ppid $$ -o CMD
PROMPT_COMMAND is the key
truncate -s 0 filename
>filename
or tail -n +2
# shell -> vim 
alias fg="$VIM --remote-send ':cd $PWD<CR>'; fg"
On resume :cd $PWD
$ sleep 42 &
 [1] 5260
 $ echo $!
 5260

