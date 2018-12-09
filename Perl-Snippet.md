


perl -p -i -e 's/oldstring/newstring/g' `find ./ -name *.html`


perl -p -i -e 's/oldstring/newstring/g' `grep -ril oldstring *`


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
