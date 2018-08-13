

# Tips 


* Get key from value -> reverse hash table
	my %rhash = reverse %hash;
	my $key = $rhash{$value};
	
	my ($key) = grep{ $bugs{$_} eq '*value*' } keys %bugs;
	print $key;
	
	while (my ($key, $value) = each %by_key) {
		$by_value{$value} = $key;
	}

* Hash : sort
    my @keys = sort { $h{$a} <=> $h{$b} } keys(%h);
    my @vals = @h{@keys};
