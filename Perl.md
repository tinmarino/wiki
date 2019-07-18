* [Perldoc](Perl-Perldoc)
* [One_Liners](Perl-One_Liners)
* [Perl Programming Note](Perl-Programming-Note)
* [Japh](Perl-Japh) : Just Another Perl Hacker

# Old
* [If & For & Sub = Structures](Perl-Structure)
* [List & Hash = Arrays](Perl-Array)
* [/ = Regexp (Downloaded)](Perl-Regexp-Downloaded)
* [Tutorial France Anger](Perl-Tuto-France)
* [Cheatsheet_one_page](Perl-Cheatsheet_one_page)
* [Perl One_Liners_old](Perl-One_Liners_old)
* [Perl Snippet](Perl-Snippet)

# Tips

use Number::Format 'format_number'
glob
.perldlrc  # to edit and load automatically some libs


Symbol table edition
	for (keys %main::){say}
	*sym = $main::{"/"}

Use Unicode::Collate::Sort  

my $foo = "zombies are the bombies";if ($foo =~ /             zombie  # sorry pirates            /x ) {    print "urg. brains.\n";}
/x modifier for pretty regzx print

Even without the /x modifier, you can enclose comments in (?# ... ):my $foo = "zombies are the bombies";if ( $foo =~ /zombie(?# sorry pirates)/ ) {    print "urg. brains.\n";}


Add to path
  use lib qw(.); # Will add your cwd to @INC
  use lib qw(. /path/to/my/home /some/other/dir); # will add those dirs 
  perl -I/path/to/include script
  
Get package path
  perl -MTime::HiRes -e 'print $INC{"Time/HiRes.pm"}' or perldoc -l Time::HiRes
	cpan -D Time::HiRes

How do I completely remove an element from an array?
	@array = grep { $_ != $element_omitted } @array;
	```
	@files = qw(/foo/bar/file.pdf /foo/baz/file2.jpg);

	foreach $file (@files) {
			# exclude any files whose full name contains the string 'bar'
			next if $file =~ /bar/;

			# print all other files
			print "$file\n";
	}
	```

Pdl
	pdl >demo



Profiling

	perl -d:DProf program.pl
	dprofpp
	dprofpp -p program.pl
	perl -d:NYTProf some_perl.pl
	nytprofhtml
	
	perldoc perldebguts
	
	
Print Hash
	print "$_ $h{$_}\n" for (keys %h);

Extend @LIB
	export PERL5LIB=/home/foobar/code
	use lib '/home/foobar/code';
	use My::Module;
	perl -I /home/foobar/code script.pl  # That is a capital i like include
	

Fork Bomb
	perl -e "fork while fork" &
		
Console 
	perl -de1 # debugging a trivial programe

Write multiple line regex  
	* Delete the space, then type CtrlV, CtrlJ.  
		Then Return.  
		The Ctrl-V prevents the shell interpreting the next character (newline) literally.
	* toto
		

Match brace, bracket or parenthesis
	* Use Text::Balanced
	*
	```
	my $re; $re = qr/ \{ (?: [^{}]* | (??{$re}) )* \} /x;
	my @array = $str =~ /$re/xg;
	```


Get environment variables
	* `$userName =  $ENV{'LOGNAME'};`
	* print "Hello, $userName\n"; 

# Installing modules

tar zxf Digest-SHA1-2.13.tar.gz
cd Digest-SHA1-2.13
perl Makefile.PL
make
make test
make install

tar zxf ...
cd ...
perl Build.PL
./Build
./Build test
./Build install

# Command line

Interactive shell
	* perl -de1
	* rlwrap perl -d -e 1
	* perlconsole (get history)
	* see psh
	* reply (the best because it uses readline)
	
Change file content
	* perl -i.bak  -p -e 's/old/new/g;' *.config


| Argument   | Description |
| ---------- | --- |
| -0         | Split on NULL byte (almost never) |
| -00        | Split on paragraph |
| -0777      | Treat the file as a whole (do not delete new lines |
| -I path    | Add path to @INC |
| -i[.bak]   | Do in place substitution like : |
|            | `perl -i.bak -ne 'print unless /^#/' script.sh` |
| -a         | Enable autosplit mode : split input lines on whitespace into the @F array |
|            | `ls -l <bar> perl -lane 'print "$F[7] $F[1]"'` |
| -F:        | Choose the -a delimiter (here :) |
|            | `perl -F: -lane 'print $F[0]' /etc/passwd` |
|            |   |
| -MModule   | Include module : `-MRegexp::Common` |
|            | `perl -MList::Util=max -ape 's/$/" " . max(@F)/e unless $.==1' input` |
|            | `-Mmodule=foo,bar` is `use module split(/,/,q{foo,bar})` |
| -n         | Process files line by line |
| -p         | Process line by line and print output |
| -l         | Remove newline char before giving line to you (and add it at the end) |
| -v         | Check Perl version |

The perl command is in apostrophes, and escaping those is hard work…
So if your regex happens to contain apostrophes, first place it in an env variable then refer to it by name :
	env mypattern="'\w+" perl -0777 -ne 'while(m/$ENV{mypattern}/g){print "$&\n";}' yourfile


# Packages

cpan install CPAN
cpan reload cpan

|                |   |
| ---            | --- |
| Cwd            | Change working directory |
| Reply          | Read Execute Print Loop |
| PDL            | Perl Data Library |
| PDL::IO::Image | Image manipulation (object) |

# Regexp

| Regexp        | Meaning |
|---------------|---|
| `(?=regex)`   | Positive lookahead |
| `(?!regex)`   | Negative lookahead |
| `(?=(regex))` | Capturing lookahead |
| `(?<=text)b`  | Positive lookbehind |
| `(?<!text)b`  | Negative lookbehind |
| `(?:regex)`   | Non capturing group |
| `\K`          | \vs in vim (start recording) |



| Modifer | Meaning |
|---------|---|
| s       | Include newlines in . |
| m       | Include newlines in ^ and $ |
| r       | Non destructive |


# Links (maybe to parse and add)
* Readen from France/Anger http://www.info.univ-angers.fr/~gh/tuteurs/tutperl.htm#dataty
