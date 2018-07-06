caca 2>&1 | tail -n 2
cat <&1
mv /mnt/usbdisk/[^l]* /home/user/stuff/.
shopt -s expand_aliases
  to get aliases in Vim
*	cd - 
Go back and foward

*	`bash -x ./script.sh`
	*   set -x  # at the beginning of the script
	*   to debug
	
*	`arr=($line)` # Space separated string -> array


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
	

*	$CDPATH  is the path bash looks at

*	shopt -s cdable_vars
  now I can go to some vars

 8
down vote

Use "pushd -n" (assuming you use bash).

Add to your ~/.bashrc:

pushd -n /Project/Warnest/docs/
pushd -n ~/Dropbox/Projects/ds/test/

then,

cd ~ is your home,

cd ~1 is ~/Dropbox/Projects/ds/test/

cd ~2 is /Project/Warnest/docs/

You can use ~1,~2 etc in exactly the same way as

pd toto
dirs
pd 3

