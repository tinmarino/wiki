
*	bash -x ./script.sh
	set -x  # at the beginning of the script
	to debug
	

*	arr=($line)			# Space separated string -> array

* 	Let a variable
```bash
var=$((var+1))
((var=var+1))
((var+=1))
((var++))
```

Or you can use let:

```bash
let "var=var+1"
let "var+=1"
let "var++"
```


*	Get submatch 1 for all lines
```bash
echo -e "Bla\nBla\nImportant1: One \nBla\nImportant2: Two\nBla\nBla" | \
   sed -n 's/^Important1: *\([^ ]*\) */\1/p'

OUTPUT:
one
```

-n means silent
