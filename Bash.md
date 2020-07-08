% BASH Bourne Again SHell

[Bash HackerRank](Bash-HackerRank)
[Bash Rc](Bash-Rc)

* `ps -ef | grep 'myProcessName' | grep -v grep | awk '{print $2}' | xargs -r kill -15` : kill all process from name
* `type find` , `type vi` : see if command is alias or function or binary
* `kill -l` list signals
* `current_script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"`

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
