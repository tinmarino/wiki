= Perl 6 Style Guide
:toc: preamble

This is a styleguide for writing https://perl6.org/[Perl 6] code. It's still in
it's early stages, and feedback would be greatly appreciated. Also note that
this is a set of rules for https://scriptkitties.church[Scriptkitties]
projects, not necesarily for you.

== Meta
=== Module hierarchy
Modules should keep the following hierarchy in their root directory:

- `bin` for executable files, if any.
- `lib` for the actual source of the module.
- `t` for tests
- `resources` for additional resources

==== Source file name extensions
Perl 6 source files must use `.pm6` and `.pl6` as extensions to properly
indicate they are Perl 6 files, and not Perl 5.

=== Shebang
All Perl 6 source files must have a
https://en.wikipedia.org/wiki/Shebang_(Unix)[shebang]. For scripts that are
intended to be executed as programs, this would be the following:

[souce,sh]
----
#! /usr/bin/env perl6
----

*Never* refer to a hardcoded perl6 path, as this is likely to break on the
setups of others.

For modules that are *not* intended to be ran as a standalone program, the
following shebang is to be used:

[source,sh]
----
#! /usr/bin/env false
----

This will ensure the script won't be ran as a standalone program. If it's
included by a program as a module, the shebang is simply interpreted as a
comment, and thus ignored.

=== `use` for the Perl 6 version
Every script must have a `use` statement to indicate which version of Perl 6 is
being used:

[source,perl6]
----
use v6.c;
----

=== Indentation style
The preferred indentation style for Scriptkitties projects is to use **tabs**
for indention. If you need to *align* things, however, you should use spaces:

[source,perl6]
----
sub foo (
	%bar,
) {
	%bar<some-index>    = "Some string";
	%bar<another-index> = "Another string";
}
----

Aligning code is *not* required, but is allowed if you think it will improve
readability of the code.

=== Line length
Lines in Perl 6 source files should not extend the *120 character* mark.
Exceptions for this are cases where the source is easier to understand by
surpassing the 120 character limit.

=== Unicode operators
Unicode operators should be used in favour of the longer ASCII operators.
Depending on your editor, plugins may already be available that convert them on
the fly:

- https://github.com/vim-perl/vim-perl[vim]

== Documentation
=== POD comments
Apply POD comments to your subs. A small description on the method should go
directly above it, and descriptions on the arguments should go above the
arguments themself:

[source,perl6]
----
#| A small description on the sub foo. This is returned on foo.WHY.
sub foo (
	#| What to expect of the bar argument
	Str:D $bar,
) is export {
	…
}
----

== Styles to avoid
=== `else`
Using an `else` is almost never necesary, yet they add a lot of cognitive load
to the source code. As such, you should try to write your code in such a way
that an `else` is not necessary. If you do find a circumstance that you *must*
use an `else` block, the `else` must go on the same line as the closing `}` of
the foregoing `if`:

[NOTE]
====
This is still open for discussion!
====

[source,perl6]
----
if ($some-condition) {
	…
} else {
	…
}
----

=== Misc

* Avoid using $_, unless needed.
[source,perl6]
----
for @array -> $element { # good
	say $element;
}
for @array {
	.say # good
}
.say for @array; # better
----

* Declare constants with my, otherwise they are **automatically** *exported* by any module that uses it.
[source,perl6]
----
constant CONST = 10; # BAD
my constant CONST = 10; # good

# vim: ft=perl6
