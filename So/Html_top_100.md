---
title: Html <- StackOverflow top 100
category: html
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How to create an HTML button that acts like a link? (score [5631819](https://stackoverflow.com/q/2906582) in 2017)

#### Question
I would like to create an HTML button that acts like a link. So, when you click the button, it redirects to a page. I would like it to be as accessible as possible.  

I would also like it so there aren't any extra characters, or parameters in the URL.  

How can I achieve this?  

<hr>

Based on the answers posted so far, I am currently doing this:  

```html
<form method="get" action="/page2">
    <button type="submit">Continue</button>
</form>
```

but the problem with this is that in <a href="http://en.wikipedia.org/wiki/Safari_%28web_browser%29" rel="noreferrer">Safari</a> and <a href="http://en.wikipedia.org/wiki/Internet_Explorer" rel="noreferrer">Internet&nbsp;Explorer</a>, it adds a question mark character to the end of the URL. I need to find a solution that doesn't add any characters to the end of the URL.  

There are two other solutions to do this: Using JavaScript or styling a link to look like a button.  

Using JavaScript:  

```html
<button onclick="window.location.href='/page2'">Continue</button>
```

But this obviously requires JavaScript, and for that reason it is less accessible to screen readers. The point of a link is to go to another page. So trying to make a button act like a link is the wrong solution. My suggestion is that you should use a link and <a href="https://stackoverflow.com/questions/710089/how-do-i-make-an-html-link-look-like-a-button">style it to look like a button</a>.  

```html
<a href="/link/to/page2">Continue</a>
```

#### Answer accepted (score 1946)
<h5>HTML</h2>

The plain HTML way is to put it in a `&lt;form&gt;` wherein you specify the desired target URL in the `action` attribute.  

```html
<form action="http://google.com">
    <input type="submit" value="Go to Google" />
</form>
```

If necessary, set CSS `display: inline;` on the form to keep it in the flow with the surrounding text. Instead of `&lt;input type="submit"&gt;` in above example, you can also use `&lt;button type="submit"&gt;`. The only difference is that the `&lt;button&gt;` element allows children.  

You'd intuitively expect to be able to use `&lt;button href="http://google.com"&gt;` analogous with the `&lt;a&gt;` element, but unfortunately no, this attribute does not exist according to <a href="https://www.w3.org/TR/html5/forms.html#the-button-element" rel="noreferrer">HTML specification</a>.  

<h5>CSS</h2>

If CSS is allowed, simply use an `&lt;a&gt;` which you style to look like a button using among others the <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/-moz-appearance" rel="noreferrer">`appearance`</a> property (<a href="http://caniuse.com/#feat=css-appearance" rel="noreferrer">only Internet&nbsp;Explorer support is currently (July 2015) still poor</a>).  

```html
<a href="http://google.com" class="button">Go to Google</a>
```



```html
a.button {
    -webkit-appearance: button;
    -moz-appearance: button;
    appearance: button;

    text-decoration: none;
    color: initial;
}
```

Or pick one of those many CSS libraries like <a href="http://getbootstrap.com/css/#buttons" rel="noreferrer">Bootstrap</a>.  

```html
<a href="http://google.com" class="btn btn-default">Go to Google</a>
```

<h5>JavaScript</h2>

If JavaScript is allowed, set the `window.location.href`.  

```html
<input type="button" onclick="location.href='http://google.com';" value="Go to Google" />
```

#### Answer 2 (score 532)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<button onclick="location.href='http://www.example.com'" type="button">
         www.example.com</button>```
</div>
</div>


Note that the `type="button"` attribute is important, since <a href="https://www.w3.org/TR/2011/WD-html5-20110525/the-button-element.html#the-button-element" rel="nofollow noreferrer">its missing value default is the Submit Button state</a>.  

#### Answer 3 (score 429)
If it's the visual appearance of a button you're looking for in a basic HTML anchor tag then you can use the <a href="http://getbootstrap.com/" rel="noreferrer">Twitter Bootstrap</a> framework to format any of the following common HTML type links/buttons to appear as a button. Please note the visual differences between version 2, 3 or 4 of the framework:  

```html
<a class="btn" href="">Link</a>
<button class="btn" type="submit">Button</button>
<input class="btn" type="button" value="Input">
<input class="btn" type="submit" value="Submit">
```

<a href="https://getbootstrap.com/docs/4.0/components/buttons/" rel="noreferrer">Bootstrap (v4)</a> sample appearance:  

<img src="https://i.stack.imgur.com/ytswI.gif" alt="Sample output of Boostrap v4 buttons">  

<a href="https://getbootstrap.com/docs/3.3/css/#buttons" rel="noreferrer">Bootstrap (v3)</a> sample appearance:  

<img src="https://i.stack.imgur.com/pXgPr.png" alt="Sample output of Boostrap v3 buttons">  

<a href="http://getbootstrap.com/2.3.2/base-css.html#buttons" rel="noreferrer">Bootstrap (v2)</a> sample appearance:  

<img src="https://i.stack.imgur.com/bMTDv.gif" alt="Sample output of Boostrap v2 buttons">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How to check whether a checkbox is checked in jQuery? (score [3985774](https://stackoverflow.com/q/901712) in 2019)

#### Question
I need to check the `checked` property of a checkbox and perform an action based on the checked property using jQuery.  

For example, if the age checkbox is checked, then I need to show a textbox to enter age, else hide the textbox.  

But the following code returns `false` by default:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
if ($('#isAgeSelected').attr('checked'))
{
    $("#txtAge").show();
}
else
{
    $("#txtAge").hide();
}```
```html
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

```html
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

```html
if(document.getElementById('isAgeSelected').checked) {
    $("#txtAge").show();
} else {
    $("#txtAge").hide();
}
```

However, there's a much prettier way to do this, using <a href="http://api.jquery.com/toggle/" rel="noreferrer">`toggle`</a>:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
$('#isAgeSelected').click(function() {
    $("#txtAge").toggle(this.checked);
});```
```html
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<input type="checkbox" id="isAgeSelected"/>
<div id="txtAge" style="display:none">Age is something</div>```
</div>
</div>


#### Answer 3 (score 1753)
Use jQuery's <a href="http://api.jquery.com/is/" rel="noreferrer">is()</a> function:  

```html
if($("#isAgeSelected").is(':checked'))
    $("#txtAge").show();  // checked
else
    $("#txtAge").hide();  // unchecked
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How to horizontally center a <div>? (score [3829513](https://stackoverflow.com/q/114543) in 2018)

#### Question
How can I horizontally center a `&lt;div&gt;` within another `&lt;div&gt;` using CSS?   

```html
<div id="outer">  
  <div id="inner">Foo foo</div>
</div>
```



#### Answer accepted (score 4515)
You can apply this CSS to the inner `&lt;div&gt;`:  

```html
#inner {
  width: 50%;
  margin: 0 auto;
}
```

Of course, you don't have to set the `width` to `50%`. Any width less than the containing `&lt;div&gt;` will work. The `margin: 0 auto` is what does the actual centering.  

If you are targeting IE8+, it might be better to have this instead:  

```html
#inner {
  display: table;
  margin: 0 auto;
}
```

It will make the inner element center horizontally and it works without setting a specific `width`.  

Working example here:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
#inner {
  display: table;
  margin: 0 auto;
  border: 1px solid black;
}

#outer {
  border: 1px solid red;
  width:100%
}```
```html
<div id="outer">
  <div id="inner">Foo foo</div>
</div>```
</div>
</div>


#### Answer 2 (score 1202)
If you don't want to set a fixed width on the inner `div` you could do something like this:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
#outer {
  width: 100%;
  text-align: center;
}

#inner {
  display: inline-block;
}```
```html
<div id="outer">  
    <div id="inner">Foo foo</div>
</div>```
</div>
</div>


That makes the inner `div` into an inline element that can be centered with `text-align`.  

#### Answer 3 (score 362)
The best approaches are with <a href="http://www.w3schools.com/css/css3_intro.asp" rel="noreferrer">CSS 3</a>.  

<h5>Box model:</h3>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
#outer {
  width: 100%;
  /* Firefox */
  display: -moz-box;
  -moz-box-pack: center;
  -moz-box-align: center;
  /* Safari and Chrome */
  display: -webkit-box;
  -webkit-box-pack: center;
  -webkit-box-align: center;
  /* W3C */
  display: box;
  box-pack: center;
  box-align: center;
}

#inner {
  width: 50%;
}```
```html
<div id="outer">
  <div id="inner">Foo foo</div>
</div>```
</div>
</div>


According to your usability you may also use the `box-orient, box-flex, box-direction` properties.  

<strong>Flex</strong>:  

```html
#outer {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
}
```

<h5>Read more about centering the child elements</h3>

<ul>
<li><p><a href="http://www.w3.org/TR/css3-box/" rel="noreferrer">Link 2</a></p></li>
<li><p><a href="http://www.w3.org/TR/CSS2/box.html" rel="noreferrer">Link 3</a></p></li>
<li><p><a href="https://developer.mozilla.org/en-US/docs/Web/CSS/box-align" rel="noreferrer">Link 4</a></p></li>
</ul>

And <strong>this explains why the box model is the best approach</strong>:  

<ul>
<li><em><a href="https://stackoverflow.com/questions/2429819/why-is-the-w3c-box-model-considered-better">Why is the W3C box model considered better?</a></em></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: Redirect from an HTML page (score [3138547](https://stackoverflow.com/q/5411538) in 2018)

#### Question
Is it possible to set up a basic HTML page to redirect to another page on load?  

#### Answer accepted (score 2096)
Try using:  

```html
<meta http-equiv="refresh" content="0; url=http://example.com/" />
```

Note: Place it in the head section.  

Additionally for older browsers if you add a quick link in case it doesn't refresh correctly:  

`&lt;p&gt;&lt;a href="http://example.com/"&gt;Redirect&lt;/a&gt;&lt;/p&gt;`  

Will appear as   

<a href="http://example.com/" rel="noreferrer">Redirect</a>  

This will still allow you to get to where you're going with an additional click.  

#### Answer 2 (score 1079)
I would use both <em>meta</em>, and <em>JavaScript code</em> and would have a link just in case.  

```html
<!DOCTYPE HTML>
<html lang="en-US">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="refresh" content="0; url=http://example.com">
        <script type="text/javascript">
            window.location.href = "http://example.com"
        </script>
        <title>Page Redirection</title>
    </head>
    <body>
        <!-- Note: don't tell people to `click` the link, just tell them that it is a link. -->
        If you are not redirected automatically, follow this <a href='http://example.com'>link to example</a>.
    </body>
</html>
```

For completeness, I think the best way, if possible, is to use server redirects, so send a <a href="https://en.wikipedia.org/wiki/HTTP_301" rel="noreferrer">301</a> status code. This is easy to do via `.htaccess` files using <a href="http://en.wikipedia.org/wiki/Apache_HTTP_Server" rel="noreferrer">Apache</a>, or via numerous plugins using <a href="http://en.wikipedia.org/wiki/WordPress" rel="noreferrer">WordPress</a>. I am sure there are also plugins for all the major content management systems. Also, cPanel has very easy configuration for 301 redirects if you have that installed on your server.  

#### Answer 3 (score 121)
<h5>JavaScript</h3>

```html
<script type="text/javascript">
    window.location.href = "http://example.com";
</script>
```

<h5>Meta tag</h3>

```html
<meta http-equiv="refresh" content="0;url=http://example.com">
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: How do I vertically center text with CSS? (score [3100733](https://stackoverflow.com/q/8865458) in 2019)

#### Question
I have a div element which contains text, and I want to align the contents of this div vertically center.  

Here is my div style:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
#box {
  height: 170px;
  width: 270px;
  background: #000;
  font-size: 48px;
  color: #FFF;
  text-align: center;
}```
```html
<div id="box">
  Lorem ipsum dolor sit
</div>```
</div>
</div>


What is the best way to do this?  

#### Answer accepted (score 2753)
You can try this basic approach:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
div {
  height: 90px;
  line-height: 90px;
  text-align: center;
  border: 2px dashed #f69c55;
}```
```html
<div>
  Hello World!
</div>```
</div>
</div>


It only works for a single line of text though, because we set the line's height to the same height as the containing box element.  

<hr>

<h5>A more versatile approach</h2>

This is another way to align text vertically. This solution will work for a single line and multiple lines of text, but it still requires a fixed height container:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
div {
  height: 200px;
  line-height: 200px;
  text-align: center;
  border: 2px dashed #f69c55;
}
span {
  display: inline-block;
  vertical-align: middle;
  line-height: normal;
}```
```html
<div>
  <span>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Haec et tu ita posuisti, et verba vestra sunt. Non enim iam stirpis bonum quaeret, sed animalis. </span>
</div>```
</div>
</div>


The CSS just sizes the `&lt;div&gt;`, vertically center aligns the `&lt;span&gt;` by setting the `&lt;div&gt;`'s line-height equal to its height, and makes the `&lt;span&gt;` an inline-block with `vertical-align: middle`. Then it sets the line-height back to normal for the `&lt;span&gt;`, so its contents will flow naturally inside the block.  

<hr>

<h5>Simulating table display</h2>

And here is another option, which may not work on older <a href="http://caniuse.com/css-table" rel="noreferrer">browsers that don't support `display: table` and `display: table-cell`</a> (basically just Internet Explorer 7). Using CSS we simulate table behavior (since tables support vertical alignment), and the HTML is the same as the second example:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
div {
  display: table;
  height: 100px;
  width: 100%;
  text-align: center;
  border: 2px dashed #f69c55;
}
span {
  display: table-cell;
  vertical-align: middle;
}```
```html
<div>
  <span>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</span>
</div>```
</div>
</div>


<hr>

<h5>Using absolute positioning</h2>

This technique uses an absolutely positioned element setting top, bottom, left and right to 0. It is described in more detail in an article in Smashing Magazine, <em><a href="http://coding.smashingmagazine.com/2013/08/09/absolute-horizontal-vertical-centering-css/" rel="noreferrer">Absolute Horizontal And Vertical Centering In CSS</a></em>.  

#### Answer 2 (score 1196)
Another way (not mentioned here yet) is with <a href="http://www.w3.org/TR/css3-flexbox/" rel="noreferrer">Flexbox</a>.  

Just add the following code to the <strong>container</strong> element:  

```html
display: flex;
justify-content: center; /* align horizontal */
align-items: center; /* align vertical */
```

<h5><a href="http://jsfiddle.net/danield770/4rrL4/594/" rel="noreferrer">Flexbox demo 1</a></h2>

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
.box {
  height: 150px;
  width: 400px;
  background: #000;
  font-size: 24px;
  font-style: oblique;
  color: #FFF;
  text-align: center;
  padding: 0 20px;
  margin: 20px;
  display: flex;
  justify-content: center;
  /* align horizontal */
  align-items: center;
  /* align vertical */
}```
```html
<div class="box">
  Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
</div>```
</div>
</div>


Alternatively, instead of aligning the content via the <em>container</em>, flexbox can also center the a <strong>flex item</strong> with an <a href="https://www.w3.org/TR/css-flexbox-1/#auto-margins" rel="noreferrer">auto margin</a> <em>when there is only one flex-item in the flex container</em> (like the example given in the question above).  

So to center the flex item both horizontally and vertically just set it with `margin:auto`  

<h5><a href="http://jsfiddle.net/danield770/4rrL4/815/" rel="noreferrer">Flexbox Demo 2</a></h2>

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
.box {
  height: 150px;
  width: 400px;
  background: #000;
  font-size: 24px;
  font-style: oblique;
  color: #FFF;
  text-align: center;
  padding: 0 20px;
  margin: 20px;
  display: flex;
}
.box span {
  margin: auto;
}```
```html
<div class="box">
  <span>margin:auto on a flex item centers it both horizontally and vertically</span> 
</div>```
</div>
</div>


<strong>NB:</strong> All the above applies to centering items while laying them out in <strong>horizontal rows</strong>. This is also the default behavior, because by default the value for `flex-direction` is `row`. If, however flex-items need to be laid out in <strong>vertical columns</strong>, then `flex-direction: column` should be set on the container to set the main-axis as column and additionally the `justify-content` and `align-items` properties now work <em>the other way around</em> with `justify-content: center` centering vertically and  `align-items: center` centering horizontally)  

<h5><a href="http://jsfiddle.net/danield770/4rrL4/888/" rel="noreferrer">`flex-direction: column` demo</a></h2>

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
.box {
  height: 150px;
  width: 400px;
  background: #000;
  font-size: 18px;
  font-style: oblique;
  color: #FFF;
  display: flex;
  flex-direction: column;
  justify-content: center;
  /* vertically aligns items */
  align-items: center;
  /* horizontally aligns items */
}
p {
  margin: 5px;
  }```
```html
<div class="box">
  <p>
    When flex-direction is column...
  </p>
  <p>
    "justify-content: center" - vertically aligns
  </p>
  <p>
    "align-items: center" - horizontally aligns
  </p>
</div>```
</div>
</div>


A good place to start with Flexbox to see some of its features and get syntax for maximum browser support is <a href="http://the-echoplex.net/flexyboxes/" rel="noreferrer">flexyboxes</a>   

Also, browser support nowadays is very good: <a href="http://caniuse.com/#feat=flexbox" rel="noreferrer">caniuse</a>  

For cross-browser compatibility for `display: flex` and `align-items`, you can use the following:  

```html
display: -webkit-box;
display: -webkit-flex;
display: -moz-box;
display: -ms-flexbox;
display: flex;
-webkit-flex-align: center;
-ms-flex-align: center;
-webkit-align-items: center;
align-items: center;
```

#### Answer 3 (score 130)
You can easily do this by adding the following piece of CSS code:  

```html
display: table-cell;
vertical-align: middle;
```

That means your CSS finally looks like:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
#box {
  height: 90px;
  width: 270px;
  background: #000;
  font-size: 48px;
  font-style: oblique;
  color: #FFF;
  text-align: center;
  margin-top: 20px;
  margin-left: 5px;
  display: table-cell;
  vertical-align: middle;
}```
```html
<div id="box">
  Some text
</div>```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 6: Tab space instead of multiple non-breaking spaces ("nbsp")? (score [2916780](https://stackoverflow.com/q/1571648) in 2017)

#### Question
Is it possible to insert a tab character in HTML instead of having to type `&amp;nbsp;` four times?  

#### Answer accepted (score 567)
It's much cleaner to use CSS. Try `padding-left:5em` or `margin-left:5em` as appropriate instead.  

#### Answer 2 (score 1250)
It depends on which character set you want to use.   

There's no tab entity defined in ISO-8859-1 HTML - but there are a couple of whitespace characters other than `&amp;nbsp;` such as `&amp;thinsp;`, `&amp;ensp;`,and `&amp;emsp;`.  

In ASCII, `&amp;#09;` is a tab.  

<a href="http://dev.w3.org/html5/html-author/charref" rel="noreferrer">Here</a> is a complete listing of HTML entities and <a href="http://en.wikipedia.org/wiki/Space_%28punctuation%29#Spaces_in_Unicode" rel="noreferrer">a useful discussion of whitespace on Wikipedia</a>.  

#### Answer 3 (score 230)
No, <a href="https://wikipedia.org/wiki/Tab_key#Tab_characters" rel="noreferrer">Tab</a> is just <a href="https://wikipedia.org/wiki/Whitespace_character" rel="noreferrer">whitespace</a> as far as HTML is concerned. I'd recommend an <a href="https://wiktionary.org/wiki/em_space" rel="noreferrer"><strong>em-space</strong></a> instead which is this big (→|&emsp;|←) ...<a href="http://jkorpela.fi/chars/spaces.html#adj" rel="noreferrer">typically</a> <strong>4 spaces wide</strong> — and is input as <strong>`&amp;emsp;`</strong>.   

You might even be able to get away with using the Unicode <a href="https://codepoints.net/U+2003" rel="noreferrer">character</a> ("` `") for it, if you're lucky.  

<ul>
<li>Here is a list of <a href="http://jkorpela.fi/chars/spaces.html" rel="noreferrer"><strong>Space characters and “zero-width spaces” in Unicode</strong></a>.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: RegEx match open tags except XHTML self-contained tags (score [2669567](https://stackoverflow.com/q/1732348) in 2012)

#### Question
I need to match all of these opening tags:  

```html
<p>
<a href="foo">
```

But not these:  

```html
<br />
<hr class="foo" />
```

I came up with this and wanted to make sure I've got it right. I am only capturing the `a-z`.  

```html
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

### 8: How to change an element's class with JavaScript? (score [2446526](https://stackoverflow.com/q/195951) in 2019)

#### Question
How can I change a class of an HTML element in response to an `onclick` event using JavaScript?  

#### Answer accepted (score 3702)
<h5>Modern HTML5 Techniques for changing classes</h2>

Modern browsers have added <a href="https://developer.mozilla.org/en-US/docs/DOM/element.classList" rel="noreferrer"><strong>classList</strong></a> which provides methods to make it easier to manipulate classes without needing a library:  

```html
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

```html
document.getElementById("MyElement").className = "MyClass";
```

(You can use a space-delimited list to apply multiple classes.)  

<h5>To add an additional class to an element:</h3>

To add a class to an element, without removing/affecting existing values, append a space and the new classname, like so:  

```html
document.getElementById("MyElement").className += " MyClass";
```

<h5>To remove a class from an element:</h3>

To remove a single class to an element, without affecting other potential classes, a simple regex replace is required:  

```html
document.getElementById("MyElement").className =
   document.getElementById("MyElement").className.replace
      ( /(?:^|\s)MyClass(?!\S)/g , '' )
/* Code wrapped for readability - above is all one statement */
```

An explanation of this regex is as follows:  

```html
(?:^|\s) # Match the start of the string, or any single whitespace character

MyClass  # The literal text for the classname to remove

(?!\S)   # Negative lookahead to verify the above is the whole classname
         # Ensures there is no non-space character following
         # (i.e. must be end of string or a space)
```

The `g` flag tells the replace to repeat as required, in case the class name has been added multiple times.  

<h5>To check if a class is already applied to an element:</h3>

The same regex used above for removing a class can also be used as a check as to whether a particular class exists:  

```html
if ( document.getElementById("MyElement").className.match(/(?:^|\s)MyClass(?!\S)/) )
```

<br/>  

<h5>Assigning these actions to onclick events:</h3>

Whilst it is possible to write JavaScript directly inside the HTML event attributes (such as `onclick="this.className+=' MyClass'"`) this is not recommended behaviour. Especially on larger applications, more maintainable code is achieved by separating HTML markup from JavaScript interaction logic.  

The first step to achieving this is by creating a function, and calling the function in the onclick attribute, for example:  

```html
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

```html
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

```html
$('#MyElement').addClass('MyClass');

$('#MyElement').removeClass('MyClass');

if ( $('#MyElement').hasClass('MyClass') )
```

In addition, jQuery provides a shortcut for adding a class if it doesn't apply, or removing a class that does:  

```html
$('#MyElement').toggleClass('MyClass');
```

<br/>  

<h5>Assigning a function to a click event with jQuery:</h3>

```html
$('#MyElement').click(changeClass);
```

or, without needing an id:  

```html
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

```html
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

```html
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

### 9: How to align a <div> to the middle (horizontally/width) of the page (score [2419195](https://stackoverflow.com/q/953918) in 2019)

#### Question
I have a `div` tag with `width` set to <strong>800 pixels</strong>. When the browser width is greater than <strong>800 pixels</strong>, it shouldn't stretch the `div`, but it should bring it to the middle of the page.  

#### Answer accepted (score 1059)
```html
<body>
    <div style="width:800px; margin:0 auto;">
        centered content
    </div>
</body>
```

#### Answer 2 (score 312)
`position: absolute` and then `top:50%` and `left:50%` places the top edge at the vertical center of the screen, and the left edge at the horizontal center, then by adding `margin-top` to the negative of the height of the div, i.e., -100 shifts it above by 100 and similarly for `margin-left`. This gets the `div` exactly in the center of the page.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
#outPopUp {
  position: absolute;
  width: 300px;
  height: 200px;
  z-index: 15;
  top: 50%;
  left: 50%;
  margin: -100px 0 0 -150px;
  background: red;
}```
```html
<div id="outPopUp"></div>```
</div>
</div>


#### Answer 3 (score 82)
Modern <a href="http://caniuse.com/#search=flexbox" rel="noreferrer"><strong>Flexbox</strong></a> solution is the way to go in/from 2015. <a href="https://css-tricks.com/almanac/properties/j/justify-content/" rel="noreferrer">`justify-content: center`</a> is used for the parent element to align the content to the center of it.  

<strong>HTML</strong>  

```html
<div class="container">
  <div class="center">Center</div>
</div>
```

<strong>CSS</strong>  

```html
.container {
  display: flex;
  justify-content: center;
}
.center {
  width: 800px;
}
```

<strong>Output</strong>  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
.container {
  display: flex;
  justify-content: center;
}
.center {
  width: 800px;
  background: #5F85DB;
  color: #fff;
  font-weight: bold;
  font-family: Tahoma;
}```
```html
<div class="container">
  <div class="center">Centered div with left aligned text.</div>
</div>```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 10: How can I set the default value for an HTML <select> element? (score [2313733](https://stackoverflow.com/q/3518002) in 2019)

#### Question
I thought that adding a `"value"` attribute set on the `&lt;select&gt;` element below would cause the `&lt;option&gt;` containing my provided `"value"` to be selected by default:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<select name="hall" id="hall" value="3">
  <option>1</option>
  <option>2</option>
  <option>3</option>
  <option>4</option>
  <option>5</option>
</select>```
</div>
</div>


However, this did not work as I had expected. How can I set which `&lt;option&gt;` element is selected by default?  

#### Answer accepted (score 1992)
Set `selected="selected"` for the option you want to be the default.  

```html
<option selected="selected">
3
</option>
```

#### Answer 2 (score 517)
In case you want to have a default text as a sort of placeholder/hint but not considered a valid value (something like "complete here", "select your nation" ecc.) you can do something like this:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<select>
  <option value="" selected disabled hidden>Choose here</option>
  <option value="1">One</option>
  <option value="2">Two</option>
  <option value="3">Three</option>
  <option value="4">Four</option>
  <option value="5">Five</option>
</select>```
</div>
</div>


#### Answer 3 (score 223)
Complete example:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<select name="hall" id="hall"> 
  <option> 
    1 
  </option> 
  <option> 
    2 
  </option> 
  <option selected> 
    3 
  </option> 
  <option> 
    4 
  </option> 
  <option> 
    5 
  </option> 
</select> ```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 11: How do I auto-resize an image to fit a 'div' container? (score [2256223](https://stackoverflow.com/q/3029422) in 2019)

#### Question
How do you auto-resize a large image so that it will fit into a smaller width div container whilst maintaining its width:height ratio?  

<hr>

Example: stackoverflow.com - when an image is inserted onto the editor panel and the image is too large to fit onto the page, the image is automatically resized.  

#### Answer accepted (score 1742)
Do not apply an explicit width or height to the image tag. Instead, give it:  

```html
max-width:100%;
max-height:100%;
```

Also, `height: auto;` if you want to specify a width only.  

Example: <a href="http://jsfiddle.net/xwrvxser/1/" rel="noreferrer">http://jsfiddle.net/xwrvxser/1/</a>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
img {
    max-width: 100%;
    max-height: 100%;
}

.portrait {
    height: 80px;
    width: 30px;
}

.landscape {
    height: 30px;
    width: 80px;
}

.square {
    height: 75px;
    width: 75px;
}```
```html
Portrait Div
<div class="portrait">
    <img src="http://i.stack.imgur.com/xkF9Q.jpg">
</div>

Landscape Div
<div class="landscape">
    <img src="http://i.stack.imgur.com/xkF9Q.jpg">
</div>

Square Div
<div class="square">
    <img src="http://i.stack.imgur.com/xkF9Q.jpg">
</div>```
</div>
</div>


#### Answer 2 (score 361)
<em><a href="https://developer.mozilla.org/en-US/docs/Web/CSS/object-fit" rel="noreferrer">object-fit</a></em>  

It turns out there's another way to do this.  

```html
<img style='height: 100%; width: 100%; object-fit: contain'/>
```

will do the work. It's CSS&nbsp;3 stuff.  

Fiddle: <a href="http://jsfiddle.net/mbHB4/7364/" rel="noreferrer">http://jsfiddle.net/mbHB4/7364/</a>  

#### Answer 3 (score 101)
Currently there is no way to do this correctly in a deterministic way, with fixed-size images such as JPEGs or PNG files.  

<strong>To resize an image proportionally, you have to set <em>either</em> the height or width to "100%", but not both.</strong> If you set both to "100%", your image will be stretched.  

Choosing whether to do height or width depends on your image and container dimensions:  

<ol>
<li>If your image and container are both "portrait shaped" or both "landscape shaped" (taller than they are wide, or wider than they are tall, respectively), then it doesn't matter which of height or width are "%100".</li>
<li>If your image is portrait, and your container is landscape, you must set `height="100%"` on the image.</li>
<li>If your image is landscape, and your container is portrait, you must set `width="100%"` on the image.</li>
</ol>

If your image is an SVG, which is a variable-sized vector image format, you can have the expansion to fit the container happen automatically.  

You just have to ensure that the SVG file has none of these properties set in the `&lt;svg&gt;` tag:  

```html
height
width
viewbox
```

Most vector drawing programs out there will set these properties when exporting an SVG file, so you will have to manually edit your file every time you export, or write a script to do it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: Which "href" value should I use for JavaScript links, "#" or "javascript:void(0)"? (score [2233339](https://stackoverflow.com/q/134845) in 2017)

#### Question
The following are two methods of building a link that has the sole purpose of running JavaScript code. Which is better, in terms of functionality, page load speed, validation purposes, etc.?  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
function myJsFunc() {
    alert("myJsFunc");
}```
```html
<a href="#" onclick="myJsFunc();">Run JavaScript Code</a>```
</div>
</div>


or  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
function myJsFunc() {
    alert("myJsFunc");
}```
```html
 <a href="javascript:void(0)" onclick="myJsFunc();">Run JavaScript Code</a>```
</div>
</div>


#### Answer 2 (score 2122)
I use `javascript:void(0)`.  

Three reasons. Encouraging the use of `#` amongst a team of developers inevitably leads to some using the return value of the function called like this:  

```html
function doSomething() {
    //Some code
    return false;
}
```

But then they forget to use `return doSomething()` in the onclick and just use `doSomething()`.  

A second reason for avoiding `#` is that the final `return false;` will not execute if the called function throws an error. Hence the developers have to also remember to handle any error appropriately in the called function.  

A third reason is that there are cases where the `onclick` event property is assigned dynamically.  I prefer to be able to call a function or assign it dynamically without having to code the function specifically for one method of attachment or another. Hence my `onclick` (or on anything) in HTML markup look like this:  

```html
onclick="someFunc.call(this)"
```

OR  

```html
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

### 13: Set cellpadding and cellspacing in CSS? (score [2226855](https://stackoverflow.com/q/339923) in 2018)

#### Question
In an HTML table, the `cellpadding` and `cellspacing` can be set like this:  

```html
<table cellspacing="1" cellpadding="1">
```

How can the same be accomplished using CSS?  

#### Answer accepted (score 3461)
<strong>Basics</strong>  

For controlling "cellpadding" in CSS, you can simply use `padding` on table cells. E.g. for 10px of "cellpadding":  

```html
td { 
    padding: 10px;
}
```

For "cellspacing", you can apply the `border-spacing` CSS property to your table. E.g. for 10px of "cellspacing":  

```html
table { 
    border-spacing: 10px;
    border-collapse: separate;
}
```

This property will even allow separate horizontal and vertical spacing, something you couldn't do with old-school "cellspacing".  

<strong>Issues in IE &lt;= 7</strong>  

This will work in almost all popular browsers except for Internet&nbsp;Explorer up through Internet&nbsp;Explorer&nbsp;7, where you're almost out of luck. I say "almost" because these browsers still support the `border-collapse` property, which merges the borders of adjoining table cells. If you're trying to eliminate cellspacing (that is, `cellspacing="0"`) then `border-collapse:collapse` should have the same effect: no space between table cells. This support is buggy, though, as it does not override an existing `cellspacing` HTML attribute on the table element.  

In short: for non-Internet&nbsp;Explorer 5-7 browsers, `border-spacing` handles you. For Internet&nbsp;Explorer, if your situation is just right (you want 0 cellspacing and your table doesn't have it defined already), you can use `border-collapse:collapse`.  

```html
table { 
    border-spacing: 0;
    border-collapse: collapse;
}
```

Note: For a great overview of CSS properties that one can apply to tables and for which browsers, see this <a href="http://www.quirksmode.org/css/tables.html" rel="noreferrer">fantastic Quirksmode page</a>.  

#### Answer 2 (score 919)
<h5>Default</h2>

The default behavior of the browser is equivalent to:  

```html
table {border-collapse: collapse;}
td    {padding: 0px;}
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://i.stack.imgur.com/cukle.png" alt="Enter image description here">  

<h5>Cellpadding</h2>

Sets the amount of space between the contents of the cell and the cell wall  

```html
table {border-collapse: collapse;}
td    {padding: 6px;}
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://i.stack.imgur.com/c0ght.png" alt="Enter image description here">  

<h5>Cellspacing</h2>

Controls the space between table cells  

```html
table {border-spacing: 2px;}
td    {padding: 0px;}
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://i.stack.imgur.com/WNuBP.png" alt="Enter image description here">  

<h5>Both</h2>

```html
table {border-spacing: 2px;}
td    {padding: 6px;}
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://i.stack.imgur.com/eyZQl.png" alt="Enter image description here">  

<h5>Both (special)</h2>

```html
table {border-spacing: 8px 2px;}
td    {padding: 6px;}
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://i.stack.imgur.com/gbJ3T.png" alt="Enter image description here">  

<blockquote>
  <strong>Note:</strong> If there is `border-spacing` set, it indicates `border-collapse` property of the table is `separate`.  
</blockquote>

<a href="http://jsfiddle.net/H4emK/3303/" rel="noreferrer">Try it yourself!</a>  

<a href="http://www.htmlcodetutorial.com/tables/index_famsupp_29.html" rel="noreferrer">Here</a> you can find the old HTML way of achieving this.  

#### Answer 3 (score 334)
```html
table
{
    border-collapse: collapse; /* 'cellspacing' equivalent */
}

table td, table th
{
    padding: 0; /* 'cellpadding' equivalent */
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: Get the value in an input text box (score [2222219](https://stackoverflow.com/q/4088467) in 2014)

#### Question
What are the ways to get and render an input value using jQuery?  

Here is one:   

```html
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.3.min.js" ></script>
<script type="text/javascript">
    $(document).ready(function(){
        $("#txt_name").keyup(function(){
            alert($(this).val());
        });
    })
</script>

<input type="text" id="txt_name"  />
```

#### Answer accepted (score 1598)
```html
//Get
var bla = $('#txt_name').val();

//Set
$('#txt_name').val(bla);
```

#### Answer 2 (score 586)
You can only select a value with the following two ways:  

```html
// First way to get a value
value = $("#txt_name").val(); 

// Second way to get a value
value = $("#txt_name").attr('value');
```

If you want to use straight JavaScript to get the value, here is how:  

```html
document.getElementById('txt_name').value 
```

#### Answer 3 (score 81)
There is one important thing to mention:  

```html
$("#txt_name").val();
```

will return the current real value of a text field, for example if the user typed something there after a page load.  

But:  

```html
$("#txt_name").attr('value')
```

will return value from DOM/HTML.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: How can I know which radio button is selected via jQuery? (score [2061588](https://stackoverflow.com/q/596351) in 2017)

#### Question
<p>I have two radio buttons and want to post the value of the selected one.
How can I get the value with jQuery?</p>

I can get all of them like this:  

```html
$("form :radio")
```

How do I know which one is selected?  

#### Answer accepted (score 3797)
To get the value of the <strong>selected</strong> `radioName` item of a form with id `myForm`:  

```html
$('input[name=radioName]:checked', '#myForm').val()
```

Here's an example:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
$('#myForm input').on('change', function() {
   alert($('input[name=radioName]:checked', '#myForm').val()); 
});```
```html
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

```html
$("#myform input[type='radio']:checked").val();
```

#### Answer 3 (score 290)
If you already have a reference to a radio button group, for example:  

```html
var myRadio = $("input[name=myRadio]");
```

Use the `filter()` function, not `find()`. (`find()` is for locating child/descendant elements, whereas `filter()` searches top-level elements in your selection.)  

```html
var checkedValue = myRadio.filter(":checked").val();
```

<hr>

<em>Notes:</em> This answer was originally correcting another answer that recommended using `find()`, which seems to have since been changed. `find()` could still be useful for the situation where you already had a reference to a container element, but not to the radio buttons, e.g.:  

```html
var form = $("#mainForm");
...
var checkedValue = form.find("input[name=myRadio]:checked").val();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: I need an unordered list without any bullets (score [1985502](https://stackoverflow.com/q/1027354) in 2019)

#### Question
I have created an unordered list. I feel the bullets in the unordered list are bothersome, so I want to remove them.   

Is it possible to have a list without bullets?  

#### Answer accepted (score 3515)
You can remove bullets by setting the <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/list-style-type" rel="noreferrer">`list-style-type`</a> to `none` on the CSS for the parent element (typically a `&lt;ul&gt;`), for example:  

```html
ul {
  list-style-type: none;
}
```

You might also want to add `padding: 0` and `margin: 0` to that if you want to remove indentation as well.  

See <a href="http://css.maxdesign.com.au/listutorial/index.htm" rel="noreferrer">Listutorial</a> for a great walkthrough of list formatting techniques.  

#### Answer 2 (score 557)
If you're using Bootstrap, it has an "unstyled" class:  

<blockquote>
  Remove the default list-style and left padding on list items (immediate children only).  
</blockquote>

<h5>Bootstrap 2:</h3>

```html
<ul class="unstyled">
   <li>...</li>
</ul>
```

<a href="http://twitter.github.io/bootstrap/base-css.html#typography" rel="noreferrer">http://twitter.github.io/bootstrap/base-css.html#typography</a>  

<h5>Bootstrap 3 and 4:</h3>

```html
<ul class="list-unstyled">
   <li>...</li>
</ul>
```

Bootstrap 3: <a href="http://getbootstrap.com/css/#type-lists" rel="noreferrer">http://getbootstrap.com/css/#type-lists</a>  

Bootstrap 4: <a href="https://getbootstrap.com/docs/4.3/content/typography/#unstyled" rel="noreferrer">https://getbootstrap.com/docs/4.3/content/typography/#unstyled</a>  

#### Answer 3 (score 204)
You need to use `list-style: none;`  

```html
<ul style="list-style: none;">
    <li> ...</li>
</ul>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: CSS Background Opacity (score [1857136](https://stackoverflow.com/q/10422949) in 2019)

#### Question
I am using something similar to the following code:   

```html
<div style="opacity:0.4; background-image:url(...);">
    <div style="opacity:1.0;">
        Text
    </div>
</div>
```

I expected this to make the background have an opacity of 0.4 and the text to have 100% opacity. Instead they both have an opacity of 0.4.   

#### Answer accepted (score 1085)
Children inherit opacity. It'd be weird and inconvenient if they didn't.  

You can use a translucent PNG file for your background image, or use an RGBa (a for alpha) color for your background color.  

Example, 50% faded black background:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<div style="background-color:rgba(0, 0, 0, 0.5);">
   <div>
      Text added.
   </div>
</div>```
</div>
</div>


#### Answer 2 (score 167)
You can use CSS 3 `:before` to have a semi-transparent background and you can do this with just one container. Use something like this  

```html
<article>
  Text.
</article>
```

Then apply some CSS  

```html
article {
  position: relative;
  z-index: 1;
}

article::before {
  content: "";
  position: absolute;
  top: 0; 
  left: 0;
  width: 100%; 
  height: 100%;  
  opacity: .4; 
  z-index: -1;
  background: url(path/to/your/image);
}
```

Sample: <a href="http://codepen.io/anon/pen/avdsi">http://codepen.io/anon/pen/avdsi</a>  

Note: You might need to adjust the `z-index` values.   

#### Answer 3 (score 43)
The following methods can be used to solve your problem:  

<ol>
<li><p>CSS alpha transparency method (doesn't work in Internet&nbsp;Explorer&nbsp;8):</p>

```html
#div{background-color:rgba(255,0,0,0.5);}
```</li>
<li><p>Use a transparent PNG image according to your choice as background.</p></li>
<li><p>Use the following CSS code snippet to create a cross-browser alpha-transparent background. Here is an example with `#000000` @ 0.4% opacity</p>

```html
.div {
    background:rgb(0,0,0);
    background: transparent\9;
    background:rgba(0,0,0,0.4);
    filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#66000000,endColorstr=#66000000);
    zoom: 1;
}
.div:nth-child(n) {
    filter: none;
}
```</li>
</ol>

For more details regarding this technique, see <a href="http://hammerspace.co.uk/2011/10/cross-browser-alpha-transparent-background-css" rel="nofollow noreferrer">this</a>, which has an online CSS generator.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: How to align content of a div to the bottom (score [1847026](https://stackoverflow.com/q/585945) in 2019)

#### Question
Say I have the following CSS and HTML code:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
#header {
  height: 150px;
}```
```html
<div id="header">
  <h1>Header title</h1>
  Header content (one or multiple lines)
</div>```
</div>
</div>


The header section is fixed height, but the header content may change.  

I would like the content of the header to be vertically aligned to the bottom of the header section, so the last line of text "sticks" to the bottom of the header section.  

So if there is only one line of text, it would be like:  

```html
-----------------------------
| Header title
|
|
|
| header content (resulting in one line)
-----------------------------
```

And if there were three lines:  

```html
-----------------------------
| Header title
|
| header content (which is so
| much stuff that it perfectly
| spans over three lines)
-----------------------------
```

How can this be done in CSS?  

#### Answer accepted (score 1248)
Relative+absolute positioning is your best bet:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
#header {
  position: relative;
  min-height: 150px;
}

#header-content {
  position: absolute;
  bottom: 0;
  left: 0;
}

#header, #header * {
  background: rgba(40, 40, 100, 0.25);
}```
```html
<div id="header">
  <h1>Title</h1>
  <div id="header-content">Some content</div>
</div>```
</div>
</div>


But you may run into issues with that.  When I tried it I had problems with dropdown menus appearing below the content.  It's just not pretty.  

Honestly, for vertical centering issues and, well, any vertical alignment issues with the items aren't fixed height, it's easier just to use tables.  

Example: <a href="https://stackoverflow.com/questions/522928/can-you-do-this-html-layout-without-using-tables">Can you do this HTML layout without using tables?</a>  

#### Answer 2 (score 149)
Use CSS positioning:  

```html
/* Creates a new stacking context on the header */
#header {
  position: relative;
}

/* Positions header-content at the bottom of header's context */
#header-content {
  position: absolute;
  bottom: 0;
}
```

As <a href="https://stackoverflow.com/questions/585945/how-to-align-content-of-a-div-to-the-bottom-with-css/585965#585965">cletus noted</a>, you need identify the header-content to make this work.  

```html
<span id="header-content">some header content</span>

<div style="height:100%; position:relative;">
    <div style="height:10%; position:absolute; bottom:0px;">bottom</div>
</div>
```

#### Answer 3 (score 111)
I use these properties and it works!  

```html
#header {
  display: table-cell;
  vertical-align: bottom;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: How to make a div 100% height of the browser window (score [1834779](https://stackoverflow.com/q/1575141) in 2019)

#### Question
I have a layout with two columns - a left `div` and a right `div`.  

The right `div` has a grey `background-color`, and I need it to expand vertically depending on the height of the user's browser window. Right now the `background-color` ends at the last piece of content in that `div`.   

I've tried `height:100%`, `min-height:100%;`, etc.  

#### Answer 2 (score 2677)
There are a couple of CSS 3 measurement units called:  

<h5><a href="http://www.w3.org/TR/css3-values/#viewport-relative-lengths" rel="noreferrer">Viewport-Percentage <em>(or Viewport-Relative)</em> Lengths</a></h1>

<h5>What are Viewport-Percentage Lengths?</h2>

From the linked W3 Candidate Recommendation above:  

<blockquote>
  <em>The viewport-percentage lengths are relative to the size of the initial containing block. When the height or width of the initial containing block is changed, they are scaled accordingly.</em>  
</blockquote>

These units are `vh` (viewport height), `vw` (viewport width), `vmin` (viewport minimum length) and `vmax` (viewport maximum length).  

<h5>How can this be used to make a divider fill the height of the browser?</h2>

For this question, we can make use of `vh`: `1vh` is equal to 1% of the viewport's height. That is to say, `100vh` is equal to the height of the browser window, regardless of where the element is situated in the DOM tree:  

<h5>HTML</h3>

```html
<div></div>
```

<h5>CSS</h3>

```html
div {
    height: 100vh;
}
```

This is literally all that's needed. Here is a <a href="http://jsfiddle.net/JamesD/hr8sL/" rel="noreferrer"><strong>JSFiddle example</strong></a> of this in use.  

<h5>What browsers support these new units?</h2>

This is currently supported on all up-to-date major browsers apart from Opera Mini. Check out <a href="http://caniuse.com/#feat=viewport-units" rel="noreferrer">Can I use...</a> for further support.  

<h5>How can this be used with multiple columns?</h2>

In the case of the question at hand, featuring a left and a right divider, here is a <a href="http://jsfiddle.net/JamesD/hr8sL/1/" rel="noreferrer">JSFiddle example</a> showing a two-column layout involving both `vh` and `vw`.  

<h5>How is `100vh` different to `100%`?</h2>

Take this layout for example:  

```html
<body style="height:100%">
    <div style="height:200px">
        <p style="height:100%; display:block;">Hello, world!</p>
    </div>
</body>
```

The `p` tag here is set to 100% height, but because its containing `div` has 200 pixels height, 100% of 200 pixels becomes 200 pixels, <em>not</em> 100% of the `body` height. Using `100vh` instead means that the `p` tag will be 100% height of the `body` regardless of the `div` height. Take a look at this <a href="http://jsfiddle.net/JamesD/hr8sL/2/" rel="noreferrer">accompanying JSFiddle</a> to easily see the difference!  

#### Answer 3 (score 553)
If you want to set the height of a `&lt;div&gt;` or any element, you should set the height of `&lt;body&gt;` and `&lt;html&gt;` to 100% too. Then you can set the height of element with 100% :)  

Here is an example:  

```html
body, html {
  height: 100%;
}

#right {
  height: 100%;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: HTML text input allow only numeric input (score [1744569](https://stackoverflow.com/q/469357) in 2019)

#### Question
Is there a quick way to set an HTML text input (`&lt;input type=text /&gt;`) to only allow numeric keystrokes (plus '.')?  

#### Answer accepted (score 1056)
<sup><strong>Note:</strong> This is an updated answer. Comments below refer to an old version which messed around with keycodes.</sup>  

<h5>JavaScript</h1>

The `setInputFilter` function below allows you to use <strong>any</strong> kind of input filter on a text `&lt;input&gt;`, including various numeric filters (see below).  

Unlike most other solutions, this <strong>correctly supports</strong> Copy+Paste, Drag+Drop, all keyboard shortcuts, all context menu operations, all non-typeable keys (e.g. cursor and navigation keys), the caret position, all keyboard layouts of all languages and platforms, and <a href="https://caniuse.com/#search=oninput" rel="nofollow noreferrer">all browsers since IE 9</a>.  

<strong>Try it yourself <a href="https://jsfiddle.net/emkey08/zgvtjc51" rel="nofollow noreferrer">on JSFiddle</a>.</strong>  

```html
// Restricts input for the given textbox to the given inputFilter.
function setInputFilter(textbox, inputFilter) {
  ["input", "keydown", "keyup", "mousedown", "mouseup", "select", "contextmenu", "drop"].forEach(function(event) {
    textbox.oldValue = "";
    textbox.addEventListener(event, function() {
      if (inputFilter(this.value)) {
        this.oldValue = this.value;
        this.oldSelectionStart = this.selectionStart;
        this.oldSelectionEnd = this.selectionEnd;
      } else if (this.hasOwnProperty("oldValue")) {
        this.value = this.oldValue;
        this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
      }
    });
  });
}

// Restrict input to digits and '.' by using a regular expression filter.
setInputFilter(document.getElementById("myTextBox"), function(value) {
  return /^\d*\.?\d*$/.test(value);
});
```

Some input filters you might want to use:  

<ul>
<li><strong>Integer</strong> values (positive only):<br/>
`/^\d*$/.test(value)`</li>
<li><strong>Integer</strong> values (positive and up to a particular limit):<br/>
`/^\d*$/.test(value) &amp;&amp; (value === "" || parseInt(value) &lt;= 500)`</li>
<li><strong>Integer</strong> values (both positive and negative):<br/>
`/^-?\d*$/.test(value)`</li>
<li><strong>Floating point</strong> values (allowing both `.` and `,` as decimal separator):<br/>
`/^-?\d*[.,]?\d*$/.test(value)`</li>
<li><strong>Currency</strong> values (i.e. at most two decimal places):<br/>
`/^-?\d*[.,]?\d{0,2}$/.test(value)`</li>
<li><strong>A-Z</strong> only (i.e. basic Latin letters):<br/>
`/^[a-z]*$/i.test(value)`</li>
<li><strong>Latin letters</strong> only (i.e. English and most European languages, see <a href="https://unicode-table.com" rel="nofollow noreferrer">https://unicode-table.com</a> for details about Unicode character ranges):<br/>
`/^[a-z\u00c0-\u024f]*$/i.test(value)`</li>
<li><strong>Hexadecimal</strong> values:<br/>
`/^[0-9a-f]*$/i.test(value)`</li>
</ul>

<strong>Note that you still <em>must</em> do server side validation!</strong>  

<h5>jQuery</h1>

There is also a jQuery version of this. See <a href="https://stackoverflow.com/a/995193/1070129">this answer</a> or try it yourself <a href="https://jsfiddle.net/emkey08/tvx5e7q3" rel="nofollow noreferrer">on JSFiddle</a>.  

<h5>HTML 5</h1>

HTML 5 has a native solution with `&lt;input type="number"&gt;` (see the <a href="https://www.w3.org/TR/html/sec-forms.html#number-state-typenumber" rel="nofollow noreferrer">specification</a>), but note that browser support varies:  

<ul>
<li>Most browsers will only validate the input when submitting the form, and not when typing.</li>
<li><a href="https://caniuse.com/#feat=input-number" rel="nofollow noreferrer">Most mobile browsers</a> don't support the `step`, `min` and `max` attributes.</li>
<li>Chrome (version 71.0.3578.98) still allows the user to enter the characters `e` and `E` into the field. Also see <a href="https://stackoverflow.com/q/31706611">this question</a>.</li>
<li>Firefox (version 64.0) and Edge (EdgeHTML version 17.17134) still allow the user to enter <em>any</em> text into the field.</li>
</ul>

Try it yourself <a href="http://www.w3schools.com/html/tryit.asp?filename=tryhtml5_input_type_number" rel="nofollow noreferrer">on w3schools.com</a>.  

#### Answer 2 (score 261)
Use this DOM  

```html
<input type='text' onkeypress='validate(event)' />
```

And this script  

```html
function validate(evt) {
  var theEvent = evt || window.event;

  // Handle paste
  if (theEvent.type === 'paste') {
      key = event.clipboardData.getData('text/plain');
  } else {
  // Handle key press
      var key = theEvent.keyCode || theEvent.which;
      key = String.fromCharCode(key);
  }
  var regex = /[0-9]|\./;
  if( !regex.test(key) ) {
    theEvent.returnValue = false;
    if(theEvent.preventDefault) theEvent.preventDefault();
  }
}
```

#### Answer 3 (score 130)
I've searched long and hard for a good answer to this, and we desperately need `&lt;input type="number"`, but short of that, these 2 are the most concise ways I could come up with:  

```html
<input type="text" 
       onkeyup="this.value=this.value.replace(/[^\d]/,'')">
```

If you dislike the non-accepted character showing for a split-second before being erased, the method below is my solution.  Note the numerous additional conditions, this is to avoid disabling all sorts of navigation and hotkeys.  If anyone knows how to compactify this, let us know!  

```html
<input type="text" 
onkeydown="return ( event.ctrlKey || event.altKey 
                    || (47<event.keyCode && event.keyCode<58 && event.shiftKey==false) 
                    || (95<event.keyCode && event.keyCode<106)
                    || (event.keyCode==8) || (event.keyCode==9) 
                    || (event.keyCode>34 && event.keyCode<40) 
                    || (event.keyCode==46) )">
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: Change an HTML5 input's placeholder color with CSS (score [1702940](https://stackoverflow.com/q/2610497) in 2018)

#### Question
Chrome supports the <a href="http://www.w3.org/html/wg/drafts/html/master/single-page.html#the-placeholder-attribute" rel="noreferrer" title="The placeholder attribute">placeholder attribute</a> on `input[type=text]` elements (others probably do too).  

But the following `CSS` doesn't do anything to the placeholder's value:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
input[placeholder], [placeholder], *[placeholder] {
    color: red !important;
}```
```html
<input type="text" placeholder="Value">```
</div>
</div>


`Value` will still remain `grey` instead of `red`.  

<strong>Is there a way to change the color of the placeholder text?</strong>  

#### Answer accepted (score 4727)
<h5>Implementation</h2>

There are three different implementations: pseudo-elements, pseudo-classes, and nothing.  

<ul>
<li>WebKit, Blink (Safari, Google Chrome, Opera 15+) and Microsoft Edge are using a pseudo-element: `::-webkit-input-placeholder`. <sup>[<a href="https://bugs.webkit.org/show_bug.cgi?id=21227" rel="noreferrer">Ref</a>]</sup></li>
<li>Mozilla Firefox 4 to 18 is using a pseudo-class: `:-moz-placeholder` (<em>one</em> colon). <sup>[<a href="https://developer.mozilla.org/en/CSS/:-moz-placeholder" rel="noreferrer">Ref</a>]</sup></li>
<li>Mozilla Firefox 19+ is using a pseudo-element: `::-moz-placeholder`, but the old selector will still work for a while. <sup>[<a href="https://developer.mozilla.org/en-US/docs/Web/CSS/%3A%3A-moz-placeholder" rel="noreferrer">Ref</a>]</sup></li>
<li>Internet Explorer 10 and 11 are using a pseudo-class: `:-ms-input-placeholder`. <sup>[<a href="http://msdn.microsoft.com/en-us/library/ie/hh772745(v=vs.85).aspx" rel="noreferrer">Ref</a>]</sup></li>
<li>April 2017: <strong>Most modern browsers support the simple pseudo-element `::placeholder` <sup>[<a href="https://caniuse.com/#feat=css-placeholder" rel="noreferrer">Ref</a>]</sup></strong></li>
</ul>

Internet Explorer 9 and lower does not support the `placeholder` attribute at all, while <a href="http://web.archive.org/web/20131206060908/http://my.opera.com/community/forums/topic.dml?id=841252&amp;t=1296553904&amp;page=1#comment8072202" rel="noreferrer">Opera 12 and lower do not support</a> any CSS selector for placeholders.  

The discussion about the best implementation is still going on. Note the pseudo-elements act like real elements in the <a href="http://glazkov.com/2011/01/14/what-the-heck-is-shadow-dom/" rel="noreferrer">Shadow DOM</a>. A `padding` on an `input` will not get the same background color as the pseudo-element.  

<h5>CSS selectors</h2>

User agents are required to ignore a rule with an unknown selector. See <a href="http://www.w3.org/TR/selectors/#Conformance" rel="noreferrer">Selectors Level 3</a>:  

<blockquote>
  a <a href="http://www.w3.org/TR/selectors/#grouping" rel="noreferrer">group</a> of selectors containing an invalid selector is invalid.  
</blockquote>

<p>So we need separate rules for each browser. Otherwise the whole group would be ignored by all browsers.
<div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
::-webkit-input-placeholder { /* WebKit, Blink, Edge */
    color:    #909;
}
:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
   color:    #909;
   opacity:  1;
}
::-moz-placeholder { /* Mozilla Firefox 19+ */
   color:    #909;
   opacity:  1;
}
:-ms-input-placeholder { /* Internet Explorer 10-11 */
   color:    #909;
}
::-ms-input-placeholder { /* Microsoft Edge */
   color:    #909;
}

::placeholder { /* Most modern browsers support this now. */
   color:    #909;
}```
```html
<input placeholder="Stack Snippets are awesome!">```
</div>
</div>


<h5>Usage notes</h2>

<ul>
<li>Be careful to avoid bad contrasts. Firefox's placeholder appears to be defaulting with a reduced opacity, so needs to use `opacity: 1` here.</li>
<li>Note that placeholder text is just cut off if it doesn’t fit – size your input elements in `em` and test them with big minimum font size settings. Don’t forget translations: some languages <a href="http://www.w3.org/International/articles/article-text-size.en" rel="noreferrer">need more room</a> for the same word. </li>
<li>Browsers with HTML support for `placeholder` but without CSS support for that (like Opera) should be tested too.</li>
<li>Some browsers use additional default CSS for some `input` types (`email`, `search`). These might affect the rendering in unexpected ways. Use the <a href="https://developer.mozilla.org/en-US/docs/CSS/-moz-appearance" rel="noreferrer">properties</a> `-webkit-appearance` and `-moz-appearance` to change that. Example:</li>
</ul>

```html
    [type="search"] {
        -moz-appearance:    textfield;
        -webkit-appearance: textfield;
        appearance: textfield;
    }
```

#### Answer 2 (score 703)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
/* do not group these rules */
*::-webkit-input-placeholder {
    color: red;
}
*:-moz-placeholder {
    /* FF 4-18 */
    color: red;
    opacity: 1;
}
*::-moz-placeholder {
    /* FF 19+ */
    color: red;
    opacity: 1;
}
*:-ms-input-placeholder {
    /* IE 10+ */
    color: red;
}
*::-ms-input-placeholder {
    /* Microsoft Edge */
    color: red;
}
*::placeholder {
    /* modern browser */
    color: red;
}```
```html
<input placeholder="hello"/> <br />
<textarea placeholder="hello"></textarea>```
</div>
</div>


This will style all `input` and `textarea` placeholders.  

<strong>Important Note:</strong> Do not group these rules. Instead, make a separate rule for every selector (one invalid selector in a group makes the whole group invalid).  

#### Answer 3 (score 270)
You may also want to style textareas:  

```html
input::-webkit-input-placeholder, textarea::-webkit-input-placeholder {
  color: #636363;
}
input:-moz-placeholder, textarea:-moz-placeholder {
  color: #636363;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How to overlay one div over another div (score [1664399](https://stackoverflow.com/q/2941189) in 2019)

#### Question
I need assistance with overlaying one individual `div` over another individual `div`.  

My code looks like this:  

```html
<div class="navi"></div>
<div id="infoi">
    <img src="info_icon2.png" height="20" width="32"/>
</div>
```

Unfortunately I cannot nest the `div#infoi` or the `img`, inside the first `div.navi`.  

It has to be two separate `div`s as shown, but I need to know how I could place the `div#infoi` over the `div.navi` and to the right most side and centered on top of the `div.navi`.  

#### Answer accepted (score 1160)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
#container {
  width: 100px;
  height: 100px;
  position: relative;
}
#navi,
#infoi {
  width: 100%;
  height: 100%;
  position: absolute;
  top: 0;
  left: 0;
}
#infoi {
  z-index: 10;
}```
```html
<div id="container">
  <div id="navi">a</div>
  <div id="infoi">
    <img src="https://appharbor.com/assets/images/stackoverflow-logo.png" height="20" width="32" />b
  </div>
</div>```
</div>
</div>


I would suggest learning about `position: relative` and child elements with `position: absolute`.  

#### Answer 2 (score 283)
The accepted solution works great, but IMO lacks an explanation as to why it works. The example below is boiled down to the basics and separates the important CSS from the non-relevant styling CSS. As a bonus, I've also included a detailed explanation of how CSS positioning works.  

<strong>TLDR;</strong> if you only want the code, scroll down to <strong>The Result</strong>.  

<h5>The Problem</h2>

There are two separate, sibling, elements and the goal is to position the second element (with an `id` of `infoi`), so it appears within the previous element (the one with a `class` of `navi`). The HTML structure cannot be changed.  

<h5>Proposed Solution</h2>

To achieve the desired result we're going to move, or position, the second element, which we'll call `#infoi` so it appears within the first element, which we'll call `.navi`. Specifically, we want `#infoi` to be positioned in the top-right corner of `.navi`.  

<h5>CSS Position Required Knowledge</h2>

CSS has several properties for positioning elements. By default, all elements are `position: static`. This means the element will be positioned according to its order in the HTML structure, with few exceptions.  

The other `position` values are `relative`, `absolute`, and `fixed`. By setting an element's `position` to one of these three values it's now possible to use a combination of the following four properties to position the element:  

<ul>
<li>`top`</li>
<li>`right`</li>
<li>`bottom`</li>
<li>`left`</li>
</ul>

In other words, by setting `position: absolute`, we can add `top: 100px` to position the element 100 pixels from the top of the page. Conversely, if we set `bottom: 100px` the element would be positioned 100 pixels from the bottom of the page.  

<strong><em>Here's where many CSS newcomers get lost</em></strong> - `position: absolute` has a frame of reference. In the example above, the frame of reference is the `body` element. `position: absolute` with `top: 100px` means the element is positioned 100 pixels from the top of the `body` element.  

The position frame of reference, or position context, can be altered by setting the `position` of a parent element to <strong><em>any value other than `position: static`</em></strong>. That is, we can create a new position context by giving a parent element:  

<ul>
<li>`position: absolute;`</li>
<li>`position: relative;`</li>
<li>`position: fixed;`</li>
</ul>

For example, if a `&lt;div class="parent"&gt;` element is given `position: relative`, any child elements use the `&lt;div class="parent"&gt;` as their position context. If a child element were given `position: absolute` and `top: 100px`, the element would be positioned 100 pixels from the top of the `&lt;div class="parent"&gt;` element, because the `&lt;div class="parent"&gt;` is now the position context.  

<strong>The other factor</strong> to be aware of is <strong>stack order</strong> - or how elements are stacked in the z-direction. The must-know here is the stack order of elements are, by default, defined by the reverse of their order in the HTML structure. Consider the following example:  

```html
<body>
  <div>Bottom</div>
  <div>Top</div>
</body>
```

In this example, if the two `&lt;div&gt;` elements were positioned in the same place on the page, the `&lt;div&gt;Top&lt;/div&gt;` element would cover the `&lt;div&gt;Bottom&lt;/div&gt;` element. Since `&lt;div&gt;Top&lt;/div&gt;` comes after `&lt;div&gt;Bottom&lt;/div&gt;` in the HTML structure it has a higher stacking order.  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="true" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
div {
  position: absolute;
  width: 50%;
  height: 50%;
}

#bottom {
  top: 0;
  left: 0;
  background-color: blue;
}

#top {
  top: 25%;
  left: 25%;
  background-color: red;
}```
```html
<div id="bottom">Bottom</div>
<div id="top">Top</div>```
</div>
</div>


The stacking order can be changed with CSS using the `z-index` or `order` properties.  

We can ignore the stacking order in this issue as the natural HTML structure of the elements means the element we want to appear on `top` comes after the other element.  

So, back to the problem at hand - we'll use position context to solve this issue.  

<h5>The Solution</h2>

As stated above, our goal is to position the `#infoi` element so it appears within the `.navi` element. To do this, we'll wrap the `.navi` and `#infoi` elements in a new element `&lt;div class="wrapper"&gt;` so we can create a new position context.  

```html
<div class="wrapper">
  <div class="navi"></div>
  <div id="infoi"></div>
</div>
```

Then create a new position context by giving `.wrapper` a `position: relative`.  

```html
.wrapper {
  position: relative;
}
```

With this new position context, we can position `#infoi` within `.wrapper`.  First, give `#infoi` a `position: absolute`, allowing us to position `#infoi` absolutely in `.wrapper`.  

Then add `top: 0` and `right: 0` to position the `#infoi` element in the top-right corner. Remember, because the `#infoi` element is using `.wrapper` as its position context, it will be in the top-right of the `.wrapper` element.  

```html
#infoi {
  position: absolute;
  top: 0;
  right: 0;
}
```

Because `.wrapper` is merely a container for `.navi`, positioning `#infoi` in the top-right corner of `.wrapper` gives the effect of being positioned in the top-right corner of `.navi`.  

And there we have it, `#infoi` now appears to be in the top-right corner of `.navi`.  

<h5>The Result</h2>

The example below is boiled down to the basics, and contains some minimal styling.  

  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="true" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
/*
*  position: relative gives a new position context
*/
.wrapper {
  position: relative;
}

/*
*  The .navi properties are for styling only
*  These properties can be changed or removed
*/
.navi {
  background-color: #eaeaea;
  height: 40px;
}


/*
*  Position the #infoi element in the top-right
*  of the .wrapper element
*/
#infoi {
  position: absolute;
  top: 0;
  right: 0;

  /*
  *  Styling only, the below can be changed or removed
  *  depending on your use case
  */
  height: 20px;
  padding: 10px 10px;
}```
```html
<div class="wrapper">
  <div class="navi"></div>
  <div id="infoi">
    <img src="http://via.placeholder.com/32x20/000000/ffffff?text=?" height="20" width="32"/>
  </div>
</div>```
</div>
</div>


<h5>The Alternate (No Wrapper) Solution</h2>

In the case we can't edit any HTML, meaning we can't add a wrapper element, we can still achieve the desired effect.  

Instead of using `position: absolute` on the `#infoi` element, we'll use `position: relative`. This allows us to reposition the `#infoi` element from its default position below the `.navi` element. With `position: relative` we can use a negative `top` value to move it up from its default position, and a `left` value of `100%` minus a few pixels, using `left: calc(100% - 52px)`, to position it near the right-side.  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="true" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
/*
*  The .navi properties are for styling only
*  These properties can be changed or removed
*/
.navi {
  background-color: #eaeaea;
  height: 40px;
  width: 100%;
}


/*
*  Position the #infoi element in the top-right
*  of the .wrapper element
*/
#infoi {
  position: relative;
  display: inline-block;
  top: -40px;
  left: calc(100% - 52px);

  /*
  *  Styling only, the below can be changed or removed
  *  depending on your use case
  */
  height: 20px;
  padding: 10px 10px;
}```
```html
<div class="navi"></div>
<div id="infoi">
  <img src="http://via.placeholder.com/32x20/000000/ffffff?text=?" height="20" width="32"/>
</div>```
</div>
</div>


#### Answer 3 (score 107)
By using a `div` with style `z-index:1;` and `position: absolute;` you can overlay your `div` on any other `div`.  

`z-index` determines the order in which divs 'stack'. A div with a higher `z-index` will appear in front of a div with a lower `z-index`. Note that this property <strong>only works with positioned elements</strong>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: Creating a div element in jQuery (score [1658176](https://stackoverflow.com/q/867916) in 2016)

#### Question
How do I create a `div` element in <strong>jQuery</strong>?  

#### Answer accepted (score 1039)
You can use `append` (to add at last position of parent) or `prepend` (to add at fist position of parent):  

```html
$('#parent').append('<div>hello</div>');    
// or
$('<div>hello</div>').appendTo('#parent');
```

Alternatively, you can use the `.html()` or `.add()` as mentioned in a <a href="https://stackoverflow.com/a/867941/59087">different answer</a>.  



#### Answer 2 (score 1957)
As of jQuery 1.4 you can pass attributes to a self-closed element like so:  

```html
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

### 24: CSS center text (horizontally and vertically) inside a div block (score [1633481](https://stackoverflow.com/q/5703552) in 2019)

#### Question
I have a `div` set to `display:block` (`90px` `height` and `width`), and I have some text inside.  

I need the text to be aligned in the center both vertically and horizontally.  

I have tried `text-align:center`, but it doesn't do the horizontal part, so I tried `vertical-align:middle`, but it didn't work.  

Any ideas?  

#### Answer accepted (score 1211)
If it is one line of text and/or image, then it is easy to do. Just use:  

```html
text-align: center;
vertical-align: middle;
line-height: 90px;       /* The same as your div height */
```

That's it. If it can be multiple lines, then it is somewhat more complicated. But there are solutions on  <a href="http://pmob.co.uk/" rel="noreferrer">http://pmob.co.uk/</a>. Look for "vertical align".  

Since they tend to be hacks or adding complicated divs... I usually use a table with a single cell to do it... to make it as simple as possible.  

<hr>

<h5>Update for 2016 / 2017:</h1>

It can be more commonly done with `transform`, and it works well even in older browsers such as Internet&nbsp;Explorer&nbsp;10 and Internet&nbsp;Explorer&nbsp;11. It can support multiple lines of text:  

```html
position: relative;
top: 50%;
transform: translateY(-50%);
```

Example: <a href="https://jsfiddle.net/wb8u02kL/1/" rel="noreferrer">https://jsfiddle.net/wb8u02kL/1/</a>  

<h5>To shrink-wrap the width:</h2>

The solution above used a fixed width for the content area. To use a shrink-wrapped width, use  

```html
position: relative;
float: left;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
```

Example: <a href="https://jsfiddle.net/wb8u02kL/2/" rel="noreferrer">https://jsfiddle.net/wb8u02kL/2/</a>  

I tried flexbox, but it wasn't as widely supported, as it would break in some older version of Internet&nbsp;Explorer such as Internet&nbsp;Explorer&nbsp;10.  

#### Answer 2 (score 428)
<h5>Common techniques as of 2014:</h2>

<hr>

<ul>
<li><h5>Approach 1 - `transform` `translateX`/`translateY`:</h3>

<a href="http://jsfiddle.net/47x60k4w/" rel="noreferrer"><strong>Example Here</strong></a> / <a href="http://jsfiddle.net/47x60k4w/show" rel="noreferrer"><strong>Full Screen Example</strong></a>  

In <a href="http://caniuse.com/#feat=transforms2d" rel="noreferrer">supported browsers</a> (most of them), you can use `top: 50%`/`left: 50%` in combination with  `translateX(-50%) translateY(-50%)` to dynamically vertically/horizontally center the element.  

```html
.container {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translateX(-50%) translateY(-50%);
}
```</li>
</ul>

<hr>

<ul>
<li><h5>Approach 2 - Flexbox method:</h3>

<a href="http://jsfiddle.net/yeaqrh48/" rel="noreferrer"><strong>Example Here</strong></a> / <a href="http://jsfiddle.net/yeaqrh48/show" rel="noreferrer"><strong>Full Screen Example</strong></a>  

In <a href="http://caniuse.com/#feat=flexbox" rel="noreferrer">supported browsers</a>, set the `display` of the targeted element to `flex` and use `align-items: center` for vertical centering and `justify-content: center` for horizontal centering. Just don't forget to add vendor prefixes for additional browser support (<a href="http://jsfiddle.net/yeaqrh48/" rel="noreferrer">see example</a>).  

```html
html, body, .container {
    height: 100%;
}
.container {
    display: flex;
    align-items: center;
    justify-content: center;
}
```</li>
</ul>

<hr>

<ul>
<li><h5>Approach 3 - `table-cell`/`vertical-align: middle`:</h3>

<a href="http://jsfiddle.net/sa088kb0/" rel="noreferrer"><strong>Example Here</strong></a> / <a href="http://jsfiddle.net/sa088kb0/show/" rel="noreferrer"><strong>Full Screen Example</strong></a>  

In some cases, you will need to ensure that the `html`/`body` element's height is set to `100%`.  

For vertical alignment, set the parent element's `width`/`height` to `100%` and add `display: table`. Then for the child element, change the `display` to `table-cell` and add `vertical-align: middle`.  

For horizontal centering, you could either add `text-align: center` to center the text and any other `inline` children elements. Alternatively, you could use `margin: 0 auto` assuming the element is `block` level.  

```html
html, body {
    height: 100%;
}
.parent {
    width: 100%;
    height: 100%;
    display: table;
    text-align: center;
}
.parent > .child {
    display: table-cell;
    vertical-align: middle;
}
```</li>
</ul>

<hr>

<ul>
<li><h5>Approach 4 - Absolutely positioned `50%` from the top with displacement:</h3>

<a href="http://jsfiddle.net/2epdqL5g/" rel="noreferrer"><strong>Example Here</strong></a> / <a href="http://jsfiddle.net/2epdqL5g/show" rel="noreferrer"><strong>Full Screen Example</strong></a>  

This approach assumes that the text has a known height - in this instance, `18px`. Just absolutely position the element `50%` from the top, relative to the parent element. Use a negative `margin-top` value that is half of the element's known height, in this case - `-9px`.  

```html
html, body, .container {
    height: 100%;
}
.container {
    position: relative;
    text-align: center;
}
.container > p {
    position: absolute;
    top: 50%;
    left: 0;
    right: 0;
    margin-top: -9px;
}
```</li>
</ul>

<hr>

<ul>
<li><h5>Approach 5 - The `line-height` method (Least flexible - not suggested):</h3>

<a href="http://jsfiddle.net/6onex7jf/" rel="noreferrer"><strong>Example Here</strong></a>  

In some cases, the parent element will have a fixed height. For vertical centering, all you have to do is set a `line-height` value on the child element equal to the fixed height of the parent element.  

Though this solution will work in some cases, it's worth noting that it won't work when there are multiple lines of text - <a href="http://jsfiddle.net/6rvdxbt9/" rel="noreferrer">like this</a>.  

```html
.parent {
    height: 200px;
    width: 400px;
    text-align: center;
}
.parent > .child {
    line-height: 200px;
}
```</li>
</ul>

<hr>

Methods 4 and 5 aren't the most reliable. Go with one of the first 3.  

#### Answer 3 (score 70)
Using flexbox/CSS:   

```html
<div class="box">
    <p>&#x0D05;</p>
</div>
```

The CSS:  

```html
.box{
    display: flex;
    justify-content: center;
    align-items: center;
}
```

Taken from <a href="http://tutorialzine.com/2015/09/quick-tip-the-simplest-way-to-center-elements-vertically-and-horizontally/">Quick Tip: The Simplest Way To Center Elements Vertically And Horizontally</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: How to style a checkbox using CSS (score [1556560](https://stackoverflow.com/q/4148499) in 2019)

#### Question
I am trying to style a checkbox using the following:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<input type="checkbox" style="border:2px dotted #00f;display:block;background:#ff0000;" />```
</div>
</div>


But the style is not applied. The checkbox still displays its default style. How do I give it the specified style?  

#### Answer accepted (score 748)
UPDATE:  

The below answer references the state of things before widespread availability of CSS&nbsp;3. In modern browsers (including Internet Explorer 9 and later) it is more straightforward to create checkbox replacements with your preferred styling, without using JavaScript.  

Here are some useful links:  

<ul>
<li><a href="http://www.inserthtml.com/2012/06/custom-form-radio-checkbox/" rel="noreferrer">Creating Custom Form Checkboxes with Just CSS</a></li>
<li><a href="http://csscheckbox.com" rel="noreferrer">Easy CSS Checkbox Generator</a></li>
<li><a href="http://css-tricks.com/the-checkbox-hack/" rel="noreferrer">Stuff You Can Do With The Checkbox Hack</a></li>
<li><a href="http://www.css3.com/implementing-custom-checkboxes-and-radio-buttons-with-css3/" rel="noreferrer">Implementing Custom Checkboxes and Radio Buttons with CSS3</a></li>
<li><a href="http://www.paulund.co.uk/style-checkboxes-with-css" rel="noreferrer">How to Style a Checkbox With CSS</a></li>
</ul>

It is worth noting that the fundamental issue has not changed. You still can't apply styles (borders, etc.) directly to the checkbox element and have those styles affect the display of the HTML checkbox. What has changed, however, is that it's now possible to hide the actual checkbox and replace it with a styled element of your own, using nothing but CSS. In particular, because CSS now has a widely supported `:checked` selector, you can make your replacement correctly reflect the checked status of the box.  

<hr>

OLDER ANSWER  

Here's <a href="http://www.456bereastreet.com/archive/200701/styling_form_controls_with_css_revisited/" rel="noreferrer">a useful article about styling checkboxes</a>.  Basically, that writer found that it varies tremendously from browser to browser, and that many browsers always display the default checkbox no matter how you style it. So there really isn't an easy way.  

It's not hard to imagine a workaround where you would use JavaScript to overlay an image on the checkbox and have clicks on that image cause the real checkbox to be checked. Users without JavaScript would see the default checkbox.  

Edited to add: here's <a href="https://web.archive.org/web/20160430165815/http://ryanfait.com:80/resources/custom-checkboxes-and-radio-buttons/#" rel="noreferrer">a nice script that does this for you</a>; it hides the real checkbox element, replaces it with a styled span, and redirects the click events.  

#### Answer 2 (score 137)
There is a way to do this using just CSS. We can (ab)use the `label` element and style that element instead. The caveat is that this will not work for Internet&nbsp;Explorer&nbsp;8 and lower versions.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
.myCheckbox input {
  position: relative;
  z-index: -9999;
}

.myCheckbox span {
  width: 20px;
  height: 20px;
  display: block;
  background: url("link_to_image");
}

.myCheckbox input:checked + span {
  background: url("link_to_another_image");
}```
```html
<label for="test">Label for my styled "checkbox"</label>
<label class="myCheckbox">
  <input type="checkbox" name="test" />
  <span></span>
</label>```
</div>
</div>


#### Answer 3 (score 130)
You can achieve quite a cool custom checkbox effect by using the new abilities that come with the `:after` and `:before` pseudo classes. The advantage to this, is: You don't need to add anything more to the DOM, just the standard checkbox.  

Note this will only work for compatible browsers. I believe this is related to the fact that some browsers do not allow you to set `:after` and `:before` on input elements. Which unfortunately means for the moment only WebKit browsers are supported. Firefox + Internet&nbsp;Explorer will still allow the checkboxes to function, just unstyled, and this will hopefully change in the future (the code does not use vendor prefixes).  

<strong>This is a WebKit browser solution only (Chrome, Safari, Mobile browsers)</strong>  

<strong><a href="http://jsfiddle.net/YMuPw/15/" rel="nofollow noreferrer">See Example Fiddle</a></strong>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
$(function() {
  $('input').change(function() {
    $('div').html(Math.random());
  });
});```
```html
/* Main Classes */
.myinput[type="checkbox"]:before {
  position: relative;
  display: block;
  width: 11px;
  height: 11px;
  border: 1px solid #808080;
  content: "";
  background: #FFF;
}

.myinput[type="checkbox"]:after {
  position: relative;
  display: block;
  left: 2px;
  top: -11px;
  width: 7px;
  height: 7px;
  border-width: 1px;
  border-style: solid;
  border-color: #B3B3B3 #dcddde #dcddde #B3B3B3;
  content: "";
  background-image: linear-gradient(135deg, #B1B6BE 0%, #FFF 100%);
  background-repeat: no-repeat;
  background-position: center;
}

.myinput[type="checkbox"]:checked:after {
  background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAQAAABuW59YAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAB2SURBVHjaAGkAlv8A3QDyAP0A/QD+Dam3W+kCAAD8APYAAgTVZaZCGwwA5wr0AvcA+Dh+7UX/x24AqK3Wg/8nt6w4/5q71wAAVP9g/7rTXf9n/+9N+AAAtpJa/zf/S//DhP8H/wAA4gzWj2P4lsf0JP0A/wADAHB0Ngka6UmKAAAAAElFTkSuQmCC'), linear-gradient(135deg, #B1B6BE 0%, #FFF 100%);
}

.myinput[type="checkbox"]:disabled:after {
  -webkit-filter: opacity(0.4);
}

.myinput[type="checkbox"]:not(:disabled):checked:hover:after {
  background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHCAQAAABuW59YAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAB2SURBVHjaAGkAlv8A3QDyAP0A/QD+Dam3W+kCAAD8APYAAgTVZaZCGwwA5wr0AvcA+Dh+7UX/x24AqK3Wg/8nt6w4/5q71wAAVP9g/7rTXf9n/+9N+AAAtpJa/zf/S//DhP8H/wAA4gzWj2P4lsf0JP0A/wADAHB0Ngka6UmKAAAAAElFTkSuQmCC'), linear-gradient(135deg, #8BB0C2 0%, #FFF 100%);
}

.myinput[type="checkbox"]:not(:disabled):hover:after {
  background-image: linear-gradient(135deg, #8BB0C2 0%, #FFF 100%);
  border-color: #85A9BB #92C2DA #92C2DA #85A9BB;
}

.myinput[type="checkbox"]:not(:disabled):hover:before {
  border-color: #3D7591;
}

/* Large checkboxes */
.myinput.large {
  height: 22px;
  width: 22px;
}

.myinput.large[type="checkbox"]:before {
  width: 20px;
  height: 20px;
}

.myinput.large[type="checkbox"]:after {
  top: -20px;
  width: 16px;
  height: 16px;
}

/* Custom checkbox */
.myinput.large.custom[type="checkbox"]:checked:after {
  background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGHRFWHRBdXRob3IAbWluZWNyYWZ0aW5mby5jb23fZidLAAAAk0lEQVQ4y2P4//8/AyUYwcAD+OzN/oMwshjRBoA0Gr8+DcbIhhBlAEyz+qZZ/7WPryHNAGTNMOxpJvo/w0/uP0kGgGwGaZbrKgfTGnLc/0nyAgiDbEY2BCRGdCDCnA2yGeYVog0Aae5MV4c7Gzk6CRqAbDM2w/EaQEgzXgPQnU2SAcTYjNMAYm3GaQCxNuM0gFwMAPUKd8XyBVDcAAAAAElFTkSuQmCC'), linear-gradient(135deg, #B1B6BE 0%, #FFF 100%);
}

.myinput.large.custom[type="checkbox"]:not(:disabled):checked:hover:after {
  background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGHRFWHRBdXRob3IAbWluZWNyYWZ0aW5mby5jb23fZidLAAAAk0lEQVQ4y2P4//8/AyUYwcAD+OzN/oMwshjRBoA0Gr8+DcbIhhBlAEyz+qZZ/7WPryHNAGTNMOxpJvo/w0/uP0kGgGwGaZbrKgfTGnLc/0nyAgiDbEY2BCRGdCDCnA2yGeYVog0Aae5MV4c7Gzk6CRqAbDM2w/EaQEgzXgPQnU2SAcTYjNMAYm3GaQCxNuM0gFwMAPUKd8XyBVDcAAAAAElFTkSuQmCC'), linear-gradient(135deg, #8BB0C2 0%, #FFF 100%);
}```
```html
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

<table style="width:100%">
  <tr>
    <td>Normal:</td>
    <td><input type="checkbox" /></td>
    <td><input type="checkbox" checked="checked" /></td>
    <td><input type="checkbox" disabled="disabled" /></td>
    <td><input type="checkbox" disabled="disabled" checked="checked" /></td>
  </tr>
  <tr>
    <td>Small:</td>
    <td><input type="checkbox" class="myinput" /></td>
    <td><input type="checkbox" checked="checked" class="myinput" /></td>
    <td><input type="checkbox" disabled="disabled" class="myinput" /></td>
    <td><input type="checkbox" disabled="disabled" checked="checked" class="myinput" /></td>
  </tr>
  <tr>
    <td>Large:</td>
    <td><input type="checkbox" class="myinput large" /></td>
    <td><input type="checkbox" checked="checked" class="myinput large" /></td>
    <td><input type="checkbox" disabled="disabled" class="myinput large" /></td>
    <td><input type="checkbox" disabled="disabled" checked="checked" class="myinput large" /></td>
  </tr>
  <tr>
    <td>Custom icon:</td>
    <td><input type="checkbox" class="myinput large custom" /></td>
    <td><input type="checkbox" checked="checked" class="myinput large custom" /></td>
    <td><input type="checkbox" disabled="disabled" class="myinput large custom" /></td>
    <td><input type="checkbox" disabled="disabled" checked="checked" class="myinput large custom" /></td>
  </tr>
</table>```
</div>
</div>


<a href="http://jsfiddle.net/dv904vn1/2/" rel="nofollow noreferrer"><strong>Bonus Webkit style flipswitch fiddle</strong></a>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
$(function() {
  var f = function() {
    $(this).next().text($(this).is(':checked') ? ':checked' : ':not(:checked)');
  };
  $('input').change(f).trigger('change');
});```
```html
body {
  font-family: arial;
}

.flipswitch {
  position: relative;
  background: white;
  width: 120px;
  height: 40px;
  -webkit-appearance: initial;
  border-radius: 3px;
  -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
  outline: none;
  font-size: 14px;
  font-family: Trebuchet, Arial, sans-serif;
  font-weight: bold;
  cursor: pointer;
  border: 1px solid #ddd;
}

.flipswitch:after {
  position: absolute;
  top: 5%;
  display: block;
  line-height: 32px;
  width: 45%;
  height: 90%;
  background: #fff;
  box-sizing: border-box;
  text-align: center;
  transition: all 0.3s ease-in 0s;
  color: black;
  border: #888 1px solid;
  border-radius: 3px;
}

.flipswitch:after {
  left: 2%;
  content: "OFF";
}

.flipswitch:checked:after {
  left: 53%;
  content: "ON";
}```
```html
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

<h2>Webkit friendly mobile-style checkbox/flipswitch</h2>
<input type="checkbox" class="flipswitch" /> &nbsp;
<span></span>
<br>
<input type="checkbox" checked="checked" class="flipswitch" /> &nbsp;
<span></span>```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How do I vertically align text in a div? (score [1542747](https://stackoverflow.com/q/2939914) in 2018)

#### Question
I am trying to find the most effective way to align text with a div. I have tried a few things and none seem to work.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
.testimonialText {
  position: absolute;
  left: 15px;
  top: 15px;
  width: 150px;
  height: 309px;
  vertical-align: middle;
  text-align: center;
  font-family: Georgia, "Times New Roman", Times, serif;
  font-style: italic;
  padding: 1em 0 1em 0;
}```
```html
<div class="testimonialText">
  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
  in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
</div>```
</div>
</div>


#### Answer accepted (score 744)
<p><strong>Vertical Centering in CSS</strong>
<br/><a href="http://www.jakpsatweb.cz/css/css-vertical-center-solution.html" rel="noreferrer">http://www.jakpsatweb.cz/css/css-vertical-center-solution.html</a></p>

Article summary:  

For a CSS&nbsp;2 browser, one can use `display:table`/`display:table-cell` to center content.  

A sample is also available at <a href="http://jsfiddle.net/SVJaK/" rel="noreferrer">JSFiddle</a>:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
div { border:1px solid green;}```
```html
<div style="display: table; height: 400px; overflow: hidden;">
  <div style="display: table-cell; vertical-align: middle;">
    <div>
      everything is vertically centered in modern IE8+ and others.
    </div>
  </div>
</div>```
</div>
</div>


It is possible to merge hacks for old browsers (Internet&nbsp;Explorer&nbsp;6/7) into styles with using `#` to hide styles from newer browsers:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
div { border:1px solid green;}```
```html
<div style="display: table; height: 400px; #position: relative; overflow: hidden;">
  <div style=
    "#position: absolute; #top: 50%;display: table-cell; vertical-align: middle;">
    <div style=" #position: relative; #top: -50%">
      everything is vertically centered
    </div>
  </div>
</div>```
</div>
</div>


#### Answer 2 (score 714)
You need to add the `line-height` attribute and that attribute must match the height of the `div`. In your case:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
.center {
  height: 309px;
  line-height: 309px; /* same as height! */
}```
```html
<div class="center">
  A single line.
</div>```
</div>
</div>


In fact, you could probably remove the `height` attribute altogether.  

This only works for <strong>one line of text</strong> though, so be careful.  

#### Answer 3 (score 438)
<h5>Here's a great resource</h2>

From <a href="http://howtocenterincss.com/" rel="noreferrer">http://howtocenterincss.com/</a>:  

<blockquote>
  Centering in CSS is a pain in the ass. There seems to be a gazillion ways to do it, depending on a variety of factors. This consolidates them and gives you the code you need for each situation.  
</blockquote>

<h5>Using Flexbox</h2>

Inline with keeping this post up to date with the latest tech, here's a much easier way to center something using Flexbox. Flexbox isn't supported in <em>Internet&nbsp;Explorer&nbsp;9 and lower</em>.  

Here are some great resources:  

<ul>
<li><a href="http://css-tricks.com/snippets/css/a-guide-to-flexbox/" rel="noreferrer">A guide to Flexbox</a></li>
<li><a href="http://coding.smashingmagazine.com/2013/05/22/centering-elements-with-flexbox/" rel="noreferrer">Centering elements with Flexbox</a></li>
<li><a href="http://zomigi.com/blog/flexbox-syntax-for-ie-10/" rel="noreferrer">Internet&nbsp;Explorer&nbsp;10 syntax for Flexbox</a></li>
<li><a href="http://caniuse.com/flexbox" rel="noreferrer">Support for Flexbox</a></li>
</ul>

<a href="http://jsfiddle.net/Sw3Jd/285/" rel="noreferrer">JSFiddle with browser prefixes</a>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
li {
  display: flex;
  justify-content: center;
  align-content: center;
  flex-direction: column;
  /* Column | row */
}```
```html
<ul>
  <li>
    <p>Some Text</p>
  </li>
  <li>
    <p>A bit more text that goes on two lines</p>
  </li>
  <li>
    <p>Even more text that demonstrates how lines can span multiple lines</p>
  </li>
</ul>```
</div>
</div>


<h5>Another solution</h2>

<a href="http://zerosixthree.se/vertical-align-anything-with-just-3-lines-of-css/" rel="noreferrer">This is from <strong>zerosixthree</strong> and lets you center anything with six lines of CSS</a>  

This method isn't supported in <em>Internet&nbsp;Explorer&nbsp;8 and lower</em>.  

<a href="http://jsfiddle.net/Sw3Jd/310/" rel="noreferrer">jsfiddle</a>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
p {
  text-align: center;
  position: relative;
  top: 50%;
  -ms-transform: translateY(-50%);
  -webkit-transform: translateY(-50%);
  transform: translateY(-50%);
}```
```html
<ul>
  <li>
    <p>Some Text</p>
  </li>
  <li>
    <p>A bit more text that goes on two lines</p>
  </li>
  <li>
    <p>Even more text that demonstrates how lines can span multiple lines</p>
  </li>
</ul>```
</div>
</div>


<h5>Previous answer</h2>

A simple and cross-browser approach, useful as links in the marked answer are slightly outdated.  

<blockquote>
  <strong>How to vertically and horizontally center text in both an unordered list and a div without resorting to JavaScript or CSS line heights</strong>. No matter how much text you have you won't have to apply any special classes to specific lists or divs (the code is the same for each). This works on all major browsers including Internet&nbsp;Explorer&nbsp;9, Internet&nbsp;Explorer&nbsp;8, Internet&nbsp;Explorer&nbsp;7, Internet&nbsp;Explorer&nbsp;6, Firefox, Chrome, <a href="http://en.wikipedia.org/wiki/Opera_%28web_browser%29" rel="noreferrer">Opera</a> and Safari. There are two special stylesheets (one for Internet&nbsp;Explorer&nbsp;7 and another for Internet&nbsp;Explorer&nbsp;6) to help them along due to their CSS limitations which modern browsers don't have.  
</blockquote>

<h5><a href="http://www.andy-howard.com/verticalAndHorizontalAlignment/index.html" rel="noreferrer">Andy Howard - How to vertically and horizontally center text in an unordered list or div</a></h3>

As I didn't care much for Internet&nbsp;Explorer&nbsp;7/6 for the last project I worked on, I used a slightly stripped down version (i.e. removed the stuff that made it work in Internet&nbsp;Explorer&nbsp;7 and 6). It might be useful for somebody else...  

<a href="http://jsfiddle.net/Sw3Jd/" rel="noreferrer">JSFiddle</a>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
.outerContainer {
  display: table;
  width: 100px;
  /* Width of parent */
  height: 100px;
  /* Height of parent */
  overflow: hidden;
}

.outerContainer .innerContainer {
  display: table-cell;
  vertical-align: middle;
  width: 100%;
  margin: 0 auto;
  text-align: center;
}

li {
  background: #ddd;
  width: 100px;
  height: 100px;
}```
```html
<ul>
  <li>
    <div class="outerContainer">
      <div class="innerContainer">
        <div class="element">
          <p>
            <!-- Content -->
            Content
          </p>
        </div>
      </div>
    </div>
  </li>

  <li>
    <div class="outerContainer">
      <div class="innerContainer">
        <div class="element">
          <p>
            <!-- Content -->
            Content
          </p>
        </div>
      </div>
    </div>
  </li>
</ul>```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 27: How do I style a <select> dropdown with only CSS? (score [1519897](https://stackoverflow.com/q/1895476) in 2019)

#### Question
Is there a CSS-only way to style a `&lt;select&gt;` dropdown?  

I need to style a `&lt;select&gt;` form as much as humanly possible, without any JavaScript. What are the properties I can use to do so in CSS?  

This code needs to be compatible with all major browsers:  

<ul>
<li>Internet Explorer 6, 7, and 8</li>
<li>Firefox</li>
<li>Safari</li>
</ul>

I know I can make it with JavaScript: <a href="http://www.queness.com/post/204/25-jQuery-plugins-that-enhance-and-beautify-html-form-elements" rel="noreferrer">Example</a>.  

And I'm not talking about simple styling. I want to know, what the best we can do with CSS only.  

I found <a href="https://stackoverflow.com/questions/1072239/is-it-possible-to-style-a-select-box">similar questions</a> on Stack&nbsp;Overflow.  

And <a href="http://doctype.com/style-select" rel="noreferrer">this one</a> on Doctype.com.  

#### Answer accepted (score 971)
Here are three solutions:  

Solution #1 - appearance: none   - with Internet&nbsp;Explorer&nbsp;10 - 11 workaround (<a href="http://codepen.io/danield770/pen/bgJOyV?editors=1100" rel="noreferrer">Demo</a>)  

--  

To hide the default arrow set `appearance: none` on the select element, then add your own custom arrow with `background-image`  

```html
select {
   -webkit-appearance: none;
   -moz-appearance: none;
   appearance: none;       /* Remove default arrow */
   background-image: url(...);   /* Add custom arrow */
}
```

<strong>Browser Support:</strong>  

`appearance: none` has very good browser support (<a href="http://caniuse.com/#feat=css-appearance" rel="noreferrer">caniuse</a>) - except for Internet&nbsp;Explorer&nbsp;11 (and later) and Firefox 34 (and later).  

We can improve this technique and add support for Internet&nbsp;Explorer&nbsp;10 and Internet&nbsp;Explorer&nbsp;11 by adding  

```html
select::-ms-expand {
    display: none; /* Hide the default arrow in Internet Explorer 10 and Internet Explorer 11 */
}
```

If Internet&nbsp;Explorer&nbsp;9 is a concern, we have no way of removing the default arrow (which would mean that we would now have two arrows), but, we could use a funky Internet&nbsp;Explorer&nbsp;9 selector.  

To at least undo our custom arrow - leaving the default select arrow intact.  

```html
/* Target Internet Explorer 9 to undo the custom arrow */
@media screen and (min-width:0\0) {
    select {
        background-image:none\9;
        padding: 5px\9;
    }
}
```

<h5>All together:</h2>

<p><div class="snippet" data-lang="js" data-hide="true" data-console="true" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
select {
  margin: 50px;
  width: 150px;
  padding: 5px 35px 5px 5px;
  font-size: 16px;
  border: 1px solid #CCC;
  height: 34px;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  background: url(http://www.stackoverflow.com/favicon.ico) 96% / 15% no-repeat #EEE;
}


/* CAUTION: Internet Explorer hackery ahead */


select::-ms-expand {
    display: none; /* Remove default arrow in Internet Explorer 10 and 11 */
}

/* Target Internet Explorer 9 to undo the custom arrow */
@media screen and (min-width:0\0) {
    select {
        background: none\9;
        padding: 5px\9;
    }
}```
```html
<select>
  <option>Apples</option>
  <option selected>Pineapples</option>
  <option>Chocklate</option>
  <option>Pancakes</option>
</select>```
</div>
</div>


This solution is easy and has good browser support - it should generally suffice.  

<hr>

If browser support for Internet&nbsp;Explorer&nbsp;9 (and later) and Firefox 34  (and later) is necessary then keep reading...  

Solution #2 Truncate the select element to hide the default arrow (<a href="http://jsfiddle.net/danield770/YvCHW/4246/" rel="noreferrer">demo</a>)  

--  

<a href="http://bavotasan.com/2011/style-select-box-using-only-css/" rel="noreferrer">(Read more here)</a>  

Wrap the `select` element in a div with a <em>fixed width</em> and `overflow:hidden`.  

Then give the `select` element a width of about <em>20 pixels greater than the div</em>.  

The result is that the default drop-down arrow of the `select` element will be hidden (due to the `overflow:hidden` on the container), and you can place any background image you want on the right-hand-side of the div.  

The <strong>advantage</strong> of this approach is that it is cross-browser (Internet&nbsp;Explorer&nbsp;8 and later, <a href="http://en.wikipedia.org/wiki/WebKit" rel="noreferrer">WebKit</a>, and <a href="http://en.wikipedia.org/wiki/Gecko_%28layout_engine%29" rel="noreferrer">Gecko</a>). However, the <strong>disadvantage</strong> of this approach is that the options drop-down juts out on the right-hand-side (by the 20 pixels which we hid... because the option elements take the width of the select element).  

<img src="https://i.stack.imgur.com/Wyf6w.png" alt="Enter image description here">  

[It should be noted, however, that if the custom select element is necessary only for <strong>mobile</strong> devices - then the above problem doesn't apply - because of the way each phone natively opens the select element. So for mobile, this may be the best solution.]  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
.styled select {
  background: transparent;
  width: 150px;
  font-size: 16px;
  border: 1px solid #CCC;
  height: 34px;
}
.styled {
  margin: 50px;
  width: 120px;
  height: 34px;
  border: 1px solid #111;
  border-radius: 3px;
  overflow: hidden;
  background: url(http://www.stackoverflow.com/favicon.ico) 96% / 20% no-repeat #EEE;
}```
```html
<div class="styled">
  <select>
    <option>Pineapples</option>
    <option selected>Apples</option>
    <option>Chocklate</option>
    <option>Pancakes</option>
  </select>
</div>```
</div>
</div>


<hr/>

If the custom arrow is necessary on Firefox - prior to <a href="https://developer.mozilla.org/en-US/Firefox/Releases/35" rel="noreferrer">Version 35</a> - but you don't need to support old versions of Internet&nbsp;Explorer - then keep reading...  

Solution #3 - Use the `pointer-events` property (<a href="http://jsfiddle.net/danield770/sNwrs/2101/" rel="noreferrer">demo</a>)  

--  

<a href="http://lea.verou.me/2011/03/custom-select-drop-downs-with-css3/" rel="noreferrer">(Read more here)</a>  

The idea here is to overlay an element over the native drop down arrow (to create our custom one) and then disallow pointer events on it.  

<strong>Advantage:</strong> It works well in WebKit and Gecko. It looks good too (no jutting out `option` elements).  

<strong>Disadvantage:</strong> Internet&nbsp;Explorer (Internet&nbsp;Explorer 10 and down) doesn't support `pointer-events`, which means you can't click the custom arrow. Also, another (obvious) disadvantage with this method is that you can't target your new arrow image with a hover effect or hand cursor, because we have just disabled pointer events on them!  

However, with this method you can use Modernizer or conditional comments to make Internet&nbsp;Explorer revert to the standard built in arrow.  

<strong>NB:</strong> Being that Internet&nbsp;Explorer 10 doesn't support `conditional comments` anymore: If you want to use this approach, you should probably use <strong>Modernizr</strong>. However, it is still possible to exclude the pointer-events CSS from Internet&nbsp;Explorer 10 with a CSS hack described <a href="https://stackoverflow.com/a/14916454/703717">here</a>.  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
.notIE {
  position: relative;
  display: inline-block;
}
select {
  display: inline-block;
  height: 30px;
  width: 150px;
  outline: none;
  color: #74646E;
  border: 1px solid #C8BFC4;
  border-radius: 4px;
  box-shadow: inset 1px 1px 2px #DDD8DC;
  background: #FFF;
}
/* Select arrow styling */

.notIE .fancyArrow {
  width: 23px;
  height: 28px;
  position: absolute;
  display: inline-block;
  top: 1px;
  right: 3px;
  background: url(http://www.stackoverflow.com/favicon.ico) right / 90% no-repeat #FFF;
  pointer-events: none;
}
/*target Internet Explorer 9 and Internet Explorer 10:*/

@media screen and (min-width: 0\0) {
  .notIE .fancyArrow {
    display: none;
  }
}```
```html
<!--[if !IE]> -->
<div class="notIE">
  <!-- <![endif]-->
  <span class="fancyArrow"></span>
  <select>
    <option>Apples</option>
    <option selected>Pineapples</option>
    <option>Chocklate</option>
    <option>Pancakes</option>
  </select>
  <!--[if !IE]> -->
</div>
<!-- <![endif]-->```
</div>
</div>


#### Answer 2 (score 230)
It is possible, but unfortunately mostly in WebKit-based browsers to the extent we, as developers, require. Here is the example of CSS styling gathered from Chrome options panel via built-in developer tools inspector, improved to match currently supported CSS properties in most modern browsers:  

```html
select {
    -webkit-appearance: button;
    -moz-appearance: button;
    -webkit-user-select: none;
    -moz-user-select: none;
    -webkit-padding-end: 20px;
    -moz-padding-end: 20px;
    -webkit-padding-start: 2px;
    -moz-padding-start: 2px;
    background-color: #F07575; /* Fallback color if gradients are not supported */
    background-image: url(../images/select-arrow.png), -webkit-linear-gradient(top, #E5E5E5, #F4F4F4); /* For Chrome and Safari */
    background-image: url(../images/select-arrow.png), -moz-linear-gradient(top, #E5E5E5, #F4F4F4); /* For old Firefox (3.6 to 15) */
    background-image: url(../images/select-arrow.png), -ms-linear-gradient(top, #E5E5E5, #F4F4F4); /* For pre-releases of Internet Explorer  10*/
    background-image: url(../images/select-arrow.png), -o-linear-gradient(top, #E5E5E5, #F4F4F4); /* For old Opera (11.1 to 12.0) */
    background-image: url(../images/select-arrow.png), linear-gradient(to bottom, #E5E5E5, #F4F4F4); /* Standard syntax; must be last */
    background-position: center right;
    background-repeat: no-repeat;
    border: 1px solid #AAA;
    border-radius: 2px;
    box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.1);
    color: #555;
    font-size: inherit;
    margin: 0;
    overflow: hidden;
    padding-top: 2px;
    padding-bottom: 2px;
    text-overflow: ellipsis;
    white-space: nowrap;
}
```

When you run this code on any page within a WebKit-based browser it should change the appearance of the select box, remove standard OS-arrow and add a PNG-arrow, put some spacing before and after the label, almost anything you want.  

The most important part is `appearance` property, which changes how the element behaves.  

It works perfectly in almost all WebKit-based browser, including mobile ones, though Gecko doesn't support `appearance` as well as WebKit, it seems.  

#### Answer 3 (score 62)
The select element and its dropdown feature <em>are</em> difficult to style.  

<em><a href="http://archivist.incutio.com/viewlist/css-discuss/39858" rel="noreferrer">style attributes for select element</a></em> by Chris Heilmann confirms what Ryan Dohery said in a comment to the first answer:  

<blockquote>
  <p>"The select element is part of the 
  operating system, not the browser chrome. Therefore, it is very 
  unreliable to style, and it does not necessarily make sense to try 
  anyway."</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: How do I give text or an image a transparent background using CSS? (score [1510757](https://stackoverflow.com/q/806000) in 2016)

#### Question
Is it possible, using CSS only, to make the `background` of an element semi-transparent but have the content (text &amp; images) of the element opaque?  

I'd like to accomplish this without having the text and the background as two separate elements.  

When trying:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
p {
  position: absolute;
  background-color: green;
  filter: alpha(opacity=60);
  opacity: 0.6;
}

span {
  color: white;
  filter: alpha(opacity=100);
  opacity: 1;
}```
```html
<p>
  <span>Hello world</span>
</p>```
</div>
</div>


It looks like child elements are subjected to the opacity of their parents, so `opacity:1` is relative to the `opacity:0.6` of the parent.  

#### Answer accepted (score 2228)
Either use a semi-transparent <a href="http://en.wikipedia.org/wiki/Portable_Network_Graphics" rel="noreferrer">PNG</a> image or use CSS&nbsp;3:  

```html
background-color: rgba(255, 0, 0, 0.5);
```

Here's an article from css3.info, <em><a href="http://www.css3.info/opacity_rgba_and_compromise/" rel="noreferrer">Opacity, RGBA and compromise</a></em> (2007-06-03).  

<hr>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<p style="background-color: rgba(255, 0, 0, 0.5);">
  <span>Hello, World!</span>
</p>```
</div>
</div>


#### Answer 2 (score 469)
In Firefox 3 and Safari 3, you can use RGBA like <a href="https://stackoverflow.com/questions/806000/css-semi-transparent-background-but-not-text/806189#806189">Georg Schölly mentioned</a>.  

A little known trick is that you can use it in Internet&nbsp;Explorer as well using the gradient filter.  

```html
background-color: rgba(0, 255, 0, 0.5);
filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#7F00FF00', EndColorStr='#7F00FF00');
```

The first hex number defines the alpha value of the color.  

Full solution all browsers:  

```html
.alpha60 {
    /* Fallback for web browsers that doesn't support RGBa */
    background: rgb(0, 0, 0) transparent;
    /* RGBa with 0.6 opacity */
    background: rgba(0, 0, 0, 0.6);
    /* For IE 5.5 - 7*/
    filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);
    /* For IE 8*/
    -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";
}
```

This is from <em><a href="http://robertnyman.com/2010/01/11/css-background-transparency-without-affecting-child-elements-through-rgba-and-filters/" rel="noreferrer">CSS background transparency without affecting child elements, through RGBa and filters</a></em>.  

<h5>Screenshots proof of results:</h2>

<p>This is when using the following code:
     
     </p>

```html
 <head>
     <meta http-equiv="X-UA-Compatible" content="IE=edge" >
    <title>An XHTML 1.0 Strict standard template</title>
     <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <style type="text/css" media="all">
         .transparent-background-with-text-and-images-on-top {
             background: rgb(0, 0, 0) transparent;   /* Fallback for web browsers that doesn't support RGBa */
            background: rgba(0, 0, 0, 0.6);   /* RGBa with 0.6 opacity */
             filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);  /* For IE 5.5 - 7*/
            -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";  /* For IE 8*/
         }
     </style>
 </head>

 <body>
     <div class="transparent-background-with-text-and-images-on-top">
         <p>Here some content (text AND images) "on top of the transparent background"</p>
        <img src="http://i.imgur.com/LnnghmF.gif">
     </div>
 </body>
 </html>
```

<p><img src="https://i.stack.imgur.com/BgkgK.png" alt="Chrome-33">
<img src="https://i.stack.imgur.com/KsGgH.png" alt="IE11">
<img src="https://i.stack.imgur.com/6Zscy.png" alt="IE9">
<img src="https://i.imgur.com/EyiPD0M.png" alt="IE8"></p>

#### Answer 3 (score 104)
This is the best solution I could come up with, NOT using CSS 3. And it works great on Firefox, Chrome and Internet Explorer as far as I can see.  

<p>Put a container DIV and two child DIVs in the same level, one for content, one for background.
And using CSS, auto-size the background to fit the content and put the background actually in the back using z-index.</p>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
.container {
  position: relative;
}
.content {
  position: relative;
  color: White;
  z-index: 5;
}
.background {
  position: absolute;
  top: 0px;
  left: 0px;
  width: 100%;
  height: 100%;
  background-color: Black;
  z-index: 1;
  /* These three lines are for transparency in all browsers. */
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=50)";
  filter: alpha(opacity=50);
  opacity: .5;
}```
```html
<div class="container">
  <div class="content">
    Here is the content.
    <br/>Background should grow to fit.
  </div>
  <div class="background"></div>
</div>```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 29: How to allow only numeric (0-9) in HTML  inputbox using jQuery? (score [1469327](https://stackoverflow.com/q/995183) in 2011)

#### Question
I am creating a web page where I have an input text field in which I want to allow only numeric characters like (0,1,2,3,4,5...9) 0-9.  

How can I do this using jQuery?  

#### Answer accepted (score 1215)
<sup><strong>Note:</strong> This is an updated answer. Comments below refer to an old version which messed around with keycodes.</sup>  

<h5>jQuery</h1>

The `inputFilter` plugin below allows you to use <strong>any</strong> kind of input filter on a text `&lt;input&gt;`, including various numeric filters (see below).  

Unlike most other solutions, this <strong>correctly supports</strong> Copy+Paste, Drag+Drop, all keyboard shortcuts, all context menu operations, all non-typeable keys (e.g. cursor and navigation keys), the caret position, all keyboard layouts of all languages and platforms, and <a href="https://caniuse.com/#search=oninput" rel="noreferrer">all browsers since IE 9</a>.  

<strong>Try it yourself <a href="https://jsfiddle.net/emkey08/tvx5e7q3" rel="noreferrer">on JSFiddle</a>.</strong>  

```html
// Restricts input for each element in the set of matched elements to the given inputFilter.
(function($) {
  $.fn.inputFilter = function(inputFilter) {
    return this.on("input keydown keyup mousedown mouseup select contextmenu drop", function() {
      if (inputFilter(this.value)) {
        this.oldValue = this.value;
        this.oldSelectionStart = this.selectionStart;
        this.oldSelectionEnd = this.selectionEnd;
      } else if (this.hasOwnProperty("oldValue")) {
        this.value = this.oldValue;
        this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
      }
    });
  };
}(jQuery));

$(document).ready(function() {
  // Restrict input to digits by using a regular expression filter.
  $("#myTextBox").inputFilter(function(value) {
    return /^\d*$/.test(value);
  });
});
```

Some input filters you might want to use:  

<ul>
<li><strong>Integer</strong> values (positive only):<br/>
`/^\d*$/.test(value)`</li>
<li><strong>Integer</strong> values (positive and up to a particular limit):<br/>
`/^\d*$/.test(value) &amp;&amp; (value === "" || parseInt(value) &lt;= 500)`</li>
<li><strong>Integer</strong> values (both positive and negative):<br/>
`/^-?\d*$/.test(value)`</li>
<li><strong>Floating point</strong> values (allowing both `.` and `,` as decimal separator):<br/>
`/^-?\d*[.,]?\d*$/.test(value)`</li>
<li><strong>Currency</strong> values (i.e. at most two decimal places):<br/>
`/^-?\d*[.,]?\d{0,2}$/.test(value)`</li>
<li><strong>A-Z</strong> only (i.e. basic Latin letters):<br/>
`/^[a-z]*$/i.test(value)`</li>
<li><strong>Latin letters</strong> only (i.e. English and most European languages, see <a href="https://unicode-table.com" rel="noreferrer">https://unicode-table.com</a> for details about Unicode character ranges):<br/>
`/^[a-z\u00c0-\u024f]*$/i.test(value)`</li>
<li><strong>Hexadecimal</strong> values:<br/>
`/^[0-9a-f]*$/i.test(value)`</li>
</ul>

<strong>Note that you still <em>must</em> do server side validation!</strong>  

<h5>Pure JavaScript (without jQuery)</h1>

jQuery isn't actually needed for this, you can do the same thing with pure JavaScript as well. See <a href="https://stackoverflow.com/a/469362/1070129">this answer</a> or try it yourself <a href="https://jsfiddle.net/emkey08/zgvtjc51" rel="noreferrer">on JSFiddle</a>.  

<h5>HTML 5</h1>

HTML 5 has a native solution with `&lt;input type="number"&gt;` (see the <a href="https://www.w3.org/TR/html/sec-forms.html#number-state-typenumber" rel="noreferrer">specification</a>), but note that browser support varies:  

<ul>
<li>Most browsers will only validate the input when submitting the form, and not when typing.</li>
<li><a href="https://caniuse.com/#feat=input-number" rel="noreferrer">Most mobile browsers</a> don't support the `step`, `min` and `max` attributes.</li>
<li>Chrome (version 71.0.3578.98) still allows the user to enter the characters `e` and `E` into the field. Also see <a href="https://stackoverflow.com/q/31706611">this question</a>.</li>
<li>Firefox (version 64.0) and Edge (EdgeHTML version 17.17134) still allow the user to enter <em>any</em> text into the field.</li>
</ul>

Try it yourself <a href="http://www.w3schools.com/html/tryit.asp?filename=tryhtml5_input_type_number" rel="noreferrer">on w3schools.com</a>.  

#### Answer 2 (score 173)
Here is the function I use:  

```html
// Numeric only control handler
jQuery.fn.ForceNumericOnly =
function()
{
    return this.each(function()
    {
        $(this).keydown(function(e)
        {
            var key = e.charCode || e.keyCode || 0;
            // allow backspace, tab, delete, enter, arrows, numbers and keypad numbers ONLY
            // home, end, period, and numpad decimal
            return (
                key == 8 || 
                key == 9 ||
                key == 13 ||
                key == 46 ||
                key == 110 ||
                key == 190 ||
                (key >= 35 && key <= 40) ||
                (key >= 48 && key <= 57) ||
                (key >= 96 && key <= 105));
        });
    });
};
```

You can then attach it to your control by doing:  

```html
$("#yourTextBoxName").ForceNumericOnly();
```

#### Answer 3 (score 141)
Inline:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<input name="number" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')">```
</div>
</div>


Unobtrusive style (with jQuery):  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
$('input[name="number"]').keyup(function(e)
                                {
  if (/\D/g.test(this.value))
  {
    // Filter non-digits from input value.
    this.value = this.value.replace(/\D/g, '');
  }
});```
```html
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<input name="number">```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 30: Hide scroll bar, but while still being able to scroll (score [1456454](https://stackoverflow.com/q/16670931) in 2018)

#### Question
I want to be able to scroll through the whole page, but without the scrollbar being shown.  

In Google Chrome it's:  

```html
::-webkit-scrollbar { 
    display: none; 
}
```

But Mozilla Firefox and Internet Explorer don't seem to work like that.  

I also tried this in CSS:  

```html
overflow: hidden;
```

That does hide the scrollbar, but I can't scroll anymore.  

<p>Is there any way I can remove the scrollbar while still being able to scroll the whole page?
With just CSS or HTML, please.</p>

#### Answer accepted (score 720)
Just a test which is working fine.  

```html
#parent{
    width: 100%;
    height: 100%;
    overflow: hidden;
}

#child{
    width: 100%;
    height: 100%;
    overflow-y: scroll;
    padding-right: 17px; /* Increase/decrease this value for cross-browser compatibility */
    box-sizing: content-box; /* So the width will be 100% + 17px */
}
```

<strong><a href="http://jsfiddle.net/5GCsJ/954/" rel="noreferrer">Working Fiddle</a></strong>  

<h5>JavaScript:</h3>

Since, the scrollbar width differs in different browsers, it is better to handle it with JavaScript. If you do `Element.offsetWidth - Element.clientWidth`, the exact scrollbar width will show up.  

<strong><a href="http://jsfiddle.net/5GCsJ/4713/" rel="noreferrer">JavaScript Working Fiddle</a></strong>  

<h5>or</h2>

Using `Position: absolute`,  

```html
#parent{
    width: 100%;
    height: 100%;
    overflow: hidden;
    position: relative;
}

#child{
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: -17px; /* Increase/Decrease this value for cross-browser compatibility */
    overflow-y: scroll;
}
```

<strong><a href="http://jsfiddle.net/5GCsJ/2125/" rel="noreferrer">Working Fiddle</a></strong>  

<a href="http://jsfiddle.net/5GCsJ/4714/" rel="noreferrer"><strong>JavaScript Working Fiddle</strong></a>  

<h5>Info:</h3>

Based on this answer, I created a <a href="https://github.com/kamlekar/slim-scroll" rel="noreferrer">simple scroll plugin</a>. I hope this will help someone.  

#### Answer 2 (score 318)
It is easy in WebKit, with optional styling:  

```html
html {
    overflow: scroll;
    overflow-x: hidden;
}
::-webkit-scrollbar {
    width: 0px;  /* Remove scrollbar space */
    background: transparent;  /* Optional: just make scrollbar invisible */
}
/* Optional: show position indicator in red */
::-webkit-scrollbar-thumb {
    background: #FF0000;
}
```

#### Answer 3 (score 214)
This works for me with simple CSS properties:  

```html
.container {
    -ms-overflow-style: none;  // IE 10+
    scrollbar-width: none;  // Firefox
}
.container::-webkit-scrollbar { 
    display: none;  // Safari and Chrome
}
```

<strong>UPDATED:</strong> added the new `scrollbar-width` property for Firefox.  

For older versions of Firefox, use: `overflow: -moz-scrollbars-none;`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: jQuery disable/enable submit button (score [1455050](https://stackoverflow.com/q/1594952) in 2019)

#### Question
I have this HTML:  

```html
<input type="text" name="textField" />
<input type="submit" value="send" />
```

How can I do something like this:  

<ul>
<li>When the text field is empty the submit should be disabled (disabled="disabled").</li>
<li>When something is typed in the text field to remove the disabled attribute.</li>
<li>If the text field becomes empty again(the text is deleted) the submit button should be disabled again.</li>
</ul>

I tried something like this:  

```html
$(document).ready(function(){
    $('input[type="submit"]').attr('disabled','disabled');
    $('input[type="text"]').change(function(){
        if($(this).val != ''){
            $('input[type="submit"]').removeAttr('disabled');
        }
    });
});
```

…but it doesn't work. Any ideas?  

#### Answer accepted (score 1132)
The problem is that the change event fires only when focus is moved away from the input (e.g. someone clicks off the input or tabs out of it).  Try using keyup instead:  

```html
$(document).ready(function() {
     $(':input[type="submit"]').prop('disabled', true);
     $('input[type="text"]').keyup(function() {
        if($(this).val() != '') {
           $(':input[type="submit"]').prop('disabled', false);
        }
     });
 });
```

#### Answer 2 (score 124)
```html
$(function() {
  $(":text").keypress(check_submit).each(function() {
    check_submit();
  });
});

function check_submit() {
  if ($(this).val().length == 0) {
    $(":submit").attr("disabled", true);
  } else {
    $(":submit").removeAttr("disabled");
  }
}
```

#### Answer 3 (score 76)
This question is 2 years old but it's still a good question and it was the first Google result ... but all of the existing answers recommend setting and <strong>removing</strong> the HTML <strong>attribute</strong> (removeAttr("disabled")) "disabled", which is not the right approach. There is a lot of confusion regarding attribute vs. property.  

<h5>HTML</h2>

The "disabled" in `&lt;input type="button" disabled&gt;` in the markup <a href="http://www.w3.org/TR/html5/forms.html#attr-fe-disabled" rel="noreferrer">is called a <em>boolean attribute</em> by the W3C</a>.  

<h5>HTML vs. DOM</h2>

Quote:  

<blockquote>
  A property is in the DOM; an attribute is in the HTML that is parsed into the DOM.  
</blockquote>

<a href="https://stackoverflow.com/a/7572855/664132">https://stackoverflow.com/a/7572855/664132</a>  

<h5>JQuery</h2>

Related:  

<blockquote>
  Nevertheless, the most important concept to remember about the checked attribute is that it does not correspond to the checked property. The <strong>attribute</strong> actually corresponds to the defaultChecked property and <strong>should be used only to set the initial value</strong> of the checkbox. The checked attribute value does not change with the state of the checkbox, while the checked property does. Therefore, the cross-browser-compatible way to determine if a checkbox is checked is to use the property...  
</blockquote>

Relevant:  

<blockquote>
  Properties generally affect the dynamic state of a DOM element without changing the serialized HTML attribute. Examples include the value property of input elements, the <strong>disabled property</strong> of inputs and buttons, or the checked property of a checkbox. <strong>The .prop() method should be used to set disabled and checked instead of the .attr() method.</strong>  
</blockquote>

```html
$( "input" ).prop( "disabled", false );
```

<h5>Summary</h2>

<strong>To [...] change DOM properties such as the [...] disabled state of form elements, use the <a href="http://api.jquery.com/prop/" rel="noreferrer">.prop()</a> method.</strong>  

(<a href="http://api.jquery.com/attr/" rel="noreferrer">http://api.jquery.com/attr/</a>)  

<hr>

As for the disable on change part of the question: There is an event called "input", but <a href="https://developer.mozilla.org/en-US/docs/Web/Events/input" rel="noreferrer">browser support is limited</a> and it's not a jQuery event, so jQuery won't make it work. The change event works reliably, but is fired when the element loses focus. So one might combine the two (some people also listen for keyup and paste).  

Here's an untested piece of code to show what I mean:  

```html
$(document).ready(function() {
    var $submit = $('input[type="submit"]');
    $submit.prop('disabled', true);
    $('input[type="text"]').on('input change', function() { //'input change keyup paste'
        $submit.prop('disabled', !$(this).val().length);
    });
});
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: How to replace innerHTML of a div using jQuery? (score [1425674](https://stackoverflow.com/q/1309452) in 2016)

#### Question
How could I achieve the following:  

```html
document.all.regTitle.innerHTML = 'Hello World';
```

Using jQuery where `regTitle` is my div ID?  

#### Answer accepted (score 1461)
```html
$("#regTitle").html("Hello World");
```

#### Answer 2 (score 313)
The <a href="http://docs.jquery.com/Attributes/html#val" rel="noreferrer">html()</a> function can take strings of HTML, and will effectively modify the `.innerHTML` property.  

```html
$('#regTitle').html('Hello World');
```

However, the <a href="http://api.jquery.com/text" rel="noreferrer">text()</a> function will change the (text) value of the specified element, but keep the `html` structure.  

```html
$('#regTitle').text('Hello world'); 
```

#### Answer 3 (score 65)
If you instead have a jquery object you want to render instead of the existing content. Then just reset the content and append the new.  

```html
var itemtoReplaceContentOf = $('#regTitle');
itemtoReplaceContentOf.html('');
newcontent.appendTo(itemtoReplaceContentOf);
```

Or:  

```html
$('#regTitle').empty().append(newcontent);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: Resize image proportionally with CSS? (score [1398643](https://stackoverflow.com/q/787839) in 2018)

#### Question
Is there a way to resize (scale down) images proportionally using ONLY CSS?  

I'm doing the JavaScript way, but just trying to see if this is possible with CSS.  

#### Answer 2 (score 743)
To resize the image proportionally using CSS:  

```html
img.resize {
    width:540px; /* you can use % */
    height: auto;
}
```

#### Answer 3 (score 217)
Control size and maintain proportion :  

```html
#your-img {
    height: auto; 
    width: auto; 
    max-width: 300px; 
    max-height: 300px;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: vertical-align with Bootstrap 3 (score [1388358](https://stackoverflow.com/q/20547819) in 2015)

#### Question
I'm using Twitter Bootstrap 3, and I have problems when I want to align vertically two `div`, for example — <a href="http://jsfiddle.net/corinem/CQstd/">JSFiddle link</a>:  

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
```html
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<div class="row">
  <div class="col-xs-5">
    <div style="height:5em;border:1px solid #000">Big</div>
  </div>
  <div class="col-xs-5">
    <div style="height:3em;border:1px solid #F00">Small</div>
  </div>
</div>```
</div>
</div>


The grid system in Bootstrap uses `float: left`, not `display:inline-block`, so the property `vertical-align` doesn't work. I tried using `margin-top` to fix it, but I think this is not a good solution for the responsive design.  

#### Answer accepted (score 908)
<blockquote>
  This answer presents a hack, but I would highly recommend you to use flexbox (as stated in <a href="https://stackoverflow.com/a/25517025/1238019">@Haschem answer</a>), since it's now supported everywhere.  
</blockquote>



<blockquote>
  <p><strong>Demos link:</strong> <br/>
  - <a href="https://www.bootply.com/jTZdTJGVzq" rel="noreferrer">Bootstrap 3</a> <br/>
  - <a href="http://www.bootply.com/IXiEbZlLvP" rel="noreferrer">Bootstrap 4 alpha 6</a> <br/></p>
</blockquote>

You still can use a custom class when you need it:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
.vcenter {
    display: inline-block;
    vertical-align: middle;
    float: none;
}```
```html
<div class="row">
    <div class="col-xs-5 col-md-3 col-lg-1 vcenter">
        <div style="height:10em;border:1px solid #000">Big</div>
    </div><!--
    --><div class="col-xs-5 col-md-7 col-lg-9 vcenter">
        <div style="height:3em;border:1px solid #F00">Small</div>
    </div>
</div>```
</div>
</div>


<strong><a href="http://www.bootply.com/dFP81frbHk" rel="noreferrer">Bootply</a></strong>  

Using `inline-block` adds extra space between blocks if you let a real space in your code (like `...&lt;/div&gt; &lt;/div&gt;...`). This extra space breaks our grid if column sizes add up to 12:  

```html
<div class="row">
    <div class="col-xs-6 col-md-4 col-lg-2 vcenter">
        <div style="height:10em;border:1px solid #000">Big</div>
    </div>
    <div class="col-xs-6 col-md-8 col-lg-10 vcenter">
        <div style="height:3em;border:1px solid #F00">Small</div>
    </div>
</div>
```

Here, we've got extra spaces between `&lt;div class="[...] col-lg-2"&gt;` and `&lt;div class="[...] col-lg-10"&gt;` (a carriage return and 2 tabs/8 spaces). And so...  

<img src="https://i.stack.imgur.com/2Yzby.png" alt="Enter image description here">  

Let's kick this extra space!!  

```html
<div class="row">
    <div class="col-xs-6 col-md-4 col-lg-2 vcenter">
        <div style="height:10em;border:1px solid #000">Big</div>
    </div><!--
    --><div class="col-xs-6 col-md-8 col-lg-10 vcenter">
        <div style="height:3em;border:1px solid #F00">Small</div>
    </div>
</div>
```

<img src="https://i.stack.imgur.com/XZTJj.png" alt="Enter image description here">  

Notice the <em>seemingly</em> useless comments `&lt;!-- ... --&gt;`? They are <strong>important</strong> -- without them, the whitespace between the `&lt;div&gt;` elements will take up space in the layout, breaking the grid system.  

<em>Note: the Bootply has been updated</em>  

#### Answer 2 (score 873)
<h5>Flexible box layout</h2>

With the advent of the <a href="http://www.w3.org/TR/css-flexbox-1/" rel="noreferrer">CSS Flexible Box</a>, many of web designers' nightmares<sup>1</sup> have been resolved. One of the most hacky ones, the vertical alignment. Now it is possible even in <strong>unknown heights</strong>.  

<blockquote>
  <p>"Two decades of layout hacks are coming to an end. Maybe not tomorrow,
  but soon, and for the rest of our lives."</p>
  
  — CSS Legendary <a href="http://meyerweb.com/" rel="noreferrer">Eric Meyer</a> at <a href="http://www.w3.org/conf/2013sf/" rel="noreferrer">W3Conf 2013</a>  
</blockquote>

Flexible Box (or in short, Flexbox), is a new layout system that is specifically designed for layout purposes. The <a href="http://www.w3.org/TR/css-flexbox-1/#overview" rel="noreferrer">specification states</a>:  

<blockquote>
  <p>Flex layout is superficially similar to block layout. It lacks many of
  the more complex text- or document-centric properties that can be used
  in block layout, such as floats and columns. In return it gains simple
  and powerful tools for distributing space and aligning content in ways
  that webapps and complex web pages often need.</p>
</blockquote>

How can it help in this case? Well, let's see.  

<hr>

<h5>Vertical aligned columns</h1>

Using Twitter Bootstrap we have `.row`s having some `.col-*`s. All we need to do is to display the desired `.row`<sup>2</sup> as a <a href="http://www.w3.org/TR/css-flexbox-1/#flex-container" rel="noreferrer">flex container</a> box and then align all its <a href="http://www.w3.org/TR/css-flexbox-1/#flex-item" rel="noreferrer">flex item</a>s (the columns) vertically by <a href="http://www.w3.org/TR/css-flexbox-1/#align-items-property" rel="noreferrer">`align-items`</a> property.  

<a href="http://codepen.io/hashem/pen/Lsprw?editors=110" rel="noreferrer"><strong>EXAMPLE HERE</strong></a> <em>(Please read the comments with care)</em>  

```html
<div class="container">
    <div class="row vertical-align"> <!--
                    ^--  Additional class -->
        <div class="col-xs-6"> ... </div>
        <div class="col-xs-6"> ... </div>
    </div>
</div>
```

```html
.vertical-align {
    display: flex;
    align-items: center;
}
```

<h5>The Output</h3>

<img src="https://i.stack.imgur.com/cvLaI.jpg" alt="Vertical aligned columns in Twitter Bootstrap">  

<em>Colored area displays the padding-box of columns.</em>  

<h5>Clarifying on `align-items: center`</h3>

<blockquote>
  <strong><a href="http://www.w3.org/TR/css-flexbox-1/#align-items-property" rel="noreferrer">8.3 Cross-axis Alignment: the `align-items` property</a></strong>  
  
  <a href="http://www.w3.org/TR/css-flexbox-1/#flex-item" rel="noreferrer">Flex items</a> can be aligned in the <a href="http://www.w3.org/TR/css-flexbox-1/#cross-axis" rel="noreferrer">cross axis</a> of the current line of the flex container, similar to <a href="http://www.w3.org/TR/css-flexbox-1/#propdef-justify-content" rel="noreferrer">`justify-content`</a> but in the perpendicular direction. <a href="http://www.w3.org/TR/css-flexbox-1/#propdef-align-items" rel="noreferrer">`align-items`</a> sets the default alignment for all of the flex container’s items, including anonymous <a href="http://www.w3.org/TR/css-flexbox-1/#flex-item" rel="noreferrer">flex items</a>.  
  
  <p>`align-items: center;`
  By center value, the <a href="http://www.w3.org/TR/css-flexbox-1/#flex-item" rel="noreferrer">flex item</a>’s margin box is centered in the <a href="http://www.w3.org/TR/css-flexbox-1/#cross-axis" rel="noreferrer">cross axis</a> within the line.</p>
</blockquote>

<hr>

<h5>Big Alert</h2>

<strong>Important note #1:</strong> Twitter Bootstrap doesn't specify the `width` of columns in extra small devices unless you give one of `.col-xs-#` classes to the columns.  

Therefore in this particular demo, I have used `.col-xs-*` classes in order for columns to be displayed properly in mobile mode, because it specifies the `width` of the column explicitly.  

But alternatively you could <strong>switch off</strong> the Flexbox layout simply by changing `display: flex;` to `display: block;` in specific screen sizes. For instance:  

```html
/* Extra small devices (767px and down) */
@media (max-width: 767px) {
    .row.vertical-align {
        display: block; /* Turn off the flexible box layout */
    }
}
```

Or you could <a href="http://jsfiddle.net/hashem/g6puyohg/6/" rel="noreferrer">specify `.vertical-align` <strong>only</strong> on specific screen sizes</a> like so:  

```html
/* Small devices (tablets, 768px and up) */
@media (min-width: 768px) {
    .row.vertical-align {
        display: flex;
        align-items: center;
    }
}
```

In that case, I'd go with <a href="https://stackoverflow.com/users/482256/kevin-nelson">@KevinNelson</a>'s <a href="https://stackoverflow.com/a/27771750/1725764">approach</a>.  

<strong>Important note #2:</strong> Vendor prefixes omitted due to brevity. Flexbox syntax has been changed during the time. The new written syntax won't work on older versions of web browsers (but not that old as Internet&nbsp;Explorer&nbsp;9! Flexbox is supported on Internet&nbsp;Explorer&nbsp;10 and later).  

This means you should also use vendor-prefixed properties like `display: -webkit-box` and so on in production mode.  

If you click on <em>"Toggle Compiled View"</em> in the <a href="http://codepen.io/hashem/pen/Lsprw?editors=110" rel="noreferrer">Demo</a>, you'll see the prefixed version of CSS declarations (thanks to <a href="https://github.com/ai/autoprefixer" rel="noreferrer">Autoprefixer</a>).  

<hr>

<h5>Full-height columns with vertical aligned contents</h1>

As you see in the <a href="http://codepen.io/hashem/pen/Lsprw?editors=110" rel="noreferrer">previous demo</a>, columns (the flex items) are no longer as high as their container (the flex container box. i.e. the `.row` element).  

This is because of using `center` value for `align-items` property. The default value is `stretch` so that the items can fill the entire height of the parent element.  

In order to fix that, you can add `display: flex;` to the columns as well:  

<strong><a href="http://codepen.io/hashem/pen/zwJaE" rel="noreferrer">EXAMPLE HERE</a></strong> <em>(Again, mind the comments)</em>  

```html
.vertical-align {
  display: flex;
  flex-direction: row;
}

.vertical-align > [class^="col-"],
.vertical-align > [class*=" col-"] {
  display: flex;
  align-items: center;     /* Align the flex-items vertically */
  justify-content: center; /* Optional, to align inner flex-items
                              horizontally within the column  */
}
```

<h5>The Output</h3>

<img src="https://i.stack.imgur.com/d2o3b.jpg" alt="Full-height columns with vertical aligned contents in Twitter Bootstrap">  

<em>Colored area displays the padding-box of columns.</em>  

<strong>Last, but not least</strong>, notice that the demos and code snippets here are meant to give you a different idea, to provide a modern approach to achieve the goal. Please mind the "<strong>Big Alert</strong>" section if you are going to use this approach in real world websites or applications.  

<hr>

For further reading including browser support, these resources would be useful:  

<ul>
<li><a href="https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Flexible_boxes" rel="noreferrer">Mozilla Developer Network - Flexible boxes</a></li>
<li><a href="http://css-tricks.com/snippets/css/a-guide-to-flexbox/" rel="noreferrer">Guide To Flexbox - CSS Tricks</a></li>
<li><a href="http://www.html5rocks.com/en/tutorials/flexbox/quick/" rel="noreferrer">HTML5Rocks - Flexbox quick</a></li>
<li><a href="http://www.smashingmagazine.com/2013/05/22/centering-elements-with-flexbox/" rel="noreferrer">SmashingMagazine - Centering Elements with Flexbox</a></li>
<li><a href="http://philipwalton.github.io/solved-by-flexbox/" rel="noreferrer">Philip Walton - Solved By Flexbox</a></li>
<li><a href="http://caniuse.com/#feat=flexbox" rel="noreferrer">Can I Use: Flexible Box Layout Module</a></li>
</ul>

<hr>

<p><sup>1. <a href="https://stackoverflow.com/questions/18516317/vertically-align-an-image-inside-a-div-with-responsive-height/18516474#18516474">Vertically align an image inside a div with responsive height</a></sup>
<sup>2. It's better to use an additional class in order not to alter Twitter Bootstrap's  default `.row`.</sup></p>

#### Answer 3 (score 45)
The below code worked for me:  

```html
.vertical-align {
    display: flex;
    align-items: center;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: How do I make a placeholder for a 'select' box? (score [1375841](https://stackoverflow.com/q/5805059) in 2019)

#### Question
I'm using placeholders for text inputs which is working out just fine. But I'd like to use a placeholder for my selectboxes as well. Of course I can just use this code:  

```html
<select>
    <option value="">Select your option</option>
    <option value="hurr">Durr</option>
</select>
```

But the 'Select your option' is in black instead of lightgrey. So my solution could possibly be CSS-based. jQuery is fine too.  

This only makes the option grey in the dropdown (so after clicking the arrow):  

```html
option:first {
    color: #999;
}
```

The question is: How do people create placeholders in selectboxes? But it has already been answered, cheers.  

And using this results in the selected value always being grey (even after selecting a real option):  

```html
select {
    color: #999;
}
```

#### Answer accepted (score 2790)
A non-CSS - no JavaScript/jQuery answer:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
<select>
    <option value="" disabled selected>Select your option</option>
    <option value="hurr">Durr</option>
</select>```
</div>
</div>


#### Answer 2 (score 757)
I just stumbled across this question, and here's what works in Firefox and Chrome (at least):  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
<style>
select:invalid { color: gray; }
</style>
<form>
<select required>
    <option value="" disabled selected hidden>Please Choose...</option>
    <option value="0">Open when powered (most valves do this)</option>
    <option value="1">Closed when powered, auto-opens when power is cut</option>
</select>
</form>```
</div>
</div>


The <em>Disabled</em> option stops the `&lt;option&gt;` being selected with both mouse and keyboard, whereas just using `'display:none'` allows the user to still select via the keyboard arrows. The `'display:none'` style just makes the list box look 'nice'.  

Note: Using an empty `value` attribute on the "placeholder" option allows validation (required attribute) to work around having the "placeholder", so if the option isn't changed, but is required, the browser should prompt the user to choose an option from the list.  

<strong>Update (July 2015):</strong>  

This method is confirmed working in the following browsers:  

<ul>
<li>Google Chrome - v.43.0.2357.132</li>
<li>Mozilla Firefox - v.39.0</li>
<li>Safari - v.8.0.7 (the placeholder is visible in dropdown, but it is not selectable)</li>
<li>Microsoft Internet Explorer - v.11 (Placeholder is visible in dropdown but is not selectable)</li>
<li>Project Spartan - v.15.10130 (the placeholder is visible in dropdown, but it is not selectable)</li>
</ul>

<strong>Update (October 2015):</strong>  

I removed the `style="display: none"` in favour of HTML5 attribute `hidden` which has wide support. The `hidden` element has similar traits as `display: none` in Safari, Internet&nbsp;Explorer, (Project Spartan needs checking) where the `option` is visible in dropdown, but it is not selectable.  

<strong>Update (January 2016):</strong>  

When the `select` element is `required` it allows use of the `:invalid` CSS pseudo-class which allows you to style the `select` element when in its "placeholder" state. `:invalid` works here because of the empty value in the placeholder `option`.  

Once a value has been set, the `:invalid` pseudo-class will be dropped. You can optionally also use `:valid` if you so wish.  

Most browsers support this pseudo-class. Internet&nbsp;Explorer&nbsp;10 and later. This works best with custom styled `select` elements; in some cases i.e. (Mac in Chrome / Safari) you'll need to change the default appearance of the `select` box so that certain styles display, i.e., `background-color` and `color`. You can find some examples and more about compatibility at <a href="https://developer.mozilla.org/en/docs/Web/CSS/:invalid" rel="noreferrer">developer.mozilla.org</a>.  

Native element appearance Mac in Chrome:  

<img src="https://i.stack.imgur.com/L6cVA.png" alt="Select box native Mac in Chrome">  

Using altered border element Mac in Chrome:  

<img src="https://i.stack.imgur.com/OWMDi.png" alt="Altered select box Mac in Chrome">  

#### Answer 3 (score 234)
For a required field, there is a pure-CSS solution in modern browsers:  

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
```html
select:required:invalid {
  color: gray;
}
option[value=""][disabled] {
  display: none;
}
option {
  color: black;
}```
```html
<select required>
  <option value="" disabled selected>Select something...</option>
  <option value="1">One</option>
  <option value="2">Two</option>
</select>```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 36: Adding a favicon to a static HTML page (score [1364820](https://stackoverflow.com/q/9943771) in 2019)

#### Question
I have a few static pages that are just pure HTML, that we display when the server goes down. How can I put a favicon that I made (it's 16x16px and it's sitting in the same directory as the HTML file; it's called favicon.ico) as the "tab" icon as it were? I have read up on Wikipedia and looked at a few tutorials and have implemented the following:  

```html
<link rel="icon" href="favicon.ico" type="image/x-icon"/>
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
```

But it still doesn't want to work. I am using Chrome to test the sites. According to Wikipedia .ico is the best picture format that runs on all browser types.  

<h5>Update</h2>

I could not get this to work locally although the code checks out it will only really work properly once the server started serving the site. Just try pushing it up to the server and refresh your cache and it should work fine.  

#### Answer accepted (score 840)
You can make a 16x16 .png and then use one of the following snippets between the `&lt;head&gt;` tags of your static HTML documents:  

```html
<link rel="shortcut icon" type="image/png" href="/favicon.png"/>
<link rel="shortcut icon" type="image/png" href="http://example.com/favicon.png"/>
```

#### Answer 2 (score 206)
Most browsers will pick up `favicon.ico` from the root directory of the site without needing to be told; but they don't always update it with a new one right away.  

However, I usually go for the second of your examples:  

```html
<link rel='shortcut icon' type='image/x-icon' href='/favicon.ico' />
```

#### Answer 3 (score 119)
Actually, to make your favicon work in all browsers, you must have more than 10 images in the correct sizes and formats.  

I created an App (<a href="http://faviconit.com">faviconit.com</a>) so people don´t have to create all these images and the correct tags by hand.  

Hope you like it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: How to select a radio button by default? (score [1364538](https://stackoverflow.com/q/5592345) in 2014)

#### Question
I have some radio buttons and I want one of them to be set as selected by default when the page is loaded. How can I do that?  

```html
<input type="radio" name="imgsel"  value=""  /> 
```

#### Answer accepted (score 1058)
XHTML solution:  

```html
<input type="radio" name="imgsel" value="" checked="checked" />
```

Please note, that the actual value of `checked` attribute does not actually matter; it's just a convention to assign `"checked"`. Most importantly, strings like `"true"` or `"false"` don't have any special meaning.  

If you don't aim for XHTML conformance, you can simplify the code to:  

```html
<input type="radio" name="imgsel" value="" checked>
```

#### Answer 2 (score 101)
Use the checked attribute.  

```html
<input type="radio" name="imgsel"  value="" checked /> 
```

or  

```html
<input type="radio" name="imgsel"  value="" checked="checked" /> 
```

#### Answer 3 (score 75)
This doesn't exactly answer the question but for anyone using AngularJS trying to achieve this, the answer is slightly different. And actually the normal answer won't work (at least it didn't for me).  

Your html will look pretty similar to the normal radio button:  

```html
<input type='radio' name='group' ng-model='mValue' value='first' />First
<input type='radio' name='group' ng-model='mValue' value='second' /> Second
```

In your controller you'll have declared the `mValue` that is associated with the radio buttons. To have one of these radio buttons preselected, assign the `$scope` variable associated with the group to the desired input's value:  

```html
$scope.mValue="second"
```

This makes the "second" radio button selected on loading the page.   

<strong>EDIT: Since AngularJS 2.x</strong>  

The above approach does not work if you're using version 2.x and above. Instead use `ng-checked` attribute as follows:  

```html
<input type='radio' name='gender' ng-model='genderValue' value='male' ng-checked='genderValue === male'/>Male
<input type='radio' name='gender' ng-model='genderValue' value='female' ng-checked='genderValue === female'/> Female
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How can I select an element by name with jQuery? (score [1362990](https://stackoverflow.com/q/1107220) in 2018)

#### Question
Have a table column I'm trying to expand and hide:   

jQuery seems to hide the `td` elements when I select it by <a href="http://docs.jquery.com/Selectors/class#class" rel="noreferrer">class</a> but not by element's <a href="http://docs.jquery.com/Selectors/element#element" rel="noreferrer">name</a>.    

For example, why does:   

```html
$(".bold").hide(); // selecting by class works
$("tcol1").hide(); // select by element name does not work
```

Note the HTML below, the second column has the same name for all rows.  How could I create this collection using the `name` attribute?  

```html
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

```html
$('td[name ="tcol1"]')   // matches exactly 'tcol1'
$('td[name^="tcol"]' )   // matches those that begin with 'tcol'
$('td[name$="tcol"]' )   // matches those that end with 'tcol'
$('td[name*="tcol"]' )   // matches those that contain 'tcol'
```

#### Answer 2 (score 205)
<p>Any attribute can be selected using `[attribute_name=value]` way.
See the sample <a href="http://myvedham.blogspot.in/2013/09/jquery-select-by-name-and-id.html" rel="noreferrer">here</a>:</p>

```html
var value = $("[name='nameofobject']");
```

#### Answer 3 (score 57)
If you have something like:  

```html
<input type="checkbox" name="mycheckbox" value="11" checked="">
<input type="checkbox" name="mycheckbox" value="12">
```

You can read all like this:  

```html
jQuery("input[name='mycheckbox']").each(function() {
    console.log( this.value + ":" + this.checked );
});
```

The snippet:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
jQuery("input[name='mycheckbox']").each(function() {
  console.log( this.value + ":" + this.checked );
});```
```html
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<input type="checkbox" name="mycheckbox" value="11" checked="">
<input type="checkbox" name="mycheckbox" value="12">```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 39: jQuery Get Selected Option From Dropdown (score [1350883](https://stackoverflow.com/q/10659097) in 2017)

#### Question
<p>Usually I use `$("#id").val()` to return the value of the selected option, but this time it doesn't work.
The selected tag has the id `aioConceptName`</p>

<strong>html code</strong>  

```html
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

```html
var conceptName = $('#aioConceptName').find(":selected").text();
```

The reason `val()` doesn't do the trick is because clicking an option doesn't change the value of the dropdown--it just adds the `:selected` property to the selected option which is a <em>child</em> of the dropdown.  

#### Answer 2 (score 326)
<strong>Set the values for each of the options</strong>  

```html
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

```html
var conceptName = $('#aioConceptName :selected').text();
```

or generically:  

```html
$('#id :pseudoclass')
```

This saves you an extra jQuery call, selects everything in one shot, and is more clear (my opinion).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: How to make JavaScript execute after page load? (score [1349255](https://stackoverflow.com/q/807878) in 2019)

#### Question
I'm executing an external script, using a `&lt;script&gt;` inside `&lt;head&gt;`.  

Now since the script executes <strong>before</strong> the page has loaded, I can't access the `&lt;body&gt;`, among other things. I'd like to execute some JavaScript after the document has been "loaded" (HTML fully downloaded and in-RAM). Are there any events that I can hook onto when my script executes, that will get triggered on page load?  

#### Answer accepted (score 745)
These solutions will work:  

```html
<body onload="script();">
```

or  

```html
document.onload = function ...
```

or even  

```html
window.onload = function ...
```

Note that <strong>the last option is a better way to go</strong> since it is <a href="http://en.wikipedia.org/wiki/Unobtrusive_JavaScript" rel="noreferrer">unobstrusive</a> and is <a href="https://stackoverflow.com/questions/807878/javascript-that-executes-after-page-load#comment617710_807891">considered more standard</a>.  

#### Answer 2 (score 186)
Reasonably portable, non-framework way of having your script set a function to run at load time:  

```html
if(window.attachEvent) {
    window.attachEvent('onload', yourFunctionName);
} else {
    if(window.onload) {
        var curronload = window.onload;
        var newonload = function(evt) {
            curronload(evt);
            yourFunctionName(evt);
        };
        window.onload = newonload;
    } else {
        window.onload = yourFunctionName;
    }
}
```

#### Answer 3 (score 137)
<h5>Keep in mind that loading the page has more than one stage. Btw, this is pure JavaScript</h1>

<h5>"DOMContentLoaded"</h3>

This event is fired when the <em>initial HTML document has been completely loaded and parsed</em>, without waiting for stylesheets, images, and subframes to finish loading. At this stage you could programmatically optimize loading of images and css based on user device or bandwidth speed.  

Exectues after DOM is loaded (before img and css):   

```html
document.addEventListener("DOMContentLoaded", function(){
    //....
});
```

<blockquote>
  <p>Note: Synchronous JavaScript pauses parsing of the DOM.
  If you want the DOM to get parsed as fast as possible after the user requested the page, you could <strong>turn your JavaScript asynchronous</strong> and <a href="https://developers.google.com/speed/docs/insights/OptimizeCSSDelivery" rel="noreferrer">optimize loading of stylesheets</a></p>
</blockquote>

<h5>"load"</h3>

A very different event, <strong>load</strong>, should only be used to detect a <em>fully-loaded page</em>. It is an incredibly popular mistake to use load where DOMContentLoaded would be much more appropriate, so be cautious.  

Exectues after everything is loaded and parsed:   

```html
window.addEventListener("load", function(){
    // ....
});
```

<hr>

<em>MDN Resources:</em>  

<p><a href="https://developer.mozilla.org/en-US/docs/Web/Events/DOMContentLoaded" rel="noreferrer">https://developer.mozilla.org/en-US/docs/Web/Events/DOMContentLoaded</a>
<a href="https://developer.mozilla.org/en-US/docs/Web/Events/load" rel="noreferrer">https://developer.mozilla.org/en-US/docs/Web/Events/load</a></p>

<em>MDN list of all events:</em>  

<a href="https://developer.mozilla.org/en-US/docs/Web/Events" rel="noreferrer">https://developer.mozilla.org/en-US/docs/Web/Events</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: Open link in new tab or window (score [1348610](https://stackoverflow.com/q/15551779) in 2016)

#### Question
Is it possible to open an `a href` link in a new tab instead of the same tab?  

```html
<a href="http://your_url_here.html">Link</a>
```

#### Answer accepted (score 1805)
You should add the `target="_blank"` and `rel="noopener noreferrer"` in the anchor tag.  

For example:  

```html
<a target="_blank" rel="noopener noreferrer" href="http://your_url_here.html">Link</a>
```

Adding `rel="noopener noreferrer"` is not mandatory, but it's a recommended security measure. More information can be found in the links below.   

Source:   

<ul>
<li><a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#attr-target" rel="noreferrer">MDN | HTML element `&lt;a&gt;` | attribute `target`</a></li>
<li><a href="https://mathiasbynens.github.io/rel-noopener/" rel="noreferrer">About rel=noopener</a></li>
<li><a href="https://developers.google.com/web/tools/lighthouse/audits/noopener" rel="noreferrer">Opens External Anchors Using rel="noopener"</a></li>
</ul>

#### Answer 2 (score 209)
It shouldn't be your call to decide whether the link should open in a new tab or a new window, since ultimately this choice should be done by the settings of the user's browser. Some people like tabs; some like new windows.  

Using `_blank` will tell the browser to use a new tab/window, depending on the user's browser configuration and how they click on the link (e.g. middle click, <kbd>Ctrl</kbd>+click, or normal click).  

#### Answer 3 (score 44)
set the `target` attribute of your `&lt;a&gt;` element to `"_tab"`  

<p>EDIT:
It works, however W3Schools says there is no such target attribute:
<a href="http://www.w3schools.com/tags/att_a_target.asp" rel="noreferrer">http://www.w3schools.com/tags/att_a_target.asp</a></p>

<p>EDIT2:
From what I've figured out from the comments. setting target to _blank will take you to a new tab or window (depending on your browser settings). Typing anything except one of the ones below will create a new tab group (I'm not sure how these work):</p>

```html
_blank  Opens the linked document in a new window or tab
_self   Opens the linked document in the same frame as it was clicked (this is default)
_parent Opens the linked document in the parent frame
_top    Opens the linked document in the full body of the window
framename   Opens the linked document in a named frame
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How to add a browser tab icon (favicon) for a website? (score [1346125](https://stackoverflow.com/q/4888377) in 2017)

#### Question
I've been working on a website and I'd like to add a small icon to the browser tab.  

How can I do this in HTML and where in the code would I need to place it (e.g. header)? I have a `.png` logo file that I'd like to convert to an icon.  

Related: <a href="https://stackoverflow.com/questions/2359866/html-set-image-on-browser-tab">HTML set image on browser tab</a>.  

#### Answer accepted (score 351)
There are actually two ways to add a favicon to a website.  

<h5>`&lt;link rel="icon"&gt;`</h1>

Simply add the following code to the `&lt;head&gt;` element:  



```html
<link rel="icon" href="http://example.com/favicon.png">
```

PNG favicons <a href="http://caniuse.com/#feat=link-icon-png" rel="noreferrer">are supported by most browsers, except IE &lt;= 10</a>. For backwards compatibility, you can use ICO favicons.  

Note that you <strong>don't have to precede `icon` in `rel` attribute with `shortcut`</strong> anymore. From <a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types" rel="noreferrer">MDN Link types</a>:  

<blockquote>
  The `shortcut` link type is often seen before `icon`, but this link type is non-conforming, ignored and <strong>web authors must not use it anymore</strong>.  
</blockquote>

<h5>`favicon.ico` in the root directory</h1>

From <a href="https://stackoverflow.com/a/1344379/3853934">another SO answer</a> (by <a href="https://stackoverflow.com/users/23263/mercator">@mercator</a>):  

<blockquote>
  All modern browsers (tested with Chrome 4, Firefox 3.5, IE8, Opera 10 and Safari 4) will always request a `favicon.ico` unless you've specified a shortcut icon via `&lt;link&gt;`.  
</blockquote>

So all you have to do is to make the `/favicon.ico` request to your website return your favicon. This option unfortunately doesn't allow you to use a PNG icon.  

See also <a href="https://stackoverflow.com/q/1344122/3853934">favicon.png vs favicon.ico - why should I use PNG instead of ICO?</a>  

#### Answer 2 (score 420)
<ol>
<li>Use a tool to convert your png to a ico file. You can search "favicon generator" and you can find many online tools.</li>
<li><p>Place the ico address in the `head` with a `link`-tag:</p>

```html
<link rel="shortcut icon" href="http://sstatic.net/stackoverflow/img/favicon.ico">
```</li>
</ol>

#### Answer 3 (score 69)
<p>The best one that I found is <a href="http://www.favicomatic.com/">http://www.favicomatic.com/</a>
I say best because it gave me the crispest favicon, and required no editing after their transformation.
It will generate favicons at 16x16 and 32x32 and to quote them "Every damn size, sir!"
Also, their site looks cool and is easy to use.</p>

They also generate the html that you need to use for the files they generate.  

```html
<link rel="apple-touch-icon-precomposed" sizes="57x57" href="apple-touch-icon-57x57.png" />
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="apple-touch-icon-114x114.png" />
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="apple-touch-icon-144x144.png" />
<link rel="apple-touch-icon-precomposed" sizes="60x60" href="apple-touch-icon-60x60.png" />
<link rel="apple-touch-icon-precomposed" sizes="120x120" href="apple-touch-icon-120x120.png" />
<link rel="apple-touch-icon-precomposed" sizes="76x76" href="apple-touch-icon-76x76.png" />
<link rel="apple-touch-icon-precomposed" sizes="152x152" href="apple-touch-icon-152x152.png" />
<link rel="icon" type="image/png" href="favicon-196x196.png" sizes="196x196" />
<link rel="icon" type="image/png" href="favicon-96x96.png" sizes="96x96" />
<link rel="icon" type="image/png" href="favicon-32x32.png" sizes="32x32" />
<link rel="icon" type="image/png" href="favicon-16x16.png" sizes="16x16" />
<link rel="icon" type="image/png" href="favicon-128.png" sizes="128x128" />
<meta name="application-name" content="&nbsp;"/>
<meta name="msapplication-TileColor" content="#FFFFFF" />
<meta name="msapplication-TileImage" content="mstile-144x144.png" />
<meta name="msapplication-square70x70logo" content="mstile-70x70.png" />
<meta name="msapplication-square150x150logo" content="mstile-150x150.png" />
<meta name="msapplication-wide310x150logo" content="mstile-310x150.png" />
<meta name="msapplication-square310x310logo" content="mstile-310x310.png" />
```

I looked at the first 20 or so google results, and this was by far the best.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Recommended way to embed PDF in HTML? (score [1342368](https://stackoverflow.com/q/291813) in 2012)

#### Question
What is the recommended way to embed PDF in HTML?  

<ul>
<li>iFrame? </li>
<li>Object? </li>
<li>Embed?</li>
</ul>

What does Adobe say itself about it?  

In my case, the PDF is generated on the fly, so it can't be uploaded to a third-party solution prior to flushing it.  

#### Answer accepted (score 518)
Probably the best approach is to use the <a href="http://mozilla.github.com/pdf.js/" rel="noreferrer">PDF.JS</a> library. It's a pure <a href="http://en.wikipedia.org/wiki/HTML5" rel="noreferrer">HTML5</a>/<a href="http://en.wikipedia.org/wiki/JavaScript" rel="noreferrer">JavaScript</a> renderer for PDF documents without any third-party plugins.  

<p>Online demo:
<a href="http://mozilla.github.com/pdf.js/web/viewer.html" rel="noreferrer">http://mozilla.github.com/pdf.js/web/viewer.html</a></p>

<p>GitHub:
<a href="https://github.com/mozilla/pdf.js" rel="noreferrer">https://github.com/mozilla/pdf.js</a></p>

#### Answer 2 (score 502)
This is quick, easy, to the point and doesn't require any third-party script:  

```html
<embed src="http://example.com/the.pdf" width="500" height="375" 
 type="application/pdf">
```

<strong>UPDATE (1/2018):</strong>  

The Chrome browser on Android no longer supports PDF embeds. You can get around this by using the Google Drive PDF viewer  

```html
<embed src="https://drive.google.com/viewerng/
viewer?embedded=true&url=http://example.com/the.pdf" width="500" height="375">
```

#### Answer 3 (score 350)
You can also use Google PDF viewer for this purpose. As far as I know it's not an official Google feature (am I wrong on this?), but it works for me very nicely and smoothly. You need to upload your PDF somewhere before and just use its URL:  

```html
<iframe src="http://docs.google.com/gview?url=http://example.com/mypdf.pdf&embedded=true" style="width:718px; height:700px;" frameborder="0"></iframe>
```

What is important is that it doesn't need a Flash player, it uses JavaScript.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: Include another HTML file in a HTML file (score [1329300](https://stackoverflow.com/q/8988855) in 2012)

#### Question
I have 2 HTML files, suppose `a.html` and `b.html`. In `a.html` I want to include `b.html`.  

In JSF I can do it like that:  

```html
<ui:include src="b.xhtml" />
```

It means that inside `a.xhtml` file, I can include `b.xhtml`.  

How can we do it in `*.html` file?  

#### Answer accepted (score 644)
In my opinion the best solution uses jQuery:  

`a.html`:  

```html
<html> 
  <head> 
    <script src="jquery.js"></script> 
    <script> 
    $(function(){
      $("#includedContent").load("b.html"); 
    });
    </script> 
  </head> 

  <body> 
     <div id="includedContent"></div>
  </body> 
</html>
```

`b.html`:  

```html
<p>This is my include file</p>
```

This method is a simple and clean solution to my problem.  

The jQuery `.load()` documentation is <a href="http://api.jquery.com/load/">here</a>.  

#### Answer 2 (score 138)
Expanding lolo's answer from above, here is a little more automation if you have to include a lot of files:  

```html
<script>
  $(function(){
    var includes = $('[data-include]');
    jQuery.each(includes, function(){
      var file = 'views/' + $(this).data('include') + '.html';
      $(this).load(file);
    });
  });
</script>
```

And then to include something in the html:  

```html
<div data-include="header"></div>
<div data-include="footer"></div>
```

Which would include the file views/header.html and views/footer.html  

#### Answer 3 (score 134)
My solution is similar to the one of <a href="https://stackoverflow.com/users/1001224/lolo">lolo</a> above. However, I insert the HTML code via JavaScript's document.write instead of using jQuery:  

<strong>a.html:</strong>  

```html
<html> 
  <body>
  <h1>Put your HTML content before insertion of b.js.</h1>
      ...

  <script src="b.js"></script>

      ...

  <p>And whatever content you want afterwards.</p>
  </body>
</html>
```

<strong>b.js:</strong>  

```html
document.write('\
\
    <h1>Add your HTML code here</h1>\
\
     <p>Notice however, that you have to escape LF's with a '\', just like\
        demonstrated in this code listing.\
    </p>\
\
');
```

The reason for me against using jQuery is that jQuery.js is ~90kb in size, and I want to keep the amount of data to load as small as possible.  

In order to get the properly escaped JavaScript file without much work, you can use the following sed command:  

```html
sed 's/\\/\\\\/g;s/^.*$/&\\/g;s/'\''/\\'\''/g' b.html > escapedB.html
```

<p>Or just use the following handy bash script published as a Gist on Github, that automates all necessary work, converting `b.html` to `b.js`:
    <a href="https://gist.github.com/Tafkadasoh/334881e18cbb7fc2a5c033bfa03f6ee6" rel="noreferrer">https://gist.github.com/Tafkadasoh/334881e18cbb7fc2a5c033bfa03f6ee6</a></p>

Credits to <a href="https://stackoverflow.com/users/1527747/greg-minshall">Greg Minshall</a> for the improved sed command that also escapes back slashes and single quotes, which my original sed command did not consider.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: How to make div not larger than its contents? (score [1323786](https://stackoverflow.com/q/450903) in 2015)

#### Question
I have a layout similar to:  

```html
<div>
    <table>
    </table>
</div>
```

I would like for the `div` to only expand to as wide as my `table` becomes.  

#### Answer 2 (score 2304)
The solution is to set your `div` to `display: inline-block`.  

#### Answer 3 (score 324)
You want a block element that has what CSS calls shrink-to-fit width and the spec does not provide a blessed way to get such a thing. In CSS2, shrink-to-fit is not a goal, but means to deal with a situation where browser "has to" get a width out of thin air. Those situations are:   

<ul>
<li>float  </li>
<li>absolutely positioned element</li>
<li>inline-block element</li>
<li>table element</li>
</ul>

when there are no width specified. I heard they think of adding what you want in CSS3. For now, make do with one of the above.  

The decision not to expose the feature directly may seem strange, but there is a good reason. It is expensive. Shrink-to-fit means formatting at least twice: you cannot start formatting an element until you know its width, and you cannot calculate the width w/o going through entire content. Plus, one does not need shrink-to-fit element as often as one may think. Why do you need extra div around your table? Maybe table caption is all you need.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Bootstrap - Text-align class for inside a table (score [1319954](https://stackoverflow.com/q/12829608) in 2019)

#### Question
Is there a set of classes in Twitter's Bootstrap framework that aligns text?  

For example, I have some tables with `$` totals that I want aligned to the right...  

```html
<th class="align-right">Total</th>
```

and  

```html
<td class="align-right">$1,000,000.00</td>
```

#### Answer accepted (score 1369)
<h5>Bootstrap 3</h1>

<a href="http://getbootstrap.com/css/#type-alignment" rel="noreferrer">v3 Text Alignment Docs</a>  

```html
<p class="text-left">Left aligned text.</p>
<p class="text-center">Center aligned text.</p>
<p class="text-right">Right aligned text.</p>
<p class="text-justify">Justified text.</p>
<p class="text-nowrap">No wrap text.</p>
```

<a href="https://i.stack.imgur.com/DZHMg.png" rel="noreferrer"><img src="https://i.stack.imgur.com/DZHMg.png" alt="Bootstrap 3 text align example"></a>  

<h5>Bootstrap 4</h1>

<a href="http://v4-alpha.getbootstrap.com/utilities/typography/#text-alignment" rel="noreferrer">v4 Text Alignment Docs</a>  

```html
<p class="text-xs-left">Left aligned text on all viewport sizes.</p>
<p class="text-xs-center">Center aligned text on all viewport sizes.</p>
<p class="text-xs-right">Right aligned text on all viewport sizes.</p>

<p class="text-sm-left">Left aligned text on viewports sized SM (small) or wider.</p>
<p class="text-md-left">Left aligned text on viewports sized MD (medium) or wider.</p>
<p class="text-lg-left">Left aligned text on viewports sized LG (large) or wider.</p>
<p class="text-xl-left">Left aligned text on viewports sized XL (extra-large) or wider.</p>
```

<a href="https://i.stack.imgur.com/Qfi1K.png" rel="noreferrer"><img src="https://i.stack.imgur.com/Qfi1K.png" alt="Bootstrap 4 text align example"></a>  

#### Answer 2 (score 74)
Using Bootstrap 3.x using `text-right` works perfectly:  

```html
<td class="text-right">
  text aligned
</td>
```

#### Answer 3 (score 46)
No, Bootstrap doesn't have a class for that, but this kind of class is considered a "utility" class, similar to the ".pull-right" class that @anton mentioned.   

<p>If you look at utilities.less you will see very few utility classes in Bootstrap, the reason being that this kind of class is generally frowned upon, and is recommended to be used for either:
 a) prototyping and development - so you can quickly build out your pages, then remove the pull-right and pull-left classes in favor of applying floats to more semantic classes or to the elements themselves, or 
 b) when it's clearly more practical than a more semantic solution. </p>

In your case, by your question it looks like you wish to have certain text align on the right in your table, but not all of it. Semantically, it would be better to do something like (I'm just going to make up a few classes here, except for the default bootstrap class, .table):   

```html
  <table class="table price-table">
    <thead>
      <th class="price-label">Total</th>
    </thead>
    <tbody>
      <tr>
        <td class="price-value">$1,000,000.00</td>
      </tr>
    </tbody>
  </table>
```

And just apply the `text-align: left` or `text-align: right` declarations to the price-value and price-label classes (or whatever classes work for you).   

The problem with applying `align-right` as a class, is that if you want to refactor your tables you will have to redo the markup and the styles. If you use semantic classes you might be able to get away with refactoring only the CSS content. Plus, if are taking the time to apply a class to an element, it's best practice to try to assign semantic value to that class so that the markup is easier to navigate for other programmers (or you three months later).  

One way to think of it is this: when you pose the question "What is this td for?", you will not get clarification from the answer "align-right".  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: HTML 5: Is it <br>, <br/>, or <br />? (score [1298945](https://stackoverflow.com/q/1946426) in 2019)

#### Question
I've tried checking <a href="https://stackoverflow.com/questions/1659208/why-br-and-not-br">other answers</a>, but I'm still confused — especially after seeing <a href="http://www.w3schools.com/tags/tag_img.asp" rel="noreferrer">W3schools HTML 5 reference</a>.  

I thought HTML 4.01 was supposed to "allow" single-tags to just be `&lt;img&gt;` and `&lt;br&gt;`. Then XHTML came along with `&lt;img /&gt;` and `&lt;br /&gt;` (<a href="https://stackoverflow.com/questions/462741/space-before-closing-slash/463692#463692">where someone said that the space is there for older browsers</a>).  

Now I'm wondering how I'm supposed to format my code when practicing HTML 5.   

Is it `&lt;br&gt;`, `&lt;br/&gt;` or `&lt;br /&gt;`?  

#### Answer accepted (score 1468)
Simply `&lt;br&gt;` is sufficient.  

The other forms are there for compatibility with XHTML; to make it possible to write the same code as XHTML, and have it also work as HTML. Some systems that generate HTML may be based on XML generators, and thus do not have the ability to output just a bare `&lt;br&gt;` tag; if you're using such a system, it's fine to use `&lt;br/&gt;`, it's just not necessary if you don't need to do it.  

Very few people actually use XHTML, however. You need to serve your content as `application/xhtml+xml` for it to be interpreted as XHTML, and that will not work in old versions of IE - it will also mean that any small error you make will prevent your page from being displayed in browsers that do support XHTML. So, most of what looks like XHTML on the web is actually being served, and interpreted, as HTML. See <a href="http://hixie.ch/advocacy/xhtml" rel="noreferrer">Serving XHTML as text/html Considered Harmful</a> for some more information.  

#### Answer 2 (score 215)
I think this quote from the <a href="https://dev.w3.org/html5/html-author/#void" rel="noreferrer">HTML 5 Reference Draft</a> provides the answer:  

<blockquote>
  <em>3.2.2.2 Void Elements</em>  
  
  The term <strong>void elements</strong> is used to designate elements that must be <a href="https://dev.w3.org/html5/html-author/#empty-element" rel="noreferrer">empty</a>. These requirements only apply to the HTML syntax. In XHTML, all such elements are treated as normal elements, but must be marked up as empty elements.  
  
  These elements are forbidden from containing any content at all. In HTML, these elements have a <a href="https://dev.w3.org/html5/html-author/#start-tag" rel="noreferrer">start tag</a> only. The <a href="https://dev.w3.org/html5/html-author/#self-closing-tag" rel="noreferrer">self-closing tag</a> syntax may be used. The <a href="https://dev.w3.org/html5/html-author/#end-tag" rel="noreferrer">end tag</a> must be omitted because the element is automatically closed by the parser.  
  
  <p>HTML Example:<br>
  A void element in the HTML syntax. This is not permitted in the XHTML syntax.</p>

```html
<hr>
```
  
  <p>Example:<br>
  A void element using the HTML- and XHTML-compatible self-closing tag syntax.</p>

```html
<hr/>
```
  
  <p>XHTML Example:<br>
  A void element using the XHTML-only syntax with an explicit end tag. This is not permitted for void elements in the HTML syntax.</p>

```html
<hr></hr>
```
</blockquote>

#### Answer 3 (score 133)
XML doesn't allow leaving tags open, so it makes `&lt;br&gt;` a bit worse than the other two. The other two are roughly equivalent with the second (`&lt;br/&gt;`) preferred for compatibility with older browsers. Actually, space before `/` is preferred for compatibility sake, but I think it only makes sense for tags that have attributes. So I'd say either `&lt;br/&gt;` or `&lt;br /&gt;`, whichever pleases your aesthetics.  

To sum it up: all three are valid with the first one (`&lt;br&gt;`) being a bit less "portable".  

<strong>Edit</strong>: Now that we're all crazy about specs, I think it worth pointing out that according to <a href="http://dev.w3.org/html5/markup/syntax.html#void-element" rel="noreferrer">dev.w3.org</a>:  

<blockquote>
  <p>Start tags consist of the following
  parts, in exactly the following order:</p>
  
  <ol>
  <li>A "&lt;" character.</li>
  <li>The element’s tag name.</li>
  <li>Optionally, one or more attributes, each of which must be
  preceded by one or more space
  characters.</li>
  <li>Optionally, one or more space characters.</li>
  <li><strong>Optionally, a "/" character, which may be present only if the
  element is a void element.</strong></li>
  <li>A ">" character.</li>
  </ol>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: jQuery.click() vs onClick (score [1286792](https://stackoverflow.com/q/12627443) in 2019)

#### Question
I have a huge jQuery application, and I'm using the below two methods for click events.  

<strong>First method</strong>  

<h5>HTML</h3>

```html
<div id="myDiv">Some Content</div>
```

<h5>jQuery</h3>

```html
$('#myDiv').click(function(){
    //Some code
});
```

<strong>Second method</strong>  

<h5>HTML</h3>

```html
<div id="myDiv" onClick="divFunction()">Some Content</div>
```

<h5>JavaScript function call</h3>

```html
function divFunction(){
    //Some code
}
```

I use either the first or second method in my application. Which one is better? Better for performance? And standard?  

#### Answer accepted (score 543)
Using `$('#myDiv').click(function(){` is <strong>better</strong> as it follows standard event registration model. (jQuery <a href="https://github.com/jquery/jquery/blob/6e995583a11b63bf1d94142da6408955ee93e7cc/src/event.js#L97-102">internally</a> uses <a href="https://developer.mozilla.org/en-US/docs/DOM/element.addEventListener">`addEventListener`</a> and <a href="http://msdn.microsoft.com/en-us/library/ie/ms536343%28v=vs.85%29.aspx">`attachEvent`</a>).   

Basically registering an event in <a href="http://www.quirksmode.org/js/events_advanced.html">modern way</a> is the <a href="http://en.wikipedia.org/wiki/Unobtrusive_JavaScript">unobtrusive</a> way of handling events. Also to register more than one event listener for the target you can call `addEventListener()` for the same target.   

```html
var myEl = document.getElementById('myelement');

myEl.addEventListener('click', function() {
    alert('Hello world');
}, false);

myEl.addEventListener('click', function() {
    alert('Hello world again!!!');
}, false);
```

<a href="http://jsfiddle.net/aj55x/1/">http://jsfiddle.net/aj55x/1/</a>   

<blockquote>
  <strong><a href="https://developer.mozilla.org/en-US/docs/DOM/element.addEventListener#Why_use_addEventListener.3F">Why use addEventListener?</a></strong> (From MDN)  
  
  <p>addEventListener is the way to register an event listener as specified
  in W3C DOM. Its benefits are as follows:</p>
  
  <ul>
  <li>It allows adding more than a single handler for an event. This is particularly useful for DHTML libraries or Mozilla extensions that
  need to work well even if other libraries/extensions are used.</li>
  <li>It gives you finer-grained control of the phase when the listener gets activated (capturing vs. bubbling)</li>
  <li>It works on any DOM element, not just HTML elements.</li>
  </ul>
</blockquote>

More about Modern event registration -> <a href="http://www.quirksmode.org/js/events_advanced.html">http://www.quirksmode.org/js/events_advanced.html</a>  

Other methods such as setting the <a href="https://developer.mozilla.org/en-US/docs/DOM/event#HTML_attribute">HTML attributes</a>, example:   

```html
<button onclick="alert('Hello world!')">
```

Or <a href="https://developer.mozilla.org/en-US/docs/DOM/event#DOM_element_properties">DOM element properties</a>, example:   

```html
myEl.onclick = function(event){alert('Hello world');}; 
```

are old and they can be over written easily.   

<strong><em>HTML attribute</em></strong> should be avoided as It makes the markup bigger and less readable. Concerns of content/structure and behavior are not well-separated, making a bug harder to find.  

The problem with the <strong><em>DOM element properties</em></strong> method is that only one event handler can be bound to an element per event.  

More about Traditional event handling -> <a href="http://www.quirksmode.org/js/events_tradmod.html">http://www.quirksmode.org/js/events_tradmod.html</a>  

MDN Reference: <a href="https://developer.mozilla.org/en-US/docs/DOM/event">https://developer.mozilla.org/en-US/docs/DOM/event</a>  

#### Answer 2 (score 64)
For better performance, use the native JavaScript. For faster development, use jQuery. Check the comparison in performance at <em><a href="http://jsperf.com/jquery-vs-native-element-performance" rel="noreferrer">jQuery vs Native Element Performance</a></em>.  

I've done a test in Firefox 16.0 32-bit on Windows Server 2008 R2 / 7 64-bit  

```html
$('span'); // 6,604 operations per second
document.getElementsByTagName('span'); // 10,331,708 operations/sec
```

For click events, check <em><a href="http://jsperf.com/native-browser-events-vs-jquery-trigger" rel="noreferrer">Native Browser events vs jquery trigger</a></em> or <em><a href="http://jsperf.com/jquery-vs-native-click-event-binding" rel="noreferrer">jQuery vs Native Click Event Binding</a></em>.  

Testing in Chrome 22.0.1229.79 32-bit on Windows Server 2008 R2 / 7 64-bit  

```html
$('#jquery a').click(window.testClickListener); // 2,957 operations/second

[].forEach.call( document.querySelectorAll('#native a'), function(el) {
    el.addEventListener('click', window.testClickListener, false);
}); // 18,196 operations/second
```

#### Answer 3 (score 39)
From what I understand, your question is not really about whether to use jQuery or not. It's rather: <em>Is it better to bind events inline in HTML or through event listeners?</em>  

Inline binding is deprecated. Moreover this way you can only bind one function to a certain event.  

Therefore I recommend using event listeners. This way, you'll be able to bind many functions to a single event and to unbind them later if needed. Consider this pure JavaScript code:  

```html
querySelector('#myDiv').addEventListener('click', function () {
    // Some code...
});
```

This works in most modern browsers.  

However, if you already include jQuery in your project — just use jQuery: `.on` or `.click` function.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: How do I modify the URL without reloading the page? (score [1266619](https://stackoverflow.com/q/824349) in 2019)

#### Question
Is there a way I can modify the URL of the current page without reloading the page?  

I would like to access the portion <strong>before</strong> the # hash if possible.  

I only need to change the portion <strong>after</strong> the domain, so it's not like I'm violating cross-domain policies.  

```html
 window.location.href = "www.mysite.com/page2.php";  // Sadly this reloads
```

#### Answer accepted (score 1899)
This can now be done in Chrome, Safari, Firefox 4+, and Internet&nbsp;Explorer&nbsp;10pp4+!  

<p>See this question's answer for more information:
<em><a href="https://stackoverflow.com/questions/3338642/updating-address-bar-with-new-url-without-hash-or-reloading-the-page">Updating address bar with new URL without hash or reloading the page</a></em></p>

Example:  

```html
 function processAjaxData(response, urlPath){
     document.getElementById("content").innerHTML = response.html;
     document.title = response.pageTitle;
     window.history.pushState({"html":response.html,"pageTitle":response.pageTitle},"", urlPath);
 }
```

You can then use `window.onpopstate` to detect the back/forward button navigation:  

```html
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

```html
window.history.pushState('page2', 'Title', '/page2.php');
```

Read more about this from <a href="https://developer.mozilla.org/en/DOM/Manipulating_the_browser_history" rel="noreferrer">here</a>  

#### Answer 3 (score 116)
You can also use HTML5 <strong>replaceState</strong> if you want to change the url but don't want to add the entry to the browser history:  

```html
if (window.history.replaceState) {
   //prevents browser from storing history with each change:
   window.history.replaceState(statedata, title, url);
}
```

This would 'break' the back button functionality. This may be required in some instances such as an image gallery (where you want the back button to return back to the gallery index page instead of moving back through each and every image you viewed) whilst giving each image its own unique url.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: How to insert spaces/tabs in text using HTML/CSS (score [1265157](https://stackoverflow.com/q/9792849) in 2019)

#### Question
Possible ways:  

```html
<pre> ... </pre>
```

or  

```html
style="white-space:pre"
```

Anything else?  

#### Answer 2 (score 130)
To insert `tab space` between two words/sentences I usually use  

`&amp;emsp;` and  `&amp;ensp;`  

#### Answer 3 (score 108)
In cases wherein the width/height of the space is beyond `&amp;nbsp;` I usually use:  

For horizontal spacer:  

```html
<span style="display:inline-block; width: YOURWIDTH;"></span>
```

For vertical spacer:  

```html
<span style="display:block; height: YOURHEIGHT;"></span>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: How do I disable the resizable property of a textarea? (score [1259614](https://stackoverflow.com/q/5235142) in 2019)

#### Question
I want to disable the resizable property of a `textarea`.  

Currently, I can resize a `textarea` by clicking on the bottom right corner of the `textarea` and dragging the mouse. How can I disable this?  

<a href="https://i.stack.imgur.com/xrfWQ.png" rel="noreferrer"><img src="https://i.stack.imgur.com/xrfWQ.png" alt="Enter image description here"></a>  

#### Answer accepted (score 3331)
The following CSS rule disables resizing behavior for <a href="http://www.w3.org/wiki/HTML/Elements/textarea" rel="noreferrer">`textarea`</a> elements:  

```html
textarea {
  resize: none;
}
```

To disable it for some (but not all) `textarea`s, there are a <a href="http://www.electrictoolbox.com/disable-textarea-resizing-safari-chrome/" rel="noreferrer">couple of options</a>.  

To disable a specific `textarea` with the `name` attribute set to `foo` (i.e., `&lt;textarea name="foo"&gt;&lt;/textarea&gt;`):  

```html
textarea[name=foo] {
  resize: none;
}
```

Or, using an `id` attribute (i.e., `&lt;textarea id="foo"&gt;&lt;/textarea&gt;`):  

```html
#foo {
  resize: none;
}
```

The <a href="http://www.w3.org/TR/css3-ui/#resize" rel="noreferrer">W3C page</a> lists possible values for resizing restrictions: none, both, horizontal, vertical, and inherit:  

```html
textarea {
  resize: vertical; /* user can resize vertically, but width is fixed */
}
```

Review a decent <a href="http://quirksmode.org/css/user-interface/" rel="noreferrer">compatibility page</a> to see what browsers currently support this feature. As Jon Hulka has commented, the dimensions can be <a href="http://davidwalsh.name/textarea-resize" rel="noreferrer">further restrained</a> in CSS using max-width, max-height, min-width, and min-height.  

<blockquote>
  <h5>Super important to know:</h3>
  
  This property does nothing unless the overflow property is something other than visible, which is the default for most elements. So generally to use this, you'll have to set something like overflow: scroll;  
  
  <p>Quote by Chris Coyier,
  <a href="http://css-tricks.com/almanac/properties/r/resize/" rel="noreferrer">http://css-tricks.com/almanac/properties/r/resize/</a></p>
</blockquote>

#### Answer 2 (score 198)
In CSS ...  

```html
textarea {
    resize: none;
}
```

#### Answer 3 (score 102)
I found two things:  

First  

```html
textarea{resize: none}
```

This is a CSS&nbsp;3, <em>which is not released yet</em>, compatible with <a href="http://www.w3schools.com/cssref/css3_pr_resize.asp" rel="nofollow noreferrer"><strong>Firefox 4 (and later), Chrome, and Safari</strong></a>.  

Another format feature is to <a href="http://www.codingforums.com/showthread.php?t=85786" rel="nofollow noreferrer">`overflow: auto`</a> to get rid of the right scrollbar, taking into account the <a href="http://www.w3schools.com/tags/att_global_dir.asp" rel="nofollow noreferrer"><em>dir</em></a> attribute.  

<h5>Code and different browsers</h2>

<em>Basic HTML</em>  

```html
<!DOCTYPE html>
<html>
<head>
</head>
<body>
    <textarea style="overflow:auto;resize:none" rows="13" cols="20"></textarea>
</body>
</html>
```

<em>Some browsers</em>  

<ul>
<li>Internet&nbsp;Explorer&nbsp;8</li>
</ul>

<img src="https://i.stack.imgur.com/IObIu.png" alt="Enter image description here">  

<ul>
<li>Firefox 17.0.1</li>
</ul>

<img src="https://i.stack.imgur.com/Xr3ub.png" alt="Enter image description here">  

<ul>
<li>Chrome</li>
</ul>

<img src="https://i.stack.imgur.com/VxYgY.png" alt="Enter image description here">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: Retrieve the position (X,Y) of an HTML element (score [1258174](https://stackoverflow.com/q/442404) in 2013)

#### Question
I want to know how to get the X and Y position of HTML elements such as `img` and `div` in JavaScript.  

#### Answer 2 (score 1645)
The correct approach is to use <a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect" rel="noreferrer">`element.getBoundingClientRect()`</a>:  

```html
var rect = element.getBoundingClientRect();
console.log(rect.top, rect.right, rect.bottom, rect.left);
```

Internet Explorer has supported this since as long as you are likely to care about and it was finally standardized in <a href="http://www.w3.org/TR/cssom-view/#the-getclientrects-and-getboundingclientrect-methods" rel="noreferrer">CSSOM Views</a>. All other browsers adopted it <a href="http://www.quirksmode.org/dom/w3c_cssom.html#t21" rel="noreferrer">a long time ago</a>.  

Some browsers also return height and width properties, though this is non-standard.  If you're worried about older browser compatibility, check this answer's revisions for an optimised degrading implementation.  

The values returned by `element.getBoundingClientRect()` are relative to the viewport.  If you need it relative to another element, simply subtract one rectangle from the other:  

```html
var bodyRect = document.body.getBoundingClientRect(),
    elemRect = element.getBoundingClientRect(),
    offset   = elemRect.top - bodyRect.top;

alert('Element is ' + offset + ' vertical pixels from <body>');
```

#### Answer 3 (score 307)
<p>The libraries go to some lengths to get accurate offsets for an element.<br>
here's a simple function that does the job in every circumstances that I've tried.</p>

```html
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

### 53: Pure JavaScript equivalent of jQuery's $.ready() - how to call a function when the page/DOM is ready for it (score [1254609](https://stackoverflow.com/q/9899372) in 2017)

#### Question
Okay, this might just be a silly question, though I'm sure there are plenty of other people asking the same question from time to time. Me, I just want to make 100% sure about it either way. With jQuery we all know the wonderful  

```html
$('document').ready(function(){});
```

However, let's say I want to run a function that is written in standard JavaScript with no library backing it, and that I want to launch a function as soon as the page is ready to handle it. What's the proper way to approach this?  

I know I can do:  

```html
window.onload="myFunction()";
```

...or I can use the `body` tag:  

```html
<body onload="myFunction()">
```

...or I can even try at the bottom of the page after everything, but the end `body` or `html` tag like:  

```html
<script type="text/javascript">
   myFunction();
</script>
```

What is a cross-browser(old/new)-compliant method of issuing one or more functions in a manner like jQuery's `$.ready()`?  

#### Answer accepted (score 1727)
The simplest thing to do in the absence of a framework that does all the cross-browser compatibility for you is to just put a call to your code at the end of the body.  This is faster to execute than an `onload` handler because this waits only for the DOM to be ready, not for all images to load.  And, this works in every browser.  

```html
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

```html
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

```html
docReady(function() {
    // DOM is loaded and ready for manipulation here
});
```

<hr>

If you need full cross browser compatibility (including old versions of IE) and you don't want to wait for `window.onload`, then you probably should go look at how a framework like jQuery implements its `$(document).ready()` method.  It's fairly involved depending upon the capabilities of the browser.  

To give you a little idea what jQuery does (which will work wherever the script tag is placed).  

If supported, it tries the standard:  

```html
document.addEventListener('DOMContentLoaded', fn, false);
```

with a fallback to:  

```html
window.addEventListener('load', fn, false )
```

or for older versions of IE, it uses:  

```html
document.attachEvent("onreadystatechange", fn);
```

with a fallback to:  

```html
window.attachEvent("onload", fn);
```

And, there are some work-arounds in the IE code path that I don't quite follow, but it looks like it has something to do with frames.  

<hr>

Here is a full substitute for jQuery's `.ready()` written in plain javascript:  

```html
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

```html
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

```html
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

```html
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

```html
document.addEventListener("DOMContentLoaded", function(event) {
    // Your code to run since DOM is loaded and ready
});
```

Above is the equivalent of jQuery `.ready`:  

```html
$(document).ready(function() {
    console.log("Ready!");
});
```

Which ALSO could be written SHORTHAND like this, which jQuery will run after the ready even <a href="https://stackoverflow.com/q/7614574/32453">occurs</a>.  

```html
$(function() {
    console.log("ready!");
});
```

<strong>NOT TO BE CONFUSED with BELOW</strong> (which is not meant to be DOM ready):  

DO NOT use an <a href="https://developer.mozilla.org/en-US/docs/Glossary/IIFE" rel="noreferrer">IIFE</a> like this that is self executing:  

```html
 Example:

(function() {
   // Your page initialization code here  - WRONG
   // The DOM will be available here   - WRONG
})();
```

This IIFE will NOT wait for your DOM to load. (I'm even talking about latest version of Chrome browser!)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: Set the value of an input field (score [1239497](https://stackoverflow.com/q/7609130) in 2017)

#### Question
How would you set the default value of a form `&lt;input&gt;` text field in JavaScript?  

#### Answer accepted (score 766)
This is one way of doing it:  

```html
document.getElementById("mytext").value = "My value";
```

#### Answer 2 (score 54)
if your form contains an input field like   

```html
<input type='text' id='id1' />
```

then you can write the code in javascript as given below to set its value as  

```html
document.getElementById('id1').value='text to be displayed' ; 
```

#### Answer 3 (score 49)
I use 'setAttribute' function:   

```html
<input type="text" id="example"> // Setup text field 
<script type="text/javascript"> 
  document.getElementById("example").setAttribute('value','My default value');
</script>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: How to Vertical align elements in a div? (score [1237657](https://stackoverflow.com/q/79461) in 2018)

#### Question
I have a div with two images and an `h1`. All of them need to be vertically aligned within the div, next to each other.  

One of the images needs to be `absolute` positioned within the div.  

What is the CSS needed for this to work on all common browsers?  

```html
<div id="header">
    <img src=".." ></img>
    <h1>testing...</h1>
    <img src="..."></img>
</div>
```

#### Answer accepted (score 867)
Wow, this problem is popular. It's based on a misunderstanding in the `vertical-align` property. This excellent article explains it:  

<a href="http://phrogz.net/CSS/vertical-align/index.html" rel="noreferrer">Understanding `vertical-align`, or "How (Not) To Vertically Center Content"</a> by Gavin Kistner.  

<strong><a href="http://howtocenterincss.com/" rel="noreferrer">“How to center in CSS”</a></strong> is a great web tool which helps to find the necessary CSS centering attributes for different situations.  

<hr>

In a nutshell <sub><sup>(and to prevent link rot)</sup></sub>:  

<ul>
<li><strong>Inline elements</strong> (and <em>only</em> inline elements) can be vertically aligned in their context via `vertical-align: middle`. However, the “context” isn’t the whole parent container height, it’s the height of the text line they’re in. <a href="http://jsfiddle.net/jBthq/" rel="noreferrer">jsfiddle example</a></li>
<li>For block elements, vertical alignment is harder and strongly depends on the specific situation:

<ul>
<li>If the inner element can have a <strong>fixed height</strong>, you can make its position `absolute` and specify its `height`, `margin-top` and `top` position. <a href="http://jsfiddle.net/YFncP/2/" rel="noreferrer">jsfiddle example</a></li>
<li>If the centered element <strong>consists of a single line</strong> <em>and</em> <strong>its parent height is fixed</strong> you can simply set the container’s `line-height` to fill its height. This method is quite versatile in my experience. <a href="http://jsfiddle.net/d4zGF/" rel="noreferrer">jsfiddle example</a></li>
<li>… there are more such special cases.</li>
</ul></li>
</ul>

#### Answer 2 (score 140)
Now that flexbox support is increasing, this CSS applied to the containing element would vertically center the contained item:  

```html
.container {        
    display: flex;
    align-items: center;
}
```

Use the prefixed version if you also need to target Explorer 10, and old (&lt; 4.4) Android browsers:  

```html
.container {
    display: -ms-flexbox;
    display: -webkit-flex;
    display: flex;

    -ms-flex-align: center;
    -webkit-align-items: center;
    -webkit-box-align: center;

    align-items: center;
}
```

#### Answer 3 (score 107)
I used this very simple code:  

HTML:  

```html
<div class="ext-box">
    <div class="int-box">
        <h2>Some txt</h2>
        <p>bla bla bla</p>
    </div>
</div>
```

CSS:  

```html
div.ext-box { display: table; width:100%;}
div.int-box { display: table-cell; vertical-align: middle; }
```

Obviously, whether you use a `.class` or an `#id`, the result won't change.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: What characters can be used for up/down triangle (arrow without stem) for display in HTML? (score [1200054](https://stackoverflow.com/q/2701192) in 2016)

#### Question
I'm looking for a <strong>HTML</strong> or <strong>ASCII</strong> character which is a triangle pointing up or down so that I can use it as a toggle switch.  

I found &uarr; (`&amp;uarr;`), and &darr; (`&amp;darr;`) - but those have a narrow stem. I'm looking just for the HTML arrow "head".  

#### Answer accepted (score 1582)
Unicode arrows heads:  

<ul>
<li>▲ - U+25B2 BLACK UP-POINTING TRIANGLE</li>
<li>▼ - U+25BC BLACK DOWN-POINTING TRIANGLE</li>
<li>▴ - U+25B4 SMALL BLACK UP-POINTING TRIANGLE</li>
<li>▾ - U+25BE SMALL BLACK DOWN-POINTING TRIANGLE</li>
</ul>

For ▲ and ▼ use `&amp;#x25B2;` and `&amp;#x25BC;` respectively if you cannot include Unicode characters directly (use UTF-8!).  

Note that the font support for the smaller versions is not as good. Better to use the large versions in smaller font.  

More Unicode arrows are at:  

<ul>
<li><a href="http://en.wikipedia.org/wiki/Arrow_%28symbol%29#Arrows_in_Unicode" rel="noreferrer">http://en.wikipedia.org/wiki/Arrow_%28symbol%29#Arrows_in_Unicode</a></li>
<li><a href="http://en.wikipedia.org/wiki/Geometric_Shapes" rel="noreferrer">http://en.wikipedia.org/wiki/Geometric_Shapes</a></li>
</ul>

Lastly, these arrows are not ASCII, including ↑ and ↓: they are Unicode.  

#### Answer 2 (score 671)
<p><strong>For HTML Entities</strong>   <br/>
&#9668; = `&amp;#9668;` <br/>
&#9658; = `&amp;#9658;` <br/>
&#9660; = `&amp;#9660;` <br/>
&#9650; = `&amp;#9650;`</p>

#### Answer 3 (score 563)
<h5>OPTION 1: UNICODE COLUMN SORT ARROWS</h2>

I found this one very handy for a single character column sorter. <em>(Looks good upscaled)</em>.  

<strong>`&amp;#x21D5;`</strong> = ⇕  

<img src="https://i.stack.imgur.com/PR1CS.jpg" alt="Unicode table column sort arrows">  

<strong>IMPORTANT NOTE</strong> <em>(When using Unicode symbols)</em>  

Unicode support varies dependant on the symbol of choice, browser and the font family. If you find your chosen symbol does not work in some browsers then try using a different font-family. Microsoft recommends `"Segoe UI Symbol"` however it would be wise to include the font with your website as not many people have it on their computers.   

<strong>Open this page in other browsers to see which symbols render with the default font.</strong>  

<hr>

<strong>Some more Unicode arrows.</strong>  

You can copy them right off the page below or you can use the code.  

Each row of arrows is numbered from left to right:  

```html
0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F
```

Simply insert the corresponding number/letter before the closing semi-colon as above.  

<hr>

<strong>`&amp;#x219;`</strong>  

<h5>
←   ↑   →   ↓   ↔   ↕   ↖   ↗   ↘   ↙   ↚   ↛   ↜   ↝   ↞   ↟
</h1>

<hr>

<strong>`&amp;#x21A;`</strong>  

<h5>
↠   ↡   ↢   ↣   ↤   ↥   ↦   ↧   ↨   ↩   ↪   ↫   ↬   ↭   ↮   ↯
</h1>

<hr>

<strong>`&amp;#x21B;`</strong>  

<h5>
↰   ↱   ↲   ↳   ↴   ↵   ↶   ↷   ↸   ↹   ↺   ↻   ↼   ↽   ↾   ↿
</h1>

<hr>

<strong>`&amp;#x21C;`</strong>  

<h5>
⇀   ⇁   ⇂   ⇃   ⇄   ⇅   ⇆   ⇇   ⇈   ⇉   ⇊   ⇋   ⇌   ⇍   ⇎   ⇏
</h1>

<hr>

<strong>`&amp;#x21D;`</strong>  

<h5>
⇐   ⇑   ⇒   ⇓   ⇔   ⇕   ⇖   ⇗   ⇘   ⇙   ⇚   ⇛   ⇜   ⇝   ⇞   ⇟
</h1>

<hr>

<strong>`&amp;#x21E;`</strong>  

<h5>
⇠   ⇡   ⇢   ⇣   ⇤   ⇥   ⇦   ⇧   ⇨   ⇩   ⇪   ⇫   ⇬   ⇭   ⇮   ⇯
</h1>

<hr>

<strong>`&amp;#x21F;`</strong>  

<h5>    
⇰   ⇱   ⇲   ⇳   ⇴   ⇵   ⇶   ⇷   ⇸   ⇹   ⇺   ⇻   ⇼   ⇽   ⇾   ⇿
</h1>

<hr>

<strong>Additional HTML unicode symbols</strong>  

A selected list of other helpful Unicode icons/symbols.  

```html
U+2302  ⌂   HOUSE
U+2303  ⌃   UP ARROWHEAD
U+2304  ⌄   DOWN ARROWHEAD
U+2305  ⌅   PROJECTIVE
U+2306  ⌆   PERSPECTIVE
U+2307  ⌇   WAVY LINE
U+2315  ⌕   TELEPHONE RECORDER
U+2316  ⌖   POSITION INDICATOR
U+2317  ⌗   VIEWDATA SQUARE
U+2318  ⌘   PLACE OF INTEREST SIGN
U+231A  ⌚   WATCH
U+231B  ⌛   HOURGLASS
U+2326  ⌦   ERASE TO THE RIGHT
U+2327  ⌧   X IN A RECTANGLE BOX
U+2328  ⌨   KEYBOARD
U+2329  〈   LEFT-POINTING ANGLE BRACKET
U+232A  〉   RIGHT-POINTING ANGLE BRACKET
U+232B  ⌫   ERASE TO THE LEFT
U+23E9  ⏩   BLACK RIGHT-POINTING DOUBLE TRIANGLE
U+23EA  ⏪   BLACK LEFT-POINTING DOUBLE TRIANGLE
U+23EB  ⏫   BLACK UP-POINTING DOUBLE TRIANGLE
U+23EC  ⏬   BLACK DOWN-POINTING DOUBLE TRIANGLE
U+23ED  ⏭   BLACK RIGHT-POINTING DOUBLE TRIANGLE WITH VERTICAL BAR
U+23EE  ⏮   BLACK LEFT-POINTING DOUBLE TRIANGLE WITH VERTICAL BAR
U+23EF  ⏯   BLACK RIGHT-POINTING TRIANGLE WITH DOUBLE VERTICAL BAR
U+23F0  ⏰   ALARM CLOCK
U+23F1  ⏱   STOPWATCH
U+23F2  ⏲   TIMER CLOCK
U+23F3  ⏳   HOURGLASS WITH FLOWING SAND
U+2600  ☀   BLACK SUN WITH RAYS
U+2601  ☁   CLOUD
U+2602  ☂   UMBRELLA
U+2603  ☃   SNOWMAN
U+2604  ☄   COMET
U+2605  ★   BLACK STAR
U+2606  ☆   WHITE STAR
U+2607  ☇   LIGHTNING
U+2608  ☈   THUNDERSTORM
U+2609  ☉   SUN
U+260A  ☊   ASCENDING NODE
U+260B  ☋   DESCENDING NODE
U+260C  ☌   CONJUNCTION
U+260D  ☍   OPPOSITION
U+260E  ☎   BLACK TELEPHONE
U+260F  ☏   WHITE TELEPHONE
U+2610  ☐   BALLOT BOX
U+2611  ☑   BALLOT BOX WITH CHECK
U+2612  ☒   BALLOT BOX WITH X
U+2613  ☓   SALTIRE
U+2614  ☔   UMBRELLA WITH RAINDROPS
U+2615  ☕   HOT BEVERAGE
U+2616  ☖   WHITE SHOGI PIECE
U+2617  ☗   BLACK SHOGI PIECE
U+2618  ☘   SHAMROCK
U+2619  ☙   REVERSED ROTATED FLORAL HEART BULLET
U+261A  ☚   BLACK LEFT-POINTING INDEX
U+261B  ☛   BLACK RIGHT-POINTING INDEX
U+261C  ☜   WHITE LEFT POINTING INDEX
U+261D  ☝   WHITE UP POINTING INDEX
U+261E  ☞   WHITE RIGHT POINTING INDEX
U+261F  ☟   WHITE DOWN POINTING INDEX
U+2620  ☠   SKULL AND CROSSBONES
U+2621  ☡   CAUTION SIGN
U+2622  ☢   RADIOACTIVE SIGN
U+2623  ☣   BIOHAZARD SIGN
U+262A  ☪   STAR AND CRESCENT
U+262B  ☫   FARSI SYMBOL
U+262C  ☬   ADI SHAKTI
U+262D  ☭   HAMMER AND SICKLE
U+262E  ☮   PEACE SYMBOL
U+262F  ☯   YIN YANG
U+2638  ☸   WHEEL OF DHARMA
U+2639  ☹   WHITE FROWNING FACE
U+263A  ☺   WHITE SMILING FACE
U+263B  ☻   BLACK SMILING FACE
U+263C  ☼   WHITE SUN WITH RAYS
U+263D  ☽   FIRST QUARTER MOON
U+263E  ☾   LAST QUARTER MOON
U+263F  ☿   MERCURY
U+2640  ♀   FEMALE SIGN
U+2641  ♁   EARTH
U+2642  ♂   MALE SIGN
U+2643  ♃   JUPITER
U+2644  ♄   SATURN
U+2645  ♅   URANUS
U+2646  ♆   NEPTUNE
U+2647  ♇   PLUTO
U+2648  ♈   ARIES
U+2649  ♉   TAURUS
U+264A  ♊   GEMINI
U+264B  ♋   CANCER
U+264C  ♌   LEO
U+264D  ♍   VIRGO
U+264E  ♎   LIBRA
U+264F  ♏   SCORPIUS
U+2650  ♐   SAGITTARIUS
U+2651  ♑   CAPRICORN
U+2652  ♒   AQUARIUS
U+2653  ♓   PISCES
U+2654  ♔   WHITE CHESS KING
U+2655  ♕   WHITE CHESS QUEEN
U+2656  ♖   WHITE CHESS ROOK
U+2657  ♗   WHITE CHESS BISHOP
U+2658  ♘   WHITE CHESS KNIGHT
U+2659  ♙   WHITE CHESS PAWN
U+265A  ♚   BLACK CHESS KING
U+265B  ♛   BLACK CHESS QUEEN
U+265C  ♜   BLACK CHESS ROOK
U+265D  ♝   BLACK CHESS BISHOP
U+265E  ♞   BLACK CHESS KNIGHT
U+265F  ♟   BLACK CHESS PAWN
U+2660  ♠   BLACK SPADE SUIT
U+2661  ♡   WHITE HEART SUIT
U+2662  ♢   WHITE DIAMOND SUIT
U+2663  ♣   BLACK CLUB SUITE
U+2664  ♤   WHITE SPADE SUIT
U+2665  ♥   BLACK HEART SUIT
U+2666  ♦   BLACK DIAMOND SUIT
U+2667  ♧   WHITE CLUB SUITE
U+2668  ♨   HOT SPRINGS
U+2669  ♩   QUARTER NOTE
U+266A  ♪   EIGHTH NOTE
U+266B  ♫   BEAMED EIGHTH NOTES
U+266C  ♬   BEAMED SIXTEENTH NOTES
U+266D  ♭   MUSIC FLAT SIGN
U+266E  ♮   MUSIC NATURAL SIGN
U+266F  ♯   MUSIC SHARP SIGN
U+267A  ♺   RECYCLING SYMBOL FOR GENERIC MATERIALS
U+267B  ♻   BLACK UNIVERSAL RECYCLING SYMBOL
U+267C  ♼   RECYCLED PAPER SYMBOL
U+267D  ♽   PARTIALLY-RECYCLED PAPER SYMBOL
U+267E  ♾   PERMANENT PAPER SIGN
U+267F  ♿   WHEELCHAIR SYMBOL
U+2680  ⚀   DIE FACE-1
U+2681  ⚁   DIE FACE-2
U+2682  ⚂   DIE FACE-3
U+2683  ⚃   DIE FACE-4
U+2684  ⚄   DIE FACE-5
U+2685  ⚅   DIE FACE-6
U+2686  ⚆   WHITE CIRCLE WITH DOT RIGHT
U+2687  ⚇   WHITE CIRCLE WITH TWO DOTS
U+2688  ⚈   BLACK CIRCLE WITH WHITE DOT RIGHT
U+2689  ⚉   BLACK CIRCLE WITH TWO WHITE DOTS
U+268A  ⚊   MONOGRAM FOR YANG
U+268B  ⚋   MONOGRAM FOR YIN
U+268C  ⚌   DIGRAM FOR GREATER YANG
U+268D  ⚍   DIGRAM FOR LESSER YIN
U+268E  ⚎   DIGRAM FOR LESSER YANG
U+268F  ⚏   DIGRAM FOR GREATER YIN
U+2690  ⚐   WHITE FLAG
U+2691  ⚑   BLACK FLAG
U+2692  ⚒   HAMMER AND PICK
U+2693  ⚓   ANCHOR
U+2694  ⚔   CROSSED SWORDS
U+2695  ⚕   STAFF OF AESCULAPIUS
U+2696  ⚖   SCALES
U+2697  ⚗   ALEMBIC
U+2698  ⚘   FLOWER
U+2699  ⚙   GEAR
U+269A  ⚚   STAFF OF HERMES
U+269B  ⚛   ATOM SYMBOL
U+269C  ⚜   FLEUR-DE-LIS
U+269D  ⚝   OUTLINED WHITE STAR
U+269E  ⚞   THREE LINES CONVERGING RIGHT
U+269F  ⚟   THREE LINES CONVERGING LEFT
U+26A0  ⚠   WARNING SIGN
U+26A1  ⚡   HIGH VOLTAGE SIGN
U+26A2  ⚢   DOUBLED FEMALE SIGN
U+26A3  ⚣   DOUBLED MALE SIGN
U+26A4  ⚤   INTERLOCKED FEMALE AND MALE SIGN
U+26A5  ⚥   MALE AND FEMALE SIGN
U+26A6  ⚦   MALE WITH STROKE SIGN
U+26A7  ⚧   MALE WITH STROKE AND MALE AND FEMALE SIGN
U+26A8  ⚨   VERTICAL MALE WITH STROKE SIGN
U+26A9  ⚩   HORIZONTAL MALE WITH STROKE SIGN
U+26AA  ⚪   MEDIUM WHITE CIRCLE
U+26AB  ⚫   MEDIUM BLACK CIRCLE
U+26BD  ⚽   SOCCER BALL
U+26BE  ⚾   BASEBALL
U+26BF  ⚿   SQUARED KEY
U+26C0  ⛀   WHITE DRAUGHTSMAN
U+26C1  ⛁   WHITE DRAUGHTS KING
U+26C2  ⛂   BLACK DRAUGHTSMAN
U+26C3  ⛃   BLACK DRAUGHTS KING
U+26C4  ⛄   SNOWMAN WITHOUT SNOW
U+26C5  ⛅   SUN BEHIND CLOUD
U+26C6  ⛆   RAIN
U+26C7  ⛇   BLACK SNOWMAN
U+26C8  ⛈   THUNDER CLOUD AND RAIN
U+26C9  ⛉   TURNED WHITE SHOGI PIECE
U+26CA  ⛊   TURNED BLACK SHOGI PIECE
U+26CB  ⛋   WHITE DIAMOND IN SQUARE
U+26CC  ⛌   CROSSING LANES
U+26CD  ⛍   DISABLED CAR
U+26CE  ⛎   OPHIUCHUS
U+26CF  ⛏   PICK
U+26D0  ⛐   CAR SLIDING
U+26D1  ⛑   HELMET WITH WHITE CROSS
U+26D2  ⛒   CIRCLED CROSSING LANES
U+26D3  ⛓   CHAINS
U+26D4  ⛔   NO ENTRY
U+26D5  ⛕   ALTERNATE ONE-WAY LEFT WAY TRAFFIC
U+26D6  ⛖   BLACK TWO-WAY LEFT WAY TRAFFIC
U+26D7  ⛗   WHITE TWO-WAY LEFT WAY TRAFFIC
U+26D8  ⛘   BLACK LEFT LANE MERGE
U+26D9  ⛙   WHITE LEFT LANE MERGE
U+26DA  ⛚   DRIVE SLOW SIGN
U+26DB  ⛛   HEAVY WHITE DOWN-POINTING TRIANGLE
U+26DC  ⛜   LEFT CLOSED ENTRY
U+26DD  ⛝   SQUARED SALTIRE
U+26DE  ⛞   FALLING DIAGONAL IN WHITE CIRCLE IN BLACK SQUARE
U+26DF  ⛟   BLACK TRUCK
U+26E0  ⛠   RESTRICTED LEFT ENTRY-1
U+26E1  ⛡   RESTRICTED LEFT ENTRY-2
U+26E2  ⛢   ASTRONOMICAL SYMBOL FOR URANUS
U+26E3  ⛣   HEAVY CIRCLE WITH STROKE AND TWO DOTS ABOVE
U+26E4  ⛤   PENTAGRAM
U+26E5  ⛥   RIGHT-HANDED INTERLACED PENTAGRAM
U+26E6  ⛦   LEFT-HANDED INTERLACED PENTAGRAM
U+26E7  ⛧   INVERTED PENTAGRAM
U+26E8  ⛨   BLACK CROSS ON SHIELD
U+26E9  ⛩   SHINTO SHRINE
U+26EA  ⛪   CHURCH
U+26EB  ⛫   CASTLE
U+26EC  ⛬   HISTORIC SITE
U+26ED  ⛭   GEAR WITHOUT HUB
U+26EE  ⛮   GEAR WITH HANDLES
U+26EF  ⛯   MAP SYMBOL FOR LIGHTHOUSE
U+26F0  ⛰   MOUNTAIN
U+26F1  ⛱   UMBRELLA ON GROUND
U+26F2  ⛲   FOUNTAIN
U+26F3  ⛳   FLAG IN HOLE
U+26F4  ⛴   FERRY
U+26F5  ⛵   SAILBOAT
U+26F6  ⛶   SQUARE FOUR CORNERS
U+26F7  ⛷   SKIER
U+26F8  ⛸   ICE SKATE
U+26F9  ⛹   PERSON WITH BALL
U+26FA  ⛺   TENT
U+26FD  ⛽   FUEL PUMP
U+26FE  ⛾   CUP ON BLACK SQUARE
U+26FF  ⛿   WHITE FLAG WITH HORIZONTAL MIDDLE BLACK STRIPE
U+2701  ✁   UPPER BLADE SCISSORS
U+2702  ✂   BLACK SCISSORS
U+2703  ✃   LOWER BLADE SCISSORS
U+2704  ✄   WHITE SCISSORS
U+2705  ✅   WHITE HEAVY CHECK MARK
U+2706  ✆   TELEPHONE LOCATION SIGN
U+2707  ✇   TAPE DRIVE
U+2708  ✈   AIRPLANE
U+2709  ✉   ENVELOPE
U+270A  ✊   RAISED FIST
U+270B  ✋   RAISED HAND
U+270C  ✌   VICTORY HAND
U+270D  ✍   WRITING HAND
U+270E  ✎   LOWER RIGHT PENCIL
U+270F  ✏   PENCIL
U+2710  ✐   UPPER RIGHT PENCIL
U+2711  ✑   WHITE NIB
U+2712  ✒   BLACK NIB
U+2713  ✓   CHECK MARK
U+2714  ✔   HEAVY CHECK MARK
U+2715  ✕   MULTIPLICATION X
U+2716  ✖   HEAVY MULTIPLICATION X
U+2717  ✗   BALLOT X
U+2718  ✘   HEAVY BALLOT X
U+2719  ✙   OUTLINED GREEK CROSS
U+271A  ✚   HEAVY GREEK CROSS
U+271B  ✛   OPEN CENTRE CROSS
U+271C  ✜   HEAVY OPEN CENTRE CROSS
U+271D  ✝   LATIN CROSS
U+271E  ✞   SHADOWED WHITE LATIN CROSS
U+271F  ✟   OUTLINED LATIN CROSS
U+2720  ✠   MALTESE CROSS
U+2721  ✡   STAR OF DAVID
U+2722  ✢   FOUR TEARDROP-SPOKED ASTERISK
U+2723  ✣   FOUR BALLOON-SPOKED ASTERISK
U+2724  ✤   HEAVY FOUR BALLOON-SPOKED ASTERISK
U+2725  ✥   FOUR CLUB-SPOKED ASTERISK
U+2726  ✦   BLACK FOUR POINTED STAR
U+2727  ✧   WHITE FOUR POINTED STAR
U+2728  ✨   SPARKLES
U+2729  ✩   STRESS OUTLINED WHITE STAR
U+272A  ✪   CIRCLED WHITE STAR
U+272B  ✫   OPEN CENTRE BLACK STAR
U+272C  ✬   BLACK CENTRE WHITE STAR
U+272D  ✭   OUTLINED BLACK STAR
U+272E  ✮   HEAVY OUTLINED BLACK STAR
U+272F  ✯   PINWHEEL STAR
U+2730  ✰   SHADOWED WHITE STAR
U+2731  ✱   HEAVY ASTERISK
U+2732  ✲   OPEN CENTRE ASTERISK
U+2733  ✳   EIGHT SPOKED ASTERISK
U+2734  ✴   EIGHT POINTED BLACK STAR
U+2735  ✵   EIGHT POINTED PINWHEEL STAR
U+2736  ✶   SIX POINTED BLACK STAR
U+2737  ✷   EIGHT POINTED RECTILINEAR BLACK STAR
U+2738  ✸   HEAVY EIGHT POINTED RECTILINEAR BLACK STAR
U+2739  ✹   TWELVE POINTED BLACK STAR
U+273A  ✺   SIXTEEN POINTED ASTERISK
U+273B  ✻   TEARDROP-SPOKED ASTERISK
U+273C  ✼   OPEN CENTRE TEARDROP-SPOKED ASTERISK
U+273D  ✽   HEAVY TEARDROP-SPOKED ASTERISK
U+273E  ✾   SIX PETALLED BLACK AND WHITE FLORETTE
U+273F  ✿   BLACK FLORETTE
U+2740  ❀   WHITE FLORETTE
U+2741  ❁   EIGHT PETALLED OUTLINED BLACK FLORETTE
U+2742  ❂   CIRCLED OPEN CENTRE EIGHT POINTED STAR
U+2743  ❃   HEAVY TEARDROP-SPOKED PINWHEEL ASTERISK
U+2744  ❄   SNOWFLAKE
U+2745  ❅   TIGHT TRIFOLIATE SNOWFLAKE
U+2746  ❆   HEAVY CHEVRON SNOWFLAKE
U+2747  ❇   SPARKLE
U+2748  ❈   HEAVY SPARKLE
U+2749  ❉   BALLOON-SPOKED ASTERISK
U+274A  ❊   EIGHT TEARDROP-SPOKED PROPELLER ASTERISK
U+274B  ❋   HEAVY EIGHT TEARDROP-SPOKED PROPELLER ASTERISK
U+274C  ❌   CROSS MARK
U+274D  ❍   SHADOWED WHITE CIRCLE
U+274E  ❎   NEGATIVE SQUARED CROSS MARK
U+2753  ❓   BLACK QUESTION MARK ORNAMENT
U+2754  ❔   WHITE QUESTION MARK ORNAMENT
U+2755  ❕   WHITE EXCLAMATION MARK ORNAMENT
U+2756  ❖   BLACK DIAMOND MINUS WHITE X
U+2757  ❗   HEAVY EXCLAMATION MARK SYMBOL
U+275B  ❛   HEAVY SINGLE TURNED COMMA QUOTATION MARK ORNAMENT
U+275C  ❜   HEAVY SINGLE COMMA QUOTATION MARK ORNAMENT
U+275D  ❝   HEAVY DOUBLE TURNED COMMA QUOTATION MARK ORNAMENT
U+275E  ❞   HEAVY DOUBLE COMMA QUOTATION MARK ORNAMENT
U+275F  ❟   HEAVY LOW SINGLE COMMA QUOTATION MARK ORNAMENT
U+2760  ❠   HEAVY LOW DOUBLE COMMA QUOTATION MARK ORNAMENT
U+2761  ❡   CURVED STEM PARAGRAPH SIGN ORNAMENT
U+2762  ❢   HEAVY EXCLAMATION MARK ORNAMENT
U+2763  ❣   HEAVY HEART EXCLAMATION MARK ORNAMENT
U+2764  ❤   HEAVY BLACK HEART
U+2765  ❥   ROTATED HEAVY BLACK HEART BULLET
U+2766  ❦   FLORAL HEART
U+2767  ❧   ROTATED FLORAL HEART BULLET
U+276C  ❬   MEDIUM LEFT-POINTING ANGLE BRACKET ORNAMENT
U+276D  ❭   MEDIUM RIGHT-POINTING ANGLE BRACKET ORNAMENT
U+276E  ❮   HEAVY LEFT-POINTING ANGLE QUOTATION MARK ORNAMENT
U+276F  ❯   HEAVY RIGHT-POINTING ANGLE QUOTATION MARK ORNAMENT
U+2770  ❰   HEAVY LEFT-POINTING ANGLE BRACKET ORNAMENT
U+2771  ❱   HEAVY RIGHT-POINTING ANGLE BRACKET ORNAMENT
U+2794  ➔   HEAVY WIDE-HEADED RIGHTWARDS ARROW
U+2795  ➕   HEAVY PLUS SIGN
U+2796  ➖   HEAVY MINUS SIGN
U+2797  ➗   HEAVY DIVISION SIGN
U+2798  ➘   HEAVY SOUTH EAST ARROW
U+2799  ➙   HEAVY RIGHTWARDS ARROW
U+279A  ➚   HEAVY NORTH EAST ARROW
U+279B  ➛   DRAFTING POINT RIGHTWARDS ARROW
U+279C  ➜   HEAVY ROUND-TIPPED RIGHTWARDS ARROW
U+279D  ➝   TRIANGLE-HEADED RIGHTWARDS ARROW
U+279E  ➞   HEAVY TRIANGLE-HEADED RIGHTWARDS ARROW
U+279F  ➟   DASHED TRIANGLE-HEADED RIGHTWARDS ARROW
U+27A0  ➠   HEAVY DASHED TRIANGLE-HEADED RIGHTWARDS ARROW
U+27A1  ➡   BLACK RIGHTWARDS ARROW
U+27A2  ➢   THREE-D TOP-LIGHTED RIGHTWARDS ARROWHEAD
U+27A3  ➣   THREE-D BOTTOM-LIGHTED RIGHTWARDS ARROWHEAD
U+27A4  ➤   BLACK RIGHTWARDS ARROWHEAD
U+27A5  ➥   HEAVY BLACK CURVED DOWNWARDS AND RIGHTWARDS ARROW
U+27A6  ➦   HEAVY BLACK CURVED UPWARDS AND RIGHTWARDS ARROW
U+27A7  ➧   SQUAT BLACK RIGHTWARDS ARROW
U+27A8  ➨   HEAVY CONCAVE-POINTED BLACK RIGHTWARDS ARROW
U+27A9  ➩   RIGHT-SHADED WHITE RIGHTWARDS ARROW
U+27AA  ➪   LEFT-SHADED WHITE RIGHTWARDS ARROW
U+27AB  ➫   BACK-TILTED SHADOWED WHITE RIGHTWARDS ARROW
U+27AC  ➬   FRONT-TILTED SHADOWED WHITE RIGHTWARDS ARROW
U+27AD  ➭   HEAVY LOWER RIGHT-SHADOWED WHITE RIGHTWARDS ARROW
U+27AE  ➮   HEAVY UPPER RIGHT-SHADOWED WHITE RIGHTWARDS ARROW
U+27AF  ➯   NOTCHED LOWER RIGHT-SHADOWED WHITE RIGHTWARDS ARROW
U+27B0  ➰   CURLY LOOP
U+27B1  ➱   NOTCHED UPPER RIGHT-SHADOWED WHITE RIGHTWARDS ARROW
U+27B2  ➲   CIRCLED HEAVY WHITE RIGHTWARDS ARROW
U+27B3  ➳   WHITE-FEATHERED RIGHTWARDS ARROW
U+27B4  ➴   BLACK-FEATHERED SOUTH EAST ARROW
U+27B5  ➵   BLACK-FEATHERED RIGHTWARDS ARROW
U+27B6  ➶   BLACK-FEATHERED NORTH EAST ARROW
U+27B7  ➷   HEAVY BLACK-FEATHERED SOUTH EAST ARROW
U+27B8  ➸   HEAVY BLACK-FEATHERED RIGHTWARDS ARROW
U+27B9  ➹   HEAVY BLACK-FEATHERED NORTH EAST ARROW
U+27BA  ➺   TEARDROP-BARBED RIGHTWARDS ARROW
U+27BB  ➻   HEAVY TEARDROP-SHANKED RIGHTWARDS ARROW
U+27BC  ➼   WEDGE-TAILED RIGHTWARDS ARROW
U+27BD  ➽   HEAVY WEDGE-TAILED RIGHTWARDS ARROW
U+27BE  ➾   OPEN-OUTLINED RIGHTWARDS ARROW
U+27C0  ⟀   THREE DIMENSIONAL ANGLE
U+27E8  ⟨   MATHEMATICAL LEFT ANGLE BRACKET
U+27E9  ⟩   MATHEMATICAL RIGHT ANGLE BRACKET
U+27EA  ⟪   MATHEMATICAL LEFT DOUBLE ANGLE BRACKET
U+27EB  ⟫   MATHEMATICAL RIGHT DOUBLE ANGLE BRACKET
U+27F0  ⟰   UPWARDS QUADRUPLE ARROW
U+27F1  ⟱   DOWNWARDS QUADRUPLE ARROW
U+27F2  ⟲   ANTICLOCKWISE GAPPED CIRCLE ARROW
U+27F3  ⟳   CLOCKWISE GAPPED CIRCLE ARROW
U+27F4  ⟴   RIGHT ARROW WITH CIRCLED PLUS
U+27F5  ⟵   LONG LEFTWARDS ARROW
U+27F6  ⟶   LONG RIGHTWARDS ARROW
U+27F7  ⟷   LONG LEFT RIGHT ARROW
U+27F8  ⟸   LONG LEFTWARDS DOUBLE ARROW
U+27F9  ⟹   LONG RIGHTWARDS DOUBLE ARROW
U+27FA  ⟺   LONG LEFT RIGHT DOUBLE ARROW
U+27FB  ⟻   LONG LEFTWARDS ARROW FROM BAR
U+27FC  ⟼   LONG RIGHTWARDS ARROW FROM BAR
U+27FD  ⟽   LONG LEFTWARDS DOUBLE ARROW FROM BAR
U+27FE  ⟾   LONG RIGHTWARDS DOUBLE ARROW FROM BAR
U+27FF  ⟿   LONG RIGHTWARDS SQUIGGLE ARROW
U+2900  ⤀   RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE
U+2901  ⤁   RIGHTWARDS TWO-HEADED ARROW WITH DOUBLE VERTICAL STROKE
U+2902  ⤂   LEFTWARDS DOUBLE ARROW WITH VERTICAL STROKE
U+2903  ⤃   RIGHTWARDS DOUBLE ARROW WITH VERTICAL STROKE
U+2904  ⤄   LEFT RIGHT DOUBLE ARROW WITH VERTICAL STROKE
U+2905  ⤅   RIGHTWARDS TWO-HEADED ARROW FROM BAR
U+2906  ⤆   LEFTWARDS DOUBLE ARROW FROM BAR
U+2907  ⤇   RIGHTWARDS DOUBLE ARROW FROM BAR
U+2908  ⤈   DOWNWARDS ARROW WITH HORIZONTAL STROKE
U+2909  ⤉   UPWARDS ARROW WITH HORIZONTAL STROKE
U+290A  ⤊   UPWARDS TRIPLE ARROW
U+290B  ⤋   DOWNWARDS TRIPLE ARROW
U+290C  ⤌   LEFTWARDS DOUBLE DASH ARROW
U+290D  ⤍   RIGHTWARDS DOUBLE DASH ARROW
U+290E  ⤎   LEFTWARDS TRIPLE DASH ARROW
U+290F  ⤏   RIGHTWARDS TRIPLE DASH ARROW
U+2910  ⤐   RIGHTWARDS TWO-HEADED TRIPLE DASH ARROW
U+2911  ⤑   RIGHTWARDS ARROW WITH DOTTED STEM
U+2912  ⤒   UPWARDS ARROW TO BAR
U+2913  ⤓   DOWNWARDS ARROW TO BAR
U+2914  ⤔   RIGHTWARDS ARROW WITH TAIL WITH VERTICAL STROKE
U+2915  ⤕   RIGHTWARDS ARROW WITH TAIL WITH DOUBLE VERTICAL STROKE
U+2916  ⤖   RIGHTWARDS TWO-HEADED ARROW WITH TAIL
U+2917  ⤗   RIGHTWARDS TWO-HEADED ARROW WITH TAIL WITH VERTICAL STROKE
U+2918  ⤘   RIGHTWARDS TWO-HEADED ARROW WITH TAIL WITH DOUBLE VERTICAL STROKE
U+2919  ⤙   LEFTWARDS ARROW-TAIL
U+291A  ⤚   RIGHTWARDS ARROW-TAIL
U+291B  ⤛   LEFTWARDS DOUBLE ARROW-TAIL
U+291C  ⤜   RIGHTWARDS DOUBLE ARROW-TAIL
U+291D  ⤝   LEFTWARDS ARROW TO BLACK DIAMOND
U+291E  ⤞   RIGHTWARDS ARROW TO BLACK DIAMOND
U+291F  ⤟   LEFTWARDS ARROW FROM BAR TO BLACK DIAMOND
U+2920  ⤠   RIGHTWARDS ARROW FROM BAR TO BLACK DIAMOND
U+2921  ⤡   NORTHWEST AND SOUTH EAST ARROW
U+2922  ⤢   NORTHEAST AND SOUTH WEST ARROW
U+2923  ⤣   NORTH WEST ARROW WITH HOOK
U+2924  ⤤   NORTH EAST ARROW WITH HOOK
U+2925  ⤥   SOUTH EAST ARROW WITH HOOK
U+2926  ⤦   SOUTH WEST ARROW WITH HOOK
U+2927  ⤧   NORTH WEST ARROW AND NORTH EAST ARROW
U+2928  ⤨   NORTH EAST ARROW AND SOUTH EAST ARROW
U+2929  ⤩   SOUTH EAST ARROW AND SOUTH WEST ARROW
U+292A  ⤪   SOUTH WEST ARROW AND NORTH WEST ARROW
U+292B  ⤫   RISING DIAGONAL CROSSING FALLING DIAGONAL
U+292C  ⤬   FALLING DIAGONAL CROSSING RISING DIAGONAL
U+292D  ⤭   SOUTH EAST ARROW CROSSING NORTH EAST ARROW
U+292E  ⤮   NORTH EAST ARROW CROSSING SOUTH EAST ARROW
U+292F  ⤯   FALLING DIAGONAL CROSSING NORTH EAST ARROW
U+2930  ⤰   RISING DIAGONAL CROSSING SOUTH EAST ARROW
U+2931  ⤱   NORTH EAST ARROW CROSSING NORTH WEST ARROW
U+2932  ⤲   NORTH WEST ARROW CROSSING NORTH EAST ARROW
U+2933  ⤳   WAVE ARROW POINTING DIRECTLY RIGHT
U+2934  ⤴   ARROW POINTING RIGHTWARDS THEN CURVING UPWARDS
U+2935  ⤵   ARROW POINTING RIGHTWARDS THEN CURVING DOWNWARDS
U+2936  ⤶   ARROW POINTING DOWNWARDS THEN CURVING LEFTWARDS
U+2937  ⤷   ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS
U+2938  ⤸   RIGHT-SIDE ARC CLOCKWISE ARROW
U+2939  ⤹   LEFT-SIDE ARC ANTICLOCKWISE ARROW
U+293A  ⤺   TOP ARC ANTICLOCKWISE ARROW
U+293B  ⤻   BOTTOM ARC ANTICLOCKWISE ARROW
U+293C  ⤼   TOP ARC CLOCKWISE ARROW WITH MINUS
U+293D  ⤽   TOP ARC ANTICLOCKWISE ARROW WITH PLUS
U+293E  ⤾   LOWER RIGHT SEMICIRCULAR CLOCKWISE ARROW
U+293F  ⤿   LOWER LEFT SEMICIRCULAR ANTICLOCKWISE ARROW
U+2940  ⥀   ANTICLOCKWISE CLOSED CIRCLE ARROW
U+2941  ⥁   CLOCKWISE CLOSED CIRCLE ARROW
U+2942  ⥂   RIGHTWARDS ARROW ABOVE SHORT LEFTWARDS ARROW
U+2943  ⥃   LEFTWARDS ARROW ABOVE SHORT RIGHTWARDS ARROW
U+2944  ⥄   SHORT RIGHTWARDS ARROW ABOVE LEFTWARDS ARROW
U+2945  ⥅   RIGHTWARDS ARROW WITH PLUS BELOW
U+2946  ⥆   LEFTWARDS ARROW WITH PLUS BELOW
U+2962  ⥢   LEFTWARDS HARPOON WITH BARB UP ABOVE LEFTWARDS HARPOON WITH BARB DOWN
U+2963  ⥣   UPWARDS HARPOON WITH BARB LEFT BESIDE UPWARDS HARPOON WITH BARB RIGHT
U+2964  ⥤   RIGHTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB DOWN
U+2965  ⥥   DOWNWARDS HARPOON WITH BARB LEFT BESIDE DOWNWARDS HARPOON WITH BARB RIGHT
U+2966  ⥦   LEFTWARDS HARPOON WITH BARB UP ABOVE RIGHTWARDS HARPOON WITH BARB UP
U+2967  ⥧   LEFTWARDS HARPOON WITH BARB DOWN ABOVE RIGHTWARDS HARPOON WITH BARB DOWN
U+2968  ⥨   RIGHTWARDS HARPOON WITH BARB UP ABOVE LEFTWARDS HARPOON WITH BARB UP
U+2969  ⥩   RIGHTWARDS HARPOON WITH BARB DOWN ABOVE LEFTWARDS HARPOON WITH BARB DOWN
U+296A  ⥪   LEFTWARDS HARPOON WITH BARB UP ABOVE LONG DASH
U+296B  ⥫   LEFTWARDS HARPOON WITH BARB DOWN BELOW LONG DASH
U+296C  ⥬   RIGHTWARDS HARPOON WITH BARB UP ABOVE LONG DASH
U+296D  ⥭   RIGHTWARDS HARPOON WITH BARB DOWN BELOW LONG DASH
U+296E  ⥮   UPWARDS HARPOON WITH BARB LEFT BESIDE DOWNWARDS HARPOON WITH BARB RIGHT
U+296F  ⥯   DOWNWARDS HARPOON WITH BARB LEFT BESIDE UPWARDS HARPOON WITH BARB RIGHT
U+2989  ⦉   Z NOTATION LEFT BINDING BRACKET
U+298A  ⦊   Z NOTATION RIGHT BINDING BRACKET
U+2991  ⦑   LEFT ANGLE BRACKET WITH DOT
U+2992  ⦒   RIGHT ANGLE BRACKET WITH DOT
U+2993  ⦓   LEFT ARC LESS-THAN BRACKET
U+2994  ⦔   RIGHT ARC GREATER-THAN BRACKET
U+2995  ⦕   DOUBLE LEFT ARC GREATER-THAN BRACKET
U+2996  ⦖   DOUBLE RIGHT ARC LESS-THAN BRACKET
U+29A8  ⦨   MEASURED ANGLE WITH OPEN ARM ENDING IN ARROW POINTING UP AND RIGHT
U+29A9  ⦩   MEASURED ANGLE WITH OPEN ARM ENDING IN ARROW POINTING UP AND LEFT
U+29AA  ⦪   MEASURED ANGLE WITH OPEN ARM ENDING IN ARROW POINTING DOWN AND RIGHT
U+29AB  ⦫   MEASURED ANGLE WITH OPEN ARM ENDING IN ARROW POINTING DOWN AND LEFT
U+29AC  ⦬   MEASURED ANGLE WITH OPEN ARM ENDING IN ARROW POINTING RIGHT AND UP
U+29AD  ⦭   MEASURED ANGLE WITH OPEN ARM ENDING IN ARROW POINTING LEFT AND UP
U+29AE  ⦮   MEASURED ANGLE WITH OPEN ARM ENDING IN ARROW POINTING RIGHT AND DOWN
U+29AF  ⦯   MEASURED ANGLE WITH OPEN ARM ENDING IN ARROW POINTING LEFT AND DOWN
U+29BE  ⦾   CIRCLED WHITE BULLET
U+29BF  ⦿   CIRCLED BULLET
U+29C9  ⧉   TWO JOINED SQUARES
U+29CE  ⧎   RIGHT TRIANGLE ABOVE LEFT TRIANGLE
U+29CF  ⧏   LEFT TRIANGLE BESIDE VERTICAL BAR
U+29D0  ⧐   VERTICAL BAR BESIDE RIGHT TRIANGLE
U+29D1  ⧑   BOWTIE WITH LEFT HALF BLACK
U+29D2  ⧒   BOWTIE WITH RIGHT HALF BLACK
U+29D3  ⧓   BLACK BOWTIE
U+29D4  ⧔   TIMES WITH LEFT HALF BLACK
U+29D5  ⧕   TIMES WITH RIGHT HALF BLACK
U+29D6  ⧖   WHITE HOURGLASS
U+29D7  ⧗   BLACK HOURGLASS
U+29E8  ⧨   DOWN-POINTING TRIANGLE WITH LEFT HALF BLACK
U+29E9  ⧩   DOWN-POINTING TRIANGLE WITH RIGHT HALF BLACK
U+29EA  ⧪   BLACK DIAMOND WITH DOWN ARROW
U+29EB  ⧫   BLACK LOZENGE
U+29EC  ⧬   WHITE CIRCLE WITH DOWN ARROW
U+29ED  ⧭   BLACK CIRCLE WITH DOWN ARROW
U+29F4  ⧴   RULE-DELAYED
U+29FC  ⧼   LEFT-POINTING CURVED ANGLE BRACKET
U+29FD  ⧽   RIGHT-POINTING CURVED ANGLE BRACKET
U+29FE  ⧾   TINY
U+29FF  ⧿   MINY
U+2B00  ⬀   NORTH EAST WHITE ARROW
U+2B01  ⬁   NORTH WEST WHITE ARROW
U+2B02  ⬂   SOUTH EAST WHITE ARROW
U+2B03  ⬃   SOUTH WEST WHITE ARROW
U+2B04  ⬄   LEFT RIGHT WHITE ARROW
U+2B05  ⬅   LEFTWARDS BLACK ARROW
U+2B06  ⬆   UPWARDS BLACK ARROW
U+2B07  ⬇   DOWNWARDS BLACK ARROW
U+2B08  ⬈   NORTH EAST BLACK ARROW
U+2B09  ⬉   NORTH WEST BLACK ARROW
U+2B0A  ⬊   SOUTH EAST BLACK ARROW
U+2B0B  ⬋   SOUTHWEST BLACK ARROW
U+2B0C  ⬌   LEFT RIGHT BLACK ARROW
U+2B0D  ⬍   UP DOWN BLACK ARROW
U+2B0E  ⬎   RIGHTWARDS ARROW WITH TIP DOWNWARDS
U+2B0F  ⬏   RIGHTWARDS ARROW WITH TIP UPWARDS
U+2B10  ⬐   LEFTWARDS ARROW WITH TIP DOWNWARDS
U+2B11  ⬑   LEFTWARDS ARROW WITH TIP UPWARDS
U+2B12  ⬒   SQUARE WITH TOP HALF BLACK
U+2B13  ⬓   SQUARE WITH BOTTOM HALF BLACK
U+2B14  ⬔   SQUARE WITH UPPER RIGHT DIAGONAL HALF BLACK
U+2B15  ⬕   SQUARE WITH LOWER LEFT DIAGONAL HALF BLACK
U+2B16  ⬖   DIAMOND WITH LEFT HALF BLACK
U+2B17  ⬗   DIAMOND WITH RIGHT HALF BLACK
U+2B18  ⬘   DIAMOND WITH TOP HALF BLACK
U+2B19  ⬙   DIAMOND WITH BOTTOM HALF BLACK
U+2B1A  ⬚   DOTTED SQUARE
U+2B1B  ⬛   BLACK LARGE SQUARE
U+2B1C  ⬜   WHITE LARGE SQUARE
U+2B1D  ⬝   BLACK VERY SMALL SQUARE
U+2B1E  ⬞   WHITE VERY SMALL SQUARE
U+2B1F  ⬟   BLACK PENTAGON
U+2B20  ⬠   WHITE PENTAGON
U+2B21  ⬡   WHITE HEXAGON
U+2B22  ⬢   BLACK HEXAGON
U+2B23  ⬣   HORIZONTAL BLACK HEXAGON
U+2B24  ⬤   BLACK LARGE CIRCLE
U+2B25  ⬥   BLACK MEDIUM DIAMOND
U+2B26  ⬦   WHITE MEDIUM DIAMOND
U+2B27  ⬧   BLACK MEDIUM LOZENGE
U+2B28  ⬨   WHITE MEDIUM LOZENGE
U+2B29  ⬩   BLACK SMALL DIAMOND
U+2B2A  ⬪   BLACK SMALL LOZENGE
U+2B2B  ⬫   WHITE SMALL LOZENGE
U+2B30  ⬰   LEFT ARROW WITH SMALL CIRCLE
U+2B31  ⬱   THREE LEFTWARDS ARROWS
U+2B32  ⬲   LEFT ARROW WITH CIRCLED PLUS
U+2B33  ⬳   LONG LEFTWARDS SQUIGGLE ARROW
U+2B34  ⬴   LEFTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE
U+2B35  ⬵   LEFTWARDS TWO-HEADED ARROW WITH DOUBLE VERTICAL STROKE
U+2B36  ⬶   LEFTWARDS TWO-HEADED ARROW FROM BAR
U+2B37  ⬷   LEFTWARDS TWO-HEADED TRIPLE DASH ARROW
U+2B38  ⬸   LEFTWARDS ARROW WITH DOTTED STEM
U+2B39  ⬹   LEFTWARDS ARROW WITH TAIL WITH VERTICAL STROKE
U+2B3A  ⬺   LEFTWARDS ARROW WITH TAIL WITH DOUBLE VERTICAL STROKE
U+2B3B  ⬻   LEFTWARDS TWO-HEADED ARROW WITH TAIL
U+2B3C  ⬼   LEFTWARDS TWO-HEADED ARROW WITH TAIL WITH VERTICAL STROKE
U+2B3D  ⬽   LEFTWARDS TWO-HEADED ARROW WITH TAIL WITH DOUBLE VERTICAL STROKE
U+2B3E  ⬾   LEFTWARDS ARROW THROUGH X
U+2B3F  ⬿   WAVE ARROW POINTING DIRECTLY LEFT
U+2B40  ⭀   EQUALS SIGN ABOVE LEFTWARDS ARROW
U+2B41  ⭁   REVERSE TILDE OPERATOR ABOVE LEFTWARDS ARROW
U+2B42  ⭂   LEFTWARDS ARROW ABOVE REVERSE ALMOST EQUAL TO
U+2B43  ⭃   RIGHTWARDS ARROW THROUGH GREATER-THAN
U+2B44  ⭄   RIGHTWARDS ARROW THROUGH SUPERSET
U+2B45  ⭅   LEFTWARDS QUADRUPLE ARROW
U+2B46  ⭆   RIGHTWARDS QUADRUPLE ARROW
U+2B47  ⭇   REVERSE TILDE OPERATOR ABOVE RIGHTWARDS ARROW
U+2B48  ⭈   RIGHTWARDS ARROW ABOVE REVERSE ALMOST EQUAL TO
U+2B49  ⭉   TILDE OPERATOR ABOVE LEFTWARDS ARROW
U+2B4A  ⭊   LEFTWARDS ARROW ABOVE ALMOST EQUAL TO
U+2B4B  ⭋   LEFTWARDS ARROW ABOVE REVERSE TILDE OPERATOR
U+2B4C  ⭌   RIGHTWARDS ARROW ABOVE REVERSE TILDE OPERATOR
U+2B50  ⭐   WHITE MEDIUM STAR
U+2B51  ⭑   BLACK SMALL STAR
U+2B52  ⭒   WHITE SMALL STAR
U+2B53  ⭓   BLACK RIGHT-POINTING PENTAGON
U+2B54  ⭔   WHITE RIGHT-POINTING PENTAGON
U+2B55  ⭕   HEAVY LARGE CIRCLE
U+2B56  ⭖   HEAVY OVAL WITH OVAL INSIDE
U+2B57  ⭗   HEAVY CIRCLE WITH CIRCLE INSIDE
U+2B58  ⭘   HEAVY CIRCLE
U+2B59  ⭙   HEAVY CIRCLED SALTIRE
```

<hr>

<h5>OPTION 2: PURE CSS CHEVRONS</h2>

I recently made an article about creating chevrons efficiently using only CSS <em>(No images required).</em>  

How to simply alter:  

<ul>
<li><strong>ROTATION</strong></li>
<li><strong>THICKNESS</strong></li>
<li><strong>COLOR</strong></li>
<li><strong>SIZE</strong></li>
</ul>

<hr>

<a href="http://jsfiddle.net/Ur6a7/" rel="nofollow noreferrer"><kbd>CLICK FOR DEMO ON JSFIDDLE</kbd></a>  

<hr>

<img src="https://i.stack.imgur.com/x7HGq.jpg" alt="enter image description here">  

<hr>

<p><strong>CSS</strong> 
<em>(Efficient with cross browser support)</em></p>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
.Chevron{
    position:relative;
    display:block;
    height:50px;/*height should be double border*/
}
.Chevron:before,
.Chevron:after{
    position:absolute;
    display:block;
    content:"";
    border:25px solid transparent;/*adjust size*/
}
/* Replace all text `top` below with left/right/bottom to rotate the chevron */
.Chevron:before{
    top:0;
    border-top-color:#b00;/*Chevron Color*/
}
.Chevron:after{
    top:-10px;/*adjust thickness*/
    border-top-color:#fff;/*Match background colour*/
}```
```html
<i class="Chevron"></i>```
</div>
</div>


<hr>

<h5>OPTION 3: CSS BASE64 IMAGE ICONS</h2>

<img src="https://i.stack.imgur.com/WIULm.gif" alt="UP/DOWN"> <strong>UP/DOWN</strong>   

<img src="https://i.stack.imgur.com/GTmwP.gif" alt="DOWN"> <strong>DOWN</strong>   

<img src="https://i.stack.imgur.com/Iv3Nu.gif" alt="UP"> <strong>UP</strong>  

Using only a few lines of CSS we can encode our images into base64.   

<hr>

<a href="http://jsfiddle.net/m7zby2gw/" rel="nofollow noreferrer"><kbd>CLICK FOR DEMO ON JSFIDDLE</kbd></a>  

<hr>

<strong>PROS</strong>  

<ul>
<li>No need to include additional resources in the form of images or fonts.</li>
<li>Supports full alpha transparency.</li>
<li>Full cross-browser support.</li>
<li>Small images/icons can be stored in a database.</li>
</ul>

<strong>CONS</strong>  

<ul>
<li>Updating/editing can become a hassle.</li>
<li>Not suitable for large images due to excessive code markup that's generated.</li>
</ul>

<strong>CSS</strong>  

```html
.sorting,
.sorting_asc,
.sorting_desc{
    padding:4px 21px 4px 4px;
    cursor:pointer;
}
.sorting{
    background:url(data:image/gif;base64,R0lGODlhCwALAJEAAAAAAP///xUVFf///yH5BAEAAAMALAAAAAALAAsAAAIUnC2nKLnT4or00PvyrQwrPzUZshQAOw==) no-repeat center right;
}
.sorting_asc{
    background:url(data:image/gif;base64,R0lGODlhCwALAJEAAAAAAP///xUVFf///yH5BAEAAAMALAAAAAALAAsAAAIRnC2nKLnT4or00Puy3rx7VQAAOw==) no-repeat center right;
}
.sorting_desc{
    background:url(data:image/gif;base64,R0lGODlhCwALAJEAAAAAAP///xUVFf///yH5BAEAAAMALAAAAAALAAsAAAIPnI+py+0/hJzz0IruwjsVADs=) no-repeat center right;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Center image using text-align center? (score [1188789](https://stackoverflow.com/q/7055393) in 2013)

#### Question
Is the property `text-align: center;` a good way to center an image using CSS?  

```html
img {
    text-align: center;
}
```

#### Answer accepted (score 1044)
That will not work as the `text-align` property applies to block containers, not inline elements, and `img` is an inline element. See <a href="http://www.w3.org/TR/CSS21/text.html#alignment-prop" rel="noreferrer">the W3C specification</a>.  

Use this instead:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
img.center {
    display: block;
    margin: 0 auto;
}```
```html
<div style="border: 1px solid black;">
<img class="center" src ="https://cdn.sstatic.net/Sites/stackoverflow/company/img/logos/so/so-icon.png?v=c78bd457575a">

</div>```
</div>
</div>


#### Answer 2 (score 110)
That doesn't always work... if it doesn't, try:  

```html
img {
    display: block;
    margin: 0 auto;
}
```

#### Answer 3 (score 84)
I came across <a href="http://hungred.com/how-to/tutorial-align-center-screen-position-absolute-css/" rel="nofollow noreferrer">this post</a>, and it worked for me:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
img {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
}```
```html
<div style="border: 1px solid black; position:relative; min-height: 200px">
  <img src="https://cdn.sstatic.net/Sites/stackoverflow/company/img/logos/so/so-icon.png?v=c78bd457575a">

</div>```
</div>
</div>


(Vertical and horizontal alignment)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: What do &lt; and &gt; stand for? (score [1178482](https://stackoverflow.com/q/5068951) in 2017)

#### Question
I know that the entities `&amp;lt;` and `&amp;gt;` are used for `&lt;` and `&gt;`, but I am curious what these names stand for.  

Does `&amp;lt;` stand for something like "<em>Left tag</em>" or is it just a code?  

#### Answer accepted (score 726)
<ul>
<li>`&amp;lt;` stands for the <a href="http://en.wikipedia.org/wiki/Less-than_sign" rel="noreferrer">less-than sign</a> ( &lt; )</li>
<li>`&amp;gt;` stands for the <a href="http://en.wikipedia.org/wiki/Greater-than_sign" rel="noreferrer">greater-than sign</a> ( > )</li>
<li>`&amp;le;` stands for the less-than or equals sign ( ≤ )</li>
<li>`&amp;ge;` stands for the greater-than or equals sign ( ≥ )</li>
</ul>

#### Answer 2 (score 108)
`&amp;lt;` Less than: `&lt;`  

`&amp;gt;` Greater than: `&gt;`  

#### Answer 3 (score 35)
They're used to explicitly define less than and greater than symbols. If one wanted to type out `&lt;html&gt;` and not have it be a tag in the HTML, one would use them. An alternate way is to wrap the `&lt;code&gt;` element around code to not run into that.   

They can also be used to present mathematical operators.  

```html
<!ENTITY lt      CDATA "&#60;"   -- less-than sign, U+003C ISOnum -->
<!ENTITY gt      CDATA "&#62;"   -- greater-than sign, U+003E ISOnum -->
```

<a href="http://www.w3.org/TR/html4/sgml/entities.html" rel="noreferrer">http://www.w3.org/TR/html4/sgml/entities.html</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: How to disable a link using only CSS? (score [1144833](https://stackoverflow.com/q/2091168) in 2017)

#### Question
Is there any way to disable a link using CSS?  

I have a class called `current-page` and want links with this class to be disabled so that no action occurs when they are clicked.  

#### Answer accepted (score 1312)
The answer is already in the comments of the question. For more visibility, I am copying <a href="http://css-tricks.com/pointer-events-current-nav/" rel="noreferrer">this solution</a> here:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
.not-active {
  pointer-events: none;
  cursor: default;
  text-decoration: none;
  color: black;
}```
```html
<a href="link.html" class="not-active">Link</a>```
</div>
</div>


For browser support, please see <a href="https://caniuse.com/#feat=pointer-events" rel="noreferrer">https://caniuse.com/#feat=pointer-events</a>. If you need to support IE there is a workaround; see <a href="https://stackoverflow.com/a/10276157/1207195">this answer</a>.  

Warning: The use of <a href="https://developer.mozilla.org/en-US/docs/CSS/pointer-events" rel="noreferrer">`pointer-events`</a> in CSS for non-SVG elements is experimental. The feature used to be part of the CSS3 UI draft specification but, due to many open issues, has been postponed to CSS4.  

#### Answer 2 (score 133)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
.disabled {
  pointer-events: none;
  cursor: default;
  opacity: 0.6;
}```
```html
<a href="#" class="disabled">link</a>```
</div>
</div>


#### Answer 3 (score 122)
CSS can only be used to change the style of something. The best you could probably do with pure CSS is to hide the link altogether.  

What you really need is some javascript. Here's how you'd do what you want using the jQuery library.  

```html
$('a.current-page').click(function() { return false; });
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: How to apply CSS to iframe? (score [1101856](https://stackoverflow.com/q/217776) in 2014)

#### Question
I have a simple page that has some iframe sections (to display RSS links). How can I apply the same CSS format from the main page to the page displayed in the iframe?  

#### Answer 2 (score 418)
<strong>Edit:</strong> This does not work cross domain unless the appropriate <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS" rel="noreferrer">CORS header</a> is set.  

There are two different things here: the style of the iframe block and the style of the page embedded in the iframe. You can set the style of the iframe block the usual way:  

```html
<iframe name="iframe1" id="iframe1" src="empty.htm" 
        frameborder="0" border="0" cellspacing="0"
        style="border-style: none;width: 100%; height: 120px;"></iframe>
```

The style of the page embedded in the iframe must be either set by including it in the child page:  

```html
<link type="text/css" rel="Stylesheet" href="Style/simple.css" />
```

Or it can be loaded from the parent page with Javascript:  

```html
var cssLink = document.createElement("link");
cssLink.href = "style.css"; 
cssLink.rel = "stylesheet"; 
cssLink.type = "text/css"; 
frames['iframe1'].document.head.appendChild(cssLink);
```

#### Answer 3 (score 195)
I met this issue with <strong>Google Calendar</strong>. I wanted to style it on a darker background and change font.  

<p>Luckily, the URL from the embed code had no restriction on direct access, so by using PHP function `file_get_contents` it is possible to get the 
entire content from the page. Instead of calling the Google URL, it is possible to call a php file located on your server, ex. `google.php`, which will contain the original content with modifications:</p>

```html
$content = file_get_contents('https://www.google.com/calendar/embed?src=%23contacts%40group.v.calendar.google.com&ctz=America/Montreal');
```

Adding the path to your stylesheet:  

```html
$content = str_replace('</head>','<link rel="stylesheet" href="http://www.yourwebsiteurl.com/google.css" /></head>', $content);
```

(This will place your stylesheet last just before the `head` end tag.)  

Specify the base url form the original url in case css and js are called relatively:  

```html
$content = str_replace('</title>','</title><base href="https://www.google.com/calendar/" />', $content);
```

The final `google.php` file should look like this:  

```html
<?php
$content = file_get_contents('https://www.google.com/calendar/embed?src=%23contacts%40group.v.calendar.google.com&ctz=America/Montreal');
$content = str_replace('</title>','</title><base href="https://www.google.com/calendar/" />', $content);
$content = str_replace('</head>','<link rel="stylesheet" href="http://www.yourwebsiteurl.com/google.css" /></head>', $content);
echo $content;
```

Then you change the `iframe` embed code to:  

```html
<iframe src="http://www.yourwebsiteurl.com/google.php" style="border: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>
```

Good luck!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Space between two rows in a table? (score [1096005](https://stackoverflow.com/q/351058) in 2016)

#### Question
Is this possible via CSS?   

I'm trying   

```html
tr.classname {
  border-spacing: 5em;
}
```

to no avail. Maybe I'm doing something wrong?  

#### Answer 2 (score 511)
You need to use padding on your `td` elements. Something like this should do the trick. You can, of course, get the same result using a top padding instead of a bottom padding.  

In the CSS code below, the greater-than sign means that the padding is only applied to `td` elements that are direct children to `tr` elements with the class `spaceUnder`. This will make it possible to use nested tables. (Cell C and D in the example code.) I'm not too sure about browser support for the direct child selector (think IE 6), but it shouldn't break the code in any modern browsers.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
/* Apply padding to td elements that are direct children of the tr elements with class spaceUnder. */

tr.spaceUnder>td {
  padding-bottom: 1em;
}```
```html
<table>
  <tbody>
    <tr>
      <td>A</td>
      <td>B</td>
    </tr>
    <tr class="spaceUnder">
      <td>C</td>
      <td>D</td>
    </tr>
    <tr>
      <td>E</td>
      <td>F</td>
    </tr>
  </tbody>
</table>```
</div>
</div>


This should render somewhat like this:  

```html
+---+---+
| A | B |
+---+---+
| C | D |
|   |   |
+---+---+
| E | F |
+---+---+
```

#### Answer 3 (score 363)
In the parent table, try setting   

```html
border-collapse:separate; 
border-spacing:5em;
```

<p>Plus a border declaration, and see if this achieves your desired effect.
Beware, though, that IE doesn't support the "separated borders" model.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: How do you easily horizontally center a <div> using CSS? (score [1095138](https://stackoverflow.com/q/618097) in )

#### Question
I'm trying to horizontally center a `&lt;div&gt;` block element on a page and have it set to a minimum width. What is the simplest way to do this? I want the `&lt;div&gt;` element to be inline with rest of my page. I'll try to draw an example:  

```html
page text page text page text page text
page text page text page text page text
               -------
               | div |
               -------
page text page text page text page text
page text page text page text page text
```

#### Answer accepted (score 776)
In the case of a <strong>non-fixed width</strong> div (i.e. you don't know how much space the div will occupy).  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
#wrapper {
  background-color: green; /* for visualization purposes */
  text-align: center;
}
#yourdiv {
  background-color: red; /* for visualization purposes */
  display: inline-block;
}```
```html
<div id="wrapper">    
    <div id="yourdiv">Your text</div>
</div>```
</div>
</div>


Keep in mind that the width of `#yourdiv` is dynamic -> it will grow and shrink to accommodate the text inside it.  

You can check browser compatibility on <a href="http://caniuse.com/inline-block" rel="noreferrer">Caniuse</a>  

#### Answer 2 (score 564)
In most browsers this will work:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
div.centre {
  width: 200px;
  display: block;
  background-color: #eee;
  margin-left: auto;
  margin-right: auto;
}```
```html
<div class="centre">Some Text</div>```
</div>
</div>


In IE6 you will need to add another outer `div`:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
div.layout {
  text-align: center;
}

div.centre {
  text-align: left;
  width: 200px;
  background-color: #eee;
  display: block;
  margin-left: auto;
  margin-right: auto;
}```
```html
<div class="layout">
  <div class="centre">Some Text</div>
</div>```
</div>
</div>


#### Answer 3 (score 58)
```html
margin: 0 auto;
```

as <a href="https://stackoverflow.com/questions/618097/how-do-you-easily-horizontally-center-a-div-using-css/618104#618104">ck has said</a>, <a href="http://www.w3schools.com/CSS/pr_dim_min-width.asp" rel="noreferrer">min-width</a> is not supported by all browsers  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: Changing the color of an hr element (score [1094306](https://stackoverflow.com/q/6382023) in 2018)

#### Question
I want to change the color of my `hr` tag using CSS. The code I've tried below doesn't seem to work:  

```html
hr {
    color: #123455;
}
```

#### Answer accepted (score 1093)
I think you should use `border-color` instead of `color`, if your intention is to change the color of the line produced by `&lt;hr&gt;` tag.  

Although, it has been pointed in comments that, if you change the size of your line, border will still be as wide as you specified in styles, and line will be filled with the default color (which is not a desired effect most of the time). So it seems like in this case you would also need to specify `background-color` (as @Ibu suggested in his answer).  

<strong>HTML 5 Boilerplate</strong> project in its default stylesheet <a href="https://github.com/paulirish/html5-boilerplate/blob/ef3c095bafa9a6fa9c771f368d4b30c8ce4deded/css/style.css#L75" rel="noreferrer">specifies</a> the following rule:  

```html
hr { display: block; height: 1px;
    border: 0; border-top: 1px solid #ccc;
    margin: 1em 0; padding: 0; }
```

<strong>An article</strong> titled <a href="http://www.sitepoint.com/12-little-known-css-facts/" rel="noreferrer">“12 Little-Known CSS Facts”</a>, published recently by SitePoint, mentions that `&lt;hr&gt;` can set its `border-color` to its parent's `color` if you specify `hr { border-color: inherit }`.  

#### Answer 2 (score 111)
<ul>
<li>`border-color` works in <strong>Chrome</strong> and <strong>Safari</strong>.</li>
<li>`background-color` works in Firefox and Opera.</li>
<li>`color` works in <strong>IE7+</strong>.</li>
</ul>

#### Answer 3 (score 80)
I think this can be useful. this was simple CSS selector.  

```html
hr { background-color: red; height: 1px; border: 0; }
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: How do you disable browser Autocomplete on web form field / input tag? (score [1091818](https://stackoverflow.com/q/2530) in 2018)

#### Question
How do you disable `autocomplete` in the major browsers for a specific `input` (or `form field`)?  

#### Answer accepted (score 2523)
Firefox 30 ignores `autocomplete="off"` for passwords, opting to prompt the user instead whether the password should be stored on the client. Note the following <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=956906#c100" rel="noreferrer">commentary</a> from May 5, 2014:  

<blockquote>
  <ul>
  <li>The password manager <em>always</em> prompts if it wants to save a password. Passwords are not saved without permission from the user.</li>
  <li>We are the third browser to implement this change, after IE and Chrome.</li>
  </ul>
</blockquote>

According to the <a href="https://developer.mozilla.org/en/How_to_Turn_Off_Form_Autocompletion" rel="noreferrer">Mozilla Developer Network</a> documentation, the Boolean form element attribute `autocomplete` prevents form data from being cached in older browsers.  

```html
<input type="text" name="foo" autocomplete="off" />
```

#### Answer 2 (score 298)
In addition to `autocomplete=off`, you could also have your form fields names be randomized by the code that generates the page, perhaps by adding some session-specific string to the end of the names.    

When the form is submitted, you can strip that part off before processing them on the server side. This would prevent the web browser from finding context for your field and also might help prevent XSRF attacks because an attacker wouldn't be able to guess the field names for a form submission.  

#### Answer 3 (score 224)
Most of the major browsers and password managers (correctly, IMHO) now ignore `autocomplete=off`.   

Why? Many banks and other "high security" websites added `autocomplete=off` to their login pages "for security purposes" but this actually decreases security since it causes people to change the passwords on these high-security sites to be easy to remember (and thus crack) since autocomplete was broken.   

Long ago most password managers started ignoring `autocomplete=off`, and now the browsers are starting to do the same for username/password inputs only.  

Unfortunately, bugs in the autocomplete implementations insert username and/or password info into inappropriate form fields, causing form validation errors, or worse yet, accidentally inserting usernames into fields that were intentionally left blank by the user.  

What's a web developer to do?  

<ul>
<li>If you can keep all password fields on a page by themselves, that's a great start as it seems that the presence of a password field is the main trigger for user/pass autocomplete to kick in. Otherwise, read the tips below.</li>
<li><strong>Safari</strong> notices that there are 2 password fields and disables autocomplete in this case, assuming it must be a change password form, not a login form. So just be sure to use 2 password fields (new and confirm new) for any forms where you allow </li>
<li><p><strong>Chrome</strong> 34, unfortunately, will try to autofill fields with user/pass whenever it sees a password field. This is quite a bad bug that hopefully, they will change the Safari behavior. However, adding this to the top of your form seems to disable the password autofill:</p>

```html
<input type="text" style="display:none">
<input type="password" style="display:none">
```</li>
</ul>

I haven't yet investigated IE or Firefox thoroughly but will be happy to update the answer if others have info in the comments.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: How to get value of selected radio button? (score [1063814](https://stackoverflow.com/q/15839169) in 2019)

#### Question
I want to get the selected value from a group of radio buttons.   

Here's my HTML:  

```html
<div id="rates">
  <input type="radio" id="r1" name="rate" value="Fixed Rate"> Fixed Rate
  <input type="radio" id="r2" name="rate" value="Variable Rate"> Variable Rate
  <input type="radio" id="r3" name="rate" value="Multi Rate" checked="checked"> Multi Rate  
</div>
```

Here's my .js:  

```html
var rates = document.getElementById('rates').value;
var rate_value;
if(rates =='Fixed Rate'){
    rate_value = document.getElementById('r1').value;

}else if(rates =='Variable Rate'){
    rate_value = document.getElementById('r2').value;

}else if(rates =='Multi Rate'){
    rate_value = document.getElementById('r3').value;
}  

document.getElementById('results').innerHTML = rate_value;
```

I keep getting undefined.  

#### Answer accepted (score 220)
```html
var rates = document.getElementById('rates').value;
```

The rates element is a `div`, so it won't have a value. This is probably where the `undefined` is coming from.  

The `checked` property will tell you whether the element is selected:  

```html
if (document.getElementById('r1').checked) {
  rate_value = document.getElementById('r1').value;
}
```

#### Answer 2 (score 453)
This works in IE9 and above and all other browsers.  

```html
document.querySelector('input[name="rate"]:checked').value;
```

#### Answer 3 (score 129)
You can get the value by using the `checked` property.  

```html
var rates = document.getElementsByName('rate');
var rate_value;
for(var i = 0; i < rates.length; i++){
    if(rates[i].checked){
        rate_value = rates[i].value;
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: JavaScript - onClick to get the ID of the clicked button (score [1053833](https://stackoverflow.com/q/4825295) in 2012)

#### Question
How do find the id of the button which is being clicked?  

```html
<button id="1" onClick="reply_click()"></button>
<button id="2" onClick="reply_click()"></button>
<button id="3" onClick="reply_click()"></button>

function reply_click()
{
}
```

#### Answer accepted (score 527)
You need to send the ID as the function parameters. Do it like this:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<button id="1" onClick="reply_click(this.id)">B1</button>
<button id="2" onClick="reply_click(this.id)">B2</button>
<button id="3" onClick="reply_click(this.id)">B3</button>
    
<script type="text/javascript">
  function reply_click(clicked_id)
  {
      alert(clicked_id);
  }
</script>```
</div>
</div>


This will send the ID `this.id` as `clicked_id` which you can use in your function. <a href="http://jsfiddle.net/R77EB/" rel="noreferrer"><strong>See it in action here.</strong></a>  

#### Answer 2 (score 56)
In general, things are easier to keep organized if you separate your code and your markup. Define all of your elements, and then in your JavaScript section, define the various actions that should be performed on those elements.  

When an event handler is called, it's called within the context of the element that was clicked on. So, the identifier <strong>this</strong> will refer to the DOM element that you clicked on. You can then access attributes of the element through that identifier.  

For example:  

```html
<button id="1">Button 1</button>
<button id="2">Button 2</button>
<button id="3">Button 3</button>

<script type="text/javascript">
var reply_click = function()
{
    alert("Button clicked, id "+this.id+", text"+this.innerHTML);
}
document.getElementById('1').onclick = reply_click;
document.getElementById('2').onclick = reply_click;
document.getElementById('3').onclick = reply_click;
</script>
```

#### Answer 3 (score 38)
(I think the `id` attribute needs to start with a letter. Could be wrong.)  

You could go for event delegation...  

```html
<div onClick="reply_click()">
    <button id="1"></button>
    <button id="2"></button>
    <button id="3"></button>
</div>

function reply_click(e) {
    e = e || window.event;
    e = e.target || e.srcElement;
    if (e.nodeName === 'BUTTON') {
        alert(e.id);
    }
}
```

...but that requires you to be relatively comfortable with the wacky event model.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: How to get current formatted date dd/mm/yyyy in Javascript and append it to an input (score [1052167](https://stackoverflow.com/q/12409299) in 2016)

#### Question
I would like to add a current date to a hidden HTML tag so that it can be sent to the server:  

```html
<input type="hidden" id="DATE" name="DATE" value="WOULD_LIKE_TO_ADD_DATE_HERE">
```

How can I add a formatted date to the VALUE attribute?  

#### Answer accepted (score 555)
I hope this is what you want:   

```html
var today = new Date();
var dd = today.getDate();
var mm = today.getMonth() + 1; //January is 0!

var yyyy = today.getFullYear();
if (dd < 10) {
  dd = '0' + dd;
} 
if (mm < 10) {
  mm = '0' + mm;
} 
var today = dd + '/' + mm + '/' + yyyy;
document.getElementById('DATE').value = today;
```

<a href="https://stackoverflow.com/questions/1531093/how-to-get-current-date-in-javascript">How do I get the current date in JavaScript?</a>  

#### Answer 2 (score 190)
I honestly suggest that you use <a href="http://momentjs.com" rel="noreferrer">moment.js</a>. Just download `moment.min.js` and then use this snippet to get your date in whatever format you want:  

```html
<script>
$(document).ready(function() {

     // set an element
     $("#date").val( moment().format('MMM D, YYYY') );

     // set a variable
     var today = moment().format('D MMM, YYYY');

});
</script>
```

Use following chart for date formats:  

<img src="https://i.stack.imgur.com/xVscR.jpg" alt="enter image description here">  

#### Answer 3 (score 105)
```html
<input type="hidden" id="date"/>
<script>document.getElementById("date").value = new Date().toJSON().slice(0,10)</script>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Show/hide 'div' using JavaScript (score [1048784](https://stackoverflow.com/q/21070101) in 2019)

#### Question
For a website I'm doing, I want to load one div, and hide another, then have two buttons that will toggle views between the div using JavaScript.  

<strong>This is my current code</strong>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
function replaceContentInContainer(target, source) {
  document.getElementById(target).innerHTML = document.getElementById(source).innerHTML;
}

function replaceContentInOtherContainer(replace_target, source) {
  document.getElementById(replace_target).innerHTML = document.getElementById(source).innerHTML;
}```
```html
<html>
<button onClick="replaceContentInContainer('target', 'replace_target')">View Portfolio</button>
<button onClick="replaceContentInOtherContainer('replace_target', 'target')">View Results</button>

<div>
  <span id="target">div1</span>
</div>

<div style="display:none">
  <span id="replace_target">div2</span>
</div>```
</div>
</div>


The second function that replaces div2 is not working, but the first one is.  

#### Answer accepted (score 387)
<h5>How to show or hide an element:</h3>

In order to show or hide an element, manipulate the element's <a href="https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/style">style property</a>. In most cases, you probably just want to change the element's <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/display">`display` property</a>:  

```html
element.style.display = 'none';           // Hide
element.style.display = 'block';          // Show
element.style.display = 'inline';         // Show
element.style.display = 'inline-block';   // Show
```

Alternatively, if you would still like the element to occupy space (like if you were to hide a table cell), you could change the element's <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/visibility">`visibility` property</a> instead:  

```html
element.style.visibility = 'hidden';      // Hide
element.style.visibility = 'visible';     // Show
```

<h5>Hiding a collection of elements:</h3>

If you want to hide a collection of elements, just iterate over each element and change the element's `display` to `none`:  

```html
function hide (elements) {
  elements = elements.length ? elements : [elements];
  for (var index = 0; index < elements.length; index++) {
    elements[index].style.display = 'none';
  }
}
```



```html
// Usage:
hide(document.querySelectorAll('.target'));
hide(document.querySelector('.target'));
hide(document.getElementById('target'));
```

<p><div class="snippet" data-lang="js" data-hide="true">
<div class="snippet-code snippet-currently-hidden">
```html
hide(document.querySelectorAll('.target'));

function hide (elements) {
  elements = elements.length ? elements : [elements];
  for (var index = 0; index < elements.length; index++) {
    elements[index].style.display = 'none';
  }
}```
```html
<div class="target">This div will be hidden.</div>

<span class="target">This span will be hidden as well.</span>```
</div>
</div>


<h5>Showing a collection of elements:</h3>

Most of the time, you will probably just be toggling between `display: none` and `display: block`, which means that the following <em>may</em> be sufficient when showing a collection of elements.  

You can optionally specify the desired `display` as the second argument if you don't want it to default to `block`.  

```html
function show (elements, specifiedDisplay) {
  elements = elements.length ? elements : [elements];
  for (var index = 0; index < elements.length; index++) {
    elements[index].style.display = specifiedDisplay || 'block';
  }
}
```



```html
// Usage:
var elements = document.querySelectorAll('.target');
show(elements);

show(elements, 'inline-block'); // The second param allows you to specify a display value
```

<p><div class="snippet" data-lang="js" data-hide="true">
<div class="snippet-code snippet-currently-hidden">
```html
var elements = document.querySelectorAll('.target');

show(elements, 'inline-block'); // The second param allows you to specify a display value

show(document.getElementById('hidden-input'));

function show (elements, specifiedDisplay) {
  elements = elements.length ? elements : [elements];
  for (var index = 0; index < elements.length; index++) {
    elements[index].style.display = specifiedDisplay || 'block';
  }
}```
```html
<div class="target" style="display: none">This hidden div should have a display of 'inline-block' when it is shown.</div>

<span>Inline span..</span>

<input id="hidden-input" />```
</div>
</div>


Alternatively, a better approach for showing the element(s) would be to merely remove the inline `display` styling in order to revert it back to its initial state. Then check the computed `display` style of the element in order to determine whether it is being hidden by a cascaded rule. If so, then show the element.  

```html
function show (elements, specifiedDisplay) {
  var computedDisplay, element, index;

  elements = elements.length ? elements : [elements];
  for (index = 0; index < elements.length; index++) {
    element = elements[index];

    // Remove the element's inline display styling
    element.style.display = '';
    computedDisplay = window.getComputedStyle(element, null).getPropertyValue('display');

    if (computedDisplay === 'none') {
        element.style.display = specifiedDisplay || 'block';
    }
  }
}
```

<p><div class="snippet" data-lang="js" data-hide="true">
<div class="snippet-code snippet-currently-hidden">
```html
show(document.querySelectorAll('.target'));

function show (elements, specifiedDisplay) {
  var computedDisplay, element, index;

  elements = elements.length ? elements : [elements];
  for (index = 0; index < elements.length; index++) {
    element = elements[index];

    // Remove the element's inline display styling
    element.style.display = '';
    computedDisplay = window.getComputedStyle(element, null).getPropertyValue('display');

    if (computedDisplay === 'none') {
        element.style.display = specifiedDisplay || 'block';
    }
  }
}```
```html
<span class="target" style="display: none">Should revert back to being inline.</span>

<span class="target" style="display: none">Inline as well.</span>

<div class="target" style="display: none">Should revert back to being block level.</div>

<span class="target" style="display: none">Should revert back to being inline.</span>```
</div>
</div>


(If you want to take it a step further, you could even mimic what jQuery does and determine the element's default browser styling by appending the element to a blank `iframe` (without a conflicting stylesheet) and then retrieve the computed styling. In doing so, you will know the true initial `display` property value of the element and you won't have to hardcode a value in order to get the desired results.)  

<h5>Toggling the display:</h3>

Similarly, if you would like to toggle the `display` of an element or collection of elements, you could simply iterate over each element and determine whether it is visible by checking the computed value of the `display` property. If it's visible, set the `display` to `none`, otherwise remove the inline `display` styling, and if it's still hidden, set the `display` to the specified value or the hardcoded default, `block`.  

```html
function toggle (elements, specifiedDisplay) {
  var element, index;

  elements = elements.length ? elements : [elements];
  for (index = 0; index < elements.length; index++) {
    element = elements[index];

    if (isElementHidden(element)) {
      element.style.display = '';

      // If the element is still hidden after removing the inline display
      if (isElementHidden(element)) {
        element.style.display = specifiedDisplay || 'block';
      }
    } else {
      element.style.display = 'none';
    }
  }
  function isElementHidden (element) {
    return window.getComputedStyle(element, null).getPropertyValue('display') === 'none';
  }
}
```



```html
// Usage:
document.getElementById('toggle-button').addEventListener('click', function () {
  toggle(document.querySelectorAll('.target'));
});
```

<p><div class="snippet" data-lang="js" data-hide="true">
<div class="snippet-code snippet-currently-hidden">
```html
document.getElementById('toggle-button').addEventListener('click', function () {
    toggle(document.querySelectorAll('.target'));
});

function toggle (elements, specifiedDisplay) {
  var element, index;

  elements = elements.length ? elements : [elements];
  for (index = 0; index < elements.length; index++) {
    element = elements[index];

    if (isElementHidden(element)) {
      element.style.display = '';

      // If the element is still hidden after removing the inline display
      if (isElementHidden(element)) {
        element.style.display = specifiedDisplay || 'block';
      }
    } else {
      element.style.display = 'none';
    }
  }
  function isElementHidden (element) {
    return window.getComputedStyle(element, null).getPropertyValue('display') === 'none';
  }
}```
```html
.target { display: none; }```
```html
<button id="toggle-button">Toggle display</button>

<span class="target">Toggle the span.</span>

<div class="target">Toggle the div.</div>```
</div>
</div>


#### Answer 2 (score 86)
You can also use the <a href="https://learn.jquery.com/about-jquery/how-jquery-works/">jQuery</a> JavaScript framework:  

To Hide Div Block  

```html
$(".divIDClass").hide();
```

To show Div Block  

```html
$(".divIDClass").show();
```

#### Answer 3 (score 41)
You can simply manipulate the style of the div in question...  

```html
document.getElementById('target').style.display = 'none';
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: Get checkbox value in jQuery (score [1047008](https://stackoverflow.com/q/2834350) in 2011)

#### Question
How can I get a checkbox's value in jQuery?  

#### Answer accepted (score 942)
To get the value of the Value attribute you can do something like this:  

```html
$("input[type='checkbox']").val();
```

Or if you have set a `class` or `id` for it, you can:  

```html
$('#check_id').val();
$('.check_class').val();
```

However this will return the <strong>same</strong> value whether it is checked or not, this can be confusing as it is different to the submitted form behaviour.  

To check whether it is checked or not, do:  

```html
if ($('#check_id').is(":checked"))
{
  // it is checked
}
```

#### Answer 2 (score 200)
Those 2 ways are working:  

<ul>
<li>`$('#checkbox').prop('checked')`</li>
<li>`$('#checkbox').is(':checked')` (thanks <kbd>@mgsloan</kbd>)</li>
</ul>

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
```html
$('#test').click(function() {
    alert("Checkbox state (method 1) = " + $('#test').prop('checked'));
    alert("Checkbox state (method 2) = " + $('#test').is(':checked'));
});```
```html
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
Check me: <input id="test" type="checkbox" />```
</div>
</div>


#### Answer 3 (score 55)
Try this small solution:   

```html
$("#some_id").attr("checked") ? 1 : 0;
```

or  

```html
$("#some_id").attr("checked") || 0;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: How can I position my div at the bottom of its container? (score [1043714](https://stackoverflow.com/q/526035) in 2017)

#### Question
Given the following HTML:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
<div id="container">
  <!-- Other elements here -->
  <div id="copyright">
    Copyright Foo web designs
  </div>
</div>```
</div>
</div>


I would like `#copyright` to stick to the bottom of `#container`.  

Can I achieve this without using absolute positioning? If the float property supported a value of 'bottom' it seems that would do the trick, but unfortunately, it doesn't.  

#### Answer accepted (score 863)
Likely not.  

Assign `position:relative` to `#container`, and then `position:absolute; bottom:0;` to `#copyright`.  

<hr>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
#container {
    position: relative;
}
#copyright {
    position: absolute;
    bottom: 0;
}```
```html
<div id="container">
  <!-- Other elements here -->
  <div id="copyright">
    Copyright Foo web designs
  </div>
</div>```
</div>
</div>


#### Answer 2 (score 334)
Actually, the accepted answer by @User will only work if the window is tall and the content is short. But if the content is tall and the window is short, it will put the copyright info over the page content, and then scrolling down to see the content will leave you with a floating copyright notice. That makes this solution useless for most pages (like this page, actually).  

The most common way of doing this is the "CSS sticky footer" approach demonstrated, or a slightly slimmer variation. This approach works great -- IF you have a fixed height footer.  

If you need a variable height footer that will appear at the bottom of the window if the content is too short, and at the bottom of the content if the window is too short, what do you do?  

Swallow your pride and use a table.  

For example:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
* {
    padding: 0;
    margin: 0;
}

html, body {
    height: 100%;
}

#container {
    height: 100%;
    border-collapse: collapse;
}```
```html
<!DOCTYPE html>
<html>
<body>
    <table id="container">
        <tr>
            <td valign="top">
                <div id="main">Lorem ipsum, etc.</div>
            </td>
        </tr>
        <tr>
            <td valign="bottom">
                <div id="footer">Copyright some evil company...</div>
            </td>
        </tr>
    </table>
</body>
</html>```
</div>
</div>


Try it out. This will work for any window size, for any amount of content, for any size footer, on every browser... even IE6.  

If you're cringing at the thought of using a table for layout, take a second to ask yourself why. CSS was supposed to make our lives easier -- and it has, overall -- but the fact is that even after all these years, it's still a broken, counter-intuitive mess. It can't solve every problem. It's incomplete.  

Tables aren't cool, but at least for now, they are sometimes the best way to solve a design problem.  

#### Answer 3 (score 139)
<h5>The flexbox approach!</h2>

In <a href="http://caniuse.com/#feat=flexbox" rel="noreferrer">supported browsers</a>, you can use the following:  

<a href="http://jsfiddle.net/bv1rs8s1/" rel="noreferrer"><strong>Example Here</strong></a>  



```html
.parent {
  display: flex;
  flex-direction: column;
}
.child {
  margin-top: auto;
}
```

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
.parent {
  height: 100px;
  border: 5px solid #000;
  display: flex;
  flex-direction: column;
}
.child {
  height: 40px;
  width: 100%;
  background: #f00;
  margin-top: auto;
}```
```html
<div class="parent">
  <div class="child">Align to the bottom</div>
</div>```
</div>
</div>


<hr>

The solution above is probably more flexible, however, here is an alternative solution:  

<a href="http://jsfiddle.net/rh4Lc5dr/" rel="noreferrer"><strong>Example Here</strong></a>  

```html
.parent {
  display: flex;
}
.child {
  align-self: flex-end;
}
```

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
.parent {
  height: 100px;
  border: 5px solid #000;
  display: flex;
}
.child {
  height: 40px;
  width: 100%;
  background: #f00;
  align-self: flex-end;
}```
```html
<div class="parent">
  <div class="child">Align to the bottom</div>
</div>```
</div>
</div>


<hr>

As a side note, you may want to add vendor prefixes for additional support.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: How to move an element into another element? (score [1039593](https://stackoverflow.com/q/1279957) in 2014)

#### Question
I would like to move one DIV element inside another. For example, I want to move this (including all children):  

```html
<div id="source">
...
</div>
```

into this:  

```html
<div id="destination">
...
</div>
```

so that I have this:  

```html
<div id="destination">
  <div id="source">
    ...
  </div>
</div>
```

#### Answer accepted (score 1729)
You may want to use the <a href="http://api.jquery.com/appendTo/" rel="noreferrer">`appendTo`</a> function (which adds to the end of the element):  

```html
$("#source").appendTo("#destination");
```

Alternatively you could use the <a href="http://api.jquery.com/prependTo/" rel="noreferrer">`prependTo`</a> function (which adds to the beginning of the element):  

```html
$("#source").prependTo("#destination");
```

<hr>

Example:  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="true" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```html
$("#appendTo").click(function() {
  $("#moveMeIntoMain").appendTo($("#main"));
});
$("#prependTo").click(function() {
  $("#moveMeIntoMain").prependTo($("#main"));
});```
```html
#main {
  border: 2px solid blue;
  min-height: 100px;
}

.moveMeIntoMain {
  border: 1px solid red;
}```
```html
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<div id="main">main</div>
<div id="moveMeIntoMain" class="moveMeIntoMain">move me to main</div>

<button id="appendTo">appendTo main</button>
<button id="prependTo">prependTo main</button>```
</div>
</div>


#### Answer 2 (score 861)
my solution:  

MOVE:  

```html
jQuery("#NodesToMove").detach().appendTo('#DestinationContainerNode')
```

COPY:  

```html
jQuery("#NodesToMove").appendTo('#DestinationContainerNode')
```

Note the usage of .detach(). When copying, be careful that you are not duplicating IDs.  

#### Answer 3 (score 106)
I just used:  

```html
$('#source').prependTo('#destination');
```

Which I grabbed from <a href="http://www.elated.com/articles/jquery-removing-replacing-moving-elements/" rel="noreferrer">here</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: Multiple lines of input in <input type="text" /> (score [1037912](https://stackoverflow.com/q/6262472) in 2014)

#### Question
I have this text input in a form:  

```html
<input type="text"
       cols="40" 
       rows="5" 
       style="width:200px; height:50px;" 
       name="Text1" 
       id="Text1" 
       value="" />
```

I am trying to get it to take multiple lines of input. The width and height make the box to be bigger, but the user can enter text all (s)he wants yet it fills one line only.   

How do I make the input more like a textarea?  

#### Answer accepted (score 635)
You need to use a textarea to get multiline handling.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
<textarea name="Text1" cols="40" rows="5"></textarea>```
</div>
</div>


#### Answer 2 (score 54)
It is possible to make a text-input multi-line by giving it the `word-break: break-word;` attribute. (Only tested this in Chrome)  

#### Answer 3 (score 47)
You can't. The only HTML form element that's designed to be multi-line is <a href="https://developer.mozilla.org/en/HTML/Element/textarea" rel="noreferrer">`&lt;textarea&gt;`</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: Making a div vertically scrollable using CSS (score [1023998](https://stackoverflow.com/q/9707397) in 2015)

#### Question
This  

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
```html
<div id="" style="overflow:scroll; height:400px;">```
</div>
</div>


gives a `div` that the user can scroll in both in horizontally and vertically. How do I change it so that the div is <em>only</em> scrollable vertically?  

#### Answer accepted (score 644)
You have it covered aside from using the wrong property. The scrollbar can be triggered with any property `overflow`, `overflow-x`, or `overflow-y` and each can be set to any of `visible`, `hidden`, `scroll`, `auto`, or `inherit`. You are currently looking at these two:  

<ul>
<li><p>`auto` - This value will look at the width and height of the box. If they are defined, it won't let the box expand past those boundaries. Instead (if the content exceeds those boundaries), it will create a scrollbar for either boundary (or both) that exceeds its length.</p></li>
<li><p>`scroll` - This values <em>forces</em> a scrollbar, no matter what, even if the content does not exceed the boundary set. If the content doesn't need to be scrolled, the bar will appear as "disabled" or non-interactive.</p></li>
</ul>

<strong>If you <em>always</em> want the vertical scrollbar to appear:</strong>  

You should use `overflow-y: scroll`. This <em>forces</em> a scrollbar to appear for the vertical axis whether or not it is needed. If you can't actually scroll the context, it will appear as a"disabled" scrollbar.  

<strong>If you only want a scrollbar to appear if you can scroll the box:</strong>  

Just use `overflow: auto`. Since your content by default just breaks to the next line when it cannot fit on the current line, a horizontal scrollbar won't be created (unless it's on an element that has word-wrapping disabled). For the vertical bar,it will allow the content to expand up to the height you have specified. If it exceeds that height, it will show a vertical scrollbar to view the rest of the content, but will not show a scrollbar if it does not exceed the height.  

#### Answer 2 (score 241)
Try like this.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
<div style="overflow-y: scroll; height:400px;">```
</div>
</div>


#### Answer 3 (score 110)
For 100% viewport height use:  

```html
overflow: auto;
max-height: 100vh;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Maximum call stack size exceeded error (score [1023585](https://stackoverflow.com/q/6095530) in 2017)

#### Question
I am using a Direct Web Remoting (DWR) JavaScript library file and am getting an error only in Safari (desktop and iPad)  

It says   

<blockquote>
  Maximum call stack size exceeded.  
</blockquote>

What exactly does this error mean and does it stop processing completely?  

Also any fix for `Safari` browser (Actually on the `iPad Safari`, it says   

<blockquote>
  JS:execution exceeded timeout  
</blockquote>

which I am assuming is the same call stack issue)  

#### Answer accepted (score 555)
It means that somewhere in your code, you are calling a function which in turn calls another function and so forth, until you hit the call stack limit.  

This is almost always because of a recursive function with a base case that isn't being met.  

<h5>Viewing the stack</h3>

Consider this code...  

```html
(function a() {
    a();
})();
```

Here is the stack after a handful of calls...  

<img src="https://i.stack.imgur.com/aSwnu.png" alt="Web Inspector">  

As you can see, the call stack grows until it hits a limit: the browser hardcoded stack size or memory exhaustion.  

In order to fix it, ensure that your recursive function has a base case which is able to be met...  

```html
(function a(x) {
    // The following condition 
    // is the base case.
    if ( ! x) {
        return;
    }
    a(--x);
})(10);
```

#### Answer 2 (score 76)
You can sometimes get this if you accidentally import/embed the same JavaScript file twice, worth checking in your resources tab of the inspector.  

#### Answer 3 (score 42)
In my case, I was sending input elements instead of their values:  

```html
$.post( '',{ registerName: $('#registerName') } )
```

Instead of:  

```html
$.post( '',{ registerName: $('#registerName').val() } )
```

This froze my Chrome tab to a point it didn't even show me the 'Wait/Kill' dialog for when the page became unresponsive...  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: How to set value of input text using jQuery (score [1016869](https://stackoverflow.com/q/10611170) in 2019)

#### Question
I have an input text which is this:  

```html
<div class="editor-label">
    @Html.LabelFor(model => model.EmployeeId, "Employee Number")
</div>

<div class="editor-field textBoxEmployeeNumber">
    @Html.EditorFor(model => model.EmployeeId) 
    @Html.ValidationMessageFor(model => model.EmployeeId)
</div>
```

Which produce following html  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<div class="editor-label">
  <label for="EmployeeId">Employee Number</label>
</div>

<div class="editor-field textBoxEmployeeNumber">
  <input class="text-box single-line" data-val="true" data-val-number="The field EmployeeId must be a number." data-val-required="The EmployeeId field is required." id="EmployeeId" name="EmployeeId" type="text" value="" />

  <span class="field-validation-valid" data-valmsg-for="EmployeeId" data-valmsg-replace="true"></span>
</div>```
</div>
</div>


I want to set the value of this input text using jquery so i did this:  

```html
<script type="text/javascript" language="javascript">
    $(function() {
        $('.textBoxEmployeeNumber').val("fgg");
    });
</script> 
```

however, it is not working... what is the error in my syntax?  

#### Answer accepted (score 511)
Your selector is retrieving the text box's surrounding `&lt;div class='textBoxEmployeeNumber'&gt;` instead of the input inside it.  

```html
// Access the input inside the div with this selector:
$(function () {
  $('.textBoxEmployeeNumber input').val("fgg");
});
```

<h5>Update after seeing output HTML</h3>

If the ASP.NET code reliably outputs the HTML `&lt;input&gt;` with an id attribute `id='EmployeeId'`, you can more simply just use:  

```html
$(function () {
  $('#EmployeeId').val("fgg");
});
```

Failing this, you will need to verify in your browser's error console that you don't have other script errors causing this to fail.  The first example above <a href="http://jsfiddle.net/a2fDQ/">works correctly in this demonstration.</a>  

#### Answer 2 (score 60)
Using jQuery, we can use the following code:  

Select by input name:  

```html
$('input[name="textboxname"]').val('some value')
```

Select by input class:  

```html
$('input[type=text].textboxclass').val('some value')
```

Select by input id:  

```html
$('#textboxid').val('some value')
```

#### Answer 3 (score 12)
```html
$(document).ready(function () {
    $('#EmployeeId').val("fgg");

    //Or
    $('.textBoxEmployeeNumber > input').val("fgg");

    //Or
    $('.textBoxEmployeeNumber').find('input').val("fgg");
});
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: How To Auto-Format / Indent XML/HTML in Notepad++ (score [1012752](https://stackoverflow.com/q/7117949) in 2017)

#### Question
Is there a way to re-indent a block of code?  I'm looking for something similar to <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>F</kbd> in Eclipse (Auto-Format/Indent).  

To be clear,  

<ul>
<li>I already know how to format XML <em>outside</em> of Notepad++ (Eclipse works fine, as mentioned) so I don't need a bunch of links to other XML-formatting tools. </li>
<li>I'm specifically working with XML and HTML.</li>
<li>Ideally, there's a keybinding as convenient as the one in Eclipse, so I don't have to break my workflow.</li>
</ul>

I already know about NppAutoIndent - it won't work, as I'm working with XML, HTML and CSS.  

#### Answer accepted (score 775)
Since I upgraded to 6.3.2, I use `XML Tools`.   

<ul>
<li>install XML Tools via the Plugin Manager. </li>
<li>use the shortcut <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Shift</kbd>+<kbd>B</kbd> (<em>or</em> 
menu -> Plugins -> XML Tools -> Pretty Print)</li>
</ul>

<p>In older versions:
menu -> TextFX -> HTML Tidy -> Tidy: Reindent XML.</p>

#### Answer 2 (score 50)
Install Tidy2 plugin. I have Notepad++ v6.2.2, and Tidy2 works fine so far.  

#### Answer 3 (score 35)
For those who don't know, npp has a lot of support from plugins and other projects. You can download those plugins from <a href="http://sourceforge.net/projects/npp-plugins/files/" rel="noreferrer">SourceForge</a>.  

<a href="https://i.stack.imgur.com/riCYJ.png" rel="noreferrer"><img src="https://i.stack.imgur.com/riCYJ.png" alt="enter image description here"></a>  

You need `XML Tools` to format your text in n++  

After you have downloaded `XML Tools` ..   

Exit Notepad++  

Go To  `C:\Program File\Notepad++` .... Your N++ installed folder.  

<ol>
<li>Place below files from xml tools which you downloaded in the npp root folder by `copy replace`</li>
</ol>

<a href="https://i.stack.imgur.com/svpII.png" rel="noreferrer"><img src="https://i.stack.imgur.com/svpII.png" alt="enter image description here"></a>  

<ol start="2">
<li>Go To `..\Plugins` subfolder and place below downloaded file</li>
</ol>

<a href="https://i.stack.imgur.com/EmbRE.png" rel="noreferrer"><img src="https://i.stack.imgur.com/EmbRE.png" alt="enter image description here"></a>  

Restart and enjoy!!!  

<kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Shft</kbd> + <kbd>B</kbd> to format.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: Make iframe automatically adjust height according to the contents without using scrollbar? (score [1002034](https://stackoverflow.com/q/9975810) in 2013)

#### Question
For example:  

```html
<iframe name="Stack" src="http://stackoverflow.com/" width="740"
        frameborder="0" scrolling="no" id="iframe"> ...
</iframe>
```

I want it to be able to adjust its height according to the contents inside it, without using scroll.  

#### Answer accepted (score 620)
Add this to your `&lt;head&gt;` section:  

```html
<script>
  function resizeIframe(obj) {
    obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
  }
</script>
```

And change your iframe to this:  

```html
<iframe src="..." frameborder="0" scrolling="no" onload="resizeIframe(this)" />
```

As found on <a href="https://www.sitepoint.com/community/t/auto-height-iframe-content-script/67843" rel="noreferrer">sitepoint discussion</a>.  

#### Answer 2 (score 87)
You can use this library, which both initially sizes your iframe correctly and also keeps it at the right size by detecting whenever the size of the iframe's content changes (either via regular checking in a `setInterval` or via `MutationObserver`) and resizing it.  

<strong><a href="https://github.com/davidjbradshaw/iframe-resizer" rel="nofollow noreferrer">https://github.com/davidjbradshaw/iframe-resizer</a></strong>  

Their is also a React version.  

<strong><a href="https://github.com/davidjbradshaw/iframe-resizer-react" rel="nofollow noreferrer">https://github.com/davidjbradshaw/iframe-resizer-react</a></strong>  

This works with both cross and same domain iframes.  

#### Answer 3 (score 48)
Here is a compact version:  

```html
<iframe src="hello.html"
        onload="this.style.height=this.contentDocument.body.scrollHeight +'px';">
</iframe>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: How can I make a button redirect my page to another page? (score [997900](https://stackoverflow.com/q/16562577) in 2015)

#### Question
I have been trying the following:  

```html
<form action="/home" class="inline">
    <button class="float-left submit-button" >Home</button>
</form>
```

It seems to work but it goes to the page "/home?"  

Is there a better way for me to make a button inside a form make the page go to a new location?  

#### Answer accepted (score 275)
Just add an `onclick` event to the `button`:  

```html
<button onclick="location.href = 'www.yoursite.com';" id="myButton" class="float-left submit-button" >Home</button>
```

But you shouldn't really have it inline like that, instead, put it in a JS block and give the `button` an ID:  

```html
<button id="myButton" class="float-left submit-button" >Home</button>

<script type="text/javascript">
    document.getElementById("myButton").onclick = function () {
        location.href = "www.yoursite.com";
    };
</script>
```

#### Answer 2 (score 33)
try  

```html
<button onclick="window.location.href='b.php'">Click me</button>
```

#### Answer 3 (score 8)
Just another variation:  

```html
    <body>
    <button name="redirect" onClick="redirect()">

    <script type="text/javascript">
    function redirect()
    {
    var url = "http://www.(url).com";
    window.location(url);
    }
    </script>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: href="tel:" and mobile numbers (score [979028](https://stackoverflow.com/q/17219688) in 2017)

#### Question
If I use `tel:` I should write the international phone code, like that.  

```html
<a href="tel:+6494461709">61709</a>
```

So far, so good, but I can't find information on how to write a cell phone number in an "international" way, if there is one.  

#### Answer accepted (score 347)
When dialing a number within the country you are in, you still need to dial the <a href="http://en.wikipedia.org/wiki/Trunk_prefix" rel="noreferrer">national trunk number</a> before the rest of the number. For example, in Australia one would dial:  

```html
   0 - trunk prefix
   2 - Area code for New South Wales
6555 - STD code for a specific telephone exchange
1234 - Telephone Exchange specific extension.
```

For a mobile phone this becomes  

```html
   0 -      trunk prefix
   4 -      Area code for a mobile telephone
1234 5678 - Mobile telephone number
```

Now, when I want to dial via the international trunk, you need to drop the trunk prefix and replace it with the <a href="http://en.wikipedia.org/wiki/List_of_international_call_prefixes" rel="noreferrer">international dialing prefix</a>  

```html
   + -      Short hand for the country trunk number
  61 -      Country code for Australia
   4 -      Area code for a mobile telephone
1234 5678 - Mobile telephone number
```

This is why you often find that the first digit of a telephone number is dropped when dialling internationally, even when using international prefixing to dial within the same country.  

So as per the <a href="http://en.wikipedia.org/wiki/Trunk_prefix#Europe" rel="noreferrer">trunk prefix for Germany</a> drop the `0` and add the `+49` for <a href="http://en.wikipedia.org/wiki/List_of_country_calling_codes" rel="noreferrer">Germany's international calling code</a> (for example) giving:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<a href="tel:+496170961709" class="Blondie">
    Call me, call me any, anytime
      <b>Call me (call me) I'll arrive</b>
        When you're ready we can share the wine!
</a>```
</div>
</div>


#### Answer 2 (score 40)
I know the OP is asking about international country codes but for North America, you could use the following:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<a href="tel:1-847-555-5555">1-847-555-5555</a>

<a href="tel:18475555555">Click Here To Call Support 1-847-555-5555</a>```
</div>
</div>


This might help you.  

#### Answer 3 (score 22)
The BlackBerry browser and Safari for iOS (iPhone/iPod/iPad) automatically detect phone numbers and email addresses and convert them to links. If you don’t want this feature, you should use the following meta tags.  

For Safari:  

```html
<meta name="format-detection" content="telephone=no">
```

For BlackBerry:  

```html
<meta http-equiv="x-rim-auto-match" content="none">
```

Source: <a href="http://www.mobilexweb.com/blog/click-to-call-links-mobile-browsers">mobilexweb.com</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Align image in center and middle within div (score [975288](https://stackoverflow.com/q/4888223) in 2014)

#### Question
I have following div  

```html
<div id="over" style="position:absolute; width:100%; height:100%>
 <img src="img.png">
</div>
```

How to align the image so as to be located in the middle and center of div ?  

#### Answer 2 (score 388)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
body {
  margin: 0;
}

#over img {
  margin-left: auto;
  margin-right: auto;
  display: block;
}```
```html
<div id="over" style="position:absolute; width:100%; height:100%">
  <img src="http://www.garcard.com/images/garcard_symbol.png">
</div>```
</div>
</div>


<a href="https://jsfiddle.net/Garconis/n3ooh4kt/" rel="noreferrer">JSFiddle</a>  

#### Answer 3 (score 158)
```html
<div style="display:table-cell; vertical-align:middle; text-align:center">
<img src="img.png">
</div>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: Set HTTP header to UTF-8 using PHP (score [967630](https://stackoverflow.com/q/4279282) in 2014)

#### Question
I have several <a href="http://en.wikipedia.org/wiki/PHP" rel="noreferrer">PHP</a> pages echoing out various things into <a href="http://en.wikipedia.org/wiki/HTML" rel="noreferrer">HTML</a> pages with the following code.  

```html
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
```

However, when I validate using the <a href="https://en.wikipedia.org/wiki/W3C_Markup_Validation_Service" rel="noreferrer">W3C validator</a> it comes up with:  

<blockquote>
  The character encoding specified in the HTTP header (iso-8859-1) is different from the value in the  element (utf-8).  
</blockquote>

I am quite new to PHP, and I was wondering if I could and should change the header for the PHP files to match the HTML files.  

#### Answer accepted (score 870)
Use <a href="http://php.net/header" rel="noreferrer">`header`</a> to modify the HTTP header:  

```html
header('Content-Type: text/html; charset=utf-8');
```

Note to call this function before any output has been sent to the client. Otherwise the header has been sent too and you obviously can’t change it any more. You can check that with <a href="http://php.net/headers_sent" rel="noreferrer">`headers_sent`</a>. See the <a href="http://php.net/header" rel="noreferrer">manual page of `header`</a> for more information.  

#### Answer 2 (score 32)
First make sure the PHP files themselves are <a href="http://en.wikipedia.org/wiki/UTF-8">UTF-8</a> encoded.  

The meta tag is ignored by some browser. If you only use ASCII-characters, it doesn't matter anyway.  

<a href="http://en.wikipedia.org/wiki/List_of_HTTP_header_fields">http://en.wikipedia.org/wiki/List_of_HTTP_header_fields</a>  

```html
header('Content-Type: text/html; charset=utf-8');
```

#### Answer 3 (score 15)
This is a problem with your web server sending out an HTTP header that does not match the one you define. For instructions on how to make the server send the correct headers, see <a href="http://www.w3.org/International/questions/qa-changing-encoding#server" rel="nofollow noreferrer">this page</a>.  

Otherwise, you can also use PHP to modify the headers, but this has to be done <em>before</em> outputting any text using this code:  

```html
header('Content-Type: text/html; charset=utf-8');
```

More information on how to send out headers using PHP can be found in <a href="http://php.net/manual/en/function.header.php" rel="nofollow noreferrer">the documentation for the header function</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: How to make a vertical line in HTML (score [967203](https://stackoverflow.com/q/3148415) in 2016)

#### Question
How do you make a vertical line using HTML?  

#### Answer accepted (score 523)
Put a `&lt;div&gt;` around the markup where you want the line to appear to next, and use CSS to style it:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
.verticalLine {
  border-left: thick solid #ff0000;
}```
```html
<div class="verticalLine">
  some other content
</div>```
</div>
</div>


#### Answer 2 (score 229)
You can use the horizontal rule tag to create vertical lines.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<hr width="1" size="500">```
</div>
</div>


By using minimal width and large size, horizontal rule becomes a vertical one.  

#### Answer 3 (score 68)
You can use an empty `&lt;div&gt;` that is styled exactly like you want the line to appear:  

<strong>HTML:</strong>  

```html
<div class="vertical-line"></div>
```

With exact height (overriding style in-line):  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
  div.vertical-line{
      width: 1px; /* Line width */
      background-color: black; /* Line color */
      height: 100%; /* Override in-line if you want specific height. */
      float: left; /* Causes the line to float to left of content. 
        You can instead use position:absolute or display:inline-block
        if this fits better with your design */
    }```
```html
<div class="vertical-line" style="height: 45px;"></div>```
</div>
</div>


Style the border if you want 3D look:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
    div.vertical-line{
      width: 0px; /* Use only border style */
      height: 100%;
      float: left; 
      border: 1px inset; /* This is default border style for <hr> tag */
    }```
```html
   <div class="vertical-line" style="height: 45px;"></div>```
</div>
</div>


You can of course also experiment with advanced combinations:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
  div.vertical-line{
      width: 1px;
      background-color: silver;
      height: 100%;
      float: left;
      border: 2px ridge silver ;
      border-radius: 2px;
    }```
```html
 <div class="vertical-line" style="height: 45px;"></div>```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 83: How do I reformat HTML code using Sublime Text 2? (score [961629](https://stackoverflow.com/q/8839753) in 2015)

#### Question
I've got some poorly-formatted HTML code that I'd like to reformat. Is there a command that will automatically reformat HTML code in Sublime Text 2 so it looks better and is easier to read?  

#### Answer accepted (score 2041)
<p>You don't need any plugins to do this.
Just select all lines (<kbd>Ctrl </kbd><kbd>A</kbd>) and then from the menu select Edit &rarr; Line &rarr; Reindent.
This will work if your file is saved with an extension that contains HTML like `.html` or `.php`.</p>

If you do this often, you may find this key mapping useful:  

```html
{ "keys": ["ctrl+shift+r"], "command": "reindent" , "args": { "single_line": false } }
```

If your file is not saved (e.g. you just pasted in a snippet to a new window), you can manually set the language for indentation by selecting the menu View &rarr; Syntax &rarr; `language of choice` before selecting the reindent option.  

#### Answer 2 (score 368)
There are half a dozen or so ways to format HTML in Sublime. I've tested each of the most popular plugins (see the <a href="http://sublimetexttips.com/formatting-html-with-sublime-text/">writeup I did on my blog</a> for full details), but here's a quick overview of some of the most popular options:  

<h5>Reindent command</h2>

Pros:  

<ul>
<li>Ships with Sublime, so no plugin install needed</li>
</ul>

Cons:  

<ul>
<li>Doesn't delete extra blank lines</li>
<li>Can't handle minified HTML, lines with multiple open tags</li>
<li>Doesn't properly format `&lt;script&gt;` blocks</li>
</ul>

<h5><a href="https://github.com/SublimeText/Tag">Tag</a></h2>

Pros:  

<ul>
<li>Supports ST2/ST3</li>
<li>Removes extra blank lines</li>
<li>No binary dependencies</li>
</ul>

Cons:  

<ul>
<li>Chokes on PHP tags</li>
<li>Doesn't handle `&lt;script&gt;` blocks correctly</li>
</ul>

<h5><a href="https://github.com/welovewordpress/SublimeHtmlTidy">HTMLTidy</a></h2>

Pros:  

<ul>
<li>Handles PHP tags</li>
<li>Some settings to tweak formatting</li>
</ul>

Cons:  

<ul>
<li>Requires PHP (falls back to web service)</li>
<li>ST2 only</li>
<li>Abandoned?</li>
</ul>

<h5><a href="https://github.com/rareyman/HTMLBeautify">HTMLBeautify</a></h2>

Pros:  

<ul>
<li>Supports ST2/ST3</li>
<li>Simple and no binaray dependencies</li>
<li>Support for OS X, Win and Linux</li>
</ul>

Cons:  

<ul>
<li>Chokes a bit with inline comments</li>
<li>Does expand minimized/compressed code </li>
</ul>

<h5><a href="https://github.com/victorporof/Sublime-HTMLPrettify">HTML-CSS-JS Prettify</a></h2>

Pros:  

<ul>
<li>Supports ST2/ST3</li>
<li>Handles HTML, CSS, JS</li>
<li>Great integration with Sublime's menus</li>
<li>Highly customizable</li>
<li>Per-project settings</li>
<li>Format on save option</li>
</ul>

Cons:  

<ul>
<li>Requires Node.js</li>
<li>Not great for embedded PHP </li>
</ul>

<h5>Which is best?</h2>

HTML-CSS-JS Prettify is the winner in my book. Lots of great features, not much to complain about.  

#### Answer 3 (score 176)
The only package I've been able to find is <a href="https://github.com/SublimeText/Tag" rel="noreferrer">Tag</a>.  

You can install it using the package control. <a href="https://sublime.wbond.net" rel="noreferrer">https://sublime.wbond.net</a>  

After installing package control. Go to package control (<em>Preferences</em> -> <em>Package Control</em>) then type `install`, hit <kbd>enter</kbd>. Then type `tag` and hit <kbd>enter</kbd>.  

After installing Tag, highlight the text and press the shortcut <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>F</kbd>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: Change the image source on rollover using jQuery (score [956957](https://stackoverflow.com/q/540349) in 2016)

#### Question
I have a few images and their rollover images. Using jQuery, I want to show/hide the rollover image when the onmousemove/onmouseout event happen. All my image names follow the same pattern, like this:  

<blockquote>
  Original Image: `Image.gif`    
  
  Rollover Image: `Imageover.gif`  
</blockquote>

I want to insert and remove the <em>"over"</em> portion of image source in the onmouseover and onmouseout event, respectively.    

How can I do it using jQuery?  

#### Answer accepted (score 619)
To set up on ready:  

```html
$(function() {
    $("img")
        .mouseover(function() { 
            var src = $(this).attr("src").match(/[^\.]+/) + "over.gif";
            $(this).attr("src", src);
        })
        .mouseout(function() {
            var src = $(this).attr("src").replace("over.gif", ".gif");
            $(this).attr("src", src);
        });
});
```

For those that use url image sources:  

```html
$(function() {
        $("img")
            .mouseover(function() {
               var src = $(this).attr("src");
               var regex = /_normal.svg/gi;
               src = this.src.replace(regex,'_rollover.svg');
               $(this).attr("src", src);

            })
            .mouseout(function() {
               var src = $(this).attr("src");
               var regex = /_rollover.svg/gi;
               src = this.src.replace(regex,'_normal.svg');
               $(this).attr("src", src);

            });
    });
```

#### Answer 2 (score 114)
I know you're asking about using jQuery, but you can achieve the same effect in browsers that have JavaScript turned off using CSS:  

```html
#element {
    width: 100px; /* width of image */
    height: 200px; /* height of image */
    background-image: url(/path/to/image.jpg);
}

#element:hover {
    background-image: url(/path/to/other_image.jpg);
}
```

There's a longer description <a href="http://tutorials.alsacreations.com/imgreactive/" rel="nofollow noreferrer">here</a>  

Even better, however, is to use sprites: <a href="http://www.findmotive.com/2006/10/31/simple-css-image-rollover/" rel="nofollow noreferrer">simple-css-image-rollover</a>  

#### Answer 3 (score 62)
If you have more than one image and you need something generic that doesn't depend on a naming convention.  

HTML  

```html
<img data-other-src="big-zebra.jpg" src="small-cat.jpg">
<img data-other-src="huge-elephant.jpg" src="white-mouse.jpg">
<img data-other-src="friendly-bear.jpg" src="penguin.jpg">
```

JavaScript  

```html
$('img').bind('mouseenter mouseleave', function() {
    $(this).attr({
        src: $(this).attr('data-other-src') 
        , 'data-other-src': $(this).attr('src') 
    })
});
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: How to write a:hover in inline CSS? (score [955832](https://stackoverflow.com/q/1033156) in 2017)

#### Question
I have a case where I must write inline CSS code, and I want to apply a hover style on an anchor.  

How can I use `a:hover` in inline CSS inside the HTML style attribute?  

E.g. you can't reliably use CSS classes in HTML emails.  

#### Answer accepted (score 534)
Short answer: you can't.  

Long answer: you shouldn't.   

Give it a class name or an id and use stylesheets to apply the style.  

`:hover` is a pseudo-selector and, for <a href="http://en.wikipedia.org/wiki/Cascading_Style_Sheets" rel="noreferrer">CSS</a>, only has meaning within the style sheet. There isn't any inline-style equivalent (as it isn't defining the selection criteria).   

Response to the OP's comments:  

See <em><a href="https://web.archive.org/web/20160104183713/http://www.hunlock.com/blogs/Totally_Pwn_CSS_with_Javascript" rel="noreferrer">Totally Pwn CSS with Javascript</a></em> for a good script on adding CSS rules dynamically. Also see <em><a href="http://www.quirksmode.org/dom/changess.html" rel="noreferrer">Change style sheet</a></em> for some of the theory on the subject.  

Also, don't forget, you can add links to external stylesheets if that's an option. For example,  

```html
<script type="text/javascript">
  var link = document.createElement("link");
  link.setAttribute("rel","stylesheet");
  link.setAttribute("href","http://wherever.com/yourstylesheet.css");
  var head = document.getElementsByTagName("head")[0];
  head.appendChild(link);
</script>
```

Caution: the above assumes there is a <a href="https://en.wikipedia.org/wiki/HTML_element#Document_structure_elements" rel="noreferrer">head</a> section.   

#### Answer 2 (score 401)
You can get the same effect by changing your styles with JavaScript in the `onMouseOver` and `onMouseOut` parameters, although it's extremely inefficient if you need to change more than one element:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<a href="abc.html"
   onMouseOver="this.style.color='#0F0'"
   onMouseOut="this.style.color='#00F'" >Text</a>```
</div>
</div>


Also, I can't remember for sure if `this` works in this context. You may have to switch it with `document.getElementById('idForLink')`.  

#### Answer 3 (score 51)
<p><a href="http://www.w3.org/TR/2002/WD-css-style-attr-20020515" rel="nofollow noreferrer">You could do it</a> at some point in the past. But now (according to the latest revision of the same standard, which is Candidate Recommendation) you can't
    .</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: Set the table column width constant regardless of the amount of text in its cells? (score [948281](https://stackoverflow.com/q/4457506) in 2017)

#### Question
<p>In my table I set the width of the first cell in a column to be `100px`.<br />
However, when the text in one of the cell in this column is too long, the width of the column becomes more than `100px`. How could I disable this expansion?</p>

#### Answer accepted (score 571)
I played with it for a bit because I had trouble figuring it out.    

You need to set the cell width (either `th` or `td` worked, I set both) AND set the `table-layout` to `fixed`. For some reason, the cell width seems to only stay fixed if the table width is set, too (I think that's silly but whatev).   

Also, it is useful to set the `overflow` property to `hidden` to prevent any extra text from coming out of the table.  

You should make sure to leave all of the bordering and sizing for CSS, too.  

Ok so here's what I have:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
table {
  border: 1px solid black;
  table-layout: fixed;
  width: 200px;
}

th,
td {
  border: 1px solid black;
  width: 100px;
  overflow: hidden;
}```
```html
<table>
  <tr>
    <th>header 1</th>
    <th>header 234567895678657</th>
  </tr>
  <tr>
    <td>data asdfasdfasdfasdfasdf</td>
    <td>data 2</td>
  </tr>
</table>```
</div>
</div>


<a href="http://jsfiddle.net/itamark/uAKNx/" rel="noreferrer">Here it is in JSFiddle</a>  

This guy had a similar problem: <a href="https://stackoverflow.com/q/446624/534056">Table cell widths - fixing width, wrapping/truncating long words</a>  

#### Answer 2 (score 155)
<p>See:
<a href="http://www.html5-tutorials.org/tables/changing-column-width/" rel="noreferrer">http://www.html5-tutorials.org/tables/changing-column-width/</a></p>

After the table tag, use the col element. you don't need a closing tag.  

For example, if you had three columns:  

```html
<table>
  <colgroup>
    <col style="width:40%">
    <col style="width:30%">
    <col style="width:30%">
  </colgroup>  
  <tbody>
    ...
  </tbody>
</table>
```

#### Answer 3 (score 121)
<p>Just add `&lt;div&gt;` tag inside `&lt;td&gt;` or `&lt;th&gt;` define width inside `&lt;div&gt;`. 
This will help you. Nothing else works.</p>

eg.   

```html
<td><div style="width: 50px" >...............</div></td>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: How to close current tab in a browser window? (score [943247](https://stackoverflow.com/q/2076299) in 2018)

#### Question
I want to create a link on a webpage that would close the currently active tab in a browser without closing other tabs in the browser. <br>When the user clicks the close link, an alert message should appear asking the user to confirm with two buttons, "YES" and "NO". If the user clicks "YES", close that page and If "NO", do nothing.  

How can it be done? Any suggestions?  

#### Answer accepted (score 459)
You will need Javascript to do this. Use <a href="https://developer.mozilla.org/en/DOM/window.close" rel="noreferrer">`window.close()`</a>:  

```html
close();
```

<strong>Note:</strong> the current tab is implied. This is equivalent:  

```html
window.close();
```

or you can specify a different window.  

So:  

```html
function close_window() {
  if (confirm("Close Window?")) {
    close();
  }
}
```

with HTML:  

```html
<a href="javascript:close_window();">close</a>
```

or:  

```html
<a href="#" onclick="close_window();return false;">close</a>
```

You `return false` here to prevent the default behavior for the event. Otherwise the browser will attempt to go to that URL (which it obviously isn't).  

Now the options on the <a href="https://developer.mozilla.org/en/DOM/window.confirm" rel="noreferrer">`window.confirm()`</a> dialog box will be OK and Cancel (not Yes and No). If you <em>really</em> want Yes and No you'll need to create some kind of modal Javascript dialog box.  

<strong>Note:</strong> there is browser-specific differences with the above. If you opened the window with Javascript (via `window.open()`) then you are allowed to close the window with javascript. Firefox disallows you from closing other windows. I believe IE will ask the user for confirmation. Other browsers may vary.  

#### Answer 2 (score 242)
Try this  

```html
<a href="javascript:window.open('','_self').close();">close</a>
```

#### Answer 3 (score 64)
This method works in Chrome and IE:  

```html
<a href="blablabla" onclick="setTimeout(function(){var ww = window.open(window.location, '_self'); ww.close(); }, 1000);">
    If you click on this the window will be closed after 1000ms
</a>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: How to align checkboxes and their labels consistently cross-browsers (score [939259](https://stackoverflow.com/q/306252) in 2018)

#### Question
This is one of the minor CSS problems that plagues me constantly.  How do folks around Stack Overflow vertically align <strong><em>`checkboxes`</em></strong> and their <strong><em>`labels`</em></strong> consistently <strong>cross-browser</strong>?  Whenever I align them correctly in Safari (usually using `vertical-align: baseline` on the `input`), they're completely off in Firefox and IE.  Fix it in Firefox, and Safari and IE are inevitably messed up. I waste time on this every time I code a form.  

Here's the standard code that I work with:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
<form>
    <div>
        <label><input type="checkbox" /> Label text</label>
    </div>
</form>```
</div>
</div>


I usually use Eric Meyer's reset, so form elements are relatively clean of overrides. Looking forward to any tips or tricks that you have to offer!  

#### Answer accepted (score 977)
After over an hour of tweaking, testing, and trying different styles of markup, I think I may have a decent solution.  The requirements for this particular project were:  

<ol>
<li>Inputs must be on their own line.</li>
<li>Checkbox inputs need to align vertically with the label text similarly (if not identically) across all browsers.</li>
<li>If the label text wraps, it needs to be indented (so no wrapping down underneath the checkbox).</li>
</ol>

Before I get into any explanation, I'll just give you the code:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
label {
  display: block;
  padding-left: 15px;
  text-indent: -15px;
}
input {
  width: 13px;
  height: 13px;
  padding: 0;
  margin:0;
  vertical-align: bottom;
  position: relative;
  top: -1px;
  *overflow: hidden;
}```
```html
<form>
  <div>
    <label><input type="checkbox" /> Label text</label>
  </div>
</form>```
</div>
</div>


Here is the working example in <a href="http://jsfiddle.net/t8EGn/6/" rel="noreferrer">JSFiddle</a>.  

This code assumes that you're using a reset like Eric Meyer's that doesn't override form input margins and padding (hence putting margin and padding resets in the input CSS).  Obviously in a live environment you'll probably be nesting/overriding stuff to support other input elements, but I wanted to keep things simple.  

Things to note:  

<ul>
<li>The `*overflow` declaration is an inline IE hack (the star-property hack).  Both IE 6 and 7 will notice it, but Safari and Firefox will properly ignore it. I think it might be valid CSS, but you're still better off with conditional comments; just used it for simplicity.</li>
<li>As best I can tell, the only `vertical-align` statement that was consistent across browsers was `vertical-align: bottom`.  Setting this and then relatively positioning upwards behaved almost identically in Safari, Firefox and IE with only a pixel or two of discrepancy.</li>
<li>The major problem in working with alignment is that IE sticks a bunch of mysterious space around input elements.  It isn't padding or margin, and it's damned persistent.  Setting a width and height on the checkbox and then `overflow: hidden` for some reason cuts off the extra space and allows IE's positioning to act very similarly to Safari and Firefox.</li>
<li>Depending on your text sizing, you'll no doubt need to adjust the relative positioning, width, height, and so forth to get things looking right.</li>
</ul>

Hope this helps someone else!  I haven't tried this specific technique on any projects other than the one I was working on this morning, so definitely pipe up if you find something that works more consistently.    

#### Answer 2 (score 196)
Sometimes vertical-align needs two inline (span, label, input, etc...) elements next to each other to work properly. The following checkboxes are properly vertically centered in IE, Safari, FF, and Chrome, even if the text size is very small or large.  

They all float next to each other on the same line, but the nowrap means that the whole label text always stays next to the checkbox.  

The downside is the extra meaningless SPAN tags.   

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
.checkboxes label {
  display: inline-block;
  padding-right: 10px;
  white-space: nowrap;
}
.checkboxes input {
  vertical-align: middle;
}
.checkboxes label span {
  vertical-align: middle;
}```
```html
<form>
  <div class="checkboxes">
    <label for="x"><input type="checkbox" id="x" /> <span>Label text x</span></label>
    <label for="y"><input type="checkbox" id="y" /> <span>Label text y</span></label>
    <label for="z"><input type="checkbox" id="z" /> <span>Label text z</span></label>
  </div>
</form>```
</div>
</div>


Now, if you had a very long label text that <em>needed</em> to wrap without wrapping under the checkbox, you'd use padding and negative text indent on the label elements:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
.checkboxes label {
  display: block;
  padding-right: 10px;
  padding-left: 22px;
  text-indent: -22px;
}
.checkboxes input {
  vertical-align: middle;
}
.checkboxes label span {
  vertical-align: middle;
}```
```html
<form>
  <div class="checkboxes">
    <label for="x"><input type="checkbox" id="x" /> <span>Label text x so long that it will probably wrap so let's see how it goes with the proposed CSS (expected: two lines are aligned nicely)</span></label>
    <label for="y"><input type="checkbox" id="y" /> <span>Label text y</span></label>
    <label for="z"><input type="checkbox" id="z" /> <span>Label text z</span></label>
  </div>
</form>```
</div>
</div>


#### Answer 3 (score 178)
Working off of <a href="https://stackoverflow.com/a/306593/1079573">One Crayon's solution</a>, I have something that works for me and is simpler:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
.font2 {font-family:Arial; font-size:32px} /* Sample font */

input[type=checkbox], input[type=radio] {
  vertical-align: middle;
  position: relative;
  bottom: 1px;
}

input[type=radio] { 
  bottom: 2px; 
} ```
```html
<label><input type="checkbox" /> Label text</label>
<p class="font2">
  <label><input type="checkbox"/> Label text</label>
</p>```
</div>
</div>


Renders pixel-for-pixel the same in Safari (whose baseline I trust) and both Firefox and IE7 check out as good.  It also works for various label font sizes, big and small. Now, for fixing IE's baseline on selects and inputs...  

<hr>

<strong>Update:</strong> (Third-Party Edit)  

The proper `bottom` position depends on font-family and font-size! I found using <strong>`bottom: .08em;`</strong> for checkbox &amp; radio elements is a good general value. I tested it in Chrome/Firefox/IE11 in windows with Arial &amp; Calibri fonts using several small/mid/large font-sizes.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
.font2, .font2 input {font-family:Arial; font-size:32px} /* Sample font */

input[type=checkbox], input[type=radio] {
  vertical-align: middle; 
  position: relative;
  bottom: .08em; /* this is a better value for different fonts! */
}```
```html
<label><input type="checkbox" /> Label text</label> 

<p class="font2">
  <label><input type="checkbox"/> Label text</label>
</p>```
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 89: How do I retrieve an HTML element's actual width and height? (score [937801](https://stackoverflow.com/q/294250) in 2016)

#### Question
Suppose that I have a `&lt;div&gt;` that I wish to center in the browser's display (viewport). To do so, I need to calculate the width and height of the `&lt;div&gt;` element.   

What should I use? Please include information on browser compatibility.  

#### Answer accepted (score 1186)
<p>You should use the `.offsetWidth` and `.offsetHeight` properties.
Note they belong to the element, not `.style`.</p>

`var width = document.getElementById('foo').offsetWidth;`  

#### Answer 2 (score 179)
Take a look at <a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect" rel="noreferrer">`Element.getBoundingClientRect()`</a>.  

This method will return an object containing the `width`, `height`, and some other useful values:  

```html
{
    width: 960,
    height: 71,
    top: 603,
    bottom: 674,
    left: 360,
    right: 1320
}
```

For Example:  

```html
var element = document.getElementById('foo');
var positionInfo = element.getBoundingClientRect();
var height = positionInfo.height;
var width = positionInfo.width;
```

I believe this does not have the issues that `.offsetWidth` and `.offsetHeight` do where they sometimes return `0` (as discussed in the <a href="https://stackoverflow.com/a/294273/363701">comments here</a>)  

Another difference is `getBoundingClientRect()` may return fractional pixels, where `.offsetWidth` and `.offsetHeight` will round to the nearest integer.  

<strong>IE8 Note</strong>: `getBoundingClientRect` does not return height and width on <strong>IE8</strong> and below.*  

If you <em>must</em> support IE8, use `.offsetWidth` and `.offsetHeight`:  

```html
var height = element.offsetHeight;
var width = element.offsetWidth;
```

Its worth noting that the Object returned by this method is not really a <em>normal</em> object. Its properties are not <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Enumerability_and_ownership_of_properties" rel="noreferrer"><em>enumerable</em></a> (so, for example, `Object.keys` doesn't work out-of-the-box.)  

<p>More info on this here:
<a href="https://stackoverflow.com/questions/39417566/how-best-to-convert-a-clientrect-domrect-into-a-plain-object">How best to convert a ClientRect / DomRect into a plain Object</a></p>

Reference:  

<ul>
<li><strong>`.offsetHeight`</strong>: <a href="https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetHeight" rel="noreferrer">https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetHeight</a></li>
<li><strong>`.offsetWidth`</strong>: <a href="https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetWidth" rel="noreferrer">https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetWidth</a></li>
<li><strong>`.getBoundingClientRect()`</strong>: <a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect" rel="noreferrer">https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect</a></li>
</ul>

#### Answer 3 (score 64)
<strong>NOTE</strong>: <em>this answer was written in 2008. At the time the best cross-browser solution for most people really was to use jQuery. I'm leaving the answer here for posterity and, if you're using jQuery, this is a good way to do it. If you're using some other framework or pure JavaScript the accepted answer is probably the way to go.</em>  

As of jQuery 1.2.6 you can use one of the core <a href="http://api.jquery.com/category/css/" rel="noreferrer">CSS functions</a>, `height` and `width` (or `outerHeight` and `outerWidth`, as appropriate).  

```html
var height = $("#myDiv").height();
var width = $("#myDiv").width();

var docHeight = $(document).height();
var docWidth = $(document).width();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: How to make an image center (vertically & horizontally) inside a bigger div (score [929682](https://stackoverflow.com/q/388180) in 2016)

#### Question
I have a div 200 x 200 px. I want to place a 50 x 50 px image right in the middle of the div.   

How can it be done?  

I am able to get it centered horizontally by using `text-align: center` for the div. But vertical alignment is the issue..  

#### Answer accepted (score 320)
Personally, I'd place it as the background image within the div, the CSS for that being:  

```html
#demo {
    background: url(bg_apple_little.gif) no-repeat center center;
    height: 200px;
    width: 200px;
}
```

(Assumes a div with `id="demo"` as you are already specifying `height` and `width` adding a `background` shouldn't be an issue)  

Let the browser take the strain.  

#### Answer 2 (score 405)
<em>Working in old browsers (IE >= 8)</em>  

Absolute position in combination with automatic margin permits to center an element horizontally and vertically. The element position could be based on a parent element position using relative positioning. <a href="https://jsfiddle.net/stuttufu/sj2m0oo2/1/" rel="noreferrer">View Result</a>  

```html
img {
    position: absolute;
    margin: auto;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
}
```

#### Answer 3 (score 105)
another way is to create a `table` with `valign`, of course. This would work regardless of you knowing the div's height or not.  

```html
<div>
   <table width="100%" height="100%" align="center" valign="center">
   <tr><td>
      <img src="foo.jpg" alt="foo" />
   </td></tr>
   </table>
</div>
```

but you should always stick to just `css` whenever possible.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: Set cookie and get cookie with JavaScript (score [928603](https://stackoverflow.com/q/14573223) in 2018)

#### Question
I'm trying to set a cookie depending on which CSS file I choose in my HTML. I have a form with a list of options, and different CSS files as values. When I choose a file, it should be saved to a cookie for about a week. The next time you open your HTML file, it should be the previous file you've chosen.  

JavaScript code:  

```html
function cssLayout() {
    document.getElementById("css").href = this.value;
}


function setCookie(){
    var date = new Date("Februari 10, 2013");
    var dateString = date.toGMTString();
    var cookieString = "Css=document.getElementById("css").href" + dateString;
    document.cookie = cookieString;
}

function getCookie(){
    alert(document.cookie);
}
```

HTML code:  

```html
<form>
    Select your css layout:<br>
    <select id="myList">
        <option value="style-1.css">CSS1</option>
        <option value="style-2.css">CSS2</option>  
        <option value="style-3.css">CSS3</option>
        <option value="style-4.css">CSS4</option>
    </select>
</form>
```

#### Answer 2 (score 721)
I find the following code to be much simpler than anything else:  

```html
function setCookie(name,value,days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days*24*60*60*1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "")  + expires + "; path=/";
}
function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}
function eraseCookie(name) {   
    document.cookie = name+'=; Max-Age=-99999999;';  
}
```

<strong>Now, calling functions</strong>  

```html
setCookie('ppkcookie','testcookie',7);

var x = getCookie('ppkcookie');
if (x) {
    [do something with x]
}
```

Source - <a href="http://www.quirksmode.org/js/cookies.html" rel="noreferrer">http://www.quirksmode.org/js/cookies.html</a>  

They updated the page today so everything in the page should be latest as of now.  

#### Answer 3 (score 324)
These are much <em>much</em> better references than w3schools (the most awful web reference ever made):  

<ul>
<li><a href="http://www.quirksmode.org/js/cookies.html" rel="noreferrer">How cookies work (quirksmode.org)</a></li>
<li><a href="https://developer.mozilla.org/en-US/docs/Web/API/document.cookie" rel="noreferrer">MDN document.cookie</a></li>
</ul>

Examples derived from these references:  

```html
// sets the cookie cookie1
document.cookie =
 'cookie1=test; expires=Fri, 19 Jun 2020 20:47:11 UTC; path=/'

// sets the cookie cookie2 (cookie1 is *not* overwritten)
document.cookie =
 'cookie2=test; expires=Fri, 19 Jun 2020 20:47:11 UTC; path=/'

// remove cookie2
document.cookie = 'cookie2=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/'
```

The Mozilla reference even has a nice cookie library you can use.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: What does enctype='multipart/form-data' mean? (score [925700](https://stackoverflow.com/q/4526273) in 2019)

#### Question
What does `enctype='multipart/form-data'` mean in an HTML form and when should we use it?  

#### Answer accepted (score 1436)
When you make a POST request, you have to encode the data that forms the body of the request in some way.   

HTML forms provide three methods of encoding.   

<ul>
<li>`application/x-www-form-urlencoded` (the default)</li>
<li>`multipart/form-data`</li>
<li>`text/plain`</li>
</ul>

Work was being done on adding <a href="http://www.w3.org/TR/html-json-forms/" rel="noreferrer">`application/json`</a>, but that has been abandoned.  

(Other encodings are possible with HTTP requests generated using other means than an HTML form submission.)  

The specifics of the formats don't matter to most developers. The important points are:  

<ul>
<li>Never use `text/plain`.</li>
</ul>

When you are writing client-side code:  

<ul>
<li>use `multipart/form-data` when your form includes any `&lt;input type="file"&gt;` elements</li>
<li>otherwise you can use `multipart/form-data` or `application/x-www-form-urlencoded` but `application/x-www-form-urlencoded` will be more efficient</li>
</ul>

When you are writing server-side code:   

<ul>
<li>Use a prewritten form handling library</li>
</ul>

Most (such as Perl's `CGI-&gt;param` or the one exposed by PHP's `$_POST` superglobal) will take care of the differences for you. Don't bother trying to parse the raw input received by the server.  

Sometimes you will find a library which can't handle both formats.  Node.js's most popular library for handling form data is <a href="https://github.com/expressjs/body-parser" rel="noreferrer">body-parser</a> which cannot handle multipart requests (but has documentation which recommends some alternatives which can).  

<hr>

If you are writing (or debugging) a library for parsing or generating the raw data, then you need to start worrying about the format. You might also want to know about it for interest's sake.  

`application/x-www-form-urlencoded` is more or less the same as a query string on the end of the URL.   

`multipart/form-data` is significantly more complicated but it allows entire files to be included in the data. An example of the result can be found in the <a href="http://www.w3.org/TR/html401/interact/forms.html#h-17.13.4" rel="noreferrer">HTML 4 specification</a>.   

`text/plain` is introduced by HTML 5 and is useful only for debugging — from <a href="http://www.w3.org/TR/html5/forms.html#text/plain-encoding-algorithm" rel="noreferrer">the spec</a>: <em>They are not reliably interpretable by computer</em> — and I'd argue that the others combined with tools (like the Net tab in the developer tools of most browsers) are better for that).  

#### Answer 2 (score 399)
<blockquote>
  when should we use it  
</blockquote>

Quentin's answer is right: use `multipart/form-data` if the form contains a file upload, and `application/x-www-form-urlencoded` otherwise, which is the default if you omit `enctype`.  

I'm going to:  

<ul>
<li>add some more HTML5 references</li>
<li>explain <strong>why</strong> he is right with a form submit example</li>
</ul>

<h5>HTML5 references</h2>

There are <a href="https://www.w3.org/TR/html5/sec-forms.html#element-attrdef-form-enctype" rel="noreferrer">three possibilities</a> for `enctype`:  

<ul>
<li><a href="https://www.w3.org/TR/html5/sec-forms.html#urlencoded-form-data" rel="noreferrer">`application/x-www-form-urlencoded`</a></li>
<li><a href="https://www.w3.org/TR/html5/sec-forms.html#multipart-form-data" rel="noreferrer">`multipart/form-data`</a> (spec points to <a href="https://tools.ietf.org/html/rfc7578" rel="noreferrer">RFC7578</a>)</li>
<li><a href="https://www.w3.org/TR/html5/sec-forms.html#plain-text-form-data" rel="noreferrer">`text/plain`</a>. This is "not reliably interpretable by computer", so it should never be used in production, and we will not look further into it.</li>
</ul>

<h5>How to generate the examples</h2>

Once you see an example of each method, it becomes obvious how they work, and when you should use each one.  

You can produce examples using:  

<ul>
<li>`nc -l` or an ECHO server: <a href="https://stackoverflow.com/questions/5725430/http-test-server-accepting-get-post-requests/52351480#52351480">HTTP test server accepting GET/POST requests</a></li>
<li>an user agent like a browser or cURL</li>
</ul>

Save the form to a minimal `.html` file:  

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <title>upload</title>
</head>
<body>
<form action="http://localhost:8000" method="post" enctype="multipart/form-data">
  <p><input type="text" name="text1" value="text default">
  <p><input type="text" name="text2" value="a&#x03C9;b">
  <p><input type="file" name="file1">
  <p><input type="file" name="file2">
  <p><input type="file" name="file3">
  <p><button type="submit">Submit</button>
</form>
</body>
</html>
```

We set the default text value to `a&amp;#x03C9;b`, which means `aωb` because `ω` is `U+03C9`, which are the bytes `61 CF 89 62` in UTF-8.  

Create files to upload:  

```html
echo 'Content of a.txt.' > a.txt

echo '<!DOCTYPE html><title>Content of a.html.</title>' > a.html

# Binary file containing 4 bytes: 'a', 1, 2 and 'b'.
printf 'a\xCF\x89b' > binary
```

Run our little echo server:  

```html
while true; do printf '' | nc -l 8000 localhost; done
```

Open the HTML on your browser, select the files and click on submit and check the terminal.   

`nc` prints the request received.  

Tested on: Ubuntu 14.04.3, `nc` BSD 1.105, Firefox 40.  

<h5>multipart/form-data</h2>

Firefox sent:  

```html
POST / HTTP/1.1
[[ Less interesting headers ... ]]
Content-Type: multipart/form-data; boundary=---------------------------735323031399963166993862150
Content-Length: 834

-----------------------------735323031399963166993862150
Content-Disposition: form-data; name="text1"

text default
-----------------------------735323031399963166993862150
Content-Disposition: form-data; name="text2"

aωb
-----------------------------735323031399963166993862150
Content-Disposition: form-data; name="file1"; filename="a.txt"
Content-Type: text/plain

Content of a.txt.

-----------------------------735323031399963166993862150
Content-Disposition: form-data; name="file2"; filename="a.html"
Content-Type: text/html

<!DOCTYPE html><title>Content of a.html.</title>

-----------------------------735323031399963166993862150
Content-Disposition: form-data; name="file3"; filename="binary"
Content-Type: application/octet-stream

aωb
-----------------------------735323031399963166993862150--
```

For the binary file and text field, the bytes `61 CF 89 62` (`aωb` in UTF-8) are sent literally. You could verify that with `nc -l localhost 8000 | hd`, which says that the bytes:  

```html
61 CF 89 62
```

were sent (`61` == 'a' and `62` == 'b').  

Therefore it is clear that:  

<ul>
<li><p>`Content-Type: multipart/form-data; boundary=---------------------------9051914041544843365972754266` sets the content type to `multipart/form-data` and says that the fields are separated by the given `boundary` string.</p></li>
<li><p>every field gets some sub headers before its data: `Content-Disposition: form-data;`, the field `name`, the `filename`, followed by the data.</p>

The server reads the data until the next boundary string. The browser must choose a boundary that will not appear in any of the fields, so this is why the boundary may vary between requests.  

Because we have the unique boundary, no encoding of the data is necessary: binary data is sent as is.  

TODO: what is the optimal boundary size (`log(N)` I bet), and name / running time of the algorithm that finds it? Asked at: <a href="https://cs.stackexchange.com/questions/39687/find-the-shortest-sequence-that-is-not-a-sub-sequence-of-a-set-of-sequences">https://cs.stackexchange.com/questions/39687/find-the-shortest-sequence-that-is-not-a-sub-sequence-of-a-set-of-sequences</a>  </li>
<li><p>`Content-Type` is automatically determined by the browser.</p>

How it is determined exactly was asked at: <a href="https://stackoverflow.com/questions/1201945/how-is-mime-type-of-an-uploaded-file-determined-by-browser">How is mime type of an uploaded file determined by browser?</a>  </li>
</ul>

<h5>application/x-www-form-urlencoded</h2>

Now change the `enctype` to `application/x-www-form-urlencoded`, reload the browser, and resubmit.  

Firefox sent:  

```html
POST / HTTP/1.1
[[ Less interesting headers ... ]]
Content-Type: application/x-www-form-urlencoded
Content-Length: 51

text1=text+default&text2=a%CF%89b&file1=a.txt&file2=a.html&file3=binary
```

Clearly the file data was not sent, only the basenames. So this cannot be used for files.  

As for the text field, we see that usual printable characters like `a` and `b` were sent in one byte, while non-printable ones like `0xCF` and `0x89` took up <strong>3 bytes</strong> each: `%CF%89`!  

<h5>Comparison</h2>

File uploads often contain lots of non-printable characters (e.g. images), while text forms almost never do.  

From the examples we have seen that:  

<ul>
<li><p>`multipart/form-data`: adds a few bytes of boundary overhead to the message, and must spend some time calculating it, but sends each byte in one byte.</p></li>
<li><p>`application/x-www-form-urlencoded`: has a single byte boundary per field (`&amp;`), but adds a <em>linear</em> overhead factor of <strong>3x</strong> for every non-printable character.</p></li>
</ul>

Therefore, even if we could send files with `application/x-www-form-urlencoded`, we wouldn't want to, because it is so inefficient.  

But for printable characters found in text fields, it does not matter and generates less overhead, so we just use it.  

#### Answer 3 (score 85)
`enctype='multipart/form-data` is an encoding type that allows files to be sent through a <em>POST</em>. Quite simply, without this encoding the files cannot be sent through <em>POST</em>.  

If you want to allow a user to upload a file via a form, you must use this <em>enctype</em>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: How to run a function when the page is loaded? (score [920311](https://stackoverflow.com/q/4842590) in 2019)

#### Question
I want to run a function when the page is loaded, but I don’t want to use it in the `&lt;body&gt;` tag.  

I have a script that runs if I initialise it in the `&lt;body&gt;`, like this:  

```html
function codeAddress() {
  // code
}
```

```html
<body onLoad="codeAddress()">
```

But I want to run it without the `&lt;body onload="codeAddress()"&gt;` and I have tried a lot of things, e.g. this:  

```html
window.onload = codeAddress;
```

But it is not working.  

So how do I run it when the page is loaded?  

#### Answer accepted (score 331)
`window.onload = codeAddress;` should work - <a href="http://jsfiddle.net/NEfR2/">here's a demo</a>, and the full code:  

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
```html
<!DOCTYPE html>
<html>
    <head>
        <title>Test</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script type="text/javascript">
        function codeAddress() {
            alert('ok');
        }
        window.onload = codeAddress;
        </script>
    </head>
    <body>
    
    </body>
</html>```
</div>
</div>


<hr>

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
```html
<!DOCTYPE html>
<html>
    <head>
        <title>Test</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script type="text/javascript">
        function codeAddress() {
            alert('ok');
        }
        
        </script>
    </head>
    <body onload="codeAddress();">
    
    </body>
</html>```
</div>
</div>


#### Answer 2 (score 153)
Rather than using jQuery or window.onload, native JavaScript has adopted some great functions since the release of jQuery. All modern browsers now have their own DOM ready function without the use of a jQuery library.   

I'd recommend this if you use native Javascript.  

```html
document.addEventListener('DOMContentLoaded', function() {
    alert("Ready!");
}, false);
```

#### Answer 3 (score 44)
Taking Darin's answer but jQuery style. (I know the user asked for javascript).  

<a href="http://jsfiddle.net/NEfR2/">running fiddle</a>  

```html
$(document).ready ( function(){
   alert('ok');
});​
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: How do you get centered content using Twitter Bootstrap? (score [918180](https://stackoverflow.com/q/9184141) in 2017)

#### Question
I'm trying to follow a very basic example.  Using the <a href="http://getbootstrap.com/css/#grid" rel="noreferrer">starter page and the grid system</a>, I was hoping the following:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
<div class="row">
  <div class="span12">
    <h1>Bootstrap starter template</h1>
    <p>Example text.</p>
  </div>
</div>```
</div>
</div>


...would produce centered text.  

However, it still appears on the far left. What am I doing wrong?  

#### Answer accepted (score 686)
<h5>This is for Text Centering (<em>which is what the question was about</em>)</h2>

For other types of content, see <a href="https://stackoverflow.com/a/13099189/2812842">Flavien's answer</a>.  

<strong>Update: Bootstrap 2.3.0+ Answer</strong>  

The original answer was for an early version of bootstrap. As of bootstrap 2.3.0, <strong>you can simply give the div the class `.text-center`</strong>.  

<hr>

<strong>Original Answer (pre 2.3.0)</strong>  

You need to define one of the two classes, `row` or `span12` with a `text-align: center`. See <a href="http://jsfiddle.net/xKSUH/" rel="noreferrer">http://jsfiddle.net/xKSUH/</a> or <a href="http://jsfiddle.net/xKSUH/1/" rel="noreferrer">http://jsfiddle.net/xKSUH/1/</a>  

#### Answer 2 (score 241)
NOTE: this was <a href="https://stackoverflow.com/questions/15265253/centering-the-pagination-in-bootstrap#comment29641329_15265287">removed in Bootstrap 3</a>.  

<hr>

Pre-Bootstrap 3, you could use the CSS class `pagination-centered` like this:  

```html
<div class="span12 pagination-centered">
    Centered content.
</div>
```

Class `pagination-centered` is already in bootstrap.css (or bootstrap.min.css) and has the only one rule:  

```html
.pagination-centered{text-align:center;}
```

With <strong>Bootstrap 2.3.0.</strong> just use class `text-center`  

#### Answer 3 (score 151)
I guess most of the people here are actually searching for the way to <em>center the whole `div`</em> and not only the text content (which is trivial…).  

The second way (instead of using text-align:center) to center things in HTML is to have an element with a fixed width and auto margin (left and right). With Bootstrap, the style defining auto margins is the "container" class.  

```html
<div class="container">
    <div class="span12">
        "Centered stuff there"
    </div>
</div>
```

Take a look here for a fiddle: <a href="http://jsfiddle.net/D2RLR/7788/" rel="noreferrer">http://jsfiddle.net/D2RLR/7788/</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: How to line-break from css, without using <br />? (score [917036](https://stackoverflow.com/q/2703601) in 2018)

#### Question
<strong>output:</strong>  

hello <br> How are you   

<strong>code:</strong>  

```html
<p>hello <br> How are you </p>
```

How to achieve same output without `&lt;br&gt;`?  

#### Answer accepted (score 353)
Impossible with the same HTML structure, you must have something to distinguish between `Hello` and `How are you`.  

I suggest using `span`s that you will then display as blocks (just like a `&lt;div&gt;` actually).  

HTML:  

```html
<p><span>hello</span><span>How are you</span></p>
```

CSS:  

```html
p span 
{
    display: block;
}
```

#### Answer 2 (score 315)
You can use `white-space: pre;` to make elements act like `&lt;pre&gt;`, which preserves newlines.  Example:  

```html
<style>
 p {
  white-space: pre;
 }
</style>
<p>hello
How are you</p>
```

Note that this doesn't work in IE6 or IE7.  I don't know about IE8.  

#### Answer 3 (score 112)
<h5>Use `&lt;br/&gt;` as normal, but hide it with `display: none` when you don't want it.</h3>

I would expect most people finding this question want to use css / responsive design to decide whether or not a line-break appears in a specific place. (and don't have anything personal against `&lt;br/&gt;`)  

While not immediately obvious, you can actually apply `display:none` to a `&lt;br/&gt;` tag to hide it, which enables the use of media queries in tandem with semantic BR tags.   

```html
 <div>
   The quick brown fox<br />
   jumps over the lazy dog
 </div>

 @media screen and (min-width: 20em) 
 {
    br 
    { 
       display: none;   // hide the BR tag for wider screens (i.e. disable the line break)
    }
 }
```

This is useful in responsive design where you need to force text into two lines at an exact break.  

<a href="http://jsfiddle.net/nNbD3/1/" rel="noreferrer">http://jsfiddle.net/nNbD3/1/</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: How to send HTTP request in java? (score [913251](https://stackoverflow.com/q/1359689) in 2014)

#### Question
In Java, How to compose a HTTP request message and send it to a HTTP WebServer?  

#### Answer accepted (score 292)
You can use <a href="http://download.oracle.com/javase/7/docs/api/java/net/HttpURLConnection.html" rel="nofollow noreferrer">java.net.HttpUrlConnection</a>.  

Example (<a href="http://www.xyzws.com/Javafaq/how-to-use-httpurlconnection-post-data-to-web-server/139" rel="nofollow noreferrer">from here</a>), with improvements. Included in case of link rot:  

```html
public static String executePost(String targetURL, String urlParameters) {
  HttpURLConnection connection = null;

  try {
    //Create connection
    URL url = new URL(targetURL);
    connection = (HttpURLConnection) url.openConnection();
    connection.setRequestMethod("POST");
    connection.setRequestProperty("Content-Type", 
        "application/x-www-form-urlencoded");

    connection.setRequestProperty("Content-Length", 
        Integer.toString(urlParameters.getBytes().length));
    connection.setRequestProperty("Content-Language", "en-US");  

    connection.setUseCaches(false);
    connection.setDoOutput(true);

    //Send request
    DataOutputStream wr = new DataOutputStream (
        connection.getOutputStream());
    wr.writeBytes(urlParameters);
    wr.close();

    //Get Response  
    InputStream is = connection.getInputStream();
    BufferedReader rd = new BufferedReader(new InputStreamReader(is));
    StringBuilder response = new StringBuilder(); // or StringBuffer if Java version 5+
    String line;
    while ((line = rd.readLine()) != null) {
      response.append(line);
      response.append('\r');
    }
    rd.close();
    return response.toString();
  } catch (Exception e) {
    e.printStackTrace();
    return null;
  } finally {
    if (connection != null) {
      connection.disconnect();
    }
  }
}
```

#### Answer 2 (score 222)
From <a href="http://java.sun.com/docs/books/tutorial/networking/urls/readingWriting.html" rel="noreferrer">Oracle's java tutorial</a>  

```html
import java.net.*;
import java.io.*;

public class URLConnectionReader {
    public static void main(String[] args) throws Exception {
        URL yahoo = new URL("http://www.yahoo.com/");
        URLConnection yc = yahoo.openConnection();
        BufferedReader in = new BufferedReader(
                                new InputStreamReader(
                                yc.getInputStream()));
        String inputLine;

        while ((inputLine = in.readLine()) != null) 
            System.out.println(inputLine);
        in.close();
    }
}
```

#### Answer 3 (score 68)
I know others will recommend Apache's http-client, but it adds complexity (i.e., more things that can go wrong) that is rarely warranted. For a simple task, `java.net.URL` will do.  

```html
URL url = new URL("http://www.y.com/url");
InputStream is = url.openStream();
try {
  /* Now read the retrieved document from the stream. */
  ...
} finally {
  is.close();
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: How to display Base64 images in HTML? (score [905633](https://stackoverflow.com/q/8499633) in 2017)

#### Question
I'm having trouble displaying a Base64 image inline.  

Can someone point me in the right direction?  

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Display Image</title>
  </head>
  <body>
    <img style='display:block; width:100px;height:100px;' id='base64image'                 
       src='data:image/jpeg;base64, LzlqLzRBQ...<!-- base64 data -->' />
  </body>
</html>
```

#### Answer accepted (score 695)
My suspect is of course actual base64 data, otherwise it looks good to me. See <a href="http://jsfiddle.net/hpP45/" rel="noreferrer">this fiddle</a> where similar scheme is working. You may try specifying char set.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```html
<div>
  <p>Taken from wikpedia</p>
  <img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUA
    AAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO
        9TXL0Y4OHwAAAABJRU5ErkJggg==" alt="Red dot" />
</div>```
</div>
</div>


You can try <a href="http://www.opinionatedgeek.com/dotnet/tools/base64decode/" rel="noreferrer">this base64 decoder</a> to see if your base64 data is correct or not.  

#### Answer 2 (score 53)
<p>You need to specify correct Content-type, Content-encoding and charset 
like </p>

```html
 data:image/jpeg;charset=utf-8;base64, 
```

according to the syntax of the <a href="https://en.wikipedia.org/wiki/Data_URI_scheme#Syntax" rel="nofollow noreferrer">data URI scheme</a>:  

```html
 data:[<media type>][;charset=<character set>][;base64],<data>
```

#### Answer 3 (score 34)
If you have PHP on the back-end, you can use this code:  

```html
$image = 'http://images.itracki.com/2011/06/favicon.png';
// Read image path, convert to base64 encoding
$imageData = base64_encode(file_get_contents($image));

// Format the image SRC:  data:{mime};base64,{data};
$src = 'data: '.mime_content_type($image).';base64,'.$imageData;

// Echo out a sample image
echo '<img src="'.$src.'">';
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: How to trigger a file download when clicking an HTML button or JavaScript (score [897161](https://stackoverflow.com/q/11620698) in 2017)

#### Question
This is crazy but I don't know how to do this, and because of how common the words are, it's hard to find what I need on search engines. I'm thinking this should be an easy one to answer.  

I want a simple file download, that would do the same as this:  

```html
<a href="file.doc">Download!</a>
```

But I want to use an HTML button, e.g. either of these:  

```html
<input type="button" value="Download!">
<button>Download!</button>
```

Likewise, is it possible to trigger a simple download via JavaScript?  

```html
$("#fileRequest").click(function(){ /* code to download? */ });
```

I'm definitely <em>not</em> looking for a way to create an anchor that looks like a button, use any back-end scripts, or mess with server headers or mime types.  

#### Answer accepted (score 263)
For the button you can do  

```html
<form method="get" action="file.doc">
   <button type="submit">Download!</button>
</form>
```

#### Answer 2 (score 399)
You can trigger a download with the HTML5 `download` attribute.  

```html
<a href="path_to_file" download="proposed_file_name">Download</a>
```

Where:  

<ul>
<li>`path_to_file` is a path that resolves to an URL <strong>on the <a href="https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy" rel="nofollow noreferrer">same origin</a>.</strong> That means the page and the file must share the same domain, subdomain, protocol (HTTP vs. HTTPS), and port (if specified). Exceptions are <a href="https://developer.mozilla.org/en-US/docs/Web/API/Blob" rel="nofollow noreferrer">`blob:`</a> and <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs" rel="nofollow noreferrer">`data:`</a> (which always work), and <a href="https://en.wikipedia.org/wiki/File_URI_scheme" rel="nofollow noreferrer">`file:`</a> (which never works).</li>
<li>`proposed_file_name` is the filename to save to. If it is blank, the browser defaults to the file's name.</li>
</ul>

Documentation: <a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#attr-download" rel="nofollow noreferrer">MDN</a>, <a href="https://html.spec.whatwg.org/multipage/links.html#downloading-resources" rel="nofollow noreferrer">HTML Standard on downloading</a>, <a href="https://html.spec.whatwg.org/multipage/links.html#attr-hyperlink-download" rel="nofollow noreferrer">HTML Standard on `download`</a>, <a href="https://caniuse.com/#feat=download" rel="nofollow noreferrer">CanIUse</a>  

#### Answer 3 (score 69)
HTML:  

```html
<button type="submit" onclick="window.open('file.doc')">Download!</button>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: How do you create a hidden div that doesn't create a line break or horizontal space? (score [896654](https://stackoverflow.com/q/1992114) in 2017)

#### Question
I want to have a hidden checkbox that doesn't take up any space on the screen.  

If I have this:  

```html
<div id="divCheckbox" style="visibility: hidden">
```

I don't see the checkbox, but it still creates a new line.  

If I have this:  

```html
<div id="divCheckbox" style="visibility: hidden; display:inline;">
```

it no longer creates a new line, but it takes up horizontal space on the screen.  

Is there a way to have a hidden div that takes up no room (vertical or horizontal?  

#### Answer accepted (score 680)
Use `display:none;`  

```html
<div id="divCheckbox" style="display: none;">
```

<ul>
<li><p>`visibility: hidden` hides the element, but it still takes up space in the layout.</p></li>
<li><p>`display: none` removes the element completely from the document, it doesn't take up any space.</p></li>
</ul>

#### Answer 2 (score 47)
Since the release of <a href="http://www.w3.org/TR/html5/" rel="noreferrer">HTML5</a> one can now simply do:  

```html
<div hidden>This div is hidden</div>
```

<strong>Note:</strong> This is not <a href="http://tjvantoll.com/2013/01/09/html5-hidden-attribute-browser-support/" rel="noreferrer">supported</a> by some old browsers, most notably IE &lt; 11.   

<em>Hidden</em> Attribute Documentation  (<a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/hidden" rel="noreferrer">MDN</a>,<a href="http://www.w3.org/html/wg/drafts/html/master/editing.html#the-hidden-attribute" rel="noreferrer">W3C</a>)  

#### Answer 3 (score 29)
Use `style="display: none;"`.  Also, you probably don't need to have the DIV, just setting the style to `display: none` on the checkbox would probably be sufficient.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Make a div fill the height of the remaining screen space (score [891472](https://stackoverflow.com/q/90178) in 2019)

#### Question
I am working on a web application where I want the content to fill the height of the entire screen.  

The page has a header, which contains a logo, and account information. This could be an arbitrary height. I want the content div to fill the rest of the page to the bottom.  

I have a header `div` and a content `div`. At the moment I am using a table for the layout like so:  

CSS and HTML  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
#page {
    height: 100%; width: 100%
}

#tdcontent {
    height: 100%;
}

#content {
    overflow: auto; /* or overflow: hidden; */
}```
```html
<table id="page">
    <tr>
        <td id="tdheader">
            <div id="header">...</div>
        </td>
    </tr>
    <tr>
        <td id="tdcontent">
            <div id="content">...</div>
        </td>
    </tr>
</table>```
</div>
</div>


The entire height of the page is filled, and no scrolling is required.  

For anything inside the content div, setting `top: 0;` will put it right underneath the header. Sometimes the content will be a real table, with its height set to 100%. Putting `header` inside `content` will not allow this to work.  

Is there a way to achieve the same effect without using the `table`?  

<strong>Update:</strong>  

Elements inside the content `div` will have heights set to percentages as well. So something at 100% inside the `div` will fill it to the bottom. As will two elements at 50%.  

<strong>Update 2:</strong>  

For instance, if the header takes up 20% of the screen's height, a table specified at 50% inside `#content` would take up 40% of the screen space. So far, wrapping the entire thing in a table is the only thing that works.  

#### Answer accepted (score 938)
<h5>2015 update: the flexbox approach</h3>

There are two other answers briefly mentioning <a href="https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Flexible_boxes">flexbox</a>; however, that was more than two years ago, and they don't provide any examples. The specification for flexbox has definitely settled now.  

<blockquote>
  Note: Though CSS Flexible Boxes Layout specification is at the Candidate Recommendation stage, not all browsers have implemented it. WebKit implementation must be prefixed with -webkit-; Internet Explorer implements an old version of the spec, prefixed with -ms-; Opera 12.10 implements the latest version of the spec, unprefixed. See the compatibility table on each property for an up-to-date compatibility status.  
  
  (taken from <a href="https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Flexible_boxes">https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Flexible_boxes</a>)  
</blockquote>

All major browsers and IE11+ support Flexbox. For IE 10 or older, you can use the FlexieJS shim.  

<p>To check current support you can also see here:
<a href="http://caniuse.com/#feat=flexbox">http://caniuse.com/#feat=flexbox</a></p>

<h5>Working example</h3>

With flexbox you can easily switch between any of your rows or columns either having fixed dimensions, content-sized dimensions or remaining-space dimensions. In my example I have set the header to snap to its content (as per the OPs question), I've added a footer to show how to add a fixed-height region and then set the content area to fill up the remaining space.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
html,
body {
  height: 100%;
  margin: 0
}

.box {
  display: flex;
  flex-flow: column;
  height: 100%;
}

.box .row {
  border: 1px dotted grey;
}

.box .row.header {
  flex: 0 1 auto;
  /* The above is shorthand for:
  flex-grow: 0,
  flex-shrink: 1,
  flex-basis: auto
  */
}

.box .row.content {
  flex: 1 1 auto;
}

.box .row.footer {
  flex: 0 1 40px;
}```
```html
<!-- Obviously, you could use HTML5 tags like `header`, `footer` and `section` -->

<div class="box">
  <div class="row header">
    <p><b>header</b>
      <br />
      <br />(sized to content)</p>
  </div>
  <div class="row content">
    <p>
      <b>content</b>
      (fills remaining space)
    </p>
  </div>
  <div class="row footer">
    <p><b>footer</b> (fixed height)</p>
  </div>
</div>```
</div>
</div>


In the CSS above, the <a href="https://developer.mozilla.org/en/CSS/flex">flex</a> property shorthands the <a href="https://developer.mozilla.org/en/CSS/flex-grow">flex-grow</a>, <a href="https://developer.mozilla.org/en/CSS/flex-shrink">flex-shrink</a>, and <a href="https://developer.mozilla.org/en/CSS/flex-basis">flex-basis</a> properties to establish the flexibility of the flex items. Mozilla has a <a href="https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Flexible_boxes">good introduction to the flexible boxes model</a>.  

#### Answer 2 (score 221)
There really isn't a sound, cross-browser way to do this in CSS.  Assuming your layout has complexities, you need to use JavaScript to set the element's height.  The essence of what you need to do is:  

```html
Element Height = Viewport height - element.offset.top - desired bottom margin
```

Once you can get this value and set the element's height, you need to attach event handlers to both the window onload and onresize so that you can fire your resize function.  

Also, assuming your content could be larger than the viewport, you will need to set overflow-y to scroll.  

#### Answer 3 (score 162)
The original post is more than 3 years ago. I guess many people who come to this post like me are looking for an app-like layout solution, say a somehow fixed header, footer, and full height content taking up the rest screen. If so, this post may help, it works on IE7+, etc.  

<a href="http://blog.stevensanderson.com/2011/10/05/full-height-app-layouts-a-css-trick-to-make-it-easier/" rel="noreferrer">http://blog.stevensanderson.com/2011/10/05/full-height-app-layouts-a-css-trick-to-make-it-easier/</a>  

And here are some snippets from that post:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```html
@media screen { 
  
  /* start of screen rules. */ 
  
  /* Generic pane rules */
  body { margin: 0 }
  .row, .col { overflow: hidden; position: absolute; }
  .row { left: 0; right: 0; }
  .col { top: 0; bottom: 0; }
  .scroll-x { overflow-x: auto; }
  .scroll-y { overflow-y: auto; }

  .header.row { height: 75px; top: 0; }
  .body.row { top: 75px; bottom: 50px; }
  .footer.row { height: 50px; bottom: 0; }
  
  /* end of screen rules. */ 
}```
```html
<div class="header row" style="background:yellow;">
    <h2>My header</h2>
</div> 
<div class="body row scroll-y" style="background:lightblue;">
    <p>The body</p>
</div> 
<div class="footer row" style="background:#e9e9e9;">
    My footer
</div>```
</div>
</div>


</section>

