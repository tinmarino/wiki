---
title: Vim <- StackEchange top 100
category: vim
wiki_css: ../Css/code_prism_dark.css, ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How can I copy text to the system clipboard from Vim? (score [228296](https://stackoverflow.com/q/84) in 2015)

#### Question
Is there a way to copy a block of text to the system clipboard, so I can paste it in another program?  

#### Answer accepted (score 325)
<p>For <strong>X11</strong>-based systems (ie. <strong>Linux</strong> and most other <strong>UNIX</strong>-like systems)
there are two clipboards which are independent of each other:</p>

<ul>
<li>PRIMARY - This is copy-on-select, and can be pasted with the middle mouse
button.</li>
<li>CLIPBOARD - This is copied with (usually) `^C`, and pasted with `^V` (It's
like MS Windows).</li>
</ul>

<strong>OS X</strong> and <strong>Windows</strong> systems only have one clipboard.  

<p>For X11 systems there are also number of tools that synchronize these clipboards
for you; so if they appear to be the same, you may have one of them running.</p>

Vim has two special registers corresponding to these clipboards:  

<ul>
<li>`*` uses PRIMARY; mnemonic: <strong>S</strong>tar is <strong>S</strong>elect (for copy-on-<strong>s</strong>elect)</li>
<li>`+` uses CLIPBOARD; mnemonic: CTRL <strong>PLUS</strong> C (for the common keybind)</li>
</ul>

<p>On Windows &amp; OS X there is no difference between `+` and `*`, since these systems
only have a single clipboard, and both registers refer to the same thing (it
doesn't matter which one you use).</p>

<p>You can use these registers as any register. For example, using the PRIMARY
clipboard `*` with the `y` and `p` commands:</p>

<ul>
<li>`"*yy`</li>
<li>`"*p`</li>
</ul>

You could maybe use this as more convenient keybinds:  

```vim
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p
```

<p>If you want to "automatically" interface with the system's clipboard instead of
referring to it manually all the time, you can set the `clipboard` variable:</p>

<ul>
<li>Set it to `unnamed` to use `*` (PRIMARY, on select)</li>
<li>Set it to `unnamedplus` to use `+` (CLIPBOARD, `^C`)</li>
</ul>

<p>Now, just using `yy` will go to the system's clipboard, instead of Vim's unnamed
register, and `p` will paste the system's clipboard.</p>

You can also assign to these registers just like any register with `let`:  

<ul>
<li>`:let @+=42`</li>
<li>`:let @*=42`</li>
</ul>

<p>The `clipboard` setting has some more options (such as exclude filters); but
these are the basics. See `:help 'clipboard'` for the full story ;-)</p>

<h5>gVim</h1>

<p>If you use gVim, you can get copy-on-select behaviour when using
`:set guioptions+=a`.<br>
This is enabled by default on X11 systems (copies to PRIMARY), but <em>not</em> on MS
Windows &amp; OSX (as selecting any text would override your clipboard).</p>

<h5>No `+clipboard`?</h1>

<p>Vim requires the `+clipboard` feature flag for any of this to work; you can
check if your Vim has this by using `:echo has('clipboard')` from within Vim (if the
output is `0`, it's <em>not</em> present, if it's `1`, it is), or checking the output of
`vim --version` for `+clipboard`.</p>

<p>Most Linux distributions ship with a "minimal" Vim build by default, which
doesn't have `+clipboard`, but you can usually install it:</p>

<ul>
<li>Debian &amp; Ubuntu: Install `vim-gtk` or `vim-gnome`.</li>
<li>Fedora: install `vim-X11`, and run `vimx` instead of `vim` (<a href="https://vi.stackexchange.com/q/2063/51">more info</a>).</li>
<li>Arch Linux: install `gvim` (this will enable `+clipboard` for normal `vim` as well).</li>
</ul>

<p>You could also use `xclip`, `xcopy`, or `xsel` to copy text to the clipboard;
see the following questions for solutions:</p>

<ul>
<li><a href="https://vi.stackexchange.com/questions/332/define-custom-commands-for-the-and-registers">Define custom commands for the * and + registers</a></li>
<li><a href="https://vi.stackexchange.com/q/8354/51">How can I copy over an ssh session without +clipboard?</a></li>
</ul>

<h5>SSH</h1>

<p>You can also use a clipboard on remote machines if you enable X11 forwarding
over SSH. This is especially useful with the above tip since you can then use
`xclip` to access your desktop's clipboard. The Vim on the machine you're
ssh-ing to will still need the `+clipboard` feature.</p>

<p>This requires the `ForwardX11Trusted` setting, and should <strong>only be
done with trusted servers</strong>, as this gives the server almost complete control
over your X11 session:</p>

```vim
$ ssh -XY myhost
```

<p>To make these settings persistent (so you don't need to add `-XY` every time),
you could  do something like this in your `~/.ssh/config`:</p>

```vim
# Do **NOT** set this globally; it gives the server complete control over
# your X11 session.
Host myhost
    ForwardX11 yes
    ForwardX11Trusted yes
```

<h5>Neovim</h1>

<p>Neovim revamped the clipboard support. The built-in interface was removed and
replaced with a system that call an external utility such as `xclip`, `xsel`, or
`pbcopy`/`pbpaste`.</p>

<p>It should automatically pick up these utilities and use them. On OS X `pbcopy`
and `pbpaste` should be available by default, on Linux you probably want to
install `xclip`, as that's the most widely available (there are actually <em>two</em>
versions of `xsel` with <em>incompatible flags</em>. This is really stupid).</p>

Also see <a href="https://neovim.io/doc/user/provider.html#clipboard" rel="noreferrer">`:help clipboard`</a> in Neovim.  

#### Answer 2 (score 18)
<p>The other answers cover how to copy text from your buffer into the system clipboard.
Another common operation is to copy text from another <em>register</em> to the clipboard.
For example, if you've already yanked some text into `"` (the default register), you might want to load that register into the clipboard.</p>

You can do this with `:let`:  

<ul>
<li>`let @+=@"` &mdash; copies the default register into the clipboard</li>
<li>`let @*=@"` &mdash; copies the default register into the X11 primary selection ("mouse clipboard")</li>
<li>`let @+=@a` &mdash; copy from register `a` to the clipboard</li>
<li>etc.</li>
</ul>

Note that this works for registers in general: `let @a=@b` copies register `b` to register `a`.  

#### Answer 3 (score 17)
From <a href="http://vim.wikia.com/wiki/Accessing_the_system_clipboard" rel="noreferrer">http://vim.wikia.com/wiki/Accessing_the_system_clipboard</a>  

```vim
set clipboard=unnamedplus
```

This changes the default Vim register to the `+` register, which is linked to the system clipboard. From <a href="http://vimhelp.appspot.com/options.txt.html#clipboard-unnamedplus" rel="noreferrer">`:h clipboard-unnamedplus`</a>:  

```vim
                                        clipboard-unnamedplus
unnamedplus     A variant of the "unnamed" flag which uses the
                clipboard register '+' (quoteplus) instead of
                register '*' for all yank, delete, change and put
                operations which would normally go to the unnamed
                register.  When "unnamed" is also included to the
                option, yank operations (but not delete, change or
                put) will additionally copy the text into register
                '*'.
                Only available with the +X11 feature.
                Availability can be checked with: 
                        if has('unnamedplus')
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How can I use Vim as a hex editor? (score [160234](https://stackoverflow.com/q/2232) in 2017)

#### Question
Is there a neat way I can view binary files as hex in Vim, and save it back to binary from the hex?  

#### Answer 2 (score 116)
You can use the `xxd` command to transform a file in Vim to hex representation, doing  

`:%!xxd`  

`:` enters command-line mode, `%` matches whole file as a range, `!` filters that range through an external command, `xxd` is that external shell command  

Giving an output like this, this is split into octet count/line (octets per line may be changed with parameter `-c` on `xxd` command), hex representation, and text representation:  

```vim
0000000: 5468 6973 2069 7320 6120 7465 7374 0a41  This is a test.A
0000010: 6e6f 7468 6572 206c 696e 650a 416e 6420  nother line.And 
0000020: 7965 7420 616e 6f74 6865 720a            yet another.
```

Once you make the changes (in the hex part), you can go back to text with `-r` command on xxd, so  

`:%!xxd -r`  

This is a little rudimentary, though I like it in its simplicity and to keep in mind `xxd`, which is an interesting command line tool (I don't have to do a lot of work on hex, though). You can use some recipes to handle this transformation in a more automatic way like the one described in <em><a href="http://vim.wikia.com/wiki/Improved_hex_editing" rel="noreferrer">Improved hex editing</a></em>.  

#### Answer 3 (score 14)
Taken from `:h hex-editing`:  

```vim
If one has a particular extension that one uses for binary files (such as exe,
bin, etc), you may find it helpful to automate the process with the following
bit of autocmds for your <.vimrc>.  Change that "*.bin" to whatever
comma-separated list of extension(s) you find yourself wanting to edit:

" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END
```

You may want to look at: <a href="https://vi.stackexchange.com/q/2136/778">How do I navigate to topics in Vim's documentation?</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How do I install a plugin in Vim/vi? (score [140003](https://stackoverflow.com/q/613) in 2017)

#### Question
How do I install a plugin in Vim?  

Does it matter:  

<ul>
<li>Whether I use vi or Vim?</li>
<li>Whether I use gVim?</li>
<li>Which version of Vim I'm using?</li>
<li>What my OS is?</li>
</ul>

#### Answer accepted (score 65)
To install a plugin, we need to know what form it comes in. It can be:  

<ul>
<li>a single `.vim` file</li>
<li>a Vimball file</li>
<li>a set of files in directories that follow an expected structure (`plugin/*`, `syntax/*`, etc.) (<a href="https://vi.stackexchange.com/questions/285/what-makes-a-plugin-vundle-compatible-and-are-other-plugin-managers-interchangea">What makes a plugin Vundle compatible and are other plugin managers interchangeable?</a>)</li>
</ul>

A single `.vim` file is supposed to be placed in the `.vim/plugin` directory.  

A Vimball file <a href="https://vi.stackexchange.com/questions/491/how-do-i-install-a-vimball-plugin">can be installed</a> by opening it in Vim and running <a href="http://vimhelp.appspot.com/repeat.txt.html#%3Asource" rel="noreferrer">`:source %`</a>.  

A set of files in the standard directory layout can be installed either by copying them to `.vim`, or using a <a href="https://vi.stackexchange.com/questions/388/what-is-the-difference-between-the-vim-package-managers">plugin package manager</a>.  

Plugins may depend on certain features. Therefore:  

<ul>
<li>It may matter if you're using Vi or Vim,</li>
<li>It may matter if you're using gVim or not (gVim typically has more features enabled at compile time than Vim on the same distribution).</li>
<li>It may matter which version of Vim you're on, since a feature may have been added after your version of Vim.</li>
<li>It may matter which OS you're on, especially if the plugin calls in external commands.</li>
</ul>

For most plugins, though, it may not matter.  

#### Answer 2 (score 37)
<h5>vim-plug</h1>

I like to use the <a href="https://github.com/junegunn/vim-plug" rel="noreferrer">vim-plug</a> plugin manager.  

<p>The problem with manually installing a plugin is that it's rather difficult to
<em>remove</em> a plugin; you often have several different files in different
directories, you have to manually find them &amp; remove them.</p>

<p>Upgrading problems is similarly difficult: What if `autoload/old-name.vim` gets
renamed to `autoload/new-name.vim`? You now have <em>both</em> an old and new version
of a plugin.</p>

<p>`vim-plug` solves this by storing each plugin in it's own directory; it also
includes command to easily install/remove a plugin, so you don't have to muck
about with unzipping plugins and the like.</p>

<p>A key advantage of vim-plug over
<a href="https://vi.stackexchange.com/a/615/51">Pathogen</a> is that vim-plug allows you to
install and remove plugins more easily. All that Pathogen does is allow each
plugin to be in a separate contained directory.</p>

<p>vim-plug relies on <a href="http://www.git-scm.com/" rel="noreferrer">git</a>; for MS Windows, you want
<a href="http://msysgit.github.io/" rel="noreferrer">msysgit</a>.</p>

You can define plugins in your vimrc like so:  

```vim
call plug#begin('~/.vim/plugged')

" For MS Windows, this is probably better:
"call plug#begin('~/vimfiles/plugged')

Plug 'embear/vim-localvimrc'
Plug 'kchmck/vim-coffee-script'
" ... etc

call plug#end()
```

Then restart Vim, and then install plugins with:  

```vim
:PlugInstall
```

<p>This will put the plugins in `~/.vim/plugged` or `$HOME\vimfiles\plugged` for MS
Windows.</p>

<p>You can add
<a href="https://github.com/junegunn/vim-plug/wiki/faq#automatic-installation" rel="noreferrer">this snippet from the FAQ</a> to
your vimrc file before the `plug#begin()` call:</p>

```vim
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
```

Note you need `curl` for this to work. This is almost always available on Linux and OSX, but not on MS Windows; so this trick won't work there...  

To remove a plugin, remove it from the vimrc file and run:  

```vim
:PlugClean
```

<p>Note that vim-plug doesn't support installing scripts from the Vim scripts
website, but <a href="https://github.com/vim-scripts" rel="noreferrer">those scripts are mirrored on
GitHub</a>, so there's no need to do so.</p>

<p>There are also some additional advantages to this such as easier updating of
plugin, and on-demand loading for better performance. You can also easily copy
your vimrc to another computer, run `:PlugInstall`, and have all your plugins.</p>

<p>Note there are more plugin managers; I happen to use `vim-plug`.
See also: <a href="https://vi.stackexchange.com/q/388/51">What is the difference between the vim package managers?</a></p>

#### Answer 3 (score 25)
<h5>Pathogen</h1>

Pathogen is a runtime path manager, which loads plugins within Vim. It makes plugin installation simple; here's how it works:  

<em>note: If you're using Windows, replace `~/.vim` with `$HOME\vimfiles`.</em>  

<ol>
<li><p>Copy <a href="https://github.com/tpope/vim-pathogen/blob/master/autoload/pathogen.vim" rel="noreferrer">`pathogen.vim`</a> to `~/.vim/autoload/pathogen.vim`.</p></li>
<li><p>Create the `~/.vim/bundle` directory, if it does not exist already.</p></li>
<li><p>Add the following line to the very beginning of your `.vimrc`:</p>

```vim
execute pathogen#infect()
```
</li>
<li><p>You're done! When you want to add a plugin, simply copy the entire plugin's directory to `~/.vim/bundle`, or `git clone` it there. For example:</p>

```vim
cd ~/.vim/bundle
git clone https://github.com/tpope/vim-surround
```
</li>
<li><p>* Caveat: If your plugin comes in the form of a `.vim` file, it won't work with Pathogen. Copy it to `~/.vim/plugin` instead (you may have to create this directory if it doesn't exist).</p></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How do I use vim as a diff tool? (score [134835](https://stackoverflow.com/q/625) in 2015)

#### Question
I use vim as my primary editor.  

I would also like to use vim to diff files and modify the files while doing the diff to fix easy changes (rather than most diff techniques which are a cycle of diff/fix/diff/fix).  

Additionally are there easy ways to integrate vim into diff tools used by source control tools/sites (I am specifically thinking of git but I am sure other people would be interested in integration with other source control tools/sites).  

#### Answer 2 (score 123)
vim has this functionality built in (with the correct command line flag).  

```vim
vim -d <file1> <file2>
```

<p>This opens each file in a view and highlights the differences.<br>
Any code that is identical is `folded` away so you do not need to look at identical code or scroll through huge chunks of identical code. </p>

But there is also a wrapper application `vimdiff` that correctly invokes vim with the correct flags.  

```vim
vimdiff source1.cpp source2.cpp
```

If you are using git you can set up an external diff tool. So it is easy to set up vimdiff to be the diff tool for git.  

```vim
git config --global diff.tool vimdiff
```

When using vimdiff you can edit either side and diff highlighting keeps pace to show you the differences.    

Note: When editing from a git diff. If you try and edit the repository stored version of the file your changes will be discarded when you exit (git does not trust you with the original so you are diffing against a tmp copy) but you can edit the local copy to your hearts content and save it over you current version.  

Some basic commands that are useful in `vimdiff`  

```vim
dp             diffput: puts changes under the cursor into the other file
                        making them identical (thus removing the diff).
do             diffget: (o => obtain). The change under the cursor is replaced
                        by the content of the other file making them identical.


]c             Jump to the next diff
[c             Jump to the previous diff
```

Other vim settings I use to work with highliting with vimdiff  

```vim
if &diff
    highlight! link DiffText MatchParen
endif
```

This turns off highlighting on the bits of code that are changed. So the line that is changed is highlighted so I can spot the changes, but the actual text that has changed stands out on the line (as it is not highlighted).  

#### Answer 3 (score 13)
If you are editing an open file and want to compare it to another file without closing the current one:  

Open the new file in split screen:   

For vertical split:  

```vim
:vs otherFile
```

or horizontal split:  

```vim
:split otherFile
```

Switch cursors to different split screen:  

```vim
ctrl+w ctrl+w
```

Invoke "diff mode" in file:  

```vim
:diffthis
```

Switch to other file and invoke "diff mode":  

```vim
:diffthis
```

To turn off "diff mode":  

```vim
:diffoff
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Displaying tabs as characters (score [118320](https://stackoverflow.com/q/422) in 2015)

#### Question
When I work on files in python, I sometimes mistake tabs for spaces and vice versa. Is there a way I can get Vim to display a character for a tab instead of a tab?  

#### Answer 2 (score 120)
Yes, use listchars:  

```vim
set list
set listchars=tab:>-
```

If you put these two lines in your .vimrc, tabs will be shown as `>` for the start position and `-` through the rest of the tab.  

(Sidenote: listchars can also show trailing spaces with `trail:x` (replace `x` with the character you want to use for a trailing space), which can be useful as well.)  

#### Answer 3 (score 58)
The basic answer is `:set list`, which causes tabs to display as `^I`.  

However, I recommend going beyond that.  Just `:set list` is problematic in that it fails to preserve visual alignment on screen.  For example:  

```vim
%.o: %.cpp
^Ig++ -c $<
```

doesn't look good, especially when you expect the `g` of `g++` to appear under the first `p` of `cpp` (assuming `tabstop=8`).  

Therefore, I suggest that in your `.vimrc` you put something like `:set listchars=tab:␉·`  (To be clear, that's Unicode character <a href="https://codepoints.net/U+2409">U+2409 SYMBOL FOR HORIZONTAL TABULATION</a> followed by <a href="https://codepoints.net/U+00B7">U+00B7 MIDDLE DOT</a>.)  

As explained in <a href="https://vimhelp.appspot.com/options.txt.html#%27listchars%27">`:help listchars`</a>, a two-character setting for `tab:xy` causes visual alignment to be preserved:  

<blockquote>
```vim
tab:xy        Two characters to be used to show a tab.  The first
              char is used once.  The second char is repeated to
              fill the space that the tab normally occupies.
              "tab:>-" will show a tab that takes four spaces as
              ">---".  When omitted, a tab is show as ^I.
```
</blockquote>

The example above would appear on screen as:  

```vim
%.o: %.cpp
␉·······g++ -c $<
```

<hr>

Personally, I go all-out with my `listchars`:  

```vim
:set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵
```

<ul>
<li>For `eol`, I use <a href="https://codepoints.net/U+23CE">U+23CE RETURN SYMBOL</a></li>
<li>For `trail`, I use <a href="https://codepoints.net/U+2420">U+2420 SYMBOL FOR SPACE</a></li>
<li>For `nbsp`, I use <a href="https://codepoints.net/U+23B5">U+23B5 BOTTOM SQUARE BRACKET</a></li>
</ul>

These characters are distinctive enough that they rarely appear literally in document text.  

To type these special characters into your `vimrc`, type <kbd>Ctrl-v</kbd><kbd>u</kbd>`23CE` while in Insert Mode, as explained in <a href="https://vimhelp.appspot.com/mbyte.txt.html#utf-8-typing">`:help utf-8-typing`</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: Why doesn't the backspace key work in insert mode? (score [103819](https://stackoverflow.com/q/2162) in 2017)

#### Question
Trying to delete characters in insert mode with the <kbd>backspace</kbd> key sometimes doesn't seem to work. I can <kbd>backspace</kbd> <em>sometimes</em>, but at other times it does nothing; the cursor doesn't go to the left, and absolutely nothing seems to happen.  

<p>I noticed this using gVim in Windows.
The <kbd>backspace</kbd> seems to work as expected while using Vim from the terminal in most Linux systems however.</p>

<ol>
<li>Why does this happen?</li>
<li>How can I make the <kbd>backspace</kbd> key delete characters as usual?</li>
<li>Is this behaviour intended as a feature? In other words: are there better alternatives to the <kbd>backspace</kbd> to delete characters in insert mode?</li>
</ol>

#### Answer accepted (score 178)
tl;dr: Add this to your vimrc to make the backspace work like in most other programs:  

```vim
set backspace=indent,eol,start
```

<hr>

<h5>Longer answer</h1>

Though the default behaviour may be surprising, the backspace "not working" can be considered a <em>feature</em>; it can prevents you from accidentally removing indentation, and from removing too much text by restricting it to the current line and/or the start of the insert.  

<a href="http://vimhelp.appspot.com/options.txt.html#%27backspace%27" rel="noreferrer">`:help 'backspace'`</a> tells us:  

```vim
Influences the working of `<BS>`, `<Del>`, `CTRL-W` and `CTRL-U` in Insert
mode.  This is a list of items, separated by commas.  Each item allows
a way to backspace over something:

value     effect
indent    allow backspacing over autoindent
eol       allow backspacing over line breaks (join lines)
start     allow backspacing over the start of insert; CTRL-W and CTRL-U
          stop once at the start of insert.
```

So what do these values mean exactly?  

<p><strong>indent</strong><br>
Vim adds automatic indentation for many filetypes; by default, you're <em>not</em>
allowed to backspace over this; the rules of what is considered to be
'autoindentation' are somewhat subtle, for example, if we would type this (where
█ is the cursor):</p>

```vim
if :; then
    █
```

Backspacing won't work.  

<p>But if we would then add a command and the `fi`, and go back up, we <em>are</em>
allowed to remove the indentation:</p>

```vim
if :; then
    █:
fi
```

This is because in the first example, Vim determined it should add 1 level of indentation when you pressed Enter; but in the second example, Vim didn't autoindent anything, it's just Tab characters or a few spaces.  

Also see <a href="http://vimhelp.appspot.com/options.txt.html#%27autoindent%27" rel="noreferrer">`:help 'autoindent'`</a>  

<p><strong>eol</strong><br>
This should be the most obvious, pressing Backspace also removes EOL
markers (`\n` or `\r\n`); if disabled, Backspace will do nothing if you try to
delete a EOL marker.</p>

<p><strong>start</strong><br>
This means you can <em>only</em> delete text that you've inserted since insert mode
started, and you can't delete any text that was previously inserted.</p>

<h5>So what's the default setting?</h2>

<blockquote>
  I noticed this using GVIM in windows. The backspace seems to work as expected while using VIM from the terminal in most Linux systems however.  
</blockquote>

The reason for this is because many Linux distro's ship with pre-made vimrc files which set some common options. For example on my Arch Linux system I have `/usr/share/vim/vimfiles/archlinux.vim` with:  

```vim
set nocompatible
set backspace=indent,eol,start
" ... and a few more...
```

If you install Vim on Windows, the default is to use the default vimrc and gvimrc that Vim ships with.  

The <em>Vim</em> default is an empty value for `backspace`. The Arch Linux, Debian, CentOS, or `$other_distro` default may be different.  

<h5>Normal mode</h1>

This question is about Backspace in insert mode, but let me also add some brief remarks about Backspace in normal mode.  

In normal mode, the Backspace acts as `h`, it just goes to the left.   

By default, the backspace will go to the previous line if at the start of a line (as if `eol` was in `backspace`); you can control this behaviour with the <a href="http://vimhelp.appspot.com/options.txt.html#%27ww%27" rel="noreferrer">`'whichwrap'`</a> option  through the `b` flag (enabled by default).  

You can also make backspace delete characters by mapping it to the `X` command:  

```vim
nnoremap <BS> X
```

#### Answer 2 (score 5)
Just in case anyone is experience not explainable `<BS>` behavior using ConEmu on Windows, you may have to remap the `<BS>` key to:  

```vim
inoremap <Char-0x07F> <BS>
nnoremap <Char-0x07F> <BS>
```

<a href="https://conemu.github.io/en/VimXterm.html#vim-bs-issue" rel="nofollow noreferrer">More information</a>  

#### Answer 3 (score 1)
```vim
set backspace=2
```

is used with v5.4 and earlier. worked for me on mac.  

looks like on mac i have v3.2:    

```vim
$ bash --version
GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin18)
Copyright (C) 2007 Free Software Foundation, Inc.
```

All versions past 3.2 use the GNU General Public License v3 (GPLv3), which Apple isn't in favor of supporting. A discussion on reddit about this is <a href="https://www.reddit.com/r/apple/comments/7v97ls/why_doesnt_apple_use_any_gpl_v3_unix_packages_in/" rel="nofollow noreferrer">here</a>.  

You can upgrade to the newest Bash with:  

```vim
brew install bash
```

this allows to take advantage of programmable completion highlighted <a href="https://itnext.io/programmable-completion-for-bash-on-macos-f81a0103080b" rel="nofollow noreferrer">here</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: What's the simplest way to strip trailing whitespace from all lines in a file? (score [91801](https://stackoverflow.com/q/454) in 2015)

#### Question
It's pretty common when programming or opening text files to encounter files with trailing whitespace at the end of a line. vim has a way to show this by setting the `trail` option in the `listchars` option and then turning `list` on.  

However, what's the easiest way to eliminate that trailing whitespace globally across the whole of a file (ideally without a plugin)?  

#### Answer accepted (score 73)
<h5>Use a keybinding to strip all trailing whitespace</h2>

Since some pages that I edit actually need trailing whitespaces (e.g. markdown) and others don't, I set up a keybinding to <kbd>F5</kbd> so that it's trivial to do without being automatic. To do so, add the <a href="http://vim.wikia.com/wiki/Remove_unwanted_spaces#Simple_commands_to_remove_unwanted_whitespace" rel="noreferrer">code below (from vim.wikia)</a> or some variation of it to your `.vimrc`:  

```vim
"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
```

<ul>
<li>`nnoremap <F5>` does a nonrecursive mapping to the key `F5` in normal mode  </li>
<li>`:let _s=@/` stores the last search term (from the macro `@/`) in the variable `_s`</li>
<li>`<Bar>` Functions as a pipe symbol `|` to separate commands, however `|` would end a command in this context, so `<Bar>` must be used instead.</li>
<li>`:%s/\s\+$//e` searches for trailing whitespace and deletes it everywhere in the buffer (see <a href="https://vi.stackexchange.com/a/456/1111">CarpetSmoker's answer</a> for a detailed breakdown of this expression)</li>
<li>`let @/=_s` restores your last search term to the macro `@/`, so that it will be available the next time you hit `n`.</li>
<li>`<CR>` ends the mapping</li>
</ul>

<hr>

<h5>... or be more selective</h2>

If you have cases in which you don't want to strip all of the trailing whitespace, you can use a pattern to be more selective. For example, the following code shows how I strip trailing whitespace only if it comes after a semicolon (here it's tied to <kbd>F8</kbd>).  

```vim
nnoremap <F8> :let _s=@/<Bar>:%s/;\s\+$/;/e<Bar>:let @/=_s<Bar><CR>
```

This is useful if, like me, you have some files with markdown-like <a href="https://en.wikipedia.org/wiki/Here_document" rel="noreferrer">heredocs</a> interspersed among semicolon-terminated programming statements.   

#### Answer 2 (score 177)
The "simplest" way is to just use `:substitute`:  

```vim
:%s/\s\+$//e
```

<ul>
<li>`:%s` to run `:substitute` over the range `%`, which is the entire buffer.</li>
<li>`\s` t match all whitespace characters.</li>
<li>`\+` to repeat them 1 or more times.</li>
<li>`$` to anchor at the end of the line.</li>
<li>The `e` flag to not give an error if there is no match (i.e. the file is already without trailing whitespace).</li>
</ul>

However, this is probably not the "best" way as it causes two side-effects:  

<ol>
<li>it moves the cursor to the last match;</li>
<li>it adds the command to the history and search history;</li>
<li>it resets the last search term.</li>
</ol>

You can fix both items by turning this into a function:  

```vim
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
```

And then use it like:  

```vim
:call TrimWhitespace()
```

<ol>
<li>The `winsaveview()` will save the current "view", which includes the cursor position, folds, jumps, etc. The `winrestview()` at the end will restore this from the saved variable.</li>
<li>The `:keeppatterns` prevents the `\s\+$` pattern from being added to the search history.</li>
<li>The last-used search term is automatically restored after leaving a function, so we don't have to do anything else for this.</li>
</ol>

Since this is somewhat annoying to type `:call` all the time, you can define a command:  

```vim
command! TrimWhitespace call TrimWhitespace()
```

Which can be be used without the `:call`:  

```vim
:TrimWitespace
```

And you can of course bind it to a key:  

```vim
:noremap <Leader>w :call TrimWhitespace()<CR>
```

<hr>

Some people like to automatically do this before they write a file to disk, like so:  

```vim
autocmd BufWritePre * :call TrimWhitespace()
```

I don't like it, as some formats require trailing whitespace (such as  Markdown), and on some other occasions you even want trailing whitespace in your code (such as formatting an email, and using the `--<Space>` marker to indicate the start of a signature).  

<hr>

Shameless plug mode: a while ago I <a href="http://code.arp242.net/sanitize_files/src" rel="noreferrer">wrote a little Python script</a> to clean up whitespace for an entire project at once.  

#### Answer 3 (score 11)
To delete all trailing whitespace (at the end of each line), you can use the command:  

```vim
:%s/ \+$//
```

To include tabs, use `\s` instead of space.  

<hr>

From the command-line:  

```vim
$ ex +'%s/\s\+$//e' -cwq file.c
```

All the files in the current directory (recursively use `**/*.*`):  

```vim
$ ex +'bufdo!%s/\s\+$//e' -cxa *.*
```

<hr>

Python way:  

```vim
:py import vim
:pydo vim.current.buffer[linenr - 1] = vim.current.buffer[linenr - 1].strip()
```

or:  

```vim
:py import vim
:py for i, l in enumerate(vim.current.buffer): vim.current.buffer[i] = l.rstrip()
```

<sup>Use `lstrip()` for left strip (trailing), `rstrip()` for right strip (leading) or `strip()` to remove from both ends.</sup>  

<hr>

Here is useful function which removes superfluous white space from the end of a line which you can add to your `.vimrc`:  

```vim
" Removes superfluous white space from the end of a line
function! RemoveWhiteSpace()
   :%s/\s*$//g
    :'^
    "`.
endfunction
```

<hr>

There is also <a href="http://www.vim.org/scripts/script.php?script_id=3967" rel="noreferrer">DeleteTrailingWhitespace</a> plugin for that.  

<hr>

<strong>Highlighting white spaces</strong>  

To double-check if all trailing spaces are gone, use:  

<ol>
<li><p>Type `/ $` to find them. If there are some, vim would highlight them for you.</p></li>
<li><p>Use colours to highlight them:</p>

```vim
:highlight ws ctermbg=red guibg=red
:match ws /\s\+$/
```
</li>
<li><p>Use visible characters (<a href="https://stackoverflow.com/a/26299952/55075">source</a>):</p>

```vim
:set encoding=utf-8
:set listchars=trail:·
:set list
```
</li>
</ol>

See also: <a href="http://vim.wikia.com/wiki/VimTip396" rel="noreferrer">Highlight unwanted spaces</a>  

To highlight trailing whitespace by default, you may configure your `.vimrc` as follow:  

```vim
highlight ws ctermbg=red guibg=red
match ws /\s\+$/
autocmd BufWinEnter * match ws / \+$/
```

<hr>

<strong>Removing white spaces by default</strong>  

If you would like to make sure that all trailing whitespace in a file are removed automatically on save, you may add the following command into your `.vimrc`:  

```vim
autocmd BufWritePre *.c,*.php :%s/ \+$//ge
```

which is not recommended, as it'll strip trailing whitespace from every file a user saves (even where whitespace can be desired).  

<hr>

See also:  

<ul>
<li><a href="http://vim.wikia.com/wiki/Remove_unwanted_spaces" rel="noreferrer">Remove unwanted spaces</a> at vim wikia</li>
<li><a href="https://stackoverflow.com/questions/1185524/how-to-trim-whitespace-including-tabs">How to trim whitespace (including tabs)?</a> at stackoverflow</li>
<li><a href="https://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim">How can you automatically remove trailing whitespace?</a> at stackoverflow</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: Is it possible to split Vim window to view multiple files at once? (score [90210](https://stackoverflow.com/q/64) in )

#### Question
When working with multiple files, it would be very handy if we can see more than one file in the screen at once. Is there any way in Vim to split the window (horizontally or vertically) so each split can show a different file?  

#### Answer accepted (score 64)
Yes, vim has the ability to split both horizontally using `:split` and vertically using `:vsplit` which both work just like `:edit` for opening a file, except they open it in a horizontal / vertical split respectively.  

Additionally, I would recommend to also read `:h window-move-cursor` for moving around different splits with ease.  

#### Answer 2 (score 17)
Yes, there are the `:split` (split into two windows, top half and bottom half) and `:vsplit` (left and right) commands. You can then use <kbd>Ctrl-W <em>direction</em></kbd> to switch windows (where <em>direction</em> is one of the normal hjkl cursor movement keys, or the arrow keys).  

You can then `:edit` (etc.) a different file in each window.  

Full documentation is at `:help windows.txt`.  

#### Answer 3 (score 15)
You can either split vim windows by <a href="https://vi.stackexchange.com/q/732/467">opening multiple files</a> using `-o`, `-O`, `-o2` parameters.  

Or if you're already editing multiple files in one window, you can use `:ba` to <a href="https://vi.stackexchange.com/q/758/467">split horizontally</a> or `:vert ba` to split vertically.  

<blockquote>
  <p>:[N]ba[ll] [N]
  :[N]sba[ll] [N] Rearrange the screen to open one window for each buffer in the buffer list.</p>
  
  :vert[ical] {cmd} Execute {cmd}.  If it contains a command that splits a window, it will be split vertically.  
</blockquote>

<a href="https://vi.stackexchange.com/q/735/467">To quit</a>, use: `:qa`.  

<hr>

See also:  

<ul>
<li><a href="https://vi.stackexchange.com/q/732/467">How to open multiple files in split mode?</a></li>
<li><a href="https://vi.stackexchange.com/q/758/467">How to convert all windows into horizontal, vertical or tab splits?</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: What is the difference between the vim plugin managers? (score [89866](https://stackoverflow.com/q/388) in 2016)

#### Question
I have been looking at the different package managers for vim and the one I decided to use <a href="https://github.com/junegunn/vim-plug">vim-plug</a> but I have seen others like <a href="https://github.com/tpope/vim-pathogen">pathogen</a> and <a href="https://github.com/gmarik/Vundle.vim">vundle</a> and I honestly don't know what the difference is.  

Can someone give me a brief overview of the differences so I can decide which works best for me?  

#### Answer accepted (score 142)
<a href="https://github.com/junegunn/vim-plug" rel="noreferrer">vim-plug</a> is a nice alternative to Vundle, it does things a bit different from a technical point of view which should make it faster (<a href="http://junegunn.kr/2013/09/writing-my-own-vim-plugin-manager/" rel="noreferrer">see this</a>). It has most (or all?) of the features of Vundle.  

<ul>
<li>Parallel update procedure for Vim with any of `+ruby`, `+python`, or Neovim. Falls back to sequential mode using Vimscript if none is available.</li>
<li>Lazy loading, for faster startup (<a href="http://junegunn.kr/2014/07/vim-plugins-and-startup-time/" rel="noreferrer">see this</a>).</li>
<li>Install plugins.</li>
<li>Update plugins.</li>
<li>Review / rollback updates.</li>
<li>Supports OSX, Linux &amp; UNIX systems, and MS Windows.</li>
<li>Post-update hooks e.g. automatically recompile YCM</li>
</ul>

To start using it:  

```vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

And in your vimrc:  

```vim
call plug#begin()
Plug 'tpope/vim-sensible'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
call plug#end()
```

Then give the command  

```vim
:PlugInstall
```

to install the listed plugins.  

#### Answer 2 (score 56)
<a href="https://github.com/tpope/vim-pathogen">Pathogen</a> is simple. Essentially it just does:  

<ul>
<li>autoload plugins from a folder</li>
<li>generate help tags for these plugins</li>
</ul>

Pros:  

<ul>
<li>minimalist</li>
</ul>

Cons:  

<ul>
<li>everything else done manually (installing, updating, removing, etc.)</li>
<li>no lazy loading</li>
</ul>

To install it download <a href="https://github.com/tpope/vim-pathogen/blob/master/autoload/pathogen.vim">`pathogen.vim`</a> to `~/.vim/autoload`:  

```vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```

And add to your `.vimrc`:  

```vim
call pathogen#infect()
call pathogen#helptags() "If you like to get crazy :)
```

If you don't like to get crazy, only call `:Helptags` when you need to.  

Plugins are then added to `~/vim/bundle`.  

#### Answer 3 (score 43)
<a href="https://github.com/gmarik/Vundle.vim">Vundle</a> is more complex. It is a package manager à la <a href="http://en.wikipedia.org/wiki/Advanced_Packaging_Tool">`apt`</a> or `yum` for plugins. It can:  

<ul>
<li>search a plugin index</li>
<li>update plugins</li>
<li>generate helptags automatically</li>
<li>keep, but not use, plugins in the autoload folder</li>
<li>clean out such unused plugins</li>
<li>Works on Linux, OSX, and MS Windows</li>
</ul>

To install:  

```vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

And then add to your `.vimrc`:  

```vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" more Plugin commands
" ...
call vundle#end()            " required
filetype plugin indent on    " required
```

To install a plugin, use the `Plugin` command in `.vimrc` (more examples on the Github README):  

```vim
" plugin on Github
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
```

And then call `:PluginInstall` from `.vim` (or `vim +PluginInstall +qall`).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: How do I reload the current file? (score [74672](https://stackoverflow.com/q/444) in 2015)

#### Question
Quite often I am working with files that are version controlled, so it is possible for changes to be made to them outside of Vim.  

What is a quick way to reload the file without having to close and reopen Vim? And is there a way to do this automatically?  

#### Answer accepted (score 173)
The command you want is <a href="http://vimdoc.sourceforge.net/htmldoc/editing.html#edit-a-file">`:e`</a> (short for `:edit`). If you use `:edit!` it will discard local changes and reload.  

You can also have vim do this automatically with <a href="http://vimdoc.sourceforge.net/htmldoc/options.html#%27autoread%27">`set autoread`</a> in your vimrc.  

#### Answer 2 (score 19)
In many cases, `set autoread` will not work as <a href="https://stackoverflow.com/a/2490635/5353461">this answer</a> explains:  

<blockquote>
  Autoread does not reload file unless you do something like run external command (like `!ls` or `!sh` etc)   
</blockquote>

<p>Focus events will trigger `autoread`, but these are not captured unless using `gvim`. So, if running plain `vim` inside a terminal window or tmux, install
the plugin <a href="https://github.com/tmux-plugins/vim-tmux-focus-events" rel="noreferrer">vim-tmux-focus-events</a>.</p>

On tmux versions > 1.9, you'll need to add in `.tmux.conf`:  

```vim
set -g focus-events on
```

For additional goodness, adding the following to your `vimrc` will trigger `autoread` when changing buffers inside while <em>inside</em> vim:  

```vim
au FocusGained,BufEnter * :checktime
```

#### Answer 3 (score 8)
If you've ever run an external command from Vim that modifies the current buffer, you may have noticed that it prompts you to reload the file since changes have been made to disk. You can actually invoke this prompt using the `:checktime` command.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: Is it possible to have vim auto-complete function names, variables, etc. when using it to program? (score [72480](https://stackoverflow.com/q/39) in 2015)

#### Question
Many IDEs automatically complete function names, variables, method names, etc. as the user types. The best ones complete the names based both on the language's built-in library as well as what has already been defined in other files of the same program.  

For example, as I'm typing the following Python program:  

```vim
hungy = True

def eatFood(food):
    pass

if hungry:
    eatF
```

the line `eatF` would automatically show `eatFood()` as an available auto-complete option.  

Does Vim have this capability? If so, how can I enable it?  

#### Answer accepted (score 42)
There are many different flavors of autocomplete in vim. One way might be to use <a href="https://github.com/ervandew/supertab" rel="noreferrer">SuperTab</a>. This provides a way to use tab-completion at more or less any time. This would enable you to hit <kbd>Tab</kbd> after you've partially typed the word to get a completion list. For instance, typing `eatF` followed by <kbd>Tab</kbd> to expand to `eatFood.`  

<strong>Please Note</strong>: these pictures all link to example gifs in action.  

<a href="https://i.stack.imgur.com/kKbAz.gif" rel="noreferrer"><img src="https://i.stack.imgur.com/dVuOT.png" alt="supertab completions" title="Click to see a gif"></a>  

Vim has excellent other options. You should read `:h ins-completion` to see the variety of built-in completion options. Using vim's <kbd>Ctrl</kbd>-<kbd>X</kbd><kbd>Ctrl</kbd>-<kbd>O</kbd>, combined with a python-aware plugin like <a href="https://github.com/davidhalter/jedi" rel="noreferrer">jedi</a> can give a completion flavor. Jedi can be configured to give documentation on omni-completion (this is what <kbd>Ctrl</kbd>-<kbd>X</kbd><kbd>Ctrl</kbd>-<kbd>O</kbd> does). Then documentation for the completion candidates would appear in a split window.  

<a href="https://i.stack.imgur.com/KlAjl.gif" rel="noreferrer"><img src="https://i.stack.imgur.com/etSIu.png" alt="ctrlxctrlo completion" title="Click to see a gif"></a>  

Using similar plugins but different options leads to all sorts of behaviours. It's possible, for instance, to not need to prompt for autocompletion (if that's what you're after). Instead, after you type some number of letters (say, 2 or 3) of a word, a plugin can try to intelligently offer possible completions in a menu.  

<a href="https://i.stack.imgur.com/9QnR9.gif" rel="noreferrer"><img src="https://i.stack.imgur.com/gtNK0.png" alt="enter image description here" title="Click to see a gif"></a>  

So the short answer is a <strong>yes!</strong> But the configuration process can be a bit complicated. I think of it as a step in the long stairway of mastering vim.  

#### Answer 2 (score 24)
Such functionality - i.e., searching the current file (and all open files) for auto-completion, should be enabled by default with `Ctrl+P`:  

<img src="https://i.stack.imgur.com/5040g.png" alt="screenshot of autocompletion in use">  

You can go to the <strong>n</strong>ext suggestion with `Ctrl+N`, the <strong>p</strong>revious suggestion with `Ctrl+P` and select it by typing any letter (which will be appended right after the suggestion).  

#### Answer 3 (score 20)
Vim has support for completion natively. You can read about the various different completions that Vim supports at `:h ins-completion`.  

In general, for all purposes I have found, ins-completions are enough for my liking, however there are some completion plugins that add more value beyond what ins-completions offers. <a href="https://github.com/Shougo/neocomplete.vim" rel="nofollow noreferrer">NeoComplete</a>, <a href="https://github.com/Valloric/YouCompleteMe" rel="nofollow noreferrer">YCM (YouCompleteMe)</a> are a few for the same. They are more advanced in the sense that they try to combine different types of completions more accurately, and they also have advanced caching mechanisms, so they tend to be faster. YCM even goes to the extent to work with external compilers / utilities to provide better IntelliSense.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How to replace tabs with spaces? (score [67722](https://stackoverflow.com/q/495) in 2015)

#### Question
Is it possible to convert tabs to spaces, while maintaining text alignment?  

Simply replacing only works usefully when there are no leading characters.  

#### Answer accepted (score 98)
<p>You can use the `:retab` command. From 
<a href="http://vimhelp.appspot.com/change.txt.html#%3Aretab">`:help :retab`</a></p>

<blockquote>
  <p>Replace all sequences of white-space containing a `<Tab>` with new strings of
  white-space using the new tabstop value given.  If you do not specify a new
  tabstop size or it is zero, Vim uses the current value of `'tabstop'`.
  [...]
  With `'expandtab'` on, Vim replaces all tabs with the appropriate number of
  spaces.</p>
</blockquote>

<p>Note that the command accepts a range, so you can make a visual selection and
then just `:retab` the selected lines.</p>

#### Answer 2 (score 23)
You can use `:retab`, as stated, however, this will change <em>all</em> tabs to spaces, <em>not</em> only tabs at the start of the line  

So this (where `⇥` is a tab character):  

```vim
if :; do
⇥echo "⇥hello"
end
```

gets changed to (where `␣` is a space character):  

```vim
if :; do
␣␣echo "␣␣hello"
end
```

This can produce unexpected side-effects in some scenarios, and it's even more of an issue when changing spaces to tabs!  

So, I wrote a little function to change <em>only</em> tabs/spaces at the <em>start</em> of the line:  

```vim
" :retab changes *everything*, not just start of lines
fun! Retab(expandtab)
    let l:spaces = repeat(' ', &tabstop)

    " Replace tabs with spaces
    if a:expandtab
        silent! execute '%substitute#^\%(' . l:spaces . '\)\+#\=repeat("\t", len(submatch(0)) / &tabstop)#e'
    " Replace spaces with tabs
    else
        silent! execute '%substitute#^\%(\t\)\+#\=repeat("' . l:spaces . '", len(submatch(0)))#e'
    endif
endfun
```

<p>With this version, you have to manually specify `expandtab` in the function call
(ie. `:call Retab(1)` to change tabs to spaces), but you could also modify it
to take the current value of `&expandtab` (as it already does with `&tabstop`)
just like `:retab` does. (I happen to prefer to specify it manually).</p>

#### Answer 3 (score 11)
Vim provides `!retab` command which will replace all sequences of `<Tab>` with new strings of white-space using the new tabstop (e.g. `:set tabstop=2`) value given, but <strong>all tabs inside of strings can be modified</strong> (e.g. in a C program, you should use `\t` to avoid this)!  

So alternatively you can change all tabs into spaces using the following command:  

```vim
:%s/\t/  /g
```

or as suggested by <a href="https://vi.stackexchange.com/questions/495/how-to-replace-tabs-with-spaces/844?noredirect=1#comment20357_844">@Shahbaz</a>:  

```vim
:%s/^\t\+/ g
```

<sup>So only the tabs used in indentation are converted.</sup>  

Explanation:  

<ul>
<li>`%` represents the entire buffer/file (`:help :%`)</li>
<li>`s` stands for substitute (`:help sub-replace-special`)</li>
<li>`\t`, or `^I` stands for tab</li>
<li>`` - use as many spaces as you need per one tab</li>
<li>`g` - stands for global, and it'll convert multiple occurences of tabs in the same line</li>
</ul>

Then to correct indentation of the entire file, you may try: <kbd>gg=G</kbd>. Check: <a href="https://vi.stackexchange.com/q/236/467">Re-indenting badly indented code</a> for more details.  

To use spaces by default instead of tabs, you need to add the following settings into your `.vimrc` file:  

```vim
set tabstop=2     " (ts) width (in spaces) that a <tab> is displayed as
set expandtab     " (et) expand tabs to spaces (use :retab to redo entire file)
set shiftwidth=2  " (sw) width (in spaces) used in each step of autoindent (aswell as << and >>)
```

Alternative solution is to use `tidy`  

<hr>

Related:  

<ul>
<li><a href="http://vim.wikia.com/wiki/Converting_tabs_to_spaces" rel="noreferrer">Converting tabs to spaces</a> at vim wikia      </li>
<li><a href="https://stackoverflow.com/questions/6753219/indenting-with-spaces-but-still-use-preferred-shiftwidth-in-vim">Indenting with spaces but still use preferred shiftwidth in Vim?</a> at stackoverflow SE</li>
<li><a href="https://askubuntu.com/questions/20937/how-can-i-easily-retab-html-files-according-to-some-sane-default">How can I easily retab html files according to some sane default?</a> at askubuntu SE</li>
<li><a href="https://softwareengineering.stackexchange.com/questions/110160/using-vim-is-there-a-way-to-automatically-un-tab-everything-in-your-source-file">Is there a way to automatically un-tab everything in your source file by using a command?</a> at programmers</li>
<li><a href="https://vi.stackexchange.com/q/236/467">Re-indenting badly indented code</a> at Vim SE</li>
<li><a href="https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim">Tab key == 4 spaces and auto-indent after curly braces in Vim</a> at stackoverflow</li>
<li><a href="https://stackoverflow.com/questions/6753219/indenting-with-spaces-but-still-use-preferred-shiftwidth-in-vim">Indenting with spaces but still use preferred shiftwidth in Vim?</a> at stackoverflow</li>
<li>(opposite) <a href="https://stackoverflow.com/questions/9104706/how-can-i-convert-spaces-to-tabs-in-vim-or-linux">How can I convert spaces to tabs in Vim or Linux?</a> at stackoverflow SE</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How to edit binary files with Vim? (score [64852](https://stackoverflow.com/q/343) in 2015)

#### Question
Is there a way to edit binary files in some kind of hexadecimal mode?  

For example if I have some binary data shown by `xxd` or `hexdump -C` like this:  

```vim
$ hexdump -C a.bin | head -n 5
00000000  cf fa ed fe 07 00 00 01  03 00 00 80 02 00 00 00  |................|
00000010  12 00 00 00 40 05 00 00  85 00 20 00 00 00 00 00  |....@..... .....|
00000020  19 00 00 00 48 00 00 00  5f 5f 50 41 47 45 5a 45  |....H...__PAGEZE|
00000030  52 4f 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |RO..............|
00000040  00 00 00 00 01 00 00 00  00 00 00 00 00 00 00 00  |................|

$ xxd a.bin | head -n 5
0000000: cffa edfe 0700 0001 0300 0080 0200 0000  ................
0000010: 1200 0000 4005 0000 8500 2000 0000 0000  ....@..... .....
0000020: 1900 0000 4800 0000 5f5f 5041 4745 5a45  ....H...__PAGEZE
0000030: 524f 0000 0000 0000 0000 0000 0000 0000  RO..............
0000040: 0000 0000 0100 0000 0000 0000 0000 0000  ................
```

<p>If I want to change the value at a specific position,
this kind of view will help finding the right place,
for example when the position to change is near some known string.</p>

#### Answer accepted (score 89)
The simplest way is to use the `binary` option. From `:help binary`:  

```vim
This option should be set before editing a binary file.  You can also
use the -b Vim argument.  When this option is switched on a few
options will be changed (also when it already was on):
        'textwidth'  will be set to 0
        'wrapmargin' will be set to 0
        'modeline'   will be off
        'expandtab'  will be off
Also, 'fileformat' and 'fileformats' options will not be used, the
file is read and written like 'fileformat' was "unix" (a single <NL>
separates lines).
The 'fileencoding' and 'fileencodings' options will not be used, the
file is read without conversion.

[..]

When writing a file the <EOL> for the last line is only written if
there was one in the original file (normally Vim appends an <EOL> to
the last line if there is none; this would make the file longer).  See
the 'endofline' option.
```

<p>If you don't do this, and your environment is using a multibyte encoding (e.g.
UTF-8, as most people use), Vim tries to encode the text as such, usually
leading to file corruption.</p>

<p>You can verify this by opening a file, and just using `:w`. It is now
changed.<br>
If you set `LANG` and `LC_ALL` to `C` (ASCII), Vim doesn't convert anything and
the files stay the same (it still adds a newline, though) since Vim won't need
to do any multibyte encoding.</p>

<p>I personally also prefer to <em>disable</em> `set wrap` for binary, although others
might prefer to <em>enable</em> it. YMMV.
Another useful thing to do is `:set display=uhex`. From `:help 'display'`:</p>

```vim
uhex            Show unprintable characters hexadecimal as <xx>
                instead of using ^C and ~C.
```

<p>And as a last tip, you can show the hex value of the character under the cursor
in the ruler with `%B` (`:set rulerformat=0x%B`).</p>

<h5>More advanced: `xxd`</h1>

<p>You can use the `xxd(1)` tool to convert a file to more readable format, and
(this is the important bit), parse the edited "readable format" and write it
back as binary data. `xxd` is part of `vim`, so if you have `vim` installed you
should also have `xxd`.</p>

To use it:  

```vim
$ xxd /bin/ls | vi -
```

Or if you've already opened the file, you can use:  

```vim
:%!xxd
```

<p>Now make your changes, you need to do that on the left-hand side of the display
(the hex numbers), changes to the right-hand side (printable representation) are
ignored on write.</p>

To save it, use `xxd -r`:  

```vim
:%!xxd -r > new-ls
```

This will save the file to `new-ls`.  

Or to load the binary in the current buffer:  

```vim
:%!xxd -r
```

From `xxd(1)`:  

```vim
   -r | -revert
          reverse operation: convert (or patch) hexdump into  binary.   If
          not  writing  to stdout, xxd writes into its output file without
          truncating it. Use the combination -r -p to read plain hexadeci‐
          mal dumps without line number information and without a particu‐
          lar column layout. Additional  Whitespace  and  line-breaks  are
          allowed anywhere.
```

<p>And then just use `:w` to write it. (<strong>beware</strong>: you want to set the `binary`
option before you write to the file, for the same reasons outline above).</p>

Complementary keybinds to make this a bit easier:  

```vim
" Hex read
nmap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>

" Hex write
nmap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>
```

<p>This is also available from the menu if you're using gVim, under 'Tools ➙
Convert to HEX' and 'Tools ➙ Convert back'.</p>

<p>The <a href="http://vim.wikia.com/wiki/VimTip1518" rel="noreferrer">vim tips wiki</a> has a page with more
information and some helper scripts. Personally, I think you're probably better
off using a real hex editor if you're editing binary files that often. Vim <em>can</em>
sort of do the job, but it's obviously not designed for it, and if you ever
write without `:set binary` Vim might destroy your binary files!</p>

#### Answer 2 (score 19)
<p>To view the content of a binary file in a hex view,
open the file, switch on binary mode, and filter the buffer through the `xxd` command:</p>

```vim
:set binary
:%!xxd
```

<p>You can make changes in the left area (edit the hex numbers),
and when ready, filter through `xxd -r`, and finally save the file:</p>

```vim
:%!xxd -r
:w
```

<p>If the filtering step after opening and before closing sounds tedious,
and you often do this with files with `.bin` extension,
you can add this to your vimrc to make the process automatic:</p>

```vim
" for hex editing
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END
```

#### Answer 3 (score 6)
Use the "bvi" editor.  <a href="http://bvi.sourceforge.net/" rel="noreferrer">http://bvi.sourceforge.net/</a>  (It's in every Linux repository.)  

```vim
$ apt-cache show bvi
[snip]
Description-en: binary file editor
 The bvi is a display-oriented editor for binary files, based on the vi
 text editor. If you are familiar with vi, just start the editor and begin to
 edit! If you never heard about vi, maybe bvi is not the best choice for you.
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: Find and replace using regular expressions (score [64492](https://stackoverflow.com/q/3115) in 2019)

#### Question
I have a file with a bunch of user defaults in. I want to change some of the text, but I'm struggling coming up with a matcher and replacer. Using the following example:  

```vim
###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
```

I'd like to replace `# Trackpad: ...` with `running "Trackpad: ..."`  

Breaking the problem down, I came up with something using a regex tester:  

```vim
/\n\n#\s(.*)/g
```

If I try and use this in Vim it doesn't work for me:  

```vim
:/\n\n#\s(.*)/running "\1"/g
```

I guess my problem boils down to two specific questions:  

<ol>
<li>How can I avoid searching for `\n` characters, and instead make sure `#` doesn't appear at the end of the search group?</li>
<li>How can I effectively use capture groups?</li>
</ol>

<hr>

There are some great answers below. Hard to choose between all three, however I feel the chosen answer is the most accurate for my original spec. I recommend you try all three answers with the <a href="https://github.com/squarefrog/dotfiles/blob/f4c5607f1826e85b55fb58e9c81b474a3f67ce91/osx/setup_defaults.sh">actual file</a> to see how you feel about them.  

#### Answer accepted (score 18)
Just to be clear… I believe you asked for this to be the result of the substitution?  

```vim
###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

running "Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
```

In that case, I recommend the following command:  

`:%s/\n\n#\s\+\(.*\)/<b><i>^M^M</i></b>running "\1"/`  

<h5>Explanation of the pattern</h3>

`:s/<i>PATTERN</i>/<i>REPLACEMENT</i>/` is the <a href="https://vimhelp.appspot.com/change.txt.html#%3Asubstitute" rel="noreferrer">substitute</a> command.  The percent sign in `:%s` makes it work on the whole file, rather than just the current line.  

The `\n\n` says that the line of interest must occur after a blank line.  If you didn't care about the preceding blank line, then `^` would suffice.  

`#\s\+` matches a hash character followed by one or more whitespace characters.  `\(.*\)` captures all subsequent text on the line.  

<h5>Explanation of the replacement text</h3>

`<b><i>^M^M</i></b>` inserts two ends of lines to replace the `\n\n` that were present in the pattern.  Otherwise, the text would get moved to the end of the line preceding the blank line.  To type each `<b><i>^M</i></b>`, press <kbd>Ctrl-V</kbd> <kbd>Ctrl-M</kbd>.  

Then, insert the string `running`, followed by whatever was captured in the parentheses within double-quotes.  

#### Answer 2 (score 11)
I would use something like:  

```vim
:s/^#\s\+\(.\{-}\):/running "\1":/
```

<ul>
<li>`^#` to match the `#` character anchored at the start of the line (this answers question 1)</li>
<li>`\s\+` to match any whitespace one or more times</li>
<li>`\(` to start a group (this answers question 2)</li>
<li>`.\{-}\` to match any character 0 or more times <em>in a non-greedy way</em>; this is diffferent from `.*` in that it tries to match as little as possible, and not as much as possible. Try adding a `:` character in the comment to see why this matters</li>
<li>`\)` to end the subgroup.</li>
<li>`:` matches a literal `:`</li>
</ul>

We then replace this with the text you want, and use `\1` to refer to the group we captured.  

<blockquote>
  I came up with something using a regex tester  
</blockquote>

Regular expression syntax is a bit like wiki syntax: there are a bunch of them, they all look alike at a glance, none of them is obviously better than any other, but there are many differences.  

Today, the so called "Perl compatible" regular expressions are the de-facto default in most languages, but Vim regular expressions are <em>not</em> compatible with Perl-compatible expressions! Vim regexp syntax goes back to at least the '70's, when Perl wasn't even around.  

You can see this with the subgroups, where you have to use `\(` and not `(` (this is compatible with POSIX 'basic' syntax, but not with the more common POSIX 'extended' syntax or Perl syntax). You can control this by adding the `\v` flag in a pattern (See <a href="http://vimhelp.appspot.com/pattern.txt.html#/%5CV">`:help /\v`</a> for details), this will make it "more compatible", but not completely (You still have to use `.{-}` for non-greedy matches for example)  

So this might explain why using "a regex tester" almost, but not quite,  works.  

<a href="http://www.vimregex.com/">http://www.vimregex.com/</a> as a good overview/cheatsheet of Vim regexps.  

#### Answer 3 (score 8)
You can:  

<ul>
<li>search for lines that don't end in `#`: `:/[^#]$/`</li>
<li>replace `#\s(.*)` at the start of the line: `s/\v^#\s(.*)/running "\1"/`</li>
</ul>

To use groups, you need to either:  

<ul>
<li>escape the brackets so that they become part of the regex syntax: `\(.*\)`, or</li>
<li>use <a href="https://vi.stackexchange.com/a/2279/205">"magic"</a> by beginning the expression with `\v`: `s/\v...`</li>
</ul>

Combining it:  

```vim
:/[^#]$/s/\v^#\s(.*)/running "\1"/
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: How can I see the full path of the current file? (score [62317](https://stackoverflow.com/q/104) in 2015)

#### Question
When I'm editing a file in Vim, is there a command to see the path of the current file? Sometimes this is very handy if there are multiple files with the same name in a project.  

#### Answer accepted (score 143)
You can press <a href="http://vimhelp.appspot.com/editing.txt.html#CTRL-G" rel="noreferrer">`{count}Ctrl-G`</a>:  

```vim
{count}CTRL-G       Like CTRL-G, but prints the current file name with
                    full path.  If the count is higher than 1 the current
                    buffer number is also given.
```

Pressing <kbd>1</kbd> followed by <kbd>Ctrl</kbd>+<kbd>G</kbd> shows the full path of the current file. If `{count}` is higher than 1, the buffer name will also be shown.  

(Pressing only <kbd>Ctrl</kbd>+<kbd>G</kbd> shows the path relative to Vim's current working directory, as pointed out by Jasper in the comments.)  

You can use the following command in your `.vimrc` to add the full path to the status line, so it is always visible:  

```vim
set statusline+=%F
```

#### Answer 2 (score 54)
Register `%` contains the name of the current file.  

The following commands could be entered to display the information shown:  

```vim
:echo @%                |" directory/name of file
:echo expand('%:t')     |" name of file ('tail')
:echo expand('%:p')     |" full path
:echo expand('%:p:h')   |" directory containing file ('head')
```

If all that is wanted is to display the name of the current file, type `:f`/`:ls` or press <kbd>Ctrl</kbd>-<kbd>g</kbd> (for full path press <kbd>1</kbd> then <kbd>Ctrl</kbd>-<kbd>g</kbd>).  

In insert mode, type <kbd>Ctrl</kbd>-<kbd>r</kbd> then <kbd>%</kbd> to insert the name of the current file.  

The following commands insert lines consisting of the full path of the current and alternate files into the buffer:  

```vim
:put =expand('%:p')
:put =expand('#:p')
```

Source: <a href="http://vim.wikia.com/wiki/Get_the_name_of_the_current_file" rel="noreferrer">Get the name of the current file</a> at vim wikia  

Related:  

<ul>
<li><a href="https://stackoverflow.com/questions/4111696/how-do-you-display-the-filename-of-the-file-you-are-working-on-in-vim">How do you display the filename of the file you are working on in vim?</a> at stackoverflow SE</li>
<li><a href="https://unix.stackexchange.com/questions/104901/how-to-find-out-which-file-is-currently-opened-in-vim">How to find out which file is currently opened in vim?</a> at unix SE</li>
</ul>

#### Answer 3 (score 22)
You can use `:!ls %:p` to get the full path to the current file.  

Depending on the ex context, `%` will either mean the contents of the file or the filename. When shelling out, it represents the file path relative to the current directory. The command '`%:p`' will add the full path filename modifier to `%`.  

There are a few other interesting filename modifiers such as:  

<ul>
<li>`:~`: Get the file path relative to the home directory (this one didn't work for me for some reason)</li>
<li>`:.`: Get the file path relative to the current directory (`%` default)</li>
<li>`:r`: File name root. The name of the file without the extension.</li>
<li>`:e`: File's extension.</li>
<li>`:h`: Split on `/` and return the left half (i.e. if I'm editing a file in a path of `/tmp/test.txt` and run `%:p:h` will return `/tmp`</li>
<li>`:t`: Split on `/` and return the right half (i.e. if I'm editing a file in a path of `/tmp/test.txt` and run `%:p:t` will return `text.txt`</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: How do I change the current split's width and height? (score [60587](https://stackoverflow.com/q/514) in 2019)

#### Question
I am working on split (using ^w+v, ^w+s) buffers, but sometimes I would like to widen a current split or change its height. How can I achieve that?  

#### Answer accepted (score 160)
There are several window commands that allow you to do this:  

<ul>
<li><kbd>Ctrl+W</kbd> <kbd>+/-</kbd>: increase/decrease height (ex. `20<C-w>+`)</li>
<li><kbd>Ctrl+W</kbd> <kbd>>/&lt;</kbd>: increase/decrease width (ex. `30<C-w><`)</li>
<li><kbd>Ctrl+W</kbd> <kbd>_</kbd>: set height (ex. `50<C-w>_`)</li>
<li><kbd>Ctrl+W</kbd> <kbd>|</kbd>: set width (ex. `50<C-w>|`)</li>
<li><kbd>Ctrl+W</kbd> <kbd>=</kbd>: equalize width and height of all windows</li>
</ul>

See also: `:help CTRL-W`  

#### Answer 2 (score 44)
You can also use the `resize` commands:  

<ul>
<li>`:resize [+-]N` - resize a horizontal split, increasing or decreasing height by N characters.</li>
<li>`:vertical resize [+-]N` - resize a vertical split, increasing or decreasing height by N characters.</li>
<li>`:resize N` - resize a horizontal split, setting height to N characters.</li>
<li>`:vertical resize N` - resize a vertical split, setting width to N characters.</li>
</ul>

These are equivalent to the <kbd>Ctrl</kbd><kbd>w</kbd> commands. See <a href="http://vimhelp.appspot.com/windows.txt.html#window-resize">`:help window-resize`</a>.  

#### Answer 3 (score 30)
This is one of the few reasons I like to use vim's mouse mode.  

If you use the GUI version, or your terminal supports sending drag events (such as xterm or rxvt-unicode) you can click on the split line and drag to resize the window exactly where you want, without a lot of guess work using the ctrl-w plus,minus,less,greater combinations.  

In terminal versions, you have to set mouse mode properly for this to work  

```vim
:set mouse=n
```

(I use 'n', but 'a' also works)  

and you have to set the tty mouse type  

```vim
:set ttymouse=xterm2
```

A lot of people say that a lot of time is wasted using the mouse (mostly due to the time it takes to move your hand from the keyboard to the mouse and back), but I find that, in this case, the time saved by having immediate feedback while adjusting window sized and the quickness of re-resizing (keep movving the mouse instead of typing another key sequence) outweighs the delay of moingmy hand.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: How can I clear word highlighting in the current document (e.g. such as after searching for a word)? (score [57992](https://stackoverflow.com/q/184) in )

#### Question
When you search for a word in a file with something like `/console.log`, all of the instances of `console.log` are highlighted.  

When you're no longer interested in these, the highlighting can be distracting. My current strategy for removing the highlighting is to do something like `/asntehua`. Is there a proper way to remove this word highlighting?  

#### Answer accepted (score 47)
As an alternative to `:noh`, I like to do `:let @/=""` mapped to a keyboard shortcut.  

<p>The difference is that `:noh` leaves the search term in the search register, so `n` and `N` in normal mode resume the search by jumping to the next/previous match and re-highlighting.
Using `:let @/=""`, on the other hand, causes the message `E25: No previous regular expression` and <em>leaves your cursor where it was</em>, which is especially convenient if you don't yet know about `ctrl`-`o` yet and accidentally hit `n`.</p>

This can also be used the other way. To cause vim to highlight some text without jumping to it, you can `:let @/="some text"`  

In these expressions, @ lets you refer to a register, and @/ is the register holding the last search pattern.  

#### Answer 2 (score 31)
Simply type  

```vim
:noh<cr>
```

(Where `<cr>` symbolizes a carriage return, i.e. Enter.)  The full non-abbreviated version of this command is `:nohlsearch`.  

For convenience, you can have a mapping such as  

```vim
nnoremap <Leader><space> :noh<cr>
```

in your `.vimrc`. Since my leader is Space, this allows me to clear highlighting simply by tapping space twice. (By default, `<Leader>` is set to `\`)  

Another popular option is to bind it to <kbd>Ctrl</kbd>+<kbd>L</kbd>, since this is more or less the default for 'redrawn terminal screen', which is <em>very roughly what you're</em> doing:  

```vim
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
```

<p>This has the side-effect of <em>also</em> redrawing the terminal screen, which might be slow if your terminal connection is slow (which is very rare these days).<br>
NOTE: If you're using <a href="http://github.com/tpope/vim-sensible" rel="noreferrer">tpope/vim-sensible</a> then it already offers the `<C-l>` mapping listed above.</p>

#### Answer 3 (score 21)


<h5>Disable search highlighting permanently</h2>

Matches won't be highlighted whenever you do a search using <kbd>/</kbd>  

```vim
:set nohlsearch
```

<hr>

<h5>Clear highlight until next search</h2>

```vim
:noh
```

or `:nohlsearch` (clears until <kbd>n</kbd> or <kbd>N</kbd> is pressed or a fresh search is performed)  

<hr>

<h5>Clear highlight on pressing <kbd>ESC</kbd></h2>

```vim
nnoremap <esc> :noh<return><esc>
```

<hr>

<h5>Clear highlight on pressing another key or custom map</h2>

<ul>
<li><p>Clear highlights on pressing <kbd>\</kbd> (backslash)</p>

```vim
nnoremap \ :noh<return>
```
</li>
<li><p>Clear highlights on hitting <kbd>ESC</kbd> twice</p>

```vim
nnoremap <esc><esc> :noh<return>
```
</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: How do I delete a large block of text without counting the lines? (score [57383](https://stackoverflow.com/q/1915) in )

#### Question
In vim, I often need to delete, or yank/put large blocks of text.  

I can count the lines of text and enter something like `50dd` to delete 50 lines.  

But that's a bit of a pain. How can I delete this large block of text <em>without</em> having to know how many lines to delete in advance?  

#### Answer accepted (score 111)
Go to the starting line of your block, and type <kbd>m</kbd><kbd>a</kbd> (mark "a", though you can of course use <em>different</em> letters, and even <em>multiple</em> letters for different marks provided you can keep it straight in your head what each letter is a mark of).  

Then go to the last line and enter <kbd>d</kbd><kbd>'</kbd><kbd>a</kbd> (delete to mark "a") or <kbd>y</kbd><kbd>'</kbd><kbd>a</kbd> (yank to mark "a") <sup>(a)</sup>.  

That will delete/yank all lines from the current to the marked one (inclusive).  

Then you can paste it somewhere else with the normal paste commands, such as <kbd>p</kbd> or <kbd>P</kbd>.  

It's also compatible with `vi` as well as `vim`, on the off chance that your environment is not blessed with the latter.  

<hr>

<sup>(a)</sup> I also use this to save my place in the file if I have to go looking elsewhere for something like, for example, copy-pasting the definition of a function I want to call.  

I simply mark the current line in the same way, <kbd>m</kbd><kbd>a</kbd>, then wander off to find whatever you're looking for.  

Then, once I've found it and copied it to a register, I just enter <kbd>'</kbd><kbd>a</kbd> to go back to mark "a", the line I saved beforehand, where I can then paste it.  

#### Answer 2 (score 65)
In Vim, use <a href="https://vimhelp.appspot.com/visual.txt.html">visual line mode</a>:  

<ol>
<li>Put your cursor on the top line of the block of text/code to remove </li>
<li>Press <kbd>V</kbd> (That's capital "V" : <kbd>Shift</kbd> + <kbd>v</kbd> )</li>
<li>Move your cursor down to the bottom of the block of text/code to remove </li>
<li>Press <kbd> d </kbd></li>
</ol>

For deleting large blocks of text this is preferred over simple visual mode because you don't need to worry about which column the cursor is at.  

#### Answer 3 (score 42)
You can <a href="http://vimhelp.appspot.com/options.txt.html#%27relativenumber%27">`:set relativenumber`</a>, so you don't have to count. ;)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Other ways to exit Insert mode besides Escape (score [57295](https://stackoverflow.com/q/300) in 2015)

#### Question
The primary reason I like vim over emacs is that my hand movement distance away from the home row is very low (even as a programmer). However, the one main time that I do this is leaving insert mode, by pressing Escape.  

I recently learned that I can use Ctrl+C to leave insert mode as well. However, this isn't really an improvement.  

How can I exit insert mode without having my hands leave the home row, and without massively impacting what I have the ability to type? Note: I use a mostly vanilla vim with a dvorak keyboard layout, though I'd love to hear solutions for a qwerty layout as well.  

#### Answer accepted (score 60)
A common binding you'll see is <strong>jj</strong>, because it works well for QWERTY layouts if you use home row positioning.  

```vim
inoremap jj <ESC>
```

In that case, to type a literal `jj` - you should wait for 1 sec (by default) between typing the second character. (see <a href="http://vimhelp.appspot.com/options.txt.html#%27timeout%27" rel="noreferrer">`:help 'timeout'`</a> for details)   

There is also `c-o` which will take you out of insert, letting you do <strong>one</strong> normal command, and then put you right back into insert.  

<a href="http://vim.wikia.com/wiki/Avoid_the_escape_key" rel="noreferrer">http://vim.wikia.com/wiki/Avoid_the_escape_key</a>  

#### Answer 2 (score 38)
<p>Beside the built-in alternatives `<C-[>` and `<C-c>` to `<Esc>` key cited by others, another popular solution is to remap `<CapsLock>` as an additional Escape. 
This both on a Qwerty and Dvorak keyboard. </p>

This way you can press Esc very easily with the left little finger, without removing hands from the HomeRow (incidentally, CapsLock is where Escape used to be on the keyboards when vi was invented).  

Remapping can be done:  

<ul>
<li>on Windows using <a href="http://www.autohotkey.com/" rel="noreferrer">AutoHotKey</a> utility;</li>
<li>on Mac using the <a href="https://pqrs.org/osx/karabiner/" rel="noreferrer">KeyRemap4MacBook</a> utility and others;</li>
<li><p>on Linux, varies according to the Desktop Environment.    For example on Linux Mint/Cinnamon is just a matter of selecting the
proper option in Menu->Keyboard->Keyboard Layouts->Caps Lock behavior. Alternatively, but less easily, it can be remapped at Xorg level using the xmodmap program and having it run the following `.Xmodmap` file:</p>

```vim
clear Lock
keycode 0x42 = Escape
```

The system can be setup to automatically run it at every login by placing strategically the following shell script lines (supposing `.Xmodmap` is on your home dir `~`) in the chain of login auto-sourced files:  

```vim
if [ -s ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi
```

It is tricky however, because actually sourced files vary according to the (desktop) environment used. As example, I have xmodmap called as an entry in the Cinnamon "Startup Applications" (which allows me to do more than the standard GUI key remapping customization).  </li>
</ul>

Some people go even further and program the CapsLock key to behave:  

<ul>
<li>as a `Ctrl` key by pressing and holding it,  </li>
<li>as an `Esc` key by pressing and quickly releasing it.</li>
</ul>

This can be done on Windows and Mac by properly setting/programming the corresponding remap utility (specifically for AutoHotkey hints can be found <a href="https://superuser.com/questions/381296/mapping-caps-lock-to-escape-and-control-on-windows-7">here</a> and for KeyRemap4MacBook check <a href="http://stevelosh.com/blog/2012/10/a-modern-space-cadet/" rel="noreferrer">here</a>). On Linux using the program <a href="https://github.com/alols/xcape" rel="noreferrer">xcape</a>.  

#### Answer 3 (score 28)
The mappings that I use are:  

```vim
inoremap jk <esc>
inoremap kj <esc>
```

This way, you can simply hit <kbd>j</kbd> and <kbd>k</kbd> at the same time, without having to worry about which one you press first.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: How can I change the font size in gVim? (score [49495](https://stackoverflow.com/q/3093) in 2017)

#### Question
Is there a way to change the size of the font in gVim, using native commands?  

And if not, what script can be used to do it quickly?  

#### Answer accepted (score 31)
Set the `guifont` option in your `.gvimrc`. See `:help guifont` and `:help setting-guifont`.   

Specifically, you can do something like: `set guifont=Consolas:h11` to use 11-point Consolas in gvim on Windows. There are a few other options you can use (each separated with a `:`), such as `:b` for bold, although some of these are only available on certain platforms.  

The `:h` option to set the font size as demonstrated is probably the most useful, and the one specifically related to changing the <em>size</em> of the font, as you requested.  

#### Answer 2 (score 29)
If you want to simply change the font size in a running GVim instance, type:  

```vim
:set guifont=*
```

A window should pop up letting you set font size as well as pick a new font if desired. You can then ask Vim to print the line you would need to add to your `~/.gvimrc` to make the change permanent:  

```vim
:set guifont?
```

Produces something like the following in the status line:  

```vim
guifont=Hasklig-Light:h16
```

Add that with the prefix `set` to your `~/.gvimrc` to persist.  

#### Answer 3 (score 13)
I have the following in my .vimrc to change font size quickly without changing the font.  Works on Windows and GTK.  I haven't tested other GUIs.  I'm sure I originally copied it from somebody else, but it's been in my rc file so long I don't remember where it came from.  

```vim
if has("unix")
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction
else
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction
endif


if has("gui_running")
    nmap <S-F12> :call FontSizeMinus()<CR>
    nmap <F12> :call FontSizePlus()<CR>
endif
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: How do I fix the status bar symbols in the Airline plugin? (score [48604](https://stackoverflow.com/q/3359) in 2017)

#### Question
I installed the <a href="https://github.com/bling/vim-airline" rel="noreferrer"><strong>Airline</strong></a> plugin in order to have a custom status bar, as seen in the figure below:  

<img src="https://i.stack.imgur.com/ehqwL.gif" alt="Enter image description here">  

However, my status bar is presenting the symbols <kbd>&lt;</kbd>, <kbd>>></kbd> and <kbd>&lt;</kbd>. How do I fix this problem?  

<img src="https://i.stack.imgur.com/fTd5U.png" alt="Enter image description here">  

<img src="https://i.stack.imgur.com/StcxB.png" alt="Enter image description here">  

<img src="https://i.stack.imgur.com/pCaOC.png" alt="Enter image description here">  

#### Answer accepted (score 50)
Actually I don't understand why your question is voted down. Honestly at first I too didn't understand what needs to be done to get this nice looking toolbar. Yes I know about the README and other stuff, but I think there should be a `getting started` or `minimum settings` section in the help file.  

Anyway here are the settings.  

<h5>Installing the appropriate fonts</h3>

You need to install fonts into your system with symbols like branching, big triangles etc. They are not standard symbols so you need to install a patched font. You can find a lot of patched fonts here: <a href="https://github.com/powerline/fonts" rel="noreferrer">https://github.com/powerline/fonts</a>.  

<h5>`.vimrc` settings</h3>

From `:help airline-customization`, place this code into your .vimrc file:  

```vim
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
```

The `unicode symbols` section is unnecessary here if you already have a patched font but it gives you a nice fallback if you try to use other font which doesn't have the appropriate symbols.  

<h5>Font settings</h3>

If you use Vim in terminal you should switch to the appropriate font in profile preferences of your terminal.  

If you use gui version of Vim (MacVim, GVim) you need to set the font in `.vimrc`, for example: `set guifont=DejaVu\ Sans:s12`. You can find more information here `:help guifont`.   

#### Answer 2 (score 12)
From the <a href="https://github.com/bling/vim-airline#user-content-integrating-with-powerline-fonts">README</a>:  

<blockquote>
  <h5>Integrating with powerline fonts</h1>
  
  For the nice looking powerline symbols to appear, you will need to install a patched font.  Instructions can be found in the official powerline <a href="https://powerline.readthedocs.org/en/master/installation.html#patched-fonts">documentation</a>.  Prepatched fonts can be found in the <a href="https://github.com/Lokaltog/powerline-fonts">powerline-fonts</a> repository.  
  
  Finally, you can add the convenience variable `let g:airline_powerline_fonts = 1` to your vimrc which will automatically populate the `g:airline_symbols` dictionary with the powerline symbols.  
</blockquote>

#### Answer 3 (score 5)
This took hours to figure out, so here's more of a dummies guide for Fedora/Ubuntu, with a special section for Windows.  

The first is figuring out what the hell are those strange but nice angle brackets that appear in the vim-airline status bar. The background is that airline is a pure vim version of powerline (which was python), and powerline uses UTF-8 characters to insert those angle brackets. So vim-airline just uses the same UTF-8 characters.  

Then even if you do manage to get one installed they look uglier than you'd hope because the fonts don't fully work.  

<h5>Configuring Vim</h2>

This is opposite to the <a href="https://github.com/vim-airline/vim-airline#integrating-with-powerline-fonts" rel="nofollow noreferrer">official instructions</a> but I had this bit wrong at the end which made me question all the font installations. So I suggest you get this configured first and then if you get the fonts working it should magically appear.  

The final trick was forcing vim-airline to use the fonts it needs. In the <a href="https://github.com/vim-airline/vim-airline#integrating-with-powerline-fonts" rel="nofollow noreferrer">official documentation</a> it should just be adding `let g:airline_powerline_fonts = 1` in your `.vimrc`. However I did this and no luck. There's more information in `:help airline-customization` and that gives you some simple config settings that you need, just in case. This was the final magic sauce that I needed. I don't know why this wasn't automatically created. Copy and paste the settings mentioned in <a href="https://vi.stackexchange.com/a/3363/11986">Alexander Myshov's accepted answer here</a>.  

<h5>Kitchen sinking it on Fedora and Ubuntu</h2>

This is probably an overkill solution, but first you need to get it consistently working before you can simplify it.  

<ol>
<li><p>Install the general powerline font `sudo dnf install powerline-fonts` (or `sudo apt install fonts-powerline`) - this should mean that you can use any font you already have installed. If you don't have an easy way of installing like dnf/apt then there's instructions for manually doing it e.g. <a href="https://www.tecmint.com/powerline-adds-powerful-statuslines-and-prompts-to-vim-and-bash/" rel="nofollow noreferrer">https://www.tecmint.com/powerline-adds-powerful-statuslines-and-prompts-to-vim-and-bash/</a>, also the official documentation has instructions (<a href="https://powerline.readthedocs.io/en/latest/installation/linux.html#fonts-installation" rel="nofollow noreferrer">https://powerline.readthedocs.io/en/latest/installation/linux.html#fonts-installation</a>).</p>

Now close your terminal re-open and check that the Powerline symbols font is available if you edit the terminal preferences and set a custom font. <strong>You don't want to use the font directly, just check that it's available</strong>. Now try opening Vim and see if you have nice symbols.  </li>
<li><p>If the general powerline font didn't work or if you're trying to improve things you can try installing individual 'patched' fonts, this took a while to figure out, but you can literally just go to the folder you want in <a href="https://github.com/powerline/fonts/" rel="nofollow noreferrer">https://github.com/powerline/fonts/</a> and download it, the font that I've liked the most from my tests is the <a href="https://github.com/powerline/fonts/tree/master/SourceCodePro" rel="nofollow noreferrer">Source Code Pro patched font</a>. Then just open the downloaded font file and click on 'Install'.</p>

If you'd rather the command line, you can install <a href="https://github.com/vim-airline/vim-airline/wiki/FAQ#the-powerline-font-is-not-perfectly-lined-up-or-there-a-bit-of-whitespace-in-between-symbols-or-they-are-cut-off" rel="nofollow noreferrer">all patched fonts</a>:  

```vim
 $ git clone https://github.com/powerline/fonts.git --depth=1
 $ fonts/install.sh
 $ rm -rf fonts
```

This will install <strong>all</strong> the patched mono fonts, but then this gives you a chance to explore the possible fonts. The font list it installs is a pretty awesome list of the available source code fonts. It also means you don't have to faff around installing each of the individual fonts that get included.  </li>
<li>Check that the font can be specified in the terminal preferences, re-open your terminal session if you're missing fonts, so note there could be two options here:

<ol>
<li>The general powerline font is working in which case you can just use the base font e.g. DejaVu Sans Mono</li>
<li>If you can't get that working the patched font that you downloaded above should be correct e.g. the equivalent for DejaVu is 'DejaVu Sans Mono for Powerline'.</li>
</ol></li>
</ol>

<h5>Tweaking Linux</h2>

Once I actually got it working for the first time, it was really disappointing as the icons didn't fully match up. But as per the <a href="https://github.com/vim-airline/vim-airline/wiki/FAQ#the-powerline-font-is-not-perfectly-lined-up-or-there-a-bit-of-whitespace-in-between-symbols-or-they-are-cut-off" rel="nofollow noreferrer">FAQ</a> we need to do some tweaking. I started off with Inconsolata as this gives me a consistent font across Windows and Linux. You can install the general font easily on Ubuntu with `apt install fonts-inconsolata` This is what I got:  

<a href="https://i.stack.imgur.com/QObBQ.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/QObBQ.png" alt="enter image description here"></a>  

The arrows are too large and are shifted up in an ugly manner.  

Then I tried all the other default Ubuntu fonts.  

Ubuntu mono:  

<a href="https://i.stack.imgur.com/6O5aM.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/6O5aM.png" alt="enter image description here"></a>  

DejaVu Sans Mono:  

<a href="https://i.stack.imgur.com/ogv8M.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/ogv8M.png" alt="enter image description here"></a>  

This has the vertical position correct but the right hand side arrows have a space after them.  

<h5>Why you use the patched fonts</h3>

Using the default fonts relies on the Powerline font to automatically patch existing fonts. However you can improve the look of the airline symbols by using the patched fonts. These are the equivalents using the patched fonts.  

I display these all at font size 16 as I like to use a larger font, plus it shows up minor issues.  

Inconsolata for Powerline:  

<a href="https://i.stack.imgur.com/3pSpp.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/3pSpp.png" alt="enter image description here"></a>  

This still has issues, but they are almost all solved by the dz variation.  

Inconsolata-dz for Powerline dz:  

<a href="https://i.stack.imgur.com/2TCQN.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/2TCQN.png" alt="enter image description here"></a>  

This has a hairline fracture on the right hand side arrows, but is otherwise perfect.  

Ubuntu Mono derivative Powerline Regular:  

<a href="https://i.stack.imgur.com/nX0d0.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/nX0d0.png" alt="enter image description here"></a>  

This still has annoying issues.  

DejaVu Sans Mono for Powerline Book:  

<a href="https://i.stack.imgur.com/CJAh4.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/CJAh4.png" alt="enter image description here"></a>  

This has a hairline fracture on the right hand side arrows, but is otherwise perfect. I actually prefer it to the Inconsolata-dz as the LN icon is more readable.  

On top of these regulars, I tried almost all the available fonts and my other favourite was Source Code Pro.  

Source Code Pro for Powerline Medium  

<a href="https://i.stack.imgur.com/6Ifts.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/6Ifts.png" alt="enter image description here"></a>  

This does have issues at size 16 where the arrows are too big, but at size 14 it's almost unnoticeable. The branch and LN icons do overflow to the bottom, but somehow this doesn't annoy me.  

Source Code Pro for Powerline Light  

<a href="https://i.stack.imgur.com/tPqbT.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/tPqbT.png" alt="enter image description here"></a>  

This almost completely solves the issues of the medium font's arrow sizes and makes it about perfect, although there's still the icon overflow.  

<h5>Source Code Pro</h3>

When I was investigating the options for fonts there's a couple of things you notice, some font patches have the absolute minimum in details, if you compare this to the Source Code Pro list it's quite significant. Source Code Pro is a very detailed and complete font that has been considered to work in a large range of scenarios. This kind of completeness matters for edge cases.  

Used as a patched font it almost perfectly displays the vim-airline bar. The benefit of so many alternatives is the use of the light font which has an even better display of the vim-airline bar.  

Source Code Pro is also under continued open development on <a href="https://github.com/adobe-fonts/source-code-pro" rel="nofollow noreferrer">Adobe's Github repository</a>.  

<h5>Handling the delicate flower of Windows (assuming GVim)</h2>

The Powerline Font doesn't work with Windows so your only choice is to use a patched font. Also the bash script to install all the fonts doesn't work, so you have to do the same `git clone` but then go into each of the individual directories and install the fonts you want.  

I downloaded all of the <a href="https://github.com/powerline/fonts/tree/master/SourceCodePro" rel="nofollow noreferrer">Source Code Pro patched fonts</a> and installed them. Even though you install them as individual fonts they get added to Windows as a single font 'Source Code Pro for Powerline' with a separate attribute to specify the weight.  

Then (assuming <strong>GVim</strong>) add this to your `.vimrc`:  

```vim
set guifont=Source\ Code\ Pro\ for\ Powerline:h15:cANSI
```

If you want to use the 'Light' font use this.   

```vim
set guifont=Source_Code_Pro_Light:h15:cANSI
```

It doesn't make much sense as it doesn't need to include the 'for Powerline', but that's how it works (I figured it out by setting the font in GVim and then using `set guifont?` to check what GVim used). Also I spotted that when you use GVim to switch the font, the font rendering isn't very good. I initially discounted the Light font because when I switched using the GVim menu it rendered badly, but if you put the below into your `.vimrc` and restart GVim it should look lovely.  

Also a nice thing is that you can set your DOS/Powershell prompt to the same font. Then with the patched font it is also possible to get Powerline working in regular Vim within DOS.  

If you don't believe me, here it is working in Vim in Powershell:  

<a href="https://i.stack.imgur.com/yyeK5.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/yyeK5.png" alt="enter image description here"></a>  

<a href="https://i.stack.imgur.com/huI2x.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/huI2x.png" alt="enter image description here"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How can I easily move a line? (score [48450](https://stackoverflow.com/q/2674) in 2015)

#### Question
What is the command (or shortcut) to move a line up or down in vim? My current workflow is to yank (copy) the line and than delete that line and than to put (paste) that line.  

#### Answer accepted (score 51)
First, you do not need to yank <em>and</em> delete; the latter will also put the deleted contents into the (default or specified) register. Therefore, `ddp` / `ddkP` are common commands to move a line one down / up.  

Alternatively, you can use the `:move` command, i.e. `:move +1` / `:move -2`; this doesn't clobber the register, and you can also move entire ranges. You can easily define key mappings to shorten this.   

If you don't mind plugins (and the additional comfort that often comes with them), both Tim Pope's <a href="http://www.vim.org/scripts/script.php?script_id=1590">unimpaired plugin</a> and my <a href="http://www.vim.org/scripts/script.php?script_id=4140">LineJuggler plugin</a> provide `]e` / `[e` mappings to move lines (and several more; Tim's for a variety of uses, mine focused on handling line(s)).  

#### Answer 2 (score 36)
The easiest is: `:m+` or `:m-2` which is abbreviation for `:move` as Ingo suggested.  

Or using visual mode (<kbd>V</kbd>) by cutting the line (<kbd>d</kbd>/<kbd>x</kbd>) then paste it (<kbd>p</kbd> - below cursor, <kbd>P</kbd> above cursor) after you moved your cursor to the right place before pasting (so in summary it's <kbd>Vxp</kbd>/<kbd>Vdp</kbd>).  

When moving multiple lines in visual mode, then you've to use `:m '>+1` (to move one line down) or `:m '<-2` (to move one line up).  

<hr>

Here is sample useful mapping (<kbd>Shift+ ↑</kbd>/<kbd>Shift+↓</kbd>):  

```vim
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>
```

which is similar to Sublime Text (<a href="http://sublime-text-unofficial-documentation.readthedocs.org/en/latest/reference/keyboard_shortcuts_win.html" rel="noreferrer">Win</a> / <a href="http://sublime-text-unofficial-documentation.readthedocs.org/en/latest/reference/keyboard_shortcuts_osx.html" rel="noreferrer">OSX</a>).  

Here are some suggested at <a href="http://vim.wikia.com/wiki/Moving_lines_up_or_down" rel="noreferrer">vim wikia</a>:  

```vim
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
```

<blockquote>
  In normal mode or in insert mode, press Alt-j to move the current line down, or press Alt-k to move the current line up.  
  
  After visually selecting a block of lines (for example, by pressing V then moving the cursor down), press Alt-j to move the whole block down, or press Alt-k to move the block up.  
</blockquote>

See also:  

<ul>
<li><a href="https://stackoverflow.com/q/741814/55075">Move entire line up and down in Vim</a> at SO</li>
<li><a href="http://vim.wikia.com/wiki/Moving_lines_up_or_down" rel="noreferrer">Moving lines up or down</a> at vim wikia</li>
</ul>

#### Answer 3 (score 11)
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

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: What does :set background=dark do? (score [41525](https://stackoverflow.com/q/12104) in 2017)

#### Question
I didn't put `color xxx` in my `.vimrc`. So I see this when I first open my `.vimrc`.   

<p>`:color` gives me `default` here.
<a href="https://i.stack.imgur.com/oKvmE.png" rel="noreferrer"><img src="https://i.stack.imgur.com/oKvmE.png" alt="Before anything"></a></p>

Then I type `:color darcula`. And it changes to this.  

<p>`:color` gives me `darcula` here (naturally).
<a href="https://i.stack.imgur.com/NCsEE.png" rel="noreferrer"><img src="https://i.stack.imgur.com/NCsEE.png" alt="Change colorscheme"></a></p>

Then I type `:set background=dark`. And it changes to this.  

<p>`:color` gives me `default` here (amazingly).
<a href="https://i.stack.imgur.com/MNPSe.png" rel="noreferrer"><img src="https://i.stack.imgur.com/MNPSe.png" alt="Change background"></a></p>

So my question is, what exactly does `:set background=dark` do?  

I tried `:h background` and didn't find anything helpful. I understand that this command doesn't actually change the background, only vim will change colors accordingly. But I still want to ask this question. Because I'm really happy with the color after `:color darcula` and `:set background=dark` so I wonder how to write my own color scheme without having to put `set background=dark` in my `.vimrc`.  

I took advice from @statox and put `set background=dark` at the last line of my `darcula.vim`. Then `color darcula` gives me the third screenshot. However when I put it at the first line, `color darcula` gives me the second screenshot. Also `set bg=dark` changes it to the third screenshot.  

I assumed by putting it at the first line, I'm telling vim that this colorscheme is designed for a dark background. By putting it at the last line, on the contrast, I let vim assume that this colorscheme is designed for a light background and then make vim change some of it by itself (when it processes the last line).  

If what I assume happened is true, my question is still unanswered. What exactly did vim change, when I use `set bg=dark` AFTER it has loaded a light colorscheme?  

My entire vim configuration is available at <a href="https://github.com/MichaelMa2014/.vim" rel="noreferrer">https://github.com/MichaelMa2014/.vim</a>  

#### Answer accepted (score 30)
<h5>What happens when you `:set background`</h2>

<p>The basic mechanism by which `:set background` works is actually pretty simple, and
it is documented (although not particularly clearly) in `:help 'background'`.</p>

<blockquote>
  <p>When 'background' is set Vim will adjust the default color groups for
  the new value.  But the colors used for syntax highlighting will not
  change.                   <em>g:colors_name</em><br>
  When a color scheme is loaded (the "g:colors_name" variable is set)
  setting 'background' will cause the color scheme to be reloaded.  If
  the color scheme adjusts to the value of 'background' this will work.
  However, if the color scheme sets 'background' itself the effect may
  be undone.</p>
</blockquote>

So what actually happens when the `'background'` option is changed is this:  

<h5>If no colour scheme is currently loaded</h3>

<p>Vim reloads the default colours, using foreground colours deemed appropriate for
the new setting of `'background'`</p>

<h5>If a colour scheme is currently loaded</h3>

<p>Vim reloads the colour scheme. When the colour scheme is loaded, either the
colour scheme sets colours appropriate to the new setting of `'background'`, or
the colour scheme <em>resets</em> `'background'` to the old value.</p>

<p>As you have already described, the `'background'` option is not intended to <em>set</em>
the background, but instead to <em>inform</em> Vim whether the background is dark or
light.</p>

<p>So if the colour scheme resets `'background'`, Vim takes this to mean
that the colour scheme simply doesn't support the new setting of `'background'`.
Since the user has indicated they <em>are using</em> such a background this means that
the current colour scheme is no longer appropriate, and so Vim unsets
`g:colors_name` and then reloads the default colours.</p>

If you'd like to explore the actual code that is run when `'background'` is set, <a href="https://github.com/vim/vim/blob/master/src/option.c#L6261" rel="noreferrer">you can start here</a>.  

<h5>What's happening in your installation</h2>

<p>The odd behaviour you describe (in the first version of your question) can be
explained by this line in the documentation quoted above:</p>

<blockquote>
  When a color scheme is loaded <em>(the "g:colors_name" variable is set)</em>  
</blockquote>

<p>The problem is that your `colors/darcula.vim` file doesn't set this value, and
so even though the colors changed when you invoked `:color darcula`, <em>Vim
doesn't consider a colour scheme to currently be loaded.</em></p>

<p>Therefore, when you call `:set background=dark` Vim carries out the step in the
"If no colour scheme is currently loaded" section above, and sets the default
colours for a dark background. This explains why `:color` then reports
`default`.</p>

<p>(Note, however, that setting the default colours does <em>not</em>, as you might expect,
remove all the colours that had previously been set, and this is why you end up
with the results you see, rather than the colours that are displayed when you
start up Vim in the first place. <a href="http://peterodding.com/code/vim/colorscheme-switcher/#known_problems" rel="noreferrer">There's some discussion of this issue
here</a>)</p>

<p>In short, your colour scheme is misconfigured: See <code>:edit
$VIMRUNTIME/colors/README.txt</code> (in particular the section at the bottom) for
more details on this, and on the interaction between `'background'` and colour
schemes.</p>

#### Answer 2 (score 4)
<p>The doc at <a href="http://vimhelp.appspot.com/options.txt.html#%27background%27" rel="nofollow noreferrer">`:h 'background'`</a>
should provide all the information you need:</p>

<blockquote>
  <p>When set to "dark", Vim will try to use colors that look good on a
  dark background.  When set to "light", Vim will try to use colors that
  look good on a light background.  Any other value is illegal.</p>
</blockquote>

<p>Your colorscheme defines 2 groups of colors: the ones used on a light background
and the ones used on a dark background. The `background` option will tell vim
which group of colors defined by your colorscheme should be used.</p>

<blockquote>
  <p>Setting this option does not change the background color, it tells Vim
  what the background color looks like.  For changing the background
  color, see <a href="http://vimhelp.appspot.com/syntax.txt.html#%3ahi%2dnormal" rel="nofollow noreferrer">`:h :hi-normal`</a>.</p>
  
  <p>When 'background' is set Vim will adjust the default color groups for
  the new value.  But the colors used for syntax highlighting will not
  change.</p>
</blockquote>

<p>That's the follow up of the previous paragraph: It's the colorscheme which
defines the groups of colors and `background` selects one of these groups.</p>

Finally if you want to write your own color scheme without having to put `set background=dark` in your vimrc, remember that a colorscheme is nothing more than a program in vimscript, so nothing stops you from using the command directly in the code of your colorscheme like e.g. <a href="https://github.com/nanotech/jellybeans.vim/blob/master/colors/jellybeans.vim#L58" rel="nofollow noreferrer">jellybeans</a> or <a href="https://github.com/romainl/Apprentice/blob/master/colors/apprentice.vim#L45" rel="nofollow noreferrer">apprentice</a>   

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: How to install YouCompleteMe with Clang completer offline? (score [39070](https://stackoverflow.com/q/7470) in )

#### Question
I have installed YouCompleteMe with Clang completer in OS X 10.10.4, and in my new OS X 10.11.4 I want to reinstall it.  

The previous installation process downloaded about 140MB at very low speed. I have used the main <a href="https://github.com/Valloric/YouCompleteMe/blob/master/README.md#mac-os-x" rel="noreferrer">tutorial</a> to install with these commands (after installing the bundle with <a href="https://github.com/VundleVim/Vundle.vim" rel="noreferrer">Vundle</a>):  

```vim
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```

How can I manually download the additional file and install it offline?  

#### Answer accepted (score 11)
I did the following to install (Although I could copy the whole `~/.vim` directory to the new place instead of steps 3-6):  

<ol>
<li><p>Install vim 7.4:</p>

```vim
brew install vim
```

Note: If you are using mac operating system, make sure you create an alias in your bash_profile pointing to macvim i.e. `which mvim`  </li>
<li><p>Install <a href="https://github.com/VundleVim/Vundle.vim" rel="noreferrer">Vundle</a></p></li>
<li><p>Add `Plugin 'Valloric/YouCompleteMe'` to `~/.vimrc` and run `:PluginInstall` in vim.</p></li>
<li><p>Download <strong>clang+llvm-<em>version</em>-x86_64-apple-darwin.tar.xz</strong> from `Pre-Built Binaries` section of <a href="http://llvm.org/releases/download.html" rel="noreferrer">LLVM Download Page</a> manually (now it is the latest version).</p></li>
<li><p>Make the download directory:</p>

```vim
mkdir -p ~/.vim/bundle/YouCompleteMe/third_party/ycmd/clang_archives
```
</li>
<li><p>Put the downloaded file in that directory.</p>

```vim
mv  clang+llvm-*-x86_64-apple-darwin.tar.xz ~/.vim/bundle/YouCompleteMe/third_party/ycmd/clang_archives
```
</li>
<li><p>Compile YouCompleteMe:</p>

```vim
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```
</li>
</ol>

#### Answer 2 (score 0)
Try something like this :  

Put this at the top of your .vimrc to use Vundle.  

```vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
```

Run following to install:   

```vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cd ~/.vim/bundle
git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
./install.sh --clang-completer
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: What is the purpose of swap files? (score [38781](https://stackoverflow.com/q/177) in )

#### Question
When I edit files, Vim tends to create files named `.<i>filename</i>.swp`, which I find annoying.  From `vim -h`, I see that the `-n` option suppresses the creation of swap files.  

Is there a vimrc directive that I can use to disable swap files by default?  

What is the purpose of swap files, and what functionality would I be missing out on by suppressing them?  

#### Answer accepted (score 89)
<h5>Reasons for swap files</h3>

Swap files store changes you've made to the buffer.  If Vim or your computer crashes, they allow you to recover those changes.  

Swap files also provide a way to avoid multiple instances of Vim from editing the same file.  This can be useful on multi-user systems or just to know if you have another Vim already editing a file.  

<h5>Disabling swap files</h3>

If you want to disable creating swap files entirely (which I wouldn't recommend), then you can add `set noswapfile` to your `.vimrc`.  This sets the global value of the option.  You can then override that for specific buffers by using `:setlocal swapfile` while running Vim.  

<h5>Organizing swap files</h3>

If your issue is more about the extra files spread around your filesystem, then you could aggregate all the swap files in one place.  For example, create a `~/.vim/tmp` directory and then add  

```vim
set directory^=$HOME/.vim/tmp//
```

to your `.vimrc`.  The `'directory'` option contains a list of directories which Vim will use to try and store the swap file.  

The `^=` syntax for `:set` prepends the directory name to the head of the list, so Vim will check that directory first.  

The `//` at the end of the directory name tells Vim to use the absolute path to the file to create the swap file so there aren't collisions between files of the same name from different directories.  

Note that this will prevent Vim from noticing when there are multiple users trying to edit the same file.  Since the swap file isn't in the same directory as the original file, the other user's Vim won't know about the swap file and won't warn them that it's already being edited.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: Does Ex mode have any practical use? (score [37752](https://stackoverflow.com/q/457) in 2018)

#### Question
Vim has an Ex mode that can be entered by entering <kbd>Q</kbd>, and a command line mode that can be entered with <kbd>q</kbd><kbd>:</kbd>. A common complaint amongst new vim users is that they enter these modes accidentally when trying to quit vim. As such, I disable these keys in my `~/.vimrc` to stop myself hitting them accidentally (particularly <kbd>q</kbd><kbd>:</kbd>):  

```vim
map q: <Nop>
nnoremap Q <nop>
```

Although I've read the <a href="http://vimdoc.sourceforge.net/htmldoc/intro.html#Ex" rel="noreferrer">vim documentation on Ex</a>, am a moderately experienced Vim user, and understand the basic idea behind it, I still struggle to find any use for it in my daily vim use. In general it seems less useful than just entering a standard vim command-line command prefixed with <kbd>:</kbd>, as changes are not echoed straight away.  

Does Ex have any practical everyday use in modern Vim? Is there anything that's easier to do in Ex mode than with standard commands? What is the difference between command line mode and ex mode?  

#### Answer accepted (score 81)
`Q` is, as you found, ex mode.  It's not entirely useful to use interactively, but it exists because Vim can be used to emulate the old `ex` binary.  In fact, many systems provide the `ex` command by simply symlinking it to `vim`.  

`q:`, or `:<C-f>`, instead provides a way to browse your command-line history and edit it like a normal buffer.  This makes it easy to find a previous command you ran, edit it with normal Vim commands, and then run the modified command.  The `q/` and `q?` commands exist to provide the same functionality for the search history.  

#### Answer 2 (score 65)
Vim in Ex mode is useful when:  

<ul>
<li>You're in need of editing (multiple) files non-interactively (as part of the script).</li>
<li>Your connection is very slow or screen is not updated after your actions.</li>
<li>Mappings and abbreviations are disabled.</li>
<li>Common keys such as <kbd>Escape</kbd> or <kbd>Control</kbd> doesn't work properly.</li>
</ul>

Basically `vi` is the visual mode for `ex` therefore Vim Ex Mode is just emulation of `ex` (they still run the same code), so it is possible to get to the command mode of `ex` from within vi and vice-versa. There are actually two modes: Ex mode (`vim -e`) and improved Ex mode which allows for more advanced commands than the vi compatible Ex-mode (`vim -E`). See: <a href="https://vi.stackexchange.com/q/2694/467">What is the difference between Ex mode and improved Ex mode?</a>  

<blockquote>
  <p>Ex is the root of a family of editors: `edit`, `ex` and `vi`.  Ex is a super‐
  set of `ed`, with the most notable  extension  being  a  display  editing
  facility.<sup>ex(1)</sup></p>
</blockquote>

Editing files non-interactively is the most common usage and people using it in similar way as `sed` and `awk`, however they're are more stream oriented - they only read the file forward from beginning to end (they're not designed to work with multiple lines) while `vim` is buffer oriented - you can move forward and backward in the file as you like which makes it so powerful.  

Basically:  

<blockquote>
  `sed` is a <strong>S</strong>tream <strong>ED</strong>itor, not a file editor.   
</blockquote>

Nevertheless, people seems to abuse it for trying to edit files and the truth is that it doesn't edit files. Secondly its options such as in-place (`-i`) are non-standard FreeBSD extensions and may not be available on other operating systems. So if you want to avoid unportable code, I/O overhead and bad side effects (such as destroying symlinks) you should use `ex` which is the standard UNIX command-based editor (along with `ed`)<sup><a href="http://mywiki.wooledge.org/BashFAQ/021" rel="noreferrer">BashFAQ</a></sup>.  

<hr>

Other things which I find useful in Ex mode is to use it as a playground (similar to `python` console) where you can execute many commands in a row, working/debugging regular expressions, checking vim configuration, executing external commands or working with registers, etc.  

For example:  

```vim
let @d = '<td></td>'
let @r = '<tr>' . repeat(@d, 5) . '</tr>'
echo @r
let @t = '<table>' . repeat(@r, 5) . '</table>'
reg
```

which is more easier in Ex mode than in normal mode (where you can see only your last command).  

<hr>

<h5>Practical usages</h3>

I've the following aliases in my <a href="https://github.com/kenorb/dotfiles/blob/master/.bash_aliases" rel="noreferrer">`.bash_aliases`</a>:  

```vim
alias trim="ex +'bufdo!%s/\s\+$//e' -scxa"
alias retab="ex +'set ts=2' +'bufdo retab' -scxa"
```

<sup>Note: Using `bufdo` is not <a href="https://unix.stackexchange.com/a/253820/21471">`ex` POSIX-compliant method</a> (as per <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/ex.html" rel="noreferrer">manual</a>), so then you can consider using it with `find` instead. The `!` is used to force switching the buffers without saving (otherwise warning is generated).</sup>  

The first one I'm using to trim the trailing spaces in all my source files, e.g.:  

```vim
trim **/*.php
```

The second one converts <strong>all</strong> tabs into spaces (recursively), e.g.:  

```vim
retab **/*.php
```

For me using `retab` is enough, but there are some downsides described in <a href="https://vi.stackexchange.com/q/495/467">here</a>. Add extra `-V` for increased verbosity output.  

<sup>Note that above examples using zsh/bash4 <a href="http://www.linuxjournal.com/content/globstar-new-bash-globbing-option" rel="noreferrer">globbing</a> (`**`), so make sure your shell supports it and it's enabled.</sup>  

For more practical examples (like parsing html files), check:  

<ul>
<li><a href="https://vi.stackexchange.com/q/788/467">How to edit files non-interactively (e.g. in pipeline)?</a></li>
<li><p><a href="https://vi.stackexchange.com/q/792/467">How to convert a source code file into HTML?</a></p>

E.g.  

```vim
vim -E -s -c "let g:html_no_progress=1" -c "syntax on" -c "set ft=c" -c "runtime syntax/2html.vim" -cwqa myfile.c
```
</li>
</ul>

Also learn further about Ex-mode at:  

<ul>
<li><a href="https://en.wikibooks.org/wiki/Learning_the_vi_Editor/Vim/Modes#Ex-mode" rel="noreferrer">Learning the vi Editor/Vim/Modes: Ex-mode</a></li>
</ul>

#### Answer 3 (score 18)
I rarely use ex-mode, but when I need it I'm grateful for its existance.  

I sometimes access systems via ssh over VPN, and these connections can sometimes get slow. Making the problem worse, I sometimes need to edit a file on the remote side which is, in addition to being behind ssh and VPN, is over a slow serial connection (so, 9600 baud plus a lot of network latency).  

It is times like this that having visual feedback and screen updates becomes more of a hindrance because what I see is delayed (the effect is kind of like talking into a mic but with speakers far away, like in a sports stadium. One's actions become choppy and sometimes confused due to the delayed feedback).  

In this case, having the changes not echoed back is a useful advantage, since I can get more done in less time when I'm not waiting for the screen to update.  

When I'm done making the edits, I go back to visual mode for a one-time screen update to review my work. Then I can go back to ex-mode or save because I'm done.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: How to get intelligent C++ auto-completion (score [37303](https://stackoverflow.com/q/82) in 2015)

#### Question
Some editors (such as visual studio on windows) do C++ autocompletion which understand C++. For example, given:  

```vim
#include <vector>

int main(void) {
  std::vector<int> v;
  v.i
```

In visual studio the auto-completion knows the only method on `std::vector<int>` that starts with an i is `insert`.  

Is it possible to get this kind of autocompletion in vim?  

#### Answer accepted (score 27)
I really like <a href="https://github.com/Rip-Rip/clang_complete">clang_complete</a> for this. It does require clang, and you need to tell it where libclang resides in your system. After that, it works wonderfully.  

People might suggest YouCompleteMe, but to be honest, that plugin is hugely bloated for what it says it does, and it requires way too many steps to install. I also had it segfault Vim on multiple occasions. I couldn't be happier with clang_complete.  

This is what I get when I type `v.`: <img src="https://i.stack.imgur.com/OYcjy.png" alt="clang-complete">  

#### Answer 2 (score 8)
YouCompleteMe (<a href="https://github.com/Valloric/YouCompleteMe">Link</a>) plugin has been work great for me. It uses libclang to generate the autocomplete feature, providing accurate completion.  

It has a lot of customization, specially when working with compilation flags. You can edit the "flag generator" editing a python script per project (<a href="https://github.com/Valloric/ycmd/blob/master/cpp/ycm/.ycm_extra_conf.py">Example</a>). But, to me the main advantage is that it supports <strong>Clang Compilation Database</strong> (<a href="http://clang.llvm.org/docs/JSONCompilationDatabase.html">Link!</a>). This means that you can compile your code normally and ask clang to spit all the flags its used for the compilation, and use those flags with YouCompleteMe. Very handy if you want your autocompletion tool to be aware of your macro definitions or the location of all the headers files in your system without any effort of typing it manually.  

#### Answer 3 (score 3)
YouCompleteMe isn't that hard to install, and it has been quite stable for me, I've migrated from clang_complete to YouCompleteMe years ago. One thing I agree, it's indeed bloated with a huge commit history, many internal dependencies and support for many languages you may not care for but still will end up cloning its associated submodules. That, that's an issue with YouComplemeMe, still.... it does the work.  

I've <a href="https://github.com/oblitum/YouCompleteMe" rel="nofollow">worked on a fork</a> with special purpose to better support C++, you may check this gif showing it off:  

<img src="https://s3.amazonaws.com/f.cl.ly/items/1e2F0A123h331c1G0L0R/SadBart.gif" alt="">  

<a href="https://s3.amazonaws.com/f.cl.ly/items/1e2F0A123h331c1G0L0R/SadBart.gif" rel="nofollow">https://s3.amazonaws.com/f.cl.ly/items/1e2F0A123h331c1G0L0R/SadBart.gif</a>  

It leverages new parameter information that Clang is able to provide, you may learn more about this from this article of mine: <a href="http://nosubstance.me/articles/2015-01-29-better-completion-for-cpp/" rel="nofollow">http://nosubstance.me/articles/2015-01-29-better-completion-for-cpp/</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: How do I configure the Vim airline plugin to look like its own project screenshot? (score [37122](https://stackoverflow.com/q/5622) in 2019)

#### Question
I am trying to get the <a href="http://vimawesome.com/plugin/vim-airline-sad-beautiful-tragic" rel="noreferrer">vim-airline</a> up and running.  

I have required it via vundle in my `~./vimrc`:  

```vim
Plugin 'bling/vim-airline'
```

I have installed it and expected my Vim to look like the screenshot on its project page:  

<img src="https://i.stack.imgur.com/fr5SC.png" alt="Expected Vim theme">  

Yet it looks like this:  

<img src="https://i.stack.imgur.com/iZPE1.png" alt="Actual look of my Vim instance">  

Concerning the fonts, I tried adding:  

```vim
let g:airline_powerline_fonts = 1
```

Yet the icons then are just gibberish.  

What am I missing?  

<hr>

I just found that for the colors, as described in <a href="https://github.com/bling/vim-airline/wiki/FAQ" rel="noreferrer">the FAQ</a>, I can add in my `.vimrc`:  

```vim
set t_Co=256
```

Yet this still leads to line looks distorted:  

<img src="https://i.stack.imgur.com/2mlbT.png" alt="Vim with t_Co=256">  

Especially the Git integration about (branch name with the icon). Or the the way the >-"arrow" is displayed. I want that eye-candy, too. Can I even achieve that in Bash? Or would I need a different shell?  

Basically, I want Vim to look like the example screenshot on the plugin page, as I expected it to be the default of the plugin. How can I achieve that?  

#### Answer accepted (score 25)
One has to realize that the feature implemented by airline are inspired by the <a href="https://powerline.readthedocs.org/en/latest/">powerline</a> plugin.  

Furthermore, I was relying on the docs too much, not realizing that there is well-written airline help document shipped with itself:  

```vim
:h airline
```

Reading its documentation helps understanding the functionality of this plugin.  

<strong>Font</strong>  

As mentioned in the powerline docs:  

<blockquote>
  <p>Powerline uses several special glyphs to get the arrow effect and some
  custom symbols for developers. This requires having either a symbol
  font or a patched font installed in the system. Used application (e.g.
  terminal emulator) must also either be configured to use patched fonts
  (in some cases even support it because custom glyphs live in private
  use area which some applications reserve for themselves) or support
  fontconfig for powerline to work properly with powerline-specific
  glyphs.</p>
</blockquote>

So one can patch existing fonts (<a href="https://powerline.readthedocs.org/en/latest/installation.html#fonts-installation">see the powerline font section</a> docs or you may install a collection or already prepared fonts.  

You can install a powerline font collection via:  

```vim
git clone git@github.com:powerline/fonts.git
cd fontd
./install.sh
```

I have chosen `Meslo LG L DZ for Powerline` in my terminal.  

One has to add to `.vimrc`:  

```vim
let g:airline_powerline_fonts = 1
```

<strong>Colors</strong>  

For the colors, you have to set in your `.vimrc`:  

```vim
set t_Co=256
```

as desribed in the <a href="https://github.com/bling/vim-airline/wiki/FAQ">FAQ</a>.  

<strong>Theme</strong>  

In order to see your current theme, run:  

```vim
 :AirlineTheme
```

for me the default was `dark`.  

You can change them for the current session by:  

```vim
 :AirlineTheme THEME_NAME
```

<a href="https://github.com/bling/vim-airline/wiki/Screenshots">You can find a list of themes here.</a>  

<em>@todo</em>: Find out theme used in the screenshot. I actually like `luna` more, yet that is an entirely different matter.  

My changes currently let vim look like this:  

<img src="https://i.stack.imgur.com/DzrlM.png" alt="current state of vim look">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: How to enable +python feature in vim (score [36047](https://stackoverflow.com/q/11526) in 2017)

#### Question
I want to install a vim plugin, this plugin needs a `+python` feature, so when I open vim and type `:version` it displays `-python`. How can I make it enable?.   

Thanks.  

#### Answer accepted (score 13)
You need to compile Vim yourself or get a prebuilt Vim package that was compiled with Python support.   

If you're on a Debian based system, the easiest way is to download the vim-gnome or vim-gtk package from `apt` (`apt install vim-gtk` for instance). Other distros might have a similar package with python support built in.  

If you'd prefer to compile Vim yourself, download the Vim repository and pass in `--enable-pythoninterp` like so:  

```vim
cd /tmp && git clone https://github.com/vim/vim.git && cd vim
./configure --enable-pythoninterp --prefix=/usr
make && sudo make install
```

On Windows, you can get the Gvim package from <a href="https://github.com/vim/vim-win32-installer/releases/tag/v8.0.0003" rel="noreferrer">here</a> which includes Python support.  

#### Answer 2 (score 6)
<h5>Solution 1 :</h1>

<ul>
<li><p>Install `vim-gtk` package  </p>

```vim
sudo apt install vim-gtk   
```
</li>
<li><p>Set Vim as a default editor  </p>

```vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim.gtk 1   
sudo update-alternatives --set editor /usr/bin/vim.gtk   
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim.gtk 1  
sudo update-alternatives --set vi /usr/bin/vim.gtk   
sudo update-alternatives --install /usr/bin/vi vim /usr/bin/vim.gtk 1  
sudo update-alternatives --set vim /usr/bin/vim.gtk    
```
</li>
</ul>

<h5>Solution 2 :</h1>

Otherwise you need to compile Vim from source code(assuming you're using Debian based system)    

<h5>Prepare your system</h1>

<ul>
<li><p>Install   </p>

```vim
sudo apt install libncurses5-dev \
libgtk2.0-dev libatk1.0-dev \
libcairo2-dev python-dev \
python3-dev git
```
</li>
<li><p>Remove Vim if you already have </p>

```vim
sudo apt remove vim vim-runtime gvim  
```
</li>
</ul>

<h5>configure and make</h1>

```vim
cd /usr && sudo git clone https://github.com/vim/vim.git && cd vim  

sudo ./configure --with-features=huge \
--enable-multibyte \
--enable-pythoninterp=yes \
--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ \  # pay attention here check directory correct
--enable-python3interp=yes \
--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/ \  # pay attention here check directory correct
--enable-gui=gtk2 \
--enable-cscope \ 
--prefix=/usr/local/

sudo make VIMRUNTIMEDIR=/usr/local/share/vim/vim81 
```

<h5>Preparing deb package using <a href="https://wiki.debian.org/CheckInstall" rel="noreferrer">checkinstall</a></h1>

<ul>
<li><p>And install that package   </p>

```vim
cd /usr/vim && sudo checkinstall
```
</li>
<li><p>Or, if want to just create a package use `--install=no` option with checkinstall</p></li>
</ul>

<h5>Set Vim as a default editor</h1>

```vim
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim   
```

<h5>Verify that you're running the new Vim binary by looking</h1>

```vim
vim --version | grep python
```

<p><strong>Reference :</strong><br>
  - <a href="https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source" rel="noreferrer">Building Vim from Source</a><br>
  - <a href="https://manpages.debian.org/stretch/checkinstall/checkinstall.8.en.html" rel="noreferrer">checkinstall</a></p>

#### Answer 3 (score 4)
For Windows you can always grab the very latest patched version of Vim 8.x compiled against the latest external libraries here: <a href="https://tuxproject.de/projects/vim/x64/" rel="nofollow noreferrer">Vim downloads</a>  

At the time of posting the most current versions:  

Latest compiled update: 2017-02-23  

Vim version: 8.0.0363 <a href="ftp://ftp.vim.org/pub/vim/patches/8.0/README" rel="nofollow noreferrer">Official patch log</a>  

Libraries used: Perl 5.24.1, Python 2.7.12, Python 3.6.0, Racket 6.7, Ruby 2.4.0, Lua 5.3.3, Tcl 8.6.4, and libXpm   

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: Is there a way to count the number of occurrences of a word in a file? (score [35456](https://stackoverflow.com/q/93) in 2017)

#### Question
Is it possible to count how many times a word or a pattern appears in a file? This is sometimes useful to find out how many times a function has been called, etc.  

#### Answer accepted (score 93)
Quincy's answer is fine, but there's an exact way to do this which doesn't require editing the buffer:  

```vim
:%s/pattern//ng
```

This will print a message like `3 matches on 2 lines`, and no changes will be made to your buffer.  

The `n` flag makes the `:substitute` command print the number of matches instead of performing an actual substitution; the `g` flag enables reporting of multiple matches per line.  

<hr>

Another thing that might be useful to your use case is to print all lines that match a pattern:  

```vim
:global/pattern/print
```

which can be shortened to:  

```vim
:g/pattern
```

This is one of the simplest uses of the `:global` command (which is mind-bogglingly powerful). It will simply print out all of the lines that match `pattern`, and then (if there is more than one line) you press `Enter` or type another command to make it go away.  

A bit of trivia: This command is the origin of the name `grep`, as it would commonly be described as `g/re/p`, where `re` stands for "regular expression".  

#### Answer 2 (score 15)
`:%s/pattern//n` The `n` flag in the end tells `:s` command to report the number of matches and not actually substitute. Read `:h :s_flags` for more details.  

#### Answer 3 (score 5)
First use `/` to search for a regex, then  

```vim
:%s///gn
```

This is the same as Dhurva's answer, except that it a.) Is easier to use (since you can preview the results of what your regex matches first) and b.) Matches globally with the `g` flag to count <strong>all</strong> occurrences.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: How can I integrate gdb with Vim? (score [34965](https://stackoverflow.com/q/2046) in 2015)

#### Question
Instead of `gdbtui` or `ctrl+x` under `gdb` which shows source code on top of the screen I would like to see this in my Vim editor that would jump between tabs, and buffers accordingly.  

How can I do this?  

#### Answer 2 (score 33)
Among all the plugins I have tried, I found <a href="https://github.com/vim-scripts/Conque-GDB" rel="noreferrer">ConqueGDB</a> to be the best approach. ConqueGDB uses <a href="http://www.vim.org/scripts/script.php?script_id=2771" rel="noreferrer">Conque Shell</a> to embed an interactive shell inside vim, that is used by GDB.  

The workflow with ConqueGDB consists not entering GDB commands on the GDB terminal, you use shortcuts on the vim source code. But you can continue using the GDB prompt if you want, for more advanced commands, or scroll to see the whole debug session.  

Some ConqueGDB default mappings, for example:   

<ul>
<li><kbd>leader</kbd><kbd>r</kbd> : run </li>
<li><kbd>leader</kbd><kbd>c</kbd> : continue</li>
<li><kbd>leader</kbd><kbd>s</kbd> : step</li>
<li><kbd>leader</kbd><kbd>p</kbd> : print variable under cursor</li>
</ul>

Notice how the vim cursor line has been used to issue a GDB 'print row', the current execution of code is in another line (14) and there's a breakpoint on line 10.   

<img src="https://i.stack.imgur.com/83EXU.png" alt="vim with CongueGDB">  

To install with Vundle for example:  

```vim
Plugin 'vim-scripts/Conque-GDB'
```

I use these plugin options:  

```vim
let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly  
```

#### Answer 3 (score 11)
You have several plugins that integrates gdb.  

<ul>
<li>We used to have <a href="http://pyclewn.sourceforge.net/" rel="nofollow noreferrer">pyclewn</a>. The <a href="https://bitbucket.org/xdegaye/etc-merge/issues/1/looking-for-pyclewn#comment-42145498" rel="nofollow noreferrer">project has been discontinued</a> after version 2.3. The last commit has been made in 2016. For the curious ones there is still a <a href="https://github.com/xdegaye/pyclewn" rel="nofollow noreferrer">mirror on github</a> where its author has archived his work. Note: pyclewn used to be the last stage step in the evolution of the other Xavier Degaye's *clewn projects.</li>
<li><a href="https://github.com/idanarye/vim-vebugger" rel="nofollow noreferrer">vim-debugger</a>, that integrates several other debuggers</li>
<li>notEvil's <a href="https://github.com/notEvil/vim-debug" rel="nofollow noreferrer">vim-debug</a>, which acts as as <em>"convenience layer for pyclewn to overcome some drawbacks"</em></li>
</ul>

And there is also a plugin that integrates lldb (from LLVM project)  

<ul>
<li><a href="https://github.com/gilligan/vim-lldb" rel="nofollow noreferrer">vim-lldb</a></li>
</ul>

It seems that Bram is currently (september 2017) working on the integration of gdb from within vim thanks to the new `:terminal` feature. To use it, we need to load <a href="https://github.com/vim/vim/blob/master/runtime/pack/dist/opt/termdebug/plugin/termdebug.vim" rel="nofollow noreferrer">`termdebug` packet</a> (with `:packadd termdebug`), then we'll be able to start a gdb console in a vim window with `:TermDebug (+options)`. IMO, we can consider it to be the future of GDB integration under Vim.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: What is Neovim? How is it different from Vim? And why should I care? (score [33870](https://stackoverflow.com/q/34) in 2015)

#### Question
I've been hearing about <a href="http://neovim.org/">Neovim</a>; how does it differ from Vim? All the points on the homepage are just architectural changes 'under the hood'. As a user, what's the difference for me?  

#### Answer accepted (score 81)
Just like the neovim homepage describes, neovim's objective is to pave the way for a better &amp; more openly community driven open source project.  

The architectural changes not only will bring more stability &amp; improve performance to vim but make the code a lot more maintainable and bring the entry barrier slightly down for anyone who is interested to contribute.  

One of the key changes also includes the core feature of access to executing jobs / tasks asynchronously in vim, which has been one of the most requested feature of vim since a long time. This can help improve performance of vim even further especially because vim will not have to block while a background job is doing something.  

As a vim user, not much might change besides the fact that neovim should grow as a software much faster (fix issues, add features) as compared to stock vim and that it will have much better performance in the long run.  

#### Answer 2 (score 36)
I'm specifically addressing:  

<blockquote>
  Why should I care?  As a user, what's the difference for me?  
</blockquote>

The thing I am most excited about as a Vim user are the new kinds of plugins, integrations, and interfaces that will be enabled by the changes under Neovim's hood.  

As time goes by you will begin to see really impressive plugins and programs that work with Neovim but not Vim.  There's a list of Neovim-specific plugins: <a href="https://github.com/neovim/neovim/wiki/Related-projects#plugins" rel="noreferrer">here in neovim's github</a>.  

I don't know how up-to-date it is, but I am excited to see it grow as we get more tools to make coding more efficient and enjoyable.  

#### Answer 3 (score 15)
My own favorite addition Neovim brings to the table is terminal mode. You can now split your Neovim window and have a terminal emulator running on one side and be editing a file on the other side! I suppose you could even run Neovim inside of itself now, just in case you really wanted to do that.  

Having asynchronous plugins is also going to be extremely useful soon; this means we're finally able to have really good code completion, after only 40 years of waiting!  

Neovim also has better mouse support than Vim does.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: How can I rename the file I'm editing? (score [33764](https://stackoverflow.com/q/305) in 2015)

#### Question
Is it possible to rename the file I'm editing from within Vim? Currently what I do is exit Vim, rename the file and open from Vim again.  

#### Answer accepted (score 33)
You could save the file under a different name using `:w`. But this operation won't remove the old file and the 'old' file stays in your buffer, so any changes will be applied to your 'old' file.  

`:saveas` saves your new file and opens it in a new buffer. But it doesn't delete the old file.  

I use <a href="https://github.com/tpope/vim-eunuch">tpope/vim-eneuch</a> to `:Move` files.  

<blockquote>
  :Move: Rename a buffer and the file on disk simultaneously.  
</blockquote>

#### Answer 2 (score 10)
You could drop to <em>Netrw</em> and rename the file there.  

If the file you're editing is in the current directory, then do:  

```vim
:edit .
```

<p>Navigate to the file, press <kbd>R</kbd>, and change the name.
Press <kbd>Enter</kbd> to edit the file.</p>

<p>There's a caveat though: the original buffer remains in the list of buffers.
If you switch to it, it's empty.</p>

If the file you're editing is in a different directory, you can change to the file's directory with:  

```vim
:cd %:p:h
```

If you don't want to change the directory for the entire Vim session but only for the current buffer, then you can do instead:  

```vim
:lcd %:p:h
```

#### Answer 3 (score 6)
I've been using the <a href="https://github.com/vim-scripts/Rename2" rel="nofollow">Rename2 plugin</a> for this for years. It renames both the current buffer, and the file on disk:  

```vim
:Rename {newname}
```

EDIT: I found this a `.vimrc` file on <a href="https://github.com/garybernhardt/dotfiles/blob/master/.vimrc" rel="nofollow">github</a>:  

```vim
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: How do I stop recording while in command line? (score [32725](https://stackoverflow.com/q/4637) in )

#### Question
When I am recording a macro with `q` and I am done, I can type:  

<ul>
<li>`q` to stop recording if I am in normal or visual mode.</li>
<li>`<c-o>q` to stop recording if I am in insert mode.</li>
<li><p>..</p>

How do I stop recording if my macro ends in command mode?   </li>
</ul>

#### Answer accepted (score 11)
Another solution is when in command line mode, use `Ctrl-f`, and press `q` to stop recording.   

`Ctrl-f` allows you to open the command line window, in which you can edit the command in normal mode. To validate the command, simply use enter.  

<hr>

Therefore, after having added something like:  

```vim
cnoremap <c-q> <c-f>i<c-o>q
```

in your `.vimrc`, you can use `<c-q>` to stop recording a macro while in command mode.  

<hr>

Florent  

#### Answer 2 (score 17)
One way to do it:  

<ul>
<li>start your macro as usual (e.g. `qq` ... other chars)</li>
<li>when you reach the cmdline-mode, write all the characters you want</li>
<li>you want to end the macro here. Hit `ESC` to get out of cmdline-mode, `q` to end your macro.</li>
<li>remove the `ESC` from your `q` register (*): you can paste it in a buffer, remove the `^[` character, select the whole stuff again (character-wise) and yank it back to register `q`.</li>
<li>that's it: run your macro: `@q`.</li>
</ul>

Basically, you "post-process" your macro a little, since it is stored in a register :)  

(*) A quick way to remove the last character from a macro stored in register `q` would be:  

```vim
:let @q = @q[:-2]
```

#### Answer 3 (score 3)
Having read your comment about the use case, it looks like you could use a key mapping instead of a macro.  

I have this line in my .vimrc (don't remember where I found it):  

```vim
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
```

It has a similar effect to the use case you described, putting you on the command line so the only thing you have to do is type the replacement and press enter, but in this case, replacing all occurrences of the word that was under your cursor.  

To just replace within the current block, I think something like the following should work:  

```vim
nnoremap <Leader>s m'va{<ESC>``:'<,'>s/\<<C-r><C-w>\>//g<Left><Left>
```

Of course, you can map it to whatever key you want.  

What the above does: mark the current position using the unnamed marker, visually select the current block, leave visual mode and return the cursor to the saved position (the visual selection markers are still set), enter command mode and type out the substitute command, inserting the word that was under the cursor with `<C-r><C-w>`, and positioning your cursor to type out the replacement.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: Close and unload a buffer without exiting Vim (score [32516](https://stackoverflow.com/q/3066) in )

#### Question
Often, I'll load some information into a temporary buffer, and then close it with `:clo!`.  But this hides the buffer rather than unloading it entirely, even though I have `nohidden` set.  I find this tiresome since I get an extra confirmation when I quit Vim, about content I already (thought I) discarded.  

I could just use `:q!` instead, but that's a bad habit to get into because it will exit Vim entirely if there's only one buffer left, which is also annoying.  Worse, if I typo `:qa!`, I could lose a lot of work.  

Is there a middle ground?  I'd really like some command which kills the current buffer but doesn't exit Vim.  I'm not opposed to writing it in Vimscript, but I'd rather avoid it if the command already exists.  

#### Answer accepted (score 68)
There is command to do exactly that: `:bdelete` or just `:bd`. By default it will unload current buffer. To unload other buffer, first get the list of all buffers with `:buffers` command, and after that you can specify the number after `:bd` to remove it. Also `:bd` + <kbd>space</kbd> + <kbd>tab</kbd> allows completion using buffer name.  

#### Answer 2 (score 27)
You can completely wipe out a buffer using the :bwipeout (or :bw) command.  This completely removes the buffer from memory, including any marks, option settings, etc. that you have added to it.  Similarly, :bdelete (or :bd) removes the buffer, but leaves it in memory and keeps marks and option settings.  

As per the comment by Tom Hale, the Vim documentation recommends using :bd over :bw unless you know what you are doing. I tend to use :bw because like the idea of completely removing the buffer from memory, and I don't make much use of marks, buffer-specific option settings, etc, to the point of needing them to remain after closing my buffer.  

Like the :quit (:q) command, Vim will give an error if the buffer has changed.  To address this, you can append an exclamation point after the command to suppress the prompt.  Another option, instead of adding exclamation points to everything, is to add "set confirm" to your vimrc.  With this set, vim will prompt you to save file changes on close.  

:bufdo is a useful command that performs another command on all active buffers.  Combining the :bufdo command with the :bw/:bd command lets you remove all active buffers at once.  You can still use the exclamation point to suppress errors, but whether you place it after :bufdo, after :bw, or after both causes different results for each:  

```vim
:bd          - deletes the current buffer, error if there are unwritten changes
:bd!         - deletes the current buffer, no error if unwritten changes
:bufdo bd    - deletes all buffers, stops at first error (unwritten changes)
:bufdo! bd   - deletes all buffers except those with unwritten changes
:bufdo! bd!  - deletes all buffers, no error on any unwritten changes

:bw          - completely deletes the current buffer, error if there are unwritten changes
:bw!         - completely deletes the current buffer, no error if unwritten changes
:bufdo bw    - completely deletes all buffers, stops at first error (unwritten changes)
:bufdo! bw   - completely deletes all buffers except those with unwritten changes
:bufdo! bw!  - completely deletes all buffers, no error on any unwritten changes

:set confirm - confirm changes (Yes, No, Cancel) instead of error
```

Here are a few other useful buffer commands:  

```vim
:ls          - list open buffers
:b N         - open buffer number N (as shown in ls)
:tabe +Nbuf  - open buffer number N in new tab
:bnext       - go to the next buffer (:bn also)
:bprevious   - go to the previous buffer (:bp also)
```

<p>There is a lot more to buffer handling that is out of the scope of this question.  Have a look at:<br>
<a href="http://vim.wikia.com/wiki/Vim_buffer_FAQ" rel="noreferrer">http://vim.wikia.com/wiki/Vim_buffer_FAQ</a>
<a href="http://vimdoc.sourceforge.net/htmldoc/windows.html#buffers" rel="noreferrer">http://vimdoc.sourceforge.net/htmldoc/windows.html#buffers</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: How to add indentation guides/lines (score [32447](https://stackoverflow.com/q/666) in 2015)

#### Question
In Sublime Text 2, you get vertical guides where your indentation is, like this:  

<img src="https://i.stack.imgur.com/nxPrP.png" alt="Sublime Text screenshot">  

but in vim I obviously don't:  

<img src="https://i.stack.imgur.com/LEnqM.png" alt="vim screenshot">  

Is there a way to show lines like that in vim? By the way, my indentation is 2 spaces.  

```vim
:set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
```

#### Answer accepted (score 39)
Unified answer:  

<h5>If you are using tabs</h2>

I'd try using listchars:  

```vim
:set listchars=tab:\|\ 
:set list
```

note: there is a space after the last `\` above.  

This method is good because it uses Vim's built-in support for showing this kind of thing.  

Example output:  

```vim
|       if (1) {
|       |       func();
|       }
```

<img src="https://i.stack.imgur.com/KrK5w.png" alt="screenshot of text sample above">  

However, this doesn't work for leading spaces. As pointed out by @Josh Petrie, <a href="http://vim.1045645.n5.nabble.com/Patch-support-for-the-quot-space-quot-argument-for-quot-listchars-quot-td1210494.html" rel="noreferrer">there is a patch to work for spaces</a>, but then you'd have to recompile Vim, which is beyond the scope of this answer.  

<h5>If you are using spaces, and don't mind using a plugin</h2>

Vaibhav Sagar points out the plugin <a href="https://github.com/Yggdroot/indentLine" rel="noreferrer">indentLine</a> performs this functionality.  

Install in the normal way (see <a href="https://vi.stackexchange.com/questions/613/how-to-install-a-plugin-in-vim-vi">installing Plugins</a>) and it seems to magically just work without further input. If you don't mind the ASCII bars, you don't need to do anything with your fonts. Example output of your example after setting your indentation settings and running `:IndentLinesReset`  

```vim
45   ¦ var move = function(direction) {
46   ¦ ¦ if(!initialized) { initialize(); }
47 
48   ¦ ¦ if(shiftBoard(direction)) {
49   ¦ ¦ ¦ setTimeout(addRandomPiece, 100);
50   ¦ ¦ }
51   ¦ };
```

<img src="https://i.stack.imgur.com/JyLPY.png" alt="screenshot of example with spaces">  

The plugin requires Vim 7.3 or later, and makes cleaver use of that version's Conceal feature. Instead of actually hiding text, it replaces text with bars in the view, but not the actual buffer. The result is you see the bars but they don't get saved into the file (since they are actually spaces)  

<h5>Caveat</h2>

Both of these methods assume "properly" indented code. They don't place the indentation lines at the level of indent when a "block" is opened (which sublime appears to do) but instead places lines at regular intervals based on your indentation settings. Additionally, it only shows the bars on lines where there is actually space (which is why the line in the vim output under the first `if` has no bars, making a visual gap)  

#### Answer 2 (score 19)
Another option I use, which isn't exactly what you asked for, but accomplishes the same purpose of making it easier to see what is in the same column, is to set the following in your `vimrc`:  

```vim
set cursorcolumn
set cursorline
```

<a href="https://i.stack.imgur.com/TZmWT.png" rel="noreferrer"><img src="https://i.stack.imgur.com/TZmWT.png" alt="cursorcolumn illustration"></a>  

This has the trade off that you have to move your cursor to the column you want to see, but you get less visual clutter.  Usually when I care about indentation levels, I'm keeping my place with the cursor anyway.  My way also isn't as awkward-looking in languages like python without closing braces.  

#### Answer 3 (score 18)
For the sake of completeness, there is also the <a href="https://github.com/nathanaelkane/vim-indent-guides" rel="noreferrer">Indent Guides</a> plugin, which shows the indentation levels by alternating the colors of white spaces. It requires version 7.2 or later. Since it uses the `tabstop` and `shiftwidth` variables, it will probably work for your indentation settings right away.   

<img src="https://i.imgur.com/qyctWU5.png" alt="Imgur">  

Once the plugin is installed, you can simply use`:IndentGuidesEnable` or `:IndentGuidesDisable`. If you are using terminal vim, note that, according to the manual,  

<blockquote>
  At the moment Terminal Vim only has basic support. This means is that colors won't be automatically calculated based on your colorscheme. Instead, some preset colors are used depending on whether background is set to dark or light.  
</blockquote>

In order to change the colors of the guides for the screenshot, I used the following  

```vim
let g:indent_guides_auto_colors=0
```

so the colors are not recalculated when buffers are swapped, and then set the colors using  

```vim
hi IndentGuidesEven ctermbg=238
hi IndentGuidesOdd ctermbg=236
```

As with the other solutions presented, it only shows the indent guides on lines were there are spaces.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: How to execute shell commands silently? (score [31968](https://stackoverflow.com/q/1942) in 2015)

#### Question
`:!<command>` can be used to execute a command in the shell. But this "takes over" my terminal and fills it with `stdout` of that particular command.   

How do I execute a command in the background that only notifies me on a non-zero exit code?  

#### Answer 2 (score 52)
`:silent exec "!command"`  

Note that your vim session will still be occupied while your command is executing. This is due to Vim's synchronous nature. You can still get back to your shell by pressing CTRL+z (to send Vim to the background) and then resume vim with the command `fg` as usual.  

To do things asynchronously, take a look at Tim Pope's plugin <a href="https://github.com/tpope/vim-dispatch" rel="noreferrer">vim-dispatch</a> or the project NeoVim which has native support for asynchronous command execution, which you can easily leverage using the plugin NeoMake. The latest version of Vim also has support for asynchronous tasks.  

See <a href="http://vimhelp.appspot.com/various.txt.html#%3Asilent" rel="noreferrer">:h :silent</a>  

#### Answer 3 (score 30)
To execute a command without triggering the Enter message, like:  

<blockquote>
  Press ENTER or type command to continue  
</blockquote>

try the following simple example:  

```vim
:silent !echo Hello
```

Then press <kbd>Ctrl</kbd>+<kbd>L</kbd> (or `:redraw!`) to refresh the screen when back to Vim.  

To avoid need for refresh, you can define your own custom command, like:  

```vim
:command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
```

Now, you can use the new Vim command to run a shell command (note: without <em>!</em> and with capital <em>S</em>):  

```vim
:Silent ps
```

Source: <a href="http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts" rel="noreferrer">Avoiding the "Hit ENTER to continue" prompts</a> at the Vim Wikia site  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How can I get gVim on Windows to behave as on Linux? (score [29967](https://stackoverflow.com/q/7457) in 2018)

#### Question
I am a frequent user of the Vim editor on Linux and now I want to use it on Windows.  

I downloaded Vim for Windows, which happens to be gVim. Several features of Vim doesn't work in gVim 7.4 like visual block, `rx` command, and several other key combinations.  

I want the same/original Vim from Linux to be used on Windows. Is that version available for Windows too? Or, can I use settings similar to the Unix format?  

#### Answer accepted (score 14)
When I have to work on Windows (which is more often than I would like), I use Cygwin to get a terminal a little less crappy than the original Windows command line. Cygwin provides an environment which tries to be close to a Bash console with standard Linux commands, and of course it is far from being flawless.  

See the <a href="http://www.cygwin.com/" rel="noreferrer">project page</a> of Cygwin. During the installation you'll end on a window allowing you to choose which packages you want to install. The search bar allows to look for packages to install, among other useful stuff (like `git`, `tmux`, `curl`, `wget`, etc.) you can type `vim` and select packages like `vim`, `vim-common`, `vim-doc`, `gvim`. This will install a Vim editor pretty close to what you're used to on Linux.  

Once everything is installed (which can sometimes be a little long) you'll be able to start Cygwin which will show a terminal, and you'll be able to start Vim as usual and use your Linux `.vimrc` and your usual plugin manager. The main drawback is the compatibility of colors which often needs to be tweaked and still look crappy.  

<strong>Note</strong> that I use Cygwin out of habit, but other solutions (like <a href="http://cmder.net/" rel="noreferrer">cmder</a> for example) exist. None of them are flawless, so you might want to try several and find your favorite.  

<strong>Also note</strong> that <a href="https://mintty.github.io/" rel="noreferrer">mintty</a> is a good way to make Cygwin a little less crappy.  

#### Answer 2 (score 11)
As of Windows 10 Anniversary Update, you can use the <a href="https://msdn.microsoft.com/en-us/commandline/wsl/about" rel="noreferrer">Bash on Ubuntu terminal</a> to run a Linux subsystem where you can `apt install` anything you're used to inside Ubuntu. Your Windows file system is mounted so you can use Vim inside the shell to edit your files.  

#### Answer 3 (score 4)
As Roflo and Rich mentioned in their comment <a href="https://vi.stackexchange.com/questions/7457/which-alternatives-to-gvim-exist-on-windows#comment12229_7457">here</a> and <a href="https://vi.stackexchange.com/questions/7457/which-alternatives-to-gvim-exist-on-windows#comment16039_7457">here</a>, your problem with being unable to use visual block (I'm not sure what `rx` command is) is because the system-wide vimrc (`$VIM\_vimrc`) sources `$VIMRUNTIME\mswin.vim` which defines Windows-style mappings like <kbd>Ctrl</kbd>+<kbd>v</kbd> for paste, <kbd>Ctrl</kbd>+<kbd>c</kbd> for copy, <kbd>Ctrl</kbd>+<kbd>x</kbd> for cut.  

The easiest way to get around this is to create a `_vimrc` files in your home directory (Note that Windows version of vim uses `_vimrc` instead of `.vimrc`). As you can see in `:h vimrc`, vim looks for vimrc in several locations and only uses the first one it finds while ignoring the rest. The one in the home directory is always searched/used first.  

Minimal steps:  

<ul>
<li>open gvim or vim</li>
<li>`:e ~/_vimrc`</li>
<li>`:w`</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: Setting TAB to 2 spaces (score [29213](https://stackoverflow.com/q/13080) in )

#### Question
I've looked through various answers which imply that setting the following in .vimrc would be appropriate to force tab insertions to become spaces.  

```vim
filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
```

However, when I attempt to use 2 spaces, it continues to default to 4 spaces per tab. I have tried moving `set expandtab` to the bottom of these declarations. I have tried removing the `softtabstop` declaration. I've scoured the various answers given to other questions as well. If anyone can help me out that would be amazing.  

#### Answer accepted (score 5)
Have you sourced your `.vimrc` since making these changes? When having vim open just type `source ~/.vimrc` (assuming it is in it's default location)  

EDIT: <a href="https://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces">This could help too</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: Is there an easy way to close a scratch buffer/preview window? (score [28792](https://stackoverflow.com/q/4056) in 2015)

#### Question
One of the plugins I have installed (probably Supertab) provides a nice view of documentation for the currently highlighted item in the completion menu:  

<a href="https://i.stack.imgur.com/fVILE.png"><img src="https://i.stack.imgur.com/fVILE.png" alt="enter image description here"></a>  

The (apparently) scratch buffer remains open even after I exit the completion (by pressing <kbd>Enter</kbd> or <kbd>Space</kbd>). Then, to quit it, I do `<c-w>↑:q`, but I find having to press <kbd>Ctrl</kbd> extremely annoying (one reason why I avoid splits).  

What's a quick way to close this scratch buffer? Is there a native way, or do I have to write a mapping?  

#### Answer accepted (score 66)
The top window is called the preview window. So any of `<c-w>z`, `<c-w><c-z>` or `:pc[lose][!]` should work.  

The below is the help for `:help :pclose`  

<pre>
CTRL-W z        CTRL-W_z
CTRL-W CTRL-Z   CTRL-W_CTRL-Z
:pc :pclose
:pc[lose][!]    Close any "Preview" window currently open.  When the 'hidden'
                option is set, or when the buffer was changed and the [!] is
                used, the buffer becomes hidden (unless there is another
                window editing it).  The command fails if any "Preview" buffer
                cannot be closed.  See also :close.
</pre>

Another relevant help page would be `:help preview-window`  

#### Answer 2 (score 29)
For my specific case, the preview window was opened by plugins. So, I used plugin configuration to automatically close these windows.  

<h5>Supertab</h3>

As suggested by Alex Kroll:  

```vim
let g:SuperTabClosePreviewOnPopupClose = 1
```

<h5>YouCompleteMe</h3>

```vim
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
```

If the second variable is set, the first has no effect. From the docs:  

```vim
The *g:ycm_autoclose_preview_window_after_completion* option

When this option is set to '1', YCM will auto-close the 'preview' window after
the user accepts the offered completion string. If there is no 'preview' window
triggered because there is no 'preview' string in 'completeopt', this option is
irrelevant. See the |g:ycm_add_preview_to_completeopt| option for more details.

Default: '0'
>
  let g:ycm_autoclose_preview_window_after_completion = 0
<
-------------------------------------------------------------------------------
The *g:ycm_autoclose_preview_window_after_insertion* option

When this option is set to '1', YCM will auto-close the 'preview' window after
the user leaves insert mode. This option is irrelevant if
|g:ycm_autoclose_preview_window_after_completion| is set or if no 'preview'
window is triggered. See the |g:ycm_add_preview_to_completeopt| option for more
details.

Default: '0'
>
  let g:ycm_autoclose_preview_window_after_insertion = 0
```

#### Answer 3 (score 4)
another nice option, which is relevant also in other cases, is using `:only` to close all other windows, including the preview:  

```vim
:on[ly][!]
:{count}on[ly][!]
CTRL-W o                        *CTRL-W_o* *E445*
CTRL-W CTRL-O                   *CTRL-W_CTRL-O* *:on* *:only*
    Make the current window the only one on the screen. All other
    windows are closed. For {count} see |:quit|.
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: How to install NERDTree with Vundle? (score [28784](https://stackoverflow.com/q/5335) in 2016)

#### Question
I'm starting to use Vim and I chose Vundle instead of Pathogen.  

I would like to know if I can install the NERDTree using Vundle.  

I'm starting Vim and searching for NERDTree like this:  

```vim
:BundleSearch NERDTree
```

But it is not finding the plugin, only:  

```vim
"Keymap: i - Install plugin; c - Cleanup; s - Se|
arch; R - Reload list                           |~                                               
"Search results for: NERDTree                   |~                                               
Plugin 'nerdtree-ack'                           |~                                               
Plugin 'FindInNERDTree'  
```

#### Answer accepted (score 31)
Below is the empty Vundle config.  

```vim
set nocompatible 
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
```

<p>Now if you want to add a new plugin example 
<a href="https://github.com/scrooloose/nerdtree">nerdtree</a></p>

you just add the line   

<strong>`Plugin 'scrooloose/nerdtree'`</strong>  

now the vimrc will look like this  

```vim
set nocompatible 
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" added nerdtree
Plugin 'scrooloose/nerdtree'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
```

Now, just save the vimrc and restart vim so it can source the new vimrc then issue the <strong>:PluginInstall command:</strong>  

```vim
:PluginInstall
```

more information on using can be found <a href="https://www.digitalocean.com/community/tutorials/how-to-use-vundle-to-manage-vim-plugins-on-a-linux-vps">here</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: What is the Vim8 package feature and how should I use it? (score [28596](https://stackoverflow.com/q/9522) in 2017)

#### Question
Vim 8 was released <a href="https://github.com/vim/vim/releases/tag/v8.0.0000" rel="noreferrer">today</a> and the <a href="https://raw.githubusercontent.com/vim/vim/master/runtime/doc/version8.txt" rel="noreferrer">release notes</a> mentions a new "package" feature. What is it and how should I use it?  

Most importantly, does it replace the good old <a href="https://vi.stackexchange.com/q/388/1841">plugin managers</a>?  

#### Answer accepted (score 74)
First of all, the relevant documentation can be found with <a href="http://vimhelp.appspot.com/repeat.txt.html#packages" rel="noreferrer">`:h packages`</a> on the newly compiled Vim8 version and <a href="https://github.com/vim/vim/blob/master/runtime/doc/repeat.txt#L459" rel="noreferrer">here on Github</a>.  

A first important note is about the vocabulary: In Vim8 a package is defined like this:  

<blockquote>
  A Vim package is a directory that contains one or more plugins.  
</blockquote>

This means that the new package manager was created to help users manage all of their plugins in the same archive. The doc lists the following advantages:  

<blockquote>
  <ul>
  <li><p>A package can be downloaded as an archive and unpacked in its own directory.
  Thus the files are not mixed with files of other plugins.  That makes it
  easy to update and remove.</p></li>
  <li><p>A package can be a git, mercurial, etc. repository.  That makes it really
  easy to update.</p></li>
  <li><p>A package can contain multiple plugins that depend on each other.</p></li>
  <li><p>A package can contain plugins that are automatically loaded on startup and
  ones that are only loaded when needed with `:packadd`.</p></li>
  </ul>
</blockquote>

So the idea is to create a folder containing all of the plugins with the following structure:  

```vim
$HOME/.vim/pack/my-plugins/
                        start/
                            foo/
                                plugin/
                                    foo.vim
                                syntax/
                                    some.vim
                            bar/
                                plugin/
                                    bar.vim
                        opt/
                            buzz/
                                plugin/
                                    buzz.vim
```

The emplacement of the folder is defined by the option `packpath` (See <a href="http://vimhelp.appspot.com/options.txt.html#%27packpath%27" rel="noreferrer">`:h 'packpath'`</a>).  

Note the importance of the structure of your folder:  

<ul>
<li>The `start` folder contains plugins which will be loaded automatically on startup.</li>
<li>The `opt` folder contains "optional" plugins, loaded with the `packadd` command.</li>
<li>The subfolders (`plugin`, `autoload`, `doc`,...) are the ones you're used to in the plugins.</li>
</ul>

Here is a recap of the folders:  

```vim
start/foobar/plugin/foo.vim     " always loaded, defines commands
start/foobar/plugin/bar.vim     " always loaded, defines commands
start/foobar/autoload/foo.vim   " loaded when foo command used
start/foobar/doc/foo.txt        " help for foo.vim
start/foobar/doc/tags           " help tags
opt/fooextra/plugin/extra.vim   " optional plugin, defines commands
opt/fooextra/autoload/extra.vim " loaded when extra command used
opt/fooextra/doc/extra.txt      " help for extra.vim
opt/fooextra/doc/tags           " help tags
```

Once these files are in the right place, opening Vim will load the plugins in `start` and make the ones in `opt` available with `:packadd`.  

<hr>

Now, can this feature replace the existing plugin managers?  

<strong>Disclaimer:</strong> This part may be a little bit opinionated.  

I think the approach of this new package manager is really different than the one of the plugins managers we were used to because it is made to manage one (or several) archive(s) containing some plugins.  

Out of the box, the package manager doesn't provide features to update your plugins one-by-one, to fetch them automatically from a Github address or to select the plugins you want to enable/disable.  

I'm not sure it will be really convenient to use it out of the box (especially because handling nested version control repositories can be a painful task) but maybe this is the occasion to make plugin managers more efficient?  

Now it is also possible to imagine moving the existing plugins to adopt the structure required by the package manager and to manage them directly from the file system. Maybe some wrapper will be created to use this new feature.  

<hr>

<strong>EDIT</strong> As suggested by @Sato Katsura here is a note about the `helptags` command. The Vim8 commit introduced two line in the <a href="https://github.com/vim/vim/blob/master/runtime/doc/helphelp.txt#L200-L201" rel="noreferrer">`helptag` doc</a>:  

<blockquote>
```vim
:helpt[ags] [++t] {dir}

Generate the help tags file(s) for directory {dir}.
When {dir} is ALL then all "doc" directories in 'runtimepath' will be used.
```
</blockquote>

Which means that the new package manager ease the generation of the helptags put in the user archive. With the single command `:helptags ALL` all the helptags are generated.  

#### Answer 2 (score 11)
To expand on the "can it replace plugin managers",  

I used to use Vundle, which was fantastic, but now have replaced it with 18 or so lines of bash.  

I find it useful to use subfolders in the pack directory to group related plugins. E.g. "Syntax" or "Ruby".  

The relevant bash example is below. Place in a file and run it.  

Additional discussion around the topic at: <a href="https://stories.abletech.nz/get-rid-of-your-vim-plugin-manager-7c8ff742f643#.abnjauzgk" rel="noreferrer">https://stories.abletech.nz/get-rid-of-your-vim-plugin-manager-7c8ff742f643#.abnjauzgk</a>  

```vim
#!/usr/bin/env bash
# This file lives in ~/.vim/pack/install.sh
# Remember to add executable: chmod +x ~/.vim/pack/install.sh
#
# Create new folder in ~/.vim/pack that contains a start folder and cd into it.
#
# Arguments:
#   package_group, a string folder name to create and change into.
#
# Examples:
#   set_group syntax-highlighting
#
function set_group () {
  package_group=$1
  path="$HOME/.vim/pack/$package_group/start"
  mkdir -p "$path"
  cd "$path" || exit
}
# Clone or update a git repo in the current directory.
#
# Arguments:
#   repo_url, a URL to the git repo.
#
# Examples:
#   package https://github.com/tpope/vim-endwise.git
#
function package () {
  repo_url=$1
  expected_repo=$(basename "$repo_url" .git)
  if [ -d "$expected_repo" ]; then
    cd "$expected_repo" || exit
    result=$(git pull --force)
    echo "$expected_repo: $result"
  else
    echo "$expected_repo: Installing..."
    git clone -q "$repo_url"
  fi
}
(
set_group ruby
package https://github.com/tpope/vim-rails.git &
package https://github.com/tpope/vim-rake.git &
package https://github.com/tpope/vim-bundler.git &
package https://github.com/tpope/vim-endwise.git &
wait
) &
(
set_group syntax
package https://github.com/kchmck/vim-coffee-script.git &
package https://github.com/tpope/vim-markdown.git &
package https://github.com/ap/vim-css-color.git &
wait
) &
(
set_group colorschemes
package https://github.com/altercation/vim-colors-solarized.git &
wait
) &
wait
```

#### Answer 3 (score 4)
The answer provided by @statox is very descriptive, but for a new user that can be distracting, because they could read the help file directly. I want to outline what you need to do in pointers.  

<ol>
<li><p>Create `pack/*/start` directory under any of the directory provided by `set packpath`. I did in `~/.config/nvim/pack/*/start`. <strong>Note</strong> that you can use any directory name you want in place of `*` but you can't omit it totally, I don't know why. For example, you can use directory `~/.config/nvim/pack/foo/start` or `~/.config/nvim/pack/bar/start` but not `~/.config/nvim/pack/start`.</p></li>
<li><p>Go to the `pack/*/start` directory and clone the package there.</p></li>
<li>Fire up n/vim and do `:scriptnames` to check if everything is loaded. Don't worry if not every part is loaded, because some files are meant to loaded after some hook, e.g. `autoload/plugin.vim`.</li>
<li>To uninstall, just remove the directory where you cloned the package. Don't need to do anything else.</li>
<li>Do `:helptags ALL` to generate tags for all the help docs. Do `:helptags {dir}` for generating tags for the help docs under directory `dir`. For example, if you put your plugin in `~/.config/nvim/pack/foo/plugin_name`, then do `:helptags ~/.config/nvim/pack/foo/plugin_name/doc`. That will generate a `tags` file in the doc directory of the plugin. If you remove the plugin from the directory, the tags file will be gone and vim will not find the help file, so you don't need to uninstall the doc file manually.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Vim 8.0 Python support (score [28486](https://stackoverflow.com/q/10242) in 2017)

#### Question
I'm trying to upgrade my Vim installation to version 8.0, but it doesn't support both Python and Python 3 as the below image.  

(PS: Because of this problem, I cannot use the YCM (YouCompleteMe) plugin  now.)  

<ol>
<li><p>I installed Vim 8.0 as in the following commands.</p></li>
<li><p>I'm using Ubuntu&nbsp;16.04 (Xenial Xerus).</p></li>
</ol>

How can I handle this problem?  

```vim
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
```

<a href="https://i.stack.imgur.com/k6H3o.png" rel="noreferrer"><img src="https://i.stack.imgur.com/k6H3o.png" alt="Enter image description here"></a>  

#### Answer accepted (score 13)
The <a href="https://launchpad.net/~pi-rho/+archive/ubuntu/dev" rel="nofollow noreferrer">pi-rho/dev PPA</a> now supports Vim 8, and like it always has, includes support for Python/Python3:  

```vim
$ vim --version | grep python
+cryptv          +linebreak       +python/dyn      +vreplace
+cscope          +lispindent      +python3/dyn     +wildignore
$ apt-cache policy vim   
vim:
  Installed: 2:8.0.0134-1ubuntu1~ppa1~x
  Candidate: 2:8.0.0134-1ubuntu1~ppa1~x
  Version table:
 *** 2:8.0.0134-1ubuntu1~ppa1~x 500
        500 http://ppa.launchpad.net/pi-rho/dev/ubuntu xenial/main amd64 Packages
        100 /var/lib/dpkg/status
     2:7.4.1689-3ubuntu1.2 500
```

Of late, the `pi-rho/dev` PPA hasn't had updated Vim builds. I use the <a href="https://launchpad.net/~jonathonf/+archive/ubuntu/backports" rel="nofollow noreferrer">`jonathonf/backports`</a> PPA now:  

```vim
$ vim --version | grep python
+comments          +libcall           -python            +vreplace
+conceal           +linebreak         +python3           +wildignore
$ apt-cache policy vim-gnome
vim-gnome:
  Installed: 2:8.0.1542-0york1~16.04
  Candidate: 2:8.0.1542-0york1~16.04
  Version table:
 *** 2:8.0.1542-0york1~16.04 500
        500 http://ppa.launchpad.net/jonathonf/vim/ubuntu xenial/main amd64 Packages
        500 http://ppa.launchpad.net/jonathonf/vim/ubuntu xenial/main i386 Packages
        100 /var/lib/dpkg/status
     2:7.4.1689-3ubuntu1.2 500
        500 http://jp.archive.ubuntu.com/ubuntu xenial-updates/main amd64 Packages
        500 http://security.ubuntu.com/ubuntu xenial-security/main amd64 Packages
     2:7.4.1689-3ubuntu1 500
        500 http://jp.archive.ubuntu.com/ubuntu xenial/main amd64 Packages
```

The PPA also contains newer versions of several other packages.  

#### Answer 2 (score 8)
From your question it appears that you have installed vim-tiny 8.0 that is a very minimal Vim runtime without plugins. You can confirm this using this:  

```vim
dpkg -l | grep vim
```

You can have several Vim runtimes, but the version running when you do `vim` will be the version that you can see indicated here:  

```vim
update-alternatives --list vim
```

You can check other versions. My suggestion is that you decide between full versions with support for GUI, and you can choose between `vim-gtk2/vim-gtk3` packages or `vim-nox` that is a full version, but without a GUI.  

Now, IIRC, the Vim full version in Debian/Ubuntu doesn't come with Python&nbsp;2 AND Python&nbsp;3 at the same time in 7.x versions. I don't know how the case is with Vim&nbsp;8, because I use `neovim` now. If this is the case for you and you are going to need BOTH Python engines supported by Vim&nbsp;8 (this will not be your case for use `YouCompleteMe`; this one works with Python 2 support only) then you will need to compile from sources your own Vim 8.0.  

#### Answer 3 (score 6)
you should use  

<p><code>sudo apt-get install vim-nox
</code></p>

instead, to get a "huge-version".  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: How can I set up a ruler at a specific column? (score [27647](https://stackoverflow.com/q/356) in 2016)

#### Question
When coding in different languages, I tend to need to restrict my lines to a specific length (usually 79 or 80 characters).  

I've seen this done in other editors through the use of a ruler (solid line displayed at the column) or by changing the color of the text to indicate that it has gone over.  

How can I have Vim indicate to me when I am approaching or going over 79 characters in a single line?  

#### Answer accepted (score 63)
You can display a ruler at a specific line using the `:set colorcolumn` (`:set cc` for short) option which is only available in Vim 7.3 or later.  

```vim
set colorcolumn=80
```

This will set the background color of that column to red, giving you a visual ruler to work from.  

<img src="https://i.stack.imgur.com/0rVzL.png" alt="Picture of default colorcolumn set to 80">  

If you want to use a different color other than red (which really stands out), you can change the color by setting the `highlight` for `ColorColumn`.  

```vim
highlight ColorColumn ctermbg=0 guibg=lightgrey
```

<img src="https://i.stack.imgur.com/9vyQT.png" alt="Customized color for the column">  

You can set the color for terminal versions of Vim using the `cterm` argument and GUI versions of Vim using the `guibg` argument. The `0` is the value of the ASCII escape code for black, which is grey when brightened (which it is, by default). The value `lightgrey` is used for GUI versions of Vim, like gVim, to change the background color to a light grey.  

#### Answer 2 (score 19)
As an addendum to Kevin's answer, you can have multiple colorcolumns. When I code, I sometimes have a "soft" limit at 80 columns and a "hard" limit at 120 columns. So I want a line at 80, and then every column after 120 to be colored.  

I do this with  

```vim
let &colorcolumn="80,".join(range(120,999),",")
```

Of course, this can be easily modified to other preferences.  

#### Answer 3 (score 14)
Vim 7.3 brings the `colorcolumn` option, as detailed very well in other answers.  

However, if you don't have version 7.3 for whatever reason, you can still achieve a visual indication that you are exceeding a particular column count using vim's `match` functionality (see `:help match` for details).  

Essentially, the match commands allow you to create persistent highlights for text matching a given regular expression. `:match ColorColumn "\%80v."` will highlight text in column 80 with the "ColorColumn" group. You can of course substitute any highlight group, and any column value. If you want a strong visual indication, the expression `"\%>79v.\+"` will highlight column 80 and beyond.  

(`\%80v` means "match in virtual column 80," and `\%>79v` means "match <em>after</em> virtual column 79; see `:help /\%c` for more.)  

This approach will only highlight when there are actual characters present in the specified columns, however, which makes it visually less consistent than `colorcolumn`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: How can I get a newer version of Vim on Ubuntu? (score [27162](https://stackoverflow.com/q/10817) in )

#### Question
Ubuntu's packages can be pretty old, but for some desktop programs (like Vim) I'd much rather have the latest version, as newer versions often fix various bugs.  

How can I get a reasonably recent Vim version on Ubuntu?  

#### Answer accepted (score 49)
You have three different options:  

<ul>
<li>Wait for the newest versions to be added to the distribution packages. Note that you might want to learn a new language or build a ship with your bare hands while you wait. </li>
</ul>

If waiting several years is not good for you then you have the following two options:  

<ul>
<li>Use a PPA containing the latest version:

<ul>
<li>Pros:

<ul>
<li>Easy to do.</li>
<li>Totally automated.</li>
<li>Let you install Vim as any other software.</li>
</ul></li>
<li>Cons:

<ul>
<li>You basically grant root privileges to a complete stranger.</li>
<li>This method only works on Ubuntu and the derived distributions using PPA system.</li>
</ul></li>
</ul></li>
<li>Build Vim from sources:

<ul>
<li>Pros:

<ul>
<li>You get a fine tuning of the options you enable (gui, Python/Lua support, etc.).</li>
<li>You get the bleeding edge version and don't need any third party maintainer to get it.</li>
<li>It's always useful to learn how to compile a software from sources.</li>
<li>This is a distribution agnostic method.</li>
</ul></li>
<li>Cons:

<ul>
<li>Not as automated as the PPA option.</li>
<li>Can be frightening for a new user.</li>
</ul></li>
</ul></li>
</ul>

In two latter cases, here is a procedure for these options:  

<hr>

<h5>PPA</h2>

Here is an online tutorial on <a href="http://tipsonubuntu.com/2016/09/13/vim-8-0-released-install-ubuntu-16-04/" rel="noreferrer">tipsonubuntu.com</a> (Thanks @joeytwiddle who suggested it in the comments).  

First open a terminal and use the following command. This will add the Personal Packet Archive (PPA) maintained by joathonf to you repos and let Ubuntu know where to look for Vim:  

```vim
sudo add-apt-repository ppa:jonathonf/vim
```

<em>I'll repeat here that doing this give the root privileges to the scripts in this PPA, do it only if you trust it</em>. You may want to read <a href="https://askubuntu.com/q/35629/255332">are PPA's safe to add to my system and what are some “red flags” to watch out for?</a> and <a href="https://askubuntu.com/q/7662/255332">is there any guarantee that software from Launchpad PPAs is free from viruses and backdoor threats?</a>.  

Update the packet list so Ubuntu will look in the PPA to find the Vim files:  

```vim
sudo apt update
```

Finally install vim:  

```vim
sudo apt install vim
```

And tada! Vim is installed. Note that you can also do that from the GUI package manager.  

Note that this is not the only PPA available with newer Vim versions, you can use your favourite search engine to find more (and <em>do</em> remember you are trusting some stranger from the internet with root access to your system).  

<hr>

<h5>Building from sources</h2>

A second option is to build Vim from sources. This implies some additional manipulation and can be frightening for a new user, but it is the best way to get the lasted build.  

There are several online resources to guide you through this procedure:  

<ul>
<li><a href="http://www.vim.org/git.php" rel="noreferrer">The official Vim's website</a></li>
<li>The plugin YouCompleteMe has <a href="https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source" rel="noreferrer">a really complete wiki page</a> with a detailed installation procedure which can be interesting from some corner cases.</li>
<li>Wikia also <a href="http://vim.wikia.com/wiki/Building_Vim" rel="noreferrer">has a page about that</a></li>
</ul>

A general procedure is the following, you might need to tweak it to fit your needs but the main idea is here:  

First you might need to install some dependencies. For example use this command (suggested by YouCompleteMe wiki):  

```vim
sudo apt-get update
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git
```

<em>Note that you maybe won't need everything: for example if you won't use Lua, do not include `lua5.1-dev` to the list</em>.  

<strong>Edit</strong> Instead of using the previous `apt-get install` command you can use the following. It has the advantage of automatically handling the dependencies you need:  

```vim
sudo apt-get build-dep vim
```

Then get the sources on your computer (you'll need the `git` command installed with `apt-get install git`):  

```vim
git clone https://github.com/vim/vim.git
```

Go to this directory and 'pull' the last changes:  

```vim
cd vim
git pull
```

<em>If you have an error on `git pull` because you already made changes you can 'stash' your modifications (i.e. remove them temporarily), pull the changes and then restore your modifications. If you did so I'll assume that you are familiar with git and won't provide the procedure to follow (it is detailed in the vim.org doc).</em>  

You can then build Vim as you would build any other software from sources. The file <a href="https://github.com/vim/vim/blob/master/src/INSTALL" rel="noreferrer">src/INSTALL</a> should provide you with the information you need to compile Vim.  

A regular workflow would begin with:  

```vim
./configure --with-features=huge --enable-gui=auto
```

<em>Remove `--enable-gui` if you don't want gVim</em>.  

If you don't have root access on the machine you're installing Vim, you might want to add the `--prefix` option which allows you to use a directory where you have access rights. For example you could use:  

```vim
./configure --with-features=huge --enable-gui=auto --prefix=$HOME/local/vim
```

The `configure` script can take a lot of arguments to tune which features you want to enable. Running it takes a while.  While running, it prints messages telling which features it is checking for.  

Once it is configured, you can compile the program with:  

```vim
make
```

An optional command exists to run some self-checks (<em>don't ask me what they do exactly I always skip them :-)</em>):  

```vim
make check
```

Finally install Vim to `/usr/local/` (this command requires the root privileges):  

```vim
sudo make install
```

To remove the now useless files which were created for the compilation you can then run:  

```vim
make clean
make distclean
```

And here you are with a fresh Vim install.  

You will probably want to remove any Vim you've installed from the Ubuntu repo, but you don't <em>need</em> to. By default, Vim will install to `/usr/local/`, rather than `/usr/`. Just make sure you're running the correct Vim version (i.e. `/usr/local/bin/vim`, and not `/usr/bin/vim`).  

#### Answer 2 (score 2)
```vim
#!/usr/bin/env bash

sudo apt update

sudo apt install -y git

sudo apt install -y build-essential

rm -fr /tmp/vim

git clone https://github.com/vim/vim.git /tmp/vim

make -C /tmp/vim

sudo make install -C /tmp/vim 

rm -fr /tmp/vim
```

#### Answer 3 (score 1)
Another option is to install <a href="https://docs.brew.sh/Homebrew-on-Linux" rel="nofollow noreferrer">Homebrew on Linix</a> as an alternate package manager and use it to install the latest vim with:  

```vim
brew install vim
```

Homebrew Features:  

<ul>
<li>Can install software to your home directory and so does not require sudo</li>
<li>Install software not packaged by your host distribution</li>
<li><strong>Install up-to-date versions of software when your host distribution is old</strong></li>
<li>Use the same package manager to manage your macOS, Linux, and Windows systems</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Exit from Terminal mode in Neovim (score [26735](https://stackoverflow.com/q/4919) in 2017)

#### Question
I can't figure out how to go back to `Normal` mode after entering `Terminal` in `Insert` mode...  

Escape just doesn't seem to work.  

Any idea ?  

#### Answer accepted (score 57)
You are supposed to press `<C-\><C-n>`.  

See `:help terminal-emulator` for a mapping suggestion.  

#### Answer 2 (score 40)
The answer by @romainl is correct but I wanted to add a bit more info for anyone that may have stumbled on this from google like I did.  

Directly from the docs we get this note:  

<blockquote>
  <p>Terminal mode has its own namespace for mappings, which is accessed
  with the "t" prefix. It's possible to use terminal mappings to
  customize interaction with the terminal. For example, here's how to
  map  to exit terminal mode:</p>

```vim
:tnoremap <Esc> <C-\><C-n>
```
</blockquote>

With that knowledge you will most likely need to create some terminal mappings to stay inline with your current workflow (tab/window movement, etc.)  

#### Answer 3 (score 2)
<h5>Exit &amp; close</h1>

```vim
tnoremap <Esc> <C-\><C-n>:q!<CR>
```

In Vim 8, this also works:  

```vim
tnoremap <ESC> <C-w>:q!<CR>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: what is the command for "Select All" in vim and VsVim? (score [23764](https://stackoverflow.com/q/9028) in 2016)

#### Question
How do I select all the content of a file in Vim and VsVim? Like in other editors `ctrl+A` does the job for select all.  

#### Answer accepted (score 20)
`ggVG` selects all content. `gg` moves to first line. `V` starts visual mode. `G` jumps to last line thereby selecting from first to last line   

#### Answer 2 (score 13)
Along with SibiCoder's answer, if you have a clear idea of what you want to do you can use the following:  

```vim
:%X
```

Where `X` is a command, for example:  

```vim
:%d             -> delete every line
:%y             -> yank every line
:%normal! >>    -> indent every line
```

You have also the global command `:g` which, with the search pattern `^`, can do the same thing:  

```vim
:g/^/d             -> delete every line
:g/^/y             -> yank every line
:g/^/normal! >>    -> indent every line
```

If what you want is selecting the text, then `ggVG` is fine, but keep in mind these method, in the case you already know what is the next step. Note that it won't leave the cursor in visual mode.  

See: `:h :%` and `:h :g` for reference.  

<hr>

Note that, even though the `C-A` mapping is used in vim (see `:h CTRL-A`), you can map it to do what other editors do:  

```vim
nnoremap <C-A> ggVG
```

#### Answer 3 (score 1)
The other answers are good. Here's another alternative.   

Since you mention that you are using VsVim, you can change which keys are handled by visual Studio, and which keys are handled by vsvim. Go to   

<blockquote>
  Tools -> Options -> VsVim -> Keyboard  
</blockquote>

From there you can set Ctrl-a to be handled by Visual Studio, rather than VsVim.   

Although I do not recommend this since you will not be able to use vim's `<C-a>`, which I find to be an essential feature. Though it's up to you.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: How to map Alt key? (score [23521](https://stackoverflow.com/q/2350) in 2015)

#### Question
I'm trying to map <kbd>Alt</kbd> key in the following way:  

```vim
:map <A-j> j
:map <A-k> k
```

but it doesn't work (bell is rang on <kbd>Alt + j</kbd>/<kbd>Alt + k</kbd>).  

What I'm missing?  

I'm using Terminal on OSX, the same happens on remote Linux.  

<hr>

On <kbd>Ctrl + v</kbd>, <kbd>Alt + j</kbd>, I've got: `?~H~F` (`∆` when `encoding=utf-8`).  

On <kbd>Ctrl + v</kbd>, <kbd>Alt + k</kbd>, I've got: `?~Z` (`˚` when `encoding=utf-8`).  

Running vim without plugins (`-u NONE`) doesn't make any difference.  

#### Answer accepted (score 34)
That's how I do it on Linux or Cygwin:  

First check what chars are send by your terminal when you press <kbd>ALT</kbd>+<kbd>J</kbd>:  

In order to do this I go to console and run `sed -n l` (you can also use `cat` for it). Then I press <kbd>ALT</kbd>+<kbd>J</kbd> and see that the chars on the screen are `^[j` .  

I replace `^[` with `\e` (because that's what is sent by my terminal when I press <kbd>esc</kbd>) and the final string for me is `\ej`.  

Then I write it to my `.vimrc`:  

```vim
execute "set <M-j>=\ej"
nnoremap <M-j> j
```

And the mapping works.  

#### Answer 2 (score 8)
With help of <a href="https://vi.stackexchange.com/questions/2350/how-to-map-alt-key#comment2107_2350">Carpetsmoker</a>, it seems that Terminal wasn't configured to 'Use Alt/option as meta key' (this is especially common for GUI Terminals).  

For Terminal on OSX, it's in <em>Preferences -> Settings -> Keyboard tab -> 'Use option as meta key'</em>. Check: <a href="https://apple.stackexchange.com/questions/54777/how-can-i-change-terminal-so-that-i-dont-have-to-press-esc-every-time-i-want-to">How can I change Terminal to use option as meta key?</a> (<a href="https://apple.stackexchange.com/questions/146485/can-you-enable-the-meta-key-in-mavericks">Mavericks</a>).  

For XTerm, check: <a href="http://frequal.com/linux/XTermMetaSendsEscape.html" rel="nofollow noreferrer">Configuring XTerm to Default to Meta Sends Escape</a> which says:  

<blockquote>
  Add this line anywhere in your personal .Xdefaults file (`~/.Xdefaults`):  

```vim
xterm*metaSendsEscape: true
```
  
  Then reload the config with xrdb. Without this step the changes in `.Xdefaults` won't take effect until the next X restart:  

```vim
xrdb -l ~/.Xdefaults
```
</blockquote>

Then standard mappings with <kbd>Alt</kbd> key like:  

```vim
:map <A-j> j
:map <A-k> k
```

works fine.  

For help, see: <a href="http://vimhelp.appspot.com/map.txt.html#%3Amap-alt-keys" rel="nofollow noreferrer">`:h :map-alt-keys`</a>.  

#### Answer 3 (score 4)
Similar to Kossak's answer but a bit simpler, by mapping literal key presses.  

Either in normal mode after pressing <kbd>:</kbd>, or inserted into your `.vimrc`, map the input directly by starting the mapping:  

```vim
nnoremap 
```

then hitting <kbd>Ctrl</kbd> + <kbd>V</kbd> then the keystroke to record, e.g. <kbd>Alt</kbd> + <kbd>←</kbd>. This will show as something like this:  

```vim
nnoremap ^[[1;3D
```

but each `^[` is a single, literal escape character and syntax highlighting should show this. Replace the literal escape(s) with the text `<Esc>`, and append the command you wish to use:  

```vim
nnoremap <Esc>[1;3D <C-w>h
```

<hr>

I know OP was mapping <kbd>Alt</kbd> + letters, but I used arrows to show how do it for something that may not be mapped by default.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: What are the differences between :wq<cr> :x<cr> and ZZ when exiting vim? (score [23339](https://stackoverflow.com/q/5723) in 2016)

#### Question
Vi and Vim, as all of you know, have many synonyms. There are three ways I know of to save the file and exit Vim and Vi. These are <em>:wq</em> <strong>&lt;cr&gt;</strong>, <em>:x</em> <strong>&lt;cr&gt;</strong> and <em>ZZ</em>. I have heard that these are different in some way.  

Are there any practical differences between using:  

<kbd>:</kbd><kbd>x</kbd><kbd>&lt;cr&gt;</kbd>  

<kbd>:</kbd><kbd>w</kbd><kbd>q</kbd><kbd>&lt;cr&gt;</kbd>  

or  

<kbd>Z</kbd><kbd>Z</kbd>  

to save file and exit Vim and Vi?  

#### Answer accepted (score 40)
From Vim's documentation, <a href="http://vimhelp.appspot.com/editing.txt.html#%3Ax" rel="noreferrer">`:x`</a> and <a href="http://vimhelp.appspot.com/editing.txt.html#ZZ" rel="noreferrer">`ZZ`</a> are equivalent; they only save the file if it has been modified, then quit Vim:  

```vim
Write current file, if modified, and quit (same as ":x").  
(Note: If there are several windows for the
current file, the file is written if it was modified and the window is closed).
```

<a href="http://vimhelp.appspot.com/editing.txt.html#%3Awq" rel="noreferrer">`:wq`</a> on the other hand writes the file and quits Vim (assuming proper permissions).   

#### Answer 2 (score 9)
<p>As akshay pointed out, Vim's documentation explains, that `:x` and `ZZ` are equivalent and only save a file if the associated buffer has been changed. 
Whereas `:wq` saves the buffer to the corresponding file, even if it is unchanged.</p>

In both cases, the contents of the buffer will be saved to disk. Obviously the outcome is the same, so why bother, right? But wait... There is a subtle, but not irrelevant difference.  

If you exit Vim via `:x` and there has been no change to the buffer, there will be no change to the modification time of that file. On the other hand, if you quit via `:wq`, the modification time will change, as the file is technically rewritten (saved again).  

This can have some impact in certain situations. For example a backup process that is dependent on modification time, could store this file (and potentially send it over the network) even if no additional information has been included. Or some monitoring process could ring an alarm if it detects that (for it) the file has been changed...  

Edit: I forgot to mention, in order to leave an modified buffer/file without changing the modification time, a `:q` (without the `w`) will work, too.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: How can I yank (copy) the single character on which the cursor rests? (score [22848](https://stackoverflow.com/q/5806) in 2017)

#### Question
I know many ways to copy things:  

<p>`yiw` = yank in current word<br>
`yaw` = yank all word (includes a trailing space)<br>
`yy`  = yank the current line<br>
`3yy` = yank three lines starting at the current one<br>
`yap` = yank all paragraph (includes trailing newline)  </p>

I can also delete or change a single character:  

<p>`x` = delete the character under the cursor<br>
`r` = replace the character under the cursor  </p>

But how in the world do you simply copy a single character under the cursor?  

My motivation is that I'm programming in Perl 6 and some of the operators are Unicode characters. Right now I'm using <a href="https://github.com/tadzik/perl6-Config-INI/blob/master/lib/Config/INI.pm" rel="noreferrer">tadzik's Perl 6 Config::INI code</a> as a starting point for a custom parser, for example, and I would have liked to have copied just that one <a href="https://doc.perl6.org/language/operators#postfix_%C2%BB._%2F_postfix_%3E%3E." rel="noreferrer">French quote character (a hyper operator)</a> from <a href="https://github.com/tadzik/perl6-Config-INI/blob/master/lib/Config/INI.pm#L26" rel="noreferrer">this line</a>:  

```vim
my %hash = $<sections>».ast;
```

I could use the two character "Texas" version of the hyper operator `>>`, but I thought that `>»` looked better and less ambiguous than `>>>`:  

```vim
my %hash = $<sections>>>.ast;
```

<p><a href="https://i.stack.imgur.com/4MoZx.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/4MoZx.jpg" alt="enter image description here"></a><br>
<a href="https://i.stack.imgur.com/eK1EC.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/eK1EC.jpg" alt="enter image description here"></a></p>

#### Answer accepted (score 40)
Composing the yank operation with the so often used "one character to the right" motion should work: `yl`.   

BTW (to comment on a OP comment), for me `»` can be yanked in this manner, in gVim or terminal Vim. Perhaps a (file)encoding issue?  

#### Answer 2 (score 14)
Usually I press `vy` (<em>visual yank</em>), sometimes `xu` (<em>delete undo</em>) too. Also , if you want to yank the char before your cursor, instead of `lvy`, you can press `Xu`, I think that's the reason why I press `xu` for the current. :-)  

Note that, `Xu` will make your cursor move to that char.  

#### Answer 3 (score 9)
The simplest way I know to do this is to use `x` to delete the character, which also puts it in the buffer, and then `P` to put it back.  You can then move the cursor around and paste the character back wherever you want it with `p` (after cursor) or `P` (before cursor), as long as you do not change the buffer.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: Fastest way to switch to a buffer in vim? (score [22833](https://stackoverflow.com/q/2129) in 2017)

#### Question
One way to select a buffer in vim could be to browse the buffers list, using standard commands as `:ls`, or with <a href="https://vi.stackexchange.com/questions/2121/how-do-i-have-buffers-listed-in-a-quickfix-window-in-vim">some external plugin / vimscript code to browse a list in a window</a>.  

Let's say I want to jump to a buffer directly, as fast as possible.  

To traverse the buffer list in sequential mode, I now use `<C-J>` `<C-K>` shortcuts, having set in my .vimrc:  

```vim
" move among buffers with CTRL
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>
```

Another way (direct access) could be <a href="http://vim.wikia.com/wiki/Easier_buffer_switching#Switching_by_number" rel="noreferrer">switching by number</a>: knowing the buffer number, it is possible to switch directly by entering the buffer number followed by `<C-^>`. So if I want to switch to buffer number 5, I would press `5<C-^>`.  

But this seem not working for me (I use vim 7.4 on ubuntu box, from a Windows guest, with <em>Italian keyboard</em>). I suspect that's because the `^` character is in the upper case key `^ì` in the Italian keyboard, so in fact to got `^` I need to press `SHIFT-^`    

Any ideas?  

#### Answer 2 (score 49)
The `:b` command can also take a <em>substring</em> of the name of the file of the buffer which you want to travel to, which is very convenient.  

For example, if you have three buffers `foo`, `bar`, and `baz`, then  

<ul>
<li><p>`:b bar` will switch to the `bar` file.</p></li>
<li><p>`:b o` will switch to the `foo` file.</p></li>
<li><p>`:b a` will give you an error because it could mean either `bar` or `baz`, but you can fix the name to be more specific with, for example, <kbd>:</kbd> <kbd>↑</kbd> <kbd>r</kbd> <kbd>Enter</kbd>.</p></li>
</ul>

This can be very useful, because it means instead of  

```vim
:buffer very/very/long/path/to/a/veryVeryLongFileName.txt
```

you can do something like  

```vim
:b LongFileName
```

which is much shorter and easier.  

This command can also take a number, if you want to use that:  

```vim
:b 5
```

#### Answer 3 (score 15)
This is what I use:  

```vim
nnoremap <Leader>b :ls<CR>:b<Space>
```

Now pressing `\b` will <strong>list the available buffers</strong> and prepare `:b` for you.  

Then you can just type the <strong>buffer number</strong>, and hit Enter.  

Or you can type <strong>part of the filename</strong>, and hit Enter.  (However I usually hit Tab before hitting Enter, to check I got the right buffer.  If not, I continue cycling with Tab until I get the one I wanted.)  

<hr>

In fact, I use a slightly tweaked version of the above:  

```vim
nnoremap <C-e> :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>
```

This will prevent the `-- More --` prompt from appearing when you have more buffers than available lines to display them.  

But if you usually have the `'more'` option disabled anyway, this mapping will really annoy you, because it re-enables the `'more'` option after doing `ls`!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: Colorscheme's background not correct in terminal (score [22830](https://stackoverflow.com/q/2010) in 2015)

#### Question
I imported the solarized colorscheme and palette. My terminal has the correct colors and background, gvim has the correct colors and background, but vim has an incorrectly colored background. The text is all correct, but the background appears to be pure black.  

<a href="https://i.stack.imgur.com/LZnB3.png" rel="noreferrer"><img src="https://i.stack.imgur.com/LZnB3.png" alt="This is a comparison of Terminal, GVim, and Vim"></a>  

Here is my .vimrc:  

```vim
syntax enable

if has('gui_running')
    set background=dark
else
    set background=dark
endif

:set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized
```

If anyone has any suggestions on what could be causing this, I would be much obliged. I run xubuntu with the default terminal.  

I should also mention that the light option results in a very yellow background for Vim.  

#### Answer accepted (score 5)
Great news, everyone. @Tom and @Rich set me on the right path. I found a solution provided <a href="https://github.com/sgerrand/xfce4-terminal-colors-solarized" rel="noreferrer">here</a>. I set my .vimrc to the simple  

```vim
syntax enable
set background=dark
set t_Co=16
colorscheme solarized
```

This seems to fix everything. The colors don't seem to be as bright in the <a href="http://ethanschoonover.com/solarized/img/terminus12" rel="noreferrer">font examples</a>, but that could very well just be me. To anyone who wants to use the Solarized colorscheme and uses xfce4-terminal, just changing the terminalrc and the .vimrc seemed to solve my main problems. Thanks to everyone for your help!  

#### Answer 2 (score 10)
There's two reasons why I think this may be happening:  

<ol>
<li><p>The solarized color scheme you are using does not declare `ctermfg` and `ctermbg` for any of the features you want to highlight. Try out this <a href="http://www.vim.org/scripts/script.php?script_id=1243" rel="noreferrer">color scheme</a>, should look essentially the same both inside your terminal and gvim, if this is the case then you may need to look into using a color scheme that declares `ctermfg` and `ctermbg`.</p></li>
<li><p>You may need to make sure your terminal emulator supports the colors you are trying to display:</p>

<ul>
<li>Ensure that the file <a href="http://packages.ubuntu.com/search?keywords=ncurses-term&amp;searchon=names&amp;suite=all&amp;section=all" rel="noreferrer">`ncurses-term` package</a> (which provides the file `/usr/share/terminfo/x/xterm+256color`) is installed.</li>
<li><p><a href="http://vim.wikia.com/wiki/256_colors_in_vim" rel="noreferrer">Set the value of your `TERM` environment variable</a> by running</p>

```vim
export TERM=xterm+256colors
```

at the shell.  </li>
<li>Then start `vim` in that shell.</li>
</ul></li>
</ol>

<hr>

Note that both of this things could be happening at the same time, but it is hard to diagnose this without more information about your system.  

#### Answer 3 (score 4)
<p>I guess it is an issue of compatibility of this `colorscheme` with terminal.
The plugin `csaprox` miraculously solve a bunch of this issues. </p>

Synopsis:  

<blockquote>
  <p>It's hard to find colorschemes for terminal Vim.  Most colorschemes are 
  written to only support GVim, and don't work at all in terminal Vim. </p>
  
  <p>This plugin makes GVim-only colorschemes Just Work in terminal Vim, as long 
  as the terminal supports 88 or 256 colors - and most do these days.  This 
  usually requires no user interaction (but see the help for what to do if 
  things don't Just Work).  After getting this plugin happily installed, any 
  time you use `:colorscheme` it will do its magic and make the colorscheme Just 
  Work.</p>
</blockquote>

Links to the plugin:  

<ul>
<li><a href="http://www.vim.org/scripts/script.php?script_id=2390" rel="nofollow">vim.org</a></li>
<li><a href="https://github.com/godlygeek/csapprox" rel="nofollow">Github</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: How do I open and close NERDTree (toggle NERDTree view) using a single keystroke? (score [22723](https://stackoverflow.com/q/9967) in )

#### Question
Sometimes during my workflow, I might want to open/search for a file on the go. I'd like to map a single key (say F6) to open and close NERDTree (ie. I want to toggle NERDTree view). Also, I'd like NERDTree to display hidden files and folders in its toggled view and I'd also like it to close automatically when I open a file for editing if that is possible. Thanks !  

#### Answer accepted (score 23)
In your `vimrc` add  

```vim
nmap <F6> :NERDTreeToggle<CR>
```

where `<F6>` is the key you want to map.  

#### Answer 2 (score 8)
To open NerdTree :   

```vim
:NERDTreeFocus
```

To switch beetween nerdtree and file opened windows :  

```vim
ctrl + ww (double w)
```

or   

```vim
ctrl + w + (h/j/k/l)
```

To close NerdTree (in nerdtree window) :  

```vim
:q
```

#### Answer 3 (score 1)
If you want to close NERDTree window make sure you are inside the NERDTree menu. You can switch windows by using `ctrl+w` then type `:q` to close NERDTree window so that you will be left with the window for editing your code.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: How can I find out what <Leader> is set to? And is it possible to remap <Leader>? (score [22707](https://stackoverflow.com/q/281) in 2015)

#### Question
How can I figure out which key is set as my `<Leader>`, and how do I remap it?  

#### Answer accepted (score 62)
By default your `<leader>` is `\`, backslash. You can check it with:  

```vim
:echo mapleader
```

If this gives you an `E121: Undefined variable: mapleader`, it means it's set to the default of `\`. If it gives you something else, then it's that :-)  

You can easily remap it. I mapped it to the space-bar:  

```vim
:let mapleader = "\<Space>"
```

Note that the value of `mapleader` is used at the moment the mapping is defined. So this example:  

```vim
let mapleader = ","
nnoremap <Leader>a :echo "Hey there ,"<CR>

let mapleader = "\<Space>"
nnoremap <Leader>a :echo "Hey there space"<CR>
```

Will produce <em>two</em> mappings: `,a` and `<Space>a`.  

This means that the <em>current</em> value of `mapleader` is not necessarily the value that was used to define your mappings!  

In addition, there's the `maplocalleader`, which is the same as `mapleader`, except that it's used by `<LocalLeader>` and that it's local to the current buffer.  

More information about `<Leader>` can be found in Vim's help with <a href="http://vimhelp.appspot.com/map.txt.html#mapleader">`:help mapleader`</a>.  

#### Answer 2 (score 8)
You can display the current leader key like this `:let mapleader`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Search for lines starting with given string in vim? (score [22603](https://stackoverflow.com/q/3347) in 2015)

#### Question
I have this code snippet:  

```vim
# import ipdb; ipdb.set_trace()
def foo():
    ...
    import ipdb; ipdb.set_trace()
    ...
    # import ipdb; ipdb.set_trace()
```

How should I specify search query, that it would find only the uncommented `ipdb` lines?  

I guess the command could look something like: `/import ipdb/(line start flag)`  

#### Answer accepted (score 12)
How about this:  

```vim
/^[^#]*ipdb
```

<p>The first `^` will anchor the match to the start of the line, `[^#]` will match
any character <em>except</em> a `#` (the `^` means to match any character <em>except</em>
those given), and the `*` repeats this 0 or more times.</p>

<p>See:<a href="http://vimhelp.appspot.com/pattern.txt.html#/%5E" rel="noreferrer">`:help /^`</a>
<a href="http://vimhelp.appspot.com/pattern.txt.html#/collection" rel="noreferrer">`:help /[`</a> for some more information.</p>

Note that this will match all lines with `ipdb` which don't start with a comment, including:  

```vim
import other_module, ipdb
```

<hr>

If you only want to match those starting with `import ipdb`, you can use:  

```vim
/^\s*import ipdb
```

Here `^` will again anchor the match to the start of the line, `\s` will match any whitespace character, and `*` repeats this 0 or more times.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: "E297: Write error in swap file" due to running in a VM (score [21311](https://stackoverflow.com/q/6641) in 2016)

#### Question
UPDATE: I've tried both the `:set noswapfile swapfile` solution and the `:e!` solution and the swapfile one is better because it retains undo history even for large files, in this case meaning over 1.5 MB. For some reason, `:e!` does not keep undo history in those cases even though it does keep it in the normal case (say sub-100KB). The `swapfile` solution appears to me now to work under any circumstances, which is very impressive.  

A bit of a weird question: How can I cleanly get rid of or move past the error message "E297: Write error in swap file"? I am running GVim when this happens and do not want to be forced to close it down and reopen a new GVim because I don't want to lose all my open buffers and ideally I'd like to keep all my undo history in each file too, but even a solution where I lose undo history would be an improvement. I have one limited workaround right now noted at bottom and am looking for something a little better...  

Why would I want to ignore such an error? A good question: I am running GVim in a virtual machine and I have it open on a file on the "host" file system rather than the VM's own file system and I "suspend" the VM. After coming back from the suspend, every GVim window open on a host system file will give this message. So the message is evidently due to the disconnection from the host file system that has to occur when the VM is suspended. GVim obviously thinks it still has a valid perhaps file descriptor and such when it doesn't.  

So the way the error arises is not anything alarming and I just need or want a way to move past it without having to close GVim and reopen it. For example, many times I might have this GVim open with many buffers and a lot of things going on. I don't want to be forced to shut down the whole GVim session because of this one error, or even to shut down <em>all</em> buffers open on the host system's file system. When the error occurs, it's quite annoying and pops up every few moments.  

What I tried so far is doing `:e` on the same file, hoping that might be like refreshing from the file system, and that did <em>not</em> get rid of the error.  

I have also tried sort of the nuclear option, `:bw` to get rid of the buffer where this is occurring and that does work, but as I say ideally I would like to keep the session in the same state as much as possible, so shutting down buffers is not ideal either. Like let's say I have GVim open on 10 files on the host system. If I have to shut down all the buffers, then it's just as bad as having to shut down GVim altogether.  

All of this applies to the command line Vim as well, and I'm using version 7.4 on Linux.  

#### Answer accepted (score 2)
I would try to globally disable swapfiles and then reenable them for all buffers. Something like this:  

`:bufdo :set noswapfile swapfile`  

(One might want to check, whether the current buffer has a swapfile enabled before resetting this option).  

#### Answer 2 (score 2)
Didn't intend to reply to my own question, and this is not necessarily better than the `swapfile` method, but this works too:  

`:w` then <a href="http://vimhelp.appspot.com/editing.txt.html#discard" rel="nofollow">`:e!`</a>  

I initially tried `:e` as I mentioned but I hadn't tried `:e!`. And I still have undo history with `:e!` (tested only on Vim 7.4), just like with the `swapfile` solution, <em>but</em>...  

The negative with this solution of course is that you will <em>lose any unsaved changes</em> since that's ordinarily the purpose of the exclamation, to say "I don't care if I lose changes since the last time saved," so make sure you use `:w` before doing this. In these swap file error situations, I am always able to save just fine.   

The Vim docs mention that <a href="http://vimhelp.appspot.com/editing.txt.html#discard" rel="nofollow">`:e!`</a> is useful when you want to "start all over again" which is kind of the situation here, though we don't want to needlessly throw away undo history:  

<blockquote>
  <p>:e! Edit the current file always.  Discard any changes to
  the current buffer.  This is useful if you want to
  start all over again.<br>
  - <a href="http://vimhelp.appspot.com/editing.txt.html#discard" rel="nofollow">`:h :e!`</a></p>
</blockquote>

Because of the unsaved changes issue, I would say the `swapfile` solution is overall the more advisable, even though `:e!` is much quicker to type.  

A note on Vim 7.3: I believe you would more likely lose the undo history in 7.3 given a similar situation, since 7.4 has seemed to make improvements in reducing the number of situations where undo history is lost. (Thank you to Bram Moolenaar and whoever else helps him make Vim/GVim better!)  

#### Answer 3 (score 1)
You could try using sessions instead of suspending the VM. You could configure your Linux to launch Vim on startup, and your Vim to load the last session.  

Anyway, for the following task:  

<blockquote>
  <p>I am running GVim when this happens and do not want to be forced to
  <strong>close it down and reopen a new GVim because I don't want to lose all</strong>
  <strong>my open buffers</strong></p>
</blockquote>

, you could use the <a href="https://github.com/xolox/vim-session/" rel="nofollow">session.vim plugin</a> as it provides the `:RestartVim` command, which restarts Vim/GVim and restores your windows/tabpages layout.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: How can I change the indent size? (score [21224](https://stackoverflow.com/q/7975) in 2016)

#### Question
I just discovered I could indent and un-indent easily in Vi with : <kbd>&lt;&lt;</kbd> and <kbd>>></kbd>  

By default it adds a `tab` character. Now I'm wondering, could this be to a number of spaces via a configuration in my `.vimrc`? And how should I do it?  

#### Answer accepted (score 21)
Several settings controls the behavior:  

First `set expandtab` allows to replace the tabs by white spaces characters <a href="http://vimdoc.sourceforge.net/htmldoc/options.html#%27expandtab%27">`:h 'expandtab'`</a>.  

Then `set shiftwidth=4` makes the tabulations be 4 white spaces <a href="http://vimdoc.sourceforge.net/htmldoc/options.html#%27shiftwidth%27">`:h 'shiftwidth'`</a>.  

You could also be interested by by <a href="http://vimdoc.sourceforge.net/htmldoc/options.html#%27tabstop%27">`:h 'tabstop'`</a> which defines the number of spaces that a tab character in the file counts for.  

As a bonus see <a href="http://vimdoc.sourceforge.net/htmldoc/options.html#%27smartindent%27">`:h 'smartindent'`</a> and <a href="http://vimdoc.sourceforge.net/htmldoc/options.html#%27autoindent%27">`:h 'autoindent'`</a> which are pretty useful.  

#### Answer 2 (score 7)
I answered my need by modifying `.vimrc` like below:  

```vim
:set shiftwidth=2
:set autoindent
:set smartindent
~
```

Thanks Sibi &amp; satox  

#### Answer 3 (score 4)
Yes.  

<p>You can set `shiftwidth` to any number of spaces.
This works both in `vi` and  `vim`.</p>

```vim
:set shiftwidth=2
```

Now, the width shifted for each `>>` and `<<` will be 2.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: What is the difference between `filetype plugin indent on` and `filetype indent on`? (score [19996](https://stackoverflow.com/q/10124) in )

#### Question
I see one of these two lines in `.vimrc` files. This one seems to be most common:  

```vim
filetype plugin indent on
```

But how does it differ from this line:  

```vim
filetype indent on
```

I've found <a href="http://vimdoc.sourceforge.net/htmldoc/filetype.html#:filetype-indent-on" rel="noreferrer">documentation for the latter</a>, but I'm still confused.  

#### Answer accepted (score 45)
`filetype plugin indent on` is like a combination of these commands:  

```vim
filetype on
filetype plugin on
filetype indent on
```

It turns on "detection", "plugin" and "indent" at once. You can check for yourself by reading <a href="http://vimdoc.sourceforge.net/htmldoc/filetype.html#:filetype-overview" rel="noreferrer">`:help :filetype-overview`</a>.  

<h5>Detection</h1>

What does filetype "detection" do? From the docs:  

<blockquote>
  <p>Each time a new or existing file is edited, Vim will try to recognize the type
  of the file and set the 'filetype' option.  This will trigger the FileType
  event, which can be used to set the syntax highlighting, set options, etc.</p>
</blockquote>

This is less confusing if you realise that the `filetype` command is distinct from the `filetype` option. (The command `:filetype...`, the option: `:set filetype...`)  

<h5>Plugin</h1>

What does the "plugin" part do? From the docs:  

<blockquote>
  This actually loads the file "ftplugin.vim" in 'runtimepath'.  
  
  <p>The result is that when a file is edited its plugin file is loaded (if there
  is one for the detected filetype).</p>
</blockquote>

The file being loaded is not necessarily named `ftplugin.vim`, it could be `ftplugin/html_example.vim` for instance.  

<h5>Indent</h1>

What does the "indent" part do? From the docs:  

<blockquote>
  This actually loads the file "indent.vim" in 'runtimepath'.  
  
  <p>The result is that when a file is edited its indent file is loaded (if there
  is one for the detected filetype). indent-expression</p>
</blockquote>

Again, the file may not be named `indent.vim`, it could be named `indent/html_example.vim` for instance.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: What are the .viminfo and .netrwhist files? (score [19886](https://stackoverflow.com/q/10671) in )

#### Question
I was wondering what's the purpose of .viminfo and .netrwhist files?  

#### Answer 2 (score 5)
You can see that here:  

<a href="http://vimhelp.appspot.com/starting.txt.html#viminfo" rel="nofollow noreferrer">`:h viminfo`</a>  

<blockquote>
  If you exit Vim and later start it again, you would normally lose a lot of information.  The viminfo file can be used to remember that information, which enables you to continue where you left off.  
</blockquote>

<a href="http://vimhelp.appspot.com/pi_netrw.txt.html#.netrwhist" rel="nofollow noreferrer">`:h .netrwhist`</a>  

<blockquote>
  <p>The file ".netrwhist" holds history when netrw (and vim) is not
  active. </p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: How to indent as spaces instead of tab? (score [19184](https://stackoverflow.com/q/4141) in 2017)

#### Question
I am coding some html templates in JADE files.  I want to auto indent code with spaces instead of tab. I tried `shiftwidth=2`, `tabstop=2`, but no matter what, it's still indents using tabs instead of spacebar, which causes the JADE compile to throw errors.  

How can I auto indent large sections of code using spaces instead of tabs?  

#### Answer accepted (score 25)
You are looking for the `expandtab` option.  When this option is set, spaces are <em>always</em> used.  You can put `set expandtab` in your vimrc to always have this option set when vim starts.  If you want to only enable this option for specific languages, see <a href="https://vi.stackexchange.com/questions/4/how-can-i-change-the-default-indentation-based-on-filetype/">this question</a>.  For help on this option, see `:help 'expandtab'`.  

#### Answer 2 (score 21)
You want expandtab.  

But there are usually a couple of options you want to set at the same time.  

If you add the following to your ~/.vimrc file  

```vim
" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When on uses space instead of tabs
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
```

Alternatively you can execute these manually from normal mode by proceeding them with ':'  

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: How can I show relative line numbers? (score [19134](https://stackoverflow.com/q/3) in 2015)

#### Question
A lot of vim commands can take a number referring to the number of lines that the command will act on.   

Is it possible to show the line numbers relative to the current line? Something like the following:  

```vim
3: some text here
2: more text
1: This is the line above where the cursor is
0: The cursor is on this line
1: This is the line after the cursor
2: More text here
```

#### Answer accepted (score 64)
I just replied to a similar question here: <a href="https://vi.stackexchange.com/questions/1/how-can-i-add-line-numbers-to-vim">How can I add line numbers to Vim?</a>  

Beginning with version 7.3, you can use the following:  

```vim
set relativenumber
```

I actually use both `relativenumber` and `number` in my vimrc which will use relative numbers for all lines except the current line.  

```vim
set number                     " Show current line number
set relativenumber             " Show relative line numbers
```

#### Answer 2 (score 6)
You can toggle relative numbering on and off using:  

```vim
:set rnu    " toggle relative numbering on
:set rnu!   " toggle relative numbering off
```

#### Answer 3 (score 5)
```vim
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <leader>nt :call NumberToggle()<cr>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: What is the difference between autoindent and smartindent in vimrc? (score [18488](https://stackoverflow.com/q/5818) in 2016)

#### Question
I read the wiki entry on <a href="http://vim.wikia.com/wiki/Indenting_source_code" rel="noreferrer">vim source code indentation</a>  

I still can't understand the difference between `autoindent` and `smartindent`  

It seems they do the same thing, copy the indentation level to next line when you press `enter`.  

#### Answer accepted (score 22)
`autoindent` essentially tells vim to apply the indentation of the current line to the next (created by pressing <kbd>enter</kbd> in <em>insert</em> mode or with <kbd>O</kbd> or <kbd>o</kbd> in <em>normal</em> mode.  

`smartindent` reacts to the syntax/style of the code you are editing (especially for C). When having it <em>on</em> you also should have `autoindent` <em>on</em>.  

`:help autoindent` also mentions two alternative settings: `cindent` and `indentexpr`, both of which make vim ignore the value of `smartindent`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: Why do I need both a vimrc and a gvimrc? (score [18307](https://stackoverflow.com/q/471) in 2015)

#### Question
There seems to be two ways to store preferences specific to gvim:  

<ol>
<li><p>Keep an `.vimrc` file for vim and a `.gvimrc` file for gvim specific additions.</p></li>
<li><p>Keep all settings in `.vimrc` and wrap gvim specific settings in a feature detection conditional:</p>

```vim
if has('gui_running')
    " gvim specific settings here
endif
```
</li>
</ol>

Given the existence of the latter option, why would I ever need a `.gvimrc` file?  

#### Answer accepted (score 29)
When the GUI starts, some settings are reset and then `.gvimrc` is processed.  

Consequently, if you want a non-default value for any of those settings, you'll need to set it in a `.gvimrc`; testing for GUI mode in `.vimrc` won't work.  

One such setting is `t_vb`, the terminal code used for the visual bell; in fact, all terminal optionals are reset to defaults for GUI mode (see `:help terminal-options`).  

Additionally a bunch of GUI setup and menu customization is carried out; if you want to tweak any of that, you'll want that in a `.gvimrc` or it may not have any impact.  

Reading over `:help gvimrc` provides a good overview of things that may change on you between the sourcing of your `.vimrc` and `.gvimrc` that you may want to consider re-adjusting in the latter.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: What is `softtabstop` used for? (score [17681](https://stackoverflow.com/q/4244) in 2015)

#### Question
I've been aware of these tab related settings in Vim:  

<ul>
<li>`ts`</li>
<li>`sw`</li>
<li>`expandtab`</li>
<li>`smarttab`</li>
<li>`sts`</li>
</ul>

My normal setting is `set ts=4 sw=4 expandtab smarttab`.   

But according to <a href="http://vimdoc.sourceforge.net/htmldoc/options.html#%27sts%27" rel="noreferrer">`sts` documentation</a>, if `expandtab` is not set, it will try to use a combination of spaces and tabs to make up of the desired number of blanks for a tab size.   

I can't really think of a useful scenario for this setting: Why would someone wants to have a fixed number of tabs and spaces that may just mess things up? The only advantage of doing this that I can think of is to reduce the number of characters and thus reduce the file size, which seems weird to me.  

#### Answer accepted (score 20)
As the `softtabstop` documention mentions, it's useful if you want to keep the default tab stop size of 8, but edit a file as if the tab stop size was some other value. For example, if you wanted an indentation level of 4 while editing code, but some comments had tab-indented text such as a table that depended on a tab stop of 8, you could set `sts` to `4`.  

One difference I notice between your tab settings (`set ts=4 sw=4 expandtab smarttab`) and the use of `sts` (e.g. `set ts=8 sts=4`) is when backspacing over spaces in the middle of a line of text. For example, consider the following line of text, where `·` indicates a space:  

```vim
some·text·······more·text
```

In insert mode, move the cursor just before the `m` of `more text`. With your settings, pressing Backspace deletes a single space. But while using `sts=4`, Backspace deletes all the way to the previous tab stop, as it would behave if the spaces were a tab character instead.  

You can set `sts=4` in addition to your settings and get the mid-line backspace behavior while not mixing tabs and spaces. Tabs will be expanded to four spaces, but you can backspace over a range of spaces in the middle of a line.  

#### Answer 2 (score 2)
See the example below,  

```vim
// Start vim without loading your vimrc. set only tabstop=8 softtabstop=4.
// This makes <Tab> in insert mode equals to 4 <Space> length at max.

// In insert mode, type 12, one <Tab>, 5. We get insertion below,
12··5
// Quit insert mode. Move cursor back, we find 2 <Space> inserted.

// In insert mode, type 12, two <Tab>, 9. We get insertion below,
12······9
// Quit insert mode. Move cursor back, you find a <Tab> inserted.

// In insert mode, type 12, three <Tab>, 3. We get insertion below,
12··········3
// Move the cursor back, you find a <Tab> and 4 <Space> inserted.

// We can even set sotftabstop=12, but this time we only need type one <Tab>, then 3.
12··········3
// Move the cursor back, you find a <Tab> and 4 <Sapce> inserted.
```

So `tabstop` is about how wide a `Tab` is defined, while `softtabstop` is about how far cursor moves while <strong>typing</strong> `Tab`. When they are not set to be the same value, it means that if you hit the `Tab` keystroke, it does not imply trivially a `Tab`character. In whatever cases, It is vim who decide once you quit insert mode. Vim will first try to match the insertion by as many `tabstop` as it can; if at last it cannot make a full `tabstop`, vim simply compensates by `Space`.   

To speak a little bit more, if you set `expandtab`, it is equal to say to vim:  

<blockquote>
  Please do not bother to calculate how many `Tab` and `Sapce` is needed. Simply insert `Space`.  
</blockquote>

#### Answer 3 (score 1)
Simple answer:  

<p>For example, it's extremly useful for programming, especially in Python, in which tabulation is crucial. 
When you press backspace with sts=4, it will untab the line, not delete a single space character.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: How to block replace code in visual mode? (score [17521](https://stackoverflow.com/q/2036) in )

#### Question
I have a list of items where I want to replace the first two characters:  

```vim
a) item 1
b) item 2
c) item 3
```

What is the fastest way to make this:  

```vim
* item 1
* item 2
* item 3
```

I have an approach with visual mode (Ctr-v, jjj, but need to do two replace commands. Iirc, this replacement can be done with 1 command)  

#### Answer accepted (score 26)
<strong>Visual-block selection:</strong>  

```vim
<C-v>
jjl
c*
<Esc>
```

<strong>`:normal`:</strong>  

```vim
:,+2norm! cE*
```

<strong>Substitution:</strong>  

```vim
:,+2s/^.\{2}/*
```

<strong>Dot formula:</strong>  

```vim
cE*<Esc>
j.
j.
```

#### Answer 2 (score 15)
Here is more efficient way of doing this:  

<ol>
<li>Having cursor on the first item and 1st letter (<kbd>0</kbd>), enter 'blockwise' visual mode <kbd>Ctrl</kbd>+<kbd>v</kbd> and select the 1st column of your current paragraph by <kbd>}</kbd> (if your list is finished by new line), otherwise use different methods like <em>arrow keys</em> (to move around the selection), or pattern search <kbd>/c)</kbd> where `c` is your last element).</li>
<li>Move to the last symbol of your list by <kbd>k</kbd> and <kbd>l</kbd> (or using <em>arrow keys</em>), so two columns are selected which you want to change.</li>
<li>Change the selected text by pressing <kbd>c</kbd> and type your bullet symbol (`*`) and finish by hitting <kbd>Esc</kbd>.</li>
</ol>

Works more efficiently especially in the longer lists.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: Trouble Using Color Scheme in NeoVim (score [17506](https://stackoverflow.com/q/3576) in 2015)

#### Question
I don't have a full understanding of how my color scheme is interacting with the `term` setting in vim and this is impeding my ability to get it to display correctly in neovim.  

In my .vimrc file, correct behavior of the color scheme in question requires setting  

```vim
set term=xterm
set t_Co=256
```

Omitting either of those settings results in incorrect display of the color scheme:  

<p><em>correct</em>
<img src="https://i.stack.imgur.com/DTNll.png" alt="Correct Color Display">
<em>incorrect</em>
<img src="https://i.stack.imgur.com/zdpYg.png" alt="Incorrect Color Display">
<em>different incorrect</em>
<img src="https://i.stack.imgur.com/6bEJ5.png" alt="Different Incorrect Color Display"></p>

The scheme looks like this:  

```vim
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="impact3"

if exists("g:impact_transbg")
    hi Normal       ctermfg=255 ctermbg=none
    hi NonText      ctermfg=DarkGray  ctermbg=none

    hi Statement    ctermfg=Blue      ctermbg=none
    hi Comment      ctermfg=DarkGray  ctermbg=none cterm=bold term=bold
    hi Constant     ctermfg=173  ctermbg=none
    hi Identifier   ctermfg=Cyan      ctermbg=none
    hi Type         ctermfg=DarkGreen ctermbg=none
    hi Folded       ctermfg=0 ctermbg=235 cterm=underline term=none
    hi Special      ctermfg=Blue      ctermbg=none
    hi PreProc      ctermfg=LightGray ctermbg=none cterm=bold term=bold
    hi Scrollbar    ctermfg=Blue      ctermbg=none
    hi Cursor       ctermfg=white     ctermbg=none
    hi ErrorMsg     ctermfg=Red       ctermbg=none cterm=bold term=bold
    hi WarningMsg   ctermfg=Yellow    ctermbg=none
    hi VertSplit    ctermfg=0     ctermbg=0
    hi Directory    ctermfg=Cyan      ctermbg=DarkBlue
    hi Visual       ctermfg=White     ctermbg=Gray cterm=underline term=none
    hi Title        ctermfg=255     ctermbg=Blue
    hi String       ctermfg=Blue   ctermbg=none

    hi StatusLine   term=bold cterm=bold,underline ctermfg=White ctermbg=Black
    hi StatusLineNC term=bold cterm=bold,underline ctermfg=Gray  ctermbg=Black
    hi LineNr       term=bold cterm=bold ctermfg=2 ctermbg=None
    hi Search       ctermfg=Black ctermbg=2
    hi TabLine      ctermfg=0 ctermbg=DarkGray
    hi TabLineFill  ctermfg=DarkGray ctermbg=DarkGray
else
    hi Normal       ctermfg=White ctermbg=Black
    hi NonText      ctermfg=DarkGray  ctermbg=Black

    hi Statement    ctermfg=Blue      ctermbg=Black
    hi Comment      ctermfg=DarkGray  ctermbg=Black cterm=bold term=bold
    hi Constant     ctermfg=DarkCyan  ctermbg=Black
    hi Identifier   ctermfg=Cyan      ctermbg=Black
    hi Type         ctermfg=DarkGreen ctermbg=Black
    hi Folded       ctermfg=DarkGreen ctermbg=Black cterm=underline term=none
    hi Special      ctermfg=Blue      ctermbg=Black
    hi PreProc      ctermfg=LightGray ctermbg=Black cterm=bold term=bold
    hi Scrollbar    ctermfg=Blue      ctermbg=Black
    hi Cursor       ctermfg=white     ctermbg=Black
    hi ErrorMsg     ctermfg=Red       ctermbg=Black cterm=bold term=bold
    hi WarningMsg   ctermfg=Yellow    ctermbg=Black
    hi VertSplit    ctermfg=White     ctermbg=Black
    hi Directory    ctermfg=Cyan      ctermbg=DarkBlue
    hi Visual       ctermfg=White     ctermbg=DarkGray cterm=underline term=none
    hi Title        ctermfg=White     ctermbg=DarkBlue

    hi StatusLine   term=bold cterm=bold,underline ctermfg=White ctermbg=Black
    hi StatusLineNC term=bold cterm=bold,underline ctermfg=Gray  ctermbg=Black
    hi LineNr       term=bold cterm=bold ctermfg=White ctermbg=Black
endif
```

In neovim, `term` cannot be set. I tried invoking neovim with a manually set $TERM like so:  

```vim
TERM=xterm nvim
```

This produced the correct display of colors in regular vim (i.e. equivalent to setting term in .vimrc), but in neovim it looks like this:  

<img src="https://i.stack.imgur.com/Kz7IT.png" alt="enter image description here">  

<strong>Why is the combination of `set term=xterm` and `set t_Co=256` necessary to produce the correct display of this color scheme in vim and why does the equivalent combination of settings produce a different result in neovim?</strong>  

<em>Edit:</em>  

<em>The default is</em> `$TERM=xterm256-color`, <em>which for some reason has to be overridden to `xterm` in regular vim to make the color display correctly. With the environment variable at the 256 default, neovim looks like this:</em>  

<img src="https://i.stack.imgur.com/1nfki.png" alt="enter image description here">  

<em>This is identical to regular vim with `xterm256-color`, but not as intended. My goal is to understand why the xterm hack is necessary/working in vim, and why it doesn't look the same in neovim.</em>  

<em>Note that many of the colors appear correctly with the above term env variable setting, notable exceptions being line numbers and background. I suspect that the way the colors are specified in this specific color scheme may be involved.</em>  

#### Answer accepted (score 10)
<h5>Main Issue</h2>

<p>The main problem you are experiencing is caused by the ordering of the
commands in your `.vimrc`.</p>

<p>You set the `g:impact_transbg` variable <em>after</em> you load the colorscheme, and
so the variable does <em>not</em> exist when checked by the colorscheme's `if` statement, and
the second version of the colorscheme (in the `else` block) is used.</p>

<p>To fix, you simply need to move the line that sets the variable above the line
where you load the colorscheme:</p>

```vim
let g:impact_transbg=1
colorscheme impact3
```

You can (and should!) then remove the unnecessary lines from your `.vimrc`:  

```vim
set term=xterm
set background=dark
set t_Co=256
```

<h5>Other Issues</h2>

<p>I can also clear up a few other misconceptions/confusions you might have about
how this all works:</p>

<h5>Explaining the behaviour of `'term'` &amp; `'t_Co'`</h3>

<p>Your $TERM is set to `xterm256-color`. Vim reads this, and queries terminfo (or
termcap) to find out how many colours the terminal supports, and then sets
`'t_Co'` accordingly. Presuming your $TERM is correct (yours is) and your
terminfo database contains the correct information for that terminal (yours
does) you should <em>never</em> need to manually reset `'t_Co'`.</p>

<p>However, you are then manually setting Vim's `'term'` to xterm. Your terminfo tells
Vim that this terminal only supports 8 colours, so adding this will cause
`'t_Co'` to be incorrectly set to 8. You are manually setting `'t_Co'` <em>back</em> to
256, but if you had left the `'term'` setting at the correct value, you would
not have needed to.</p>

<p>Incidentally, when you change `'t_Co'` manually after setting `g:impact_transbg`, it
causes the colorscheme to be reloaded (to allow the colorscheme to adapt to the
new number of colours), and because `g:impact_transbg` <em>is</em> now set, you get the
colours you desire.</p>

<p>(With the line setting `'term'` omitted, `'t_Co'` is <em>already</em> set to 256 when you get
to the latter line in your .vimrc, and so the colorscheme is not reloaded: hence
wrong colours.)</p>

So, to recap:  

```vim
term=xterm
colorscheme impact3
let g:impact_transbg=1
set t_Co=256
```

Result: Colorscheme is reloaded when `'t_Co'` is set to 256, colours are correct.  

```vim
"term=xterm
colorscheme impact3
let g:impact_transbg=1
set t_Co=256
```

<p>Result: Colorscheme is loaded by `colorscheme` command, variable does not exist,
colours are wrong.</p>

```vim
term=xterm
colorscheme impact3
let g:impact_transbg=1
"set t_Co=256
```

<p>Result: Colorscheme is loaded by `colorscheme` command, variable does not exist
and Vim only uses 8 colours, colours are wrong.</p>

```vim
"term=xterm
colorscheme impact3
let g:impact_transbg=1
"set t_Co=256
```

<p>Result: Colorscheme is loaded by `colorscheme` command, variable does not exist,
colours are wrong.</p>

```vim
let g:impact_transbg=1
colorscheme impact3
```

Result: Colorscheme is loaded by `colorscheme` command, variable <em>does</em> exist, so colours are correct. (And as a bonus `'term'` and `'t_Co'` are also correct!)  

The behaviour is different in NeoVim simply because the call to set `'t_Co'` is ignored, as other answerers have already mentioned.  

<h5>`'background'`</h3>

<p>After setting the colorscheme, you also set `'background'`. For this <em>particular</em>
colorscheme, this is completely unnecessary, because the first thing the
colorscheme does is to set `'background'` to `'dark'`.</p>

<p>Note that I disagree with the other answerer who suggests that you should set
`'background'` after loading your colorscheme. The colorscheme may use the value
of `'background'` to adjust its colors, so setting `'background'` before loading
the colorscheme is the more obvious ordering. (Although note that if you change
the `'background'` setting, Vim will reload any loaded colorschemes, so setting
it `'background'` afterwards would also work: it's just non-optimal.)</p>

#### Answer 2 (score 7)
In the case of Neovim, `t_Co` and `TERM` make no difference.  

You are calling `set background=dark`before <em>and</em> after the call to `colorscheme impact3`. Move `set background=dark` to the bottom of the colorscheme, and <em>remove</em> the other call from your vimrc.  

From `:help 'background'`:  

```vim
When 'background' is set Vim will adjust the default color 
groups for the new value.
...
When a color scheme is loaded (the "g:colors_name" variable 
is set) setting 'background' will cause the color scheme to 
be reloaded.
```

See also: <a href="https://github.com/justinmk/molokai/commit/aa1cc201c743dd7d1b80bb2e2b5fbb7894ebfe5f" rel="nofollow noreferrer">https://github.com/justinmk/molokai/commit/aa1cc201c743dd7d1b80bb2e2b5fbb7894ebfe5f</a>  

<blockquote>
  My goal is to understand why the xterm hack is necessary/working in vim, and why it doesn't look the same in neovim.  
</blockquote>

<ul>
<li>Neovim doesn't care about `t_Co` because it assumes 256 unless you <a href="https://github.com/neovim/neovim/wiki/FAQ#how-can-i-use-true-color-in-the-terminal" rel="nofollow noreferrer">enable "true color"</a>.

<ul>
<li>In fact Neovim ignores all `t_*` options, see `:help t_xx`.</li>
</ul></li>
<li>Neovim doesn't allow `&term` to be set because it is meaningless. Neovim uses <a href="https://github.com/mauke/unibilium" rel="nofollow noreferrer">unibilium</a> and other mechanisms to detect terminal capabilities.</li>
</ul>

#### Answer 3 (score 2)
I see you use iTerm2, so you can try this:  

<ol>
<li>Open prefernces window <kbd>⌘</kbd>+<kbd>,</kbd></li>
<li>Go to `profiles` tab</li>
<li>Check your current profile in the left list</li>
<li>Click on the tab `terminal` at right</li>
<li>In the `Report terminal type` choose `xterm-256color`</li>
<li>Done.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: Show only matching lines? (score [16648](https://stackoverflow.com/q/2280) in 2015)

#### Question
<p>In a long file, I would like to search for a pattern that will match roughly 200 lines or so. The matched lines are in random places in the file.<br>
When a line matches, only the line itself is relevant, no context above or below.</p>

<p>Normally, I would search with `/` and jump through the matches with `n`.<br>
But that means there are only one or two relevant lines on the screen at a time.  </p>

<strong>Is there a way to hide all lines that did not match, while going through the list of result lines?</strong>  

<br>  

A brute force approach would be to delete all non-matching lines, and undo that deletion later. But that's ugly in various ways, even if it would not end up in persistent undo...  

#### Answer 2 (score 33)
```vim
:vimgrep pattern %
:cwin
```

<a href="http://vimhelp.appspot.com/quickfix.txt.html#grep">`vimgrep`</a> will search for your pattern in the current file (`%`), or whatever files you specify.  

<a href="http://vimhelp.appspot.com/quickfix.txt.html#%3Acwin">`cwin`</a> will then open a buffer in your window that will only show the desired lines. You can use pretty much any navigating/search command within the `cwin` buffer. Press return to jump to the line under your cursor in the source file.  

#### Answer 3 (score 14)
You can list all matching lines with  

```vim
:g/{pattern}
```

(The `:print` command can be omitted; it is the default for `:g`.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Can I jump to a function declaration or definition in a multiple C++ source files project? (score [16557](https://stackoverflow.com/q/1977) in 2015)

#### Question
Can I jump to a function declaration or definition in a multiple C++ source files project?  

Lets say I have a header file `foo.hpp`:  

```vim
int bar();
```

and a source file `foo.cpp`:  

```vim
#include "foo.hpp"
int bar() { return 42; }
```

and a main file `main.cpp`:  

```vim
#include "foo.hpp"
int main() { bar(); return 0; }
```

Can vim find both the definition and declaration of the function `bar()` from the `main` function?  

#### Answer accepted (score 13)
<p>Exuberant ctags is the simplest way to achieve this. 
Under GNU/Linux (e.g. Ubuntu or Debian) you should be able to just do</p>

```vim
sudo apt-get install exuberant-ctags
```

(For OSX "$ brew install ctags" should suffice; for Windows you might want to visit <a href="http://ctags.sourceforge.net/">http://ctags.sourceforge.net/</a> and download the standalone executable)  

Then navigate to your project's root folder and run   

```vim
ctags -R --exclude=.git .
```

This will scan your entire project and create a ./tags file which vim will automatically use to provide you with the ability to jump to functions at the press of a key. Namely:  

```vim
Ctrl + ]
```

<p>with your cursor placed on the function you want to see the implementation for.
There are other combinations and many command mode functions that let you navigate through your code by ctags as well (e.g. <kbd>Ctrl</kbd>+<kbd>t</kbd> to jump to older tag stack entry). See `:help 29.1` for an overview.</p>

<strong>Note</strong> that you have to re-run ctags for each significant change in the code and let it re-index your project. You can either do that manually, or teach vim to do it on hotkey or on write.   

<em>Hint:</em> if you make extensive use of ctags, maybe the vim-taglist (<a href="http://vim-taglist.sourceforge.net">http://vim-taglist.sourceforge.net</a>) plugin is worth a look as well. It gives you an IDE-style outline with a list of all functions for that class/file.  

#### Answer 2 (score 4)
So far I can name two solutions to the problem of finding either the declaration or the definition of a function. I know there is another well know tags based solution, but as I don't use it, I'll let others give it to you.  

The more trendy one first: <a href="https://github.com/Valloric/YouCompleteMe" rel="nofollow noreferrer">YouCompleteMe</a> has a `:GoToDefinition` and a `:GoToDeclaration` pair of commands.  

The one I use (it's hard to change 10years long habits). My <a href="http://lh-vim.googlecode.com/svn/tags/trunk/lh-tags-addon-info.txt" rel="nofollow noreferrer">lh-tags</a> plugin has a way to generate a ctags database and to update it incrementally. And also it offers a way (`CTRL+W Meta+Down`) to present all declarations and definitions that match what is under the cursor (/what is selected). As this solution relies on ctags, it won't be able to know which overload the identifier under the cursor is really related too. Other ctags based solutions should as bad (/as good) on this topic. However YCM should be much better here.  

Discl.: I did implement lh-tags as a more ergonomic alternative to `:tselect`.  

(Actually I remember a third solution: I had started a fork of <a href="https://github.com/LucHermitte/clang_indexer" rel="nofollow noreferrer">clang-indexer</a> and the related <a href="https://github.com/LucHermitte/vim-clang" rel="nofollow noreferrer">vim plugin</a> that would have encapsulated it. But with YCM around, I'd to forget this solution)  

EDIT: As of 2019, the most efficient solution rely on <a href="https://langserver.org/" rel="nofollow noreferrer">LSP servers</a>. I'm using <a href="https://github.com/neoclide/coc.nvim" rel="nofollow noreferrer">COC</a>+<a href="https://github.com/MaskRay/ccls/" rel="nofollow noreferrer">ccls</a> to index, jump and do many more things. I'm falling back to tags based solutions when I'm too lazy to configure COC for a project on which I won't spend much time or where I cannot install recent versions of clang and ccls.  

#### Answer 3 (score 3)
There are few alternatives. The first one is `ctags`. If you need a more advanced indexer then `cscope` is a better alternative. For instance it will allow you to list <em>all callers</em> of given function. These tools will index your code without really understanding it properly (they do have a simple grammar definition to know what given symbol means). It's also relatively easy to extend that grammar. The `taglist` plugin is a must have for these and it's possible to extend indexer grammar to show results in taglist.  

If you need something more than indexer then like syntax checking then `YouCompleteMe` is probably the way to go. It's build on top of the `llvm` and thus has proper parser. This allows to check the code <em>syntax and semantics</em>.  

Then if you work with a code that has domain specific language or embedded code then you often end up just greping thru files. Alternative is `Ack` perl script that tries to help with this task.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: How to diff and merge two directories? (score [15944](https://stackoverflow.com/q/778) in 2017)

#### Question
I know that <a href="https://vi.stackexchange.com/questions/625/how-do-i-use-vim-as-a-diff-tool">Vim's diff mode</a> (`vimdiff`) allows us to compare the contents of two (or more) files.  

But it is possible to compare content of multiple files across directories in order to merge two directories recursively (like DiffMerge and similar tools)?  

#### Answer accepted (score 29)
There is <a href="http://www.vim.org/scripts/script.php?script_id=102" rel="noreferrer">DirDiff.vim</a> plugin (<a href="https://github.com/will133/vim-dirdiff" rel="noreferrer">GitHub</a>) to diff and merge two directories recursively.  

<blockquote>
  <p>It performs a recursive diff on two directories and generate a diff
  "window". Based on that window you can perform various diff operations
  such as opening two files in Vim's diff mode, copy the file or
  directory recursively to the other, or remove the directory tree from
  the source directory.</p>
</blockquote>

Usage:  

```vim
:DirDiff <dir1> <dir2>
```

For more information / help: `:help dirdiff`  

See the screenshot:  

<a href="https://github.com/will133/vim-dirdiff#vim-dirdiff" rel="noreferrer"><img src="https://i.stack.imgur.com/CM7U2.png" alt="wlee screenshot"></a>  

See also:  

<ul>
<li>(video) <a href="http://www.youtube.com/watch?v=LQZBiHRo_UU" rel="noreferrer">DirDiff.vim, diff and merge two directories recursively</a> by Yu-Jie Lin at YouTube</li>
<li><p><a href="http://web.archive.org/web/20150618154142/http://dedm.livejournal.com:80/115224.html" rel="noreferrer">Recursively compare and merge directories?</a> at dedm blog</p>

<a href="http://dedm.livejournal.com/115224.html" rel="noreferrer"><img src="https://i.stack.imgur.com/LHG23.png" alt="two random directories"></a>  </li>
</ul>

#### Answer 2 (score 4)
<p>I use a wrapper script in `python` to merge files (see below). This is a
simplified version of what I use to merge my `~/.vim` dirs and such.</p>

<p>It should work in Python 2 and 3; but probably not in very old versions of
Python as shipped with CentOS and some other distros.</p>

<p>Be aware that some checks (like the one for binary files, or if the files are
the same) are not very fast (it reads the entire file); you could remove them if
you want.</p>

It also doesn't report if a is only present in one of the directories...  

```vim
#!/usr/bin/env python
from __future__ import print_function
import hashlib, os, subprocess, sys

if len(sys.argv) < 3:
    print('Usage: {} dir1 dir2'.format(sys.argv[0]))
    sys.exit(1)

dir1 = os.path.realpath(sys.argv[1])
dir2 = os.path.realpath(sys.argv[2])

for root, dirs, files in os.walk(dir1):
    for f in files:
        f1 = '{}/{}'.format(root, f)
        f2 = f1.replace(dir1, dir2, 1)

        # Don't diff files over 1MiB
        if os.stat(f1).st_size > 1048576 or os.stat(f2).st_size > 1048576: continue

        # Check if files are the same; in which case a diff is useless
        h1 = hashlib.sha256(open(f1, 'rb').read()).hexdigest()
        h2 = hashlib.sha256(open(f2, 'rb').read()).hexdigest()
        if h1 == h2: continue

        # Don't diff binary files
        if open(f1, 'rb').read().find(b'\000') >= 0: continue

        subprocess.call(['vimdiff', f1, f2])
```

#### Answer 3 (score 3)
I've wanted the same for a while. The best solution I found was to use <a href="https://github.com/Osse/vdwrap" rel="nofollow">vdwrap</a>, which works amazingly well. All it does is wrap `git difftool --dir-diff` for `vimdiff`. It doesn't require any vim plugins.  

All you need to do is tell `git difftool` to use `vdwrap`:  

```vim
git config --global difftool.vdwrap.cmd '/full/path/vdwrap $LOCAL $REMOTE'
git config --global diff.tool vdwrap
```

The next time you use git difftool, it will open Vim with separate Vim tabs for each pairs of files.  

A caveat is that it's a Zsh script. It should be pretty simple to convert it to a bash script but I haven't given that a go.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: How to jump to function call? (score [15853](https://stackoverflow.com/q/4955) in )

#### Question
After generating a tags file with `exuberant-ctags` I can jump from a function call to its declaration with `<C-]>` which is pretty convenient.  

My question is how to do it in the other way? When my cursor is on the definition of a function, how can I go to the lines where the function is called?  

When I look to the file generated by ctags I only see informations related to the location of the definition and not of the calls, does it means that I can't do that, that Vim as a clever workaround or that I need to use something else than `exuberant-ctags`?  

#### Answer 2 (score 11)
You can't jump to function calls with `ctags`.  For C/C++ and Java there is <a href="http://cscope.sourceforge.net/">`cscope`</a>, and it integrates nicely with Vim (see <a href="http://vimhelp.appspot.com/if_cscop.txt.html">`:help cscope`</a>).  For other languages you might be able to find a tool that generates / exports `cscope`-compatible databases (f.i. <a href="https://github.com/bosu/hscope">`hscope`</a> for Haskell, and <a href="https://github.com/eapache/starscope/">`starscope`</a> for Ruby, Go, and JavaScript).  You can also use `cscope` with <a href="http://www.gnu.org/software/global/">GNU global</a> databases, by pointing `cscopeprg` to `gtags-cscope`.  

On a side note: if you aren't put off by occasionally puzzling use of <a href="https://en.wikipedia.org/wiki/Engrish">Engrish</a>, ;) you probably also want to use <a href="https://github.com/universal-ctags/ctags">universal-ctags</a> instead of `exuberant-ctags`.  The latter hasn't been updated in years.  The former is an actively maintained fork.  

#### Answer 3 (score 8)
You can't do that with ctags.  

Try a beefier alternative like <a href="http://cscope.sourceforge.net/">cscope</a> (which even has its own help section: `:help cscope`) or <a href="http://www.gnu.org/software/global/">global</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: How can I get vim to stop putting comments in front of new lines? (score [15818](https://stackoverflow.com/q/1983) in 2015)

#### Question
I'm editing my `.vimrc` file, and I am including comments. When I have a comment like this:  

```vim
" example comment
```

And then hit enter at the end of the line after finishing the comment, the next line is automatically set up as a comment (the quotes are automatically inserted):  

```vim
" example comment
" 
```

How can I stop this behavior?  

#### Answer accepted (score 66)
This is controlled with the `formatoptions` setting; from <a href="http://vimhelp.appspot.com/change.txt.html#fo-table">`:help fo-table`</a>:  

<blockquote>
  <p>You can use the `'formatoptions'` option  to influence how Vim formats text.
      `'formatoptions'` is a string that can contain any of the letters below.  The
      default setting is `tcq`.  You can separate the option letters with commas for
      readability.</p>
</blockquote>

Note that the statement about the "defaults" is somewhat misleading, since many filetypes change the formatoptions to best suit the file type; for example in `/usr/share/vim/vim74/ftplugin/vim.vim`:  

```vim
" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql
```

You can view the current `formatoptions` with:  

```vim
:set fo?
  formatoptions=jcroql
```

And see where they were set like so:  

```vim
:verbose set fo?
  formatoptions=jcroql
      Last set from /usr/share/vim/vim74/ftplugin/vim.vim
```

In this case, you want to remove the `r` flag, but perhaps also the `c` and `o` flags:  

```vim
r       Automatically insert the current comment leader after hitting
        <Enter> in Insert mode.
c       Auto-wrap comments using textwidth, inserting the current comment
        leader automatically.
o       Automatically insert the current comment leader after hitting 'o' or
        'O' in Normal mode.
```

This can be done like so:  

```vim
:set formatoptions-=r formatoptions-=c formatoptions-=o
```

Note that using `:set formatoptions-=cro` won't work as expected (since it's a string, it will look for the string `cro`, in that order, which often won't work.).  

To set the changes <em>only</em> for the current buffer, use `:setlocal` instead of `:set`. If you want to <em>always</em> have these options, it's probably best to use an `autocmd` in your vimrc; for example:  

```vim
au FileType vim setlocal fo-=c fo-=r fo-=o
```

This will set the options <em>only</em> for the 'vim' filetype, and won't interfere with other filetypes.  

If you want to <em>always</em> set it, use:  

```vim
au FileType * set fo-=c fo-=r fo-=o
```

Just using `set fo-=cro` won't work since many filetypes set/expand `formatoption` (like shown above); the FileType autocmd is executed <em>after</em> the filetype files have loaded.  

#### Answer 2 (score 1)
Add this in your vimrc:  

```vim
au BufEnter * set fo-=c fo-=r fo-=o
```

Using `FileType` won't work since other plugins set `formatoption`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: How do I know the patch version of my vim? (score [15753](https://stackoverflow.com/q/2466) in )

#### Question
I have vim 7.4 installed, but I'm not sure what patch level it was at when I installed it. How do I check?  

```vim
vim --version
```

Gives   

```vim
VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Oct 15 2014 16:18:44)
....
```

But it doesn't give the patch level or a minor version number.  

#### Answer accepted (score 25)
You seem to simply have an unpatched version of vim, otherwise the `:version` command or the `--version` parameter would list the patches on the second line. For example on my machine it says:  

```vim
VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Sep 10 2014 09:36:33)
Included patches: 1-207, 209-355, 357-430
```

This is "patchlevel" 430, but it skips patches 208 &amp; 356.  

Vim doesn't have a "minor version number" beyond <em>major.minor</em>; although I believe that some distributions may use the "patchlevel" as such.  

<hr>

As shown above, not all patches may be included, so if you want to use this value you can't just check if a number is higher than a certain version.  

Usually, the best way is to use `has("patch-7.4-399")`; this will return true if:  

<ul>
<li>We're running Vim 7.4 with patch 399 included.</li>
<li>We're running Vim 7.5 or later.</li>
</ul>

You can also use the form of `has('patch399')`, which is typically used like:  

```vim
if v:version == 704 && has('patch399')
```

But be aware; this will be <em>false</em> for Vim 7.5; use this only in very specific cases.  

See <a href="http://vimhelp.appspot.com/eval.txt.html#feature-list">`:help feature-list`</a> for some more information.  

<hr>

I can't find a way to list all the included patches, other than redirecting `:version` and parsing that ... I'm also not sure how this would be useful anyway, as `has()` should be enough :-)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: How do I debug my vimrc file? (score [15629](https://stackoverflow.com/q/2003) in 2018)

#### Question
I have a problem in Vim, and I think it may be in my `vimrc` file (or have been <em>told</em> it could be my `vimrc` file).  

How do I verify this? If it <em>is</em> my `vimrc` file, how do I know where <em>exactly</em> the problem lies?  

#### Answer accepted (score 79)
The first thing you want to do is to start Vim with the default settings:  

```vim
vim -u NONE -U NONE -N
```

<p>The `-u NONE` prevents Vim from loading your vimrc, `-U NONE` prevents Vim from
loading your gvimrc, and `-N` tells Vim to use no-compatible mode (this isn't
required, but most Vim users are not used to "compatible" mode).
Note that the `NONE` is <em>required</em> to be in all-caps.</p>

In Windows you can <a href="https://superuser.com/questions/29569/how-to-add-command-line-options-to-shortcut">add these flags by creating a new shortcut</a><sup>1</sup>.  

<ul>
<li><p>If the problem stays, then you know it's <em>not</em> something in your vimrc.</p></li>
<li><p>If the problem disappears, you now it's caused by <em>something</em> in your vimrc
file.</p></li>
</ul>

<h5>It's not my vimrc!</h1>

<p>Hurray! Go and ask your question. Be sure to mention that you tried starting Vim
without a vimrc file!</p>

<h5>So it's my vimrc, now what?</h1>

<p>If you haven't already, you probably want to save a backup copy of your vimrc
file first.</p>

<h5>Check the plugins</h2>

<p>The next thing you probably want to do is disable all plugins first; plugins can
alter quite a bit in Vim. If this fixes the problem, then try to find out
<em>which</em> plugin by re-enabling them one-by-one. After you've found out which
plugin exactly causes the problem, you can try &amp; fix it by reading this plugin's
documentation, and/or by asking a question tagged with `plugin-<name>`.</p>

<p>If it's <em>not</em> a plugin, and you don't have <em>any</em> idea what's causing your
problem, then it's a trial-and-error procedure. Comment out one or more lines in
your vimrc, start Vim, check if the problem occurs, and repeat this procedure
until the problem stops occurring. The fastest way of doing this is:</p>

<ol>
<li>Comment out (or remove) about half your vimrc file.</li>
<li>Restart Vim, or open a new Vim (reloading the vimrc is <em>not</em> good enough, as
settings aren't unset).</li>
<li>Is the problem now gone? Put back the part you removed out (keeping Vim
open and using undo is useful here) and repeat step 1 on the part you added
back.</li>
<li>Does the problem still occur? Go to step 1.</li>
</ol>

<p>In the end you should have a single option or a combination of a few options
that causes your problem. You can find out more about any option in Vim by
using:</p>

```vim
:help 'option_name'
```

<p>The quotes are important here, it <em>usually</em> works without them, but sometimes
you end up on the wrong page if you omit them.</p>

<p>If you're still confused after reading the help page, you know where to ask a
question ;-)</p>

<h5>Debugging a single plugin</h1>

<p>If you want to isolate a single plugin, perhaps to ask a question about it, you want to load as little as
possible but <em>still</em> load the plugin; you can easily do this with Vim's packages
feature. This requires Vim 8 or a reasonably recent version of Neovim.</p>

<ol>
<li><p>Create a new empty directory; we'll use the `~/plugin` path in this example.
Now put the plugin in the regular `pack/plugins/start/$name` directory. For
example:</p>

```vim
git clone https://github.com/fatih/vim-go.git ~/plugin/pack/plugins/start/vim-go
```
</li>
<li><p>Create a `test-vimrc` file with the following contents; this will ensure that
Vim will load plugins from the `~/plugin` directory and <em>not</em> the `~/.vim`
directory:</p>

```vim
set nocompatible
set packpath=~/plugin,/usr/share/vim/vimfiles,/usr/share/vim/vim80,/usr/share/vim/vimfiles/after,~/plugin/after
packloadall!

syntax on
filetype plugin indent on
```
</li>
<li><p>Start Vim with:</p>

```vim
vim -U NONE -u ~/test-vimrc
```

You now have a minimal vimrc with just this single plugin.  </li>
</ol>

<hr>

<strong>Footnotes</strong>  

<sup>1</sup> For example: on 64 bit Windows, the shortcut would look something like this: `"C:\Program Files (x86)\Vim\vim74\vim.exe" -u NONE -U NONE -N`. To create it, right click in File Explorer where you want the shortcut, then select New -> Shortcut and paste the shortcut text. You may need to change the Vim path if your Vim is installed in another location.  

#### Answer 2 (score 31)
There is `-D` Vim parameter specially for debugging which will go to debugging mode after executing the first command from a script.  

E.g. to run Vim in debug mode without any plugins, run as:  

```vim
vim --noplugin -D
```

Type `n`/`next` to parse the next line and keep pressing <kbd>Enter</kbd>.  

And `cont` or `q` to go back to `vim` interface.  

If you're using a GUI version, put a `gui` command in your vimrc to start the debugging right after that command.  

Press <kbd>Ctrl</kbd>+<kbd>d</kbd> for list of available commands  

Read more:  

<ul>
<li><a href="http://vim.wikia.com/wiki/Debug_unexpected_option_settings">Debug unexpected option settings</a> at Vim tips wiki</li>
<li><a href="http://vimhelp.appspot.com/repeat.txt.html#debug-scripts">`:help debug-scripts`</a></li>
</ul>

#### Answer 3 (score 11)
As already mentioned, first try `vim -u NONE -U NONE -N` to make sure your vanilla vim is working fine.  

Then start vim normally and check  

```vim
:messages
```

from inside vim after the problem, which will show all warnings and errors.  

Finally start vim with the following command  

```vim
vim -V9logfile.log
```

which will create a logfile called `logfile.log`, `-V9` is the logging level and try to reproduce your problem.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Why is using arrow keys in normal mode considered bad practice? (score [15441](https://stackoverflow.com/q/15673) in 2018)

#### Question
I have read it in many articles (<a href="http://kgrz.io/getting-started-with-using-vim.html" rel="noreferrer">e.g.</a>) that it's a bad practice to use arrow keys in normal mode. Could somebody explain why is it considered a wrong practice, if at all?  

#### Answer accepted (score 66)
Actually this is not a bad practice.  

A lot of people (<em>including Vim's doc as @B Layer's answer shows</em>) argue that you shall not use arrow keys because it makes your hands move from the home row (the second line of your keyboard where you have <kbd>h</kbd><kbd>j</kbd><kbd>k</kbd><kbd>l</kbd>) and that make you less efficient.  

This is (IMO at least) a bad result from vim "purists" circle jerk: new users follow this blindly, some even disable the arrow keys and then they complain that they are not as efficient as before.  

The only real rule to use vim is to use it efficiently: if you feel more comfortable using <kbd>Left</kbd> and <kbd>Right</kbd> than <kbd>h</kbd> and <kbd>l</kbd>  be it, use the arrow keys. Vim even has `set mouse=a` option if you want to use a mouse!  

Once you get used to vim and get better with the different available motions (<kbd>f</kbd>, <kbd>t</kbd>, <kbd>,</kbd>, <kbd>;</kbd>, <kbd>w</kbd>, <kbd>b</kbd>, <kbd>e</kbd>, <kbd>g</kbd><kbd>e</kbd>, and basically everything in <a href="http://vimhelp.appspot.com/quickref.txt.html#quickref" rel="noreferrer">`:h quickref`</a>) you might realize that you don't use arrow keys that much. And if you still use them, it's not a problem, use what you are most efficient with.  

<strong>Note</strong> That the argument of don't leave the home row for more efficiency is not that good in my opinion: If you take a look at <a href="https://vi.stackexchange.com/q/9313/1841">Why does vim use hjkl</a> you'll see that these keys were chosen because there weren't any arrow keys when Vi was written. One could argue that maybe if the keyboards were different at this time no one would consider not using the arrow keys a good practice.  

#### Answer 2 (score 40)
I don't know if this is really relevant any more, but I'm an old-timer so here's a bit of history.  

<p>In the old days, VT100 terminals had arrow keys, but pressing one transmitted an escape sequence like `<ESC>[A` for up, `<ESC>[B` for down, etc.<br>
Also, being a serial terminal communicating at 9600 baud, it was possible for the user to press the keys too fast to transmit the whole sequence which would cause one key press to interrupt the sequence of the previous key press and confuse vi.  </p>

This would cause vi to inexplicably go into insert mode and insert [B[B[B[B[B[B into your file if you held down the down arrow.  I say inexplicably because there's nothing about this sequence that should enter insert mode and the fact that each sequence starts with an ESC character should have exited insert mode.  But still, it would insert garbage.  Not always - just when you were in a hurry.  

One quickly got tired of this and decided to just stick to the `hjkl` keys.  

#### Answer 3 (score 28)
While I agree with @statox that no one should be chastised, shunned, excommunicated, or tarred-and-feathered if they choose to use the arrow keys...use your software however you see fit...I wouldn't exude as much of a laissez-faire attitude if I were giving guidance to an open-minded new user. I'd pretty strongly recommend that they start with following best practices. They are "best practices" for a reason...they've been employed to good effect by lots of people who came before you and me.   

Heck, even <a href="http://vimhelp.appspot.com/usr_02.txt.html#hjkl" rel="noreferrer">Vim's own help nudges you in that direction</a>, though not without hyperbole ("<em>greatly</em> slow down")...  

<blockquote>
  <p>You can also move the cursor by using the arrow keys.  If you do,
  however, you greatly slow down your editing because to press the arrow
  keys, you must move your hand from the text keys to the arrow keys.
  Considering that you might be doing it hundreds of times an hour, this
  can take a significant amount of time.</p>
</blockquote>

There's also the fact that whatever choices you make at the start may become habits that are difficult to break if you want to change in the future. So all else being equal why not adopt a recommended habit now rather than take the chance that using arrow keys <em>is</em> inefficient or carpal-killing?  

All in all, consider giving an honest effort to doing things without arrow keys. After a reasonable amount of time if you just can't live without up/down/left/right...don't.  

<em>...is what I would say to a new user who was interested in my opinion. Don't take it personally if you don't agree (I'm talking to you, downvoter).</em>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: Execute normal command over range (score [15035](https://stackoverflow.com/q/4418) in 2015)

#### Question
For a file looking like this:  

```vim
   2  AD,42.546245,1.601554,Andorra,376
   3  AE,23.424076,53.847818,United Arab Emirates,971
   4  AF,33.93911,67.709953,Afghanistan,93
   5  AG,17.060816,-61.796428,Antigua and Barbuda,1
```

I am trying to remove the leading spaces and numbers for the first 10 lines, so I'd end up with   

```vim
AD,42.546245,1.601554,Andorra,376
AE,23.424076,53.847818,United Arab Emirates,971
AF,33.93911,67.709953,Afghanistan,93
AG,17.060816,-61.796428,Antigua and Barbuda,1
```

Why does "remove two words" `:d2w` work for a single line, but not for a range `:1,10d2w`?  

NOTE:  

The problem itself is solved due to the fixed format, using `:1,10s/.\{8\}//`, so this is more about understanding how to use ranges with `:dNw`   

#### Answer accepted (score 14)
You can do this with the normal command :   

```vim
:1,10normal d2w
```

This is because the `d` operator doesn't accept a range, but only a motion :  

```vim
:h d

["x]d{motion}           Delete text that {motion} moves over [into register x].
```

Alternatively you can select your text in visual mode and you can do :  

```vim
:'<,'>normal d2w
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Vim Code Completion for Python 3 (score [14860](https://stackoverflow.com/q/2403) in 2015)

#### Question
I am running Debian Jessie and use the current vim-nox (with +python -python3). I am having a hard time trying to program in Python 3, as I struggle with Python 3 code completion.  

YouCompleteMe doesn't support Python3 at all. jedi-vim does support Python 3 completion, but only if I would have the +python3 option if I understand it correctly. From several posts from Debian Developers it seems that compiling Vim with the +python3 flag is not really working. Therefore I am left with the python-mode plugin.  

Besides the fact that python-mode seems unmaintained (see open pull-requests and last commits) and it currently has a huge bug concerning rope in its master branch, it interferes with YouCompleteMe. I do get some Python 3 code completion to work, but only if I disable YouCompleteMe totally. Blacklisting YCM for python filetypes or disabling YCM completion for python files doesn't work, I get a YCM warning each time I open vim.  

So my questions are:  

How can I get a Python 3 autocompletion to work on a current Debian distribution while not deactivating YouCompleteMe (which I want for other programmming languages)? How come an unmaintained plugin is the only choice at the moment for code completion for such an important programming language (Python 3 can no longer be considered new..)?  

#### Answer accepted (score 17)
The ideal way is to get Vim's source and compile it yourself.   

Step 1: For Debian-like systems, get the required packages:  

```vim
sudo apt-get build-dep vim
```

Step 2: Clone Vim's source code:  

```vim
cd /tmp && git clone https://github.com/vim/vim.git && cd vim
```

Step 3: Configure, Make, Install  

```vim
./configure --with-features=huge --enable-multibyte --enable-python3interp \
    --enable-gui=gtk-2 --prefix=/usr

make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install
```

Step 4: Done! You should have a huge version of vim, with +python3 support. It also has +clipboard support so you can use it with your system clipboard, and a gui version.  

Of course, you can remove configure flags you don't want or add some in. YouCompleteMe actually has a fairly length wiki dedicated to explaining how to build Vim from source <a href="https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source">here</a>  

#### Answer 2 (score 4)
<p><a href="https://github.com/davidhalter/jedi-vim" rel="nofollow">jedi-vim</a> works fine for me now with +python3 support in vim. In added the following option to my .vimrc:
`let g:jedi#force_py_version = 3`.</p>

#### Answer 3 (score 4)
<p><a href="https://github.com/davidhalter/jedi-vim" rel="nofollow">jedi-vim</a> works fine for me now with +python3 support in vim. In added the following option to my .vimrc:
`let g:jedi#force_py_version = 3`.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: What is the difference between the vim snippets plugins? (score [14786](https://stackoverflow.com/q/7466) in 2017)

#### Question
There is a great number of snippets plugins for vim: <a href="https://github.com/SirVer/ultisnips" rel="noreferrer">ultisnips</a>, <a href="https://github.com/msanders/snipmate.vim" rel="noreferrer">snipmate</a>, <a href="https://github.com/drmingdrmer/xptemplate" rel="noreferrer">xptemplate</a>, <a href="https://github.com/Shougo/neosnippet.vim" rel="noreferrer">neosnippet</a> and a lot more.  

They all have pros and cons and more or less dependencies. So far I've been using ultisnips but never been totally satisfied with it.  

As we have a very interesting and complete question about <a href="https://vi.stackexchange.com/q/388/1841">plugin managers</a> I think it would be pretty useful to have the same kind of explanations about snippets plugins.  

There is a listing <a href="http://vim.wikia.com/wiki/Snippet_Plugin_Comparison" rel="noreferrer">here</a> which could be a good start but some complete, clear and precises answers as our community can write would be pretty useful.  

#### Answer 2 (score 22)
<p>I've been using <a href="https://github.com/sirver/UltiSnips" rel="noreferrer">ultisnips</a> for several
weeks now:</p>

I think the main advantages of this plugins are the following:  

<ul>
<li>It is pretty fast even with a great number of snippets available.</li>
<li>The basic syntax to define a new snippet is easy to understand, thus it is
easy to create quickly a new snippet doing what you want to do. (For more
complex snippets some additional work can be required)</li>
<li>It works very well out of the box, a basic configuration allow you do use
snippets very quickly.</li>
<li>It is really configurable. Even if the basic configuration works well, if
you're a power user you can really tune it pretty finely.</li>
</ul>

<hr>

<p>First of all ultisnips is a snippet engine which means that the plugin provides
features to use snippets but doesn't provide the snippets themselves. To get the
snippets, the author recommends to use
<a href="https://github.com/honza/vim-snippets" rel="noreferrer">vim-snippets</a>.</p>

Once you got both plugin installed you'll be able to use your snippets.  

<p>The snippets definition are stored in files named following patterns:
`ft.snippets`, `ft_*.snippets`, or `ft/*`, where `ft` is the 'filetype' of the
current document and `*` is a shell-like wildcard matching any string including
the empty string. <em>(Note that dotted filetype syntax like `cuda.cpp` is
supported)</em></p>

<p>This way snippets specifics to a filetype are expanded only when the buffer's
filetype is set. A special filetype `all` is available to create snippets
expanded on every buffers.</p>

<p>In addition to the snippets provided by vim-snippets, the user can define it's
own snippets. My recommendation would be to place them in the directory
`~/.vim/my-snippets/Ultisnips` this way Ultisnips will find them without
additional configuration and it is easy to maintain them in a dotfile
repository.</p>

<p>To expand the snippets Ultisnips provides a variable `g:UltiSnipsExpandTrigger`
which defines the mapping which will trigger the expansion (I choose
<kbd>**</kbd> which is pretty convenient for me). Note that an integration
should be possible but I didn't tested it by myself).</p>

<p>For power users, Ultisnips also provides some function to customize the behavior
of the expansion, or to trigger it differently. See <a href="https://github.com/SirVer/ultisnips/blob/master/doc/UltiSnips.txt#L271" rel="noreferrer"><code>:h
UltiSnips-trigger-functions</code></a></p>

<hr>

<p>This is the first snippet manager that I really use extensively and I think this
is a good one to begin with for its simplicity out of the box and its
possibility to be tuned.</p>

<p>Finally here is a list of screencast which give a good introduction to the
plugin:</p>

<ul>
<li><a href="http://www.sirver.net/blog/2011/12/30/first-episode-of-ultisnips-screencast/" rel="noreferrer">Episode 1: What are snippets and do I need them?</a></li>
<li><a href="http://www.sirver.net/blog/2012/01/08/second-episode-of-ultisnips-screencast/" rel="noreferrer">Episode 2: Creating Basic Snippets</a></li>
<li><a href="http://www.sirver.net/blog/2012/02/05/third-episode-of-ultisnips-screencast/" rel="noreferrer">Episode 3: What's new in version 2.0</a></li>
<li><a href="http://www.sirver.net/blog/2012/03/31/fourth-episode-of-ultisnips-screencast/" rel="noreferrer">Episode 4: Python Interpolation</a></li>
</ul>

#### Answer 3 (score 12)
I've been using the original <a href="https://github.com/msanders/snipmate.vim" rel="noreferrer">SnipMate</a> since I started using Vim.  

<ul>
<li>It doesn't have external dependencies.</li>
<li>It uses a very simple syntax.</li>
<li>It is very easy to set up.</li>
<li>It has been abandoned since 2009.</li>
</ul>

I have nothing to complain about.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: How can I install 64-bit Vim on Windows? (score [14762](https://stackoverflow.com/q/6097) in 2017)

#### Question
Vim's <a href="http://www.vim.org/download.php#pc">Downloads page</a> says the 64-bit version is discontinued:  

<blockquote>
  <h5>Win64</h3>
  
  <p>The 32-bit version of Vim runs fine on 64-bit windows. There was a
  64-bit binary, but it wasn't used much and maintenance stopped.</p>
</blockquote>

Which is fine, I suppose, except that 32-bit Vim doesn't pick up 64-bit Python. `has('python')`? `0`.  

What are my options for installing 64-bit Vim specifically (including GVim) on Windows, with as much plugin support as possible?  

<hr>

The binary from Cream is also apparently 32-bit (see the <a href="http://sourceforge.net/projects/cream/files/Vim/7.4.1063/gvim-7-4-1063_version.txt/download">`version.txt`</a>). As for Cygwin, I'm not sure about getting GVim running in it (<a href="http://cs.nyu.edu/~yap/prog/cygwin/FAQs.html#gvim">it apparently needs `DISPLAY` set</a>, which would indicate the need for X server, which is yet another complication over the complexity of Cygwin itself).  

I have <a href="http://www.mingw.org/">MinGW</a> installed (and it is rather outdated, admittedly), so I could make some attempt at compiling it myself.  

The Vim Wikia suggests <a href="https://tuxproject.de/projects/vim/x64/">https://tuxproject.de/projects/vim/x64/</a>, which has a rather ominous instruction:  

<blockquote>
  You'll need to copy the appropriate DLL files to your Vim directory to make them work. They're not included.  
</blockquote>

To my Vim directory? Will <a href="https://tuxproject.de">https://tuxproject.de</a>'s build not pick up Python installed elsewhere?  

<hr>

So, I'd like to install 64-bit Vim so that:  

<ul>
<li>it works out-of-the-box with Python installed using the official Python binaries (preferably both 2 and 3, if that's possible, and the latest versions)</li>
<li>it is easy to keep updated</li>
<li>the requirements for having it installed are a minimum (... so a Cygwin installation, if workable, should be minimal)</li>
</ul>

#### Answer accepted (score 14)
I think tuxproject.de is the way to go and I think, it will pick up Python dll, if they are in your path and are also 64bit. The easy way is to copy them to your .vim directory, to make sure vim will find them when trying to load them.  

There is another alternative (and I really hope this will become official). We are trying to build binary Vims as part of the CI testing with appveyor, so that eventually for every patch there will be a corresponding Windows Vim version 32bit and 64bit available. Current snapshots are available <a href="https://ci.appveyor.com/project/k-takata/vim/history" rel="noreferrer">here</a> and <a href="https://github.com/chrisbra/vim/releases" rel="noreferrer">here</a>. Note they are unofficial and not regularly maintained. But I really hope, something like this will be available with the not too far away release of Vim 7.5  

<strong>05.02.2016</strong> We have now un-official (or almost official) binaries in the new repository <a href="https://github.com/vim/vim-win32-installer" rel="noreferrer">vim-win32-installer</a>. Feedback is appreciated.  

#### Answer 2 (score 7)
I was just looking this information up and I only found one x64 version not mentioned by Christian. Here's a summary of the interfaces each version supports today to give you an idea of how well they stay up to date:  

<h5><a href="https://github.com/vim/vim-win32-installer/releases" rel="noreferrer">Nearly Official</a></h1>

<ul>
<li><a href="https://github.com/vim/vim-win32-installer/releases/download/v7.4.1832/gvim_7.4.1832_x86.zip" rel="noreferrer">Vim 7.4.1832</a> and <a href="https://github.com/vim/vim-win32-installer/releases/download/v7.4.1832/gvim_7.4.1832_x64.zip" rel="noreferrer">x64</a></li>
<li>Interfaces: ActivePerl 5.22, ActiveTcl 8.6, LuaBinaries 5.3, Python 2.7, Python 3.4, Racket 6.4, RubyInstaller 2.2</li>
</ul>

<h5><a href="https://tuxproject.de/projects/vim/" rel="noreferrer">TuxProject.de</a></h1>

<ul>
<li><a href="http://tuxproject.de/projects/vim/complete-x86.exe" rel="noreferrer">Vim 7.4.1832</a> and <a href="http://tuxproject.de/projects/vim/complete-x64.exe" rel="noreferrer">x64</a></li>
<li>Interfaces: Perl 5.22.2, Python 2.7.11, Python 3.5.1, Racket 6.4.0.4, Ruby 2.3.0, Lua 5.3.2, Tcl 8.6.4, libXpm. </li>
<li>Python 2.7.11 requires you to rename a registry key when using the x86 builds. </li>
</ul>

<h5><a href="https://bitbucket.org/Alexander-Shukaev/vim-for-windows" rel="noreferrer">Alexander-Shukaev (formerly Haroogan)</a></h1>

<ul>
<li><a href="https://bitbucket.org/Alexander-Shukaev/vim-for-windows/downloads/vim-7.4.417-python-2.7-python-3.4-ruby-2.0.0-lua-5.2-perl-5.18-windows-x86.zip" rel="noreferrer">Vim 7.4.417</a> and <a href="https://bitbucket.org/Alexander-Shukaev/vim-for-windows/downloads/vim-7.4.417-python-2.7-python-3.4-ruby-2.0.0-lua-5.2-perl-5.18-windows-x64.zip" rel="noreferrer">x64</a></li>
<li>Interfaces: python 2.7, python 3.4, ruby 2.0.0, lua 5.2, perl 5.18.</li>
</ul>

#### Answer 3 (score 1)
The other answers really only point you to .zip files or self-extracting archives, not to installers. (TuxProject's "complete-x64.exe" file is a self-extracting archive, not an installer.)  

Here's an easy way to <em>install</em> 64-bit Vim.  

The following steps will install a full 64-bit Vim on Windows, including a working "Edit with Vim" context-menu item in Windows Explorer. I have no idea whether or not Python will work. Try it and see, then <a href="https://vi.stackexchange.com/posts/11826/edit">edit this answer</a> to inform other people.  

<hr>

<h5>To install Vim</h1>

A) Install <a href="https://chocolatey.org/" rel="nofollow noreferrer">Chocolatey</a>, which is a high-level package-management system for Windows. It's kind of like apt-get or yum for Linux, but perhaps not quite as elegant.  

B) Open a command prompt. Make sure to launch it as Administrator.  

C) If you don't have "vcruntime140.dll" installed, or if you're not sure whether or not you have it, install it. You should use the `-y` switch, or else Chocolatey will ask you a lot of questions. Enter this command:  

```vim
choco install vcredist2015 -y
```

D) Install 64-bit Vim:  

```vim
choco install vim-tux -y
```

Chocolatey will install Vim automatically, with no questions asked.  

<h5>To do an upgrade by entering just one command</h1>

Run this:  

```vim
choco upgrade all -y
```

This will make Chocolatey upgrade everything that it's installed. This is automatic, with no questions asked. Please be patient.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: How to open multiple files in split mode? (score [14601](https://stackoverflow.com/q/732) in 2017)

#### Question
I know how to <a href="https://vi.stackexchange.com/questions/64/is-it-possible-to-split-vim-window-to-view-multiple-files-at-once">split windows in vim</a>, but it's possible to open multiple files using vim in split mode (at startup) from the command line?  

In example:  

```vim
vim file1 file2 file3
```

or:  

```vim
vim *.cpp
```

#### Answer accepted (score 38)
You can use the option `-o` to open the files in horizontal splits or `-O` to open vertical splits. The following commands open a window for each file specified:  

```vim
vim -o *.cpp
vim -O foo bar baz
```

You can tell Vim the maximum number of windows to open by putting an integer after `o` or `O` options, the following example will open at most two windows no matter how many file matches, you will see the first two file specified on the command line, the rest will remain hidden:  

```vim
vim -o2 *.cpp
```

See <a href="http://vimhelp.appspot.com/starting.txt.html#-o" rel="noreferrer">`:help -o`</a> for all the details.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Why am I getting a "E488: Trailing characters" error on this custom command? (score [14576](https://stackoverflow.com/q/4689) in 2015)

#### Question
I have a `~/.vimrc` that contains just this:  

```vim
function! NewFile()
        let filename = input("Filename:")
endfunction
command NewFile :call NewFile()<cr>
```

(of course my real `.vimrc` is more complex, but I've recreated this small test case with no plugins etc.)  

My intent is to write a function that supports creating a new file according to a template. Some input items will be asked from the vi user, such as the name of the file.   

The function isn't that sophisticated yet (understatement!) - all it does is ask for the filename. When I use the command `NewFile` from the vi command line, it starts, but then once I enter the filename and hit Enter, I get the error:  

```vim
E488: Trailing characters
```

Why is that? What am I doing wrong?  

#### Answer accepted (score 21)
<p>Remove the trailing `<cr>`
That is only needed for mappings, but not for commands.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: How to share config between vim and Neovim (score [14462](https://stackoverflow.com/q/12794) in 2018)

#### Question
I started using neovim and moved my `.vimrc` to `.config/nvim/init.vim` and other stuff is located in `.local/share/nvim`.  

<p>What is the best way to share configs or even plugins between vim and Neovim?
Symlinks? Can I change the directories in the .vimrc to use only one symlink?</p>

After migrating my vim config to Neovim's default location, this seems to work almost:  

```vim
ln -s ~/.local/share/nvim/site ~/.vim 
ln -s .config/nvim/init.vim .vimrc
```

Some plugins (using using <a href="https://github.com/junegunn/vim-plug" rel="noreferrer">vim-plug</a>) don't seem to work correctly. I can't load custom colorschmes nor vim-airline.  

#### Answer accepted (score 7)
Having your config in Neovim's default location, do the following:  

```vim
mkdir -p ~/.local/share/nvim/site
ln -s ~/.local/share/nvim/site ~/.vim 
ln -s .config/nvim/init.vim .vimrc
```

To fix the colorscheme I <a href="https://stackoverflow.com/a/10778126/859591">had to set to</a> <a href="http://vim.wikia.com/wiki/256_colors_in_vim" rel="noreferrer">256 terminal color mode</a>, i.e. add this to your .vimrc (= init.vim) file, which <a href="https://github.com/neovim/neovim/wiki/FAQ#colors-arent-displayed-correctly" rel="noreferrer">will be ignored by nvim</a>:  

```vim
set t_Co=256  " Note: Neovim ignores t_Co and other terminal codes.
```

To get vim-airline I <a href="https://github.com/vim-airline/vim-airline/wiki/FAQ#vim-airline-doesnt-appear-until-i-create-a-new-split" rel="noreferrer">added the following snippet</a> to .vimrc:  

```vim
set laststatus=2
```

I don't quite understand why this is necessary only in vim and not in Neovim, but I am not <a href="https://github.com/vim-airline/vim-airline/issues/130" rel="noreferrer">the</a> <a href="https://github.com/vim-airline/vim-airline/issues/334" rel="noreferrer">only</a> <a href="https://github.com/vim-airline/vim-airline/issues/20" rel="noreferrer">one</a> stumbling upon this thing.  

#### Answer 2 (score 34)
<p><strong>TL;DR</strong><br />
<br />
You can use your existing `~/.vimrc`, files, and plugins located within `~/.vim` without having to symlink the files.</p>

And this is now documented in NeoVim manual, see <a href="https://neovim.io/doc/user/nvim.html#nvim-from-vim" rel="noreferrer">Transitioning from Vim</a>.  

<hr>

The below lines will add the existing paths and `~/.vimrc` file to your nvim setup.  

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
```

For Linux and macOS, just add the above lines to the top of your `~/.config/nvim/init.vim`, or `%LOCALAPPDATA%\nvim\init.vim` for Windows.  

Credit goes to 👉 <a href="http://vimcasts.org/episodes/meet-neovim/" rel="noreferrer">this</a>  

<p>cheers 🍻<br />
Chris</p>

#### Answer 3 (score 4)
You can use `if has('nvim')`. Here are complete examples:  

<strong>Configuration only for Neovim:</strong>  

```vim
if has('nvim')
        tnoremap <Esc> <C-\><C-n>
endif
```

<strong>Configuration only for Vim</strong>  

```vim
if !has('nvim')
    set ttymouse=xterm2
endif
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: How to join lines without producing a space? (score [14278](https://stackoverflow.com/q/439) in 2015)

#### Question
The standard <kbd>J</kbd> command for joining lines replaces the newline character(s) with a space. It's useful when editing 'literature' but can be troublesome if I, say, edit a hex dump by hand if I forget to remove the superfluous space.  

Is there a quick &amp; easy method to join two lines without producing a space between them?  

#### Answer accepted (score 87)
The `gJ` combination does this; from `:help gJ`:  

<blockquote>
  Join [count] lines, with a minimum of two lines. Don't insert or remove any spaces.   
</blockquote>

You could rebind it to `J`, if you wanted to save a keystroke:  

```vim
:nnoremap J gJ
```

<p>Note that this doesn't <em>remove</em> any spaces, so if either the current line ends
with a space or next line starts with one or more spaces, <em>they will be left as
is</em>.</p>

So:  

```vim
Hello
    world
```

Becomes:  

```vim
Hello    world
```

We <em>could</em> use `Jx` in this case, then it will be `Helloworld`, but that won't work in all cases; from the help:  

<blockquote>
  <p>Join the highlighted lines, with a minimum of two lines.  Remove the indent and insert up to two
  spaces</p>
  
  [...]  
  
  <p>These commands, except "gJ", insert one space in place of the  unless
  there is trailing white space or the next line starts with a ')'.</p>
</blockquote>

<p>So in some cases more than one space or no space is inserted. As far as I can
see, there is no easy way to change this behaviour; I created a function to
modify `gJ` to always join without spaces:</p>

```vim
" Like gJ, but always remove spaces
fun! JoinSpaceless()
    execute 'normal gJ'

    " Character under cursor is whitespace?
    if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
        " When remove it!
        execute 'normal dw'
    endif
endfun

" Map it to a key
nnoremap <Leader>J :call JoinSpaceless()<CR>
```

See also: `:help J`, `:help 'joinspaces'`  

#### Answer 2 (score 8)
Another trick you may try is to use replace. Sometimes this might be useful.  

```vim
%s/$\n//g
```

Scenario: Delete the last character and join with the next line:  

```vim
%s/=$\n\(.\)/\1/g
```

For example,  

```vim
xxxx=
123
```

becomes:  

```vim
xxxx123
```

#### Answer 3 (score 3)
Create a macro and reuse it:  

<kbd>q</kbd><kbd>a</kbd><kbd>J</kbd><kbd>x</kbd><kbd>q</kbd>  

Now replay the macro, `a` by using <kbd>@</kbd><kbd>a</kbd> wherever you want to join two lines with no space.   

<kbd>@</kbd><kbd>@</kbd> will repeat the previous macro. So you can just hold <kbd>@</kbd> to join multiple lines.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: Regex to match any character including newline (score [14103](https://stackoverflow.com/q/13603) in )

#### Question
I frequently find myself trying to do transformations like   

```vim
  author    = {{foo
                bar}},
```

to   

```vim
  author    = {foo
                bar},
```

and I can't find a regex to match the part in between the curly braces.  

```vim
%s/{{\(.*\)}}/{\1}/g
```

doesn't work since `.` does not match newlines. But `[\.\r]` or something doesn't seem to work either. I tried `[\s\S]` as well to match whitespace and non-whitespace, but to no avail.  

#### Answer accepted (score 8)
You should use `\_.\{-}` instead of `.*`.   

`\_.` matches any character including end-of-line. However, as `:h \_.` warns, using it with `*` will match all text to the end of the buffer.  

`\{-}` is similar to `*`, matching 0 or more instances of the proceeding atom. But it matches <strong>as few as possible</strong> instead of as many as possible. This makes `\{-}` safe if your example pattern appears more than once. For example:  

```vim
author = {{foo
           bar}},

editor = {{buz
           baz}},
```

Using `%s/{{\(\_.*\)}}/{\1}/g` changes the starting double brace for author, but the closing double brace for editor. Since `*` matches as many atoms as possible, the pattern matches until the last double brace it finds. This results in the following:  

```vim
author = {foo
           bar}},

editor = {{buz
           baz},
```

However, using `%s/{{\(\_.\{-}\)}}/{\1}/g` gives the desired result for both author and editor as it stops searching at the first double brace it finds:  

```vim
author = {foo
           bar},

editor = {buz
           baz},
```

#### Answer 2 (score 1)
Turns out one must use `\_.*` instead of `.`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: List valid color schemes? (score [13644](https://stackoverflow.com/q/2995) in )

#### Question
I just found out about the `:colorscheme` command. Is there a way that I can get a list of valid color schemes from Vim? I'd like to be able to do this from within Vim, not from a list somewhere on the Internet.  

#### Answer accepted (score 17)
The easiest way is to use <a href="http://vimhelp.appspot.com/cmdline.txt.html#c_CTRL-D">`:help c_Ctrl-d`</a> after `:colorscheme`.  

So, `:colorscheme`<kbd>Ctrl-d</kbd> will output the colorschemes you have available to you.  

#### Answer 2 (score 10)
Another way to show the list is by `set wildmenu`. With this, after `:colorscheme` + `space` + `tab`, a list of completion is displayed and also selectable with arrow key or `Ctrl-N` and `Ctrl-P`. This is not only work on colorscheme, but also on other cmdline completion. The behavior is affected by `wildmode` and better set to the default value `full`.  

#### Answer 3 (score 2)
If you want to do this in Vimscript, you can get a <a href="http://vimhelp.appspot.com/eval.txt.html#List" rel="nofollow noreferrer">List</a> of color schemes by using the getcompletion() function:  

```vim
let c = getcompletion('', 'color')
echo c
```

This is a bit simpler than the existing Vimscript answer, which scans the filesystem.  

See `:help getcompletion()` for more details.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: How to match the first occurence of a repeating pattern on the same line? (score [13388](https://stackoverflow.com/q/4836) in 2015)

#### Question
I'd like to replace the following code:  

```vim
ThisIsALoooongNameOfATwoDArray[100-rowIndex][j-2]-ThisIsALoooongNameOfATwoDArray[100+rowIndex][j+2];
```

by  

```vim
Ptr[j-2]-Ptr[j+2];
```

I tried the command `:%s/This.*ex\]/Ptr/g` (and `/gc` variation), It turns out the regular expression performs the longest matching and the result becomes  

```vim
Ptr[j+2];
```

Is there any simple way to achieve my goal? (I know I can delete it one by one and/or use `q` macro. Just wonder if we can do something using the "restricted" regular expression.)  

#### Answer accepted (score 1)
You can use   

```vim
s/\mThis.\{-}]/Ptr/g
```

`\{-}` will match as few as possible characters before the following character in the regex. This allows to match only the first pair of brackets.  

To be more detailled:  

<ul>
<li>`\m` use magic flavor of regex</li>
<li>`This` match literally the string `This`</li>
<li>`.\{-}]` match as few as possible character before the following `]`. </li>
</ul>

#### Answer 2 (score 1)
A greedy alternative:  

```vim
:%s/This[^]]*ex\]/Ptr/g
```

Where:  

<ul>
<li>`[^]]*` matches anything but `]`

<ul>
<li>`ex\]` matches literally `ex]`</li>
</ul></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: List known filetypes (score [13108](https://stackoverflow.com/q/5780) in 2015)

#### Question
How can I get a list of the names of filetypes that vim currently knows about?  

I want to be able to do this so that when vim doesn't automatically detect a filetype I can try some of the filetypes vim knows about that may be similar and see if they provide reasonable syntax highlighting.  

I know that vimscript files dealing with filetypes are put in the `ftplugin` directory by convention but they don't need to be (I'm not sure, but I don't think the vimscript files in the `ftplugin` directory are special) so I want to just ask vim what filetypes it knows about, regardless of how it learned about them.  

#### Answer accepted (score 63)
<strong>Simple Solution</strong>  

Type `:setfiletype` <em>(with a space afterwards)</em>, then press `Ctrl-d`.  

See `:help cmdline-completion` for more on autocompletion in vim's command line.  

<strong>Complicated Solution</strong>  

This solution uses the `'runtimepath'` option to get all available syntax directories, and then fetches a list of the vimscript files in those directories with their extensions removed.  This may not be the safest way to do it, so improvements are welcome:  

```vim
function! GetFiletypes()
    " Get a list of all the runtime directories by taking the value of that
    " option and splitting it using a comma as the separator.
    let rtps = split(&runtimepath, ",")
    " This will be the list of filetypes that the function returns
    let filetypes = []

    " Loop through each individual item in the list of runtime paths
    for rtp in rtps
        let syntax_dir = rtp . "/syntax"
        " Check to see if there is a syntax directory in this runtimepath.
        if (isdirectory(syntax_dir))
            " Loop through each vimscript file in the syntax directory
            for syntax_file in split(glob(syntax_dir . "/*.vim"), "\n")
                " Add this file to the filetypes list with its everything
                " except its name removed.
                call add(filetypes, fnamemodify(syntax_file, ":t:r"))
            endfor
        endif
    endfor

    " This removes any duplicates and returns the resulting list.
    " NOTE: This might not be the best way to do this, suggestions are welcome.
    return uniq(sort(filetypes))
endfunction
```

You can then use this function in whatever way you want, such as printing all of the values in the list.  You could accomplish that like so:  

```vim
for f in GetFiletypes() | echo f | endfor
```

Note that this probably can be compacted quite a bit, it is just like this for readability.  I won't explain every function and command used here, but here are all the help pages for them:  

<ul>
<li>`:help 'runtimepath'`</li>
<li>`:help :let`</li>
<li>`:help :let-&`</li>
<li>`:help split()`</li>
<li>`:help :for`</li>
<li>`:help expr-.`</li>
<li>`:help :if`</li>
<li>`:help isdirectory()`</li>
<li>`:help glob()`</li>
<li>`:help fnamemodify()`</li>
<li>`:help add()`</li>
<li>`:help uniq()`</li>
<li>`:help sort()`</li>
</ul>

#### Answer 2 (score 18)
If your version of vim is recent enough (v7.4.2011+), you can ask for known filetypes with the function we can now use to help define manual autocompletion: <a href="http://vimhelp.appspot.com/eval.txt.html#getcompletion%28%29" rel="noreferrer">`getcompletion()`</a>  

```vim
:echo getcompletion('', 'filetype')
```

If you want to restrict the list to filetypes starting with a `'c'`, you'd call  

```vim
:echo getcompletion('c', 'filetype')
```

and so on.  

<p>Note: unlike solutions that parse the file names and directory names in `$VIMRUNTIME/{syntax,filetype}/`, this solution analyses `'runtimepath'` as well. 
As far as I understand, it doesn't see new filetypes defined/registered on the fly with `set ft=foobar`, nor after autocommands.</p>

#### Answer 3 (score 3)
You can also print all file types in the terminal by running the following 2 commands:  

1.  

```vim
cd $(vim -e -T dumb --cmd 'exe "set t_cm=\<C-M>"|echo $VIMRUNTIME|quit' | tr -d '\015')
```

2.  

```vim
cat <(ls -1 ftplugin/*.vim) <(ls -1 syntax/*.vim) | tr '\n' '\0' | xargs -0 -n 1 basename | sort | uniq | cut -f 1 -d '.'
```

First command simply navigates to your vim runtime path (for me it was <em>/usr/share/vim/vim80</em>).  

Second command lists all the file type names in the two folders where vim stores the file type definitions.  

<h5>Update</h2>

Suggested improvements to the two commands by muru which offer:  

1.  

```vim
cd $(vim -Nesc '!echo $VIMRUNTIME' -c qa)
```

2.  

```vim
find syntax ftplugin -iname '*.vim' -exec basename -s .vim {} + | sort -u
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: How can I get Vim to show documentation of a C/C++ function? (score [13098](https://stackoverflow.com/q/6228) in 2016)

#### Question
Most editors have a feature like when you press some keys by placing caret over a function, it pops the documentation of that function along with number and type of arguments that function takes.  

I was wondering whether Vim offers such support. For example, while coding in C, I use a built in function `qsort()`. Since I am not sure about type and number of arguments it takes, I would like to know it without escaping Vim. Is it possible?   

#### Answer 2 (score 8)
For C, pressing `K` on the keyword will pull up the built-in manpage directly. For instance, place the cursor on the `printf` keyword:  

```vim
printf("Hello, %s!", foo);
```

Now press `K` (upper case K) and the manpage for `printf` should appear in VIM:  

```vim
NAME
   printf - format and print data

SYNOPSIS
   printf FORMAT [ARGUMENT]...
   printf OPTION

DESCRIPTION
   Print ARGUMENT(s) according to FORMAT, or execute according to OPTION:

   --help display this help and exit

   --version
          output version information and exit

   FORMAT controls the output as in C printf.  Interpreted sequences are:

   \"     double quote
   \\     backslash

   ... It continues for quite a few scrollable pages
```

This seems to work out of the box in all Debian-derived distros that I've tried it on, no specific configuration required.  

#### Answer 3 (score 8)
For C, pressing `K` on the keyword will pull up the built-in manpage directly. For instance, place the cursor on the `printf` keyword:  

```vim
printf("Hello, %s!", foo);
```

Now press `K` (upper case K) and the manpage for `printf` should appear in VIM:  

```vim
NAME
   printf - format and print data

SYNOPSIS
   printf FORMAT [ARGUMENT]...
   printf OPTION

DESCRIPTION
   Print ARGUMENT(s) according to FORMAT, or execute according to OPTION:

   --help display this help and exit

   --version
          output version information and exit

   FORMAT controls the output as in C printf.  Interpreted sequences are:

   \"     double quote
   \\     backslash

   ... It continues for quite a few scrollable pages
```

This seems to work out of the box in all Debian-derived distros that I've tried it on, no specific configuration required.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: How to automatically turn off "hlsearch" after I'm done searching? (score [13021](https://stackoverflow.com/q/8741) in 2016)

#### Question
I love the "hlsearch" setting, but after I'm done searching, I find it obnoxious. Especially if I search for something that has a lot of matches. I know that I can turn this off with   

```vim
:set nohlsearch
```

But this takes a whole 16 keystrokes, and even more annoyingly, I have to turn it back on for my next search with  

```vim
:set hlsearch    
```

Is there a way I can have hlsearch automatically toggle on when I start searching, and off when I am done searching? For example, if I enter insert mode, or modify the text, have hlsearch turn off without any additional keystrokes?  

#### Answer 2 (score 24)
There is a much more convenient way. Rather than using   

```vim
:set nohlsearch
```

which actually turns the hlsearch setting off, use  

```vim
:nohls
```

This will only turn hlsearch off until you search again. From `:help nohls`  

```vim
                 *'hlsearch'* *'hls'* *'nohlsearch'* *'nohls'*
'hlsearch' 'hls'    boolean (default off)
            global
            {not in Vi}
            {not available when compiled without the
            |+extra_search| feature}

    ...

    When you get bored looking at the highlighted matches, you can turn it
    off with |:nohlsearch|.  This does **not change the option value**, as
    soon as you use a search command, the highlighting comes back.
```

However, this solution isn't perfect, since you still have to type out `:nohls` which is pain to do after every search. You can get around this with a mapping, e.g.  

```vim
nnoremap <esc><esc> :silent! nohls<cr>
```

But there is an even <em>better</em> solution! <a href="https://github.com/haya14busa/incsearch.vim">haya14busa/incsearch.vim</a>. This is, at least in my opinion, an <em>essential</em> vim plugin. The main feature is that <strong>all</strong> search matches are highlighted in real time, as you are typing out your regex. For example:  

<a href="https://i.stack.imgur.com/UUHD4.gif"><img src="https://i.stack.imgur.com/UUHD4.gif" alt="enter image description here"></a>  

However, a secondary feature that is also provided is the option to <em>immediately</em> toggle hlsearch on and off when you start/stop searching. To enable this feature, you will have to add  

```vim
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
```

to your `.vimrc`.  

If you have any other `n` mappings, you will have to turn these off. For example, I used to have  

```vim
nnoremap n nzz
nnoremap N Nzz
```

These two mappings are not compatible with eachother!  

#### Answer 3 (score 6)
<a href="https://github.com/romainl/vim-cool" rel="noreferrer">vim-cool</a> is a simple plugin that does just this.  

<blockquote>
  <p>Vim-cool disables search highlighting when you are done searching and
  re-enables it when you search again.</p>
</blockquote>

It works <em>without remapping</em> by <a href="https://github.com/romainl/vim-cool/issues/9" rel="noreferrer">using</a> the <a href="http://vimdoc.sourceforge.net/htmldoc/autocmd.html#CursorMoved" rel="noreferrer">`CursorMoved`</a> and <a href="http://vimdoc.sourceforge.net/htmldoc/autocmd.html#InsertEnter" rel="noreferrer">`InsertEnter`</a> autocommands.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: How to insert a newline without leaving normal mode (score [12974](https://stackoverflow.com/q/3875) in 2019)

#### Question
I wonder if I can insert a new line without leaving normal mode. For example, I have two lines:  

```vim
this is line one
this is line two
```

And the cursor is on line one. Now I want a new line between line one and line two, like this:  

```vim
this is line one

this is line two
```

I know that when I am in normal mode, I can simply press `o`. But this would enter insert mode.   

How can I insert a new line like and stay in normal mode?  

#### Answer accepted (score 9)
I use a mapping for that:  

```vim
" Quickly insert an empty new line without entering insert mode
    nnoremap <Leader>o o<Esc>
    nnoremap <Leader>O O<Esc>
```

This way you can insert a line under your cursor with `<Leader>o` and one on the previous line with `<Leader>O`.   

<strong>Note:</strong> One could argue that it requires as many keystrokes as `o<Esc>` but hopefully you choosed your leader to make this kind of mapping easy. Also I'm really not sure there is a built-in way to do this.  

#### Answer 2 (score 8)
A solution that doesn't go through insert mode, doesn't move the cursor, and allows you to use a counter to append several lines at once (<kbd>3</kbd><kbd>\</kbd><kbd>o</kbd> etc.):  

```vim
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
```

#### Answer 3 (score 4)
I personally recommend using Tim Pope's <a href="https://github.com/tpope/vim-unimpaired" rel="nofollow">Unimpaired plugin</a>. It provides many mappings but the ones you will looking for are `[<space>` and `]<space>` which create blank lines above and below the current line respectively. Unimpaired also provides nice mappings for moving through the quickfix list, buffer list, option toggling, and many others. See `:h unimpaired` for more.  

If you do not want to use unimpaired plugin but like the mappings below are some quick mappings to put in your `~/.vimrc` file:  

```vim
nnoremap <silent> [<space>  :<c-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> ]<space>  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: How can I change the colour of the line highlighted with the 'cursorline' option? (score [12817](https://stackoverflow.com/q/2673) in 2015)

#### Question
I can highlight the current line like this `:set cursorline`, which underlines the current line.  

<img src="https://i.stack.imgur.com/LS4qN.png" alt="enter image description here">  

However I would like to highlight the entire line in a lighter color. How can I achieve this look?  

<img src="https://i.stack.imgur.com/w84R6.png" alt="enter image description here">  

#### Answer accepted (score 17)
According to <a href="http://vimhelp.appspot.com/options.txt.html#%27cursorline%27">`:help cursorline`</a>, the highlight label is `CursorLine`. So you can try:  

```vim
:highlight CursorLine ctermbg=LightBlue
```

See `:help highlight-cterm` for more options.  

Experiment with the colours to see which suits you.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: Use conditional operators AND or OR in an IF statement? (score [12775](https://stackoverflow.com/q/8240) in 2016)

#### Question
This is probably an incredibly simple question, but I did not find any answer so far (I must lack the right sources, and I don't know where to search in vim's help).  

I have a condition and I would like it to include 'AND', like  

```vim
if (condition1 .AND. condition2)
   "do what I want you to do
endif
```

but I couldn't find the syntax. Same thing for 'OR'.  

#### Answer accepted (score 30)
As @lcd047 said in his comment, vimscript use C-like operators `&&` and `||`.  

You can find description of their usage on <a href="http://vimdoc.sourceforge.net/htmldoc/eval.html#expr2">`:h expr2`</a>. Some important points mentioned by the doc are the following  

You'll find that the operators can be concatenated and `&&` takes precedence over `||`, so  

```vim
&nu || &list && &shell == "csh"
```

Is equivalent to  

```vim
&nu || (&list && &shell == "csh")
```

Also once the result is known, the expression "short-circuits", that is, further arguments are not evaluated.  This is like what happens in C.  

If you use:   

```vim
if a || b
```

The expression will be valid even is `b` is not defined.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: Where is xxd in Windows gvim? (score [12746](https://stackoverflow.com/q/9144) in 2016)

#### Question
Does it exist?  Is it Linux only?  Do I have to install it?  

<a href="http://vim.wikia.com/wiki/Improved_hex_editing" rel="nofollow">According to this</a>, it's `:!xxd` to convert the file to hex, and it's `:!xxd -r` to convert it back again.  

#### Answer 2 (score 7)
It is distributed with Vim (as xxd.exe), along with diff.exe.  

So it exists and should work on Windows. You don't need to install anything separately, as it is already bundled with Vim (at least in the versions available from vim.org).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: Swap the position of two windows (score [12523](https://stackoverflow.com/q/3725) in 2015)

#### Question
Say the following is the current structure of my window:  

<pre>
+-----+----------------------------
|     |
|  A  |
|     |
+-----+
|     |
|  B  |
</pre>

The order of A and B is not quite natural. It would be better if B was on top.  

However, if I go `<C-w>K`, B will be the very top of all windows, which is not what I want. How can I put B above A, but not above any other window that is already above A?  

And if two windows are vertically split, how can I change them to horizontally split?  

#### Answer 2 (score 33)
To swap the two parts of a split window simply do: `<C-w> <C-r>`  

#### Answer 3 (score 6)
<p>In order to swap `window` positions, the effect is equivalent to swapping buffers that those two windows show.<br>
e.g. If window A has buffer 2 and window B has buffer 8, you'll want to go to Window A, select buffer 8, then to Window B, select buffer 2.</p>

This idea inspired me to script it - and it's already in my own toolbox as well  

Function Code:  

```vim
function! WinBufSwap()
  let thiswin = winnr()
  let thisbuf = bufnr("%")
  let lastwin = winnr("#")
  let lastbuf = winbufnr(lastwin)

  exec  lastwin . " wincmd w" ."|".
      \ "buffer ". thisbuf ."|".
      \ thiswin ." wincmd w" ."|".
      \ "buffer ". lastbuf
endfunction

command! Wswap :call WinBufSwap()
map <Leader>bs <C-c>:call WinBufSwap()<CR>
```

<ol>
<li>Select window A</li>
<li>Select window B  </li>
<li>`:call WinBufSwap()`<br>
This swaps the buffers in the two pre-selected windows, leaving the cursor in the original window.</li>
</ol>

Selecting the two desired windows to be swapped ahead of time is the key detail, as that is needed to specify for Vim which ones to work with.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Is there a difference between "sudo apt-get vim" and "./configure --with-features=huge"? (score [12436](https://stackoverflow.com/q/4873) in 2015)

#### Question
I'd like to install VIM via apt-get, but I'm not sure if I get all of its features.   

Is there a difference between this, and compiling it from source?  

#### Answer 2 (score 15)
If you look at the options used to build the various packages (in <a href="https://salsa.debian.org/vim-team/vim/blob/debian/sid/debian/rules" rel="nofollow noreferrer">`debian/rules`</a>), you'll see  

```vim
OPTFLAGS+=--with-features=huge

...

NOINTERPFLAGS:=--disable-luainterp
NOINTERPFLAGS+=--disable-mzschemeinterp
NOINTERPFLAGS+=--disable-perlinterp
ifeq ($(DEB_VENDOR),Ubuntu)
    NOINTERPFLAGS+=--enable-pythoninterp --with-python-config-dir=$(shell python-config --configdir)
else
    NOINTERPFLAGS+=--disable-pythoninterp
endif
NOINTERPFLAGS+=--disable-python3interp
NOINTERPFLAGS+=--disable-rubyinterp
NOINTERPFLAGS+=--disable-tclinterp

ALLINTERPFLAGS:=--enable-luainterp
ALLINTERPFLAGS+=--disable-mzschemeinterp
ALLINTERPFLAGS+=--enable-perlinterp
ALLINTERPFLAGS+=--enable-pythoninterp --with-python-config-dir=$(shell python-config --configdir)
ALLINTERPFLAGS+=--disable-python3interp
ALLINTERPFLAGS+=--enable-rubyinterp
ALLINTERPFLAGS+=--enable-tclinterp
ALLINTERPFLAGS+=--with-tclsh=/usr/bin/tclsh

...

CFLAGS_vim-basic:=$(CFLAGS)
CFGFLAGS_vim-basic:=$(CFGFLAGS) $(OPTFLAGS) $(NOXFLAGS) $(NOINTERPFLAGS)

CFLAGS_vim-tiny:=$(CFLAGS) -DTINY_VIMRC
CFGFLAGS_vim-tiny:=$(CFGFLAGS) $(TINYFLAGS)

CFLAGS_vim-gtk:=$(CFLAGS)
CFGFLAGS_vim-gtk:=$(CFGFLAGS) $(OPTFLAGS) $(GUIFLAGS) $(GTKFLAGS) $(ALLINTERPFLAGS)

CFLAGS_vim-gnome:=$(CFLAGS)
CFGFLAGS_vim-gnome:=$(CFGFLAGS) $(OPTFLAGS) $(GUIFLAGS) $(GNOMEFLAGS) $(ALLINTERPFLAGS)

CFLAGS_vim-athena:=$(CFLAGS)
CFGFLAGS_vim-athena:=$(CFGFLAGS) $(OPTFLAGS) $(GUIFLAGS) $(ATHENAFLAGS) $(ALLINTERPFLAGS)

CFLAGS_vim-nox:=$(CFLAGS)
CFGFLAGS_vim-nox:=$(CFGFLAGS) $(OPTFLAGS) $(NOXFLAGS) $(ALLINTERPFLAGS)
```

So:  

<ul>
<li>all packages except `vim-tiny` gets built with `--with-features=huge`</li>
<li>`vim-basic` (aka `vim`) has interpreters turned <em>off</em></li>
<li>the others have options based on frontend, with interpreters turned on.</li>
</ul>

To pick one:  

<ul>
<li>If you'd like a barebones Vim, pick `vim-tiny`.</li>
<li>If you'd like a more full-featured Vim, pick `vim`.</li>
<li>If you'd like all the features that the packaging allows, but <em>don't</em> want GUI (and the dependencies of a GUI), pick `vim-nox`.</li>
<li>If you'd like a GUI, and but don't want anything to do with GTK, pick `vim-athena`.</li>
<li>If you'd like a GUI, <strike>and use a GNOME-based desktop environment (GNOME, Unity, Cinnamon, etc.), pick `vim-gnome`</strike> and use a GTK3-based environment (GNOME, Unity, Cinnamon, MATE, etc.), pick `vim-gtk3`.</li>
<li>If you'd like a GUI, and use a GTK2-based or non-GTK desktop environment (XFCE, LXDE, etc.), pick `vim-gtk`.</li>
</ul>

#### Answer 3 (score 5)
Indeed the version you get with `apt-get install vim` doesn't have all the features of a version compiled with  `--with-features=huge`. For example you don't always have options like `+python` or `+lua`.  

A good alternative is to use `apt-get install vim-nox` which is much more complete.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: Why does vim use hjkl for cursor keys? (score [12352](https://stackoverflow.com/q/9313) in 2017)

#### Question
Why use the keys <kbd>hjkl</kbd> on the same line instead of keys in a triangle like <kbd>wasd</kbd> for moving on video games?  

Why not something equivalent with right hand, like <kbd>ijkl</kbd> or <kbd>pl;'</kbd>?  

#### Answer accepted (score 75)
From <a href="http://www.catonmat.net/blog/why-vim-uses-hjkl-as-arrow-keys/">http://www.catonmat.net/blog/why-vim-uses-hjkl-as-arrow-keys/</a>:  

<blockquote>
  When Bill Joy created the vi text editor he used the ADM-3A terminal, which had the arrows on hjkl keys. Naturally he reused the same keys and the rest is history!  
</blockquote>

<a href="https://i.stack.imgur.com/K4ZfL.jpg"><img src="https://i.stack.imgur.com/K4ZfL.jpg" alt="enter image description here"></a>  

#### Answer 2 (score 21)
<a href="https://vi.stackexchange.com/a/9315/2920">Nobe4's answer</a> is great, and explains why we use `hjkl` very well. However, it's really interesting to see the full keyboard, and a lot of strange things about vim make more sense when you can see the full keyboard it was designed on. For example, why does vi rely so heavily on the `esc` key, when it's in such a weird and uncomfortable place? This is why:  

<a href="https://i.stack.imgur.com/qdO06.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/qdO06.jpg" alt="enter image description here"></a>  

As you can see, `esc` is where tab is on most keyboards. `ctrl` is another key that is slightly awkward to reach, but in a very comfortable location on this keyboard (where caps lock usually is).   

#### Answer 3 (score 17)
As to why these arrows were printed on these keys... it's because they could be used with the control key for local cursor movement. Ctrl-H and Ctrl-J (backspace and line feed) are obvious, and an easy mnemonic even today. Ctrl-K is "vertical tab", but was sometimes used for reverse linefeed on pre-ANSI terminals. The use of Ctrl-L for a non-destructive cursor forward was probably chosen based on its keyboard location.  

You may also have noticed in the picture of the keyboard in the other answer that "HOME" is on the `^`/`~` key. Of course, Ctrl-^ homes the cursor (sends to the top left of the screen, or bottom left, depending on mode).  

These control mappings were also used for Wyse terminals, the Kermit protocol, and were supported in some versions of PC ANSI.SYS.  

Sources:  

<ul>
<li><a href="http://vt100.net/lsi/adm3a-om/" rel="noreferrer">The ADM-3A Operator's Manual</a>, page 3-5 [pdf page 38] onward describes the control functions.</li>
<li><a href="http://invisible-island.net/ncurses/terminfo.src.html" rel="noreferrer">Terminfo database</a> for other terminals; search for `kcuf1=^L` and `kcuu1=^K`</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: How do I use the system clipboard with Vim in Arch Linux? (score [12300](https://stackoverflow.com/q/3076) in 2015)

#### Question
I am using Vim on Arch Linux through urxvt. Since there is no "Ctrl-V" or "Ctrl-Shift-V" support in urxvt, there is no way for me to paste things I have copied from my browser (let's say) into my vim buffer.   

I have `set clipboard=unnamed` in my .vimrc but this seems to have no effect. Pressing "p" only pastes from the vim clipboard and after copying or cutting from vim, nothing gets added to my system clipboard.   

Just in urxvt, I can paste by using middle click on the mouse, which uses the system clipboard, but once I enter vim, even this functionality is replaced by vim's internal clipboard.  

Is there any way to enable copy-paste functionality in my vim setup?  

#### Answer accepted (score 14)
<p>Ok. Apparently on native vim in Arch there is no support for X so the `+clipboard` feature is missing. 
To fix this, install `gvim`, which although conflicts with vim, which was my initial problem with it, retains the exact same functionality if you use </p>

```vim
vim
```

Rather than,   

```vim
gvim
```

You still need to `set clipboard=unnamed`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: How do I copy and paste between two vim instances - shared clipboard? (score [12281](https://stackoverflow.com/q/2015) in )

#### Question
<p>I use gnu `screen` and I run `vim file1.txt` and `vim file2.txt` in two windows. 
How can I copy part of the text from `file1.txt` and paste it to `file2.txt`
without using temporary files or opening two files under the same vim instance?</p>

Basically I would like to yank in first window and paste in second one. I need shared clipboard.  

#### Answer accepted (score 8)
One way is to just copy it to the system clipboard from the first instance, then copy it from the system clipboard in the second instance.  How exactly you would do this depends on your OS and also your vim `clipboard` setting.  

Another option is to use <a href="https://github.com/svermeulen/vim-easyclip" rel="nofollow">vim-easyclip</a> which has the ability to share one clipboard across all vim instances (including sharing a history of yanks as well).  Internally what it does is mirror your clipboard to a temporary file, so it bypasses using your system clipboard entirely.  

#### Answer 2 (score 1)
I usually end up using <a href="https://linux.die.net/man/1/xsel" rel="nofollow noreferrer">xsel</a> to copy to/from the system clipboard:  

```vim
vmap <leader>y !xsel -i -b && xsel -b <CR>
nmap <leader>p :r !xsel -b <CR>
```

#### Answer 3 (score 1)
I usually end up using <a href="https://linux.die.net/man/1/xsel" rel="nofollow noreferrer">xsel</a> to copy to/from the system clipboard:  

```vim
vmap <leader>y !xsel -i -b && xsel -b <CR>
nmap <leader>p :r !xsel -b <CR>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: How do I exit ex input mode? (score [12106](https://stackoverflow.com/q/7701) in )

#### Question
I got stuck in ex input mode by typing `:i`. Now I cannot use any commands. All there is just a string of text. Pressing escape does not get me out of it, typing `:visual` does not get me out of it, and typing `visual` does not get me out of it. How do I get out of it?  

#### Answer 2 (score 16)
`:insert` will keep asking for lines until you type a line only containing `.`. For more help see `:h :i`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Can I justify text in Vim? (score [11909](https://stackoverflow.com/q/509) in 2015)

#### Question
The only reason why I'd ever edit a text file in Pico or Nano, and not in Vim was its "Justify" command <kbd>^J</kbd>. It would reformat a paragraph of text, creating line breaks at word breaks so that the text would float on fixed width screen nicely - format the text to fit predefined 80 columns, creating line breaks only between words. As limited the function was, it was very useful, whether to format lengthy comment blocks, documentation files, or just replacing an endless line of parameters with something more readable.  

Can I do something like that in Vim?  

#### Answer accepted (score 36)
You can use the `gq` or `gw` operators combined with a motion command. By default, it uses the `fmt` program (in Linux) to format the given text. However, to the best of my knowledge, it does not justify the lines so you will get ragged right margins.  

The way I use it is to `gwip` (normal mode) with the cursor on a paragraph. This will format the current paragraph keeping the cursor on the same position. I use it this way to make sure that only the current paragraph is formatted. When editing a text file, issuing `gwG` (normal mode) at the begining of the file will format the whole text. As a good practice, be sure to leave at least one blank line between paragraphs.  

There is a lot of configuration that can be done. To begin with, here are some relevant help: `:h gq`, `:h gw`, `:h fo` (format options), `:h fp` (format program), `:h fo-table` (an explanation of the possible options).  

#### Answer 2 (score 15)
There is a great VimCast on this topic.  

<a href="http://vimcasts.org/episodes/formatting-text-with-par/">http://vimcasts.org/episodes/formatting-text-with-par/</a>  

Basically, you need to install `par`:  

```vim
$ brew install par
# or
$ sudo apt-get install par
```

And then, since you want columns to be wrapped in 80 columns:  

```vim
:set formatprg=par\ -w80
```

Now you can use the `gq` operator, like in other answers (e.g. `gqip`), and it will use Par instead of Vim's built-in formatter.  

Par is quite advanced, and it will format comments like this nicely:  

```vim
/* This is a long */
/* multiline comment */
```

#### Answer 3 (score 11)
From `:help usr_25`:  

```vim
JUSTIFYING TEXT                                                                 

Vim has no built-in way of justifying text.  However, there is a neat macro     
package that does the job.  To use this package, execute the following          
command:                                                                        

        :runtime macros/justify.vim                                             

This Vim script file defines a new visual command "_j".  To justify a block of  
text, highlight the text in Visual mode and then execute "_j".
```

So, all you have to do is run  

```vim
:ru macros/justify.vim
```

and then type  

```vim
_j
```

to justify the text in the entire file.  

(Of course, you could also add `ru macros/justify.vim` to your .vimrc so you don't have to type it every time.)  

<strong>Note</strong>: this does <em>not</em> add line breaks for you. You have to add those manually with `gq`. For this you must also set the `textwidth` (default is 0) to your desired value via  

```vim
set textwidth=80
```

and—if you want—automatic text wrapping by setting the `t`-flag via  

```vim
set formatoptions+=t
```

If you want, you can set a mapping in your .vimrc to do the entire thing for you:  

```vim
nnoremap <C-j> gggqG_j
```

This moves to the beginning of the file (`gg`), wraps all the lines (`gq` until `G`), and then `_j`ustifies the text.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Vim -p: Caught deadly signal SEGV? (score [11863](https://stackoverflow.com/q/1889) in 2015)

#### Question
I get this problem when I start Vim with `-p` option. Suppose, I started out with  

```vim
vim -p first.txt second.txt
```

Then after editing `first.txt` I move to `second.txt` using `gt`. I press the keys `gg` and `G` again. This produces the error   

```vim
Vim: Caught deadly signal SEGV
```

From this point, Vim doesn't respond to any signal including <kbd>Ctrl</kbd> <kbd>D</kbd>. I can close this session only by killing the terminal.   

This problem arises only when I invoke Vim with `-p` option. If I open `first.txt` first and then use `:tabe` to open `second.txt`, this problem doesn't arise.   

Any ideas why this might occur?  

<hr>

Output of `vim --version`:  

```vim
VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Jan  2 2014 19:40:46)
Included patches: 1-52
Modified by pkg-vim-maintainers@lists.alioth.debian.org
Compiled by buildd@
Huge version with GTK2-GNOME GUI.  Features included (+) or not (-):
+acl             +farsi           +mouse_netterm   +syntax
+arabic          +file_in_path    +mouse_sgr       +tag_binary
+autocmd         +find_in_path    -mouse_sysmouse  +tag_old_static
+balloon_eval    +float           +mouse_urxvt     -tag_any_white
+browse          +folding         +mouse_xterm     +tcl
++builtin_terms  -footer          +multi_byte      +terminfo
+byte_offset     +fork()          +multi_lang      +termresponse
+cindent         +gettext         -mzscheme        +textobjects
+clientserver    -hangul_input    +netbeans_intg   +title
+clipboard       +iconv           +path_extra      +toolbar
+cmdline_compl   +insert_expand   +perl            +user_commands
+cmdline_hist    +jumplist        +persistent_undo +vertsplit
+cmdline_info    +keymap          +postscript      +virtualedit
+comments        +langmap         +printer         +visual
+conceal         +libcall         +profile         +visualextra
+cryptv          +linebreak       +python          +viminfo
+cscope          +lispindent      -python3         +vreplace
+cursorbind      +listcmds        +quickfix        +wildignore
+cursorshape     +localmap        +reltime         +wildmenu
+dialog_con_gui  +lua             +rightleft       +windows
+diff            +menu            +ruby            +writebackup
+digraphs        +mksession       +scrollbind      +X11
+dnd             +modify_fname    +signs           -xfontset
-ebcdic          +mouse           +smartindent     +xim
+emacs_tags      +mouseshape      -sniff           +xsmp_interact
+eval            +mouse_dec       +startuptime     +xterm_clipboard
+ex_extra        +mouse_gpm       +statusline      -xterm_save
+extra_search    -mouse_jsbterm   -sun_workshop    +xpm
   system vimrc file: "$VIM/vimrc"
     user vimrc file: "$HOME/.vimrc"
 2nd user vimrc file: "~/.vim/vimrc"
      user exrc file: "$HOME/.exrc"
  system gvimrc file: "$VIM/gvimrc"
    user gvimrc file: "$HOME/.gvimrc"
2nd user gvimrc file: "~/.vim/gvimrc"
    system menu file: "$VIMRUNTIME/menu.vim"
  fall-back for $VIM: "/usr/share/vim"
Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H -DFEAT_GUI_GTK  -pthread -I/usr/include/gtk-2.0 -I/usr/lib/i386-linux-gnu/gtk-2.0/include -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/pango-1.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/freetype2 -I/usr/include/glib-2.0 -I/usr/lib/i386-linux-gnu/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/libpng12 -I/usr/include/harfbuzz   -pthread -DORBIT2=1 -D_REENTRANT -I/usr/include/libgnomeui-2.0 -I/usr/include/libart-2.0 -I/usr/include/gconf/2 -I/usr/include/gnome-keyring-1 -I/usr/include/libgnome-2.0 -I/usr/include/libbonoboui-2.0 -I/usr/include/libgnomecanvas-2.0 -I/usr/include/gtk-2.0 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/gnome-vfs-2.0 -I/usr/lib/i386-linux-gnu/gnome-vfs-2.0/include -I/usr/include/dbus-1.0 -I/usr/lib/i386-linux-gnu/dbus-1.0/include -I/usr/include/glib-2.0 -I/usr/lib/i386-linux-gnu/glib-2.0/include -I/usr/include/orbit-2.0 -I/usr/include/libbonobo-2.0 -I/usr/include/bonobo-activation-2.0 -I/usr/include/libxml2 -I/usr/include/pango-1.0 -I/usr/include/gail-1.0 -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/atk-1.0 -I/usr/lib/i386-linux-gnu/gtk-2.0/include -I/usr/include/cairo -I/usr/include/gio-unix-2.0/ -I/usr/include/pixman-1 -I/usr/include/libpng12     -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1     -I/usr/include/tcl8.6  -D_REENTRANT=1  -D_THREAD_SAFE=1  -D_LARGEFILE64_SOURCE=1  
Linking: gcc   -L. -Wl,-Bsymbolic-functions -Wl,-z,relro -rdynamic -Wl,-export-dynamic -Wl,-E  -Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,--as-needed -o vim   -lgtk-x11-2.0 -lgdk-x11-2.0 -latk-1.0 -lgio-2.0 -lpangoft2-1.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lcairo -lpango-1.0 -lfontconfig -lgobject-2.0 -lglib-2.0 -lfreetype     -lgnomeui-2 -lSM -lICE -lbonoboui-2 -lgnomevfs-2 -lgnomecanvas-2 -lgnome-2 -lpopt -lbonobo-2 -lbonobo-activation -lORBit-2 -lart_lgpl_2 -lgtk-x11-2.0 -lgdk-x11-2.0 -latk-1.0 -lgio-2.0 -lpangoft2-1.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lcairo -lpango-1.0 -lfontconfig -lfreetype -lgconf-2 -lgthread-2.0 -lgmodule-2.0 -lgobject-2.0 -lglib-2.0   -lSM -lICE -lXpm -lXt -lX11 -lXdmcp -lSM -lICE  -lm -ltinfo -lnsl  -lselinux  -lacl -lattr -lgpm -ldl  -L/usr/lib -llua5.2 -Wl,-E  -fstack-protector -L/usr/local/lib  -L/usr/lib/perl/5.18/CORE -lperl -ldl -lm -lpthread -lcrypt -L/usr/lib/python2.7/config-i386-linux-gnu -lpython2.7 -lpthread -ldl -lutil -lm -Xlinker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions  -L/usr/lib/i386-linux-gnu -ltcl8.6 -ldl -lz -lpthread -lieee -lm -lruby-1.9.1 -lpthread -lrt -ldl -lcrypt -lm  -L/usr/lib   
```

Output of `uname -a`:  

```vim
Linux nitish 3.13.0-45-generic #74-Ubuntu SMP Tue Jan 13 19:37:48 UTC 2015 i686 i686 i686 GNU/Linux
```

Based on comments by @Carpetsmoker, I found out that the problem is because of my `.vimrc` file. So I checked ran the problem causing command with some portions of the `.vimrc` file commented. Finally I found out that the problem is with the line  

```vim
set columns=1000
```

How can so innocent command cause this problem? `:help columns` didn't give any useful information regarding this.  

#### Answer 2 (score 6)
The SEGV signal, also known as a segfault, is almost always due to a bug in the program you're running—in this case, vim. (Other causes are things like defective hardware, or once in a blue moon, kernel bugs).  

So, really, you need to report a bug. <a href="http://vimhelp.appspot.com/intro.txt.html#bug-reports">`:help bug-reports`</a> provides instructions on how to report a bug. It sounds like you've already got a minimal set of steps to reproduce the problem, so that's most of the work there. You should probably test a newer version of Vim first though, just to make sure it hasn't already been fixed.  

#### Answer 3 (score 3)
If your vim crashes because of <a href="https://en.wikipedia.org/wiki/Segmentation_fault" rel="nofollow noreferrer">segmentation fault</a>, that indicates memory access violation which is caused either by software bug or hardware issues.  

If this happens repeatedly, you should do in order:  

<ol>
<li>Disable plugins by running: `vim -u NONE` and see if that helps.</li>
<li>Upgrade your vim to the latest stable version.</li>
<li>Upgrade your vim to the latest development version.</li>
<li>Optionally double check the same vim version on different machine (maybe it's caused by hardware issues). </li>
<li>Try to run `vim` under debugger, e.g.: `gdb vim` and check for the backtrace (after SEGV, in `gdb`: type `bt` or `bt full`).</li>
<li>If the backtrace doesn't have symbols, you've to recompile your vim to include these.</li>
<li>If you've complete backtrace, please check for similar issues or report a new bug in <a href="https://github.com/vim/vim/issues" rel="nofollow noreferrer">vim's bug tracker</a> (for plain vim) or check for `:help bugs`. If you've different version of vim (like gVim, MacVim, NeoVim), please report it to the right maintainers.</li>
</ol>

</section>

<script src="../Css/js_prism_vim.js"></script>
