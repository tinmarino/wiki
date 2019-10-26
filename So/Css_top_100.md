---
title: Css <- StackOverflow top 100
category: css
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How to horizontally center a <div>? (score [3829513](https://stackoverflow.com/q/114543) in 2018)

#### Question
How can I horizontally center a `&lt;div&gt;` within another `&lt;div&gt;` using CSS?   

<pre class="lang-html prettyprint-override"><code>&lt;div id="outer"&gt;  
  &lt;div id="inner"&gt;Foo foo&lt;/div&gt;
&lt;/div&gt;
</code></pre>



#### Answer accepted (score 4515)
You can apply this CSS to the inner `&lt;div&gt;`:  

```css
#inner {
  width: 50%;
  margin: 0 auto;
}
```

Of course, you don't have to set the `width` to `50%`. Any width less than the containing `&lt;div&gt;` will work. The `margin: 0 auto` is what does the actual centering.  

If you are targeting IE8+, it might be better to have this instead:  

```css
#inner {
  display: table;
  margin: 0 auto;
}
```

It will make the inner element center horizontally and it works without setting a specific `width`.  

Working example here:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
#inner {
  display: table;
  margin: 0 auto;
  border: 1px solid black;
}

#outer {
  border: 1px solid red;
  width:100%
}
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="outer"&gt;
  &lt;div id="inner"&gt;Foo foo&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 1202)
If you don't want to set a fixed width on the inner `div` you could do something like this:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
#outer {
  width: 100%;
  text-align: center;
}

#inner {
  display: inline-block;
}
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="outer"&gt;  
    &lt;div id="inner"&gt;Foo foo&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


That makes the inner `div` into an inline element that can be centered with `text-align`.  

#### Answer 3 (score 362)
The best approaches are with <a href="http://www.w3schools.com/css/css3_intro.asp" rel="noreferrer">CSS 3</a>.  

<h5>Box model:</h3>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
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
}
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="outer"&gt;
  &lt;div id="inner"&gt;Foo foo&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


According to your usability you may also use the `box-orient, box-flex, box-direction` properties.  

<strong>Flex</strong>:  

```css
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

### 2: How do I vertically center text with CSS? (score [3100733](https://stackoverflow.com/q/8865458) in 2019)

#### Question
I have a div element which contains text, and I want to align the contents of this div vertically center.  

Here is my div style:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
#box {
  height: 170px;
  width: 270px;
  background: #000;
  font-size: 48px;
  color: #FFF;
  text-align: center;
}
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="box"&gt;
  Lorem ipsum dolor sit
&lt;/div&gt;</code></pre>
</div>
</div>


What is the best way to do this?  

#### Answer accepted (score 2753)
You can try this basic approach:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
div {
  height: 90px;
  line-height: 90px;
  text-align: center;
  border: 2px dashed #f69c55;
}
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div&gt;
  Hello World!
&lt;/div&gt;</code></pre>
</div>
</div>


It only works for a single line of text though, because we set the line's height to the same height as the containing box element.  

<hr>

<h5>A more versatile approach</h2>

This is another way to align text vertically. This solution will work for a single line and multiple lines of text, but it still requires a fixed height container:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
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
}
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div&gt;
  &lt;span&gt;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Haec et tu ita posuisti, et verba vestra sunt. Non enim iam stirpis bonum quaeret, sed animalis. &lt;/span&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


The CSS just sizes the `&lt;div&gt;`, vertically center aligns the `&lt;span&gt;` by setting the `&lt;div&gt;`'s line-height equal to its height, and makes the `&lt;span&gt;` an inline-block with `vertical-align: middle`. Then it sets the line-height back to normal for the `&lt;span&gt;`, so its contents will flow naturally inside the block.  

<hr>

<h5>Simulating table display</h2>

And here is another option, which may not work on older <a href="http://caniuse.com/css-table" rel="noreferrer">browsers that don't support `display: table` and `display: table-cell`</a> (basically just Internet Explorer 7). Using CSS we simulate table behavior (since tables support vertical alignment), and the HTML is the same as the second example:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
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
}
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div&gt;
  &lt;span&gt;Lorem ipsum dolor sit amet, consectetur adipiscing elit.&lt;/span&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


<hr>

<h5>Using absolute positioning</h2>

This technique uses an absolutely positioned element setting top, bottom, left and right to 0. It is described in more detail in an article in Smashing Magazine, <em><a href="http://coding.smashingmagazine.com/2013/08/09/absolute-horizontal-vertical-centering-css/" rel="noreferrer">Absolute Horizontal And Vertical Centering In CSS</a></em>.  

#### Answer 2 (score 1196)
Another way (not mentioned here yet) is with <a href="http://www.w3.org/TR/css3-flexbox/" rel="noreferrer">Flexbox</a>.  

Just add the following code to the <strong>container</strong> element:  

```css
display: flex;
justify-content: center; /* align horizontal */
align-items: center; /* align vertical */
```

<h5><a href="http://jsfiddle.net/danield770/4rrL4/594/" rel="noreferrer">Flexbox demo 1</a></h2>

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
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
}
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="box"&gt;
  Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
&lt;/div&gt;</code></pre>
</div>
</div>


Alternatively, instead of aligning the content via the <em>container</em>, flexbox can also center the a <strong>flex item</strong> with an <a href="https://www.w3.org/TR/css-flexbox-1/#auto-margins" rel="noreferrer">auto margin</a> <em>when there is only one flex-item in the flex container</em> (like the example given in the question above).  

So to center the flex item both horizontally and vertically just set it with `margin:auto`  

<h5><a href="http://jsfiddle.net/danield770/4rrL4/815/" rel="noreferrer">Flexbox Demo 2</a></h2>

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
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
}
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="box"&gt;
  &lt;span&gt;margin:auto on a flex item centers it both horizontally and vertically&lt;/span&gt; 
&lt;/div&gt;</code></pre>
</div>
</div>


<strong>NB:</strong> All the above applies to centering items while laying them out in <strong>horizontal rows</strong>. This is also the default behavior, because by default the value for `flex-direction` is `row`. If, however flex-items need to be laid out in <strong>vertical columns</strong>, then `flex-direction: column` should be set on the container to set the main-axis as column and additionally the `justify-content` and `align-items` properties now work <em>the other way around</em> with `justify-content: center` centering vertically and  `align-items: center` centering horizontally)  

<h5><a href="http://jsfiddle.net/danield770/4rrL4/888/" rel="noreferrer">`flex-direction: column` demo</a></h2>

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
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
  }
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="box"&gt;
  &lt;p&gt;
    When flex-direction is column...
  &lt;/p&gt;
  &lt;p&gt;
    "justify-content: center" - vertically aligns
  &lt;/p&gt;
  &lt;p&gt;
    "align-items: center" - horizontally aligns
  &lt;/p&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


A good place to start with Flexbox to see some of its features and get syntax for maximum browser support is <a href="http://the-echoplex.net/flexyboxes/" rel="noreferrer">flexyboxes</a>   

Also, browser support nowadays is very good: <a href="http://caniuse.com/#feat=flexbox" rel="noreferrer">caniuse</a>  

For cross-browser compatibility for `display: flex` and `align-items`, you can use the following:  

```css
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

```css
display: table-cell;
vertical-align: middle;
```

That means your CSS finally looks like:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
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
}
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="box"&gt;
  Some text
&lt;/div&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How to align a <div> to the middle (horizontally/width) of the page (score [2419195](https://stackoverflow.com/q/953918) in 2019)

#### Question
I have a `div` tag with `width` set to <strong>800 pixels</strong>. When the browser width is greater than <strong>800 pixels</strong>, it shouldn't stretch the `div`, but it should bring it to the middle of the page.  

#### Answer accepted (score 1059)
```css
&lt;body&gt;
    &lt;div style="width:800px; margin:0 auto;"&gt;
        centered content
    &lt;/div&gt;
&lt;/body&gt;
```

#### Answer 2 (score 312)
`position: absolute` and then `top:50%` and `left:50%` places the top edge at the vertical center of the screen, and the left edge at the horizontal center, then by adding `margin-top` to the negative of the height of the div, i.e., -100 shifts it above by 100 and similarly for `margin-left`. This gets the `div` exactly in the center of the page.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
#outPopUp {
  position: absolute;
  width: 300px;
  height: 200px;
  z-index: 15;
  top: 50%;
  left: 50%;
  margin: -100px 0 0 -150px;
  background: red;
}
```
<pre class="snippet-code-html lang-html prettyprint-override">`&lt;div id="outPopUp"&gt;&lt;/div&gt;`</pre>
</div>
</div>


#### Answer 3 (score 82)
Modern <a href="http://caniuse.com/#search=flexbox" rel="noreferrer"><strong>Flexbox</strong></a> solution is the way to go in/from 2015. <a href="https://css-tricks.com/almanac/properties/j/justify-content/" rel="noreferrer">`justify-content: center`</a> is used for the parent element to align the content to the center of it.  

<strong>HTML</strong>  

```css
&lt;div class="container"&gt;
  &lt;div class="center"&gt;Center&lt;/div&gt;
&lt;/div&gt;
```

<strong>CSS</strong>  

```css
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
```css
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
}
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="container"&gt;
  &lt;div class="center"&gt;Centered div with left aligned text.&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How do I auto-resize an image to fit a 'div' container? (score [2256223](https://stackoverflow.com/q/3029422) in 2019)

#### Question
How do you auto-resize a large image so that it will fit into a smaller width div container whilst maintaining its width:height ratio?  

<hr>

Example: stackoverflow.com - when an image is inserted onto the editor panel and the image is too large to fit onto the page, the image is automatically resized.  

#### Answer accepted (score 1742)
Do not apply an explicit width or height to the image tag. Instead, give it:  

```css
max-width:100%;
max-height:100%;
```

Also, `height: auto;` if you want to specify a width only.  

Example: <a href="http://jsfiddle.net/xwrvxser/1/" rel="noreferrer">http://jsfiddle.net/xwrvxser/1/</a>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
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
}
```
<pre class="snippet-code-html lang-html prettyprint-override"><code>Portrait Div
&lt;div class="portrait"&gt;
    &lt;img src="http://i.stack.imgur.com/xkF9Q.jpg"&gt;
&lt;/div&gt;

Landscape Div
&lt;div class="landscape"&gt;
    &lt;img src="http://i.stack.imgur.com/xkF9Q.jpg"&gt;
&lt;/div&gt;

Square Div
&lt;div class="square"&gt;
    &lt;img src="http://i.stack.imgur.com/xkF9Q.jpg"&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 361)
<em><a href="https://developer.mozilla.org/en-US/docs/Web/CSS/object-fit" rel="noreferrer">object-fit</a></em>  

It turns out there's another way to do this.  

```css
&lt;img style='height: 100%; width: 100%; object-fit: contain'/&gt;
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

```css
height
width
viewbox
```

Most vector drawing programs out there will set these properties when exporting an SVG file, so you will have to manually edit your file every time you export, or write a script to do it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Set cellpadding and cellspacing in CSS? (score [2226855](https://stackoverflow.com/q/339923) in 2018)
