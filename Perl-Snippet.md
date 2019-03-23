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
