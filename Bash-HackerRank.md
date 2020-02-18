---
title: Perl HackerRank tips
category: Perl
wiki_css: Css/color_dark_solarized.css, Css/layout_toc.css
header-includes: <script type="text/javascript" src="Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---


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


### 
