% BASH Bourne Again SHell

[Bash HackerRank](Bash-HackerRank)
[Bash Rc](Bash-Rc)
[Bash_Snippet](Bash_Snippet.md)
[Bash_Cheatsheet](Bash_Cheatsheet.sh)
[Bash_Quizz](Bash_Quizz.md)
[Bash_Dump](Bash_Dump.md)


```bash
# Repeat string
printf '=%.0s' {1..100}

# Array map append to each elt (and prepend)
array=( "${array[@]/%/_content}" )
array=( "${array[@]/#/prefix_}" )

# Remove duplicate lines while keeping the order of the lines
# From https://unix.stackexchange.com/questions/194780/remove-duplicate-lines-while-keeping-the-order-of-the-lines
cat -n out.txt | sort -k2 -k1n  | uniq -f1 | sort -nk1,1 | cut -f2-

# Replace recursive
find . -type f -print0 | xargs -0 sed -i -e 's/foo/bar/g'

# List process attached to tty (showed by w)
ps -ft pts/3 
pkill -t pts/1

newline_separated=${space_separated// /$'\n'}

compgen -c # will list all the commands you could run.
compgen -a # will list all the aliases you could run.
compgen -b # will list all the built-ins you could run.
compgen -k # will list all the keywords you could run.
compgen -A function # will list all the functions you could run.
compgen -A function -abck # will list all the above in one go.

https://codegolf.stackexchange.com/questions/28786/write-a-program-that-makes-2-2-5

# Cat all file with filename
tail -n +1 file1.txt file2.txt file3.txt

# Export all function
declare -fx $(compgen -A function)

copy_function() {
  # See: https://stackoverflow.com/a/18839557/2544873
  test -n "$(declare -f "$1")" || return 
  eval "${_/$1/$2}"
}

# Bash Terminal raw
alacritty -e env -i INPUTRC= bash --noprofile --norc
alacritty -e env -i INPUTRC= bash --noprofile --norc -ic 'echo toto; bash --norc'

nl  # for number line: prepend each line with line number, pipeutil

IFS=''; while read REPLY; do echo "$REPLY"; done < tag.md

ps -ef | grep 'myProcessName' | grep -v grep | awk '{print $2}' | xargs -r kill -15  #  kill all process from name

type find; type vi  # see if command is alias or function or binary

kill -l  # list signals

current_script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"`
```

# Create User

```bash
name=isaacgd
useradd -m -s $(which bash) -d /users/$name $name
passwd $name
getent passwd $name
```

# Useless cat

```bash
value=`cat config.txt`
value=$(<config.txt)
```

# Redirection and file descriptor



```bash
# Fork a pipe
echo "Hello world." | tee >(sed 's/^/1: /')  >(sed 's/^/2: /') >/dev/null
# Fork a pipe bis: more sophisticated
echo "Hello world." | tee >(md5sum | tee out1 | sed 's/^/md5 : /') >(sha1sum | tee out2 | sed 's/^/sha1: /') > out3
# For a pipe posix compliant
( # 6
( # 5
( # 4
echo "Hello World" | tee /dev/fd/{4,5} > /dev/null
) 4>&1 | ( sed 's/^/one: /' > /dev/fd/6 )
) 5>&1 | ( sed 's/^/two: /' > /dev/fd/6 )
) 6>&1

shopt -s lastpipe; set +m  # permit last pipe command to execute in current shell; disable Monitor mode (i.e. job control)
{ echo -e "begin\ngrepme\nend" | tee /dev/fd/3 | sed -n '/grepme/p' | readarray -t a_filter; } 3>&1; echo "${a_filter[*]}"


# :from: https://catonmat.net/bash-redirections-cheat-sheet
cmd > file        # Redirect the standard output (stdout) ofcmdto a file.
cmd 1> file       # Same ascmd > file. 1 is the default file descriptor (fd) for stdout.
cmd 2> file       # Redirect the standard error (stderr) ofcmdto a file. 2 is the default fd for stderr.
cmd >> file       # Append stdout ofcmdto a file.
cmd 2>> file      # Append stderr ofcmdto a file.
cmd &> file       # Redirect stdout and stderr ofcmdto a file.
cmd > file 2>&1   # Another way to redirect both stdout and stderr ofascmd 2>&1 > file. Redirection order matters! cmdto a file. This is notthe same
cmd > /dev/null   # Discard stdout ofcmd.
cmd 2> /dev/null  # Discard stderr ofcmd.
cmd &> /dev/null  # Discard stdout and stderr ofcmd.
cmd < file        # Redirect the contents of the file to the standard input (stdin) ofcmd.

# Redirect a bunch of lines to the stdin. If'EOL'is quoted, text is treated literally. This is called a here-document.
cmd << EOL
line
line
EOL

# Redirect a bunch of lines to the stdin and strip the leading tabs.
cmd <<- EOL
<tab>foo
<tab><tab>bar
EOL

exec &> >(tee -a log.out)  # Redirect stdout and stderr to file
exec &> /dev/tty           # Reset stdout and stderr 

cmd <<< "string"  # Redirect a single line of text to the stdin ofcmd. This is called a here-string.
exec 2> file      # Redirect stderr of all commands to a file forever.
exec 3< file      # Open a file for reading using a custom file descriptor.
exec 3> file      # Open a file for writing using a custom file descriptor.
exec 3<> file     # Open a file for reading and writing using a custom file descriptor.
exec 3>&-         # Close a file descriptor.
exec 4>&3         # Make file descriptor 4 to be a copy of file descriptor 3. (Copy fd 3 to 4 .)
exec 4>&3-        # Copy file descriptor 3 to 4 and close file descriptor 3.
echo "foo" >&3    # Write to a custom file descriptor.
cat <&3           # Read from a custom file descriptor.
(cmd1; cmd2) > file  # Redirect stdout from multiple commands to a file (using a sub-shell).
{ cmd1; cmd2; } > file  # Redirect stdout from multiple commands to a file (faster; not using a sub-shell).
exec 3<> /dev/tcp/host/port  # Open a TCP connection tohost:port. (This is a bash feature, not Linux feature).
exec 3<> /dev/udp/host/port  # Open a UDP connection tohost:port. (This is a bash feature, not Linux feature).
cmd <(cmd1)       # Redirect stdout ofUseful whencmddoesn’t read from stdin directly.cmd1to an anonymous fifo, then pass the fifo tocmdas an argument.
cmd < <(cmd1)     # Redirect stdout ofBest example:diff <(find /path1 | sort) <(find /path2 | sort)cmd1to an anonymous fifo, then redirect the fifo to stdin of. cmd.
cmd <(cmd1) <(cmd2)  # Redirect stdout ofarguments tocmd. cmd1andcmd2to two anonymous fifos, then pass both fifos as
cmd1 >(cmd2)      # Runpipe as an argument tocmd2with its stdin connected to an anonymous fifo, and pass the filename of thecmd1.
cmd1 > >(cmd2)    # Runto this anonymous pipe.cmd2with its stdin connected to an anonymous fifo, then redirect stdout ofcmd
cmd1 | cmd2       # Redirect stdout ofsame ascmd2 < <(cmd1)cmd1to stdin of, same ascmd2> >(cmd2) cmd1. Pro-tip: This is the same as, same as< <(cmd1) cmd2cmd1 > >(cmd2). ,
cmd1 |& cmd2      #  Redirect stdout and stderr ofcmd1 2>&1 | cmd2for older bashes.cmd1 to stdin of cmd2 (bash 4.0+ only). Use
cmd | tee file    # Redirect stdout ofcmdto a file and print it to screen.
exec {filew}> file  # Open a file for writing using a named file descriptor called{filew}(bash 4.1+).
cmd 3>&1 1>&2 2>&3  # Swap stdout and stderr ofcmd.
cmd > >(cmd1) 2> >(cmd2)  # Send stdout ofcmdtocmd1and stderr ofcmdtocmd2.
cmd1 | cmd2 | cmd3 | cmd; echo ${PIPESTATUS[@]}  # Find out the exit codes of all piped commands.

# 
```

# interactive

```bash
bash --init-file my-init-script

eval "$(declare -F | sed -e 's/-f /-fx /')"
```

# Introspection

* typedef  # Know type instances
* caller  # Stacktrace
* hash  # Previously Run command
* type  # Show type of a lias, keyword, function, builtin, file
* FUNCNAME
* BASH_SOURCE
* BASH_LINENO
* ${!variable name}

# Shell check

```bash
# shellcheck disable=SC2155  # Declare and assign separately to avoid masking return values -> Prevent declare -a
# shellcheck disable=SC2092  # Remove backticks
```

# Completion

* COMP_WORDS: an array of all the words typed after the name of the program the compspec belongs to
* COMP_CWORD: an index of the COMP_WORDS array pointing to the word the current cursor is at - in other words, the index of the word the cursor was when the tab key was pressed
* COMP_LINE: the current command line
  

# Getopt

```bash
# $@ is all command line parameters passed to the script.
# -o is for short options like -v
# -l is for long options with double dash like --version
options=$(getopt \
  -l "all,help,rosetta,site,vim,html,wiki" \
  -o "ahrsvxw" -- "$@")

# set --:
# If no arguments follow this option, then the positional parameters are unset. Otherwise, the positional parameters
# are set to the arguments, even if some of them begin with a ‘-’.
eval set -- "$options"
echo -n "Args: "
while true; do
  case "$1" in
    -a|--all)
      echo -n "All, "
      ((ball=1))
      ;;
    -h|--help)
      usage
      ;;
    -r|--rosetta)
      echo -n "Rosetta, "
      ((brosetta=1))
      ;;
    -s|--site)
      echo -n "Site, "
      ((bsite=1))
      ;;
    -v|--vim)
      echo -n "Vim, "
      ((bvim=1))
      ;;
    -w|--wiki)
      echo -n "Wiki, "
      ((bwiki=1))
      ;;
    -x|--html)
      echo -n "Html, "
      ((bhtml=1))
      ;;
    --)
      shift
      break
      ;;
  esac
  shift
done
echo

```

~/Software/Bash
$ toto a1 a2 a3
# Tutorial LinkedIn

* `unset` variable
* () subshell do not change env var but {} do
* `enable` to list builtins
* `echo`
  * -n dont print new line
  * -e enable backslash escaped (\n, \e, \t)
  * -E disable basckslash escaped chars
* `declare`
  * declare -l lstring="ABCdef"
  * declare -u ustring="ABCdef"
  * declare -r readonly="A value"
  * declare -a Myarray
  * declare -A Myarray2
* `read`
  * breaks on whitespace
* `lsof`

### Mnemonic

* `tee` for T intersection
* `cat` for concatenate
* `tac` for cat upside down


# Commpletion

* `complete -p` : list 
* bind 'set show-all-if-ambiguous on'
* bind TAB:menu-complete 

```conf
# display all possible matches for an ambiguous pattern at first tab
set show-all-if-ambiguous on

# next tab(s) will cycle through matches
TAB: menu-complete
# shift tab cycles backward
"\e[Z": menu-complete-backward
```

# History

```
!^      first argument
!:2     second argument
!:2-$   second to last arguments
!:2*    second to last arguments
!:2-    second to next to last arguments
!:2-3   second to third arguments
!$      last argument
!*      all arguments
```

# Other tips

* How to join multiple lines of file names into one with custom delimiter?:
  * `paste` in `ls -1 | paste -sd "," -`
  * `tr` in `ls -1 | tr '\n' ','`
  * `awk` in `ls -1 | awk 'ORS=","'` Output Record Separator
  * `xargs` in ls  | xargs -d, -L 1 echo
* Exit with <C-D>
* cat directory any write
  * `inotifywait -qme close_write . | while read -r fil ; do cat $fil ; done`

* Read file line by line
  * cat peptides.txt | while read line; do_something_with_$line_here; done
  * while read p; do echo "$p" ; done <peptides.txt

* Xterm change mouse cursor
  * `printf '\033[6 q'`
	* echo -e -n "\x1b[\x30 q" # changes to blinking block
	* echo -e -n "\x1b[\x31 q" # changes to blinking block also
	* echo -e -n "\x1b[\x32 q" # changes to steady block
	* echo -e -n "\x1b[\x33 q" # changes to blinking underline
	* echo -e -n "\x1b[\x34 q" # changes to steady underline
	* echo -e -n "\x1b[\x35 q" # changes to blinking bar
	* echo -e -n "\x1b[\x36 q" # changes to steady bar


* Remove all (including dot files)
	* `rm -rf .[^.] .??*`


* Get filename and extension
	* `filename=$(basename -- "$fullfile")`
	* `extension="${filename##*.}"`
	* `filename="${filename%.*}"`


* Get source directory of a script
	* `DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"`
	* `dirname $0`
	* `dirname "$(readlink -f "$0")"`


* Faster redirect to null `| :` instead of `> /dev/null`


*	Center text (read ~/Bin/hi.sh)
	*	
		```bash
		title="El terminal de la Ponette"
		printf "%*s\n" $(( ( ${#title} + $columns ) / 2  )) "$title"


		while read -r line
		do
				echo "$line"
		done < <(jobs)
		while read -r line  ; do echo -e  "ccaca $line" ; done< <(echo -e "$toto")

		lines=$(tput lines)
		columns=$(tput cols)

		IFS='' read -r -d '' String <<"EOF"
		<?xml version="1.0" encoding='UTF-8'?>
		 <painting>
			 <img src="madonna.jpg" alt='Foligno Madonna, by Raphael'/>
			 <caption>This is Raphael's "Foligno" Madonna, painted in
			 <date>1511</date>-<date>1512</date>.</caption>
		 </painting>
		EOF
		This will put your text into your variable without needing to escape the quotes. It will also handle unbalanced quotes (apostrophes, i.e. '). Putting quotes around the sentinel (EOF) prevents the text from undergoing parameter expansion. The -d'' causes it to read multiple lines (ignore newlines). read is a Bash built-in so it doesn't require calling an external command such as cat.
		And if you are using this multi-line String variable to write to a file, put the variable around "QUOTES" like echo "${String}" > /tmp/multiline_file.txt or echo "${String}" | tee /tmp/multiline_file.txt. Took me more than an hour to find that.
		# more there : https://stackoverflow.com/questions/1167746/how-to-assign-a-heredoc-value-to-a-variable-in-bash
		```



* Fork bomb
	* :(){ :|:& };:
	* Explications :
	* :() définit une fonction nommée :. { :|:& } est le corps de la fonction. Dans celui-ci, la fonction s'appelle elle-même (:), puis redirige la sortie à l'aide d'un pipe (|) sur l'entrée de la même fonction : et cache le processus en fond avec &. La fonction, ensuite appelée avec :, s'appelle récursivement à l'infini. 




*	Redirection
	*	`caca 2>&1 | tail -n 2`
	*	`cat <&1`


* Regex
	*	`mv /mnt/usbdisk/[^l]* /home/user/stuff/.`


*   Preserving spaces
	*   `var="abc        def    gh ijk"`
	*   `echo $var`
		*  BAD : `abc def gh ijk`
	*   `echo "$var"`
	*   `echo "${var}"`
	*   `IFS='%' ; echo $var`
		*   GOOD : `abc        def    gh ijk`
		* 	Put your variable inside double quote to prevent field splitting, which ate your spaces:


* Debugging
	*	`bash -x ./script.sh`

	* set -x 
  * trap read debug
    * # at the beginning of the script
		*   to debug
	
*	Arrays
	* `arr=($line)` # Space separated string -> array


* 	Let a variable
    *
        ```bash
        var=$((var+1))
        ((var=var+1))
        ((var+=1))
        ((var++))
        ```
    *   Or you can use let:
    *
        ```bash
        let "var=var+1"
        let "var+=1"
        let "var++"
        ```
	


* Configuration
	*	shopt -s chanble_vars
		now I can go to some vars
	*	shopt -s expand_aliases
  	to get aliases in Vim
		

*	Chaging directories fast
	*	`pushd -n /Project/Warnest/docs/`
	*	`pushd -n ~/Dropbox/Projects/ds/test/`  
	* `dirs`
	*	`cd -` # Go back and foward
	*	`$CDPATH` #  is the path bash looks at
	then,  

	cd ~ is your home,  

	cd ~1 is ~/Dropbox/Projects/ds/test/  

	cd ~2 is /Project/Warnest/docs/  

	You can use ~1,~2 etc in exactly the same way as
