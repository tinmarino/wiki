% BASH Bourne Again SHell

[Bash HackerRank](Bash-HackerRank)
[Bash Rc](Bash-Rc)

* nl  # for number line: prepend each line with line number, pipeutil
* `IFS=''; while read REPLY; do echo "$REPLY"; done < tag.md`
* `ps -ef | grep 'myProcessName' | grep -v grep | awk '{print $2}' | xargs -r kill -15` : kill all process from name
* `type find` , `type vi` : see if command is alias or function or binary
* `kill -l` list signals
* `current_script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"`



# Shell check

# shellcheck disable=SC2155  # Declare and assign separately to avoid masking return values -> Prevent declare -a
# shellcheck disable=SC2092  # Remove backticks

# Completion

* COMP_WORDS: an array of all the words typed after the name of the program the compspec belongs to
* COMP_CWORD: an index of the COMP_WORDS array pointing to the word the current cursor is at - in other words, the index of the word the cursor was when the tab key was pressed
* COMP_LINE: the current command line
  
Dirty
```
92 cword          Bonjour 0: aa!    Bonjour 2: toto!  Bonjour 4: toto!
1: name
2: last word
3: last last
Then need the 
$ toto a1 a2 a3
91 word                Bonjour 0: aa!         Bonjour 3: a3!
92 cword               Bonjour 1: bb!         Bonjour 4: a2!
93 line toto a1 a2 a3  Bonjour 2: toto!
```

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
