# Contents

  - [](#)
  - [wiki_pandoc: --toc](#wiki_pandoc---toc)
  - [Syntax](#syntax)
    - [Common operation](#common-operation)
    - [Looping and Skipping](#looping-and-skipping)
    - [A Personalized Echo](#a-personalized-echo)
    - [The World of Numbers](#the-world-of-numbers)
    - [Comparing Numbers](#comparing-numbers)
    - [Getting started with conditionals](#getting-started-with-conditionals)
    - [More on Conditionals](#more-on-conditionals)
    - [Arithmetic Operations](#arithmetic-operations)
    - [Compute the Average](#compute-the-average)
  - [Pipe](#pipe)
    - [Functions and Fractals - Recursive Trees - Bash!](#functions-and-fractals---recursive-trees---bash)
    - [Cut](#cut)
    - [Head](#head)
    - [Middle](#middle)
    - [Tail](#tail)
    - [Tr](#tr)
    - [Sort](#sort)
    - [Uniq](#uniq)
    - [Paste](#paste)
  - [Array](#array)
    - [Read in an Array](#read-in-an-array)
    - [Slice an Array](#slice-an-array)
    - [Filter an Array with Patterns](#filter-an-array-with-patterns)
    - [Concatenate an array with itself](#concatenate-an-array-with-itself)
    - [Display an element of an array](#display-an-element-of-an-array)
    - [Count the number of elements in an Array](#count-the-number-of-elements-in-an-array)
    - [Remove the First Capital Letter from Each Element](#remove-the-first-capital-letter-from-each-element)
    - [Lonely Integer - Bash!](#lonely-integer---bash)
  - [Grep / Sed / Awk](#grep-sed-awk)
    - [Grep](#grep)
    - [Sed](#sed)
    - [Awk](#awk)
      - [Awk tricks](#awk-tricks)

---
title: Bash HackerRank tips
category: Bash
wiki_css: Css/color_dark_solarized.css, Css/layout_toc.css
header-includes: <script type="text/javascript" src="Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---
<section class="level2">

## Syntax
### Common operation

* Copy: [link](https://stackoverflow.com/questions/19417015/how-to-copy-an-array-in-bash)

```bash
a=(foo bar "foo 1" "bar two")  #create an array
b=("${a[@]}")                  #copy the array in another one 

for value in "${b[@]}" ; do    #print the new array 
  echo "$value" 
done
```

* Delete: [link](https://stackoverflow.com/questions/16860877/remove-an-element-from-a-bash-array)
```bash
delete=(pluto pippo)
for del in ${delete[@]}
do
   array=("${array[@]/$del}") #Quotes when working with strings
done

# This technique actually removes prefixes matching $delete from the elements, not necessarily whole elements.
# To really remove an exact item, you need to walk through the array, comparing the target to each element, and using unset to delete an exact match.

array=(pluto pippo bob)
delete=(pippo)
for target in "${delete[@]}"; do
  for i in "${!array[@]}"; do
    if [[ ${array[i]} = $target ]]; then
      unset 'array[i]'
    fi
  done
done

# Note that if you do this, and one or more elements is removed, the indices will no longer be a continuous sequence of integers.

declare -p array
declare -a array=([0]="pluto" [2]="bob")

#If gaps are a problem, then you need to rebuild the array to fill the gaps:

for i in "${!array[@]}"; do
    new_array+=( "${array[i]}" )
done
array=("${new_array[@]}")
unset new_array
```

```bash
array=(pluto pippo)
new_array=()
for value in "${array[@]}"
do
    [[ $value != pluto ]] && new_array+=($value)
done
array=("${new_array[@]}")
unset new_array
```

### Looping and Skipping

```sh
for i in $(seq 1 2 99); do echo $i; done
```

```sh
for number in {1..99..2}; do echo $number; done
```

```sh
echo -e "\n"{1..99..2}
echo -e 1 "\n"{3..99..2}
printf '%s\n' {1..99..2}
```

### A Personalized Echo

```sh
name=`cat -`; echo "Welcome $name"
```

```sh
read name
echo "Welcome $name"
```

```sh
printf "Welcome "; cat
```

```sh
sed -r 's/(.*)/Welcome \1/g'
```

```sh
echo "Welcome $(cat)"
echo "Welcome $(cat <&0)"
echo "Welcome $(</dev/stdin)"
xargs -I ^ echo "Welcome" ^
```

### The World of Numbers

* Read from command line

```sh
echo -e "3\n3" | { read X; read Y; echo $((X + Y)); } 
```

```sh
read x
read y

echo $((x + y))
echo $((x - y))
echo $((x * y))
echo $((x / y))
```

```sh
read X
read Y
printf "%s\n" $X{+,-,*,/}"($Y)" | bc
```

```sh
read x
read y
for i in {+,-,"*",/}
do
    var=$(((x)$i(y)))
    echo $var
done
```

```sh
read x
read y

if [ "$x" -ge "-100" ] && [ "$y" -ge "-100" ] && [ "$x" -le "100" ] && [ "$y" -le "100" ] && [ "$y" -ne "0" ]; then
	echo "$x + $y" | bc
	echo "$x - $y" | bc
	echo "$x * $y" | bc
	echo "$x / $y" | bc
else
	echo "ERROR"

fi
```


### Comparing Numbers

```sh
read X
read Y

if (( $X < $Y )); then
    echo 'X is less than Y'
elif (( $X > $Y )); then
    echo 'X is greater than Y'
else 
    echo 'X is equal to Y'
fi
```

```sh
read x
read y
[[ $x -gt $y ]] && echo 'X is greater than Y'
[[ $x -eq $y ]] && echo 'X is equal to Y'
[[ $x -lt $y ]] && echo 'X is less than Y'
```


### Getting started with conditionals

```sh
read X;
if [ "${X:0:1}" = "n" -o "${X:0:1}" = "N" ]; then echo "NO"; fi
if [ "${X:0:1}" = "y" -o "${X:0:1}" = "Y" ]; then echo "YES"; fi
```

```sh
read char; echo -e "YES\nNO\n" | grep -i $char
```

```sh
read c
[[ "$c" == [yY] ]] && echo "YES" || echo "NO"
```


### More on Conditionals

```sh
read X; read Y; read Z

if (( X == Y && Y == Z )); then echo "EQUILATERAL"
elif (( X == Y || Y == Z || X == Z )); then echo "ISOSCELES"
else echo "SCALENE"
fi
```

* Solution based on counting number of unique values

```sh
c=$(cat | tr ' ' "\n" | sort -n -u | wc -l)

[ $c -eq 1 ] && echo EQUILATERAL
[ $c -eq 2 ] && echo ISOSCELES
[ $c -eq 3 ] && echo SCALENE
```

* Problem tester code

```sh
read a
read b
read c

if [ `$a -eq $`b ] && [ `$a -eq $`c ]; then
    echo "EQUILATERAL"
elif [ `$a -eq $`b ] || [ `$a -eq $`c ] || [ `$b -eq $`c ]; then
    echo "ISOSCELES"
else
    echo "SCALENE"
fi
```


### Arithmetic Operations

```sh
printf %.3f $({ echo -n "scale=4; "; cat; } | bc)
```

```sh
cat | bc -l | xargs printf "%.3f"
```

```sh
read a
printf "%.3f\n" $(bc -l <<< "$a")
```


### Compute the Average

```sh
read n;
readarray -t a_num

printf "%.3f" $({
    echo -n "(";
    { IFS=+; echo -n "${a_num[*]}"; };
    echo -n ") / $n"; } | bc -l)
```

```sh
read n
printf "%.3f" $(echo "("$(cat)")/$n" | tr ' ' '+' | bc -l)
```

```sh
read n
arr=($(cat)) 
arr=${arr[*]}
printf "%.3f" $(echo $((${arr// /+}))/$n | bc -l)
```

* Problem tester

```sh
read n
sum=0
for ((i=0;i<$n;i++))
do
    read temp
    sum=`$(($`sum+$temp))
done
printf "%.3f\n" `$(bc -l <<< "$`sum/$n")
```

```sh
read n
for i in $(seq 1 $n);
    do
        read num
        sum=$((sum + num))
    done
printf "%.3f" $(echo "$sum/$n" | bc -l)
```

## Pipe
<section class="level2">
### Functions and Fractals - Recursive Trees - Bash!

Too long, I passed !

```sh
declare -A arr

initialize(){
    for r in {0..62}; do
        for c in {0..99}; do
            arr[$r,$c]="_"
        done
    done
}
print(){
    for r in {0..62}; do
        for c in {0..99}; do
            echo -n ${arr[$r,$c]}
        done
        echo
    done
}

draw(){
    local cnt=$1
    local r=$2
    local c=$3
    for ((i=0; i<cnt; i++ )); do
        arr[$r,$c]=1
        (( r -= 1 ))
    done
    for ((i=0; i<cnt; i++ )); do
        arr[$r,$((c-i-1))]=1
        arr[$r,$((c+i+1))]=1
        (( r -= 1 ))
    done

    if [[ $4 -gt 1 ]]; then
        draw $(($cnt>>1)) $r $(($c-cnt)) $(($4-1))
        draw $(($cnt>>1)) $r $(($c+cnt)) $(($4-1))
    fi
}

initialize

read x
draw 16 62 49 x

print
```

```bash

branch() {    
    if (( $1 == 0 )); then
        exit;
    fi
    let inc=int=ext=rows=$(( 64 / 2**$1 ))
    for ((i=1;i<=rows;i++)) do   
        x=$((buffer))
        for ((j=0;j<100;j++)) do  
            if (( $1 > N )) || (( j >= (100 - buffer) )) || (( j != x )); then
                printf "_"
            else
                printf "1"                
                if (( i <= rows/2 )); then               
                    if (( inc == int )); then
                        inc=$((ext))
                    else
                        inc=$((int))
                    fi  
                fi
                x=$((x+inc))
            fi
        done
        printf "\n"
        if ((i <= rows/2 )); then
            buffer=$((buffer+1))
            int=$((int-2))
            inc=ext=$((ext+2))           
        fi
    done    
    branch $(($1-1))
}
printf "%0.s_" {1..100} 
printf "\n"
buffer=18
read N
branch 5
```

* Recursive

```bash
declare -A m
StartLegLength=16
maxrows=63
maxcols=100
iter=$(cat)


function Y {
  typeset -i row=$1 col=$2 len=$3 iter=$4
  typeset -i r=$row x=$len cl=$col cr=$col l=$((len/2))

  # leg
  while (( x-- > 0 ))
  do m[$((r--)),$col]=1
  done

  # fork
  x=$len
  while (( x-- > 0 ))
  do m[$r,$((--cl))]=1
     m[$r,$((++cr))]=1
     ((r--))
  done

  # subs
  if (( --iter > 0 ))
  then Y $r $cl $l $iter
       Y $r $cr $l $iter
  fi
}

# initialize
for (( row=0; row<maxrows; row++ ))
do  for (( col=0; col<maxcols; col++))
    do  m[$row,$col]=_
    done
done

# recurse
Y $(( maxrows-1 )) $(( (maxcols-1)/2 )) $StartLegLength $iter

# show the result
for (( r=0; r<maxrows; r++ ))
do  for (( c=0; c<maxcols; c++))
    do  printf "%s" ${m[$r,$c]}
    done
    printf "\n"
done
```


### Cut

```sh
cut -f1,3 -d":" /etc/passwd  # Field
cut -c1 /etc/passwd  # Char
cut -c1-5 /etc/passwd
cut -b1 /etc/passwd  # Byte
```

```sh
cut -c3
cut -c2,7
cut -c2-7  # Inclusive
cut -c0-4

cut -f1-3 -d$'\t'  # Tab delimiter
cut -f1-3 -s  # Not containg delimiter
cut -c13-
cut -f4 -d" "
cut -f1-3 -d" "
cut -f2-
```


### Head

```sh
head -n 20  # Line
head -c 20  # Character
```


### Middle

```sh
sed -n '12,22p'
```

```sh
head -n 22 | tail -n +12
cut -d$'\n' -f12-22
```

* Problem tester:

```sh
head -22 | tail -11
```


### Tail

```sh
tail -n 20
tail -c 20
```


### Tr

```sh
tr '()' '[]'
tr -d [a-z]
```

```sh
sed "s/  */ /g"
tr -s  ' ' ' '  # S for squeezze
tr -s " "
```


### Sort

* The vanilla sort command simply sorts the lines of the input file in lexicographical order.
* The `-n` option sorts the file on the basis of the numeric fields available if the first word or column in the file is a number.
* The `-r` option reverses the sorting order to either the reverse of the usual lexicographical ordering or descending order while sorting in numerical mode.
* The `-k` option is useful while sorting a table of data (tsv, csv etc.) based on a specified column (or columns).
* The `-t` option is used while specifying a delimiter in a particular file where columns are separated by tabs, spaces, pipes etc.

```sh
sort
sort -r
sort -n
sort -rn
sort -t$'\t' -nr -k2
sort -r -n -k2 -t $'\t'  # Same
sort -n -t $'\t' -k 2
sort -nr -t '|' -k 2
```


### Uniq

* `-c` count: prefix with the number of lines collaspsed
* `-d` duplicate: only print duplicate lines
* `-u` uniqque: only print unique lines
* `-w` word: Limit comparison only to the first characters
* `-s` paSS: Avoid comparing the first characters
* `-i` ignore case: Ignore variations in case between lines
* `-f` field: Avoid comparing the first fields

```sh
uniq
uniq -c | cut -c7-
uniq -c | tr -s " " | cut -b 2-  # Same
uniq -ci | tr -s " " | cut -b 2-
uniq -u
```


### Paste

* `-s` serial
* `-d";"` delimiter separated by ;

```sh
tr '\n' ';' | head -c -1
paste -s -d";"
```

```sh
paste -d ";" - - -
paste -sd ';;\n'
```

```sh
paste -s
```

```sh
paste - - -
```


</section>
## Array
<section class="level2">
### Read in an Array

```sh
arr=($(cat)); echo ${arr[@]}
```

### Slice an Array

* `${A[@]:3:5}`: From 3 (0 indexed) with 5 elements

```sh
readarray -t A
B=("${A[@]:3:5}")
echo "${B[*]}"
```

```sh
arr=($(cat))
echo ${arr[@]:3:5}
```

```sh
head -8 | tail -5 | paste -s -d' '
```


### Filter an Array with Patterns

```sh
arr=($(cat))
echo ${arr[@]/*[Aa]*/}
```

```sh
grep -vi a
```


### Concatenate an array with itself

```sh
arr=($(cat))
echo "${arr[@]} ${arr[@]} ${arr[@]}"
```

```sh
X=$(xargs)
echo $X $X $X
```

```sh
X=$(paste -d' ')
echo $X $X $X
```

```sh
tr `$'\n' ' ' | awk '{print $`0 `$0 $`0}'
```

```sh
IFS=$'\n' read -d '' -ra countries
echo "${countries[@]}" "${countries[@]}" "${countries[@]}"
```


### Display an element of an array

```sh
arr=($(cat))
echo ${arr[3]}
```

```sh
awk 'NR==4'
```


### Count the number of elements in an Array

```sh
arr=($(cat))
echo ${#arr[*]}
```


### Remove the First Capital Letter from Each Element


```sh
arr=($(cat))
echo ${arr[@]/?/.}
```


### Lonely Integer - Bash!

```sh
read n
tr " " "\n" | sort | uniq -u
```

```sh
read
arr=($(cat))
arr=${arr[*]}  # render a new variable of type string from the merging of the array arr delimited by space, i.e., from [1,2,2,2,1] to "1 2 2 2 1"
echo $((${arr// /^}))  # replaces all spaces ' ' in the string variable with ^ (bitwise-XOR operator),
```

```sh
read
echo $(( `tr ' ' '^'` ))
```

```sh
# read the input values
read n
read -a A
#echo -e "The size of the array is '${#A[*]}', and the array is:\n${A[*]}"
x=${A[0]}
#echo "A[0] = ${A[0]}, x = $x"
for (( i = 1; i < ${#A[*]}; i++ )); do
#for (( i = 1; i < n; i++ )); do
    $((x ^= ${A[i]} ))
    #x=$((x ^ ${A[i]} ))
    #echo "A[$i] = ${A[i]}, x = $x"
    
done
echo $x
```


</section>
## Grep / Sed / Awk
<section class="level2">
### Grep

* Note: escape `|` `()`

```sh
grep " the "
grep '\bthe\b'
grep -w 'the'
```

```sh
grep -viw that
grep -iw 'the\|that\|then\|those'
grep '\(\d\)\s*\1'
```


### Sed

```sh
sed 's/\bthe\b/this/'
sed -e 's/\<the\>/this/'
sed 's/\<thy\>/your/gi'
sed 's/\<thy\>/{\0}/gi'
```

```sh
sed 's/\d\d\d\d \d\d\d\d \d\d\d\d/**** **** ****/'
sed 's/[0-9]\+ /**** /g'
sed -e 's/([0-9]){4} /**** /g'
sed -r 's/[0-9]{4} /**** /g'
# Reverse each line
# Used sed to replace digits with *, starting with the 5th digit
# Reverse each line again
rev | sed 's/[0-9]/*/g5' | rev
```

```sh
sed -E 's/(\d{4}) (\d{4}) (\d{4}) (\d{4})/\4 \3 \2 \1/'
awk '{print $4" "$3" "$2" "$1}'
sed -r 's/(.... )(.... )(.... )(....)/\4 \3\2\1/'
```


### Awk

* `NF` Number of Fields

```sh
awk '{if ($4 == "") print "Not all scores are available for",$1;}'
awk '{if(NF < 4) print "Not all scores are available for",$1;}'
awk '{if (NF < 4){print "Not all scores are available for "$1}}'  # Removed coma
awk '$4=="" {print "Not all scores are available for " $1} '
```

```sh
awk '{printf $1" : "; if ($2+$3+$4 >= 150) {print "Pass"} else {print "Fail"}}'  # Wrong but I got lucky
awk '{print $1,":", ($2<50||$3<50||$4<50) ? "Fail" : "Pass"}'
```

```sh
awk '{
    printf $0" : ";
    sum=$2+$3+$4;
    if (sum >= 240) {print "A"}
    else if (sum >= 180) {print "B"}
    else if (sum >= 150) {print "C"}
    else {print "FAIL"}
    }'
awk '{avg=($2+$3+$4)/3; print $0, ":", (avg<50)?"FAIL":(avg<80)?"B":"A"}'
```

* Concatenate each 2 lines

```sh
paste -d";" - -
awk 'ORS=NR%2?";":"\n"'
awk 'NR%2{printf$0";"}1-NR%2'
awk '{
    if ( NR % 2 == 1 )
        printf "%s;", $0
    else
        printf "%s\n", $0  
}'
```

#### Awk tricks

```sh
awk '/^num/ {n++;sum+=$2} END {print n?sum/n:0}' file
```


</section>
