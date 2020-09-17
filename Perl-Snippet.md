
# Mutline match
From: https://unix.stackexchange.com/questions/21076/how-to-show-lines-after-each-grep-match-until-other-specific-match
```bash
perl -lne 'print if /Word A/ .. /Word D/' file
grep -nr  -Pzo '(?s)Popen.*?universal_newlines.*?\n' .
awk '/Word A/,/Word D/' filename
sed -n -e '/Word A/,/Word D/ p' file

# Replace: https://unix.stackexchange.com/questions/26284/how-can-i-use-sed-to-replace-a-multi-line-string
cat alpha.txt | tr '\n' '\f' | sed -e 's/a test\fPlease do not/not a test\fBe/'  | tr '\f' '\n'
perl -0777 -i.original -pe 's/a test\nPlease do not/not a test\nBe/igs' alpha.txt

sed '/^a test$/{
       $!{ N        # append the next line when not on the last line
         s/^a test\nPlease do not$/not a test\nBe/
                    # now test for a successful substitution, otherwise
                    #+  unpaired "a test" lines would be mis-handled
         t sub-yes  # branch_on_substitute (goto label :sub-yes)
         :sub-not   # a label (not essential; here to self document)
                    # if no substituion, print only the first line
         P          # pattern_first_line_print
         D          # pattern_ltrunc(line+nl)_top/cycle
         :sub-yes   # a label (the goto target of the 't' branch)
                    # fall through to final auto-pattern_print (2 lines)
       }    
     }' alpha.txt  
sed '/^a test$/{$!{N;s/^a test\nPlease do not$/not a test\nBe/;ty;P;D;:y}}' alpha.txt

# Sed cheat
# See: docstore.mik.ua/orelly/unix/sedawk/appa_03.htm

:  # label
=  # line_number
a  # append_text_to_stdout_after_flush
b  # branch_unconditional             
c  # range_change                     
d  # pattern_delete_top/cycle          
D  # pattern_ltrunc(line+nl)_top/cycle 
g  # pattern=hold                      
G  # pattern+=nl+hold                  
h  # hold=pattern                      
H  # hold+=nl+pattern                  
i  # insert_text_to_stdout_now         
l  # pattern_list                       
n  # pattern_flush=nextline_continue   
N  # pattern+=nl+nextline              
p  # pattern_print                     
P  # pattern_first_line_print          
q  # flush_quit                        
r  # append_file_to_stdout_after_flush 
s  # substitute                                          
t  # branch_on_substitute              
w  # append_pattern_to_file_now         
x  # swap_pattern_and_hold             
y  # transform_chars                   
```

```perl
sub import {
	no strict 'refs';
	for (qw(add subtract multiply )) {
		*{"main::$_"} = \&$_;
	}
}
```

```perl
      WARNING: THIS MAN IS CLASSIFIED AS A MUNITION
[U.S. ITAR/EAR REGULATIONS -- RSA IN THREE LINES OF PERL]

#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)

FEDERAL LAW PROHIBITS TRANSFER OF THIS MAN TO FOREIGNERS.
```


```perl
perl -p -i -e 's/oldstring/newstring/g' `find ./ -name *.html`


perl -p -i -e 's/oldstring/newstring/g' `grep -ril oldstring *`
```


#!/usr/bin/perl

use strict;
use warnings;

#create an in-memory file
my $fakefile = "1234567890\n";
open my $fh, "+<", \$fakefile
    or die "Cant open file: $!";

my $offset = 5;

seek $fh, $offset, 0
    or die "could not seek: $!";

print $fh "CP1";

print $fakefile;
