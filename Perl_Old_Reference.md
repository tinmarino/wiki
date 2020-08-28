* [Perl One_Liners_old](Perl-One_Liners_old)

### Stdio Large

```perl
open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $n = <>;
$n =~ s/\s+$//;

my @indexes = ();

for (1..$n) {
    my $indexes_item = <>;
    $indexes_item =~ s/\s+$//;
    my @indexes_item = split /\s+/, $indexes_item;

    push @indexes, \@indexes_item;
}

my $queries_count = <>;
$queries_count =~ s/\s+$//;

my @queries = ();

for (1..$queries_count) {
    my $queries_item = <>;
    $queries_item =~ s/\s+$//;
    push @queries, $queries_item;
}

my @result = swapNodes \@indexes, \@queries;

print $fptr join "\n", map{ join " ", @{$_} } @result;
print $fptr "\n";

close $fptr;
```
