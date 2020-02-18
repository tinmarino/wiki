---
title: Perl HackerRank tips
category: Perl
wiki_css: Css/color_dark_solarized.css, Css/layout_toc.css
header-includes: <script type="text/javascript" src="Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---


### Stdin

* Slurp all stdin to list or string

```perl
my @lines = <STDIN>;
my $str = do { local $/; <STDIN> };
```

* Read all lines (except first)

```perl
sub read_all_lines(){<>;(<STDIN>);}
```


* Read_n_lines: Function to read num then num x lines

```perl
sub read_n_lines(){
    my @res;
    my $n = <> + 0;
    for (1 .. $n) {my $line = <>; chomp $line; push @res, $line;}
    return @res;
}
```

* Inline example

```perl
my @data; my @query;

my $n = <> + 0;
for (1 .. $n) {my $line = <>; chomp $line; push @data, $line;}

my $q = <> + 0;
for (1 .. $q) {my $line = <>; chomp $line; push @query, $line;}
```

### Number of match

Put the regex in list context (to get the number of matches) and put that into scalar context.

```perl
my $number = () = $string =~ /\./gi;
```

```perl
my $string = "one.two.three.four";
my @count = $string =~ /\./g;
print scalar @count;
```


### Branch reset Group `(?|(a)|(b))`

```perl
$Regex_Pattern = '^\d\d(?|(-)|(:)|(\.)|(---))\d\d\1\d\d\1\d\d$';
```

### Forward references `^(\2tic|(tac))+$`

```perl
$Regex_Pattern = '^(\2tic|(tac))+$'
```



### The British and American Style of Spelling

```perl
use v5.26;

sub read_lines(){
    my @res;
    my $n = <> + 0;
    for (1 .. $n) {my $line = <>; chomp $line; push @res, $line;}
    return @res;
}

my @data = read_lines;
my @query = read_lines;
my $data = join " ", @data;

for my $query (@query){
    my $re = '\b' . $query . '|' . $query =~ s/ze$/se/r . '\b';
    my $num = () = $data =~ /$re/gi;
    say $num;
}
```

* One liner

```perl
$;.=<> for(0..<>); s/ze\n?$//, @_=$;=~/\b$_[zs]e\b/g, print$#_+1,$/ while<>
```

### UK and US: Part 2

* Same as above with:

```perl
my $re = '\b' . $query =~ s/our/ou?r/r . '\b';
```

### Detect the Email Addresses

```perl
use v5.26;

sub read_lines(){
    my @res;
    my $n = <> + 0;
    for (1 .. $n) {my $line = <>; chomp $line; push @res, $line;}
    return @res;
}

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

my @data = read_lines;
my $data = join " ", @data;

my $re = /\b\S+\b/;
my @match = $data =~ /\b\S+@\S+\.\S+\b/g;
say join ';', uniq sort @match;
```

* Too slow

```perl
use v5.26;

sub read_lines(){
    my @res;
    my $n = <> + 0;
    for (1 .. $n) {my $line = <>; chomp $line; push @res, $line;}
    return @res;
}

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

my @data = read_lines;
my $data = join " ", @data;

my $rfc5322 = qr{
    \b(?=\S)(
    (?(DEFINE)
        (?<address>         (?&mailbox) | (?&group))
        (?<mailbox>         (?&name_addr) | (?&addr_spec))
        (?<name_addr>       (?&display_name)? (?&angle_addr))
        (?<angle_addr>      (?&CFWS)? < (?&addr_spec) > (?&CFWS)?)
        (?<group>           (?&display_name) : (?:(?&mailbox_list) | (?&CFWS))? ; (?&CFWS)?)
        (?<display_name>    (?&phrase))
        (?<mailbox_list>    (?&mailbox) (?: , (?&mailbox))*)

        (?<addr_spec>       (?&local_part) \@ (?&domain))
        (?<local_part>      (?&dot_atom) | (?&quoted_string))
        (?<domain>          (?&dot_atom) | (?&domain_literal))
        (?<domain_literal>  (?&CFWS)? \[ (?: (?&FWS)? (?&dcontent))* (?&FWS)?
                            \] (?&CFWS)?)
        (?<dcontent>        (?&dtext) | (?&quoted_pair))
        (?<dtext>           (?&NO_WS_CTL) | [\x21-\x5a\x5e-\x7e])

        (?<atext>           (?&ALPHA) | (?&DIGIT) | [!\#\$%&'*+-\/=?^_`{|}~])
        (?<atom>            (?&CFWS)? (?&atext)+ (?&CFWS)?)
        (?<dot_atom>        (?&CFWS)? (?&dot_atom_text) (?&CFWS)?)
        (?<dot_atom_text>   (?&atext)+ (?: \. (?&atext)+)*)

        (?<text>            [\x01-\x09\x0b\x0c\x0e-\x7f])
        (?<quoted_pair>     \\ (?&text))

        (?<qtext>           (?&NO_WS_CTL) | [\x21\x23-\x5b\x5d-\x7e])
        (?<qcontent>        (?&qtext) | (?&quoted_pair))
        (?<quoted_string>   (?&CFWS)? (?&DQUOTE) (?:(?&FWS)? (?&qcontent))*
                            (?&FWS)? (?&DQUOTE) (?&CFWS)?)

        (?<word>            (?&atom) | (?&quoted_string))
        (?<phrase>          (?&word)+)

        # Folding white space
        (?<FWS>             (?: (?&WSP)* (?&CRLF))? (?&WSP)+)
        (?<ctext>           (?&NO_WS_CTL) | [\x21-\x27\x2a-\x5b\x5d-\x7e])
        (?<ccontent>        (?&ctext) | (?&quoted_pair) | (?&comment))
        (?<comment>         \( (?: (?&FWS)? (?&ccontent))* (?&FWS)? \) )
        (?<CFWS>            (?: (?&FWS)? (?&comment))*
                            (?: (?:(?&FWS)? (?&comment)) | (?&FWS)))

        # No whitespace control
        (?<NO_WS_CTL>       [\x01-\x08\x0b\x0c\x0e-\x1f\x7f])

        (?<ALPHA>           [A-Za-z])
        (?<DIGIT>           [0-9])
        (?<CRLF>            \x0d \x0a)
        (?<DQUOTE>          ")
        (?<WSP>             [\x20\x09])
    )

    (?&address)
    )\b(?<=\S)
}x;



my @match;
while ($data =~ /$rfc5322/g){
    push @match, $& ;
}

say join ';', uniq sort @match;
```


### Build a Stack Exchange Scraper

```perl
use v5.26;

my $str; { local $/; $str = <STDIN> }

=pod
<h3><a href="/questions/80407/about-power-supply-of-opertional-amplifier" class="question-hyperlink">about power supply of opertional amplifier</a></h3>
....
asked <span title="2013-08-27 21:49:14Z" class="relativetime">11 hours ago</span>
=cut

my $r1 = qr/
    questions\/(\d*)\/    # question grep(id)                      
    [^>]*?>               # ...>
        ([^<]*?)<         # grep(title)<
    .*?                   # closest ...
    relativetime[^>]*?>   # ... relativetime
        ([^<]*?)<         # grep(title)
    /xs;


my @res;
while ($str =~ /$r1/g){
    push @res, $1 . ';' . $2 . ';' . $3;
}

print join "\n", @res;
```


### Utopian Identification Number

```perl
use v5.26;

=pod

The string must begin with between 0-3 (inclusive) lowercase letters.
Immediately following the letters, there must be a sequence of digits (0-9). The length of this segment must be between 2 and 8, both inclusive.
Immediately following the numbers, there must be atleast 3 uppercase letters.

=cut
my $re = qr/^[a-z]{0,3}\d{2,8}[A-Z]{3,}$/;

sub read_lines(){
    my @res;
    my $n = <> + 0;
    for (1 .. $n) {my $line = <>; chomp $line; push @res, $line;}
    return @res;
}

for my $line (read_lines){
    say $line =~ m/$re/ ? 'VALID' : 'INVALID';
}
```


### Valid PAN number

```perl
use v5.26;

# <char><char><char><char><char><digit><digit><digit><digit><char>
my $re = qr/^[A-Z]{5}\d{4}[A-Z]$/;

sub read_lines(){<>;(<STDIN>);}

for my $line (read_lines){
    say $line =~ m/$re/ ? 'YES' : 'NO';
}
```


### Find Hackerrank

```perl
use v5.26;
<>;
my @lines = <>;
my $r1 = 'hackerrank';
for (@lines){
    given ($_){
        when (/^$r1$/){say 0;}
        when (/$r1$/){say 2;}
        when (/^$r1/){say 1;}
        default {say -1;}
    }
}
```


### IP Address Validation

```perl
use v5.26;
<>;my @lines = <>;
my $r_ipv4 = '((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\\.|$)){4}';
my $r_ipv6 = qr/
  ([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|          # 1:2:3:4:5:6:7:8
  ([0-9a-fA-F]{1,4}:){1,7}:|                         # 1::                              1:2:3:4:5:6:7::
  ([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|         # 1::8             1:2:3:4:5:6::8  1:2:3:4:5:6::8
  ([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|  # 1::7:8           1:2:3:4:5::7:8  1:2:3:4:5::8
  ([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|  # 1::6:7:8         1:2:3:4::6:7:8  1:2:3:4::8
  ([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|  # 1::5:6:7:8       1:2:3::5:6:7:8  1:2:3::8
  ([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|  # 1::4:5:6:7:8     1:2::4:5:6:7:8  1:2::8
  [0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|       # 1::3:4:5:6:7:8   1::3:4:5:6:7:8  1::8  
  :((:[0-9a-fA-F]{1,4}){1,7}|:)|                     # ::2:3:4:5:6:7:8  ::2:3:4:5:6:7:8 ::8       ::     
  fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|     # fe80::7:8%eth0   fe80::7:8%1     (link-local IPv6 addresses with zone index)
  ::(ffff(:0{1,4}){0,1}:){0,1}
  ((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}
  (25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|          # ::255.255.255.255   ::ffff:255.255.255.255  ::ffff:0:255.255.255.255  (IPv4-mapped IPv6 addresses and IPv4-translated addresses)
  ([0-9a-fA-F]{1,4}:){1,4}:
  ((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}
  (25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])           # 2001:db8:3:4::192.0.2.33  64:ff9b::192.0.2.33 (IPv4-Embedded IPv6 Address)
  /x;

for (@lines){
    given ($_){
        when (/^$r_ipv4$/){say 'IPv4';}
        when (/^$r_ipv6$/){say 'IPv6';}
        default {say 'Neither';}      
    }
}
```


### Split the Phone Numbers

```perl
use v5.26;
<>;my @lines = <>;
my $r = '^(\d+)[- ](\d+)[- ](\d+)';
for (@lines){
    $_ =~ m/$r/;
    say "CountryCode=$1,LocalAreaCode=$2,Number=$3";
}
```


### Detect HTML Attributes

```perl
use v5.26;
use Set::Scalar;

<>;
my $text = do { local $/; <STDIN> };
my %hash;

# Use grep to filter so we only look at lines with a start tag in them
for my $input ( grep { /<\w/ } split />/, $text ) {

    # Get the tag:
    unless ( $input =~ /<(\w+)/ ) { continue; }
    my $tag = $1;

    # Get the attribute-value pairs
    # @matches will be empty if there are none
    my @matches = $input =~ /\s(\w+)=["'].*?["']/g;
    if ( $hash{$tag} ) {
        $hash{$tag}->insert(@matches);
    }
    else {
        $hash{$tag} = Set::Scalar->new(@matches);
    }
}

# Print out
for my $tag (sort keys %hash) {
    say "$tag:" . join (",",  sort $hash{$tag}->elements);
}
```


### Matching

#### Word Boundaries

```perl
$Regex_Pattern = '\b[aeiouAEIOU][a-zA-Z]*\b';

$Test_String = <STDIN> ;
if($Test_String =~ /$Regex_Pattern/){
    print "true";
} else {
    print "false";
}
```

#### Alternative Matching

```perl
$Regex_Pattern = '^(?:Mr|Mrs|Ms|Dr|Er)\.[[:alpha:]]++$';
```

#### Negative Lookbehind

```perl
$Regex_Pattern = '(?<![aeiuoAEIOU]).';

$Test_String = <STDIN> ;
$count = () = $Test_String =~ /$Regex_Pattern/g;
print "Number of matches : ",$count ;
```

#### Matching {x, y} Repetitions

```perl
$Regex_Pattern = '^\d\d?[[:alpha:]]{3,}\.{0,3}$';
```

#### Matching Same Text Again & Again

```perl
$Regex_Pattern = qr/^([a-z]\w\s\W\d\D[A-Z][a-zA-Z][aeiuoAEIOU]\S)\1$/;
```

#### Backreferences To Failed Groups

```perl
Regex_Pattern = '^\d\d(-?)\d\d\1\d\d\1\d\d$'
```

#### Negative Lookahead

```perl
$Regex_Pattern = '(.)(?!\1)';
```


### Detect HTML Tags

```perl
<>;
my $text = do { local $/; <STDIN> };
my $r = qr/<(\w+).*?>/;
my @res;
sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}
while ($text =~ m/$r/g){
    push @res, $1;
}

print join ";", uniq sort @res;
```


### 

()()()()()()()()()()()()()()()()()()()()
