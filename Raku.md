

* Tie variables
```perl
my $1 := my $b = 2;
```

### String

* .comb -> array of chars
* .chars -> length
* .flip -> reverse
* ~ -> stringify (the intify is +)
* .IO -> get IO::HANDLE


* .index "na" -> first index of occurence
* .rindex "na" -> last index
* .contains "na"
* .substr pos, length
  * .substr *-5 - > last 5 chars (graphemes)


### IO::HANDLE

* .lines -> array of chomped lines
* .slurp
* .spurt -> write clobering


### Array

* .elems -> length
* .end -> index of last
* .unique
* .squish -> unique for sorted
* |@arr -> convert to list (to use with push and unshift)

```perl
# Reduce
my $sum = reduce { $^a + $^b }, 1..10;
say [+] 1, 2, 3,4;  # -> 10
say [\+] 1, 2, 3, 4;  # -> (1 3 6 10)
say [lt] <a b c d e>;  # -> True

# Map
map { $_ * 2 }, 1..10;
map $num -> { $num * 2 }, 1..10;
map { $^a * 2 }, 1..10;

# Filter
grep { /<[aeiouy]>/ }, @array;
grep {'uno'}, %eng2sp.values;
```

```perl
# Type
my Int @arr = 1...20;
# Shaped arrays
my @arr[12] = 22, 12;  # Fill with Any
```

### Hash

```perl
say grep { .value == 2 }, %histo.pairs
%seen{$key}:exists
my %uniq = map { $_ => 1 }, @arr;
my %rev = %hash.kv.reverse;
```

### HOW: Higher Order Working

Can be invoked with `'toto'.^methods`


* .methods 




