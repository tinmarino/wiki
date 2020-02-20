---
title: Bash HackerRank tips
category: Bash
wiki_css: Css/color_dark_solarized.css, Css/layout_toc.css
header-includes: <script type="text/javascript" src="Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---
<section class="level2">


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
#!/bin/bash
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
#!/bin/bash
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
#!/bin/bash
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

```sh

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

```sh
#!/bin/bash

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


```


</section>
