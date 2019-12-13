### Hide element (5 ways)
1. Opacity

```css
.hide {
  opacity: 0;
}
```

2. Visibility

Just like the opacity property, the hidden element will still affect the layout of our web page. The only difference is that this time it will not capture any user interaction when hidden from the user. 
```css
.hide {
   visibility: hidden;
}
```

3. Display : best

Setting display to none makes sure that the box-model is not generated at all.
```css
.hide {
   display: none;
}
```

4. Position

```css
.hide {
   position: absolute;
   top: -9999px;
   left: -9999px;
}
```

5. CLip-path

Ocupy my space
```css
.hide {
  clip-path: polygon(0px 0px,0px 0px,0px 0px,0px 0px);
}
```


### Indent wraped text
```css
div {
    padding-left: 2em;
    text-indent: -2em;
}
```

opacity: 0.5;               /* Good browsers */
background-color: transparent;
background-color: rgba(255, 0, 0, 0.4);


### Text properties

From [w3school](https://www.w3schools.com/css/css_text.asp)
color   Sets the color of text
direction   Specifies the text direction/writing direction
letter-spacing  Increases or decreases the space between characters in a text
line-height   Sets the line height
text-align  Specifies the horizontal alignment of text
text-decoration   Specifies the decoration added to text
text-indent   Specifies the indentation of the first line in a text-block
text-shadow   Specifies the shadow effect added to text
text-transform  Controls the capitalization of text
text-overflow   Specifies how overflowed content that is not displayed should be signaled to the user
unicode-bidi  Used together with the direction property to set or return whether the text should be overridden to support multiple languages in the same document
vertical-align  Sets the vertical alignment of an element
white-space   Specifies how white-space inside an element is handled
word-spacing  Increases or decreases the space between words in a text
