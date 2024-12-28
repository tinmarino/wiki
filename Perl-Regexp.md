---
title: 'Regular expressions in Perl - a summary with examples'
---

# Table

## Quantifier

|       |   |
| ---   | --- |
| ?     | 0 or 1 |
| +     | 1 or more, may be *? |
| *     | 0 or more |
| *?    | 0 or more non-greeedy |
| {3}   | 3 |
| {3,5} | 3, 4 or 5 |


## Group

|       |   |
| ---   | --- |
| .     | Any char |
| (a)   |   |
| `(a   | b)` |
| (?a)  | Non catpuring |
| [ab]  | Range: a or b |
| [^ab] | Range not |
| [a-q] | Range |

## Anchor

|     |   |
| --- | --- |
| ^   |   |
| $   |   |
| \A  | Start of string |
| \Z  | End of string |
| \b  | Word boundary |
| \B  | Not word boundary |
| \<  | Start of word |
| \>  | End of word |

## Asssertion

|     |   |
| --- | --- |
| ?=  | Lookahead |
| ?!  | Negative lookahead |
| ?<= | Lookbehind |
| ?<! | Negative lookbehind |
| ?>  | Once-only subexpression |
| ?() | Condition if then |
| ?#  | Comment |

and `?|` for if then else
  

# Dump

-------- -----------------------------                           
`\t`     tab                    
`\n`     newline                
`\r`     return (CR)            
`\x`hh   character with hex. code hh                             
-------- -----------------------------                           

: Single characters             

------ -----------------------  
`\b`   “word” boundary          
`\B`   not a “word” boundary    
------ -----------------------  
							   
: “Zero-width assertions”       
                                   

  ------ -----------------------------------------------------------------------------------------
  `\w`   matches any *single* character classified as a “word” character (alphanumeric or “`_`”)
  `\W`   matches any non-“word” character
  `\s`   matches any whitespace character (space, tab, newline)
  `\S`   matches any non-whitespace character
  `\d`   matches any digit character, equiv. to `[0-9]`
  `\D`   matches any non-digit character
  ------ -----------------------------------------------------------------------------------------

  : Matching

[Character sets: specialities inside `[`...`]`]{#sets}
------------------------------------------------------

**Different meanings** apply inside a character set (“character class”)
denoted by `[`...`]` so that, **instead of** the normal rules given
here, the following apply:

  ------------------ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  `[`characters`]`   matches any of the characters in the sequence
  `[`x`-`y`]`        matches any of the characters from x to y (inclusively) in the ASCII code
  `[\-]`             matches the hyphen character “`-`”
  \[`\n`\]           matches the newline; other [single character denotations with `\`](#esc) apply normally, too
  `[^`something`]`   matches any character *except* those that `[`something`]` denotes; that is, immediately after the leading “`[`”, the circumflex “`^`” means “not” applied to all of the rest
  ------------------ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

[Examples]{#ex}
---------------

  expression    matches...
  ------------- ------------------------------------------------------------------------------------------------------------------------------
  `abc`         `abc` (that exact character sequence, but anywhere in the string)
  `^abc`        `abc` at the *beginning* of the string
  `abc$`        `abc` at the *end* of the string
  `a|b`         either of `a` and `b`
  `^abc|abc$`   the string `abc` at the beginning or at the end of the string
  `ab{2,4}c`    an `a` followed by two, three or four `b`’s followed by a `c`
  `ab{2,}c`     an `a` followed by at least two `b`’s followed by a `c`
  `ab*c`        an `a` followed by any number (zero or more) of `b`’s followed by a `c`
  `ab+c`        an `a` followed by one or more `b`’s followed by a `c`
  `ab?c`        an `a` followed by an optional `b` followed by a `c`; that is, either `abc` or `ac`
  `a.c`         an `a` followed by any single character (not newline) followed by a `c`
  `a\.c`        `a.c` exactly
  `[abc]`       any one of `a`, `b` and `c`
  `[Aa]bc`      either of `Abc` and `abc`
  `[abc]+`      any (nonempty) string of `a`’s, `b`’s and `cs` (such as `a`, `abba`, `acbabcacaa`)
  `[^abc]+`     any (nonempty) string which does *not* contain any of `a`, `b` and `c` (such as `defg`)
  `\d\d`        any two decimal digits, such as `42`; same as \\d{2}
  `\w+`         a “word”: a nonempty sequence of alphanumeric characters and low lines (underscores), such as `foo` and `12bar8` and `foo_1`
  `100\s*mk`    the strings `100` and `mk` optionally separated by any amount of white space (spaces, tabs, newlines)
  `abc\b`       `abc` when followed by a word boundary (e.g. in `abc!` but not in `abcd`)
  `perl\B`      `perl` when *not* followed by a word boundary (e.g. in `perlert` but not in `perl stuff`)

### Examples of simple use in Perl statements

These examples use very simple regexps only. The intent is just to show
*contexts* where regexps might be used, as well as the effect of some
“flags” to matching and replacements. Note in particular that matching
is by default *case-sensitive* (`Abc` does not match `abc` unless
specified otherwise).

`s/foo/bar/;`\
replaces the *first* occurrence of the exact character sequence `foo` in
the “current string” (in special variable `$_`{.rpad}) by the character
sequence `bar`; for example, `foolish bigfoot` would become
`barlish bigfoot`

`s/foo/bar/g;`\
replaces *any* occurrence of the exact character sequence `foo` in the
“current string” by the character sequence `bar`; for example,
`foolish bigfoot` would become `barlish bigbart`

`s/foo/bar/gi;`\
replaces any occurrence of `foo` *case-insensitively* in the “current
string” by the character sequence `bar` (e.g. `Foo` and `FOO` get
replaced by `bar` too)

`if(m/foo/)`...\
tests whether the current string contains the string `foo`

------------------------------------------------------------------------


[Date](http://jkorpela.fi/iso8601.html "ISO 8601, the date and time representation standard")
of creation: 2000-01-28. Last revision: 2007-04-16. Last modification:
2007-05-28.

Finnish translation – [suomennos: [Säännölliset lausekkeet
Perlissä](http://www.uta.fi/~jm58660/jutut/ohjelmointi/regexp.html)]{lang="fi"}.

The inspiration for my writing this document was [Appendix : A Summary
of Perl Regular
Expressions](http://www.irt.org/articles/js184/index.htm#appendix) in
Pankaj Kamthan’s [CGI Security : Better Safe than
Sorry](http://www.irt.org/articles/js184/index.htm), and my own repeated
failures to memorize the syntax.


This page belongs to section
[Programming](http://jkorpela.fi/prog/index.html) of the free
information site [IT and communication](http://jkorpela.fi/indexen.html)
by [[Jukka]{lang="fi"} “Yucca”
[Korpela]{lang="fi"}](http://jkorpela.fi/personal.html "Jukka K. Korpela, an IT generalist and specialist (personal home page)").


