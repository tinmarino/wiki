http://www.softpanorama.org/Scripting/Perlorama/perl_in_command_line.shtml



Hi:

    perl -e 'print "hello world!\n"'

A simple filter:

    perl -ne 'print if /REGEX/'

Filter out blank lines (in place):

    perl -i -ne'print if /\w/'

Search and replace (in place):

    perl -i -pe's/SEARCH/REPLACE/' 

Add first and penultimate columns:

    perl -lane 'print $F[0] + $F[-2]'

Just lines 15 to 17:

    perl -ne 'print if 15 .. 17' *.pod

In-place edit of *.c files changing all foo to bar:

    perl -p -i.bak -e 's/\bfoo\b/bar/g' *.c

Command-line that prints the first 50 lines (cheaply):

    perl -pe 'exit if $. > 50' f1 f2 f3 ...

Delete first 10 lines:

    perl -i.old -ne 'print unless 1 .. 10' foo.txt

Change all the isolated oldvar occurrences to newvar:

    perl -i.old -pe 's{\boldvar\b}{newvar}g' *.[chy]

Command-line that reverses the whole file by lines:

    perl -e 'print reverse <>' file1 file2 file3 ....

Find palindromes:

    perl -lne 'print if $_ eq reverse' /usr/dict/words

Command-line that reverse all the bytes in a file:

    perl -0777e 'print scalar reverse <>' f1 f2 f3 ...

Command-line that reverses the whole file by paragraphs:

    perl -00 -e 'print reverse <>' file1 file2 file3 ....

Increment all numbers found in these files:

    perl i.tiny -pe 's/(\d+)/ 1 + $1 /ge' file1 file2 ....

Command-line that shows each line with its characters backwards:

    perl -nle 'print scalar reverse $_' file1 file2 file3 ....

Delete all but lines between START and END:

    perl -i.old -ne 'print unless /^START$/ .. /^END$/' foo.txt

Binary edit (careful!):

    perl -i.bak -pe 's/Mozilla/Slopoke/g' /usr/local/bin/netscape

Duplicate words:

    perl -0777 -ne 'print "$.: doubled $_\n" while /\b(\w+)\b\s+\b\1\b/gi'

Print the last 50 lines (expensive!):

    perl -e '@lines = <>; print @lines[ $#lines .. $#lines-50' f1 f2 f3 ...

Move files < 1000 bytes to DIR:

    ls -l *xls | perl -na -F'/\s+/' -e 'print "$F[8]\n" if $F[4] < 1000' |
    xargs -J % mv % DIR

Print 1st, 2nd, and last columns (use -l for auto-line-end processing):

    perl -F"\t" -nlae'print join "\t", @F[0,1,-1]' 

Print columns 1-20:

    perl -F"\t" -nlae'print join "\t", @F[0..19]'

Print all filenames & their line #s w/ pattern:

    perl -ne'if (/PATTERN/) { print "$ARGV: $.\n" }; $. = 0 if eof'

Print file up to some pattern:

    perl -ne'if (/PATTERN/) { close ARGV } else { print }'

Inclusive of line w/ pattern:

    perl -pe'if (/PATTERN/) { close ARGV }'

Delete columns of file after column N+2:

    perl -i -F'\t' -nlae'print join "\t", @F[0..N]' 

Insert new column after column N:

    perl -i -F'\t' -nae'print join "\t", @F[0..N], "new", @F[N+1..$#F]'

Cut files in dir at pattern & omit blank lines:

    perl -i -ne 'if (/PATTERN/) { close ARGV } else { print unless /^$/ }'

Insert line numbers in a file:

    perl -i -ne 'printf "%04d %s", $., $_'

Insert text at line N:

    perl -i -pe 'print "text\n" if $. == N; $. = 0 if eof'

Print filenames of files containing pattern in first N lines:

    perl -n -e 'if (/PATTERN/) { print "$ARGV\n"; close ARGV }' 
            -e 'close $ARGV if $. = N'

Return part of select filenames:

    perl -ne '$ARGV =~ /^(.*)\.TXT$/; print "$&\n"; close ARGV'

Add columns M thru N and insert total:

    perl -F'\t' -nlae '$t=0; $t += $_ for @F[M..N]; print "$_\t$t" '

Replace pattern on first line of each file:

    perl -i -pe'
        $new = 1; 
        s/PATTERN/REPLACE/ if $new; 
        $new = eof(ARGV) ? 1 : 0'

Create two columns of random numbers:

    jot -r 100 | rs 50

Given a list of random numbers, ranging from 1 to 20, show the count
of those numbers >= 10 and those < 10:

    jot -r 20 1 20 | perl -ne 'print $_ >= 10 ? 1 : 0, "\n"' | sort | uniq -c

... or showing percentages:

    jot -r 20 1 20 
      | perl -ne 'print $_ >= 10 ? 1 : 0, "\n"' 
      | sort 
      | uniq -c 
      | cut -c 3-4 
      | perl -ne'chomp; $sum += $_; push @counts, $_; 
                END { print $_, " : ", $_ / $sum, "\n" for @counts }'

... or to show the percentage of nines in the list:

      | perl -ne 'print $_ == 9 ? 1 : 0, "\n"' 

Given a list of numbers, ranging from 0 to 20,000, show the distribtion (i.e., 
individual counts) of those numbers after each is rounded to the nearest 
$1,000 increment:

    jot -r 20 0 20000 
      | perl -pe'$_ = 1000 * int($_/1000)."\n"' 
      | sort -n 
      | uniq -c

... or showing percentages:

    jot -r 20 1000 20000 
      | perl -pe'$_ = 1000 * int($_/1000) . "\n"' 
      | sort -n
      | uniq -c 
      | perl -ne'($n,$num) = /(\d+)/g; $counts{$num} = $n; $sum += $n; 
                  END { print $_, 
                        " : ", 
                  $counts{$_} / $sum, "\n" 
                  for sort {$a<=>$b} keys %counts }'

... or to find the median (i.e., the middle number):

	    | perl -e'@lines = <>; print $lines[int($#lines/2)]'

... or to find the average:

    jot -r 20 0 20000 | perl -pe'$_=1000 * int($_/1000)."\n"'
