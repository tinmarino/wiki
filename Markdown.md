# Markdown

## Syntax

* Comment
  * `<!-- my comment -->`
  * `[//]: <>(my comment)`

* Font style :
  * `*italic* or _italic_ ` : _italic_
  * `__bold__ or **bold**` : __bold__
  * `~~scratched~~` : ~~scratched~~
  * `->center<-` : ->center<-

* Diff :
	* [+ addition +] or {+ addition +} and [- deletiion -]
	* ``` \`\`\`diff +add or -remove ```

* Tasklist : `- [x] Completed task`

* Math : \`\`\`math \`\`\`

* Color : `#F00[A]`

* Blockquote : `> this is a blockquote`

* Linebreak `---` `___` or `***`

* Footnote : `[^2]` then `[^2]`: explanation 

* Subscirpt `H<sub>2</sub>O and E = mc^2`

* Link :
  * `[clickme](#title-name)` to point to some `# Title Name`
  * [goto google](http://google.com)
  * [in-ref-written][in_ref]
  * [in_ref]: http://wwww.google.fr

* Image : `![img](http://.... "Ttitle"{width="40px" height="400px}})

* Hightlight : `== text to print ==` -> == text to print ==

* Footnote : `see me [11] later` and later `[11]: The 'footnote'`

* Newline :
  * 2 spaces at end of line
  * blank line -> paragraph : 2 newlines in md

## Html

* `&nbsp;` To make spaces
* `<kbd>Shift</kbd>` to get keyboard shotcuts <kdb>Shift</kbd>
* `<br>` : newline

## Pandoc

* `pandoc --number-sections`
* `pandoc --toc`
* TODO bash compleiton
