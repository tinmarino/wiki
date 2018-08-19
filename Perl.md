# [If & For & Sub = Structures](Perl-Structure)
# [List & Hash = Arrays](Perl-Array)
# [/ = Regexp (Downloaded)](Perl-Regexp-Downloaded)
# [Perldoc](Perl-Perldoc)
# [Tutorial France Anger](Perl-Tuto-France)

my $foo = "zombies are the bombies";if ($foo =~ /             zombie  # sorry pirates            /x ) {    print "urg. brains.\n";}
/x modifier for pretty regzx print

Even without the /x modifier, you can enclose comments in (?# ... ):my $foo = "zombies are the bombies";if ( $foo =~ /zombie(?# sorry pirates)/ ) {    print "urg. brains.\n";}


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


Get environment varaibles
	* `$userName =  $ENV{'LOGNAME'};`
	* print "Hello, $userName\n"; 


# Command line

Interactive shell
	* perl -de1
	* rlwrap perl -d -e 1
	* perlconsole (get history)
	* see psh
	
Change file content
	* perl -i.bak  -p -e 's/old/new/g;' *.config


# Links (maybe to parse and add)
* Readen from France/Anger http://www.info.univ-angers.fr/~gh/tuteurs/tutperl.htm#dataty
