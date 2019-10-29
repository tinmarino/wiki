---
title: Js <- StackOverflow top 100
category: js
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How do I remove a particular element from an array in JavaScript? (score [6032283](https://stackoverflow.com/q/5767325) in 2019)

#### Question
I have an array of numbers, and I'm using the `.push()` method to add elements to it.  

Is there a simple way to remove a specific element from an array? The equivalent of something like `array.remove(number);`.  

I have to use <em>core</em> JavaScript - frameworks are not allowed.  

#### Answer accepted (score 10772)
Find the `index` of the array element you want to remove, and then remove that index with <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice" rel="noreferrer">`splice`</a>.  

<blockquote>
  <p>The splice() method changes the contents of an array by removing
  existing elements and/or adding new elements.</p>
</blockquote>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var array = [2, 5, 9];
console.log(array)
var index = array.indexOf(5);
if (index > -1) {
  array.splice(index, 1);
}
// array = [2, 9]
console.log(array);```
</div>
</div>


The second parameter of `splice` is the number of elements to remove. Note that `splice` modifies the array in place and returns a new array containing the elements that have been removed.  

#### Answer 2 (score 1131)
I don't know how you are expecting `array.remove(int)` to behave. There are three possibilities I can think of that you might be wanting.  

To remove an element of an array at an index `i`:  

```javascript
array.splice(i, 1);
```

If you want to remove every element with value `number` from the array:  

```javascript
for(var i = array.length - 1; i >= 0; i--) {
    if(array[i] === number) {
       array.splice(i, 1);
    }
}
```

If you just want to make the element at index `i` no longer exist, but you don't want the indexes of the other elements to change:  

```javascript
delete array[i];
```

#### Answer 3 (score 985)
<h5>Edited on 2016 October</h1>

<ul>
<li>Do it simple, intuitive and explicit (<a href="https://en.wikipedia.org/wiki/Occam%27s_razor" rel="noreferrer">Occam's razor</a>)</li>
<li>Do it immutable (original array stay unchanged)</li>
<li>Do it with standard JavaScript functions, if your browser don't support them - <strong>use polyfill</strong></li>
</ul>

In this code example I use <strong>"array.filter(...)"</strong> function to remove unwanted items from array. This function doesn't change the original array and creates a new one. If your browser don't support this function (e.g. Internet&nbsp;Explorer before version 9, or Firefox before version 1.5), consider using <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter#Polyfill" rel="noreferrer"><strong>the filter polyfill from Mozilla</strong></a>.  

<h5>Removing item (ECMA-262 Edition 5 code aka oldstyle JavaScript)</h1>

```javascript
var value = 3

var arr = [1, 2, 3, 4, 5, 3]

arr = arr.filter(function(item) {
    return item !== value
})

console.log(arr)
// [ 1, 2, 4, 5 ]
```

<h5>Removing item (ECMAScript 6 code)</h1>

```javascript
let value = 3

let arr = [1, 2, 3, 4, 5, 3]

arr = arr.filter(item => item !== value)

console.log(arr)
// [ 1, 2, 4, 5 ]
```

<strong>IMPORTANT</strong> ECMAScript&nbsp;6 "() => {}" arrow function syntax is not supported in Internet&nbsp;Explorer at all, Chrome before 45 version, Firefox before 22 version, and Safari before 10 version. To use ECMAScript&nbsp;6 syntax in old browsers you can use <a href="http://babeljs.io" rel="noreferrer">BabelJS</a>.  

<hr>

<h5>Removing multiple items (ECMAScript&nbsp;7 code)</h1>

An additional advantage of this method is that you can remove multiple items  

```javascript
let forDeletion = [2, 3, 5]

let arr = [1, 2, 3, 4, 5, 3]

arr = arr.filter(item => !forDeletion.includes(item))
// !!! Read below about array.includes(...) support !!!

console.log(arr)
// [ 1, 4 ]
```

<strong>IMPORTANT</strong> "array.includes(...)" function is not supported in Internet&nbsp;Explorer at all, Chrome before 47 version, Firefox before 43 version, Safari before 9 version, and Edge before 14 version so <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes#Polyfill" rel="noreferrer"><strong>here is polyfill from Mozilla</strong></a>.  

<h5>Removing multiple items (in the future, maybe)</h1>

If the <a href="https://github.com/tc39/proposal-bind-operator" rel="noreferrer">"This-Binding Syntax"</a> proposal is ever accepted, you'll be able to do this:  

```javascript
// array-lib.js

export function remove(...forDeletion) {
    return this.filter(item => !forDeletion.includes(item))
}

// main.js

import { remove } from './array-lib.js'

let arr = [1, 2, 3, 4, 5, 3]

// :: This-Binding Syntax Proposal
// using "remove" function as "virtual method"
// without extending Array.prototype
arr = arr::remove(2, 3, 5)

console.log(arr)
// [ 1, 4 ]
```

<a href="https://babeljs.io/repl/#?babili=false&amp;evaluate=true&amp;lineWrap=false&amp;presets=es2015%2Creact%2Cstage-0%2Cstage-2&amp;targets=&amp;browsers=chrome%20%3E%2050&amp;builtIns=false&amp;code=%20%20%20%20function%20remove(...forDeletion)%20%7B%0A%20%20%20%20%20%20%20%20return%20this.filter(item%20%3D%3E%20!forDeletion.includes(item))%0A%20%20%20%20%7D%0A%0A%20%20%20%20let%20arr%20%3D%20%5B1%2C%202%2C%203%2C%204%2C%205%2C%203%5D%0A%0A%20%20%20%20%2F%2F%20%3A%3A%20This-Binding%20Syntax%20Proposal%0A%20%20%20%20%2F%2F%20using%20remove%20function%20as%20%22virtual%20method%22%0A%20%20%20%20arr%20%3D%20arr%3A%3Aremove(2%2C%203%2C%205)%0A%0A%20%20%20%20console.log(arr)%0A%20%20%20%20%2F%2F%20%5B%201%2C%204%20%5D" rel="noreferrer"><strong>Try it yourself in BabelJS :)</strong></a>  

<strong>Reference</strong>  

<ul>
<li><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes" rel="noreferrer">Array.prototype.includes</a></li>
<li><a href="https://vanslaars.io/post/create-pipe-function/" rel="noreferrer">Functional composition</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How do I redirect to another webpage? (score [5895389](https://stackoverflow.com/q/503093) in 2018)

#### Question
How can I redirect the user from one page to another using jQuery or pure JavaScript?  

#### Answer accepted (score 14310)
<h5>One does not simply redirect using jQuery</h2>

jQuery is not necessary, and <a href="https://developer.mozilla.org/en-US/docs/Web/API/Location/replace" rel="noreferrer"><strong>`window.location.replace(...)`</strong></a> will best simulate an HTTP redirect.    

`window.location.replace(...)` is better than using `window.location.href`, because `replace()` does not keep the originating page in the session history, meaning the user won't get stuck in a never-ending back-button fiasco.  

<p>If you want to simulate someone clicking on a link, use
 <strong>`location.href`</strong></p>

If you want to simulate an HTTP redirect, use <strong>`location.replace`</strong>  

<strong>For example:</strong>  

```javascript
// similar behavior as an HTTP redirect
window.location.replace("http://stackoverflow.com");

// similar behavior as clicking on a link
window.location.href = "http://stackoverflow.com";
```

#### Answer 2 (score 1627)
<strong>WARNING:</strong> This answer has merely been provided as a possible solution; it is obviously <em>not</em> the best solution, as it requires jQuery. Instead, prefer the pure JavaScript solution.  

```javascript
$(location).attr('href', 'http://stackoverflow.com')
```

#### Answer 3 (score 622)
<h5>Standard "vanilla" JavaScript way to redirect a page</h1>

```javascript
window.location.href = 'newPage.html';
```

<h5>Or more simply:  (since `window` is Global)</h2>

```javascript
location.href = 'newPage.html';
```

<hr>

<blockquote>
  <strong>If you are here because you are <em>losing</em> HTTP_REFERER when redirecting, keep reading:</strong>  
  
  (Otherwise ignore this last part)  
</blockquote>

<hr>

The following section is for those using `HTTP_REFERER` as one of many secure measures (although it isn't a great protective measure). If you're using <a href="http://en.wikipedia.org/wiki/Internet_Explorer_8" rel="noreferrer">Internet&nbsp;Explorer&nbsp;8</a> or lower, these variables get lost when using any form of JavaScript page redirection (location.href,  etc.).  

Below we are going to implement an alternative for <strong>IE8 &amp; lower</strong> so that we don't lose HTTP_REFERER. Otherwise you can almost always simply use `window.location.href`.  

<p>Testing against `HTTP_REFERER` (URL pasting, session, etc.) <em>can</em> be helpful in telling whether a request is legitimate.
<em>(<strong>Note:</strong> there are also ways to work-around / spoof these referrers, as noted by droop's link in the comments)</em></p>

<hr>

Simple cross-browser testing solution (fallback to window.location.href for Internet&nbsp;Explorer&nbsp;9+ and all other browsers)  

<strong>Usage: `redirect('anotherpage.aspx');`</strong>  

```javascript
function redirect (url) {
    var ua        = navigator.userAgent.toLowerCase(),
        isIE      = ua.indexOf('msie') !== -1,
        version   = parseInt(ua.substr(4, 2), 10);

    // Internet Explorer 8 and lower
    if (isIE && version < 9) {
        var link = document.createElement('a');
        link.href = url;
        document.body.appendChild(link);
        link.click();
    }

    // All other browsers can use the standard window.location.href (they don't lose HTTP_REFERER like Internet Explorer 8 & lower does)
    else { 
        window.location.href = url; 
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How to check whether a string contains a substring in JavaScript? (score [5745859](https://stackoverflow.com/q/1789945) in 2019)

#### Question
Usually I would expect a `String.contains()` method, but there doesn't seem to be one.   

What is a reasonable way to check for this?  

#### Answer accepted (score 13188)
ES6 introduced <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/includes" rel="noreferrer">`String.prototype.includes`</a>:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var string = "foo",
    substring = "oo";

console.log(string.includes(substring));```
</div>
</div>


`includes` <a href="https://caniuse.com/#feat=es6-string-includes" rel="noreferrer">doesn’t have IE support</a>, though. In an ES5 or older environment, <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/indexOf" rel="noreferrer">`String.prototype.indexOf`</a>, which returns −1 when it doesn’t find the substring, can be used instead:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var string = "foo",
    substring = "oo";

console.log(string.indexOf(substring) !== -1);```
</div>
</div>


#### Answer 2 (score 490)
<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/includes" rel="noreferrer">There is a `String.prototype.includes` in ES6</a>:  

```javascript
"potato".includes("to");
> true
```

Note that this <a href="https://caniuse.com/?v=1#feat=es6-string-includes" rel="noreferrer">does not work in Internet Explorer or some other old browsers</a> with no or incomplete ES6 support. To make it work in old browsers, you may wish to use a transpiler like <a href="https://babeljs.io/" rel="noreferrer">Babel</a>, a shim library like <a href="https://github.com/paulmillr/es6-shim" rel="noreferrer">es6-shim</a>, or this <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/includes#Polyfill" rel="noreferrer">polyfill from MDN</a>:  

```javascript
if (!String.prototype.includes) {
  String.prototype.includes = function(search, start) {
    'use strict';
    if (typeof start !== 'number') {
      start = 0;
    }

    if (start + search.length > this.length) {
      return false;
    } else {
      return this.indexOf(search, start) !== -1;
    }
  };
}
```

#### Answer 3 (score 19)
Another alternative is <a href="https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm" rel="noreferrer">KMP</a>.  

The KMP algorithm searches for a length-<em>m</em> substring in a length-<em>n</em> string in worst-case O(<em>n</em>+<em>m</em>) time, compared to a worst case of O(<em>n</em>⋅<em>m</em>) for the naive algorithm, so using KMP may be reasonable if you care about worst-case time complexity.  

Here's a JavaScript implementation by Project Nayuki, taken from <a href="https://www.nayuki.io/res/knuth-morris-pratt-string-matching/kmp-string-matcher.js" rel="noreferrer">https://www.nayuki.io/res/knuth-morris-pratt-string-matching/kmp-string-matcher.js</a>:  

```javascript
// Searches for the given pattern string in the given text string using the Knuth-Morris-Pratt string matching algorithm.
// If the pattern is found, this returns the index of the start of the earliest match in 'text'. Otherwise -1 is returned.
```

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function kmpSearch(pattern, text) {
  if (pattern.length == 0)
    return 0; // Immediate match

  // Compute longest suffix-prefix table
  var lsp = [0]; // Base case
  for (var i = 1; i < pattern.length; i++) {
    var j = lsp[i - 1]; // Start by assuming we're extending the previous LSP
    while (j > 0 && pattern.charAt(i) != pattern.charAt(j))
      j = lsp[j - 1];
    if (pattern.charAt(i) == pattern.charAt(j))
      j++;
    lsp.push(j);
  }

  // Walk through text string
  var j = 0; // Number of chars matched in pattern
  for (var i = 0; i < text.length; i++) {
    while (j > 0 && text.charAt(i) != pattern.charAt(j))
      j = lsp[j - 1]; // Fall back in the pattern
    if (text.charAt(i) == pattern.charAt(j)) {
      j++; // Next char matched, increment position
      if (j == pattern.length)
        return i - (j - 1);
    }
  }
  return -1; // Not found
}

console.log(kmpSearch('ays', 'haystack') != -1) // true
console.log(kmpSearch('asdf', 'haystack') != -1) // false```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How to check whether a checkbox is checked in jQuery? (score [3985774](https://stackoverflow.com/q/901712) in 2019)

#### Question
I need to check the `checked` property of a checkbox and perform an action based on the checked property using jQuery.  

For example, if the age checkbox is checked, then I need to show a textbox to enter age, else hide the textbox.  

But the following code returns `false` by default:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
if ($('#isAgeSelected').attr('checked'))
{
    $("#txtAge").show();
}
else
{
    $("#txtAge").hide();
}```
```javascript
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

<input type="checkbox" id="isAgeSelected"/>

<div id="txtAge" style="display:none">
Age is selected
</div>```
</div>
</div>


How do I successfully query the `checked` property?  

#### Answer accepted (score 93)
This worked for me:  

```javascript
$get("isAgeSelected ").checked == true
```

Where `isAgeSelected` is the id of the control.  

Also, @karim79's <a href="https://stackoverflow.com/questions/901712/check-checkbox-checked-property-using-jquery/901727#901727">answer</a> works fine. I am not sure what I missed at the time I tested it.  

<strong>Note, this is answer uses Microsoft Ajax, not jQuery</strong>  

#### Answer 2 (score 3326)
<blockquote>
  How do I successfully query the checked property?  
</blockquote>

The `checked` property of a checkbox DOM element will give you the `checked` state of the element.  

Given your existing code, you could therefore do this:  

```javascript
if(document.getElementById('isAgeSelected').checked) {
    $("#txtAge").show();
} else {
    $("#txtAge").hide();
}
```

However, there's a much prettier way to do this, using <a href="http://api.jquery.com/toggle/" rel="noreferrer">`toggle`</a>:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```javascript
$('#isAgeSelected').click(function() {
    $("#txtAge").toggle(this.checked);
});```
```javascript
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<input type="checkbox" id="isAgeSelected"/>
<div id="txtAge" style="display:none">Age is something</div>```
</div>
</div>


#### Answer 3 (score 1753)
Use jQuery's <a href="http://api.jquery.com/is/" rel="noreferrer">is()</a> function:  

```javascript
if($("#isAgeSelected").is(':checked'))
    $("#txtAge").show();  // checked
else
    $("#txtAge").hide();  // unchecked
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: For-each over an array in JavaScript? (score [3880811](https://stackoverflow.com/q/9329446) in 2019)

#### Question
How can I loop through all the entries in an array using JavaScript?  

I thought it was something like this:  

```javascript
forEach(instance in theArray)
```

Where `theArray` is my array, but this seems to be incorrect.  

#### Answer accepted (score 6716)


<strong>TL;DR</strong>  

<ul>
<li>Don't use `for-in` unless you use it with safeguards or are at least aware of why it might bite you.</li>
<li><p>Your best bets are usually</p>

<ul>
<li>a `for-of` loop (ES2015+ only),</li>
<li>`Array#forEach` (<a href="https://tc39.github.io/ecma262/#sec-array.prototype.foreach" rel="noreferrer">`spec`</a> | <a href="https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach" rel="noreferrer">`MDN`</a>) (or its relatives `some` and such) (ES5+ only),</li>
<li>a simple old-fashioned `for` loop,</li>
<li>or `for-in` with safeguards.</li>
</ul></li>
</ul>

But there's <strong>lots</strong> more to explore, read on...  

<hr>

JavaScript has powerful semantics for looping through arrays and array-like objects. I've split the answer into two parts: Options for genuine arrays, and options for things that are just array-<em>like</em>, such as the `arguments` object, other iterable objects (ES2015+), DOM collections, and so on.  

I'll quickly note that you can use the ES2015 options <em>now</em>, even on ES5 engines, by <em>transpiling</em> ES2015 to ES5. Search for "ES2015 transpiling" / "ES6 transpiling" for more...  

Okay, let's look at our options:  

<h5>For Actual Arrays</h2>

You have three options in <a href="http://ecma-international.org/ecma-262/5.1/" rel="noreferrer">ECMAScript&nbsp;5</a> ("ES5"), the version most broadly supported at the moment, and two more added in <a href="http://www.ecma-international.org/ecma-262/6.0/index.html" rel="noreferrer">ECMAScript&nbsp;2015</a> ("ES2015", "ES6"):  

<ol>
<li>Use `forEach` and related (ES5+)</li>
<li>Use a simple `for` loop</li>
<li>Use `for-in` <em>correctly</em></li>
<li>Use `for-of` (use an iterator implicitly) (ES2015+)</li>
<li>Use an iterator explicitly (ES2015+)</li>
</ol>

Details:  

<h5>1. Use `forEach` and related</h3>

In any vaguely-modern environment (so, not IE8) where you have access to the `Array` features added by ES5 (directly or using polyfills), you can use `forEach` (<a href="https://tc39.github.io/ecma262/#sec-array.prototype.foreach" rel="noreferrer">`spec`</a> | <a href="https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach" rel="noreferrer">`MDN`</a>):  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var a = ["a", "b", "c"];
a.forEach(function(entry) {
    console.log(entry);
});```
</div>
</div>


`forEach` accepts a callback function and, optionally, a value to use as `this` when calling that callback (not used above). The callback is called for each entry in the array, in order, skipping non-existent entries in sparse arrays. Although I only used one argument above, the callback is called with three: The value of each entry, the index of that entry, and a reference to the array you're iterating over (in case your function doesn't already have it handy).  

Unless you're supporting obsolete browsers like IE8 (which NetApps shows at just over 4% market share as of this writing in September&nbsp;2016), you can happily use `forEach` in a general-purpose web page without a shim. If you do need to support obsolete browsers, shimming/polyfilling `forEach` is easily done (search for "es5 shim" for several options).  

`forEach` has the benefit that you don't have to declare indexing and value variables in the containing scope, as they're supplied as arguments to the iteration function, and so nicely scoped to just that iteration.  

If you're worried about the runtime cost of making a function call for each array entry, don't be; <a href="http://blog.niftysnippets.org/2012/02/foreach-and-runtime-cost.html" rel="noreferrer">details</a>.  

Additionally, `forEach` is the "loop through them all" function, but ES5 defined several other useful "work your way through the array and do things" functions, including:  

<ul>
<li><a href="https://tc39.github.io/ecma262/#sec-array.prototype.every" rel="noreferrer">`every`</a> (stops looping the first time the callback returns `false` or something falsey)</li>
<li><a href="https://tc39.github.io/ecma262/#sec-array.prototype.some" rel="noreferrer">`some`</a> (stops looping the first time the callback returns `true` or something truthy)</li>
<li><a href="https://tc39.github.io/ecma262/#sec-array.prototype.filter" rel="noreferrer">`filter`</a> (creates a new array including elements where the filter function returns `true` and omitting the ones where it returns `false`)</li>
<li><a href="https://tc39.github.io/ecma262/#sec-array.prototype.map" rel="noreferrer">`map`</a> (creates a new array from the values returned by the callback)</li>
<li><a href="https://tc39.github.io/ecma262/#sec-array.prototype.reduce" rel="noreferrer">`reduce`</a> (builds up a value by repeatedly calling the callback, passing in previous values; see the spec for the details; useful for summing the contents of an array and many other things)</li>
<li><a href="https://tc39.github.io/ecma262/#sec-array.prototype.reduceright" rel="noreferrer">`reduceRight`</a> (like `reduce`, but works in descending rather than ascending order)</li>
</ul>

<h5>2. Use a simple `for` loop</h3>

Sometimes the old ways are the best:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var index;
var a = ["a", "b", "c"];
for (index = 0; index < a.length; ++index) {
    console.log(a[index]);
}```
</div>
</div>


If the length of the array won't change during the loop, and it's in performance-sensitive code (unlikely), a slightly more complicated version grabbing the length up front might be a <strong><em>tiny</em></strong> bit faster:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var index, len;
var a = ["a", "b", "c"];
for (index = 0, len = a.length; index < len; ++index) {
    console.log(a[index]);
}```
</div>
</div>


And/or counting backward:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var index;
var a = ["a", "b", "c"];
for (index = a.length - 1; index >= 0; --index) {
    console.log(a[index]);
}```
</div>
</div>


But with modern JavaScript engines, it's rare you need to eke out that last bit of juice.  

In ES2015 and higher, you can make your index and value variables local to the `for` loop:  

```javascript
let a = ["a", "b", "c"];
for (let index = 0; index < a.length; ++index) {
    let value = a[index];
    console.log(index, value);
}
//console.log(index);   // would cause "ReferenceError: index is not defined"
//console.log(value);   // would cause "ReferenceError: value is not defined"
```

<p><div class="snippet" data-lang="js" data-hide="true" data-console="true" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```javascript
let a = ["a", "b", "c"];
for (let index = 0; index < a.length; ++index) {
    let value = a[index];
    console.log(index, value);
}
try {
    console.log(index);
} catch (e) {
    console.error(e);   // "ReferenceError: index is not defined"
}
try {
    console.log(value);
} catch (e) {
    console.error(e);   // "ReferenceError: value is not defined"
}```
</div>
</div>


And when you do that, not just `value` but also `index` is recreated for each loop iteration, meaning closures created in the loop body keep a reference to the `index` (and `value`) created for that specific iteration:  

```javascript
let divs = document.querySelectorAll("div");
for (let index = 0; index < divs.length; ++index) {
    divs[index].addEventListener('click', e => {
        console.log("Index is: " + index);
    });
}
```

<p><div class="snippet" data-lang="js" data-hide="true" data-console="true" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```javascript
let divs = document.querySelectorAll("div");
for (let index = 0; index < divs.length; ++index) {
    divs[index].addEventListener('click', e => {
        console.log("Index is: " + index);
    });
}```
```javascript
<div>zero</div>
<div>one</div>
<div>two</div>
<div>three</div>
<div>four</div>```
</div>
</div>


If you had five divs, you'd get "Index is: 0" if you clicked the first and "Index is: 4" if you clicked the last. This does <strong>not</strong> work if you use `var` instead of `let`.  

<h5>3. Use `for-in` <em>correctly</em></h3>

You'll get people telling you to use `for-in`, but <a href="http://blog.niftysnippets.org/2010/11/myths-and-realities-of-forin.html" rel="noreferrer">that's not what `for-in` is for</a>. `for-in` loops through the <em>enumerable properties of an object</em>, not the indexes of an array. <strong>The order is not guaranteed</strong>, not even in ES2015 (ES6). ES2015+ does define an order to object properties (via <a href="https://tc39.github.io/ecma262/#sec-ordinary-object-internal-methods-and-internal-slots-ownpropertykeys" rel="noreferrer">`[[OwnPropertyKeys]]`</a>, <a href="https://tc39.github.io/ecma262/#sec-ordinary-object-internal-methods-and-internal-slots-enumerate" rel="noreferrer">`[[Enumerate]]`</a>, and things that use them like <a href="https://tc39.github.io/ecma262/#sec-object.getownpropertynames" rel="noreferrer">`Object.getOwnPropertyKeys`</a>), but it <strong>does not</strong> define that `for-in` will follow that order. (Details in <a href="https://stackoverflow.com/a/30919039/157247">this other answer</a>.)  

The only real use cases for `for-in` on an array are:  

<ul>
<li>It's a <a href="http://en.wikipedia.org/wiki/Sparse_array" rel="noreferrer"><em>sparse</em> arrays</a> with <strong>massive</strong> gaps in it, or</li>
<li>You're using non-element properties and you want to include them in the loop</li>
</ul>

Looking only at that first example: You can use `for-in` to visit those sparese array elements if you use appropriate safeguards:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
// `a` is a sparse array
var key;
var a = [];
a[0] = "a";
a[10] = "b";
a[10000] = "c";
for (key in a) {
    if (a.hasOwnProperty(key)  &&        // These checks are
        /^0$|^[1-9]\d*$/.test(key) &&    // explained
        key <= 4294967294                // below
        ) {
        console.log(a[key]);
    }
}```
</div>
</div>


Note the three checks:  

<ol>
<li><p>That the object has its <em>own</em> property by that name (not one it inherits from its prototype), and</p></li>
<li><p>That the key is all decimal digits (e.g., normal string form, not scientific notation), and</p></li>
<li><p>That the key's value when coerced to a number is &lt;= 2^32 - 2 (which is 4,294,967,294). Where does that number come from? It's part of the definition of an array index <a href="https://tc39.github.io/ecma262/#array-index" rel="noreferrer">in the specification</a>. Other numbers (non-integers, negative numbers, numbers greater than 2^32 - 2) are not array indexes. The reason it's 2^32 - <strong>2</strong> is that that makes the greatest index value one lower than 2^32 - <strong>1</strong>, which is the maximum value an array's `length` can have. (E.g., an array's length fits in a 32-bit unsigned integer.) <em>(Props to RobG for pointing out in a comment <a href="http://blog.niftysnippets.org/2010/11/myths-and-realities-of-forin.html" rel="noreferrer">on my blog post</a> that my previous test wasn't quite right.)</em></p></li>
</ol>

You wouldn't do that in inline code, of course. You'd write a utility function. Perhaps:  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="true" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```javascript
// Utility function for antiquated environments without `forEach`
var hasOwn = Object.prototype.hasOwnProperty;
var rexNum = /^0$|^[1-9]\d*$/;
function sparseEach(array, callback, thisArg) {
    var index;
    for (var key in array) {
        index = +key;
        if (hasOwn.call(a, key) &&
            rexNum.test(key) &&
            index <= 4294967294
            ) {
            callback.call(thisArg, array[key], index, array);
        }
    }
}

var a = [];
a[5] = "five";
a[10] = "ten";
a[100000] = "one hundred thousand";
a.b = "bee";

sparseEach(a, function(value, index) {
    console.log("Value at " + index + " is " + value);
});```
</div>
</div>


<h5>4. Use `for-of` (use an iterator implicitly) (ES2015+)</h3>

ES2015 adds <em>iterators</em> to JavaScript. The easiest way to use iterators is the new `for-of` statement. It looks like this:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
const a = ["a", "b", "c"];
for (const val of a) {
    console.log(val);
}```
</div>
</div>


Under the covers, that gets an <em>iterator</em> from the array and loops through it, getting the values from it. This doesn't have the issue that using `for-in` has, because it uses an iterator defined by the object (the array), and arrays define that their iterators iterate through their <em>entries</em> (not their properties). Unlike `for-in` in ES5, the order in which the entries are visited is the numeric order of their indexes.  

<h5>5. Use an iterator explicitly (ES2015+)</h3>

Sometimes, you might want to use an iterator <em>explicitly</em>. You can do that, too, although it's a lot clunkier than `for-of`. It looks like this:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
const a = ["a", "b", "c"];
const it = a.values();
let entry;
while (!(entry = it.next()).done) {
    console.log(entry.value);
}```
</div>
</div>


The iterator is an object matching the Iterator definition in the specification. Its `next` method returns a new <em>result object</em> each time you call it. The result object has a property, `done`, telling us whether it's done, and a property `value` with the value for that iteration. (`done` is optional if it would be `false`, `value` is optional if it would be `undefined`.)  

The meaning of `value` varies depending on the iterator; arrays support (at least) three functions that return iterators:  

<ul>
<li>`values()`: This is the one I used above. It returns an iterator where each `value` is the array entry for that iteration (`"a"`, `"b"`, and `"c"` in the example earlier).</li>
<li>`keys()`: Returns an iterator where each `value` is the key for that iteration (so for our `a` above, that would be `"0"`, then `"1"`, then `"2"`).</li>
<li>`entries()`: Returns an iterator where each `value` is an array in the form `[key, value]` for that iteration.</li>
</ul>

<h5>For Array-Like Objects</h2>

Aside from true arrays, there are also <em>array-like</em> objects that have a `length` property and properties with numeric names: `NodeList` instances, the `arguments` object, etc. How do we loop through their contents?  

<h5>Use any of the options above for arrays</h3>

At least some, and possibly most or even all, of the array approaches above frequently apply equally well to array-like objects:  

<ol>
<li><p><strong>Use `forEach` and related (ES5+)</strong></p>

The various functions on `Array.prototype` are "intentionally generic" and can usually be used on array-like objects via <a href="https://tc39.github.io/ecma262/#sec-function.prototype.call" rel="noreferrer">`Function#call`</a> or <a href="https://tc39.github.io/ecma262/#sec-function.prototype.apply" rel="noreferrer">`Function#apply`</a>. (See the <em>Caveat for host-provided objects</em> at the end of this answer, but it's a rare issue.)  

Suppose you wanted to use `forEach` on a `Node`'s `childNodes` property. You'd do this:  

```javascript
Array.prototype.forEach.call(node.childNodes, function(child) {
    // Do something with `child`
});
```

If you're going to do that a lot, you might want to grab a copy of the function reference into a variable for reuse, e.g.:  

```javascript
// (This is all presumably in some scoping function)
var forEach = Array.prototype.forEach;

// Then later...
forEach.call(node.childNodes, function(child) {
    // Do something with `child`
});
```</li>
<li><p><strong>Use a simple `for` loop</strong></p>

Obviously, a simple `for` loop applies to array-like objects.  </li>
<li><p><strong>Use `for-in` <em>correctly</em></strong></p>

`for-in` with the same safeguards as with an array should work with array-like objects as well; the caveat for host-provided objects on #1 above may apply.  </li>
<li><p><strong>Use `for-of` (use an iterator implicitly) (ES2015+)</strong></p>

`for-of` will use the iterator provided by the object (if any); we'll have to see how this plays with the various array-like objects, particularly host-provided ones. For instance, the specification for the `NodeList` from `querySelectorAll` was updated to support iteration. The spec for the `HTMLCollection` from `getElementsByTagName` was not.  </li>
<li><p><strong>Use an iterator explicitly (ES2015+)</strong></p>

See #4, we'll have to see how iterators play out.  </li>
</ol>

<h5>Create a true array</h3>

Other times, you may want to convert an array-like object into a true array. Doing that is surprisingly easy:  

<ol>
<li><p><strong>Use the <a href="https://tc39.github.io/ecma262/#sec-array.prototype.slice" rel="noreferrer">`slice`</a> method of arrays</strong></p>

We can use the `slice` method of arrays, which like the other methods mentioned above is "intentionally generic" and so can be used with array-like objects, like this:  

```javascript
var trueArray = Array.prototype.slice.call(arrayLikeObject);
```

So for instance, if we want to convert a `NodeList` into a true array, we could do this:  

```javascript
var divs = Array.prototype.slice.call(document.querySelectorAll("div"));
```

See the <em>Caveat for host-provided objects</em> below. In particular, note that this will fail in IE8 and earlier, which don't let you use host-provided objects as `this` like that.  </li>
<li><p><strong>Use <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax" rel="noreferrer">spread syntax (`...`)</a></strong></p>

It's also possible to use ES2015's <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax" rel="noreferrer">spread syntax</a> with JavaScript engines that support this feature:  

```javascript
var trueArray = [...iterableObject];
```

So for instance, if we want to convert a `NodeList` into a true array, with spread syntax this becomes quite succinct:  

```javascript
var divs = [...document.querySelectorAll("div")];
```</li>
<li><p><strong>Use `Array.from`</strong> <a href="https://tc39.github.io/ecma262/#sec-array.from" rel="noreferrer">(spec)</a> | <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/from" rel="noreferrer">(MDN)</a></p>

`Array.from` (ES2015+, but easily polyfilled) creates an array from an array-like object, optionally passing the entries through a mapping function first. So:  

```javascript
var divs = Array.from(document.querySelectorAll("div"));
```

Or if you wanted to get an array of the tag names of the elements with a given class, you'd use the mapping function:  

```javascript
// Arrow function (ES2015):
var divs = Array.from(document.querySelectorAll(".some-class"), element => element.tagName);

// Standard function (since `Array.from` can be shimmed):
var divs = Array.from(document.querySelectorAll(".some-class"), function(element) {
    return element.tagName;
});
```</li>
</ol>

<h5>Caveat for host-provided objects</h3>

If you use `Array.prototype` functions with <em>host-provided</em> array-like objects (DOM lists and other things provided by the browser rather than the JavaScript engine), you need to be sure to test in your target environments to make sure the host-provided object behaves properly. <strong>Most do behave properly</strong> (now), but it's important to test. The reason is that most of the `Array.prototype` methods you're likely to want to use rely on the host-provided object giving an honest answer to the abstract <a href="https://tc39.github.io/ecma262/#sec-ordinary-object-internal-methods-and-internal-slots-hasproperty-p" rel="noreferrer">`[[HasProperty]]`</a> operation. As of this writing, browsers do a very good job of this, but the 5.1 spec did allow for the possibility a host-provided object may not be honest. It's in <a href="http://www.ecma-international.org/ecma-262/5.1/#sec-8.6.2" rel="noreferrer">§8.6.2</a>, several paragraphs below the big table near the beginning of that section), where it says:  

<blockquote>
  Host objects may implement these internal methods in any manner unless specified otherwise; for example, one possibility is that `[[Get]]` and `[[Put]]` for a particular host object indeed fetch and store property values but `[[HasProperty]]` always generates <strong>false</strong>.  
</blockquote>

(I couldn't find the equivalent verbiage in the ES2015 spec, but it's bound to still be the case.) Again, as of this writing the common host-provided array-like objects in modern browsers [`NodeList` instances, for instance] <strong>do</strong> handle `[[HasProperty]]` correctly, but it's important to test.)  

#### Answer 2 (score 488)
<strong>Note</strong>: This answer is hopelessly out-of-date. For a more modern approach, look at <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array" rel="nofollow noreferrer">the methods available on an array</a>. Methods of interest might be:  

<ul>
<li>forEach</li>
<li>map</li>
<li>filter</li>
<li>zip</li>
<li>reduce</li>
<li>every</li>
<li>some</li>
</ul>

<hr>

The standard way to iterate an array in <a href="http://en.wikipedia.org/wiki/JavaScript" rel="nofollow noreferrer">JavaScript</a> is a vanilla `for`-loop:  

```javascript
var length = arr.length,
    element = null;
for (var i = 0; i < length; i++) {
  element = arr[i];
  // Do something with element
}
```

Note, however, that this approach is only good if you have a dense array, and each index is occupied by an element. If the array is sparse, then you can run into performance problems with this approach, since you will iterate over a lot of indices that do not <em>really</em> exist in the array. In this case, a `for .. in`-loop might be a better idea. <strong>However</strong>, you must use the appropriate safeguards to ensure that only the desired properties of the array (that is, the array elements) are acted upon, since the `for..in`-loop will also be enumerated in legacy browsers, or if the additional properties are defined as `enumerable`.  

In <a href="https://en.wikipedia.org/wiki/ECMAScript#ECMAScript.2C_5th_Edition" rel="nofollow noreferrer">ECMAScript 5</a> there will be a forEach method on the array prototype, but it is not supported in legacy browsers. So to be able to use it consistently you must either have an environment that supports it (for example, <a href="http://en.wikipedia.org/wiki/Node.js" rel="nofollow noreferrer">Node.js</a> for server side JavaScript), or use a "Polyfill". The Polyfill for this functionality is, however, trivial and since it makes the code easier to read, it is a good polyfill to include.  

#### Answer 3 (score 224)
If you’re using the <a href="http://jquery.com/" rel="noreferrer"><strong>jQuery</strong></a> library, you can use <a href="http://api.jquery.com/jQuery.each/" rel="noreferrer"><strong>jQuery.each</strong></a>:  



```javascript
$.each(yourArray, function(index, value) {
  // do your stuff here
});
```

<strong>EDIT :</strong>   

As per question, user want code in javascript instead of jquery so the edit is  

```javascript
var length = yourArray.length;   
for (var i = 0; i < length; i++) {
  // Do something with yourArray[i].
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: Get selected value in dropdown list using JavaScript (score [3750417](https://stackoverflow.com/q/1085801) in 2019)

#### Question
How do I get the selected value from a dropdown list using JavaScript?  

I tried the methods below, but they all return the selected index instead of the value:  

```javascript
var as = document.form1.ddlViewBy.value;
var e = document.getElementById("ddlViewBy");
var strUser = e.options[e.selectedIndex].value;
```

#### Answer accepted (score 2722)
If you have a select element that looks like this:  

```javascript
<select id="ddlViewBy">
  <option value="1">test1</option>
  <option value="2" selected="selected">test2</option>
  <option value="3">test3</option>
</select>
```

Running this code:  

```javascript
var e = document.getElementById("ddlViewBy");
var strUser = e.options[e.selectedIndex].value;
```

Would make `strUser` be `2`. If what you actually want is `test2`, then do this:  

```javascript
var e = document.getElementById("ddlViewBy");
var strUser = e.options[e.selectedIndex].text;
```

Which would make `strUser` be `test2`  

#### Answer 2 (score 342)
Plain JavaScript:  

```javascript
var e = document.getElementById("elementId");
var value = e.options[e.selectedIndex].value;
var text = e.options[e.selectedIndex].text;
```

jQuery:  

```javascript
$("#elementId :selected").text(); // The text content of the selected option
$("#elementId :selected").val(); // The value of the selected option
```

<a href="http://en.wikipedia.org/wiki/AngularJS" rel="noreferrer">AngularJS</a>: (<a href="http://jsfiddle.net/qk5wwyct" rel="noreferrer">http://jsfiddle.net/qk5wwyct</a>):  

```javascript
// HTML
<select ng-model="selectItem" ng-options="item as item.text for item in items">
</select>
<p>Text: {{selectItem.text}}</p>
<p>Value: {{selectItem.value}}</p>

// JavaScript
$scope.items = [{
  value: 'item_1_id',
  text: 'Item 1'
}, {
  value: 'item_2_id',
  text: 'Item 2'
}];
```

#### Answer 3 (score 167)
```javascript
var strUser = e.options[e.selectedIndex].value;
```

<p>This is correct and should give you the value.
Is it the text you're after?</p>

```javascript
var strUser = e.options[e.selectedIndex].text;
```

So you're clear on the terminology:  

```javascript
<select>
    <option value="hello">Hello World</option>
</select>
```

This option has:  

<ul>
<li>Index = 0</li>
<li>Value = hello</li>
<li>Text = Hello World</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: How can I get query string values in JavaScript? (score [3549269](https://stackoverflow.com/q/901115) in 2015)

#### Question
Is there a plugin-less way of retrieving <a href="http://en.wikipedia.org/wiki/Query_string" rel="nofollow noreferrer">query string</a> values via jQuery (or without)?   

If so, how? If not, is there a plugin which can do so?  

#### Answer accepted (score 7925)
<strong>Update: Sep-2018</strong>  

You can use <a href="https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams#Browser_compatibility" rel="noreferrer">URLSearchParams</a> which is simple and has <a href="https://caniuse.com/#feat=urlsearchparams" rel="noreferrer">decent (but not complete) browser support</a>.  

```javascript
const urlParams = new URLSearchParams(window.location.search);
const myParam = urlParams.get('myParam');
```

<strong>Original</strong>  

You don't need jQuery for that purpose. You can use just some pure JavaScript:  

```javascript
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}
```

<strong>Usage:</strong>  

```javascript
// query string: ?foo=lorem&bar=&baz
var foo = getParameterByName('foo'); // "lorem"
var bar = getParameterByName('bar'); // "" (present with empty value)
var baz = getParameterByName('baz'); // "" (present with no value)
var qux = getParameterByName('qux'); // null (absent)
```

<p><br>
Note: If a parameter is present several times (`?foo=lorem&amp;foo=ipsum`), you will get the first value (`lorem`). There is no standard about this and usages vary, see for example this question: <a href="https://stackoverflow.com/questions/1746507/authoritative-position-of-duplicate-http-get-query-keys">Authoritative position of duplicate HTTP GET query keys</a>.<br>
NOTE: The function is case-sensitive. If you prefer case-insensitive parameter name, <a href="https://stackoverflow.com/questions/3939715/case-insensitive-regex-in-javascript">add 'i' modifier to RegExp</a></p>

<hr>

This is an update based on the new <a href="https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams" rel="noreferrer">URLSearchParams specs</a> to achieve the same result more succinctly. See answer titled "<a href="https://stackoverflow.com/questions/901115/how-can-i-get-query-string-values-in-javascript/901144#12151322">URLSearchParams</a>" below.  

#### Answer 2 (score 1683)
Some of the solutions posted here are inefficient. Repeating the regular expression search every time the script needs to access a parameter is completely unnecessary, one single function to split up the parameters into an associative-array style object is enough. If you're not working with the HTML 5 History API, this is only necessary once per page load.  The other suggestions here also fail to decode the URL correctly.  

```javascript
var urlParams;
(window.<a href="https://developer.mozilla.org/en-US/docs/DOM/window.onpopstate" rel="noreferrer">onpopstate</a> = function () {
    var match,
        pl     = /\+/g,  // Regex for replacing addition symbol with a space
        search = /([^&=]+)=?([^&]*)/g,
        decode = function (s) { return <a href="https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/decodeURIComponent" rel="noreferrer">decodeURIComponent</a>(s.replace(pl, " ")); },
        query  = window.<a href="https://developer.mozilla.org/en-US/docs/DOM/window.location" rel="noreferrer">location</a>.search.<a href="https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/String/substring" rel="noreferrer">substring</a>(1);

    urlParams = {};
    while (match = search.<a href="https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/RegExp/exec" rel="noreferrer">exec</a>(query))
       urlParams[decode(match[1])] = decode(match[2]);
})();```

Example querystring:   

<blockquote>
  `?i=main&amp;mode=front&amp;sid=de8d49b78a85a322c4155015fdce22c4&amp;enc=+Hello%20&amp;empty`  
</blockquote>

Result:  

```javascript
 urlParams = {
    enc: " Hello ",
    i: "main",
    mode: "front",
    sid: "de8d49b78a85a322c4155015fdce22c4",
    empty: ""
}

alert(urlParams["mode"]);
// -> "front"

alert("empty" in urlParams);
// -> true
```

This could easily be improved upon to handle array-style query strings too.  An example of this is <a href="http://jsbin.com/adali3/2" rel="noreferrer">here</a>, but since array-style parameters aren't defined in <a href="http://tools.ietf.org/html/rfc3986" rel="noreferrer">RFC 3986</a> I won't pollute this answer with the source code. <a href="https://stackoverflow.com/questions/901115/how-can-i-get-query-string-values-in-javascript/23401756#23401756">For those interested in a "polluted" version, look at campbeln's answer below</a>.  

Also, as pointed out in the comments, `;` is a legal delimiter for `key=value` pairs.  It would require a more complicated regex to handle `;` or `&amp;`, which I think is unnecessary because it's rare that `;` is used and I would say even more unlikely that both would be used.  If you need to support `;` instead of `&amp;`, just swap them in the regex.  

<p><hr /> 
If you're using a server-side preprocessing language, you might want to use its native JSON functions to do the heavy lifting for you.  For example, in PHP you can write:</p>

```javascript
<script>var urlParams = <?php echo <a href="http://php.net/manual/en/function.json-encode.php" rel="noreferrer">json_encode</a>($_GET, JSON_HEX_TAG);?>;</script>```

Much simpler!  

#### Answer 3 (score 1260)
<h5>ES2015 (ES6)</h1>

```javascript
getQueryStringParams = query => {
    return query
        ? (/^[?#]/.test(query) ? query.slice(1) : query)
            .split('&')
            .reduce((params, param) => {
                    let [key, value] = param.split('=');
                    params[key] = value ? decodeURIComponent(value.replace(/\+/g, ' ')) : '';
                    return params;
                }, {}
            )
        : {}
};
```

<hr>

<h5>Without jQuery</h2>

```javascript
var qs = (function(a) {
    if (a == "") return {};
    var b = {};
    for (var i = 0; i < a.length; ++i)
    {
        var p=a[i].split('=', 2);
        if (p.length == 1)
            b[p[0]] = "";
        else
            b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
    }
    return b;
})(window.location.search.substr(1).split('&'));
```

With an URL like `?topic=123&amp;name=query+string`, the following will return:  

```javascript
qs["topic"];    // 123
qs["name"];     // query string
qs["nothere"];  // undefined (object)
```

<hr>

<h5>Google method</h2>

Tearing Google's code I found the method they use: `getUrlParameters`  

```javascript
function (b) {
    var c = typeof b === "undefined";
    if (a !== h && c) return a;
    for (var d = {}, b = b || k[B][vb], e = b[p]("?"), f = b[p]("#"), b = (f === -1 ? b[Ya](e + 1) : [b[Ya](e + 1, f - e - 1), "&", b[Ya](f + 1)][K](""))[z]("&"), e = i.dd ? ia : unescape, f = 0, g = b[w]; f < g; ++f) {
        var l = b[f][p]("=");
        if (l !== -1) {
            var q = b[f][I](0, l),
                l = b[f][I](l + 1),
                l = l[Ca](/\+/g, " ");
            try {
                d[q] = e(l)
            } catch (A) {}
        }
    }
    c && (a = d);
    return d
}
```

It is obfuscated, but it is understandable. It does not work because some variables are undefined.  

They start to look for parameters on the url from `?` and also from the hash `#`. Then for each parameter they split in the equal sign `b[f][p]("=")` (which looks like `indexOf`, they use the position of the char to get the key/value). Having it split they check whether the parameter has a value or not, if it has then they store the value of `d`, otherwise they just continue.  

In the end the object `d` is returned, handling escaping and the `+` sign. This object is just like mine, it has the same behavior.  

<hr>

My method as a <strong>jQuery plugin</strong>  

```javascript
(function($) {
    $.QueryString = (function(paramsArray) {
        let params = {};

        for (let i = 0; i < paramsArray.length; ++i)
        {
            let param = paramsArray[i]
                .split('=', 2);

            if (param.length !== 2)
                continue;

            params[param[0]] = decodeURIComponent(param[1].replace(/\+/g, " "));
        }

        return params;
    })(window.location.search.substr(1).split('&'))
})(jQuery);
```

Usage  

```javascript
//Get a param
$.QueryString.param
//-or-
$.QueryString["param"]
//This outputs something like...
//"val"

//Get all params as object
$.QueryString
//This outputs something like...
//Object { param: "val", param2: "val" }

//Set a param (only in the $.QueryString object, doesn't affect the browser's querystring)
$.QueryString.param = "newvalue"
//This doesn't output anything, it just updates the $.QueryString object

//Convert object into string suitable for url a querystring (Requires jQuery)
$.param($.QueryString)
//This outputs something like...
//"param=newvalue&param2=val"

//Update the url/querystring in the browser's location bar with the $.QueryString object
history.replaceState({}, '', "?" + $.param($.QueryString));
//-or-
history.pushState({}, '', "?" + $.param($.QueryString));
```

<hr>

<h5><a href="http://jsperf.com/querystring-with-javascript" rel="noreferrer">Performance test (split method against regex method)</a> (<a href="http://jsperf.com/" rel="noreferrer">jsPerf</a>)</h2>

Preparation code: methods declaration  

<h5>Split test code</h3>

```javascript
var qs = window.GetQueryString(query);

var search = qs["q"];
var value = qs["value"];
var undef = qs["undefinedstring"];
```

<h5>Regex test code</h3>

```javascript
var search = window.getParameterByName("q");
var value = window.getParameterByName("value");
var undef = window.getParameterByName("undefinedstring");
```

<strong>Testing in Firefox 4.0 x86 on Windows Server 2008 R2 / 7 x64</strong>  

<ul>
<li><strong>Split method</strong>: 144,780 ±2.17% fastest</li>
<li><strong>Regex method</strong>: 13,891 ±0.85% | 90% slower</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: Loop through an array in JavaScript (score [3479539](https://stackoverflow.com/q/3010840) in 2018)

#### Question
In Java you can use a `for` loop to traverse objects in an array as follows:  

```javascript
String[] myStringArray = {"Hello", "World"};
for (String s : myStringArray)
{
    // Do something
}
```

Can you do the same in JavaScript?  

#### Answer 2 (score 3627)
You have several options:  

<h5>1. Sequential `for` loop:</h1>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var myStringArray = ["Hello","World"];
var arrayLength = myStringArray.length;
for (var i = 0; i < arrayLength; i++) {
    console.log(myStringArray[i]);
    //Do something
}```
</div>
</div>


<strong>Pros</strong>  

<ul>
<li>Works on every environment</li>
<li>You can use `break` and `continue` flow control statements</li>
</ul>

<strong>Cons</strong>  

<ul>
<li>Too verbose</li>
<li>Imperative</li>
<li>Easy to have <a href="https://en.wikipedia.org/wiki/Off-by-one_error#Looping_over_arrays" rel="noreferrer">off-by-one errors</a> (this is sometimes called a <em>fence post error</em>)</li>
</ul>

<h5>2. Array.prototype.forEach</h1>

The ES5 spec. introduced a lot of very helpful array methods, one of them, the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach" rel="noreferrer">`Array.prototype.forEach`</a> and it gives us a very short way to iterate over an array:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
const array = ["one", "two", "three"]
array.forEach(function (item, index) {
  console.log(item, index);
});```
</div>
</div>


Being almost 9 years as the time of writing that the ES5 spec. was released (Dec. 2009), it has been implemented by almost all modern engines in the desktop, server and mobile environments, so it's safe to use them.  

And with the ES6 arrow function syntax, it's even more succinct:  

```javascript
array.forEach(item => console.log(item));
```

Arrow functions are also being widely implemented, unless you plan to support very old platforms (e.g. IE11) you are also safe to go.  

<strong>Pros</strong>  

<ul>
<li>Very short and succinct.</li>
<li>Declarative</li>
</ul>

<strong>Cons</strong>  

<ul>
<li>Cannot use `break` / `continue`</li>
</ul>

Normally, you can replace the need to `break` out of imperative loops by filtering the array elements before iterating them, for example:  

```javascript
array.filter(item => item.condition < 10)
     .forEach(item => console.log(item))
```

Keep in mind if you are iterating an array <em>to build another array from it</em>, you should use `map`, I've seen this anti-pattern so many times.  

<strong>Anti-pattern:</strong>  

```javascript
const numbers = [1,2,3,4,5], doubled = [];

numbers.forEach((n, i) => { doubled[i] = n * 2 });
```

<strong>Proper use case of <em>map</em>:</strong>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
const numbers = [1,2,3,4,5];
const doubled = numbers.map(n => n * 2);

console.log(doubled);```
</div>
</div>


Also if you are trying to <em>reduce</em> the array to a value, for example, you want to sum an array of numbers, you should use the <em>reduce</em> method.  

<strong>Antipattern:</strong>  

```javascript
const numbers = [1,2,3,4,5];
const sum = 0;
numbers.forEach(num => { total += num });
```

<strong>Proper use of <em>reduce</em>:</strong>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
const numbers = [1,2,3,4,5];
const sum = numbers.reduce((total, n) => total + n, 0);

console.log(sum);```
</div>
</div>


<h5>3. ES6 `for-of` statement</h1>

The ES6 standard introduces the concept of iterable objects and defines a new construct for traversing data, the `for...of` statement.  

This statement work for any kind of iterable object and also for generators.  

Array objects are by definition built-in iterables in ES6, so you can use this statement on them:  

```javascript
let colors = ['red', 'green', 'blue'];
for (const color of colors){
  console.log(color);
}
```

<strong>Pros</strong>  

<ul>
<li>Can iterate over a large variety of objects.</li>
<li>Can use normal flow control statements (`break` / `continue`).</li>
<li>Useful to iterate serially asynchronous values.</li>
</ul>

<strong>Cons</strong>  

<ul>
<li>If you are targeting older browsers the transpiled output <a href="https://babeljs.io/repl#?babili=false&amp;browsers=&amp;build=&amp;builtIns=false&amp;spec=false&amp;loose=false&amp;code_lz=GYewTgBAFAxiB2BnALhOAbcETDSTYiAlAN4BQEeS-ApgHSYDms-4RA3GQL5A&amp;debug=false&amp;forceAllTransforms=false&amp;shippedProposals=false&amp;circleciRepo=&amp;evaluate=true&amp;fileSize=false&amp;timeTravel=false&amp;sourceType=module&amp;lineWrap=false&amp;presets=es2015&amp;prettier=false&amp;targets=&amp;version=7.4.4&amp;externalPlugins=" rel="noreferrer">might surprise you</a>.</li>
</ul>

<h5>Do not use `for...in`</h1>

@zipcodeman suggests the use of the `for...in` statement, but for iterating arrays `for-in` should be avoided, that statement is meant to <strong>enumerate</strong> object properties.  

It shouldn't be used for array-like objects because:  

<ul>
<li>The order of iteration is not guaranteed, the array indexes may not be visited in numeric order.</li>
<li>Inherited properties are also enumerated.</li>
</ul>

The second point is that it can give you a lot of problems, for example, if you extend the `Array.prototype` object to include a method there, that property will be also enumerated.  

For example:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
Array.prototype.foo = "foo!";
    var array = ['a', 'b', 'c'];
    
    for (var i in array) {
      console.log(array[i]);
    }```
</div>
</div>


The above code will console "a", "b", "c" and "foo!".  

That be particularly a problem if you use some library that relies heavily on native prototypes augmention (such as MooTools for example).  

The `for-in` statement as I said before is there to <em>enumerate</em> object properties, for example:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var obj = {
      "a": 1,
      "b": 2,
      "c": 3
    };

    for (var prop in obj) {
      if (obj.hasOwnProperty(prop)) { 
      // or if (Object.prototype.hasOwnProperty.call(obj,prop)) for safety...
        console.log("prop: " + prop + " value: " + obj[prop])
      }
    }```
</div>
</div>


In the above example the `hasOwnProperty` method allows you to enumerate only <em>own properties</em>, that's it, only the properties that the object physically has, no inherited properties.  

I would recommend you to read the following article:  

<ul>
<li><a href="http://web.archive.org/web/20101213150231/http://dhtmlkitchen.com/?category=/JavaScript/&amp;date=2007/10/21/&amp;entry=Iteration-Enumeration-Primitives-and-Objects" rel="noreferrer">Enumeration VS Iteration</a></li>
</ul>

#### Answer 3 (score 1076)
Yes, assuming your implementation includes the <a href="http://www.ecma-international.org/ecma-262/6.0/#sec-for-in-and-for-of-statements" rel="noreferrer">`for`...`of`</a> feature introduced in <a href="http://www.ecma-international.org/ecma-262/6.0/" rel="noreferrer">ECMAScript 2015</a> (the "Harmony" release)... which is a pretty safe assumption these days.  

It works like this:  

```javascript
// REQUIRES ECMASCRIPT 2015+
var s, myStringArray = ["Hello", "World"];
for (s of myStringArray) {
  // ... do something with s ...
}
```

Or better yet, since ECMAScript 2015 also provides block-scoped variables via `let` and `const`:  

```javascript
// REQUIRES ECMASCRIPT 2015+
const myStringArray = ["Hello", "World"];
for (const s of myStringArray) {
  // ... do something with s ...
}
// s is no longer defined here
```

A note on sparse arrays: an array in JavaScript may not actually store as many items as reported by its `length`; that reported number is simply one greater than the highest index at which a value is stored. If the array holds fewer elements than indicated by its length, its said to be <em>sparse</em>. For example, it's perfectly legitimate to have an array with items only at indexes 3, 12, and 247; the `length` of such an array is reported as 248, though it is only actually storing 3 values.  If you try to access an item at any other index, the array will appear to have the `undefined` value there. So when you want to "loop through" an array, you have a question to answer: do you want to loop over the full range indicated by its length and process `undefined`s for any missing elements, or do you only want to process the elements actually present? There are plenty of applications for both approaches; it just depends on what you're using the array for.  

If you iterate over an array with `for`..`of`, the body of the loop is executed `length` times, and the loop control variable is set to `undefined` for any items not actually present in the array. Depending on the details of your "do something with" code, that behavior may be what you want, but if that's not what you want, you should use a different approach.  

Of course, some developers have no choice but to use a different approach anyway, because for whatever reason they're targeting a version of JavaScript that doesn't yet support `for`...`of`.  

As long as your JavaScript implementation is compliant with the <em>previous</em> edition of the ECMAScript specification (which rules out, for example, versions of Internet Explorer before 9), then you can use the <a href="http://www.ecma-international.org/ecma-262/6.0/#sec-array.prototype.foreach" rel="noreferrer">`Array#forEach`</a> iterator method instead of a loop. In that case, you pass a function to be called on each item in the array:  

```javascript
var myStringArray = [ "Hello", "World" ];
myStringArray.forEach( function(s) { 
     // ... do something with s ...
} );
```

Unlike `for`...`of`, `.forEach` only calls the function for elements that actually contain values. If passed our hypothetical array with three elements and a length of 248, it will only call the function three times, not 248 times. It also distinguishes between missing elements and elements that are actually set to `undefined`; for the latter, it will still call the function, passing `undefined` as the argument. If this is how you want to handle sparse arrays, `.forEach` may be the way to go even if your interpreter supports `for`...`of`.  

The final option, which works in <em>all</em> versions of JavaScript, is <a href="http://www.ecma-international.org/ecma-262/6.0/#sec-for-statement" rel="noreferrer">an explicit counting loop</a>. You simply count from 0 up to one less than the length and use the counter as an index. The basic loop looks like this:  

```javascript
var i, s, myStringArray = [ "Hello", "World" ], len = myStringArray.length;
for (i=0; i<len; ++i) {
  s = myStringArray[i];
  // ... do something with s ...
}
```

One advantage of this approach is that you can choose how to handle sparse arrays; the above code will run the body of the loop the full `length` times, with `s` set to `undefined` for any missing elements, just like `for`..`of`. If you instead want to handle only the actually-present elements of a sparse array, like `.forEach`, you can add a simple `in` test on the index:  

```javascript
var i, s, myStringArray = [ "Hello", "World" ], len = myStringArray.length;
for (i=0; i<len; ++i) {
  if (i in myStringArray) {
    s = myStringArray[i];
    // ... do something with s ...
  }
}
```

Assigning the length value to the local variable (as opposed to including the full `myStringArray.length` expression in the loop condition) can make a significant difference in performance since it skips a property lookup each time through; using Rhino on my machine, the speedup is 43%.   

You may see the length caching done in the loop initialization clause, like this:  

```javascript
var i, len, myStringArray = [ "Hello", "World" ];
for (len = myStringArray.length, i=0; i<len; ++i) {
```

The `for`...`in` syntax mentioned by others is for looping over an object's properties; since an Array in JavaScript is just an object with numeric property names (and an automatically-updated `length` property), you can theoretically loop over an Array with it.  But the problem is that it doesn't restrict itself to the numeric property values (remember that even methods are actually just properties whose value is a closure), nor is it guaranteed to iterate over those in numeric order. Therefore, the `for`...`in` syntax should <em>not</em> be used for looping through Arrays.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: How to format a JavaScript date (score [3218299](https://stackoverflow.com/q/3552461) in 2018)

#### Question
How can I format a JavaScript date object to print as `10-Aug-2010`?  

#### Answer accepted (score 1108)
<blockquote>
  Attention: There are better answers below. This answer was written in 2010 and newer and better solutions have arrived since. The OP should accept another answer.  
</blockquote>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function formatDate(date) {
  var monthNames = [
    "January", "February", "March",
    "April", "May", "June", "July",
    "August", "September", "October",
    "November", "December"
  ];

  var day = date.getDate();
  var monthIndex = date.getMonth();
  var year = date.getFullYear();

  return day + ' ' + monthNames[monthIndex] + ' ' + year;
}

console.log(formatDate(new Date()));  // show current date-time in console```
</div>
</div>


You can edit the array `monthNames` to use Jan, Feb, Mar, etc..  

#### Answer 2 (score 1692)
<h5>Use `toLocaleDateString()`</h3>

The <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toLocaleDateString" rel="noreferrer">`toLocaleDateString()`</a> method returns a string with a language-sensitive representation of the date portion of the date. The locales and options arguments let applications specify the language whose formatting conventions should be used and allow to customize the behavior of the function.  

<h5>The values you can passed in options for different keys:</h3>

<ol>
<li><strong>day:</strong> <br/>
The representation of the day. <br/>
Possible values are "numeric", "2-digit".</li>
<li><strong>weekday:</strong> <br/>
The representation of the weekday. <br/>
Possible values are "narrow", "short", "long".</li>
<li><strong>year:</strong> <br/>
The representation of the year. <br/>
Possible values are "numeric", "2-digit".</li>
<li><strong>month:</strong> <br/>
The representation of the month. <br/>
Possible values are "numeric", "2-digit", "narrow", "short", "long".</li>
<li><strong>hour:</strong> <br/>
The representation of the hour. <br/>
Possible values are "numeric", "2-digit".</li>
<li><strong>minute:</strong>
The representation of the minute. <br/>
 Possible values are "numeric", "2-digit".</li>
<li><strong>second:</strong> <br/>
The representation of the second. <br/>
Possible values are "numeric", 2-digit".</li>
</ol>

All these keys are optional.  You can change the number of options values based on your requirements, and this will also reflect the presence of each date time term.  

Note: If you would only like to configure the content options, but still use the current locale, passing `null` for the first parameter will cause an error.  Use `undefined` instead.  

<h5>For different languages:</h3>

<ol>
<li><strong>"en-US":</strong> For English</li>
<li><strong>"hi-IN":</strong> For Hindi</li>
<li><strong>"ja-JP":</strong> For Japanese</li>
</ol>

You can use more language options.  

<h5>For example</h3>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
var today  = new Date();

console.log(today.toLocaleDateString("en-US")); // 9/17/2016
console.log(today.toLocaleDateString("en-US", options)); // Saturday, September 17, 2016
console.log(today.toLocaleDateString("hi-IN", options)); // शनिवार, 17 सितंबर 2016```
</div>
</div>


You can also use the `toLocaleString()` method for the same purpose. The only difference is this function provides the time when you don't pass any options.  

```javascript
// Example
9/17/2016, 1:21:34 PM
```

<h5>References:</h3>

<ul>
<li><p><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toLocaleString" rel="noreferrer">`toLocaleString()`</a></p></li>
<li><p><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toLocaleDateString" rel="noreferrer">`toLocaleDateString()`</a></p></li>
</ul>

#### Answer 3 (score 584)
Use the <a href="http://blog.stevenlevithan.com/archives/date-time-format" rel="noreferrer">date.format library</a>:  

```javascript
var dateFormat = require('dateformat');
var now = new Date();
dateFormat(now, "dddd, mmmm dS, yyyy, h:MM:ss TT");
```

returns:  

```javascript
Saturday, June 9th, 2007, 5:46:21 PM 
```

<a href="https://www.npmjs.com/package/dateformat" rel="noreferrer">dateformat on npm</a>  

<a href="http://jsfiddle.net/phZr7/1/" rel="noreferrer">http://jsfiddle.net/phZr7/1/</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: Setting "checked" for a checkbox with jQuery? (score [3137898](https://stackoverflow.com/q/426258) in 2016)

#### Question
I'd like to do something like this to tick a `checkbox` using <strong>jQuery</strong>:  

```javascript
$(".myCheckBox").checked(true);
```

or   

```javascript
$(".myCheckBox").selected(true);
```

Does such a thing exist?  

#### Answer accepted (score 5804)
<h5>Modern jQuery</h2>

Use <a href="https://api.jquery.com/prop" rel="noreferrer">`.prop()`</a>:  

```javascript
$('.myCheckbox').prop('checked', true);
$('.myCheckbox').prop('checked', false);
```

<h5>DOM API</h2>

If you're working with just one element, you can always just access the underlying <a href="https://developer.mozilla.org/en/docs/Web/API/HTMLInputElement" rel="noreferrer">`HTMLInputElement`</a> and modify its <a href="https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement#Properties_checkbox_radio" rel="noreferrer">`.checked`</a> property:  

```javascript
$('.myCheckbox')[0].checked = true;
$('.myCheckbox')[0].checked = false;
```

The benefit to using the `.prop()` and `.attr()` methods instead of this is that they will operate on all matched elements.  

<h5>jQuery 1.5.x and below</h2>

The `.prop()` method is not available, so you need to use <a href="https://api.jquery.com/attr" rel="noreferrer">`.attr()`</a>.  

```javascript
$('.myCheckbox').attr('checked', true);
$('.myCheckbox').attr('checked', false);
```

Note that this is <a href="https://github.com/jquery/jquery/blob/1.5.2/test/unit/attributes.js#L157" rel="noreferrer">the approach used by jQuery's unit tests prior to version 1.6</a> and is preferable to using `$('.myCheckbox').removeAttr('checked');` since the latter will, if the box was initially checked, change the behaviour of a call to <a href="https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement.reset" rel="noreferrer">`.reset()`</a> on any form that contains it – a subtle but probably unwelcome behaviour change.  

For more context, some incomplete discussion of the changes to the handling of the `checked` attribute/property in the transition from 1.5.x to 1.6 can be found in the <a href="https://blog.jquery.com/2011/05/03/jquery-16-released/" rel="noreferrer">version 1.6 release notes</a> and the <strong>Attributes vs. Properties</strong> section of the <a href="https://api.jquery.com/prop" rel="noreferrer">`.prop()` documentation</a>.  

#### Answer 2 (score 679)
Use:  

```javascript
$(".myCheckbox").attr('checked', true); // Deprecated
$(".myCheckbox").prop('checked', true);
```

And if you want to check if a checkbox is checked or not:  

```javascript
$('.myCheckbox').is(':checked');
```

#### Answer 3 (score 304)
This is the correct way of checking and unchecking checkboxes with jQuery, as it is cross-platform standard, and <em>will</em> allow form reposts.  

```javascript
$('.myCheckBox').each(function(){ this.checked = true; });

$('.myCheckBox').each(function(){ this.checked = false; });
```

By doing this, you are using JavaScript standards for checking and unchecking checkboxes, so any browser that properly implements the "checked" property of the checkbox element will run this code flawlessly. This <em>should</em> be all major browsers, but I am unable to test previous to Internet&nbsp;Explorer&nbsp;9.  

<strong>The Problem</strong> (jQuery 1.6):  

Once a user clicks on a checkbox, that checkbox stops responding to the "checked" attribute changes.  

Here is an example of the checkbox attribute failing to do the job after someone has <em>clicked</em> the checkbox (this happens in Chrome).  

<strong><a href="http://jsfiddle.net/xixonia/zgcrB/">Fiddle</a></strong>  

<strong>The Solution:</strong>  

By using JavaScript's "checked" property on the <a href="http://en.wikipedia.org/wiki/Document_Object_Model">DOM</a> elements, we are able to solve the problem directly, instead of trying to manipulate the DOM into doing what we <em>want</em> it to do.  

<a href="http://jsfiddle.net/xixonia/WnbNC/"><strong>Fiddle</strong></a>  

This plugin will alter the checked property of any elements selected by jQuery, and successfully check and uncheck checkboxes under all circumstances. So, while this may seem like an over-bearing solution, it will make your site's user experience better, and help prevent user frustration.  

```javascript
(function( $ ) {
    $.fn.checked = function(value) {
        if(value === true || value === false) {
            // Set the value of the checkbox
            $(this).each(function(){ this.checked = value; });
        } 
        else if(value === undefined || value === 'toggle') {
            // Toggle the checkbox
            $(this).each(function(){ this.checked = !this.checked; });
        }

        return this;
    };
})( jQuery );
```

Alternatively, if you do not want to use a plugin, you can use the following code snippets:  

```javascript
// Check
$(':checkbox').prop('checked', true);

// Un-check
$(':checkbox').prop('checked', false);

// Toggle
$(':checkbox').prop('checked', function (i, value) {
    return !value;
});
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: How to replace all occurrences of a string? (score [3132930](https://stackoverflow.com/q/1144783) in 2019)

#### Question
I have this string:  

```javascript
"Test abc test test abc test test test abc test test abc"
```

Doing:  

```javascript
str = str.replace('abc', '');
```

seems to only remove the first occurrence of `abc` in the string above.  

How can I replace <strong>all</strong> occurrences of it?  

#### Answer accepted (score 2346)
For the sake of completeness, I got to thinking about which method I should use to do this. There are basically two ways to do this as suggested by the other answers on this page.  

<strong>Note:</strong> In general, extending the built-in prototypes in JavaScript is generally not recommended. I am providing as extensions on the String prototype simply for purposes of illustration, showing different implementations of a hypothetical standard method on the `String` built-in prototype.  

<hr>

<h5>Regular Expression Based Implementation</h3>

```javascript
String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};
```

<h5>Split and Join (Functional) Implementation</h3>

```javascript
String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.split(search).join(replacement);
};
```

<hr>

Not knowing too much about how regular expressions work behind the scenes in terms of efficiency, I tended to lean toward the split and join implementation in the past without thinking about performance. When I did wonder which was more efficient, and by what margin, I used it as an excuse to find out.  

On my Chrome Windows&nbsp;8 machine, <strong>the regular expression based implementation is the fastest</strong>, with the <strong>split and join implementation being 53% slower</strong>. Meaning the regular expressions are twice as fast for the lorem ipsum input I used.  

Check out this <a href="http://jsben.ch/#/LFfWA" rel="noreferrer"><strong>benchmark</strong></a> running these two implementations against each other.  

<hr>

As noted in the comment below by @ThomasLeduc and others, there could be an issue with the regular expression-based implementation if `search` contains certain characters which are reserved as <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions#Using_special_characters" rel="noreferrer">special characters in regular expressions</a>. The implementation assumes that the caller will escape the string beforehand or will only pass strings that are without the characters in the table in <em><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions#Using_special_characters" rel="noreferrer">Regular Expressions</a></em> (MDN).  

MDN also provides an implementation to escape our strings. It would be nice if this was also standardized as `RegExp.escape(str)`, but alas, it does not exist:  

```javascript
function escapeRegExp(str) {
  return str.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"); // $& means the whole matched string
}
```

We could call `escapeRegExp` within our `String.prototype.replaceAll` implementation, however, I'm not sure how much this will affect the performance (potentially even for strings for which the escape is not needed, like all alphanumeric strings).  

#### Answer 2 (score 4097)
```javascript
str = str.replace(/abc/g, '');
```

In response to comment:  

```javascript
var find = 'abc';
var re = new RegExp(find, 'g');

str = str.replace(re, '');
```

In response to <a href="https://stackoverflow.com/users/49153/click-upvote">Click Upvote</a>'s comment, you could simplify it even more:  

```javascript
function replaceAll(str, find, replace) {
    return str.replace(new RegExp(find, 'g'), replace);
}
```

<strong>Note:</strong> Regular expressions contain special (meta) characters, and as such it is dangerous to blindly pass an argument in the `find` function above without pre-processing it to escape those characters.  This is covered in the <a href="https://developer.mozilla.org/en-US/" rel="noreferrer">Mozilla Developer Network</a>'s <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions#Using_Special_Characters" rel="noreferrer">JavaScript Guide on Regular Expressions</a>, where they present the following utility function:  

```javascript
function escapeRegExp(str) {
    return str.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
}
```

So in order to make the `replaceAll()` function above safer, it could be modified to the following if you also include `escapeRegExp`:  

```javascript
function replaceAll(str, find, replace) {
    return str.replace(new RegExp(escapeRegExp(find), 'g'), replace);
}
```

#### Answer 3 (score 1286)
<strong>Note: Don't use this in real code.</strong>  

As an alternative to regular expressions for a simple literal string, you could use  

```javascript
str = "Test abc test test abc test...".split("abc").join("");
```

The general pattern is  

```javascript
str.split(search).join(replacement)
```

This used to be faster in some cases than using `replaceAll` and a regular expression, but that doesn't seem to be the case anymore in modern browsers. So, this should really only be used as a quick hack to avoid needing to escape the regular expression, not in real code.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How to append something to an array? (score [2888739](https://stackoverflow.com/q/351409) in 2017)

#### Question
How do I append an object (such as a string or number) to an array in JavaScript?            

#### Answer accepted (score 4026)
Use the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push" rel="noreferrer">`Array.prototype.push`</a> method to append values to an array:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
// initialize array
var arr = [
  "Hi",
  "Hello",
  "Bonjour"
];

// append new value to the array
arr.push("Hola");

console.log(arr);```
</div>
</div>


<hr>

You can use the `push()` function to append more than one value to an array in a single call:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
// initialize array
var arr = ["Hi", "Hello", "Bonjour", "Hola"];

// append multiple values to the array
arr.push("Salut", "Hey");

// display all values
for (var i = 0; i < arr.length; i++) {
  console.log(arr[i]);
}```
</div>
</div>


<hr>

<strong>Update</strong>  

If you want to add the items of one array to another array, you can use <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat" rel="noreferrer">`firstArray.concat(secondArray)`</a>:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var arr = [
  "apple",
  "banana",
  "cherry"
];

arr = arr.concat([
  "dragonfruit",
  "elderberry",
  "fig"
]);

console.log(arr);```
</div>
</div>


<strong>Update</strong>  

Just an addition to this answer if you want to append any value to the start of an array that means to the first index then you can use <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/unshift" rel="noreferrer">`Array.prototype.unshift`</a> for this purpose.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var arr = [1, 2, 3];
arr.unshift(0);
console.log(arr);```
</div>
</div>


It also supports appending multiple values at once just like `push`.  

#### Answer 2 (score 1005)
If you're only appending a single variable, then `push()` works just fine. If you need to append another array, use `concat()`:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var ar1 = [1, 2, 3];
var ar2 = [4, 5, 6];

var ar3 = ar1.concat(ar2);

alert(ar1);
alert(ar2);
alert(ar3);```
</div>
</div>


The concat does not affect `ar1` and `ar2` unless reassigned, for example:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var ar1 = [1, 2, 3];
var ar2 = [4, 5, 6];

ar1 = ar1.concat(ar2);
alert(ar1);```
</div>
</div>


Lots of great info <a href="http://www.javascriptkit.com/jsref/" rel="noreferrer">here</a>.  

#### Answer 3 (score 397)
Some quick benchmarking (each test = 500k appended elements and the results are averages of multiple runs) showed the following:  

Firefox 3.6 (Mac):  

<ul>
<li>Small arrays: <strong>`arr[arr.length] = b` is faster</strong> (300ms vs. 800ms)</li>
<li>Large arrays: <strong>`arr.push(b)` is faster</strong> (500ms vs. 900ms)</li>
</ul>

Safari 5.0 (Mac):  

<ul>
<li>Small arrays: <strong>`arr[arr.length] = b` is faster</strong> (90ms vs. 115ms)</li>
<li>Large arrays: <strong>`arr[arr.length] = b` is faster</strong> (160ms vs. 185ms)</li>
</ul>

Google Chrome 6.0 (Mac):  

<ul>
<li>Small arrays: <strong>No significant difference</strong> (and Chrome is FAST! Only ~38ms !!)</li>
<li>Large arrays: <strong>No significant difference</strong> (160ms)</li>
</ul>

I like the `arr.push()` syntax better, but I think I'd be better off with the `arr[arr.length]` Version, at least in raw speed. I'd love to see the results of an IE run though.  

<hr>

My benchmarking loops:  

```javascript
function arrpush_small() {
    var arr1 = [];
    for (a = 0; a < 100; a++)
    {
        arr1 = [];
        for (i = 0; i < 5000; i++)
        {
            arr1.push('elem' + i);
        }
    }
}

function arrlen_small() {
    var arr2 = [];
    for (b = 0; b < 100; b++)
    {
        arr2 = [];
        for (j = 0; j < 5000; j++)
        {
            arr2[arr2.length] = 'elem' + j;
        }
    }
}


function arrpush_large() {
    var arr1 = [];
    for (i = 0; i < 500000; i++)
    {
        arr1.push('elem' + i);
    }
}

function arrlen_large() {
    var arr2 = [];
    for (j = 0; j < 500000; j++)
    {
        arr2[arr2.length] = 'elem' + j;
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How do I include a JavaScript file in another JavaScript file? (score [2883256](https://stackoverflow.com/q/950087) in 2017)

#### Question
Is there something in JavaScript similar to `@import` in CSS that allows you to include a JavaScript file inside another JavaScript file?  

#### Answer accepted (score 4203)
The old versions of JavaScript had no import, include, or require, so many different approaches to this problem have been developed.  

But since 2015 (ES6), JavaScript has had the <a href="http://exploringjs.com/es6/ch_modules.html" rel="noreferrer">ES6 modules</a> standard to import modules in Node.js, which is also supported by <a href="https://caniuse.com/#feat=es6-module" rel="noreferrer">most modern browsers</a>.  

For compatibility with older browsers, <a href="https://webpack.github.io/" rel="noreferrer">build</a> and/or <a href="https://babeljs.io/" rel="noreferrer">transpilation</a> tools can be used.  

<h5>ES6 Modules</h1>

ECMAScript (ES6) modules have been supported in Node.js since v8.5, with the `--experimental-modules` flag. All files involved must have the `.mjs` extension.  

```javascript
// module.mjs
export function hello() {
  return "Hello";
}
```

```javascript
// main.mjs
import { hello } from 'module'; // or './module'
let val = hello();  // val is "Hello";
```

<h5>ECMAScript modules in browsers</h2>

Browsers have had support for loading ECMAScript modules directly (no tools like Webpack required) <a href="https://jakearchibald.com/2017/es-modules-in-browsers/" rel="noreferrer">since</a> Safari 10.1, Chrome 61, Firefox 60, and Edge 16. Check the current support at <a href="https://caniuse.com/#feat=es6-module" rel="noreferrer">caniuse</a>.  

```javascript
<script type="module">
  import { hello } from './hello.mjs';
  hello('world');
</script>
```

```javascript
// hello.mjs
export function hello(text) {
  const div = document.createElement('div');
  div.textContent = `Hello ${text}`;
  document.body.appendChild(div);
}
```

Read more at <a href="https://jakearchibald.com/2017/es-modules-in-browsers/" rel="noreferrer">https://jakearchibald.com/2017/es-modules-in-browsers/</a>  

<h5>Dynamic imports in browsers</h3>

Dynamic imports let the script load other scripts as needed:  

```javascript
<script type="module">
  import('hello.mjs').then(module => {
      module.hello('world');
    });
</script>
```

Read more at <a href="https://developers.google.com/web/updates/2017/11/dynamic-import" rel="noreferrer">https://developers.google.com/web/updates/2017/11/dynamic-import</a>  

<h5>Node.js require</h1>

The old style of importing modules, still widely used in Node.js, is the <a href="https://nodejs.org/api/modules.html" rel="noreferrer">module.exports/require</a> system.  

```javascript
// mymodule.js
module.exports = {
   hello: function() {
      return "Hello";
   }
}
```

```javascript
// server.js
const myModule = require('./mymodule');
let val = myModule.hello(); // val is "Hello"   
```

There are other ways for JavaScript to include external JavaScript contents in browsers that do not require preprocessing.  

<h5>AJAX Loading</h1>

You could load an additional script with an AJAX call and then use `eval` to run it. This is the most straightforward way, but it is limited to your domain because of the JavaScript sandbox security model. Using `eval` also opens the door to bugs, hacks and security issues.  

<h5>Fetch Loading</h1>

Like Dynamic Imports you can load one or many scripts with a `fetch` call using promises to control order of execution for script dependencies using the <a href="https://git.habd.as/jhabdas/fetch-inject" rel="noreferrer">Fetch Inject</a> library:  

```javascript
fetchInject([
  'https://cdn.jsdelivr.net/momentjs/2.17.1/moment.min.js'
]).then(() => {
  console.log(`Finish in less than ${moment().endOf('year').fromNow(true)}`)
})
```

<h5>jQuery Loading</h1>

The <a href="http://jquery.com/" rel="noreferrer">jQuery</a> library provides loading functionality <a href="http://api.jquery.com/jQuery.getScript/" rel="noreferrer">in one line</a>:  

```javascript
$.getScript("my_lovely_script.js", function() {
   alert("Script loaded but not necessarily executed.");
});
```

<h5>Dynamic Script Loading</h1>

You could add a script tag with the script URL into the HTML. To avoid the overhead of jQuery, this is an ideal solution.  

The script can even reside on a different server. Furthermore, the browser evaluates the code. The `&lt;script&gt;` tag can be injected into either the web page `&lt;head&gt;`, or inserted just before the closing `&lt;/body&gt;` tag.  

Here is an example of how this could work:  

```javascript
function dynamicallyLoadScript(url) {
    var script = document.createElement("script");  // create a script DOM node
    script.src = url;  // set its src to the provided URL

    document.head.appendChild(script);  // add it to the end of the head section of the page (could change 'head' to 'body' to add it to the end of the body section instead)
}
```

This function will add a new `&lt;script&gt;` tag to the end of the head section of the page, where the `src` attribute is set to the URL which is given to the function as the first parameter.  

Both of these solutions are discussed and illustrated in <a href="http://unixpapa.com/js/dyna.html" rel="noreferrer">JavaScript Madness: Dynamic Script Loading</a>.  

<h5>Detecting when the script has been executed</h1>

Now, there is a big issue you must know about. Doing that implies that <em>you remotely load the code</em>. Modern web browsers will load the file and keep executing your current script because they load everything asynchronously to improve performance. (This applies to both the jQuery method and the manual dynamic script loading method.)  

It means that if you use these tricks directly, <em>you won't be able to use your newly loaded code the next line after you asked it to be loaded</em>, because it will be still loading.  

For example: `my_lovely_script.js` contains `MySuperObject`:  

```javascript
var js = document.createElement("script");

js.type = "text/javascript";
js.src = jsFilePath;

document.body.appendChild(js);

var s = new MySuperObject();

Error : MySuperObject is undefined
```

Then you reload the page hitting <kbd>F5</kbd>. And it works! Confusing...  

<strong>So what to do about it ?</strong>  

Well, you can use the hack the author suggests in the link I gave you. In summary, for people in a hurry, he uses an event to run a callback function when the script is loaded. So you can put all the code using the remote library in the callback function. For example:  

```javascript
function loadScript(url, callback)
{
    // Adding the script tag to the head as suggested before
    var head = document.head;
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = url;

    // Then bind the event to the callback function.
    // There are several events for cross browser compatibility.
    script.onreadystatechange = callback;
    script.onload = callback;

    // Fire the loading
    head.appendChild(script);
}
```

Then you write the code you want to use AFTER the script is loaded in a <a href="http://en.wikipedia.org/wiki/Anonymous_function" rel="noreferrer">lambda function</a>:  

```javascript
var myPrettyCode = function() {
   // Here, do whatever you want
};
```

Then you run all that:  

```javascript
loadScript("my_lovely_script.js", myPrettyCode);
```

Note that the script may execute after the DOM has loaded, or before, depending on the browser and whether you included the line `script.async = false;`. There's a <a href="http://www.html5rocks.com/en/tutorials/speed/script-loading/" rel="noreferrer">great article on Javascript loading in general</a> which discusses this.  

<h5>Source Code Merge/Preprocessing</h1>

As mentioned at the top of this answer, many developers use build/transpilation tool(s) like Parcel, Webpack, or Babel in their projects, allowing them to use upcoming JavaScript syntax, provide backward compatibility for older browsers, combine files, minify, perform code splitting etc.  

#### Answer 2 (score 553)
If anyone is looking for something more advanced, try out <a href="http://requirejs.org/" rel="noreferrer">RequireJS</a>. You'll get added benefits such as dependency management, better concurrency, and avoid duplication (that is, retrieving a script more than once).  

You can write your JavaScript files in "modules" and then reference them as dependencies in other scripts. Or you can use RequireJS as a simple "go get this script" solution.  

Example:  

Define dependencies as modules:  

<strong>some-dependency.js</strong>  

```javascript
define(['lib/dependency1', 'lib/dependency2'], function (d1, d2) {

     //Your actual script goes here.   
     //The dependent scripts will be fetched if necessary.

     return libraryObject;  //For example, jQuery object
});
```

<strong>implementation.js</strong> is your "main" JavaScript file that depends on <strong>some-dependency.js</strong>  

```javascript
require(['some-dependency'], function(dependency) {

    //Your script goes here
    //some-dependency.js is fetched.   
    //Then your script is executed
});
```

Excerpt from the <a href="https://github.com/jrburke/requirejs" rel="noreferrer">GitHub</a> README:  

<blockquote>
  <p>RequireJS loads plain JavaScript files as well as more defined
  modules. It is optimized for in-browser use, including in a Web
  Worker, but it can be used in other JavaScript environments, like
  Rhino and Node. It implements the Asynchronous Module API.</p>
  
  <p>RequireJS uses plain script tags to load modules/files, so it should
  allow for easy debugging. It can be used simply to load existing
  JavaScript files, so <strong>you can add it to your existing project without
  having to re-write your JavaScript files.</strong></p>
  
  ...   
</blockquote>

#### Answer 3 (score 185)
There actually <em>is</em> a way to load a JavaScript file <em>not</em> asynchronously, so you could use the functions included in your newly loaded file right after loading it, and I think it works in all browsers.  

You need to use `jQuery.append()` on the `&lt;head&gt;` element of your page, that is:  

```javascript
$("head").append('<script type="text/javascript" src="' + script + '"></script>');
```

However, this method also has a problem: if an error happens in the imported JavaScript file, <a href="http://en.wikipedia.org/wiki/Firebug_%28software%29" rel="noreferrer">Firebug</a> (and also Firefox Error Console and <a href="https://developers.google.com/chrome-developer-tools/" rel="noreferrer">Chrome Developer Tools</a> as well) will report its place incorrectly, which is a big problem if you use Firebug to track JavaScript errors down a lot (I do). Firebug simply doesn't know about the newly loaded file for some reason, so if an error occurs in that file, it reports that it occurred in your main <a href="http://en.wikipedia.org/wiki/HTML" rel="noreferrer">HTML</a> file, and you will have trouble finding out the real reason for the error.  

But if that is not a problem for you, then this method should work.  

I have actually written a jQuery plugin called <em>$.import_js()</em> which uses this method:  

```javascript
(function($)
{
    /*
     * $.import_js() helper (for JavaScript importing within JavaScript code).
     */
    var import_js_imported = [];

    $.extend(true,
    {
        import_js : function(script)
        {
            var found = false;
            for (var i = 0; i < import_js_imported.length; i++)
                if (import_js_imported[i] == script) {
                    found = true;
                    break;
                }

            if (found == false) {
                $("head").append('<script type="text/javascript" src="' + script + '"></script>');
                import_js_imported.push(script);
            }
        }
    });

})(jQuery);
```

So all you would need to do to import JavaScript is:  

```javascript
$.import_js('/path_to_project/scripts/somefunctions.js');
```

I also made a simple test for this at <a href="http://www.kipras.com/dev/import_js_test/" rel="noreferrer">Example</a>.  

It includes a `main.js` file in the main HTML and then the script in `main.js` uses `$.import_js()` to import an additional file called `included.js`, which defines this function:  

```javascript
function hello()
{
    alert("Hello world!");
}
```

And right after including `included.js`, the `hello()` function is called, and you get the alert.  

(This answer is in response to e-satis' comment).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: How to validate an email address in JavaScript (score [2751724](https://stackoverflow.com/q/46155) in 2019)

#### Question
How can an email address be validated in JavaScript?  

#### Answer accepted (score 4568)
Using <a href="http://en.wikipedia.org/wiki/Regular_expression" rel="noreferrer">regular expressions</a> is probably the best way. You can see a bunch of tests <a href="http://jsfiddle.net/ghvj4gy9/embedded/result,js/" rel="noreferrer">here</a> (taken from <a href="https://cs.chromium.org/chromium/src/third_party/blink/web_tests/fast/forms/resources/ValidityState-typeMismatch-email.js?q=ValidityState-typeMismatch-email.js&amp;sq=package:chromium&amp;dr" rel="noreferrer">chromium</a>)  

```javascript
function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}
```

Here's the example of regular expresion that accepts unicode:  

```javascript
var re = /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
```

But keep in mind that one should not rely only upon JavaScript validation. JavaScript can easily be disabled. This should be validated on the server side as well.  

Here's an example of the above in action:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
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

$("#validate").on("click", validate);```
```javascript
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

<form>
  <p>Enter an email address:</p>
  <input id='email'>
  <button type='submit' id='validate'>Validate!</button>
</form>

<h2 id='result'></h2>```
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

```javascript
/\S+@\S+\.\S+/
```

Example JavaScript function:  

```javascript
function validateEmail(email) 
{
    var re = /\S+@\S+\.\S+/;
    return re.test(email);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: Get the current URL with JavaScript? (score [2692673](https://stackoverflow.com/q/1034621) in 2017)

#### Question
All I want is to get the website URL. Not the URL as taken from a link. On the page loading I need to be able to grab the full, current URL of the website and set it as a variable to do with as I please.  

#### Answer accepted (score 3517)
Use:  

```javascript
window.location.href 
```

As noted in the comments, the line below works, but it is bugged for Firefox.  

```javascript
document.URL;
```

See <strong><a href="https://web.archive.org/web/20170327080647/http://www.w3.org/TR/DOM-Level-2-HTML/html.html#ID-46183437" rel="noreferrer">URL of type DOMString, readonly</a></strong>.  

#### Answer 2 (score 619)
<strong>URL Info Access</strong>  

JavaScript provides you with many methods to retrieve and change the current URL, which is displayed in the browser's address bar. All these methods use the `Location` object, which is a property of the `Window` object. You can create a new `Location` object that has the current URL as follows:  

```javascript
var currentLocation = window.location;
```

<strong>Basic URL Structure</strong>  

```javascript
<protocol>//<hostname>:<port>/<pathname><search><hash>
```

<ul>
<li><p><strong>protocol:</strong> Specifies the protocol name be used to access the resource on the Internet. (HTTP (without SSL) or HTTPS (with SSL))</p></li>
<li><p><strong>hostname:</strong> Host name specifies the host that owns the resource. For example, `www.stackoverflow.com`. A server provides services using the name of the host.</p></li>
<li><p><strong>port:</strong> A port number used to recognize a specific process to which an Internet or other network message is to be forwarded when it arrives at a server.</p></li>
<li><p><strong>pathname:</strong> The path gives info about the specific resource within the host that the Web client wants to access. For example, `/index.html`.</p></li>
<li><p><strong>query:</strong> A query string follows the path component, and provides a string of information that the resource can utilize for some purpose (for example, as parameters for a search or as data to be processed). </p></li>
<li><p><strong>hash:</strong> The anchor portion of a URL, includes the hash sign (#).</p></li>
</ul>

With these `Location` object properties you can access all of these URL components and what they can set or return:  

<ul>
<li><strong>href</strong> - the entire URL</li>
<li><strong>protocol</strong> - the protocol of the URL</li>
<li><strong>host</strong> - the hostname and port of the URL</li>
<li><strong>hostname</strong> - the hostname of the URL</li>
<li><strong>port</strong> - the port number the server uses for the URL</li>
<li><strong>pathname</strong> - the path name of the URL</li>
<li><strong>search</strong> - the query portion of the URL</li>
<li><strong>hash</strong> - the anchor portion of the URL</li>
</ul>

I hope you got your answer..  

#### Answer 3 (score 315)
Use `window.location` for read and write access to the <a href="https://developer.mozilla.org/En/DOM/Window.location#Location_object" rel="nofollow noreferrer">location object</a> associated with the current frame. If you just want to get the address as a read-only string, you may use `document.URL`, which should contain the same value as `window.location.href`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: How do you get a timestamp in JavaScript? (score [2691791](https://stackoverflow.com/q/221294) in 2019)

#### Question
How can I get a timestamp in JavaScript?  

Something similar to <a href="https://en.wikipedia.org/wiki/Unix_time" rel="noreferrer">Unix timestamp</a>, that is, a single number that represents the current time and date. Either as a number or a string.  

#### Answer accepted (score 4686)
<h5>Short &amp; Snazzy:</h1>

```javascript
+ new Date()
```

A unary operator like `plus` triggers the `valueOf` method in the `Date` object and it returns the timestamp (without any alteration).  

<strong>Details:</strong>  

On almost all current browsers you can use <a href="http://www.ecma-international.org/ecma-262/5.1/#sec-15.9.4.4" rel="noreferrer">`Date.now()`</a> to get the UTC timestamp in <strong>milliseconds</strong>; a notable exception to this is IE8 and earlier (see <a href="http://kangax.github.io/compat-table/es5/#Date.now" rel="noreferrer">compatibility table</a>).  

You can easily make a shim for this, though:  

```javascript
if (!Date.now) {
    Date.now = function() { return new Date().getTime(); }
}
```

To get the timestamp in <strong>seconds</strong>, you can use:  

```javascript
Math.floor(Date.now() / 1000)
```

Or alternatively you could use:  

```javascript
Date.now() / 1000 | 0
```

Which should be slightly faster, but also less readable (also <a href="https://stackoverflow.com/questions/7487977/using-bitwise-or-0-to-floor-a-number">see this answer</a>).  

I would recommend using `Date.now()` (with compatibility shim). It's slightly better because it's shorter &amp; doesn't create a new `Date` object. However, if you don't want a shim &amp; maximum compatibility, you could use the "old" method to get the timestamp in <strong>milliseconds</strong>:  

```javascript
new Date().getTime()
```

Which you can then convert to seconds like this:  

```javascript
Math.round(new Date().getTime()/1000)
```

And you can also use the `valueOf` method which we showed above:  

```javascript
new Date().valueOf()
```

<strong>Timestamp in Milliseconds</strong>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var timeStampInMs = window.performance && window.performance.now && window.performance.timing && window.performance.timing.navigationStart ? window.performance.now() + window.performance.timing.navigationStart : Date.now();

console.log(timeStampInMs, Date.now());```
</div>
</div>


#### Answer 2 (score 490)
I like this, because it is small:  

```javascript
+new Date
```

I also like this, because it is just as short and is compatible with modern browsers, and over 500 people voted that it is better:   

```javascript
Date.now()
```

#### Answer 3 (score 264)
JavaScript works with the number of milliseconds since the epoch whereas most other languages work with the seconds. You could work with milliseconds but as soon as you pass a value to say PHP, the PHP native functions will probably fail. So to be sure I always use the seconds, not milliseconds.  

This will give you a Unix timestamp (in seconds):  

```javascript
var unix = Math.round(+new Date()/1000);
```

This will give you the milliseconds since the epoch (not Unix timestamp):  

```javascript
var milliseconds = new Date().getTime();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: How to check empty/undefined/null string in JavaScript? (score [2687485](https://stackoverflow.com/q/154059) in 2018)

#### Question
I saw this <a href="https://stackoverflow.com/questions/10230/checking-for-string-contents-string-length-vs-empty-string">thread</a>, but I didn't see a JavaScript specific example. Is there a simple `string.Empty` available in JavaScript, or is it just a case of checking for `""`?  

#### Answer accepted (score 3265)
If you just want to check whether there's any value, you can do   

```javascript
if (strValue) {
    //do something
}
```

If you need to check specifically for an empty string over null, I would think checking against `""` is your best bet, using <a href="http://webreference.com/js/column26/stricteq.html" rel="noreferrer">the `===` operator</a> (so that you know that it is, in fact, a string you're comparing against).  

```javascript
if (strValue === "") {
    //...
}
```

#### Answer 2 (score 1048)
For checking if a string is empty, null or undefined I use:  

```javascript
function isEmpty(str) {
    return (!str || 0 === str.length);
}
```

For checking if a string is blank, null or undefined I use:  

```javascript
function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}
```

For checking if a string is blank or contains only white-space:  

```javascript
String.prototype.isEmpty = function() {
    return (this.length === 0 || !this.trim());
};
```

#### Answer 3 (score 272)
All the above are good but this will be even better. use `!!`(<em>not not</em>) operator.   

```javascript
if(!!str){
some code here;
}
```

or use type casting:  

```javascript
if(Boolean(str)){
    codes here;
}
```

<p>Both do the same function, type cast the variable to boolean, where `str` is a variable.<br>
Returns `false` for `null,undefined,0,000,"",false`.<br>
Returns `true` for string "0" and whitespace " ".</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: How do I check if an element is hidden in jQuery? (score [2524355](https://stackoverflow.com/q/178325) in 2019)

#### Question
It is possible to toggle the visibility of an element, using the functions `.hide()`, `.show()` or `.toggle()`?  

How would you test if an element is visible or hidden?  

#### Answer accepted (score 9107)
Since the question refers to a single element, this code might be more suitable:  

```javascript
// Checks css for display:[none|block], ignores visibility:[true|false]
$(element).is(":visible"); 

// The same works with hidden
$(element).is(":hidden"); 
```

Same as <a href="https://stackoverflow.com/questions/178325/how-do-you-test-if-something-is-hidden-in-jquery/178386#178386">twernt's suggestion</a>, but applied to a single element; and it <a href="https://stackoverflow.com/a/4685330/49942">matches the algorithm recommended in the jQuery FAQ</a>  

We use jQuery is() to check the selected element with another element, selector or any jQuery object. This method traverses along the DOM elements to find a match, which satisfies the passed parameter. It will return true if there is a match otherwise returns false.  

#### Answer 2 (score 1408)
You can use the <a href="http://docs.jquery.com/Selectors/hidden" rel="noreferrer">`hidden`</a> selector:  

```javascript
// Matches all elements that are hidden
$('element:hidden')
```

And the <a href="http://docs.jquery.com/Selectors/visible" rel="noreferrer">`visible`</a> selector:  

```javascript
// Matches all elements that are visible
$('element:visible')
```

#### Answer 3 (score 897)
```javascript
if ( $(element).css('display') == 'none' || $(element).css("visibility") == "hidden"){
    // element is hidden
}
```

Above method does not consider the visibility of the parent. To consider the parent as well, you should use `.is(":hidden")` or `.is(":visible")`.  

For example,  

```javascript
<div id="div1" style="display:none">
  <div id="div2" style="display:block">Div2</div>
</div>
```

<blockquote>
  The above method will consider `div2` visible while `:visible` not. But the above might be useful in many cases, especially when you need to find if there is any error divs visible in the hidden parent because in such conditions `:visible` will not work.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: How to change an element's class with JavaScript? (score [2446526](https://stackoverflow.com/q/195951) in 2019)

#### Question
How can I change a class of an HTML element in response to an `onclick` event using JavaScript?  

#### Answer accepted (score 3702)
<h5>Modern HTML5 Techniques for changing classes</h2>

Modern browsers have added <a href="https://developer.mozilla.org/en-US/docs/DOM/element.classList" rel="noreferrer"><strong>classList</strong></a> which provides methods to make it easier to manipulate classes without needing a library:  

```javascript
document.getElementById("MyElement").classList.add('MyClass');

document.getElementById("MyElement").classList.remove('MyClass');

if ( document.getElementById("MyElement").classList.contains('MyClass') )

document.getElementById("MyElement").classList.toggle('MyClass');
```

Unfortunately, these do not work in Internet Explorer prior to v10, though there is a <a href="http://en.wikipedia.org/wiki/Shim_(computing)" rel="noreferrer">shim</a> to add support for it to IE8 and IE9, available from <a href="https://developer.mozilla.org/en-US/docs/DOM/element.classList" rel="noreferrer">this page</a>. It is, though, getting more and more <a href="http://caniuse.com/#feat=classlist" rel="noreferrer">supported</a>.  

<h5>Simple cross-browser solution</h2>

The standard JavaScript way to select an element is using <a href="https://developer.mozilla.org/en-US/docs/DOM/document.getElementById" rel="noreferrer">`document.getElementById("Id")`</a>, which is what the following examples use - you can of course obtain elements in other ways, and in the right situation may simply use `this` instead - however, going into detail on this is beyond the scope of the answer.  

<h5>To change all classes for an element:</h3>

To replace all existing classes with one or more new classes, set the className attribute:  

```javascript
document.getElementById("MyElement").className = "MyClass";
```

(You can use a space-delimited list to apply multiple classes.)  

<h5>To add an additional class to an element:</h3>

To add a class to an element, without removing/affecting existing values, append a space and the new classname, like so:  

```javascript
document.getElementById("MyElement").className += " MyClass";
```

<h5>To remove a class from an element:</h3>

To remove a single class to an element, without affecting other potential classes, a simple regex replace is required:  

```javascript
document.getElementById("MyElement").className =
   document.getElementById("MyElement").className.replace
      ( /(?:^|\s)MyClass(?!\S)/g , '' )
/* Code wrapped for readability - above is all one statement */
```

An explanation of this regex is as follows:  

```javascript
(?:^|\s) # Match the start of the string, or any single whitespace character

MyClass  # The literal text for the classname to remove

(?!\S)   # Negative lookahead to verify the above is the whole classname
         # Ensures there is no non-space character following
         # (i.e. must be end of string or a space)
```

The `g` flag tells the replace to repeat as required, in case the class name has been added multiple times.  

<h5>To check if a class is already applied to an element:</h3>

The same regex used above for removing a class can also be used as a check as to whether a particular class exists:  

```javascript
if ( document.getElementById("MyElement").className.match(/(?:^|\s)MyClass(?!\S)/) )
```

<br/>  

<h5>Assigning these actions to onclick events:</h3>

Whilst it is possible to write JavaScript directly inside the HTML event attributes (such as `onclick="this.className+=' MyClass'"`) this is not recommended behaviour. Especially on larger applications, more maintainable code is achieved by separating HTML markup from JavaScript interaction logic.  

The first step to achieving this is by creating a function, and calling the function in the onclick attribute, for example:  

```javascript
<script type="text/javascript">
    function changeClass(){
        // Code examples from above
    }
</script>
...
<button onclick="changeClass()">My Button</button>
```

<sub><em>(It is not required to have this code in script tags, this is simply for brevity of example, and including the JavaScript in a distinct file may be more appropriate.)</em></sub>  

The second step is to move the onclick event out of the HTML and into JavaScript, for example using <a href="https://developer.mozilla.org/en-US/docs/DOM/element.addEventListener" rel="noreferrer">addEventListener</a>  

```javascript
<script type="text/javascript">
    function changeClass(){
        // Code examples from above
    }

    window.onload = function(){
        document.getElementById("MyElement").addEventListener( 'click', changeClass);
    }
</script>
...
<button id="MyElement">My Button</button>
```

(Note that the window.onload part is required so that the contents of that function are executed <em>after</em> the HTML has finished loading - without this, the MyElement might not exist when the JavaScript code is called, so that line would fail.)  

<br/>  

<h5>JavaScript Frameworks and Libraries</h2>

The above code is all in standard JavaScript, however it is common practise to use either a framework or a library to simplify common tasks, as well as benefit from fixed bugs and edge cases that you might not think of when writing your code.  

Whilst some people consider it overkill to add a ~50&nbsp;KB framework for simply changing a class, if you are doing any substantial amount of JavaScript work, or anything that might have unusual cross-browser behaviour, it is well worth considering.  

<em>(Very roughly, a library is a set of tools designed for a specific task, whilst a framework generally contains multiple libraries and performs a complete set of duties.)</em>  

The examples above have been reproduced below using <a href="http://jquery.com" rel="noreferrer">jQuery</a>, probably the most commonly used JavaScript library (though there are others worth investigating too).  

(Note that `$` here is the jQuery object.)  

<h5>Changing Classes with jQuery:</h3>

```javascript
$('#MyElement').addClass('MyClass');

$('#MyElement').removeClass('MyClass');

if ( $('#MyElement').hasClass('MyClass') )
```

In addition, jQuery provides a shortcut for adding a class if it doesn't apply, or removing a class that does:  

```javascript
$('#MyElement').toggleClass('MyClass');
```

<br/>  

<h5>Assigning a function to a click event with jQuery:</h3>

```javascript
$('#MyElement').click(changeClass);
```

or, without needing an id:  

```javascript
$(':button:contains(My Button)').click(changeClass);
```

<br/>  

#### Answer 2 (score 403)
You could also just do:  

<pre>
document.getElementById('id').classList.add('class');
document.getElementById('id').classList.remove('class');
</pre>

And to toggle a class (remove if exists else add it):  

<pre>
document.getElementById('id').classList.toggle('class');
</pre>

#### Answer 3 (score 109)
In one of my old projects that did not use jQuery, I built the following functions for adding, removing and checking if element has class:  

```javascript
function hasClass(ele, cls) {
    return ele.className.match(new RegExp('(\\s|^)' + cls + '(\\s|$)'));
}
function addClass(ele, cls) {
    if (!hasClass(ele, cls)) ele.className += " " + cls;
}
function removeClass(ele, cls) {
    if (hasClass(ele, cls)) {
        var reg = new RegExp('(\\s|^)' + cls + '(\\s|$)');
        ele.className = ele.className.replace(reg, ' ');
    }
}
```

So, for example, if I want `onclick` to add some class to the button I can use this:  

```javascript
<script type="text/javascript">
    function changeClass(btn, cls) {
        if(!hasClass(btn, cls)) {
            addClass(btn, cls);
        }
    }
</script>
...
<button onclick="changeClass(this, "someClass")">My Button</button>
```

By now for sure it would just be better to use jQuery.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: How do I get the current date in JavaScript? (score [2442657](https://stackoverflow.com/q/1531093) in 2018)

#### Question
How do I get current date in JavaScript?  

#### Answer accepted (score 2489)
Use `new Date()` to generate a new `Date` object containing the current date and time.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```javascript
var today = new Date();
var dd = String(today.getDate()).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
var yyyy = today.getFullYear();

today = mm + '/' + dd + '/' + yyyy;
document.write(today);```
</div>
</div>


This will give you today's date in the format of mm/dd/yyyy.  

Simply change `today = mm +'/'+ dd +'/'+ yyyy;` to whatever format you wish.  

#### Answer 2 (score 409)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var utc = new Date().toJSON().slice(0,10).replace(/-/g,'/');
document.write(utc);```
</div>
</div>


Use the `replace` option if you're going to reuse the `utc` variable, such as `new Date(utc)`, as Firefox and Safari don't recognize a date with dashes.  

#### Answer 3 (score 222)
<blockquote>
  <strong><em>UPDATED!</em></strong>, Scroll Down  
</blockquote>

If you want something simple pretty to the end-user ... <em>`Also, fixed a small suffix issue in the first version below. Now properly returns suffix.`</em>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```javascript
var objToday = new Date(),
	weekday = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'),
	dayOfWeek = weekday[objToday.getDay()],
	domEnder = function() { var a = objToday; if (/1/.test(parseInt((a + "").charAt(0)))) return "th"; a = parseInt((a + "").charAt(1)); return 1 == a ? "st" : 2 == a ? "nd" : 3 == a ? "rd" : "th" }(),
	dayOfMonth = today + ( objToday.getDate() < 10) ? '0' + objToday.getDate() + domEnder : objToday.getDate() + domEnder,
	months = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'),
	curMonth = months[objToday.getMonth()],
	curYear = objToday.getFullYear(),
	curHour = objToday.getHours() > 12 ? objToday.getHours() - 12 : (objToday.getHours() < 10 ? "0" + objToday.getHours() : objToday.getHours()),
	curMinute = objToday.getMinutes() < 10 ? "0" + objToday.getMinutes() : objToday.getMinutes(),
	curSeconds = objToday.getSeconds() < 10 ? "0" + objToday.getSeconds() : objToday.getSeconds(),
	curMeridiem = objToday.getHours() > 12 ? "PM" : "AM";
var today = curHour + ":" + curMinute + "." + curSeconds + curMeridiem + " " + dayOfWeek + " " + dayOfMonth + " of " + curMonth + ", " + curYear;

document.getElementsByTagName('h1')[0].textContent = today;```
```javascript
<h1></h1>```
</div>
</div>


<blockquote>
  <strong>UBBER UPDATE</strong> After much procrastination, I've finally <a href="https://github.com/JDMcKinstry/JavaScriptDateFormat" rel="noreferrer"><strong>GitHubbed</strong></a> and updated this with the final solution I've been using for myself. It's even had some last-minute edits to make it sweeter! If you're looking for the old <a href="http://jsfiddle.net/SpYk3/rYzAY/" rel="noreferrer">jsFiddle, please see this</a>.  
</blockquote>

This update comes in <s>2</s> flavors, still relatively small, though not as small as my above, original answer. If you want extremely small, go with that. <br /> Also Note: This is still less bloated than moment.js. While moment.js is nice, imo, it has too many secular methods, which require learning moment as if it were a language. Mine here uses the same common format as <a href="http://php.net/manual/en/function.date.php" rel="noreferrer">PHP: date</a>.  

<h5>Quick Links</h3>

<ul>
<li><a href="https://cdn.rawgit.com/JDMcKinstry/JavaScriptDateFormat/master/Date.format.min.js" rel="noreferrer">Date.format.min.js</a> 5.08 KB</li>
<li><a href="https://cdn.rawgit.com/JDMcKinstry/JavaScriptDateFormat/master/dateFormat.min.js" rel="noreferrer">dateFormat.min.js</a> 4.16 KB</li>
</ul>

<blockquote>
  <p><strong>Flavor 1 <a href="http://jsfiddle.net/SpYk3/smdz6d43/" rel="noreferrer">`new Date().format(String)`</a></strong>
  My Personal Fav. I know the taboo but works great on the Date Object. Just be aware of any other mods you may have to the Date Object.</p>
</blockquote>

```javascript
//  use as simple as
new Date().format('m-d-Y h:i:s');   //  07-06-2016 06:38:34
```

<blockquote>
  <p><strong>Flavor 2 <a href="http://jsfiddle.net/SpYk3/tcqpw5d7/" rel="noreferrer">`dateFormat(Date, String)`</a></strong>
  More traditional all-in-one method. Has all the ability of the previous, but is called via the method with Date param.</p>
</blockquote>

```javascript
//  use as simple as
dateFormat(new Date(), 'm-d-Y h:i:s');  //  07-06-2016 06:38:34
```

<blockquote>
  <p><strong>BONUS Flavor (requires jQuery) <a href="https://github.com/JDMcKinstry/jQuery-Date" rel="noreferrer">`$.date(Date, String)`</a></strong>
  This contains much more than just a simple `format` option. It extends the base Date object and includes methods such as `addDays`. For more information, please see the <a href="https://github.com/JDMcKinstry/jQuery-Date" rel="noreferrer"><em>Git</em></a>.</p>
</blockquote>

In this mod, the format characters are inspired by <a href="http://php.net/manual/en/function.date.php" rel="noreferrer">PHP: date</a>. For a complete list, please see my <a href="https://github.com/JDMcKinstry/JavaScriptDateFormat/blob/master/README.md" rel="noreferrer">README</a>  

This mod also has a much longer list of pre-made formats. To use a premade format, simply enter its key name. `dateFormat(new Date(), 'pretty-a');`  

<ul>
<li>'compound'

<ul>
<li>'commonLogFormat' == 'd/M/Y:G:i:s'</li>
<li>'exif' == 'Y:m:d G:i:s'</li>
<li>'isoYearWeek' == 'Y\\WW'</li>
<li>'isoYearWeek2' == 'Y-\\WW'</li>
<li>'isoYearWeekDay' == 'Y\\WWj'</li>
<li>'isoYearWeekDay2' == 'Y-\\WW-j'</li>
<li>'mySQL' == 'Y-m-d h:i:s'</li>
<li>'postgreSQL' == 'Y.z'</li>
<li>'postgreSQL2' == 'Yz'</li>
<li>'soap' == 'Y-m-d\\TH:i:s.u'</li>
<li>'soap2' == 'Y-m-d\\TH:i:s.uP'</li>
<li>'unixTimestamp' == '@U'</li>
<li>'xmlrpc' == 'Ymd\\TG:i:s'</li>
<li>'xmlrpcCompact' == 'Ymd\\tGis'</li>
<li>'wddx' == 'Y-n-j\\TG:i:s'</li>
</ul></li>
<li>'constants'

<ul>
<li>'AMERICAN' == 'F j Y'</li>
<li>'AMERICANSHORT' == 'm/d/Y'</li>
<li>'AMERICANSHORTWTIME' == 'm/d/Y h:i:sA'</li>
<li>'ATOM' == 'Y-m-d\\TH:i:sP'</li>
<li>'COOKIE' == 'l d-M-Y H:i:s T'</li>
<li>'EUROPEAN' == 'j F Y'</li>
<li>'EUROPEANSHORT' == 'd.m.Y'</li>
<li>'EUROPEANSHORTWTIME' == 'd.m.Y H:i:s'</li>
<li>'ISO8601' == 'Y-m-d\\TH:i:sO'</li>
<li>'LEGAL' == 'j F Y'</li>
<li>'RFC822' == 'D d M y H:i:s O'</li>
<li>'RFC850' == 'l d-M-y H:i:s T'</li>
<li>'RFC1036' == 'D d M y H:i:s O'</li>
<li>'RFC1123' == 'D d M Y H:i:s O'</li>
<li>'RFC2822' == 'D d M Y H:i:s O'</li>
<li>'RFC3339' == 'Y-m-d\\TH:i:sP'</li>
<li>'RSS' == 'D d M Y H:i:s O'</li>
<li>'W3C' == 'Y-m-d\\TH:i:sP'</li>
</ul></li>
<li>'pretty'

<ul>
<li>'pretty-a' == 'g:i.sA l jS \\o\\f F Y'</li>
<li>'pretty-b' == 'g:iA l jS \\o\\f F Y'</li>
<li>'pretty-c' == 'n/d/Y g:iA'</li>
<li>'pretty-d' == 'n/d/Y'</li>
<li>'pretty-e' == 'F jS - g:ia'</li>
<li>'pretty-f' == 'g:iA'</li>
</ul></li>
</ul>

<em>As you may notice, you can use double `\` to escape a character.</em>  

<hr>

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: How do I check if an array includes a value in JavaScript? (score [2382154](https://stackoverflow.com/q/237104) in 2019)

#### Question
What is the most concise and efficient way to find out if a JavaScript array contains a value?  

This is the only way I know to do it:  

```javascript
function contains(a, obj) {
    for (var i = 0; i < a.length; i++) {
        if (a[i] === obj) {
            return true;
        }
    }
    return false;
}
```

Is there a better and more concise way to accomplish this?  

This is very closely related to Stack Overflow question <em><a href="https://stackoverflow.com/questions/143847/best-way-to-find-an-item-in-a-javascript-array">Best way to find an item in a JavaScript Array?</a></em> which addresses finding objects in an array using `indexOf`.  

#### Answer accepted (score 4127)
Current browsers have <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes#Browser_compatibility" rel="noreferrer">`Array#includes`</a>, which does <em>exactly</em> that, <a href="https://kangax.github.io/compat-table/es2016plus/#test-Array.prototype.includes" rel="noreferrer">is widely supported</a>, and has a <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes#Polyfill" rel="noreferrer">polyfill</a> for older browsers.  

```javascript
> ['joe', 'jane', 'mary'].includes('jane');
true 
```

You can also use <a href="https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/indexOf" rel="noreferrer">`Array#indexOf`</a>, which is less direct, but doesn't require Polyfills for out of date browsers.  

jQuery offers <a href="http://api.jquery.com/jquery.inarray/" rel="noreferrer">`$.inArray`</a>, which is functionally equivalent to `Array#indexOf`.  

<a href="http://underscorejs.org/#" rel="noreferrer">underscore.js</a>, a JavaScript utility library, offers <a href="http://underscorejs.org/#contains" rel="noreferrer">`_.contains(list, value)`</a>, alias `_.include(list, value)`, both of which use <a href="http://underscorejs.org/#indexOf" rel="noreferrer">indexOf</a> internally if passed a JavaScript array.  

Some other frameworks offer similar methods:  

<ul>
<li>Dojo Toolkit: <a href="http://dojotoolkit.org/reference-guide/dojo/indexOf.html" rel="noreferrer">`dojo.indexOf(array, value, [fromIndex, findLast])`</a></li>
<li>Prototype: <a href="http://api.prototypejs.org/language/Array/prototype/indexOf/" rel="noreferrer">`array.indexOf(value)`</a></li>
<li>MooTools: <a href="https://mootools.net/core/docs/1.6.0/Types/Array#Array:indexOf" rel="noreferrer">`array.indexOf(value)`</a></li>
<li>MochiKit: <a href="http://mochi.github.io/mochikit/doc/html/MochiKit/Base.html#fn-findvalue" rel="noreferrer">`findValue(array, value)`</a></li>
<li>MS Ajax: <a href="http://www.asp.net/ajaxlibrary/Reference.Array-indexOf-Function.ashx" rel="noreferrer">`array.indexOf(value)`</a></li>
<li>Ext: <a href="http://docs.sencha.com/extjs/4.0.0/#/api/Ext.Array-method-contains" rel="noreferrer">`Ext.Array.contains(array, value)`</a></li>
<li>Lodash: <a href="https://lodash.com/docs#includes" rel="noreferrer">`_.includes(array, value, [from])`</a> (is `_.contains` prior 4.0.0)</li>
<li>ECMAScript 2016: <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes" rel="noreferrer">`array.includes(value)`</a></li>
</ul>

Notice that some frameworks implement this as a function, while others add the function to the array prototype.  

#### Answer 2 (score 399)
<strong>Update from 2019: This answer is from 2008 (11 years old!) and is not relevant for modern JS usage. The promised performance improvement was based on a benchmark done in browsers of that time. It might not be relevant to modern JS execution contexts. If you need an easy solution, look for other answers. If you need the best performance, benchmark for yourself in the relevant execution environments.</strong>  

As others have said, the iteration through the array is probably the best way, but it <a href="http://blogs.oracle.com/greimer/entry/best_way_to_code_a" rel="noreferrer">has been proven</a> that a decreasing `while` loop is the fastest way to iterate in JavaScript. So you may want to rewrite your code as follows:  

```javascript
function contains(a, obj) {
    var i = a.length;
    while (i--) {
       if (a[i] === obj) {
           return true;
       }
    }
    return false;
}
```

Of course, you may as well extend Array prototype:  

```javascript
Array.prototype.contains = function(obj) {
    var i = this.length;
    while (i--) {
        if (this[i] === obj) {
            return true;
        }
    }
    return false;
}
```

And now you can simply use the following:  

```javascript
alert([1, 2, 3].contains(2)); // => true
alert([1, 2, 3].contains('2')); // => false
```

#### Answer 3 (score 189)
<a href="https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/Array/indexOf" rel="noreferrer">`indexOf`</a> maybe, but it's a "JavaScript extension to the ECMA-262 standard; as such it may not be present in other implementations of the standard."  

Example:  

```javascript
[1, 2, 3].indexOf(1) => 0
["foo", "bar", "baz"].indexOf("bar") => 1
[1, 2, 3].indexOf(4) => -1
```

AFAICS <a href="http://msdn.microsoft.com/en-us/library/k4h76zbx%5C%28VS.85%5C%29.aspx" rel="noreferrer">Microsoft does <em>not</em> offer some kind of alternative</a> to this, but you can add similar functionality to arrays in Internet Explorer (and other browsers that don't support `indexOf`) if you want to, as a <a href="http://google.com/search?q=indexof%20internet%20explorer" rel="noreferrer">quick Google search reveals</a> (for example, <a href="http://soledadpenades.com/2007/05/17/arrayindexof-in-internet-explorer/" rel="noreferrer">this one</a>).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How do I empty an array in JavaScript? (score [2380812](https://stackoverflow.com/q/1232040) in 2015)

#### Question
Is there a way to empty an array and if so possibly with `.remove()`?  

For instance,   

```javascript
A = [1,2,3,4];
```

How can I empty that?  

#### Answer accepted (score 4102)
Ways to clear an existing array `A`:  

<strong>Method 1</strong>  

(this was my original answer to the question)  

```javascript
A = [];
```

This code will set the variable `A` to a new empty array. This is perfect if you don't have <strong>references to the original array `A`</strong> anywhere else because this actually creates a brand new (empty) array. You should be careful with this method because if you have referenced this array from another variable or property, the original array will remain unchanged. Only use this if you only reference the array by its original variable `A`.  

This is also the fastest solution.  

This code sample shows the issue you can encounter when using this method:  

```javascript
var arr1 = ['a','b','c','d','e','f'];
var arr2 = arr1;  // Reference arr1 by another variable 
arr1 = [];
console.log(arr2); // Output ['a','b','c','d','e','f']
```

<strong>Method 2</strong> (as <a href="https://stackoverflow.com/a/1234337/113570">suggested</a> by <a href="https://stackoverflow.com/users/2214/matthew-crumley">Matthew Crumley</a>)  

```javascript
A.length = 0
```

This will clear the existing array by setting its length to 0. Some have argued that this may not work in all implementations of JavaScript, but it turns out that this is not the case. It also works when using "strict mode" in ECMAScript 5 because the length property of an array is a read/write property.  

<strong>Method 3</strong> (as <a href="https://stackoverflow.com/a/8134354/113570">suggested</a> by <a href="https://stackoverflow.com/users/1047275/anthony">Anthony</a>)  

```javascript
A.splice(0,A.length)
```

Using `.splice()` will work perfectly, but since the `.splice()` function will return an array with all the removed items, it will actually return a copy of the original array. Benchmarks suggest that this has no effect on performance whatsoever.  

<strong>Method 4</strong> (as <a href="https://stackoverflow.com/a/17306971/113570">suggested</a> by <a href="https://stackoverflow.com/users/990356/tanguy-k">tanguy_k</a>)  

```javascript
while(A.length > 0) {
    A.pop();
}
```

This solution is not very succinct, and it is also the slowest solution, contrary to earlier benchmarks referenced in the original answer.  

<strong>Performance</strong>  

Of all the methods of clearing an <strong><em>existing array</em></strong>, methods 2 and 3 are very similar in performance and are a lot faster than method 4. See this <a href="http://jsben.ch/#/hyj65" rel="noreferrer">benchmark</a>.  

As pointed out by <a href="https://stackoverflow.com/users/47401/diadistis">Diadistis</a> in their <a href="https://stackoverflow.com/a/28548360/113570">answer</a> below, the original benchmarks that were used to determine the performance of the four methods described above were flawed. The original benchmark reused the cleared array so the second iteration was clearing an array that was already empty.  

The following benchmark fixes this flaw: <a href="http://jsben.ch/#/hyj65" rel="noreferrer">http://jsben.ch/#/hyj65</a>. It clearly shows that methods #2 (length property) and #3 (splice) are the fastest (not counting method #1 which doesn't change the original array).  

<hr/>

This has been a hot topic and the cause of a lot of controversy. There are actually many correct answers and because this answer has been marked as the accepted answer for a very long time, I will include all of the methods here. If you vote for this answer, please upvote the other answers that I have referenced as well.  

#### Answer 2 (score 2385)
If you need to keep the original array because you have other references to it that should be updated too, you can clear it without creating a new array by setting its length to zero:  

```javascript
A.length = 0;
```

#### Answer 3 (score 280)
<s>Here the fastest working implementation</s> while <strong>keeping the same array</strong> ("mutable"):  

```javascript
function clearArray(array) {
  while (array.length) {
    array.pop();
  }
}
```

FYI it cannot be simplified to `while (array.pop())`: the tests will fail.  

FYI <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map/clear" rel="noreferrer">Map</a> and <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set/clear" rel="noreferrer">Set</a> define `clear()`, it would have seem logical to have `clear()` for <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array" rel="noreferrer">Array</a> too.  

TypeScript version:  

```javascript
function clearArray<T>(array: T[]) {
  while (array.length) {
    array.pop();
  }
}
```

The corresponding tests:  

```javascript
describe('clearArray()', () => {
  test('clear regular array', () => {
    const array = [1, 2, 3, 4, 5];
    clearArray(array);
    expect(array.length).toEqual(0);
    expect(array[0]).toEqual(undefined);
    expect(array[4]).toEqual(undefined);
  });

  test('clear array that contains undefined and null', () => {
    const array = [1, undefined, 3, null, 5];
    clearArray(array);
    expect(array.length).toEqual(0);
    expect(array[0]).toEqual(undefined);
    expect(array[4]).toEqual(undefined);
  });
});
```

Here the updated jsPerf: <s><a href="http://jsperf.com/array-destroy/32" rel="noreferrer">http://jsperf.com/array-destroy/32</a></s> <a href="http://jsperf.com/array-destroy/152" rel="noreferrer">http://jsperf.com/array-destroy/152</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: How can I refresh a page with jQuery? (score [2363933](https://stackoverflow.com/q/5404839) in 2013)

#### Question
How can I refresh a page with jQuery?  

#### Answer accepted (score 3693)
Use <a href="https://developer.mozilla.org/en-US/docs/Web/API/Location/reload" rel="noreferrer">`location.reload()`</a>:  

```javascript
$('#something').click(function() {
    location.reload();
});
```

The `reload()` function takes an optional parameter that can be set to `true` to force a reload from the server rather than the cache. The parameter defaults to `false`, so by default the page may reload from the browser's cache.  

#### Answer 2 (score 444)
This should work on all browsers even without jQuery:  

```javascript
location.reload();
```

#### Answer 3 (score 427)
There are <strike>multiple</strike> unlimited ways to refresh a page with JavaScript:  

<ol>
<li>`location.reload()`</li>
<li>`history.go(0)`</li>
<li>`location.href = location.href`</li>
<li>`location.href = location.pathname`</li>
<li>`location.replace(location.pathname)`</li>
<li><p>`location.reload(false)` </p>

<blockquote>
  <p>If we needed to pull the document from
   the web-server again (such as where the document contents
   change dynamically) we would pass the argument as `true`.</p>
</blockquote></li>
</ol>

You can continue the list being creative:  

<ul>
<li>`window.location = window.location`</li>
<li>`window.self.window.self.window.window.location = window.location`</li>
<li><a href="http://www.phpied.com/files/location-location/location-location.html" rel="noreferrer">...and other 534 ways</a></li>
</ul>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```javascript
var methods = [
  "location.reload()",
  "history.go(0)",
  "location.href = location.href",
  "location.href = location.pathname",
  "location.replace(location.pathname)",
  "location.reload(false)"
];

var $body = $("body");
for (var i = 0; i < methods.length; ++i) {
  (function(cMethod) {
    $body.append($("<button>", {
      text: cMethod
    }).on("click", function() {
      eval(cMethod); // don't blame me for using eval
    }));
  })(methods[i]);
}```
```javascript
button {
  background: #2ecc71;
  border: 0;
  color: white;
  font-weight: bold;
  font-family: "Monaco", monospace;
  padding: 10px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.5s ease;
  margin: 2px;
}
button:hover {
  background: #27ae60;
}```
```javascript
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 24: How to determine if variable is 'undefined' or 'null'? (score [2363523](https://stackoverflow.com/q/2647867) in 2016)

#### Question
How do I determine if variable is `undefined` or `null`?  My code is as follows:  

```javascript
var EmpName = $("div#esd-names div#name").attr('class');
if(EmpName == 'undefined'){
  //DO SOMETHING
};
```

```javascript
<div id="esd-names">
  <div id="name"></div>
</div>
```



But if I do this, the JavaScript interpreter halts execution.  

#### Answer accepted (score 2672)
You can use the qualities of the <a href="http://www.ecma-international.org/ecma-262/6.0/#sec-abstract-equality-comparison" rel="noreferrer">abstract equality operator</a> to do this:  

```javascript
if (variable == null){
    // your code here.
}
```

Because `null == undefined` is true, the above code will catch both `null` and `undefined`.  

#### Answer 2 (score 1059)
The standard way to catch `null` and `undefined` simultaneously is this:  

```javascript
if (variable == null) {
     // do something 
}
```

--which is 100% equivalent to the more explicit but less concise:  

```javascript
if (variable === undefined || variable === null) {
     // do something 
}
```

When writing professional JS, it's taken for granted that <a href="https://dorey.github.io/JavaScript-Equality-Table/" rel="noreferrer">type equality and the behavior of `==` vs `===`</a> is understood. Therefore we use `==` and only compare to `null`.  

<hr>

<h5><strong><em>Edit again</em></strong></h2>

The comments suggesting the use of `typeof` are simply <em>wrong.</em> Yes, my solution above will cause a ReferenceError if the variable doesn't exist. <em>This is a good thing.</em> This ReferenceError is desirable: it will help you find your mistakes and fix them before you ship your code, just like compiler errors would in other languages.  

<strong>You should not have any references to undeclared variables in your code.</strong>  

#### Answer 3 (score 208)
Combining the above answers, it seems the most complete answer would be:  

```javascript
if( typeof variable === 'undefined' || variable === null ){
    // Do stuff
}
```

This should work for any variable that is either undeclared or declared and explicitly set to null or undefined.  The boolean expression should evaluate to false for any declared variable that has an actual non-null value.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: Open a URL in a new tab (and not a new window) using JavaScript (score [2357996](https://stackoverflow.com/q/4907843) in 2019)

#### Question
I'm trying to open a <a href="https://en.wikipedia.org/wiki/URL" rel="noreferrer">URL</a> in a new tab, as opposed to a popup window.  

I've seen related questions where the responses would look something like:  

```javascript
window.open(url,'_blank');
window.open(url);
```

But none of them worked for me, the browser still tried to open a popup window.  

#### Answer accepted (score 834)
Nothing an author can do can choose to open in a new tab instead of a new window; it is a <em>user preference</em>.  

CSS3 proposed <a href="https://www.w3.org/TR/2004/WD-css3-hyperlinks-20040224/#target-new" rel="noreferrer">target-new</a>, but <a href="https://www.w3.org/TR/2014/NOTE-css3-hyperlinks-20141014/" rel="noreferrer">the specification was abandoned</a>.  

The <strong>reverse</strong> is not true; by specifying dimensions for the window in the third argument of `window.open()`, you can trigger a new window when the preference is for tabs.  

#### Answer 2 (score 1582)
This is a trick,    

```javascript
function openInNewTab(url) {
  var win = window.open(url, '_blank');
  win.focus();
}
```

In most cases, this should happen directly in the `onclick` handler for the link to prevent pop-up blockers, and the default "new window" behavior. You could do it this way, or by adding an event listener to your `DOM` object.    

```javascript
<div onclick="openInNewTab('www.test.com');">Something To Click On</div>
```

<a href="http://www.tutsplanet.com/open-url-new-tab-using-javascript/" rel="noreferrer">http://www.tutsplanet.com/open-url-new-tab-using-javascript/</a>  

#### Answer 3 (score 353)
`window.open()` will not open in a new tab if it is not happening on the actual click event. In the example given the URL is being opened on the actual click event. <strong>This will work provided the user has appropriate settings in the browser</strong>.  

```javascript
<a class="link">Link</a>
<script  type="text/javascript">
     $("a.link").on("click",function(){
         window.open('www.yourdomain.com','_blank');
     });
</script>
```

Similarly, if you are trying to do an Ajax call within the click function and want to open a window on success, ensure you are doing the Ajax call with the `async : false` option set.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: What is the JavaScript version of sleep()? (score [2356533](https://stackoverflow.com/q/951021) in 2018)

#### Question
Is there a better way to engineer a `sleep` in JavaScript than the following `pausecomp` function (<a href="http://www.sean.co.uk/a/webdesign/javascriptdelay.shtm" rel="noreferrer">taken from here</a>)?  

```javascript
function pausecomp(millis)
{
    var date = new Date();
    var curDate = null;
    do { curDate = new Date(); }
    while(curDate-date < millis);
}
```

This is not a duplicate of <a href="https://stackoverflow.com/questions/758688/sleep-in-javascript-delay-between-actions">Sleep in JavaScript - delay between actions</a>; I want a <em>real sleep</em> in the middle of a function, and not a delay before a piece of code executes.  

#### Answer accepted (score 2019)
<h5>2017 &mdash; 2019 update</h2>

Since 2009 when this question was asked, JavaScript has evolved significantly. All other answers are now obsolete or overly complicated. Here is the current best practice:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function demo() {
  console.log('Taking a break...');
  await sleep(2000);
  console.log('Two seconds later, showing sleep in a loop...');

  // Sleep in loop
  for (let i = 0; i < 5; i++) {
    if (i === 3)
      await sleep(2000);
    console.log(i);
  }
}

demo();```
</div>
</div>


<h5>This is it. `await sleep(&lt;duration&gt;)`.</h3>

Note that,  

<ol>
<li>`await` can only be executed in functions prefixed with the `async` keyword, or at the <a href="https://developers.google.com/web/updates/2017/08/devtools-release-notes#await" rel="noreferrer">top level</a> of your script in some environments (e.g. the Chrome DevTools console, or Runkit).</li>
<li>`await` only pauses the current `async` function</li>
</ol>

Two new JavaScript features helped write this "sleep" function:  

<ul>
<li><a href="https://ponyfoo.com/articles/es6-promises-in-depth" rel="noreferrer">Promises, a native feature of ES2015</a> (aka ES6). We also use <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions" rel="noreferrer">arrow functions</a> in the definition of the sleep function.</li>
<li>The <a href="https://ponyfoo.com/articles/understanding-javascript-async-await" rel="noreferrer">`async/await`</a> feature lets the code explicitly wait for a promise to settle (resolve or reject).</li>
</ul>

<h5>Compatibility</h2>

<ul>
<li>promises are supported <a href="http://node.green/#Promise" rel="noreferrer">in Node v0.12+</a> and <a href="http://caniuse.com/#feat=promises" rel="noreferrer">widely supported in browsers</a>, except IE</li>
<li>`async`/`await` landed in V8 and has been <a href="https://developers.google.com/web/fundamentals/getting-started/primers/async-functions" rel="noreferrer">enabled by default since Chrome 55</a> (released in Dec 2016)

<ul>
<li>it landed <a href="https://blog.risingstack.com/async-await-node-js-7-nightly/" rel="noreferrer">in Node 7 in October 2016</a></li>
<li>and also landed <a href="https://blog.nightly.mozilla.org/2016/11/01/async-await-support-in-firefox/" rel="noreferrer">in Firefox Nightly in November 2016</a></li>
</ul></li>
</ul>

If for some weird reason you're using Node older than 7 (which has reached <a href="https://github.com/nodejs/Release" rel="noreferrer">end of life</a>), or are targeting old browsers, `async`/`await` can still be used via <a href="https://babeljs.io/" rel="noreferrer">Babel</a> (a tool that will <a href="https://www.stevefenton.co.uk/2012/11/compiling-vs-transpiling/" rel="noreferrer">transpile</a> JavaScript + new features into plain old JavaScript), with the <a href="https://babeljs.io/docs/en/babel-plugin-transform-async-to-generator" rel="noreferrer">`transform-async-to-generator`</a> plugin.  

#### Answer 2 (score 845)
(See the <a href="https://stackoverflow.com/a/39914235/11236">updated answer for 2016</a>)  

I think it's perfectly reasonable to want to perform an action, wait, then perform another action. If you are used to writing in multi-threaded languages, you probably have the idea of yielding execution for a set amount of time until your thread wakes up.  

The issue here is that JavaScript is a single-thread event-based model. While in a specific case, it might be nice to have the whole engine wait for a few seconds, in general it is bad practice. Suppose I wanted to make use of your functions while writing my own? When I called your method, my methods would all freeze up. If JavaScript could somehow preserve your function's execution context, store it somewhere, then bring it back and continue later, then sleep could happen, but that would basically be threading.  

So you are pretty much stuck with what others have suggested -- you'll need to break your code up into multiple functions.  

Your question is a bit of a false choice, then. There is no way to sleep in the way you want, nor should you pursue the solution you suggest.  

#### Answer 3 (score 629)
In JavaScript, I rewrite every function so that it can end as soon as possible. You want the browser back in control so it can make your DOM changes.  

Every time I've wanted a sleep in the middle of my function, I refactored to use a `setTimeout()`.  

<blockquote>
  I am going to edit this answer because i found this as useful:  
</blockquote>

The infamous sleep, or delay, function within any language is much debated.  Some will say that there should always be a signal or callback to fire a given functionality, others will argue that sometimes an arbitrary moment of delay is useful.  I say that to each their own and one rule can never dictate anything in this industry.  

Writing a sleep function is simple and made even more usable with JavaScript Promises:  

```javascript
// sleep time expects milliseconds
function sleep (time) {
  return new Promise((resolve) => setTimeout(resolve, time));
}

// Usage!
sleep(500).then(() => {
    // Do something after the sleep!
});
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: jQuery scroll to element (score [2328481](https://stackoverflow.com/q/6677035) in 2017)

#### Question
I have this `input` element:  

```javascript
<input type="text" class="textfield" value="" id="subject" name="subject">
```

Then I have some other elements, like other text inputs, textareas, etc.  

When the user clicks on that `input` with `#subject`, the page should scroll to the last element of the page with a nice animation. It should be a scroll to bottom and not to top.  

The last item of the page is a `submit` button with `#submit`:  

```javascript
<input type="submit" class="submit" id="submit" name="submit" value="Ok, Done.">
```

The animation should not be too fast and should be fluid.  

I am running the latest jQuery version. I prefer to not install any plugin but to use the default jQuery features to achieve this.  

#### Answer accepted (score 3849)
Assuming you have a button with the id `button`, try this example:  

```javascript
$("#button").click(function() {
    $([document.documentElement, document.body]).animate({
        scrollTop: $("#elementtoScrollToID").offset().top
    }, 2000);
});
```

I got the code from the article <em><a href="http://www.abeautifulsite.net/smoothly-scroll-to-an-element-without-a-jquery-plugin-2/" rel="noreferrer">Smoothly scroll to an element without a jQuery plugin</a></em>. And I have tested it on the example below.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```javascript
<html>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function (){
            $("#click").click(function (){
                $('html, body').animate({
                    scrollTop: $("#div1").offset().top
                }, 2000);
            });
        });
    </script>
    <div id="div1" style="height: 1000px; width 100px">
        Test
    </div>
    <br/>
    <div id="div2" style="height: 1000px; width 100px">
        Test 2
    </div>
    <button id="click">Click me</button>
</html>```
</div>
</div>


#### Answer 2 (score 500)
<a href="http://demos.flesler.com/jquery/scrollTo/" rel="noreferrer"> <img src="https://i.stack.imgur.com/g55iQ.png" alt="jQuery .scrollTo() Method"> </a>  

<strong>jQuery .scrollTo(): <a href="http://demos.flesler.com/jquery/scrollTo/" rel="noreferrer"> View - Demo, API, Source </a></strong>  

I wrote this lightweight plugin to make page/element scrolling much easier. It's flexible where you could pass in a target element or specified value. Perhaps this could be part of jQuery's next official release, what do you think?  

<hr>

<strong>Examples Usage:</strong>  

```javascript
$('body').scrollTo('#target'); // Scroll screen to target element

$('body').scrollTo(500); // Scroll screen 500 pixels down

$('#scrollable').scrollTo(100); // Scroll individual element 100 pixels down
```

<hr>

<strong>Options:</strong>  

<em>scrollTarget</em>: A element, string, or number which indicates desired scroll position.  

<em>offsetTop</em>: A number that defines additional spacing above scroll target.  

<em>duration</em>: A string or number determining how long the animation will run.  

<em>easing</em>: A string indicating which easing function to use for the transition.  

<em>complete</em>: A function to call once the animation is complete.  

#### Answer 3 (score 341)
If you are not much interested in the smooth scroll effect and just interested in scrolling to a particular element, you don't require some jQuery function for this. Javascript has got your case covered:  

<a href="https://developer.mozilla.org/en-US/docs/Web/API/element.scrollIntoView">https://developer.mozilla.org/en-US/docs/Web/API/element.scrollIntoView</a>  

So all you need to do is: `$("selector").get(0).scrollIntoView();`    

`.get(0)` is used because we want to retrieve the JavaScript's DOM element and not the JQuery's DOM element.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: Which "href" value should I use for JavaScript links, "#" or "javascript:void(0)"? (score [2233339](https://stackoverflow.com/q/134845) in 2017)

#### Question
The following are two methods of building a link that has the sole purpose of running JavaScript code. Which is better, in terms of functionality, page load speed, validation purposes, etc.?  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```javascript
function myJsFunc() {
    alert("myJsFunc");
}```
```javascript
<a href="#" onclick="myJsFunc();">Run JavaScript Code</a>```
</div>
</div>


or  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```javascript
function myJsFunc() {
    alert("myJsFunc");
}```
```javascript
 <a href="javascript:void(0)" onclick="myJsFunc();">Run JavaScript Code</a>```
</div>
</div>


#### Answer 2 (score 2122)
I use `javascript:void(0)`.  

Three reasons. Encouraging the use of `#` amongst a team of developers inevitably leads to some using the return value of the function called like this:  

```javascript
function doSomething() {
    //Some code
    return false;
}
```

But then they forget to use `return doSomething()` in the onclick and just use `doSomething()`.  

A second reason for avoiding `#` is that the final `return false;` will not execute if the called function throws an error. Hence the developers have to also remember to handle any error appropriately in the called function.  

A third reason is that there are cases where the `onclick` event property is assigned dynamically.  I prefer to be able to call a function or assign it dynamically without having to code the function specifically for one method of attachment or another. Hence my `onclick` (or on anything) in HTML markup look like this:  

```javascript
onclick="someFunc.call(this)"
```

OR  

```javascript
onclick="someFunc.apply(this, arguments)"
```

Using `javascript:void(0)` avoids all of the above headaches, and I haven't found any examples of a downside.  

So if you're a lone developer then you can clearly make your own choice, but if you work as a team you have to either state:  

Use `href="#"`, make sure `onclick` always contains `return false;` at the end, that any called function does not throw an error and if you attach a function dynamically to the `onclick` property make sure that as well as not throwing an error it returns `false`.  

OR  

Use `href="javascript:void(0)"`  

The second is clearly much easier to communicate.  

#### Answer 3 (score 1283)
Neither.    

If you can have an actual URL that makes sense use that as the HREF.  The onclick won't fire if someone middle-clicks on your link to open a new tab or if they have JavaScript disabled.  

If that is not possible, then you should at least inject the anchor tag into the document with JavaScript and the appropriate click event handlers.    

I realize this isn't always possible, but in my opinion it should be striven for in developing any public website.  

Check out <em><a href="http://en.wikipedia.org/wiki/Unobtrusive_JavaScript" rel="noreferrer">Unobtrusive JavaScript</a></em> and <em><a href="http://en.wikipedia.org/wiki/Progressive_enhancement" rel="noreferrer">Progressive enhancement</a></em> (both Wikipedia).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: How to check for "undefined" in JavaScript? (score [2185286](https://stackoverflow.com/q/3390396) in 2014)

#### Question
What is the most appropriate way to test if a variable is undefined in JavaScript? I've seen several possible ways:  

```javascript
if (window.myVariable)
```

Or  

```javascript
if (typeof(myVariable) != "undefined")
```

Or  

```javascript
if (myVariable) //This throws an error if undefined. Should this be in Try/Catch?
```

#### Answer accepted (score 2534)
If you are interested in finding out whether a variable has been declared regardless of its value, then using the `in` operator is the safest way to go. Consider this example.  

```javascript
// global scope
var theFu; // theFu has been declared, but its value is undefined
typeof theFu; // "undefined"
```

But this may not be the intended result for some cases, since the variable or property was declared but just not initialized. Use the `in` operator for a more robust check.  

```javascript
"theFu" in window; // true
"theFoo" in window; // false
```

If you are interested in knowing whether the variable hasn't been declared or has the value `undefined`, then use the `typeof` operator.  

```javascript
if (typeof myVar !== 'undefined')
```

The `typeof` operator is guaranteed to return a string. Direct comparisons against `undefined` are troublesome as `undefined` can be overwritten.   

```javascript
window.undefined = "omg";
"omg" == undefined // true
```

As @CMS pointed out, this has been patched in ECMAScript 5th ed., and `undefined` is non-writable.  

`if (window.myVar)` will also include these falsy values, so it's not very robust:  

<pre>
false
0
""
NaN
null
undefined
</pre>

Thanks to @CMS for pointing out that your third case - `if (myVariable)` can also throw an error in two cases. The first is when the variable hasn't been defined which throws a `ReferenceError`.   

```javascript
// abc was never declared.
if (abc) {
    // ReferenceError: abc is not defined
} 
```

The other case is when the variable has been defined, but has a getter function which throws an error when invoked. For example,  

```javascript
// or it's a property that can throw an error
Object.defineProperty(window, "myVariable", { 
    get: function() { throw new Error("W00t?"); }, 
    set: undefined 
});
if (myVariable) {
    // Error: W00t?
}
```

#### Answer 2 (score 1075)
I personally use   

```javascript
myVar === undefined
```

Warning: Please note that `===` is used over `==` and that `myVar` has been previously <em>declared</em> (not <em>defined</em>).  

<hr>

I do not like `typeof myVar === "undefined"`. I think it is long winded and unnecessary. (I can get the same done in less code.)  

Now some people will keel over in pain when they read this, screaming: "Wait! WAAITTT!!! `undefined` can be redefined!"  

Cool. I know this. Then again, most variables in Javascript can be redefined. Should you never use any built-in identifier that can be redefined?  

If you follow this rule, good for you: you aren't a hypocrite.  

The thing is, in order to do lots of real work in JS, developers need to rely on redefinable identifiers to be what they are. I don't hear people telling me that I shouldn't use `setTimeout` because someone can  

```javascript
window.setTimeout = function () {
    alert("Got you now!");
};
```

Bottom line, the "it can be redefined" argument to not use a raw `=== undefined` is bogus.   

(If you are still scared of `undefined` being redefined, why are you blindly integrating untested library code into your code base? Or even simpler: a linting tool.)  

<hr>

Also, like the `typeof` approach, this technique can "detect" undeclared variables:   

```javascript
if (window.someVar === undefined) {
    doSomething();
}
```

But both these techniques leak in their abstraction. I urge you not to use this or even   

```javascript
if (typeof myVar !== "undefined") {
    doSomething();
}
```

Consider:  

```javascript
var iAmUndefined;
```

To catch whether or not that variable is declared or not, you may need to resort to the `in` operator. (In many cases, you can simply read the code O_o).  

```javascript
if ("myVar" in window) {
    doSomething();
}
```

But wait! There's more! What if some prototype chain magic is happening…? Now even the superior `in` operator does not suffice. (Okay, I'm done here about this part except to say that for 99% of the time, `=== undefined` (and ****cough**** `typeof`) works just fine. If you really care, you can read about this subject on its own.)  

#### Answer 3 (score 176)
Using `typeof` is my preference. It will work when the variable has never been declared, unlike any comparison with the `==` or `===` operators or type coercion using `if`. (`undefined`, unlike `null`, may also be redefined in ECMAScript 3 environments, making it unreliable for comparison, although nearly all common environments now are compliant with ECMAScript 5 or above).  

```javascript
if (typeof someUndeclaredVariable == "undefined") {
    // Works
}

if (someUndeclaredVariable === undefined) { 
    // Throws an error
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: Round to at most 2 decimal places (only if necessary) (score [2144234](https://stackoverflow.com/q/11832914) in 2019)

#### Question
I'd like to round at most 2 decimal places, but <em>only if necessary</em>.  

Input:  

```javascript
10
1.7777777
9.1
```

Output:  

```javascript
10
1.78
9.1
```

How can I do this in JavaScript?   

#### Answer accepted (score 3050)
Use `Math.round(num * 100) / 100`  

#### Answer 2 (score 2820)
If the value is a text type:  

```javascript
parseFloat("123.456").toFixed(2);
```

If the value is a number:  

```javascript
var numb = 123.23454;
numb = numb.toFixed(2);
```

There is a downside that values like 1.5 will give "1.50" as the output. A fix suggested by @minitech:  

```javascript
var numb = 1.5;
numb = +numb.toFixed(2);
// Note the plus sign that drops any "extra" zeroes at the end.
// It changes the result (which is a string) into a number again (think "0 + foo"),
// which means that it uses only as many digits as necessary.
```

It seems like `Math.round` is a better solution. <strong>But it is not!</strong> In some cases it will <strong>NOT</strong> round correctly:  

```javascript
Math.round(1.005 * 1000)/1000 // Returns 1 instead of expected 1.01!
```

toFixed() will also <strong>NOT</strong> round correctly in some cases (tested in Chrome v.55.0.2883.87)!  

Examples:  

```javascript
parseFloat("1.555").toFixed(2); // Returns 1.55 instead of 1.56.
parseFloat("1.5550").toFixed(2); // Returns 1.55 instead of 1.56.
// However, it will return correct result if you round 1.5551.
parseFloat("1.5551").toFixed(2); // Returns 1.56 as expected.

1.3555.toFixed(3) // Returns 1.355 instead of expected 1.356.
// However, it will return correct result if you round 1.35551.
1.35551.toFixed(2); // Returns 1.36 as expected.
```

I guess, this is because 1.555 is actually something like float 1.55499994 behind the scenes.  

<strong>Solution 1</strong> is to use a script with required rounding algorithm, for example:  

```javascript
function roundNumber(num, scale) {
  if(!("" + num).includes("e")) {
    return +(Math.round(num + "e+" + scale)  + "e-" + scale);
  } else {
    var arr = ("" + num).split("e");
    var sig = ""
    if(+arr[1] + scale > 0) {
      sig = "+";
    }
    return +(Math.round(+arr[0] + "e" + sig + (+arr[1] + scale)) + "e-" + scale);
  }
}
```

<a href="https://plnkr.co/edit/uau8BlS1cqbvWPCHJeOy?p=preview" rel="noreferrer">https://plnkr.co/edit/uau8BlS1cqbvWPCHJeOy?p=preview</a>  

<strong>Solution 2</strong> is to avoid front end calculations and pull rounded values from the backend server.  

#### Answer 3 (score 421)
You can use  

```javascript
function roundToTwo(num) {    
    return +(Math.round(num + "e+2")  + "e-2");
}
```

I found this over on <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/round" rel="noreferrer">MDN</a>. Their way avoids the problem with 1.005 that was <a href="https://stackoverflow.com/questions/11832914/round-up-to-2-decimal-places-in-javascript#comment24719818_11832950">mentioned</a>.  

```javascript
roundToTwo(1.005)
1.01
roundToTwo(10)
10
roundToTwo(1.7777777)
1.78
roundToTwo(9.1)
9.1
roundToTwo(1234.5678)
1234.57
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: Disable/enable an input with jQuery? (score [2086518](https://stackoverflow.com/q/1414365) in 2016)

#### Question
```javascript
$input.disabled = true;
```

or   

```javascript
$input.disabled = "disabled";
```

Which is the standard way? And, conversely, how do you enable a disabled input?  

#### Answer accepted (score 3694)
<h5>jQuery 1.6+</h2>

To change the `disabled` property you should use the <a href="http://api.jquery.com/prop" rel="noreferrer">`.prop()`</a> function.  

```javascript
$("input").prop('disabled', true);
$("input").prop('disabled', false);
```

<h5>jQuery 1.5 and below</h2>

The `.prop()` function doesn't exist, but <a href="http://api.jquery.com/attr" rel="noreferrer">`.attr()`</a> does similar:  

Set the disabled attribute.  

```javascript
$("input").attr('disabled','disabled');
```

To enable again, the proper method is to use <a href="//api.jquery.com/removeAttr" rel="noreferrer">`.removeAttr()`</a>  

```javascript
$("input").removeAttr('disabled');
```

<h5>In any version of jQuery</h2>

You can always rely on the actual DOM object and is probably a little faster than the other two options if you are only dealing with one element:  

```javascript
// assuming an event handler thus 'this'
this.disabled = true;
```

The advantage to using the `.prop()` or `.attr()` methods is that you can set the property for a bunch of selected items.  

<hr>

<strong>Note:</strong> In 1.6 there is a <a href="//api.jquery.com/removeProp" rel="noreferrer">`.removeProp()`</a> method that sounds a lot like `removeAttr()`, but it <strong>SHOULD NOT BE USED</strong> on native properties like `'disabled'`  Excerpt from the documentation:  

<blockquote>
  Note: Do not use this method to remove native properties such as checked, disabled, or selected. This will remove the property completely and, once removed, cannot be added again to element. Use .prop() to set these properties to false instead.  
</blockquote>

In fact, I doubt there are many legitimate uses for this method, boolean props are done in such a way that you should set them to false instead of "removing" them like their "attribute" counterparts in 1.5  

#### Answer 2 (score 55)
Just for the sake of new conventions &amp;&amp; making it adaptable going forward (unless things change drastically with ECMA6(????):  

```javascript
$(document).on('event_name', '#your_id', function() {
    $(this).removeAttr('disabled');
});
```

and  

```javascript
$(document).off('event_name', '#your_id', function() {
    $(this).attr('disabled','disabled');   
});
```

#### Answer 3 (score 31)
```javascript
    // Disable #x
    $( "#x" ).prop( "disabled", true );
    // Enable #x
    $( "#x" ).prop( "disabled", false );
```

<p>Sometimes you need to disable/enable the form element like input or textarea. Jquery helps you to easily make this with setting disabled attribute to "disabled".
For e.g.:</p>

```javascript
  //To disable 
  $('.someElement').attr('disabled', 'disabled');
```

To enable disabled element you need to remove "disabled" attribute from this element or empty it's string. For e.g:  

```javascript
//To enable 
$('.someElement').removeAttr('disabled');

// OR you can set attr to "" 
$('.someElement').attr('disabled', '');
```

refer :<a href="http://garmoncheg.blogspot.fr/2011/07/how-to-disableenable-element-with.html">http://garmoncheg.blogspot.fr/2011/07/how-to-disableenable-element-with.html</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: How can I know which radio button is selected via jQuery? (score [2061588](https://stackoverflow.com/q/596351) in 2017)

#### Question
<p>I have two radio buttons and want to post the value of the selected one.
How can I get the value with jQuery?</p>

I can get all of them like this:  

```javascript
$("form :radio")
```

How do I know which one is selected?  

#### Answer accepted (score 3797)
To get the value of the <strong>selected</strong> `radioName` item of a form with id `myForm`:  

```javascript
$('input[name=radioName]:checked', '#myForm').val()
```

Here's an example:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```javascript
$('#myForm input').on('change', function() {
   alert($('input[name=radioName]:checked', '#myForm').val()); 
});```
```javascript
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<form id="myForm">
  <input type="radio" name="radioName" value="1" /> 1 <br />
  <input type="radio" name="radioName" value="2" /> 2 <br />
  <input type="radio" name="radioName" value="3" /> 3 <br />
</form>```
</div>
</div>


#### Answer 2 (score 394)
Use this..    

```javascript
$("#myform input[type='radio']:checked").val();
```

#### Answer 3 (score 290)
If you already have a reference to a radio button group, for example:  

```javascript
var myRadio = $("input[name=myRadio]");
```

Use the `filter()` function, not `find()`. (`find()` is for locating child/descendant elements, whereas `filter()` searches top-level elements in your selection.)  

```javascript
var checkedValue = myRadio.filter(":checked").val();
```

<hr>

<em>Notes:</em> This answer was originally correcting another answer that recommended using `find()`, which seems to have since been changed. `find()` could still be useful for the situation where you already had a reference to a container element, but not to the radio buttons, e.g.:  

```javascript
var form = $("#mainForm");
...
var checkedValue = form.find("input[name=myRadio]:checked").val();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: How do I remove a property from a JavaScript object? (score [2051539](https://stackoverflow.com/q/208105) in 2017)

#### Question
Say I create an object as follows:  

```javascript
var myObject = {
    "ircEvent": "PRIVMSG",
    "method": "newURI",
    "regex": "^http://.*"
};
```

What is the best way to remove the property `regex` to end up with new `myObject` as follows?  

```javascript
var myObject = {
    "ircEvent": "PRIVMSG",
    "method": "newURI"
};
```

#### Answer accepted (score 7836)
Like this:  

```javascript
delete myObject.regex;
// or,
delete myObject['regex'];
// or,
var prop = "regex";
delete myObject[prop];
```

<p>Demo
<div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var myObject = {
    "ircEvent": "PRIVMSG",
    "method": "newURI",
    "regex": "^http://.*"
};
delete myObject.regex;

console.log(myObject);```
</div>
</div>


For anyone interested in reading more about it, Stack Overflow user <a href="https://stackoverflow.com/users/130652/kangax">kangax</a> has written an incredibly in-depth blog post about the `delete` statement on their blog, <em><a href="http://perfectionkills.com/understanding-delete/" rel="noreferrer">Understanding delete</a></em>. It is highly recommended.  

#### Answer 2 (score 864)
<h5>Operator `delete` is unexpectedly slow!</h2>

Look at the <strong><a href="http://jsperf.com/delete-vs-undefined-vs-null/16" rel="noreferrer">benchmark</a></strong>.  

<p>Delete is the only true way to remove object's properties without any leftovers, but it works <strong>~ 100 times slower</strong>, 
compared to its "alternative", setting `object[key] = undefined`.</p>

This alternative is not the correct answer to this question! But, if you use it with care, you can dramatically speed up some algorithms. If you are using `delete` in loops and you have problems with performance, read the verbose explanation.  

<h5>When should one use `delete` and when set value to `undefined` ?</h2>

An object may be seen as a set of key-value pairs. What I call a 'value' is a primitive or a reference to other object, connected to that 'key'.   

<strong>Use `delete`,</strong> when you are passing the result object to the code on which you don't have control (or when you are not sure about your team or yourself).  

It <strong>deletes the key from the hashmap</strong>.  

```javascript
 var obj = {
     field: 1     
 };
 delete obj.field;
```

<strong>Use setting to `undefined`,</strong> when you care about performance. It can give a serious boost to your code.   

The <strong>key remains on its place in the hashmap</strong>, only the value is replaced with `undefined`. Understand, that `for..in` loop will still iterate over that key.  

```javascript
 var obj = {
     field: 1     
 };
 obj.field = undefined;
```

Using this method, not all <a href="https://stackoverflow.com/questions/1894792/determining-if-a-javascript-object-has-a-given-property">ways of determining property existence</a> will work as expected.   

However, this code:  

`object.field === undefined`  

will behave equivalently for both methods.  

<h5>Tests</h2>

To summarize, differences are all about ways of determining the property existence, and about `for..in` loop.  

```javascript
 console.log('* -> "Takes prototype inheritance into consideration, that means it lookups all over prototype chain too."');

 console.log(obj.field === undefined, 'obj.field === undefined', 'You get "undefined" value when querying for "field" in object-hashmap. *');

 console.log(obj["field"] === undefined, 'obj["field"] === undefined', 'Just another way to query (equivalent). *');

 console.log(typeof obj.field === "undefined", 'typeof obj.field === "undefined"', 'Get the value attached to "field" key, and check it\'s type is "undefined". *');

 console.log("field" in obj, '"field" in obj', 'This statement returns true if "field" key exists in the hashmap. False otherwise. *');

 console.log(obj.hasOwnProperty("field"), 'obj.hasOwnProperty("field")', 'This statement returns true if \'field\' key exists in the hashmap. The ONLY way NOT to lookup for property in the prototype chain!');
 //Object.keys().indexOf() is an overkill that runs much slower :)

 var counter = 0,
     key;
 for (key in obj) {
     counter++;
 }
 console.assert(counter === 0, 'counter === 0', '"field" is not iterated using "for .. in" loop. *');
```

<h5>Beware Of Memory Leaks!</h2>

While using `obj[prop] = undefined` is faster than doing `delete obj[prop]`, another important consideration is that `obj[prop] = undefined` may not always be appropriate. `delete obj[prop]` removes `prop` from `obj` and erases it from memory whereas `obj[prop] = undefined` simply sets the value of `prop` to `undefined` which leaves `prop` still in memory. Therefore, in circumstances where there are many keys being created and deleted, using `obj[prop] = undefined` can force expensive memory reconciliation (causing the page to freeze up) and potentially an out-of-memory error. Examine the following code.  

```javascript
"use strict";
var theNodeList=[], i, current, numberOfNodes=65536, body=document.body, nodeRecords=[];
for (i = 0; i !== numberOfNodes; i++) {
    nodeRecords[i] = [];
    current = theNodeList[i] = document.createElement("div");
    current.textContent = i;
    document.body.appendChild( current );
}
var lastTime = -1;
requestAnimationFrame(function recordUpdates(){
    var currentTime = Math.round( performance.now()*1000 )
    for (i = 0; i !== numberOfNodes; i++) {
        if (lastTime !== -1) {
            // the previously collected data is no longer in use
            /*************************************************/
            /****/ nodeRecords[i][lastTime] = undefined; /****/
            /*************************************************/
        }
        nodeRecords[i][currentTime] = theNodeList[i].outerHTML;
    }
    lastTime = currentTime;
    requestAnimationFrame( recordUpdates );
});
```

In the code above, simply doing `nodeRecords[i][lastTime] = undefined;` will cause a massive memory leak because each animation frame. Each frame, all 65536 DOM elements will take up another 65536 individual slots, but the previous 65536 slots will only be set to undefined which leaves them hanging in the memory. Go ahead, try to run the above code in the console and see for yourself. After forcing an out-of-memory error, attempt to run it again except with the following version of the code that uses the `delete` operator instead.  

```javascript
"use strict";
var theNodeList=[], i, current, numberOfNodes=65536, body=document.body, nodeRecords=[];
for (i = 0; i !== numberOfNodes; i++) {
    nodeRecords[i] = [];
    current = theNodeList[i] = document.createElement("div");
    current.textContent = i;
    document.body.appendChild( current );
}
var lastTime = -1;
requestAnimationFrame(function recordUpdates(){
    var currentTime = Math.round( performance.now()*1000 )
    for (i = 0; i !== numberOfNodes; i++) {
        if (lastTime !== -1) {
            // the previously collected data is no longer in use
            /********************************************/
            /****/ delete nodeRecords[i][lastTime]; /****/
            /********************************************/
        }
        nodeRecords[i][currentTime] = theNodeList[i].outerHTML;
    }
    lastTime = currentTime;
    requestAnimationFrame( recordUpdates );
});
```

As seen in the above code snippet, there are some rare appropriate use cases for the `delete` operator. However, do not worry about this problem too much. This will only become a problem with long-lifespan objects that get new keys constantly added to them. In any other case (which is almost every case in real-world programming), it is most appropriate to use `obj[prop] = undefined`. The main purpose of this section is just to bring this to your attention so that in the rare chance that this does become a problem in your code, then you can more easily understand the problem and thus not have to waste hours dissecting your code to locate and understand this problem.  

<h5>Do Not Always Set To `undefined`</h2>

One aspect of Javascript that is important to consider is polymorphism. Polymorphism is when assigning the same variable/slot-in-an-object different types as seen below.  

```javascript
var foo = "str";
foo = 100;          // variable foo is now labeled polymorphic by the browser
var bar = ["Some", "example"];
bar[2] = "text";    // bar is a monomorphic array here because all its entries have the
                    // same type: string primitive
bar[1] = undefined; // bar is now a polymorphic array
```

However, there are two major unfixable problems with polymorphic arrays:  

<ol>
<li>They are slow &amp; memory inefficient. When accessing a specific index, instead of just getting the global type for the array, the browser instead has to get the type on a per-index basis whereby each index stores the additional metadata of its type.</li>
<li>Once polymorphic, always polymorphic. When an array is made polymorphic, the polymorphism cannot be undone in Webkit browsers. So, even if you restore a polymorphic array to being non-polymorphic, it will still be stored by the browser as a polymorphic array.</li>
</ol>

One may liken polymorphism to a drug addiction. At first glance, it seems awesomely lucrative: nice pretty fluffy code. Then, the coder introduces their array to the drug of polymorphism. Instantly, the polymorphic array becomes less efficient, and it can never become as efficient as it was before since it is drugged. To correlate such circumstance to real life, someone on cocaine might not even be capable of operating a simple door handle, much less be able to calculate digits of PI. Likewise, an array on the drug of polymorphism cannot ever be as efficient as a monomorphic array.  

But, how does a drug trip analogy relate to the `delete` operation? The answer inheres the last line of code in the snippet above. Thus let it be reexamined, this time with a twist.  

```javascript
var bar = ["Some", "example"];
bar[2] = "text";    // bar is not a polymorphic array here because all its entries have the
                    // same type: string primitive
bar[1] = "";        // bar is still a monomorphic array
bar[1] = undefined; // bar is now a polymorphic array
```

Observe. `bar[1] = ""` does not coerce polymorphism whereas `bar[1] = undefined` does. Therefore, one should always, whenever possible use the corresponding type for their objects so as to not accidentally cause polymorphism. One such person may use the following list as a general reference to get them going. However, please do not explicitly use the below ideas. Instead, use whatever works well for your code.  

<ul>
<li>When using an array/variable typed to the boolean primitive, use either `false` or `undefined` as the empty value. While avoiding unnecessary polymorphism is good, rewriting all your code to explicitly forbid it will likely actually result in a decrease in performance. Use common judgement!</li>
<li>When using an array/variable typed to the number primitive, use `0` as the empty value. Note that internally, there are two types of numbers: fast integers (2147483647 to -2147483648 inclusive) and slow floating point doubles (anything other than that including `NaN` and `Infinity`). When an integer is demoted to a double, it cannot be promoted back to an integer.</li>
<li>When using an array/variable typed to the string primitive, use `""` as the empty value.</li>
<li>When using a Symbol, wait, why are you using a Symbol?!?! Symbols are bad  juju for performance. Everything programmed to use Symbols can be reprogrammed to not use Symbols, resulting in a faster code without Symbols. Symbols are really just super inefficient meta-sugar.</li>
<li>When using anything else, use `null`.</li>
</ul>

However, be mindful! Do not suddenly start doing this with all your preexisting code now as it would likely break such preexisting code and/or introduce strange bugs. Rather, such an efficient practice needs to be implemented from the start, and when converting preexisting code, it is recommended that you double, triple, quadruple check all the lines relating to that as trying to upgrade old code to this new practice can be as risky as it is rewarding.  

#### Answer 3 (score 228)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var myObject = {"ircEvent": "PRIVMSG", "method": "newURI", "regex": "^http://.*"};
    
delete myObject.regex;

console.log ( myObject.regex); // logs: undefined```
</div>
</div>


This works in Firefox and Internet&nbsp;Explorer, and I think it works in all others.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: Get current URL with jQuery? (score [2039234](https://stackoverflow.com/q/406192) in 2018)

#### Question
I am using jQuery. How do I get the path of the current URL and assign it to a variable?  

Example URL:  

```javascript
http://localhost/menuname.de?foo=bar&amp;number=0
```

#### Answer accepted (score 2385)
To get the path, you can use:  

```javascript
var pathname = window.location.pathname; // Returns path only (/path/example.html)
var url      = window.location.href;     // Returns full URL (https://example.com/path/example.html)
var origin   = window.location.origin;   // Returns base URL (https://example.com)
```

#### Answer 2 (score 805)
In pure jQuery style:  

```javascript
$(location).attr('href');
```

The location object also has other properties, like host, hash, protocol, and pathname.  

#### Answer 3 (score 458)
```javascript
http://www.refulz.com:8082/index.php#tab2?foo=789

Property    Result
------------------------------------------
host        www.refulz.com:8082
hostname    www.refulz.com
port        8082
protocol    http:
pathname    index.php
href        http://www.refulz.com:8082/index.php#tab2
hash        #tab2
search      ?foo=789

var x = $(location).attr('<property>');
```

<strong>This will work only if you have jQuery. For example:</strong>  

```javascript
<html>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.min.js"></script>
<script>
  $(location).attr('href');      // http://www.refulz.com:8082/index.php#tab2
  $(location).attr('pathname');  // index.php
</script>
</html>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: Get selected text from a drop-down list (select box) using jQuery (score [1964098](https://stackoverflow.com/q/1643227) in 2018)

#### Question
How can I get the selected text (not the selected value) from a drop-down list in jQuery?  

#### Answer accepted (score 3662)
```javascript
$("#yourdropdownid option:selected").text();
```

#### Answer 2 (score 259)
Try this:  

```javascript
$("#myselect :selected").text();
```

For an ASP.NET dropdown you can use the following selector:  

```javascript
$("[id*='MyDropDownId'] :selected")
```

#### Answer 3 (score 207)
The answers posted here, for example,  

```javascript
$('#yourdropdownid option:selected').text();
```

didn't work for me, but this did:  

```javascript
$('#yourdropdownid').find('option:selected').text();
```

It is possibly an older version of jQuery.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: How can I add a key/value pair to a JavaScript object? (score [1959719](https://stackoverflow.com/q/1168807) in 2015)

#### Question
Here is my object literal:  

```javascript
var obj = {key1: value1, key2: value2};
```

How can I add `{key3: value3}` to the object?  

#### Answer accepted (score 2034)
There are two ways to add new <strong>properties</strong> to an object:  

```javascript
var obj = {
    key1: value1,
    key2: value2
};
```

<h5>Using dot notation:</h3>

```javascript
obj.key3 = "value3";
```

<h5>Using square bracket notation:</h3>

```javascript
obj["key3"] = "value3";
```

The first form is used when you know the name of the property. The second form is used when the name of the property is dynamically determined. Like in this example:  

```javascript
var getProperty = function (propertyName) {
    return obj[propertyName];
};

getProperty("key1");
getProperty("key2");
getProperty("key3");
```

<hr>

A <em>real</em> JavaScript array can be constructed using either:  

<h5>The Array literal notation:</h3>

```javascript
var arr = [];
```

<h5>The Array constructor notation:</h3>

```javascript
var arr = new Array();
```

#### Answer 2 (score 258)
<h5>Year 2017 answer: `Object.assign()`</h1>

<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign" rel="noreferrer">Object.assign(dest, src1, src2, ...)</a> merges objects.  

It overwrites `dest` with properties and values of (however many) source objects, then returns `dest`.  

<blockquote>
  The `Object.assign()` method is used to copy the values of all enumerable own properties from one or more source objects to a target object. It will return the target object.  
</blockquote>

<h5>Live example</h3>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var obj = {key1: "value1", key2: "value2"};
Object.assign(obj, {key3: "value3"});

document.body.innerHTML = JSON.stringify(obj);```
</div>
</div>


<h5>Year 2018 answer: object spread operator `{...}`</h1>

```javascript
obj = {...obj, ...pair};
```

From <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_operator#Spread_in_object_literals" rel="noreferrer">MDN</a>:  

<blockquote>
  It copies own enumerable properties from a provided object onto a new object.   
  
  Shallow-cloning (excluding prototype) or merging of objects is now possible using a shorter syntax than <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign" rel="noreferrer">`Object.assign()`</a>.  
  
  Note that <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign" rel="noreferrer">`Object.assign()`</a> triggers <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/set" rel="noreferrer">setters</a> whereas spread syntax doesn’t.  
</blockquote>

<h5>Live example</h3>

It works in current Chrome and current Firefox. They say it doesn’t work in current Edge.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var obj = {key1: "value1", key2: "value2"};
var pair = {key3: "value3"};
obj = {...obj, ...pair};

document.body.innerHTML = JSON.stringify(obj);```
</div>
</div>


<h5>Year 2019 answer</h1>

<s><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Assignment_Operators#Object_assignment" rel="noreferrer">Object assignment operator</a> `+=`:  

```javascript
obj += {key3: "value3"};
```

</s>Oops... I got carried away. Smuggling information from the future is illegal. Duly obscured!  

#### Answer 3 (score 84)
I have grown fond of the <a href="https://lodash.com" rel="noreferrer">LoDash</a> / <a href="http://underscorejs.org/" rel="noreferrer">Underscore</a> when writing larger projects.  

Adding by `obj['key']` or `obj.key` are all solid pure JavaScript answers. However both of LoDash and Underscore libraries do provide many additional convenient functions when working with Objects and Arrays in general.  

<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push" rel="noreferrer">`.push()` is for Arrays</a>, not for <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object#Methods" rel="noreferrer">objects</a>.  

Depending what you are looking for, there are two specific functions that may be nice to utilize and give functionality similar to the the feel of `arr.push()`. For more info check the docs, they have some great examples there.  

<h5><a href="https://lodash.com/docs#merge" rel="noreferrer">_.merge</a> (Lodash only)</h1>

<p>The second object will overwrite or add to the base object.
`undefined` values are not copied.</p>

```javascript
var obj = {key1: "value1", key2: "value2"};
var obj2 = {key2:"value4", key3: "value3", key4: undefined};
_.merge(obj, obj2);
console.log(obj);
// → {key1: "value1", key2: "value4", key3: "value3"} 
```

<h5><a href="https://lodash.com/docs#assign" rel="noreferrer">_.extend / _.assign</a></h1>

<p>The second object will overwrite or add to the base object.
`undefined` will be copied.</p>

```javascript
var obj = {key1: "value1", key2: "value2"};
var obj2 = {key2:"value4", key3: "value3", key4: undefined};
_.extend(obj, obj2);
console.log(obj);
// → {key1: "value1", key2: "value4", key3: "value3", key4: undefined}
```

<h5><a href="https://lodash.com/docs#defaults" rel="noreferrer">_.defaults</a></h1>

<p>The second object contains defaults that will be added to base object if they don't exist.
`undefined` values will be copied if key already exists.</p>

```javascript
var obj = {key3: "value3", key5: "value5"};
var obj2 = {key1: "value1", key2:"value2", key3: "valueDefault", key4: "valueDefault", key5: undefined};
_.defaults(obj, obj2);
console.log(obj);
// → {key3: "value3", key5: "value5", key1: "value1", key2: "value2", key4: "valueDefault"}
```

<h5><a href="http://api.jquery.com/jquery.extend/" rel="noreferrer">$.extend</a></h1>

In addition, it may be worthwhile mentioning jQuery.extend, it functions similar to _.merge and may be a better option if you already are using jQuery.  

<p>The second object will overwrite or add to the base object.
`undefined` values are not copied.</p>

```javascript
var obj = {key1: "value1", key2: "value2"};
var obj2 = {key2:"value4", key3: "value3", key4: undefined};
$.extend(obj, obj2); 
console.log(obj);
// → {key1: "value1", key2: "value4", key3: "value3"}
```

<h5><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign" rel="noreferrer">Object.assign()</a></h1>

It may be worth mentioning the ES6/ ES2015 Object.assign, it functions similar to _.merge and may be the best option if you already are using an ES6/ES2015 polyfill like <a href="https://github.com/babel-plugins/babel-plugin-object-assign" rel="noreferrer">Babel</a> if you want to <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign#Polyfill" rel="noreferrer">polyfill yourself</a>.  

<p>The second object will overwrite or add to the base object.
`undefined` will be copied.</p>

```javascript
var obj = {key1: "value1", key2: "value2"};
var obj2 = {key2:"value4", key3: "value3", key4: undefined};
Object.assign(obj, obj2); 
console.log(obj);
// → {key1: "value1", key2: "value4", key3: "value3", key4: undefined}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: How to get the value from the GET parameters? (score [1930107](https://stackoverflow.com/q/979975) in 2016)

#### Question
I have a URL with some GET parameters as follows:  

```javascript
www.test.com/t.html?a=1&b=3&c=m2-m3-m4-m5 
```

I need to get the whole value of `c`. I tried to read the URL, but I got only `m2`. How do I do this using JavaScript?  

#### Answer accepted (score 1775)
JavaScript <em>itself</em> has nothing built in for handling query string parameters.   

Code running in a (modern) browser you can use the <a href="https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams" rel="noreferrer">`URL` object</a> (which is part of the APIs provided by browsers to JS):  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var url_string = "http://www.example.com/t.html?a=1&b=3&c=m2-m3-m4-m5"; //window.location.href
var url = new URL(url_string);
var c = url.searchParams.get("c");
console.log(c);```
</div>
</div>


<hr>

For older browsers (including Internet Explorer), you can use <a href="https://github.com/ungap/url-search-params" rel="noreferrer">this polyfill</a> or the code from the original version of this answer that predates `URL`:  

You could access `location.search`, which would give you from the `?` character on to the end of the URL or the start of the fragment identifier (#foo), whichever comes first.  

Then you can parse it with this:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function parse_query_string(query) {
  var vars = query.split("&");
  var query_string = {};
  for (var i = 0; i < vars.length; i++) {
    var pair = vars[i].split("=");
    var key = decodeURIComponent(pair[0]);
    var value = decodeURIComponent(pair[1]);
    // If first entry with this name
    if (typeof query_string[key] === "undefined") {
      query_string[key] = decodeURIComponent(value);
      // If second entry with this name
    } else if (typeof query_string[key] === "string") {
      var arr = [query_string[key], decodeURIComponent(value)];
      query_string[key] = arr;
      // If third or later entry with this name
    } else {
      query_string[key].push(decodeURIComponent(value));
    }
  }
  return query_string;
}

var query_string = "a=1&b=3&c=m2-m3-m4-m5";
var parsed_qs = parse_query_string(query_string);
console.log(parsed_qs.c);```
</div>
</div>


You can get the query string from the URL of the current page with:  

```javascript
var query = window.location.search.substring(1);
var qs = parse_query_string(query);
```

#### Answer 2 (score 239)
Most implementations I've seen miss out URL-decoding the names and the values.  

Here's a general utility function that also does proper URL-decoding:  

```javascript
function getQueryParams(qs) {
    qs = qs.split('+').join(' ');

    var params = {},
        tokens,
        re = /[?&]?([^=]+)=([^&]*)/g;

    while (tokens = re.exec(qs)) {
        params[decodeURIComponent(tokens[1])] = decodeURIComponent(tokens[2]);
    }

    return params;
}

//var query = getQueryParams(document.location.search);
//alert(query.foo);
```

#### Answer 3 (score 224)
<a href="http://www.netlobo.com/url_query_string_javascript.html" rel="noreferrer">source</a>  

```javascript
function gup( name, url ) {
    if (!url) url = location.href;
    name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
    var regexS = "[\\?&]"+name+"=([^&#]*)";
    var regex = new RegExp( regexS );
    var results = regex.exec( url );
    return results == null ? null : results[1];
}
gup('q', 'hxxp://example.com/?q=abc')
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How can I create a two dimensional array in JavaScript? (score [1897981](https://stackoverflow.com/q/966225) in 2015)

#### Question
I have been reading online and some places say it isn't possible, some say it is and then give an example and others refute the example, etc.   

<ol>
<li><p>How do I declare a 2 dimensional array in JavaScript? (assuming it's possible) </p></li>
<li><p>How would I access its members? (`myArray[0][1]` or `myArray[0,1]`?)</p></li>
</ol>

#### Answer accepted (score 1194)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var items = [
  [1, 2],
  [3, 4],
  [5, 6]
];
console.log(items[0][0]); // 1
console.log(items[0][1]); // 2
console.log(items[1][0]); // 3
console.log(items[1][1]); // 4
console.log(items);```
</div>
</div>


#### Answer 2 (score 421)
You simply make each item within the array an array.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var x = new Array(10);

for (var i = 0; i < x.length; i++) {
  x[i] = new Array(3);
}

console.log(x);```
</div>
</div>


#### Answer 3 (score 186)
Similar to activa's answer, here's a function to create an n-dimensional array:  

```javascript
function createArray(length) {
    var arr = new Array(length || 0),
        i = length;

    if (arguments.length > 1) {
        var args = Array.prototype.slice.call(arguments, 1);
        while(i--) arr[length-1 - i] = createArray.apply(this, args);
    }

    return arr;
}

createArray();     // [] or new Array()

createArray(2);    // new Array(2)

createArray(3, 2); // [new Array(2),
                   //  new Array(2),
                   //  new Array(2)]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: How do I test for an empty JavaScript object? (score [1881498](https://stackoverflow.com/q/679915) in 2019)

#### Question
After an AJAX request, sometimes my application may return an empty object, like:  

```javascript
var a = {};
```

How can I check whether that's the case?  

#### Answer accepted (score 4582)
<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/entries#Browser_compatibility" rel="noreferrer">ECMA 7+</a>:  

```javascript
// because Object.entries(new Date()).length === 0;
// we have to do some additional check
Object.entries(obj).length === 0 && obj.constructor === Object
```

<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys#Browser_compatibility" rel="noreferrer">ECMA 5+</a>:  

```javascript
// because Object.keys(new Date()).length === 0;
// we have to do some additional check
Object.keys(obj).length === 0 && obj.constructor === Object
```

Pre-ECMA 5:  

```javascript
function isEmpty(obj) {
  for(var prop in obj) {
    if(obj.hasOwnProperty(prop)) {
      return false;
    }
  }

  return JSON.stringify(obj) === JSON.stringify({});
}
```

<a href="https://api.jquery.com/jQuery.isEmptyObject/" rel="noreferrer">jQuery</a>:  

```javascript
jQuery.isEmptyObject({}); // true
```

<a href="https://lodash.com/docs#isEmpty" rel="noreferrer">lodash</a>:  

```javascript
_.isEmpty({}); // true
```

<a href="https://underscorejs.org/#isEmpty" rel="noreferrer">Underscore</a>:  

```javascript
_.isEmpty({}); // true
```

<a href="https://github.com/hapijs/hoek" rel="noreferrer">Hoek</a>  

```javascript
Hoek.deepEqual({}, {}); // true
```

<a href="https://docs.sencha.com/extjs/6.0.2/modern/Ext.Object.html#method-isEmpty" rel="noreferrer">ExtJS</a>  

```javascript
Ext.Object.isEmpty({}); // true
```

<a href="https://docs.angularjs.org/api/ng/function/angular.equals" rel="noreferrer">AngularJS (version 1)</a>  

```javascript
angular.equals({}, {}); // true
```

<a href="https://ramdajs.com/docs/#isEmpty" rel="noreferrer">Ramda</a>  

```javascript
R.isEmpty({}); // true
```

#### Answer 2 (score 818)
There's no easy way to do this. You'll have to loop over the properties explicitly:  

```javascript
function isEmpty(obj) {
    for(var prop in obj) {
        if(obj.hasOwnProperty(prop))
            return false;
    }

    return true;
}
```

If <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys#Browser_compatibility" rel="noreferrer">ECMAScript 5 support</a> is available, you can use `Object.keys()` instead:  

```javascript
function isEmpty(obj) {
    return Object.keys(obj).length === 0;
}
```

#### Answer 3 (score 557)
For those of you who have the same problem but uses jQuery, you can use <a href="http://api.jquery.com/jQuery.isEmptyObject/" rel="noreferrer">jQuery.isEmptyObject</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: What is the most efficient way to deep clone an object in JavaScript? (score [1868130](https://stackoverflow.com/q/122102) in 2017)

#### Question
<p>What is the most efficient way to clone a JavaScript object? I've seen `obj = eval(uneval(o));` being used, but <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/uneval" rel="noreferrer">that's non-standard and only supported by Firefox</a>.<br/><br/> I've done things like `obj = JSON.parse(JSON.stringify(o));` but question the efficiency. <br/><br/> I've also seen recursive copying functions with various flaws.
<br />
I'm surprised no canonical solution exists.</p>

#### Answer accepted (score 4441)
<h5>Native deep cloning</h1>

It's called "structured cloning", works experimentally in Node 11 and later, and hopefully will land in browsers. See <a href="https://stackoverflow.com/questions/122102/what-is-the-most-efficient-way-to-deep-clone-an-object-in-javascript/10916838#10916838">this answer</a> for more details.  

<h5>Fast cloning with data loss - JSON.parse/stringify</h1>

If you do not use `Date`s, functions, `undefined`, `Infinity`, RegExps, Maps, Sets, Blobs, FileLists, ImageDatas, sparse Arrays, Typed Arrays or other complex types within your object, a very simple one liner to deep clone an object is:  

`JSON.parse(JSON.stringify(object))`  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
const a = {
  string: 'string',
  number: 123,
  bool: false,
  nul: null,
  date: new Date(),  // stringified
  undef: undefined,  // lost
  inf: Infinity,  // forced to 'null'
  re: /.*/,  // lost
}
console.log(a);
console.log(typeof a.date);  // Date object
const clone = JSON.parse(JSON.stringify(a));
console.log(clone);
console.log(typeof clone.date);  // result of .toISOString()```
</div>
</div>


See <a href="https://stackoverflow.com/questions/122102/what-is-the-most-efficient-way-to-deep-clone-an-object-in-javascript/5344074#5344074">Corban's answer</a> for benchmarks.  

<h5>Reliable cloning using a library</h1>

Since cloning objects is not trivial (complex types, circular references, function etc.), most major libraries provide function to clone objects. <strong>Don't reinvent the wheel</strong> - if you're already using a library, check if it has an object cloning function. For example,  

<ul>
<li>lodash - <a href="https://lodash.com/docs#cloneDeep" rel="noreferrer">`cloneDeep`</a>; can be imported separately via the <a href="https://www.npmjs.com/package/lodash.clonedeep" rel="noreferrer">lodash.clonedeep</a> module and is probably your best choice if you're not already using a library that provides a deep cloning function</li>
<li>AngularJS - <a href="https://docs.angularjs.org/api/ng/function/angular.copy" rel="noreferrer">`angular.copy`</a></li>
<li>jQuery - <a href="https://api.jquery.com/jquery.extend/#jQuery-extend-deep-target-object1-objectN" rel="noreferrer">`jQuery.extend(true, { }, oldObject)`</a>; `.clone()` only clones DOM elements</li>
</ul>

<h5>ES6</h1>

For completeness, note that ES6 offers two shallow copy mechanisms: <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign" rel="noreferrer">`Object.assign()`</a> and the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax" rel="noreferrer">spread operator</a>.  

#### Answer 2 (score 2210)
Checkout this benchmark: <a href="http://jsben.ch/#/bWfk9" rel="noreferrer">http://jsben.ch/#/bWfk9</a>  

In my previous tests where speed was a main concern I found   

```javascript
JSON.parse(JSON.stringify(obj))
```

to be the slowest way to deep clone an object (it is slower than <a href="https://api.jquery.com/jQuery.extend/" rel="noreferrer">jQuery.extend</a> with `deep` flag set true by 10-20%).  

jQuery.extend is pretty fast when the `deep` flag is set to `false` (shallow clone). It is a good option, because it includes some extra logic for type validation and doesn't copy over undefined properties, etc., but this will also slow you down a little.  

If you know the structure of the objects you are trying to clone or can avoid deep nested arrays you can write a simple `for (var i in obj)` loop to clone your object while checking hasOwnProperty and it will be much much faster than jQuery.  

Lastly if you are attempting to clone a known object structure in a hot loop you can get MUCH MUCH MORE PERFORMANCE by simply in-lining the clone procedure and manually constructing the object.  

JavaScript trace engines suck at optimizing `for..in` loops and checking hasOwnProperty will slow you down as well. Manual clone when speed is an absolute must.  

```javascript
var clonedObject = {
  knownProp: obj.knownProp,
  ..
}
```

Beware using the `JSON.parse(JSON.stringify(obj))` method on `Date` objects - `JSON.stringify(new Date())` returns a string representation of the date in ISO format, which `JSON.parse()` <strong>doesn't</strong> convert back to a `Date` object. <a href="https://stackoverflow.com/questions/11491938/issues-with-date-when-using-json-stringify-and-json-parse/11491993#11491993">See this answer for more details</a>.  

Additionally, please note that, in Chrome 65 at least, native cloning is not the way to go. According to <a href="https://jsperf.com/efficient-deep-cloning-teqniques" rel="noreferrer">this JSPerf</a>, performing native cloning by creating a new function is nearly <strong>800x</strong> slower than using JSON.stringify which is incredibly fast all the way across the board.  

<strong><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign" rel="noreferrer">Update for ES6</a></strong>  

If you are using Javascript ES6 try this native method for cloning or shallow copy.  

```javascript
Object.assign({}, obj);
```

#### Answer 3 (score 458)
Assuming that you have only variables and not any functions in your object, you can  just use:  

```javascript
var newObject = JSON.parse(JSON.stringify(oldObject));
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: How do I make the first letter of a string uppercase in JavaScript? (score [1858457](https://stackoverflow.com/q/1026069) in 2019)

#### Question
How do I make the first letter of a string uppercase, but not change the case of any of the other letters?  

For example:  

<ul>
<li>`"this is a test"` -> `"This is a test"`</li>
<li>`"the Eiffel Tower"` -> `"The Eiffel Tower"`</li>
<li>`"/index.html"` -> `"/index.html"`</li>
</ul>

#### Answer 2 (score 5446)
```javascript
function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}
```

Some other answers modify `String.prototype` (this answer used to as well), but I would advise against this now due to maintainability (hard to find out where the function is being added to the `prototype` and could cause conflicts if other code uses the same name / a browser adds a native function with that same name in future).  

#### Answer 3 (score 1305)
Here's a more object-oriented approach:  

```javascript
String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}
```

You'd call the function, like this:  

```javascript
"hello world".capitalize();
```

With the expected output being:  

```javascript
"Hello world" 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: Parse JSON in JavaScript? (score [1857919](https://stackoverflow.com/q/4935632) in 2017)

#### Question
I want to parse a JSON string in JavaScript. The response is something like  

```javascript
var response = '{"result":true,"count":1}';
```

How can I get the values `result` and `count` from this?  

#### Answer accepted (score 1944)
The standard way to parse JSON in JavaScript is <a href="http://msdn.microsoft.com/en-us/library/cc836466(v=vs.85).aspx" rel="noreferrer"><strong>`JSON.parse()`</strong></a>  

The <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON" rel="noreferrer">`JSON`</a> API was introduced with <a href="https://en.wikipedia.org/wiki/ECMAScript#5th_Edition" rel="noreferrer">ES5</a> (2011) and has since been implemented in >99% of browsers by market share, and Node.js. Its usage is simple:  

```javascript
const json = '{ "fruit": "pineapple", "fingers": 10 }';
const obj = JSON.parse(json);
console.log(obj.fruit, obj.fingers);
```

<hr>

The only time you won't be able to use `JSON.parse()` is if you are programming for an ancient browser, such as IE 7 (2006), IE 6 (2001), Firefox 3 (2008), Safari 3.x (2009), etc. Alternatively, you may be in an esoteric JavaScript environment that doesn't include the standard APIs. In these cases, use <a href="https://github.com/douglascrockford/JSON-js/blob/master/json2.js" rel="noreferrer">json2.js</a>, the reference implementation of JSON written by <a href="https://en.wikipedia.org/wiki/Douglas_Crockford" rel="noreferrer">Douglas Crockford</a>, the inventor of JSON. That library will provide an implementation of `JSON.parse()`.  

When processing extremely large JSON files, `JSON.parse()` may choke because of its synchronous nature and design. To resolve this, the JSON website recommends third-party libraries such as <a href="http://oboejs.com/" rel="noreferrer">Oboe.js</a> and <a href="https://github.com/dscape/clarinet" rel="noreferrer">clarinet</a>, which provide streaming JSON parsing.  

jQuery once had a <a href="https://api.jquery.com/jQuery.parseJSON/" rel="noreferrer">`$.parseJSON()`</a> function, but it was deprecated with jQuery 3.0. In any case, for a long time it was nothing more than a wrapper around `JSON.parse()`.  

#### Answer 2 (score 101)
<blockquote>
  <strong>WARNING!</strong>  
  
  This answer stems from an ancient era of JavaScript programming during which there was no builtin way to parse JSON. The advice given here is no longer applicable and probably dangerous. From a modern perspective, parsing JSON by involving jQuery or calling eval() is nonsense. Unless you need to support IE 7 or Firefox 3.0, the correct way to parse JSON is <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/parse" rel="nofollow noreferrer">JSON.parse()</a>.   
</blockquote>

First of all, you have to make sure that the JSON code is valid.  

After that, I would recommend using a JavaScript library such as jQuery or Prototype if you can because these things are handled well in those libraries.    

On the other hand, if you don't want to use a library and you can vouch for the validity of the JSON object, I would simply wrap the string in an anonymous function and use the eval function.   

This is not recommended if you are getting the JSON object from another source that isn't absolutely trusted because the eval function allows for renegade code if you will.    

Here is an example of using the eval function:  

```javascript
var strJSON = '{"result":true,"count":1}';
var objJSON = eval("(function(){return " + strJSON + ";})()");
alert(objJSON.result);
alert(objJSON.count);
```

If you control what browser is being used or you are not worried people with an older browser, you can always use the JSON.parse method.   

This is really the ideal solution for the future.  

#### Answer 3 (score 59)
If you are getting this from an outside site it might be helpful to use jQuery's getJSON. If it's a list you can iterate through it with $.each  

```javascript
$.getJSON(url, function (json) {
    alert(json.result);
    $.each(json.list, function (i, fb) {
        alert(fb.result);
    });
});
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Compare two dates with JavaScript (score [1785021](https://stackoverflow.com/q/492994) in 2019)

#### Question
Can someone suggest a way to compare the values of <strong>two dates</strong> greater than, less than, and not in the past using JavaScript? The values will be coming from text boxes.  

#### Answer accepted (score 1994)
The <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date" rel="nofollow noreferrer">Date object</a> will do what you want - construct one for each date, then compare them using the `&gt;`, `&lt;`, `&lt;=` or `&gt;=`.   

The `==`, `!=`, `===`, and `!==` operators require you to use `date.getTime()` as in   

```javascript
var d1 = new Date();
var d2 = new Date(d1);
var same = d1.getTime() === d2.getTime();
var notSame = d1.getTime() !== d2.getTime();
```

to be clear just checking for equality directly with the date objects won't work  

```javascript
var d1 = new Date();
var d2 = new Date(d1);

console.log(d1 == d2);   // prints false (wrong!) 
console.log(d1 === d2);  // prints false (wrong!)
console.log(d1 != d2);   // prints true  (wrong!)
console.log(d1 !== d2);  // prints true  (wrong!)
console.log(d1.getTime() === d2.getTime()); // prints true (correct)
```

I suggest you use drop-downs or some similar constrained form of date entry rather than text boxes, though, lest you find yourself in input validation hell.  

#### Answer 2 (score 405)
The easiest way to compare dates in javascript is to first convert it to a Date object and then compare these date-objects.  

Below you find an object with three functions:  

<ul>
<li><p><strong>dates.compare(a,b)</strong></p>

Returns a number:  

<ul>
<li>-1 if a &lt; b</li>
<li>0 if a = b</li>
<li>1 if a &gt; b</li>
<li>NaN if a or b is an illegal date</li>
</ul></li>
<li><p><strong>dates.inRange</strong> (d,start,end)</p>

Returns a boolean or NaN:  

<ul>
<li><em>true</em> if <em>d</em> is between the <em>start</em> and <em>end</em> (inclusive)</li>
<li><em>false</em> if <em>d</em> is before <em>start</em> or after <em>end</em>.</li>
<li>NaN if one or more of the dates are illegal.</li>
</ul></li>
<li><p><strong>dates.convert</strong></p>

Used by the other functions to convert their input to a date object. The input can be  

<ul>
<li>a <strong>date</strong>-object : The input is returned as is.</li>
<li>an <strong>array</strong>: Interpreted as [year,month,day]. <strong>NOTE</strong> month is 0-11.</li>
<li>a <strong>number</strong> : Interpreted as number of milliseconds since 1 Jan 1970 (a timestamp) </li>
<li>a <strong>string</strong> : Several different formats is supported, like "YYYY/MM/DD", "MM/DD/YYYY", "Jan 31 2009" etc.</li>
<li>an <strong>object</strong>: Interpreted as an object with year, month and date attributes.  <strong>NOTE</strong> month is 0-11.</li>
</ul></li>
</ul>

.  

```javascript
// Source: http://stackoverflow.com/questions/497790
var dates = {
    convert:function(d) {
        // Converts the date in d to a date-object. The input can be:
        //   a date object: returned without modification
        //  an array      : Interpreted as [year,month,day]. NOTE: month is 0-11.
        //   a number     : Interpreted as number of milliseconds
        //                  since 1 Jan 1970 (a timestamp) 
        //   a string     : Any format supported by the javascript engine, like
        //                  "YYYY/MM/DD", "MM/DD/YYYY", "Jan 31 2009" etc.
        //  an object     : Interpreted as an object with year, month and date
        //                  attributes.  **NOTE** month is 0-11.
        return (
            d.constructor === Date ? d :
            d.constructor === Array ? new Date(d[0],d[1],d[2]) :
            d.constructor === Number ? new Date(d) :
            d.constructor === String ? new Date(d) :
            typeof d === "object" ? new Date(d.year,d.month,d.date) :
            NaN
        );
    },
    compare:function(a,b) {
        // Compare two dates (could be of any type supported by the convert
        // function above) and returns:
        //  -1 : if a < b
        //   0 : if a = b
        //   1 : if a > b
        // NaN : if a or b is an illegal date
        // NOTE: The code inside isFinite does an assignment (=).
        return (
            isFinite(a=this.convert(a).valueOf()) &&
            isFinite(b=this.convert(b).valueOf()) ?
            (a>b)-(a<b) :
            NaN
        );
    },
    inRange:function(d,start,end) {
        // Checks if date in d is between dates in start and end.
        // Returns a boolean or NaN:
        //    true  : if d is between start and end (inclusive)
        //    false : if d is before start or after end
        //    NaN   : if one or more of the dates is illegal.
        // NOTE: The code inside isFinite does an assignment (=).
       return (
            isFinite(d=this.convert(d).valueOf()) &&
            isFinite(start=this.convert(start).valueOf()) &&
            isFinite(end=this.convert(end).valueOf()) ?
            start <= d && d <= end :
            NaN
        );
    }
}
```

#### Answer 3 (score 256)
Compare `&lt;` and `&gt;` just as usual, but anything involving `=` should use a `+` prefix. Like so:  

```javascript
var x = new Date('2013-05-23');
var y = new Date('2013-05-23');

// less than, greater than is fine:
x < y; => false
x > y; => false
x === y; => false, oops!

// anything involving '=' should use the '+' prefix
// it will then compare the dates' millisecond values
+x <= +y;  => true
+x >= +y;  => true
+x === +y; => true
```

Hope this helps!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: Checking if a key exists in a JavaScript object? (score [1769527](https://stackoverflow.com/q/1098040) in 2019)

#### Question
How do I check if a particular key exists in a JavaScript object or array?  

If a key doesn't exist, and I try to access it, will it return false? Or throw an error?  

#### Answer accepted (score 3716)
Checking for undefined-ness is not an accurate way of testing whether a key exists. What if the key exists but the value is actually `undefined`?  

```javascript
var obj = { key: undefined };
obj["key"] !== undefined // false, but the key exists!
```

You should instead use the `in` operator:  

```javascript
"key" in obj // true, regardless of the actual value
```

If you want to check if a key doesn't exist, remember to use parenthesis:  

```javascript
!("key" in obj) // true if "key" doesn't exist in object
!"key" in obj   // ERROR!  Equivalent to "false in obj"
```

Or, if you want to particularly test for properties of the object instance (and not inherited properties), use `hasOwnProperty`:  

```javascript
obj.hasOwnProperty("key") // true
```

For performance comparison between the methods that are `in`, `hasOwnProperty` and key is `undefined`, see this <a href="http://jsben.ch/#/WqlIl" rel="noreferrer"><strong>benchmark</strong></a>  

#### Answer 2 (score 270)
<h5>quick answer</h1>

<blockquote>
  <p>How do I check if a particular key exists in a JavaScript object or array?
  If a key doesn't exist and I try to access it, will it return false? Or throw an error?</p>
</blockquote>

Accessing directly a missing property using (associative) array style or object style will return an <em>undefined</em> constant.  

<h5>The slow and reliable <em>in</em> operator and <em>hasOwnProperty</em> method</h2>

As people have already mentioned here, you could have an object with a property associated with an "undefined" constant.   

```javascript
 var bizzareObj = {valid_key:  undefined};
```

In that case, you will have to use <em>hasOwnProperty</em> or <em>in</em> operator to know if the key is really there. But, <em>but at what price?</em>  

so, I tell you...  

<em>in</em> operator and <em>hasOwnProperty</em> are "methods" that use Property Descriptor mechanism in Javascript (similar to Java reflection in the Java language).  

<a href="http://www.ecma-international.org/ecma-262/5.1/#sec-8.10" rel="noreferrer">http://www.ecma-international.org/ecma-262/5.1/#sec-8.10</a>  

<blockquote>
  The Property Descriptor type is used to explain the manipulation and reification of named property attributes. Values of the Property Descriptor type are records composed of named fields where each field’s name is an attribute name and its value is a corresponding attribute value as specified in 8.6.1. In addition, any field may be present or absent.  
</blockquote>

On the other hand, calling an object method or key will use Javascript [[Get]] mechanism. That is far way faster!  

<h5>benchmark</h2>

<a href="http://jsperf.com/checking-if-a-key-exists-in-a-javascript-array" rel="noreferrer">http://jsperf.com/checking-if-a-key-exists-in-a-javascript-array</a>  

<img src="https://i.stack.imgur.com/GjzNU.png" alt="Comparing key access in JS">.  

Using <em>in</em> operator

```javascript
var result = "Impression" in array;
```

The result was   

```javascript
12,931,832 ±0.21% ops/sec      92% slower 
```

Using hasOwnProperty

```javascript
var result = array.hasOwnProperty("Impression")
```

The result was  

```javascript
16,021,758 ±0.45% ops/sec     91% slower
```

Accessing elements directly (brackets style)

```javascript
var result = array["Impression"] === undefined
```

The result was  

```javascript
168,270,439 ±0.13 ops/sec     0.02% slower 
```

Accessing elements directly (object style)

```javascript
var result = array.Impression  === undefined;
```

The result was  

```javascript
168,303,172 ±0.20%     fastest
```

<h5>EDIT: What is the reason to assign to a property the `undefined` value?</h2>

That question puzzles me. In Javascript, there are at least two references for absent objects to avoid problems like this: `null` and `undefined`.   

`null` is the primitive value that represents the intentional absence of any object value, or in short terms, the <strong>confirmed</strong> lack of value. On the other hand, `undefined` is unknown value (not defined). If there is a property that will be used later with a <em>proper</em> value consider use `null` reference instead of `undefined` because in the initial moment the property is <strong>confirmed</strong> to lack a value.  

Compare:   

```javascript
var a = {1: null}; 
console.log(a[1] === undefined); // output: false. I know the value at position 1 of a[] is absent and this was by design, i.e.:  the value is defined. 
console.log(a[0] === undefined); // output: true. I cannot say anything about a[0] value. In this case, the key 0 was not in a[].
```

<h5>Advise</h2>

Avoid objects with `undefined` values. Check directly whenever possible and use `null` to initialize property values. Otherwise, use the slow `in` operator or `hasOwnProperty()` method.  

<h5>EDIT: 12/04/2018 - NOT RELEVANT ANYMORE</h2>

As people have commented, modern versions of the Javascript engines (with firefox exception) has changed the approach for access properties. Current implementation is slower than the previous one for this particular case but difference between access key and object are neglectable.  

#### Answer 3 (score 130)
It will return `undefined`.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var aa = {hello: "world"};
alert( aa["hello"] );      // popup box with "world"
alert( aa["goodbye"] );    // popup box with "undefined"```
</div>
</div>


`undefined` is a special constant value.  So you can say, e.g.  

```javascript
// note the three equal signs so that null won't be equal to undefined
if( aa["goodbye"] === undefined ) {
    // do something
}
```

This is probably the best way to check for missing keys.  However, as is pointed out in a comment below, it's theoretically possible that you'd want to have the actual value be `undefined`.  I've never needed to do this and can't think of a reason offhand why I'd ever want to, but just for the sake of completeness, you can use the `in` operator  

```javascript
// this works even if you have {"goodbye": undefined}
if( "goodbye" in aa ) {
    // do something
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: How do I loop through or enumerate a JavaScript object? (score [1767834](https://stackoverflow.com/q/684672) in 2018)

#### Question
I have a JavaScript object like the following:  

```javascript
var p = {
    "p1": "value1",
    "p2": "value2",
    "p3": "value3"
};
```

Now I want to loop through all `p` elements (`p1`, `p2`, `p3`...) And get their keys and values. How can I do that?  

I can modify the JavaScript object if necessary. My ultimate goal is to loop through some key value pairs and if possible I want to avoid using `eval`.  

#### Answer accepted (score 4117)
You can use the `for-in` loop as shown by others. However, you also have to make sure that the key you get is an actual property of an object, and doesn't come from the prototype.  

<p><strong>Here is the snippet:</strong>
<div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var p = {
    "p1": "value1",
    "p2": "value2",
    "p3": "value3"
};

for (var key in p) {
    if (p.hasOwnProperty(key)) {
        console.log(key + " -> " + p[key]);
    }
}```
</div>
</div>


#### Answer 2 (score 1001)
Under ECMAScript 5, you can combine <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys" rel="noreferrer">`Object.keys()`</a> and <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach" rel="noreferrer">`Array.prototype.forEach()`</a>:  

```javascript
var obj = { first: "John", last: "Doe" };

Object.keys(obj).forEach(function(key) {
    console.log(key, obj[key]);
});
```

ECMAScript 6 adds <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...of" rel="noreferrer">`for...of`</a>:  

```javascript
for (const key of Object.keys(obj)) {
    console.log(key, obj[key]);
}
```

ECMAScript 8 adds <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/entries" rel="noreferrer">`Object.entries()`</a> which avoids having to look up each value in the original object:  

```javascript
Object.entries(obj).forEach(
    ([key, value]) => console.log(key, value)
);
```

You can combine `for...of`, destructuring, and `Object.entries`:  

```javascript
for (const [key, value] of Object.entries(obj)) {
    console.log(key, value);
}
```

Both `Object.keys()` and `Object.entries()` iterate properties in the same order as a `for...in` loop <em>but ignore the prototype chain</em>. Only the object's own enumerable properties are iterated.  

#### Answer 3 (score 332)
You have to use the <strong>for-in loop</strong>  

But be very careful when using this kind of loop, because this will <strong>loop all the properties along the prototype chain</strong>.  

Therefore, when using for-in loops, always make use of the `hasOwnProperty` method to determine if the current property in iteration is really a property of the object you're checking on:  

```javascript
for (var prop in p) {
    if (!p.hasOwnProperty(prop)) {
        //The current property is not a direct property of p
        continue;
    }
    //Do your logic with the property here
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: How to get the children of the $(this) selector? (score [1766627](https://stackoverflow.com/q/306583) in 2017)

#### Question
I have a layout similar to this:  

```javascript
<div id="..."><img src="..."></div>
```

and would like to use a jQuery selector to select the child `img` inside the `div` on click.  

To get the `div`, I've got this selector:  

```javascript
$(this)
```

How can I get the child `img` using a selector?  

#### Answer accepted (score 2813)
The jQuery constructor accepts a 2nd parameter called <a href="http://api.jquery.com/jQuery/#jQuery-selector-context" rel="noreferrer">`context`</a> which can be used to override the context of the selection.   

```javascript
jQuery("img", this);
```

Which is the same as using <a href="http://api.jquery.com/find" rel="noreferrer">`.find()`</a> like this:  

```javascript
jQuery(this).find("img");
```

If the imgs you desire are <strong>only</strong> direct descendants of the clicked element, you can also use <a href="http://api.jquery.com/children" rel="noreferrer">`.children()`</a>:  

```javascript
jQuery(this).children("img");
```

#### Answer 2 (score 459)
You could also use  

```javascript
$(this).find('img');
```

which would return all `img`s that are descendants of the `div`  

#### Answer 3 (score 133)
If you need to get the first `img` that's down exactly one level, you can do   

```javascript
$(this).children("img:first")
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: How can I convert a string to boolean in JavaScript? (score [1764203](https://stackoverflow.com/q/263965) in )

#### Question
Can I convert a string representing a boolean value (e.g., 'true', 'false') into a intrinsic type in JavaScript?  

I have a hidden form in HTML that is updated based upon a user's selection within a list. This form contains some fields which represent boolean values and are dynamically populated with an intrinsic boolean value. However, once this value is placed into the hidden input field it becomes a string.  

The only way I could find to determine the field's boolean value, once it was converted into a string, was to depend upon the literal value of its string representation.  

```javascript
var myValue = document.myForm.IS_TRUE.value;
var isTrueSet = myValue == 'true';
```

Is there a better way to accomplish this?  

#### Answer accepted (score 3095)
<h5>Do:</h1>

```javascript
var isTrueSet = (myValue == 'true');
```

You could make it stricter by using the identity operator (`===`), which doesn't make any implicit type conversions when the compared variables have different types, instead of the equality operator (`==`).  

```javascript
var isTrueSet = (myValue === 'true');
```

<hr>

<h5>Don't:</h2>

You should probably <strong>be cautious about using these two methods</strong> for your specific needs:  

```javascript
var myBool = Boolean("false");  // == true

var myBool = !!"false";  // == true
```

Any string which isn't the empty string will evaluate to `true` by using them. Although they're the cleanest methods I can think of concerning to boolean conversion, I think they're not what you're looking for.  

#### Answer 2 (score 635)
<h5>Warning</h1>

This highly upvoted legacy answer is technically correct but only covers a very specific scenario, when your string value is EXACTLY `"true"` or `"false"` (MUST be lowercase as well).  

An invalid json string passed into these functions below <strong>WILL throw an exception</strong>.  

<hr>

<strong>Original answer:</strong>  

How about?  

```javascript
JSON.parse("true");
```

or with jQuery  

```javascript
$.parseJSON("true");
```

#### Answer 3 (score 208)
```javascript
stringToBoolean: function(string){
    switch(string.toLowerCase().trim()){
        case "true": case "yes": case "1": return true;
        case "false": case "no": case "0": case null: return false;
        default: return Boolean(string);
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: Check if checkbox is checked with jQuery (score [1743815](https://stackoverflow.com/q/2204250) in 2018)

#### Question
How can I check if a checkbox in a checkbox array is checked using the id of the checkbox array?  

I am using the following code, but it always returns the count of checked checkboxes regardless of id.  

```javascript
function isCheckedById(id) {
  alert(id);
  var checked = $("input[@id=" + id + "]:checked").length;
  alert(checked);

  if (checked == 0) {
    return false;
  } else {
    return true;
  }
}
```

#### Answer accepted (score 645)
IDs must be unique in your document, meaning that you <strong>shouldn't</strong> do this:  

```javascript
<input type="checkbox" name="chk[]" id="chk[]" value="Apples" />
<input type="checkbox" name="chk[]" id="chk[]" value="Bananas" />
```

Instead, drop the ID, and then select them by name, or by a containing element:  

```javascript
<fieldset id="checkArray">
    <input type="checkbox" name="chk[]" value="Apples" />

    <input type="checkbox" name="chk[]" value="Bananas" />
</fieldset>
```

And now the jQuery:  

```javascript
var atLeastOneIsChecked = $('#checkArray:checkbox:checked').length > 0;
//there should be no space between identifier and selector

// or, without the container:

var atLeastOneIsChecked = $('input[name="chk[]"]:checked').length > 0;
```

#### Answer 2 (score 1923)
```javascript
$('#' + id).is(":checked")
```

That gets if the checkbox is checked.  

For an array of checkboxes with the same name you can get the list of checked ones by:  

```javascript
var $boxes = $('input[name=thename]:checked');
```

Then to loop through them and see what's checked you can do:  

```javascript
$boxes.each(function(){
    // Do stuff here with this
});
```

To find how many are checked you can do:  

```javascript
$boxes.length;
```

#### Answer 3 (score 283)
```javascript
$('#checkbox').is(':checked'); 
```

The above code returns true if the checkbox is checked or false if not.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: How do I correctly clone a JavaScript object? (score [1734289](https://stackoverflow.com/q/728360) in 2018)

#### Question
I have an object, `x`. I'd like to copy it as object `y`, such that changes to `y` do not modify `x`. I realized that copying objects derived from built-in JavaScript objects will result in extra, unwanted properties. This isn't a problem, since I'm copying one of my own, literal-constructed objects.  

How do I correctly clone a JavaScript object?  

#### Answer accepted (score 1486)
To do this for any object in JavaScript will not be simple or straightforward. You will run into the problem of erroneously picking up attributes from the object's prototype that should be left in the prototype and not copied to the new instance. If, for instance, you are adding a `clone` method to `Object.prototype`, as some answers depict, you will need to explicitly skip that attribute. But what if there are other additional methods added to `Object.prototype`, or other intermediate prototypes, that you don't know about? In that case, you will copy attributes you shouldn't, so you need to detect unforeseen, non-local attributes with the <a href="https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/Object/hasOwnProperty" rel="noreferrer" title="Mozilla JavaScript Reference: Object.hasOwnProperty">`hasOwnProperty`</a> method.  

In addition to non-enumerable attributes, you'll encounter a tougher problem when you try to copy objects that have hidden properties. For example, `prototype` is a hidden property of a function. Also, an object's prototype is referenced with the attribute `__proto__`, which is also hidden, and will not be copied by a for/in loop iterating over the source object's attributes. I think `__proto__` might be specific to Firefox's JavaScript interpreter and it may be something different in other browsers, but you get the picture. Not everything is enumerable. You can copy a hidden attribute if you know its name, but I don't know of any way to discover it automatically.  

Yet another snag in the quest for an elegant solution is the problem of setting up the prototype inheritance correctly. If your source object's prototype is `Object`, then simply creating a new general object with `{}` will work, but if the source's prototype is some descendant of `Object`, then you are going to be missing the additional members from that prototype which you skipped using the `hasOwnProperty` filter, or which were in the prototype, but weren't enumerable in the first place. One solution might be to call the source object's `constructor` property to get the initial copy object and then copy over the attributes, but then you still will not get non-enumerable attributes. For example, a <a href="https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/Date" rel="noreferrer" title="Mozilla JavaScript Reference: Date">`Date`</a> object stores its data as a hidden member:  

```javascript
function clone(obj) {
    if (null == obj || "object" != typeof obj) return obj;
    var copy = obj.constructor();
    for (var attr in obj) {
        if (obj.hasOwnProperty(attr)) copy[attr] = obj[attr];
    }
    return copy;
}

var d1 = new Date();

/* Executes function after 5 seconds. */
setTimeout(function(){
    var d2 = clone(d1);
    alert("d1 = " + d1.toString() + "\nd2 = " + d2.toString());
}, 5000);
```

The date string for `d1` will be 5 seconds behind that of `d2`. A way to make one `Date` the same as another is by calling the `setTime` method, but that is specific to the `Date` class. I don't think there is a bullet-proof general solution to this problem, though I would be happy to be wrong!  

When I had to implement general deep copying I ended up compromising by assuming that I would only need to copy a plain `Object`, `Array`, `Date`, `String`, `Number`, or `Boolean`. The last 3 types are immutable, so I could perform a shallow copy and not worry about it changing. I further assumed that any elements contained in `Object` or `Array` would also be one of the 6 simple types in that list. This can be accomplished with code like the following:  

```javascript
function clone(obj) {
    var copy;

    // Handle the 3 simple types, and null or undefined
    if (null == obj || "object" != typeof obj) return obj;

    // Handle Date
    if (obj instanceof Date) {
        copy = new Date();
        copy.setTime(obj.getTime());
        return copy;
    }

    // Handle Array
    if (obj instanceof Array) {
        copy = [];
        for (var i = 0, len = obj.length; i < len; i++) {
            copy[i] = clone(obj[i]);
        }
        return copy;
    }

    // Handle Object
    if (obj instanceof Object) {
        copy = {};
        for (var attr in obj) {
            if (obj.hasOwnProperty(attr)) copy[attr] = clone(obj[attr]);
        }
        return copy;
    }

    throw new Error("Unable to copy obj! Its type isn't supported.");
}
```

The above function will work adequately for the 6 simple types I mentioned, as long as the data in the objects and arrays form a tree structure. That is, there isn't more than one reference to the same data in the object. For example:  

```javascript
// This would be cloneable:
var tree = {
    "left"  : { "left" : null, "right" : null, "data" : 3 },
    "right" : null,
    "data"  : 8
};

// This would kind-of work, but you would get 2 copies of the 
// inner node instead of 2 references to the same copy
var directedAcylicGraph = {
    "left"  : { "left" : null, "right" : null, "data" : 3 },
    "data"  : 8
};
directedAcyclicGraph["right"] = directedAcyclicGraph["left"];

// Cloning this would cause a stack overflow due to infinite recursion:
var cyclicGraph = {
    "left"  : { "left" : null, "right" : null, "data" : 3 },
    "data"  : 8
};
cyclicGraph["right"] = cyclicGraph;
```

It will not be able to handle any JavaScript object, but it may be sufficient for many purposes as long as you don't assume that it will just work for anything you throw at it.  

#### Answer 2 (score 906)
If you do not use `Date`s, functions, undefined, or Infinity within your object, a very simple one liner is `JSON.parse(JSON.stringify(object))`:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
const a = {
  string: 'string',
  number: 123,
  bool: false,
  nul: null,
  date: new Date(),  // stringified
  undef: undefined,  // lost
  inf: Infinity,  // forced to 'null'
}
console.log(a);
console.log(typeof a.date);  // Date object
const clone = JSON.parse(JSON.stringify(a));
console.log(clone);
console.log(typeof clone.date);  // result of .toISOString()```
</div>
</div>


This works for all kind of objects containing objects, arrays, strings, booleans and numbers.  

See also <a href="https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/The_structured_clone_algorithm" rel="noreferrer">this article about the structured clone algorithm of browsers</a> which is used when posting messages to and from a worker. It also contains a function for deep cloning.  

#### Answer 3 (score 763)
With jQuery, you can <strong>shallow copy</strong> with <a href="http://api.jquery.com/jQuery.extend" rel="noreferrer">extend</a>:  

```javascript
var copiedObject = jQuery.extend({}, originalObject)
```

subsequent changes to the `copiedObject` will not affect the `originalObject`, and vice versa.  

Or to make a <strong>deep copy</strong>:  

```javascript
var copiedObject = jQuery.extend(true, {}, originalObject)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: Disable same origin policy in Chrome (score [1730961](https://stackoverflow.com/q/3102819) in 2019)

#### Question
Is there any way to disable the <a href="https://en.wikipedia.org/wiki/Same_origin_policy" rel="noreferrer">Same-origin policy</a> on Google's <a href="http://en.wikipedia.org/wiki/Google_Chrome" rel="noreferrer">Chrome</a> browser?  

#### Answer accepted (score 956)
Close chrome (or chromium) and restart with the `--disable-web-security` argument. I just tested this and verified that I can access the contents of an iframe with src="http://google.com" embedded in a page served from "localhost" (tested under chromium 5 / ubuntu). For me the exact command was:  

<strong>Note  :  Kill all chrome instances before running command</strong>  

```javascript
chromium-browser --disable-web-security --user-data-dir="[some directory here]"
```

The browser will warn you that "you are using an unsupported command line" when it first opens, which you can ignore.  

From the chromium source:  

```javascript
// Don't enforce the same-origin policy. (Used by people testing their sites.)
const wchar_t kDisableWebSecurity[] = L"disable-web-security";
```

<hr>

Before Chrome 48, you could just use:  

```javascript
chromium-browser --disable-web-security
```

#### Answer 2 (score 1039)
Yep. For OSX, open Terminal and run:  

```javascript
$ open -a Google\ Chrome --args --disable-web-security --user-data-dir
```

<a href="https://stackoverflow.com/a/35509189/773263">--user-data-dir required on Chrome 49+ on OSX</a>  

For Linux run:  

```javascript
$ google-chrome --disable-web-security
```

Also if you're trying to access local files for dev purposes like AJAX or JSON, you can use this flag too.  

```javascript
-–allow-file-access-from-files
```

For Windows go into the command prompt and go into the folder where Chrome.exe is and type  

```javascript
chrome.exe --disable-web-security
```

That should disable the same origin policy and allow you to access local files.  

<strong>Update:</strong> For Chrome 22+ you will be presented with an error message that says:  

<blockquote>
  You are using an unsupported command-line flag: --disable-web-security. Stability and security will suffer.  
</blockquote>

However you can just ignore that message while developing.  

#### Answer 3 (score 476)
For Windows users:  

The problem with the solution accepted here, in my opinion is that if you already have Chrome open and try to run this it won't work.   

However, when researching this, I came across a post on Super&nbsp;User, <em><a href="https://superuser.com/questions/593726/is-it-possible-to-run-chrome-with-and-without-web-security-at-the-same-time">Is it possible to run Chrome with and without web security at the same time?</a></em>.  

Basically, by running the following command (or creating a shortcut with it and opening Chrome through that)  

```javascript
chrome.exe --user-data-dir="C:/Chrome dev session" --disable-web-security
```

<p>you can open a new "insecure" instance of Chrome at the same time as you keep your other "secure" browser instances open and working as normal. 
<em>Important</em>: delete/clear `C:/Chrome dev session` folder every time when you open a window as second time `--disable-web-security` is not going to work. So you cannot save your changes and then open it again as a second insecure instance of Chrome with `--disable-web-security`.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: What does "javascript:void(0)" mean? (score [1723008](https://stackoverflow.com/q/1291942) in 2017)

#### Question
```javascript
<a href="javascript:void(0)" id="loginlink">login</a>
```

I've seen such `href`s many times, but I don't know what exactly that means.  

#### Answer accepted (score 963)
<blockquote>
  <p>The `void` operator evaluates the given
  expression and then returns `undefined`.</p>
  
  <p>The `void` operator is often used merely
  to obtain the `undefined` primitive
  value, usually using “`void(0)`” (which
  is equivalent to “`void 0`”). In these
  cases, the global variable <a href="https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/undefined" rel="noreferrer">`undefined`</a>
  can be used instead (assuming it has
  not been assigned to a non-default
  value).</p>
</blockquote>

An explanation is provided here: <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/void" rel="noreferrer">`void` operator</a>.  

The reason you’d want to do this with the `href` of a link is that normally, a `javascript:` URL will redirect the browser to a plain text version of the result of evaluating that JavaScript. But if the result is `undefined`, then the browser stays on the same page. `void(0)` is just a short and simple script that evaluates to `undefined`.  

#### Answer 2 (score 419)
In addition to the technical answer, `javascript:void` means the author is Doing It Wrong.  

There is no good reason to use a `javascript:` pseudo-URL(*). In practice it will cause confusion or errors should anyone try things like ‘bookmark link’, ‘open link in a new tab’, and so on. This happens quite a lot now people have got used to middle-click-for-new-tab: it looks like a link, you want to read it in a new tab, but it turns out to be not a real link at all, and gives unwanted results like a blank page or a JS error when middle-clicked.  

`&lt;a href="#"&gt;` is a common alternative which might arguably be less bad. However you must remember to `return false` from your `onclick` event handler to prevent the link being followed and scrolling up to the top of the page.  

In some cases there may be an actual useful place to point the link to. For example if you have a control you can click on that opens up a previously-hidden `&lt;div id="foo"&gt;`, it makes some sense to use `&lt;a href="#foo"&gt;` to link to it. Or if there is a non-JavaScript way of doing the same thing (for example, ‘thispage.php?show=foo’ that sets foo visible to begin with), you can link to that.  

Otherwise, if a link points only to some script, it is not really a link and should not be marked up as such. The usual approach would be to add the `onclick` to a `&lt;span&gt;`, `&lt;div&gt;`, or an `&lt;a&gt;` without an `href` and style it in some way to make it clear you can click on it. This is what StackOverflow [did at the time of writing; now it uses `href="#"`].  

The disadvantage of this is that you lose keyboard control, since you can't tab onto a span/div/bare-a or activate it with space. Whether this is actually a disadvantage depends on what sort of action the element is intended to take. You can, with some effort, attempt to mimic the keyboard interactability by adding a `tabIndex` to the element, and listening for a Space keypress. But it's never going to 100% reproduce the real browser behaviour, not least because different browsers can respond to the keyboard differently (not to mention non-visual browsers).  

If you really want an element that isn't a link but which can be activated as normal by mouse or keyboard, what you want is a `&lt;button type="button"&gt;` (or `&lt;input type="button"&gt;` is just as good, for simple textual contents). You can always use CSS to restyle it so it looks more like a link than a button, if you want. But since it behaves like a button, that's how really you should mark it up.  

(*: in site authoring, anyway. Obviously they are useful for bookmarklets. `javascript:` pseudo-URLs are a conceptual bizarreness: a locator that doesn't point to a location, but instead calls active code inside the current location. They have caused massive security problems for both browsers and webapps, and should never have been invented by Netscape.)  

#### Answer 3 (score 121)
It means it’ll do nothing. It’s an attempt to have the link not ‘navigate’ anywhere. But it’s not the right way.  

You should actually just `return false` in the `onclick` event, like so:  

```javascript
<a href="#" onclick="return false;">hello</a>
```

Typically it’s used if the link is doing some ‘JavaScript-y’ thing. Like posting an AJAX form, or swapping an image, or whatever. In that case you just make whatever function is being called return `false`.  

To make your website completely awesome, however, generally you’ll include a link that does the same action, if the person browsing it chooses not to run JavaScript.  

```javascript
<a href="backup_page_displaying_image.aspx"
   onclick="return coolImageDisplayFunction();">hello</a>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: Which equals operator (== vs ===) should be used in JavaScript comparisons? (score [1695940](https://stackoverflow.com/q/359494) in 2017)

#### Question
I'm using <a href="http://en.wikipedia.org/wiki/JSLint" rel="noreferrer">JSLint</a> to go through JavaScript, and it's returning many suggestions to replace `==` (two equals signs) with `===` (three equals signs) when doing things like comparing `idSele_UNVEHtype.value.length == 0` inside of an `if` statement.  

Is there a performance benefit to replacing `==` with `===`?   

Any performance improvement would be welcomed as many comparison operators exist.  

If no type conversion takes place, would there be a performance gain over `==`?  

#### Answer accepted (score 6298)
The identity (`===`) operator behaves identically to the equality (`==`) operator except no type conversion is done, and the types must be the same to be considered equal.  

Reference: <a href="http://www.c-point.com/javascript_tutorial/jsgrpComparison.htm" rel="noreferrer">Javascript Tutorial: Comparison Operators</a>  

The `==` operator will compare for equality <em>after doing any necessary type conversions</em>.  The `===` operator will <strong>not</strong> do the conversion, so if two values are not the same type `===` will simply return `false`. Both are equally quick.  

To quote Douglas Crockford's excellent <a href="https://rads.stackoverflow.com/amzn/click/com/0596517742" rel="noreferrer" rel="nofollow noreferrer">JavaScript: The Good Parts</a>,  

<blockquote>
  JavaScript has two sets of equality operators: `===` and `!==`, and their evil twins `==` and `!=`.  The good ones work the way you would expect.  If the two operands are of the same type and have the same value, then `===` produces `true` and `!==` produces `false`.  The evil twins do the right thing when the operands are of the same type, but if they are of different types, they attempt to coerce the values.  the rules by which they do that are complicated and unmemorable.  These are some of the interesting cases:  

```javascript
'' == '0'           // false
0 == ''             // true
0 == '0'            // true

false == 'false'    // false
false == '0'        // true

false == undefined  // false
false == null       // false
null == undefined   // true

' \t\r\n ' == 0     // true
```
  
  The lack of transitivity is alarming.  My advice is to never use the evil twins.  Instead, always use `===` and `!==`.  All of the comparisons just shown produce `false` with the `===` operator.  
</blockquote>

<hr>

<h5>Update:</h3>

A good point was brought up by <a href="https://stackoverflow.com/users/165495/casebash">@Casebash</a> in the comments and in <a href="https://stackoverflow.com/users/113570/philippe-leybaert">@Phillipe Laybaert's</a> <a href="https://stackoverflow.com/a/957602/1288">answer</a> concerning reference types.  For reference types `==` and `===` act consistently with one another (except in a special case).  

```javascript
var a = [1,2,3];
var b = [1,2,3];

var c = { x: 1, y: 2 };
var d = { x: 1, y: 2 };

var e = "text";
var f = "te" + "xt";

a == b            // false
a === b           // false

c == d            // false
c === d           // false

e == f            // true
e === f           // true
```

The special case is when you compare a literal with an object that evaluates to the same literal, due to its `toString` or `valueOf` method. For example, consider the comparison of a string literal with a string object created by the `String` constructor.  

```javascript
"abc" == new String("abc")    // true
"abc" === new String("abc")   // false
```

Here the `==` operator is checking the values of the two objects and returning `true`, but the `===` is seeing that they're not the same type and returning `false`.  Which one is correct?  That really depends on what you're trying to compare.  My advice is to bypass the question entirely and just don't use the `String` constructor to create string objects.  

<p><strong>Reference</strong><br>
<a href="http://www.ecma-international.org/ecma-262/5.1/#sec-11.9.3" rel="noreferrer">http://www.ecma-international.org/ecma-262/5.1/#sec-11.9.3</a></p>

#### Answer 2 (score 1102)
Using the `==` operator (<em>Equality</em>)  

```javascript
true == 1; //true, because 'true' is converted to 1 and then compared
"2" == 2;  //true, because "2" is converted to 2 and then compared
```

Using the `===` operator (<em>Identity</em>)  

```javascript
true === 1; //false
"2" === 2;  //false
```

This is because the <strong>equality operator `==` does type coercion</strong>, meaning that the interpreter implicitly tries to convert the values before comparing.  

On the other hand, the <strong>identity operator `===` does not do type coercion</strong>, and thus does not convert the values when comparing, and is therefore faster (as according to <a href="http://jsben.ch/JUOm2" rel="noreferrer">This JS benchmark</a> test) as it skips one step.  

#### Answer 3 (score 677)
An interesting pictorial representation of the equality comparison between `==` and `===`.    

<strong>Source: <a href="http://dorey.github.io/JavaScript-Equality-Table/" rel="noreferrer">http://dorey.github.io/JavaScript-Equality-Table/</a></strong>  

<hr>

<h5>`var1 === var2`</h1>

<blockquote>
  <strong><em>When using `===` for JavaScript equality testing, everything is as is. Nothing gets converted before being evaluated.</em></strong>  
</blockquote>

<img src="https://i.stack.imgur.com/62vxI.png" alt="Equality evaluation of === in JS">  

<hr>

<h5>`var1 == var2`</h1>

<blockquote>
  <p><strong><em>When using `==` for JavaScript equality testing, some
  funky conversions take place.</em></strong></p>
</blockquote>

<img src="https://i.stack.imgur.com/35MpY.png" alt="Equality evaluation of == in JS">  

<blockquote>
  <strong><em>Moral of the story:</em></strong>   
  
  <p><strong><em>Use `===` unless you fully understand the
  conversions that take place with `==`.</em></strong></p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: How can I format numbers as currency string in JavaScript? (score [1687668](https://stackoverflow.com/q/149055) in 2019)

#### Question
<p>I would like to format a price in JavaScript.<br>
I'd like a function which takes a `float` as an argument and returns a `string` formatted like this:</p>

```javascript
"$ 2,500.00"
```

What's the best way to do this?  

#### Answer accepted (score 27)
Ok, based on what you said, i'm using this:  

```javascript
var DecimalSeparator = Number("1.2").toLocaleString().substr(1,1);

var AmountWithCommas = Amount.toLocaleString();
var arParts = String(AmountWithCommas).split(DecimalSeparator);
var intPart = arParts[0];
var decPart = (arParts.length > 1 ? arParts[1] : '');
decPart = (decPart + '00').substr(0,2);

return '£ ' + intPart + DecimalSeparator + decPart;
```

<p>I'm open to improvement suggestions (i'd prefer not to include YUI just to do this :-) )
I already know I should be detecting the "." instead of just using it as the decimal separator...</p>

#### Answer 2 (score 1716)
<h5><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed" rel="noreferrer">Number.prototype.toFixed</a></h2>

This solution is compatible with every single major browser:  

```javascript
  const profits = 2489.8237;

  profits.toFixed(3) //returns 2489.824 (rounds up)
  profits.toFixed(2) //returns 2489.82
  profits.toFixed(7) //returns 2489.8237000 (pads the decimals)
```

All you need is to add the currency symbol (e.g. `"$" + profits.toFixed(2)`) and you will have your amount in dollars.  

<h5>Custom function</h2>

If you require the use of `,` between each digit, you can use this function:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```javascript
function formatMoney(number, decPlaces, decSep, thouSep) {
decPlaces = isNaN(decPlaces = Math.abs(decPlaces)) ? 2 : decPlaces,
decSep = typeof decSep === "undefined" ? "." : decSep;
thouSep = typeof thouSep === "undefined" ? "," : thouSep;
var sign = number < 0 ? "-" : "";
var i = String(parseInt(number = Math.abs(Number(number) || 0).toFixed(decPlaces)));
var j = (j = i.length) > 3 ? j % 3 : 0;

return sign +
	(j ? i.substr(0, j) + thouSep : "") +
	i.substr(j).replace(/(\decSep{3})(?=\decSep)/g, "$1" + thouSep) +
	(decPlaces ? decSep + Math.abs(number - i).toFixed(decPlaces).slice(2) : "");
}

document.getElementById("b").addEventListener("click", event => {
  document.getElementById("x").innerText = "Result was: " + formatMoney(document.getElementById("d").value);
});```
```javascript
<label>Insert your amount: <input id="d" type="text" placeholder="Cash amount" /></label>
<br />
<button id="b">Get Output</button>
<p id="x">(press button to get output)</p>```
</div>
</div>


Use it like so:  

```javascript
(123456789.12345).formatMoney(2, ".", ",");
```

If you're always going to use '.' and ',', you can leave them off your method call, and the method will default them for you.  

```javascript
(123456789.12345).formatMoney(2);
```

If your culture has the two symbols flipped (i.e. Europeans) and you would like to use the defaults, just paste over the following two lines in the `formatMoney` method:  

```javascript
    d = d == undefined ? "," : d, 
    t = t == undefined ? "." : t, 
```

<h5>Custom function (ES6)</h2>

If you can use modern ECMAScript syntax (i.e. through Babel), you can use this simpler function instead:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function formatMoney(amount, decimalCount = 2, decimal = ".", thousands = ",") {
  try {
    decimalCount = Math.abs(decimalCount);
    decimalCount = isNaN(decimalCount) ? 2 : decimalCount;

    const negativeSign = amount < 0 ? "-" : "";

    let i = parseInt(amount = Math.abs(Number(amount) || 0).toFixed(decimalCount)).toString();
    let j = (i.length > 3) ? i.length % 3 : 0;

    return negativeSign + (j ? i.substr(0, j) + thousands : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands) + (decimalCount ? decimal + Math.abs(amount - i).toFixed(decimalCount).slice(2) : "");
  } catch (e) {
    console.log(e)
  }
};
document.getElementById("b").addEventListener("click", event => {
  document.getElementById("x").innerText = "Result was: " + formatMoney(document.getElementById("d").value);
});```
```javascript
<label>Insert your amount: <input id="d" type="text" placeholder="Cash amount" /></label>
<br />
<button id="b">Get Output</button>
<p id="x">(press button to get output)</p>```
</div>
</div>


#### Answer 3 (score 1253)
<h5>Short and fast solution (works everywhere!)</h2>

```javascript
(12345.67).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');  // 12,345.67
```

The idea behind this solution is replacing matched sections with first match and comma, i.e. `'$&amp;,'`. The matching is done using <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions#special-lookahead" rel="noreferrer">lookahead approach</a>. You may read the expression as <em>"match a number if it is followed by a sequence of three number sets (one or more) and a dot"</em>.  

<strong>TESTS:</strong>  

```javascript
1        --> "1.00"
12       --> "12.00"
123      --> "123.00"
1234     --> "1,234.00"
12345    --> "12,345.00"
123456   --> "123,456.00"
1234567  --> "1,234,567.00"
12345.67 --> "12,345.67"
```

<strong>DEMO:</strong> <a href="http://jsfiddle.net/hAfMM/9571/" rel="noreferrer">http://jsfiddle.net/hAfMM/9571/</a>  

<hr>

<h5>Extended short solution</h2>

You can also extend the prototype of <a href="https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/Number" rel="noreferrer">`Number`</a> object to add additional support of any number of decimals `[0 .. n]` and the size of number groups `[0 .. x]`:  

```javascript
/**
 * Number.prototype.format(n, x)
 * 
 * @param integer n: length of decimal
 * @param integer x: length of sections
 */
Number.prototype.format = function(n, x) {
    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
    return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
};

1234..format();           // "1,234"
12345..format(2);         // "12,345.00"
123456.7.format(3, 2);    // "12,34,56.700"
123456.789.format(2, 4);  // "12,3456.79"
```

<strong>DEMO / TESTS:</strong> <a href="http://jsfiddle.net/hAfMM/435/" rel="noreferrer">http://jsfiddle.net/hAfMM/435/</a>  

<hr>

<h5>Super extended short solution</h2>

In this <a href="https://stackoverflow.com/questions/149055/how-can-i-format-numbers-as-money-in-javascript/14428340#comment34151293_14428340">super extended version</a> you may set different delimiter types:  

```javascript
/**
 * Number.prototype.format(n, x, s, c)
 * 
 * @param integer n: length of decimal
 * @param integer x: length of whole part
 * @param mixed   s: sections delimiter
 * @param mixed   c: decimal delimiter
 */
Number.prototype.format = function(n, x, s, c) {
    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\D' : '$') + ')',
        num = this.toFixed(Math.max(0, ~~n));

    return (c ? num.replace('.', c) : num).replace(new RegExp(re, 'g'), '$&' + (s || ','));
};

12345678.9.format(2, 3, '.', ',');  // "12.345.678,90"
123456.789.format(4, 4, ' ', ':');  // "12 3456:7890"
12345678.9.format(0, 3, '-');       // "12-345-679"
```

<strong>DEMO / TESTS:</strong> <a href="http://jsfiddle.net/hAfMM/612/" rel="noreferrer">http://jsfiddle.net/hAfMM/612/</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: How do I copy to the clipboard in JavaScript? (score [1678830](https://stackoverflow.com/q/400212) in 2017)

#### Question
What is the best way to copy text to the clipboard? (multi-browser)  

I have tried:   

```javascript
function copyToClipboard(text) {
    if (window.clipboardData) { // Internet Explorer
        window.clipboardData.setData("Text", text);
    } else {  
        unsafeWindow.netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");  
        const clipboardHelper = Components.classes["@mozilla.org/widget/clipboardhelper;1"].getService(Components.interfaces.nsIClipboardHelper);  
        clipboardHelper.copyString(text);
    }
}
```

but in Internet Explorer it gives a syntax error. In Firefox, it says `unsafeWindow is not defined`.  

A nice trick without flash: <a href="https://stackoverflow.com/questions/17527870/how-does-trello-access-the-users-clipboard">How does Trello access the user&#39;s clipboard?</a>  

#### Answer 2 (score 1987)
<h5>Overview</h1>

There are three primary browser APIs for copying to the clipboard:  

<ol>
<li><a href="https://www.w3.org/TR/clipboard-apis/#async-clipboard-api" rel="noreferrer">Async Clipboard API</a> `[navigator.clipboard.writeText]`

<ul>
<li>Text-focused portion available in <a href="https://developers.google.com/web/updates/2018/03/clipboardapi" rel="noreferrer">Chrome 66 (March 2018)</a></li>
<li>Access is asynchronous and uses <a href="https://developers.google.com/web/fundamentals/primers/promises" rel="noreferrer">JavaScript Promises</a>, can be written so security user prompts (if displayed) don't interrupt the JavaScript in page.</li>
<li>Text can be copied to the clipboard directly from a variable.</li>
<li>Only supported on pages served over HTTPS.</li>
<li>In Chrome 66 pages in active tabs can write to the clipboard without a permissions prompt.</li>
</ul></li>
<li>`document.execCommand('copy')`

<ul>
<li>Most browsers support this as of ~April 2015 (see Browser Support below).</li>
<li>Access is synchronous, i.e. stops JavaScript in the page until complete including displaying and user interacting with any security prompts.</li>
<li>Text is read from the DOM and placed on the clipboard.</li>
<li>During testing ~April 2015 only Internet Explorer was noted as displaying permissions prompts whilst writing to the clipboard.</li>
</ul></li>
<li>Overriding the copy event

<ul>
<li>See Clipboard API documentation on <a href="https://w3c.github.io/clipboard-apis/#override-copy" rel="noreferrer">Overriding the copy event</a>.</li>
<li>Allows you to modify what appears on the clipboard from any copy event, can include other formats of data other than plain text.</li>
<li>Not covered here as it doesn't directly answer the question.</li>
</ul></li>
</ol>

<h5>General development notes</h1>

Don't expect clipboard related commands to work whilst you are testing code in the console. Generally the page is required to be active (Async Clipboard API) or requires user interaction (e.g. a user click) to allow (`document.execCommand('copy')`) to access the clipboard see below for more detail.  

<h5>Async + Fallback</h1>

Due to the level of browser support for the new Async Clipboard API you will likely want to fallback to the `document.execCommand('copy')` method to get good browser coverage.  

Here is a simple example:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function fallbackCopyTextToClipboard(text) {
  var textArea = document.createElement("textarea");
  textArea.value = text;
  document.body.appendChild(textArea);
  textArea.focus();
  textArea.select();

  try {
    var successful = document.execCommand('copy');
    var msg = successful ? 'successful' : 'unsuccessful';
    console.log('Fallback: Copying text command was ' + msg);
  } catch (err) {
    console.error('Fallback: Oops, unable to copy', err);
  }

  document.body.removeChild(textArea);
}
function copyTextToClipboard(text) {
  if (!navigator.clipboard) {
    fallbackCopyTextToClipboard(text);
    return;
  }
  navigator.clipboard.writeText(text).then(function() {
    console.log('Async: Copying to clipboard was successful!');
  }, function(err) {
    console.error('Async: Could not copy text: ', err);
  });
}

var copyBobBtn = document.querySelector('.js-copy-bob-btn'),
  copyJaneBtn = document.querySelector('.js-copy-jane-btn');

copyBobBtn.addEventListener('click', function(event) {
  copyTextToClipboard('Bob');
});


copyJaneBtn.addEventListener('click', function(event) {
  copyTextToClipboard('Jane');
});```
```javascript
<div style="display:inline-block; vertical-align:top;">
  <button class="js-copy-bob-btn">Set clipboard to BOB</button><br /><br />
  <button class="js-copy-jane-btn">Set clipboard to JANE</button>
</div>
<div style="display:inline-block;">
  <textarea class="js-test-textarea" cols="35" rows="4">Try pasting into here to see what you have on your clipboard:

  </textarea>
</div>```
</div>
</div>


Note that this snippet is not working well in Stack Overflow's embedded preview you can try it here: <a href="https://codepen.io/DeanMarkTaylor/pen/RMRaJX?editors=1011" rel="noreferrer">https://codepen.io/DeanMarkTaylor/pen/RMRaJX?editors=1011</a>  

<h5>Async Clipboard API</h1>

<ul>
<li><a href="https://developers.google.com/web/updates/2018/03/clipboardapi" rel="noreferrer">Chrome 66 announcement post (March 2018)</a></li>
<li>Reference <a href="https://www.w3.org/TR/clipboard-apis/#async-clipboard-api" rel="noreferrer">Async Clipboard API</a> draft documentation</li>
</ul>

Note that there is an ability to "request permission" and test for access to the clipboard via the permissions API in Chrome 66.  

```javascript
var text = "Example text to appear on clipboard";
navigator.clipboard.writeText(text).then(function() {
  console.log('Async: Copying to clipboard was successful!');
}, function(err) {
  console.error('Async: Could not copy text: ', err);
});
```

<h5>document.execCommand('copy')</h1>

The rest of this post goes into the nuances and detail of the `document.execCommand('copy')` API.  

<h5>Browser Support</h2>

The JavaScript <a href="https://developer.mozilla.org/en-US/docs/Web/API/Document/execCommand" rel="noreferrer">`document.execCommand('copy')`</a> support has grown, see the links below for browser updates:  

<ul>
<li>Internet Explorer 10+ (although <a href="https://msdn.microsoft.com/en-us/library/ms537834(v=vs.85).aspx" rel="noreferrer">this document</a> indicates some support was there from Internet Explorer 5.5+).</li>
<li><a href="https://developers.google.com/web/updates/2015/04/cut-and-copy-commands?hl=en" rel="noreferrer">Google Chrome 43+ (~April 2015)</a></li>
<li><a href="https://developer.mozilla.org/en-US/Firefox/Releases/41#Interfaces.2FAPIs.2FDOM" rel="noreferrer">Mozilla Firefox 41+ (shipping ~September 2015)</a></li>
<li><a href="https://dev.opera.com/blog/opera-29/#cut-and-copy-commands" rel="noreferrer">Opera 29+ (based on Chromium 42, ~April 2015)</a></li>
</ul>

<h5>Simple Example</h2>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var copyTextareaBtn = document.querySelector('.js-textareacopybtn');

copyTextareaBtn.addEventListener('click', function(event) {
  var copyTextarea = document.querySelector('.js-copytextarea');
  copyTextarea.focus();
  copyTextarea.select();

  try {
    var successful = document.execCommand('copy');
    var msg = successful ? 'successful' : 'unsuccessful';
    console.log('Copying text command was ' + msg);
  } catch (err) {
    console.log('Oops, unable to copy');
  }
});```
```javascript
<p>
  <button class="js-textareacopybtn" style="vertical-align:top;">Copy Textarea</button>
  <textarea class="js-copytextarea">Hello I'm some text</textarea>
</p>```
</div>
</div>


<h5>Complex Example: Copy to clipboard without displaying input</h2>

The above simple example works great if there is a `textarea` or `input` element visible on screen.  

In some cases you might wish to copy text to the clipboard without displaying an `input` / `textarea` element. This is one example of a way to work around this (basically insert element, copy to clipboard, remove element):  

Tested with Google Chrome 44, Firefox 42.0a1 and Internet Explorer 11.0.8600.17814.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function copyTextToClipboard(text) {
  var textArea = document.createElement("textarea");

  //
  // *** This styling is an extra step which is likely not required. ***
  //
  // Why is it here? To ensure:
  // 1. the element is able to have focus and selection.
  // 2. if element was to flash render it has minimal visual impact.
  // 3. less flakyness with selection and copying which **might** occur if
  //    the textarea element is not visible.
  //
  // The likelihood is the element won't even render, not even a
  // flash, so some of these are just precautions. However in
  // Internet Explorer the element is visible whilst the popup
  // box asking the user for permission for the web page to
  // copy to the clipboard.
  //

  // Place in top-left corner of screen regardless of scroll position.
  textArea.style.position = 'fixed';
  textArea.style.top = 0;
  textArea.style.left = 0;

  // Ensure it has a small width and height. Setting to 1px / 1em
  // doesn't work as this gives a negative w/h on some browsers.
  textArea.style.width = '2em';
  textArea.style.height = '2em';

  // We don't need padding, reducing the size if it does flash render.
  textArea.style.padding = 0;

  // Clean up any borders.
  textArea.style.border = 'none';
  textArea.style.outline = 'none';
  textArea.style.boxShadow = 'none';

  // Avoid flash of white box if rendered for any reason.
  textArea.style.background = 'transparent';


  textArea.value = text;

  document.body.appendChild(textArea);
  textArea.focus();
  textArea.select();

  try {
    var successful = document.execCommand('copy');
    var msg = successful ? 'successful' : 'unsuccessful';
    console.log('Copying text command was ' + msg);
  } catch (err) {
    console.log('Oops, unable to copy');
  }

  document.body.removeChild(textArea);
}


var copyBobBtn = document.querySelector('.js-copy-bob-btn'),
  copyJaneBtn = document.querySelector('.js-copy-jane-btn');

copyBobBtn.addEventListener('click', function(event) {
  copyTextToClipboard('Bob');
});


copyJaneBtn.addEventListener('click', function(event) {
  copyTextToClipboard('Jane');
});```
```javascript
<div style="display:inline-block; vertical-align:top;">
  <button class="js-copy-bob-btn">Set clipboard to BOB</button><br /><br />
  <button class="js-copy-jane-btn">Set clipboard to JANE</button>
</div>
<div style="display:inline-block;">
  <textarea class="js-test-textarea" cols="35" rows="4">Try pasting into here to see what you have on your clipboard:

  </textarea>
</div>```
</div>
</div>


<h5>Additional notes</h2>

<h5>Only works if the user takes an action</h3>

All `document.execCommand('copy')` calls must take place as a direct result of a user action, e.g. click event handler. This is a measure to prevent messing with the user's clipboard when they don't expect it.  

See the <a href="https://developers.google.com/web/updates/2015/04/cut-and-copy-commands?hl=en" rel="noreferrer">Google Developers post here</a> for more info.  

<h5>Clipboard API</h3>

<p>Note the full Clipboard API draft specification can be found here:
<a href="https://w3c.github.io/clipboard-apis/" rel="noreferrer">https://w3c.github.io/clipboard-apis/</a></p>

<h5>Is it supported?</h3>

<ul>
<li>`document.queryCommandSupported('copy')` should return `true` if the command "is supported by the browser".</li>
<li>and `document.queryCommandEnabled('copy')` return `true` if the `document.execCommand('copy')` will succeed if called now. Checking to ensure the command was called from a user-initiated thread and other requirements are met.</li>
</ul>

However as an example of browser compatibility issues, Google Chrome from ~April to ~October 2015 only returned `true` from `document.queryCommandSupported('copy')` if the command was called from a user-initiated thread.  

Note compatibility detail below.  

<h5>Browser Compatibility Detail</h3>

Whilst a simple call to `document.execCommand('copy')` wrapped in a `try`/`catch` block called as a result of a user click will get you the most compatibility use the following has some provisos:  

Any call to `document.execCommand`, `document.queryCommandSupported` or `document.queryCommandEnabled` should be wrapped in a `try`/`catch` block.  

Different browser implementations and browser versions throw differing types of exceptions when called instead of returning `false`.  

Different browser implementations are still in flux and the <a href="https://w3c.github.io/clipboard-apis/" rel="noreferrer">Clipboard API</a> is still in draft, so remember to do your testing.  

#### Answer 3 (score 1235)
Automatic copying to clipboard may be dangerous, therefore most browsers (except IE) make it very difficult. Personally, I use the following simple trick:  

```javascript
function copyToClipboard(text) {
  window.prompt("Copy to clipboard: Ctrl+C, Enter", text);
}
```

The user is presented with the prompt box, where the text to be copied is already selected. Now it's enough to press <kbd>Ctrl</kbd>+<kbd>C</kbd> and <kbd>Enter</kbd> (to close the box) -- and voila!  

Now the clipboard copy operation is SAFE, because the user does it manually (but in a pretty straightforward way). Of course, works in all browsers.  

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
```javascript
<button id="demo" onclick="copyToClipboard(document.getElementById('demo').innerHTML)">This is what I want to copy</button>

<script>
  function copyToClipboard(text) {
    window.prompt("Copy to clipboard: Ctrl+C, Enter", text);
  }
</script>```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 55: How to insert an item into an array at a specific index (JavaScript)? (score [1664635](https://stackoverflow.com/q/586182) in 2019)

#### Question
I am looking for a JavaScript array insert method, in the style of:  

```javascript
arr.insert(index, item)
```

Preferably in jQuery, but any JavaScript implementation will do at this point.  

#### Answer accepted (score 4303)
What you want is the <strong><a href="https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/splice" rel="noreferrer">`splice`</a></strong> function on the native array object.  

`arr.splice(index, 0, item);` will insert `item` into `arr` at the specified index (deleting `0` items first, that is, it's just an insert).  

In this example we will create an array and add an element to it into index 2:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var arr = [];
arr[0] = "Jani";
arr[1] = "Hege";
arr[2] = "Stale";
arr[3] = "Kai Jim";
arr[4] = "Borge";

console.log(arr.join());
arr.splice(2, 0, "Lene");
console.log(arr.join());```
</div>
</div>


#### Answer 2 (score 264)
You can implement the `Array.insert` method by doing this:  

```javascript
Array.prototype.insert = function ( index, item ) {
    this.splice( index, 0, item );
};
```

Then you can use it like:  

```javascript
var arr = [ 'A', 'B', 'D', 'E' ];
arr.insert(2, 'C');

// => arr == [ 'A', 'B', 'C', 'D', 'E' ]
```

#### Answer 3 (score 106)
Other than splice, you can use this approach which will not mutate the original array, but will create a new array with the added item. You should usually avoid mutation whenever possible. I'm using ES6 spread operator here.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="true">
<div class="snippet-code">
```javascript
const items = [1, 2, 3, 4, 5]

const insert = (arr, index, newItem) => [
  // part of the array before the specified index
  ...arr.slice(0, index),
  // inserted item
  newItem,
  // part of the array after the specified index
  ...arr.slice(index)
]

const result = insert(items, 1, 10)

console.log(result)
// [1, 10, 2, 3, 4, 5]```
</div>
</div>


This can be used to add more than one item by tweaking the function a bit to use the rest operator for the new items, and spread that in the returned result as well  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="true">
<div class="snippet-code">
```javascript
const items = [1, 2, 3, 4, 5]

const insert = (arr, index, ...newItems) => [
  // part of the array before the specified index
  ...arr.slice(0, index),
  // inserted items
  ...newItems,
  // part of the array after the specified index
  ...arr.slice(index)
]

const result = insert(items, 1, 10, 20)

console.log(result)
// [1, 10, 20, 2, 3, 4, 5]```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 56: Creating a div element in jQuery (score [1658176](https://stackoverflow.com/q/867916) in 2016)

#### Question
How do I create a `div` element in <strong>jQuery</strong>?  

#### Answer accepted (score 1039)
You can use `append` (to add at last position of parent) or `prepend` (to add at fist position of parent):  

```javascript
$('#parent').append('<div>hello</div>');    
// or
$('<div>hello</div>').appendTo('#parent');
```

Alternatively, you can use the `.html()` or `.add()` as mentioned in a <a href="https://stackoverflow.com/a/867941/59087">different answer</a>.  



#### Answer 2 (score 1957)
As of jQuery 1.4 you can pass attributes to a self-closed element like so:  

```javascript
jQuery('<div/>', {
    id: 'some-id',
    "class": 'some-class',
    title: 'now this div has a title!'
}).appendTo('#mySelector');
```

Here it is in the <em><a href="http://api.jquery.com/jQuery/#jQuery2" rel="noreferrer">Docs</a></em>  

Examples can be found at <em><a href="http://net.tutsplus.com/tutorials/javascript-ajax/jquery-1-4-released-the-15-new-features-you-must-know/" rel="noreferrer">jQuery 1.4 Released: The 15 New Features you Must Know </a></em>.  

#### Answer 3 (score 228)
Technically `$('&lt;div&gt;&lt;/div&gt;')` will 'create' a `div` element (or more specifically a DIV DOM element) but won't add it to your HTML document. You will then need to use that in combination with the other answers to actually do anything useful with it (such as using the `append()` method or such like).  

The <a href="http://docs.jquery.com/Manipulation" rel="nofollow noreferrer">manipulation documentation</a> gives you all the various options on how to add new elements.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Length of a JavaScript object (score [1658003](https://stackoverflow.com/q/5223) in 2019)

#### Question
I have a JavaScript object, is there a built-in or accepted best practice way to get the length of this object?  

```javascript
var myObject = new Object();
myObject["firstname"] = "Gareth";
myObject["lastname"] = "Simpson";
myObject["age"] = 21;
```

#### Answer accepted (score 2417)
The most robust answer (i.e. that captures the intent of what you're trying to do while causing the fewest bugs) would be:  

```javascript
Object.size = function(obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};

// Get the size of an object
var size = Object.size(myObj);
```

There's a sort of convention in JavaScript that you <a href="https://stackoverflow.com/questions/10757455/object-prototype-is-verboten">don't add things to Object.prototype</a>, because it can break enumerations in various libraries. Adding methods to Object is usually safe, though.  

<hr>

<strong>Here's an update as of 2016 and <a href="http://kangax.github.io/compat-table/es5/" rel="noreferrer">widespread deployment of ES5</a> and beyond.</strong>  For IE9+ and all other modern ES5+ capable browsers, you can use <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys" rel="noreferrer">`Object.keys()`</a> so the above code just becomes:  

```javascript
var size = Object.keys(myObj).length;
```

This doesn't have to modify any existing prototype since `Object.keys()` is now built in.  

<strong>Edit</strong>: Objects can have symbolic properties which can not be returned via Object.key method. So the answer would be incomplete without mentioning them.  

Symbol type was added to the language to create unique identifiers for object properties. Main benefit of Symbol type is prevention of overwrites.  

`Object.keys` or `Object.getOwnPropertyNames` does not work for symbolic properties. To return them you need to use `Object.getOwnPropertySymbols`.  

```javascript
var person = {
  [Symbol('name')]: 'John Doe',
  [Symbol('age')]: 33,
  "occupation": "Programmer"
};

const propOwn = Object.getOwnPropertyNames(person);
console.log(propOwn.length); // 1

let propSymb = Object.getOwnPropertySymbols(person);
console.log(propSymb.length); // 2
```

#### Answer 2 (score 1611)
If you know you don't have to worry about `hasOwnProperty` checks, you can do this very simply:  

```javascript
Object.keys(myArray).length
```

#### Answer 3 (score 276)
<strong>Updated</strong>: If you're using <a href="http://underscorejs.org/#size">Underscore.js</a> (recommended, it's lightweight!), then you can just do  

```javascript
_.size({one : 1, two : 2, three : 3});
=> 3
```

<strong>If not</strong>, and you don't want to mess around with Object properties for whatever reason, and are already using jQuery, a plugin is equally accessible:  

```javascript
$.assocArraySize = function(obj) {
    // http://stackoverflow.com/a/6700/11236
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: How can I display a JavaScript object? (score [1635768](https://stackoverflow.com/q/957537) in 2016)

#### Question
How do I display the content of a JavaScript object in a string format like when we `alert` a variable?  

The same formatted way I want to display an object.  

#### Answer accepted (score 942)
If you want to print the object for debugging purposes, use the code:  

```javascript
var obj = {prop1: 'prop1Value', prop2: 'prop2Value', child: {childProp1: 'childProp1Value'}}
console.log(obj)
```

will display:  

<a href="https://i.stack.imgur.com/x0Tvz.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/x0Tvz.png" alt="screenshot console chrome"></a>  

<strong>Note:</strong> you must <em>only</em> log the object. For example, this won't work:  

```javascript
console.log('My object : ' + obj)
```

<strong>Note '</strong>: You can also use a comma in the `log` method, then the first line of the output will be the string and after that the object will be renderd:  

```javascript
console.log('My object: ', obj);
```

#### Answer 2 (score 1918)
<p>Use native `JSON.stringify` method.
Works with nested objects and all major browsers <a href="http://caniuse.com/#search=json" rel="noreferrer">support</a> this method.</p>

```javascript
str = JSON.stringify(obj);
str = JSON.stringify(obj, null, 4); // (Optional) beautiful indented output.
console.log(str); // Logs output to dev tools console.
alert(str); // Displays output using window.alert()
```

Link to <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify" rel="noreferrer">Mozilla API Reference</a> and other examples.  

```javascript
obj = JSON.parse(str); // Reverses above operation (Just in case if needed.)
```

<hr>

<p>Use a custom <a href="https://stackoverflow.com/a/11616993/218857">JSON.stringify replacer</a> if you
encounter this Javascript error</p>

```javascript
"Uncaught TypeError: Converting circular structure to JSON"
```

#### Answer 3 (score 383)
```javascript
var output = '';
for (var property in object) {
  output += property + ': ' + object[property]+'; ';
}
alert(output);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: Create GUID / UUID in JavaScript? (score [1617271](https://stackoverflow.com/q/105034) in 2014)

#### Question
I'm trying to create globally-unique identifiers in JavaScript.  I'm not sure what routines are available on all browsers, how "random" and seeded the built-in random number generator is, etc..  

The GUID / UUID should be at least 32 characters and should stay in the ASCII range to avoid trouble when passing them around.  

#### Answer accepted (score 2203)
UUIDs (Universally Unique IDentifier), also known as GUIDs (Globally Unique IDentifier), according to <a href="https://www.ietf.org/rfc/rfc4122.txt" rel="noreferrer">RFC 4122</a>, are identifiers with a certain uniqueness guarantee.  

The best way to generate them, is to follow implementation instructions in the said RFC, use one of the many community vetted open source implementations.  

A popular Open Source tool for working with UUIDs in JavaScript is <a href="https://github.com/kelektiv/node-uuid" rel="noreferrer">node-uuid</a>  

Note that just randomly generating the identifiers byte by byte, or character by character, will not give you the same guarantees as a conforming implementation. Also, very important, systems working with compliant UUIDs may choose not to accept randomly generated ones, and many open source validators will actually check for a valid structure.  

An UUID must have this format:  

```javascript
xxxxxxxx-xxxx-Mxxx-Nxxx-xxxxxxxxxxxx
```

Where the <em>M</em> and <em>N</em> positions may only have certain values. At this time, the only valid values for M are 1, 2, 3, 4 and 5, so randomly generating that position would make most results unacceptable.  

#### Answer 2 (score 3727)
For an <a href="https://www.ietf.org/rfc/rfc4122.txt" rel="noreferrer">RFC4122</a> version 4 compliant solution, this one-liner(ish) solution is the most compact I could come up with.:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function uuidv4() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
}

console.log(uuidv4());```
</div>
</div>


<strong>Update, 2015-06-02</strong>:  Be aware that UUID uniqueness relies heavily on the underlying random number generator (RNG).  The solution above uses `Math.random()` for brevity, however `Math.random()` is <em>not</em> guaranteed to be a high-quality RNG.  See Adam Hyland's <a href="http://bocoup.com/weblog/random-numbers/" rel="noreferrer">excellent writeup on Math.random()</a> for details.  For a more robust solution, consider something like <a href="https://github.com/kelektiv/node-uuid" rel="noreferrer">the uuid module</a> (disclaimer: I'm the author), which uses higher quality RNG APIs where available.  

<strong>Update, 2015-08-26</strong>: As a side-note, this <a href="https://gist.githubusercontent.com/aristus/f0c311df98d92e367df0" rel="noreferrer">gist</a> describes how to determine how many IDs can be generated before reaching a certain probability of collision.  For example, with 3.26x10<sup>15</sup> version 4 RFC4122 UUIDs you have a 1-in-a-million chance of collision.  

<strong>Update, 2017-06-28</strong>: A <a href="https://v8project.blogspot.com/2015/12/theres-mathrandom-and-then-theres.html" rel="noreferrer">good article from Chrome developers</a> discussing the state of Math.random PRNG quality in Chrome, Firefox, and Safari.  tl;dr - As of late-2015 it's "pretty good", but not cryptographic quality.  To address that issue, here's an updated version of the above solution that uses ES6, the `crypto` API, and <a href="https://gist.github.com/jed/982883" rel="noreferrer">a bit of JS wizardry I can't take credit for</a>:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function uuidv4() {
  return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c =>
    (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
  );
}

console.log(uuidv4());```
</div>
</div>


#### Answer 3 (score 772)
I really like how clean <a href="https://stackoverflow.com/a/2117523/508537">Broofa's answer</a> is, but it's unfortunate that <a href="https://stackoverflow.com/q/6906916/508537">poor implementations of `Math.random`</a> leave the chance for collision.    

Here's a similar <a href="http://www.ietf.org/rfc/rfc4122.txt" rel="noreferrer">RFC4122</a> version 4 compliant solution that solves that issue by offsetting the first 13 hex numbers by a hex portion of the timestamp, and once depleted offsets by a hex portion of the microseconds since pageload.  That way, even if `Math.random` is on the same seed, both clients would have to generate the UUID the exact same number of microseconds since pageload (if high-perfomance time is supported) AND at the exact same millisecond (or 10,000+ years later) to get the same UUID:     

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function generateUUID() { // Public Domain/MIT
    var d = new Date().getTime();//Timestamp
    var d2 = (performance && performance.now && (performance.now()*1000)) || 0;//Time in microseconds since page-load or 0 if unsupported
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = Math.random() * 16;//random number between 0 and 16
        if(d > 0){//Use timestamp until depleted
            r = (d + r)%16 | 0;
            d = Math.floor(d/16);
        } else {//Use microseconds since page-load if supported
            r = (d2 + r)%16 | 0;
            d2 = Math.floor(d2/16);
        }
        return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
}

console.log(generateUUID())```
</div>
</div>


<p><br/>
<a href="https://jsfiddle.net/briguy37/8eacgpnq/" rel="noreferrer">Here's a fiddle to test.</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: Is there a standard function to check for null, undefined, or blank variables in JavaScript? (score [1586860](https://stackoverflow.com/q/5515310) in 2012)

#### Question
Is there a universal JavaScript function that checks that a variable has a value and ensures that it's not `undefined` or `null`? I've got this code, but I'm not sure if it covers all cases:  

```javascript
function isEmpty(val){
    return (val === undefined || val == null || val.length <= 0) ? true : false;
}
```

#### Answer accepted (score 4028)
You can just check if the <em>variable</em> has a `truthy` value or not. That means  

```javascript
if( value ) {
}
```

will evaluate to `true` if `value` is <strong>not</strong>:  

<ul>
<li>null</li>
<li>undefined</li>
<li>NaN</li>
<li>empty string ("")</li>
<li>0</li>
<li>false</li>
</ul>

The above list represents all possible `falsy` values in ECMA-/Javascript. Find it in the <a href="https://www.ecma-international.org/ecma-262/5.1/#sec-9.2" rel="noreferrer">specification</a> at the `ToBoolean` section.  

Furthermore, if you do not <strong>know</strong> whether a variable exists (that means, if it was <em>declared</em>) you should check with the `typeof` operator. For instance  

```javascript
if( typeof foo !== 'undefined' ) {
    // foo could get resolved and it's defined
}
```

If you can be sure that a <em>variable</em> is declared at least, you should directly check if it has a `truthy` value like shown above.  

Further read: <a href="http://typeofnan.blogspot.com/2011/01/typeof-is-fast.html" rel="noreferrer">http://typeofnan.blogspot.com/2011/01/typeof-is-fast.html</a>  

#### Answer 2 (score 198)
The verbose method to check if value is undefined or null is:  

```javascript
return value === undefined || value === null;
```

You can also use the `==` operator but this expects one to <a href="http://www.ecma-international.org/ecma-262/5.1/#sec-11.9.3" rel="noreferrer">know all the rules</a>:  

```javascript
return value == null; // also returns true if value is undefined
```

#### Answer 3 (score 72)
```javascript
function isEmpty(value){
  return (value == null || value.length === 0);
}
```

This will return true for  

```javascript
undefined  // Because undefined == null

null

[]

""
```

and zero argument functions since a function's `length` is the number of declared parameters it takes.  

To disallow the latter category, you might want to just check for blank strings  

```javascript
function isEmpty(value){
  return (value == null || value === '');
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Add table row in jQuery (score [1585868](https://stackoverflow.com/q/171027) in 2015)

#### Question
What is the best method in jQuery to add an additional row to a table as the last row?  

Is this acceptable?  

```javascript
$('#myTable').append('<tr><td>my data</td><td>more data</td></tr>');
```

Are there limitations to what you can add to a table like this (such as inputs, selects, number of rows)?  

#### Answer accepted (score 2058)
The approach you suggest is not guaranteed to give you the result you're looking for - what if you had a `tbody` for example:  

```javascript
<table id="myTable">
  <tbody>
    <tr>...</tr>
    <tr>...</tr>
  </tbody>
</table>
```

You would end up with the following:  

```javascript
<table id="myTable">
  <tbody>
    <tr>...</tr>
    <tr>...</tr>
  </tbody>
  <tr>...</tr>
</table>
```

I would therefore recommend this approach instead:  

```javascript
$('#myTable tr:last').after('<tr>...</tr><tr>...</tr>');
```

You can include anything within the `after()` method as long as it's valid HTML, including multiple rows as per the example above.  

<strong>Update:</strong> Revisiting this answer following recent activity with this question. eyelidlessness makes a good comment that there will always be a `tbody` in the DOM; this is true, but only if there is at least one row. If you have no rows, there will be no `tbody` unless you have specified one yourself.  

DaRKoN_ <a href="https://stackoverflow.com/questions/171027/jquery-add-table-row/468240#468240">suggests</a> appending to the `tbody` rather than adding content after the last `tr`. This gets around the issue of having no rows, but still isn't bulletproof as you could theoretically have multiple `tbody` elements and the row would get added to each of them.  

Weighing everything up, I'm not sure there is a single one-line solution that accounts for every single possible scenario. You will need to make sure the jQuery code tallies with your markup.  

I think the safest solution is probably to ensure your `table` always includes at least one `tbody` in your markup, even if it has no rows. On this basis, you can use the following which will work however many rows you have (and also account for multiple `tbody` elements):  

```javascript
$('#myTable > tbody:last-child').append('<tr>...</tr><tr>...</tr>');
```

#### Answer 2 (score 746)
jQuery has a built-in facility to manipulate DOM elements on the fly.  

<strong>You can add anything to your table like this:</strong>  

```javascript
$("#tableID").find('tbody')
    .append($('<tr>')
        .append($('<td>')
            .append($('<img>')
                .attr('src', 'img.png')
                .text('Image cell')
            )
        )
    );
```

The `$('&lt;some-tag&gt;')` thing in jQuery is a tag object that can have several `attr` attributes that can be set and get, as well as `text`, which represents the text between the tag here: `&lt;tag&gt;text&lt;/tag&gt;`.  

<em>This is some pretty weird indenting, but it's easier for you to see what's going on in this example.</em>  

#### Answer 3 (score 295)
So things have changed ever since <a href="https://stackoverflow.com/a/171049/362006">@Luke Bennett</a> answered this question. Here is an update.  

jQuery since version 1.4(?) automatically detects if the element you are trying to insert (using any of the <a href="http://api.jquery.com/append/" rel="noreferrer">`append()`</a>, <a href="http://api.jquery.com/prepend/" rel="noreferrer">`prepend()`</a>, <a href="http://api.jquery.com/before/" rel="noreferrer">`before()`</a>, or <a href="http://api.jquery.com/after/" rel="noreferrer">`after()`</a> methods) is a `&lt;tr&gt;` and inserts it into the first `&lt;tbody&gt;` in your table or wraps it into a new `&lt;tbody&gt;` if one doesn't exist.   

So yes your example code is acceptable and will work fine with jQuery 1.4+. ;)  

```javascript
$('#myTable').append('<tr><td>my data</td><td>more data</td></tr>');
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: Determine whether an array contains a value (score [1581682](https://stackoverflow.com/q/1181575) in 2015)

#### Question
I need to determine if a value exists in an array.  

I am using the following function:  

```javascript
Array.prototype.contains = function(obj) {
    var i = this.length;
    while (i--) {
        if (this[i] == obj) {
            return true;
        }
    }
    return false;
}
```

The above function always returns false.  

The array values and the function call is as below:  

```javascript
arrValues = ["Sam","Great", "Sample", "High"]
alert(arrValues.contains("Sam"));
```

#### Answer accepted (score 996)
```javascript
var contains = function(needle) {
    // Per spec, the way to identify NaN is that it is not equal to itself
    var findNaN = needle !== needle;
    var indexOf;

    if(!findNaN && typeof Array.prototype.indexOf === 'function') {
        indexOf = Array.prototype.indexOf;
    } else {
        indexOf = function(needle) {
            var i = -1, index = -1;

            for(i = 0; i < this.length; i++) {
                var item = this[i];

                if((findNaN && item !== item) || item === needle) {
                    index = i;
                    break;
                }
            }

            return index;
        };
    }

    return indexOf.call(this, needle) > -1;
};
```

You can use it like this:  

```javascript
var myArray = [0,1,2],
    needle = 1,
    index = contains.call(myArray, needle); // true
```

<a href="http://codepen.io/anon/pen/mVRNaJ" rel="noreferrer">CodePen validation/usage</a>  

#### Answer 2 (score 986)
<a href="http://docs.jquery.com/Utilities/jQuery.inArray" rel="noreferrer">jQuery</a> has a utility function for this:  

```javascript
$.inArray(value, array)
```

Returns index of `value` in `array`. Returns `-1` if `array` does not contain `value`.  

See also <a href="https://stackoverflow.com/questions/237104/array-containsobj-in-javascript">How do I check if an array includes an object in JavaScript?</a>  

#### Answer 3 (score 871)
This is generally what the indexOf() method is for. You would say:  

```javascript
return arrValues.indexOf('Sam') > -1
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: Scroll to the top of the page using JavaScript? (score [1573088](https://stackoverflow.com/q/1144805) in 2019)

#### Question
I have a `&lt;button&gt;` element on the page, when this button is pressed a hidden `&lt;div&gt;` element is shown.  

How do I scroll to the top of the page using a JavaScript? It is desirable even if the scrollbar instantly jumps to the top. I'm not looking for a smooth scrolling.  

#### Answer accepted (score 2045)
If you don't need the change to animate then you don't need to use any special plugins - I'd just use the native JavaScript window.scrollTo method -- passing in 0,0 will scroll the page to the top left instantly.  

```javascript
window.scrollTo(x-coord, y-coord);
```

Parameters      

<ul>
<li>x-coord is the pixel along the horizontal axis.  </li>
<li>y-coord is the pixel along the vertical axis. </li>
</ul>

#### Answer 2 (score 1304)
If you do want smooth scrolling, try something like this:  

```javascript
$("a[href='#top']").click(function() {
  $("html, body").animate({ scrollTop: 0 }, "slow");
  return false;
});
```

That will take any `&lt;a&gt;` tag whose `href="#top"` and make it smooth scroll to the top.  

#### Answer 3 (score 167)
<strong>Try this to scroll on top</strong>  

```javascript
<script>
 $(document).ready(function(){
    $(window).scrollTop(0);
});
</script>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: JavaScript equivalent to printf/String.Format (score [1572835](https://stackoverflow.com/q/610406) in 2018)

#### Question
I'm looking for a good JavaScript equivalent of the C/PHP `printf()` or for C#/Java programmers, `String.Format()` (`IFormatProvider` for .NET).  

My basic requirement is a thousand separator format for numbers for now, but something that handles lots of combinations (including dates) would be good.  

I realize Microsoft's <a href="http://en.wikipedia.org/wiki/Ajax_%28programming%29" rel="noreferrer">Ajax</a> library provides a version of `String.Format()`, but we don't want the entire overhead of that framework.  

#### Answer accepted (score 975)
From ES6 on you could use template strings:  

```javascript
let soMany = 10;
console.log(`This is ${soMany} times easier!`);
// "This is 10 times easier!
```

See Kim's <a href="https://stackoverflow.com/a/32202320/2430448">answer</a> below for details.   

<hr>

<h5>Otherwise:</h1>

Try <a href="https://github.com/alexei/sprintf.js" rel="noreferrer">sprintf() for JavaScript</a>.  

<hr>

If you really want to do a simple format method on your own, don’t do the replacements successively but do them simultaneously.  

Because most of the other proposals that are mentioned fail when a replace string of previous replacement does also contain a format sequence like this:  

```javascript
"{0}{1}".format("{1}", "{0}")
```

Normally you would expect the output to be `{1}{0}` but the actual output is `{1}{1}`. So do a simultaneously replacement instead like in <a href="https://stackoverflow.com/questions/610406/javascript-printf-string-format/4673436#4673436">fearphage’s suggestion</a>.  

#### Answer 2 (score 1361)
Building on the previously suggested solutions:  

```javascript
// First, checks if it isn't implemented yet.
if (!String.prototype.format) {
  String.prototype.format = function() {
    var args = arguments;
    return this.replace(/{(\d+)}/g, function(match, number) { 
      return typeof args[number] != 'undefined'
        ? args[number]
        : match
      ;
    });
  };
}
```

`"{0} is dead, but {1} is alive! {0} {2}".format("ASP", "ASP.NET")`  

outputs  

<blockquote>
  ASP is dead, but ASP.NET is alive! ASP {2}  
</blockquote>

<hr>

If you prefer not to modify `String`'s prototype:  

```javascript
if (!String.format) {
  String.format = function(format) {
    var args = Array.prototype.slice.call(arguments, 1);
    return format.replace(/{(\d+)}/g, function(match, number) { 
      return typeof args[number] != 'undefined'
        ? args[number] 
        : match
      ;
    });
  };
}
```

Gives you the much more familiar:  

`String.format('{0} is dead, but {1} is alive! {0} {2}', 'ASP', 'ASP.NET');`  

with the same result:  

<blockquote>
  ASP is dead, but ASP.NET is alive! ASP {2}  
</blockquote>

#### Answer 3 (score 444)
It's funny because Stack&nbsp;Overflow actually has their own formatting function for the `String` prototype called `formatUnicorn`. Try it! Go into the console and type something like:  

```javascript
"Hello, {name}, are you feeling {adjective}?".formatUnicorn({name:"Gabriel", adjective: "OK"});
```

<img src="https://i.stack.imgur.com/jYeIc.png" alt="Firebug">  

You get this output:  

`Hello, Gabriel, are you feeling OK?`  

You can use objects, arrays, and strings as arguments! I got its code and reworked it to produce a new version of `String.prototype.format`:  

```javascript
String.prototype.formatUnicorn = String.prototype.formatUnicorn ||
function () {
    "use strict";
    var str = this.toString();
    if (arguments.length) {
        var t = typeof arguments[0];
        var key;
        var args = ("string" === t || "number" === t) ?
            Array.prototype.slice.call(arguments)
            : arguments[0];

        for (key in args) {
            str = str.replace(new RegExp("\\{" + key + "\\}", "gi"), args[key]);
        }
    }

    return str;
};
```

Note the clever `Array.prototype.slice.call(arguments)` call -- that means if you throw in arguments that are strings or numbers, not a single JSON-style object, you get C#'s <a href="https://msdn.microsoft.com/en-us/library/system.string.format(v=vs.110).aspx#Starting">`String.Format`</a> behavior almost exactly.  

```javascript
"a{0}bcd{1}ef".formatUnicorn("foo", "bar"); // yields "aFOObcdBARef"
```

That's because `Array`'s `slice` will force whatever's in `arguments` into an `Array`, whether it was originally or not, and the `key` will be the index (0, 1, 2...) of each array element coerced into a string (eg, "0", so `"\\{0\\}"` for your first regexp pattern).  

Neat.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: JavaScript chop/slice/trim off last character in string (score [1568123](https://stackoverflow.com/q/952924) in 2017)

#### Question
I have a string, `12345.00`, and I would like it to return `12345.0`.  

I have looked at `trim`, but it looks like it is only trimming whitespace and `slice` which I don't see how this would work. Any suggestions?  

#### Answer accepted (score 2982)
You can use the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/substring" rel="noreferrer">substring</a> function:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
let str = "12345.00";
str = str.substring(0, str.length - 1);
console.log(str);```
</div>
</div>


This is the accepted answer, but as per the conversations below, the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/slice" rel="noreferrer">slice</a> syntax is much clearer:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
let str = "12345.00";
str = str.slice(0, -1); 
console.log(str);```
</div>
</div>


#### Answer 2 (score 1243)
You can use <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/slice" rel="noreferrer">slice</a>! You just have to make sure you know how to use it. Positive #s are relative to the beginning, negative numbers are relative to the end.  

```javascript
js>"12345.00".slice(0,-1)
12345.0
```

#### Answer 3 (score 253)
You can use the <a href="https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/String/substring" rel="noreferrer">substring</a> method of JavaScript string objects:  

```javascript
s = s.substring(0, s.length - 4)
```

It unconditionally removes the last four characters from string `s`.  

However, if you want to <em>conditionally</em> remove the last four characters, only if they are <em>exactly</em> `_bar`:  

```javascript
var re = /_bar$/;
s.replace(re, "");
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: How to loop through a plain JavaScript object with the objects as members? (score [1555849](https://stackoverflow.com/q/921789) in 2018)

#### Question
How can I loop through all members in a JavaScript object including values that are objects.  

For example, how could I loop through this (accessing the "your_name" and "your_message" for each)?  

```javascript
var validation_messages = {
    "key_1": {
        "your_name": "jimmy",
        "your_msg": "hello world"
    },
    "key_2": {
        "your_name": "billy",
        "your_msg": "foo equals bar"
    }
}
```

#### Answer accepted (score 2041)
```javascript
for (var key in validation_messages) {
    // skip loop if the property is from prototype
    if (!validation_messages.hasOwnProperty(key)) continue;

    var obj = validation_messages[key];
    for (var prop in obj) {
        // skip loop if the property is from prototype
        if (!obj.hasOwnProperty(prop)) continue;

        // your code
        alert(prop + " = " + obj[prop]);
    }
}
```

#### Answer 2 (score 721)
Under ECMAScript 5, you can combine `Object.keys()` and `Array.prototype.forEach()`:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var obj = {
  first: "John",
  last: "Doe"
};

//
//	Visit non-inherited enumerable keys
//
Object.keys(obj).forEach(function(key) {

  console.log(key, obj[key]);

});```
</div>
</div>


#### Answer 3 (score 381)
The problem with this  

```javascript
for (var key in validation_messages) {
   var obj = validation_messages[key];
   for (var prop in obj) {
      alert(prop + " = " + obj[prop]);
   }
}
```

is that you’ll also loop through the primitive object's prototype.  

With this one you will avoid it:  

```javascript
for (var key in validation_messages) {
   if (validation_messages.hasOwnProperty(key)) {
      var obj = validation_messages[key];
      for (var prop in obj) {
         if (obj.hasOwnProperty(prop)) {
            alert(prop + " = " + obj[prop]);
         }
      }
   }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: How do I add a class to a given element? (score [1505892](https://stackoverflow.com/q/507138) in 2019)

#### Question
I have an element that already has a class:  

```javascript
<div class="someclass">
    <img ... id="image1" name="image1" />
</div>
```

Now I want to create a JavaScript function that will add a class to the `div` (not replace, but add).  

How can I do that?  

#### Answer accepted (score 1790)
Add a space plus the name of your new class to the `className` property of the element. First, put an `id` on the element so you can easily get a reference.  

```javascript
<div id="div1" class="someclass">
    <img ... id="image1" name="image1" />
</div>
```

Then   

```javascript
var d = document.getElementById("div1");
d.className += " otherclass";
```

Note the space before `otherclass`. It's important to include the space otherwise it compromises existing classes that come before it in the class list.   

See also <a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/className" rel="noreferrer">element.className on MDN</a>.  

#### Answer 2 (score 1301)
The easiest way to do this without any framework is to use <a href="https://developer.mozilla.org/en-US/docs/DOM/element.classList" rel="noreferrer">element.classList.add</a> method.  

```javascript
var element = document.getElementById("div1");
element.classList.add("otherclass");
```

<p><strong>Edit:</strong>
And if you want to remove class from an element - </p>

```javascript
element.classList.remove("otherclass");
```

I prefer not having to add any empty space and duplicate entry handling myself (which is required when using the `document.className` approach). There are some <a href="http://caniuse.com/#feat=classlist" rel="noreferrer">browser limitations</a>, but you can work around them using <a href="https://github.com/Modernizr/Modernizr/wiki/HTML5-Cross-Browser-Polyfills#wiki-classlist" rel="noreferrer">polyfills</a>.  

#### Answer 3 (score 173)
find your target element "d" however you wish and then:  

```javascript
d.className += ' additionalClass'; //note the space
```

you can wrap that in cleverer ways to check pre-existence, and check for space requirements etc..  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Convert JS object to JSON string (score [1499332](https://stackoverflow.com/q/4162749) in 2019)

#### Question
If I defined an object in JS with:  

```javascript
var j={"name":"binchen"};
```

How can I convert the object to JSON? The output string should be:  

```javascript
'{"name":"binchen"}'
```

#### Answer accepted (score 1846)
All current browsers have native JSON support built in. So as long as you're not dealing with prehistoric browsers like IE6/7 you can do it just as easily as that:  

```javascript
var j={"name":"binchen"};
JSON.stringify(j); // '{"name":"binchen"}'
```

#### Answer 2 (score 104)
With `JSON.stringify()` found in <a href="http://www.json.org/js.html" rel="noreferrer">json2.js</a> or native in most modern browsers.  

<blockquote>
```javascript
   JSON.stringify(value, replacer, space)
        value       any JavaScript value, usually an object or array.

       replacer    an optional parameter that determines how object
                    values are stringified for objects. It can be a
                    function or an array of strings.

       space       an optional parameter that specifies the indentation
                    of nested structures. If it is omitted, the text will
                    be packed without extra whitespace. If it is a number,
                    it will specify the number of spaces to indent at each
                    level. If it is a string (such as '\t' or '&nbsp;'),
                    it contains the characters used to indent at each level.

       This method produces a JSON text from a JavaScript value.
```
</blockquote>

#### Answer 3 (score 30)
Check out updated/better way:  

<ul>
<li><a href="http://www.thomasfrank.se/json_stringify_revisited.html" rel="noreferrer">JSON stringify revisited</a></li>
</ul>

<blockquote>
  <p>Update May 17, 2008: Small sanitizer
  added to the toObject-method. <strong>Now
  toObject() will not eval() the string
  if it finds any malicious code in
  it.For even more security: Don't set
  the includeFunctions flag to true.</strong></p>
  
  Douglas Crockford, father of the JSON concept, wrote one of the first stringifiers for JavaScript. Later Steve Yen at Trim Path wrote a nice improved version which I have used for some time. It's my changes to Steve's version that I'd like to share with you. Basically they stemmed from my wish to make the stringifier:  

```javascript
• handle and restore cyclical references  
• include the JavaScript code for functions/methods (as an option)  
• exclude object members from Object.prototype if needed.
```
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: Validate decimal numbers in JavaScript - IsNumeric() (score [1447994](https://stackoverflow.com/q/18082) in 2016)

#### Question
What's the cleanest, most effective way to validate decimal numbers in JavaScript?  

Bonus points for:  

<ol>
<li>Clarity. Solution should be clean and simple.</li>
<li>Cross-platform.</li>
</ol>

Test cases:  

```javascript
01. IsNumeric('-1')      => true
02. IsNumeric('-1.5')    => true
03. IsNumeric('0')       => true
04. IsNumeric('0.42')    => true
05. IsNumeric('.42')     => true
06. IsNumeric('99,999')  => false
07. IsNumeric('0x89f')   => false
08. IsNumeric('#abcdef') => false
09. IsNumeric('1.2.3')   => false
10. IsNumeric('')        => false
11. IsNumeric('blah')    => false
```

#### Answer accepted (score 2860)
<a href="https://stackoverflow.com/questions/18082/validate-numbers-in-javascript-isnumeric/174921#174921">@Joel's answer</a> is pretty close, but it will fail in the following cases:  

```javascript
// Whitespace strings:
IsNumeric(' ')    == true;
IsNumeric('\t\t') == true;
IsNumeric('\n\r') == true;

// Number literals:
IsNumeric(-1)  == false;
IsNumeric(0)   == false;
IsNumeric(1.1) == false;
IsNumeric(8e5) == false;
```

Some time ago I had to implement an `IsNumeric` function, to find out if a variable contained a numeric value, <strong>regardless of its type</strong>, it could be a `String` containing a numeric value (I had to consider also exponential notation, etc.), a `Number` object, virtually anything could be passed to that function, I couldn't make any type assumptions,  taking care of type coercion (eg. `+true == 1;` but `true` shouldn't be considered as `"numeric"`).  

I think is worth sharing this set of <a href="http://run.plnkr.co/plunks/93FPpacuIcXqqKMecLdk/" rel="noreferrer"><strong>+30 unit tests</strong></a> made to numerous function implementations, and also share the one that passes all my tests:  

```javascript
function isNumeric(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
}
```

<strong>P.S.</strong> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/isNaN" rel="noreferrer">isNaN</a> &amp; <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/isFinite" rel="noreferrer">isFinite</a> have a confusing behavior due to forced conversion to number. In ES6, <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/isNaN" rel="noreferrer">Number.isNaN</a> &amp; <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/isFinite" rel="noreferrer">Number.isFinite</a> would fix these issues. Keep that in mind when using them.   

<hr>

<p><strong>Update</strong> : 
<a href="https://github.com/jquery/jquery/blob/2.2-stable/src/core.js#L215" rel="noreferrer">Here's how jQuery does it now (2.2-stable)</a>: </p>

```javascript
isNumeric: function(obj) {
    var realStringObj = obj && obj.toString();
    return !jQuery.isArray(obj) && (realStringObj - parseFloat(realStringObj) + 1) >= 0;
}
```

<p><strong>Update</strong> :
<a href="https://github.com/angular/angular/blob/4.3.x/packages/common/src/pipes/number_pipe.ts#L172" rel="noreferrer">Angular 4.3</a>:</p>

```javascript
export function isNumeric(value: any): boolean {
    return !isNaN(value - parseFloat(value));
}
```

#### Answer 2 (score 329)
Arrrgh!  Don't listen to the regular expression answers.  RegEx is icky for this, and I'm not talking just performance.  It's so easy to make subtle, impossible to spot mistakes with your regular expression.    

If you can't use `isNaN()`, this should work much better:  

```javascript
function IsNumeric(input)
{
    return (input - 0) == input && (''+input).trim().length > 0;
}
```

Here's how it works:  

The `(input - 0)` expression forces JavaScript to do type coercion on your input value; it must first be interpreted as a number for the subtraction operation.  If that conversion to a number fails, the expression will result in `NaN`.  This <em>numeric</em> result is then compared to the original value you passed in.  Since the left hand side is now numeric, type coercion is again used.  Now that the input from both sides was coerced to the same type from the same original value, you would think they should always be the same (always true). However, there's a special rule that says `NaN` is never equal to `NaN`, and so a value that can't be converted to a number (and only values that cannot be converted to numbers) will result in false.   

The check on the length is for a special case involving empty strings. Also note that it falls down on your 0x89f test, but that's because in many environments that's an okay way to define a number literal.  If you want to catch that specific scenario you could add an additional check.  Even better, if that's your reason for not using `isNaN()` then just wrap your own function around `isNaN()` that can also do the additional check.  

In summary, <strong><em>if you want to know if a value can be converted to a number, actually try to convert it to a number.</em></strong>  

<hr>

I went back and did some research for <em>why</em> a whitespace string did not have the expected output, and I think I get it now: an empty string is coerced to `0` rather than `NaN`. Simply trimming the string before the length check will handle this case.  

Running the unit tests against the new code and it only fails on the infinity and boolean literals, and the only time that should be a problem is if you're generating code (really, who would type in a literal and check if it's numeric? You should <em>know</em>), and that would be some strange code to generate.  

But, again, <strong>the only reason ever to use this is if for some reason you have to avoid isNaN().</strong>  

#### Answer 3 (score 65)
This way seems to work well:  

```javascript
function IsNumeric(input){
    var RE = /^-{0,1}\d*\.{0,1}\d+$/;
    return (RE.test(input));
}
```

And to test it:  

```javascript
// alert(TestIsNumeric());

function TestIsNumeric(){
    var results = ''
    results += (IsNumeric('-1')?"Pass":"Fail") + ": IsNumeric('-1') => true\n";
    results += (IsNumeric('-1.5')?"Pass":"Fail") + ": IsNumeric('-1.5') => true\n";
    results += (IsNumeric('0')?"Pass":"Fail") + ": IsNumeric('0') => true\n";
    results += (IsNumeric('0.42')?"Pass":"Fail") + ": IsNumeric('0.42') => true\n";
    results += (IsNumeric('.42')?"Pass":"Fail") + ": IsNumeric('.42') => true\n";
    results += (!IsNumeric('99,999')?"Pass":"Fail") + ": IsNumeric('99,999') => false\n";
    results += (!IsNumeric('0x89f')?"Pass":"Fail") + ": IsNumeric('0x89f') => false\n";
    results += (!IsNumeric('#abcdef')?"Pass":"Fail") + ": IsNumeric('#abcdef') => false\n";
    results += (!IsNumeric('1.2.3')?"Pass":"Fail") + ": IsNumeric('1.2.3') => false\n";
    results += (!IsNumeric('')?"Pass":"Fail") + ": IsNumeric('') => false\n";
    results += (!IsNumeric('blah')?"Pass":"Fail") + ": IsNumeric('blah') => false\n";

    return results;
}
```

I borrowed that regex from <a href="http://www.codetoad.com/javascript/isnumeric.asp" rel="noreferrer">http://www.codetoad.com/javascript/isnumeric.asp</a>. Explanation:  

```javascript
/^ match beginning of string
-{0,1} optional negative sign
\d* optional digits
\.{0,1} optional decimal point
\d+ at least one digit
$/ match end of string
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: Encode URL in JavaScript? (score [1436477](https://stackoverflow.com/q/332872) in 2014)

#### Question
How do you safely encode a URL using JavaScript such that it can be put into a GET string?  

```javascript
var myUrl = "http://example.com/index.html?param=1&anotherParam=2";
var myOtherUrl = "http://example.com/index.html?url=" + myUrl;
```

I assume that you need to encode the `myUrl` variable on that second line?  

#### Answer accepted (score 2700)
<p>Check out the built-in function <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURIComponent" rel="noreferrer">encodeURIComponent(str)</a> and <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURI" rel="noreferrer">encodeURI(str)</a>.<br>
In your case, this should work:</p>

```javascript
var myOtherUrl = 
       "http://example.com/index.html?url=" + encodeURIComponent(myUrl);
```

#### Answer 2 (score 1481)
You have three options:  

<ul>
<li><p>`escape()` will not encode: `@*/+`</p></li>
<li><p>`encodeURI()` will not encode: `~!@#$&amp;*()=:/,;?+'`</p></li>
<li><p>`encodeURIComponent()` will not encode: `~!*()'`</p></li>
</ul>

But in your case, if you want to pass a <a href="http://en.wikipedia.org/wiki/Uniform_Resource_Locator" rel="noreferrer">URL</a> into a `GET` parameter of other page, you should use `escape` or `encodeURIComponent`, but not `encodeURI`.  

See Stack Overflow question <em><a href="https://stackoverflow.com/questions/75980/best-practice-escape-or-encodeuri-encodeuricomponent">Best practice: escape, or encodeURI / encodeURIComponent</a></em> for further discussion.  

#### Answer 3 (score 175)
Stick with <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURIComponent" rel="noreferrer">`encodeURIComponent()`</a>. The function <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURI" rel="noreferrer">`encodeURI()`</a> does not bother to encode many characters that have semantic importance in URLs (e.g. "#", "?", and "&amp;"). <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/escape" rel="noreferrer">`escape()`</a> is deprecated, and does not bother to encode "+" characters, which will be interpreted as encoded spaces on the server (and, as pointed out by others here, does not properly URL-encode non-ASCII characters).  

There is a nice <a href="https://stackoverflow.com/questions/75980/best-practice-escape-or-encodeuri-encodeuricomponent">explanation of the difference between `encodeURI()` and `encodeURIComponent()`</a> elsewhere. If you want to encode something so that it can safely be included as a component of a URI (e.g. as a query string parameter), you want to use `encodeURIComponent()`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: What is the best way to detect a mobile device? (score [1433708](https://stackoverflow.com/q/3514784) in 2019)

#### Question
Is there a solid way to detect whether or not a user is using a mobile device in jQuery? Something similar to the CSS @media attribute? I would like to run a different script if the browser is on a handheld device.  

The jQuery `$.browser` function is not what I am looking for.  

#### Answer accepted (score 1928)
Instead of using jQuery you can use simple JavaScript to detect it:  

```javascript
if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
 // some code..
}
```

Or you can combine them both to make it more accessible through jQuery...  

```javascript
$.browser.device = (/android|webos|iphone|ipad|ipod|blackberry|iemobile|opera mini/i.test(navigator.userAgent.toLowerCase()));
```

Now `$.browser` will return `"device"` for all above devices  

Note: `$.browser` removed on <a href="http://jquery.com/upgrade-guide/1.9/#jquery-browser-removed" rel="noreferrer"><strong>jQuery v1.9.1</strong></a>. But you can use this by using jQuery migration plugin <a href="https://stackoverflow.com/a/15072522/2724173"><strong>Code</strong></a>  

<hr>

A more thorough version:  

```javascript
var isMobile = false; //initiate as false
// device detection
if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent) 
    || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0,4))) { 
    isMobile = true;
}
```

#### Answer 2 (score 493)
For me small is beautiful so I'm using this technique:  

In CSS file:  

```javascript
/* Smartphones ----------- */
@media only screen and (max-width: 760px) {
  #some-element { display: none; }
}
```

In jQuery/JavaScript file:    

```javascript
$( document ).ready(function() {      
    var is_mobile = false;

    if( $('#some-element').css('display')=='none') {
        is_mobile = true;       
    }

    // now i can use is_mobile to run javascript conditionally

    if (is_mobile == true) {
        //Conditional script here
    }
 });
```

My objective was to have my site "mobile friendly". So I use CSS Media Queries do show/hide elements depending on the screen size.  

For example, in my mobile version I don't want to activate the Facebook Like Box, because it loads all those profile images and stuff. And that's not good for mobile visitors. So, besides hiding the container element, I also do this inside the jQuery code block (above):  

```javascript
if(!is_mobile) {
    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/pt_PT/all.js#xfbml=1&appId=210731252294735";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
}
```

You can see it in action at <a href="http://lisboaautentica.com" rel="noreferrer">http://lisboaautentica.com</a>  

I'm still working on the the mobile version, so it's still not looking as it should, as of writing this.  

<strong>Update by <a href="https://stackoverflow.com/users/1226446">dekin88</a></strong>  

<p>There is a JavaScript API built in for detecting media.
Rather than using the above solution simply use the following:</p>

```javascript
$( document ).ready(function() {      
    var isMobile = window.matchMedia("only screen and (max-width: 760px)").matches;

    if (isMobile) {
        //Conditional script here
    }
 });
```

<strong>Browser Supports:</strong> <a href="http://caniuse.com/#feat=matchmedia" rel="noreferrer">http://caniuse.com/#feat=matchmedia</a>  

The advantage to this method is that it's not only simpler and shorter, but you can conditionally target different devices such as smartphones and tablets separately if necessary without having to add any dummy elements into the DOM.  

#### Answer 3 (score 217)
According to <a href="https://developer.mozilla.org/en-US/docs/Browser_detection_using_the_user_agent" rel="noreferrer">Mozilla - Browser detection using the user agent</a>:  

<blockquote>
  In summary, we recommend looking for the string “Mobi” anywhere in the User Agent to detect a mobile device.  
</blockquote>

Like this:  

```javascript
if (/Mobi/.test(navigator.userAgent)) {
    // mobile!
}
```

This will match all common mobile browser user agents, including mobile Mozilla, Safari, IE, Opera, Chrome, etc.  

<strong>Update for Android</strong>  

EricL recommends testing for `Android` as a user agent also, as the <a href="https://developer.chrome.com/multidevice/user-agent#chrome_for_android_user_agent" rel="noreferrer">Chrome user agent string</a> for tablets does not include "Mobi" (the phone versions do however):  

```javascript
if (/Mobi|Android/i.test(navigator.userAgent)) {
    // mobile!
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: Where can I find documentation on formatting a date in JavaScript? (score [1423476](https://stackoverflow.com/q/1056728) in 2018)

#### Question
I noticed that JavaScript's `new Date()` function is very smart in accepting dates in several formats.  

```javascript
Xmas95 = new Date("25 Dec, 1995 23:15:00")
Xmas95 = new Date("2009 06 12,12:52:39")
Xmas95 = new Date("20 09 2006,12:52:39")
```

I could not find documentation anywhere showing all the valid string formats while calling `new Date()` function.  

This is for converting a string to a date. If we look at the opposite side, that is, converting a date object to a string, until now I was under the impression that JavaScript doesn't have a built-in API to format a date object into a string.  

<blockquote>
  <strong>Editor's note:</strong> The following approach is the asker's attempt that worked on a particular browser but does <em>not</em> work in general; <strong>see the answers on this page</strong> to see some actual solutions.  
</blockquote>

Today, I played with the `toString()` method on the date object and surprisingly it serves the purpose of formatting date to strings.  

```javascript
var d1 = new Date();
d1.toString('yyyy-MM-dd');       //Returns "2009-06-29" in Internet Explorer, but not Firefox or Chrome
d1.toString('dddd, MMMM ,yyyy')  //Returns "Monday, June 29,2009" in Internet Explorer, but not Firefox or Chrome
```

Also here I couldn't find any documentation on all the ways we can format the date object into a string.  

Where is the documentation which lists the format specifiers supported by the `Date()` object?  

#### Answer accepted (score 1051)
I love <em><a href="https://www.webdevelopersnotes.com/10-ways-to-format-time-and-date-using-javascript" rel="noreferrer">10 ways to format time and date using JavaScript</a></em> and <em><a href="http://www.elated.com/articles/working-with-dates/" rel="noreferrer">Working with Dates</a></em>.  

Basically, you have three methods and you have to combine the strings for yourself:  

```javascript
getDate() // Returns the date
getMonth() // Returns the month
getFullYear() // Returns the year
```

Example:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var d = new Date();
var curr_date = d.getDate();
var curr_month = d.getMonth() + 1; //Months are zero based
var curr_year = d.getFullYear();
console.log(curr_date + "-" + curr_month + "-" + curr_year);```
</div>
</div>


#### Answer 2 (score 677)
<strong><a href="http://momentjs.com">Moment.js</a></strong>  

It is a (lightweight)* JavaScript date library for parsing, manipulating, and formatting dates.  

```javascript
var a = moment([2010, 1, 14, 15, 25, 50, 125]);
a.format("dddd, MMMM Do YYYY, h:mm:ss a"); // "Sunday, February 14th 2010, 3:25:50 pm"
a.format("ddd, hA");                       // "Sun, 3PM"
```

<em>(*) lightweight meaning 9.3KB minified + gzipped in the smallest possible setup (feb 2014)</em>   

#### Answer 3 (score 425)
If you are already using <a href="http://en.wikipedia.org/wiki/JQuery_UI" rel="noreferrer">jQuery UI</a> in your project, you can use the built-in datepicker method for formatting your date object:  

```javascript
$.datepicker.formatDate('yy-mm-dd', new Date(2007, 1 - 1, 26));
```

However, the datepicker only formats dates, and cannot format times.  

Have a look at <a href="http://docs.jquery.com/UI/Datepicker/formatDate" rel="noreferrer">jQuery UI datepicker formatDate</a>, the examples.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: How do I completely uninstall Node.js, and reinstall from beginning (Mac OS X) (score [1423100](https://stackoverflow.com/q/11177954) in 2017)

#### Question


My version of node is always v0.6.1-pre even after I install brew node and NVM install v0.6.19.  

My node version is:  

```javascript
node -v
v0.6.1-pre
```

NVM says this (after I install a version of node for the first time in one bash terminal):  

```javascript
nvm ls
v0.6.19
current:    v0.6.19
```

But when I restart bash, this is what I see:  

```javascript
nvm ls
v0.6.19
current:    v0.6.1-pre
default -> 0.6.19 (-> v0.6.19)
```

So where is this phantom node 0.6.1-pre version and how can I get rid of it? I'm trying to install libraries via NPM so that I can work on a project.  

<p>I tried using BREW to update before NVM, using "brew update" and "brew install node". 
I've tried deleting the "node" directory in my /usr/local/include and the "node" and "node_modules" in my "/usr/local/lib".
I've tried uninstalling npm and reinstalling it following <a href="https://superuser.com/questions/268946/uninstall-node-js">these</a> instructions.</p>

All of this because I was trying to update an older version of node to install the "zipstream" library. Now there's folders in my users directory, and the node version STILL isn't up to date, even though NVM says it's using 0.6.19.  

<strong>Ideally, I'd like to uninstall nodejs, npm, and nvm, and just reinstall the entire thing from scratch on my system.</strong>  

#### Answer accepted (score 1593)
Apparently, there was a `/Users/myusername/local` folder that contained a `include` with `node` and `lib` with `node` and `node_modules`. How and why this was created instead of in my `/usr/local` folder, I do not know.  

Deleting these local references fixed the phantom v0.6.1-pre. If anyone has an explanation, I'll choose that as the correct answer.  

<strong>EDIT:</strong>  

You may need to do the additional instructions as well:  

```javascript
sudo rm -rf /usr/local/{lib/node{,/.npm,_modules},bin,share/man}/{npm*,node*,man1/node*}
```

which is the equivalent of (same as above)...  

```javascript
sudo rm -rf /usr/local/bin/npm /usr/local/share/man/man1/node* /usr/local/lib/dtrace/node.d ~/.npm ~/.node-gyp 
```

or (same as above) broken down...  

To completely uninstall node + npm is to do the following:  

<ol>
<li>go to <strong>/usr/local/lib</strong> and delete any <strong>node</strong> and <strong>node_modules</strong></li>
<li>go to <strong>/usr/local/include</strong> and delete any <strong>node</strong> and <strong>node_modules</strong> directory </li>
<li>if you installed with <strong>brew install node</strong>, then run <strong>brew uninstall node</strong> in your terminal</li>
<li>check your Home directory for any <strong>local</strong> or <strong>lib</strong> or <strong>include</strong> folders, and delete any <strong>node</strong> or <strong>node_modules</strong> from there</li>
<li>go to <strong>/usr/local/bin</strong> and delete any <strong>node</strong> executable</li>
</ol>

You may also need to do:  

```javascript
sudo rm -rf /opt/local/bin/node /opt/local/include/node /opt/local/lib/node_modules
sudo rm -rf /usr/local/bin/npm /usr/local/share/man/man1/node.1 /usr/local/lib/dtrace/node.d
```

Additionally, NVM modifies the PATH variable in `$HOME/.bashrc`, which must be <a href="https://github.com/creationix/nvm#removal" rel="noreferrer">reverted manually</a>.  

Then download <strong>nvm</strong> and follow the instructions to install node. The latest versions of node come with <strong>npm</strong>, I believe, but you can also reinstall that as well.  

#### Answer 2 (score 450)
<h5><strong>For brew users, OSX</strong>:</h1>

To remove:  

```javascript
brew uninstall node; 
# or `brew uninstall --force node` which removes all versions
brew cleanup;
rm -f /usr/local/bin/npm /usr/local/lib/dtrace/node.d;
rm -rf ~/.npm;
```

To install:   

```javascript
brew install node;
which node # => /usr/local/bin/node
export NODE_PATH='/usr/local/lib/node_modules' # <--- add this ~/.bashrc
```

You can run `brew info node` for more details regarding your node installs.  

<hr>

<h5>consider using NVM instead of brew</h1>

NVM (node version manager) is a portable solution for managing multiple versions of node  

<h5><a href="https://github.com/creationix/nvm" rel="noreferrer">https://github.com/creationix/nvm</a></h2>

```javascript
> nvm uninstall v4.1.0
> nvm install v8.1.2
> nvm use v8.1.2
> nvm list
         v4.2.0
         v5.8.0
        v6.11.0
->       v8.1.2
         system
```

<ul>
<li><a href="https://github.com/wbyoung/avn" rel="noreferrer">you can use this with AVN</a> to automatically switch versions as you hop between different projects with different node dependencies. </li>
</ul>

#### Answer 3 (score 179)
I know this post is a little dated but just wanted to share the commands that worked for me in Terminal when removing Node.js.  

```javascript
lsbom -f -l -s -pf /var/db/receipts/org.nodejs.pkg.bom | while read f; do  sudo rm /usr/local/${f}; done

sudo rm -rf /usr/local/lib/node /usr/local/lib/node_modules /var/db/receipts/org.nodejs.*
```

<hr/>

<h5>UPDATE: `23 SEP 2016`</h1>

<hr/>

<h5>If you're afraid of running these commands...</h1>

Thanks to <a href="https://gist.github.com/jguix" rel="noreferrer">`jguix`</a> for <a href="https://gist.github.com/TonyMtz/d75101d9bdf764c890ef#gistcomment-1880118" rel="noreferrer">`this quick tutorial`</a>.  

<strong>First, create an intermediate file:</strong>  

```javascript
lsbom -f -l -s -pf /var/db/receipts/org.nodejs.node.pkg.bom >> ~/filelist.txt
```

<strong>Manually review your file (located in your `Home` folder)</strong>  

```javascript
 ~/filelist.txt
```

<strong>Then delete the files:</strong>  

```javascript
cat ~/filelist.txt | while read f; do sudo rm /usr/local/${f}; done

sudo rm -rf /usr/local/lib/node /usr/local/lib/node_modules /var/db/receipts/org.nodejs.*
```

<hr/>

<h5>For 10.10.5 and above</h1>

<strong>Thanks <a href="https://stackoverflow.com/users/852592/lenar-hoyt">`Lenar Hoyt`</a></strong>  

<strong>Gist Comment Source:</strong> <a href="https://gist.github.com/TonyMtz/d75101d9bdf764c890ef#gistcomment-1572198" rel="noreferrer">`gistcomment-1572198`</a>  

<strong>Original Gist:</strong> <a href="https://gist.github.com/TonyMtz/d75101d9bdf764c890ef#file-gistfile1-txt" rel="noreferrer">`TonyMtz/d75101d9bdf764c890ef`</a>  

```javascript
lsbom -f -l -s -pf /var/db/receipts/org.nodejs.node.pkg.bom | while read f; do sudo rm /usr/local/${f}; done

sudo rm -rf /usr/local/lib/node /usr/local/lib/node_modules /var/db/receipts/org.nodejs.*
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: How to check if an object is an array? (score [1421658](https://stackoverflow.com/q/4775722) in 2019)

#### Question
I'm trying to write a function that either accepts a list of strings, or a single string. If it's a string, then I want to convert it to an array with just the one item. Then I can loop over it without fear of an error.   

So how do I check if the variable is an array?  

<hr>

I've rounded up the various solutions below and created a <a href="http://jsperf.com/js-isarray-comparison" rel="noreferrer">jsperf test</a>.  

#### Answer accepted (score 773)
In modern browsers you can do  

```javascript
Array.isArray(obj)
```

(<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/isArray" rel="noreferrer">Supported by</a> Chrome 5, Firefox 4.0, IE 9, Opera 10.5 and Safari 5)  

For backward compatibility you can add the following  

```javascript
# only implement if no native implementation is available
if (typeof Array.isArray === 'undefined') {
  Array.isArray = function(obj) {
    return Object.prototype.toString.call(obj) === '[object Array]';
  }
};
```

If you use jQuery you can use `jQuery.isArray(obj)` or `$.isArray(obj)`. If you use underscore you can use `_.isArray(obj)`  

If you don't need to detect arrays created in different frames you can also just use `instanceof`  

```javascript
obj instanceof Array
```

#### Answer 2 (score 1916)
The method given in the ECMAScript standard to find the class of Object is to use the `toString` method from `Object.prototype`.  

```javascript
if( Object.prototype.toString.call( someVar ) === '[object Array]' ) {
    alert( 'Array!' );
}
```

Or you could use `typeof` to test if it is a String:  

```javascript
if( typeof someVar === 'string' ) {
    someVar = [ someVar ];
}
```

Or if you're not concerned about performance, you could just do a `concat` to a new empty Array.  

```javascript
someVar = [].concat( someVar );
```

There's also the constructor which you can query directly:  

```javascript
if (somevar.constructor.name == "Array") {
    // do something
}
```

<hr>

Check out a <a href="http://blog.niftysnippets.org/2010/09/say-what.html" rel="noreferrer">thorough treatment</a> from <a href="https://stackoverflow.com/users/157247/t-j-crowder">@T.J. Crowder's</a> blog, as posted in his comment below.  

Check out this <a href="http://jsben.ch/#/QgYAV" rel="noreferrer">benchmark</a> to get an idea which method performs better: <a href="http://jsben.ch/#/QgYAV" rel="noreferrer">http://jsben.ch/#/QgYAV</a>  

From <a href="https://stackoverflow.com/users/8432239/bharath?tab=profile">@Bharath</a> convert string to array using Es6 for the question asked:  

```javascript
const convertStringToArray = (object) => {
   return (typeof object === 'string') ? Array(object) : object 
}
```

suppose:   

```javascript
let m = 'bla'
let n = ['bla','Meow']
let y = convertStringToArray(m)
let z = convertStringToArray(n)
console.log('check y: '+JSON.stringify(y)) . // check y: ['bla']
console.log('check y: '+JSON.stringify(z)) . // check y: ['bla','Meow']
```

#### Answer 3 (score 1254)
I would first check if your implementation supports `isArray`:  

```javascript
if (Array.isArray)
    return Array.isArray(v);
```

You could also try using the `instanceof` operator  

```javascript
v instanceof Array
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: Get the size of the screen, current web page and browser window (score [1416478](https://stackoverflow.com/q/3437786) in 2017)

#### Question
How can I get `windowWidth`, `windowHeight`, `pageWidth`, `pageHeight`, `screenWidth`, `screenHeight`, `pageX`, `pageY`, `screenX`, `screenY` which will work in all major browsers?  

<img src="https://i.stack.imgur.com/6xPdH.png" alt="screenshot describing which values are wanted">  

#### Answer accepted (score 1313)
You can get the size of the window or document with jQuery:  

```javascript
// Size of browser viewport.
$(window).height();
$(window).width();

// Size of HTML document (same as pageHeight/pageWidth in screenshot).
$(document).height();
$(document).width();
```

For screen size you can use the <a href="https://developer.mozilla.org/en-US/docs/Web/API/Window/screen" rel="noreferrer">`screen`</a> object:  

```javascript
window.screen.height;
window.screen.width;
```

#### Answer 2 (score 920)
This has everything you need to know: <a href="https://andylangton.co.uk/blog/development/get-viewportwindow-size-width-and-height-javascript" rel="noreferrer">Get viewport/window size</a>  

but in short:  

```javascript
var win = window,
    doc = document,
    docElem = doc.documentElement,
    body = doc.getElementsByTagName('body')[0],
    x = win.innerWidth || docElem.clientWidth || body.clientWidth,
    y = win.innerHeight|| docElem.clientHeight|| body.clientHeight;
alert(x + ' × ' + y);
```

<strong><a href="http://fiddle.jshell.net/L6uPV/show/" rel="noreferrer">Fiddle</a></strong>  

Please stop editing this answer. It's been edited 20 times now by different people to match their code format preference. It's also been pointed out that this isn't required if you only want to target modern browsers - if so you only need the following:  

```javascript
const width  = window.innerWidth || document.documentElement.clientWidth || 
document.body.clientWidth,
const height = window.innerHeight|| document.documentElement.clientHeight|| 
document.body.clientHeight;

console.log(width, height);
```

#### Answer 3 (score 455)
Here is a cross browser solution with pure <strong>JavaScript</strong> (<a href="http://www.w3schools.com/jsref/prop_win_innerheight.asp" rel="noreferrer">Source</a>):   

```javascript
var width = window.innerWidth
|| document.documentElement.clientWidth
|| document.body.clientWidth;

var height = window.innerHeight
|| document.documentElement.clientHeight
|| document.body.clientHeight;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: How does Access-Control-Allow-Origin header work? (score [1414222](https://stackoverflow.com/q/10636611) in 2016)

#### Question
Apparently, I have completely misunderstood its semantics. I thought of something like this:  

<ol>
<li>A client downloads javascript code MyCode.js from http://siteA - <strong>the origin</strong>.</li>
<li>The response header of MyCode.js contains <strong>Access-Control-Allow-Origin: http://siteB</strong>, which I thought meant that MyCode.js was allowed to make cross-origin references to the site B.</li>
<li>The client triggers some functionality of MyCode.js, which in turn make requests to http://siteB, which should be fine, despite being cross-origin requests.</li>
</ol>

Well, I am wrong. It does not work like this at all. So, I have read <a href="http://en.wikipedia.org/wiki/Cross-origin_resource_sharing">Cross-origin resource sharing</a> and attempted to read <a href="http://www.w3.org/TR/cors/.">Cross-Origin Resource Sharing in w3c recommendation</a>  

One thing is sure - I still do not understand how am I supposed to use this header.   

I have full control of both site A and site B. How do I enable the javascript code downloaded from the site A to access resources on the site B using this header?  

P.S.  

I do not want to utilize JSONP.  

#### Answer accepted (score 1313)
`Access-Control-Allow-Origin` is a <a href="http://www.html5rocks.com/en/tutorials/cors/" rel="noreferrer">CORS (Cross-Origin Resource Sharing) header</a>.  

When Site A tries to fetch content from Site B,  Site B can send an `Access-Control-Allow-Origin` response header to tell the browser that the content of this page is accessible to certain origins. (An <em>origin</em> is a <a href="https://stackoverflow.com/a/19542686/710446">domain, plus a scheme and port number</a>.)  By default, Site B's pages are <a href="https://en.wikipedia.org/wiki/Same-origin_policy" rel="noreferrer">not accessible to any other origin</a>; using the `Access-Control-Allow-Origin` header opens a door for cross-origin access by specific requesting origins.  

For each resource/page that Site B wants to make accessible to Site A, Site B should serve its pages with the response header:  

```javascript
Access-Control-Allow-Origin: http://siteA.com
```

Modern browsers will not block cross-domain requests outright.  If Site A requests a page from Site B, the browser will actually fetch the requested page <em>on the network level</em> and check if the response headers list Site A as a permitted requester domain.  If Site B has not indicated that Site A is allowed to access this page, the browser will trigger the `XMLHttpRequest`'s `error` event and  deny the response data to the requesting JavaScript code.  

<h5>Non-simple requests</h1>

What happens on the network level can be <em>slightly</em> more complex than explained above. If the request is a <a href="http://www.html5rocks.com/en/tutorials/cors/#toc-handling-a-not-so-simple-request" rel="noreferrer">"non-simple" request</a>, the browser first sends a data-less "preflight" OPTIONS request, to verify that the server will accept the request. A request is non-simple when either (or both):  

<ul>
<li>using an HTTP verb other than GET or POST (e.g. PUT, DELETE)</li>
<li>using non-simple request headers; the only simple requests headers are:

<ul>
<li>`Accept`</li>
<li>`Accept-Language`</li>
<li>`Content-Language`</li>
<li>`Content-Type` (this is only simple when its value is `application/x-www-form-urlencoded`, `multipart/form-data`, or `text/plain`)</li>
</ul></li>
</ul>

If the server responds to the OPTIONS preflight with appropriate response headers (`Access-Control-Allow-Headers` for non-simple headers, `Access-Control-Allow-Methods` for non-simple verbs) that match the non-simple verb and/or non-simple headers, then the browser sends the actual request.  

Supposing that Site A wants to send a PUT request for `/somePage`, with a non-simple `Content-Type` value of `application/json`, the browser would first send a preflight request:  

```javascript
OPTIONS /somePage HTTP/1.1
Origin: http://siteA.com
Access-Control-Request-Method: PUT
Access-Control-Request-Headers: Content-Type
```

Note that `Access-Control-Request-Method` and `Access-Control-Request-Headers` are added by the browser automatically; you do not need to add them. This OPTIONS preflight gets the successful response headers:  

```javascript
Access-Control-Allow-Origin: http://siteA.com
Access-Control-Allow-Methods: GET, POST, PUT
Access-Control-Allow-Headers: Content-Type
```

When sending the actual request (after preflight is done), the behavior is identical to how a simple request is handled. In other words, a non-simple request whose preflight is successful is treated the same as a simple request (i.e., the server must still send `Access-Control-Allow-Origin` again for the actual response).  

The browsers sends the actual request:  

```javascript
PUT /somePage HTTP/1.1
Origin: http://siteA.com
Content-Type: application/json

{ "myRequestContent": "JSON is so great" }
```

And the server sends back an `Access-Control-Allow-Origin`, just as it would for a simple request:  

```javascript
Access-Control-Allow-Origin: http://siteA.com
```

See <a href="https://stackoverflow.com/a/13400954/710446">Understanding XMLHttpRequest over CORS</a> for a little more information about non-simple requests.  

#### Answer 2 (score 114)
Cross-Origin Request Sharing - `CORS` (A.K.A. Cross-Domain AJAX request) is an issue that most web developers might encounter, according to Same-Origin-Policy, browsers restrict client JavaScript in a security sandbox, usually JS cannot directly communicate with a remote server from a different domain. In the past developers created many tricky ways to achieve Cross-Domain resource request, most commonly using ways are:  

<ol>
<li>Use Flash/Silverlight or server side as a "proxy" to communicate
with remote. </li>
<li>JSON With Padding (<a href="http://en.wikipedia.org/wiki/JSONP">JSONP</a>). </li>
<li>Embeds remote server in an iframe and communicate through fragment or window.name, refer <a href="http://www.ibm.com/developerworks/library/wa-crossdomaincomm/#N10120">here</a>.</li>
</ol>

Those tricky ways have more or less some issues, for example JSONP might result in security hole if developers simply "eval" it, and #3 above, although it works, both domains should build strict contract between each other, it neither flexible nor elegant IMHO:)  

W3C had introduced Cross-Origin Resource Sharing (CORS) as a standard solution to provide a safe, flexible and a recommended standard way to solve this issue.   

<strong>The Mechanism</strong>  

From a high level we can simply deem CORS is a contract between client AJAX call from domain A and a page hosted on domain B, a typical Cross-Origin request/response would be:  

<strong>DomainA AJAX request headers</strong>  

```javascript
Host DomainB.com
User-Agent Mozilla/5.0 (Windows NT 6.1; WOW64; rv:2.0) Gecko/20100101 Firefox/4.0
Accept text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8,application/json
Accept-Language en-us;
Accept-Encoding gzip, deflate
Keep-Alive 115
Origin http://DomainA.com 
```

<strong>DomainB response headers</strong>  

```javascript
Cache-Control private
Content-Type application/json; charset=utf-8
Access-Control-Allow-Origin DomainA.com
Content-Length 87
Proxy-Connection Keep-Alive
Connection Keep-Alive
```

The blue parts I marked above were the kernal facts, "Origin" request header "indicates where the cross-origin request or preflight request originates from", the "Access-Control-Allow-Origin" response header indicates this page allows remote request from DomainA (if the value is * indicate allows remote requests from any domain).  

As I mentioned above, W3 recommended browser to implement a "<strong>preflight request</strong>" before submiting the actually Cross-Origin HTTP request, in a nutshell it is an HTTP `OPTIONS` request:  

```javascript
OPTIONS DomainB.com/foo.aspx HTTP/1.1
```

If foo.aspx supports OPTIONS HTTP verb, it might return response like below:  

```javascript
HTTP/1.1 200 OK
Date: Wed, 01 Mar 2011 15:38:19 GMT
Access-Control-Allow-Origin: http://DomainA.com
Access-Control-Allow-Methods: POST, GET, OPTIONS, HEAD
Access-Control-Allow-Headers: X-Requested-With
Access-Control-Max-Age: 1728000
Connection: Keep-Alive
Content-Type: application/json
```

Only if the response contains "Access-Control-Allow-Origin" AND its value is "*" or contain the domain who submitted the CORS request, by satisfying this mandtory condition browser will submit the actual Cross-Domain request, and cache the result in "<strong>Preflight-Result-Cache</strong>".  

I blogged about CORS three years ago: <a href="http://wayneye.com/Blog/Ajax-Cross-Origin-HTTP-request">AJAX Cross-Origin HTTP request</a>  

#### Answer 3 (score 50)
Question is a bit too old to answer, but I am posting this for any future reference to this question.  

According to <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS" rel="noreferrer">this</a> Mozilla Developer Network article,  

<blockquote>
  A resource makes a <strong>cross-origin HTTP request</strong> when it requests a resource from a different domain, or port than the one which the first resource itself serves.  
</blockquote>

<a href="https://i.stack.imgur.com/zn3sT.png" rel="noreferrer"><img src="https://i.stack.imgur.com/zn3sT.png" alt="enter image description here"></a>  

<p>An <strong>HTML page</strong> served from `http://domain-a.com` makes an `&lt;img&gt;` src request for `http://domain-b.com/image.jpg`.<br>
Many pages on the web today load resources like <strong>CSS stylesheets</strong>, <strong>images</strong> and <strong>scripts</strong> from separate domains (thus it should be cool).</p>

<h5>Same-Origin Policy</h1>

<p>For security reasons, browsers restrict <strong>cross-origin HTTP</strong> requests <strong>initiated from within scripts</strong>.<br>
For example, `XMLHttpRequest` and `Fetch` follow the <strong>same-origin policy</strong>.<br>
So, a web application using `XMLHttpRequest` or `Fetch` could only make <strong>HTTP requests</strong> to <strong>its own domain</strong>.</p>

<h5>Cross-Origin Resource Sharing (CORS)</h1>

To improve web applications, developers asked browser vendors to allow cross-domain requests.  

<p>The <strong>Cross-Origin Resource Sharing (CORS)</strong> mechanism gives web servers <strong>cross-domain access controls</strong>, which enable secure cross-domain data transfers.<br>
Modern browsers use <strong>CORS</strong> in an <strong>API container</strong> - such as `XMLHttpRequest` or `Fetch` - to mitigate risks of cross-origin HTTP requests.</p>

<h5>How CORS works (`Access-Control-Allow-Origin` header)</h2>

<a href="https://en.wikipedia.org/wiki/Cross-origin_resource_sharing" rel="noreferrer">Wikipedia</a>:  

<blockquote>
  The CORS standard describes new HTTP headers which provide browsers and servers a way to request remote URLs only when they have permission.  
  
  Although some validation and authorization can be performed by the server, <strong>it is generally the browser's responsibility</strong> to support these headers and honor the restrictions they impose.  
</blockquote>

<h5>Example</h1>

<ol>
<li><p>The browser sends the `OPTIONS` request with an `Origin HTTP` header. </p>

The value of this header is the domain that served the parent page. When a page from `http://www.example.com` attempts to access a user's data in `service.example.com`, the following request header would be sent to `service.example.com`:  

Origin: <a href="http://www.example.com" rel="noreferrer">http://www.example.com</a>  </li>
<li><p>The server at `service.example.com` may respond with:</p>

<ul>
<li><p>An `Access-Control-Allow-Origin` (ACAO) header in its response indicating which origin sites are allowed.<br>
For example:  </p>

`Access-Control-Allow-Origin: http://www.example.com`  </li>
<li><p>An error page if the server does not allow the cross-origin request</p></li>
<li><p>An `Access-Control-Allow-Origin` (ACAO) header with a wildcard that allows all domains:</p>

`Access-Control-Allow-Origin: *`  </li>
</ul></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: Remove element by id (score [1399549](https://stackoverflow.com/q/3387427) in 2016)

#### Question
When removing an element with standard JavaScript, you must go to its parent first:  

```javascript
var element = document.getElementById("element-id");
element.parentNode.removeChild(element);
```

Having to go to the parent node first seems a bit odd to me, is there a reason JavaScript works like this?  

#### Answer accepted (score 79)
The DOM is organized in a tree of nodes, where each node has a value, along with a list of references to its child nodes. So `element.parentNode.removeChild(element)` mimics exactly what is happening internally: First you go the the parent node, then remove the reference to the child node.  

As of DOM4, a helper function is provided to do the same thing: <a href="https://developer.mozilla.org/en/docs/Web/API/ChildNode.remove">`element.remove()`</a>. This <a href="http://caniuse.com/#search=remove">works in 87% of browsers</a> (as of 2016), but not IE 11. If you need to support older browsers, you can:  

<ul>
<li>Remove elements via the parent node, as in <a href="https://www.google.com/search?q=What%20is%20the%20answer%20to%20the%20ultimate%20question%20of%20life,%20the%20universe,%20and%20everything%3F">the question</a>,</li>
<li>modify the native DOM functions, as in <a href="https://stackoverflow.com/a/18120786/405550">Johan Dettmar's answer</a>, or</li>
<li>use a <a href="https://github.com/WebReflection/dom4#dom4">DOM4 polyfill</a>.</li>
</ul>

#### Answer 2 (score 603)
I know that augmenting native DOM functions isn't always the best or most popular solution, but this works fine for modern browsers.  

```javascript
Element.prototype.remove = function() {
    this.parentElement.removeChild(this);
}
NodeList.prototype.remove = HTMLCollection.prototype.remove = function() {
    for(var i = this.length - 1; i >= 0; i--) {
        if(this[i] && this[i].parentElement) {
            this[i].parentElement.removeChild(this[i]);
        }
    }
}
```

And then you can remove elements like this    

```javascript
document.getElementById("my-element").remove();
```

or  

```javascript
document.getElementsByClassName("my-elements").remove();
```

<strong>Note:</strong> this solution doesn't work for IE 7 and below. For more info about extending the DOM read this <a href="http://perfectionkills.com/whats-wrong-with-extending-the-dom/" rel="noreferrer">article</a>.  

<strong>EDIT</strong>: Reviewing my answer in 2019, `node.remove()` has come to the rescue and can be used as follows (without the polyfill above):  

```javascript
document.getElementById("my-element").remove();
```

or  

```javascript
[...document.getElementsByClassName("my-elements")].map(n => n && n.remove());
```

These functions are available in all modern browsers (not IE). Read more on <a href="https://developer.mozilla.org/en-US/docs/Web/API/ChildNode/remove" rel="noreferrer">MDN</a>.  

#### Answer 3 (score 268)
Crossbrowser and IE >= 11:  

```javascript
document.getElementById("element-id").outerHTML = "";
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: JavaScript check if variable exists (is defined/initialized) (score [1385078](https://stackoverflow.com/q/5113374) in 2015)

#### Question
<p>Which method of checking if a variable has been initialized is better/correct?
(Assuming the variable could hold anything (string, int, object, function, etc.))</p>

```javascript
if (elem) { // or !elem
```

or  

```javascript
if (typeof(elem) !== 'undefined') {
```

or  

```javascript
if (elem != null) {
```

#### Answer accepted (score 801)
The `typeof` operator will check if the variable is really undefined.  

```javascript
if (typeof variable === 'undefined') {
    // variable is undefined
}
```

The `typeof` operator, unlike the other operators, doesn't throw a <em>ReferenceError</em> exception when used with an undeclared variable.  

However, do note that `typeof null` will return `"object"`. We have to be careful to avoid the mistake of initializing a variable to `null`. To be safe, this is what we could use instead:  

```javascript
if (typeof variable === 'undefined' || variable === null) {
    // variable is undefined or null
}
```

<hr>

For more info on using strict comparison `===` instead of simple equality `==`, see:<br><a href="https://stackoverflow.com/q/359494/584192">Which equals operator (== vs ===) should be used in JavaScript comparisons?</a>  

#### Answer 2 (score 2862)
You want <a href="https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Operators/Special_Operators/typeof_Operator" rel="noreferrer">the `typeof` operator</a>. Specifically:  

```javascript
if (typeof variable !== 'undefined') {
    // the variable is defined
}
```

#### Answer 3 (score 205)
In JavaScript, a variable can be defined, but hold the value `undefined`, so the most common answer is not technically correct, and instead performs the following:  

```javascript
if (typeof v === "undefined") {
   // no variable "v" is defined in the current scope
   // *or* some variable v exists and has been assigned the value undefined
} else {
   // some variable (global or local) "v" is defined in the current scope
   // *and* it contains a value other than undefined
}
```

That may suffice for your purposes.  The following test has simpler semantics, which makes it easier to precisely describe your code's behavior and understand it yourself (if you care about such things):  

```javascript
if ("v" in window) {
   // global variable v is defined
} else {
   // global variable v is not defined
}
```

This, of course, assumes you are running in a browser (where `window` is a name for the global object).  But if you're mucking around with globals like this you're probably in a browser.  Subjectively, using `'name' in window` is stylistically consistent with using `window.name` to refer to globals.  Accessing globals as properties of `window` rather than as variables allows you to minimize the number of undeclared variables you reference in your code (for the benefit of linting), and avoids the possibility of your global being shadowed by a local variable.  Also, if globals make your skin crawl you might feel more comfortable touching them only with this relatively long stick.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: Writing files in Node.js (score [1381849](https://stackoverflow.com/q/2496710) in 2018)

#### Question
I've been trying to find a way to write to a file when using Node.js, but with no success. How can I do that?  

#### Answer accepted (score 2282)
There are a lot of details in the <a href="http://nodejs.org/docs/latest/api/fs.html" rel="noreferrer">File System API</a>. The most common way is:  

```javascript
const fs = require('fs');

fs.writeFile("/tmp/test", "Hey there!", function(err) {

    if(err) {
        return console.log(err);
    }

    console.log("The file was saved!");
}); 
```

#### Answer 2 (score 512)
Currently there are three ways to write a file:  

<ol>
<li><p><a href="http://nodejs.org/api/fs.html#fs_fs_write_fd_buffer_offset_length_position_callback" rel="noreferrer">`fs.write(fd, buffer, offset, length, position, callback`)</a></p>

You need to wait for the callback to ensure that the buffer is written to disk. It's not buffered.  </li>
<li><p><a href="http://nodejs.org/api/fs.html#fs_fs_writefile_filename_data_options_callback" rel="noreferrer">`fs.writeFile(filename, data, [encoding], callback)`</a></p>

All data must be stored at the same time; you cannot perform sequential writes.  </li>
<li><p><a href="http://nodejs.org/api/fs.html#fs_fs_createwritestream_path_options" rel="noreferrer">`fs.createWriteStream(path, [options]`)</a></p>

Creates a <a href="https://github.com/joyent/node/blob/master/lib/fs.js#L1623" rel="noreferrer">`WriteStream`</a>, which is convenient because you don't need to wait for a callback. But again, it's not buffered.  </li>
</ol>

A <a href="https://github.com/joyent/node/blob/master/lib/fs.js#L1623" rel="noreferrer">`WriteStream`</a>, as the name says, is a stream. A stream by definition is “a buffer” containing data which moves in one direction (source ► destination). But a writable stream is not necessarily “buffered”. A stream is “buffered” when you write `n` times, and at time `n+1`, the stream sends the buffer to the kernel (because it's full and needs to be flushed).  

<strong>In other words:</strong> “A buffer” is the object. Whether or not it “is buffered” is a property of that object.  

If you look at the code, the `WriteStream` inherits from a writable `Stream` object. If you pay attention, you’ll see how they flush the content; they don't have any buffering system.  

If you write a string, it’s converted to a buffer, and then sent to the native layer and written to disk. When writing strings, they're not filling up any buffer. So, if you do:  



```javascript
write("a")
write("b")
write("c")
```

You're doing:  

```javascript
fs.write(new Buffer("a"))
fs.write(new Buffer("b"))
fs.write(new Buffer("c"))
```

That’s <em>three</em> calls to the I/O layer. Although you're using “buffers”, the data is not buffered. A buffered stream would do: `fs.write(new Buffer ("abc"))`, one call to the I/O layer.  

<p>As of now, in Node.js v0.12 (stable version announced 02/06/2015) now supports two functions:
<a href="http://nodejs.org/docs/v0.11.5/api/stream.html#stream_writable_cork" rel="noreferrer">`cork()`</a> and
<a href="http://nodejs.org/docs/v0.11.5/api/stream.html#stream_writable_uncork" rel="noreferrer">`uncork()`</a>. It seems that these functions will finally allow you to buffer/flush the write calls.</p>

For example, in Java there are some classes that provide buffered streams (`BufferedOutputStream`, `BufferedWriter`...). If you write three bytes, these bytes will be stored in the buffer (memory) instead of doing an I/O call just for three bytes. When the buffer is full the content is flushed and saved to disk. This improves performance.  

I'm not discovering anything, just remembering how a disk access should be done.  

#### Answer 3 (score 243)
You can of course make it a little more advanced. Non-blocking, writing bits and pieces, not writing the whole file at once:  

```javascript
var fs = require('fs');
var stream = fs.createWriteStream("my_file.txt");
stream.once('open', function(fd) {
  stream.write("My first row\n");
  stream.write("My second row\n");
  stream.end();
});
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: How do JavaScript closures work? (score [1379921](https://stackoverflow.com/q/111102) in 2017)

#### Question
How would you explain JavaScript closures to someone with a knowledge of the concepts they consist of (for example functions, variables and the like), but does not understand closures themselves?  

I have seen <a href="http://en.wikipedia.org/wiki/Scheme_%28programming_language%29" rel="noreferrer">the Scheme example</a> given on Wikipedia, but unfortunately it did not help.  

#### Answer accepted (score 7025)
<h5>JavaScript closures for beginners</h1>

<blockquote>Submitted by Morris on Tue, 2006-02-21 10:19.  Community-edited since.</blockquote>

<h5>Closures are not magic</h2>

This page explains closures so that a programmer can understand them &mdash; using working JavaScript code. It is not for gurus or functional programmers.  

Closures are <em>not hard</em> to understand once the core concept is grokked. However, they are impossible to understand by reading any theoretical or academically oriented explanations!  

This article is intended for programmers with some programming experience in a mainstream language, and who can read the following JavaScript function:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function sayHello(name) {
  var text = 'Hello ' + name;
  var say = function() { console.log(text); }
  say();
}
sayHello('Joe');```
</div>
</div>


<h5>Two brief summaries</h2>

<ul>
<li><p>When a function (`foo`) declares other functions (bar and baz), the family of local variables created in `foo` is <em>not destroyed</em> when the function exits. The variables merely become invisible to the outside world. `foo` can therefore cunningly return the functions `bar` and `baz`, and they can continue to read, write and communicate with each other through this closed-off family of variables ("the closure") that nobody else can meddle with, not even someone who calls `foo` again in future.</p></li>
<li><p>A closure is one way of supporting <a href="https://en.wikipedia.org/wiki/First-class_function" rel="noreferrer">first-class functions</a>; it is an expression that can reference variables within its scope (when it was first declared), be assigned to a variable, be passed as an argument to a function, or be returned as a function result. </p></li>
</ul>

<h5>An example of a closure</h2>

The following code returns a reference to a function:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function sayHello2(name) {
  var text = 'Hello ' + name; // Local variable
  var say = function() { console.log(text); }
  return say;
}
var say2 = sayHello2('Bob');
say2(); // logs "Hello Bob"```
</div>
</div>


Most JavaScript programmers will understand how a reference to a function is returned to a variable (`say2`) in the above code. If you don't, then you need to look at that before you can learn closures. A programmer using C would think of the function as returning a pointer to a function, and that the variables `say` and `say2` were each a pointer to a function.  

There is a critical difference between a C pointer to a function and a JavaScript reference to a function. In JavaScript, you can think of a function reference variable as having both a pointer to a function <em>as well</em> as a hidden pointer to a closure.  

The above code has a closure because the anonymous function `function() { console.log(text); }` is declared <em>inside</em> another function, `sayHello2()` in this example. In JavaScript, if you use the `function` keyword inside another function, you are creating a closure.  

In C and most other common languages, <em>after</em> a function returns, all the local variables are no longer accessible because the stack-frame is destroyed.  

In JavaScript, if you declare a function within another function, then the local variables of the outer function can remain accessible after returning from it. This is demonstrated above, because we call the function `say2()` after we have returned from `sayHello2()`. Notice that the code that we call references the variable `text`, which was a <em>local variable</em> of the function `sayHello2()`.  

```javascript
function() { console.log(text); } // Output of say2.toString();
```

Looking at the output of `say2.toString()`, we can see that the code refers to the variable `text`. The anonymous function can reference `text` which holds the value `'Hello Bob'` because the local variables of `sayHello2()` have been secretly kept alive in a closure.  

The genius is that in JavaScript a function reference also has a secret reference to the closure it was created in &mdash; similar to how delegates are a method pointer plus a secret reference to an object.  

<h5>More examples</h2>

<p>For some reason, closures seem really hard to understand when you read about them, but when you see some examples, it becomes clear how they work (it took me a while).
I recommend working through the examples carefully until you understand how they work. If you start using closures without fully understanding how they work, you would soon create some very weird bugs!</p>

<h5>Example 3</h3>

This example shows that the local variables are not copied &mdash; they are kept by reference. It is as though the stack-frame stays alive in memory even after the outer function exits!  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function say667() {
  // Local variable that ends up within closure
  var num = 42;
  var say = function() { console.log(num); }
  num++;
  return say;
}
var sayNumber = say667();
sayNumber(); // logs 43```
</div>
</div>


<h5>Example 4</h3>

All three global functions have a common reference to the <em>same</em> closure because they are all declared within a single call to `setupSomeGlobals()`.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var gLogNumber, gIncreaseNumber, gSetNumber;
function setupSomeGlobals() {
  // Local variable that ends up within closure
  var num = 42;
  // Store some references to functions as global variables
  gLogNumber = function() { console.log(num); }
  gIncreaseNumber = function() { num++; }
  gSetNumber = function(x) { num = x; }
}

setupSomeGlobals();
gIncreaseNumber();
gLogNumber(); // 43
gSetNumber(5);
gLogNumber(); // 5

var oldLog = gLogNumber;

setupSomeGlobals();
gLogNumber(); // 42

oldLog() // 5```
</div>
</div>


The three functions have shared access to the same closure &mdash; the local variables of `setupSomeGlobals()` when the three functions were defined.  

Note that in the above example, if you call `setupSomeGlobals()` again, then a new closure (stack-frame!) is created. The old `gLogNumber`, `gIncreaseNumber`, `gSetNumber` variables are overwritten with <em>new</em> functions that have the new closure. (In JavaScript, whenever you declare a function inside another function, the inside function(s) is/are recreated again <em>each</em> time the outside function is called.)  

<h5>Example 5</h3>

<p>This example shows that the closure contains any local variables that were declared inside the outer function before it exited. Note that the variable `alice` is actually declared after the anonymous function. The anonymous function is declared first and when that function is called it can access the `alice` variable because `alice` is in the same scope (JavaScript does <a href="https://stackoverflow.com/a/3725763/1269037">variable hoisting</a>).
Also `sayAlice()()` just directly calls the function reference returned from `sayAlice()` &mdash; it is exactly the same as what was done previously but without the temporary variable.</p>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function sayAlice() {
    var say = function() { console.log(alice); }
    // Local variable that ends up within closure
    var alice = 'Hello Alice';
    return say;
}
sayAlice()();// logs "Hello Alice"```
</div>
</div>


Tricky: note the `say` variable is also inside the closure and could be accessed by any other function that might be declared within `sayAlice()`, or it could be accessed recursively within the inside function.  

<h5>Example 6</h3>

This one is a real gotcha for many people, so you need to understand it. Be very careful if you are defining a function within a loop: the local variables from the closure may not act as you might first think.   

You need to understand the "variable hoisting" feature in Javascript in order to understand this example.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function buildList(list) {
    var result = [];
    for (var i = 0; i < list.length; i++) {
        var item = 'item' + i;
        result.push( function() {console.log(item + ' ' + list[i])} );
    }
    return result;
}

function testList() {
    var fnlist = buildList([1,2,3]);
    // Using j only to help prevent confusion -- could use i.
    for (var j = 0; j < fnlist.length; j++) {
        fnlist[j]();
    }
}

 testList() //logs "item2 undefined" 3 times```
</div>
</div>


The line `result.push( function() {console.log(item + ' ' + list[i])}` adds a reference to an anonymous function three times to the result array. If you are not so familiar with anonymous functions think of it like:  

```javascript
pointer = function() {console.log(item + ' ' + list[i])};
result.push(pointer);
```

Note that when you run the example, `"item2 undefined"` is logged three times! This is because just like previous examples, there is only one closure for the local variables for `buildList` (which are `result`, `i`, `list` and `item`). When the anonymous functions are called on the line `fnlist[j]()`; they all use the same single closure, and they use the current value for `i` and `item` within that one closure (where `i` has a value of `3` because the loop had completed, and `item` has a value of `'item2'`). Note we are indexing from 0 hence `item` has a value of `item2`. And the i++ will increment `i` to the value `3`.  

It may be helpful to see what happens when a block-level declaration of the variable `item` is used (via the `let` keyword) instead of a function-scoped variable declaration via the `var` keyword. If that change is made, then each anonymous function in the array `result` has its own closure; when the example is run the output is as follows:  

```javascript
item0 undefined
item1 undefined
item2 undefined
```

If the variable `i` is also defined using `let` instead of `var`, then the output is:  

```javascript
item0 1
item1 2
item2 3
```

<h5>Example 7</h3>

In this final example, each call to the main function creates a separate closure.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function newClosure(someNum, someRef) {
    // Local variables that end up within closure
    var num = someNum;
    var anArray = [1,2,3];
    var ref = someRef;
    return function(x) {
        num += x;
        anArray.push(num);
        console.log('num: ' + num +
            '; anArray: ' + anArray.toString() +
            '; ref.someVar: ' + ref.someVar + ';');
      }
}
obj = {someVar: 4};
fn1 = newClosure(4, obj);
fn2 = newClosure(5, obj);
fn1(1); // num: 5; anArray: 1,2,3,5; ref.someVar: 4;
fn2(1); // num: 6; anArray: 1,2,3,6; ref.someVar: 4;
obj.someVar++;
fn1(2); // num: 7; anArray: 1,2,3,5,7; ref.someVar: 5;
fn2(2); // num: 8; anArray: 1,2,3,6,8; ref.someVar: 5;```
</div>
</div>


<h5>Summary</h2>

<p>If everything seems completely unclear, then the best thing to do is to play with the examples. Reading an explanation is much harder than understanding examples.
My explanations of closures and stack-frames, etc. are not technically correct &mdash; they are gross simplifications intended to help to understand. Once the basic idea is grokked, you can pick up the details later.</p>

<h5>Final points:</h2>

<ul>
<li>Whenever you use `function` inside another function, a closure is used.</li>
<li>Whenever you use `eval()` inside a function, a closure is used. The text you `eval` can reference local variables of the function, and within `eval` you can even create new local variables by using `eval('var foo = …')`</li>
<li>When you use `new Function(…)` (the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function" rel="noreferrer">Function constructor</a>) inside a function, it does not create a closure. (The new function cannot reference the local variables of the outer function.)</li>
<li>A closure in JavaScript is like keeping a copy of all the local variables, just as they were when a function exited.</li>
<li>It is probably best to think that a closure is always created just an entry to a function, and the local variables are added to that closure.</li>
<li>A new set of local variables is kept every time a function with a closure is called (given that the function contains a function declaration inside it, and a reference to that inside function is either returned or an external reference is kept for it in some way).</li>
<li>Two functions might look like they have the same source text, but have completely different behavior because of their 'hidden' closure. I don't think JavaScript code can actually find out if a function reference has a closure or not.</li>
<li>If you are trying to do any dynamic source code modifications (for example: `myFunction = Function(myFunction.toString().replace(/Hello/,'Hola'));`), it won't work if `myFunction` is a closure (of course, you would never even think of doing source code string substitution at runtime, but...).</li>
<li>It is possible to get function declarations within function declarations within functions… and you can get closures at more than one level.</li>
<li>I think normally a closure is a term for both the function along with the variables that are captured. Note that I do not use that definition in this article!</li>
<li>I suspect that closures in JavaScript differ from those normally found in functional languages.</li>
</ul>

<h5>Links</h2>

<ul>
<li>Douglas Crockford's simulated <a href="http://www.crockford.com/javascript/private.html" rel="noreferrer">private attributes and private methods</a> for an object, using closures.</li>
<li>A great explanation of how closures can <a href="https://www.codeproject.com/Articles/12231/Memory-Leakage-in-Internet-Explorer-revisited" rel="noreferrer">cause memory leaks in IE</a> if you are not careful.</li>
</ul>

<h5>Thanks</h2>

If you have <em>just</em> learned closures (here or elsewhere!), then I am interested in any feedback from you about any changes you might suggest that could make this article clearer. Send an email to morrisjohns.com (morris_closure @). Please note that I am not a guru on JavaScript &mdash; nor on closures.  

<hr>

Original post by Morris can be found in the <a href="http://web.archive.org/web/20080209105120/http:/blog.morrisjohns.com/javascript_closures_for_dummies" rel="noreferrer">Internet Archive</a>.  

#### Answer 2 (score 3935)
Whenever you see the function keyword within another function, the inner function has access to variables in the outer function.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function foo(x) {
  var tmp = 3;

  function bar(y) {
    console.log(x + y + (++tmp)); // will log 16
  }

  bar(10);
}

foo(2);```
</div>
</div>


This will always log 16, because `bar` can access the `x` which was defined as an argument to `foo`, and it can also access `tmp` from `foo`.  

That <strong><em>is</em></strong> a closure. A function doesn't have to <em>return</em> in order to be called a closure. <strong><em>Simply accessing variables outside of your immediate lexical scope creates a closure</em></strong>.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function foo(x) {
  var tmp = 3;

  return function (y) {
    console.log(x + y + (++tmp)); // will also log 16
  }
}

var bar = foo(2); // bar is now a closure.
bar(10);```
</div>
</div>


The above function will also log 16, because `bar` can still refer to `x` and `tmp`, even though it is no longer directly inside the scope.  

However, since `tmp` is still hanging around inside `bar`'s closure, it is also being incremented. It will be incremented each time you call `bar`.  

The simplest example of a closure is this:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
var a = 10;

function test() {
  console.log(a); // will output 10
  console.log(b); // will output 6
}
var b = 6;
test();```
</div>
</div>


When a JavaScript function is invoked, a new execution context is created. Together with the function arguments and the parent object, this execution context also receives all the variables declared outside of it (in the above example, both 'a' and 'b').  

It is possible to create more than one closure function, either by returning a list of them or by setting them to global variables. All of these will refer to the <strong>same</strong> `x` and the same `tmp`, they don't make their own copies.  

Here the number `x` is a literal number. As with other literals in JavaScript, when `foo` is called, the number `x` is <strong>copied</strong> into `foo` as its argument `x`.  

On the other hand, JavaScript always uses references when dealing with objects. If say, you called `foo` with an object, the closure it returns will <strong>reference</strong> that original object!  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function foo(x) {
  var tmp = 3;

  return function (y) {
    console.log(x + y + tmp);
    x.memb = x.memb ? x.memb + 1 : 1;
    console.log(x.memb);
  }
}

var age = new Number(2);
var bar = foo(age); // bar is now a closure referencing age.
bar(10);```
</div>
</div>


As expected, each call to `bar(10)` will increment `x.memb`. What might not be expected, is that `x` is simply referring to the same object as the `age` variable! After a couple of calls to `bar`, `age.memb` will be 2! This referencing is the basis for memory leaks with HTML objects.  

#### Answer 3 (score 2380)
FOREWORD: this answer was written when the question was:  

<blockquote>
  Like the old Albert said : "If you can't explain it to a six-year old, you really don't understand it yourself.”. Well I tried to explain JS closures to a 27 years old friend and completely failed.  
  
  Can anybody consider that I am 6 and strangely interested in that subject ?  
</blockquote>

I'm pretty sure I was one of the only people that attempted to take the initial question literally. Since then, the question has mutated several times, so my answer may now seem incredibly silly &amp; out of place. Hopefully the general idea of the story remains fun for some.  

<hr>

I'm a big fan of analogy and metaphor when explaining difficult concepts, so let me try my hand with a story.  

<strong>Once upon a time:</strong>  

There was a princess...  

```javascript
function princess() {
```

She lived in a wonderful world full of adventures. She met her Prince Charming, rode around her world on a unicorn, battled dragons, encountered talking animals, and many other fantastical things.  

```javascript
    var adventures = [];

    function princeCharming() { /* ... */ }

    var unicorn = { /* ... */ },
        dragons = [ /* ... */ ],
        squirrel = "Hello!";

    /* ... */
```

But she would always have to return back to her dull world of chores and grown-ups.  

```javascript
    return {
```

And she would often tell them of her latest amazing adventure as a princess.  

```javascript
        story: function() {
            return adventures[adventures.length - 1];
        }
    };
}
```

But all they would see is a little girl...  

```javascript
var littleGirl = princess();
```

...telling stories about magic and fantasy.  

```javascript
littleGirl.story();
```

And even though the grown-ups knew of real princesses, they would never believe in the unicorns or dragons because they could never see them. The grown-ups said that they only existed inside the little girl's imagination.  

But we know the real truth; that the little girl with the princess inside...  

...is really a princess with a little girl inside.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: JavaScript post request like a form submit (score [1368289](https://stackoverflow.com/q/133925) in 2017)

#### Question
I'm trying to direct a browser to a different page. If I wanted a GET request, I might say  

```javascript
document.location.href = 'http://example.com/q=a';
```

But the resource I'm trying to access won't respond properly unless I use a POST request. If this were not dynamically generated, I might use the HTML  

```javascript
<form action="http://example.com/" method="POST">
  <input type="hidden" name="q" value="a">
</form>
```

Then I would just submit the form from the DOM.  

But really I would like JavaScript code that allows me to say  

```javascript
post_to_url('http://example.com/', {'q':'a'});
```

What's the best cross browser implementation?  

<strong>Edit</strong>   

I'm sorry I was not clear. I need a solution that changes the location of the browser, just like submitting a form. If this is possible with <a href="http://en.wikipedia.org/wiki/XMLHttpRequest" rel="noreferrer">XMLHttpRequest</a>, it is not obvious. And this should not be asynchronous, nor use XML, so Ajax is not the answer.  

#### Answer accepted (score 2058)
<h5>Dynamically create `&lt;input&gt;`s in a form and submit it</h2>

```javascript
/**
 * sends a request to the specified url from a form. this will change the window location.
 * @param {string} path the path to send the post request to
 * @param {object} params the paramiters to add to the url
 * @param {string} [method=post] the method to use on the form
 */

function post(path, params, method='post') {

  // The rest of this code assumes you are not using a library.
  // It can be made less wordy if you use one.
  const form = document.createElement('form');
  form.method = method;
  form.action = path;

  for (const key in params) {
    if (params.hasOwnProperty(key)) {
      const hiddenField = document.createElement('input');
      hiddenField.type = 'hidden';
      hiddenField.name = key;
      hiddenField.value = params[key];

      form.appendChild(hiddenField);
    }
  }

  document.body.appendChild(form);
  form.submit();
}

```

Example:  

```javascript
post('/contact/', {name: 'Johnny Bravo'});
```

<strong>EDIT</strong>: Since this has gotten upvoted so much, I'm guessing people will be copy-pasting this a lot. So I added the `hasOwnProperty` check to fix any inadvertent bugs.  

#### Answer 2 (score 126)
This would be a version of the selected answer using <a href="http://en.wikipedia.org/wiki/JQuery">jQuery</a>.  

```javascript
// Post to the provided URL with the specified parameters.
function post(path, parameters) {
    var form = $('<form></form>');

    form.attr("method", "post");
    form.attr("action", path);

    $.each(parameters, function(key, value) {
        var field = $('<input></input>');

        field.attr("type", "hidden");
        field.attr("name", key);
        field.attr("value", value);

        form.append(field);
    });

    // The form needs to be a part of the document in
    // order for us to be able to submit it.
    $(document.body).append(form);
    form.submit();
}
```

#### Answer 3 (score 65)
A simple quick-and-dirty implementation of @Aaron answer:  

```javascript
document.body.innerHTML += '<form id="dynForm" action="http://example.com/" method="post"><input type="hidden" name="q" value="a"></form>';
document.getElementById("dynForm").submit();
```

Of course, you should rather use a JavaScript framework such as <a href="http://en.wikipedia.org/wiki/Prototype_JavaScript_Framework" rel="noreferrer">Prototype</a> or <a href="http://en.wikipedia.org/wiki/JQuery" rel="noreferrer">jQuery</a>...  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: How to change the href for a hyperlink using jQuery (score [1363581](https://stackoverflow.com/q/179713) in 2016)

#### Question
How can you change the href for a hyperlink using jQuery?  

#### Answer accepted (score 1775)
Using  

```javascript
$("a").attr("href", "http://www.google.com/")
```

will modify the href of all hyperlinks to point to Google. You probably want a somewhat more refined selector though. For instance, if you have a mix of link source (hyperlink) and link target (a.k.a. "anchor") anchor tags:  

```javascript
<a name="MyLinks"></a>
<a href="http://www.codeproject.com/">The CodeProject</a>
```

...Then you probably don't want to accidentally add `href` attributes to them. For safety then, we can specify that our selector will only match `&lt;a&gt;` tags with an existing `href` attribute:  

```javascript
$("a[href]") //...
```

Of course, you'll probably have something more interesting in mind. If you want to match an anchor with a specific existing `href`, you might use something like this:  

```javascript
$("a[href='http://www.google.com/']").attr('href', 'http://www.live.com/')
```

This will find links where the `href` exactly matches the string `http://www.google.com/`. A more involved task might be matching, then updating only part of the `href`:  

```javascript
$("a[href^='http://stackoverflow.com']")
   .each(function()
   { 
      this.href = this.href.replace(/^http:\/\/beta\.stackoverflow\.com/, 
         "http://stackoverflow.com");
   });
```

The first part selects only links where the href <em>starts</em> with `http://stackoverflow.com`. Then, a function is defined that uses a simple regular expression to replace this part of the URL with a new one. Note the flexibility this gives you - any sort of modification to the link could be done here.  

#### Answer 2 (score 277)
With jQuery 1.6 and above you should use:  

```javascript
$("a").prop("href", "http://www.jakcms.com")
```

The difference between `prop` and `attr` is that `attr` grabs the HTML attribute whereas `prop` grabs the DOM property.  

You can find more details in this post: <a href="https://stackoverflow.com/questions/5874652/prop-vs-attr">.prop() vs .attr()</a>  

#### Answer 3 (score 75)
Use the `attr` method on your lookup. You can switch out any attribute with a new value.  

```javascript
$("a.mylink").attr("href", "http://cupcream.com");
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: How can I select an element by name with jQuery? (score [1362990](https://stackoverflow.com/q/1107220) in 2018)

#### Question
Have a table column I'm trying to expand and hide:   

jQuery seems to hide the `td` elements when I select it by <a href="http://docs.jquery.com/Selectors/class#class" rel="noreferrer">class</a> but not by element's <a href="http://docs.jquery.com/Selectors/element#element" rel="noreferrer">name</a>.    

For example, why does:   

```javascript
$(".bold").hide(); // selecting by class works
$("tcol1").hide(); // select by element name does not work
```

Note the HTML below, the second column has the same name for all rows.  How could I create this collection using the `name` attribute?  

```javascript
<tr>    
    <td>data1</td>
    <td name="tcol1" class="bold"> data2</td>
</tr>
<tr>    
    <td>data1</td>
    <td name="tcol1" class="bold"> data2</td>
</tr>  
<tr>    
    <td>data1</td>
    <td name="tcol1" class="bold"> data2</td>
</tr>
```

#### Answer accepted (score 2043)
You can use the <a href="https://api.jquery.com/category/selectors/attribute-selectors/" rel="noreferrer">jQuery attribute selector</a>:  

```javascript
$('td[name ="tcol1"]')   // matches exactly 'tcol1'
$('td[name^="tcol"]' )   // matches those that begin with 'tcol'
$('td[name$="tcol"]' )   // matches those that end with 'tcol'
$('td[name*="tcol"]' )   // matches those that contain 'tcol'
```

#### Answer 2 (score 205)
<p>Any attribute can be selected using `[attribute_name=value]` way.
See the sample <a href="http://myvedham.blogspot.in/2013/09/jquery-select-by-name-and-id.html" rel="noreferrer">here</a>:</p>

```javascript
var value = $("[name='nameofobject']");
```

#### Answer 3 (score 57)
If you have something like:  

```javascript
<input type="checkbox" name="mycheckbox" value="11" checked="">
<input type="checkbox" name="mycheckbox" value="12">
```

You can read all like this:  

```javascript
jQuery("input[name='mycheckbox']").each(function() {
    console.log( this.value + ":" + this.checked );
});
```

The snippet:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
jQuery("input[name='mycheckbox']").each(function() {
  console.log( this.value + ":" + this.checked );
});```
```javascript
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<input type="checkbox" name="mycheckbox" value="11" checked="">
<input type="checkbox" name="mycheckbox" value="12">```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 84: jQuery Get Selected Option From Dropdown (score [1350883](https://stackoverflow.com/q/10659097) in 2017)

#### Question
<p>Usually I use `$("#id").val()` to return the value of the selected option, but this time it doesn't work.
The selected tag has the id `aioConceptName`</p>

<strong>html code</strong>  

```javascript
<label>Name</label>
<input type="text" name="name" />
<select id="aioConceptName">
    <option>choose io</option>
    <option>roma</option>
    <option>totti</option>
</select>
```

#### Answer accepted (score 1750)
For dropdown options you probably want something like this:  

```javascript
var conceptName = $('#aioConceptName').find(":selected").text();
```

The reason `val()` doesn't do the trick is because clicking an option doesn't change the value of the dropdown--it just adds the `:selected` property to the selected option which is a <em>child</em> of the dropdown.  

#### Answer 2 (score 326)
<strong>Set the values for each of the options</strong>  

```javascript
<select id="aioConceptName">
    <option value="0">choose io</option>
    <option value="1">roma</option>
    <option value="2">totti</option>
</select>
```

`$('#aioConceptName').val()` didn't work because `.val()` returns the `value` attribute. To have it work properly, the `value` attributes must be set on each `&lt;option&gt;`.  

Now you can call `$('#aioConceptName').val()` instead of all this `:selected` voodoo being suggested by others.  

#### Answer 3 (score 158)
I stumbled across this question and developed a more concise version of Elliot BOnneville's answer:  

```javascript
var conceptName = $('#aioConceptName :selected').text();
```

or generically:  

```javascript
$('#id :pseudoclass')
```

This saves you an extra jQuery call, selects everything in one shot, and is more clear (my opinion).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: Creating multiline strings in JavaScript (score [1336887](https://stackoverflow.com/q/805107) in 2013)

#### Question
I have the following code in Ruby. I want to convert this code into JavaScript. what's the equivalent code in JS?  

```javascript
text = <<"HERE"
This
Is
A
Multiline
String
HERE
```

#### Answer accepted (score 2958)
<h5>Update:</h3>

ECMAScript 6 (ES6) introduces a new type of literal, namely <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/template_strings" rel="noreferrer"><strong>template literals</strong></a>. They have many features, variable interpolation among others, but most importantly for this question, they can be multiline.  

A template literal is delimited by <em>backticks</em>:  

```javascript
var html = `
  <div>
    <span>Some HTML here</span>
  </div>
`;
```

(Note: I'm not advocating to use HTML in strings)  

<a href="https://kangax.github.io/compat-table/es6/#test-template_literals" rel="noreferrer">Browser support is OK</a>, but you can use <a href="https://babeljs.io/" rel="noreferrer">transpilers</a> to be more compatible.  

<hr>

<h5>Original ES5 answer:</h3>

Javascript doesn't have a here-document syntax. You can escape the literal newline, however, which comes close:  

```javascript
"foo \
bar"
```

#### Answer 2 (score 1240)
<h5>ES6 Update:</h2>

As the first answer mentions, with ES6/Babel, you can now create multi-line strings simply by using backticks:  

```javascript
const htmlString = `Say hello to 
multi-line
strings!`;
```

Interpolating variables is a popular new feature that comes with back-tick delimited strings:  

```javascript
const htmlString = `${user.name} liked your post about strings`;
```

This just transpiles down to concatenation:  

```javascript
user.name + ' liked your post about strings'
```

<h5>Original ES5 answer:</h2>

<blockquote>
  <a href="https://google.github.io/styleguide/javascriptguide.xml?showone=Multiline_string_literals#Multiline_string_literals" rel="noreferrer">Google's JavaScript style guide</a> recommends to use string concatenation instead of escaping newlines:  
  
  <strong>Do not do this:</strong>  

```javascript
var myString = 'A rather long string of English text, an error message \
                actually that just keeps going and going -- an error \
                message to make the Energizer bunny blush (right through \
                those Schwarzenegger shades)! Where was I? Oh yes, \
                you\'ve got an error and all the extraneous whitespace is \
                just gravy.  Have a nice day.';
```
  
  The whitespace at the beginning of each line can't be safely stripped at compile time; whitespace after the slash will result in tricky errors; and while most script engines support this, it is not part of ECMAScript.  
  
  <strong>Use string concatenation instead:</strong>  

```javascript
var myString = 'A rather long string of English text, an error message ' +
               'actually that just keeps going and going -- an error ' +
               'message to make the Energizer bunny blush (right through ' +
               'those Schwarzenegger shades)! Where was I? Oh yes, ' +
               'you\'ve got an error and all the extraneous whitespace is ' +
               'just gravy.  Have a nice day.';
```
</blockquote>

#### Answer 3 (score 660)
the pattern `text = &lt;&lt;"HERE" This Is A Multiline String HERE` is not available in js (I remember using it much in my good old Perl days).  

To keep oversight with complex or long multiline strings I sometimes use an array pattern:  

```javascript
var myString = 
   ['<div id="someId">',
    'some content<br />',
    '<a href="#someRef">someRefTxt</a>',
    '</div>'
   ].join('\n');
```

or the pattern anonymous already showed (escape newline), which can be an ugly block in your code:  

```javascript
    var myString = 
       '<div id="someId"> \
some content<br /> \
<a href="#someRef">someRefTxt</a> \
</div>';
```

Here's another weird but working 'trick'<sup><b>1</b></sup>:  

```javascript
var myString = (function () {/*
   <div id="someId">
     some content<br />
     <a href="#someRef">someRefTxt</a>
    </div>        
*/}).toString().match(/[^]*\/\*([^]*)\*\/\}$/)[1];
```

<em>external edit: <a href="http://jsfiddle.net/orwellophile/hna15vLw/2/" rel="noreferrer">jsfiddle</a></em>  

<strong>ES20xx</strong> supports spanning strings over multiple lines using <a href="http://www.2ality.com/2011/09/quasi-literals.html" rel="noreferrer">template strings</a>:  

```javascript
let str = `This is a text
    with multiple lines.
    Escapes are interpreted,
    \n is a newline.`;
let str = String.raw`This is a text
    with multiple lines.
    Escapes are not interpreted,
    \n is not a newline.`;
```

<sup><b>1</b></sup> Note: this will be lost after minifying/obfuscating your code  

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: Trigger a button click with JavaScript on the Enter key in a text box (score [1329593](https://stackoverflow.com/q/155188) in 2015)

#### Question
I have one text input and one button (see below). How can I use JavaScript to <strong>trigger the button's click event</strong> when the <kbd>Enter</kbd> key is pressed inside the text box?  

There is already a different submit button on my current page, so I can't simply make the button a submit button. And, I <em>only</em> want the <kbd>Enter</kbd> key to click this specific button if it is pressed from within this one text box, nothing else.  

```javascript
<input type="text" id="txtSearch" />
<input type="button" id="btnSearch" value="Search" onclick="doSomething();" />
```

#### Answer accepted (score 1390)
In jQuery, the following would work:  

```javascript
$("#id_of_textbox").keyup(function(event) {
    if (event.keyCode === 13) {
        $("#id_of_button").click();
    }
});
```

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
$("#pw").keyup(function(event) {
    if (event.keyCode === 13) {
        $("#myButton").click();
    }
});

$("#myButton").click(function() {
  alert("Button code executed.");
});```
```javascript
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

Username:<input id="username" type="text"><br>
Password:&nbsp;<input id="pw" type="password"><br>
<button id="myButton">Submit</button>```
</div>
</div>


Or in plain JavaScript, the following would work:  

```javascript
document.getElementById("id_of_textbox")
    .addEventListener("keyup", function(event) {
    event.preventDefault();
    if (event.keyCode === 13) {
        document.getElementById("id_of_button").click();
    }
});
```

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
document.getElementById("pw")
    .addEventListener("keyup", function(event) {
    event.preventDefault();
    if (event.keyCode === 13) {
        document.getElementById("myButton").click();
    }
});

function buttonCode()
{
  alert("Button code executed.");
}```
```javascript
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

Username:<input id="username" type="text"><br>
Password:&nbsp;<input id="pw" type="password"><br>
<button id="myButton" onclick="buttonCode()">Submit</button>```
</div>
</div>


#### Answer 2 (score 387)
Then just code it in!  

```javascript
<input type = "text"
       id = "txtSearch" 
       onkeydown = "if (event.keyCode == 13)
                        document.getElementById('btnSearch').click()"    
/>

<input type = "button"
       id = "btnSearch"
       value = "Search"
       onclick = "doSomething();"
/>
```

#### Answer 3 (score 176)
Figured this out:  

```javascript
<input type="text" id="txtSearch" onkeypress="return searchKeyPress(event);" />
<input type="button" id="btnSearch" Value="Search" onclick="doSomething();" />

<script>
function searchKeyPress(e)
{
    // look for window.event in case event isn't passed in
    e = e || window.event;
    if (e.keyCode == 13)
    {
        document.getElementById('btnSearch').click();
        return false;
    }
    return true;
}
</script>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: Deleting array elements in JavaScript - delete vs splice (score [1329284](https://stackoverflow.com/q/500606) in 2016)

#### Question
What is the difference between using <a href="https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Operators/delete" rel="noreferrer">the `delete` operator</a> on the array element as opposed to using <a href="https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/Array/splice" rel="noreferrer">the `Array.splice` method</a>?   

For example:  

```javascript
myArray = ['a', 'b', 'c', 'd'];

delete myArray[1];
//  or
myArray.splice (1, 1);
```

Why even have the splice method if I can delete array elements like I can with objects?  

#### Answer accepted (score 1659)
`delete` will delete the object property, but will not reindex the array or update its length. This makes it appears as if it is undefined:  

```javascript
> myArray = ['a', 'b', 'c', 'd']
  ["a", "b", "c", "d"]
> delete myArray[0]
  true
> myArray[0]
  undefined
```

Note that it is not in fact set to the value `undefined`, rather the property is removed from the array, making it <em>appear</em> undefined. The Chrome dev tools make this distinction clear by printing `empty` when logging the array.  

```javascript
> myArray[0]
  undefined
> myArray
  [empty, "b", "c", "d"]
```

<a href="https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Array/splice" rel="noreferrer">`myArray.splice(start, deleteCount)`</a> actually removes the element, reindexes the array, and changes its length.  

```javascript
> myArray = ['a', 'b', 'c', 'd']
  ["a", "b", "c", "d"]
> myArray.splice(0, 2)
  ["a", "b"]
> myArray
  ["c", "d"]
```

#### Answer 2 (score 336)
<h5>Array.remove() Method</h1>

<strong>John Resig</strong>, creator of jQuery created a very handy `Array.remove` method that I always use it in my projects.  

```javascript
// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};
```

and here's some examples of how it could be used:  

```javascript
// Remove the second item from the array
array.remove(1);
// Remove the second-to-last item from the array
array.remove(-2);
// Remove the second and third items from the array
array.remove(1,2);
// Remove the last and second-to-last items from the array
array.remove(-2,-1);
```

<a href="http://ejohn.org/blog/javascript-array-remove/" rel="noreferrer">John's website</a>  

#### Answer 3 (score 102)
Because delete only removes the object from the element in the array, the length of the array won't change. Splice removes the object and shortens the array.  

The following code will display "a", "b", "undefined", "d"  

```javascript
myArray = ['a', 'b', 'c', 'd']; delete myArray[2];

for (var count = 0; count < myArray.length; count++) {
    alert(myArray[count]);
}
```

Whereas this will display "a", "b", "d"  

```javascript
myArray = ['a', 'b', 'c', 'd']; myArray.splice(2,1);

for (var count = 0; count < myArray.length; count++) {
    alert(myArray[count]);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: Sort array of objects by string property value (score [1325247](https://stackoverflow.com/q/1129216) in 2018)

#### Question
I have an array of JavaScript objects:  

```javascript
var objs = [ 
    { first_nom: 'Lazslo', last_nom: 'Jamf'     },
    { first_nom: 'Pig',    last_nom: 'Bodine'   },
    { first_nom: 'Pirate', last_nom: 'Prentice' }
];
```

How can I sort them by the value of `last_nom` in JavaScript?  

I know about `sort(a,b)`, but that only seems to work on strings and numbers. Do I need to add a `toString()` method to my objects?  

#### Answer accepted (score 3576)
It's easy enough to write your own comparison function:  

```javascript
function compare( a, b ) {
  if ( a.last_nom < b.last_nom ){
    return -1;
  }
  if ( a.last_nom > b.last_nom ){
    return 1;
  }
  return 0;
}

objs.sort( compare );
```

Or inline (c/o Marco Demaio):   

```javascript
objs.sort((a,b) => (a.last_nom > b.last_nom) ? 1 : ((b.last_nom > a.last_nom) ? -1 : 0)); 
```

#### Answer 2 (score 793)
You can also create a dynamic sort function that sorts objects by their value that you pass:  

```javascript
function dynamicSort(property) {
    var sortOrder = 1;
    if(property[0] === "-") {
        sortOrder = -1;
        property = property.substr(1);
    }
    return function (a,b) {
        /* next line works with strings and numbers, 
         * and you may want to customize it to your needs
         */
        var result = (a[property] < b[property]) ? -1 : (a[property] > b[property]) ? 1 : 0;
        return result * sortOrder;
    }
}
```

So you can have an array of objects like this:  

```javascript
var People = [
    {Name: "Name", Surname: "Surname"},
    {Name:"AAA", Surname:"ZZZ"},
    {Name: "Name", Surname: "AAA"}
];
```

...and it will work when you do:  

```javascript
People.sort(dynamicSort("Name"));
People.sort(dynamicSort("Surname"));
People.sort(dynamicSort("-Surname"));
```

Actually this already answers the question. Below part is written because many people contacted me, complaining that <a href="https://stackoverflow.com/questions/11379361">it doesn't work with multiple parameters</a>.  

<h5>Multiple Parameters</h2>

You can use the function below to generate sort functions with multiple sort parameters.  

```javascript
function dynamicSortMultiple() {
    /*
     * save the arguments object as it will be overwritten
     * note that arguments object is an array-like object
     * consisting of the names of the properties to sort by
     */
    var props = arguments;
    return function (obj1, obj2) {
        var i = 0, result = 0, numberOfProperties = props.length;
        /* try getting a different result from 0 (equal)
         * as long as we have extra properties to compare
         */
        while(result === 0 && i < numberOfProperties) {
            result = dynamicSort(props[i])(obj1, obj2);
            i++;
        }
        return result;
    }
}
```

Which would enable you to do something like this:  

```javascript
People.sort(dynamicSortMultiple("Name", "-Surname"));
```

<h5>Subclassing Array</h3>

For the lucky among us who can use ES6, which allows extending the native objects:  

```javascript
class MyArray extends Array {
    sortBy(...args) {
        return this.sort(dynamicSortMultiple.apply(null, args));
    }
}
```

That would enable this:  

```javascript
MyArray.from(People).sortBy("Name", "-Surname");
```

#### Answer 3 (score 317)
In ES6/ES2015 or later you can do this way:  

```javascript
objs.sort((a, b) => a.last_nom.localeCompare(b.last_nom));
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: How do I return the response from an asynchronous call? (score [1313831](https://stackoverflow.com/q/14220321) in 2019)

#### Question
I have a function `foo` which makes an Ajax request. How can I return the response from `foo`?   

I tried returning the value from the `success` callback as well as assigning the response to a local variable inside the function and returning that one, but none of those ways actually return the response.  

```javascript
function foo() {
    var result;

    $.ajax({
        url: '...',
        success: function(response) {
            result = response;
            // return response; // <- I tried that one as well
        }
    });

    return result;
}

var result = foo(); // It always ends up being `undefined`.
```

#### Answer accepted (score 5413)
<blockquote>
  <em>&rarr; For a more general explanation of async behaviour with different examples, please see</em> <a href="https://stackoverflow.com/q/23667086/218196">Why is my variable unaltered after I modify it inside of a function? - Asynchronous code reference</a>    
  
  <em>&rarr; If you already understand the problem, skip to the possible solutions below.</em>  
</blockquote>

<h5>The problem</h1>

The <strong>A</strong> in <a href="https://en.wikipedia.org/wiki/Ajax_(programming)" rel="noreferrer">Ajax</a> stands for <a href="https://www.merriam-webster.com/dictionary/asynchronous" rel="noreferrer"><strong>asynchronous</strong></a> . That means sending the request (or rather receiving the response) is taken out of the normal execution flow. In your example, `$.ajax` returns immediately and the next statement, `return result;`, is executed before the function you passed as `success` callback was even called.  

Here is an analogy which hopefully makes the difference between synchronous and asynchronous flow clearer:   

<h5>Synchronous</h2>

Imagine you make a phone call to a friend and ask him to look something up for you. Although it might take a while, you wait on the phone and stare into space, until your friend gives you the answer that you needed.  

The same is happening when you make a function call containing "normal" code:  

```javascript
function findItem() {
    var item;
    while(item_not_found) {
        // search
    }
    return item;
}

var item = findItem();

// Do something with item
doSomethingElse();
```

Even though `findItem` might take a long time to execute, any code coming after `var item = findItem();` has to <em>wait</em> until the function returns the result.  

<h5>Asynchronous</h2>

You call your friend again for the same reason. But this time you tell him that you are in a hurry and he should <em>call you back</em> on your mobile phone. You hang up, leave the house and do whatever you planned to do. Once your friend calls you back, you are dealing with the information he gave to you.  

That's exactly what's happening when you do an Ajax request.   

```javascript
findItem(function(item) {
    // Do something with item
});
doSomethingElse();
```

Instead of waiting for the response, the execution continues immediately and the statement after the Ajax call is executed. To get the response eventually, you provide a function to be called once the response was received, a <em>callback</em> (notice something? <em>call back</em> ?). Any statement coming after that call is executed before the callback is called.  

<hr>

<h5>Solution(s)</h1>

<strong>Embrace the asynchronous nature of JavaScript!</strong> While certain asynchronous operations provide synchronous counterparts (so does "Ajax"), it's generally discouraged to use them, especially in a browser context.  

Why is it bad do you ask?  

JavaScript runs in the UI thread of the browser and any long running process will lock the UI, making it unresponsive. Additionally, there is an upper limit on the execution time for JavaScript and the browser will ask the user whether to continue the execution or not.   

All of this is really bad user experience. The user won't be able to tell whether everything is working fine or not. Furthermore, the effect will be worse for users with a slow connection.  

In the following we will look at three different solutions that are all building on top of each other:  

<ul>
<li><strong>Promises with `async/await`</strong> (ES2017+, available in older browsers if you use a transpiler or regenerator)</li>
<li><strong>Callbacks</strong> (popular in node)</li>
<li><strong>Promises with `then()`</strong> (ES2015+, available in older browsers if you use one of the many promise libraries)</li>
</ul>

<strong>All three are available in current browsers, and node 7+.</strong>   

<hr>

<h5>ES2017+: Promises with <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function" rel="noreferrer">`async/await`</a></h2>

The ECMAScript version released in 2017 introduced <em>syntax-level support</em> for asynchronous functions. With the help of `async` and `await`, you can write asynchronous in a "synchronous style". The code is still asynchronous, but it's easier to read/understand.  

`async/await` builds on top of promises: an `async` function always returns a promise. `await` "unwraps" a promise and either result in the value the promise was resolved with or throws an error if the promise was rejected.  

<strong>Important:</strong> You can only use `await` inside an `async` function. Right now, top-level `await` isn't yet supported, so you might have to make an async IIFE (<a href="https://en.wikipedia.org/wiki/Immediately_invoked_function_expression" rel="noreferrer">Immediately Invoked Function Expression</a>) to start an `async` context.  

You can read more about <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function" rel="noreferrer">`async`</a> and <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/await" rel="noreferrer">`await`</a> on MDN.  

Here is an example that builds on top of delay above:  

```javascript
// Using 'superagent' which will return a promise.
var superagent = require('superagent')

// This is isn't declared as `async` because it already returns a promise
function delay() {
  // `delay` returns a promise
  return new Promise(function(resolve, reject) {
    // Only `delay` is able to resolve or reject the promise
    setTimeout(function() {
      resolve(42); // After 3 seconds, resolve the promise with value 42
    }, 3000);
  });
}


async function getAllBooks() {
  try {
    // GET a list of book IDs of the current user
    var bookIDs = await superagent.get('/user/books');
    // wait for 3 seconds (just for the sake of this example)
    await delay();
    // GET information about each book
    return await superagent.get('/books/ids='+JSON.stringify(bookIDs));
  } catch(error) {
    // If any of the awaited promises was rejected, this catch block
    // would catch the rejection reason
    return null;
  }
}

// Start an IIFE to use `await` at the top level
(async function(){
  let books = await getAllBooks();
  console.log(books);
})();
```

Current <a href="https://kangax.github.io/compat-table/es2016plus/#test-async_functions" rel="noreferrer">browser</a> and <a href="http://node.green/#ES2017-features-async-functions" rel="noreferrer">node</a> versions support `async/await`. You can also support older environments by transforming your code to ES5 with the help of <a href="https://github.com/facebook/regenerator" rel="noreferrer">regenerator</a> (or tools that use regenerator, such as <a href="https://babeljs.io/" rel="noreferrer">Babel</a>).  

<hr>

<h5>Let functions accept <em>callbacks</em></h2>

A callback is simply a function passed to another function. That other function can call the function passed whenever it is ready. In the context of an asynchronous process, the callback will be called whenever the asynchronous process is done. Usually, the result is passed to the callback.  

In the example of the question, you can make `foo` accept a callback and use it as `success` callback. So this  

```javascript
var result = foo();
// Code that depends on 'result'
```

becomes  

```javascript
foo(function(result) {
    // Code that depends on 'result'
});
```

Here we defined the function "inline" but you can pass any function reference:  

```javascript
function myCallback(result) {
    // Code that depends on 'result'
}

foo(myCallback);
```

`foo` itself is defined as follows:  

```javascript
function foo(callback) {
    $.ajax({
        // ...
        success: callback
    });
}
```

`callback` will refer to the function we pass to `foo` when we call it and we simply pass it on to `success`. I.e. once the Ajax request is successful, `$.ajax` will call `callback` and pass the response to the callback (which can be referred to with `result`, since this is how we defined the callback).  

You can also process the response before passing it to the callback:  

```javascript
function foo(callback) {
    $.ajax({
        // ...
        success: function(response) {
            // For example, filter the response
            callback(filtered_response);
        }
    });
}
```

<p>It's easier to write code using callbacks than it may seem. After all, JavaScript in the browser is heavily event-driven (DOM events). Receiving the Ajax response is nothing else but an event.<br>
Difficulties could arise when you have to work with third-party code, but most problems can be solved by just thinking through the application flow.</p>

<hr>

<h5>ES2015+: Promises with <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise" rel="noreferrer">then()</a></h2>

The <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise" rel="noreferrer">Promise API</a> is a new feature of ECMAScript 6 (ES2015), but it has good <a href="http://caniuse.com/#feat=promises" rel="noreferrer" title="caniuse">browser support</a> already. There are also many libraries which implement the standard Promises API and provide additional methods to ease the use and composition of asynchronous functions (e.g. <a href="https://github.com/petkaantonov/bluebird" rel="noreferrer">bluebird</a>).  

Promises are containers for <em>future</em> values. When the promise receives the value (it is <em>resolved</em>) or when it is cancelled (<em>rejected</em>), it notifies all of its "listeners" who want to access this value.  

The advantage over plain callbacks is that they allow you to decouple your code and they are easier to compose.  

Here is a simple example of using a promise:  

```javascript
function delay() {
  // `delay` returns a promise
  return new Promise(function(resolve, reject) {
    // Only `delay` is able to resolve or reject the promise
    setTimeout(function() {
      resolve(42); // After 3 seconds, resolve the promise with value 42
    }, 3000);
  });
}

delay()
  .then(function(v) { // `delay` returns a promise
    console.log(v); // Log the value once it is resolved
  })
  .catch(function(v) {
    // Or do something else if it is rejected 
    // (it would not happen in this example, since `reject` is not called).
  });
```

Applied to our Ajax call we could use promises like this:  

```javascript
function ajax(url) {
  return new Promise(function(resolve, reject) {
    var xhr = new XMLHttpRequest();
    xhr.onload = function() {
      resolve(this.responseText);
    };
    xhr.onerror = reject;
    xhr.open('GET', url);
    xhr.send();
  });
}

ajax("/echo/json")
  .then(function(result) {
    // Code depending on result
  })
  .catch(function() {
    // An error occurred
  });
```

Describing all the advantages that promise offer is beyond the scope of this answer, but if you write new code, you should seriously consider them. They provide a great abstraction and separation of your code.  

More information about promises: <a href="http://www.html5rocks.com/en/tutorials/es6/promises/" rel="noreferrer">HTML5 rocks - JavaScript Promises</a>  

<h5>Side note: jQuery's deferred objects</h3>

<a href="https://stackoverflow.com/questions/4866721/what-are-deferred-objects">Deferred objects</a> are jQuery's custom implementation of promises (before the Promise API was standardized). They behave almost like promises but expose a slightly different API.  

Every Ajax method of jQuery already returns a "deferred object" (actually a promise of a deferred object) which you can just return from your function:  

```javascript
function ajax() {
    return $.ajax(...);
}

ajax().done(function(result) {
    // Code depending on result
}).fail(function() {
    // An error occurred
});
```

<h5>Side note: Promise gotchas</h3>

Keep in mind that promises and deferred objects are just <em>containers</em> for a future value, they are not the value itself. For example, suppose you had the following:  

```javascript
function checkPassword() {
    return $.ajax({
        url: '/password',
        data: {
            username: $('#username').val(),
            password: $('#password').val()
        },
        type: 'POST',
        dataType: 'json'
    });
}

if (checkPassword()) {
    // Tell the user they're logged in
}
```

This code misunderstands the above asynchrony issues. Specifically, `$.ajax()` doesn't freeze the code while it checks the '/password' page on your server - it sends a request to the server and while it waits, immediately returns a jQuery Ajax Deferred object, not the response from the server. That means the `if` statement is going to always get this Deferred object, treat it as `true`, and proceed as though the user is logged in. Not good.  

But the fix is easy:  

```javascript
checkPassword()
.done(function(r) {
    if (r) {
        // Tell the user they're logged in
    } else {
        // Tell the user their password was bad
    }
})
.fail(function(x) {
    // Tell the user something bad happened
});
```

<hr>

<h5>Not recommended: Synchronous "Ajax" calls</h2>

As I mentioned, some(!) asynchronous operations have synchronous counterparts. I don't advocate their use, but for completeness' sake, here is how you would perform a synchronous call:  

<h5>Without jQuery</h3>

If you directly use a <a href="http://www.w3.org/TR/XMLHttpRequest/" rel="noreferrer">`XMLHTTPRequest`</a> object, pass `false` as third argument to <a href="http://www.w3.org/TR/XMLHttpRequest/#the-open%28%29-method" rel="noreferrer">`.open`</a>.  

<h5>jQuery</h3>

<p>If you use <a href="http://api.jquery.com/jQuery.ajax/" rel="noreferrer">jQuery</a>, you can set the `async` option to `false`. Note that this option is <em>deprecated</em> since jQuery 1.8.
You can then either still use a `success` callback or access the `responseText` property of the <a href="http://api.jquery.com/jQuery.ajax/#jqXHR" rel="noreferrer">jqXHR object</a>:</p>

```javascript
function foo() {
    var jqXHR = $.ajax({
        //...
        async: false
    });
    return jqXHR.responseText;
}
```

If you use any other jQuery Ajax method, such as `$.get`, `$.getJSON`, etc., you have to change it to `$.ajax` (since you can only pass configuration parameters to `$.ajax`).  

<strong>Heads up!</strong> It is not possible to make a synchronous <a href="https://stackoverflow.com/questions/2067472/please-explain-jsonp">JSONP</a> request. JSONP by its very nature is always asynchronous (one more reason to not even consider this option).  

#### Answer 2 (score 1034)
<h5>If you're <em>not</em> using jQuery in your code, this answer is for you</h1>

Your code should be something along the lines of this:  

```javascript
function foo() {
    var httpRequest = new XMLHttpRequest();
    httpRequest.open('GET', "/echo/json");
    httpRequest.send();
    return httpRequest.responseText;
}

var result = foo(); // always ends up being 'undefined'
```

Felix Kling did a fine job writing an answer for people using jQuery for AJAX, I've decided to provide an alternative for people who aren't.  

(<a href="https://stackoverflow.com/a/30180679/1348195">Note, for those using the new `fetch` API, Angular or promises I've added another answer below</a>)  

<hr>

<h5>What you're facing</h1>

This is a short summary of "Explanation of the problem" from the other answer, if you're not sure after reading this, read that.  

The <strong>A</strong> in AJAX stands for <strong>asynchronous</strong>. That means sending the request (or rather receiving the response) is taken out of the normal execution flow. In your example, <a href="https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest#send%28%29" rel="noreferrer">`.send`</a> returns immediately and the next statement, `return result;`, is executed before the function you passed as `success` callback was even called.  

This means when you're returning, the listener you've defined did not execute yet, which means the value you're returning has not been defined.   

Here is a simple analogy  

```javascript
function getFive(){ 
    var a;
    setTimeout(function(){
         a=5;
    },10);
    return a;
}
```

<a href="http://jsfiddle.net/7RK3k/" rel="noreferrer">(Fiddle)</a>  

The value of `a` returned is `undefined` since the `a=5` part has not executed yet. AJAX acts like this, you're returning the value before the server got the chance to tell your browser what that value is.  

One possible solution to this problem is to code <em>re-actively</em> , telling your program what to do when the calculation completed.  

```javascript
function onComplete(a){ // When the code completes, do this
    alert(a);
}

function getFive(whenDone){ 
    var a;
    setTimeout(function(){
         a=5;
         whenDone(a);
    },10);
}
```

This is called <a href="http://en.wikipedia.org/wiki/Continuation-passing_style" rel="noreferrer">CPS</a>. Basically, we're passing `getFive` an action to perform when it completes, we're telling our code how to react when an event completes (like our AJAX call, or in this case the timeout).  

Usage would be:  

```javascript
getFive(onComplete);
```

Which should alert "5" to the screen. <a href="http://jsfiddle.net/PAjZR/" rel="noreferrer">(Fiddle)</a>.  

<h5>Possible solutions</h1>

There are basically two ways how to solve this:  

<ol>
<li>Make the AJAX call synchronous (lets call it SJAX).</li>
<li>Restructure your code to work properly with callbacks.</li>
</ol>

<h5>1. Synchronous AJAX - Don't do it!!</h2>

As for synchronous AJAX, <strong>don't do it!</strong> Felix's answer raises some compelling arguments about why it's a bad idea. To sum it up, it'll freeze the user's browser until the server returns the response and create a very bad user experience. Here is another short summary taken from MDN on why:  

<blockquote>
  XMLHttpRequest supports both synchronous and asynchronous communications. In general, however, asynchronous requests should be preferred to synchronous requests for performance reasons.  
  
  In short, synchronous requests block the execution of code... ...this can cause serious issues...  
</blockquote>

If you <em>have</em> to do it, you can pass a flag: <a href="https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/Synchronous_and_Asynchronous_Requests#Synchronous_request" rel="noreferrer">Here is how:</a>  

```javascript
var request = new XMLHttpRequest();
request.open('GET', 'yourURL', false);  // `false` makes the request synchronous
request.send(null);

if (request.status === 200) {// That's HTTP for 'ok'
  console.log(request.responseText);
}
```

<h5>2. Restructure code</h2>

Let your function accept a callback. In the example code `foo` can be made to accept a callback. We'll be telling our code how to <em>react</em> when `foo` completes.   

So:  

```javascript
var result = foo();
// code that depends on `result` goes here
```

Becomes:  

```javascript
foo(function(result) {
    // code that depends on `result`
});
```

Here we passed an anonymous function, but we could just as easily pass a reference to an existing function, making it look like:  

```javascript
function myHandler(result) {
    // code that depends on `result`
}
foo(myHandler);
```

For more details on how this sort of callback design is done, check Felix's answer.   

Now, let's define foo itself to act accordingly  

```javascript
function foo(callback) {
    var httpRequest = new XMLHttpRequest();
    httpRequest.onload = function(){ // when the request is loaded
       callback(httpRequest.responseText);// we're calling our method
    };
    httpRequest.open('GET', "/echo/json");
    httpRequest.send();
}
```

<a href="http://jsfiddle.net/DAcWT/" rel="noreferrer">(fiddle)</a>  

We have now made our foo function accept an action to run when the AJAX completes successfully, we can extend this further by checking if the response status is not 200 and acting accordingly (create a fail handler and such). Effectively solving our issue.  

If you're still having a hard time understanding this <a href="https://developer.mozilla.org/en-US/docs/AJAX/Getting_Started" rel="noreferrer">read the AJAX getting started guide</a> at MDN.  

#### Answer 3 (score 380)
<strong><a href="http://en.wikipedia.org/wiki/XMLHttpRequest" rel="noreferrer">XMLHttpRequest</a> 2</strong> (first of all read the answers from <a href="https://stackoverflow.com/a/16825593/19068">Benjamin Gruenbaum</a> &amp; <a href="https://stackoverflow.com/a/14220323/19068">Felix Kling</a>)  

If you don't use jQuery and want a nice short XMLHttpRequest 2 which works on the modern browsers and also on the mobile browsers I suggest to use it this way:  

```javascript
function ajax(a, b, c){ // URL, callback, just a placeholder
  c = new XMLHttpRequest;
  c.open('GET', a);
  c.onload = b;
  c.send()
}
```

As you can see:  

<ol>
<li>It's shorter than all other functions Listed.</li>
<li>The callback is set directly (so no extra unnecessary closures).</li>
<li>It uses the new onload (so you don't have to check for readystate &amp;&amp; status)</li>
<li>There are some other situations which I don't remember that make the XMLHttpRequest 1 annoying.</li>
</ol>

There are two ways to get the response of this Ajax call (three using the XMLHttpRequest var name):  

The simplest:  

```javascript
this.response
```

Or if for some reason you `bind()` the callback to a class:  

```javascript
e.target.response
```

Example:  

```javascript
function callback(e){
  console.log(this.response);
}
ajax('URL', callback);
```

Or (the above one is better anonymous functions are always a problem):  

```javascript
ajax('URL', function(e){console.log(this.response)});
```

Nothing easier.  

Now some people will probably say that it's better to use onreadystatechange or the even the XMLHttpRequest variable name. That's wrong.  

Check out <a href="http://caniuse.com/xhr2" rel="noreferrer">XMLHttpRequest advanced features</a>  

It supported all *modern browsers. And I can confirm as I'm using this approach since XMLHttpRequest 2 exists. I never had any type of problem on all browsers I use.  

onreadystatechange is only useful if you want to get the headers on state 2.  

Using the `XMLHttpRequest` variable name is another big error as you need to execute the callback inside the onload/oreadystatechange closures else you lost it.  

<hr>

Now if you want something more complex using post and FormData you can easily extend this function:  

```javascript
function x(a, b, e, d, c){ // URL, callback, method, formdata or {key:val},placeholder
  c = new XMLHttpRequest;
  c.open(e||'get', a);
  c.onload = b;
  c.send(d||null)
}
```

Again ... it's a very short function, but it does get &amp; post.  

Examples of usage:  

```javascript
x(url, callback); // By default it's get so no need to set
x(url, callback, 'post', {'key': 'val'}); // No need to set post data
```

Or pass a full form element (`document.getElementsByTagName('form')[0]`):  

```javascript
var fd = new FormData(form);
x(url, callback, 'post', fd);
```

Or set some custom values:  

```javascript
var fd = new FormData();
fd.append('key', 'val')
x(url, callback, 'post', fd);
```

As you can see I didn't implement sync... it's a bad thing.  

Having said that ... why don't do it the easy way?  

<hr>

As mentioned in the comment the use of error &amp;&amp; synchronous does completely break the point of the answer. Which is a nice short way to use Ajax in the proper way?  

<em>Error handler</em>  

```javascript
function x(a, b, e, d, c){ // URL, callback, method, formdata or {key:val}, placeholder
  c = new XMLHttpRequest;
  c.open(e||'get', a);
  c.onload = b;
  c.onerror = error;
  c.send(d||null)
}

function error(e){
  console.log('--Error--', this.type);
  console.log('this: ', this);
  console.log('Event: ', e)
}
function displayAjax(e){
  console.log(e, this);
}
x('WRONGURL', displayAjax);
```

In the above script, you have an error handler which is statically defined so it does not compromise the function. The error handler can be used for other functions too.  

But to really get out an error the <strong>only</strong> way is to write a wrong URL in which case every browser throws an error.  

Error handlers are maybe useful if you set custom headers, set the responseType to blob array buffer or whatever...  

Even if you pass 'POSTAPAPAP' as the method it won't throw an error.  

Even if you pass 'fdggdgilfdghfldj' as formdata it won't throw an error.  

In the first case the error is inside the `displayAjax()` under `this.statusText` as `Method not Allowed`.  

In the second case, it simply works. You have to check at the server side if you passed the right post data.  

cross-domain not allowed throws error automatically.  

In the error response, there are no error codes.  

There is only the `this.type` which is set to error.  

<p>Why add an error handler if you totally have no control over errors?
Most of the errors are returned inside this in the callback function `displayAjax()`.</p>

So: No need for error checks if you're able to copy and paste the URL properly. ;)  

<em>PS: As the first test I wrote x('x', displayAjax)..., and it totally got a response...??? So I checked the folder where the HTML is located, and there was a file called 'x.xml'. So even if you forget the extension of your file XMLHttpRequest 2 WILL FIND IT</em>. I LOL'd  

<hr>

<em>Read a file synchronous</em>  

<strong>Don't do that.</strong>  

If you want to block the browser for a while load a nice big `.txt` file synchronous.  

```javascript
function omg(a, c){ // URL
  c = new XMLHttpRequest;
  c.open('GET', a, true);
  c.send();
  return c; // Or c.response
}
```

Now you can do  

```javascript
 var res = omg('thisIsGonnaBlockThePage.txt');
```

There is no other way to do this in a non-asynchronous way. (Yeah, with setTimeout loop... but seriously?)  

Another point is... if you work with APIs or just your own list's files or whatever you always use different functions for each request...  

Only if you have a page where you load always the same XML/JSON or whatever you need only one function. In that case, modify a little the Ajax function and replace b with your special function.  

<hr>

The functions above are for basic use.  

If you want to EXTEND the function...  

Yes, you can.  

I'm using a lot of APIs and one of the first functions I integrate into every HTML page is the first Ajax function in this answer, with GET only...  

But you can do a lot of stuff with XMLHttpRequest 2:  

I made a download manager (using ranges on both sides with resume, filereader, filesystem), various image resizers converters using canvas, populate web SQL databases with base64images and much more... But in these cases you should create a function only for that purpose... sometimes you need a blob, array buffers, you can set headers, override mimetype and there is a lot more...  

But the question here is how to return an Ajax response... (I added an easy way.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Convert a string to an integer? (score [1303678](https://stackoverflow.com/q/1133770) in 2019)

#### Question
How do I convert a string to an integer in JavaScript?  

#### Answer accepted (score 2032)
The simplest way would be to use the native `Number` function:  

```javascript
var x = Number("1000")
```

If that doesn't work for you, then there are the <strong>parseInt</strong>, <strong>unary plus</strong>, <strong>parseFloat with floor</strong>, and <strong>Math.round</strong> methods.  

parseInt:  

```javascript
var x = parseInt("1000", 10); // you want to use radix 10
    // so you get a decimal number even with a leading 0 and an old browser ([IE8, Firefox 20, Chrome 22 and older][1])
```

<p>unary plus
if your string is already in the form of an integer:</p>

```javascript
var x = +"1000";
```

if your string is or might be a float and you want an integer:  

```javascript
var x = Math.floor("1000.01"); //floor automatically converts string to number
```

or, if you're going to be using Math.floor several times:  

```javascript
var floor = Math.floor;
var x = floor("1000.01");
```

If you're the type who forgets to put the radix in when you call parseInt, you can use parseFloat and round it however you like. Here I use floor.  

```javascript
var floor = Math.floor;
var x = floor(parseFloat("1000.01"));
```

Interestingly, Math.round (like Math.floor) will do a string to number conversion, so if you want the number rounded (or if you have an integer in the string), this is a great way, maybe my favorite:  

```javascript
var round = Math.round;
var x = round("1000"); //equivalent to round("1000",0)
```

#### Answer 2 (score 214)
Try parseInt function:  

```javascript
var number = parseInt("10");
```

But there is a problem. If you try to convert "010" using parseInt function, it detects as octal number, and will return number 8. So, you need to specify a radix (from 2 to 36). In this case base 10.  

```javascript
parseInt(string, radix)
```

Example:  

```javascript
var result = parseInt("010", 10) == 10; // Returns true

var result = parseInt("010") == 10; // Returns false
```

<p>Note that `parseInt` ignores bad data after parsing anything valid.<br>
This guid will parse as 51:</p>

```javascript
var result = parseInt('51e3daf6-b521-446a-9f5b-a1bb4d8bac36', 10) == 51; // Returns true
```

#### Answer 3 (score 120)
There are two main ways to convert a string to a number in javascript.  One way is to parse it and the other way is to change its type to a Number.  All of the tricks in the other answers (e.g. unary plus) involve implicitly coercing the type of the string to a number.  You can also do the same thing explicitly with the Number function.  

<strong>Parsing</strong>  

```javascript
var parsed = parseInt("97", 10);
```

parseInt and parseFloat are the two functions used for parsing strings to numbers.  Parsing will stop silently if it hits a character it doesn't recognise, which can be useful for parsing strings like "92px", but it's also somewhat dangerous, since it won't give you any kind of error on bad input, instead you'll get back NaN unless the string starts with a number. Whitespace at the beginning of the string is ignored.  Here's an example of it doing something different to what you want, and giving no indication that anything went wrong:  

```javascript
var widgetsSold = parseInt("97,800", 10); // widgetsSold is now 97
```

It's good practice to always specify the radix as the second argument.  In older browsers, if the string started with a 0, it would be interpreted as octal if the radix wasn't specified which took a lot of people by surprise.  The behaviour for hexadecimal is triggered by having the string start with 0x if no radix is specified, e.g. `0xff`. The standard actually changed with ecmascript 5, so modern browsers no longer trigger octal when there's a leading 0 if no radix has been specified.  parseInt understands radixes up to base 36, in which case both upper and lower case letters are treated as equivalent.  

<strong>Changing the Type of a String to a Number</strong>  

All of the other tricks mentioned above that don't use parseInt, involve implicitly coercing the string into a number.  I prefer to do this explicitly,  

```javascript
var cast = Number("97");
```

This has different behavior to the parse methods (although it still ignores whitespace).  It's more strict: if it doesn't understand the whole of the string than it returns `NaN`, so you can't use it for strings like `97px`.  Since you want a primitive number rather than a Number wrapper object, make sure you don't put `new` in front of the Number function.  

Obviously, converting to a Number gives you a value that might be a float rather than an integer, so if you want an integer, you need to modify it.  There are a few ways of doing this:  

```javascript
var rounded = Math.floor(Number("97.654"));  // other options are Math.ceil, Math.round
var fixed = Number("97.654").toFixed(0); // rounded rather than truncated
var bitwised = Number("97.654")|0;  // do not use for large numbers
```

Any bitwise operator (here I've done a bitwise or, but you could also do double negation as in an earlier answer or a bitshift) will convert the value to a 32bit integer, and most of them will convert to a signed integer.  Note that this <strong>will not do want you want for large integers</strong>.  If the integer cannot be represented in 32bits, it will wrap.    

```javascript
~~"3000000000.654" === -1294967296
// This is the same as
Number("3000000000.654")|0
"3000000000.654" >>> 0 === 3000000000 // unsigned right shift gives you an extra bit
"300000000000.654" >>> 0 === 3647256576 // but still fails with larger numbers
```

To work correctly with larger numbers, you should use the rounding methods  

```javascript
Math.floor("3000000000.654") === 3000000000
// This is the same as
Math.floor(Number("3000000000.654"))
```

Bear in mind that all of these methods understand exponential notation, so `2e2` is `200` rather than NaN.  Also, Number understands "Infinity", while the parse methods don't.  

<strong>Custom</strong>  

It's unlikely that either of these methods do exactly what you want.  For example, usually I would want an error thrown if parsing fails, and I don't need support for Infinity, exponentials or leading whitespace.  Depending on your usecase, sometimes it makes sense to write a custom conversion function.  

Always check that the output of Number or one of the parse methods is the sort of number you expect.  You will almost certainly want to use `isNaN` to make sure the number is not NaN (usually the only way you find out that the parse failed).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: Generate random number between two numbers in JavaScript (score [1293869](https://stackoverflow.com/q/4959975) in 2016)

#### Question
Is there a way to generate a random number in a specified range (e.g. from 1 to 6: 1, 2, 3, 4, 5, or 6) in JavaScript?  

#### Answer accepted (score 1949)
<h5>Important</h3>

The following code works only if the minimum value is `1`. It does not work for minimum values other than `1`.  

If you wanted to get a random integer between 1 (<strong>and only 1</strong>) and 6, you would calculate:  

```javascript
Math.floor(Math.random() * 6) + 1  
```

Where:    

<ul>
<li>1 is the start number    </li>
<li>6 is the number of possible results (1 + start <em>(6)</em> - end <em>(1)</em>)</li>
</ul>

#### Answer 2 (score 2050)
```javascript
function randomIntFromInterval(min, max) { // min and max included 
  return Math.floor(Math.random() * (max - min + 1) + min);
}
```

<p>What it does "extra" is it allows random intervals that do not start with 1.
So you can get a random number from 10 to 15 for example. Flexibility.</p>

#### Answer 3 (score 260)
<h5><a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random" rel="noreferrer">Math.random()</a></h1>

From the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random" rel="noreferrer">Mozilla</a> Developer Network documentation:  

```javascript
// Returns a random integer between min (include) and max (include)

Math.floor(Math.random() * (max - min + 1)) + min;
```

Useful examples:  

```javascript
// 0 -> 10
Math.floor(Math.random() * 11);

// 1 -> 10
Math.floor(Math.random() * 10) + 1;

// 5 -> 20
Math.floor(Math.random() * 16) + 5;

// -10 -> (-2)
Math.floor(Math.random() * 9) - 10;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: How can I upload files asynchronously? (score [1286681](https://stackoverflow.com/q/166221) in 2019)

#### Question
I would like to upload a file asynchronously with jQuery. This is my HTML:  

```javascript
<span>File</span>
<input type="file" id="file" name="file" size="10"/>
<input id="uploadbutton" type="button" value="Upload"/>
```

And here my `Jquery` code:  

```javascript
$(document).ready(function () {
    $("#uploadbutton").click(function () {
        var filename = $("#file").val();

        $.ajax({
            type: "POST",
            url: "addFile.do",
            enctype: 'multipart/form-data',
            data: {
                file: filename
            },
            success: function () {
                alert("Data Uploaded: ");
            }
        });
    });
});
```

Instead of the file being uploaded, I am only getting the filename. What can I do to fix this problem?  

<h5>Current Solution</h3>

I am using the <a href="http://malsup.com/jquery/form/#code-samples" rel="noreferrer">jQuery Form Plugin</a> to upload files.  

#### Answer 2 (score 2474)
With <a href="http://en.wikipedia.org/wiki/HTML5" rel="noreferrer">HTML5</a> you can make file uploads with Ajax and jQuery. Not only that, you can do file validations (name, size, and MIME type) or handle the progress event with the HTML5 progress tag (or a div). Recently I had to make a file uploader, but I didn't want to use <a href="http://en.wikipedia.org/wiki/Adobe_Flash" rel="noreferrer">Flash</a> nor Iframes or plugins and after some research I came up with the solution.  

The HTML:  

```javascript
<form enctype="multipart/form-data">
    <input name="file" type="file" />
    <input type="button" value="Upload" />
</form>
<progress></progress>
```

First, you can do some validation if you want. For example, in the `.on('change')` event of the file:  

```javascript
$(':file').on('change', function () {
  var file = this.files[0];

  if (file.size > 1024) {
    alert('max upload size is 1k');
  }

  // Also see .name, .type
});
```

Now the `$.ajax()` submit with the button's click:  

```javascript
$(':button').on('click', function () {
  $.ajax({
    // Your server script to process the upload
    url: 'upload.php',
    type: 'POST',

    // Form data
    data: new FormData($('form')[0]),

    // Tell jQuery not to process data or worry about content-type
    // You *must* include these options!
    cache: false,
    contentType: false,
    processData: false,

    // Custom XMLHttpRequest
    xhr: function () {
      var myXhr = $.ajaxSettings.xhr();
      if (myXhr.upload) {
        // For handling the progress of the upload
        myXhr.upload.addEventListener('progress', function (e) {
          if (e.lengthComputable) {
            $('progress').attr({
              value: e.loaded,
              max: e.total,
            });
          }
        }, false);
      }
      return myXhr;
    }
  });
});
```

As you can see, with HTML5 (and some research) file uploading not only becomes possible but super easy. Try it with <a href="http://en.wikipedia.org/wiki/Google_Chrome" rel="noreferrer">Google Chrome</a> as some of the HTML5 components of the examples aren't available in every browser.  

#### Answer 3 (score 263)
<h5>2019 Update: It <em>still</em> depends on the browsers <em>your</em> demographic uses.</h2>

An important thing to understand with the "new" HTML5 `file` API is that it <a href="http://caniuse.com/fileapi" rel="nofollow noreferrer">wasn't supported until IE 10</a>. If the specific market you're aiming at has a higher-than-average propensity toward older versions of Windows, you might not have access to it.  

As of 2017, about 5% of browsers are one of IE 6, 7, 8 or 9. If you head into a big corporation (e.g., this is a B2B tool, or something you're delivering for training) that number can skyrocket. In 2016, I dealt with a company using IE8 on over 60% of their machines.  

It's 2019 as of this edit, almost 11 years after my initial answer. IE9 and lower are <em>globally</em> around the 1% mark but there are still clusters  of higher usage.  

The important take-away from this —whatever the feature— is, <strong>check what browser <em>your</em> users use</strong>. If you don't, you'll learn a quick and painful lesson in why "works for me" isn't good enough in a deliverable to a client. <a href="https://caniuse.com/" rel="nofollow noreferrer">caniuse</a> is a useful tool but note where they get their demographics from. They may not align with yours. This is never truer than enterprise environments.  

My answer from 2008 follows.  

<hr>

However, there are viable non-JS methods of file uploads. You can create an iframe on the page (that you hide with CSS) and then target your form to post to that iframe. The main page doesn't need to move.  

It's a "real" post so it's not wholly interactive. If you need status you need something server-side to process that. This varies massively depending on your server. <a href="http://en.wikipedia.org/wiki/ASP.NET" rel="nofollow noreferrer">ASP.NET</a> has nicer mechanisms. PHP plain fails, but you can use <a href="http://en.wikipedia.org/wiki/Perl" rel="nofollow noreferrer">Perl</a> or Apache modifications to get around it.  

If you need multiple file-uploads, it's best to do each file one at a time (to overcome maximum file upload limits). Post the first form to the iframe, monitor its progress using the above and when it has finished, post the second form to the iframe, and so on.  

Or use a Java/Flash solution. They're a lot more flexible in what they can do with their posts...  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: Find object by id in an array of JavaScript objects (score [1282573](https://stackoverflow.com/q/7364150) in 2016)

#### Question
I've got an array:  

```javascript
myArray = [{'id':'73','foo':'bar'},{'id':'45','foo':'bar'}, etc.]
```

I'm unable to change the structure of the array. I'm being passed an id of `45`, and I want to get `'bar'` for that object in the array.   

How do I do this in JavaScript or using jQuery?  

#### Answer accepted (score 916)
Use the `find()` method:  

```javascript
myArray.find(x => x.id === '45').foo;
```

From <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/find" rel="noreferrer">MDN</a>:  

<blockquote>
  The `find()` method returns the first value in the array, if an element in the array satisfies the provided testing function. Otherwise `undefined` is returned.  
</blockquote>

<hr>

If you want to find its <em>index</em> instead, use `findIndex()`:  

```javascript
myArray.findIndex(x => x.id === '45');
```

From <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/findIndex" rel="noreferrer">MDN</a>:  

<blockquote>
  The `findIndex()` method returns the index of the first element in the array that satisfies the provided testing function. Otherwise -1 is returned.  
</blockquote>

<hr>

If you want to get an array of matching elements, use the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter" rel="noreferrer">`filter()`</a> method instead:  

```javascript
myArray.filter(x => x.id === '45');
```

This will return an array of objects. If you want to get an array of `foo` properties, you can do this with the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map" rel="noreferrer">`map()`</a> method:  

```javascript
myArray.filter(x => x.id === '45').map(x => x.foo);
```

<hr>

Side note: methods like `find()` or `filter()`, and <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions" rel="noreferrer">arrow functions</a> are not supported by older browsers (like IE), so if you want to support these browsers, you should transpile your code using <a href="https://babeljs.io/" rel="noreferrer">Babel</a> (with the <a href="https://babeljs.io/docs/usage/polyfill/" rel="noreferrer">polyfill</a>).  

#### Answer 2 (score 1446)
As you are already using jQuery, you can use the <a href="http://api.jquery.com/jQuery.grep/" rel="noreferrer">grep</a> function which is intended for searching an array:  

```javascript
var result = $.grep(myArray, function(e){ return e.id == id; });
```

The result is an array with the items found. If you know that the object is always there and that it only occurs once, you can just use `result[0].foo` to get the value. Otherwise you should check the length of the resulting array. Example:  

```javascript
if (result.length === 0) {
  // no result found
} else if (result.length === 1) {
  // property found, access the foo property using result[0].foo
} else {
  // multiple items found
}
```

#### Answer 3 (score 353)
Another solution is to create a lookup object:  

```javascript
var lookup = {};
for (var i = 0, len = array.length; i < len; i++) {
    lookup[array[i].id] = array[i];
}

... now you can use lookup[id]...
```

This is especially interesting if you need to do many lookups.  

This won't need much more memory since the IDs and objects will be shared.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Remove duplicate values from JS array (score [1269025](https://stackoverflow.com/q/9229645) in 2018)

#### Question
I have a very simple JavaScript array that may or may not contain duplicates.  

```javascript
var names = ["Mike","Matt","Nancy","Adam","Jenny","Nancy","Carl"];
```

I need to remove the duplicates and put the unique values in a new array.  

I could point to all the codes that I've tried but I think it's useless because they don't work. I accept jQuery solutions too.  

<h5>Similar question:</h3>

<ul>
<li><a href="https://stackoverflow.com/questions/840781">Get all non-unique values (i.e.: duplicate/more than one occurrence) in an array</a></li>
</ul>

#### Answer accepted (score 427)
Quick and dirty using jQuery:  

```javascript
var names = ["Mike","Matt","Nancy","Adam","Jenny","Nancy","Carl"];
var uniqueNames = [];
$.each(names, function(i, el){
    if($.inArray(el, uniqueNames) === -1) uniqueNames.push(el);
});
```

#### Answer 2 (score 3116)
<h5>TL;DR</h2>

Using the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set" rel="noreferrer">Set</a> constructor and the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax" rel="noreferrer">spread syntax</a>:  

```javascript
uniq = [...new Set(array)];
```

<hr>

<h5>"Smart" but naïve way</h2>

```javascript
uniqueArray = a.filter(function(item, pos) {
    return a.indexOf(item) == pos;
})
```

Basically, we iterate over the array and, for each element, check if the first position of this element in the array is equal to the current position. Obviously, these two positions are different for duplicate elements.  

Using the 3rd ("this array") parameter of the filter callback we can avoid a closure of the array variable:  

```javascript
uniqueArray = a.filter(function(item, pos, self) {
    return self.indexOf(item) == pos;
})
```

Although concise, this algorithm is not particularly efficient for large arrays (quadratic time).  

<h5>Hashtables to the rescue</h2>

```javascript
function uniq(a) {
    var seen = {};
    return a.filter(function(item) {
        return seen.hasOwnProperty(item) ? false : (seen[item] = true);
    });
}
```

This is how it's usually done. The idea is to place each element in a hashtable and then check for its presence instantly. This gives us linear time, but has at least two drawbacks:  

<ul>
<li>since hash keys can only be strings in JavaScript, this code doesn't distinguish numbers and "numeric strings". That is, `uniq([1,"1"])` will return just `[1]`</li>
<li>for the same reason, all objects will be considered equal: `uniq([{foo:1},{foo:2}])` will return just `[{foo:1}]`.</li>
</ul>

That said, if your arrays contain only primitives and you don't care about types (e.g. it's always numbers), this solution is optimal.  

<h5>The best from two worlds</h2>

A universal solution combines both approaches: it uses hash lookups for primitives and linear search for objects.  

```javascript
function uniq(a) {
    var prims = {"boolean":{}, "number":{}, "string":{}}, objs = [];

    return a.filter(function(item) {
        var type = typeof item;
        if(type in prims)
            return prims[type].hasOwnProperty(item) ? false : (prims[type][item] = true);
        else
            return objs.indexOf(item) >= 0 ? false : objs.push(item);
    });
}
```

<h5>sort | uniq</h2>

Another option is to sort the array first, and then remove each element equal to the preceding one:  

```javascript
function uniq(a) {
    return a.sort().filter(function(item, pos, ary) {
        return !pos || item != ary[pos - 1];
    })
}
```

Again, this doesn't work with objects (because all objects are equal for `sort`). Additionally, we silently change the original array as a side effect - not good! However, if your input is already sorted, this is the way to go (just remove `sort` from the above).  

<h5>Unique by...</h2>

Sometimes it's desired to uniquify a list based on some criteria other than just equality, for example, to filter out objects that are different, but share some property. This can be done elegantly by passing a callback. This "key" callback is applied to each element, and elements with equal "keys" are removed. Since `key` is expected to return a primitive, hash table will work fine here:  

```javascript
function uniqBy(a, key) {
    var seen = {};
    return a.filter(function(item) {
        var k = key(item);
        return seen.hasOwnProperty(k) ? false : (seen[k] = true);
    })
}
```

A particularly useful `key()` is `JSON.stringify` which will remove objects that are physically different, but "look" the same:  

```javascript
a = [[1,2,3], [4,5,6], [1,2,3]]
b = uniqBy(a, JSON.stringify)
console.log(b) // [[1,2,3], [4,5,6]]
```

If the `key` is not primitive, you have to resort to the linear search:  

```javascript
function uniqBy(a, key) {
    var index = [];
    return a.filter(function (item) {
        var k = key(item);
        return index.indexOf(k) >= 0 ? false : index.push(k);
    });
}
```

In ES6 you can use a `Set`:  

```javascript
function uniqBy(a, key) {
    let seen = new Set();
    return a.filter(item => {
        let k = key(item);
        return seen.has(k) ? false : seen.add(k);
    });
}
```

or a `Map`:  

```javascript
function uniqBy(a, key) {
    return [
        ...new Map(
            a.map(x => [key(x), x])
        ).values()
    ]
}
```

which both also work with non-primitive keys.  

<h5>First or last?</h2>

When removing objects by a key, you might to want to keep the first of "equal" objects or the last one.  

Use the `Set` variant above to keep the first, and the `Map` to keep the last:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function uniqByKeepFirst(a, key) {
    let seen = new Set();
    return a.filter(item => {
        let k = key(item);
        return seen.has(k) ? false : seen.add(k);
    });
}


function uniqByKeepLast(a, key) {
    return [
        ...new Map(
            a.map(x => [key(x), x])
        ).values()
    ]
}

//

data = [
    {a:1, u:1},
    {a:2, u:2},
    {a:3, u:3},
    {a:4, u:1},
    {a:5, u:2},
    {a:6, u:3},
];

console.log(uniqByKeepFirst(data, it => it.u))
console.log(uniqByKeepLast(data, it => it.u))```
</div>
</div>


<h5>Libraries</h2>

Both <a href="http://underscorejs.org/#uniq" rel="noreferrer">underscore</a> and <a href="https://lodash.com/docs#uniq" rel="noreferrer">Lo-Dash</a> provide `uniq` methods. Their algorithms are basically similar to the first snippet above and boil down to this:  

```javascript
var result = [];
a.forEach(function(item) {
     if(result.indexOf(item) < 0) {
         result.push(item);
     }
});
```

This is quadratic, but there are nice additional goodies, like wrapping native `indexOf`, ability to uniqify by a key (`iteratee` in their parlance), and optimizations for already sorted arrays.  

If you're using jQuery and can't stand anything without a dollar before it, it goes like this:  

```javascript
  $.uniqArray = function(a) {
        return $.grep(a, function(item, pos) {
            return $.inArray(item, a) === pos;
        });
  }
```

which is, again, a variation of the first snippet.  

<h5>Performance</h2>

Function calls are expensive in JavaScript, therefore the above solutions, as concise as they are, are not particularly efficient. For maximal performance, replace `filter` with a loop and get rid of other function calls:  

```javascript
function uniq_fast(a) {
    var seen = {};
    var out = [];
    var len = a.length;
    var j = 0;
    for(var i = 0; i < len; i++) {
         var item = a[i];
         if(seen[item] !== 1) {
               seen[item] = 1;
               out[j++] = item;
         }
    }
    return out;
}
```

This chunk of ugly code does the same as the snippet #3 above, <s>but an order of magnitude faster</s> (as of 2017 it's only twice as fast - JS core folks are doing a great job!)  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```javascript
function uniq(a) {
    var seen = {};
    return a.filter(function(item) {
        return seen.hasOwnProperty(item) ? false : (seen[item] = true);
    });
}

function uniq_fast(a) {
    var seen = {};
    var out = [];
    var len = a.length;
    var j = 0;
    for(var i = 0; i < len; i++) {
         var item = a[i];
         if(seen[item] !== 1) {
               seen[item] = 1;
               out[j++] = item;
         }
    }
    return out;
}

/////

var r = [0,1,2,3,4,5,6,7,8,9],
    a = [],
    LEN = 1000,
    LOOPS = 1000;

while(LEN--)
    a = a.concat(r);

var d = new Date();
for(var i = 0; i < LOOPS; i++)
    uniq(a);
document.write('<br>uniq, ms/loop: ' + (new Date() - d)/LOOPS)

var d = new Date();
for(var i = 0; i < LOOPS; i++)
    uniq_fast(a);
document.write('<br>uniq_fast, ms/loop: ' + (new Date() - d)/LOOPS)```
</div>
</div>


<h5>ES6</h2>

ES6 provides the <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set" rel="noreferrer">Set</a> object, which makes things a whole lot easier:  

```javascript
function uniq(a) {
   return Array.from(new Set(a));
}
```

or  

```javascript
let uniq = a => [...new Set(a)];
```

Note that, unlike in python, ES6 sets are iterated in insertion order, so this code preserves the order of the original array.  

However, if you need an array with unique elements, why not use sets right from the beginning?  

<h5>Generators</h2>

A "lazy", generator-based version of `uniq` can be built on the same basis:  

<ul>
<li>take the next value from the argument</li>
<li>if it's been seen already, skip it</li>
<li>otherwise, yield it and add it to the set of already seen values</li>
</ul>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function* uniqIter(a) {
    let seen = new Set();

    for (let x of a) {
        if (!seen.has(x)) {
            seen.add(x);
            yield x;
        }
    }
}

// example:

function* randomsBelow(limit) {
    while (1)
        yield Math.floor(Math.random() * limit);
}

// note that randomsBelow is endless

count = 20;
limit = 30;

for (let r of uniqIter(randomsBelow(limit))) {
    console.log(r);
    if (--count === 0)
        break
}

// exercise for the reader: what happens if we set `limit` less than `count` and why```
</div>
</div>


#### Answer 3 (score 310)
Got tired of seeing all bad examples with for-loops or jQuery. Javascript has the perfect tools for this nowadays: sort, map and reduce.   

<h5>Uniq reduce while keeping existing order</h2>

```javascript
var names = ["Mike","Matt","Nancy","Adam","Jenny","Nancy","Carl"];

var uniq = names.reduce(function(a,b){
    if (a.indexOf(b) < 0 ) a.push(b);
    return a;
  },[]);

console.log(uniq, names) // [ 'Mike', 'Matt', 'Nancy', 'Adam', 'Jenny', 'Carl' ]

// one liner
return names.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);
```

<h5>Faster uniq with sorting</h2>

There are probably faster ways but this one is pretty decent.  

```javascript
var uniq = names.slice() // slice makes copy of array before sorting it
  .sort(function(a,b){
    return a > b;
  })
  .reduce(function(a,b){
    if (a.slice(-1)[0] !== b) a.push(b); // slice(-1)[0] means last item in array without removing it (like .pop())
    return a;
  },[]); // this empty array becomes the starting value for a

// one liner
return names.slice().sort(function(a,b){return a > b}).reduce(function(a,b){if (a.slice(-1)[0] !== b) a.push(b);return a;},[]);
```

<h5>Update 2015: ES6 version:</h2>

In ES6 you have Sets and Spread which makes it very easy and performant to remove all duplicates:  

```javascript
var uniq = [ ...new Set(names) ]; // [ 'Mike', 'Matt', 'Nancy', 'Adam', 'Jenny', 'Carl' ]
```

<h5>Sort based on occurrence:</h2>

Someone asked about ordering the results based on how many unique names there are:  

```javascript
var names = ['Mike', 'Matt', 'Nancy', 'Adam', 'Jenny', 'Nancy', 'Carl']

var uniq = names
  .map((name) => {
    return {count: 1, name: name}
  })
  .reduce((a, b) => {
    a[b.name] = (a[b.name] || 0) + b.count
    return a
  }, {})

var sorted = Object.keys(uniq).sort((a, b) => uniq[a] < uniq[b])

console.log(sorted)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: How do I modify the URL without reloading the page? (score [1266619](https://stackoverflow.com/q/824349) in 2019)

#### Question
Is there a way I can modify the URL of the current page without reloading the page?  

I would like to access the portion <strong>before</strong> the # hash if possible.  

I only need to change the portion <strong>after</strong> the domain, so it's not like I'm violating cross-domain policies.  

```javascript
 window.location.href = "www.mysite.com/page2.php";  // Sadly this reloads
```

#### Answer accepted (score 1899)
This can now be done in Chrome, Safari, Firefox 4+, and Internet&nbsp;Explorer&nbsp;10pp4+!  

<p>See this question's answer for more information:
<em><a href="https://stackoverflow.com/questions/3338642/updating-address-bar-with-new-url-without-hash-or-reloading-the-page">Updating address bar with new URL without hash or reloading the page</a></em></p>

Example:  

```javascript
 function processAjaxData(response, urlPath){
     document.getElementById("content").innerHTML = response.html;
     document.title = response.pageTitle;
     window.history.pushState({"html":response.html,"pageTitle":response.pageTitle},"", urlPath);
 }
```

You can then use `window.onpopstate` to detect the back/forward button navigation:  

```javascript
window.onpopstate = function(e){
    if(e.state){
        document.getElementById("content").innerHTML = e.state.html;
        document.title = e.state.pageTitle;
    }
};
```

<hr>

For a more in-depth look at manipulating browser history, see <a href="https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Manipulating_the_browser_history" rel="noreferrer">this MDN article</a>.  

#### Answer 2 (score 512)
HTML5 introduced the <a href="https://developer.mozilla.org/en-US/docs/Web/API/History_API#The_pushState()_method" rel="noreferrer">`history.pushState()`</a> and <a href="https://developer.mozilla.org/en-US/docs/Web/API/History_API#The_replaceState()_method" rel="noreferrer">`history.replaceState()`</a> methods, which allow you to add and modify history entries, respectively.  

```javascript
window.history.pushState('page2', 'Title', '/page2.php');
```

Read more about this from <a href="https://developer.mozilla.org/en/DOM/Manipulating_the_browser_history" rel="noreferrer">here</a>  

#### Answer 3 (score 116)
You can also use HTML5 <strong>replaceState</strong> if you want to change the url but don't want to add the entry to the browser history:  

```javascript
if (window.history.replaceState) {
   //prevents browser from storing history with each change:
   window.history.replaceState(statedata, title, url);
}
```

This would 'break' the back button functionality. This may be required in some instances such as an image gallery (where you want the back button to return back to the gallery index page instead of moving back through each and every image you viewed) whilst giving each image its own unique url.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: Convert a Unix timestamp to time in JavaScript (score [1259520](https://stackoverflow.com/q/847185) in 2018)

#### Question
I am storing time in a MySQL database as a Unix timestamp and that gets sent to some JavaScript code. How would I get just the time out of it?  

For example, in HH/MM/SS format.  

#### Answer accepted (score 1549)
```javascript
// Create a new JavaScript Date object based on the timestamp
// multiplied by 1000 so that the argument is in milliseconds, not seconds.
var date = new Date(unix_timestamp*1000);
// Hours part from the timestamp
var hours = date.getHours();
// Minutes part from the timestamp
var minutes = "0" + date.getMinutes();
// Seconds part from the timestamp
var seconds = "0" + date.getSeconds();

// Will display time in 10:30:23 format
var formattedTime = hours + ':' + minutes.substr(-2) + ':' + seconds.substr(-2);
```

For more information regarding the Date object, please refer to <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date" rel="noreferrer">MDN</a> or the <a href="http://ecma-international.org/ecma-262/5.1/#sec-15.9" rel="noreferrer">ECMAScript 5 specification</a>.  

#### Answer 2 (score 274)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```javascript
function timeConverter(UNIX_timestamp){
  var a = new Date(UNIX_timestamp * 1000);
  var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  var year = a.getFullYear();
  var month = months[a.getMonth()];
  var date = a.getDate();
  var hour = a.getHours();
  var min = a.getMinutes();
  var sec = a.getSeconds();
  var time = date + ' ' + month + ' ' + year + ' ' + hour + ':' + min + ':' + sec ;
  return time;
}
console.log(timeConverter(0));```
</div>
</div>


#### Answer 3 (score 176)
JavaScript works in milliseconds, so you'll first have to convert the UNIX timestamp from seconds to milliseconds.  

```javascript
var date = new Date(UNIX_Timestamp * 1000);
// Manipulate JavaScript Date object here...
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: Retrieve the position (X,Y) of an HTML element (score [1258174](https://stackoverflow.com/q/442404) in 2013)

#### Question
I want to know how to get the X and Y position of HTML elements such as `img` and `div` in JavaScript.  

#### Answer 2 (score 1645)
The correct approach is to use <a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect" rel="noreferrer">`element.getBoundingClientRect()`</a>:  

```javascript
var rect = element.getBoundingClientRect();
console.log(rect.top, rect.right, rect.bottom, rect.left);
```

Internet Explorer has supported this since as long as you are likely to care about and it was finally standardized in <a href="http://www.w3.org/TR/cssom-view/#the-getclientrects-and-getboundingclientrect-methods" rel="noreferrer">CSSOM Views</a>. All other browsers adopted it <a href="http://www.quirksmode.org/dom/w3c_cssom.html#t21" rel="noreferrer">a long time ago</a>.  

Some browsers also return height and width properties, though this is non-standard.  If you're worried about older browser compatibility, check this answer's revisions for an optimised degrading implementation.  

The values returned by `element.getBoundingClientRect()` are relative to the viewport.  If you need it relative to another element, simply subtract one rectangle from the other:  

```javascript
var bodyRect = document.body.getBoundingClientRect(),
    elemRect = element.getBoundingClientRect(),
    offset   = elemRect.top - bodyRect.top;

alert('Element is ' + offset + ' vertical pixels from <body>');
```

#### Answer 3 (score 307)
<p>The libraries go to some lengths to get accurate offsets for an element.<br>
here's a simple function that does the job in every circumstances that I've tried.</p>

```javascript
function getOffset( el ) {
    var _x = 0;
    var _y = 0;
    while( el && !isNaN( el.offsetLeft ) && !isNaN( el.offsetTop ) ) {
        _x += el.offsetLeft - el.scrollLeft;
        _y += el.offsetTop - el.scrollTop;
        el = el.offsetParent;
    }
    return { top: _y, left: _x };
}
var x = getOffset( document.getElementById('yourElId') ).left; 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: Pure JavaScript equivalent of jQuery's $.ready() - how to call a function when the page/DOM is ready for it (score [1254609](https://stackoverflow.com/q/9899372) in 2017)

#### Question
Okay, this might just be a silly question, though I'm sure there are plenty of other people asking the same question from time to time. Me, I just want to make 100% sure about it either way. With jQuery we all know the wonderful  

```javascript
$('document').ready(function(){});
```

However, let's say I want to run a function that is written in standard JavaScript with no library backing it, and that I want to launch a function as soon as the page is ready to handle it. What's the proper way to approach this?  

I know I can do:  

```javascript
window.onload="myFunction()";
```

...or I can use the `body` tag:  

```javascript
<body onload="myFunction()">
```

...or I can even try at the bottom of the page after everything, but the end `body` or `html` tag like:  

```javascript
<script type="text/javascript">
   myFunction();
</script>
```

What is a cross-browser(old/new)-compliant method of issuing one or more functions in a manner like jQuery's `$.ready()`?  

#### Answer accepted (score 1727)
The simplest thing to do in the absence of a framework that does all the cross-browser compatibility for you is to just put a call to your code at the end of the body.  This is faster to execute than an `onload` handler because this waits only for the DOM to be ready, not for all images to load.  And, this works in every browser.  

```javascript
<!doctype html>
<html>
<head>
</head>
<body>
Your HTML here

<script>
// self executing function here
(function() {
   // your page initialization code here
   // the DOM will be available here

})();
</script>
</body>
</html>
```

<hr>

For modern browsers (anything from IE9 and newer and any version of Chrome, Firefox or Safari), if you want to be able to implement a jQuery like `$(document).ready()` method that you can call from anywhere (without worrying about where the calling script is positioned), you can just use something like this:  

```javascript
function docReady(fn) {
    // see if DOM is already available
    if (document.readyState === "complete" || document.readyState === "interactive") {
        // call on next available tick
        setTimeout(fn, 1);
    } else {
        document.addEventListener("DOMContentLoaded", fn);
    }
}    
```

Usage:  

```javascript
docReady(function() {
    // DOM is loaded and ready for manipulation here
});
```

<hr>

If you need full cross browser compatibility (including old versions of IE) and you don't want to wait for `window.onload`, then you probably should go look at how a framework like jQuery implements its `$(document).ready()` method.  It's fairly involved depending upon the capabilities of the browser.  

To give you a little idea what jQuery does (which will work wherever the script tag is placed).  

If supported, it tries the standard:  

```javascript
document.addEventListener('DOMContentLoaded', fn, false);
```

with a fallback to:  

```javascript
window.addEventListener('load', fn, false )
```

or for older versions of IE, it uses:  

```javascript
document.attachEvent("onreadystatechange", fn);
```

with a fallback to:  

```javascript
window.attachEvent("onload", fn);
```

And, there are some work-arounds in the IE code path that I don't quite follow, but it looks like it has something to do with frames.  

<hr>

Here is a full substitute for jQuery's `.ready()` written in plain javascript:  

```javascript
(function(funcName, baseObj) {
    // The public function name defaults to window.docReady
    // but you can pass in your own object and own function name and those will be used
    // if you want to put them in a different namespace
    funcName = funcName || "docReady";
    baseObj = baseObj || window;
    var readyList = [];
    var readyFired = false;
    var readyEventHandlersInstalled = false;

    // call this when the document is ready
    // this function protects itself against being called more than once
    function ready() {
        if (!readyFired) {
            // this must be set to true before we start calling callbacks
            readyFired = true;
            for (var i = 0; i < readyList.length; i++) {
                // if a callback here happens to add new ready handlers,
                // the docReady() function will see that it already fired
                // and will schedule the callback to run right after
                // this event loop finishes so all handlers will still execute
                // in order and no new ones will be added to the readyList
                // while we are processing the list
                readyList[i].fn.call(window, readyList[i].ctx);
            }
            // allow any closures held by these functions to free
            readyList = [];
        }
    }

    function readyStateChange() {
        if ( document.readyState === "complete" ) {
            ready();
        }
    }

    // This is the one public interface
    // docReady(fn, context);
    // the context argument is optional - if present, it will be passed
    // as an argument to the callback
    baseObj[funcName] = function(callback, context) {
        if (typeof callback !== "function") {
            throw new TypeError("callback for docReady(fn) must be a function");
        }
        // if ready has already fired, then just schedule the callback
        // to fire asynchronously, but right away
        if (readyFired) {
            setTimeout(function() {callback(context);}, 1);
            return;
        } else {
            // add the function and context to the list
            readyList.push({fn: callback, ctx: context});
        }
        // if document already ready to go, schedule the ready function to run
        if (document.readyState === "complete") {
            setTimeout(ready, 1);
        } else if (!readyEventHandlersInstalled) {
            // otherwise if we don't have event handlers installed, install them
            if (document.addEventListener) {
                // first choice is DOMContentLoaded event
                document.addEventListener("DOMContentLoaded", ready, false);
                // backup is window load event
                window.addEventListener("load", ready, false);
            } else {
                // must be IE
                document.attachEvent("onreadystatechange", readyStateChange);
                window.attachEvent("onload", ready);
            }
            readyEventHandlersInstalled = true;
        }
    }
})("docReady", window);
```

The latest version of the code is shared publicly on GitHub at <a href="https://github.com/jfriend00/docReady" rel="noreferrer">https://github.com/jfriend00/docReady</a>  

Usage:  

```javascript
// pass a function reference
docReady(fn);

// use an anonymous function
docReady(function() {
    // code here
});

// pass a function reference and a context
// the context will be passed to the function as the first argument
docReady(fn, context);

// use an anonymous function with a context
docReady(function(context) {
    // code here that can use the context argument that was passed to docReady
}, ctx);
```

<hr>

This has been tested in:  

```javascript
IE6 and up
Firefox 3.6 and up
Chrome 14 and up
Safari 5.1 and up
Opera 11.6 and up
Multiple iOS devices
Multiple Android devices
```

Working implementation and test bed: <a href="http://jsfiddle.net/jfriend00/YfD3C/" rel="noreferrer">http://jsfiddle.net/jfriend00/YfD3C/</a>  

<hr>

Here's a summary of how it works:  

<ol>
<li>Create an <a href="http://benalman.com/news/2010/11/immediately-invoked-function-expression/" rel="noreferrer">IIFE</a> (immediately invoked function expression) so we can have non-public state variables.</li>
<li>Declare a public function `docReady(fn, context)`</li>
<li>When `docReady(fn, context)` is called, check if the ready handler has already fired.  If so, just schedule the newly added callback to fire right after this thread of JS finishes with `setTimeout(fn, 1)`.</li>
<li>If the ready handler has not already fired, then add this new callback to the list of callbacks to be called later.</li>
<li>Check if the document is already ready.  If so, execute all ready handlers.</li>
<li>If we haven't installed event listeners yet to know when the document becomes ready, then install them now.</li>
<li>If `document.addEventListener` exists, then install event handlers using `.addEventListener()` for both `"DOMContentLoaded"` and `"load"` events.  The "load" is a backup event for safety and should not be needed.</li>
<li>If `document.addEventListener` doesn't exist, then install event handlers using `.attachEvent()` for `"onreadystatechange"` and `"onload"` events.</li>
<li>In the `onreadystatechange` event, check to see if the `document.readyState === "complete"` and if so, call a function to fire all the ready handlers.</li>
<li>In all the other event handlers, call a function to fire all the ready handlers.</li>
<li>In the function to call all the ready handlers, check a state variable to see if we've already fired.  If we have, do nothing.  If we haven't yet been called, then loop through the array of ready functions and call each one in the order they were added.  Set a flag to indicate these have all been called so they are never executed more than once.</li>
<li>Clear the function array so any closures they might be using can be freed.</li>
</ol>

Handlers registered with `docReady()` are guaranteed to be fired in the order they were registered.  

If you call `docReady(fn)` after the document is already ready, the callback will be scheduled to execute as soon as the current thread of execution completes using `setTimeout(fn, 1)`.  This allows the calling code to always assume they are async callbacks that will be called later, even if later is as soon as the current thread of JS finishes and it preserves calling order.  

#### Answer 2 (score 146)
I would like to mention some of the possible ways here together with a <strong>pure javascript trick which works across all browsers</strong>:  

```javascript
// with jQuery 
$(document).ready(function(){ /* ... */ });

// shorter jQuery version 
$(function(){ /* ... */ });

// without jQuery (doesn't work in older IEs)
document.addEventListener('DOMContentLoaded', function(){ 
    // your code goes here
}, false);

// and here's the trick (works everywhere)
function r(f){/in/.test(document.readyState)?setTimeout('r('+f+')',9):f()}
// use like
r(function(){
    alert('DOM Ready!');
});
```

The trick here, as explained by the <a href="http://www.dustindiaz.com/smallest-domready-ever" rel="noreferrer">original author</a>, is that we are checking the <strong>document.readyState</strong> property. If it contains the string `in` (as in `uninitialized` and `loading`, the first two <a href="http://www.w3schools.com/jsref/prop_doc_readystate.asp" rel="noreferrer">DOM ready states</a> out of 5) we set a timeout and check again. Otherwise, we execute the passed function.  

And here's the <a href="http://jsfiddle.net/ramswaroop/br21uzk7/" rel="noreferrer">jsFiddle</a> for the trick which <strong>works across all browsers.</strong>   

Thanks to <a href="http://tutorialzine.com/" rel="noreferrer">Tutorialzine</a> for including this in their book.  

#### Answer 3 (score 127)
If you are doing <strong>VANILLA</strong> plain <strong>JavaScript</strong> without jQuery, then you must use (Internet&nbsp;Explorer&nbsp;9 or later):  

```javascript
document.addEventListener("DOMContentLoaded", function(event) {
    // Your code to run since DOM is loaded and ready
});
```

Above is the equivalent of jQuery `.ready`:  

```javascript
$(document).ready(function() {
    console.log("Ready!");
});
```

Which ALSO could be written SHORTHAND like this, which jQuery will run after the ready even <a href="https://stackoverflow.com/q/7614574/32453">occurs</a>.  

```javascript
$(function() {
    console.log("ready!");
});
```

<strong>NOT TO BE CONFUSED with BELOW</strong> (which is not meant to be DOM ready):  

DO NOT use an <a href="https://developer.mozilla.org/en-US/docs/Glossary/IIFE" rel="noreferrer">IIFE</a> like this that is self executing:  

```javascript
 Example:

(function() {
   // Your page initialization code here  - WRONG
   // The DOM will be available here   - WRONG
})();
```

This IIFE will NOT wait for your DOM to load. (I'm even talking about latest version of Chrome browser!)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Check if element exists in jQuery (score [1244831](https://stackoverflow.com/q/4592493) in 2013)

#### Question
<p>How do I check if an element exists if the element is created by `.append()` method?
`$('elemId').length` doesn't work for me.</p>

#### Answer accepted (score 1663)
<blockquote>
  <p>`$('elemId').length` doesn't work for
  me.</p>
</blockquote>

You need to put `#` before element id:  

```javascript
$('#elemId').length
---^
```

<hr>

With vanilla JavaScript, you don't need the hash (`#`) e.g. `document.getElementById('id_here')` , however when using jQuery, you do need to put hash to target elements based on `id` just like CSS.  

#### Answer 2 (score 348)
Try to check the length of the selector, if it returns you something then the element must exists else not.  

```javascript
 if( $('#selector').length )         // use this if you are using id to check
{
     // it exists
}


 if( $('.selector').length )         // use this if you are using class to check
{
     // it exists
}
```

#### Answer 3 (score 127)
Try this:  

```javascript
if ($("#mydiv").length > 0){
  // do something here
}
```

The length property will return zero if element does not exists.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: How do I get started with Node.js (score [1227201](https://stackoverflow.com/q/2353818) in 2013)

#### Question
Are there any good resources to get started with Node.JS? Any good tutorials, blogs or books?  

Of course, I have visited its official website <a href="http://nodejs.org/" rel="noreferrer">http://nodejs.org/</a>, but I didn't think the documentation they have is a good starting point.  

#### Answer 2 (score 4549)
<strong>Tutorials</strong>  

<ul>
<li><a href="http://nodeschool.io/" rel="nofollow noreferrer">NodeSchool.io interactive lessons</a></li>
<li><a href="https://github.com/maxogden/art-of-node/#the-art-of-node" rel="nofollow noreferrer">The Art of Node (an introduction to Node.js)</a></li>
<li><a href="http://www.nodebeginner.org/#hello-world" rel="nofollow noreferrer">Hello World</a></li>
<li><a href="http://www.nodebeginner.org/#building-the-application-stack" rel="nofollow noreferrer">Hello World Web Server</a> (paid)</li>
<li><a href="http://nodeguide.com/" rel="nofollow noreferrer">Node.js guide</a></li>
<li><a href="http://howtonode.org/express-mongodb" rel="nofollow noreferrer">Build a blog with Node.js, express and MongoDB</a></li>
<li><a href="http://net.tutsplus.com/tutorials/javascript-ajax/node-js-for-beginners/" rel="nofollow noreferrer">Node.js for Beginners</a></li>
<li><a href="http://javascriptissexy.com/learn-node-js-completely-and-with-confidence/" rel="nofollow noreferrer">Learn Node.js Completely and with Confidence</a></li>
<li><a href="http://www.journaldev.com/7462/node-js-processing-model-single-threaded-model-with-event-loop-architecture" rel="nofollow noreferrer">Node JS Processing Model – Single Threaded Model with Event Loop Architecture</a></li>
<li><a href="https://blog.risingstack.com/node-hero-tutorial-getting-started-with-node-js/" rel="nofollow noreferrer">RisingStack's Node Hero Series</a></li>
<li><a href="https://hackr.io/tutorials/learn-node-js" rel="nofollow noreferrer">Great Node.js tutorials voted by the programming community</a></li>
<li><a href="http://www.nodejsrecipes.com/" rel="nofollow noreferrer">Node.js Recipes</a></li>
<li><p><a href="https://www.tutorialkart.com/nodejs/nodejs-tutorial/" rel="nofollow noreferrer">Node.js Tutorial</a></p></li>
<li><p><a href="https://www.nodejsera.com/30-days-of-node.html" rel="nofollow noreferrer">30 days of Node</a></p></li>
</ul>

<strong>Developer Sites</strong>  

<ul>
<li><a href="http://www.joyent.com/developers/node" rel="nofollow noreferrer">Joyent's developer site for node</a></li>
<li><a href="https://www.tutorialsteacher.com/nodejs/nodejs-tutorials" rel="nofollow noreferrer">Tutorials Teacher</a></li>
</ul>

<strong>Videos</strong>  

<ul>
<li><a href="http://nodetuts.com/" rel="nofollow noreferrer">Node Tuts</a> (Node.js video tutorials)</li>
<li><a href="https://vimeo.com/thenativeweb" rel="nofollow noreferrer">Einführung in Node.js (in German)</a></li>
<li><a href="http://www.youtube.com/watch?v=jo_B4LTHi3I" rel="nofollow noreferrer">Introduction to Node.js with Ryan Dahl</a></li>
<li><a href="http://www.infoq.com/presentations/nodejs" rel="nofollow noreferrer">Node.js: Asynchronous Purity Leads to Faster Development</a></li>
<li><a href="http://www.infoq.com/presentations/Parallel-Programming-with-Nodejs" rel="nofollow noreferrer">Parallel Programming with Node.js</a></li>
<li><a href="http://vimeo.com/18077379" rel="nofollow noreferrer">Server-side JavaScript with Node, Connect &amp; Express</a></li>
<li><a href="http://www.lynda.com/Nodejs-tutorials/Nodejs-First-Look/101554-2.html" rel="nofollow noreferrer">Node.js First Look</a></li>
<li><a href="http://www.youtube.com/watch?v=0_GNHWZHc-o" rel="nofollow noreferrer">Node.js with MongoDB</a></li>
<li><a href="http://www.youtube.com/watch?v=F6k8lTrAE2g" rel="nofollow noreferrer">Ryan Dahl's Google Tech Talk</a></li>
<li><a href="http://node.codeschool.com/levels/1" rel="nofollow noreferrer">Real Time Web with Node.js</a></li>
<li><a href="https://www.youtube.com/playlist?list=PL6gx4Cwl9DGBMdkKFn3HasZnnAqVjzHn_" rel="nofollow noreferrer">Node.js Tutorials for Beginners</a></li>
<li><a href="http://www.pluralsight.com/search/?searchTerm=Node.js" rel="nofollow noreferrer">Pluralsight courses (paid)</a></li>
<li><a href="https://www.google.co.in/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=1&amp;cad=rja&amp;uact=8&amp;ved=0ahUKEwj6oMvR35nTAhWFuY8KHfC-BFoQFggZMAA&amp;url=https%3A%2F%2Fwww.udemy.com%2Funderstand-nodejs%2F&amp;usg=AFQjCNF3WkS8cFyYrTgzgd5V_S1ANKkZJw&amp;sig2=rD4t8JYDPvQKjwAMzQnH7Q" rel="nofollow noreferrer">Udemy Learn and understand Nodejs (paid)</a></li>
<li><a href="https://www.youtube.com/watch?v=-u-j7uqU7sI&amp;list=PL6gx4Cwl9DGBMdkKFn3HasZnnAqVjzHn_" rel="nofollow noreferrer">The New Boston</a></li>
</ul>

<strong>Screencasts</strong>  

<ul>
<li><a href="http://learnallthenodes.com" rel="nofollow noreferrer">Learn All The Nodes</a></li>
<li><a href="http://nodetuts.com/" rel="nofollow noreferrer">Node Tuts</a></li>
<li><a href="https://vimeo.com/thenativeweb" rel="nofollow noreferrer">Einführung in Node.js (in German)</a></li>
<li><a href="http://nodecasts.net/" rel="nofollow noreferrer">NodeCasts</a></li>
</ul>

<strong>Books</strong>  

<ul>
<li><a href="http://nodebeginner.org/" rel="nofollow noreferrer">The Node Beginner Book</a></li>
<li><a href="https://github.com/tj/masteringnode" rel="nofollow noreferrer">Mastering Node.js</a></li>
<li><a href="http://chimera.labs.oreilly.com/books/1234000001808/index.html" rel="nofollow noreferrer">Up and Running with Node.js</a></li>
<li><a href="http://www.manning.com/cantelon/" rel="nofollow noreferrer">Node.js in Action</a></li>
<li><a href="https://rads.stackoverflow.com/amzn/click/com/B008Z5OEUY" rel="nofollow noreferrer" rel="nofollow noreferrer">Smashing Node.js: JavaScript Everywhere</a></li>
<li><a href="http://www.amazon.de/dp/389864829X" rel="nofollow noreferrer">Node.js &amp; Co. (in German)</a></li>
<li><a href="http://nodejsbook.io/" rel="nofollow noreferrer">Sam's Teach Yourself Node.js in 24 Hours</a></li>
<li><a href="http://jsbooks.revolunet.com/" rel="nofollow noreferrer">Most detailed list of free JavaScript Books</a></li>
<li><a href="http://book.mixu.net/node/index.html" rel="nofollow noreferrer">Mixu's Node Book</a></li>
<li><a href="http://pragprog.com/book/jwnode/node-js-the-right-way" rel="nofollow noreferrer">Node.js the Right Way: Practical, Server-Side JavaScript That Scale</a></li>
<li><a href="https://leanpub.com/webdevelopmentwithnodejs" rel="nofollow noreferrer">Beginning Web Development with Node.js</a></li>
<li><a href="http://www.packtpub.com/node-javascript-web-development/book" rel="nofollow noreferrer">Node Web Development</a></li>
<li><a href="http://node.codeschool.com/" rel="nofollow noreferrer">NodeJS for Righteous Universal Domination!</a></li>
</ul>

<strong>Courses</strong>  

<ul>
<li><a href="http://node.codeschool.com/" rel="nofollow noreferrer">Real Time Web with Node.js</a></li>
<li><a href="http://www.develop.com/training-course/nodejs-featuring-node-npm-express-mocha-mongodb-with-mongoose" rel="nofollow noreferrer">Essential Node.js from DevelopMentor</a></li>
<li><a href="https://www.freecodecamp.org/" rel="nofollow noreferrer">Freecodecamp - Learn to code for free</a></li>
</ul>

<strong>Blogs</strong>  

<ul>
<li><a href="http://blog.nodejs.org/" rel="nofollow noreferrer">The Node.js blog</a></li>
<li><a href="http://howtonode.org/" rel="nofollow noreferrer">How To Node</a></li>
<li><a href="http://dailyjs.com/" rel="nofollow noreferrer">DailyJS</a></li>
<li><a href="http://blog.nodejitsu.com/" rel="nofollow noreferrer">Nodejitsu blog</a></li>
<li><a href="http://www.wilcoxd.com/whitepapers/node_js/" rel="nofollow noreferrer">Ryan Wilcox's Whitepaper</a></li>
<li><a href="http://www.devthought.com/" rel="nofollow noreferrer">devthought</a></li>
</ul>

<strong>Podcasts</strong>  

<ul>
<li><a href="http://nodeup.com/" rel="nofollow noreferrer">NodeUp</a></li>
</ul>

<strong>JavaScript resources</strong>  

<ul>
<li><a href="https://www.youtube.com/playlist?list=PL7664379246A246CB" rel="nofollow noreferrer">Crockford's videos</a> (must see!)</li>
<li><a href="http://www.addyosmani.com/resources/essentialjsdesignpatterns/book/" rel="nofollow noreferrer">Essential JavaScript Design Patterns For Beginners</a></li>
<li><a href="http://bonsaiden.github.com/JavaScript-Garden/" rel="nofollow noreferrer">JavaScript garden</a></li>
<li><a href="http://oreilly.com/catalog/9780596806767" rel="nofollow noreferrer">JavaScript Patterns</a> book</li>
<li><a href="http://oreilly.com/catalog/9780596517748/" rel="nofollow noreferrer">JavaScript: The Good Parts</a> book</li>
<li><a href="http://eloquentjavascript.net/" rel="nofollow noreferrer">Eloquent javascript </a> book</li>
</ul>

<strong>Node.js Modules</strong>  

<ul>
<li><a href="http://npmjs.org/" rel="nofollow noreferrer">Search for registered Node.js modules</a></li>
<li><a href="https://github.com/sindresorhus/awesome-nodejs" rel="nofollow noreferrer">A curated list of awesome Node.js libraries</a></li>
<li><a href="https://github.com/joyent/node/wiki/modules" rel="nofollow noreferrer">Wiki List on GitHub/Joyent/Node.js</a> (start here last!)</li>
</ul>

<strong>Other</strong>  

<ul>
<li><a href="http://jsapp.us/" rel="nofollow noreferrer">JSApp.US - like jsfiddle, but for Node.js</a></li>
<li><a href="https://www.ebayopensource.org/index.php/VJET/NodeJS" rel="nofollow noreferrer">Node with VJET JS (for Eclipse IDE)</a></li>
<li>Production sites with published source:

<ul>
<li><a href="http://nodeknockout.com/" rel="nofollow noreferrer">Node Knockout Hackathon</a> <a href="https://github.com/nko3/website" rel="nofollow noreferrer">(source)</a></li>
<li><a href="https://www.freecodecamp.org/" rel="nofollow noreferrer">Freecodecamp - Learn to code for free</a> <a href="https://github.com/freeCodeCamp/freeCodeCamp" rel="nofollow noreferrer">(source)</a></li>
</ul></li>
<li><a href="http://coding.smashingmagazine.com/2011/09/16/useful-node-js-tools-tutorials-and-resources/" rel="nofollow noreferrer">Useful Node.js Tools, Tutorials and Resources</a></li>
<li><a href="http://runnable.com/" rel="nofollow noreferrer">Runnable.com - like jsfiddle, but for server side as well</a></li>
<li><a href="https://devcenter.heroku.com/categories/nodejs" rel="nofollow noreferrer">Getting Started with Node.js on Heroku</a></li>
<li><a href="https://blog.openshift.com/run-your-nodejs-projects-on-openshift-in-two-simple-steps/" rel="nofollow noreferrer">Getting Started with Node.js on Open-Shift</a></li>
<li><a href="http://passportjs.org/guide/" rel="nofollow noreferrer">Authentication using Passport</a></li>
</ul>

#### Answer 3 (score 1782)
<strong>First, learn the core concepts of Node.js:</strong>  

<ul>
<li><p><a href="http://blog.shinetech.com/2011/08/26/asynchronous-code-design-with-node-js/" rel="noreferrer">You'll want to understand the asynchronous coding style that Node.js encourages</a>.</p></li>
<li><p><a href="http://blog.mixu.net/2011/02/01/understanding-the-node-js-event-loop/" rel="noreferrer">Async != concurrent. Understand Node.js's event loop</a>!</p></li>
<li><p><a href="http://docs.nodejitsu.com/articles/getting-started/what-is-require" rel="noreferrer">Node.js uses CommonJS-style require() for code loading; it's probably a bit different from what you're used to</a>.</p></li>
<li><p><a href="http://nodejs.org/api/index.html" rel="noreferrer">Familiarize yourself with Node.js's standard library</a>.</p></li>
</ul>

<strong>Then, you're going to want to see what the community has to offer:</strong>  

The gold standard for Node.js package management is <a href="http://npmjs.org/" rel="noreferrer">NPM</a>.  

<ul>
<li><p><a href="http://docs.nodejitsu.com/articles/getting-started/npm/what-is-npm" rel="noreferrer">It is a command line tool for managing your project's dependencies</a>.</p></li>
<li><p><a href="http://nodejs.org/api/modules.html" rel="noreferrer">Make sure you understand how Node.js and NPM interact with your project via the node_modules folder and package.json</a>.</p></li>
<li><p><a href="http://search.npmjs.org/" rel="noreferrer">NPM is also a registry of pretty much every Node.js package out there</a></p></li>
</ul>

<strong>Finally, you're going to want to know what some of the more popular packages are for various tasks:</strong>  

<strong>Useful Tools for Every Project:</strong>  

<ul>
<li><a href="http://underscorejs.org/" rel="noreferrer">Underscore</a> contains just about every core utility method you want.</li>
<li><a href="http://lodash.com/" rel="noreferrer">Lo-Dash</a> is a clone of Underscore that aims to be faster, more customizable, and has quite a few functions that underscore doesn't have. Certain versions of it can be used as drop-in replacements of underscore.</li>
<li><a href="http://www.typescriptlang.org" rel="noreferrer">TypeScript</a> makes JavaScript considerably more bearable, while also keeping you out of trouble!</li>
<li><a href="http://jshint.com/" rel="noreferrer">JSHint</a> is a code-checking tool that'll save you loads of time finding stupid errors. Find a plugin for your text editor that will automatically run it on your code.</li>
</ul>

<strong>Unit Testing:</strong>  

<ul>
<li><a href="https://github.com/mochajs/mocha" rel="noreferrer">Mocha</a> is a popular test framework.</li>
<li><a href="http://vowsjs.org/" rel="noreferrer">Vows</a> is a fantastic take on asynchronous testing, albeit somewhat stale.</li>
<li><a href="http://visionmedia.github.com/expresso/" rel="noreferrer">Expresso</a> is a more traditional unit testing framework.</li>
<li><a href="https://github.com/caolan/nodeunit" rel="noreferrer">node-unit</a> is another relatively traditional unit testing framework.</li>
<li><a href="https://github.com/sindresorhus/ava" rel="noreferrer">AVA</a> is a new test runner with Babel built-in and runs tests concurrently.</li>
</ul>

<strong>Web Frameworks:</strong>  

<ul>
<li><a href="http://expressjs.com/" rel="noreferrer">Express.js</a> is by far the most popular framework.</li>
<li><a href="http://koajs.com/" rel="noreferrer">Koa</a> is a new web framework designed by the team behind Express.js, which aims to be a smaller, more expressive, and more robust foundation for web applications and APIs.</li>
<li><a href="https://sailsjs.org" rel="noreferrer">sails.js</a> the most popular MVC framework for Node.js, and is based on express. It is designed to emulate the familiar MVC pattern of frameworks like Ruby on Rails, but with support for the requirements of modern apps: data-driven APIs with a scalable, service-oriented architecture.</li>
<li><a href="http://www.meteor.com/" rel="noreferrer">Meteor</a> bundles together jQuery, Handlebars, Node.js, <a href="http://en.wikipedia.org/wiki/WebSocket" rel="noreferrer">WebSocket</a>, <a href="http://en.wikipedia.org/wiki/MongoDB" rel="noreferrer">MongoDB</a>, and DDP and promotes convention over configuration without being a <a href="http://en.wikipedia.org/wiki/Ruby_on_Rails" rel="noreferrer">Ruby on Rails</a> clone.</li>
<li><a href="http://towerjs.org/" rel="noreferrer">Tower</a> (<em>deprecated</em>) is an abstraction of a top of Express.js that aims to be a Ruby on Rails clone.</li>
<li><a href="http://geddyjs.org/" rel="noreferrer">Geddy</a> is another take on web frameworks.</li>
<li><a href="https://npmjs.org/package/railway" rel="noreferrer">RailwayJS</a> is a Ruby on Rails inspired MVC web framework.</li>
<li><a href="https://sleekjs.com" rel="noreferrer">Sleek.js</a> is a simple web framework, built upon Express.js.</li>
<li><a href="http://hapijs.com" rel="noreferrer">Hapi</a> is a configuration-centric framework with built-in support for input validation, caching, authentication, etc.</li>
<li><p><a href="http://www.trailsjs.io" rel="noreferrer">Trails</a> is a modern web application framework. It builds on the pedigree of <a href="http://rubyonrails.org/" rel="noreferrer">Rails</a> and <a href="https://grails.org/" rel="noreferrer">Grails</a> to accelerate development by adhering to a straightforward, convention-based, API-driven design philosophy.</p></li>
<li><p><a href="https://github.com/gnodi/danf" rel="noreferrer">Danf</a> is a full-stack OOP framework providing many features in order to produce a scalable, maintainable, testable and performant applications and allowing to code the same way on both the server (Node.js) and client (browser) sides.</p></li>
<li><p><a href="http://derbyjs.com/" rel="noreferrer">Derbyjs</a> is a reactive full-stack JavaScript framework. They are using patterns like reactive programming and isomorphic JavaScript for a long time.</p></li>
<li><p><a href="http://loopback.io/" rel="noreferrer">Loopback.io</a> is a powerful Node.js framework for creating APIs and easily connecting to backend data sources. It has an Angular.js SDK and provides SDKs for iOS and Android.</p></li>
</ul>

<strong>Web Framework Tools:</strong>  

<ul>
<li><a href="https://github.com/visionmedia/jade" rel="noreferrer">Jade</a> is the HAML/Slim of the Node.js world</li>
<li><a href="https://github.com/visionmedia/ejs" rel="noreferrer">EJS</a> is a more traditional templating language.</li>
<li>Don't forget about <a href="http://documentcloud.github.com/underscore/#template" rel="noreferrer">Underscore's template method</a>!</li>
</ul>

<strong>Networking:</strong>  

<ul>
<li><a href="http://www.senchalabs.org/connect/" rel="noreferrer">Connect</a> is the Rack or WSGI of the Node.js world.</li>
<li><a href="https://github.com/mikeal/request" rel="noreferrer">Request</a> is a very popular HTTP request library.</li>
<li><a href="https://github.com/LearnBoost/socket.io" rel="noreferrer">socket.io</a> is handy for building WebSocket servers.</li>
</ul>

<strong>Command Line Interaction:</strong>  

<ul>
<li><a href="https://www.npmjs.com/package/minimist" rel="noreferrer">minimist</a> just command line argument parsing.</li>
<li><a href="https://github.com/bcoe/yargs" rel="noreferrer">Yargs</a> is a powerful library for parsing command-line arguments.</li>
<li><a href="https://github.com/tj/commander.js" rel="noreferrer">Commander.js</a> is a complete solution for building single-use command-line applications.</li>
<li><a href="https://github.com/dthree/vorpal" rel="noreferrer">Vorpal.js</a> is a framework for building mature, immersive command-line applications.</li>
<li><a href="https://github.com/chalk/chalk" rel="noreferrer">Chalk</a> makes your CLI output pretty.</li>
</ul>

<strong>Work with streams:</strong>  

<ul>
<li><a href="https://github.com/maxogden/mississippi" rel="noreferrer">mississipi</a> everything you miss about streams.</li>
<li><a href="https://github.com/calvinmetcalf/streams-a-love-story" rel="noreferrer">https://github.com/calvinmetcalf/streams-a-love-story</a></li>
<li><a href="http://maxogden.com/node-streams.html" rel="noreferrer">http://maxogden.com/node-streams.html</a></li>
<li><a href="https://github.com/substack/stream-handbook" rel="noreferrer">https://github.com/substack/stream-handbook</a></li>
<li><a href="https://www.youtube.com/watch?v=QgEuZ52OZtU" rel="noreferrer">How streams help to raise Node.js performance</a></li>
</ul>

</section>

