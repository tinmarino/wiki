* [Sed](Sed)
* [Awk](Awk)
* [Readline](Readline)
* [Tmux](Tmux)
* [Screen](Screen)
* [Dialog](Dialog)
* [Termux](Termux)
* [Git](Git)
* [Gcc](Gcc)
* [Pentest](Pentest)
* [Imagemagick](Imagemagick)
* [BusyBox](BusyBox)
* [W3m](W3m)

* Files (Read, get specific info)
  * /proc/sys/vm/block_dump  # echo 1 lgos IO; then tail -f /var/log/syslog
  * /proc/[pid]/io
  * /proc/net/dev
  * /sys/class/net/${interface}/statistics/ 



* Xrand
  redshift
  xrandr -q | grep " connected"  # gives me LVDS1
  xrandr --output LVDS1 --brightness 0.5
  xbacklight -set 50
  xbacklight -inc 10
  xbacklight -dec 10 
  echo 400 | sudo tee /sys/class/backlight/intel_backlight/brightness

* Module (kernel)
    depmod - handle dependency descriptions for loadable kernel modules.
    insmod - install loadable kernel module.
    lsmod - list loaded modules.
    modinfo - display information about a kernel module.
    modprobe - high level handling of loadable modules.
    rmmod - unload loadable modules.

* User Rights, Capabilities
  visudo

# File
* /etc/resolv.conf
* /etc/nework/interface
* /etc/hosts
* /etc/mailname
* /etc/hostname


* tail -f
* apt --allow-unauthentificated
* cat | xargs grep
* find . -type f -size +10M
* grep -Po '[^[:digit:]]'
* grep -A 1 print 1 line before
* grep -B 1 print 1 line before
* grep -C 3 print 3 lines before and after
* grep --include=*.txt
* cat toto.txt | grep -arnobUP "\xCA\xCA"
* echo "conbtent" | mail -s "subject" user@email.com
* find . -maxdepth 1 -exec grep foo {}

* Hybernate
  sudo pm-hibernate
  sudo systemctl hibernate

* Move mouse
  tmux send-key -t session:pane ls
  tput - initialize a terminal or query terminfo database
    - color output
  xdotool - send keystrokes

* Screen off
  xset dpms force off

*  Tar   
  tar - cvf tecmint-14-09-12.tar /home/tecmint/
  tar cvzf MyImages-14-09-12.tar.gz /home/MyImages
      c – Creates a new .tar archive file.
      v – Verbosely show the .tar file progress.
      f – File name type of the archive file.
      z - Compress
  tar -xvf thumbnails-14-09-12.tar.gz
  tar -zxvf tar-archive-name.tar.gz 

*   Remotely move mouse : `xdotool`
  ```
  #! /bin/bash
  # move the mouse  x    y
  xdotool mousemove 1800 500
  # left click
  xdotool click 1
  # right click
  xdotool click 3
  ```

*  List device UUID
  ls /dev:disk/by_uuid

*   Find file (and print only finle name)
    * `find /dir1 -type f -printf "%f\n"`
    * `find ./dir1 -type f -exec basename {} \;`  # If no printf 

*   Remove windows line ending
  * `tr -d '\15\32' < winfile.txt >  unixfile.txt`
  * `tr -d "\r" < file`
  * `vi -c '%s/^M//g` # use ctrl-v ctrl-m to insert the `^M`
  * `sed 's/\x0D$//'`
  * `find ./ -type f -exec dos2unix {} \;`
  * `awk '{ sub("\r$",""); print }' dos.txt > unix.txt`


*   List signals shortcuts
  *   `stty -a`

* bc 
  * `echo "ibase=16;FF" | bc`
  * 

* expr 10 + 10


*   List all users, groups
  *  `groups`
  *  `cut -d: -f1 /etc/passwd`

*   Mem : If no screen
    *   `df`  list mount points 


*linux.txt*                 Linux Memories, Usefull when no screen or connection
                          Can become ugly 

df  # list mount points 




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


### Jobs and Processes

`jobs -l`   
`disown %2`  
`kill -l`  # to see the trap list  
`exec vi` # replace the shell by vim => destroy the shell)
`tty` # to get my tty (of course)  
`stty -a` # show shell shortcut for SIGNALS  
`echo $$; echo $BASHPID` # Get my (shell) pid
`$$` -> Expands to the process ID of the (current) shell.  
`$!` -> Expands to the process ID of the most recently executed background command.  
`$PROMPT_COMMAND` To automate cmds  
`disown -h %<jobid>` # After that, you can safely exit the terminal


`/proc/{PID}/cwd`         is as symlink the pwd of the current process   
```  
" Send commadn to oter terminal (shell)  
A: mkfifo mypipe  
A: eval $(cat mypipe)  
B: echo "ls" > mypipe  
vi Mem/vim; eval $(cat /tmp/ttypipe21)  
```
   


#### Ps

`ps ax | grep pts/16`  
`ps -f ax | grep pts/16`  
`ps --ppid $$ -o CMD`  




#### Change default

/usr/share/gnome/applications/defaults.list  
touch ~/.local/share/applications/defaults.list  
touch ~/.local/share/applications/mimeapps.list  
mimetype img.jpg   
  
// Get current font   
gsettings get org.gnome.desktop.interface monospace-font-name  
  
gconftool-2 --get /apps/gnome-terminal/profiles/Unnamed/font  
gconftool-2 --set /apps/gnome-terminal/profiles/Unnamed/font --type string "courier new 12"  


#### Mouse

sudo modprobe -r psmouse  
sudo modprobe psmouse proto=imps  


### Par (format text with indent and hard-wrap)

```
    w - specify line length
    r - repeat characters in bodiless lines (empty line "" -> "    "
    j - justifies text (add extra spaces to end at same point)
    e - remove ‘superflous’ lines
    q - handle nested quotations in plaintext email
    f - fit: good argumnent for all lines to be good len (even th first; 
      protected one
```


