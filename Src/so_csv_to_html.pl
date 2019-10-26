#!/usr/bin/perl

use strict; use warnings; use v5.26;
use Text::CSV;
use Getopt::Long qw/GetOptions/;
use Pod::Usage qw/pod2usage/;


sub usage() {
    pod2usage(
        -message => "Error: csv_to_md, not enought argument",
        -exitval  => 1,
        -verbose => 2);
}

# Get option
GetOptions(
    'in=s' => \my $sf_csv,
    'out=s' => \my $sf_md,
    'tag=s' => \my $tag,
    'help|?' => \my $help
) or usage();
$sf_csv or usage();
$help and usage();

# Go
say "---> Csv to MD";
main();

# Read CSV to array of md
sub arg_to_str {
    # Garde foux pour terminer les font formating si line dropped by a mal interpreted \
    my $row_suffix = "</b> </em> </i> </small> </strong> </sub> </sup>";

    # Open
    open my $fh, "<:encoding(utf8)", $sf_csv or die "Usage: $0: $!";

    # Init
    my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
                    or die "Cannot use CSV: ".Text::CSV->error_diag ();

    ## Discard the fisrt line
    $csv->getline( $fh );
    my @res;
    my $ln = 0;
    while ( my $row = $csv->getline( $fh ) ) {
        $ln++;
        my $q_year = (split /-/, $row->[5])[0];
        my $line = ""
            . "\n" . $row_suffix . "\n\n"
            . "### $ln: $row->[1] (score [$row->[2]](https://stackoverflow.com/q/$row->[0]) in $q_year)\n"
            . "\n#### Question\n$row->[3]";
        if ($row->[6]) { $line .= "\n#### Answer accepted (score $row->[7])\n$row->[6]" ;}
        if ($row->[9]) { $line .= "\n#### Answer 2 (score $row->[10])\n$row->[9]";}
        if ($row->[12]) { $line .= "\n#### Answer 3 (score $row->[13])\n$row->[12]";}
        push @res, $line;
    }
    $csv->eof or $csv->error_diag();
    close $fh;
    return @res;
}


# Treat a single post in md
sub treat {
    # In
    my $post = shift;

    # Code tag as variable
    $post =~ s|<pre(?![^>]*lang-html)[^>]*><code>([\S\s]*?)</code></pre>|```$tag\n$1```|g;
    # If ``` is not at BOL or followed
    $post =~ s|(.)```|$1\n```|g;
    $post =~ s|```(?!$tag)(.)|```\n$1|g;
    # Inline code
    $post =~ s|<code>(.*?)</code>|`$1`|g;

    # Remove windows line ending
    $post =~ s/\r//g;

    # Paragraph
    $post =~ s|^(\s*)<p>(.*?)</p>|$1$2  |mg;
    $post =~ s|^</?p>$||mg;

    # Headings
    $post =~ s|<h[1234]>|<h5>|g;
    $post =~ s|<h/[1234]>|</h5>|g;

    # Escape \u000C
    $post =~ s|\\u|\\\\u|g;

    # Characters
    ## TODO Avoid some windows path to cut end of line then make all it
    ## but not in code blocks

    # Prefix
    return $post;
}


sub dump_md {
    # In
    my $posts = shift;
    my $path = shift;
    open my $fh, ">:encoding(utf8)", $path or die "Write faile: $path: $!";

    # Add header (as a post)
    my $title = "@{[ ucfirst $tag ]} <- StackOverflow top ${\(scalar @$posts)}";
    my $header = <<"END_HEADER";
---
title: $title
category: $tag
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">
END_HEADER
    my $footer = <<"END_FOOTER";

</section>
END_FOOTER
    unshift @$posts, $header;
    push @$posts, $footer;


    # Out
    say $fh @$posts;
    close $fh;

    # Return
    return $title;
}


# Not used
sub pandoc_html {
    my $md_path = shift; 
    my $html_path = $md_path =~ s/.md$/.html/r;
    system "pandoc $md_path 
        -t html
        -f markdown-auto_identifiers
        -o $html_path"
        =~ s/\n/ /gr;
}

sub main {
    say 'Read cvs';
    my @in = arg_to_str;

    say 'Treat';
    my @out;
    for my $post (@in) {
        $post = treat $post;
        push @out, $post;
    }

    say 'Write md';
    my $md_path = $sf_md || $sf_csv =~ s/\.[^.]*/.md/r;
    my $title = dump_md(\@out, $md_path);
    $title = substr $title, 1;


    return;
}

__END__
=head1 Name
So_csv_to_md: Convert:
from: cvs <- (from StackOverflow sql query)
to: md -> html

=head1 Option
=over 8
=item B<-help>
    print me
=item B<-in>
    filepath_in.csv
=item B<-out>
    -filepath_out.md
=item B<-tag>
    tag I selected first in the sql query (template next to this script)
=back

=head1 Example
Ex: pl csv_to_md.pl -i so_perl_top_1000.csv -o ~/Test/so_perl100.md -t perl

=head1 Comment
CSV (use in $row->[0]):
    0ID, 1Title, 2Score, 3,4,5question,score,date
    6,7,8answer1,score,date 9,10,11answser2, 12,13,14answer3


=cut
