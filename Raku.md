* [Raku Regex](Raku-Regex)
* [Raku Nqp](Raku-Nqp)
* [Raku Cheat](Raku-Cheat)
* [Raku OneLiner](Raku-OneLiner)
* [Raky Style](Raky-Style)
* [Raku Guide](Raku-Guide)
* [Raku Y Minute](Raku-Y-Minute)
* [Raku_Mem](Raku_Mem)



* Tie variables
```raku
my $1 := my $b = 2;
```

* Enable not defining variables
```raku
no strict;
```

* Number base
```raku
my $b = :2<11110000>;  # -> 240   ## A binary (base 2) number
my $a = :16<FF>;       # -> 255   ## A hexadecimal (base 16) number
my $b = :2("11110000");  # -> 240   ## A binary (base 2) number
```

### Instrospection

```raku
for "azea".HOW.^attributes { .name.say }
```

###  Dispatch 


* Link: https://perl6.party/post/Perl6-But-Heres-My-Dispatch-So-Callwith-Maybe

call____ — call next matching candidate in the chain and come back here
next____ — just go to next matching candidate in the chain and don't come back
____same — use the same arguments as were used for current candidate
____with — make the operation with these new arguments provided
samewith — make the same call from scratch, following a new dispatch chain, with these new arguments, and come back


### Async

### Types

* Native C types

| Perl          | C |
| ---           | --- |
| int8          | int8_t, also used for char |
| int16         | int16_t, also used for short |
| int32         | int32_t, also used for int |
| int64         | int64_t |
| uint8         | uint8_t, also used for unsigned char |
| uint16        | uint16_t, also used for unsigned short |
| uint32        | uint32_t, also used for unsigned int |
| uint64        | uint64_t |
| Long          | long |
| Longlong      | long Long, at least 64-bit |
| num32         | float |
| num64         | double |
| Str           | string |
| CArray[int32] | int*, an array of ints |
| Pointer[void] | void*, can point to all other types |
| bool          | bool from C99 |
| size_t        | size_t |

* Custom types

| ---     | ---     | --     | --- |
| package | grammar | module | role |
| knowhow | enum    | class  | subset |

# Module

* use loads and imports a module at compile time
* need loads a module at compile time but does not import anything from it
* import imports the names from the loaded module at compile time
* require loads a module at runtime without importing the names

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




