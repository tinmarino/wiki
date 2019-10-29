---
title: C++ <- StackOverflow top 100
category: c++
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: Easiest way to convert int to string in C++ (score [2671193](https://stackoverflow.com/q/5590381) in 2018)

#### Question
What is the easiest way to convert from `int` to equivalent `string` in C++.  I am aware of two methods. Is there any easier way?  

(1)  

```c++
int a = 10;
char *intStr = itoa(a);
string str = string(intStr);
```

(2)  

```c++
int a = 10;
stringstream ss;
ss << a;
string str = ss.str();
```

#### Answer accepted (score 1940)
C++11 introduces <a href="http://en.cppreference.com/w/cpp/string/basic_string/stol" rel="noreferrer">`std::stoi`</a> (and variants for each numeric type) and <a href="http://en.cppreference.com/w/cpp/string/basic_string/to_string" rel="noreferrer">`std::to_string`</a>, the counterparts of the C `atoi` and `itoa` but expressed in term of `std::string`.  

```c++
#include <string> 

std::string s = std::to_string(42);
```

is therefore the shortest way I can think of. You can even omit naming the type, using the `auto` keyword:  

```c++
auto s = std::to_string(42);
```

<em>Note: see <strong>[string.conversions]</strong> (<strong>21.5</strong> in <a href="http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2011/n3242.pdf" rel="noreferrer">n3242</a>)</em>  

#### Answer 2 (score 179)
Picking up a discussion with @v.oddou a couple of years later, C++17 has finally delivered a way to do the originally macro-based type-agnostic solution (preserved below) <em>without</em> going through macro uglyness.  

```c++
// variadic template
template < typename... Args >
std::string sstr( Args &&... args )
{
    std::ostringstream sstr;
    // fold expression
    ( sstr << std::dec << ... << args );
    return sstr.str();
}
```

Usage:  

```c++
int i = 42;
std::string s = sstr( "i is: ", i );
puts( sstr( i ).c_str() );

Foo x( 42 );
throw std::runtime_error( sstr( "Foo is '", x, "', i is ", i ) );
```

<hr>

<strong>Original answer:</strong>  

Since "converting ... to string" is a recurring problem, I always define the <a href="http://rootdirectory.ddns.net/dokuwiki/doku.php?id=software:sstr" rel="noreferrer">SSTR()</a> macro in a central header of my C++ sources:  

```c++
#include <sstream>

#define SSTR( x ) static_cast< std::ostringstream & >( \
        ( std::ostringstream() << std::dec << x ) ).str()
```

Usage is as easy as could be:  

```c++
int i = 42;
std::string s = SSTR( "i is: " << i );
puts( SSTR( i ).c_str() );

Foo x( 42 );
throw std::runtime_error( SSTR( "Foo is '" << x << "', i is " << i ) );
```

The above is C++98 compatible (if you cannot use C++11 `std::to_string`), and does not need any third-party includes (if you cannot use Boost `lexical_cast&lt;&gt;`); both these other solutions have a better performance though.  

#### Answer 3 (score 103)
I usually use the following method:  

```c++
#include <sstream>

template <typename T>
  std::string NumberToString ( T Number )
  {
     std::ostringstream ss;
     ss << Number;
     return ss.str();
  }
```

It is described in details <a href="http://www.cplusplus.com/articles/D9j2Nwbp/" rel="nofollow noreferrer">here</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: The Definitive C++ Book Guide and List (score [2220799](https://stackoverflow.com/q/388242) in 2018)

#### Question
This question attempts to collect the few pearls among the dozens of bad C++ books that are published every year.  

Unlike many other programming languages, which are often picked up on the go from tutorials found on the Internet, few are able to quickly pick up C++ without studying a well-written C++ book. It is way too big and complex for doing this. In fact, it is so big and complex, that <strong><em>there are very many very bad C++ books</em></strong> out there. And we are not talking about bad style, but things like sporting <em>glaringly obvious factual errors</em> and <em>promoting abysmally bad programming styles</em>.  

Please edit the accepted answer to provide <strong>quality books</strong> and an approximate skill level — <em>preferably</em> <strong>after</strong> <em>discussing your addition in <a href="http://chat.stackoverflow.com/rooms/10/loungec">the C++ chat room</a></em>. (The regulars might mercilessly undo your work if they disagree with a recommendation.) Add a short blurb/description about each book that you have personally read/benefited from. Feel free to debate quality, headings, etc. Books that meet the criteria will be added to the list.  Books that have reviews by the Association of C and C++ Users (ACCU) have links to the review.   

<sub>*Note: FAQs and other resources can be found in the <a href="https://stackoverflow.com/tags/c%2b%2b/info">C++ tag info</a> and under <a href="/questions/tagged/c%2b%2b-faq" class="post-tag" title="show questions tagged &#39;c++-faq&#39;" rel="tag">c++-faq</a>. </sub>  

#### Answer 2 (score 4599)
<h5>Beginner</h2>

<h5>Introductory, no previous programming experience</h3>

<ul>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0321714113" rel="noreferrer" rel="nofollow noreferrer"><em>C++ Primer</em></a> * (Stanley Lippman, Josée Lajoie, and Barbara E. Moo)  (<strong>updated for C++11</strong>) Coming at 1k pages, this is a very thorough introduction into C++ that covers just about everything in the language in a very accessible format and in great detail. The fifth edition (released August 16, 2012) covers C++11. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=1848" rel="noreferrer">[Review]</a> </p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0321992784" rel="noreferrer" rel="nofollow noreferrer"><em>Programming: Principles and Practice Using C++</em></a> (Bjarne Stroustrup, 2nd Edition - May 25, 2014) (<strong>updated for C++11/C++14</strong>) An introduction to programming using C++ by the creator of the language. A good read, that assumes no previous programming experience, but is not only for beginners. </p></li>
</ul>

<p><sub>
* Not to be confused with <a href="https://rads.stackoverflow.com/amzn/click/com/0672326973" rel="noreferrer" rel="nofollow noreferrer"><em>C++ Primer Plus</em></a> (Stephen Prata), with a significantly less favorable <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=1744" rel="noreferrer">review</a>.
</sub></p>

<h5>Introductory, with previous programming experience</h3>

<ul>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/B00F8CWGOS" rel="noreferrer" rel="nofollow noreferrer"><em>A Tour of C++</em></a> (Bjarne Stroustrup) (<strong><a href="http://a.co/f7WPDeD" rel="noreferrer">2nd edition  for C++17</a></strong>) The “tour” is a quick (about 180 pages and 14 chapters) tutorial overview of all of standard C++ (language and standard library, <strong>and using C++11</strong>) at a moderately high level for people who already know C++ or at least are experienced programmers. This book is an extended version of the material that constitutes Chapters 2-5 of The C++ Programming Language, 4th edition.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/020170353X" rel="noreferrer" rel="nofollow noreferrer"><em>Accelerated C++</em></a> (Andrew Koenig and Barbara Moo, 1st Edition - August 24, 2000)  This basically covers the same ground as the <em>C++ Primer</em>, but does so on a fourth of its space. This is largely because it does not attempt to be an introduction to <em>programming</em>, but an introduction to <em>C++</em> for people who've previously programmed in some other language. It has a steeper learning curve, but, for those who can cope with this, it is a very compact introduction to the language. (Historically, it broke new ground by being the first beginner's book to use a modern approach to teaching the language.) Despite this, the C++
it teaches is purely C++98. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=1185" rel="noreferrer">[Review]</a></p></li>
</ul>

<h5>Best practices</h3>

<ul>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0321334876" rel="noreferrer" rel="nofollow noreferrer"><em>Effective C++</em></a> (Scott Meyers, 3rd Edition - May 22, 2005)  This was written with the aim of being the best second book C++ programmers should read, and it succeeded. Earlier editions were aimed at programmers coming from C, the third edition changes this and targets programmers coming from languages like Java. It presents ~50 easy-to-remember rules of thumb along with their rationale in a very accessible (and enjoyable) style. For C++11 and C++14 the examples and a few issues are outdated and Effective Modern C++ should be preferred. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=700" rel="noreferrer">[Review]</a></p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/1491903996" rel="noreferrer" rel="nofollow noreferrer"><em>Effective Modern C++</em></a> (Scott Meyers) This is basically the new version of <em>Effective C++</em>, aimed at C++ programmers making the transition from C++03 to C++11 and C++14. </p></li>
<li><a href="https://rads.stackoverflow.com/amzn/click/com/0201749629" rel="noreferrer" rel="nofollow noreferrer"><em>Effective STL</em></a> (Scott Meyers)  This aims to do the same to the part of the standard library coming from the STL what <em>Effective C++</em> did to the language as a whole: It presents rules of thumb along with their rationale. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=67" rel="noreferrer">[Review]</a></li>
</ul>

<hr>

<h5>Intermediate</h2>

<ul>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/020163371X" rel="noreferrer" rel="nofollow noreferrer"><em>More Effective C++</em></a> (Scott Meyers) Even more rules of thumb than <em>Effective C++</em>. Not as important as the ones in the first book, but still good to know.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201615622" rel="noreferrer" rel="nofollow noreferrer"><em>Exceptional C++</em></a> (Herb Sutter)  Presented as a set of puzzles, this has one of the best and thorough discussions of the proper resource management and exception safety in C++ through Resource Acquisition is Initialization (RAII) in addition to in-depth coverage of a variety of other topics including the pimpl idiom, name lookup, good class design, and the C++ memory model. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=209" rel="noreferrer">[Review]</a></p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/020170434X" rel="noreferrer" rel="nofollow noreferrer"><em>More Exceptional C++</em></a> (Herb Sutter)  Covers additional exception safety topics not covered in <em>Exceptional C++</em>, in addition to discussion of effective object-oriented programming in C++ and correct use of the STL. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=784" rel="noreferrer">[Review]</a></p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201760428" rel="noreferrer" rel="nofollow noreferrer"><em>Exceptional C++ Style</em></a> (Herb Sutter)  Discusses generic programming, optimization, and resource management; this book also has an excellent exposition of how to write modular code in C++ by using non-member functions and the single responsibility principle. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=107" rel="noreferrer">[Review]</a></p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0321113586" rel="noreferrer" rel="nofollow noreferrer"><em>C++ Coding Standards</em></a> (Herb Sutter and Andrei Alexandrescu) “Coding standards” here doesn't mean “how many spaces should I indent my code?”  This book contains 101 best practices, idioms, and common pitfalls that can help you to write correct, understandable, and efficient C++ code. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=1439" rel="noreferrer">[Review]</a></p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201734842" rel="noreferrer" rel="nofollow noreferrer"><em>C++ Templates: The Complete Guide</em></a> (David Vandevoorde and Nicolai M. Josuttis) This is <em>the</em> book about templates as they existed before C++11.  It covers everything from the very basics to some of the most advanced template metaprogramming and explains every detail of how templates work (both conceptually and at how they are implemented) and discusses many common pitfalls.  Has excellent summaries of the One Definition Rule (ODR) and overload resolution in the appendices. A <a href="https://rads.stackoverflow.com/amzn/click/com/0321714121" rel="noreferrer" rel="nofollow noreferrer">second edition</a> covering C++11, C++14 and C++17 has been already published. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=506" rel="noreferrer">[Review]</a></p></li>
<li><p><a href="https://leanpub.com/cpp17/" rel="noreferrer"><em>C++ 17 - The Complete Guide</em></a> (Nicolai M. Josuttis) This book describes all the new features introduced in the C++17 Standard covering everything from the simple ones like 'Inline Variables', 'constexpr if' all the way up to 'Polymorphic Memory Resources' and 'New and Delete with overaligned Data'.</p></li>
</ul>

<hr>

<h5>Advanced</h2>

<ul>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201704315" rel="noreferrer" rel="nofollow noreferrer"><em>Modern C++ Design</em></a> (Andrei Alexandrescu)  A groundbreaking book on advanced generic programming techniques.  Introduces policy-based design, type lists, and fundamental generic programming idioms then explains how many useful design patterns (including small object allocators, functors, factories, visitors, and multi-methods) can be implemented efficiently, modularly, and cleanly using generic programming. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=979" rel="noreferrer">[Review]</a></p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0321227255" rel="noreferrer" rel="nofollow noreferrer"><em>C++ Template Metaprogramming</em></a> (David Abrahams and Aleksey Gurtovoy)</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/1933988770" rel="noreferrer" rel="nofollow noreferrer"><em>C++ Concurrency In Action</em></a> (Anthony Williams) A book covering C++11 concurrency support including the thread library, the atomics library, the C++ memory model, locks and mutexes, as well as issues of designing and debugging multithreaded applications. A <a href="https://rads.stackoverflow.com/amzn/click/com/1617294691" rel="noreferrer" rel="nofollow noreferrer">second edition</a> covering C++14 and C++17 has been already published.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/1460966163" rel="noreferrer" rel="nofollow noreferrer"><em>Advanced C++ Metaprogramming</em></a> (Davide Di Gennaro) A pre-C++11 manual of TMP techniques, focused more on practice than theory.  There are a ton of snippets in this book, some of which are made obsolete by type traits, but the techniques, are nonetheless useful to know.  If you can put up with the quirky formatting/editing, it is easier to read than Alexandrescu, and arguably, more rewarding.  For more experienced developers, there is a good chance that you may pick up something about a dark corner of C++ (a quirk) that usually only comes about through extensive experience.</p></li>
</ul>

<hr>

<h5>Reference Style - All Levels</h2>

<ul>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0321958322" rel="noreferrer" rel="nofollow noreferrer"><em>The C++ Programming Language</em></a> (Bjarne Stroustrup) (<strong>updated for C++11</strong>) The classic introduction to C++ by its creator. Written to parallel the classic K&amp;R, this indeed reads very much like it and covers just about everything from the core language to the standard library, to programming paradigms to the language's philosophy. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=1853" rel="noreferrer">[Review]</a> Note: All releases of the C++ standard are tracked in this question: <a href="https://stackoverflow.com/a/4653479/14065">Where do I find the current C++ standard</a>.   </p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0321623215" rel="noreferrer" rel="nofollow noreferrer"><em>C++ Standard Library Tutorial and Reference</em></a> (Nicolai Josuttis) (<strong>updated for C++11</strong>) <em>The</em> introduction and reference for the C++ Standard Library. The second edition (released on April 9, 2012) covers C++11. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=1849" rel="noreferrer">[Review]</a></p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201183951" rel="noreferrer" rel="nofollow noreferrer"><em>The C++ IO Streams and Locales</em></a> (Angelika Langer and Klaus Kreft)  There's very little to say about this book except that, if you want to know anything about streams and locales, then this is the one place to find definitive answers. <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=200" rel="noreferrer">[Review]</a></p></li>
</ul>

<strong>C++11/14/17/… References:</strong>  

<ul>
<li><p><em>The C++<a href="https://www.iso.org/standard/50372.html" rel="noreferrer">11</a>/<a href="https://www.iso.org/standard/64029.html" rel="noreferrer">14</a>/<a href="https://www.iso.org/standard/68564.html" rel="noreferrer">17</a> Standard (INCITS/ISO/IEC 14882:2011/2014/2017)</em> This, of course, is the final arbiter of all that is or isn't C++. Be aware, however, that it is intended purely as a reference for <em>experienced</em> users willing to devote considerable time and effort to its understanding. The C++17 standard is released in electronic form for 198 Swiss Francs.</p></li>
<li><p>The C++17 standard is available, but seemingly not in an economical form – <a href="https://www.iso.org/standard/68564.html" rel="noreferrer">directly from the ISO</a> it costs 198 Swiss Francs (about $200 US). For most people, the <a href="http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2017/n4659.pdf" rel="noreferrer">final draft before standardization</a> is more than adequate (and free). Many will prefer an <a href="http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/n4778.pdf" rel="noreferrer">even newer draft</a>, documenting new features that are likely to be included in C++20.</p></li>
<li><p><a href="http://www.artima.com/shop/overview_of_the_new_cpp" rel="noreferrer"><em>Overview of the New C++ (C++11/14) (PDF only)</em></a> (Scott Meyers) (<strong>updated for C++14</strong>) These are the presentation materials (slides and some lecture notes) of a three-day training course offered by Scott Meyers, who's a highly respected author on C++. Even though the list of items is short, the quality is high.</p></li>
<li><p>The <a href="https://github.com/isocpp/CppCoreGuidelines/blob/master/CppCoreGuidelines.md" rel="noreferrer"><em>C++ Core Guidelines (C++11/14/17/…)</em></a> (edited by Bjarne Stroustrup and Herb Sutter) is an evolving online document consisting of a set of guidelines for using modern C++ well. The guidelines are focused on relatively higher-level issues, such as interfaces, resource management, memory management and concurrency affecting application architecture and library design. The project was <a href="https://isocpp.org/blog/2015/09/bjarne-stroustrup-announces-cpp-core-guidelines" rel="noreferrer">announced at CppCon'15 by Bjarne Stroustrup and others</a> and welcomes contributions from the community. Most guidelines are supplemented with a rationale and examples as well as discussions of possible tool support. Many rules are designed specifically to be automatically checkable by static analysis tools.</p></li>
<li><p>The <a href="https://isocpp.org/faq" rel="noreferrer"><em>C++ Super-FAQ</em></a> (Marshall Cline, Bjarne Stroustrup and others) is an effort by the Standard C++ Foundation to unify the C++ FAQs previously maintained individually by Marshall Cline and Bjarne Stroustrup and also incorporating new contributions. The items mostly address issues at an intermediate level and are often written with a humorous tone. Not all items might be fully up to date with the latest edition of the C++ standard yet.</p></li>
<li><p><a href="http://en.cppreference.com/" rel="noreferrer"><em>cppreference.com (C++03/11/14/17/…)</em></a> (initiated by Nate Kohl) is a wiki that summarizes the basic core-language features and has extensive documentation of the C++ standard library. The documentation is very precise but is easier to read than the official standard document and provides better navigation due to its wiki nature. The project documents all versions of the C++ standard and the site allows filtering the display for a specific version. The project was <a href="https://isocpp.org/blog/2015/07/cppcon-2014-cppreference.com-documenting-cpp-one-edit-at-a-time-nate-kohl" rel="noreferrer">presented by Nate Kohl at CppCon'14</a>.</p></li>
</ul>

<hr>

<h5>Classics / Older</h2>

<strong>Note:</strong> Some information contained within these books may not be up-to-date or no longer considered best practice.  

<ul>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201543303" rel="noreferrer" rel="nofollow noreferrer"><em>The Design and Evolution of C++</em></a> (Bjarne Stroustrup)  If you want to know <em>why</em> the language is the way it is, this book is where you find answers. This covers everything <em>before the standardization</em> of C++.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201423391" rel="noreferrer" rel="nofollow noreferrer"><em>Ruminations on C++</em></a> - (Andrew Koenig and Barbara Moo) <a href="http://accu.org/index.php?module=bookreviews&amp;func=search&amp;rid=776" rel="noreferrer">[Review]</a></p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201548550" rel="noreferrer" rel="nofollow noreferrer"><em>Advanced C++ Programming Styles and Idioms</em></a> (James Coplien)  A predecessor of the pattern movement, it describes many C++-specific “idioms”. It's certainly a very good book and might still be worth a read if you can spare the time, but quite old and not up-to-date with current C++. </p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201633620" rel="noreferrer" rel="nofollow noreferrer"><em>Large Scale C++ Software Design</em></a> (John Lakos)  Lakos explains techniques to manage very big C++ software projects. Certainly, a good read, if it only was up to date. It was written long before C++ 98 and misses on many features (e.g. namespaces) important for large-scale projects. If you need to work in a big C++ software project, you might want to read it, although you need to take more than a grain of salt with it. The first volume of a new edition is <a href="https://rads.stackoverflow.com/amzn/click/com/0201717069" rel="noreferrer" rel="nofollow noreferrer">expected in 2019</a>.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201834545" rel="noreferrer" rel="nofollow noreferrer"><em>Inside the C++ Object Model</em></a> (Stanley Lippman)  If you want to know how virtual member functions are commonly implemented and how base objects are commonly laid out in memory in a multi-inheritance scenario, and how all this affects performance, this is where you will find thorough discussions of such topics.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201514591" rel="noreferrer" rel="nofollow noreferrer"><em>The Annotated C++ Reference Manual</em></a> (Bjarne Stroustrup, Margaret A. Ellis) This book is quite outdated in the fact that it explores the 1989 C++ 2.0 version - Templates, exceptions, namespaces and new casts were not yet introduced. Saying that however, this book goes through the entire C++ standard of the time explaining the rationale, the possible implementations, and features of the language. This is not a book to learn programming principles and patterns on C++, but to understand every aspect of the C++ language.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0139798099" rel="noreferrer" rel="nofollow noreferrer"><em>Thinking in C++</em></a> (Bruce Eckel, 2nd Edition, 2000).  Two volumes; is a tutorial style <em>free</em> set of intro level books. Downloads: <a href="https://ia800100.us.archive.org/10/items/TICPP2ndEdVolOne/TICPP-2nd-ed-Vol-one.zip" rel="noreferrer">vol 1</a>, <a href="https://ia800108.us.archive.org/24/items/TICPP2ndEdVolTwo/TICPP-2nd-ed-Vol-two.zip" rel="noreferrer">vol 2</a>. Unfortunately they&rsquo;re marred by a number of trivial errors (e.g. maintaining that temporaries are automatically `const`), with no official errata list. A partial 3<sup>rd</sup> party errata list is available at (<a href="http://www.computersciencelab.com/Eckel.htm" rel="noreferrer">http://www.computersciencelab.com/Eckel.htm</a>), but it&rsquo;s apparently not maintained.</p></li>
<li><p><a href="https://rads.stackoverflow.com/amzn/click/com/0201533936" rel="noreferrer" rel="nofollow noreferrer"><em>Scientific and Engineering C++: An Introduction to Advanced Techniques and Examples</em></a> (John Barton and Lee Nackman) 
It is a comprehensive and very detailed book that tried to explain and make use of all the features available in C++, in the context of numerical methods. It introduced at the time several new techniques, such as the Curiously Recurring Template Pattern (CRTP, also called Barton-Nackman trick).
It pioneered several techniques such as dimensional analysis and automatic differentiation. 
It came with a lot of compilable and useful code, ranging from an expression parser to a Lapack wrapper. 
The code is still available here: <a href="http://www.informit.com/store/scientific-and-engineering-c-plus-plus-an-introduction-9780201533934" rel="noreferrer">http://www.informit.com/store/scientific-and-engineering-c-plus-plus-an-introduction-9780201533934</a>.
Unfortunately, the books have become somewhat outdated in the style and C++ features, however, it was an incredible tour-de-force at the time (1994, pre-STL).
The chapters on dynamics inheritance are a bit complicated to understand and not very useful.
An updated version of this classic book that includes move semantics and the lessons learned from the STL would be very nice.</p></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How do I iterate over the words of a string? (score [2132194](https://stackoverflow.com/q/236129) in 2018)

#### Question
I'm trying to iterate over the words of a string.  

The string can be assumed to be composed of words separated by whitespace.  

Note that I'm not interested in C string functions or that kind of character manipulation/access. Also, please give precedence to elegance over efficiency in your answer.  

The best solution I have right now is:  

```c++
#include <iostream>
#include <sstream>
#include <string>

using namespace std;

int main()
{
    string s = "Somewhere down the road";
    istringstream iss(s);

    do
    {
        string subs;
        iss >> subs;
        cout << "Substring: " << subs << endl;
    } while (iss);
}
```

Is there a more elegant way to do this?  

#### Answer accepted (score 1311)
For what it's worth, here's another way to extract tokens from an input string, relying only on standard library facilities. It's an example of the power and elegance behind the design of the STL.  

```c++
#include <iostream>
#include <string>
#include <sstream>
#include <algorithm>
#include <iterator>

int main() {
    using namespace std;
    string sentence = "And I feel fine...";
    istringstream iss(sentence);
    copy(istream_iterator<string>(iss),
         istream_iterator<string>(),
         ostream_iterator<string>(cout, "\n"));
}
```

Instead of copying the extracted tokens to an output stream, one could insert them into a container, using the same generic <a href="https://en.cppreference.com/w/cpp/algorithm/copy" rel="noreferrer">`copy`</a> algorithm.  

```c++
vector<string> tokens;
copy(istream_iterator<string>(iss),
     istream_iterator<string>(),
     back_inserter(tokens));
```

... or create the `vector` directly:  

```c++
vector<string> tokens{istream_iterator<string>{iss},
                      istream_iterator<string>{}};
```

#### Answer 2 (score 2391)
I use this to split string by a delimiter. The first puts the results in a pre-constructed vector, the second returns a new vector.  



```c++
#include <string>
#include <sstream>
#include <vector>
#include <iterator>

template <typename Out>
void split(const std::string &s, char delim, Out result) {
    std::istringstream iss(s);
    std::string item;
    while (std::getline(iss, item, delim)) {
        *result++ = item;
    }
}

std::vector<std::string> split(const std::string &s, char delim) {
    std::vector<std::string> elems;
    split(s, delim, std::back_inserter(elems));
    return elems;
}
```

<hr>

Note that this solution does not skip empty tokens, so the following will find 4 items, one of which is empty:  

```c++
std::vector<std::string> x = split("one:two::three", ':');
```

#### Answer 3 (score 825)
A possible solution using Boost might be:  

```c++
#include <boost/algorithm/string.hpp>
std::vector<std::string> strs;
boost::split(strs, "string to split", boost::is_any_of("\t "));
```

This approach might be even faster than the `stringstream` approach. And since this is a generic template function it can be used to split other types of strings (wchar, etc. or UTF-8) using all kinds of delimiters.  

See the <a href="http://www.boost.org/doc/libs/1_36_0/doc/html/string_algo/usage.html" rel="noreferrer">documentation</a> for details.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: Convert char to int in C and C++ (score [1516373](https://stackoverflow.com/q/5029840) in 2011)

#### Question
How do I convert a `char` to an `int` in C and C++?  

#### Answer 2 (score 466)
Depends on what you want to do:  

to read the value as an ascii code, you can write  

```c++
char a = 'a';
int ia = (int)a; 
/* note that the int cast is not necessary -- int ia = a would suffice */
```

to convert the character `'0' -&gt; 0`, `'1' -&gt; 1`, etc, you can write  

```c++
char a = '4';
int ia = a - '0';
/* check here if ia is bounded by 0 and 9 */
```

<p><strong>Explanation</strong>:<br>
`a - '0'` is equivalent to `((int)a) - ((int)'0')`, which means the ascii values of the characters are subtracted from each other. Since `0` comes directly before `1` in the ascii table (and so on until `9`), the difference between the two gives the number that the character `a` represents.</p>

#### Answer 3 (score 78)
Well, in ASCII code, the numbers (digits) start from <strong>48</strong>. All you need to do is:  

```c++
int x = (int)character - 48;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Why is processing a sorted array faster than processing an unsorted array? (score [1410048](https://stackoverflow.com/q/11227809) in 2019)

#### Question
Here is a piece of C++ code that shows some very peculiar behavior. For some strange reason, sorting the data miraculously makes the code almost six times faster:  

```c++
#include <algorithm>
#include <ctime>
#include <iostream>

int main()
{
    // Generate data
    const unsigned arraySize = 32768;
    int data[arraySize];

    for (unsigned c = 0; c < arraySize; ++c)
        data[c] = std::rand() % 256;

    // !!! With this, the next loop runs faster.
    std::sort(data, data + arraySize);

    // Test
    clock_t start = clock();
    long long sum = 0;

    for (unsigned i = 0; i < 100000; ++i)
    {
        // Primary loop
        for (unsigned c = 0; c < arraySize; ++c)
        {
            if (data[c] >= 128)
                sum += data[c];
        }
    }

    double elapsedTime = static_cast<double>(clock() - start) / CLOCKS_PER_SEC;

    std::cout << elapsedTime << std::endl;
    std::cout << "sum = " << sum << std::endl;
}
```

<ul>
<li>Without `std::sort(data, data + arraySize);`, the code runs in 11.54 seconds.</li>
<li>With the sorted data, the code runs in 1.93 seconds.</li>
</ul>

<hr>

Initially, I thought this might be just a language or compiler anomaly, so I tried Java:  

```c++
import java.util.Arrays;
import java.util.Random;

public class Main
{
    public static void main(String[] args)
    {
        // Generate data
        int arraySize = 32768;
        int data[] = new int[arraySize];

        Random rnd = new Random(0);
        for (int c = 0; c < arraySize; ++c)
            data[c] = rnd.nextInt() % 256;

        // !!! With this, the next loop runs faster
        Arrays.sort(data);

        // Test
        long start = System.nanoTime();
        long sum = 0;

        for (int i = 0; i < 100000; ++i)
        {
            // Primary loop
            for (int c = 0; c < arraySize; ++c)
            {
                if (data[c] >= 128)
                    sum += data[c];
            }
        }

        System.out.println((System.nanoTime() - start) / 1000000000.0);
        System.out.println("sum = " + sum);
    }
}
```

With a similar but less extreme result.  

<hr>

My first thought was that sorting brings the data into the cache, but then I thought how silly that was because the array was just generated.  

<ul>
<li>What is going on?</li>
<li>Why is processing a sorted array faster than processing an unsorted array?</li>
</ul>

The code is summing up some independent terms, so the order should not matter.                         

#### Answer accepted (score 30765)
<strong>You are a victim of <a href="//en.wikipedia.org/wiki/Branch_predictor" rel="noreferrer">branch prediction</a> fail.</strong>  

<hr>

<h5>What is Branch Prediction?</h2>

Consider a railroad junction:  

<p><a href="//commons.wikimedia.org/wiki/File:Entroncamento_do_Transpraia.JPG" rel="noreferrer"><img src="https://i.stack.imgur.com/muxnt.jpg" alt="Image showing a railroad junction"></a>
<sub><a href="//commons.wikimedia.org/wiki/File:Entroncamento_do_Transpraia.JPG" rel="noreferrer">Image</a> by Mecanismo, via Wikimedia Commons. Used under the <a href="//creativecommons.org/licenses/by-sa/3.0/deed.en" rel="noreferrer">CC-By-SA 3.0</a> license.</sub></p>

Now for the sake of argument, suppose this is back in the 1800s - before long distance or radio communication.  

You are the operator of a junction and you hear a train coming. You have no idea which way it is supposed to go. You stop the train to ask the driver which direction they want. And then you set the switch appropriately.  

<em>Trains are heavy and have a lot of inertia. So they take forever to start up and slow down.</em>  

Is there a better way? You guess which direction the train will go!  

<ul>
<li>If you guessed right, it continues on.</li>
<li>If you guessed wrong, the captain will stop, back up, and yell at you to flip the switch. Then it can restart down the other path.</li>
</ul>

<p><strong>If you guess right every time</strong>, the train will never have to stop. <br/>
<strong>If you guess wrong too often</strong>, the train will spend a lot of time stopping, backing up, and restarting.</p>

<hr>

<strong>Consider an if-statement:</strong> At the processor level, it is a branch instruction:  

<img src="https://i.stack.imgur.com/pyfwC.png" alt="Screenshot of compiled code containing an if statement">  

You are a processor and you see a branch. You have no idea which way it will go. What do you do? You halt execution and wait until the previous instructions are complete. Then you continue down the correct path.  

<em>Modern processors are complicated and have long pipelines. So they take forever to "warm up" and "slow down".</em>  

Is there a better way? You guess which direction the branch will go!  

<ul>
<li>If you guessed right, you continue executing.</li>
<li>If you guessed wrong, you need to flush the pipeline and roll back to the branch. Then you can restart down the other path.</li>
</ul>

<p><strong>If you guess right every time</strong>, the execution will never have to stop. <br/>
<strong>If you guess wrong too often</strong>, you spend a lot of time stalling, rolling back, and restarting.</p>

<hr>

This is branch prediction. I admit it's not the best analogy since the train could just signal the direction with a flag. But in computers, the processor doesn't know which direction a branch will go until the last moment.  

So how would you strategically guess to minimize the number of times that the train must back up and go down the other path? You look at the past history! If the train goes left 99% of the time, then you guess left. If it alternates, then you alternate your guesses. If it goes one way every three times, you guess the same...  

<strong><em>In other words, you try to identify a pattern and follow it.</em></strong> This is more or less how branch predictors work.  

Most applications have well-behaved branches. So modern branch predictors will typically achieve >90% hit rates. But when faced with unpredictable branches with no recognizable patterns, branch predictors are virtually useless.  

Further reading: <a href="//en.wikipedia.org/wiki/Branch_predictor" rel="noreferrer">"Branch predictor" article on Wikipedia</a>.  

<hr>

<h5>As hinted from above, the culprit is this if-statement:</h2>

```c++
if (data[c] >= 128)
    sum += data[c];
```

Notice that the data is evenly distributed between 0 and 255. When the data is sorted, roughly the first half of the iterations will not enter the if-statement. After that, they will all enter the if-statement.  

This is very friendly to the branch predictor since the branch consecutively goes the same direction many times. Even a simple saturating counter will correctly predict the branch except for the few iterations after it switches direction.  

<strong>Quick visualization:</strong>  

```c++
T = branch taken
N = branch not taken

data[] = 0, 1, 2, 3, 4, ... 126, 127, 128, 129, 130, ... 250, 251, 252, ...
branch = N  N  N  N  N  ...   N    N    T    T    T  ...   T    T    T  ...

       = NNNNNNNNNNNN ... NNNNNNNTTTTTTTTT ... TTTTTTTTTT  (easy to predict)
```

However, when the data is completely random, the branch predictor is rendered useless, because it can't predict random data. Thus there will probably be around 50% misprediction (no better than random guessing).  

```c++
data[] = 226, 185, 125, 158, 198, 144, 217, 79, 202, 118,  14, 150, 177, 182, 133, ...
branch =   T,   T,   N,   T,   T,   T,   T,  N,   T,   N,   N,   T,   T,   T,   N  ...

       = TTNTTTTNTNNTTTN ...   (completely random - hard to predict)
```

<hr>

<strong>So what can be done?</strong>  

If the compiler isn't able to optimize the branch into a conditional move, you can try some hacks if you are willing to sacrifice readability for performance.  

Replace:  

```c++
if (data[c] >= 128)
    sum += data[c];
```

with:  

```c++
int t = (data[c] - 128) >> 31;
sum += ~t & data[c];
```

This eliminates the branch and replaces it with some bitwise operations.  

<sub>(Note that this hack is not strictly equivalent to the original if-statement. But in this case, it's valid for all the input values of `data[]`.)</sub>  

<strong>Benchmarks: Core i7 920 @ 3.5 GHz</strong>  

C++ - Visual Studio 2010 - x64 Release  

```c++
//  Branch - Random
seconds = 11.777

//  Branch - Sorted
seconds = 2.352

//  Branchless - Random
seconds = 2.564

//  Branchless - Sorted
seconds = 2.587
```

Java - NetBeans 7.1.1 JDK 7 - x64  

```c++
//  Branch - Random
seconds = 10.93293813

//  Branch - Sorted
seconds = 5.643797077

//  Branchless - Random
seconds = 3.113581453

//  Branchless - Sorted
seconds = 3.186068823
```

Observations:  

<ul>
<li><strong>With the Branch:</strong> There is a huge difference between the sorted and unsorted data.</li>
<li><strong>With the Hack:</strong> There is no difference between sorted and unsorted data.</li>
<li>In the C++ case, the hack is actually a tad slower than with the branch when the data is sorted.</li>
</ul>

A general rule of thumb is to avoid data-dependent branching in critical loops (such as in this example).  

<hr>

<strong>Update:</strong>  

<ul>
<li><p>GCC 4.6.1 with `-O3` or `-ftree-vectorize` on x64 is able to generate a conditional move. So there is no difference between the sorted and unsorted data - both are fast.</p></li>
<li><p>VC++ 2010 is unable to generate conditional moves for this branch even under `/Ox`.</p></li>
<li><p><a href="https://en.wikipedia.org/wiki/Intel_C%2B%2B_Compiler" rel="noreferrer">Intel C++ Compiler</a> (ICC) 11 does something miraculous. It <a href="https://en.wikipedia.org/wiki/Loop_interchange" rel="noreferrer">interchanges the two loops</a>, thereby hoisting the unpredictable branch to the outer loop. So not only is it immune the mispredictions, it is also twice as fast as whatever VC++ and GCC can generate! In other words, ICC took advantage of the test-loop to defeat the benchmark...</p></li>
<li><p>If you give the Intel compiler the branchless code, it just out-right vectorizes it... and is just as fast as with the branch (with the loop interchange).</p></li>
</ul>

This goes to show that even mature modern compilers can vary wildly in their ability to optimize code...  

#### Answer 2 (score 3958)
<strong>Branch prediction.</strong>  

With a sorted array, the condition `data[c] &gt;= 128` is first `false` for a streak of values, then becomes `true` for all later values. That's easy to predict. With an unsorted array, you pay for the branching cost.  

#### Answer 3 (score 3198)
The reason why performance improves drastically when the data is sorted is that the branch prediction penalty is removed, as explained beautifully in <a href="https://stackoverflow.com/questions/11227809/why-is-it-faster-to-process-a-sorted-array-than-an-unsorted-array/11227902#11227902">Mysticial's answer</a>.  

Now, if we look at the code  

```c++
if (data[c] >= 128)
    sum += data[c];
```

we can find that the meaning of this particular `if... else...` branch is to add something when a condition is satisfied. This type of branch can be easily transformed into a <strong>conditional move</strong> statement, which would be compiled into a conditional move instruction: `cmovl`, in an `x86` system. The branch and thus the potential branch prediction penalty is removed.  

In `C`, thus `C++`, the statement, which would compile directly (without any optimization) into the conditional move instruction in `x86`, is the ternary operator `... ? ... : ...`. So we rewrite the above statement into an equivalent one:  

```c++
sum += data[c] >=128 ? data[c] : 0;
```

While maintaining readability, we can check the speedup factor.  

On an Intel <a href="http://en.wikipedia.org/wiki/Intel_Core#Core_i7" rel="noreferrer">Core i7</a>-2600K @ 3.4&nbsp;GHz and Visual Studio 2010 Release Mode, the benchmark is (format copied from Mysticial):  

<strong>x86</strong>  

```c++
//  Branch - Random
seconds = 8.885

//  Branch - Sorted
seconds = 1.528

//  Branchless - Random
seconds = 3.716

//  Branchless - Sorted
seconds = 3.71
```

<strong>x64</strong>  

```c++
//  Branch - Random
seconds = 11.302

//  Branch - Sorted
 seconds = 1.830

//  Branchless - Random
seconds = 2.736

//  Branchless - Sorted
seconds = 2.737
```

The result is robust in multiple tests. We get a great speedup when the branch result is unpredictable, but we suffer a little bit when it is predictable. In fact, when using a conditional move, the performance is the same regardless of the data pattern.  

Now let's look more closely by investigating the `x86` assembly they generate. For simplicity, we use two functions `max1` and `max2`.  

`max1` uses the conditional branch `if... else ...`:  

```c++
int max1(int a, int b) {
    if (a > b)
        return a;
    else
        return b;
}
```

`max2` uses the ternary operator `... ? ... : ...`:  

```c++
int max2(int a, int b) {
    return a > b ? a : b;
}
```

On a x86-64 machine, `GCC -S` generates the assembly below.  

```c++
:max1
    movl    %edi, -4(%rbp)
    movl    %esi, -8(%rbp)
    movl    -4(%rbp), %eax
    cmpl    -8(%rbp), %eax
    jle     .L2
    movl    -4(%rbp), %eax
    movl    %eax, -12(%rbp)
    jmp     .L4
.L2:
    movl    -8(%rbp), %eax
    movl    %eax, -12(%rbp)
.L4:
    movl    -12(%rbp), %eax
    leave
    ret

:max2
    movl    %edi, -4(%rbp)
    movl    %esi, -8(%rbp)
    movl    -4(%rbp), %eax
    cmpl    %eax, -8(%rbp)
    cmovge  -8(%rbp), %eax
    leave
    ret
```

`max2` uses much less code due to the usage of instruction `cmovge`. But the real gain is that `max2` does not involve branch jumps, `jmp`, which would have a significant performance penalty if the predicted result is not right.  

So why does a conditional move perform better?  

In a typical `x86` processor, the execution of an instruction is divided into several stages. Roughly, we have different hardware to deal with different stages. So we do not have to wait for one instruction to finish to start a new one. This is called <strong><a href="http://en.wikipedia.org/wiki/Pipeline_%28computing%29" rel="noreferrer">pipelining</a></strong>.  

In a branch case, the following instruction is determined by the preceding one, so we cannot do pipelining. We have to either wait or predict.  

In a conditional move case, the execution conditional move instruction is divided into several stages, but the earlier stages like `Fetch` and `Decode` does not depend on the result of the previous instruction; only latter stages need the result. Thus, we wait a fraction of one instruction's execution time. This is why the conditional move version is slower than the branch when prediction is easy.  

The book <em><a href="https://rads.stackoverflow.com/amzn/click/com/0136108040" rel="noreferrer" rel="nofollow noreferrer">Computer Systems: A Programmer's Perspective, second edition</a></em> explains this in detail. You can check Section 3.6.6 for <em>Conditional Move Instructions</em>, entire Chapter 4 for <em>Processor Architecture</em>, and Section 5.11.2 for a special treatment for <em>Branch Prediction and Misprediction Penalties</em>.  

Sometimes, some modern compilers can optimize our code to assembly with better performance, sometimes some compilers can't (the code in question is using Visual Studio's native compiler). Knowing the performance difference between branch and conditional move when unpredictable can help us write code with better performance when the scenario gets so complex that the compiler can not optimize them automatically.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: How do I find the length of an array? (score [1265750](https://stackoverflow.com/q/4108313) in 2011)

#### Question
Is there a way to find how many values an array has?  Detecting whether or not I've reached the end of an array would also work.  

#### Answer accepted (score 467)
If you mean a C-style array, then you can do something like:  

```c++
int a[7];
std::cout << "Length of array = " << (sizeof(a)/sizeof(*a)) << std::endl;
```

This doesn't work on pointers, though, i.e. it <strong>won't</strong> work for either of the following:  

```c++
int *p = new int[7];
std::cout << "Length of array = " << (sizeof(p)/sizeof(*p)) << std::endl;
```

or:  

```c++
void func(int *p)
{
    std::cout << "Length of array = " << (sizeof(p)/sizeof(*p)) << std::endl;
}

int a[7];
func(a);
```

In C++, if you want this kind of behaviour, then you should be using a container class; probably <a href="http://en.cppreference.com/w/cpp/container/vector">`std::vector`</a>.  

#### Answer 2 (score 129)
As other's said you can use the `sizeof(arr)/sizeof(*arr)` but this will give you the wrong answer for pointer types that aren't arrays.  

```c++
template<class T, size_t N>
constexpr size_t size(T (&)[N]) { return N; }
```

This has the nice property of failing to compile for non array types (visual studio has <a href="http://msdn.microsoft.com/en-us/library/ms175773.aspx" rel="noreferrer">`_countof`</a> which does this). The <a href="http://en.cppreference.com/w/cpp/language/constexpr" rel="noreferrer">`constexpr`</a> makes this a compile time expression so it doesn't have any drawbacks over the macro (at least none I know of).  

You can also consider using `std::array` from C++11 which exposes its length with no overhead over a native C array.  

<strong>C++17</strong> has <a href="https://en.cppreference.com/w/cpp/iterator/size" rel="noreferrer">`std::size()`</a> in the `&lt;iterator&gt;` header which does the same and works for STL containers too (thanks to <a href="https://stackoverflow.com/a/48543672/3848">@Jon C</a>).  

#### Answer 3 (score 77)
Doing `sizeof( myArray )` will get you the total number of bytes allocated for that array. You can then find out the number of elements in the array by dividing by the size of one element in the array: `sizeof( myArray[0] )`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: How can I convert a std::string to int? (score [1229147](https://stackoverflow.com/q/7663709) in 2018)

#### Question
Just have a quick question. I've looked around the internet quite a bit  and I've found a few solutions but none of them have worked yet. Looking at converting a string to an int and I don't mean ASCII codes.  

For a quick run-down, we are passed in an equation as a string. We are to break it down, format it correctly and solve the linear equations. Now, in saying that, I'm not able to convert a string to an int.  

I know that the string will be in either the format (-5) or (25) etc. so it's definitely an int. But how do we extract that from a string?  

One way I was thinking is running a for/while loop through the string, check for a digit, extract all the digits after that and then look to see if there was a leading '-', if there is, multiply the int by -1.  

It seems a bit over complicated for such a small problem though. Any ideas?  

#### Answer accepted (score 647)
In C++11 there are some nice new convert functions from `std::string` to a number type.  

So instead of   

```c++
atoi( str.c_str() )
```

you can use  

```c++
std::stoi( str )
```

where `str` is your number as `std::string`.  

<p>There are version for all flavours of numbers:
`long stol(string)`, `float stof(string)`, `double stod(string)`,...
see <a href="http://en.cppreference.com/w/cpp/string/basic_string/stol">http://en.cppreference.com/w/cpp/string/basic_string/stol</a></p>

#### Answer 2 (score 58)
```c++
std::istringstream ss(thestring);
ss >> thevalue;
```

To be fully correct you'll want to check the error flags.  

#### Answer 3 (score 37)
use the atoi function to convert the string to an integer:  

```c++
string a = "25";

int b = atoi(a.c_str());
```

<a href="http://www.cplusplus.com/reference/clibrary/cstdlib/atoi/">http://www.cplusplus.com/reference/clibrary/cstdlib/atoi/</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: Read file line by line using ifstream in C++ (score [1228489](https://stackoverflow.com/q/7868936) in 2018)

#### Question
The contents of file.txt are:  

```c++
5 3
6 4
7 1
10 5
11 6
12 3
12 4
```

<p>Where `5 3` is a coordinate pair.
How do I process this data line by line in C++?</p>

I am able to get the first line, but how do I get the next line of the file?  

```c++
ifstream myfile;
myfile.open ("text.txt");
```

#### Answer accepted (score 856)
First, make an `ifstream`:  

```c++
#include <fstream>
std::ifstream infile("thefile.txt");
```

The two standard methods are:  

<ol>
<li><p>Assume that every line consists of two numbers and read token by token:</p>

```c++
int a, b;
while (infile >> a >> b)
{
    // process pair (a,b)
}
```</li>
<li><p>Line-based parsing, using string streams:</p>

```c++
#include <sstream>
#include <string>

std::string line;
while (std::getline(infile, line))
{
    std::istringstream iss(line);
    int a, b;
    if (!(iss >> a >> b)) { break; } // error

    // process pair (a,b)
}
```</li>
</ol>

You shouldn't mix (1) and (2), since the token-based parsing doesn't gobble up newlines, so you may end up with spurious empty lines if you use `getline()` after token-based extraction got you to the end of a line already.  

#### Answer 2 (score 164)
Use `ifstream` to read data from a file:  

```c++
std::ifstream input( "filename.ext" );
```

If you really need to read line by line, then do this:  

```c++
for( std::string line; getline( input, line ); )
{
    ...for each line in input...
}
```

But you probably just need to extract coordinate pairs:  

```c++
int x, y;
input >> x >> y;
```

<strong>Update:</strong>  

In your code you use `ofstream myfile;`, however the `o` in `ofstream` stands for `output`. If you want to read from the file (input) use `ifstream`. If you want to both read and write use `fstream`.  

#### Answer 3 (score 39)
Reading a file line by line in C++ can be done in some different ways.  

<h5>[Fast] Loop with std::getline()</h2>

The simplest approach is to open an std::ifstream and loop using std::getline() calls. The code is clean and easy to understand.  

```c++
#include <fstream>

std::ifstream file(FILENAME);
if (file.is_open()) {
    std::string line;
    while (getline(file, line)) {
        // using printf() in all tests for consistency
        printf("%s", line.c_str());
    }
    file.close();
}
```

<h5>[Fast] Use Boost's file_description_source</h2>

Another possibility is to use the Boost library, but the code gets a bit more verbose. The performance is quite similar to the code above (Loop with std::getline()).  

```c++
#include <boost/iostreams/device/file_descriptor.hpp>
#include <boost/iostreams/stream.hpp>
#include <fcntl.h>

namespace io = boost::iostreams;

void readLineByLineBoost() {
    int fdr = open(FILENAME, O_RDONLY);
    if (fdr >= 0) {
        io::file_descriptor_source fdDevice(fdr, io::file_descriptor_flags::close_handle);
        io::stream <io::file_descriptor_source> in(fdDevice);
        if (fdDevice.is_open()) {
            std::string line;
            while (std::getline(in, line)) {
                // using printf() in all tests for consistency
                printf("%s", line.c_str());
            }
            fdDevice.close();
        }
    }
}
```

<h5>[Fastest] Use C code</h2>

If performance is critical for your software, you may consider using the C language. This code can be 4-5 times faster than the C++ versions above, see benchmark below  

```c++
FILE* fp = fopen(FILENAME, "r");
if (fp == NULL)
    exit(EXIT_FAILURE);

char* line = NULL;
size_t len = 0;
while ((getline(&line, &len, fp)) != -1) {
    // using printf() in all tests for consistency
    printf("%s", line);
}
fclose(fp);
if (line)
    free(line);
```

<h5>Benchmark -- Which one is faster?</h2>

I have done some performance benchmarks with the code above and the results are interesting. I have tested the code with ASCII files that contain 100,000 lines, 1,000,000 lines and 10,000,000 lines of text. Each line of text contains 10 words in average. The program is compiled with `-O3` optimization and its output is forwarded to `/dev/null` in order to remove the logging time variable from the measurement. Last, but not least, each piece of code logs each line with the `printf()` function for consistency.  

The results show the time (in ms) that each piece of code took to read the files.  

The performance difference between the two C++ approaches is minimal and shouldn't make any difference in practice. The performance of the C code is what makes the benchmark impressive and can be a game changer in terms of speed.  

```c++
                             10K lines     100K lines     1000K lines
Loop with std::getline()         105ms          894ms          9773ms
Boost code                       106ms          968ms          9561ms
C code                            23ms          243ms          2397ms
```

<a href="https://i.stack.imgur.com/fKKqc.png" rel="noreferrer"><img src="https://i.stack.imgur.com/fKKqc.png" alt="enter image description here"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: What does the C++ standard state the size of int, long type to be? (score [1194580](https://stackoverflow.com/q/589575) in 2016)

#### Question
<p>I'm looking for detailed information regarding the size of basic C++ types.
I know that it depends on the architecture (16 bits, 32 bits, 64 bits) and the compiler.</p>

But are there any standards for C++?  

I'm using Visual Studio 2008 on a 32-bit architecture. Here is what I get:  

```c++
char  : 1 byte
short : 2 bytes
int   : 4 bytes
long  : 4 bytes
float : 4 bytes
double: 8 bytes
```

I tried to find, without much success, reliable information stating the sizes of `char`, `short`, `int`, `long`, `double`, `float` (and other types I didn't think of) under different architectures and compilers.  

#### Answer 2 (score 667)
<p>The C++ standard does not specify the size of integral types in bytes, but it specifies minimum ranges they must be able to hold. You can infer minimum size in bits from the required range. You can infer minimum size in bytes from that and the value of the `CHAR_BIT` macro that <a href="https://stackoverflow.com/questions/437470/type-to-use-to-represent-a-byte-in-ansi-c89-90-c/437640#437640">defines the number of bits in a byte</a>. In all but the most obscure platforms it's 8, and it can't be less than 8. That's because it must be large enough to hold "the eight-bit code units of the Unicode UTF-8
encoding form."</p>

One additional constraint for `char` is that its size is always 1 byte, or `CHAR_BIT` bits (hence the name). This is stated explicitly in the standard.  

The C standard is a <em>normative reference</em> for the C++ standard, so even though it doesn't state these requirements explicitly, C++ requires the minimum ranges <a href="http://www.open-std.org/JTC1/SC22/WG14/www/docs/n1256.pdf" rel="nofollow noreferrer">required by the C standard</a> (page 22), which are the same as those from Data Type Ranges on <a href="http://msdn.microsoft.com/en-us/library/s3f49ktz.aspx" rel="nofollow noreferrer">MSDN</a>:  

<ol>
<li>`signed char`: -127 to 127 (note, not -128 to 127; this accommodates 1's-complement and sign-and-magnitude platforms)</li>
<li>`unsigned char`: 0 to 255</li>
<li>"plain" `char`: same range as `signed char` or `unsigned char`, <a href="https://stackoverflow.com/q/2397984">implementation-defined</a></li>
<li>`signed short`: -32767 to 32767</li>
<li>`unsigned short`: 0 to 65535</li>
<li>`signed int`: -32767 to 32767</li>
<li>`unsigned int`: 0 to 65535</li>
<li>`signed long`: -2147483647 to 2147483647</li>
<li>`unsigned long`: 0 to 4294967295</li>
<li>`signed long long`: -9223372036854775807 to 9223372036854775807</li>
<li>`unsigned long long`: 0 to 18446744073709551615</li>
</ol>

A C++ (or C) implementation can define the size of a type in bytes `sizeof(type)` to any value, as long as  

<ol>
<li>the expression `sizeof(type) * CHAR_BIT` evaluates to a number of bits high enough to contain required ranges, and</li>
<li>the ordering of type is still valid (e.g. `sizeof(int) &lt;= sizeof(long)`).</li>
</ol>

Putting this all together, we are guaranteed that:  

<ul>
<li>`char`, `signed char`, and `unsigned char` are at least 8 bits</li>
<li>`signed short`, `unsigned short`, `signed int`, and `unsigned int` are at least 16 bits</li>
<li>`signed long` and `unsigned long` are at least 32 bits</li>
<li>`signed long long` and `unsigned long long` are at least 64 bits</li>
</ul>

No guarantee is made about the size of `float` or `double` except that `double` provides at least as much precision as `float`.  

The actual implementation-specific ranges can be found in `&lt;limits.h&gt;` header in C, or `&lt;climits&gt;` in C++ (or even better, templated `std::numeric_limits` in `&lt;limits&gt;` header).  

For example, this is how you will find maximum range for `int`:  

<strong>C:</strong>  

```c++
#include <limits.h>
const int min_int = INT_MIN;
const int max_int = INT_MAX;
```

<strong>C++</strong>:  

```c++
#include <limits>
const int min_int = std::numeric_limits<int>::min();
const int max_int = std::numeric_limits<int>::max();
```

#### Answer 3 (score 233)
For 32-bit systems, the 'de facto' standard is ILP32 — that is, `int`, `long` and pointer are all 32-bit quantities.  

For 64-bit systems, the primary Unix 'de facto' standard is LP64 — `long` and pointer are 64-bit (but `int` is 32-bit).  The Windows 64-bit standard is LLP64 — `long long` and pointer are 64-bit (but `long` and `int` are both 32-bit).  

At one time, some Unix systems used an ILP64 organization.  

None of these de facto standards is legislated by the C standard (ISO/IEC 9899:1999), but all are permitted by it.  

And, by definition, `sizeof(char)` is `1`, notwithstanding the test in the Perl configure script.  

Note that there were machines (Crays) where `CHAR_BIT` was much larger than 8.  That meant, IIRC, that `sizeof(int)` was also 1, because both `char` and `int` were 32-bit.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: Best C++ IDE or Editor for Windows (score [1193943](https://stackoverflow.com/q/89275) in 2009)

#### Question
What is the best C++ IDE or editor for using on Windows? I use Notepad++, but am missing IntelliSense from Visual Studio.  

#### Answer accepted (score 41)
I've found the latest release of NetBeans, which includes C/C++ support, to be excellent.  

<a href="http://www.netbeans.org/features/cpp/index.html" rel="nofollow noreferrer">http://www.netbeans.org/features/cpp/index.html</a>  

#### Answer 2 (score 202)
Um, that's because Visual Studio is the best IDE.  Come back to the darkside.  

#### Answer 3 (score 30)
I personally like Visual Studio combined with a third party add-in such as Visual Assist (<a href="http://www.wholetomato.com/" rel="nofollow noreferrer">http://www.wholetomato.com/</a>). I've tried a few of the others and always ended up back with Visual Studio. Plus, Visual Studio is a widely used product in development industries, so having experience using it can only be a plus.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: Sleep for milliseconds (score [1182180](https://stackoverflow.com/q/4184468) in 2015)

#### Question
I know the POSIX `sleep(x)` function makes the program sleep for x seconds. Is there a function to make the program sleep for x <em>milliseconds</em> in C++?  

#### Answer accepted (score 433)
Note that there is no standard C API for milliseconds, so (on Unix) you will have to settle for `usleep`, which accepts microseconds:  

```c++
#include <unistd.h>

unsigned int microseconds;
...
usleep(microseconds);
```

#### Answer 2 (score 1138)
In C++11, you can do this with standard library facilities:  

```c++
#include <chrono>
#include <thread>
```



```c++
std::this_thread::sleep_for(std::chrono::milliseconds(x));
```

Clear and readable, no more need to guess at what units the `sleep()` function takes.  

#### Answer 3 (score 80)
To stay portable you could use <a href="http://www.boost.org/doc/libs/1_44_0/doc/html/thread.html" rel="noreferrer">Boost::Thread</a> for sleeping:  

```c++
#include <boost/thread/thread.hpp>

int main()
{
    //waits 2 seconds
    boost::this_thread::sleep( boost::posix_time::seconds(1) );
    boost::this_thread::sleep( boost::posix_time::milliseconds(1000) );

    return 0;
}
```

<em>This answer is a duplicate and has been posted in <a href="https://stackoverflow.com/questions/4103707/need-a-better-wait-solution/4103842#4103842">this question</a> before. Perhaps you could find some usable answers there too.</em>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How do you set, clear, and toggle a single bit? (score [1095506](https://stackoverflow.com/q/47981) in 2019)

#### Question
How do you set, clear, and toggle a bit?  

#### Answer accepted (score 3407)
<h5>Setting a bit</h1>

Use the bitwise OR operator (`|`) to set a bit.  

```c++
number |= 1UL << n;
```

That will set the `n`th bit of `number`. `n` should be zero, if you want to set the `1`st bit and so on upto `n-1`, if you want to set the `n`th bit.  

Use `1ULL` if `number` is wider than `unsigned long`; promotion of `1UL &lt;&lt; n` doesn't happen until after evaluating `1UL &lt;&lt; n` where it's undefined behaviour to shift by more than the width of a `long`.  The same applies to all the rest of the examples.  

<h5>Clearing a bit</h1>

Use the bitwise AND operator (`&amp;`) to clear a bit.  

```c++
number &= ~(1UL << n);
```

That will clear the `n`th bit of `number`. You must invert the bit string with the bitwise NOT operator (`~`), then AND it.  

<h5>Toggling a bit</h1>

The XOR operator (`^`) can be used to toggle a bit.  

```c++
number ^= 1UL << n;
```

That will toggle the `n`th bit of `number`.  

<h5>Checking a bit</h1>

You didn't ask for this, but I might as well add it.  

To check a bit, shift the number n to the right, then bitwise AND it:  

```c++
bit = (number >> n) & 1U;
```

That will put the value of the `n`th bit of `number` into the variable `bit`.  

<h5>Changing the <em>n</em>th bit to <em>x</em></h1>

Setting the `n`th bit to either `1` or `0` can be achieved with the following on a 2's complement C++ implementation:  

```c++
number ^= (-x ^ number) & (1UL << n);
```

Bit `n` will be set if `x` is `1`, and cleared if `x` is `0`.  If `x` has some other value, you get garbage.  `x = !!x` will booleanize it to 0 or 1.  

To make this independent of 2's complement negation behaviour (where `-1` has all bits set, unlike on a 1's complement or sign/magnitude C++ implementation), use unsigned negation.  

```c++
number ^= (-(unsigned long)x ^ number) & (1UL << n);
```

or  

```c++
unsigned long newbit = !!x;    // Also booleanize to force 0 or 1
number ^= (-newbit ^ number) & (1UL << n);
```

It's generally a good idea to use unsigned types for portable bit manipulation.  

or  

```c++
number = (number & ~(1UL << n)) | (x << n);
```

`(number &amp; ~(1UL &lt;&lt; n))` will clear the `n`th bit and `(x &lt;&lt; n)` will set the `n`th bit to `x`.  

It's also generally a good idea to not to copy/paste code in general and so many people use preprocessor macros (like <a href="https://stackoverflow.com/a/263738/52074">the community wiki answer further down</a>) or some sort of encapsulation.  

#### Answer 2 (score 438)
Using the Standard C++ Library: <a href="http://en.cppreference.com/w/cpp/utility/bitset" rel="noreferrer">`std::bitset&lt;N&gt;`</a>.  

Or the <a href="http://en.wikipedia.org/wiki/Boost_%28C%2B%2B_libraries%29" rel="noreferrer">Boost</a> version: <a href="http://www.boost.org/doc/libs/release/libs/dynamic_bitset/dynamic_bitset.html" rel="noreferrer">`boost::dynamic_bitset`</a>.  

There is no need to roll your own:  

```c++
#include <bitset>
#include <iostream>

int main()
{
    std::bitset<5> x;

    x[1] = 1;
    x[2] = 0;
    // Note x[0-4]  valid

    std::cout << x << std::endl;
}
```

<hr>

```c++
[Alpha:] > ./a.out
00010
```

The Boost version allows a runtime sized bitset compared with a <a href="https://en.wikipedia.org/wiki/C%2B%2B_Standard_Library" rel="noreferrer">standard library</a> compile-time sized bitset.  

#### Answer 3 (score 234)
The other option is to use bit fields:  

```c++
struct bits {
    unsigned int a:1;
    unsigned int b:1;
    unsigned int c:1;
};

struct bits mybits;
```

defines a 3-bit field (actually, it's three 1-bit felds). Bit operations now become a bit (haha) simpler:  

To set or clear a bit:  

```c++
mybits.b = 1;
mybits.c = 0;
```

To toggle a bit:  

```c++
mybits.a = !mybits.a;
mybits.b = ~mybits.b;
mybits.c ^= 1;  /* all work */
```

Checking a bit:  

```c++
if (mybits.c)  //if mybits.c is non zero the next line below will execute
```

This only works with fixed-size bit fields. Otherwise you have to resort to the bit-twiddling techniques described in previous posts.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How to get current time and date in C++? (score [1051055](https://stackoverflow.com/q/997946) in 2015)

#### Question
Is there a cross-platform way to get the current date and time in C++?  

#### Answer accepted (score 498)
In C++ 11 you can use <a href="http://en.cppreference.com/w/cpp/chrono/system_clock/now" rel="noreferrer">`std::chrono::system_clock::now()`</a>  

Example (copied from <a href="https://en.cppreference.com/w/cpp/chrono" rel="noreferrer">en.cppreference.com</a>):  

```c++
#include <iostream>
#include <chrono>
#include <ctime>    

int main()
{
    auto start = std::chrono::system_clock::now();
    // Some computation here
    auto end = std::chrono::system_clock::now();

    std::chrono::duration<double> elapsed_seconds = end-start;
    std::time_t end_time = std::chrono::system_clock::to_time_t(end);

    std::cout << "finished computation at " << std::ctime(&end_time)
              << "elapsed time: " << elapsed_seconds.count() << "s\n";
}
```

This should print something like this:  

```c++
finished computation at Mon Oct  2 00:59:08 2017
elapsed time: 1.88232s
```

#### Answer 2 (score 463)
C++ shares its date/time functions with C. The <a href="http://en.cppreference.com/w/cpp/chrono/c/tm" rel="noreferrer">tm structure</a> is probably the easiest for a C++ programmer to work with - the following prints today's date:  

```c++
#include <ctime>
#include <iostream>

int main() {
    std::time_t t = std::time(0);   // get time now
    std::tm* now = std::localtime(&t);
    std::cout << (now->tm_year + 1900) << '-' 
         << (now->tm_mon + 1) << '-'
         <<  now->tm_mday
         << "\n";
}
```

#### Answer 3 (score 175)
You can try the following cross-platform code to get current date/time:  

```c++
#include <iostream>
#include <string>
#include <stdio.h>
#include <time.h>

// Get current date/time, format is YYYY-MM-DD.HH:mm:ss
const std::string currentDateTime() {
    time_t     now = time(0);
    struct tm  tstruct;
    char       buf[80];
    tstruct = *localtime(&now);
    // Visit http://en.cppreference.com/w/cpp/chrono/c/strftime
    // for more information about date/time format
    strftime(buf, sizeof(buf), "%Y-%m-%d.%X", &tstruct);

    return buf;
}

int main() {
    std::cout << "currentDateTime()=" << currentDateTime() << std::endl;
    getchar();  // wait for keyboard input
}
```

Output:  

```c++
currentDateTime()=2012-05-06.21:47:59
```

Please visit <a href="http://en.cppreference.com/w/cpp/chrono/c/strftime">here</a> for more information about date/time format  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: C++ IDE for Linux? (score [967131](https://stackoverflow.com/q/24109) in 2017)

#### Question
I want to expand my programming horizons to Linux. A good, dependable basic toolset is important, and what is more basic than an IDE?  

I could find these SO topics:  

<ul>
<li><a href="https://stackoverflow.com/questions/2756/lightweight-ide-for-linux">Lightweight IDE for linux</a> and</li>
<li><a href="https://stackoverflow.com/questions/17228/what-tools-do-you-use-to-develop-c-applications-on-linux">What tools do you use to develop
C++ applications on Linux?</a></li>
</ul>

I'm not looking for a <em>lightweight</em> IDE. If an IDE is worth the money, then I will pay for it, so it need not be free.  

My question, then:  

<blockquote>
  <em>What good, C++ programming IDE is available for Linux?</em>  
</blockquote>

<p>The minimums are fairly standard: syntax highlighting, code completion (like <a href="http://en.wikipedia.org/wiki/IntelliSense" rel="nofollow noreferrer">intellisense</a> or its Eclipse counterpart) and integrated debugging (e.g., basic
breakpoints).</p>

I have searched for it myself, but there are so many that it is almost impossible to separate the good from the bads by hand, especially for someone like me who has little  C++ coding experience in Linux. I know that <a href="http://www.eclipse.org/cdt/" rel="nofollow noreferrer">Eclipse supports C++</a>, and I really like that IDE for Java, but is it any good for C++ and is there something better?  

The second post actually has some good suggestions, but what I am missing is what exactly makes the sugested IDE so good for the user, what are its (dis)advantages?  

Maybe my question should therefore be:  

<blockquote>
  <em>What IDE do you propose (given your experiences), and why?</em>  
</blockquote>

#### Answer accepted (score 261)
<h5>Initially: confusion</h2>

When originally writing this answer, I had recently made the switch from Visual Studio (with years of experience) to Linux and the first thing I did was try to find a reasonable IDE. At the time this was impossible: no good IDE existed.  

<h5>Epiphany: UNIX is an IDE. <em>All of it.</em><sup>1</sup></h2>

And then I realised that the IDE in Linux is the command line with its tools:  

<ul>
<li>First you set up your shell

<ul>
<li>Bash, in my case, but many people prefer</li>
<li><a href="https://fishshell.com/" rel="noreferrer">fish</a> or</li>
<li><a href="https://github.com/robbyrussell/oh-my-zsh" rel="noreferrer">(Oh My) Zsh</a>;</li>
</ul></li>
<li>and your editor; pick your poison — both are state of the art:

<ul>
<li><a href="https://neovim.io/" rel="noreferrer">Neovim</a><sup>2</sup> or</li>
<li><a href="https://www.gnu.org/software/emacs/" rel="noreferrer">Emacs</a>.</li>
</ul></li>
</ul>

Depending on your needs, you will then have to install and configure several plugins to make the editor work nicely (that’s the one annoying part). For example, most programmers on Vim will benefit from the <a href="https://valloric.github.io/YouCompleteMe/" rel="noreferrer">YouCompleteMe</a> plugin for smart autocompletion.  

Once that’s done, the shell is your command interface to interact with the various tools — Debuggers (gdb), Profilers (gprof, valgrind), etc. You set up your project/build environment using <a href="https://www.gnu.org/software/make/" rel="noreferrer">Make</a>, <a href="https://bitbucket.org/snakemake/snakemake/wiki/Home" rel="noreferrer">CMake</a>, <a href="https://bitbucket.org/snakemake/snakemake/wiki/Home" rel="noreferrer">SnakeMake</a> or any of the various alternatives. And you manage your code with a version control system (most people use <a href="https://git-scm.com/" rel="noreferrer">Git</a>). You also use <a href="https://tmux.github.io/" rel="noreferrer">tmux</a> (previously also screen) to multiplex (= think multiple windows/tabs/panels) and persist your terminal session.  

The point is that, thanks to the shell and a few tool writing conventions, these all <em>integrate with each other</em>. And that way <strong>the Linux shell is a truly integrated development environment</strong>, completely on par with other modern IDEs. (This doesn’t mean that individual IDEs don’t have features that the command line may be lacking, but the inverse is also true.)  

<h5>To each their own</h2>

I cannot overstate how well the above workflow functions once you’ve gotten into the habit. But some people simply prefer graphical editors, and in the years since this answer was originally written, Linux has gained a suite of excellent graphical IDEs for several different programming languages (but not, as far as I’m aware, for C++). Do give them a try even if — like me — you end up not using them. Here’s just a small and biased selection:  

<ul>
<li>For Python development, there’s <a href="https://www.jetbrains.com/pycharm/" rel="noreferrer">PyCharm</a></li>
<li>For R, there’s <a href="https://www.rstudio.com/" rel="noreferrer">RStudio</a></li>
<li>For JavaScript and TypeScript, there’s <a href="https://code.visualstudio.com/" rel="noreferrer">Visual Studio Code</a> (which is also a good all-round editor)</li>
<li>And finally, many people love the <a href="https://www.sublimetext.com/" rel="noreferrer">Sublime Text editor</a> for general code editing.</li>
</ul>

Keep in mind that this list is far from complete.  

<hr>

<sup>1</sup> I stole that title from dsm’s comment.  

<sup>2</sup> I used to refer to Vim here. And while plain Vim is still more than capable, Neovim is a promising restart, and it’s modernised a few old warts.  

#### Answer 2 (score 86)
My personal favorite is the <strong>CodeLite 2.x</strong> IDE.  

see: <a href="http://www.codelite.org/" rel="noreferrer" title="codelite website">http://www.codelite.org</a>  

The decision to use CodeLite was based on a research regarding the following C++ IDE for Linux:  

<ul>
<li>Eclipse Galileo with CDT Plugin</li>
<li>NetBeans 6.7 (which is also the base for the SunStudio IDE)</li>
<li>KDevelop4</li>
<li>CodeBlocks 8.02</li>
<li>CodeLite 2.x</li>
</ul>

After all I have decided to use <em>CodeLite 2.x</em>.  

Below I have listed some Pros and Cons regarding the mentioned C++ IDEs. Please note, that this reflects my personal opinion only!  

<strong>EDIT</strong>: what a pity that SOF doesn't support tables, so I have to write in paragraphs ...  

<strong>Eclipse Galileo with CDT Plugin</strong>  

Pros:  

<ul>
<li>reasonable fast</li>
<li>also supports Java, Perl(with E.P.I.C plugin)</li>
<li>commonly used and well maintained</li>
<li>also available for other OS flavours (Windows, MacOS, Solaris, AIX(?))</li>
</ul>

Cons:  

<ul>
<li>GUI is very confusing and somewhat inconsistent - not very intuitive at all</li>
<li>heavy weight</li>
<li>Only supports CVS (AFAIK)</li>
</ul>

<strong>NetBeans 6.7</strong> (note this is also the base for the SunStudio IDE)  

Pros:  

<ul>
<li>one of the most intuitive GUI I have ever seen</li>
<li>also supports Java, Python, Ruby</li>
<li>integrates CVS, SVN, Mercurial</li>
<li>commonly used and well maintained</li>
<li>also available for other OS flavours (Windows, MacOS, Solaris)</li>
</ul>

Cons:  

<ul>
<li>extremly slow</li>
<li>heavy weight</li>
<li>uses Spaces for indentation, which is not the policy at my work. I'm sure this is configurable, but I couldn't find out how to to that</li>
</ul>

<strong>KDevelop4</strong> (note: I did not much testing on it)  

Pros:  

<ul>
<li>commonly used on Linux</li>
<li>integrates CVS, SVN, Mercurial</li>
</ul>

Cons:  

<ul>
<li>the GUI looks somewhat old fashioned</li>
<li>heavy weight</li>
<li>very specific to the KDE environment</li>
</ul>

<strong>CodeBlocks 8.02</strong> (note: I did not much testing on it)  

Pros:  

<ul>
<li>reasonable fast</li>
</ul>

Cons:  

<ul>
<li>the GUI looks somewhat old fashioned (although it has a nice startup screen)</li>
<li>the fonts in the editor are very small</li>
<li>some icons (e.g. the debugger related icons starting/stepping) are very small</li>
<li>no source control integration</li>
</ul>

<strong>CodeLite 2.x</strong> (note: this is my personal favorite)  

Pros:  

<ul>
<li>the best, modern looking and intuitive GUI I have seen on Linux</li>
<li>lightweight</li>
<li>reasonable fast</li>
<li>integrates SVN</li>
<li>also available on other OS flavours(Windows, MacOS, Solaris(?))</li>
</ul>

Cons:  

<ul>
<li>no CVS integration (that's important for me because I have to use it at work)</li>
<li>no support for Java, Perl, Python (would be nice to have)</li>
</ul>

#### Answer 3 (score 75)
<ol>
<li><a href="http://www.codeblocks.org/" rel="noreferrer">Code::Blocks</a> </li>
<li><a href="http://www.eclipse.org/cdt/" rel="noreferrer">Eclipse CDT</a></li>
</ol>

Soon you'll find that IDEs are not enough, and you'll have to learn the GCC toolchain anyway (which isn't hard, at least learning the basic functionality). But no harm in reducing the transitional pain with the IDEs, IMO.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: How to use the PI constant in C++ (score [959136](https://stackoverflow.com/q/1727881) in 2014)

#### Question
I want to use the PI constant and trigonometric functions in some C++ program. I get the trigonometric functions with `include &lt;math.h&gt;`. However, there doesn't seem to be a definition for PI in this header file.  

How can I get PI without defining it manually?  

#### Answer accepted (score 496)
On some (especially older) platforms (see the comments below) you might need to  

```c++
#define _USE_MATH_DEFINES
```

and then include the necessary header file:  

```c++
#include <math.h>
```

and the value of pi can be accessed via:  

```c++
M_PI
```

In my `math.h` (2014) it is defined as:   

```c++
# define M_PI           3.14159265358979323846  /* pi */
```

but check your `math.h` for more. An extract from the "old" `math.h` (in 2009):  

```c++
/* Define _USE_MATH_DEFINES before including math.h to expose these macro
 * definitions for common math constants.  These are placed under an #ifdef
 * since these commonly-defined names are not part of the C/C++ standards.
 */
```

However:  

<ol>
<li><p>on newer platforms (at least on my 64 bit Ubuntu 14.04) I do not need to define the `_USE_MATH_DEFINES` </p></li>
<li><p>On (recent) Linux platforms there are `long double` values too provided as a GNU Extension:</p>

```c++
# define M_PIl          3.141592653589793238462643383279502884L /* pi */
```</li>
</ol>

#### Answer 2 (score 164)
Pi can be calculated as `atan(1)*4`. You could calculate the value this way and cache it.  

#### Answer 3 (score 108)
You could also use boost, which defines important math constants with maximum accuracy for the requested type (i.e. float vs double).    

```c++
const double pi = boost::math::constants::pi<double>();
```

Check out the <a href="http://www.boost.org/doc/libs/1_37_0/libs/math/doc/sf_and_dist/html/math_toolkit/toolkit/internals1/constants.html" rel="noreferrer">boost documentation</a> for more examples.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: Parse (split) a string in C++ using string delimiter (standard C++) (score [952287](https://stackoverflow.com/q/14265581) in 2018)

#### Question
I am parsing a string in C++ using the following:  

```c++
string parsed,input="text to be parsed";
stringstream input_stringstream(input);

if(getline(input_stringstream,parsed,' '))
{
     // do some processing.
}
```

Parsing with a single char delimiter is fine. But what if I want to use a string as delimiter.  

Example: I want to split:  

```c++
scott>=tiger
```

with >= as delimiter so that I can get scott and tiger.     

#### Answer accepted (score 487)
You can use the <a href="http://en.cppreference.com/w/cpp/string/basic_string/find">`std::string::find()`</a> function to find the position of your string delimiter, then use <a href="http://en.cppreference.com/w/cpp/string/basic_string/substr">`std::string::substr()`</a> to get a token.  

Example:  

```c++
std::string s = "scott>=tiger";
std::string delimiter = ">=";
std::string token = s.substr(0, s.find(delimiter)); // token is "scott"
```

<ul>
<li><p>The `find(const string&amp; str, size_t pos = 0)` function returns the position of the first occurrence of `str` in the string, or <a href="http://en.cppreference.com/w/cpp/string/basic_string/npos">`npos`</a> if the string is not found.</p></li>
<li><p>The `substr(size_t pos = 0, size_t n = npos)` function returns a substring of the object, starting at position `pos` and of length `npos`.</p></li>
</ul>

<hr>

If you have multiple delimiters, after you have extracted one token, you can remove it (delimiter included) to proceed with subsequent extractions (if you want to preserve the original string, just use `s = s.substr(pos + delimiter.length());`):  

```c++
s.erase(0, s.find(delimiter) + delimiter.length());
```

This way you can easily loop to get each token.  

<h5> Complete Example </h2>

```c++
std::string s = "scott>=tiger>=mushroom";
std::string delimiter = ">=";

size_t pos = 0;
std::string token;
while ((pos = s.find(delimiter)) != std::string::npos) {
    token = s.substr(0, pos);
    std::cout << token << std::endl;
    s.erase(0, pos + delimiter.length());
}
std::cout << s << std::endl;
```

Output:  

```c++
scott
tiger
mushroom
```

#### Answer 2 (score 53)
This method uses `std::string::find` without mutating the original string by remembering the beginning and end of the previous substring token.  

```c++
#include <iostream>
#include <string>

int main()
{
    std::string s = "scott>=tiger";
    std::string delim = ">=";

    auto start = 0U;
    auto end = s.find(delim);
    while (end != std::string::npos)
    {
        std::cout << s.substr(start, end - start) << std::endl;
        start = end + delim.length();
        end = s.find(delim, start);
    }

    std::cout << s.substr(start, end);
}
```

#### Answer 3 (score 31)
You can use next function to split string:  

```c++
vector<string> split(const string& str, const string& delim)
{
    vector<string> tokens;
    size_t prev = 0, pos = 0;
    do
    {
        pos = str.find(delim, prev);
        if (pos == string::npos) pos = str.length();
        string token = str.substr(prev, pos-prev);
        if (!token.empty()) tokens.push_back(token);
        prev = pos + delim.length();
    }
    while (pos < str.length() && prev < str.length());
    return tokens;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: What is the difference between float and double? (score [936859](https://stackoverflow.com/q/2386772) in 2018)

#### Question
I've read about the difference between double precision and single precision. However, in most cases, `float` and `double` seem to be interchangeable, i.e. using one or the other does not seem to affect the results. Is this really the case? When are floats and doubles interchangeable? What are the differences between them?  

#### Answer accepted (score 466)
Huge difference.  

As the name implies, a <a href="http://en.wikipedia.org/wiki/Double_precision_floating-point_format" rel="noreferrer">`double`</a> has 2x the precision of <a href="http://en.wikipedia.org/wiki/Single_precision_floating-point_format" rel="noreferrer">`float`</a><sup>[1]</sup>. In general a `double` has 15 decimal digits of precision, while `float` has 7.  

Here's how the number of digits are calculated:  

<blockquote>
  `double` has 52 mantissa bits + 1 hidden bit: log(2<sup>53</sup>)÷log(10) = 15.95 digits  
  
  `float` has 23 mantissa bits + 1 hidden bit: log(2<sup>24</sup>)÷log(10) = 7.22 digits  
</blockquote>

This precision loss could lead to greater truncation errors being accumulated when repeated calculations are done, e.g.  

```c++
float a = 1.f / 81;
float b = 0;
for (int i = 0; i < 729; ++ i)
    b += a;
printf("%.7g\n", b); // prints 9.000023
```

while  

```c++
double a = 1.0 / 81;
double b = 0;
for (int i = 0; i < 729; ++ i)
    b += a;
printf("%.15g\n", b); // prints 8.99999999999996
```

Also, the maximum value of float is about `3e38`, but double is about `1.7e308`, so using `float` can hit "infinity" (i.e. a special floating-point number) much more easily than `double` for something simple, e.g. computing the factorial of 60.  

During testing, maybe a few test cases contain these huge numbers, which may cause your programs to fail if you use floats.  

<hr>

Of course, sometimes, even `double` isn't accurate enough, hence we sometimes have `long double`<sup>[1]</sup> (the above example gives 9.000000000000000066 on Mac), but all floating point types suffer from <em>round-off errors</em>, so if precision is very important (e.g. money processing) you should use `int` or a fraction class.  

<hr>

Furthermore, don't use `+=` to sum lots of floating point numbers, as the errors accumulate quickly. If you're using Python, use `fsum`. Otherwise, try to implement the <a href="http://en.wikipedia.org/wiki/Kahan_summation_algorithm" rel="noreferrer">Kahan summation algorithm</a>.  

<hr>

<sup>[1]: The C and C++ standards do not specify the representation of `float`, `double` and `long double`. It is possible that all three are implemented as IEEE double-precision. Nevertheless, for most architectures (gcc, MSVC; x86, x64, ARM) `float` <em>is</em> indeed a IEEE single-precision floating point number (binary32), and `double` <em>is</em> a IEEE double-precision floating point number (binary64).</sup>  

#### Answer 2 (score 54)
Here is what the standard C99 (ISO-IEC 9899 6.2.5 §10) or C++2003 (ISO-IEC 14882-2003 3.1.9 §8) standards say:  

<blockquote>
  There are three floating point types: `float`, `double`, and `long double`. The type `double` provides at least as much precision as `float`, and the type `long double` provides at least as much precision as `double`. The set of values of the type `float` is a subset of the set of values of the type `double`; the set of values of the type `double` is a subset of the set of values of the type `long double`.  
</blockquote>

The C++ standard adds:  

<blockquote>
  The value representation of floating-point types is implementation-defined.  
</blockquote>

I would suggest having a look at the excellent <a href="http://docs.sun.com/source/806-3568/ncg_goldberg.html" rel="noreferrer">What Every Computer Scientist Should Know About Floating-Point Arithmetic</a> that covers the IEEE floating-point standard in depth. You'll learn about the representation details and you'll realize there is a tradeoff between magnitude and precision. The precision of the floating point representation increases as the magnitude decreases, hence floating point numbers between -1 and 1 are those with the most precision.  

#### Answer 3 (score 26)
Given a quadratic equation: <em>x</em><sup>2</sup>&nbsp;&minus;&nbsp;4.0000000&nbsp;<em>x</em>&nbsp;+&nbsp;3.9999999&nbsp;=&nbsp;0, the exact roots to 10 significant digits are, <em>r</em><sub>1</sub>&nbsp;=&nbsp;2.000316228 and <em>r</em><sub>2</sub>&nbsp;=&nbsp;1.999683772.  

Using `float` and `double`, we can write a test program:  

```c++
#include <stdio.h>
#include <math.h>

void dbl_solve(double a, double b, double c)
{
    double d = b*b - 4.0*a*c;
    double sd = sqrt(d);
    double r1 = (-b + sd) / (2.0*a);
    double r2 = (-b - sd) / (2.0*a);
    printf("%.5f\t%.5f\n", r1, r2);
}

void flt_solve(float a, float b, float c)
{
    float d = b*b - 4.0f*a*c;
    float sd = sqrtf(d);
    float r1 = (-b + sd) / (2.0f*a);
    float r2 = (-b - sd) / (2.0f*a);
    printf("%.5f\t%.5f\n", r1, r2);
}   

int main(void)
{
    float fa = 1.0f;
    float fb = -4.0000000f;
    float fc = 3.9999999f;
    double da = 1.0;
    double db = -4.0000000;
    double dc = 3.9999999;
    flt_solve(fa, fb, fc);
    dbl_solve(da, db, dc);
    return 0;
}  
```

Running the program gives me:  

```c++
2.00000 2.00000
2.00032 1.99968
```

Note that the numbers aren't large, but still you get cancellation effects using `float`.  

(In fact, the above is not the best way of solving quadratic equations using either single- or double-precision floating-point numbers, but the answer remains unchanged even if one uses a <a href="http://en.wikipedia.org/wiki/Quadratic_equation#Floating_point_implementation" rel="noreferrer">more stable method</a>.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: What are the differences between a pointer variable and a reference variable in C++? (score [933961](https://stackoverflow.com/q/57483) in 2018)

#### Question
I know references are syntactic sugar, so code is easier to read and write.  

But what are the differences?  

<hr>

Summary from answers and links below:  

<ol>
<li>A pointer can be re-assigned any number of times while a reference cannot be re-assigned after binding.</li>
<li>Pointers can point nowhere (`NULL`), whereas a reference always refers to an object.</li>
<li>You can't take the address of a reference like you can with pointers.</li>
<li>There's no "reference arithmetic" (but you can take the address of an object pointed by a reference and do pointer arithmetic on it as in `&amp;obj + 5`).</li>
</ol>

To clarify a misconception:  

<blockquote>
  <p><em>The C++ standard is very careful to avoid dictating how a compiler may
  implement references, but every C++ compiler implements
  references as pointers. That is, a declaration such as:</em></p>

```c++
int &ri = i;
```
  
  <p><strong><em>if it's not optimized away entirely</em></strong>, <em>allocates the same amount of storage
  as a pointer, and places the address
  of `i` into that storage.</em></p>
</blockquote>

<strong><em>So, a pointer and a reference both use the same amount of memory.</em></strong>  

As a general rule,  

<ul>
<li>Use references in function parameters and return types to provide useful and self-documenting interfaces.</li>
<li>Use pointers for implementing algorithms and data structures.</li>
</ul>

Interesting read:  

<ul>
<li>My all-time favorite <a href="http://yosefk.com/c++fqa/ref.html" rel="noreferrer">C++ FAQ lite</a>.</li>
<li><a href="http://www.embedded.com/electronics-blogs/programming-pointers/4023307/References-vs-Pointers" rel="noreferrer">References vs. Pointers</a>.</li>
<li><a href="http://www.embedded.com/electronics-blogs/programming-pointers/4024641/An-Introduction-to-References" rel="noreferrer">An Introduction to References</a>.</li>
<li><a href="http://www.embedded.com/electronics-blogs/programming-pointers/4023290/References-and-const" rel="noreferrer">References and const</a>.</li>
</ul>

#### Answer 2 (score 1599)
<ol>
<li><p>A pointer can be re-assigned: </p>

```c++
int x = 5;
int y = 6;
int *p;
p = &x;
p = &y;
*p = 10;
assert(x == 5);
assert(y == 10);
```

A reference cannot, and must be assigned at initialization:  

```c++
int x = 5;
int y = 6;
int &r = x;
```</li>
<li><p>A pointer has its own memory address and size on the stack (4 bytes on x86), whereas a reference shares the same memory address (with the original variable) but also takes up some space on the stack.  Since a reference has the same address as the original variable itself, it is safe to think of a reference as another name for the same variable.  Note: What a pointer points to can be on the stack or heap.  Ditto a reference. My claim in this statement is not that a pointer must point to the stack.  A pointer is just a variable that holds a memory address.  This variable is on the stack.  Since a reference has its own space on the stack, and since the address is the same as the variable it references.  More on <a href="https://stackoverflow.com/questions/79923/what-and-where-are-the-stack-and-heap#79936">stack vs heap</a>.  This implies that there is a real address of a reference that the compiler will not tell you. </p>

```c++
int x = 0;
int &r = x;
int *p = &x;
int *p2 = &r;
assert(p == p2);
```</li>
<li><p>You can have pointers to pointers to pointers offering extra levels of indirection.  Whereas references only offer one level of indirection. </p>

```c++
int x = 0;
int y = 0;
int *p = &x;
int *q = &y;
int **pp = &p;
pp = &q;//*pp = q
**pp = 4;
assert(y == 4);
assert(x == 0);
```</li>
<li><p>Pointer can be assigned `nullptr` directly, whereas reference cannot. If you try hard enough, and you know how, you can make the address of a reference `nullptr`.  Likewise, if you try hard enough you can have a reference to a pointer, and then that reference can contain `nullptr`.</p>

```c++
int *p = nullptr;
int &r = nullptr; <--- compiling error
int &r = *p;  <--- likely no compiling error, especially if the nullptr is hidden behind a function call, yet it refers to a non-existent int at address 0
```</li>
<li><p>Pointers can iterate over an array, you can use `++` to go to the next item that a pointer is pointing to, and `+ 4` to go to the 5th element.  This is no matter what size the object is that the pointer points to.</p></li>
<li><p>A pointer needs to be dereferenced with `*` to access the memory location it points to, whereas a reference can be used directly.  A pointer to a class/struct uses `-&gt;` to access it's members whereas a reference uses a `.`.</p></li>
<li><p>A pointer is a variable that holds a memory address.  Regardless of how a reference is implemented, a reference has the same memory address as the item it references.</p></li>
<li><p>References cannot be stuffed into an array, whereas pointers can be (Mentioned by user @litb)</p></li>
<li><p>Const references can be bound to temporaries. Pointers cannot (not without some indirection):</p>

```c++
const int &x = int(12); //legal C++
int *y = &int(12); //illegal to dereference a temporary.
```

This makes `const&amp;` safer for use in argument lists and so forth.  </li>
</ol>

#### Answer 3 (score 357)
<h5>What's a C++ reference (<em>for C programmers</em>)</h1>

A <em>reference</em> can be thought of as a <em>constant pointer</em> (not to be confused with a pointer to a constant value!) with automatic indirection, ie the compiler will apply the `*` operator for you.  

All references must be initialized with a non-null value or compilation will fail. It's neither possible to get the address of a reference - the address operator will return the address of the referenced value instead - nor is it possible to do arithmetics on references.  

C programmers might dislike C++ references as it will no longer be obvious when indirection happens or if an argument gets passed by value or by pointer without looking at function signatures.  

C++ programmers might dislike using pointers as they are considered unsafe - although references aren't really any safer than constant pointers except in the most trivial cases - lack the convenience of automatic indirection and carry a different semantic connotation.  

Consider the following statement from the <a href="https://isocpp.org/wiki/faq/references#overview-refs" rel="noreferrer"><em>C++ FAQ</em></a>:  

<blockquote>
  <p>Even though a reference is often implemented using an address in the
  underlying assembly language, please do <em>not</em> think of a reference as a
  funny looking pointer to an object. A reference <em>is</em> the object. It is
  not a pointer to the object, nor a copy of the object. It <em>is</em> the
  object.</p>
</blockquote>

But if a reference <em>really</em> were the object, how could there be dangling references? In unmanaged languages, it's impossible for references to be any 'safer' than pointers - there generally just isn't a way to reliably alias values across scope boundaries!  

<h5>Why I consider C++ references useful</h1>

Coming from a C background, C++ references may look like a somewhat silly concept, but one should still use them instead of pointers where possible: Automatic indirection <em>is</em> convenient, and references become especially useful when dealing with <a href="https://en.wikipedia.org/wiki/Resource_Acquisition_Is_Initialization" rel="noreferrer">RAII</a> - but not because of any perceived safety advantage, but rather because they make writing idiomatic code less awkward.  

RAII is one of the central concepts of C++, but it interacts non-trivially with copying semantics. Passing objects by reference avoids these issues as no copying is involved. If references were not present in the language, you'd have to use pointers instead, which are more cumbersome to use, thus violating the language design principle that the best-practice solution should be easier than the alternatives.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: How to convert a std::string to const char* or char*? (score [881988](https://stackoverflow.com/q/347949) in 2014)

#### Question
How can I convert an `std::string` to a `char*` or a `const char*`?  

#### Answer accepted (score 1014)
If you just want to pass a <a href="http://en.cppreference.com/w/cpp/string/basic_string" rel="noreferrer">`std::string`</a> to a function that needs `const char*` you can use   

```c++
std::string str;
const char * c = str.c_str();
```

If you want to get a writable copy, like `char *`, you can do that with this:  

```c++
std::string str;
char * writable = new char[str.size() + 1];
std::copy(str.begin(), str.end(), writable);
writable[str.size()] = '\0'; // don't forget the terminating 0

// don't forget to free the string after finished using it
delete[] writable;
```

<strong>Edit</strong>: Notice that the above is not exception safe. If anything between the `new` call and the `delete` call throws, you will leak memory, as nothing will call `delete` for you automatically. There are two immediate ways to solve this.  

<h5>boost::scoped_array</h3>

<a href="http://www.boost.org/doc/libs/release/libs/smart_ptr/scoped_array.htm" rel="noreferrer">`boost::scoped_array`</a> will delete the memory for you upon going out of scope:  

```c++
std::string str;
boost::scoped_array<char> writable(new char[str.size() + 1]);
std::copy(str.begin(), str.end(), writable.get());
writable[str.size()] = '\0'; // don't forget the terminating 0

// get the char* using writable.get()

// memory is automatically freed if the smart pointer goes 
// out of scope
```

<h5>std::vector</h3>

This is the standard way (does not require any external library). You use <a href="http://en.cppreference.com/w/cpp/container/vector" rel="noreferrer">`std::vector`</a>, which completely manages the memory for you.  

```c++
std::string str;
std::vector<char> writable(str.begin(), str.end());
writable.push_back('\0');

// get the char* using &writable[0] or &*writable.begin()
```

#### Answer 2 (score 186)
Given say...  

```c++
std::string x = "hello";
```

<h5> Getting a `char *` or `const char*` from a `string`</h2>

<strong>How to get a character pointer that's valid while `x` remains in scope and isn't modified further</strong>  

<strong>C++11</strong> simplifies things; the following all give access to the same internal string buffer:  

```c++
const char* p_c_str = x.c_str();
const char* p_data  = x.data();
char* p_writable_data = x.data(); // for non-const x from C++17 
const char* p_x0    = &x[0];

      char* p_x0_rw = &x[0];  // compiles iff x is not const...
```

All the above pointers will hold the <em>same value</em> - the address of the first character in the buffer.  Even an empty string has a "first character in the buffer", because C++11 guarantees to always keep an extra NUL/0 terminator character after the explicitly assigned string content (e.g. `std::string("this\0that", 9)` will have a buffer holding `"this\0that\0"`).  

Given any of the above pointers:  

```c++
char c = p[n];   // valid for n <= x.size()
                 // i.e. you can safely read the NUL at p[x.size()]
```

Only for the non-`const` pointer `p_writable_data` and from `&amp;x[0]`:  

```c++
p_writable_data[n] = c;
p_x0_rw[n] = c;  // valid for n <= x.size() - 1
                 // i.e. don't overwrite the implementation maintained NUL
```

Writing a NUL elsewhere in the string does <em>not</em> change the `string`'s `size()`; `string`'s are allowed to contain any number of NULs - they are given no special treatment by `std::string` (same in C++03).  

In <strong>C++03</strong>, things were considerably more complicated (key differences <strong><em>highlighted</em></strong>):  

<ul>
<li><p>`x.data()`</p>

<ul>
<li>returns `const char*` to the string's internal buffer <strong><em>which wasn't required by the Standard to conclude with a NUL</em></strong> (i.e. might be `['h', 'e', 'l', 'l', 'o']` followed by uninitialised or garbage values, with accidental accesses thereto having <em>undefined behaviour</em>).

<ul>
<li>`x.size()` characters are safe to read, i.e. `x[0]` through `x[x.size() - 1]`</li>
<li>for empty strings, you're guaranteed some non-NULL pointer to which 0 can be safely added (hurray!), but you shouldn't dereference that pointer.</li>
</ul></li>
</ul></li>
<li><p>`&amp;x[0]`</p>

<ul>
<li><strong><em>for empty strings this has undefined behaviour</em></strong> (21.3.4)

<ul>
<li>e.g. given `f(const char* p, size_t n) { if (n == 0) return; ...whatever... }` you mustn't call `f(&amp;x[0], x.size());` when `x.empty()` - just use `f(x.data(), ...)`.</li>
</ul></li>
<li>otherwise, as per `x.data()` but:

<ul>
<li>for non-`const` `x` this yields a non-`const` `char*` pointer; you can overwrite string content</li>
</ul></li>
</ul></li>
<li><p>`x.c_str()`</p>

<ul>
<li>returns `const char*` to an ASCIIZ (NUL-terminated) representation of the value (i.e. ['h', 'e', 'l', 'l', 'o', '\0']).</li>
<li>although few if any implementations chose to do so, the C++03 Standard was worded to allow the string implementation the freedom to create a <strong><em>distinct NUL-terminated buffer</em></strong> <em>on the fly</em>, from the potentially non-NUL terminated buffer "exposed" by `x.data()` and `&amp;x[0]`</li>
<li>`x.size()` + 1 characters are safe to read.</li>
<li>guaranteed safe even for empty strings (['\0']).</li>
</ul></li>
</ul>

<h5>Consequences of accessing outside legal indices</h2>

Whichever way you get a pointer, you must not access memory further along from the pointer than the characters guaranteed present in the descriptions above.  Attempts to do so have <em>undefined behaviour</em>, with a very real chance of application crashes and garbage results even for reads, and additionally wholesale data, stack corruption and/or security vulnerabilities for writes.  

<h5>When do those pointers get invalidated?</h2>

If you call some `string` member function that modifies the `string` or reserves further capacity, any pointer values returned beforehand by any of the above methods are <em>invalidated</em>.  You can use those methods again to get another pointer.  (The rules are the same as for iterators into `string`s).  

See also <em>How to get a character pointer valid even after `x` leaves scope or is modified further</em> below....  

<h5>So, which is <em>better</em> to use?</h2>

From C++11, use `.c_str()` for ASCIIZ data, and `.data()` for "binary" data (explained further below).  

In C++03, use `.c_str()` unless certain that `.data()` is adequate, and prefer `.data()` over `&amp;x[0]` as it's safe for empty strings....  

<em>...try to understand the program enough to use `data()` when appropriate, or you'll probably make other mistakes...</em>  

The ASCII NUL '\0' character guaranteed by `.c_str()` is used by many functions as a sentinel value denoting the end of relevant and safe-to-access data.  This applies to both C++-only functions like say `fstream::fstream(const char* filename, ...)` and shared-with-C functions like `strchr()`, and `printf()`.  

Given C++03's `.c_str()`'s guarantees about the returned buffer are a super-set of `.data()`'s, you can always safely use `.c_str()`, but people sometimes don't because:  

<ul>
<li>using `.data()` communicates to other programmers reading the source code that the data is not ASCIIZ (rather, you're using the string to store a block of data (which sometimes isn't even really textual)), or that you're passing it to another function that treats it as a block of "binary" data.  This can be a crucial insight in ensuring that other programmers' code changes continue to handle the data properly.</li>
<li>C++03 only: there's a slight chance that your `string` implementation will need to do some extra memory allocation and/or data copying in order to prepare the NUL terminated buffer</li>
</ul>

As a further hint, if a function's parameters require the (`const`) `char*` but don't insist on getting `x.size()`, the function <em>probably</em> needs an ASCIIZ input, so `.c_str()` is a good choice (the function needs to know where the text terminates somehow, so if it's not a separate parameter it can only be a convention like a length-prefix or sentinel or some fixed expected length).  

<h5>How to get a character pointer valid even after `x` leaves scope or is modified further</h2>

You'll need to <strong><em>copy</em></strong> the contents of the `string` `x` to a new memory area outside `x`.  This external buffer could be in many places such as another `string` or character array variable, it may or may not have a different lifetime than `x` due to being in a different scope (e.g. namespace, global, static, heap, shared memory, memory mapped file).  

To copy the text from `std::string x` into an independent character array:  

```c++
// USING ANOTHER STRING - AUTO MEMORY MANAGEMENT, EXCEPTION SAFE
std::string old_x = x;
// - old_x will not be affected by subsequent modifications to x...
// - you can use `&old_x[0]` to get a writable char* to old_x's textual content
// - you can use resize() to reduce/expand the string
//   - resizing isn't possible from within a function passed only the char* address

std::string old_x = x.c_str(); // old_x will terminate early if x embeds NUL
// Copies ASCIIZ data but could be less efficient as it needs to scan memory to
// find the NUL terminator indicating string length before allocating that amount
// of memory to copy into, or more efficient if it ends up allocating/copying a
// lot less content.
// Example, x == "ab\0cd" -> old_x == "ab".

// USING A VECTOR OF CHAR - AUTO, EXCEPTION SAFE, HINTS AT BINARY CONTENT, GUARANTEED CONTIGUOUS EVEN IN C++03
std::vector<char> old_x(x.data(), x.data() + x.size());       // without the NUL
std::vector<char> old_x(x.c_str(), x.c_str() + x.size() + 1);  // with the NUL

// USING STACK WHERE MAXIMUM SIZE OF x IS KNOWN TO BE COMPILE-TIME CONSTANT "N"
// (a bit dangerous, as "known" things are sometimes wrong and often become wrong)
char y[N + 1];
strcpy(y, x.c_str());

// USING STACK WHERE UNEXPECTEDLY LONG x IS TRUNCATED (e.g. Hello\0->Hel\0)
char y[N + 1];
strncpy(y, x.c_str(), N);  // copy at most N, zero-padding if shorter
y[N] = '\0';               // ensure NUL terminated

// USING THE STACK TO HANDLE x OF UNKNOWN (BUT SANE) LENGTH
char* y = alloca(x.size() + 1);
strcpy(y, x.c_str());

// USING THE STACK TO HANDLE x OF UNKNOWN LENGTH (NON-STANDARD GCC EXTENSION)
char y[x.size() + 1];
strcpy(y, x.c_str());

// USING new/delete HEAP MEMORY, MANUAL DEALLOC, NO INHERENT EXCEPTION SAFETY
char* y = new char[x.size() + 1];
strcpy(y, x.c_str());
//     or as a one-liner: char* y = strcpy(new char[x.size() + 1], x.c_str());
// use y...
delete[] y; // make sure no break, return, throw or branching bypasses this

// USING new/delete HEAP MEMORY, SMART POINTER DEALLOCATION, EXCEPTION SAFE
// see boost shared_array usage in Johannes Schaub's answer

// USING malloc/free HEAP MEMORY, MANUAL DEALLOC, NO INHERENT EXCEPTION SAFETY
char* y = strdup(x.c_str());
// use y...
free(y);
```

<h5>Other reasons to want a `char*` or `const char*` generated from a `string`</h2>

So, above you've seen how to get a (`const`) `char*`, and how to make a copy of the text independent of the original `string`, but what can you <em>do</em> with it?  A random smattering of examples...  

<ul>
<li>give "C" code access to the C++ `string`'s text, as in `printf("x is '%s'", x.c_str());`</li>
<li>copy `x`'s text to a buffer specified by your function's caller (e.g. `strncpy(callers_buffer, callers_buffer_size, x.c_str())`), or volatile memory used for device I/O (e.g. `for (const char* p = x.c_str(); *p; ++p) *p_device = *p;`)</li>
<li>append `x`'s text to an character array already containing some ASCIIZ text (e.g. `strcat(other_buffer, x.c_str())`) - be careful not to overrun the buffer (in many situations you may need to use `strncat`)</li>
<li>return a `const char*` or `char*` from a function (perhaps for historical reasons - client's using your existing API - or for C compatibility you don't want to return a `std::string`, but do want to copy your `string`'s data somewhere for the caller)

<ul>
<li>be careful not to return a pointer that may be dereferenced by the caller after a local `string` variable to which that pointer pointed has left scope</li>
<li>some projects with shared objects compiled/linked for different `std::string` implementations (e.g. STLport and compiler-native) may pass data as ASCIIZ to avoid conflicts</li>
</ul></li>
</ul>

#### Answer 3 (score 33)
Use the `.c_str()` method for `const char *`.  

You can use `&amp;mystring[0]` to get a `char *` pointer, but there are a couple of gotcha's: you won't necessarily get a zero terminated string, and you won't be able to change the string's size. You especially have to be careful not to add characters past the end of the string or you'll get a buffer overrun (and probable crash).  

There was no guarantee that all of the characters would be part of the same contiguous buffer until C++11, but in practice all known implementations of `std::string` worked that way anyway; see <a href="https://stackoverflow.com/questions/1986966/does-s0-point-to-contiguous-characters-in-a-stdstring">Does “&amp;s[0]” point to contiguous characters in a std::string?</a>.  

Note that many `string` member functions will reallocate the internal buffer and invalidate any pointers you might have saved. Best to use them immediately and then discard.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: What are the basic rules and idioms for operator overloading? (score [880173](https://stackoverflow.com/q/4421706) in 2017)

#### Question
Note: The answers were given in <em>a specific order</em>, but since many users sort answers according to votes, rather than the time they were given, here's an <strong><em>index of the answers</em></strong> in the order in which they make most sense:  

<ul>
<li><a href="https://stackoverflow.com/questions/4421706/operator-overloading-in-c/4421715#4421715">The General Syntax of operator overloading in C++</a></li>
<li><a href="https://stackoverflow.com/questions/4421706/operator-overloading-in-c/4421708#4421708">The Three Basic Rules of Operator Overloading in C++</a></li>
<li><a href="https://stackoverflow.com/questions/4421706/operator-overloading-in-c/4421729#4421729">The Decision between Member and Non-member</a></li>
<li><a href="https://stackoverflow.com/questions/4421706/operator-overloading-in-c/4421719#4421719">Common operators to overload</a>

<ul>
<li>Assignment Operator</li>
<li>Input and Output Operators</li>
<li>Function call operator</li>
<li>Comparison operators</li>
<li>Arithmetic Operators</li>
<li>Array Subscripting</li>
<li>Operators for Pointer-like Types</li>
<li><a href="https://stackoverflow.com/questions/4421706/operator-overloading/16615725#16615725">Conversion Operators</a></li>
</ul></li>
<li><a href="https://stackoverflow.com/questions/4421706/operator-overloading-in-c/4421791#4421791">Overloading new and delete</a>                   </li>
</ul>

<p><sub>
<em>(Note: This is meant to be an entry to <a href="https://stackoverflow.com/questions/tagged/c++-faq">Stack Overflow's C++ FAQ</a>. If you want to critique the idea of providing an FAQ in this form, then <a href="https://meta.stackexchange.com/questions/68647/setting-up-a-faq-for-the-c-tag">the posting on meta that started all this</a> would be the place to do that. Answers to that question are monitored in the <a href="http://chat.stackoverflow.com/rooms/10/c-lounge">C++ chatroom</a>, where the FAQ idea started out in the first place, so your answer is very likely to get read by those who came up with the idea.)</em>
</sub>           </p>

#### Answer 2 (score 997)
<h5>Common operators to overload</h1>

Most of the work in overloading operators is boiler-plate code. That is little wonder, since operators are merely syntactic sugar, their actual work could be done by (and often is forwarded to) plain functions. But it is important that you get this boiler-plate code right. If you fail, either your operator’s code won’t compile or your users’ code won’t compile or your users’ code will behave surprisingly.  

<h5>Assignment Operator</h2>

There's a lot to be said about assignment. However, most of it has already been said in <a href="https://stackoverflow.com/questions/3279543/what-is-the-copy-and-swap-idiom">GMan's famous Copy-And-Swap FAQ</a>, so I'll skip most of it here, only listing the perfect assignment operator for reference:  

```c++
X& X::operator=(X rhs)
{
  swap(rhs);
  return *this;
}
```

<h5>Bitshift Operators (used for Stream I/O)</h2>

The bitshift operators `&lt;&lt;` and `&gt;&gt;`, although still used in hardware interfacing for the bit-manipulation functions they inherit from C, have become more prevalent as overloaded stream input and output operators in most applications.  For guidance overloading as bit-manipulation operators, see the section below on Binary Arithmetic Operators.  For implementing your own custom format and parsing logic when your object is used with iostreams, continue.  

<p>The stream operators, among the most commonly overloaded operators, are binary infix operators for which the syntax specifies no restriction on whether they should be members or non-members.
Since they change their left argument (they alter the stream’s state), they should, according to the rules of thumb, be implemented as members of their left operand’s type. However, their left operands are streams from the standard library, and while most of the stream output and input operators defined by the standard library are indeed defined as members of the stream classes, when you implement output and input operations for your own types, you cannot change the standard library’s stream types. That’s why you need to implement these operators for your own types as non-member functions.
The canonical forms of the two are these:</p>

```c++
std::ostream& operator<<(std::ostream& os, const T& obj)
{
  // write obj to stream

  return os;
}

std::istream& operator>>(std::istream& is, T& obj)
{
  // read obj from stream

  if( /* no valid object of T found in stream */ )
    is.setstate(std::ios::failbit);

  return is;
}
```

When implementing `operator&gt;&gt;`, manually setting the stream’s state is only necessary when the reading itself succeeded, but the result is not what would be expected.  

<h5>Function call operator</h2>

The function call operator, used to create function objects, also known as functors, must be defined as a <strong><em>member</em></strong> function, so it always has the implicit `this` argument of member functions. Other than this, it can be overloaded to take any number of additional arguments, including zero.  

Here's an example of the syntax:  

```c++
class foo {
public:
    // Overloaded call operator
    int operator()(const std::string& y) {
        // ...
    }
};
```

Usage:  

```c++
foo f;
int a = f("hello");
```

Throughout the C++ standard library, function objects are always copied. Your own function objects should therefore be cheap to copy. If a function object absolutely needs to use data which is expensive to copy, it is better to store that data elsewhere and have the function object refer to it.  

<h5>Comparison operators</h2>

The binary infix comparison operators should, according to the rules of thumb, be implemented as non-member functions<sup>1</sup>. The unary prefix negation `!` should (according to the same rules) be implemented as a member function. (but it is usually not a good idea to overload it.)  

The standard library’s algorithms (e.g. `std::sort()`) and types (e.g. `std::map`) will always only expect `operator&lt;` to be present. However, the <em>users of your type will expect all the other operators to be present</em>, too, so if you define `operator&lt;`, be sure to follow the third fundamental rule of operator overloading and also define all the other boolean comparison operators. The canonical way to implement them is this:  

```c++
inline bool operator==(const X& lhs, const X& rhs){ /* do actual comparison */ }
inline bool operator!=(const X& lhs, const X& rhs){return !operator==(lhs,rhs);}
inline bool operator< (const X& lhs, const X& rhs){ /* do actual comparison */ }
inline bool operator> (const X& lhs, const X& rhs){return  operator< (rhs,lhs);}
inline bool operator<=(const X& lhs, const X& rhs){return !operator> (lhs,rhs);}
inline bool operator>=(const X& lhs, const X& rhs){return !operator< (lhs,rhs);}
```

The important thing to note here is that only two of these operators actually do anything, the others are just forwarding their arguments to either of these two to do the actual work.  

The syntax for overloading the remaining binary boolean operators (`||`, `&amp;&amp;`) follows the rules of the comparison operators. However, it is <em>very</em> unlikely that you would find a reasonable use case for these<sup>2</sup>.  

<sup>1</sup> <sub>As with all rules of thumb, sometimes there might be reasons to break this one, too. If so, do not forget that the left-hand operand of the binary comparison operators, which for member functions will be `*this`, needs to be `const`, too. So a comparison operator implemented as a member function would have to have this signature:</sub>  

```c++
bool operator<(const X& rhs) const { /* do actual comparison with *this */ }
```

<sub>(Note the `const` at the end.)</sub>  

<sup>2</sup> <sub>It should be noted that the built-in version of `||` and `&amp;&amp;` use shortcut semantics. While the user defined ones (because they are syntactic sugar for method calls) do not use shortcut semantics. User will expect these operators to have shortcut semantics, and their code may depend on it, Therefore it is highly advised NEVER to define them.</sub>  

<h5>Arithmetic Operators</h2>

<h5>Unary arithmetic operators</h3>

<p>The unary increment and decrement operators come in both prefix and postfix flavor. To tell one from the other, the postfix variants take an additional dummy int argument. If you overload increment or decrement, be sure to always implement both prefix and postfix versions.
Here is the canonical implementation of increment, decrement follows the same rules:</p>

```c++
class X {
  X& operator++()
  {
    // do actual increment
    return *this;
  }
  X operator++(int)
  {
    X tmp(*this);
    operator++();
    return tmp;
  }
};
```

Note that the postfix variant is implemented in terms of prefix. Also note that postfix does an extra copy.<sup>2</sup>  

Overloading unary minus and plus is not very common and probably best avoided. If needed, they should probably be overloaded as member functions.   

<sup>2</sup> <sub>Also note that the postfix variant does more work and is therefore less efficient to use than the prefix variant. This is a good reason to generally prefer prefix increment over postfix increment. While compilers can usually optimize away the additional work of postfix increment for built-in types, they might not be able to do the same for user-defined types (which could be something as innocently looking as a list iterator). Once you got used to do `i++`, it becomes very hard to remember to do `++i` instead when `i` is not of a built-in type (plus you'd have to change code when changing a type), so it is better to make a habit of always using prefix increment, unless postfix is explicitly needed.</sub>  

<h5>Binary arithmetic operators</h3>

For the binary arithmetic operators, do not forget to obey the third basic rule operator overloading: If you provide `+`, also provide `+=`, if you provide `-`, do not omit `-=`, etc. Andrew Koenig is said to have been the first to observe that the compound assignment operators can be used as a base for their non-compound counterparts. That is, operator `+` is implemented in terms of `+=`, `-` is implemented in terms of `-=` etc.  

According to our rules of thumb, `+` and its companions should be non-members, while their compound assignment counterparts (`+=` etc.), changing their left argument, should be a member. Here is the exemplary code for `+=` and `+`; the other binary arithmetic operators should be implemented in the same way:  

```c++
class X {
  X& operator+=(const X& rhs)
  {
    // actual addition of rhs to *this
    return *this;
  }
};
inline X operator+(X lhs, const X& rhs)
{
  lhs += rhs;
  return lhs;
}
```

<p>`operator+=` returns its result per reference, while `operator+` returns a copy of its result. Of course, returning a reference is usually more efficient than returning a copy, but in the case of `operator+`, there is no way around the copying. When you write `a + b`, you expect the result to be a new value, which is why `operator+` has to return a new value.<sup>3</sup>
Also note that `operator+` takes its left operand <strong><em>by copy</em></strong> rather than by const reference. The reason for this is the same as the reason giving for `operator=` taking its argument per copy.</p>

The bit manipulation operators `~` `&amp;` `|` `^` `&lt;&lt;` `&gt;&gt;` should be implemented in the same way as the arithmetic operators. However, (except for overloading `&lt;&lt;` and `&gt;&gt;` for output and input) there are very few reasonable use cases for overloading these.  

<sup>3</sup> <sub>Again, the lesson to be taken from this is that `a += b` is, in general, more efficient than `a + b` and should be preferred if possible.</sub>  

<h5>Array Subscripting</h2>

<p>The array subscript operator is a binary operator which must be implemented as a class member. It is used for container-like types that allow access to their data elements by a key.
The canonical form of providing these is this:</p>

```c++
class X {
        value_type& operator[](index_type idx);
  const value_type& operator[](index_type idx) const;
  // ...
};
```

Unless you do not want users of your class to be able to change data elements returned by `operator[]` (in which case you can omit the non-const variant), you should always provide both variants of the operator.  

If value_type is known to refer to a built-in type, the const variant of the operator should better return a copy instead of a const reference:  

```c++
class X {
  value_type& operator[](index_type idx);
  value_type  operator[](index_type idx) const;
  // ...
};
```

<h5>Operators for Pointer-like Types</h2>

For defining your own iterators or smart pointers, you have to overload the unary prefix dereference operator `*` and the binary infix pointer member access operator `-&gt;`:  

```c++
class my_ptr {
        value_type& operator*();
  const value_type& operator*() const;
        value_type* operator->();
  const value_type* operator->() const;
};
```

<p>Note that these, too, will almost always need both a const and a non-const version.
For the `-&gt;` operator, if `value_type` is of `class` (or `struct` or `union`) type, another `operator-&gt;()` is called recursively, until an `operator-&gt;()` returns a value of non-class type.</p>

The unary address-of operator should never be overloaded.  

For `operator-&gt;*()` see <a href="https://stackoverflow.com/q/8777845/140719">this question</a>. It's rarely used and thus rarely ever overloaded. In fact, even iterators do not overload it.  

<hr>

Continue to <a href="https://stackoverflow.com/questions/4421706/operator-overloading/16615725#16615725">Conversion Operators</a>  

#### Answer 3 (score 475)
<h5>The Three Basic Rules of Operator Overloading in C++</h1>

When it comes to operator overloading in C++, there are <strong><em>three basic rules you should follow</em></strong>. As with all such rules, there are indeed exceptions. Sometimes people have deviated from them and the outcome was not bad code, but such positive deviations are few and far between. At the very least, 99 out of 100 such deviations I have seen were unjustified. However, it might just as well have been 999 out of 1000. So you’d better stick to the following rules.   

<ol>
<li><p><strong><em>Whenever the meaning of an operator is not obviously clear and undisputed, it should not be overloaded.</em></strong> <em>Instead, provide a function with a well-chosen name.</em><br>
Basically, the first and foremost rule for overloading operators, at its very heart, says: <em>Don’t do it</em>. That might seem strange, because there is a lot to be known about operator overloading and so a lot of articles, book chapters, and other texts deal with all this. But despite this seemingly obvious evidence, <em>there are only a surprisingly few cases where operator overloading is appropriate</em>. The reason is that actually it is hard to understand the semantics behind the application of an operator unless the use of the operator in the application domain is well known and undisputed. Contrary to popular belief, this is hardly ever the case.  </p></li>
<li><p><strong><em>Always stick to the operator’s well-known semantics.</em></strong><br>
C++ poses no limitations on the semantics of overloaded operators. Your compiler will happily accept code that implements the binary `+` operator to subtract from its right operand. However, the users of such an operator would never suspect the expression `a + b` to subtract `a` from `b`. Of course, this supposes that the semantics of the operator in the application domain is undisputed. </p></li>
<li><p><strong><em>Always provide all out of a set of related operations.</em></strong><br>
<em>Operators are related to each other</em> and to other operations. If your type supports `a + b`, users will expect to be able to call `a += b`, too. If it supports prefix increment `++a`, they will expect `a++` to work as well. If they can check whether `a &lt; b`, they will most certainly expect to also to be able to check whether `a &gt; b`. If they can copy-construct your type, they expect assignment to work as well. </p></li>
</ol>

<hr>

Continue to <a href="https://stackoverflow.com/questions/4421706/operator-overloading-in-c/4421729#4421729">The Decision between Member and Non-member</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: How to find out if an item is present in a std::vector? (score [864239](https://stackoverflow.com/q/571394) in 2017)

#### Question
All I want to do is to check whether an element exists in the vector or not, so I can deal with each case.  

```c++
if ( item_present )
   do_this();
else
   do_that();
```

#### Answer accepted (score 863)
You can use <a href="http://en.cppreference.com/w/cpp/algorithm/find" rel="noreferrer">`std::find`</a> from `&lt;algorithm&gt;`:  

```c++
#include <vector>
vector<int> vec; 
//can have other data types instead of int but must same datatype as item 
std::find(vec.begin(), vec.end(), item) != vec.end()
```

This returns a bool (`true` if present, `false` otherwise).  With your example:  

```c++
#include <algorithm>
#include <vector>

if ( std::find(vec.begin(), vec.end(), item) != vec.end() )
   do_this();
else
   do_that();
```

#### Answer 2 (score 107)
As others have said, use the STL <a href="http://en.cppreference.com/w/cpp/algorithm/find" rel="noreferrer">`find`</a> or <a href="http://en.cppreference.com/w/cpp/algorithm/find" rel="noreferrer">`find_if`</a> functions. But if you are searching in very large vectors and this impacts performance, you may want to sort your vector and then use the <a href="http://en.cppreference.com/w/cpp/algorithm/binary_search" rel="noreferrer">`binary_search`</a>, <a href="http://en.cppreference.com/w/cpp/algorithm/lower_bound" rel="noreferrer">`lower_bound`</a>, or <a href="http://en.cppreference.com/w/cpp/algorithm/upper_bound" rel="noreferrer">`upper_bound`</a> algorithms.  

#### Answer 3 (score 46)
Use find from the algorithm header of stl.I've illustrated its use with int type. You can use any type you like as long as you can compare for equality (overload == if you need to for your custom class).  

```c++
#include <algorithm>
#include <vector>

using namespace std;
int main()
{   
    typedef vector<int> IntContainer;
    typedef IntContainer::iterator IntIterator;

    IntContainer vw;

    //...

    // find 5
    IntIterator i = find(vw.begin(), vw.end(), 5);

    if (i != vw.end()) {
        // found it
    } else {
        // doesn't exist
    }

    return 0;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How do I declare a 2d array in C++ using new? (score [851223](https://stackoverflow.com/q/936687) in 2016)

#### Question
How do i declare a 2d array using new?  

Like, for a "normal" array I would:  

```c++
int* ary = new int[Size]
```

but  

```c++
int** ary = new int[sizeY][sizeX]
```

a) doesn't work/compile and b) doesn't accomplish what:  

```c++
int ary[sizeY][sizeX] 
```

does.  

#### Answer accepted (score 701)
A dynamic 2D array is basically an array of <em>pointers to arrays</em>. You can initialize it using a loop, like this:  

```c++
int** a = new int*[rowCount];
for(int i = 0; i < rowCount; ++i)
    a[i] = new int[colCount];
```

The above, for `colCount= 5` and `rowCount = 4`, would produce the following:  

<img src="https://i.stack.imgur.com/M75kn.png" alt="enter image description here">  

#### Answer 2 (score 290)
```c++
int** ary = new int[sizeY][sizeX]
```

should be:  

```c++
int **ary = new int*[sizeY];
for(int i = 0; i < sizeY; ++i) {
    ary[i] = new int[sizeX];
}
```

and then clean up would be:  

```c++
for(int i = 0; i < sizeY; ++i) {
    delete [] ary[i];
}
delete [] ary;
```

<strong>EDIT:</strong> as Dietrich Epp pointed out in the comments this is not exactly a light weight solution. An alternative approach would be to use one large block of memory:  

```c++
int *ary = new int[sizeX*sizeY];

// ary[i][j] is then rewritten as
ary[i*sizeY+j]
```

#### Answer 3 (score 196)
Although <a href="https://stackoverflow.com/a/936702/358475">this popular answer</a> will give you your desired indexing syntax, it is doubly inefficient: big and slow both in space and time. There's a better way.  

<strong>Why That Answer is Big and Slow</strong>  

The proposed solution is to create a dynamic array of pointers, then initializing each pointer to its own, independent dynamic array. The <strong>advantage</strong> of this approach is that it gives you the indexing syntax you're used to, so if you want to find the value of the matrix at position x,y, you say:  

```c++
int val = matrix[ x ][ y ];
```

This works because matrix[x] returns a pointer to an array, which is then indexed with [y]. Breaking it down:  

```c++
int* row = matrix[ x ];
int  val = row[ y ];
```

Convenient, yes? We like our [ x ][ y ] syntax.   

But the solution has a big <strong>disadvantage</strong>, which is that it is both fat and slow.   

Why?  

The reason that it's both fat and slow is actually the same. Each "row" in the matrix is a separately allocated dynamic array. Making a heap allocation is expensive both in time and space. The allocator takes time to make the allocation, sometimes running O(n) algorithms to do it. And the allocator "pads" each of your row arrays with extra bytes for bookkeeping and alignment. That extra space costs...well...extra space. The deallocator will <em>also</em> take extra time when you go to deallocate the matrix, painstakingly free-ing up each individual row allocation. Gets me in a sweat just thinking about it.  

There's another reason it's slow. These separate allocations tend to live in discontinuous parts of memory. One row may be at address 1,000, another at address 100,000—you get the idea. This means that when you're traversing the matrix, you're leaping through memory like a wild person. This tends to result in cache misses that vastly slow down your processing time.  

So, if you absolute must have your cute [x][y] indexing syntax, use that solution. If you want quickness and smallness (and if you don't care about those, why are you working in C++?), you need a different solution.  

<strong>A Different Solution</strong>  

The better solution is to allocate your whole matrix as a single dynamic array, then use (slightly) clever indexing math of your own to access cells. The indexing math is only very slightly clever; nah, it's not clever at all: it's obvious.  

```c++
class Matrix
{
    ...
    size_t index( int x, int y ) const { return x + m_width * y; }
};
```

Given this `index()` function (which I'm imagining is a member of a class because it needs to know the `m_width` of your matrix), you can access cells within your matrix array. The matrix array is allocated like this:  

```c++
array = new int[ width * height ];
```

So the equivalent of this in the slow, fat solution:  

```c++
array[ x ][ y ]
```

...is this in the quick, small solution:  

```c++
array[ index( x, y )]
```

Sad, I know. But you'll get used to it. And your CPU will thank you.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: usr/bin/ld: cannot find -l<nameOfTheLibrary> (score [838868](https://stackoverflow.com/q/16710047) in 2016)

#### Question
I'm trying to compile my program and it returns this error :  

```c++
usr/bin/ld: cannot find -l<nameOfTheLibrary>
```

in my makefile I use the command `g++` and link to my library which is a symbolic link to my library located on an other directory.  

Is there an option to add to make it work please?  

#### Answer accepted (score 172)
If your library name is say `libxyz.so` and it is located on path say:  

```c++
/home/user/myDir
```

then to link it to your program:  

```c++
g++ -L/home/user/myDir -lxyz myprog.cpp -o myprog
```

#### Answer 2 (score 416)
To figure out what the linker is looking for, run it in verbose mode.    

For example, I encountered this issue while trying to compile MySQL with ZLIB support.  I was receiving an error like this during compilation:  

```c++
/usr/bin/ld: cannot find -lzlib
```

I did some Googl'ing and kept coming across different issues of the same kind where people would say to make sure the .so file actually exists and if it doesn't, then create a symlink to the versioned file, for example, zlib.so.1.2.8.  But, when I checked, zlib.so DID exist.  So, I thought, surely that couldn't be the problem.    

I came across another post on the Internets that suggested to run make with LD_DEBUG=all:  

```c++
LD_DEBUG=all make
```

Although I got a TON of debugging output, it wasn't actually helpful.  It added more confusion than anything else.  So, I was about to give up.  

Then, I had an epiphany.  I thought to actually check the help text for the ld command:  

```c++
ld --help
```

From that, I figured out how to run ld in verbose mode (imagine that):  

```c++
ld -lzlib --verbose
```

This is the output I got:  

```c++
==================================================
attempt to open /usr/x86_64-linux-gnu/lib64/libzlib.so failed
attempt to open /usr/x86_64-linux-gnu/lib64/libzlib.a failed
attempt to open /usr/local/lib64/libzlib.so failed
attempt to open /usr/local/lib64/libzlib.a failed
attempt to open /lib64/libzlib.so failed
attempt to open /lib64/libzlib.a failed
attempt to open /usr/lib64/libzlib.so failed
attempt to open /usr/lib64/libzlib.a failed
attempt to open /usr/x86_64-linux-gnu/lib/libzlib.so failed
attempt to open /usr/x86_64-linux-gnu/lib/libzlib.a failed
attempt to open /usr/local/lib/libzlib.so failed
attempt to open /usr/local/lib/libzlib.a failed
attempt to open /lib/libzlib.so failed
attempt to open /lib/libzlib.a failed
attempt to open /usr/lib/libzlib.so failed
attempt to open /usr/lib/libzlib.a failed
/usr/bin/ld.bfd.real: cannot find -lzlib
```

Ding, ding, ding...  

So, to finally fix it so I could compile MySQL with my own version of ZLIB (rather than the bundled version):  

```c++
sudo ln -s /usr/lib/libz.so.1.2.8 /usr/lib/libzlib.so
```

Voila!  

#### Answer 3 (score 38)
There does not seem to be any answer which addresses the very common beginner problem of failing to install the required library in the first place.  

On Debianish platforms, if `libfoo` is missing, you can frequently install it with something like  

```c++
apt-get install libfoo-dev
```

The `-dev` version of the package is required for development work, even trivial development work such as compiling source code to link to the library.  

The package name will sometimes require some decorations (`libfoo0-dev`?  `foo-dev` without the `lib` prefix? etc), or you can simply use your distro's <a href="https://packages.debian.org/search?searchon=contents&amp;keywords=libfoo.so&amp;mode=exactfilename&amp;suite=stable&amp;arch=any" rel="noreferrer">package search</a> to find out precisely which packages provide a particular file.  

(If there is more than one, you will need to find out what their differences are. Picking the coolest or the most popular is a common shortcut, but not an acceptable procedure for any serious development work.)  

For other architectures (most notably RPM) similar procedures apply, though the details will be different.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: std::string to char* (score [818531](https://stackoverflow.com/q/7352099) in )

#### Question
I want to convert a <strong>std::string</strong> into a <strong>char*</strong> or <strong>char[]</strong> data type.  

```c++
std::string str = "string";
char* chr = str;
```

Results in: <strong>“error: cannot convert ‘std::string’ to ‘char’ ...”</strong>.  

What methods are there available to do this?  

#### Answer accepted (score 611)
It won't automatically convert (thank god). You'll have to use the method `c_str()` to get the C string version.  

```c++
std::string str = "string";
const char *cstr = str.c_str();
```

Note that it returns a `const char *`; you aren't allowed to change the C-style string returned by `c_str()`. If you want to process it you'll have to copy it first:  

```c++
std::string str = "string";
char *cstr = new char[str.length() + 1];
strcpy(cstr, str.c_str());
// do stuff
delete [] cstr;
```

Or in modern C++:  

```c++
std::vector<char> cstr(str.c_str(), str.c_str() + str.size() + 1);
```

#### Answer 2 (score 137)
<a href="https://stackoverflow.com/a/4152881/111307">More details here</a>, and <a href="https://stackoverflow.com/a/10916896/111307">here</a> but you can use   

```c++
string str = "some string" ;
char *cstr = &str[0];
```

#### Answer 3 (score 38)
If I'd need a mutable raw copy of a c++'s string contents, then I'd do this:   

```c++
std::string str = "string";
char* chr = strdup(str.c_str());
```

and later:  

```c++
free(chr); 
```

So why don't I fiddle with std::vector or new[] like anyone else? Because <em>when I need a mutable C-style raw char* string, then because I want to call C code which changes the string and C code deallocates stuff with free() and allocates with malloc() (strdup uses malloc)</em>. So if I pass my raw string to some function X <em>written in C</em> it <em>might</em> have a constraint on it's argument that it has to allocated on the heap (for example if the function might want to call realloc on the parameter). But it is highly unlikely that it would expect an argument allocated with (some user-redefined) new[]!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: How to convert std::string to lower case? (score [810490](https://stackoverflow.com/q/313970) in 2018)

#### Question
I want to convert a `std::string` to lowercase. I am aware of the function `tolower()`, however in the past I have had issues with this function and it is hardly ideal anyway as use with a `std::string` would require iterating over each character.  

Is there an alternative which works 100% of the time?  

#### Answer accepted (score 855)
Adapted from <a href="http://notfaq.wordpress.com/2007/08/04/cc-convert-string-to-upperlower-case/" rel="noreferrer"><em>Not So Frequently Asked Questions</em></a>:  

```c++
#include <algorithm>
#include <cctype>
#include <string>

std::string data = "Abc";
std::transform(data.begin(), data.end(), data.begin(),
    [](unsigned char c){ return std::tolower(c); });
```

You're really not going to get away without iterating through each character. There's no way to know whether the character is lowercase or uppercase otherwise.  

If you really hate <a href="https://en.cppreference.com/w/cpp/string/byte/tolower" rel="noreferrer">`tolower()`</a>, here's a specialized ASCII-only alternative that I don't recommend you use:  

```c++
char asciitolower(char in) {
    if (in <= 'Z' && in >= 'A')
        return in - ('Z' - 'z');
    return in;
}

std::transform(data.begin(), data.end(), data.begin(), asciitolower);
```

Be aware that `tolower()` can only do a per-single-byte-character substitution, which is ill-fitting for many scripts, especially if using a multi-byte-encoding like UTF-8.  

#### Answer 2 (score 299)
<a href="https://www.boost.org/doc/libs/1_70_0/doc/html/boost/algorithm/to_lower.html" rel="nofollow noreferrer">Boost provides a string algorithm for this</a>:  

```c++
#include <boost/algorithm/string.hpp>

std::string str = "HELLO, WORLD!";
boost::algorithm::to_lower(str); // modifies str
```

<a href="https://www.boost.org/doc/libs/1_70_0/doc/html/boost/algorithm/to_lower_copy.html" rel="nofollow noreferrer">Or, for non-in-place</a>:  

```c++
#include <boost/algorithm/string.hpp>

const std::string str = "HELLO, WORLD!";
const std::string lower_str = boost::algorithm::to_lower_copy(str);
```

#### Answer 3 (score 213)
<strong>tl;dr</strong>  

<strong>Use the <a href="http://www.icu-project.org" rel="noreferrer">ICU library</a>.</strong>  

<hr>

First you have to answer a question: What is the <em>encoding</em> of your `std::string`? Is it ISO-8859-1? Or perhaps ISO-8859-8? Or Windows Codepage 1252? <em>Does whatever you're using to convert upper-to-lowercase know that?</em> (Or does it fail miserably for characters over `0x7f`?)  

If you are using UTF-8 (the only sane choice among the 8-bit encodings) with `std::string` as container, you are already deceiving yourself into believing that you are still in control of things, because you are storing a multibyte character sequence in a container that is not aware of the multibyte concept. Even something as simple as `.substr()` is a ticking timebomb. (Because splitting a multibyte sequence will result in an invalid (sub-) string.)  

And as soon as you try something like `std::toupper( 'ß' )`, in <em>any</em> encoding, you are in deep trouble. (Because it's simply not possible to do this "right" with the standard library, which can only deliver <em>one</em> result character, not the `"SS"` needed here.) [1] Another example would be `std::tolower( 'I' )`, which should yield different results <em>depending on the locale</em>. In Germany, `'i'` would be correct; in Turkey, `'ı'` (LATIN SMALL LETTER DOTLESS I) is the expected result (which, again, is more than one byte in UTF-8 encoding).  

Then there is the point that the standard library is depending on which locales are <em>supported</em> on the machine your software is running on... and what do you do if it isn't?  

So what you are <em>really</em> looking for is a string class that is capable of dealing with all this correctly, <strong>and that is <em>not</em> any of the `std::basic_string&lt;&gt;` variants</strong>.  

(C++11 note: `std::u16string` and `std::u32string` are <em>better</em>, but still not perfect. C++20 brought `std::u8string`, but all these do is specify the encoding. In many other respects they still remain ignorant of Unicode mechanics, like normalization, collation, ...)  

While Boost <em>looks</em> nice, API wise, Boost.Locale is basically a wrapper around <a href="http://www.icu-project.org" rel="noreferrer">ICU</a>. <strong>If</strong> Boost is <em>compiled</em> with ICU support... if it isn't, Boost.Locale is limited to the locale support compiled for the standard library.  

And believe me, <em>getting</em> Boost to compile with ICU can be a real pain sometimes. (There are no pre-compiled binaries for Windows, so you'd have to supply them together with your application, and <em>that</em> opens a whole new can of worms...)  

So personally I would recommend getting full Unicode support straight from the horse's mouth and using the <a href="http://www.icu-project.org" rel="noreferrer">ICU</a> library directly:  

```c++
#include <unicode/unistr.h>
#include <unicode/ustream.h>
#include <unicode/locid.h>

#include <iostream>

int main()
{
    char const * someString = "Eidenges\xe4\xdf";
    icu::UnicodeString someUString( someString, "ISO-8859-1" );
    // Setting the locale explicitly here for completeness.
    // Usually you would use the user-specified system locale.
    std::cout << someUString.toLower( "de_DE" ) << "\n";
    std::cout << someUString.toUpper( "de_DE" ) << "\n";
    return 0;
}
```

Compile (with G++ in this example):  

```c++
g++ -Wall example.cpp -licuuc -licuio
```

This gives:  

```c++
eidengesäß
EIDENGESÄSS
```

<hr>

[1] In 2017, the Council for German Orthography ruled that "ẞ" U+1E9E LATIN CAPITAL LETTER SHARP S could be used officially, as an option beside the traditional "SS" conversion to avoid ambiguity e.g. in passports (where names are capitalized). My beautiful go-to example, made obsolete by committee decision...   

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How can I get the list of files in a directory using C or C++? (score [806406](https://stackoverflow.com/q/612097) in 2018)

#### Question
How can I determine the list of files in a directory from inside my C or C++ code?  

I'm not allowed to execute the `ls` command and parse the results from within my program.  

#### Answer accepted (score 749)
In small and simple tasks I do not use boost, I use <strong>dirent.h</strong> which is also available for windows:  

```c++
DIR *dir;
struct dirent *ent;
if ((dir = opendir ("c:\\src\\")) != NULL) {
  /* print all the files and directories within directory */
  while ((ent = readdir (dir)) != NULL) {
    printf ("%s\n", ent->d_name);
  }
  closedir (dir);
} else {
  /* could not open directory */
  perror ("");
  return EXIT_FAILURE;
}
```

It is just a small header file and does most of the simple stuff you need without using a big template-based approach like boost(no offence, I like boost!).  

The author of the windows compatibility layer is Toni Ronkko. In Unix, it is a standard header.  

<strong>UPDATE 2017</strong>:  

In C++17 there is now an official way to list files of your file system: `std::filesystem`. There is an excellent answer from <a href="https://stackoverflow.com/a/37494654/23264"><strong>Shreevardhan</strong></a> below with this source code:  

```c++
#include <string>
#include <iostream>
#include <filesystem>
namespace fs = std::filesystem;

int main()
{
    std::string path = "/path/to/directory";
    for (const auto & entry : fs::directory_iterator(path))
        std::cout << entry.path() << std::endl;
}
```

#### Answer 2 (score 285)
C++17 now has a <a href="http://en.cppreference.com/w/cpp/filesystem/directory_iterator" rel="noreferrer">`std::filesystem::directory_iterator`</a>, which can be used as  

```c++
#include <string>
#include <iostream>
#include <filesystem>
namespace fs = std::filesystem;

int main() {
    std::string path = "/path/to/directory";
    for (const auto & entry : fs::directory_iterator(path))
        std::cout << entry.path() << std::endl;
}
```

Also, <a href="http://en.cppreference.com/w/cpp/filesystem/recursive_directory_iterator" rel="noreferrer">`std::filesystem::recursive_directory_iterator`</a> can iterate the subdirectories as well.  

#### Answer 3 (score 227)
Unfortunately the C++ standard does not define a standard way of working with files and folders in this way.   

Since there is no cross platform way, the best cross platform way is to use a library such as the <a href="http://www.boost.org/doc/libs/1_38_0/libs/filesystem/doc/index.htm" rel="noreferrer">boost filesystem module</a>.  

<strong>Cross platform boost method:</strong>  

<blockquote>
  The following function, given a directory path and a file name, recursively searches the directory and its sub-directories for the file name, returning a bool, and if successful, the path to the file that was found.   

```c++
bool find_file(const path & dir_path,         // in this directory,
               const std::string & file_name, // search for this name,
               path & path_found)             // placing path here if found
{
    if (!exists(dir_path)) 
        return false;

    directory_iterator end_itr; // default construction yields past-the-end

    for (directory_iterator itr(dir_path); itr != end_itr; ++itr)
    {
        if (is_directory(itr->status()))
        {
            if (find_file(itr->path(), file_name, path_found)) 
                return true;
        }
        else if (itr->leaf() == file_name) // see below
        {
            path_found = itr->path();
            return true;
        }
    }
    return false;
}
```
</blockquote>

Source from the boost page mentioned above.  

<strong>For Unix/Linux based systems:</strong>   

You can use <a href="http://www.manpagez.com/man/3/opendir/" rel="noreferrer">opendir</a> / <a href="http://www.manpagez.com/man/3/readdir/" rel="noreferrer">readdir</a> / <a href="http://www.manpagez.com/man/3/closedir/" rel="noreferrer">closedir</a>.   

<blockquote>
  Sample code which searches a directory for entry ``name'' is:  

```c++
len = strlen(name);
dirp = opendir(".");
while ((dp = readdir(dirp)) != NULL)
        if (dp->d_namlen == len && !strcmp(dp->d_name, name)) {
                (void)closedir(dirp);
                return FOUND;
        }
(void)closedir(dirp);
return NOT_FOUND;
```
</blockquote>

Source code from the above man pages.  

<strong>For a windows based systems:</strong>   

You can use the Win32 API <a href="http://msdn.microsoft.com/en-us/library/aa364418(VS.85).aspx" rel="noreferrer">FindFirstFile</a> / <a href="http://msdn.microsoft.com/en-us/library/aa364428(VS.85).aspx" rel="noreferrer">FindNextFile</a> / <a href="http://msdn.microsoft.com/en-us/library/aa364413(VS.85).aspx" rel="noreferrer">FindClose</a> functions.  

<blockquote>
  The following C++ example shows you a minimal use of FindFirstFile.  

```c++
#include <windows.h>
#include <tchar.h>
#include <stdio.h>

void _tmain(int argc, TCHAR *argv[])
{
   WIN32_FIND_DATA FindFileData;
   HANDLE hFind;

   if( argc != 2 )
   {
      _tprintf(TEXT("Usage: %s [target_file]\n"), argv[0]);
      return;
   }

   _tprintf (TEXT("Target file is %s\n"), argv[1]);
   hFind = FindFirstFile(argv[1], &FindFileData);
   if (hFind == INVALID_HANDLE_VALUE) 
   {
      printf ("FindFirstFile failed (%d)\n", GetLastError());
      return;
   } 
   else 
   {
      _tprintf (TEXT("The first file found is %s\n"), 
                FindFileData.cFileName);
      FindClose(hFind);
   }
}
```
</blockquote>

Source code from the above msdn pages.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: What does int argc, char *argv[] mean? (score [798351](https://stackoverflow.com/q/3024197) in 2018)

#### Question
In many C++ IDE's and compilers, when it generates the main function for you, it looks like this:  

```c++
int main(int argc, char *argv[])
```

When I code C++ without an IDE, just with a command line compiler, I type:  

```c++
int main()
```

without any parameters.  What does this mean, and is it vital to my program?  

#### Answer accepted (score 609)
`argv` and `argc` are how command line arguments are passed to `main()` in C and C++.  

`argc` will be the number of strings pointed to by `argv`.  This will (in practice) be 1 plus the number of arguments, as virtually all implementations will prepend the name of the program to the array.  

The variables are named `argc` (<em>argument count</em>) and `argv` (<em>argument vector</em>) by convention, but they can be given any valid identifier: `int main(int num_args, char** arg_strings)` is equally valid.  

They can also be omitted entirely, yielding `int main()`, if you do not intend to process command line arguments.  

Try the following program:  

```c++
#include <iostream>

int main(int argc, char** argv) {
    std::cout << "Have " << argc << " arguments:" << std::endl;
    for (int i = 0; i < argc; ++i) {
        std::cout << argv[i] << std::endl;
    }
}
```

Running it with `./test a1 b2 c3` will output  

```c++
Have 4 arguments:
./test
a1
b2
c3
```

#### Answer 2 (score 50)
`argc` is the number of arguments being passed into your program from the command line and `argv` is the array of arguments.  

You can loop through the arguments knowing the number of them like:  

```c++
for(int i = 0; i < argc; i++)
{
    // argv[i] is the argument at index i
}
```

#### Answer 3 (score 17)
<p>Suppose you run your program thus (using `sh` syntax):


```c++
myprog arg1 arg2 'arg 3'
```

If you declared your main as `int main(int argc, char *argv[])`, then (in most environments), your `main()` will be called as if like:  

```c++
p = { "myprog", "arg1", "arg2", "arg 3", NULL };
exit(main(4, p));
```

However, if you declared your main as `int main()`, it will be called something like  

```c++
exit(main());
```

and you don't get the arguments passed.  

Two additional things to note:  

<ol>
<li>These are the only two standard-mandated signatures for `main`.  If a particular platform accepts extra arguments or a different return type, then that's an extension and should not be relied upon in a portable program.</li>
<li>`*argv[]` and `**argv` are exactly equivalent, so you can write `int main(int argc, char *argv[])` as `int main(int argc, char **argv)`.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: What does the explicit keyword mean? (score [795711](https://stackoverflow.com/q/121162) in 2018)

#### Question
What does the `explicit` keyword mean in C++?  

#### Answer accepted (score 3129)
The compiler is allowed to make one implicit conversion to resolve the parameters to a function. What this means is that the compiler can use constructors callable with a <strong>single parameter</strong> to convert from one type to another in order to get the right type for a parameter.   

Here's an example class with a constructor that can be used for implicit conversions:  

```c++
class Foo
{
public:
  // single parameter constructor, can be used as an implicit conversion
  Foo (int foo) : m_foo (foo) 
  {
  }

  int GetFoo () { return m_foo; }

private:
  int m_foo;
};
```

Here's a simple function that takes a `Foo` object:  

```c++
void DoBar (Foo foo)
{
  int i = foo.GetFoo ();
}
```

and here's where the `DoBar` function is called.  

```c++
int main ()
{
  DoBar (42);
}
```

The argument is not a `Foo` object, but an `int`. However, there exists a constructor for `Foo` that takes an `int` so this constructor can be used to convert the parameter to the correct type.  

The compiler is allowed to do this once for each parameter.  

Prefixing the `explicit` keyword to the constructor prevents the compiler from using that constructor for implicit conversions. Adding it to the above class will create a compiler error at the function call `DoBar (42)`.  It is now necessary to call for conversion explicitly with  `DoBar (Foo (42))`  

The reason you might want to do this is to avoid accidental construction that can hide bugs.  Contrived example:  

<ul>
<li>You have a `MyString(int size)` class with a constructor that constructs a string of the given size.  You have a function `print(const MyString&amp;)`, and you call `print(3)` (when you <em>actually</em> intended to call `print("3")`).  You expect it to print "3", but it prints an empty string of length 3 instead.</li>
</ul>

#### Answer 2 (score 1078)
Suppose, you have a class `String`:  

```c++
class String {
public:
    String(int n); // allocate n bytes to the String object
    String(const char *p); // initializes object with char *p
};
```

Now, if you try:  

```c++
String mystring = 'x';
```

The character `'x'` will be implicitly converted to `int` and then the `String(int)` constructor will be called. But, this is not what the user might have intended. So, to prevent such conditions, we shall define the constructor as `explicit`:  

```c++
class String {
public:
    explicit String (int n); //allocate n bytes
    String(const char *p); // initialize sobject with string p
};
```

#### Answer 3 (score 151)
In C++, a constructor with only one required parameter is considered an implicit conversion function.  It converts the parameter type to the class type.  Whether this is a good thing or not depends on the semantics of the constructor.  

For example, if you have a string class with constructor `String(const char* s)`, that's probably exactly what you want.  You can pass a `const char*` to a function expecting a `String`, and the compiler will automatically construct a temporary `String` object for you.  

On the other hand, if you have a buffer class whose constructor `Buffer(int size)` takes the size of the buffer in bytes, you probably don't want the compiler to quietly turn `int`s into `Buffer`s.  To prevent that, you declare the constructor with the `explicit` keyword:  

```c++
class Buffer { explicit Buffer(int size); ... }
```

That way,  

```c++
void useBuffer(Buffer& buf);
useBuffer(4);
```

becomes a compile-time error.  If you want to pass a temporary `Buffer` object, you have to do so explicitly:  

```c++
useBuffer(Buffer(4));
```

In summary, if your single-parameter constructor converts the parameter into an object of your class, you probably don't want to use the `explicit` keyword.  But if you have a constructor that simply happens to take a single parameter, you should declare it as `explicit` to prevent the compiler from surprising you with unexpected conversions.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: How to convert a char array to a string? (score [781170](https://stackoverflow.com/q/8960087) in 2014)

#### Question
Converting a C++ `string` to a char array is pretty straightorward using the `c_str` function of string and then doing `strcpy`. However, how to do the opposite?  

<p>I have a char array like: `char arr[ ] = "This is a test";` to be converted back to:
`string str = "This is a test`.</p>

#### Answer accepted (score 351)
The `string` class has a constructor that takes a NULL-terminated C-string:  

```c++
char arr[ ] = "This is a test";

string str(arr);


//  You can also assign directly to a string.
str = "This is another string";

// or
str = arr;
```

#### Answer 2 (score 54)
Another solution might look like this,  

```c++
char arr[] = "mom";
std::cout << "hi " << std::string(arr);
```

which avoids using an extra variable.  

#### Answer 3 (score 27)
There is a small problem missed in top-voted answers. Namely, character array may contain 0. If we will use constructor with single parameter as pointed above we will lose some data. The possible solution is:  

```c++
cout << string("123\0 123") << endl;
cout << string("123\0 123", 8) << endl;
```

Output is:  

<blockquote>
  <p>123<br>
  123 123</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: What is the easiest way to initialize a std::vector with hardcoded elements? (score [775328](https://stackoverflow.com/q/2236197) in 2019)

#### Question
I can create an array and initialize it like this:  

```c++
int a[] = {10, 20, 30};
```

How do I create a `std::vector` and initialize it similarly elegant?  

The best way I know is:  

```c++
std::vector<int> ints;

ints.push_back(10);
ints.push_back(20);
ints.push_back(30);
```

Is there a better way?  

#### Answer accepted (score 528)
One method would be to use the array to initialize the vector  

```c++
static const int arr[] = {16,2,77,29};
vector<int> vec (arr, arr + sizeof(arr) / sizeof(arr[0]) );
```

#### Answer 2 (score 602)
If your compiler supports C++11, you can simply do:  

```c++
std::vector<int> v = {1, 2, 3, 4};
```

This is available in GCC <a href="http://gcc.gnu.org/projects/cxx0x.html" rel="noreferrer">as of version 4.4</a>. Unfortunately, VC++ 2010 seems to be lagging behind in this respect.  

Alternatively, the <a href="http://www.boost.org/doc/libs/1_42_0/libs/assign/doc/index.html" rel="noreferrer">Boost.Assign</a> library uses non-macro magic to allow the following:  

```c++
#include <boost/assign/list_of.hpp>
...
std::vector<int> v = boost::assign::list_of(1)(2)(3)(4);
```

Or:  

```c++
#include <boost/assign/std/vector.hpp>
using namespace boost::assign;
...
std::vector<int> v;
v += 1, 2, 3, 4;
```

But keep in mind that this has some overhead (basically, `list_of` constructs a `std::deque` under the hood) so for performance-critical code you'd be better off doing as Yacoby says.  

#### Answer 3 (score 83)
If you can, use the modern C++[11,14,17,...] way:  

```c++
std::vector<int> vec = {10,20,30};
```

The old way of looping over a variable-length array or using `sizeof()` is truly terrible on the eyes and completely unnecessary in terms of mental overhead. Yuck.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: Why is "using namespace std;" considered bad practice? (score [770478](https://stackoverflow.com/q/1452721) in 2019)

#### Question
I've been told by others that writing `using namespace std;` in code is wrong, and that I should use `std::cout` and `std::cin` directly instead.  

Why is `using namespace std;` considered a bad practice? Is it inefficient or does it risk declaring ambiguous variables (variables that share the same name as a function in `std` namespace)? Does it impact performance?  

#### Answer accepted (score 2068)
This is not related to performance at all. But consider this: you are using two libraries called Foo and Bar:  

```c++
using namespace foo;
using namespace bar;
```

Everything works fine, and you can call `Blah()` from Foo and `Quux()` from Bar without problems. But one day you upgrade to a new version of Foo 2.0, which now offers a function called `Quux()`. Now you've got a conflict: Both Foo 2.0 and Bar import `Quux()` into your global namespace. This is going to take some effort to fix, especially if the function parameters happen to match.  

If you had used `foo::Blah()` and `bar::Quux()`, then the introduction of `foo::Quux()` would have been a non-event.  

#### Answer 2 (score 1318)
I agree with everything <a href="https://stackoverflow.com/questions/1452721/1452738#1452738">Greg wrote</a>, but I'd like to add: <strong><em>It can even get worse than Greg said!</em></strong>  

Library Foo 2.0 could introduce a function, `Quux()`, that is an unambiguously better match for some of your calls to `Quux()` than the `bar::Quux()` your code called for years. Then your <strong><em>code still compiles</em></strong>, but <strong><em>it silently calls the wrong function</em></strong> and does god-knows-what. That's about as bad as things can get.  

Keep in mind that the `std` namespace has tons of identifiers, many of which are <em>very</em> common ones (think `list`, `sort`, `string`, `iterator`, etc.) which are very likely to appear in other code, too.  

<p>If you consider this unlikely: There was <a href="https://stackoverflow.com/a/2712125/140719">a question asked</a> here on Stack Overflow where pretty much exactly this happened (wrong function called due to omitted `std::` prefix) about half a year after I gave this answer. <a href="https://stackoverflow.com/questions/13402789/">Here</a> is another, more recent example of such a question.
So this is a real problem.</p>

<hr>

Here's one more data point: Many, many years ago, I also used to find it annoying having to prefix everything from the standard library with `std::`. Then I worked in a project where it was decided at the start that both `using` directives and declarations are banned except for function scopes. Guess what? It took most of us very few weeks to get used to writing the prefix, and after a few more weeks most of us even agreed that it actually made the code <em>more readable</em>. There's a reason for that: <strong><em>Whether you like shorter or longer prose is subjective, but the prefixes objectively add clarity to the code.</em></strong> Not only the compiler, but you, too, find it easier to see which identifier is referred to.  

In a decade, that project grew to have several million lines of code. Since these discussions come up again and again, I once was curious how often the (allowed) function-scope `using` actually was used in the project. I grep'd the sources for it and only found one or two dozen places where it was used. To me this indicates that, once tried, developers don't find `std::` painful enough to employ using directives even once every 100 kLoC even where it was allowed to be used.  

<hr>

Bottom line: Explicitly prefixing everything doesn't do any harm, takes very little getting used to, and has objective advantages. In particular, it makes the code easier to interpret by the compiler and by human readers — and that should probably be the main goal when writing code.  

#### Answer 3 (score 383)
The problem with putting `using namespace` in the header files of your classes is that it forces anyone who wants to use your classes (by including your header files) to also be 'using' (i.e. seeing everything in) those other namespaces.  

However, you may feel free to put a using statement in your (private) *.cpp files.  

<hr>

Beware that some people disagree with my saying "feel free" like this -- because although a using statement in a cpp file is <em>better</em> than in a header (because it doesn't affect people who include your header file), they think it's still not <em>good</em> (because depending on the code it could make the implementation of the class more difficult to maintain). <a href="https://isocpp.org/wiki/faq/coding-standards#using-namespace-std" rel="noreferrer">This FAQ topic</a> says,  

<blockquote>
  The using-directive exists for legacy C++ code and to ease the transition to namespaces, but you probably shouldn’t use it on a regular basis, at least not in your new C++ code.  
</blockquote>

The FAQ suggests two alternatives:  

<ul>
<li><p>A using-declaration:</p>

```c++
using std::cout; // a using-declaration lets you use cout without qualification
cout << "Values:";
```</li>
<li><p>Just typing std::</p>

```c++
std::cout << "Values:";
```</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: std::string formatting like sprintf (score [756090](https://stackoverflow.com/q/2342162) in 2015)

#### Question
I have to format <a href="http://en.cppreference.com/w/cpp/string/basic_string">`std::string`</a> with <a href="http://en.cppreference.com/w/cpp/io/c/fprintf">`sprintf`</a> and send it into file stream. How can I do this?  

#### Answer accepted (score 300)
You can't do it directly, because you don't have write access to the underlying buffer (until C++11; see Dietrich Epp's <a href="https://stackoverflow.com/questions/2342162/stdstring-formatting-like-sprintf#comment61134428_2342176">comment</a>). You'll have to do it first in a c-string, then copy it into a std::string:  

```c++
  char buff[100];
  snprintf(buff, sizeof(buff), "%s", "Hello");
  std::string buffAsStdStr = buff;
```

But I'm not sure why you wouldn't just use a string stream? I'm assuming you have specific reasons to not just do this:  

```c++
  std::ostringstream stringStream;
  stringStream << "Hello";
  std::string copyOfStr = stringStream.str();
```

#### Answer 2 (score 239)
C++11 solution that uses `vsnprintf()` internally:  

```c++
#include <stdarg.h>  // For va_start, etc.

std::string string_format(const std::string fmt, ...) {
    int size = ((int)fmt.size()) * 2 + 50;   // Use a rubric appropriate for your code
    std::string str;
    va_list ap;
    while (1) {     // Maximum two passes on a POSIX system...
        str.resize(size);
        va_start(ap, fmt);
        int n = vsnprintf((char *)str.data(), size, fmt.c_str(), ap);
        va_end(ap);
        if (n > -1 && n < size) {  // Everything worked
            str.resize(n);
            return str;
        }
        if (n > -1)  // Needed size returned
            size = n + 1;   // For null char
        else
            size *= 2;      // Guess at a larger size (OS specific)
    }
    return str;
}
```

A safer and more efficient (I tested it, and it is faster) approach:  

```c++
#include <stdarg.h>  // For va_start, etc.
#include <memory>    // For std::unique_ptr

std::string string_format(const std::string fmt_str, ...) {
    int final_n, n = ((int)fmt_str.size()) * 2; /* Reserve two times as much as the length of the fmt_str */
    std::unique_ptr<char[]> formatted;
    va_list ap;
    while(1) {
        formatted.reset(new char[n]); /* Wrap the plain char array into the unique_ptr */
        strcpy(&formatted[0], fmt_str.c_str());
        va_start(ap, fmt_str);
        final_n = vsnprintf(&formatted[0], n, fmt_str.c_str(), ap);
        va_end(ap);
        if (final_n < 0 || final_n >= n)
            n += abs(final_n - n + 1);
        else
            break;
    }
    return std::string(formatted.get());
}
```

The `fmt_str` is passed by value to conform with the requirements of `va_start`.  

NOTE: The "safer" and "faster" version doesn't work on some systems. Hence both are still listed. Also, "faster" depends entirely on the preallocation step being correct, otherwise the `strcpy` renders it slower.  

#### Answer 3 (score 208)
Utilising <a href="http://en.wikipedia.org/wiki/C%2B%2B11" rel="noreferrer">C++11</a> <a href="http://en.cppreference.com/w/cpp/io/c/fprintf" rel="noreferrer">`std::snprintf`</a>, this becomes a pretty easy and safe task. I see a lot of answers on this question that were apparently written before the time of C++11 which use fixed buffer lengths and vargs, something I would not recommend for safety, efficiency and clarity reasons.  

```c++
#include <memory>
#include <iostream>
#include <string>
#include <cstdio>

template<typename ... Args>
std::string string_format( const std::string& format, Args ... args )
{
    size_t size = snprintf( nullptr, 0, format.c_str(), args ... ) + 1; // Extra space for '\0'
    std::unique_ptr<char[]> buf( new char[ size ] ); 
    snprintf( buf.get(), size, format.c_str(), args ... );
    return std::string( buf.get(), buf.get() + size - 1 ); // We don't want the '\0' inside
}
```

<em>The code snippet above is licensed under <a href="https://creativecommons.org/publicdomain/zero/1.0/" rel="noreferrer">CC0 1.0</a>.</em>  

<h5>Line by line explanation:</h2>

<strong><em>Aim:</em></strong> Write to a `char*` by using  `std::snprintf` and then convert that to a `std::string`.  

First, we determine the desired length of the char array.  

From <a href="http://en.cppreference.com/w/cpp/io/c/fprintf" rel="noreferrer">cppreference.com</a>:  

<blockquote>
  <strong>Return value</strong>  
  
  <p>[...] If the resulting string gets truncated due to buf_size limit,
  function returns the total number of characters (not including the
  terminating null-byte) which would have been written, if the limit was
  not imposed.</p>
</blockquote>

This means that the desired size is the number of characters <strong>plus one</strong>, so that the null-terminator will sit after all other characters and that it can be cut off by the string constructor again. This issue was explained by @alexk7 in the comments.  

Then, we allocate a new character array and assign it to a `std::unique_ptr`. This is generally advised, as you won't have to manually `delete` it again.  

<em>Note that this is not a safe way to allocate a `unique_ptr` with user-defined types as you can not deallocate the memory if the constructor throws an exception!</em>  

After that, we can of course just use `snprintf` for its intended use and write the formatted string to the `char[]` and afterwards create and return a new `std::string` from that.  

<hr>

You can see an example in action <a href="http://ideone.com/av9b8p" rel="noreferrer">here</a>.  

<hr>

If you also want to use `std::string` in the argument list, take a look at <a href="http://gist.github.com/Zitrax/a2e0040d301bf4b8ef8101c0b1e3f1d5" rel="noreferrer">this gist</a>.   

<hr>

Additional information for <a href="http://en.wikipedia.org/wiki/Microsoft_Visual_Studio" rel="noreferrer">Visual Studio</a> users:  

<p>As explained in <a href="https://stackoverflow.com/a/9052232/2533467">this answer</a>, Microsoft renamed `std::snprintf` to `_snprintf` (yes, without `std::`). MS further set it as deprecated and advises to use <a href="http://msdn.microsoft.com/en-US/library/f30dzcf6(v=vs.80).aspx" rel="noreferrer">`_snprintf_s`</a> instead, however `_snprintf_s` won't accept the buffer to be zero or smaller than the formatted output and will not calculate the outputs length if that occurs. 
So in order to get rid of the deprecation warnings during compilation, you can insert <a href="http://msdn.microsoft.com/en-us/library/vstudio/2c8f766e(v=vs.120).aspx" rel="noreferrer">the following line</a> at the top of the file which contains the use of `_snprintf`:</p>

```c++
#pragma warning(disable : 4996)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: What are the rules for calling the superclass constructor? (score [750052](https://stackoverflow.com/q/120876) in 2017)

#### Question
What are the C++ rules for calling the superclass constructor from a subclass one?  

For example, I know in Java, you must do it as the first line of the subclass constructor (and if you don't, an implicit call to a no-arg super constructor is assumed - giving you a compile error if that's missing).  

#### Answer accepted (score 878)
Base class constructors are automatically called for you if they have no argument.  If you want to call a superclass constructor with an argument, you must use the subclass's constructor initialization list.  Unlike Java, C++ supports multiple inheritance (for better or worse), so the base class must be referred to by name, rather than "super()".  

```c++
class SuperClass
{
    public:

        SuperClass(int foo)
        {
            // do something with foo
        }
};

class SubClass : public SuperClass
{
    public:

        SubClass(int foo, int bar)
        : SuperClass(foo)    // Call the superclass constructor in the subclass' initialization list.
        {
            // do something with bar
        }
};
```

More info on the constructor's initialization list <a href="http://www.cprogramming.com/tutorial/initialization-lists-c++.html" rel="noreferrer">here</a> and <a href="http://www.parashift.com/c++-faq-lite/ctors.html#faq-10.6" rel="noreferrer">here</a>.  

#### Answer 2 (score 224)
In C++, the no-argument constructors for all superclasses and member variables are called for you, before entering your constructor. If you want to pass them arguments, there is a separate syntax for this called "constructor chaining", which looks like this:  

```c++
class Sub : public Base
{
  Sub(int x, int y)
  : Base(x), member(y)
  {
  }
  Type member;
};
```

If anything run at this point throws, the bases/members which had previously completed construction have their destructors called and the exception is rethrown to to the caller. If you want to catch exceptions during chaining, you must use a function try block:  

```c++
class Sub : public Base
{
  Sub(int x, int y)
  try : Base(x), member(y)
  {
    // function body goes here
  } catch(const ExceptionType &e) {
    throw kaboom();
  }
  Type member;
};
```

In this form, note that the try block <strong>is</strong> the body of the function, rather than being inside the body of the function; this allows it to catch exceptions thrown by implicit or explicit member and base class initializations, as well as during the body of the function. However, if a function catch block does not throw a different exception, the runtime will rethrow the original error; exceptions during initialization <strong>cannot</strong> be ignored.  

#### Answer 3 (score 51)
In C++ there is a concept of constructor's initialization list, which is where you can and should call the base class' constructor and where you should also initialize the data members.  The initialization list comes after the constructor signature following a colon, and before the body of the constructor.  Let's say we have a class A:  

```c++

class A : public B
{
public:
  A(int a, int b, int c);
private:
  int b_, c_;
};
```

Then, assuming B has a constructor which takes an int, A's constructor may look like this:  

```c++

A::A(int a, int b, int c) 
  : B(a), b_(b), c_(c) // initialization list
{
  // do something
}
```

As you can see, the constructor of the base class is called in the initialization list.  Initializing the data members in the initialization list, by the way, is preferable to assigning the values for b_, and c_ inside the body of the constructor, because you are saving the extra cost of assignment.  

Keep in mind, that data members are always initialized in the order in which they are declared in the class definition, regardless of their order in the initialization list.  To avoid strange bugs, which may arise if your data members depend on each other, you should always make sure that the order of the members is the same in the initialization list and the class definition.  For the same reason the base class constructor must be the first item in the initialization list.  If you omit it altogether, then the default constructor for the base class will be called automatically.  In that case, if the base class does not have a default constructor, you will get a compiler error.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: What is the "-->" operator in C++? (score [738032](https://stackoverflow.com/q/1642028) in 2019)

#### Question
After reading <a href="http://groups.google.com/group/comp.lang.c++.moderated/msg/33f173780d58dd20" rel="noreferrer">Hidden Features and Dark Corners of C++/STL</a> on `comp.lang.c++.moderated`, I was completely surprised that the following snippet compiled and worked in both Visual Studio 2008 and G++ 4.4.  

Here's the code:  

```c++
#include <stdio.h>
int main()
{
    int x = 10;
    while (x --> 0) // x goes to 0
    {
        printf("%d ", x);
    }
}
```

I'd assume this is C, since it works in GCC as well. Where is this defined in the standard, and where has it come from?  

#### Answer accepted (score 8191)
`--&gt;` is not an operator. It is in fact two separate operators, `--` and `&gt;`.  

The conditional's code decrements `x`, while returning `x`'s original (not decremented) value, and then compares the original value with `0` using the `&gt;` operator.  

<strong>To better understand, the statement could be written as follows:</strong>  

```c++
while( (x--) > 0 )
```

#### Answer 2 (score 2868)
Or for something completely different... x slides to 0  

```c++
while (x --\
            \
             \
              \
               > 0)
     printf("%d ", x);
```

Not so mathematical, but... every picture paints a thousand words...  

#### Answer 3 (score 2318)
That's a very complicated operator, so even <a href="https://isocpp.org/std/the-committee" rel="nofollow noreferrer">ISO/IEC JTC1 (Joint Technical Committee 1)</a> placed its description in two different parts of the C++ Standard.  

Joking aside, they are two different operators: `--` and `&gt;` described respectively in &sect;5.2.6/2 and &sect;5.9 of the C++03 Standard.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: Iteration over std::vector: unsigned vs signed index variable (score [737570](https://stackoverflow.com/q/409348) in 2016)

#### Question
What is the correct way of iterating over a vector in C++?  

Consider these two code fragments, this one works fine:  

```c++
for (unsigned i=0; i < polygon.size(); i++) {
    sum += polygon[i];
}
```

and this one:  

```c++
for (int i=0; i < polygon.size(); i++) {
    sum += polygon[i];
}
```

which generates `warning: comparison between signed and unsigned integer expressions`.  

I'm new in the world of C++, so the `unsigned` variable looks a bit frightening to me and I know `unsigned` variables can be dangerous if not used correctly, so - is this correct?  

#### Answer accepted (score 772)
<h5>Iterating Backwards</h1>

See <a href="https://stackoverflow.com/questions/275994/whats-the-best-way-to-do-a-backwards-loop-in-c-c-c#276053">this answer</a>.   

<h5>Iterating Forwards</h1>

This is almost identical. Just change the iterators / swap decrement by increment. You should prefer iterators. Some people tell you to use `std::size_t` as the index variable type. However, that is not portable. Always use the `size_type` typedef of the container (While you could get away with only a conversion in the forward iterating case, it could actually go wrong all the way in the backward iterating case when using `std::size_t`, in case `std::size_t` is wider than what is the typedef of `size_type`):  

<h5>Using std::vector</h2>

<h5>Using iterators</h3>

```c++
for(std::vector<T>::iterator it = v.begin(); it != v.end(); ++it) {
    /* std::cout << *it; ... */
}
```

Important is, always use the prefix increment form for iterators whose definitions you don't know. That will ensure your code runs as generic as possible.   

<h5>Using Range C++11</h3>

```c++
for(auto const& value: a) {
     /* std::cout << value; ... */
```

<h5>Using indices</h3>

```c++
for(std::vector<int>::size_type i = 0; i != v.size(); i++) {
    /* std::cout << v[i]; ... */
}
```

<h5>Using arrays</h2>

<h5>Using iterators</h3>

```c++
for(element_type* it = a; it != (a + (sizeof a / sizeof *a)); it++) {
    /* std::cout << *it; ... */
}
```

<h5>Using Range C++11</h3>

```c++
for(auto const& value: a) {
     /* std::cout << value; ... */
```

<h5>Using indices</h3>

```c++
for(std::size_t i = 0; i != (sizeof a / sizeof *a); i++) {
    /* std::cout << a[i]; ... */
}
```

Read in the backward iterating answer what problem the `sizeof` approach can yield to, though.  

#### Answer 2 (score 163)
Four years passed, <em>Google</em> gave me this answer. With the <a href="http://en.wikipedia.org/wiki/C++11">standard <em>C++11</em></a> (aka <em>C++0x</em>) there is actually a new pleasant way of doing this (at the price of breaking backward compatibility): the new `auto` keyword. It saves you the pain of having to explicitly specify the type of the iterator to use (repeating the vector type again), when it is obvious (to the compiler), which type to use. With `v` being your `vector`, you can do something like this:  

```c++
for ( auto i = v.begin(); i != v.end(); i++ ) {
    std::cout << *i << std::endl;
}
```

<em>C++11</em> goes even further and gives you a special syntax for iterating over collections like vectors. It removes the necessity of writing things that are always the same:  

```c++
for ( auto &i : v ) {
    std::cout << i << std::endl;
}
```

To see it in a working program, build a file `auto.cpp`:  

```c++
#include <vector>
#include <iostream>

int main(void) {
    std::vector<int> v = std::vector<int>();
    v.push_back(17);
    v.push_back(12);
    v.push_back(23);
    v.push_back(42);
    for ( auto &i : v ) {
        std::cout << i << std::endl;
    }
    return 0;
}
```

As of writing this, when you compile this with <em>g++</em>, you normally need to set it to work with the new standard by giving an extra flag:  

```c++
g++ -std=c++0x -o auto auto.cpp
```

Now you can run the example:  

```c++
$ ./auto
17
12
23
42
```

<em>Please note</em> that the instructions on compiling and running are specific to <em>gnu c++</em> compiler on <em>Linux</em>, the program should be platform (and compiler) independent.  

#### Answer 3 (score 44)
In the specific case in your example, I'd use the STL algorithms to accomplish this.   

```c++
#include <numeric> 

sum = std::accumulate( polygon.begin(), polygon.end(), 0 );
```

For a more general, but still fairly simple case, I'd go with:  

```c++
#include <boost/lambda/lambda.hpp>
#include <boost/lambda/bind.hpp>

using namespace boost::lambda;
std::for_each( polygon.begin(), polygon.end(), sum += _1 );
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: Return array in a function (score [715453](https://stackoverflow.com/q/3473438) in 2014)

#### Question
I have an array `int arr[5]` that is passed to a function `fillarr(int arr[])`:  

```c++
int fillarr(int arr[])
{
    for(...);
    return arr;
}
```

<ol>
<li>How can I return that array?</li>
<li>How will I use it, say I returned a pointer how am I going to access it?</li>
</ol>

#### Answer accepted (score 174)
In this case, your array variable `arr` can actually also be treated as a pointer to the beginning of your array's block in memory, by an implicit conversion.  This syntax that you're using:  

```c++
int fillarr(int arr[])
```

Is kind of just syntactic sugar.  You could really replace it with this and it would still work:  

```c++
int fillarr(int* arr)
```

So in the same sense, what you want to return from your function is actually a pointer to the first element in the array:  

```c++
int* fillarr(int arr[])
```

And you'll still be able to use it just like you would a normal array:  

```c++
int main()
{
  int y[10];
  int *a = fillarr(y);
  cout << a[0] << endl;
}
```

#### Answer 2 (score 100)
C++ functions can't return C-style arrays by value. The closest thing is to return a pointer. Furthermore, an array type in the argument list is simply converted to a pointer.  

```c++
int *fillarr( int arr[] ) { // arr "decays" to type int *
    return arr;
}
```

You can improve it by using an array references for the argument and return, which prevents the decay:  

```c++
int ( &fillarr( int (&arr)[5] ) )[5] { // no decay; argument must be size 5
    return arr;
}
```

With Boost or C++11, pass-by-reference is only optional and the syntax is less mind-bending:  

```c++
array< int, 5 > &fillarr( array< int, 5 > &arr ) {
    return arr; // "array" being boost::array or std::array
}
```

The `array` template simply generates a `struct` containing a C-style array, so you can apply object-oriented semantics yet retain the array's original simplicity.  

#### Answer 3 (score 19)
$8.3.5/8 states-  

"Functions shall not have a return type of type array or function, although they may have a return type of type pointer or reference to such things. There shall be no arrays of functions, although there can be arrays of pointers to functions."  

```c++
int (&fn1(int (&arr)[5]))[5]{     // declare fn1 as returning refernce to array
   return arr;
}

int *fn2(int arr[]){              // declare fn2 as returning pointer to array
   return arr;
}


int main(){
   int buf[5];
   fn1(buf);
   fn2(buf);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: What is the effect of extern "C" in C++? (score [709916](https://stackoverflow.com/q/1041866) in 2018)

#### Question
What exactly does putting `extern "C"` into C++ code do?  

For example:  

```c++
extern "C" {
   void foo();
}
```

#### Answer accepted (score 1442)
extern "C" makes a function-name in C++ have 'C' linkage (compiler does not mangle the name) so that client C code can link to (i.e use) your function using a 'C' compatible header file that contains just the declaration of your function. Your function definition is contained in a binary format (that was compiled by your C++ compiler) that the client 'C' linker will then link to using the 'C' name.  

Since C++ has overloading of function names and C does not, the C++ compiler cannot just use the function name as a unique id to link to, so it mangles the name by adding information about the arguments.  A C compiler does not need to mangle the name since you can not overload function names in C.  When you state that a function has extern "C" linkage in C++, the C++ compiler does not add argument/parameter type information to the name used for linkage.  

Just so you know, you can specify "C" linkage to each individual declaration/definition explicitly or use a block to group a sequence of declarations/definitions to have a certain linkage:  

```c++
extern "C" void foo(int);
extern "C"
{
   void g(char);
   int i;
}
```

If you care about the technicalities, they are listed in section 7.5 of the C++03 standard, here is a brief summary (with emphasis on extern "C"):  

<ul>
<li>extern "C" is a linkage-specification</li>
<li>Every compiler is <em>required</em> to provide "C" linkage</li>
<li>a linkage specification shall occur only in namespace scope</li>
<li><strike> all function types, function names and variable names have a language linkage </strike> <b><a href="https://stackoverflow.com/questions/1041866/in-c-source-what-is-the-effect-of-extern-c#comment20842899_1041880">See Richard's Comment:</a></b> Only function names and variable names with external linkage have a language linkage</li>
<li>two function types with distinct language linkages are distinct types even if otherwise identical</li>
<li>linkage specs nest, inner one determines the final linkage</li>
<li>extern "C" is ignored for class members </li>
<li>at most one function with a particular name can have "C" linkage (regardless of namespace)</li>
<li><strike> extern "C" forces a function to have external linkage (cannot make it static) </strike> <b> <a href="https://stackoverflow.com/questions/1041866/what-is-the-effect-of-extern-c-in-c?rq=1#comment20842893_1041880">See Richard's comment:</a> </b>   'static' inside 'extern "C"' is valid; an entity so declared has internal linkage, and so does not have a language linkage </li>
<li>Linkage from C++ to objects defined in other languages and to objects defined in C++ from other languages is implementation-defined and language-dependent. Only where the object layout strategies of two language implementations are similar enough can such linkage be achieved  </li>
</ul>

#### Answer 2 (score 295)
Just wanted to add a bit of info, since I haven't seen it posted yet.  

You'll very often see code in C headers like so:  

```c++
#ifdef __cplusplus
extern "C" {
#endif

// all of your legacy C code here

#ifdef __cplusplus
}
#endif
```

What this accomplishes is that it allows you to use that C header file with your C++ code, because the macro "__cplusplus" will be defined. But you can <em>also</em> still use it with your legacy C code, where the macro is <em>NOT</em> defined, so it won't see the uniquely C++ construct.  

Although, I have also seen C++ code such as:  

```c++
extern "C" {
#include "legacy_C_header.h"
}
```

which I imagine accomplishes much the same thing.  

Not sure which way is better, but I have seen both.  

#### Answer 3 (score 210)
<strong>Decompile a `g++` generated binary to see what is going on</strong>  

main.cpp  

```c++
void f() {}
void g();

extern "C" {
    void ef() {}
    void eg();
}

/* Prevent g and eg from being optimized away. */
void h() { g(); eg(); }
```

Compile and disassemble the generated <a href="https://stackoverflow.com/questions/26294034/how-to-make-an-executable-elf-file-in-linux-using-a-hex-editor/30648229#30648229">ELF</a> output:  

```c++
g++ -c -std=c++11 -Wall -Wextra -pedantic -o main.o main.cpp
readelf -s main.o
```

The output contains:  

```c++
     8: 0000000000000000     7 FUNC    GLOBAL DEFAULT    1 _Z1fv
     9: 0000000000000007     7 FUNC    GLOBAL DEFAULT    1 ef
    10: 000000000000000e    17 FUNC    GLOBAL DEFAULT    1 _Z1hv
    11: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND _GLOBAL_OFFSET_TABLE_
    12: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND _Z1gv
    13: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND eg
```

<strong>Interpretation</strong>  

We see that:  

<ul>
<li><p>`ef` and `eg` were stored in symbols with the same name as in the code</p></li>
<li><p>the other symbols were mangled. Let's unmangle them:</p>

```c++
$ c++filt _Z1fv
f()
$ c++filt _Z1hv
h()
$ c++filt _Z1gv
g()
```</li>
</ul>

Conclusion: both of the following symbol types were <em>not</em> mangled:  

<ul>
<li>defined</li>
<li>declared but undefined (`Ndx = UND`), to be provided at link or run time from another object file</li>
</ul>

So you will need `extern "C"` both when calling:  

<ul>
<li>C from C++: tell `g++` to expect unmangled symbols produced by `gcc`</li>
<li>C++ from C: tell `g++` to generate unmangled symbols for `gcc` to use</li>
</ul>

<strong>Things that do not work in extern C</strong>  

It becomes obvious that any C++ feature that requires name mangling will not work inside `extern C`:  

```c++
extern "C" {
    // Overloading.
    // error: declaration of C function ‘void f(int)’ conflicts with
    void f();
    void f(int i);

    // Templates.
    // error: template with C linkage
    template <class C> void f(C i) { }
}
```

<strong>Minimal runnable C from C++ example</strong>  

For the sake of completeness and for the newbs out there, see also: <a href="https://stackoverflow.com/questions/13694605/how-to-use-c-source-files-in-a-c-project/51912672#51912672">How to use C source files in a C++ project?</a>  

Calling C from C++ is pretty easy: each C function only has one possible non-mangled symbol, so no extra work is required.  

main.cpp  

```c++
#include <cassert>

#include "c.h"

int main() {
    assert(f() == 1);
}
```

c.h  

```c++
#ifndef C_H
#define C_H

/* This ifdef allows the header to be used from both C and C++. */
#ifdef __cplusplus
extern "C" {
#endif
int f();
#ifdef __cplusplus
}
#endif

#endif
```

c.c  

```c++
#include "c.h"

int f(void) { return 1; }
```

Run:  

```c++
g++ -c -o main.o -std=c++98 main.cpp
gcc -c -o c.o -std=c89 c.c
g++ -o main.out main.o c.o
./main.out
```

Without `extern "C"` the link fails with:  

```c++
main.cpp:6: undefined reference to `f()'
```

because `g++` expects to find a mangled `f`, which `gcc` did not produce.  

<a href="https://github.com/cirosantilli/cpp-cheat/tree/bf5f48628d0b01ba6a3fcea6f1162b28539654c9/c-from-cpp" rel="noreferrer">Example on GitHub</a>.  

<strong>Minimal runnable C++ from C example</strong>  

Calling C++ from C is a bit harder: we have to manually create non-mangled versions of each function we want to expose.  

Here we illustrate how to expose C++ function overloads to C.  

main.c  

```c++
#include <assert.h>

#include "cpp.h"

int main(void) {
    assert(f_int(1) == 2);
    assert(f_float(1.0) == 3);
    return 0;
}
```

cpp.h  

```c++
#ifndef CPP_H
#define CPP_H

#ifdef __cplusplus
// C cannot see these overloaded prototypes, or else it would get confused.
int f(int i);
int f(float i);
extern "C" {
#endif
int f_int(int i);
int f_float(float i);
#ifdef __cplusplus
}
#endif

#endif
```

cpp.cpp  

```c++
#include "cpp.h"

int f(int i) {
    return i + 1;
}

int f(float i) {
    return i + 2;
}

int f_int(int i) {
    return f(i);
}

int f_float(float i) {
    return f(i);
}
```

Run:  

```c++
gcc -c -o main.o -std=c89 -Wextra main.c
g++ -c -o cpp.o -std=c++98 cpp.cpp
g++ -o main.out main.o cpp.o
./main.out
```

Without `extern "C"` it fails with:  

```c++
main.c:6: undefined reference to `f_int'
main.c:7: undefined reference to `f_float'
```

because `g++` generated mangled symbols which `gcc` cannot find.  

<a href="https://github.com/cirosantilli/cpp-cheat/tree/bf5f48628d0b01ba6a3fcea6f1162b28539654c9/cpp-from-c" rel="noreferrer">Example on GitHub</a>.  

Tested in Ubuntu 18.04.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How do I erase an element from std::vector<> by index? (score [678605](https://stackoverflow.com/q/875103) in 2016)

#### Question
I have a std::vector&lt;int>, and I want to delete the n'th element. How do I do that?  

```c++
std::vector<int> vec;

vec.push_back(6);
vec.push_back(-17);
vec.push_back(12);

vec.erase(???);
```

#### Answer accepted (score 633)
To delete a single element, you could do:  

```c++
std::vector<int> vec;

vec.push_back(6);
vec.push_back(-17);
vec.push_back(12);

// Deletes the second element (vec[1])
vec.erase(vec.begin() + 1);
```

Or, to delete more than one element at once:  

```c++
// Deletes the second through third elements (vec[1], vec[2])
vec.erase(vec.begin() + 1, vec.begin() + 3);
```

#### Answer 2 (score 194)
The erase method on std::vector is overloaded, so it's probably clearer to call  

```c++
vec.erase(vec.begin() + index);
```

when you only want to erase a single element.  

#### Answer 3 (score 51)
```c++
template <typename T>
void remove(std::vector<T>& vec, size_t pos)
{
    std::vector<T>::iterator it = vec.begin();
    std::advance(it, pos);
    vec.erase(it);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: Compiling C++11 with g++ (score [675811](https://stackoverflow.com/q/10363646) in 2018)

#### Question
<p>I'm trying to update my C++ compiler to C++11.
I have searched a bit and I have come to the conclusion that I have to use the flag `-std=c++0x` or `-std=gnu++0x`, but I don't know many things about flags. Can anyone help me? (I'm using Ubuntu 12.04.)</p>

Here is the error that I get from the compiler when I attempt to use a library which is included in C++11 (i.e. array):  

```c++
#include <array>
#include <iostream>

int main()
{
    std::array<int, 3> arr = {2, 3, 5};
    ...
}
```

<blockquote>
  This file requires compiler and library support for the upcoming ISO C++ standard, C++0x. This support is currently experimental, and must be enabled with the -std=c++0x or -std=gnu++0x compiler options.  
</blockquote>

#### Answer accepted (score 499)
Flags (or compiler options) are nothing but ordinary command line arguments passed to the compiler executable.  

Assuming you are invoking g++ from the command line (terminal):  

`$ g++ -std=c++11 your_file.cpp -o your_program`  

or  

`$ g++ -std=c++0x your_file.cpp -o your_program`  

if the above doesn't work.  

#### Answer 2 (score 41)
You can check your `g++` by command:  

```c++
which g++
g++ --version
```

this will tell you which complier is currently it is pointing.  

To switch to `g++` 4.7 (assuming that you have installed it in your machine),run:  

```c++
sudo update-alternatives --config gcc

There are 2 choices for the alternative gcc (providing /usr/bin/gcc).

  Selection    Path              Priority   Status
------------------------------------------------------------
  0            /usr/bin/gcc-4.6   60        auto mode
  1            /usr/bin/gcc-4.6   60        manual mode
* 2            /usr/bin/gcc-4.7   40        manual mode
```

Then select `2` as selection(My machine already pointing to `g++` 4.7,so the *)  

Once you switch the complier then again run `g++ --version` to check the switching has happened correctly.  

Now compile your program with   

```c++
g++ -std=c++11 your_file.cpp -o main
```

#### Answer 3 (score 13)
Your ubuntu definitely has a sufficiently recent version of g++. The flag to use is `-std=c++0x`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: Regular cast vs. static_cast vs. dynamic_cast (score [667403](https://stackoverflow.com/q/28002) in 2014)

#### Question
I've been writing C and C++ code for almost twenty years, but there's one aspect of these languages that I've never really understood. I've obviously used regular casts i.e.  

```c++
MyClass *m = (MyClass *)ptr;
```

all over the place, but there seem to be two other types of casts, and I don't know the difference. What's the difference between the following lines of code?  

```c++
MyClass *m = (MyClass *)ptr;
MyClass *m = static_cast<MyClass *>(ptr);
MyClass *m = dynamic_cast<MyClass *>(ptr);
```

#### Answer accepted (score 1533)
<h5>static_cast</h2>

`static_cast` is used for cases where you basically want to reverse an implicit conversion, with a few restrictions and additions. `static_cast` performs no runtime checks. This should be used if you know that you refer to an object of a specific type, and thus a check would be unnecessary. Example:  

```c++
void func(void *data) {
  // Conversion from MyClass* -> void* is implicit
  MyClass *c = static_cast<MyClass*>(data);
  ...
}

int main() {
  MyClass c;
  start_thread(&func, &c)  // func(&c) will be called
      .join();
}
```

In this example, you know that you passed a `MyClass` object, and thus there isn't any need for a runtime check to ensure this.  

<h5>dynamic_cast</h2>

`dynamic_cast` is useful when you don't know what the dynamic type of the object is. It returns a null pointer if the object referred to doesn't contain the type casted to as a base class (when you cast to a reference, a `bad_cast` exception is thrown in that case).  

```c++
if (JumpStm *j = dynamic_cast<JumpStm*>(&stm)) {
  ...
} else if (ExprStm *e = dynamic_cast<ExprStm*>(&stm)) {
  ...
}
```

You cannot use `dynamic_cast` if you downcast (cast to a derived class) and the argument type is not polymorphic. For example, the following code is not valid, because `Base` doesn't contain any virtual function:  

```c++
struct Base { };
struct Derived : Base { };
int main() {
  Derived d; Base *b = &d;
  dynamic_cast<Derived*>(b); // Invalid
}
```

An "up-cast" (cast to the base class) is always valid with both `static_cast` and `dynamic_cast`, and also without any cast, as an "up-cast" is an implicit conversion.  

<h5>Regular Cast</h2>

These casts are also called C-style cast. A C-style cast is basically identical to trying out a range of sequences of C++ casts, and taking the first C++ cast that works, without ever considering `dynamic_cast`. Needless to say, this is much more powerful as it combines all of `const_cast`, `static_cast` and `reinterpret_cast`, but it's also unsafe, because it does not use `dynamic_cast`.  

In addition, C-style casts not only allow you to do this, but they also allow you to safely cast to a private base-class, while the "equivalent" `static_cast` sequence would give you a compile-time error for that.  

Some people prefer C-style casts because of their brevity. I use them for numeric casts only, and use the appropriate C++ casts when user defined types are involved, as they provide stricter checking.  

#### Answer 2 (score 160)
<h5>Static cast</h2> 

The static cast performs conversions between compatible types. It is similar to the C-style cast, but is more restrictive. For example, the C-style cast would allow an integer pointer to point to a char.  

```c++
char c = 10;       // 1 byte
int *p = (int*)&c; // 4 bytes
```

Since this results in a 4-byte pointer pointing to 1 byte of allocated memory, writing to this pointer will either cause a run-time error or will overwrite some adjacent memory.  

```c++
*p = 5; // run-time error: stack corruption
```

In contrast to the C-style cast, the static cast will allow the compiler to check that the pointer and pointee data types are compatible, which allows the programmer to catch this incorrect pointer assignment during compilation.  

```c++
int *q = static_cast<int*>(&c); // compile-time error
```

<h5>Reinterpret cast</h2>

To force the pointer conversion, in the same way as the C-style cast does in the background, the reinterpret cast would be used instead.  

```c++
int *r = reinterpret_cast<int*>(&c); // forced conversion
```

This cast handles conversions between certain unrelated types, such as from one pointer type to another incompatible pointer type. It will simply perform a binary copy of the data without altering the underlying bit pattern. Note that the result of such a low-level operation is system-specific and therefore not portable. It should be used with caution if it cannot be avoided altogether.  

<h5>Dynamic cast</h2>

This one is only used to convert object pointers and object references into other pointer or reference types in the inheritance hierarchy. It is the only cast that makes sure that the object pointed to can be converted, by performing a run-time check that the pointer refers to a complete object of the destination type. For this run-time check to be possible the object must be polymorphic. That is, the class must define or inherit at least one virtual function. This is because the compiler will only generate the needed run-time type information for such objects.  

<strong>Dynamic cast examples</strong>  

In the example below, a MyChild pointer is converted into a MyBase pointer using a dynamic cast. This derived-to-base conversion succeeds, because the Child object includes a complete Base object.  

```c++
class MyBase 
{ 
  public:
  virtual void test() {}
};
class MyChild : public MyBase {};



int main()
{
  MyChild *child = new MyChild();
  MyBase  *base = dynamic_cast<MyBase*>(child); // ok
}
```

The next example attempts to convert a MyBase pointer to a MyChild pointer. Since the Base object does not contain a complete Child object this pointer conversion will fail. To indicate this, the dynamic cast returns a null pointer. This gives a convenient way to check whether or not a conversion has succeeded during run-time.  

```c++
MyBase  *base = new MyBase();
MyChild *child = dynamic_cast<MyChild*>(base);


if (child == 0) 
std::cout << "Null pointer returned";
```

If a reference is converted instead of a pointer, the dynamic cast will then fail by throwing a bad_cast exception. This needs to be handled using a try-catch statement.  

```c++
#include <exception>
// …  
try
{ 
  MyChild &child = dynamic_cast<MyChild&>(*base);
}
catch(std::bad_cast &e) 
{ 
  std::cout << e.what(); // bad dynamic_cast
}
```

<h5>Dynamic or static cast</h2>

The advantage of using a dynamic cast is that it allows the programmer to check whether or not a conversion has succeeded during run-time. The disadvantage is that there is a performance overhead associated with doing this check. For this reason using a static cast would have been preferable in the first example, because a derived-to-base conversion will never fail.  

```c++
MyBase *base = static_cast<MyBase*>(child); // ok
```

However, in the second example the conversion may either succeed or fail. It will fail if the MyBase object contains a MyBase instance and it will succeed if it contains a MyChild instance. In some situations this may not be known until run-time. When this is the case dynamic cast is a better choice than static cast.  

```c++
// Succeeds for a MyChild object
MyChild *child = dynamic_cast<MyChild*>(base);
```

If the base-to-derived conversion had been performed using a static cast instead of a dynamic cast the conversion would not have failed. It would have returned a pointer that referred to an incomplete object. Dereferencing such a pointer can lead to run-time errors.  

```c++
// Allowed, but invalid
MyChild *child = static_cast<MyChild*>(base);

// Incomplete MyChild object dereferenced
(*child);
```

<h5>Const cast</h2>

This one is primarily used to add or remove the const modifier of a variable.  

```c++
const int myConst = 5;
int *nonConst = const_cast<int*>(&myConst); // removes const
```

Although const cast allows the value of a constant to be changed, doing so is still invalid code that may cause a run-time error. This could occur for example if the constant was located in a section of read-only memory.  

```c++
*nonConst = 10; // potential run-time error
```

Const cast is instead used mainly when there is a function that takes a non-constant pointer argument, even though it does not modify the pointee.  

```c++
void print(int *p) 
{
   std::cout << *p;
}
```

The function can then be passed a constant variable by using a const cast.  

```c++
print(&myConst); // error: cannot convert 
                 // const int* to int*

print(nonConst); // allowed
```

<a href="http://www.pvtuts.com/cpp/cpp-type-conversion-i">Source and More Explanations</a>  

#### Answer 3 (score 78)
You should look at the article <em><a href="http://en.wikibooks.org/wiki/C%2B%2B_Programming/Programming_Languages/C%2B%2B/Code/Statements/Variables/Type_Casting" rel="noreferrer">C++ Programming/Type Casting</a></em>.  

It contains a good description of all of the different cast types. The following taken from the above link:  

<blockquote>
  const_cast  
  
  <p>const_cast(expression) The const_cast&lt;>() is used to add/remove
  const(ness) (or volatile-ness) of a variable.</p>
  
  static_cast  
  
  <p>static_cast(expression) The static_cast&lt;>() is used to cast between
  the integer types. 'e.g.' char->long, int->short etc.</p>
  
  <p>Static cast is also used to cast pointers to related types, for
  example casting void* to the appropriate type.</p>
  
  dynamic_cast  
  
  <p>Dynamic cast is used to convert pointers and references at run-time,
  generally for the purpose of casting a pointer or reference up or down
  an inheritance chain (inheritance hierarchy).</p>
  
  dynamic_cast(expression)  
  
  <p>The target type must be a pointer or reference type, and the
  expression must evaluate to a pointer or reference. Dynamic cast works
  only when the type of object to which the expression refers is
  compatible with the target type and the base class has at least one
  virtual member function. If not, and the type of expression being cast
  is a pointer, NULL is returned, if a dynamic cast on a reference
  fails, a bad_cast exception is thrown. When it doesn't fail, dynamic
  cast returns a pointer or reference of the target type to the object
  to which expression referred.</p>
  
  reinterpret_cast  
  
  <p>Reinterpret cast simply casts one type bitwise to another. Any pointer
  or integral type can be casted to any other with reinterpret cast,
  easily allowing for misuse. For instance, with reinterpret cast one
  might, unsafely, cast an integer pointer to a string pointer.</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: Remove secure warnings (_CRT_SECURE_NO_WARNINGS) from projects by default in Visual Studio (score [653402](https://stackoverflow.com/q/16883037) in 2017)

#### Question
Is there a way to set by default for all projects removing the precompiler secure warnings that come up when using functions like scanf(). I found that you can do it by adding a line in the project option or a `#define _CRT_SECURE_NO_WARNINGS` in the beginning of the code.  

I find myself repeatedly creating new projects for solving programming contests and it is really annoying (and takes valuable time) to add:  

```c++
#ifdef _MSC_VER
#define _CRT_SECURE_NO_WARNINGS
#endif
```

In the beginning of the code, or to set it in the precompiler options every time I start a new project.  

#### Answer 2 (score 261)
Mark all the desired projects in solution explorer.  

Press Alt-F7 or right click in solution explorer and select "Properties"  

Configurations:All Configurations  

<p>Click on the 
Preprocessor Definitions line to invoke its editor</p>

<p>Choose 
Edit...</p>

Copy "_CRT_SECURE_NO_WARNINGS" into the Preprocessor Definitions white box on the top.  

<img src="https://i.stack.imgur.com/VjogY.png" alt="enter image description here">  

#### Answer 3 (score 79)
It may have been because I am still new to VS and definitely new to C, but the only thing that allowed me to build was adding  

```c++
#pragma warning(disable:4996)
```

At the top of my file, this suppressed the C4996 error I was getting with sprintf  

A bit annoying but perfect for my tiny bit of code and by far the easiest.  

I read about it here: <a href="https://msdn.microsoft.com/en-us/library/2c8f766e.aspx">https://msdn.microsoft.com/en-us/library/2c8f766e.aspx</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: Simple example of threading in C++ (score [652032](https://stackoverflow.com/q/266168) in 2019)

#### Question
Can someone post a simple example of starting two (Object Oriented) threads in C++.   

I'm looking for actual C++ thread objects that I can extend run methods on (or something similar) as opposed to calling a C-style thread library.  

I left out any OS specific requests in the hopes that whoever replied would reply with cross platform libraries to use. I'm just making that explicit now.  

#### Answer accepted (score 530)
Create a function that you want the thread to execute, eg:  

```c++
void task1(std::string msg)
{
    std::cout << "task1 says: " << msg;
}
```

Now create the `thread` object that will ultimately invoke the function above like so:  

```c++
std::thread t1(task1, "Hello");
```

(You need to `#include &lt;thread&gt;` to access the `std::thread` class)  

The constructor's arguments are the function the thread will execute, followed by the function's parameters. The thread is automatically started upon construction.  

If later on you want to wait for the thread to be done executing the function, call:  

```c++
t1.join(); 
```

(Joining means that the thread who invoked the new thread will wait for the new thread to finish execution, before it will continue its own execution).  

<hr>

<h5>The Code</h2>

```c++
#include <string>
#include <iostream>
#include <thread>

using namespace std;

// The function we want to execute on the new thread.
void task1(string msg)
{
    cout << "task1 says: " << msg;
}

int main()
{
    // Constructs the new thread and runs it. Does not block execution.
    thread t1(task1, "Hello");

    // Do other things...

    // Makes the main thread wait for the new thread to finish execution, therefore blocks its own execution.
    t1.join();
}
```

<a href="http://en.cppreference.com/w/cpp/thread/thread" rel="noreferrer">More information about std::thread here</a>  

<ul>
<li><em>On GCC, compile with `-std=c++0x -pthread`.</em></li>
<li><em>This should work for any operating-system, granted your compiler supports this (C++11) feature.</em></li>
</ul>

#### Answer 2 (score 78)
Well, technically any such object will wind up being built over a C-style thread library because C++ only just specified a stock <a href="http://en.cppreference.com/w/cpp/thread/thread" rel="noreferrer">`std::thread`</a> model in c++0x, which was just nailed down and hasn't yet been implemented. The problem is somewhat systemic, technically the existing c++ memory model isn't strict enough to allow for well defined semantics for all of the 'happens before' cases. Hans Boehm wrote an paper on the topic a while back and was instrumental in hammering out the c++0x standard on the topic.  

<a href="http://www.hpl.hp.com/techreports/2004/HPL-2004-209.html" rel="noreferrer">http://www.hpl.hp.com/techreports/2004/HPL-2004-209.html</a>  

That said there are several cross-platform thread C++ libraries that work just fine in practice. Intel thread building blocks contains a tbb::thread object that closely approximates the c++0x standard and Boost has a boost::thread library that does the same.  

<a href="http://www.threadingbuildingblocks.org/" rel="noreferrer">http://www.threadingbuildingblocks.org/</a>  

<a href="http://www.boost.org/doc/libs/1_37_0/doc/html/thread.html" rel="noreferrer">http://www.boost.org/doc/libs/1_37_0/doc/html/thread.html</a>  

Using boost::thread you'd get something like:  

```c++
#include <boost/thread.hpp>

void task1() { 
    // do stuff
}

void task2() { 
    // do stuff
}

int main (int argc, char ** argv) {
    using namespace boost; 
    thread thread_1 = thread(task1);
    thread thread_2 = thread(task2);

    // do other stuff
    thread_2.join();
    thread_1.join();
    return 0;
}
```

#### Answer 3 (score 20)
<p>There is also a POSIX library for POSIX operating systems. 
<a href="http://en.wikipedia.org/wiki/POSIX" rel="nofollow noreferrer">Check</a> for compatability </p>

```c++
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <iostream>

void *task(void *argument){
      char* msg;
      msg = (char*)argument;
      std::cout<<msg<<std::endl;
}

int main(){
    pthread_t thread1, thread2;
    int i1,i2;
    i1 = pthread_create( &thread1, NULL, task, (void*) "thread 1");
    i2 = pthread_create( &thread2, NULL, task, (void*) "thread 2");

    pthread_join(thread1,NULL);
    pthread_join(thread2,NULL);
    return 0;

}
```

compile with -lpthread      

<a href="http://en.wikipedia.org/wiki/POSIX_Threads" rel="nofollow noreferrer">http://en.wikipedia.org/wiki/POSIX_Threads</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: When to use virtual destructors? (score [650734](https://stackoverflow.com/q/461203) in 2019)

#### Question
I have a solid understanding of most OO theory but the one thing that confuses me a lot is virtual destructors.  

I thought that the destructor always gets called no matter what and for every object in the chain.  

When are you meant to make them virtual and why?  

#### Answer accepted (score 1491)
Virtual destructors are useful when you might potentially delete an instance of a derived class through a pointer to base class:  

```c++
class Base 
{
    // some virtual methods
};

class Derived : public Base
{
    ~Derived()
    {
        // Do some important cleanup
    }
};
```

Here, you'll notice that I didn't declare Base's destructor to be `virtual`. Now, let's have a look at the following snippet:  

```c++
Base *b = new Derived();
// use b
delete b; // Here's the problem!
```

Since Base's destructor is not `virtual` and `b` is a `Base*` pointing to a `Derived` object, `delete b` has <a href="https://stackoverflow.com/q/2397984/20984">undefined behaviour</a>:  

<blockquote>
  <p>[In `delete b`], if the static type of the
  object to be deleted is different from its dynamic type, the static
  type shall be a base class of the dynamic type of the object to be
  deleted and <strong>the static type shall have a virtual destructor or the
  behavior is undefined</strong>.</p>
</blockquote>

In most implementations, the call to the destructor will be resolved like any non-virtual code, meaning that the destructor of the base class will be called but not the one of the derived class, resulting in a resources leak.  

To sum up, always make base classes' destructors `virtual` when they're meant to be manipulated polymorphically.  

If you want to prevent the deletion of an instance through a base class pointer, you can make the base class destructor protected and nonvirtual; by doing so, the compiler won't let you call `delete` on a base class pointer.  

You can learn more about virtuality and virtual base class destructor in <a href="http://www.gotw.ca/publications/mill18.htm" rel="noreferrer">this article from Herb Sutter</a>.  

#### Answer 2 (score 194)
<p>A virtual constructor is not possible but virtual destructor is possible.
Let us experiment....</p>

```c++
#include <iostream>

using namespace std;

class Base
{
public:
    Base(){
        cout << "Base Constructor Called\n";
    }
    ~Base(){
        cout << "Base Destructor called\n";
    }
};

class Derived1: public Base
{
public:
    Derived1(){
        cout << "Derived constructor called\n";
    }
    ~Derived1(){
        cout << "Derived destructor called\n";
    }
};

int main()
{
    Base *b = new Derived1();
    delete b;
}
```

The above code output the following:  

```c++
Base Constructor Called
Derived constructor called
Base Destructor called
```

<p>The construction of derived object follow the construction rule but when we delete the "b" pointer(base pointer) we have found that only the base destructor is called. But this must not be happen. To do the appropriate thing, we have to make the base destructor virtual.
Now let see what happens in the following:</p>

```c++
#include <iostream>

using namespace std;

class Base
{ 
public:
    Base(){
        cout << "Base Constructor Called\n";
    }
    virtual ~Base(){
        cout << "Base Destructor called\n";
    }
};

class Derived1: public Base
{
public:
    Derived1(){
        cout << "Derived constructor called\n";
    }
    ~Derived1(){
        cout << "Derived destructor called\n";
    }
};

int main()
{
    Base *b = new Derived1();
    delete b;
}
```

The output changed as following:  

```c++
Base Constructor Called
Derived Constructor called
Derived destructor called
Base destructor called
```

<p>So the destruction of the base pointer (which takes an allocation on derived object!) follows the destruction rule, i.e first the Derived, then the Base.
On the other hand, there is nothing like a virtual constructor.</p>

#### Answer 3 (score 185)
Declare destructors virtual in polymorphic base classes.  This is Item 7 in Scott Meyers' <a href="https://rads.stackoverflow.com/amzn/click/com/0201924889" rel="noreferrer" rel="nofollow noreferrer">Effective C++</a>.  Meyers goes on to summarize that if a class has <em>any</em> virtual function, it should have a virtual destructor, and that classes not designed to be base classes or not designed to be used polymorphically should <em>not</em> declare virtual destructors.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: Difference between private, public, and protected inheritance (score [643153](https://stackoverflow.com/q/860339) in 2018)

#### Question
What is the difference between `public`, `private`, and `protected` inheritance in C++? All of the questions I've found on SO deal with specific cases.  

#### Answer accepted (score 1013)
To answer that question, I'd like to describe member's accessors first in my own words. If you already know this, skip to the heading "next:".  

There are three accessors that I'm aware of: `public`, `protected` and `private`.   

Let:  

```c++
class Base {
    public:
        int publicMember;
    protected:
        int protectedMember;
    private:
        int privateMember;
};
```

<ul>
<li>Everything that is aware of `Base` is also aware that `Base` contains `publicMember`.</li>
<li>Only the children (and their children) are aware that `Base` contains `protectedMember`.</li>
<li>No one but `Base` is aware of `privateMember`.</li>
</ul>

By "is aware of", I mean "acknowledge the existence of, and thus be able to access".  

<h5>next:</h2>

The same happens with public, private and protected inheritance. Let's consider a class `Base` and a class `Child` that inherits from `Base`.  

<ul>
<li>If the inheritance is `public`, everything that is aware of `Base` and `Child` is also aware that `Child` inherits from `Base`.</li>
<li>If the inheritance is `protected`, only `Child`, and its children, are aware that they inherit from `Base`.</li>
<li>If the inheritance is `private`, no one other than `Child` is aware of the inheritance.</li>
</ul>

#### Answer 2 (score 1385)
```c++
class A 
{
public:
    int x;
protected:
    int y;
private:
    int z;
};

class B : public A
{
    // x is public
    // y is protected
    // z is not accessible from B
};

class C : protected A
{
    // x is protected
    // y is protected
    // z is not accessible from C
};

class D : private A    // 'private' is default for classes
{
    // x is private
    // y is private
    // z is not accessible from D
};
```

IMPORTANT NOTE: Classes B, C and D all contain the variables x, y and z. It is just question of access.  

About usage of protected and private inheritance you could read <a href="https://stackoverflow.com/questions/374399/private-protected-inheritance/374423">here</a>.  

#### Answer 3 (score 108)
Limiting the visibility of inheritance will make code not able to see that some class inherits another class: Implicit conversions from the derived to the base won't work, and `static_cast` from the base to the derived won't work either.   

Only members/friends of a class can see private inheritance, and only members/friends and derived classes can see protected inheritance.   

<strong>public</strong> inheritance  

<ol>
<li><p>IS-A inheritance. A button is-a window, and anywhere where a window is needed, a button can be passed too. </p>

```c++
class button : public window { };
```</li>
</ol>

<strong>protected</strong> inheritance  

<ol>
<li><p>Protected implemented-in-terms-of. Rarely useful. Used in `boost::compressed_pair` to derive from empty classes and save memory using empty base class optimization (example below doesn't use template to keep being at the point):</p>

```c++
struct empty_pair_impl : protected empty_class_1 
{ non_empty_class_2 second; };

struct pair : private empty_pair_impl {
  non_empty_class_2 &second() {
    return this->second;
  }

  empty_class_1 &first() {
    return *this; // notice we return *this!
  }
};
```</li>
</ol>

<strong>private</strong> inheritance  

<ol>
<li><p>Implemented-in-terms-of. The usage of the base class is only for implementing the derived class. Useful with traits and if size matters (empty traits that only contain functions will make use of the empty base class optimization). Often <em>containment</em> is the better solution, though. The size for strings is critical, so it's an often seen usage here</p>

```c++
template<typename StorageModel>
struct string : private StorageModel {
public:
  void realloc() {
    // uses inherited function
    StorageModel::realloc();
  }
};
```</li>
</ol>

<hr>

<strong>public</strong> member  

<ol>
<li><p>Aggregate</p>

```c++
class pair {
public:
  First first;
  Second second;
};
```</li>
<li><p>Accessors</p>

```c++
class window {
public:
    int getWidth() const;
};
```</li>
</ol>

<strong>protected</strong> member  

<ol>
<li><p>Providing enhanced access for derived classes</p>

```c++
class stack {
protected:
  vector<element> c;
};

class window {
protected:
  void registerClass(window_descriptor w);
};
```</li>
</ol>

<strong>private</strong> member  

<ol>
<li><p>Keep implementation details</p>

```c++
class window {
private:
  int width;
};
```</li>
</ol>

<hr>

Note that C-style casts purposely allows casting a derived class to a protected or private base class in a defined and safe manner and to cast into the other direction too. This should be avoided at all costs, because it can make code dependent on implementation details - but if necessary, you can make use of this technique.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: What's the best way to trim std::string? (score [637282](https://stackoverflow.com/q/216823) in 2016)

#### Question
I'm currently using the following code to right-trim all the `std::strings` in my programs:  

```c++
std::string s;
s.erase(s.find_last_not_of(" \n\r\t")+1);
```

It works fine, but I wonder if there are some end-cases where it might fail?  

Of course, answers with elegant alternatives and also left-trim solution are welcome.  

#### Answer 2 (score 608)
<strong>EDIT</strong> Since c++17, some parts of the standard library were removed. Fortunately, starting with c++11, we have lambdas which are a superior solution.  

```c++
#include <algorithm> 
#include <cctype>
#include <locale>

// trim from start (in place)
static inline void ltrim(std::string &s) {
    s.erase(s.begin(), std::find_if(s.begin(), s.end(), [](int ch) {
        return !std::isspace(ch);
    }));
}

// trim from end (in place)
static inline void rtrim(std::string &s) {
    s.erase(std::find_if(s.rbegin(), s.rend(), [](int ch) {
        return !std::isspace(ch);
    }).base(), s.end());
}

// trim from both ends (in place)
static inline void trim(std::string &s) {
    ltrim(s);
    rtrim(s);
}

// trim from start (copying)
static inline std::string ltrim_copy(std::string s) {
    ltrim(s);
    return s;
}

// trim from end (copying)
static inline std::string rtrim_copy(std::string s) {
    rtrim(s);
    return s;
}

// trim from both ends (copying)
static inline std::string trim_copy(std::string s) {
    trim(s);
    return s;
}
```

Thanks to <a href="https://stackoverflow.com/a/44973498/524503">https://stackoverflow.com/a/44973498/524503</a> for bringing up the modern solution.  

<h5>Original answer:</h2>

I tend to use one of these 3 for my trimming needs:  

```c++
#include <algorithm> 
#include <functional> 
#include <cctype>
#include <locale>

// trim from start
static inline std::string &ltrim(std::string &s) {
    s.erase(s.begin(), std::find_if(s.begin(), s.end(),
            std::not1(std::ptr_fun<int, int>(std::isspace))));
    return s;
}

// trim from end
static inline std::string &rtrim(std::string &s) {
    s.erase(std::find_if(s.rbegin(), s.rend(),
            std::not1(std::ptr_fun<int, int>(std::isspace))).base(), s.end());
    return s;
}

// trim from both ends
static inline std::string &trim(std::string &s) {
    return ltrim(rtrim(s));
}
```

They are fairly self explanatory and work very well.  

<strong>EDIT</strong>: BTW, I have `std::ptr_fun` in there to help disambiguate `std::isspace` because there is actually a second definition which supports locales. This could have been a cast just the same, but I tend to like this better.  

<strong>EDIT</strong>: To address some comments about accepting a parameter by reference, modifying and returning it. I Agree. An implementation that I would likely prefer would be two sets of functions, one for in place and one which makes a copy. A better set of examples would be:  

```c++
#include <algorithm> 
#include <functional> 
#include <cctype>
#include <locale>

// trim from start (in place)
static inline void ltrim(std::string &s) {
    s.erase(s.begin(), std::find_if(s.begin(), s.end(),
            std::not1(std::ptr_fun<int, int>(std::isspace))));
}

// trim from end (in place)
static inline void rtrim(std::string &s) {
    s.erase(std::find_if(s.rbegin(), s.rend(),
            std::not1(std::ptr_fun<int, int>(std::isspace))).base(), s.end());
}

// trim from both ends (in place)
static inline void trim(std::string &s) {
    ltrim(s);
    rtrim(s);
}

// trim from start (copying)
static inline std::string ltrim_copy(std::string s) {
    ltrim(s);
    return s;
}

// trim from end (copying)
static inline std::string rtrim_copy(std::string s) {
    rtrim(s);
    return s;
}

// trim from both ends (copying)
static inline std::string trim_copy(std::string s) {
    trim(s);
    return s;
}
```

I am keeping the original answer above though for context and in the interest of keeping the high voted answer still available.  

#### Answer 3 (score 408)
Using <a href="http://www.boost.org/doc/libs/1_58_0/doc/html/string_algo/usage.html#idp424359600" rel="noreferrer">Boost's string algorithms</a> would be easiest:  

```c++
#include <boost/algorithm/string.hpp>

std::string str("hello world! ");
boost::trim_right(str);
```

`str` is now `"hello world!"`. There's also `trim_left` and `trim`, which trims both sides.  

<hr>

If you add `_copy` suffix to any of above function names e.g. `trim_copy`, the function will return a trimmed copy of the string instead of modifying it through a reference.  

If you add `_if` suffix to any of above function names e.g. `trim_copy_if`, you can trim all characters satisfying your custom predicate, as opposed to just whitespaces.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: C++ Singleton design pattern (score [634664](https://stackoverflow.com/q/1008019) in 2012)

#### Question
Recently I've bumped into a realization/implementation of the Singleton design pattern for C++. It has looked like this (I have adopted it from the real life example):  

```c++
// a lot of methods are omitted here
class Singleton
{
   public:
       static Singleton* getInstance( );
       ~Singleton( );
   private:
       Singleton( );
       static Singleton* instance;
};
```

From this declaration I can deduce that the instance field is initiated on the heap. That means there is a memory allocation. What is completely unclear for me is when exactly the memory is going to be deallocated? Or is there a bug and memory leak? It seems like there is a problem in the implementation.  

My main question is, how do I implement it in the right way?  

#### Answer accepted (score 1017)
<p>In 2008 I provided a C++98 implementation of the Singleton design pattern that is lazy-evaluated, guaranteed-destruction, not-technically-thread-safe:<br>
<a href="https://stackoverflow.com/questions/270947/can-any-one-provide-me-a-sample-of-singleton-in-c/271104#271104">Can any one provide me a sample of Singleton in c++?</a>  </p>

Here is an updated C++11 implementation of the Singleton design pattern that is lazy-evaluated, correctly-destroyed, and <a href="https://stackoverflow.com/a/449823/52074">thread-safe</a>.  

```c++
class S
{
    public:
        static S& getInstance()
        {
            static S    instance; // Guaranteed to be destroyed.
                                  // Instantiated on first use.
            return instance;
        }
    private:
        S() {}                    // Constructor? (the {} brackets) are needed here.

        // C++ 03
        // ========
        // Don't forget to declare these two. You want to make sure they
        // are unacceptable otherwise you may accidentally get copies of
        // your singleton appearing.
        S(S const&);              // Don't Implement
        void operator=(S const&); // Don't implement

        // C++ 11
        // =======
        // We can use the better technique of deleting the methods
        // we don't want.
    public:
        S(S const&)               = delete;
        void operator=(S const&)  = delete;

        // Note: Scott Meyers mentions in his Effective Modern
        //       C++ book, that deleted functions should generally
        //       be public as it results in better error messages
        //       due to the compilers behavior to check accessibility
        //       before deleted status
};
```

<p>See this article about when to use a singleton: (not often)<br>
<a href="https://stackoverflow.com/questions/86582/singleton-how-should-it-be-used">Singleton: How should it be used</a></p>

<p>See this two article about initialization order and how to cope:<br>
<a href="https://stackoverflow.com/questions/211237/c-static-variables-initialisation-order/211307#211307">Static variables initialisation order</a><br>
<a href="https://stackoverflow.com/questions/335369/finding-c-static-initialization-order-problems/335746#335746">Finding C++ static initialization order problems</a>  </p>

<p>See this article describing lifetimes:<br>
<a href="https://stackoverflow.com/questions/246564/what-is-the-lifetime-of-a-static-variable-in-a-c-function">What is the lifetime of a static variable in a C++ function?</a>  </p>

<p>See this article that discusses some threading implications to singletons:<br>
<a href="https://stackoverflow.com/questions/449436/singleton-instance-declared-as-static-variable-of-getinstance-method/449823#449823">Singleton instance declared as static variable of GetInstance method, is it thread-safe?</a></p>

<p>See this article that explains why double checked locking will not work on C++:<br>
<a href="https://stackoverflow.com/questions/367633/what-are-all-the-common-undefined-behaviour-that-c-programmer-should-know-about/367690#367690">What are all the common undefined behaviours that a C++ programmer should know about?</a><br>
<a href="http://www.drdobbs.com/cpp/c-and-the-perils-of-double-checked-locki/184405726" rel="noreferrer">Dr Dobbs: C++ and The Perils of Double-Checked Locking: Part I</a></p>

#### Answer 2 (score 46)
Being a Singleton, you usually do not want it to be destructed.  

It will get torn down and deallocated when the program terminates, which is the normal, desired behavior for a singleton.  If you want to be able to explicitly clean it, it's fairly easy to add a static method to the class that allows you to restore it to a clean state, and have it reallocate next time it's used, but that's outside of the scope of a "classic" singleton.  

#### Answer 3 (score 35)
You could avoid memory allocation. There are many variants, all having problems in case of multithreading environment.  

I prefer this kind of implementation (actually, it is not correctly said I prefer, because I avoid singletons as much as possible):  

```c++
class Singleton
{
private:
   Singleton();

public:
   static Singleton& instance()
   {
      static Singleton INSTANCE;
      return INSTANCE;
   }
};
```

It has no dynamic memory allocation.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Check if a string contains a string in C++ (score [622627](https://stackoverflow.com/q/2340281) in 2019)

#### Question
I have a variable of type `std::string`.  I want to check if it contains a certain `std::string`.  How would I do that?  

Is there a function that returns true if the string is found, and false if it isn't?  

#### Answer accepted (score 632)
Use <a href="http://en.cppreference.com/w/cpp/string/basic_string/find" rel="noreferrer">`std::string::find`</a> as follows:  

```c++
if (s1.find(s2) != std::string::npos) {
    std::cout << "found!" << '\n';
}
```

Note: "found!" will be printed if `s2` is a substring of `s1`, both `s1` and `s2` are of type `std::string`.  

#### Answer 2 (score 102)
You can try using the <a href="http://en.cppreference.com/w/cpp/string/basic_string/find" rel="noreferrer">`find`</a> function:  

```c++
string str ("There are two needles in this haystack.");
string str2 ("needle");

if (str.find(str2) != string::npos) {
//.. found.
} 
```

#### Answer 3 (score 21)
Actually, you can try to use boost library,I think std::string doesn't supply enough method to do all the common string operation.In boost,you can just use the <a href="http://www.boost.org/doc/libs/1_55_0/doc/html/string_algo/reference.html#header.boost.algorithm.string.predicate_hpp" rel="noreferrer">`boost::algorithm::contains`</a>:  

```c++
#include "string"

#include "boost/algorithm/string.hpp"

using namespace std;
using namespace boost;
int main(){
    string s("gengjiawen");
    string t("geng");
    bool b = contains(s, t);
    cout << b << endl;
    return 0;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: How to initialize a vector in C++ (score [621092](https://stackoverflow.com/q/8906545) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong> <br/>
  <a href="https://stackoverflow.com/questions/2236197/c-easiest-way-to-initialize-an-stl-vector-with-hardcoded-elements">C++: Easiest way to initialize an STL vector with hardcoded elements</a></p>
</blockquote>



I want to initialize a vector like we do in case of an array.  

Example  

```c++
int vv[2] = {12, 43};
```

But when I do it like this,  

```c++
vector<int> v(2) = {34, 23};
```

OR  

```c++
vector<int> v(2);
v = {0, 9};
```

it gives an error:  

<blockquote>
  expected primary-expression before ‘{’ token  
</blockquote>

AND  

<blockquote>
  error: expected ‘,’ or ‘;’ before ‘=’ token  
</blockquote>

respectively.  

#### Answer accepted (score 259)
With the new C++ standard (may need special flags to be enabled on your compiler) you can simply do:  

```c++
std::vector<int> v { 34,23 };
// or
// std::vector<int> v = { 34,23 };
```

Or even:  

```c++
std::vector<int> v(2);
v = { 34,23 };
```

On compilers that don't support this feature (initializer lists) yet you can emulate this with an array:  

```c++
int vv[2] = { 12,43 };
std::vector<int> v(&vv[0], &vv[0]+2);
```

Or, for the case of assignment to an existing vector:  

```c++
int vv[2] = { 12,43 };
v.assign(&vv[0], &vv[0]+2);
```

Like James Kanze suggested, it's more robust to have functions that give you the beginning and end of an array:  

```c++
template <typename T, size_t N>
T* begin(T(&arr)[N]) { return &arr[0]; }
template <typename T, size_t N>
T* end(T(&arr)[N]) { return &arr[0]+N; }
```

And then you can do this without having to repeat the size all over:  

```c++
int vv[] = { 12,43 };
std::vector<int> v(begin(vv), end(vv));
```

#### Answer 2 (score 29)
You can also do like this:  

```c++
template <typename T>
class make_vector {
public:
  typedef make_vector<T> my_type;
  my_type& operator<< (const T& val) {
    data_.push_back(val);
    return *this;
  }
  operator std::vector<T>() const {
    return data_;
  }
private:
  std::vector<T> data_;
};
```

And use it like this:  

```c++
std::vector<int> v = make_vector<int>() << 1 << 2 << 3;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: How to print out the contents of a vector? (score [618189](https://stackoverflow.com/q/10750057) in 2018)

#### Question
I want to print out the contents of a vector in C++, here is what I have:  

```c++
#include <iostream>
#include <fstream>
#include <string>
#include <cmath>
#include <vector>
#include <sstream>
#include <cstdio>
using namespace std;

int main()
{
    ifstream file("maze.txt");
    if (file) {
        vector<char> vec(istreambuf_iterator<char>(file), (istreambuf_iterator<char>()));
        vector<char> path;
        int x = 17;
        char entrance = vec.at(16);
        char firstsquare = vec.at(x);
        if (entrance == 'S') { 
            path.push_back(entrance); 
        }
        for (x = 17; isalpha(firstsquare); x++) {
            path.push_back(firstsquare);
        }
        for (int i = 0; i < path.size(); i++) {
            cout << path[i] << " ";
        }
        cout << endl;
        return 0;
    }
}
```

How do I print the contents of the vector to the screen?  

#### Answer accepted (score 348)
Purely to answer your question, you can use an iterator:  

```c++
std::vector<char> path;
// ...
for (std::vector<char>::const_iterator i = path.begin(); i != path.end(); ++i)
    std::cout << *i << ' ';
```

If you want to modify the vector's contents in the for loop, then use `iterator` rather than `const_iterator`.  

But there's lots more that can be said about this. If you just want an answer you can use, then you can stop here; otherwise, read on.  

<h5>auto (C++11)/typedef</h2>

This is not another solution, but a supplement to the above `iterator` solution. If you are using the C++11 standard (or later), then you can use the `auto` keyword to help the readability:  

```c++
for (auto i = path.begin(); i != path.end(); ++i)
    std::cout << *i << ' ';
```

But the type of `i` will be non-const (i.e., the compiler will use `std::vector&lt;char&gt;::iterator` as the type of `i`).  

In this case, you might as well just use a `typedef` (not restricted to C++11, and <strong>very</strong> useful to use anyway):  

```c++
typedef std::vector<char> Path;
Path path;
// ...
for (Path::const_iterator i = path.begin(); i != path.end(); ++i)
    std::cout << *i << ' ';
```

<h5>counter</h2>

You can, of course, use a integer type to record your position in the `for` loop:  

```c++
for(int i=0; i<path.size(); ++i)
  std::cout << path[i] << ' ';
```

If you are going to do this, it's better to use the container's member types, if they are available and appropriate. `std::vector` has a member type called `size_type` for this job: it is the type returned by the `size` method.  

```c++
// Path typedef'd to std::vector<char>
for( Path::size_type i=0; i<path.size(); ++i)
  std::cout << path[i] << ' ';
```

Why not just use this over the `iterator` solution? For simple cases you might as well, but the point is that the `iterator` class is an object designed to do this job for more complicated objects where this solution is not going to be ideal.  

<h5>range-based for loop (C++11)</h2>

See <a href="https://stackoverflow.com/a/20507503/498730">Jefffrey's solution</a>. In C++11 (and later) you can use the new range-based `for` loop, which looks like this:  

```c++
for (auto i: path)
  std::cout << i << ' ';
```

Since `path` is a vector of items (explicitly `std::vector&lt;char&gt;`), the object `i` is of type of the item of the vector (i.e., explicitly, it is of type `char`). The object `i` has a value that is a copy of the actual item in the `path` object. Thus, all changes to `i` in the loop are not preserved in `path` itself. Additionally, if you would like to enforce the fact that you don't want to be able to change the copied value of `i` in the loop, you can force the type of `i` to be `const char` like this:  

```c++
for (const auto i: path)
  std::cout << i << ' ';
```

If you would like to modify the items in `path`, you can use a reference:  

```c++
for (auto& i: path)
  std::cout << i << ' ';
```

and even if you don't want to modify `path`, if the copying of objects is expensive you should use a const reference instead of copying by value:  

```c++
for (const auto& i: path)
  std::cout << i << ' ';
```

<h5>std::copy</h2>

See <a href="https://stackoverflow.com/a/11335634/498730">Joshua's answer</a>. You can use the STL algorithm `std::copy` to copy the vector contents onto the output stream. This is an elegant solution if you are comfortable with it (and besides, it is <strong>very</strong> useful, not just in this case of printing the contents of a vector).  

<h5>std::for_each</h2>

See <a href="https://stackoverflow.com/a/26363773/498730">Max's solution</a>. Using `std::for_each` is overkill for this simple scenario, but it is a very useful solution if you wanted to do more than just printing to screen: using `std::for_each` allows you to do <em>any</em> (sensible) operation on the vector contents.  

<h5>overload ostream::operator&lt;&lt;</h2>

See <a href="https://stackoverflow.com/a/23397700/498730">Chris's answer</a>, this is more a complement to the other answers since you will still need to implement one of the solutions above in the overloading. In his example he used a counter in a `for` loop. For example, this is how you could quickly use <a href="https://stackoverflow.com/a/11335634/498730">Joshua's solution</a>:  

```c++
template <typename T>
std::ostream& operator<< (std::ostream& out, const std::vector<T>& v) {
  if ( !v.empty() ) {
    out << '[';
    std::copy (v.begin(), v.end(), std::ostream_iterator<T>(out, ", "));
    out << "\b\b]";
  }
  return out;
}
```

Usage of any of the other solutions should be straightforward.  

<h5>conclusion</h2>

Any of the solutions presented here will work. It's up to you and the code on which one is the "best". Anything more detailed than this is probably best left for another question where the pros/cons can be properly evaluated; but as always user preference will always play a part: none of the solutions presented are wrong, but some will look nicer to each individual coder.  

<h5>addendum</h2>

This is an expanded solution of an earlier one I posted. Since that post kept getting attention, I decided to expand on it and refer to the other excellent solutions that were posted here. My original post had a remark that mentioned that if you <em>were</em> intending on modifying your vector inside a `for` loop then there are two methods provided by `std::vector` to access elements: `std::vector::operator[]` which does not do bounds checking, and `std::vector::at` which does perform bounds checking. In other words, `at` will throw if you try to access an element outside the vector and `operator[]` wouldn't. I only added this comment, originally, for the sake of mentioning something that it might be useful to know of if anyone already didn't. And I see no difference now. Hence this addendum.  

#### Answer 2 (score 203)
A much easier way to do this is with the standard <a href="http://en.cppreference.com/w/cpp/algorithm/copy">copy algorithm</a>:   

```c++
#include <iostream>
#include <algorithm> // for copy
#include <iterator> // for ostream_iterator
#include <vector>

int main() {
    /* Set up vector to hold chars a-z */
    std::vector<char> path;
    for (int ch = 'a'; ch <= 'z'; ++ch)
        path.push_back(ch);

    /* Print path vector to console */
    std::copy(path.begin(), path.end(), std::ostream_iterator<char>(std::cout, " "));

    return 0;
}
```

The ostream_iterator is what's called an <em>iterator adaptor</em>. It is templatized over the type to print out to the stream (in this case, `char`). `cout` (aka console output) is the stream we want to write to, and the space character (`" "`) is what we want printed between each element stored in the vector.   

This standard algorithm is powerful and so are many others. The power and flexibility the standard library gives you are what make it so great. Just imagine: you can print a vector to the console with just <strong>one</strong> line of code. You don't have to deal with special cases with the separator character. You don't need to worry about for-loops. The standard library does it all for you.  

#### Answer 3 (score 64)
In C++11 you can now use a <a href="http://en.cppreference.com/w/cpp/language/range-for">range-based for loop</a>:  

```c++
for (auto const& c : path)
    std::cout << c << ' ';
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: How to concatenate a std::string and an int? (score [601901](https://stackoverflow.com/q/191757) in 2017)

#### Question
I thought this would be really simple but it's presenting some difficulties. If I have  

```c++
std::string name = "John";
int age = 21;
```

How do I combine them to get a single string `"John21"`?  

#### Answer 2 (score 1062)
In alphabetical order:  

```c++
std::string name = "John";
int age = 21;
std::string result;

// 1. with Boost
result = name + boost::lexical_cast<std::string>(age);

// 2. with C++11
result = name + std::to_string(age);

// 3. with FastFormat.Format
fastformat::fmt(result, "{0}{1}", name, age);

// 4. with FastFormat.Write
fastformat::write(result, name, age);

// 5. with the {fmt} library
result = fmt::format("{}{}", name, age);

// 6. with IOStreams
std::stringstream sstm;
sstm << name << age;
result = sstm.str();

// 7. with itoa
char numstr[21]; // enough to hold all numbers up to 64-bits
result = name + itoa(age, numstr, 10);

// 8. with sprintf
char numstr[21]; // enough to hold all numbers up to 64-bits
sprintf(numstr, "%d", age);
result = name + numstr;

// 9. with STLSoft's integer_to_string
char numstr[21]; // enough to hold all numbers up to 64-bits
result = name + stlsoft::integer_to_string(numstr, 21, age);

// 10. with STLSoft's winstl::int_to_string()
result = name + winstl::int_to_string(age);

// 11. With Poco NumberFormatter
result = name + Poco::NumberFormatter().format(age);
```

<ol>
<li>is safe, but slow; requires <a href="http://www.boost.org/" rel="noreferrer">Boost</a> (header-only); most/all platforms</li>
<li>is safe, requires C++11 (<a href="http://www.cplusplus.com/reference/string/to_string/" rel="noreferrer">to_string()</a> is already included in `#include &lt;string&gt;`)</li>
<li>is safe, and fast; requires <a href="http://fastformat.sourceforge.net/" rel="noreferrer">FastFormat</a>, which must be compiled; most/all platforms</li>
<li>(<em>ditto</em>)</li>
<li>is safe, and fast; requires <a href="https://github.com/fmtlib/fmt" rel="noreferrer">the {fmt} library</a>, which can either be compiled or used in a header-only mode; most/all platforms</li>
<li>safe, slow, and verbose; requires `#include &lt;sstream&gt;` (from standard C++)</li>
<li>is brittle (you must supply a large enough buffer), fast, and verbose; itoa() is a non-standard extension, and not guaranteed to be available for all platforms</li>
<li>is brittle (you must supply a large enough buffer), fast, and verbose; requires nothing (is standard C++); all platforms</li>
<li>is brittle (you must supply a large enough buffer), <a href="http://www.ddj.com/cpp/184401596" rel="noreferrer">probably the fastest-possible conversion</a>, verbose; requires <a href="http://www.stlsoft.org/" rel="noreferrer">STLSoft</a> (header-only); most/all platforms</li>
<li>safe-ish (you don't use more than one <a href="http://www.stlsoft.org/doc-1.9/int%5F%5Fto%5F%5Fstring%5F8hpp.html" rel="noreferrer">int_to_string()</a> call in a single statement), fast; requires <a href="http://www.stlsoft.org/" rel="noreferrer">STLSoft</a> (header-only); Windows-only</li>
<li>is safe, but slow; requires <a href="http://www.boost.org/" rel="noreferrer">Poco C++</a> ; most/all platforms</li>
</ol>

#### Answer 3 (score 251)
In C++11, you can use `std::to_string`, e.g.:  

```c++
auto result = name + std::to_string( age );
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: How do I build a graphical user interface in C++? (score [587542](https://stackoverflow.com/q/1186017) in 2019)

#### Question
All of my C++ programs so far have been using the command line interface and the only other language I have experience with is PHP which doesn't support GUIs.   

Where do I start with graphical user interface programming in C++? How do I create one?  

#### Answer accepted (score 143)
Essentially an operating system's windowing system exposes some API calls that you can perform to do jobs like create a window, or put a button on the window. Basically you get a suite of header files and you can call functions in those imported libraries, just like you'd do with stdlib and `printf`.   

Each operating system comes with it's own GUI toolkit, suite of header files, and API calls, and their own way of doing things. There are also cross platform toolkits like gtk, qt, and wx widgets that help you build programs that work anywhere. They achieve this by having the same API calls on each platform, but a different implementation for those API functions that call down to the native OS API calls.  

One thing they'll all have in common, which will be different from a CLI program, is something called an event loop. The basic idea there is somewhat complicated, and difficult to compress, but in essence it means that not a hell of a lot is going in in your main class/main function, except:  

<ul>
<li>check the event queue if there's any new events</li>
<li>if there is, dispatch those events to appropriate handlers</li>
<li>when you're done, yield control back to the operating system (usually with some kind of special "sleep" or "select" or "yield" function call)</li>
<li>then the yield function will return when the operating system is done, and you have another go around the loop.</li>
</ul>

There are plenty of resources about event based programming. If you have any experience with javascript, it's the same basic idea, except that you, the scripter have no access or control over the event loop itself, or what events there are, your only job is to write and register handlers.  

You should keep in mind that GUI programming is incredibly complicated and difficult, in general. If you have the option, it's actually much easier to just integrate an embedded webserver into your program and have an html/web based interface. The one exception that I've encountered is Apple's cocoa+xcode+interface builder + tutorials that make it easily the most approachable environment for people new to GUI programming that I've seen.  

#### Answer 2 (score 156)
There are plenty of <b>free portable GUI libraries</b>, each with its own strengths and weaknesses:  

<ul>
<li><a href="https://www.qt.io/" rel="noreferrer">Qt</a>
<li><a href="http://www.gtkmm.org/" rel="noreferrer">GTKmm</a> (based on <a href="http://www.gtk.org/" rel="noreferrer">GTK+</a>)
<li><a href="http://www.wxwidgets.org/" rel="noreferrer">wxWidgets</a>
<li><a href="http://www.fltk.org/" rel="noreferrer">FLTK</a>
<li><a href="http://www.ultimatepp.org/" rel="noreferrer">Ultimate++</a>
<li><a href="https://www.juce.com/" rel="noreferrer">JUCE</a>
<li>...

</ul>

Especially <a href="http://doc.qt.io/qt-5/qtexamplesandtutorials.html" rel="noreferrer">Qt has nice tutorials</a> and tools which help you getting started. Enjoy!  

Note, however, that you should <b>avoid platform specific</b> functionality such as the Win32 API or MFC. That ties you unnecessarily on a specific platform with almost no benefits.  

#### Answer 3 (score 72)
OS independent algorithm "<em>Creating GUI applications in C++ in three steps</em>":  

<ol>
<li><p>Install <a href="https://www.qt.io/download-open-source/" rel="noreferrer">Qt Creator</a>  </p>

<a href="https://i.stack.imgur.com/F87hl.png" rel="noreferrer"><img src="https://i.stack.imgur.com/F87hl.png" alt="enter image description here"></a>  </li>
<li><p>Create new project (Qt Widgets Application)  </p>

<a href="https://i.stack.imgur.com/VXVsJ.png" rel="noreferrer"><img src="https://i.stack.imgur.com/VXVsJ.png" alt="enter image description here"></a>  </li>
<li><p>Build it.</p></li>
</ol>

Congratulations, you've got your first GUI in C++.  

Now you're ready to read a lot of <a href="http://doc.qt.io/" rel="noreferrer">documentation</a> to create something more complicate than "Hello world" GUI application.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: How to call a parent class function from derived class function? (score [577074](https://stackoverflow.com/q/357307) in 2014)

#### Question
<p>How do I call the parent function from a derived class using C++? For example, I have a class called `parent`, and a class called `child` which is derived from parent. Within 
each class there is a `print` function.  In the definition of the child's print function I would like to make a call to the parents print function.  How would I go about doing this?</p>

#### Answer accepted (score 701)
I'll take the risk of stating the obvious: You call the function, if it's defined in the base class it's automatically available in the derived class (unless it's `private`).  

If there is a function with the same signature in the derived class you can disambiguate it by adding the base class's name followed by two colons `base_class::foo(...)`. You should note that unlike Java and C#, C++ does <strong>not</strong> have a keyword for "the base class" (`super` or `base`) since C++ supports <a href="http://en.wikipedia.org/wiki/Multiple_inheritance" rel="noreferrer">multiple inheritance</a> which may lead to ambiguity.  

```c++
class left {
public:
    void foo();
};

class right {
public:
    void foo();
};

class bottom : public left, public right {
public:
    void foo()
    {
        //base::foo();// ambiguous
        left::foo();
        right::foo();

        // and when foo() is not called for 'this':
        bottom b;
        b.left::foo();  // calls b.foo() from 'left'
        b.right::foo();  // call b.foo() from 'right'
    }
};
```

Incidentally, you can't derive directly from the same class twice since there will be no way to refer to one of the base classes over the other.  

```c++
class bottom : public left, public left { // Illegal
};
```

#### Answer 2 (score 182)
Given parent class named `Parent` and child class named `Child`, you can do something like this:  

```c++
class Parent {
public:
    virtual void print(int x);
}

class Child : public Parent {
    void print(int x) override;
}

void Parent::print(int x) {
    // some default behavior
}

void Child::print(int x) {
    // use Parent's print method; implicitly passes 'this' to Parent::print
    Parent::print(x);
}
```

Note that `Parent` is the class's actual name and not a keyword.  

#### Answer 3 (score 30)
If your base class is called `Base`, and your function is called `FooBar()` you can call it directly using `Base::FooBar()`  

```c++
void Base::FooBar()
{
   printf("in Base\n");
}

void ChildOfBase::FooBar()
{
  Base::FooBar();
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: Passing a 2D array to a C++ function (score [576831](https://stackoverflow.com/q/8767166) in 2015)

#### Question
I have a function which I want to take, as a parameter, a 2D array of variable size.   

So far I have this:   

```c++
void myFunction(double** myArray){
     myArray[x][y] = 5;
     etc...
}
```

And I have declared an array elsewhere in my code:  

```c++
double anArray[10][10];
```

However, calling `myFunction(anArray)` gives me an error.  

I do not want to copy the array when I pass it in. Any changes made in `myFunction` should alter the state of `anArray`. If I understand correctly, I only want to pass in as an argument a pointer to a 2D array. The function needs to accept arrays of different sizes also. So for example, `[10][10]` and `[5][5]`. How can I do this?  

#### Answer accepted (score 389)
There are three ways to pass a 2D array to a function:  

<ol>
<li><p>The parameter is a 2D array</p>

```c++
int array[10][10];
void passFunc(int a[][10])
{
    // ...
}
passFunc(array);
```</li>
<li><p>The parameter is an array containing pointers</p>

```c++
int *array[10];
for(int i = 0; i < 10; i++)
    array[i] = new int[10];
void passFunc(int *a[10]) //Array containing pointers
{
    // ...
}
passFunc(array);
```</li>
<li><p>The parameter is a pointer to a pointer</p>

```c++
int **array;
array = new int *[10];
for(int i = 0; i <10; i++)
    array[i] = new int[10];
void passFunc(int **a)
{
    // ...
}
passFunc(array);
```</li>
</ol>

#### Answer 2 (score 160)
<h5>Fixed Size</h2>

<strong>1. Pass by reference</strong>  

```c++
template <size_t rows, size_t cols>
void process_2d_array_template(int (&array)[rows][cols])
{
    std::cout << __func__ << std::endl;
    for (size_t i = 0; i < rows; ++i)
    {
        std::cout << i << ": ";
        for (size_t j = 0; j < cols; ++j)
            std::cout << array[i][j] << '\t';
        std::cout << std::endl;
    }
}
```

In C++ passing the array by reference without losing the dimension information is probably the safest, since one needn't worry about the caller passing an incorrect dimension (compiler flags when mismatching). However, this isn't possible with dynamic (freestore) arrays; it works for automatic (<a href="https://stackoverflow.com/a/6500497/183120">usually stack-living</a>) arrays only i.e. the dimensionality should be known at compile time.  

<strong>2. Pass by pointer</strong>  

```c++
void process_2d_array_pointer(int (*array)[5][10])
{
    std::cout << __func__ << std::endl;
    for (size_t i = 0; i < 5; ++i)
    {
        std::cout << i << ": ";
        for (size_t j = 0; j < 10; ++j)
            std::cout << (*array)[i][j] << '\t';
        std::cout << std::endl;
    }    
}
```

The C equivalent of the previous method is passing the array by pointer. This should not be confused with passing by the array's decayed pointer type <strong>(3)</strong>, which is the common, popular method, albeit less safe than this one but more flexible. Like <strong>(1)</strong>, use this method when all the dimensions of the array is fixed and known at compile-time. Note that when calling the function the array's address should be passed `process_2d_array_pointer(&amp;a)` and not the address of the first element by decay `process_2d_array_pointer(a)`.  

<h5>Variable Size</h2>

These are inherited from C but are less safe, the compiler has no way of checking, guaranteeing that the caller is passing the required dimensions. The function only banks on what the caller passes in as the dimension(s). These are more flexible than the above ones since arrays of different lengths can be passed to them invariably.  

It is to be remembered that there's no such thing as passing an array directly to a function in C [while in C++ they can be passed as a reference <strong>(1)</strong>]; <strong>(2)</strong> is passing a pointer to the array and not the array itself. Always passing an array as-is becomes a pointer-copy operation which is facilitated by <a href="https://stackoverflow.com/questions/4810664/how-do-i-use-arrays-in-c">array's nature of decaying into a pointer</a>.  

<strong>3. Pass by (value) a pointer to the decayed type</strong>  

```c++
// int array[][10] is just fancy notation for the same thing
void process_2d_array(int (*array)[10], size_t rows)
{
    std::cout << __func__ << std::endl;
    for (size_t i = 0; i < rows; ++i)
    {
        std::cout << i << ": ";
        for (size_t j = 0; j < 10; ++j)
            std::cout << array[i][j] << '\t';
        std::cout << std::endl;
    }
}
```

Although `int array[][10]` is allowed, I'd not recommend it over the above syntax since the above syntax makes it clear that the identifier `array` is a single pointer to an array of 10 integers, while this syntax <em>looks</em> like it's a 2D array but is the same pointer to an array of 10 integers. Here we know the number of elements in a single row (i.e. the column size, 10 here) but the number of rows is unknown and hence to be passed as an argument. In this case there's some safety since the compiler can flag when a pointer to an array with second dimension not equal to 10 is passed. The first dimension is the varying part and can be omitted. <a href="https://stackoverflow.com/a/8205191/183120">See here for the rationale</a> on why only the first dimension is allowed to be omitted.  

<strong>4. Pass by pointer to a pointer</strong>  

```c++
// int *array[10] is just fancy notation for the same thing
void process_pointer_2_pointer(int **array, size_t rows, size_t cols)
{
    std::cout << __func__ << std::endl;
    for (size_t i = 0; i < rows; ++i)
    {
        std::cout << i << ": ";
        for (size_t j = 0; j < cols; ++j)
            std::cout << array[i][j] << '\t';
        std::cout << std::endl;
    }
}
```

Again there's an alternative syntax of `int *array[10]` which is the same as `int **array`. In this syntax the `[10]` is ignored as it decays into a pointer thereby becoming `int **array`. Perhaps it is just a cue to the caller that the passed array should have at least 10 columns, even then row count is required. In any case the compiler doesn't flag for any length/size violations (it only checks if the type passed is a pointer to pointer), hence requiring both row and column counts as parameter makes sense here.  

<strong>Note:</strong> <em>(4) is the least safest option</em> since it hardly has any type check and the most inconvenient. One cannot legitimately pass a 2D array to this function; <a href="http://c-faq.com/aryptr/pass2dary.html" rel="noreferrer">C-FAQ condemns</a> the usual workaround of doing `int x[5][10]; process_pointer_2_pointer((int**)&amp;x[0][0], 5, 10);` as it <a href="https://stackoverflow.com/a/7785116/183120">may potentially lead to undefined behaviour</a> due to array flattening. The right way of passing an array in this method brings us to the inconvenient part i.e. we need an additional (surrogate) array of pointers with each of its element pointing to the respective row of the actual, to-be-passed array; this surrogate is then passed to the function (see below); all this for getting the same job done as the above methods which are more safer, cleaner and perhaps faster.  

Here's a driver program to test the above functions:  

```c++
#include <iostream>

// copy above functions here

int main()
{
    int a[5][10] = { { } };
    process_2d_array_template(a);
    process_2d_array_pointer(&a);    // <-- notice the unusual usage of addressof (&) operator on an array
    process_2d_array(a, 5);
    // works since a's first dimension decays into a pointer thereby becoming int (*)[10]

    int *b[5];  // surrogate
    for (size_t i = 0; i < 5; ++i)
    {
        b[i] = a[i];
    }
    // another popular way to define b: here the 2D arrays dims may be non-const, runtime var
    // int **b = new int*[5];
    // for (size_t i = 0; i < 5; ++i) b[i] = new int[10];
    process_pointer_2_pointer(b, 5, 10);
    // process_2d_array(b, 5);
    // doesn't work since b's first dimension decays into a pointer thereby becoming int**
}
```

#### Answer 3 (score 40)
A modification to shengy's first suggestion, you can use templates to make the function accept a multi-dimensional array variable (instead of storing an array of pointers that have to be managed and deleted):  

```c++
template <size_t size_x, size_t size_y>
void func(double (&arr)[size_x][size_y])
{
    printf("%p\n", &arr);
}

int main()
{
    double a1[10][10];
    double a2[5][5];

    printf("%p\n%p\n\n", &a1, &a2);
    func(a1);
    func(a2);

    return 0;
}
```

The print statements are there to show that the arrays are getting passed by reference (by displaying the variables' addresses)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: Fastest way to check if a file exist using standard C++/C++11/C? (score [550079](https://stackoverflow.com/q/12774207) in 2017)

#### Question
I would like to find the fastest way to check if a file exist in standard C++11, C++, or C. I have thousands of files and before doing something on them I need to check if all of them exist. What can I write instead of `/* SOMETHING */` in the following function?    

```c++
inline bool exist(const std::string& name)
{
    /* SOMETHING */
}
```

#### Answer accepted (score 694)
Well I threw together a test program that ran each of these methods 100,000 times, half on files that existed and half on files that didn't.  

```c++
#include <sys/stat.h>
#include <unistd.h>
#include <string>
#include <fstream>

inline bool exists_test0 (const std::string& name) {
    ifstream f(name.c_str());
    return f.good();
}

inline bool exists_test1 (const std::string& name) {
    if (FILE *file = fopen(name.c_str(), "r")) {
        fclose(file);
        return true;
    } else {
        return false;
    }   
}

inline bool exists_test2 (const std::string& name) {
    return ( access( name.c_str(), F_OK ) != -1 );
}

inline bool exists_test3 (const std::string& name) {
  struct stat buffer;   
  return (stat (name.c_str(), &buffer) == 0); 
}
```

Results for total time to run the 100,000 calls averaged over 5 runs,  

```c++
Method exists_test0 (ifstream): **0.485s**
Method exists_test1 (FILE fopen): **0.302s**
Method exists_test2 (posix access()): **0.202s**
Method exists_test3 (posix stat()): **0.134s**
```

The `stat()` function provided the best performance on my system (Linux, compiled with `g++`), with a standard `fopen` call being your best bet if you for some reason refuse to use POSIX functions.  

#### Answer 2 (score 118)
Remark : in C++14 and as soon as the <a href="http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n4099.html" rel="noreferrer">filesystem TS</a> will be finished and adopted, the solution will be to use:  

```c++
std::experimental::filesystem::exists("helloworld.txt");
```

and since C++17, only:  

```c++
std::filesystem::exists("helloworld.txt");
```

#### Answer 3 (score 104)
I use this piece of code, it works OK with me so far. This does not use many fancy features of C++:  

```c++
bool is_file_exist(const char *fileName)
{
    std::ifstream infile(fileName);
    return infile.good();
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: What is a segmentation fault? (score [539500](https://stackoverflow.com/q/2346806) in 2016)

#### Question
What is a segmentation fault? Is it different in C and C++? How are segmentation faults and dangling pointers related?  

#### Answer accepted (score 610)
Segmentation fault is a specific kind of error caused by accessing memory that “does not belong to you.” It’s a helper mechanism that keeps you from corrupting the memory and introducing hard-to-debug memory bugs. Whenever you get a segfault you know you are doing something wrong with memory – accessing variable that has already been freed, writing to a read-only portion of the memory, etc. Segmentation fault is essentially the same in most languages that let you mess with the memory management, there is no principial difference between segfaults in C and C++.  

There are many ways to get a segfault, at least in the lower-level languages such as C(++). A common way to get a segfault is to dereference a null pointer:  

```c++
int *p = NULL;
*p = 1;
```

Another segfault happens when you try to write to a portion of memory that was marked as read-only:  

```c++
char *str = "Foo"; // Compiler marks the constant string as read-only
*str = 'b'; // Which means this is illegal and results in a segfault
```

Dangling pointer points to a thing that does not exist any more, like here:  

```c++
char *p = NULL;
{
    char c;
    p = &c;
}
// Now p is dangling
```

The pointer `p` dangles because it points to character variable `c` that ceased to exist after the block ended. And when you try to dereference dangling pointer (like `*p='A'`), you would probably get a segfault.  

#### Answer 2 (score 106)
It would be worth noting that segmentation fault isn't caused by directly accessing another process memory (this is what I'm hearing sometimes), as it is simply not possible. With virtual memory every process has its own virtual address space and there is no way to access another one using any value of pointer. Exception to this can be shared libraries which are same physical address space mapped to (possibly) different virtual addresses and kernel memory which is even mapped in the same way in every process (to avoid TLB flushing on syscall, I think). And things like shmat ;) - these are what I count as 'indirect' access. One can, however, check that they are usually located long way from process code and we are usually able to access them (this is why they are there, nevertheless accessing them in a improper way will produce segmentation fault).  

Still, segmentation fault can occur in case of accessing our own (process) memory in improper way (for instance trying to write to non-writable space). But the most common reason for it is the access to the part of the virtual address space that is <em>not mapped</em> to physical one at all.  

And all of this with respect to virtual memory systems.  

#### Answer 3 (score 33)
A segmentation fault is caused by a request for a page that the process does not have listed in its descriptor table, or an invalid request for a page that it does have listed (e.g. a write request on a read-only page).  

A dangling pointer is a pointer that may or may not point to a valid page, but does point to an "unexpected" segment of memory.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: What is an unsigned char? (score [539232](https://stackoverflow.com/q/75191) in 2016)

#### Question
In C/C++, what an `unsigned char` is used for? How is it different from a regular `char`?  

#### Answer accepted (score 523)
In C++, there are three <em>distinct</em> character types:  

<ul>
<li>`char`</li>
<li>`signed char`</li>
<li>`unsigned char`</li>
</ul>

If you are using character types for <em>text</em>, use the unqualified `char`:  

<ul>
<li>it is the type of character literals like `'a'` or `'0'`.</li>
<li>it is the type that makes up C strings like `"abcde"`</li>
</ul>

It also works out as a number value, but it is unspecified whether that value is treated as signed or unsigned. Beware character comparisons through inequalities - although if you limit yourself to ASCII (0-127) you're just about safe.  

If you are using character types as <em>numbers</em>, use:  

<ul>
<li>`signed char`, which gives you <em>at least</em> the -127 to 127 range. (-128 to 127 is common)</li>
<li>`unsigned char`, which gives you <em>at least</em> the 0 to 255 range.</li>
</ul>

"At least", because the C++ standard only gives the minimum range of values that each numeric type is required to cover. `sizeof (char)` is required to be 1 (i.e. one byte), but a byte could in theory be for example 32 bits. <strong>`sizeof` would still be report its size as `1`</strong> - meaning that you <em>could</em> have `sizeof (char) == sizeof (long) == 1`.  

#### Answer 2 (score 84)
This is implementation dependent, as the C standard does NOT define the signed-ness of `char`.  Depending on the platform, char may be `signed` or `unsigned`, so you need to explicitly ask for `signed char` or `unsigned char` if your implementation depends on it.  Just use `char` if you intend to represent characters from strings, as this will match what your platform puts in the string.  

The difference between `signed char` and `unsigned char` is as you'd expect.  On most platforms, `signed char` will be an 8-bit two's complement number ranging from `-128` to `127`, and `unsigned char` will be an 8-bit unsigned integer (`0` to `255`).  Note the standard does NOT require that `char` types have 8 bits, only that `sizeof(char)` return `1`.  You can get at the number of bits in a char with `CHAR_BIT` in `limits.h`.  There are few if any platforms today where this will be something other than `8`, though.  

There is a nice summary of this issue <a href="http://www.arm.linux.org.uk/docs/faqs/signedchar.php" rel="noreferrer">here</a>.  

As others have mentioned since I posted this, you're better off using `int8_t` and `uint8_t` if you really want to represent small integers.  

#### Answer 3 (score 34)
Because i feel it's really called for, i just want to state some rules of C and C++ (they are the same in this regard). First, <em>all bits</em> of `unsigned char` participate in determining the value if any unsigned char object. Second, `unsigned char` is explicitly stated unsigned.  

Now, i had a discussion with someone about what happens when you convert the value `-1` of type int to `unsigned char`. He refused the idea that the resulting `unsigned char` has all its bits set to 1, because he was worried about sign representation. But he don't have to. It's immediately following out of this rule that the conversion does what is intended:  

<blockquote>
  <p>If the new type is unsigned, the value is converted by repeatedly adding or
  subtracting one more than the maximum value that can be represented in the new type
  until the value is in the range of the new type. (`6.3.1.3p2` in a C99 draft)</p>
</blockquote>

That's a mathematical description. C++ describes it in terms of modulo calculus, which yields to the same rule. Anyway, what is <em>not</em> guaranteed is that all bits in the integer `-1` are one before the conversion. So, what do we have so we can claim that the resulting `unsigned char` has all its `CHAR_BIT` bits turned to 1?  

<ol>
<li>All bits participate in determining its value - that is, no padding bits occur in the object. </li>
<li>Adding only one time `UCHAR_MAX+1` to `-1` will yield a value in range, namely `UCHAR_MAX`</li>
</ol>

That's enough, actually! So whenever you want to have an `unsigned char` having all its bits one, you do  

```c++
unsigned char c = (unsigned char)-1;
```

It also follows that a conversion is <em>not</em> just truncating higher order bits. The fortunate event for <em>two's complement</em> is that it is just a truncation there, but the same isn't necessarily true for other sign representations.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: What is the difference between #include <filename> and #include "filename"? (score [537618](https://stackoverflow.com/q/21593) in 2016)

#### Question
In the C and C++ programming languages, what is the difference between using angle brackets and using quotes in an `include` statement, as follows?  

<ol>
<li>`#include &lt;filename&gt;` </li>
<li>`#include "filename"`</li>
</ol>

#### Answer 2 (score 1283)
In practice, the difference is in the location where the preprocessor searches for the included file.   

For `#include &lt;filename&gt;` the preprocessor searches in an implementation dependent manner, normally in search directories pre-designated by the compiler/IDE. This method is normally used to include standard library header files.  

For `#include "filename"` the preprocessor searches first in the same directory as the file containing the directive, and then follows the search path used for the `#include &lt;filename&gt;` form. This method is normally used to include programmer-defined header files.  

A more complete description is available in the GCC <a href="https://gcc.gnu.org/onlinedocs/cpp/Search-Path.html" rel="noreferrer">documentation on search paths</a>.  

#### Answer 3 (score 674)
The only way to know is to read your implementation's documentation.  

In <a href="http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf#page=182" rel="noreferrer">the C standard</a>, section 6.10.2, paragraphs 2 to 4 state:  

<blockquote>
  <ul>
  <li><p>A preprocessing directive of the form</p>

```c++
#include <h-char-sequence> new-line
```
  
  searches a sequence of implementation-defined places for a <strong>header</strong> identified uniquely by the specified sequence between the `&lt;` and `&gt;` delimiters, and causes the replacement of that directive by the entire contents of the <strong>header</strong>. How the places are specified or the header identified is implementation-defined.  </li>
  <li><p>A preprocessing directive of the form</p>

```c++
#include "q-char-sequence" new-line
```
  
  causes the replacement of that directive by the entire contents of the <strong>source file</strong> identified by the specified sequence between the `"` delimiters. The named <strong>source file</strong> is searched for in an implementation-defined manner. If this search is not supported, or if the search fails, the directive is reprocessed as if it read  

```c++
#include <h-char-sequence> new-line
```
  
  <p>with the identical contained sequence (including `&gt;` characters, if any) from the original
  directive.</p></li>
  <li><p>A preprocessing directive of the form</p>

```c++
#include pp-tokens new-line
```
  
  (that does not match one of the two previous forms) is permitted. The preprocessing tokens after `include` in the directive are processed just as in normal text. (Each identifier currently defined as a macro name is replaced by its replacement list of preprocessing tokens.) The directive resulting after all replacements shall match one of the two previous forms. The method by which a sequence of preprocessing tokens between a `&lt;` and a `&gt;` preprocessing token pair or a pair of `"` characters is combined into a single header name preprocessing token is implementation-defined.  </li>
  </ul>
  
  <h5>Definitions:</h3>
  
  <ul>
  <li><p>h-char: any member of the source character set except the new-line character and `&gt;`</p></li>
  <li><p>q-char: any member of the source character set except the new-line character and `"`</p></li>
  </ul>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: What is a smart pointer and when should I use one? (score [532699](https://stackoverflow.com/q/106508) in 2015)

#### Question
What is a smart pointer and when should I use one?  

#### Answer accepted (score 1827)
<strong>UPDATE</strong>  

This answer is rather old, and so describes what was 'good' at the time, which was smart pointers provided by the Boost library. Since C++11, the standard library has provided sufficient smart pointers types, and so you should favour the use of <a href="http://en.cppreference.com/w/cpp/memory/unique_ptr" rel="noreferrer">`std::unique_ptr`</a>, <a href="http://en.cppreference.com/w/cpp/memory/shared_ptr" rel="noreferrer">`std::shared_ptr`</a> and <a href="http://en.cppreference.com/w/cpp/memory/weak_ptr" rel="noreferrer">`std::weak_ptr`</a>.   

<p>There was also <a href="http://en.cppreference.com/w/cpp/memory/auto_ptr" rel="noreferrer">`std::auto_ptr`</a>. It was very much like a scoped pointer, except that it also had the "special" dangerous ability to be copied — which also unexpectedly transfers ownership.<br>
<strong>It was deprecated in C++11 and removed in C++17</strong>, so you shouldn't use it.</p>

```c++
std::auto_ptr<MyObject> p1 (new MyObject());
std::auto_ptr<MyObject> p2 = p1; // Copy and transfer ownership. 
                                 // p1 gets set to empty!
p2->DoSomething(); // Works.
p1->DoSomething(); // Oh oh. Hopefully raises some NULL pointer exception.
```

<hr>

<strong>OLD ANSWER</strong>  

A smart pointer is a class that wraps a 'raw' (or 'bare') C++ pointer, to manage the lifetime of the object being pointed to. There is no single smart pointer type, but all of them try to abstract a raw pointer in a practical way.  

Smart pointers should be preferred over raw pointers. If you feel you need to use pointers (first consider if you <em>really</em> do), you would normally want to use a smart pointer as this can alleviate many of the problems with raw pointers, mainly forgetting to delete the object and leaking memory.  

With raw pointers, the programmer has to explicitly destroy the object when it is no longer useful.  

```c++
// Need to create the object to achieve some goal
MyObject* ptr = new MyObject(); 
ptr->DoSomething(); // Use the object in some way
delete ptr; // Destroy the object. Done with it.
// Wait, what if DoSomething() raises an exception...?
```

A smart pointer by comparison defines a policy as to when the object is destroyed. You still have to create the object, but you no longer have to worry about destroying it.  

```c++
SomeSmartPtr<MyObject> ptr(new MyObject());
ptr->DoSomething(); // Use the object in some way.

// Destruction of the object happens, depending 
// on the policy the smart pointer class uses.

// Destruction would happen even if DoSomething() 
// raises an exception
```

The simplest policy in use involves the scope of the smart pointer wrapper object, such as implemented by <a href="http://www.boost.org/doc/libs/release/libs/smart_ptr/scoped_ptr.htm" rel="noreferrer">`boost::scoped_ptr`</a> or <a href="http://en.cppreference.com/w/cpp/memory/unique_ptr" rel="noreferrer">`std::unique_ptr`</a>.   

```c++
void f()
{
    {
       std::unique_ptr<MyObject> ptr(new MyObject());
       ptr->DoSomethingUseful();
    } // ptr goes out of scope -- 
      // the MyObject is automatically destroyed.

    // ptr->Oops(); // Compile error: "ptr" not defined
                    // since it is no longer in scope.
}
```

Note that `std::unique_ptr` instances cannot be copied. This prevents the pointer from being deleted multiple times (incorrectly). You can, however, pass references to it around to other functions you call.  

`std::unique_ptr`s are useful when you want to tie the lifetime of the object to a particular block of code, or if you embedded it as member data inside another object, the lifetime of that other object. The object exists until the containing block of code is exited, or until the containing object is itself destroyed.  

A more complex smart pointer policy involves reference counting the pointer. This does allow the pointer to be copied. When the last "reference" to the object is destroyed, the object is deleted. This policy is implemented by <a href="http://www.boost.org/doc/libs/release/libs/smart_ptr/shared_ptr.htm" rel="noreferrer">`boost::shared_ptr`</a> and <a href="http://en.cppreference.com/w/cpp/memory/shared_ptr" rel="noreferrer">`std::shared_ptr`</a>.  

```c++
void f()
{
    typedef std::shared_ptr<MyObject> MyObjectPtr; // nice short alias
    MyObjectPtr p1; // Empty

    {
        MyObjectPtr p2(new MyObject());
        // There is now one "reference" to the created object
        p1 = p2; // Copy the pointer.
        // There are now two references to the object.
    } // p2 is destroyed, leaving one reference to the object.
} // p1 is destroyed, leaving a reference count of zero. 
  // The object is deleted.
```

Reference counted pointers are very useful when the lifetime of your object is much more complicated, and is not tied directly to a particular section of code or to another object.  

There is one drawback to reference counted pointers — the possibility of creating a dangling reference:  

```c++
// Create the smart pointer on the heap
MyObjectPtr* pp = new MyObjectPtr(new MyObject())
// Hmm, we forgot to destroy the smart pointer,
// because of that, the object is never destroyed!
```

Another possibility is creating circular references:  

```c++
struct Owner {
   std::shared_ptr<Owner> other;
};

std::shared_ptr<Owner> p1 (new Owner());
std::shared_ptr<Owner> p2 (new Owner());
p1->other = p2; // p1 references p2
p2->other = p1; // p2 references p1

// Oops, the reference count of of p1 and p2 never goes to zero!
// The objects are never destroyed!
```

To work around this problem, both Boost and C++11 have defined a `weak_ptr` to define a weak (uncounted) reference to a `shared_ptr`.  

#### Answer 2 (score 264)
Here's a simple answer for these days of modern C++:  

<ul>
<li><strong>What is a smart pointer?</strong> <br>
It's a type whose values can be used like pointers, but which provides the additional feature of automatic memory management: When a smart pointer is no longer in use, the memory it points to is deallocated (see also <a href="http://en.wikipedia.org/wiki/Smart_pointer" rel="noreferrer">the more detailed definition on Wikipedia</a>).</li>
<li><strong>When should I use one?</strong> <br>
In code which involves tracking the ownership of a piece of memory, allocating or de-allocating; the smart pointer often saves you the need to do these things explicitly.</li>
<li><strong>But which smart pointer should I use in which of those cases?</strong> 

<ul>
<li>Use <a href="http://en.cppreference.com/w/cpp/memory/unique_ptr" rel="noreferrer">`std::unique_ptr`</a> when you don't intend to hold multiple references to the same object. For example, use it for a pointer to memory which gets allocated on entering some scope and de-allocated on exiting the scope.</li>
<li>Use <a href="http://en.cppreference.com/w/cpp/memory/shared_ptr" rel="noreferrer">`std::shared_ptr`</a> when you do want to refer to your object from multiple places - and do not want your object to be de-allocated until all these references are themselves gone.</li>
<li>Use <a href="http://en.cppreference.com/w/cpp/memory/weak_ptr" rel="noreferrer">`std::weak_ptr`</a> when you do want to refer to your object from multiple places - for those references for which it's ok to ignore and deallocate (so they'll just note the object is gone when you try to dereference).</li>
<li>Don't use the `boost::` smart pointers or `std::auto_ptr` except in special cases which you can read up on if you must.</li>
</ul></li>
<li><strong>Hey, I didn't ask which one to use!</strong> <br>
Ah, but you really wanted to, admit it.</li>
<li><strong>So when should I use regular pointers then?</strong> <br>
Mostly in code that is oblivious to memory ownership. This would typically be in functions which get a pointer from someplace else and do not allocate nor de-allocate, and do not store a copy of the pointer which outlasts their execution.</li>
</ul>

#### Answer 3 (score 108)
<a href="http://en.wikipedia.org/wiki/Smart_pointer" rel="noreferrer">Smart pointer</a> is a pointer-like type with some additional functionality, e.g. automatic memory deallocation, reference counting etc.  

Small intro is available on page <a href="http://ootips.org/yonat/4dev/smart-pointers.html" rel="noreferrer">Smart Pointers - What, Why, Which?</a>.  

One of the simple smart-pointer type is <a href="http://en.cppreference.com/w/cpp/memory/auto_ptr" rel="noreferrer">`std::auto_ptr`</a> (chapter 20.4.5 of C++ standard), which allows to deallocate memory automatically when it out of scope and which is more robust than simple pointer usage when exceptions are thrown, although less flexible.  

Another convenient type is <a href="http://www.boost.org/doc/libs/1_36_0/libs/smart_ptr/shared_ptr.htm" rel="noreferrer">`boost::shared_ptr`</a> which implements reference counting and automatically deallocates memory when no references to object remains. This helps avoiding memory leaks and is easy to use to implement <a href="http://en.wikipedia.org/wiki/Resource_Acquisition_Is_Initialization" rel="noreferrer">RAII</a>.  

<p>Subject is covered in depth in book <a href="https://rads.stackoverflow.com/amzn/click/com/0201734842" rel="noreferrer" rel="nofollow noreferrer">"C++ Templates: The Complete Guide" by David Vandevoorde, Nicolai M. Josuttis</a>, chapter Chapter 20. Smart Pointers.
Some topics covered:</p>

<ul>
<li>Protecting Against Exceptions</li>
<li>Holders, (note, <a href="http://en.cppreference.com/w/cpp/memory/auto_ptr" rel="noreferrer">std::auto_ptr</a> is implementation of such type of smart pointer)</li>
<li><a href="http://en.wikipedia.org/wiki/Resource_acquisition_is_initialization" rel="noreferrer">Resource Acquisition Is Initialization</a> (This is frequently used for exception-safe resource management in C++)</li>
<li>Holder Limitations</li>
<li><a href="http://en.wikipedia.org/wiki/Reference_counting" rel="noreferrer">Reference Counting</a></li>
<li>Concurrent Counter Access</li>
<li>Destruction and Deallocation</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: How do I tokenize a string in C++? (score [529167](https://stackoverflow.com/q/53849) in 2013)

#### Question
Java has a convenient split method:  

```c++
String str = "The quick brown fox";
String[] results = str.split(" ");
```

Is there an easy way to do this in C++?  

#### Answer accepted (score 139)
Your simple case can easily be built using the <a href="http://en.cppreference.com/w/cpp/string/basic_string/find" rel="noreferrer">`std::string::find`</a> method. However, take a look at <a href="https://www.boost.org/doc/libs/1_70_0/libs/tokenizer/doc/tokenizer.htm" rel="noreferrer">Boost.Tokenizer</a>. It's great. Boost generally has some very cool string tools.  

#### Answer 2 (score 187)
The <a href="http://www.boost.org/doc/libs/1_36_0/libs/tokenizer/index.html" rel="noreferrer">Boost tokenizer</a> class can make this sort of thing quite simple:  

```c++
#include <iostream>
#include <string>
#include <boost/foreach.hpp>
#include <boost/tokenizer.hpp>

using namespace std;
using namespace boost;

int main(int, char**)
{
    string text = "token, test   string";

    char_separator<char> sep(", ");
    tokenizer< char_separator<char> > tokens(text, sep);
    BOOST_FOREACH (const string& t, tokens) {
        cout << t << "." << endl;
    }
}
```

Updated for C++11:  

```c++
#include <iostream>
#include <string>
#include <boost/tokenizer.hpp>

using namespace std;
using namespace boost;

int main(int, char**)
{
    string text = "token, test   string";

    char_separator<char> sep(", ");
    tokenizer<char_separator<char>> tokens(text, sep);
    for (const auto& t : tokens) {
        cout << t << "." << endl;
    }
}
```

#### Answer 3 (score 168)
Here's a real simple one:  

```c++
#include <vector>
#include <string>
using namespace std;

vector<string> split(const char *str, char c = ' ')
{
    vector<string> result;

    do
    {
        const char *begin = str;

        while(*str != c && *str)
            str++;

        result.push_back(string(begin, str));
    } while (0 != *str++);

    return result;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: What does "dereferencing" a pointer mean? (score [519585](https://stackoverflow.com/q/4955198) in 2017)

#### Question
Please include an example with the explanation.  

#### Answer accepted (score 676)
<h5>Reviewing the basic terminology</h2>

It's <em>usually</em> good enough - unless you're programming assembly - to envisage a <strong><em>pointer</em></strong> containing a numeric memory address, with 1 referring to the second byte in the process's memory, 2 the third, 3 the fourth and so on....  

<ul>
<li>What happened to 0 and the first byte?  Well, we'll get to that later - see <em>null pointers</em> below.</li>
<li>For a more accurate definition of what pointers store, and how memory and addresses relate, see <em>"More about memory addresses, and why you probably don't need to know"</em>.</li>
</ul>

When you want to access the data/value in the memory that the pointer points to - the contents of the address with that numerical index - then you <strong><em>dereference</em></strong> the pointer.  

Different computer languages have different notations to tell the compiler or interpreter that you're now interested in the pointed-to value - I focus below on C and C++.  

<h5>A pointer scenario</h2>

Consider in C, given a pointer such as `p` below...  

```c++
const char* p = "abc";
```

...four bytes with the numerical values used to encode the letters 'a', 'b', 'c', and a 0 byte to denote the end of the textual data, are stored somewhere in memory and the numerical address of that data is stored in `p`.  

For example, if the string literal happened to be at address 0x1000 and `p` a 32-bit pointer at 0x2000, the memory content would be:  

```c++
Memory Address (hex)    Variable name    Contents
1000                                     'a' == 97 (ASCII)
1001                                     'b' == 98
1002                                     'c' == 99
1003                                     0
...
2000-2003               p                1000 hex
```

Note that there is no variable name/identifier for address 0x1000, but we can indirectly refer to the string literal using a pointer storing its address: `p`.  

<h5>Dereferencing the pointer</h2>

To refer to the characters `p` points to, we dereference `p` using one of these notations (again, for C):  

```c++
assert(*p == 'a');  // The first character at address p will be 'a'
assert(p[1] == 'b'); // p[1] actually dereferences a pointer created by adding
                     // p and 1 times the size of the things to which p points:
                     // In this case they're char which are 1 byte in C...
assert(*(p + 1) == 'b');  // Another notation for p[1]
```

You can also move pointers through the pointed-to data, dereferencing them as you go:  

```c++
++p;  // Increment p so it's now 0x1001
assert(*p == 'b');  // p == 0x1001 which is where the 'b' is...
```

If you have some data that can be written to, then you can do things like this:  

```c++
int x = 2;
int* p_x = &x;  // Put the address of the x variable into the pointer p_x
*p_x = 4;       // Change the memory at the address in p_x to be 4
assert(x == 4); // Check x is now 4
```

Above, you must have known at compile time that you would need a variable called `x`, and the code asks the compiler to arrange where it should be stored, ensuring the address will be available via `&amp;x`.  

<h5>Dereferencing and accessing a structure data member</h2>

In C, if you have a variable that is a pointer to a structure with data members, you can access those members using the `-&gt;` dereferencing operator:  

```c++
typedef struct X { int i_; double d_; } X;
X x;
X* p = &x;
p->d_ = 3.14159;  // Dereference and access data member x.d_
(*p).d_ *= -1;    // Another equivalent notation for accessing x.d_
```

<h5>Multi-byte data types</h2>

To use a pointer, a computer program also needs some insight into the type of data that is being pointed at - if that data type needs more than one byte to represent, then the pointer normally points to the lowest-numbered byte in the data.  

So, looking at a slightly more complex example:  

```c++
double sizes[] = { 10.3, 13.4, 11.2, 19.4 };
double* p = sizes;
assert(p[0] == 10.3);  // Knows to look at all the bytes in the first double value
assert(p[1] == 13.4);  // Actually looks at bytes from address p + 1 * sizeof(double)
                       // (sizeof(double) is almost always eight bytes)
assert(++p);           // Advance p by sizeof(double)
assert(*p == 13.4);    // The double at memory beginning at address p has value 13.4
*(p + 2) = 29.8;       // Change sizes[3] from 19.4 to 29.8
                       // Note: earlier ++p and + 2 here => sizes[3]
```

<h5>Pointers to dynamically allocated memory</h2>

Sometimes you don't know how much memory you'll need until your program is running and sees what data is thrown at it... then you can dynamically allocate memory using `malloc`. It is common practice to store the address in a pointer...  

```c++
int* p = malloc(sizeof(int)); // Get some memory somewhere...
*p = 10;            // Dereference the pointer to the memory, then write a value in
fn(*p);             // Call a function, passing it the value at address p
(*p) += 3;          // Change the value, adding 3 to it
free(p);            // Release the memory back to the heap allocation library
```

In C++, memory allocation is normally done with the `new` operator, and deallocation with `delete`:  

```c++
int* p = new int(10); // Memory for one int with initial value 10
delete p;

p = new int[10];      // Memory for ten ints with unspecified initial value
delete[] p;

p = new int[10]();    // Memory for ten ints that are value initialised (to 0)
delete[] p;
```

See also <em>C++ smart pointers</em> below.  

<h5>Losing and leaking addresses</h2>

Often a pointer may be the only indication of where some data or buffer exists in memory. If ongoing use of that data/buffer is needed, or the ability to call `free()` or `delete` to avoid leaking the memory, then the programmer must operate on a copy of the pointer...  

```c++
const char* p = asprintf("name: %s", name);  // Common but non-Standard printf-on-heap

// Replace non-printable characters with underscores....
for (const char* q = p; *q; ++q)
    if (!isprint(*q))
        *q = '_';

printf("%s\n", p); // Only q was modified
free(p);
```

...or carefully orchestrate reversal of any changes...  

```c++
const size_t n = ...;
p += n;
...
p -= n;  // Restore earlier value...
```

<h5>C++ smart pointers</h2>

In C++, it's best practice to use <a href="http://en.wikipedia.org/wiki/Smart_pointer" rel="noreferrer">smart pointer</a> objects to store and manage the pointers, automatically deallocating them when the smart pointers' destructors run. Since C++11 the Standard Library provides two, <a href="http://en.cppreference.com/w/cpp/memory/unique_ptr" rel="noreferrer">`unique_ptr`</a> for when there's a single owner for an allocated object...  

```c++
{
    std::unique_ptr<T> p{new T(42, "meaning")};
    call_a_function(p);
    // The function above might throw, so delete here is unreliable, but...
} // p's destructor's guaranteed to run "here", calling delete
```

...and <a href="http://en.cppreference.com/w/cpp/memory/shared_ptr" rel="noreferrer">`shared_ptr`</a> for share ownership (using <a href="http://en.wikipedia.org/wiki/Reference_counting" rel="noreferrer">reference counting</a>)...  

```c++
{
    std::shared_ptr<T> p(new T(3.14, "pi"));
    number_storage.may_add(p); // Might copy p into its container
} // p's destructor will only delete the T if number_storage didn't copy
```

<h5>Null pointers</h2>

In C, `NULL` and `0` - and additionally in C++ `nullptr` - can be used to indicate that a pointer doesn't currently hold the memory address of a variable, and shouldn't be dereferenced or used in pointer arithmetic. For example:  

```c++
const char* p_filename = NULL; // Or "= 0", or "= nullptr" in C++
char c;
while ((c = getopt(argc, argv, "f:")) != EOF)
    switch (c) {
      case f: p_filename = optarg; break;
    }
if (p_filename)  // Only NULL converts to false
    ...   // Only get here if -f flag specified
```

In C and C++, just as inbuilt numeric types don't necessarily default to `0`, nor `bools` to `false`, pointers are not always set to `NULL`. All these are set to 0/false/NULL when they're `static` variables or (C++ only) direct or indirect member variables of static objects or their bases, or undergo zero initialisation (e.g. `new T();` and `new T(x, y, z);` perform zero-initialisation on T's members including pointers, whereas `new T;` does not).  

Further, when you assign `0`, `NULL` and `nullptr` to a pointer the bits in the pointer are not necessarily all reset: the pointer may not contain "0" at the hardware level, or refer to address 0 in your virtual address space. The compiler is allowed to store something else there if it has reason to, but whatever it does - if you come along and compare the pointer to `0`, `NULL`, `nullptr` or another pointer that was assigned any of those, the comparison must work as expected. So, below the source code at the compiler level, "NULL" is potentially a bit "magical" in the C and C++ languages...  

<h5>More about memory addresses, and why you probably don't need to know</h2>

More strictly, initialised pointers store a bit-pattern identifying either `NULL` or a (often <a href="http://en.wikipedia.org/wiki/Virtual_address_space" rel="noreferrer">virtual</a>) memory address.  

The simple case is where this is a numeric offset into the process's entire virtual address space; in more complex cases the pointer may be relative to some specific memory area, which the CPU may select based on CPU "segment" registers or some manner of segment id encoded in the bit-pattern, and/or looking in different places depending on the machine code instructions using the address.  

For example, an `int*` properly initialised to point to an `int` variable might - after casting to a `float*` - access a value in "GPU" memory quite distinct from the `int` variable, then once cast to a function pointer might refer to distinct memory holding the machine opcodes for the function.  

3GL programming languages like C and C++ tend to hide this complexity, such that:  

<ul>
<li><p>If the compiler gives you a pointer to a variable or function, you can dereference it freely (as long as the variable's not destructed/deallocated meanwhile) and it's the compiler's problem whether e.g. a particular CPU register needs to be restored beforehand, or a distinct machine code instruction used</p></li>
<li><p>If you get a pointer to an element in an array, you can use pointer arithmetic to move anywhere else in the array, or even to form an address one-past-the-end of the array that's legal to compare with other pointers to elements in the array (or that have similarly been moved by pointer arithmetic to the same one-past-the-end value); again in C and C++, it's up to the compiler to ensure this "just works"</p></li>
<li><p>Specific OS functions, e.g. shared memory mapping, may give you pointers, and they'll "just work" within the range of addresses that makes sense for them</p></li>
<li><p>Attempts to move legal pointers beyond these boundaries, or to cast arbitrary numbers to pointers, or use pointers cast to unrelated types, typically have <a href="http://en.wikipedia.org/wiki/Undefined_behavior" rel="noreferrer"><em>undefined behaviour</em></a>, so should be avoided in higher level libraries and applications, but code for OSes, device drivers, etc. may need to rely on behaviour left undefined by C or C++, that is nevertheless well defined by their specific hardware.</p></li>
</ul>

#### Answer 2 (score 90)
Dereferencing a pointer means getting the value that is stored in the memory location pointed by the pointer. The operator * is used to do this, and is called the dereferencing operator.  

```c++
int a = 10;
int* ptr = &a;

printf("%d", *ptr); // With *ptr I'm dereferencing the pointer. 
                    // Which means, I am asking the value pointed at by the pointer.
                    // ptr is pointing to the location in memory of the variable a.
                    // In a's location, we have 10. So, dereferencing gives this value.

// Since we have indirect control over a's location, we can modify its content using the pointer. This is an indirect way to access a.

 *ptr = 20;         // Now a's content is no longer 10, and has been modified to 20.
```

#### Answer 3 (score 16)
A pointer is a "reference" to a value.. much like a library call number is a reference to a book. "Dereferencing" the call number is physically going through and retrieving that book.  

```c++
int a=4 ;
int *pA = &a ;
printf( "The REFERENCE/call number for the variable `a` is %p\n", pA ) ;

// The * causes pA to DEREFERENCE...  `a` via "callnumber" `pA`.
printf( "%d\n", *pA ) ; // prints 4.. 
```

If the book isn't there, the librarian starts shouting, shuts the library down, and a couple of people are set to investigate the cause of a person going to find a book that isn't there.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: When should static_cast, dynamic_cast, const_cast and reinterpret_cast be used? (score [515678](https://stackoverflow.com/q/332030) in 2015)

#### Question
What are the proper uses of:  

<ul>
<li>`static_cast`</li>
<li>`dynamic_cast`</li>
<li>`const_cast`</li>
<li>`reinterpret_cast`</li>
<li>C-style cast `(type)value`</li>
<li>Function-style cast `type(value)`</li>
</ul>

How does one decide which to use in which specific cases?  

#### Answer accepted (score 2440)
<strong>`static_cast`</strong> is the first cast you should attempt to use. It does things like implicit conversions between types (such as `int` to `float`, or pointer to `void*`), and it can also call explicit conversion functions (or implicit ones). In many cases, explicitly stating `static_cast` isn't necessary, but it's important to note that the `T(something)` syntax is equivalent to `(T)something` and should be avoided (more on that later). A `T(something, something_else)` is safe, however, and guaranteed to call the constructor.  

`static_cast` can also cast through inheritance hierarchies. It is unnecessary when casting upwards (towards a base class), but when casting downwards it can be used as long as it doesn't cast through `virtual` inheritance. It does not do checking, however, and it is undefined behavior to `static_cast` down a hierarchy to a type that isn't actually the type of the object.  

<hr>

<strong>`const_cast`</strong> can be used to remove or add `const` to a variable; no other C++ cast is capable of removing it (not even `reinterpret_cast`). It is important to note that modifying a formerly `const` value is only undefined if the original variable is `const`; if you use it to take the `const` off a reference to something that wasn't declared with `const`, it is safe. This can be useful when overloading member functions based on `const`, for instance. It can also be used to add `const` to an object, such as to call a member function overload.  

`const_cast` also works similarly on `volatile`, though that's less common.  

<hr>

<strong>`dynamic_cast`</strong> is exclusively used for handling polymorphism. You can cast a pointer or reference to any polymorphic type to any other class type (a polymorphic type has at least one virtual function, declared or inherited). You can use it for more than just casting downwards – you can cast sideways or even up another chain. The `dynamic_cast` will seek out the desired object and return it if possible. If it can't, it will return `nullptr` in the case of a pointer, or throw `std::bad_cast` in the case of a reference.  

`dynamic_cast` has some limitations, though. It doesn't work if there are multiple objects of the same type in the inheritance hierarchy (the so-called 'dreaded diamond') and you aren't using `virtual` inheritance. It also can only go through public inheritance - it will always fail to travel through `protected` or `private` inheritance. This is rarely an issue, however, as such forms of inheritance are rare.  

<hr>

<strong>`reinterpret_cast`</strong> is the most dangerous cast, and should be used very sparingly. It turns one type directly into another — such as casting the value from one pointer to another, or storing a pointer in an `int`, or all sorts of other nasty things. Largely, the only guarantee you get with `reinterpret_cast` is that normally if you cast the result back to the original type, you will get the exact same value (but <strong><em>not</em></strong> if the intermediate type is smaller than the original type). There are a number of conversions that <strong>`reinterpret_cast`</strong> cannot do, too. It's used primarily for particularly weird conversions and bit manipulations, like turning a raw data stream into actual data, or storing data in the low bits of a pointer to aligned data.  

<hr>

<strong>C-style cast</strong> and <strong>function-style cast</strong> are casts using `(type)object` or `type(object)`, respectively, and are functionally equivalent. They are defined as the first of the following which succeeds:  

<ul>
<li>`const_cast`</li>
<li>`static_cast` (though ignoring access restrictions)</li>
<li>`static_cast` (see above), then `const_cast`</li>
<li>`reinterpret_cast`</li>
<li>`reinterpret_cast`, then `const_cast`</li>
</ul>

It can therefore be used as a replacement for other casts in some instances, but can be extremely dangerous because of the ability to devolve into a `reinterpret_cast`, and the latter should be preferred when explicit casting is needed, unless you are sure `static_cast` will succeed or `reinterpret_cast` will fail. Even then, consider the longer, more explicit option.  

C-style casts also ignore access control when performing a `static_cast`, which means that they have the ability to perform an operation that no other cast can. This is mostly a kludge, though, and in my mind is just another reason to avoid C-style casts.  

#### Answer 2 (score 315)
Use `dynamic_cast` for converting pointers/references within an inheritance hierarchy.  

Use `static_cast` for ordinary type conversions.  

Use `reinterpret_cast` for low-level reinterpreting of bit patterns.  Use with extreme caution.  

Use `const_cast` for casting away `const/volatile`.  Avoid this unless you are stuck using a const-incorrect API.  

#### Answer 3 (score 186)
<em>(A lot of theoretical and conceptual explanation has been given above)</em>   

Below are some of the <strong>practical examples</strong> when I used <strong>static_cast</strong>, <strong>dynamic_cast</strong>, <strong>const_cast</strong>, <strong>reinterpret_cast</strong>.  

(Also referes this to understand the explaination : <a href="http://www.cplusplus.com/doc/tutorial/typecasting/" rel="noreferrer">http://www.cplusplus.com/doc/tutorial/typecasting/</a>)  

<strong>static_cast :</strong>  

```c++
OnEventData(void* pData)

{
  ......

  //  pData is a void* pData, 

  //  EventData is a structure e.g. 
  //  typedef struct _EventData {
  //  std::string id;
  //  std:: string remote_id;
  //  } EventData;

  // On Some Situation a void pointer *pData
  // has been static_casted as 
  // EventData* pointer 

  EventData *evtdata = static_cast<EventData*>(pData);
  .....
}
```

<strong>dynamic_cast :</strong>  

```c++
void DebugLog::OnMessage(Message *msg)
{
    static DebugMsgData *debug;
    static XYZMsgData *xyz;

    if(debug = dynamic_cast<DebugMsgData*>(msg->pdata)){
        // debug message
    }
    else if(xyz = dynamic_cast<XYZMsgData*>(msg->pdata)){
        // xyz message
    }
    else/* if( ... )*/{
        // ...
    }
}
```

<strong>const_cast :</strong>  

```c++
// *Passwd declared as a const

const unsigned char *Passwd


// on some situation it require to remove its constness

const_cast<unsigned char*>(Passwd)
```

<strong>reinterpret_cast :</strong>  

```c++
typedef unsigned short uint16;

// Read Bytes returns that 2 bytes got read. 

bool ByteBuffer::ReadUInt16(uint16& val) {
  return ReadBytes(reinterpret_cast<char*>(&val), 2);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: Why do we need virtual functions in C++? (score [514757](https://stackoverflow.com/q/2391679) in 2017)

#### Question
I'm learning C++ and I'm just getting into virtual functions.  

From what I've read (in the book and online), virtual functions are functions in the base class that you can override in derived classes.  

But earlier in the book, when learning about basic inheritance, I was able to override base functions in derived classes without using `virtual`.  

So what am I missing here? I know there is more to virtual functions, and it seems to be important so I want to be clear on what it is exactly. I just can't find a straight answer online.  

#### Answer accepted (score 2588)
Here is how I understood not just what <a href="https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.3.0/com.ibm.zos.v2r3.cbclx01/cplr139.htm" rel="noreferrer">`virtual`</a> functions are, but why they're required:  

Let's say you have these two classes:  

```c++
class Animal
{
    public:
        void eat() { std::cout << "I'm eating generic food."; }
};

class Cat : public Animal
{
    public:
        void eat() { std::cout << "I'm eating a rat."; }
};
```

In your main function:  

```c++
Animal *animal = new Animal;
Cat *cat = new Cat;

animal->eat(); // Outputs: "I'm eating generic food."
cat->eat();    // Outputs: "I'm eating a rat."
```

So far so good, right? Animals eat generic food, cats eat rats, all without `virtual`.  

Let's change it a little now so that `eat()` is called via an intermediate function (a trivial function just for this example):  

```c++
// This can go at the top of the main.cpp file
void func(Animal *xyz) { xyz->eat(); }
```

Now our main function is:  

```c++
Animal *animal = new Animal;
Cat *cat = new Cat;

func(animal); // Outputs: "I'm eating generic food."
func(cat);    // Outputs: "I'm eating generic food."
```

Uh oh... we passed a Cat into `func()`, but it won't eat rats. Should you overload `func()` so it takes a `Cat*`? If you have to derive more animals from Animal they would all need their own `func()`.  

The solution is to make `eat()` from the `Animal` class a virtual function:  

```c++
class Animal
{
    public:
        virtual void eat() { std::cout << "I'm eating generic food."; }
};

class Cat : public Animal
{
    public:
        void eat() { std::cout << "I'm eating a rat."; }
};
```

Main:  

```c++
func(animal); // Outputs: "I'm eating generic food."
func(cat);    // Outputs: "I'm eating a rat."
```

Done.  

#### Answer 2 (score 622)
Without "virtual" you get "early binding". Which implementation of the method is used gets decided at compile time based on the type of the pointer that you call through.  

With "virtual" you get "late binding". Which implementation of the method is used gets decided at run time based on the type of the pointed-to object - what it was originally constructed as. This is not necessarily what you'd think based on the type of the pointer that points to that object.  

```c++
class Base
{
  public:
            void Method1 ()  {  std::cout << "Base::Method1" << std::endl;  }
    virtual void Method2 ()  {  std::cout << "Base::Method2" << std::endl;  }
};

class Derived : public Base
{
  public:
    void Method1 ()  {  std::cout << "Derived::Method1" << std::endl;  }
    void Method2 ()  {  std::cout << "Derived::Method2" << std::endl;  }
};

Base* obj = new Derived ();
  //  Note - constructed as Derived, but pointer stored as Base*

obj->Method1 ();  //  Prints "Base::Method1"
obj->Method2 ();  //  Prints "Derived::Method2"
```

<strong>EDIT</strong> - see <a href="https://stackoverflow.com/questions/10580/what-are-early-and-late-binding">this question</a>.  

Also - <a href="http://www.learncpp.com/cpp-tutorial/124-early-binding-and-late-binding/" rel="noreferrer">this tutorial</a> covers early and late binding in C++.  

#### Answer 3 (score 79)
You need at least 1 level of inheritance and a downcast to demonstrate it. Here is a very simple  example:  

```c++
class Animal
{        
    public: 
      // turn the following virtual modifier on/off to see what happens
      //virtual   
      std::string Says() { return "?"; }  
};

class Dog: public Animal
{
    public: std::string Says() { return "Woof"; }
};

void test()
{
    Dog* d = new Dog();
    Animal* a = d;       // refer to Dog instance with Animal pointer

    cout << d->Says();   // always Woof
    cout << a->Says();   // Woof or ?, depends on virtual
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: What is an undefined reference/unresolved external symbol error and how do I fix it? (score [514061](https://stackoverflow.com/q/12573816) in 2018)

#### Question
What are undefined reference/unresolved external symbol errors? What are common causes and how to fix/prevent them?  

<sub>Feel free to edit/add your own.</sub>  

#### Answer accepted (score 806)
Compiling a C++ program takes place in several steps, as specified by <strong>2.2</strong> <a href="https://stackoverflow.com/a/8834196/673730">(credits to Keith Thompson for the reference)</a>:  

<blockquote>
  The precedence among the syntax rules of translation is specified by the following phases <em>[see footnote]</em>.  
  
  <ol>
  <li>Physical source file characters are mapped, in an implementation-defined manner, to the basic source character set
  (introducing new-line characters for end-of-line indicators) if
  necessary. <em>[SNIP]</em></li>
  <li>Each instance of a backslash character (\) immediately followed by a new-line character is deleted, splicing physical source lines to
  form logical source lines. <em>[SNIP]</em></li>
  <li>The source file is decomposed into preprocessing tokens (2.5) and sequences of white-space characters (including comments). <em>[SNIP]</em></li>
  <li>Preprocessing directives are executed, macro invocations are expanded, and _Pragma unary operator expressions are executed. <em>[SNIP]</em></li>
  <li>Each source character set member in a character literal or a string literal, as well as each escape sequence and universal-character-name
  in a character literal or a non-raw string literal, is converted to
  the corresponding member of the execution character set; <em>[SNIP]</em></li>
  <li>Adjacent string literal tokens are concatenated.</li>
  <li>White-space characters separating tokens are no longer significant. Each preprocessing token is converted into a token. (2.7). The
  resulting tokens are syntactically and semantically analyzed and
  translated as a translation unit. <em>[SNIP]</em></li>
  <li>Translated translation units and instantiation units are combined as follows: <em>[SNIP]</em></li>
  <li><strong>All external entity references are resolved. Library components are linked to satisfy external references to entities not defined in the
  current translation. All such translator output is collected into a
  program image which contains information needed for execution in its
  execution environment.</strong> (emphasis mine)</li>
  </ol>
  
  <em>[footnote]</em> Implementations must behave as if these separate phases occur, although in practice different phases might be folded together.  
</blockquote>

The specified errors occur during this last stage of compilation, most commonly referred to as linking. It basically means that you compiled a bunch of implementation files into object files or libraries and now you want to get them to work together.  

Say you defined symbol `a` in `a.cpp`. Now, `b.cpp` <em>declared</em> that symbol and used it. Before linking, it simply assumes that that symbol was defined <em>somewhere</em>, but it doesn't yet care where. The linking phase is responsible for finding the symbol and correctly linking it to `b.cpp` (well, actually to the object or library that uses it).  

If you're using Microsoft Visual Studio, you'll see that projects generate `.lib` files. These contain a table of exported symbols, and a table of imported symbols. The imported symbols are resolved against the libraries you link against, and the exported symbols are provided for the libraries that use that `.lib` (if any).  

Similar mechanisms exist for other compilers/ platforms.  

Common error messages are `error LNK2001`, `error LNK1120`, `error LNK2019` for <strong>Microsoft Visual Studio</strong> and `undefined reference to` <em>symbolName</em> for <strong>GCC</strong>.  

The code:  

```c++
struct X
{
   virtual void foo();
};
struct Y : X
{
   void foo() {}
};
struct A
{
   virtual ~A() = 0;
};
struct B: A
{
   virtual ~B(){}
};
extern int x;
void foo();
int main()
{
   x = 0;
   foo();
   Y y;
   B b;
}
```

will generate the following errors with <strong>GCC</strong>:  

```c++
/home/AbiSfw/ccvvuHoX.o: In function `main':
prog.cpp:(.text+0x10): undefined reference to `x'
prog.cpp:(.text+0x19): undefined reference to `foo()'
prog.cpp:(.text+0x2d): undefined reference to `A::~A()'
/home/AbiSfw/ccvvuHoX.o: In function `B::~B()':
prog.cpp:(.text._ZN1BD1Ev[B::~B()]+0xb): undefined reference to `A::~A()'
/home/AbiSfw/ccvvuHoX.o: In function `B::~B()':
prog.cpp:(.text._ZN1BD0Ev[B::~B()]+0x12): undefined reference to `A::~A()'
/home/AbiSfw/ccvvuHoX.o:(.rodata._ZTI1Y[typeinfo for Y]+0x8): undefined reference to `typeinfo for X'
/home/AbiSfw/ccvvuHoX.o:(.rodata._ZTI1B[typeinfo for B]+0x8): undefined reference to `typeinfo for A'
collect2: ld returned 1 exit status
```

and similar errors with <strong>Microsoft Visual Studio</strong>:  

```c++
1>test2.obj : error LNK2001: unresolved external symbol "void __cdecl foo(void)" (?foo@@YAXXZ)
1>test2.obj : error LNK2001: unresolved external symbol "int x" (?x@@3HA)
1>test2.obj : error LNK2001: unresolved external symbol "public: virtual __thiscall A::~A(void)" (??1A@@UAE@XZ)
1>test2.obj : error LNK2001: unresolved external symbol "public: virtual void __thiscall X::foo(void)" (?foo@X@@UAEXXZ)
1>...\test2.exe : fatal error LNK1120: 4 unresolved externals
```

Common causes include:  

<ul>
<li><a href="https://stackoverflow.com/a/12574400/673730">Failure to link against appropriate libraries/object files or compile implementation files</a></li>
<li><a href="https://stackoverflow.com/a/12574403/673730">Declared and undefined variable or function.</a></li>
<li><a href="https://stackoverflow.com/a/12574407/673730">Common issues with class-type members</a></li>
<li><a href="https://stackoverflow.com/a/12574417/673730">Template implementations not visible.</a></li>
<li><a href="https://stackoverflow.com/a/12574420/673730">Symbols were defined in a C program and used in C++ code.</a></li>
<li><a href="https://stackoverflow.com/a/12574423/673730">Incorrectly importing/exporting methods/classes across modules/dll. (MSVS specific)</a></li>
<li><a href="https://stackoverflow.com/a/20358542/673730">Circular library dependency</a></li>
<li><a href="https://stackoverflow.com/questions/5259714/undefined-reference-to-winmain16/5260237#5260237">undefined reference to `WinMain@16'</a></li>
<li><a href="https://stackoverflow.com/a/24675715/1356926">Interdependent library order</a></li>
<li><a href="https://stackoverflow.com/questions/14364362/visualstudio-project-with-multiple-sourcefiles-of-the-same-name">Multiple source files of the same name</a></li>
<li><a href="https://stackoverflow.com/a/25744263/3747990">Mistyping or not including the .lib extension when using the `#pragma` (Microsoft Visual Studio)</a></li>
<li><a href="https://stackoverflow.com/a/35891188/3747990">Problems with template friends</a></li>
<li><a href="https://stackoverflow.com/a/36475406/3747990">Inconsistent `UNICODE` definitions</a></li>
</ul>

#### Answer 2 (score 169)
<h5>Class members:</h2>

<h5>A pure `virtual` destructor needs an implementation.</h3>

Declaring a destructor pure still requires you to define it (unlike a regular function):  

```c++
struct X
{
    virtual ~X() = 0;
};
struct Y : X
{
    ~Y() {}
};
int main()
{
    Y y;
}
//X::~X(){} //uncomment this line for successful definition
```

This happens because base class destructors are called when the object is destroyed implicitly, so a definition is required.      

<h5>`virtual` methods must either be implemented or defined as pure.</h3>

<p>This is similar to non-`virtual` methods with no definition, with the added reasoning that 
the pure declaration generates a dummy vtable and you might get the linker error without using the function:</p>

```c++
struct X
{
    virtual void foo();
};
struct Y : X
{
   void foo() {}
};
int main()
{
   Y y; //linker error although there was no call to X::foo
}
```

For this to work, declare `X::foo()` as pure:  

```c++
struct X
{
    virtual void foo() = 0;
};
```

<h5>Non-`virtual` class members</h3>

Some members need to be defined even if not used explicitly:  

```c++
struct A
{ 
    ~A();
};
```

The following would yield the error:  

```c++
A a;      //destructor undefined
```

The implementation can be inline, in the class definition itself:  

```c++
struct A
{ 
    ~A() {}
};
```

or outside:  

```c++
A::~A() {}
```

If the implementation is outside the class definition, but in a header, the methods have to be marked as `inline` to prevent a multiple definition.  

All used member methods need to be defined if used.  

<h5>A common mistake is forgetting to qualify the name:</h3>

```c++
struct A
{
   void foo();
};

void foo() {}

int main()
{
   A a;
   a.foo();
}
```

The definition should be  

```c++
void A::foo() {}
```

<h5>`static` data members must be defined outside the class in a <strong>single translation unit</strong>:</h3>

```c++
struct X
{
    static int x;
};
int main()
{
    int x = X::x;
}
//int X::x; //uncomment this line to define X::x
```

An initializer can be provided for a `static` `const` data member of integral or enumeration type within the class definition; however, odr-use of this member will still require a namespace scope definition as described above. C++11 allows initialization inside the class for all `static const` data members.  

#### Answer 3 (score 106)
<h5>Failure to link against appropriate libraries/object files or compile implementation files</h3>

<p>Commonly, each translation unit will generate an object file that contains the definitions of the symbols defined in that translation unit. 
To use those symbols, you have to link against those object files.</p>

Under <strong>gcc</strong> you would specify all object files that are to be linked together in the command line, or compile the implementation files together.  

```c++
g++ -o test objectFile1.o objectFile2.o -lLibraryName
```

The `libraryName` here is just the bare name of the library, without platform-specific additions. So e.g. on Linux library files are usually called `libfoo.so` but you'd only write `-lfoo`. On Windows that same file might be called `foo.lib`, but you'd use the same argument. You might have to add the directory where those files can be found using `-L‹directory›`. Make sure to not write a space after `-l` or `-L`.  

For <strong>XCode</strong>:  Add the User Header Search Paths -> add the Library Search Path -> drag and drop the actual library reference into the project folder.  

<p>Under <strong>MSVS</strong>, files added to a project automatically have their object files linked together and a `lib` file would be generated (in common usage). To use the symbols in a separate project, you'd 
need to include the `lib` files in the project settings. This is done in the Linker section of the project properties, in `Input -&gt; Additional Dependencies`. (the path to the `lib` file should be
added in `Linker -&gt; General -&gt; Additional Library Directories`) When using a third-party library that is provided with a `lib` file, failure to do so usually results in the error.</p>

It can also happen that you forget to add the file to the compilation, in which case the object file won't be generated. In <strong>gcc</strong> you'd add the files to the command line. In <strong>MSVS</strong> adding the file to the project will make it compile it automatically (albeit files can, manually, be individually excluded from the build).  

In Windows programming, the tell-tale sign that you did not link a necessary library is that the name of the unresolved symbol begins with `__imp_`. Look up the name of the function in the documentation, and it should say which library you need to use. For example, MSDN puts the information in a box at the bottom of each function in a section called "Library".  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: Struct Constructor in C++? (score [511554](https://stackoverflow.com/q/1127396) in 2014)

#### Question
Can a `struct` have a constructor in C++?  

I have been trying to solve this problem but I am not getting the syntax.  

#### Answer 2 (score 437)
In C++ the only difference between a `class` and a `struct` is that members and base classes are private by default in classes, whereas they are public by default in structs.   

So structs can have constructors, and the syntax is the same as for classes.  

#### Answer 3 (score 153)
```c++
struct TestStruct {
        int id;
        TestStruct() : id(42)
        {
        }
};
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: How to convert string to char array in C++? (score [499222](https://stackoverflow.com/q/13294067) in 2015)

#### Question
I would like to convert `string` to `char` array but not `char*`. I know how to convert string to `char*` (by using `malloc` or the way I posted it in my code) - but that's not what I want. I simply want to convert `string` to `char[size]` array. Is it possible?  

```c++
#include <iostream>
#include <string>
#include <stdio.h>
using namespace std;

int main()
{
    // char to string
    char tab[4];
    tab[0] = 'c';
    tab[1] = 'a';
    tab[2] = 't';
    tab[3] = '\0';
    string tmp(tab);
    cout << tmp << "\n";

    // string to char* - but thats not what I want

    char *c = const_cast<char*>(tmp.c_str());
    cout << c << "\n";

    //string to char
    char tab2[1024];
    // ?

    return 0;
}
```

#### Answer accepted (score 113)
Simplest way I can think of doing it is:  

```c++
string temp = "cat";
char tab2[1024];
strcpy(tab2, temp.c_str());
```

For safety, you might prefer:  

```c++
string temp = "cat";
char tab2[1024];
strncpy(tab2, temp.c_str(), sizeof(tab2));
tab2[sizeof(tab2) - 1] = 0;
```

or could be in this fashion:  

```c++
string temp = "cat";
char * tab2 = new char [temp.length()+1];
strcpy (tab2, temp.c_str());
```

#### Answer 2 (score 52)
Ok, i am shocked that no one really gave a good answer, now my turn. There are two cases;  

<ol>
<li><p>A <strong>constant char array</strong> is good enough for you so you go with, </p>

```c++
const char *array = tmp.c_str();
```</li>
<li><p>Or you <strong>need to modify</strong> the char array so constant is not ok, then just go with this </p>

```c++
char *array = &tmp[0];
```</li>
</ol>

Both of them are <strong>just assignment operations</strong> and most of the time that is just what you need, if you really need a new copy then follow other fellows answers.  

#### Answer 3 (score 16)
Easiest way to do it would be this  

```c++
std::string myWord = "myWord";
char myArray[myWord.size()+1];//as 1 char space for null is also required
strcpy(myArray, myWord.c_str());
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: convert a char* to std::string (score [498258](https://stackoverflow.com/q/1195675) in 2018)

#### Question
I need to use an `std::string` to store data retrieved by `fgets()`. To do this I need to convert the `char*` return value from `fgets()` into an `std::string` to store in an array. How can this be done?  

#### Answer accepted (score 332)
`std::string` has a constructor for this:  

```c++
const char *s = "Hello, World!";
std::string str(s);
```

Just make sure that your `char *` isn't `NULL`, or else the behavior is undefined.  

#### Answer 2 (score 114)
If you already know size of the char*, use this instead  

```c++
char* data = ...;
int size = ...;
std::string myString(data, size);
```

This doesn't use strlen.  

EDIT: If string variable already exists, use assign():  

```c++
std::string myString;
char* data = ...;
int size = ...;
myString.assign(data, size);
```

#### Answer 3 (score 28)
<blockquote>
  I need to use std::string to store data retrieved by fgets().  
</blockquote>

Why using `fgets()` when you are programming C++? Why not `std::getline()`?  

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: How to compile and run C/C++ in a Unix console/Mac terminal? (score [496686](https://stackoverflow.com/q/221185) in 2018)

#### Question
How can I compile/run C or C++ in Unix console or a Mac terminal?  

(I know it, forget it, and relearn it again. Time to write it down.)  

#### Answer accepted (score 173)
If it is a simple single source program:  

```c++
make foo
```

where the source file is foo.c or foo.cpp, etc.  

You dont even need a makefile. Make has enough built-in rules to build your source file into an executable of the same name, minus extension.  

Running the executable just built is the same as running any program - but you will most often need to specify the path to the executable as the shell will only search what is in `$PATH` to find executables, and most often that does not include the current directory (`.`).  

So to run the built executable `foo`:  

```c++
./foo
```

#### Answer 2 (score 107)
```c++
gcc main.cpp -o main.out  
./main.out
```

#### Answer 3 (score 67)
This is the command that works on all Unix machines... I use it on Linux/Ubuntu, but it works in OS&nbsp;X as well. Type the following command in <strong>Terminal.app</strong>.  

```c++
$ g++ -o lab21 iterative.cpp
```

`-o` is the letter O not zero  

`lab21` will be your executable file  

`iterative.cpp` is your c++ file  

After you run that command type the following in terminal to run your program:  

```c++
$ ./lab21
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Appending a vector to a vector (score [491976](https://stackoverflow.com/q/2551775) in 2016)

#### Question
Assuming I have 2 standard vectors:  

```c++
vector<int> a;
vector<int> b;
```

Let's also say the both have around 30 elements.  

<ul>
<li>How do I add the vector b to the end of vector a?</li>
</ul>

The dirty way would be iterating through b and adding each element via `vector&lt;int&gt;::push_back()`, though I wouldn't like to do that!  

#### Answer 2 (score 1107)
```c++
a.insert(a.end(), b.begin(), b.end());
```

or  

```c++
a.insert(std::end(a), std::begin(b), std::end(b));
```

The second variant is a more generically applicable solution, as `b` could also be an array. However, it requires C++11.  If you want to work with user-defined types, use ADL:  

```c++
using std::begin, std::end;
a.insert(end(a), begin(b), end(b));
```

#### Answer 3 (score 79)
```c++
std::copy (b.begin(), b.end(), std::back_inserter(a));
```

This can be used in case the items in vector a have no assignment operator (e.g. const member).  

In all other cases this solution is ineffiecent compared to the above insert solution.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: Difference between 'struct' and 'typedef struct' in C++? (score [489010](https://stackoverflow.com/q/612328) in )

#### Question
In C++, is there any difference between:  

```c++
struct Foo { ... };
```

and   

```c++
typedef struct { ... } Foo;
```

#### Answer accepted (score 1135)
In C++, there is only a subtle difference.  It's a holdover from C, in which it makes a difference.  

The C language standard (<a href="http://port70.net/~nsz/c/c89/c89-draft.txt" rel="noreferrer">C89 §3.1.2.3</a>, <a href="http://port70.net/~nsz/c/c99/n1256.html#6.2.3" rel="noreferrer">C99 §6.2.3</a>, and <a href="http://port70.net/~nsz/c/c11/n1570.html#6.2.3" rel="noreferrer">C11 §6.2.3</a>) mandates separate namespaces for different categories of identifiers, including <em>tag identifiers</em> (for `struct`/`union`/`enum`) and <em>ordinary identifiers</em> (for `typedef` and other identifiers).   

If you just said:  

```c++
struct Foo { ... };
Foo x;
```

you would get a compiler error, because `Foo` is only defined in the tag namespace.   

You'd have to declare it as:  

```c++
struct Foo x;
```

Any time you want to refer to a `Foo`, you'd always have to call it a `struct Foo`.  This gets annoying fast, so you can add a `typedef`:  

```c++
struct Foo { ... };
typedef struct Foo Foo;
```

Now `struct Foo` (in the tag namespace) and just plain `Foo` (in the ordinary identifier namespace) both refer to the same thing, and you can freely declare objects of type `Foo` without the `struct` keyword.  

<hr>

The construct:  

```c++
typedef struct Foo { ... } Foo;
```

is just an abbreviation for the declaration and `typedef`.  

<hr>

Finally,  

```c++
typedef struct { ... } Foo;
```

declares an anonymous structure and creates a `typedef` for it.  Thus, with this construct, it doesn't have a name in the tag namespace, only a name in the typedef namespace.  This means it also cannot be forward-declared.  <em>If you want to make a forward declaration, you have to give it a name in the tag namespace</em>.  

<hr>

In C++, all `struct`/`union`/`enum`/`class` declarations act like they are implicitly `typedef`'ed, as long as the name is not hidden by another declaration with the same name.  See <a href="https://stackoverflow.com/questions/612328/difference-between-struct-and-typedef-struct-in-c/612476#612476">Michael Burr's answer</a> for the full details.  

#### Answer 2 (score 220)
In <a href="http://drdobbs.com/article/print?articleId=184403396" rel="noreferrer">this DDJ article</a>, Dan Saks explains one small area where bugs can creep through if you do not typedef your structs (and classes!):  

<blockquote>
  <p>If you want, you can imagine that C++
  generates a typedef for every tag
  name, such as</p>

```c++
typedef class string string;
```
  
  <p>Unfortunately, this is not entirely
  accurate. I wish it were that simple,
  but it's not. C++ can't generate such
  typedefs for structs, unions, or enums
  without introducing incompatibilities
  with C.</p>
  
  <p>For example, suppose a C program
  declares both a function and a struct
  named status:</p>

```c++
int status(); struct status;
```
  
  <p>Again, this may be bad practice, but
  it is C. In this program, status (by
  itself) refers to the function; struct
  status refers to the type.</p>
  
  <p>If C++ did automatically generate
  typedefs for tags, then when you
  compiled this program as C++, the
  compiler would generate:</p>

```c++
typedef struct status status;
```
  
  <p>Unfortunately, this type name would
  conflict with the function name, and
  the program would not compile. That's
  why C++ can't simply generate a
  typedef for each tag.</p>
  
  <p>In C++, tags act just like typedef
  names, except that a program can
  declare an object, function, or
  enumerator with the same name and the
  same scope as a tag. In that case, the
  object, function, or enumerator name
  hides the tag name. The program can
  refer to the tag name only by using
  the keyword class, struct, union, or
  enum (as appropriate) in front of the
  tag name. A type name consisting of
  one of these keywords followed by a
  tag is an elaborated-type-specifier.
  For instance, struct status and enum
  month are elaborated-type-specifiers. </p>
  
  Thus, a C program that contains both:  

```c++
int status(); struct status;
```
  
  <p>behaves the same when compiled as C++.
  The name status alone refers to the
  function. The program can refer to the
  type only by using the
  elaborated-type-specifier struct
  status.</p>
  
  <p>So how does this allow bugs to creep
  into programs? Consider the program in
  <a href="http://drdobbs.com/cpp/184403396?pgno=1" rel="noreferrer">Listing 1</a>. This program defines a
  class foo with a default constructor,
  and a conversion operator that
  converts a foo object to char const *.
  The expression</p>

```c++
p = foo();
```
  
  <p>in main should construct a foo object
  and apply the conversion operator. The
  subsequent output statement</p>

```c++
cout << p << '\n';
```
  
  <p>should display class foo, but it
  doesn't. It displays function foo.</p>
  
  <p>This surprising result occurs because
  the program includes header lib.h
  shown in <a href="http://drdobbs.com/cpp/184403396?pgno=2" rel="noreferrer">Listing 2</a>. This header
  defines a function also named foo. The
  function name foo hides the class name
  foo, so the reference to foo in main
  refers to the function, not the class.
  main can refer to the class only by
  using an elaborated-type-specifier, as
  in</p>

```c++
p = class foo();
```
  
  <p>The way to avoid such confusion
  throughout the program is to add the
  following typedef for the class name
  foo:</p>

```c++
typedef class foo foo;
```
  
  <p>immediately before or after the class
  definition. This typedef causes a
  conflict between the type name foo and
  the function name foo (from the
  library) that will trigger a
  compile-time error.</p>
  
  <p>I know of no one who actually writes
  these typedefs as a matter of course.
  It requires a lot of discipline. Since
  the incidence of errors such as the
  one in <a href="http://drdobbs.com/cpp/184403396?pgno=1" rel="noreferrer">Listing 1</a> is probably pretty
  small, you many never run afoul of
  this problem. But if an error in your
  software might cause bodily injury,
  then you should write the typedefs no
  matter how unlikely the error. </p>
  
  <p>I can't imagine why anyone would ever
  want to hide a class name with a
  function or object name in the same
  scope as the class. The hiding rules
  in C were a mistake, and they should
  not have been extended to classes in
  C++. Indeed, you can correct the
  mistake, but it requires extra
  programming discipline and effort that
  should not be necessary.</p>
</blockquote>

#### Answer 3 (score 62)
One more important difference: `typedef`s cannot be forward declared. So for the `typedef` option you must `#include` the file containing the `typedef`, meaning everything that `#include`s your `.h` also includes that file whether it directly needs it or not, and so on. It can definitely impact your build times on larger projects.  

Without the `typedef`, in some cases you can just add a forward declaration of `struct Foo;` at the top of your `.h` file, and only `#include` the struct definition in your `.cpp` file.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: How to find if a given key exists in a C++ std::map (score [487253](https://stackoverflow.com/q/1939953) in 2017)

#### Question
I'm trying to check if a given key is in a map and somewhat can't do it:  

```c++
typedef map<string,string>::iterator mi;
map<string, string> m;
m.insert(make_pair("f","++--"));
pair<mi,mi> p = m.equal_range("f");//I'm not sure if equal_range does what I want
cout << p.first;//I'm getting error here
```

so how can I print what is in p?  

#### Answer accepted (score 637)
Use <a href="http://en.cppreference.com/w/cpp/container/map/find" rel="noreferrer">`map::find`</a>  

```c++
if ( m.find("f") == m.end() ) {
  // not found
} else {
  // found
}
```

#### Answer 2 (score 285)
To check if a particular key in the map exists, use the `count` member function in one of the following ways:  

```c++
m.count(key) > 0
m.count(key) == 1
m.count(key) != 0
```

The <a href="http://www.cplusplus.com/reference/map/map/find/" rel="noreferrer">documentation</a> for `map::find` says: "Another member function, `map::count`, can be used to just check whether a particular key exists."  

The <a href="http://www.cplusplus.com/reference/map/map/count/" rel="noreferrer">documentation</a> for `map::count` says: "Because all elements in a map container are unique, the function can only return 1 (if the element is found) or zero (otherwise)."  

To retrieve a value from the map via a key that you know to exist, use <a href="http://www.cplusplus.com/reference/map/map/at/" rel="noreferrer">map::at</a>:  

```c++
value = m.at(key)
```

Unlike <a href="http://www.cplusplus.com/reference/map/map/operator%5B%5D/" rel="noreferrer">map::operator[]</a>, `map::at` will not create a new key in the map if the specified key does not exist.  

#### Answer 3 (score 35)
You can use `.find()`:  

```c++
map<string,string>::iterator i = m.find("f");

if (i == m.end()) { /* Not found */ }
else { /* Found, i->first is f, i->second is ++-- */ }
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: How can I profile C++ code running on Linux? (score [485365](https://stackoverflow.com/q/375913) in 2018)

#### Question
I have a C++ application, running on Linux, which I'm in the process of optimizing. How can I pinpoint which areas of my code are running slowly?  

#### Answer accepted (score 1349)
If your goal is to use a profiler, use one of the suggested ones.  

However, if you're in a hurry and you can manually interrupt your program under the debugger while it's being subjectively slow, there's a simple way to find performance problems.  

<p>Just halt it several times, and each time look at the call stack. If there is some code that is wasting some percentage of the time, 20% or 50% or whatever, that is the probability that you will catch it in the act on each sample. So that is roughly the percentage of samples on which you will see it. There is no educated guesswork required.
If you do have a guess as to what the problem is, this will prove or disprove it.</p>

<p>You may have multiple performance problems of different sizes. If you clean out any one of them, the remaining ones will take a larger percentage, and be easier to spot, on subsequent passes.
This <em>magnification effect</em>, when compounded over multiple problems, can lead to truly massive speedup factors.</p>

Caveat: Programmers tend to be skeptical of this technique unless they've used it themselves. They will say that profilers give you this information, but that is only true if they sample the entire call stack, and then let you examine a random set of samples. (The summaries are where the insight is lost.) Call graphs don't give you the same information, because   

<ol>
<li>they don't summarize at the instruction level, and</li>
<li>they give confusing summaries in the presence of recursion.</li>
</ol>

<p>They will also say it only works on toy programs, when actually it works on any program, and it seems to work better on bigger programs, because they tend to have more problems to find.
They will say it sometimes finds things that aren't problems, but that is only true if you see something <em>once</em>. If you see a problem on more than one sample, it is real.</p>

P.S. This can also be done on multi-thread programs if there is a way to collect call-stack samples of the thread pool at a point in time, as there is in Java.  

P.P.S As a rough generality, the more layers of abstraction you have in your software, the more likely you are to find that that is the cause of performance problems (and the opportunity to get speedup).  

Added: It might not be obvious, but the stack sampling technique works equally well in the presence of recursion. The reason is that the time that would be saved by removal of an instruction is approximated by the fraction of samples containing it, regardless of the number of times it may occur within a sample.  

<p>Another objection I often hear is: "<em>It will stop someplace random, and it will miss the real problem</em>".
This comes from having a prior concept of what the real problem is.
A key property of performance problems is that they defy expectations.
Sampling tells you something is a problem, and your first reaction is disbelief.
That is natural, but you can be sure if it finds a problem it is real, and vice-versa.</p>

ADDED: Let me make a Bayesian explanation of how it works.  Suppose there is some instruction `I` (call or otherwise) which is on the call stack some fraction `f` of the time (and thus costs that much). For simplicity, suppose we don't know what `f` is, but assume it is either 0.1, 0.2, 0.3, ... 0.9, 1.0, and the prior probability of each of these possibilities is 0.1, so all of these costs are equally likely a-priori.  

Then suppose we take just 2 stack samples, and we see instruction `I` on both samples, designated observation `o=2/2`. This gives us new estimates of the frequency `f` of `I`, according to this:  

```c++
Prior                                    
P(f=x) x  P(o=2/2|f=x) P(o=2/2&&f=x)  P(o=2/2&&f >= x)  P(f >= x | o=2/2)

0.1    1     1             0.1          0.1            0.25974026
0.1    0.9   0.81          0.081        0.181          0.47012987
0.1    0.8   0.64          0.064        0.245          0.636363636
0.1    0.7   0.49          0.049        0.294          0.763636364
0.1    0.6   0.36          0.036        0.33           0.857142857
0.1    0.5   0.25          0.025        0.355          0.922077922
0.1    0.4   0.16          0.016        0.371          0.963636364
0.1    0.3   0.09          0.009        0.38           0.987012987
0.1    0.2   0.04          0.004        0.384          0.997402597
0.1    0.1   0.01          0.001        0.385          1

                  P(o=2/2) 0.385                
```

The last column says that, for example, the probability that `f` >= 0.5 is 92%, up from the prior assumption of 60%.  

Suppose the prior assumptions are different. Suppose we assume P(f=0.1) is .991 (nearly certain), and all the other possibilities are almost impossible (0.001). In other words, our prior certainty is that `I` is cheap. Then we get:  

```c++
Prior                                    
P(f=x) x  P(o=2/2|f=x) P(o=2/2&& f=x)  P(o=2/2&&f >= x)  P(f >= x | o=2/2)

0.001  1    1              0.001        0.001          0.072727273
0.001  0.9  0.81           0.00081      0.00181        0.131636364
0.001  0.8  0.64           0.00064      0.00245        0.178181818
0.001  0.7  0.49           0.00049      0.00294        0.213818182
0.001  0.6  0.36           0.00036      0.0033         0.24
0.001  0.5  0.25           0.00025      0.00355        0.258181818
0.001  0.4  0.16           0.00016      0.00371        0.269818182
0.001  0.3  0.09           0.00009      0.0038         0.276363636
0.001  0.2  0.04           0.00004      0.00384        0.279272727
0.991  0.1  0.01           0.00991      0.01375        1

                  P(o=2/2) 0.01375                
```

Now it says P(f >= 0.5) is 26%, up from the prior assumption of 0.6%. So Bayes allows us to update our estimate of the probable cost of `I`. If the amount of data is small, it doesn't tell us accurately what the cost is, only that it is big enough to be worth fixing.  

<p>Yet another way to look at it is called the <a href="http://en.wikipedia.org/wiki/Rule_of_succession" rel="noreferrer">Rule Of Succession</a>.
If you flip a coin 2 times, and it comes up heads both times, what does that tell you about the probable weighting of the coin?
The respected way to answer is to say that it's a Beta distribution, with average value (number of hits + 1) / (number of tries + 2) = (2+1)/(2+2) = 75%.</p>

(The key is that we see `I` more than once. If we only see it once, that doesn't tell us much except that `f` > 0.)  

So, even a very small number of samples can tell us a lot about the cost of instructions that it sees. (And it will see them with a frequency, on average, proportional to their cost. If `n` samples are taken, and `f` is the cost, then `I` will appear on `nf+/-sqrt(nf(1-f))` samples. Example, `n=10`, `f=0.3`, that is `3+/-1.4` samples.)  

<hr>

<p>ADDED, to give an intuitive feel for the difference between measuring and random stack sampling:<br>
There are profilers now that sample the stack, even on wall-clock time, but <em>what comes out</em> is measurements (or hot path, or hot spot, from which a "bottleneck" can easily hide). What they don't show you (and they easily could) is the actual samples themselves. And if your goal is to <em>find</em> the bottleneck, the number of them you need to see is, <em>on average</em>, 2 divided by the fraction of time it takes.
So if it takes 30% of time, 2/.3 = 6.7 samples, on average, will show it, and the chance that 20 samples will show it is 99.2%.</p>

<p>Here is an off-the-cuff illustration of the difference between examining measurements and examining stack samples.
The bottleneck could be one big blob like this, or numerous small ones, it makes no difference.</p>

<a href="https://i.stack.imgur.com/FpWuS.png" rel="noreferrer"><img src="https://i.stack.imgur.com/FpWuS.png" alt="enter image description here"></a>  

<p>Measurement is horizontal; it tells you what fraction of time specific routines take.
Sampling is vertical.
If there is any way to avoid what the whole program is doing at that moment, <em>and if you see it on a second sample</em>, you've found the bottleneck.
That's what makes the difference - seeing the whole reason for the time being spent, not just how much.</p>

#### Answer 2 (score 547)
You can use <a href="http://en.wikipedia.org/wiki/Valgrind" rel="noreferrer">Valgrind</a> with the following options  

```c++
valgrind --tool=callgrind ./(Your binary)
```

It will generate a file called `callgrind.out.x`. You can then use `kcachegrind` tool to read this file. It will give you a graphical analysis of things with results like which lines cost how much.   

#### Answer 3 (score 332)
I assume you're using GCC. The standard solution would be to profile with <a href="http://www.math.utah.edu/docs/info/gprof_toc.html" rel="noreferrer">gprof</a>.  

Be sure to add `-pg` to compilation before profiling:  

```c++
cc -o myprog myprog.c utils.c -g -pg
```

I haven't tried it yet but I've heard good things about <a href="https://github.com/gperftools/gperftools" rel="noreferrer">google-perftools</a>. It is definitely worth a try.  

Related question <a href="https://stackoverflow.com/questions/56672/how-do-you-profile-your-code">here</a>.  

A few other buzzwords if `gprof` does not do the job for you: <a href="http://en.wikipedia.org/wiki/Valgrind" rel="noreferrer">Valgrind</a>, Intel <a href="http://en.wikipedia.org/wiki/VTune" rel="noreferrer">VTune</a>, Sun <a href="http://en.wikipedia.org/wiki/DTrace" rel="noreferrer">DTrace</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: Read whole ASCII file into C++ std::string (score [478956](https://stackoverflow.com/q/2602013) in 2014)

#### Question
I need to read a whole file into memory and place it in a C++ `std::string`.  

If I were to read it into a `char[]`, the answer would be very simple:  

```c++
std::ifstream t;
int length;
t.open("file.txt");      // open input file
t.seekg(0, std::ios::end);    // go to the end
length = t.tellg();           // report location (this is the length)
t.seekg(0, std::ios::beg);    // go back to the beginning
buffer = new char[length];    // allocate memory for a buffer of appropriate dimension
t.read(buffer, length);       // read the whole file into the buffer
t.close();                    // close file handle

// ... Do stuff with buffer here ...
```

Now, I want to do the exact same thing, but using a `std::string` instead of a `char[]`. I want to avoid loops, i.e. I <strong>don't</strong> want to:  

```c++
std::ifstream t;
t.open("file.txt");
std::string buffer;
std::string line;
while(t){
std::getline(t, line);
// ... Append line to buffer and go on
}
t.close()
```

Any ideas?  

#### Answer accepted (score 498)
<strong>Update:</strong> Turns out that this method, while following STL idioms well, is actually surprisingly inefficient! Don't do this with large files. (See: <a href="http://insanecoding.blogspot.com/2011/11/how-to-read-in-file-in-c.html" rel="noreferrer">http://insanecoding.blogspot.com/2011/11/how-to-read-in-file-in-c.html</a>)  

You can make a streambuf iterator out of the file and initialize the string with it:  

```c++
#include <string>
#include <fstream>
#include <streambuf>

std::ifstream t("file.txt");
std::string str((std::istreambuf_iterator<char>(t)),
                 std::istreambuf_iterator<char>());
```

Not sure where you're getting the `t.open("file.txt", "r")` syntax from. As far as I know that's not a method that `std::ifstream` has. It looks like you've confused it with C's `fopen`.  

<strong>Edit:</strong> Also note the extra parentheses around the first argument to the string constructor. <em>These are essential</em>. They prevent the problem known as the "<a href="http://web.archive.org/web/20110426155617/http://www.informit.com/guides/content.aspx?g=cplusplus&amp;seqNum=439" rel="noreferrer">most vexing parse</a>", which in this case won't actually give you a compile error like it usually does, but will give you interesting (read: wrong) results.  

Following KeithB's point in the comments, here's a way to do it that allocates all the memory up front (rather than relying on the string class's automatic reallocation):  

```c++
#include <string>
#include <fstream>
#include <streambuf>

std::ifstream t("file.txt");
std::string str;

t.seekg(0, std::ios::end);   
str.reserve(t.tellg());
t.seekg(0, std::ios::beg);

str.assign((std::istreambuf_iterator<char>(t)),
            std::istreambuf_iterator<char>());
```

#### Answer 2 (score 751)
There are a couple of possibilities. One I like uses a stringstream as a go-between:  

```c++
std::ifstream t("file.txt");
std::stringstream buffer;
buffer << t.rdbuf();
```

Now the contents of "file.txt" are available in a string as `buffer.str()`.  

Another possibility (though I certainly don't like it as well) is much more like your original:  

```c++
std::ifstream t("file.txt");
t.seekg(0, std::ios::end);
size_t size = t.tellg();
std::string buffer(size, ' ');
t.seekg(0);
t.read(&buffer[0], size); 
```

Officially, this isn't required to work under the C++98 or 03 standard (string isn't required to store data contiguously) but in fact it works with all known implementations, and C++11 and later do require contiguous storage, so it's guaranteed to work with them.  

As to why I don't like the latter as well: first, because it's longer and harder to read. Second, because it requires that you initialize the contents of the string with data you don't care about, then immediately write over that data (yes, the time to initialize is usually trivial compared to the reading, so it probably doesn't matter, but to me it still feels kind of wrong). Third, in a text file, position X in the file doesn't necessarily mean you'll have read X characters to reach that point -- it's not required to take into account things like line-end translations. On real systems that do such translations (e.g., Windows) the translated form is shorter than what's in the file (i.e., "\r\n" in the file becomes "\n" in the translated string) so all you've done is reserved a little extra space you never use. Again, doesn't really cause a major problem but feels a little wrong anyway.  

#### Answer 3 (score 62)
I think best way is to use string stream. simple and quick !!!  

```c++
#include <fstream>
#include <iostream>
#include <sstream> //std::stringstream
int main() {
    std::ifstream inFile;
    inFile.open("inFileName"); //open the input file

    std::stringstream strStream;
    strStream << inFile.rdbuf(); //read the file
    std::string str = strStream.str(); //str holds the content of the file

    std::cout << str << "\n"; //you can do anything with the string!!!
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: How do I get the directory that a program is running from? (score [477268](https://stackoverflow.com/q/143174) in 2013)

#### Question
Is there a platform-agnostic and filesystem-agnostic method to obtain the full path of the directory from where a program is running using C/C++? Not to be confused with the current working directory. (Please don't suggest libraries unless they're standard ones like clib or STL.)  

(If there's no platform/filesystem-agnostic method, suggestions that work in Windows and Linux for specific filesystems are welcome too.)  

#### Answer accepted (score 171)
Here's code to get the full path to the executing app:  

Windows:  

```c++
int bytes = GetModuleFileName(NULL, pBuf, len);
if(bytes == 0)
    return -1;
else
    return bytes;
```

Linux:  

```c++
char szTmp[32];
sprintf(szTmp, "/proc/%d/exe", getpid());
int bytes = MIN(readlink(szTmp, pBuf, len), len - 1);
if(bytes >= 0)
    pBuf[bytes] = '\0';
return bytes;
```

#### Answer 2 (score 165)
If you fetch the current directory when your program first starts, then you effectively have the directory your program was started from. Store the value in a variable and refer to it later in your program. This is distinct from <a href="https://stackoverflow.com/q/933850/33732">the directory that holds the current executable program file</a>. It isn't necessarily the same directory; if someone runs the program from a command prompt, then the program is being <em>run from</em> the command prompt's current working directory even though the program file lives elsewhere.  

getcwd is a POSIX function and supported out of the box by all POSIX compliant platforms. You would not have to do anything special (apart from incliding the right headers unistd.h on Unix and direct.h on windows).  

Since you are creating a C program it will link with the default c run time library which is linked to by ALL processes in the system (specially crafted exceptions avoided) and it will include this function by default. The CRT is never considered an external library because that provides the basic standard compliant interface to the OS.  

On windows getcwd function has been deprecated in favour of _getcwd. I think you could use it in this fashion.  

```c++
#include <stdio.h>  /* defines FILENAME_MAX */
#ifdef WINDOWS
    #include <direct.h>
    #define GetCurrentDir _getcwd
#else
    #include <unistd.h>
    #define GetCurrentDir getcwd
 #endif

 char cCurrentPath[FILENAME_MAX];

 if (!GetCurrentDir(cCurrentPath, sizeof(cCurrentPath)))
     {
     return errno;
     }

cCurrentPath[sizeof(cCurrentPath) - 1] = '\0'; /* not really required */

printf ("The current working directory is %s", cCurrentPath);
```

#### Answer 3 (score 39)
This is from the <a href="http://www.cplusplus.com/forum/general/11104/">cplusplus forum</a>  

<strong>On windows:</strong>  

```c++
#include <string>
#include <windows.h>

std::string getexepath()
{
  char result[ MAX_PATH ];
  return std::string( result, GetModuleFileName( NULL, result, MAX_PATH ) );
}
```

<strong>On Linux:</strong>  

```c++
#include <string>
#include <limits.h>
#include <unistd.h>

std::string getexepath()
{
  char result[ PATH_MAX ];
  ssize_t count = readlink( "/proc/self/exe", result, PATH_MAX );
  return std::string( result, (count > 0) ? count : 0 );
}
```

<strong>On HP-UX:</strong>  

```c++
#include <string>
#include <limits.h>
#define _PSTAT64
#include <sys/pstat.h>
#include <sys/types.h>
#include <unistd.h>

std::string getexepath()
{
  char result[ PATH_MAX ];
  struct pst_status ps;

  if (pstat_getproc( &ps, sizeof( ps ), 0, getpid() ) < 0)
    return std::string();

  if (pstat_getpathname( result, PATH_MAX, &ps.pst_fid_text ) < 0)
    return std::string();

  return std::string( result );
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Easily measure elapsed time (score [469449](https://stackoverflow.com/q/2808398) in 2013)

#### Question
I am trying to use <a href="http://en.cppreference.com/w/cpp/chrono/c/time" rel="noreferrer">time()</a> to measure various points of my program.  

What I don't understand is why the values in the before and after are the same?  I understand this is not the best way to profile my program, I just want to see how long something take.    

```c++
printf("**MyProgram::before time= %ld\n", time(NULL));

doSomthing();
doSomthingLong();

printf("**MyProgram::after time= %ld\n", time(NULL));
```

I have tried:  

```c++
struct timeval diff, startTV, endTV;

gettimeofday(&startTV, NULL); 

doSomething();
doSomethingLong();

gettimeofday(&endTV, NULL); 

timersub(&endTV, &startTV, &diff);

printf("**time taken = %ld %ld\n", diff.tv_sec, diff.tv_usec);
```

How do I read a result of `**time taken = 0 26339`?  Does that mean 26,339 nanoseconds = 26.3 msec?  

What about `**time taken = 4 45025`, does that mean 4 seconds and 25 msec?  

#### Answer 2 (score 263)
```c++
#include <ctime>

void f() {
  using namespace std;
  clock_t begin = clock();

  code_to_time();

  clock_t end = clock();
  double elapsed_secs = double(end - begin) / CLOCKS_PER_SEC;
}
```

The `time()` function is only accurate to within a second, but there are <a href="http://en.cppreference.com/w/cpp/chrono/c/CLOCKS_PER_SEC" rel="noreferrer">`CLOCKS_PER_SEC`</a> "clocks" within a second.  This is an easy, portable measurement, even though it's over-simplified.  

#### Answer 3 (score 261)
You can <strong>abstract the time measuring mechanism</strong> and have each callable's run time measured with <strong>minimal extra code</strong>, just by being called through a timer structure. Plus, at compile time you can <strong>parametrize the timing type</strong> (milliseconds, nanoseconds etc).   

<p><sup>Thanks to the review by <a href="https://stackoverflow.com/users/14065/loki-astari">Loki Astari</a> and the suggestion to use variadic templates.</sup>
<sup><a href="https://stackoverflow.com/q/31253334/2567683">This</a> is why the forwarded function call.</sup></p>

```c++
#include <iostream>
#include <chrono>

template<typename TimeT = std::chrono::milliseconds>
struct measure
{
    template<typename F, typename ...Args>
    static typename TimeT::rep execution(F&& func, Args&&... args)
    {
        auto start = std::chrono::steady_clock::now();
        std::forward<decltype(func)>(func)(std::forward<Args>(args)...);
        auto duration = std::chrono::duration_cast< TimeT> 
                            (std::chrono::steady_clock::now() - start);
        return duration.count();
    }
};

int main() {
    std::cout << measure<>::execution(functor(dummy)) << std::endl;
}
```

<a href="http://ideone.com/JbUkPq" rel="noreferrer"><kbd><strong>Demo</strong></kbd></a>  

According to the comment by <a href="https://stackoverflow.com/users/576911/howard-hinnant"><strong>Howard Hinnant</strong></a> it's best not to escape out of the chrono system until we have to. So the above class could give the user the choice to call `count` manually by providing an extra static method (shown in C++14)  

```c++
template<typename F, typename ...Args>
static auto duration(F&& func, Args&&... args)
{
    auto start = std::chrono::steady_clock::now();
    std::forward<decltype(func)>(func)(std::forward<Args>(args)...);
    return std::chrono::duration_cast<TimeT>(std::chrono::steady_clock::now()-start);
} 

// call .count() manually later when needed (eg IO)
auto avg = (measure<>::duration(func) + measure<>::duration(func)) / 2.0;
```

and be most useful for clients that   

<blockquote>
  "want to post-process a bunch of durations prior to I/O (e.g. average)"  
</blockquote>

<hr>

The complete <a href="https://github.com/picanumber/bureaucrat/blob/master/time_lapse.h" rel="noreferrer"><strong>code can be found here</strong></a>. My attempt to build a <strong>benchmarking tool</strong> based on chrono is recorded <a href="https://isocpp.org/blog/2015/04/https-ngathanasiou.wordpress.com-2015-04-01-benchmarking-in-c" rel="noreferrer"><strong>here</strong></a>.  

<hr>

If C++17's <a href="http://en.cppreference.com/w/cpp/utility/functional/invoke" rel="noreferrer">`std::invoke`</a> is available, the invocation of the callable in `execution` could be done like this :   

```c++
invoke(forward<decltype(func)>(func), forward<Args>(args)...);
```

to provide for callables that are pointers to member functions.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: Convert a String In C++ To Upper Case (score [469068](https://stackoverflow.com/q/735204) in 2012)

#### Question
How could one convert a string to upper case. The examples I have found from googling only have to deal with chars.  

#### Answer accepted (score 204)
Boost string algorithms:  

```c++
#include <boost/algorithm/string.hpp>
#include <string>

std::string str = "Hello World";

boost::to_upper(str);

std::string newstr = boost::to_upper_copy<std::string>("Hello World");
```

#### Answer 2 (score 466)
```c++
#include <algorithm>
#include <string>

std::string str = "Hello World";
std::transform(str.begin(), str.end(),str.begin(), ::toupper);
```

#### Answer 3 (score 82)
Short solution using C++11 and toupper().  

```c++
for (auto & c: str) c = toupper(c);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: How to initialize private static members in C++? (score [466489](https://stackoverflow.com/q/185844) in 2018)

#### Question
What is the best way to initialize a private, static data member in C++?  I tried this in my header file, but it gives me weird linker errors:  

```c++
class foo
{
    private:
        static int i;
};

int foo::i = 0;
```

I'm guessing this is because I can't initialize a private member from outside the class.  So what's the best way to do this?  

#### Answer accepted (score 519)
<p>The class declaration should be in the header file (Or in the source file if not shared).<br>
File: foo.h</p>

```c++
class foo
{
    private:
        static int i;
};
```

<p>But the initialization should be in source file.<br>
File: foo.cpp</p>

```c++
int foo::i = 0;
```

If the initialization is in the header file then each file that includes the header file will have a definition of the static member. Thus during the link phase you will get linker errors as the code to initialize the variable will be defined in multiple source files.  

<b>Note:</b> Matt Curtis: points out that C++ allows the simplification of the above if the static member variable is of const int type (e.g. `int`, `bool`, `char`). You can then declare and initialize the member variable directly inside the class declaration in the header file:  

```c++
class foo
{
    private:
        static int const i = 42;
};
```

#### Answer 2 (score 86)
For a <strong>variable</strong>:  

foo.h:  

```c++
class foo
{
private:
    static int i;
};
```

foo.cpp:  

```c++
int foo::i = 0;
```

This is because there can only be one instance of `foo::i` in your program. It's sort of the equivalent of `extern int i` in a header file and `int i` in a source file.  

For a <strong>constant</strong> you can put the value straight in the class declaration:  

```c++
class foo
{
private:
    static int i;
    const static int a = 42;
};
```

#### Answer 3 (score 27)
For future viewers of this question, I want to point out that you should avoid what <a href="https://stackoverflow.com/a/8772501/5571184">monkey0506 is suggesting</a>.  

Header files are for declarations.  

Header files get compiled once for every `.cpp` file that directly or indirectly `#includes` them, and code outside of any function is run at program initialization, before `main()`.  

By putting: `foo::i = VALUE;` into the header, `foo:i` will be assigned the value `VALUE` (whatever that is) for every `.cpp` file, and these assignments will happen in an indeterminate order (determined by the linker) before `main()` is run.  

What if we `#define VALUE` to be a different number in one of our `.cpp` files? It will compile fine and we will have no way of knowing which one wins until we run the program.  

Never put executed code into a header for the same reason that you never `#include` a `.cpp` file.  

include guards (which I agree you should always use) protect you from something different: the same header being indirectly `#include`d multiple times while compiling a single `.cpp` file  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: Differences between C++ string == and compare()? (score [464209](https://stackoverflow.com/q/9158894) in 2012)

#### Question
I just read some recommendations on using   

```c++
std::string s = get_string();
std::string t = another_string();

if( !s.compare(t) ) 
{
```

instead of   

```c++
if( s == t )
{
```

<p>I'm almost always using the last one because I'm used to it and it feels natural, more readable. I didn't even know that there was a separate comparison function.
To be more precise, I thought == would call compare().</p>

<strong>What are the differences? In which contexts should one way be favored to the other?</strong>  

I'm considering only the cases where I need to know if a string is the same value as another string.  

#### Answer accepted (score 412)
This is what the standard has to say about `operator==`  

<blockquote>
  <strong>21.4.8.2 operator==</strong>  

```c++
template<class charT, class traits, class Allocator>
bool operator==(const basic_string<charT,traits,Allocator>& lhs,
                const basic_string<charT,traits,Allocator>& rhs) noexcept;
```
  
  Returns: lhs.compare(rhs) == 0.  
</blockquote>

Seems like there isn't much of a difference!  

#### Answer 2 (score 130)
<a href="http://www.cplusplus.com/reference/string/string/compare/">std::string::compare()</a> returns an `int`:  

<ul>
<li>equal to zero if `s` and `t` are equal,</li>
<li>less than zero if `s` is less than `t`,</li>
<li>greater than zero if `s` is greater than `t`.</li>
</ul>

If you want your first code snippet to be equivalent to the second one, it should actually read:  

```c++
if (!s.compare(t)) {
    // 's' and 't' are equal.
}
```

The equality operator only tests for equality (hence its name) and returns a `bool`.  

To elaborate on the use cases, `compare()` can be useful if you're interested in how the two strings relate to one another (less or greater) when they happen to be different. PlasmaHH rightfully mentions trees, and it could also be, say, a string insertion algorithm that aims to keep the container sorted, a dichotomic search algorithm for the aforementioned container, and so on.  

<strong>EDIT:</strong> As Steve Jessop points out in the comments, `compare()` is most useful for quick sort and binary search algorithms. Natural sorts and dichotomic searches can be implemented with only <a href="http://www.cplusplus.com/reference/std/functional/less/">std::less</a>.  

#### Answer 3 (score 30)
`compare` has overloads for comparing substrings. If you're comparing whole strings you should just use `==` operator (and whether it calls `compare` or not is pretty much irrelevant).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: Unresolved external symbol in object files (score [462491](https://stackoverflow.com/q/9928238) in 2016)

#### Question
<p>During coding in Visual Studio I got an unresolved external symbol error
and I've got no idea what to do. I don't know what's wrong.
Could you please decipher me? Where should I be looking for what kind of errors?</p>

```c++
1>Form.obj : error LNK2019: unresolved external symbol "public: class Field * __thiscall Field::addField(class Field *)" (?addField@Field@@QAEPAV1@PAV1@@Z) referenced in function "public: void __thiscall Form::parse(class std::basic_stringstream<char,struct std::char_traits<char>,class std::allocator<char> > &)" (?parse@Form@@QAEXAAV?$basic_stringstream@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@@Z)
1>Form.obj : error LNK2019: unresolved external symbol "public: virtual void __thiscall Field::parse(class std::basic_stringstream<char,struct std::char_traits<char>,class std::allocator<char> > &)" (?parse@Field@@UAEXAAV?$basic_stringstream@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@@Z) referenced in function "public: __thiscall InputField::InputField(class std::basic_stringstream<char,struct std::char_traits<char>,class std::allocator<char> > &)" (??0InputField@@QAE@AAV?$basic_stringstream@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@@Z)
1>Form.obj : error LNK2001: unresolved external symbol "public: virtual void __thiscall Field::prompt(void)" (?prompt@Field@@UAEXXZ)
1>Form.obj : error LNK2001: unresolved external symbol "public: virtual class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > __thiscall Field::getName(void)" (?getName@Field@@UAE?AV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@XZ)
1>Form.obj : error LNK2001: unresolved external symbol "public: virtual class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> > __thiscall Field::getType(void)" (?getType@Field@@UAE?AV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@XZ)
1>Form.obj : error LNK2001: unresolved external symbol "public: virtual void __thiscall Field::describe(void)" (?describe@Field@@UAEXXZ)
1>C:\Users\tomy\Documents\Visual Studio 2010\Projects\zapoctovkac++\Debug\zapoctovkac++.exe : fatal error LNK1120: 6 unresolved externals
```

#### Answer accepted (score 286)
This error often means that some function has a declaration, but not a definition.  

Example:  

```c++
// A.hpp
class A
{
public:
  void myFunc(); // Function declaration
};

// A.cpp

// Function definition
void A::myFunc()
{
  // do stuff
}
```

<strong>In your case, the definition cannot be found.</strong> The issue could be that you are including a header file, which brings in some function declarations, but you either:  

<ol>
<li>do not define the functions in your cpp file (if you wrote this code yourself)</li>
<li>do not include the lib/dll file that contains the definitions </li>
</ol>

A common mistake is that you define a function as a standalone and forget the class selector, e.g. `A::`, in your <em>.cpp</em> file:  

<p><strong>Wrong:</strong> `void myFunc() { /* do stuff */ }`
<br><strong>Right:</strong> `void A::myFunc() { /* do stuff */ }`</p>

#### Answer 2 (score 24)
Check you are including all the source files within your solution that you are referencing.   

If you are not including the source file (and thus the implementation) for the class `Field` in your project it won't be built and you will be unable to link during compilation.  

Alternatively, perhaps you are using a static or dynamic library and have forgotten to tell the linker about the `.lib`s?  

#### Answer 3 (score 11)
It looks to be missing a library or include,  you can try to figure out what class of your library that have getName, getType etc ... and put that in the header file or using `#include`.  

Also if these happen to be from an external library, make sure you reference to them on your project file.  For example, if this class belongs to an abc.lib then in your Visual Studio   

<ol>
<li>Click on Project Properties. </li>
<li>Go to Configuration Properties, C/C++,
Generate, verify you point to the abc.lib location under Additional
Include Directories. Under Linker, Input, make sure you have the
abc.lib under Additional Dependencies.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: What is the difference between const int*, const int * const, and int const *? (score [459578](https://stackoverflow.com/q/1143262) in 2017)

#### Question
I always mess up how to use `const int*`, `const int * const`, and `int const *` correctly. Is there a set of rules defining what you can and cannot do?  

I want to know all the do's and all don'ts in terms of assignments, passing to the functions, etc.  

#### Answer accepted (score 2072)
Read it backwards (as driven by <a href="http://c-faq.com/decl/spiral.anderson.html" rel="noreferrer">Clockwise/Spiral Rule</a>):  

<ul>
<li>`int*` - pointer to int</li>
<li>`int const *` - pointer to const int</li>
<li>`int * const` - const pointer to int</li>
<li>`int const * const` - const pointer to const int</li>
</ul>

Now the first `const` can be on either side of the type so:  

<ul>
<li>`const int *` == `int const *`</li>
<li>`const int * const` == `int const * const`</li>
</ul>

If you want to go really crazy you can do things like this:  

<ul>
<li>`int **` - pointer to pointer to int</li>
<li>`int ** const` - a const pointer to a pointer to an int</li>
<li>`int * const *` - a pointer to a const pointer to an int</li>
<li>`int const **` - a pointer to a pointer to a const int</li>
<li>`int * const * const` - a const pointer to a const pointer to an int</li>
<li>...</li>
</ul>

And to make sure we are clear on the meaning of const  

```c++
const int* foo;
int *const bar; //note, you actually need to set the pointer 
                //here because you can't change it later ;)
```

`foo` is a variable pointer to a constant integer. This lets you change what you point to but not the value that you point to. Most often this is seen with C-style strings where you have a pointer to a `const char`. You may change which string you point to but you can't change the content of these strings. This is important when the string itself is in the data segment of a program and shouldn't be changed.  

`bar` is a constant or fixed pointer to a value that can be changed. This is like a reference without the extra syntactic sugar. Because of this fact, usually you would use a reference where you would use a `T* const` pointer unless you need to allow `NULL` pointers.  

#### Answer 2 (score 322)
<p>For those who don't know about Clockwise/Spiral Rule:
Start from the name of the variable, move clockwisely (in this case, move backward) to the next <strong>pointer</strong> or <strong>type</strong>. Repeat until expression ends.</p>

Here is a demo:  

<img src="https://i.stack.imgur.com/sT6ng.png" alt="pointer to int">  

<img src="https://i.stack.imgur.com/Zt0G2.png" alt="const pointer to int const">  

<img src="https://i.stack.imgur.com/kXH8P.png" alt="pointer to int const">  

<img src="https://i.stack.imgur.com/UeqZO.png" alt="pointer to const int">  

<img src="https://i.stack.imgur.com/f5ftV.png" alt="const pointer to int">  

#### Answer 3 (score 137)
I think everything is answered here already, but I just want to add that you should beware of `typedef`s! They're NOT just text replacements.  

For example:  

```c++
typedef char *ASTRING;
const ASTRING astring;
```

The type of `astring` is `char * const`, not `const char *`. This is one reason I always tend to put `const` to the right of the type, and never at the start.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Undefined reference to vtable (score [455622](https://stackoverflow.com/q/3065154) in 2019)

#### Question
When building my C++ program, I'm getting the error message   

<blockquote>
  undefined reference to 'vtable...  
</blockquote>

What is the cause of this problem? How do I fix it?  

<hr>

It so happens that I'm getting the error for the following code (The class in question is CGameModule.) and I cannot for the life of me understand what the problem is. At first, I thought it was related to forgetting to give a virtual function a body, but as far as I understand, everything is all here. The inheritance chain is a little long, but here is the related source code. I'm not sure what other information I should provide.  

Note: The constructor is where this error is happening, it'd seem.  

My code:  

```c++
class CGameModule : public CDasherModule {
 public:
  CGameModule(Dasher::CEventHandler *pEventHandler, CSettingsStore *pSettingsStore, CDasherInterfaceBase *pInterface, ModuleID_t iID, const char *szName)
  : CDasherModule(pEventHandler, pSettingsStore, iID, 0, szName)
  { 
      g_pLogger->Log("Inside game module constructor");   
      m_pInterface = pInterface; 
  }

  virtual ~CGameModule() {};

  std::string GetTypedTarget();

  std::string GetUntypedTarget();

  bool DecorateView(CDasherView *pView) {
      //g_pLogger->Log("Decorating the view");
      return false;
  }

  void SetDasherModel(CDasherModel *pModel) { m_pModel = pModel; }


  virtual void HandleEvent(Dasher::CEvent *pEvent); 

 private:



  CDasherNode *pLastTypedNode;


  CDasherNode *pNextTargetNode;


  std::string m_sTargetString;


  size_t m_stCurrentStringPos;


  CDasherModel *m_pModel;


  CDasherInterfaceBase *m_pInterface;
};
```

Inherits from...  

```c++
class CDasherModule;
typedef std::vector<CDasherModule*>::size_type ModuleID_t;

/// \ingroup Core
/// @{
class CDasherModule : public Dasher::CDasherComponent {
 public:
  CDasherModule(Dasher::CEventHandler * pEventHandler, CSettingsStore * pSettingsStore, ModuleID_t iID, int iType, const char *szName);

  virtual ModuleID_t GetID();
  virtual void SetID(ModuleID_t);
  virtual int GetType();
  virtual const char *GetName();

  virtual bool GetSettings(SModuleSettings **pSettings, int *iCount) {
    return false;
  };

 private:
  ModuleID_t m_iID;
  int m_iType;
  const char *m_szName;
};
```

Which inherits from....  

```c++
namespace Dasher {
  class CEvent;
  class CEventHandler;
  class CDasherComponent;
};

/// \ingroup Core
/// @{
class Dasher::CDasherComponent {
 public:
  CDasherComponent(Dasher::CEventHandler* pEventHandler, CSettingsStore* pSettingsStore);
  virtual ~CDasherComponent();

  void InsertEvent(Dasher::CEvent * pEvent);
  virtual void HandleEvent(Dasher::CEvent * pEvent) {};

  bool GetBoolParameter(int iParameter) const;
  void SetBoolParameter(int iParameter, bool bValue) const;

  long GetLongParameter(int iParameter) const;
  void SetLongParameter(int iParameter, long lValue) const;

  std::string GetStringParameter(int iParameter) const;
  void        SetStringParameter(int iParameter, const std::string & sValue) const;

  ParameterType   GetParameterType(int iParameter) const;
  std::string     GetParameterName(int iParameter) const;

 protected:
  Dasher::CEventHandler *m_pEventHandler;
  CSettingsStore *m_pSettingsStore;
};
/// @}


#endif
```

#### Answer accepted (score 52)
So, I've figured out the issue and it was a combination of bad logic and not being totally familiar with the automake/autotools world. I was adding the correct files to my Makefile.am template, but I wasn't sure which step in our build process actually created the makefile itself. So, I was compiling with an old makefile that had no idea about my new files whatsoever.  

Thanks for the responses and the link to the GCC FAQ. I will be sure to read that to avoid this problem occurring for a real reason.  

#### Answer 2 (score 380)
The <a href="http://gcc.gnu.org/faq.html#vtables" rel="noreferrer">GCC FAQ</a> has an entry on it:  

<blockquote>
  The solution is to ensure that all virtual methods that are not pure are defined. Note that a destructor must be defined even if it is declared pure-virtual [class.dtor]/7.  
</blockquote>

#### Answer 3 (score 150)
For what it is worth, forgetting a body on a virtual destructor generates the following:   

<blockquote>
  undefined reference to `vtable for CYourClass'.    
</blockquote>

I am adding a note because the error message is deceptive.  (This was with gcc version 4.6.3.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: How do you declare an interface in C++? (score [455244](https://stackoverflow.com/q/318064) in 2009)

#### Question
How do I setup a class that represents an interface?  Is this just an abstract base class?  

#### Answer accepted (score 670)
To expand on the answer by <a href="https://stackoverflow.com/questions/318064/how-do-you-declare-an-interface-in-c#318084">bradtgmurray</a>,  you may want to make one exception to the pure virtual method list of your interface by adding a virtual destructor. This allows you to pass pointer ownership to another party without exposing the concrete derived class. The destructor doesn't have to do anything, because the interface doesn't have any concrete members. It might seem contradictory to define a function as both virtual and inline, but trust me - it isn't.  

```c++
class IDemo
{
    public:
        virtual ~IDemo() {}
        virtual void OverrideMe() = 0;
};

class Parent
{
    public:
        virtual ~Parent();
};

class Child : public Parent, public IDemo
{
    public:
        virtual void OverrideMe()
        {
            //do stuff
        }
};
```

You don't have to include a body for the virtual destructor - it turns out some compilers have trouble optimizing an empty destructor and you're better off using the default.   

#### Answer 2 (score 236)
Make a class with pure virtual methods. Use the interface by creating another class that overrides those virtual methods.  

A pure virtual method is a class method that is defined as virtual and assigned to 0.  

```c++
class IDemo
{
    public:
        virtual ~IDemo() {}
        virtual void OverrideMe() = 0;
};

class Child : public IDemo
{
    public:
        virtual void OverrideMe()
        {
            //do stuff
        }
};
```

#### Answer 3 (score 144)
The whole reason you have a special Interface type-category in addition to abstract base classes in C#/<a href="https://stackoverflow.com/questions/1321122/what-is-an-interface-in-java">Java</a> is because C#/Java do not support multiple inheritance.    

C++ supports multiple inheritance, and so a special type isn't needed.  An abstract base class with no non-abstract (pure virtual) methods is functionally equivalent to a C#/Java interface.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: What is the C++ function to raise a number to a power? (score [452219](https://stackoverflow.com/q/845912) in 2009)

#### Question
How do I raise a number to a power?  

```c++
2^1

2^2

2^3
```

etc...  

#### Answer accepted (score 132)
<p>pow() in the cmath library. More info <a href="http://en.cppreference.com/w/cpp/numeric/math/pow" rel="noreferrer">here</a>.
Don't forget to put `#include&lt;cmath&gt;` at the top of the file.</p>

#### Answer 2 (score 90)
`std::pow` in the `&lt;cmath&gt;` header has these overloads:  

```c++
pow(float, float);
pow(float, int);
pow(double, double); // taken over from C
pow(double, int);
pow(long double, long double);
pow(long double, int);
```

Now you can't just do   

```c++
pow(2, N)
```

with N being an int, because it doesn't know which of `float`, `double`, or `long double` version it should take, and you would get an ambiguity error. All three would need a conversion from int to floating point, and all three are equally costly!   

Therefore, be sure to have the first argument typed so it matches one of those three perfectly. I usually use `double`  

```c++
pow(2.0, N)
```

Some lawyer crap from me again. I've often fallen in this pitfall myself, so I'm going to warn you about it.  

#### Answer 3 (score 19)
In C++ the  "^" operator is a bitwise OR.  It does not work for raising to a power.  The x &lt;&lt; n is a left shift of the binary number which is the same as multiplying x by 2 n number of times and that can only be used when raising 2 to a power.  The POW function is a math function that will work generically.      

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: Why can templates only be implemented in the header file? (score [450124](https://stackoverflow.com/q/495021) in 2019)

#### Question
Quote from <a href="http://books.google.com/books?id=n9VEG2Gp5pkC&amp;pg=PA10&amp;lpg=PA10&amp;dq=%22The%20only%20portable%20way%20of%20using%20templates%20at%20the%20moment%20is%20to%20implement%20them%20in%20header%20files%20by%20using%20inline%20functions.%22&amp;source=bl&amp;ots=Ref8pl8dPX&amp;sig=t4K5gvxtBblpcujNxodpwMfei8I&amp;hl=en&amp;ei=qkR6TvbiGojE0AHq4IzqAg&amp;sa=X&amp;oi=book_result&amp;ct=result&amp;resnum=3&amp;ved=0CC8Q6AEwAg#v=onepage&amp;q=%22The%20only%20portable%20way%20of%20using%20templates%20at%20the%20moment%20is%20to%20implement%20them%20in%20header%20files%20by%20using%20inline%20functions.%22&amp;f=false" rel="noreferrer">The C++ standard library: a tutorial and handbook</a>:  

<blockquote>
  The only portable way of using templates at the moment is to implement them in header files by using inline functions.  
</blockquote>

Why is this?  

(Clarification: header files are not the <em>only</em> portable solution. But they are the most convenient portable solution.)  

#### Answer accepted (score 1437)
It is <em>not</em> necessary to put the implementation in the header file, see the alternative solution at the end of this answer.  

Anyway, the reason your code is failing is that, when instantiating a template, the compiler creates a new class with the given template argument. For example:  

```c++
template<typename T>
struct Foo
{
    T bar;
    void doSomething(T param) {/* do stuff using T */}
};

// somewhere in a .cpp
Foo<int> f; 
```

When reading this line, the compiler will create a new class (let's call it `FooInt`), which is equivalent to the following:  

```c++
struct FooInt
{
    int bar;
    void doSomething(int param) {/* do stuff using int */}
}
```

Consequently, the compiler needs to have access to the implementation of the methods, to instantiate them with the template argument (in this case `int`). If these implementations were not in the header, they wouldn't be accessible, and therefore the compiler wouldn't be able to instantiate the template.  

A common solution to this is to write the template declaration in a header file, then implement the class in an implementation file (for example .tpp), and include this implementation file at the end of the header.  

```c++
// Foo.h
template <typename T>
struct Foo
{
    void doSomething(T param);
};

#include "Foo.tpp"

// Foo.tpp
template <typename T>
void Foo<T>::doSomething(T param)
{
    //implementation
}
```

This way, implementation is still separated from declaration, but is accessible to the compiler.  

Another solution is to keep the implementation separated, and explicitly instantiate all the template instances you'll need:  

```c++
// Foo.h

// no implementation
template <typename T> struct Foo { ... };

//----------------------------------------    
// Foo.cpp

// implementation of Foo's methods

// explicit instantiations
template class Foo<int>;
template class Foo<float>;
// You will only be able to use Foo with int or float
```

If my explanation isn't clear enough, you can have a look at the <a href="https://isocpp.org/wiki/faq/templates#templates-defn-vs-decl" rel="noreferrer">C++ Super-FAQ on this subject</a>.  

#### Answer 2 (score 235)
Plenty correct answers here, but I wanted to add this (for completeness):  

If you, at the bottom of the implementation cpp file, do explicit instantiation of all the types the template will be used with, the linker will be able to find them as usual.  

Edit: Adding example of explicit template instantiation. Used after the template has been defined, and all member functions has been defined.  

```c++
template class vector<int>;
```

This will instantiate (and thus make available to the linker) the class and all its member functions (only). Similar syntax works for template functions, so if you have non-member operator overloads you may need to do the same for those.  

The above example is fairly useless since vector is fully defined in headers, except when a common include file (precompiled header?) uses `extern template class vector&lt;int&gt;` so as to keep it from instantiating it in all the <em>other</em> (1000?) files that use vector.   

#### Answer 3 (score 225)
It's because of the requirement for separate compilation and because templates are instantiation-style polymorphism.  

Lets get a little closer to concrete for an explanation. Say I've got the following files:  

<ul>
<li>foo.h
<ul>
<li>declares the interface of `class MyClass&lt;T&gt;`</li>
</ul></li>
<li>foo.cpp
<ul>
<li>defines the implementation of `class MyClass&lt;T&gt;`</li>
</ul></li>
<li>bar.cpp
<ul>
<li>uses `MyClass&lt;int&gt;`</li>
</ul></li>
</ul>

Separate compilation means I should be able to compile <strong>foo.cpp</strong> independently from <strong>bar.cpp</strong>. The compiler does all the hard work of analysis, optimization, and code generation on each compilation unit completely independently; we don't need to do whole-program analysis. It's only the linker that needs to handle the entire program at once, and the linker's job is substantially easier.  

<strong>bar.cpp</strong> doesn't even need to exist when I compile <strong>foo.cpp</strong>, but I should still be able to link the <strong>foo.o</strong> I already had together with the <strong>bar.o</strong> I've only just produced, without needing to recompile <strong>foo.cpp</strong>. <strong>foo.cpp</strong> could even be compiled into a dynamic library, distributed somewhere else without <strong>foo.cpp</strong>, and linked with code they write years after I wrote <strong>foo.cpp</strong>.  

"Instantiation-style polymorphism" means that the template `MyClass&lt;T&gt;` isn't really a generic class that can be compiled to code that can work for any value of `T`. That would add overhead such as boxing, needing to pass function pointers to allocators and constructors, etc. The intention of C++ templates is to avoid having to write nearly identical `class MyClass_int`, `class MyClass_float`, etc, but to still be able to end up with compiled code that is mostly as if we <em>had</em> written each version separately. So a template is <em>literally</em> a template; a class template is <em>not</em> a class, it's a recipe for creating a new class for each `T` we encounter. A template cannot be compiled into code, only the result of instantiating the template can be compiled.  

So when <strong>foo.cpp</strong> is compiled, the compiler can't see <strong>bar.cpp</strong> to know that `MyClass&lt;int&gt;` is needed. It can see the template `MyClass&lt;T&gt;`, but it can't emit code for that (it's a template, not a class). And when <strong>bar.cpp</strong> is compiled, the compiler can see that it needs to create a `MyClass&lt;int&gt;`, but it can't see the template `MyClass&lt;T&gt;` (only its interface in <strong>foo.h</strong>) so it can't create it.  

If <strong>foo.cpp</strong> itself uses `MyClass&lt;int&gt;`, then code for that will be generated while compiling <strong>foo.cpp</strong>, so when <strong>bar.o</strong> is linked to <strong>foo.o</strong> they can be hooked up and will work. We can use that fact to allow a finite set of template instantiations to be implemented in a .cpp file by writing a single template. But there's no way for <strong>bar.cpp</strong> to use the template <em>as a template</em> and instantiate it on whatever types it likes; it can only use pre-existing versions of the templated class that the author of <strong>foo.cpp</strong> thought to provide.  

You might think that when compiling a template the compiler should "generate all versions", with the ones that are never used being filtered out during linking. Aside from the huge overhead and the extreme difficulties such an approach would face because "type modifier" features like pointers and arrays allow even just the built-in types to give rise to an infinite number of types, what happens when I now extend my program by adding:  

<ul>
<li>baz.cpp
<ul>
<li>declares and implements `class BazPrivate`, and uses `MyClass&lt;BazPrivate&gt;`</li>
</ul></li>
</ul>

There is no possible way that this could work unless we either  

<ol>
<li>Have to recompile <strong>foo.cpp</strong> every time we change <em>any other file in the program</em>, in case it added a new novel instantiation of `MyClass&lt;T&gt;`</li>
<li>Require that <strong>baz.cpp</strong> contains (possibly via header includes) the full template of `MyClass&lt;T&gt;`, so that the compiler can generate `MyClass&lt;BazPrivate&gt;` during compilation of <strong>baz.cpp</strong>.</li>
</ol>

Nobody likes (1), because whole-program-analysis compilation systems take <em>forever</em> to compile , and because it makes it impossible to distribute compiled libraries without the source code. So we have (2) instead.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: std::cin input with spaces? (score [448215](https://stackoverflow.com/q/5838711) in 2018)

#### Question
```c++
#include <string>

std::string input;
std::cin >> input;
```

The user wants to enter "Hello World". But `cin` fails at the space between the two words. How can I make `cin` take in the whole of `Hello World`?  

I'm actually doing this with structs and `cin.getline` doesn't seem to work. Here's my code:  

```c++
struct cd
{
    std::string CDTitle[50];
    std::string Artist[50];
    int number_of_songs[50];
};

std::cin.getline(library.number_of_songs[libNumber], 250);
```

This yields an error. Any ideas?  

#### Answer accepted (score 92)
You have to use <a href="http://en.cppreference.com/w/cpp/io/basic_istream/getline" rel="noreferrer">`cin.getline()`</a>:  

```c++
char input[100];
cin.getline(input,sizeof(input));
```

#### Answer 2 (score 190)
It doesn't "fail"; it just stops reading. It sees a lexical token as a "string".  

Use <a href="http://en.cppreference.com/w/cpp/string/basic_string/getline" rel="noreferrer">`std::getline`</a>:  

```c++
int main()
{
   std::string name, title;

   std::cout << "Enter your name: ";
   std::getline(std::cin, name);

   std::cout << "Enter your favourite movie: ";
   std::getline(std::cin, title);

   std::cout << name << "'s favourite movie is " << title;
}
```

Note that this is <em>not</em> the same as `std::istream::getline`, which works with C-style `char` buffers rather than `std::string`s.  

<strong>Update</strong>  

Your edited question bears little resemblance to the original.  

You were trying to `getline` into an `int`, not a string or character buffer. The formatting operations of streams only work with `operator&lt;&lt;` and `operator&gt;&gt;`. Either use one of them (and tweak accordingly for multi-word input), or use `getline` and lexically convert to `int` after-the-fact.  

#### Answer 3 (score 24)
Use :   

```c++
getline(cin, input);
```

the function can be found in   

```c++
#include <string>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: How to replace all occurrences of a character in string? (score [446818](https://stackoverflow.com/q/2896600) in 2016)

#### Question
What is the effective way to replace all occurrences of a character with another character in `std::string`?  

#### Answer accepted (score 682)
`std::string` doesn't contain such function but you could use stand-alone `replace` function from `algorithm` header.  

```c++
#include <algorithm>
#include <string>

void some_func() {
  std::string s = "example string";
  std::replace( s.begin(), s.end(), 'x', 'y'); // replace all 'x' to 'y'
}
```

#### Answer 2 (score 125)
I thought I'd toss in the <a href="http://www.boost.org/doc/libs/release/libs/algorithm/string">boost solution</a> as well:  

```c++
#include <boost/algorithm/string/replace.hpp>

// in place
std::string in_place = "blah#blah";
boost::replace_all(in_place, "#", "@");

// copy
const std::string input = "blah#blah";
std::string output = boost::replace_all_copy(input, "#", "@");
```

#### Answer 3 (score 112)
The question is centered on `character` replacement, but, as I found this page very useful (especially <a href="https://stackoverflow.com/users/18664/konrad">Konrad</a>'s remark), I'd like to share this more generalized implementation, which allows to deal with `substrings` as well:  

```c++
std::string ReplaceAll(std::string str, const std::string& from, const std::string& to) {
    size_t start_pos = 0;
    while((start_pos = str.find(from, start_pos)) != std::string::npos) {
        str.replace(start_pos, from.length(), to);
        start_pos += to.length(); // Handles case where 'to' is a substring of 'from'
    }
    return str;
}
```

Usage:  

```c++
std::cout << ReplaceAll(string("Number Of Beans"), std::string(" "), std::string("_")) << std::endl;
std::cout << ReplaceAll(string("ghghjghugtghty"), std::string("gh"), std::string("X")) << std::endl;
std::cout << ReplaceAll(string("ghghjghugtghty"), std::string("gh"), std::string("h")) << std::endl;
```

Outputs:  

<blockquote>
  Number_Of_Beans  
  
  XXjXugtXty  
  
  hhjhugthty  
</blockquote>

<hr>

<strong>EDIT:</strong>  

<em>The above can be implemented in a more suitable way, in case performances are of your concern, by returning nothing (`void`) and performing the changes directly on the string `str` given as argument, passed <strong>by address</strong> instead of <strong>by value</strong>. This would avoid useless and costly copy of the original string, while returning the result. Your call, then...</em>  

<em>Code :</em>  

```c++
static inline void ReplaceAll2(std::string &str, const std::string& from, const std::string& to)
{
    // Same inner code...
    // No return statement
}
```

<hr>

Hope this will be helpful for some others...  

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: What is a lambda expression in C++11? (score [445636](https://stackoverflow.com/q/7627098) in 2011)

#### Question
What is a lambda expression in C++11? When would I use one? What class of problem do they solve that wasn't possible prior to their introduction?  

A few examples, and use cases would be useful.   

#### Answer accepted (score 1412)
<h5>The problem</h1>

C++ includes useful generic functions like `std::for_each` and `std::transform`, which can be very handy. Unfortunately they can also be quite cumbersome to use, particularly if the <a href="https://stackoverflow.com/questions/356950/c-functors-and-their-uses">functor</a> you would like to apply is unique to the particular function.  

```c++
#include <algorithm>
#include <vector>

namespace {
  struct f {
    void operator()(int) {
      // do something
    }
  };
}

void func(std::vector<int>& v) {
  f f;
  std::for_each(v.begin(), v.end(), f);
}
```

If you only use `f` once and in that specific place it seems overkill to be writing a whole class just to do something trivial and one off.  

In C++03 you might be tempted to write something like the following, to keep the functor local:  

```c++
void func2(std::vector<int>& v) {
  struct {
    void operator()(int) {
       // do something
    }
  } f;
  std::for_each(v.begin(), v.end(), f);
}
```

however this is not allowed, `f` cannot be passed to a <a href="https://en.cppreference.com/w/cpp/language/function_template" rel="noreferrer">template</a> function in C++03.  

<h5>The new solution</h1>

C++11 introduces lambdas allow you to write an inline, anonymous functor to replace the `struct f`. For small simple examples this can be cleaner to read (it keeps everything in one place) and potentially simpler to maintain, for example in the simplest form:  

```c++
void func3(std::vector<int>& v) {
  std::for_each(v.begin(), v.end(), [](int) { /* do something here*/ });
}
```

Lambda functions are just syntactic sugar for anonymous functors.  

<h5>Return types</h2>

In simple cases the return type of the lambda is deduced for you, e.g.:  

```c++
void func4(std::vector<double>& v) {
  std::transform(v.begin(), v.end(), v.begin(),
                 [](double d) { return d < 0.00001 ? 0 : d; }
                 );
}
```

however when you start to write more complex lambdas you will quickly encounter cases where the return type cannot be deduced by the compiler, e.g.:  

```c++
void func4(std::vector<double>& v) {
    std::transform(v.begin(), v.end(), v.begin(),
        [](double d) {
            if (d < 0.0001) {
                return 0;
            } else {
                return d;
            }
        });
}
```

To resolve this you are allowed to explicitly specify a return type for a lambda function, using `-&gt; T`:  

```c++
void func4(std::vector<double>& v) {
    std::transform(v.begin(), v.end(), v.begin(),
        [](double d) -> double {
            if (d < 0.0001) {
                return 0;
            } else {
                return d;
            }
        });
}
```

<h5>"Capturing" variables</h2>

So far we've not used anything other than what was passed to the lambda within it, but we can also use other variables, within the lambda. If you want to access other variables you can use the capture clause (the `[]` of the expression), which has so far been unused in these examples, e.g.:  

```c++
void func5(std::vector<double>& v, const double& epsilon) {
    std::transform(v.begin(), v.end(), v.begin(),
        [epsilon](double d) -> double {
            if (d < epsilon) {
                return 0;
            } else {
                return d;
            }
        });
}
```

You can capture by both reference and value, which you can specify using `&amp;` and `=` respectively:  

<ul>
<li>`[&amp;epsilon]` capture by reference</li>
<li>`[&amp;]` captures all variables used in the lambda by reference</li>
<li>`[=]` captures all variables used in the lambda by value</li>
<li>`[&amp;, epsilon]` captures variables like with [&amp;], but epsilon by value</li>
<li>`[=, &amp;epsilon]` captures variables like with [=], but epsilon by reference</li>
</ul>

The generated `operator()` is `const` by default, with the implication that captures will be `const` when you access them by default. This has the effect that each call with the same input would produce the same result, however you can <a href="https://stackoverflow.com/questions/5501959/why-does-c0xs-lambda-require-mutable-keyword-for-capture-by-value-by-defaul">mark the lambda as `mutable`</a> to request that the `operator()` that is produced is not `const`.  



#### Answer 2 (score 799)
<h5>What is a lambda function?</h1>

The C++ concept of a lambda function originates in the lambda calculus and functional programming. A lambda is an unnamed function that is useful (in actual programming, not theory) for short snippets of code that are impossible to reuse and are not worth naming.  

In C++ a lambda function is defined like this  

```c++
[]() { } // barebone lambda
```

or in all its glory  

```c++
[]() mutable -> T { } // T is the return type, still lacking throw()
```

`[]` is the capture list, `()` the argument list and `{}` the function body.  

<h5>The capture list</h2>

<p>The capture list defines what from the outside of the lambda should be available inside the function body and how.
It can be either:</p>

<ol>
<li>a value: [x]</li>
<li>a reference [&amp;x]</li>
<li>any variable currently in scope by reference [&amp;]</li>
<li>same as 3, but by value [=]</li>
</ol>

You can mix any of the above in a comma separated list `[x, &amp;y]`.  

<h5>The argument list</h2>

The argument list is the same as in any other C++ function.   

<h5>The function body</h2>

The code that will be executed when the lambda is actually called.  

<h5>Return type deduction</h2>

If a lambda has only one return statement, the return type can be omitted and has the implicit type of `decltype(return_statement)`.  

<h5>Mutable</h2>

If a lambda is marked mutable (e.g. `[]() mutable { }`) it is allowed to mutate the values that have been captured by value.  

<h5>Use cases</h1>

The library defined by the ISO standard benefits heavily from lambdas and raises the usability several bars as now users don't have to clutter their code with small functors in some accessible scope.  

<h5>C++14</h1>

In C++14 lambdas have been extended by various proposals.  

<h5>Initialized Lambda Captures</h2>

An element of the capture list can now be initialized with `=`. This allows renaming of variables and to capture by moving. An example taken from the standard:  

```c++
int x = 4;
auto y = [&r = x, x = x+1]()->int {
            r += 2;
            return x+2;
         }();  // Updates ::x to 6, and initializes y to 7.
```

and one taken from Wikipedia showing how to capture with `std::move`:  

```c++
auto ptr = std::make_unique<int>(10); // See below for std::make_unique
auto lambda = [ptr = std::move(ptr)] {return *ptr;};
```

<h5>Generic Lambdas</h2>

<p>Lambdas can now be generic (`auto` would be equivalent to `T` here if
`T` were a type template argument somewhere in the surrounding scope):</p>

```c++
auto lambda = [](auto x, auto y) {return x + y;};
```

<h5>Improved Return Type Deduction</h2>

C++14 allows deduced return types for every function and does not restrict it to functions of the form `return expression;`. This is also extended to lambdas.  

#### Answer 3 (score 165)
Lambda expressions are typically used to encapsulate algorithms so that they can be passed to another function.  However, <strong>it is possible to execute a lambda immediately upon definition</strong>:  

```c++
[&](){ ...your code... }(); // immediately executed lambda expression
```

is functionally equivalent to  

```c++
{ ...your code... } // simple code block
```

This makes lambda expressions <strong>a powerful tool for refactoring complex functions</strong>.  You start by wrapping a code section in a lambda function as shown above.  The process of explicit parameterization can then be performed gradually with intermediate testing after each step.  Once you have the code-block fully parameterized (as demonstrated by the removal of the `&amp;`), you can move the code to an external location and make it a normal function.  

Similarly, you can use lambda expressions to <strong>initialize variables based on the result of an algorithm</strong>...  

```c++
int a = []( int b ){ int r=1; while (b>0) r*=b--; return r; }(5); // 5!
```

As <strong>a way of partitioning your program logic</strong>, you might even find it useful to pass a lambda expression as an argument to another lambda expression...  

```c++
[&]( std::function<void()> algorithm ) // wrapper section
   {
   ...your wrapper code...
   algorithm();
   ...your wrapper code...
   }
([&]() // algorithm section
   {
   ...your algorithm code...
   });
```

Lambda expressions also let you create named <a href="http://en.wikipedia.org/wiki/Nested_function" rel="noreferrer"><strong>nested functions</strong></a>, which can be a convenient way of avoiding duplicate logic.  Using named lambdas also tends to be a little easier on the eyes (compared to anonymous inline lambdas) when passing a non-trivial function as a parameter to another function.  <em>Note: don't forget the semicolon after the closing curly brace.</em>  

```c++
auto algorithm = [&]( double x, double m, double b ) -> double
   {
   return m*x+b;
   };

int a=algorithm(1,2,3), b=algorithm(4,5,6);
```

If subsequent profiling reveals significant initialization overhead for the function object, you might choose to rewrite this as a normal function.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: Private and Protected Members : C++ (score [443439](https://stackoverflow.com/q/224966) in 2018)

#### Question
Can someone enlighten me as to the difference between `private` and `protected` members in classes?  

I understand from best practice conventions that variables and functions which are not called outside the class should be made `private` - but looking at my <strong>MFC</strong> project, <strong>MFC</strong> seems to favor `protected`.  

What's the difference and which should I use?  

#### Answer accepted (score 357)
Private members are only accessible within the class defining them.  

Protected members are accessible in the class that defines them and in classes that inherit from that class.  

Edit: Both are also accessible by friends of their class, and in the case of protected members, by friends of their derived classes.  

Edit 2: Use whatever makes sense in the context of your problem. You should try to make members private whenever you can to reduce coupling and protect the implementation of the base class, but if that's not possible then use protected members. Check <a href="https://isocpp.org/wiki/faq/basics-of-inheritance" rel="noreferrer">C++ FAQ</a> for a better understanding of the issue. <a href="https://stackoverflow.com/questions/37011/protected-member-variables">This question about protected variables</a> might also help.  

#### Answer 2 (score 130)
<strong>Public</strong> members of a class A are accessible for all and everyone.  

<strong>Protected</strong> members of a class A are not accessible outside of A's code, but is accessible from the code of any class derived from A.  

<strong>Private</strong> members of a class A are not accessible outside of A's code, or from the code of any class derived from A.  

So, in the end, choosing between protected or private is answering the following questions: <strong>How much trust are you willing to put into the programmer of the derived class?</strong>  

<strong>By default</strong>, assume the derived class is not to be trusted, and <strong>make your members private</strong>. If you have a very good reason to give free access of the mother class' internals to its derived classes, then you can make them protected.  

#### Answer 3 (score 60)
Protected members can be accessed from derived classes. Private ones can't.  

```c++
class Base {

private: 
  int MyPrivateInt;
protected: 
  int MyProtectedInt;
public:
  int MyPublicInt;
};

class Derived : Base
{
public:
  int foo1()  { return MyPrivateInt;} // Won't compile!
  int foo2()  { return MyProtectedInt;} // OK  
  int foo3()  { return MyPublicInt;} // OK
};‌‌

class Unrelated 
{
private:
  Base B;
public:
  int foo1()  { return B.MyPrivateInt;} // Won't compile!
  int foo2()  { return B.MyProtectedInt;} // Won't compile
  int foo3()  { return B.MyPublicInt;} // OK
};
```

In terms of "best practice", it depends. If there's even a faint possibility that someone might want to derive a new class from your existing one and need access to internal members, make them Protected, not Private. If they're private, your class may become difficult to inherit from easily.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: How to stop C++ console application from exiting immediately? (score [442739](https://stackoverflow.com/q/2529617) in 2014)

#### Question
Lately, I've been trying to learn C++ from <a href="http://www.cplusplus.com/doc/tutorial/" rel="noreferrer">this website</a>. Unfortunately whenever I try to run one of the code samples, I see that program open for about a half second and then immediately close. Is there a way to stop the program from closing immediately so that I can see the fruits of my effort?  

#### Answer accepted (score 118)
<strong>Edit:</strong>  As Charles Bailey rightly points out in a comment below, this won't work if there are characters buffered in `stdin`, and there's really no good way to work around that.  If you're running with a debugger attached, <a href="https://stackoverflow.com/questions/2529617/how-to-stop-c-console-application-from-exiting-immediately/2529936#2529936">John Dibling's suggested solution</a> is probably the cleanest solution to your problem.  

That said, I'll leave this here and maybe someone else will find it useful.  I've used it a lot as a quick hack of sorts when writing tests during development.  

<hr>

At the end of your `main` function, you can call <a href="http://en.cppreference.com/w/cpp/io/c/getchar" rel="noreferrer">`std::getchar();`</a>  

This will get a single character from `stdin`, thus giving you the "press any key to continue" sort of behavior (if you actually want a "press any key" message, you'll have to print one yourself).  

You need to `#include &lt;cstdio&gt;` for `getchar`.  

#### Answer 2 (score 135)
If you are using Visual Studio and you are starting the console application out of the IDE:  

pressing <strong>CTRL-F5</strong> (start without debugging) will start the application and keep the console window open until you press any key.  

#### Answer 3 (score 101)
The solution by James works for all Platforms.   

Alternatively on `Windows` you can also add the following just before you return from `main` function:  

```c++
  system("pause");
```

This will run the `pause` command which waits till you press a key and also displays a nice message `Press any key to continue . . .`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Case-insensitive string comparison in C++ (score [440956](https://stackoverflow.com/q/11635) in 2017)

#### Question
What is the best way of doing case-insensitive string comparison in C++ without transforming a string to all uppercase or all lowercase?  

Please indicate whether the methods are Unicode-friendly and how portable they are.  

#### Answer accepted (score 309)
Boost includes a handy algorithm for this:  

```c++
#include <boost/algorithm/string.hpp>
// Or, for fewer header dependencies:
//#include <boost/algorithm/string/predicate.hpp>

std::string str1 = "hello, world!";
std::string str2 = "HELLO, WORLD!";

if (boost::iequals(str1, str2))
{
    // Strings are identical
}
```

#### Answer 2 (score 116)
Take advantage of the standard `char_traits`. Recall that a `std::string` is in fact a typedef for `std::basic_string&lt;char&gt;`, or more explicitly, `std::basic_string&lt;char, std::char_traits&lt;char&gt; &gt;`. The `char_traits` type describes how characters compare, how they copy, how they cast etc. All you need to do is typedef a new string over `basic_string`, and provide it with your own custom `char_traits` that compare case insensitively.  

```c++
struct ci_char_traits : public char_traits<char> {
    static bool eq(char c1, char c2) { return toupper(c1) == toupper(c2); }
    static bool ne(char c1, char c2) { return toupper(c1) != toupper(c2); }
    static bool lt(char c1, char c2) { return toupper(c1) <  toupper(c2); }
    static int compare(const char* s1, const char* s2, size_t n) {
        while( n-- != 0 ) {
            if( toupper(*s1) < toupper(*s2) ) return -1;
            if( toupper(*s1) > toupper(*s2) ) return 1;
            ++s1; ++s2;
        }
        return 0;
    }
    static const char* find(const char* s, int n, char a) {
        while( n-- > 0 && toupper(*s) != toupper(a) ) {
            ++s;
        }
        return s;
    }
};

typedef std::basic_string<char, ci_char_traits> ci_string;
```

The details are on <a href="http://www.gotw.ca/gotw/029.htm" rel="noreferrer">Guru of The Week number 29</a>.  

#### Answer 3 (score 71)
The trouble with boost is that you have to link with and depend on boost. Not easy in some cases (e.g. android).  

And using char_traits means <em>all</em> your comparisons are case insensitive, which isn't usually what you want.  

This should suffice. It should be reasonably efficient. Doesn't handle unicode or anything though.  

```c++
bool iequals(const string& a, const string& b)
{
    unsigned int sz = a.size();
    if (b.size() != sz)
        return false;
    for (unsigned int i = 0; i < sz; ++i)
        if (tolower(a[i]) != tolower(b[i]))
            return false;
    return true;
}
```

Update: Bonus C++14 version (`#include &lt;algorithm&gt;`):  

```c++
bool iequals(const string& a, const string& b)
{
    return std::equal(a.begin(), a.end(),
                      b.begin(), b.end(),
                      [](char a, char b) {
                          return tolower(a) == tolower(b);
                      });
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: What are C++ functors and their uses? (score [438237](https://stackoverflow.com/q/356950) in 2018)

#### Question
I keep hearing a lot about functors in C++. Can someone give me an overview as to what they are and in what cases they would be useful?  

#### Answer accepted (score 978)
A functor is pretty much just a class which defines the operator(). That lets you create objects which "look like" a function:  

```c++
// this is a functor
struct add_x {
  add_x(int x) : x(x) {}
  int operator()(int y) const { return x + y; }

private:
  int x;
};

// Now you can use it like this:
add_x add42(42); // create an instance of the functor class
int i = add42(8); // and "call" it
assert(i == 50); // and it added 42 to its argument

std::vector<int> in; // assume this contains a bunch of values)
std::vector<int> out(in.size());
// Pass a functor to std::transform, which calls the functor on every element 
// in the input sequence, and stores the result to the output sequence
std::transform(in.begin(), in.end(), out.begin(), add_x(1)); 
assert(out[i] == in[i] + 1); // for all i
```

There are a couple of nice things about functors. One is that unlike regular functions, they can contain state. The above example creates a function which adds 42 to whatever you give it. But that value 42 is not hardcoded, it was specified as a constructor argument when we created our functor instance. I could create another adder, which added 27, just by calling the constructor with a different value. This makes them nicely customizable.  

As the last lines show, you often pass functors as arguments to other functions such as std::transform or the other standard library algorithms. You could do the same with a regular function pointer except, as I said above, functors can be "customized" because they contain state, making them more flexible (If I wanted to use a function pointer, I'd have to write a function which added exactly 1 to its argument. The functor is general, and adds whatever you initialized it with), and they are also potentially more efficient. In the above example, the compiler knows exactly which function `std::transform` should call. It should call `add_x::operator()`. That means it can inline that function call. And that makes it just as efficient as if I had manually called the function on each value of the vector.  

If I had passed a function pointer instead, the compiler couldn't immediately see which function it points to, so unless it performs some fairly complex global optimizations, it'd have to dereference the pointer at runtime, and then make the call.  

#### Answer 2 (score 118)
Little addition. You can use <a href="http://www.boost.org/doc/libs/1_51_0/doc/html/boost/function.html" rel="noreferrer">`boost::function`</a>, to create functors from functions and methods, like this:  

```c++
class Foo
{
public:
    void operator () (int i) { printf("Foo %d", i); }
};
void Bar(int i) { printf("Bar %d", i); }
Foo foo;
boost::function<void (int)> f(foo);//wrap functor
f(1);//prints "Foo 1"
boost::function<void (int)> b(&Bar);//wrap normal function
b(1);//prints "Bar 1"
```

and you can use boost::bind to add state to this functor  

```c++
boost::function<void ()> f1 = boost::bind(foo, 2);
f1();//no more argument, function argument stored in f1
//and this print "Foo 2" (:
//and normal function
boost::function<void ()> b1 = boost::bind(&Bar, 2);
b1();// print "Bar 2"
```

and most useful, with boost::bind and boost::function you can create functor from class method, actually this is a delegate:  

```c++
class SomeClass
{
    std::string state_;
public:
    SomeClass(const char* s) : state_(s) {}

    void method( std::string param )
    {
        std::cout << state_ << param << std::endl;
    }
};
SomeClass *inst = new SomeClass("Hi, i am ");
boost::function< void (std::string) > callback;
callback = boost::bind(&SomeClass::method, inst, _1);//create delegate
//_1 is a placeholder it holds plase for parameter
callback("useless");//prints "Hi, i am useless"
```

You can create list or vector of functors  

```c++
std::list< boost::function<void (EventArg e)> > events;
//add some events
....
//call them
std::for_each(
        events.begin(), events.end(), 
        boost::bind( boost::apply<void>(), _1, e));
```

There is one problem with all this stuff, compiler error messages is not human readable :)  

#### Answer 3 (score 93)
<p>A Functor is a object which acts like a function.
Basically, a class which defines `operator()`.</p>

```c++
class MyFunctor
{
   public:
     int operator()(int x) { return x * 2;}
}

MyFunctor doubler;
int x = doubler(5);
```

The real advantage is that a functor can hold state.   

```c++
class Matcher
{
   int target;
   public:
     Matcher(int m) : target(m) {}
     bool operator()(int x) { return x == target;}
}

Matcher Is5(5);

if (Is5(n))    // same as if (n == 5)
{ ....}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: What is meant with "const" at end of function declaration? (score [437523](https://stackoverflow.com/q/3141087) in 2019)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://stackoverflow.com/questions/751681/meaning-of-const-last-in-a-c-method-declaration">Meaning of &ldquo;const&rdquo; last in a C++ method declaration?</a>  </p>
</blockquote>

I got a book, where there is written something like:  

```c++
class Foo 
{
public:
    int Bar(int random_arg) const
    {
        // code
    }
};
```

What does it mean?  

#### Answer accepted (score 821)
A "const function", denoted with the keyword `const` after a function declaration, makes it a compiler error for this class function to change a member variable of the class.  However, reading of a class variables is okay inside of the function, but writing inside of this function will generate a compiler error.    

Another way of thinking about such "const function" is by viewing a class function as a normal function taking an implicit `this` pointer. So a method `int Foo::Bar(int random_arg)` (without the const at the end) results in a function like `int Foo_Bar(Foo* this, int random_arg)`, and a call such as `Foo f; f.Bar(4)` will internally correspond to something like `Foo f; Foo_Bar(&amp;f, 4)`. Now adding the const at the end (`int Foo::Bar(int random_arg) const`) can then be understood as a declaration with a const this pointer: `int Foo_Bar(const Foo* this, int random_arg)`. Since the type of `this` in such case is const, no modifications of member variables are possible.  

It is possible to loosen the "const function" restriction of not allowing the function to write to any variable of a class. To allow some of the variables to be writable even when the function is marked as a "const function", these class variables are marked with the keyword `mutable`.  Thus, if a class variable is marked as mutable, and a "const function" writes to this variable then the code will compile cleanly and the variable is possible to change. (C++11)  

As usual when dealing with the `const` keyword, changing the location of the const key word in a C++ statement has entirely different meanings.  The above usage of `const` only applies when adding `const` to the end of the function declaration after the parenthesis.   

`const` is a highly overused qualifier in C++: the syntax and ordering is often not straightforward in combination with pointers. Some readings about `const` correctness and the `const` keyword:  

<a href="http://en.wikipedia.org/wiki/Const-correctness" rel="noreferrer">Const correctness</a>  

<a href="http://duramecho.com/ComputerInformation/WhyHowCppConst.html" rel="noreferrer">The C++ 'const' Declaration: Why &amp; How</a>  

#### Answer 2 (score 42)
Consider two class-typed variables:  

```c++
class Boo { ... };

Boo b0;       // mutable object
const Boo b1; // non-mutable object
```

Now you are able to call <em>any</em> member function of `Boo` on `b0`, but only `const`-qualified member functions on `b1`.  

#### Answer 3 (score 12)
`Bar` is guaranteed not to change the object it is being invoked on. See the <a href="http://www.parashift.com/c++-faq-lite/const-correctness.html" rel="noreferrer">section about const correctness</a> in the C++ FAQ, for example.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: How to convert int to QString? (score [432339](https://stackoverflow.com/q/3211771) in 2015)

#### Question
Is there a `QString` function which takes an <strong>int</strong> and outputs it as a `QString`?  

#### Answer accepted (score 616)
Use <a href="http://doc.qt.io/qt-5/qstring.html#number" rel="noreferrer">`QString::number()`</a>:  

```c++
int i = 42;
QString s = QString::number(i);
```

#### Answer 2 (score 116)
<p>And if you want to put it into string within some text context, forget about `+` operator. 
Simply do:</p>

```c++
// Qt 5 + C++11
auto i = 13;    
auto printable = QStringLiteral("My magic number is %1. That's all!").arg(i);

// Qt 5
int i = 13;    
QString printable = QStringLiteral("My magic number is %1. That's all!").arg(i);

// Qt 4
int i = 13;    
QString printable = QString::fromLatin1("My magic number is %1. That's all!").arg(i);
```

#### Answer 3 (score 24)
<p>Moreover to convert whatever you want, you can use `QVariant`.
For an `int` to a `QString` you get:</p>

```c++
QVariant(3).toString();
```

A `float` to a `string` or a `string` to a `float`:  

```c++
QVariant(3.2).toString();
QVariant("5.2").toFloat();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: How do I add a linker or compile flag in a CMake file? (score [430588](https://stackoverflow.com/q/11783932) in 2019)

#### Question
I am using the `arm-linux-androideabi-g++` compiler. When I try to compile a simple "Hello, World!" program it compiles fine. When I test it by adding a simple exception handling in that code it works too (after adding `-fexceptions` .. I guess it is disabled by default).  

This is for an Android device, and I only want to use CMake, not `ndk-build`.  

For example - `first.cpp`  

```c++
#include <iostream>

using namespace std;

int main()
{
   try
   {
   }
   catch (...)
   {
   }
   return 0;
}
```

`./arm-linux-androideadi-g++ -o first-test first.cpp -fexceptions`  

It works with no problem...  

<strong>The problem</strong> ... I am trying to compile the file with a CMake file.  

I want to add the `-fexceptions` as a flag. I tried with  

```c++
set (CMAKE_EXE_LINKER_FLAGS -fexceptions ) or set (CMAKE_EXE_LINKER_FLAGS "fexceptions" )
```

and  

```c++
set ( CMAKE_C_FLAGS "fexceptions")
```

It still displays an error.  

#### Answer accepted (score 222)
Suppose you want to add those flags (better to declare them in a constant):  

```c++
SET(GCC_COVERAGE_COMPILE_FLAGS "-fprofile-arcs -ftest-coverage")
SET(GCC_COVERAGE_LINK_FLAGS    "-lgcov")
```

There are several ways to add them:  

<ol>
<li><p>The easiest one (not clean, but easy and convenient, and works only for compile flags, C &amp; C++ at once):</p>

```c++
add_definitions(${GCC_COVERAGE_COMPILE_FLAGS})
```</li>
<li><p>Appending to corresponding CMake variables:</p>

```c++
SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}")
SET(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}")
```</li>
<li><p>Using target properties, cf. doc <a href="http://www.cmake.org/cmake/help/v2.8.8/cmake.html#prop_tgt:COMPILE_FLAGS" rel="noreferrer">CMake compile flag target property</a> and need to know the target name.</p>

```c++
get_target_property(TEMP ${THE_TARGET} COMPILE_FLAGS)
if(TEMP STREQUAL "TEMP-NOTFOUND")
  SET(TEMP "") # Set to empty string
else()
  SET(TEMP "${TEMP} ") # A space to cleanly separate from existing content
endif()
# Append our values
SET(TEMP "${TEMP}${GCC_COVERAGE_COMPILE_FLAGS}" )
set_target_properties(${THE_TARGET} PROPERTIES COMPILE_FLAGS ${TEMP} )
```</li>
</ol>

Right now I use method 2.  

#### Answer 2 (score 141)
In newer versions of CMake you can set compiler and linker flags for a single target with <a href="http://www.cmake.org/cmake/help/v3.0/command/target_compile_options.html" rel="noreferrer">`target_compile_options`</a> and <a href="http://www.cmake.org/cmake/help/v3.0/command/target_link_libraries.html" rel="noreferrer">`target_link_libraries`</a> respectively (yes, the latter sets linker options too):  

```c++
target_compile_options(first-test PRIVATE -fexceptions)
```

The advantage of this method is that you can control propagation of options to other targets that depend on this one via `PUBLIC` and `PRIVATE`.  

As of CMake 3.13 you can also use <a href="https://cmake.org/cmake/help/git-stage/command/target_link_options.html" rel="noreferrer">`target_link_options`</a> to add linker options which makes the intent more clear.  

#### Answer 3 (score 38)
Try setting the variable `CMAKE_CXX_FLAGS` instead of `CMAKE_C_FLAGS`:  

```c++
set (CMAKE_CXX_FLAGS "-fexceptions")
```

The variable `CMAKE_C_FLAGS` only affects the C compiler, but you are compiling C++ code.   

Adding the flag to `CMAKE_EXE_LINKER_FLAGS` is redundant.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Can I call a constructor from another constructor (do constructor chaining) in C++? (score [428350](https://stackoverflow.com/q/308276) in 2017)

#### Question
As a <a href="http://en.wikipedia.org/wiki/C_Sharp_%28programming_language%29" rel="noreferrer">C#</a> developer I'm used to run through constructors:  



```c++
class Test {
    public Test() {
        DoSomething();
    }

    public Test(int count) : this() {
        DoSomethingWithCount(count);
    }

    public Test(int count, string name) : this(count) {
        DoSomethingWithName(name);
    }
}
```

Is there a way to do this in C++?  

I tried calling the Class name and using the 'this' keyword, but both fails.  

#### Answer accepted (score 1161)
<strong>C++11: Yes!</strong>  

C++11 and onwards has this same feature (called <a href="https://secure.wikimedia.org/wikipedia/en/wiki/C++11#Object_construction_improvement" rel="noreferrer">delegating constructors</a>).   

The syntax is slightly different from C#:  

```c++
class Foo {
public: 
  Foo(char x, int y) {}
  Foo(int y) : Foo('a', y) {}
};
```

<strong>C++03: No</strong>  

Unfortunately, there's no way to do this in C++03, but there are two ways of simulating this:  

<ol>
<li><p>You can combine two (or more) constructors via default parameters:</p>

```c++
class Foo {
public:
  Foo(char x, int y=0);  // combines two constructors (char) and (char, int)
  // ...
};
```</li>
<li><p>Use an init method to share common code:</p>

```c++
class Foo {
public:
  Foo(char x);
  Foo(char x, int y);
  // ...
private:
  void init(char x, int y);
};

Foo::Foo(char x)
{
  init(x, int(x) + 7);
  // ...
}

Foo::Foo(char x, int y)
{
  init(x, y);
  // ...
}

void Foo::init(char x, int y)
{
  // ...
}
```</li>
</ol>

See <a href="https://isocpp.org/wiki/faq/ctors#init-methods" rel="noreferrer">the C++FAQ entry</a> for reference.  

#### Answer 2 (score 108)
No, you can't call one constructor from another in C++03 (called a delegating constructor).  

<p>This changed in C++11 (aka C++0x), which added support for the following syntax:<br>
(example taken from <a href="http://en.wikipedia.org/wiki/C%2B%2B11#Object_construction_improvement" rel="noreferrer">Wikipedia</a>)</p>

```c++
class SomeType
{
  int number;

public:
  SomeType(int newNumber) : number(newNumber) {}
  SomeType() : SomeType(42) {}
};
```

#### Answer 3 (score 40)
I believe you can call a constructor from a constructor. It will compile and run. I recently saw someone do this and it ran on both Windows and Linux.  

It just doesn't do what you want. The inner constructor will construct a temporary local object which gets deleted once the outer constructor returns. They would have to be different constructors as well or you would create a recursive call.  

Ref: <a href="https://isocpp.org/wiki/faq/ctors#init-methods" rel="noreferrer">https://isocpp.org/wiki/faq/ctors#init-methods</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: C++ Structure Initialization (score [426595](https://stackoverflow.com/q/11516657) in 2017)

#### Question
Is it possible to initialize structs in C++ as indicated below  

```c++
struct address {
    int street_no;
    char *street_name;
    char *city;
    char *prov;
    char *postal_code;
};
address temp_address =
    { .city = "Hamilton", .prov = "Ontario" };
```

The links <a href="http://publib.boulder.ibm.com/infocenter/comphelp/v8v101/index.jsp?topic=/com.ibm.xlcpp8a.doc/language/ref/strin.htm" rel="noreferrer">here</a> and <a href="https://stackoverflow.com/questions/5790534/static-structure-initialization-with-tags-in-c">here</a> mention that it is possible to use this style only in C.  If so why is this not possible in C++?  Is there any underlying technical reason why it is not implemented in C++, or is it bad practice to use this style.  I like using this way of initializing because my struct is big and this style gives me clear readability of what value is assigned to which member.  

Please share with me if there are other ways through which we can achieve the same readability.  

I have referred the following links before posting this question  

<ol>
<li><a href="http://publib.boulder.ibm.com/infocenter/comphelp/v8v101/index.jsp?topic=/com.ibm.xlcpp8a.doc/language/ref/strin.htm" rel="noreferrer">C/C++ for AIX</a></li>
<li><a href="https://stackoverflow.com/questions/7700878/c-structure-initialization-with-variable">C Structure Initialization with Variable</a></li>
<li><a href="https://stackoverflow.com/questions/5790534/static-structure-initialization-with-tags-in-c">Static structure initialization with tags in C++</a></li>
<li><a href="https://stackoverflow.com/questions/9557464/c11-proper-structure-initialization">C++11 Proper Structure Initialization</a></li>
</ol>

#### Answer accepted (score 150)
If you want to make it clear what each initializer value is, just split it up on multiple lines, with a comment on each:  

```c++
address temp_addres = {
  0,  // street_no
  nullptr,  // street_name
  "Hamilton",  // city
  "Ontario",  // prov
  nullptr,  // postal_code
};
```

#### Answer 2 (score 94)
After <a href="https://stackoverflow.com/questions/5790534/static-structure-initialization-with-tags-in-c">my question</a> resulted in no satisfying result (because C++ doesn't implement tag-based init for structures), I took the trick I found here: <a href="https://stackoverflow.com/questions/1069621/are-members-of-a-c-struct-initialized-to-0-by-default">Are members of a C++ struct initialized to 0 by default?</a>  

For you it would amount to do that:  

```c++
address temp_address = {}; // will zero all fields in C++
temp_address.city = "Hamilton";
temp_address.prov = "Ontario";
```

This is certainly the closest to what you wanted originally (zero all the fields except those you want to initialize).  

#### Answer 3 (score 15)
As others have mentioned this is designated initializer.  

This feature is part of <a href="https://en.wikipedia.org/wiki/C%2B%2B20" rel="noreferrer">C++20</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: How can I loop through a C++ map of maps? (score [424125](https://stackoverflow.com/q/4844886) in 2019)

#### Question
How can I loop through a `std::map` in C++? My map is defined as:  

```c++
std::map< std::string, std::map<std::string, std::string> >
```

For example, the above container holds data like this:  

```c++
m["name1"]["value1"] = "data1";
m["name1"]["value2"] = "data2";
m["name2"]["value1"] = "data1";
m["name2"]["value2"] = "data2";
m["name3"]["value1"] = "data1";
m["name3"]["value2"] = "data2";
```

How can I loop through this map and access the various values?  

#### Answer accepted (score 555)
Old question but the remaining answers are outdated as of C++11 - you can use a <a href="http://en.cppreference.com/w/cpp/language/range-for" rel="noreferrer">ranged based for loop</a> and simply do:  

```c++
std::map<std::string, std::map<std::string, std::string>> mymap;

for(auto const &ent1 : mymap) {
  // ent1.first is the first key
  for(auto const &ent2 : ent1.second) {
    // ent2.first is the second key
    // ent2.second is the data
  }
}
```

this should be much cleaner than the earlier versions, and avoids unnecessary copies.   

Some favour replacing the comments with explicit definitions of reference variables (which get optimised away if unused):  

```c++
for(auto const &ent1 : mymap) {
  auto const &outer_key = ent1.first;
  auto const &inner_map = ent1.second;
  for(auto const &ent2 : inner_map) {
    auto const &inner_key   = ent2.first;
    auto const &inner_value = ent2.second;
  }
}
```

#### Answer 2 (score 307)
You can use an iterator.  

```c++
typedef std::map<std::string, std::map<std::string, std::string>>::iterator it_type;
for(it_type iterator = m.begin(); iterator != m.end(); iterator++) {
    // iterator->first = key
    // iterator->second = value
    // Repeat if you also want to iterate through the second map.
}
```

#### Answer 3 (score 59)
```c++
for(std::map<std::string, std::map<std::string, std::string> >::iterator outer_iter=map.begin(); outer_iter!=map.end(); ++outer_iter) {
    for(std::map<std::string, std::string>::iterator inner_iter=outer_iter->second.begin(); inner_iter!=outer_iter->second.end(); ++inner_iter) {
        std::cout << inner_iter->second << std::endl;
    }
}
```

or nicer in C++0x:  

```c++
for(auto outer_iter=map.begin(); outer_iter!=map.end(); ++outer_iter) {
    for(auto inner_iter=outer_iter->second.begin(); inner_iter!=outer_iter->second.end(); ++inner_iter) {
        std::cout << inner_iter->second << std::endl;
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: What is the difference between g++ and gcc? (score [422142](https://stackoverflow.com/q/172587) in 2018)

#### Question
What is the difference between g++ and gcc?  Which ones should be used for general c++ development?  

#### Answer accepted (score 673)
`gcc` and `g++` are compiler-drivers of the GNU Compiler <em>Collection</em> (which was once upon a time just the GNU <em>C Compiler</em>).  

Even though they automatically determine which backends (`cc1` `cc1plus` ...) to call depending on the file-type, unless overridden with `-x language`, they have some differences.  

The probably most important difference in their defaults is which libraries they link against automatically.  

According to GCC's online documentation <a href="https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html" rel="noreferrer">link options</a> and <a href="https://gcc.gnu.org/onlinedocs/gcc/Invoking-G_002b_002b.html" rel="noreferrer">how g++ is invoked</a>, `g++` is equivalent to `gcc -xc++ -lstdc++ -shared-libgcc` (the 1st is a compiler option, the 2nd two are linker options). This can be checked by running both with the `-v` option (it displays the backend toolchain commands being run).  

#### Answer 2 (score 413)
GCC: GNU Compiler Collection<br>  

<ul>
<li>Referrers to all the different languages that are supported by the GNU compiler.</li>
</ul>

<p>gcc: GNU C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Compiler<br>
g++: GNU C++ Compiler<br></p>

The main differences:  

<ol>
<li>gcc will compile: *.c/*.cpp files as C and C++ respectively.</li>
<li>g++ will compile: *.c/*.cpp files but they will all be treated as C++ files.</li>
<li>Also if you use g++ to link the object files it automatically links in the std C++ libraries (gcc does not do this).</li>
<li>gcc compiling C files has fewer predefined macros.</li>
<li>gcc compiling *.cpp and g++ compiling *.c/*.cpp files has a few extra macros.</li>
</ol>

Extra Macros when compiling *.cpp files:  

```c++
#define __GXX_WEAK__ 1
#define __cplusplus 1
#define __DEPRECATED 1
#define __GNUG__ 4
#define __EXCEPTIONS 1
#define __private_extern__ extern
```

#### Answer 3 (score 76)
For c++ you should use g++.  

It's the same compiler (e.g. the GNU compiler collection). GCC or G++ just choose a different front-end with different default options.  

In a nutshell: if you use g++ the frontend will tell the linker that you may want to link with the C++ standard libraries. The gcc frontend won't do that (also it could link with them if you pass the right command line options).   

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: How do you make a HTTP request with C++? (score [412466](https://stackoverflow.com/q/1011339) in 2015)

#### Question
Is there any way to easily make a HTTP request with C++?  Specifically, I want to download the contents of a page (an API) and check the contents to see if it contains a 1 or a 0. Is it also possible to download the contents into a string?  

#### Answer accepted (score 228)
I had the same problem. <a href="http://curl.haxx.se/libcurl/" rel="noreferrer">libcurl</a> is really complete. There is a C++ wrapper <a href="http://www.curlpp.org/" rel="noreferrer">curlpp</a> that might interest you as you ask for a C++ library. <a href="http://www.webdav.org/neon/" rel="noreferrer">neon</a> is another interesting C library that also support <a href="https://fr.wikipedia.org/wiki/WebDAV" rel="noreferrer">WebDAV</a>.  

<p>curlpp seems natural if you use C++. There are many examples provided in the source distribution.
To get the content of an URL you do something like that (extracted from examples) :</p>

```c++
// Edit : rewritten for cURLpp 0.7.3
// Note : namespace changed, was cURLpp in 0.7.2 ...

#include <curlpp/cURLpp.hpp>
#include <curlpp/Options.hpp>

// RAII cleanup

curlpp::Cleanup myCleanup;

// Send request and get a result.
// Here I use a shortcut to get it in a string stream ...

std::ostringstream os;
os << curlpp::options::Url(std::string("http://www.wikipedia.org"));

string asAskedInQuestion = os.str();
```

See the `examples` directory in <a href="https://github.com/jpbarrette/curlpp" rel="noreferrer">curlpp source distribution</a>, there is a lot of more complex cases, as well as a <a href="https://github.com/jpbarrette/curlpp/blob/master/examples/example22.cpp" rel="noreferrer">simple complete minimal one</a> using curlpp.  

my 2 cents ...  

#### Answer 2 (score 112)
Windows code:  

```c++
#include <string.h>
#include <winsock2.h>
#include <windows.h>
#include <iostream>
#include <vector>
#include <locale>
#include <sstream>
using namespace std;
#pragma comment(lib,"ws2_32.lib")




int main( void ){

WSADATA wsaData;
SOCKET Socket;
SOCKADDR_IN SockAddr;
int lineCount=0;
int rowCount=0;
struct hostent *host;
locale local;
char buffer[10000];
int i = 0 ;
int nDataLength;
string website_HTML;

// website url
string url = "www.google.com";

//HTTP GET
string get_http = "GET / HTTP/1.1\r\nHost: " + url + "\r\nConnection: close\r\n\r\n";


    if (WSAStartup(MAKEWORD(2,2), &wsaData) != 0){
        cout << "WSAStartup failed.\n";
        system("pause");
        //return 1;
    }

    Socket=socket(AF_INET,SOCK_STREAM,IPPROTO_TCP);
    host = gethostbyname(url.c_str());

    SockAddr.sin_port=htons(80);
    SockAddr.sin_family=AF_INET;
    SockAddr.sin_addr.s_addr = *((unsigned long*)host->h_addr);

    if(connect(Socket,(SOCKADDR*)(&SockAddr),sizeof(SockAddr)) != 0){
        cout << "Could not connect";
        system("pause");
        //return 1;
    }

    // send GET / HTTP
    send(Socket,get_http.c_str(), strlen(get_http.c_str()),0 );

    // recieve html
    while ((nDataLength = recv(Socket,buffer,10000,0)) > 0){        
        int i = 0;
        while (buffer[i] >= 32 || buffer[i] == '\n' || buffer[i] == '\r'){

            website_HTML+=buffer[i];
            i += 1;
        }               
    }

    closesocket(Socket);
    WSACleanup();

    // Display HTML source 
    cout<<website_HTML;

    // pause
    cout<<"\n\nPress ANY key to close.\n\n";
    cin.ignore(); cin.get(); 


 return 0;
}
```

Here is a much better implementation:   

```c++
#include <windows.h>
#include <string>
#include <stdio.h>

using std::string;

#pragma comment(lib,"ws2_32.lib")


HINSTANCE hInst;
WSADATA wsaData;
void mParseUrl(char *mUrl, string &serverName, string &filepath, string &filename);
SOCKET connectToServer(char *szServerName, WORD portNum);
int getHeaderLength(char *content);
char *readUrl2(char *szUrl, long &bytesReturnedOut, char **headerOut);


int main()
{
    const int bufLen = 1024;
    char *szUrl = "http://stackoverflow.com";
    long fileSize;
    char *memBuffer, *headerBuffer;
    FILE *fp;

    memBuffer = headerBuffer = NULL;

    if ( WSAStartup(0x101, &wsaData) != 0)
        return -1;


    memBuffer = readUrl2(szUrl, fileSize, &headerBuffer);
    printf("returned from readUrl\n");
    printf("data returned:\n%s", memBuffer);
    if (fileSize != 0)
    {
        printf("Got some data\n");
        fp = fopen("downloaded.file", "wb");
        fwrite(memBuffer, 1, fileSize, fp);
        fclose(fp);
         delete(memBuffer);
        delete(headerBuffer);
    }

    WSACleanup();
    return 0;
}


void mParseUrl(char *mUrl, string &serverName, string &filepath, string &filename)
{
    string::size_type n;
    string url = mUrl;

    if (url.substr(0,7) == "http://")
        url.erase(0,7);

    if (url.substr(0,8) == "https://")
        url.erase(0,8);

    n = url.find('/');
    if (n != string::npos)
    {
        serverName = url.substr(0,n);
        filepath = url.substr(n);
        n = filepath.rfind('/');
        filename = filepath.substr(n+1);
    }

    else
    {
        serverName = url;
        filepath = "/";
        filename = "";
    }
}

SOCKET connectToServer(char *szServerName, WORD portNum)
{
    struct hostent *hp;
    unsigned int addr;
    struct sockaddr_in server;
    SOCKET conn;

    conn = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (conn == INVALID_SOCKET)
        return NULL;

    if(inet_addr(szServerName)==INADDR_NONE)
    {
        hp=gethostbyname(szServerName);
    }
    else
    {
        addr=inet_addr(szServerName);
        hp=gethostbyaddr((char*)&addr,sizeof(addr),AF_INET);
    }

    if(hp==NULL)
    {
        closesocket(conn);
        return NULL;
    }

    server.sin_addr.s_addr=*((unsigned long*)hp->h_addr);
    server.sin_family=AF_INET;
    server.sin_port=htons(portNum);
    if(connect(conn,(struct sockaddr*)&server,sizeof(server)))
    {
        closesocket(conn);
        return NULL;
    }
    return conn;
}

int getHeaderLength(char *content)
{
    const char *srchStr1 = "\r\n\r\n", *srchStr2 = "\n\r\n\r";
    char *findPos;
    int ofset = -1;

    findPos = strstr(content, srchStr1);
    if (findPos != NULL)
    {
        ofset = findPos - content;
        ofset += strlen(srchStr1);
    }

    else
    {
        findPos = strstr(content, srchStr2);
        if (findPos != NULL)
        {
            ofset = findPos - content;
            ofset += strlen(srchStr2);
        }
    }
    return ofset;
}

char *readUrl2(char *szUrl, long &bytesReturnedOut, char **headerOut)
{
    const int bufSize = 512;
    char readBuffer[bufSize], sendBuffer[bufSize], tmpBuffer[bufSize];
    char *tmpResult=NULL, *result;
    SOCKET conn;
    string server, filepath, filename;
    long totalBytesRead, thisReadSize, headerLen;

    mParseUrl(szUrl, server, filepath, filename);

    ///////////// step 1, connect //////////////////////
    conn = connectToServer((char*)server.c_str(), 80);

    ///////////// step 2, send GET request /////////////
    sprintf(tmpBuffer, "GET %s HTTP/1.0", filepath.c_str());
    strcpy(sendBuffer, tmpBuffer);
    strcat(sendBuffer, "\r\n");
    sprintf(tmpBuffer, "Host: %s", server.c_str());
    strcat(sendBuffer, tmpBuffer);
    strcat(sendBuffer, "\r\n");
    strcat(sendBuffer, "\r\n");
    send(conn, sendBuffer, strlen(sendBuffer), 0);

//    SetWindowText(edit3Hwnd, sendBuffer);
    printf("Buffer being sent:\n%s", sendBuffer);

    ///////////// step 3 - get received bytes ////////////////
    // Receive until the peer closes the connection
    totalBytesRead = 0;
    while(1)
    {
        memset(readBuffer, 0, bufSize);
        thisReadSize = recv (conn, readBuffer, bufSize, 0);

        if ( thisReadSize <= 0 )
            break;

        tmpResult = (char*)realloc(tmpResult, thisReadSize+totalBytesRead);

        memcpy(tmpResult+totalBytesRead, readBuffer, thisReadSize);
        totalBytesRead += thisReadSize;
    }

    headerLen = getHeaderLength(tmpResult);
    long contenLen = totalBytesRead-headerLen;
    result = new char[contenLen+1];
    memcpy(result, tmpResult+headerLen, contenLen);
    result[contenLen] = 0x0;
    char *myTmp;

    myTmp = new char[headerLen+1];
    strncpy(myTmp, tmpResult, headerLen);
    myTmp[headerLen] = NULL;
    delete(tmpResult);
    *headerOut = myTmp;

    bytesReturnedOut = contenLen;
    closesocket(conn);
    return(result);
}
```

#### Answer 3 (score 38)
On Linux, I tried cpp-netlib, libcurl, curlpp, urdl, boost::asio and considered Qt (but turned it down based on the license). All of these were either incomplete for this use, had sloppy interfaces, had poor documentation, were unmaintained or didn't support https.  

Then, at the suggestion of <a href="https://stackoverflow.com/a/1012577/278976">https://stackoverflow.com/a/1012577/278976</a>, I tried POCO. Wow, I wish I had seen this years ago. Here's an example of making an HTTP GET request:  

<a href="http://xjia.heroku.com/2011/09/10/learning-poco-get-with-http/" rel="noreferrer">http://xjia.heroku.com/2011/09/10/learning-poco-get-with-http/</a>  

POCO is free, open source (boost license). And no, I don't have any affiliation with the company; I just really like their interfaces. Great job guys (and gals).  

<a href="http://pocoproject.org/download/index.html" rel="noreferrer">http://pocoproject.org/download/index.html</a>  

Hope this helps someone... it took me three days to try all of these libraries out.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: How do you create a static class in C++? (score [412436](https://stackoverflow.com/q/9321) in 2018)

#### Question
How do you create a static class in C++? I should be able to do something like:  

```c++
cout << "bit 5 is " << BitParser::getBitAt(buffer, 5) << endl;
```

Assuming I created the `BitParser` class. What would the `BitParser` class definition look like?  

#### Answer accepted (score 255)
If you're looking for a way of applying the "static" keyword to a class, like you can in C# for example, then you won't be able to without using Managed C++.  

But the looks of your sample, you just need to create a public static method on your BitParser object. Like so:  

<strong>BitParser.h</strong>  

```c++
class BitParser
{
 public:
  static bool getBitAt(int buffer, int bitIndex);

  // ...lots of great stuff

 private:
  // Disallow creating an instance of this object
  BitParser() {}
};
```

<strong>BitParser.cpp</strong>  

```c++
bool BitParser::getBitAt(int buffer, int bitIndex)
{
  bool isBitSet = false;
  // .. determine if bit is set
  return isBitSet;
}
```

You can use this code to call the method in the same way as your example code.  

Hope that helps! Cheers.  

#### Answer 2 (score 237)
Consider <a href="https://stackoverflow.com/questions/9321/how-do-you-create-a-static-class-in-c/9348#9348">Matt Price's solution</a>.  

<ol>
<li>In C++, a "static class" has no meaning. The nearest thing is a class with only static methods and members.</li>
<li>Using static methods will only limit you.</li>
</ol>

What you want is, expressed in C++ semantics, to put your function (for it <strong>is</strong> a function) in a namespace.  

<h5>Edit 2011-11-11</h2>

There is no "static class" in C++. The nearest concept would be a class with only static methods. For example:  

```c++
// header
class MyClass
{
   public :
      static void myMethod() ;
} ;

// source
void MyClass::myMethod()
{
   // etc.
}
```

But you must remember that "static classes" are hacks in the Java-like kind of languages (e.g. C#) that are unable to have non-member functions, so they have instead to move them inside classes as static methods.  

In C++, what you really want is a non-member function that you'll declare in a namespace:  

```c++
// header
namespace MyNamespace
{
   void myMethod() ;
}

// source
namespace MyNamespace
{
   void myMethod()
   {
      // etc.
   }
}
```

<h5>Why is that?</h3>

In C++, the namespace is more powerful than classes for the "Java static method" pattern, because:  

<ul>
<li>static methods have access to the classes private symbols</li>
<li>private static methods are still visible (if inaccessible) to everyone, which breaches somewhat the encapsulation</li>
<li>static methods cannot be forward-declared</li>
<li>static methods cannot be overloaded by the class user without modifying the library header</li>
<li>there is nothing that can be done by a static method that can't be done better than a (possibly friend) non-member function in the same namespace</li>
<li>namespaces have their own semantics (they can be combined, they can be anonymous, etc.)</li>
<li>etc.</li>
</ul>

Conclusion: Do not copy/paste that Java/C#'s pattern in C++. In Java/C#, the pattern is mandatory. But in C++, it is bad style.  

<h5>Edit 2010-06-10</h2>

There was an argument in favor to the static method because sometimes, one needs to use a static private member variable.  

I disagree somewhat, as show below:  

<h5>The "Static private member" solution</h3>

```c++
// HPP

class Foo
{
   public :
      void barA() ;
   private :
      void barB() ;
      static std::string myGlobal ;
} ;
```

First, myGlobal is called myGlobal because it is still a global private variable. A look at the CPP source will clarify that:  

```c++
// CPP
std::string Foo::myGlobal ; // You MUST declare it in a CPP

void Foo::barA()
{
   // I can access Foo::myGlobal
}

void Foo::barB()
{
   // I can access Foo::myGlobal, too
}

void barC()
{
   // I CAN'T access Foo::myGlobal !!!
}
```

At first sight, the fact the free function barC can't access Foo::myGlobal seems a good thing from an encapsulation viewpoint... It's cool because someone looking at the HPP won't be able (unless resorting to sabotage) to access Foo::myGlobal.  

But if you look at it closely, you'll find that it is a colossal mistake: Not only your private variable must still be declared in the HPP (and so, visible to all the world, despite being private), but you must declare in the same HPP all (as in ALL) functions that will be authorized to access it !!!  

So <b>using a private static member is like walking outside in the nude with the list of your lovers tattooed on your skin : No one is authorized to touch, but everyone is able to peek at. And the bonus: Everyone can have the names of those authorized to play with your privies.</b>  

<p>`private` indeed...
:-D</p>

<h5>The "Anonymous namespaces" solution</h3>

Anonymous namespaces will have the advantage of making things private really private.  

First, the HPP header  

```c++
// HPP

namespace Foo
{
   void barA() ;
}
```

Just to be sure you remarked: There is no useless declaration of barB nor myGlobal. Which means that no one reading the header knows what's hidden behind barA.  

Then, the CPP:  

```c++
// CPP
namespace Foo
{
   namespace
   {
      std::string myGlobal ;

      void Foo::barB()
      {
         // I can access Foo::myGlobal
      }
   }

   void barA()
   {
      // I can access myGlobal, too
   }
}

void barC()
{
   // I STILL CAN'T access myGlobal !!!
}
```

As you can see, like the so-called "static class" declaration, fooA and fooB are still able to access myGlobal. But no one else can. And no one else outside this CPP knows fooB and myGlobal even exist!  

<b>Unlike the "static class" walking on the nude with her address book tattooed on her skin the "anonymous" namespace is fully clothed</b>, which seems quite better encapsulated AFAIK.  

<h5>Does it really matter?</h3>

Unless the users of your code are saboteurs (I'll let you, as an exercise, find how one can access to the private part of a public class using a dirty behaviour-undefined hack...), what's `private` is `private`, even if it is visible in the `private` section of a class declared in a header.  

Still, if you need to add another "private function" with access to the private member, you still must declare it to all the world by modifying the header, which is a paradox as far as I am concerned: <b>If I change the implementation of my code (the CPP part), then the interface (the HPP part) should NOT change.</b> Quoting Leonidas : "<b>This is ENCAPSULATION!</b>"  

<h5>Edit 2014-09-20</h2>

When are classes static methods are actually better than namespaces with non-member functions?  

When you need to group together functions and feed that group to a template:  

```c++
namespace alpha
{
   void foo() ;
   void bar() ;
}

struct Beta
{
   static void foo() ;
   static void bar() ;
};

template <typename T>
struct Gamma
{
   void foobar()
   {
      T::foo() ;
      T::bar() ;
   }
};

Gamma<alpha> ga ; // compilation error
Gamma<Beta> gb ;  // ok
gb.foobar() ;     // ok !!!
```

Because, if a class can be a template parameter, a namespaces cannot.  

#### Answer 3 (score 62)
You can also create a free function in a namespace:  

In BitParser.h  

```c++
namespace BitParser
{
    bool getBitAt(int buffer, int bitIndex);
}
```

In BitParser.cpp  

```c++
namespace BitParser
{
    bool getBitAt(int buffer, int bitIndex)
    {
        //get the bit :)
    }
}
```

In general this would be the preferred way to write the code. When there's no need for an object don't use a class.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: How to make a SIMPLE C++ Makefile? (score [411599](https://stackoverflow.com/q/2481269) in 2015)

#### Question
We are required to use a Makefile to pull everything together for our project but our professor never showed us how to.  

<p>I only have ONE file, `a3driver.cpp`.
The driver imports a class from a location `"/user/cse232/Examples/example32.sequence.cpp"`.</p>

That's it, everything else is contained with the `.cpp`.  

How would I go about making a simple Makefile that creates an executable called `a3a.exe`?  

#### Answer accepted (score 524)
Copied from a wiki post I wrote for physics grad students.  

Since this is for unix the executables have no extensions.  

One thing to note is that `root-config` is a utility which provides the right compilation and linking flags; and the right libraries for building applications against root. That's just a detail related to the original audience for this document.  

<h5>Make Me Baby</h2>

<strong>or You Never Forget The First Time You Got Made</strong>  

A introductory discussion of make, and how to write a simple makefile  

<strong>What is Make? And Why Should I Care?</strong>  

The tool called make is a build dependency manager. That is, it takes care of knowing what commands need to be executed in what order to take your software project from a collection of source files, object files, libraries, headers, etc. etc.---some of which may have changed recently---and turning them into a correct up-to-date version of the program.  

Actually you can use make for other things too, but I'm not going to talk about that.  

<strong>A Trivial Makefile</strong>  

Suppose that you have a directory containing: `tool` `tool.cc` `tool.o` `support.cc` `support.hh`, and  `support.o` which depend on `root` and are supposed to be compiled into a program called `tool`, and suppose that you've been hacking on the source files (which means the existing `tool` is now out of date) and want to compile the program.  

To do this yourself you could  

1) check if either `support.cc` or `support.hh` is newer than `support.o`, and if so run a command like  

```c++
g++ -g -c -pthread -I/sw/include/root support.cc
```

2) check if either `support.hh` or `tool.cc` are newer than `tool.o`, and if so run a command like  

```c++
g++ -g  -c -pthread -I/sw/include/root tool.cc
```

3) check if `tool.o` is newer than `tool`, and if so run a command like  

```c++
g++ -g tool.o support.o -L/sw/lib/root -lCore -lCint -lRIO -lNet -lHist -lGraf -lGraf3d -lGpad -lTree -lRint \
  -lPostscript -lMatrix -lPhysics -lMathCore -lThread -lz -L/sw/lib -lfreetype -lz -Wl,-framework,CoreServices \
  -Wl,-framework,ApplicationServices -pthread -Wl,-rpath,/sw/lib/root -lm -ldl
```

Phew! What a hassle! There is a lot to remember and several chances to make mistakes. (BTW-- The particulars of the command lines exhibited here depend on our software environment. These ones work on my computer.)  

Of course, you could just run all three commands every time. That would work, but doesn't scale well to a substantial piece of software (like DOGS which takes more than 15 minutes to compile from the ground up on my MacBook).  

Instead you could write a file called `makefile` like this:  

```c++
tool: tool.o support.o
    g++ -g -o tool tool.o support.o -L/sw/lib/root -lCore -lCint -lRIO -lNet -lHist -lGraf -lGraf3d -lGpad -lTree -lRint \
        -lPostscript -lMatrix -lPhysics -lMathCore -lThread -lz -L/sw/lib -lfreetype -lz -Wl,-framework,CoreServices \
        -Wl,-framework,ApplicationServices -pthread -Wl,-rpath,/sw/lib/root -lm -ldl

tool.o: tool.cc support.hh
    g++ -g  -c -pthread -I/sw/include/root tool.cc

support.o: support.hh support.cc
    g++ -g -c -pthread -I/sw/include/root support.cc
```

and just type `make` at the command line. which will perform the three steps shown above automatically.  

The un-indented lines here have the form <em>"target: dependencies"</em> and tell make that the associated commands (indented lines) should be run if any of the dependencies are newer than the target. That is the dependency lines describe the logic of what needs to be rebuilt to accommodate changes in various files. If `support.cc` changes that means that `support.o` must be rebuilt, but `tool.o` can be left alone. When `support.o` changes `tool` must be rebuilt.  

The commands associated with each dependency line are set off with a tab (see below) should modify the target (or at least touch it to update the modification time).  

<h5>Variables, Built In Rules, and Other Goodies</h2>

At this point, our makefile is simply remembering the work that needs doing, but we still had to figure out and type each and every needed command in its entirety. It does not have to be that way: make is a powerful language with variables, text manipulation functions, and a whole slew of built-in rules which can make this much easier for us.  

<strong>Make Variables</strong>  

The syntax for accessing a make variable is `$(VAR)`.  

<p>The syntax for assigning to a make variable is: `VAR = A text value of some kind`
(or `VAR := A different text value but ignore this for the moment`).</p>

You can use variables in rules like this improved version of our makefile:  

```c++
CPPFLAGS=-g -pthread -I/sw/include/root 
LDFLAGS=-g
LDLIBS=-L/sw/lib/root -lCore -lCint -lRIO -lNet -lHist -lGraf -lGraf3d -lGpad -lTree -lRint \
       -lPostscript -lMatrix -lPhysics -lMathCore -lThread -lz -L/sw/lib -lfreetype -lz \
       -Wl,-framework,CoreServices -Wl,-framework,ApplicationServices -pthread -Wl,-rpath,/sw/lib/root \
       -lm -ldl

tool: tool.o support.o
    g++ $(LDFLAGS) -o tool tool.o support.o $(LDLIBS) 

tool.o: tool.cc support.hh
    g++ $(CPPFLAGS) -c tool.cc

support.o: support.hh support.cc
    g++ $(CPPFLAGS) -c support.cc
```

which is a little more readable, but still requires a lot of typing  

<strong>Make Functions</strong>  

GNU make supports a variety of functions for accessing information from the filesystem or other commands on the system. In this case we are interested in `$(shell ...)` which expands to the output of the argument(s), and `$(subst opat,npat,text)` which replaces all instances of `opat` with `npat` in text.  

Taking advantage of this gives us:  

```c++
CPPFLAGS=-g $(shell root-config --cflags)
LDFLAGS=-g $(shell root-config --ldflags)
LDLIBS=$(shell root-config --libs)

SRCS=tool.cc support.cc
OBJS=$(subst .cc,.o,$(SRCS))

tool: $(OBJS)
    g++ $(LDFLAGS) -o tool $(OBJS) $(LDLIBS) 

tool.o: tool.cc support.hh
    g++ $(CPPFLAGS) -c tool.cc

support.o: support.hh support.cc
    g++ $(CPPFLAGS) -c support.cc
```

which is easier to type and much more readable.  

Notice that  

<ol>
<li>We are still stating explicitly the dependencies for each object file and the final executable</li>
<li>We've had to explicitly type the compilation rule for both source files </li>
</ol>

<strong>Implicit and Pattern Rules</strong>  

We would generally expect that all c++ source files should be treated the same way, and make provides three ways to state this  

<ol>
<li>suffix rules (considered obsolete in GNU make, but kept for backwards compatibility)</li>
<li>implicit rules</li>
<li>pattern rules </li>
</ol>

Implicit rules are built in, and a few will be discussed below. Pattern rules are specified in a form like  

```c++
%.o: %.c 
    $(CC) $(CFLAGS) $(CPPFLAGS) -c $<
```

which means that object files are generated from c source files by running the command shown, where the "automatic" variable `$&lt;` expands to the name of the first dependency.  

<strong>Built-in Rules</strong>  

Make has a whole host of built in rules that mean that very often, a project can be compile by a very simple makefile, indeed.  

The GNU make built in rule for c source files is the one exhibited above. Similarly we create object files from c++ source files with a rule like `$(CXX) -c $(CPPFLAGS) $(CFLAGS)`  

Single object files are linked using `$(LD) $(LDFLAGS) n.o $(LOADLIBES) $(LDLIBS)`, but this won't work in our case, because we want to link multiple object files.  

<strong>Variables Used By Built-in Rules</strong>  

The built in rules use a  set of standard variables that allow you to specify local environment information (like where to find the ROOT include files) without re-writing all the rules. The ones most likely to be interesting to us are:  

<ul>
<li>`CC` -- the c compiler to use</li>
<li>`CXX` -- the c++ compiler to use</li>
<li>`LD` -- the linker to use</li>
<li>`CFLAGS` -- compilation flag for c source files</li>
<li>`CXXFLAGS` -- compilation flags for c++ source files</li>
<li>`CPPFLAGS` -- flags for the c-preprocessor (typically include file paths and symbols defined on the command line), used by c and c++</li>
<li>`LDFLAGS` -- linker flags</li>
<li>`LDLIBS` -- libraries to link </li>
</ul>

<strong>A Basic Makefile</strong>  

By taking advantage of the built in rules we can simplify our makefile to:  

```c++
CC=gcc
CXX=g++
RM=rm -f
CPPFLAGS=-g $(shell root-config --cflags)
LDFLAGS=-g $(shell root-config --ldflags)
LDLIBS=$(shell root-config --libs)

SRCS=tool.cc support.cc
OBJS=$(subst .cc,.o,$(SRCS))

all: tool

tool: $(OBJS)
    $(CXX) $(LDFLAGS) -o tool $(OBJS) $(LDLIBS) 

tool.o: tool.cc support.hh

support.o: support.hh support.cc

clean:
    $(RM) $(OBJS)

distclean: clean
    $(RM) tool
```

We have also added several standard targets that perform special actions (like cleaning up the source directory).  

Note that when make is invoked without an argument, it uses the first target found in the file (in this case all), but you can also name the target to get which is what makes `make clean` remove the object files in this case.  

We still have all the dependencies hard-coded.  

<strong>Some Mysterious Improvements</strong>  

```c++
CC=gcc
CXX=g++
RM=rm -f
CPPFLAGS=-g $(shell root-config --cflags)
LDFLAGS=-g $(shell root-config --ldflags)
LDLIBS=$(shell root-config --libs)

SRCS=tool.cc support.cc
OBJS=$(subst .cc,.o,$(SRCS))

all: tool

tool: $(OBJS)
    $(CXX) $(LDFLAGS) -o tool $(OBJS) $(LDLIBS) 

depend: .depend

.depend: $(SRCS)
    $(RM) ./.depend
    $(CXX) $(CPPFLAGS) -MM $^>>./.depend;

clean:
    $(RM) $(OBJS)

distclean: clean
    $(RM) *~ .depend

include .depend
```

Notice that  

<ol>
<li>There are no longer any dependency lines for the source files!?!</li>
<li>There is some strange magic related to .depend and depend</li>
<li>If you do `make` then `ls -A` you see a file named `.depend` which contains things that look like make dependency lines </li>
</ol>

<strong>Other Reading</strong>  

<ul>
<li><a href="http://www.gnu.org/software/make/manual/make.html" rel="noreferrer">GNU make manual</a></li>
<li><a href="http://miller.emu.id.au/pmiller/books/rmch/" rel="noreferrer">Recursive Make Considered Harmful</a> on a common way of writing makefiles that is less than optimal, and how to avoid it.</li>
</ul>

<strong>Know Bugs and Historical Notes</strong>  

The input language for make is whitespace sensitive. In particular <em>the action lines following dependencies must start with a tab</em>. But a series of spaces can look the same (and indeed there are editors that will silently convert tabs to spaces or vice versa), which results in a make file that looks right and still doesn't work. This was identified as a bug early on but (<a href="http://www.catb.org/esr/writings/taoup/html/ch15s04.html" rel="noreferrer">the story goes</a>) was not fixed because there were already 10 users.  

#### Answer 2 (score 52)
I've always thought this was easier to learn with a detailed example, so here's how I think of makefiles. For each section you have one line that's not indented and it shows the name of the section followed by dependencies. The dependencies can be either other sections (which will be run before the current section) or files (which if updated will cause the current section to be run again next time you run `make`).  

Here's a quick example (keep in mind that I'm using 4 spaces where I should be using a tab, Stack Overflow won't let me use tabs):  

```c++
a3driver: a3driver.o
    g++ -o a3driver a3driver.o

a3driver.o: a3driver.cpp
    g++ -c a3driver.cpp
```

When you type `make`, it will choose the first section (a3driver). a3driver depends on a3driver.o, so it will go to that section. a3driver.o depends on a3driver.cpp, so it will only run if a3driver.cpp has changed since it was last run. Assuming it has (or has never been run), it will compile a3driver.cpp to a .o file, then go back to a3driver and compile the final executable.  

Since there's only one file, it could even be reduced to:  

```c++
a3driver: a3driver.cpp
    g++ -o a3driver a3driver.cpp
```

The reason I showed the first example is that it shows the power of makefiles. If you need to compile another file, you can just add another section. Here's an example with a secondFile.cpp (which loads in a header named secondFile.h):  

```c++
a3driver: a3driver.o secondFile.o
    g++ -o a3driver a3driver.o secondFile.o

a3driver.o: a3driver.cpp
    g++ -c a3driver.cpp

secondFile.o: secondFile.cpp secondFile.h
    g++ -c secondFile.cpp
```

This way if you change something in secondFile.cpp or secondFile.h and recompile, it will only recompile secondFile.cpp (not a3driver.cpp). Or alternately, if you change something in a3driver.cpp, it won't recompile secondFile.cpp.  

Let me know if you have any questions about it.  

It's also traditional to include a section named "all" and a section named "clean". "all" will usually build all of the executables, and "clean" will remove "build artifacts" like .o files and the executables:  

```c++
all: a3driver ;

clean:
    # -f so this will succeed even if the files don't exist
    rm -f a3driver a3driver.o
```

EDIT: I didn't notice you're on Windows. I think the only difference is changing the `-o a3driver` to `-o a3driver.exe`.  

#### Answer 3 (score 35)
Why does everyone like to list out source files?  A simple find command can take care of that easily.  

Here's an example of a dirt simple C++ Makefile.  Just drop it in a directory containing `.C` files and then type `make`...  

```c++
appname := myapp

CXX := clang++
CXXFLAGS := -std=c++11

srcfiles := $(shell find . -name "*.C")
objects  := $(patsubst %.C, %.o, $(srcfiles))

all: $(appname)

$(appname): $(objects)
    $(CXX) $(CXXFLAGS) $(LDFLAGS) -o $(appname) $(objects) $(LDLIBS)

depend: .depend

.depend: $(srcfiles)
    rm -f ./.depend
    $(CXX) $(CXXFLAGS) -MM $^>>./.depend;

clean:
    rm -f $(objects)

dist-clean: clean
    rm -f *~ .depend

include .depend
```
</section>

