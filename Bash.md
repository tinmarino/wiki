% BASH Bourne Again SHell

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
		*   set -x  # at the beginning of the script
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
