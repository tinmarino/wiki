---
title: Regex <- StackOverflow top 100
category: regex
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: Regular expression to match a line that doesn't contain a word (score [3113595](https://stackoverflow.com/q/406230) in 2019)

#### Question
I know it's possible to match a word and then reverse the matches using other tools (e.g. `grep -v`). However, is it possible to match lines that do not contain a specific word, e.g. `hede`, using a regular expression?   

<h5>Input:</h3>

```perl
hoho
hihi
haha
hede
```

<h5>Code:</h3>

```perl
grep "<Regex for 'doesn't contain hede'>" input
```

<h5>Desired output:</h3>

```perl
hoho
hihi
haha
```

#### Answer accepted (score 5569)
The notion that regex doesn't support inverse matching is not entirely true. You can mimic this behavior by using negative look-arounds:  

```perl
^((?!hede).)*$
```

The regex above will match any string, or line without a line break, <strong>not</strong> containing the (sub)string 'hede'. As mentioned, this is not something regex is "good" at (or should do), but still, it <em>is</em> possible.   

And if you need to match line break chars as well, use the <a href="http://perldoc.perl.org/perlre.html#Modifiers" rel="noreferrer">DOT-ALL modifier</a> (the trailing `s` in the following pattern):  

```perl
/^((?!hede).)*$/s
```

or use it inline:  

```perl
/(?s)^((?!hede).)*$/
```

<em>(where the `/.../` are the regex delimiters, i.e., not part of the pattern)</em>  

If the DOT-ALL modifier is not available, you can mimic the same behavior with the character class `[\s\S]`:  

```perl
/^((?!hede)[\s\S])*$/
```

<h5>Explanation</h2>

A string is just a list of `n` characters. Before, and after each character, there's an empty string. So a list of `n` characters will have `n+1` empty strings. Consider the string `"ABhedeCD"`:  

```perl
    ┌──┬───┬──┬───┬──┬───┬──┬───┬──┬───┬──┬───┬──┬───┬──┬───┬──┐
S = │e1│ A │e2│ B │e3│ h │e4│ e │e5│ d │e6│ e │e7│ C │e8│ D │e9│
    └──┴───┴──┴───┴──┴───┴──┴───┴──┴───┴──┴───┴──┴───┴──┴───┴──┘

index    0      1      2      3      4      5      6      7
```

where the `e`'s are the empty strings. The regex `(?!hede).` looks ahead to see if there's no substring `"hede"` to be seen, and if that is the case (so something else is seen), then the `.` (dot) will match any character except a line break. Look-arounds are also called <em>zero-width-assertions</em> because they don't <em>consume</em> any characters. They only assert/validate something.   

So, in my example, every empty string is first validated to see if there's no `"hede"` up ahead, before a character is consumed by the `.` (dot). The regex `(?!hede).` will do that only once, so it is wrapped in a group, and repeated zero or more times: `((?!hede).)*`. Finally, the start- and end-of-input are anchored to make sure the entire input is consumed: `^((?!hede).)*$`  

As you can see, the input `"ABhedeCD"` will fail because on `e3`, the regex `(?!hede)` fails (there <em>is</em> `"hede"` up ahead!).  

#### Answer 2 (score 697)
Note that the solution to <strong>does not <em>start with</em> “hede”</strong>:  

```perl
^(?!hede).*$
```

is generally much more efficient than the solution to <strong>does not <em>contain</em> “hede”</strong>:  

```perl
^((?!hede).)*$
```

The former checks for “hede” only at the input string’s first position, rather than at every position.  

#### Answer 3 (score 196)
<em>If</em> you're just using it for grep, you can use `grep -v hede` to get all lines which do not contain hede.  

ETA Oh, rereading the question, `grep -v` is probably what you meant by "tools options".  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How to validate an email address in JavaScript (score [2751724](https://stackoverflow.com/q/46155) in 2019)

#### Question
How can an email address be validated in JavaScript?  

#### Answer accepted (score 4568)
Using <a href="http://en.wikipedia.org/wiki/Regular_expression" rel="noreferrer">regular expressions</a> is probably the best way. You can see a bunch of tests <a href="http://jsfiddle.net/ghvj4gy9/embedded/result,js/" rel="noreferrer">here</a> (taken from <a href="https://cs.chromium.org/chromium/src/third_party/blink/web_tests/fast/forms/resources/ValidityState-typeMismatch-email.js?q=ValidityState-typeMismatch-email.js&amp;sq=package:chromium&amp;dr" rel="noreferrer">chromium</a>)  

```perl
function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}
```

Here's the example of regular expresion that accepts unicode:  

```perl
var re = /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
```

But keep in mind that one should not rely only upon JavaScript validation. JavaScript can easily be disabled. This should be validated on the server side as well.  

Here's an example of the above in action:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
function validateEmail(email) {
  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(email);
}

function validate() {
  var $result = $("#result");
  var email = $("#email").val();
  $result.text("");

  if (validateEmail(email)) {
    $result.text(email + " is valid :)");
    $result.css("color", "green");
  } else {
    $result.text(email + " is not valid :(");
    $result.css("color", "red");
  }
  return false;
}

$("#validate").on("click", validate);
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"&gt;&lt;/script&gt;

&lt;form&gt;
  &lt;p&gt;Enter an email address:&lt;/p&gt;
  &lt;input id='email'&gt;
  &lt;button type='submit' id='validate'&gt;Validate!&lt;/button&gt;
&lt;/form&gt;

&lt;h2 id='result'&gt;&lt;/h2&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 719)
Just for completeness, <a href="http://www.regular-expressions.info/email.html" rel="noreferrer">here you have another RFC 2822 compliant regex</a>  

<blockquote>
  The official standard is known as <a href="https://tools.ietf.org/html/rfc2822#section-3.4.1" rel="noreferrer">RFC 2822</a>. It describes the syntax that valid email addresses must adhere to. You can (<strong>but you shouldn't</strong> &mdash; <a href="http://www.regular-expressions.info/email.html" rel="noreferrer">read on</a>) implement it with this regular expression:  
  
  `(?:[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])`  
  
  (...) We get a more practical implementation of RFC 2822 if we omit the syntax using double quotes and square brackets. <strong>It will still match 99.99% of all email addresses in actual use today.</strong>  
  
  `[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?`  
  
  A further change you could make is to allow any two-letter country code top level domain, and only specific generic top level domains. <strong>This regex filters dummy email addresses like `asdf@adsf.adsf`</strong>. You <strong>will need to update it as new top-level domains are added</strong>.  
  
  `[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)\b`  
  
  So even when following official standards, there are still trade-offs to be made. <strong><em>Don't blindly copy regular expressions from online libraries or discussion forums. Always test them on your own data and with your own applications.</em></strong>  
</blockquote>

<sub>Emphasis mine</sub>  

#### Answer 3 (score 714)
I've slightly modified Jaymon's answer for people who want really simple validation in the form of:  

anystring@anystring.anystring  

The regular expression:  

```perl
/\S+@\S+\.\S+/
```

Example JavaScript function:  

```perl
function validateEmail(email) 
{
    var re = /\S+@\S+\.\S+/;
    return re.test(email);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: RegEx match open tags except XHTML self-contained tags (score [2669567](https://stackoverflow.com/q/1732348) in 2012)

#### Question
I need to match all of these opening tags:  

```perl
<p>
<a href="foo">
```

But not these:  

```perl
<br />
<hr class="foo" />
```

I came up with this and wanted to make sure I've got it right. I am only capturing the `a-z`.  

```perl
<([a-z]+) *[^/]*?>
```

I believe it says:  

<ul>
<li>Find a less-than, then</li>
<li>Find (and capture) a-z one or more times, then</li>
<li>Find zero or more spaces, then</li>
<li>Find any character zero or more times, greedy, except `/`, then</li>
<li>Find a greater-than</li>
</ul>

Do I have that right? And more importantly, what do you think?  

#### Answer accepted (score 4420)
You can't parse [X]HTML with regex. Because HTML can't be parsed by regex. Regex is not a tool that can be used to correctly parse HTML. As I have answered in HTML-and-regex questions here so many times before, the use of regex will not allow you to consume HTML. Regular expressions are a tool that is insufficiently sophisticated to understand the constructs employed by HTML. HTML is not a regular language and hence cannot be parsed by regular expressions. Regex queries are not equipped to break down HTML into its meaningful parts. so many times but it is not getting to me. Even enhanced irregular regular expressions as used by Perl are not up to the task of parsing HTML. You will never make me crack. HTML is a language of sufficient complexity that it cannot be parsed by regular expressions. Even Jon Skeet cannot parse HTML using regular expressions. Every time you attempt to parse HTML with regular expressions, the unholy child weeps the blood of virgins, and Russian hackers pwn your webapp. Parsing HTML with regex summons tainted souls into the realm of the living. HTML and regex go together like love, marriage, and ritual infanticide. The &lt;center> cannot hold it is too late. The force of regex and HTML together in the same conceptual space will destroy your mind like so much watery putty. If you parse HTML with regex you are giving in to Them and their blasphemous ways which doom us all to inhuman toil for the One whose Name cannot be expressed in the Basic Multilingual Plane, he comes. HTML-plus-regexp will liquify the n​erves of the sentient whilst you observe, your psyche withering in the onslaught of horror. Rege̿̔̉x-based HTML parsers are the cancer that is killing StackOverflow <i>it is too late it is too late we cannot be saved</i> the trangession of a chi͡ld ensures regex will consume all living tissue (except for HTML which it cannot, as previously prophesied) <i>dear lord help us how can anyone survive this scourge</i> using regex to parse HTML has doomed humanity to an eternity of dread torture and security holes <i>using rege</i>x as a tool to process HTML establishes a brea<i>ch between this world</i> and the dread realm of c͒ͪo͛ͫrrupt entities (like SGML entities, but <i>more corrupt) a mere glimp</i>se of the world of reg​<b>ex parsers for HTML will ins</b>​tantly transport a p<i>rogrammer's consciousness i</i>nto a w<i>orl</i>d of ceaseless screaming, he comes<strike>, the pestilent sl</strike>ithy regex-infection wil​<b>l devour your HT</b>​ML parser, application and existence for all time like Visual Basic only worse <i>he comes he com</i>es <i>do not fi</i>​ght h<b>e com̡e̶s, ̕h̵i</b>​s un̨ho͞ly radiańcé de<i>stro҉ying all enli̍̈́̂̈́ghtenment, HTML tags <b>lea͠ki̧n͘g fr̶ǫm ̡yo​͟ur eye͢s̸ ̛l̕ik͏e liq</b>​uid p</i>ain, the song of re̸gular exp​re<strike>ssion parsing </strike>will exti<i>​nguish the voices of mor​<b>tal man from the sp</b>​here I can see it can you see ̲͚̖͔̙î̩́t̲͎̩̱͔́̋̀ it is beautiful t​</i>he f`inal snuf`fing o<i>f the lie​<b>s of Man ALL IS LOŚ͖̩͇̗̪̏̈́T A</b></i><b>LL I​S L</b>OST th<i>e pon̷y he come</i>s he c̶̮om<strike>es he co</strike><b><strike>me</strike>s t<i>he</i> ich​</b>or permeat<i>es al</i>l MY FAC<i>E MY FACE ᵒh god n<b>o NO NOO̼</b></i><b>O​O N</b>Θ stop t<i>he an​*̶͑̾̾​̅ͫ͏̙̤g͇̫͛͆̾ͫ̑͆l͖͉̗̩̳̟̍ͫͥͨ</i>e̠̅s` ͎a̧͈͖r̽̾̈́͒͑e` n<b>​ot rè̑ͧ̌aͨl̘̝̙̃ͤ͂̾̆ ZA̡͊͠͝LGΌ ISͮ̂҉̯͈͕̹̘̱ T</b>O͇̹̺ͅƝ̴ȳ̳ TH̘<b>Ë͖́̉ ͠P̯͍̭O̚​N̐Y̡ H̸̡̪̯ͨ͊̽̅̾̎Ȩ̬̩̾͛ͪ̈́̀́͘ ̶̧̨̱̹̭̯ͧ̾ͬC̷̙̲̝͖ͭ̏ͥͮ͟Oͮ͏̮̪̝͍M̲̖͊̒ͪͩͬ̚̚͜Ȇ̴̟̟͙̞ͩ͌͝</b>S̨̥̫͎̭ͯ̿̔̀ͅ  

<hr>

Have you tried using an XML parser instead?  

<hr>

<blockquote>
  <strong>Moderator's Note</strong>  
  
  This post is locked to prevent inappropriate edits to its content. The post looks exactly as it is supposed to look - there are no problems with its content. Please do not flag it for our attention.  
</blockquote>

#### Answer 2 (score 3165)
While <em>arbitrary</em> HTML with only a regex is impossible, it's sometimes appropriate to use them for parsing a <em>limited, known</em> set of HTML.    

If you have a small set of HTML pages that you want to scrape data from and then stuff into a database, regexes might work fine.  For example, I recently wanted to get the names, parties, and districts of Australian federal Representatives, which I got off of the Parliament's web site.  This was a limited, one-time job.    

Regexes worked just fine for me, and were very fast to set up.  

#### Answer 3 (score 1984)
I think the flaw here is that HTML is a <a href="http://en.wikipedia.org/wiki/Context-free_grammar" rel="noreferrer">Chomsky Type 2 grammar (context free grammar)</a> and RegEx is a <a href="http://en.wikipedia.org/wiki/Regular_grammar" rel="noreferrer">Chomsky Type 3 grammar (regular grammar)</a>. Since a Type 2 grammar is fundamentally more complex than a Type 3 grammar (see the <a href="http://en.wikipedia.org/wiki/Chomsky_hierarchy" rel="noreferrer">Chomsky hierarchy</a>), it is <em>mathematically impossible</em> to parse XML with RegEx.   

But many will try, some will even claim success - but until others find the fault and totally mess you up.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: Regular expression to check if password is "8 characters including 1 uppercase letter, 1 special character, alphanumeric characters" (score [1708893](https://stackoverflow.com/q/9477906) in 2018)

#### Question
I want a regular expression to check that   

<blockquote>
  a password must be eight characters including one uppercase letter, one special character and alphanumeric characters.  
</blockquote>

And here is my validation expression which is for eight characters including one uppercase letter, one lowercase letter, and one number or special character.  

```perl
(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
```

How I can write it for a password that must be eight characters including one uppercase letter, one special character and alphanumeric characters?  

#### Answer accepted (score 129)
The regular expression you are after will most likely be huge and a nightmare to maintain especially for people who are not that familiar with regular expressions.  

I think it would be easier to break your regex down and do it one bit at a time. It might take a bit more to do, but I am pretty sure that maintaining it and debugging it would be easier. This would also allow you to provide more directed error messages to your users (other than just `Invalid Password`) which should improve user experience.  

From what I am seeing you are pretty fluent in regex, so I would presume that giving you the regular expressions to do what you need would be futile.  

Seeing your comment, this is how I would go about it:  

<ul>
<li><p>Must be eight characters Long: You do not need a regex for this. Using the `.Length` property should be enough.</p></li>
<li><p>Including one uppercase letter: You can use the `[A-Z]+` regular expression. If the string contains at least one upper case letter, this regular expression will yield `true`.</p></li>
<li><p>One special character: You can use either the `\W` which will match any character which is not a letter or a number or else, you can use something like so `[!@#]` to specify a custom list of special characters. Note though that characters such as `$`, `^`, `(` and `)` are special characters in the regular expression language, so they need to be escaped like so: `\$`. So in short, you might use the `\W`.</p></li>
<li><p>Alphanumeric characters: Using the `\w+` should match any letter and number and underscore.</p></li>
</ul>

Take a look at <a href="http://www.regular-expressions.info/reference.html" rel="noreferrer">this</a> tutorial for more information.  

#### Answer 2 (score 101)
```perl
(                   # Start of group
    (?=.*\d)        #   must contain at least one digit
    (?=.*[A-Z])     #   must contain at least one uppercase character
    (?=.*\W)        #   must contain at least one special symbol
       .            #     match anything with previous condition checking
         {8,8}      #        length is exactly 8 characters
)                   # End of group
```

In one line:  

```perl
((?=.*\d)(?=.*[A-Z])(?=.*\W).{8,8})
```

<h5>Edit 2019-05-28:</h2>

You need to match entire input string. So, you can enclose the regex between `^` and `$` to prevent accidentally assuming partial matches as matching entire input:  

```perl
^((?=.*\d)(?=.*[A-Z])(?=.*\W).{8,8})$
```

<h5>Sources:</h2>

<ul>
<li><p><a href="http://www.mkyong.com/regular-expressions/how-to-validate-password-with-regular-expression/" rel="nofollow noreferrer">Password matching expression</a></p></li>
<li><p><a href="http://www.zorched.net/2009/05/08/password-strength-validation-with-regular-expressions/" rel="nofollow noreferrer">Password Strength Validation with Regular Expressions</a></p></li>
</ul>

#### Answer 3 (score 33)
So many answers.... all bad!  

Regular expressions don't have an AND operator, so it's pretty hard to write a regex that matches valid passwords, when validity is defined by something AND something else AND something else...  

But, regular expressions <em>do</em> have an OR operator, so just apply DeMorgan's theorem, and write a regex that matches <em>invalid</em> passwords.  

anything with less than 8 characters <strong>OR</strong> anything with no numbers <strong>OR</strong> anything with no uppercase <strong>OR</strong> anything with no special characters  

So:  

```perl
^(.{0,7}|[^0-9]*|[^A-Z]*|[a-zA-Z0-9]*)$
```

If anything matches that, then it's an <em>invalid</em> password.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Match the path of a URL, minus the filename extension (score [1259727](https://stackoverflow.com/q/8313941) in 2014)

#### Question
What would be the best regular expression for this scenario?  

Given this URL:  

```perl
http://php.net/manual/en/function.preg-match.php
```

How should I go about selecting everything between (but not including) `http://php.net` and `.php`:  

```perl
/manual/en/function.preg-match
```

This is for an <a href="http://en.wikipedia.org/wiki/Nginx" rel="nofollow">Nginx</a> configuration file.  

#### Answer accepted (score 8)
Like this:  

```perl
if (preg_match('/(?<=net).*(?=\.php)/', $subject, $regs)) {
    $result = $regs[0];
}
```

Explanation:  

```perl
"
(?<=      # Assert that the regex below can be matched, with the match ending at this position (positive lookbehind)
   net       # Match the characters “net” literally
)
.         # Match any single character that is not a line break character
   *         # Between zero and unlimited times, as many times as possible, giving back as needed (greedy)
(?=       # Assert that the regex below can be matched, starting at this position (positive lookahead)
   \.        # Match the character “.” literally
   php       # Match the characters “php” literally
)
"
```

#### Answer 2 (score 20)
A regular expression might not be the most effective tool for this job.  

Try using <a href="http://php.net/parse_url" rel="noreferrer">`parse_url()`</a>, combined with <a href="http://php.net/pathinfo" rel="noreferrer">`pathinfo()`</a>:  

```perl
$url      = 'http://php.net/manual/en/function.preg-match.php';
$path     = parse_url($url, PHP_URL_PATH);
$pathinfo = pathinfo($path);

echo $pathinfo['dirname'], '/', $pathinfo['filename'];
```

The above code outputs:  

<pre>/manual/en/function.preg-match</pre>

#### Answer 3 (score 3)
There's no need to use a regular expression to dissect a URL. PHP has built-in functions for this, <a href="http://www.php.net/pathinfo" rel="nofollow">pathinfo()</a> and <a href="http://www.php.net/parse_url" rel="nofollow">parse_url()</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: How to validate an email address using a regular expression? (score [1146192](https://stackoverflow.com/q/201323) in 2018)

#### Question
Over the years I have slowly developed a <a href="http://en.wikipedia.org/wiki/Regular_expression" rel="noreferrer">regular expression</a> that validates MOST email addresses correctly, assuming they don't use an IP address as the server part.  

I use it in several PHP programs, and it works most of the time.  However, from time to time I get contacted by someone that is having trouble with a site that uses it, and I end up having to make some adjustment (most recently I realized that I wasn't allowing 4-character TLDs).  

<em>What is the best regular expression you have or have seen for validating emails?</em>  

I've seen several solutions that use functions that use several shorter expressions, but I'd rather have one long complex expression in a simple function instead of several short expression in a more complex function.  

#### Answer accepted (score 2310)
The <a href="http://ex-parrot.com/~pdw/Mail-RFC822-Address.html" rel="noreferrer">fully RFC 822 compliant regex</a> is inefficient and obscure because of its length.  Fortunately, RFC 822 was superseded twice and the current specification for email addresses is <a href="http://www.ietf.org/rfc/rfc5322.txt" rel="noreferrer">RFC 5322</a>.  RFC 5322 leads to a regex that can be understood if studied for a few minutes and is efficient enough for actual use.  

One RFC 5322 compliant regex can be found at the top of the page at <a href="http://emailregex.com/" rel="noreferrer">http://emailregex.com/</a> but uses the IP address pattern that is floating around the internet with a bug that allows `00` for any of the unsigned byte decimal values in a dot-delimited address, which is illegal.  The rest of it appears to be consistent with the RFC 5322 grammar and passes several tests using `grep -Po`, including cases domain names, IP addresses, bad ones, and account names with and without quotes.  

Correcting the `00` bug in the IP pattern, we obtain a working and fairly fast regex.  (Scrape the rendered version, not the markdown, for actual code.)  

<blockquote>
  (?:[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&amp;'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])  
</blockquote>

<p>Here is <a href="https://regexper.com/#(%3F%3A%5Ba-z0-9!%23%24%25%26&#39;*%2B%2F%3D%3F%5E_%60%7B%7C%7D~-%5D%2B(%3F%3A%5C.%5Ba-z0-9!%23%24%25%26&#39;*%2B%2F%3D%3F%5E_%60%7B%7C%7D~-%5D%2B)*%7C%22(%3F%3A%5B%5Cx01-%5Cx08%5Cx0b%5Cx0c%5Cx0e-%5Cx1f%5Cx21%5Cx23-%5Cx5b%5Cx5d-%5Cx7f%5D%7C%5C%5C%5B%5Cx01-%5Cx09%5Cx0b%5Cx0c%5Cx0e-%5Cx7f%5D)*%22)%40(%3F%3A(%3F%3A%5Ba-z0-9%5D(%3F%3A%5Ba-z0-9-%5D*%5Ba-z0-9%5D)%3F%5C.)%2B%5Ba-z0-9%5D(%3F%3A%5Ba-z0-9-%5D*%5Ba-z0-9%5D)%3F%7C%5C%5B(%3F%3A(%3F%3A(2(5%5B0-5%5D%7C%5B0-4%5D%5B0-9%5D)%7C1%5B0-9%5D%5B0-9%5D%7C%5B1-9%5D%3F%5B0-9%5D))%5C.)%7B3%7D(%3F%3A(2(5%5B0-5%5D%7C%5B0-4%5D%5B0-9%5D)%7C1%5B0-9%5D%5B0-9%5D%7C%5B1-9%5D%3F%5B0-9%5D)%7C%5Ba-z0-9-%5D*%5Ba-z0-9%5D%3A(%3F%3A%5B%5Cx01-%5Cx08%5Cx0b%5Cx0c%5Cx0e-%5Cx1f%5Cx21-%5Cx5a%5Cx53-%5Cx7f%5D%7C%5C%5C%5B%5Cx01-%5Cx09%5Cx0b%5Cx0c%5Cx0e-%5Cx7f%5D)%2B)%5C%5D)" rel="noreferrer">diagram</a> of <a href="https://en.wikipedia.org/wiki/Finite-state_machine" rel="noreferrer">finite state machine</a> for above regexp which is more clear than regexp itself
<a href="https://i.stack.imgur.com/YI6KR.png" rel="noreferrer"><img src="https://i.stack.imgur.com/YI6KR.png" alt="enter image description here"></a></p>

The more sophisticated patterns in Perl and PCRE (regex library used e.g. in PHP) can <a href="https://stackoverflow.com/questions/201323/what-is-the-best-regular-expression-for-validating-email-addresses/1917982#1917982">correctly parse RFC 5322 without a hitch</a>. Python and C# can do that too, but they use a different syntax from those first two. However, if you are forced to use one of the many less powerful pattern-matching languages, then it’s best to use a real parser.  

It's also important to understand that validating it per the RFC tells you absolutely nothing about whether that address actually exists at the supplied domain, or whether the person entering the address is its true owner. People sign others up to mailing lists this way all the time. Fixing that requires a fancier kind of validation that involves sending that address a message that includes a confirmation token meant to be entered on the same web page as was the address.   

Confirmation tokens are the only way to know you got the address of the person entering it. This is why most mailing lists now use that mechanism to confirm sign-ups. After all, anybody can put down `president@whitehouse.gov`, and that will even parse as legal, but it isn't likely to be the person at the other end.  

For PHP, you should <em>not</em> use the pattern given in <a href="http://www.linuxjournal.com/article/9585" rel="noreferrer">Validate an E-Mail Address with PHP, the Right Way</a> from which I quote:  

<blockquote>
  There is some danger that common usage and widespread sloppy coding will establish a de facto standard for e-mail addresses that is more restrictive than the recorded formal standard.  
</blockquote>

That is no better than all the other non-RFC patterns. It isn’t even smart enough to handle even <a href="http://www.ietf.org/rfc/rfc0822.txt" rel="noreferrer">RFC 822</a>, let alone RFC 5322. <a href="https://stackoverflow.com/questions/201323/what-is-the-best-regular-expression-for-validating-email-addresses/1917982#1917982">This one</a>, however, is.  

If you want to get fancy and pedantic, <a href="http://cubicspot.blogspot.com/2012/06/correct-way-to-validate-e-mail-address.html" rel="noreferrer">implement a complete state engine</a>. A regular expression can only act as a rudimentary filter. The problem with regular expressions is that telling someone that their perfectly valid e-mail address is invalid (a false positive) because your regular expression can't handle it is just rude and impolite from the user's perspective. A state engine for the purpose can both validate and even correct e-mail addresses that would otherwise be considered invalid as it disassembles the e-mail address according to each RFC. This allows for a potentially more pleasing experience, like  

<blockquote>
  The specified e-mail address 'myemail@address,com' is invalid. Did you mean 'myemail@address.com'?  
</blockquote>

See also <a href="http://worsethanfailure.com/Articles/Validating_Email_Addresses.aspx" rel="noreferrer">Validating Email Addresses</a>, including the comments. Or <a href="http://fightingforalostcause.net/misc/2006/compare-email-regex.php" rel="noreferrer">Comparing E-mail Address Validating Regular Expressions</a>.  

<a href="https://i.stack.imgur.com/SrUwP.png" rel="noreferrer"><img src="https://i.stack.imgur.com/SrUwP.png" alt="Regular expression visualization"></a>  

<a href="https://www.debuggex.com/r/aH_x42NflV8G-GS7" rel="noreferrer">Debuggex Demo</a>  

#### Answer 2 (score 738)
You should not use regular expressions to validate email addresses.  

Instead, use the <a href="http://msdn.microsoft.com/en-us/library/system.net.mail.mailaddress.aspx" rel="noreferrer">MailAddress</a> class, like this:  

```perl
try {
    address = new MailAddress(address).Address;
} catch(FormatException) {
    //address is invalid
}
```

The MailAddress class uses a BNF parser to validate the address in full accordance with RFC822.  

If you really want to use a regex, <a href="http://www.ex-parrot.com/~pdw/Mail-RFC822-Address.html" rel="noreferrer">here it is</a>:          

<pre>(?:(?:\r\n)?[ \t])*(?:(?:(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t]
)+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:
\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(
?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ 
\t]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\0
31]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\
](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+
(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:
(?:\r\n)?[ \t])*))*|(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z
|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)
?[ \t])*)*\&lt;(?:(?:\r\n)?[ \t])*(?:@(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\
r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[
 \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)
?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t]
)*))*(?:,@(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[
 \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*
)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t]
)+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*)
*:(?:(?:\r\n)?[ \t])*)?(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+
|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r
\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:
\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t
]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031
]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](
?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?
:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?
:\r\n)?[ \t])*))*\&gt;(?:(?:\r\n)?[ \t])*)|(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?
:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?
[ \t]))*"(?:(?:\r\n)?[ \t])*)*:(?:(?:\r\n)?[ \t])*(?:(?:(?:[^()&lt;&gt;@,;:\\".\[\] 
\000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|"(?:[^\"\r\\]|
\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;

@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|"
(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t]
)*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\
".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?
:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[
\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*|(?:[^()&lt;&gt;@,;:\\".\[\] \000-
\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(
?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)*\&lt;(?:(?:\r\n)?[ \t])*(?:@(?:[^()&lt;&gt;@,;
:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([
^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\"
.\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\
]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*(?:,@(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\
[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\
r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] 
\000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]
|\\.)*\](?:(?:\r\n)?[ \t])*))*)*:(?:(?:\r\n)?[ \t])*)?(?:[^()&lt;&gt;@,;:\\".\[\] \0
00-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\
.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,
;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|"(?
:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t])*
(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".
\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[
^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]
]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*\&gt;(?:(?:\r\n)?[ \t])*)(?:,\s*(
?:(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\
".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:\.(?:(
?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[
\["()&lt;&gt;@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t
])*))*@(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t
])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?
:\.(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|
\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*|(?:
[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\
]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)*\&lt;(?:(?:\r\n)
?[ \t])*(?:@(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["
()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)
?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;

@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*(?:,@(?:(?:\r\n)?[
 \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,
;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t]
)*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\
".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*)*:(?:(?:\r\n)?[ \t])*)?
(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()&lt;&gt;@,;:\\".
\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:\.(?:(?:
\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\[
"()&lt;&gt;@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])
*))*@(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])
+|\Z|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\
.(?:(?:\r\n)?[ \t])*(?:[^()&lt;&gt;@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z
|(?=[\["()&lt;&gt;@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*\&gt;(?:(
?:\r\n)?[ \t])*))*)?;\s*)</pre>

#### Answer 3 (score 527)
This question is asked a lot, but I think you should step back and ask yourself <em>why</em> you want to validate email adresses syntactically? What is the benefit really?  

<ul>
<li>It will not catch common typos.</li>
<li>It does not prevent people from entering invalid or made-up email addresses, or entering someone else's address. </li>
</ul>

If you want to validate that an email is correct, you have no choice than to send an confirmation email and have the user reply to that. In many cases you will <em>have</em> to send a confirmation mail anyway for security reasons or for ethical reasons (so you cannot e.g. sign someone up to a service against their will).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: Regular Expression for alphanumeric and underscores (score [1010986](https://stackoverflow.com/q/336210) in )

#### Question
I would like to have a regular expression that checks if a string contains only upper and lowercase letters, numbers, and underscores.  

#### Answer 2 (score 869)
To match a string that contains <em>only</em> those characters (or an empty string), try  

```perl
"^[a-zA-Z0-9_]*$"
```

This works for .NET regular expressions, and probably a lot of other languages as well.  

Breaking it down:  

```perl
^ : start of string
[ : beginning of character group
a-z : any lowercase letter
A-Z : any uppercase letter
0-9 : any digit
_ : underscore
] : end of character group
* : zero or more of the given characters
$ : end of string
```

If you don't want to allow empty strings, use + instead of *.  

<strong>EDIT</strong> As others have pointed out, some regex languages have a shorthand form for `[a-zA-Z0-9_]`. In the .NET regex language, you can turn on ECMAScript behavior and use `\w` as a shorthand (yielding `^\w*$` or `^\w+$`). Note that in other languages, and by default in .NET, `\w` is somewhat broader, and will match other sorts of unicode characters as well (thanks to Jan for pointing this out). So if you're really intending to match <strong>only</strong> those characters, using the explicit (longer) form is probably best.  

#### Answer 3 (score 318)
There's a lot of verbosity in here, and I'm deeply against it, so, my conclusive answer would be:  

```perl
/^\w+$/
```

`\w` is equivalent to `[A-Za-z0-9_]`, which is pretty much what you want. (unless we introduce unicode to the mix)  

Using the `+` quantifier you'll match one or more characters. If you want to accept an empty string too, use `*` instead.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: A comprehensive regex for phone number validation (score [876411](https://stackoverflow.com/q/123559) in 2017)

#### Question
I'm trying to put together a comprehensive regex to validate phone numbers. Ideally it would handle international formats, but it must handle US formats, including the following:  

<ul>
<li>1-234-567-8901</li>
<li>1-234-567-8901 x1234</li>
<li>1-234-567-8901 ext1234</li>
<li>1 (234) 567-8901</li>
<li>1.234.567.8901</li>
<li>1/234/567/8901</li>
<li>12345678901</li>
</ul>

I'll answer with my current attempt, but I'm hoping somebody has something better and/or more elegant.  

#### Answer accepted (score 511)
Better option... just strip all non-digit characters on input (except 'x' and leading '+' signs), taking care because of the British tendency to write numbers in the non-standard form `+44 (0) ...` when asked to use the international prefix (in that specific case, you should discard the `(0)` entirely).  

Then, you end up with values like:  

```perl
 12345678901
 12345678901x1234
 345678901x1234
 12344678901
 12345678901
 12345678901
 12345678901
 +4112345678
 +441234567890
```

Then when you display, reformat to your hearts content. e.g.  

```perl
  1 (234) 567-8901
  1 (234) 567-8901 x1234
```

#### Answer 2 (score 296)
It turns out that there's something of a spec for this, at least for North America, called the <a href="http://en.wikipedia.org/wiki/North_American_Numbering_Plan" rel="noreferrer">NANP</a>.   

You need to specify exactly what you want. What are legal delimiters? Spaces, dashes, and periods? No delimiter allowed? Can one mix delimiters (e.g., +0.111-222.3333)? How are extensions (e.g., 111-222-3333 x 44444) going to be handled? What about special numbers, like 911? Is the area code going to be optional or required?   

Here's a regex for a 7 or 10 digit number, with extensions allowed, delimiters are spaces, dashes, or periods:  

```perl
^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$
```

#### Answer 3 (score 293)
```perl
.*
```

If the user wants to give you his phone number, then trust him to get it right.  If he does not want to give it to you then forcing him to enter a valid number will either send him to a competitor's site or make him enter a random string that fits your regex.  I might even be tempted to look up the number of a premium rate sex line and enter that instead.  

I would also consider any of the following as valid entries on a web site:  

```perl
"123 456 7890 until 6pm, then 098 765 4321"  
"123 456 7890 or try my mobile on 098 765 4321"  
"ex-directory - mind your own business"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: How to use Regular Expressions (Regex) in Microsoft Excel both in-cell and loops (score [800567](https://stackoverflow.com/q/22542834) in 2019)

#### Question
How can I use regular expressions in Excel and take advantage of Excel's powerful grid-like setup for data manipulation?  

<ul>
<li>In-cell function to return a matched pattern or replaced value in a string.</li>
<li>Sub to loop through a column of data and extract matches to adjacent cells.</li>
<li>What setup is necessary?</li>
<li>What are Excel's special characters for Regular expressions?</li>
</ul>

<hr>

I understand Regex is not ideal for many situations (<a href="https://stackoverflow.com/a/4098123/2521004">To use or not to use regular expressions?</a>) since excel can use `Left`, `Mid`, `Right`, `Instr` type commands for similar manipulations.    

#### Answer accepted (score 883)
<a href="http://en.wikipedia.org/wiki/Regular_expressions" rel="noreferrer">Regular expressions</a> are used for Pattern Matching.    

To use in Excel follow these steps :  

<strong>Step 1</strong>: Add VBA reference to "Microsoft VBScript Regular Expressions 5.5"  

<ul>
<li>Select "Developer" tab (<a href="http://msdn.microsoft.com/en-us/library/bb608625.aspx" rel="noreferrer">I don't have this tab what do I do?</a>)</li>
<li>Select "Visual Basic" icon from 'Code' ribbon section</li>
<li>In "Microsoft Visual Basic for Applications" window select "Tools" from the top menu.</li>
<li>Select "References"</li>
<li>Check the box next to "Microsoft VBScript Regular Expressions 5.5" to include in your workbook.</li>
<li>Click "OK"</li>
</ul>

<strong>Step 2</strong>: Define your pattern  

<em>Basic definitions:</em>  

`-`  Range.    

<ul>
<li>E.g. `a-z` matches an lower case letters from a to z</li>
<li>E.g. `0-5` matches any number from 0 to 5</li>
</ul>

`[]` Match exactly one of the objects inside these brackets.  

<ul>
<li>E.g. `[a]` matches the letter a</li>
<li>E.g. `[abc]` matches a single letter which can be a, b or c</li>
<li>E.g. `[a-z]` matches any single lower case letter of the alphabet.</li>
</ul>

`()` Groups different matches for return purposes.  See examples below.  

`{}` Multiplier for repeated copies of pattern defined before it.  

<ul>
<li>E.g. `[a]{2}` matches two consecutive lower case letter a: `aa`</li>
<li>E.g. `[a]{1,3}` matches at least one and up to three lower case letter `a`, `aa`, `aaa`           </li>
</ul>

`+`  Match at least one, or more, of the pattern defined before it.  

<ul>
<li>E.g. `a+` will match consecutive a's `a`, `aa`, `aaa`, and so on</li>
</ul>

`?`  Match zero or one of the pattern defined before it.  

<ul>
<li>E.g. Pattern may or may not be present but can only be matched one time.</li>
<li>E.g. `[a-z]?` matches empty string or any single lower case letter.</li>
</ul>

<p>`*`  Match zero or more of the pattern defined before it.
 - E.g. Wildcard for pattern that may or may not be present.
 - E.g. `[a-z]*` matches empty string or string of lower case letters.</p>

`.`  Matches any character except newline `\n`  

<ul>
<li>E.g. `a.` Matches a two character string starting with a and ending with anything except `\n`</li>
</ul>

`|`  OR operator   

<ul>
<li>E.g. `a|b` means either `a` or `b` can be matched.</li>
<li>E.g. `red|white|orange` matches exactly one of the colors.</li>
</ul>

`^`  NOT operator  

<ul>
<li>E.g. `[^0-9]` character can not contain a number</li>
<li>E.g. `[^aA]` character can not be lower case `a` or upper case `A`</li>
</ul>

`\`  Escapes special character that follows (overrides above behavior)  

<ul>
<li>E.g. `\.`, `\\`, `\(`, `\?`, `\$`, `\^`</li>
</ul>

<hr>

<em>Anchoring Patterns:</em>  

`^`  Match must occur at start of string  

<ul>
<li>E.g. `^a` First character must be lower case letter `a`</li>
<li>E.g. `^[0-9]` First character must be a number.</li>
</ul>

`$`  Match must occur at end of string  

<ul>
<li>E.g. `a$` Last character must be lower case letter `a`   </li>
</ul>

<hr>

<em>Precedence table:</em>  

```perl
Order  Name                Representation
1      Parentheses         ( )
2      Multipliers         ? + * {m,n} {m, n}?
3      Sequence & Anchors  abc ^ $
4      Alternation         |
```

<hr>

<em>Predefined Character Abbreviations:</em>  

```perl
abr    same as       meaning
\d     [0-9]         Any single digit
\D     [^0-9]        Any single character that's not a digit
\w     [a-zA-Z0-9_]  Any word character
\W     [^a-zA-Z0-9_] Any non-word character
\s     [ \r\t\n\f]   Any space character
\S     [^ \r\t\n\f]  Any non-space character
\n     [\n]          New line
```

<hr>

<strong>Example 1</strong>: <em>Run as macro</em>  

The following example macro looks at the value in cell `A1` to see if the first 1 or 2 characters are digits.  If so, they are removed and the rest of the string is displayed.  If not, then a box appears telling you that no match is found.  Cell `A1` values of `12abc` will return `abc`, value of `1abc` will return `abc`, value of `abc123` will return "Not Matched" because the digits were not at the start of the string.  

```perl
Private Sub simpleRegex()
    Dim strPattern As String: strPattern = "^[0-9]{1,2}"
    Dim strReplace As String: strReplace = ""
    Dim regEx As New RegExp
    Dim strInput As String
    Dim Myrange As Range

    Set Myrange = ActiveSheet.Range("A1")

    If strPattern <> "" Then
        strInput = Myrange.Value

        With regEx
            .Global = True
            .MultiLine = True
            .IgnoreCase = False
            .Pattern = strPattern
        End With

        If regEx.Test(strInput) Then
            MsgBox (regEx.Replace(strInput, strReplace))
        Else
            MsgBox ("Not matched")
        End If
    End If
End Sub
```

<hr>

<strong>Example 2</strong>: <em>Run as an in-cell function</em>  

This example is the same as example 1 but is setup to run as an in-cell function. To use, change the code to this:  

```perl
Function simpleCellRegex(Myrange As Range) As String
    Dim regEx As New RegExp
    Dim strPattern As String
    Dim strInput As String
    Dim strReplace As String
    Dim strOutput As String


    strPattern = "^[0-9]{1,3}"

    If strPattern <> "" Then
        strInput = Myrange.Value
        strReplace = ""

        With regEx
            .Global = True
            .MultiLine = True
            .IgnoreCase = False
            .Pattern = strPattern
        End With

        If regEx.test(strInput) Then
            simpleCellRegex = regEx.Replace(strInput, strReplace)
        Else
            simpleCellRegex = "Not matched"
        End If
    End If
End Function
```

Place your strings ("12abc") in cell `A1`.  Enter this formula `=simpleCellRegex(A1)` in cell `B1` and the result will be "abc".  

<img src="https://i.stack.imgur.com/q3RRC.png" alt="enter image description here">  

<hr>

<strong>Example 3</strong>: <em>Loop Through Range</em>  

This example is the same as example 1 but loops through a range of cells.  

```perl
Private Sub simpleRegex()
    Dim strPattern As String: strPattern = "^[0-9]{1,2}"
    Dim strReplace As String: strReplace = ""
    Dim regEx As New RegExp
    Dim strInput As String
    Dim Myrange As Range

    Set Myrange = ActiveSheet.Range("A1:A5")

    For Each cell In Myrange
        If strPattern <> "" Then
            strInput = cell.Value

            With regEx
                .Global = True
                .MultiLine = True
                .IgnoreCase = False
                .Pattern = strPattern
            End With

            If regEx.Test(strInput) Then
                MsgBox (regEx.Replace(strInput, strReplace))
            Else
                MsgBox ("Not matched")
            End If
        End If
    Next
End Sub
```

<hr>

<strong>Example 4</strong>: Splitting apart different patterns  

This example loops through a range (`A1`, `A2` &amp; `A3`) and looks for a string starting with three digits followed by a single alpha character and then 4 numeric digits.  The output splits apart the pattern matches into adjacent cells by using the `()`.  `$1` represents the first pattern matched within the first set of `()`.  

```perl
Private Sub splitUpRegexPattern()
    Dim regEx As New RegExp
    Dim strPattern As String
    Dim strInput As String
    Dim Myrange As Range

    Set Myrange = ActiveSheet.Range("A1:A3")

    For Each C In Myrange
        strPattern = "(^[0-9]{3})([a-zA-Z])([0-9]{4})"

        If strPattern <> "" Then
            strInput = C.Value

            With regEx
                .Global = True
                .MultiLine = True
                .IgnoreCase = False
                .Pattern = strPattern
            End With

            If regEx.test(strInput) Then
                C.Offset(0, 1) = regEx.Replace(strInput, "$1")
                C.Offset(0, 2) = regEx.Replace(strInput, "$2")
                C.Offset(0, 3) = regEx.Replace(strInput, "$3")
            Else
                C.Offset(0, 1) = "(Not matched)"
            End If
        End If
    Next
End Sub
```

Results:  

<img src="https://i.stack.imgur.com/9eCZ5.png" alt="enter image description here">  

<hr>

<strong>Additional Pattern Examples</strong>  

```perl
String   Regex Pattern                  Explanation
a1aaa    [a-zA-Z][0-9][a-zA-Z]{3}       Single alpha, single digit, three alpha characters
a1aaa    [a-zA-Z]?[0-9][a-zA-Z]{3}      May or may not have preceeding alpha character
a1aaa    [a-zA-Z][0-9][a-zA-Z]{0,3}     Single alpha, single digit, 0 to 3 alpha characters
a1aaa    [a-zA-Z][0-9][a-zA-Z]*         Single alpha, single digit, followed by any number of alpha characters

</i8>    \<\/[a-zA-Z][0-9]\>            Exact non-word character except any single alpha followed by any single digit
```

#### Answer 2 (score 190)
To make use of regular expressions directly in Excel formulas the following UDF (user defined function) can be of help. It more or less directly exposes regular expression functionality as an excel function.  

<h5>How it works</h2>

It takes 2-3 parameters.  

<ol>
<li>A text to use the regular expression on.</li>
<li>A regular expression.</li>
<li>A format string specifying how the result should look. It can contain `$0`, `$1`, `$2`, and so on. `$0` is the entire match, `$1` and up correspond to the respective match groups in the regular expression. Defaults to `$0`.</li>
</ol>

<h5>Some examples</h2>

Extracting an email address:  

```perl
=regex("Peter Gordon: some@email.com, 47", "\w+@\w+\.\w+")
=regex("Peter Gordon: some@email.com, 47", "\w+@\w+\.\w+", "$0")
```

Results in: `some@email.com`  

Extracting several substrings:  

```perl
=regex("Peter Gordon: some@email.com, 47", "^(.+): (.+), (\d+)$", "E-Mail: $2, Name: $1")
```

Results in: `E-Mail: some@email.com, Name: Peter Gordon`  

To take apart a combined string in a single cell into its components in multiple cells:  

```perl
=regex("Peter Gordon: some@email.com, 47", "^(.+): (.+), (\d+)$", "$" & 1)
=regex("Peter Gordon: some@email.com, 47", "^(.+): (.+), (\d+)$", "$" & 2)
```

Results in: `Peter Gordon` `some@email.com` ...  

<h5>How to use</h2>

To use this UDF do the following (roughly based on <a href="https://support.office.com/en-in/article/Create-Custom-Functions-in-Excel-2007-2f06c10b-3622-40d6-a1b2-b6748ae8231f" title="This Microsoft page">this Microsoft page</a>. They have some good additional info there!):  

<ol>
<li>In Excel in a Macro enabled file ('.xlsm') push `ALT+F11` to open the <em>Microsoft Visual Basic for Applications</em> Editor.</li>
<li>Add VBA reference to the Regular Expressions library (shamelessly copied from <a href="/questions/22542834/how-to-use-regular-expressions-regex-in-microsoft-excel-both-in-cell-and-loops#answer-22542835">Portland Runners++ answer</a>):

<ol>
<li>Click on <em>Tools</em> -> <em>References</em> (please excuse the german screenshot)
<img src="https://i.stack.imgur.com/etyH4.png" alt="Tools -&gt; References"></li>
<li>Find <em>Microsoft VBScript Regular Expressions 5.5</em> in the list and tick the checkbox next to it.</li>
<li>Click <em>OK</em>.</li>
</ol></li>
<li><p>Click on <em>Insert Module</em>. If you give your module a different name make sure the Module does <em>not</em> have the same name as the UDF below (e.g. naming the Module `Regex` and the function `regex` causes <em>#NAME!</em> errors).</p>

<img src="https://i.stack.imgur.com/nlTpn.png" alt="Second icon in the icon row -&gt; Module">  </li>
<li><p>In the big text window in the middle insert the following:</p>

```perl
Function regex(strInput As String, matchPattern As String, Optional ByVal outputPattern As String = "$0") As Variant
    Dim inputRegexObj As New VBScript_RegExp_55.RegExp, outputRegexObj As New VBScript_RegExp_55.RegExp, outReplaceRegexObj As New VBScript_RegExp_55.RegExp
    Dim inputMatches As Object, replaceMatches As Object, replaceMatch As Object
    Dim replaceNumber As Integer

    With inputRegexObj
        .Global = True
        .MultiLine = True
        .IgnoreCase = False
        .Pattern = matchPattern
    End With
    With outputRegexObj
        .Global = True
        .MultiLine = True
        .IgnoreCase = False
        .Pattern = "\$(\d+)"
    End With
    With outReplaceRegexObj
        .Global = True
        .MultiLine = True
        .IgnoreCase = False
    End With

    Set inputMatches = inputRegexObj.Execute(strInput)
    If inputMatches.Count = 0 Then
        regex = False
    Else
        Set replaceMatches = outputRegexObj.Execute(outputPattern)
        For Each replaceMatch In replaceMatches
            replaceNumber = replaceMatch.SubMatches(0)
            outReplaceRegexObj.Pattern = "\$" & replaceNumber

            If replaceNumber = 0 Then
                outputPattern = outReplaceRegexObj.Replace(outputPattern, inputMatches(0).Value)
            Else
                If replaceNumber > inputMatches(0).SubMatches.Count Then
                    'regex = "A to high $ tag found. Largest allowed is $" & inputMatches(0).SubMatches.Count & "."
                    regex = CVErr(xlErrValue)
                    Exit Function
                Else
                    outputPattern = outReplaceRegexObj.Replace(outputPattern, inputMatches(0).SubMatches(replaceNumber - 1))
                End If
            End If
        Next
        regex = outputPattern
    End If
End Function
```</li>
<li><p>Save and close the <em>Microsoft Visual Basic for Applications</em> Editor window.</p></li>
</ol>

#### Answer 3 (score 54)
Expanding on <a href="https://stackoverflow.com/users/1975049/patszim">patszim</a>'s <a href="https://stackoverflow.com/a/28176749/1699071">answer</a> for those in a rush.  

<ol>
<li>Open Excel workbook.</li>
<li><kbd>Alt</kbd>+<kbd>F11</kbd> to open VBA/Macros window.</li>
<li>Add reference to regex under <strong><em>Tools</em></strong> then <strong><em>References</em></strong><br>
<a href="https://i.stack.imgur.com/sKCdA.png" rel="noreferrer"><img src="https://i.stack.imgur.com/sKCdA.png" alt="![Excel VBA Form add references"></a></li>
<li>and selecting <strong>Microsoft VBScript Regular Expression 5.5</strong><br>
<a href="https://i.stack.imgur.com/nmSgP.png" rel="noreferrer"><img src="https://i.stack.imgur.com/nmSgP.png" alt="![Excel VBA add regex reference"></a></li>
<li>Insert a new module (code needs to reside in the module otherwise it doesn't work).<br>
<a href="https://i.stack.imgur.com/RaLQ0.png" rel="noreferrer"><img src="https://i.stack.imgur.com/RaLQ0.png" alt="![Excel VBA insert code module"></a></li>
<li>In the newly inserted module,<br>
<a href="https://i.stack.imgur.com/DFJ7F.png" rel="noreferrer"><img src="https://i.stack.imgur.com/DFJ7F.png" alt="![Excel VBA insert code into module"></a></li>
<li><p>add the following code:  </p>

```perl
Function RegxFunc(strInput As String, regexPattern As String) As String
    Dim regEx As New RegExp
    With regEx
        .Global = True
        .MultiLine = True
        .IgnoreCase = False
        .pattern = regexPattern
    End With

    If regEx.Test(strInput) Then
        Set matches = regEx.Execute(strInput)
        RegxFunc = matches(0).Value
    Else
        RegxFunc = "not matched"
    End If
End Function
```</li>
<li><p>The regex pattern is placed in one of the cells and <strong><em>absolute referencing</em></strong> is used on it.
<a href="https://i.stack.imgur.com/XnS6t.png" rel="noreferrer"><img src="https://i.stack.imgur.com/XnS6t.png" alt="![Excel regex function in-cell usage"></a>
Function will be tied to workbook that its created in.<br>
If there's a need for it to be used in different workbooks, store the function in <strong>Personal.XLSB</strong></p></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: How to extract numbers from a string in Python? (score [754314](https://stackoverflow.com/q/4289331) in 2019)

#### Question
I would extract all the numbers contained in a string. Which is the better suited for the purpose, regular expressions or the `isdigit()` method?  

Example:  

```perl
line = "hello 12 hi 89"
```

Result:  

```perl
[12, 89]
```

#### Answer accepted (score 423)
If you only want to extract only positive integers, try the following:  

```perl
>>> str = "h3110 23 cat 444.4 rabbit 11 2 dog"
>>> [int(s) for s in str.split() if s.isdigit()]
[23, 11, 2]
```

I would argue that this is better than the regex example for three reasons.  First,  you don't need another module; secondly, it's more readable because you don't need to parse the regex mini-language; and third, it is faster (and thus likely more pythonic):  

```perl
python -m timeit -s "str = 'h3110 23 cat 444.4 rabbit 11 2 dog' * 1000" "[s for s in str.split() if s.isdigit()]"
100 loops, best of 3: 2.84 msec per loop

python -m timeit -s "import re" "str = 'h3110 23 cat 444.4 rabbit 11 2 dog' * 1000" "re.findall('\\b\\d+\\b', str)"
100 loops, best of 3: 5.66 msec per loop
```

This will not recognize floats, negative integers, or integers in hexadecimal format.  If you can't accept these limitations, <a href="https://stackoverflow.com/questions/4289331/python-extract-numbers-of-a-string/4289415#4289415">slim's answer below</a> will do the trick.  

#### Answer 2 (score 393)
I'd use a regexp :  

```perl
>>> import re
>>> re.findall(r'\d+', 'hello 42 I\'m a 32 string 30')
['42', '32', '30']
```

This would also match 42 from `bla42bla`. If you only want numbers delimited by word boundaries (space, period, comma), you can use \b :  

```perl
>>> re.findall(r'\b\d+\b', 'he33llo 42 I\'m a 32 string 30')
['42', '32', '30']
```

To end up with a list of numbers instead of a list of strings:  

```perl
>>> [int(s) for s in re.findall(r'\b\d+\b', 'he33llo 42 I\'m a 32 string 30')]
[42, 32, 30]
```

#### Answer 3 (score 81)
This is more than a bit late, but you can extend the regex expression to account for scientific notation too.  

```perl
import re

# Format is [(<string>, <expected output>), ...]
ss = [("apple-12.34 ba33na fanc-14.23e-2yapple+45e5+67.56E+3",
       ['-12.34', '33', '-14.23e-2', '+45e5', '+67.56E+3']),
      ('hello X42 I\'m a Y-32.35 string Z30',
       ['42', '-32.35', '30']),
      ('he33llo 42 I\'m a 32 string -30', 
       ['33', '42', '32', '-30']),
      ('h3110 23 cat 444.4 rabbit 11 2 dog', 
       ['3110', '23', '444.4', '11', '2']),
      ('hello 12 hi 89', 
       ['12', '89']),
      ('4', 
       ['4']),
      ('I like 74,600 commas not,500', 
       ['74,600', '500']),
      ('I like bad math 1+2=.001', 
       ['1', '+2', '.001'])]

for s, r in ss:
    rr = re.findall("[-+]?[.]?[\d]+(?:,\d\d\d)*[\.]?\d*(?:[eE][-+]?\d+)?", s)
    if rr == r:
        print('GOOD')
    else:
        print('WRONG', rr, 'should be', r)
```

Gives all good!  

Additionally, you can look at the <a href="http://docs.aws.amazon.com/glue/latest/dg/custom-classifier.html#classifier-builtin-patterns?icmpid=docs_glue_console" rel="noreferrer">AWS Glue built-in regex</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: Remove all special characters from a string (score [720840](https://stackoverflow.com/q/14114411) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://stackoverflow.com/questions/3022185/regular-expression-sanitize-php">Regular Expression Sanitize (PHP)</a>  </p>
</blockquote>



I am facing an issue with URLs, I want to be able to convert titles that could contain anything and have them stripped of all special characters so they only have letters and numbers and of course I would like to replace spaces with hyphens.  

How would this be done? I've heard a lot about regular expressions (regex) being used...  

#### Answer accepted (score 614)
Easy peasy:  

```perl
function clean($string) {
   $string = str_replace(' ', '-', $string); // Replaces all spaces with hyphens.

   return preg_replace('/[^A-Za-z0-9\-]/', '', $string); // Removes special chars.
}
```

<b>Usage:</b>  

```perl
echo clean('a|"bc!@£de^&$f g');
```

Will output: `abcdef-g`  

<b>Edit:</b>  

<blockquote>
  Hey, just a quick question, how can I prevent multiple hyphens from being next to each other? and have them replaced with just 1?  
</blockquote>

```perl
function clean($string) {
   $string = str_replace(' ', '-', $string); // Replaces all spaces with hyphens.
   $string = preg_replace('/[^A-Za-z0-9\-]/', '', $string); // Removes special chars.

   return preg_replace('/-+/', '-', $string); // Replaces multiple hyphens with single one.
}
```

#### Answer 2 (score 100)
<h5>Update</h1>

The solution below has a "SEO friendlier" version:  

```perl
function hyphenize($string) {
    $dict = array(
        "I'm"      => "I am",
        "thier"    => "their",
        // Add your own replacements here
    );
    return strtolower(
        preg_replace(
          array( '#[\\s-]+#', '#[^A-Za-z0-9. -]+#' ),
          array( '-', '' ),
          // the full cleanString() can be downloaded from http://www.unexpectedit.com/php/php-clean-string-of-utf8-chars-convert-to-similar-ascii-char
          cleanString(
              str_replace( // preg_replace can be used to support more complicated replacements
                  array_keys($dict),
                  array_values($dict),
                  urldecode($string)
              )
          )
        )
    );
}

function cleanString($text) {
    $utf8 = array(
        '/[áàâãªä]/u'   =>   'a',
        '/[ÁÀÂÃÄ]/u'    =>   'A',
        '/[ÍÌÎÏ]/u'     =>   'I',
        '/[íìîï]/u'     =>   'i',
        '/[éèêë]/u'     =>   'e',
        '/[ÉÈÊË]/u'     =>   'E',
        '/[óòôõºö]/u'   =>   'o',
        '/[ÓÒÔÕÖ]/u'    =>   'O',
        '/[úùûü]/u'     =>   'u',
        '/[ÚÙÛÜ]/u'     =>   'U',
        '/ç/'           =>   'c',
        '/Ç/'           =>   'C',
        '/ñ/'           =>   'n',
        '/Ñ/'           =>   'N',
        '/–/'           =>   '-', // UTF-8 hyphen to "normal" hyphen
        '/[’‘‹›‚]/u'    =>   ' ', // Literally a single quote
        '/[“”«»„]/u'    =>   ' ', // Double quote
        '/ /'           =>   ' ', // nonbreaking space (equiv. to 0x160)
    );
    return preg_replace(array_keys($utf8), array_values($utf8), $text);
}
```

The rationale for the above functions (which I find <em>way</em> inefficient - the one below is better) is that <em>a service that shall not be named</em> apparently ran spelling checks and keyword recognition on the URLs.  

After losing a long time on a customer's paranoias, I found out they were <em>not</em> imagining things after all -- their SEO experts [I am definitely not one] reported that, say, converting "Viaggi Economy Perù" to `viaggi-economy-peru` "behaved better" than `viaggi-economy-per` (the previous "cleaning" removed UTF8 characters; <strong>Bogotà</strong> became <strong>bogot</strong>, <strong>Medellìn</strong> became <strong>medelln</strong> and so on).  

There were also some common misspellings that seemed to influence the results, and the only explanation that made sense to me is that our URL were being unpacked, the words singled out, and used to drive God knows what ranking algorithms. And those algorithms apparently had been fed with UTF8-cleaned strings, so that "Perù" became "Peru" instead of "Per". "Per" did not match and sort of took it in the neck.  

In order to both keep UTF8 characters and replace some misspellings, the faster function below became the more accurate (?) function above. `$dict` needs to be hand tailored, of course.  

<h5>Previous answer</h1>

A simple approach:  

```perl
// Remove all characters except A-Z, a-z, 0-9, dots, hyphens and spaces
// Note that the hyphen must go last not to be confused with a range (A-Z)
// and the dot, NOT being special (I know. My life was a lie), is NOT escaped

$str = preg_replace('/[^A-Za-z0-9. -]/', '', $str);

// Replace sequences of spaces with hyphen
$str = preg_replace('/  */', '-', $str);

// The above means "a space, followed by a space repeated zero or more times"
// (should be equivalent to / +/)

// You may also want to try this alternative:
$str = preg_replace('/\\s+/', '-', $str);

// where \s+ means "zero or more whitespaces" (a space is not necessarily the
// same as a whitespace) just to be sure and include everything
```

Note that you might have to first `urldecode()` the URL, since %20 and + both are actually spaces - I mean, if you have "Never%20gonna%20give%20you%20up" you want it to become Never-gonna-give-you-up, not <em>Never20gonna20give20you20up</em> . You might not need it, but I thought I'd mention the possibility.  

So the finished function along with test cases:  

```perl
function hyphenize($string) {
    return 
    ## strtolower(
          preg_replace(
            array('#[\\s-]+#', '#[^A-Za-z0-9. -]+#'),
            array('-', ''),
        ##     cleanString(
              urldecode($string)
        ##     )
        )
    ## )
    ;
}

print implode("\n", array_map(
    function($s) {
            return $s . ' becomes ' . hyphenize($s);
    },
    array(
    'Never%20gonna%20give%20you%20up',
    "I'm not the man I was",
    "'Légeresse', dit sa majesté",
    )));


Never%20gonna%20give%20you%20up    becomes  never-gonna-give-you-up
I'm not the man I was              becomes  im-not-the-man-I-was
'Légeresse', dit sa majesté        becomes  legeresse-dit-sa-majeste
```

To handle UTF-8 I used a `cleanString` implementation found online (link broken since, but a stripped down copy with all the not-too-esoteric UTF8 characters is at the beginning of the answer; it's also easy to add more characters to it if you need) that converts UTF8 characters to normal characters, thus preserving the word "look" as much as possible. It could be simplified and wrapped inside the function here for performance.  

The function above also implements converting to lowercase - but that's a taste. The code to do so has been commented out.  

#### Answer 3 (score 36)
Here, check out this function:  

```perl
function seo_friendly_url($string){
    $string = str_replace(array('[\', \']'), '', $string);
    $string = preg_replace('/\[.*\]/U', '', $string);
    $string = preg_replace('/&(amp;)?#?[a-z0-9]+;/i', '-', $string);
    $string = htmlentities($string, ENT_COMPAT, 'utf-8');
    $string = preg_replace('/&([a-z])(acute|uml|circ|grave|ring|cedil|slash|tilde|caron|lig|quot|rsquo);/i', '\\1', $string );
    $string = preg_replace(array('/[^a-z0-9]/i', '/[-]+/') , '-', $string);
    return strtolower(trim($string, '-'));
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: Regex for numbers only (score [719314](https://stackoverflow.com/q/273141) in 2019)

#### Question
I haven't used regular expressions at all, so I'm having difficulty troubleshooting. I want the regex to match only when the contained string is all numbers; but with the two examples below it is matching a string that contains all numbers plus an equals sign like "1234=4321". I'm sure there's a way to change this behavior, but as I said, I've never really done much with regular expressions.  

```perl
string compare = "1234=4321";
Regex regex = new Regex(@"[\d]");

if (regex.IsMatch(compare))
{ 
    //true
}

regex = new Regex("[0-9]");

if (regex.IsMatch(compare))
{ 
    //true
}
```

In case it matters, I'm using C# and .NET2.0.  

#### Answer accepted (score 449)
Use the beginning and end anchors.  

```perl
Regex regex = new Regex(@"^\d$");
```

Use `"^\d+$"` if you need to match more than one digit.  

<hr>

Note that `"\d"` will match `[0-9]` and other digit characters like the Eastern Arabic numerals `٠١٢٣٤٥٦٧٨٩`.  Use `"^[0-9]+$"` to restrict matches to just the Arabic numerals 0 - 9.  

<hr>

If you need to include any numeric representations other than just digits (like decimal values for starters), then see <a href="https://stackoverflow.com/users/471272/tchrist">@tchrist</a>'s <a href="https://stackoverflow.com/a/4247184/1288">comprehensive guide to parsing numbers with regular expressions</a>.  

#### Answer 2 (score 99)
Your regex will match anything that contains a number, you want to use anchors to match the whole string and then match one or more numbers:  

```perl
regex = new Regex("^[0-9]+$");
```

The `^` will anchor the beginning of the string, the `$` will anchor the end of the string, and the `+` will match one or more of what precedes it (a number in this case).  

#### Answer 3 (score 37)
If you need to tolerate decimal point and thousand marker  

```perl
var regex = new Regex(@"^-?[0-9][0-9,\.]+$");
```

You will need a "-", if the number can go negative.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How to match "any character" in regular expression? (score [718409](https://stackoverflow.com/q/2912894) in 2018)

#### Question
The following should be matched:  

```perl
AAA123
ABCDEFGH123
XXXX123
```

can I do: `".*123"` ?  

#### Answer accepted (score 572)
Yes, you can. That should work.  

<ul>
<li>`.` = any char</li>
<li>`\.` = the actual dot character</li>
<li>`.?` = `.{0,1}` = match any char zero or one times</li>
<li>`.*` = `.{0,}` = match any char zero or more times</li>
<li>`.+` = `.{1,}` = match any char one or more times</li>
</ul>

#### Answer 2 (score 52)
Yes that will work, though note that `.` will not match newlines unless you pass the <a href="http://java.sun.com/javase/7/docs/api/java/util/regex/Pattern.html#DOTALL" rel="noreferrer">DOTALL</a> flag when compiling the expression:  

```perl
Pattern pattern = Pattern.compile(".*123", Pattern.DOTALL);
Matcher matcher = pattern.matcher(inputStr);
boolean matchFound = matcher.matches();
```

#### Answer 3 (score 19)
Use the pattern `.` to match any character once, `.*` to match any character zero or more times,  `.+` to match any character one or more times.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: How do you access the matched groups in a JavaScript regular expression? (score [705906](https://stackoverflow.com/q/432493) in 2017)

#### Question
I want to match a portion of a string using a <a href="http://en.wikipedia.org/wiki/Regular_expression" rel="noreferrer">regular expression</a> and then access that parenthesized substring:  

```perl
var myString = "something format_abc"; // I want "abc"

var arr = /(?:^|\s)format_(.*?)(?:\s|$)/.exec(myString);

console.log(arr);     // Prints: [" format_abc", "abc"] .. so far so good.
console.log(arr[1]);  // Prints: undefined  (???)
console.log(arr[0]);  // Prints: format_undefined (!!!)
```

What am I doing wrong?  

<hr>

I've discovered that there was nothing wrong with the regular expression code above: the actual string which I was testing against was this:  

```perl
"date format_%A"
```

Reporting that "%A" is undefined seems a very strange behaviour, but it is not directly related to this question, so I've opened a new one, <em><a href="https://stackoverflow.com/questions/432826/why-is-a-matched-substring-returning-undefined-in-javascript">Why is a matched substring returning "undefined" in JavaScript?</a></em>.  

<hr>

The issue was that `console.log` takes its parameters like a `printf` statement, and since the string I was logging (`"%A"`) had a special value, it was trying to find the value of the next parameter.  

#### Answer accepted (score 1570)
You can access capturing groups like this:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
var myString = "something format_abc";
var myRegexp = /(?:^|\s)format_(.*?)(?:\s|$)/g;
var match = myRegexp.exec(myString);
console.log(match[1]); // abc
```
</div>
</div>


And if there are multiple matches you can iterate over them:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
var myString = "something format_abc";
var myRegexp = /(?:^|\s)format_(.*?)(?:\s|$)/g;
match = myRegexp.exec(myString);
while (match != null) {
  // matched text: match[0]
  // match start: match.index
  // capturing group n: match[n]
  console.log(match[0])
  match = myRegexp.exec(myString);
}
```
</div>
</div>


<h5>Edit: 2019-09-10</h2>

As you can see the way to iterate over multiple matches was not very intuitive. This lead to the proposal of the <a href="https://github.com/tc39/proposal-string-matchall" rel="noreferrer">`String.prototype.matchAll`</a> method. This new method is expected to ship in the <a href="https://tc39.es/ecma262/#sec-string.prototype.matchall" rel="noreferrer">ECMAScript 2020 specification</a>. It gives us a clean API and solves multiple problems. It has been started to land on major browsers and JS engines as <a href="https://v8.dev/features/string-matchall" rel="noreferrer">Chrome 73+ / Node 12+</a> and Firefox 67+.  

The method returns an iterator and is used as follows:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
const string = "something format_abc";
const regexp = /(?:^|\s)format_(.*?)(?:\s|$)/g;
const matches = string.matchAll(regexp);
    
for (const match of matches) {
  console.log(match);
  console.log(match.index)
}
```
</div>
</div>


As it returns an iterator, we can say it's lazy, this is useful when handling particularly large numbers of capturing groups, or very large strings. But if you need, the result can be easily transformed into an Array by using the <em>spread syntax</em> or the `Array.from` method:  

```perl
function getFirstGroup(regexp, str) {
  const array = [...str.matchAll(regexp)];
  return array.map(m => m[1]);
}

// or:
function getFirstGroup(regexp, str) {
  return Array.from(str.matchAll(regexp), m => m[1]);
}
```

In the meantime, while this proposal gets more wide support, you can use the <a href="https://www.npmjs.com/package/string.prototype.matchall" rel="noreferrer">official shim package</a>.  

Also, the internal workings of the method are simple. An equivalent implementation using a generator function would be as follows:  

```perl
function* matchAll(str, regexp) {
  const flags = regexp.global ? regexp.flags : regexp.flags + "g";
  const re = new RegExp(regexp, flags);
  let match;
  while (match = re.exec(str)) {
    yield match;
  }
}
```

A copy of the original regexp is created; this is to avoid side-effects due to the mutation of the `lastIndex` property when going through the multple matches.  

Also, we need to ensure the regexp has the <em>global</em> flag to avoid an infinite loop.  

I'm also happy to see that even this StackOverflow question was referenced in the <a href="https://github.com/tc39/proposal-string-matchall#previous-discussions" rel="noreferrer">discussions of the proposal</a>.  

#### Answer 2 (score 178)
Here’s a method you can use to get the <em>n</em>​th capturing group for each match:  

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
```perl
function getMatches(string, regex, index) {
  index || (index = 1); // default to the first capturing group
  var matches = [];
  var match;
  while (match = regex.exec(string)) {
    matches.push(match[index]);
  }
  return matches;
}


// Example :
var myString = 'something format_abc something format_def something format_ghi';
var myRegEx = /(?:^|\s)format_(.*?)(?:\s|$)/g;

// Get an array containing the first capturing group for every match
var matches = getMatches(myString, myRegEx, 1);

// Log results
document.write(matches.length + ' matches found: ' + JSON.stringify(matches))
console.log(matches);
```
</div>
</div>


#### Answer 3 (score 55)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
var myString = "something format_abc";
var arr = myString.match(/\bformat_(.*?)\b/);
console.log(arr[0] + " " + arr[1]);
```
</div>
</div>


The `\b` isn't exactly the same thing. (It works on `--format_foo/`, but doesn't work on `format_a_b`) But I wanted to show an alternative to your expression, which is fine. Of course, the `match` call is the important thing.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: Check whether a string matches a regex in JS (score [700870](https://stackoverflow.com/q/6603015) in 2017)

#### Question
I want to use JavaScript (can be with jQuery) to do some client-side validation to check whether a string matches the regex:  

```perl
^([a-z0-9]{5,})$
```

Ideally it would be an expression that returned true or false.   

I'm a JavaScript newbie, does `match()` do what I need? It seems to check whether part of a string matches a regex, not the whole thing.   

#### Answer accepted (score 1064)
Use <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/test" rel="noreferrer">`regex.test()`</a> if all you want is a boolean result:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
console.log(/^([a-z0-9]{5,})$/.test('abc1')); // false

console.log(/^([a-z0-9]{5,})$/.test('abc12')); // true

console.log(/^([a-z0-9]{5,})$/.test('abc123')); // true
```
</div>
</div>


...and you could remove the `()` from your regexp since you've no need for a capture.  

#### Answer 2 (score 160)
Use `test()` method :   

```perl
var term = "sample1";
var re = new RegExp("^([a-z0-9]{5,})$");
if (re.test(term)) {
    console.log("Valid");
} else {
    console.log("Invalid");
}
```

#### Answer 3 (score 83)
You can use `match()` as well:  

```perl
if (str.match(/^([a-z0-9]{5,})$/)) {
    alert("match!");
}
```

But `test()` seems to be faster as you can read <a href="https://stackoverflow.com/a/10940138/1895428">here</a>.  

<strong>Important difference between `match()` and `test()`:</strong>  

`match()` works only with strings, but `test()` works also with integers.  

```perl
12345.match(/^([a-z0-9]{5,})$/); // ERROR
/^([a-z0-9]{5,})$/.test(12345);  // true
/^([a-z0-9]{5,})$/.test(null);   // false

// Better watch out for undefined values
/^([a-z0-9]{5,})$/.test(undefined); // true
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: Python string.replace regular expression (score [696728](https://stackoverflow.com/q/16720541) in 2019)

#### Question
I have a parameter file of the form:  

```perl
parameter-name parameter-value
```

Where the parameters may be in any order but there is only one parameter per line.  I want to replace one parameter's `parameter-value` with a new value.  

I am using a line replace function <a href="https://stackoverflow.com/questions/39086/search-and-replace-a-line-in-a-file-in-python">posted previously</a> to replace the line which uses Python's <a href="http://www.tutorialspoint.com/python/string_replace.htm%20String.Replace" rel="noreferrer">`string.replace(pattern, sub)`</a>.  The regular expression that I'm using works for instance in vim but doesn't appear to work in `string.replace()`.   

Here is the regular expression that I'm using:  

```perl
line.replace("^.*interfaceOpDataFile.*$/i", "interfaceOpDataFile %s" % (fileIn))
```

Where `"interfaceOpDataFile"` is the parameter name that I'm replacing (/i for case-insensitive) and the new parameter value is the contents of the `fileIn` variable.   

Is there a way to get Python to recognize this regular expression or else is there another way to accomplish this task?  

#### Answer accepted (score 504)
`str.replace()` <sup><a href="https://docs.python.org/2/library/stdtypes.html#str.replace" rel="noreferrer">v2</a>|<a href="https://docs.python.org/3/library/stdtypes.html#str.replace" rel="noreferrer">v3</a></sup> does not recognize regular expressions.   

To perform a substitution using a regular expression, use `re.sub()` <sup><a href="https://docs.python.org/2/library/re.html#re.sub" rel="noreferrer">v2</a>|<a href="https://docs.python.org/3/library/re.html#re.sub" rel="noreferrer">v3</a></sup>.  

For example:  

```perl
import re

line = re.sub(
           r"(?i)^.*interfaceOpDataFile.*$", 
           "interfaceOpDataFile %s" % fileIn, 
           line
       )
```

In a loop, it would be better to compile the regular expression first:  

```perl
import re

regex = re.compile(r"^.*interfaceOpDataFile.*$", re.IGNORECASE)
for line in some_file:
    line = regex.sub("interfaceOpDataFile %s" % fileIn, line)
    # do something with the updated line
```

#### Answer 2 (score 340)
You are looking for the <a href="http://docs.python.org/2/library/re.html#re.sub" rel="noreferrer">re.sub</a> function.  

```perl
import re
s = "Example String"
replaced = re.sub('[ES]', 'a', s)
print replaced 
```

will print `axample atring`  

#### Answer 3 (score 14)
As a summary   

```perl
import sys
import re

f = sys.argv[1]
find = sys.argv[2]
replace = sys.argv[3]
with open (f, "r") as myfile:
     s=myfile.read()
ret = re.sub(find,replace, s)   # <<< This is where the magic happens
print ret
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: Regex that accepts only numbers (0-9) and NO characters (score [694263](https://stackoverflow.com/q/19715303) in 2013)

#### Question
I need a regex that will accept only digits from 0-9 and nothing else. No letters, no characters.  

I thought this would work:  

```perl
^[0-9]
```

or even   

```perl
\d+
```

but these are accepting the characters : ^,$,(,), etc  

I thought that both the regexes above would do the trick and I'm not sure why its accepting those characters.  

EDIT:  

This is exactly what I am doing:  

```perl
 private void OnTextChanged(object sender, EventArgs e)
    {

   if (!System.Text.RegularExpressions.Regex.IsMatch("^[0-9]", textbox.Text))
        {
            textbox.Text = string.Empty;
        }
    }
```

This is allowing the characters I mentioned above.  

#### Answer accepted (score 332)
Your regex `^[0-9]` matches anything <em>beginning</em> with a digit, including strings like "1A". To avoid a partial match, append a `$` to the end:  

```perl
^[0-9]*$
```

This accepts any number of digits, including none. To accept one or more digits, change the `*` to `+`. To accept exactly one digit, just remove the `*`.  

<strong>UPDATE:</strong> You mixed up the arguments to `IsMatch`. The pattern should be the second argument, not the first:  

```perl
if (!System.Text.RegularExpressions.Regex.IsMatch(textbox.Text, "^[0-9]*$"))
```

<strong>CAUTION:</strong> In JavaScript, `\d` is equivalent to `[0-9]`, but in .NET, `\d` by default matches any <a href="http://graphemica.com/categories/decimal-digit-number">Unicode decimal digit</a>, including exotic fare like ႒ (Myanmar 2) and ߉ (N'Ko 9). Unless your app is prepared to deal with these characters, stick with `[0-9]` (or supply the <a href="https://msdn.microsoft.com/en-us/library/yd1hzczs(v=vs.110).aspx#Anchor_10">RegexOptions.ECMAScript</a> flag).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: Regular Expressions: Is there an AND operator? (score [693174](https://stackoverflow.com/q/469913) in 2017)

#### Question
Obviously, you can use the `|` (pipe?) to represent `OR`, but is there a way to represent `AND` as well?  

Specifically, I'd like to match paragraphs of text that contain ALL of a certain phrase, but in no particular order.  

#### Answer 2 (score 361)
Use a non-consuming regular expression.  

The typical (i.e. Perl/Java) notation is:  

`(?=`<em>expr</em>`)`  

This means "match <em>expr</em> but after that continue matching at the original match-point."    

You can do as many of these as you want, and this will be an "and."  Example:  

`(?=match this expression)(?=match this too)(?=oh, and this)`  

You can even add capture groups inside the non-consuming expressions if you need to save some of the data therein.  

#### Answer 3 (score 317)
You need to use lookahead as some of the other responders have said, but the lookahead has to account for other characters between its target word and the current match position.  For example:  

```perl
(?=.*word1)(?=.*word2)(?=.*word3)
```

The `.*` in the first lookahead lets it match however many characters it needs to before it gets to "word1".  Then the match position is reset and the second lookahead seeks out "word2".  Reset again, and the final part matches "word3"; since it's the last word you're checking for, it isn't necessary that it be in a lookahead, but it doesn't hurt.  

In order to match a whole paragraph, you need to anchor the regex at both ends and add a final `.*` to consume the remaining characters.  Using Perl-style notation, that would be:  

```perl
/^(?=.*word1)(?=.*word2)(?=.*word3).*$/m
```

The 'm' modifier is for multline mode; it lets the `^` and `$` match at paragraph boundaries ("line boundaries" in regex-speak).  It's essential in this case that you <strong>not</strong> use the 's' modifier, which lets the dot metacharacter match newlines as well as all other characters.    

Finally, you want to make sure you're matching whole words and not just fragments of longer words, so you need to add word boundaries:  

```perl
/^(?=.*\bword1\b)(?=.*\bword2\b)(?=.*\bword3\b).*$/m
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: How can I exclude one word with grep? (score [679734](https://stackoverflow.com/q/4538253) in 2015)

#### Question
I need something like:  

```perl
grep ^"unwanted_word"XXXXXXXX
```

#### Answer accepted (score 730)
You can also do it using `-v` (for `--invert-match`) option of grep as:  

```perl
grep -v "unwanted_word" file | grep XXXXXXXX
```

`grep -v "unwanted_word" file` will filter the lines that have the `unwanted_word` and `grep XXXXXXXX` will list only lines with pattern `XXXXXXXX`.  

<strong>EDIT:</strong>  

From your comment it looks like you want to list all lines without the `unwanted_word`. In that case all you need is:  

```perl
grep -v 'unwanted_word' file
```

#### Answer 2 (score 79)
I understood the question as "How do I match a word but exclude another", for which one solution is two greps in series: First grep finding the wanted "word1", second grep excluding "word2":  

```perl
grep "word1" | grep -v "word2"
```

In my case: I need to differentiate between "plot" and "#plot" which grep's "word" option won't do ("#" not being a alphanumerical).  

Hope this helps.  

#### Answer 3 (score 33)
If your `grep` supports Perl regular expression with `-P` option you can do (if bash; if tcsh you'll need to escape the `!`):  

```perl
grep -P '(?!.*unwanted_word)keyword' file
```

Demo:  

```perl
$ cat file
foo1
foo2
foo3
foo4
bar
baz
```

Let us now list all `foo` except `foo3`  

```perl
$ grep -P '(?!.*foo3)foo' file
foo1
foo2
foo4
$ 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: Matching a space in regex (score [675660](https://stackoverflow.com/q/559363) in 2015)

#### Question
I need to match a space character in a PHP regular expression. Anyone got any ideas?  

I mean like "gavin schulz", the space in between the two words. I am using a regular expression to make sure that I only allow letters, number and a space. But I'm not sure how to find the space. This is what I have right now:  

```perl
$newtag = preg_replace("/[^a-zA-Z0-9s|]/", "", $tag);
```

#### Answer accepted (score 339)
If you're looking for a space, that would be `" "` (one space).  

If you're looking for one or more, it's `"  *"` (that's <em>two</em> spaces and an asterisk) or `" +"` (one space and a plus).  

If you're looking for common spacing, use `"[ X]"` or `"[ X][ X]*"` or `"[ X]+"` where `X` is the physical tab character (and each is preceded by a single space in all those examples).  

These will work in <em>every</em>* regex engine I've ever seen (some of which don't even have the one-or-more `"+"` character, ugh).  

If you know you'll be using one of the more modern regex engines, `"\s"` and its variations are the way to go. In addition, I believe word boundaries match start and end of lines as well, important when you're looking for words that may appear without preceding or following spaces.  

For PHP specifically, <a href="http://www.wellho.net/regex/php.html" rel="noreferrer">this page</a> may help.  

From your edit, it appears you want to remove all non valid characters The start of this is (note the space inside the regex):  

```perl
$newtag = preg_replace ("/[^a-zA-Z0-9 ]/", "", $tag);
#                                    ^ space here
```

If you also want trickery to ensure there's only one space between each word and none at the start or end, that's a little more complicated (and probably another question) but the basic idea would be:  

```perl
$newtag = preg_replace ("/ +/", " ", $tag); # convert all multispaces to space
$newtag = preg_replace ("/^ /", "", $tag);  # remove space from start
$newtag = preg_replace ("/ $/", "", $tag);  # and end
```

#### Answer 2 (score 43)
`\040` matches exactly the space character.  

<a href="http://us.php.net/manual/en/regexp.reference.php" rel="noreferrer">Regexp PHP reference</a>  

<p>New Link<br>
<a href="http://php.net/manual/en/regexp.reference.escape.php" rel="noreferrer">Escape sequences for Regex PHP</a></p>

#### Answer 3 (score 23)
Here is a everything you need to know about whitespace in regular expressions:  

<ul>
<li>`[[:blank:]]` Space or tab only</li>
<li>`[[:space:]]` Whitespace </li>
<li>`\s` Any whitespace character</li>
<li>`\v` Vertical whitespace</li>
<li>`\h` Horizontal whitespace </li>
<li>`x` Ignore whitespace</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: How do you use a variable in a regular expression? (score [665330](https://stackoverflow.com/q/494035) in 2019)

#### Question
I would like to create a `String.replaceAll()` method in JavaScript and I'm thinking that using a regex would be most terse way to do it.  However, I can't figure out how to pass a variable in to a regex.  I can do this already which will replace all the instances of `"B"` with `"A"`.  

```perl
"ABABAB".replace(/B/g, "A");
```

But I want to do something like this:  

```perl
String.prototype.replaceAll = function(replaceThis, withThis) {
    this.replace(/replaceThis/g, withThis);
};
```

But obviously this will only replace the text `"replaceThis"`...so how do I pass this variable in to my regex string?  

#### Answer accepted (score 1682)
Instead of using the `/regex/g` syntax, you can construct a new <a href="https://developer.mozilla.org/en-US/docs/JavaScript/Guide/Regular_Expressions" rel="noreferrer">RegExp</a> object:  

```perl
var replace = "regex";
var re = new RegExp(replace,"g");
```

You can dynamically create regex objects this way. Then you will do:  

```perl
"mystring".replace(re, "newstring");
```

#### Answer 2 (score 196)
As Eric Wendelin mentioned, you can do something like this:  

```perl
str1 = "pattern"
var re = new RegExp(str1, "g");
"pattern matching .".replace(re, "regex");
```

This yields `"regex matching ."`. However, it will fail if str1 is `"."`. You'd expect the result to be `"pattern matching regex"`, replacing the period with `"regex"`, but it'll turn out to be...  

```perl
regexregexregexregexregexregexregexregexregexregexregexregexregexregexregexregexregexregex
```

This is because, although `"."` is a String, in the RegExp constructor it's still interpreted as a regular expression, meaning any non-line-break character, meaning every character in the string. For this purpose, the following function may be useful:  

```perl
 RegExp.quote = function(str) {
     return str.replace(/([.?*+^$[\]\\(){}|-])/g, "\\$1");
 };
```

Then you can do:  

```perl
str1 = "."
var re = new RegExp(RegExp.quote(str1), "g");
"pattern matching .".replace(re, "regex");
```

yielding `"pattern matching regex"`.  

#### Answer 3 (score 109)
<blockquote>
  `"ABABAB".replace(/B/g, "A");`  
</blockquote>

As always: don't use regex unless you have to. For a simple string replace, the idiom is:  

```perl
'ABABAB'.split('B').join('A')
```

Then you don't have to worry about the quoting issues mentioned in Gracenotes's answer.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: What is a non-capturing group in regular expressions? (score [647385](https://stackoverflow.com/q/3512471) in 2019)

#### Question
How are non-capturing groups, i.e. `(?:)`, used in regular expressions and what are they good for?  

#### Answer accepted (score 2154)
Let me try to explain this with an example.  

Consider the following text:  

```perl
http://stackoverflow.com/
https://stackoverflow.com/questions/tagged/regex
```

Now, if I apply the regex below over it...  

```perl
(https?|ftp)://([^/\r\n]+)(/[^\r\n]*)?
```

... I would get the following result:  

```perl
Match "http://stackoverflow.com/"
     Group 1: "http"
     Group 2: "stackoverflow.com"
     Group 3: "/"

Match "https://stackoverflow.com/questions/tagged/regex"
     Group 1: "https"
     Group 2: "stackoverflow.com"
     Group 3: "/questions/tagged/regex"
```

But I don't care about the protocol -- I just want the host and path of the URL. So, I change the regex to include the non-capturing group `(?:)`.  

```perl
(?:https?|ftp)://([^/\r\n]+)(/[^\r\n]*)?
```

Now, my result looks like this:  

```perl
Match "http://stackoverflow.com/"
     Group 1: "stackoverflow.com"
     Group 2: "/"

Match "https://stackoverflow.com/questions/tagged/regex"
     Group 1: "stackoverflow.com"
     Group 2: "/questions/tagged/regex"
```

See? The first group has not been captured. The parser uses it to match the text, but ignores it later, in the final result.  

<hr>

<h5>EDIT:</h2>

As requested, let me try to explain groups too.  

Well, groups serve many purposes. They can help you to extract exact information from a bigger match (which can also be named), they let you rematch a previous matched group, and can be used for substitutions. Let's try some examples, shall we?  

Ok, imagine you have some kind of XML or HTML (be aware that <a href="https://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags">regex may not be the best tool for the job</a>, but it is nice as an example). You want to parse the tags, so you could do something like this (I have added spaces to make it easier to understand):  

```perl
   \<(?<TAG>.+?)\> [^<]*? \</\k<TAG>\>
or
   \<(.+?)\> [^<]*? \</\1\>
```

The first regex has a named group (TAG), while the second one uses a common group. Both regexes do the same thing: they use the value from the first group (the name of the tag) to match the closing tag. The difference is that the first one uses the name to match the value, and the second one uses the group index (which starts at 1).  

Let's try some substitutions now. Consider the following text:  

```perl
Lorem ipsum dolor sit amet consectetuer feugiat fames malesuada pretium egestas.
```

Now, let's use this dumb regex over it:  

```perl
\b(\S)(\S)(\S)(\S*)\b
```

This regex matches words with at least 3 characters, and uses groups to separate the first three letters. The result is this:  

```perl
Match "Lorem"
     Group 1: "L"
     Group 2: "o"
     Group 3: "r"
     Group 4: "em"
Match "ipsum"
     Group 1: "i"
     Group 2: "p"
     Group 3: "s"
     Group 4: "um"
...

Match "consectetuer"
     Group 1: "c"
     Group 2: "o"
     Group 3: "n"
     Group 4: "sectetuer"
...
```

So, if we apply the substitution string:  

```perl
$1_$3$2_$4
```

... over it, we are trying to use the first group, add an underscore, use the third group, then the second group, add another underscore, and then the fourth group. The resulting string would be like the one below.  

```perl
L_ro_em i_sp_um d_lo_or s_ti_ a_em_t c_no_sectetuer f_ue_giat f_ma_es m_la_esuada p_er_tium e_eg_stas.
```

You can use named groups for substitutions too, using `${name}`.  

To play around with regexes, I recommend <a href="http://regex101.com/" rel="noreferrer">http://regex101.com/</a>, which offers a good amount of details on how the regex works; it also offers a few regex engines to choose from.  

#### Answer 2 (score 161)
You can use capturing groups to organize and parse an expression.  A non-capturing group has the first benefit, but doesn't have the overhead of the second.  You can still say a non-capturing group is optional, for example.  

Say you want to match numeric text, but some numbers could be written as 1st, 2nd, 3rd, 4th,...  If you want to capture the numeric part, but not the (optional) suffix you can use a non-capturing group.  

```perl
([0-9]+)(?:st|nd|rd|th)?
```

That will match numbers in the form 1, 2, 3... or in the form 1st, 2nd, 3rd,... but it will only capture the numeric part.  

#### Answer 3 (score 98)
`?:` is used when you want to group an expression, but you do not want to save it as a matched/captured portion of the string.  

An example would be something to match an IP address:  

```perl
/(?:\d{1,3}\.){3}\d{1,3}/
```

Note that I don't care about saving the first 3 octets, but the `(?:...)` grouping allows me to shorten the regex without incurring the overhead of capturing and storing a match.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: Using String Format to show decimal up to 2 places or simple integer (score [641202](https://stackoverflow.com/q/6951335) in 2017)

#### Question
<p>I have got a price field to display which sometimes can be either 100 or 100.99 or 100.9, What I want is to display the price in 2 decimal places only if the decimals are entered for that price , for instance if its 100 so it should only show 100 not 100.00 and if the price is 100.2 it should display 100.20 similarly for 100.22 should be same .
I googled and came across some examples but they didn't match exactly what i wanted :</p>

```perl
// just two decimal places
String.Format("{0:0.00}", 123.4567);      // "123.46"
String.Format("{0:0.00}", 123.4);         // "123.40"
String.Format("{0:0.00}", 123.0);         // "123.00"
```

#### Answer accepted (score 140)
An inelegant way would be:  

```perl
var my = DoFormat(123.0);
```

With `DoFormat` being something like:  

```perl
public static string DoFormat( double myNumber )
{
    var s = string.Format("{0:0.00}", myNumber);

    if ( s.EndsWith("00") )
    {
        return ((int)myNumber).ToString();
    }
    else
    {
        return s;
    }
}
```

Not elegant but working for me in similar situations in some projects.  

#### Answer 2 (score 470)
Sorry for reactivating this question, but I didn't find the right answer here.  

In formatting numbers you can use `0` as a mandatory place and `#` as an optional place.  

<strong>So:</strong>  

```perl
// just two decimal places
String.Format("{0:0.##}", 123.4567);      // "123.46"
String.Format("{0:0.##}", 123.4);         // "123.4"
String.Format("{0:0.##}", 123.0);         // "123"
```

You can also combine `0` with `#`.  

```perl
String.Format("{0:0.0#}", 123.4567)       // "123.46"
String.Format("{0:0.0#}", 123.4)          // "123.4"
String.Format("{0:0.0#}", 123.0)          // "123.0"
```

For this formating method is always used `CurrentCulture`. For some Cultures `.` will be changed to `,`.  

<h5>Answer to original question:</h2>

The simpliest solution comes from @Andrew (<a href="https://stackoverflow.com/questions/6951335#33180829">here</a>). So I personally would use something like this:  

```perl
var number = 123.46;
String.Format(number % 1 == 0 ? "{0:0}" : "{0:0.00}", number)
```

#### Answer 3 (score 56)
This is a common formatting floating number use case.  

<p>Unfortunately, all of the built-in one-letter format strings (eg. F, G, N) won't achieve this directly.<br>
For example, `num.ToString("F2")` will always show 2 decimal places like `123.40`.</p>

You'll have to use <strong>`0.##`</strong> pattern even it looks a little verbose.  

A complete code example:  

```perl
double a = 123.4567;
double b = 123.40;
double c = 123.00;

string sa = a.ToString("0.##"); // 123.46
string sb = b.ToString("0.##"); // 123.4
string sc = c.ToString("0.##"); // 123
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: Regex Match all characters between two strings (score [638223](https://stackoverflow.com/q/6109882) in 2016)

#### Question
<p>Example:
"This is just\na simple sentence".</p>

I want to match every character between "This is" and "sentence". Line breaks should be ignored. I can't figure out the correct syntax.  

#### Answer accepted (score 541)
For example  

```perl
(?<=This is)(.*)(?=sentence)
```

<a href="http://regexr.com?2tr28" rel="noreferrer">Regexr</a>  

I used lookbehind `(?&lt;=)` and look ahead `(?=)` so that "This is" and "sentence" is not included in the match, but this is up to your use case, you can also simply write `This is(.*)sentence`.  

The important thing here is that you activate the "dotall" mode of your regex engine, so that the `.` is matching the newline. But how you do this depends on your regex engine.  

The next thing is if you use `.*` or `.*?`. The first one is greedy and will match till the last "sentence" in your string, the second one is lazy and will match till the next "sentence" in your string.  

<strong>Update</strong>  

<a href="http://gskinner.com/RegExr/?2tr2n" rel="noreferrer">Regexr</a>  

```perl
This is(?s)(.*)sentence
```

Where the (?s) turns on the dotall modifier, making the `.` matching the newline characters.  

<strong>Update 2:</strong>  

```perl
(?<=is \()(.*?)(?=\s*\))
```

is matching your example "This is (a simple) sentence". See here on <a href="http://regexr.com?2tr5t" rel="noreferrer">Regexr</a>  

#### Answer 2 (score 159)
<h5>Lazy Quantifier Needed</h2>

Resurrecting this question because the regex in the accepted answer doesn't seem quite correct to me. Why? Because  

```perl
(?<=This is)(.*)(?=sentence)
```

will match `my first sentence. This is my second` in `This is my first sentence. This is my second sentence.`   

<a href="http://regex101.com/r/eZ1gT7/6"><strong>See demo</strong></a>.   

You need a lazy quantifier between the two lookarounds. Adding a `?` makes the star lazy.   

This matches what you want:  

```perl
(?<=This is).*?(?=sentence)
```

<a href="http://regex101.com/r/eZ1gT7/5">See demo</a>. I removed the capture group, which was not needed.   

<strong>DOTALL Mode to Match Across Line Breaks</strong>  

Note that in the demo the "dot matches line breaks mode" (a.k.a.) dot-all is set (see <a href="http://www.rexegg.com/regex-modifiers.html#dotall">how to turn on DOTALL in various languages</a>). In many regex flavors, you can set it with the online modifier `(?s)`, turning the expression into:  

```perl
(?s)(?<=This is).*?(?=sentence)
```

<hr>

<strong>Reference</strong>  

<ul>
<li><a href="http://www.rexegg.com/regex-greed.html">The Many Degrees of Regex Greed</a></li>
<li><a href="http://www.regular-expressions.info/repeat.html">Repetition with Star and Plus</a></li>
</ul>

#### Answer 3 (score 37)
Try `This is[\s\S]*sentence`, works in javascript  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: Regex to check whether a string contains only numbers (score [633360](https://stackoverflow.com/q/9011524) in 2018)

#### Question
```perl
hash = window.location.hash.substr(1);
var reg = new RegExp('^[0-9]$');
console.log(reg.test(hash));
```

I get false on both `"123"` and `"123f"`. I would like to check if the hash only contains numbers. Did I miss something?  

#### Answer accepted (score 452)
```perl
var reg = /^\d+$/;
```

should do it.  The original matches anything that consists of exactly one digit.  

#### Answer 2 (score 92)
As you said, you want hash to contain only numbers.  

```perl
var reg = new RegExp('^[0-9]+$');
```

or   

```perl
var reg = new RegExp('^\\d+$');
```

<p>`\d` and `[0-9]` both mean the same thing.
The + used means that search for one or more occurring of [0-9].</p>

#### Answer 3 (score 64)
This one will allow also for signed and float numbers or empty string:  

```perl
var reg = /^-?\d*\.?\d*$/
```

If you don't want allow to empty string use this one:  

```perl
var reg = /^-?\d+\.?\d*$/
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How to negate specific word in regex? (score [626264](https://stackoverflow.com/q/1240275) in 2016)

#### Question
I know that I can negate group of chars as in `[^bar]` but I need a regular expression where negation applies to the specific word - so in my example how do I negate an actual `"bar"` and not `"any chars in bar"`?  

#### Answer accepted (score 641)
A great way to do this is to use <a href="http://www.regular-expressions.info/lookaround.html" rel="noreferrer">negative lookahead</a>:  

```perl
^(?!.*bar).*$
```

<blockquote>
  The negative lookahead construct is the pair of parentheses, with the opening parenthesis followed by a question mark and an exclamation point. Inside the lookahead [is any regex pattern].  
</blockquote>

#### Answer 2 (score 60)
Unless performance is of utmost concern, it's often easier just to run your results through a second pass, skipping those that match the words you want to negate.   

Regular expressions usually mean you're doing scripting or some sort of low-performance task anyway, so find a solution that is easy to read, easy to understand and easy to maintain.  

#### Answer 3 (score 44)
The following regex will do what you want (as long as negative lookbehinds and lookaheads are supported), matching things properly; the only problem is that it matches individual characters (i.e. each match is a single character rather than all characters between two consecutive "bar"s), possibly resulting in a potential for high overhead if you're working with very long strings.  

```perl
b(?!ar)|(?<!b)a|a(?!r)|(?<!ba)r|[^bar]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: Regex to match only letters (score [623756](https://stackoverflow.com/q/3617797) in 2018)

#### Question
How can I write a regex that matches only letters?  

#### Answer 2 (score 357)
Use a character set: `[a-zA-Z]` matches one letter from A–Z in lowercase and uppercase. `[a-zA-Z]+` matches one or more letters and `^[a-zA-Z]+$` matches only strings that consist of one or more letters only (`^` and `$` mark the begin and end of a string respectively).  

If you want to match other letters than A–Z, you can either add them to the character set: `[a-zA-ZäöüßÄÖÜ]`. Or you use predefined character classes like the <a href="http://www.regular-expressions.info/unicode.html#prop" rel="noreferrer">Unicode character property</a> class `\p{L}` that describes the Unicode characters that are letters.  

#### Answer 3 (score 177)
`\p{L}` matches anything that is a Unicode letter if you're interested in alphabets beyond the Latin one  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: Split string on whitespace in Python (score [603894](https://stackoverflow.com/q/8113782) in 2015)

#### Question
I'm looking for the Python equivalent of   

```perl
String str = "many   fancy word \nhello    \thi";
String whiteSpaceRegex = "\\s";
String[] words = str.split(whiteSpaceRegex);

["many", "fancy", "word", "hello", "hi"]
```

#### Answer accepted (score 745)
The `str.split()` method without an argument splits on whitespace:  

```perl
>>> "many   fancy word \nhello    \thi".split()
['many', 'fancy', 'word', 'hello', 'hi']
```

#### Answer 2 (score 63)
```perl
import re
s = "many   fancy word \nhello    \thi"
re.split('\s+', s)
```

#### Answer 3 (score 14)
Another method through `re` module. It does the reverse operation of matching all the words instead of spitting the whole sentence by space.  

```perl
>>> import re
>>> s = "many   fancy word \nhello    \thi"
>>> re.findall(r'\S+', s)
['many', 'fancy', 'word', 'hello', 'hi']
```

Above regex would match one or more non-space characters.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: Simple regular expression for a decimal with a precision of 2 (score [593074](https://stackoverflow.com/q/308122) in 2012)

#### Question
What is the regular expression for a decimal with a precision of 2?  

<em>Valid examples</em>:  

```perl
123.12
2
56754
92929292929292.12
0.21
3.1
```

<em>Invalid examples:</em>  

```perl
12.1232
2.23332
e666.76
```

The decimal point may be optional, and integers may also be included.  

#### Answer accepted (score 376)
Valid regex tokens vary by implementation.  The most generic form that I know of would be:  

```perl
[0-9]+(\.[0-9][0-9]?)?
```

The most compact:  

```perl
\d+(\.\d{1,2})?
```

Both assume that you must have both at least one digit before and one after the decimal place.  

To require that the whole string is a number of this form, wrap the expression in start and end tags such as (in Perl's form):  

```perl
^\d+(\.\d{1,2})?$
```

<strong>ADDED:</strong> Wrapped the fractional portion in ()? to make it optional.  Be aware that this excludes forms such as "12."  Including that would be more like `^\d+\.?\d{0,2}$`.  

<p><strong>Added:</strong>
Use this format `^\d{1,6}(\.\d{1,2})?$` to stop repetition and give a restriction to whole part of the decimal value.</p>

#### Answer 2 (score 262)
```perl
^[0-9]+(\.[0-9]{1,2})?$
```

And since regular expressions are horrible to read, much less understand, here is the verbose equivalent:  

```perl
^                         # Start of string
 [0-9]+                   # Require one or more numbers
       (                  # Begin optional group
        \.                # Point must be escaped or it is treated as "any character"
          [0-9]{1,2}      # One or two numbers
                    )?    # End group--signify that it's optional with "?"
                      $   # End of string
```

You can replace `[0-9]` with `\d` in most regular expression implementations (including <a href="http://en.wikipedia.org/wiki/Perl_Compatible_Regular_Expressions" rel="noreferrer">PCRE</a>, the most common). I've left it as `[0-9]` as I think it's easier to read.  

Also, here is the simple Python script I used to check it:  

```perl
import re
deci_num_checker = re.compile(r"""^[0-9]+(\.[0-9]{1,2})?$""")

valid = ["123.12", "2", "56754", "92929292929292.12", "0.21", "3.1"]
invalid = ["12.1232", "2.23332", "e666.76"]

assert len([deci_num_checker.match(x) != None for x in valid]) == len(valid)
assert [deci_num_checker.match(x) == None for x in invalid].count(False) == 0
```

#### Answer 3 (score 20)
To include an optional minus sign and to disallow numbers like `015` (which can be mistaken for octal numbers) write:  

```perl
-?(0|([1-9]\d*))(\.\d+)?
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: How is the AND/OR operator represented as in Regular Expressions? (score [590059](https://stackoverflow.com/q/8020848) in 2019)

#### Question
<p>I'm currently programming a vocabulary algorithm that checks if a user has typed in the word correctly. I have the following situation:
The correct solution for the word would be "part1, part2".
The user should be able to enter either "part1" (answer 1), "part2" (answer 2) or "part1, part2" (answer 3). 
I now try to match the string given by the user with the following, automatically created, regex expression:</p>

```perl
^(part1|part2)$
```

This only returns answer 1 and 2 as correct while answer 3 would be wrong. I'm now wondering whether there's an operator similar to | that says `and/or` instead of `either...or`.  

May anyone help me solve this problem?  

#### Answer accepted (score 260)
I'm going to assume you want to build a the regex dynamically to contain other words than part1 and part2, and that you want order not to matter. If so you can use something like this:  

```perl
((^|, )(part1|part2|part3))+$
```

Positive matches:  

```perl
part1
part2, part1
part1, part2, part3
```

Negative matches:  

```perl
part1,           //with and without trailing spaces.
part3, part2, 
otherpart1
```

#### Answer 2 (score 25)
```perl
'^(part1|part2|part1,part2)$'
```

does it work?  

#### Answer 3 (score 5)
Does this work without alternation?  

```perl
^((part)1(, \22)?)?(part2)?$
```

or why not this?  

```perl
^((part)1(, (\22))?)?(\4)?$
```

The first works for all conditions the second for all but `part2`(using GNU sed 4.1.5)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: How to match "anything up until this sequence of characters" in a regular expression? (score [570881](https://stackoverflow.com/q/7124778) in )

#### Question
Take this regular expression: `/^[^abc]/`. This will match any single character at the beginning of a string, except a, b, or c.  

If you add a `*` after it – `/^[^abc]*/` – the regular expression will continue to add each subsequent character to the result, until it meets either an `a`, <strong>or</strong> `b`, <strong>or</strong> `c`.  

For example, with the source string `"qwerty qwerty whatever abc hello"`, the expression will match up to `"qwerty qwerty wh"`.   

But what if I wanted the matching string to be `"qwerty qwerty whatever "`   

...In other words, how can I match everything up to (but not including) the <em>exact sequence</em> `"abc"`?  

#### Answer accepted (score 884)
<p>You didn't  specify which flavor  of regex  you're using, but  this will
work in any of the most popular ones that can be considered "complete".</p>

```perl
/.+?(?=abc)/
```

<h5>How it works</h3>

<p>The  `.+?`  part is  the  un-greedy  version of  `.+`  (one  or more  of
anything). When we use `.+`, the engine will basically match everything.
Then, if there is  something else in the regex it will  go back in steps
trying to  match the  following part. This  is the  <strong>greedy</strong> behavior,
meaning <strong>as much as possible to satisfy</strong>.</p>

<p>When using  `.+?`, instead of  matching all at  once and going  back for
other conditions (if any), the engine  will match the next characters by
step until the  subsequent part of the regex is  matched (again if any).
This  is  the <strong>un-greedy</strong>,  meaning  match  <strong>the fewest  possible  to
satisfy</strong>.</p>

```perl
/.+X/  ~ "abcXabcXabcX"        /.+/  ~ "abcXabcXabcX"
          ^^^^^^^^^^^^                  ^^^^^^^^^^^^

/.+?X/ ~ "abcXabcXabcX"        /.+?/ ~ "abcXabcXabcX"
          ^^^^                          ^
```

<p>Following  that   we  have   `(?=`<strong>`{contents}`</strong>`)`,  a   <em>zero  width
assertion</em>,  a  <em>look around</em>.  This  grouped  construction matches  its
contents, but does not count  as characters matched (<strong>zero width</strong>). It
only returns if it is a match or not (<strong>assertion</strong>).</p>

Thus, in other terms the regex `/.+?(?=abc)/` means:  

<blockquote>
  <p>Match any  characters as  few  as possible  until a  "abc" is  found,
  without counting the "abc".</p>
</blockquote>

#### Answer 2 (score 104)
If you're looking to capture everything up to "abc":  

```perl
/^(.*?)abc/
```

Explanation:  

`( )` capture the expression inside the parentheses for access using `$1`, `$2`, etc.  

`^` match start of line  

`.*` match anything, `?` non-greedily (match the minimum number of characters required) - [1]  

[1] The reason why this is needed is that otherwise, in the following string:  

```perl
whatever whatever something abc something abc
```

by default, regexes are <em>greedy</em>, meaning it will match as much as possible. Therefore `/^.*abc/` would match "whatever whatever something abc something ". Adding the non-greedy quantifier `?` makes the regex only match "whatever whatever something ".  

#### Answer 3 (score 38)
As @Jared Ng and @Issun pointed out, the key to solve this kind of RegEx like "matching everything up to a certain word or substring" or "matching everything after a certain word or substring" is called "lookaround" zero-length assertions. <a href="http://www.regular-expressions.info/lookaround.html" rel="noreferrer">Read more about them here.</a>  

In your particular case, it can be solved by a positive look ahead. A picture is worth a thousand words. See the detail explanation in the screenshot.  

<a href="https://i.stack.imgur.com/cxm8d.png" rel="noreferrer"><img src="https://i.stack.imgur.com/cxm8d.png" alt="Regex101 Screenshot"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: How to extract a substring using regex (score [570678](https://stackoverflow.com/q/4662215) in 2014)

#### Question
I have a string that has two single quotes in it, the `'` character. In between the single quotes is the data I want.  

How can I write a regex to extract "the data i want" from the following text?  

```perl
mydata = "some string with 'the data i want' inside";
```

#### Answer accepted (score 511)
Assuming you want the part between single quotes, use this regular expression with a <a href="http://download.oracle.com/javase/6/docs/api/java/util/regex/Matcher.html" rel="noreferrer">`Matcher`</a>:  

```perl
"'(.*?)'"
```

Example:  

```perl
String mydata = "some string with 'the data i want' inside";
Pattern pattern = Pattern.compile("'(.*?)'");
Matcher matcher = pattern.matcher(mydata);
if (matcher.find())
{
    System.out.println(matcher.group(1));
}
```

Result:  

<pre>
the data i want
</pre>

#### Answer 2 (score 63)
You don't need regex for this.  

Add apache commons lang to your project (<a href="http://commons.apache.org/proper/commons-lang/" rel="noreferrer">http://commons.apache.org/proper/commons-lang/</a>), then use:  

```perl
String dataYouWant = StringUtils.substringBetween(mydata, "'");
```

#### Answer 3 (score 11)
```perl
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Test {
    public static void main(String[] args) {
        Pattern pattern = Pattern.compile(".*'([^']*)'.*");
        String mydata = "some string with 'the data i want' inside";

        Matcher matcher = pattern.matcher(mydata);
        if(matcher.matches()) {
            System.out.println(matcher.group(1));
        }

    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: Regex: ignore case sensitivity (score [569767](https://stackoverflow.com/q/9655164) in 2017)

#### Question
How can I make the following regex ignore case sensitivity? It should match all the correct characters but ignore whether they are lower or uppercase.  

```perl
G[a-b].*
```

#### Answer accepted (score 363)
Assuming you want the <strong>whole</strong> regex to ignore case, you should look for the <a href="http://www.regular-expressions.info/modifiers.html">`i` flag</a>. Nearly all regex engines support it:  

```perl
/G[a-b].*/i

string.match("G[a-b].*", "i")
```

Check the documentation for your language/platform/tool to find how the matching modes are specified.  

If you want only <strong>part</strong> of the regex to be case insensitive (as my original answer presumed), then you have two options:  

<ol>
<li><p>Use the `(?i)` and [optionally] `(?-i)` mode modifiers:</p>

```perl
(?i)G[a-b](?-i).*
```</li>
<li><p>Put all the variations (i.e. lowercase and uppercase) in the regex - useful if mode modifiers are not supported:</p>

```perl
[gG][a-bA-B].*
```</li>
</ol>

One last note: if you're dealing with Unicode characters besides ASCII, check whether or not your regex engine properly supports them.  

#### Answer 2 (score 120)
<p>Depends on implementation
but I would use</p>

```perl
(?i)G[a-b].
```

<strong>VARIATIONS:</strong>   

```perl
(?i) case-insensitive mode ON    
(?-i) case-insensitive mode OFF
```

Modern regex flavors allow you to apply modifiers to only part of the regular expression. If you insert the modifier (?im) in the middle of the regex then the modifier only applies to the part of the regex to the right of the modifier. With these flavors, you can turn off modes by preceding them with a minus sign (?-i).   

<p>Description is from the page:
<a href="https://www.regular-expressions.info/modifiers.html" rel="noreferrer">https://www.regular-expressions.info/modifiers.html</a></p>

#### Answer 3 (score 46)
regular expression for validate 'abc' ignoring case sensitive   

```perl
(?i)(abc)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: Find CRLF in Notepad++ (score [548272](https://stackoverflow.com/q/133965) in 2018)

#### Question
How can I find/replace all CR/LF characters in Notepad++?  

I am looking for something equivalent to the ^p special character in Microsoft Word.  

#### Answer accepted (score 398)
<strong>`[\r\n]+`</strong> should work too  

Update March, 26th 2012, release date of <strong><a href="http://notepad-plus-plus.org/news/notepad-6.0-release.html" rel="noreferrer">Notepad++ 6.0</a></strong>:  

OMG, it actually does work now!!!  

<img src="https://i.stack.imgur.com/ZiyXX.png" alt="PCRE regexp in Notepad++">  

<hr>

Original answer 2008 (Notepad++ 4.x) - 2009-2010-2011 (Notepad++ 5.x)  

Actually no, it does not seem to work with regexp...  

But if you have Notepad++ 5.x, you can use the '<strong>extended</strong>' search mode and look for `\r\n`. That does find all your `CRLF`.  

(I realize this is the same answer than the others, but again, 'extended mode' is only available with Notepad++ 4.9, 5.x and more)  

<hr>

<p>Since April 2009, you have a wiki article on the Notepad++ site on this topic:<br>
"<strong><a href="http://sourceforge.net/apps/mediawiki/notepad-plus/index.php?title=Replacing_Newlines" rel="noreferrer">How To Replace Line Ends, thus changing the line layout</a></strong>".<br>
(mentioned by <a href="https://stackoverflow.com/users/467509/georgiecasey">georgiecasey</a> in his/her <a href="https://stackoverflow.com/questions/133965/find-crlf-in-notepad/4608574#4608574">answer below</a>)</p>

Some relevant extracts includes the following search processes:  

<blockquote>
  <h5>Simple search (<kbd>Ctrl</kbd>+<kbd>F</kbd>), Search Mode = `Normal`</h3>
  
  You can select an `EOL` in the editing window.   
  
  <ul>
  <li>Just move the cursor to the end of the line, and type <kbd>Shift</kbd>+<kbd>Right</kbd> Arrow. </li>
  <li>or, to select `EOL` with the mouse, start just at the line end and drag to the start of the next line; dragging to the right of the `EOL` won't work.
  You can manually copy the `EOL` and paste it into the field for Unix files (`LF`-only).</li>
  </ul>
  
  <h5>Simple search (Ctrl+F), Search Mode = Extended</h3>
  
  <p>The "Extended" option shows `\n` and `\r` as characters that could be matched.<br>
  As with the Normal search mode, Notepad++ is looking for the exact character.<br>
  Searching for `\r` in a UNIX-format file will not find anything, but searching for `\n` will. Similarly, a Macintosh-format file will contain `\r` but not `\n`.</p>
  
  <h5>Simple search (Ctrl+F), Search Mode = Regular expression</h3>
  
  <p>Regular expressions use the characters `^` and `$` to anchor the match string to the beginning or end of the line. For instance, searching for `return;$` will find occurrences of "return;" that occur with no subsequent text on that same line. The anchor characters work identically in all file formats.<br>
  The '.' dot metacharacter does not match line endings.</p>
  
  <p>[Tested in Notepad++ 5.8.5]: <strong>a regular expression search with an explicit `\r` or `\n` does not work (contrary to the <a href="http://www.scintilla.org/ScintillaDoc.html" rel="noreferrer">Scintilla documentation</a>)</strong>.<br>
  Neither does a search on an explicit (pasted) LF, or on the (invisible) EOL characters placed in the field when an EOL is selected.
  Advanced search (<kbd>Ctrl</kbd>+<kbd>R</kbd>) without regexp</p>
  
  <p><kbd>Ctrl</kbd>+<kbd>M</kbd> will insert something that matches newlines. They will be replaced by the replace string.<br>
  I recommend this method as the most reliable, unless you really need to use regex.<br>
  As an example, to remove every second newline in a double spaced file, enter <kbd>Ctrl</kbd>+<kbd>M</kbd> twice in the search string box, and once in the replace string box.</p>
  
  <h5>Advanced search (<kbd>Ctrl</kbd>+<kbd>R</kbd>) with Regexp.</h3>
  
  Neither <kbd>Ctrl</kbd>+<kbd>M</kbd>, `$` nor `\r\n` are matched.   
</blockquote>

<hr>

The same wiki also mentions the <strong>Hex editor alternative</strong>:  

<blockquote>
  <ul>
  <li>Type the new string at the beginning of the document. </li>
  <li>Then select to <strong>view the document in Hex mode</strong>.  </li>
  <li>Select one of the new lines and hit <kbd>Ctrl</kbd>+<kbd>H</kbd>. </li>
  <li>While you have the Replace dialog box up, select on the background the new replacement string and <kbd>Ctrl</kbd>+<kbd>C</kbd> copy it to paste it in the Replace with text input. </li>
  <li>Then Replace or Replace All as you wish. </li>
  </ul>
  
  <p>Note: the character selected for new line usually appears as <strong>`0a`</strong>.<br>
  It may have a different value if the file is in Windows Format. In that case you can always go to `Edit -&gt; EOL Conversion -&gt; Convert to Unix Format`, and after the replacement switch it back and `Edit -&gt; EOL Conversion -&gt; Convert to Windows Format`.</p>
</blockquote>

#### Answer 2 (score 22)
It appears that this is a <a href="http://notepad-plus.sourceforge.net/uk/newlineFindReplace-HOWTO.php" rel="noreferrer">FAQ</a>, and the resolution offered is:  

<blockquote>
  <strong>Simple search (Ctrl+H) without regexp</strong>  
  
  <p>You can turn on View/Show End of Line
  or view/Show All, and select the now
  visible newline characters. Then when
  you start the command some characters
  matching the newline character will be
  pasted into the search field. Matches
  will be replaced by the replace
  string, unlike in regex mode.</p>
  
  <p>Note 1: If you select them with the
  mouse, start just before them and drag
  to the start of the next line.
  Dragging to the end of the line won't
  work. </p>
  
  <p>Note 2: You can't copy and paste
  them into the field yourself.</p>
  
  <strong>Advanced search (Ctrl+R) without regexp</strong>  
  
  Ctrl+M will insert something that matches newlines. They will be replaced by the replace string.  
</blockquote>

#### Answer 3 (score 10)
On the Replace dialog, you want to set the search mode to "Extended".  Normal or Regular Expression modes wont work.  

Then just find "\r\n"  (or just \n for unix files or just \r for mac format files), and set the replace to whatever you want.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: What is a good regular expression to match a URL? (score [534454](https://stackoverflow.com/q/3809401) in 2012)

#### Question
Currently I have an input box which will detect the URL and parse the data.  

So right now, I am using:  

```perl
var urlR = /^(?:([A-Za-z]+):)?(\/{0,3})([0-9.\-A-Za-z]+)
           (?::(\d+))?(?:\/([^?#]*))?(?:\?([^#]*))?(?:#(.*))?$/;
var url= content.match(urlR);
```

The problem is, when I enter a URL like `www.google.com`, its not working. when I entered `http://www.google.com`, it is working.  

I am not very fluent in regular expressions. Can anyone help me?  

#### Answer 2 (score 492)
Regex if you want to ensure URL starts with HTTP/HTTPS:  

```perl
https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)
```

If you do not require HTTP protocol:  

```perl
[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)
```

To try this out see <a href="http://regexr.com?37i6s" rel="noreferrer">http://regexr.com?37i6s</a>, or for a version which is less restrictive <a href="http://regexr.com/3e6m0" rel="noreferrer">http://regexr.com/3e6m0</a>.  

Example JavaScript implementation:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
var expression = /[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)?/gi;
var regex = new RegExp(expression);
var t = 'www.google.com';

if (t.match(regex)) {
  alert("Successful match");
} else {
  alert("No match");
}
```
</div>
</div>


#### Answer 3 (score 169)
```perl
(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})
```

Will match the following cases  

<ul>
<li>`http://www.foufos.gr`</li>
<li>`https://www.foufos.gr`</li>
<li>`http://foufos.gr`</li>
<li>`http://www.foufos.gr/kino`</li>
<li>`http://werer.gr`</li>
<li>`www.foufos.gr`</li>
<li>`www.mp3.com`</li>
<li>`www.t.co`</li>
<li>`http://t.co`</li>
<li>`http://www.t.co`</li>
<li>`https://www.t.co`</li>
<li>`www.aa.com`</li>
<li>`http://aa.com`</li>
<li>`http://www.aa.com`</li>
<li>`https://www.aa.com`</li>
</ul>

Will NOT match the following  

<ul>
<li>`www.foufos`</li>
<li>`www.foufos-.gr`</li>
<li>`www.-foufos.gr`</li>
<li>`foufos.gr`</li>
<li>`http://www.foufos`</li>
<li>`http://foufos`</li>
<li>`www.mp3#.com`</li>
</ul>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
var expression = /(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})/gi;
var regex = new RegExp(expression);

var check = [
  'http://www.foufos.gr',
  'https://www.foufos.gr',
  'http://foufos.gr',
  'http://www.foufos.gr/kino',
  'http://werer.gr',
  'www.foufos.gr',
  'www.mp3.com',
  'www.t.co',
  'http://t.co',
  'http://www.t.co',
  'https://www.t.co',
  'www.aa.com',
  'http://aa.com',
  'http://www.aa.com',
  'https://www.aa.com',
  'www.foufos',
  'www.foufos-.gr',
  'www.-foufos.gr',
  'foufos.gr',
  'http://www.foufos',
  'http://foufos',
  'www.mp3#.com'
];

check.forEach(function(entry) {
  if (entry.match(regex)) {
    $("#output").append( "<div >Success: " + entry + "</div>" );
  } else {
    $("#output").append( "<div>Fail: " + entry + "</div>" );
  }
});
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"&gt;&lt;/script&gt;
&lt;div id="output"&gt;&lt;/div&gt;</code></pre>
</div>
</div>


<a href="https://rubular.com/r/eGPe4bGlwMd98E" rel="noreferrer">Check it in rubular - NEW version</a>  

<a href="https://www.rubular.com/r/WacnNAOQZa" rel="noreferrer"><del>Check it in rubular - old version</del></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: Regex to validate date format dd/mm/yyyy (score [533749](https://stackoverflow.com/q/15491894) in 2016)

#### Question
I need to validate a date string for the format `dd/mm/yyyy` with a regular expresssion.  

This regex validates `dd/mm/yyyy`, but not the invalid dates like `31/02/4500`:  

```perl
^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$
```

What is a valid regex to validate `dd/mm/yyyy` format with leap year support?  

#### Answer accepted (score 286)
<p>The regex you pasted does not validate leap years correctly, but there is one that does <a href="https://stackoverflow.com/a/8768241/1537042">in the same post</a>.
I modified it to take `dd/mm/yyyy`, `dd-mm-yyyy` or `dd.mm.yyyy`.</p>

`^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$`  

I tested it a bit in the link Arun provided in his answer and also <a href="http://regexr.com?346hf" rel="noreferrer">here</a> and it seems to work.  

Edit February 14th 2019: I've removed a comma that was in the regex which allowed dates like `29-0,-11`  

#### Answer 2 (score 240)
I have extended the regex given by @Ofir Luzon for the formats dd-mmm-YYYY, dd/mmm/YYYY, dd.mmm.YYYY as per my requirement. Anyone else with same requirement can refer this  

```perl
^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]|(?:Jan|Mar|May|Jul|Aug|Oct|Dec)))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2]|(?:Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)(?:0?2|(?:Feb))\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9]|(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep))|(?:1[0-2]|(?:Oct|Nov|Dec)))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$
```

and tested for some test cases here <a href="http://regexr.com/39tr1" rel="noreferrer">http://regexr.com/39tr1</a>.  

<p>For better understanding for this Regular expression refer this image:
<img src="https://i.stack.imgur.com/D4YDF.png" alt="enter image description here"></p>

#### Answer 3 (score 63)
Notice:   

<blockquote>
  Your regexp does not work for years that "are multiples of 4 and 100, but not of 400". Years that pass that test are not leap years. For example: 1900, 2100, 2200, 2300, 2500, etc. In other words, it puts all years with the format \d\d00 in the same class of leap years, which is incorrect. – MuchToLearn     
</blockquote>

So it works properly only for [1901 - 2099]     (Whew)  😊    

dd/MM/yyyy:  

<p>Checks if leap year.
Years from 1900 to 9999 are valid. Only dd/MM/yyyy</p>

```perl
(^(((0[1-9]|1[0-9]|2[0-8])[\/](0[1-9]|1[012]))|((29|30|31)[\/](0[13578]|1[02]))|((29|30)[\/](0[4,6,9]|11)))[\/](19|[2-9][0-9])\d\d$)|(^29[\/]02[\/](19|[2-9][0-9])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)$)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: Replace specific characters within strings (score [524267](https://stackoverflow.com/q/11936339) in 2019)

#### Question
I would like to remove specific characters from strings within a vector, similar to the <em>Find and Replace</em> feature in Excel.   

Here are the data I start with:  

```perl
group <- data.frame(c("12357e", "12575e", "197e18", "e18947")
```

I start with just the first column; I want to produce the second column by removing the `e`'s:  

```perl
group       group.no.e
12357e      12357
12575e      12575
197e18      19718
e18947      18947
```

#### Answer accepted (score 376)
With a regular expression and the function `gsub()`:  

```perl
group <- c("12357e", "12575e", "197e18", "e18947")
group
[1] "12357e" "12575e" "197e18" "e18947"

gsub("e", "", group)
[1] "12357" "12575" "19718" "18947"
```

What `gsub` does here is to replace each occurrence of `"e"` with an empty string `""`.  

<hr>

See `?regexp` or `gsub` for more help.  

#### Answer 2 (score 45)
Regular expressions are your friends:  

```perl
R> ## also adds missing ')' and sets column name
R> group<-data.frame(group=c("12357e", "12575e", "197e18", "e18947"))  )
R> group
   group
1 12357e
2 12575e
3 197e18
4 e18947
```

Now use `gsub()` with the simplest possible replacement pattern: empty string:  

```perl
R> group$groupNoE <- gsub("e", "", group$group)
R> group
   group groupNoE
1 12357e    12357
2 12575e    12575
3 197e18    19718
4 e18947    18947
R> 
```

#### Answer 3 (score 23)
Summarizing 2 ways to replace strings:  

```perl
group<-data.frame(group=c("12357e", "12575e", "197e18", "e18947"))
```

1) Use `gsub`  

```perl
group$group.no.e <- gsub("e", "", group$group)
```

2) Use the `stringr` package  

```perl
group$group.no.e <- str_replace_all(group$group, "e", "")
```

Both will produce the desire output:  

```perl
   group group.no.e
1 12357e      12357
2 12575e      12575
3 197e18      19718
4 e18947      18947
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How do I match any character across multiple lines in a regular expression? (score [520690](https://stackoverflow.com/q/159118) in 2015)

#### Question
For example, this regex  

```perl
(.*)<FooBar>
```

will match:  

```perl
abcde<FooBar>
```

But how do I get it to match across multiple lines?  

```perl
abcde
fghij<FooBar>
```

#### Answer accepted (score 215)
It depends on the language, but there should be a modifier that you can add to the regex pattern. In PHP it is:  

```perl
/(.*)<FooBar>/s
```

The <strong>s</strong> at the end causes the dot to match <em>all</em> characters including newlines.  

#### Answer 2 (score 308)
Try this:    

```perl
((.|\n)*)<FooBar>
```

It basically says "any character or a newline" repeated zero or more times.  

#### Answer 3 (score 68)
The question is, can `.` pattern match <em>any</em> character? The answer varies from engine to engine. The main difference is whether the pattern is used by a POSIX or non-POSIX regex library.  

Special note about <a href="/questions/tagged/lua-patterns" class="post-tag" title="show questions tagged &#39;lua-patterns&#39;" rel="tag">lua-patterns</a>: they are not considered regular expressions, but `.` matches any char there, same as POSIX based engines.  

Another note on <a href="/questions/tagged/matlab" class="post-tag" title="show questions tagged &#39;matlab&#39;" rel="tag">matlab</a> and <a href="/questions/tagged/octave" class="post-tag" title="show questions tagged &#39;octave&#39;" rel="tag">octave</a>: the `.` matches any char by default (<a href="https://ideone.com/OkH7Mh" rel="noreferrer">demo</a>): `str = "abcde\n     fghij&lt;Foobar&gt;"; expression = '(.*)&lt;Foobar&gt;*'; [tokens,matches] = regexp(str,expression,'tokens','match');` (`tokens` contain a `abcde\n     fghij` item).  

Also, in all of <a href="/questions/tagged/boost" class="post-tag" title="show questions tagged &#39;boost&#39;" rel="tag">boost</a>'s regex grammars the dot matches line breaks by default. Boost's ECMAScript grammar allows you to turn this off with `regex_constants::no_mod_m` (<a href="http://www.regular-expressions.info/dot.html" rel="noreferrer">source</a>).  

As for <a href="/questions/tagged/oracle" class="post-tag" title="show questions tagged &#39;oracle&#39;" rel="tag">oracle</a> (it is POSIX based), use <a href="https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions130.htm" rel="noreferrer">`n` option</a> (<a href="http://rextester.com/WEQF2051" rel="noreferrer">demo</a>): `select regexp_substr('abcde' || chr(10) ||'     fghij&lt;Foobar&gt;', '(.*)&lt;Foobar&gt;', 1, 1, 'n', 1) as results from dual`  

<strong>POSIX-based engines</strong>:  

A mere `.` already matches line breaks, no need to use any modifiers, see <a href="/questions/tagged/bash" class="post-tag" title="show questions tagged &#39;bash&#39;" rel="tag">bash</a> (<a href="https://ideone.com/d1XTpR" rel="noreferrer">demo</a>).  

The <a href="/questions/tagged/tcl" class="post-tag" title="show questions tagged &#39;tcl&#39;" rel="tag">tcl</a> (<a href="https://ideone.com/ORmscd" rel="noreferrer">demo</a>), <a href="/questions/tagged/postgresql" class="post-tag" title="show questions tagged &#39;postgresql&#39;" rel="tag">postgresql</a> (<a href="http://rextester.com/FWXM76553" rel="noreferrer">demo</a>), <a href="/questions/tagged/r" class="post-tag" title="show questions tagged &#39;r&#39;" rel="tag">r</a> (TRE, base R default engine with no `perl=TRUE`, for base R with `perl=TRUE` or for <em>stringr</em>/<em>stringi</em> patterns, use the `(?s)` inline modifier) (<a href="https://ideone.com/A1kIU4" rel="noreferrer">demo</a>) also treat `.` the same way.    

<em>However</em>, most POSIX based tools process input line by line. Hence, `.` does not match the line breaks just because they are not in scope. Here are some examples how to override this:  

<ul>
<li><a href="/questions/tagged/sed" class="post-tag" title="show questions tagged &#39;sed&#39;" rel="tag">sed</a> - There are multiple workarounds, the most precise but not very safe is `sed 'H;1h;$!d;x; s/\(.*\)&gt;&lt;Foobar&gt;/\1/'` (`H;1h;$!d;x;` slurps the file into memory). If whole lines must be included, `sed '/start_pattern/,/end_pattern/d' file` (removing from start will end with matched lines included) or `sed '/start_pattern/,/end_pattern/{{//!d;};}' file` (with matching lines excluded) can be considered.</li>
<li><a href="/questions/tagged/perl" class="post-tag" title="show questions tagged &#39;perl&#39;" rel="tag">perl</a> - `perl -0pe 's/(.*)&lt;FooBar&gt;/$1/gs' &lt;&lt;&lt; "$str"` (`-0` slurps the whole file into memory, `-p` prints the file after applying the script given by `-e`). Note that using `-000pe` will slurp the file and activate 'paragraph mode' where Perl uses consecutive newlines (`\n\n`) as the record separator.</li>
<li><a href="/questions/tagged/gnu-grep" class="post-tag" title="show questions tagged &#39;gnu-grep&#39;" rel="tag">gnu-grep</a> - `grep -Poz '(?si)abc\K.*?(?=&lt;Foobar&gt;)' file`. Here, `z` enables file slurping, `(?s)` enables the DOTALL mode for the `.` pattern, `(?i)` enables case insensitive mode, `\K` omits the text matched so far, `*?` is a lazy quantifier, `(?=&lt;Foobar&gt;)` matches the location before `&lt;Foobar&gt;`.</li>
<li><a href="/questions/tagged/pcregrep" class="post-tag" title="show questions tagged &#39;pcregrep&#39;" rel="tag">pcregrep</a> - `pcregrep -Mi "(?si)abc\K.*?(?=&lt;Foobar&gt;)" file` (`M` enables file slurping here). Note `pcregrep` is a good solution for Mac OS `grep` users.</li>
</ul>

<a href="https://ideone.com/J7n00M" rel="noreferrer">See demos</a>.  

<strong>Non-POSIX-based engines</strong>:  

<ul>
<li><a href="/questions/tagged/php" class="post-tag" title="show questions tagged &#39;php&#39;" rel="tag">php</a> - Use `s` modifier <a href="http://php.net/manual/en/reference.pcre.pattern.modifiers.php" rel="noreferrer">PCRE_DOTALL modifier</a>: `preg_match('~(.*)&lt;Foobar&gt;~s', $s, $m)` (<a href="https://ideone.com/QyLjnm" rel="noreferrer">demo</a>)</li>
<li><a href="/questions/tagged/c%23" class="post-tag" title="show questions tagged &#39;c#&#39;" rel="tag">c#</a> - Use `RegexOptions.Singleline` flag (<a href="https://ideone.com/agPd94" rel="noreferrer">demo</a>): <br/> - `var result = Regex.Match(s, @"(.*)&lt;Foobar&gt;", RegexOptions.Singleline).Groups[1].Value;`<br/>- `var result = Regex.Match(s, @"(?s)(.*)&lt;Foobar&gt;").Groups[1].Value;`</li>
<li><a href="/questions/tagged/powershell" class="post-tag" title="show questions tagged &#39;powershell&#39;" rel="tag">powershell</a> - Use `(?s)` inline option: `$s = "abcde`nfghij&lt;FooBar>"; $s -match "(?s)(.*)&lt;Foobar>"; $matches[1]`</li>
<li><a href="/questions/tagged/perl" class="post-tag" title="show questions tagged &#39;perl&#39;" rel="tag">perl</a> - Use `s` modifier (or `(?s)` inline version at the start) (<a href="https://ideone.com/nsYpjE" rel="noreferrer">demo</a>): `/(.*)&lt;FooBar&gt;/s`</li>
<li><a href="/questions/tagged/python" class="post-tag" title="show questions tagged &#39;python&#39;" rel="tag">python</a> - Use `re.DOTALL` (or `re.S`) flags or `(?s)` inline modifier (<a href="https://ideone.com/A21CXy" rel="noreferrer">demo</a>): `m = re.search(r"(.*)&lt;FooBar&gt;", s, flags=re.S)` (and then `if m:`, `print(m.group(1))`)</li>
<li><a href="/questions/tagged/java" class="post-tag" title="show questions tagged &#39;java&#39;" rel="tag">java</a> - Use `Pattern.DOTALL` modifier (or inline `(?s)` flag) (<a href="https://ideone.com/Oq1j8Z" rel="noreferrer">demo</a>): `Pattern.compile("(.*)&lt;FooBar&gt;", Pattern.DOTALL)`</li>
<li><a href="/questions/tagged/groovy" class="post-tag" title="show questions tagged &#39;groovy&#39;" rel="tag">groovy</a> - Use `(?s)` in-pattern modifier (<a href="https://ideone.com/2wmACW" rel="noreferrer">demo</a>): `regex = /(?s)(.*)&lt;FooBar&gt;/`</li>
<li><a href="/questions/tagged/scala" class="post-tag" title="show questions tagged &#39;scala&#39;" rel="tag">scala</a> - Use `(?s)` modifier (<a href="https://ideone.com/faL4xJ" rel="noreferrer">demo</a>): `"(?s)(.*)&lt;Foobar&gt;".r.findAllIn("abcde\n    fghij&lt;Foobar&gt;").matchData foreach { m =&gt; println(m.group(1)) }`</li>
<li><a href="/questions/tagged/javascript" class="post-tag" title="show questions tagged &#39;javascript&#39;" rel="tag">javascript</a> - Use `[^]` or workarounds `[\d\D]` / `[\w\W]` / `[\s\S]` (<a href="https://jsfiddle.net/36c6rt7o/3/" rel="noreferrer">demo</a>): `s.match(/([\s\S]*)&lt;FooBar&gt;/)[1]`</li>
<li><a href="/questions/tagged/c%2b%2b" class="post-tag" title="show questions tagged &#39;c++&#39;" rel="tag">c++</a> (`std::regex`) Use `[\s\S]` or the JS workarounds (<a href="https://ideone.com/2xC4ih" rel="noreferrer">demo</a>): `regex rex(R"(([\s\S]*)&lt;FooBar&gt;)");`</li>
<li><a href="/questions/tagged/vba" class="post-tag" title="show questions tagged &#39;vba&#39;" rel="tag">vba</a> - Use the same approach as in JavaScript, `([\s\S]*)&lt;Foobar&gt;`.</li>
<li><a href="/questions/tagged/ruby" class="post-tag" title="show questions tagged &#39;ruby&#39;" rel="tag">ruby</a> - Use <a href="https://ruby-doc.org/core-2.4.0/Regexp.html#class-Regexp-label-Options" rel="noreferrer">`/m` <em>MULTILINE</em> modifier</a> (<a href="https://ideone.com/hSj5M2" rel="noreferrer">demo</a>): `s[/(.*)&lt;Foobar&gt;/m, 1]`</li>
<li><a href="/questions/tagged/go" class="post-tag" title="show questions tagged &#39;go&#39;" rel="tag">go</a> - Use the inline modifier `(?s)` at the start (<a href="https://play.golang.org/p/Xqproig3jZ" rel="noreferrer">demo</a>): `re: = regexp.MustCompile(`(?s)(.*)&lt;FooBar>`)`</li>
<li><a href="/questions/tagged/swift" class="post-tag" title="show questions tagged &#39;swift&#39;" rel="tag">swift</a> - Use <a href="https://developer.apple.com/documentation/foundation/nsregularexpression.options/1412529-dotmatcheslineseparators" rel="noreferrer">`dotMatchesLineSeparators`</a> or (easier) pass the `(?s)` inline modifier to the pattern: `let rx = "(?s)(.*)&lt;Foobar&gt;"`</li>
<li><a href="/questions/tagged/objective-c" class="post-tag" title="show questions tagged &#39;objective-c&#39;" rel="tag">objective-c</a> - Same as Swift, `(?s)` works the easiest, but here is how the <a href="https://ideone.com/C6RP37" rel="noreferrer">option can be used</a>: <code>NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern 
options:NSRegularExpressionDotMatchesLineSeparators error:&amp;regexError];</code></li>
<li><a href="/questions/tagged/re2" class="post-tag" title="show questions tagged &#39;re2&#39;" rel="tag">re2</a>, <a href="/questions/tagged/google-apps-script" class="post-tag" title="show questions tagged &#39;google-apps-script&#39;" rel="tag">google-apps-script</a> - Use `(?s)` modifier (<a href="https://docs.google.com/spreadsheets/d/1kn6Bb4TTjXT27Yfqwi3Z9K6YQVQxqHIBYoAAa1B4NsA/edit#gid=0" rel="noreferrer">demo</a>): `"(?s)(.*)&lt;Foobar&gt;"` (in Google Spreadsheets, `=REGEXEXTRACT(A2,"(?s)(.*)&lt;Foobar&gt;")`)</li>
</ul>

<strong>NOTES ON `(?s)`</strong>:  

In most non-POSIX engines, `(?s)` inline modifier (or embedded flag option) can be used to enforce `.` to match line breaks.  

If placed at the start of the pattern, `(?s)` changes the bahavior of all `.` in  the pattern. If the `(?s)` is placed somewhere after the beginning, only those `.` will be affected that are located to the right of it <em>unless</em> this is a pattern passed to Python `re`. In Python `re`, regardless of the `(?s)` location, the whole pattern `.` are affected. The `(?s)` effect is stopped using `(?-s)`. A modified group can be used to only affect a specified range of a regex pattern (e.g. `Delim1(?s:.*?)\nDelim2.*` will make the first `.*?` match across newlines and the second `.*` will only match the rest of the line).  

<strong>POSIX note</strong>:  

In non-POSIX regex engines, to match any char, `[\s\S]` / `[\d\D]` / `[\w\W]` constructs can be used.  

In POSIX, `[\s\S]` is not matching any char (as in JavaScript or any non-POSIX engine) because regex escape sequences are not supported inside bracket expressions. `[\s\S]` is parsed as bracket expressions that match a single char, `\` or `s` or `S`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: Regular expression to stop at first match (score [520377](https://stackoverflow.com/q/2503413) in 2012)

#### Question
My regex pattern looks something like  

```perl
<xxxx location="file path/level1/level2" xxxx some="xxx">
```

I am only interested in the part in quotes assigned to location. Shouldn't it be as easy as below without the greedy switch?   

```perl
/.*location="(.*)".*/
```

Does not seem to work.  

#### Answer accepted (score 970)
You need to make your regular expression non-greedy, because by default, `"(.*)"` will match all of `"file path/level1/level2" xxx some="xxx"`.  

Instead you can make your dot-star non-greedy, which will make it match as few characters as possible:  

```perl
/location="(.*?)"/
```

Adding a `?` on a quantifier (`?`, `*` or `+`) makes it non-greedy.  

#### Answer 2 (score 48)
`location="(.*)"` will match from the " after `location=` until the " after `some="xxx` unless you make it non-greedy. So you either need `.*?` (i.e. make it non-greedy) or better replace `.*` with `[^"]*`.  

#### Answer 3 (score 29)
How about  

```perl
.*location="([^"]*)".*
```

This avoids the unlimited search with .* and will match exactly to the first quote.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: A regular expression to exclude a word/string (score [515997](https://stackoverflow.com/q/2078915) in 2010)

#### Question
I have a regular expression as follows:  

```perl
^/[a-z0-9]+$
```

This matches strings such as `/hello` or `/hello123`.  

However, I would like it to exclude a couple of string values such as `/ignoreme` and `/ignoreme2`.  

I've tried a few variants but can't seem to get any to work!  

My latest feeble attempt was   

```perl
^/(((?!ignoreme)|(?!ignoreme2))[a-z0-9])+$
```

Any help would be gratefully appreciated :-)  

#### Answer accepted (score 328)
Here's yet another way (using a <a href="http://www.regular-expressions.info/lookaround.html" rel="noreferrer">negative look-ahead</a>):   

```perl
^/(?!ignoreme|ignoreme2|ignoremeN)([a-z0-9]+)$ 
```

Note: There's only one capturing expression: `([a-z0-9]+)`.   

#### Answer 2 (score 39)
This should do it:  

```perl
^/\b([a-z0-9]+)\b(?<!ignoreme|ignoreme2|ignoreme3)
```

You can add as much ignored words as you like, here is a simple PHP implementation:  

```perl
$ignoredWords = array('ignoreme', 'ignoreme2', 'ignoreme...');

preg_match('~^/\b([a-z0-9]+)\b(?<!' . implode('|', array_map('preg_quote', $ignoredWords)) . ')~i', $string);
```

#### Answer 3 (score 17)
As you want to exclude both words, you need a conjuction:  

```perl
^/(?!ignoreme$)(?!ignoreme2$)[a-z0-9]+$
```

Now both conditions must be true (neither <em>ignoreme</em> nor <em>ignoreme2</em> is allowed) to have a match.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: Regex for password must contain at least eight characters, at least one number and both lower and uppercase letters and special characters (score [498895](https://stackoverflow.com/q/19605150) in 2017)

#### Question
I want a regular expression to check that:  

A password contains at least eight characters, including at least one number and  includes both lower and uppercase letters and special characters, for example `#`, `?`, `!`.  

It cannot be your old password or contain your username, `"password"`, or `"websitename"`  

And here is my validation expression which is for eight characters including one uppercase letter, one lowercase letter, and one number or special character.  

```perl
(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
```

How can I write it for <strong>a password must be eight characters including one uppercase letter, one special character and alphanumeric characters</strong>?  

#### Answer 2 (score 965)
Minimum eight characters, at least one letter and one number:  

```perl
"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
```

Minimum eight characters, at least one letter, one number and one special character:  

```perl
"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$"
```

Minimum eight characters, at least one uppercase letter, one lowercase letter and one number:  

```perl
"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"
```

Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:  

```perl
"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
```

Minimum eight and maximum 10 characters, at least one uppercase letter, one lowercase letter, one number and one special character:  

```perl
"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,10}$"
```

#### Answer 3 (score 330)
You may use this regex with multiple <a href="https://www.regular-expressions.info/lookaround.html" rel="noreferrer">lookahead assertions (conditions)</a>:  

```perl
^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$
```

This regex will enforce these rules:  

<ul>
<li>At least one upper case <a href="https://en.wikipedia.org/wiki/English_alphabet" rel="noreferrer">English letter</a>, `(?=.*?[A-Z])`</li>
<li>At least one lower case English letter, `(?=.*?[a-z])`</li>
<li>At least one digit, `(?=.*?[0-9])`</li>
<li>At least one special character, `(?=.*?[#?!@$%^&amp;*-])`</li>
<li>Minimum eight in length `.{8,}` (with the anchors)</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How to remove all line breaks from a string (score [487768](https://stackoverflow.com/q/10805125) in 2018)

#### Question
I have a text in a textarea and I read it out using the .value attribute.  

Now I would like to remove all linebreaks (the character that is produced when you press <kbd>Enter</kbd>) from my text now using .replace with a regular expression, but how do I indicate a linebreak in a regex?  

If that is not possible, is there another way?  

#### Answer accepted (score 430)
This is probably a FAQ.  Anyhow, line breaks (better: newlines) can be one of Carriage Return (CR, `\r`, on older Macs), Line Feed (LF, `\n`, on Unices incl. Linux) or CR followed by LF (`\r\n`, on WinDOS). (Contrary to another answer, this has <em>nothing</em> to do with character encoding.)  

Therefore, the most efficient `RegExp` literal to match all variants is  

```perl
/\r?\n|\r/
```

If you want to match all newlines in a string, use a global match,  

```perl
/\r?\n|\r/g
```

respectively.  Then proceed with the `replace` method as suggested in several other answers. (Probably you do <em>not</em> want to remove the newlines, but replace them with other whitespace, for example the space character, so that words remain intact.)  

#### Answer 2 (score 453)
How you'd find a line break varies between operating system encodings. Windows would be `\r\n`, but Linux just uses `\n` and Apple uses `\r`.  

I found this in <a href="http://www.textfixer.com/tutorials/javascript-line-breaks.php" rel="noreferrer">JavaScript line breaks</a>:  

```perl
someText = someText.replace(/(\r\n|\n|\r)/gm, "");
```

That should remove all kinds of line breaks.  

#### Answer 3 (score 97)
<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/Trim" rel="noreferrer">`String.trim()`</a> removes whitespace from the beginning and end of strings... including newlines.  

```perl
const myString = "   \n \n\n Hey! \n I'm a string!!!         \n\n";
const trimmedString = myString.trim();

console.log(trimmedString);
// outputs: "Hey! \n I'm a string!!!"
```

Here's an example fiddle: <a href="http://jsfiddle.net/BLs8u/" rel="noreferrer">http://jsfiddle.net/BLs8u/</a>  

<strong>NOTE!</strong> it only trims the beginning and end of the string, not line breaks or whitespace in the middle of the string.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Find and extract a number from a string (score [480142](https://stackoverflow.com/q/4734116) in 2015)

#### Question
I have a requirement to find and extract a number contained within a string.  

For example, from these strings:  

```perl
string test = "1 test"
string test1 = " 1 test"
string test2 = "test 99"
```

How can I do this?  

#### Answer 2 (score 500)
`\d+` is the regex for an integer number. So   

```perl
//System.Text.RegularExpressions.Regex
resultString = Regex.Match(subjectString, @"\d+").Value;
```

returns a string containing the first occurrence of a number in `subjectString`.  

`Int32.Parse(resultString)` will then give you the number.  

#### Answer 3 (score 154)
Here's how I cleanse phone numbers to get the digits only:  

```perl
string numericPhone = new String(phone.Where(Char.IsDigit).ToArray());
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: Regular expression to extract text between square brackets (score [478828](https://stackoverflow.com/q/2403122) in 2010)

#### Question
Simple regex question. I have a string on the following format:  

```perl
this is a [sample] string with [some] special words. [another one]
```

What is the regular expression to extract the words within the square brackets, ie.  

```perl
sample
some
another one
```

Note: In my use case, brackets cannot be nested.  

#### Answer accepted (score 664)
You can use the following regex <strong>globally</strong>:  

```perl
\[(.*?)\]
```

Explanation:  

<ul>
<li>`\[` : `[` is a meta char and needs to be escaped if you want to match it literally.</li>
<li>`(.*?)` : match everything in a non-greedy way and capture it.</li>
<li>`\]` : `]` is a meta char and needs to be escaped if you want to match it literally.</li>
</ul>

#### Answer 2 (score 88)
```perl
(?<=\[).+?(?=\])
```

Will capture content without brackets  

<ul>
<li><p>`(?&lt;=\[)` - positive lookbehind for `[`</p></li>
<li><p>`.*?` - non greedy match for the content</p></li>
<li><p>`(?=\])` - positive lookahead for `]`</p></li>
</ul>

EDIT: for nested brackets the below regex should work:  

```perl
(\[(?:\[??[^\[]*?\]))
```

#### Answer 3 (score 84)
This should work out ok:  

```perl
\[([^]]+)\]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Regular expression for exact match of a string (score [476033](https://stackoverflow.com/q/5752829) in 2019)

#### Question
I want to match two passwords with regular expression. For example I have two inputs "123456" and "1234567" then the result should be not match (false). And when I have entered "123456" and "123456" then the result should be match (true).  

I couldn't make the expression. How do I do it?  

#### Answer accepted (score 146)
if you have a the input password in a variable and you want to match exactly 123456 then anchors will help you:  

```perl
/^123456$/
```

in perl the test for matching the password would be something like  

```perl
print "MATCH_OK" if ($input_pass=~/^123456$/);
```

EDIT:  

<a href="https://stackoverflow.com/users/50476/bart-kiers">bart kiers</a> is right tho, why don't you use a strcmp() for this? every language has it in its own way  

as a second thought, you may want to consider a safer authentication mechanism :)  

#### Answer 2 (score 132)
<p>In malfaux's answer <strong>'^'</strong> and <strong>'$'</strong> has been used to detect the beginning and the end of the text. 
<br/>These are usually used to detect the beginning and the end of a line. <br/>However this may be the correct way in this case. <br/>But if you wish to match an exact word the more elegant way is to use <strong>'\b'</strong>. In this case following pattern will match the exact phrase'123456'. </p>

<blockquote>
  /\b123456\b/  
</blockquote>

#### Answer 3 (score 26)
```perl
(?<![\w\d])abc(?![\w\d])
```

this makes sure that your match is not preceded by some character, number, or underscore and is not followed immediately by  character or number, or underscore  

so it will match "abc" in "abc", "abc.", "abc ", but not "4abc", nor "abcde"  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Split Java String by New Line (score [474015](https://stackoverflow.com/q/454908) in 2009)

#### Question
<p>I'm trying to split text in a `JTextArea` using a regex to split the String by `\n` However, this does not work and I also tried by `\r\n|\r|n` and many other combination of regexes.
Code:</p>

```perl
public void insertUpdate(DocumentEvent e) {
    String split[], docStr = null;
    Document textAreaDoc = (Document)e.getDocument();

    try {
        docStr = textAreaDoc.getText(textAreaDoc.getStartPosition().getOffset(), textAreaDoc.getEndPosition().getOffset());
    } catch (BadLocationException e1) {
        // TODO Auto-generated catch block
        e1.printStackTrace();
    }

    split = docStr.split("\\n");
}
```

#### Answer accepted (score 687)
This should cover you:  

```perl
String lines[] = string.split("\\r?\\n");
```

There's only really two newlines (UNIX and Windows) that you need to worry about.  

#### Answer 2 (score 126)
If you don’t want empty lines:  

```perl
String.split("[\\r\\n]+")
```

#### Answer 3 (score 106)
<a href="https://docs.oracle.com/javase/10/docs/api/java/lang/String.html#split(java.lang.String)" rel="noreferrer">`String#split​(String regex)`</a> method is using regex (regular expressions). Since Java 8 regex supports `\R` which represents (from <a href="https://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html" rel="noreferrer">documentation of Pattern class</a>):  

<blockquote>
  <p><strong>Linebreak matcher</strong><br>
  \R&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Any Unicode linebreak sequence, is equivalent to
  `\u000D\u000A|[\u000A\u000B\u000C\u000D\u0085\u2028\u2029]`</p>
</blockquote>

So we can use it to match:  

<ul>
<li>`\u000D\000A` -> `\r\n` pair  </li>
<li><a href="http://www.fileformat.info/info/unicode/char/000a/index.htm" rel="noreferrer">\\u000A</a> -> line feed (`\n`)</li>
<li><a href="http://www.fileformat.info/info/unicode/char/000b/index.htm" rel="noreferrer">\\u000B</a> -> line tabulation (DO NOT confuse with <a href="http://www.fileformat.info/info/unicode/char/0009/index.htm" rel="noreferrer">character tabulation `\t` which is `\\u0009`</a>)</li>
<li><a href="http://www.fileformat.info/info/unicode/char/000c/index.htm" rel="noreferrer">\\u000C</a> -> form feed (`\f`)</li>
<li><a href="http://www.fileformat.info/info/unicode/char/000d/index.htm" rel="noreferrer">\\u000D</a> -> carriage return (`\r`)</li>
<li><a href="http://www.fileformat.info/info/unicode/char/0085/index.htm" rel="noreferrer">\\u0085</a> -> next line (NEL)</li>
<li><a href="http://www.fileformat.info/info/unicode/char/2028/index.htm" rel="noreferrer">\\u2028</a> -> line separator</li>
<li><a href="http://www.fileformat.info/info/unicode/char/2029/index.htm" rel="noreferrer">\\u2029</a> -> paragraph separator</li>
</ul>

As you see `\r\n` is placed at start of regex which ensures that regex will try to match this <em>pair</em> first, and only if that match fails it will try to match <em>single character</em> line separators.  

<hr>

So if you want to split on line separator use `split("\\R")`.   

If you <a href="https://stackoverflow.com/questions/14602062/java-string-split-removed-empty-values">don't want to remove from resulting array trailing empty strings `""`</a> use `split(regex, limit)` with negative `limit` parameter like `split("\\R", -1)`.  

If you want to treat one or more continues empty lines as single delimiter use `split("\\R+")`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Removing empty lines in Notepad++ (score [472569](https://stackoverflow.com/q/3866034) in 2014)

#### Question
How can I replace empty lines in Notepad++? I tried a find and replace with the empty lines in the find, and nothing in the replace, but it did not work; it probably needs regex.  

#### Answer accepted (score 367)
You need something like a regular expression.  

<strong>You have to be in `Extended` mode</strong>  

If you want all the lines to end up on a <strong>single line</strong> use `\r\n`. If you want to simply remove <strong>empty</strong> lines, use `\n\r` as @Link originally suggested.  

Replace either expression with nothing.  

#### Answer 2 (score 529)
There is now a built-in way to do this as of version 6.5.2  

`Edit -&gt; Line Operations -&gt; Remove Empty Lines` or `Remove Empty Lines (Containing Blank characters)`  

<a href="https://i.stack.imgur.com/XelUW.png" rel="noreferrer"><img src="https://i.stack.imgur.com/XelUW.png" alt="Screenshot of removing empty lines"></a>  

#### Answer 3 (score 122)
There is a plugin that adds a menu entitled `TextFX`.  This menu, which houses a dizzying array of quick text editing options, gives a person the ability to make quick coding changes.  In this menu, you can find selections such as Drop Quotes, Delete Blank Lines as well as Unwrap and Rewrap Text  

<strong>Do the following:</strong>   

```perl
TextFX > TextFX Edit > Delete Blank Lines
TextFX > TextFX Edit > Delete Surplus Blank Lines
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: Regular Expressions- Match Anything (score [465260](https://stackoverflow.com/q/6711971) in 2018)

#### Question
How do I make an expression to match absolutely anything (including whitespaces)? <br />Example:  

<strong>Regex:</strong>   I bought _____ sheep.  

<strong>Matches:</strong> I bought sheep. I bought a sheep. I bought five sheep.  

I tried using `(.*)`, but that doesn't seem to be working.  

Update: I got it to work, apparently the problem wasn't with the regular expressions, it's just that the (.) characters were being escaped.  

#### Answer 2 (score 252)
Normally the dot matches any character <em>except newlines</em>.   

So if `.*` isn't working, set the "dot matches newlines, too" option (or use `(?s).*`).   

If you're using JavaScript, which doesn't have a "dotall" option, try `[\s\S]*`. This means "match any number of characters that are either whitespace or non-whitespace" - effectively "match any string".  

Another option that only works for JavaScript (and is not recognized by any other regex flavor) is `[^]*` which also matches any string. But `[\s\S]*` seems to be more widely used, perhaps because it's more portable.  

#### Answer 3 (score 155)
`(.*?)` matches anything - I've been using it for years.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: Find and kill a process in one line using bash and regex (score [456080](https://stackoverflow.com/q/3510673) in 2010)

#### Question
I often need to kill a process during programming.  

The way I do it now is:  

```perl
[~]$ ps aux | grep 'python csp_build.py'
user    5124  1.0  0.3 214588 13852 pts/4    Sl+  11:19   0:00 python csp_build.py
user    5373  0.0  0.0   8096   960 pts/6    S+   11:20   0:00 grep python csp_build.py
[~]$ kill 5124
```

How can I extract the process id automatically and kill it in the same line?  

Like this:  

```perl
[~]$ ps aux | grep 'python csp_build.py' | kill <regex that returns the pid>
```

#### Answer accepted (score 1287)
In `bash`, you should be able to do:  

```perl
kill $(ps aux | grep '[p]ython csp_build.py' | awk '{print $2}')
```

Details on its workings are as follows:  

<ul>
<li>The `ps` gives you the list of all the processes.</li>
<li>The `grep` filters that based on your search string, `[p]` is a trick to stop you picking up the actual `grep` process itself.</li>
<li>The `awk` just gives you the second field of each line, which is the PID.</li>
<li>The `$(x)` construct means to execute `x` then take its output and put it on the command line. The output of that `ps` pipeline inside that construct above is the list of process IDs so you end up with a command like `kill 1234 1122 7654`.</li>
</ul>

Here's a transcript showing it in action:  

```perl
pax> sleep 3600 &
[1] 2225
pax> sleep 3600 &
[2] 2226
pax> sleep 3600 &
[3] 2227
pax> sleep 3600 &
[4] 2228
pax> sleep 3600 &
[5] 2229
pax> kill $(ps aux | grep '[s]leep' | awk '{print $2}')
[5]+  Terminated              sleep 3600
[1]   Terminated              sleep 3600
[2]   Terminated              sleep 3600
[3]-  Terminated              sleep 3600
[4]+  Terminated              sleep 3600
```

and you can see it terminating all the sleepers.  

<hr>

Explaining the `grep '[p]ython csp_build.py'` bit in a bit more detail:  

When you do `sleep 3600 &amp;` followed by `ps -ef | grep sleep`, you tend to get <em>two</em> processes with `sleep` in it, the `sleep 3600` and the `grep sleep` (because they both have `sleep` in them, that's not rocket science).  

However, `ps -ef | grep '[s]leep'` won't create a process with `sleep` in it, it instead creates `grep '[s]leep'` and here's the tricky bit: the `grep` doesn't find it because it's looking for the regular expression "any character from the character class `[s]` (which is `s`) followed by `leep`.  

In other words, it's looking for `sleep` but the grep process is `grep '[s]leep'` which doesn't have `sleep` in it.  

When I was shown this (by someone here on SO), I immediately started using it because  

<ul>
<li>it's one less process than adding `| grep -v grep`; and</li>
<li>it's elegant <em>and</em> sneaky, a rare combination :-)</li>
</ul>

#### Answer 2 (score 125)
if you have pkill,   

```perl
pkill -f csp_build.py
```

If you only want to grep against the process name (instead of the full argument list) then leave off `-f`.  

#### Answer 3 (score 82)
<h5>One liner:</h2>

<strong>`ps aux  |  grep -i csp_build  |  awk '{print $2}'  |  xargs sudo kill -9`</strong>  

<ul>
<li>Print out column 2:  `awk '{print $2}'` </li>
<li><strong>`sudo`</strong> is optional</li>
<li>Run `kill -9 5124`, `kill -9 5373` etc (kill -15 is more graceful but slightly slower)</li>
</ul>

<hr>

<h5>Bonus:</h2>

<p>I also have 2 shortcut functions defined in my .bash_profile
(~/.bash_profile is for osx, you have to see what works for your *nix machine).</p>

<ol>
<li><strong>p</strong> <em>keyword</em>

<ul>
<li>lists out all <strong>P</strong>rocesses containing keyword</li>
<li>usage e.g: `p csp_build` , `p python` etc</li>
</ul></li>
</ol>

<em>bash_profile code:</em>  

```perl
# FIND PROCESS
function p(){
        ps aux | grep -i $1 | grep -v grep
}
```

<ol start="2">
<li><strong>ka</strong> <em>keyword</em>

<ul>
<li><strong>K</strong>ills <strong>A</strong>ll processes that have this keyword</li>
<li>usage e.g: `ka csp_build` , `ka python` etc</li>
<li>optional kill level e.g: `ka csp_build 15`, `ka python 9`</li>
</ul></li>
</ol>

<em>bash_profile code:</em>  

```perl
# KILL ALL
function ka(){

    cnt=$( p $1 | wc -l)  # total count of processes found
    klevel=${2:-15}       # kill level, defaults to 15 if argument 2 is empty

    echo -e "\nSearching for '$1' -- Found" $cnt "Running Processes .. "
    p $1

    echo -e '\nTerminating' $cnt 'processes .. '

    ps aux  |  grep -i $1 |  grep -v grep   | awk '{print $2}' | xargs sudo kill -klevel
    echo -e "Done!\n"

    echo "Running search again:"
    p "$1"
    echo -e "\n"
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: Regex: matching up to the first occurrence of a character (score [447616](https://stackoverflow.com/q/2013124) in 2013)

#### Question
I am looking for a pattern that matches everything <strong>until</strong> the first occurrence of a specific character, say a ";" - a <strong>semicolon</strong>.  

I wrote this:  

```perl
/^(.*);/
```

But it actually matches everything (including the semicolon) until the last occurrence of a semicolon.  

#### Answer accepted (score 443)
You need  

```perl
/[^;]*/
```

The `[^;]` is a <em>character class</em>, it matches everything but a semicolon.  

To cite the <a href="http://perldoc.perl.org/perlre.html" rel="noreferrer">`perlre`</a> manpage:  

<blockquote>
  You can specify a character class, by enclosing a list of characters in [] , which will match any character from the list. If the first character after the "[" is "^", the class matches any character not in the list.  
</blockquote>

This should work in most regex dialects.  

#### Answer 2 (score 266)
Would;  

```perl
/^(.*?);/
```

work?  

The `?` is a lazy operator, so the regex grabs as little as possible before matching the `;`.  

#### Answer 3 (score 34)
`/^[^;]*/`  

The [^;] says match anything except a semicolon.  The square brackets are a set matching operator, it's essentially, match any character in this set of characters, the `^` at the start makes it an inverse match, so match anything <em>not</em> in this set.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: Check if string matches pattern (score [446271](https://stackoverflow.com/q/12595051) in 2016)

#### Question
How do I check if a string matches this pattern?  

Uppercase letter, number(s), uppercase letter, number(s)...  

Example, These would match:  

```perl
A1B2
B10L1
C1N200J1
```

These wouldn't ('^' points to problem)  

```perl
a1B2
^
A10B
   ^
AB400
^
```

#### Answer accepted (score 396)
```perl
import re
pattern = re.compile("^([A-Z][0-9]+)+$")
pattern.match(string)
```

Edit: As noted in the comments `match` checks only for matches at the beginning of the string while `re.search()` will match a pattern anywhere in string. (See also: <a href="https://docs.python.org/library/re.html#search-vs-match" rel="noreferrer">https://docs.python.org/library/re.html#search-vs-match</a>)  

#### Answer 2 (score 132)
<strong>One-liner: `re.match(r"pattern", string) # No need to compile`</strong>  

```perl
import re
>>> if re.match(r"hello[0-9]+", 'hello1'):
...     print('Yes')
... 
Yes
```

You can evalute it as `bool` if needed  

```perl
>>> bool(re.match(r"hello[0-9]+", 'hello1'))
True
```

#### Answer 3 (score 32)
Please try the following:  

```perl
import re

name = ["A1B1", "djdd", "B2C4", "C2H2", "jdoi","1A4V"]

# Match names.
for element in name:
     m = re.match("(^[A-Z]\d[A-Z]\d)", element)
     if m:
        print(m.groups())
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: How do I split a string with multiple separators in javascript? (score [442421](https://stackoverflow.com/q/650022) in 2015)

#### Question
How do I split a string with multiple separators in JavaScript?  I'm trying to split on both commas and spaces but, AFAIK, JS's split function only supports one separator.  

#### Answer accepted (score 639)
Pass in a regexp as the parameter:  

```perl
js> "Hello awesome, world!".split(/[\s,]+/)
Hello,awesome,world!
```

<strong>Edited to add:</strong>  

You can get the last element by selecting the length of the array minus 1:  

```perl
>>> bits = "Hello awesome, world!".split(/[\s,]+/)
["Hello", "awesome", "world!"]
>>> bit = bits[bits.length - 1]
"world!"
```

... and if the pattern doesn't match:  

```perl
>>> bits = "Hello awesome, world!".split(/foo/)
["Hello awesome, world!"]
>>> bits[bits.length - 1]
"Hello awesome, world!"
```

#### Answer 2 (score 168)
You can pass a regex into <a href="https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/String/split" rel="noreferrer">Javascript's split operator</a>. For example:  

```perl
"1,2 3".split(/,| /) 
["1", "2", "3"]
```

Or, if you want to allow multiple separators together to act as one only:  

```perl
"1, 2, , 3".split(/(?:,| )+/) 
["1", "2", "3"]
```

(You have to use the non-capturing (?:) parens because otherwise it gets spliced back into the result. Or you can be smart like Aaron and use a character class.)  

(Examples tested in Safari + FF)  

#### Answer 3 (score 48)
Another simple but effective method is to use split + join repeatedly.  

```perl
"a=b,c:d".split('=').join(',').split(':').join(',').split(',')
```

Essentially doing a split followed by a join is like a global replace so this replaces each separator with a comma then once all are replaced it does a final split on comma  

The result of the above expression is:  

```perl
['a', 'b', 'c', 'd']
```

Expanding on this you could also place it in a function:  

```perl
function splitMulti(str, tokens){
        var tempChar = tokens[0]; // We can use the first token as a temporary join character
        for(var i = 1; i < tokens.length; i++){
            str = str.split(tokens[i]).join(tempChar);
        }
        str = str.split(tempChar);
        return str;
}
```

Usage:   

```perl
splitMulti('a=b,c:d', ['=', ',', ':']) // ["a", "b", "c", "d"]
```

If you use this functionality a lot it might even be worth considering wrapping    `String.prototype.split` for convenience (I think my function is fairly safe - the only consideration is the additional overhead of the conditionals (minor) and the fact that it lacks an implementation of the limit argument if an array is passed).  

Be sure to include the `splitMulti` function if using this approach to the below simply  wraps it :). Also worth noting that some people frown on extending built-ins (as many people do it wrong and conflicts can occur) so if in doubt speak to someone more senior before using this or ask on SO :)   

```perl
    var splitOrig = String.prototype.split; // Maintain a reference to inbuilt fn
    String.prototype.split = function (){
        if(arguments[0].length > 0){
            if(Object.prototype.toString.call(arguments[0]) == "[object Array]" ) { // Check if our separator is an array
                return splitMulti(this, arguments[0]);  // Call splitMulti
            }
        }
        return splitOrig.apply(this, arguments); // Call original split maintaining context
    };
```

Usage:  

```perl
var a = "a=b,c:d";
    a.split(['=', ',', ':']); // ["a", "b", "c", "d"]

// Test to check that the built-in split still works (although our wrapper wouldn't work if it didn't as it depends on it :P)
        a.split('='); // ["a", "b,c:d"] 
```

Enjoy!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: How to count string occurrence in string? (score [426426](https://stackoverflow.com/q/4009756) in )

#### Question
How can I count the number of times a particular string occurs in another string. For example, this is what I am trying to do in Javascript:  

```perl
var temp = "This is a string.";
alert(temp.count("is")); //should output '2'
```

#### Answer accepted (score 933)
The `g` in the regular expression (short for <em>global</em>) says to search the whole string rather than just find the first occurrence. This matches `is` twice:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
var temp = "This is a string.";
var count = (temp.match(/is/g) || []).length;
console.log(count);
```
</div>
</div>


And, if there are no matches, it returns `0`:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
var temp = "Hello World!";
var count = (temp.match(/is/g) || []).length;
console.log(count);
```
</div>
</div>


#### Answer 2 (score 224)
```perl
/** Function that count occurrences of a substring in a string;
 * @param {String} string               The string
 * @param {String} subString            The sub string to search for
 * @param {Boolean} [allowOverlapping]  Optional. (Default:false)
 *
 * @author Vitim.us https://gist.github.com/victornpb/7736865
 * @see Unit Test https://jsfiddle.net/Victornpb/5axuh96u/
 * @see http://stackoverflow.com/questions/4009756/how-to-count-string-occurrence-in-string/7924240#7924240
 */
function occurrences(string, subString, allowOverlapping) {

    string += "";
    subString += "";
    if (subString.length <= 0) return (string.length + 1);

    var n = 0,
        pos = 0,
        step = allowOverlapping ? 1 : subString.length;

    while (true) {
        pos = string.indexOf(subString, pos);
        if (pos >= 0) {
            ++n;
            pos += step;
        } else break;
    }
    return n;
}
```

<h5>Usage</h2>

```perl
occurrences("foofoofoo", "bar"); //0

occurrences("foofoofoo", "foo"); //3

occurrences("foofoofoo", "foofoo"); //1
```

<h5>allowOverlapping</h3>

```perl
occurrences("foofoofoo", "foofoo", true); //2
```

Matches:  

```perl
  foofoofoo
1 `----´
2    `----´
```

<h5>Unit Test</h2>

<ul>
<li><a href="https://jsfiddle.net/Victornpb/5axuh96u/" rel="noreferrer">https://jsfiddle.net/Victornpb/5axuh96u/</a></li>
</ul>

<h5>Benchmark</h2>

<blockquote>
  <p>I've made a benchmark test and my function is more then 10 times
  faster then the regexp match function posted by gumbo. In my test
  string is 25 chars length. with 2 occurences of the character 'o'. I
  executed 1 000 000 times in Safari.</p>
  
  <strong>Safari 5.1</strong>  
  
  Benchmark> Total time execution: 5617 ms (regexp)  
  
  Benchmark> Total time execution: 881 ms  (my function 6.4x faster)  
  
  <strong>Firefox 4</strong>  
  
  Benchmark> Total time execution: 8547 ms (Rexexp)  
  
  Benchmark> Total time execution:  634 ms  (my function 13.5x faster)  
  
  <hr>
  
  Edit: changes I've made  
  
  <ul>
  <li><p>cached substring length</p></li>
  <li><p>added type-casting to string.</p></li>
  <li><p>added optional 'allowOverlapping' parameter</p></li>
  <li><p>fixed correct output for "" empty substring case.</p></li>
  </ul>
</blockquote>

Gist

<ul>
<li><a href="https://gist.github.com/victornpb/7736865" rel="noreferrer">https://gist.github.com/victornpb/7736865</a></li>
</ul>

#### Answer 3 (score 99)
```perl
function countInstances(string, word) {
   return string.split(word).length - 1;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: Regular expression to allow spaces between words (score [425290](https://stackoverflow.com/q/15472764) in 2019)

#### Question
I want a regular expression that prevents symbols and only allows letters and numbers. The regex below works great, but it doesn't allow for spaces between words.  

```perl
^[a-zA-Z0-9_]*$
```

For example, when using this regular expression "HelloWorld" is fine, but "Hello World" does not match.  

How can I tweak it to allow spaces?  

#### Answer accepted (score 305)
<h5>tl;dr</h1>

Just add a space in your <a href="http://www.regular-expressions.info/charclass.html" rel="noreferrer">character class</a>.  

```perl
^[a-zA-Z0-9_ ]*$
```

&nbsp;  

<hr>

<h5>Now, if you want to be strict...</h1>

The above isn't exactly correct. Due to the fact that `*` means <em>zero or more</em>, it would match all of the following cases that one would not usually mean to match:  

<ul>
<li>An empty string, "".</li>
<li>A string comprised entirely of spaces, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;".</li>
<li>A string that leads and / or trails with spaces, "&nbsp;&nbsp;&nbsp;Hello World&nbsp;&nbsp;".</li>
<li>A string that contains multiple spaces in between words, "Hello&nbsp;&nbsp;&nbsp;World".</li>
</ul>

Originally I didn't think such details were worth going into, as OP was asking such a basic question that it seemed strictness wasn't a concern. Now that the question's gained some popularity however, I want to say...  

<h5>...use <a href="https://stackoverflow.com/a/15473717/3886459">@stema's answer</a>.</h2>

Which, in my flavor (without using `\w`) translates to:  

```perl
^[a-zA-Z0-9_]+( [a-zA-Z0-9_]+)*$
```

(Please upvote @stema regardless.)  

Some things to note about this (and @stema's) answer:  

<ul>
<li><p>If you want to allow <em>multiple</em> spaces between words (say, if you'd like to allow accidental double-spaces, or if you're working with copy-pasted text from a PDF), then add a `+` after the space:</p>

```perl
^\w+( +\w+)*$
```</li>
<li><p>If you want to allow tabs and newlines (whitespace characters), then replace the space with a `\s+`:</p>

```perl
^\w+(\s+\w+)*$
```

Here I suggest the `+` by default because, for example, Windows linebreaks consist of <em>two</em> whitespace characters in sequence, `\r\n`, so you'll need the `+` to catch both.  </li>
</ul>

<h5>Still not working?</h1>

Check what dialect of regular expressions you're using.<sup>*</sup> In languages like Java you'll have to escape your backslashes, <em>i.e.</em> `\\w` and `\\s`. In older or more basic languages and utilities, like `sed`, `\w` and `\s` aren't defined, so write them out with character classes, <em>e.g.</em> `[a-zA-Z0-9_]` and `[\f\n\p\r\t]`, respectively.  

&nbsp;  

<hr>

<sup><sup>*</sup> I know this question is tagged <a href="/questions/tagged/vb.net" class="post-tag" title="show questions tagged &#39;vb.net&#39;" rel="tag">vb.net</a>, but based on 25,000+ views, I'm guessing it's not only those folks who are coming across this question. Currently it's the first hit on google for the search phrase, <em>regular expression space word</em>.</sup>  

#### Answer 2 (score 105)
One possibility would be to just add the space into you character class, like acheong87 suggested, this depends on how strict you are on your pattern, because this would also allow a string starting with 5 spaces, or strings consisting only of spaces.  

The other possibility is to define a pattern:  

I will use `\w` this is in most regex flavours the same than `[a-zA-Z0-9_]` (in some it is Unicode based)  

```perl
^\w+( \w+)*$
```

This will allow a series of at least one word and the words are divided by spaces.  

`^` Match the start of the string  

`\w+` Match a series of at least one word character  

`( \w+)*` is a group that is repeated 0 or more times. In the group it expects a space followed by a series of at least one word character  

`$` matches the end of the string  

#### Answer 3 (score 21)
This one worked for me   

```perl
([\w ]+)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Validating email addresses using jQuery and regex (score [422825](https://stackoverflow.com/q/2855865) in 2017)

#### Question
I'm not too sure how to do this.  I need to validate email addresses using regex with something like this:  

```perl
[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)
```

Then I need to run this in a jQuery function like this:     

```perl
$j("#fld_emailaddress").live('change',function() { 
var emailaddress = $j("#fld_emailaddress").val();

// validation here? 

if(emailaddress){}

// end validation

$j.ajax({  
        type: "POST",  
         url: "../ff-admin/ff-register/ff-user-check.php",  
        data: "fld_emailaddress="+ emailaddress,  
        success: function(msg)
        { 
            if(msg == 'OK') { 
            $j("#fld_username").attr('disabled',false); 
            $j("#fld_password").attr('disabled',false); 
            $j("#cmd_register_submit").attr('disabled',false); 
            $j("#fld_emailaddress").removeClass('object_error'); // if necessary
            $j("#fld_emailaddress").addClass("object_ok");
            $j('#email_ac').html('&nbsp;<img src="img/cool.png" align="absmiddle"> <font color="Green"> Your email <strong>'+ emailaddress+'</strong> is OK.</font>  ');
            } else {  
            $j("#fld_username").attr('disabled',true); 
            $j("#fld_password").attr('disabled',true); 
            $j("#cmd_register_submit").attr('disabled',true);  
            $j("#fld_emailaddress").removeClass('object_ok'); // if necessary
            $j("#fld_emailaddress").addClass("object_error");
            $j('#email_ac').html(msg);
            }
        }
     });
});
```

Where does the validation go and what is the expression?  

#### Answer accepted (score 489)
<h5>UPDATES</h1>

<ul>
<li><a href="http://so.lucafilosofi.com/jquery-validate-e-mail-address-regex/" rel="noreferrer">http://so.lucafilosofi.com/jquery-validate-e-mail-address-regex/</a></li>
<li>using new regex </li>
<li>added support for <a href="http://en.wikipedia.org/wiki/Email_address#Address_tags" rel="noreferrer">Address tags</a> (+ sign)</li>
</ul>

<hr>

```perl
function isValidEmailAddress(emailAddress) {
    var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
    return pattern.test(emailAddress);
}
```

<hr>

```perl
if( !isValidEmailAddress( emailaddress ) ) { /* do stuff here */ }
```

<ul>
<li><strong>NOTE:</strong> <a href="https://stackoverflow.com/questions/201323/what-is-the-best-regular-expression-for-validating-email-addresses">keep in mind that no 100% regex</a> email check exists!</li>
</ul>

#### Answer 2 (score 28)
This is my solution:  

```perl
function isValidEmailAddress(emailAddress) {
    var pattern = new RegExp(/^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i);
    // alert( pattern.test(emailAddress) );
    return pattern.test(emailAddress);
};
```

<strike>Found that RegExp over here: <a href="http://mdskinner.com/code/email-regex-and-validation-jquery" rel="noreferrer">http://mdskinner.com/code/email-regex-and-validation-jquery</a></strike>  

#### Answer 3 (score 14)
```perl
$(document).ready(function() {

$('#emailid').focusout(function(){

                $('#emailid').filter(function(){
                   var emil=$('#emailid').val();
              var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
            if( !emailReg.test( emil ) ) {
                alert('Please enter valid email');
                } else {
                alert('Thank you for your valid email');
                }
                })
            });
});
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: Remove new lines from string and replace with one empty space (score [421794](https://stackoverflow.com/q/3760816) in 2019)

#### Question
```perl
$string = "
put returns between paragraphs

for linebreak add 2 spaces at end

";
```

Want to remove all new lines from string.  

I've this regex, it can catch all of them, the problem is I don't know with which function should I use it.  

```perl
/\r\n|\r|\n/
```

`$string` should become:  

```perl
$string = "put returns between paragraphs for linebreak add 2 spaces at end ";
```

#### Answer accepted (score 540)
You have to be cautious of double line breaks, which would cause double spaces. Use this really efficient regular expression:  

```perl
$string = trim(preg_replace('/\s\s+/', ' ', $string));
```

Multiple spaces and newlines are replaced with a single space.  

<strong>Edit:</strong> As others have pointed out, this solution has issues matching single newlines in between words. This is not present in the example, but one can easily see how that situation could occur. An alternative is to do the following:  

```perl
$string = trim(preg_replace('/\s+/', ' ', $string));
```

#### Answer 2 (score 172)
A few comments on the accepted answer:  

The `+` means "1 or more". I don't think you need to repeat `\s`. I think you can simply write `'/\s+/'`.  

Also, if you want to remove whitespace first and last in the string, add `trim`.  

With these modifications, the code would be:  

```perl
$string = preg_replace('/\s+/', ' ', trim($string));
```

#### Answer 3 (score 72)
Just use <a href="http://php.net/manual/en/function.preg-replace.php" rel="noreferrer">`preg_replace()`</a>  

```perl
$string = preg_replace('~[\r\n]+~', '', $string);
```

You could get away with <a href="http://php.net/manual/en/function.str-replace.php" rel="noreferrer">`str_replace()`</a> on this one, although the code doesn't look as clean:  

```perl
$string = str_replace(array("\n", "\r"), '', $string);
```

See it live on <a href="http://ideone.com/ugNOZ" rel="noreferrer">ideone</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: How to do a regular expression replace in MySQL? (score [412329](https://stackoverflow.com/q/986826) in 2017)

#### Question
I have a table with ~500k rows; varchar(255) UTF8 column `filename` contains a file name;  

I'm trying to strip out various strange characters out of the filename - thought I'd use a character class: `[^a-zA-Z0-9()_ .\-]`  

Now, <strong>is there a function in MySQL that lets you replace through a regular expression</strong>? I'm looking for a similar functionality to REPLACE() function - simplified example follows:  

```perl
SELECT REPLACE('stackowerflow', 'ower', 'over');

Output: "stackoverflow"

/* does something like this exist? */
SELECT X_REG_REPLACE('Stackoverflow','/[A-Zf]/','-'); 

Output: "-tackover-low"
```

I know about <a href="https://stackoverflow.com/a/6943142/19746">REGEXP/RLIKE</a>, but those only check <em>if</em> there is a match, not <em>what</em> the match is.  

(I <em>could</em> do a "`SELECT pkey_id,filename FROM foo WHERE filename RLIKE '[^a-zA-Z0-9()_ .\-]'`" from a PHP script, do a `preg_replace` and then "`UPDATE foo ... WHERE pkey_id=...`", but that looks like a last-resort slow &amp; ugly hack)  

#### Answer accepted (score 45)
MySQL 8.0+ you could use natively `REGEXP_REPLACE`.  

<a href="https://dev.mysql.com/doc/refman/8.0/en/regexp.html#function_regexp-replace" rel="noreferrer">12.5.2 Regular Expressions</a>:  

<blockquote>
  <strong>REGEXP_REPLACE(expr, pat, repl[, pos[, occurrence[, match_type]]])</strong>  
  
  Replaces occurrences in the string expr that match the regular expression specified by the pattern pat with the replacement string repl, and returns the resulting string. If expr, pat, or repl is NULL, the return value is NULL.   
</blockquote>

and <a href="https://dev.mysql.com/doc/refman/8.0/en/mysql-nutshell.html" rel="noreferrer">Regular expression support</a>:  

<blockquote>
  Previously, MySQL used the Henry Spencer regular expression library to support regular expression operators (REGEXP, RLIKE).   
  
  Regular expression support has been reimplemented using International Components for Unicode (ICU), which provides full Unicode support and is multibyte safe. The REGEXP_LIKE() function performs regular expression matching in the manner of the REGEXP and RLIKE operators, which now are synonyms for that function. <strong>In addition, the REGEXP_INSTR(), REGEXP_REPLACE(), and REGEXP_SUBSTR() functions are available to find match positions and perform substring substitution and extraction, respectively.</strong>  
</blockquote>

```perl
SELECT REGEXP_REPLACE('Stackoverflow','[A-Zf]','-',1,0,'c'); 
-- Output:
-tackover-low
```

<strong><a href="https://dbfiddle.uk/?rdbms=mysql_8.0&amp;fiddle=b2436ab953a61ed401284357140777d4" rel="noreferrer">DBFiddle Demo</a></strong>  

#### Answer 2 (score 140)
No.  

But if you have access to your server, you could use a user defined function (UDF)  like <a href="https://github.com/hholzgra/mysql-udf-regexp" rel="noreferrer">mysql-udf-regexp</a>.  

<strong>EDIT:</strong> MySQL 8.0+ you could use natively REGEXP_REPLACE. More in answer above  

#### Answer 3 (score 122)
Use MariaDB instead. It has a function  

```perl
REGEXP_REPLACE(col, regexp, replace)
```

See <a href="https://mariadb.com/kb/en/mariadb/documentation/functions-and-operators/string-functions/regular-expressions-functions/pcre-regular-expressions/">MariaDB docs</a> and <a href="https://mariadb.com/kb/en/mariadb/documentation/functions-and-operators/string-functions/regular-expressions-functions/pcre-regular-expressions/">PCRE Regular expression enhancements</a>  

Note that you can use regexp grouping as well (I found that very useful):  

```perl
SELECT REGEXP_REPLACE("stackoverflow", "(stack)(over)(flow)", '\\2 - \\1 - \\3')
```

returns  

```perl
over - stack - flow
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: Remove all special characters, punctuation and spaces from string (score [410777](https://stackoverflow.com/q/5843518) in 2015)

#### Question
I need to remove all special characters, punctuation and spaces from a string so that I only have letters and numbers.  

#### Answer accepted (score 301)
This can be done without regex:  

```perl
>>> string = "Special $#! characters   spaces 888323"
>>> ''.join(e for e in string if e.isalnum())
'Specialcharactersspaces888323'
```

You can use <a href="https://docs.python.org/library/stdtypes.html#str.isalnum" rel="noreferrer">`str.isalnum`</a>:  

<blockquote>
```perl
S.isalnum() -> bool

Return True if all characters in S are alphanumeric
and there is at least one character in S, False otherwise.
```
</blockquote>

If you insist on using regex, other solutions will do fine. However note that if it can be done without using a regular expression, that's the best way to go about it.  

#### Answer 2 (score 183)
Here is a regex to match a string of characters that are not a letters or numbers:  

```perl
[^A-Za-z0-9]+
```

Here is the Python command to do a regex substitution:  

```perl
re.sub('[^A-Za-z0-9]+', '', mystring)
```

#### Answer 3 (score 39)
Shorter way  :  

```perl
import re
cleanString = re.sub('\W+','', string )
```

If you want spaces between words and numbers substitute '' with ' '  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: How to print matched regex pattern using awk? (score [406650](https://stackoverflow.com/q/5536018) in 2018)

#### Question
Using `awk`, I need to find a word in a file that matches a regex pattern.   

I <em>only</em> want to print the word matched with the pattern.  

So if in the line, I have:  

```perl
xxx yyy zzz
```

And pattern:  

```perl
/yyy/
```

I want to only get:  

```perl
yyy
```

<hr>

<p>EDIT:
thanks to <strong>kurumi</strong> i managed to write something like this:</p>

```perl
awk '{
        for(i=1; i<=NF; i++) {
                tmp=match($i, /[0-9]..?.?[^A-Za-z0-9]/)
                if(tmp) {
                        print $i
                }
        }
}' $1
```

and this is what i needed :) thanks a lot!  

#### Answer accepted (score 133)
This is the very basic  

```perl
awk '/pattern/{ print $0 }' file
```

ask `awk` to search for `pattern` using `//`, then print out the line, which by default is called a record, denoted by $0. At least read up the <a href="http://www.gnu.org/software/gawk/manual">documentation</a>.  

If you only want to get print out the matched word.   

```perl
awk '{for(i=1;i<=NF;i++){ if($i=="yyy"){print $i} } }' file
```

#### Answer 2 (score 102)
It sounds like you are trying to emulate GNU's `grep -o` behaviour. This will do that providing you only want the first match on each line:  

```perl
awk 'match($0, /regex/) {
    print substr($0, RSTART, RLENGTH)
}
' file
```

Here's an example:  

```perl
% awk 'match($0, /a.t/) {
    print substr($0, RSTART, RLENGTH)
}
' /usr/share/dict/words | head
act
act
act
act
aft
ant
apt
art
art
art
```

Read about <a href="https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#index-match_0028_0029-function" rel="noreferrer">`match`</a>, <a href="https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html#index-substr_0028_0029-function" rel="noreferrer">`substr`</a>, <a href="https://www.gnu.org/software/gawk/manual/html_node/Auto_002dset.html#index-RSTART-variable" rel="noreferrer">`RSTART`</a> and <a href="https://www.gnu.org/software/gawk/manual/html_node/Auto_002dset.html#index-RLENGTH-variable" rel="noreferrer">`RLENGTH`</a> in the `awk` manual.  

After that you may wish to extend this to deal with multiple matches on the same line. I can't do <em>all</em> your homework for you :-)  

#### Answer 3 (score 30)
<strong><em>gawk</em></strong> can get the matching part of every line using this as action:  

```perl
{ if (match($0,/your regexp/,m)) print m[0] }
```

<blockquote>
  <p>match(string, regexp [, array])
  If array is present, it is cleared,
  and then the zeroth element of array is set to the entire portion of
  string matched by regexp. If regexp contains parentheses, the
  integer-indexed elements of array are set to contain the portion of
  string matching the corresponding parenthesized subexpression.
  <a href="http://www.gnu.org/software/gawk/manual/gawk.html#String-Functions" rel="noreferrer">http://www.gnu.org/software/gawk/manual/gawk.html#String-Functions</a></p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: How to remove special characters from a string? (score [406020](https://stackoverflow.com/q/7552253) in 2016)

#### Question
I want to remove special characters like:  

```perl
- + ^ . : ,
```

from an String using Java.  

#### Answer accepted (score 236)
That depends on what you define as special characters, but try `replaceAll(...)`:  

```perl
String result = yourString.replaceAll("[-+.^:,]","");
```

Note that the `^` character must not be the first one in the list, since you'd then either have to escape it or it would mean "any but these characters".  

Another note: the `-` character needs to be the first or last one on the list, otherwise you'd have to escape it or it would define a range ( e.g. `:-,` would mean "all characters in the range `:` to `,`).  

So, in order to keep consistency and not depend on character positioning, you might want to escape all those characters that have a special meaning in regular expressions (the following list is not complete, so be aware of other characters like `(`, `{`, `$`  etc.):  

```perl
String result = yourString.replaceAll("[\\-\\+\\.\\^:,]","");
```

<p><br>
If you want to get rid of all punctuation and symbols, try this regex: `\p{P}\p{S}` (keep in mind that in Java strings you'd have to escape back slashes: `"\\p{P}\\p{S}"`).</p>

A third way could be something like this, if you can exactly define what should be left in your string:  

```perl
String  result = yourString.replaceAll("[^\\w\\s]","");
```

This means: replace everything that is not a word character (a-z in any case, 0-9 or _) or whitespace.  

Edit: please note that there are a couple of other patterns that might prove helpful. However, I can't explain them all, so have a look at the reference section of <a href="http://www.regular-expressions.info/refunicode.html">regular-expressions.info</a>.  

Here's less restrictive alternative to the "define allowed characters" approach, as suggested by Ray:  

```perl
String  result = yourString.replaceAll("[^\\p{L}\\p{Z}]","");
```

The regex matches everything that is not a letter in any language and not a separator (whitespace, linebreak etc.). Note that you can't use `[\P{L}\P{Z}]` (upper case P means not having that property), since that would mean "everything that is not a letter or not whitespace", which almost matches everything, since letters are not whitespace and vice versa.  

<em>Additional information on Unicode</em>  

Some unicode characters seem to cause problems due to different possible ways to encode them (as a single code point or a combination of code points). Please refer to <a href="http://www.regular-expressions.info/refunicode.html">regular-expressions.info</a> for more information.  

#### Answer 2 (score 16)
<p>As described here
<a href="http://developer.android.com/reference/java/util/regex/Pattern.html">http://developer.android.com/reference/java/util/regex/Pattern.html</a></p>

<blockquote>
  Patterns are compiled regular expressions. In many cases, convenience methods such as `String.matches`, `String.replaceAll` and `String.split` will be preferable, but if you need to do a lot of work with the same regular expression, it may be more efficient to compile it once and reuse it. The Pattern class and its companion, Matcher, also offer more functionality than the small amount exposed by String.  
</blockquote>

```perl
public class RegularExpressionTest {

public static void main(String[] args) {
    System.out.println("String is = "+getOnlyStrings("!&(*^*(^(+one(&(^()(*)(*&^%$#@!#$%^&*()("));
    System.out.println("Number is = "+getOnlyDigits("&(*^*(^(+91-&*9hi-639-0097(&(^("));
}

 public static String getOnlyDigits(String s) {
    Pattern pattern = Pattern.compile("[^0-9]");
    Matcher matcher = pattern.matcher(s);
    String number = matcher.replaceAll("");
    return number;
 }
 public static String getOnlyStrings(String s) {
    Pattern pattern = Pattern.compile("[^a-z A-Z]");
    Matcher matcher = pattern.matcher(s);
    String number = matcher.replaceAll("");
    return number;
 }
}
```

Result  

```perl
String is = one
Number is = 9196390097
```

#### Answer 3 (score 16)
<p>As described here
<a href="http://developer.android.com/reference/java/util/regex/Pattern.html">http://developer.android.com/reference/java/util/regex/Pattern.html</a></p>

<blockquote>
  Patterns are compiled regular expressions. In many cases, convenience methods such as `String.matches`, `String.replaceAll` and `String.split` will be preferable, but if you need to do a lot of work with the same regular expression, it may be more efficient to compile it once and reuse it. The Pattern class and its companion, Matcher, also offer more functionality than the small amount exposed by String.  
</blockquote>

```perl
public class RegularExpressionTest {

public static void main(String[] args) {
    System.out.println("String is = "+getOnlyStrings("!&(*^*(^(+one(&(^()(*)(*&^%$#@!#$%^&*()("));
    System.out.println("Number is = "+getOnlyDigits("&(*^*(^(+91-&*9hi-639-0097(&(^("));
}

 public static String getOnlyDigits(String s) {
    Pattern pattern = Pattern.compile("[^0-9]");
    Matcher matcher = pattern.matcher(s);
    String number = matcher.replaceAll("");
    return number;
 }
 public static String getOnlyStrings(String s) {
    Pattern pattern = Pattern.compile("[^a-z A-Z]");
    Matcher matcher = pattern.matcher(s);
    String number = matcher.replaceAll("");
    return number;
 }
}
```

Result  

```perl
String is = one
Number is = 9196390097
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Regex to test if string begins with http:// or https:// (score [404032](https://stackoverflow.com/q/4643142) in 2011)

#### Question
I'm trying to set a regexp which will check the start of a string, and if it contains either `http://` or `https://` it should match it.  

How can I do that? I'm trying the following which isn't working:  

```perl
^[(http)(https)]://
```

#### Answer accepted (score 325)
Your use of `[]` is incorrect -- note that `[]` denotes a <em>character class</em> and will therefore only ever match one character.  The expression `[(http)(https)]` translates to "match a `(`, an `h`, a `t`, a `t`, a `p`, a `)`, or an `s`."  (Duplicate characters are ignored.)  

Try this:  

```perl
^https?://
```

If you really want to use alternation, use this syntax instead:  

```perl
^(http|https)://
```

#### Answer 2 (score 37)
Case insensitive:  

```perl
var re = new RegExp("^(http|https)://", "i");
var str = "My String";
var match = re.test(str);
```

#### Answer 3 (score 25)
```perl
^https?://
```

You might have to escape the forward slashes though, depending on context.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: Regex Email validation (score [401797](https://stackoverflow.com/q/5342375) in 2016)

#### Question
I use this  

```perl
@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"
```

regexp to validate the email  

<p>`([\w\.\-]+)` - this is for the first-level domain (many letters and numbers, also point and hyphen)<br><br>
`([\w\-]+)` - this is for second-level domain<br><br>
`((\.(\w){2,3})+)` - and this is for other level domains(from 3 to infinity) which includes a point and 2 or 3 literals<br></p>

what's wrong with this regex?  

EDIT:it doesn't match the "something@someth.ing" email  

#### Answer accepted (score 343)
TLD's like <a href="http://en.wikipedia.org/wiki/.museum" rel="noreferrer">.museum</a> aren't matched this way, and there are a few other long TLD's. Also, you can validate email addresses using the <a href="http://msdn.microsoft.com/en-us/library/system.net.mail.mailaddress.aspx" rel="noreferrer">MailAddress class</a> as Microsoft explains <a href="http://msdn.microsoft.com/en-us/library/01escwtf.aspx" rel="noreferrer">here</a> in a note:  

<blockquote>
  <p>Instead of using a regular expression to validate an email address,
  you can use the System.Net.Mail.MailAddress class. To determine
  whether an email address is valid, pass the email address to the
  MailAddress.MailAddress(String) class constructor.</p>
</blockquote>

```perl
public bool IsValid(string emailaddress)
{
    try
    {
        MailAddress m = new MailAddress(emailaddress);

        return true;
    }
    catch (FormatException)
    {
        return false;
    }
}
```

This saves you a lot af headaches because you don't have to write (or try to understand someone else's) regex.  

#### Answer 2 (score 91)
<p>I think `@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"` should work.<br>
You need to write it like</p>

```perl
string email = txtemail.Text;
Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
Match match = regex.Match(email);
if (match.Success)
    Response.Write(email + " is correct");
else
    Response.Write(email + " is incorrect");
```

Be warned that this will fail if:  

<ol>
<li><p>There is a subdomain after the `@` symbol.</p></li>
<li><p>You use a TLD with a length greater than 3, such as `.info`</p></li>
</ol>

#### Answer 3 (score 65)
I have an expression for checking email addresses that I use.  

Since none of the above were as short or as accurate as mine, I thought I would post it here.  

```perl
@"^[\w!#$%&'*+\-/=?\^_`{|}~]+(\.[\w!#$%&'*+\-/=?\^_`{|}~]+)*"
+ "@"
+ @"((([\-\w]+\.)+[a-zA-Z]{2,4})|(([0-9]{1,3}\.){3}[0-9]{1,3}))$";
```

For more info go read about it here: <a href="https://www.rhyous.com/2010/06/15/csharp-email-regular-expression/" rel="noreferrer">C# – Email Regular Expression</a>  

Also, this checks for RFC validity based on email syntax, not for whether the email really exists. The only way to test that an email really exists is to send and email and have the user verify they received the email by clicking a link or entering a token.  

Then there are throw-away domains, such as Mailinator.com, and such. This doesn't do anything to verify whether an email is from a throwaway domain or not.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: jQuery selector regular expressions (score [401188](https://stackoverflow.com/q/190253) in 2016)

#### Question
I am after documentation on using wildcard or regular expressions (not sure on the exact terminology) with a jQuery selector.  

I have looked for this myself but have been unable to find information on the syntax and how to use it. Does anyone know where the documentation for the syntax is?  

EDIT: The attribute filters allow you to select based on patterns of an attribute value.  

#### Answer accepted (score 328)
James Padolsey created a <a href="http://james.padolsey.com/javascript/regex-selector-for-jquery/" rel="noreferrer">wonderful filter</a> that allows regex to be used for selection.  

Say you have the following `div`:  

```perl
<div class="asdf">
```

Padolsey's `:regex` filter can select it like so:  

```perl
$("div:regex(class, .*sd.*)")
```

Also, check the <a href="http://docs.jquery.com/Selectors" rel="noreferrer">official documentation on selectors</a>.  

#### Answer 2 (score 712)
You can use the <a href="http://docs.jquery.com/Traversing/filter#expr" rel="noreferrer">`filter`</a> function to apply more complicated regex matching.  

Here's an example which would just match the first three divs:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
$('div')
  .filter(function() {
    return this.id.match(/abc+d/);
  })
  .html("Matched!");
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"&gt;&lt;/script&gt;

&lt;div id="abcd"&gt;Not matched&lt;/div&gt;
&lt;div id="abccd"&gt;Not matched&lt;/div&gt;
&lt;div id="abcccd"&gt;Not matched&lt;/div&gt;
&lt;div id="abd"&gt;Not matched&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 3 (score 263)
These can be helpful.  

If you're finding by <strong>Contains</strong> then it'll be like this  

```perl
    $("input[id*='DiscountType']").each(function (i, el) {
         //It'll be an array of elements
     });
```

If you're finding by <strong>Starts With</strong> then it'll be like this  

```perl
    $("input[id^='DiscountType']").each(function (i, el) {
         //It'll be an array of elements
     });
```

If you're finding by <strong>Ends With</strong> then it'll be like this  

```perl
     $("input[id$='DiscountType']").each(function (i, el) {
         //It'll be an array of elements
     });
```

If you want to select elements which <strong>id is not a given string</strong>  

```perl
    $("input[id!='DiscountType']").each(function (i, el) {
         //It'll be an array of elements
     });
```

If you want to select elements which <strong>name contains a given word, delimited by spaces</strong>  

```perl
     $("input[name~='DiscountType']").each(function (i, el) {
         //It'll be an array of elements
     });
```

If you want to select elements which <strong>id is equal to a given string or starting with that string followed by a hyphen</strong>  

```perl
     $("input[id|='DiscountType']").each(function (i, el) {
         //It'll be an array of elements
     });
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: Remove all special characters with RegExp (score [395465](https://stackoverflow.com/q/4374822) in 2018)

#### Question
I would like a RegExp that will remove all special characters from a string. I am trying something like this but it doesn’t work in IE7, though it works in Firefox.  

```perl
var specialChars = "!@#$^&%*()+=-[]\/{}|:<>?,.";

for (var i = 0; i < specialChars.length; i++) {
  stringToReplace = stringToReplace.replace(new RegExp("\\" + specialChars[i], "gi"), "");
}
```

A detailed description of the RegExp would be helpful as well.  

#### Answer accepted (score 569)
```perl
var desired = stringToReplace.replace(/[^\w\s]/gi, '')
```

As was mentioned in the comments it's easier to do this as a whitelist - replace the characters which <em>aren't</em> in your safelist.   

The caret (`^`) character is the negation of the set `[...]`, `gi` say global and case-insensitive (the latter is a bit redundant but I wanted to mention it) and the safelist in this example is digits, word characters, underscores (`\w`) and whitespace (`\s`).  

#### Answer 2 (score 91)
Note that if you still want to exclude a set, including things like slashes and special characters you can do the following:  

```perl
var outString = sourceString.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, '');
```

take special note that in order to also include the "minus" character, you need to escape it with a backslash like the latter group.  if you don't it will also select 0-9 which is probably undesired.  

#### Answer 3 (score 19)
<h5><strong>Plain Javascript regex does not handle Unicode letters</strong>.</h1>

Do not use `[^\w\s]`, this will remove letters with accents (like àèéìòù), not to mention to Cyrillic or Chinese, letters coming from such languages will be completed removed.   

You really don't want remove these letters together with all the special characters. You have two chances:   

<ul>
<li>Add in your regex all the special characters you don't want remove, <br> for example: `[^èéòàùì\w\s]`. </li>
<li>Have a look at <a href="http://xregexp.com/" rel="noreferrer">xregexp.com</a>. XRegExp adds base support for Unicode matching via the `\p{...}` syntax.</li>
</ul>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
var str = "Їжак::: résd,$%& adùf"
var search = XRegExp('([^?<first>\\pL ]+)');
var res = XRegExp.replace(str, search, '',"all");

console.log(res); // returns "Їжак::: resd,adf"
console.log(str.replace(/[^\w\s]/gi, '') ); // returns " rsd adf"
console.log(str.replace(/[^\wèéòàùì\s]/gi, '') ); // returns " résd adùf"
```
<pre class="snippet-code-html lang-html prettyprint-override">`&lt;script src="https://cdnjs.cloudflare.com/ajax/libs/xregexp/3.1.1/xregexp-all.js"&gt;&lt;/script&gt;`</pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 65: Regular Expression to find a string included between two characters while EXCLUDING the delimiters (score [395344](https://stackoverflow.com/q/1454913) in 2018)

#### Question
I need to extract from a string a set of characters which are included between two delimiters, without returning the delimiters themselves.  

A simple example should be helpful:  

<strong>Target</strong>: extract the substring between square brackets, without returning the brackets themselves.  

<strong>Base string</strong>: `This is a test string [more or less]`  

If I use the following reg. ex.  

<pre>\[.*?\]</pre>

The match is `[more or less]`. I need to get only `more or less` (without the brackets).    

Is it possible to do it?  

#### Answer accepted (score 389)
Easy done:  

```perl
(?<=\[)(.*?)(?=\])
```

Technically that's using lookaheads and lookbehinds. See <a href="http://www.regular-expressions.info/lookaround.html" rel="noreferrer">Lookahead and Lookbehind Zero-Width Assertions</a>. The pattern consists of:  

<ul>
<li>is preceded by a [ that is not captured (lookbehind);</li>
<li>a non-greedy captured group. It's non-greedy to stop at the first ]; and</li>
<li>is followed by a ] that is not captured (lookahead).</li>
</ul>

Alternatively you can just capture what's between the square brackets:  

```perl
\[(.*?)\]
```

and return the first captured group instead of the entire match.  

#### Answer 2 (score 47)
If you are using <strong>JavaScript</strong>, the <a href="https://stackoverflow.com/a/1454936/1476885">first solution</a> provided by cletus, `(?&lt;=\[)(.*?)(?=\])`, will not work because JavaScript doesn't support the lookbehind operator.  

However, the second solution works well, but you need to get the second matched element.  

Example:  

```perl
var regex = /\[(.*?)\]/;
var strToMatch = "This is a test string [more or less]";
var matched = regex.exec(strToMatch);
```

It will return:  

```perl
["[more or less]", "more or less"]
```

So, what you need is the second value. Use:  

```perl
var matched = regex.exec(strToMatch)[1];
```

To return:  

```perl
"more or less"
```

#### Answer 3 (score 18)
You just need to 'capture' the bit between the brackets.  

```perl
\[(.*?)\]
```

To capture you put it inside parentheses.  You do not say which language this is using.  In Perl for example, you would access this using the $1 variable.  

```perl
my $string ='This is the match [more or less]';
$string =~ /\[(.*?)\]/;
print "match:$1\n";
```

Other languages will have different mechanisms. C#, for example, uses the <a href="http://msdn.microsoft.com/en-us/library/system.text.regularexpressions.regex.match%28VS.71%29.aspx" rel="noreferrer">Match collection</a> class, I believe.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: Java; String replace (using regular expressions)? (score [394664](https://stackoverflow.com/q/632204) in 2012)

#### Question
As part of a project for school, I need to replace a string from the form:  

```perl
5 * x^3 - 6 * x^1 + 1
```

to something like:  

```perl
5x<sup>3</sup> - 6x<sup>1</sup> + 1
```

I believe this can be done with regular expressions, but I don't know how to do it yet.  

Can you lend me a hand?   

P.S. The actual assignment is to implement a Polynomial Processing Java application, and I'm using this to pass polynomial.toString() from the model to the view, and I want do display it using html tags in a pretty way.  

#### Answer 2 (score 157)
```perl
str.replaceAll("\\^([0-9]+)", "<sup>$1</sup>");
```

#### Answer 3 (score 33)
```perl
private String removeScript(String content) {
    Pattern p = Pattern.compile("<script[^>]*>(.*?)</script>",
            Pattern.DOTALL | Pattern.CASE_INSENSITIVE);
    return p.matcher(content).replaceAll("");
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: Java string split with "." (dot) (score [387315](https://stackoverflow.com/q/14833008) in 2019)

#### Question
Why does the second line of this code throw `ArrayIndexOutOfBoundsException`?  

```perl
String filename = "D:/some folder/001.docx";
String extensionRemoved = filename.split(".")[0];
```

While this works:  

```perl
String driveLetter = filename.split("/")[0];
```

I use Java 7.  

#### Answer 2 (score 678)
You need to escape the dot if you want to split on a <em>literal</em> dot:  

```perl
String extensionRemoved = filename.split("\\.")[0];
```

<p>Otherwise you are splitting on the regex `.`, which means "any character".<br>
Note the double backslash needed to create a single backslash in the regex.</p>

<hr>

You're getting an `ArrayIndexOutOfBoundsException` because your input string is just a dot, ie `"."`, which is an edge case that produces an empty array when split on dot; <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#split-java.lang.String-">`split(regex)`</a> removes all trailing blanks from the result, but since splitting a dot on a dot leaves only two blanks, after trailing blanks are removed you're left with an empty array.  

To avoid getting an `ArrayIndexOutOfBoundsException` for this edge case, use the overloaded version of <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#split-java.lang.String-int-">`split(regex, limit)`</a>, which has a second parameter that is the size limit for the resulting array. When `limit` is <em>negative</em>, the behaviour of removing trailing blanks from the resulting array is disabled:  

```perl
".".split("\\.", -1) // returns an array of two blanks, ie ["", ""]
```

ie, when `filename` is just a dot `"."`, calling `filename.split("\\.", -1)[0]` will return a blank, but calling `filename.split("\\.")[0]` will throw an `ArrayIndexOutOfBoundsException`.  

#### Answer 3 (score 93)
"." is a special character in java regex engine, so you have to use "\\." to escape this character:  

```perl
final String extensionRemoved = filename.split("\\.")[0];
```

I hope this helps  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Regular expression to limit number of characters to 10 (score [384603](https://stackoverflow.com/q/1649435) in 2013)

#### Question
I am trying to write a <a href="http://en.wikipedia.org/wiki/Regular_expression" rel="noreferrer">regular expression</a> that will only allow lowercase letters and up to 10 characters. What I have so far looks like this:  

```perl
pattern: /^[a-z]{0,10}+$/ 
```

This does not work or compile. I had a working one that would just allow lowercase letters which was this:  

```perl
pattern: /^[a-z]+$/ 
```

But I need to limit the number of characters to 10.  

#### Answer 2 (score 326)
You can use curly braces to control the number of occurrences. For example, this means 0 to 10:  

```perl
/^[a-z]{0,10}$/
```

The options are:  

<ul>
<li>{3} Exactly 3 occurrences;</li>
<li>{6,} At least 6 occurrences;</li>
<li>{2,5} 2 to 5 occurrences.</li>
</ul>

See the <a href="http://www.regular-expressions.info/reference.html" rel="noreferrer">regular expression reference</a>.  

Your expression had a + after the closing curly brace, hence the error.  

#### Answer 3 (score 10)
`/^[a-z]{0,10}$/` should work. `/^[a-z]{1,10}$/` if you want to match at least one character, like `/^[a-z]+$/` does.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: Regex for string contains? (score [381502](https://stackoverflow.com/q/4999064) in 2016)

#### Question
What is the regex for simply checking if a string contains a certain word (e.g. 'Test')? I've done some googling but can't get a straight example of such a regex. This is for a build script but has no bearing to any particular programming language.  

#### Answer accepted (score 70)
Assuming regular PCRE-style regex flavors:  

If you want to check for it as a <em>single, full word</em>, it's `\bTest\b`, with appropriate flags for case insensitivity if desired and delimiters for your programming language. `\b` represents a "word boundary", that is, a point between characters where a word can be considered to start or end. For example, since spaces are used to separate words, there will be a word boundary on either side of a space.  

If you want to check for it as <em>part of the word</em>, it's just `Test`, again with appropriate flags for case insensitivity. Note that usually, dedicated "substring" methods tend to be faster in this case, because it removes the overhead of parsing the regex.  

#### Answer 2 (score 91)
Just don't anchor your pattern:  

```perl
/Test/
```

The above regex will check for the literal string "Test" being found somewhere within it.  

#### Answer 3 (score 1)
I have hashed together different elements to get the validation we needed for student emails. I hope this is going to work I haven't tested fully.  

```perl
^[a-zA-Z0-9._%+-]+@\{ac|org|stu|student|stud|studmail|edu|uni}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: Regex to replace multiple spaces with a single space (score [379298](https://stackoverflow.com/q/1981349) in 2016)

#### Question
Given a string like:   

<pre>"The dog      has a long   tail, and it     is RED!"</pre>

What kind of jQuery or JavaScript magic can be used to keep spaces to only one space max?  

Goal:   

<pre>"The dog has a long tail, and it is RED!"</pre>

#### Answer accepted (score 817)
Given that you also want to cover tabs, newlines, etc, just replace `\s\s+` with `' '`:   

```perl
string = string.replace(/\s\s+/g, ' ');
```

If you really want to cover only spaces (and thus not tabs, newlines, etc), do so:  

```perl
string = string.replace(/  +/g, ' ');
```

#### Answer 2 (score 152)
Since you seem to be interested in performance, I profiled these with firebug.  Here are the results I got:  

```perl
str.replace( /  +/g, ' ' )       ->  380ms
str.replace( /\s\s+/g, ' ' )     ->  390ms
str.replace( / {2,}/g, ' ' )     ->  470ms
str.replace( / +/g, ' ' )        ->  790ms
str.replace( / +(?= )/g, ' ')    -> 3250ms
```

This is on Firefox, running 100k string replacements.  

I encourage you to do your own profiling tests with firebug, if you think performance is an issue.  Humans are notoriously bad at predicting where the bottlenecks in their programs lie.  

(Also, note that IE 8's developer toolbar also has a profiler built in -- it might be worth checking what the performance is like in IE.)   

#### Answer 3 (score 43)
```perl
var str = "The      dog        has a long tail,      and it is RED!";
str = str.replace(/ {2,}/g,' ');
```

<p><strong>EDIT:</strong>
If you wish to replace all kind of whitespace characters the most efficient way would be like that:</p>

```perl
str = str.replace(/\s{2,}/g,' ');
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Test if characters are in a string (score [377400](https://stackoverflow.com/q/10128617) in 2018)

#### Question
I'm trying to determine if a string is a subset of another string.  For example:  

```perl
chars <- "test"
value <- "es"
```

I want to return TRUE if "value" appears as part of the string "chars".  In the following scenario, I would want to return false:  

```perl
chars <- "test"
value <- "et"
```

#### Answer accepted (score 338)
Use the  `grepl` function  

```perl
grepl(value, chars)
# TRUE
```

#### Answer 2 (score 133)
<h5>Answer</h2>

Sigh, it took me 45 minutes to find the answer to this simple question. The answer is: `grepl(needle, haystack, fixed=TRUE)`  

```perl
# Correct
> grepl("1+2", "1+2", fixed=TRUE)
[1] TRUE
> grepl("1+2", "123+456", fixed=TRUE)
[1] FALSE

# Incorrect
> grepl("1+2", "1+2")
[1] FALSE
> grepl("1+2", "123+456")
[1] TRUE
```

<hr>

<h5>Interpretation</h2>

`grep` is named after the linux executable, which is itself an acronym of "<strong>G</strong>lobal <strong>R</strong>egular <strong>E</strong>xpression <strong>P</strong>rint", it would read lines of input and then print them if they matched the arguments you gave. "Global" meant the match could occur anywhere on the input line, I'll explain "Regular Expression" below, but the idea is it's a smarter way to match the string (R calls this "character", eg `class("abc")`), and "Print" because it's a command line program, emitting output means it prints to its output string.  

Now, the `grep` program is basically a filter, from lines of input, to lines of output. And it seems that R's `grep` function similarly will take an array of inputs. For reasons that are utterly unknown to me (I only started playing with R about an hour ago), it returns a vector of the indexes that match, rather than a list of matches.  

But, back to your original question, what we really want is to know whether we found the needle in the haystack, a true/false value. They apparently decided to name this function `grepl`, as in "grep" but with a "<strong>L</strong>ogical" return value (they call true and false logical values, eg `class(TRUE)`).  

So, now we know where the name came from and what it's supposed to do. Lets get back to Regular Expressions. The arguments, even though they are strings, they are used to build regular expressions (henceforth: regex). A regex is a way to match a string (if this definition irritates you, let it go). For example, the regex `a` matches the character `"a"`, the regex `a*` matches the character `"a"` 0 or more times, and the regex `a+` would match the character `"a"` 1 or more times. Hence in the example above, the needle we are searching for `1+2`, when treated as a regex, means "one or more 1 followed by a 2"... but ours is followed by a plus!  

<a href="https://i.stack.imgur.com/cTye4.png"><img src="https://i.stack.imgur.com/cTye4.png" alt="1+2 as a regex"></a>  

So, if you used the `grepl` without setting `fixed`, your needles would accidentally be haystacks, and that would accidentally work quite often, we can see it even works for the OP's example. But that's a latent bug! We need to tell it the input is a string, not a regex, which is apparently what `fixed` is for. Why fixed? No clue, bookmark this answer b/c you're probably going to have to look it up 5 more times before you get it memorized.  

<h5>A few final thoughts</h2>

The better your code is, the less history you have to know to make sense of it. Every argument can have at least two interesting values (otherwise it wouldn't need to be an argument), the docs list 9 arguments here, which means there's at least 2^9=512 ways to invoke it, that's a lot of work to write, test, and remember... decouple such functions (split them up, remove dependencies on each other, string things are different than regex things are different than vector things). Some of the options are also mutually exclusive, don't give users incorrect ways to use the code, ie the problematic invocation should be structurally nonsensical (such as passing an option that doesn't exist), not logically nonsensical (where you have to emit a warning to explain it). Put metaphorically: replacing the front door in the side of the 10th floor with a wall is better than hanging a sign that warns against its use, but either is better than neither. In an interface, the function defines what the arguments should look like, not the caller (because the caller depends on the function, inferring everything that everyone might ever want to call it with makes the function depend on the callers, too, and this type of cyclical dependency will quickly clog a system up and never provide the benefits you expect). Be very wary of equivocating types, it's a design flaw that things like `TRUE` and `0` and `"abc"` are all vectors.  

#### Answer 3 (score 31)
You want `grepl`:  

```perl
> chars <- "test"
> value <- "es"
> grepl(value, chars)
[1] TRUE
> chars <- "test"
> value <- "et"
> grepl(value, chars)
[1] FALSE
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: How to find all occurrences of a substring? (score [375838](https://stackoverflow.com/q/4664850) in 2019)

#### Question
Python has `string.find()` and `string.rfind()` to get the index of a substring in a string.  

I'm wondering whether there is something like `string.find_all()` which can return all found indexes (not only the first from the beginning or the first from the end).  

For example:  

```perl
string = "test test test test"

print string.find('test') # 0
print string.rfind('test') # 15

#this is the goal
print string.find_all('test') # [0,5,10,15]
```

#### Answer accepted (score 465)
There is no simple built-in string function that does what you're looking for, but you could use the more powerful <a href="http://www.regular-expressions.info/" rel="noreferrer">regular expressions</a>:  

```perl
import re
[m.start() for m in re.finditer('test', 'test test test test')]
#[0, 5, 10, 15]
```

If you want to find overlapping matches, <a href="http://www.regular-expressions.info/lookaround.html" rel="noreferrer">lookahead</a> will do that:  

```perl
[m.start() for m in re.finditer('(?=tt)', 'ttt')]
#[0, 1]
```

If you want a reverse find-all without overlaps, you can combine positive and negative lookahead into an expression like this:  

```perl
search = 'tt'
[m.start() for m in re.finditer('(?=%s)(?!.{1,%d}%s)' % (search, len(search)-1, search), 'ttt')]
#[1]
```

<a href="http://docs.python.org/library/re.html#re.finditer" rel="noreferrer">`re.finditer`</a> returns a <a href="http://wiki.python.org/moin/Generators" rel="noreferrer">generator</a>, so you could change the `[]` in the above to `()` to get a generator instead of a list which will be more efficient if you're only iterating through the results once.  

#### Answer 2 (score 94)
```perl
>>> help(str.find)
Help on method_descriptor:

find(...)
    S.find(sub [,start [,end]]) -> int
```

Thus, we can build it ourselves:  

```perl
def find_all(a_str, sub):
    start = 0
    while True:
        start = a_str.find(sub, start)
        if start == -1: return
        yield start
        start += len(sub) # use start += 1 to find overlapping matches

list(find_all('spam spam spam spam', 'spam')) # [0, 5, 10, 15]
```

No temporary strings or regexes required.  

#### Answer 3 (score 43)
Here's a (very inefficient) way to get <em>all</em> (i.e. even overlapping) matches:  

```perl
>>> string = "test test test test"
>>> [i for i in range(len(string)) if string.startswith('test', i)]
[0, 5, 10, 15]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: What is the best regular expression to check if a string is a valid URL? (score [372948](https://stackoverflow.com/q/161738) in 2016)

#### Question
How can I check if a given string is a valid URL address?  

My knowledge of regular expressions is basic and doesn't allow me to choose from the hundreds of regular expressions I've already seen on the web.  

#### Answer 2 (score 395)
I wrote my URL (actually IRI, internationalized) pattern to comply with RFC 3987 (<a href="http://www.faqs.org/rfcs/rfc3987.html" rel="noreferrer">http://www.faqs.org/rfcs/rfc3987.html</a>). These are in PCRE syntax.  

For absolute IRIs (internationalized):  

```perl
/^[a-z](?:[-a-z0-9\+\.])*:(?:\/\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:])*@)?(?:\[(?:(?:(?:[0-9a-f]{1,4}:){6}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|::(?:[0-9a-f]{1,4}:){5}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){4}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,1}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){3}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,2}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){2}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,3}[0-9a-f]{1,4})?::[0-9a-f]{1,4}:(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,4}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,5}[0-9a-f]{1,4})?::[0-9a-f]{1,4}|(?:(?:[0-9a-f]{1,4}:){0,6}[0-9a-f]{1,4})?::)|v[0-9a-f]+\.[-a-z0-9\._~!\$&'\(\)\*\+,;=:]+)\]|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}|(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=])*)(?::[0-9]*)?(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*|\/(?:(?:(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))+)(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*)?|(?:(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))+)(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*|(?!(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])))(?:\?(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])|[\x{E000}-\x{F8FF}\x{F0000}-\x{FFFFD}\x{100000}-\x{10FFFD}\/\?])*)?(?:\#(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])|[\/\?])*)?$/i
```

To also allow relative IRIs:  

```perl
/^(?:[a-z](?:[-a-z0-9\+\.])*:(?:\/\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:])*@)?(?:\[(?:(?:(?:[0-9a-f]{1,4}:){6}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|::(?:[0-9a-f]{1,4}:){5}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){4}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,1}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){3}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,2}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){2}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,3}[0-9a-f]{1,4})?::[0-9a-f]{1,4}:(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,4}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,5}[0-9a-f]{1,4})?::[0-9a-f]{1,4}|(?:(?:[0-9a-f]{1,4}:){0,6}[0-9a-f]{1,4})?::)|v[0-9a-f]+\.[-a-z0-9\._~!\$&'\(\)\*\+,;=:]+)\]|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}|(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=])*)(?::[0-9]*)?(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*|\/(?:(?:(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))+)(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*)?|(?:(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))+)(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*|(?!(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])))(?:\?(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])|[\x{E000}-\x{F8FF}\x{F0000}-\x{FFFFD}\x{100000}-\x{10FFFD}\/\?])*)?(?:\#(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])|[\/\?])*)?|(?:\/\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:])*@)?(?:\[(?:(?:(?:[0-9a-f]{1,4}:){6}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|::(?:[0-9a-f]{1,4}:){5}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){4}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,1}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){3}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,2}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){2}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,3}[0-9a-f]{1,4})?::[0-9a-f]{1,4}:(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,4}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,5}[0-9a-f]{1,4})?::[0-9a-f]{1,4}|(?:(?:[0-9a-f]{1,4}:){0,6}[0-9a-f]{1,4})?::)|v[0-9a-f]+\.[-a-z0-9\._~!\$&'\(\)\*\+,;=:]+)\]|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}|(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=])*)(?::[0-9]*)?(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*|\/(?:(?:(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))+)(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*)?|(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=@])+)(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*|(?!(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])))(?:\?(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])|[\x{E000}-\x{F8FF}\x{F0000}-\x{FFFFD}\x{100000}-\x{10FFFD}\/\?])*)?(?:\#(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])|[\/\?])*)?)$/i
```

How they were compiled (in PHP):  

```perl
<?php

/* Regex convenience functions (character class, non-capturing group) */
function cc($str, $suffix = '', $negate = false) {
    return '[' . ($negate ? '^' : '') . $str . ']' . $suffix;
}
function ncg($str, $suffix = '') {
    return '(?:' . $str . ')' . $suffix;
}

/* Preserved from RFC3986 */

$ALPHA = 'a-z';
$DIGIT = '0-9';
$HEXDIG = $DIGIT . 'a-f';

$sub_delims = '!\\$&\'\\(\\)\\*\\+,;=';
$gen_delims = ':\\/\\?\\#\\[\\]@';
$reserved = $gen_delims . $sub_delims;
$unreserved = '-' . $ALPHA . $DIGIT . '\\._~';

$pct_encoded = '%' . cc($HEXDIG) . cc($HEXDIG);

$dec_octet = ncg(implode('|', array(
    cc($DIGIT),
    cc('1-9') . cc($DIGIT),
    '1' . cc($DIGIT) . cc($DIGIT),
    '2' . cc('0-4') . cc($DIGIT),
    '25' . cc('0-5')
)));

$IPv4address = $dec_octet . ncg('\\.' . $dec_octet, '{3}');

$h16 = cc($HEXDIG, '{1,4}');
$ls32 = ncg($h16 . ':' . $h16 . '|' . $IPv4address);

$IPv6address = ncg(implode('|', array(
    ncg($h16 . ':', '{6}') . $ls32,
    '::' . ncg($h16 . ':', '{5}') . $ls32,
    ncg($h16, '?') . '::' . ncg($h16 . ':', '{4}') . $ls32,
    ncg($h16 . ':' . $h16, '?') . '::' . ncg($h16 . ':', '{3}') . $ls32,
    ncg(ncg($h16 . ':', '{0,2}') . $h16, '?') . '::' . ncg($h16 . ':', '{2}') . $ls32,
    ncg(ncg($h16 . ':', '{0,3}') . $h16, '?') . '::' . $h16 . ':' . $ls32,
    ncg(ncg($h16 . ':', '{0,4}') . $h16, '?') . '::' . $ls32,
    ncg(ncg($h16 . ':', '{0,5}') . $h16, '?') . '::' . $h16,
    ncg(ncg($h16 . ':', '{0,6}') . $h16, '?') . '::',
)));

$IPvFuture = 'v' . cc($HEXDIG, '+') . cc($unreserved . $sub_delims . ':', '+');

$IP_literal = '\\[' . ncg(implode('|', array($IPv6address, $IPvFuture))) . '\\]';

$port = cc($DIGIT, '*');

$scheme = cc($ALPHA) . ncg(cc('-' . $ALPHA . $DIGIT . '\\+\\.'), '*');

/* New or changed in RFC3987 */

$iprivate = '\x{E000}-\x{F8FF}\x{F0000}-\x{FFFFD}\x{100000}-\x{10FFFD}';

$ucschar = '\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}' .
    '\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}' .
    '\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}' .
    '\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}' .
    '\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}' .
    '\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}';

$iunreserved = '-' . $ALPHA . $DIGIT . '\\._~' . $ucschar;

$ipchar = ncg($pct_encoded . '|' . cc($iunreserved . $sub_delims . ':@'));

$ifragment = ncg($ipchar . '|' . cc('\\/\\?'), '*');

$iquery = ncg($ipchar . '|' . cc($iprivate . '\\/\\?'), '*');

$isegment_nz_nc = ncg($pct_encoded . '|' . cc($iunreserved . $sub_delims . '@'), '+');
$isegment_nz = ncg($ipchar, '+');
$isegment = ncg($ipchar, '*');

$ipath_empty = '(?!' . $ipchar . ')';
$ipath_rootless = ncg($isegment_nz) . ncg('\\/' . $isegment, '*');
$ipath_noscheme = ncg($isegment_nz_nc) . ncg('\\/' . $isegment, '*');
$ipath_absolute = '\\/' . ncg($ipath_rootless, '?'); // Spec says isegment-nz *( "/" isegment )
$ipath_abempty = ncg('\\/' . $isegment, '*');

$ipath = ncg(implode('|', array(
    $ipath_abempty,
    $ipath_absolute,
    $ipath_noscheme,
    $ipath_rootless,
    $ipath_empty
))) . ')';

$ireg_name = ncg($pct_encoded . '|' . cc($iunreserved . $sub_delims . '@'), '*');

$ihost = ncg(implode('|', array($IP_literal, $IPv4address, $ireg_name)));
$iuserinfo = ncg($pct_encoded . '|' . cc($iunreserved . $sub_delims . ':'), '*');
$iauthority = ncg($iuserinfo . '@', '?') . $ihost . ncg(':' . $port, '?');

$irelative_part = ncg(implode('|', array(
    '\\/\\/' . $iauthority . $ipath_abempty . '',
    '' . $ipath_absolute . '',
    '' . $ipath_noscheme . '',
    '' . $ipath_empty . ''
)));

$irelative_ref = $irelative_part . ncg('\\?' . $iquery, '?') . ncg('\\#' . $ifragment, '?');

$ihier_part = ncg(implode('|', array(
    '\\/\\/' . $iauthority . $ipath_abempty . '',
    '' . $ipath_absolute . '',
    '' . $ipath_rootless . '',
    '' . $ipath_empty . ''
)));

$absolute_IRI = $scheme . ':' . $ihier_part . ncg('\\?' . $iquery, '?');

$IRI = $scheme . ':' . $ihier_part . ncg('\\?' . $iquery, '?') . ncg('\\#' . $ifragment, '?');

$IRI_reference = ncg($IRI . '|' . $irelative_ref);
```

Edit 7 March 2011: Because of the way PHP handles backslashes in quoted strings, these are unusable by default. You'll need to double-escape backslashes except where the backslash has a special meaning in regex. You can do that this way:  

```perl
$escape_backslash = '/(?<!\\)\\(?![\[\]\\\^\$\.\|\*\+\(\)QEnrtaefvdwsDWSbAZzB1-9GX]|x\{[0-9a-f]{1,4}\}|\c[A-Z]|)/';
$absolute_IRI = preg_replace($escape_backslash, '\\\\', $absolute_IRI);
$IRI = preg_replace($escape_backslash, '\\\\', $IRI);
$IRI_reference = preg_replace($escape_backslash, '\\\\', $IRI_reference);
```

#### Answer 3 (score 141)
I've just written up a blog post for a great solution for recognizing URLs in most used formats such as:  

<ul>
<li>`www.google.com`</li>
<li>`http://www.google.com`</li>
<li>`mailto:somebody@google.com`</li>
<li>`somebody@google.com`</li>
<li>`www.url-with-querystring.com/?url=has-querystring`</li>
</ul>

The regular expression used is:  

```perl
/((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: How to output only captured groups with sed? (score [372573](https://stackoverflow.com/q/2777579) in 2019)

#### Question
Is there any way to tell `sed` to output only captured groups? For example given the input:  

```perl
This is a sample 123 text and some 987 numbers
```

and pattern:  

```perl
/([\d]+)/
```

Could I get only 123 and 987 output in the way formatted by back references?  

#### Answer accepted (score 298)
The key to getting this to work is to tell `sed` to exclude what you don't want to be output as well as specifying what you do want.  

```perl
string='This is a sample 123 text and some 987 numbers'
echo "$string" | sed -rn 's/[^[:digit:]]*([[:digit:]]+)[^[:digit:]]+([[:digit:]]+)[^[:digit:]]*/\1 \2/p'
```

This says:  

<ul>
<li>don't default to printing each line (`-n`)</li>
<li>exclude zero or more non-digits</li>
<li>include one or more digits</li>
<li>exclude one or more non-digits</li>
<li>include one or more digits</li>
<li>exclude zero or more non-digits</li>
<li>print the substitution (`p`)</li>
</ul>

In general, in `sed` you capture groups using parentheses and output what you capture using a back reference:  

```perl
echo "foobarbaz" | sed 's/^foo\(.*\)baz$/\1/'
```

will output "bar". If you use `-r` (`-E` for OS X) for extended regex, you don't need to escape the parentheses:  

```perl
echo "foobarbaz" | sed -r 's/^foo(.*)baz$/\1/'
```

There can be up to 9 capture groups and their back references. The back references are numbered in the order the groups appear, but they can be used in any order and can be repeated:  

```perl
echo "foobarbaz" | sed -r 's/^foo(.*)b(.)z$/\2 \1 \2/'
```

outputs "a bar a".  

If you have GNU `grep` (it may also work in BSD, including OS X):  

```perl
echo "$string" | grep -Po '\d+'
```

or variations such as:  

```perl
echo "$string" | grep -Po '(?<=\D )(\d+)'
```

<p>The `-P` option enables Perl Compatible Regular Expressions. See <a href="http://linux.die.net/man/3/pcrepattern" rel="noreferrer">`man 3 pcrepattern`</a> or <a href="http://linux.die.net/man/3/pcresyntax" rel="noreferrer"><code>man 
3 pcresyntax</code></a>.</p>

#### Answer 2 (score 52)
Sed has up to nine remembered patterns but you need to use escaped parentheses to remember portions of the regular expression.  

See <a href="http://www.grymoire.com/Unix/Sed.html#uh-4" rel="noreferrer">here</a> for examples and more detail  

#### Answer 3 (score 30)
you can use grep  

```perl
grep -Eow "[0-9]+" file
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: Using RegEx in SQL Server (score [371450](https://stackoverflow.com/q/8928378) in )

#### Question
I'm looking how to replace/encode text using RegEx based on RegEx settings/params below:  

```perl
RegEx.IgnoreCase = True     
RegEx.Global = True     
RegEx.Pattern = "[^a-z\d\s.]+"   
```

I have seen some examples on RegEx, but confused as to how to apply it the same way in SQL Server. Any suggestions would be helpful. Thank you.  

#### Answer accepted (score 91)
You do not need to interact with managed code, as you can use <a href="http://msdn.microsoft.com/en-us/library/ms179859.aspx" rel="noreferrer">LIKE</a>:  

```perl
CREATE TABLE #Sample(Field varchar(50), Result varchar(50))
GO
INSERT INTO #Sample (Field, Result) VALUES ('ABC123 ', 'Do not match')
INSERT INTO #Sample (Field, Result) VALUES ('ABC123.', 'Do not match')
INSERT INTO #Sample (Field, Result) VALUES ('ABC123&', 'Match')
SELECT * FROM #Sample WHERE Field LIKE '%[^a-z0-9 .]%'
GO
DROP TABLE #Sample
```

As your expression ends with `+` you can go with `'%[^a-z0-9 .][^a-z0-9 .]%'`  

<strong>EDIT</strong>: to make clear: SQL Server doesn't supports regular expressions without managed code. Depending on the situation, the `LIKE` operator can be an option, but it lacks the flexibility that regular expressions provides.  

#### Answer 2 (score 7)
You will have to build a CLR procedure that provides regex functionality, as <a href="http://www.simple-talk.com/sql/t-sql-programming/clr-assembly-regex-functions-for-sql-server-by-example/" rel="nofollow noreferrer">this article</a> illustrates.  

Their example function uses VB.NET:  

```perl
Imports System
Imports System.Data.Sql
Imports Microsoft.SqlServer.Server
Imports System.Data.SqlTypes
Imports System.Runtime.InteropServices
Imports System.Text.RegularExpressions
Imports System.Collections 'the IEnumerable interface is here  


Namespace SimpleTalk.Phil.Factor
    Public Class RegularExpressionFunctions
        'RegExIsMatch function
        <SqlFunction(IsDeterministic:=True, IsPrecise:=True)> _
        Public Shared Function RegExIsMatch( _
                                            ByVal pattern As SqlString, _
                                            ByVal input As SqlString, _
                                            ByVal Options As SqlInt32) As SqlBoolean
            If (input.IsNull OrElse pattern.IsNull) Then
                Return SqlBoolean.False
            End If
            Dim RegExOption As New System.Text.RegularExpressions.RegExOptions
            RegExOption = Options
            Return RegEx.IsMatch(input.Value, pattern.Value, RegExOption)
        End Function
    End Class      ' 
End Namespace
```

...and is installed in SQL Server using the following SQL (replacing '%'-delimted variables by their actual equivalents:  

```perl
sp_configure 'clr enabled', 1
RECONFIGURE WITH OVERRIDE

IF EXISTS ( SELECT   1
            FROM     sys.objects
            WHERE    object_id = OBJECT_ID(N'dbo.RegExIsMatch') ) 
   DROP FUNCTION dbo.RegExIsMatch
go

IF EXISTS ( SELECT   1
            FROM     sys.assemblies asms
            WHERE    asms.name = N'RegExFunction ' ) 
   DROP ASSEMBLY [RegExFunction]

CREATE ASSEMBLY RegExFunction 
           FROM '%FILE%'
GO

CREATE FUNCTION RegExIsMatch
   (
    @Pattern NVARCHAR(4000),
    @Input NVARCHAR(MAX),
    @Options int
   )
RETURNS BIT
AS EXTERNAL NAME 
   RegExFunction.[SimpleTalk.Phil.Factor.RegularExpressionFunctions].RegExIsMatch
GO

--a few tests
---Is this card a valid credit card?
SELECT dbo.RegExIsMatch ('^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$','4241825283987487',1)
--is there a number in this string
SELECT dbo.RegExIsMatch( '\d','there is 1 thing I hate',1)
--Verifies number Returns 1
DECLARE @pattern VARCHAR(255)
SELECT @pattern ='[a-zA-Z0-9]\d{2}[a-zA-Z0-9](-\d{3}){2}[A-Za-z0-9]'
SELECT  dbo.RegExIsMatch (@pattern, '1298-673-4192',1),
        dbo.RegExIsMatch (@pattern,'A08Z-931-468A',1),
        dbo.RegExIsMatch (@pattern,'[A90-123-129X',1),
        dbo.RegExIsMatch (@pattern,'12345-KKA-1230',1),
        dbo.RegExIsMatch (@pattern,'0919-2893-1256',1)
```

#### Answer 3 (score 6)
Slightly modified version of <a href="https://www.simple-talk.com/sql/t-sql-programming/tsql-regular-expression-workbench/" rel="noreferrer">Julio's answer.</a>  

```perl
-- MS SQL using VBScript Regex
-- select dbo.RegexReplace('aa bb cc','($1) ($2) ($3)','([^\s]*)\s*([^\s]*)\s*([^\s]*)')
-- $$ dollar sign, $1 - $9 back references, $& whole match

CREATE FUNCTION [dbo].[RegexReplace]
(   -- these match exactly the parameters of RegExp
    @searchstring varchar(4000),
    @replacestring varchar(4000),
    @pattern varchar(4000)
)
RETURNS varchar(4000)
AS
BEGIN
    declare @objRegexExp int, 
        @objErrorObj int,
        @strErrorMessage varchar(255),
        @res int,
        @result varchar(4000)

    if( @searchstring is null or len(ltrim(rtrim(@searchstring))) = 0) return null
    set @result=''
    exec @res=sp_OACreate 'VBScript.RegExp', @objRegexExp out
    if( @res <> 0) return '..VBScript did not initialize'
    exec @res=sp_OASetProperty @objRegexExp, 'Pattern', @pattern
    if( @res <> 0) return '..Pattern property set failed'
    exec @res=sp_OASetProperty @objRegexExp, 'IgnoreCase', 0
    if( @res <> 0) return '..IgnoreCase option failed'
    exec @res=sp_OAMethod @objRegexExp, 'Replace', @result OUT,
         @searchstring, @replacestring
    if( @res <> 0) return '..Bad search string'
    exec @res=sp_OADestroy @objRegexExp
    return @result
END
```

You'll need Ole Automation Procedures turned on in SQL:  

```perl
exec sp_configure 'show advanced options',1; 
go
reconfigure; 
go
sp_configure 'Ole Automation Procedures', 1; 
go
reconfigure; 
go
sp_configure 'show advanced options',0; 
go
reconfigure;
go
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Regular expression to match a word or its prefix (score [365246](https://stackoverflow.com/q/18402416) in 2018)

#### Question
I want to match a regular expression on a whole word.  

In the following example I am trying to match `s` or `season` but what I have matches `s`, `e`, `a`, `o` and `n`.    

```perl
[s|season]
```

How do I make a regular expression to match a whole word?  

#### Answer accepted (score 125)
Square brackets are meant for character class, and you're actually trying to match any one of: `s`, `|`, `s` (again), `e`, `a`, `s` (again), `o` and `n`.  

Use parentheses instead for grouping:  

```perl
(s|season)
```

or non-capturing group:  

```perl
(?:s|season)
```

<hr>

Note: Non-capture groups tell the engine that it doesn't need to store the match, while the other one (capturing group does). For small stuff, either works, for 'heavy duty' stuff, you might want to see first if you need the match or not. If you don't, better use the non-capture group to allocate more memory for calculation instead of storing something you will never need to use.  

#### Answer 2 (score 115)
<h5>Use this live online example to test your pattern:</h2>

<img src="https://i.stack.imgur.com/l69SY.png" alt="enter image description here">  

Above screenshot taken from this live example: <a href="https://regex101.com/r/cU5lC2/1" rel="noreferrer">https://regex101.com/r/cU5lC2/1</a>  

<h5>Matching any whole word on the commandline.</h2>

I'll be using the <a href="http://www.phpsh.org/" rel="noreferrer">phpsh interactive shell</a> on <a href="http://releases.ubuntu.com/12.10/" rel="noreferrer">Ubuntu 12.10</a> to demonstrate the <a href="http://us2.php.net/pcre" rel="noreferrer">PCRE regex engine</a> through the method known as <a href="http://us2.php.net/preg_match" rel="noreferrer">preg_match</a>  

Start phpsh, put some content into a variable, match on word.  

```perl
el@apollo:~/foo$ phpsh

php> $content1 = 'badger'
php> $content2 = '1234'
php> $content3 = '$%^&'

php> echo preg_match('(\w+)', $content1);
1

php> echo preg_match('(\w+)', $content2);
1

php> echo preg_match('(\w+)', $content3);
0
```

The preg_match method used the PCRE engine within the PHP language to analyze variables: `$content1`, `$content2` and `$content3` with the `(\w)+` pattern.    

$content1 and $content2 contain at least one word, $content3 does not.  

<h5>Match a specific words on the commandline without word bountaries</h2>

```perl
el@apollo:~/foo$ phpsh

php> $gun1 = 'dart gun';
php> $gun2 = 'fart gun';
php> $gun3 = 'darty gun';
php> $gun4 = 'unicorn gun';

php> echo preg_match('(dart|fart)', $gun1);
1

php> echo preg_match('(dart|fart)', $gun2);
1

php> echo preg_match('(dart|fart)', $gun3);
1

php> echo preg_match('(dart|fart)', $gun4);
0
```

Variables `gun1` and `gun2` contain the string `dart` or `fart` which is correct, but gun3 contains `darty` and still matches, that is the problem.  So onto the next example.  

<h5>Match specific words on the commandline with word boundaries:</h2>

<p>Word Boundaries can be force matched with `\b`, see:
<a href="https://i.stack.imgur.com/U7T8z.png" rel="noreferrer"><img src="https://i.stack.imgur.com/U7T8z.png" alt="Visual analysis of what wordboundary is doing from jex.im/regulex "></a></p>

Regex Visual Image acquired from <a href="http://jex.im/regulex" rel="noreferrer">http://jex.im/regulex</a> and <a href="https://github.com/JexCheng/regulex" rel="noreferrer">https://github.com/JexCheng/regulex</a>  Example:  

```perl
el@apollo:~/foo$ phpsh

php> $gun1 = 'dart gun';
php> $gun2 = 'fart gun';
php> $gun3 = 'darty gun';
php> $gun4 = 'unicorn gun';

php> echo preg_match('(\bdart\b|\bfart\b)', $gun1);
1

php> echo preg_match('(\bdart\b|\bfart\b)', $gun2);
1

php> echo preg_match('(\bdart\b|\bfart\b)', $gun3);
0

php> echo preg_match('(\bdart\b|\bfart\b)', $gun4);
0
```

The `\b` asserts that we have a word boundary, making sure " dart " is matched, but " darty " isn't.  

#### Answer 3 (score 3)
<p>I test examples in js. 
Simplest solution - just add word u need inside / /:</p>

```perl
var reg = /cat/;
reg.test('some cat here');//1 test
true // result
reg.test('acatb');//2 test
true // result
```

<hr>

Now if u need this specific word with boundaries, not inside any other signs-letters. We use <strong>b</strong> marker:  

```perl
var reg = /\bcat\b/
reg.test('acatb');//1 test 
false // result
reg.test('have cat here');//2 test
true // result
```

We have also exec() method in js, whichone returns object-result. It helps f.g. to get info about place/index of our word.  

```perl
var matchResult = /\bcat\b/.exec("good cat good");
console.log(matchResult.index); // 5
```

If we need get all matched words in string/sentence/text, we can use g modifier (global match):  

```perl
"cat good cat good cat".match(/\bcat\b/g).length
// 3 
```

Now the last one - i need not 1 specific word, but some of them. We use | sign, it means choice/or.  

```perl
"bad dog bad".match(/\bcat|dog\b/g).length
// 1
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: Match two strings in one line with grep (score [363844](https://stackoverflow.com/q/4487328) in 2019)

#### Question
I am trying to use `grep` to match lines that contain two different strings. I have tried the following but this matches lines that contain either <em>string1</em> <strong>or</strong> <em>string2</em> which not what I want.  

```perl
grep 'string1\|string2' filename
```

So how do I match with `grep` only the lines that contain <em>both strings</em>?  

#### Answer accepted (score 173)
You can use `grep 'string1' filename | grep 'string2'`  

Or, `grep 'string1.*string2\|string2.*string1' filename`  

#### Answer 2 (score 197)
I think this is what you were looking for:  

```perl
grep -E "string1|string2" filename
```

I think that answers like this:  

```perl
grep 'string1.*string2\|string2.*string1' filename
```

only match the case where both are present, not one or the other or both.  

#### Answer 3 (score 26)
To search for files containing all the words in any order anywhere:  

```perl
grep -ril \'action\' | xargs grep -il \'model\' | xargs grep -il \'view_type\'
```

The first grep kicks off a recursive search (`r`), ignoring case (`i`) and listing (printing out) the name of the files that are matching (`l`) for one term (`'action'` with the single quotes) occurring anywhere in the file.  

The subsequent greps search for the other terms, retaining case insensitivity and listing out the matching files.  

The final list of files that you will get will the ones that contain these terms, in any order anywhere in the file.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: Regex: match everything but specific pattern (score [359326](https://stackoverflow.com/q/1687620) in 2019)

#### Question
I need a regex able to match everything <strong>but</strong> a string starting with a specific pattern (specifically `index.php` and what follows, like `index.php?id=2342343`)  

#### Answer accepted (score 204)
Not a regexp expert, but I think you could use a negative lookahead from the start, e.g. `^(?!foo).*$` shouldn't match anything starting with `foo`.  

#### Answer 2 (score 256)
Regex: match everything <strong>but</strong>:  

<ul>
<li>a <strong>string <em>starting with</em> a specific pattern</strong>  (e.g. any  - empty, too - string not starting with `foo`):

<ul>
<li>Lookahead-based solution for NFAs: 

<ul>
<li><a href="https://regex101.com/r/jC8nB0/6">`^(?!foo).*$`</a></li>
<li><a href="https://regex101.com/r/jC8nB0/5">`^(?!foo)`</a></li>
</ul></li>
<li>Negated character class based solution <em>for regex engines not supporting lookarounds</em>:

<ul>
<li><a href="https://regex101.com/r/jC8nB0/16">`^(([^f].{2}|.[^o].|.{2}[^o]).*|.{0,2})$`</a></li>
<li><a href="https://regex101.com/r/jC8nB0/15">`^([^f].{2}|.[^o].|.{2}[^o])|^.{0,2}$`</a></li>
</ul></li>
</ul></li>
<li>a <strong>string <em>ending with</em> a specific pattern</strong> (say, no `world.` at the end):

<ul>
<li>Lookbehind-based solution:

<ul>
<li><a href="https://regex101.com/r/jC8nB0/11">`(?&lt;!world\.)$`</a></li>
<li><a href="https://regex101.com/r/jC8nB0/12">`^.*(?&lt;!world\.)$`</a></li>
</ul></li>
<li>POSIX workaround:

<ul>
<li><a href="https://regex101.com/r/jC8nB0/17">`^(.*([^w].{5}|.[^o].{4}|.{2}[^r].{3}|.{3}[^l].{2}|.{4}[^d].|.{5}[^.])|.{0,5})$`</a></li>
<li><a href="https://regex101.com/r/jC8nB0/18">`([^w].{5}|.[^o].{4}|.{2}[^r].{3}|.{3}[^l].{2}|.{4}[^d].|.{5}[^.]$|^.{0,5})$`</a></li>
</ul></li>
</ul></li>
<li>a <strong>string <em>containing</em> specific text</strong> (say, not match a string having `foo`) (no POSIX compliant patern, sorry): 

<ul>
<li><a href="https://regex101.com/r/jC8nB0/21">`^(?!.*foo)`</a></li>
<li><a href="https://regex101.com/r/jC8nB0/22">`^(?!.*foo).*$`</a></li>
</ul></li>
<li>a <strong>string <em>containing</em> specific <em>character</em></strong> (say, avoid matching a string having a `|` symbol):

<ul>
<li><a href="https://regex101.com/r/jC8nB0/26">`^[^|]*$`</a></li>
</ul></li>
<li>a <strong>string <em>equal to</em> some string</strong> (say, not equal to `foo`):

<ul>
<li>Lookaround-based:

<ul>
<li><a href="https://regex101.com/r/jC8nB0/23">`^(?!foo$)`</a></li>
<li><a href="https://regex101.com/r/jC8nB0/24">`^(?!foo$).*$`</a></li>
</ul></li>
<li>POSIX:

<ul>
<li><a href="https://regex101.com/r/jC8nB0/25">`^(.{0,2}|.{4,}|[^f]..|.[^o].|..[^o])$`</a></li>
</ul></li>
</ul></li>
<li>a <strong>sequence of characters</strong>: 

<ul>
<li><em>PCRE</em> (match any text but `cat`): <a href="https://regex101.com/r/jC8nB0/1">`/cat(*SKIP)(*FAIL)|[^c]*(?:c(?!at)[^c]*)*/i`</a> or <a href="https://regex101.com/r/jC8nB0/2">`/cat(*SKIP)(*FAIL)|(?:(?!cat).)+/is`</a></li>
<li>Other engines allowing lookarounds: <a href="https://regex101.com/r/jC8nB0/19">`(cat)|[^c]*(?:c(?!at)[^c]*)*`</a> (or <a href="https://regex101.com/r/jC8nB0/20">`(?s)(cat)|(?:(?!cat).)*`</a>, or `(cat)|[^c]+(?:c(?!at)[^c]*)*|(?:c(?!at)[^c]*)+[^c]*`) and then check with language means: if Group 1 matched, it is not what we need, else, grab the match value if not empty</li>
</ul></li>
<li>a <strong>certain single character or a set of characters</strong>:

<ul>
<li>Use a <a href="http://www.regular-expressions.info/charclass.html#negated">negated character class</a>: <a href="https://regex101.com/r/jC8nB0/7">`[^a-z]+`</a> (any char other than a lowercase ASCII letter)</li>
<li>Matching any char(s) but `|`: <a href="https://regex101.com/r/jC8nB0/8">`[^|]+`</a></li>
</ul></li>
</ul>

<strong>Demo note</strong>: the newline `\n` is used inside negated character classes in demos to avoid match overflow to the neighboring line(s). They are not necessary when testing individual strings.  

<strong>Anchor note</strong>: In many languages, use `\A` to define the unambiguous start of string, and `\z` (in Python, it is `\Z`, in JavaScript, `$` is OK) to define the very end of the string.  

<strong>Dot note</strong>: In many flavors (but not POSIX, TRE, TCL), `.` matches any char <em>but a newline</em> char. Make sure you use a corresponding DOTALL modifier (`/s` in PCRE/Boost/.NET/Python/Java and `/m` in Ruby) for the `.` to match any char including a newline.  

<strong>Backslash note</strong>: In languages where you have to declare patterns with C strings allowing escape sequences (like `\n` for a newline), you need to double the backslashes escaping special characters so that the engine could treat them as literal characters (e.g. in Java, `world\.` will be declared as `"world\\."`, or use a character class: `"world[.]"`). Use raw string literals (Python `r'\bworld\b'`), C# verbatim string literals `@"world\."`, or slashy strings/regex literal notations like `/world\./`.  

#### Answer 3 (score 243)
You can put a `^` in the beginning of a character set to match anything but those characters.  

```perl
[^=]*
```

will match everything but `=`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: Regex - Does not contain certain Characters (score [353405](https://stackoverflow.com/q/4105956) in 2019)

#### Question
I need a regex to match if anywhere in a sentence there is NOT either &lt; or >.  

If either &lt; or > are in the string then it must return false.  

I had a partial success with this but only if my &lt; > are at the beginning or end:  

```perl
(?!<|>).*$
```

I am using .Net if that makes a difference.  

Thanks for the help.  

#### Answer accepted (score 368)
```perl
^[^<>]+$
```

The caret in the character class (`[^`) means match anything but, so this means, beginning of string, then one or more of anything except `&lt;` and `&gt;`, then the end of the string.  

#### Answer 2 (score 52)
Here you go:  

```perl
^[^<>]*$
```

This will test for string that has no `&lt;` and no `&gt;`  

If you want to test for a string that may have `&lt;` and `&gt;`, but must also have something other you should use just  

```perl
[^<>] (or ^.*[^<>].*$)
```

Where `[&lt;&gt;]` means <em>any of `&lt;` or `&gt;`</em> and `[^&lt;&gt;]` means <em>any that is not of `&lt;` or `&gt;`</em>.  

And of course the mandatory <a href="http://www.regular-expressions.info/reference.html">link</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Whitespace Matching Regex - Java (score [352296](https://stackoverflow.com/q/4731055) in 2014)

#### Question
The Java API for <a href="http://download.oracle.com/javase/6/docs/api/java/util/regex/Pattern.html">regular expressions</a> states that `\s` will match whitespace. So the regex `\\s\\s` should match two spaces.  

```perl
Pattern whitespace = Pattern.compile("\\s\\s");
matcher = whitespace.matcher(modLine);
while (matcher.find()) matcher.replaceAll(" ");
```

The aim of this is to replace all instances of two consecutive whitespace with a single space. However this does not actually work.  

Am I having a grave misunderstanding of regexes or the term "whitespace"?  

#### Answer accepted (score 41)
Yeah, you need to grab the result of matcher.replaceAll():  

```perl
String result = matcher.replaceAll(" ");
System.out.println(result);
```

#### Answer 2 (score 182)
You can’t use `\s` in Java to match white space on its own native character set, because Java doesn’t support the Unicode white space property — even though doing so is strictly required to meet <a href="http://www.unicode.org/reports/tr18/#Categories" rel="noreferrer">UTS#18’s RL1.2!</a>  What it does have is not standards-conforming, alas.  

Unicode defines 26 code points as `\p{White_Space}`: 20 of them are various sorts of `\pZ` <em>GeneralCategory=Separator</em>, and the remaining 6 are `\p{Cc}` <em>GeneralCategory=Control</em>.    

White space is a pretty stable property, and those same ones have been around virtually forever. Even so,  Java has no property that conforms to The Unicode Standard for these, so you instead have to use code like this:  

```perl
String whitespace_chars =  ""       /* dummy empty string for homogeneity */
                        + "\\u0009" // CHARACTER TABULATION
                        + "\\u000A" // LINE FEED (LF)
                        + "\\u000B" // LINE TABULATION
                        + "\\u000C" // FORM FEED (FF)
                        + "\\u000D" // CARRIAGE RETURN (CR)
                        + "\\u0020" // SPACE
                        + "\\u0085" // NEXT LINE (NEL) 
                        + "\\u00A0" // NO-BREAK SPACE
                        + "\\u1680" // OGHAM SPACE MARK
                        + "\\u180E" // MONGOLIAN VOWEL SEPARATOR
                        + "\\u2000" // EN QUAD 
                        + "\\u2001" // EM QUAD 
                        + "\\u2002" // EN SPACE
                        + "\\u2003" // EM SPACE
                        + "\\u2004" // THREE-PER-EM SPACE
                        + "\\u2005" // FOUR-PER-EM SPACE
                        + "\\u2006" // SIX-PER-EM SPACE
                        + "\\u2007" // FIGURE SPACE
                        + "\\u2008" // PUNCTUATION SPACE
                        + "\\u2009" // THIN SPACE
                        + "\\u200A" // HAIR SPACE
                        + "\\u2028" // LINE SEPARATOR
                        + "\\u2029" // PARAGRAPH SEPARATOR
                        + "\\u202F" // NARROW NO-BREAK SPACE
                        + "\\u205F" // MEDIUM MATHEMATICAL SPACE
                        + "\\u3000" // IDEOGRAPHIC SPACE
                        ;        
/* A \s that actually works for Java’s native character set: Unicode */
String     whitespace_charclass = "["  + whitespace_chars + "]";    
/* A \S that actually works for  Java’s native character set: Unicode */
String not_whitespace_charclass = "[^" + whitespace_chars + "]";
```

Now you can use `whitespace_charclass + "+"` as the pattern in your `replaceAll`.  

<hr>

Sorry ’bout all that. <strong>Java’s regexes just don’t work very well on its own native character set,</strong> and so you really have to jump through exotic hoops to make them work.   

And if you think white space is bad, you should see what you have to do to get `\w` and `\b` to finally behave properly!   

Yes, it’s possible, and yes, it’s a mindnumbing mess.  That’s being charitable, even. The easiest way to get a standards-comforming regex library for Java is to JNI over to ICU’s stuff. That’s what Google does for Android, because OraSun’s doesn’t measure up.  

If you don’t want to do that but still want to stick with Java, I have a front-end regex rewriting library I wrote that “fixes” Java’s patterns, at least to get them conform to the requirements of <a href="http://www.unicode.org/reports/tr18/#Compatibility_Properties" rel="noreferrer">RL1.2a in UTS#18, <em>Unicode Regular Expressions</em></a>.  

#### Answer 3 (score 13)
For Java (not php, not javascript, not anyother):  

```perl
txt.replaceAll("\\p{javaSpaceChar}{2,}"," ")
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: How to use regex with find command? (score [351529](https://stackoverflow.com/q/6844785) in 2011)

#### Question
I have some images named with generated uuid1 string. For example 81397018-b84a-11e0-9d2a-001b77dc0bed.jpg. I want to find out all these images using "find" command:  

```perl
find . -regex "[a-f0-9\-]\{36\}\.jpg".
```

But it doesn't work. Something wrong with the regex? Could someone help me with this?  

#### Answer accepted (score 311)
```perl
find . -regextype sed -regex ".*/[a-f0-9\-]\{36\}\.jpg"
```

Note that you need to specify `.*/` in the beginning because `find` matches the whole path.  

Example:  

```perl
susam@nifty:~/so$ find . -name "*.jpg"
./foo-111.jpg
./test/81397018-b84a-11e0-9d2a-001b77dc0bed.jpg
./81397018-b84a-11e0-9d2a-001b77dc0bed.jpg
susam@nifty:~/so$ 
susam@nifty:~/so$ find . -regextype sed -regex ".*/[a-f0-9\-]\{36\}\.jpg"
./test/81397018-b84a-11e0-9d2a-001b77dc0bed.jpg
./81397018-b84a-11e0-9d2a-001b77dc0bed.jpg
```

My version of find:  

```perl
$ find --version
find (GNU findutils) 4.4.2
Copyright (C) 2007 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Eric B. Decker, James Youngman, and Kevin Dalley.
Built using GNU gnulib version e5573b1bad88bfabcda181b9e0125fb0c52b7d3b
Features enabled: D_TYPE O_NOFOLLOW(enabled) LEAF_OPTIMISATION FTS() CBO(level=0) 
susam@nifty:~/so$ 
susam@nifty:~/so$ find . -regextype foo -regex ".*/[a-f0-9\-]\{36\}\.jpg"
find: Unknown regular expression type `foo'; valid types are `findutils-default', `awk', `egrep', `ed', `emacs', `gnu-awk', `grep', `posix-awk', `posix-basic', `posix-egrep', `posix-extended', `posix-minimal-basic', `sed'.
```

#### Answer 2 (score 72)
The `-regex` find expression matches the <strong>whole name</strong>, including the relative path from the current directory. For `find .` this always starts with `./`, then any directories.  

Also, these are `emacs` regular expressions, which have other escaping rules than the usual egrep regular expressions.  

If these are all directly in the current directory, then   

```perl
find . -regex '\./[a-f0-9\-]\{36\}\.jpg'
```

should work. (I'm not really sure - I can't get the counted repetition to work here.) You can switch to egrep expressions by `-regextype posix-egrep`:  

```perl
find . -regextype posix-egrep -regex '\./[a-f0-9\-]{36}\.jpg'
```

(Note that everything said here is for GNU find, I don't know anything about the BSD one which is also the default on Mac.)  

#### Answer 3 (score 30)
Judging from other answers, it seems this might be find's fault.  

However you can do it this way instead:  

`find . * | grep -P "[a-f0-9\-]{36}\.jpg"`  

You might have to tweak the grep a bit and use different options depending on what you want but it works.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: PHP string "contains" (score [351294](https://stackoverflow.com/q/13577041) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://stackoverflow.com/questions/1019169/how-can-i-check-if-a-word-is-contained-in-another-string-using-php">How can I check if a word is contained in another string using PHP?</a>  </p>
</blockquote>



What would be the most efficient way to check whether a string contains a "." or not?  

I know you can do this in many different ways like with <a href="http://en.wikipedia.org/wiki/Regular_expression" rel="noreferrer">regular expressions</a> or loop through the string to see if it contains a dot (".").  

#### Answer accepted (score 488)
```perl
if (strpos($str, '.') !== FALSE)
{
 echo 'Found it';
}
else
{
 echo 'Not found.';
}
```

Note that you need to compare with the `!==` operator. If you use `!=` or `&lt;&gt;` and the `'.'` is found at position `0`, hey! `0` compares equal to `FALSE` and you lose. This will cause you to point a production website at a development database over the weekend, causing no end of joy when you return monday.  

#### Answer 2 (score 65)
You can use these string functions,  

<a href="http://www.php.net/manual/en/function.strstr.php" rel="noreferrer">strstr</a> — Find the first occurrence of a string  

<a href="http://www.php.net/manual/en/function.stristr.php" rel="noreferrer">stristr</a> — Case-insensitive strstr()  

<a href="http://www.php.net/manual/en/function.strrchr.php" rel="noreferrer">strrchr</a> — Find the last occurrence of a character in a string  

<a href="http://www.php.net/manual/en/function.strpos.php" rel="noreferrer">strpos</a> — Find the position of the first occurrence of a substring in a string  

<a href="http://www.php.net/manual/en/function.strpbrk.php" rel="noreferrer">strpbrk</a> — Search a string for any of a set of characters  

If that doesn't help then you should use `preg` regular expression  

<a href="http://www.php.net/manual/en/function.preg-match.php" rel="noreferrer">preg_match</a> — Perform a regular expression match  

#### Answer 3 (score 7)
You can use  `stristr()` or `strpos()`. Both <em>return false</em> if nothing is found.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: Regular Expression to match every new line character (\n) inside a <content> tag (score [350198](https://stackoverflow.com/q/1117807) in 2015)

#### Question
I'm looking for a regular expression to match every new line character (`\n`) inside a XML tag which is `&lt;content&gt;`, or inside any tag which is inside that `&lt;content&gt;` tag, for example :  

```perl
<blog>
<text>
(Do NOT match new lines here)
</text>
<content>
(DO match new lines here)
<p>
(Do match new lines here)
</p>
</content>
(Do NOT match new lines here)
<content>
(DO match new lines here)
</content>
```

#### Answer accepted (score 73)
Actually... you can't use a simple regex here, at least not one. You probably need to worry about comments! Someone may write:  

```perl
<!-- <content> blah </content> -->
```

You can take two approaches here:  

<ol>
<li>Strip all comments out first. Then use the regex approach.</li>
<li>Do not use regular expressions and use a context sensitive parsing approach that can keep track of whether or not you are nested in a comment.</li>
</ol>

Be careful.  

I am also not so sure you can match all new lines at once. @Quartz suggested this one:  

```perl
<content>([^\n]*\n+)+</content>
```

This will match any content tags that have a newline character RIGHT BEFORE the closing tag... but I'm not sure what you mean by matching <em>all</em> newlines. Do you want to be able to access all the matched newline characters? If so, your best bet is to grab all content tags, and then search for all the newline chars that are nested in between. Something more like this:  

```perl
<content>.*</content>
```

BUT THERE IS ONE CAVEAT: regexes are greedy, so this regex will match the first opening tag to the last closing one. Instead, you HAVE to suppress the regex so it is not greedy. In languages like python, you can do this with the "?" regex symbol.  

I hope with this you can see some of the pitfalls and figure out how you want to proceed. You are probably better off using an XML parsing library, then iterating over all the content tags.  

I know I may not be offering the best solution, but at least I hope you will see the difficulty in this and why other answers may not be right...  

<strong>UPDATE 1:</strong>  

Let me summarize a bit more and add some more detail to my response. I am going to use python's regex syntax because it is what I am more used to (forgive me ahead of time... you may need to escape some characters... comment on my post and I will correct it):  

<p>To strip out comments, use this regex:
    
Notice the "?" suppresses the .* to make it non-greedy.</p>

<p>Similarly, to search for content tags, use:
    .*?</p>

Also, You may be able to try this out, and access each newline character with the match objects groups():  

```perl
<content>(.*?(\n))+.*?</content>
```

I know my escaping is off, but it captures the idea. This last example probably won't work, but I think it's your best bet at expressing what you want. My suggestion remains: either grab all the content tags and do it yourself, or use a parsing library.  

<strong>UPDATE 2:</strong>  

So here is python code that ought to work. I am still unsure what you mean by "find" all newlines. Do you want the entire lines? Or just to count how many newlines. To get the actual lines, try:  

```perl
#!/usr/bin/python

import re

def FindContentNewlines(xml_text):
    # May want to compile these regexes elsewhere, but I do it here for brevity
    comments = re.compile(r"<!--.*?-->", re.DOTALL)
    content = re.compile(r"<content>(.*?)</content>", re.DOTALL)
    newlines = re.compile(r"^(.*?)$", re.MULTILINE|re.DOTALL)

    # strip comments: this actually may not be reliable for "nested comments"
    # How does xml handle <!--  <!-- --> -->. I am not sure. But that COULD
    # be trouble.
    xml_text = re.sub(comments, "", xml_text)

    result = []
    all_contents = re.findall(content, xml_text)
    for c in all_contents:
        result.extend(re.findall(newlines, c))

    return result

if __name__ == "__main__":
    example = """

<!-- This stuff
ought to be omitted
<content>
  omitted
</content>
-->

This stuff is good
<content>
<p>
  haha!
</p>
</content>

This is not found
"""
    print FindContentNewlines(example)
```

This program prints the result:  

```perl
 ['', '<p>', '  haha!', '</p>', '']
```

The first and last empty strings come from the newline chars immediately preceeding the first `&lt;p&gt;` and the one coming right after the `&lt;/p&gt;`. All in all this (for the most part) does the trick. Experiment with this code and refine it for your needs. Print out stuff in the middle so you can see what the regexes are matching and not matching.  

Hope this helps :-).  

PS - I didn't have much luck trying out my regex from my first update to capture all the newlines... let me know if you do.  

#### Answer 2 (score 4)
```perl
<content>(?:[^\n]*(\n+))+</content>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: RegEx for Javascript to allow only alphanumeric (score [349473](https://stackoverflow.com/q/388996) in 2015)

#### Question
I need to find a reg ex that only allows alphanumeric. So far, everyone I try only works if the string is alphanumeric, meaning contains both a letter and a number. I just want one what would allow either and not require both.  

#### Answer accepted (score 450)
```perl
/^[a-z0-9]+$/i

^         Start of string
[a-z0-9]  a or b or c or ... z or 0 or 1 or ... 9
+         one or more times (change to * to allow empty string)
$         end of string    
/i        case-insensitive
```

#### Answer 2 (score 137)
If you wanted to return a replaced result, then this would work:  

```perl
var a = 'Test123*** TEST';
var b = a.replace(/[^a-z0-9]/gi,'');
console.log(b);
```

This would return:  

```perl
Test123TEST
```

Note that the gi is necessary because it means global (not just on the first match), and case-insensitive, which is why I have a-z instead of a-zA-Z. And the ^ inside the brackets means "anything not in these brackets".  

WARNING: Alphanumeric is great if that's exactly what you want. But if you're using this in an international market on like a person's name or geographical area, then you need to account for unicode characters, which this won't do. For instance, if you have a name like "Âlvarö", it would make it "lvar".  

#### Answer 3 (score 77)
Use the word character class. The following is equivalent to a `^[a-zA-Z0-9_]+$`:  

```perl
^\w+$
```

Explanation:  

<ul>
<li>^ start of string</li>
<li>\w any word character (A-Z, a-z, 0-9, _).</li>
<li>$ end of string</li>
</ul>

Use `/[^\w]|_/g` if you don't want to match the underscore.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: Validate phone number with JavaScript (score [347886](https://stackoverflow.com/q/4338267) in 2011)

#### Question
<p>I found this code in some website, and it works perfectly. It validates that the phone number is in one of these formats:<br>
<strong>(123) 456-7890</strong> or <strong>123-456-7890</strong>  </p>

The problem is that my client (I don't know why, maybe client stuffs) wants to add another format, the ten numbers consecutively, something like this: <strong>1234567890</strong>.  

I'm using this regular expression,  

```perl
/^(\()?\d{3}(\))?(-|\s)?\d{3}(-|\s)\d{4}$/
```

How can I add that it also validates the another format? I'm not good with regular expressions.    

#### Answer accepted (score 107)
First off, your format validator is obviously only appropriate for <a href="http://en.wikipedia.org/wiki/North_American_Numbering_Plan" rel="noreferrer">NANP</a> (country code +1) numbers.  Will your application be used by someone with a phone number from outside North America?  If so, you don't want to prevent those people from entering a perfectly valid [international] number.  

Secondly, your validation is incorrect.  NANP numbers take the form `NXX NXX XXXX` where `N` is a digit 2-9 and `X` is a digit 0-9.  Additionally, area codes and exchanges may not take the form `N11` (end with two ones) to avoid confusion with special services <em>except</em> numbers in a non-geographic area code (800, 888, 877, 866, 855, 900) may have a `N11` exchange.  

So, your regex will pass the number (123) 123 4566 even though that is not a valid phone number.  You can fix that by replacing `\d{3}` with `[2-9]{1}\d{2}`.  

Finally, I get the feeling you're validating user input in a web browser.  Remember that client-side validation is <a href="https://stackoverflow.com/questions/1726617/form-validation-with-javascript-vs-php">only a <strong>convenience</strong> you provide to the user</a>; you still need to validate all input (again) on the server.  

<strong>TL;DR</strong> don't use a regular expression to <a href="https://stackoverflow.com/a/5059082/1269037">validate complex real-world data like phone numbers</a> or <a href="https://stackoverflow.com/questions/37684/how-to-replace-plain-urls-with-links/21925491#21925491">URLs</a>. Use a <a href="https://github.com/googlei18n/libphonenumber" rel="noreferrer">specialized library</a>.  

#### Answer 2 (score 119)
My regex of choice is:  

```perl
/^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im
```

Valid formats:  

<p><strong>(123) 456-7890</strong><br>
<strong>(123)456-7890</strong><br>
<strong>123-456-7890</strong><br>
<strong>123.456.7890</strong><br>
<strong>1234567890</strong><br>
<strong>+31636363634</strong><br>
<strong>075-63546725</strong>  </p>

#### Answer 3 (score 58)
If you are looking for 10 and only 10 digits, ignore everything but the digits-  

```perl
   return value.match(/\d/g).length===10;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: JavaScript Regular Expression Email Validation (score [329940](https://stackoverflow.com/q/940577) in 2018)

#### Question
This code is always alerting out `"null"`, which means that the string does not match the expression.  

```perl
var pattern = "^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$"; 

function isEmailAddress(str) {

    str = "azamsharp@gmail.com";      

    alert(str.match(pattern)); 
    return str.match(pattern);    

}
```

#### Answer accepted (score 73)
If you define your regular expression as a string then all backslashes need to be escaped, so instead of '\w' you should have '\\w'.  

Alternatively, define it as a regular expression:  

```perl
var pattern = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/; 
```

<hr>

BTW, please don't validate email addresses on the client-side. Your regular expression is way too simple to pass for a solid implementation anyway.  

See the real thing here: <strong><a href="http://www.ex-parrot.com/~pdw/Mail-RFC822-Address.html" rel="noreferrer">http://www.ex-parrot.com/~pdw/Mail-RFC822-Address.html</a></strong>  

#### Answer 2 (score 27)
this is the one i am using on my page.  

<a href="http://www.zparacha.com/validate-email-address-using-javascript-regular-expression/" rel="noreferrer">http://www.zparacha.com/validate-email-address-using-javascript-regular-expression/</a>  

`/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/`  

#### Answer 3 (score 14)
I've been using this function for a while. it returns a boolean value.  

```perl
// Validates email address of course.
function validEmail(e) {
    var filter = /^\s*[\w\-\+_]+(\.[\w\-\+_]+)*\@[\w\-\+_]+\.[\w\-\+_]+(\.[\w\-\+_]+)*\s*$/;
    return String(e).search (filter) != -1;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: How do I remove all non alphanumeric characters from a string except dash? (score [329647](https://stackoverflow.com/q/3210393) in 2014)

#### Question
How do I remove all non alphanumeric characters from a string except dash and space characters?  

#### Answer accepted (score 808)
Replace `[^a-zA-Z0-9 -]` with an empty string.  

```perl
Regex rgx = new Regex("[^a-zA-Z0-9 -]");
str = rgx.Replace(str, "");
```

#### Answer 2 (score 338)
I could have used RegEx, they can provide elegant solution but they can cause performane issues. Here is one solution  

```perl
char[] arr = str.ToCharArray();

arr = Array.FindAll<char>(arr, (c => (char.IsLetterOrDigit(c) 
                                  || char.IsWhiteSpace(c) 
                                  || c == '-')));
str = new string(arr);
```

<hr>

When using the compact framework (which doesn't have FindAll)  

Replace FindAll with<sup>1</sup>  

```perl
char[] arr = str.Where(c => (char.IsLetterOrDigit(c) || 
                             char.IsWhiteSpace(c) || 
                             c == '-')).ToArray(); 

str = new string(arr);
```

<hr>

<sup>1</sup> <a href="https://stackoverflow.com/questions/3210393/how-do-i-remove-all-non-alphanumeric-characters-from-a-string-except-dash/3210462#comment20263933_3210462">Comment by ShawnFeatherly</a>  

#### Answer 3 (score 43)
You can try:  

```perl
   string s1= Regex.Replace(s,"[^A-Za-z0-9 _]","");
```

Where `s` is your string.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: Regular Expression to match string starting with "stop" (score [329414](https://stackoverflow.com/q/1240504) in 2011)

#### Question
How do I create a regular expression to match a word at the beginning of a string.  We are looking to match `stop` at the beginning of a string and anything can follow it.  

For example the expression should match:  

```perl
stop
stop random
stopping
```

Thanks.  

#### Answer 2 (score 158)
If you wish to match only lines beginning with stop use  

```perl
^stop
```

If you wish to match lines beginning with the word stop followed by a space  

```perl
^stop\s
```

Or, if you wish to match lines beginning with the word stop but followed by either a space or any other non word character you can use (your regex flavor permitting)  

```perl
^stop\W
```

On the other hand, what follows matches a word at the beginning of a string on most regex flavors (in these flavors \w matches the opposite of \W)  

```perl
^\w
```

If your flavor does not have the \w shortcut, you can use  

```perl
^[a-zA-Z0-9]+
```

Be wary that this second idiom will only match letters and numbers, no symbol whatsoever.  

Check your regex flavor manual to know what shortcuts are allowed and what exactly do they match (and how do they deal with Unicode.)  

#### Answer 3 (score 70)
Try this:  

```perl
/^stop.*$/
```

Explanation:  

<ul>
<li><strong>/</strong> charachters delimit the regular expression (i.e. they are not part of the Regex per se)</li>
<li><strong>^</strong> means match at the beginning of the line</li>
<li><strong>.</strong> followed by <strong>*</strong> means match any character (.), any number of times (*)</li>
<li><strong>$</strong> means to the end of the line</li>
</ul>

If you would like to enforce that stop be followed by a whitespace, you could modify the RegEx like so:  

```perl
/^stop\s+.*$/
```

<ul>
<li><strong>\s</strong> means any whitespace character</li>
<li><strong>+</strong> following the <strong>\s</strong> means there has to be at least one whitespace character following after the stop word</li>
</ul>

Note: Also keep in mind that the RegEx above requires that the stop word be followed by a space! So it wouldn't match a line that only contains: <em>stop</em>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Regular Expression to match only alphabetic characters (score [329002](https://stackoverflow.com/q/6067592) in 2011)

#### Question
I was wondering If i could get a regular expression which will match a string that only has alpahabetic characters, and that alone  

#### Answer accepted (score 161)
You may use any of these 2 variants:  

```perl
/^[A-Z]+$/i
/^[A-Za-z]+$/
```

to match an input string of ASCII alphabets.  

<ul>
<li>`[A-Za-z]` will match all the alphabets (both lowercase and uppercase).</li>
<li>`^` and `$` will make sure that nothing but these alphabets will be matched.</li>
</ul>

<strong>Code:</strong>  

```perl
preg_match('/^[A-Z]+$/i', "abcAbc^Xyz", $m);
var_dump($m);
```

<strong>Output:</strong>  

```perl
array(0) {
}
```

<strong>Test case</strong> is for OP's comment that he wants to match <strong>only if</strong> there are 1 or more alphabets present in input. As you can see in test case that match failed because there was `^` in the input string `abcAbc^Xyz`.   

<strong>Note:</strong> Please note that above answer <em>only matches ASCII alphabets</em> and doesn't match Unicode characters. If you want to match unicode letters then use:  

```perl
/^\p{L}+$/u
```

#### Answer 2 (score 49)
If you need to include non-ASCII alphabetic characters, and if your regex flavor supports Unicode, then  

```perl
\A\pL+\z
```

would be the correct regex.  

Some regex engines don't support this Unicode syntax but allow the `\w` alphanumeric shorthand to also match non-ASCII characters. In that case, you can get all alphabetics by subtracting digits and underscores from `\w` like this:  

```perl
\A[^\W\d_]+\z
```

`\A` matches at the start of the string, `\z` at the end of the string (`^` and `$` also match at the start/end of lines in some languages like Ruby, or if certain regex options are set).  

#### Answer 3 (score 21)
This will match one or more alphabetical characters:  

```perl
/^[a-z]+$/
```

You can make it case insensitive using:  

```perl
/^[a-z]+$/i
```

or:  

```perl
/^[a-zA-Z]+$/
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Regular expression to match DNS hostname or IP Address? (score [322309](https://stackoverflow.com/q/106179) in 2014)

#### Question
Does anyone have a regular expression handy that will match any legal DNS hostname or IP address?  

It's easy to write one that works 95% of the time, but I'm hoping to get something that's well tested to exactly match the latest RFC specs for DNS hostnames.  

#### Answer accepted (score 518)
You can use the following regular expressions separately or by combining them in a joint OR expression.  

```perl
ValidIpAddressRegex = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$";

ValidHostnameRegex = "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$";
```

<strong>ValidIpAddressRegex</strong> matches valid IP addresses and <strong>ValidHostnameRegex</strong> valid host names. Depending on the language you use \ could have to be escaped with \.  

<hr>

<strong>ValidHostnameRegex</strong> is valid as per <a href="http://tools.ietf.org/html/rfc1123" rel="noreferrer">RFC 1123</a>. Originally, <a href="http://tools.ietf.org/html/rfc952" rel="noreferrer">RFC 952</a> specified that hostname segments could not start with a digit.  

<a href="http://en.wikipedia.org/wiki/Hostname" rel="noreferrer">http://en.wikipedia.org/wiki/Hostname</a>  

<blockquote>
  <p>The original specification of
  hostnames in <a href="http://tools.ietf.org/html/rfc952" rel="noreferrer">RFC
  952</a>,
  mandated that labels could not start
  with a digit or with a hyphen, and
  must not end with a hyphen. However, a
  subsequent specification (<a href="http://tools.ietf.org/html/rfc1123" rel="noreferrer">RFC
  1123</a>)
  permitted hostname labels to start
  with digits.</p>
</blockquote>

```perl
Valid952HostnameRegex = "^(([a-zA-Z]|[a-zA-Z][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$";
```

#### Answer 2 (score 61)
The hostname regex of <em>smink</em> does not observe the limitation on the length of individual labels within a hostname. <strong>Each label within a valid hostname may be no more than 63 octets long.</strong>  

<pre>ValidHostnameRegex="^([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])\
(\.([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]{0,61}[a-zA-Z0-9]))*$"</pre>

Note that the backslash at the end of the first line (above) is Unix shell syntax for splitting the long line. It's not a part of the regular expression itself.  

Here's just the regular expression alone on a single line:  

<pre>^([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])(\.([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]{0,61}[a-zA-Z0-9]))*$</pre>

You should also check separately that <strong>the total length of the hostname must not exceed 255 characters</strong>. For more information, please consult RFC-952 and RFC-1123.  

#### Answer 3 (score 31)
To match a valid <strong>IP address</strong> use the following regex:  

```perl
(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}
```

instead of:  

```perl
([01]?[0-9][0-9]?|2[0-4][0-9]|25[0-5])(\.([01]?[0-9][0-9]?|2[0-4][0-9]|25[0-5])){3}
```

<h5>Explanation</h3>

Many regex engine match the first possibility in the `OR` sequence. For instance, try the following regex:   

```perl
10.48.0.200
```

<h5>Test</h3>

Test the difference between <a href="http://regexr.com?37hh1" rel="noreferrer">good</a> vs <a href="http://regexr.com?37hh4" rel="noreferrer">bad</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: What regex will match every character except comma ',' or semi-colon ';'? (score [320135](https://stackoverflow.com/q/1409162) in 2009)

#### Question
Is it possible to define a regex which will match every character except a certain defined character or set of characters?  

Basically, I wanted to split a string by either comma (,) or semi-colon (;). So I was thinking of doing it with a regex which would match everything until it encountered a comma or a semi-colon.  

#### Answer accepted (score 418)
```perl
[^,;]+         
```

You haven't specified the regex implementation you are using. Most of them have a `Split` method that takes delimiters and split by them. You might want to use that one with a "normal" (without `^`) character class:  

```perl
[,;]+
```

#### Answer 2 (score 73)
Use character classes. A character class beginning with caret will match anything not in the class.  

```perl
[^,;]
```

#### Answer 3 (score 38)
use a <a href="https://www.regular-expressions.info/charclass.html#negated" rel="noreferrer">negative character class</a>:  

```perl
[^,;]+
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: How to escape regular expression special characters using javascript? (score [319153](https://stackoverflow.com/q/3115150) in 2011)

#### Question
I need to escape the regular expression special characters using java script.How can i achieve this?Any help should be appreciated.  

<hr>

Thanks for your quick reply.But i need to escape all the special characters of regular expression.I have try by this code,But i can't achieve the result.  

```perl
RegExp.escape=function(str)
            {
                if (!arguments.callee.sRE) {
                    var specials = [
                        '/', '.', '*', '+', '?', '|',
                        '(', ')', '[', ']', '{', '}', '\\'
                    ];
                    arguments.callee.sRE = new RegExp(
                    '(\\' + specials.join('|\\') + ')', 'gim'
                );
                }
                return str.replace(arguments.callee.sRE, '\\$1');

            }

function regExpFind() {
            <%--var regex = new RegExp("\\[munees\\]","gim");--%>
                    var regex= new RegExp(RegExp.escape("[Munees]waran"));
                    <%--var regex=RegExp.escape`enter code here`("[Munees]waran");--%>
                    alert("Reg : "+regex);
                }
```

What i am wrong with this code?Please guide me.  

#### Answer 2 (score 380)
Use the `\` character to escape a character that has special meaning inside a regular expression.  

To automate it, you could use this:  

```perl
function escapeRegExp(text) {
  return text.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, '\\$&');
}
```

<strong>Update:</strong> There is now a proposal to standardize this method, possibly in ES2016: <a href="https://github.com/benjamingr/RegExp.escape" rel="noreferrer">https://github.com/benjamingr/RegExp.escape</a>  

<strong>Update</strong>: The abovementioned proposal was rejected, so keep implementing this yourself if you need it.  

#### Answer 3 (score 14)
Use the backslash to escape a character. For example:  

```perl
/\\d/
```

This will match \d instead of a numeric character  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: Regular expression to get a string between two strings in Javascript (score [316875](https://stackoverflow.com/q/5642315) in 2019)

#### Question
I have found very similar posts, but I can't quite get my regular expression right here.  

I am trying to write a regular expression which returns a string which is between two other strings. For example: I want to get the string which resides between the strings "cow" and "milk".  

<blockquote>
  My cow always gives milk  
</blockquote>

would return  

<blockquote>
  "always gives"  
</blockquote>

Here is the expression I have pieced together so far:  

```perl
(?=cow).*(?=milk)
```

However, this returns the string "cow always gives".  

#### Answer accepted (score 156)
A lookahead (that `(?=` part) does not consume any input. It is a <em>zero-width assertion</em> (as are boundary checks and lookbehinds).  

You want a regular match here, to consume the `cow` portion. To capture the portion in between, you use a capturing group (just put the portion of pattern you want to capture inside parenthesis):  



```perl
cow(.*)milk
```

No lookaheads are needed at all.  

#### Answer 2 (score 57)
<blockquote>
  Regular expression to get a string between two strings in JavaScript  
</blockquote>

The most complete solution that will work in the vast majority of cases is using a <strong>capturing group</strong> with a <strong>lazy dot matching pattern</strong>. However, a dot `.` in JavaScript regex does not match line break characters, so, what will work in 100% cases is a `[^]` or `[\s\S]`/`[\d\D]`/`[\w\W]` constructs.  

<h5>ECMAScript 2018 and newer compatible solution</h2>

In JavaScript environments supporting <em>ECMAScript 2018</em>, `s` modifier allows `.` to match any char including line break chars, and the regex engine supports lookbehinds of variable length. So, you may use a regex like  

```perl
var result = s.match(/(?<=cow\s+).*?(?=\s+milk)/gs); // Returns multiple matches if any
// Or
var result = s.match(/(?<=cow\s*).*?(?=\s*milk)/gs); // Same but whitespaces are optional
```

In both cases, the current position is checked for `cow` with any 1/0 or more whitespaces after `cow`, then any 0+ chars as few as possible are matched and consumed (=added to the match value), and then `milk` is checked for (with any 1/0 or more whitespaces before this substring).  

<h5>Scenario 1: Single-line input</h2>

<strong><em>This and all other scenarios below are supported by all JavaScript environments. See usage examples at the bottom of the answer.</em></strong>  

```perl
cow (.*?) milk
```

`cow` is found first, then a space, then any 0+ chars other than line break chars, as few as possible as `*?` is a lazy quantifier, are captured into Group 1 and then a space with `milk` must follow (and those are matched and <em>consumed</em>, too).  

<h5>Scenario 2: Multiline input</h2>

```perl
cow ([\s\S]*?) milk
```

Here, `cow` and a space are matched first, then any 0+ chars as few as possible are matched and captured into Group 1, and then a space with `milk` are matched.  

<h5>Scenario 3: Overlapping matches</h2>

If you have  a string like `&gt;&gt;&gt;15 text&gt;&gt;&gt;67 text2&gt;&gt;&gt;` and you need to get 2 matches in-between `&gt;&gt;&gt;`+`number`+`whitespace` and `&gt;&gt;&gt;`, you can't use <a href="https://regex101.com/r/Vtw7W1/2" rel="nofollow noreferrer">`/&gt;&gt;&gt;\d+\s(.*?)&gt;&gt;&gt;/g`</a> as this will only find 1 match due to the fact the `&gt;&gt;&gt;` before `67` is already <em>consumed</em> upon finding the first match. You may use a <a href="http://www.regular-expressions.info/lookaround.html" rel="nofollow noreferrer"><strong>positive lookahead</strong></a> to check for the text presence without actually "gobbling" it (i.e. appending to the match):  

```perl
/>>>\d+\s(.*?)(?=>>>)/g
```

See the <a href="https://regex101.com/r/Vtw7W1/3" rel="nofollow noreferrer">online regex demo</a> yielding `text1` and `text2` as Group 1 contents found.  

Also see <a href="https://stackoverflow.com/questions/18029487/how-to-get-all-possible-overlapping-matches-for-a-string"><em>How to get all possible overlapping matches for a string</em></a>.  

<h5>Performance considerations</h2>

Lazy dot matching pattern (`.*?`) inside regex patterns may slow down script execution if very long input is given. In many cases, <a href="http://www.softec.lu/site/RegularExpressions/UnrollingTheLoop" rel="nofollow noreferrer"><em>unroll-the-loop technique</em></a> helps to a greater extent. Trying to grab all between `cow` and `milk` from `"Their\ncow\ngives\nmore\nmilk"`, we see that we just need to match all lines that do not start with `milk`, thus, instead of <a href="https://regex101.com/r/e1W8DA/1" rel="nofollow noreferrer">`cow\n([\s\S]*?)\nmilk`</a> we can use:  

```perl
/cow\n(.*(?:\n(?!milk$).*)*)\nmilk/gm
```

See the <a href="https://regex101.com/r/4xWB0S/2" rel="nofollow noreferrer">regex demo</a> (if there can be `\r\n`, use `/cow\r?\n(.*(?:\r?\n(?!milk$).*)*)\r?\nmilk/gm`). With this small test string, the performance gain is negligible, but with very large text, you will feel the difference (especially if the lines are long and line breaks are not very numerous).  

<blockquote>
  <h5>Sample regex usage in JavaScript:</h3>
  
  <p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
//Single/First match expected: use no global modifier and access match[1]
console.log("My cow always gives milk".match(/cow (.*?) milk/)[1]);
// Multiple matches: get multiple matches with a global modifier and
// trim the results if length of leading/trailing delimiters is known
var s = "My cow always gives milk, thier cow also gives milk";
console.log(s.match(/cow (.*?) milk/g).map(function(x) {return x.substr(4,x.length-9);}));
//or use RegExp#exec inside a loop to collect all the Group 1 contents
var result = [], m, rx = /cow (.*?) milk/g;
while ((m=rx.exec(s)) !== null) {
  result.push(m[1]);
}
console.log(result);
```
</div>
</div>

</blockquote>

#### Answer 3 (score 50)
Here's a regex which will grab what's between cow and milk (without leading/trailing space):  

```perl
srctext = "My cow always gives milk.";
var re = /(.*cow\s+)(.*)(\s+milk.*)/;
var newtext = srctext.replace(re, "$2");
```

An example: <a href="http://jsfiddle.net/entropo/tkP74/" rel="noreferrer">http://jsfiddle.net/entropo/tkP74/</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Use String.split() with multiple delimiters (score [313325](https://stackoverflow.com/q/5993779) in 2017)

#### Question
I need to split a string base on delimiter `-` and `.`. Below are my desired output.   

`AA.BB-CC-DD.zip` ->   

```perl
AA
BB
CC
DD
zip 
```

but my following code does not work.  

```perl
private void getId(String pdfName){
    String[]tokens = pdfName.split("-\\.");
}
```

#### Answer accepted (score 296)
I think you need to include the regex <strong>OR operator</strong>:  

```perl
String[]tokens = pdfName.split("-|\\.");
```

<p>What you have will match:<br>
[DASH followed by DOT together] `-.`<br>
not<br>
[DASH or DOT any of them]  `-` or `.`</p>

#### Answer 2 (score 48)
Try this regex `"[-.]+"`. The + after treats consecutive delimiter chars as one. Remove plus if you do not want this.  

#### Answer 3 (score 25)
You can use the regex "\W".This matches any non-word character.The required line would be:  

```perl
String[] tokens=pdfName.split("\\W");
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: Regular expression to match balanced parentheses (score [312134](https://stackoverflow.com/q/546433) in 2019)

#### Question
I need a regular expression to select all the text between two outer brackets.  

Example: `some text(text here(possible text)text(possible text(more text)))end text`  

Result: `(text here(possible text)text(possible text(more text)))`  

#### Answer accepted (score 126)
Regular expressions are the wrong tool for the job because you are dealing with nested structures, i.e. recursion.  

But there is a simple algorithm to do this, which I described <a href="https://stackoverflow.com/questions/524548/regular-expression-to-detect-semi-colon-terminated-c-for-while-loops/524624#524624">in this answer</a> to a <a href="https://stackoverflow.com/questions/524548/regular-expression-to-detect-semi-colon-terminated-c-for-while-loops">previous question</a>.   

#### Answer 2 (score 108)
You can use <a href="http://www.regular-expressions.info/recurse.html#balanced" rel="noreferrer">regex recursion</a>:  

```perl
\(([^()]|(?R))*\)
```

#### Answer 3 (score 101)
I want to add this answer for quickreference. Feel free to update.  

<hr>

<strong>.NET Regex</strong> using <a href="http://www.regular-expressions.info/balancing.html" rel="noreferrer">balancing groups</a>.  

```perl
\((?>\((?<c>)|[^()]+|\)(?<-c>))*(?(c)(?!))\)
```

Where `c` is used as the depth counter.  

<a href="http://regexstorm.net/tester?p=%5C((%3F%3E%5C((%3F%3Cc%3E)%7C%5B%5E()%5D%2B%7C%5C)(%3F%3C-c%3E))*(%3F(c)(%3F!))%5C)&amp;i=some%20text(text%20here(possible%20text)text(possible%20text(more%20text)))end%20text" rel="noreferrer">Demo at Regexstorm.com</a>  

<ul>
<li><a href="https://stackoverflow.com/questions/7898310/using-regex-to-balance-match-parenthesis"><strong>Stack Overflow</strong>: Using RegEx to balance match parenthesis</a></li>
<li><a href="http://weblogs.asp.net/whaggard/377025" rel="noreferrer"><strong>Wes' Puzzling Blog</strong>: Matching Balanced Constructs with .NET Regular Expressions</a></li>
<li><a href="http://www.rassoc.com/gregr/weblog/2003/05/15/nested-constructs-in-regular-expressions/" rel="noreferrer"><strong>Greg Reinacker's Weblog</strong>: Nested Constructs in Regular Expressions</a></li>
</ul>

<hr>

<strong>PCRE</strong> using a <a href="http://php.net/manual/en/regexp.reference.recursive.php" rel="noreferrer">recursive pattern</a>.  

```perl
\((?:[^)(]+|(?R))*+\)
```

<a href="https://regex101.com/r/eBtSTM/1" rel="noreferrer">Demo at regex101</a>; Or without alternation:  

```perl
\((?:[^)(]*(?R)?)*+\)
```

<a href="https://regex101.com/r/eBtSTM/2" rel="noreferrer">Demo at regex101</a>; Or <a href="http://www.softec.lu/site/RegularExpressions/UnrollingTheLoop" rel="noreferrer">unrolled</a> for performance:  

```perl
\([^)(]*+(?:(?R)[^)(]*)*+\)
```

<a href="https://regex101.com/r/eBtSTM/3" rel="noreferrer">Demo at regex101</a>; The pattern is pasted at `(?R)` which represents `(?0)`.  

<em>Perl, PHP, Notepad++,</em> <em>R</em>: <a href="http://www.regular-expressions.info/rlanguage.html" rel="noreferrer">perl=TRUE</a>, <em>Python</em>: <a href="https://pypi.python.org/pypi/regex" rel="noreferrer">Regex package</a> with `(?V1)` for Perl behaviour.  

<hr>

<strong>Ruby</strong> using <a href="http://ruby-doc.org/core-2.0.0/Regexp.html#class-Regexp-label-Subexpression+Calls" rel="noreferrer">subexpression calls</a>.  

With Ruby 2.0 `\g&lt;0&gt;` can be used to call full pattern.  

```perl
\((?>[^)(]+|\g<0>)*\)
```

<a href="http://rubular.com/r/RUDsEv7SBZ" rel="noreferrer">Demo at Rubular</a>; Ruby 1.9 only supports <a href="http://www.regular-expressions.info/subroutine.html" rel="noreferrer">capturing group recursion</a>:  

```perl
(\((?>[^)(]+|\g<1>)*\))
```

<a href="http://rubular.com/r/vuyejEfjih" rel="noreferrer">Demo at Rubular</a> &nbsp;(<a href="http://ruby-doc.org/core-1.9.3/Regexp.html#class-Regexp-label-Atomic+Grouping" rel="noreferrer">atomic grouping</a> since Ruby 1.9.3)  

<hr>

<strong>JavaScript</strong> &nbsp;<a href="http://xregexp.com/api/#matchRecursive" rel="noreferrer">API :: XRegExp.matchRecursive</a>  

```perl
XRegExp.matchRecursive(str, '\\(', '\\)', 'g');
```

JS, Java and other regex flavors without recursion up to 2 levels of nesting:  

```perl
\((?:[^)(]+|\((?:[^)(]+|\([^)(]*\))*\))*\)
```

<p><a href="https://regex101.com/r/eE6mX3/1" rel="noreferrer">Demo at regex101</a>. Deeper <a href="https://stackoverflow.com/a/17759264">nesting needs to be added</a> to pattern.<br>
To fail faster on unbalanced parenthesis <a href="https://regex101.com/r/cU7uG9/1" rel="noreferrer">drop the `+` quantifier.</a></p>

<hr>

<strong>Java</strong>: An interesting <a href="https://stackoverflow.com/a/47162099/5527985">idea using forward references by @jaytea</a>.  

<hr>

<sub><a href="https://stackoverflow.com/a/22944075/5527985">Reference - What does this regex mean?</a></sub><br>  

<ul>
<li><a href="http://www.rexegg.com/regex-recursion.html" rel="noreferrer"><strong>rexegg.com</strong> - Recursive Regular Expressions</a></li>
<li><a href="http://www.regular-expressions.info/recurse.html" rel="noreferrer"><strong>Regular-Expressions.info</strong> - Regular Expression Recursion</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: RegEx: Grabbing values between quotation marks (score [309597](https://stackoverflow.com/q/171480) in 2014)

#### Question
I have a value like this:  

```perl
"Foo Bar" "Another Value" something else
```

What regex will return the values enclosed in the quotation marks (e.g. `Foo Bar` and `Another Value`)?  

#### Answer accepted (score 315)
I've been using the following with great success:  

```perl
(["'])(?:(?=(\\?))\2.)*?\1
```

It supports nested quotes as well.  

For those who want a deeper explanation of how this works, here's an explanation from user <a href="https://stackoverflow.com/users/20713/ephemient">ephemient</a>:  

<blockquote>
  `([""'])` match a quote; `((?=(\\?))\2.)` if backslash exists, gobble it, and whether or not that happens, match a character; `*?` match many times (non-greedily, as to not eat the closing quote); `\1` match the same quote that was use for opening.  
</blockquote>

#### Answer 2 (score 291)
In general, the following regular expression fragment is what you are looking for:  

```perl
"(.*?)"
```

This uses the non-greedy *? operator to capture everything up to but not including the next double quote. Then, you use a language-specific mechanism to extract the matched text.  

In Python, you could do:  

```perl
>>> import re
>>> string = '"Foo Bar" "Another Value"'
>>> print re.findall(r'"(.*?)"', string)
['Foo Bar', 'Another Value']
```

#### Answer 3 (score 80)
I would go for:  

```perl
"([^"]*)"
```

<p>The <b>[^"]</b> is regex for any character except '<b>"</b>'<br>
The reason I use this over the non greedy many operator is that I have to keep looking that up just to make sure I get it correct.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: How do I extract text that lies between parentheses (round brackets)? (score [307895](https://stackoverflow.com/q/378415) in 2015)

#### Question
I have a string `User name (sales)` and I want to extract the text between the brackets, how would I do this?   

I suspect sub-string but I can't work out how to read until the closing bracket, the length of text will vary.  

#### Answer 2 (score 419)
A very simple way to do it is by using regular expressions:  

```perl
Regex.Match("User name (sales)", @"\(([^)]*)\)").Groups[1].Value
```

<hr>

As a response to the (very funny) comment, here's the same Regex with some explanation:  

```perl
\(             # Escaped parenthesis, means "starts with a '(' character"
    (          # Parentheses in a regex mean "put (capture) the stuff 
               #     in between into the Groups array" 
       [^)]    # Any character that is not a ')' character
       *       # Zero or more occurrences of the aforementioned "non ')' char"
    )          # Close the capturing group
\)             # "Ends with a ')' character"
```

#### Answer 3 (score 415)
If you wish to stay away from regular expressions, the simplest way I can think of is:  

```perl
string input = "User name (sales)";
string output = input.Split('(', ')')[1];
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: jQuery validate: How to add a rule for regular expression validation? (score [305989](https://stackoverflow.com/q/280759) in 2017)

#### Question
I am using the <strong><a href="http://en.wikipedia.org/wiki/JQuery" rel="noreferrer">jQuery</a> validation plugin</strong>. Great stuff! I want to migrate my existing ASP.NET solution to use jQuery instead of the ASP.NET validators. I am missing a replacement for the <strong>regular expression</strong> validator. I want to be able to do something like this:  

```perl
$("Textbox").rules("add", { regularExpression: "^[a-zA-Z'.\s]{1,40}$" })
```

How do I <strong>add a custom rule</strong> to achieve this?  

#### Answer accepted (score 317)
Thanks to the answer of redsquare I added a method like this:  

```perl
$.validator.addMethod(
        "regex",
        function(value, element, regexp) {
            var re = new RegExp(regexp);
            return this.optional(element) || re.test(value);
        },
        "Please check your input."
);
```

now all you need to do to validate against any regex is this:  

```perl
$("#Textbox").rules("add", { regex: "^[a-zA-Z'.\\s]{1,40}$" })
```

Additionally, it looks like there is a file called additional-methods.js that contains the method "pattern", which can be a RegExp when created using the method without quotes.  

<a href="http://bassistance.de/jquery-plugins/jquery-plugin-validation/" rel="noreferrer">http://bassistance.de/jquery-plugins/jquery-plugin-validation/</a>  

<a href="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/additional-methods.js" rel="noreferrer">http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/additional-methods.js</a>  

#### Answer 2 (score 78)
You can use the addMethod()  

e.g   

```perl
$.validator.addMethod('postalCode', function (value) { 
    return /^((\d{5}-\d{4})|(\d{5})|([A-Z]\d[A-Z]\s\d[A-Z]\d))$/.test(value); 
}, 'Please enter a valid US or Canadian postal code.');
```

good article here <a href="https://web.archive.org/web/20130609222116/http://www.randallmorey.com/blog/2008/mar/16/extending-jquery-form-validation-plugin/" rel="noreferrer">https://web.archive.org/web/20130609222116/http://www.randallmorey.com/blog/2008/mar/16/extending-jquery-form-validation-plugin/</a>  

#### Answer 3 (score 43)
I had some trouble putting together all the pieces for doing a jQuery regular expression validator, but I got it to work... Here is a complete working example. It uses the 'Validation' plugin which can be found in <em><a href="http://bassistance.de/jquery-plugins/jquery-plugin-validation/" rel="noreferrer">jQuery Validation Plugin</a></em>  

```perl
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <script src="http://YOURJQUERYPATH/js/jquery.js" type="text/javascript"></script>
    <script src="http://YOURJQUERYPATH/js/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">

        $().ready(function() {
            $.validator.addMethod("EMAIL", function(value, element) {
                return this.optional(element) || /^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\.[a-zA-Z.]{2,5}$/i.test(value);
            }, "Email Address is invalid: Please enter a valid email address.");

            $.validator.addMethod("PASSWORD",function(value,element){
                return this.optional(element) || /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,16}$/i.test(value);
            },"Passwords are 8-16 characters with uppercase letters, lowercase letters and at least one number.");

            $.validator.addMethod("SUBMIT",function(value,element){
                return this.optional(element) || /[^ ]/i.test(value);
            },"You did not click the submit button.");

            // Validate signup form on keyup and submit
            $("#LOGIN").validate({
                rules: {
                    EMAIL: "required EMAIL",
                    PASSWORD: "required PASSWORD",
                    SUBMIT: "required SUBMIT",
                },
            });
        });
    </script>
</head>
<body>
    <div id="LOGIN_FORM" class="form">
        <form id="LOGIN" name="LOGIN" method="post" action="/index/secure/authentication?action=login">
            <h1>Log In</h1>
            <div id="LOGIN_EMAIL">
                <label for="EMAIL">Email Address</label>
                <input id="EMAIL" name="EMAIL" type="text" value="" tabindex="1" />
            </div>
            <div id="LOGIN_PASSWORD">
                <label for="PASSWORD">Password</label>
                <input id="PASSWORD" name="PASSWORD" type="password" value="" tabindex="2" />
            </div>
            <div id="LOGIN_SUBMIT">
                <input id="SUBMIT" name="SUBMIT" type="submit" value="Submit" tabindex="3" />
            </div>
        </form>
    </div>
</body>
</html>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Regular Expression to get a string between parentheses in Javascript (score [305791](https://stackoverflow.com/q/17779744) in 2018)

#### Question
I am trying to write a regular expression which returns a string which is between parentheses. For example: I want to get the string which resides between the strings "(" and ")"  

```perl
I expect five hundred dollars ($500).
```

would return  

```perl
$500
```

Found <a href="https://stackoverflow.com/questions/5642315/regular-expression-to-get-a-string-between-two-strings-in-javascript">Regular Expression to get a string between two strings in Javascript</a>  

But I'm new with regex. I don't know how to use '(', ')' in regexp  

#### Answer accepted (score 405)
You need to create a set of escaped (with `\`) parentheses (that match the parentheses) and a group of regular parentheses that create your capturing group:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```perl
var regExp = /\(([^)]+)\)/;
var matches = regExp.exec("I expect five hundred dollars ($500).");

//matches[1] contains the value between the parentheses
console.log(matches[1]);
```
</div>
</div>


Breakdown:  

<ul>
<li>`\(` : match an opening parentheses</li>
<li>`(` : begin capturing group</li>
<li>`[^)]+`: match one or more non `)` characters</li>
<li>`)` : end capturing group</li>
<li>`\)` : match closing parentheses</li>
</ul>

Here is a visual explanation on <a href="http://www.regexplained.co.uk/?pattern=%252F%5C((%5B%5E)%5D%252B)%5C)%252F" rel="noreferrer">RegExplained</a>  

#### Answer 2 (score 31)
Try string manipulation:  

```perl
var txt = "I expect five hundred dollars ($500). and new brackets ($600)";
var newTxt = txt.split('(');
for (var i = 1; i < newTxt.length; i++) {
    console.log(newTxt[i].split(')')[0]);
}
```

or regex (<em>which is somewhat <a href="http://jsperf.com/stringvsregex/">slow compare to the above</a></em>)  

```perl
var txt = "I expect five hundred dollars ($500). and new brackets ($600)";
var regExp = /\(([^)]+)\)/g;
var matches = txt.match(regExp);
for (var i = 0; i < matches.length; i++) {
    var str = matches[i];
    console.log(str.substring(1, str.length - 1));
}
```

#### Answer 3 (score 9)
Ported <a href="https://stackoverflow.com/a/17780281/942767">Mr_Green's answer</a> to a functional programming style to avoid use of temporary global variables.  

```perl
var matches = string2.split('[')
  .filter(function(v){ return v.indexOf(']') > -1})
  .map( function(value) { 
    return value.split(']')[0]
  })
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: How to extract img src, title and alt from html using php? (score [303789](https://stackoverflow.com/q/138313) in 2015)

#### Question
I would like to create a page where all images which reside on my website are listed with title and alternative representation.  

I already wrote me a little program to find and load all HTML files, but now I am stuck at how to extract `src`, `title` and `alt` from this HTML:  

```perl
<img <b>src</b>="/image/fluffybunny.jpg" <b>title</b>="Harvey the bunny" <b>alt</b>="a cute little fluffy bunny" />
```

I guess this should be done with some regex, but since the order of the tags may vary, and I need all of them, I don't really know how to parse this in an elegant way (I could do it the hard char by char way, but that's painful).  

#### Answer accepted (score 191)
<h5>EDIT : now that I know better</h2>

Using regexp to solve this kind of problem is <a href="https://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags/1732454#1732454">a bad idea</a> and will likely lead in unmaintainable and unreliable code. Better use an <a href="http://simplehtmldom.sourceforge.net/" rel="noreferrer">HTML parser</a>.   

<h5>Solution With regexp</h2>

In that case it's better to split the process into two parts :  

<ul>
<li>get all the img tag</li>
<li>extract their metadata</li>
</ul>

I will assume your doc is not xHTML strict so you can't use an XML parser. E.G. with this web page source code :  

```perl
/* preg_match_all match the regexp in all the $html string and output everything as 
an array in $result. "i" option is used to make it case insensitive */

preg_match_all('/<img[^>]+>/i',$html, $result); 

print_r($result);
Array
(
    [0] => Array
        (
            [0] => <img src="/Content/Img/stackoverflow-logo-250.png" width="250" height="70" alt="logo link to homepage" />
            [1] => <img class="vote-up" src="/content/img/vote-arrow-up.png" alt="vote up" title="This was helpful (click again to undo)" />
            [2] => <img class="vote-down" src="/content/img/vote-arrow-down.png" alt="vote down" title="This was not helpful (click again to undo)" />
            [3] => <img src="http://www.gravatar.com/avatar/df299babc56f0a79678e567e87a09c31?s=32&d=identicon&r=PG" height=32 width=32 alt="gravatar image" />
            [4] => <img class="vote-up" src="/content/img/vote-arrow-up.png" alt="vote up" title="This was helpful (click again to undo)" />

[...]
        )

)
```

Then we get all the img tag attributes with a loop :  

```perl
$img = array();
foreach( $result as $img_tag)
{
    preg_match_all('/(alt|title|src)=("[^"]*")/i',$img_tag, $img[$img_tag]);
}

print_r($img);

Array
(
    [<img src="/Content/Img/stackoverflow-logo-250.png" width="250" height="70" alt="logo link to homepage" />] => Array
        (
            [0] => Array
                (
                    [0] => src="/Content/Img/stackoverflow-logo-250.png"
                    [1] => alt="logo link to homepage"
                )

            [1] => Array
                (
                    [0] => src
                    [1] => alt
                )

            [2] => Array
                (
                    [0] => "/Content/Img/stackoverflow-logo-250.png"
                    [1] => "logo link to homepage"
                )

        )

    [<img class="vote-up" src="/content/img/vote-arrow-up.png" alt="vote up" title="This was helpful (click again to undo)" />] => Array
        (
            [0] => Array
                (
                    [0] => src="/content/img/vote-arrow-up.png"
                    [1] => alt="vote up"
                    [2] => title="This was helpful (click again to undo)"
                )

            [1] => Array
                (
                    [0] => src
                    [1] => alt
                    [2] => title
                )

            [2] => Array
                (
                    [0] => "/content/img/vote-arrow-up.png"
                    [1] => "vote up"
                    [2] => "This was helpful (click again to undo)"
                )

        )

    [<img class="vote-down" src="/content/img/vote-arrow-down.png" alt="vote down" title="This was not helpful (click again to undo)" />] => Array
        (
            [0] => Array
                (
                    [0] => src="/content/img/vote-arrow-down.png"
                    [1] => alt="vote down"
                    [2] => title="This was not helpful (click again to undo)"
                )

            [1] => Array
                (
                    [0] => src
                    [1] => alt
                    [2] => title
                )

            [2] => Array
                (
                    [0] => "/content/img/vote-arrow-down.png"
                    [1] => "vote down"
                    [2] => "This was not helpful (click again to undo)"
                )

        )

    [<img src="http://www.gravatar.com/avatar/df299babc56f0a79678e567e87a09c31?s=32&d=identicon&r=PG" height=32 width=32 alt="gravatar image" />] => Array
        (
            [0] => Array
                (
                    [0] => src="http://www.gravatar.com/avatar/df299babc56f0a79678e567e87a09c31?s=32&d=identicon&r=PG"
                    [1] => alt="gravatar image"
                )

            [1] => Array
                (
                    [0] => src
                    [1] => alt
                )

            [2] => Array
                (
                    [0] => "http://www.gravatar.com/avatar/df299babc56f0a79678e567e87a09c31?s=32&d=identicon&r=PG"
                    [1] => "gravatar image"
                )

        )

   [..]
        )

)
```

Regexps are CPU intensive so you may want to cache this page. If you have no cache system, you can tweak your own by using <a href="http://fr2.php.net/manual/fr/function.ob-start.php" rel="noreferrer">ob_start</a> and loading / saving from a text file.  

<h5>How does this stuff work ?</h2>

First, we use <a href="http://fr2.php.net/manual/fr/function.preg-match-all.php" rel="noreferrer">preg_ match_ all</a>, a function that gets every string matching the pattern and ouput it in it's third parameter.  

The regexps :  

```perl
<img[^>]+>
```

We apply it on all html web pages. It can be read as <em>every string that starts with "`&lt;img`", contains non ">" char and ends with a ></em>.  

```perl
(alt|title|src)=("[^"]*")
```

We apply it successively on each img tag. It can be read as <em>every string starting with "alt", "title" or "src", then a "=", then a ' " ', a bunch of stuff that are not ' " ' and ends with a ' " '. Isolate the sub-strings between ()</em>.   

Finally, every time you want to deal with regexps, it handy to have good tools to quickly test them. Check this <a href="http://regex.larsolavtorvik.com/" rel="noreferrer">online regexp tester</a>.  

EDIT : answer to the first comment.  

It's true that I did not think about the (hopefully few) people using single quotes.  

Well, if you use only ', just replace all the " by '.   

If you mix both. First you should slap yourself :-), then try to use ("|') instead or " and [^ø] to replace [^"].  

#### Answer 2 (score 243)
```perl
$url="http://example.com";

$html = file_get_contents($url);

$doc = new DOMDocument();
@$doc->loadHTML($html);

$tags = $doc->getElementsByTagName('img');

foreach ($tags as $tag) {
       echo $tag->getAttribute('src');
}
```

#### Answer 3 (score 64)
Just to give a small example of using PHP's XML functionality for the task:  

```perl
$doc=new DOMDocument();
$doc->loadHTML("<html><body>Test<br><img src=\"myimage.jpg\" title=\"title\" alt=\"alt\"></body></html>");
$xml=simplexml_import_dom($doc); // just to make xpath more simple
$images=$xml->xpath('//img');
foreach ($images as $img) {
    echo $img['src'] . ' ' . $img['alt'] . ' ' . $img['title'];
}
```

I did use the `DOMDocument::loadHTML()` method because this method can cope with HTML-syntax and does not force the input document to be XHTML. Strictly speaking the conversion to a `SimpleXMLElement` is not necessary - it just makes using xpath and the xpath results more simple.  

</section>

