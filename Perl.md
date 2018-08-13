# [Perldoc](Perl-Perldoc)

my $foo = "zombies are the bombies";if ($foo =~ /             zombie  # sorry pirates            /x ) {    print "urg. brains.\n";}
/x modifier for pretty regzx print

Even without the /x modifier, you can enclose comments in (?# ... ):my $foo = "zombies are the bombies";if ( $foo =~ /zombie(?# sorry pirates)/ ) {    print "urg. brains.\n";}



* Fork Bomb
        perl -e "fork while fork" &
		
* Console 
	 perl -de1 # debugging a trivial programe
