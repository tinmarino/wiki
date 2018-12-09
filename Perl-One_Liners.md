Double-space a file
	perl -pe '$\ = "\n"' file
	perl -pe '$_ .= "\n"' file
	perl -pe 's/$/\n/' file
	perl -nE 'say' file

Double-space a file, excluding the blank lines
	perl -pe '$_ .= "\n" unless /^$/'
	perl -pe '$_ .= "\n" if /\S/'

N-space a file
	perl -pe '$_ .= "\n"x7'
	
Add a blank line before every line
	perl -pe 's/^/\n/'

Remove all blank lines
	perl -ne 'print unless /^$/'
	perl -lne 'print if length'
	perl -ne 'print if /\S/'
	perl -pe 's/^\s*$//'
	
Remove all consecutive blank lines, leaving only one
	perl -00 -pe ''
	perl -00pe0
	
Compress/expand all blank lines into N consecutive lines
	perl -00 -pe '$_ .= "\n"x2'
	
Insert a space between all characters
	perl -lpe 's// /g'

# Numbering
Number all lines in a file
	perl -pe '$_ = "$. $_"'
	perl -ne 'print "$. $_"'
	perl -ne 'print $. . $_'
	
Number only non-empty lines in a file
	perl -pe'$_ = ++$x . $_ if /./'
	perl -pe '$_ = ++$x." $_" if /\S/'
	
Number and print only non-empty lines in a file (drop empty lines)
	perl -ne'print ++$x . $_ if /\S/' 
	
Number all lines but print line numbers only for non-empty lines
	perl -pe '$_ = "$. $_" if /./'

Number only lines that match a pattern; print others unmodified
	perl -pe '$_ = ++$x." $_" if /regex/'

Number and print only lines that match a pattern
	perl -ne 'print ++$x." $_" if /regex/'
	
Number all lines but print line numbers only for lines that match a pattern
	perl -pe '$_ = "$. $_" if /regex/'

Number all lines in a file using a custom format
	perl -ne 'printf "%-5d %s", $., $_'
	
Print the total number of lines in a file (emulate wc -l)
	perl -lne 'END { print $. }'
	perl -le 'print $n = () = <>'
	perl -le 'print $n = (() = <>)'
	perl -le 'print scalar(() = <>)'
	perl -le 'print scalar(@foo = <>)'
	perl -ne '}{print $.'  # eskimo operator }{
	
Print the number of non-empty lines in a file
	pl -ne'/\S/ && $a++}{print $a'
	perl -le 'print scalar(grep { /./ } <>)'
	perl -le 'print ~~grep{/./}<>'
	perl -le 'print~~grep/./,<>'
	perl -lE 'say~~grep/./,<>'
	
Print the number of empty lines in a file
	perl -lne '$x++ if /^$/; END { print $x+0 }'
	perl -lne '$x++ if /^$/; END { print int $x }'
	perl -le 'print scalar(grep { /^$/ } <>)'
	perl -le 'print ~~grep{ /^$/ } <>'
	
Print the number of lines in a file that match a pattern (emulate grep -c)
	perl -lne '$x++ if /regex/; END { print $x+0 }'
	
Number words across all lines
	perl -pe 's/(\w+)/++$i.".$1"/ge'

Number words on each individual line
	perl -pe '$i=0; s/(\w+)/++$i.".$1"/ge'
	
	
# Calculations

Check if a number is a prime
	perl -lne '(1x$_) !~ /^1?$|^(11+?)\1+$/ && print "$_ is prime"'
	
Print the sum of all fields on each line
	perl -MList::Util=sum -alne 'print sum @F'
	perl -MList::Util=sum -F: -alne 'print sum @F'
	
Print the sum of all fields on all lines
	perl -MList::Util=sum -alne 'push @S,@F; END { print sum @S }'
	perl -MList::Util=sum -alne '$s += sum @F; END { print $s }'
	
Shuffle all fields on each line
	perl -MList::Util=shuffle -alne 'print "@{[shuffle @F]}"'
	perl -MList::Util=shuffle -alne 'print join " ", shuffle @F'
	
Find the numerically smallest element (minimum element) on each line
	perl -MList::Util=min -alne 'print min @F'

Find the numerically smallest element (minimum element) over all lines
	perl -MList::Util=min -alne '@M = (@M, @F); END { print min @M }'
	perl -MList::Util=min -alne '$min = min($min // (), @F); END { print $min }'

Replace each field with its absolute value
	perl -alne 'print "@{[map { abs } @F]}"'
	
Print the total number of fields on each line
	perl -alne 'print scalar @F'

Print the total number of fields on each line, followed by the line
	perl -alne 'print scalar @F, " $_"'
	
Print the total number of fields on all lines
	perl -alne '$t += @F; END { print $t }'
	
Print the total number of fields that match a pattern
	perl -alne 'map { /regex/ && $t++ } @F; END { print $t || 0 }'
	perl -alne '$t += /regex/ for @F; END { print $t }'
	perl -alne '$t += grep /regex/, @F; END { print $t }'
	
Print the total number of lines that match a pattern
	perl -lne '/regex/ && $t++; END { print $t || 0 }'

Print the number π
	perl -Mbignum=bpi -le 'print bpi(21)'
	perl -Mbignum=PI -le 'print PI'
	
Print the number e
	perl -Mbignum=bexp -le 'print bexp(1,21)'
	perl -Mbignum=bexp -le 'print bexp(2,31)'
	perl -Mbignum=e -le 'print e'
	
Print UNIX time (seconds since January 1, 1970, 00:00:00 UTC)
	perl -le 'print time'

Print Greenwich Mean Time and local computer time
	perl -le 'print scalar gmtime'
	perl -le 'print join ":", (localtime)[2..6]'
	
Calculate the factorial
	perl -le '$f = 1; $f *= $_ for 1..5; print $f'
	
Calculate the greatest common divisor
	perl -MMath::BigInt=bgcd -le 'print bgcd(20,60,30)'

Generate 10 random numbers between 5 and 15 (excluding 15)
	perl -le 'print join ",", map { int(rand(15-5))+5 } 1..10'
	perl -le 'for (1..10){say int(5 + 10 * rand)}'
	
Convert an IP address to an unsigned integer
	perl -le 'print unpack("N", 127.0.0.1)'
	
Convert an unsigned integer to an IP address
	perl -le '
	$ip = 2130706433;
	$, = ".";
	print map { (($ip>>8*($_))&0xFF) } reverse 0..3
	'

# Array and string

Generate and print the alphabet
Generate and print all the strings from “a” to “zz”
Create a hex lookup table
Generate a random eight-character password
Create a string of specific length
Create an array from a string
Create a string from the command-line arguments
Find the numeric values for characters in a string
Convert a list of numeric ASCII values into a string
Generate an array with odd numbers from 1 to 100
Generate an array with even numbers from 1 to 100
Find the length of a string
Find the number of elements in an array

# Text convertion

ROT13 a string
Base64-encode a string
Base64-decode a string
URL-escape a string
URL-unescape a string
HTML-encode a string
HTML-decode a string
Convert all text to uppercase
Convert all text to lowercase
Uppercase only the first letter of each line
Invert the letter case
Title-case each line
Strip leading whitespace (spaces, tabs) from the beginning of each line
Strip trailing whitespace (spaces, tabs) from the end of each line
Strip whitespace (spaces, tabs) from the beginning and end of each line
Convert UNIX newlines to DOS/Windows newlines
Convert DOS/Windows newlines to UNIX newlines
Convert UNIX newlines to Mac newlines
Substitute (find and replace) “foo” with “bar” on each line
Substitute (find and replace) “foo” with “bar” on lines that match “baz”
Print paragraphs in reverse order
Print all lines in reverse order
Print columns in reverse order
