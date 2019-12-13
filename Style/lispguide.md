Revision 1.28

Robert Brown

[François-René Rideau](mailto:tunes@google.com)

In memoriam Dan Weinreb

Patterns mean \"I have run out of language.\" --- Rich Hickey

This style guide contains many details that are initially hidden from
view. They are marked by the triangle icon, which you see here on your
left. Click it now. You should see \"Hooray\" appear below.

Hooray! Now you know you can expand points to get more details.
Alternatively, there\'s an \"expand all\" at the top of this document.

Common Lisp is a powerful multiparadigm programming language. With great
power comes great responsibility.

This guide recommends formatting and stylistic choices designed to make
your code easier for other people to understand. For those internal
applications and free software libraries that we develop at Google, you
should keep within these guidelines when making changes. Note however
that each project has its own rules and customs that complement or
override these general guidelines; the speed-oriented QPX low fare
search engine notably has a very different style and feel from the QRes
reservation system.

If you\'re writing Common Lisp code outside Google, we invite you to
consider these guidelines. You may find some of them useful where they
don\'t conflict with other priorities you have. We welcome remarks and
constructive feedback on how to improve our guide, and on what alternate
styles work for you and why.

This guide is not a Common Lisp tutorial. For basic information about
the language, please consult [Practical Common
Lisp](http://www.gigamonkeys.com/book/). For a language reference,
please consult the [Common Lisp
HyperSpec](http://www.lispworks.com/documentation/HyperSpec/Front/index.htm).
For more detailed style guidance, take (with a pinch of salt) a look at
Peter Norvig and Kent Pitman\'s [style
guide](http://norvig.com/luv-slides.ps).

Each guideline\'s level of importance is indicated by use of the
following keywords and phrases, adapted from [RFC
2119](https://www.ietf.org/rfc/rfc2119.txt).

  ------------ ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  MUST         This word, or the terms \"REQUIRED\" or \"SHALL\", means that the guideline is an absolute requirement. You must ask permission to violate a MUST.
  MUST NOT     This phrase, or the phrase \"SHALL NOT\", means that the guideline is an absolute prohibition. You must ask permission to violate a MUST NOT.
  SHOULD       This word, or the adjective \"RECOMMENDED\", means that there may exist valid reasons in particular circumstances to ignore the demands of the guideline, but the full implications must be understood and carefully weighed before choosing a different course. You must ask forgiveness for violating a SHOULD.
  SHOULD NOT   This phrase, or the phrase \"NOT RECOMMENDED\", means that there may exist valid reasons in particular circumstances to ignore the prohibitions of this guideline, but the full implications should be understood and carefully weighed before choosing a different course. You must ask forgiveness for violating a SHOULD NOT.
  MAY          This word, or the adjective \"OPTIONAL\", means that an item is truly optional.
  ------------ ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Unlike RFCs, we don\'t capitalize every instance of one of the above
keywords when it is used.

There are cases where transgression of some of these rules is useful or
even necessary. In some cases, you must seek permission or obtain
forgiveness from the proper people.

Permission comes from the owners of your project.

Forgiveness is requested in a comment near the point of guideline
violation, and is granted by your code reviewer. The original comment
should be signed by you, and the reviewer should add a signed approval
to the comment at review time.

You MUST follow conventions. They are not optional.

Some of these guidelines are motivated by universal principles of good
programming. Some guidelines are motivated by technical peculiarities of
Common Lisp. Some guidelines were once motivated by a technical reason,
but the guideline remained after the reason subsided. Some guidelines,
such those about as comments and indentation, are based purely on
convention, rather than on clear technical merit. Whatever the case may
be, you must still follow these guidelines, as well as other
conventional guidelines that have not been formalized in this document.

You MUST follow conventions. They are important for readability. When
conventions are followed by default, violations of the convention are a
signal that something notable is happening and deserves attention. When
conventions are systematically violated, violations of the convention
are a distracting noise that needs to be ignored.

Conventional guidelines *are* indoctrination. Their purpose is to make
you follow the mores of the community, so you can more effectively
cooperate with existing members. It is still useful to distinguish the
parts that are technically motivated from the parts that are mere
conventions, so you know when best to defy conventions for good effect,
and when not to fall into the pitfalls that the conventions are there to
help avoid.

Fix old code as you go.

A lot of our code was written before these guidelines existed. You
should fix violations as you encounter them in the course of your normal
coding.

You must not fix violations en masse without warning other developers
and coordinating with them, so as not to make the merging of large
branches more difficult than it already is.

There are many topics for additional standardization not covered by
current version of this document, but deferred to future versions.

-   File and directory structure
-   Packages and modularity
-   Threads and locking
-   How to add configurable components
-   CLOS style: initforms, slot and accessor names, etc.
-   Recommendations on max number of slots per class.
-   More concrete examples of good code:
    -   exceptions
    -   transactions, with retry
    -   XML
    -   typing
    -   encapsulation / abstraction
    -   class and slot names
    -   etc.
-   When (not) to use conditional compilation:
    -   modifying the product
    -   conditional debugging/console output/etc.
    -   \"temporarily\" commenting-out blocks of code
    -   etc.

There are some basic principles for team software development that every
developer must keep in mind. Whenever the detailed guidelines are
inadequate, confusing or contradictory, refer back to these principles
for guidance:

-   Every developer\'s code must be easy for another developer to read,
    understand, and modify --- even if the first developer isn\'t around
    to explain it. (This is the \"hit by a truck\" principle.)
-   Everybody\'s code should look the same. Ideally, there should be no
    way to look at lines of code and recognize it as \"Fred\'s code\" by
    its style.
-   Be precise.
-   Be concise.
-   KISS --- Keep It Simple, Stupid.
-   Use the smallest hammer for the job.
-   Use common sense.
-   Keep related code together. Minimize the amount of jumping around
    someone has to do to understand an area of code.

When making decisions about how to write a given piece of code, aim for
the following -ilities in this priority order:

-   Usability by the customer
-   Debuggability/Testability
-   Readability/Comprehensibility
-   Extensibility/Modifiability
-   Efficiency (of the Lisp code at runtime)

Most of these are obvious.

Usability by the customer means that the system has to do what the
customer requires; it has to handle the customer\'s transaction volumes,
uptime requirements; etc.

For the Lisp efficiency point, given two options of equivalent
complexity, pick the one that performs better. (This is often the same
as the one that conses less, i.e. allocates less storage from the heap.)

Given two options where one is more complex than the other, pick the
simpler option and revisit the decision only if profiling shows it to be
a performance bottleneck.

However, avoid premature optimization. Don\'t add complexity to speed up
something that runs rarely, since in the long run, it matters less
whether such code is fast.

To build code that is robust and maintainable, it matters a lot how the
code is divided into components, how these components communicate, how
changes propagate as they evolve, and more importantly how the
programmers who develop these components communicate as these components
evolve.

If your work affects other groups, might be reusable across groups, adds
new components, has an impact on other groups (including QA or Ops), or
otherwise isn\'t purely local, you must write it up using at least a
couple of paragraphs, and get a design approval from the other parties
involved before starting to write code --- or be ready to scratch what
you have when they object.

If you don\'t know or don\'t care about these issues, ask someone who
does.

Often, the smallest hammer is to use an existing library. Or one that
doesn\'t exist yet. In such cases, you are encouraged to use or develop
such a library, but you must take appropriate precautions.

-   You MUST NOT start a new library unless you established that none is
    already available that can be fixed or completed into becoming what
    you need. That\'s a rule against the NIH syndrome (\"Not Invented
    Here\"), which is particularly strong amongst Lisp hackers.
-   Whichever library, old or new, you pick, you MUST get permission to
    incorporate third-party code into the code base. You must discuss
    the use of such library in the appropriate mailing-list, and have
    your code reviewed by people knowledgeable in the domain and/or the
    Lisp library ecosystem (if any). Please be ready to argue why this
    particular solution makes sense as compared to other available
    libraries.
-   Some libraries are distributed under licenses not compatible with
    the software you\'re writing, and must not be considered available
    for use. Be aware of these issues, or consult with people who are.

If you write a general-purpose library, or modify an existing
open-source library, you are encouraged to publish the result separate
from your main project and then have your project import it like any
other open-source library.

Use your judgment to distinguish general-purpose versus
business-specific code, and open-source the general-purpose parts, while
keeping the business-specific parts a trade secret.

Open-Sourcing code has many advantages, including being able to leverage
third parties for development, letting the development of features be
user-directed, and keeping you honest with respect to code quality.
Whatever code you write, you will have to maintain anyway, and make sure
its quality is high enough to sustain use in production. There should
therefore be no additional burden to Open-Sourcing, even of code that
(at least initially) is not directly usable by third parties.

Development process is outside the scope of this document. However,
developers should remember at least these bits: get reviewed, write
tests, eliminate warnings, run tests, avoid mass-changes.

-   All code changes must be reviewed. You should expect that your code
    will be reviewed by other hackers, and that you will be assigned
    other hackers\' code to review. Part of the review criteria will be
    that code obeys the coding standards in this document.
-   You must write and check-in tests for new code that you write and
    old bugs you fix. There must be a unit test for every API function,
    and any previously failing case. Your work is not truly done until
    this activity is complete. Estimating tasks must include the time it
    takes to produce such tests.
-   Your code must compile without any compilation error or warning
    messages whatsoever. If the compiler issues warnings that should be
    ignored, muffle those warnings using the
    `UIOP:WITH-MUFFLED-COMPILER-CONDITIONS` and
    `UIOP:*UNINTERESTING-COMPILER-CONDITIONS*` framework (part of
    `UIOP`, part of `ASDF 3`), either around the entire project, or
    around individual files (using `ASDF`\'s `:around-compile` hooks).
-   All code should be checked in an appropriate source control system,
    in a way that allows for complete reproducibility of build, test and
    execution of the code that is, has been or may be deployed.
-   You must run the \"precheckin\" tests, and each component must pass
    its unit tests successfully before you commit any code.
-   You should incorporate code coverage into your testing process.
    Tests are not sufficient if they do not cover all new and updated
    code; code that for whatever reason cannot be included in coverage
    results should be clearly marked as such including the reason.
-   Many people develop on branches. You must get permission to
    undertake mass-changes (e.g. mass reindentations) so that we can
    coordinate in advance, and give branch residents time to get back on
    the mainline

You must use correct spelling in your comments, and most importantly in
your identifiers.

When several correct spellings exist (including American vs English),
and there isn\'t a consensus amongst developers as which to use, you
should choose the shorter spelling.

You must use only common and domain-specific abbreviations, and must be
consistent with these abbreviations. You may abbreviate lexical
variables of limited scope in order to avoid overly-long symbol names.

If you\'re not sure, consult a dictionary, Google for alternative
spellings, or ask a local expert.

Here are examples of choosing the correct spelling:

-   Use \"complimentary\" in the sense of a meal or beverage that is not
    paid for by the recipient, not \"complementary\".
-   Use \"existent\" and \"nonexistent\", not \"existant\". Use
    \"existence\", not \"existance\".
-   Use \"hierarchy\" not \"heirarchy\".
-   Use \"precede\" not \"preceed\".
-   Use \"weird\", not \"wierd\".

Here are examples of choosing the shorter spelling:

-   Use \"canceled\", not \"cancelled\"
-   Use \"queuing\", not \"queueing\".
-   Use \"signaled\", not \"signalled\";
-   Use \"traveled\", not \"travelled\".
-   Use \"aluminum\", not \"aluminium\"
-   Use \"oriented\", not \"orientated\"
-   Use \"color\", not \"colour\"
-   Use \"behavior\", not \"behaviour\"

Make appropriate exceptions for industry standard nomenclature/jargon,
including plain misspellings. For instance:

-   Use \"referer\", not \"referrer\", in the context of the HTTP
    protocol.

You should format source code so that no line is longer than 100
characters.

Some line length restriction is better than none at all. While old text
terminals used to make 80 columns the standard, these days, allowing 100
columns seems better, since good style encourages the use of descriptive
variables and function names.

Indent your code the way a properly configured GNU Emacs does.

Maintain a consistent indentation style throughout a project.

Indent carefully to make the code easier to understand.

Common Lisp indentation in Emacs is provided by the cl-indent library.
The latest version of cl-indent is packaged with
[SLIME](https://www.common-lisp.net/project/slime/) (under
contrib/slime-cl-indent.el). After installing SLIME, set up Emacs to
load SLIME automatically using [these
instructions](https://www.common-lisp.net/project/slime/doc/html/Loading-Contribs.html),
adding slime-indentation to the list of contrib libraries to be loaded
in the call to slime-setup.

Ideally, use the default indentation settings provided by
slime-indentation. If necessary, customize indentation parameters to
maintain a consistent indentation style throughout an existing project.
Parameters can be customized using the :variables setting in
define-common-lisp-style. Indentation of specific forms can be
customized using the :indentation setting of define-common-lisp-style.
This is particularly useful when creating forms that behave like macros
or special operators that are indented differently than standard
function calls (e.g. defun, labels, or let). Add a
[hook](https://www.gnu.org/software/emacs/manual/html_node/emacs/Hooks.html)
to \'lisp-mode-hook that calls common-lisp-set-style to set the
appropriate style automatically.

Use indentation to make complex function applications easier to read.
When an application does not fit on one line or the function takes many
arguments, consider inserting newlines between the arguments so that
each one is on a separate line. However, do not insert newlines in a way
that makes it hard to tell how many arguments the function takes or
where an argument form starts and ends.

;; Bad (do-something first-argument second-argument (lambda (x) (frob
x)) fourth-argument last-argument) ;; Better (do-something
first-argument second-argument \#\'(lambda (x) (frob x)) fourth-argument
last-argument)

You should include a description at the top of each source file.

You should include neither authorship nor copyright information in a
source file.

Every source file should begin with a brief description of the contents
of that file.

After that description, every file should start the code itself with an
`(in-package :package-name)` form.

After that `in-package` form, every file should follow with any
file-specific `(declaim (optimize ...))` declaration that is not covered
by an `ASDF` `:around-compile` hook.

;;;; Variable length encoding for integers and floating point numbers.
(in-package \#:varint) (declaim \#.\*optimize-default\*)

You should not include authorship information at the top of a file:
better information is available from version control, and such a mention
will only cause confusion and grief. Indeed, whoever was the main author
at the time such a mention was included might not be who eventually made
the most significant contributions to the file, and even less who is
responsible for the file at the moment.

You should not include copyright information in individual source code
files. An exception is made for files meant to be disseminated as
standalone.

Vertical white space: one blank line between top-level forms.

You should include one blank line between top-level forms, such as
function definitions. Exceptionally, blank lines can be omitted between
simple, closely related defining forms of the same kind, such as a group
of related type declarations or constant definitions.

(defconstant +mix32+ \#x12b9b0a1 \"pi, an arbitrary number\")
(defconstant +mix64+ \#x2b992ddfa23249d6 \"more digits of pi\")
(defconstant +golden-ratio32+ \#x9e3779b9 \"the golden ratio\")
(defconstant +golden-ratio64+ \#xe08c1d668b756f82 \"more digits of the
golden ratio\") (defmacro incf32 (x y) \"Like INCF, but for integers
modulo 2\*\*32\" \`(setf ,x (logand (+ ,x ,y) \#xffffffff))) (defmacro
incf64 (x y) \"Like INCF, but for integers modulo 2\*\*64\" \`(setf ,x
(logand (+ ,x ,y) \#xffffffffffffffff)))

Blank lines can be used to separate parts of a complicated function.
Generally, however, you should break a large function into smaller ones
instead of trying to make it more readable by adding vertical space. If
you can\'t, you should document with a `;;` comment what each of the
separated parts of the function does.

You should strive to keep top-level forms, including comments but
excluding the documentation string, of appropriate length; preferrably
short. Forms extending beyond a single page should be rare and their use
should be justfied. This applies to each of the forms in an `eval-when`,
rather than to the `eval-when` itself. Additionally, `defpackage` forms
may be longer, since they may include long lists of symbols.

Horizontal white space: none around parentheses. No tabs.

You must not include extra horizontal whitespace before or after
parentheses or around symbols.

You must not place right parentheses by themselves on a line. A set of
consecutive trailing parentheses must appear on the same line.

;; Very Bad ( defun factorial ( limit ) ( let (( product 1 )) ( loop for
i from 1 upto limit do (setf product ( \* product i ) ) ) product ) ) ;;
Better (defun factorial (limit) (let ((product 1)) (loop for i from 1
upto limit do (setf product (\* product i))) product))

You should use only one space between forms.

You should not use spaces to vertically align forms in the middle of
consecutive lines. An exception is made when the code possesses an
important yet otherwise not visible symmetry that you want to emphasize.

;; Bad (let\* ((low 1) (high 2) (sum (+ (\* low low) (\* high high))))
\...) ;; Better (let\* ((low 1) (high 2) (sum (+ (\* low low) (\* high
high)))) \...))

You must align nested forms if they occur across more than one line.

;; Bad (defun munge (a b c) (\* (+ a b) c)) ;; Better (defun munge (a b
c) (\* (+ a b) c))

The convention is that the body of a binding form is indented two spaces
after the form. Any binding data before the body is usually indented
four spaces. Arguments to a function call are aligned with the first
argument; if the first argument is on its own line, it is aligned with
the function name.

(multiple-value-bind (a b c d) (function-returning-four-values x y)
(declare (ignore c)) (something-using a) (also-using b d))

An exception to the rule against lonely parentheses is made for an
`eval-when` form around several definitions; in this case, include a
comment `; eval-when` after the closing parenthesis.

You must set your editor to avoid inserting tab characters in the files
you edit. Tabs cause confusion when editors disagree on how many spaces
they represent. In Emacs, do `(setq-default indent-tabs-mode nil)`.

You should use document strings on all visible functions to explain how
to use your code.

Unless some bit of code is painfully self-explanatory, document it with
a documentation string (also known as docstring).

Documentation strings are destined to be read by the programmers who use
your code. They can be extracted from functions, types, classes,
variables and macros, and displayed by programming tools, such as IDEs,
or by REPL queries such as `(describe 'foo)`; web-based documentation or
other reference works can be created based on them. Documentation
strings are thus the perfect locus to document your API. They should
describe how to use the code (including what pitfalls to avoid), as
opposed to how the code works (and where more work is needed), which is
what you\'ll put in comments.

Supply a documentation string when defining top-level functions, types,
classes, variables and macros. Generally, add a documentation string
wherever the language allows.

For functions, the docstring should describe the function\'s contract:
what the function does, what the arguments mean, what values are
returned, what conditions the function can signal. It should be
expressed at the appropriate level of abstraction, explaining the
intended meaning rather than, say, just the syntax. In documentation
strings, capitalize the names of Lisp symbols, such as function
arguments. For example, \"The value of LENGTH should be an integer.\"

(defun small-prime-number-p (n) \"Return T if N, an integer, is a prime
number. Otherwise, return NIL.\" (cond ((or (\< n 2)) nil) ((= n 2) t)
((divisorp 2 n) nil) (t (loop for i from 3 upto (sqrt n) by 2 never
(divisorp i n))))) (defgeneric table-clear (table) (:documentation
\"Like clrhash, empties the TABLE of all associations, and returns the
table itself.\"))

A long docstring may usefully begin with a short, single-sentence
summary, followed by the larger body of the docstring.

When the name of a type is used, the symbol may be quoted by surrounding
it with a back quote at the beginning and a single quote at the end.
Emacs will highlight the type, and the highlighting serves as a cue to
the reader that [M-.]{.kbd} will lead to the symbol\'s definition.

(defun bag-tag-expected-itinerary (bag-tag) \"Return a list of
\`legacy-pnr-pax-segment\' objects representing the expected itinerary
of the \`bag-tag\' object, BAG-TAG.\" \...)

Every method of a generic function should be independently documented
when the specialization affects what the method does, beyond what is
described in its generic function\'s docstring.

When you fix a bug, consider whether what the fixed code does is
obviously correct or not; if not, you must add a comment explaining the
reason for the code in terms of fixing the bug. Adding the bug number,
if any, is also recommended.

You must use the appropriate number of semicolons to introduce comments.

Comments are explanations to the future maintainers of the code. Even if
you\'re the only person who will ever see and touch the code, even if
you\'re either immortal and never going to quit, or unconcerned with
what happens after you leave (and have your code self-destruct in such
an eventuality), you may find it useful to comment your code. Indeed, by
the time you revisit your code, weeks, months or years later, you will
find yourself a different person from the one who wrote it, and you will
be grateful to that previous self for making the code readable.

You must comment anything complicated so that the next developer can
understand what\'s going on. (Again, the \"hit by a truck\" principle.)

Also use comments as a way to guide those who read the code, so they
know what to find where.

-   File headers and important comments that apply to large sections of
    code in a source file should begin with four semicolons.
-   You should use three semicolons to begin comments that apply to just
    one top-level form or small group of top-level forms.
-   Inside a top-level form, you should use two semicolons to begin a
    comment if it appears between lines.
-   You should use one semicolon if it is a parenthetical remark and
    occurs at the end of a line. You should use spaces to separate the
    comment from the code it refers to so the comment stands out. You
    should try to vertically align consecutive related end-of-line
    comments.

;;;; project-euler.lisp ;;;; File-level comments or comments for large
sections of code. ;;; Problems are described in more detail here:
https://projecteuler.net/ ;;; Divisibility ;;; Comments that describe a
group of definitions. (defun divisorp (d n) (zerop (mod n d))) (defun
proper-divisors (n) \...) (defun divisors (n) (cons n (proper-divisors
n))) ;;; Prime numbers (defun small-prime-number-p (n) (cond ((or (\< n
2)) nil) ((= n 2) ; parenthetical remark here t) ; continuation of the
remark ((divisorp 2 n) nil) ; different remark ;; Comment that applies
to a section of code. (t (loop for i from 3 upto (sqrt n) by 2 never
(divisorp i n)))))

You should include a space between the semicolon and the text of the
comment.

You should punctuate documentation correctly.

When a comment is a full sentence, you should capitalize the initial
letter of the first word and end the comment with a period. In general,
you should use correct punctuation.

You must follow the convention of using TODO comments for code requiring
special attention. For code using unobvious forms, you must include a
comment.

For comments requiring special attention, such as incomplete code, todo
items, questions, breakage, and danger, include a TODO comment
indicating the type of problem, its nature, and any notes on how it may
be addressed.

The comments begin with `TODO` in all capital letters, followed by the
name, e-mail address, or other identifier of the person with the best
context about the problem referenced by the `TODO`. The main purpose is
to have a consistent `TODO` that can be searched to find out how to get
more details upon request. A `TODO` is not a commitment that the person
referenced will fix the problem. Thus when you create a `TODO`, it is
almost always your name that is given.

When signing comments, you should use your username (for code within the
company) or full email address (for code visible outside the company),
not just initials.

;;\-\-- TODO(george\@gmail.com): Refactor to provide a better API.

Be specific when indicating times or software releases in a TODO comment
and use [YYYY-MM-DD](https://www.w3.org/TR/NOTE-datetime) format for
dates to make automated processing of such dates easier, e.g.,
2038-01-20 for the end of the 32-bit signed `time_t`.

;;\-\-- TODO(brown): Remove this code after release 1.7 or before
2012-11-30.

For code that uses unobvious forms to accomplish a task, you must
include a comment stating the purpose of the form and the task it
accomplishes.

You should document DSLs and any terse program in a DSL.

You should design your Domain Specific Language to be easy to read and
understand by people familiar with the domain.

You must properly document all your Domain Specific Language.

Sometimes, your DSL is designed for terseness. In that case, it is
important to document what each program does, if it\'s not painfully
obvious from the context.

Notably, when you use regular expressions (e.g. with the `CL-PPCRE`
package), you MUST ALWAYS put in a comment (usually a two-semicolon
comment on the previous line) explaining, at least basically, what the
regular expression does, or what the purpose of using it is. The comment
need not spell out every bit of the syntax, but it should be possible
for someone to follow the logic of the code without actually parsing the
regular expression.

You should use lower case. You should follow the rules for [Spelling and
Abbreviations](#Spelling_and_Abbreviations) You should follow
punctuation conventions.

Use lower case for all symbols. Consistently using lower case makes
searching for symbol names easier and is more readable.

Note that Common Lisp is case-converting, and that the `symbol-name` of
your symbols will be upper case. Because of this case-converting,
attempts to distinguish symbols by case are defeated, and only result in
confusion. While it is possible to escape characters in symbols to force
lower case, you should not use this capability unless this is somehow
necessary to interoperate with third-party software.

Place hyphens between all the words in a symbol. If you can\'t easily
say an identifier out loud, it is probably badly named.

You must not use `"/"` or `"."` instead of `"-"` unless you have a
well-documented overarching reason to, and permission from other hackers
who review your proposal.

See the section on [Spelling and
Abbreviations](#Spelling_and_Abbreviations) for guidelines on using
abbreviations.

;; Bad (defvar \*default-username\* \"Ann\") (defvar \*max-widget-cnt\*
200) ;; Better (defvar \*default-user-name\* \"Ann\") (defvar
\*maximum-widget-count\* 200)

There are conventions in Common Lisp for the use of punctuation in
symbols. You should not use punctuation in symbols outside these
conventions.

Unless the scope of a variable is very small, do not use overly short
names like `i` and `zq`.

Name your variables according to their intent, not their content.

You should name a variable according to the high-level concept that it
represents, not according to the low-level implementation details of how
the concept is represented.

Thus, you should avoid embedding data structure or aggregate type names,
such as `list`, `array`, or `hash-table` inside variable names, unless
you\'re writing a generic algorithm that applies to arbitrary lists,
arrays, hash-tables, etc. In that case it\'s perfectly OK to name a
variable `list` or `array`.

Indeed, you should be introducing new abstract data types with
`DEFCLASS` or `DEFTYPE`, whenever a new kind of intent appears for
objects in your protocols. Functions that manipulate such objects
generically may then use variables the name of which reflect that
abstract type.

For example, if a variable\'s value is always a row (or is either a row
or `NIL`), it\'s good to call it `row` or `first-row` or something like
that. It is alright is `row` has been `DEFTYPE`\'d to `STRING` ---
precisely because you have abstracted the detail away, and the remaining
salient point is that it is a row. You should not name the variable
`STRING` in this context, except possibly in low-level functions that
specifically manipulate the innards of rows to provide the suitable
abstraction.

Be consistent. If a variable is named `row` in one function, and its
value is being passed to a second function, then call it `row` rather
than, say, `value` (this was a real case).

Name globals according to convention.

The names of global constants should start and end with plus characters.

Global variable names should start and end with asterisks (also known in
this context as earmuffs).

In some projects, parameters that are not meant to be usually modified
or bound under normal circumstances (but may be during experimentation
or exceptional situations) should start (but do not end) with a dollar
sign. If such a convention exists within your project, you should follow
it consistently. Otherwise, you should avoid naming variables like this.

Common Lisp does not have global lexical variables, so a naming
convention is used to ensure that globals, which are dynamically bound,
never have names that overlap with local variables. It is possible to
fake global lexical variables with a differently named global variable
and a `DEFINE-SYMBOL-MACRO`. You should not use this trick, unless you
first publish a library that abstracts it away.

(defconstant +hash-results+ \#xbd49d10d10cbee50) (defvar
\*maximum-search-depth\* 100)

Names of predicate functions and variables end with a `"P"`.

You should name boolean-valued functions and variables with a trailing
`"P"` or `"-P"`, to indicate they are predicates. Generally, you should
use `"P"` when the rest of the function name is one word and `"-P"` when
it is more than one word.

A rationale for this convention is given in [the CLtL2 chapter on
predicates](http://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node69.html).

For uniformity, you should follow the convention above, and not one of
the alternatives below.

An alternative rule used in some existing packages is to always use
`"-P"`. Another alternative rule used in some existing packages is to
always use `"?"`. When you develop such a package, you must be
consistent with the rest of the package. When you start a new package,
you should not use such an alternative rule without a very good
documented reason.

You should not include a library or package name as a prefix within the
name of symbols.

When naming a symbol (external or internal) in a package, you should not
include the package name as a prefix within the name of the symbol.
Naming a symbol this way makes it awkward to use from a client package
accessing the symbol by qualifying it with a package prefix, where the
package name then appears twice (once as a package prefix, another time
as a prefix within the symbol name).

;; Bad (in-package \#:varint) (defun varint-length64 () \... )
(in-package \#:client-code) (defconst +padding+ (varint:varint-length64
+end-token+)) ;; Better (in-package \#:varint) (defun length64 () \... )
(in-package \#:client-code) (defconst +padding+ (varint:length64
+end-token+))

An exception to the above rule would be to include a prefix for the
names of variables that would otherwise be expected to clash with
variables in packages that use the current one. For instance, `ASDF`
exports a variable `*ASDF-VERBOSE*` that controls the verbosity of
`ASDF` only, rather than of the entire Lisp program.

Use packages appropriately.

Lisp packages are used to demarcate namespaces. Usually, each system has
its own namespace. A package has a set of external symbols, which are
intended to be used from outside the package, in order to allow other
modules to use this module\'s facilities.

The internal symbols of a package should never be referred to from other
packages. That is, you should never have to use the double-colon `::`
construct. (e.g. `QUAKE::HIDDEN-FUNCTION`). If you need to use
double-colons to write real production code, something is wrong and
needs to be fixed.

As an exception, unit tests may use the internals of the package being
tested. So when you refactor, watch out for internals used by the
package\'s unit tests.

The `::` construct is also useful for very temporary hacks, and at the
REPL. But if the symbol really is part of the externally-visible
definition of the package, export it.

You may find that some internal symbols represent concepts you usually
want to abstract away and hide under the hood, yet at times are
necessary to expose for various extensions. For the former reason, you
do not want to export them, yet for the latter reason, you have to
export them. The solution is to have two different packages, one for
your normal users to use, and another for the implementation and its
extenders to use.

Each package is one of two types:

-   Intended to be included in the `:use` specification of other
    packages. If package `A` \"uses\" package `B`, then the external
    symbols of package `B` can be referenced from within package `A`
    without a package prefix. We mainly use this for low-level modules
    that provide widely-used facilities.
-   Not intended to be \"used\". To reference a facility provided by
    package `B`, code in package `A` must use an explicit package
    prefix, e.g. `B:DO-THIS`.

If you add a new package, it should always be of the second type, unless
you have a special reason and get permission. Usually a package is
designed to be one or the other, by virtue of the names of the
functions. For example, if you have an abstraction called `FIFO`, and it
were in a package of the first type you\'d have functions named things
like `FIFO-ADD-TO` and `FIFO-CLEAR-ALL`. If you used a package of the
second type, you\'d have names like `ADD-TO` and `CLEAR-ALL`, because
the callers would be saying `FIFO:ADD-TO` and `FIFO:CLEAR-ALL`.
(`FIFO:FIFO-CLEAR-ALL` is redundant and ugly.)

Another good thing about packages is that your symbol names won\'t
\"collide\" with the names of other packages, except the ones your
packages \"uses\". So you have to stay away from symbols that are part
of the Lisp implementation (since you always \"use\" that) and that are
part of any other packages you \"use\", but otherwise you are free to
make up your own names, even short ones, and not worry about some else
having used the same name. You\'re isolated from each other.

Your package must not shadow (and thus effectively redefine) symbols
that are part of the Common Lisp language. There are certain exceptions,
but they should be very well-justified and extremely rare:

-   If you are explicitly replacing a Common Lisp symbol by a safer or
    more featureful version.
-   If you are defining a package not meant to be \"used\", and have a
    good reason to export a symbol that clashes with Common Lisp, such
    as `log:error` and `log:warn` and so on.

You should avoid side-effects when they are not necessary.

Lisp is best used as a \"mostly functional\" language.

Avoid modifying local variables, try rebinding instead.

Avoid creating objects and the SETFing their slots. It\'s better to set
the slots during initialization.

Make classes as immutable as possible, that is, avoid giving slots
setter functions if at all possible.

Using a mostly functional style makes it much easier to write concurrent
code that is thread-safe. It also makes it easier to test the code.

You should favor iteration over recursion.

Common Lisp systems are not required to implement function calls from
tail positions without leaking stack space --- which is known as proper
tail calls (PTC), tail call elimination (TCE), or tail call optimization
(TCO). This means that indefinite recursion through tail calls may
quickly blow out the stack, which hampers functional programming. Still,
most serious implementations (including SBCL and CCL) do implement
proper tail calls, but with restrictions:

-   The `(DECLARE (OPTIMIZE ...))` settings must favor `SPEED` enough
    and not favor `DEBUG` too much, for some compiler-dependent meanings
    of \"enough\" and \"too much\". (For instance, in SBCL, you should
    avoid `(SPEED 0)` and `(DEBUG 3)` to achieve proper tail calls.)
-   There should not be dynamic bindings around the call (even though
    some Scheme compilers are able to properly treat such dynamic
    bindings, called parameters in Scheme parlance).

For compatibility with all compilers and optimization settings, and to
avoid stack overflow when debugging, you should prefer iteration or the
built in mapping functions to relying on proper tail calls.

If you do rely on proper tail calls, you must prominently document the
fact, and take appropriate measures to ensure an appropriate compiler is
used with appropriate optimization settings. For fully portable code,
you may have to use trampolines instead.

Use special variables sparingly.

Using Lisp \"special\" (dynamically bound) variables as implicit
arguments to functions should be used sparingly, and only in cases where
it won\'t surprise the person reading the code, and where it offers
significant benefits.

Indeed, each special variable constitutes state. Developers have to
mentally track the state of all relevant variables when trying to
understand what the code does and how it does it; tests have to be
written and run with all relevant combinations; to isolate some
activity, care has to be taken to locally bind all relevant variables,
including those of indirectly used modules. They can hide precious
information from being printed in a backtrace. Not only is there
overhead associated to each new variable, but interactions between
variables can make the code exponentially more complex as the number of
such variables increases. The benefits have to match the costs.

Note though that a Lisp special variable is not a global variable in the
sense of a global variable in, say, BASIC or C. As special variables can
be dynamically bound to a local value, they are much more powerful than
global value cells where all users necessarily interfere with each
other.

Good candidates for such special variables are items for which \"the
current\" can be naturally used as prefix, such as \"the current
database connection\" or \"the current business data source\". They are
singletons as far as the rest of the code is concerned, and often
passing them as an explicit argument does not add anything to the
readability or maintainability of the source code in question.

They can make it easier to write code that can be refactored. If you
have a request processing chain, with a number of layers that all
operate upon a \"current\" request, passing the request object
explicitly to every function requires that every function in the chain
have a request argument. Factoring out code into new functions often
requires that these functions also have this argument, which clutters
the code with boilerplate.

You should treat special variables as though they are per-thread
variables. By default, you should leave a special variable with no
top-level binding at all, and each thread of control that needs the
variable should bind it explicitly. This will mean that any incorrect
use of the variable will result in an \"unbound variable\" error, and
each thread will see its own value for the variable. Variables with a
default global value should usually be locally bound at thread creation
time. You should use suitable infrastructure to automate the appropriate
declaration of such variables.

Be consistent in assignment forms.

There are several styles for dealing with assignment and side-effects;
whichever a given package is using, keep using the same consistently
when hacking said package. Pick a style that makes sense when starting a
new package.

Regarding multiple assignment in a same form, there are two schools: the
first style groups as many assignments as possible into a single `SETF`
or `PSETF` form thus minimizing the number of forms with side-effects;
the second style splits assignments into as many individual `SETF` (or
`SETQ`, see below) forms as possible, to maximize the chances of
locating forms that modify a kind of place by grepping for
`(setf (foo ...`. A grep pattern must actually contain as many
place-modifying forms as you may use in your programs, which may make
this rationale either convincing or moot depending on the rest of the
style of your code. You should follow the convention used in the package
you are hacking. We recommend the first convention for new packages.

Regarding `SETF` and `SETQ`, there are two schools: this first regards
`SETQ` as an archaic implementation detail, and avoids it entirely in
favor of `SETF`; the second regards `SETF` as an additional layer of
complexity, and avoids it in favor of `SETQ` whenever possible (i.e.
whenever the assigned place is a variable or symbol-macro). You should
follow the convention used in the package you are hacking. We recommend
the first convention for new packages.

In the spirit of a mostly pure functional style, which makes testing and
maintenance easier, we invite you to consider how to do things with the
fewest assignments required.

You must make proper usage of assertions and conditions.

-   `ASSERT` should be used ONLY to detect internal bugs. Code should
    `ASSERT` invariants whose failure indicates that the software is
    itself broken. Incorrect input should be handled properly at
    runtime, and must not cause an assertion violation. The audience for
    an `ASSERT` failure is a developer. Do not use the data-form and
    argument-form in `ASSERT` to specify a condition to signal. It\'s
    fine to use them to print out a message for debugging purposes (and
    since it\'s only for debugging, there\'s no issue of
    internationalization).
-   `CHECK-TYPE`, `ETYPECASE` are also forms of assertion. When one of
    these fails, that\'s a detected bug. You should prefer to use
    `CHECK-TYPE` over (DECLARE (TYPE \...)) for the inputs of functions.
-   Your code should use assertions and type checks liberally. The
    sooner a bug is discovered, the better! Only code in the critical
    path for performance and internal helpers should eschew explicit
    assertions and type checks.
-   Invalid input, such as files that are read but do not conform to the
    expected format, should not be treated as assertion violations.
    Always check to make sure that input is valid, and take appropriate
    action if it is not, such as signalling a real error.
-   `ERROR` should be used to detect problems with user data, requests,
    permissions, etc., or to report \"unusual outcomes\" to the caller.
-   `ERROR` should always be called with an explicit condition type; it
    should never simply be called with a string. This enables
    internationalization.
-   Functions that report unusual outcomes by signaling a condition
    should say so explicitly in their contracts (their textual
    descriptions, in documentation and docstrings etc.). When a function
    signals a condition that is not specified by its contract, that\'s a
    bug. The contract should specify the condition class(es) clearly.
    The function may then signal any condition that is a type-of any of
    those conditions. That is, signaling instances of subclasses of the
    documented condition classes is fine.
-   Complex bug-checks may need to use `ERROR` instead of `ASSERT`.
-   When writing a server, you must not call `WARN`. Instead, you should
    use the appropriate logging framework.
-   Code must not call `SIGNAL`. Instead, use `ERROR` or `ASSERT`.
-   Code should not use `THROW` and `CATCH`; instead use the `restart`
    facility.
-   Code should not generically handle all conditions, e.g. type `T`, or
    use `IGNORE-ERRORS`. Instead, let unknown conditions propagate to
    the standard ultimate handler for processing.
-   There are a few places where handling all conditions is appropriate,
    but they are rare. The problem is that handling all conditions can
    mask program bugs. If you *do* need to handle \"all conditions\",
    you MUST handle only `ERROR`, *not* `T` and not `SERIOUS-CONDITION`.
    (This is notably because CCL\'s process shutdown depends on being
    able to signal `process-reset` and have it handled by CCL\'s
    handler, so we must not interpose our own handler.)
-   `(error (make-condition 'foo-error ...))` is equivalent to
    `(error 'foo-error ...)` --- code must use the shorter form.
-   Code should not signal conditions from inside the cleanup form of
    `UNWIND-PROTECT` (unless they are always handled inside the cleanup
    form), or otherwise do non-local exits from cleanup handlers outside
    of the handler e.g. `INVOKE-RESTART`.
-   Do not clean up by resignaling. If you do that, and the condition is
    not handled, the stack trace will halt at the point of the resignal,
    hiding the rest. And the rest is the part we really care about! ;;
    Bad (handler-case (catch \'ticket-at (etd-process-blocks)) (error
    (c) (reset-parser-values) (error c))) ;; Better (unwind-protect
    (catch \'ticket-at (etd-process-blocks)) (reset-parser-values))

If you know the type of something, you should make it explicit in order
to enable compile-time and run-time sanity-checking.

If your function is using a special variable as an implicit argument,
it\'s good to put in a `CHECK-TYPE` for the special variable, for two
reasons: to clue in the person reading the code that this variable is
being used implicitly as an argument, and also to help detect bugs.

Using `(declare (type ...))` is the least-desirable mechanism to use
because, as Scott McKay puts it:

> The fact is, `(declare (type ...))` does different things depending on
> the compiler settings of speed, safety, etc. In some compilers, when
> speed is greater than safety, `(declare (type ...))` will tell the
> compiler \"please assume that these variables have these types\"
> *without* generating any type-checks. That is, if some variable has
> the value `1432` in it, and you declare it to be of type `string`, the
> compiler might just go ahead and use it as though it\'s a string.
>
> Moral: don\'t use `(declare (type ...))` to declare the contract of
> any API functions, it\'s not the right thing. Sure, use it for
> \"helper\" functions, but not API functions.

You should, of course, use appropriate declarations in internal
low-level functions where these declarations are used for optimization.
When you do, however, see our recommendations for [Unsafe
Operations](#Unsafe_Operations).

Use CLOS appropriately.

When a generic function is intended to be called from other modules
(other parts of the code), there should be an explicit `DEFGENERIC`
form, with a `:DOCUMENTATION` string explaining the generic contract of
the function (as opposed to its behavior for some specific class). It\'s
generally good to do explicit `DEFGENERIC` forms, but for module entry
points it is mandatory.

When the argument list of a generic function includes `&KEY`, the
`DEFGENERIC` should always explicitly list all of the keyword arguments
that are acceptable, and explain what they mean. (Common Lisp does not
require this, but it is good form, and it may avoid spurious warnings on
SBCL.)

You should avoid `SLOT-VALUE` and `WITH-SLOTS`, unless you absolutely
intend to circumvent any sort of method combination that might be in
effect for the slot. Rare exceptions include `INITIALIZE-INSTANCE` and
`PRINT-OBJECT` methods and accessing normally hidden slots in the
low-level implementation of methods that provide user-visible
abstractions. Otherwise, you should use accessors, `WITH-ACCESSORS`

Accessor names generally follow a convention of
`<protocol-name>-<slot-name>`, where a \"protocol\" in this case loosely
indicates a set of functions with well-defined behavior.

No implication of a formal \"protocol\" concept is necessarily intended,
much less first-class \"protocol\" objects. However, there may indeed be
an abstract CLOS class or an [Interface-Passing
Style](https://common-lisp.net/~frideau/lil-ilc2012/lil-ilc2012.html)
interface that embodies the protocol. Further (sub)classes or
(sub)interfaces may then implement all or part of a protocol by defining
some methods for (generic) functions in the protocol, including readers
and writers.

For example, if there were a notional protocol called is `pnr` with
accessors `pnr-segments` and `pnr-passengers`, then the classes
`air-pnr`, `hotel-pnr` and `car-pnr` could each reasonably implement
methods for `pnr-segments` and `pnr-passengers` as accessors.

By default, an abstract base class name is used as the notional protocol
name, so accessor names default to `<class-name>-<slot-name>`; while
such names are thus quite prevalent, this form is neither required nor
even preferred. In general, it contributes to \"symbol bloat\", and in
many cases has led to a proliferation of \"trampoline\" methods.

Accessors named `<slot-name>-of` should not be used.

Explicit `DEFGENERIC` forms should be used when there are (or it is
anticipated that there will be) more than one `DEFMETHOD` for that
generic function. The reason is that the documentation for the generic
function explains the abstract contract for the function, as opposed to
explaining what an individual method does for some specific class(es).

You must not use generic functions where there is no notional protocol.
To put it more concretely, if you have more than one generic function
that specializes its Nth argument, the specializing classes should all
be descendants of a single class. Generic functions must not be used for
\"overloading\", i.e. simply to use the same name for two entirely
unrelated types.

More precisely, it\'s not really whether they descend from a common
superclass, but whether they obey the same \"protocol\". That is, the
two classes should handle the same set of generic functions, as if there
were an explicit `DEFGENERIC` for each method.

Here\'s another way to put it. Suppose you have two classes, A and B,
and a generic function F. There are two methods for F, which dispatch on
an argument being of types A and B. Is it plausible that there might be
a function call somewhere in the program that calls F, in which the
argument might sometimes, at runtime, be of class A and other times be
of class B? If not, you probably are overloading and should not be using
a single generic function.

We allow one exception to this rule: it\'s OK to do overloading if the
corresponding argument \"means\" the same thing. Typically one
overloading allows an X object, and the other allows the name of an X
object, which might be a symbol or something.

You must not use MOP \"intercessory\" operations at runtime. You should
not use MOP \"intercessory\" operations at compile-time. At runtime,
they are at worst a danger, at best a performance issue. At
compile-time, it is usually cleaner that macros should set things up the
right way in one pass than have to require a second pass of fixups
through intercession; but sometimes, fixups are necessary to resolve
forward references, and intercession is allowed then. MOP intercession
is a great tool for interactive development, and you may enjoy it while
developping and debugging; but you should not use it in normal
applications.

If a class definition creates a method as a `:READER`, `:WRITER`, or
`:ACCESSOR`, do not redefine that method. It\'s OK to add `:BEFORE`,
`:AFTER`, and `:AROUND` methods, but don\'t override the primary method.

In methods with keyword arguments, you must always use `&KEY`, even if
the method does not care about the values of any keys, and you should
never use `&ALLOW-OTHER-KEYS`. As long as a keyword is accepted by any
method of a generic function, it\'s OK to use it in the generic
function, even if the other methods of the same generic function don\'t
mention it explicitly. This is particularly important for
`INITIALIZE-INSTANCE` methods, since if you did use `&ALLOW-OTHER-KEYS`,
it would disable error checking for misspelled or wrong keywords in
`MAKE-INSTANCE` calls!

A typical `PRINT-OBJECT` method might look like this:

(defmethod print-object ((p person) stream) (print-unprintable-object (p
stream :type t :identity t) (with-slots (first-name last-name) p
(safe-format stream \"\~a \~a\" first-name last-name))))

Use macros when appropriate, which is often. Define macros when
appropriate, which is seldom.

Macros bring syntactic abstraction, which is a wonderful thing. It helps
make your code clearer, by describing your intent without getting bogged
in implementation details (indeed abstracting those details away). It
helps make your code more concise and more readable, by eliminating both
redundancy and irrelevant details. But it comes at a cost to the reader,
which is learning a new syntactic concept for each macro. And so it
should not be abused.

The general conclusion is that there shouldn\'t be any recognizable
*design pattern* in a good Common Lisp program. The one and only pattern
is: *use the language*, which includes defining and using syntactic
abstractions.

Existing macros must be used whenever they make code clearer by
conveying intent in a more concise way, which is often. When a macro is
available in your project that expresses the concept you\'re using, you
must not write the expansion rather than use the macro.

New macros should be defined as appropriate, which should be seldom, for
common macros have already been provided by the language and its various
libraries, and your program typically only needs few new ones relative
to its size.

You should follow the OAOOM rule of thumb for deciding when to create a
new abstraction, whether syntactic or not: if a particular pattern is
used more than twice, it should probably be abstracted away. A more
refined rule to decide when to use abstraction should take into account
the benefit in term of number of uses and gain at each use, to the costs
in term of having to get used to reading the code. For syntactic
abstractions, costs and benefits to the reader is usually more important
than costs and benefits to the writer, because good code is usually
written once and read many times by many people (including the same
programmer who has to maintain the program after having forgotten it).
Yet the cost to the writer of the macro should also be taken into
account; however, in doing so it should rather be compared to the cost
of the programmer writing other code instead that may have higher
benefits.

Using Lisp macros properly requires taste. Avoid writing complicated
macros unless the benefit clearly outweighs the cost. It takes more
effort for your fellow developers to learn your macro, so you should
only use a macro if the gain in expressiveness is big enough to justify
that cost. As usual, feel free to consult your colleagues if you\'re not
sure, since without a lot of Lisp experience, it can be hard to make
this judgment.

You must never use a macro where a function will do. That is, if the
semantics of what you are writing conforms to the semantics of a
function, then you must write it as a function rather than a macro.

You must not transform a function into a macro for performance reasons.
If profiling shows that you have a performance problem with a specific
function `FOO`, document the need and profiling-results appropriately,
and `(declaim (inline foo))`.

You can also use a compiler-macro as a way to speed up function
execution by specifying a source-to-source transformation. Beware that
it interferes with tracing the optimized function.

When you write a macro-defining macro (a macro that generates macros),
document and comment it particularly clearly, since these are harder to
understand.

You must not install new reader macros without a consensus among the
developers of your system. Reader macros must not leak out of the system
that uses them to clients of that system or other systems used in the
same project. You must use software such as `cl-syntax` or
`named-readtables` to control how reader macros are used. This clients
who desire it may use the same reader macros as you do. In any case,
your system must be usable even to clients who do not use these reader
macros.

If your macro has a parameter that is a Lisp form that will be evaluated
when the expanded code is run, you should name the parameter with the
suffix `-form`. This convention helps make it clearer to the macro\'s
user which parameters are Lisp forms to be evaluated, and which are not.
The common names `body` and `end` are exceptions to this rule.

You should follow the so-called `CALL-WITH` style when it applies. This
style is explained at length in
<http://random-state.net/log/3390120648.html>. The general principle is
that the macro is strictly limited to processing the syntax, and as much
of the semantics as possible is kept in normal functions. Therefore, a
macro `WITH-FOO` is often limited to generating a call to an auxiliary
function `CALL-WITH-FOO` with arguments deduced from the macro
arguments. Macro `&body` arguments are typically wrapped into a lambda
expression of which they become the body, which is passed as one of the
arguments of the auxiliary function.

The separation of syntactic and semantic concerns is a general principle
of style that applies beyond the case of `WITH-` macros. Its advantages
are many. By keeping semantics outside the macro, the macro is made
simpler, easier to get right, and less subject to change, which makes it
easier to develop and maintain. The semantics is written in a simpler
language --- one without staging --- which also makes it easier to
develop and maintain. It becomes possible to debug and update the
semantic function without having to recompile all clients of the macro.
The semantic function appears in the stack trace which also helps debug
client functions. The macro expansion is made shorter and each expansion
shares more code with other expansions, which reduces memory pressure
which in turn usually makes things faster. It also makes sense to write
the semantic functions first, and write the macros last as syntactic
sugar on top. You should use this style unless the macro is used in
tight loops where performance matters; and even then, see our rules
regarding optimization.

Any functions (closures) created by the macro should be named, which can
be done using `FLET`. This also allows you to declare the function to be
of dynamic extent (if it is --- and often it is; yet see below regarding
[DYNAMIC-EXTENT](#DYNAMIC-EXTENT)).

If a macro call contains a form, and the macro expansion includes more
than one copy of that form, the form can be evaluated more than once,
and code it contains macro-expanded and compiled more than once. If
someone uses the macro and calls it with a form that has side effects or
that takes a long time to compute, the behavior will be undesirable
(unless you\'re intentionally writing a control structure such as a
loop). A convenient way to avoid this problem is to evaluate the form
only once, and bind a (generated) variable to the result. There is a
very useful macro called `ALEXANDRIA:ONCE-ONLY` that generates code to
do this. See also `ALEXANDRIA:WITH-GENSYMS`, to make some temporary
variables in the generated code. Note that if you follow our `CALL-WITH`
style, you typically expand the code only once, as either an argument to
the auxiliary function, or the body of a lambda passed as argument to
it; you therefore avoid the above complexity.

When you write a macro with a body, such as a `WITH-xxx` macro, even if
there aren\'t any parameters, you should leave space for them anyway.
For example, if you invent `WITH-LIGHTS-ON`, do not make the call to it
look like `(defmacro with-lights-on (&body b) ...)`. Instead, do
`(defmacro with-lights-on (() &body b) ...)`. That way, if parameters
are needed in the future, you can add them without necessarily having to
change all the uses of the macro.

When using `EVAL-WHEN`, you should almost always use all of
`(:compile-toplevel :load-toplevel :execute)`.

Lisp evaluation happens at several times, some of them interleaved. Be
aware of them when writing macros. [EVAL-WHEN considered harmful to your
mental health](https://fare.livejournal.com/146698.html).

In summary of the article linked above, unless you\'re doing truly
advanced macrology, the only valid combination in an `EVAL-WHEN` is to
include all of
`(eval-when (:compile-toplevel :load-toplevel :execute) ...)`

You must use
`(eval-when (:compile-toplevel :load-toplevel :execute) ...)` whenever
you define functions, types, classes, constants, variables, etc., that
are going to be used in macros.

It is usually an error to omit the `:execute`, because it prevents
`LOAD`ing the source rather than the fasl. It is usually an error to
omit the `:load-toplevel` (except to modify e.g. readtables and
compile-time settings), because it prevents `LOAD`ing future files or
interactively compiling code that depends on the effects that happen at
compile-time, unless the current file was `COMPILE-FILE`d within the
same Lisp session.

Regarding variables, note that because macros may or may not be expanded
in the same process that runs the expanded code, you must not depend on
compile-time and runtime effects being either visible or invisible at
the other time. There are still valid uses of variables in macros:

-   Some variables may hold dictionaries for some new kind of definition
    and other meta-data. If such meta-data is to be visible at runtime
    and/or in other files, you must make sure that the macro expands
    into code that will register the definitions to those meta-data
    structures at load-time, in addition to effecting the registration
    at compile-time. Typically, your top-level definitions expand to
    code that does the registration. if your code doesn\'t expand at the
    top-level, you can sometimes use `LOAD-TIME-VALUE` for good effect.
    In extreme cases, you may have to use
    `ASDF-FINALIZERS:EVAL-AT-TOPLEVEL`.
-   Some variables may hold temporary data that is only used at
    compile-time in the same file, and can be cleaned up at the end of
    the file\'s compilation. Predefined such variables would include
    `*readtable*` or compiler-internal variables holding the current
    optimization settings. You can often manage existing and new such
    variables using the `:AROUND-COMPILE` hooks of `ASDF`.

You should use `#.` sparingly, and you must avoid read-time
side-effects.

The `#.` standard read-macro will read one object, evaluate the object,
and have the reader return the resulting value.

You must not use it where other idioms will do, such as using
`EVAL-WHEN` to evaluate side-effects at compile-time, using a regular
macro to return an expression computed at compile-time, using
`LOAD-TIME-VALUE` to compute it at load-time.

Read-time evaluation is often used as a quick way to get something
evaluated at compile time (actually \"read time\" but it amounts to the
same thing). If you use this, the evaluation MUST NOT have any side
effects and MUST NOT depend on any variable global state. The `#.`
should be treated as a way to force \"constant-folding\" that a
sufficiently-clever compiler could have figure out all by itself, when
the compiler isn\'t sufficiently-clever and the difference matters.

Another use of `#.` is to expand the equivalent of macros in places that
are neither expressions nor (quasi)quotations, such as lambda-lists.
However, if you find yourself using it a lot, it might be time to
instead define macros to replace your consumers of lambda-lists with
something that recognizes an extension.

Whenever you are going to use `#.`, you should consider using
`DEFCONSTANT` and its variants, possibly in an `EVAL-WHEN`, to give the
value a name explaining what it means.

You must not use `EVAL` at runtime.

Places where it is actually appropriate to use `EVAL` are so few and far
between that you must consult with your reviewers; it\'s easily misused.

If your code manipulates symbols at runtime and needs to get the value
of a symbol, use `SYMBOL-VALUE`, not `EVAL`.

Often, what you really need is to write a macro, not to use `EVAL`.

You may be tempted to use `EVAL` as a shortcut to evaluating expressions
in a safe subset of the language. But it often requires more scrutiny to
properly check and sanitize all possible inputs to such use of `EVAL`
than to build a special-purpose evaluator. You must not use `EVAL` in
this way at runtime.

Places where it is OK to use `EVAL` are:

-   The implementation of an interactive development tool.
-   The build infrastructure.
-   Backdoors that are part of testing frameworks. (You MUST NOT have
    such backdoors in production code.)
-   Macros that fold constants at compile-time.
-   Macros that register definitions to meta-data structures; the
    registration form is sometimes evaluated at compile-time as well as
    included in the macro-expansion, so it is immediately available to
    other macros.

Note that in the latter case, if the macro isn\'t going to be used at
the top-level, it might not be possible to make these definitions
available as part of the expansion. The same phenomenon may happen in a
`DEFTYPE` expansion, or in helper functions used by macros. In these
cases, you may actually have to use `ASDF-FINALIZERS:EVAL-AT-TOPLEVEL`
in your macro. It will not only `EVAL` your definitions at
macro-expansion time for immediate availability, it will also save the
form aside, for inclusion in a `(ASDF-FINALIZERS:FINAL-FORMS)` that you
need to include at the end of the file being compiled (or before the
form is needed). This way, the side-effects are present when loading the
fasl without having compiled it as well as while compiling it; in either
case, the form is made available at load-time. `ASDF-FINALIZERS` ensures
that the form is present, by throwing an error if you omit it.

You must not use `INTERN` or `UNINTERN` at runtime.

You must not use `INTERN` at runtime. Not only does it cons, it either
creates a permanent symbol that won\'t be collected or gives access to
internal symbols. This creates opportunities for memory leaks, denial of
service attacks, unauthorized access to internals, clashes with other
symbols.

You must not `INTERN` a string just to compare it to a keyword; use
`STRING=` or `STRING-EQUAL`.

(member (intern str :keyword) \$keys) ; Bad (member str \$keys :test
\#\'string-equal) ; Better

You must not use `UNINTERN` at runtime. It can break code that relies on
dynamic binding. It makes things harder to debug. You must not
dynamically intern any new symbol, and therefore you need not
dynamically unintern anything.

You may of course use `INTERN` at compile-time, in the implementation of
some macros. Even so, it is usually more appropriate to use abstractions
on top of it, such as `ALEXANDRIA:SYMBOLICATE` or
`ALEXANDRIA:FORMAT-SYMBOL` to create the symbols you need.

Appropriately use or avoid using `NIL`.

`NIL` can have several different interpretations:

-   \"False.\" In this case, use `NIL`. You should test for false `NIL`
    using the operator `NOT` or using the predicate function `NULL`.
-   \"Empty-list.\" In this case, use `'()`. (Be careful about quoting
    the empty-list when calling macros.) You should use `ENDP` to test
    for the empty list when the argument is known to be a proper list,
    or with `NULL` otherwise.
-   A statement about some value being unspecified. In this case, you
    may use `NIL` if there is no risk of ambiguity anywhere in your
    code; otherwise you should use an explicit, descriptive symbol.
-   A statement about some value being known not to exist. In this case,
    you should use an explicit, descriptive symbol instead of `NIL`.

You must not introduce ambiguity in your data representations that will
cause headaches for whoever has to debug code. If there is any risk of
ambiguity, you should use an explicit, descriptive symbol or keyword for
each case, instead of using `NIL` for either. If you do use `NIL`, you
must make sure that the distinction is well documented.

In many contexts, instead of representing \"I don\'t know\" as a
particular value, you should instead use multiple values, one for the
value that is known if any, and one to denote whether the value was
known or found.

When working with database classes, keep in mind that `NIL` need not
always map to `'NULL'` (and vice-versa)! The needs of the database may
differ from the needs of the Lisp.

You must select proper data representation. You must not abuse the
`LIST` data structure.

Even though back in 1958, LISP was short for \"LISt Processing\", its
successor Common Lisp has been a modern programming language with modern
data structures since the 1980s. You must use the proper data structures
in your programs.

You must not abuse the builtin (single-linked) `LIST` data structure
where it is not appropriate, even though Common Lisp makes it especially
easy to use it.

You must only use lists when their performance characteristics is
appropriate for the algorithm at hand: sequential iteration over the
entire contents of the list.

An exception where it is appropriate to use lists is when it is known in
advance that the size of the list will remain very short (say, less than
16 elements).

List data structures are often (but not always) appropriate for macros
and functions used by macros at compile-time: indeed, not only is source
code passed as lists in Common Lisp, but the macro-expansion and
compilation processes will typically walk over the entire source code,
sequentially, once. (Note that advanced macro systems don\'t directly
use lists, but instead use abstract syntax objects that track source
code location and scope; however there is no such advanced macro system
in Common Lisp at this time.)

Another exception where it is appropriate to use lists is for
introducing literal constants that will be transformed into more
appropriate data structures at compile-time or load-time. It is a good
to have a function with a relatively short name to build your program\'s
data structures from such literals.

In the many cases when lists are not the appropriate data structure,
various libraries such as
[cl-containers](http://cliki.net/cl-containers) or
[lisp-interface-library](http://cliki.net/lisp-interface-library)
provide plenty of different data structures that should fulfill all the
basic needs of your programs. If the existing libraries are not
satisfactory, see above about [Using Libraries](#Using_Libraries) and
[Open-Sourcing Code](#Open-Sourcing_Code).

You should use the appropriate representation for product types.

You should avoid using a list as anything besides a container of
elements of like type. You must not use a list as method of passing
multiple separate values of different types in and out of function
calls. Sometimes it is convenient to use a list as a little ad hoc
structure, i.e. \"the first element of the list is a FOO, and the second
is a BAR\", but this should be used minimally since it gets harder to
remember the little convention. You must only use a list that way when
destructuring the list of arguments from a function, or creating a list
of arguments to which to `APPLY` a function.

The proper way to pass around an object comprising several values of
heterogeneous types is to use a structure as defined by `DEFSTRUCT` or
`DEFCLASS`.

You should use multiple values only when function returns a small number
of values that are meant to be destructured immediately by the caller,
rather than passed together as arguments to further functions.

You should not return a condition object as one of a set of multiple
values. Instead, you should signal the condition to denote an unusual
outcome.

You should signal a condition to denote an unusual outcome, rather than
relying on a special return type.

Use the appropriate functions when manipulating lists.

Use `FIRST` to access the first element of a list, `SECOND` to access
the second element, etc. Use `REST` to access the tail of a list. Use
`ENDP` to test for the end of the list.

Use `CAR` and `CDR` when the cons cell is not being used to implement a
proper list and is instead being treated as a pair of more general
objects. Use `NULL` to test for `NIL` in this context.

The latter case should be rare outside of alists, since you should be
using structures and classes where they apply, and data structure
libraries when you want trees.

Exceptionally, you may use `CDADR` and other variants on lists when
manually destructuring them, instead of using a combination of several
list accessor functions. In this context, using `CAR` and `CDR` instead
of `FIRST` and `REST` also makes sense. However, keep in mind that it
might be more appropriate in such cases to use higher-level constructs
such as `DESTRUCTURING-BIND` or `OPTIMA:MATCH`.

You should use arrays rather than lists where random access matters.

`ELT` has *O(n)* behavior when used on lists. If you are to use random
element access on an object, use arrays and `AREF` instead.

The exception is for code outside the critical path where the list is
known to be small anyway.

You should only use lists as sets for very small lists.

Using lists as representations of sets is a bad idea unless you know the
lists will be small, for accessors are *O(n)* instead of *O(log n)*. For
arbitrary big sets, use balanced binary trees, for instance using
`lisp-interface-library`.

If you still use lists as sets, you should not `UNION` lists just to
search them.

(member foo (union list-1 list-2)) ; Bad (or (member foo list-1) (member
foo list-2)) ; Better

Indeed, `UNION` not only conses unnecessarily, but it can be *O(n\^2)*
on some implementations, and is rather slow even when it\'s *O(n)*.

You must follow the proper usage regarding well-known functions, macros
and special forms.

You must use proper defining forms for constant values.

The Lisp system we primarily use, SBCL, is very picky and signals a
condition whenever a constant is redefined to a value not `EQL` to its
previous setting. You must not use `DEFCONSTANT` when defining variables
that are not numbers, characters, or symbols (including booleans and
keywords). Instead, consistently use whichever alternative is
recommended for your project.

;; Bad (defconstant +google-url+ \"https://www.google.com/\")
(defconstant +valid-colors+ \'(red green blue))

Open-Source libraries may use `ALEXANDRIA:DEFINE-CONSTANT` for constants
other than numbers, characters and symbols (including booleans and
keywords). You may use the `:TEST` keyword argument to specify an
equality predicate.

;; Better, for Open-Source code: (define-constant +google-url+
\"https://www.google.com/\" :test \#\'string=) (define-constant
+valid-colors+ \'(red green blue))

Note that with optimizing implementations, such as SBCL or CMUCL,
defining constants this way precludes any later redefinition short of
`UNINTERN`ing the symbol and recompiling all its clients. This may make
it \"interesting\" to debug things at the REPL or to deploy live code
upgrades. If there is a chance that your \"constants\" are not going to
be constant over the lifetime of your server processes after taking into
consideration scheduled and unscheduled code patches, you should
consider using `DEFPARAMETER` or `DEFVAR` instead, or possibly a variant
of `DEFINE-CONSTANT` that builds upon some future library implementing
global lexicals rather than `DEFCONSTANT`. You may keep the `+plus+`
convention in these cases to document the intent of the parameter as a
constant.

Also note that `LOAD-TIME-VALUE` may help you avoid the need for defined
constants.

You should make proper use of `&OPTIONAL` and `&KEY` arguments. You
should not use `&AUX` arguments.

You should avoid using `&ALLOW-OTHER-KEYS`, since it blurs the contract
of a function. Almost any real function (generic or not) allows a
certain fixed set of keywords, as far as its caller is concerned, and
those are part of its contract. If you are implementing a method of a
generic function, and it does not need to know the values of some of the
keyword arguments, you should explicitly `(DECLARE (IGNORE ...))` all
the arguments that you are not using. You must not use
`&ALLOW-OTHER-KEYS` unless you explicitly want to disable checking of
allowed keys for all methods when invoking the generic function on
arguments that match this particular method. Note that the contract of a
generic function belongs in the `DEFGENERIC`, not in the `DEFMETHOD`
which is basically an \"implementation detail\" of the generic function
as far as the caller of the generic is concerned.

A case where `&ALLOW-OTHER-KEYS` is appropriate is when you write a
wrapper function to other some other functions that may vary (within the
computation or during development), and pass around a plist as a `&REST`
argument.

You should avoid using `&AUX` arguments.

You should avoid having both `&OPTIONAL` and `&KEY` arguments, unless it
never makes sense to specify keyword arguments when the optional
arguments are not all specified. You must not have non-`NIL` defaults to
your `&OPTIONAL` arguments when your function has both `&OPTIONAL` and
`&KEY` arguments.

For maximum portability of a library, it is good form that `DEFMETHOD`
definitions should `(DECLARE (IGNORABLE ...))` all the required
arguments that they are not using. Indeed, some implementations will
issue a warning if you `(DECLARE (IGNORE ...))` those arguments, whereas
other implementations will issue a warning if you fail to
`(DECLARE (IGNORE ...))` them. `(DECLARE (IGNORABLE ...))` works on all
implementations.

You should avoid excessive nesting of binding forms inside a function.
If your function ends up with massive nesting, you should probably break
it up into several functions or macros. If it is really a single
conceptual unit, consider using a macro such as `FARE-UTILS:NEST` to at
least reduce the amount of indentation required. It is bad form to use
`NEST` in typical short functions with 4 or fewer levels of nesting, but
also bad form not to use it in the exceptional long functions with 10 or
more levels of nesting. Use your judgment and consult your reviewers.

Use the appropriate conditional form.

Use `WHEN` and `UNLESS` when there is only one alternative. Use `IF`
when there are two alternatives and `COND` when there are several.

However, don\'t use `PROGN` for an `IF` clause --- use `COND`, `WHEN`,
or `UNLESS`.

Note that in Common Lisp, `WHEN` and `UNLESS` return `NIL` when the
condition is not met. You may take advantage of it. Nevertheless, you
may use an `IF` to explicitly return `NIL` if you have a specific reason
to insist on the return value. You may similarly include a fall-through
clause `(t nil)` as the last in your COND, or `(otherwise nil)` as the
last in your CASE, to insist on the fact that the value returned by the
conditional matters and that such a case is going to be used. You should
omit the fall-through clause when the conditional is used for
side-effects.

You should prefer `AND` and `OR` when it leads to more concise code than
using `IF`, `COND`, `WHEN` or `UNLESS`, and there are no side-effects
involved. You may also use an `ERROR` as a side-effect in the final
clause of an `OR`.

You should only use `CASE` and `ECASE` to compare numbers, characters or
symbols (including booleans and keywords). Indeed, `CASE` uses `EQL` for
comparisons, so strings, pathnames and structures may not compare the
way you expect, and `1` will differ from `1.0`.

You should use `ECASE` and `ETYPECASE` in preference to `CASE` and
`TYPECASE`. It is better to catch erroneous values early.

You should not use `CCASE` or `CTYPECASE` at all. At least, you should
not use them in server processes, unless you have quite robust error
handling infrastructure and make sure not to leak sensitive data this
way. These are meant for interactive use, and can cause interesting
damage if they cause data or control to leak to attackers.

You must not use gratuitous single quotes in `CASE` forms. This is a
common error:

(case x ; Bad: silently returns NIL on mismatch (\'bar :bar) ; Bad:
catches QUOTE (\'baz :baz)) ; Bad: also would catch QUOTE (ecase x ;
Better: will error on mismatch ((bar) :bar) ; Better: won\'t match QUOTE
((baz) :baz)) ; Better: same reason

`'BAR` there is `(QUOTE BAR)`, meaning this leg of the case will be
executed if `X` is `QUOTE`\... and ditto for the second leg (though
`QUOTE` will be caught by the first clause). This is unlikely to be what
you really want.

In `CASE` forms, you must use `otherwise` instead of `t` when you mean
\"execute this clause if the others fail\". You must use `((t) ...)`
when you mean \"match the symbol T\" rather than \"match anything\". You
must also use `((nil) ...)` when you mean \"match the symbol NIL\"
rather than \"match nothing\".

Therefore, if you want to map booleans `NIL` and `T` to respective
symbols `:BAR` and `:QUUX`, you should avoid the former way and do it
the latter way:

(ecase x ; Bad: has no actual error case! (nil :bar)) ; Bad: matches
nothing (t :quux)) ; Bad: matches anything (ecase x ; Better: will
actually catch non-booleans ((nil) :bar)) ; Better: matches NIL ((t)
:quux)) ; Better: matches T

You should the appropriate predicates when comparing objects.

Lisp provides four general equality predicates: `EQ`, `EQL`, `EQUAL`,
and `EQUALP`, which subtly vary in semantics. Additionally, Lisp
provides the type-specific predicates `=`, `CHAR=`, `CHAR-EQUAL`,
`STRING=`, and `STRING-EQUAL`. Know the distinction!

You should use `EQL` to compare objects and symbols for *identity*.

You must not use `EQ` to compare numbers or characters. Two numbers or
characters that are `EQL` are not required by Common Lisp to be `EQ`.

When choosing between `EQ` and `EQL`, you should use `EQL` unless you
are writing performance-critical low-level code. `EQL` reduces the
opportunity for a class of embarrassing errors (i.e. if numbers or
characters are ever compared). There may a tiny performance cost
relative to `EQ`, although under SBCL, it often compiles away entirely.
`EQ` is equivalent to `EQL` and type declarations, and use of it for
optimization should be treated just like any such [unsafe
operations](#Unsafe_Operations).

You should use `CHAR=` for case-dependent character comparisons, and
`CHAR-EQUAL` for case-ignoring character comparisons.

You should use `STRING=` for case-dependent string comparisons, and
`STRING-EQUAL` for case-ignoring string comparisons.

A common mistake when using `SEARCH` on strings is to provide `STRING=`
or `STRING-EQUAL` as the `:TEST` function. The `:TEST` function is given
two sequence elements to compare. If the sequences are strings, the
`:TEST` function is called on two characters, so the correct tests are
`CHAR=` or `CHAR-EQUAL`. If you use `STRING=` or `STRING-EQUAL`, the
result is what you expect, but in some Lisp implementations it\'s much
slower. CCL (at least as of 8/2008) creates a one-character string upon
each comparison, for example, which is very expensive.

Also, you should use `:START` and `:END` arguments to `STRING=` or
`STRING-EQUAL` instead of using `SUBSEQ`; e.g.
`(string-equal (subseq s1 2 6) s2)` should instead be
`(string-equal s1 s2 :start1 2 :end1 6)` This is preferable because it
does not cons.

You should use `ZEROP`, `PLUSP`, or `MINUSP`, instead of comparing a
value to `0` or `0.0`.

You must not use exact comparison on floating point numbers, since the
vague nature of floating point arithmetic can produce little \"errors\"
in numeric value. You should compare absolute values to a threshhold.

You must use `=` to compare numbers, unless you really mean for `0`,
`0.0` and `-0.0` to compare unequal, in which case you should use `EQL`.
Then again, you must not usually use exact comparison on floating point
numbers.

Monetary amounts should be using decimal (rational) numbers to avoid the
complexities and rounding errors of floating-point arithmetic. Libraries
such as [wu-decimal](http://wukix.com/lisp-decimals) may help you; once
again, if this library is not satisfactory, see above about [Using
Libraries](#Using_Libraries) and [Open-Sourcing
Code](#Open-Sourcing_Code).

Use the appropriate form for iteration.

You should use simpler forms such as `DOLIST` or `DOTIMES` instead of
`LOOP` in simple cases when you\'re not going to use any of the `LOOP`
facilities such as bindings, collection or block return.

Use the `WITH` clause of `LOOP` when it will avoid a level of nesting
with `LET`. You may use `LET` if it makes it clearer to return one of
bound variables after the `LOOP`, rather than use a clumsy
`FINALLY (RETURN ...)` form.

In the body of a `DOTIMES`, do not set the iteration variable. (CCL will
issue a compiler warning if you do.)

Most systems use unadorned symbols in the current package as `LOOP`
keywords. Other systems use actual `:keywords` from the `KEYWORD`
package as `LOOP` keywords. You must be consistent with the convention
used in your system.

Use the appropriate I/O functions.

When writing a server, code must not send output to the standard streams
such as `*STANDARD-OUTPUT*` or `*ERROR-OUTPUT*`. Instead, code must use
the proper logging framework to output messages for debugging. We are
running as a server, so there is no console!

Code must not use `PRINT-OBJECT` to communicate with a user ---
`PRINT-OBJECT` is for debugging purposes only. Modifying any
`PRINT-OBJECT` method must not break any public interfaces.

You should not use a sequence of `WRITE-XXX` where a single `FORMAT`
string could be used. Using format allows you to parameterize the format
control string in the future if the need arises.

You should use `WRITE-CHAR` to emit a character rather than
`WRITE-STRING` to emit a single-character string.

You should not use `(format nil "~A" value)`; you should use
`PRINC-TO-STRING` instead.

You should use `~<Newline>` or `~@<Newline>` in format strings to keep
them from wrapping in 100-column editor windows, or to indent sections
or clauses to make them more readable.

You should not use `STRING-UPCASE` or `STRING-DOWNCASE` on format
control parameters; instead, it should use `"~:@(~A~)"` or `"~(~A~)"`.

Be careful when using the `FORMAT` conditional directive. The parameters
are easy to forget.

No parameters, e.g. `"~[Siamese~;Manx~;Persian~] Cat"`
:   Take one format argument, which should be an integer. Use it to
    choose a clause. Clause numbers are zero-based. If the number is out
    of range, just print nothing. You can provide a default value by
    putting a `":"` in front of the last `";"`. E.g. in
    `"~[Siamese~;Manx~;Persian~:;Alley~] Cat"`, an out-of-range arg
    prints `"Alley"`.

`:` parameter, e.g. `"~:[Siamese~;Manx~]"`
:   Take one format argument. If it\'s `NIL`, use the first clause,
    otherwise use the second clause.

`@` parameter, e.g. `"~@[Siamese ~a~]"`
:   If the next format argument is true, use the choice, but do NOT take
    the argument. If it\'s false, take one format argument and print
    nothing. (Normally the clause uses the format argument.)

`#` parameter, e.g. `"~#[ none~; ~s~; ~s and ~s~]"`
:   Use the number of arguments to format as the number to choose a
    clause. The same as no parameters in all other ways. Here\'s the
    full hairy example:
    `"Items:~#[ none~; ~S~; ~S and ~S~:;~@{~#[~; and~] ~S~^ ,~}~]."`

You should avoid unnecessary allocation of memory.

In a language with automatic storage management (such as Lisp or Java),
the colloquial phrase \"memory leak\" refers to situation where storage
that is not actually needed nevertheless does not get deallocated,
because it is still reachable.

You should be careful that when you create objects, you don\'t leave
them reachable after they are no longer needed!

Here\'s a particular trap-for-the-unwary in Common Lisp. If you make an
array with a fill pointer, and put objects in it, and then set the fill
pointer back to zero, those objects are still reachable as far as Lisp
goes (the Common Lisp spec says that it\'s still OK to refer to the
array entries past the end of the fill pointer).

Don\'t cons (i.e., allocate) unnecessarily. Garbage collection is not
magic. Excessive allocation is usually a performance problem.

You must only use faster unsafe operations when there is a clear
performance need and you can document why it\'s correct.

Common Lisp implementations often provide backdoors to compute some
operations faster in an unsafe way. For instance, some libraries provide
arithmetic operations that are designed to be used with fixnums only,
and yield the correct result faster if provided proper arguments. The
downside is that the result of such operations is incorrect in case of
overflow, and can have undefined behavior when called with anything but
fixnums.

More generally, unsafe operations will yield the correct result faster
than would the equivalent safe operation if the arguments satisfy some
invariant such as being of the correct type and small enough; however if
the arguments fail to satisfy the required invariants, then the
operation may have undefined behavior, such as crashing the software,
or, which is sometimes worse, silently giving wrong answers. Depending
on whether the software is piloting an aircraft or other life-critical
device, or whether it is accounting for large amounts money, such
undefined behavior can kill or bankrupt people. Yet proper speed can
sometimes make the difference between software that\'s unusably slow and
software that does its job, or between software that is a net loss and
software that can yield a profit.

You must not define or use unsafe operations without both profiling
results indicating the need for this optimization, and careful
documentation explaining why it is safe to use them. Unsafe operations
should be restricted to internal functions; you should carefully
documented how unsafe it is to use these functions with the wrong
arguments. You should only use unsafe operations inside functions
internal to a package and you should document the use of the
declarations, since calling the functions with arguments of the wrong
type can lead to undefined behavior. Use `check-type` in functions
exported from a package to sanitize input arguments, so that internal
functions are never passed illegal values.

On some compilers, new unsafe operations can usually be defined by
combining type declarations with an `OPTIMIZE` declaration that has
sufficiently high `SPEED` and low `SAFETY`. In addition to providing
more speed for production code, such declarations may more helpful than
`check-type` assertions for finding bugs at compile-time, on compilers
that have type inference. These compilers may interpret those
declarations as assertions if you switch to safer and slower optimize
settings; this is good to locate a dynamic error in your code during
development, but is not to be used for production code since it defeats
the purpose of declarations as a performance trick.

You should only use `DYNAMIC-EXTENT` where it matters for performance,
and you can document why it is correct.

`DYNAMIC-EXTENT` declarations are a particular case of [unsafe
operations](#Unsafe_Operations).

The purpose of a `DYNAMIC-EXTENT` declaration is to improve performance
by reducing garbage collection in cases where it appears to be obvious
that an object\'s lifetime is within the \"dynamic extent\" of a
function. That means the object is created at some point after the
function is called, and the object is always inaccessible after the
function exits by any means.

By declaring a variable or a local function `DYNAMIC-EXTENT`, the
programmer *asserts* to Lisp that any object that is ever a value of
that variable or the closure that is the definition of the function has
a lifetime within the dynamic extent of the (innermost) function that
declares the variable.

The Lisp implementation is then free to use that information to make the
program faster. Typically, Lisp implementations can take advantage of
this knowledge to stack-allocate:

-   The lists created to store `&REST` parameters.
-   Lists, vectors and structures allocated within a function.
-   Closures.

If the assertion is wrong, i.e. if the programmer\'s claim is not true,
the results can be *catastrophic*: Lisp can terminate any time after the
function returns, or it can hang forever, or --- worst of all --- it can
produce incorrect results without any runtime error!

Even if the assertion is correct, future changes to the function might
introduce a violation of the assertion. This increases the danger.

In most cases, such objects are ephemeral. Modern Lisp implementations
use generational garbage collectors, which are quite efficient under
these circumstances.

Therefore, `DYNAMIC-EXTENT` declarations should be used sparingly. You
must only use them if:

1.  There is some good reason to think that the overall effect on
    performance is noticeable, and
2.  It is absolutely clear that the assertion is true.
3.  It is quite unlikely that the code will be changed in ways that
    cause the declaration to become false.

Point (1) is a special case of the principle of avoiding premature
optimization. An optimization like this only matters if such objects are
allocated at a very high rate, e.g. \"inside an inner loop\".

Note that is relatively easy to ascertain that a function will not
escape the dynamic extent of the current call frame by analyzing where
the function is called and what other functions it is passed to;
therefore, you should somewhat wary of declaring a function
`DYNAMIC-EXTENT`, but this is not a high-stress declaration. On the
other hand, it is much harder to ascertain that none of the objects ever
bound or assigned to that variable and none of their sub-objects will
escape the dynamic extent of the current call frame, and that they still
won\'t in any future modification of a function. Therefore, you should
be extremely wary of declaring a variable `DYNAMIC-EXTENT`.

It\'s usually hard to predict the effect of such optimization on
performance. When writing a function or macro that is part of a library
of reusable code, there\'s no a priori way to know how often the code
will run. Ideally, tools would be available to discover the availability
and suitability of using such an optimization based on running
simulations and test cases, but in practice this isn\'t as easy as it
ought to be. It\'s a tradeoff. If you\'re very, very sure that the
assertion is true (that any object bound to the variable and any of its
sub-objects are only used within the dynamic extent of the specified
scope), and it\'s not obvious how much time will be saved and it\'s not
easy to measure, then it may be better to put in the declaration than to
leave it out. (Ideally it would be easier to make such measurements than
it actually is.)

You should use `REDUCE` instead of `APPLY` where appropriate.

You should use `REDUCE` instead of `APPLY` and a consed-up list, where
the semantics of the first operator argument otherwise guarantees the
same semantics. Of course, you must use `APPLY` if it does what you want
and `REDUCE` doesn\'t. For instance:

;; Bad (apply \#\'+ (mapcar \#\'acc frobs)) ;; Better (reduce \#\'+
frobs :key \#\'acc :initial-value 0)

This is preferable because it does not do extra consing, and does not
risk going beyond `CALL-ARGUMENTS-LIMIT` on implementations where that
limit is small, which could blow away the stack on long lists (we want
to avoid gratuitous non-portability in our code).

However, you must be careful not to use `REDUCE` in ways that needlessly
increase the complexity class of the computation. For instance,
`(REDUCE 'STRCAT ...)` is *O(n\^2)* when an appropriate implementation
is only *O(n)*. Moreover, `(REDUCE 'APPEND ...)` is also *O(n\^2)*
unless you specify `:FROM-END T`. In such cases, you MUST NOT use
`REDUCE`, and you MUST NOT use `(APPLY 'STRCAT ...)` or
`(APPLY 'APPEND ...)` either. Instead you MUST use proper abstractions
from a suitable library (that you may have to contribute to) that
properly handles those cases without burdening users with implementation
details. See for instance `UIOP:REDUCE/STRCAT`.

You should not use `NCONC`; you should use `APPEND` instead, or better,
better data structures.

You should almost never use `NCONC`. You should use `APPEND` when you
don\'t depend on any side-effect. You should use `ALEXANDRIA:APPENDF`
when you need to update a variable. You should probably not depend on
games being played with the `CDR` of the current CONS cell (which some
might argue is suggested but not guaranteed by the specification); if
you do, you must include a prominent comment explaining the use of
`NCONC`; and you should probably reconsider your data representation
strategy.

By extension, you should avoid `MAPCAN` or the `NCONC` feature of
`LOOP`. You should instead respectively use `ALEXANDRIA:MAPPEND` and the
`APPEND` feature of `LOOP`.

`NCONC` is very seldom a good idea, since its time complexity class is
no better than `APPEND`, its space complexity class also is no better
than `APPEND` in the common case where no one else is sharing the
side-effected list, and its bug complexity class is way higher than
`APPEND`.

If the small performance hit due to `APPEND` vs. `NCONC` is a limiting
factor in your program, you have a big problem and are probably using
the wrong data structure: you should be using sequences with
constant-time append (see Okasaki\'s book, and add them to
lisp-interface-library), or more simply you should be accumulating data
in a tree that will get flattened once in linear time after the
accumulation phase is complete.

You may only use `NCONC`, `MAPCAN` or the `NCONC` feature of `LOOP` in
low-level functions where performance matters, where the use of lists as
a data structure has been vetted because these lists are known to be
short, and when the function or expression the result of which are
accumulated explicitly promises in its contract that it only returns
fresh lists (in particular, it can\'t be a constant quote or backquote
expression). Even then, the use of such primitives must be rare, and
accompanied by justifying documentation.

You should usually refer to a function as `#'FUN` rather than `'FUN`.

The former, which reads as `(FUNCTION FUN)`, refers to the function
object, and is lexically scoped. The latter, which reads as
`(QUOTE FUN)`, refers to the symbol, which when called uses the global
`FDEFINITION` of the symbol.

When using functions that take a functional argument (e.g., `MAPCAR`,
`APPLY`, `:TEST` and `:KEY` arguments), you should use the `#'` to refer
to the function, not just single quote.

An exception is when you explicitly want dynamic linking, because you
anticipate that the global function binding will be updated.

Another exception is when you explicitly want to access a global
function binding, and avoid a possible shadowing lexical binding. This
shouldn\'t happen often, as it is usually a bad idea to shadow a
function when you will want to use the shadowed function; just use a
different name for the lexical function.

You must consistently use either `#'(lambda ...)` or `(lambda ...)`
without `#'` everywhere. Unlike the case of `#'symbol` vs `'symbol`, it
is only a syntactic difference with no semantic impact, except that the
former works on Genera and the latter doesn\'t. You must use the former
style if your code is intended as a library with maximal compatibility
to all Common Lisp implementations; otherwise, it is optional which
style you use. `#'` may be seen as a hint that you\'re introducing a
function in expression context; but the `lambda` itself is usually
sufficient hint, and concision is good. Choose wisely, but above all,
consistently with yourself and other developers, within a same file,
package, system, project, etc.

Note that if you start writing a new system in a heavily functional
style, you may consider using
[lambda-reader](http://cliki.net/lambda-reader), a system that lets you
use the unicode character `λ` instead of `LAMBDA`. But you must not
start using such a syntactic extension in an existing system without
getting permission from other developers.

Common Lisp pathnames are tricky. Be aware of pitfalls. Use `UIOP`.

It is surprisingly hard to properly deal with pathnames in Common Lisp.

`ASDF 3` comes with a portability library `UIOP` that makes it *much*
easier to deal with pathnames portably --- and correctly --- in Common
Lisp. You should use it when appropriate.

First, be aware of the discrepancies between the syntax of Common Lisp
pathnames, which depends on which implementation and operating system
you are using, and the native syntax of pathnames on your operating
system. The Lisp syntax may involves quoting of special characters such
as `#\.` and `#\*`, etc., in addition to the quoting of `#\\` and `#\"`
within strings. By contrast, your operating system\'s other system
programming languages (shell, C, scripting languages) may only have one
layer of quoting, into strings.

Second, when using `MERGE-PATHNAMES`, be wary of the treatment of the
`HOST` component, which matters a lot on non-Unix platforms (and even on
some Unix implementations). You probably should be using
`UIOP:MERGE-PATHNAMES*` or `UIOP:SUBPATHNAME` instead of
`MERGE-PATHNAMES`, especially if your expectations for relative
pathnames are informed by the way they work in Unix or Windows;
otherwise you might hit weird bugs whereby on some implementations,
merging a relative pathnames with an absolute pathname results in
overriding the absolute pathname\'s host and replace it with the host
from the value of `*DEFAULT-PATHNAME-DEFAULTS*` at the time the relative
pathname was created.

Third, be aware that `DIRECTORY` is not portable across implementations
in how it handles wildcards, sub-directories, symlinks, etc. There
again, `UIOP` provides several common abstractions to deal with
pathnames, but only does so good a job. For a complete portable
solution, use IOLib --- though its Windows support lags behind.

`LOGICAL-PATHNAME`s are not a portable abstraction, and should not be
used in portable code. Many implementations have bugs in them, when they
are supported at all. SBCL implements them very well, but strictly
enforces the limitations on characters allowed by the standard, which
restricts their applicability. Other implementations allow arbitrary
characters in such pathnames, but in doing so are not being conformant,
and are still incompatible with each other in many ways. You should use
other pathname abstractions, such as `ASDF:SYSTEM-RELATIVE-PATHNAME` or
the underlying `UIOP:SUBPATHNAME` and `UIOP:PARSE-UNIX-NAMESTRING`.

Finally, be aware that paths may change between the time you build the
Lisp image for your application, and the time you run the application
from its image. You should be careful to reset your image to forget
irrelevant build-time paths and reinitialize any search path from
current environment variables. `ASDF` for instance requires you to reset
its paths with `UIOP:CLEAR-CONFIGURATION`. `UIOP` provides hooks to call
functions before an image is dumped, from which to reset or `makunbound`
relevant variables.

You must be careful when using a `SATISFIES` clause in a type specifier.

Most Common Lisp implementations can\'t optimize based on a `SATISFIES`
type, but many of them offer simple optimizations based on a type of the
form `(AND FOO (SATISFIES BAR-P))` where the first term of the `AND`
clause describes the structure of the object without any `SATISFIES` and
the second term is the `SATISFIES`.

(deftype prime-number () (satisfies prime-number-p)) ; Bad (deftype
prime-number () (and integer (satisfies prime-number-p)) ; Better

However, `AND` in the `DEFTYPE` language isn\'t a left-to-right
short-circuit operator as in the expression language; it is a
symmetrical connector that allows for reordering subterms and doesn\'t
guarantee short-circuiting. Therefore, in the above example, you cannot
rely on the test for `INTEGER`ness to protect the function
`PRIME-NUMBER-P` from being supplied non-integer arguments to test for
being of instances of the type. Implementations may, and some *will*,
invoke `SATISFIES`-specified function at compile-time to test various
relevant objects.

That is why any function specified in a `SATISFIES` clause MUST accept
objects of any type as argument to the function, and MUST be defined
within an `EVAL-WHEN` (as well as any variable it uses or function it
calls):

(defun prime-number-p (n) ; Doubly bad! (let ((m (abs n))) (if (\<= m
\*prime-number-cutoff\*) (small-prime-number-p m) (big-prime-number-p
m)))) (eval-when (:compile-toplevel :load-toplevel :execute) ; Better
(defun prime-number-p (n) (when (integerp n) ; Better (let ((m (abs n)))
(if (\<= m \*prime-number-cutoff\*) (small-prime-number-p m)
(big-prime-number-p m))))))

In particular, the above means that the
[example](https://www.lispworks.com/documentation/HyperSpec/Body/t_satisf.htm)
used in the Common Lisp Standard is erroneous:
`(and integer (satisfies evenp))` is *not* a safe, conformant type
specifier to use, because `EVENP` will throw an error rather than return
`NIL` when passed a non-integer as an argument.

Finally, there is a catch when your `DEFTYPE` code expands to a
`SATISFIES` with a dynamically generated function:

-   You cannot control when implementations will or will not expand a
    `DEFTYPE`.
-   The expansion itself cannot contain a function definition or any
    code in the expression language.
-   You cannot control when the expansion is used, it may happen in a
    different process that didn\'t expand the definition.

Therefore, you cannot merely create the function as a side-effect of
expansion using `EVAL` at type-expansion time. The solution is to use
`ASDF-FINALIZERS:EVAL-AT-TOPLEVEL` instead. See the very last point in
the discussion about [EVAL](#EVAL).

Common Lisp is hard to satisfy.

------------------------------------------------------------------------

[Credits: Adam Worrall, Dan Pierson, Matt Marjanovic, Matt Reklaitis,
Paul Weiss, Scott McKay, Sundar Narasimhan, and several other people
contributed. Special thanks to Steve Hain, and to the previous editors,
in reverse chronological order Dan Weinreb and Jeremy Brown.]{.small}

Revision 1.28

Robert Brown

[François-René Rideau](mailto:tunes@google.com)
