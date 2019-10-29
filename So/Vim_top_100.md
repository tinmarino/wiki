---
title: Vim <- StackOverflow top 100
category: vim
wiki_css: ../Css/code_prism_dark.css, ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How do I exit the Vim editor? (score [1992281](https://stackoverflow.com/q/11828270) in 2019)

#### Question
I'm stuck and cannot escape. It says:  

```vim
"type :quit<Enter> to quit VIM"
```

But when I type that it simply appears in the object body.  

#### Answer accepted (score 4638)
Hit the <kbd>Esc</kbd> key to enter "Normal mode". Then you can type `:` to enter "Command-line mode". A colon (`:`) will appear at the bottom of the screen and you can type in one of the following commands. To execute a command, press the <kbd>Enter</kbd> key.  

<ul>
<li>`:q`  to quit (short for `:quit`)</li>
<li>`:q!` to quit without saving (short for `:quit!`)</li>
<li>`:wq` to write and quit</li>
<li>`:wq!` to write and quit even if file has only read permission (if file does not have write permission: force write)</li>
<li>`:x`  to write and quit (similar to `:wq`, but only write if there are changes)</li>
<li>`:exit` to write and exit (same as `:x`)</li>
<li>`:qa` to quit all (short for `:quitall`)</li>
<li>`:cq` to quit without saving and make Vim return non-zero error (i.e. exit with error)</li>
</ul>

You can also exit Vim directly from "Normal mode" by typing `ZZ` to save and quit (same as `:x`) or `ZQ` to just quit (same as `:q!`). (Note that case is important here. `ZZ` and `zz` do not mean the same thing.)  

Vim has extensive help - that you can access with the `:help` command - where you can find answers to all your questions and a tutorial for beginners.  

#### Answer 2 (score 166)
Before you enter a command, <strong>hit the <kbd>Esc</kbd> key</strong>. After you enter it, hit the <kbd>Return</kbd> to confirm.  

<kbd>Esc</kbd> finishes the current command and switches Vim to <a href="http://vimdoc.sourceforge.net/htmldoc/intro.html#Normal" rel="noreferrer">normal mode</a>.   Now if you press <kbd>:</kbd>, the `:` will appear at the <em>bottom</em> of the screen. This confirms that you're actually typing a command and not editing the file.   

Most commands have abbreviations, with optional part enclosed in brackets: `c[ommand]`.  

Commands marked with '*' are Vim-only (not implemented in Vi).  

<strong>Safe-quit (fails if there are unsaved changes):</strong>  

<ul>
<li>`:q[uit]`  Quit the current <a href="http://vimdoc.sourceforge.net/htmldoc/windows.html#window" rel="noreferrer">window</a>. Quit Vim if this is the last        window.  This fails when changes have been made in current <a href="http://vimdoc.sourceforge.net/htmldoc/windows.html#buffers" rel="noreferrer">buffer</a>.</li>
<li>`:qa[ll]`*  Quit all windows and Vim, unless there are some buffers which have been changed.</li>
</ul>

<strong>Prompt-quit (prompts if there are unsaved changes)</strong>  

<ul>
<li>`:conf[irm] q[uit]`* Quit, but give prompt when there are some buffers which have been changed.</li>
<li>`:conf[irm] xa[ll]`* Write all changed buffers and exit Vim. Bring up a prompt when some buffers cannot be written.</li>
</ul>

<strong>Write (save) changes and quit:</strong>  

<ul>
<li>`:wq` Write the current file (even if it was not changed) and quit.  Writing fails when the file is read-only or the buffer does not have a name. `:wqa[ll]`* for all windows.</li>
<li>`:wq!` The same, but writes even read-only files. `:wqa[ll]!`* for all windows.</li>
<li>`:x[it]`, `ZZ`(with <a href="http://vimdoc.sourceforge.net/htmldoc/editing.html#ZZ" rel="noreferrer">details</a>). Write the file only <em>if it was changed</em> and quit, `:xa[ll]`* for all windows.</li>
</ul>

<strong>Discard changes and quit:</strong>  

<ul>
<li>`:q[uit]!` `ZQ`* Quit without writing, also when visible buffers have changes.  Does not exit when there are changed hidden buffers. </li>
<li>`:qa[ll]!`*, `:quita[ll][!]`* Quit Vim, all changes to the buffers (including hidden) are lost.</li>
</ul>

<strong>Press <kbd>Return</kbd> to confirm the command.</strong>  

This answer doesn't reference all Vim write and quit commands and arguments. Indeed, they are referenced in the <a href="http://vimdoc.sourceforge.net/htmldoc/editing.html#:q" rel="noreferrer">Vim documentation</a>.   

Vim has extensive built-in help, type <kbd>Esc</kbd>`:help`<kbd>Return</kbd> to open it.  

<p><sub>
This answer was inspired by the <a href="https://stackoverflow.com/a/11828573/2790048">other one</a>, originally authored by @dirvine and edited by other SO users. I've included more information from Vim reference, SO comments and some other sources. Differences for Vi and Vim are reflected too.
</sub></p>

#### Answer 3 (score 155)
Pictures are worth a thousand Unix commands and options:  

<a href="https://i.stack.imgur.com/BN6vl.png" rel="noreferrer"><img src="https://i.stack.imgur.com/BN6vl.png" alt="Enter image description here"></a>  

I draw this to my students each semester and they seem to grasp vi afterwards.  

vi is a <a href="https://en.wikipedia.org/wiki/Finite-state_machine" rel="noreferrer">finite state machine</a> with only three states.  

Upon starting, vi goes into COMMAND mode, where you can type short, few character commands, <em>blindly</em>. You know what you are doing; this isn't for amateurs.  

When you want to actually edit text, you should go to INSERT mode with some one-character command:  

<ul>
<li>i: go to INSERT in the place of the cursor</li>
<li>I: go to INSERT mode at the beginning of the line</li>
<li>a: append <em>after</em> the cursor</li>
<li>A: append at the end of line</li>
<li>o: <em>open</em> a new line below the current line</li>
<li>O: <em>open</em> a new line in the place of the current line</li>
</ul>

Now, answering the question: exiting.  

You can exit vi from EX mode:  

<ul>
<li>q: if you haven't made any modifications, or saved them beforehand</li>
<li>q!: ignores any modifications and <em>quit</em></li>
<li>wq: save and quit</li>
<li>x: this is equal to wq</li>
</ul>

`w` and `x` accept a file name parameter. If you started vi with a filename, you need not give it here again.  

At last, the most important: how can you reach EX mode?  

EX mode is for long commands that you can see typing at the bottom line of the screen. From COMMAND mode, you push colon, `:`, and a colon will appear at the bottom line, where you can type the above commands.  

From INSERT mode, you need to push ESC, i.e. the Escape button, going to COMMAND mode, and then : to go to EX mode.  

If you are unsure, push ESC and that will bring you to command mode.  

So, the robust method is ESC-:-x-Enter which saves your file and quits.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How do I make Git use the editor of my choice for commits? (score [845181](https://stackoverflow.com/q/2596805) in 2017)

#### Question
I would prefer to write my commit messages in Vim, but it is opening them in Emacs.  

How do I configure Git to always use Vim?  Note that I want to do this globally, not just for a single project.  

#### Answer accepted (score 3207)
If you want to set the editor <em>only</em> for Git, do either (you don’t need both):  

<ul>
<li>Set <a href="http://git-scm.com/book/en/Customizing-Git-Git-Configuration#Basic-Client-Configuration" rel="noreferrer">`core.editor`</a> in your Git config: `git config --global core.editor "vim"`</li>
<li>Set the <a href="http://git-scm.com/docs/git-var#_variables" rel="noreferrer">`GIT_EDITOR`</a> environment variable: `export GIT_EDITOR=vim`</li>
</ul>

<hr>

If you want to set the editor for Git <em>and also other programs</em>, set the standardized `VISUAL` and `EDITOR` environment variables*:  

```vim
export VISUAL=vim
export EDITOR="$VISUAL"
```

<sub>* Setting both is not necessarily needed, but some programs may not use the more-correct `VISUAL`. See <a href="https://unix.stackexchange.com/questions/4859/visual-vs-editor-whats-the-difference">`VISUAL` vs. `EDITOR`</a>.</sub>  

<hr>

<p><strong>For Sublime Text</strong>:
Add this to the `.gitconfig`. The `--wait` is important. (it allows to type text in sublime and will wait for save/close event.</p>

```vim
[core]
    editor = 'subl' --wait
```

<em>'subl' can be replaced by the full path of the executable but is usually available when correctly installed.</em>  

#### Answer 2 (score 558)
Copy paste this:  

```vim
git config --global core.editor "vim"
```

In case you'd like to know what you're doing. From `man git-commit`:  

<blockquote>
  <h5>ENVIRONMENT AND CONFIGURATION VARIABLES</h2>
  
  The editor used to edit the commit log message will be chosen from the `GIT_EDITOR` environment variable, the `core.editor` configuration variable, the `VISUAL` environment variable, or the `EDITOR` environment variable (in that order).  
</blockquote>

#### Answer 3 (score 175)
On Ubuntu and also Debian (thanks @MichielB) changing the default editor is also possible by running:   

```vim
sudo update-alternatives --config editor
```

Which will prompt the following:  

```vim
There are 4 choices for the alternative editor (providing /usr/bin/editor).

  Selection    Path                Priority   Status
------------------------------------------------------------
  0            /bin/nano            40        auto mode
  1            /bin/ed             -100       manual mode
  2            /bin/nano            40        manual mode
* 3            /usr/bin/vim.basic   30        manual mode
  4            /usr/bin/vim.tiny    10        manual mode

Press enter to keep the current choice[*], or type selection number: 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: What's a quick way to comment/uncomment lines in Vim? (score [810229](https://stackoverflow.com/q/1676632) in 2013)

#### Question
I have a Ruby code file open in vi, there are lines commented out with `#`:  

```vim
class Search < ActiveRecord::Migration
  def self.up
    # create_table :searches do |t|
    #   t.integer :user_id
    #   t.string :name
    #   t.string :all_of
    #   t.string :any_of
    #   t.string :none_of
    #   t.string :exact_phrase
    # 
    #   t.timestamps
    # end
  end

  def self.down
    # drop_table :searches
  end
end
```

Say I want to uncomment all the lines in the first `def ... end` section. What's an efficient way to do that in Vim?  

In general, I'm looking for an easy and fluid way to comment and uncomment lines. Here I'm dealing with Ruby code, but it could be JavaScript (`//`) or Haml (`-#`).  

#### Answer accepted (score 172)
I use the <a href="http://www.vim.org/scripts/script.php?script_id=1218" rel="noreferrer">NERD Commenter script</a>. It lets you easily comment, uncomment or toggle comments in your code.  

As mentioned in the <a href="https://stackoverflow.com/questions/1676632/whats-a-quick-way-to-comment-uncomment-lines-in-vim/1676775#comment63316440_1676775">comments</a>:  

<blockquote>
  for anyone who is confused by the usage, default leader is "\" so 10\cc will comment ten lines and 10\cu will uncomment those ten lines  
</blockquote>

#### Answer 2 (score 2267)
For those tasks I use most of the time <a href="http://vimdoc.sourceforge.net/htmldoc/visual.html" rel="noreferrer">block selection</a>.  

Put your cursor on the first `#` character, press <kbd>Ctrl</kbd><kbd>V</kbd> (or <kbd>Ctrl</kbd><kbd>Q</kbd> for gVim), and go down until the last commented line and press <kbd>x</kbd>, that will delete all the `#` characters vertically.  

For commenting a block of text is almost the same:   

<ol>
<li>First, go to the first line you want to comment, press <kbd>Ctrl</kbd><kbd>V</kbd>. This will put the editor in the `VISUAL BLOCK` mode.</li>
<li>Then using the arrow key and select until the last line</li>
<li>Now press <kbd>Shift</kbd><kbd>I</kbd>, which will put the editor in `INSERT` mode and then press <kbd>#</kbd>. This will add a hash to the first line. </li>
<li>Then press <kbd>Esc</kbd> (give it a second), and it will insert a `#` character on all other selected lines. </li>
</ol>

For the stripped-down version of vim shipped with debian/ubuntu by default, type `: s/^/#` in the third step instead (any remaining highlighting of the first character of each line can be removed with `:nohl`).  

Here are two small screen recordings for visual reference.  

<p>Comment:
<a href="https://i.stack.imgur.com/lu6aU.gif" rel="noreferrer"><img src="https://i.stack.imgur.com/lu6aU.gif" alt="Comment"></a></p>

<p>Uncomment:
<a href="https://i.stack.imgur.com/2Y7eH.gif" rel="noreferrer"><img src="https://i.stack.imgur.com/2Y7eH.gif" alt="Uncomment"></a></p>

#### Answer 3 (score 761)
<h5>To comment out blocks in vim:</h2>

<ul>
<li>press <kbd>Esc</kbd> (to leave editing or other mode)</li>
<li>hit <kbd>ctrl</kbd>+<kbd>v</kbd> (visual block mode)</li>
<li>use the up/down arrow keys to select lines you want (it won't highlight everything - it's OK!)</li>
<li><kbd>Shift</kbd>+<kbd>i</kbd> (capital I)</li>
<li>insert the text you want, i.e. `%`</li>
<li>press <kbd>Esc</kbd><kbd>Esc</kbd></li>
</ul>

<hr>

<h5>To uncomment blocks in vim:</h2>

<ul>
<li>press <kbd>Esc</kbd> (to leave editing or other mode)</li>
<li>hit <kbd>ctrl</kbd>+<kbd>v</kbd> (visual block mode)</li>
<li>use the <kbd>↑</kbd>/<kbd>↓</kbd> arrow keys to select the lines to uncomment.


<em>If you want to select multiple characters, use one or combine these methods:</em>

<ul>
<li><em>use the left/right arrow keys to select more text</em></li>
<li><em>to select chunks of text use <kbd>shift</kbd> + <kbd>←</kbd>/<kbd>→</kbd> arrow key</em></li>
<li><em>you can repeatedly push the delete keys below, like a regular delete button</em>
<p></li>
</ul></li>
<li>press <kbd>d</kbd> or <kbd>x</kbd> to delete characters, repeatedly if necessary</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: Tab key == 4 spaces and auto-indent after curly braces in Vim (score [784783](https://stackoverflow.com/q/234564) in 2015)

#### Question
How do I make <a href="http://en.wikipedia.org/wiki/Vi" rel="noreferrer">vi</a>-<a href="http://en.wikipedia.org/wiki/Vim_%28text_editor%29" rel="noreferrer">Vim</a> never use tabs (converting spaces to tabs, bad!), makes the tab key == 4 spaces, and automatically indent code after curly brace blocks like <a href="http://en.wikipedia.org/wiki/Emacs" rel="noreferrer">Emacs</a> does?  

Also, how do I save these settings so I never have to input them again?  

I've seen other questions related to this, but it always seems to be a little off from what I want.  

#### Answer accepted (score 1798)
As has been pointed out in a couple of answers below, the preferred method now is NOT to use smartindent, but instead use the following (in your <a href="https://stackoverflow.com/questions/10921441/where-is-my-vimrc-file">.vimrc</a>):  

```vim
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
```

<hr>

<p><strike>
In your <a href="https://stackoverflow.com/questions/10921441/where-is-my-vimrc-file">.vimrc:</a> file:</p>

```vim
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
```

The help files take a bit of time to get used to, but the more you read, the better Vim gets:  

```vim
:help smartindent
```

Even better, you can embed these settings in your source for portability:  

```vim
:help auto-setting
```

To see your current settings:  

```vim
:set all
```

As <a href="https://stackoverflow.com/users/18038/graywh">graywh</a> points out in the comments, smartindent has been replaced by cindent which "Works more cleverly", although still mainly for languages with C-like syntax:  

```vim
:help C-indenting
```

</strike>  

#### Answer 2 (score 229)
Related, if you open a file that uses both tabs and spaces, assuming you've got  

```vim
set expandtab ts=4 sw=4 ai
```

You can replace all the tabs with spaces in the entire file with  

```vim
:%retab
```

#### Answer 3 (score 87)
The best way to get filetype-specific indentation is to use `filetype plugin indent on` in your vimrc.  Then you can specify things like `set sw=4 sts=4 et` in .vim/ftplugin/c.vim, for example, without having to make those global for all files being edited and other non-C type syntaxes will get indented correctly, too <em>(even lisps)</em>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Redefine tab as 4 spaces (score [763913](https://stackoverflow.com/q/1878974) in 2014)

#### Question
My current setting assumes 8 spaces; how could I redefine it?  

#### Answer accepted (score 1516)
It depends on what you mean. Do you want actual tab characters in your file to <em>appear</em> 4 spaces wide, or by "tab" do you actually mean an <em>indent</em>, generated by pressing the tab key, which would result in the file literally containing (up to) 4 space characters for each "tab" you type?  

<p>Depending on your answer, one of the following sets of
settings should work for you:</p>

<ul>
<li><p><strong>For tab characters that appear 4-spaces-wide</strong>:</p>

```vim
set tabstop=4
```

If you're using actual tab character in your source code you probably also want these settings (these are actually the defaults, but you may want to set them defensively):  

```vim
set softtabstop=0 noexpandtab
```

Finally, if you want an indent to correspond to a single tab, you should also use:  

```vim
set shiftwidth=4
```</li>
<li><p><strong>For indents that consist of 4 space characters</strong> but are entered with the tab key:</p>

```vim
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
```</li>
</ul>

<p><strong>To make the above settings permanent add
these lines to your <a href="https://stackoverflow.com/a/34005877/90848">vimrc</a>.</strong></p>

In case you need to make adjustments, or would simply like to understand what these options all mean, here's a breakdown of what each option means:  

<blockquote>
  <h5>`tabstop`</h2>
  
  The width of a hard tabstop measured in "spaces" -- effectively the (maximum) width of an actual tab character.  
  
  <h5>`shiftwidth`</h2>
  
  The size of an "indent". It's also measured in spaces, so if your code base indents with tab characters then you want `shiftwidth` to equal the number of tab characters times `tabstop`. This is also used by things like the `=`, `&gt;` and `&lt;` commands.  
  
  <h5>`softtabstop`</h2>
  
  <p>Setting this to a non-zero value other than `tabstop` will make the tab key (in insert mode) 
  insert a combination of spaces (and possibly tabs) to <em>simulate</em> tab stops at this width.</p>
  
  <h5>`expandtab`</h2>
  
  <p>Enabling this will make the tab key (in insert mode) insert spaces instead of 
  tab characters. This also affects the behavior of the `retab` command.</p>
  
  <h5>`smarttab`</h2>
  
  <p>Enabling this will make the tab key (in insert mode) insert spaces or tabs to
  go to the next indent
  of the next tabstop when the cursor is at the beginning of a line (i.e. the
  only preceding characters are whitespace).</p>
</blockquote>

For more details on any of these see `:help '<em>optionname</em>'` in vim (e.g. `:help 'tabstop'`)   

#### Answer 2 (score 721)
To define this on a permanent basis for the current user, create (or edit) the `.vimrc` file:  

```vim
$ vim ~/.vimrc
```

Then, paste the configuration below into the file. Once vim is restarted, the tab settings will apply.  

```vim
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces
```

#### Answer 3 (score 52)
or shorthand for vim modeline:  

```vim
vim :set ts=4 sw=4 sts=4 et :
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: Indent multiple lines quickly in vi (score [753143](https://stackoverflow.com/q/235839) in 2014)

#### Question
Should be trivial, and it might even be in the help, but I can't figure out how to navigate it. How do I indent multiple lines quickly in vi?  

#### Answer accepted (score 2478)
Use the <kbd>></kbd> command. To indent 5 lines, <kbd>5</kbd><kbd>></kbd><kbd>></kbd>. To mark a block of lines and indent it, <kbd>V</kbd><kbd>j</kbd><kbd>j</kbd><kbd>></kbd> to indent 3 lines (vim only). To indent a curly-braces block, put your cursor on one of the curly braces and use <kbd>></kbd><kbd>%</kbd> or from anywhere inside block use <kbd>></kbd><kbd>i</kbd><kbd>B</kbd>.  

If you’re copying blocks of text around and need to align the indent of a block in its new location, use <kbd>]</kbd><kbd>p</kbd> instead of just <kbd>p</kbd>. This aligns the pasted block with the surrounding text.  

Also, the <a href="http://vimdoc.sourceforge.net/htmldoc/options.html#&#39;shiftwidth&#39;" rel="noreferrer">`shiftwidth`</a> setting allows you to control how many spaces to indent.  

#### Answer 2 (score 933)
This answer summarises the other answers and comments of this question, and adds extra information based on the <a href="http://vimdoc.sourceforge.net/" rel="noreferrer">Vim documentation</a> and the <a href="http://vim.wikia.com" rel="noreferrer">Vim wiki</a>. For conciseness, this answer doesn't distinguish between Vi and Vim-specific commands.  

In the commands below, "re-indent" means "indent lines according to your <a href="http://vim.wikia.com/wiki/VimTip83" rel="noreferrer">indentation settings</a>." <a href="http://vimdoc.sourceforge.net/htmldoc/options.html#%27shiftwidth%27" rel="noreferrer">`shiftwidth`</a> is the primary variable that controls indentation.  

<strong>General Commands</strong>  

```vim
>>   Indent line by shiftwidth spaces
<<   De-indent line by shiftwidth spaces
5>>  Indent 5 lines
5==  Re-indent 5 lines

>%   Increase indent of a braced or bracketed block (place cursor on brace first)
=%   Reindent a braced or bracketed block (cursor on brace)
<%   Decrease indent of a braced or bracketed block (cursor on brace)
]p   Paste text, aligning indentation with surroundings

=i{  Re-indent the 'inner block', i.e. the contents of the block
=a{  Re-indent 'a block', i.e. block and containing braces
=2a{ Re-indent '2 blocks', i.e. this block and containing block

>i{  Increase inner block indent
<i{  Decrease inner block indent
```

You can replace `{` with `}` or `B`, e.g. `=iB` is a valid block indent command. Take a look at <a href="http://vim.wikia.com/wiki/Indent_a_code_block" rel="noreferrer">"Indent a Code Block"</a> for a nice example to try these commands out on.  

Also, remember that  

```vim
.    Repeat last command
```

, so indentation commands can be easily and conveniently repeated.  

<strong>Re-indenting complete files</strong>  

Another common situation is requiring indentation to be fixed throughout a source file:  

```vim
gg=G  Re-indent entire buffer
```

You can extend this idea to multiple files:  

```vim
" Re-indent all your c source code:
:args *.c
:argdo normal gg=G
:wall
```

Or multiple buffers:  

```vim
" Re-indent all open buffers:
:bufdo normal gg=G:wall
```

<strong>In Visual Mode</strong>  

```vim
Vjj> Visually mark and then indent 3 lines
```

<strong>In insert mode</strong>  

These commands apply to the current line:  

```vim
CTRL-t   insert indent at start of line
CTRL-d   remove indent at start of line
0 CTRL-d remove all indentation from line
```

<strong>Ex commands</strong>  

<p>These are useful when you want to indent a specific range of lines, without moving your
cursor.</p>

```vim
:< and :> Given a range, apply indentation e.g.
:4,8>   indent lines 4 to 8, inclusive
```

<strong>Indenting using markers</strong>  

Another approach is via <a href="http://www.marksanborn.net/software/using-markers-in-vim/" rel="noreferrer">markers</a>:  

```vim
ma     Mark top of block to indent as marker 'a'
```

...move cursor to end location  

```vim
>'a    Indent from marker 'a' to current location
```

<strong>Variables that govern indentation</strong>  

You can set these in your <a href="http://vimdoc.sourceforge.net/htmldoc/starting.html#vimrc" rel="noreferrer">.vimrc file</a>.  

```vim
set expandtab       "Use softtabstop spaces instead of tab characters for indentation
set shiftwidth=4    "Indent by 4 spaces when using >>, <<, == etc.
set softtabstop=4   "Indent by 4 spaces when pressing <TAB>

set autoindent      "Keep indentation from previous line
set smartindent     "Automatically inserts indentation in some cases
set cindent         "Like smartindent, but stricter and more customisable
```

Vim has intelligent indentation based on filetype. Try adding this to your .vimrc:  

```vim
if has ("autocmd")
    " File type detection. Indent based on filetype. Recommended.
    filetype plugin indent on
endif
```

<strong>References</strong>  

<ul>
<li><a href="http://vim.wikia.com/wiki/Indent_a_code_block" rel="noreferrer">Indent a code block</a> </li>
<li><a href="http://vim.wikia.com/wiki/VimTip224" rel="noreferrer">Shifting blocks visually</a></li>
<li><a href="http://vim.wikia.com/wiki/VimTip83" rel="noreferrer">Indenting source code</a></li>
<li>`:help =`</li>
</ul>

#### Answer 3 (score 123)
A big selection would be:  

```vim
gg=G
```

It is really fast, and everything gets indented ;-)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: What is your most productive shortcut with Vim? (score [752799](https://stackoverflow.com/q/1218390) in 2017)

#### Question
<p>I've heard a lot about <a href="http://www.vim.org/" rel="noreferrer">Vim</a>, both pros and cons.
It really seems you should be (as a developer) faster with Vim than with any other editor.
I'm using Vim to do some basic stuff and I'm at best 10 times <em>less productive</em> with Vim.</p>

The only two things you should care about when you talk about speed (you may not care enough about them, but you should) are:  

<ol>
<li>Using alternatively left and right
hands is the <strong>fastest</strong> way to use the
keyboard. </li>
<li>Never touching the mouse is the
second way to be as fast as possible.
It takes ages for you to move your hand,
grab the mouse, move it, and bring it
back to the keyboard (and you often have
to look at the keyboard to be sure you
returned your hand properly to the right place)</li>
</ol>

Here are two examples demonstrating why I'm far less productive with Vim.  

<strong>Copy/Cut &amp; paste.</strong> I do it all the time. With all the contemporary editors you press <kbd>Shift</kbd>  with the left hand, and you move the cursor with your right hand to select text. Then <kbd>Ctrl</kbd>+<kbd>C</kbd> copies, you move the cursor and <kbd>Ctrl</kbd>+<kbd>V</kbd> pastes.  

With Vim it's horrible:  

<ul>
<li><strong>`yy`</strong> to copy one line (you almost never want the whole line!)</li>
<li><strong>`[number xx]yy`</strong> to copy `xx` lines into the buffer. But you never know exactly if you've selected what you wanted. I often have to do <strong>`[number xx]dd`</strong> then <strong>`u`</strong> to undo!</li>
</ul>

Another example? <strong>Search &amp; replace.</strong>  

<ul>
<li>In <a href="http://en.wikipedia.org/wiki/PSPad" rel="noreferrer">PSPad</a>: <kbd>Ctrl</kbd>+<kbd>f</kbd> then type what you want you search for, then press <kbd>Enter</kbd>.</li>
<li>In Vim: <strong>`/`</strong>, then type what you want to search for, then if there are some special characters put <strong>`\`</strong> before <em>each</em> special character, then press <kbd>Enter</kbd>.</li>
</ul>

And everything with Vim is like that: it seems I don't know how to handle it the right way.  

NB : <strong>I've already read the Vim <a href="http://www.viemu.com/vi-vim-cheat-sheet.gif" rel="noreferrer">cheat</a> <a href="http://www.fprintf.net/vimCheatSheet.html" rel="noreferrer">sheet</a></strong> :)  

My question is:  

What is the way you use Vim that makes you more productive than with a contemporary editor?  

#### Answer accepted (score 2862)
<h5>Your problem with <strong>Vim</strong> is that  you don't grok <strong>vi</strong>.</h3>

You mention cutting with `yy` and complain that you almost never want to cut whole lines.  In fact programmers, editing source code, very often want to work on whole lines, ranges of lines and blocks of code.  However, `yy` is only one of many way to yank text into the anonymous copy buffer (or "register" as it's called in <strong>vi</strong>).  

The "Zen" of <strong>vi</strong> is that you're speaking a language.  The initial `y` is a verb.  The statement `yy` is a synonym for `y_`. The `y` is doubled up to make it easier to type, since it is such a common operation.  

This can also be expressed as `dd` `P` (delete the current line and paste a copy back into place; leaving a copy in the anonymous register as a side effect).  The `y` and `d` "verbs" take any movement as their "subject."  Thus `yW` is "yank from here (the cursor) to the end of the current/next (big) word" and `y'a` is "yank from here to the line containing the mark named '<em>a</em>'."  

If you only understand basic up, down, left, and right cursor movements then <strong>vi</strong> will be no more productive than a copy of "notepad" for you.  (Okay, you'll still have syntax highlighting and the ability to handle files larger than a piddling ~45KB or so; but work with me here).  

<strong>vi</strong> has 26 "marks" and 26 "registers."  A mark is set to any cursor location using the `m` command.  Each mark is designated by a single lower case letter.  Thus `ma` sets the '<em>a</em>' mark to the current location, and `mz` sets the '<em>z</em>' mark.  You can move to the line containing a mark using the `'` (single quote) command.  Thus `'a` moves to the beginning of the line containing the '<em>a</em>' mark.  You can move to the precise location of any mark using the ``` (backquote) command.  Thus ``z` will move directly to the exact location of the '<em>z</em>' mark.  

Because these are "movements" they can also be used as subjects for other "statements."  

So, one way to cut an arbitrary selection of text would be to drop a mark (I usually use '<em>a</em>' as my "first" mark, '<em>z</em>' as my next mark, '<em>b</em>' as another, and '<em>e</em>' as yet another (I don't recall ever having interactively used more than four marks in 15 years of using <strong>vi</strong>; one creates one's own conventions regarding how marks and registers are used by macros that don't disturb one's interactive context).  Then we go to the other end of our desired text; we can start at either end, it doesn't matter.  Then we can simply use `d`a` to cut or `y`a` to copy.  Thus the whole process has a 5 keystrokes overhead (six if we started in "insert" mode and needed to <kbd>Esc</kbd> out command mode).  Once we've cut or copied then pasting in a copy is a single keystroke: `p`.  

I say that this is one way to cut or copy text.  However, it is only one of many.  Frequently we can more succinctly describe the range of text without moving our cursor around and dropping a mark.  For example if I'm in a paragraph of text I can use `{` and `}` movements to the beginning or end of the paragraph respectively.  So, to move a paragraph of text I cut it using `{` `d}` (3 keystrokes).  (If I happen to already be on the first or last line of the paragraph I can then simply use `d}` or `d{` respectively.    

The notion of "paragraph" defaults to something which is usually intuitively reasonable.  Thus it often works for code as well as prose.  

Frequently we know some pattern (regular expression) that marks one end or the other of the text in which we're interested.  Searching forwards or backwards are movements in <strong>vi</strong>.  Thus they can also be used as "subjects" in our "statements."  So I can use `d/foo` to cut from the current line to the next line containing the string "foo" and `y?bar` to copy from the current line to the most recent (previous) line containing "bar."  If I don't want whole lines I can still use the search movements (as statements of their own), drop my mark(s) and use the ``x` commands as described previously.  

In addition to "verbs" and "subjects" <strong>vi</strong> also has "objects" (in the grammatical sense of the term).  So far I've only described the use of the anonymous register.  However, I can use any of the 26 "named" registers by <em>prefixing</em> the "object" reference with `"` (the double quote modifier).  Thus if I use `"add` I'm cutting the current line into the '<em>a</em>' register and if I use `"by/foo` then I'm yanking a copy of the text from here to the next line containing "foo" into the '<em>b</em>' register.  To paste from a register I simply prefix the paste with the same modifier sequence: `"ap` pastes a copy of the '<em>a</em>' register's contents into the text after the cursor and `"bP` pastes a copy from '<em>b</em>' to before the current line.  

This notion of "prefixes" also adds the analogs of grammatical "adjectives" and "adverbs'  to our text manipulation "language."  Most commands (verbs) and movement (verbs or objects, depending on context) can also take numeric prefixes. Thus `3J` means "join the next three lines" and `d5}` means "delete from the current line through the end of the fifth paragraph down from here."  

This is all intermediate level <strong>vi</strong>.  None of it is <strong>Vim</strong> specific and there are far more advanced tricks in <strong>vi</strong> if you're ready to learn them.  If you were to master just these intermediate concepts then you'd probably find that you rarely need to write any macros because the text manipulation language is sufficiently concise and expressive to do most things easily enough using the editor's "native" language.  

<hr>

<h5>A sampling of more advanced tricks:</h3>

There are a number of `:` commands, most notably the `:% s/foo/bar/g` global substitution technique.  (That's not advanced but other `:` commands can be).  The whole `:` set of commands was historically inherited by <strong>vi</strong>'s previous incarnations as the <strong>ed</strong> (line editor) and later the <strong>ex</strong> (extended line editor) utilities.  In fact <strong>vi</strong> is so named because it's the visual interface to <strong>ex</strong>.  

`:` commands normally operate over lines of text.  <strong>ed</strong> and <strong>ex</strong> were written in an era when terminal screens were uncommon and many terminals were "teletype" (TTY) devices.  So it was common to work from printed copies of the text, using commands through an extremely terse interface (common connection speeds were 110 baud, or, roughly, 11 characters per second -- which is slower than a fast typist; lags were common on multi-user interactive sessions; additionally there was often some motivation to conserve paper).  

So the syntax of most `:` commands includes an address or range of addresses (line number) followed by a command.  Naturally one could use literal line numbers: `:127,215 s/foo/bar` to change the first occurrence of "foo" into "bar" on each line between 127 and 215.  One could also use some abbreviations such as `.` or `$` for current and last lines respectively.  One could also use relative prefixes `+` and `-` to refer to offsets after or before the curent line, respectively.  Thus: `:.,$j` meaning "from the current line to the last line, join them all into one line".  `:%` is synonymous with `:1,$` (all the lines).  

The `:... g` and `:... v` commands bear some explanation as they are incredibly powerful.  `:... g` is a prefix for "globally" applying a subsequent command to all lines which match a pattern (regular expression) while `:... v` applies such a command to all lines which do NOT match the given pattern ("v" from "conVerse").  As with other <strong>ex</strong> commands these can be prefixed by addressing/range references.  Thus `:.,+21g/foo/d` means "delete any lines containing the string "foo" from the current one through the next 21 lines" while `:.,$v/bar/d` means "from here to the end of the file, delete any lines which DON'T contain the string "bar."  

It's interesting that the common Unix command <strong>grep</strong> was actually inspired by this <strong>ex</strong> command (and is named after the way in which it was documented).  The <strong>ex</strong> command `:g/re/p` (grep) was the way they documented how to "globally" "print" lines containing a "regular expression" (re).  When <strong>ed</strong> and <strong>ex</strong> were used, the `:p` command was one of the first that anyone learned and often the first one used when editing any file.  It was how you printed the current contents (usually just one page full at a time using `:.,+25p` or some such).  

Note that `:% g/.../d` or (its reVerse/conVerse counterpart: `:% v/.../d` are the most common usage patterns.  However there are  couple of other `ex` commands which are worth remembering:  

We can use `m` to move lines around, and `j` to join lines.  For example if you have a list and you want to separate all the stuff matching (or conversely NOT matching some pattern) without deleting them, then you can use something like: `:% g/foo/m$` ... and all the "foo" lines will have been moved to the end of the file.  (Note the other tip about using the end of your file as a scratch space).  This will have preserved the relative order of all the "foo" lines while having extracted them from the rest of the list.  (This would be equivalent to doing something like: `1G!GGmap!Ggrep foo&lt;ENTER&gt;1G:1,'a g/foo'/d` (copy the file to its own tail, filter the tail through `grep`, and delete all the stuff from the head).  

To join lines usually I can find a pattern for all the lines which need to be joined to their predecessor (all the lines which start with "^   " rather than "^ * " in some bullet list, for example).  For that case I'd use: `:% g/^   /-1j` (for every matching line, go up one line and join them). (BTW: for bullet lists trying to search for the bullet lines and join to the next doesn't work for a couple reasons ... it can join one bullet line to another, and it won't join any bullet line to <em>all</em> of its continuations; it'll only work pairwise on the matches).  

Almost needless to mention you can use our old friend `s` (substitute) with the `g` and `v` (global/converse-global) commands.  Usually you don't need to do so.  However, consider some case where you want to perform a substitution only on lines matching some other pattern.  Often you can use a complicated pattern with captures and use back references to preserve the portions of the lines that you DON'T want to change.  However, it will often be easier to separate the match from the substitution: `:% g/foo/s/bar/zzz/g` -- for every line containing "foo" substitute all "bar" with "zzz."  (Something like `:% s/\(.*foo.*\)bar\(.*\)/\1zzz\2/g` would only work for the cases those instances of "bar" which were PRECEDED by "foo" on the same line; it's ungainly enough already, and would have to be mangled further to catch all the cases where "bar" preceded "foo")  

The point is that there are more than just `p`, `s`, and `d` lines in the `ex` command set.   

The `:` addresses can also refer to marks.  Thus you can use: `:'a,'bg/foo/j` to join any line containing the string foo to its subsequent line, if it lies between the lines between the '<em>a</em>' and '<em>b</em>' marks.  (Yes, all of the preceding `ex` command examples can be limited to subsets of the file's lines by prefixing with these sorts of addressing expressions).  

That's pretty obscure (I've only used something like that a few times in the last 15 years). However, I'll freely admit that I've often done things iteratively and interactively that could probably have been done more efficiently if I'd taken the time to think out the correct incantation.  

Another very useful <strong>vi</strong> or <strong>ex</strong> command is `:r` to read in the contents of another file.  Thus: `:r foo` inserts the contents of the file named "foo" at the current line.    

More powerful is the `:r!` command.  This reads the results of a command.  It's the same as suspending the <strong>vi</strong> session, running a command, redirecting its output to a temporary file, resuming your <strong>vi</strong> session, and reading in the contents from the temp. file.  

Even more powerful are the `!` (bang) and `:... !` (<strong>ex</strong> bang) commands.  These also execute external commands and read the results into the current text. However, they also filter selections of our text through the command!  This we can sort all the lines in our file using `1G!Gsort` (`G` is the <strong>vi</strong> "goto" command; it defaults to going to the last line of the file, but can be prefixed by a line number, such as 1, the first line).  This is equivalent to the <strong>ex</strong> variant `:1,$!sort`.  Writers often use `!` with the Unix <strong>fmt</strong> or <strong>fold</strong> utilities for reformating or "word wrapping" selections of text.  A very common macro is `{!}fmt` (reformat the current paragraph).  Programmers sometimes use it to run their code, or just portions of it, through <strong>indent</strong> or other code reformatting tools.  

Using the `:r!` and `!` commands means that any external utility or filter can be treated as an extension of our editor.  I have occasionally used these with scripts that pulled data from a database, or with <strong>wget</strong> or <strong>lynx</strong> commands that pulled data off a website, or <strong>ssh</strong> commands that pulled data from remote systems.  

Another useful <strong>ex</strong> command is `:so` (short for `:source`).  This reads the contents of a file as a series of commands.  When you start <strong>vi</strong> it normally, implicitly, performs a `:source` on `~/.exinitrc` file (and <strong>Vim</strong> usually does this on `~/.vimrc`, naturally enough).  The use of this is that you can change your editor profile on the fly by simply sourcing in a new set of macros, abbreviations, and editor settings.  If you're sneaky you can even use this as a trick for storing sequences of <strong>ex</strong> editing commands to apply to files on demand.  

For example I have a seven line file (36 characters) which runs a file through <strong>wc</strong>, and inserts a C-style comment at the top of the file containing that word count data.  I can apply that "macro" to a file by using a command like: `vim +'so mymacro.ex' ./mytarget`  

(The `+` command line option to <strong>vi</strong> and <strong>Vim</strong> is normally used to start the editing session at a given line number.  However it's a little known fact that one can follow the `+` by any valid <strong>ex</strong> command/expression, such as a "source" command as I've done here; for a simple example I have scripts which invoke: `vi +'/foo/d|wq!' ~/.ssh/known_hosts` to remove an entry from my SSH known hosts file non-interactively while I'm re-imaging a set of servers).  

Usually it's far easier to write such "macros" using Perl, AWK, <strong>sed</strong> (which is, in fact, like <strong>grep</strong> a utility inspired by the <strong>ed</strong> command).  

<p>The `@` command is probably the most obscure <strong>vi</strong> command.  In occasionally teaching advanced systems administration courses for close to a decade I've met very few people who've ever used it.  `@` executes the contents of a register as if it were a <strong>vi</strong> or <strong>ex</strong> command.<br>
Example: I often use: `:r!locate ...` to find some file on my system and read its name into my document.  From there I delete any extraneous hits, leaving only the full path to the file I'm interested in.  Rather than laboriously <kbd>Tab</kbd>-ing through each component of the path (or worse, if I happen to be stuck on a machine without Tab completion support in its copy of <strong>vi</strong>) I just use:</p>

<ol>
<li>`0i:r` (to turn the current line into a valid <strong>:r</strong> command),</li>
<li>`"cdd` (to delete the line into the "c" register) and</li>
<li>`@c` execute that command.</li>
</ol>

That's only 10 keystrokes (and the expression `"cdd` `@c` is effectively a finger macro for me, so I can type it almost as quickly as any common six letter word).  

<hr>

<h5>A sobering thought</h3>

I've only scratched to surface of <strong>vi</strong>'s power and none of what I've described here is even part of the "improvements" for which <strong>vim</strong> is named!  All of what I've described here should work on any old copy of <strong>vi</strong> from 20 or 30 years ago.  

There are people who have used considerably more of <strong>vi</strong>'s power than I ever will.   

#### Answer 2 (score 505)
You are talking about text selecting and copying, I think that you should give a look to the <a href="http://www.vim.org/htmldoc/visual.html" rel="nofollow noreferrer">Vim Visual Mode</a>.  

In the visual mode, you are able to select text using Vim commands, then you can do whatever you want with the selection.  

Consider the following common scenarios:  

You need to select to the next matching parenthesis.  

You could do:  

<ul>
<li><strong>`v%`</strong> if the cursor is on the starting/ending parenthesis</li>
<li><strong>`vib`</strong> if the cursor is inside the parenthesis block</li>
</ul>

<img src="https://dl.dropbox.com/u/35146/stackoverflow/Vim/parens.gif" />  

You want to select text between quotes:  

<ul>
<li><strong>vi"</strong> for double quotes </li>
<li><strong>vi'</strong> for single quotes</li>
</ul>

<img src="https://dl.dropbox.com/u/35146/stackoverflow/Vim/quotes.gif" />  

You want to select a curly brace block (very common on C-style languages):  

<ul>
<li><strong>`viB`</strong></li>
<li><strong>`vi{`</strong></li>
</ul>

<img src="https://dl.dropbox.com/u/35146/stackoverflow/Vim/viB.gif" />  

You want to select the entire file:  

<ul>
<li><strong>`ggVG`</strong> </li>
</ul>

<a href="http://vimdoc.sourceforge.net/htmldoc/visual.html#CTRL-V" rel="nofollow noreferrer">Visual block selection</a> is another really useful feature, it allows you to select a rectangular area of text, you just have to press <kbd>Ctrl</kbd>-<kbd>V</kbd> to start it, and then select the text block you want and perform any type of operation such as yank, delete, paste, edit, etc. It's great to edit <em>column oriented</em> text.  

<img src="https://dl.dropbox.com/u/35146/stackoverflow/Vim/blockselection.gif" />  

#### Answer 3 (score 207)
Some productivity tips:  

<strong>Smart movements</strong>  

<ul>
<li>`*` and  `#` search for the word under the cursor forward/backward.</li>
<li>`w` to the next word</li>
<li>`W` to the next space-separated word</li>
<li>`b` / `e` to the begin/end of the current word. (`B` / `E` for space separated only)</li>
<li>`gg` / `G` jump to the begin/end of the file.</li>
<li>`%` jump to the matching { .. } or ( .. ), etc..</li>
<li>`{` / `}` jump to next paragraph.</li>
<li>`'.` jump back to last edited line.</li>
<li>`g;` jump back to last edited position.</li>
</ul>

<strong>Quick editing commands</strong>  

<ul>
<li>`I` insert at the begin.</li>
<li>`A` append to end.</li>
<li>`o` / `O` open a new line after/before the current.</li>
<li>`v` / `V` / `Ctrl+V` visual mode (to select text!)</li>
<li>`Shift+R` replace text</li>
<li>`C` change remaining part of line.</li>
</ul>

<strong>Combining commands</strong>  

Most commands accept a amount and direction, for example:  

<ul>
<li>`cW` = change till end of word</li>
<li>`3cW` = change 3 words</li>
<li>`BcW` = to begin of full word, change full word</li>
<li>`ciW` = change inner word.</li>
<li>`ci"` = change inner between ".."</li>
<li>`ci(` = change text between ( .. )</li>
<li>`ci&lt;` = change text between &lt; .. >  (needs `set matchpairs+=&lt;:&gt;` in vimrc)</li>
<li>`4dd` = delete 4 lines</li>
<li>`3x` = delete 3 characters.</li>
<li>`3s` = substitute 3 characters.</li>
</ul>

<strong>Useful programmer commands</strong>  

<ul>
<li>`r` replace one character (e.g. `rd` replaces the current char with `d`).</li>
<li>`~` changes case.</li>
<li>`J` joins two lines</li>
<li>Ctrl+A / Ctrl+X increments/decrements a number.</li>
<li>`.` repeat last command (a simple macro)</li>
<li>`==` fix line indent</li>
<li>`&gt;` indent block (in visual mode)</li>
<li>`&lt;` unindent block (in visual mode)</li>
</ul>

<strong>Macro recording</strong>  

<ul>
<li>Press `q[ key ]` to start recording.</li>
<li>Then hit `q` to stop recording.</li>
<li>The macro can be played with `@[ key ]`.</li>
</ul>

By using very specific commands and movements, VIM can replay those exact actions for the next lines. (e.g. A for append-to-end, `b` / `e` to move the cursor to the begin or end of a word respectively)  

<strong>Example of well built settings</strong>  

```vim
# reset to vim-defaults
if &compatible          # only if not set before:
  set nocompatible      # use vim-defaults instead of vi-defaults (easier, more user friendly)
endif

# display settings
set background=dark     # enable for dark terminals
set nowrap              # dont wrap lines
set scrolloff=2         # 2 lines above/below cursor when scrolling
set number              # show line numbers
set showmatch           # show matching bracket (briefly jump)
set showmode            # show mode in status bar (insert/replace/...)
set showcmd             # show typed command in status bar
set ruler               # show cursor position in status bar
set title               # show file in titlebar
set wildmenu            # completion with menu
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set laststatus=2        # use 2 lines for the status bar
set matchtime=2         # show matching bracket for 0.2 seconds
set matchpairs+=<:>     # specially for html

# editor settings
set esckeys             # map missed escape sequences (enables keypad keys)
set ignorecase          # case insensitive searching
set smartcase           # but become case sensitive if you type uppercase characters
set smartindent         # smart auto indenting
set smarttab            # smart tab handling for indenting
set magic               # change the way backslashes are used in search patterns
set bs=indent,eol,start # Allow backspacing over everything in insert mode

set tabstop=4           # number of spaces a tab counts for
set shiftwidth=4        # spaces for autoindents
#set expandtab           # turn a tabs into spaces

set fileformat=unix     # file mode is unix
#set fileformats=unix,dos    # only detect unix file format, displays that ^M with dos files

# system settings
set lazyredraw          # no redraws in macros
set confirm             # get a dialog when :q, :w, or :wq fails
set nobackup            # no backup~ files.
set viminfo='20,\"500   # remember copy registers after quitting in the .viminfo file -- 20 jump links, regs up to 500 lines'
set hidden              # remember undo after quitting
set history=50          # keep 50 lines of command history
set mouse=v             # use mouse in visual mode (not normal,insert,command,help mode


# color settings (if terminal/gui supports it)
if &t_Co > 2 || has("gui_running")
  syntax on          # enable colors
  set hlsearch       # highlight search (very useful!)
  set incsearch      # search incremently (search while typing)
endif

# paste mode toggle (needed when using autoindent/smartindent)
map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>

# Use of the filetype plugins, auto completion and indentation support
filetype plugin indent on

# file type specific settings
if has("autocmd")
  # For debugging
  #set verbose=9

  # if bash is sh.
  let bash_is_sh=1

  # change to directory of current file automatically
  autocmd BufEnter * lcd %:p:h

  # Put these in an autocmd group, so that we can delete them easily.
  augroup mysettings
    au FileType xslt,xml,css,html,xhtml,javascript,sh,config,c,cpp,docbook set smartindent shiftwidth=2 softtabstop=2 expandtab
    au FileType tex set wrap shiftwidth=2 softtabstop=2 expandtab

    # Confirm to PEP8
    au FileType python set tabstop=4 softtabstop=4 expandtab shiftwidth=4 cinwords=if,elif,else,for,while,try,except,finally,def,class
  augroup END

  augroup perl
    # reset (disable previous 'augroup perl' settings)
    au!  

    au BufReadPre,BufNewFile
    \ *.pl,*.pm
    \ set formatoptions=croq smartindent shiftwidth=2 softtabstop=2 cindent cinkeys='0{,0},!^F,o,O,e' " tags=./tags,tags,~/devel/tags,~/devel/C
    # formatoption:
    #   t - wrap text using textwidth
    #   c - wrap comments using textwidth (and auto insert comment leader)
    #   r - auto insert comment leader when pressing <return> in insert mode
    #   o - auto insert comment leader when pressing 'o' or 'O'.
    #   q - allow formatting of comments with "gq"
    #   a - auto formatting for paragraphs
    #   n - auto wrap numbered lists
    #   
  augroup END


  # Always jump to the last known cursor position. 
  # Don't do it when the position is invalid or when inside
  # an event handler (happens when dropping a file on gvim). 
  autocmd BufReadPost * 
    \ if line("'\"") > 0 && line("'\"") <= line("$") | 
    \   exe "normal g`\"" | 
    \ endif 

endif # has("autocmd")
```

The settings can be stored in `~/.vimrc`, or system-wide in `/etc/vimrc.local` and then by read from the `/etc/vimrc` file using:  

```vim
source /etc/vimrc.local
```

(you'll have to replace the `#` comment character with `"` to make it work in VIM, I wanted to give proper syntax highlighting here).  

The commands I've listed here are pretty basic, and the main ones I use so far. They already make me quite more productive, without having to know all the fancy stuff.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: How to replace a character by a newline in Vim (score [739765](https://stackoverflow.com/q/71323) in 2019)

#### Question
I'm trying to replace each `,` in the current file by a new line:  

```vim
:%s/,/\n/g 
```

But it inserts what looks like a `^@` instead of an actual newline. The file is not in DOS mode or anything.  

What should I do?  

If you are curious, like me, check the question <em><a href="https://stackoverflow.com/questions/71417/why-is-r-a-newline-for-vim">Why is \r a newline for Vim?</a></em> as well.  

#### Answer accepted (score 2415)
<h5>Use `\r` instead of `\n`.</h2>

Substituting by `\n` inserts a null character into the text. To get a newline, use `\r`. When <em>searching</em> for a newline, you’d still use `\n`, however. This asymmetry is due to the fact that `\n` and `\r` <a href="http://vim.wikia.com/wiki/Search_and_replace" rel="noreferrer">do slightly different things</a>:  

`\n` matches an end of line (newline), whereas `\r` matches a carriage return. On the other hand, in substitutions `\n` inserts a null character whereas `\r` inserts a newline (more precisely, it’s treated as the input <kbd>&lt;CR&gt;</kbd>). Here’s a small, non-interactive example to illustrate this, using the Vim command line feature (in other words, you can copy and paste the following into a terminal to run it). `xxd` shows a hexdump of the resulting file.  

```vim
echo bar > test
(echo 'Before:'; xxd test) > output.txt
vim test '+s/b/\n/' '+s/a/\r/' +wq
(echo 'After:'; xxd test) >> output.txt
more output.txt
```



```vim
Before:
0000000: 6261 720a                                bar.
After:
0000000: 000a 720a                                ..r.
```

In other words, `\n` has inserted the byte 0x00 into the text; `\r` has inserted the byte 0x0a.  

#### Answer 2 (score 193)
Here's the trick:   

First, set your vi(m) session to allow pattern matching with special characters (ie: newline). It's probably worth putting this line in your .vimrc or .exrc file.  

```vim
:set magic
```

Next, do:  

```vim
:s/,/,^M/g
```

To get the `^M` character, type <kbd>Control</kbd>-<kbd>v</kbd> and hit <kbd>Enter</kbd>. Under Windows, do <kbd>Control</kbd>-<kbd>q</kbd>, <kbd>Enter</kbd>. The only way I can remember these is by remembering how little sense they make:   

<blockquote>
  A: <em>What would be the worst control-character to use to represent a newline?</em>  
  
  B: <em>Either `q` (because it usually means "Quit") or `v` because it would be so easy to type <kbd>Control</kbd>-<kbd>c</kbd> by mistake and kill the editor.</em>  
  
  A: <em>Make it so.</em>  
</blockquote>

#### Answer 3 (score 90)
In the syntax `s/foo/bar` `\r` and `\n` have different meanings, depending on context.  

<hr>

<h5>short:</h2>

<p>For `foo`:<br/>
\n = newline (LF on linux/mac, CRLF on windows)<br/>
\r = carriage return (CR)<br/></p>

<p>For `bar`:<br/>
\r = is newline<br/>
\n = null byte.<br/></p>

<h5>longer: (with ascii numbers)</h2>


`NUL` = 0x00 = 0 = <kbd>CTRL</kbd><kbd>@</kbd><br/>
`LF` = 0x0A = 10 = <kbd>CTRL</kbd><kbd>J</kbd><br/>
`CR` = 0x0D = 13 = <kbd>CTRL</kbd><kbd>M</kbd></p>

<p>Here is a list of the <a href="http://www.cs.tut.fi/~jkorpela/chars/c0.html" rel="noreferrer">ASCII control characters</a>, insert them in `vim` via <kbd>CTRL</kbd><kbd>v</kbd><kbd>CTRL</kbd><kbd>---key---</kbd>.<br/>
In `bash` or the other unix/linux shells just type <kbd>CTRL</kbd><kbd>---key---</kbd>. Try <kbd>CTRL</kbd><kbd>M</kbd> in bash, its the same as hitting <kbd>ENTER</kbd>, as the shell realizes what is meant, even though linux systems use Line Feeds for line delimiting.</p>

To insert literal's in bash, prepending them with <kbd>CTRL</kbd><kbd>v</kbd> will also work.  

Try in bash:   

```vim
echo ^[[33;1mcolored.^[[0mnot colored.
```

This uses <a href="http://en.wikipedia.org/wiki/ANSI_escape_code" rel="noreferrer">ANSI escape sequences</a>, insert the two `^[`'s via <kbd>CTRL</kbd><kbd>v</kbd><kbd>ESC</kbd>.  

You might also try <kbd>CTRL</kbd><kbd>v</kbd><kbd>CTRL</kbd><kbd>m</kbd><kbd>ENTER</kbd>, which will give you this:  

```vim
bash: $'\r': command not found
```

Remember the `\r` from above? :>  

<p>This <a href="http://www.cs.tut.fi/~jkorpela/chars/c0.html" rel="noreferrer">ASCII control characters</a> list is different from a complete <a href="http://ascii-code.com/" rel="noreferrer">ASCII symbol table</a>, in that the control characters, which are inserted into a console/pseudoterminal/vim via the <kbd>CTRL</kbd> key (haha), can be found there. 
Whereas in C and most other languages you usually use the octal codes to represent these 'characters'.</p>

<p>If you really want to know where all this comes from: <a href="http://www.linusakesson.net/programming/tty/" rel="noreferrer">http://www.linusakesson.net/programming/tty/</a>. <br/>
This is the best link you will come across about this topic, but beware: There be dragons.</p>

<hr>

<em>TL;DR</em>  

Usually `foo` = `\n`, and `bar` = `\r`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: Copy all the lines to clipboard (score [729835](https://stackoverflow.com/q/1620018) in 2019)

#### Question
Is there any way to copy all lines from open file to clipboard in VI editor. I tried <kbd>y</kbd><kbd>G</kbd> but it's not using clipboard to store those lines.   

So is it possible?  

#### Answer accepted (score 580)
You should yank the text to the `*` or `+` <a href="http://3.bp.blogspot.com/-Mp8uW2YRtsQ/TyVC1_JDanI/AAAAAAAAASI/hDfS9m7E3iY/s1600/vim_regs_p1.png" rel="noreferrer">registers</a>:  

<kbd>g</kbd><kbd>g</kbd><kbd>"</kbd><kbd>*</kbd><kbd>y</kbd><kbd>G</kbd>  

Explanation:   

<ul>
<li>`gg` to get the cursor to the first character of the file</li>
<li>`"*y` to start a yank command to the register `*` from the first line, until...</li>
<li>`G` to go the end of the file</li>
</ul>

#### Answer 2 (score 639)
Use:  

<kbd>:</kbd><kbd>%</kbd><kbd>y</kbd><kbd>+</kbd>  

to yank all lines.  

Explanation:  

<ul>
<li>`%` to refer the next command to work on all the lines</li>
<li>`y` to yank those lines</li>
<li>`+` to copy to the system clipboard</li>
</ul>

<strong>NB</strong>: In Windows, `+` and `*` are equivalent <a href="https://stackoverflow.com/a/3961954/341156">see this answer</a>.  

#### Answer 3 (score 76)
on Mac  

<ul>
<li><p>copy selected part: visually select text(type `v` or `V` in normal
mode) and type `:w !pbcopy`</p></li>
<li><p>copy the whole file `:%w !pbcopy`</p></li>
<li><p>past from the clipboard `:r !pbpaste`</p></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: How do I move to end of line in Vim? (score [683506](https://stackoverflow.com/q/105721) in 2017)

#### Question
I know how to generally move around in command mode, specifically, jumping to lines, etc. But what is the command to jump to the end of the line that I am currently on?  

#### Answer accepted (score 1940)
Just the <kbd>$</kbd> <em>(dollar sign)</em> key.  You can use <kbd>A</kbd> to move to the end of the line and switch to editing mode (Append).  To jump the last non-blank character, you can press <kbd>g</kbd> then <kbd>_</kbd> keys.  

The opposite of <kbd>A</kbd> is <kbd>I</kbd> (Insert mode at beginning of line), as an aside.  Pressing just the <kbd>^</kbd> will place your cursor at the beginning of the line.  

#### Answer 2 (score 291)
As lots of people have said:  

<ul>
<li><kbd>$</kbd> gets you to the end of the line</li>
</ul>

but also:  

<ul>
<li><kbd>^</kbd> or <kbd>_</kbd> gets you to the first non-whitespace character in the line, and</li>
<li><kbd>0</kbd> (zero) gets you to the beginning of the line incl. whitespace</li>
</ul>

#### Answer 3 (score 135)
<ul>
<li><kbd>$</kbd> moves to the last character on the line.</li>
<li><p><kbd>g</kbd> <kbd>_</kbd> goes to the last non-whitespace character.</p></li>
<li><p><kbd>g</kbd> <kbd>$</kbd> goes to the end of the screen line (when a buffer line is wrapped across multiple screen lines)</p></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: Duplicate a whole line in Vim (score [671286](https://stackoverflow.com/q/73319) in 2017)

#### Question
How do I duplicate a whole line in Vim in a similar way to <kbd>Ctrl</kbd>+<kbd>D</kbd> in IntelliJ IDEA/Resharper or <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>&#8593;</kbd>/<kbd>&#8595;</kbd> in Eclipse?  

#### Answer accepted (score 2625)
<p><kbd>y</kbd><kbd>y</kbd> or <kbd>Y</kbd> to copy the line (mnemonic: <strong><em>y</strong>ank</em>)
<br />or
<br /><kbd>d</kbd><kbd>d</kbd> to <strong><em>d</strong>elete</em> the line (Vim copies what you deleted into a clipboard-like "register", like a <em>cut</em> operation)</p>

then  

<p><kbd>p</kbd> to <strong><em>p</strong>aste</em> the copied or deleted text <em>after</em> the current line
<br />or
<br /><kbd>P</kbd> to <strong><em>p</strong>aste</em> the copied or deleted text <em>before</em> the current line</p>

#### Answer 2 (score 392)
Normal mode: see other answers.  

The <a href="https://en.wikipedia.org/wiki/Ex_%28text_editor%29" rel="noreferrer" title="text editor">Ex</a> way:  

<ul>
<li>`:t.` will duplicate the line,</li>
<li>`:t 7` will copy it after line 7,</li>
<li>`:,+t0` will copy current and next line at the beginning of the file (`,+` is a synonym for the range `.,.+1`),</li>
<li>`:1,t$` will copy lines from beginning till cursor position to the end (`1,` is a synonym for the range `1,.`).</li>
</ul>

If you need to move instead of copying, use `:m` instead of `:t`.  

This can be really powerful if you combine it with `:g` or `:v`:   

<ul>
<li>`:v/foo/m$` will move all lines not matching the pattern “foo” to the end of the file.</li>
<li>`:+,$g/^\s*class\s\+\i\+/t.` will copy all subsequent lines of the form `class xxx` right after the cursor.</li>
</ul>

Reference: `:help range`, `:help :t`, `:help :g`, `:help :m` and `:help :v`  

#### Answer 3 (score 288)
`YP` or `Yp` or `yyp`.  

  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: Make Vim show ALL white spaces as a character (score [585726](https://stackoverflow.com/q/1675688) in )

#### Question
<p>I can't find a way to make Vim show all white spaces as a character.
All I found was about tabs, trailing spaces etc.</p>

#### Answer 2 (score 651)
As others have said, you could use  

```vim
:set list
```

which will, in combination with  

```vim
:set listchars=...
```

<p>display invisible characters.<br>
Now, there isn't an explicit option which you can use to <em>show</em> whitespace, but in listchars, you could set a character to show for everything BUT whitespace. For example, mine looks like this</p>

```vim
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
```

so, now, after you use  

```vim
:set list
```

everything that isn't explicitly shown as something else, is then, really, a plain old whitespace.  

As usual, to understand how `listchars` works, use the help. It provides great information about what chars can be displayed (like trailing space, for instance) and how to do it:  

```vim
:help listchars
```

It might be helpful to add a toggle to it so you can see the changes mid editing easily (source: <a href="https://stackoverflow.com/questions/12534313/vim-set-list-as-a-toggle-in-vimrc">VIM :set list! as a toggle in .vimrc</a>):  

```vim
noremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>
```

#### Answer 3 (score 247)
`:set list` to enable.  

`:set nolist` to disable.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How to effectively work with multiple files in Vim? (score [552719](https://stackoverflow.com/q/53664) in 2011)

#### Question
I've started using Vim to develop Perl scripts and am starting to find it very powerful.   

One thing I like is to be able to open multiple files at once with e.g. `vi main.pl maintenance.pl` and then hop between them with:  

```vim
:n
:prev
```

and see which file are open with  

```vim
:args
```

And to add a file, I can say:   

```vim
:n test.pl
```

which I expect would then be ADDED to my list of files, but instead it wipes out my current file list and when I type `:args` I only have `test.pl` open.  

So how can I ADD and REMOVE files to my args list?  

#### Answer accepted (score 1138)
<p>Why not use tabs (introduced in Vim 7)?
You can switch between tabs with `:tabn` and `:tabp`,
With `:tabe &lt;filepath&gt;` you can add a new tab; and with a regular `:q` or `:wq` you close a tab.
If you map `:tabn` and `:tabp` to your <kbd>F7</kbd>/<kbd>F8</kbd> keys you can easily switch between files.</p>

If there are not that many files or you don't have Vim 7 you can also split your screen in multiple files: `:sp &lt;filepath&gt;`. Then you can switch between splitscreens with <kbd>Ctrl</kbd>+<kbd>W</kbd> and then an arrow key in the direction you want to move (or instead of arrow keys, <kbd>w</kbd> for next and <kbd>W</kbd> for previous splitscreen)  

#### Answer 2 (score 539)
<h5>Listing</h3>

To see a list of current buffers, I use:  

```vim
:ls
```

<hr>

<h5>Opening</h3>

To open a new file, I use  

```vim
:e ../myFile.pl
```

with enhanced tab completion (put `set wildmenu` in your `.vimrc`).  

Note: you can also use `:find` which will search a set of paths for you, but you need to customize those paths first.  

<hr>

<h5>Switching</h3>

To switch between all open files, I use  

```vim
:b myfile
```

with enhanced tab completion (still `set wildmenu`).  

Note: `:b#` chooses the last visited file, so you can use it to switch quickly between two files.  

<hr>

<h5>Using windows</h3>

`Ctrl-W s` and `Ctrl-W v` to split the current window horizontally and vertically. You can also use `:split` and `:vertical split` (`:sp` and `:vs`)  

`Ctrl-W w` to switch between open windows, and `Ctrl-W h` (or `j` or `k` or `l`) to navigate through open windows.  

`Ctrl-W c` to close the current window, and `Ctrl-W o` to close all windows except the current one.  

Starting vim with a `-o` or `-O` flag opens each file in its own split.  

<hr>

With all these I don't need tabs in Vim, and my fingers find my buffers, not my eyes.  

Note: if you want all files to go to the same instance of Vim, start Vim with the `--remote-silent` option.  

#### Answer 3 (score 227)
```vim
:ls
```

for list of open buffers  

<ul>
<li>`:bp` previous buffer</li>
<li>`:bn` next buffer</li>
<li>`:bn` (`n` a number) move to n'th buffer</li>
<li>`:b &lt;filename-part&gt;` with tab-key providing auto-completion (awesome !!)</li>
</ul>

In some versions of vim, `bn` and `bp` are actually `bnext` and `bprevious` respectively. Tab auto-complete is helpful in this case.  

Or when you are in normal mode, use `^` to switch to the last file you were working on.  

Plus, you can save sessions of vim  

```vim
:mksession! ~/today.ses
```

The above command saves the current open file buffers and settings to `~/today.ses`. You can load that session by using  

```vim
vim -S ~/today.ses
```

No hassle remembering where you left off yesterday. ;)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: How to make vim paste from (and copy to) system's clipboard? (score [525630](https://stackoverflow.com/q/11489428) in 2015)

#### Question
Unlike other editors, vim stores copied text in its own clipboard. So, it's very hard for me to copy some text from a webpage and paste it into the current working file. It so happens I have to either open gedit or type it manually.  

Can I make vim paste from and to the system's clipboard?  

#### Answer accepted (score 815)
The `"*` and `"+` registers are for the system's clipboard (`:help registers`). Depending on your system, they may do different things. For instance, on systems that don't use X11 like OSX or Windows, the `"*` register is used to read and write to the system clipboard. On X11 systems both registers can be used. See `:help x11-selection` for more details, but basically the `"*` is analogous to X11's <em>PRIMARY</em> selection (which usually copies things you select with the mouse and pastes with the middle mouse button) and `"+` is analogous to X11's <em>CLIPBOARD</em> selection (which is the clipboard proper).  

If all that went over your head, try using `"*yy` or `"+yy` to copy a line to your system's clipboard. Assuming you have the appropriate compile options, one or the other should work. You might like to remap this to something more convenient for you. For example, you could put `vnoremap &lt;C-c&gt; "*y` in your ~/.vimrc so that you can visually select and press <kbd>Ctrl</kbd>+<kbd>c</kbd> to yank to your system's clipboard.  

Be aware that copying/pasting from the system clipboard <strong>will not work</strong> if `:echo has('clipboard')` returns 0. In this case, vim is not compiled with the `+clipboard` feature and you'll have to install a different version or recompile it. Some linux distros supply a minimal vim installation by default, but generally if you <strong>install the `vim-gtk` or `vim-gtk3` package</strong> you can get the extra features.  

You also may want to have a look at the `'clipboard'` option described at `:help cb`. In this case you can `:set clipboard=unnamed` or `:set clipboard=unnamedplus` to make all yanking/deleting operations automatically copy to the system clipboard. This could be an inconvenience in some cases where you are storing something else in the clipboard as it will override it.  

To paste you can use `"+p` or `"*p` (again, depending on your system and/or desired selection) or you can map these to something else. I type them explicitly, but I often find myself in insert mode. If you're in insert mode you can still paste them with proper indentation by using `&lt;C-r&gt;&lt;C-p&gt;*` or `&lt;C-r&gt;&lt;C-p&gt;+`. See `:help i_CTRL-R_CTRL-P`.  

It's also worth mentioning vim's `paste` option (`:help paste`). This puts vim into a special "paste mode" that disables several other options, allowing you to easily paste into vim using your terminal emulator or multiplexer's familiar paste shortcut. Simply type `:set paste` to enable it, paste your content and then type `:set nopaste` to disable it. Alternatively, you can use the `pastetoggle` option to set a keycode that toggles the mode (`:help pastetoggle`). I recommend using registers instead of these options, but if they are still too scary this can be a convenient workaround while you're perfecting your vim chops.  

See `:help clipboard` for more detailed information.  

#### Answer 2 (score 132)
You can copy into vim by gnome-terminal's shortcut for paste. Make the file in insert mode and use   

<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>v</kbd>.   

Remember beforehand to   

```vim
 :set paste 
```

to avoid messing with the indentation.  

#### Answer 3 (score 39)
<h5>Linux</h3>

On my Linux system, the `+` and `*` registers map to an X11 selection, which can be pasted with the middle mouse button. When `:set clipboard=unnamed` and `:set clipboard=unnamedplus` are used, then the registers map to the clipboard, and can be pasted with CTRL-V.  

The specifics seem to be somewhat configuration and system dependent, so your mileage will definitely vary. It should definitely get you pointed in the right direction, though.  

<h5>See Also</h3>

<a href="http://vim.wikia.com/wiki/Accessing_the_system_clipboard" rel="noreferrer">http://vim.wikia.com/wiki/Accessing_the_system_clipboard</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: Convert DOS line endings to Linux line endings in vim (score [517407](https://stackoverflow.com/q/82726) in 2016)

#### Question
<p>If I open files I created in Windows, the lines all end with `^M`.<br>
How do I delete these characters all at once?</p>

#### Answer accepted (score 1029)
<a href="https://sourceforge.net/projects/dos2unix" rel="noreferrer">dos2unix</a> is a commandline utility that will do this, or `:%s/^M//g` will if you use <kbd>Ctrl</kbd>-<kbd>v</kbd> <kbd>Ctrl</kbd>-<kbd>m</kbd> to input the ^M, or you can `:set ff=unix` and vim will do it for you.  

Docs on the 'fileformat' setting are <a href="http://www.vim.org/htmldoc/options.html#%27fileformat%27" rel="noreferrer">here</a>, and the vim wiki has a comprehensive <a href="http://vim.wikia.com/wiki/Change_end-of-line_format_for_dos-mac-unix" rel="noreferrer">page on line ending conversions</a>.  

Alternately, if you move files back and forth a lot, you might not want to convert them, but rather to do `:set ff=dos`, so vim will know it's a DOS file and use DOS conventions for line endings.  

#### Answer 2 (score 261)
Change the line endings in the view:  

```vim
:e ++ff=dos
:e ++ff=mac
:e ++ff=unix
```

This can also be used as saving operation (:w alone will not save using the line endings you see on screen):  

```vim
:w ++ff=dos
:w ++ff=mac
:w ++ff=unix
```

And you can use it from the command-line:  

```vim
for file in *.cpp
do 
    vi +':w ++ff=unix' +':q' "$file"
done
```

#### Answer 3 (score 155)
I typically use  

```vim
:%s/\r/\r/g
```

which seems a little odd, but works because of the way that vim matches linefeeds.  I also find it easier to remember :)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: Move cursor to end of file in vim (score [515115](https://stackoverflow.com/q/17012308) in 2013)

#### Question
When I want the cursor to go to the end of the file (i.e. the end of the last line) in Vim, I have to type six keystrokes:  

`&lt;ESC&gt;G$a` - which translates to <kbd>ESC</kbd> + <kbd>Shift</kbd><kbd>g</kbd> + <kbd>Shift</kbd><kbd>4</kbd> + <kbd>a</kbd> on my keyboard layout.   

How can I do this more efficiently?  

Since I regularly work on many different machines, I cannot always change .vimrc, so I'm looking for answers without having to edit or create that file.  

#### Answer accepted (score 346)
<p>No need to explicitly go to the end of line before doing <a href="http://vimdoc.sourceforge.net/htmldoc/insert.html#a">`a`</a>, use <a href="http://vimdoc.sourceforge.net/htmldoc/insert.html#A">`A`</a>;<br>
<em>Append text at the end of line [count] times</em></p>

`&lt;ESC&gt;GA`  

#### Answer 2 (score 424)
This is quicker. Just use this   

```vim
:$
```

#### Answer 3 (score 112)
Hit <kbd>Esc</kbd> and then press: <kbd>Shift</kbd> + <kbd>G</kbd>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: Where is my .vimrc file? (score [466283](https://stackoverflow.com/q/10921441) in 2015)

#### Question
I have been using <a href="http://en.wikipedia.org/wiki/Vim_%28text_editor%29" rel="noreferrer">Vim</a>, and I would really like to save my settings. The problem I am having is that I cannot find my .vimrc file, and it is not in the standard `/home/user/.vimrc` location. How might I find this file?  

#### Answer accepted (score 443)
You need to create it. In most installations I've used it hasn't been created by default.  

You usually create it as `~/.vimrc`.   

#### Answer 2 (score 338)
`:scriptnames` list all the .vim files that Vim loaded for you, including your `.vimrc` file.  

`:e $MYVIMRC` open &amp; edit the current .vimrc that you are using, then use <kbd>Ctrl</kbd> + <kbd>G</kbd> to view the path in status bar.  

#### Answer 3 (score 86)
<h5>Short answer:</h1>

To create your vimrc, start up Vim and do one of the following:  

```vim
:e $HOME/.vimrc  " on Unix, Mac or OS/2

:e $HOME/_vimrc  " on Windows

:e s:.vimrc      " on Amiga
```

Insert the settings you want, and save the file.  

Note that exisitence of this file will disable the `compatible` option. See below for details.  

<h5>Long answer:</h1>

There are two kinds of vimrc:  

<ul>
<li>the <em>user vimrc</em> in `$HOME`</li>
<li>the <em>system vimrc</em> in `$VIM` (on Amiga systems, `s:.vimrc` is considered a user vimrc)</li>
</ul>

<strong>The user vimrc file often does not exist until created by the user.</strong> If you cannot find `$HOME/.vimrc` (or `$HOME/_vimrc` on Windows) then you can, and probably should, just create it.  

<strong>The system vimrc should normally be left unmodified</strong> and is located in the `$VIM`<sup>*</sup> directory. The system vimrc is <em>not</em> a good place you keep your personal settings. If you modify this file your changes may be overwritten if you ever upgrade Vim. Also, changes here will affect other users on a multi-user system. In most cases, settings in the user vimrc will override settings in the system vimrc.  

From `:help vimrc`:  

<blockquote>
  <p>A file that contains initialization commands is called a "vimrc" file.
  Each line in a vimrc file is executed as an Ex command line.  It is
  sometimes also referred to as "exrc" file.  They are the same type of
  file, but "exrc" is what Vi always used, "vimrc" is a Vim specific
  name.  Also see |vimrc-intro|.</p>
  
  Places for your personal initializations:  

```vim
    Unix            $HOME/.vimrc or $HOME/.vim/vimrc
    OS/2            $HOME/.vimrc, $HOME/vimfiles/vimrc
                    or $VIM/.vimrc (or _vimrc)
    MS-Windows      $HOME/_vimrc, $HOME/vimfiles/vimrc
                    or $VIM/_vimrc
    Amiga           s:.vimrc, home:.vimrc, home:vimfiles:vimrc
                    or $VIM/.vimrc
```
  
  <p>The files are searched in the order specified above and only the first
  one that is found is read.</p>
</blockquote>

(MacOS counts as Unix for the above.)  

Note that the mere <em>existence</em> of a user vimrc will change Vim's behavior by turning off the `compatible` option. From `:help compatible-default`:  

<blockquote>
  <p>When Vim starts, the 'compatible' option is on.  This will be used when Vim
  starts its initializations.  But as soon as a user vimrc file is found, or a
  vimrc file in the current directory, or the "VIMINIT" environment variable is
  set, it will be set to 'nocompatible'.  This has the side effect of setting or
  resetting other options (see 'compatible').  But only the options that have
  not been set or reset will be changed.</p>
</blockquote>

<hr>

<sup>* `$VIM` may not be set in your shell, but is always set inside Vim. If you want to see what it's set to, start up Vim and use the command `:echo $VIM`</sup>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: Vim clear last search highlighting (score [457149](https://stackoverflow.com/q/657447) in 2016)

#### Question
After doing a search in Vim, I get all the occurrences highlighted. How can I disable that?  I now do another search for something gibberish that can't be found.  

Is there a way to just temporarily disable the highlight and then re-enable it when needed again?  

#### Answer accepted (score 1493)
To turn off highlighting until the next search:  

```vim
:noh
```

Or turn off highlighting completely:  

```vim
set nohlsearch
```

Or, to toggle it:  

```vim
set hlsearch!

nnoremap <F3> :set hlsearch!<CR>
```

#### Answer 2 (score 668)
From the <a href="http://vimdoc.sourceforge.net/htmldoc/pattern.html#last-pattern" rel="noreferrer">VIM Documentation</a>  

To clear the last used search pattern:  

```vim
:let @/ = ""
```

<p>This will not set the pattern to an empty string, because that would match 
everywhere. The pattern is really cleared, like when starting Vim.</p>

#### Answer 3 (score 573)
You can do  

```vim
:noh
```

or <a href="http://vimdoc.sourceforge.net/htmldoc/pattern.html#:nohlsearch" rel="noreferrer">`:nohlsearch`</a> to temporarily disable search highlighting until the next search.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: How to copy to clipboard in Vim? (score [437882](https://stackoverflow.com/q/3961859) in 2016)

#### Question
Is it possible to copy to clipboard directly from Vim? `yy` only copies stuff to Vim's internal buffer. I want to copy to the OS's clipboard. Is there any such command in Vim or you can only yank stuff within Vim?  

#### Answer accepted (score 468)
The `*` register will do this. In Windows, `+` and `*` are equivalent. In unix there is a subtle difference between `+` and `*`:  

<blockquote>
  <p>Under Windows, the * and + registers
  are equivalent. For X11 systems,
  though, they differ. For X11 systems,
  * is the selection, and + is the cut buffer (like clipboard). 
  <a href="http://vim.wikia.com/wiki/Accessing_the_system_clipboard" rel="noreferrer">http://vim.wikia.com/wiki/Accessing_the_system_clipboard</a></p>
</blockquote>

`*` is probably what you want most of the time, so I use `*` because it functions as I expect it to in both environments.  

In Linux distros, for some reason, you have to install vim-gtk first to gain clipboard functionality.  

And for those confused about how to use registers when yanking or putting, you merely write `"` then the name of the register. So for copying something to the clipboard register you type `"*y` and then to put you type `"*p`  

#### Answer 2 (score 315)
On Mac <strong>OSX</strong>  

<ul>
<li><p>copy selected part: visually select text(type `v` or `V` in normal
mode) and type `:w !pbcopy`</p></li>
<li><p>copy the whole file `:%w !pbcopy`</p></li>
<li><p>paste from the clipboard `:r !pbpaste`</p></li>
</ul>

On <em>most</em> <strong>Linux</strong> Distros, you can substitute:  

<ul>
<li>`pbcopy` above with `xclip -i -sel c` or `xsel -i -b`</li>
<li>`pbpaste` using `xclip -o -sel -c` or `xsel -o -b`<br>
-- <strong>Note:</strong> <em>In case neither of these tools (`xsel` and `xclip`) are preinstalled on your distro, you can probably find them in the repos</em></li>
</ul>

#### Answer 3 (score 147)
In your vimrc file you can specify to automatically use the system clipboard for copy and paste.  

On Windows set:  

```vim
set clipboard=unnamed
```

On Linux set (vim 7.3.74+):  

```vim
set clipboard=unnamedplus
```

NOTE: You may need to use an up to date version of Vim for these to work.  

<a href="http://vim.wikia.com/wiki/Accessing_the_system_clipboard" rel="noreferrer">http://vim.wikia.com/wiki/Accessing_the_system_clipboard</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: How to do case insensitive search in Vim (score [433542](https://stackoverflow.com/q/2287440) in 2014)

#### Question
I'd like to search for an upper case word, for example COPYRIGHT in a file. I tried performing a search like:  

```vim
/copyright/i    # Doesn't work
```

but it doesn't work.  I know that in Perl, if I give the `i` flag into a regex it will turn the regex into a case-insensitive regex. It seems that Vim  has its own way to indicate a case-insensitive regex.  

#### Answer accepted (score 1985)
You need to use the `\c` escape sequence. So:  

`/\ccopyright`  

To do the inverse (case <em>sensitive</em> matching), use `\C` instead.  

#### Answer 2 (score 644)
As well as the suggestions for `\c` and `ignorecase`, I find the `smartcase` very useful.  If you search for something containing uppercase characters, it will do a case sensitive search; if you search for something purely lowercase, it will do a case insensitive search.  You can use `\c` and `\C` to override this:  

```vim
:set ignorecase
:set smartcase
/copyright      " Case insensitive
/Copyright      " Case sensitive
/copyright\C    " Case sensitive
/Copyright\c    " Case insensitive
```

See:  

```vim
:help /\c
:help /\C
:help 'smartcase'
```

#### Answer 3 (score 273)
You can set the `ic` option in Vim before the search:  

```vim
:set ic
```

To go back to case-sensitive searches use:  

```vim
:set noic
```

`ic` is shorthand for `ignorecase`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: Differences between Emacs and Vim (score [416096](https://stackoverflow.com/q/1430164) in 2018)

#### Question
Without getting into a religious argument about why one is better than the other, what are the <strong>practical</strong> differences between Emacs and Vim? I'm looking to learn one or the other, but I realize the learning curve for each is high and I can't decide. I have never used an editor of this type (I've always used IDEs), so anything that helps a newbie is a plus.  

<hr>

Before a flame war starts: I'm not asking which is better, I'm asking the differences between the two. I would like an <strong>objective</strong> comparison.  

#### Answer accepted (score 468)
<em>(the text below is my opinion, it should not be taken as fact or an insult)</em>  

With Emacs you are expected to have it open 24/7 and live inside the program, almost everything you do can be done from there. You write your own extensions, use it for note-taking, organization, games, programming, shell access, file access, listening to music, web browsing. It takes weeks and weeks till you will be happy with it and then you will learn new stuff all the time. You will be annoyed when you don't have access to it and constantly change your config. You won't be able to use other peoples emacs versions easily and it won't just be installed. It uses Lisp, which is great. You can make it into anything you want it to be. (anything, at all)  

With Vim, it's almost always pre-installed. It's fast. You open up a file do a quick edit and then quit. You can work with the basic setup if you are on someone else's machine. It's not quite so editable, but it's still far better than most text editors. It recognizes that most of the time you are reading/editing not typing and makes that portion faster. You don't suffer from <em><a href="https://en.wikipedia.org/wiki/Emacs#Emacs_pinky" rel="noreferrer">emacs pinkie</a></em>. It's not so infuriating. It's easier to learn.   

<em>Even though I use Emacs all day every day (and love it) unless you intend to spend a lot of time in the program you choose I would pick vim</em>  

#### Answer 2 (score 131)
Vim is not a shell. And it does not communicate well with subprocesses. This is nearly by design, whereas in Emacs, these elements are included by design. This means that some stuff, like embedding a debugger or an interpreter (yielding a sort of IDE), is difficult in Vim.  

Also, Emacs shortcuts are mainly accessed through modifiers, and obviously the Vim interface is famously modal, giving access to an absurd amount of direct keys for manipulation.  

Emacs used to be the only editor of the two that was programmable, and while Vim has a lot of weird levels to its programmability, with the addition of Python and Ruby bindings (and more, I forget), Vim is also programmable in most ways you'd care for.  

I use Vim, and I'm fairly happy with it.  

#### Answer 3 (score 103)
<strong><em>Vim:</em></strong>    

<ul>
<li>better as a simple editor (fewer keys required for simple tasks)</li>
<li>more active scripting community - internal language: vimscript  </li>
<li>one central repository of scripts, plugins, color schemes, ...  </li>
<li>also extensible in python, ruby  </li>
<li>can be made portable (emacs has some problems with that)</li>
</ul>

<strong><em>Emacs:</em></strong>    

<ul>
<li>non modal by default (most of today's editors have taken this approach). Though there is <a href="https://github.com/emacs-evil/evil" rel="noreferrer">evil-mode</a> which emulates vim behavior.</li>
<li>more powerful language for extending it (elisp is a full blown language, and in emacs you can practically redefine everything; while in vim you cannot redefine build in functions of the editor. On the downside, vimscript is relatively similar to today's dynamic languages while elisp doesn't resemble pretty much anything)  </li>
<li>more extendible  </li>
<li>excellent support for GNU tools (the bunch of them)</li>
</ul>

Personally, I prefer vim - it is small, does what it's supposed to do, and when I wish a full blown IDE I open VS. Emacs's approach of being an editor which wants to be an IDE (or should I say, an OS), but is not quite, is IMHO, outdated. In the old days having a email client, ftp client, tetris, ... whatnot in one package (emacs) made some sense ... nowadays, it doesn't anymore.  

Both are however a topic of religious discussions among the programmer and superuser community users, and in that respect, both are excellent for starting flame wars if put in contact (in the same sentence / question).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How to convert the ^M linebreak to 'normal' linebreak in a file opened in vim? (score [356218](https://stackoverflow.com/q/811193) in 2014)

#### Question
vim shows on every line ending ^M  

How I do to replace this with a 'normal' linebreak?  

#### Answer accepted (score 119)
This is the only thing that worked for me:  

<blockquote>
  :e ++ff=dos  
</blockquote>

Found it at: <a href="http://vim.wikia.com/wiki/File_format" rel="noreferrer">http://vim.wikia.com/wiki/File_format</a>  

#### Answer 2 (score 560)
<h5>Command</h1>

```vim
:%s/<Ctrl-V><Ctrl-M>/\r/g
```

<p>Where `&lt;Ctrl-V&gt;&lt;Ctrl-M&gt;` means type <kbd>Ctrl</kbd>+<kbd>V</kbd> then <kbd>Ctrl</kbd>+<kbd>M</kbd>.
<br/>
<br/></p>

<h5>Explanation</h1>

```vim
:%s
```

substitute, % = all lines   

```vim
<Ctrl-V><Ctrl-M>
```

^M characters (the Ctrl-V is a Vim way of writing the Ctrl ^ character and Ctrl-M writes the M after the regular expression, resulting to ^M special character)  

```vim
/\r/
```

with new line (`\r`)  

```vim
g
```

And do it globally (not just the first occurrence on the line).  

#### Answer 3 (score 416)
On Linux and Mac OS, the following works,  

```vim
:%s/^V^M/^V^M/g
```

where `^V^M` means type <kbd>Ctrl</kbd>+<kbd>V</kbd>, then <kbd>Ctrl</kbd>+<kbd>M</kbd>.  

<sub>Note: on Windows you probably want to use `^Q` instead of `^V`, since by default `^V` is mapped to paste text.</sub>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: Turning off auto indent when pasting text into vim (score [347468](https://stackoverflow.com/q/2514445) in 2018)

#### Question
I am making the effort to learn Vim.  

When I paste code into my document from the clipboard, I get extra spaces at the start of each new line:  

```vim
line
  line
    line
```

I know you can turn off auto indent but I can't get it to work because I have some other settings conflicting or something (which look pretty obvious in my .vimrc but don't seem to matter when I take them out).   

How do I turn off auto indenting when I paste code but still have vim auto indent when I am writing code?  Here is my `.vimrc` file:  

```vim
set expandtab  
set tabstop=2  
set shiftwidth=2  
set autoindent  
set smartindent  
set bg=dark  
set nowrap  
```

#### Answer accepted (score 1953)
<strong>Update:</strong> Better answer here: <a href="https://stackoverflow.com/a/38258720/62202">https://stackoverflow.com/a/38258720/62202</a>  

To turn off autoindent when you paste code, there's a special "paste" mode.  

Type   

```vim
:set paste
```

Then paste your code.  Note that the text in the tooltip now says `-- INSERT (paste) --`.  

After you pasted your code, turn off the paste-mode, so that auto-indenting when you type works correctly again.  

```vim
:set nopaste
```

However, I always found that cumbersome.  That's why I map `&lt;F3&gt;` such that it can switch between paste and nopaste modes <em>while editing the text!</em>  I add this to `.vimrc`  

```vim
set pastetoggle=<F3>
```

#### Answer 2 (score 256)
To avoid undesired effects while pasting, there is an option that needs to be set:  

```vim
set paste
```

A useful command to have in your .vimrc is `set pastetoggle=&lt;F10&gt;` or some other button, to easily toggle between paste and nopaste.  

#### Answer 3 (score 127)
I usually use `:r! cat` and then paste `( shift + insert )` the content, and `CTRL+D`.  

No need to enable &amp; disable, direct usage.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: How does the vim "write with sudo" trick work? (score [337504](https://stackoverflow.com/q/2600783) in 2012)

#### Question
Many of you have probably seen the command that allows you to write on a file that needs root permission, even when you forgot to open vim with sudo:  

```vim
:w !sudo tee %
```

The thing is that I don't get what is exactly happening here.  

<p>I have already figured this:
`w` is for this</p>

```vim
                                                        *:w_c* *:write_c*
:[range]w[rite] [++opt] !{cmd}
                        Execute {cmd} with [range] lines as standard input
                        (note the space in front of the '!').  {cmd} is
                        executed like with ":!{cmd}", any '!' is replaced with
                        the previous command |:!|.
```

so it passes all the lines as standard input.  

The `!sudo tee` part calls `tee` with administrator privileges.  

For all to make sense, the `%` should output the filename (as a parameter for `tee`), but I can't find references on the help for this behavior.  

<strong>tl;dr</strong> Could someone help me dissect this command?  

#### Answer accepted (score 1510)
In `:w !sudo tee %`...  

<h5>`%` means "the current file"</h2>

As <a href="https://stackoverflow.com/a/2600852/211563">eugene y pointed out</a>, `%` does indeed mean "the current file name", which is passed to `tee` so that it knows which file to overwrite.  

(In substitution commands, it's slightly different; as `:help :%` shows, it's `equal to 1,$ (the entire file)` (thanks to @Orafu for pointing out that this does not evaluate to the filename). For example, `:%s/foo/bar` means "<strong>in the current file</strong>, replace occurrences of `foo` with `bar`." If you highlight some text before typing `:s`, you'll see that the highlighted lines take the place of `%` as your substitution range.)  

<h5>`:w` isn't updating your file</h2>

One confusing part of this trick is that you might think `:w` is modifying your file, but it isn't. If you opened and modified `file1.txt`, then ran `:w file2.txt`, it would be a "save as"; `file1.txt` wouldn't be modified, but the current buffer contents would be sent to `file2.txt`.  

Instead of `file2.txt`, you can <strong>substitute a shell command to receive the buffer contents</strong>. For instance, `:w !cat` will just display the contents.  

If Vim wasn't run with sudo access, its `:w` can't modify a protected file, but if it passes the buffer contents to the shell, <strong>a command in the shell <em>can</em> be run with sudo</strong>. In this case, we use `tee`.  

<h5>Understanding tee</h2>

As for `tee`, picture the `tee` command as a T-shaped pipe in a normal bash piping situation: it directs output to specified file(s) and <strong>also sends it to standard output</strong>, which can be captured by the next piped command.   

For example, in `ps -ax | tee processes.txt | grep 'foo'`, the list of processes will be written to a text file <strong>and</strong> passed along to `grep`.  

```vim
     +-----------+    tee     +------------+
     |           |  --------  |            |
     | ps -ax    |  --------  | grep 'foo' |
     |           |     ||     |            |
     +-----------+     ||     +------------+
                       ||   
               +---------------+
               |               |
               | processes.txt |
               |               |
               +---------------+
```

(Diagram created with <a href="http://www.asciiflow.com/" rel="nofollow noreferrer">Asciiflow</a>.)  

See the <a href="http://ss64.com/bash/tee.html" rel="nofollow noreferrer">`tee` man page</a> for more info.  

<h5>Tee as a hack</h2>

In the situation your question describes, <strong>using `tee` is a hack because we're ignoring half of what it does</strong>. `sudo tee` writes to our file and also sends the buffer contents to standard output, but <strong>we ignore standard output</strong>. We don't need to pass anything to another piped command in this case; we're just using `tee` as an alternate way of writing a file and so that we can call it with `sudo`.  

<h5>Making this trick easy</h2>

You can add this to your `.vimrc` to make this trick easy-to-use: just type `:w!!`.  

```vim
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
```

The `&gt; /dev/null` part <strong>explicitly</strong> throws away the standard output, since, as I said, we don't need to pass anything to another piped command.  

#### Answer 2 (score 94)
In the executed command line, `%` stands for the <strong>current file name</strong>. This is documented in <a href="http://vimhelp.appspot.com/cmdline.txt.html#cmdline-special" rel="noreferrer">`:help cmdline-special`</a>:  

```vim
In Ex commands, at places where a file name can be used, the following
characters have a special meaning.
        %       Is replaced with the current file name.
```

As you've already found out, `:w !cmd` pipes the contents of the current buffer to another command. What <a href="https://en.wikipedia.org/wiki/Tee_(command)" rel="noreferrer">`tee`</a> does is copy standard input to one or more files, and also to standard output. Therefore, `:w !sudo tee % &gt; /dev/null` effectively writes the contents of the current buffer to the current file <strong>while being root</strong>. Another command that can be used for this is <a href="https://en.wikipedia.org/wiki/Dd_(Unix)" rel="noreferrer">`dd`</a>:  

```vim
:w !sudo dd of=% > /dev/null
```

As a shortcut, you can add this mapping to your `.vimrc`:  

```vim
" Force saving files that require root permission 
cnoremap w!! w !sudo tee > /dev/null %
```

With the above you can type `:w!!&lt;Enter&gt;` to save the file as root.  

#### Answer 3 (score 18)
This also works well:  

```vim
:w !sudo sh -c "cat > %"
```

This is inspired by the comment of @Nathan Long.   

<strong>NOTICE</strong>:  

`"` must be used instead of `'` because we want `%` to be expanded before passing to shell.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: Vim delete blank lines (score [332736](https://stackoverflow.com/q/706076) in 2010)

#### Question
What command can I run to remove blank lines in Vim?  

#### Answer accepted (score 1186)
```vim
:g/^$/d
```

`:g` will execute a command on lines which match a regex. The regex is 'blank line' and the command is `:d` (delete)  

#### Answer 2 (score 176)
Found it, it's:  

```vim
g/^\s*$/d
```

Source: <a href="http://vim.wikia.com/wiki/Power_of_g" rel="nofollow noreferrer">Power of <em>g</em> at vim wikia</a>  

<blockquote>
  Brief explanation of `:g`  

```vim
:[range]g/pattern/cmd
```
  
  This acts on the specified <em>[range]</em> (default whole file), by executing the Ex command <em>cmd</em> for each line matching <em>pattern</em> (an Ex command is one starting with a colon such as `:d` for delete). Before executing <em>cmd</em>, "`.`" is set to the current line.   
</blockquote>

#### Answer 3 (score 50)
```vim
:v/./d
```

or  

```vim
:g/^$/d
```

or      

```vim
:%!cat -s
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How do I insert text at beginning of a multi-line selection in vi/Vim? (score [322539](https://stackoverflow.com/q/253380) in 2018)

#### Question
In <a href="http://en.wikipedia.org/wiki/Vim_%28text_editor%29" rel="noreferrer">Vim</a>, how would I go about inserting characters at the beginning of each line in a selection?  

For instance, let's say I want to comment out a block of code by prepending `//` at the beginning of each line (assuming my language's comment system doesn't allow block commenting like `/* */`).  How would I do this?  

#### Answer accepted (score 696)
<ul>
<li>Press <kbd>Esc</kbd> to enter 'command mode'</li>
<li>Use <kbd>Ctrl</kbd>+<kbd>V</kbd> to enter visual block mode</li>
<li>Move <kbd>Up</kbd>/<kbd>Down</kbd>to select the columns of text in the lines you want to
comment.</li>
<li>Then hit <kbd>Shift</kbd>+<kbd>i</kbd> and type the text you want to insert.</li>
<li>Then hit <kbd>Esc</kbd>, wait 1 second and the inserted text will appear on every line.</li>
</ul>

For further information and reading, check out <a href="https://vim.wikia.com/wiki/Inserting_text_in_multiple_lines" rel="noreferrer">this related article on the vim wiki</a>.  

#### Answer 2 (score 177)
This replaces the beginning of <em>each line</em> with "//":  

```vim
:%s!^!//!
```

This replaces the beginning of <em>each selected line</em> (use visual mode to select) with "//":  

```vim
:'<,'>s!^!//!
```

<strong>Note</strong> that `gv` (in normal mode) restores the last visual selection, this comes in handy from time to time.  

#### Answer 3 (score 81)
The general pattern for search and replace is:  

```vim
:s/search/replace/
```

<em>Replaces the first occurrence of 'search' with 'replace' for current line</em>  

```vim
:s/search/replace/g
```

<em>Replaces all occurrences of 'search' with 'replace' for current line, 'g' is short for 'global'</em>  

This command will replace each occurrence of 'search' with 'replace' for the current line only.  The % is used to search over the whole file.  To confirm each replacement interactively append a 'c' for confirm:  

```vim
:%s/search/replace/c
```

<em>Interactive confirm replacing 'search' with 'replace' for the entire file</em>  

Instead of the % character you can use a line number range <strong>(note that the '^' character is a special search character for the start of line)</strong>:  

```vim
:14,20s/^/#/
```

<em>Inserts a '#' character at the start of lines 14-20</em>  

If you want to use another comment character (like //) then change your command delimiter:  

```vim
:14,20s!^!//!
```

<em>Inserts a '//' character sequence at the start of lines 14-20</em>  

Or you can always just escape the // characters like:  

```vim
:14,20s/^/\/\//
```

<em>Inserts a '//' character sequence at the start of lines 14-20</em>  

If you are not seeing line numbers in your editor, simply type the following  

```vim
:set nu
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: Copy and paste content from one file to another file in vi (score [314454](https://stackoverflow.com/q/4620672) in 2017)

#### Question
I am working with two files, I need to copy a few lines from one file and paste into another file. I know how to copy (yy) and paste(p) in the same file. But that doesn't work for different files, how is this done??  

Also, is there a way to cut-paste? I have tried googling, but most of the resources only talk about copy-paste.  

#### Answer accepted (score 198)
Since you already know how to cut/yank text, here are a few ideas for pasting it back into another file:  

<ul>
<li>Edit the first file, yanking the text you want. Then open your second file from within vi (`:e /path/to/other/file`) and paste it</li>
<li><p>Open both files together in a split window and navigate between them using <kbd>Ctrl</kbd> + <kbd>w</kbd>, <kbd>Up</kbd>/<kbd>Down</kbd> either by:</p>

<ul>
<li>`vi -o /path/to/file1 /path/to/file2`</li>
<li>From within the first file, <kbd>Ctrl</kbd> + <kbd>w</kbd>, <kbd>s</kbd></li>
</ul></li>
</ul>

#### Answer 2 (score 47)
If you are using VIM in Windows, you can get access to the clipboard (MS copy/paste) using:  

<kbd>"</kbd><kbd>*</kbd><kbd>d</kbd><kbd>d</kbd> -- cut a line (or 3dd to cut 3 lines)  

<kbd>"</kbd><kbd>*</kbd><kbd>y</kbd><kbd>y</kbd> -- copy a line (or 3yy to copy 3 lines)  

<kbd>"</kbd><kbd>*</kbd><kbd>p</kbd>  -- paste line(s) on line after the cursor  

<kbd>"</kbd><kbd>*</kbd><kbd>P</kbd>  -- paste line(s) on line before the cursor  

The lets you paste between separate VIM windows or between VIM and PC applications (notepad, word, etc).  

#### Answer 3 (score 38)
Use the variations of `d` like `dd` to cut.  

To write a range of lines to another file you can use:  

```vim
:<n>,<m> w filename
```

Where `&lt;n&gt;` and `&lt;m&gt;` are numbers (or symbols) that designate a range of lines.  

For using the desktop clipboard, take a look at the `+g` commands.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: What is the <leader> in a .vimrc file? (score [308014](https://stackoverflow.com/q/1764263) in 2018)

#### Question
I see `&lt;leader&gt;` in many `.vimrc` files, and I am wondering what does it mean? What is it used for? Just a general overview of the purpose and usage would be great.  

#### Answer accepted (score 896)
The `&lt;Leader&gt;` key is mapped to <kbd>\</kbd> by default.  So if you have a map of `&lt;Leader&gt;t`, you can execute it by default with <kbd>\</kbd>+<kbd>t</kbd>.  For more detail or re-assigning it using the `mapleader` variable, see  

:help leader  

<pre>
To define a mapping which uses the "mapleader" variable, the special string
"&lt;Leader&gt;" can be used.  It is replaced with the string value of "mapleader".
If "mapleader" is not set or empty, a backslash is used instead.  
Example:
    :map &lt;Leader&gt;A  oanother line &lt;Esc&gt;
Works like:
    :map \A  oanother line &lt;Esc&gt;
But after:
    :let mapleader = ","
It works like:
    :map ,A  oanother line &lt;Esc&gt;

Note that the value of "mapleader" is used at the moment the mapping is
defined.  Changing "mapleader" after that has no effect for already defined
mappings.


</pre>

#### Answer 2 (score 240)
Be aware that when you do press your `&lt;leader&gt;` key <strong>you have only 1000ms</strong> (by default) <strong>to enter the command</strong> following it.  

This is exacerbated because there is <em>no</em> visual feedback (by default) that you have pressed your `&lt;leader&gt;` key and vim is awaiting the command; and so there is also no visual way to know when this time out has happened.  

If you add `set showcmd` to your `vimrc` then you will see your `&lt;leader&gt;` key appear in the bottom right hand corner of vim (to the left of the cursor location) and perhaps more importantly you will see it <em>disappear</em> when the time out happens.  

The length of the timeout can also be set in your `vimrc`, see <a href="http://vimdoc.sourceforge.net/htmldoc/options.html#%27timeoutlen%27">`:help timeoutlen`</a> for more information.  

#### Answer 3 (score 108)
The "Leader key" is a way of extending the power of VIM's shortcuts by using sequences of keys to perform a command. The default leader key is backslash. Therefore, if you have a map of &lt;Leader>Q, you can perform that action by typing \Q.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: Replace tabs with spaces in vim (score [306849](https://stackoverflow.com/q/426963) in 2019)

#### Question
I would like to convert tab to spaces in gVim. I added the following line to my `_vimrc`:  

```vim
set tabstop=2
```

It works to stop at two spaces but it still looks like one tab key is inserted (I tried to use the h key to count spaces afterwards).  

I'm not sure what should I do to make gVim convert tabs to spaces?  

#### Answer accepted (score 361)
IIRC, something like:  

```vim
set tabstop=2 shiftwidth=2 expandtab
```

should do the trick. If you already have tabs, then follow it up with a nice global RE to replace them with double spaces.  

#### Answer 2 (score 795)
Once you've got expandtab on as per the other answers, the extremely convenient way to convert existing files according to your new settings is:  

```vim
:retab
```

It will work on the current buffer.  

#### Answer 3 (score 103)
Try  

```vim
set expandtab
```

for soft tabs.  

To fix pre-existing tabs:  

```vim
:%s/\t/  /g
```

I used two spaces since you already set your tabstop to 2 spaces.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: Find and replace strings in vim on multiple lines (score [296903](https://stackoverflow.com/q/19994922) in 2013)

#### Question
I can do `:%s/&lt;search_string&gt;/&lt;replace_string&gt;/g` for replacing a string across a file, or `:s/&lt;search_string&gt;/&lt;replace_string&gt;/` to replace in current line.  

How can I select and replace words from selective lines in vim?  

Example: replace text from lines `6-10`, `14-18` but not from `11-13`.  

#### Answer accepted (score 219)
The `:&amp;&amp;` command repeats the last substitution with the same flags. You can supply the additional range(s) to it (and concatenate as many as you like):  

```vim
:6,10s/<search_string>/<replace_string>/g | 14,18&&
```

If you have <strong>many ranges</strong> though, I'd rather use a loop:  

```vim
:for range in split('6,10 14,18')| exe range 's/<search_string>/<replace_string>/g' | endfor
```

#### Answer 2 (score 308)
Replace All:  

```vim
:%s/foo/bar/g
```

Find each occurrence of 'foo' (in all lines), and replace it with 'bar'.  

For specific lines:  

```vim
:6,10s/foo/bar/g
```

Change each 'foo' to 'bar' for all lines from line 6 to line 10 inclusive.  

#### Answer 3 (score 48)
As a side note, instead of having to type in the line numbers, just highlight the lines where you want to find/replace in one of the visual modes:  

<ul>
<li><strong>`VISUAL`</strong> mode (<kbd>V</kbd>)</li>
<li><strong>`VISUAL BLOCK`</strong> mode (<kbd>Ctrl</kbd>+<kbd>V</kbd>)</li>
<li><strong>`VISUAL LINE`</strong> mode (<kbd>Shift</kbd>+<kbd>V</kbd>, works best in your case)</li>
</ul>

Once you selected the lines to replace, type your command:  

```vim
:s/<search_string>/<replace_string>/g
```

You'll note that the range `'&lt;,'&gt;` will be inserted automatically for you:  

```vim
:'<,'>s/<search_string>/<replace_string>/g
```

Here `'&lt;` simply means <em>first highlighted line</em>, and `'&gt;` means <em>last highlighted line</em>.  

Note that the behaviour might be unexpected when in <strong>`NORMAL`</strong> mode: `'&lt;` and `'&gt;` point to the start and end of the last highlight done in one of the <strong>`VISUAL`</strong> modes. Instead, in <strong>`NORMAL`</strong> mode, the special line number `.` can be used, which simply means <em>current line</em>. Hence, you can find/replace only on the current line like this:  

```vim
:.s/<search_string>/<replace_string>/g
```

Another thing to note is that inserting a second `:` between the range and the find/replace command does no harm, in other words, these commands will still work:  

```vim
:'<,'>:s/<search_string>/<replace_string>/g
:.:s/<search_string>/<replace_string>/g
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: "Find next" in vim (score [295769](https://stackoverflow.com/q/6607630) in )

#### Question
To search forward in vim for `cake`, I'd type `/cake`, but the cursor jumps to the first match when I press return. <strong>Is there a vim command analogous to "find next"?</strong>  

#### Answer accepted (score 815)
It is <kbd>n</kbd> for next and <kbd>N</kbd> for previous.  

And if you use reverse search with `?` (e.g `?cake`) instead of `/`, it is the other way round.  

If it is installed on your system, you should try to run `vimtutor` command from your terminal, which will start a tutorial of the basic Vim commands.  

<a href="https://stackoverflow.com/a/6607664">Rob Wells advice</a> about `*` and `#` is also very pertinent.  

#### Answer 2 (score 203)
The most useful shortcut in vim, IMHO, is the <kbd>*</kbd> key.  

Put the cursor on a word and hit the <kbd>*</kbd> key and you will jump to the next instance of that word.  

The <kbd>#</kbd> key does the same but jumps to the previous instance of the word.  

Truly a time saver.  

#### Answer 3 (score 72)
When I was beginning I needed to <a href="https://www.youtube.com/watch?v=J1_CfIb-3X4#t=0m46s">watch a demo</a>  

<h5>How to search in VIM</h3>

<ol>
<li><em>type</em> `/` </li>
<li><em>type search term</em> e.g. "var"</li>
<li><em>press</em> <kbd>enter</kbd></li>
<li>for <strong>next</strong> instance press <kbd>n</kbd> (for <strong>previous</strong> <kbd>N</kbd>)</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: Autocompletion in Vim (score [293759](https://stackoverflow.com/q/5169638) in 2012)

#### Question
After a long "training", I have finally switched to Vim; but I have some trouble with the autocompletion. How can I have a code suggestion while I'm typing?  

I usually develop PHP, Ruby, HTML, C and CSS.  

#### Answer accepted (score 134)
You can use a plugin like <a href="http://www.vim.org/scripts/script.php?script_id=1879" rel="noreferrer">AutoComplPop</a> to get automatic code completion as you type.  

2015 Edit: I personally use <a href="https://github.com/Valloric/YouCompleteMe" rel="noreferrer">YouCompleteMe</a> now.  

#### Answer 2 (score 399)
Use <kbd>Ctrl</kbd>-<kbd>N</kbd> to get a list of word suggestions while in insert mode. Type `:help i_CTRL-N` to see Vim's documentation on this functionality.  

<a href="https://web.archive.org/web/20120630181124/http://www.mohdshakir.net/2007/12/27/enable-vim-code-python-auto-complete" rel="noreferrer">Here</a> is an example of importing the Python dictionary into Vim.  

#### Answer 3 (score 9)
If you are using VIM version 8+, just type `Ctrl + n` or `Ctrl + p`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: How do I do redo (i.e. "undo undo") in Vim? (score [290699](https://stackoverflow.com/q/1555779) in 2013)

#### Question
In Vim, I did too much undo. How do I undo this (that is, redo)?  

#### Answer accepted (score 870)
<kbd>Ctrl</kbd>+<kbd>r</kbd>  

#### Answer 2 (score 129)
Also check out `:undolist`, which offers multiple paths through the undo history. This is useful if you accidentally type something after undoing too much.  

#### Answer 3 (score 52)
Strange nobody mentioned `:earlier`/`:later`. To redo everything you just need to do  

```vim
later 9999999d
```

(assuming that you first edited the file at most 9999999 days ago), or, if you remember the difference between current undo state and needed one, use `Nh`, `Nm` or `Ns` for hours, minutes and seconds respectively. + `:later N&lt;CR&gt;` &lt;=> `Ng+` and `:later Nf` for file writes.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: How can I quickly delete a line in VIM starting at the cursor position? (score [289880](https://stackoverflow.com/q/8296473) in )

#### Question
I want to be able to delete the remainder of the line I'm on starting at the cursor's position in VIM. Is there an easy command to do this?  

To help illustrate, this is before the command.  

```vim
The quick brown dog jumps over the lazy fox.
     ^
     |----- Cursor is here.
```

This is after the command  

```vim
The q
     ^
     |----- Cursor is here.
```

#### Answer accepted (score 412)
(Edited to include commenter's good additions:)  

`D` or its equivalent `d$` will delete the rest of the line and leave you in command mode. `C` or `c$` will delete the rest of the line and put you in insert mode, and new text will be appended to the line.  

This is part of `vitutor` and `vimtutor`, excellent "reads" for vim beginners.  

#### Answer 2 (score 40)
Use <kbd>D</kbd>. See <a href="http://vimdoc.sourceforge.net/htmldoc/change.html#D">docs</a> for further information.  

#### Answer 3 (score 19)
You might also be interested in <kbd>C</kbd>, it will also delete the end of line like <kbd>D</kbd>, but additionally it will put you in Insert mode at the cursor location.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: What is vim recording and how can it be disabled? (score [277475](https://stackoverflow.com/q/1527784) in 2016)

#### Question
I keep seeing the `recording` message at the bottom of my gvim 7.2 window.   

What is it and how do I turn it off?  

#### Answer accepted (score 1001)
<p>You start recording by <kbd>q</kbd><kbd>&lt;letter&gt;</kbd>
and you can end it by typing <kbd>q</kbd> again.</p>

Recording is a really useful feature of Vim.  

<p>It records everything you type. You can then replay it simply by typing <kbd>@</kbd><kbd>&lt;letter&gt;</kbd>.
Record search, movement, replacement...</p>

One of the best feature of Vim IMHO.  

#### Answer 2 (score 100)
Type <kbd>:h recording</kbd> to learn more.  

<pre>                           <b>*q*</b> <b>*recording*</b>
q{0-9a-zA-Z"}           Record typed characters into <a href="http://vimdoc.sourceforge.net/htmldoc/sponsor.html#register" rel="noreferrer">register</a> {0-9a-zA-Z"}
                        (uppercase to append).  The '<a href="http://vimdoc.sourceforge.net/htmldoc/repeat.html#q" rel="noreferrer">q</a>' command is disabled
                        while executing a <a href="http://vimdoc.sourceforge.net/htmldoc/sponsor.html#register" rel="noreferrer">register</a>, and <a href="http://vimdoc.sourceforge.net/htmldoc/motion.html#it" rel="noreferrer">it</a> doesn't work inside
                        a <a href="http://vimdoc.sourceforge.net/htmldoc/map.html#mapping" rel="noreferrer">mapping</a>.  {Vi: no recording}

<a href="http://vimdoc.sourceforge.net/htmldoc/repeat.html#q" rel="noreferrer">q</a>                       Stops <a href="http://vimdoc.sourceforge.net/htmldoc/repeat.html#recording" rel="noreferrer">recording</a>.  (Implementation note: The '<a href="http://vimdoc.sourceforge.net/htmldoc/repeat.html#q" rel="noreferrer">q</a>' that
                        stops <a href="http://vimdoc.sourceforge.net/htmldoc/repeat.html#recording" rel="noreferrer">recording</a> is not stored in the <a href="http://vimdoc.sourceforge.net/htmldoc/sponsor.html#register" rel="noreferrer">register</a>, unless
                        <a href="http://vimdoc.sourceforge.net/htmldoc/motion.html#it" rel="noreferrer">it</a> was the result of a <a href="http://vimdoc.sourceforge.net/htmldoc/map.html#mapping" rel="noreferrer">mapping</a>)  {Vi: no recording}


                                                        *@*
@{0-9a-z".=*}           Execute the contents of <a href="http://vimdoc.sourceforge.net/htmldoc/sponsor.html#register" rel="noreferrer">register</a> {0-9a-z".=*} <a href="http://vimdoc.sourceforge.net/htmldoc/intro.html#[count]" rel="noreferrer">[count]</a>
                        times.  Note that <a href="http://vimdoc.sourceforge.net/htmldoc/sponsor.html#register" rel="noreferrer">register</a> '<a href="http://vimdoc.sourceforge.net/htmldoc/motion.html#%" rel="noreferrer">%</a>' (name of the current
                        file) and '<a href="http://vimdoc.sourceforge.net/htmldoc/pattern.html##" rel="noreferrer">#</a>' (name of the alternate file) cannot be
                        used.  For "<a href="http://vimdoc.sourceforge.net/htmldoc/change.html#@=" rel="noreferrer">@=</a>" you are prompted to enter an
                        <a href="http://vimdoc.sourceforge.net/htmldoc/eval.html#expression" rel="noreferrer">expression</a>.  The result of the <a href="http://vimdoc.sourceforge.net/htmldoc/eval.html#expression" rel="noreferrer">expression</a> is then
                        executed.  See also |<a href="http://vimdoc.sourceforge.net/htmldoc/repeat.html#@:" rel="noreferrer">@:</a>|.  {Vi: only named registers}
</pre>

#### Answer 3 (score 36)
It sounds like you have macro recording turned on.  To shut it off, press `q`.  

Refer to "<a href="http://www.vim.org/htmldoc/repeat.html" rel="noreferrer">:help recording</a>" for further information.  

Related links:  

<ul>
<li><a href="http://blog.smr.co.in/linux/vim-recording/" rel="noreferrer">smr's blog: vim :: recording</a></li>
<li><a href="http://www.thegeekstuff.com/2009/01/vi-and-vim-macro-tutorial-how-to-record-and-play/" rel="noreferrer">Vi and Vim Macro Tutorial: How To Record and Play</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: How to get the list of all installed color schemes in Vim? (score [275800](https://stackoverflow.com/q/7331940) in 2013)

#### Question
Is there a way to get a list of all installed color schemes in Vim? That would make very easy to select one without looking at the `.vim` directory.  

#### Answer accepted (score 576)
Type   

`:colorscheme` then <kbd>Space</kbd> followed by <kbd>TAB</kbd>.  

or as Peter said,  

`:colorscheme` then <kbd>Space</kbd> followed by <kbd>CTRL</kbd><kbd>d</kbd>  

The short version of the command is `:colo` so you can use it in the two previous commands, instead of using the "long form".  

If you want to find and preview more themes, there are various websites like <a href="http://vimcolors.com/" rel="noreferrer">Vim colors</a>  

#### Answer 2 (score 48)
You can see the list of color schemes under `/usr/share/vim/vimNN/colors` (with `NN` being the version, e.g. `vim74` for vim 7.4).  

This is explained <a href="http://www.linux.com/learn/tutorials/540255-weekend-project-take-control-of-vims-color-scheme" rel="noreferrer">here</a>.  

On the linux servers I use via ssh, <kbd>TAB</kbd> prints `^I` and <kbd>CTRL</kbd><kbd>d</kbd> prints `^D`.  

#### Answer 3 (score 34)
Just for convenient reference as I see that there are a lot of people searching for this topic and are too laz... sorry, busy, to check themselves (including me). Here a list of the default set of colour schemes for Vim 7.4:   

```vim
blue.vim
darkblue.vim,
delek.vim
desert.vim
elflord.vim
evening.vim
industry.vim                                                                                                                                                 
koehler.vim                                                                                                                                                  
morning.vim                                                                                                                                                  
murphy.vim                                                                                                                                                   
pablo.vim                                                                                                                                                    
peachpuff.vim                                                                                                                                                
ron.vim                                                                                                                                                      
shine.vim                                                                                                                                                    
slate.vim                                                                                                                                                    
torte.vim                                                                                                                                                    
zellner.vim 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: What does ^M character mean in Vim? (score [270803](https://stackoverflow.com/q/5843495) in 2013)

#### Question
I keep getting `^M` character in my vimrc and it breaks my configuration.   

#### Answer accepted (score 522)
Unix uses 0xA for a newline character. Windows uses a combination of two characters: 0xD 0xA. 0xD is the carriage return character. `^M` happens to be the way vim displays 0xD (0x0D = 13, M is the 13th letter in the English alphabet).  

You can remove all the `^M` characters by running the following:   

```vim
:%s/^M//g
```

Where `^M` is entered by holding down <kbd>Ctrl</kbd> and typing <kbd>v</kbd> followed by <kbd>m</kbd>, and then releasing <kbd>Ctrl</kbd>. This is sometimes abbreviated as `^V^M`, but note that you must enter it as described in the previous sentence, rather than typing it out literally.  

This expression will replace all occurrences of `^M` with the empty string (i.e. nothing). I use this to get rid of `^M` in files copied from Windows to Unix (Solaris, Linux, OSX).  

#### Answer 2 (score 129)
```vim
:%s/\r//g 
```

worked for me today.  But my situation may have been slightly different.  

#### Answer 3 (score 62)
To translate the new line instead of removing it:  

```vim
:%s/\r/\r/g
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How do I fix the indentation of an entire file in Vi? (score [266638](https://stackoverflow.com/q/506075) in 2012)

#### Question
In Vim, what is the command to correct the indentation of all the lines?  

Often times I'll copy and paste code into a remote terminal and have the whole thing messed up.  I want to fix this in one fell swoop.  

#### Answer accepted (score 1169)
`=`, the indent command can take motions. So, `gg` to get the start of the file, `=` to indent, `G` to the end of the file, `gg=G`.  

#### Answer 2 (score 121)
Before pasting into the terminal, try `:set paste` (and then `:set nopaste` after you're done). This will turn off the auto-indent, line-wrap, etc. features that are messing up your paste.  

edit: Also, I should point out that a much better result than = indenting can usually be obtained by using an external program. For example, I run `:%!perltidy` all the time. astyle, cindent, etc. can also be used. And, of course, you can map those to a key stroke — and map different ones to the same keystroke depending on file type  

#### Answer 3 (score 29)
If you want to reindent the block you're in without having to type any chords, you can do:  

```vim
[[=]]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: Vim and Ctags tips and tricks (score [261799](https://stackoverflow.com/q/563616) in 2016)

#### Question
I have just installed <a href="http://en.wikipedia.org/wiki/Ctags" rel="noreferrer">Ctags</a> (to help with C++ development) with my Vim (or rather gVim), and would like to find out your favorite commands, macros, shortcuts, tips that go along with it...  

Share your best arsenal. What other Vim add-ons you would recommend for C++ on Vim development?  

<strong>EDIT</strong> What other add-on you would use in conjunction with Ctags?  

<strong>EDIT2</strong> What version of gVim you use with tags? Does it make a difference?   

<strong>EDIT3</strong> How do you enhance your programming experience for both big and small projects?  

#### Answer accepted (score 394)
<p><kbd>Ctrl</kbd>+<kbd>]</kbd> - go to definition<br>
<kbd>Ctrl</kbd>+<kbd>T</kbd> - Jump back from the definition.<br>
<kbd>Ctrl</kbd>+<kbd>W</kbd> <kbd>Ctrl</kbd>+<kbd>]</kbd> - Open the definition in a horizontal split  </p>

<p>Add these lines in vimrc<br>
    `map &lt;C-\&gt; :tab split&lt;CR&gt;:exec("tag ".expand("&lt;cword&gt;"))&lt;CR&gt;`<br>
    `map &lt;A-]&gt; :vsp &lt;CR&gt;:exec("tag ".expand("&lt;cword&gt;"))&lt;CR&gt;`  </p>

<p><kbd>Ctrl</kbd>+<kbd>\</kbd> - Open the definition in a new tab<br>
<kbd>Alt</kbd>+<kbd>]</kbd> - Open the definition in a vertical split</p>

After the tags are generated. You can use the following keys to tag into and tag out of functions:  

<p><kbd>Ctrl</kbd>+`Left MouseClick` - Go to definition<br>
<kbd>Ctrl</kbd>+`Right MouseClick` - Jump back from definition </p>

#### Answer 2 (score 176)
One line that always goes in my .vimrc:  

```vim
set tags=./tags;/
```

This will look in the current directory for "tags", and work up the tree towards root until one is found.  IOW, you can be anywhere in your source tree instead of just the root of it.  

#### Answer 3 (score 45)
<p>Another useful plugin for C development is <a href="http://cscope.sourceforge.net/" rel="noreferrer">cscope</a>
Just as Ctags lets you jump to definitions, Cscope jumps to the <em>calling</em> functions.</p>

If you have cscope in your ~/bin/ directory, add the following to your .vimrc and use g^] to go to the calling function (see :help cscope).  

```vim
if has("cscope")
    set csprg=~/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif
```

Almost forgot... Just as ctags - you have to generate (and periodically update) the database. I use the following script  

```vim
select_files > cscope.files
ctags -L cscope.files
ctags -e -L cscope.files
cscope -ub -i cscope.files
```

Where 'select_files' is another script that extracts the list of C and header files from the Makefile. This way I index only the files actually used by the project.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: Setting the Vim background colors (score [255989](https://stackoverflow.com/q/1117526) in 2019)

#### Question
When I try to change the background colors in `.vimrc` or directly in Vim using the command:   

```vim
set background=dark
```

... it doesn't affect my background at all. Neither does the `light` option. However, it looks okay when I run gvim.  

Is there a way to change the background in Mim without changing my Konsole settings?    

<strong>EDIT</strong> Okay, there is a difference between guifg/guibg and ctermfg/ctermbg. While the GUI accepts lots of different color combinations, cterm allows only few standard ones.  

#### Answer accepted (score 127)
As vim's own help on `set background` says, "Setting this option does not change the background color, it tells Vim what the background color looks like. For changing the background color, see |:hi-normal|."  

For example  

```vim
:highlight Normal ctermfg=grey ctermbg=darkblue
```

will write in white on blue on your color terminal.  

#### Answer 2 (score 24)
In a terminal emulator like konsole or gnome-terminal, you should to set a 256 color setting for vim.  

```vim
:set  t_Co=256
```

After that you can to change your background.  

#### Answer 3 (score 15)
Try adding  

```vim
set background=dark
```

to your `.gvimrc` too. This work well for me.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: How do I run a terminal inside of Vim? (score [252923](https://stackoverflow.com/q/1236563) in 2016)

#### Question
I am used to Emacs, but I am trying out Vim to see which one I like better.   

One thing that I like about Emacs is the ability to run a terminal inside Emacs. Is this possible inside of Vim? I know that you can execute commands from Vim, but I would like to be able to run a terminal inside of a tab.  

#### Answer accepted (score 116)
I would definitely recommend <a href="http://www.gnu.org/software/screen/" rel="noreferrer">`screen`</a> for something like this. Vim is a text editor, not a shell.  

I would use <kbd>Ctrl+A</kbd><kbd>S</kbd> to split the current window horizontally, or in Ubuntu's screen and other patched versions, you can use <kbd>Ctrl+A</kbd><kbd>|</kbd>(pipe) to split vertically. Then use <kbd>Ctrl+A</kbd><kbd>Tab</kbd> (or equivalently on some systems, <kbd>Ctrl+A</kbd><kbd>Ctrl+I</kbd> which may be easier to type) to switch between the windows. There are other commands to change the size and arrangement of the windows.  

Or a less advanced use of `screen` is just to open multiple full-screen windows and toggle between them. This is what I normally do, I only use the split screen feature occasionally.  

The <a href="https://stackoverflow.com/questions/70614/gnu-screen-survival-guide">GNU Screen Survival Guide</a> question has a number of good tips if you're unfamiliar with its use.  

#### Answer 2 (score 231)
<strong>Outdated from August 2011</strong>  

Check out <a href="http://www.vim.org/scripts/script.php?script_id=2771" rel="noreferrer">Conque Shell</a> (also on <a href="https://github.com/vim-scripts/Conque-Shell" rel="noreferrer">GitHub</a>).  Lets you run any interactive program inside vim, not just a shell.  

#### Answer 3 (score 193)
I'm not sure exactly what you're trying to achieve (I've never used Emacs), but you can run commands in Vim by typing:  

```vim
:! somecommand [ENTER]
```

And if you want to type in several commands, or play around in a shell for a while, you can always use:  

```vim
:! bash (or your favourite shell) [ENTER]
```

Once the command or shell terminates, you'll be given the option to press <kbd>Enter</kbd> to return to your editor window  

Vim is intentionally lightweight and lacking in the ability to do non-editorish type things, just as running a full-blown shell inside a Vim pane/tab, but as mentioned above there are third-party addons such as vim-shell that allow you to do that sort of thing.  

Typically if I want to switch between Vim and my shell (Bash), I just hit <kbd>CTRL</kbd>+<kbd>Z</kbd> to pause the Vim process, play around in my shell, then type 'fg' when I want to go back to Vim - keeping my editor and my shell nice and separate.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How do I use vim registers? (score [251044](https://stackoverflow.com/q/1497958) in 2016)

#### Question
I only know of one instance using registers is via <kbd>Ctrl</kbd><kbd>R</kbd><kbd>*</kbd> whereby I paste text from a clipboard.   

What are other uses of registers? How to use them?   

Everything you know about VI registers (let's focus on vi 7.2) -- share with us.  

#### Answer accepted (score 1130)
Registers in Vim let you run actions or commands on text stored within them.  To access a register, you type `"a` before a command, where `a` is the name of a register.  If you want to copy the current line into register `k`, you can type  

<blockquote>
  "kyy  
</blockquote>

Or you can <em>append</em> to a register by using a capital letter  

<blockquote>
  "Kyy  
</blockquote>

You can then move through the document and paste it elsewhere using  

<blockquote>
  "kp  
</blockquote>

To paste from system clipboard on Linux  

<blockquote>
  "+p  
</blockquote>

To paste from system clipboard on Windows (or from "mouse highlight" clipboard on Linux)  

<blockquote>
  "*p  
</blockquote>

To access all currently defined registers type  

<blockquote>
  :reg  
</blockquote>

#### Answer 2 (score 748)
I was pleased when I discovered the `0` register. If you yank text without assigning it to a particular register, then it will be assigned to the `0` register, as well as being saved in the default `"` register. The difference between the `0` and `"` registers is that `0` is only populated with yanked text, whereas the default register is also populated with text deleted using `d`/`D`/`x`/`X`/`c`/`C`/`s`/`S` commands.  

I find this useful when I want to copy some text, delete something and replace it with the copied text. The following steps illustrate an example:  

<ul>
<li>Yank the text you want to copy with `y[motion]` - this text is saved in `"` and `0` registers</li>
<li>Delete the text you want to replace with `d[motion]` - this text is saved in `"` register</li>
<li>Paste the yanked text with `"0p`</li>
</ul>

where `"` is the command to use a register for the next command.   

On the final step, if you were to paste from the default register (with `p`), it would use the text that you had just deleted (probably not what you intended).  

Note that `p` or `P` pastes from the default register. The longhand equivalent would be `""p` (or `""P`) and `"0` holds the last yank, `"1`holds the last delete or change.  

For more info see <a href="http://www.vim.org/htmldoc/change.html#registers" rel="noreferrer">`:help registers`</a>.  

#### Answer 3 (score 318)
One of my favorite parts about registers is using them as macros!  

Let's say you are dealing with a tab-delimited value file as such:  

```vim
ID  Df  %Dev    Lambda
1   0   0.000000    0.313682
2   1   0.023113    0.304332
3   1   0.044869    0.295261
4   1   0.065347    0.286460
5   1   0.084623    0.277922
6   1   0.102767    0.269638
7   1   0.119845    0.261601
```

Now you decide that you need to add a percentage sign at the end of the %Dev field (starting from 2nd line). We'll make a simple macro in the (arbitrarily selected) `m` register as follows:  

<ol>
<li><p>Press: `qm`: To start recording macro under `m` register.</p></li>
<li><p>`EE`: Go to the end of the 3rd column.</p></li>
<li><p>`a`: Insert mode to append to the end of this column.</p></li>
<li><p>`%`: Type the percent sign we want to add.</p></li>
<li><p>`&lt;ESC&gt;`: Get back into command mode.</p></li>
<li><p>`j0`: Go to beginning of next line. </p></li>
<li><p>`q`: Stop recording macro</p></li>
</ol>

We can now just type `@m` to run this macro on the current line. Furthermore, we can type `@@` to repeat, or `100@m` to do this 100 times! Life's looking pretty good.  

At this point you should be saying, "<strong>BUT WAIT, WHAT THE HECK DOES THIS HAVE TO DO WITH REGISTERS</strong>?"  

Excellent point. Let's investigate what is in the contents of the `m` register by typing `"mp`. We then get the following:  

```vim
EEa%<ESC>j0
```

At first this looks like you accidentally opened a binary file in notepad, but upon second glance, <strong>it's the exact sequence  of characters in our macro!</strong>  

You are a curious person, so let's do something interesting and edit this line of text to insert a `!` instead of boring old `%`.   

```vim
EEa!<ESC>j0
```

Then let's yank this into the `n` register by typing `B"nyE`. Then, just for kicks, let's run the `n` macro on a line of our data using `@n`....  

<strong>OMG, IT ADDED A `!`</strong>  

Essentially, running a macro is like pressing the exact sequence of keys in that macro's register. If that isn't a cool register trick, I'll eat my hat.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: What is in your .vimrc? (score [249413](https://stackoverflow.com/q/164847) in 2017)

#### Question
Vi and Vim allow for really awesome customization, typically stored inside a `.vimrc` file. Typical features for a programmer would be syntax highlighting, smart indenting and so on.  

<strong>What other tricks for productive programming have you got, hidden in your .vimrc?</strong>  

I am mostly interested in refactorings, auto classes and similar productivity macros, especially for C#.  

#### Answer 2 (score 104)
You asked for it :-)  

```vim
"{{{Auto Commands

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

"}}}

"{{{Misc Settings

" Necesary  for lots of cool vim things
set nocompatible

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=3
set softtabstop=3

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

" Real men use gcc
"compiler gcc

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Got backspace?
set backspace=2

" Line Numbers PWN!
set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>

nnoremap JJJJ <Nop>

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" When I close a tab, remove the buffer
set nohidden

" Set off the other paren
highlight MatchParen ctermbg=4
" }}}

"{{{Look and Feel

" Favorite Color Scheme
if has("gui_running")
   colorscheme inkpot
   " Remove Toolbar
   set guioptions-=T
   "Terminus is AWESOME
   set guifont=Terminus\ 9
else
   colorscheme metacosm
endif

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" }}}

"{{{ Functions

"{{{ Open URL in browser

function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!konqueror ".line
endfunction

"}}}

"{{{Theme Rotating
let themeindex=0
function! RotateColorTheme()
   let y = -1
   while y == -1
      let colorstring = "inkpot#ron#blue#elflord#evening#koehler#murphy#pablo#desert#torte#"
      let x = match( colorstring, "#", g:themeindex )
      let y = match( colorstring, "#", x + 1 )
      let g:themeindex = x + 1
      if y == -1
         let g:themeindex = 0
      else
         let themestring = strpart(colorstring, x + 1, y - x - 1)
         return ":colorscheme ".themestring
      endif
   endwhile
endfunction
" }}}

"{{{ Paste Toggle
let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc
"}}}

"{{{ Todo List Mode

function! TodoListMode()
   e ~/.todo.otl
   Calendar
   wincmd l
   set foldlevel=1
   tabnew ~/.notes.txt
   tabfirst
   " or 'norm! zMzr'
endfunction

"}}}

"}}}

"{{{ Mappings

" Open Url on this line with the browser \w
map <Leader>w :call Browser ()<CR>

" Open the Project Plugin <F2>
nnoremap <silent> <F2> :Project<CR>

" Open the Project Plugin
nnoremap <silent> <Leader>pal  :Project .vimproject<CR>

" TODO Mode
nnoremap <silent> <Leader>todo :execute TodoListMode()<CR>

" Open the TagList Plugin <F3>
nnoremap <silent> <F3> :Tlist<CR>

" Next Tab
nnoremap <silent> <C-Right> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" Rotate Color Scheme <F8>
nnoremap <silent> <F8> :execute RotateColorTheme()<CR>

" DOS is for fools.
nnoremap <silent> <F9> :%s/$//g<CR>:%s// /g<CR>

" Paste Mode!  Dang! <F10>
nnoremap <silent> <F10> :call Paste_on_off()<CR>
set pastetoggle=<F10>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" Edit gvimrc \gv
nnoremap <silent> <Leader>gv :tabnew<CR>:e ~/.gvimrc<CR>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Good call Benjie (r for i)
nnoremap <silent> <Home> i <Esc>r
nnoremap <silent> <End> a <Esc>r

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Testing
set completeopt=longest,menuone,preview

inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" Fix email paragraphs
nnoremap <leader>par :%s/^>$//<CR>

"ly$O#{{{ "lpjjj_%A#}}}jjzajj

"}}}

"{{{Taglist configuration
let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0
"}}}

let g:rct_completion_use_fri = 1
"let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_ViewRule_pdf = "kpdf"

filetype plugin indent on
syntax on
```

#### Answer 3 (score 73)
This isn't in my .vimrc file, but yesterday I learned about the `]p` command. This pastes the contents of a buffer just like `p` does, but it automatically adjusts the indent to match the line the cursor is on! This is excellent for moving code around.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: How can I add a string to the end of each line in Vim? (score [246015](https://stackoverflow.com/q/594448) in 2013)

#### Question
I want to add `*` to the end of each line in Vim.  

I tried the code unsuccessfully  

```vim
:%s/\n/*\n/g
```

#### Answer accepted (score 332)
`:%s/$/\*/g`   

should work. So should `:%s/$/*/g` as <a href="https://stackoverflow.com/users/51577/mrwiggles">MrWiggles</a> points out correctly.  

#### Answer 2 (score 327)
Even shorter than the :search command:  

```vim
:%norm A*
```

This is what it means:  

```vim
 %       = for every line
 norm    = type the following commands
 A*      = append '*' to the end of current line
```

#### Answer 3 (score 42)
Also:  

```vim
:g/$/norm A*
```

Also:  

```vim
gg<Ctrl-v>G$A*<Esc>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Vim 80 column layout concerns (score [241633](https://stackoverflow.com/q/235439) in 2010)

#### Question
I feel like the way I do 80-column indication in Vim is incorrect: `set columns=80`. At times I also `set textwidth` but I like to be able to see and anticipate line overflow with the `set columns` alternative.  

This has some unfortunate side effects -- I can't `set number` for fear of splitting between files that have different orders of line numbers; i.e. &lt; 100 line files and >= 100 line files will require two different `set columns` values because of the extra column used for the additional digit display. I also start new (g)Vim sessions instead of splitting windows vertically, which forces me to use the window manager's clipboard -- `vsplit`s force me to do `set columns` every time I open or close a pane, so starting a new session is less hassle.  

How do you handle the 80-character indication when you want to `set numbers`, vertically split, etc.?  

#### Answer accepted (score 574)
I have this set up in my .vimrc:  

```vim
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
```

This highlights the background in a subtle red for text that goes over the 80 column limit (subtle in GUI mode, anyway - in terminal mode it's less so).  

#### Answer 2 (score 759)
As of vim 7.3, you can use `set colorcolumn=80` (`set cc=80` for short).  

Since earlier versions do not support this, my `.vimrc` uses instead:  

```vim
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
```

See also <a href="http://vimdoc.sourceforge.net/htmldoc/options.html#%27colorcolumn%27" rel="noreferrer">the online documentation on the `colorcolumn` option</a>.  

#### Answer 3 (score 53)
Shorter way:  

```vim
match ErrorMsg '\%>80v.\+'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: How to save as a new file and keep working on the original one in Vim? (score [239921](https://stackoverflow.com/q/4980168) in 2016)

#### Question
Whenever I use the `:sav` command, it saves the file with a new name and opens the new file open in Vim.    

Is it possible to save the file with a new name but keep the original one open for editing?  

#### Answer 2 (score 508)
Use the `:w` command with a filename:  

```vim
:w other_filename
```

#### Answer 3 (score 263)
Thanks for the answers. Now I know that there are two ways of "SAVE AS" in Vim.  

Assumed that I'm editing hello.txt.  

<ul>
<li><strong>:w world.txt</strong>  will write hello.txt's content to the file world.txt while keeping hello.txt as the opened buffer in vim.</li>
<li><strong>:sav world.txt</strong> will first write hello.txt's content to the file world.txt, then close buffer hello.txt, finally open world.txt as the current buffer.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: How do I exit from the text window in Git? (score [229788](https://stackoverflow.com/q/9171356) in 2012)

#### Question
I am using Windows and before committing, Git wants me to enter a text message and a new text window appears.   

<img src="https://i.stack.imgur.com/DSfuw.png" alt="screenshot">  

How can I exit from this?   

I am trying to learn Git. So, a little help will be highly appreciated.  

#### Answer 2 (score 251)
Since you are learning Git, know that this has little to do with git but with the text editor configured for use. In vim, you can press `i` to start entering text and save by pressing `esc` and `:wq` and `enter`, this will commit with the message you typed. In your current state, to just come out without committing, you can do `:q` instead of the `:wq` as mentioned above.  

Alternatively, you can just do `git commit -m '&lt;message&gt;'` instead of having git open the editor to type the message.  

Note that you can also change the editor and use something you are comfortable with ( like notepad) - <a href="https://stackoverflow.com/questions/10564/how-can-i-set-up-an-editor-to-work-with-git-on-windows">How can I set up an editor to work with Git on Windows?</a>  

#### Answer 3 (score 71)
There is a <a href="http://git-scm.com/book/en/Getting-Started-First-Time-Git-Setup#Your-Editor" rel="noreferrer">default text editor</a> that will be used when Git needs you to type in a message. By default, Git uses your system’s default editor, which is generally <a href="http://ex-vi.sourceforge.net/" rel="noreferrer">Vi</a> or <a href="http://www.vim.org/" rel="noreferrer">Vim</a>. In your case, it is Vim that Git has chosen. See <a href="https://stackoverflow.com/q/2596805/78845">How do I make Git use the editor of my choice for commits?</a> for details of how to choose another editor. Meanwhile...  

You'll want to enter a message before you leave <a href="http://www.vim.org/" rel="noreferrer">Vim</a>:  

<a href="http://vimdoc.sourceforge.net/htmldoc/insert.html#O" rel="noreferrer"><kbd>O</kbd></a>  

...will start a new line for you to type in.  

To exit (g)Vim type:  

<a href="http://vimdoc.sourceforge.net/htmldoc/insert.html#i_%3CEsc%3E" rel="noreferrer"><kbd>Esc</kbd></a><a href="http://vimdoc.sourceforge.net/htmldoc/editing.html#ZZ" rel="noreferrer"><kbd>Z</kbd><kbd>Z</kbd></a> or <kbd>Esc</kbd><a href="http://vimdoc.sourceforge.net/htmldoc/editing.html#:wq" rel="noreferrer"><strong>`:wq`</strong></a><kbd>Return</kbd>.  

It's worth getting to know Vim, as you can use it for editing text on almost any platform. I recommend the <a href="http://vimdoc.sourceforge.net/htmldoc/usr_01.html#tutor" rel="noreferrer"><strong>`Vim Tutor`</strong></a>, I used it <strong>many</strong> years ago and have never looked back (barely a day goes by when I don't use Vim).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: What are the benefits of learning Vim? (score [227338](https://stackoverflow.com/q/597077) in 2015)

#### Question
As a programmer I spend a lot of hours at the keyboard and I've been doing it for the last 12 years, more or less. If there's something I've never gotten used to during all this time, it's these annoying and almost unconscious constant micro-interruptions I experience while coding, due to some of the most common code editing tasks. Things like a simple copy &amp; paste from a different line (or even the same line), or moving 1 or 2 lines up or down from the current position require too much typing or involve the use of the arrow keys ...and it gets worse when I want to move further - I end up using the mouse. Now imagine this same scenario but on a laptop.  

I've always considered learning VIM but the amount of time needed to master it has always made me want to step back.  

I'd like to hear from people who have learnt it and if it ends up being one of those things you cannot live without.  

At work, I use VS2008, C# and R#, which together make editing code a lot faster and easier than ever, but even so I think I could enjoy not having to use the mouse at all.  

And not even the arrow keys.  

#### Answer accepted (score 250)
I've been using vi and vim also for some 20 years, and I'm still learning new things.  

David Rayner's <a href="http://vim.wikia.com/wiki/Best_Vim_Tips" rel="noreferrer">Best of Vim Tips</a> site is an excellent list, though it's probably more useful once you have some familiarity with vim.  

I also want to mention the <a href="http://viemu.com" rel="noreferrer">ViEmu</a> site which has some great info on <a href="http://www.viemu.com/vi_vim_tips.html" rel="noreferrer">vi/vim tips</a> and especially the article <a href="http://www.viemu.com/a-why-vi-vim.html" rel="noreferrer">Why, oh WHY, do those nutheads use vi?</a> (<a href="http://web.archive.org/web/20121010104931/http://www.viemu.com/a-why-vi-vim.html" rel="noreferrer">archived version</a>)  

#### Answer 2 (score 185)
Could I live without it?  Easily.  

Is it useful?  Yes.  

<h5>Reasons for Learning</h2>

<ul>
<li><p>vi is guaranteed to exist on all Unix systems and exists on most Linux ones as well.  That kind of broad coverage makes learning it worth it.</p></li>
<li><p>It's much quicker to use vi for a `sudo` edit:</p>

$ sudo vi   </li>
<li><p>Also, GMail uses vi-ish commands for selecting &amp; moving emails around!</p></li>
</ul>

You don't have to be a master.    

Just learn   

<h5> The basics:</h2>

<ul>
<li>How to switch from command mode to insert mode <kbd>i</kbd></li>
<li>How to switch from insert mode to command mode <kbd>Esc</kbd></li>
<li>How to navigate up a line in command mode <kbd>k</kbd></li>
<li>How to navigate down a line in command mode <kbd>j</kbd></li>
<li>How to navigate left a character in command mode <kbd>h</kbd></li>
<li>How to navigate right a character <kbd>l</kbd></li>
<li>How to save a file `:w`<kbd>Enter</kbd> (write)</li>
<li>How to exit without saving (in command mode) `:q!`<kbd>Enter</kbd></li>
<li>How to Undo <kbd>u</kbd></li>
<li>How to Redo <kbd>Ctrl</kbd>+<kbd>r</kbd></li>
<li>You can combine writing and quitting (in command mode): `:wq`<kbd>Enter</kbd></li>
</ul>

From there the rest will just make you faster.  

#### Answer 3 (score 138)
Running through <a href="http://linuxcommand.gds.tuwien.ac.at/man_pages/vimtutor1.html" rel="noreferrer">vimtutor</a> only took me 30 minutes, which was enough to get familiar with vim. It was worth every second of it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: How to Select Columns in Editors (Atom,Notepad++, Kate, VIM, Sublime, Textpad,etc) and IDEs (NetBeans, IntelliJ IDEA, Eclipse, Visual Studio, etc) (score [225765](https://stackoverflow.com/q/1802616) in 2016)

#### Question
How to select columns in Editors and IDEs to columnar delete, insert or replace some characters ?  

Editors:  

<ul>
<li>Atom</li>
<li>Notepad++</li>
<li>Kate</li>
<li>VIM</li>
<li>Sublime</li>
<li>Emacs</li>
<li>Textpad</li>
<li>Emerald Editor</li>
<li>UltraEdit</li>
<li>MCEdit</li>
<li>jEdit</li>
<li>Nedit</li>
</ul>

IDEs:  

<ul>
<li>NetBeans</li>
<li>Eclipse</li>
<li>Visual Studio</li>
<li>IntelliJ IDEA</li>
<li>Flash Builder</li>
<li>Aptana Studio</li>
</ul>

#### Answer accepted (score 197)
<ul>
<li>Notepad++, Visual Studio, and some others: <kbd>Alt</kbd> + <kbd>drag</kbd>.</li>
<li>vim: <kbd>Ctrl</kbd> + <kbd>v</kbd> or (bizarrely enough) Quad-click-drag. In windows: <kbd>Ctrl</kbd> + <kbd>Q</kbd> (since <kbd>Ctrl</kbd> + <kbd>V</kbd> is the standard for paste)</li>
</ul>

#### Answer 2 (score 75)
In Kate toggle  <kbd>Ctrl</kbd> + <kbd>shift</kbd> + <kbd>B</kbd> .  

#### Answer 3 (score 60)
In Netbeans 7.1 can select columns (Rectangular Selection) with <kbd>Ctrl</kbd> + <kbd>shift</kbd> + <kbd>R</kbd> . There is also a button <img src="https://i.stack.imgur.com/I5OkJ.png" alt="Toggle Rectangular Selection Button"> in the code editor available.  

<p>This is how rectangular selections look like:
<img src="https://i.stack.imgur.com/lsbrf.png" alt="Screenshot Rectangular Selection"></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: How can I change a file's encoding with vim? (score [218678](https://stackoverflow.com/q/778069) in )

#### Question
I'm used to using vim to modify a file's line endings:  

```vim
$ file file
file: ASCII text, with CRLF line terminators
$ vim file
:set ff=mac
:wq
$ file file
file: ASCII text, with CR line terminators
```

Is it possible to use a similar process to change a file's unicode encoding?  I'm trying the following, which doesn't work:  

```vim
$ file file.xml
file.xml: Unicode text, UTF-16, little-endian
$ vim file
:set encoding=utf-8
:wq
$ file file.xml
file.xml: Unicode text, UTF-16, little-endian
```

I saw <a href="http://www.linuxquestions.org/questions/solaris-opensolaris-20/converting-utf-16-files-to-another-encoding-such-as-utf-8-630588/" rel="noreferrer">someone say</a> that he could "set fileencoding=utf-8, then update and write the file, and it works," but I seem to be missing something, or else he was confused.  I don't know what he meant by "then update."  

#### Answer accepted (score 245)
From the <a href="http://vimdoc.sourceforge.net/htmldoc/usr_45.html#45.4" rel="noreferrer">doc</a>:  

<blockquote>
  :write ++enc=utf-8 russian.txt  
</blockquote>

So you should be able to change the encoding as part of the write command.  

#### Answer 2 (score 158)
Notice that there is a difference between   

<pre><a href="http://vimhelp.appspot.com/options.txt.html#%27encoding%27" rel="noreferrer">set encoding</a></pre>

and  

<pre><a href="http://vimhelp.appspot.com/options.txt.html#%27fileencoding%27" rel="noreferrer">set fileencoding</a></pre>

In the first case, you'll change the output encoding that is shown in the terminal. In the second case, you'll change the output encoding of the file that is written.  

#### Answer 3 (score 77)
While using vim to do it is perfectly possible, why don't you simply use iconv? I mean - loading text editor just to do encoding conversion seems like using too big hammer for too small nail.  

Just:  

```vim
iconv -f utf-16 -t utf-8 file.xml > file.utf8.xml
```

And you're done.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: How to use vim in the terminal? (score [214981](https://stackoverflow.com/q/5764071) in 2016)

#### Question
How does one setup and start using vim in the terminal on OS X?  

I want to start writing my C code using vim in the terminal rather than a separate text editor. How does one get started on this?  

The basics like: opening, creating, saving files via terminal using vim and writing code using vim. Also, does one compile directly using vim in the terminal?  

#### Answer accepted (score 70)
Run `vim` from the terminal. For the basics, you're advised to run the command `vimtutor`.  

```vim
# On your terminal command line:
$ vim
```

If you have a specific file to edit, pass it as an argument.  

```vim
$ vim yourfile.cpp
```

Likewise, launch the tutorial  

```vim
$ vimtutor
```

#### Answer 2 (score 142)
<h5>Get started quickly</h1>

You simply type `vim` into the terminal to open it and start a new file.  

You can pass a filename as an option and it will open that file, e.g. `vim main.c`. You can open multiple files by passing multiple file arguments.  

Vim has different modes, unlike most editors you have probably used. You begin in `NORMAL` mode, which is where you will spend most of your time once you become familiar with vim.  

To return to `NORMAL` mode after changing to a different mode, press <kbd>Esc</kbd>. It's a good idea to map your Caps Lock key to Esc, as it's closer and nobody really uses the Caps Lock key.  

The first mode to try is `INSERT` mode, which is entered with <kbd>a</kbd>   for <em>append after cursor</em>, or <kbd>i</kbd> for <em>insert before cursor</em>.  

To enter `VISUAL` mode, where you can select text, use <kbd>v</kbd>. There are many other variants of this mode, which you will discover as you learn more about vim.  

To save your file, ensure you're in `NORMAL` mode and then enter the command `:w`. When you press `:`, you will see your command appear in the bottom status bar. To save and exit, use `:x`. To quit without saving, use `:q`. If you had made a change you wanted to discard, use `:q!`.  

<h5>Configure vim to your liking</h1>

You can edit your `~/.vimrc` file to configure vim to your liking. It's best to look at a few first (<a href="https://github.com/alexanderdickson/dotfiles/blob/master/vimrc" rel="noreferrer">here's mine</a>) and then decide which options suits your style.  

This is how mine looks:  

<a href="https://i.stack.imgur.com/AcRmL.png" rel="noreferrer"><img src="https://i.stack.imgur.com/AcRmL.png" alt="vim screenshot"></a>  

To get the file explorer on the left, use <a href="https://github.com/scrooloose/nerdtree" rel="noreferrer">NERDTree</a>. For the status bar, use <a href="https://github.com/vim-airline/vim-airline" rel="noreferrer">vim-airline</a>. Finally, the color scheme is <a href="https://github.com/altercation/vim-colors-solarized" rel="noreferrer">solarized</a>.  

<h5>Further learning</h1>

You can use `man vim` for some help inside the terminal. Alternatively, run `vimtutor` which is a good hands-on starting point.  

It's a good idea to print out a <a href="http://www.viemu.com/vi-vim-cheat-sheet.gif" rel="noreferrer">Vim Cheatsheet</a> and keep it in front of you while you're learning vim.  

Good luck!  

#### Answer 3 (score 4)
You can definetely build your code <strong>from</strong> Vim, that's what the `:make` command does.  

However, you <strong>need</strong> to go through the basics first : type `vimtutor` in your terminal and follow the instructions to the end.   

After you have completed it a few times, open an existing (non-important) text file and try out all the things you learned from `vimtutor`: entering/leaving insert mode, undoing changes, quitting/saving, yanking/putting, moving and so on.  

For a while you won't be productive at all with Vim and will probably be tempted to go back to your previous IDE/editor. Do that, but keep up with Vim a little bit every day. You'll probably be stopped by very weird and unexpected things but it will happen less and less.  

In a few months you'll find yourself hitting `o`, `v` and `i` all the time in every textfield everywhere.  

Have fun!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: How to set default vim colorscheme (score [199655](https://stackoverflow.com/q/2975994) in 2018)

#### Question
The latest upgrade of Ubuntu made my vim colorscheme unusable. I know how to set it manually (`:colo evening`, for example), but I want to set the default for all vim sessions. I see reference in other places to `.vimrc`, but the right location and syntax have eluded me thus far.  

#### Answer accepted (score 70)
Your `.vimrc` file goes in your `$HOME` directory.  In *nix, `cd ~; vim .vimrc`.  The commands in the `.vimrc` are the same as you type in ex-mode in vim, only without the leading colon, so `colo evening` would suffice.  Comments in the `.vimrc` are indicated with a leading double-quote.  

To see an example vimrc, open `$VIMRUNTIME/vimrc_example.vim` from within vim  

```vim
:e $VIMRUNTIME/vimrc_example.vim
```

#### Answer 2 (score 126)
Put a `colorscheme` directive in your `.vimrc` file, for example:  

```vim
colorscheme morning
```

See here: <a href="http://vim.wikia.com/wiki/Change_the_color_scheme" rel="noreferrer">http://vim.wikia.com/wiki/Change_the_color_scheme</a>  

#### Answer 3 (score 34)
It's as simple as adding a line to your `~/.vimrc`:  

<blockquote>
  colorscheme color_scheme_name  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: How do I switch between command and insert mode in Vim? (score [198230](https://stackoverflow.com/q/13178874) in 2016)

#### Question
I just started using Vim as an IDE. I was using it as a test editor for a while now, so I didn't have to go to command mode very often. But, since I program in Java, I have to go to command mode to make the file, compile/run it... etc.   

The problem is: I need a good way to switch between the two modes.   

I looked online and it says that the `&lt;Esc&gt;` key is supposed to do that, but that doesn't work for me (maybe it's not for gVim? I don't know why.)  

I have to press <kbd>CTRL</kbd><kbd>O</kbd> every time to go to command mode; the escape key works from that mode... it brings me back to insert mode. But is there a better, or easier, way of switching between command mode and insert mode?  

#### Answer accepted (score 43)
Looks like your Vim is launched in <em>easy mode</em>. See `:help easy`.  

This happens when Vim is invoked with the `-y` argument or as `evim`, or maybe you have a `:set insertmode` somewhere in your `.vimrc` configuration. Find the source and disable it; temporarily this can be also done via <kbd>Ctrl</kbd> + <kbd>O</kbd> `:set noim` <kbd>Enter</kbd>.  

#### Answer 2 (score 107)
<p>Pressing <kbd>ESC</kbd> quits from insert mode to normal mode, where you can press <kbd>:</kbd> to type in a command.
Press <kbd>i</kbd> again to back to insert mode, and you are good to go.</p>

I'm not a Vim guru, so someone else can be more experienced and give you other options.  

#### Answer 3 (score 16)
This has been mentioned in <a href="https://stackoverflow.com/a/4416543/3653165">other questions</a>, but <kbd>ctrl + [</kbd> is an equivalent to <kbd>ESC</kbd> on all keyboards.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: How do I close a single buffer (out of many) in Vim? (score [190152](https://stackoverflow.com/q/1269648) in 2011)

#### Question
I open several files in Vim by, for example, running  

```vim
vim a/*.php
```

which opens 23 files.  

I then make my edit and run the following twice  

```vim
:q
```

which closes all my buffers.  

<strong>How can you close only one buffer in Vim?</strong>  

#### Answer accepted (score 524)
<strong>A word of caution: "w does not stand for write but for wipeout!"</strong>   

More from manuals:  

<strong>:bd</strong>  

<blockquote>
  <p>Unload buffer [N] (default: current
  buffer) and delete it from
                  the buffer list.  If the buffer was changed, this fails,
                  unless when [!] is specified, in which case changes are
  lost.
                  The file remains unaffected.</p>
</blockquote>

<strong>If you know what you're doing, you can also use :bw</strong>  

<strong>:bw</strong>  

<blockquote>
  <p>Like |:bdelete|, but really delete the
  buffer.</p>
</blockquote>

#### Answer 2 (score 346)
If this isn't made obvious by the the previous answers:  

<strong>:bd</strong> will close the current buffer.  If you don't want to grab the buffer list.  

#### Answer 3 (score 100)
<p>Check your buffer id using 
:buffers</p>

you will see list of buffers there like   

```vim
1  a.php
2  b.php
3  c.php
```

if you want to remove b.php from buffer  

```vim
:2bw
```

if you want to remove/close all from buffers  

```vim
:1,3bw
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Jump to function definition in vim (score [188891](https://stackoverflow.com/q/635770) in 2017)

#### Question
How can I jump to to a function definition using vim? For example with Visual Assist, I can type <kbd>Alt</kbd>+<kbd>g</kbd> under a function and it opens a context menu listing the files with definitions.  

How can I do something like this in vim?  

#### Answer accepted (score 187)
Use ctags.  Generate a tags file, and tell vim where it is using the :tags command.  Then you can just jump to the function definition using <kbd>Ctrl</kbd>-<kbd>]</kbd>  

There are more tags tricks and tips in <a href="https://stackoverflow.com/questions/563616/vimctags-tips-and-tricks">this question</a>.  

#### Answer 2 (score 121)
If everything is contained in one file, there's the command <strong>`gd`</strong> (as in 'goto definition'), which will take you to the first occurrence in the file of the word under the cursor, which is often the definition.  

#### Answer 3 (score 96)
<kbd>g*</kbd> does a decent job without ctags being set up.  

That is, type <kbd>g</kbd>,<kbd>*</kbd> (or just <kbd>*</kbd> - see below) to search for the word under the cursor (in this case, the function name). Then press <kbd>n</kbd> to go to the next (or <kbd>Shift</kbd>-<kbd>n</kbd> for previous) occurrence.  

It doesn't jump directly to the definition, given that this command just searches for the word under the cursor, but if you don't want to deal with setting up ctags at the moment, you can at least save yourself from having to re-type the function name to search for its definition.  

<p>--Edit--
Although I've been using g* for a long time, I've recently discovered two shortcuts for these shortcuts!</p>

(a) <kbd>*</kbd> will jump to the next occurrence of the word under the cursor. (No need to type the `g`, the 'goto' command in vi).   

(b) <kbd>#</kbd> goes to the previous occurrence, in similar fashion.  

N and n still work, but '#' is often very useful to start the search initially in the reverse direction, for example, when looking for the declaration of a variable under the cursor.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: Paste in insert mode? (score [185878](https://stackoverflow.com/q/2861627) in 2018)

#### Question
Is it possible to paste in insert mode in Vim?  

#### Answer accepted (score 424)
While in insert mode hit `CTRL-R {register}`   

Examples:      

<ul>
<li>`CTRL-R *` will insert in the contents of the clipboard    </li>
<li>`CTRL-R "` (the unnamed register) inserts the last delete or yank.  </li>
</ul>

To find this in vim's help type `:h i_ctrl-r`  

#### Answer 2 (score 225)
If you don't want Vim to mangle formatting in incoming pasted text, you might also want to consider using: `:set paste`. This will prevent Vim from re-tabbing your code. When done pasting, `:set nopaste` will return to the normal behavior.  

It's also possible to toggle the mode with a single key, by adding something like `set pastetoggle=&lt;F2&gt;` to your .vimrc.  More details on toggling auto-indent are <a href="http://vim.wikia.com/wiki/VimTip906" rel="noreferrer">here</a>.  

#### Answer 3 (score 119)
<strike>No not directly.</strike>  What you can do though is quickly exit insert mode for a single normal mode  operation with <kbd>Ctrl-O</kbd> and then paste from there which will end by putting you back in insert mode.   

Key Combo: <kbd>Ctrl-O</kbd>  <kbd>p</kbd>  

<strong>EDIT:</strong> Interesting. It does appear that there is a way as several other people have listed.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Renaming the current file in Vim (score [184978](https://stackoverflow.com/q/1205286) in 2018)

#### Question
How should I rename my current file in Vim?  

For example:  

<ul>
<li>I am editing `person.html_erb_spec.rb`</li>
<li>I would like it renamed to `person.haml_spec.rb`</li>
<li>I would like to continue editing `person.haml_spec.rb`</li>
</ul>

How would I go about doing this, elegantly?  

#### Answer accepted (score 88)
There's a <a href="http://www.vim.org/scripts/script.php?script_id=1928" rel="noreferrer">little plugin</a> that let's you do this.  

#### Answer 2 (score 429)
The command is called `:saveas`, but unfortunately it will not delete your old file, you'll have to do that manually. see <a href="http://vimdoc.sourceforge.net/htmldoc/editing.html#:saveas" rel="noreferrer">`:help saveas`</a> for more info.  

<strong>EDIT:</strong>  

Most vim installations have an integrated file explorer, which you can use for such operations. Try `:Explore` in command mode (I would actually map that to a function key, it's <em>very</em> handy). You can rename files with `R` or delete them with `D`, for example. But pressing `&lt;F1&gt;` in the explorer will give you a better overview.  

#### Answer 3 (score 148)
If you use git and already have the tpope's plugin <a href="https://github.com/tpope/vim-fugitive">fugitive.vim</a> then simply:  

```vim
:Gmove newname
```

This will:  

<ol>
<li>Rename your file on disk.</li>
<li>Rename the file in git repo.</li>
<li>Reload the file into the current buffer.</li>
<li>Preserve undo history.</li>
</ol>

If your file was not yet added to a git repo then first add it:  

```vim
:Gwrite
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: Why does using from __future__ import print_function breaks Python2-style print? (score [182008](https://stackoverflow.com/q/32032697) in 2019)

#### Question
I am new at programming with python, and I am trying to print out with a separator and end but it is still giving me a syntax error.  

I am using python 2.7.  

Here is my code:  

```vim
from __future__ import print_function
import sys, os, time

for x in range(0,10):
    print x, sep=' ', end=''
    time.sleep(1)
```

And here is the error:  

```vim
$ python2 xy.py
  File "xy.py", line 5
    print x, sep=' ', end=''
          ^
SyntaxError: invalid syntax
$
```

#### Answer accepted (score 188)
First of all, `from __future__ import print_function` needs to be the first line of code in your script (aside from some exceptions mentioned below). Second of all, as other answers have said, you have to use `print` as a function now. That's the whole point of `from __future__ import print_function`; to bring the `print` <em>function</em> from Python 3 into Python 2.6+.  

```vim
from __future__ import print_function

import sys, os, time

for x in range(0,10):
    print(x, sep=' ', end='')  # No need for sep here, but okay :)
    time.sleep(1)
```

`__future__` statements need to be near the top of the file because they change fundamental things about the language, and so the compiler needs to know about them from the beginning. From <a href="https://docs.python.org/2/reference/simple_stmts.html#future" rel="noreferrer">the documentation</a>:  

<blockquote>
  <p>A future statement is recognized and treated specially at compile
  time: Changes to the semantics of core constructs are often
  implemented by generating different code. It may even be the case that
  a new feature introduces new incompatible syntax (such as a new
  reserved word), in which case the compiler may need to parse the
  module differently. Such decisions cannot be pushed off until runtime.</p>
</blockquote>

The documentation also mentions that the only things that can precede a `__future__` statement are the module docstring, comments, blank lines, and other future statements.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: Delete newline in Vim (score [177877](https://stackoverflow.com/q/3983406) in )

#### Question
Is there a way to delete the newline at the end of a line in Vim, so that the next line is appended to the current line?  

For example:  

```vim
Evaluator<T>():
    _bestPos(){
}
```

I'd like to put this all on one line without copying lines and pasting them into the previous one.  It seems like I should be able to put my cursor to the end of each line, press a key, and have the next line jump onto the same one the cursor is on.  

End result:  

```vim
Evaluator<T>(): _bestPos(){ }
```

Is this possible in Vim?  

#### Answer accepted (score 554)
If you are on the first line, pressing (upper case) <kbd>J</kbd> will join that line and the next line together, removing the newline. You can also combine this with a count, so pressing `3J` will combine all 3 lines together.  

#### Answer 2 (score 76)
<p>Certainly. Vim recognizes the \n character as a newline, so you can just search and replace.
In command mode type:</p>

```vim
:%s/\n/
```

#### Answer 3 (score 49)
While on the upper line in normal mode, hit <kbd>Shift</kbd>+<kbd>j</kbd>.  

You can prepend a count too, so `3J` on the top line would join all those lines together.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: vi editor, copy a block (not usual action) (score [172648](https://stackoverflow.com/q/13447066) in 2018)

#### Question
In vi editor, I need to copy a block. There are many ways, but one way is very quick.  

<ol>
<li><p>label the first line by some way,</p></li>
<li><p>then label the end line by some way,</p></li>
<li><p>then put some command to copy the labeled lines.</p></li>
<li><p>then copy, may using 'p', but not sure.</p></li>
</ol>

Anybody know the commands (not yy or 10yy)? Thanks in advance.   

#### Answer accepted (score 34)
Another option which may be easier to remember would be to place marks on the two lines with <kbd>m</kbd><kbd>a</kbd> and <kbd>m</kbd><kbd>b</kbd>, then run `:'a,'byank`.  

Many different ways to accomplish this task, just offering another.  

#### Answer 2 (score 89)
just use <kbd>V</kbd> to select lines or <kbd>v</kbd> to select chars or <kbd>Ctrl</kbd><kbd>v</kbd> to select a block.  

When the selection spans the area you'd like to copy just hit <kbd>y</kbd> and use <kbd>p</kbd> to paste it anywhere you like...  

#### Answer 3 (score 50)
<strong><a href="http://vim.wikia.com/wiki/Copy,_cut_and_paste" rel="noreferrer">Their Documentation says:</a></strong>  

<strong>Cut and paste:</strong>  

<ol>
<li>Position the cursor where you want to begin cutting.</li>
<li>Press <kbd>v</kbd> to select characters (or uppercase <kbd>V</kbd> to select whole lines).</li>
<li>Move the cursor to the end of what you want to cut.</li>
<li>Press <kbd>d</kbd> to cut (or <kbd>y</kbd> to copy).</li>
<li>Move to where you would like to paste.</li>
<li>Press <kbd>P</kbd> to paste before the cursor, or <kbd>p</kbd> to paste after. </li>
</ol>

Copy and paste is performed with the same steps except for step 4 where you would press y instead of d:  

<kbd>d</kbd> = `delete` = `cut`  

<kbd>y</kbd> = `yank` = `copy`   

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: What is the difference between the remap, noremap, nnoremap and vnoremap mapping commands in Vim? (score [171778](https://stackoverflow.com/q/3776117) in 2018)

#### Question
What is the difference between the remap, noremap, nnoremap and vnoremap mapping commands in Vim?  

#### Answer accepted (score 1501)
`remap` is an <strong>option</strong> that makes mappings work recursively. By default it is on and I'd recommend you leave it that way. The rest are <strong>mapping commands</strong>, described below:  

`:map` and `:noremap` are <strong>recursive</strong> and <strong>non-recursive</strong> versions of the various mapping commands. What that means is that if you do:  

```vim
:map j gg
:map Q j
:noremap W j
```

`j` will be mapped to `gg`. `Q` will <em>also</em> be mapped to `gg`, because `j` will be expanded for the recursive mapping. `W` will be mapped to `j` (and not to `gg`) because `j` will not be expanded for the non-recursive mapping.  

Now remember that Vim is a <strong>modal editor</strong>. It has a <strong>normal</strong> mode, <strong>visual</strong> mode and other modes.  

For each of these sets of mappings, there is a <a href="http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_%28Part_1%29#Creating_keymaps" rel="noreferrer">mapping</a> that works in normal, visual, select and operator modes (`:map` and `:noremap`), one that works in normal mode (`:nmap` and `:nnoremap`), one in visual mode (`:vmap` and `:vnoremap`) and so on.  

For more guidance on this, see:  

```vim
:help :map
:help :noremap
:help recursive_mapping
:help :map-modes
```

#### Answer 2 (score 243)
I think the Vim documentation should've explained the meaning behind the naming of these commands. Just telling you what they do doesn't help you remember the names.  

`map` is the "root" of all recursive mapping commands. The root form applies to "normal", "visual+select", and "operator-pending" modes. (I'm using the term "root" as in <a href="https://simple.wikipedia.org/wiki/Root_(linguistics)" rel="noreferrer">linguistics</a>.)  

`noremap` is the "root" of all non-recursive mapping commands. The root form applies to the same modes as `map`. (Think of the `nore` prefix to mean "non-recursive".)  

(Note that there are also the `!` modes like `map!` that apply to insert &amp; command-line.)  

See below for what "recursive" means in this context.  

Prepending a mode letter like `n` modify the modes the mapping works in. It can choose a subset of the list of applicable modes (e.g. only "visual"), or choose other modes that `map` wouldn't apply to (e.g. "insert").  

Use `help map-modes` will show you a few tables that explain how to control which modes the mapping applies to.  

Mode letters:  

<ul>
<li>`n`: normal only</li>
<li>`v`: visual and select</li>
<li>`o`: operator-pending</li>
<li>`x`: visual only</li>
<li>`s`: select only</li>
<li>`i`: insert</li>
<li>`c`: command-line</li>
<li>`l`: insert, command-line, regexp-search (and others. Collectively called "Lang-Arg" pseudo-mode)</li>
</ul>

"<strong>Recursive</strong>" means that the mapping is expanded to a result, then the result is expanded to another result, and so on.  

The expansion stops when one of these is true:  

<ol>
<li>the result is no longer mapped to anything else.</li>
<li>a non-recursive mapping has been applied (i.e. the "noremap" [or one of its ilk] is the final expansion).</li>
</ol>

At that point, Vim's default "meaning" of the final result is applied/executed.  

"<strong>Non-recursive</strong>" means the mapping is only expanded once, and that result is applied/executed.  

Example:  

```vim
 nmap K H
 nnoremap H G
 nnoremap G gg
```

The above causes `K` to expand to `H`, then `H` to expand to `G` and stop. It stops because of the `nnoremap`, which expands and stops immediately. The meaning of `G` will be executed (i.e. "jump to last line"). At most one non-recursive mapping will ever be applied in an expansion chain (it would be the last expansion to happen).  

The mapping of `G` to `gg` only applies if you press `G`, but not if you press `K`. This mapping doesn't affect pressing `K` regardless of whether `G` was mapped recursively or not, since it's line 2 that causes the expansion of `K` to stop, so line 3 wouldn't be used.  

#### Answer 3 (score 77)
<p>Caution, `vnoremap` and `vmap` work in Visual AND Select mode.
To have a mapping only in Visual mode, use `xmap` and `xnoremap`.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: How do I change tab size in Vim? (score [170917](https://stackoverflow.com/q/2054627) in 2017)

#### Question
Every time I add a selector in CSS and I press `Enter` to define the properties it ends up like this:  



```vim
#selector {
        property: value;
}
```

(8-space tabs)  

How can I configure Vim to make it like this:  

```vim
#selector {
    property: value;
}
```

(4-space tabs)  

#### Answer accepted (score 85)
Expanding on zoul's answer:  

If you want to setup Vim to use specific settings when editing a particular filetype, you'll want to use autocommands:  

```vim
autocmd Filetype css setlocal tabstop=4
```

This will make it so that tabs are displayed as 4 spaces. Setting `expandtab` will cause Vim to actually insert spaces (the number of them being controlled by `tabstop`) when you press tab; you might want to use `softtabstop` to make backspace work properly (that is, reduce indentation when that's what would happen should tabs be used, rather than always delete one char at a time).  

To make a fully educated decision as to how to set things up, you'll need to read Vim docs on `tabstop`, `shiftwidth`, `softtabstop` and `expandtab`. The most interesting bit is found under `expandtab` (`:help 'expandtab`):  

<blockquote>
  There are four main ways to use tabs in Vim:  
  
  <ol>
  <li><p>Always keep 'tabstop' at 8, set 'softtabstop' and 'shiftwidth' to 4 (or 3 or whatever you prefer) and use 'noexpandtab'.  Then Vim will use a mix of tabs and spaces, but typing  and  will behave like a tab appears every 4 (or 3) characters.</p></li>
  <li><p>Set 'tabstop' and 'shiftwidth' to whatever you prefer and use 'expandtab'.  This way you will always insert spaces.  The formatting will never be messed up when 'tabstop' is changed.</p></li>
  <li><p>Set 'tabstop' and 'shiftwidth' to whatever you prefer and use a |modeline| to set these values when editing the file again.  Only works when using Vim to edit the file.</p></li>
  <li><p>Always set 'tabstop' and 'shiftwidth' to the same value, and 'noexpandtab'.  This should then work (for initial indents only) for any tabstop setting that people use.  It might be nice to have tabs after the first non-blank inserted as spaces if you do this though.  Otherwise aligned comments will be wrong when 'tabstop' is changed.</p></li>
  </ol>
</blockquote>

#### Answer 2 (score 177)
```vim
:set tabstop=4
:set shiftwidth=4
:set expandtab
```

This will insert four spaces instead of a tab character. Spaces are a bit more “stable”, meaning that text indented with spaces will show up the same in the browser and any other application.  

#### Answer 3 (score 98)
To make the change for one session, use this command:   

```vim
:set tabstop=4
```

To make the change permanent, add it to `~/.vimrc` or `~/.vim/vimrc`:   

```vim
set tabstop=4
```

This will affect all files, not just css.  To only affect css files:   

```vim
autocmd Filetype css setlocal tabstop=4
```

as stated in <a href="https://stackoverflow.com/a/2054782/3006854">Michał's answer</a>.    

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: vim - How to delete a large block of text without counting the lines? (score [169640](https://stackoverflow.com/q/5362363) in )

#### Question
In vim, I often find myself deleting (or copying) large blocks of text. One can count the lines of text and say (for example) `50dd` to delete 50 lines.   

But how would one delete this large block of text without having to know how many lines to delete?  

#### Answer accepted (score 282)
I'm no vim guru, but what I use in this circumstance is "visual mode". In command mode, type `V` (capital). Then move up/down to highlight the block you want deleted (all the usual movement commands work). Then remove it with `x` or `d`.  

#### Answer 2 (score 288)
Go to the starting line and type <kbd>m</kbd><kbd>a</kbd> (mark "a"). Then go to the last line and enter <kbd>d</kbd><kbd>'</kbd><kbd>a</kbd> (delete to mark "a").  

That will delete all lines from the current to the marked one (inclusive). It's also compatible with `vi` as well as `vim`, on the off chance that your environment is not blessed with the latter.  

#### Answer 3 (score 45)
<p>You can use the visual mode also (some commands are usable with the delete option also)
<kbd>vip</kbd> <kbd>vap</kbd> to select paragraph, <kbd>v2ap</kbd> to select two paragraphs 
<kbd>dap</kbd> works, <kbd>d2ap</kbd> also. You can delete within blocks of `[` `]` like <kbd>da[</kbd> </p>

<p>For reference: the types of objects.
From vim documentation : section 4. <a href="http://vimdoc.sourceforge.net/htmldoc/visual.html">http://vimdoc.sourceforge.net/htmldoc/visual.html</a></p>

```vim
4. Operating on the Visual area             *visual-operators*

...    
The objects that can be used are:
aw  a word (with white space)           
iw  inner word                  
aW  a WORD (with white space)           
iW  inner WORD                  
as  a sentence (with white space)           
is  inner sentence                  
ap  a paragraph (with white space)          
ip  inner paragraph                 
ab  a () block (with parenthesis)           
ib  inner () block                  
aB  a {} block (with braces)            
iB  inner {} block                  
a<  a <> block (with <>)                
i<  inner <> block                  
a[  a [] block (with [])                
i[  inner [] block                  
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: How I can delete in VIM all text from current line to end of file? (score [169543](https://stackoverflow.com/q/8124315) in 2019)

#### Question
I have very large files (more than 10Gb). I need only some lines from the top of the file. Is it possible (in vim) to delete the rest of the file (from current line to the end of file)?  

#### Answer accepted (score 340)
<kbd>d</kbd><kbd>G</kbd> will delete from the current line to the end of file  

<kbd>d</kbd><kbd>Ctrl</kbd>+<kbd>End</kbd> will delete from the cursor to the end of the file  

But if this file is as large as you say, you may be better off reading the first few lines with `head` rather than editing and saving the file.  

```vim
head hugefile > firstlines
```

(If you are on Windows you can use the Win32 port of `head`)  

#### Answer 2 (score 61)
Go to the first line from which you would like to delete, and press the keys <kbd>d</kbd><kbd>G</kbd>   

#### Answer 3 (score 27)
<kbd>:</kbd><kbd>.</kbd><kbd>,</kbd><kbd>$</kbd><kbd>d</kbd>  

This will delete all content from current line to end of the file. This is very useful when you're dealing with test vector generation or stripping.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: Git commit in terminal opens VIM, but can't get back to terminal (score [168900](https://stackoverflow.com/q/13507430) in 2016)

#### Question
Trying to learn GitHub at the moment and doing this <a href="https://tutsplus.com/course/git-essentials/">Git essentials tutorial</a> over at nettuts. I'm on the lesson about making commits.  

The teacher types `git commit` and it opens VIM as his editor (I'd also like to know how to make it open up in <a href="http://www.sublimetext.com/">Sublime Text</a> 2 instead) anyways it opens in VIM and I add in 1 line saying this is my first commit and hit save.  

Next it then prompts me to save the output to the desktop, something I did not see in his screencast. Now I'm still in VIM and not sure how to get back to 'normal' terminal :(  

I couldn't figure it out so I just exited the terminal and relaunched it, did git commit again and had some warning messages about duplicates! Not sure if I need to `(E)edit` anyways or `(A)abort`.  

<strong>git status</strong>  

<img src="https://i.stack.imgur.com/OoMYb.png" alt="enter image description here">  

<strong>vim</strong>  

<img src="https://i.stack.imgur.com/d4bbf.png" alt="enter image description here">  

<strong>message</strong> when I reopen terminal and do git commit again  

<img src="https://i.stack.imgur.com/wIZ30.png" alt="enter image description here">  

#### Answer accepted (score 349)
To save your work and exit press <kbd>Esc</kbd> and then <kbd>:</kbd><kbd>w</kbd><kbd>q</kbd> (w for write and q for quit).  

Alternatively, you could both save and exit by pressing <kbd>Esc</kbd> and then <kbd>:</kbd><kbd>x</kbd>  

To set another editor run `export EDITOR=myFavoriteEdior`on your terminal, where `myFavoriteEdior` can be `vi`, `gedit`, `subl`(for sublime) etc.  

#### Answer 2 (score 37)
not really the answer to the VIM problem but you could use the command line to also enter the commit message:  

```vim
git commit -m "This is the first commit"
```

#### Answer 3 (score 19)
You need to return to <em>normal</em> mode and save the commit message with either  

```vim
<Esc>:wq
```

or  

```vim
<Esc>:x
```

or  

```vim
<Esc>ZZ
```

<p>The <kbd>Esc</kbd> key returns you from <em>insert</em> mode to <em>normal</em> mode.
The <kbd>:wq</kbd>, <kbd>:x</kbd> or <kbd>ZZ</kbd> sequence writes the changes and exits the editor.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: Changing Vim indentation behavior by file type (score [167470](https://stackoverflow.com/q/158968) in 2017)

#### Question
Could someone explain to me in simple terms the easiest way to change the indentation behavior of Vim based on the file type? For instance, if I open a Python file it should indent with 2 spaces, but if I open a Powershell script it should use 4 spaces.  

#### Answer accepted (score 288)
You can add `.vim` files to be executed whenever vim switches to a particular filetype.  

For example, I have a file `~/.vim/after/ftplugin/html.vim`  with this contents:  

```vim
setlocal shiftwidth=2
setlocal tabstop=2
```

Which causes vim to use tabs with a width of 2 characters for indenting (the `noexpandtab` option is set globally elsewhere in my configuration).  

This is described here: <a href="http://vimdoc.sourceforge.net/htmldoc/usr_05.html#05.4" rel="noreferrer">http://vimdoc.sourceforge.net/htmldoc/usr_05.html#05.4</a>, scroll down to the section on filetype plugins.  

#### Answer 2 (score 164)
Use ftplugins or autocommands to set options.  

<h5>ftplugin</h3>

In `~/.vim/ftplugin/python.vim:`  

```vim
setlocal shiftwidth=2 softtabstop=2 expandtab
```

And don't forget to turn them on in `~/.vimrc`:  

```vim
filetype plugin indent on
```

(`:h ftplugin` for more information)  

<h5>autocommand</h3>

In `~/.vimrc`:  

```vim
autocmd FileType python setlocal shiftwidth=2 softtabstop=2 expandtab
```

<p>You can replace any of the long commands or settings with their short versions:<br>
<a href="http://vimdoc.sourceforge.net/htmldoc/autocmd.html#:autocmd" rel="noreferrer">`autocmd`</a>: `au`<br>
<a href="http://vimdoc.sourceforge.net/htmldoc/options.html#:setlocal" rel="noreferrer">`setlocal`</a>: `setl`<br>
<a href="http://vimdoc.sourceforge.net/htmldoc/options.html#&#39;shiftwidth&#39;" rel="noreferrer">`shiftwidth`</a>: `sw`<br>
<a href="http://vimdoc.sourceforge.net/htmldoc/options.html#&#39;tabstop&#39;" rel="noreferrer">`tabstop`</a>: `ts`<br>
<a href="http://vimdoc.sourceforge.net/htmldoc/options.html#&#39;softtabstop&#39;" rel="noreferrer">`softtabstop`</a>: `sts`<br>
<a href="http://vimdoc.sourceforge.net/htmldoc/options.html#&#39;expandtab&#39;" rel="noreferrer">`expandtab`</a>: `et`  </p>

I would also suggest learning the difference between `tabstop` and `softtabstop`. A lot of people don't know about `softtabstop`.  

#### Answer 3 (score 79)
edit your `~/.vimrc`, and add different file types for different indents,e.g. I want `html/rb` indent for 2 spaces, and `js/coffee` files indent for 4 spaces:  

```vim
" by default, the indent is 2 spaces. 
set shiftwidth=2
set softtabstop=2
set tabstop=2

" for html/rb files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" for js/coffee/jade files, 4 spaces
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype jade setlocal ts=4 sw=4 sts=0 expandtab
```

refer to: <a href="https://stackoverflow.com/questions/1562633/setting-vim-whitespace-preferences-by-filetype">Setting Vim whitespace preferences by filetype</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: Go to beginning of line without opening new line in VI (score [160892](https://stackoverflow.com/q/10243551) in 2012)

#### Question
For ages now I've used <kbd>SHIFT</kbd><kbd>O</kbd> and <kbd>SHIFT</kbd><kbd>$</kbd> to move to the beginning and end of a line in `vi`.  

However <kbd>SHIFT</kbd><kbd>O</kbd> is more for opening a new line above the cursor.    

Is there any command which just takes you to the start of a line?  

#### Answer accepted (score 385)
You can use <kbd>^</kbd> or <kbd>0</kbd> (Zero) in normal mode to move to the beginning of a line.  

<p><kbd>^</kbd> moves the cursor to the first non-blank character of a line<br>
<kbd>0</kbd> always moves the cursor to the "first column"</p>

You can also use <kbd>Shift</kbd><kbd>i</kbd> to move and switch to Insert mode.   

#### Answer 2 (score 26)
A simple `0` takes you to the beginning of a line.  

`:help 0` for more information  

#### Answer 3 (score 21)
Try this <a href="http://worldtimzone.com/res/vi.html" rel="noreferrer">Vi/Vim cheatsheet</a> solution to many problems.   

<p>For normal mode :<br>
<kbd>0</kbd> - [zero] to beginning of line, first column.<br>
<kbd>$</kbd> - to end of line</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: How do you delete all text above a certain line (score [154077](https://stackoverflow.com/q/4161921) in )

#### Question
How do you delete all text above a certain line. For deletion below a line I use "d shift g"  

#### Answer accepted (score 449)
```vim
dgg
```

will delete everything from your current line to the top of the file.  

`d` is the deletion command, and `gg` is a movement command that says go to the top of the file, so when used together, it means delete from my current position to the top of the file.  

Also  

```vim
dG
```

will delete all lines at or below the current one  

#### Answer 2 (score 37)
```vim
kdgg
```

delete all lines above the current one.  

#### Answer 3 (score 35)
<p>`:1,.d` deletes lines 1 to current.<br>
`:1,.-1d` deletes lines 1 to above current.</p>

(Personally I'd use `dgg` or `kdgg` like the other answers, but TMTOWTDI.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: Go to first line in a file in vim? (score [152109](https://stackoverflow.com/q/5507374) in 2013)

#### Question
How do I go to first line in a file in vim ?  

#### Answer accepted (score 370)
In command mode (press <kbd>Esc</kbd> if you are not sure) you can use:  

<ul>
<li><kbd>g</kbd><kbd>g</kbd>,</li>
<li><kbd>:</kbd><kbd>1</kbd>,</li>
<li><kbd>1</kbd><kbd>G</kbd>,</li>
<li>or <kbd>1</kbd><kbd>gg</kbd>.</li>
</ul>

#### Answer 2 (score 35)
Type "gg" in command mode. This brings the cursor to the first line.  

#### Answer 3 (score 4)
If you are using gvim, you could just hit <kbd>Ctrl + Home</kbd> to go the first line. Similarly, <kbd>Ctrl + End</kbd> goes to the last line.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: set gvim font in .vimrc file (score [151084](https://stackoverflow.com/q/3316244) in 2019)

#### Question
I am using gVim 7.2 on Windows 7. I can set the gui font as Consolas 10 (font size) from the menu. I am trying to set this in `.vimrc` file like below:  

```vim
set guifont=Consolas\ 10
```

But it doesn't work. Does anyone know how to set this?  

#### Answer accepted (score 291)
I use the following (Uses Consolas size 11 on Windows, Menlo Regular size 14 on Mac OS X and Inconsolata size 12 everywhere else):  

```vim
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif
```

Edit: And while you're at it, you could take a look at Coding Horror's <a href="http://www.codinghorror.com/blog/2004/12/progamming-fonts.html" rel="noreferrer">Programming Fonts blog post</a>.  

Edit²: Added MacVim.  

#### Answer 2 (score 79)
Try setting your font from the menu and then typing  

```vim
:set guifont?
```

This should display to you the string that Vim has set this option to. You'll need to escape any spaces.  

#### Answer 3 (score 42)
<blockquote>
  I am trying to set this in .vimrc file like below  
</blockquote>

For GUI specific settings use the `.gvimrc` instead of `.vimrc`, which on Windows is either `$HOME\_gvimrc` or `$VIM\_gvimrc`.  

Check the <a href="http://vimdoc.sourceforge.net/htmldoc/gui.html#.gvimrc" rel="noreferrer">`:help .gvimrc`</a> for details. In essence, on start-up VIM reads the `.vimrc`. After that, if GUI is activated, it also reads the `.gvimrc`. IOW, all VIM general settings should be kept in `.vimrc`, all GUI specific things in `.gvimrc`. (But if you do no use console VIM then you can simply forget about the `.vimrc`.)  

<blockquote>
  set guifont=Consolas\ 10  
</blockquote>

The syntax is wrong. After `:set guifont=*` you can always check the proper syntax for the font using `:set guifont?`. VIM Windows syntax is `:set guifont=Consolas:h10`. I do not see precise specification for that, though it is mentioned in the <a href="http://vimdoc.sourceforge.net/htmldoc/os_win32.html#win32-faq" rel="noreferrer">`:help win32-faq`</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: How to run mvim (MacVim) from Terminal? (score [150401](https://stackoverflow.com/q/2056137) in 2011)

#### Question
I have MacVim installed and I am trying to set it up as the editor for Git (version control),  but I can't run 'mvim' from the command line as it isn't recognised. How do I setup mvim so I can run it from Terminal?  

#### Answer accepted (score 188)
There should be a script named mvim in the root of the .bz2 file. Copy this somewhere into your $PATH ( /usr/local/bin would be good ) and you should be sorted.  

#### Answer 2 (score 205)
I don't think I'd to add anything to the path, did  

```vim
brew install macvim

mvim -v
```

should then open macvim in the terminal, you can also go ahead and alias that  

```vim
alias vim='mvim -v'
```

#### Answer 3 (score 105)
If you go the brew route, the best way to install would be:  

```vim
brew install macvim --with-override-system-vim
```

That will provide mvim, vim, vi, view, etc. in /usr/local/bin (all symlinked to the copy in the Cellar). This also removes the need to create any aliases and also changes your vi, vim, etc. to all use the same Vim distribution as your MacVim.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: vim line numbers - how to have them on by default? (score [148936](https://stackoverflow.com/q/10274146) in 2014)

#### Question
I can `:set number` from within a file I'm editing but how can I have them always be on by default?  

#### Answer accepted (score 413)
<p>Add `set number` to your `.vimrc` file in your home directory.<br>
If the `.vimrc` file is not in your home directory create one with
`vim .vimrc` and add the commands you want at open.</p>

<a href="http://vim.wikia.com/wiki/Open_vimrc_file" rel="noreferrer">Here's a site</a> that explains the vimrc and how to use it.  

#### Answer 2 (score 67)
<p><strong>To change the default setting to display line numbers in vi/vim:</strong>
<br/></p>

```vim
vi ~/.vimrc
```

then add the following line to the file:  

```vim
set number
```

Either we can `source ~/.vimrc` or save and quit by `:wq`, now future vi/vim sessions will have numbering :)  

#### Answer 3 (score 10)
Terminal > `su` > `password` > `vim /etc/vimrc`  

Click here and edit as in line number (13):  

```vim
set nu
```

<img src="https://i.stack.imgur.com/qOjSC.png" alt="click here and Edit as &quot;Line number (13)&quot;">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: How can I install MacVim on OS X? (score [146996](https://stackoverflow.com/q/21012203) in 2016)

#### Question
I am using OS X 10.9.1 (Mavericks).  

What are the systematic steps to install to Gvim or MacVim in Mac OS? If you write the steps using 1, 2, 3, ..., it would be easy to follow.   

<p>I must confess that I failed to understand all the instructions provided on MacVim page. Other google-searched webpages do not clarify. 
E.g. </p>

<p>What is `$VIMRUNTIME` ? 
What version of vim should I install for my OS? </p>

<p>Now somehow I have installed MacVim in my system (Not systematically I believe).
I can see that I have a folder `/Applications/gvim.app/MacVim.app/`. </p>

Now when I open a text file from MacVim, which was already written using vi-editor, MacVim does not recognize it. Also vi does not recognize whatever is written in MacVim!   

How can I resolve this?  

#### Answer accepted (score 249)
<ul>
<li>Step 1. Install homebrew from here: <a href="http://brew.sh" rel="noreferrer">http://brew.sh</a></li>
<li>Step 1.1. Run `export PATH=/usr/local/bin:$PATH`</li>
<li>Step 2. Run `brew update`</li>
<li>Step 3. Run `brew install vim &amp;&amp; brew install macvim`</li>
<li>Step 4. Run `brew link macvim`</li>
</ul>

You now have the latest versions of vim and macvim managed by brew. Run `brew update &amp;&amp; brew upgrade` every once in a while to upgrade them.  

This includes the installation of the CLI `mvim` and the mac application (which both point to the same thing).  

I use this setup and it works like a charm. Brew even takes care of installing vim with the preferable options.  

#### Answer 2 (score 30)
There is also a new option now in <a href="http://vimr.org/">http://vimr.org/</a>, which looks quite promising.  

#### Answer 3 (score 15)
<ol>
<li><p>Download the latest build from <a href="https://github.com/macvim-dev/macvim/releases" rel="nofollow noreferrer">https://github.com/macvim-dev/macvim/releases</a></p></li>
<li><p>Expand the archive.</p></li>
<li><p>Put MacVim.app into `/Applications/`.</p></li>
</ol>

Done.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: How can I autoformat/indent C code in vim? (score [146498](https://stackoverflow.com/q/2355834) in 2015)

#### Question
When I copy code from another file, the formatting is messed up, like this:  

```vim
fun()
{
for(...)
{
for(...)
{
if(...)
{
}
}
}
}
```

How can I autoformat this code in vim?  

#### Answer accepted (score 539)
Try the following keystrokes:  

```vim
gg=G
```

Explanation: `gg` goes to the top of the file, `=` is a command to fix the indentation and `G` tells it to perform the operation to the end of the file.  

#### Answer 2 (score 77)
I like to use the program Artistic Style. According to their <a href="http://astyle.sourceforge.net/" rel="noreferrer">website</a>:  

<blockquote>
  Artistic Style is a source code indenter, formatter, and beautifier for the C, C++, C# and Java programming languages.  
</blockquote>

It runs in Window, Linux and Mac. It will do things like indenting, replacing tabs with spaces or vice-versa, putting spaces around operations however you like (converting `if(x&lt;2)` to if `( x&lt;2 )` if that's how you like it), putting braces on the same line as function definitions, or moving them to the line below, etc. All the options are controlled by command line parameters.  

In order to use it in vim, just set the formatprg option to it, and then use the gq command. So, for example, I have in my .vimrc:  

```vim
autocmd BufNewFile,BufRead *.cpp set formatprg=astyle\ -T4pb
```

so that whenever I open a .cpp file, formatprg is set with the options I like. Then, I can type gg to go to the top of the file, and <kbd>g</kbd><kbd>q</kbd><kbd>G</kbd> to format the entire file according to my standards. If I only need to reformat a single function, I can go to the top of the function, then type <kbd>g</kbd><kbd>q</kbd><kbd>]</kbd><kbd>[</kbd> and it will reformat just that function.  

The options I have for astyle, `-T4pb`, are just my preferences. You can look through <a href="http://astyle.sourceforge.net/astyle.html" rel="noreferrer">their docs</a>, and change the options to have it format the code however you like.  

Here's a demo. Before astyle:  

```vim
int main(){if(x<2){x=3;}}

float test()
{
if(x<2)
x=3;
}
```

After astyle (gggqG):  

```vim
int main()
{
    if (x < 2)
    {
        x = 3;
    }
}

float test()
{
    if (x < 2)
        x = 3;
}
```

Hope that helps.  

#### Answer 3 (score 56)
The OP asked for auto-formatting, but accepted an answer that does auto-indenting only.  

Here is the difference:  

<blockquote>
  <strong>ORIGINAL</strong>  
</blockquote>

```vim
int main(){if(x<2){x=3;}}

float test()
{
if(x<2)
x=3;
}
```

<blockquote>
  <strong>AUTOINDENT</strong>  
</blockquote>

```vim
int main(){if(x<2){x=3;}}

float test()
{
    if(x<2)
        x=3;
}
```

<blockquote>
  <strong>AUTOFORMAT</strong>  
</blockquote>

```vim
int main()
{
    if (x < 2)
    {
        x = 3;
    }
}

float test()
{
    if (x < 2)
        x = 3;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: Vim for Windows - What do I type to save and exit from a file? (score [145559](https://stackoverflow.com/q/4708645) in 2019)

#### Question
Using Windows&nbsp;XP I accidentally typed `git commit -a` instead of `git commit -am "My commit message"`, and now I'm viewing my CMD prompt filled with the file version of my commit message ("Please enter the commit message for your..."). I've added my message to the top, but now I can't figure out how to save and leave. I tried to press <kbd>Ctrl</kbd> + <kbd>W</kbd> + <kbd>Q</kbd>, but it doesn't do anything, but add `^` where the cursor is.  

I also tried <kbd>Esc</kbd> first, and then <kbd>Ctrl</kbd> + <kbd>W</kbd> + <kbd>Q</kbd>, but it says `No write since last change (add ! to override)`.  

#### Answer accepted (score 495)
Press <kbd>ESC</kbd> to make sure you are out of the edit mode and then type:  

```vim
:wq
```

#### Answer 2 (score 51)
Instead of telling you how you could execute a certain command (<kbd>Esc</kbd><kbd>:</kbd><kbd>w</kbd><kbd>q</kbd>), I can provide you two links that may help you with VIM:  

<ul>
<li><a href="http://bullium.com/support/vim.html" rel="nofollow noreferrer">http://bullium.com/support/vim.html</a> provides an HTML quick reference card</li>
<li><a href="http://tnerual.eriogerg.free.fr/vim.html" rel="nofollow noreferrer">http://tnerual.eriogerg.free.fr/vim.html</a> provides a PDF quick reference card in several languages, optimized for print-out, fold and put on your desk drawer</li>
</ul>

However, the best way to learn Vim is not only using it for Git commits, but as a regular editor for your everyday work.  

If you're not going to switch to Vim, it's nonsense to keep its commands in mind. In that case, go and <a href="https://stackoverflow.com/questions/10564/how-can-i-set-up-an-editor-to-work-with-git-on-windows">set up your favourite editor to use with Git</a>.  

#### Answer 3 (score 35)
<kbd>Esc</kbd> to make sure you exit insert mode, then `:wq` (colon w q) or `ZZ` (shift-Z shift-Z).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Searching word in vim? (score [145070](https://stackoverflow.com/q/458915) in 2013)

#### Question
I can search word in vim with `/word`. How can I search only for `word`, excluding searches for `word1` and `word2`?  

#### Answer accepted (score 180)
like this:  

```vim
/\<word\>
```

`\&lt;` means beginning of a word, and `\&gt;` means the end of a word,  

<p>Adding @Roe's comment:<br>
VIM provides a shortcut for this.  If you already have <em>word</em> on screen and you want to find other instances of it, you can put the cursor on the word and press `'*'` to search forward in the file or `'#'` to search backwards.</p>

#### Answer 2 (score 59)
<ol>
<li>vim filename </li>
<li>press /</li>
<li>type word which you want to search</li>
<li>press Enter </li>
</ol>

#### Answer 3 (score 20)
If you are working in Ubuntu,follow the steps:  

<ol>
<li>Press `/` and type word to search</li>
<li>To search in forward press 'SHIFT' key with  `*` key</li>
<li>To search in backward press 'SHIFT' key with `#` key </li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: How to stop line breaking in vim (score [143730](https://stackoverflow.com/q/2280030) in 2012)

#### Question
I like that the long lines are displayed over more than one terminal line;  I don’t like that vim inserts newlines into my actual text. Which part of .vimrc I should change?  

#### Answer 2 (score 283)
Use   

```vim
:set wrap
```

To wrap lines visually, i.e. the line is still one line of text, but Vim displays it on multiple lines.  

Use  

```vim
:set nowrap
```

To display long lines as just one line (i.e. you have to scroll horizontally to see the entire line).   

#### Answer 3 (score 188)
<blockquote>
  I like that the long lines are displayed over more than one terminal line  
</blockquote>

This sort of visual/virtual line wrapping is enabled with the `wrap` window option:  

```vim
set wrap
```

<blockquote>
  I don’t like that vim inserts newlines into my actual text.   
</blockquote>

To turn off physical line wrapping, clear both the `textwidth` and `wrapmargin` buffer options:  

```vim
set textwidth=0 wrapmargin=0
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: Using Vim's tabs like buffers (score [142309](https://stackoverflow.com/q/102384) in 2012)

#### Question
I have looked at the ability to use tabs in Vim (with `:tabe`, `:tabnew`, etc.) as a replacement for my current practice of having many files open in the same window in hidden buffers.  

I would like every distinct file that I have open to always be in its own tab. However, there are some things that get in the way of this. How do I fix these:  

<ol>
<li><p>When commands like `gf` and `^]` jump to a location in another file, the file opens in a new buffer in the current tab. Is there a way to have all of these sorts of commands open the file in a new tab, or switch to the existing tab with the file if it is already open?</p></li>
<li><p>When switching buffers I can use
`:b &lt;part of filename&gt;&lt;tab&gt;`
and it will complete the names of files in existing buffers. `&lt;part of filename&gt;` can even be the middle of a filename instead of the beginning. Is there an equivalent for switching tabs?</p></li>
</ol>

#### Answer accepted (score 608)
Stop, stop, stop.  

This is not how Vim's tabs are designed to be used. In fact, they're misnamed. A better name would be "viewport" or "layout", because that's what a tab is&mdash;it's a different layout of windows of <em>all</em> of your existing buffers.  

Trying to beat Vim into 1 tab == 1 buffer is an exercise in futility. Vim doesn't know or care and it will not respect it on all commands&mdash;in particular, anything that uses the quickfix buffer (`:make`, `:grep`, and `:helpgrep` are the ones that spring to mind) will happily ignore tabs and there's nothing you can do to stop that.  

Instead:    

<ul>
<li>`:set hidden`<br>
If you don't have this set already, then do so. It makes vim work like every other multiple-file editor on the planet. You can have edited buffers that aren't visible in a window somewhere.</li>
<li>Use `:bn`, `:bp`, `:b #`, `:b name`, and `ctrl-6` to switch between buffers. I like `ctrl-6` myself (alone it switches to the previously used buffer, or `#ctrl-6` switches to buffer number `#`).</li>
<li>Use `:ls` to list buffers, or a plugin like <a href="https://github.com/fholgado/minibufexpl.vim" rel="noreferrer">MiniBufExpl</a> or <a href="http://www.vim.org/scripts/script.php?script_id=42" rel="noreferrer">BufExplorer</a>.</li>
</ul>

#### Answer 2 (score 270)
Bit late to the party here but surprised I didn't see the following in this list:  

`:tab sball` - this opens a new tab for each open buffer.  

`:help switchbuf` - this controls buffer switching behaviour, try `:set switchbuf=usetab,newtab`. This should mean switching to the existing tab if the buffer is open, or creating a new one if not.  

#### Answer 3 (score 162)
Vim `:help window` explains the confusion "tabs vs buffers" pretty well.  

<blockquote>
  <p>A buffer is the in-memory text of a file.<br>
   A window is a viewport
   on a buffer.<br>
  A tab page is a collection of windows.</p>
</blockquote>

Opening multiple files is achieved in vim with <strong>buffers</strong>. In other editors (e.g. notepad++) this is done with tabs, so the name tab in vim maybe misleading.   

<strong>Windows</strong> are for the purpose of splitting the workspace and displaying multiple files (buffers) together on one screen. In other editors this could be achieved by opening multiple GUI windows and rearranging them on the desktop.   

Finally in this analogy vim's <strong>tab pages</strong> would correspond to multiple desktops, that is different rearrangements of windows.  

As vim `help: tab-page` explains a tab page can be used, when one wants to temporarily edit a file, but does not want to change anything in the current layout of windows and buffers. In such a case another tab page can be used just for the purpose of editing that particular file.  

Of course you have to remember that displaying the same file in many tab pages or windows would result in displaying the same working copy (buffer).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: delete word after or around cursor in VIM (score [140526](https://stackoverflow.com/q/833838) in 2019)

#### Question
I'm now switching to `VIM` from TextMate. I found `^+W` in INSERT mode very useful. However, I'd like to delete not only the word before cursor, but the word after or around cursor as well.  

I did some googling, but the only thing I can find was `^+W` to delete word BEFORE cursor.  

#### Answer accepted (score 74)
What you should do is create an imap of a certain key to a series of commands, in this case the commands will drop you into normal mode, delete the current word and then put you back in insert:  

```vim
:imap <C-d> <C-[>diwi
```

#### Answer 2 (score 510)
Normal mode:   

```vim
daw : delete the word under the cursor    
caw : delete the word under the cursor and put you in insert mode 
```

#### Answer 3 (score 97)
I think it's just `daw`  

```vim
daw - delete a word
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Tips for using Vim as a Java IDE? (score [138495](https://stackoverflow.com/q/253170) in 2013)

#### Question
I'm addicted to Vim, it's now my de facto way of editing text files.  

Being that it's mainly a text editor and not an IDE, has anyone got tricks for me to make it easier when developing Java apps?  

Some questions I have:  

<ul>
<li>How do I invoke a maven task without leaving vi?</li>
<li>Can I get code completion?</li>
<li>How's the syntax highlighting?</li>
</ul>

Anything else (other than "Don't do it!") that I should know about?  

#### Answer accepted (score 75)
Some tips:  

<ul>
<li>Make sure you use vim (vi improved). Linux and some versions of UNIX symlink vi to vim.</li>
<li>You can get code completion with <a href="http://eclim.sourceforge.net/" rel="noreferrer">eclim</a></li>
<li>Or you can get vi functionality within Eclipse with <a href="http://viplugin.com/" rel="noreferrer">viPlugin</a></li>
<li>Syntax highlighting is great with vim</li>
<li>Vim has good support for writing little macros like running ant/<a href="http://vim.wikia.com/wiki/Use_maven_with_quickfix" rel="noreferrer">maven</a> builds</li>
</ul>

Have fun :-)  

#### Answer 2 (score 30)
I've been a Vim user for years.  I'm starting to find myself starting up Eclipse occasionally (using the vi plugin, which, I have to say, has a variety of issues).  The main reason is that Java builds take quite a while...and they are just getting slower and slower with the addition of highly componentized build-frameworks like maven.  So validating your changes tends to take quite a while, which for me seems to often lead to stacking up a bunch of compile issues I have to resolve later, and filtering through the commit messages takes a while.  

When I get too big of a queue of compile issues, I fire up Eclipse.  It lets me make cake-work of the changes.  It's slow, brutal to use, and not nearly as nice of an editor as Vim is (I've been using Vim for nearly a decade, so it's second nature to me).  I find for precision editing&mdash;needing to fix a specific bug, needing to refactor some specific bit of logic, or something else...I simply can't be as efficient at editing in Eclipse as I can in Vim.  

Also a tip:  

```vim
:set path=**
:chdir your/project/root
```

This makes `^wf` on a classname a very nice feature for navigating a large project.  

So anyway, the skinny is, when I need to add a lot of new code, Vim seems to slow me down simply due to the time spent chasing down compilation issues and similar stuff.  When I need to find and edit specific sources, though, Eclipse feels like a sledge hammer.  I'm still waiting for the magical IDE for Vim.  There's been three major attempts I know of.  There's a pure viml IDE-type plugin which adds a lot of features but seems impossible to use.  There's eclim, which I've had a lot of trouble with.  And there's a plugin for Eclipse which actually embeds Vim.  The last one seems the most promising for real serious Java EE work, but it doesn't seem to work very well or really integrate all of Eclipse's features with the embedded Vim.  

Things like add a missing import with a keystroke, hilight code with typing issues, etc, seems to be invaluable from your IDE when working on a large Java project.  

#### Answer 3 (score 22)
<ul>
<li><p><em>How do I invoke a maven task without leaving vi?</em></p>

Maven is no different than any other shell command:  

`:!mvn`  

You can `:set makeprg=mvn` if you already have a favourite key mapping for `:make`.  </li>
<li><p><em>Can I get code completion?</em></p>

Yes, <a href="http://eclim.sourceforge.net/" rel="noreferrer">eclim</a> is great, a bridge between vim's editing efficiency and Eclipse's Java language-specific awareness.  

`&lt;C-n&gt;` and `&lt;C-p&gt;` are not-so-great, but amazingly helpful.  </li>
<li><p>How's the syntax highlighting?</p>

More than good enough for a regex-based highligher.  </li>
</ul>

You may want to consider tools for other vim+java purposes, like code templates (<a href="http://vim.sourceforge.net/scripts/script.php?script_id=1318" rel="noreferrer">snippetEmu</a>&mdash;default snippets suck, but customizability shines), searching for usages and going to declarations (eclim, grep, ctags), generating getters and setters (<a href="http://www.vim.org/scripts/script.php?script_id=490" rel="noreferrer">java_getset</a>, or eclim), automatic imports (eclim).  You might also need a java shell for quick experiments (the <a href="http://www.beanshell.org/" rel="noreferrer">BeanShell</a>, a.k.a. `bsh`).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: A more useful statusline in vim? (score [133810](https://stackoverflow.com/q/5375240) in 2013)

#### Question
I’d like to make my statusline in vim more informative and interesting, and for that I need some ideas. How did you customize your statusline?  

#### Answer accepted (score 58)
Pretty nice stuff for statuslines here:  

<ul>
<li><a href="http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html" rel="noreferrer">http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html</a></li>
<li><a href="http://got-ravings.blogspot.com/search/label/statuslines" rel="noreferrer">http://got-ravings.blogspot.com/search/label/statuslines</a></li>
</ul>

#### Answer 2 (score 129)
<blockquote>
  Edit:-  
  
  <p>Note <a href="https://github.com/bling/vim-airline" rel="noreferrer">vim-airline</a> is gaining
  some traction as the new vimscript option as powerline has gone
  python.</p>
</blockquote>

<hr>

Seems <a href="https://github.com/Lokaltog/powerline" rel="noreferrer">powerline</a> is where it is at these days:-  

<strong>Normal status line</strong>  

<img src="https://i.imgur.com/QIdac.png" alt="powerline">  

<strong>Customised status lines for other plugins (e.g. <a href="https://github.com/kien/ctrlp.vim" rel="noreferrer">ctrlp</a>)</strong>  

<img src="https://i.imgur.com/pxtQj.png" alt="powerline">  

#### Answer 3 (score 57)
Here's mine:  

```vim
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor
```

<img src="https://i.stack.imgur.com/yTNvD.png" alt="vim statusline">  

And here's the colors I used:  

```vim
hi User1 guifg=#eea040 guibg=#222222
hi User2 guifg=#dd3333 guibg=#222222
hi User3 guifg=#ff66ff guibg=#222222
hi User4 guifg=#a0ee40 guibg=#222222
hi User5 guifg=#eeee40 guibg=#222222
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: Setting up Vim for Python (score [133193](https://stackoverflow.com/q/9172802) in 2016)

#### Question
I really like the Emacs editor for Python because of it's smart tabbing for instance if I have something like this  

```vim
def foo():
    if bar:
         blah
         [b]eep
```

and I press tab on the cursor (which is on the b of beep), it will not insert a new tab causing a syntax error but it would toggle through the possible levels that beep can be on. Is there anyway of getting this effect on Vim?  

#### Answer 2 (score 92)
In general, vim is a very powerful <strong>regular language</strong> editor (macros extend this but we'll ignore that for now).  This is because vim's a thin layer on top of ed, and ed isn't much more than a line editor that speaks regex.  Emacs has the advantage of being built on top of ELisp; lending it the ability to easily parse complex grammars and perform indentation tricks like the one you shared above.  

To be honest, I've never been able to dive into the depths of emacs because it is simply delightful meditating within my vim cave.  With that said, let's jump in.  

<h5>Getting Started</h3>

<em>Janus</em>  

For beginners, I highly recommend installing the readymade <a href="https://github.com/carlhuda/janus" rel="noreferrer">Janus plugin</a> (fwiw, the name hails from a Star Trek episode featuring Janus Vim).  If you want a quick shortcut to a vim IDE it's your best bang for your buck.  

I've never used it much, but I've seen others use it happily and my current setup is borrowed heavily from an old Janus build.  

<em>Vim Pathogen</em>  

Otherwise, do some exploring on your own!  I'd highly recommend installing <a href="https://github.com/tpope/vim-pathogen" rel="noreferrer">vim pathogen</a> if you want to see the universe of vim plugins.  

It's a package manager of sorts.  Once you install it, you can `git clone` packages to your `~/.vim/bundle` directory and they're auto-installed.  No more plugin installation, maintenance, or uninstall headaches!  

You can run the following script from the GitHub page to install pathogen:  

```vim
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -so ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
```

<h5>Helpful Links</h3>

Here are some links on extending vim I've found and enjoyed:  

<ul>
<li><strike><a href="http://www.sontek.net/blog/2011/05/07/turning_vim_into_a_modern_python_ide.html" rel="noreferrer">Turning Vim Into A Modern Python IDE</a></strike></li>
<li><a href="http://blog.dispatched.ch/2009/05/24/vim-as-python-ide/" rel="noreferrer">Vim As Python IDE</a></li>
<li><a href="http://blog.coredumped.org/2010/01/osx-vim-and-python.html" rel="noreferrer">OS X And Python</a> (osx specific)</li>
<li><a href="http://learnvimscriptthehardway.stevelosh.com/" rel="noreferrer">Learn Vimscript The Hard Way</a> (great book if you want to learn vimscript)</li>
</ul>

#### Answer 3 (score 26)
For those arriving around summer 2013, I believe some of this thread is outdated.  

I followed <a href="http://unlogic.co.uk/2013/02/08/vim-as-a-python-ide/">this howto</a> which recommends Vundle over Pathogen. After one days use I found installing plugins trivial.  

The klen/python-mode plugin deserves special mention. It provides pyflakes and pylint amongst other features.  

I have just started using Valloric/YouCompleteMe and I love it. It has C-lang auto-complete and python also works great thanks to jedi integration. It may well replace jedi-vim as per this discussion /davidhalter/jedi-vim/issues/119  

Finally browsing the /carlhuda/janus plugins supplied is a good guide to useful scripts you might not know you are looking for such as NerdTree, vim-fugitive, syntastic, powerline, ack.vim, snipmate...  

All the above '{}/{}' are found on github you can find them easily with Google.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: How to expand/collapse a diff sections in Vimdiff? (score [132951](https://stackoverflow.com/q/5288875) in 2018)

#### Question
I've started using vimdiff today, and wanted to do some of the things that I've taken for granted on Windows based diff editors (like expand/collapse a diff section, have full file expansion/only diffs with 3 context lines above or below, etc.). I currently know only the following commands :  

Keyboard Shortcuts:  

<ul>
<li><p><kbd>d</kbd><kbd>o</kbd> - Get changes from other window into the current window.</p></li>
<li><p><kbd>d</kbd><kbd>p</kbd> - Put the changes from current window into the other window.</p></li>
<li><p><kbd>]</kbd><kbd>c</kbd> - Jump to the next change.</p></li>
<li><p><kbd>[</kbd><kbd>c</kbd> - Jump to the previous change.</p></li>
<li><p><kbd>CTRL</kbd>+<kbd>W</kbd>, <kbd>w</kbd> - Switch to the other split window (<kbd>CTRL</kbd>+<kbd>W</kbd>, <kbd>CTRL</kbd>+<kbd>W</kbd> does the same
thing, in case you let go of the <kbd>CTRL</kbd> key a bit later)</p></li>
</ul>

Could someone point me to the right direction so I could replicate similar features?  

It would be nice if I could expand/collapse lines around the diffs, for example.  

#### Answer accepted (score 232)
Aside from the ones you mention, I only use frequently when diffing the following:  

<ul>
<li>`:diffupdate` `:diffu` -> recalculate the diff, useful when after making several changes vim's isn't showing minimal changes anymore. Note that it only works if the files have been modified inside vimdiff. Otherwise, use:
<ul>
<li>`:e` to reload the files if they have been modified outside of vimdiff. </li>
</ul></li>
<li>`:set noscrollbind` -> temporarily disable simultaneous scrolling on both buffers, reenable by `:set scrollbind` and scrolling.</li>
</ul>

Most of what you asked for is folding: <a href="http://vimdoc.sourceforge.net/htmldoc/usr_28.html">vim user manual's chapter on folding</a>. Outside of diffs I sometime use:  

<ul>
<li>`zo` -> open fold.</li>
<li>`zc` -> close fold.</li>
</ul>

But you'll probably be better served by:  

<ul>
<li>`zr` -> reducing folding level.</li>
<li>`zm` -> one more folding level, please.</li>
</ul>

or even:  

<ul>
<li>`zR` -> Reduce completely the folding, I said!.</li>
<li>`zM` -> fold Most!.</li>
</ul>

The other thing you asked for, use n lines of folding, can be found at the <a href="http://vimdoc.sourceforge.net/htmldoc/options.html#%27diffopt%27">vim reference manual section on options</a>, via the <a href="http://vimdoc.sourceforge.net/htmldoc/diff.html#diff-options">section on diff</a>:  

<ul>
<li>`set diffopt=&lt;TAB&gt;`, then update or add `context:n`.</li>
</ul>

You should also take a look at the <a href="http://vimdoc.sourceforge.net/htmldoc/usr_08.html#08.7">user manual section on diff</a>.  

#### Answer 2 (score 4)
set vimdiff to ignore case  

Having started vim diff with  

```vim
 gvim -d main.sql backup.sql &
```

I find that annoyingly one file has MySQL keywords in lowercase the other uppercase showing differences on practically every other line  

```vim
:set diffopt+=icase
```

this updates the screen dynamically &amp; you can just as easily switch it off again  

#### Answer 3 (score 3)
Actually if you do `Ctrl+W W`, you won't need to add that extra `Ctrl`. Does the same thing.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: To switch from vertical split to horizontal split fast in Vim (score [131069](https://stackoverflow.com/q/1269603) in 2011)

#### Question
<strong>How can you switch your current windows from horizontal split to vertical split and vice versa in Vim?</strong>  

I did that a moment ago by accident but I cannot find the key again.  

#### Answer accepted (score 851)
<a href="http://www.mail-archive.com/vim@vim.org/msg11206.html" rel="noreferrer">Vim mailing list</a> says (re-formatted for better readability):  

<blockquote>
  <p>To change <em>two</em> vertically split
  windows to horizonally split</p>
  
  <kbd>Ctrl</kbd>-<kbd>w</kbd> <kbd>t</kbd> <kbd>Ctrl</kbd>-<kbd>w</kbd> <kbd>K</kbd>  
  
  Horizontally to vertically:  
  
  <kbd>Ctrl</kbd>-<kbd>w</kbd> <kbd>t</kbd> <kbd>Ctrl</kbd>-<kbd>w</kbd> <kbd>H</kbd>  
  
  Explanations:  
  
  <kbd>Ctrl</kbd>-<kbd>w</kbd> <kbd>t</kbd>     makes the first (topleft) window current  
  
  <kbd>Ctrl</kbd>-<kbd>w</kbd> <kbd>K</kbd>     moves the current window to full-width at the very top  
  
  <kbd>Ctrl</kbd>-<kbd>w</kbd> <kbd>H</kbd>     moves the current window to full-height at far left  
</blockquote>

Note that the t is lowercase, and the K and H are uppercase.  

Also, with only two windows, it seems like you can drop the <kbd>Ctrl</kbd>-<kbd>w</kbd> <kbd>t</kbd> part because if you're already in one of only two windows, what's the point of making it current?  

#### Answer 2 (score 300)
<kbd>Ctrl</kbd>-<kbd>w</kbd> followed by <kbd>H</kbd>, <kbd>J</kbd>, <kbd>K</kbd> or <kbd>L</kbd> (capital) will move the current window to the far `left`, `bottom`, `top` or `right` respectively like normal cursor navigation.  

The lower case equivalents move focus instead of moving the window.  

#### Answer 3 (score 42)
When you have two <em>or more</em> windows open horizontally or vertically and want to switch them <em>all</em> to the other orientation, you can use the following:  

(switch to horizontal)  

```vim
:windo wincmd K
```

(switch to vertical)  

```vim
:windo wincmd H
```

It's effectively going to each window individually and using <kbd>^W</kbd><kbd>K</kbd> or <kbd>^W</kbd><kbd>H</kbd>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: How do I install a plugin for vim? (score [130513](https://stackoverflow.com/q/1639606) in )

#### Question
I'd like to try the plugin for Vim linked below. It adds syntax highlighting for `.haml` and (perhaps) `.sass` files.  

<a href="http://github.com/tpope/vim-haml" rel="noreferrer">http://github.com/tpope/vim-haml</a>  

I did this...  

```vim
$ cd ~/.vim
$ git clone git://github.com/tpope/vim-haml.git
```

I opened a `.haml` file in Vim, but there's no highlighting. There must be another step I need to perform.  

#### Answer accepted (score 52)
Those two commands will create a `~/.vim/vim-haml/` directory with the ftplugin, syntax, etc directories in it. Those directories need to be immediately in the `~/.vim` directory proper or `~/.vim/vim-haml` needs to be added to the list of paths that vim searches for plugins.  

<strong>Edit:</strong>  

I recently decided to tweak my vim config and in the process wound up writing the following rakefile. It only works on Mac/Linux, but the advantage over `cp` versions is that it's completely safe (symlinks don't overwrite existing files, uninstall only deletes symlinks) and easy to keep things updated.  

```vim
# Easily install vim plugins from a source control checkout (e.g. Github)
#
# alias vim-install=rake -f ~/.vim/rakefile-vim-install
# vim-install
# vim-install uninstall

require 'ftools'
require 'fileutils'

task :default => :install
desc "Install a vim plugin the lazy way"
task :install do
  vim_dir      = File.expand_path("~/.vim")
  plugin_dir   = Dir.pwd

  if not (FileTest.exists? File.join(plugin_dir,".git") or
          FileTest.exists? File.join(plugin_dir,".svn") or
          FileTest.exists? File.join(plugin_dir,".hg"))
      puts "#{plugin_dir} isn't a source controlled directory. Aborting."
      exit 1
  end

  Dir['**/'].each do |d|
    FileUtils.mkdir_p File.join(vim_dir, d)
  end

  Dir["**/*.{txt,snippet,snippets,vim,js,wsf}"].each do |f|
    ln File.join(plugin_dir, f), File.join(vim_dir,f)
  end

  boldred = "\033[1;31m"
  clear = "\033[0m"
  puts "\nDone. Remember to #{boldred}:helptags ~/.vim/doc#{clear}"
end

task :uninstall do
  vim_dir      = File.expand_path("~/.vim")
  plugin_dir   = Dir.pwd
  Dir["**/*.{txt,snippet,snippets,vim}"].each do |f|
    safe_rm File.join(vim_dir, f)
  end
end

def nicename(path)
    boldgreen = "\033[1;32m"
    clear = "\033[0m"
    return "#{boldgreen}#{File.join(path.split('/')[-2..-1])}#{clear}\t"
end

def ln(src, dst)
    begin
        FileUtils.ln_s src, dst
        puts "    Symlink #{nicename src}\t => #{nicename dst}"
    rescue Errno::EEXIST
        puts "  #{nicename dst} exists! Skipping."
    end
end

def cp(src, dst)
  puts "    Copying #{nicename src}\t=> #{nicename dst}"
  FileUtils.cp src, dst
end

def safe_rm(target)
    if FileTest.exists? target and FileTest.symlink? target
        puts "    #{nicename target} removed."
        File.delete target
    else
        puts "  #{nicename target} is not a symlink. Skipping"
    end
end
```

#### Answer 2 (score 130)
Make sure that the actual `.vim` file is in `~/.vim/plugin/`  

#### Answer 3 (score 45)
To expand on Karl's reply, Vim looks in a specific set of directories for its runtime files.  You can see that set of directories via `:set runtimepath?`.  In order to tell Vim to also look inside `~/.vim/vim-haml` you'll want to add  

```vim
set runtimepath+=$HOME/.vim/vim-haml
```

to your `~/.vimrc`.  You'll likely also want the following in your `~/.vimrc` to enable all the functionality provided by vim-haml.  

```vim
filetype plugin indent on
syntax on
```

You can refer to the <a href="http://vimhelp.appspot.com/options.txt.html#%27runtimepath%27" rel="noreferrer">`'runtimepath'`</a> and <a href="http://vimhelp.appspot.com/filetype.txt.html#%3Afiletype" rel="noreferrer">`:filetype`</a> help topics in Vim for more information.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: How to temporarily exit Vim and go back (score [129430](https://stackoverflow.com/q/1879219) in 2019)

#### Question
How could I exit Vim, not `:q`, and then go back to continue editing?  

#### Answer accepted (score 544)
Assuming terminal Vim on a flavor of *nix:  

<h5>To suspend your running Vim</h2>

<kbd>Ctrl</kbd> + <kbd>Z</kbd>  

will suspend the process and get back to your shell  

```vim
fg
```

will resume (bring to <strong>f</strong>ore<strong>g</strong>round) your suspended Vim.  

<h5>To start a new shell</h2>

Start a subshell using:  

```vim
:sh
```

(as configured by)  

```vim
:set shell?
```

<h5>or</h2>

```vim
:!bash
```

followed by:  

<kbd>Ctrl</kbd>+<kbd>D</kbd> (or `exit`, but why type so much?)  

to kill the shell and return to Vim.  

#### Answer 2 (score 104)
You can use `:sh` to exit to your default shell then typing `$ exit` at the shell prompt will return you to Vim.  

#### Answer 3 (score 33)
You can switch to shell mode temporarily by:  

```vim
:! <command>
```

such as  

```vim
:! ls
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: Vim: insert the same characters across multiple lines (score [127799](https://stackoverflow.com/q/9549729) in 2018)

#### Question
Sometimes I want to edit a certain visual block of text across multiple lines.  

For example I would take a text that looks like this:  

```vim
name
comment
phone
email
```

And make it looke like this  

```vim
vendor_name
vendor_comment
vendor_phone
vendor_email
```

Currently the way I would do it now is...  

<ol>
<li>Select all 4 row lines of block by pressing <kbd>V</kbd> and then <kbd>j</kbd> 4 times.</li>
<li>Indent with <kbd>></kbd>.</li>
<li>Go back one letter with <kbd>h</kbd>.</li>
<li>Go to block visual mode with <kbd>ctrl</kbd><kbd>v</kbd>.</li>
<li>Select down 4 rows by pressing <kbd>j</kbd> 4 times. At this point you have selected a 4x1 visual block of whitespace (4 rows, 1 cols).</li>
<li>Press <kbd>c</kbd>. Notice this pretty much indented to the left by one column.</li>
<li>Type out a `" vendor_"` without the quote. Notice the extra space we had to put back.</li>
<li>Press <kbd>esc</kbd>. This is one of the very few times I use <kbd>esc</kbd> to get out of insert mode. <kbd>ctrl</kbd><kbd>c</kbd> would only edit the first line.</li>
<li>Repeat step 1.</li>
<li>Indent the other way with <kbd>&lt;</kbd>.</li>
</ol>

I don't need to indent if there is at least one column of whitespace before the words. I wouldn't need the whitespace if I didn't have to clear the visual block with <kbd>c</kbd>.   

But if I have to clear, then is there a way to do what I performed above without creating the needed whitespace with indentation?  

Also why does editing multiple lines at once only work by exiting out of insert mode with <kbd>esc</kbd> over <kbd>ctrl</kbd><kbd>c</kbd>?  

<strong>Edit:</strong>  

Here is a more complicated example  

```vim
name    = models.CharField( max_length = 135 )
comment = models.TextField( blank = True )
phone   = models.CharField( max_length = 135, blank = True )
email   = models.EmailField( blank = True )
```

to  

```vim
name    = models.whatever.CharField( max_length = 135 )
comment = models.whatever.TextField( blank = True )
phone   = models.whatever.CharField( max_length = 135, blank = True )
email   = models.whatever.EmailField( blank = True )
```

in this example I would perform the vertical visual block over the `.`, then reinsert it back during insert mode, ie type `.whatever.`. Hopefully now you can see the drawback to this method. I am limited to only selecting a column of text <strong>that are all the same in a vertical position</strong>.  

#### Answer accepted (score 831)
<ol>
<li>Move the cursor to the `n` in `name`.</li>
<li>Enter visual block mode (<kbd>ctrl</kbd><kbd>v</kbd>).</li>
<li>Press <kbd>j</kbd> three times (or <kbd>3j</kbd>).</li>
<li>Press <kbd>`I`</kbd> (capital i).</li>
<li>Type in `vendor_`.</li>
<li>Press <kbd>esc</kbd>.</li>
</ol>

<img src="https://i.stack.imgur.com/T1WBi.gif" alt="mini-screencast demonstrating the method">  

An uppercase `I` must be used rather than a lowercase `i` because the lowercase `i` is interpreted as the start of a <a href="http://vimhelp.appspot.com/motion.txt.html#text-objects" rel="noreferrer">text object</a>, which is rather useful on its own, e.g. for selecting a inside a tag block (<a href="http://vimhelp.appspot.com/motion.txt.html#it" rel="noreferrer">`it`</a>):  

<img src="https://i.stack.imgur.com/nlwsZ.gif" alt="mini-screencast showing the usefulness of the it text object">  

#### Answer 2 (score 64)
Another approach is to use the <kbd>.</kbd> (`dot`) command in combination with <kbd>I</kbd>.  

<ol>
<li>Move the cursor where you want to start</li>
<li>Press <kbd>I</kbd></li>
<li>Type in the prefix you want (e.g. `vendor_`)</li>
<li>Press <kbd>esc</kbd>.</li>
<li>Press <kbd>j</kbd> to go down a line</li>
<li>Type <kbd>.</kbd> to repeat the last edit, automatically inserting the prefix again</li>
<li>Alternate quickly between <kbd>j</kbd> and <kbd>.</kbd></li>
</ol>

I find this technique is often faster than the visual block mode for small numbers of additions and has the added benefit that if you don't need to insert the text on every single line in a range you can easily skip them by pressing extra <kbd>j</kbd>'s.  

Note that for large number of contiguous additions, the block approach or macro will likely be superior.  

#### Answer 3 (score 31)
<ol>
<li>Select the lines you want to modify using <KBD>Ctrl</KBD><KBD>V</KBD>.<br></li>
<li><p>Press:</p>

<ul>
<li><KBD>I</KBD>: Insert before what's selected.</li>
<li><KBD>A</KBD>: Append after what's selected.</li>
<li><KBD>C</KBD>: Replace what's selected.</li>
</ul></li>
<li><p>Type the new text.<br></p></li>
<li>Press <KBD>Esc</KBD> to apply the changes to all selected lines.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: Using regular expressions to do mass replace in Notepad++ and Vim (score [126919](https://stackoverflow.com/q/287404) in 2015)

#### Question
So I've got a big text file which looks like the following:  

```vim
<option value value='1' >A
<option value value='2' >B
<option value value='3' >C
<option value value='4' >D
```

It's several hundred lines long and I really don't want to do it manually. The expression that I'm trying to use is:  

```vim
<option value='.{1,}' >
```

Which is working as intended when i run it through several online regular expression testers. I basically want to remove everything before A, B, C, etc. The issue is when I try to use that expression in Vim and Notepad++, it can't seem to find anything.  

#### Answer accepted (score 20)
Everything before the <strong>A</strong>, <strong>B</strong>, <strong>C</strong>, etc.  

That seems so simple I must be misinterpreting you. It's just  

```vim
:%s/<.*>//
```

#### Answer 2 (score 63)
In Notepad++ you don't need to use Regular Expressions for this.  

Hold down alt to allow you to select a rectangle of text across multiple rows at once. Select the chunk you want to be rid of, and press delete.  

#### Answer 3 (score 30)
<strong>In Notepad++ :</strong>  

```vim
<option value value='1' >A
<option value value='2' >B
<option value value='3' >C
<option value value='4' >D


Find what: (.*)(>)(.)
Replace with: \3

Replace All


A
B
C
D
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: How to cut an entire line in vim and paste it? (score [126646](https://stackoverflow.com/q/8773299) in 2012)

#### Question
I know how to use the `v` command in vim, but I need something which will delete an entire line and it should allow me to paste the same line somewhere else.  

#### Answer accepted (score 78)
Pressing <kbd>Shift</kbd>+<kbd>v</kbd> would select that entire line and pressing <kbd>d</kbd> would delete it.  

You can also use <kbd>d</kbd><kbd>d</kbd>, which is does not require you to enter visual mode.  

#### Answer 2 (score 387)
`dd` in command mode (after pressing escape) will cut the line, `p` in command mode will paste.  

Update:  

For a bonus, `d` and then a movement will cut the equivalent of that movement, so `dw` will cut a word, `d&lt;down-arrow&gt;` will cut this line and the line below, `d50w` will cut 50 words.  

`yy` is copy line, and works like `dd`.  

`D` cuts from cursor to end of line.  

If you've used `v` (visual mode), you should try `V` (visual line mode) and `&lt;ctrl&gt;v` (visual block mode).  

#### Answer 3 (score 16)
There are several ways to cut a line, all controlled by the `d` key in normal mode. If you are using visual mode (the `v` key) you can just hit the `d` key once you have highlighted the region you want to cut. Move to the location you would like to paste and hit the `p` key to paste.   

It's also worth mentioning that you can copy/cut/paste from registers. Suppose you aren't sure when or where you want to paste the text. You could save the text to up to 24 registers identified by an alphabetical letter. Just prepend your command with `'` (single quote) and the register letter (a thru z). For instance you could use the visual mode (`v` key) to select some text and then type `'ad` to cut the text and store it in register 'a'. Once you navigate to the location where you want to paste the text you would type `'ap` to paste the contents of register a.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Highlight all occurrence of a selected word? (score [126348](https://stackoverflow.com/q/3431184) in 2014)

#### Question
How can I highlight all occurrence of a selected word in GVim, like in Notepad++?  

#### Answer accepted (score 185)
In Normal mode:  

```vim
:set hlsearch
```

Then search for a pattern with the command `/` in Normal mode, or `&lt;Ctrl&gt;o` followed by `/` in Insert mode. `*` in Normal mode will search for the next occurrence of the word under the cursor. The `hlsearch` option will highlight all of them if set. `#` will search for the previous occurrence of the word.  

To remove the highlight of the previous search:  

```vim
:nohlsearch
```

You might wish to map `:nohlsearch&lt;CR&gt;` to some convenient key.  

#### Answer 2 (score 107)
The `*` key will highlight all occurrences of the word that is under the cursor.  

#### Answer 3 (score 22)
<p>I know than it's a really old question, but if someone is interested in this feature, can check this code
<a href="http://vim.wikia.com/wiki/Auto_highlight_current_word_when_idle" rel="noreferrer">http://vim.wikia.com/wiki/Auto_highlight_current_word_when_idle</a></p>

```vim
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
   let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     echo 'Highlight current word: off'
     return 0
  else
    augroup auto_highlight
    au!
    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
  return 1
 endif
endfunction
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: Working with huge files in VIM (score [125856](https://stackoverflow.com/q/1591723) in 2017)

#### Question
I tried opening a huge (~2GB) file in VIM but it choked. I don't actually need to edit the file, just jump around efficiently.  

How can I go about working with very large files in VIM?  

#### Answer 2 (score 84)
I had a 12GB file to edit today. The vim LargeFile plugin did not work for me. It still used up all my memory and then printed an error message :-(. I could not use hexedit for either, as it cannot insert anything, just overwrite. Here is an alternative approach:  

You split the file, edit the parts and then recombine it. You still need twice the disk space though.  

<ul>
<li><p>Grep for something surrounding the line you would like to edit:</p>

```vim
grep -n 'something' HUGEFILE | head -n 1
```</li>
<li><p>Extract that range of the file. Say the lines you want to edit are at line 4 and 5. Then do:</p>

```vim
sed -n -e '4,5p' -e '5q' HUGEFILE > SMALLPART
```

<ul>
<li>The `-n` option is required to suppress the default behaviour of sed to print everything</li>
<li>`4,5p` prints lines 4 and 5</li>
<li>`5q` aborts sed after processing line 5 </li>
</ul></li>
<li><p>Edit `SMALLPART` using your favourite editor.</p></li>
<li><p>Combine the file:</p>

```vim
(head -n 3 HUGEFILE; cat SMALLPART; sed -e '1,5d' HUGEFILE) > HUGEFILE.new 
```

<ul>
<li>i.e: pick all the lines before the edited lines from the HUGEFILE (which in this case is the top 3 lines), combine it with the edited lines (in this case lines 4 and 5) and use this combined set of lines to replace the equivalent (in this case the top 5 lines) in the HUGEFILE and write it all to a new file.</li>
</ul>

`HUGEFILE.new` will now be your edited file, you can delete the original `HUGEFILE`.  </li>
</ul>

#### Answer 3 (score 30)
This has been a recurring question for many years.  (The numbers keep changing, but the concept is the same: how do I view or edit files that are larger than memory?)  

Obviously `more` or `less` are  good approaches to merely reading the files --- `less` even offers `vi` like keybindings for scrolling and searching.  

A <a href="http://www.freshmeat.net/" rel="noreferrer">Freshmeat</a> search on "large files" suggests that two editors would be particularly suited to your needs.  

One would be: <a href="http://stoopidsimple.com/lfhex" rel="noreferrer">lfhex</a> ... a large file hex editor (which depends on Qt).  That one, obviously, entails using a GUI.  

Another would seem to be suited to console use: <a href="http://pasky.or.cz/~pasky/dev/hed/" rel="noreferrer">hed</a> ... and it claims to have a `vim`-like interface (including an `ex` mode?).  

I'm sure I've seen other editors for Linux/UNIX that were able to page through files without loading their entirety into memory.  However, I don't recall any of their names.  I'm making this response a "wiki" entry to encourage others to add their links to such editors.  (Yes, I am familiar with ways to work around the issue using `split` and `cat`; but I'm thinking of editors, especially console/curses editors which can dispense with that and save us the time/latencies and disk space overhead that such approaches entail).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: Move entire line up and down in Vim (score [123972](https://stackoverflow.com/q/741814) in 2015)

#### Question
In Notepad++, I can use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Up</kbd> / <kbd>Down</kbd> to move the current line up and down. Is there a similar command to this in Vim?  I have looked through endless guides, but have found nothing.  

If there isn't, how could I bind the action to that key combination?  

Edit: Mykola's answer works for all lines, apart from those at the beginning and end of the buffer. Moving the first line up or the bottom line down deletes the line, and when moving the bottom line up it jumps two spaces initially, like a pawn! Can anyone offer any refinements?  

#### Answer accepted (score 80)
Put the following to your .vimrc to do the job  

```vim
noremap <c-s-up> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
noremap <c-s-down> ddp
```

Disappearing of the line looks like a Vim bug. I put a hack to avoid it. Probably there is some more accurate solution.  

<strong>Update</strong>  

There are a lot of unexplained difficulties with just using Vim combinations. These are line missing and extra line jumping.  

So here is the scripting solution which can be placed either inside .vimrc or ~/.vim/plugin/swap_lines.vim  

```vim
function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

noremap <silent> <c-s-up> :call <SID>swap_up()<CR>
noremap <silent> <c-s-down> :call <SID>swap_down()<CR>
```

#### Answer 2 (score 550)
If I want to swap one line with the line above I usually do the following  

```vim
ddkP
```

Explanation  

<ul>
<li>dd will delete the line and add it to the default register.</li>
<li>k will move up a line (j would move down a line)</li>
<li>P will paste above the current line</li>
</ul>

#### Answer 3 (score 217)
Assuming the cursor is on the line you like to move.  

<p>Moving up and down:
<a href="http://vimdoc.sourceforge.net/htmldoc/change.html#:m">`:m`</a> for move</p>

`:m +1` - moves down 1 line  

`:m -2` - move up 1 lines  

(Note you can replace +1 with any numbers depending on how many lines you want to move it up or down, ie +2 would move it down 2 lines, -3 would move it up 2 lines)  

To move to specific line  

<a href="http://vimdoc.sourceforge.net/htmldoc/various.html#:number">`:set number`</a> - display number lines (easier to see where you are moving it to)  

`:m 3` - move the line after 3rd line (replace 3 to any line you'd like)  

Moving multiple lines:  

<a href="http://vimdoc.sourceforge.net/htmldoc/visual.html#V">`V`</a> (i.e. <kbd>Shift</kbd>-<kbd>V</kbd>) and move courser up and down to select multiple lines in VIM  

once selected hit <kbd>:</kbd> and run the commands above, `m +1` etc  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: Shortcut to open file in Vim (score [122748](https://stackoverflow.com/q/573039) in 2015)

#### Question
I want to open a file in Vim like in Eclipse using <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd>, or via the <kbd>Ctrl</kbd> + <kbd>N</kbd> option of autofill. Invoke a keyboard shortcut, type the file name/pattern, and choose from all the matching files names.  

I know opening it normally like:  

```vim
:tabe <filepath>
:new <filepath>
:edit <filepath>
```

The problem here is that I have to specify the whole file path in these cases.  

#### Answer accepted (score 59)
<p>I recently fell in love with <a href="http://www.vim.org/scripts/script.php?script_id=1984" rel="noreferrer">fuzzyfinder.vim
</a>... :-)</p>

<em>:FuzzyFinderFile</em> will let you open files by typing partial names or patterns.   

#### Answer 2 (score 140)
What I normally do is `e .` (e-space-dot) which gives me a browsable current directory - then I can `/` - search for name fragments, just like finding a word in a text file. I find that generally good enough, simple and quick.  

#### Answer 3 (score 33)
`:find` is another option.  

I open vim from the root of my project and have the `path` set to there.  

Then, I can open files located anywhere in the tree using:  

```vim
:find **/filena< tab >
```

Tab will autocomplete through various matches. (`**` tells it to search recursively through the path).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: How to go back (ctrl+z) in vi/vim (score [122634](https://stackoverflow.com/q/12436154) in 2017)

#### Question
In normal text editors [with all due respect to Vim] there is a shortcut <kbd>Ctrl</kbd>+<kbd>Z</kbd> when you have done something nasty and want to return to the previous version of the text. Like BACK button in Word. I wonder how can you achieve this behaviour in Vim.  

#### Answer accepted (score 143)
You can use the `u` button to undo the last modification. (And <kbd>Ctrl</kbd>+<kbd>R</kbd> to redo it).  

Read more about it at: <a href="http://vim.wikia.com/wiki/Undo_and_Redo" rel="noreferrer">http://vim.wikia.com/wiki/Undo_and_Redo</a>  

#### Answer 2 (score 7)
The answer, `u`, (and many others) is in `$ vimtutor`.  

#### Answer 3 (score 2)
<p>Here is a trick though. You can map the <kbd>Ctrl</kbd>+<kbd>Z</kbd> keys. 
This can be achieved by editing the `.vimrc` file. Add the following lines in the '.vimrc` file.</p>

```vim
nnoremap <c-z> :u<CR>      " Avoid using this**
inoremap <c-z> <c-o>:u<CR>
```

This may not the a preferred way, but can be used.  

** <kbd>Ctrl</kbd>+<kbd>Z</kbd> is used in Linux to suspend the ongoing program/process.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: How do I join two lines in vi? (score [122393](https://stackoverflow.com/q/1912905) in 2017)

#### Question
I have two lines in a text file like below:  

```vim
S<Switch_ID>_F<File type>
_ID<ID number>_T<date+time>_O<Original File name>.DAT
```

I want to append the two lines in vi like below:  

```vim
S<Switch_ID>_F<File type>_ID<ID number>_T<date+time>_O<Original File name>.DAT
```

The second line got deleted and the contents of the second line was appended to the first line.  

How could I do it using command mode in vi?  

#### Answer accepted (score 296)
<kbd>Shift</kbd>+<kbd>J</kbd> removes the line change character from the current line, so by pressing "J" at any place in the line you can combine the current line and the next line in the way you want.  

#### Answer 2 (score 58)
Vi or Vim?  

Anyway, the following command works for Vim in 'nocompatible' mode. That is, I suppose, almost pure vi.  

```vim
:join!
```

If you want to do it from normal command use  

```vim
gJ
```

With 'gJ' you join lines as is -- without adding or removing whitespaces:  

```vim
S<Switch_ID>_F<File type>
_ID<ID number>_T<date+time>_O<Original File name>.DAT
```

Result:  

```vim
S<Switch_ID>_F<File type>_ID<ID number>_T<date+time>_O<Original File name>.DAT
```

With 'J' command you will have:  

```vim
S<Switch_ID>_F<File type> _ID<ID number>_T<date+time>_O<Original File name>.DAT
```

Note space between `type&gt;` and `_ID`.  

#### Answer 3 (score 22)
This should do it:  

`J`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: How do I set the default font size in Vim? (score [121999](https://stackoverflow.com/q/17508542) in 2018)

#### Question
I am trying to configure the default settings for my GUI with Vim. I already made research on the web, but all the solutions I found and tried did not work.  

Here are some of the things I tried (in the .vimrc file):  

```vim
set guifont = Monaco:h20
set guifont=Monospace 20
```

Actually I don't care about the Monaco font.  

#### Answer accepted (score 194)
For the first one remove the spaces. Whitespace matters for the set command.  

```vim
set guifont=Monaco:h20
```

For the second one it should be (the h specifies the height)  

```vim
set guifont=Monospace:h20
```

My recommendation for setting the font is to do (if your version supports it)  

```vim
set guifont=*
```

This will pop up a menu that allows you to select the font. After selecting the font, type  

```vim
set guifont?
```

To show what the current guifont is set to. After that copy that line into your vimrc or gvimrc. If there are spaces in the font add a `\` to escape the space.  

```vim
set guifont=Monospace\ 20
```

#### Answer 2 (score 15)
Try a `\&lt;Space&gt;` before `12`, like so:  

```vim
:set guifont=Monospace\ 12
```

#### Answer 3 (score 0)
Add Regular to syntax and use `gfn`:  

<blockquote>
  set gfn= Monospace\ Regular:h13  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: How to convert all text to lowercase in Vim (score [121012](https://stackoverflow.com/q/1102859) in 2017)

#### Question
How do you convert all text in Vim to lowercase? Is it even possible?  

#### Answer accepted (score 118)
<ol>
<li><p>If you really mean <a href="https://www.google.com/search?q=small+caps&amp;tbm=isch" rel="noreferrer">small caps</a>, then no, that is not possible – just as it isn’t possible to convert text to bold or italic in any <a href="http://en.wikipedia.org/wiki/Text_editor" rel="noreferrer">text editor</a> (as opposed to <a href="http://en.wikipedia.org/wiki/Word_processor" rel="noreferrer">word processor</a>). If you want to convert text to lowercase, create a visual block and press `u` (or `U` to convert to uppercase). Tilde (`~`) in command mode reverses case of the character under the cursor.</p></li>
<li><p>If you want to see all text in Vim in small caps, you might want to look at the `guifont` option, or type `:set guifont=*` if your Vim flavour supports GUI font chooser.</p></li>
</ol>

#### Answer 2 (score 388)
I assume you want lowercase the text. Solution is pretty simple:  

```vim
ggVGu
```

Explanation:  

<ol>
<li><kbd>gg</kbd> - goes to first line of text</li>
<li><kbd>V</kbd> - turns on Visual selection, in line mode</li>
<li><kbd>G</kbd> - goes to end of file (at the moment you have whole text selected)</li>
<li><kbd>u</kbd> - lowercase selected area</li>
</ol>

#### Answer 3 (score 37)
Similar to mangledorf's solution, but shorter and layman friendly  

`:%s/.*/\L&amp;/g`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: What are the dark corners of Vim your mom never told you about? (score [120702](https://stackoverflow.com/q/726894) in 2017)

#### Question
There are a plethora of questions where people talk about common tricks, notably "<a href="https://stackoverflow.com/questions/563616/vimctags-tips-and-tricks">Vim+ctags tips and tricks</a>".  

However, I don't refer to commonly used shortcuts that someone new to Vim would find cool. I am talking about a seasoned Unix user (be they a developer, administrator, both, etc.), who thinks  they know something 99% of us never heard or dreamed about. Something that not only makes their work easier, but also is COOL and <strong>hackish</strong>. After all, <em>Vim</em> resides in the most dark-corner-rich OS in the world, thus it should have intricacies that only a few privileged know about and want to share with us.  

#### Answer 2 (score 772)
Might not be one that 99% of Vim users don't know about, but it's something I use daily and that any Linux+Vim poweruser must know.   

Basic command, yet extremely useful.  

```vim
:w !sudo tee %
```

I often forget to sudo before editing a file I don't have write permissions on. When I come to save that file and get a permission error, I just issue that vim command in order to save the file without the need to save it to a temp file and then copy it back again.  

You obviously have to be on a system with sudo installed and have sudo rights.  

#### Answer 3 (score 606)
Something I just discovered recently that I thought was very cool:  

```vim
:earlier 15m
```

Reverts the document back to how it was 15 minutes ago. Can take various arguments for the amount of time you want to roll back, and is dependent on undolevels. Can be reversed with the opposite command `:later`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: How to paste yanked text into Vim command line? (score [119495](https://stackoverflow.com/q/3997078) in 2015)

#### Question
I'd like to paste yanked text into Vim command line. Is it possible?  

#### Answer accepted (score 1107)
Yes. Hit <kbd>Ctrl</kbd>-<kbd>R</kbd> then <kbd>"</kbd>. If you have literal control characters in what you have yanked, use <kbd>Ctrl</kbd>-<kbd>R</kbd>, <kbd>Ctrl</kbd>-<kbd>O</kbd>, <kbd>"</kbd>.  

Here is an explanation of what you can do with registers. What you can do with registers is extraordinary, and once you know how to use them you cannot live without them.  

Registers are basically storage locations for strings. Vim has many registers that work in different ways:  

<ul>
<li>`0` (yank register: when you use `y` in normal mode, without specifying a register, yanked text goes there and also to the default register),</li>
<li>`1` to `9` (shifting delete registers, when you use commands such as `c` or `d`, what has been deleted goes to register 1, what was in register 1 goes to register 2, <em>etc.</em>),</li>
<li>`"` (default register, also known as unnamed register. This is where the <kbd>"</kbd> comes in <kbd>Ctrl</kbd>-<kbd>R</kbd>, <kbd>"</kbd>),</li>
<li>`a` to `z` for your own use (capitalized `A` to `Z` are for appending to corresponding registers).</li>
<li>`_` (acts like `/dev/null` (Unix) or `NUL` (Windows), you can write to it but it's discarded and when you read from it, it is always empty),</li>
<li>`-` (small delete register),</li>
<li>`/` (search pattern register, updated when you look for text with `/`, `?`, `*` or `#` for instance; you can also write to it to dynamically change the search pattern),</li>
<li>`:` (stores last VimL typed command via `Q` or `:`, readonly),</li>
<li>`+` and `*` (system clipboard registers, you can write to them to set the clipboard and read the clipboard contents from them)</li>
</ul>

See `:help registers` for the full reference.  

You can, at any moment, use `:registers` to display the contents of all registers. Synonyms and shorthands for this command are `:display`, `:reg` and `:di`.  

<p>In Insert or Command-line mode, <kbd>Ctrl</kbd>-<kbd>R</kbd> plus a register name, inserts the contents of this register. If you want to insert them literally (no auto-indenting, no conversion of control characters like `0x08` to backspace, etc), you can use <kbd>Ctrl</kbd>-<kbd>R</kbd>, <kbd>Ctrl</kbd>-<kbd>O</kbd>, register name.
See `:help i_CTRL-R` and following paragraphs for more reference.</p>

But you can also do the following (and I probably forgot many uses for registers).  

<ul>
<li><p>In normal mode, hit <kbd>"</kbd><kbd>:</kbd><kbd>p</kbd>. The last command you used in vim is pasted into your buffer.<br>
Let's decompose: `"` is a Normal mode command that lets you select what register is to be used during the next yank, delete or paste operation. So <kbd>"</kbd><kbd>:</kbd> selects the colon register (storing last command). Then <kbd>p</kbd> is a command you already know, it pastes the contents of the register.</p>

cf. `:help "`, `:help quote_:`  </li>
<li><p>You're editing a VimL file (for instance your `.vimrc`) and would like to execute a couple of consecutive lines right now: <kbd>y</kbd><kbd>j</kbd><kbd>:</kbd><kbd>@</kbd><kbd>"</kbd><kbd>Enter</kbd>.<br>
Here, <kbd>y</kbd><kbd>j</kbd> yanks current and next line (this is because j is a linewise motion but this is out of scope of this answer) into the default register (also known as the unnamed register). Then the `:@` Ex command plays Ex commands stored in the register given as argument, and `"` is how you refer to the unnamed register. Also see the top of this answer, which is related.</p>

Do not confuse `"` used here (which is a register name) with the `"` from the previous example, which was a Normal-mode command.  

cf. `:help :@` and `:help quote_quote`  </li>
<li><p>Insert the last search pattern into your file in Insert mode, or into the command line, with <kbd>Ctrl</kbd>-<kbd>R</kbd>, <kbd>/</kbd>.</p>

cf. `:help quote_/`, `help i_CTRL-R`    

Corollary: Keep your search pattern but add an alternative: `/` <kbd>Ctrl</kbd>-<kbd>R</kbd>, <kbd>/</kbd> `\|alternative`.  </li>
<li><p>You've selected two words in the middle of a line in visual mode, yanked them with `y`, they are in the unnamed register. Now you want to open a new line just below where you are, with those two words: `:pu`. This is shorthand for `:put "`. The `:put` command, like many Ex commands, works only linewise.</p>

cf. `:help :put`  

You could also have done: `:call setreg('"', @", 'V')` then `p`. The `setreg` function sets the register of which the name is given as first argument (as a string), initializes it with the contents of the second argument (and you can use registers as variables with the name `@x` where `x` is the register name in VimL), and turns it into the mode specified in the third argument, `V` for linewise, nothing for characterwise and literal `^V` for blockwise.  

cf. `:help setreg()`. The reverse functions are `getreg()` and `getregtype()`.  </li>
<li><p>If you have recorded a macro with `qa`...`q`, then `:echo @a` will tell you what you have typed, and `@a` will replay the macro (probably you knew that one, very useful in order to avoid repetitive tasks)</p>

cf. `:help q`, `help @`  

Corollary from the previous example: If you have `8go` in the clipboard, then `@+` will play the clipboard contents as a macro, and thus go to the 8th byte of your file. Actually this will work with almost every register. If your last inserted string was `dd` in Insert mode, then `@.` will (because the `.` register contains the last inserted string) delete a line. (Vim documentation is wrong in this regard, since it states that the registers `#`, `%`, `:` and `.` will only work with `p`, `P`, `:put` and <kbd>Ctrl</kbd>-<kbd>R</kbd>).  

cf. `:help @`  

Don't confuse `:@` (command that plays Vim commands from a register) and `@` (normal-mode command that plays normal-mode commands from a register).  

Notable exception is `@:`. The command register does not contain the initial colon neither does it contain the final carriage return. However in Normal mode, `@:` will do what you expect, interpreting the register as an Ex command, not trying to play it in Normal mode. So if your last command was `:e`, the register contains `e` but `@:` will reload the file, not go to end of word.  

cf. `:help @:`  </li>
<li><p>Show what you will be doing in Normal mode before running it: `@='dd'` <kbd>Enter</kbd>. As soon as you hit the `=` key, Vim switches to expression evaluation: as you enter an expression and hit <kbd>Enter</kbd>, Vim computes it, and the result acts as a register content. Of course the register `=` is read-only, and one-shot. Each time you start using it, you will have to enter a new expression.</p>

cf. `:help quote_=`  

Corollary: If you are editing a command, and you realize that you should need to insert into your command line some line from your current buffer: don't press <kbd>Esc</kbd>! Use <kbd>Ctrl</kbd>-<kbd>R</kbd> `=getline(58)` <kbd>Enter</kbd>. After that you will be back to command line editing, but it has inserted the contents of the 58th line.  </li>
<li><p>Define a search pattern manually: `:let @/ = 'foo'`</p>

cf. `:help :let`  

Note that doing that, you needn't to escape `/` in the pattern. However you need to double all single quotes of course.  </li>
<li><p>Copy all lines beginning with `foo`, and afterwards all lines containing `bar` to clipboard, chain these commands: `qaq` (resets the <em>a</em> register storing an empty macro inside it), `:g/^foo/y A`, `:g/bar/y A`, `:let @+ = @a`.</p>

Using a capital register name makes the register work in append mode  

Better, if `Q` has not been remapped by `mswin.vim`, start Ex mode with `Q`, chain those “colon commands” which are actually better called “Ex commands”, and go back to Normal mode by typing `visual`.  

cf. `:help :g`, `:help :y`, `:help Q`  </li>
<li><p>Double-space your file: `:g/^/put _`. This puts the contents of the black hole register (empty when reading, but writable, behaving like `/dev/null`) linewise, after each line (because every line has a beginning!).</p></li>
<li><p>Add a line containing `foo` before each line: `:g/^/-put ='foo'`. This is a clever use of the expression register. Here, `-` is a synonym for `.-1` (cf. `:help :range`). Since `:put` puts the text after the line, you have to explicitly tell it to act on the previous one.</p></li>
<li><p>Copy the entire buffer to the system clipboard: `:%y+`.</p>

cf. `:help :range` (for the `%` part) and `:help :y`.  </li>
<li><p>If you have misrecorded a macro, you can type `:let @a='` <kbd>Ctrl</kbd>-<kbd>R</kbd> `=replace(@a,"'","''",'g')` <kbd>Enter</kbd> `'` and edit it. This will modify the contents of the macro stored in register `a`, and it's shown here how you can use the expression register to do that.</p></li>
<li><p>If you did `dddd`, you might do `uu` in order to undo. With `p` you could get the last deleted line. But actually you can also recover up to 9 deletes with the registers `@1` through `@9`.</p>

Even better, if you do `"1P`, then `.` in Normal mode will play `"2P`, and so on.  

cf. `:help .` and `:help quote_number`  </li>
<li><p>If you want to insert the current date in Insert mode: <kbd>Ctrl</kbd>-<kbd>R</kbd>`=strftime('%y%m%d')`<kbd>Enter</kbd>.</p>

cf. `:help strftime()`  </li>
</ul>

Once again, what can be confusing:  

<ul>
<li>`:@` is a command-line command that interprets the contents of a register as vimscript and sources it</li>
<li><p>`@`  in normal mode command that interprets the contents of a register as normal-mode keystrokes (except when you use `:` register, that contains last played command without the initial colon: in this case it replays the command as if you also re-typed the colon and the final return key).</p></li>
<li><p>`"`  in normal mode command that helps you select a register for yank, paste, delete, correct, etc.</p></li>
<li>`"`  is also a valid register name (the default, or unnamed, register) and therefore can be passed as an arguments for commands that expect register names</li>
</ul>

#### Answer 2 (score 46)
For pasting something that is the system clipboard you can just use <KBD>SHIFT</KBD> - <KBD>INS</KBD>.  

It works in Windows, but I am guessing it works well in Linux too.  

#### Answer 3 (score 37)
"I'd like to paste yanked text into Vim command line."  

While the top voted answer is very complete, I prefer editing the command history.  

In normal mode, type: `q:`. This will give you a list of recent commands, editable and searchable with normal vim commands. You'll start on a blank command line at the bottom.  

For the exact thing that the article asks, pasting a yanked line (or yanked anything) into a command line, yank your text and then: `q:p` (get into command history edit mode, and then (p)ut your yanked text into a new command line. Edit at will, <kbd>enter</kbd> to execute.  

To get out of command history mode, it's the opposite. In normal mode in command history, type: `:q` + <kbd>enter</kbd>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Vim: copy selection to OS X clipboard (score [117584](https://stackoverflow.com/q/677986) in 2015)

#### Question
Say you've got an area selected in vim. How can you copy it into the OS X clipboard?  

(Hint: the OS X clipboard can be written to via pipe to `/usr/bin/pbcopy`)  

#### Answer accepted (score 77)
Depending on which version of vim I use, I'm able to use the + register to access the clipboard.  

<a href="http://vim.wikia.com/wiki/Mac_OS_X_clipboard_sharing" rel="noreferrer">http://vim.wikia.com/wiki/Mac_OS_X_clipboard_sharing</a> may have some ideas that work for you as well.  

#### Answer 2 (score 236)
For <a href="http://code.google.com/p/macvim/" rel="noreferrer">MacVim</a> and Windows Gvim, simply add the following to your `~/.vimrc`:  

```vim
set clipboard=unnamed
```

Now all operations such as `yy`, `D`, and `P` work with the clipboard. No need to prefix them with `"*` or `"+`.  

#### Answer 3 (score 134)
If the clipboard is enabled, you can copy a selected region to the clipboard by hitting `"*y`  

To see if it is enabled, o a vim --version and look for `+clipboard` or `-clipboard`.  For example, it's not enabled by default on my 10.5.6 box:  

<pre>% which vim
/usr/bin/vim
% vim --version
VIM - Vi IMproved 7.2 (2008 Aug 9, compiled Nov 11 2008 17:20:43)
Included patches: 1-22
Compiled by _www@b77.apple.com
Normal version without GUI.  <b>Features included (+) or not (-):</b>
<i>...</i>
-clientserver <b>-clipboard</b> +cmdline_compl +cmdline_hist +cmdline_info +comments
<i>...</i>
</pre>

If it had been compiled with `+clipboard`, I'd be able to use the `"*` register to access the system clipboard.  

I downloaded the <a href="ftp://ftp.vim.org/pub/vim/unix/vim-7.2.tar.bz2" rel="noreferrer">7.2 source</a> and compiled it (easy as `tar xjf vim-7.2.tar.bz &amp;&amp; cd vim72 &amp;&amp; ./configure &amp;&amp; make &amp;&amp; sudo make install`), and the clipboard was enabled:  

<pre>% which vim
/usr/local/bin/vim
% vim --version
VIM - Vi IMproved 7.2 (2008 Aug 9, compiled Mar 24 2009 17:31:52)
Compiled by rampion@Myrrhy.local
Normal version with GTK2 GUI.  <b>Features included (+) or not (-):</b>
<i>...</i>
+clientserver <b>+clipboard</b> +cmdline_compl +cmdline_hist +cmdline_info +comments
<i>...</i>
</pre>

However, even after compiling, I couldn't copy to the clipboard when running vim in Terminal.app, only in X11.app.  
</section>


<script src="../Css/js_prism_vim.js"></script>
