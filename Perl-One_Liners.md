### All lines Stuff

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


### Numbering

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


### Calculations

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

### Array and string

Generate and print the alphabet
	perl -E 'say a..z'
	perl -le '$, = ","; print ("a".."z")'
	perl -le '$alphabet = join ",", ("a".."z"); print $alphabet'

Hex - Dec
	perl -le 'use bigint; print 1024->as_hex'
	perl -le 'print hex "400"'

Generate a random eight-character password
	perl -le 'print map { ("a".."z")[rand 26] } 1..8'
	perl -le 'print map { ("a".."z", 0..9)[rand 36] } 1..8'

Create a string of specific length
	perl -E 'say "a"x50'
	perl -e 'print "a"x1024' # For 1K stream
	perl -le '@list = (1,2)x20; print "@list"'

Create an array from a string
	@months = split ' ', "Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"
	@months = qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/

Create a string from the command-line arguments
	perl -E '$, = ", "; say @ARGV' val1 val2 val3
	perl -le 'print "(", (join ",", @ARGV), ")"' val1 val2 val3

Find the numeric values for characters in a string
	perl  -E 'say map {ord . ","} split //, "hello_world"'
	perl -le 'print join ", ", map { ord } split //, "hello world"'
	perl -le 'print join ", ", unpack("C*", "hello world")'
	perl -Mbigint=hex -E 'say join ", ", map {Math::BigInt::as_hex ord} split //, "hello_world"'
	perl -le ' print join ", ", map { sprintf "0x%x", ord $_ } split //, "hello world" '

Convert a list of numeric ASCII values into a string
	pl -E 'say map { chr } (104,101,108,108,111)'
	pl -E 'say map chr, 104,101,108,108,111'

Generate an array with odd numbers from 1 to 100
	perl -le '@odd = grep { $_ & 1 } 1..100; print "@odd"'
	pl -E '$, = ","; say grep { $_ % 2 == 1 } 1..100'

Find the length of a string
	pl -E 'say length "hello"'

Find the number of elements in an array
	perl -le '@array = ("a".."z"); print scalar @array'
	perl -le '@array = ("a".."z"); print $#array + 1'
	perl -le 'print scalar @ARGV' *.txt
	perl -le 'print scalar (@ARGV=<*.txt>)'


### Text convertion

ROT13 a string
	perl -le '$string = "bananas"; $string =~ y/A-Za-z/N-ZA-Mn-za-m/; print $string'
	perl -pi.bak -e 'y/A-Za-z/N-ZA-Mn-za-m/' oranges.txt

Base64-encode a string
	perl -MMIME::Base64 -e 'print encode_base64("string")'
	perl -MMIME::Base64 -0777 -ne 'print encode_base64($_)' file

Base64-decode a string
	perl -MMIME::Base64 -le 'print decode_base64("base64string")'
	perl -MMIME::Base64 -0777 -ne 'print decode_base64($_)' file

URL-escape a string
	perl -MURI::Escape -le 'print uri_escape("http://example.com")'

URL-unescape a string
	perl -MURI::Escape -le 'print uri_unescape("http%3A%2F%2Fexample.com")'

HTML-encode a string
	perl -MHTML::Entities -le 'print encode_entities("<html>")'

HTML-decode a string
	perl -MHTML::Entities -le 'print decode_entities("&lt;html&gt;")'

Convert all text to uppercase
	perl -nle 'print uc'
	perl -ple '$_ = uc'
	perl -nle 'print "\U$_"'

Uppercase only the first letter of each line
	perl -nle 'print ucfirst lc'

Invert the letter case
	perl -ple 'y/A-Za-z/a-zA-Z/'

Title-case each line
	perl -ple 's/(\w+)/\u$1/g'

Strip leading whitespace (spaces, tabs) from the beginning of each line
	perl -ple 's/^\s+//' array.c

Strip whitespace (spaces, tabs) from the beginning and end of each line
	perl -ple 's/^\s+|\s+$//g'

Convert UNIX newlines to DOS/Windows newlines
	perl -pe 's|\012|\015\012|'

Convert UNIX newlines to Mac newlines
	perl -pe 's|\012|\015|'

Substitute (find and replace) “foo” with “bar” on lines that match “baz”
	perl -pe '/baz/ && s/foo/bar/'
	perl -pe 's/foo/bar/ if /baz/'

Print paragraphs in reverse order
	perl -00 -e 'print reverse <>' file

Print all lines in reverse order
	perl -e 'print reverse <>' array.c
	# Or, to reverse line characters
	perl -lne 'print scalar reverse $_'
	perl -lpe '$_ = reverse'

Print columns in reverse order
	perl -alne 'print "@{[reverse @F]}"'
	perl -F: -alne '$" = ":"; print "@{[reverse @F]}"'

### Selectively Printing and Deleting Lines

The first line of a file (emulate head -1)
	perl -ne 'print; exit' file

The first 10 lines of a file (emulate head -10)
	perl -ne 'print if 1..10' file
	perl -ne 'print if $. <= 10' file
	perl -pe 'exit if $. == 10' file

The last line of a file (emulate tail -1)
	perl -ne '$last = $_; END { print $last }' file
	perl -ne 'print if eof' file

The last 10 lines of a file (emulate tail -10) (use tail)
	perl -ne 'push @a, $_; shift @a if @a>10; END { print @a }' file

Only lines that match a regular expression
	perl -ne 'print if /regex/'

Only lines that do not match a regular expression
	perl -ne 'print unless /regex/'
	perl -ne 'print if !/regex/'

Every line preceding a line that matches a regular expression
	perl -ne '/magic/ && $last && print $last; $last = $_'

Every line following a line that matches a regular expression
	perl -ne 'if ($p) { print; $p = 0 } $p++ if /regex/'
	perl -ne '$p && print; $p = /science/'

Lines that match regular expressions AAA and BBB in any order
	perl -ne '/AAA/ && /BBB/ && print'

Lines that don’t match regular expressions AAA and BBB
	perl -ne '!/AAA/ && !/BBB/ && print'

Lines that match regular expression AAA followed by BBB followed by CCC
	perl -ne '/AAA.*BBB.*CCC/ && print'

Lines that are at least 80 characters long
	perl -lne 'print if length >= 80'
	# with l, I don't count line endings characters

Lines that are fewer than 80 characters long
	perl -ne 'print if length() < 80'

Only line 13
	perl -ne '$. == 13 && print'

All lines except line 27
	perl -ne 'print unless $. == 27'

All lines from 17 to 30
	perl -ne 'print if 17..30'

All lines between two regular expressions (including the lines that match)
	perl -ne 'print if /regex1/../regex2/'

The longest line
	perl -ne '
		$l = $_ if length($_) > length($l);
		END { print $l }
	'

All lines containing digits
	perl -ne 'print if /\d/'

Every second line
	perl -ne 'print if $. % 2'

All repeated lines only once
	perl -ne 'print if ++$a{$_} == 2'

All unique lines
	perl -ne 'print unless $a{$_}++'


###­Useful Regular Expressions


Match something that looks like an IP address
	/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/

Test whether a number is in the range 0 to 255
	/^([0-9]|[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$/

Match an IP address
	my $ip_part = qr/[0-9]|[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]/;
	if ($ip =~ /^$ip_part\.$ip_part\.$ip_part\.$ip_part$/) {
		print "valid ip\n";
	}

Check whether a string looks like an email address
	/\S+@\S+\.\S+/

Check whether a string is a number
	/^[+-]?\d+\.?\d*$/
	perl -MRegexp::Common -ne 'print if /$RE{num}{real}/'

Check whether a word appears in a string twice
	/(word).*\1/

Increase all integers in a string by one
	$str =~ s/(\d+)/$1+1/ge

Extract the HTTP User-Agent string from HTTP headers
	/^User-Agent: (.+)$/  # -> $1

Match printable ASCII characters
	/[ -~]/

Extract all matches from a regular expression
	my @matches = $text =~ /regex/g;

