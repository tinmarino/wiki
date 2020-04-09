### So never posted

I am trying to write a [Slang for Raku without sigil](https://github.com/tinmarino/nogil).

So I want the `nogil` token, matching anythin `<?>` to return a clean Match (actually a NQPMatch) but when Grammar.nqp is calling [`$<sigil>.Str`](https://github.com/rakudo/rakudo/blob/master/src/Perl6/Grammar.nqp#L2334) I want the result to be '$'.



Currently my token sigil look like that 

```raku
token sigil {
    | <[$@%&]>
    | <?{ by-variable }> <nogil> { say "Nogil returned: ", lk($/, 'nogil').Str; }
}
token nogil-proxy {
    | '€'
    | <?>
    {log "No sigil:", get-stack; }
}
```

And the method with that should return a `NQPMatch` with method `Str` overwritten 
```raku
method nogil {
    my $cursor := self.nogil-proxy;
    # .. This si where Nqp expertise would be nice
    say "string is:", $cursor.Str;
    return $cursor;
}
```

```raku
$cursor.^cache_add('Str', sub { return '$'; } );
$cursor.^publish_method_cache;
for $cursor.^attributes { .name.say };
for $cursor.^methods { .name.say };
say $cursor.WHAT.Str;
nqp::setmethcacheauth($cursor, 0);
```

Currently, most of my tests work but I have problems in declarations without my (with `no strict`) like `my-var = 42;` because they are considered as method call.

@Arne-Sommer already make a [post](https://stackoverflow.com/questions/55079169) and an [article](https://raku-musings.com/eu.html)

#######################################





```raku
=head2 List: How can I concatenate lists?

Use the slip prefix (L<C<|>|/language/operators#prefix_|>) or the L<flat|/routine/flat> routine

=begin code
my @a = <a b c>;
my @b = <d e f>;
my @ab = |@a, |@b; say @ab;  # OUTPUT: «[a b c d e f]␤»
say (@a, @b).flat;           # OUTPUT: «(a b c d e f)␤»
=end code

Note that flat recursively flattens L<non-containerized|/language/containers> L<iterables|/type/Iterable>.


=head2 List: How can I remove duplicates items in a list?

Use L<.unique|/routine/unique>:

=begin code
(1, 2, 3, 2, 3, 1, 1, 0).unique;  # OUTPUT: «(1 2 3 0)␤»
=end code


=head2 List: How can I delete an element from a list?

To delete by index, use L<.splice|/routine/splice>:

=begin code
my @a = <3 18 4 8 92 14 30>;
say @a.splice(3, 1);  # OUTPUT: «[8]␤»
say @a;               # OUTPUT: «[3 18 4 92 14 30]␤»
=end code

Note that the L<delete subscript|/language/subscripts#index-entry-:delete_(subscript_adverb)> replaces the element with its natural (i.e. default) state. Here (Any):

=begin code
my @a = <3 18 4 8 92 14 30>;
@a[3]:delete;
say @a;  # OUTPUT: «[3 18 4 (Any) 92 14 30]␤»
=end code

To delete by value, use L<.grep|/routine/grep>:

=begin code
my @letters = <a b c>;
@letters .= grep: * ne "b";
say @letters;  # OUTPUT: «[a c]␤»
=end code


=head2 List: How can I show index while looping through a list?

Use L<.kv|/routine/kv> or L<.pairs|/routine/pairs>:

=begin code
my @aa = 8 .. 12;
for @aa.kv -> $i, $_ { say "$i: $_" };     # OUTPUT: «0: 8␤1: 9␤2: 10␤3: 11␤4: 12␤»
say "$_.key(): $_.value()" for @aa.pairs;  # OUTPUT: «0: 8␤1: 9␤2: 10␤3: 11␤4: 12␤»
=end code

=head2 List: How can I generate a list of random numbers?

Use L<.roll|/routine/roll>:

=begin code
say (1..100).roll(50);   # prints 50 numbers between 1 and 100
say [+] (1..6).roll(4);  # prints 1 number = 4d6
for (1..10).roll(*) { .say; last if $_ == 9 };  # * is creating a lazy list
=end code

=head2 List: How can I get a list of repeated item?

Use the L<xx infix|/routine/xx> operator:

=begin code
say 42 xx 3;  # OUTPUT: «(42 42 42)␤»
=end code

=head2 List: How can I get the sum of a list of numbers?

Use the C<[+]> L<reduction metaoperator|/operators#Reduction_metaoperators>:

=begin code
say [+] 1..10;  # OUTPUT: «55␤»
=end code

=head2 List: How can I add two lists element wise?

Use the C<Z+> L<zip metaoperator|/operators#Zip_metaoperator>:

=begin code
say [1, 37, 12] Z+ [41, 5, 30];  # OUTPUT: «(42 42 42)␤»
say 1..10 Z+ 2 <<*>> 100 xx 10;  # OUTPUT: «(201 202 203 204 205 206 207 208 209 210)␤»
=end code


=head2 System: How can I check the execution operating system

L<$*KERNEL|/language/variables#$*KERNEL> gives information on the underlying kernel.
To check is running on windows use L<$*DISTRO|/language/variables#$*DISTRO>.is-win.


=head2 System: How can I work with file and folder

=item Delete: L<unlink|/routine/unlink> 'file.txt'; for a file, L<rmdir|/routine/rmdir> "dir"; for a directory

=item Copy: 'file-from.twt'.L<copy|/type/IO::Path#routine_copy>('file-to.txt');

=item Move: 'file-or-dir-from'.L<rename|/type/IO::Path#routine_rename>('file-or-dir-to');

=item Create: 'file-or-dir-from'.L<rename|/type/IO::Path#routine_rename>('file-or-dir-to');

=item Read: say 'file.txt'.IO.L<slurp|/type/IO::Path#routine_slurp>;

=item List: say 'dir'.IO.L<dir|/type/IO::Path#routine_dir>;

=item Inspect: say 'file.txt'.IO.L<absolute|/type/IO::Path#method_absolute>; say $filename.IO.L<extension|/type/IO::Path#method_extension>;

=item Check: say 'exists' if 'file.txt'.IO.L<e|/type/IO::Path#method_e>;
say 'is a file' if 'file.txt'.IO.L<f|/type/IO::Path#method_f>;
say 'is a directory'  if 'dir'.IO.L<d|/type/IO::Path#method_d>;

=item Write: 'file.txt'.IO.L<spurt|/type/IO::Path#method_spurt>: 'I ❤ 🦋'; Use the C<:append> adverb to append.

=item Open: my $fh = 'file.txt'.IO.L<open|/type/IO::Path#method_open>;

File handles are powerfull, read the L<overview|/language/io>, L<guide|/language/io-guide> or L<IO::Path|/type/IO::Path>. As usual, there are hundreds of ways to code with them, find yours!


=head2 System: How can I recursively list file (find command)

Build a recursive function:

=begin code
sub find-files ($dir, Mu :$test) {
    gather for dir $dir -> $path {
        if $path.basename ~~ $test { take $path }
        if $path.d                 { .take for find-files $path, :$test };
    }
}
.put for find-files '.', test => /'.txt' $/;
=end code

Or use File::Find module:

=begin code
use File::Find;
.say for find dir => '.', name => /'.txt' $/;
=end code


=head2 System: How can I read from STDIN

L<$*IN|/language/variables#Special_filehandles:_STDIN,_STDOUT_and_STDERR> is the default variable when no object is specified to a <IO::Path|/type/IO::Path> method

=begin code
say slurp;          # Print all STIND
.say for lines();   # Print STDIN line by line
say get();          # Consume and print one line of STDIN
=end code
```
