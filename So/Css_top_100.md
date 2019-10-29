---
title: Css <- StackOverflow top 100
category: css
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How to horizontally center a \<div>? (score [3829513](https://stackoverflow.com/q/114543) in 2018)

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

### 3: How to align a \<div> to the middle (horizontally/width) of the page (score [2419195](https://stackoverflow.com/q/953918) in 2019)

#### Question
I have a `div` tag with `width` set to <strong>800 pixels</strong>. When the browser width is greater than <strong>800 pixels</strong>, it shouldn't stretch the `div`, but it should bring it to the middle of the page.  

#### Answer accepted (score 1059)
```css
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
<div class="container">
  <div class="center">Center</div>
</div>
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

```css
height
width
viewbox
```

Most vector drawing programs out there will set these properties when exporting an SVG file, so you will have to manually edit your file every time you export, or write a script to do it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Set cellpadding and cellspacing in CSS? (score [2226855](https://stackoverflow.com/q/339923) in 2018)

#### Question
In an HTML table, the `cellpadding` and `cellspacing` can be set like this:  

<pre class="lang-html prettyprint-override"><code>&lt;table cellspacing="1" cellpadding="1"&gt;
</code></pre>

How can the same be accomplished using CSS?  

#### Answer accepted (score 3461)
<strong>Basics</strong>  

For controlling "cellpadding" in CSS, you can simply use `padding` on table cells. E.g. for 10px of "cellpadding":  

```css
td { 
    padding: 10px;
}
```

For "cellspacing", you can apply the `border-spacing` CSS property to your table. E.g. for 10px of "cellspacing":  

```css
table { 
    border-spacing: 10px;
    border-collapse: separate;
}
```

This property will even allow separate horizontal and vertical spacing, something you couldn't do with old-school "cellspacing".  

<strong>Issues in IE &lt;= 7</strong>  

This will work in almost all popular browsers except for Internet&nbsp;Explorer up through Internet&nbsp;Explorer&nbsp;7, where you're almost out of luck. I say "almost" because these browsers still support the `border-collapse` property, which merges the borders of adjoining table cells. If you're trying to eliminate cellspacing (that is, `cellspacing="0"`) then `border-collapse:collapse` should have the same effect: no space between table cells. This support is buggy, though, as it does not override an existing `cellspacing` HTML attribute on the table element.  

In short: for non-Internet&nbsp;Explorer 5-7 browsers, `border-spacing` handles you. For Internet&nbsp;Explorer, if your situation is just right (you want 0 cellspacing and your table doesn't have it defined already), you can use `border-collapse:collapse`.  

```css
table { 
    border-spacing: 0;
    border-collapse: collapse;
}
```

Note: For a great overview of CSS properties that one can apply to tables and for which browsers, see this <a href="http://www.quirksmode.org/css/tables.html" rel="noreferrer">fantastic Quirksmode page</a>.  

#### Answer 2 (score 919)
<h5>Default</h2>

The default behavior of the browser is equivalent to:  

```css
table {border-collapse: collapse;}
td    {padding: 0px;}
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://i.stack.imgur.com/cukle.png" alt="Enter image description here">  

<h5>Cellpadding</h2>

Sets the amount of space between the contents of the cell and the cell wall  

```css
table {border-collapse: collapse;}
td    {padding: 6px;}
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://i.stack.imgur.com/c0ght.png" alt="Enter image description here">  

<h5>Cellspacing</h2>

Controls the space between table cells  

```css
table {border-spacing: 2px;}
td    {padding: 0px;}
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://i.stack.imgur.com/WNuBP.png" alt="Enter image description here">  

<h5>Both</h2>

```css
table {border-spacing: 2px;}
td    {padding: 6px;}
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://i.stack.imgur.com/eyZQl.png" alt="Enter image description here">  

<h5>Both (special)</h2>

```css
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
```css
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

### 6: Center a column using Twitter Bootstrap 3 (score [2068068](https://stackoverflow.com/q/18153234) in 2019)

#### Question
How do I center a div of one column size within the container (12 columns) in <a href="https://en.wikipedia.org/wiki/Bootstrap_%28front-end_framework%29" rel="noreferrer">Twitter Bootstrap&nbsp;3</a>?  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.centered {
  background-color: red;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;body class="container"&gt;
  &lt;div class="col-lg-1 col-offset-6 centered"&gt;
    &lt;img data-src="holder.js/100x100" alt="" /&gt;
  &lt;/div&gt;
&lt;/body&gt;</code></pre>
</div>
</div>


I want a `div`, with a class `.centered` to be centered within the container. I may use a row if there are multiple `div`s, but for now I just want a `div` with the size of one column centered within the container (12 columns).  

I am also not sure the above approach is good enough as the intention is not to offset the `div` by half. I do not need free spaces outside the `div` and the contents of the `div` shrink in proportion. I want to <strong>empty space outside the div to be evenly distributed</strong> (shrink till the container width is equal to one column).  

#### Answer accepted (score 1918)
There are two approaches to centering a column `&lt;div&gt;` in Bootstrap 3:  

<h5><strong>Approach 1 (offsets):</strong></h2>

The first approach uses Bootstrap's own offset classes so it requires no change in markup and no extra CSS. The key is to <strong>set an offset equal to half of the remaining size of the row</strong>. So for example, a column of size 2 would be centered by adding an offset of 5, that's `(12-2)/2`.  

In markup this would look like:  

```css
<div class="row">
    <div class="col-md-2 col-md-offset-5"></div>
</div>
```

Now, there's an obvious drawback for this method. <strong>It only works for even column sizes</strong>, so only `.col-X-2`, `.col-X-4`, `col-X-6`, `col-X-8`, and `col-X-10` are supported.  

<hr>

<h5><strong>Approach 2 (the old `margin:auto`)</strong></h2>

You can <strong>center any column size</strong> by using the proven `margin: 0 auto;` technique. You just need to take care of the floating that is added by Bootstrap's grid system. I recommend defining a custom CSS class like the following:  

```css
.col-centered{
    float: none;
    margin: 0 auto;
}
```

Now you can add it to any column size at any screen size, and it will work seamlessly with Bootstrap's responsive layout:  

```css
<div class="row">
    <div class="col-lg-1 col-centered"></div>
</div>
```

<strong>Note:</strong> With both techniques you could skip the `.row` element and have the column centered inside a `.container`, but you would notice a minimal difference in the actual column size because of the padding in the container class.  

<hr>

<strong>Update:</strong>  

Since v3.0.1 Bootstrap has a built-in class named `center-block` that uses `margin: 0 auto`, but is missing `float:none`, you can add that to your CSS to make it work with the grid system.  

#### Answer 2 (score 289)
The preferred method of <strong>centering columns</strong> is to use "offsets" (ie: `col-md-offset-3`)  

<a href="http://codeply.com/go/Sv6Z9eR9kk" rel="noreferrer">Bootstrap 3.x centering examples</a>  

For <strong>centering elements</strong>, there is a `center-block` <a href="http://getbootstrap.com/css/#helper-classes-center" rel="noreferrer">helper class</a>.  

You can also use `text-center` to <strong>center text</strong> (and inline elements).  

<strong>Demo</strong>: <a href="http://bootply.com/91632" rel="noreferrer">http://bootply.com/91632</a>  

<strong><em>EDIT</em></strong> - As mentioned in the comments, `center-block` works on column contents and `display:block` elements, but won't work on the column itself (`col-*` divs) because Bootstrap uses `float`.   

<hr>

<h5>Update 2018</h2>

Now with <strong>Bootstrap 4</strong>, the <strong>centering</strong> methods have changed..  

<ul>
<li>`text-center` is still used for `display:inline` elements</li>
<li>`mx-auto` replaces `center-block` to center `display:block` elements</li>
<li>`offset-*` <em>or</em> `mx-auto` can be used to center grid columns</li>
</ul>

`mx-auto` (auto x-axis margins) will center `display:block` or `display:flex` elements that have a <em>defined width</em>, (`%`, `vw`, `px`, etc..). <strong>Flexbox is used by default</strong> on grid columns, so there are also various flexbox centering methods.  

<a href="http://www.codeply.com/go/SOSvvKpLOc" rel="noreferrer"><strong>Demo</strong> Bootstrap 4 Horizontal Centering</a>  

<strong>For vertical centering in BS4 see</strong> <a href="https://stackoverflow.com/a/41464397/171456">https://stackoverflow.com/a/41464397/171456</a>  

#### Answer 3 (score 93)
Now Bootstrap 3.1.1 is working with `.center-block`, and this helper class works with the column system.  

Bootstrap 3 <a href="http://getbootstrap.com/css/#helper-classes-center">Helper Class Center</a>.  

Please check <a href="http://jsfiddle.net/e7eSP/1/show/"><strong>this jsfiddle DEMO</strong></a>:  

```css
<div class="container">
    <div class="row">
        <div class="center-block">row center-block</div>
    </div>
    <div class="row">
        <div class="col-md-6 brd">
            <div class="center-block">1 center-block</div>
        </div>
        <div class="col-md-6 brd">
            <div class="center-block">2 center-block</div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-xs-2 col-center-block">row col-xs-2 col-center-block</div>
</div>
```

<img src="https://i.stack.imgur.com/bHg4V.png" alt="Helper classes center">  

Row column center using `col-center-block` helper class.  

```css
.col-center-block {
    float: none;
    display: block;
    margin: 0 auto;
    /* margin-left: auto; margin-right: auto; */
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: I need an unordered list without any bullets (score [1985502](https://stackoverflow.com/q/1027354) in 2019)

#### Question
I have created an unordered list. I feel the bullets in the unordered list are bothersome, so I want to remove them.   

Is it possible to have a list without bullets?  

#### Answer accepted (score 3515)
You can remove bullets by setting the <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/list-style-type" rel="noreferrer">`list-style-type`</a> to `none` on the CSS for the parent element (typically a `&lt;ul&gt;`), for example:  

```css
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

```css
<ul class="unstyled">
   <li>...</li>
</ul>
```

<a href="http://twitter.github.io/bootstrap/base-css.html#typography" rel="noreferrer">http://twitter.github.io/bootstrap/base-css.html#typography</a>  

<h5>Bootstrap 3 and 4:</h3>

```css
<ul class="list-unstyled">
   <li>...</li>
</ul>
```

Bootstrap 3: <a href="http://getbootstrap.com/css/#type-lists" rel="noreferrer">http://getbootstrap.com/css/#type-lists</a>  

Bootstrap 4: <a href="https://getbootstrap.com/docs/4.3/content/typography/#unstyled" rel="noreferrer">https://getbootstrap.com/docs/4.3/content/typography/#unstyled</a>  

#### Answer 3 (score 204)
You need to use `list-style: none;`  

```css
<ul style="list-style: none;">
    <li> ...</li>
</ul>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: Make the cursor a hand when a user hovers over a list item (score [1857281](https://stackoverflow.com/q/3087975) in 2018)

#### Question
I've got a list, and I have a click handler for its items:  

```css
<ul>
  <li>foo</li>
  <li>goo</li>
</ul>
```

How can I change the mouse pointer into a hand pointer (like when hovering over a button)? Right now the pointer turns into a text selection pointer when I hover over the list items.  

#### Answer accepted (score 3089)
In light of the passage of time, as people have mentioned, you can now safely just use:  

```css
li { cursor: pointer; }
```

#### Answer 2 (score 289)
Use for `li`:  

```css
li:hover {
    cursor: pointer;
}
```

See more cursor properties with examples after running snippet option:  

<a href="https://i.stack.imgur.com/gJYJv.gif" rel="noreferrer"><img src="https://i.stack.imgur.com/gJYJv.gif" alt="An animation showing a cursor hovering over a div of each class"></a>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.auto          { cursor: auto; }
.default       { cursor: default; }
.none          { cursor: none; }
.context-menu  { cursor: context-menu; }
.help          { cursor: help; }
.pointer       { cursor: pointer; }
.progress      { cursor: progress; }
.wait          { cursor: wait; }
.cell          { cursor: cell; }
.crosshair     { cursor: crosshair; }
.text          { cursor: text; }
.vertical-text { cursor: vertical-text; }
.alias         { cursor: alias; }
.copy          { cursor: copy; }
.move          { cursor: move; }
.no-drop       { cursor: no-drop; }
.not-allowed   { cursor: not-allowed; }
.all-scroll    { cursor: all-scroll; }
.col-resize    { cursor: col-resize; }
.row-resize    { cursor: row-resize; }
.n-resize      { cursor: n-resize; }
.e-resize      { cursor: e-resize; }
.s-resize      { cursor: s-resize; }
.w-resize      { cursor: w-resize; }
.ns-resize     { cursor: ns-resize; }
.ew-resize     { cursor: ew-resize; }
.ne-resize     { cursor: ne-resize; }
.nw-resize     { cursor: nw-resize; }
.se-resize     { cursor: se-resize; }
.sw-resize     { cursor: sw-resize; }
.nesw-resize   { cursor: nesw-resize; }
.nwse-resize   { cursor: nwse-resize; }

.cursors > div {
    float: left;
    box-sizing: border-box;
    background: #f2f2f2;
    border:1px solid #ccc;
    width: 20%;
    padding: 10px 2px;
    text-align: center;
    white-space: nowrap;
    &:nth-child(even) {
       background: #eee;
    }
    &:hover {
       opacity: 0.25
    }
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;h1&gt;Example of cursor&lt;/h1&gt;

&lt;div class="cursors"&gt;
    &lt;div class="auto"&gt;auto&lt;/div&gt;
    &lt;div class="default"&gt;default&lt;/div&gt;
    &lt;div class="none"&gt;none&lt;/div&gt;
    &lt;div class="context-menu"&gt;context-menu&lt;/div&gt;
    &lt;div class="help"&gt;help&lt;/div&gt;
    &lt;div class="pointer"&gt;pointer&lt;/div&gt;
    &lt;div class="progress"&gt;progress&lt;/div&gt;
    &lt;div class="wait"&gt;wait&lt;/div&gt;
    &lt;div class="cell"&gt;cell&lt;/div&gt;
    &lt;div class="crosshair"&gt;crosshair&lt;/div&gt;
    &lt;div class="text"&gt;text&lt;/div&gt;
    &lt;div class="vertical-text"&gt;vertical-text&lt;/div&gt;
    &lt;div class="alias"&gt;alias&lt;/div&gt;
    &lt;div class="copy"&gt;copy&lt;/div&gt;
    &lt;div class="move"&gt;move&lt;/div&gt;
    &lt;div class="no-drop"&gt;no-drop&lt;/div&gt;
    &lt;div class="not-allowed"&gt;not-allowed&lt;/div&gt;
    &lt;div class="all-scroll"&gt;all-scroll&lt;/div&gt;
    &lt;div class="col-resize"&gt;col-resize&lt;/div&gt;
    &lt;div class="row-resize"&gt;row-resize&lt;/div&gt;
    &lt;div class="n-resize"&gt;n-resize&lt;/div&gt;
    &lt;div class="s-resize"&gt;s-resize&lt;/div&gt;
    &lt;div class="e-resize"&gt;e-resize&lt;/div&gt;
    &lt;div class="w-resize"&gt;w-resize&lt;/div&gt;
    &lt;div class="ns-resize"&gt;ns-resize&lt;/div&gt;
    &lt;div class="ew-resize"&gt;ew-resize&lt;/div&gt;
    &lt;div class="ne-resize"&gt;ne-resize&lt;/div&gt;
    &lt;div class="nw-resize"&gt;nw-resize&lt;/div&gt;
    &lt;div class="se-resize"&gt;se-resize&lt;/div&gt;
    &lt;div class="sw-resize"&gt;sw-resize&lt;/div&gt;
    &lt;div class="nesw-resize"&gt;nesw-resize&lt;/div&gt;
    &lt;div class="nwse-resize"&gt;nwse-resize&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 3 (score 151)
You do not require jQuery for this, simply use the following CSS content:  

```css
li {cursor: pointer}
```

And voilà! Handy.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: CSS Background Opacity (score [1857136](https://stackoverflow.com/q/10422949) in 2019)

#### Question
I am using something similar to the following code:   

```css
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
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div style="background-color:rgba(0, 0, 0, 0.5);"&gt;
   &lt;div&gt;
      Text added.
   &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 167)
You can use CSS 3 `:before` to have a semi-transparent background and you can do this with just one container. Use something like this  

```css
<article>
  Text.
</article>
```

Then apply some CSS  

```css
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

```css
#div{background-color:rgba(255,0,0,0.5);}
```
</li>
<li><p>Use a transparent PNG image according to your choice as background.</p></li>
<li><p>Use the following CSS code snippet to create a cross-browser alpha-transparent background. Here is an example with `#000000` @ 0.4% opacity</p>

```css
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
```
</li>
</ol>

For more details regarding this technique, see <a href="http://hammerspace.co.uk/2011/10/cross-browser-alpha-transparent-background-css" rel="nofollow noreferrer">this</a>, which has an online CSS generator.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: How to align content of a div to the bottom (score [1847026](https://stackoverflow.com/q/585945) in 2019)

#### Question
Say I have the following CSS and HTML code:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
#header {
  height: 150px;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="header"&gt;
  &lt;h1&gt;Header title&lt;/h1&gt;
  Header content (one or multiple lines)
&lt;/div&gt;</code></pre>
</div>
</div>


The header section is fixed height, but the header content may change.  

I would like the content of the header to be vertically aligned to the bottom of the header section, so the last line of text "sticks" to the bottom of the header section.  

So if there is only one line of text, it would be like:  

```css
-----------------------------
| Header title
|
|
|
| header content (resulting in one line)
-----------------------------
```

And if there were three lines:  

```css
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="header"&gt;
  &lt;h1&gt;Title&lt;/h1&gt;
  &lt;div id="header-content"&gt;Some content&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


But you may run into issues with that.  When I tried it I had problems with dropdown menus appearing below the content.  It's just not pretty.  

Honestly, for vertical centering issues and, well, any vertical alignment issues with the items aren't fixed height, it's easier just to use tables.  

Example: <a href="https://stackoverflow.com/questions/522928/can-you-do-this-html-layout-without-using-tables">Can you do this HTML layout without using tables?</a>  

#### Answer 2 (score 149)
Use CSS positioning:  

```css
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

<pre class="lang-html prettyprint-override"><code>&lt;span id="header-content"&gt;some header content&lt;/span&gt;

&lt;div style="height:100%; position:relative;"&gt;
    &lt;div style="height:10%; position:absolute; bottom:0px;"&gt;bottom&lt;/div&gt;
&lt;/div&gt;
</code></pre>

#### Answer 3 (score 111)
I use these properties and it works!  

```css
#header {
  display: table-cell;
  vertical-align: bottom;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: How to make a div 100% height of the browser window (score [1834779](https://stackoverflow.com/q/1575141) in 2019)

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

<pre class="lang-html prettyprint-override"><code>&lt;div&gt;&lt;/div&gt;
</code></pre>

<h5>CSS</h3>

```css
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

<pre class="lang-html prettyprint-override"><code>&lt;body style="height:100%"&gt;
    &lt;div style="height:200px"&gt;
        &lt;p style="height:100%; display:block;"&gt;Hello, world!&lt;/p&gt;
    &lt;/div&gt;
&lt;/body&gt;
</code></pre>

The `p` tag here is set to 100% height, but because its containing `div` has 200 pixels height, 100% of 200 pixels becomes 200 pixels, <em>not</em> 100% of the `body` height. Using `100vh` instead means that the `p` tag will be 100% height of the `body` regardless of the `div` height. Take a look at this <a href="http://jsfiddle.net/JamesD/hr8sL/2/" rel="noreferrer">accompanying JSFiddle</a> to easily see the difference!  

#### Answer 3 (score 553)
If you want to set the height of a `&lt;div&gt;` or any element, you should set the height of `&lt;body&gt;` and `&lt;html&gt;` to 100% too. Then you can set the height of element with 100% :)  

Here is an example:  

```css
body, html {
  height: 100%;
}

#right {
  height: 100%;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: Is there a CSS parent selector? (score [1806412](https://stackoverflow.com/q/1014861) in 2019)

#### Question
How do I select the `&lt;li&gt;` element that is a direct parent of the anchor element?  

As an example, my CSS would be something like this:  

```css
li < a.active {
    property: value;
}
```

Obviously there are ways of doing this with JavaScript, but I'm hoping that there is some sort of workaround that exists native to CSS Level 2.  

The menu that I am trying to style is being spewed out by a CMS, so I can't move the active element to the `&lt;li&gt;` element... (unless I theme the menu creation module which I'd rather not do).  

Any ideas?  

#### Answer accepted (score 2360)
There is currently no way to select the parent of an element in CSS.  

If there was a way to do it, it would be in either of the current CSS selectors specs:  

<ul>
<li><a href="https://www.w3.org/TR/css3-selectors/#selectors" rel="noreferrer">Selectors Level 3 Spec</a></li>
<li><a href="https://www.w3.org/TR/CSS2/selector.html#pattern-matching" rel="noreferrer">CSS 2.1 Selectors Spec</a></li>
</ul>

In the meantime, you'll have to resort to JavaScript if you need to select a parent element.  

<hr>

The <a href="https://dev.w3.org/csswg/selectors4/#relational" rel="noreferrer">Selectors Level 4 Working Draft</a> includes a `:has()` pseudo-class that works the same as the <a href="https://api.jquery.com/has-selector/" rel="noreferrer">jQuery implementation</a>. As of 2019, <strong><a href="https://caniuse.com/#feat=css-has" rel="noreferrer">this is still not supported by any browser</a></strong>.   

Using `:has()` the original question could be solved with this:  

```css
li:has(> a.active) { /* styles to apply to the li tag */ }
```

#### Answer 2 (score 146)
I don’t think you can select the parent in CSS only.  

But as you already seem to have an `.active` class, it would be easier to move that class to the `li` (instead of the `a`). That way you can access both the `li` and the `a` via CSS only.  

#### Answer 3 (score 118)
You can use <a href="https://github.com/Idered/cssParentSelector" rel="nofollow noreferrer">this script</a>:  

```css
*! > input[type=text] { background: #000; }
```

This will select any parent of a text input. But wait, there's still much more. If you want, you can select a specified parent:  

```css
.input-wrap! > input[type=text] { background: #000; }
```

Or select it when it's active:  

```css
.input-wrap! > input[type=text]:focus { background: #000; }
```

Check out this HTML:  

<pre class="lang-html prettyprint-override"><code>&lt;div class="input-wrap"&gt;
    &lt;input type="text" class="Name"/&gt;
    &lt;span class="help hide"&gt;Your name sir&lt;/span&gt;
&lt;/div&gt;
</code></pre>

You can select that `span.help` when the `input` is active and show it:  

```css
.input-wrap! .help > input[type=text]:focus { display: block; }
```

There are many more capabilities; just check out the documentation of the plugin.  

BTW, it works in Internet&nbsp;Explorer.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How to disable text selection highlighting (score [1755509](https://stackoverflow.com/q/826782) in 2019)

#### Question
For anchors that act like buttons (for example, <em>Questions</em>, <em>Tags</em>, <em>Users</em>, etc. at the top of the Stack&nbsp;Overflow page) or tabs, is there a CSS standard way to disable the highlighting effect if the user accidentally selects the text?  

I realize this could be done with JavaScript, and a little googling yielded the Mozilla-only `-moz-user-select` option.  

Is there a standard-compliant way to accomplish this with CSS, and if not, what is the "best practice" approach?  

#### Answer 2 (score 6997)
<strong>UPDATE January, 2017:</strong>  

According to <a href="http://caniuse.com/#feat=user-select-none" rel="noreferrer">Can I use</a>, the `user-select` is currently supported in all browsers except Internet&nbsp;Explorer 9 and earlier versions (but sadly <em>still</em> needs a vendor prefix).  

<hr>

All of the correct CSS variations are:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
.noselect {
  -webkit-touch-callout: none; /* iOS Safari */
    -webkit-user-select: none; /* Safari */
     -khtml-user-select: none; /* Konqueror HTML */
       -moz-user-select: none; /* Old versions of Firefox */
        -ms-user-select: none; /* Internet Explorer/Edge */
            user-select: none; /* Non-prefixed version, currently
                                  supported by Chrome, Opera and Firefox */
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;p&gt;
  Selectable text.
&lt;/p&gt;
&lt;p class="noselect"&gt;
  Unselectable text.
&lt;/p&gt;</code></pre>
</div>
</div>


<hr>

Note that it's a <strong>non-standard feature</strong> (i.e. not a part of any specification). It is not guaranteed to work everywhere, and there might be differences in implementation among browsers and in the future browsers can drop support for it.  

<hr>

More information can be found in <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/user-select" rel="noreferrer">Mozilla Developer Network documentation</a>.  

#### Answer 3 (score 808)
In most browsers, this can be achieved using proprietary variations on the CSS `user-select` property, <a href="http://www.w3.org/TR/2000/WD-css3-userint-20000216#user-select" rel="noreferrer">originally proposed and then abandoned in CSS3</a> and now proposed in <a href="https://drafts.csswg.org/css-ui-4/#content-selection" rel="noreferrer">CSS UI Level 4</a>:  

```css
*.unselectable {
   -moz-user-select: none;
   -khtml-user-select: none;
   -webkit-user-select: none;

   /*
     Introduced in IE 10.
     See http://ie.microsoft.com/testdrive/HTML5/msUserSelect/
   */
   -ms-user-select: none;
   user-select: none;
}
```

For IE &lt; 10 and Opera &lt; 15, you will need to use the `unselectable` attribute of the element you wish to be unselectable. You can set this using an attribute in HTML:  

```css
<div id="foo" unselectable="on" class="unselectable">...</div>
```

Sadly this property isn't inherited, meaning you have to put an attribute in the start tag of every element inside the `&lt;div&gt;`. If this is a problem, you could instead use JavaScript to do this recursively for an element's descendants:  

```css
function makeUnselectable(node) {
    if (node.nodeType == 1) {
        node.setAttribute("unselectable", "on");
    }
    var child = node.firstChild;
    while (child) {
        makeUnselectable(child);
        child = child.nextSibling;
    }
}

makeUnselectable(document.getElementById("foo"));
```

<hr>

<p><strong>Update 30 April 2014</strong>: This tree traversal needs to be re-run whenever a new element is added to the tree, but it seems from a comment by @Han that it is possible to avoid this by
adding a `mousedown` event handler that sets `unselectable` on the target of the event. See <a href="http://jsbin.com/yagekiji/1" rel="noreferrer">http://jsbin.com/yagekiji/1</a> for details.</p>

<hr>

This still doesn't cover all possibilities. While it is impossible to initiate selections in unselectable elements, in some browsers (IE and Firefox, for example) it's still impossible to prevent selections that start before and end after the unselectable element without making the whole document unselectable.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: CSS opacity only to background color, not the text on it? (score [1753836](https://stackoverflow.com/q/5135019) in 2019)

#### Question
Can I assign the `opacity` property to the `background` property of a `div` only and not to the text on it?  

I've tried:  

```css
background: #CCC;
opacity: 0.6;
```

but this doesn't change the opacity.  

#### Answer accepted (score 1324)
It sounds like you want to use a transparent background, in which case you could try using the <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/color_value#rgb()_and_rgba()" rel="noreferrer">`rgba()`</a> function:  

<blockquote>
  <h5>`rgba(R, G, B, A)`</h3>
  
  R (red), G (green), and B (blue) can be either `&lt;integer&gt;`s or `&lt;percentage&gt;`s, where the number 255 corresponds to 100%. A (alpha) can be a `&lt;number&gt;` between 0 and 1, or a `&lt;percentage&gt;`, where the number 1 corresponds to 100% (full opacity).  
  
  <h5>RGBa example</h3>

```css
rgba(51, 170, 51, .1)    /*  10% opaque green */ 
rgba(51, 170, 51, .4)    /*  40% opaque green */ 
rgba(51, 170, 51, .7)    /*  70% opaque green */ 
rgba(51, 170, 51,  1)    /* full opaque green */ 
```
</blockquote>

A small <a href="http://jsfiddle.net/swQx2/" rel="noreferrer">example</a> showing how `rgba` can be used.  

As of 2018, practically <a href="https://caniuse.com/#feat=css3-colors" rel="noreferrer"><strong>every browser supports the `rgba` syntax</strong></a>.  

#### Answer 2 (score 74)
The easiest way to do this is with 2 divs, 1 with the background and 1 with the text:  

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
```css
#container {
  position: relative;
  width: 300px;
  height: 200px;
}
#block {
  background: #CCC;
  filter: alpha(opacity=60);
  /* IE */
  -moz-opacity: 0.6;
  /* Mozilla */
  opacity: 0.6;
  /* CSS3 */
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
}
#text {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="container"&gt;
  &lt;div id="block"&gt;&lt;/div&gt;
  &lt;div id="text"&gt;Test&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 3 (score 21)
<strong>For <a href="http://lesscss.org" rel="nofollow noreferrer">Less</a> users only:</strong>  

If you don't like to set your colors using RGBA, but rather using HEX, there are solutions.  

You could use a mixin like:  

```css
.transparentBackgroundColorMixin(@alpha,@color) {
  background-color: rgba(red(@color), green(@color), blue(@color), @alpha);
}
```

And use it like:  

```css
.myClass {
    .transparentBackgroundColorMixin(0.6,#FFFFFF);
}
```

Actually this is what a <a href="http://lesscss.org/functions/#color-operations-fade" rel="nofollow noreferrer">built-in Less function</a> also provide:  

```css
.myClass {
    background-color: fade(#FFFFFF, 50%);
}
```

See <em><a href="https://stackoverflow.com/questions/14860874/how-do-i-convert-a-hexadecimal-color-to-rgba-with-the-less-compiler">How do I convert a hexadecimal color to rgba with the Less compiler?</a></em>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: Change an HTML5 input's placeholder color with CSS (score [1702940](https://stackoverflow.com/q/2610497) in 2018)

#### Question
Chrome supports the <a href="http://www.w3.org/html/wg/drafts/html/master/single-page.html#the-placeholder-attribute" rel="noreferrer" title="The placeholder attribute">placeholder attribute</a> on `input[type=text]` elements (others probably do too).  

But the following `CSS` doesn't do anything to the placeholder's value:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
input[placeholder], [placeholder], *[placeholder] {
    color: red !important;
}
```

<pre class="snippet-code-html lang-html prettyprint-override">`&lt;input type="text" placeholder="Value"&gt;`</pre>
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override">`&lt;input placeholder="Stack Snippets are awesome!"&gt;`</pre>
</div>
</div>


<h5>Usage notes</h2>

<ul>
<li>Be careful to avoid bad contrasts. Firefox's placeholder appears to be defaulting with a reduced opacity, so needs to use `opacity: 1` here.</li>
<li>Note that placeholder text is just cut off if it doesn’t fit – size your input elements in `em` and test them with big minimum font size settings. Don’t forget translations: some languages <a href="http://www.w3.org/International/articles/article-text-size.en" rel="noreferrer">need more room</a> for the same word. </li>
<li>Browsers with HTML support for `placeholder` but without CSS support for that (like Opera) should be tested too.</li>
<li>Some browsers use additional default CSS for some `input` types (`email`, `search`). These might affect the rendering in unexpected ways. Use the <a href="https://developer.mozilla.org/en-US/docs/CSS/-moz-appearance" rel="noreferrer">properties</a> `-webkit-appearance` and `-moz-appearance` to change that. Example:</li>
</ul>

```css
    [type="search"] {
        -moz-appearance:    textfield;
        -webkit-appearance: textfield;
        appearance: textfield;
    }
```

#### Answer 2 (score 703)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;input placeholder="hello"/&gt; &lt;br /&gt;
&lt;textarea placeholder="hello"&gt;&lt;/textarea&gt;</code></pre>
</div>
</div>


This will style all `input` and `textarea` placeholders.  

<strong>Important Note:</strong> Do not group these rules. Instead, make a separate rule for every selector (one invalid selector in a group makes the whole group invalid).  

#### Answer 3 (score 270)
You may also want to style textareas:  

```css
input::-webkit-input-placeholder, textarea::-webkit-input-placeholder {
  color: #636363;
}
input:-moz-placeholder, textarea:-moz-placeholder {
  color: #636363;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: Stretch and scale a CSS image in the background - with CSS only (score [1676896](https://stackoverflow.com/q/1150163) in 2017)

#### Question
I want that my background image stretch and scale depending on the browser viewport size.  

I've seen some questions on Stack&nbsp;Overflow that do the job, like <em><a href="https://stackoverflow.com/questions/376253/stretch-and-scale-css-background/388817#388817">Stretch and scale CSS background</a></em> for example. It works well, but I want to place the image using `background`, not with an `img` tag.  

In that one an `img` tag is placed, and then with CSS we tribute to the `img` tag.  

```css
width:100%; height:100%;
```

It works, but that question is a bit old, and states that in CSS 3 resizing a background image will work pretty well. I've tried this <a href="http://www.w3.org/TR/2002/WD-css3-background-20020802/#background-size" rel="noreferrer">example the first one</a>, but it didn't work out for me.  

Is there a good method to do it with the `background-image` declaration?  

#### Answer accepted (score 1012)
CSS3 has a nice little attribute called `background-size:cover`.  

This scales the image so that the background area is completely covered by the background image while maintaining the aspect ratio. The entire area will be covered. However, part of the image may not be visible if the width/height of the resized image is too great.  

#### Answer 2 (score 463)
You could use the CSS3 property to do it quite nicely. It resizes to ratio so no image distortion (although it does upscale small images). Just note, it's not implemented in all browsers yet.  

```css
background-size: 100%;
```

#### Answer 3 (score 183)
Using the <a href="https://stackoverflow.com/questions/376253/stretch-and-scale-css-background/388817#388817">code</a> I mentioned...  

<h5>HTML</h3>

```css
<div id="background">
    <img src="img.jpg" class="stretch" alt="" />
</div>
```

<h5>CSS</h3>

```css
#background {
    width: 100%; 
    height: 100%; 
    position: fixed; 
    left: 0px; 
    top: 0px; 
    z-index: -1; /* Ensure div tag stays behind content; -999 might work, too. */
}

.stretch {
    width:100%;
    height:100%;
}
```

That produces the desired effect: only the content will scroll, not the background.  

The background image resizes to the browser viewport for any screen size. When the content doesn't fit the browser viewport, and the user needs to scroll the page, the background image remains fixed in the viewport while the content scrolls.  

With CSS 3 it seems this would be a lot easier.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: How to overlay one div over another div (score [1664399](https://stackoverflow.com/q/2941189) in 2019)

#### Question
I need assistance with overlaying one individual `div` over another individual `div`.  

My code looks like this:  

```css
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="container"&gt;
  &lt;div id="navi"&gt;a&lt;/div&gt;
  &lt;div id="infoi"&gt;
    &lt;img src="https://appharbor.com/assets/images/stackoverflow-logo.png" height="20" width="32" /&gt;b
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
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

```css
<body>
  <div>Bottom</div>
  <div>Top</div>
</body>
```

In this example, if the two `&lt;div&gt;` elements were positioned in the same place on the page, the `&lt;div&gt;Top&lt;/div&gt;` element would cover the `&lt;div&gt;Bottom&lt;/div&gt;` element. Since `&lt;div&gt;Top&lt;/div&gt;` comes after `&lt;div&gt;Bottom&lt;/div&gt;` in the HTML structure it has a higher stacking order.  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="true" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="bottom"&gt;Bottom&lt;/div&gt;
&lt;div id="top"&gt;Top&lt;/div&gt;</code></pre>
</div>
</div>


The stacking order can be changed with CSS using the `z-index` or `order` properties.  

We can ignore the stacking order in this issue as the natural HTML structure of the elements means the element we want to appear on `top` comes after the other element.  

So, back to the problem at hand - we'll use position context to solve this issue.  

<h5>The Solution</h2>

As stated above, our goal is to position the `#infoi` element so it appears within the `.navi` element. To do this, we'll wrap the `.navi` and `#infoi` elements in a new element `&lt;div class="wrapper"&gt;` so we can create a new position context.  

```css
<div class="wrapper">
  <div class="navi"></div>
  <div id="infoi"></div>
</div>
```

Then create a new position context by giving `.wrapper` a `position: relative`.  

```css
.wrapper {
  position: relative;
}
```

With this new position context, we can position `#infoi` within `.wrapper`.  First, give `#infoi` a `position: absolute`, allowing us to position `#infoi` absolutely in `.wrapper`.  

Then add `top: 0` and `right: 0` to position the `#infoi` element in the top-right corner. Remember, because the `#infoi` element is using `.wrapper` as its position context, it will be in the top-right of the `.wrapper` element.  

```css
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="wrapper"&gt;
  &lt;div class="navi"&gt;&lt;/div&gt;
  &lt;div id="infoi"&gt;
    &lt;img src="http://via.placeholder.com/32x20/000000/ffffff?text=?" height="20" width="32"/&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


<h5>The Alternate (No Wrapper) Solution</h2>

In the case we can't edit any HTML, meaning we can't add a wrapper element, we can still achieve the desired effect.  

Instead of using `position: absolute` on the `#infoi` element, we'll use `position: relative`. This allows us to reposition the `#infoi` element from its default position below the `.navi` element. With `position: relative` we can use a negative `top` value to move it up from its default position, and a `left` value of `100%` minus a few pixels, using `left: calc(100% - 52px)`, to position it near the right-side.  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="true" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="navi"&gt;&lt;/div&gt;
&lt;div id="infoi"&gt;
  &lt;img src="http://via.placeholder.com/32x20/000000/ffffff?text=?" height="20" width="32"/&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 3 (score 107)
By using a `div` with style `z-index:1;` and `position: absolute;` you can overlay your `div` on any other `div`.  

`z-index` determines the order in which divs 'stack'. A div with a higher `z-index` will appear in front of a div with a lower `z-index`. Note that this property <strong>only works with positioned elements</strong>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: Hiding the scroll bar on an HTML page (score [1654295](https://stackoverflow.com/q/3296644) in 2019)

#### Question
Can CSS be used to hide the scroll bar? How would you do this?  

#### Answer accepted (score 405)
Set `overflow: hidden;` on the body tag like this:  

```css
<style type="text/css">
    body {
        overflow: hidden;
    }
</style>
```

The code above hides both the horizontal and vertical scrollbar.  

If you want to hide <strong>only the vertical scrollbar</strong>, use `overflow-y`:  

```css
<style type="text/css">
    body {
        overflow-y: hidden;
    }
</style>
```

And if you want to hide <strong>only the horizontal scrollbar</strong>, use `overflow-x`:  

```css
<style type="text/css">
    body {
        overflow-x: hidden;
    }
</style>
```

<hr>

<em>Note: It'll also disable the scrolling feature. Refer to the below answers if you just want to hide the scroll bar, but not the scroll feature.</em>  

#### Answer 2 (score 915)
WebKit supports scrollbar pseudo elements that can be hidden with standard CSS rules:  



```css
#element::-webkit-scrollbar {
    display: none;
}
```

If you want all scrollbars hidden, use  

```css
::-webkit-scrollbar {
    display: none;
}
```

I'm not sure about restoring - this did work, but there might be a right way to do it:  

```css
::-webkit-scrollbar {
    display: block;
}
```

You can of course always use `width: 0`, which can then be easily restored with `width: auto`, but I'm not a fan of abusing `width` for visibility tweaks.  

Firefox 64 now supports the experimental <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/scrollbar-width" rel="noreferrer">scrollbar-width property</a> by default (63 requires a configuration flag to be set). To hide the scrollbar in Firefox 64:  

```css
#element {
    scrollbar-width: none;
}
```

To see if your current browser supports either the pseudo element or `scrollbar-width`, try this snippet:  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
.content {
  /* These rules create an artificially confined space, so we get
     a scrollbar that we can hide. They are not directly involved in
     hiding the scrollbar. */

  border: 1px dashed gray;
  padding: .5em;

  white-space: pre-wrap;
  height: 5em;
  overflow-y: scroll;
}

.content {
  /* This is the magic bit for Firefox */
  scrollbar-width: none;
}

.content::-webkit-scrollbar {
  /* This is the magic bit for WebKit */
  display: none;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class='content'&gt;
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris eu
urna et leo aliquet malesuada ut ac dolor. Fusce non arcu vel ligula
fermentum sodales a quis sapien. Sed imperdiet justo sit amet venenatis
egestas. Integer vitae tempor enim. In dapibus nisl sit amet purus congue
tincidunt. Morbi tincidunt ut eros in rutrum. Sed quam erat, faucibus
vel tempor et, elementum at tortor. Praesent ac libero at arcu eleifend
mollis ut eget sapien. Duis placerat suscipit eros, eu tempor tellus
facilisis a. Vivamus vulputate enim felis, a euismod diam elementum
non. Duis efficitur ac elit non placerat. Integer porta viverra nunc,
sed semper ipsum. Nam laoreet libero lacus.

Sed sit amet tincidunt felis. Sed imperdiet, nunc ut porta elementum,
eros mi egestas nibh, facilisis rutrum sapien dolor quis justo. Quisque
nec magna erat. Phasellus vehicula porttitor nulla et dictum. Sed
tincidunt scelerisque finibus. Maecenas consequat massa aliquam pretium
volutpat. Duis elementum magna vel velit elementum, ut scelerisque
odio faucibus.
&lt;/div&gt;</code></pre>
</div>
</div>


<hr>

<em>(Note that this is not really a correct answer to the question, because it hides the horizontal bars as well, but that's what I was looking for when Google pointed me here, so I figured I'd post it anyway.)</em>  

#### Answer 3 (score 505)
<h5>Yes, sort of..</h2>

When you ask the question, "Can the scroll-bars of a browser be removed in some way, rather than simply hidden or camouflaged", everyone will say "Not possible" because it is not possible to <em>remove</em> the scrollbars from all browsers in a compliant and cross-compatible way, and then there's the whole argument of usability.  

However, it is possible to prevent the browser from ever having the need to generate and display scrollbars if you do not allow your webpage to overflow.  

This just means that we have to proactively substitute the same behavior that the browser would typically do for us and tell the browser thanks but no thanks buddy.  Rather than try to remove scrollbars (which we all know is not possible) we can avoid scrolling (perfectly feasible) and scroll within the elements that we make and have more control over.  

Create a div with overflow hidden. Detect when the user attempts to scroll, but is unable to because we've disabled the browsers ability to scroll with overflow: hidden.. and instead move the content up using JavaScript when this occurs. Thereby creating our own scrolling without the browsers default scrolling or use a plugin like <a href="https://github.com/cubiq/iscroll" rel="noreferrer">iScroll</a>.  

<h5>---</h2>

<em>For the sake of being thorough; all the vendor specific ways of manipulating scroll-bars:</em>  

<h5>Internet Explorer 5.5+</h2>

*These properties were never part of the CSS specification, nor were they ever approved or vendor prefixed, but they work in Internet Explorer and Konqueror. These can also be set locally in the user style sheet for each application. In Internet&nbsp;Explorer you find it under the "Accessibility" tab, in Konqueror under the "Stylesheets" tab.  

```css
body, html { /* These are defaults and can be replaced by hexadecimal color values */
    scrollbar-base-color: aqua;
    scrollbar-face-color: ThreeDFace;
    scrollbar-highlight-color: ThreeDHighlight;
    scrollbar-3dlight-color: ThreeDLightShadow;
    scrollbar-shadow-color: ThreeDDarkShadow;
    scrollbar-darkshadow-color: ThreeDDarkShadow;
    scrollbar-track-color: Scrollbar;
    scrollbar-arrow-color: ButtonText;
}
```

As of Internet&nbsp;Explorer&nbsp;8 these properties were vendor prefixed by Microsoft, but they were still never approved by <a href="http://en.wikipedia.org/wiki/World_Wide_Web_Consortium" rel="noreferrer">W3C</a>.  

```css
-ms-scrollbar-base-color
-ms-scrollbar-face-color
-ms-scrollbar-highlight-color
-ms-scrollbar-3dlight-color
-ms-scrollbar-shadow-color
-ms-scrollbar-darkshadow-color
-ms-scrollbar-base-color
-ms-scrollbar-track-color
```

<h5>Further details about Internet Explorer</h3>

Internet Explorer makes `scroll` available which sets whether or not to disable or enable scroll bars; it can also be used to get the value of the position of the scroll bars.  

With Microsoft Internet Explorer 6 and later, when you use the `!DOCTYPE` declaration to specify standards-compliant mode, this attribute applies to the HTML element. When standards-compliant mode is not specified, as with earlier versions of Internet&nbsp;Explorer, this attribute applies to the `BODY` element, <strong>NOT</strong> the `HTML` element.  

It's also worth noting that when working with .NET the ScrollBar class in `System.Windows.Controls.Primitives` in the Presentation framework is responsible for rendering the scrollbars.  

<a href="http://msdn.microsoft.com/en-us/library/ie/ms534393(v=vs.85).aspx" rel="noreferrer">http://msdn.microsoft.com/en-us/library/ie/ms534393(v=vs.85).aspx</a>  

<ul>
<li><a href="http://msdn.microsoft.com/en-us/library/ie/hh772048%28v=vs.85%29.aspx" rel="noreferrer">MSDN. Basic UI properties</a></li>
<li><a href="http://www.w3.org/Style/Examples/007/scrollbars.en.html" rel="noreferrer">W3C. About non-standard scrollbar properties</a></li>
<li><a href="http://msdn.microsoft.com/en-us/library/system.windows.controls.primitives.scrollbar%28v=vs.110%29.aspx" rel="noreferrer">MSDN. .NET ScrollBar Class</a></li>
</ul>

<hr>

<h5>WebKit</h2>

WebKit extensions related to scroll-bar customization are:  

```css
::-webkit-scrollbar {}             /* 1 */
::-webkit-scrollbar-button {}      /* 2 */
::-webkit-scrollbar-track {}       /* 3 */
::-webkit-scrollbar-track-piece {} /* 4 */
::-webkit-scrollbar-thumb {}       /* 5 */
::-webkit-scrollbar-corner {}      /* 6 */
::-webkit-resizer {}               /* 7 */
```

<img src="https://i.stack.imgur.com/BhMto.jpg" alt="Enter image description here">  

These can each be combined with additional pseudo-selectors:  

<ul>
<li>`:horizontal` – The horizontal pseudo-class applies to any scrollbar pieces that have a horizontal orientation.</li>
<li>`:vertical` – The vertical pseudo-class applies to any scrollbar pieces that have a vertical orientation.</li>
<li>`:decrement` – The decrement pseudo-class applies to buttons and track pieces. It indicates whether or not the button or track piece will decrement the view’s position when used (e.g., up on a vertical scrollbar, left on a horizontal scrollbar).</li>
<li>`:increment` – The increment pseudo-class applies to buttons and track pieces. It indicates whether or not a button or track piece will increment the view’s position when used (e.g., down on a vertical scrollbar, right on a horizontal scrollbar).</li>
<li>`:start` – The start pseudo-class applies to buttons and track pieces. It indicates whether the object is placed before the thumb.</li>
<li>`:end` – The end pseudo-class applies to buttons and track pieces. It indicates whether the object is placed after the thumb.</li>
<li>`:double-button` – The double-button pseudo-class applies to buttons and track pieces. It is used to detect whether a button is part of a pair of buttons that are together at the same end of a scrollbar. For track pieces it indicates whether the track piece abuts a pair of buttons.</li>
<li>`:single-button` – The single-button pseudo-class applies to buttons and track pieces. It is used to detect whether a button is by itself at the end of a scrollbar. For track pieces it indicates whether the track piece abuts a singleton button.</li>
<li>`:no-button` – Applies to track pieces and indicates whether or not the track piece runs to the edge of the scrollbar, i.e., there is no button at that end of the track.</li>
<li>`:corner-present` – Applies to all scrollbar pieces and indicates whether or not a scrollbar corner is present.</li>
<li>`:window-inactive` – Applies to all scrollbar pieces and indicates whether or not the window containing the scrollbar is currently active. (In recent nightlies, this pseudo-class now applies to ::selection as well. We plan to extend it to work with any content and to propose it as a new standard pseudo-class.)</li>
</ul>

<strong>Examples of these combinations</strong>  

```css
::-webkit-scrollbar-track-piece:start { /* Select the top half (or left half) or scrollbar track individually */ }
::-webkit-scrollbar-thumb:window-inactive { /* Select the thumb when the browser window isn't in focus */ }
::-webkit-scrollbar-button:horizontal:decrement:hover { /* Select the down or left scroll button when it's being hovered by the mouse */ }
```

<ul>
<li><a href="https://www.webkit.org/blog/363/styling-scrollbars/" rel="noreferrer">Styling Scrollbars - Webkit.org</a></li>
</ul>

<h5>Further details about Chrome</h3>

<blockquote>
  <p><strong>addWindowScrollHandler</strong>
  public static HandlerRegistration addWindowScrollHandler(Window.ScrollHandler handler)</p>
  
  <p>&nbsp;&nbsp;Adds a Window.ScrollEvent handler
  Parameters:
  &nbsp;&nbsp;handler - the handler
  Returns:
  &nbsp;&nbsp;returns the handler registration
  [<em>source</em>](<a href="http://www.gwtproject.org/javadoc/latest/com/google/gwt/user/client/Window.html#addWindowScrollHandler(com.google.gwt.user.client.Window.ScrollHandler)" rel="noreferrer">http://www.gwtproject.org/javadoc/latest/com/google/gwt/user/client/Window.html#addWindowScrollHandler(com.google.gwt.user.client.Window.ScrollHandler)</a>
  )</p>
</blockquote>

<hr>

<h5>Mozilla</h2>

Mozilla does have some extensions for manipulating the scroll-bars, but they are all recommended not to be used.  

<ul>
<li>`-moz-scrollbars-none` They recommend using overflow:hidden in place of this.</li>
<li>`-moz-scrollbars-horizontal` Similar to overflow-x</li>
<li>`-moz-scrollbars-vertical` Similar to overflow-y</li>
<li><p>`-moz-hidden-unscrollable` Only works internally within a users profile settings. Disables scrolling XML root elements and disables using arrow keys and mouse wheel to scroll web pages.</p></li>
<li><p><a href="https://developer.mozilla.org/en-US/docs/Web/CSS/overflow" rel="noreferrer">Mozilla Developer Docs on 'Overflow'</a></p></li>
</ul>

<h5>Further details about Mozilla</h3>

This is not really useful as far as I know, but it's worth noting that the attribute which controls whether or not scrollbars are displayed in Firefox is (<a href="https://developer.mozilla.org/en-US/docs/Mozilla/Tech/XPCOM/Reference/Interface/nsIDOMWindow" rel="noreferrer">reference link</a>):  

<ul>
<li><strong>Attribute:</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;scrollbars</li>
<li><strong>Type:</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nsIDOMBarProp</li>
<li><strong>Description:</strong>&nbsp;&nbsp;The object that controls whether or not scrollbars are shown in the window. This attribute is "replaceable" in JavaScript. Read only</li>
</ul>

<h5>Last but not least, padding is like magic.</h2>

As has been previously mentioned in some other answers, here is an illustration which is sufficiently self-explanatory.  

<img src="https://i.stack.imgur.com/fafgt.gif" alt="Enter image description here">  

<hr>

<h5>History lesson</h2>

<a href="https://i.stack.imgur.com/C1Wd0.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/C1Wd0.jpg" alt="Scroll bars"></a>  

Just because I'm curious, I wanted to learn about the origin of scrollbars, and these are the best references I found.  

<ul>
<li><a href="https://arxiv.org/pdf/1404.6752.pdf" rel="noreferrer">10 Inventions on Scrolling and Scrollbars</a></li>
<li><a href="https://tools.ietf.org/id/draft-hellstrom-textpreview-02.txt" rel="noreferrer">https://tools.ietf.org/id/draft-hellstrom-textpreview-02.txt</a></li>
<li><a href="https://tools.ietf.org/id/draft-mrose-blocks-service-01.txt" rel="noreferrer">https://tools.ietf.org/id/draft-mrose-blocks-service-01.txt</a></li>
</ul>

<h5>Miscellaneous</h2>

<a href="http://www.w3.org/TR/2014/CR-html5-20140204/embedded-content-0.html#attr-iframe-seamless" rel="noreferrer">In an HTML5 specification draft, the `seamless` attribute was defined to prevent scroll-bars from appearing in iFrames so that they could be blended with surrounding content on a page</a>. Though this element does not appear in the latest revision.  

The `scrollbar` BarProp object is a child of the `window` object and represents the user interface element that contains a scrolling mechanism, or some similar interface concept. `window.scrollbars.visible` will return `true` if the scroll bars are visible.  

```css
interface Window {
  // The current browsing context
  readonly attribute WindowProxy window;
  readonly attribute WindowProxy self;
           attribute DOMString name;
  [PutForwards=href] readonly attribute Location location;
  readonly attribute History history;
  readonly attribute UndoManager undoManager;
  Selection getSelection();
  [Replaceable] readonly attribute BarProp locationbar;
  [Replaceable] readonly attribute BarProp menubar;
  [Replaceable] readonly attribute BarProp personalbar;
  [Replaceable] readonly attribute BarProp scrollbars;
  [Replaceable] readonly attribute BarProp statusbar;
  [Replaceable] readonly attribute BarProp toolbar;
  void close();
  void focus();
  void blur();
  // Truncated
```

The History API also includes features for scroll restoration on page navigation to persist the scroll position on page load.  

`window.history.scrollRestoration` can be used to check the status of scrollrestoration or change its status (appending `="auto"/"manual"`. Auto is the default value. Changing it to manual means that you as the developer will take ownership of any scroll changes that may be required when a user traverses the app's history. If you need to, you can keep track of the scroll position as you push history entries with history.pushState().  

<h5>---</h2>

<h5>Further reading:</h1>

<ul>
<li><a href="https://en.wikipedia.org/wiki/Scrollbar" rel="noreferrer">Scrollbar on Wikipedia</a></li>
<li><a href="https://msdn.microsoft.com/en-us/library/windows/desktop/bb787529(v=vs.85).aspx" rel="noreferrer">Scroll bar (Windows)</a></li>
<li><a href="http://help.dottoro.com/ljtxlmfr.php" rel="noreferrer">The Scroll Method</a></li>
<li><a href="http://msdn.microsoft.com/en-us/library/ms536726(VS.85).aspx" rel="noreferrer">The Scroll Method - Microsoft Dev Network</a></li>
<li><a href="https://github.com/cubiq/iscroll" rel="noreferrer">iScroll on Github (referenced in the first section above)</a></li>
<li><a href="http://www.nngroup.com/articles/scrolling-and-scrollbars/" rel="noreferrer">Scrolling and Scrollbars an article about usability by Jakob Nielsen</a></li>
</ul>

<h5>Examples</h2>

<ul>
<li><a href="https://benfrain.com/independent-scrolling-panels-body-scroll-using-just-css/" rel="noreferrer">Independent scrolling panels with no body scroll (using just CSS) - Ben Frain (10-21-2014)</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: CSS center text (horizontally and vertically) inside a div block (score [1633481](https://stackoverflow.com/q/5703552) in 2019)

#### Question
I have a `div` set to `display:block` (`90px` `height` and `width`), and I have some text inside.  

I need the text to be aligned in the center both vertically and horizontally.  

I have tried `text-align:center`, but it doesn't do the horizontal part, so I tried `vertical-align:middle`, but it didn't work.  

Any ideas?  

#### Answer accepted (score 1211)
If it is one line of text and/or image, then it is easy to do. Just use:  

```css
text-align: center;
vertical-align: middle;
line-height: 90px;       /* The same as your div height */
```

That's it. If it can be multiple lines, then it is somewhat more complicated. But there are solutions on  <a href="http://pmob.co.uk/" rel="noreferrer">http://pmob.co.uk/</a>. Look for "vertical align".  

Since they tend to be hacks or adding complicated divs... I usually use a table with a single cell to do it... to make it as simple as possible.  

<hr>

<h5>Update for 2016 / 2017:</h1>

It can be more commonly done with `transform`, and it works well even in older browsers such as Internet&nbsp;Explorer&nbsp;10 and Internet&nbsp;Explorer&nbsp;11. It can support multiple lines of text:  

```css
position: relative;
top: 50%;
transform: translateY(-50%);
```

Example: <a href="https://jsfiddle.net/wb8u02kL/1/" rel="noreferrer">https://jsfiddle.net/wb8u02kL/1/</a>  

<h5>To shrink-wrap the width:</h2>

The solution above used a fixed width for the content area. To use a shrink-wrapped width, use  

```css
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

```css
.container {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translateX(-50%) translateY(-50%);
}
```
</li>
</ul>

<hr>

<ul>
<li><h5>Approach 2 - Flexbox method:</h3>

<a href="http://jsfiddle.net/yeaqrh48/" rel="noreferrer"><strong>Example Here</strong></a> / <a href="http://jsfiddle.net/yeaqrh48/show" rel="noreferrer"><strong>Full Screen Example</strong></a>  

In <a href="http://caniuse.com/#feat=flexbox" rel="noreferrer">supported browsers</a>, set the `display` of the targeted element to `flex` and use `align-items: center` for vertical centering and `justify-content: center` for horizontal centering. Just don't forget to add vendor prefixes for additional browser support (<a href="http://jsfiddle.net/yeaqrh48/" rel="noreferrer">see example</a>).  

```css
html, body, .container {
    height: 100%;
}
.container {
    display: flex;
    align-items: center;
    justify-content: center;
}
```
</li>
</ul>

<hr>

<ul>
<li><h5>Approach 3 - `table-cell`/`vertical-align: middle`:</h3>

<a href="http://jsfiddle.net/sa088kb0/" rel="noreferrer"><strong>Example Here</strong></a> / <a href="http://jsfiddle.net/sa088kb0/show/" rel="noreferrer"><strong>Full Screen Example</strong></a>  

In some cases, you will need to ensure that the `html`/`body` element's height is set to `100%`.  

For vertical alignment, set the parent element's `width`/`height` to `100%` and add `display: table`. Then for the child element, change the `display` to `table-cell` and add `vertical-align: middle`.  

For horizontal centering, you could either add `text-align: center` to center the text and any other `inline` children elements. Alternatively, you could use `margin: 0 auto` assuming the element is `block` level.  

```css
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
```
</li>
</ul>

<hr>

<ul>
<li><h5>Approach 4 - Absolutely positioned `50%` from the top with displacement:</h3>

<a href="http://jsfiddle.net/2epdqL5g/" rel="noreferrer"><strong>Example Here</strong></a> / <a href="http://jsfiddle.net/2epdqL5g/show" rel="noreferrer"><strong>Full Screen Example</strong></a>  

This approach assumes that the text has a known height - in this instance, `18px`. Just absolutely position the element `50%` from the top, relative to the parent element. Use a negative `margin-top` value that is half of the element's known height, in this case - `-9px`.  

```css
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
```
</li>
</ul>

<hr>

<ul>
<li><h5>Approach 5 - The `line-height` method (Least flexible - not suggested):</h3>

<a href="http://jsfiddle.net/6onex7jf/" rel="noreferrer"><strong>Example Here</strong></a>  

In some cases, the parent element will have a fixed height. For vertical centering, all you have to do is set a `line-height` value on the child element equal to the fixed height of the parent element.  

Though this solution will work in some cases, it's worth noting that it won't work when there are multiple lines of text - <a href="http://jsfiddle.net/6rvdxbt9/" rel="noreferrer">like this</a>.  

```css
.parent {
    height: 200px;
    width: 400px;
    text-align: center;
}
.parent > .child {
    line-height: 200px;
}
```
</li>
</ul>

<hr>

Methods 4 and 5 aren't the most reliable. Go with one of the first 3.  

#### Answer 3 (score 70)
Using flexbox/CSS:   

```css
<div class="box">
    <p>&#x0D05;</p>
</div>
```

The CSS:  

```css
.box{
    display: flex;
    justify-content: center;
    align-items: center;
}
```

Taken from <a href="http://tutorialzine.com/2015/09/quick-tip-the-simplest-way-to-center-elements-vertically-and-horizontally/">Quick Tip: The Simplest Way To Center Elements Vertically And Horizontally</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: How to style a checkbox using CSS (score [1556560](https://stackoverflow.com/q/4148499) in 2019)

#### Question
I am trying to style a checkbox using the following:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override">`&lt;input type="checkbox" style="border:2px dotted #00f;display:block;background:#ff0000;" /&gt;`</pre>
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;label for="test"&gt;Label for my styled "checkbox"&lt;/label&gt;
&lt;label class="myCheckbox"&gt;
  &lt;input type="checkbox" name="test" /&gt;
  &lt;span&gt;&lt;/span&gt;
&lt;/label&gt;</code></pre>
</div>
</div>


#### Answer 3 (score 130)
You can achieve quite a cool custom checkbox effect by using the new abilities that come with the `:after` and `:before` pseudo classes. The advantage to this, is: You don't need to add anything more to the DOM, just the standard checkbox.  

Note this will only work for compatible browsers. I believe this is related to the fact that some browsers do not allow you to set `:after` and `:before` on input elements. Which unfortunately means for the moment only WebKit browsers are supported. Firefox + Internet&nbsp;Explorer will still allow the checkboxes to function, just unstyled, and this will hopefully change in the future (the code does not use vendor prefixes).  

<strong>This is a WebKit browser solution only (Chrome, Safari, Mobile browsers)</strong>  

<strong><a href="http://jsfiddle.net/YMuPw/15/" rel="nofollow noreferrer">See Example Fiddle</a></strong>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
$(function() {
  $('input').change(function() {
    $('div').html(Math.random());
  });
});
```

```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"&gt;&lt;/script&gt;

&lt;table style="width:100%"&gt;
  &lt;tr&gt;
    &lt;td&gt;Normal:&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" checked="checked" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" disabled="disabled" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" disabled="disabled" checked="checked" /&gt;&lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;Small:&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" class="myinput" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" checked="checked" class="myinput" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" disabled="disabled" class="myinput" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" disabled="disabled" checked="checked" class="myinput" /&gt;&lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;Large:&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" class="myinput large" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" checked="checked" class="myinput large" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" disabled="disabled" class="myinput large" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" disabled="disabled" checked="checked" class="myinput large" /&gt;&lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;Custom icon:&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" class="myinput large custom" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" checked="checked" class="myinput large custom" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" disabled="disabled" class="myinput large custom" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="checkbox" disabled="disabled" checked="checked" class="myinput large custom" /&gt;&lt;/td&gt;
  &lt;/tr&gt;
&lt;/table&gt;</code></pre>
</div>
</div>


<a href="http://jsfiddle.net/dv904vn1/2/" rel="nofollow noreferrer"><strong>Bonus Webkit style flipswitch fiddle</strong></a>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
$(function() {
  var f = function() {
    $(this).next().text($(this).is(':checked') ? ':checked' : ':not(:checked)');
  };
  $('input').change(f).trigger('change');
});
```

```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"&gt;&lt;/script&gt;

&lt;h2&gt;Webkit friendly mobile-style checkbox/flipswitch&lt;/h2&gt;
&lt;input type="checkbox" class="flipswitch" /&gt; &amp;nbsp;
&lt;span&gt;&lt;/span&gt;
&lt;br&gt;
&lt;input type="checkbox" checked="checked" class="flipswitch" /&gt; &amp;nbsp;
&lt;span&gt;&lt;/span&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 21: How do I vertically align text in a div? (score [1542747](https://stackoverflow.com/q/2939914) in 2018)

#### Question
I am trying to find the most effective way to align text with a div. I have tried a few things and none seem to work.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="testimonialText"&gt;
  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
  in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
&lt;/div&gt;</code></pre>
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
```css
div { border:1px solid green;}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div style="display: table; height: 400px; overflow: hidden;"&gt;
  &lt;div style="display: table-cell; vertical-align: middle;"&gt;
    &lt;div&gt;
      everything is vertically centered in modern IE8+ and others.
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


It is possible to merge hacks for old browsers (Internet&nbsp;Explorer&nbsp;6/7) into styles with using `#` to hide styles from newer browsers:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
div { border:1px solid green;}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div style="display: table; height: 400px; #position: relative; overflow: hidden;"&gt;
  &lt;div style=
    "#position: absolute; #top: 50%;display: table-cell; vertical-align: middle;"&gt;
    &lt;div style=" #position: relative; #top: -50%"&gt;
      everything is vertically centered
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 714)
You need to add the `line-height` attribute and that attribute must match the height of the `div`. In your case:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.center {
  height: 309px;
  line-height: 309px; /* same as height! */
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="center"&gt;
  A single line.
&lt;/div&gt;</code></pre>
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
```css
li {
  display: flex;
  justify-content: center;
  align-content: center;
  flex-direction: column;
  /* Column | row */
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;ul&gt;
  &lt;li&gt;
    &lt;p&gt;Some Text&lt;/p&gt;
  &lt;/li&gt;
  &lt;li&gt;
    &lt;p&gt;A bit more text that goes on two lines&lt;/p&gt;
  &lt;/li&gt;
  &lt;li&gt;
    &lt;p&gt;Even more text that demonstrates how lines can span multiple lines&lt;/p&gt;
  &lt;/li&gt;
&lt;/ul&gt;</code></pre>
</div>
</div>


<h5>Another solution</h2>

<a href="http://zerosixthree.se/vertical-align-anything-with-just-3-lines-of-css/" rel="noreferrer">This is from <strong>zerosixthree</strong> and lets you center anything with six lines of CSS</a>  

This method isn't supported in <em>Internet&nbsp;Explorer&nbsp;8 and lower</em>.  

<a href="http://jsfiddle.net/Sw3Jd/310/" rel="noreferrer">jsfiddle</a>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
p {
  text-align: center;
  position: relative;
  top: 50%;
  -ms-transform: translateY(-50%);
  -webkit-transform: translateY(-50%);
  transform: translateY(-50%);
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;ul&gt;
  &lt;li&gt;
    &lt;p&gt;Some Text&lt;/p&gt;
  &lt;/li&gt;
  &lt;li&gt;
    &lt;p&gt;A bit more text that goes on two lines&lt;/p&gt;
  &lt;/li&gt;
  &lt;li&gt;
    &lt;p&gt;Even more text that demonstrates how lines can span multiple lines&lt;/p&gt;
  &lt;/li&gt;
&lt;/ul&gt;</code></pre>
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;ul&gt;
  &lt;li&gt;
    &lt;div class="outerContainer"&gt;
      &lt;div class="innerContainer"&gt;
        &lt;div class="element"&gt;
          &lt;p&gt;
            &lt;!-- Content --&gt;
            Content
          &lt;/p&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/li&gt;

  &lt;li&gt;
    &lt;div class="outerContainer"&gt;
      &lt;div class="innerContainer"&gt;
        &lt;div class="element"&gt;
          &lt;p&gt;
            &lt;!-- Content --&gt;
            Content
          &lt;/p&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/li&gt;
&lt;/ul&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How to remove focus border (outline) around text/input boxes? (Chrome) (score [1525931](https://stackoverflow.com/q/3397113) in 2019)

#### Question
Can anyone explain how to remove the orange or blue border (outline) around text/input boxes? I think it only happens on Chrome to show that the input box is active. Here's the input CSS I'm using:  

```css
input {
    background-color: transparent;
    border: 0px solid;
    height: 20px;
    width: 160px;
    color: #CCC;
}
```

<img src="https://i.stack.imgur.com/HSKYf.png" alt="enter image description here">  

#### Answer accepted (score 2129)
This border is used to show that the element is focused (i.e. you can type in the input or press the button with Enter). You can remove it, though:  

```css
textarea:focus, input:focus{
    outline: none;
}
```

You may want to add some other way for users to know what element has keyboard focus though for usability.  

Chrome will also apply highlighting to other elements such as DIV's used as modals. To prevent the highlight on those and all other elements as well, you can do:  

```css
*:focus {
    outline: none;
}
```

#### Answer 2 (score 154)
The current answer didn't work for me with Bootstrap 3.1.1. Here's what I had to override:  

```css
.form-control:focus {
  border-color: inherit;
  -webkit-box-shadow: none;
  box-shadow: none;
}
```

#### Answer 3 (score 92)
```css
input:focus {
    outline:none;
}
```

This will do. Orange outline won't show up anymore.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: How do I style a \<select> dropdown with only CSS? (score [1519897](https://stackoverflow.com/q/1895476) in 2019)

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

```css
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

```css
select::-ms-expand {
    display: none; /* Hide the default arrow in Internet Explorer 10 and Internet Explorer 11 */
}
```

If Internet&nbsp;Explorer&nbsp;9 is a concern, we have no way of removing the default arrow (which would mean that we would now have two arrows), but, we could use a funky Internet&nbsp;Explorer&nbsp;9 selector.  

To at least undo our custom arrow - leaving the default select arrow intact.  

```css
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;select&gt;
  &lt;option&gt;Apples&lt;/option&gt;
  &lt;option selected&gt;Pineapples&lt;/option&gt;
  &lt;option&gt;Chocklate&lt;/option&gt;
  &lt;option&gt;Pancakes&lt;/option&gt;
&lt;/select&gt;</code></pre>
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="styled"&gt;
  &lt;select&gt;
    &lt;option&gt;Pineapples&lt;/option&gt;
    &lt;option selected&gt;Apples&lt;/option&gt;
    &lt;option&gt;Chocklate&lt;/option&gt;
    &lt;option&gt;Pancakes&lt;/option&gt;
  &lt;/select&gt;
&lt;/div&gt;</code></pre>
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;!--[if !IE]&gt; --&gt;
&lt;div class="notIE"&gt;
  &lt;!-- &lt;![endif]--&gt;
  &lt;span class="fancyArrow"&gt;&lt;/span&gt;
  &lt;select&gt;
    &lt;option&gt;Apples&lt;/option&gt;
    &lt;option selected&gt;Pineapples&lt;/option&gt;
    &lt;option&gt;Chocklate&lt;/option&gt;
    &lt;option&gt;Pancakes&lt;/option&gt;
  &lt;/select&gt;
  &lt;!--[if !IE]&gt; --&gt;
&lt;/div&gt;
&lt;!-- &lt;![endif]--&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 230)
It is possible, but unfortunately mostly in WebKit-based browsers to the extent we, as developers, require. Here is the example of CSS styling gathered from Chrome options panel via built-in developer tools inspector, improved to match currently supported CSS properties in most modern browsers:  

```css
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

### 24: How do I give text or an image a transparent background using CSS? (score [1510757](https://stackoverflow.com/q/806000) in 2016)

#### Question
Is it possible, using CSS only, to make the `background` of an element semi-transparent but have the content (text &amp; images) of the element opaque?  

I'd like to accomplish this without having the text and the background as two separate elements.  

When trying:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;p&gt;
  &lt;span&gt;Hello world&lt;/span&gt;
&lt;/p&gt;</code></pre>
</div>
</div>


It looks like child elements are subjected to the opacity of their parents, so `opacity:1` is relative to the `opacity:0.6` of the parent.  

#### Answer accepted (score 2228)
Either use a semi-transparent <a href="http://en.wikipedia.org/wiki/Portable_Network_Graphics" rel="noreferrer">PNG</a> image or use CSS&nbsp;3:  

```css
background-color: rgba(255, 0, 0, 0.5);
```

Here's an article from css3.info, <em><a href="http://www.css3.info/opacity_rgba_and_compromise/" rel="noreferrer">Opacity, RGBA and compromise</a></em> (2007-06-03).  

<hr>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;p style="background-color: rgba(255, 0, 0, 0.5);"&gt;
  &lt;span&gt;Hello, World!&lt;/span&gt;
&lt;/p&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 469)
In Firefox 3 and Safari 3, you can use RGBA like <a href="https://stackoverflow.com/questions/806000/css-semi-transparent-background-but-not-text/806189#806189">Georg Schölly mentioned</a>.  

A little known trick is that you can use it in Internet&nbsp;Explorer as well using the gradient filter.  

```css
background-color: rgba(0, 255, 0, 0.5);
filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#7F00FF00', EndColorStr='#7F00FF00');
```

The first hex number defines the alpha value of the color.  

Full solution all browsers:  

```css
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

```css
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="container"&gt;
  &lt;div class="content"&gt;
    Here is the content.
    &lt;br/&gt;Background should grow to fit.
  &lt;/div&gt;
  &lt;div class="background"&gt;&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 25: How to vertically align an image inside a div (score [1475597](https://stackoverflow.com/q/7273338) in 2019)

#### Question
How can you align an image inside of a containing `div`?  

<h5>Example</h2>

In my example, I need to vertically center the `&lt;img&gt;` in the `&lt;div&gt;` with `class ="frame`":  

```css
<div class="frame" style="height: 25px;">
    <img src="http://jsfiddle.net/img/logo.png" />
</div>
```

`.frame`'s height is fixed and image's height is unknown. I can add new elements in `.frame` if that's the only solution. I'm trying to do this on Internet&nbsp;Explorer&nbsp;7  and later, WebKit, Gecko.  

See the jsfiddle <a href="http://jsfiddle.net/4RPFa/61/" rel="noreferrer">here</a>.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.frame {
    height: 25px;      /* Equals maximum image height */
    line-height: 25px;
    width: 160px;
    border: 1px solid red;

    text-align: center;
    margin: 1em 0;
}
img {
    background: #3A6F9A;
    vertical-align: middle;
    max-height: 25px;
    max-width: 160px;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class=frame&gt;
   &lt;img src="http://jsfiddle.net/img/logo.png" height=250 /&gt;
&lt;/div&gt;
&lt;div class=frame&gt;
   &lt;img src="http://jsfiddle.net/img/logo.png" height=25 /&gt;
&lt;/div&gt;
&lt;div class=frame&gt;
   &lt;img src="http://jsfiddle.net/img/logo.png" height=23 /&gt;
&lt;/div&gt;
&lt;div class=frame&gt;
   &lt;img src="http://jsfiddle.net/img/logo.png" height=21 /&gt;
&lt;/div&gt;
&lt;div class=frame&gt;
   &lt;img src="http://jsfiddle.net/img/logo.png" height=19 /&gt;
&lt;/div&gt;
&lt;div class=frame&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=17 /&gt;
&lt;/div&gt;
&lt;div class=frame&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=15 /&gt;
 &lt;/div&gt;
&lt;div class=frame&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=13 /&gt;
 &lt;/div&gt;
&lt;div class=frame&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=11 /&gt;
 &lt;/div&gt;
&lt;div class=frame&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=9 /&gt;
 &lt;/div&gt;
&lt;div class=frame&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=7 /&gt;
 &lt;/div&gt;
&lt;div class=frame&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=5 /&gt;
 &lt;/div&gt;
&lt;div class=frame&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=3 /&gt;
 &lt;/div&gt;</code></pre>
</div>
</div>


#### Answer accepted (score 2031)
The only (and the best cross-browser) way as I know is to use an `inline-block` helper with `height: 100%` and `vertical-align: middle` on both elements.  

So there is a solution: <a href="http://jsfiddle.net/kizu/4RPFa/4570/" rel="noreferrer">http://jsfiddle.net/kizu/4RPFa/4570/</a>  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
.frame {
    height: 25px;      /* Equals maximum image height */
    width: 160px;
    border: 1px solid red;
    white-space: nowrap; /* This is required unless you put the helper span closely near the img */

    text-align: center;
    margin: 1em 0;
}

.helper {
    display: inline-block;
    height: 100%;
    vertical-align: middle;
}

img {
    background: #3A6F9A;
    vertical-align: middle;
    max-height: 25px;
    max-width: 160px;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=250px /&gt;
&lt;/div&gt;
&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=25px /&gt;
&lt;/div&gt;
&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=23px /&gt;
&lt;/div&gt;
&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=21px /&gt;
&lt;/div&gt;
&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=19px /&gt;
&lt;/div&gt;
&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=17px /&gt;
&lt;/div&gt;
&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=15px /&gt;
&lt;/div&gt;
&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=13px /&gt;
&lt;/div&gt;
&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=11px /&gt;
&lt;/div&gt;
&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=9px /&gt;
&lt;/div&gt;
&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=7px /&gt;
&lt;/div&gt;
&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=5px /&gt;
&lt;/div&gt;
&lt;div class="frame"&gt;
    &lt;span class="helper"&gt;&lt;/span&gt;
    &lt;img src="http://jsfiddle.net/img/logo.png" height=3px /&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


Or, if you don't want to have an extra element in modern browsers and don't mind using Internet&nbsp;Explorer expressions, you can use a pseudo-element and add it to Internet&nbsp;Explorer using a convenient expression, that runs only once per element, so there won't be any performance issues:  

The solution with `:before` and `expression()` for Internet&nbsp;Explorer: <a href="http://jsfiddle.net/kizu/4RPFa/4571/" rel="noreferrer">http://jsfiddle.net/kizu/4RPFa/4571/</a>  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
.frame {
    height: 25px;      /* Equals maximum image height */
    width: 160px;
    border: 1px solid red;
    white-space: nowrap;

    text-align: center;
    margin: 1em 0;
}

.frame:before,
.frame_before {
    content: "";
    display: inline-block;
    height: 100%;
    vertical-align: middle;
}

img {
    background: #3A6F9A;
    vertical-align: middle;
    max-height: 25px;
    max-width: 160px;
}

/* Move this to conditional comments */
.frame {
    list-style:none;
    behavior: expression(
        function(t){
            t.insertAdjacentHTML('afterBegin','<span class="frame_before"></span>');
            t.runtimeStyle.behavior = 'none';
        }(this)
    );
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=250px /&gt;&lt;/div&gt;
&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=25px /&gt;&lt;/div&gt;
&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=23px /&gt;&lt;/div&gt;
&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=21px /&gt;&lt;/div&gt;
&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=19px /&gt;&lt;/div&gt;
&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=17px /&gt;&lt;/div&gt;
&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=15px /&gt;&lt;/div&gt;
&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=13px /&gt;&lt;/div&gt;
&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=11px /&gt;&lt;/div&gt;
&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=9px /&gt;&lt;/div&gt;
&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=7px /&gt;&lt;/div&gt;
&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=5px /&gt;&lt;/div&gt;
&lt;div class="frame"&gt;&lt;img src="http://jsfiddle.net/img/logo.png" height=3px /&gt;&lt;/div&gt;</code></pre>
</div>
</div>


<hr>

How it works:  

<ol>
<li><p>When you have two `inline-block` elements near each other, you can align each to other's side, so with `vertical-align: middle` you'll get something like this:</p>

<img src="https://i.stack.imgur.com/XIFPv.png" alt="Two aligned blocks">  </li>
<li><p>When you have a block with fixed height (in `px`, `em` or other absolute unit), you can set the height of inner blocks in `%`.</p></li>
<li>So, adding one `inline-block` with `height: 100%` in a block with fixed height would align another `inline-block` element in it (`&lt;img/&gt;` in your case) vertically near it.</li>
</ol>

#### Answer 2 (score 493)
This might be useful:   

```css
div {
    position: relative;
    width: 200px;
    height: 200px;
}
img {
    position: absolute;
    top: 0;
    bottom: 0;
    margin: auto;
}
.image {
    min-height: 50px
}
```

Reference: <a href="http://www.student.oulu.fi/~laurirai/www/css/middle/" rel="noreferrer">http://www.student.oulu.fi/~laurirai/www/css/middle/</a>  

#### Answer 3 (score 451)
<strong>matejkramny's solution is a good start, but oversized images have a wrong ratio.</strong>  

Here's my fork:  

Demo: <a href="https://jsbin.com/lidebapomi/edit?html,css,output" rel="noreferrer">https://jsbin.com/lidebapomi/edit?html,css,output</a>  

<img src="https://i.imgur.com/Fgh89yb.png" alt="preview">  

<hr/>

HTML:  

```css
<div class="frame">
  <img src="foo"/>
</div>
```

CSS:  

```css
.frame {
    height: 160px; /* Can be anything */
    width: 160px; /* Can be anything */
    position: relative;
}
img {
    max-height: 100%;
    max-width: 100%;
    width: auto;
    height: auto;
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How to apply a CSS filter to a background image (score [1462311](https://stackoverflow.com/q/20039765) in 2019)

#### Question
I have a JPEG file that I'm using as a background image for a search page, and I'm using CSS to set it because I'm working within <a href="https://en.wikipedia.org/wiki/Backbone.js">Backbone.js</a> contexts:  

```css
background-image: url("whatever.jpg");
```

I want to apply a CSS 3 blur filter <em>only</em> to the background, but I'm not sure how to style just that one element. If I try:  

```css
-webkit-filter: blur(5px);
-moz-filter: blur(5px);
-o-filter: blur(5px);
-ms-filter: blur(5px);
filter: blur(5px);
```

just underneath `background-image` in my CSS, it styles the whole page, rather than just the background. Is there a way to select just the image and apply the filter to that? Alternatively, is there a way to just turn the blur off for every other element on the page?  

#### Answer accepted (score 509)
Check out this <a href="http://codepen.io/aniketpant/pen/DsEve" rel="nofollow noreferrer">pen</a>.  

You will have to use two different containers, one for the background image and the other for your content.  

In the example, I have created two containers, `.background-image` and `.content`.  

Both of them are placed with `position: fixed` and `left: 0; right: 0;`. The difference in displaying them comes from the `z-index` values which have been set differently for the elements.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.background-image {
  position: fixed;
  left: 0;
  right: 0;
  z-index: 1;
  display: block;
  background-image: url('http://666a658c624a3c03a6b2-25cda059d975d2f318c03e90bcf17c40.r92.cf1.rackcdn.com/unsplash_527bf56961712_1.JPG');
  width: 1200px;
  height: 800px;
  -webkit-filter: blur(5px);
  -moz-filter: blur(5px);
  -o-filter: blur(5px);
  -ms-filter: blur(5px);
  filter: blur(5px);
}

.content {
  position: fixed;
  left: 0;
  right: 0;
  z-index: 9999;
  margin-left: 20px;
  margin-right: 20px;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="background-image"&gt;&lt;/div&gt;
&lt;div class="content"&gt;
  &lt;p&gt;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis aliquam erat in ante malesuada, facilisis semper nulla semper. Phasellus sapien neque, faucibus in malesuada quis, lacinia et libero. Sed sed turpis tellus. Etiam ac aliquam tortor, eleifend
    rhoncus metus. Ut turpis massa, sollicitudin sit amet molestie a, posuere sit amet nisl. Mauris tincidunt cursus posuere. Nam commodo libero quis lacus sodales, nec feugiat ante posuere. Donec pulvinar auctor commodo. Donec egestas diam ut mi adipiscing,
    quis lacinia mauris condimentum. Quisque quis odio venenatis, venenatis nisi a, vehicula ipsum. Etiam at nisl eu felis vulputate porta.&lt;/p&gt;
  &lt;p&gt;Fusce ut placerat eros. Aliquam consequat in augue sed convallis. Donec orci urna, tincidunt vel dui at, elementum semper dolor. Donec tincidunt risus sed magna dictum, quis luctus metus volutpat. Donec accumsan et nunc vulputate accumsan. Vestibulum
    tempor, erat in mattis fringilla, elit urna ornare nunc, vel pretium elit sem quis orci. Vivamus condimentum dictum tempor. Nam at est ante. Sed lobortis et lorem in sagittis. In suscipit in est et vehicula.&lt;/p&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


Apologies for the <em>Lorem Ipsum</em> Text.   

<h5>Update</h1>

Thanks to <a href="https://stackoverflow.com/users/266375/matthew-wilcoxson">Matthew Wilcoxson</a> for a better implementation using `.content:before` <a href="http://codepen.io/akademy/pen/FlkzB" rel="nofollow noreferrer">http://codepen.io/akademy/pen/FlkzB</a>  

#### Answer 2 (score 63)
<a href="http://codepen.io/anon/pen/GpvxBK" rel="noreferrer">pen</a>  

Abolishing the need for an extra element, along with making the content fit within the document flow rather than being fixed/absolute like other solutions.  

Achieved using  

```css
.content {
  overflow: auto;
  position: relative;
}
```

Overflow auto is needed, else the background will be offset by a few pixels at the top.  

After this you simply need  

```css
.content:before {
  content: "";
  position: fixed;
  left: 0;
  right: 0;
  z-index: -1;

  display: block;
  background-image: url('img-here');
  background-size:cover;
  width: 100%;
  height: 100%;

  -webkit-filter: blur(5px);
  -moz-filter: blur(5px);
  -o-filter: blur(5px);
  -ms-filter: blur(5px);
  filter: blur(5px);
}
```

<strong>EDIT</strong> If you are interested in removing the white borders at the edges, use a width and height of `110%` and a left and top of `-5%`. This will enlarge your backgrounds a tad - but there should be no solid colour bleeding in from the edges.   

Updated Pen here: <a href="https://codepen.io/anon/pen/QgyewB" rel="noreferrer">https://codepen.io/anon/pen/QgyewB</a> - Thanks Chad Fawcett for the suggestion.  

#### Answer 3 (score 48)
As stated in other answers this can be achieved with:  

<ul>
<li>A copy of the blurred image as the background.</li>
<li>A pseudo element that can be filtered then positioned behind the content.</li>
</ul>

<h5>You can also use <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter" rel="nofollow noreferrer">`backdrop-filter`</a></h2>

<p>There is a supported property called `backdrop-filter`, and it is currently 
supported in Chrome 76, <a href="https://wpdev.uservoice.com/forums/257854-microsoft-edge-developer/suggestions/9160189-backdrop-filters" rel="nofollow noreferrer">Edge</a>, Safari, and iOS Safari (see <a href="http://caniuse.com/#feat=css-backdrop-filter" rel="nofollow noreferrer">caniuse.com</a> for statistics).</p>

From <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/backdrop-filter" rel="nofollow noreferrer">Mozilla devdocs</a>:  

<blockquote>
  The backdrop-filter property provides for effects like blurring or color shifting the area behind an element, which can then be seen through that element by adjusting the element's transparency/opacity.  
</blockquote>

See <a href="http://caniuse.com/#feat=css-backdrop-filter" rel="nofollow noreferrer">caniuse.com</a> for usage statistics.  

You would use it like so:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.background-filter::after {
  -webkit-backdrop-filter: blur(5px); /* Use for Safari 9+, Edge 17+ (not a mistake) and iOS Safari 9.2+ */
  backdrop-filter: blur(5px); /* Supported in Chrome 76 */

  content: "";
  display: block;
  position: absolute;
  width: 100%; height: 100%;
}

.background-filter {
  position: relative;
}

.background {
  background-image: url('https://upload.wikimedia.org/wikipedia/en/6/62/Kermit_the_Frog.jpg');
  width: 200px;
  height: 200px;
}
```

<pre class="snippet-code-html lang-html prettyprint-override">`&lt;div class="background background-filter"&gt;&lt;/div&gt;`</pre>
</div>
</div>


<strong>Update (12/06/2019)</strong>: Chromium will ship with `backdrop-filter` enabled by default in version 76 which <a href="https://www.chromestatus.com/features/schedule" rel="nofollow noreferrer">is due out 30/07/2019</a>.  

<strong>Update (01/06/2019)</strong>: The Mozzilla Firefox team <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=1178765#c55" rel="nofollow noreferrer">has announced</a> it will start working on implementing this soon.  

<strong>Update (21/05/2019)</strong>: Chromium <a href="https://bugs.chromium.org/p/chromium/issues/detail?id=497522#c195" rel="nofollow noreferrer">just announced</a> `backdrop-filter` is available in chrome canary without enabling "Enable Experimental Web Platform Features" flag. This means `backdrop-filter` is very close to being implemented on all chrome platforms.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: Hide scroll bar, but while still being able to scroll (score [1456454](https://stackoverflow.com/q/16670931) in 2018)

#### Question
I want to be able to scroll through the whole page, but without the scrollbar being shown.  

In Google Chrome it's:  

```css
::-webkit-scrollbar { 
    display: none; 
}
```

But Mozilla Firefox and Internet Explorer don't seem to work like that.  

I also tried this in CSS:  

```css
overflow: hidden;
```

That does hide the scrollbar, but I can't scroll anymore.  

<p>Is there any way I can remove the scrollbar while still being able to scroll the whole page?
With just CSS or HTML, please.</p>

#### Answer accepted (score 720)
Just a test which is working fine.  

```css
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

```css
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

```css
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

```css
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

### 28: Resize image proportionally with CSS? (score [1398643](https://stackoverflow.com/q/787839) in 2018)

#### Question
Is there a way to resize (scale down) images proportionally using ONLY CSS?  

I'm doing the JavaScript way, but just trying to see if this is possible with CSS.  

#### Answer 2 (score 743)
To resize the image proportionally using CSS:  

```css
img.resize {
    width:540px; /* you can use % */
    height: auto;
}
```

#### Answer 3 (score 217)
Control size and maintain proportion :  

```css
#your-img {
    height: auto; 
    width: auto; 
    max-width: 300px; 
    max-height: 300px;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: How to vertically center a div for all browsers? (score [1394635](https://stackoverflow.com/q/396145) in 2018)

#### Question
I want to center a `div` vertically with CSS. I don't want tables or JavaScript, but only pure CSS. I found some solutions, but all of them are missing Internet Explorer 6 support.  

```css
<body>
    <div>Div to be aligned vertically</div>
</body>
```

How can I center a `div` vertically in all major browsers, including Internet Explorer 6?  

#### Answer accepted (score 1316)
Below is the best all-around solution I could build to vertically and horizontally center a fixed-width, <strong>flexible height</strong> content box. It was tested and working for recent versions of Firefox, Opera, Chrome, and Safari.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.outer {
  display: table;
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
}

.middle {
  display: table-cell;
  vertical-align: middle;
}

.inner {
  margin-left: auto;
  margin-right: auto;
  width: 400px;
  /*whatever width you want*/
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="outer"&gt;
  &lt;div class="middle"&gt;
    &lt;div class="inner"&gt;
      &lt;h1&gt;The Content&lt;/h1&gt;
      &lt;p&gt;Once upon a midnight dreary...&lt;/p&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


<a href="http://emergentweb.com/test/valign.html" rel="noreferrer">View A Working Example With Dynamic Content</a>  

I built in some dynamic content to test the flexibility and would love to know if anyone sees any problems with it. It should work well for centered overlays also -- lightbox, pop-up, etc.  

#### Answer 2 (score 268)
One more I can't see on the list:  

```css
.Center-Container {
  position: relative;
  height: 100%;
}

.Absolute-Center {
  width: 50%;
  height: 50%;
  overflow: auto;
  margin: auto;
  position: absolute;
  top: 0; left: 0; bottom: 0; right: 0;
  border: solid black;
}
```

<ul>
<li>Cross-browser (including Internet&nbsp;Explorer&nbsp;8 - Internet&nbsp;Explorer&nbsp;10 without hacks!)</li>
<li>Responsive with percentages and min-/max-</li>
<li>Centered regardless of padding (without box-sizing!)</li>
<li>`height` must be declared (see <a href="https://www.smashingmagazine.com/2013/08/absolute-horizontal-vertical-centering-css/#Height" rel="noreferrer">Variable Height</a>)</li>
<li>Recommended setting `overflow: auto` to prevent content spillover (see Overflow)</li>
</ul>

<sub>Source: <a href="https://www.smashingmagazine.com/2013/08/absolute-horizontal-vertical-centering-css" rel="noreferrer">Absolute Horizontal And Vertical Centering In CSS</a></sub>  

#### Answer 3 (score 224)
The simplest way would be the following <strong>3 lines</strong> of CSS:  

<strong>1) position: relative;</strong>  

<strong>2) top: 50%;</strong>  

<strong>3) transform: translateY(-50%);</strong>  

Following is an <strong>EXAMPLE</strong>:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
div.outer-div {
  height: 170px;
  width: 300px;
  background-color: lightgray;
}

div.middle-div {
  position: relative;
  top: 50%;
  -webkit-transform: translateY(-50%);
  -ms-transform: translateY(-50%);
  transform: translateY(-50%);
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class='outer-div'&gt;
  &lt;div class='middle-div'&gt;
    Test text
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 30: Vertically align text within a div (score [1388670](https://stackoverflow.com/q/9249359) in 2019)

#### Question
The code below (also available as <a href="http://jsfiddle.net/9Y7Cm/3/" rel="noreferrer">a demo on JS Fiddle</a>) does not position the text in the middle, as I ideally would like it to. I cannot find any way to vertically centre text in a `div`, even using the `margin-top` attribute. How can I do this?  



```css
<div id="column-content">
    <img src="http://i.stack.imgur.com/12qzO.png">
    <strong>1234</strong>
    yet another text content that should be centered vertically
</div>
```



```css
#column-content {
    display: inline-block;
    border: 1px solid red;
    position:relative;
}

#column-content strong {
    color: #592102;
    font-size: 18px;
}

img {
    margin-top:-7px;
    vertical-align: middle;        
}
```

#### Answer accepted (score 431)
Create a container for your text content, a `span` perhaps.  

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
```css
#column-content {
  display: inline-block;
}
img {
  vertical-align: middle;
}
span {
  display: inline-block;
  vertical-align: middle;
}

/* for visual purposes */
#column-content {
  border: 1px solid red;
  position: relative;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="column-content"&gt;

  &lt;img src="http://i.imgur.com/WxW4B.png"&gt;
  &lt;span&gt;&lt;strong&gt;1234&lt;/strong&gt;
    yet another text content that should be centered vertically&lt;/span&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


<a href="http://jsfiddle.net/9Y7Cm/5/">JSFiddle</a>  

#### Answer 2 (score 661)
Andres Ilich has it right. Just in case someone misses his comment...  

<strong>A.) If you only have one line of text:</strong>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
div
{
  height: 200px;
  line-height: 200px; /* <-- this is what you must define */
}
```

<pre class="snippet-code-html lang-html prettyprint-override">`&lt;div&gt;vertically centered text&lt;/div&gt;`</pre>
</div>
</div>


<strong>B.) If you have multiple lines of text:</strong>  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
div
{
  height: 200px;
  line-height: 200px;
}

span
{
  display: inline-block;
  vertical-align: middle;
  line-height: 18px; /* <-- adjust this */
}
```

<pre class="snippet-code-html lang-html prettyprint-override">`&lt;div&gt;&lt;span&gt;vertically centered text vertically centered text vertically centered text vertically centered text vertically centered text vertically centered text vertically centered text vertically centered text vertically centered text vertically centered text&lt;/span&gt;&lt;/div&gt;`</pre>
</div>
</div>


#### Answer 3 (score 218)
<strong>Update April 10, 2016</strong>  

Flexboxes should now be used to vertically (or even  horizontally) align items.  

```css
<div class="flex-container">
    <div class="flex-item">Item</div>
    <div class="flex-item">Item</div>
    <div class="flex-item">Item</div>
    <div class="flex-item">Item</div>
</div>

<style>
.flex-container {
    display: flex;
    align-items: center; /* Vertical center alignment */
    justify-content: center; /* Horizontal center alignment */
}
</style>
```

A good guide to flexbox can be read on <a href="https://css-tricks.com/snippets/css/a-guide-to-flexbox/" rel="noreferrer">CSS Tricks</a>. Thanks Ben (from comments) for pointing it out. I didn't have time to update.  

<hr>

A good guy named Mahendra posted a very working solution <a href="https://stackoverflow.com/questions/16629561/css-vertical-align-middle-not-working">here</a>.  

The following class should make the element horizontally and vertically centered to its parent.  

```css
.absolute-center {

    /* Internet Explorer 10 */
    display: -ms-flexbox;
    -ms-flex-pack: center;
    -ms-flex-align: center;

    /* Firefox */
    display: -moz-box;
    -moz-box-pack: center;
    -moz-box-align: center;

    /* Safari, Opera, and Chrome */
    display: -webkit-box;
    -webkit-box-pack: center;
    -webkit-box-align: center;

    /* W3C */
    display: box;
    box-pack: center;
    box-align: center;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: vertical-align with Bootstrap 3 (score [1388358](https://stackoverflow.com/q/20547819) in 2015)

#### Question
I'm using Twitter Bootstrap 3, and I have problems when I want to align vertically two `div`, for example — <a href="http://jsfiddle.net/corinem/CQstd/">JSFiddle link</a>:  

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;!-- Latest compiled and minified CSS --&gt;
&lt;link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"&gt;

&lt;!-- Optional theme --&gt;
&lt;link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css"&gt;

&lt;!-- Latest compiled and minified JavaScript --&gt;
&lt;script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"&gt;&lt;/script&gt;
&lt;div class="row"&gt;
  &lt;div class="col-xs-5"&gt;
    &lt;div style="height:5em;border:1px solid #000"&gt;Big&lt;/div&gt;
  &lt;/div&gt;
  &lt;div class="col-xs-5"&gt;
    &lt;div style="height:3em;border:1px solid #F00"&gt;Small&lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
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
```css
.vcenter {
    display: inline-block;
    vertical-align: middle;
    float: none;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="row"&gt;
    &lt;div class="col-xs-5 col-md-3 col-lg-1 vcenter"&gt;
        &lt;div style="height:10em;border:1px solid #000"&gt;Big&lt;/div&gt;
    &lt;/div&gt;&lt;!--
    --&gt;&lt;div class="col-xs-5 col-md-7 col-lg-9 vcenter"&gt;
        &lt;div style="height:3em;border:1px solid #F00"&gt;Small&lt;/div&gt;
    &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


<strong><a href="http://www.bootply.com/dFP81frbHk" rel="noreferrer">Bootply</a></strong>  

Using `inline-block` adds extra space between blocks if you let a real space in your code (like `...&lt;/div&gt; &lt;/div&gt;...`). This extra space breaks our grid if column sizes add up to 12:  

```css
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

```css
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

```css
<div class="container">
    <div class="row vertical-align"> <!--
                    ^--  Additional class -->
        <div class="col-xs-6"> ... </div>
        <div class="col-xs-6"> ... </div>
    </div>
</div>
```

```css
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

```css
/* Extra small devices (767px and down) */
@media (max-width: 767px) {
    .row.vertical-align {
        display: block; /* Turn off the flexible box layout */
    }
}
```

Or you could <a href="http://jsfiddle.net/hashem/g6puyohg/6/" rel="noreferrer">specify `.vertical-align` <strong>only</strong> on specific screen sizes</a> like so:  

```css
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

```css
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

```css
.vertical-align {
    display: flex;
    align-items: center;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: How do I make a placeholder for a 'select' box? (score [1375841](https://stackoverflow.com/q/5805059) in 2019)

#### Question
I'm using placeholders for text inputs which is working out just fine. But I'd like to use a placeholder for my selectboxes as well. Of course I can just use this code:  

```css
<select>
    <option value="">Select your option</option>
    <option value="hurr">Durr</option>
</select>
```

But the 'Select your option' is in black instead of lightgrey. So my solution could possibly be CSS-based. jQuery is fine too.  

This only makes the option grey in the dropdown (so after clicking the arrow):  

```css
option:first {
    color: #999;
}
```

The question is: How do people create placeholders in selectboxes? But it has already been answered, cheers.  

And using this results in the selected value always being grey (even after selecting a real option):  

```css
select {
    color: #999;
}
```

#### Answer accepted (score 2790)
A non-CSS - no JavaScript/jQuery answer:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;select&gt;
    &lt;option value="" disabled selected&gt;Select your option&lt;/option&gt;
    &lt;option value="hurr"&gt;Durr&lt;/option&gt;
&lt;/select&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 757)
I just stumbled across this question, and here's what works in Firefox and Chrome (at least):  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;style&gt;
select:invalid { color: gray; }
&lt;/style&gt;
&lt;form&gt;
&lt;select required&gt;
    &lt;option value="" disabled selected hidden&gt;Please Choose...&lt;/option&gt;
    &lt;option value="0"&gt;Open when powered (most valves do this)&lt;/option&gt;
    &lt;option value="1"&gt;Closed when powered, auto-opens when power is cut&lt;/option&gt;
&lt;/select&gt;
&lt;/form&gt;</code></pre>
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
```css
select:required:invalid {
  color: gray;
}
option[value=""][disabled] {
  display: none;
}
option {
  color: black;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;select required&gt;
  &lt;option value="" disabled selected&gt;Select something...&lt;/option&gt;
  &lt;option value="1"&gt;One&lt;/option&gt;
  &lt;option value="2"&gt;Two&lt;/option&gt;
&lt;/select&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 33: Transitions on the display: property (score [1340917](https://stackoverflow.com/q/3331353) in 2019)

#### Question
I'm currently designing a CSS 'mega dropdown' menu - basically a regular CSS-only dropdown menu, but one that contains different types of content.  

At the moment, <strong>it appears that CSS&nbsp;3 transitions don't apply to the 'display' property</strong>, i.e., you can't do any sort of transition from `display: none` to `display: block` (or any combination).  

Is there a way for the second-tier menu from the above example to 'fade in' when someone hovers over one of the top level menu items?  

I'm aware that you can use transitions on the `visibility:` property, but I can't think of a way to use that effectively.  

I've also tried using height, but that just failed miserably.  

I'm also aware that it's trivial to achieve this using JavaScript, but I wanted to challenge myself to use just CSS, and I think I'm coming up a little short.  

#### Answer accepted (score 1235)
You can concatenate two transitions or more, and `visibility` is what comes handy this time.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
div {
  border: 1px solid #eee;
}
div > ul {
  visibility: hidden;
  opacity: 0;
  transition: visibility 0s, opacity 0.5s linear;
}
div:hover > ul {
  visibility: visible;
  opacity: 1;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div&gt;
  &lt;ul&gt;
    &lt;li&gt;Item 1&lt;/li&gt;
    &lt;li&gt;Item 2&lt;/li&gt;
    &lt;li&gt;Item 3&lt;/li&gt;
  &lt;/ul&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


(Don't forget the vendor prefixes to the `transition` property.)  

More details are in <a href="http://www.greywyvern.com/?post=337" rel="noreferrer">this article</a>.  

#### Answer 2 (score 754)
You need to hide the element by other means in order to get this to work.  

I accomplished the effect by positioning both `&lt;div&gt;`s absolutely and setting the hidden one to `opacity: 0`.  

<strong>If you even toggle the `display` property from `none` to `block`, your transition on other elements will not occur.</strong>  

To work around this, always allow the element to be `display: block`, but hide the element by adjusting any of these means:  

<ol>
<li>Set the `height` to `0`.</li>
<li>Set the `opacity` to `0`.</li>
<li>Position the element outside of the frame of another element that has `overflow: hidden`.</li>
</ol>

There are likely more solutions, but you cannot perform a transition if you toggle the element to `display: none`. For example, you may attempt to try something like this:  

```css
div {
    display: none;
    transition: opacity 1s ease-out;
    opacity: 0;
}
div.active {
    opacity: 1;
    display: block;
}
```

But that will <strong>not</strong> work. From my experience, I have found this to do nothing.  

Because of this, you will always need to keep the element `display: block` - but you could get around it by doing something like this:  

```css
div {
    transition: opacity 1s ease-out;
    opacity: 0;
    height: 0;
    overflow: hidden;
}
div.active {
    opacity: 1;
    height: auto;
}
```

#### Answer 3 (score 257)
At the time of this post all major browsers disable CSS transitions if you try to change the `display` property, but CSS animations still work fine so we can use them as a workaround.  

<strong>Example Code</strong> (you can apply it to your menu accordingly) <a href="http://cssdesk.com/7WPCT" rel="nofollow noreferrer">Demo</a>:  

Add the following CSS to your stylesheet:  

```css
@-webkit-keyframes fadeIn {
    from { opacity: 0; }
      to { opacity: 1; }
}
@keyframes fadeIn {
    from { opacity: 0; }
      to { opacity: 1; }
}
```

Then apply the `fadeIn` animation to the child on parent hover (and of course set `display: block`):  

```css
.parent:hover .child {
    display: block;
    -webkit-animation: fadeIn 1s;
    animation: fadeIn 1s;
}
```

<hr>

<h5>Update 2019 - Method that also supports fading out:</h1>

(Some JavaScript code is required)  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
// We need to keep track of faded in elements so we can apply fade out later in CSS
document.addEventListener('animationstart', function (e) {
  if (e.animationName === 'fade-in') {
      e.target.classList.add('did-fade-in');
  }
});

document.addEventListener('animationend', function (e) {
  if (e.animationName === 'fade-out') {
      e.target.classList.remove('did-fade-in');
   }
});
```

```css
div {
    border: 5px solid;
    padding: 10px;
}

div:hover {
    border-color: red;
}

.parent .child {
  display: none;
}

.parent:hover .child {
  display: block;
  animation: fade-in 1s;
}

.parent:not(:hover) .child.did-fade-in {
  display: block;
  animation: fade-out 1s;
}

@keyframes fade-in {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes fade-out {
  from {
    opacity: 1;
  }
  to {
    opacity: 0;
  }
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="parent"&gt;
    Parent
    &lt;div class="child"&gt;
        Child
    &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 34: How to make div not larger than its contents? (score [1323786](https://stackoverflow.com/q/450903) in 2015)

#### Question
I have a layout similar to:  

```css
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

### 35: Bootstrap - Text-align class for inside a table (score [1319954](https://stackoverflow.com/q/12829608) in 2019)

#### Question
Is there a set of classes in Twitter's Bootstrap framework that aligns text?  

For example, I have some tables with `$` totals that I want aligned to the right...  

```css
<th class="align-right">Total</th>
```

and  

```css
<td class="align-right">$1,000,000.00</td>
```

#### Answer accepted (score 1369)
<h5>Bootstrap 3</h1>

<a href="http://getbootstrap.com/css/#type-alignment" rel="noreferrer">v3 Text Alignment Docs</a>  

```css
<p class="text-left">Left aligned text.</p>
<p class="text-center">Center aligned text.</p>
<p class="text-right">Right aligned text.</p>
<p class="text-justify">Justified text.</p>
<p class="text-nowrap">No wrap text.</p>
```

<a href="https://i.stack.imgur.com/DZHMg.png" rel="noreferrer"><img src="https://i.stack.imgur.com/DZHMg.png" alt="Bootstrap 3 text align example"></a>  

<h5>Bootstrap 4</h1>

<a href="http://v4-alpha.getbootstrap.com/utilities/typography/#text-alignment" rel="noreferrer">v4 Text Alignment Docs</a>  

```css
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

```css
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

```css
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

### 36: How to insert spaces/tabs in text using HTML/CSS (score [1265157](https://stackoverflow.com/q/9792849) in 2019)

#### Question
Possible ways:  

```css
<pre> ... </pre>
```

or  

```css
style="white-space:pre"
```

Anything else?  

#### Answer 2 (score 130)
To insert `tab space` between two words/sentences I usually use  

`&amp;emsp;` and  `&amp;ensp;`  

#### Answer 3 (score 108)
In cases wherein the width/height of the space is beyond `&amp;nbsp;` I usually use:  

For horizontal spacer:  

```css
<span style="display:inline-block; width: YOURWIDTH;"></span>
```

For vertical spacer:  

```css
<span style="display:block; height: YOURHEIGHT;"></span>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: How do I disable the resizable property of a textarea? (score [1259614](https://stackoverflow.com/q/5235142) in 2019)

#### Question
I want to disable the resizable property of a `textarea`.  

Currently, I can resize a `textarea` by clicking on the bottom right corner of the `textarea` and dragging the mouse. How can I disable this?  

<a href="https://i.stack.imgur.com/xrfWQ.png" rel="noreferrer"><img src="https://i.stack.imgur.com/xrfWQ.png" alt="Enter image description here"></a>  

#### Answer accepted (score 3331)
The following CSS rule disables resizing behavior for <a href="http://www.w3.org/wiki/HTML/Elements/textarea" rel="noreferrer">`textarea`</a> elements:  

```css
textarea {
  resize: none;
}
```

To disable it for some (but not all) `textarea`s, there are a <a href="http://www.electrictoolbox.com/disable-textarea-resizing-safari-chrome/" rel="noreferrer">couple of options</a>.  

To disable a specific `textarea` with the `name` attribute set to `foo` (i.e., `&lt;textarea name="foo"&gt;&lt;/textarea&gt;`):  

```css
textarea[name=foo] {
  resize: none;
}
```

Or, using an `id` attribute (i.e., `&lt;textarea id="foo"&gt;&lt;/textarea&gt;`):  

```css
#foo {
  resize: none;
}
```

The <a href="http://www.w3.org/TR/css3-ui/#resize" rel="noreferrer">W3C page</a> lists possible values for resizing restrictions: none, both, horizontal, vertical, and inherit:  

```css
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

```css
textarea {
    resize: none;
}
```

#### Answer 3 (score 102)
I found two things:  

First  

```css
textarea{resize: none}
```

This is a CSS&nbsp;3, <em>which is not released yet</em>, compatible with <a href="http://www.w3schools.com/cssref/css3_pr_resize.asp" rel="nofollow noreferrer"><strong>Firefox 4 (and later), Chrome, and Safari</strong></a>.  

Another format feature is to <a href="http://www.codingforums.com/showthread.php?t=85786" rel="nofollow noreferrer">`overflow: auto`</a> to get rid of the right scrollbar, taking into account the <a href="http://www.w3schools.com/tags/att_global_dir.asp" rel="nofollow noreferrer"><em>dir</em></a> attribute.  

<h5>Code and different browsers</h2>

<em>Basic HTML</em>  

```css
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

### 38: Retrieve the position (X,Y) of an HTML element (score [1258174](https://stackoverflow.com/q/442404) in 2013)

#### Question
I want to know how to get the X and Y position of HTML elements such as `img` and `div` in JavaScript.  

#### Answer 2 (score 1645)
The correct approach is to use <a href="https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect" rel="noreferrer">`element.getBoundingClientRect()`</a>:  

```css
var rect = element.getBoundingClientRect();
console.log(rect.top, rect.right, rect.bottom, rect.left);
```

Internet Explorer has supported this since as long as you are likely to care about and it was finally standardized in <a href="http://www.w3.org/TR/cssom-view/#the-getclientrects-and-getboundingclientrect-methods" rel="noreferrer">CSSOM Views</a>. All other browsers adopted it <a href="http://www.quirksmode.org/dom/w3c_cssom.html#t21" rel="noreferrer">a long time ago</a>.  

Some browsers also return height and width properties, though this is non-standard.  If you're worried about older browser compatibility, check this answer's revisions for an optimised degrading implementation.  

The values returned by `element.getBoundingClientRect()` are relative to the viewport.  If you need it relative to another element, simply subtract one rectangle from the other:  

```css
var bodyRect = document.body.getBoundingClientRect(),
    elemRect = element.getBoundingClientRect(),
    offset   = elemRect.top - bodyRect.top;

alert('Element is ' + offset + ' vertical pixels from <body>');
```

#### Answer 3 (score 307)
<p>The libraries go to some lengths to get accurate offsets for an element.<br>
here's a simple function that does the job in every circumstances that I've tried.</p>

```css
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

### 39: How to Vertical align elements in a div? (score [1237657](https://stackoverflow.com/q/79461) in 2018)

#### Question
I have a div with two images and an `h1`. All of them need to be vertically aligned within the div, next to each other.  

One of the images needs to be `absolute` positioned within the div.  

What is the CSS needed for this to work on all common browsers?  

```css
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

```css
.container {        
    display: flex;
    align-items: center;
}
```

Use the prefixed version if you also need to target Explorer 10, and old (&lt; 4.4) Android browsers:  

```css
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

```css
<div class="ext-box">
    <div class="int-box">
        <h2>Some txt</h2>
        <p>bla bla bla</p>
    </div>
</div>
```

CSS:  

```css
div.ext-box { display: table; width:100%;}
div.int-box { display: table-cell; vertical-align: middle; }
```

Obviously, whether you use a `.class` or an `#id`, the result won't change.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: Center image using text-align center? (score [1188789](https://stackoverflow.com/q/7055393) in 2013)

#### Question
Is the property `text-align: center;` a good way to center an image using CSS?  

```css
img {
    text-align: center;
}
```

#### Answer accepted (score 1044)
That will not work as the `text-align` property applies to block containers, not inline elements, and `img` is an inline element. See <a href="http://www.w3.org/TR/CSS21/text.html#alignment-prop" rel="noreferrer">the W3C specification</a>.  

Use this instead:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
img.center {
    display: block;
    margin: 0 auto;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div style="border: 1px solid black;"&gt;
&lt;img class="center" src ="https://cdn.sstatic.net/Sites/stackoverflow/company/img/logos/so/so-icon.png?v=c78bd457575a"&gt;

&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 110)
That doesn't always work... if it doesn't, try:  

```css
img {
    display: block;
    margin: 0 auto;
}
```

#### Answer 3 (score 84)
I came across <a href="http://hungred.com/how-to/tutorial-align-center-screen-position-absolute-css/" rel="nofollow noreferrer">this post</a>, and it worked for me:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
img {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div style="border: 1px solid black; position:relative; min-height: 200px"&gt;
  &lt;img src="https://cdn.sstatic.net/Sites/stackoverflow/company/img/logos/so/so-icon.png?v=c78bd457575a"&gt;

&lt;/div&gt;</code></pre>
</div>
</div>


(Vertical and horizontal alignment)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: Vertically align text next to an image? (score [1187180](https://stackoverflow.com/q/489340) in 2019)

#### Question
Why won't `vertical-align: middle` work?  And yet, `vertical-align: top` <em>does</em> work.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
span{
  vertical-align: middle;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div&gt;
  &lt;img src="http://lorempixel.com/30/30/" alt="small img" /&gt;
  &lt;span&gt;Doesn't work.&lt;/span&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer accepted (score 2146)
Actually, in this case it's quite simple: apply the vertical align to the image. Since it's all in one line, it's really the image you want aligned, not the text.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;!-- moved "vertical-align:middle" style from span to img --&gt;
&lt;div&gt;
  &lt;img style="vertical-align:middle" src="https://placehold.it/60x60"&gt;
  &lt;span style=""&gt;Works.&lt;/span&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


Tested in FF3.  

Now you can use flexbox for this type of layout.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.box {
   display: flex;
   align-items:center;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="box"&gt;
    &lt;img src="https://placehold.it/60x60"&gt;
    &lt;span style=""&gt;Works.&lt;/span&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 335)
Here are some simple techniques for vertical-align:  

<h5>One-line vertical-align:middle</h2>

This one is easy: set the line-height of the text element to equal that of the container  

```css
<div>
  <img style="width:30px; height:30px;">
  <span style="line-height:30px;">Doesn't work.</span>
</div>
```

<h5>Multiple-lines vertical-align:bottom</h2>

Absolutely position an inner div relative to its container  

```css
<div style="position:relative;width:30px;height:60px;">
  <div style="position:absolute;bottom:0">This is positioned on the bottom</div>
</div>
```

<h5>Multiple-lines vertical-align:middle</h2>

```css
<div style="display:table;width:30px;height:60px;">
  <div style="display:table-cell;height:30px;">This is positioned in the middle</div>
</div>
```

<h5>If you must support ancient versions of IE &lt;= 7</h2>

In order to get this to work correctly across the board, you'll have to hack the CSS a bit. Luckily, there is an IE bug that works in our favor. Setting `top:50%` on the container and `top:-50%` on the inner div, you can achieve the same result. We can combine the two using another feature IE doesn't support: advanced CSS selectors.  

```css
<style type="text/css">
  #container {
    width: 30px;
    height: 60px;
    position: relative;
  }
  #wrapper > #container {
    display: table;
    position: static;
  }
  #container div {
    position: absolute;
    top: 50%;
  }
  #container div div {
    position: relative;
    top: -50%;
  }
  #container > div {
    display: table-cell;
    vertical-align: middle;
    position: static;
  }
</style>

<div id="wrapper">
  <div id="container">
    <div><div><p>Works in everything!</p></div></div>
  </div>
</div>
```

<h5>Variable container height vertical-align:middle</h2>

This solution requires a slightly more modern browser than the other solutions, as it makes use of the `transform: translateY` property. (<a href="http://caniuse.com/#feat=transforms2d" rel="noreferrer">http://caniuse.com/#feat=transforms2d</a>)  

Applying the following 3 lines of CSS to an element will vertically centre it within its parent regardless of the height of the parent element:  

```css
position: relative;
top: 50%;
transform: translateY(-50%);
```

#### Answer 3 (score 91)
Change your `div` into a flex container:  

```css
div {display:flex;}
```

<p><br>
Now there are two methods to center the alignments for all the content:</p>

<strong>Method 1:</strong>  

```css
div {align-items:center;}
```

<strong><a href="http://jsfiddle.net/Mori/35oh5dfL/">DEMO</a></strong>    

<hr>

<strong>Method 2:</strong>  

```css
div * {margin-top:auto; margin-bottom:auto;}
```

<strong><a href="http://jsfiddle.net/Mori/Qtng7/">DEMO</a></strong>    

<hr>

Try different width and height values on the `img` and different font size values on the `span` and you'll see they always remain in the middle of the container.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How to disable a link using only CSS? (score [1144833](https://stackoverflow.com/q/2091168) in 2017)

#### Question
Is there any way to disable a link using CSS?  

I have a class called `current-page` and want links with this class to be disabled so that no action occurs when they are clicked.  

#### Answer accepted (score 1312)
The answer is already in the comments of the question. For more visibility, I am copying <a href="http://css-tricks.com/pointer-events-current-nav/" rel="noreferrer">this solution</a> here:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.not-active {
  pointer-events: none;
  cursor: default;
  text-decoration: none;
  color: black;
}
```

<pre class="snippet-code-html lang-html prettyprint-override">`&lt;a href="link.html" class="not-active"&gt;Link&lt;/a&gt;`</pre>
</div>
</div>


For browser support, please see <a href="https://caniuse.com/#feat=pointer-events" rel="noreferrer">https://caniuse.com/#feat=pointer-events</a>. If you need to support IE there is a workaround; see <a href="https://stackoverflow.com/a/10276157/1207195">this answer</a>.  

Warning: The use of <a href="https://developer.mozilla.org/en-US/docs/CSS/pointer-events" rel="noreferrer">`pointer-events`</a> in CSS for non-SVG elements is experimental. The feature used to be part of the CSS3 UI draft specification but, due to many open issues, has been postponed to CSS4.  

#### Answer 2 (score 133)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
.disabled {
  pointer-events: none;
  cursor: default;
  opacity: 0.6;
}
```

<pre class="snippet-code-html lang-html prettyprint-override">`&lt;a href="#" class="disabled"&gt;link&lt;/a&gt;`</pre>
</div>
</div>


#### Answer 3 (score 122)
CSS can only be used to change the style of something. The best you could probably do with pure CSS is to hide the link altogether.  

What you really need is some javascript. Here's how you'd do what you want using the jQuery library.  

```css
$('a.current-page').click(function() { return false; });
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Change navbar color in Twitter Bootstrap (score [1110481](https://stackoverflow.com/q/18529274) in 2018)

#### Question
How would I go about modifying the CSS to change the color of the navbar in Twitter Bootstrap?  

#### Answer accepted (score 1364)
<blockquote>
  <strong>tl;dr - <a href="http://work.smarchal.com/twbscolor/css/e74c3cc0392becf0f1ffbbbc0" rel="noreferrer">TWBSColor - Generate your own Bootstrap navbar</a></strong>  
  
  <p><strong>Version notes:</strong>
  - Online tool: Bootstrap 3.3.2+ / 4.0.0+
  - This answer: Bootstrap 3.0.x</p>
</blockquote>

<h5>Available navbars</h2>

You've got two basic navbars:  

<pre class="lang-html prettyprint-override"><code>&lt;!-- A light one --&gt;
&lt;nav class="navbar navbar-default" role="navigation"&gt;&lt;/nav&gt;
&lt;!-- A dark one --&gt;
&lt;nav class="navbar navbar-inverse" role="navigation"&gt;&lt;/nav&gt;
</code></pre>

<h5>Default color usage</h2>

Here are the main colors and their usage:  

<ul>
<li>`#F8F8F8`: navbar background</li>
<li>`#E7E7E7`: navbar border</li>
<li>`#777`: default color</li>
<li>`#333`: hover color (`#5E5E5E` for `.nav-brand`)</li>
<li>`#555`: active color</li>
<li>`#D5D5D5`: active background</li>
</ul>

<h5>Default style</h2>

If you want to put some custom style, here's the CSS you need to change:  

```css
/* navbar */
.navbar-default {
    background-color: #F8F8F8;
    border-color: #E7E7E7;
}
/* Title */
.navbar-default .navbar-brand {
    color: #777;
}
.navbar-default .navbar-brand:hover,
.navbar-default .navbar-brand:focus {
    color: #5E5E5E;
}
/* Link */
.navbar-default .navbar-nav > li > a {
    color: #777;
}
.navbar-default .navbar-nav > li > a:hover,
.navbar-default .navbar-nav > li > a:focus {
    color: #333;
}
.navbar-default .navbar-nav > .active > a,
.navbar-default .navbar-nav > .active > a:hover,
.navbar-default .navbar-nav > .active > a:focus {
    color: #555;
    background-color: #E7E7E7;
}
.navbar-default .navbar-nav > .open > a,
.navbar-default .navbar-nav > .open > a:hover,
.navbar-default .navbar-nav > .open > a:focus {
    color: #555;
    background-color: #D5D5D5;
}
/* Caret */
.navbar-default .navbar-nav > .dropdown > a .caret {
    border-top-color: #777;
    border-bottom-color: #777;
}
.navbar-default .navbar-nav > .dropdown > a:hover .caret,
.navbar-default .navbar-nav > .dropdown > a:focus .caret {
    border-top-color: #333;
    border-bottom-color: #333;
}
.navbar-default .navbar-nav > .open > a .caret,
.navbar-default .navbar-nav > .open > a:hover .caret,
.navbar-default .navbar-nav > .open > a:focus .caret {
    border-top-color: #555;
    border-bottom-color: #555;
}
/* Mobile version */
.navbar-default .navbar-toggle {
    border-color: #DDD;
}
.navbar-default .navbar-toggle:hover,
.navbar-default .navbar-toggle:focus {
    background-color: #DDD;
}
.navbar-default .navbar-toggle .icon-bar {
    background-color: #CCC;
}
@media (max-width: 767px) {
    .navbar-default .navbar-nav .open .dropdown-menu > li > a {
        color: #777;
    }
    .navbar-default .navbar-nav .open .dropdown-menu > li > a:hover,
    .navbar-default .navbar-nav .open .dropdown-menu > li > a:focus {
          color: #333;
    }
}
```

<h5>Custom colored navbar examples</h2>

Here are four examples of a custom colored navbar:  

<strong><a href="http://jsfiddle.net/zessx/drSbw/" rel="noreferrer">JSFiddle link</a></strong>  

<img src="https://i.stack.imgur.com/3qhkK.jpg" alt="Enter image description here">  

And the SCSS code:  

```css
$bgDefault   : #e74c3c;
$bgHighlight : #c0392b;
$colDefault  : #ecf0f1;
$colHighlight: #ffbbbc;
.navbar-default {
  background-color: $bgDefault;
  border-color: $bgHighlight;
  .navbar-brand {
    color: $colDefault;
    &:hover, &:focus {
      color: $colHighlight; }}
  .navbar-text {
    color: $colDefault; }
  .navbar-nav {
    > li {
      > a {
        color: $colDefault;
        &:hover,  &:focus {
          color: $colHighlight; }}}
    > .active {
      > a, > a:hover, > a:focus {
        color: $colHighlight;
        background-color: $bgHighlight; }}
    > .open {
      > a, > a:hover, > a:focus {
        color: $colHighlight;
        background-color: $bgHighlight; }}}
  .navbar-toggle {
    border-color: $bgHighlight;
    &:hover, &:focus {
      background-color: $bgHighlight; }
    .icon-bar {
      background-color: $colDefault; }}
  .navbar-collapse,
  .navbar-form {
    border-color: $colDefault; }
  .navbar-link {
    color: $colDefault;
    &:hover {
      color: $colHighlight; }}}
@media (max-width: 767px) {
  .navbar-default .navbar-nav .open .dropdown-menu {
    > li > a {
      color: $colDefault;
      &:hover, &:focus {
        color: $colHighlight; }}
    > .active {
      > a, > a:hover, > a:focus, {
        color: $colHighlight;
        background-color: $bgHighlight; }}}
}
```

<h5>And finally, a little gift</h2>

<p>I've just made a script which will allow you to generate your theme:
<strong><a href="http://work.smarchal.com/twbscolor/css/e74c3cc0392becf0f1ffbbbc0" rel="noreferrer">TWBSColor - Generate your own Bootstrap navbar</a></strong></p>

<p><em>[Update]: TWBSColor now generates SCSS/SASS/<a href="https://en.wikipedia.org/wiki/Less_%28stylesheet_language%29" rel="noreferrer">Less</a>/CSS code.</em> <br/>
<em>[Update]: From now, you can use Less as the default language provided by TWBSColor</em> <br/>
<em>[Update]: TWBSColor now supports drop down menus colorization</em><br>
<em>[Update]: TWBSColor now allows to choose your version (Bootstrap 4 support added)</em></p>

#### Answer 2 (score 194)
<strong><em>Updated 2018 for Bootstrap 4</em></strong>  

Changing the Navbar color is different (and a little easier) in Bootstrap 4. You can create a custom navbar class, and then reference it to change the navbar without impacting other Bootstrap navs..  

```css
<nav class="navbar navbar-custom">...</nav>
```

<hr>

<strong>Bootstrap 4.0</strong>  

The CSS required to change the Navbar is much less in Bootstrap 4...  

```css
.navbar-custom {
    background-color: #ff5500;
}
/* change the brand and text color */
.navbar-custom .navbar-brand,
.navbar-custom .navbar-text {
    color: rgba(255,255,255,.8);
}
/* change the link color */
.navbar-custom .navbar-nav .nav-link {
    color: rgba(255,255,255,.5);
}
/* change the color of active or hovered links */
.navbar-custom .nav-item.active .nav-link,
.navbar-custom .nav-item:hover .nav-link {
    color: #ffffff;
}
```

<a href="http://www.codeply.com/go/1ZFF5CEXM5/custom-navbar-color" rel="noreferrer">Bootstrap 4 Custom Navbar Demo</a><a href="https://i.stack.imgur.com/6cUsa.png" rel="noreferrer"><img src="https://i.stack.imgur.com/6cUsa.png" alt="enter image description here"></a>  

Changing the active/hover link <strong><em>background</em> color</strong> also works with the same CSS, but you must adjust the padding if you want the bg color to fill the full height of the link...  

`py-0` to remove vertical padding from the entire navbar...  

`&lt;nav class="navbar navbar-expand-sm navbar-custom py-0"&gt;..&lt;/nav&gt;`  

```css
/* change the link color and padding  */
.navbar-custom .navbar-nav .nav-link {
    color: rgba(255,255,255,.5);
    padding: .75rem 1rem;
}

/* change the color and background color of active links */
.navbar-custom .nav-item.active .nav-link,
.navbar-custom .nav-item:hover .nav-link {
    color: #ffffff;
    background-color: #333;
}
```

<a href="https://www.codeply.com/go/CzhP1QKxnW" rel="noreferrer">Bootstrap 4 Change Link and Background Color Demo</a>  

Also see: <a href="https://stackoverflow.com/questions/42586729/">Bootstrap 4 Change Hamburger Toggler Color</a>  

<hr>

<strong>Bootstrap 3</strong>  

```css
<nav class="navbar navbar-custom">
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">...
    </button>
    <a class="navbar-brand" href="#">Title</a>
  </div>
   ...
</nav>


.navbar-custom {
    background-color:#229922;
    color:#ffffff;
    border-radius:0;
}

.navbar-custom .navbar-nav > li > a {
    color:#fff;
}

.navbar-custom .navbar-nav > .active > a {
    color: #ffffff;
    background-color:transparent;
}

.navbar-custom .navbar-nav > li > a:hover,
.navbar-custom .navbar-nav > li > a:focus,
.navbar-custom .navbar-nav > .active > a:hover,
.navbar-custom .navbar-nav > .active > a:focus,
.navbar-custom .navbar-nav > .open >a {
    text-decoration: none;
    background-color: #33aa33;
}

.navbar-custom .navbar-brand {
    color:#eeeeee;
}
.navbar-custom .navbar-toggle {
    background-color:#eeeeee;
}
.navbar-custom .icon-bar {
    background-color:#33aa33;
}
```

<a href="http://bootply.com/78010" rel="noreferrer">Custom Navbar Demo on Bootply</a>  

<hr>

If the Navbar has dropdowns, add the following to change dropdown color(s):  

```css
/* for dropdowns only */
.navbar-custom .navbar-nav .dropdown-menu  { 
  background-color: #33aa33;
}
.navbar-custom .navbar-nav .dropdown-menu>li>a  { 
  color: #fff;
}
.navbar-custom .navbar-nav .dropdown-menu>li>a:hover,.navbar-custom .navbar-nav .dropdown-menu>li>a:focus  { 
  color: #33aa33;
}
```

<a href="http://www.bootply.com/Iq82PS84ZA" rel="noreferrer">Demo with Dropdown</a>  

<hr>

#### Answer 3 (score 49)
It took me a while, but I discovered that including the following was what made it possible to change the navbar color:  

```css
.navbar{ 
    background-image: none;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: How to apply CSS to iframe? (score [1101856](https://stackoverflow.com/q/217776) in 2014)

#### Question
I have a simple page that has some iframe sections (to display RSS links). How can I apply the same CSS format from the main page to the page displayed in the iframe?  

#### Answer 2 (score 418)
<strong>Edit:</strong> This does not work cross domain unless the appropriate <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS" rel="noreferrer">CORS header</a> is set.  

There are two different things here: the style of the iframe block and the style of the page embedded in the iframe. You can set the style of the iframe block the usual way:  

<pre class="lang-html prettyprint-override"><code>&lt;iframe name="iframe1" id="iframe1" src="empty.htm" 
        frameborder="0" border="0" cellspacing="0"
        style="border-style: none;width: 100%; height: 120px;"&gt;&lt;/iframe&gt;
</code></pre>

The style of the page embedded in the iframe must be either set by including it in the child page:  

```css
<link type="text/css" rel="Stylesheet" href="Style/simple.css" />
```

Or it can be loaded from the parent page with Javascript:  

```css
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

```css
$content = file_get_contents('https://www.google.com/calendar/embed?src=%23contacts%40group.v.calendar.google.com&ctz=America/Montreal');
```

Adding the path to your stylesheet:  

```css
$content = str_replace('</head>','<link rel="stylesheet" href="http://www.yourwebsiteurl.com/google.css" /></head>', $content);
```

(This will place your stylesheet last just before the `head` end tag.)  

Specify the base url form the original url in case css and js are called relatively:  

```css
$content = str_replace('</title>','</title><base href="https://www.google.com/calendar/" />', $content);
```

The final `google.php` file should look like this:  

```css
<?php
$content = file_get_contents('https://www.google.com/calendar/embed?src=%23contacts%40group.v.calendar.google.com&ctz=America/Montreal');
$content = str_replace('</title>','</title><base href="https://www.google.com/calendar/" />', $content);
$content = str_replace('</head>','<link rel="stylesheet" href="http://www.yourwebsiteurl.com/google.css" /></head>', $content);
echo $content;
```

Then you change the `iframe` embed code to:  

<pre class="lang-html prettyprint-override"><code>&lt;iframe src="http://www.yourwebsiteurl.com/google.php" style="border: 0" width="800" height="600" frameborder="0" scrolling="no"&gt;&lt;/iframe&gt;
</code></pre>

Good luck!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Space between two rows in a table? (score [1096005](https://stackoverflow.com/q/351058) in 2016)

#### Question
Is this possible via CSS?   

I'm trying   

```css
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
```css
/* Apply padding to td elements that are direct children of the tr elements with class spaceUnder. */

tr.spaceUnder>td {
  padding-bottom: 1em;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;table&gt;
  &lt;tbody&gt;
    &lt;tr&gt;
      &lt;td&gt;A&lt;/td&gt;
      &lt;td&gt;B&lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr class="spaceUnder"&gt;
      &lt;td&gt;C&lt;/td&gt;
      &lt;td&gt;D&lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
      &lt;td&gt;E&lt;/td&gt;
      &lt;td&gt;F&lt;/td&gt;
    &lt;/tr&gt;
  &lt;/tbody&gt;
&lt;/table&gt;</code></pre>
</div>
</div>


This should render somewhat like this:  

```css
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

```css
border-collapse:separate; 
border-spacing:5em;
```

<p>Plus a border declaration, and see if this achieves your desired effect.
Beware, though, that IE doesn't support the "separated borders" model.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: How do you easily horizontally center a \<div> using CSS? (score [1095138](https://stackoverflow.com/q/618097) in )

#### Question
I'm trying to horizontally center a `&lt;div&gt;` block element on a page and have it set to a minimum width. What is the simplest way to do this? I want the `&lt;div&gt;` element to be inline with rest of my page. I'll try to draw an example:  

```css
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
```css
#wrapper {
  background-color: green; /* for visualization purposes */
  text-align: center;
}
#yourdiv {
  background-color: red; /* for visualization purposes */
  display: inline-block;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="wrapper"&gt;    
    &lt;div id="yourdiv"&gt;Your text&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


Keep in mind that the width of `#yourdiv` is dynamic -> it will grow and shrink to accommodate the text inside it.  

You can check browser compatibility on <a href="http://caniuse.com/inline-block" rel="noreferrer">Caniuse</a>  

#### Answer 2 (score 564)
In most browsers this will work:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
div.centre {
  width: 200px;
  display: block;
  background-color: #eee;
  margin-left: auto;
  margin-right: auto;
}
```

<pre class="snippet-code-html lang-html prettyprint-override">`&lt;div class="centre"&gt;Some Text&lt;/div&gt;`</pre>
</div>
</div>


In IE6 you will need to add another outer `div`:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="layout"&gt;
  &lt;div class="centre"&gt;Some Text&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 3 (score 58)
```css
margin: 0 auto;
```

as <a href="https://stackoverflow.com/questions/618097/how-do-you-easily-horizontally-center-a-div-using-css/618104#618104">ck has said</a>, <a href="http://www.w3schools.com/CSS/pr_dim_min-width.asp" rel="noreferrer">min-width</a> is not supported by all browsers  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Changing the color of an hr element (score [1094306](https://stackoverflow.com/q/6382023) in 2018)

#### Question
I want to change the color of my `hr` tag using CSS. The code I've tried below doesn't seem to work:  

```css
hr {
    color: #123455;
}
```

#### Answer accepted (score 1093)
I think you should use `border-color` instead of `color`, if your intention is to change the color of the line produced by `&lt;hr&gt;` tag.  

Although, it has been pointed in comments that, if you change the size of your line, border will still be as wide as you specified in styles, and line will be filled with the default color (which is not a desired effect most of the time). So it seems like in this case you would also need to specify `background-color` (as @Ibu suggested in his answer).  

<strong>HTML 5 Boilerplate</strong> project in its default stylesheet <a href="https://github.com/paulirish/html5-boilerplate/blob/ef3c095bafa9a6fa9c771f368d4b30c8ce4deded/css/style.css#L75" rel="noreferrer">specifies</a> the following rule:  

```css
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

```css
hr { background-color: red; height: 1px; border: 0; }
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: Using CSS for a fade-in effect on page load (score [1067009](https://stackoverflow.com/q/11679567) in 2019)

#### Question
Can CSS transitions be used to allow a text paragraph to fade-in on page load?  

I really like how it looked on <a href="http://web.archive.org/web/20120728071954/http://www.dotmailapp.com/" rel="nofollow noreferrer">http://dotmailapp.com/</a> and would love to use a similar effect using CSS. The domain has since been purchased and no longer has the effect mentioned. An archived copy can be viewed <a href="http://web.archive.org/web/20120728071954/http://www.dotmailapp.com/" rel="nofollow noreferrer">on the Wayback Machine</a>.  

<h5>Illustration</h3>

Having this markup:  

<pre class="lang-html prettyprint-override"><code>&lt;div id="test"&gt;
    &lt;p&gt;​This is a test&lt;/p&gt;
&lt;/div&gt;​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
</code></pre>

With the following CSS rule:  

```css
#test p {
    opacity: 0;
    margin-top: 25px;
    font-size: 21px;
    text-align: center;
    -webkit-transition: opacity 2s ease-in;
    -moz-transition: opacity 2s ease-in;
    -o-transition: opacity 2s ease-in;
    -ms-transition: opacity 2s ease-in;
    transition: opacity 2s ease-in;
}​
```

How can the transition be triggered on load?  

#### Answer accepted (score 830)
<h5>Method 1:</h2>

If you are looking for a self-invoking transition then you should use <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/animation" rel="noreferrer">CSS&nbsp;3 Animations</a>. They aren't supported either, but this is exactly the kind of thing they were made for.  

<h5>CSS</h3>

```css
#test p {
    margin-top: 25px;
    font-size: 21px;
    text-align: center;

    -webkit-animation: fadein 2s; /* Safari, Chrome and Opera > 12.1 */
       -moz-animation: fadein 2s; /* Firefox < 16 */
        -ms-animation: fadein 2s; /* Internet Explorer */
         -o-animation: fadein 2s; /* Opera < 12.1 */
            animation: fadein 2s;
}

@keyframes fadein {
    from { opacity: 0; }
    to   { opacity: 1; }
}

/* Firefox < 16 */
@-moz-keyframes fadein {
    from { opacity: 0; }
    to   { opacity: 1; }
}

/* Safari, Chrome and Opera > 12.1 */
@-webkit-keyframes fadein {
    from { opacity: 0; }
    to   { opacity: 1; }
}

/* Internet Explorer */
@-ms-keyframes fadein {
    from { opacity: 0; }
    to   { opacity: 1; }
}

/* Opera < 12.1 */
@-o-keyframes fadein {
    from { opacity: 0; }
    to   { opacity: 1; }
}
```

<h5>Demo</h3>

<ul>
<li><a href="http://jsfiddle.net/SO_AMK/VV2ek/" rel="noreferrer">http://jsfiddle.net/SO_AMK/VV2ek/</a></li>
</ul>

<h5>Browser Support</h3>

All modern browsers and Internet&nbsp;Explorer&nbsp;10 (and later): <a href="http://caniuse.com/#feat=css-animation" rel="noreferrer">http://caniuse.com/#feat=css-animation</a>  

<br/>  

<h5>Method 2:</h2>

Alternatively, you can use jQuery (or plain JavaScript; see the third code block) to change the class on load:  

<h5>jQuery</h3>

```css
$("#test p").addClass("load");​
```

<h5>CSS</h3>

```css
#test p {
    opacity: 0;
    font-size: 21px;
    margin-top: 25px;
    text-align: center;

    -webkit-transition: opacity 2s ease-in;
       -moz-transition: opacity 2s ease-in;
        -ms-transition: opacity 2s ease-in;
         -o-transition: opacity 2s ease-in;
            transition: opacity 2s ease-in;
}

#test p.load {
    opacity: 1;
}
```

<h5>Plain JavaScript (not in the demo)</h3>

```css
document.getElementById("test").children[0].className += " load";
```

<h5>Demo</h3>

<ul>
<li><a href="http://jsfiddle.net/SO_AMK/a9dnW/" rel="noreferrer">http://jsfiddle.net/SO_AMK/a9dnW/</a></li>
</ul>

<h5>Browser Support</h3>

All modern browsers and Internet&nbsp;Explorer&nbsp;10 (and later): <a href="http://caniuse.com/#feat=css-transitions" rel="noreferrer">http://caniuse.com/#feat=css-transitions</a>  

<br />  

<h5>Method 3:</h2>

Or, you can use the method that <em>.Mail</em> uses:  

<h5>jQuery</h3>

```css
$("#test p").delay(1000).animate({ opacity: 1 }, 700);​
```

<h5>CSS</h3>

```css
#test p {
    opacity: 0;
    font-size: 21px;
    margin-top: 25px;
    text-align: center;
}
```

<h5>Demo</h3>

<ul>
<li><a href="http://jsfiddle.net/SO_AMK/a9dnW/3/" rel="noreferrer">http://jsfiddle.net/SO_AMK/a9dnW/3/</a></li>
</ul>

<h5>Browser Support</h3>

<p><strong>jQuery 1.x</strong>: All modern browsers and Internet&nbsp;Explorer&nbsp;6 (and later): <a href="http://jquery.com/browser-support/" rel="noreferrer">http://jquery.com/browser-support/</a>
<br />
<strong>jQuery 2.x</strong>: All modern browsers and Internet&nbsp;Explorer&nbsp;9 (and later): <a href="http://jquery.com/browser-support/" rel="noreferrer">http://jquery.com/browser-support/</a></p>

This method is the most cross-compatible as the target browser does not need to support CSS&nbsp;3 transitions <em>or</em> animations.  

#### Answer 2 (score 19)
You can use the `onload=""` HTML attribute and use JavaScript to adjust the opacity style of your element.  

Leave your CSS as you proposed. Edit your HTML code to:  

```css
<body onload="document.getElementById(test).style.opacity='1'">
    <div id="test">
        <p>​This is a test</p>
    </div>
</body>
```

<strong>This also works to fade-in the complete page when finished loading:</strong>  

HTML:  

```css
<body onload="document.body.style.opacity='1'">
</body>
```

CSS:  

```css
body{ 
    opacity: 0;
    transition: opacity 2s;
    -webkit-transition: opacity 2s; /* Safari */
}
```

Check the <a href="http://en.wikipedia.org/wiki/W3Schools" rel="nofollow noreferrer">W3Schools</a> website: <a href="http://www.w3schools.com/css/css3_transitions.asp" rel="nofollow noreferrer">transitions</a> and an article for <a href="http://www.w3schools.com/js/js_htmldom_css.asp" rel="nofollow noreferrer">changing styles with JavaScript</a>.  

#### Answer 3 (score 5)
In response to @A.M.K's question about how to do transitions without jQuery. A very simple example I threw together. If I had time to think this through some more, I might be able to eliminate the JavaScript code altogether:  

```css
<style>
    body {
        background-color: red;
        transition: background-color 2s ease-in;
    }
</style>

<script>
    window.onload = function() {
        document.body.style.backgroundColor = '#00f';
    }
</script>

<body>
    <p>test</p>
</body>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: How to center absolutely positioned element in div? (score [1065702](https://stackoverflow.com/q/1776915) in 2017)

#### Question
I need to place a `div` (with `position:absolute;`) element in the center of my window. But I am having problems doing so, because the <strong>width is unknown</strong>.  

I tried this. But it needs to be adjusted as the width is responsive.  

```css
.center {
  left: 50%;
  bottom:5px;
}
```

Any ideas?  

#### Answer accepted (score 1290)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;body&gt;
  &lt;div style="position: absolute; left: 50%;"&gt;
    &lt;div style="position: relative; left: -50%; border: dotted red 1px;"&gt;
      I am some centered shrink-to-fit content! &lt;br /&gt;
      tum te tum
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/body&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 1747)
This works for me:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
#content {
  position: absolute; 
  left: 0; 
  right: 0; 
  margin-left: auto; 
  margin-right: auto; 
  width: 100px; /* Need a specific value to work */
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;body&gt;
  &lt;div&gt;
    &lt;div id="content"&gt;
      I'm the content
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/body&gt;</code></pre>
</div>
</div>


#### Answer 3 (score 690)
<h5>Responsive Solution</h2>

Here is a good solution <strong>for responsive design or unknown dimensions</strong> in general <em>if you don't need to support IE8 and lower.</em>  

```css
.centered-axis-x {
    position: absolute;
    left: 50%;
    transform: translate(-50%, 0);
}
```

<p><div class="snippet" data-lang="js" data-hide="true" data-console="true" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
.outer {
    position: relative; /* or absolute */
    
    /* unnecessary styling properties */
    margin: 5%;
    width: 80%;
    height: 500px;
    border: 1px solid red;
}

.inner {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    
    /* unnecessary styling properties */
    max-width: 50%;
    text-align: center;
    border: 1px solid blue;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="outer"&gt;
    &lt;div class="inner"&gt;I'm always centered&lt;br/&gt;doesn't matter how much text, height or width i have.&lt;br/&gt;The dimensions or my parent are irrelevant as well&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


<a href="http://jsfiddle.net/6xo11zwv/2/" rel="noreferrer">Here is a JS Fiddle</a>  

The clue is, that `left: 50%` is relative to the parent while the `translate` transform is relative to the elements width/height.  

This way you have a perfectly centered element, with a flexible width on both child and parent. Bonus: this works even if the child is bigger than the parent.  

You can also center it vertically with this (and again, width and height of parent and child can be totally flexible (and/or unknown)):  

```css
.centered-axis-xy {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%,-50%);
}
```

Keep in mind that you might need `transform` vendor prefixed as well. For example `-webkit-transform: translate(-50%,-50%);`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: Font scaling based on width of container (score [1051157](https://stackoverflow.com/q/16056591) in 2019)

#### Question
I'm having a hard time getting my head around font scaling.  

I currently have <a href="http://www.haselden.co.uk/rttest/index.html" rel="noreferrer">this site</a> with a body `font-size` of 100%. 100% of what though? This seems to compute out at 16&nbsp;pixels.  

I was under the impression that 100% would somehow refer to the size of the browser window, but apparently not because it's always 16&nbsp;pixels whether the window is resized down to a mobile width or full blown widescreen desktop.  

How can I make the text on my site scale in relation to its container? I tried using `em`, but this doesn't scale either.  

My reasoning is that things like my menu become squished when you resize, so I need to reduce the `px` `font-size` of `.menuItem` among other elements in relation to the width of the container. (For example, in the menu on a large desktop, `22px` works perfectly. Move down to tablet width and `16px` is more appropriate.)  

I'm aware I can add breakpoints, but I really want the text to scale as <em>well</em> as having extra breakpoints, otherwise I'll end up with hundreds of breakpoints for every 100&nbsp;pixels decrease in width to control the text.  

#### Answer accepted (score 1382)
<strong>EDIT: If the container is not the body</strong> CSS Tricks covers all of your options in <em><a href="https://css-tricks.com/fitting-text-to-a-container/" rel="noreferrer">Fitting Text to a Container</a></em>.  

If the container is the body, what you are looking for is <a href="http://dev.w3.org/csswg/css-values/#viewport-relative-lengths" rel="noreferrer">Viewport-percentage lengths</a>:  

<blockquote>
  The <strong>viewport-percentage lengths</strong> are relative to the size of the <a href="https://www.w3.org/TR/CSS21/visudet.html#containing-block-details" rel="noreferrer">initial containing block</a>. When the height or width of the initial containing block is changed, they are scaled accordingly. However, when the value of overflow on the root element is auto, any scroll bars are assumed not to exist.  
</blockquote>

The values are:  

<ul>
<li>`vw` (% of the viewport width)</li>
<li>`vh` (% of the viewport height)</li>
<li>`vi` (1% of the viewport size in the direction of the root element's inline axis)</li>
<li>`vb` (1% of the viewport size in the direction of the root element's block axis)</li>
<li>`vmin` (the smaller of `vw` or `vh`)</li>
<li>`vmax` (the larger or `vw` or `vh`)</li>
</ul>

1 v* is equal to 1% of the initial containing block.  

Using it looks like this:  

```css
p {
    font-size: 4vw;
}
```

As you can see, when the viewport width increases, so does the font-size, without needing to use media queries.  

These values are a sizing unit, just like `px` or `em`, so they can be used to size other elements as well, such was width, margin, or padding.  

Browser support is pretty good, but you'll likely need a fallback, such as:  

```css
p {
    font-size: 16px;
    font-size: 4vw;
}
```

Check out the support statistics: <a href="http://caniuse.com/#feat=viewport-units" rel="noreferrer">http://caniuse.com/#feat=viewport-units</a>.  

Also, check out CSS-Tricks for a broader look: <em><a href="http://css-tricks.com/viewport-sized-typography/" rel="noreferrer">Viewport Sized Typography</a></em>  

Here's a nice article about setting minimum/maximum sizes and exercising a bit more control over the sizes: <em><a href="http://madebymike.com.au/writing/precise-control-responsive-typography/" rel="noreferrer">Precise control over responsive typography</a></em>  

And here's an article about setting your size using calc() so that the text fills the viewport: <a href="http://codepen.io/CrocoDillon/pen/fBJxu" rel="noreferrer">http://codepen.io/CrocoDillon/pen/fBJxu</a>  

Also, please view this article, which uses a technique dubbed 'molten leading' to adjust the line-height as well. <em><a href="https://css-tricks.com/molten-leading-css/" rel="noreferrer">Molten Leading in CSS</a></em>  

#### Answer 2 (score 301)
<h5>But what if the container is not the viewport (body)?</h2>

This question is asked in comment by Alex under <a href="https://stackoverflow.com/questions/16056591/font-scaling-based-on-width-of-container/19814948#19814948">the accepted answer</a>.  

That fact does not mean `vw` cannot be used to some extent to size for that container. Now to see any variation at all one has to be assuming that the container in some way is flexible in size. Whether through a direct percentage `width` or through being 100% minus margins. The point becomes "moot" if the container is always set to, let's say, `200px` wide--then just set a `font-size` that works for that width.  

<strong>Example 1</strong>  

With a flexible width container, however, it must be realized that in some way the container is <strong><em>still being sized off the viewport</em></strong>. As such, it is a matter of adjusting a `vw` setting based off that percentage size difference to the viewport, which means taking into account the sizing of parent wrappers. <a href="http://jsfiddle.net/T84wL/1/" rel="nofollow noreferrer"><strong>Take this example</strong></a>:  

```css
div {
    width: 50%;
    border: 1px solid black;
    margin: 20px;
    font-size: 16px;
    /* 100 = viewport width, as 1vw = 1/100th of that
       So if the container is 50% of viewport (as here)
       then factor that into how you want it to size.
       Let's say you like 5vw if it were the whole width,
       then for this container, size it at 2.5vw (5 * .5 [i.e. 50%])
    */
    font-size: 2.5vw;
}
```

Assuming here the `div` is a child of the `body`, it is `50%` of that `100%` width, which is the viewport size in this basic case. Basically, you want to set a `vw` that is going to look good to you. As you can see in my comment in the above CSS content, you can "think" through that mathematically with respect to the full viewport size, but you don't <em>need</em> to do that. The text is going to "flex" with the container, because the container is flexing with the viewport resizing. UPDATE: <a href="http://jsfiddle.net/T84wL/6/" rel="nofollow noreferrer">here's an example of two differently sized containers</a>.  

<strong>Example 2</strong>  

You can help ensure viewport sizing by forcing the calculation based off that. <a href="http://jsfiddle.net/T84wL/3/" rel="nofollow noreferrer"><strong>Consider this example</strong></a>:  

```css
html {width: 100%;} /* Force 'html' to be viewport width */
body {width: 150%; } /* Overflow the body */

div {
    width: 50%;
    border: 1px solid black;
    margin: 20px;
    font-size: 16px;
    /* 100 = viewport width, as 1vw = 1/100th of that
       Here, the body is 150% of viewport, but the container is 50%
       of viewport, so both parents factor  into how you want it to size.
       Let's say you like 5vw if it were the whole width,
       then for this container, size it at 3.75vw
       (5 * 1.5 [i.e. 150%]) * .5 [i.e. 50%]
    */
    font-size: 3.75vw;
}
```

The sizing is still based off viewport, but is in essence set up based off the container size itself.  

<h5>Should Sizing of the Container Change Dynamically...</h2>

If sizing of the container element ended up changing dynamically its percentage relationship either via `@media` break points or via JavaScript, then whatever the base "target" was would need recalculation to maintain the same "relationship" for text sizing.  

Take example #1 above. If the `div` was switched to `25%` width by either `@media` or JavaScript, then at the same time, the `font-size` would need to adjust in either the media query or by JavaScript to the new calculation of `5vw * .25 = 1.25`. This would put the text size at the same size it would have been had the "width" of the original `50%` container been reduced by half from viewport sizing, but has now been reduced due to a change in its own percentage calculation.  

<strong>A Challenge</strong>  

With <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/calc" rel="nofollow noreferrer">the CSS3 `calc()` function</a> in use, it would become difficult to adjust dynamically, as that function does not work for `font-size` purposes at this time. So you could not do a pure CSS&nbsp;3 adjustment if your width is changing on `calc()`. Of course, a minor adjustment of width for margins may not be enough to warrant any change in `font-size`, so it may not matter.  

#### Answer 3 (score 49)
Solution with SVG:  

```css
<div style="width: 60px;">  
  <svg width="100%" height="100%" viewBox="0 -200 1000 300"
     xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <text font-size="300" fill="black">Text</text>
  </svg>
</div>
```

<a href="https://jsfiddle.net/qc8ht5eb/" rel="noreferrer">https://jsfiddle.net/qc8ht5eb/</a>  

<hr>

Solution with SVG and text-wrapping using `foreignObject`:  

```css
<svg viewBox="0 0 100 100">
  <foreignObject width="100%" height="100%">
    <h1>heading</h1>

    lorem ipsum dolor sit amet
  </foreignObject>
</svg> 
```

<a href="https://jsfiddle.net/2rp1q0sy/" rel="noreferrer">https://jsfiddle.net/2rp1q0sy/</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: How can I position my div at the bottom of its container? (score [1043714](https://stackoverflow.com/q/526035) in 2017)

#### Question
Given the following HTML:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="container"&gt;
  &lt;!-- Other elements here --&gt;
  &lt;div id="copyright"&gt;
    Copyright Foo web designs
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
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
```css
#container {
    position: relative;
}
#copyright {
    position: absolute;
    bottom: 0;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="container"&gt;
  &lt;!-- Other elements here --&gt;
  &lt;div id="copyright"&gt;
    Copyright Foo web designs
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;body&gt;
    &lt;table id="container"&gt;
        &lt;tr&gt;
            &lt;td valign="top"&gt;
                &lt;div id="main"&gt;Lorem ipsum, etc.&lt;/div&gt;
            &lt;/td&gt;
        &lt;/tr&gt;
        &lt;tr&gt;
            &lt;td valign="bottom"&gt;
                &lt;div id="footer"&gt;Copyright some evil company...&lt;/div&gt;
            &lt;/td&gt;
        &lt;/tr&gt;
    &lt;/table&gt;
&lt;/body&gt;
&lt;/html&gt;</code></pre>
</div>
</div>


Try it out. This will work for any window size, for any amount of content, for any size footer, on every browser... even IE6.  

If you're cringing at the thought of using a table for layout, take a second to ask yourself why. CSS was supposed to make our lives easier -- and it has, overall -- but the fact is that even after all these years, it's still a broken, counter-intuitive mess. It can't solve every problem. It's incomplete.  

Tables aren't cool, but at least for now, they are sometimes the best way to solve a design problem.  

#### Answer 3 (score 139)
<h5>The flexbox approach!</h2>

In <a href="http://caniuse.com/#feat=flexbox" rel="noreferrer">supported browsers</a>, you can use the following:  

<a href="http://jsfiddle.net/bv1rs8s1/" rel="noreferrer"><strong>Example Here</strong></a>  



```css
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="parent"&gt;
  &lt;div class="child"&gt;Align to the bottom&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


<hr>

The solution above is probably more flexible, however, here is an alternative solution:  

<a href="http://jsfiddle.net/rh4Lc5dr/" rel="noreferrer"><strong>Example Here</strong></a>  

```css
.parent {
  display: flex;
}
.child {
  align-self: flex-end;
}
```

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="parent"&gt;
  &lt;div class="child"&gt;Align to the bottom&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


<hr>

As a side note, you may want to add vendor prefixes for additional support.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: Making a div vertically scrollable using CSS (score [1023998](https://stackoverflow.com/q/9707397) in 2015)

#### Question
This  

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override">`&lt;div id="" style="overflow:scroll; height:400px;"&gt;`</pre>
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
<pre class="snippet-code-html lang-html prettyprint-override">`&lt;div style="overflow-y: scroll; height:400px;"&gt;`</pre>
</div>
</div>


#### Answer 3 (score 110)
For 100% viewport height use:  

```css
overflow: auto;
max-height: 100vh;
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: Opacity of background-color, but not the text (score [1007381](https://stackoverflow.com/q/637921) in 2016)

#### Question
How do I make the cross-browser (including Internet Explorer 6) transparency for the background of a `div` while the text remains opaque?  

I need to do it without using any library such as jQuery, etc. (But if you know of a library that does it I'd love to know so I can look at their code).  

#### Answer accepted (score 595)
Use rgba!  

```css
.alpha60 {
    /* Fallback for web browsers that don't support RGBa */
    background-color: rgb(0, 0, 0);
    /* RGBa with 0.6 opacity */
    background-color: rgba(0, 0, 0, 0.6);
    /* For IE 5.5 - 7*/
    filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);
    /* For IE 8*/
    -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";
}
```

<blockquote>
  In addition to this, you have to declare `background: transparent` for IE web browsers, preferably served via conditional comments or similar!  
</blockquote>

via <a href="http://robertnyman.com/2010/01/11/css-background-transparency-without-affecting-child-elements-through-rgba-and-filters/" rel="noreferrer">http://robertnyman.com/2010/01/11/css-background-transparency-without-affecting-child-elements-through-rgba-and-filters/</a>  

#### Answer 2 (score 32)
I use an alpha-transparent PNG for that:  

```css
div.semi-transparent {
  background: url('semi-transparent.png');
}
```

For IE6, you'd need to use a PNG fix (<a href="http://unitinteractive.com/labs/unitpngfix.php" rel="noreferrer">1</a>, <a href="http://www.twinhelix.com/css/iepngfix/" rel="noreferrer">2</a>), though.  

#### Answer 3 (score 16)
I've created that effect on my blog <a href="http://landman-code.blogspot.com/" rel="noreferrer">Landman Code</a>.  

What I did was  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
#Header {
  position: relative;
}
#Header H1 {
  font-size: 3em;
  color: #00FF00;
  margin:0;
  padding:0;
}
#Header H2 {
  font-size: 1.5em;
  color: #FFFF00;
  margin:0;
  padding:0;
}
#Header .Background {
  background: #557700;
  filter: alpha(opacity=30);
  filter: progid: DXImageTransform.Microsoft.Alpha(opacity=30);
  -moz-opacity: 0.30;
  opacity: 0.3;
  zoom: 1;
}
#Header .Background * {
  visibility: hidden; // hide the faded text
}
#Header .Foreground {
  position: absolute; // position on top of the background div
  left: 0;
  top: 0;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="Header"&gt;
  &lt;div class="Background"&gt;
    &lt;h1&gt;Title&lt;/h1&gt;
    &lt;h2&gt;Subtitle&lt;/h2&gt;
  &lt;/div&gt;
  &lt;div class="Foreground"&gt;
    &lt;h1&gt;Title&lt;/h1&gt;
    &lt;h2&gt;Subtitle&lt;/h2&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


The important thing that every padding/margin and content must be the same in both the .Background as .Foreground.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: Remove stubborn underline from link (score [982128](https://stackoverflow.com/q/2789703) in 2019)

#### Question
I am attempting to have a link show up in white, without an underline. The text color shows up correctly as white, but the blue underline is stubbornly persisting. I tried `text-decoration: none;` and `text-decoration: none !important;` in the CSS to remove the link underline. Neither worked.   

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.boxhead .otherPage {
  color: #FFFFFF;
  text-decoration: none;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="boxhead"&gt;
  &lt;h2&gt;
    &lt;span class="thisPage"&gt;Current Page&lt;/span&gt;
    &lt;a href="myLink"&gt;&lt;span class="otherPage"&gt;Different Page&lt;/span&gt;&lt;/a&gt;
  &lt;/h2&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


How can I remove the blue underline from the link?  

#### Answer accepted (score 727)
As I expected, you are not applying `text-decoration: none;` to an anchor (`.boxhead a`) but to a span element (`.boxhead`).  

Try this:  

```css
.boxhead a {
    color: #FFFFFF;
    text-decoration: none;
}
```

#### Answer 2 (score 200)
The anchor tag (link) also has pseudo-classes such as visited, hover, link and active. Make sure your style is applied to the state(s) in question and that no other styles are conflicting.  

For example:  

```css
a:hover, a:visited, a:link, a:active
{
    text-decoration: none;
}
```

See <a href="https://www.w3.org/TR/css3-selectors/#useraction-pseudos" rel="noreferrer">W3.org</a> for more information on <strong>user action pseudo-classes :hover, :active, and :focus.</strong>  

#### Answer 3 (score 30)
`text-decoration: none !important` should remove it .. Are you sure there isn't a `border-bottom: 1px solid` lurking about? (Trace the computed style in Firebug/F12 in IE)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Align image in center and middle within div (score [975288](https://stackoverflow.com/q/4888223) in 2014)

#### Question
I have following div  

```css
<div id="over" style="position:absolute; width:100%; height:100%>
 <img src="img.png">
</div>
```

How to align the image so as to be located in the middle and center of div ?  

#### Answer 2 (score 388)
<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
body {
  margin: 0;
}

#over img {
  margin-left: auto;
  margin-right: auto;
  display: block;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="over" style="position:absolute; width:100%; height:100%"&gt;
  &lt;img src="http://www.garcard.com/images/garcard_symbol.png"&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


<a href="https://jsfiddle.net/Garconis/n3ooh4kt/" rel="noreferrer">JSFiddle</a>  

#### Answer 3 (score 158)
```css
<div style="display:table-cell; vertical-align:middle; text-align:center">
<img src="img.png">
</div>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: How to make a vertical line in HTML (score [967203](https://stackoverflow.com/q/3148415) in 2016)

#### Question
How do you make a vertical line using HTML?  

#### Answer accepted (score 523)
Put a `&lt;div&gt;` around the markup where you want the line to appear to next, and use CSS to style it:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.verticalLine {
  border-left: thick solid #ff0000;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="verticalLine"&gt;
  some other content
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 229)
You can use the horizontal rule tag to create vertical lines.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override">`&lt;hr width="1" size="500"&gt;`</pre>
</div>
</div>


By using minimal width and large size, horizontal rule becomes a vertical one.  

#### Answer 3 (score 68)
You can use an empty `&lt;div&gt;` that is styled exactly like you want the line to appear:  

<strong>HTML:</strong>  

<pre class="lang-html prettyprint-override"><code>&lt;div class="vertical-line"&gt;&lt;/div&gt;
</code></pre>

With exact height (overriding style in-line):  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
  div.vertical-line{
      width: 1px; /* Line width */
      background-color: black; /* Line color */
      height: 100%; /* Override in-line if you want specific height. */
      float: left; /* Causes the line to float to left of content. 
        You can instead use position:absolute or display:inline-block
        if this fits better with your design */
    }
```

<pre class="snippet-code-html lang-html prettyprint-override">`&lt;div class="vertical-line" style="height: 45px;"&gt;&lt;/div&gt;`</pre>
</div>
</div>


Style the border if you want 3D look:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
    div.vertical-line{
      width: 0px; /* Use only border style */
      height: 100%;
      float: left; 
      border: 1px inset; /* This is default border style for <hr> tag */
    }
```

<pre class="snippet-code-html lang-html prettyprint-override">`   &lt;div class="vertical-line" style="height: 45px;"&gt;&lt;/div&gt;`</pre>
</div>
</div>


You can of course also experiment with advanced combinations:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
  div.vertical-line{
      width: 1px;
      background-color: silver;
      height: 100%;
      float: left;
      border: 2px ridge silver ;
      border-radius: 2px;
    }
```

<pre class="snippet-code-html lang-html prettyprint-override">` &lt;div class="vertical-line" style="height: 45px;"&gt;&lt;/div&gt;`</pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 57: How can I remove a style added with .css() function? (score [956804](https://stackoverflow.com/q/4036857) in 2018)

#### Question
I'm changing CSS with jQuery and I wish to remove the styling I'm adding based on the input value:  

```css
if(color != '000000') $("body").css("background-color", color); else // remove style ?
```

How can I do this? Note that the line above runs whenever a color is selected using a color picker (ie. when mouse moves over a color wheel).  

2nd note: I can't do this with `css("background-color", "none")` because it will remove the default styling from the css files. I just want to remove the `background-color` inline style added by jQuery.  

#### Answer accepted (score 1284)
Changing the property to an empty string appears to do the job:  

```css
$.css("background-color", "");
```

#### Answer 2 (score 528)
<a href="https://stackoverflow.com/a/4036868/187606">The accepted answer</a> works but leaves an empty `style` attribute on the DOM in my tests. No big deal, but this removes it all:  

```css
removeAttr( 'style' );
```

This assumes you want to remove all dynamic styling and return back to the stylesheet styling.  

#### Answer 3 (score 167)
There are several ways to remove a CSS property using jQuery:  

<strong>1. Setting the CSS property to its default (initial) value</strong>  

```css
.css("background-color", "transparent")
```

<p>See the <a href="https://developer.mozilla.org/en/docs/CSS/background-color">initial value for the CSS property at MDN</a>.
Here the default value is `transparent`. You can also use <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/inherit">`inherit`</a> for several CSS properties to inherite the attribute from its parent. In CSS3/CSS4, you may also use <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/initial">`initial`</a>, <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/revert">`revert`</a> or <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/unset">`unset`</a> but these keywords may have limited browser support.</p>

<strong>2. Removing the CSS property</strong>  

An empty string removes the CSS property, i.e.  

```css
.css("background-color","")
```

But beware, as specified in <a href="http://api.jquery.com/css/#css2">jQuery .css() documentation</a>, this removes the property but it has compatibilty issues with IE8 for certain CSS shorthand properties, including <strong>background</strong>.  

<blockquote>
  <p>Setting the value of a style property to an empty string — e.g.
  $('#mydiv').css('color', '') — removes that property from an element
  if it has already been directly applied, whether in the HTML style
  attribute, through jQuery's .css() method, or through direct DOM
  manipulation of the style property. It does not, however, remove a
  style that has been applied with a CSS rule in a stylesheet or 
  element. Warning: <strong>one notable exception is that, for IE 8 and below,
  removing a shorthand property such as border or background will
  remove that style entirely from the element, regardless of what is set
  in a stylesheet or  element</strong>.</p>
</blockquote>

<strong>3. Removing the whole style of the element</strong>  

```css
.removeAttr("style")
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: How to write a:hover in inline CSS? (score [955832](https://stackoverflow.com/q/1033156) in 2017)

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

```css
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
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;a href="abc.html"
   onMouseOver="this.style.color='#0F0'"
   onMouseOut="this.style.color='#00F'" &gt;Text&lt;/a&gt;</code></pre>
</div>
</div>


Also, I can't remember for sure if `this` works in this context. You may have to switch it with `document.getElementById('idForLink')`.  

#### Answer 3 (score 51)
<p><a href="http://www.w3.org/TR/2002/WD-css-style-attr-20020515" rel="nofollow noreferrer">You could do it</a> at some point in the past. But now (according to the latest revision of the same standard, which is Candidate Recommendation) you can't
    .</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: Set the table column width constant regardless of the amount of text in its cells? (score [948281](https://stackoverflow.com/q/4457506) in 2017)

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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;table&gt;
  &lt;tr&gt;
    &lt;th&gt;header 1&lt;/th&gt;
    &lt;th&gt;header 234567895678657&lt;/th&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;data asdfasdfasdfasdfasdf&lt;/td&gt;
    &lt;td&gt;data 2&lt;/td&gt;
  &lt;/tr&gt;
&lt;/table&gt;</code></pre>
</div>
</div>


<a href="http://jsfiddle.net/itamark/uAKNx/" rel="noreferrer">Here it is in JSFiddle</a>  

This guy had a similar problem: <a href="https://stackoverflow.com/q/446624/534056">Table cell widths - fixing width, wrapping/truncating long words</a>  

#### Answer 2 (score 155)
<p>See:
<a href="http://www.html5-tutorials.org/tables/changing-column-width/" rel="noreferrer">http://www.html5-tutorials.org/tables/changing-column-width/</a></p>

After the table tag, use the col element. you don't need a closing tag.  

For example, if you had three columns:  

```css
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

```css
<td><div style="width: 50px" >...............</div></td>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: How to align checkboxes and their labels consistently cross-browsers (score [939259](https://stackoverflow.com/q/306252) in 2018)

#### Question
This is one of the minor CSS problems that plagues me constantly.  How do folks around Stack Overflow vertically align <strong><em>`checkboxes`</em></strong> and their <strong><em>`labels`</em></strong> consistently <strong>cross-browser</strong>?  Whenever I align them correctly in Safari (usually using `vertical-align: baseline` on the `input`), they're completely off in Firefox and IE.  Fix it in Firefox, and Safari and IE are inevitably messed up. I waste time on this every time I code a form.  

Here's the standard code that I work with:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;form&gt;
    &lt;div&gt;
        &lt;label&gt;&lt;input type="checkbox" /&gt; Label text&lt;/label&gt;
    &lt;/div&gt;
&lt;/form&gt;</code></pre>
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;form&gt;
  &lt;div&gt;
    &lt;label&gt;&lt;input type="checkbox" /&gt; Label text&lt;/label&gt;
  &lt;/div&gt;
&lt;/form&gt;</code></pre>
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;form&gt;
  &lt;div class="checkboxes"&gt;
    &lt;label for="x"&gt;&lt;input type="checkbox" id="x" /&gt; &lt;span&gt;Label text x&lt;/span&gt;&lt;/label&gt;
    &lt;label for="y"&gt;&lt;input type="checkbox" id="y" /&gt; &lt;span&gt;Label text y&lt;/span&gt;&lt;/label&gt;
    &lt;label for="z"&gt;&lt;input type="checkbox" id="z" /&gt; &lt;span&gt;Label text z&lt;/span&gt;&lt;/label&gt;
  &lt;/div&gt;
&lt;/form&gt;</code></pre>
</div>
</div>


Now, if you had a very long label text that <em>needed</em> to wrap without wrapping under the checkbox, you'd use padding and negative text indent on the label elements:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;form&gt;
  &lt;div class="checkboxes"&gt;
    &lt;label for="x"&gt;&lt;input type="checkbox" id="x" /&gt; &lt;span&gt;Label text x so long that it will probably wrap so let's see how it goes with the proposed CSS (expected: two lines are aligned nicely)&lt;/span&gt;&lt;/label&gt;
    &lt;label for="y"&gt;&lt;input type="checkbox" id="y" /&gt; &lt;span&gt;Label text y&lt;/span&gt;&lt;/label&gt;
    &lt;label for="z"&gt;&lt;input type="checkbox" id="z" /&gt; &lt;span&gt;Label text z&lt;/span&gt;&lt;/label&gt;
  &lt;/div&gt;
&lt;/form&gt;</code></pre>
</div>
</div>


#### Answer 3 (score 178)
Working off of <a href="https://stackoverflow.com/a/306593/1079573">One Crayon's solution</a>, I have something that works for me and is simpler:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.font2 {font-family:Arial; font-size:32px} /* Sample font */

input[type=checkbox], input[type=radio] {
  vertical-align: middle;
  position: relative;
  bottom: 1px;
}

input[type=radio] { 
  bottom: 2px; 
} 
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;label&gt;&lt;input type="checkbox" /&gt; Label text&lt;/label&gt;
&lt;p class="font2"&gt;
  &lt;label&gt;&lt;input type="checkbox"/&gt; Label text&lt;/label&gt;
&lt;/p&gt;</code></pre>
</div>
</div>


Renders pixel-for-pixel the same in Safari (whose baseline I trust) and both Firefox and IE7 check out as good.  It also works for various label font sizes, big and small. Now, for fixing IE's baseline on selects and inputs...  

<hr>

<strong>Update:</strong> (Third-Party Edit)  

The proper `bottom` position depends on font-family and font-size! I found using <strong>`bottom: .08em;`</strong> for checkbox &amp; radio elements is a good general value. I tested it in Chrome/Firefox/IE11 in windows with Arial &amp; Calibri fonts using several small/mid/large font-sizes.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.font2, .font2 input {font-family:Arial; font-size:32px} /* Sample font */

input[type=checkbox], input[type=radio] {
  vertical-align: middle; 
  position: relative;
  bottom: .08em; /* this is a better value for different fonts! */
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;label&gt;&lt;input type="checkbox" /&gt; Label text&lt;/label&gt; 

&lt;p class="font2"&gt;
  &lt;label&gt;&lt;input type="checkbox"/&gt; Label text&lt;/label&gt;
&lt;/p&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Responsive font size in CSS (score [931009](https://stackoverflow.com/q/15649244) in 2019)

#### Question
I've created a site using the <strong>Zurb Foundation 3</strong> grid. Each page has a large `h1`:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
body {
  font-size: 100%
}

/* Headers */

h1 {
  font-size: 6.2em;
  font-weight: 500;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="row"&gt;
  &lt;div class="twelve columns text-center"&gt;
    &lt;h1&gt; LARGE HEADER TAGLINE &lt;/h1&gt;
  &lt;/div&gt;
  &lt;!-- End Tagline --&gt;
&lt;/div&gt;
&lt;!-- End Row --&gt;</code></pre>
</div>
</div>


When I resize the browser to mobile size the large font doesn't adjust and causes the browser to include a horizontal scroll to accommodate for the large text.  

I've noticed that on the <strong>Zurb Foundation 3</strong> Typography <a href="http://foundation.zurb.com/sites/docs/v/3.2.5/typography.php" rel="noreferrer">example page</a>, the headers adapt to the browser as it is compressed and expanded.   

Am I missing something really obvious? How do I achieve this?  

#### Answer accepted (score 273)
The `font-size` won't respond like this when resizing the browser window. Instead they respond to the browser zoom/type size settings, such as if you press <kbd>Ctrl</kbd> and <kbd>+</kbd> together on the keyboard while in the browser.  

<strong>Media Queries</strong>  

You would have to look at using <a href="http://www.w3.org/TR/css3-mediaqueries/" rel="nofollow noreferrer">media queries</a> to reduce the font-size at certain intervals where it starts breaking your design and creating scrollbars.  

For example, try adding this inside your CSS at the bottom, changing the 320 pixels width for wherever your design starts breaking:  

```css
@media only screen and (max-width: 320px) {

   body { 
      font-size: 2em; 
   }

}
```

<strong>Viewport percentage lengths</strong>  

You can also use <a href="https://www.w3.org/TR/css3-values/#viewport-relative-lengths" rel="nofollow noreferrer">viewport percentage lengths</a> such as `vw`, `vh`, `vmin` and `vmax`. The official W3C document for this states:  

<blockquote>
  The viewport-percentage lengths are relative to the size of the initial containing block. When the height or width of the initial containing block is changed, they are scaled accordingly.  
</blockquote>

Again, from the same W3C document each individual unit can be defined as below:  

<blockquote>
  vw unit - Equal to 1% of the width of the initial containing block.  
  
  vh unit - Equal to 1% of the height of the initial containing block.   
  
  vmin unit - Equal to the smaller of vw or vh.   
  
  vmax unit - Equal to the larger of vw or vh.   
</blockquote>

And they are used in exactly the same way as any other CSS value:  

```css
.text {
  font-size: 3vw;
}

.other-text {
  font-size: 5vh;
}
```

Compatibility is relatively good as can be seen <a href="https://caniuse.com/#search=vw" rel="nofollow noreferrer">here</a>. However, some versions of Internet&nbsp;Explorer and Edge don’t support vmax. Also, iOS&nbsp;6 and 7 have an issue with the vh unit, which was fixed in iOS&nbsp;8.  

#### Answer 2 (score 608)
You can use the viewport value instead of ems, pxs, or pts:  

<blockquote>
  1vw = 1% of viewport width  
  
  1vh = 1% of viewport height  
  
  1vmin = 1vw or 1vh, whichever is smaller  
  
  1vmax = 1vw or 1vh, whichever is larger  
</blockquote>

```css
h1 {
  font-size: 5.9vw;
}
h2 {
  font-size: 3.0vh;
}
p {
  font-size: 2vmin;
}
```

From CSS-Tricks: <em><a href="http://css-tricks.com/viewport-sized-typography/" rel="nofollow noreferrer">Viewport Sized Typography</a></em>  

#### Answer 3 (score 36)
I've been playing around with ways to overcome this issue, and believe I have found a solution:  

If you can write your application for Internet&nbsp;Explorer&nbsp;9 (and later) and all other modern browsers that support CSS calc(), rem units, and vmin units. You can use this to achieve scalable text without media queries:  

```css
body {
  font-size: calc(0.75em + 1vmin);
}
```

Here it is in action: <a href="http://codepen.io/csuwldcat/pen/qOqVNO" rel="nofollow noreferrer">http://codepen.io/csuwldcat/pen/qOqVNO</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: How to make an image center (vertically & horizontally) inside a bigger div (score [929682](https://stackoverflow.com/q/388180) in 2016)

#### Question
I have a div 200 x 200 px. I want to place a 50 x 50 px image right in the middle of the div.   

How can it be done?  

I am able to get it centered horizontally by using `text-align: center` for the div. But vertical alignment is the issue..  

#### Answer accepted (score 320)
Personally, I'd place it as the background image within the div, the CSS for that being:  

```css
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

```css
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

```css
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

### 63: How can I transition height: 0; to height: auto; using CSS? (score [929463](https://stackoverflow.com/q/3508605) in 2017)

#### Question
I am trying to make a `&lt;ul&gt;` slide down using CSS transitions.  

The `&lt;ul&gt;` starts off at `height: 0;`. On hover, the height is set to `height:auto;`. However, this is causing it to simply appear, <em>not</em> transition,  

If I do it from `height: 40px;` to `height: auto;`, then it will slide up to `height: 0;`, and then suddenly jump to the correct height.  

How else could I do this without using JavaScript?  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
#child0 {
  height: 0;
  overflow: hidden;
  background-color: #dedede;
  -moz-transition: height 1s ease;
  -webkit-transition: height 1s ease;
  -o-transition: height 1s ease;
  transition: height 1s ease;
}
#parent0:hover #child0 {
  height: auto;
}
#child40 {
  height: 40px;
  overflow: hidden;
  background-color: #dedede;
  -moz-transition: height 1s ease;
  -webkit-transition: height 1s ease;
  -o-transition: height 1s ease;
  transition: height 1s ease;
}
#parent40:hover #child40 {
  height: auto;
}
h1 {
  font-weight: bold;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>The only difference between the two snippets of CSS is one has height: 0, the other height: 40.
&lt;hr&gt;
&lt;div id="parent0"&gt;
  &lt;h1&gt;Hover me (height: 0)&lt;/h1&gt;
  &lt;div id="child0"&gt;Some content
    &lt;br&gt;Some content
    &lt;br&gt;Some content
    &lt;br&gt;Some content
    &lt;br&gt;Some content
    &lt;br&gt;Some content
    &lt;br&gt;
  &lt;/div&gt;
&lt;/div&gt;
&lt;hr&gt;
&lt;div id="parent40"&gt;
  &lt;h1&gt;Hover me (height: 40)&lt;/h1&gt;
  &lt;div id="child40"&gt;Some content
    &lt;br&gt;Some content
    &lt;br&gt;Some content
    &lt;br&gt;Some content
    &lt;br&gt;Some content
    &lt;br&gt;Some content
    &lt;br&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer accepted (score 2555)
Use `max-height` in the transition and not `height`. And set a value on `max-height` to something bigger than your box will ever get.  

See <a href="http://jsfiddle.net/thechrisjordan/3Fc7D/23/" rel="nofollow noreferrer">JSFiddle demo</a> provided by Chris Jordan in another <a href="https://stackoverflow.com/a/20226830/18706">answer</a> here.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
#menu #list {
    max-height: 0;
    transition: max-height 0.15s ease-out;
    overflow: hidden;
    background: #d5d5d5;
}

#menu:hover #list {
    max-height: 500px;
    transition: max-height 0.25s ease-in;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="menu"&gt;
    &lt;a&gt;hover me&lt;/a&gt;
    &lt;ul id="list"&gt;
        &lt;!-- Create a bunch, or not a bunch, of li's to see the timing. --&gt;
        &lt;li&gt;item&lt;/li&gt;
        &lt;li&gt;item&lt;/li&gt;
        &lt;li&gt;item&lt;/li&gt;
        &lt;li&gt;item&lt;/li&gt;
        &lt;li&gt;item&lt;/li&gt;
    &lt;/ul&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 284)
You should use scaleY instead.  

HTML:  

```css
<p>Here (scaleY(1))</p>
<ul>
  <li>Coffee</li>
  <li>Tea</li>
  <li>Milk</li>
</ul>
```

CSS:  

```css
ul {
    background-color: #eee;
    transform: scaleY(0);    
    transform-origin: top;
    transition: transform 0.26s ease;
}

p:hover ~ ul {
    transform: scaleY(1);
}
```

I've made a vendor prefixed version of the above code on jsfiddle, <a href="http://jsfiddle.net/dotnetCarpenter/PhyQc/9/">http://jsfiddle.net/dotnetCarpenter/PhyQc/9/</a> and changed your jsfiddle to use scaleY instead of height, <a href="http://jsfiddle.net/dotnetCarpenter/7cnfc/206/">http://jsfiddle.net/dotnetCarpenter/7cnfc/206/</a>.  

#### Answer 3 (score 189)
You can't currently animate on height when one of the heights involved is `auto`, you have to set two explicit heights.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: Set cookie and get cookie with JavaScript (score [928603](https://stackoverflow.com/q/14573223) in 2018)

#### Question
I'm trying to set a cookie depending on which CSS file I choose in my HTML. I have a form with a list of options, and different CSS files as values. When I choose a file, it should be saved to a cookie for about a week. The next time you open your HTML file, it should be the previous file you've chosen.  

JavaScript code:  

```css
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

```css
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

```css
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

```css
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

```css
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

### 65: @Media min-width & max-width (score [921201](https://stackoverflow.com/q/13550541) in 2016)

#### Question
I have this `@media` setup:  

<strong>HTML</strong>:  

```css
<head>
  <meta name="viewport" content="width=device-width, user-scalable=no" />
</head>
```

<strong>CSS</strong>:  

```css
@media screen and (min-width: 769px) {
    /* STYLES HERE */
}

@media screen and (min-device-width: 481px) and (max-device-width: 768px) { 
    /* STYLES HERE */
}

@media only screen and (max-device-width: 480px) {
    /* STYLES HERE */
}
```

With this setup it works on the iPhone but it does not work in the browser.  

Is it because I already have `device` in the meta, and maybe have `max-width:480px` instead?  

#### Answer accepted (score 312)
I've found the best method is to write your default CSS for the older browsers, as older browsers including i.e. 5.5, 6, 7 and 8. Can't read @media. When I use @media I use it like this:  

```css
<style type="text/css">
    /* default styles here for older browsers. 
       I tend to go for a 600px - 960px width max but using percentages
    */
    @media only screen and (min-width: 960px) {
        /* styles for browsers larger than 960px; */
    }
    @media only screen and (min-width: 1440px) {
        /* styles for browsers larger than 1440px; */
    }
    @media only screen and (min-width: 2000px) {
        /* for sumo sized (mac) screens */
    }
    @media only screen and (max-device-width: 480px) {
       /* styles for mobile browsers smaller than 480px; (iPhone) */
    }
    @media only screen and (device-width: 768px) {
       /* default iPad screens */
    }
    /* different techniques for iPad screening */
    @media only screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait) {
      /* For portrait layouts only */
    }

    @media only screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape) {
      /* For landscape layouts only */
    }
</style>
```

But you can do whatever you like with your @media, This is just an example of what I've found best for me when building styles for all browsers.  

<a href="http://css-tricks.com/snippets/css/ipad-specific-css/" rel="noreferrer">iPad CSS specifications.</a>  

Also! If you're looking for printability you can use `@media print{}`  

#### Answer 2 (score 34)
The underlying issue is using `max-device-width` vs plain old `max-width`.   

Using the "device" keyword targets physical dimension of the screen, not the width of the browser window.  

For example:  

```css
@media only screen and (max-device-width: 480px) {
    /* STYLES HERE for DEVICES with physical max-screen width of 480px */
}
```

Versus  

```css
@media only screen and (max-width: 480px) {
    /* STYLES HERE for BROWSER WINDOWS with a max-width of 480px. 
       This will work on desktops when the window is narrowed.  */
}
```

#### Answer 3 (score 8)
The correct value for the `content` attribute should include `initial-scale` instead:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;meta name="viewport" content="width=device-width, initial-scale=1"&gt;
                                                   ^^^^^^^^^^^^^^^</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 66: CSS to make HTML page footer stay at bottom of the page with a minimum height, but not overlap the page (score [918389](https://stackoverflow.com/q/643879) in 2018)

#### Question
I had the following page (deadlink: `http://www.workingstorage.com/Sample.htm` ) that has a footer that I can't make sit at the bottom of the page.  

I want the footer to  

<ul>
<li>stick to the window bottom when the page is short and the screen is not filled, and</li>
<li>stay at the document end and move down as normal when there is more than a screenful of content (instead of overlapping the content).</li>
</ul>

The CSS is inherited and befuddles me; I can't seem to change it properly to put a minimum height on the content or make the footer go to the bottom.  

#### Answer accepted (score 320)
A simple method is to make the body `100%` of your page, with a `min-height` of `100%` too. This works fine if the height of your footer does not change.  

Give the footer a negative margin-top:  

```css
footer {
    clear: both;
    position: relative;
    height: 200px;
    margin-top: -200px;
}
```

#### Answer 2 (score 101)
<p>I've developed quite an easy method to stick the Footer at the bottom, but as most common methods, you will need to tweak it to fit your Footer's height.
<a href="http://codepen.io/vsync/pen/FyluI" rel="noreferrer"><h5>VIEW DEMO</h1></a></p>

<hr>

<h5>Flexbox method:</h2>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
html, body{ height:100%; margin:0; }
header{ height:50px; background:lightcyan; }
footer{ height:50px; background:PapayaWhip; }

/* Trick */
body{ 
  display:flex; 
  flex-direction:column; 
}

footer{
  margin-top:auto; 
}
 
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;body&gt;
  &lt;header&gt;Header&lt;/header&gt;
  &lt;article&gt;Content&lt;/article&gt;
  &lt;footer&gt;Footer&lt;/footer&gt;
&lt;/body&gt;</code></pre>
</div>
</div>


<hr>

This method below uses a "trick" by placing an `::after` pseudo-element on the `body`, and set it to have the <em>exact</em> height of the footer, so it will occupy the exact same space the footer does, so when the footer is `absolute` positioned over it, it would appear like the footer is really taking up space and eliminate the negative affects of it's absolute positioning (for example, going over the body's content)  

<h5>`position:absolute` method: (doesn't allow dynamic footer height)</h2>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
html{ height:100%; }
body{ min-height:100%; padding:0; margin:0; position:relative; }
header{ height:50px; background:lightcyan; }
footer{ background:PapayaWhip; }

/* Trick: */
body {
  position: relative;
}

body::after {
  content: '';
  display: block;
  height: 50px; /* Set same as footer's height */
}

footer {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 50px;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;body&gt;
  &lt;header&gt;Header&lt;/header&gt;
  &lt;article&gt;Content&lt;/article&gt;
  &lt;footer&gt;Footer&lt;/footer&gt;
&lt;/body&gt;</code></pre>
</div>
</div>


<hr>

<h5>Table-layout method:</h2>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
html,body { height: 100%;  margin: 0; }

header {
  height: 50px;
  background: lightcyan;
}

footer {
  height: 50px;
  background: PapayaWhip;
}


/**** Trick: ****/
body {
  display: table;
  width: 100%; 
}

footer {
   display: table-row;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;body&gt;
  &lt;header&gt;Header&lt;/header&gt;
  &lt;article&gt;Content&lt;/article&gt;
  &lt;footer&gt;Footer&lt;/footer&gt;
&lt;/body&gt;</code></pre>
</div>
</div>


#### Answer 3 (score 40)
A very simple approach which works great cross browser is this:  

<a href="http://matthewjamestaylor.com/blog/keeping-footers-at-the-bottom-of-the-page">http://matthewjamestaylor.com/blog/keeping-footers-at-the-bottom-of-the-page</a>  

<h5>HTML</h2>

```css
<div id="container">
   <div id="header"></div>
   <div id="body"></div>
   <div id="footer"></div>
</div>
```

<h5>CSS</h2>

```css
html,
body {
   margin:0;
   padding:0;
   height:100%;
}
#container {
   min-height:100%;
   position:relative;
}
#header {
   background:#ff0;
   padding:10px;
}
#body {
   padding:10px;
   padding-bottom:60px;   /* Height of the footer */
}
#footer {
   position:absolute;
   bottom:0;
   width:100%;
   height:60px;   /* Height of the footer */
   background:#6cf;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: How do you get centered content using Twitter Bootstrap? (score [918180](https://stackoverflow.com/q/9184141) in 2017)

#### Question
I'm trying to follow a very basic example.  Using the <a href="http://getbootstrap.com/css/#grid" rel="noreferrer">starter page and the grid system</a>, I was hoping the following:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="row"&gt;
  &lt;div class="span12"&gt;
    &lt;h1&gt;Bootstrap starter template&lt;/h1&gt;
    &lt;p&gt;Example text.&lt;/p&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
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

```css
<div class="span12 pagination-centered">
    Centered content.
</div>
```

Class `pagination-centered` is already in bootstrap.css (or bootstrap.min.css) and has the only one rule:  

```css
.pagination-centered{text-align:center;}
```

With <strong>Bootstrap 2.3.0.</strong> just use class `text-center`  

#### Answer 3 (score 151)
I guess most of the people here are actually searching for the way to <em>center the whole `div`</em> and not only the text content (which is trivial…).  

The second way (instead of using text-align:center) to center things in HTML is to have an element with a fixed width and auto margin (left and right). With Bootstrap, the style defining auto margins is the "container" class.  

```css
<div class="container">
    <div class="span12">
        "Centered stuff there"
    </div>
</div>
```

Take a look here for a fiddle: <a href="http://jsfiddle.net/D2RLR/7788/" rel="noreferrer">http://jsfiddle.net/D2RLR/7788/</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: How to line-break from css, without using <br />? (score [917036](https://stackoverflow.com/q/2703601) in 2018)

#### Question
<strong>output:</strong>  

hello <br> How are you   

<strong>code:</strong>  

```css
<p>hello <br> How are you </p>
```

How to achieve same output without `&lt;br&gt;`?  

#### Answer accepted (score 353)
Impossible with the same HTML structure, you must have something to distinguish between `Hello` and `How are you`.  

I suggest using `span`s that you will then display as blocks (just like a `&lt;div&gt;` actually).  

HTML:  

<pre class="lang-html prettyprint-override"><code>&lt;p&gt;&lt;span&gt;hello&lt;/span&gt;&lt;span&gt;How are you&lt;/span&gt;&lt;/p&gt;
</code></pre>

CSS:  

```css
p span 
{
    display: block;
}
```

#### Answer 2 (score 315)
You can use `white-space: pre;` to make elements act like `&lt;pre&gt;`, which preserves newlines.  Example:  

```css
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

```css
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

### 69: CSS selector for first element with class (score [913018](https://stackoverflow.com/q/2717480) in 2018)

#### Question
I have a bunch of elements with a class name `red`, but I can't seem to select the first element with the `class="red"` using the following CSS rule:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.red:first-child {
    border: 5px solid red;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;p class="red"&gt;&lt;/p&gt;
&lt;div class="red"&gt;&lt;/div&gt;</code></pre>
</div>
</div>


What is wrong in this selector and how do I correct it?  

Thanks to the comments, I figured out that the element has to be the first child of its parent to get selected which is not the case that I have. I have the following structure, and this rule fails as mentioned in the comments:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.home .red:first-child {
    border: 1px solid red;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="home"&gt;
    &lt;span&gt;blah&lt;/span&gt;
    &lt;p class="red"&gt;first&lt;/p&gt;
    &lt;p class="red"&gt;second&lt;/p&gt;
    &lt;p class="red"&gt;third&lt;/p&gt;
    &lt;p class="red"&gt;fourth&lt;/p&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


How can I target the first child with class `red`?  

#### Answer accepted (score 1335)
This is one of the most well-known examples of authors misunderstanding how `:first-child` works. <a href="http://www.w3.org/TR/CSS21/selector.html#first-child" rel="noreferrer">Introduced in CSS2</a>, the `:first-child` pseudo-class represents <strong>the very first child of its parent</strong>. That's it. There's a very common misconception that it picks up whichever child element is the first to match the conditions specified by the rest of the compound selector. Due to the way selectors work (see <a href="https://stackoverflow.com/questions/5545649/can-i-combine-nth-child-or-nth-of-type-with-an-arbitrary-selector/5546296#5546296">here</a> for an explanation), that is simply not true.  

<a href="http://www.w3.org/TR/css3-selectors/#first-of-type-pseudo" rel="noreferrer">Selectors level 3 introduces a `:first-of-type` pseudo-class</a>, which represents the first element among siblings of its element type. <a href="https://stackoverflow.com/questions/24657555/what-is-the-difference-between-first-child-and-first-of-type/24657721#24657721">This answer</a> explains, with illustrations, the difference between `:first-child` and `:first-of-type`. However, as with `:first-child`, it does not look at any other conditions or attributes. In HTML, the element type is represented by the tag name. In the question, that type is `p`.  

Unfortunately, there is no similar `:first-of-class` pseudo-class for matching the first child element of a given class. One workaround that <a href="https://stackoverflow.com/questions/5287272/css-select-first-element-with-a-certain-class/5293095#5293095">Lea Verou</a> and I came up with for this (albeit totally independently) is to first apply your desired styles to <em>all</em> your elements with that class:  

```css
/* 
 * Select all .red children of .home, including the first one,
 * and give them a border.
 */
.home > .red {
    border: 1px solid red;
}
```

... then "undo" the styles for elements with the class that <em>come after the first one</em>, using <a href="http://www.w3.org/TR/selectors/#general-sibling-combinators" rel="noreferrer">the general sibling combinator `~`</a> in an overriding rule:  

```css
/* 
 * Select all but the first .red child of .home,
 * and remove the border from the previous rule.
 */
.home > .red ~ .red {
    border: none;
}
```

Now only the first element with `class="red"` will have a border.  

Here's an illustration of how the rules are applied:  

<pre class="lang-html prettyprint-override"><code>&lt;div class="home"&gt;
  &lt;span&gt;blah&lt;/span&gt;         &lt;!-- [1] --&gt;
  &lt;p class="red"&gt;first&lt;/p&gt;  &lt;!-- [2] --&gt;
  &lt;p class="red"&gt;second&lt;/p&gt; &lt;!-- [3] --&gt;
  &lt;p class="red"&gt;third&lt;/p&gt;  &lt;!-- [3] --&gt;
  &lt;p class="red"&gt;fourth&lt;/p&gt; &lt;!-- [3] --&gt;
&lt;/div&gt;
</code></pre>

<ol>
<li><p><strong>No rules are applied; no border is rendered.</strong><br>
This element does not have the class `red`, so it's skipped.</p></li>
<li><p><strong>Only the first rule is applied; a red border is rendered.</strong><br>
This element has the class `red`, but it's not preceded by any elements with the class `red` in its parent. Thus the second rule is not applied, only the first, and the element keeps its border.</p></li>
<li><p><strong>Both rules are applied; no border is rendered.</strong><br>
This element has the class `red`. It is also preceded by at least one other element with the class `red`. Thus both rules are applied, and the second `border` declaration overrides the first, thereby "undoing" it, so to speak.</p></li>
</ol>

As a bonus, although it was introduced in Selectors 3, the general sibling combinator is actually pretty well-supported by IE7 and newer, unlike `:first-of-type` and `:nth-of-type()` which are only supported by IE9 onward. If you need good browser support, you're in luck.  

In fact, the fact that the sibling combinator is the only important component in this technique, <em>and</em> it has such amazing browser support, makes this technique very versatile — you can adapt it for filtering elements by other things, besides class selectors:  

<ul>
<li><p>You can use this to work around `:first-of-type` in IE7 and IE8, by simply supplying a type selector instead of a class selector (again, more on its incorrect usage here in a later section):</p>

```css
article > p {
    /* Apply styles to article > p:first-of-type, which may or may not be :first-child */
}

article > p ~ p {
    /* Undo the above styles for every subsequent article > p */
}
```
</li>
<li><p>You can filter by <a href="https://stackoverflow.com/questions/7128406/css-select-the-first-child-from-elements-with-particular-attribute/7128429#7128429">attribute selectors</a> or any other simple selectors instead of classes.</p></li>
<li><p>You can also combine this overriding technique with <a href="https://stackoverflow.com/questions/8535686/first-child-not-working/8535800#8535800">pseudo-elements</a> even though pseudo-elements technically aren't simple selectors.</p></li>
</ul>

Note that in order for this to work, you will need to know in advance what the default styles will be for your other sibling elements so you can override the first rule. Additionally, since this involves overriding rules in CSS, you can't achieve the same thing with a single selector for use with the <a href="http://www.w3.org/TR/selectors-api" rel="noreferrer">Selectors API</a>, or <a href="http://seleniumhq.org" rel="noreferrer">Selenium</a>'s CSS locators.  

It's worth mentioning that Selectors 4 introduces <a href="http://dev.w3.org/csswg/selectors-4/#the-nth-child-pseudo" rel="noreferrer">an extension to the `:nth-child()` notation</a> (originally an entirely new pseudo-class called `:nth-match()`), which will allow you to use something like `:nth-child(1 of .red)` in lieu of a hypothetical `.red:first-of-class`. Being a relatively recent proposal, there aren't enough interoperable implementations for it to be usable in production sites yet. Hopefully this will change soon. In the meantime, the workaround I've suggested should work for most cases.  

Keep in mind that this answer assumes that the question is looking for every first child element that has a given class. There is neither a pseudo-class nor even a generic CSS solution for the nth match of a complex selector <em>across the entire document</em> — whether a solution exists depends heavily on the document structure. jQuery provides `:eq()`, `:first`, `:last` and more for this purpose, but note again that <a href="https://stackoverflow.com/questions/9983297/difference-between-css-selector-and-jquery-filter/10835694#10835694">they function very differently from `:nth-child()` et al</a>. Using the Selectors API, you can either use `document.querySelector()` to obtain the very first match:  

```css
var first = document.querySelector('.home > .red');
```

Or use `document.querySelectorAll()` with an indexer to pick any specific match:  

```css
var redElements = document.querySelectorAll('.home > .red');
var first = redElements[0];
var second = redElements[1];
// etc
```

<hr>

Although the `.red:nth-of-type(1)` solution in the original accepted answer by <a href="https://stackoverflow.com/questions/2717480/css-selector-for-first-element-with-class/2717515#2717515">Philip Daubmeier</a> works (which was originally written by <a href="https://stackoverflow.com/users/264276/martyn">Martyn</a> but deleted since), it does not behave the way you'd expect it to.  

For example, if you only wanted to select the `p` in your original markup:  

<pre class="lang-html prettyprint-override"><code>&lt;p class="red"&gt;&lt;/p&gt;
&lt;div class="red"&gt;&lt;/div&gt;
</code></pre>

... then you can't use `.red:first-of-type` (equivalent to `.red:nth-of-type(1)`), because each element is the first (and only) one of its type (`p` and `div` respectively), so <em>both</em> will be matched by the selector.  

When the first element of a certain class <em>is also the first of its type</em>, the pseudo-class will work, but <strong>this happens only by coincidence</strong>. This behavior is demonstrated in Philip's answer. The moment you stick in an element of the same type before this element, the selector will fail. Taking the updated markup:  

<pre class="lang-html prettyprint-override"><code>&lt;div class="home"&gt;
  &lt;span&gt;blah&lt;/span&gt;
  &lt;p class="red"&gt;first&lt;/p&gt;
  &lt;p class="red"&gt;second&lt;/p&gt;
  &lt;p class="red"&gt;third&lt;/p&gt;
  &lt;p class="red"&gt;fourth&lt;/p&gt;
&lt;/div&gt;
</code></pre>

Applying a rule with `.red:first-of-type` will work, but once you add another `p` without the class:  

<pre class="lang-html prettyprint-override"><code>&lt;div class="home"&gt;
  &lt;span&gt;blah&lt;/span&gt;
  &lt;p&gt;dummy&lt;/p&gt;
  &lt;p class="red"&gt;first&lt;/p&gt;
  &lt;p class="red"&gt;second&lt;/p&gt;
  &lt;p class="red"&gt;third&lt;/p&gt;
  &lt;p class="red"&gt;fourth&lt;/p&gt;
&lt;/div&gt;
</code></pre>

... the selector will immediately fail, because the first `.red` element is now the <em>second</em> `p` element.  

#### Answer 2 (score 317)
The `:first-child` selector is intended, like the name says, to select the first child of a parent tag. The children have to be embedded in the same parent tag. Your exact example will work (Just tried it <a href="http://www.w3schools.com/css/tryit.asp?filename=trycss_first-child1" rel="noreferrer">here</a>):  



<pre class="lang-html prettyprint-override"><code>&lt;body&gt;
    &lt;p class="red"&gt;first&lt;/p&gt;
    &lt;div class="red"&gt;second&lt;/div&gt;
&lt;/body&gt;
</code></pre>

Maybe you have nested your tags in different parent tags? Are your tags of class `red` really the first tags under the parent?  

Notice also that this doesnt only apply to the first such tag in the whole document, but everytime a new parent is wrapped around it, like:  

<pre class="lang-html prettyprint-override"><code>&lt;div&gt;
    &lt;p class="red"&gt;first&lt;/p&gt;
    &lt;div class="red"&gt;second&lt;/div&gt;
&lt;/div&gt;
&lt;div&gt;
    &lt;p class="red"&gt;third&lt;/p&gt;
    &lt;div class="red"&gt;fourth&lt;/div&gt;
&lt;/div&gt;
</code></pre>

`first` and `third` will be red then.  

<strong>Update:</strong>  

I dont know why martyn deleted his answer, but he had the solution, the `:nth-of-type` selector:  

<pre class="lang-html prettyprint-override"><code>&lt;html&gt;
&lt;head&gt;
&lt;style type="text/css"&gt;
.red:nth-of-type(1)
{
    border:5px solid red;
} 
&lt;/style&gt;
&lt;/head&gt;

&lt;body&gt;
    &lt;div class="home"&gt;
        &lt;span&gt;blah&lt;/span&gt;
        &lt;p class="red"&gt;first&lt;/p&gt;
        &lt;p class="red"&gt;second&lt;/p&gt;
        &lt;p class="red"&gt;third&lt;/p&gt;
        &lt;p class="red"&gt;fourth&lt;/p&gt;
    &lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;
</code></pre>

Credits to <a href="https://stackoverflow.com/users/264276/martyn">Martyn</a>. More infos for example <a href="http://www.quirksmode.org/css/nthchild.html" rel="noreferrer">here</a>. Be aware that this is a CSS 3 selector, therefore not all browsers will recognize it (e.g. IE8 or older).  

#### Answer 3 (score 70)
The correct answer is:  

```css
.red:first-child, :not(.red) + .red { border:5px solid red }
```

<p>Part I: If element is first to its parent and has class "red", it shall get border.<br>
Part II: If ".red" element is not first to its parent, but is immediately following an element without class ".red", it shall also deserve the honor of said border.</p>

<a href="http://jsfiddle.net/Vq8PB/7/" rel="noreferrer">Fiddle or it didn't happen.</a>  

<p>Philip Daubmeier's answer, while accepted, is not correct - see attached fiddle.<br>
BoltClock's answer would work, but unnecessarily defines and overwrites styles<br>
(particularly an issue where it otherwise would inherit a different border - you don't want to declare other to border:none)</p>

<p>EDIT:
In the event that you have "red" following non-red several times, each "first" red will get the border. To prevent that, one would need to use BoltClock's answer. See <a href="http://jsfiddle.net/Vq8PB/8/" rel="noreferrer">fiddle</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: Make a div fill the height of the remaining screen space (score [891472](https://stackoverflow.com/q/90178) in 2019)

#### Question
I am working on a web application where I want the content to fill the height of the entire screen.  

The page has a header, which contains a logo, and account information. This could be an arbitrary height. I want the content div to fill the rest of the page to the bottom.  

I have a header `div` and a content `div`. At the moment I am using a table for the layout like so:  

CSS and HTML  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
#page {
    height: 100%; width: 100%
}

#tdcontent {
    height: 100%;
}

#content {
    overflow: auto; /* or overflow: hidden; */
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;table id="page"&gt;
    &lt;tr&gt;
        &lt;td id="tdheader"&gt;
            &lt;div id="header"&gt;...&lt;/div&gt;
        &lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
        &lt;td id="tdcontent"&gt;
            &lt;div id="content"&gt;...&lt;/div&gt;
        &lt;/td&gt;
    &lt;/tr&gt;
&lt;/table&gt;</code></pre>
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;!-- Obviously, you could use HTML5 tags like `header`, `footer` and `section` --&gt;

&lt;div class="box"&gt;
  &lt;div class="row header"&gt;
    &lt;p&gt;&lt;b&gt;header&lt;/b&gt;
      &lt;br /&gt;
      &lt;br /&gt;(sized to content)&lt;/p&gt;
  &lt;/div&gt;
  &lt;div class="row content"&gt;
    &lt;p&gt;
      &lt;b&gt;content&lt;/b&gt;
      (fills remaining space)
    &lt;/p&gt;
  &lt;/div&gt;
  &lt;div class="row footer"&gt;
    &lt;p&gt;&lt;b&gt;footer&lt;/b&gt; (fixed height)&lt;/p&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


In the CSS above, the <a href="https://developer.mozilla.org/en/CSS/flex">flex</a> property shorthands the <a href="https://developer.mozilla.org/en/CSS/flex-grow">flex-grow</a>, <a href="https://developer.mozilla.org/en/CSS/flex-shrink">flex-shrink</a>, and <a href="https://developer.mozilla.org/en/CSS/flex-basis">flex-basis</a> properties to establish the flexibility of the flex items. Mozilla has a <a href="https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Flexible_boxes">good introduction to the flexible boxes model</a>.  

#### Answer 2 (score 221)
There really isn't a sound, cross-browser way to do this in CSS.  Assuming your layout has complexities, you need to use JavaScript to set the element's height.  The essence of what you need to do is:  

```css
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
```css
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
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="header row" style="background:yellow;"&gt;
    &lt;h2&gt;My header&lt;/h2&gt;
&lt;/div&gt; 
&lt;div class="body row scroll-y" style="background:lightblue;"&gt;
    &lt;p&gt;The body&lt;/p&gt;
&lt;/div&gt; 
&lt;div class="footer row" style="background:#e9e9e9;"&gt;
    My footer
&lt;/div&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Styling an input type="file" button (score [889426](https://stackoverflow.com/q/572768) in 2019)

#### Question
How do you style an input `type="file"` button?  

#### Answer accepted (score 201)
Styling file inputs are notoriously difficult, as most browsers will not change the appearance from either CSS or javascript.  

Even the size of the input will not respond to the likes of:  

```css
<input type="file" style="width:200px">
```

Instead, you will need to use the size attribute:  

```css
<input type="file" size="60" />
```

For any styling more sophisticated than that (e.g. changing the look of the browse button) you will need to look at the tricksy approach of overlaying a styled button and input box on top of the native file input. The article already mentioned by rm at <a href="http://www.quirksmode.org/dom/inputfile.html" rel="noreferrer">www.quirksmode.org/dom/inputfile.html</a> is the best one I've seen.  

#### Answer 2 (score 899)
<h5>You don't need JavaScript for this! Here is a cross-browser solution:</h3>

<a href="http://jsfiddle.net/4cwpLvae/" rel="noreferrer"><strong>See this example!</strong></a> - It works in Chrome/FF/IE - (IE10/9/8/7)  

The best approach would be to have a custom label element with a `for` attribute attached to a <strong>hidden</strong> file input element. (The label's `for` attribute must match the file element's `id` in order for this to work).  

```css
<label for="file-upload" class="custom-file-upload">
    Custom Upload
</label>
<input id="file-upload" type="file"/>
```

As an alternative, you could also just wrap the file input element with a label directly: <a href="http://jsfiddle.net/1pc9pcev/" rel="noreferrer"><strong>(example)</strong></a>  

```css
<label class="custom-file-upload">
    <input type="file"/>
    Custom Upload
</label>
```

In terms of styling, just hide<sup>1</sup> the input element using the <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/Attribute_selectors" rel="noreferrer">attribute selector</a>.  

```css
input[type="file"] {
    display: none;
}
```

Then all you need to do is style the custom `label` element. <a href="http://jsfiddle.net/4cwpLvae/" rel="noreferrer"><strong>(example)</strong></a>.  

```css
.custom-file-upload {
    border: 1px solid #ccc;
    display: inline-block;
    padding: 6px 12px;
    cursor: pointer;
}
```

<hr>

<sup>1</sup> - It's worth noting that if you hide the element using `display: none`, it won't work in IE8 and below. Also be aware of the fact that jQuery validate <a href="https://stackoverflow.com/questions/8466643/jquery-validate-enable-validation-for-hidden-fields">doesn't validate hidden fields</a> by default. If either of those things are an issue for you, here are two different methods to hide the input (<a href="http://jsfiddle.net/9Lzjzwr7/" rel="noreferrer"><strong>1</strong></a>, <a href="http://jsfiddle.net/m8x2fobw/" rel="noreferrer"><strong>2</strong></a>) that work in these circumstances.  

#### Answer 3 (score 188)
follow these steps then you can create custom styles for your file upload form:  

<ol>
<li><p>this is the simple HTML form(please read the HTML comments I have written here below)</p>

<pre class="lang-html prettyprint-override"><code>&lt;form action="#type your action here" method="POST" enctype="multipart/form-data"&gt;
  &lt;div id="yourBtn" style="height: 50px; width: 100px;border: 1px dashed #BBB; cursor:pointer;" onclick="getFile()"&gt;Click to upload!&lt;/div&gt;
  &lt;!-- this is your file input tag, so i hide it!--&gt;
  &lt;div style='height: 0px;width:0px; overflow:hidden;'&gt;&lt;input id="upfile" type="file" value="upload"/&gt;&lt;/div&gt;
  &lt;!-- here you can have file submit button or you can write a simple script to upload the file automatically--&gt;
  &lt;input type="submit" value='submit' &gt;
&lt;/form&gt;
</code></pre></li>
<li><p>then use this simple script to pass the click event to file input tag.</p>

```css
function getFile(){
     document.getElementById("upfile").click();
}
```

Now you can use any type of styling without worrying about how to change default styles.  </li>
</ol>

I know this very well because I have been trying to change the default styles for a month and a half. believe me, it's very hard because different browsers have different upload input tag. So use this one to build your custom file upload forms. Here is the full AUTOMATED UPLOAD code.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
function getFile() {
  document.getElementById("upfile").click();
}

function sub(obj) {
  var file = obj.value;
  var fileName = file.split("\\");
  document.getElementById("yourBtn").innerHTML = fileName[fileName.length - 1];
  document.myForm.submit();
  event.preventDefault();
}
```

```css
#yourBtn {
  position: relative;
  top: 150px;
  font-family: calibri;
  width: 150px;
  padding: 10px;
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
  border: 1px dashed #BBB;
  text-align: center;
  background-color: #DDD;
  cursor: pointer;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;form action="#type your action here" method="POST" enctype="multipart/form-data" name="myForm"&gt;
  &lt;div id="yourBtn" onclick="getFile()"&gt;click to upload a file&lt;/div&gt;
  &lt;!-- this is your file input tag, so i hide it!--&gt;
  &lt;!-- i used the onchange event to fire the form submission--&gt;
  &lt;div style='height: 0px;width: 0px; overflow:hidden;'&gt;&lt;input id="upfile" type="file" value="upload" onchange="sub(this)" /&gt;&lt;/div&gt;
  &lt;!-- here you can have file submit button or you can write a simple script to upload the file automatically--&gt;
  &lt;!-- &lt;input type="submit" value='submit' &gt; --&gt;
&lt;/form&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 72: Set size on background image with CSS? (score [871034](https://stackoverflow.com/q/1341358) in 2014)

#### Question
Is it possible to set the size of the background image with CSS?  

I want to do something like:  

```css
background: url('bg.gif') top repeat-y;
background-size: 490px;
```

But it seems it's totally wrong to do it like that...  

#### Answer accepted (score 612)
<h5>CSS2</h1>

If you need to make the image bigger, you must edit the image itself in an image editor.   

If you use the img tag, you can change the size, but that would not give you the desired result if you need the image to be background for some other content (and it will not repeat itself like you seems to want)...  

<h5>CSS3 <sub><sup>unleash the powers</sup></sub></h1>

This is possible to do in CSS3 with `background-size`.  

<p>All modern browsers support this, so unless you need to support old browsers, this is the way to do it.<br>
<sub><b>Supported browsers:</b></sub><br>
<sup>
Mozilla Firefox 4.0+ (Gecko 2.0+), Microsoft Internet Explorer 9.0+, Opera 10.0+, Safari 4.1+ (webkit 532) and Chrome 3.0+.
</sup></p>

```css
.stretch{
/* Will stretch to specified width/height */
  background-size: 200px 150px;
}
.stretch-content{
/* Will stretch to width/height of element */
  background-size: 100% 100%;
}

.resize-width{
/* width: 150px, height: auto to retain aspect ratio */
  background-size: 150px Auto;
}
.resize-height{
/* height: 150px, width: auto to retain aspect ratio */
  background-size: Auto 150px;
}
.resize-fill-and-clip{ 
  /* Resize to fill and retain aspect ratio.
     Will cause clipping if aspect ratio of box is different from image. */ 
  background-size: cover;
}
.resize-best-fit{
/* Resize to best fit and retain aspect ratio.
   Will cause gap if aspect ratio of box is different from image. */ 
  background-size: contain;
}
```

In particular, I like the `cover` and `contain` values that gives us new power of control that we didn't have before.   

<h5>Round</h2>

You can also use `background-size: round` that have a meaning in combination with repeat:   

```css
.resize-best-fit-in-repeat{
/* Resize to best fit in a whole number of times in x-direction */ 
  background-size: round auto; /* Height: auto is to keep aspect ratio */
  background-repeat: repeat;
}
```

This will adjust the image width so it fits a whole number of times in the background positioning area.  

<hr>

<p><em>Additional note</em><br>
If the size you need is static pixel size, it is still smart to physically resize the actual image. This is both to improve quality of the resize (given that your image software does a better job than the browsers), and to save bandwidth if the original image is larger than what to display.</p>

#### Answer 2 (score 330)
Only CSS 3 supports that,  

```css
background-size: 200px 50px;
```

But I would edit the image itself, so that the user needs to load less, and it might look better than a shrunken image without antialiasing.  

#### Answer 3 (score 23)
If your users use only Opera 9.5+, Safari 3+, Internet&nbsp;Explorer 9+ and Firefox 3.6+ then the answer is yes. Otherwise, no.  

The <a href="http://www.w3.org/TR/2002/WD-css3-background-20020802/#background-size" rel="noreferrer">background-size</a> property is part of CSS 3, but it won't work on most browsers.  

For your purposes just make the actual image larger.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: Flexbox: center horizontally and vertically (score [870181](https://stackoverflow.com/q/19026884) in 2016)

#### Question
How to center div horizontally, and vertically within the container using flexbox. In below example, I want each number below each other (in rows), which are centered horizontally.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.flex-container {
  padding: 0;
  margin: 0;
  list-style: none;
  display: flex;
  align-items: center;
  justify-content: center;
}
row {
  width: 100%;
}
.flex-item {
  background: tomato;
  padding: 5px;
  width: 200px;
  height: 150px;
  margin: 10px;
  line-height: 150px;
  color: white;
  font-weight: bold;
  font-size: 3em;
  text-align: center;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="flex-container"&gt;
  &lt;div class="row"&gt;
    &lt;span class="flex-item"&gt;1&lt;/span&gt;
  &lt;/div&gt;
  &lt;div class="row"&gt;
    &lt;span class="flex-item"&gt;2&lt;/span&gt;
  &lt;/div&gt;
  &lt;div class="row"&gt;
    &lt;span class="flex-item"&gt;3&lt;/span&gt;
  &lt;/div&gt;
  &lt;div class="row"&gt;
    &lt;span class="flex-item"&gt;4&lt;/span&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


<a href="http://codepen.io/anon/pen/zLxBo">http://codepen.io/anon/pen/zLxBo</a>  

#### Answer accepted (score 648)
I think you want something like the following.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
html, body {
    height: 100%;
}
body {
    margin: 0;
}
.flex-container {
    height: 100%;
    padding: 0;
    margin: 0;
    display: -webkit-box;
    display: -moz-box;
    display: -ms-flexbox;
    display: -webkit-flex;
    display: flex;
    align-items: center;
    justify-content: center;
}
.row {
    width: auto;
    border: 1px solid blue;
}
.flex-item {
    background-color: tomato;
    padding: 5px;
    width: 20px;
    height: 20px;
    margin: 10px;
    line-height: 20px;
    color: white;
    font-weight: bold;
    font-size: 2em;
    text-align: center;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="flex-container"&gt;
    &lt;div class="row"&gt; 
        &lt;div class="flex-item"&gt;1&lt;/div&gt;
        &lt;div class="flex-item"&gt;2&lt;/div&gt;
        &lt;div class="flex-item"&gt;3&lt;/div&gt;
        &lt;div class="flex-item"&gt;4&lt;/div&gt;
    &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


See demo at: <a href="http://jsfiddle.net/audetwebdesign/tFscL/">http://jsfiddle.net/audetwebdesign/tFscL/</a>  

Your `.flex-item` elements should be block level (`div` instead of `span`) if you want the height and top/bottom padding to work properly.  

Also, on `.row`, set the width to `auto` instead of `100%`.  

Your `.flex-container` properties are fine.  

If you want the `.row` to be centered vertically in the view port, assign 100% height to `html` and `body`, and also zero out the `body` margins.  

Note that `.flex-container` needs a height to see the vertical alignment effect, otherwise, the container computes the minimum height needed to enclose the content, which is less than the view port height in this example.  

<p><strong>Footnote:</strong><br>
The `flex-flow`, `flex-direction`, `flex-wrap` properties could have made this design easier to implement. I think that the `.row` container is not needed unless you want to add some styling around the elements (background image, borders and so on).</p>

A useful resource is: <a href="http://demo.agektmr.com/flexbox/">http://demo.agektmr.com/flexbox/</a>  

#### Answer 2 (score 228)
<h5>How to Center Elements Vertically and Horizontally in Flexbox</h2>

Below are two general centering solutions.  

One for vertically-aligned flex items (`flex-direction: column`) and the other for horizontally-aligned flex items (`flex-direction: row`).  

In both cases the height of the centered divs can be variable, undefined, unknown, whatever. The height of the centered divs doesn't matter.  

<strong>Here's the HTML for both:</strong>  

```css
<div id="container"><!-- flex container -->

    <div class="box" id="bluebox"><!-- flex item -->
        <p>DIV #1</p>
    </div>

    <div class="box" id="redbox"><!-- flex item -->
        <p>DIV #2</p>
    </div>

</div>
```

<hr>

<strong>CSS</strong> (excluding decorative styles)  

<em>When flex items are stacked vertically:</em>  

```css
#container {
    display: flex;           /* establish flex container */
    flex-direction: column;  /* make main axis vertical */
    justify-content: center; /* center items vertically, in this case */
    align-items: center;     /* center items horizontally, in this case */
    height: 300px;
}

.box {
    width: 300px;
    margin: 5px;
    text-align: center;     /* will center text in <p>, which is not a flex item */
}
```

<a href="https://i.stack.imgur.com/9Jbjt.png" rel="noreferrer"><img src="https://i.stack.imgur.com/9Jbjt.png" alt="enter image description here"></a>  

<a href="http://jsfiddle.net/8o29y7pd/" rel="noreferrer"><strong>DEMO</strong></a>  

<hr>

<em>When flex items are stacked horizontally:</em>  

Adjust the `flex-direction` rule from the code above.  

```css
#container {
    display: flex;
    flex-direction: row;     /* make main axis horizontal (default setting) */
    justify-content: center; /* center items horizontally, in this case */
    align-items: center;     /* center items vertically, in this case */
    height: 300px;
}
```

<a href="https://i.stack.imgur.com/ccTOU.png" rel="noreferrer"><img src="https://i.stack.imgur.com/ccTOU.png" alt="enter image description here"></a>  

<a href="http://jsfiddle.net/8o29y7pd/3/" rel="noreferrer"><strong>DEMO</strong></a>  

<hr>

<h5>Centering the content of the flex items</h3>

The scope of a <a href="https://www.w3.org/TR/css-flexbox-1/#flex-containers" rel="noreferrer"><em>flex formatting context</em></a> is limited to a parent-child relationship. Descendants of a flex container beyond the children do not participate in flex layout and will ignore flex properties. Essentially, flex properties are not inheritable beyond the children.  

Hence, you will always need to apply `display: flex` or `display: inline-flex` to a parent element in order to apply flex properties to the child.  

In order to vertically and/or horizontally center text or other content contained in a flex item, make the item a (nested) flex container, and repeat the centering rules.  

```css
.box {
    display: flex;
    justify-content: center;
    align-items: center;        /* for single line flex container */
    align-content: center;      /* for multi-line flex container */
}
```

More details here: <a href="https://stackoverflow.com/q/25311541/3597276">How to vertically align text inside a flexbox?</a>  

Alternatively, you can apply `margin: auto` to the content element of the flex item.  

```css
p { margin: auto; }
```

Learn about flex `auto` margins here: <a href="https://stackoverflow.com/a/33856609/3597276">Methods for Aligning Flex Items</a> (see box#56).  

<hr>

<h5>Centering multiple lines of flex items</h3>

When a flex container has multiple lines (due to wrapping) the `align-content` property will be necessary for cross-axis alignment.  

<em>From the spec:</em>  

<blockquote>
  <p><a href="https://www.w3.org/TR/css-flexbox-1/#align-content-property" rel="noreferrer"><strong>8.4. Packing Flex Lines: the `align-content`
  property</strong></a></p>
  
  <p>The `align-content` property aligns a flex container’s lines within the
  flex container when there is extra space in the cross-axis, similar to
  how `justify-content` aligns individual items within the main-axis.
  <em>Note, this property has no effect on a single-line flex container.</em></p>
</blockquote>

More details here: <a href="https://stackoverflow.com/q/42613359/3597276">How does flex-wrap work with align-self, align-items and align-content?</a>  

<hr>

<h5>Browser support</h3>

Flexbox is supported by all major browsers, <a href="http://caniuse.com/#search=flex" rel="noreferrer">except IE &lt; 10</a>. Some recent browser versions, such as Safari 8 and IE10, require <a href="https://developer.mozilla.org/en-US/docs/Glossary/Vendor_Prefix" rel="noreferrer">vendor prefixes</a>. For a quick way to add prefixes use <a href="https://autoprefixer.github.io/" rel="noreferrer">Autoprefixer</a>. More details in <a href="https://stackoverflow.com/a/35137869/3597276">this answer</a>.  

<hr>

<h5>Centering solution for older browsers</h3>

For an alternative centering solution using CSS table and positioning properties see this answer: <a href="https://stackoverflow.com/a/31977476/3597276">https://stackoverflow.com/a/31977476/3597276</a>  

#### Answer 3 (score 36)
Add   

```css
.container {
    display: flex;
    justify-content: center;
    align-items: center;
}
```

<p>to the container element of whatever you want to center. Documentation:
 <a href="https://developer.mozilla.org/de/docs/Web/CSS/justify-content" rel="noreferrer">justify-content</a> and 
<a href="https://developer.mozilla.org/de/docs/Web/CSS/align-items" rel="noreferrer">align-items</a>.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Slide right to left? (score [867488](https://stackoverflow.com/q/596608) in 2016)

#### Question
How can I have a div go from collapsed to expanded (and vice versa), but do so from right to left?  

Most everything I see out there is always left to right.  

#### Answer 2 (score 364)
```css
$("#slide").animate({width:'toggle'},350);
```

Reference: <a href="https://api.jquery.com/animate/" rel="noreferrer">https://api.jquery.com/animate/</a>  

#### Answer 3 (score 231)
<p>This can be achieved natively using the jQueryUI hide/show methods.
Eg.</p>

```css
    // To slide something leftwards into view,
    // with a delay of 1000 msec
    $("div").click(function () {
          $(this).show("slide", { direction: "left" }, 1000);
    });
```

Reference: <a href="http://docs.jquery.com/UI/Effects/Slide" rel="noreferrer">http://docs.jquery.com/UI/Effects/Slide</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: Stretch and scale CSS background (score [864111](https://stackoverflow.com/q/376253) in 2012)

#### Question
Is there a way to get a background in CSS to stretch or scale to fill its container?  

#### Answer accepted (score 258)
For modern browsers, you can accomplish this by using <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/background-size" rel="noreferrer">`background-size`</a>:  

```css
body {
    background-image: url(bg.jpg);
    background-size: cover;
}
```

`cover` means stretching the image either vertically or horizontally so it never tiles/repeats.  

That would work for Safari 3 (or later), Chrome, <a href="http://en.wikipedia.org/wiki/Opera_%28web_browser%29" rel="noreferrer">Opera</a> 10+, Firefox 3.6+, and Internet&nbsp;Explorer&nbsp;9 (or later).  

For it to work with lower verions of Internet&nbsp;Explorer, try these CSS:  

```css
filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='.myBackground.jpg', sizingMethod='scale');
-ms-filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='myBackground.jpg', sizingMethod='scale')";
```

#### Answer 2 (score 566)
Use the <a href="http://en.wikipedia.org/wiki/Cascading_Style_Sheets#CSS_3">CSS 3</a> property `background-size`:  

```css
#my_container {
    background-size: 100% auto; /* width and height, can be %, px or whatever. */
}
```

This is available for modern browsers, since 2012.  

#### Answer 3 (score 172)
Scaling an image with CSS is not quite possible, but a similar effect can be achieved in the following manner, though.  

Use this markup:  

<pre class="lang-html prettyprint-override"><code>&lt;div id="background"&gt;
    &lt;img src="img.jpg" class="stretch" alt="" /&gt;
&lt;/div&gt;
</code></pre>

with the following CSS:  

```css
#background {
    width: 100%; 
    height: 100%; 
    position: absolute; 
    left: 0px; 
    top: 0px; 
    z-index: 0;
}

.stretch {
    width:100%;
    height:100%;
}
```

and you should be done!  

In order to scale the image to be "full bleed" and maintain the aspect ratio, you can do this instead:  

```css
.stretch { min-width:100%; min-height:100%; width:auto; height:auto; }
```

It works out quite nicely! If one dimension is cropped, however, it will be cropped on only one side of the image, rather than being evenly cropped on both sides (and centered). I've tested it in Firefox, <a href="http://en.wikipedia.org/wiki/WebKit" rel="noreferrer">Webkit</a>, and Internet&nbsp;Explorer&nbsp;8.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Placing border inside of div and not on its edge (score [852960](https://stackoverflow.com/q/9601357) in 2015)

#### Question
I have a `&lt;div&gt;` element and I want to put a border on it.  I know I can write `style="border: 1px solid black"`, but this adds 2px to either side of the div, which is not what I want.    

I would rather have this border be -1px from the edge of the div. The div itself is 100px x 100px, and if I add a border, then I have to do some mathematics to make the border appear.  

Is there any way that I can make the border appear, and ensure the box will still be 100px (including the border)?  

#### Answer accepted (score 613)
Set `box-sizing` property to `border-box`:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
div {
    box-sizing: border-box;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    width: 100px;
    height: 100px;
    border: 20px solid #f00;
    background: #00f;
    margin: 10px;
}

div + div {
    border: 10px solid red;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div&gt;Hello!&lt;/div&gt;
&lt;div&gt;Hello!&lt;/div&gt;</code></pre>
</div>
</div>


It works on <a href="http://caniuse.com/#search=box-sizing" rel="noreferrer">IE8 &amp; above</a>.  

#### Answer 2 (score 333)
You can also use box-shadow like this:  

```css
div{
    -webkit-box-shadow:inset 0px 0px 0px 10px #f00;
    -moz-box-shadow:inset 0px 0px 0px 10px #f00;
    box-shadow:inset 0px 0px 0px 10px #f00;
}
```

Example here: <a href="http://jsfiddle.net/nVyXS/">http://jsfiddle.net/nVyXS/</a> (hover to view border)  

<p>This works in modern browsers only. For example: No IE 8 support.
<a href="http://caniuse.com/#feat=css-boxshadow">See caniuse.com (box-shadow feature)</a> for more info.</p>

#### Answer 3 (score 82)
Probably it is belated answer, but I want to share with my findings. I found 2 new approaches to this problem that I have not found here in the answers:  

<h5>Inner border through `box-shadow` css property</h2>

Yes, box-shadow is used to add box-shadows to the elements. But you can specify `inset` shadow, that would look like a inner border rather like a shadow. You just need to set horizontal and vertical shadows to `0px`, and the "`spread`" property of the `box-shadow` to the width of the border you want to have. So for the 'inner' border of 10px you would write the following:  

```css
div{
    width:100px;
    height:100px;
    background-color:yellow;
    box-shadow:0px 0px 0px 10px black inset;
    margin-bottom:20px;
}
```

Here is <a href="http://jsfiddle.net/gh05s9ac/3/" rel="noreferrer">jsFiddle</a> example that illustrates the difference between `box-shadow` border and 'normal' border. This way your border and the box width are of total 100px including the border.  

More about box-shadow:<a href="http://www.w3schools.com/cssref/css3_pr_box-shadow.asp" rel="noreferrer">here</a>  

<h5>Border through outline css property</h2>

<p>Here is another approach, but this way the border would be outside of the box. Here is <a href="http://jsfiddle.net/tna8garq/" rel="noreferrer">an example</a>.
As follows from the example, you can use css `outline` property, to set the border that does not affect the width and height of the element. This way, the border width is not added to the width of an element. </p>

```css
div{
   width:100px;
   height:100px;
   background-color:yellow;
   outline:10px solid black;
}
```

More about outline: <a href="http://www.w3schools.com/cssref/pr_outline.asp" rel="noreferrer">here</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: How to force child div to be 100% of parent div's height without specifying parent's height? (score [851350](https://stackoverflow.com/q/1122381) in 2019)

#### Question
I have a site with the following structure:  

```css
<div id="header"></div>

<div id="main">
  <div id="navigation"></div>
  <div id="content"></div>
</div>

<div id="footer"></div>
```

The navigation is on the left and the content div is on the right. The information for the content div is pulled in through PHP, so it's different every time.  

How can I scale the navigation vertically so that its height is the same as the content div's height, no matter which page is loaded?  

#### Answer accepted (score 154)
<strong>NOTE</strong>: This answer is applicable to legacy browsers without support for the Flexbox standard. For a modern approach, see: <a href="https://stackoverflow.com/a/23300532/1155721">https://stackoverflow.com/a/23300532/1155721</a>  

<hr>

I suggest you take a look at <a href="http://matthewjamestaylor.com/blog/equal-height-columns-cross-browser-css-no-hacks" rel="noreferrer">Equal Height Columns with Cross-Browser CSS and No Hacks</a>.  

Basically, doing this with CSS in a browser compatible way is not trivial (but trivial with tables) so find yourself an appropriate pre-packaged solution.  

Also, the answer varies on whether you want 100% height or equal height. Usually it's equal height. If it's 100% height the answer is slightly different.  

#### Answer 2 (score 517)
For the parent:  

```css
display: flex;
```

You should add some prefixes, <a href="http://css-tricks.com/using-flexbox/" rel="noreferrer">http://css-tricks.com/using-flexbox/</a>.  

<p>Edit:
As @Adam Garner noted, align-items: stretch; is not needed. Its usage is also for parent, not children. If you want to define children stretching, you use align-self.</p>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.parent {
  background: red;
  padding: 10px;
  display:flex;
}

.other-child {
  width: 100px;
  background: yellow;
  height: 150px;
  padding: .5rem;
}

.child {  
  width: 100px;
  background: blue;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="parent"&gt;
  &lt;div class="other-child"&gt;
    Only used for stretching the parent
  &lt;/div&gt;
  &lt;div class="child"&gt;&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer 3 (score 97)
This is a frustrating issue that's dealt with designers all the time. The trick is that you need to set the height to 100% on BODY and HTML in your CSS.  

```css
html,body {
    height:100%;
}
```

This seemingly pointless code is to define to the browser what 100% means. Frustrating, yes, but is the simplest way.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: Best way to center a \<div> on a page vertically and horizontally? (score [849636](https://stackoverflow.com/q/356809) in 2018)

#### Question
Best way to center a `&lt;div&gt;` element on a page both vertically and horizontally?  

I know that `margin-left: auto; margin-right: auto;` will center on the horizontal, but what is the best way to do it vertically, too?  

#### Answer 2 (score 692)
<h5>The best and most flexible way</h2>

<strong>My <a href="http://dabblet.com/gist/2872671" rel="noreferrer">demo on dabblet.com</a></strong>  

The main trick in this demo is that in the normal flow of elements going from top to bottom, so the `margin-top: auto` is set to zero. However, an absolutely positioned element acts the same for distribution of free space, and similarly can be centered vertically at the specified `top` and `bottom` (does not work in IE7).  

<h5>This trick will work with any sizes of `div`.</h2>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
div {
	width: 100px;
	height: 100px;
	background-color: red;
	
	position: absolute;
	top:0;
	bottom: 0;
	left: 0;
	right: 0;
  	
	margin: auto;
}
```

<pre class="snippet-code-html lang-html prettyprint-override">`&lt;div&gt;&lt;/div&gt;`</pre>
</div>
</div>


#### Answer 3 (score 126)
Even though this did not work when the OP asked this question, I think, for modern browsers at least, the best solution is to use <strong>display: flex</strong> or <strong>pseudo classes</strong>.  

<p>You can see an example in the following <a href="http://jsfiddle.net/sFM7C/" rel="noreferrer">fiddle</a>.
Here is the <a href="http://jsfiddle.net/sFM7C/287/" rel="noreferrer">updated fiddle</a>.</p>

For <strong>pseudo classes</strong> an example could be:  

```css
.centerPseudo {
    display:inline-block;
    text-align:center;
}

.centerPseudo::before{
    content:'';
    display:inline-block;
    height:100%;
    vertical-align:middle;
    width:0px;
}
```

The usage of <strong>display: flex</strong>, according to <a href="https://css-tricks.com/snippets/css/a-guide-to-flexbox/" rel="noreferrer">css-tricks</a> and <a href="https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Flexible_boxes" rel="noreferrer">MDN</a> is as follows:  

```css
.centerFlex {
  align-items: center;
  display: flex;
  justify-content: center;
}
```

There are other attributes available for flex, which are explained in above mentioned links, with further examples.  

If you have to support older browsers, which don't support css3, then you should probably use javascript or the fixed width/height solution shown in the other answers.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: Can I have an onclick effect in CSS? (score [847017](https://stackoverflow.com/q/13630229) in 2019)

#### Question
I have an image element that I want to change on click.  

```css
<img id="btnLeft">
```

This works:  

```css
#btnLeft:hover {
    width:70px;
    height:74px;
}
```

But what I need is:  

```css
#btnLeft:onclick {
    width:70px;
    height:74px;
}
```

But, it doesn't work, obviously. Is it possible at all to have `onclick` behavior in CSS (i.e. without using JavaScript)?  

#### Answer accepted (score 282)
The closest you'll get is <a href="https://developer.mozilla.org/en-US/docs/CSS/%3aactive">`:active`</a>:  

```css
#btnLeft:active {
    width: 70px;
    height: 74px;
}
```

However this will only apply the style when the mouse button is held down. The only way to apply a style <em>and keep it applied</em> onclick is to use a bit of JavaScript.  

#### Answer 2 (score 319)
<h5>Answer as of 2019:</h1>

The best way (actually the only way*) to simulate an actual <em>click</em> event using only CSS (rather than just hovering on an element or making an element active, where you don't have <a href="https://developer.mozilla.org/en-US/docs/Web/Events/mouseup" rel="noreferrer">mouseUp</a>) is to use the checkbox hack. It works by attaching a <a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/label" rel="noreferrer">`label`</a> to an <a href="http://www.w3.org/TR/html-markup/input.checkbox.html" rel="noreferrer">`&lt;input type="checkbox"&gt;`</a> element via the label's `for=""` attribute.   

This feature has <a href="http://caniuse.com/#search=%3Achecked" rel="noreferrer">broad browser support</a> (the `:checked` pseudo-class is IE9+).  

Apply the same value to an `&lt;input&gt;`'s ID attribute and an accompanying `&lt;label&gt;`'s `for=""` attribute, and you can tell the browser to re-style the label on click with the <a href="http://www.w3.org/TR/css3-selectors/#checked" rel="noreferrer">`:checked`</a> pseudo-class, thanks to the fact that clicking a label will check and uncheck the "associated" `&lt;input type="checkbox"&gt;`.  

* You can simulate a "selected" event via the `:active` or `:focus` pseudo-class in IE7+ (e.g. for a button that's normally `50px` wide, you can change its width while `active`: `#btnControl:active { width: 75px; }`), but those are not true "click" events. They are "live" the entire time the element is selected (such as by <kbd>Tab</kbd>bing with your keyboard), which is a little different from a true click event, which fires an action on - typically - `mouseUp`.  

<hr>

<h5>Basic demo of the checkbox hack (the basic code structure for what you're asking):</h2>

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
label {
    display: block;
    background: lightgrey;
    width: 100px;
    height: 100px;
}

#demo:checked + label {
    background: blue;
    color: white;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;input type="checkbox" id="demo"/&gt;
&lt;label for="demo"&gt;I'm a square. Click me.&lt;/label&gt;</code></pre>
</div>
</div>


Here I've positioned the label right after the input in my markup. This is so that I can use the <a href="https://drafts.csswg.org/selectors-3/#adjacent-sibling-combinators" rel="noreferrer">adjacent sibling selector</a> (the <kbd>+</kbd> key) to select only the label that immediately follows my `#demo` checkbox. Since the `:checked` pseudo-class applies to the checkbox, `#demo:checked + label` will only apply when the checkbox is checked.   

<h5>Demo for re-sizing an image on click, which is what you're asking:</h1>

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
#btnControl {
    display: none;
}

#btnControl:checked + label > img {
    width: 70px;
    height: 74px;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;input type="checkbox" id="btnControl"/&gt;
&lt;label class="btn" for="btnControl"&gt;&lt;img src="http://placekitten.com/200/140" id="btnLeft" /&gt;&lt;/label&gt;</code></pre>
</div>
</div>


With that being said, there <em>is</em> some bad news. Because a label can only be <a href="https://stackoverflow.com/questions/31944554/when-a-label-only-has-a-button-a-button-click-does-not-fully-trigger-the-lab/31944858#31944858">associated with one form control at a time</a>, that means you can't just drop a button inside the `&lt;label&gt;&lt;/label&gt;` tags and call it a day. However, we <em>can</em> use some CSS to make the label look and behave fairly close to how an HTML button looks and behaves.  

<h5>Demo for imitating a button click effect, above and beyond what you're asking:</h2>

<p><div class="snippet" data-lang="js" data-hide="true" data-console="false" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
#btnControl {
    display: none;
}

.btn {
    width: 60px;
    height: 20px;
    background: silver;
    border-radius: 5px;
    padding: 1px 3px;
    box-shadow: 1px 1px 1px #000;
    display: block;
    text-align: center;
    background-image: linear-gradient(to bottom, #f4f5f5, #dfdddd);
    font-family: arial;
    font-size: 12px;
    line-height:20px;
}

.btn:hover {
    background-image: linear-gradient(to bottom, #c3e3fa, #a5defb);
}


.btn:active {
    margin-left: 1px 1px 0;
    box-shadow: -1px -1px 1px #000;
    outline: 1px solid black;
    -moz-outline-radius: 5px;
    background-image: linear-gradient(to top, #f4f5f5, #dfdddd);
}

#btnControl:checked + label {
    width: 70px;
    height: 74px;
    line-height: 74px;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;input type="checkbox" id="btnControl"/&gt;
&lt;label class="btn" for="btnControl"&gt;Click me!&lt;/label&gt;</code></pre>
</div>
</div>


Most of the CSS in this demo is just for styling the label element. If you don't actually need a <em>button</em>, and any old element will suffice, then you can remove almost all of the styles in this demo, similar to my second demo above.  

You'll also notice I have one prefixed property in there, `-moz-outline-radius`. A while back, Mozilla added this awesome non-spec property to Firefox, but the folks at WebKit decided they <a href="https://stackoverflow.com/a/14896685/2756409">aren't going to add it</a>, unfortunately. So consider that line of CSS just a progressive enhancement for people who use Firefox.  

#### Answer 3 (score 79)
You can use pseudo class `:target` to mimic on click event, let me give you an example.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
#something {
  display: none;
}

#something:target {
  display: block;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;a href="#something"&gt;Show&lt;/a&gt;
&lt;div id="something"&gt;Bingo!&lt;/div&gt;</code></pre>
</div>
</div>


Here's how it looks like: <a href="http://jsfiddle.net/TYhnb/" rel="noreferrer">http://jsfiddle.net/TYhnb/</a>  

One thing to note, this is only limited to hyperlink, so if you need to use on other than hyperlink, such as a button, you might want to hack it a little bit, such as styling a hyperlink to look like a button.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Convert HTML + CSS to PDF with PHP? (score [843541](https://stackoverflow.com/q/391005) in 2018)

#### Question
I have an HTML (not XHTML) document that renders fine in Firefox 3 and IE 7.  It uses fairly basic CSS to style it and renders fine in HTML.  

I'm now after a way of converting it to PDF.  I have tried:  

<ul>
<li><a href="https://github.com/dompdf/dompdf" rel="noreferrer">DOMPDF</a>: it had huge problems with tables.  I factored out my large nested tables and it helped (before it was just consuming up to 128M of memory then dying--thats my limit on memory in php.ini) but it makes a complete mess of tables and doesn't seem to get images.  The tables were just basic stuff with some border styles to add some lines at various points;</li>
<li><a href="https://github.com/spipu/html2pdf" rel="noreferrer">HTML2PDF and HTML2PS</a>: I actually had better luck with this.  It rendered some of the images (all the images are Google Chart URLs) and the table formatting was much better but it seemed to have some complexity problem I haven't figured out yet and kept dying with unknown node_type() errors.  Not sure where to go from here; and</li>
<li><a href="http://www.msweet.org/projects.php?Z1" rel="noreferrer">Htmldoc</a>: this seems to work fine on basic HTML but has almost no support for CSS whatsoever so you have to do everything in HTML (I didn't realize it was still 2001 in Htmldoc-land...) so it's useless to me.</li>
</ul>

I tried a Windows app called Html2Pdf Pilot that actually did a pretty decent job but I need something that at a minimum runs on Linux and ideally runs on-demand via PHP on the Webserver.  

What am I missing, or how can I resolve this issue?  

#### Answer accepted (score 544)
<p><strong>Important:</strong>
Please note that this answer was written in 2009 and it might not be the most cost-effective solution today in 2019. Online alternatives are better today at this than they were back then.</p>

Here are some online services that you can use:  

<ul>
<li><a href="https://pdfshift.io" rel="noreferrer">PDFShift</a></li>
<li><a href="https://restpack.io/html2pdf" rel="noreferrer">Restpack</a></li>
<li><a href="https://pdflayer.com" rel="noreferrer">PDF Layer</a></li>
<li><a href="https://docraptor.com" rel="noreferrer">DocRaptor</a></li>
<li><a href="https://htmlpdfapi.com" rel="noreferrer">HTMLPDFAPI</a></li>
<li><a href="https://www.html2pdfrocket.com" rel="noreferrer">HTML to PDF Rocket</a></li>
</ul>

<hr>

Have a look at <a href="http://princexml.com" rel="noreferrer">PrinceXML</a>.  

It's definitely the best HTML/CSS to PDF converter out there, although it's not free (But hey, your programming might not be free either, so if it saves you 10 hours of work, you're home free (since you also need to take into account that the alternative solutions will require you to setup a dedicated server with the right software)  

Oh yeah, did I mention that this is the first (and probably only) HTML2PDF solution that does full <a href="http://princexml.com/samples/acid2/acid2.pdf" rel="noreferrer">ACID2</a> ?  

<a href="http://princexml.com/samples/" rel="noreferrer">PrinceXML Samples</a>  

#### Answer 2 (score 663)
Have a look at <a href="http://wkhtmltopdf.org/" rel="noreferrer">`wkhtmltopdf`</a> . It is open source, based on webkit and free.  

We wrote a small tutorial <a href="http://beebole.com/blog/general/convert-html-to-pdf-with-full-css-support-an-opensource-alternative-based-on-webkit/" rel="noreferrer">here</a>.  

<strong>EDIT( 2017 ):</strong>  

<p>If it was to build something today, I wouldn't go that route anymore.<br/>
But would use <a href="http://pdfkit.org/" rel="noreferrer">http://pdfkit.org/</a> instead.<br/>
Probably stripping it of all its nodejs dependencies, to run in the browser.</p>

#### Answer 3 (score 149)
After some investigation and general hair-pulling the solution seems to be <a href="http://html2pdf.fr/" rel="noreferrer">HTML2PDF</a>.  <a href="https://github.com/dompdf/dompdf" rel="noreferrer">DOMPDF</a> did a terrible job with tables, borders and even moderately complex layout and <a href="http://www.easysw.com/htmldoc/" rel="noreferrer">htmldoc</a> seems reasonably robust but is almost completely CSS-ignorant and I don't want to go back to doing HTML layout without CSS just for that program.  

HTML2PDF looked the most promising but I kept having this weird error about null reference arguments to node_type.  I finally found the solution to this.  Basically, PHP 5.1.x worked fine with regex replaces (preg_replace_*) on strings of any size.  PHP 5.2.1 introduced a php.ini config directive called <strong>pcre.backtrack_limit</strong>.  What this config parameter does is limits the string length for which matching is done.  Why this was introduced I don't know.  The default value was chosen as 100,000.  Why such a low value?  Again, no idea.  

A <a href="http://bugs.php.net/bug.php?id=40846" rel="noreferrer">bug was raised against PHP 5.2.1 for this</a>, which is still open <em>almost two years later</em>.  

What's horrifying about this is that when the limit is exceeded, the replace just <strong>silently fails</strong>.  At least if an error had been raised and logged you'd have some indication of what happened, why and what to change to fix it.  But no.  

So I have a 70k HTML file to turn into PDF.  It requires the following php.ini settings:  

<ul>
<li>pcre.backtrack_limit = 2000000; # probably more than I need but that's OK</li>
<li>memory_limit = 1024M; # yes, <strong>one gigabyte</strong>; and</li>
<li>max_execution_time = 600; # yes, <strong>10 minutes</strong>.</li>
</ul>

Now the astute reader may have noticed that my HTML file is smaller than 100k.  The only reason I can guess as to why I hit this problem is that html2pdf does a conversion into xhtml as part of the process.  Perhaps that took me over (although nearly 50% bloat seems odd).  Whatever the case, the above worked.  

Now, html2pdf is a resource hog. My 70k file takes approximately 5 minutes and at least 500-600M of RAM to create a 35 page PDF file.  Not quick enough (by far) for a real-time download unfortunately and the memory usage puts the memory usage ratio in the order of 1000-to-1 (600M of RAM for a 70k file), which is utterly ridiculous.  

Unfortunately, that's the best I've come up with.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: CSS force image resize and keep aspect ratio (score [837591](https://stackoverflow.com/q/12991351) in 2013)

#### Question
I am working with images, and I ran across a problem with aspect ratios.  

```css
<img src="big_image.jpg" width="900" height="600" alt="" />
```

As you can see, `height` and `width` are already specified. I added CSS rule for images:  

```css
img {
  max-width:500px;
}
```

But for `big_image.jpg`, I receive `width=500` and `height=600`. How I can set images to be re-sized, while keeping their aspect ratios.  

#### Answer accepted (score 686)
<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
```css
img {
  display: block;
  max-width:230px;
  max-height:95px;
  width: auto;
  height: auto;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;p&gt;This image is originally 400x400 pixels, but should get resized by the CSS:&lt;/p&gt;
&lt;img width="400" height="400" src="http://i.stack.imgur.com/aEEkn.png"&gt;</code></pre>
</div>
</div>


This will make image shrink if it's too big for specified area (as downside, it will not enlarge image).  

#### Answer 2 (score 211)
<strong>The solutions below will allow scaling up and scaling down of the image</strong>, depending on the parent box width.  

All images have a parent container with a fixed width <em>for demonstration purposes only</em>. In production, this will be the width of the parent box.  

<h5>Best Practice (2018):</h1>

This solution tells the browser to render the image with max available width and adjust the height as a percentage of that width.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
.parent {
  width: 100px;
}

img {
  display: block;
  width: 100%;
  height: auto;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;p&gt;This image is originally 400x400 pixels, but should get resized by the CSS:&lt;/p&gt;
&lt;div class="parent"&gt;
  &lt;img width="400" height="400" src="https://placehold.it/400x400"&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


<h5>Fancier Solution:</h1>

With the fancier solution, you'll be able to crop the image regardless of its size and add a background color to compensate for the cropping.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
.parent {
  width: 100px;
}

.container {
  display: block;
  width: 100%;
  height: auto;
  position: relative;
  overflow: hidden;
  padding: 34.37% 0 0 0; /* 34.37% = 100 / (w / h) = 100 / (640 / 220) */
}

.container img {
  display: block;
  max-width: 100%;
  max-height: 100%;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;p&gt;This image is originally 640x220, but should get resized by the CSS:&lt;/p&gt;
&lt;div class="parent"&gt;
  &lt;div class="container"&gt;
    &lt;img width="640" height="220" src="https://placehold.it/640x220"&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


For the line specifying padding, you need to calculate the aspect ratio of the image, for example:  

```css
640px (w) = 100%
220px (h) = ?

640/220 = 2.909
100/2.909 = 34.37%
```

So, top padding = 34.37%.  

#### Answer 3 (score 190)
I've struggled with this problem quite hard, and eventually arrived at this simple solution:  

```css
object-fit: cover;
width: 100%;
height: 250px;
```

You can adjust the width and height to fit your needs, and the object-fit property will do the cropping for you.  

Cheers.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: How to add some non-standard font to a website? (score [831371](https://stackoverflow.com/q/107936) in 2012)

#### Question
Is there a way to add some custom font on website without using images, <a href="http://en.wikipedia.org/wiki/Adobe_Flash" rel="noreferrer">Flash</a> or some other graphics?  

For example, I was working on some wedding website, and I was finding a lot of nice fonts for that subject, but I can't find the right way to add that font on the server, and how do I include that font with CSS into the HTML? Is this possible to do without graphics?  

#### Answer accepted (score 484)
This could be done via CSS:  

```css
<style type="text/css">
@font-face {
    font-family: "My Custom Font";
    src: url(http://www.example.org/mycustomfont.ttf) format("truetype");
}
p.customfont { 
    font-family: "My Custom Font", Verdana, Tahoma;
}
</style>
<p class="customfont">Hello world!</p>
```

It is <a href="http://www.w3schools.com/cssref/css3_pr_font-face_rule.asp" rel="noreferrer">supported for all of the regular browsers</a> if you use TrueType-Fonts (TTF) or the Web Open Font Format (WOFF).  

#### Answer 2 (score 116)
You can add some fonts via <a href="http://www.google.com/fonts/" rel="noreferrer">Google Web Fonts</a>.  

Technically, the fonts are hosted at Google and you link them in the HTML header. Then, you can use them freely in CSS with <a href="http://www.w3.org/TR/css3-fonts/#font-face-rule" rel="noreferrer">`@font-face`</a> (<a href="http://www.css3.info/preview/web-fonts-with-font-face/" rel="noreferrer">read about it</a>).  

For example:  

In the `&lt;head&gt;` section:  

```css
 <link href=' http://fonts.googleapis.com/css?family=Droid+Sans' rel='stylesheet' type='text/css'>
```

Then in CSS:  

```css
h1 { font-family: 'Droid Sans', arial, serif; }
```

<hr>

The solution seems quite reliable (even <a href="http://www.smashingmagazine.com/" rel="noreferrer">Smashing Magazine uses it for an article title.</a>). There are, however, not so many fonts available so far in <a href="http://www.google.com/fonts/" rel="noreferrer">Google Font Directory</a>.  

#### Answer 3 (score 74)
The way to go is using the @font-face CSS declaration which allows authors to specify online fonts to display text on their web pages. By allowing authors to provide their own fonts, @font-face eliminates the need to depend on the limited number of fonts users have installed on their computers.  

Take a look at the following table:  

<img src="https://i.stack.imgur.com/fFhYS.png" alt="enter image description here">   

As you can see, there are several formats that you need to know about mainly due to cross-browser compatibility. The scenario in mobile devices isn't much different.  

<h5>Solutions:</h2>

<strong>1 - Full browser compatibility</strong>  

This is the method with the deepest support possible right now:  

```css
@font-face {
  font-family: 'MyWebFont';
  src: url('webfont.eot'); /* IE9 Compat Modes */
  src: url('webfont.eot?#iefix') format('embedded-opentype'), /* IE6-IE8 */
       url('webfont.woff') format('woff'), /* Modern Browsers */
       url('webfont.ttf')  format('truetype'), /* Safari, Android, iOS */
       url('webfont.svg#svgFontName') format('svg'); /* Legacy iOS */
}
```

<strong>2 - Most of the browser</strong>  

Things are <a href="http://caniuse.com/#feat=woff" rel="noreferrer">shifting heavily toward WOFF</a> though, so you can probably get away with:  

```css
@font-face {
  font-family: 'MyWebFont';
  src: url('myfont.woff') format('woff'), /* Chrome 6+, Firefox 3.6+, IE 9+, Safari 5.1+ */
       url('myfont.ttf') format('truetype'); /* Chrome 4+, Firefox 3.5, Opera 10+, Safari 3—5 */
}
```

<strong>3 - Only the latest browsers</strong>  

<p>Or even just WOFF.<br>
You then use it like this:</p>

```css
body {
  font-family: 'MyWebFont', Fallback, sans-serif;
}
```

<h5>References and Further reading:</h2>

That's mainly what you need to know about implementing this feature. If you want to research more on the subject I'll encourage to take a look at the following resources. Most of what I put here is extracted from the following  

<ul>
<li><a href="http://css-tricks.com/snippets/css/using-font-face/" rel="noreferrer">Using Font Face</a> (Very recommended)</li>
<li><a href="http://www.paulirish.com/2009/bulletproof-font-face-implementation-syntax/" rel="noreferrer">Bulletproof @font-face syntax</a></li>
<li><a href="http://caniuse.com/fontface" rel="noreferrer">Can i use @font-face web fonts ?</a></li>
<li><a href="http://blog.themeforest.net/tutorials/how-to-achieve-cross-browser-font-face-support/" rel="noreferrer">How to archive Cross-Browser @font-face support</a></li>
<li><a href="http://blog.themeforest.net/tutorials/how-to-achieve-cross-browser-font-face-support/" rel="noreferrer">@font-face at the CSS Mozilla Developer Network</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: How do you make div elements display inline? (score [829472](https://stackoverflow.com/q/224602) in 2013)

#### Question
Given this HTML:  

```css
<div>foo</div><div>bar</div><div>baz</div>
```

How do you make them display inline like this:  

<blockquote>
  foo bar baz  
</blockquote>

not like this:  

<blockquote>
  <p>foo<br>
  bar<br>
  baz  </p>
</blockquote>

#### Answer accepted (score 252)
That's something else then:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
div.inline { float:left; }
.clearBoth { clear:both; }
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="inline"&gt;1&lt;br /&gt;2&lt;br /&gt;3&lt;/div&gt;
&lt;div class="inline"&gt;1&lt;br /&gt;2&lt;br /&gt;3&lt;/div&gt;
&lt;div class="inline"&gt;1&lt;br /&gt;2&lt;br /&gt;3&lt;/div&gt;
&lt;br class="clearBoth" /&gt;&lt;!-- you may or may not need this --&gt;</code></pre>
</div>
</div>


#### Answer 2 (score 250)
An inline div is a freak of the web &amp; should be beaten until it becomes a span (at least 9 times out of 10)...  

```css
<span>foo</span>
<span>bar</span>
<span>baz</span>
```

...answers the original question...  

#### Answer 3 (score 169)
Try writing it like this:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
div { border: 1px solid #CCC; }
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>    &lt;div style="display: inline"&gt;a&lt;/div&gt;
    &lt;div style="display: inline"&gt;b&lt;/div&gt;
    &lt;div style="display: inline"&gt;c&lt;/div&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 84: Bootstrap NavBar with left, center or right aligned items (score [828222](https://stackoverflow.com/q/19733447) in 2018)

#### Question
In <strong>Bootstrap</strong>, what is the most platform-friendly way to create a navigation bar that has Logo A on the left, menu items in the center, and Logo B on the right?   

Here is what I've tried so far, and it ends up being aligned so that Logo A is on the left, menu items next to the logo on the left and Logo B on the right.  

```css
<div class="navbar navbar-fixed-top navbar-custom ">
  <div class="container" >
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#"><span class="navbar-logo">Logo_A</span></a>
    </div>
    <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Home</a></li>
        <li><a href="#about">Menu Item 1</a></li>
        <li><a href="#contact">Menu Item 2</a></li>
        <li><a href="#about">Menu Item 3</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><img src="images/Logo_B.png" class="img-responsive"></a></li>
      </ul>
    </div>
  </div>
</div>
```

#### Answer 2 (score 654)
<strong><em>2019 Update</em></strong>  

<h5><strong>Bootstrap 4</strong></h1>

Now that Bootstrap 4 has flexbox, Navbar alignment is much easier. Here are <a href="http://www.codeply.com/go/qhaBrcWp3v" rel="noreferrer">updated examples for <strong>left</strong>, <strong>right</strong> and <strong>center</strong> in the Bootstrap 4 Navbar</a>, and <a href="https://www.codeply.com/go/kTGlK9Axdk" rel="noreferrer"><strong>many other alignment scenarios</strong> demonstrated here</a>.  

The <a href="http://getbootstrap.com/docs/4.1/utilities/flex/" rel="noreferrer">flexbox</a>, <a href="http://getbootstrap.com/docs/4.1/utilities/flex/#auto-margins" rel="noreferrer">auto-margins</a>, and <a href="http://getbootstrap.com/docs/4.1/utilities/flex/#order" rel="noreferrer">ordering</a> utility classes can be used to align Navbar content as needed. There are many things to consider including the order and alignment of Navbar items (brand, links, toggler) on both large screens and the mobile/collapsed views. <strong>Don't use the grid classes (row,col) for the Navbar</strong>.  

Here are various examples...  

<strong>Left, center(brand) and right links:</strong>  

<a href="https://i.stack.imgur.com/bYbLJ.png" rel="noreferrer"><img src="https://i.stack.imgur.com/bYbLJ.png" alt="enter image description here"></a>  

```css
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <div class="navbar-collapse collapse w-100 order-1 order-md-0 dual-collapse2">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#">Left</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="//codeply.com">Codeply</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Link</a>
            </li>
        </ul>
    </div>
    <div class="mx-auto order-0">
        <a class="navbar-brand mx-auto" href="#">Navbar 2</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target=".dual-collapse2">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
    <div class="navbar-collapse collapse w-100 order-3 dual-collapse2">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="#">Right</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Link</a>
            </li>
        </ul>
    </div>
</nav>
```

<a href="http://www.codeply.com/go/qhaBrcWp3v" rel="noreferrer">http://www.codeply.com/go/qhaBrcWp3v</a>  

<br>  

Another BS4 Navbar option with <a href="https://www.codeply.com/go/0xSGj0EsAu" rel="noreferrer"><strong>center links and overlay logo image</strong></a>:  

<a href="https://i.stack.imgur.com/VmMkS.png" rel="noreferrer"><img src="https://i.stack.imgur.com/VmMkS.png" alt="center links and overlay logo image"></a>  

```css
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="navbar-collapse collapse w-100 dual-collapse2 order-1 order-md-0">
        <ul class="navbar-nav ml-auto text-center">
            <li class="nav-item active">
                <a class="nav-link" href="#">Link</a>
            </li>
        </ul>
    </div>
    <div class="mx-auto my-2 order-0 order-md-1 position-relative">
        <a class="mx-auto" href="#">
            <img src="//placehold.it/120/ccff00" class="rounded-circle">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target=".dual-collapse2">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
    <div class="navbar-collapse collapse w-100 dual-collapse2 order-2 order-md-2">
        <ul class="navbar-nav mr-auto text-center">
            <li class="nav-item">
                <a class="nav-link" href="#">Link</a>
            </li>
        </ul>
    </div>
</nav>
```

<br>  

<strong>Or</strong>, these other Bootstrap 4 alignment scenarios:  

<a href="https://www.codeply.com/go/Z5klFmvHbW" rel="noreferrer">brand left, dead center links, (empty right)</a><br>  

<a href="https://i.stack.imgur.com/IJl3c.png" rel="noreferrer"><img src="https://i.stack.imgur.com/IJl3c.png" alt="Navbar brand left, dead center links"></a>  

<hr>

<a href="https://www.codeply.com/go/a6OeSIHdLK" rel="noreferrer">brand and links center, icons left and right</a><br>  

<a href="https://i.stack.imgur.com/DNZVY.png" rel="noreferrer"><img src="https://i.stack.imgur.com/DNZVY.png" alt="enter image description here"></a>  

<hr>

<strong>More Bootstrap 4 examples</strong>:  

<p><a href="https://www.codeply.com/go/2GyQyizf61" rel="noreferrer">toggler left on mobile, brand right</a><br>
<a href="https://www.codeply.com/go/zj3wL8Wotk" rel="noreferrer">center brand and links on mobile</a><br>
<a href="https://www.codeply.com/go/1WCDUUa6yz" rel="noreferrer">right align links on desktop, center links on mobile</a><br>
<a href="https://www.codeply.com/go/pG674ErRQg" rel="noreferrer">left links &amp; toggler, center brand, search right</a><br></p>

<hr>

<p>Also see: <a href="https://stackoverflow.com/questions/41513463/bootstrap-4-align-navbar-item-to-the-right">Bootstrap 4 align navbar items to the right</a><br/>
<a href="https://stackoverflow.com/questions/51852374/bootstrap-4-navbar-right-align-with-button-that-doesnt-collapse-on-mobile">Bootstrap 4 navbar right align with button that doesn&#39;t collapse on mobile</a><br/>
<a href="https://stackoverflow.com/questions/33867603/center-an-element-in-bootstrap-4-navbar">Center an element in Bootstrap 4 Navbar</a></p>

<hr>

<h5><strong>Bootstrap 3</strong></h1>

<strong>Option 1</strong> - Brand center, with left/right nav links:  

<a href="https://i.stack.imgur.com/tHJHB.png" rel="noreferrer"><img src="https://i.stack.imgur.com/tHJHB.png" alt="enter image description here"></a>  

```css
<nav class="navbar navbar-default" role="navigation">
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>    
  </div>
  <a class="navbar-brand" href="#">Brand</a>
  <div class="navbar-collapse collapse">
    <ul class="nav navbar-nav navbar-left">
        <li><a href="#">Left</a></li>
        <li><a href="#about">Left</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="#about">Right</a></li>
      <li><a href="#contact">Right</a></li>
    </ul>
  </div>
</nav>

.navbar-brand
{
    position: absolute;
    width: 100%;
    left: 0;
    text-align: center;
    margin:0 auto;
}
.navbar-toggle {
    z-index:3;
}
```

<a href="http://bootply.com/98314" rel="noreferrer">http://bootply.com/98314</a>  

<hr>

<strong>Option 2</strong> - Left, center and right nav links:  

<a href="https://i.stack.imgur.com/fihdg.png" rel="noreferrer"><img src="https://i.stack.imgur.com/fihdg.png" alt="enter image description here"></a>  

```css
<nav class="navbar navbar-default" role="navigation">
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>    
  </div>
  <div class="navbar-collapse collapse">
    <ul class="nav navbar-nav">
        <li><a href="#">Left</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-center">
        <li><a href="#">Center</a></li>
        <li><a href="#">Center</a></li>
      <li><a href="#">Center</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
        <li><a href="#">Right</a></li>
    </ul>
  </div>
</nav>

@media (min-width: 768px) {
  .navbar-nav.navbar-center {
    position: absolute;
    left: 50%;
    transform: translatex(-50%);
  }
}
```

<a href="http://www.bootply.com/SGYC6BWeBK" rel="noreferrer">http://www.bootply.com/SGYC6BWeBK</a>  

<strong>Option 3</strong> - Center both brand and links  

<a href="https://i.stack.imgur.com/llVyZ.png" rel="noreferrer"><img src="https://i.stack.imgur.com/llVyZ.png" alt="enter image description here"></a>  

```css
.navbar .navbar-header,
.navbar-collapse {
    float:none;
    display:inline-block;
    vertical-align: top;
}

@media (max-width: 768px) {
    .navbar-collapse  {
        display: block;
    }
}
```

<a href="http://www.codeply.com/go/1lrdvNH9GI" rel="noreferrer">http://www.codeply.com/go/1lrdvNH9GI</a>  

<strong>More examples:</strong>  

<p><a href="https://www.codeply.com/go/Iyz6G8vOzL" rel="noreferrer">Left brand, center links</a><br>
<a href="https://www.codeply.com/go/VfuMAtIoXi" rel="noreferrer">Left toggler, center brand</a><br></p>

For 3.x also see nav-justified: <a href="https://stackoverflow.com/questions/21453781/bootstrap-center-navbar/21459341#21459341">Bootstrap center navbar</a>  

<hr>

<p><a href="https://stackoverflow.com/questions/39945599/center-navbar-in-bootstrap/42736011#42736011">Center Navbar in Bootstrap</a><br>
<a href="https://stackoverflow.com/questions/41513463/">Bootstrap 4 align navbar items to the right</a><br></p>

#### Answer 3 (score 36)
I needed something similar (left, center and right aligned items), but with ability to mark centered items as active. What worked for me was:  

<a href="http://www.bootply.com/CSI2KcCoEM">http://www.bootply.com/CSI2KcCoEM</a>  

```css
<nav class="navbar navbar-default" role="navigation">
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>    
  </div>
  <div class="navbar-collapse collapse">
    <ul class="nav navbar-nav">
      <li class="navbar-left"><a href="#">Left 1</a></li>
      <li class="navbar-left"><a href="#">Left 2</a></li>
      <li class="active"><a href="#">Center 1</a></li>
      <li><a href="#">Center 2</a></li>
      <li><a href="#">Center 3</a></li>
      <li class="navbar-right"><a href="#">Right 1</a></li>
      <li class="navbar-right"><a href="#">Right 2</a></li>
    </ul>
  </div>
</nav>
```

CSS:  

```css
@media (min-width: 768px) {
  .navbar-nav {
    width: 100%;
    text-align: center;
  }
  .navbar-nav > li {
    float: none;
    display: inline-block;
  }
  .navbar-nav > li.navbar-right {
    float: right !important;
  }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: Responsive image align center bootstrap 3 (score [816165](https://stackoverflow.com/q/18462808) in 2017)

#### Question
I do a catalog using Bootstrap 3. When displayed on tablets, the product images look ugly because of their small size (500x500) and a width of 767 pixels in the browser. I want to put the image in the center of the screen, but for some reason I can not. Who be will help solve the problem?  

<img src="https://i.stack.imgur.com/bwJiHm.jpg" alt="enter image description here">  

#### Answer accepted (score 562)
<em>If you're using Bootstrap v3.0.1 or greater, you should use <a href="https://stackoverflow.com/a/20396826/383609">this solution</a> instead. It doesn't override Bootstrap's styles with custom CSS, but instead uses a Bootstrap feature.</em>  

<em>My original answer is shown below for posterity</em>  

<hr>

This is a pleasantly easy fix. Because `.img-responsive` from Bootstrap already sets `display: block`, you can use `margin: 0 auto` to center the image:  

```css
.product .img-responsive {
    margin: 0 auto;
}
```

#### Answer 2 (score 1147)
There is <a href="https://github.com/twbs/bootstrap/blob/v3.0.1/dist/css/bootstrap.css#L6556-L6560" rel="noreferrer">`.center-block`</a> class in Twitter Bootstrap 3 (<em>Since v3.0.1</em>), so use:  

```css
<img src="..." alt="..." class="img-responsive center-block" />
```

#### Answer 3 (score 103)
Add only the class `center-block` to an image, this works with Bootstrap 4 as well:  

```css
<img src="..." alt="..." class="center-block" />
```

Note: `center-block` works even when `img-responsive` is used  

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: How to set Bullet colors in UL/LI html lists via CSS without using any images or span tags (score [810364](https://stackoverflow.com/q/5306640) in 2017)

#### Question
Imagine a simple unsorted list with some `&lt;li&gt;` items. Now, I have defined the bullets to be square shaped via `list-style:square;` However, if I set the color of the `&lt;li&gt;` items with `color: #F00;` then <em>everything</em> becomes red!  

While I only want to set the color of the square bullets. Is there an <strong>elegant way</strong> to define the color of the bullets in CSS...  

<h5><em>...without using any sprite images nor span tags!</em></h1>

<strong>HTML</strong>  

```css
<ul>
<li>Item 1</li>
<li>Item 2</li>
<li>Item 3</li>
<ul>
```

<strong>CSS</strong>  

```css
li{
   list-style:square;
}
```

#### Answer accepted (score 1011)
The most common way to do this is something along these lines:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

li {
  padding-left: 1em; 
  text-indent: -.7em;
}

li::before {
  content: "• ";
  color: red; /* or whatever color you prefer */
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;ul&gt;
  &lt;li&gt;Foo&lt;/li&gt;
  &lt;li&gt;Bar&lt;/li&gt;
  &lt;li&gt;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.&lt;/li&gt;
&lt;/ul&gt;</code></pre>
</div>
</div>


JSFiddle: <a href="http://jsfiddle.net/leaverou/ytH5P/" rel="noreferrer">http://jsfiddle.net/leaverou/ytH5P/</a>  

Will work in all browsers, including IE from version 8 and up.  

#### Answer 2 (score 88)
browsing sometime ago, found this site, have you tried this alternative?  

```css
li{
    list-style-image: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAAECAYAAACp8Z5+AAAAE0lEQVQIW2NkYGD4D8RwwEi6AACaVAQBULo4sgAAAABJRU5ErkJggg==");
}
```

sounds hard, but you can make your own png image/pattern <strong><a href="http://www.patternify.com/" rel="noreferrer">here</a></strong>, then copy/paste your code and customize your bullets =) stills elegant?  

EDIT:  

following the idea of @lea-verou on the other answer and applying this philosophy of outside sources enhancement I've come to this other solution:  

<ol>
<li>embed in your head the stylesheet of the Webfont icons Library, in this case Font Awesome:</li>
</ol>

`&lt;link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"&gt;`  

<ol start="2">
<li>take a code from FontAwesome <a href="http://fontawesome.io/cheatsheet/" rel="noreferrer">cheatsheet</a> (or any other webfont icons).</li>
</ol>

<blockquote>
```css
i.e.:
fa-angle-right [&#xf105;]
```
</blockquote>

and use the last part of f... followed by a number like this, with the `font-family` too:  

```css
li:before {
    content: "\f105";
    font-family: FontAwesome;
    color: red; /* or whatever color you prefer */
    margin-right: 4px;
}
```

and that's it! now you have custom bullet tips too =)  

<a href="http://jsfiddle.net/ytH5P/5721/" rel="noreferrer">fiddle</a>  

#### Answer 3 (score 46)
I simply solve this problem like this, which should work in all browsers:  

<strong>HTML:</strong>  

<pre class="lang-html prettyprint-override"><code>&lt;ul&gt;
  &lt;li&gt;&lt;span&gt;Foo&lt;/span&gt;&lt;/li&gt;
  &lt;li&gt;&lt;span&gt;Bar&lt;/span&gt;&lt;/li&gt;
  &lt;li&gt;&lt;span&gt;Bat&lt;/span&gt;&lt;/li&gt;
&lt;/ul&gt;
</code></pre>

<p><strong>CSS:</strong>


```css
ul li{
    color: red
}

ul li span{
    color: blue;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: Make body have 100% of the browser height (score [810272](https://stackoverflow.com/q/6654958) in 2014)

#### Question
I want to make body have 100% of the browser height. Can I do that using CSS?  

I tried setting `height: 100%`, but it doesn't work.  

I want to set a background color for a page to fill the entire browser window, but if the page has little content I get a ugly white bar at the bottom.  

#### Answer accepted (score 991)
Try setting the height of the html element to 100% as well.   

```css
html, 
body {
    height: 100%;
}
```

Body looks to its parent (HTML) for how to scale the dynamic property, so the HTML element needs to have its height set as well.   

<p>However the content of body will probably need to change dynamically.
Setting min-height to 100% will accomplish this goal.</p>

```css
html {
  height: 100%;
}
body {
  min-height: 100%;
}
```

#### Answer 2 (score 198)
As an alternative to setting both the `html` and `body` element's heights to `100%`, you could also use viewport-percentage lengths.  

<blockquote>
  <a href="http://www.w3.org/TR/css3-values/#viewport-relative-lengths" rel="noreferrer"><strong>5.1.2. Viewport-percentage lengths: the ‘vw’, ‘vh’, ‘vmin’, ‘vmax’ units</strong></a>  
  
  The viewport-percentage lengths are relative to the size of the initial containing block. When the height or width of the initial containing block is changed, they are scaled accordingly.  
</blockquote>

In this instance, you could use the value `100vh` - which is the height of the viewport.  

<a href="http://jsfiddle.net/dkdsfddz/" rel="noreferrer"><strong>Example Here</strong></a>  

```css
body {
    height: 100vh;
}
```



```css
body {
    min-height: 100vh;
}
```

This is supported in most modern browsers - <a href="http://caniuse.com/#feat=viewport-units" rel="noreferrer">support can be found here</a>.  

#### Answer 3 (score 118)
If you have a background image then you will want to set this instead:  

```css
html{
  height: 100%;
}
body {
  min-height: 100%;
}
```

This ensures that your body tag is allowed to continue growing when the content is taller than the viewport and that the background image continues to repeat/scroll/whatever when you start scrolling down.  

Remember if you have to support IE6 you will need to find a way to wedge in `height:100%` for body, IE6 treats `height` like `min-height` anyway.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: How to style icon color, size, and shadow of Font Awesome Icons (score [807573](https://stackoverflow.com/q/12272372) in 2018)

#### Question
How could I style the color, size and shadow of icons from Font Awesome's <a href="http://fortawesome.github.com/Font-Awesome/#overview">Icons</a>?  

For example, Font Awesome's <a href="http://fortawesome.github.com/Font-Awesome/#overview"> site</a> will show some icons in white and some in red but won't show the `CSS` for how to style them that way ...  

<img src="https://i.stack.imgur.com/kHzqT.png" alt="enter image description here">  

#### Answer accepted (score 449)
Given that they're simply fonts, then you should be able to style them as fonts:  

```css
#elementID {
    color: #fff;
    text-shadow: 1px 1px 1px #ccc;
    font-size: 1.5em;
}
```

#### Answer 2 (score 145)
You can also just add style inline:  

```css
<i class="icon-ok-sign" style="color:green"></i>

<i class="icon-warning-sign" style="color:red"></i>
```

#### Answer 3 (score 102)
If you are using Bootstrap at the same time, you can use:  

```css
<i class="fa fa-check-circle-o fa-5x text-success" ></i>
```

Otherwise:  

```css
<i class="fa fa-check-circle-o fa-5x" style="color:green"></i>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Remove border from IFrame (score [804807](https://stackoverflow.com/q/65034) in 2019)

#### Question
How would I remove the border from an iframe embedded in my web app? An example of the iframe is:  

```css
<iframe src="myURL" width="300" height="300">Browser not compatible.</iframe>
```

I would like the transition from the content on my page to the contents of the iframe to be seamless, assuming the background colors are consistent. The target browser is IE6 only and unfortunately solutions for others will not help.  

#### Answer accepted (score 1080)
Add the `frameBorder` attribute (note the <strong>capital ‘B’</strong>).  

So it would look like:  

```css
<iframe src="myURL" width="300" height="300" frameBorder="0">Browser not compatible.</iframe>
```

#### Answer 2 (score 142)
After going mad trying to remove the border in IE7, I found that the frameBorder attribute is case sensitive.  

You have to set the frameBorder attribute with a capital <strong>B</strong>.  

```css
<iframe frameBorder="0" ></iframe>
```

#### Answer 3 (score 71)
As per <a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe" rel="noreferrer">iframe</a> documentation, frameBorder is deprecated and using the "border" CSS attribute is preferred:  

```css
<iframe src="test.html" style="width: 100%; height: 400px; border: 0"></iframe>
```

<ul>
<li>Note CSS border property does <strong>not</strong> achieve the desired results in IE6, 7 or 8.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Fixed position but relative to container (score [803251](https://stackoverflow.com/q/6794000) in 2015)

#### Question
I am trying to fix a `div` so it always sticks to the top of the screen, using:  

```css
position: fixed;
top: 0px;
right: 0px;
```

However, the `div` is inside a centered container. When I use `position:fixed` it fixes the `div` relative to the browser window, such as it's up against the right side of the browser. Instead, it should be fixed relative to the container.  

I know that `position:absolute` can be used to fix an element relative to the `div`, but when you scroll down the page the element vanishes and doesn't stick to the top as with `position:fixed`.  

Is there a hack or workaround to achieve this?  

#### Answer accepted (score 383)
Short answer: <s>no.</s> (It is now possible with CSS transform.  See the edit below)  

Long answer: The problem with using "fixed" positioning is that it takes the element <strong>out of flow</strong>. thus it can't be re-positioned relative to its parent because it's as if it didn't have one.  If, however, the container is of a fixed, known width, you can use something like:  

```css
#fixedContainer {
  position: fixed;
  width: 600px;
  height: 200px;
  left: 50%;
  top: 0%;
  margin-left: -300px; /*half the width*/
}
```

<a href="http://jsfiddle.net/HFjU6/1/" rel="noreferrer">http://jsfiddle.net/HFjU6/1/</a>  

<h5>Edit (03/2015):</h3>

This is outdated information.  It is now possible to center content of an dynamic size (horizontally and vertically) with the help of the magic of CSS3 transform.  The same principle applies, but instead of using margin to offset your container, you can use `translateX(-50%)`.  This doesn't work with the above margin trick because you don't know how much to offset it unless the width is fixed and you can't use relative values (like `50%`) because it will be relative to the parent and not the element it's applied to.  `transform` behaves differently.  Its values are relative to the element they are applied to.  Thus, `50%` for `transform` means half the width of the element, while `50%` for margin is half of the parent's width. This is an <a href="http://caniuse.com/#feat=transforms2d" rel="noreferrer">IE9+ solution</a>  

Using similar code to the above example, I recreated the same scenario using completely dynamic width and height:  

```css
.fixedContainer {
    background-color:#ddd;
    position: fixed;
    padding: 2em;
    left: 50%;
    top: 0%;
    transform: translateX(-50%);
}
```

If you want it to be centered, you can do that too:  

```css
.fixedContainer {
    background-color:#ddd;
    position: fixed;
    padding: 2em;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
}
```

<h5>Demos:</h3>

<p><a href="http://jsfiddle.net/b2jz1yvr/" rel="noreferrer">jsFiddle: Centered horizontally only</a><br/>
<a href="http://jsfiddle.net/b2jz1yvr/1/" rel="noreferrer">jsFiddle: Centered both horizontally and vertically</a>
<br/>Original credit goes to user <a href="https://stackoverflow.com/users/1387396/aaronk6">aaronk6</a> for pointing it out to me in <a href="https://stackoverflow.com/a/28773941/854246">this answer</a></p>

#### Answer 2 (score 169)
Actually this is possible and the accepted answer only deals with centralising, which is straightforward enough. Also you really don't need to use JavaScript.  

<h5>This will let you deal with any scenario:</h3>

Set everything up as you would if you want to position: absolute inside a position: relative container, and then create a new fixed position div inside the div with `position: absolute`, but do <strong>not</strong> set its top and left properties. It will then be fixed wherever you want it, relative to the container.  

For example:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
/* Main site body */
.wrapper {
    width: 940px;
    margin: 0 auto;
    position: relative; /* Ensure absolute positioned child elements are relative to this*/
}

/* Absolute positioned wrapper for the element you want to fix position */
.fixed-wrapper {
    width: 220px;
    position: absolute;
    top: 0;
    left: -240px; /* Move this out to the left of the site body, leaving a 20px gutter */
}

/* The element you want to fix the position of */
.fixed {
    width: 220px;
    position: fixed;
    /* Do not set top / left! */
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="wrapper"&gt;
    &lt;div class="fixed-wrapper"&gt;
        &lt;div class="fixed"&gt;
            Content in here will be fixed position, but 240px to the left of the site body.
        &lt;/div&gt;
    &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


Sadly, I was hoping this thread might solve my issue with Android's <a href="http://en.wikipedia.org/wiki/WebKit" rel="noreferrer">WebKit</a> rendering box-shadow blur pixels as margins on fixed position elements, but it seems it's a bug.<br/> Anyway, I hope this helps!  

#### Answer 3 (score 128)
<h5>Yes, according to the specs, there is a way.</h1>

<em>While I agree that Graeme Blackwood's should be the accepted answer, because it practically solves the issue, it should be noted that a fixed element <strong>can</strong> be positioned relatively to its container.</em>  

I noticed by accident that when applying  

```css
-webkit-transform: translateZ(0);
```

to the body, it made a fixed child relative to it (instead of the viewport). So my fixed elements `left` and `top` properties were now relative to the container.  

So I did some research, and found that the issue was already been covered by <a href="http://meyerweb.com/eric/thoughts/2011/09/12/un-fixing-fixed-elements-with-css-transforms/">Eric Meyer</a> and even if it felt like a "trick", turns out that this is part of the specifications:  

<blockquote>
  <p>For elements whose layout is governed by the CSS box model, any value
  other than none for the transform results in the creation of both a
  stacking context and a containing block. The object acts as a
  containing block for fixed positioned descendants.</p>
</blockquote>

<a href="http://www.w3.org/TR/css3-transforms/">http://www.w3.org/TR/css3-transforms/</a>  

So, if you apply any transformation to a parent element, it will become the containing block.  

<h5>But...</h1>

The problem is that the implementation seems buggy/creative, because the elements also stop behaving as fixed (even if this bit doesn't seem to be part of specification).  

The same behavior will be found in Safari, Chrome and Firefox, but not in IE11 (where the fixed element will still remain fixed).  

Another interesting (undocumented) thing is that when a fixed element is contained inside a transformed element, while its `top` and `left` properties will now be related to the container, respecting the `box-sizing` property, its scrolling context will extend over the border of the element, as if box-sizing was set to `border-box`. For some creative out there, this could possibly become a plaything :)  

<a href="http://jsfiddle.net/frapporti/DYGan/"><strong>TEST</strong></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: How do I center float elements? (score [800209](https://stackoverflow.com/q/4767971) in 2016)

#### Question
I'm implementing pagination, and it needs to be centered. The problem is that the links need to be displayed as block, so they need to be floated. But then, `text-align: center;` doesn't work on them. I could achieve it by giving the wrapper div padding of left, but every page will have a different number of pages, so that wouldn't work. Here's my code:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
.pagination {
  text-align: center;
}
.pagination a {
  display: block;
  width: 30px;
  height: 30px;
  float: left;
  margin-left: 3px;
  background: url(/images/structure/pagination-button.png);
}
.pagination a.last {
  width: 90px;
  background: url(/images/structure/pagination-button-last.png);
}
.pagination a.first {
  width: 60px;
  background: url(/images/structure/pagination-button-first.png);
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class='pagination'&gt;
  &lt;a class='first' href='#'&gt;First&lt;/a&gt;
  &lt;a href='#'&gt;1&lt;/a&gt;
  &lt;a href='#'&gt;2&lt;/a&gt;
  &lt;a href='#'&gt;3&lt;/a&gt;
  &lt;a class='last' href='#'&gt;Last&lt;/a&gt;
&lt;/div&gt;
&lt;!-- end: .pagination --&gt;</code></pre>
</div>
</div>


To get the idea, what I want:  

<img src="https://i.stack.imgur.com/XYZzC.jpg" alt="alt text">  

#### Answer accepted (score 390)
Removing `float`s, and using `inline-block` may fix your problems:  

```css
 .pagination a {
-    display: block;
+    display: inline-block;
     width: 30px;
     height: 30px;
-    float: left;
     margin-left: 3px;
     background: url(/images/structure/pagination-button.png);
 }
```

(remove the lines starting with `-` and add the lines starting with `+`.)  

<p><div class="snippet" data-lang="js" data-hide="true" data-console="true" data-babel="false">
<div class="snippet-code snippet-currently-hidden">
```css
.pagination {
  text-align: center;
}
.pagination a {
  + display: inline-block;
  width: 30px;
  height: 30px;
  margin-left: 3px;
  background: url(/images/structure/pagination-button.png);
}
.pagination a.last {
  width: 90px;
  background: url(/images/structure/pagination-button-last.png);
}
.pagination a.first {
  width: 60px;
  background: url(/images/structure/pagination-button-first.png);
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class='pagination'&gt;
  &lt;a class='first' href='#'&gt;First&lt;/a&gt;
  &lt;a href='#'&gt;1&lt;/a&gt;
  &lt;a href='#'&gt;2&lt;/a&gt;
  &lt;a href='#'&gt;3&lt;/a&gt;
  &lt;a class='last' href='#'&gt;Last&lt;/a&gt;
&lt;/div&gt;
&lt;!-- end: .pagination --&gt;</code></pre>
</div>
</div>


`inline-block` works cross-browser, even on IE6 as long as the element is originally an inline element.  

Quote from <a href="http://www.quirksmode.org/css/display.html#inlineblock">quirksmode</a>:   

<blockquote>
  An inline block is placed inline (ie. on the same line as adjacent content), but it behaves as a block.  
</blockquote>

this often can effectively replace floats:   

<blockquote>
  The real use of this value is when you want to give an inline element a width. In some circumstances some browsers don't allow a width on a real inline element, but if you switch to display: inline-block you are allowed to set a width.” ( <a href="http://www.quirksmode.org/css/display.html#inlineblock">http://www.quirksmode.org/css/display.html#inlineblock</a> ).  
</blockquote>

From the <a href="http://www.w3.org/TR/CSS2/visuren.html#display-prop">W3C spec</a>:  

<blockquote>
  [inline-block] causes an element to generate an inline-level block container. The inside of an  inline-block is formatted as a block box, and the element itself is formatted as an atomic inline-level box.  
</blockquote>

#### Answer 2 (score 146)
Since many years I use an old trick I learned in some blog, I'm sorry i don't remember the name to give him credits.  

Anyway to center floating elements this should work:  

You need a structure like this:  

<p><div class="snippet" data-lang="js" data-hide="false">
<div class="snippet-code">
```css
    .main-container {
      float: left;
      position: relative;
      left: 50%;
    }
    .fixer-container {
      float: left;
      position: relative;
      left: -50%;
    }
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="main-container"&gt;
  &lt;div class="fixer-container"&gt;
    &lt;ul class="list-of-floating-elements"&gt;

      &lt;li class="floated"&gt;Floated element&lt;/li&gt;
      &lt;li class="floated"&gt;Floated element&lt;/li&gt;
      &lt;li class="floated"&gt;Floated element&lt;/li&gt;

    &lt;/ul&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


the trick is giving float left to make the containers change the width depending on the content. Than is a matter of position:relative and left 50% and -50% on the two containers.  

The good thing is that this is cross browser and should work from IE7+.  

#### Answer 3 (score 32)
<strong>Centering floats is easy</strong>. Just use the style for container:  

```css
.pagination{ display: table; margin: 0 auto; }
```

change the margin for floating elements:  

```css
.pagination a{ margin: 0 2px; }
```

or  

```css
.pagination a{ margin-left: 3px; }
.pagination a.first{ margin-left: 0; } 
```

and leave the rest as it is.  

It's the best solution for me to display things like menus or pagination.  

Strengths:  

<ul>
<li><p>cross-browser for any elements (blocks, list-items etc.)</p></li>
<li><p>simplicity </p></li>
</ul>

Weaknesses:  

<ul>
<li>it works only when all floating elements are in one line (which is usually ok for menus but not for galleries).</li>
</ul>

@arnaud576875 Using <strong>inline-block</strong> elements will work great (cross-browser) in this case as pagination contains just anchors (inline), no list-items or divs:  

Strengths:  

<ul>
<li>works for multiline items.</li>
</ul>

Weknesses:  

<ul>
<li><p><strong>gaps between inline-block elements</strong> - it works the same way as a space between words. It may cause some troubles calculating the width of the container and styling margins. Gaps width isn't constant but it's browser specific (4-5px).
To get rid of this gaps I would add to arnaud576875 code (not fully tested):</p>

.pagination{ word-spacing: -1em; }  

.pagination a{ word-spacing: .1em; }  </li>
<li><p>it won't work in IE6/7 on block and list-items elements</p></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: AngularJS ngClass conditional (score [797735](https://stackoverflow.com/q/16529825) in 2019)

#### Question
Is there any way to make an expression for something like <a href="https://docs.angularjs.org/api/ng/directive/ngClass" rel="noreferrer">`ng-class`</a> to be a conditional?  

For example, I have tried the following:  

```css
<span ng-class="{test: 'obj.value1 == \'someothervalue\''}">test</span>
```

The issue with this code is that no matter what `obj.value1` is, the class test is always applied to the element. Doing this:  

```css
<span ng-class="{test: obj.value2}">test</span>
```

As long as `obj.value2` does not equal a truthy value, the class in not applied.  Now I can work around the issue in the first example by doing this:  

```css
<span ng-class="{test: checkValue1()}">test</span>
```

Where the `checkValue1` function looks like this:  

```css
$scope.checkValue1 = function() {
  return $scope.obj.value === 'somevalue';
}
```

I am just wondering if this is how `ng-class` is supposed to work.  I am also building a custom directive where I would like to do something similar to this. However, I can't find a way to watch an expression (and maybe that is impossible and the reason why it works like this).  

Here is a <a href="http://plnkr.co/edit/iSh0t8swDEyGbh7ylZg2?p=preview" rel="noreferrer">plnkr</a> to show what I mean.  

#### Answer accepted (score 570)
Your first attempt was almost right, It should work without the quotes.  

```css
{test: obj.value1 == 'someothervalue'}
```

Here is a <a href="http://plnkr.co/edit/j4r8MDt3Q77NFJlhv7oQ?p=preview" rel="noreferrer">plnkr</a>.  

<p>The ngClass directive will work with any expression that evaluates truthy or falsey, a bit similar to Javascript expressions but with some differences, you can read about <a href="http://docs.angularjs.org/guide/expression" rel="noreferrer">here</a>.
If your conditional is too complex, then you can use a function that returns truthy or falsey, as you did in your third attempt.</p>

Just to complement: You can also use logical operators to form logical expressions like   

```css
ng-class="{'test': obj.value1 == 'someothervalue' || obj.value2 == 'somethingelse'}"
```

#### Answer 2 (score 220)
Using ng-class inside ng-repeat  

```css
<table>
    <tbody>
            <tr ng-repeat="task in todos"
                ng-class="{'warning': task.status == 'Hold' , 'success': task.status == 'Completed',
              'active': task.status == 'Started', 'danger': task.status == 'Pending' } ">
                <td>{{$index + 1}}</td>
                <td>{{task.name}}</td>
                <td>{{task.date|date:'yyyy-MM-dd'}}</td>
                <td>{{task.status}}</td>
            </tr>
    </tbody>
</table>
```

For each status in task.status a different class is used for the row.  

#### Answer 3 (score 107)
<strong>Angular JS</strong> provide this functionality in <strong><a href="https://docs.angularjs.org/api/ng/directive/ngClass">ng-class Directive</a></strong>. In which you can put condition and also assign conditional class. You can achieve this in two different ways.  

<h5>Type 1</h1>

```css
<div ng-class="{0:'one', 1:'two',2:'three'}[status]"></div>
```

In this code class will be apply according to value of <strong>status</strong> value  

if <strong>status</strong> value is <strong>0</strong> then apply class <strong>one</strong>  

if <strong>status</strong> value is <strong>1</strong> then apply class <strong>two</strong>  

if <strong>status</strong> value is <strong>2</strong> then apply class <strong>three</strong>  

<hr>

<h5>Type 2</h1>

```css
<div ng-class="{1:'test_yes', 0:'test_no'}[status]"></div>
```

In which class will be apply by value of <strong>status</strong>  

if <strong>status</strong> value is <strong>1 or true</strong> then it will add class <strong>test_yes</strong>  

if <strong>status</strong> value is <strong>0 or false</strong> then it will add class <strong>test_no</strong>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: How do I right align div elements? (score [795939](https://stackoverflow.com/q/7693224) in 2018)

#### Question
The body of my html document consists of 3 elements, a button, a form, and a canvas. I want the button and the form to be right aligned and the canvas to stay left aligned. The problem is when I try to align the first two elements, they no longer follow each other and instead are next to each other horizontally?, heres the code I have so far, I want the form to follow directly after the button on the right with no space in between.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
#cTask {
  background-color: lightgreen;
}

#button {
  position: relative;
  float: right;
}

#addEventForm {
  position: relative;
  float: right;
  border: 2px solid #003B62;
  font-family: verdana;
  background-color: #B5CFE0;
  padding-left: 10px;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;!DOCTYPE html&gt;
&lt;html lang="en"&gt;
&lt;head&gt;
  &lt;script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.js"&gt;&lt;/script&gt;
  &lt;script type="text/javascript" src="timeline.js"&gt;&lt;/script&gt;
  &lt;link rel="stylesheet" href="master.css" type="text/css" media="screen" /&gt;
&lt;/head&gt;

&lt;body bgcolor="000" TEXT="FFFFFF"&gt;
  &lt;div id="button"&gt;
    &lt;button onclick="showForm()" type="button" id="cTask"&gt;
        Create Task
    &lt;/button&gt;
  &lt;/div&gt;
  &lt;div id="addEventForm"&gt;
    &lt;form&gt;
      &lt;p&gt;&lt;label&gt;Customer name: &lt;input&gt;&lt;/label&gt;&lt;/p&gt;
      &lt;p&gt;&lt;label&gt;Telephone: &lt;input type=tel&gt;&lt;/label&gt;&lt;/p&gt;
      &lt;p&gt;&lt;label&gt;E-mail address: &lt;input type=email&gt;&lt;/label&gt;&lt;/p&gt;
    &lt;/form&gt;
  &lt;/div&gt;
  &lt;div&gt;
    &lt;canvas id="myBoard" width="1000" height="600"&gt;
      &lt;p&gt;Your browser doesn't support canvas.&lt;/p&gt;
    &lt;/canvas&gt;
  &lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;</code></pre>
</div>
</div>


#### Answer accepted (score 263)
You can make a div that contains both the form &amp; the button, then make the div float to the right by setting `float: right;`.  

#### Answer 2 (score 403)
floats are ok, but problematic with ie6 &amp; 7.  

i'd prefer to use `margin-left:auto; margin-right:0;` on the inner div.  

#### Answer 3 (score 140)
Old answers.  An update: use flexbox, pretty much works in all browsers now.  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div style="display: flex; justify-content: flex-end"&gt;
  &lt;div&gt;I'm on the right&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


And you can get even fancier, simply:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div style="display: flex; justify-content: space-around"&gt;
  &lt;div&gt;Left&lt;/div&gt;
  &lt;div&gt;Right&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


And fancier:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div style="display: flex; justify-content: space-around"&gt;
   &lt;div&gt;Left&lt;/div&gt;
   &lt;div&gt;Middle&lt;/div&gt;
  &lt;div&gt;Right&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


</b> </em> </i> </small> </strong> </sub> </sup>

### 94: How to make Twitter Bootstrap menu dropdown on hover rather than click (score [793142](https://stackoverflow.com/q/8878033) in 2017)

#### Question
I'd like to have my Bootstrap menu automatically drop down on hover, rather than having to click the menu title. I'd also like to lose the little arrows next to the menu titles.  

#### Answer accepted (score 574)
I created a pure on hover dropdown menu based on the latest (v2.0.2) Bootstrap framework that has support for multiple submenus and thought I'd post it for future users:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
```css
body {
  padding-top: 60px;
  padding-bottom: 40px;
}

.sidebar-nav {
  padding: 9px 0;
}

.dropdown-menu .sub-menu {
  left: 100%;
  position: absolute;
  top: 0;
  visibility: hidden;
  margin-top: -1px;
}

.dropdown-menu li:hover .sub-menu {
  visibility: visible;
}

.dropdown:hover .dropdown-menu {
  display: block;
}

.nav-tabs .dropdown-menu,
.nav-pills .dropdown-menu,
.navbar .dropdown-menu {
  margin-top: 0;
}

.navbar .sub-menu:before {
  border-bottom: 7px solid transparent;
  border-left: none;
  border-right: 7px solid rgba(0, 0, 0, 0.2);
  border-top: 7px solid transparent;
  left: -7px;
  top: 10px;
}

.navbar .sub-menu:after {
  border-top: 6px solid transparent;
  border-left: none;
  border-right: 6px solid #fff;
  border-bottom: 6px solid transparent;
  left: 10px;
  top: 11px;
  left: -6px;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" /&gt;

&lt;div class="navbar navbar-fixed-top"&gt;
  &lt;div class="navbar-inner"&gt;
    &lt;div class="container-fluid"&gt;
      &lt;a data-target=".nav-collapse" data-toggle="collapse" class="btn btn-navbar"&gt;
        &lt;span class="icon-bar"&gt;&lt;/span&gt;
        &lt;span class="icon-bar"&gt;&lt;/span&gt;
        &lt;span class="icon-bar"&gt;&lt;/span&gt;
      &lt;/a&gt;
      &lt;a href="#" class="brand"&gt;Project name&lt;/a&gt;
      &lt;div class="nav-collapse"&gt;
        &lt;ul class="nav"&gt;
          &lt;li class="active"&gt;&lt;a href="#"&gt;Home&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href="#"&gt;Link&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href="#"&gt;Link&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href="#"&gt;Link&lt;/a&gt;&lt;/li&gt;
          &lt;li class="dropdown"&gt;
            &lt;a data-toggle="dropdown" class="dropdown-toggle" href="#"&gt;Dropdown &lt;b class="caret"&gt;&lt;/b&gt;&lt;/a&gt;
            &lt;ul class="dropdown-menu"&gt;
              &lt;li&gt;
                &lt;a href="#"&gt;2-level Dropdown &lt;i class="icon-arrow-right"&gt;&lt;/i&gt;&lt;/a&gt;
                &lt;ul class="dropdown-menu sub-menu"&gt;
                  &lt;li&gt;&lt;a href="#"&gt;Action&lt;/a&gt;&lt;/li&gt;
                  &lt;li&gt;&lt;a href="#"&gt;Another action&lt;/a&gt;&lt;/li&gt;
                  &lt;li&gt;&lt;a href="#"&gt;Something else here&lt;/a&gt;&lt;/li&gt;
                  &lt;li class="divider"&gt;&lt;/li&gt;
                  &lt;li class="nav-header"&gt;Nav header&lt;/li&gt;
                  &lt;li&gt;&lt;a href="#"&gt;Separated link&lt;/a&gt;&lt;/li&gt;
                  &lt;li&gt;&lt;a href="#"&gt;One more separated link&lt;/a&gt;&lt;/li&gt;
                &lt;/ul&gt;
              &lt;/li&gt;
              &lt;li&gt;&lt;a href="#"&gt;Another action&lt;/a&gt;&lt;/li&gt;
              &lt;li&gt;&lt;a href="#"&gt;Something else here&lt;/a&gt;&lt;/li&gt;
              &lt;li class="divider"&gt;&lt;/li&gt;
              &lt;li class="nav-header"&gt;Nav header&lt;/li&gt;
              &lt;li&gt;&lt;a href="#"&gt;Separated link&lt;/a&gt;&lt;/li&gt;
              &lt;li&gt;&lt;a href="#"&gt;One more separated link&lt;/a&gt;&lt;/li&gt;
            &lt;/ul&gt;
          &lt;/li&gt;
        &lt;/ul&gt;
        &lt;form action="" class="navbar-search pull-left"&gt;
          &lt;input type="text" placeholder="Search" class="search-query span2"&gt;
        &lt;/form&gt;
        &lt;ul class="nav pull-right"&gt;
          &lt;li&gt;&lt;a href="#"&gt;Link&lt;/a&gt;&lt;/li&gt;
          &lt;li class="divider-vertical"&gt;&lt;/li&gt;
          &lt;li class="dropdown"&gt;
            &lt;a class="#" href="#"&gt;Menu&lt;/a&gt;
          &lt;/li&gt;
        &lt;/ul&gt;
      &lt;/div&gt;
      &lt;!-- /.nav-collapse --&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;

&lt;hr&gt;

&lt;ul class="nav nav-pills"&gt;
  &lt;li class="active"&gt;&lt;a href="#"&gt;Regular link&lt;/a&gt;&lt;/li&gt;
  &lt;li class="dropdown"&gt;
    &lt;a href="#" data-toggle="dropdown" class="dropdown-toggle"&gt;Dropdown &lt;b class="caret"&gt;&lt;/b&gt;&lt;/a&gt;
    &lt;ul class="dropdown-menu" id="menu1"&gt;
      &lt;li&gt;
        &lt;a href="#"&gt;2-level Menu &lt;i class="icon-arrow-right"&gt;&lt;/i&gt;&lt;/a&gt;
        &lt;ul class="dropdown-menu sub-menu"&gt;
          &lt;li&gt;&lt;a href="#"&gt;Action&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href="#"&gt;Another action&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href="#"&gt;Something else here&lt;/a&gt;&lt;/li&gt;
          &lt;li class="divider"&gt;&lt;/li&gt;
          &lt;li class="nav-header"&gt;Nav header&lt;/li&gt;
          &lt;li&gt;&lt;a href="#"&gt;Separated link&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href="#"&gt;One more separated link&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
      &lt;/li&gt;
      &lt;li&gt;&lt;a href="#"&gt;Another action&lt;/a&gt;&lt;/li&gt;
      &lt;li&gt;&lt;a href="#"&gt;Something else here&lt;/a&gt;&lt;/li&gt;
      &lt;li class="divider"&gt;&lt;/li&gt;
      &lt;li&gt;&lt;a href="#"&gt;Separated link&lt;/a&gt;&lt;/li&gt;
    &lt;/ul&gt;
  &lt;/li&gt;
  &lt;li class="dropdown"&gt;
    &lt;a href="#"&gt;Menu&lt;/a&gt;
  &lt;/li&gt;
  &lt;li class="dropdown"&gt;
    &lt;a href="#"&gt;Menu&lt;/a&gt;
  &lt;/li&gt;
&lt;/ul&gt;</code></pre>
</div>
</div>


<a href="http://jsfiddle.net/2Smgv/3100/" rel="noreferrer">Demo</a>  

#### Answer 2 (score 905)
To get the menu to automatically drop on hover then this can achieved using basic CSS. You need to work out the selector to the hidden menu option and then set it to display as block when the appropriate `li` tag is hovered over. Taking the example from the twitter bootstrap page, the selector would be as follows:  

```css
ul.nav li.dropdown:hover > ul.dropdown-menu {
    display: block;    
}
```

However, if you are using Bootstrap's responsive features, you will not want this functionality on a collapsed navbar (on smaller screens). To avoid this, wrap the code above in a media query:  

```css
@media (min-width: 979px) {
  ul.nav li.dropdown:hover > ul.dropdown-menu {
    display: block;
  }
}
```

<hr>

To hide the arrow (caret) this is done in different ways depending on whether you are using Twitter Bootstrap version 2 and lower or version 3:  

<b>Bootstrap 3</b>  

To remove the caret in version 3 you just need to remove the HTML `&lt;b class="caret"&gt;&lt;/b&gt;` from the `.dropdown-toggle` anchor element:  

<pre class="lang-html prettyprint-override"><code>&lt;a class="dropdown-toggle" data-toggle="dropdown" href="#"&gt;
    Dropdown
    &lt;b class="caret"&gt;&lt;/b&gt;    &lt;-- remove this line
&lt;/a&gt;
</code></pre>

<b>Bootstrap 2 &amp; lower</b>  

To remove the caret in version 2 you need a little more insight into CSS and I suggest looking at how the `:after` pseudo element works in more detail. To get you started on your way to understanding, to target and remove the arrows in the twitter bootstrap example, you would use the following CSS selector and code:  

```css
a.menu:after, .dropdown-toggle:after {
    content: none;
}
```

It will work in your favour if you look further into how these work and not just use the answers that I have given you.  

<strong><em>Thanks to @CocaAkat for pointing out that we were missing the ">" child combinator to prevent sub menus being shown on the parent hover</em></strong>  

#### Answer 3 (score 228)
In addition to the answer from "My Head Hurts" (which was great):  

```css
ul.nav li.dropdown:hover ul.dropdown-menu{
    display: block;    
}
```

There are 2 lingering issues:  

<ol>
<li>Clicking on the dropdown link will open the dropdown-menu. And it will stay open unless the user clicks somewhere else, or hovers back over it, creating an awkward UI.</li>
<li>There is a 1px margin between the dropdown link, and dropdown-menu. This causes the dropdown-menu to become hidden if you move slowly between the dropdown and dropdown-menu.</li>
</ol>

The solution to (1) is removing the "class" and "data-toggle" elements from the nav link  

```css
<a href="#">
     Dropdown
     <b class="caret"></b>
</a>
```

This also gives you the ability to create a link to your parent page - which wasn't possible with the default implementation. You can just replace the "#" with whatever page you want to send the user.  

The solution to (2) is removing the margin-top on the .dropdown-menu selector  

```css
.navbar .dropdown-menu {
 margin-top: 0px;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: Bootstrap 3 Navbar with Logo (score [792825](https://stackoverflow.com/q/18474564) in 2014)

#### Question
I want to use the Bootstrap 3 default navbar with an image logo instead of text branding. What's the proper way of doing this without causing any issues with different screen sizes? I assume this a common requirement, but I haven't yet seen a good code sample. A key requirement other than having acceptable display on all screen sizes is the menu collapsibility on smaller screens.  

I tried just putting an IMG tag inside the A tag that has the navbar-brand class, but that caused the menu not to function properly on my android phone. I also tried increasing the height of the navbar class, but that screwed things up even more.  

By the way, my logo image is larger than the height of the navbar.  

#### Answer 2 (score 415)
Why is everyone trying to do it the hard way?  Sure, some of these approaches will work, but they're more complicated than is necessary.  

OK, first - you need an image that will fit within your navbar.  You can adjust your image via css height attribute (allowing width to scale) or you can just use an appropriately sized image.  Whatever you decide to do - the way this looks will depend on how well you size your image.  

For some reason, everyone wants to stick the image inside of an anchor with `navbar-brand`, and this isn't necessary.  `navbar-brand` applies text styles that aren't necessary to an image, as well as the `navbar-left` class (just like pull-left, but for use in a navbar).  All you really need is to add `navbar-left`.  

<pre class="lang-html prettyprint-override"><code>&lt;a href="#" class="navbar-left"&gt;&lt;img src="/path/to/image.png"&gt;&lt;/a&gt;
</code></pre>

You can even follow this with a navbar-brand item, which will appear to the right of the image.  

#### Answer 3 (score 147)
```css
<div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" 
            data-target=".navbar-ex1-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" rel="home" href="#" title="Buy Sell Rent Everyting">
        <img style="max-width:100px; margin-top: -7px;"
             src="/img/transparent-white-logo.png">
    </a>
</div>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: How to set up fixed width for \<td>? (score [792029](https://stackoverflow.com/q/15115052) in 2019)

#### Question
Simple scheme:  

```css
  <tr class="something">
    <td>A</td>
    <td>B</td>
    <td>C</td>
    <td>D</td>
  </tr>
```

I need to set up a fixed width for `&lt;td&gt;`. I've tried:  

```css
tr.something {
  td {
    width: 90px;
  }
}
```

Also  

```css
td.something {
  width: 90px;
}
```

for   

```css
<td class="something">B</td>
```

And even  

```css
<td style="width: 90px;">B</td>
```

But the width of `&lt;td&gt;` is still the same.  

#### Answer accepted (score 987)
<h5>For Bootstrap 4.0:</h2>

<p>In Bootstrap 4.0.0 you cannot use the `col-*` classes reliably (works in Firefox, but not in Chrome).
You need to use <a href="https://stackoverflow.com/a/34987484/2256700">OhadR's answer</a>:</p>

```css
<tr>
  <th style="width: 16.66%">Col 1</th>
  <th style="width: 25%">Col 2</th>
  <th style="width: 50%">Col 4</th>
  <th style="width:  8.33%">Col 5</th>
</tr>
```

<h5>For Bootstrap 3.0:</h2>

With twitter bootstrap 3 use: `class="col-md-*"` where * is a number of columns of width.  

```css
<tr class="something">
    <td class="col-md-2">A</td>
    <td class="col-md-3">B</td>
    <td class="col-md-6">C</td>
    <td class="col-md-1">D</td>
</tr>
```

<h5>For Bootstrap 2.0:</h2>

With twitter bootstrap 2 use: `class="span*"` where * is a number of columns of width.  

```css
<tr class="something">
    <td class="span2">A</td>
    <td class="span3">B</td>
    <td class="span6">C</td>
    <td class="span1">D</td>
</tr>
```

** If you have `&lt;th&gt;` elements set the width there and not on the `&lt;td&gt;` elements.  

#### Answer 2 (score 120)
I was having the same issue, I made the table fixed and then specified my td width. If you have th you can do those as well.  

```css
table {
    table-layout: fixed;
    word-wrap: break-word;
}
```

Template:  

```css
<td style="width:10%">content</td>
```

Please use CSS for structuring any layouts.  

#### Answer 3 (score 70)
Instead of applying the `col-md-*` classes to each `td` in the row you can create a `colgroup` and apply the classes to the `col` tag.  

```css
    <table class="table table-striped">
        <colgroup>
            <col class="col-md-4">
            <col class="col-md-7">
        </colgroup>
        <tbody>
        <tr>
            <td>Title</td>
            <td>Long Value</td>
        </tr>
        </tbody>
    </table>
```

Demo <a href="http://www.bootply.com/rNvsMxe7d8" rel="noreferrer">here</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: How can I make Bootstrap columns all the same height? (score [779166](https://stackoverflow.com/q/19695784) in 2017)

#### Question
I'm using Bootstrap. How can I make three columns all the same height?  

Here is a screenshot of the problem. I would like the blue and red columns to be the same height as the yellow column.   

<img src="https://i.stack.imgur.com/PLP7h.png" alt="Three bootstrap columns with the center column longer than the other two columns">  

Here is the code:   

<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">
<div class="snippet-code">
<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/&gt;
&lt;div class="container-fluid"&gt;
&lt;div class="row"&gt;
    &lt;div class="col-xs-4 panel" style="background-color: red"&gt;
        some content
    &lt;/div&gt;
    &lt;div class="col-xs-4 panel" style="background-color: yellow"&gt;
        catz
        &lt;img width="100" height="100" src="https://lorempixel.com/100/100/cats/"&gt;
    &lt;/div&gt;
    &lt;div class="col-xs-4 panel" style="background-color: blue"&gt;
        some more content
    &lt;/div&gt;
&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


#### Answer accepted (score 996)
<strong>Solution 4 using Bootstrap 4</strong>  

Bootstrap 4 uses Flexbox so there's need for extra CSS.   

<a href="http://jsfiddle.net/fs84o9q7/" rel="noreferrer">Demo</a>  

```css
<div class="container">
    <div class="row ">
        <div class="col-md-4" style="background-color: red">
          some content
        </div>
        <div class="col-md-4" style="background-color: yellow">
          catz
          <img width="100" height="100" src="https://lorempixel.com/100/100/cats/">
        </div>
        <div class="col-md-4" style="background-color: green">
          some more content
        </div>
    </div>
</div>
```

<strong>Solution 1 using negative margins (doesn't break responsiveness)</strong>   

<a href="http://jsfiddle.net/nV3Ua/1195/" rel="noreferrer">Demo</a>  

```css
.row{
    overflow: hidden; 
}

[class*="col-"]{
    margin-bottom: -99999px;
    padding-bottom: 99999px;
}
```

<strong>Solution 2 using table</strong>   

<a href="http://jsfiddle.net/nV3Ua/1192/" rel="noreferrer">Demo</a>  

```css
.row {
    display: table;
}

[class*="col-"] {
    float: none;
    display: table-cell;
    vertical-align: top;
}
```

<strong>Solution 3 using flex</strong> added August 2015. Comments posted before this don't apply to this solution.  

<a href="http://jsfiddle.net/nV3Ua/1821/" rel="noreferrer">Demo</a>  

```css
.row {
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display:         flex;
  flex-wrap: wrap;
}
.row > [class*='col-'] {
  display: flex;
  flex-direction: column;
}
```

#### Answer 2 (score 280)
<h5>Update 2018</h1>

<strong>Best approach for Bootstap 3.x</strong> -- using CSS <strong>flexbox</strong> (and requires minimal CSS)..  

```css
.equal {
  display: flex;
  display: -webkit-flex;
  flex-wrap: wrap;
}
```

<a href="http://bootply.com/127827" rel="noreferrer">Bootstrap same height flexbox example</a>  

To only apply the same height flexbox at specific breakpoints (responsive), use a media query. For example, here is `sm`(768px) and up:  

```css
@media (min-width: 768px) {
  .row.equal {
    display: flex;
    flex-wrap: wrap;
  }
}
```

<p>This solution also works well for multiple rows (column wrapping):<br> 
<a href="https://www.bootply.com/gCEXzPMehZ" rel="noreferrer">https://www.bootply.com/gCEXzPMehZ</a></p>

<strong>Other workarounds</strong>  

These options will be recommended by others, but <a href="https://medium.com/@bootply/bootstrap-equal-height-columns-d07bc934eb27" rel="noreferrer"><strong>are not a good idea</strong></a> for responsive design. These only work for simple single row layouts w/o column wrapping.  

1) Using <a href="http://www.bootply.com/6mwUqfimQN" rel="noreferrer"><strong>huge negative margins &amp; padding</strong></a>  

2) Using <a href="http://www.codeply.com/go/GDZz7SjPwd" rel="noreferrer"><strong>display:table-cell</strong></a> (this solution also effects the responsive grid, so a @media query can be used to only apply `table` display on wider screens before the columns stack vertically)  

<hr>  

<h5><strong>Bootstrap 4</strong></h2>

Flexbox is now used by default in Bootstrap 4 so there is no need for the extra CSS to make equal height columns: <a href="http://www.codeply.com/go/IJYRI4LPwU" rel="noreferrer">http://www.codeply.com/go/IJYRI4LPwU</a>  

Example:  

<pre class="lang-html prettyprint-override"><code>&lt;div class="container"&gt;
    &lt;div class="row"&gt;
        &lt;div class="col-md-6"&gt;&lt;/div&gt;
        &lt;div class="col-md-6"&gt;&lt;/div&gt;
    &lt;/div&gt;
&lt;/div&gt;
</code></pre>

#### Answer 3 (score 84)
No JavaScript needed. Just add the class `.row-eq-height` to your existing `.row` just like this:  

```css
<div class="row row-eq-height">
  <div class="col-xs-12 col-sm-4 panel" style="background-color: red">
    some content
  </div>
  <div class="col-xs-6 col-sm-4 panel" style="background-color: yellow">
    kittenz
  <img src="http://placekitten.com/100/100">
  </div>
  <div class="col-xs-6 col-sm-4 panel" style="background-color: blue">
    some more content
  </div>
</div>
```

Tip: if you have more than 12 columns in your row, the bootstrap grid will fail to wrap it. So add a new `div.row.row-eq-height` each 12 columns.  

Tip: you may need to add   

```css
<link rel="stylesheet" href="http://getbootstrap.com.vn/examples/equal-height-columns/equal-height-columns.css" />
```

to your html  

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: How to place two divs next to each other? (score [778829](https://stackoverflow.com/q/5803023) in 2015)

#### Question
Consider the <a href="http://jsfiddle.net/dqC8t/" rel="noreferrer">following code</a>:  

<p><div class="snippet" data-lang="js" data-hide="false" data-console="false" data-babel="false">
<div class="snippet-code">
```css
#wrapper {
    width: 500px;
    border: 1px solid black;
}
#first {
    width: 300px;
    border: 1px solid red;
}
#second {
    border: 1px solid green;
}
```

<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div id="wrapper"&gt;
    &lt;div id="first"&gt;Stack Overflow is for professional and enthusiast programmers, people who write code because they love it.&lt;/div&gt;
    &lt;div id="second"&gt;When you post a new question, other users will almost immediately see it and try to provide good answers. This often happens in a matter of minutes, so be sure to check back frequently when your question is still new for the best response.&lt;/div&gt;
&lt;/div&gt;</code></pre>
</div>
</div>


I would like the two divs to be next to each other inside the wrapper div. In this case, the height of the green div should determine the height of the wrapper.  

How could I achieve this via CSS ?  

#### Answer accepted (score 414)
Float one or both inner divs.  

<strong>Floating one div:</strong>  

```css
#wrapper {
    width: 500px;
    border: 1px solid black;
    overflow: hidden; /* will contain if #first is longer than #second */
}
#first {
    width: 300px;
    float:left; /* add this */
    border: 1px solid red;
}
#second {
    border: 1px solid green;
    overflow: hidden; /* if you don't want #second to wrap below #first */
}
```

or if you float both, you'll need to encourage the wrapper div to contain both the floated children, or it will think it's empty and not put the border around them  

<strong>Floating both divs:</strong>  

```css
#wrapper {
    width: 500px;
    border: 1px solid black;
    overflow: hidden; /* add this to contain floated children */
}
#first {
    width: 300px;
    float:left; /* add this */
    border: 1px solid red;
}
#second {
    border: 1px solid green;
    float: left; /* add this */
}
```

#### Answer 2 (score 110)
Having two divs,  

```css
<div id="div1">The two divs are</div>
<div id="div2">next to each other.</div>
```

you could also use the `display` property:  

```css
#div1 {
    display: inline-block;
}

#div2 {
    display: inline-block;
}
```

jsFiddle example <a href="http://jsfiddle.net/dimitrios_87/d5Z6V/11/">here</a>.  

If `div1` exceeds a certain height, `div2` will be placed next to `div1` at the bottom. To solve this, use `vertical-align:top;` on `div2`.  

jsFiddle example <a href="http://jsfiddle.net/dimitrios_87/b9hXU/">here</a>.  

#### Answer 3 (score 28)
You can sit elements next to each other by using the CSS float property:  

```css
#first {
float: left;
}
#second {
float: left;
}
```

You'd need to make sure that the wrapper div allows for the floating in terms of width, and margins etc are set correctly.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Twitter Bootstrap Form File Element Upload Button (score [777570](https://stackoverflow.com/q/11235206) in 2018)

#### Question
Why isn't there a fancy file element upload button for twitter bootstrap? It would be sweet if the blue primary button was implemented for the upload button. Is it even possible to finesse the upload button using CSS? (seems like a native browser element that can't be manipulated)   

#### Answer accepted (score 945)
Here's a solution for Bootstrap 3 and 4.  

To make a functional file input control that looks like a button, you only need HTML:  

<strong>HTML</strong>  

```css
<label class="btn btn-default">
    Browse <input type="file" hidden>
</label>
```

This works in all modern browsers, including IE9+. If you need support for old IE as well, please use the legacy approach shown below.  

This techniques relies on the HTML5 `hidden` attribute. Bootstrap 4 uses the following CSS to shim this feature in unsupportive browsers. You may need to add if you're using Bootstrap 3.  

```css
[hidden] {
  display: none !important;
}
```

<hr>

<h5>Legacy approach for old IE</h2>

If you need support for IE8 and below, use the following HTML/CSS:  

<strong>HTML</strong>  

```css
<span class="btn btn-default btn-file">
    Browse <input type="file">
</span>
```

<strong>CSS</strong>  

```css
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}
```

Note that old IE doesn't trigger the file input when you click on a `&lt;label&gt;`, so the The CSS "bloat" does a couple things to work around that:  

<ul>
<li>Makes the file input span the full width/height of the surrounding `&lt;span&gt;`</li>
<li>Makes the file input invisible</li>
</ul>

<hr>

<h5>Feedback &amp; Additional Reading</h2>

I've posted more details about this method, as well as examples for how to show the user which/how many files are selected:  

<a href="http://www.abeautifulsite.net/whipping-file-inputs-into-shape-with-bootstrap-3/" rel="noreferrer">http://www.abeautifulsite.net/whipping-file-inputs-into-shape-with-bootstrap-3/</a>  

#### Answer 2 (score 372)
Im surprised there was no mention of the `&lt;label&gt;` element.  

<strong>Solution:</strong>  

```css
<label class="btn btn-primary" for="my-file-selector">
    <input id="my-file-selector" type="file" class="d-none">
    Button Text Here
</label>
```

No need for any JS, or funky css...  

<strong>Solution for including the filename:</strong>  

```css
<label class="btn btn-primary" for="my-file-selector">
    <input id="my-file-selector" type="file" style="display:none" 
    onchange="$('#upload-file-info').html(this.files[0].name)">
    Button Text Here
</label>
<span class='label label-info' id="upload-file-info"></span>
```

The solution above requires jQuery.  

#### Answer 3 (score 129)
With no additional plugin required, this bootstrap solution works great for me:  

```css
<div style="position:relative;">
        <a class='btn btn-primary' href='javascript:;'>
            Choose File...
            <input type="file" style='position:absolute;z-index:2;top:0;left:0;filter: alpha(opacity=0);-ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";opacity:0;background-color:transparent;color:transparent;' name="file_source" size="40"  onchange='$("#upload-file-info").html($(this).val());'>
        </a>
        &nbsp;
        <span class='label label-info' id="upload-file-info"></span>
</div>
```

demo:   

<a href="http://jsfiddle.net/haisumbhatti/cAXFA/1/" rel="noreferrer">http://jsfiddle.net/haisumbhatti/cAXFA/1/</a> (bootstrap 2)  

<img src="https://i.stack.imgur.com/ISyRZ.png" alt="enter image description here">  

<a href="http://jsfiddle.net/haisumbhatti/y3xyU/" rel="noreferrer">http://jsfiddle.net/haisumbhatti/y3xyU/</a>   (bootstrap 3)  

<img src="https://i.stack.imgur.com/XIqVl.png" alt="enter image description here">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Media Queries: How to target desktop, tablet and mobile? (score [774778](https://stackoverflow.com/q/6370690) in 2013)

#### Question
I have been doing some research on media queries and I still don't quite understand how to target devices of certain sizes.   

I want to be able to target desktop, tablet and mobile. I know that there will be some discrepancies but it would be nice to have a generic system that can be used to target these devices.   

Some examples I have found:  

```css
# Mobile
only screen and (min-width: 480px)

# Tablet
only screen and (min-width: 768px) 

# Desktop
only screen and (min-width: 992px)

# Huge
only screen and (min-width: 1280px) 
```

Or:  

```css
# Phone
only screen and (max-width:320px)

# Tablet
only screen and (min-width:321px) and (max-width:768px)

# Desktop
only screen and (min-width:769px)
```

What do you think these 'breakpoints' should be for each device?  

#### Answer accepted (score 588)
IMO these are the best breakpoints:  

```css
@media (min-width:320px)  { /* smartphones, portrait iPhone, portrait 480x320 phones (Android) */ }
@media (min-width:480px)  { /* smartphones, Android phones, landscape iPhone */ }
@media (min-width:600px)  { /* portrait tablets, portrait iPad, e-readers (Nook/Kindle), landscape 800x480 phones (Android) */ }
@media (min-width:801px)  { /* tablet, landscape iPad, lo-res laptops ands desktops */ }
@media (min-width:1025px) { /* big landscape tablets, laptops, and desktops */ }
@media (min-width:1281px) { /* hi-res laptops and desktops */ }
```

<strong>Edit</strong>: Refined to work better with 960 grids:  

```css
@media (min-width:320px)  { /* smartphones, iPhone, portrait 480x320 phones */ }
@media (min-width:481px)  { /* portrait e-readers (Nook/Kindle), smaller tablets @ 600 or @ 640 wide. */ }
@media (min-width:641px)  { /* portrait tablets, portrait iPad, landscape e-readers, landscape 800x480 or 854x480 phones */ }
@media (min-width:961px)  { /* tablet, landscape iPad, lo-res laptops ands desktops */ }
@media (min-width:1025px) { /* big landscape tablets, laptops, and desktops */ }
@media (min-width:1281px) { /* hi-res laptops and desktops */ }
```

In practice, many designers convert pixels to ems, largely b/c ems better afford zooming. At standard zoom `1em === 16px`. Multiply pixels by `1em/16px` to get ems. For example, `320px === 20em`.  

In response to the comment, `min-width` is standard in "mobile-first" design, wherein you start by designing for your smallest screens, and then add ever-increasing media queries, working you way onto larger and larger screens. Regardless of whether you prefer `min-`, `max-`, or combinations thereof, be cognizant of the order of your rules, keeping in mind that if multiple rules match the same element, the later rules will override the earlier rules.  

#### Answer 2 (score 148)
If you want to target a device then just write `min-device-width`. For example:  

<h5>For iPhone</h3>

```css
@media only screen and (min-device-width: 480px){}
```

<h5>For tablets</h3>

```css
@media only screen and (min-device-width: 768px){}
```

Here are some good articles:  

<ul>
<li><a href="http://x7.fi/2010/02/12/how-to-fit-your-website-for-the-apple-ipad/" rel="noreferrer">How to fit your website for the Apple iPad</a></li>
<li><a href="http://webdesignerwall.com/tutorials/css3-media-queries" rel="noreferrer">CSS3 Media Queries</a></li>
</ul>

#### Answer 3 (score 140)
<h5>Don't target specific devices or sizes!</h2>

The <a href="http://www.palantir.net/blog/re-thinking-breakpoints-responsive-design" rel="nofollow noreferrer">general wisdom</a> is <strong>not to target specific devices or sizes</strong>, but to reframe the term 'breakpoint':  

<ul>
<li>develop the site for <a href="http://www.lukew.com/ff/entry.asp?933" rel="nofollow noreferrer">mobile first</a> using percentages or ems, not pixels,</li>
<li>then try it in a larger viewport and note where it begins to fail,</li>
<li>redesign the layout and add a CSS media query just to handle the broken parts,</li>
<li>repeat the process until you reach the next breakpoint.</li>
</ul>

You can use <a href="http://responsivepx.com/" rel="nofollow noreferrer">responsivepx.com</a> to find the 'natural' breakpoints, as in <a href="http://marcdrummond.com/responsive-web-design/2011/12/29/default-breakpoints-are-dead" rel="nofollow noreferrer">'breakpoints are dead' by Marc Drummond</a>.  

<h5>Use natural breakpoints</h3>

The 'breakpoints' then become the <strong>actual point at which your mobile design begins to 'break'</strong> i.e. cease to be usable or visually pleasing. Once you have a good working mobile site, without media queries, you can stop being concerned about specific sizes and simply add media queries that handle successively larger viewports.  

If you're not trying to pin a design to an exact screen size, this approach works by <strong>removing the need to target specific devices</strong>. The <strong>integrity of the design itself at each breakpoint</strong> ensures that it will hold up at any size. In other words, if a menu/content section/whatever stops being usable at a certain size, <em>design a breakpoint for that size</em>, <strong>not</strong> for a specific device size.  

See Lyza Gardner's post on <a href="http://blog.cloudfour.com/behavioral-breakpoints/" rel="nofollow noreferrer">behavioural breakpoints</a>, and also Zeldman's post about Ethan Marcotte and <a href="http://www.zeldman.com/2014/03/09/evolving-responsive-web-design/" rel="nofollow noreferrer">how responsive web design evolved</a> from the intitial idea.  

<h5>Use semantic markup</h3>

Further, the <strong>simpler and more semantic the DOM structure</strong> with `nav`, `header`, `main`, `section`, `footer` etc. (avoiding abominations like `div class="header"` with nested inner `div` tags) the easier it will be to engineer responsiveness, especially avoiding floats by using <a href="https://css-tricks.com/snippets/css/complete-guide-grid/" rel="nofollow noreferrer">CSS Grid Layout</a> (Sarah Drasner's <a href="https://cssgrid-generator.netlify.com/" rel="nofollow noreferrer">grid generator</a> is a great tool for this) and <a href="https://css-tricks.com/snippets/css/a-guide-to-flexbox/" rel="nofollow noreferrer">flexbox</a> for arranging and re-ordering according to your RWD design plan.  

</section>

