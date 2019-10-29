---
title: Windows <- StackOverflow top 100
category: windows
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How do I install pip on Windows? (score [2887828](https://stackoverflow.com/q/4750806) in 2017)

#### Question
<a href="https://pip.pypa.io/en/stable/" rel="noreferrer">`pip`</a> is a replacement for <a href="http://setuptools.readthedocs.io/en/latest/easy_install.html" rel="noreferrer">`easy_install`</a>. But should I install `pip` using `easy_install` on Windows?  Is there a better way?  

#### Answer accepted (score 1779)
<h5>Python 2.7.9+ and 3.4+</h2>

Good news! <a href="https://docs.python.org/3/whatsnew/3.4.html" rel="noreferrer">Python 3.4</a> (released March 2014) and <a href="https://docs.python.org/2/whatsnew/2.7.html#pep-477-backport-ensurepip-pep-453-to-python-2-7" rel="noreferrer">Python 2.7.9</a> (released December 2014) ship with Pip. This is the best feature of any Python release. It makes the community's wealth of libraries accessible to everyone. Newbies are no longer excluded from using community libraries by the prohibitive difficulty of setup. In shipping with a package manager, Python joins <a href="http://en.wikipedia.org/wiki/Ruby_%28programming_language%29" rel="noreferrer">Ruby</a>, <a href="http://en.wikipedia.org/wiki/Node.js" rel="noreferrer">Node.js</a>, <a href="http://en.wikipedia.org/wiki/Haskell_%28programming_language%29" rel="noreferrer">Haskell</a>, <a href="http://en.wikipedia.org/wiki/Perl" rel="noreferrer">Perl</a>, <a href="http://en.wikipedia.org/wiki/Go_%28programming_language%29" rel="noreferrer">Go</a>&mdash;almost every other contemporary language with a majority open-source community. Thank you, Python.  

If you do find that pip is not available when using Python 3.4+ or Python 2.7.9+, simply execute e.g.:  

```sh
py -3 -m ensurepip
```

Of course, that doesn't mean Python packaging is problem solved. The experience remains frustrating. I discuss this <a href="https://stackoverflow.com/questions/2436731/does-python-have-a-package-module-management-system/13445719#13445719">in the Stack Overflow question <em>Does Python have a package/module management system?</em></a>.  

And, alas for everyone using Python 2.7.8 or earlier (a sizable portion of the community). There's no plan to ship Pip to you. Manual instructions follow.  

<h5>Python 2 ≤ 2.7.8 and Python 3 ≤ 3.3</h2>

Flying in the face of its <a href="http://www.python.org/about/" rel="noreferrer">'batteries included'</a> motto, Python ships without a package manager. To make matters worse, Pip was&mdash;until recently&mdash;ironically difficult to install.  

<h5>Official instructions</h3>

Per <a href="https://pip.pypa.io/en/stable/installing/#do-i-need-to-install-pip" rel="noreferrer">https://pip.pypa.io/en/stable/installing/#do-i-need-to-install-pip</a>:  

Download <a href="https://bootstrap.pypa.io/get-pip.py" rel="noreferrer">`get-pip.py`</a>, being careful to save it as a `.py` file rather than `.txt`. Then, run it from the command prompt:  

```sh
python get-pip.py
```

You possibly need an administrator command prompt to do this. Follow <em><a href="http://technet.microsoft.com/en-us/library/cc947813(v=ws.10).aspx" rel="noreferrer">Start a Command Prompt as an Administrator</a></em> (Microsoft TechNet).  

This installs the pip package, which (in Windows) contains ...\Scripts\pip.exe that path must be in PATH environment variable to use pip from the command line (see the second part of 'Alternative Instructions' for adding it to your PATH,  

<h5>Alternative instructions</h3>

The official documentation tells users to install Pip and each of its dependencies from source. That's tedious for the experienced and prohibitively difficult for newbies.  

For our sake, Christoph Gohlke prepares Windows installers (`.msi`) for popular Python packages. He builds installers for all Python versions, both 32 and 64 bit. You need to:  

<ol>
<li><a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/#setuptools" rel="noreferrer">Install setuptools</a></li>
<li><a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/#pip" rel="noreferrer">Install pip</a></li>
</ol>

For me, this installed Pip at `C:\Python27\Scripts\pip.exe`. Find `pip.exe` on your computer, then add its folder (for example, `C:\Python27\Scripts`) to your path (Start / Edit environment variables). Now you should be able to run `pip` from the command line. Try installing a package:  

```sh
pip install httpie
```

There you go (hopefully)! Solutions for common problems are given below:  

<h5>Proxy problems</h3>

If you work in an office, you might be behind an HTTP proxy. If so, set the environment variables <a href="http://docs.python.org/2/library/urllib.html" rel="noreferrer">`http_proxy` and `https_proxy`</a>. Most Python applications (and other free software) respect these. Example syntax:  

```sh
http://proxy_url:port
http://username:password@proxy_url:port
```

If you're really unlucky, your proxy might be a Microsoft <a href="https://en.wikipedia.org/wiki/NT_LAN_Manager" rel="noreferrer">NTLM</a> proxy. Free software can't cope. The only solution is to install a free software friendly proxy that forwards to the nasty proxy. <a href="http://cntlm.sourceforge.net/" rel="noreferrer">http://cntlm.sourceforge.net/</a>  

<h5>Unable to find vcvarsall.bat</h3>

Python modules can be partly written in C or C++. Pip tries to compile from source. If you don't have a C/C++ compiler installed and configured, you'll see this cryptic error message.  

<blockquote>
  Error: Unable to find vcvarsall.bat  
</blockquote>

You can fix that by <a href="https://stackoverflow.com/questions/2817869/error-unable-to-find-vcvarsall-bat">installing a C++ compiler</a> such as <a href="http://en.wikipedia.org/wiki/MinGW" rel="noreferrer">MinGW</a> or <a href="http://en.wikipedia.org/wiki/Visual_C%2B%2B#32-bit_versions" rel="noreferrer">Visual C++</a>. Microsoft actually ships one specifically for use with Python. Or try <em><a href="http://aka.ms/vcpython27" rel="noreferrer">Microsoft Visual C++ Compiler for Python 2.7</a></em>.  

Often though it's easier to check <a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/" rel="noreferrer">Christoph's site</a> for your package.  

#### Answer 2 (score 296)
<p><s>-- <strong>Outdated</strong> -- use distribute, not setuptools as described here. --</s><br>
-- <strong>Outdated #2</strong> -- use setuptools as distribute is deprecated.</p>

As you mentioned pip doesn't include an independent installer, but you can install it with its predecessor easy_install.  

So:  

<ol>
<li>Download the last pip version from here: <a href="http://pypi.python.org/pypi/pip#downloads" rel="noreferrer">http://pypi.python.org/pypi/pip#downloads</a></li>
<li>Uncompress it</li>
<li>Download the last easy installer for Windows: (<strong>download the .exe at the bottom of <a href="http://pypi.python.org/pypi/setuptools" rel="noreferrer">http://pypi.python.org/pypi/setuptools</a></strong> ). Install it.</li>
<li>copy the uncompressed pip folder <strong>content</strong> into `C:\Python2x\` folder (don't copy the whole folder into it, just the content), because python command doesn't work outside `C:\Python2x` folder and then run:  `python setup.py install`</li>
<li>Add your python `C:\Python2x\Scripts` to the path</li>
</ol>

You are done.   

Now you can use `pip install package` to easily install packages as in Linux :)  

#### Answer 3 (score 215)
<strong>2014 UPDATE:</strong>  

1) If you have installed Python 3.4 or later, pip is included with Python and should already be working on your system.  

2) If you are running a version below Python 3.4 or if pip was not installed with Python 3.4 for some reason, then you'd probably use pip's official installation script `get-pip.py`. The pip installer now grabs setuptools for you, and works regardless of architecture (32-bit or 64-bit).  

The installation <a href="http://www.pip-installer.org/en/latest/installing.html" rel="noreferrer">instructions are detailed here</a> and involve:  

<blockquote>
  To install or upgrade pip, securely download <a href="https://raw.github.com/pypa/pip/master/contrib/get-pip.py" rel="noreferrer">get-pip.py</a>.  
  
  Then run the following (which may require administrator access):  
</blockquote>

```sh
python get-pip.py
```

<blockquote>
  To upgrade an existing setuptools (or distribute), run `pip install -U setuptools`  
</blockquote>

I'll leave the two sets of old instructions below for posterity.  

<strong>OLD Answers:</strong>  

For Windows editions of the <strong>64 bit</strong> variety - 64-bit Windows + Python used to require a separate installation method due to ez_setup, but I've tested the new distribute method on 64-bit Windows running 32-bit Python and 64-bit Python, and you can now use the same method for all versions of Windows/Python 2.7X:  

<strong>OLD Method 2</strong> using <a href="https://pypi.python.org/pypi/distribute" rel="noreferrer">distribute</a>:  

<ol>
<li>Download <a href="http://python-distribute.org/distribute_setup.py" rel="noreferrer">distribute</a> - I threw mine in `C:\Python27\Scripts` (feel free to create a `Scripts` directory if it doesn't exist.</li>
<li>Open up a command prompt (on Windows you should check out <a href="http://code.google.com/p/conemu-maximus5/" rel="noreferrer">conemu2</a> if you don't use <a href="http://en.wikipedia.org/wiki/Windows_PowerShell" rel="noreferrer">PowerShell</a>) and change (`cd`) to the directory you've downloaded `distribute_setup.py` to.</li>
<li>Run distribute_setup: `python distribute_setup.py` (This will not work if your python installation directory is not added to your path - <a href="https://stackoverflow.com/a/6318188/705198">go here for help</a>)</li>
<li>Change the current directory to the `Scripts` directory for your Python installation (`C:\Python27\Scripts`) or add that directory, as well as the Python base installation directory to your %PATH% environment variable.</li>
<li>Install pip using the newly installed setuptools: `easy_install pip`</li>
</ol>

The last step will not work unless you're either in the directory `easy_install.exe` is located in (C:\Python27\Scripts would be the default for Python 2.7), or you have that directory added to your path.  

<strong>OLD Method 1</strong> using ez_setup:  

<a href="http://pypi.python.org/pypi/setuptools#windows" rel="noreferrer">from the setuptools page</a> --  

<blockquote>
  Download <a href="http://peak.telecommunity.com/dist/ez_setup.py" rel="noreferrer">ez_setup.py</a> and run it; it will download the appropriate .egg file and install it for you. (Currently, the provided .exe installer does not support 64-bit versions of Python for Windows, due to a distutils installer compatibility issue.  
</blockquote>

After this, you may continue with:  

<ol start="2">
<li>Add `c:\Python2x\Scripts` to the Windows path (replace the `x` in `Python2x` with the actual version number you have installed)</li>
<li>Open a new (!) DOS prompt. From there run `easy_install pip`</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How can you find out which process is listening on a port on Windows? (score [2827167](https://stackoverflow.com/q/48198) in 2016)

#### Question
How can you find out which process is listening on a port on Windows?  

#### Answer accepted (score 2266)
<h5>PowerShell</h1>

```sh
Get-Process -Id (Get-NetTCPConnection -LocalPort portNumber).OwningProcess
```

<h5>cmd</h1>

```sh
 C:\> netstat -a -b
```

(Add <strong>-n</strong> to stop it trying to resolve hostnames, which will make it a lot faster.)  

Note Dane's recommendation for <a href="http://technet.microsoft.com/en-us/sysinternals/bb897437.aspx" rel="noreferrer">TCPView</a>. It looks very useful!  

<strong>-a</strong>  Displays all connections and listening ports.  

<strong>-b</strong>  Displays the executable involved in creating each connection or listening port. In some cases well-known executables host multiple independent components, and in these cases the sequence of components involved in creating the connection        or listening port is displayed. In this case the executable name is in [] at the bottom, on top is the component it called, and so forth until TCP/IP was reached. Note that this option can be time-consuming and will fail unless you have sufficient permissions.  

<strong>-n</strong>  Displays addresses and port numbers in numerical form.  

<strong>-o</strong>  Displays the owning process ID associated with each connection.  

#### Answer 2 (score 2016)
There's a native GUI for Windows:  

<ul>
<li><em>Start>>All Programs>>Accessories>>System Tools>>Resource Monitor</em></li>
</ul>

<p>or <strong>Run</strong> `resmon.exe`, 
or from <strong>TaskManager</strong> performance tab</p>

<img src="https://i.stack.imgur.com/I2UzJ.png" alt="enter image description here">  

#### Answer 3 (score 214)
Use <a href="http://technet.microsoft.com/en-us/sysinternals/bb897437.aspx" rel="noreferrer">TCPView</a> if you want a GUI for this.  It's the old Sysinternals app that Microsoft bought out.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How do I shutdown, restart, or log off Windows via a bat file? (score [2377843](https://stackoverflow.com/q/162304) in 2018)

#### Question
I've been using <a href="https://en.wikipedia.org/wiki/Remote_Desktop_Services#Remote_Desktop_Connection" rel="noreferrer">Remote Desktop Connection</a> to get into a workstation. But in this environment, I cannot use the power options in Start Menu. I need an alternative way to shutdown or restart.  

How do I control my computer's power state through the command line?  

#### Answer accepted (score 1156)
The most common ways to use the <a href="https://ss64.com/nt/shutdown.html" rel="noreferrer">`shutdown`</a> command are:  

<ul>
<li>`shutdown -s` — Shuts down.</li>
<li>`shutdown -r` — Restarts.</li>
<li>`shutdown -l` — Logs off.</li>
<li><p>`shutdown -h` — Hibernates.</p>

<strong>Note:</strong> There is a common pitfall wherein users think `-h` means "help" (which it does for every other command-line program... except `shutdown.exe`, where it means "hibernate"). They then run `shutdown -h` and accidentally turn off their computers. Watch out for that.  </li>
<li><p>`shutdown -i` — "Interactive mode". Instead of performing an action, it displays a GUI dialog.</p></li>
<li>`shutdown -a` — Aborts a previous shutdown command.</li>
</ul>

The commands above can be combined with these additional options:  

<ul>
<li>`-f` — Forces programs to exit. Prevents the shutdown process from getting stuck.</li>
<li>`-t &lt;seconds&gt;` — Sets the time until shutdown. Use `-t 0` to shutdown immediately.</li>
<li>`-c &lt;message&gt;` — Adds a shutdown message. The message will end up in the Event Log.</li>
<li><p>`-y` — Forces a "yes" answer to all shutdown queries.</p>

<strong>Note:</strong> This option is not documented in any official documentation. It was discovered by <a href="https://stackoverflow.com/questions/46071009/what-exactly-does-shutdown-y-do">these StackOverflow users</a>.  </li>
</ul>

<hr>

I want to make sure some other really good answers are also mentioned along with this one. Here they are in no particular order.  

<ul>
<li><a href="https://stackoverflow.com/questions/162304/how-do-i-shutdown-restart-logoff-via-bat-file#162342">The `-f` option</a> from <a href="https://stackoverflow.com/users/672/kogus">JosephStyons</a></li>
<li><a href="https://stackoverflow.com/questions/162304/how-do-i-shutdown-restart-logoff-via-bat-file#162398">Using `rundll32`</a> from <a href="https://stackoverflow.com/users/6309/vonc">VonC</a></li>
<li><a href="https://stackoverflow.com/questions/162304/how-do-i-shutdown-restart-logoff-via-bat-file#162428">The Run box</a>  from <a href="https://stackoverflow.com/users/14966/dean">Dean</a></li>
<li><a href="https://stackoverflow.com/questions/162304/how-do-i-shutdown-restart-logoff-windows-via-bat-file#416830">Remote shutdown</a> from <a href="https://stackoverflow.com/users/18511/kip">Kip</a></li>
</ul>

#### Answer 2 (score 374)
If you are on a remote machine, you may also want to add the -f option to <strong>force</strong> the reboot.  Otherwise your session may close and a stubborn app can hang the system.  

I use this whenever I want to force an immediate reboot:  

```sh
shutdown -t 0 -r -f
```

For a more friendly "give them some time" option, you can use this:  

```sh
shutdown -t 30 -r
```

As you can see in the comments, the -f is implied by the timeout.  

<a href="http://www.proffs.nu/brutus.htm" rel="noreferrer">Brutus 2006 is a utility that provides a GUI for these options.</a>  

#### Answer 3 (score 81)
No one has mentioned `-m` option for remote shutdown:  

```sh
shutdown -r -f -m \\machinename
```

Also:  

<ul>
<li>The `-r` parameter causes a reboot (which is usually what you want on a remote machine, since physically starting it might be difficult).</li>
<li>The `-f` parameter option forces the reboot.</li>
<li>You must have appropriate privileges to shut down the remote machine, of course.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How to run a PowerShell script (score [1638604](https://stackoverflow.com/q/2035193) in 2018)

#### Question
How do I run a PowerShell script?  

<ul>
<li>I have a script named myscript.ps1</li>
<li>I have all the necessary frameworks installed</li>
<li>I set that <a href="https://stackoverflow.com/questions/10635/why-dont-my-powershell-scripts-run">execution policy</a> thing</li>
<li>I have followed the instructions on <a href="http://technet.microsoft.com/en-us/library/ee176949.aspx" rel="noreferrer">this MSDN help page</a>
and am trying to run it like so:
`powershell.exe 'C:\my_path\yada_yada\run_import_script.ps1'` (with or without `--noexit`)</li>
</ul>

which returns exactly nothing, except that the file name is output.  

No error, no message, nothing. Oh, when I add `-noexit`, the same thing happens, but I remain within PowerShell and have to exit manually.  

The .ps1 file is supposed to run a program and return the error level dependent on that program's output. But I'm quite sure I'm not even getting there yet.  

What am I doing wrong?  

#### Answer accepted (score 683)
<ol>
<li>Launch Windows PowerShell, and wait a moment for the `PS` command prompt to appear</li>
<li><p>Navigate to the directory where the script lives</p>

```sh
PS> cd C:\my_path\yada_yada\ (enter)
```</li>
<li><p>Execute the script:</p>

```sh
PS> .\run_import_script.ps1 (enter)
```</li>
</ol>

What am I missing??  

Or: you can run the PowerShell script from `cmd.exe` like this:  

```sh
powershell -noexit "& ""C:\my_path\yada_yada\run_import_script.ps1""" (enter)
```

according to this <a href="http://poshoholic.com/2007/09/27/invoking-a-powershell-script-from-cmdexe-or-start-run/" rel="nofollow noreferrer">blog post here</a>  

Or you could even run your PowerShell script from your C# application :-)  

<a href="http://www.codeproject.com/KB/threads/AsyncPowerShell.aspx" rel="nofollow noreferrer">Asynchronously execute PowerShell scripts from your C# application</a>  

#### Answer 2 (score 206)
If you are on PowerShell 2.0, use PowerShell.exe's `-File` parameter to invoke a script from another environment, like cmd.exe. For example:  

```sh
Powershell.exe -File C:\my_path\yada_yada\run_import_script.ps1
```

#### Answer 3 (score 168)
If you want to run a script without modifying the default script execution policy, you can use the <em>bypass</em> switch when launching <strong>Windows PowerShell</strong>.    

```sh
powershell [-noexit] -executionpolicy bypass -File <Filename>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Text editor to open big (giant, huge, large) text files (score [1537932](https://stackoverflow.com/q/159521) in 2010)

#### Question
I mean 100+ MB big; such text files can push the envelope of editors.  

I need to look through a large XML file, but cannot if the editor is buggy.  

Any suggestions?  

#### Answer accepted (score 1312)
<strong><a href="https://code.visualstudio.com/" rel="noreferrer">VS Code</a></strong> (Windows, macOS, Linux) - Free and Open Source with a nice GUI. Edited a 3.6 GB JSON file, loaded in a minute. You must have enough RAM to load the files.   

Free read-only viewers:  

<ul>
<li><a href="https://glogg.bonnefon.org/description.html" rel="noreferrer"><strong>glogg</strong></a> (Windows, macOS, Linux) – Confirmed to handle multi-GB files. Its main feature is regular expression search. Has tabs, reads files directly from disk, can watch/follow files, and allows user to mark lines.</li>
<li><a href="https://github.com/zarunbal/LogExpert" rel="noreferrer"><strong>LogExpert</strong></a> (Windows) – "A GUI replacement for `tail`." Supports file following, searching, filtering, configurable highlighting, plugins, and external tools.</li>
<li><a href="https://web.archive.org/web/20140908181354fw_/http://swiftgear.com/ltfviewer/features.html" rel="noreferrer"><strong>Large Text File Viewer</strong></a> (Windows) – Minimalist and has very small executable size. Supports split view, text theme customization, regex search, and file following.</li>
<li><a href="https://www.ghisler.com/lister/" rel="noreferrer"><strong>Lister</strong></a> (Windows) – Even more small and minimalist. It's one executable, barely 500 KB, but it still supports searching (with regexes), printing, a hex editor mode, and settings.</li>
</ul>

Free editors:  

<ul>
<li><strong>Vim</strong> and <strong>Emacs</strong> (Windows, macOS, Linux) – Classic Unix editors. Steep learning curve, but brutally efficient. They have settings that can be tuned to make them even faster.</li>
<li><a href="https://www.liquid-technologies.com/large-file-editor" rel="noreferrer"><strong>Large File Editor</strong></a> (Windows) – Opens and edits TB+ files, supports Unicode, uses little memory, has XML-specific features, and includes a binary mode.</li>
<li><a href="https://mh-nexus.de/en/hxd/" rel="noreferrer"><strong>HxD</strong></a> (Windows) – A hex editor, not a text editor; but it's amazingly fast and useful.</li>
<li><a href="http://www.heliwave.com/GigaEdit.html" rel="noreferrer"><strong>GigaEdit</strong></a> (Windows) – Supports searching, character statistics, and font customization. But it's buggy – with large files, it only allows overwriting characters, not inserting them; it doesn't respect LF as a line terminator, only CRLF; and it's slow.</li>
</ul>

Builtin programs (no installation required):  

<ul>
<li><a href="https://en.wikipedia.org/wiki/Less_(Unix)" rel="noreferrer"><strong>less</strong></a> (macOS, Linux) – The traditional Unix command-line pager tool. Lets you view text files of practically any size. Can be installed on Windows, too.</li>
<li><a href="https://en.wikipedia.org/wiki/Microsoft_Notepad" rel="noreferrer"><strong>Notepad</strong></a> (Windows) – Decent with large files, especially with word wrap turned off.</li>
<li><a href="https://ss64.com/nt/more.html" rel="noreferrer"><strong>MORE</strong></a> (Windows) – This refers to the Windows `MORE`, not the Unix `more`. A console program that allows you to view a file, one screen at a time.</li>
</ul>

Web viewers:  

<ul>
<li><a href="https://htmlpen.com" rel="noreferrer"><strong>htmlpen.com</strong></a> – Can open and syntax-highlight TB+ files. Allows editing, except for very large files. Supports searching, regexes, and exporting.</li>
<li><a href="https://www.readfileonline.com/" rel="noreferrer"><strong>readfileonline.com</strong></a> – Another HTML5 large file viewer. Supports search.</li>
</ul>

Paid editors:  

<ul>
<li><a href="https://www.sweetscape.com/010editor/" rel="noreferrer"><strong>010 Editor</strong></a> (Windows, macOS, Linux) – Opens giant (as much as 50 GB) files.</li>
<li><a href="https://www.slickedit.com/products/slickedit" rel="noreferrer"><strong>SlickEdit</strong></a> (Windows, macOS, Linux) – Opens large files.</li>
<li><a href="https://www.ultraedit.com/" rel="noreferrer"><strong>UltraEdit</strong></a> (Windows, macOS, Linux) – Opens files of more than 6 GB, but the configuration must be changed for this to be practical: Menu » Advanced » Configuration » File Handling » Temporary Files » Open file without temp file...</li>
<li><a href="https://www.emeditor.com/" rel="noreferrer"><strong>EmEditor</strong></a> (Windows) – Handles very large text files nicely (officially up to 248 GB, but as much as 900 GB according to one report).</li>
</ul>

And finally, have you tried opening the large file with your regular editor? Some editors can actually handle reasonably large files. In particular, <a href="https://notepad-plus-plus.org/" rel="noreferrer"><strong>Notepad++</strong></a> (Windows) and <a href="https://www.sublimetext.com/" rel="noreferrer"><strong>Sublime Text</strong></a> (Windows, macOS, Linux) support files in the 2 GB range.  

#### Answer 2 (score 184)
<h5>Tips and tricks</h1>

<h5>less</h2>

Why are you using <em>editors</em> to just <em>look</em> at a (large) file?  

Under *nix or <a href="http://en.wikipedia.org/wiki/Cygwin" rel="noreferrer">Cygwin</a>, just use <a href="http://linux.die.net/man/1/less" rel="noreferrer">less</a>. (There is a famous saying – "less is more, more or less" – because "less" replaced the earlier Unix command "more", with the addition that you could scroll back up.) Searching and navigating under less is very similar to Vim, but there is no swap file and little RAM used.  

There is a Win32 port of GNU less. See the "less" section of the answer above.  

<h5>Perl</h2>

Perl is good for quick scripts, and its `..` (range flip-flop) operator makes for a nice selection mechanism to limit the crud you have to wade through.  

For example:  

```sh
$ perl -n -e 'print if ( 1000000 .. 2000000)' humongo.txt | less
```

This will extract everything from line 1 million to line 2 million, and allow you to sift the output manually in less.  

Another example:  

```sh
$ perl -n -e 'print if ( /regex one/ .. /regex two/)' humongo.txt | less
```

This starts printing when the "regular expression one" finds something, and stops when the "regular expression two" find the end of an interesting block. It may find multiple blocks. Sift the output...  

<h5>logparser</h2>

This is another useful tool you can use. To quote <a href="https://en.wikipedia.org/wiki/Logparser" rel="noreferrer">the Wikipedia article</a>:  

<blockquote>
  <strong>logparser</strong> is a flexible command line utility that was initially written by Gabriele Giuseppini, a Microsoft employee, to automate tests for IIS logging. It was intended for use with the Windows operating system, and was included with the IIS 6.0 Resource Kit Tools. The default behavior of logparser works like a "data processing pipeline", by taking an SQL expression on the command line, and outputting the lines containing matches for the SQL expression.  
  
  Microsoft describes Logparser as a powerful, versatile tool that provides universal query access to text-based data such as log files, XML files and CSV files, as well as key data sources on the Windows operating system such as the Event Log, the Registry, the file system, and Active Directory. The results of the input query can be custom-formatted in text based output, or they can be persisted to more specialty targets like SQL, SYSLOG, or a chart.  
</blockquote>

Example usage:  

```sh
C:\>logparser.exe -i:textline -o:tsv "select Index, Text from 'c:\path\to\file.log' where line > 1000 and line < 2000"
C:\>logparser.exe -i:textline -o:tsv "select Index, Text from 'c:\path\to\file.log' where line like '%pattern%'"
```

<h5>The relativity of sizes</h2>

100 MB isn't too big. 3 GB is getting kind of big. I used to work at a print &amp; mail facility that created about 2% of U.S. first class mail. One of the systems for which I was the tech lead accounted for about 15+% of the pieces of mail. We had some big files to debug here and there.  

<h5>And more...</h2>

Feel free to add more tools and information here. This answer is community wiki for a reason! We all need more advice on dealing with large amounts of data...  

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: Can't start Eclipse - Java was started but returned exit code=13 (score [1496556](https://stackoverflow.com/q/11461607) in 2019)

#### Question
I am trying to get my first taste of Android development using Eclipse. I ran into this problem when trying to run Eclipse, having installed version 4.2 only minutes ago.  

After first trying to start `Eclipse` without any parameters to specify the Java VM, I got an error message saying it `couldn't find a Java VM called javaw.exe inside the Eclipse folder`, so I found where Java was installed and specified that location as the parameter in the shortcut's target. Now I get a different error, `Java was started but returned exit code=13`.  

Similar questions seem to indicate that it's a 32-bit/64-bit conflict, but I'm 99% positive that I downloaded 64-bit versions of both Eclipse and `Java (RE 7u5)`, which I chose because I have 64-bit Windows 7.   

<ul>
<li>If anyone knows how to confirm that my Eclipse and Java are 64-bit,
that'd be appreciated.</li>
<li>If you think my problem is a different one, please help!</li>
<li>Please speak as plainly as you can, as I am totally new to Eclipse
and Java.</li>
</ul>

<blockquote>
  Shortcut Target: "C:\Program Files\Eclipse-SDK-4.2-win32-x86_64\eclipse\eclipse.exe" -vm "C:\Program Files (x86)\Java\jre7\bin\javaw.exe"  
</blockquote>

<strong>Full error code...:</strong>  

```sh
Java was started but returned exit code=13
C:\Program Files (x86)\Java\jre7\bin\javaw.exe
-Xms40m
-Xmx512m
-XX:MaxPermSize=256m
-jar C:\Program Files\Eclipse-SDK-4.2-win32-x86_64\eclipse\\plugins/org.eclipse.equinox.launcher_1.30v20120522-1813.jar
-os win32
-ws win32
-arch x86_64
-showsplash C:\Program Files\Eclipse-SDK-4.2-win32-x86_64\eclipse\\plugins\org.eclipse.platform_4.2.0.v201206081400\splash.bmp
-launcher C:\Program Files\Eclipse-SDK-4.2-win32-x86_64\eclipse\eclipse.exe
-name Eclipse
--launcher.library C:\Program Files\Eclipse-SDK-4.2-win32-x86_64\eclipse\\plugins/org.eclipse.equinox.launcher.win32.win32.x86_64_1.1.200.v201205221813\eclipse_1503.dll
-startup C:\Program Files\Eclipse-SDK-4.2-win32-x86_64\eclipse\\plugins/org.eclipse.equinox.launcher_1.30v20120522-1813.jar
--launcher.overrideVmargs
-exitdata 1e30_5c
-vm C:\Program Files (x86)\Java\jre7\bin\javaw.exe
-vmargs
-Xms40m
-Xmx512m
-XX:MaxPermSize=256m
-jar C:\Program Files\Eclipse-SDK-4.2-win32-x86_64\eclipse\\plugins/org.eclipse.equinox.launcher_1.30v20120522-1813.jar
```

#### Answer accepted (score 186)
There are working combinations of OS, JDK and Eclipse bitness. In my case, I was using a 64-bit JDK with a 32-bit Eclipse on a 64-bit OS. After downgrading the JDK to 32-bit, Eclipse started working.  

<strong>Kindly use one of the following combinations.</strong>  

<ul>
<li>32-bit OS, 32-bit JDK, 32-bit Eclipse (32-bit only)</li>
<li>64-bit OS, 32-bit JDK, 32-bit Eclipse</li>
<li>64-bit OS, 64-bit JDK, 64-bit Eclipse (64-bit only)</li>
</ul>

#### Answer 2 (score 726)
<p>Your version of Eclipse is 64-bit, based on the paths and filenames.
However, the version of Java that it's picking up is 32-bit, as indicated by where it is coming from, on this line:</p>

```sh
-vm C:\Program Files (x86)\Java\jre7\bin\javaw.exe
```

`Program Files (x86)` is the folder where 64-bit Windows places <strong>32-bit</strong> programs.  

`Program Files` is the folder where 64-bit Windows places <strong>64-bit</strong> programs.  

This can happen when a system has more than one JVM installed, as is often the case on Windows 64-bit (for example, the JRE download page uses the bit-ness of the browser to determine what bit-ness download to offer you, and many people use(d) 32-bit browsers even though they run 64-bit Windows).  

The best way to fix this, assuming you do in fact have 64-bit JRE or JDK on your system, is to specify in `eclipse.ini` exactly which JVM you want it to use. The instructions are detailed in <a href="https://wiki.eclipse.org/Eclipse.ini" rel="noreferrer">the Eclipse wiki page</a>, but basically you have to specify the `-vm` option in the ini file - make sure to read the wiki page carefully as the format is very specific.  

Specifying the JVM path in `eclipse.ini` is strongly recommended because doing so isolates Eclipse from any potential changes to your system `PATH` that some program installers might make (I'm talking to you, Oracle!).  

Another option would be to download and use 32-bit Eclipse instead of 64-bit, but it's still strongly recommended to specify the path to the JVM in `eclipse.ini`.  

<hr>

<em>Left for historical reference</em>:  

To check your version of Java, run   

<pre>
  java -version 
</pre>

in a console (command prompt). On Windows 7 with 64-bit Java 6 I get:  

<pre>
  java version "1.6.0_27"
  Java(TM) SE Runtime Environment (build 1.6.0_27-b07)
  Java HotSpot(TM) 64-Bit Server VM (build 20.2-b06, mixed mode)
</pre>

Note the 3rd line, which shows that this is a 64-bit version.   

On a 32-bit version you'll get something like:  

<pre>
  Java HotSpot(TM) Client VM (build 20.1-b02, mixed mode, sharing) 
</pre>

#### Answer 3 (score 243)
I got this error and found that my PATH variable (on Windows) was probably changed. First in my PATH was this entry:  

```sh
C:\ProgramData\Oracle\Java\javapath
```

...and Eclipse ran `"C:\ProgramData\Oracle\Java\javapath\javaw"` - which gave the error. I suspect that this is something that came along with an installation of Java 8.  

I have several Java versions installed (6,7 and 8), so I removed that entry from the PATH and tried to restart Eclipse again, which worked fine.  

If it's doesn't work for you, you'll need to upgrade your JDK (to the Java versions - 8 in this case).   

<a href="https://java.com/en/download/help/path.xml" rel="noreferrer">Instructions on how to edit PATH variable</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: Adding directory to PATH Environment Variable in Windows (score [1421264](https://stackoverflow.com/q/9546324) in 2018)

#### Question
I am trying to add `C:\xampp\php` to my system `PATH` environment variable in Windows.  

I have already added it using the Environment Variables dialog box.  

But when I type into my console:  

```sh
C:\>path
```

it doesn't show the new `C:\xampp\php` directory:  

```sh
PATH=D:\Program Files\Autodesk\Maya2008\bin;C:\Ruby192\bin;C:\WINDOWS\system32;C:\WINDOWS;
C:\WINDOWS\System32\Wbem;C:\PROGRA~1\DISKEE~2\DISKEE~1\;c:\Program Files\Microsoft SQL
Server\90\Tools\binn\;C:\Program Files\QuickTime\QTSystem\;D:\Program Files\TortoiseSVN\bin
;D:\Program Files\Bazaar;C:\Program Files\Android\android-sdk\tools;D:\Program Files\
Microsoft Visual Studio\Common\Tools\WinNT;D:\Program Files\Microsoft Visual Studio\Common
\MSDev98\Bin;D:\Program Files\Microsoft Visual Studio\Common\Tools;D:\Program Files\
Microsoft Visual Studio\VC98\bin
```

I have two questions:  

<ol>
<li>Why did this happen? Is there something I did wrong?</li>
<li>Also, how do I add directories to my `PATH` variable using the console (and programmatically, with a batch file)?</li>
</ol>

#### Answer accepted (score 132)
This only modifies the registry.  An existing process won't use these values. A new process will do so if it is started <em>after</em> this change <em>and</em> doesn't inherit the old environment from its parent.  

You didn't specify how you started the console session.  Best way to ensure this is to exit the command shell and run it again. It should then inherit the updated PATH.  

#### Answer 2 (score 914)
<h5>Option 1</h1>

After you change `PATH` with the GUI, close and re-open the console window.  

This works because only programs started after the change will see the new `PATH`.  

<h5>Option 2</h1>

Execute this command in the command window you have open:  

```sh
set PATH=%PATH%;C:\your\path\here\
```

This command appends `C:\your\path\here\` to the current `PATH`.  

Breaking it down:  

<ul>
<li><a href="https://ss64.com/nt/set.html" rel="noreferrer">`set`</a> – A command that changes cmd's environment variables <em>only for the current cmd session</em>; other programs and the system are unaffected.</li>
<li>`PATH=` – Signifies that `PATH` is the environment variable to be temporarily changed.</li>
<li>`%PATH%;C:\your\path\here\` – The `%PATH%` part expands to the current value of `PATH`, and `;C:\your\path\here\` is then concatenated to it. This becomes the new `PATH`.</li>
</ul>

#### Answer 3 (score 190)
<blockquote>
  <strong>WARNING:</strong> This solution <strong>may be destructive</strong> to your PATH, and the stability of your system. As a side effect, it will merge your user and system PATH, and truncate PATH to 1024 characters. The effect of this command is irreversible. Make a backup of PATH first. See the comments for more information.  
  
  Don't blindly copy-and-paste this. Use with caution.  
</blockquote>

You can <strong>permanently</strong> add a path to `PATH` with the <a href="https://ss64.com/nt/setx.html" rel="noreferrer">`setx`</a> command:  

```sh
setx /M path "%path%;C:\your\path\here\"
```

Remove the `/M` flag if you want to set the user `PATH` instead of the system `PATH`.  

Notes:  

<ul>
<li>The `setx` command is only available in Windows 7 and later.</li>
<li><p>You should run this command from an elevated command prompt.</p></li>
<li><p>If you only want to change it for the current session, use <a href="http://ss64.com/nt/set.html" rel="noreferrer">set</a>.</p></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: Failed to load the JNI shared Library (JDK) (score [1418728](https://stackoverflow.com/q/7352493) in 2017)

#### Question
When I try opening <a href="http://www.eclipse.org/">Eclipse</a>, a pop-up dialog states:  

<blockquote>
  Failed to load the JNI shared library "C:/JDK/bin/client/jvm.dll"`.  
</blockquote>

Following this, Eclipse force closes.  

Here's a few points I'd like to make:    

<ul>
<li>I checked to see if anything exists at that path. It does exist.  </li>
<li>My Eclipse and <a href="http://www.oracle.com/technetwork/java/javase/overview/index.html">Java SE Development Kit</a> are both 64-bit. I checked my system, and it can handle 64-bit.  </li>
<li>I've searched for this problem on Google and on Stack&nbsp;Overflow, and the only answer I found was to download the 32-bit versions of JDK and Eclipse.</li>
</ul>

<p>Downloading the 32-bit versions is something I only want to do as a very last resort.<br>
What would be suggested to solve this issue?</p>

#### Answer accepted (score 835)
You need a `64-bit` trio:   

<ul>
<li>`64-bit` <strong>OS</strong></li>
<li>`64-bit` <strong>Java</strong> </li>
<li>`64-bit` <strong>Eclipse</strong></li>
</ul>

#### Answer 2 (score 307)
<h5>Working pairings of OS, JDK and Eclipse:</h1>

<hr>

<ul>
<li>`32-bit` <strong>OS</strong> | `32-bit` <strong>JDK</strong> | `32-bit` <strong>Eclipse</strong> (<strong><em>32-bit only</em></strong>)</li>
<li>`64-bit` <strong>OS</strong> | `32-bit` <strong>JDK</strong>  | `32-bit` <strong>Eclipse</strong> </li>
<li>`64-bit` <strong>OS</strong> |  `64-bit JDK` | `64bit`  <strong>Eclipse</strong> (<strong><em>64-bit only</em></strong>)</li>
</ul>

<hr>

I had several JDKs and JREs installed.  

Each of them had their own entry in the PATH variable, all was working more or less.  

Judging from the PATH variables, some installations were completely useless, since they were never used. Of course, the "inactive" Javas could be referenced manually from within Eclipse if I needed, but I never did that, so I really did not need them. (At least I thought so at that time...)  

I cleaned up the mess, deinstalled all current Java's, installed only JDK + JRE 1.7 64-bit.   

One of the Eclipse 'installations' failed afterwards with the `Failed to Load the JNI shared Library` and a given path relative to the fresh installed JDK where it thought the `jvm.dll` to be.  

<strong><em>The failing Eclipse was the only one of all my IDEs that was still a 32-bit version on my otherwise all-64-bit setup.</em></strong>  

Adding VM arguments, like so often mentioned, in the `eclipse.ini` was no use in my case (because I had only the wrong JDK/JRE to relate to.)  

I was also unable to find out how to check if this Eclipse was a 32-bit or 64-bit version (I could not look it up in the <a href="http://en.wikipedia.org/wiki/Windows_Task_Manager" rel="nofollow noreferrer">Task Manager</a>, since this Eclipse 'installation' would not start up. And since it had been a while since I had set it up, I could not remember its version either.)  

In case you use a newer JDK and a older <a href="http://en.wikipedia.org/wiki/Java_Virtual_Machine#Execution_environment" rel="nofollow noreferrer">JRE</a> you might be in for trouble, too, but then it is more likely a `java.lang.UnsupportedClassVersionError` appears, <a href="http://en.wiktionary.org/wiki/IIRC" rel="nofollow noreferrer">IIRC</a>.  

#### Answer 3 (score 261)
Make sure your `eclipse.ini` file includes the following lines.  

```sh
-vm
C:\path\to\64bit\java\bin\javaw.exe
```

My <strong>`eclipse.ini`</strong> for example:  

```sh
-startup
plugins/org.eclipse.equinox.launcher_1.1.1.R36x_v20101122_1400.jar
--launcher.library
plugins/org.eclipse.equinox.launcher.win32.win32.x86_64_1.1.2.R36x_v20101222
-product
org.eclipse.epp.package.java.product
--launcher.defaultAction
openFile
--launcher.XXMaxPermSize
256M
-showsplash
org.eclipse.platform
-vm
C:\Program Files\Java\jdk1.6.0_32\bin\javaw.exe
--launcher.XXMaxPermSize
256m
--launcher.defaultAction
openFile
-vmargs
-Dosgi.requiredJavaVersion=1.5
-Xms40m
-Xmx512m
```

Use OS and Eclipse both 64 bit or both 32 bit keep same and config <strong>`eclipse.ini`</strong>.  

Your `eclipse.ini` file <strong>can be found in your eclipse folder</strong>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: How do I get current date/time on the Windows command line in a suitable format for usage in a file/folder name? (score [1301764](https://stackoverflow.com/q/203090) in 2019)

#### Question
Update: Now that it's 2016 I'd use PowerShell for this unless there's a really compelling backwards-compatible reason for it, particularly because of the regional settings issue with using `date`. See @npocmaka's <a href="https://stackoverflow.com/a/19799236/8479">https://stackoverflow.com/a/19799236/8479</a>  

<hr>

What's a Windows command line statement(s) I can use to get the current datetime in a format that I can put into a filename?  

I want to have a .bat file that zips up a directory into an archive with the current date and time as part of the name, for example, `Code_2008-10-14_2257.zip`. Is there any easy way I can do this, independent of the regional settings of the machine?  

I don't really mind about the date format, ideally it'd be yyyy-mm-dd, but anything simple is fine.  

So far I've got this, which on my machine gives me `Tue_10_14_2008_230050_91`:  

```sh
rem Get the datetime in a format that can go in a filename.
set _my_datetime=%date%_%time%
set _my_datetime=%_my_datetime: =_%
set _my_datetime=%_my_datetime::=%
set _my_datetime=%_my_datetime:/=_%
set _my_datetime=%_my_datetime:.=_%

rem Now use the timestamp by in a new ZIP file name.
"d:\Program Files\7-Zip\7z.exe" a -r Code_%_my_datetime%.zip Code
```

I can live with this, but it seems a bit clunky. Ideally it'd be briefer and have the format mentioned earlier.  

I'm using Windows Server 2003 and Windows&nbsp;XP Professional. I don't want to install additional utilities to achieve this (although I realise there are some that will do nice date formatting).  

#### Answer accepted (score 649)
See <em><a href="http://www.tech-recipes.com/rx/956/windows-batch-file-bat-to-get-current-date-in-mmddyyyy-format/" rel="noreferrer">Windows Batch File (.bat) to get current date in MMDDYYYY format</a></em>:  

```sh
@echo off
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
echo %mydate%_%mytime%
```

If you prefer the time in 24 hour/military format, you can replace the second FOR line with this:  

```sh
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a%%b)
```

<blockquote>
  <p>C:> .\date.bat <br />
  2008-10-14_0642</p>
</blockquote>

If you want the date independently of the region day/month order, you can use "WMIC os GET LocalDateTime" as a source, since it's in ISO order:  

```sh
@echo off
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2% %ldt:~8,2%:%ldt:~10,2%:%ldt:~12,6%
echo Local date is [%ldt%]
```

<blockquote>
  <p>C:>test.cmd<br />
  Local date is [2012-06-19 10:23:47.048]</p>
</blockquote>

#### Answer 2 (score 105)
<h5>Regionally independent date time parsing</h3>

The output format of `%DATE%` and of the `dir` command is regionally dependent and thus neither robust nor smart. <a href="http://sourceforge.net/projects/unxutils/files/" rel="noreferrer">date.exe</a> (part of <a href="http://en.wikipedia.org/wiki/UnxUtils" rel="noreferrer">UnxUtils</a>) delivers any date and time information in any thinkable format. You may also extract the date/time information from any file with `date.exe`.  

<h5>Examples:  (in a cmd-script use %% instead of %)</h3>

<p>`date.exe +"%Y-%m-%d"`<br>
2009-12-22  </p>

<p>`date.exe +"%T"`<br>
18:55:03  </p>

<p>`date.exe +"%Y%m%d %H%M%S: Any text"`<br>
20091222 185503: Any text</p>

<p>`date.exe +"Text: %y/%m/%d-any text-%H.%M"`<br>
Text: 09/12/22-any text-18.55</p>

<p>`Command: date.exe +"%m-%d """%H %M %S """"`<br>
07-22 "18:55:03"`</p>

<p>The date/time information from a reference file:<br>
`date.exe -r c:\file.txt +"The timestamp of file.txt is: %Y-%m-%d %H:%M:%S"`</p>

Using it in a CMD script to get year, month, day, time information:  

```sh
for /f "tokens=1,2,3,4,5,6* delims=," %%i in ('C:\Tools\etc\date.exe +"%%y,%%m,%%d,%%H,%%M,%%S"') do set yy=%%i& set mo=%%j& set dd=%%k& set hh=%%l& set mm=%%m& set ss=%%n
```

Using it in a CMD script to get a timestamp in any required format:  

```sh
for /f "tokens=*" %%i in ('C:\Tools\etc\date.exe +"%%y-%%m-%%d %%H:%%M:%%S"') do set timestamp=%%i
```

Extracting the date/time information from any reference file.  

```sh
for /f "tokens=1,2,3,4,5,6* delims=," %%i in ('C:\Tools\etc\date.exe -r file.txt +"%%y,%%m,%%d,%%H,%%M,%%S"') do set yy=%%i& set mo=%%j& set dd=%%k& set hh=%%l& set mm=%%m& set ss=%%n
```

Adding to a file its date/time information:  

```sh
for /f "tokens=*" %%i in ('C:\Tools\etc\date.exe -r file.txt +"%%y-%%m-%%d.%%H%%M%%S"') do ren file.txt file.%%i.txt
```

date.exe is <a href="http://sourceforge.net/projects/unxutils/files/" rel="noreferrer">part of the free GNU tools</a> which need no installation.  

NOTE: Copying `date.exe` into any directory which is in the search path may cause other scripts to fail that use the Windows built-in `date` command.  

#### Answer 3 (score 91)
Two more ways that do not depend on the time settings (both taken from <a href="http://www.dostips.com/forum/viewtopic.php?f=3&amp;t=4555" rel="noreferrer">:How get data/time independent from localization:</a>). And both also get the day of the week and none of them requires admin permissions!:  

<ol>
<li><p><strong>MAKECAB</strong> - will work on EVERY Windows system (fast, but creates a small temp file) (the foxidrive script):</p>

```sh
@echo off
pushd "%temp%"
makecab /D RptFileName=~.rpt /D InfFileName=~.inf /f nul >nul
for /f "tokens=3-7" %%a in ('find /i "makecab"^<~.rpt') do (
   set "current-date=%%e-%%b-%%c"
   set "current-time=%%d"
   set "weekday=%%a"
)
del ~.*
popd
echo %weekday% %current-date% %current-time%
pause
```

<a href="http://ss64.com/ps/get-date.html" rel="noreferrer">More information about get-date function</a>.  </li>
<li><p><strong>ROBOCOPY</strong> - it's not native command for Windows&nbsp;XP and Windows Server 2003, but it can be <a href="http://www.microsoft.com/en-us/download/details.aspx?id=17657" rel="noreferrer">downloaded from microsoft site</a>. But is built-in in everything from Windows&nbsp;Vista and above:</p>

```sh
@echo off
setlocal
for /f "skip=8 tokens=2,3,4,5,6,7,8 delims=: " %%D in ('robocopy /l * \ \ /ns /nc /ndl /nfl /np /njh /XF * /XD *') do (
 set "dow=%%D"
 set "month=%%E"
 set "day=%%F"
 set "HH=%%G"
 set "MM=%%H"
 set "SS=%%I"
 set "year=%%J"
)

echo Day of the week: %dow%
echo Day of the month : %day%
echo Month : %month%
echo hour : %HH%
echo minutes : %MM%
echo seconds : %SS%
echo year : %year%
endlocal
```

And three more ways that uses other Windows script languages. They will give you more flexibility e.g. you can get week of the year, time in milliseconds and so on.  </li>
<li><p><strong>JScript/batch</strong> hybrid (need to be saved as `.bat`). JScript is available on every system form NT and above, as a part of <a href="http://en.wikipedia.org/wiki/Windows_Script_Host" rel="noreferrer">Windows Script Host</a> (<a href="http://technet.microsoft.com/en-us/library/ee198684.aspx" rel="noreferrer">though can be disabled through the registry it's a rare case</a>):</p>

```sh
@if (@X)==(@Y) @end /* ---Harmless hybrid line that begins a JScript comment

@echo off
cscript //E:JScript //nologo "%~f0"
exit /b 0
*------------------------------------------------------------------------------*/

function GetCurrentDate() {
        // Today date time which will used to set as default date.
        var todayDate = new Date();
        todayDate = todayDate.getFullYear() + "-" +
                       ("0" + (todayDate.getMonth() + 1)).slice(-2) + "-" +
                       ("0" + todayDate.getDate()).slice(-2) + " " + ("0" + todayDate.getHours()).slice(-2) + ":" +
                       ("0" + todayDate.getMinutes()).slice(-2);

        return todayDate;
    }

WScript.Echo(GetCurrentDate());
```</li>
<li><p><strong>VSCRIPT/BATCH</strong> hybrid (<em><a href="https://stackoverflow.com/questions/9074476/is-it-possible-to-embed-and-execute-vbscript-within-a-batch-file-without-using-a">Is it possible to embed and execute VBScript within a batch file without using a temporary file?</a></em>) same case as JScript, but hybridization is not so perfect:</p>

```sh
:sub echo(str) :end sub
echo off
'>nul 2>&1|| copy /Y %windir%\System32\doskey.exe %windir%\System32\'.exe >nul
'& echo current date:
'& cscript /nologo /E:vbscript "%~f0"
'& exit /b

'0 = vbGeneralDate - Default. Returns date: mm/dd/yy and time if specified: hh:mm:ss PM/AM.
'1 = vbLongDate - Returns date: weekday, monthname, year
'2 = vbShortDate - Returns date: mm/dd/yy
'3 = vbLongTime - Returns time: hh:mm:ss PM/AM
'4 = vbShortTime - Return time: hh:mm

WScript.echo  Replace(FormatDateTime(Date,1),", ","-")
```</li>
<li><p><strong>PowerShell</strong> - can be installed on every machine that has .NET - download from Microsoft (<a href="http://www.microsoft.com/en-us/download/details.aspx?id=7217" rel="noreferrer">v1</a>, <a href="http://support.microsoft.com/kb/968929/bg" rel="noreferrer">v2</a>, <a href="http://www.microsoft.com/en-us/download/details.aspx?id=34595" rel="noreferrer">v3</a> (only for Windows&nbsp;7 and above)). It is installed by default on everything from Windows&nbsp;7/Windows Server 2008 and above:</p>

```sh
C:\> powershell get-date -format "{dd-MMM-yyyy HH:mm}"
```

To use it from a batch file:  

```sh
for /f "delims=" %%# in ('powershell get-date -format "{dd-MMM-yyyy HH:mm}"') do @set _date=%%#
```</li>
<li><p><strong>Self-compiled jscript.net/batch</strong> (never seen a Windows machine without .NET, so I think this is a pretty portable):</p>

```sh
@if (@X)==(@Y) @end /****** silent line that start JScript comment ******

@echo off
::::::::::::::::::::::::::::::::::::
:::       Compile the script    ::::
::::::::::::::::::::::::::::::::::::
setlocal
if exist "%~n0.exe" goto :skip_compilation

set "frm=%SystemRoot%\Microsoft.NET\Framework\"

:: Searching the latest installed .NET framework
for /f "tokens=* delims=" %%v in ('dir /b /s /a:d /o:-n "%SystemRoot%\Microsoft.NET\Framework\v*"') do (
    if exist "%%v\jsc.exe" (
        rem :: the javascript.net compiler
        set "jsc=%%~dpsnfxv\jsc.exe"
        goto :break_loop
    )
)
echo jsc.exe not found && exit /b 0
:break_loop


call %jsc% /nologo /out:"%~n0.exe" "%~dpsfnx0"
::::::::::::::::::::::::::::::::::::
:::       End of compilation    ::::
::::::::::::::::::::::::::::::::::::
:skip_compilation

"%~n0.exe"

exit /b 0


****** End of JScript comment ******/
import System;
import System.IO;

var dt=DateTime.Now;
Console.WriteLine(dt.ToString("yyyy-MM-dd hh:mm:ss"));
```</li>
<li><p><strong>Logman</strong> This cannot get the year and day of the week. It's comparatively slow and also creates a temporary file and is based on the time stamps that logman puts on its log files. It will work on everything from Windows&nbsp;XP and above. It probably will be never used by anybody - including me - but is one more way...</p>

```sh
@echo off
setlocal
del /q /f %temp%\timestampfile_*

Logman.exe stop ts-CPU 1>nul 2>&1
Logman.exe delete ts-CPU 1>nul 2>&1

Logman.exe create counter ts-CPU  -sc 2 -v mmddhhmm -max 250 -c "\Processor(_Total)\%% Processor Time" -o %temp%\timestampfile_ >nul
Logman.exe start ts-CPU 1>nul 2>&1

Logman.exe stop ts-CPU >nul 2>&1
Logman.exe delete ts-CPU >nul 2>&1
for /f "tokens=2 delims=_." %%t in  ('dir /b %temp%\timestampfile_*^&del /q/f %temp%\timestampfile_*') do set timestamp=%%t

echo %timestamp%
echo MM: %timestamp:~0,2%
echo dd: %timestamp:~2,2%
echo hh: %timestamp:~4,2%
echo mm: %timestamp:~6,2%

endlocal
exit /b 0
```</li>
<li><p>One more way with <strong>WMIC</strong> which also gives week of the year and the day of the week, but not the milliseconds (for milliseconds check foxidrive's answer):</p>

```sh
for /f %%# in ('wMIC Path Win32_LocalTime Get /Format:value') do @for /f %%@ in ("%%#") do @set %%@
echo %day%
echo %DayOfWeek%
echo %hour%
echo %minute%
echo %month%
echo %quarter%
echo %second%
echo %weekinmonth%
echo %year%
```</li>
<li><p>Using <strong><a href="http://ss64.com/nt/typeperf.html" rel="noreferrer">TYPEPERF</a></strong> with some efforts to be fast and compatible with different language settings and as fast as possible:</p>

```sh
@echo off
setlocal

:: Check if Windows is Windows XP and use Windows XP valid counter for UDP performance
::if defined USERDOMAIN_roamingprofile (set "v=v4") else (set "v=")

for /f "tokens=4 delims=. " %%# in ('ver') do if %%# GTR 5 (set "v=v4") else ("v=")
set "mon="
for /f "skip=2 delims=," %%# in ('typeperf "\UDP%v%\*" -si 0 -sc 1') do (
   if not defined mon (
      for /f "tokens=1-7 delims=.:/ " %%a in (%%#) do (
        set mon=%%a
        set date=%%b
        set year=%%c
        set hour=%%d
        set minute=%%e
        set sec=%%f
        set ms=%%g
      )
   )
)
echo %year%.%mon%.%date%
echo %hour%:%minute%:%sec%.%ms%
endlocal
```</li>
<li><p><strong>MSHTA</strong> allows calling JavaScript methods similar to the JScript method demonstrated in #3 above. Bear in mind that JavaScript's Date object properties involving month values are numbered from 0 to 11, not 1 to 12. So a value of 9 means October.</p>

```sh
<!-- : Batch portion

@echo off
setlocal

for /f "delims=" %%I in ('mshta "%~f0"') do set "now.%%~I"

rem Display all variables beginning with "now."
set now.

goto :EOF

end batch / begin HTA -->

<script>
    resizeTo(0,0)
    var fso = new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1),
        now = new Date(),
        props=['getDate','getDay','getFullYear','getHours','getMilliseconds','getMinutes',
            'getMonth','getSeconds','getTime','getTimezoneOffset','getUTCDate','getUTCDay',
            'getUTCFullYear','getUTCHours','getUTCMilliseconds','getUTCMinutes','getUTCMonth',
            'getUTCSeconds','getYear','toDateString','toGMTString','toLocaleDateString',
            'toLocaleTimeString','toString','toTimeString','toUTCString','valueOf'],
        output = [];

    for (var i in props) {output.push(props[i] + '()=' + now[props[i]]())}
    close(fso.Write(output.join('\n')));
</script>
```</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: How to add to the PYTHONPATH in Windows, so it finds my modules/packages? (score [1268739](https://stackoverflow.com/q/3701646) in 2019)

#### Question
I have a directory which hosts all of my Django apps (`C:\My_Projects`). I want to add this directory to my `PYTHONPATH` so I can call the apps directly.  

I tried adding `C:\My_Projects\;` to my Windows `Path` variable from the Windows GUI (`My Computer &gt; Properties &gt; Advanced System Settings &gt; Environment Variables`). But it still doesn't read the coltrane module and generates this error:  

<blockquote>
  Error: No module named coltrane  
</blockquote>

#### Answer accepted (score 398)
You know what has worked for me really well on windows.  

`My Computer &gt; Properties &gt; Advanced System Settings &gt; Environment Variables &gt;`   

Just add the path as C:\Python27 (or wherever you installed python)  

OR  

Then under system variables I create a new Variable called `PythonPath`. In this variable I have `C:\Python27\Lib;C:\Python27\DLLs;C:\Python27\Lib\lib-tk;C:\other-folders-on-the-path`  

<img src="https://i.stack.imgur.com/ZGp36.png" alt="enter image description here">  

This is the best way that has worked for me which I hadn't found in any of the docs offered.  

<p><strong>EDIT:</strong> For those who are not able to get it,
Please add </p>

<blockquote>
  C:\Python27;  
</blockquote>

along with it. Else it will <em>never work</em>.  

#### Answer 2 (score 120)
<p>Windows 7 Professional
I Modified @mongoose_za's answer to make it easier to change the python version:</p>

<ol>
<li>[Right Click]Computer > Properties >Advanced System Settings > Environment Variables</li>
<li>Click [New] under "System Variable"</li>
<li>Variable Name: PY_HOME, Variable Value:C:\path\to\python\version
<img src="https://i.stack.imgur.com/kqc2E.png" alt="enter image description here"></li>
<li>Click [OK]</li>
<li>Locate the "Path" System variable and click [Edit]</li>
<li><p>Add the following to the existing variable:</p>

<p>%PY_HOME%;%PY_HOME%\Lib;%PY_HOME%\DLLs;%PY_HOME%\Lib\lib-tk;
<img src="https://i.stack.imgur.com/XK6YH.png" alt="enter image description here"></p></li>
<li><p>Click [OK] to close all of the windows. </p></li>
</ol>

As a final sanity check open a command prompt and enter python. You should see   

```sh
>python [whatever version you are using]
```

If you need to switch between versions, you only need to modify the PY_HOME variable to point to the proper directory. This is bit easier to manage if you need multiple python versions installed.   

#### Answer 3 (score 68)
<strong>Just append</strong> your installation path (ex. <strong>C:\Python27\</strong>) to the <strong>PATH</strong> variable in <strong>System variables</strong>. Then close and open your <strong>command line and type 'python'</strong>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: List all environment variables from the command line (score [1247592](https://stackoverflow.com/q/5327495) in 2019)

#### Question
Is it possible to list <em>all</em> environment variables from a Windows' command prompt?  

Something equivalent to PowerShell's `gci env:` (or `ls env:` or `dir env:`).  

#### Answer accepted (score 1280)
Just do:  

```sh
SET
```

You can also do `SET prefix` to see all variables with names starting with `prefix`.  

For example, if you want to read only derbydb from the environment variables, do the following:   

```sh
set derby 
```

...and you will get the following:   

```sh
DERBY_HOME=c:\Users\amro-a\Desktop\db-derby-10.10.1.1-bin\db-derby-10.10.1.1-bin
```

#### Answer 2 (score 157)
Jon has the right answer, but to elaborate a little more with some syntactic sugar..  

```sh
SET | more
```

enables you to see the variables one page at a time, rather than the whole lot, or  

```sh
SET > output.txt
```

sends the output to a file output.txt which you can open in <a href="http://en.wikipedia.org/wiki/Notepad_%28software%29" rel="nofollow noreferrer">Notepad</a> or whatever...  

#### Answer 3 (score 90)
To list all environment variables in PowerShell:  

```sh
Get-ChildItem Env:
```

Or as suggested by user797717 to avoid output truncation:  

```sh
Get-ChildItem Env: | Format-Table -Wrap -AutoSize
```

Source: <em><a href="https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-powershell-1.0/ff730964(v=technet.10)" rel="nofollow noreferrer">Creating and Modifying Environment Variables</a></em> (<em>Windows PowerShell Tip of the Week</em>)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How do I install a Python package with a .whl file? (score [1233159](https://stackoverflow.com/q/27885397) in 2017)

#### Question
I'm having trouble installing a Python package (specifically, JPype1 0.5.7) on my Windows machine, and would like to install it with Christoph Gohlke's Window binaries. (Which, to my experience, alleviated much of the fuss for many other package installations.)  

However, while Christoph used to provide .exe files in the past, recently it seems he's uploading .whl files instead.  

<a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/#jpype" rel="noreferrer">http://www.lfd.uci.edu/~gohlke/pythonlibs/#jpype</a>  

But how do I install .whl files?  

<blockquote>
  Notes:  
  
  <ul>
  <li>I've found <a href="https://wheel.readthedocs.org/en/latest/" rel="noreferrer">documents on wheel</a>, but they don't seem so staightforward in explaining how to install .whl files.</li>
  <li>This question is a duplicate with <a href="https://stackoverflow.com/questions/27041264/how-to-install-whl-file-in-python-windows">this question</a>, which wasn't directly answered.</li>
  </ul>
</blockquote>

#### Answer accepted (score 924)
I just used the following which was quite simple. First open a console then cd to where you've downloaded your file like some-package.whl and use  

```sh
pip install some-package.whl
```

<p>Note: if pip.exe is not recognized, you may find it in the "Scripts" directory from where python has been installed. If pip is not installed, this page can help:
<a href="https://stackoverflow.com/questions/4750806/how-to-install-pip-on-windows">How do I install pip on Windows?</a></p>

<p><em>Note: for clarification</em><br>
If you copy the `*.whl` file to your local drive (ex. <strong>C:\some-dir\some-file.whl</strong>) use the following command line parameters --  </p>

```sh
pip install C:/some-dir/some-file.whl
```

#### Answer 2 (score 60)
To install from wheel, give it the directory where the wheel is downloaded. For example, to install `package_name.whl`:  

```sh
pip install --use-wheel --no-index --find-links=/where/its/downloaded package_name
```

Make sure you have updated pip first to enable wheel support:  

```sh
pip install --upgrade pip
```

#### Answer 3 (score 19)
I am in the same boat as the OP.  

Using a Windows command prompt, from directory:  

```sh
C:\Python34\Scripts>
pip install wheel
```

seemed to work.  

Changing directory to where the whl was located, it just tells me 'pip is not recognized'. Going back to `C:\Python34\Scripts&gt;`, then using the full command above to provide the 'where/its/downloaded' location, it says `Requirement 'scikit_image-...-win32.whl' looks like a filename, but the filename does not exist`.  

So I dropped a copy of the .whl in Python34/Scripts, ran the exact same command over again (with the `--find-links=` still going to the other folder), and this time it worked.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: Best C++ IDE or Editor for Windows (score [1193943](https://stackoverflow.com/q/89275) in 2009)

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

### 14: How do I install and use curl on Windows? (score [1105897](https://stackoverflow.com/q/9507353) in 2018)

#### Question
I am having trouble getting curl to run on Windows.  

I have downloaded a curl zip file from <a href="https://curl.haxx.se/download.html" rel="noreferrer">here</a>, but it seems to contain source code, not an executable.  

Do I <em>need</em> to compile curl to run it? If yes, then how do I do that?  

Where can I find `.exe` downloads for curl?  

I have looked for documentation on installing curl, but there is little to be found.  

#### Answer accepted (score 222)
Assuming you got it from <a href="http://curl.haxx.se/download.html">https://curl.haxx.se/download.html</a>, just unzip it wherever you want. No need to install. If you are going to use SSL, you need to download the OpenSSL DLLs, available from curl's website.  

#### Answer 2 (score 845)
<h5>You might already have curl</h1>

It is possible that you won't need to download anything:  

<ul>
<li>If you are on Windows 10, version 1803 or later, your OS <a href="https://devblogs.microsoft.com/commandline/tar-and-curl-come-to-windows/" rel="noreferrer">ships with a copy of curl</a>, already set up and ready to use.</li>
<li><p>If you have <a href="https://gitforwindows.org/" rel="noreferrer">Git for Windows</a> installed (if you downloaded Git from <a href="https://git-scm.com/" rel="noreferrer">git-scm.com</a>, the answer is yes), you have `curl.exe` under:</p>

```sh
C:\Program Files\Git\mingw64\bin\
```

Simply add the above path to `PATH`.  </li>
</ul>

<h5>Installing curl with a package manager</h1>

If you are already using a package manager, it may be more convenient to install with one:  

<ul>
<li>For <a href="https://chocolatey.org/" rel="noreferrer">Chocolatey</a>, run `choco install curl`</li>
<li>For <a href="https://www.msys2.org/" rel="noreferrer">MSYS2</a>, run `pacman -S curl`</li>
<li>For <a href="https://scoop.sh/" rel="noreferrer">Scoop</a>, run `scoop install curl`</li>
<li>For <a href="https://www.cygwin.com/" rel="noreferrer">Cygwin</a>, <a href="https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/objectstorage/installing_cURL/installing_cURL_on_Cygwin_on_Windows.html#section1" rel="noreferrer">add the curl package in Cygwin Setup</a>.</li>
</ul>

<h5>Installing curl manually</h1>

<h5>Downloading curl</h3>

It is too easy to accidentally download the wrong thing. If, on the <a href="https://curl.haxx.se/" rel="noreferrer">curl homepage</a>, you click the large and prominent "Download" section in the site header, and then the large and prominent `curl-7.62.0.tar.gz` link in its body, you will have downloaded a curl <em>source package</em>, which contains curl's source code but not `curl.exe`. Watch out for that.  

Instead, click the large and prominent download links <strong><a href="https://curl.haxx.se/windows/" rel="noreferrer">on this page</a></strong>. Those are the official Windows builds, and they are provided by the <a href="https://github.com/curl/curl-for-win" rel="noreferrer">curl-for-win</a> project.  

If you have more esoteric needs (e.g. you want cygwin builds, third-party builds, libcurl, header files, sources, etc.), use the curl <a href="https://curl.haxx.se/dlwiz/" rel="noreferrer">download wizard</a>. After answering five questions, you will be presented with a list of download links.  

<h5>Extracting and setting up curl</h3>

Find `curl.exe` within your downloaded package; it's probably under `bin\`.  

Pick a location on your hard drive that will serve as a permanent home for curl:  

<ul>
<li>If you want to give curl its own folder, `C:\Program Files\curl\` or `C:\curl\` will do.</li>
<li>If you have many loose executables, and you do not want to add many individual folders to `PATH`, use a single folder such as `C:\Program Files\tools\` or `C:\tools\` for the purpose.</li>
</ul>

Place `curl.exe` under the folder. And never move the folder or its contents.  

Next, you'll want to make curl available anywhere from the command line. To do this, add the folder to `PATH`, like this:  

<ol>
<li>Click the Windows 10 start menu. Start typing "environment".</li>
<li>You'll see the search result <strong>Edit the system environment variables</strong>. Choose it.</li>
<li>A System Properties window will popup. Click the <strong>Environment Variables</strong> button at the bottom.</li>
<li>Select the "Path" variable under "System variables" (the lower box). Click the <strong>Edit</strong> button.</li>
<li>Click the <strong>Add</strong> button and paste in the folder path where `curl.exe` lives.</li>
<li>Click <strong>OK</strong> as needed. Close open console windows and reopen, so they get the new `PATH`.</li>
</ol>

Now enjoy typing curl at any command prompt. Party time!  

#### Answer 3 (score 98)
<ol>
<li>Download curl zip</li>
<li>Extract the contents (if you have downloaded the correct version you should find curl.exe)</li>
<li>Place curl.exe in a folder where you keep your software (e.g. D:\software\curl\curl.exe)</li>
<li><p>To run curl from the command line </p>

a) Right-hand-click on "My Computer" icon  

b) Select Properties  

c) Click 'Advanced system settings' link  

d) Go to tab [Advanced] - 'Environment Variables' button  

e) Under <em>System variable</em> select 'Path' and Edit button  

f) Add a semicolon followed by the path to where you placed your curl.exe (e.g. ;D:\software\curl)  </li>
</ol>

Now you can run from the command line by typing:   

```sh
curl www.google.com
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: How can I develop for iPhone using a Windows development machine? (score [1099372](https://stackoverflow.com/q/22358) in 2019)

#### Question
Is there any way to tinker with the iPhone SDK on a Windows machine? Are there plans for an iPhone SDK version for Windows?  

The only other way I can think of doing this is to run a Mac VM image on a <strong>VMWare</strong> server running on Windows, although I'm not too sure how legal this is.  

#### Answer 2 (score 492)
It's certainly possible to develop on a Windows machine, in fact, my first application was exclusively developed on the old Dell Precision I had at the time :)  

There are three routes;  

<ol>
<li>Install <a href="http://en.wikipedia.org/wiki/OSx86" rel="noreferrer">OSx86</a> (aka iATKOS / Kalyway) on a second partition/disk and dual boot.</li>
<li>Run Mac OS X Server under VMWare (Mac OS X 10.7 (Lion) onwards, read the update below).</li>
<li>Use Delphi XE4 and the macincloud service. This is a commercial toolset, but the component and lib support is growing.</li>
</ol>

The first route requires modifying (or using a pre-modified) image of Leopard that can be installed on a regular PC. This is not as hard as you would think, although your success/effort ratio will depend upon how closely the hardware in your PC matches that in Mac hardware - e.g. if you're running a Core 2 Duo on an Intel Motherboard, with an NVidia graphics card you are laughing. If you're running an AMD machine or something without SSE3 it gets a little more involved.  

If you purchase (or already own) a version of Leopard then this is a gray area since the Leopard EULA states you may only run it on an "Apple Labeled" machine. As many point out if you stick an Apple sticker on your PC you're probably covered.  

The second option is more costly. The EULA for the workstation version of Leopard prevents it from being run under emulation and as a result, there's no support in VMWare for this. Leopard server, however, CAN be run under emulation and can be used for desktop purposes. Leopard server and VMWare are expensive, however.  

If you're interested in option 1) I would suggest starting at <a href="http://www.insanelymac.com/forum/" rel="noreferrer">Insanelymac</a> and reading the OSx86 sections.   

I do think you should consider whether the time you will invest is going to be worth the money you will save though. It was for me because I enjoy tinkering with this type of stuff and I started during the early iPhone betas, months before their App Store became available.  

Alternatively, you could pick up a low-spec Mac Mini from eBay. You don't need much horsepower to run the SDK and you can always sell it on later if you decide to stop development or buy a better Mac.  

Update: You cannot create a Mac OS X Client virtual machine for OS X 10.6 and earlier. Apple does not allow these Client OSes to be virtualized. With Mac OS X 10.7 (Lion) onwards, Apple has changed its licensing agreement in regards to virtualization. Source: <a href="http://kb.vmware.com/selfservice/microsites/search.do?language=en_US&amp;cmd=displayKC&amp;externalId=2005793" rel="noreferrer">VMWare KnowledgeBase</a>  

#### Answer 3 (score 168)
<a href="http://xamarin.com/" rel="noreferrer">Xamarin</a> is now my top vote. Purchased by Microsoft and built directly into Visual Studio now and being able to use C# and with all the updates and features they are adding, you can do everything on Windows, even compile, build and initiate deployment. You only need a Mac Mini to act as the deployment server, but you never need to write any code on it.  

For games, <a href="http://www.unity3d.com" rel="noreferrer">Unity 3D</a> is my top choice. The editor is free up to 100K annual revenue (perfect for indie). Unity 5+ is fully unlocked as well, even the free version. Unity supports iOS, Android and most other platforms. For iOS and MAC, simply get the cheapest MAC Mini you can find to do the build, but all the development can be done on Windows.  

Other options:  

<a href="http://www.phonegap.com" rel="noreferrer">PhoneGap</a> also works, but I have found it isn't quite as nice for gaming, but it's pretty decent for regular GUI applications. Again, you'll need a Mac to sign and test your application and be in compliance with Apple's terms of use.  

<a href="https://flutter.io/" rel="noreferrer">Flutter</a> is a free cross platform mobile app development framework from Google.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: Batch file to delete files older than N days (score [1097834](https://stackoverflow.com/q/51054) in 2018)

#### Question
I am looking for a way to delete all files older than 7 days in a batch file.  I've searched around the web, and found some examples with hundreds of lines of code, and others that required installing extra command line utilities to accomplish the task.  

Similar things can be <a href="https://stackoverflow.com/questions/25785/delete-all-but-the-most-recent-x-files-in-bash">done in BASH</a> in just a couple lines of code. It seems that something at least remotely easy could be done for batch files in Windows. I'm looking for a solution that works in a standard Windows command prompt, without any extra utilities. Please no PowerShell or Cygwin either.  

#### Answer accepted (score 1029)
Enjoy:  

```sh
forfiles -p "C:\what\ever" -s -m *.* -d <number of days> -c "cmd /c del @path"
```

See <a href="http://ss64.com/nt/forfiles.html" rel="noreferrer">`forfiles` documentation</a> for more details.  

For more goodies, refer to <em><a href="http://www.ss64.com/nt/" rel="noreferrer">An A-Z Index of the Windows&nbsp;XP command line</a></em>.  

If you don't have `forfiles` installed on your machine, copy it from any <a href="http://en.wikipedia.org/wiki/Windows_Server_2003" rel="noreferrer">Windows&nbsp;Server&nbsp;2003</a> to your Windows&nbsp;XP machine at `%WinDir%\system32\`. This is possible since the EXE is fully compatible between Windows&nbsp;Server&nbsp;2003 and Windows&nbsp;XP.  

Later versions of Windows and Windows&nbsp;Server have it installed by default.  

For Windows&nbsp;7 and newer (including Windows&nbsp;10):  

The syntax has changed a little. Therefore the updated command is:  

```sh
forfiles /p "C:\what\ever" /s /m *.* /D -<number of days> /C "cmd /c del @path"
```

#### Answer 2 (score 74)
Run the following <a href="https://technet.microsoft.com/en-us/library/cc733145.aspx" rel="noreferrer">commands</a>:  

```sh
ROBOCOPY C:\source C:\destination /mov /minage:7
del C:\destination /q
```

Move all the files (using /mov, which moves files and then deletes them as opposed to /move which moves whole filetrees which are then deleted) via robocopy to another location, and then execute a delete command on that path and you're all good.    

Also if you have a directory with lots of data in it you can use `/mir` switch   

#### Answer 3 (score 24)
Ok was bored a bit and came up with this, which contains my version of a poor man's Linux epoch replacement limited for daily usage (no time retention):  

7daysclean.cmd  

```sh
@echo off
setlocal ENABLEDELAYEDEXPANSION
set day=86400
set /a year=day*365
set /a strip=day*7
set dSource=C:\temp

call :epoch %date%
set /a slice=epoch-strip

for /f "delims=" %%f in ('dir /a-d-h-s /b /s %dSource%') do (
    call :epoch %%~tf
    if !epoch! LEQ %slice% (echo DELETE %%f ^(%%~tf^)) ELSE echo keep %%f ^(%%~tf^)
)
exit /b 0

rem Args[1]: Year-Month-Day
:epoch
    setlocal ENABLEDELAYEDEXPANSION
    for /f "tokens=1,2,3 delims=-" %%d in ('echo %1') do set Years=%%d& set Months=%%e& set Days=%%f
    if "!Months:~0,1!"=="0" set Months=!Months:~1,1!
    if "!Days:~0,1!"=="0" set Days=!Days:~1,1!
    set /a Days=Days*day
    set /a _months=0
    set i=1&& for %%m in (31 28 31 30 31 30 31 31 30 31 30 31) do if !i! LSS !Months! (set /a _months=!_months! + %%m*day&& set /a i+=1)
    set /a Months=!_months!
    set /a Years=(Years-1970)*year
    set /a Epoch=Years+Months+Days
    endlocal& set Epoch=%Epoch%
    exit /b 0
```

<h5>USAGE</h2>

`set /a strip=day*7` : Change <strong>7</strong> for the number of days to keep.  

`set dSource=C:\temp` : This is the starting directory to check for files.  

<h5>NOTES</h2>

This is non-destructive code, it will display what would have happened.  

Change :  

```sh
if !epoch! LEQ %slice% (echo DELETE %%f ^(%%~tf^)) ELSE echo keep %%f ^(%%~tf^)
```

to something like :  

```sh
if !epoch! LEQ %slice% del /f %%f
```

so files actually get deleted  

<strong>February</strong>: is hard-coded to 28 days. Bissextile years is a hell to add, really. if someone has an idea that would not add 10 lines of code, go ahead and post so I add it to my code.  

<strong>epoch</strong>: I did not take time into consideration, as the need is to delete files older than a certain date, taking hours/minutes would have deleted files from a day that was meant for keeping.  

<h5>LIMITATION</h2>

<strong>epoch</strong> takes for granted your short date format is YYYY-MM-DD.  It would need to be adapted for other settings or a run-time evaluation (read sShortTime, user-bound configuration, configure proper field order in a filter and use the filter to extract the correct data from the argument).  

Did I mention I hate this editor's auto-formating? it removes the blank lines and the copy-paste is a hell.  

I hope this helps.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: How can I update npm on Windows? (score [1073070](https://stackoverflow.com/q/18412129) in 2018)

#### Question
I tried <a href="http://davidwalsh.name/upgrade-nodejs" rel="noreferrer">this</a>:  

```sh
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
```

...but it didn't work.  

How do I do this on Windows?  

#### Answer accepted (score 1789)
This is the new best way to <a href="https://github.com/felixrieseberg/npm-windows-upgrade" rel="noreferrer">upgrade <strong>npm</strong> on Windows</a>.  

Run PowerShell as Administrator  

```sh
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
npm install -g npm-windows-upgrade
npm-windows-upgrade
```

Note: Do not run `npm i -g npm`. Instead use `npm-windows-upgrade` to update npm going forward. Also if you run the NodeJS installer, it will replace the node version.  

<ul>
<li>Upgrades npm in-place, where node installed it.</li>
<li>Easy updating, update to the latest by running `npm-windows-upgrade -p -v latest`.</li>
<li>Does not modify the default path.</li>
<li>Does not change the default global package location.</li>
<li>Allows easy upgrades and downgrades.</li>
<li><a href="https://github.com/npm/npm/wiki/Troubleshooting#upgrading-on-windows" rel="noreferrer">Officially recommended by the NPM team</a>.</li>
<li>A list of versions matched between NPM and NODE (<a href="https://nodejs.org/en/download/releases/" rel="noreferrer">https://nodejs.org/en/download/releases/</a>) - but you will need to download NODE INSTALLER and run that to update node (<a href="https://nodejs.org/en/" rel="noreferrer">https://nodejs.org/en/</a>) </li>
</ul>

#### Answer 2 (score 581)
<a href="https://nodejs.org/en/download" rel="noreferrer">Download</a> and run the latest MSI.  The MSI will update your installed node and npm.  

#### Answer 3 (score 112)
To update NPM, this worked for me:  

<ul>
<li>Navigate in your shell to your node installation directory, eg `C:\Program Files (x86)\nodejs`</li>
<li>run `npm install npm` (no `-g` option) </li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: How to create an empty file at the command line in Windows? (score [1034890](https://stackoverflow.com/q/1702762) in 2019)

#### Question
How to create an empty file at the DOS/Windows command-line?  

I tried:  

```sh
copy nul > file.txt
```

but it always displays that a file was copied.  

Is there any other method in the standard cmd?  

<p>It should be a method that does not require the <a href="http://en.wikipedia.org/wiki/Touch_%28Unix%29" rel="noreferrer">touch</a> command from Cygwin or any other nonstandard commands.
The command needs to run from a script so keystrokes cannot be used.</p>

#### Answer accepted (score 532)
<em>Without</em> redirection, <a href="https://stackoverflow.com/users/5423827/luc-vu">Luc Vu</a> or <a href="https://stackoverflow.com/users/2474955/erik-konstantopoulos">Erik Konstantopoulos</a> <a href="https://stackoverflow.com/a/34460123/6309">point</a> <a href="https://stackoverflow.com/a/32296375/6309">out</a> to:  

```sh
copy NUL EMptyFile.txt
copy /b NUL EmptyFile.txt
```

<hr>

"<a href="https://stackoverflow.com/q/210201/6309">How to create empty text file from a batch file?</a>" (2008) also points to:  

```sh
type NUL > EmptyFile.txt
# also
echo. 2>EmptyFile.txt
copy nul file.txt > nul # also in qid's answer below
REM. > empty.file
fsutil file createnew file.cmd 0 # to create a file on a mapped drive
```

<hr>

<a href="https://stackoverflow.com/users/3040932/nomad">Nomad</a> mentions <a href="https://stackoverflow.com/a/20237561/6309">an original one</a>:  

```sh
C:\Users\VonC\prog\tests>aaaa > empty_file
'aaaa' is not recognized as an internal or external command, operable program or batch file.

C:\Users\VonC\prog\tests>dir

 Folder C:\Users\VonC\prog\tests

27/11/2013  10:40    <REP>          .
27/11/2013  10:40    <REP>          ..
27/11/2013  10:40                 0 empty_file
```

In the same spirit, <a href="https://stackoverflow.com/users/840405/samuel">Samuel</a> suggests <a href="https://stackoverflow.com/questions/1702762/how-to-create-an-empty-file-at-the-command-line-in-windows/43677896#comment74402568_1702790">in the comments</a>:  

<blockquote>
  the shortest one I use is basically the one by Nomad:   
</blockquote>

```sh
.>out.txt
```

It does give an error:   

```sh
'.' is not recognized as an internal or external command
```

<p>But this error is on stderr. And `&gt;` only redirects stdout, where <em>nothing</em> have been produced.<br>
Hence the creation of an <em>empty</em> file. The error message can be disregarded here.</p>

<hr>

(Original answer, November 2009)  

```sh
echo.>filename
```

(`echo ""` would actually put "" in the file! And `echo` without the '.' would put "`Command ECHO activated`" in the file...)  

Note: the resulting file is not <em>empty</em> but includes a return line sequence: 2 bytes.  

<hr>

This <a href="http://groups.google.com/group/microsoft.public.win2000.cmdprompt.admin/msg/092e5cc12148ce2f?pli=1" rel="noreferrer">discussion</a> points to a true batch solution for a real <em>empty</em> file:  

```sh
 <nul (set/p z=) >filename

 dir filename
 11/09/2009  19:45                 0 filename
 1 file(s)                         0 bytes
```

<blockquote>
  <p>The "`&lt;nul`" pipes a `nul` response to the `set/p` command, which will cause the
  variable used to remain unchanged. As usual with `set/p`, the string to the
  right of the equal sign is displayed as a prompt with no CRLF. </p>
</blockquote>

Since here the "string to the right of the equal sign" is empty... the result is an empty file.  

<hr>

The difference with `cd. &gt; filename` (which is mentioned in <a href="https://stackoverflow.com/questions/1702762/how-to-create-an-empty-file-in-the-command-line/1703040#1703040">Patrick Cuff's answer</a> and does also produce a 0-byte-length file) is that this "bit of redirection" (the `&lt;nul...` trick) can be used to <strong>echo lines without any CR</strong>:  

```sh
<nul (set/p z=hello) >out.txt
<nul (set/p z= world!) >>out.txt
dir out.txt
```

<blockquote>
  The dir command should indicate the file size as 12 bytes: "`hello world!`".   
</blockquote>

#### Answer 2 (score 259)
Try this:  

```sh
type NUL > 1.txt
```

this will definitely create an empty file.  

#### Answer 3 (score 97)
Here's another way:  

```sh
cd. > filename
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Bat file to run a .exe at the command prompt (score [1023585](https://stackoverflow.com/q/221730) in 2013)

#### Question
I want to create a .bat file so I can just click on it so it can run:  

```sh
svcutil.exe /language:cs /out:generatedProxy.cs /config:app.config http://localhost:8000/ServiceModelSamples/service
```

Can someone help me with the structure of the .bat file?  

#### Answer 2 (score 179)
To start a program and then close command prompt without waiting for program to exit:  

```sh
start /d "path" file.exe
```

#### Answer 3 (score 38)
You can use:  

```sh
start "windowTitle" fullPath/file.exe
```

Note: the first set of quotes must be there but you don't have to put anything in them, e.g.:  

```sh
start "" fullPath/file.exe
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: Command line for looking at specific port (score [998385](https://stackoverflow.com/q/12010631) in 2012)

#### Question
Is there a way to examine the status of a specific port from the Windows command line? I know I can use netstat to examine all ports but netstat is slow and looking at a specific port probably isn't.  

#### Answer 2 (score 230)
Here is the <strong>easy solution</strong> of port finding...  

In cmd:  

```sh
netstat -na | find "8080"
```

In bash:  

```sh
netstat -na | grep "8080"
```

In PowerShell:  

```sh
netstat -na | Select-String "8080"
```

#### Answer 3 (score 102)
You can use the `netstat` combined with the `-np` flags and a pipe to the `find` or `findstr` commands.  

Basic Usage is as such:  

```sh
netstat -np <protocol> | find "port #"
```

<p>So for example to check port 80 on TCP, you can do this: `netstat -np TCP | find "80"`
Which ends up giving the following kind of output:</p>

```sh
TCP    192.168.0.105:50466    64.34.119.101:80       ESTABLISHED
TCP    192.168.0.105:50496    64.34.119.101:80       ESTABLISHED
```

As you can see, this only shows the connections on port 80 for the TCP protocol.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: How to check if a file exists from inside a batch file (score [993839](https://stackoverflow.com/q/4340350) in 2011)

#### Question
I need to run a utility only if a certain file exists. How do I do this in Windows batch?  

#### Answer accepted (score 705)
```sh
if exist <insert file name here> (
    rem file exists
) else (
    rem file doesn't exist
)
```

Or on a single line (if only a single action needs to occur):  

```sh
if exist <insert file name here> <action>
```

for example, this opens notepad on autoexec.bat, if the file exists:  

```sh
if exist c:\autoexec.bat notepad c:\autoexec.bat
```

#### Answer 2 (score 81)
```sh
C:\>help if
```

Performs conditional processing in batch programs.  

<blockquote>
  IF [NOT] ERRORLEVEL number command  
  
  IF [NOT] string1==string2 command  
  
  <strong>IF [NOT] EXIST filename command</strong>  
</blockquote>

#### Answer 3 (score 35)
Try something like the following example, quoted from the output of `IF /?` on Windows XP:  

<pre>
IF EXIST filename. (
    del filename.
) ELSE (
    echo filename. missing.
)
</pre>

You can also check for a missing file with `IF NOT EXIST`.  

<p>The `IF` command is quite powerful. The output of `IF /?` will reward careful reading. For that matter, try the `/?` option on many of the other built-in commands for lots of hidden gems.
&nbsp;</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: In Windows cmd, how do I prompt for user input and use the result in another command? (score [975908](https://stackoverflow.com/q/1223721) in 2013)

#### Question
I have a Windows .bat file which I would like to accept user input and then use the results of that input as part of the call to additional commands.  

For example, I'd like to accept a process ID from the user, and then run jstack against that ID, putting the results of the jstack call into a file. However, when I try this, it doesn't work.   

Here's my sample bat file contents:  

```sh
@echo off
set /p id=Enter ID: 
echo %id%
jstack > jstack.txt
```

and here's what shows up in jstack.txt:  

<pre>
Enter ID: Terminate batch job (Y/N)? 
</pre>

#### Answer 2 (score 410)
<strong>Try this:</strong>  

```sh
@echo off
set /p id="Enter ID: "
```

You can then use `%id%` as a parameter to another batch file like `jstack %id%`.   

<strong>For example:</strong>  

```sh
set /P id=Enter id: 
jstack %id% > jstack.txt
```

#### Answer 3 (score 97)
The syntax is as such: `set /p variable=[string]`  

Check out <a href="http://commandwindows.com/batch.htm" rel="noreferrer">http://commandwindows.com/batch.htm</a> or <a href="http://www.robvanderwoude.com/userinput.php" rel="noreferrer">http://www.robvanderwoude.com/userinput.php</a> for a more deep dive into user input with the different versions of Windows OS batch files.  

Once you have set your variable, you can then go about using it in the following fashion.  

```sh
@echo off
set /p UserInputPath=What Directory would you like?
cd C:\%UserInputPath%
```

note the `%VariableName%` syntax  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: Ignoring directories in Git repos on Windows (score [935943](https://stackoverflow.com/q/343646) in 2017)

#### Question
How can I ignore directories or folders in Git using msysgit on Windows?  

#### Answer accepted (score 1444)
Create a file named `.gitignore` in your project's directory. Ignore directories by entering the directory name into the file (with a slash appended):  

```sh
dir_to_ignore/
```

More info <a href="http://git-scm.com/docs/gitignore" rel="noreferrer">here</a>.  

#### Answer 2 (score 194)
By default windows explorer will display `.gitignore` when in-fact the file name is `.gitignore.txt`  

Git will not use `.gitignore.txt`  

And you can't rename the file to `.gitignore` because explorer thinks its a file of type gitignore with no name.  

Non command line solution:   

<pre>You can rename a file to <b>".gitignore."</b> and it will create <b>".gitignore"</b></pre>

#### Answer 3 (score 97)
It seems that for ignoring files and directories there are two main ways:  

<ol>
<li><p><strong>.gitignore</strong> </p>

<ul>
<li>Placing `.gitignore` file into the root of your repo besides `.git` folder (in Windows make sure you <a href="http://windows.microsoft.com/en-us/windows/show-hide-file-name-extensions#show-hide-file-name-extensions=windows-7" rel="noreferrer">see the true file extension</a> and then make `.gitignore.` (with the point at the end to make empty file extension) ) </li>
<li>Making global configuration `~/.gitignore_global` and running `git config --global core.excludesfile ~/.gitignore_global` to add this to your git config</li>
</ul>

note: files tracked before can be untracked by running `git rm --cached filename`  </li>
<li><p><strong>Repo exclude</strong> - For local files that do not need to be shared, you just add the file pattern or directory to the file `.git/info/exclude`. Theses rules are not commited, so <strong>are not seen by other users</strong> more info <a href="http://help.github.com/ignore-files/" rel="noreferrer">here</a></p></li>
</ol>

<p>[updated]
To make exceptions in list of ignored files, see <a href="https://stackoverflow.com/questions/2415873/exceptions-in-gitignore">this question</a>.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: How can I echo a newline in a batch file? (score [914923](https://stackoverflow.com/q/132799) in 2019)

#### Question


How can you you insert a newline from your batch file output?  

I want to do something like:  

```sh
echo hello\nworld
```

Which would output:  

```sh
hello
world
```

#### Answer accepted (score 437)
`echo hello &amp; echo.world`  

This means you could define `&amp; echo.` as a constant for a newline `\n`.  

#### Answer 2 (score 524)
Use:  

```sh
echo hello
echo.
echo world
```

#### Answer 3 (score 133)
Here you go, create a .bat file with the following in it :  

```sh
@echo off
REM Creating a Newline variable (the two blank lines are required!)
set NLM=^


set NL=^^^%NLM%%NLM%^%NLM%%NLM%
REM Example Usage:
echo There should be a newline%NL%inserted here.

echo.
pause
```

You should see output like the following:  

```sh
There should be a newline
inserted here.

Press any key to continue . . .
```

You only need the code between the REM statements, obviously.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: How to delete files/subfolders in a specific directory at the command prompt in Windows (score [910658](https://stackoverflow.com/q/1965787) in 2019)

#### Question
Say, there is a variable called `%pathtofolder%`, as it makes it clear it is a full path of a folder.  

I want to delete every single file and subfolder in this directory, but not the directory itself.  

But, there might be an error like 'this file/folder is already in use'... when that happens, it should just continue and skip that file/folder.  

Is there some command for this?  

#### Answer accepted (score 237)
You can use this shell script to clean up the folder and files within `C:\Temp` <a href="https://stackoverflow.com/a/1502935/4352889">source</a>:  

```sh
del /q "C:\Temp\*"
FOR /D %%p IN ("C:\Temp\*.*") DO rmdir "%%p" /s /q
```

Create a batch file (say, delete.bat) containing the above command. Go to the location where the delete.bat file is located and then run the command: delete.bat  

#### Answer 2 (score 325)
<a href="https://technet.microsoft.com/en-us/library/bb490990.aspx" rel="noreferrer">`rmdir`</a>  is my all time favorite command for the job. It works for deleting huge files and folders with subfolders. A backup is not created, so make sure that you have copied your files safely before running this command.  

```sh
RMDIR "FOLDERNAME" /S /Q
```

This silently removes the folder and all files and subfolders.  

#### Answer 3 (score 85)
The simplest solution I can think of is removing the whole directory with  

```sh
RD /S /Q folderPath
```

Then creating this directory again:  

```sh
MD folderPath
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: error: Unable to find vcvarsall.bat (score [861588](https://stackoverflow.com/q/2817869) in 2017)

#### Question
I tried to install the Python package <a href="https://pypi.python.org/pypi/dulwich" rel="noreferrer">dulwich</a>:  



```sh
pip install dulwich
```

But I get a cryptic error message:  

```sh
error: Unable to find vcvarsall.bat
```

The same happens if I try installing the package manually:  

```sh
> python setup.py install
running build_ext
building 'dulwich._objects' extension
error: Unable to find vcvarsall.bat
```

#### Answer 2 (score 683)
<strong><em>Update</strong>: Comments point out that the instructions here may be dangerous. Consider using the Visual C++ 2008 Express edition or the purpose-built <a href="http://www.microsoft.com/en-us/download/details.aspx?id=44266" rel="noreferrer">Microsoft Visual C++ Compiler for Python</a> (<a href="/a/26127562/2778484">details</a>) and <strong>NOT</strong> using the original answer below. Original error message means the required version of Visual C++ is not installed.</em>  

<hr>

For Windows installations:  

While running setup.py for package installations, Python 2.7 searches for an installed Visual Studio 2008. You can trick Python to use a newer Visual Studio by setting the correct path in `VS90COMNTOOLS` environment variable before calling `setup.py`.  

Execute the following command based on the version of Visual Studio installed:  

<ul>
<li>Visual Studio 2010 (VS10): `SET VS90COMNTOOLS=%VS100COMNTOOLS%`</li>
<li>Visual Studio 2012 (VS11): `SET VS90COMNTOOLS=%VS110COMNTOOLS%`</li>
<li>Visual Studio 2013 (VS12): `SET VS90COMNTOOLS=%VS120COMNTOOLS%`</li>
<li>Visual Studio 2015 (VS14): `SET VS90COMNTOOLS=%VS140COMNTOOLS%`</li>
</ul>

<hr>

WARNING: As noted below, this answer is unlikely to work if you are trying to compile python modules.  

See <a href="https://stackoverflow.com/questions/3047542">Building lxml for Python 2.7 on Windows</a> for details.  

#### Answer 3 (score 225)
<p>I found the solution. 
I had the exact same problem, and error, installing 'amara'. I had mingw32 installed, but distutils needed to be configured.</p>

<ol>
<li>I have Python 2.6 that was already installed.</li>
<li>I installed mingw32 to `C:\programs\mingw\`</li>
<li>Add mingw32's bin directory to your environment variable: append `c:\programs\MinGW\bin;` to the <strong>PATH</strong></li>
<li><p>Edit (create if not existing) <strong>distutils.cfg</strong> file located at `C:\Python26\Lib\distutils\distutils.cfg` to be:  </p>

```sh
[build]
compiler=mingw32
```</li>
<li><p>Now run `easy_install.exe amara`.</p></li>
</ol>

Make sure environment is set by opening a new `cmd.exe`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: How do I find where JDK is installed on my windows machine? (score [853848](https://stackoverflow.com/q/4681090) in 2015)

#### Question
<strong>I need to know where JDK is located on my machine.</strong>   

<p>On running `Java -version` in <strong>cmd</strong>, it shows the version as '1.6.xx'.
To find the location of this SDK on my machine I tried using `echo %JAVA_HOME%` but it is only showing 'JAVA_HOME' (as there is no 'JAVA_PATH' var set in my environment variables).</p>

#### Answer accepted (score 302)
If you are using Linux/Unix/Mac OS X:  

Try this:  

```sh
$ which java
```

Should output the exact location.  

After that, you can set `JAVA_HOME` environment variable yourself.  

In my computer (Mac OS X - Snow Leopard):  

```sh
$ which java
/usr/bin/java
$ ls -l /usr/bin/java
lrwxr-xr-x  1 root  wheel  74 Nov  7 07:59 /usr/bin/java -> /System/Library/Frameworks/JavaVM.framework/Versions/Current/Commands/java
```

If you are using Windows:  

```sh
c:\> for %i in (java.exe) do @echo.   %~$PATH:i
```

#### Answer 2 (score 105)
Windows > Start > cmd >   

```sh
C:> for %i in (javac.exe) do @echo.   %~$PATH:i
```

<p>If you have a JDK installed, the Path is displayed,<br>
for example: `C:\Program Files\Java\jdk1.6.0_30\bin\javac.exe`</p>

#### Answer 3 (score 89)
In Windows at the command prompt  

`where javac`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: How to grant permission to users for a directory using command line in Windows? (score [835471](https://stackoverflow.com/q/2928738) in 2016)

#### Question
How can I grant permissions to a user on a directory (Read, Write, Modify) using the Windows command line?  

#### Answer accepted (score 377)
As of Vista, `cacls` is deprecated. Here's the first couple of help lines:  

```sh
C:\>cacls
NOTE: Cacls is now deprecated, please use Icacls.

Displays or modifies access control lists (ACLs) of files
```

You should use `icacls` instead. This is how you grant John full control over `D:\test` folder and all its subfolders:  

```sh
C:\>icacls "D:\test" /grant John:(OI)(CI)F /T
```

According do MS documentation:  

<ul>
<li>`F` = Full Control</li>
<li>`CI` = Container Inherit - This flag indicates that subordinate containers will inherit this ACE.</li>
<li>`OI` = Object Inherit - This flag indicates that subordinate files will inherit the ACE.</li>
<li>`/T` = Apply recursively to existing files and sub-folders. (`OI` and `CI` only apply to new files and sub-folders). Credit: comment by @AlexSpence.</li>
</ul>

For complete documentation, you may run "`icacls`" with no arguments or see the Microsoft documentation <a href="http://technet.microsoft.com/en-us/library/cc753525%28WS.10%29.aspx" rel="noreferrer">here</a> and <a href="http://support.microsoft.com/kb/318754" rel="noreferrer">here</a>  

#### Answer 2 (score 71)
You can also use ICACLS.   

To grant the <strong>Users</strong> group <strong>Full Control</strong> to a folder:  

```sh
>icacls "C:\MyFolder" /grant Users:F
```

To grant <strong>Modify</strong> permission to IIS users for `C:\MyFolder` (if you need your IIS has ability to R/W files into specific folder):  

```sh
>icacls "C:\MyFolder" /grant IIS_IUSRS:M
```

If you do <strong>ICACLS /?</strong> you will be able to see all available options.  

#### Answer 3 (score 19)
Open a Command Prompt, then execute this command:  

<blockquote>
  `icacls "c:\somelocation\of\path" /q /c /t /grant Users:F`  
</blockquote>

`F` gives Full Access.  

`/q /c /t` applies the permissions to subfolders.  

Note: Sometimes "Run as Administrator" will help.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: Command to list all files in a folder as well as sub-folders in windows (score [824293](https://stackoverflow.com/q/15214486) in 2015)

#### Question
<p>I tried searching for a command that could list all the file in a directory as well as subfolders using a command prompt command.
I have read the help for "dir" command but coudn't find what I was looking for.
Please help me what command could get this.</p>

#### Answer accepted (score 264)
The below post gives the solution for your scenario.  

```sh
dir /s /b /o:gn
```

<hr>

<strong>/S</strong> Displays files in specified directory and all subdirectories.  

<strong>/B</strong> Uses bare format (no heading information or summary).  

<strong>/O</strong> List by files in sorted order.  

#### Answer 2 (score 91)
If you want to list folders and files like graphical directory tree, you should use <a href="https://jpsoft.com/help/tree.htm">tree command</a>.  

```sh
tree /f
```

There are various options for display format or ordering.  

Check example output.  

<a href="https://i.stack.imgur.com/DQLnO.jpg"><img src="https://i.stack.imgur.com/DQLnO.jpg" alt="enter image description here"></a>  

Answering late. Hope it help someone.   

#### Answer 3 (score 52)
An addition to the answer: when you do not want to list the folders, only the files in the subfoldes, use /A-D switch like this:  

```sh
dir ..\myfolder /b /s /A-D /o:gn>list.txt
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: How can you find and replace text in a file using the Windows command-line environment? (score [823252](https://stackoverflow.com/q/60034) in 2018)

#### Question
I am writing a batch file script using Windows command-line environment and want to change each occurrence of some text in a file (ex. "FOO") with another (ex. "BAR"). What is the simplest way to do that? Any built in functions?  

#### Answer accepted (score 279)
A lot of the answers here helped point me in the right direction, however none were suitable for me, so I am posting my solution.  

I have Windows 7, which comes with PowerShell built-in. Here is the script I used to find/replace all instances of text in a file:  

```sh
powershell -Command "(gc myFile.txt) -replace 'foo', 'bar' | Out-File -encoding ASCII myFile.txt"
```

To explain it:  

<ul>
<li>`powershell` starts up powershell.exe, which is included in Windows 7</li>
<li>`-Command "... "` is a command line arg for powershell.exe containing the command to run</li>
<li>`(gc myFile.txt)` reads the content of `myFile.txt` (`gc` is short for the `Get-Content` command)</li>
<li>`-replace 'foo', 'bar'` simply runs the replace command to replace `foo` with `bar`</li>
<li>`| Out-File myFile.txt` pipes the output to the file `myFile.txt`</li>
<li>`-encoding ASCII` prevents transcribing the output file to unicode, as the comments point out</li>
</ul>

Powershell.exe should be part of your PATH statement already, but if not you can add it. The location of it on my machine is `C:\WINDOWS\system32\WindowsPowerShell\v1.0`  

#### Answer 2 (score 180)
If you are on Windows version that supports .Net 2.0, I would replace your shell.  <a href="http://en.wikipedia.org/wiki/Windows_PowerShell" rel="noreferrer">PowerShell</a> gives you the full power of .Net from the command line.  There are many commandlets built in as well.  The example below will solve your question.  I'm using the full names of the commands, there are shorter aliases, but this gives you something to Google for.  

```sh
(Get-Content test.txt) | ForEach-Object { $_ -replace "foo", "bar" } | Set-Content test2.txt
```

#### Answer 3 (score 156)
<p>Just used <strong><a href="http://fart-it.sourceforge.net/" rel="noreferrer">FART</a></strong> ("<strong>F</strong> ind <strong>A</strong> nd <strong>R</strong> eplace <strong>T</strong> ext" command line utility):<br>
excellent little freeware for text replacement within a large set of files.</p>

The setup files <a href="http://sourceforge.net/projects/fart-it/files/" rel="noreferrer">are on SourceForge</a>.  

Usage example:  

```sh
fart.exe -p -r -c -- C:\tools\perl-5.8.9\* @@APP_DIR@@ C:\tools
```

will preview the replacements to do recursively in the files of this Perl distribution.  

Only problem: the FART website icon isn't exactly tasteful, refined or elegant ;)  

<hr>

Update 2017 (7 years later) <a href="https://stackoverflow.com/users/3217130/jagb">jagb</a> points out <a href="https://stackoverflow.com/questions/60034/how-can-you-find-and-replace-text-in-a-file-using-the-windows-command-line-envir/2363075#comment72538743_2363075">in the comments</a> to the 2011 article "<a href="https://emtunc.org/blog/03/2011/farting-the-easy-way-find-and-replace-text/" rel="noreferrer">FARTing the Easy Way – Find And Replace Text</a>" from <a href="https://emtunc.org/blog/about/" rel="noreferrer">Mikail Tunç</a>   

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: How to export/import PuTTy sessions list? (score [813310](https://stackoverflow.com/q/13023920) in 2018)

#### Question
Is there a way to do this?  

Or I have to take manually every record from Registry?  

#### Answer accepted (score 1159)
<h5>Export</h1>

<h5>`cmd.exe`, <em>require</em> elevated prompt:</h2>

Only sessions:  

```sh
regedit /e "%USERPROFILE%\Desktop\putty-sessions.reg" HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions
```

All settings:  

```sh
regedit /e "%USERPROFILE%\Desktop\putty.reg" HKEY_CURRENT_USER\Software\SimonTatham
```

<hr>

<h5>Powershell:</h2>

Only sessions:  

```sh
reg export HKCU\Software\SimonTatham\PuTTY\Sessions ([Environment]::GetFolderPath("Desktop") + "\putty-sessions.reg")
```

All settings:  

```sh
reg export HKCU\Software\SimonTatham ([Environment]::GetFolderPath("Desktop") + "\putty.reg")
```

<hr>

<h5>Import</h1>

Double-click on the `*.reg` file and accept the import.  

<h5>Alternative ways:</h2>

<h5>`cmd.exe`, <em>require</em> elevated command prompt:</h3>

```sh
regedit /i putty-sessions.reg
regedit /i putty.reg
```

<h5>PowerShell:</h3>

```sh
reg import putty-sessions.reg
reg import putty.reg
```

<hr>

<em>Note</em>: <strong>do not replace</strong> `SimonTatham` with your username.  

<em>Note</em>: It will create a `reg` file on the Desktop of the current user.  

<em>Note</em>: It will <strong>not</strong> export related SSH keys.  

#### Answer 2 (score 40)
When I tried the other solutions I got this error:  

```sh
Registry editing has been disabled by your administrator.
```

Phooey to that, I say!  

I put together the below powershell scripts for exporting and importing PuTTY settings. The exported file is a windows .reg file and will import cleanly if you have permission, otherwise use import.ps1 to load it.  

<strong>Warning</strong>: messing with the registry like this is a Bad Idea™, and I don't really know what I'm doing. Use the  below scripts at your own risk, and be prepared to have your IT department re-image your machine and ask you uncomfortable questions about what you were doing.  

On the source machine:  

```sh
.\export.ps1
```

On the target machine:  

```sh
.\import.ps1 > cmd.ps1
# Examine cmd.ps1 to ensure it doesn't do anything nasty
.\cmd.ps1
```

export.ps1  

```sh
# All settings
$registry_path = "HKCU:\Software\SimonTatham"
# Only sessions
#$registry_path = "HKCU:\Software\SimonTatham\PuTTY\Sessions"
$output_file = "putty.reg"

$registry = ls "$registry_path" -Recurse

"Windows Registry Editor Version 5.00" | Out-File putty.reg
"" | Out-File putty.reg -Append

foreach ($reg in $registry) {
  "[$reg]" | Out-File putty.reg -Append
  foreach ($prop in $reg.property) {
    $propval = $reg.GetValue($prop)
    if ("".GetType().Equals($propval.GetType())) {
      '"' + "$prop" + '"' + "=" + '"' + "$propval" + '"' | Out-File putty.reg -Append
    } elseif ($propval -is [int]) {
      $hex = "{0:x8}" -f $propval
      '"' + "$prop" + '"' + "=dword:" + $hex | Out-File putty.reg -Append
    }
  }
  "" | Out-File putty.reg -Append
}
```

import.ps1  

```sh
$input_file = "putty.reg"

$content = Get-Content "$input_file"

"Push-Location"
"cd HKCU:\"

foreach ($line in $content) { 
  If ($line.StartsWith("Windows Registry Editor")) {
    # Ignore the header
  } ElseIf ($line.startswith("[")) {
    $section = $line.Trim().Trim('[', ']')
    'New-Item -Path "' + $section + '" -Force' | %{ $_ -replace 'HKEY_CURRENT_USER\\', '' }
  } ElseIf ($line.startswith('"')) {
    $linesplit = $line.split('=', 2)
    $key = $linesplit[0].Trim('"')
    if ($linesplit[1].StartsWith('"')) {
      $value = $linesplit[1].Trim().Trim('"')
    } ElseIf ($linesplit[1].StartsWith('dword:')) {
      $value = [Int32]('0x' + $linesplit[1].Trim().Split(':', 2)[1])
      'New-ItemProperty "' + $section + '" "' + $key + '" -PropertyType dword -Force' | %{ $_ -replace 'HKEY_CURRENT_USER\\', '' }
    } Else {
      Write-Host "Error: unknown property type: $linesplit[1]"
      exit
    }
    'Set-ItemProperty -Path "' + $section + '" -Name "' + $key + '" -Value "' + $value + '"' | %{ $_ -replace 'HKEY_CURRENT_USER\\', '' }
  }
}

"Pop-Location"
```

Apologies for the non-idiomatic code, I'm not very familiar with Powershell. Improvements are welcome!  

#### Answer 3 (score 38)
<ol>
<li><p>Launch Run, 
then type in the Open drop down window: regedit                            </p></li>
<li><p>Navigate to, just like in Window's Explorer:<br>
HKEY_CURRENT_USER\Software\SimonTatham                                     </p></li>
<li>Right click on 'SimonTatham' key (directory icon), select Export<br>
Give the file a name (say) putty.reg and save it to your location for<br>
later use.                                                                 </li>
<li>Close Registry Editor.</li>
</ol>

Done.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: How do I run two commands in one line in Windows CMD? (score [807691](https://stackoverflow.com/q/8055371) in 2018)

#### Question
I want to run two commands in a Windows CMD console.  

In Linux I would do it like this  

```sh
touch thisfile ; ls -lstrh
```

How is it done on Windows?  

#### Answer accepted (score 1158)
Like this on all Microsoft OSes since 2000, and still good today:  

```sh
dir & echo foo
```

If you want the second command to execute only if the first exited successfully:  

```sh
dir && echo foo
```

The single ampersand (&amp;) syntax to execute multiple commands on one line goes back to Windows XP, Windows 2000, and some earlier NT versions. (4.0 at least, according to one commenter here.)  

There are quite a few other points about this that you'll find scrolling down this page.  

Historical data follows, for those who may find it educational.  

Prior to that, the &amp;&amp; syntax was only a feature of the shell replacement 4DOS before that feature was added to the Microsoft command interpreter.  

In Windows 95, 98 and ME, you'd use the pipe character instead:  

```sh
dir | echo foo
```

In MS-DOS 5.0 and later, through some earlier Windows and NT versions of the command interpreter, the (undocumented) command separator was character 20 (Ctrl+T) which I'll represent with ^T here.  

```sh
dir ^T echo foo
```

#### Answer 2 (score 546)
A quote from the documentation:  

<ul>
<li>Source: Microsoft, Windows XP Professional Product Documentation, <a href="https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-xp/bb490954(v=technet.10)" rel="noreferrer"><em>Command shell overview</em></a></li>
</ul>

<blockquote>
  <em>Using multiple commands and conditional processing symbols</em>  
  
  You can run multiple commands from a single command line or script using conditional processing symbols. When you run multiple commands with conditional processing symbols, the commands to the right of the conditional processing symbol act based upon the results of the command to the left of the conditional processing symbol.   
  
  For example, you might want to run a command only if the previous command fails. Or, you might want to run a command only if the previous command is successful.  
  
  You can use the special characters listed in the following table to pass multiple commands.  
  
  <ul>
  <li><p>`&amp; [...]`<br>
  `command1 &amp; command2`<br>
  Use to separate multiple commands on one command line. Cmd.exe runs the first command, and then the second command.</p></li>
  <li><p>`&amp;&amp; [...]`<br>
  `command1 &amp;&amp; command2`<br>
  Use to run the command following &amp;&amp; only if the command preceding the symbol is successful. Cmd.exe runs the first command, and then runs the second command only if the first command completed successfully. </p></li>
  <li><p>`|| [...]`<br>
  `command1 || command2`<br>
  Use to run the command following || only if the command preceding || fails. Cmd.exe runs the first command, and then runs the second command only if the first command did not complete successfully (receives an error code greater than zero).</p></li>
  <li><p>`( ) [...]`<br>
  `(command1 &amp; command2)`<br>
  Use to group or nest multiple commands.</p></li>
  <li><p>`; or ,`<br>
  `command1 parameter1;parameter2`<br>
  Use to separate command parameters.</p></li>
  </ul>
</blockquote>

#### Answer 3 (score 70)
`&amp;` is the Bash equivalent for `;` ( run commands) and `&amp;&amp;` is the Bash equivalent of `&amp;&amp;` (run commands only when the previous has not caused an error).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: Batch script loop (score [780981](https://stackoverflow.com/q/2591758) in 2018)

#### Question
I need to execute a command 100-200 times, and so far my research indicates that I would either have to copy/paste 100 copies of this command, OR use a `for` loop, but the `for` loop expects a list of items, hence I would need 200 files to operate on, or a list of 200 items, defeating the point.  

I would rather not have to write a C program and go through the length of documenting why I had to write another program to execute my program for test purposes. Modification of my program itself is also not an option.  

<strong>So, given a command, `a`, how would I execute it `N` times via a batch script?</strong>  

#### Answer accepted (score 492)
`for /l` is your friend:  

```sh
for /l %x in (1, 1, 100) do echo %x
```

Starts at 1, steps by one, and finishes at 100.  

Use two `%`s if it's in a batch file  

```sh
for /l %%x in (1, 1, 100) do echo %%x
```

(which is one of the things I really really hate about windows scripting)  

If you have multiple commands for each iteration of the loop, do this:  

```sh
for /l %x in (1, 1, 100) do (
   echo %x
   copy %x.txt z:\whatever\etc
)
```

or in a batch file  

```sh
for /l %%x in (1, 1, 100) do (
   echo %%x
   copy %%x.txt z:\whatever\etc
)
```

<p>Key:<br>
`/l` denotes that the `for` command will operate in a numerical fashion, rather than operating on a set of files<br>
`%x` is the loops variable<br>
(starting value, increment of value, end condition[inclusive] )</p>

#### Answer 2 (score 61)
And to iterate on the files of a directory:  

```sh
@echo off 
setlocal enableDelayedExpansion 

set MYDIR=C:\something
for /F %%x in ('dir /B/D %MYDIR%') do (
  set FILENAME=%MYDIR%\%%x\log\IL_ERROR.log
  echo ===========================  Search in !FILENAME! ===========================
  c:\utils\grep motiv !FILENAME!
)
```

You must use "enableDelayedExpansion" and !FILENAME! instead of $FILENAME$. In the second case, DOS will interpret the variable only once (before it enters the loop) and not each time the program loops.  

#### Answer 3 (score 19)
Template for a simple but counted loop:  

```sh
set loopcount=[Number of times]
:loop
[Commands you want to repeat]
set /a loopcount=loopcount-1
if %loopcount%==0 goto exitloop
goto loop
:exitloop
```

Example: Say "Hello World!" 5 times:  

```sh
@echo off
set loopcount=5
:loop
echo Hello World!
set /a loopcount=loopcount-1
if %loopcount%==0 goto exitloop
goto loop
:exitloop
pause
```

This example will output:  

```sh
Hello World!
Hello World!
Hello World!
Hello World!
Hello World!
Press any key to continue . . .
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: How to run a hello.js file in Node.js on windows? (score [771257](https://stackoverflow.com/q/6737824) in 2016)

#### Question
I am trying to run a hello world program written in javascript in a separate file named hello.js  

Currently running windows version of node.js.  

The code runs perfectly in console window but <strong>how do I reference the path in windows environment</strong>.  

```sh
C:\abc\zyx\hello.js
```

in Unix I guess it is showing $ node hello.js  

I'm absolutely new to Node.js Please correct me if I am doing something wrong.  

I tried   

`&gt; node  C:\abc\zyx\hello.js` ----didn't work  

`&gt; C:\abc\zyx\hello.js` --didn't work  

<strong>UPDATE1:</strong>  

<p>Added node.exe to the folder where hello.js file is sitting.<br>
Added path point to the folder c:\abc\zyx\  and I get an error that says </p>

ReferenceError: hello is not defined  

see contents of hello.js   

```sh
setTimeout(function() {
console.log('World!');
}, 2000);
console.log('Hello');
```

<strong>UPDATE 2:</strong>  

So far I have tried all these version and <strong>none of them seems to work</strong>.  May be I am doing something completely wrong.  

```sh
>node hello.js
>$ node hello.js
>node.exe hello.js
>node /hello.js
>node \hello.js
> \node \hello.js
> /node /hello.js
> C:\abc\xyz\node.exe C:\abc\xyz\hello.js
> C:\abc\xyz\node.exe C:/abc/xyz/hello.js
> hello.js
> /hello.js
> \hello.js
>node hello
```

<strong>Refer to my file structure</strong>  

<img src="https://i.stack.imgur.com/fTUNt.jpg" alt="enter image description here">  

<p><strong>RESOLVED:</strong>
Instead of running node.exe, try running in command prompt with the following option and it worked.</p>

```sh
c:\>node c:\abc\hello.js
Hello
World! (after 2 secs)
```

#### Answer accepted (score 342)
Here are the exact steps I just took to run the "Hello World" example found at <a href="http://nodejs.org/">http://nodejs.org/</a>. This is a quick and dirty example. For a permanent installation you'd want to store the executable in a more reasonable place than the root directory and update your `PATH` to include its location.  

<ol>
<li>Download the Windows executable here: <a href="http://nodejs.org/#download">http://nodejs.org/#download</a></li>
<li>Copy the file to C:\</li>
<li>Create C:\hello.js</li>
<li>Paste in the following content:</li>
</ol>

```sh
    var http = require('http');
    http.createServer(function (req, res) {
      res.writeHead(200, {'Content-Type': 'text/plain'});
      res.end('Hello World\n');
    }).listen(1337, "127.0.0.1");
    console.log('Server running at http://127.0.0.1:1337/');
```

<ol>
<li>Save the file</li>
<li>Start -> Run... -> cmd</li>
<li>c:</li>
<li><p>C:>node hello.js</p>

```sh
Server running at http://127.0.0.1:1337/
```</li>
</ol>

That's it. This was done on Windows XP.  

#### Answer 2 (score 33)
<p>Install the MSI file:
Go to the installed directory `C:\Program Files\nodejs` from command prompt n </p>

`C:\&gt;cd C:\Program Files\nodejs enter..`  

`node helloworld.js`  

output:  

`Hello World`  

#### Answer 3 (score 27)
You need to make sure that `node` is in your `PATH`. To set up your path, <a href="http://geekswithblogs.net/renso/archive/2009/10/21/how-to-set-the-windows-path-in-windows-7.aspx." rel="nofollow noreferrer">this out</a>.  

<p>Make sure that the directory that has `node.exe` is in your `PATH`. Then you should be able to 
run `node path_to_js_file.js`.</p>

For a good "Hello World" example, check out: <a href="http://howtonode.org/hello-node" rel="nofollow noreferrer">http://howtonode.org/hello-node</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: Format date and time in a Windows batch script (score [767861](https://stackoverflow.com/q/1192476) in 2017)

#### Question
In a Windows (Windows&nbsp;XP) batch script I need to format the current date and time for later use in files names, etc.  

It is similar to Stack Overflow question <em><a href="https://stackoverflow.com/questions/864718/how-to-append-a-date-in-batch-files">How to append a date in batch files</a></em>, but with time in as well.  

I have this so far:  

```sh
echo %DATE%
echo %TIME%
set datetimef=%date:~-4%_%date:~3,2%_%date:~0,2%__%time:~0,2%_%time:~3,2%_%time:~6,2%
echo %datetimef%
```

which gives:  

```sh
28/07/2009
 8:35:31.01
2009_07_28__ 8_36_01
```

Is there a way I can allow for a single digit hour in %TIME%, so I can get the following?  

```sh
2009_07_28__08_36_01
```

#### Answer accepted (score 141)
I ended up with this script:  

```sh
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
echo hour=%hour%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
echo min=%min%
set secs=%time:~6,2%
if "%secs:~0,1%" == " " set secs=0%secs:~1,1%
echo secs=%secs%

set year=%date:~-4%
echo year=%year%
```

:: On WIN2008R2 e.g. I needed to make your 'set month=%date:~3,2%' like below ::otherwise 00 appears for MONTH  

```sh
set month=%date:~4,2%
if "%month:~0,1%" == " " set month=0%month:~1,1%
echo month=%month%
set day=%date:~0,2%
if "%day:~0,1%" == " " set day=0%day:~1,1%
echo day=%day%

set datetimef=%year%%month%%day%_%hour%%min%%secs%

echo datetimef=%datetimef%
```

#### Answer 2 (score 70)
```sh
@ECHO OFF
: Sets the proper date and time stamp with 24Hr Time for log file naming
: convention

SET HOUR=%time:~0,2%
SET dtStamp9=%date:~-4%%date:~4,2%%date:~7,2%_0%time:~1,1%%time:~3,2%%time:~6,2% 
SET dtStamp24=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%

if "%HOUR:~0,1%" == " " (SET dtStamp=%dtStamp9%) else (SET dtStamp=%dtStamp24%)

ECHO %dtStamp%

PAUSE
```

#### Answer 3 (score 60)
Here is how I generate a log filename (based on <a href="http://ss64.com/nt/syntax-getdate.html">http://ss64.com/nt/syntax-getdate.html</a>):  

```sh
@ECHO OFF
:: Check WMIC is available
WMIC.EXE Alias /? >NUL 2>&1 || GOTO s_error

:: Use WMIC to retrieve date and time
FOR /F "skip=1 tokens=1-6" %%G IN ('WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year /Format:table') DO (
   IF "%%~L"=="" goto s_done
      Set _yyyy=%%L
      Set _mm=00%%J
      Set _dd=00%%G
      Set _hour=00%%H
      SET _minute=00%%I
      SET _second=00%%K
)
:s_done

:: Pad digits with leading zeros
      Set _mm=%_mm:~-2%
      Set _dd=%_dd:~-2%
      Set _hour=%_hour:~-2%
      Set _minute=%_minute:~-2%
      Set _second=%_second:~-2%

Set logtimestamp=%_yyyy%-%_mm%-%_dd%_%_hour%_%_minute%_%_second%
goto make_dump

:s_error
echo WMIC is not available, using default log filename
Set logtimestamp=_

:make_dump
set FILENAME=database_dump_%logtimestamp%.sql
...
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: Stop and Start a service via batch or cmd file? (score [767352](https://stackoverflow.com/q/133883) in 2009)

#### Question
How can I script a bat or cmd to stop and start a service reliably with error checking (or let me know that it wasn't successful for whatever reason)?  

#### Answer accepted (score 345)
Use the `SC` (service control) command, it gives you a lot more options than just `start` &amp; `stop`.  

<pre>
  DESCRIPTION:
          SC is a command line program used for communicating with the
          NT Service Controller and services.
  USAGE:
      sc &lt;server&gt; [command] [service name]  ...

      The option &lt;server&gt; has the form "\\ServerName"
      Further help on commands can be obtained by typing: "sc [command]"
      Commands:
        query-----------Queries the status for a service, or
                        enumerates the status for types of services.
        queryex---------Queries the extended status for a service, or
                        enumerates the status for types of services.
        start-----------Starts a service.
        pause-----------Sends a PAUSE control request to a service.
        interrogate-----Sends an INTERROGATE control request to a service.
        continue--------Sends a CONTINUE control request to a service.
        stop------------Sends a STOP request to a service.
        config----------Changes the configuration of a service (persistant).
        description-----Changes the description of a service.
        failure---------Changes the actions taken by a service upon failure.
        qc--------------Queries the configuration information for a service.
        qdescription----Queries the description for a service.
        qfailure--------Queries the actions taken by a service upon failure.
        delete----------Deletes a service (from the registry).
        create----------Creates a service. (adds it to the registry).
        control---------Sends a control to a service.
        sdshow----------Displays a service's security descriptor.
        sdset-----------Sets a service's security descriptor.
        GetDisplayName--Gets the DisplayName for a service.
        GetKeyName------Gets the ServiceKeyName for a service.
        EnumDepend------Enumerates Service Dependencies.

      The following commands don't require a service name:
      sc &lt;server&gt; &lt;command&gt; &lt;option&gt;
        boot------------(ok | bad) Indicates whether the last boot should
                        be saved as the last-known-good boot configuration
        Lock------------Locks the Service Database
        QueryLock-------Queries the LockStatus for the SCManager Database
  EXAMPLE:
          sc start MyService
</pre>

#### Answer 2 (score 206)
```sh
net start [serviceName]
```

and  

```sh
net stop [serviceName]
```

tell you whether they have succeeded or failed pretty clearly. For example  

```sh
U:\>net stop alerter
The Alerter service is not started.

More help is available by typing NET HELPMSG 3521.
```

If running from a batch file, you have access to the ERRORLEVEL of the return code. 0 indicates success. Anything higher indicates failure.  

As a bat file, `error.bat`:  

```sh
@echo off
net stop alerter
if ERRORLEVEL 1 goto error
exit
:error
echo There was a problem
pause
```

The output looks like this:  

```sh
U:\>error.bat
The Alerter service is not started.

More help is available by typing NET HELPMSG 3521.

There was a problem
Press any key to continue . . .
```

<strong>Return Codes</strong>  

```sh
 - 0 = Success
 - 1 = Not Supported
 - 2 = Access Denied
 - 3 = Dependent Services Running
 - 4 = Invalid Service Control
 - 5 = Service Cannot Accept Control
 - 6 = Service Not Active
 - 7 = Service Request Timeout
 - 8 = Unknown Failure
 - 9 = Path Not Found
 - 10 = Service Already Running
 - 11 = Service Database Locked
 - 12 = Service Dependency Deleted
 - 13 = Service Dependency Failure
 - 14 = Service Disabled
 - 15 = Service Logon Failure
 - 16 = Service Marked For Deletion
 - 17 = Service No Thread
 - 18 = Status Circular Dependency
 - 19 = Status Duplicate Name
 - 20 = Status Invalid Name
 - 21 = Status Invalid Parameter 
 - 22 = Status Invalid Service Account
 - 23 = Status Service Exists
 - 24 = Service Already Paused
```

<strong>Edit 20.04.2015</strong>  

Return Codes:    

<blockquote>
  The NET command does not return the documented Win32_Service class return codes (Service Not Active,Service Request Timeout, etc) and for many errors will simply return Errorlevel 2.  
</blockquote>

Look here: <a href="http://ss64.com/nt/net_service.html" rel="noreferrer">http://ss64.com/nt/net_service.html</a>  

#### Answer 3 (score 28)
You can use the NET START command and then check the ERRORLEVEL environment variable, e.g.  

```sh
net start [your service]
if %errorlevel% == 2 echo Could not start service.
if %errorlevel% == 0 echo Service started successfully.
echo Errorlevel: %errorlevel%
```

Disclaimer: I've written this from the top of my head, but I think it'll work.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: Run cURL commands from Windows console (score [738476](https://stackoverflow.com/q/2710748) in 2013)

#### Question
Is there a way to install cURL in Windows in order to run cURL commands from the command prompt?  

#### Answer accepted (score 448)
If you are not into <a href="https://en.wikipedia.org/wiki/Cygwin" rel="noreferrer">Cygwin</a>, you can use native Windows builds. Some are here: <a href="https://curl.haxx.se/dlwiz/?type=bin&amp;os=Win32&amp;flav=-&amp;ver=2000%2FXP" rel="noreferrer">curl Download Wizard</a>.  

#### Answer 2 (score 164)
<p>First you need to download the cURL executable. For Windows 64bit, download it from <a href="https://curl.haxx.se/dlwiz/?type=bin&amp;os=Win64" rel="noreferrer">here</a> and for Windows 32bit download from <a href="https://curl.haxx.se/dlwiz/?type=bin&amp;os=Win32" rel="noreferrer">here</a> 
After that, save the `curl.exe` file on your `C:` drive.</p>

To use it, just open the `command prompt` and type in:  

```sh
C:\curl http://someurl.com
```

#### Answer 3 (score 136)
If you have `Git` installed on windows you can use the `GNU Bash`.... it's built in.  

<a href="https://superuser.com/questions/134685/run-curl-commands-from-windows-console/#483964">https://superuser.com/questions/134685/run-curl-commands-from-windows-console/#483964</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How can I open a cmd window in a specific location? (score [735230](https://stackoverflow.com/q/60904) in 2017)

#### Question
How can I open a cmd window in a specific location without having to navigate all the way to the directory I want?  

#### Answer accepted (score 62)
You may want to look at <a href="http://go.microsoft.com/fwlink/?LinkId=211471" rel="noreferrer">this "PowerToy" from Microsoft</a>:  

<blockquote>
  <strong>Open Command Window Here</strong>  
  
  <p>This PowerToy adds an "Open Command
  Window Here" context menu option on
  file system folders, giving you a
  quick way to open a command window
  (cmd.exe) pointing at the selected
  folder.</p>
</blockquote>

<strong>EDIT :</strong> This software will not function on a version of Windows earlier or later than Windows XP.  

<a href="https://i.stack.imgur.com/sdXWW.png" rel="noreferrer"><img src="https://i.stack.imgur.com/sdXWW.png" alt="enter image description here"></a>  

#### Answer 2 (score 470)
This might be what you want:   

```sh
cmd /K "cd C:\Windows\"
```

Note that in order to change drive letters, you need to use `cd /d`. For example:  

```sh
C:\Windows\System32\cmd.exe /K "cd /d H:\Python\"
```

<a href="http://ss64.com/nt/cd.html" rel="noreferrer">(documentation)</a>  

#### Answer 3 (score 295)
If you have Windows Vista or later, right-click on the folder icon in Explorer while holding the Shift key, and then click on the "Open command window here" or "Open PowerShell window here" context menu option.   

If you're already in the folder you want, you can do one of the following:  

<ul>
<li>[only Win8+] Click the Explorer Ribbon's File button, then click on "Open command window here" or "Open PowerShell window here".</li>
<li><kbd>Shift</kbd>-<kbd>right-click</kbd> on the background of the Explorer window, then click on "Open command window here" or "Open PowerShell window here". (recommended by Kate in the comments)</li>
<li>[only Vista or Win7] Hold down Shift when opening the Explorer File menu, then click on "Open command window here". If you can't see the menu bar, open the File menu by pressing <kbd>Alt</kbd>-<kbd>Shift</kbd>-<kbd>F</kbd> - <kbd>Alt</kbd>-<kbd>F</kbd> to open the File menu, plus <kbd>Shift</kbd>.</li>
</ul>

For Windows XP, <a href="https://stackoverflow.com/a/60905/1879">use the PowerToy mentioned by dF</a> to get the same function.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: How to create .pfx file from certificate and private key? (score [722231](https://stackoverflow.com/q/6307886) in 2016)

#### Question
I need .pfx file to install https on website on IIS.   

I have two separate files: certificate (.cer or pem) and private key (.crt) but IIS accepts only .pfx files.  

I obviously installed certificate and it is available in certificate manager (mmc) but when I select Certificate Export Wizard I cannot select PFX format (it's greyed out)  

Are there any tools to do that or C# examples of doing that programtically?  

#### Answer 2 (score 485)
You will need to use openssl.  

`openssl pkcs12 -export -out domain.name.pfx -inkey domain.name.key -in domain.name.crt`  

The key file is just a text file with your private key in it.  

If you have a root CA and intermediate certs, then include them as well using multiple `-in` params  

`openssl pkcs12 -export -out domain.name.pfx -inkey domain.name.key -in domain.name.crt -in intermediate.crt -in rootca.crt`  

You can install openssl from here: <a href="https://wiki.openssl.org/index.php/Binaries" rel="noreferrer">openssl</a>  

#### Answer 3 (score 36)
The Microsoft Pvk2Pfx command line utility seems to have the functionality you need:    

<p>Pvk2Pfx (Pvk2Pfx.exe) is a command-line tool copies public key and private key information contained in .spc, .cer, and .pvk files to a Personal Information Exchange (.pfx) file.<br>
<a href="http://msdn.microsoft.com/en-us/library/windows/hardware/ff550672(v=vs.85).aspx">http://msdn.microsoft.com/en-us/library/windows/hardware/ff550672(v=vs.85).aspx</a>  </p>

Note: if you need/want/prefer a C# solution, then you may want to consider using the <a href="http://www.bouncycastle.org/">http://www.bouncycastle.org/</a> api.    

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: How do I uninstall a Windows service if the files do not exist anymore? (score [714336](https://stackoverflow.com/q/197876) in 2015)

#### Question
How do I uninstall a .NET Windows Service, if the service files does not exists anymore?  

I installed a .NET Windows Service using InstallUtil. I have since deleted the files but forgot to run  

```sh
 InstallUtil /u
```

first. So the service is still listed in the Services MMC.  

Do I have to go into the registry? Or is there a better way?  

#### Answer accepted (score 1111)
You have at least three options. I have presented them in order of usage preference.  

<p><strong>Method 1</strong> -  You can use the <a href="http://support.microsoft.com/kb/251192" rel="noreferrer">SC tool</a> (Sc.exe) included in the Resource Kit. 
(included with Windows 7/8)</p>

Open a Command Prompt and enter  

```sh
sc delete <service-name>
```

Tool help snippet follows:  

```sh
DESCRIPTION:
        SC is a command line program used for communicating with the
        NT Service Controller and services.

delete----------Deletes a service (from the registry).
```

<strong>Method 2</strong> - use delserv  

<a href="http://support.microsoft.com/kb/927229" rel="noreferrer">Download</a> and use delserv command line utility. This is a legacy tool developed for Windows 2000. In current Window XP boxes this was superseded by sc described in method 1.  

<strong>Method 3</strong> - manually delete registry entries <strong>(Note that this backfires in Windows 7/8)</strong>  

Windows services are registered under the following registry key.  

```sh
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services
```

Search for the sub-key with the service name under referred key and delete it. (and you might need to restart to remove completely the service from the Services list)  

#### Answer 2 (score 165)
From the command prompt, use the Windows "sc.exe" utility.  You will run something like this:  

```sh
sc delete <service-name>
```

#### Answer 3 (score 27)
Notes on using "sc delete" in Windows 8:    

<p>1) Open a CMD window with elevated privileges.  [Windows Key-X to bring up a menu with the option; select "Command Prompt (Admin)".]<br>
2) Use the parenthetical name from the list in Services [for example, I used "sc delete gupdate" when, in Services, it read "Google Update (gupdate)"]</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: How do I get the application exit code from a Windows command line? (score [700869](https://stackoverflow.com/q/334879) in )

#### Question
I am running a program and want to see what its return code is (since it returns different codes based on different errors).  

I know in Bash I can do this by running  

<blockquote>
  echo $?  
</blockquote>

What do I do when using cmd.exe on Windows?  

#### Answer accepted (score 918)
A pseudo environment variable named `errorlevel` stores the exit code:  

```sh
echo Exit Code is %errorlevel%
```

Also, the `if` command has a special syntax:  

```sh
if errorlevel
```

See `if /?` for details.  

<h5>Example</h1>

```sh
@echo off
my_nify_exe.exe
if errorlevel 1 (
   echo Failure Reason Given is %errorlevel%
   exit /b %errorlevel%
)
```

<em>Warning: If you set an environment variable name `errorlevel`, `%errorlevel%` will return that value and not the exit code. Use (`set errorlevel=`) to clear the environment variable, allowing access to the true value of `errorlevel` via the `%errorlevel%` environment variable.</em>  

#### Answer 2 (score 252)
Testing `ErrorLevel` works for <em>console</em> applications, but as hinted at <a href="https://stackoverflow.com/a/3119934/4518341">by dmihailescu</a>, this won't work if you're trying to run a <em>windowed</em> application (e.g. Win32-based) from a command prompt.  A windowed application will run in the background, and control will return immediately to the command prompt (most likely with an `ErrorLevel` of zero to indicate that the process was <em>created</em> successfully).  When a windowed application eventually exits, its exit status is lost.  

Instead of using the console-based C++ launcher mentioned elsewhere, though, a simpler alternative is to start a windowed application using the command prompt's `START /WAIT` command.  This will start the windowed application, wait for it to exit, and then return control to the command prompt with the exit status of the process set in `ErrorLevel`.  

```sh
start /wait something.exe
echo %errorlevel%
```

#### Answer 3 (score 95)
Use the built-in ERRORLEVEL Variable:  

```sh
echo %ERRORLEVEL%
```

But <a href="https://web.archive.org/web/20190109201338/https://blogs.msdn.microsoft.com/oldnewthing/20080926-00/?p=20743/" rel="nofollow noreferrer">beware if an application has defined an environment variable named ERRORLEVEL</a>!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How can you zip or unzip from the script using ONLY Windows' built-in capabilities? (score [686318](https://stackoverflow.com/q/17546016) in 2019)

#### Question
In Windows you can zip some files by   

<blockquote>
  right click &rarr; <em>Send to</em> &rarr; <em>Compressed (zipped) folder</em>  
</blockquote>

And unzip by double clicking on the `.zip` file and extract the files.  

Is there a way to apply those abilities from a script (.bat file) <strong>without the need to install any third-party software</strong>?  

#### Answer accepted (score 77)
Back in 2013, that was not possible. Microsoft didn't provide any executable for this.  

<p>See this link for some VBS way to do this.
<a href="https://superuser.com/questions/201371/create-zip-folder-from-the-command-line-windows">https://superuser.com/questions/201371/create-zip-folder-from-the-command-line-windows</a></p>

<p>From Windows 8 on, .NET Framework 4.5 is installed by default, with <a href="https://msdn.microsoft.com/en-us/library/system.io.compression.ziparchive(v=vs.110).aspx" rel="nofollow noreferrer">System.IO.Compression.ZipArchive</a> and PowerShell available, one can write scripts to achieve this, see
<a href="https://stackoverflow.com/a/26843122/71312">https://stackoverflow.com/a/26843122/71312</a></p>

#### Answer 2 (score 170)
To expand upon Steven Penny's PowerShell solution, you can incorporate it into a batch file by calling powershell.exe like this:  

```sh
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('foo.zip', 'bar'); }"
```

As Ivan Shilo said, this won't work with PowerShell 2, it requires PowerShell 3 or greater and .NET Framework 4.  

#### Answer 3 (score 155)
As of <a href="https://www.microsoft.com/en-us/download/details.aspx?id=30653" rel="noreferrer">.NET 4.5</a>, PowerShell can do this:  

```sh
Add-Type -A System.IO.Compression.FileSystem
[IO.Compression.ZipFile]::CreateFromDirectory('foo', 'foo.zip')
[IO.Compression.ZipFile]::ExtractToDirectory('foo.zip', 'bar')
```

For the last two lines, `bar` and `foo` can be replaced with the name you would like the folder to have, or whatever the name is of the preexisting folder. `foo.zip` in both cases acts as the zip file either to save as or to unzip from.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: How can I run a program from a batch file without leaving the console open after the program starts? (score [675156](https://stackoverflow.com/q/324539) in 2018)

#### Question
For the moment my batch file look like this:  

```sh
myprogram.exe param1
```

The program starts but the DOS Window remains open. How can I close it?  

#### Answer accepted (score 158)
You can use the exit keyword. Here is an example from one of my batch files:  

```sh
start myProgram.exe param1
exit
```

#### Answer 2 (score 243)
<p>Use the start command to prevent the batch file from waiting for the program.  Just remember to put a  empty double quote in front of the program you want to run after "Start".
For example, if you want to run Visual Studio 2012 from a batch command:</p>

```sh
Start ""  "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe"
```

notice the double quote after start.   

#### Answer 3 (score 52)
Look at the START command, you can do this:  

```sh
START rest-of-your-program-name
```

For instance, this batch-file will wait until notepad exits:  

```sh
@echo off
notepad c:\test.txt
```

However, this won't:  

```sh
@echo off
start notepad c:\test.txt
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: How to kill the process currently using a port on localhost in windows? (score [651351](https://stackoverflow.com/q/39632667) in 2019)

#### Question
How to remove current process/application which is already assigned to a port?  

For example: `localhost:8080`  

#### Answer accepted (score 768)
<strong>Step 1</strong>   

<p>Run command-line as an Administrator. Then run the below mention command.
type your port number in <strong>yourPortNumber</strong></p>

<blockquote>
  netstat -ano | findstr :<strong>yourPortNumber</strong>  
</blockquote>

<img src="https://i.stack.imgur.com/lEpCZ.png" alt="">  

Red coloured circled area shows the PID (process identifier)  

<strong>Step 2</strong>  

Then you execute this command after identify the PID.   

<blockquote>
  taskkill /PID <strong>typeyourPIDhere</strong> /F  
</blockquote>

<img src="https://i.stack.imgur.com/8k64x.png" alt="">  

P.S. Run the first command again to check if process is still available or not. You'll get empty line if process is successfully ended.  

#### Answer 2 (score 95)
<em>Step 1 (same is in accepted <a href="https://stackoverflow.com/a/39633428/5292302">answer</a> written by <a href="https://stackoverflow.com/users/3626371/kavinduwije">KavinduWije</a>):</em>  

<blockquote>
```sh
netstat -ano | findstr :yourPortNumber
```
</blockquote>

<em>Change in Step 2 to:</em>  

```sh
tskill typeyourPIDhere 
```

This since `taskkill` is not working in some git bash command  

#### Answer 3 (score 79)
<strong>If you are using GitBash</strong>  

<em>Step one:</em>  

```sh
netstat -ano | findstr :8080
```

<em>Step two:</em>   

```sh
taskkill /PID typeyourPIDhere /F 
```

(`/F` forcefully terminates the process)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: How to get the system uptime in Windows? (score [646905](https://stackoverflow.com/q/11606774) in 2016)

#### Question
I am using windows 7 and xp. I want to know the uptime of the system.  

What is the command / procedure for getting the uptime?  

#### Answer accepted (score 671)
Following are eight ways to find the <strong>Uptime</strong> in Windows OS.  

<h5>1: By using the Task Manager</h1>

In Windows Vista and Windows Server 2008, the Task Manager has been beefed up to show additional information about the system. One of these pieces of info is the server’s running time.  

<ol>
<li>Right-click on the Taskbar, and click Task Manager. You can also click <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>ESC</kbd> to get to the Task Manager.</li>
<li>In Task Manager, select the Performance tab.</li>
<li><p>The current system uptime is shown under System or Performance &rArr; CPU for Win 8/10.</p>

<img src="https://i.stack.imgur.com/ln4Af.png" alt="&quot;Up Time&quot; field in Task Manager">  </li>
</ol>

<h5>2: By using the System Information Utility</h1>

<p>The `systeminfo` command line utility checks and displays various system statistics such as installation date, installed hotfixes and more.
Open a Command Prompt and type the following command:</p>

```sh
systeminfo
```

You can also narrow down the results to just the line you need:  

```sh
systeminfo | find "System Boot Time:"
```

<img src="https://i.stack.imgur.com/viwWl.png" alt="enter image description here">  

<h5>3: By using the Uptime Utility</h1>

Microsoft have published a tool called Uptime.exe. It is a simple command line tool that analyses the computer's reliability and availability information. It can work locally or remotely. In its simple form, the tool will display the current system uptime. An advanced option allows you to access more detailed information such as shutdown, reboots, operating system crashes, and Service Pack installation.  

Read the following KB for more info and for the download links:    

<ul>
<li>MSKB232243: <a href="http://support.microsoft.com/kb/232243" rel="nofollow noreferrer">Uptime.exe Tool Allows You to Estimate Server Availability with Windows NT 4.0 SP4 or Higher</a>.</li>
</ul>

To use it, follow these steps:  

<ol>
<li>Download uptime.exe from the above link, and save it to a folder,
preferably in one that's in the system's path (such as SYSTEM32).</li>
<li>Open an elevated Command Prompt window. To open an elevated Command
Prompt, click Start, click All Programs, click Accessories,
right-click Command Prompt, and then click Run as administrator. You
can also type CMD in the search box of the Start menu, and when you
see the Command Prompt icon click on it to select it, hold
<kbd>CTRL</kbd>+<kbd>SHIFT</kbd> and press <kbd>ENTER</kbd>.</li>
<li>Navigate to where you've placed the uptime.exe utility.</li>
<li>Run the `uptime.exe` utility. You can add a /? to the command in order
to get more options. 
<img src="https://i.stack.imgur.com/56jIB.png" alt="enter image description here"></li>
</ol>

It does not offer many command line parameters:  

```sh
C:\uptimefromcodeplex\> uptime /?
usage: Uptime [-V]
    -V   display version

C:\uptimefromcodeplex\> uptime -V
version 1.1.0
```

<h5>3.1: By using the old Uptime Utility</h1>

There is an older version of the "uptime.exe" utility. This has the advantage of NOT needing .NET. (It also has a lot more features beyond simple uptime.)  

<p>Download link: <a href="https://www.microsoft.com/en-us/download/details.aspx?id=14732" rel="nofollow noreferrer">Windows NT 4.0 Server Uptime Tool (uptime.exe) (final x86)
</a></p>

```sh
C:\uptimev100download>uptime.exe /?

UPTIME, Version 1.00
(C) Copyright 1999, Microsoft Corporation

Uptime [server] [/s ] [/a] [/d:mm/dd/yyyy | /p:n] [/heartbeat] [/? | /help]
        server          Name or IP address of remote server to process.
        /s              Display key system events and statistics.
        /a              Display application failure events (assumes /s).
        /d:             Only calculate for events after mm/dd/yyyy.
        /p:             Only calculate for events in the previous n days.
        /heartbeat      Turn on/off the system's heartbeat
        /?              Basic usage.
        /help           Additional usage information.
```

<h5>4: By using the NET STATISTICS Utility</h1>

<p>Another easy method, if you can remember it, is to use the approximate information found in the statistics displayed by the NET STATISTICS command.
Open a Command Prompt and type the following command:</p>

```sh
net statistics workstation
```

The statistics should tell you how long it’s been running, although in some cases this information is not as accurate as other methods.  

<img src="https://i.stack.imgur.com/aCq6z.png" alt="enter image description here">  

<h5>5: By Using the Event Viewer</h1>

Probably the most accurate of them all, but it does require some clicking. It does not display an exact day or hour count since the last reboot, but it will display important information regarding why the computer was rebooted and when it did so. We need to look at Event ID 6005, which is an event that tells us that the computer has just finished booting, but you should be aware of the fact that there are virtually hundreds if not thousands of other event types that you could potentially learn from.  

Note: BTW, the 6006 Event ID is what tells us when the server has gone down, so if there’s much time difference between the 6006 and 6005 events, the server was down for a long time.  

Note: You can also open the Event Viewer by typing eventvwr.msc in the Run command, and you might as well use the shortcut found in the Administrative tools folder.  

<ol start="2">
<li>Click on Event Viewer (Local) in the left navigation pane.</li>
<li>In the middle pane, click on the Information event type, and scroll down till you see Event ID 6005. Double-click the 6005 Event ID, or right-click it and select View All Instances of This Event.</li>
<li>A list of all instances of the 6005 Event ID will be displayed. You can examine this list, look at the dates and times of each reboot event, and so on.</li>
<li>Open Server  Manager tool by right-clicking the Computer icon on the start menu (or on the Desktop if you have it enabled) and select Manage. Navigate to the Event Viewer.</li>
</ol>

<img src="https://i.stack.imgur.com/qsYTG.png" alt="enter image description here">  

<h5>5.1: Eventlog via PowerShell</h1>

```sh
Get-WinEvent -ProviderName eventlog | Where-Object {$_.Id -eq 6005 -or $_.Id -eq 6006}
```

<h5>6: Programmatically, by using <a href="http://msdn.microsoft.com/en-us/library/windows/desktop/ms724411%28v=vs.85%29.aspx" rel="nofollow noreferrer">GetTickCount64</a></h1>

<blockquote>
  GetTickCount64 retrieves the number of milliseconds that have elapsed since the system was started.  
</blockquote>

<h5>7: By using WMI</h1>

```sh
wmic os get lastbootuptime
```

<h5>8: The new uptime.exe for Windows XP and up</h1>

Like the tool from Microsoft, but compatible with all operating systems up to and including Windows 10 and Windows Server 2016, <a href="https://neosmart.net/blog/2017/uptime-for-windows/" rel="nofollow noreferrer">this uptime utility</a> does not require an elevated command prompt and offers an option to show the uptime in both DD:HH:MM:SS and in human-readable formats (when executed with the `-h` command-line parameter).   

Additionally, this version of `uptime.exe` will run and show the system uptime even when launched normally from within an explorer.exe session (i.e. not via the command line) and pause for the uptime to be read:  

<a href="https://i.stack.imgur.com/QCRJN.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/QCRJN.png" alt="enter image description here"></a>  

and when executed as `uptime -h`:  

<a href="https://i.stack.imgur.com/hwOxd.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/hwOxd.png" alt="enter image description here"></a>  

#### Answer 2 (score 15)
I use this little PowerShell snippet:  

```sh
function Get-SystemUptime {
    $operatingSystem = Get-WmiObject Win32_OperatingSystem
    "$((Get-Date) - ([Management.ManagementDateTimeConverter]::ToDateTime($operatingSystem.LastBootUpTime)))"
}
```

which then yields something like the following:  

```sh
PS> Get-SystemUptime
6.20:40:40.2625526
```

#### Answer 3 (score 7)
Two ways to do that..  

<strong>Option 1:</strong>  

```sh
1.  Go to "Start" -> "Run".

2.  Write "CMD" and press on "Enter" key.

3.  Write the command "net statistics server" and press on "Enter" key.

4.  The line that start with "Statistics since …" provides the time that the server was up from.


  The command "net stats srv" can be use instead.
```

<strong>Option 2:</strong>  

Uptime.exe Tool Allows You to Estimate Server Availability with Windows NT 4.0 SP4 or Higher  

<a href="http://support.microsoft.com/kb/232243" rel="noreferrer">http://support.microsoft.com/kb/232243</a>  

Hope it helped you!!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Check status of one port on remote host (score [640720](https://stackoverflow.com/q/1168317) in 2016)

#### Question
I need a command line that can check the port status on a remote host.  I tried `ping xxx.xxx.xxx.xxx:161` but it doesn't recognize the "host".  I thought it was a "good" answer until I did the same command against a host I know has that port open.  This is for a batch file on Windows that will check the status of the remote port then run a command that uses that remote port for information, then the remote port check command again, then the command that uses that port on the next server for information, and so on. I've looked everywhere and thought the ping might do it, but there must be various versions of ping, I suppose as the server I am doing this on does not show that option.  

Just for chuckles, I tried a web-based remote port checker from a website - and the results were correct for both the "problem" server and the correct server.  However, I can't use that in a batch run with 500+ server IPs in it.    

Is there something I can do that is simple?  My Perl skills are extremely rusty (use it or lose it), don't know any other Windows based languages except batch.  Unix is my skill, but this must be executed from Widows Server 2003.     

#### Answer 2 (score 143)
You seem to be looking for a port scanner such as <a href="http://nmap.org/" rel="noreferrer">nmap</a> or <a href="http://netcat.sourceforge.net/" rel="noreferrer">netcat</a>, both of which are available for Windows, Linux, and Mac OS X.  

For example, check for telnet on a known ip:  

```sh
nmap -A 192.168.0.5/32 -p 23
```

For example, look for open ports from 20 to 30 on host.example.com:  

```sh
nc -z host.example.com 20-30
```

#### Answer 3 (score 122)
<p>In Command Prompt, you can use the command telnet..
For Example, to connect to IP 192.168.10.1 with port 80,</p>

```sh
telnet 192.168.10.1 80
```

To enable telnet in Windows 7 and above <a href="https://www.rootusers.com/how-to-enable-the-telnet-client-in-windows-10/" rel="noreferrer">click</a>. From the linked article, enable telnet through control panel -> programs and features -> windows features -> telnet client, or just run this in an admin prompt:   

```sh
dism /online /Enable-Feature /FeatureName:TelnetClient
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: how to change directory using Windows command line (score [639399](https://stackoverflow.com/q/17753986) in 2017)

#### Question
I'm using `cmd.exe` (C:\WINDOWS\System32\cmd.exe) and I have to change my current directory to "D:\temp" i.e. temp folder in the D drive.  

When I try to `cd` nothing happens.  

```sh
C:\> cd D:\temp

C:\>
```

I don't know what else to do here. Even pressing `tab` key does not give any hints. I have never got the reason to use cmd.exe until now when I have to. I mostly use Linux for development.  

If this helps: I'm on a remote login to another computer and `D:\temp` in on the remote machine, but so is `C:\` where I have opened the terminal (cmd.exe).  

#### Answer accepted (score 283)
The "cd" command changes the directory, but not what drive you are working with. So when you go "cd d:\temp", you are changing the D drive's directory to temp, but staying in the C drive.  

Execute these two commands:  

```sh
D:
cd temp
```

That will get you the results you want.  

#### Answer 2 (score 106)
Another alternative is `pushd`, which will automatically switch drives as needed. It also allows you to return to the previous directory via `popd`:  

```sh
C:\Temp><b>pushd D:\some\folder</b><br>
D:\some\folder><b>popd</b><br>
C:\Temp>_```

#### Answer 3 (score 81)
`cd` has a parameter `/d`, which will change drive and path with one command:  

```sh
cd /d d:\temp
```

( see `cd /?`)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: pip install fails with "connection error: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:598)" (score [634501](https://stackoverflow.com/q/25981703) in 2014)

#### Question
I am very new to Python and trying to `&gt; pip install linkchecker` on Windows 7. Some notes:  

<ul>
<li>pip install is failing no matter the package. For example, `&gt; pip install scrapy` also results in the SSL error.</li>
<li>Vanilla install of Python 3.4.1 included pip 1.5.6. The first thing I tried to do was install linkchecker. Python 2.7 was already installed, it came with ArcGIS. `python` and `pip` were not available from the command line until I installed 3.4.1.</li>
<li>`&gt; pip search linkchecker` works. Perhaps that is because pip search does not verify the site's SSL certificate.</li>
<li>I am in a company network but we do not go through a proxy to reach the Internet.</li>
<li>Each company computer (including mine) has a Trusted Root Certificate Authority that is used for various reasons including enabling monitoring TLS traffic to <a href="https://google.com">https://google.com</a>. Not sure if that has anything to do with it.</li>
</ul>

Here are the contents of my <strong>pip.log</strong> after running `pip install linkchecker`:  

```sh
Downloading/unpacking linkchecker
  Getting page https://pypi.python.org/simple/linkchecker/
  Could not fetch URL https://pypi.python.org/simple/linkchecker/: connection error: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:598)
  Will skip URL https://pypi.python.org/simple/linkchecker/ when looking for download links for linkchecker
  Getting page https://pypi.python.org/simple/
  Could not fetch URL https://pypi.python.org/simple/: connection error: HTTPSConnectionPool(host='pypi.python.org', port=443): Max retries exceeded with url: /simple/ (Caused by <class 'http.client.CannotSendRequest'>: Request-sent)
  Will skip URL https://pypi.python.org/simple/ when looking for download links for linkchecker
  Cannot fetch index base URL https://pypi.python.org/simple/
  URLs to search for versions for linkchecker:
  * https://pypi.python.org/simple/linkchecker/
  Getting page https://pypi.python.org/simple/linkchecker/
  Could not fetch URL https://pypi.python.org/simple/linkchecker/: connection error: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:598)
  Will skip URL https://pypi.python.org/simple/linkchecker/ when looking for download links for linkchecker
  Could not find any downloads that satisfy the requirement linkchecker
Cleaning up...
  Removing temporary dir C:\Users\jcook\AppData\Local\Temp\pip_build_jcook...
No distributions at all found for linkchecker
Exception information:
Traceback (most recent call last):
  File "C:\Python34\lib\site-packages\pip\basecommand.py", line 122, in main
    status = self.run(options, args)
  File "C:\Python34\lib\site-packages\pip\commands\install.py", line 278, in run
    requirement_set.prepare_files(finder, force_root_egg_info=self.bundle, bundle=self.bundle)
  File "C:\Python34\lib\site-packages\pip\req.py", line 1177, in prepare_files
    url = finder.find_requirement(req_to_install, upgrade=self.upgrade)
  File "C:\Python34\lib\site-packages\pip\index.py", line 277, in find_requirement
    raise DistributionNotFound('No distributions at all found for %s' % req)
pip.exceptions.DistributionNotFound: No distributions at all found for linkchecker
```

#### Answer 2 (score 547)
You can ignore SSL errors by setting <a href="https://pypi.org" rel="noreferrer">`pypi.org`</a> and <a href="https://files.pythonhosted.org" rel="noreferrer">`files.pythonhosted.org`</a> as trusted hosts.  

```sh
$ pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org <package_name>
```

<strong>Note</strong>: Sometime during April 2018, the <a href="https://pypi.org" rel="noreferrer">Python Package Index</a> was migrated from `pypi.python.org` to `pypi.org`. This means "trusted-host" commands using the old domain no longer work.  

<h5>Permanent Fix</h3>

Since the release of pip 10.0, you should be able to fix this permanently just by upgrading `pip` itself:  

```sh
$ pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org pip setuptools
```

Or by just <a href="https://pip.pypa.io/en/stable/installing/" rel="noreferrer">reinstalling it</a> to get the latest version:  

```sh
$ curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
```

(… and then running `get-pip.py` with the relevant Python interpreter).  

`pip install &lt;otherpackage&gt;` should just work after this. If not, then you will need to do more, as explained below.  

<hr>

You may want to <a href="https://pip.pypa.io/en/stable/user_guide/?highlight=appdata#config-file" rel="noreferrer">add the trusted hosts and proxy to your config file</a>.    

`pip.ini` (Windows) or `pip.conf` (unix)  

```sh
[global]
trusted-host = pypi.python.org
               pypi.org
               files.pythonhosted.org
```

<hr>

<strong>Alternate Solutions (Less secure)</strong>  

Most of the answers could pose a security issue.  

Two of the workarounds that help in installing most of the python packages with ease would be:  

<ul>
<li><strong>Using easy_install</strong>: if you are really lazy and don't want to waste much time, use `easy_install &lt;package_name&gt;`. Note that some packages won't be found or will give small errors.</li>
<li><strong>Using Wheel</strong>: download the <a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/" rel="noreferrer">Wheel of the python package</a> and use the pip command `pip install wheel_package_name.whl` to install the package.</li>
</ul>

#### Answer 3 (score 108)
You can specify a cert with this param:   

```sh
pip --cert /etc/ssl/certs/FOO_Root_CA.pem install linkchecker
```

See: <a href="https://pip.readthedocs.io/en/latest/reference/pip/#cmdoption--cert" rel="noreferrer">Docs » Reference Guide » pip</a>  

If specifying your company's root cert doesn't work maybe the cURL one will work: <a href="http://curl.haxx.se/ca/cacert.pem" rel="noreferrer">http://curl.haxx.se/ca/cacert.pem</a>  

<strong>You must use a PEM file and not a CRT file. If you have a CRT file you will need to <a href="https://stackoverflow.com/q/991758/3357935">convert the file to PEM</a></strong> There are reports in the comments that this now works with a CRT file but I have not verified.  

Also check: <a href="http://docs.python-requests.org/en/latest/user/advanced/#ssl-cert-verification" rel="noreferrer">SSL Cert Verification</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: How to run a PowerShell script from a batch file (score [633470](https://stackoverflow.com/q/19335004) in 2014)

#### Question
I am trying to run this script in PowerShell. I have saved the below script as `ps.ps1` on my desktop.  

```sh
$query = "SELECT * FROM Win32_DeviceChangeEvent WHERE EventType = 2"
Register-WMIEvent -Query $query -Action { invoke-item "C:\Program Files\abc.exe"}
```

I have made a batch script to run this PowerShell script  

```sh
@echo off
Powershell.exe set-executionpolicy remotesigned -File  C:\Users\SE\Desktop\ps.ps1
pause
```

But I am getting this error:  

<img src="https://i.stack.imgur.com/i2473.png" alt="Enter image description here">  

#### Answer accepted (score 241)
You need the `-ExecutionPolicy` parameter:  

```sh
Powershell.exe -executionpolicy remotesigned -File  C:\Users\SE\Desktop\ps.ps1
```

Otherwise PowerShell considers the arguments a line to execute and while `Set-ExecutionPolicy` <em>is</em> a cmdlet, it has no `-File` parameter.  

#### Answer 2 (score 105)
I explain both why you would want to call a PowerShell script from a batch file and how to do it <a href="http://blog.danskingdom.com/allow-others-to-run-your-powershell-scripts-from-a-batch-file-they-will-love-you-for-it/" rel="noreferrer">in my blog post here</a>.  

This is basically what you are looking for:  

```sh
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'C:\Users\SE\Desktop\ps.ps1'"
```

And if you need to run your PowerShell script as an admin, use this:  

```sh
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""C:\Users\SE\Desktop\ps.ps1""' -Verb RunAs}"
```

Rather than hard-coding the entire path to the PowerShell script though, I recommend placing the batch file and PowerShell script file in the same directory, as my blog post describes.  

#### Answer 3 (score 13)
If you run a batch file calling PowerShell as a administrator, you better run it like this, saving you all the trouble:  

```sh
powershell.exe -ExecutionPolicy Bypass -Command "Path\xxx.ps1"
```

It is better to use `Bypass`...  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: PHP 7: Missing VCRUNTIME140.dll (score [619583](https://stackoverflow.com/q/30811668) in 2017)

#### Question
I have an error when I start PHP&nbsp;7 on Windows. When I run `php` on the command line, it returns a message box with system error:  

<blockquote>
  The program can't start because VCRUNTIME140.dll is missing from your computer. Try reinstalling the program to fix this problem.  
</blockquote>

After that, `CLI` is crashing.  

As I don't want to install a DLL file from an external website, I don't know how to fix this!  

<strong>PHP version:</strong> <a href="http://windows.php.net/downloads/qa/php-7.0.0alpha1-Win32-VC14-x64.zip" rel="noreferrer">7.0.0alpha1 VC14 x64 Thread Safe</a>  

#### Answer accepted (score 223)
On the <em>side bar</em> of the <a href="http://windows.php.net/qa/" rel="noreferrer">PHP 7 alpha download page</a>, it does say this:  

<blockquote>
  <p>VC9, VC11 &amp; VC14
  More recent versions of PHP are built with VC9, VC11
  or VC14 (Visual Studio 2008, 2012 or 2015 compiler respectively) and
  include improvements in performance and stability.</p>
  
  <ul>
  <li><p>The VC9 builds require you to have the Visual C++ Redistributable for Visual Studio 2008 SP1 <a href="http://www.microsoft.com/en-us/download/details.aspx?id=5582" rel="noreferrer">x86</a> or <a href="http://www.microsoft.com/en-us/download/details.aspx?id=15336" rel="noreferrer">x64</a> installed</p></li>
  <li><p>The VC11 builds require to have the Visual C++ Redistributable for Visual Studio 2012 <a href="http://www.microsoft.com/en-us/download/details.aspx?id=30679" rel="noreferrer">x86 or x64</a> installed</p></li>
  <li><p>The VC14 builds require to have the Visual C++ Redistributable for Visual Studio 2015 <a href="https://www.microsoft.com/en-us/download/details.aspx?id=48145" rel="noreferrer">x86 or x64</a> installed</p></li>
  </ul>
</blockquote>

<sup>There's been a problem with some of those links, so the files are also available from <a href="http://www.softpedia.com/get/Programming/Components-Libraries/Microsoft-Visual-C-Redistributable-Package.shtml#download" rel="noreferrer">Softpedia</a>.</sup>  

In the case of the PHP 7 alpha, it's the last option that's required.  

I think that the placement of this information is poor, as it's kind of marginalized (i.e.: it's basically literally in the margin!) whereas it's actually critical for the software to run.  

I documented my experiences of getting PHP 7 alpha up and running on Windows 8.1 in <a href="http://blog.adamcameron.me/2015/06/php-getting-php7-alpha-running-on.html" rel="noreferrer">PHP: getting PHP7 alpha running on Windows 8.1</a>, and it covers some more symptoms that might crop up. They're out of scope for this question but might help other people.  

Other symptom of this issue:  

<ul>
<li>Apache not starting, claiming `php7apache2_4.dll` is missing despite it definitely being in place, and offering nothing else in any log.</li>
<li>`php-cgi.exe - The FastCGI process exited unexpectedly` (as per @ftexperts's comment below)</li>
</ul>

Attempted solution:  

<ul>
<li>Using the `php7apache2_4.dll` file from an earlier PHP 7 dev build. <em>This did not work.</em></li>
</ul>

(I include those for googleability.)  

#### Answer 2 (score 22)
<em><a href="https://www.microsoft.com/en-us/download/details.aspx?id=48145" rel="nofollow noreferrer">Visual C++ Redistributable for Visual Studio 2015</a></em> (x32 bit version) - RC.  

This should correct that. You can google for what the DLL <em>is</em>, but that's not important.  

PS: It's officially from Microsoft too:)  

Where I found it: <em><a href="https://www.visualstudio.com/downloads/visual-studio-2015-downloads-vs" rel="nofollow noreferrer">Downloads</a></em> (Visual Studio)  

#### Answer 3 (score 16)
Installing <strong><a href="https://www.microsoft.com/en-in/download/details.aspx?id=48145" rel="nofollow noreferrer">vc_redist.x86.exe</a></strong> works for me even though you have a 64-bit machine.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: Create Windows service from executable (score [606305](https://stackoverflow.com/q/3582108) in 2013)

#### Question
Is there any quick way to, given an executable file, create a Windows service that, when started, launches it?  

#### Answer accepted (score 424)
To create a Windows Service from an executable, you can use `sc.exe`:  

```sh
sc.exe create <new_service_name> binPath= "<path_to_the_service_executable>"
```

You must have quotation marks around the actual `exe` path, and a space after the `binPath=`.  

<a href="http://support.microsoft.com/kb/251192" rel="noreferrer">More information on the `sc` command can be found in Microsoft KB251192</a>.   

Note that it will not work for just any executable: the executable must be a Windows Service (<a href="https://msdn.microsoft.com/en-us/library/windows/desktop/ms685138(v=vs.85).aspx" rel="noreferrer">i.e. implement ServiceMain</a>). When registering a non-service executable as a service, you'll get the following error upon trying to start the service:  

<blockquote>
  Error 1053: The service did not respond to the start or control request in a timely fashion.  
</blockquote>

There are tools that can create a Windows Service from arbitrary, non-service executables, see the other answers for examples of such tools.  

#### Answer 2 (score 220)
Use NSSM( <strong>the non-Sucking Service Manager</strong> ) to run a .BAT or any .EXE file as a service.   

<a href="http://nssm.cc/" rel="noreferrer">http://nssm.cc/</a>  

<ul>
<li><strong>Step 1</strong>: Download NSSM</li>
<li><strong>Step 2</strong>: Install your sevice with `nssm.exe install [serviceName]`</li>
<li><strong>Step 3</strong>: This will open a GUI which you will use to locate your executable</li>
</ul>

#### Answer 3 (score 90)
Extending (Kevin Tong) answer.  

<strong>Step 1:</strong> Download &amp; Unzip <a href="http://nssm.cc/release/nssm-2.24.zip" rel="noreferrer">nssm-2.24.zip</a>  

<strong>Step 2:</strong> From command line type:   

`C:\&gt; nssm.exe install [servicename]`  

it will open GUI as below (the example is UT2003 server), then simply browse it to: yourapplication.exe  

<img src="https://i.stack.imgur.com/p2K4y.png" alt="enter image description here">  

More information on: <a href="https://nssm.cc/usage" rel="noreferrer">https://nssm.cc/usage</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: How to prevent auto-closing of console after the execution of batch file (score [592911](https://stackoverflow.com/q/988403) in 2018)

#### Question
What command can I put at the end of a batch file to prevent auto-closing of the console after the execution of the file?  

#### Answer accepted (score 603)
In Windows/DOS batch files:  

```sh
pause
```

This prints a nice `"Press any key to continue . . . "` message  

Or, if you don't want the `"Press any key to continue . . ."` message, do this instead:  

```sh
pause >nul
```

#### Answer 2 (score 133)
Depends on the exact question!  

Normally `pause` does the job within a <strong>.bat</strong> file.  

If you want <strong>cmd.exe</strong> not to close to be able to remain typing, use `cmd /k` command at the end of the file.  

#### Answer 3 (score 63)
<blockquote>
  If you want cmd.exe to not close, and able to continue to type, use `cmd /k`  
</blockquote>

Just felt the need to clarify what `/k` does (from windows website):  

<blockquote>
  `/k` : Carries out the command specified by string and continues.  
</blockquote>

So `cmd /k` without follow up command at the end of bat file will just keep `cmd.exe` window open for further use.  

On the other hand `pause` at the end of a batch file will simply pause the process and terminate `cmd.exe` on first button press   

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: Remove credentials from Git (score [588935](https://stackoverflow.com/q/15381198) in 2017)

#### Question
I'm working with several repositories, but lately I was just working in our internal one and all was great.  

Today I had to commit and push code into other one, but I'm having some troubles.  

```sh
$ git push appharbor master
error: The requested URL returned error: 403 while accessing https://gavekortet@appharbor.com/mitivo.git/info/refs?service=git-receive-pack
fatal: HTTP request failed
```

There is nothing I can do, that would bring the password entry again.  

How can I reset the credentials on my system so Git will ask me for the password of that repository?  

I have tried:  

<ul>
<li>`git config --global --unset core.askpass`</li>
</ul>

in order to unset the password  

<ul>
<li>`git config credential.helper 'cache --timeout=1'`</li>
</ul>

in order to avoid credentials cache...  

Nothing seems to work; does anyone have a better idea?  

#### Answer accepted (score 567)
The Git credential cache runs a daemon process which caches your credentials in memory and hands them out on demand. So killing your git-credential-cache--daemon process throws all these away and results in re-prompting you for your password if you continue to use this as the cache.helper option.  

You could also disable use of the Git credential cache using `git config --global --unset credential.helper`. Then reset this, and you would continue to have the cached credentials available for other repositories (if any). You may also need to do `git config --system --unset credential.helper` if this has been set in the system configuration file (for example, Git for Windows 2).  

On Windows you might be better off using the <em>manager</em> helper (`git config --global credential.helper manager`). This stores your credentials in the Windows credential store which has a Control Panel interface where you can delete or edit your stored credentials. With this store, your details are secured by your Windows login and can persist over multiple sessions. The <em>manager</em> helper included in Git for Windows 2.x has replaced the earlier <em>wincred</em> helper that was added in Git for Windows 1.8.1.1. A similar helper called <em>winstore</em> is also available online and was used with GitExtensions as it offers a more GUI driven interface. The <em>manager</em> helper offers the same GUI interface as <em>winstore</em>.  

Extract from <a href="http://windows.microsoft.com/en-us/windows7/manage-stored-passwords-certificates-and-other-credentials" rel="noreferrer">the Windows manual</a> detailing the Windows credential store panel:  

<blockquote>
  Open User Accounts by clicking the Start button Picture of the Start button, clicking Control Panel, clicking User Accounts and Family Safety (or clicking User Accounts, if you are connected to a network domain), and then clicking User Accounts. In the left pane, click Manage your credentials.  
</blockquote>

#### Answer 2 (score 488)
If this problem comes on a Windows machine, do the following.  

<ul>
<li>Go to Credential Manager</li>
<li>Go to Windows Credentials </li>
<li>Delete the entries under Generic Credentials</li>
<li>Try connecting again. This time, it should prompt you for the correct username and password.</li>
</ul>

<a href="https://i.stack.imgur.com/5KePZ.png" rel="noreferrer"><img src="https://i.stack.imgur.com/5KePZ.png" alt="Go to Credential Manager "></a>  

<a href="https://i.stack.imgur.com/kRdEv.png" rel="noreferrer"><img src="https://i.stack.imgur.com/kRdEv.png" alt="Go to Windows Credentials and Delete the entries under Generic Credentials "></a>  

#### Answer 3 (score 140)
Retype:  

```sh
$ git config credential.helper store
```

And then you will be prompted to enter your credentials again.  

<strong>WARNING</strong>  

<blockquote>
  Using this helper will store your passwords unencrypted on disk  
</blockquote>

Source: <a href="https://git-scm.com/docs/git-credential-store" rel="noreferrer">https://git-scm.com/docs/git-credential-store</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: Really killing a process in Windows (score [579432](https://stackoverflow.com/q/49988) in 2016)

#### Question
Occasionally a program on a Windows machine goes crazy and just hangs.  So I'll call up the task manager and hit the "End Process" button for it.  However, this doesn't always work; if I try it enough times then it'll usually die eventually, but I'd really like to be able to just kill it immediately.  On Linux I could just `kill -9` to guarantee that a process will die.  

This also could be used for writing batch scripts and writing batch scripts is programming.  

<strong>Is there some</strong> program or <strong>command that comes with Windows that will always kill a process?</strong>  A free third-party app would be fine, although I'd prefer to be able to do this on machines I sit down at for the first time.  

#### Answer accepted (score 316)
"End Process" on the Processes-Tab calls `TerminateProcess` which is the most ultimate way Windows knows to kill a process.  

If it doesn't go away, it's currently locked waiting on some kernel resource (probably a buggy driver) and there is nothing (short of a reboot) you could do to make the process go away.  

Have a look at this blog-entry from wayback when: <a href="http://blogs.technet.com/markrussinovich/archive/2005/08/17/unkillable-processes.aspx" rel="noreferrer">http://blogs.technet.com/markrussinovich/archive/2005/08/17/unkillable-processes.aspx</a>  

Unix based systems like Linux also have that problem where processes could survive a `kill -9` if they are in what's known as "Uninterruptible sleep" (shown by top and ps as state `D`) at which point the processes sleep so well that they can't process incoming signals (which is what `kill` does - sending signals).  

Normally, Uninterruptible sleep should not last long, but as under Windows, broken drivers or broken userpace programs (`vfork` without `exec`) can end up sleeping in `D` forever.  

#### Answer 2 (score 225)
```sh
taskkill /im myprocess.exe /f
```

<p>The "/f" is for "force".
If you know the PID, then you can specify that, as in:</p>

```sh
taskkill /pid 1234 /f
```

Lots of other options are possible, just type taskkill /? for all of them.  The "/t" option kills a process and any child processes; that may be useful to you.  

#### Answer 3 (score 37)
<a href="http://processhacker.sourceforge.net/" rel="noreferrer"><em>Process Hacker</em></a> has numerous ways of killing a process.  

<img src="https://i.stack.imgur.com/ByAnj.png" alt="">  

(Right-click the process, then go to Miscellaneous->Terminator.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Create folder with batch but only if it doesn't already exist (score [577198](https://stackoverflow.com/q/4165387) in 2016)

#### Question
Can anybody tell me how to do the following in in a Windows batch script?  (`*.bat`):  

<ul>
<li>Create a folder only if it doesn't already exist</li>
</ul>

In more detail, I want to create a folder named `VTS` on the `C:\` drive, but only if that folder doesn't already exist.  I don't want to overwrite the contents of the folder if it already exists and the batch is executed.  

#### Answer 2 (score 569)
You just use this: `if not exist "C:\VTS\" mkdir C:\VTS` it wll create a directory only if the folder does not exist.  

Note that this existence test will return true only if VTS exists and is a directory.  If it is not there, or is there as a file, the mkdir command will run, and should cause an error.  You might want to check for whether VTS exists as a file as well.  

#### Answer 3 (score 204)
```sh
if exist C:\VTS\NUL echo "Folder already exists"

if not exist C:\VTS\NUL echo "Folder does not exist"
```

See also <a href="https://support.microsoft.com/en-us/kb/65994" rel="noreferrer">https://support.microsoft.com/en-us/kb/65994</a>  

(Update March 7, 2018; Microsoft article is down, archive on <a href="https://web.archive.org/web/20150609092521/https://support.microsoft.com/en-us/kb/65994" rel="noreferrer">https://web.archive.org/web/20150609092521/https://support.microsoft.com/en-us/kb/65994</a> )  

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: IIS Manager in Windows 10 (score [567408](https://stackoverflow.com/q/30901434) in 2019)

#### Question
How do you open IIS (Internet Information Services) Manager using Windows 10?  

I have installed the developer preview of Windows 10 and can't seem to find IIS Manager?  It is not in Control Panel > Administrative Tools.  

When I browse to the folder C:\Windows\System32\inetsrv it is empty.  

I did a full search of my hard drive to find inetmgr.exe and found three copies and none of them would open, when I tried to open them it says "This App cannot Run on your PC"  To find a version of the App that works contact the publisher.  

I know IIS works because I have ran local ASP.net apps through VisualStudio, but I can't seem to find any way to launch IIS Manager to do some configurations for a site.  

Anyone know anything about this?  

#### Answer accepted (score 433)
Thanks to @SLaks comment above I was able to turn on IIS and bring the manager back.  

Press the Windows Key and type Windows Features, select the first entry Turn Windows Features On or Off.  

Make sure the box next to IIS is checked.  

<img src="https://i.stack.imgur.com/3Ief6.png" alt="enter image description here">  

If it is not checked, check it.  This might take a few minutes, but this will install everything you need to use IIS.  

When it is done, IIS should have returned to Control Panel > Administrative Tools  

<img src="https://i.stack.imgur.com/D0Fyf.png" alt="enter image description here">  

#### Answer 2 (score 225)
<a href="https://i.stack.imgur.com/xV6e1.png" rel="noreferrer"><img src="https://i.stack.imgur.com/xV6e1.png" alt="Windows features, ISS Management Console"></a>  

<p>Under the windows feature list, make sure to check the IIS Management Console 
You also need to check additional check boxes as shown below:</p>

<img src="https://i.stack.imgur.com/Tgf3W.png" alt="Windows features, ISS, HTTP Features">  

#### Answer 3 (score 67)
Actually you must make sure that the IIS Management Console feature is explicitly checked. On my win 10 pro I had to do it manually, checking the root only was not enough!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: How to code a BAT file to always run as admin mode? (score [565736](https://stackoverflow.com/q/6811372) in 2011)

#### Question
I have this line inside my BAT file:  

```sh
"Example1Server.exe"
```

I would like to execute this in Administrator mode. How to modify the bat code to run this as admin?  

Is this correct? Do I need to put the quotes?  

```sh
runas /user:Administrator invis.vbs Example1Server.exe
```

#### Answer accepted (score 66)
You use `runas` to launch a program as a specific user:  

```sh
runas /user:Administrator Example1Server.exe
```

#### Answer 2 (score 345)
The other answer requires that you enter the Administrator account password. Also, running under an account in the Administrator Group is not the same as <em>run as administrator</em> see: <a href="http://en.wikipedia.org/wiki/User_Account_Control#Requesting_elevation" rel="noreferrer">UAC on Wikipedia</a>  

<em>Windows 7 Instructions</em>  

In order to run as an Administrator, create a shortcut for the batch file.  

<ol>
<li>Right click the batch file and click copy </li>
<li>Navigate to where you want the shortcut </li>
<li>Right click the background of the directory</li>
<li>Select Paste Shortcut</li>
</ol>

Then you can set the shortcut to run as administrator:  

<ol>
<li>Right click the shortcut</li>
<li>Choose Properties</li>
<li>In the Shortcut tab, click Advanced</li>
<li>Select the checkbox "Run as administrator"</li>
<li>Click OK, OK</li>
</ol>

Now when you double click the shortcut it will prompt you for UAC confirmation and then <em>Run as administrator</em> (which as I said above is different than running under an account in the Administrator Group)  

<strong>Check the screenshot below</strong>  

<img src="https://i.stack.imgur.com/ZFldW.png" alt="Screenshot">  

<p><strong>Note:</strong>
When you do so to Run As Administrator, the current directory (path) will not be same as the bat file. This can cause some problems in many cases that the bat file refer to relative files beside it. For example, in my Windows 7 the cur dir will be SYSTEM32 instead of bat file location! 
<a href="https://stackoverflow.com/a/672721/2803565">To workaround it</a>, you should use </p>

`cd "%~dp0"`   

or better   

`pushd "%~dp0"`   

to ensure cur dir is at the same path where the bat file is.  

#### Answer 3 (score 13)
Just add this to the top of your bat file:  

```sh
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
```

It will elevate to admin and also stay in the correct directory. Tested on Windows 10.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: How to check if a process is running via a batch script (score [554470](https://stackoverflow.com/q/162291) in 2008)

#### Question
How can I check if an application is running from a batch (well cmd) file?  

I need to not launch another instance if a program is already running. (I can't change the app to make it single instance only.)  

Also the application could be running as any user.  

#### Answer 2 (score 307)
Another possibility I came up with, inspired by using <a href="http://en.wikipedia.org/wiki/Grep" rel="noreferrer">grep</a>, is:  

```sh
tasklist /FI "IMAGENAME eq myapp.exe" 2>NUL | find /I /N "myapp.exe">NUL
if "%ERRORLEVEL%"=="0" echo Program is running
```

It doesn't need to save an extra file, so I prefer this method.  

#### Answer 3 (score 61)
Here's how I've worked it out:  

```sh
tasklist /FI "IMAGENAME eq notepad.exe" /FO CSV > search.log

FOR /F %%A IN (search.log) DO IF %%~zA EQU 0 GOTO end

start notepad.exe

:end

del search.log
```

The above will open <a href="http://en.wikipedia.org/wiki/Notepad_%28software%29" rel="noreferrer">Notepad</a> if it is not already running.  

Edit: Note that this won't find applications hidden from the tasklist. This will include any scheduled tasks running as a different user, as these are automatically hidden.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: Is there an equivalent of 'which' on the Windows command line? (score [550715](https://stackoverflow.com/q/304319) in 2018)

#### Question
As I sometimes have path problems, where one of my own cmd scripts is hidden (shadowed) by another program (earlier on the path), I would like to be able to find the full path to a program on the Windows command line, given just its name.  

Is there an equivalent to the UNIX command 'which'?  

On UNIX, `which command` prints the full path of the given command to easily find and repair these shadowing problems.  

#### Answer accepted (score 2405)
Windows Server 2003 and later (i.e. anything after Windows XP 32 bit) provide the `where.exe` program which does some of what `which` does, though it matches all types of files, not just executable commands.  (It does not match built-in shell commands like `cd`.)  It will even accept wildcards, so `where nt*` finds all files in your `%PATH%` and current directory whose names start with `nt`.  

Try `where /?` for help.  

Note that Windows PowerShell defines `where` as an alias for <a href="http://technet.microsoft.com/en-us/library/hh849715.aspx" rel="noreferrer">the `Where-Object` cmdlet</a>, so if you want `where.exe`, you need to type the full name instead of omitting the `.exe` extension.  

#### Answer 2 (score 281)
While later versions of Windows have a `where` command, you can also do this with Windows XP by using the environment variable modifiers, as follows:  

```sh
c:\> for %i in (cmd.exe) do @echo.   %~$PATH:i
   C:\WINDOWS\system32\cmd.exe

c:\> for %i in (python.exe) do @echo.   %~$PATH:i
   C:\Python25\python.exe
```

You don't need any extra tools and it's not limited to `PATH` since you can substitute any environment variable (in the path format, of course) that you wish to use.  

<hr>

And, if you want one that can handle all the extensions in PATHEXT (as Windows itself does), this one does the trick:  

```sh
@echo off
setlocal enableextensions enabledelayedexpansion

:: Needs an argument.

if "x%1"=="x" (
    echo Usage: which ^<progName^>
    goto :end
)

:: First try the unadorned filenmame.

set fullspec=
call :find_it %1

:: Then try all adorned filenames in order.

set mypathext=!pathext!
:loop1
    :: Stop if found or out of extensions.

    if "x!mypathext!"=="x" goto :loop1end

    :: Get the next extension and try it.

    for /f "delims=;" %%j in ("!mypathext!") do set myext=%%j
    call :find_it %1!myext!

:: Remove the extension (not overly efficient but it works).

:loop2
    if not "x!myext!"=="x" (
        set myext=!myext:~1!
        set mypathext=!mypathext:~1!
        goto :loop2
    )
    if not "x!mypathext!"=="x" set mypathext=!mypathext:~1!

    goto :loop1
:loop1end

:end
endlocal
goto :eof

:: Function to find and print a file in the path.

:find_it
    for %%i in (%1) do set fullspec=%%~$PATH:i
    if not "x!fullspec!"=="x" @echo.   !fullspec!
    goto :eof
```

It actually returns all possibilities but you can tweak it quite easily for specific search rules.  

#### Answer 3 (score 135)
Under PowerShell, <a href="https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Core/Get-Command?view=powershell-5.1" rel="noreferrer">`Get-Command`</a> will find executables anywhere in `$Env:PATH`.  

```sh
Get-Command eventvwr

CommandType   Name          Definition
-----------   ----          ----------
Application   eventvwr.exe  c:\windows\system32\eventvwr.exe
Application   eventvwr.msc  c:\windows\system32\eventvwr.msc
```

It also finds PowerShell cmdlets, functions, aliases, files with custom executables extensions via `$Env:PATHEXT`, etc. defined for the current shell (quite akin to Bash's `type -a foo`) - making it a better go-to than other tools like `where.exe`, `which.exe`, etc which are unaware of these PowerShell commands.  

<h5>Finding executables using only part of the name</h3>

```sh
gcm *disk*

CommandType     Name                             Version    Source
-----------     ----                             -------    ------
Alias           Disable-PhysicalDiskIndication   2.0.0.0    Storage
Alias           Enable-PhysicalDiskIndication    2.0.0.0    Storage
Function        Add-PhysicalDisk                 2.0.0.0    Storage
Function        Add-VirtualDiskToMaskingSet      2.0.0.0    Storage
Function        Clear-Disk                       2.0.0.0    Storage
Cmdlet          Get-PmemDisk                     1.0.0.0    PersistentMemory
Cmdlet          New-PmemDisk                     1.0.0.0    PersistentMemory
Cmdlet          Remove-PmemDisk                  1.0.0.0    PersistentMemory
Application     diskmgmt.msc                     0.0.0.0    C:\WINDOWS\system32\diskmgmt.msc
Application     diskpart.exe                     10.0.17... C:\WINDOWS\system32\diskpart.exe
Application     diskperf.exe                     10.0.17... C:\WINDOWS\system32\diskperf.exe
Application     diskraid.exe                     10.0.17... C:\WINDOWS\system32\diskraid.exe
...
```

<h5>Finding custom executables</h3>

To find other non-windows executables (python, ruby, perl, etc), file extensions for those executables need to be added to the `PATHEXT` environmental variable (defaults to `.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC;.CPL`) to identify files with these extensions in the `PATH` as executable. As `Get-Command` also honours this variable, it can be extended to list custom executables. e.g.  

```sh
$Env:PATHEXT="$Env:PATHEXT;.dll;.ps1;.psm1;.py"     # temporary assignment, only for this shell's process

gcm user32,kernel32,*WASM*,*http*py

CommandType     Name                        Version    Source
-----------     ----                        -------    ------
ExternalScript  Invoke-WASMProfiler.ps1                C:\WINDOWS\System32\WindowsPowerShell\v1.0\Invoke-WASMProfiler.ps1
Application     http-server.py              0.0.0.0    C:\Users\ME\AppData\Local\Microsoft\WindowsApps\http-server.py
Application     kernel32.dll                10.0.17... C:\WINDOWS\system32\kernel32.dll
Application     user32.dll                  10.0.17... C:\WINDOWS\system32\user32.dll
```

You can quickly set up an alias with `sal which gcm` (short form of `set-alias which get-command`).  

More information and examples can be found under the online help for <a href="http://go.microsoft.com/fwlink/?LinkId=821482" rel="noreferrer">`Get-Command`</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: Setting Windows PowerShell environment variables (score [548411](https://stackoverflow.com/q/714877) in 2019)

#### Question
I have found out that setting the PATH environment variable affects only the old command prompt. PowerShell seems to have different environment settings. How do I change the environment variables for PowerShell (v1)?  

Note:  

I want to make my changes permanent, so I don't have to set it every time I run PowerShell. Does PowerShell have a profile file? Something like Bash profile on Unix?  

#### Answer accepted (score 399)
<p>Changing the actual environment variables can be done by
using the `env: namespace / drive` information. For example, this
code will update the path environment variable:</p>

```sh
$env:Path = "SomeRandomPath";             (replaces existing path) 
$env:Path += ";SomeRandomPath"            (appends to existing path)
```

<p>There are ways to make environment settings permanent, but
if you are only using them from PowerShell, it's probably
a lot better to use your profile to initiate the
settings. On startup, PowerShell will run any <em>.ps1</em>
files it finds in the `WindowsPowerShell` directory under
My Documents folder. Typically you have a <em>profile.ps1</em>
file already there. The path on my computer is</p>

```sh
C:\Users\JaredPar\Documents\WindowsPowerShell\profile.ps1
```

#### Answer 2 (score 603)
<p>If, some time during a PowerShell session, you need to
append to the PATH environment variable temporarily, you can
do it this way:</p>

```sh
$env:Path += ";C:\Program Files\GnuWin32\bin"
```

#### Answer 3 (score 233)
You can also modify user/system environment variables <strong>permanently</strong> (i.e. will be persistent across shell restarts) with the following:  

Modify a system environment variable   

```sh
[Environment]::SetEnvironmentVariable
     ("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
```

Modify a user environment variable  

```sh
[Environment]::SetEnvironmentVariable
     ("INCLUDE", $env:INCLUDE, [System.EnvironmentVariableTarget]::User)
```

Usage from comments - add to the system environment variable  

```sh
[Environment]::SetEnvironmentVariable(
    "Path",
    [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";C:\bin",
    [EnvironmentVariableTarget]::Machine)
```

String based solution is also possible if you don't want to write types  

```sh
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\bin", "Machine")
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: How to log in to phpMyAdmin with WAMP, what is the username and password? (score [547231](https://stackoverflow.com/q/18012052) in 2015)

#### Question
What does the word "root" mean in <a href="http://en.wikipedia.org/wiki/PhpMyAdmin">phpMyAdmin</a>?  

Whenever I write `localhost/phpmyadmin` on the address bar, I am asked to enter a username and a password, but I don't know what they are. I don't remember when and where I set them. From where can I get my username and password to login to phpMyAdmin?  

#### Answer accepted (score 335)
Try username = root and password is blank.  

#### Answer 2 (score 25)
```sh
http://localhost/phpmyadmin
```

Username: root  

Password:  

(No password set)  

#### Answer 3 (score 15)
Sometimes it doesn't get login with `username = root` and `password`, then you can change the default settings or the reset settings.  

Open `config.inc.php` file in the phpmyadmin folder  

Instead of  

```sh
$cfg['Servers'][$i]['AllowNoPassword'] = false;
```

change it to:  

```sh
$cfg['Servers'][$i]['AllowNoPassword'] = true;
```

Do not specify any password and put the user name as it was before, which means `root`.  

E.g.   

```sh
$cfg['Servers'][$i]['user'] = 'root';
$cfg['Servers'][$i]['password'] = '';
```

This worked for me after i had edited my `config.inc.php` file.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: javac not working in windows command prompt (score [539803](https://stackoverflow.com/q/1678520) in 2018)

#### Question
I'm trying to use `javac` with the windows command prompt, but it's not working.  

After adding the directory `"C:\Program Files\Java\jdk1.6.0_16\bin\"` to the end of the `PATH` environment variable, the `java` command works fine, but using `javac` gives me the following error:  

<blockquote>
  'javac' is not recognized as an internal or external command, operable program or batch file.  
</blockquote>

#### Answer accepted (score 156)
If you added it in the control panel while your command prompt was open, that won't affect your current command prompt. You'll need to exit and re-open or simply do:  

```sh
set "path=%path%;c:\program files\java\jdk1.6.0_16\bin"
```

By way of checking, execute:  

```sh
echo %path%
```

from your command prompt and let us know what it is.  

Otherwise, make sure there <em>is</em> a javac in that directory by trying:  

```sh
"c:\program files\java\jdk1.6.0_16\bin\javac.exe"
```

from the command prompt. You can also tell <em>which</em> executable (if any) is being used with the command:  

```sh
for %i in (javac.exe) do @echo %~$PATH:i
```

This is a neat trick similar to the `which` and/or `whence` commands in some UNIX-type operating systems.  

#### Answer 2 (score 86)
Windows OS searches the current directory and the directories listed in the PATH environment variable for executable programs. JDK's programs (such as Java compiler javac.exe and Java runtime java.exe) reside in directory "\bin" (where  denotes the JDK installed directory, e.g., C:\Program Files\Java\jdk1.8.0_xx). You need to include the "\bin" directory in the PATH.  

To edit the PATH environment variable in Windows XP/Vista/7/8:  

<ol>
<li><p>Control Panel ⇒ System ⇒ Advanced system settings</p></li>
<li><p>Switch to "Advanced" tab ⇒ Environment Variables</p></li>
<li><p>In "System Variables", scroll down to select "PATH" ⇒ Edit</p></li>
</ol>

(( now read the following 3 times before proceeding, <strong>THERE IS NO UNDO</strong> ))  

<p>In "Variable value" field, INSERT "c:\Program Files\Java\jdk1.8.0_xx\bin" (Replace xx with the upgrade number and VERIFY that this is your JDK's binary directory!!!) IN FRONT of all the existing directories, followed by a semi-colon (;) which separates the JDK's binary directory from the rest of the existing directories.
DO NOT DELETE any existing entries; otherwise, some existing applications may not run.</p>

```sh
Variable name  : PATH
Variable value : c:\Program Files\Java\jdk1.8.0_xx\bin;[existing entries...]
```

<img src="https://i.stack.imgur.com/7jqLF.png" alt="Screenshot ">  

#### Answer 3 (score 33)
After a long Google, I came to know that javac.exe will be inside <strong>JDK</strong>(C:\Program Files\Java\jdk(version number)\bin) not inside <strong>JRE</strong> (C:\Program Files (x86)\Java\jre7\bin)  <strong>"JRE doesn't come with a compiler. It(JRE) is simply a java runtime environment. What you need is the Java development kit."</strong> in order to use  compiler javac  

javac will not work if you are pointing bin inside jre  

In order to use javac in cmd , JDK must be installed in your system...  

<strong>For javac  path</strong>  

<strong>path = C:\Program Files (x86)\Java\jre7\bin</strong>  this is wrong   

<strong>path = C:\Program Files\Java\jdk(version number)\bin</strong>  this is correct  

Make sure that "javac.exe" is inside your <strong>"C:\Program Files\Java\jdk(version number)\bin"</strong>  

Don't get confused with JRE and JDK  both are totally different   

if you don't have JDK pls download from this link <a href="http://www.oracle.com/technetwork/java/javase/downloads/index.html" rel="nofollow noreferrer">http://www.oracle.com/technetwork/java/javase/downloads/index.html</a>  

reference thread for JDK VS JRE  <a href="https://stackoverflow.com/questions/1906445/what-is-the-difference-between-jdk-and-jre">What is the difference between JDK and JRE?</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: Iterate all files in a directory using a 'for' loop (score [534443](https://stackoverflow.com/q/138497) in 2016)

#### Question
How can I iterate over each file in a directory using a `for` loop?  

And how could I tell if a certain entry is a directory or if it's just a file?  

#### Answer accepted (score 452)
This lists all the files (and only the files) in the current directory:  

```sh
for /r %i in (*) do echo %i
```

Also if you run that command in a batch file you need to double the % signs.   

```sh
for /r %%i in (*) do echo %%i
```

(thanks @agnul)   

#### Answer 2 (score 203)
Iterate through...  

<ul>
<li>...files in current dir: `for %f in (.\*) do @echo %f`</li>
<li>...subdirs in current dir: `for /D %s in (.\*) do @echo %s`</li>
<li>...files in current and all subdirs: `for /R %f in (.\*) do @echo %f`</li>
<li>...subdirs in current and all subdirs: `for /R /D %s in (.\*) do @echo %s`</li>
</ul>

Unfortunately I did not find any way to iterate over files and subdirs at the same time.  

Just use <a href="http://www.cygwin.com" rel="noreferrer">cygwin</a> with its bash for much more functionality.  

Apart from this: Did you notice, that the buildin help of MS Windows is a great resource for descriptions of cmd's command line syntax?  

Also have a look here: <a href="http://technet.microsoft.com/en-us/library/bb490890.aspx" rel="noreferrer">http://technet.microsoft.com/en-us/library/bb490890.aspx</a>  

#### Answer 3 (score 55)
<strong>To iterate over each file a for loop will work:</strong>  

`for %%f in (directory\path\*) do ( something_here )`  

<strong>In my case I also wanted the file content, name, etc.</strong>   

<em>This lead to a few issues and I thought my use case might help. Here is a loop that reads info from each '.txt' file in a directory and allows you do do something with it (setx for instance).</em>  

```sh
@ECHO OFF
setlocal enabledelayedexpansion
for %%f in (directory\path\*.txt) do (
  set /p val=<%%f
  echo "fullname: %%f"
  echo "name: %%~nf"
  echo "contents: !val!"
)
```

*Limitation: val&lt;=%%f will only get the first line of the file.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: Show a popup/message box from a Windows batch file (score [532467](https://stackoverflow.com/q/774175) in 2016)

#### Question
Is there a way to display a message box from a batch file (similar to how `xmessage` can be used from bash-scripts in Linux)?  

#### Answer accepted (score 113)
I would make a very simple VBScript file and call it using CScript to parse the command line parameters.  

Something like the following saved in `MessageBox.vbs`:  

```sh
Set objArgs = WScript.Arguments
messageText = objArgs(0)
MsgBox messageText
```

Which you would call like:  

```sh
cscript MessageBox.vbs "This will be shown in a popup."
```

<a href="http://msdn.microsoft.com/en-us/library/sfw6660x%28v=vs.84%29.aspx" rel="noreferrer">`MsgBox` reference</a> if you are interested in going this route.  

#### Answer 2 (score 124)
First of all, DOS has nothing to do with it, you probably want a Windows command line solution (again: no DOS, pure Windows, just not a Window, but a Console).  

You can either use the VBScript method provided by boflynn or you can mis-use `net send` or `msg`.  `net send` works only on older versions of windows:  

```sh
net send localhost Some message to display
```

This also depends on the Messenger service to run, though.  

For newer versions (XP and onward, apparently):  

```sh
msg "%username%" Some message to display
```

It should be noted that a message box sent using `msg.exe` will only last for 60 seconds. This can however be overridden with the `/time:xx` switch.  

#### Answer 3 (score 83)
Might display a little flash, but no temp files required. Should work all the way back to somewhere in the (IIRC) IE5 era.  

```sh
mshta javascript:alert("Message\n\nMultiple\nLines\ntoo!");close();
```

Don't forget to <a href="https://stackoverflow.com/questions/12976351/escaping-parentheses-within-parentheses-for-batch-file">escape your parentheses</a> if you're using `if`:  

```sh
if 1 == 1 (
   mshta javascript:alert^("1 is equal to 1, amazing."^);close^(^);
)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: "rm -rf" equivalent for Windows? (score [531124](https://stackoverflow.com/q/97875) in 2018)

#### Question
I need a way to recursively delete a folder and its children.  

Is there a prebuilt tool for this, or do I need to write one?  

`DEL /S` doesn't delete directories.  

`DELTREE` was removed from Windows 2000+  

#### Answer accepted (score 623)
RMDIR or RD if you are using the classic Command Prompt (cmd.exe):  

```sh
rd /s /q "path"
```

If you are using PowerShell you can use `Remove-Item` (which is aliased to `del`, `erase`, `rd`, `ri`, `rm` and `rmdir`) and takes a `-Recurse` argument that can be shorted to `-r`  

```sh
rd -r "path"
```

#### Answer 2 (score 131)
admin:  

```sh
takeown /r /f folder
cacls folder /c /G "ADMINNAME":F /T
rmdir /s folder
```

Works for anything including sys files  

EDIT: I actually found the best way which also solves file path too long problem as well:  

```sh
mkdir \empty
robocopy /mir \empty folder
```

#### Answer 3 (score 109)
`RMDIR <strong>[/S]</strong> [/Q] [drive:]path`  

`RD <strong>[/S]</strong> [/Q] [drive:]path`  

<ul>
<li><p><strong>`/S`</strong>      Removes all directories and files in the specified directory in addition to the directory itself.  <strong><em>Used to remove a directory tree.</em></strong></p></li>
<li><p>`/Q`      Quiet mode, do not ask if ok to remove a directory tree with `/S`</p></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: How to output something in PowerShell (score [530739](https://stackoverflow.com/q/2038181) in 2018)

#### Question
I am running a PowerShell script from within a batch file. The script fetches a web page and checks whether the page's content is the string "OK".  

The PowerShell script returns an error level to the batch script.  

The batch script is executed by <a href="http://www.scriptftp.com" rel="noreferrer">ScriptFTP</a>, an FTP automation program. If an error occurs, I can have ScriptFTP send the full console output to the administrator via E-Mail.  

In the PowerShell script, I would like to output the return value from the web site if it is not "OK", so the error message gets included in the console output, and thus in the status mail.  

I am new to PowerShell and not sure which output function to use for this. I can see three:  

<ul>
<li>Write-Host</li>
<li>Write-Output</li>
<li>Write-Error</li>
</ul>

What would be the right thing to use to write to the Windows equivalent of `stdout`?  

#### Answer accepted (score 187)
Simply outputting something is PowerShell is a thing of beauty - and one its greatest strengths. For example, the common Hello, World! application is reduced to a single line:  

```sh
"Hello, World!"
```

It creates a string object, assigns the aforementioned value, and being the last item on the command pipeline it calls the `.toString()` method and outputs the result to `STDOUT` (by default). A thing of beauty.  

The other `Write-*` commands are specific to outputting the text to their associated streams, and have their place as such.  

#### Answer 2 (score 117)
I think in this case you will need <a href="http://technet.microsoft.com/en-us/library/hh849921.aspx" rel="noreferrer">Write-Output</a>.  

If you have a script like  

```sh
Write-Output "test1";
Write-Host "test2";
"test3";
```

then, if you call the script with redirected output, something like `yourscript.ps1 &gt; out.txt`, you will get `test2` on the screen `test1\ntest3\n` in the "out.txt".  

Note that "test3" and the Write-Output line will always append a new line to your text and there is no way in PowerShell to stop this (that is, `echo -n` is impossible in PowerShell with the native commands). If you want (the somewhat basic and easy in <a href="http://en.wikipedia.org/wiki/Bash_%28Unix_shell%29" rel="noreferrer">Bash</a>) functionality of `echo -n` then see <a href="https://stackoverflow.com/questions/2038181/how-to-output-something-in-powershell/11901810#11901810">samthebest's answer</a>.  

If a batch file runs a PowerShell command, it will most likely capture the Write-Output command. I have had "long discussions" with system administrators about what should be written to the console and what should not. We have now agreed that the only information if the script executed successfully or died has to be `Write-Host`'ed, and everything that is the script's author might need to know about the execution (what items were updated, what fields were set, et cetera) goes to Write-Output. This way, when you submit a script to the system administrator, he can easily `runthescript.ps1 &gt;someredirectedoutput.txt` and see on the screen, if everything is OK. Then send the "someredirectedoutput.txt" back to the developers.  

#### Answer 3 (score 8)
I think the following is a good exhibit of Echo vs. <a href="https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.utility/Write-Host" rel="noreferrer">Write-Host</a>. Notice how test() actually returns an array of ints, not a single int as one could easily be led to believe.  

```sh
function test {
    Write-Host 123
    echo 456 # AKA 'Write-Output'
    return 789
}

$x = test

Write-Host "x of type '$($x.GetType().name)' = $x"

Write-Host "`$x[0] = $($x[0])"
Write-Host "`$x[1] = $($x[1])"
```

Terminal output of the above:  

```sh
123
x of type 'Object[]' = 456 789
$x[0] = 456
$x[1] = 789
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: How to find which program is using port 80 in Windows? (score [521839](https://stackoverflow.com/q/1960750) in 2014)

#### Question
How to find which program is using port 80 in Windows? I can't find it.  

#### Answer accepted (score 190)
Start->Accessories right click on "Command prompt", in menu click "Run as Administrator" (on Windows XP you can just run it as usual), run `netstat -anb` then look through output for your program.  

BTW, Skype by default tries to use ports 80 and 443 for incoming connections.  

You can also run `netstat -anb &gt;%USERPROFILE%\ports.txt` followed by `start %USERPROFILE%\ports.txt` to open port and process list in a text editor, where you can search for information you want.  

You can also use powershell to parse `netstat` output and present it in a better way (or process any way you want):  

```sh
$proc = @{};
Get-Process | ForEach-Object { $proc.Add($_.Id, $_) };
netstat -aon | Select-String "\s*([^\s]+)\s+([^\s]+):([^\s]+)\s+([^\s]+):([^\s]+)\s+([^\s]+)?\s+([^\s]+)" | ForEach-Object {
    $g = $_.Matches[0].Groups;
    New-Object PSObject | 
        Add-Member @{ Protocol =           $g[1].Value  } -PassThru |
        Add-Member @{ LocalAddress =       $g[2].Value  } -PassThru |
        Add-Member @{ LocalPort =     [int]$g[3].Value  } -PassThru |
        Add-Member @{ RemoteAddress =      $g[4].Value  } -PassThru |
        Add-Member @{ RemotePort =         $g[5].Value  } -PassThru |
        Add-Member @{ State =              $g[6].Value  } -PassThru |
        Add-Member @{ PID =           [int]$g[7].Value  } -PassThru |
        Add-Member @{ Process = $proc[[int]$g[7].Value] } -PassThru;
#} | Format-Table Protocol,LocalAddress,LocalPort,RemoteAddress,RemotePort,State -GroupBy @{Name='Process';Expression={$p=$_.Process;@{$True=$p.ProcessName; $False=$p.MainModule.FileName}[$p.MainModule -eq $Null] + ' PID: ' + $p.Id}} -AutoSize
} | Sort-Object PID | Out-GridView
```

Also it does not require elevation to run.  

#### Answer 2 (score 180)
Type in the command: `netstat -aon | findstr :80`.  

It will show you all processes that use port 80. Notice the <em>pid</em> (process id) in the right column.  

If you would like to free the port, go to task manager, sort by <em>pid</em> and close those processes.<br><br>  

-<strong>a</strong> displays all connections and listening ports.  

-<strong>o</strong> displays the owning process ID associated with each connection.  

-<strong>n</strong> displays addresses and port numbers in numerical form.  

#### Answer 3 (score 13)
If you want to be really fancy, download <a href="http://technet.microsoft.com/en-us/sysinternals/bb897437.aspx" rel="noreferrer">TCPView</a> from sysinternals  

<blockquote>
  <p>TCPView is a Windows program that will
  show you detailed listings of all TCP
  and UDP endpoints on your system,
  including the local and remote
  addresses and state of TCP
  connections. On Windows Server 2008,
  Vista, and XP, TCPView also reports
  the name of the process that owns the
  endpoint. TCPView provides a more
  informative and conveniently presented
  subset of the Netstat program that
  ships with Windows.</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: 'git' is not recognized as an internal or external command (score [520774](https://stackoverflow.com/q/4492979) in 2018)

#### Question


I have an installation of Git for Windows, but when I try to use the `git` command in Command Prompt, I get the following error:  

```sh
'git' is not recognized as an internal or external command,
operable program or batch file. 
```

How do I fix this problem?  

#### Answer accepted (score 412)
Have you correctly set your `PATH` to point at your Git installation?  

You need to add the following paths to `PATH`:  

<ul>
<li>`C:\Program Files\Git\bin\`</li>
<li>`C:\Program Files\Git\cmd\`</li>
</ul>

And check that these paths are correct – you may have Git installed on a different drive, or under `Program Files (x86)`. Correct the paths if necessary.  

<hr>

Modifying `PATH` on Windows 10:  

<ol>
<li>In the Start Menu or taskbar search, search for "environment variable".</li>
<li>Select "Edit the system environment variables".</li>
<li>Click the "Environment Variables" button at the bottom.</li>
<li>Double-click the "Path" entry under "System variables".</li>
<li>With the "New" button in the PATH editor, add `C:\Program Files\Git\bin\` and `C:\Program Files\Git\cmd\` to the end of the list.</li>
<li>Close and re-open your console.</li>
</ol>

Modifying `PATH` on Windows 7:  

<ol>
<li>Right-click "Computer" on the Desktop or Start Menu.</li>
<li>Select "Properties".</li>
<li>On the very far left, click the "Advanced system settings" link.</li>
<li>Click the "Environment Variables" button at the bottom.</li>
<li>Double-click the "Path" entry under "System variables".</li>
<li>At the end of "Variable value", insert a `;` if there is not already one, and then `C:\Program Files\Git\bin\;C:\Program Files\Git\cmd\`. Do not put a space between `;` and the entry.</li>
<li>Close and re-open your console.</li>
</ol>

If these instructions weren't helpful, feel free to look at some others:  

<ul>
<li><a href="https://www.computerhope.com/issues/ch000549.htm" rel="noreferrer">How to set the path and environment variables in Windows</a> (Computer Hope)</li>
<li><a href="https://www.howtogeek.com/118594/how-to-edit-your-system-path-for-easy-command-line-access/" rel="noreferrer">How to edit your system PATH for easy command line access in Windows</a> (How-To Geek)</li>
<li><a href="https://www.addictivetips.com/windows-tips/set-path-environment-variables-in-windows-10/" rel="noreferrer">How to set Path environment variables in Windows 10</a> (Addictive Tips)</li>
<li><a href="https://superuser.com/questions/284342/what-are-path-and-other-environment-variables-and-how-can-i-set-or-use-them">What are PATH and other environment variables, and how can I set or use them?</a> (Super User)</li>
</ul>

#### Answer 2 (score 130)
Did you open the `cmd` prompt before installation of git? If so, close and reopen it.  

#### Answer 3 (score 47)
<ol>
<li>Go to <strong>My Computer => Local Disk(C:) => Program Files(x86) => Git => cmd</strong></li>
<li>Right Click the <strong>git => Select Properties</strong></li>
<li>Under the <strong>location</strong> Copy the text 
eg - C:\Program Files (x86)\Git\cmd</li>
<li>Come back to the Desktop </li>
<li>Right-click <strong>My Computer</strong></li>
<li>Select <strong>property</strong> </li>
<li>Open <strong>Advanced</strong> </li>
<li>Click <strong>Environment Variables</strong></li>
<li>In the System variables Find the Variable call <strong>Path</strong></li>
<li>Click the <strong>variable</strong> </li>
<li>Click the <strong>Edit Button</strong> </li>
<li>Select the <strong>Variable value</strong> Text Box . </li>
<li>Go to the edge of the text and put <strong>semicolon(;)</strong> </li>
<li>Then Right-click and press Paste </li>
<li>Press Ok</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: How to clear the interpreter console? (score [512843](https://stackoverflow.com/q/517970) in 2019)

#### Question
Like most Python developers, I typically keep a console window open with the Python interpreter running to test commands, `dir()` stuff, `help() stuff`, etc.  

Like any console, after a while the visible backlog of past commands and prints gets to be cluttered, and sometimes confusing when re-running the same command several times.  I'm wondering if, and how, to clear the Python interpreter console.  

I've heard about doing a system call and either calling `cls` on Windows or `clear` on Linux, but I was hoping there was something I could command the interpreter itself to do.  

<strong>Note:</strong> I'm running on Windows, so `Ctrl+L` doesn't work.  

#### Answer accepted (score 393)
As you mentioned, you can do a system call:  

For Windows  

```sh
>>> import os
>>> clear = lambda: os.system('cls')
>>> clear()
```

For Linux the lambda becomes  

```sh
>>> clear = lambda: os.system('clear')
```

#### Answer 2 (score 176)
here something handy that is a little more cross-platform  

```sh
import os

def cls():
    os.system('cls' if os.name=='nt' else 'clear')

# now, to clear the screen
cls()
```

#### Answer 3 (score 84)
Well, here's a quick hack:  

```sh
>>> clear = "\n" * 100
>>> print clear
>>> ...do some other stuff...
>>> print clear
```

Or to save some typing, put this file in your python search path:  

```sh
# wiper.py
class Wipe(object):
    def __repr__(self):
        return '\n'*1000

wipe = Wipe()
```

Then you can do this from the interpreter all you like :)  

```sh
>>> from wiper import wipe
>>> wipe
>>> wipe
>>> wipe
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: How to run .sh on Windows Command Prompt? (score [510971](https://stackoverflow.com/q/26522789) in )

#### Question
How can I run .sh on Windows 7 Command Prompt? I always get this error when I try to run this line in it,  

```sh
app/build/build.sh
```

error,  

```sh
'app' is not recognized...
```

or,  

```sh
bash app/build/build.sh
```

error,  

```sh
'bash' is not recognized...
```

Any ideas what have I missed?   

<p>Here the screen grab,
<img src="https://i.stack.imgur.com/0mcPj.jpg" alt="enter image description here"></p>

#### Answer accepted (score 51)
The error message indicates that you have not installed `bash`, or it is not in your `PATH`.  

The top Google hit is <a href="http://win-bash.sourceforge.net/">http://win-bash.sourceforge.net/</a> but you also need to understand that most Bash scripts expect a Unix-like environment; so just installing Bash is probably unlikely to allow you to run a script you found on the net, unless it was specifically designed for this particular usage scenario.  The usual solution to that is <a href="https://www.cygwin.com/">https://www.cygwin.com/</a> but there are many possible alternatives, depending on what exactly it is that you want to accomplish.  

If Windows is not central to your usage scenario, installing a free OS (perhaps virtualized) might be the simplest way forward.  

The second error message is due to the fact that Windows nominally accepts forward slash as a directory separator, but in this context, it is being interpreted as a switch separator.  In other words, Windows parses your command line as `app /build /build.sh` (or, to paraphrase with Unix option conventions, `app --build --build.sh`).  You could try `app\build\build.sh` but it is unlikely to work, because of the circumstances outlined above.  

#### Answer 2 (score 111)
Install <a href="https://git-scm.com/downloads" rel="noreferrer">GIT</a>. During installation of GIT, add GIT Bash to windows context menu by selecting its option. After installation right click in your folder select `GIT Bash Here` (see attached pic) and use your sh command like for example:  

```sh
sh test.sh
```

<a href="https://i.stack.imgur.com/soecn.png" rel="noreferrer"><img src="https://i.stack.imgur.com/soecn.png" alt="enter image description here"></a>  

#### Answer 3 (score 47)
The most common way to run a <a href="http://en.wikipedia.org/wiki/Bourne_shell" rel="noreferrer"><strong>.sh</strong></a> file is using the <strong>sh</strong> command:  

```sh
C:\>sh my-script-test.sh 
```

other good option is installing <a href="https://www.cygwin.com/" rel="noreferrer"><strong>CygWin</strong></a>  

in `Windows` the `home` is located in:   

```sh
C:\cygwin64\home\[user]
```

for example i execute my `my-script-test.sh` file using the <a href="http://linux.about.com/library/cmd/blcmdl1_bash.htm" rel="noreferrer"><strong>bash</strong></a> command as:  

```sh
jorgesys@INT024P ~$ bash /home/[user]/my-script-test.sh 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Permanently add a directory to PYTHONPATH? (score [509513](https://stackoverflow.com/q/3402168) in 2018)

#### Question
Whenever I use `sys.path.append`, the new directory will be added. However, once I close python, the list will revert to the previous (default?) values. How do I permanently add a directory to `PYTHONPATH`?  

#### Answer accepted (score 122)
You need to add your new directory to the environment variable `PYTHONPATH`, separated by a colon from previous contents thereof.  In any form of Unix, you can do that in a startup script appropriate to whatever shell you're using (`.profile` or whatever, depending on your favorite shell) with a command which, again, depends on the shell in question; in Windows, you can do it through the system GUI for the purpose.  

`superuser.com` may be a better place to ask further, i.e. for more details if you need specifics about how to enrich an environment variable in your chosen platform and shell, since it's not really a programming question per se.  

#### Answer 2 (score 392)
If you're using bash (on a Mac or GNU/Linux distro), add this to your `~/.bashrc`  

```sh
export PYTHONPATH="${PYTHONPATH}:/my/other/path"
```

#### Answer 3 (score 81)
Instead of manipulating `PYTHONPATH` you can also create a <a href="http://docs.python.org/library/site.html">path configuration file</a>. First find out in which directory Python searches for this information:  

```sh
python -m site --user-site
```

For some reason this doesn't seem to work in Python 2.7. There you can use:  

```sh
python -c 'import site; site._script()' --user-site
```

Then create a `.pth` file in that directory containing the path you want to add (create the directory if it doesn't exist).  

For example:  

```sh
# find directory
SITEDIR=$(python -m site --user-site)

# create if it doesn't exist
mkdir -p "$SITEDIR"

# create new .pth file with our path
echo "$HOME/foo/bar" > "$SITEDIR/somelib.pth"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: How do I run Redis on Windows? (score [502853](https://stackoverflow.com/q/6476945) in 2012)

#### Question
How do I run Redis on Windows? The Redis download page just seems to offer *nix options.  

Can I run Redis natively on Windows?  

#### Answer 2 (score 412)
One click Redis install as a Windows service:  

<a href="https://github.com/rgl/redis/downloads">https://github.com/rgl/redis/downloads</a>  

Download and run the top .exe (ignore the "download as zip" button)  

<strong>Edit:</strong> For the latest versions of Redis for Windows look at <a href="https://github.com/MSOpenTech/redis/releases">`MSOpenTech/redis`</a>. See <a href="https://stackoverflow.com/a/20200022/2039244">Todd Menier's answer</a> for more information.  

#### Answer 3 (score 262)
I found one more simple way to install `Redis` under Windows  

Download the latest `Redis` `.msi` file from   

<a href="https://github.com/MSOpenTech/redis/releases" rel="noreferrer">https://github.com/MSOpenTech/redis/releases</a>  

after installation. The redis service is installed, we can operate it from `Service manager`  

<a href="https://i.stack.imgur.com/nCwcR.png" rel="noreferrer"><img src="https://i.stack.imgur.com/nCwcR.png" alt="enter image description here"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: How do I use spaces in the Command Prompt? (score [491652](https://stackoverflow.com/q/6376113) in 2017)

#### Question
How can I use spaces in the Windows Command Line?  

```sh
cmd /C C:\Program Files (x86)\WinRar\Rar.exe a D:\Hello 2\File.rar D:\Hello 2\*.*
```

#### Answer accepted (score 233)
Single quotation marks won't do in that case. You have to add quotation marks around each path and also enclose the whole command in quotation marks:  

```sh
cmd /C ""C:\Program Files (x86)\WinRar\Rar.exe" a "D:\Hello 2\File.rar" "D:\Hello 2\*.*""
```

#### Answer 2 (score 68)
I just figured out that for a case where the path involves the use of white space characters, for example,  when I need to access the app `xyz` which location is :  

```sh
C:\Program Files\ab cd\xyz.exe
```

To run this from windows cmd prompt, you need to use   

```sh
C:\"Program Files"\"ab cd"\xyz.exe
```

or  

```sh
"C:\Program Files\ab cd\xyz.exe"
```

#### Answer 3 (score 19)
If double quotes do not solve the issue then try e.g.  

```sh
dir /X ~1 c:\
```

to get a list of alternative file or directory names. Example output:  

```sh
11/09/2014 12:54 AM             8,065  DEFAUL~1.XML Default Desktop Policy.xml
06/12/2014  03:49 PM    <DIR>          PROGRA~1     Program Files 
10/12/2014  12:46 AM    <DIR>          PROGRA~2     Program Files (x86)
```

Now use the short 8 character file or folder name in the 5th column, e.g. PROGRA~1 or DEFAUL~1.XML, in your commands. For instance:  

```sh
set JAVA_HOME=c:\PROGRA~1\Java\jdk1.6.0_45 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Register comdlg32.dll gets Regsvr32: DllRegisterServer entry point was not found (score [491213](https://stackoverflow.com/q/13931337) in 2017)

#### Question
I have Windows 7, 64-bit.  

I'm trying to register a .dll (comdlg32.dll) using regsvr32. But I get an error that says the dll is read but the DLLRegistryServer entry point is not found.  

I have run the command under both System32 and SysWOW64 and I have run my commands with "Run As Administrator".  

My old MSComDlg.CommonDialog component is no longer working with 64-bit.  

#### Answer 2 (score 14)
Run this command:  

```sh
dumpbin /exports comdlg32.dll
```

You'll likely see that comdlg32.dll doesn't contain a DllRegisterServer method. Hence RegSvr32.exe won't work.  

That's your answer.  

ComDlg32.dll is a a system component. (exists in both c:\windows\system32 and c:\windows\syswow64)  Trying to replace it or override any registration with an older version could corrupt the rest of Windows.  

I can help more, but I need to know what MSComDlg.CommonDialog is. What does it do and how is it supposed to work? And what version of ComDlg32.dll are you trying to register (and where did you get it)?    

#### Answer 3 (score 9)
comdlg32.dll is not really a COM dll (you can't register it).  

What you need is <strong>comdlg32.ocx</strong> which contains the MSComDlg.CommonDialog COM class (and indeed relies on comdlg32.dll to work). Once you get ahold on a comdlg32.ocx, then you will be able to do `regsvr32 comdlg32.ocx`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: 'npm' is not recognized as internal or external command, operable program or batch file (score [490579](https://stackoverflow.com/q/20992723) in 2018)

#### Question
I am completely new to nodejs. I am trying to get nodejs to work on my Windows 2008 box in order to install Karma which I would use for TDDing my AngularJs code. I have done the following steps so far  

<ol>
<li>Install using Chocolatey ==> npm is not recognised</li>
<li>Install using 64-bit nodejs installer from nodejs.org ==> npm is not recognised</li>
<li>At this stage, running `where npm` gives me `c:\User\&lt;Username&gt;\AppData\Roaming\npm` which has nothing in it</li>
<li>I figure out that nodejs is installed in `C:\Program Files\nodejs`. Opening a command prompt in this directory makes `npm` work fine.</li>
<li>So I added `C:\Program Files\nodejs` to `PATH` only to get the same error again that `npm is not recognized`</li>
<li>One of the github issues on nodejs repository says that I need to restart the machine and it would fix. But that has not helped so far</li>
<li>I do see a `Node.js` icon in my `Start -&gt; Programms` mennu which takes me to nodejs console but not sure what to do with that. </li>
</ol>

Have I missed any important step in the process?  

<h5>Edit</h2>

I figured out that if I open "Nodejs command prompt" from program files, then npm is recognized. How do I make it work on a normal command prompt?  

<h5>Edit</h2>

After `node` I started facing a similar problem with another application. I posted <a href="https://superuser.com/questions/699725/windows-2008-where-command-shows-correct-path-but-the-actual-command-does-no">this question</a> on superuser and as rightly pointed out by the accepted answer, I had an additional quote in my `PATH` which was causing issues with all the paths added after the quote. I have a feeling that some Chocolatey install adds this troubling quote but I am just not sure which one.   

#### Answer accepted (score 299)
Just add:  

```sh
;C:\Program Files\nodejs\
```

To the end of your <strong>Path</strong> variable on the <strong>"User variable"</strong> section of the Environment Variables on the System Properties.  

After that, reopen your command prompt and type  

```sh
npm
```

This should work.  

#### Answer 2 (score 90)
Don't forget to reboot your computer after installing node! That one got me.  

#### Answer 3 (score 26)
To elaborate on <a href="https://stackoverflow.com/a/21923238/1766230">Breno's answer</a>... For <strong>Windows</strong> 7 these steps worked for me:  

<ol>
<li>Open the Control Panel (Click the Start button, then click <em>Control Panel</em>)</li>
<li>Click <em>User Accounts</em></li>
<li>Click <em>Change my environment variables</em></li>
<li>Select <em>PATH</em> and click the <em>Edit...</em> button</li>
<li>At the end of the Variable value, add `;C:\Program Files\nodejs`</li>
<li>Click <em>Ok</em> on the "Edit User Variable" window, then click <em>Ok</em> on the "Environment Variables" window</li>
<li>Start a command prompt window (Start button, then type <strong>cmd</strong> into the search and hit enter)</li>
<li>At the prompt (`C:\&gt;`) type <strong>npm</strong> and hit enter; you should now see some help text (`Usage: npm &lt;command&gt;` etc.) rather than "<em>npm is not recognized...</em>"</li>
</ol>

Now you can <a href="https://www.npmjs.org/doc/cli/npm.html" rel="noreferrer">start using npm</a>!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Is there a command to refresh environment variables from the command prompt in Windows? (score [490548](https://stackoverflow.com/q/171588) in 2017)

#### Question
If I modify or add an environment variable I have to restart the command prompt.  Is there a command I could execute that would do this without restarting CMD?  

#### Answer accepted (score 131)
You can capture the system environment variables with a vbs script, but you need a bat script to actually change the current environment variables, so this is a combined solution.  

Create a file named `resetvars.vbs` containing this code, and save it on the path:  



```sh
Set oShell = WScript.CreateObject("WScript.Shell")
filename = oShell.ExpandEnvironmentStrings("%TEMP%\resetvars.bat")
Set objFileSystem = CreateObject("Scripting.fileSystemObject")
Set oFile = objFileSystem.CreateTextFile(filename, TRUE)

set oEnv=oShell.Environment("System")
for each sitem in oEnv 
    oFile.WriteLine("SET " & sitem)
next
path = oEnv("PATH")

set oEnv=oShell.Environment("User")
for each sitem in oEnv 
    oFile.WriteLine("SET " & sitem)
next

path = path & ";" & oEnv("PATH")
oFile.WriteLine("SET PATH=" & path)
oFile.Close
```

create another file name resetvars.bat containing this code, same location:  

```sh
@echo off
%~dp0resetvars.vbs
call "%TEMP%\resetvars.bat"
```

When you want to refresh the environment variables, just run `resetvars.bat`  

<hr>

<em>Apologetics</em>:  

The two main problems I had coming up with this solution were  

<strong>a.</strong> I couldn't find a straightforward way to export environment variables from a vbs script back to the command prompt, and   

<strong>b.</strong> the PATH environment variable is a concatenation of the user and the system PATH variables.  

I'm not sure what the general rule is for conflicting variables between user and system, so I elected to make user override system, except in the PATH variable which is handled specifically.  

I use the weird vbs+bat+temporary bat mechanism to work around the problem of exporting variables from vbs.  

<strong>Note</strong>: this script does not delete variables.  

This can probably be improved.  

<strong>ADDED</strong>  

If you need to export the environment from one cmd window to another, use this script (let's call it `exportvars.vbs`):  

```sh
Set oShell = WScript.CreateObject("WScript.Shell")
filename = oShell.ExpandEnvironmentStrings("%TEMP%\resetvars.bat")
Set objFileSystem = CreateObject("Scripting.fileSystemObject")
Set oFile = objFileSystem.CreateTextFile(filename, TRUE)

set oEnv=oShell.Environment("Process")
for each sitem in oEnv 
    oFile.WriteLine("SET " & sitem)
next
oFile.Close
```

Run `exportvars.vbs` in the window you want to export <strong>from</strong>, then switch to the window you want to export <strong>to</strong>, and type:  

```sh
"%TEMP%\resetvars.bat"
```

#### Answer 2 (score 98)
Here is what Chocolatey uses.  

<a href="https://github.com/chocolatey/choco/blob/master/src/chocolatey.resources/redirects/RefreshEnv.cmd" rel="noreferrer">https://github.com/chocolatey/choco/blob/master/src/chocolatey.resources/redirects/RefreshEnv.cmd</a>  

```sh
@echo off
::
:: RefreshEnv.cmd
::
:: Batch file to read environment variables from registry and
:: set session variables to these values.
::
:: With this batch file, there should be no need to reload command
:: environment every time you want environment changes to propagate

echo | set /p dummy="Reading environment variables from registry. Please wait... "

goto main

:: Set one environment variable from registry key
:SetFromReg
    "%WinDir%\System32\Reg" QUERY "%~1" /v "%~2" > "%TEMP%\_envset.tmp" 2>NUL
    for /f "usebackq skip=2 tokens=2,*" %%A IN ("%TEMP%\_envset.tmp") do (
        echo/set %~3=%%B
    )
    goto :EOF

:: Get a list of environment variables from registry
:GetRegEnv
    "%WinDir%\System32\Reg" QUERY "%~1" > "%TEMP%\_envget.tmp"
    for /f "usebackq skip=2" %%A IN ("%TEMP%\_envget.tmp") do (
        if /I not "%%~A"=="Path" (
            call :SetFromReg "%~1" "%%~A" "%%~A"
        )
    )
    goto :EOF

:main
    echo/@echo off >"%TEMP%\_env.cmd"

    :: Slowly generating final file
    call :GetRegEnv "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" >> "%TEMP%\_env.cmd"
    call :GetRegEnv "HKCU\Environment">>"%TEMP%\_env.cmd" >> "%TEMP%\_env.cmd"

    :: Special handling for PATH - mix both User and System
    call :SetFromReg "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" Path Path_HKLM >> "%TEMP%\_env.cmd"
    call :SetFromReg "HKCU\Environment" Path Path_HKCU >> "%TEMP%\_env.cmd"

    :: Caution: do not insert space-chars before >> redirection sign
    echo/set Path=%%Path_HKLM%%;%%Path_HKCU%% >> "%TEMP%\_env.cmd"

    :: Cleanup
    del /f /q "%TEMP%\_envset.tmp" 2>nul
    del /f /q "%TEMP%\_envget.tmp" 2>nul

    :: Set these variables
    call "%TEMP%\_env.cmd"

    echo | set /p dummy="Done"
    echo .
```

#### Answer 3 (score 62)
On windows 7/8/10 you can install Chocolatey which has a script for this built in.  

After installing Chocolatey, just type "refreshenv" without quotes.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: How do I get the current username in Windows PowerShell? (score [488193](https://stackoverflow.com/q/2085744) in 2019)

#### Question
How do I get the current username in Windows PowerShell?  

#### Answer accepted (score 354)
I found it:  

```sh
$env:UserName
```

There is also:  

```sh
$env:UserDomain
$env:ComputerName
```

#### Answer 2 (score 161)
```sh
[System.Security.Principal.WindowsIdentity]::GetCurrent().Name
```

#### Answer 3 (score 103)
`$env:username` is the easiest way  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: What are good grep tools for Windows? (score [488031](https://stackoverflow.com/q/87350) in 2013)

#### Question
Any recommendations on <a href="http://en.wikipedia.org/wiki/Grep" rel="noreferrer">grep</a> tools for Windows? Ideally ones that could leverage 64-bit OS.  

I'm aware of <a href="http://www.cygwin.com/" rel="noreferrer">Cygwin</a>, of course, and have also found <a href="http://www.powergrep.com/" rel="noreferrer">PowerGREP</a>, but I'm wondering if there are any hidden gems out there?  

#### Answer accepted (score 196)
<h5>Based on recommendations in the comments, I've started using <a href="http://tools.tortoisesvn.net/grepWin.html" rel="noreferrer">grepWin</a> and it's fantastic and <em>free</em>.</h2>

<hr>

(I'm still a fan of <a href="http://www.powergrep.com/" rel="noreferrer">PowerGREP</a>, but I don't use it anymore.)  

I know you already mentioned it, but PowerGREP is <strong>awesome</strong>.  

Some of my favorite features are:  

<ul>
<li>Right-click on a folder to run PowerGREP on it</li>
<li>Use regular expressions or literal text</li>
<li>Specify wildcards for files to include &amp; exclude</li>
<li>Search &amp; replace</li>
<li>Preview mode is nice because you can make sure you're replacing what you intend to.</li>
</ul>

Now I realize that the other grep tools can do all of the above. It's just that PowerGREP packages all of the functionality into a very easy-to-use GUI.  

<strong><em>From the same wonderful folks who brought you <a href="http://en.wikipedia.org/wiki/RegexBuddy" rel="noreferrer">RegexBuddy</a> and who I have no affiliation with beyond loving their stuff.</em></strong> (It should be noted that RegexBuddy includes a basic version of grep (for Windows) itself and it costs a lot less than PowerGREP.)  

<hr>

<h5>Additional solutions</h2>

<h5>Existing Windows commands</h3>

<ul>
<li><a href="http://ss64.com/nt/findstr.html" rel="noreferrer">FINDSTR</a></li>
<li><a href="https://technet.microsoft.com/en-us/library/hh849903.aspx" rel="noreferrer">Select-String</a> in PowerShell</li>
</ul>

<h5>Linux command implementations on Windows</h3>

<ul>
<li><a href="http://en.wikipedia.org/wiki/Cygwin" rel="noreferrer">Cygwin</a></li>
<li><a href="https://github.com/dthree/cash" rel="noreferrer">Cash</a></li>
</ul>

<h5>Grep tools with a graphical interface</h3>

<ul>
<li><a href="http://astrogrep.sourceforge.net/screenshots/" rel="noreferrer">AstroGrep</a></li>
<li><a href="https://www.baremetalsoft.com/baregrep/" rel="noreferrer">BareGrep</a></li>
<li><a href="http://stefanstools.sourceforge.net/grepWin.html" rel="noreferrer">GrepWin</a></li>
</ul>

<h5>Additional Grep tools</h3>

<ul>
<li><a href="http://code.google.com/p/dngrep/" rel="noreferrer">dnGrep</a></li>
</ul>

#### Answer 2 (score 317)
<a href="http://ss64.com/nt/findstr.html" rel="noreferrer">FINDSTR</a> is fairly powerful, supports <a href="http://en.wikipedia.org/wiki/Regular_expression" rel="noreferrer">regular expressions</a> and has the advantages of being on all Windows machines already.  

```sh
c:\> FindStr /?

Searches for strings in files.

FINDSTR [/B] [/E] [/L] [/R] [/S] [/I] [/X] [/V] [/N] [/M] [/O] [/P] [/F:file]
        [/C:string] [/G:file] [/D:dir list] [/A:color attributes] [/OFF[LINE]]
        strings [[drive:][path]filename[ ...]]

  /B         Matches pattern if at the beginning of a line.
  /E         Matches pattern if at the end of a line.
  /L         Uses search strings literally.
  /R         Uses search strings as regular expressions.
  /S         Searches for matching files in the current directory and all
             subdirectories.
  /I         Specifies that the search is not to be case-sensitive.
  /X         Prints lines that match exactly.
  /V         Prints only lines that do not contain a match.
  /N         Prints the line number before each line that matches.
  /M         Prints only the filename if a file contains a match.
  /O         Prints character offset before each matching line.
  /P         Skip files with non-printable characters.
  /OFF[LINE] Do not skip files with offline attribute set.
  /A:attr    Specifies color attribute with two hex digits. See "color /?"
  /F:file    Reads file list from the specified file(/ stands for console).
  /C:string  Uses specified string as a literal search string.
  /G:file    Gets search strings from the specified file(/ stands for console).
  /D:dir     Search a semicolon delimited list of directories
  strings    Text to be searched for.
  [drive:][path]filename
             Specifies a file or files to search.

Use spaces to separate multiple search strings unless the argument is prefixed
with /C.  For example, 'FINDSTR "hello there" x.y' searches for "hello" or
"there" in file x.y.  'FINDSTR /C:"hello there" x.y' searches for
"hello there" in file x.y.

Regular expression quick reference:
  .        Wildcard: any character
  *        Repeat: zero or more occurances of previous character or class
  ^        Line position: beginning of line
  $        Line position: end of line
  [class]  Character class: any one character in set
  [^class] Inverse class: any one character not in set
  [x-y]    Range: any characters within the specified range
  \x       Escape: literal use of metacharacter x
  \<xyz    Word position: beginning of word
  xyz\>    Word position: end of word
```

Example usage: `findstr text_to_find *` or to search recursively `findstr /s text_to_find *`  

#### Answer 3 (score 106)
<strong>GrepWin</strong> Free and open source (GPL)  

<img src="https://i.stack.imgur.com/M4Ru8.png" alt="enter image description here">I've been using grepWin which was written by one of the tortoisesvn guys.  Does the job on Windows...  

<a href="http://stefanstools.sourceforge.net/grepWin.html" rel="noreferrer">http://stefanstools.sourceforge.net/grepWin.html</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: XAMPP - Port 80 in use by "Unable to open process" with PID 4! 12 (score [481779](https://stackoverflow.com/q/20558410) in 2018)

#### Question
I have been trying to figure out how to fix this problem for two days. I'm new to this kind of thing so I would appreciate it if someone could tell me how to fix it.  

I've tried deleting skype but that didn't work, I've tried turning off the world wide web thing off, IIS off nothing seems to work.  

```sh
12:51:22 PM  [Apache]   Problem detected!
12:51:22 PM  [Apache]   Port 80 in use by "Unable to open process" with PID 4!
12:51:22 PM  [Apache]   Apache WILL NOT start without the configured ports free!
12:51:22 PM  [Apache]   You need to uninstall/disable/reconfigure the blocking application
12:51:22 PM  [Apache]   or reconfigure Apache and the Control Panel to listen on a different port
```

#### Answer 2 (score 333)
<ol>
<li><p>Open a CMD prompt as administrator and execute the following command: </p>

```sh
net stop was /y
```</li>
<li><p>Open the Run dialog box (press <kbd>Win</kbd>+<kbd>R</kbd>), then type: `services.msc`</p>

Then search for <strong>World Wide Web Publishing Service</strong> (WWW-Publishing Service) and <strong>Web Deployment Agent Service</strong> and stop them. You should also disable them.  </li>
<li><p>Start Apache again with XAMPP :)</p></li>
</ol>

Link Ref: <a href="https://www.sitepoint.com/unblock-port-80-on-windows-run-apache/" rel="noreferrer">https://www.sitepoint.com/unblock-port-80-on-windows-run-apache/</a>  

#### Answer 3 (score 135)
Another very easy option is to simply set Apache to listen on a different port. This can be done by clicking on the "Config" button on the same line as the "Apache" module, select the "httpd.conf" file in the dropdown, then change the "Listen 80" line to "Listen 8080". Save the file and close it.  

Now it avoids Port 80 and uses Port 8080 instead without issue. The only additional thing you need to do is make sure to put `localhost:8080` in the browser so the browser knows to look on Port 8080. Otherwise it defaults to Port 80 and won't find your local site.  

This will also require you to restart Apache for the change to take effect.  

Voila! Fixed.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: UnicodeDecodeError: 'charmap' codec can't decode byte X in position Y: character maps to <undefined> (score [480668](https://stackoverflow.com/q/9233027) in 2019)

#### Question
I'm trying to get a Python 3 program to do some manipulations with a text file filled with information. However, when trying to read the file I get the following error:  

<blockquote>
  <p>Traceback (most recent call last):<br>
      File "SCRIPT LOCATION", line NUMBER, in <br>
      `text = file.read()`<br>
      File "C:\Python31\lib\encodings\cp1252.py", line 23, in decode<br>
      `return codecs.charmap_decode(input,self.errors,decoding_table)[0]`<br>
      UnicodeDecodeError: 'charmap' codec can't decode byte 0x90 in position 2907500: character maps to `&lt;undefined&gt;`  </p>
</blockquote>

#### Answer accepted (score 748)
The file in question is not using the `CP1252` encoding. It's using another encoding. Which one you have to figure out yourself. Common ones are `Latin-1` and `UTF-8`. Since <em>0x90</em> doesn't actually mean anything in `Latin-1`, `UTF-8` (where <em>0x90</em> is a continuation byte) is more likely.  

You specify the encoding when you open the file:  

```sh
file = open(filename, encoding="utf8")
```

#### Answer 2 (score 34)
As an extension to <a href="https://stackoverflow.com/a/9233174/3357935">@LennartRegebro's answer</a>:  

If you can't tell what encoding your file uses and the solution above does not work (it's not `utf8`) and you found yourself merely guessing - there are <a href="https://nlp.fi.muni.cz/projects/chared/" rel="nofollow noreferrer">online tools</a> that you could use to identify what encoding that is. They aren't perfect but usually work just fine. After you figure out the encoding you should be able to use solution above.  

<strong>EDIT:</strong> (Copied from comment)  

A quite popular text editor `Sublime Text` has a command to display encoding if it has been set...  

<ol>
<li>Go to `View` -> `Show Console` (or <kbd>Ctrl</kbd>+<kbd>`</kbd>)</li>
</ol>

<a href="https://i.stack.imgur.com/TvXZL.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/TvXZL.png" alt="enter image description here"></a>   

<ol start="2">
<li>Type into field at the bottom `view.encoding()` and hope for the best (I was unable to get anything but `Undefined` but maybe you will have better luck...)</li>
</ol>

<a href="https://i.stack.imgur.com/yz8nN.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/yz8nN.png" alt="enter image description here"></a>   

#### Answer 3 (score 32)
<p>Just to add in case `file = open(filename, encoding="utf8")` does not work
try `file = open(filename, errors='ignore')`</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: Import SQL file into mysql (score [473829](https://stackoverflow.com/q/5152921) in 2018)

#### Question
I have a database called `nitm`. I haven't created any tables there. But I have a SQL file which contains all the necessary data for the database. The file is `nitm.sql` which is in `C:\ drive`. This file has size of about 103 MB. I am using wamp server.  

I have used the following syntax in MySQL console to import the file:  

```sh
mysql>c:/nitm.sql;
```

But this didn't work.  

#### Answer accepted (score 90)
Finally, i solved the problem. I placed the `nitm.sql` file in `bin` file of the `mysql` folder and used the following syntax.  

```sh
C:\wamp\bin\mysql\mysql5.0.51b\bin>mysql -u root nitm < nitm.sql
```

And this worked.  

#### Answer 2 (score 400)
From the mysql console:  

mysql> `use DATABASE_NAME;`  

mysql> `source path/to/file.sql;`  

<br>  

make sure there is no slash before path if you are referring to a relative path... it took me a while to realize that! lol  

#### Answer 3 (score 52)
If you are using wamp you can try this. Just type `use your_Database_name` first.  

<ol>
<li><p>Click your wamp server icon then look for `MYSQL &gt; MSQL Console` then run it.</p></li>
<li><p>If you dont have password, just hit enter and type :</p>

```sh
mysql> use database_name;
mysql> source location_of_your_file;
```

If you have password, you will promt to enter a password. Enter you password first then type:  

```sh
mysql> use database_name;
mysql> source location_of_your_file;
```</li>
</ol>

`location_of_your_file` should look like `C:\mydb.sql`  

so the commend is <strong>mysql>source C:\mydb.sql;</strong>  

This kind of importing sql dump is very helpful for BIG SQL FILE.  

I copied my file `mydb.sq` to directory `C:` .It should be capital C: in order to run  

and that's it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: Adding Python Path on Windows 7 (score [473663](https://stackoverflow.com/q/6318156) in 2016)

#### Question
I've been trying to add the Python path to the command line on Windows 7, yet no matter the method I try, nothing seems to work. I've used the `set` command, I've tried adding it through the Edit Environment variables prompt etc.  

Further more if I run the set command on the command line it lists this  

```sh
python = c:\python27
```

Yet it still doesn't recognize the Python command.  

Reading the documentation, and various other sources hasn't seemed to help.  

Edit: Just to clarify further, I've appended the path of the Python executable to PATH in edit environment prompt. Doesn't seem to work.  

#### Answer 2 (score 264)
<ol>
<li>Hold <kbd>Win</kbd> and press <kbd>Pause</kbd>.</li>
<li>Click Advanced System Settings.</li>
<li>Click Environment Variables.</li>
<li>Append `;C:\python27` to the `Path` variable.</li>
<li>Restart Command Prompt.</li>
</ol>

#### Answer 3 (score 111)
<p>When setting Environmental Variables in Windows, I have gone wrong on many, many occasions. 
I thought I should share a few of my past mistakes here hoping that it might help someone.
(These apply to all Environmental Variables, not just when setting Python Path)</p>

Watch out for these possible mistakes:  

<ol>
<li>Kill and reopen your shell window: Once you make a change to the ENVIRONMENTAL Variables, you have to <strong>restart</strong> the window you are testing it on.</li>
<li><strong>NO SPACES</strong> when setting the Variables. Make sure that you are adding the `;C:\Python27` WITHOUT any spaces. (It is common to try `C:\SomeOther; C:\Python27` That space (␣) after the semicolon is <em>not okay.)</em></li>
<li>USE A <strong>BACKWARD SLASH</strong> when spelling out your full path. You will see forward slashes when you try `echo $PATH` but only backward slashes have worked for me.</li>
<li><strong>DO NOT ADD a final backslash</strong>. Only `C:\Python27` NOT `C:\Python27\`</li>
</ol>

Hope this helps someone.    

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: How to run a makefile in Windows? (score [450355](https://stackoverflow.com/q/2532234) in 2013)

#### Question
I have some demos that I downloaded and they come with a Makefile.win and a Makefile.sgi. How can I run these in Windows to compile the demos?  

#### Answer accepted (score 100)
If you have Visual Studio, run the Visual Studio Command prompt from the Start menu, change to the directory containing `Makefile.win` and type this:  

```sh
nmake -f Makefile.win
```

You can also use the normal command prompt and run vsvars32.bat (c:\Program Files (x86)\Microsoft Visual Studio 9.0\Common7\Tools for VS2008). This will set up the environment to run nmake and find the compiler tools.  

#### Answer 2 (score 44)
Check out <a href="http://www.cygwin.com/" rel="noreferrer">cygwin</a>, a Unix alike environment for Windows  

#### Answer 3 (score 32)
Check out <a href="http://gnuwin32.sourceforge.net/">GnuWin</a>'s <a href="http://gnuwin32.sourceforge.net/packages/make.htm">make</a>, which provides a native port for Windows (without requiring a full runtime environment like Cygwin)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: How do you loop through each line in a text file using a windows batch file? (score [448770](https://stackoverflow.com/q/155932) in 2010)

#### Question
I would like to know how to loop through each line in a text file using a Windows batch file and process each line of text in succession.  

#### Answer accepted (score 281)
The posts below helped greatly, but did not do what I stated in my question where I needed to process the entire line as a whole.  Here is what I found to work.  

```sh
for /F "tokens=*" %%A in (myfile.txt) do [process] %%A
```

The tokens keyword with an asterisk (*) will pull all text for the entire line.  If you don't put in the asterisk it will only pull the first word on the line.  I assume it has to do with spaces.    

<a href="http://technet.microsoft.com/en-us/library/bb490909.aspx" rel="noreferrer">For Command on TechNet</a>  

I appreciate all of the posts!  

<hr>

If there are spaces in your file path, you need to use `usebackq`. For example.  

```sh
for /F "usebackq tokens=*" %%A in ("my file.txt") do [process] %%A
```

#### Answer 2 (score 54)
From the Windows command line reference:  

To parse a file, ignoring commented lines, type:  

```sh
for /F "eol=; tokens=2,3* delims=," %i in (myfile.txt) do @echo %i %j %k
```

This command parses each line in Myfile.txt, ignoring lines that begin with a semicolon and passing the second and third token from each line to the FOR body (tokens are delimited by commas or spaces). The body of the FOR statement references %i to get the second token, %j to get the third token, and %k to get all of the remaining tokens.   

If the file names that you supply contain spaces, use quotation marks around the text (for example, "File Name"). To use quotation marks, you must use usebackq. Otherwise, the quotation marks are interpreted as defining a literal string to parse.  

By the way, you can find the command-line help file on most Windows systems at:  

```sh
 "C:\WINDOWS\Help\ntcmds.chm"
```

#### Answer 3 (score 31)
In a Batch File you <strong>MUST</strong> use `%%` instead of `%` : (Type `help for`)  

```sh
for /F "tokens=1,2,3" %%i in (myfile.txt) do call :process %%i %%j %%k
goto thenextstep
:process
set VAR1=%1
set VAR2=%2
set VAR3=%3
COMMANDS TO PROCESS INFORMATION
goto :EOF
```

<p>What this does:
The "do call :process %%i %%j %%k" at the end of the for command passes the information acquired in the for command from myfile.txt to the "process" 'subroutine'.</p>

When you're using the for command in a batch program, you need to use double % signs for the variables.  

The following lines pass those variables from the for command to the process 'sub routine' and allow you to process this information.  

```sh
set VAR1=%1
 set VAR2=%2
 set VAR3=%3
```

I have some pretty advanced uses of this exact setup that I would be willing to share if further examples are needed.  Add in your EOL or Delims as needed of course.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: A Windows equivalent of the Unix tail command (score [439478](https://stackoverflow.com/q/187587) in 2018)

#### Question
I'm looking for the equivalent of the Unix 'tail' command that will allow me to watch the output of a log file while it is being written to.  

#### Answer accepted (score 132)
I'd suggest installing something like <a href="http://sourceforge.net/projects/unxutils/" rel="noreferrer">GNU Utilities for Win32</a>.  It has most favourites, including tail.  

#### Answer 2 (score 408)
If you use PowerShell then this works:   

```sh
Get-Content filenamehere -Wait -Tail 30
```

Posting Stefan's comment from below, so people don't miss it    

PowerShell 3 introduces a -Tail parameter to include only the last x lines   

#### Answer 3 (score 61)
I've always used <a href="http://www.baremetalsoft.com/baretail/" rel="noreferrer">Baretail</a> for tailing in Windows. It's free and pretty nice.  

Edit: for a better description of Baretail see <s><a href="https://stackoverflow.com/questions/113121/best-tail-log-file-visualization-freeware-tool">this question</a></s>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: CALL command vs. START with /WAIT option (score [433307](https://stackoverflow.com/q/13257571) in 2014)

#### Question
How is the START command with a WAIT option   

```sh
START /wait notepad.exe 
START /wait  notepad.exe 
```

...any different from using a CALL command?  

```sh
CALL notepad.exe 
CALL notepad.exe 
```

Is there a situation where one may behave differently that the other dependending on what is being executed?  

#### Answer accepted (score 159)
<p>For <em>exe</em> files, I suppose the differences are nearly unimportant.<br>
But to start an <em>exe</em> you don't even need `CALL`.  </p>

<p>When starting another batch it's a big difference,<br>
as `CALL` will start it in the same window and the called batch has access  to the same variable context.<br>
So it can also change variables which affects the caller.  </p>

<p>`START` will create a new cmd.exe for the called batch and without /b it will open a new window.<br>
As it's a new context, variables can't be shared.</p>

<h5>Differences</h1>

<p><strong>Using `start /wait &lt;prog&gt;`</strong><br>
- Changes of environment variables are lost when the `&lt;prog&gt;` ends<br>
- The caller waits until the `&lt;prog&gt;` is finished</p>

<p><strong>Using `call &lt;prog&gt;`</strong><br>
- For <em>exe</em> it can be ommited, because it's equal to just starting `&lt;prog&gt;`<br>
- For an <em>exe-prog</em> the caller batch waits or starts the <em>exe</em> asynchronous, but the behaviour depends on the <em>exe</em> itself.<br>
- For <em>batch</em> files, the caller batch continues, when the called `&lt;batch-file&gt;` finishes, WITHOUT call the control will not return to the caller batch</p>

<h5>Addendum:</h1>  

Using `CALL` can change the parameters (for batch and exe files), but only when they contain carets or percent signs.  

```sh
call myProg param1 param^^2 "param^3" %%path%%
```

Will be expanded to (from within an batch file)    

```sh
myProg param1 param2 param^^3 <content of path>
```

#### Answer 2 (score 15)
<p>I think that they should perform generally the same, but there are some differences.
`START` is generally used to start applications or to start the default application for a given file type.  That way if you `START http://mywebsite.com` it doesn't do `START iexplore.exe http://mywebsite.com`.</p>

`START myworddoc.docx` would start Microsoft Word and open myworddoc.docx.`CALL myworddoc.docx` does the same thing... however `START` provides more options for the window state and things of that nature. It also allows process priority and affinity to be set.  

In short, given the additional options provided by start, it should be your tool of choice.  

```sh
START ["title"] [/D path] [/I] [/MIN] [/MAX] [/SEPARATE | /SHARED]
  [/LOW | /NORMAL | /HIGH | /REALTIME | /ABOVENORMAL | /BELOWNORMAL]
  [/NODE <NUMA node>] [/AFFINITY <hex affinity mask>] [/WAIT] [/B]
  [command/program] [parameters]

"title"     Title to display in window title bar.
path        Starting directory.
B           Start application without creating a new window. The
            application has ^C handling ignored. Unless the application
            enables ^C processing, ^Break is the only way to interrupt
            the application.
I           The new environment will be the original environment passed
            to the cmd.exe and not the current environment.
MIN         Start window minimized.
MAX         Start window maximized.
SEPARATE    Start 16-bit Windows program in separate memory space.
SHARED      Start 16-bit Windows program in shared memory space.
LOW         Start application in the IDLE priority class.
NORMAL      Start application in the NORMAL priority class.
HIGH        Start application in the HIGH priority class.
REALTIME    Start application in the REALTIME priority class.
ABOVENORMAL Start application in the ABOVENORMAL priority class.
BELOWNORMAL Start application in the BELOWNORMAL priority class.
NODE        Specifies the preferred Non-Uniform Memory Architecture (NUMA)
            node as a decimal integer.
AFFINITY    Specifies the processor affinity mask as a hexadecimal number.
            The process is restricted to running on these processors.

            The affinity mask is interpreted differently when /AFFINITY and
            /NODE are combined.  Specify the affinity mask as if the NUMA
            node's processor mask is right shifted to begin at bit zero.
            The process is restricted to running on those processors in
            common between the specified affinity mask and the NUMA node.
            If no processors are in common, the process is restricted to
            running on the specified NUMA node.
WAIT        Start application and wait for it to terminate.
```

#### Answer 3 (score 9)
<p>There is a useful difference between `call` and `start /wait` when calling `regsvr32.exe /s` for example, also referenced by <a href="https://stackoverflow.com/users/236365/gary">Gary </a>in 
in his answer to <a href="https://stackoverflow.com/questions/334879/how-do-i-get-the-application-exit-code-from-a-windows-command-line">how-do-i-get-the-application-exit-code-from-a-windows-command-line</a></p>

```sh
call regsvr32.exe /s broken.dll
echo %errorlevel%
```

will always return 0 but  

```sh
start /wait regsvr32.exe /s broken.dll
echo %errorlevel%
```

will return the error level from regsvr32.exe   

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: Error: ANDROID_HOME is not set and "android" command not in your PATH. You must fulfill at least one of these conditions. (score [433019](https://stackoverflow.com/q/26356359) in 2017)

#### Question
I'm trying to install PhoneGap and I'm getting the following error:  

<blockquote>
  Error: ANDROID_HOME is not set and "android" command not in your PATH. You must fulfill at least one of these conditions.  
</blockquote>

<h5>Error (screenshot)</h3>

<img src="https://i.stack.imgur.com/4MMNK.png" alt="enter image description here">  

What do I do to ensure Android is set up correctly for use with Cordova?  

#### Answer accepted (score 348)
For Windows:  

<blockquote>
  set ANDROID_HOME=C:\ <em>installation location</em> \android-sdk  
  
  set PATH=%PATH%;%ANDROID_HOME%\tools;%ANDROID_HOME%\platform-tools  
</blockquote>

Taken from this <a href="https://web.archive.org/web/20180210044548/http://spring.io/guides/gs/android/" rel="noreferrer">installation guide</a>.  

#### Answer 2 (score 79)
For Mac OS X:  

```sh
export ANDROID_HOME=/<installation location>/android-sdk-macosx
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

#### Answer 3 (score 45)
I have MAC OS X Yosemite, Android Studio 1.0.1, JDK 1.8, and Cordova 4.1.2   

When I tried to add the android project:  

```sh
cordova platforms add android
```

<p>I received the message:
<em>ANDROID_HOME is not set and "android" command not in your PATH</em></p>

<p>Based in cforcloud's answer... 
<a href="https://stackoverflow.com/questions/24580966/error-the-command-android-failed-using-cordova/26186336#26186336">&#39;Error: the command &quot;android&quot; failed&#39; using cordova</a>
and
<a href="http://developer.android.com/sdk/installing/index.html?pkg=studio" rel="noreferrer">http://developer.android.com/sdk/installing/index.html?pkg=studio</a>
I used the following:</p>

```sh
export ANDROID_HOME="/Users/<user_name>/Library/Android/sdk"
export ANDROID_TOOLS="/Users/<user_name>/Library/Android/sdk/tools/"
export ANDROID_PLATFORM_TOOLS="/Users/<user_name>/Library/Android/sdk/platform-tools/"
PATH=$PATH:$ANDROID_HOME:$ANDROID_TOOLS:$ANDROID_PLATFORM_TOOLS
echo $PATH
```

When I tried to create the android project, I received this message:  

```sh
Creating android project...
/Users/lg/.cordova/lib/npm_cache/cordova-android/3.6.4/package/bin/node_modules/q/q.js:126
                    throw e;
                          ^
Error: Please install Android target "android-19".
```

I ran Android SDK Manager, and installed Android 4.4.2 (API 19) (everything but Glass Development Kit Preview). It worked for me.  

===  

This is the content of my .bash_profile file.  

```sh
export PATH=$PATH:/usr/local/bin
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
launchctl setenv STUDIO_JDK /library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk
export ANDROID_HOME="/Users/<UserName>/Library/Android/sdk"
export ANDROID_TOOLS="/Users/<UserName>/Library/Android/sdk/tools"
export ANDROID_PLATFORM_TOOLS="/Users/<UserName>/Library/Android/sdk/platform-tools"
PATH=$PATH:$ANDROID_HOME:$ANDROID_TOOLS:$ANDROID_PLATFORM_TOOLS
```

To edit .bash_profile using Terminal, I use nano. It is easy to understand.  

```sh
cd
nano .bash_profile
```

I hope it helps.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: Get Folder Size from Windows Command Line (score [432778](https://stackoverflow.com/q/12813826) in 2016)

#### Question
Is it possible in Windows to get a folder's size from the command line without using any 3rd party tool?  

I want the same result as you would get when right clicking the folder in the windows explorer → properties.  

#### Answer accepted (score 109)
You can just add up sizes recursively (the following is a batch file):  

```sh
@echo off
set size=0
for /r %%x in (folder\*) do set /a size+=%%~zx
echo %size% Bytes
```

However, this has several problems because `cmd` is limited to 32-bit signed integer arithmetic. So it will get sizes above 2 GiB wrong<sup>1</sup>. Furthermore it will likely count symlinks and junctions multiple times so it's at best an upper bound, not the true size (you'll have that problem with any tool, though).  

An alternative is PowerShell:  

```sh
Get-ChildItem -Recurse | Measure-Object -Sum Length
```

or shorter:  

```sh
ls -r | measure -s Length
```

If you want it prettier:  

```sh
switch((ls -r|measure -s Length).Sum) {
  {$_ -gt 1GB} {
    '{0:0.0} GiB' -f ($_/1GB)
    break
  }
  {$_ -gt 1MB} {
    '{0:0.0} MiB' -f ($_/1MB)
    break
  }
  {$_ -gt 1KB} {
    '{0:0.0} KiB' -f ($_/1KB)
    break
  }
  default { "$_ bytes" }
}
```

You can use this directly from `cmd`:  

```sh
powershell -noprofile -command "ls -r|measure -s Length"
```

<hr>

<sup>1</sup> I do have a partially-finished bignum library in batch files somewhere which at least gets arbitrary-precision integer addition right. I should really release it, I guess :-)  

#### Answer 2 (score 102)
There is a <strong>built-in Windows tool</strong> for that:  

```sh
dir /s 'FolderName'
```

This will print a lot of unnecessary information but the end will be the folder size like this:  

```sh
 Total Files Listed:
       12468 File(s)    182,236,556 bytes
```

If you need to include hidden folders add `/a`.  

#### Answer 3 (score 63)
<p>I suggest to download utility DU from the Sysinternals Suite provided by Microsoft at this link
<a href="http://technet.microsoft.com/en-us/sysinternals/bb896651" rel="noreferrer">http://technet.microsoft.com/en-us/sysinternals/bb896651</a></p>

```sh
usage: du [-c] [-l <levels> | -n | -v] [-u] [-q] <directory>
   -c     Print output as CSV.
   -l     Specify subdirectory depth of information (default is all levels).
   -n     Do not recurse.
   -q     Quiet (no banner).
   -u     Count each instance of a hardlinked file.
   -v     Show size (in KB) of intermediate directories.


C:\SysInternals>du -n d:\temp

Du v1.4 - report directory disk usage
Copyright (C) 2005-2011 Mark Russinovich
Sysinternals - www.sysinternals.com

Files:        26
Directories:  14
Size:         28.873.005 bytes
Size on disk: 29.024.256 bytes
```

While you are at it, take a look at the other utilities. They are a life-saver for every Windows Professional  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Redirect Windows cmd stdout and stderr to a single file (score [431021](https://stackoverflow.com/q/1420965) in 2017)

#### Question
I'm trying to redirect all output (stdout + stderr) of a <a href="http://en.wikipedia.org/wiki/DOS" rel="noreferrer">DOS</a> command to a single file:  

```sh
C:\>dir 1> a.txt 2> a.txt
The process cannot access the file because it is being used by another process.
```

Is it possible, or should I just redirect to two separate files?  

#### Answer accepted (score 1022)
You want:  

```sh
dir > a.txt 2>&1
```

The syntax `2&gt;&amp;1` will redirect `2` (stderr) to `1` (stdout). You can also hide messages by redirecting to `NUL`, <a href="https://support.microsoft.com/en-us/help/110930/redirecting-error-messages-from-command-prompt-stderr-stdout" rel="noreferrer">more explanation and examples on MSDN</a>.  

#### Answer 2 (score 191)
Anders Lindahl's answer is correct, but it should be noted that if you are redirecting stdout to a file and want to redirect stderr as well then you MUST ensure that `2&gt;&amp;1` is specified <strong>AFTER</strong> the `1&gt;` redirect, otherwise it will not work.  

```sh
REM *** WARNING: THIS WILL NOT REDIRECT STDERR TO STDOUT ****
dir 2>&1 > a.txt
```

#### Answer 3 (score 76)
<h5>Background info from MSKB</h1>

While the accepted answer to this question is correct, it really doesn't do much to explain <em>why</em> it works, and since the syntax is not immediately clear I did a quick google to find out what was actually going on.  In the hopes that this information is helpful to others, I'm posting it here.  

Taken from <a href="https://support.microsoft.com/en-us/help/110930/redirecting-error-messages-from-command-prompt-stderr-stdout" rel="noreferrer">MS Support KB 110930</a>.   

<hr>

<h5>From MSKB110930</h1>

<blockquote>
  <h5>Redirecting Error Messages from Command Prompt: STDERR/STDOUT</h1>
  
  <h5>Summary</h2>
  
  When redirecting output from an application using the '>' symbol, error messages still print to the screen. This is because error messages are often sent to the Standard Error stream instead of the Standard Out stream.  
  
  Output from a console (Command Prompt) application or command is often sent to two separate streams. The regular output is sent to Standard Out (STDOUT) and the error messages are sent to Standard Error (STDERR). When you redirect console output using the ">" symbol, you are only redirecting STDOUT. In order to redirect STDERR you have to specify '2>' for the redirection symbol. This selects the second output stream which is STDERR.  
  
  <h5>Example</h2>
  
  The command `dir file.xxx` (where `file.xxx` does not exist) will display the following output:  

```sh
Volume in drive F is Candy Cane Volume Serial Number is 34EC-0876

File Not Found
```
  
  If you redirect the output to the `NUL` device using `dir file.xxx &gt; nul`, you will still see the error message part of the output, like this:  

```sh
File Not Found
```
  
  To redirect (only) the error message to `NUL`, use the following command:  

```sh
dir file.xxx 2> nul
```
  
  Or, you can redirect the output to one place, and the errors to another.  

```sh
dir file.xxx > output.msg 2> output.err
```
  
  You can print the errors and standard output to a single file by using the "&amp;1" command to redirect the output for STDERR to STDOUT and then sending the output from STDOUT to a file:  

```sh
dir file.xxx 1> output.msg 2>&1
```
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Windows batch files: .bat vs .cmd? (score [430244](https://stackoverflow.com/q/148968) in 2015)

#### Question
As I understand it, `.bat` is the old 16-bit naming convention, and `.cmd` is for 32-bit Windows, i.e., starting with NT. But I continue to see .bat files everywhere, and they seem to work exactly the same using either suffix. Assuming that my code will never need to run on anything older than NT, does it really matter which way I name my batch files, or is there some <strong>gotcha</strong> awaiting me by using the wrong suffix?  

#### Answer accepted (score 425)
From <a href="https://groups.google.com/group/microsoft.public.win2000.cmdprompt.admin/msg/ad9066638815812c" rel="noreferrer">this news group posting</a> by <a href="http://en.wikipedia.org/wiki/Mark_Zbikowski" rel="noreferrer">Mark Zbikowski</a> himself:  

<blockquote>
  <p>The differences between .CMD and .BAT as far as CMD.EXE is concerned
  are:  With extensions enabled, PATH/APPEND/PROMPT/SET/ASSOC in .CMD 
  files will set ERRORLEVEL regardless of error. .BAT sets ERRORLEVEL 
  only on errors.</p>
</blockquote>

In other words, if ERRORLEVEL is set to non-0 and then you run one of those commands, the resulting ERRORLEVEL will be:  

<ul>
<li>left alone at its non-0 value in a .bat file </li>
<li>reset to 0 in a .cmd file. </li>
</ul>

#### Answer 2 (score 397)
Here is a compilation of verified information from the various answers and cited references in this thread:  

<ol>
<li>`command.com` is the 16-bit command processor introduced in MS-DOS and was also used in the Win9x series of operating systems.</li>
<li>`cmd.exe` is the 32-bit command processor in Windows NT (64-bit Windows OSes also have a 64-bit version). `cmd.exe` was never part of Windows 9x.  It originated in OS/2 version 1.0, and the OS/2 version of `cmd` began 16-bit (but was nonetheless a fully fledged protected mode program with commands like `start`).  Windows NT inherited `cmd` from OS/2, but Windows NT's Win32 version started off 32-bit.  Although OS/2 went 32-bit in 1992, its `cmd` remained a 16-bit OS/2 1.x program.</li>
<li>The `ComSpec` env variable defines which program is launched by `.bat` and `.cmd` scripts. (Starting with WinNT this defaults to `cmd.exe`.)</li>
<li>`cmd.exe` is backward compatible with `command.com`.</li>
<li>A script that is designed for `cmd.exe` can be named `.cmd` to prevent accidental execution on Windows 9x.  This filename extension also dates back to OS/2 version 1.0 and 1987.</li>
</ol>

Here is a list of `cmd.exe` features that are not supported by `command.com`:  

<ul>
<li>Long filenames (exceeding the 8.3 format)</li>
<li>Command history</li>
<li>Tab completion</li>
<li>Escape character: `^` (Use for: `\ &amp; | &gt; &lt; ^`)</li>
<li>Directory stack: `PUSHD`/`POPD`</li>
<li>Integer arithmetic: `SET /A i+=1`</li>
<li>Search/Replace/Substring: `SET %varname:expression%`</li>
<li>Command substitution: `FOR /F` (existed before, has been enhanced)</li>
<li>Functions: `CALL :label`</li>
</ul>

Order of Execution:  

If both .bat and .cmd versions of a script (test.bat, test.cmd) are in the same folder and you run the script without the extension (test), by default the .bat version of the script will run, even on 64-bit Windows 7. The order of execution is controlled by the PATHEXT environment variable. See <a href="https://stackoverflow.com/questions/605101/order-in-which-command-prompt-executes-files-with-the-same-name-a-bat-vs-a-cmd-v">Order in which Command Prompt executes files</a> for more details.  

References:  

<ul>
<li><a href="http://www.ss64.com/ntsyntax/" rel="noreferrer">cmd.exe</a></li>
<li><a href="http://gregvogl.net/courses/os/handouts/doscmdref.pdf" rel="noreferrer" title="PDF">command.com</a></li>
</ul>

wikipedia: <a href="http://en.wikipedia.org/wiki/Comparison_of_computer_shells" rel="noreferrer">Comparison of command shells</a>  

#### Answer 3 (score 69)
These answers are a bit too long and focused on interactive use.  The important differences for scripting are:  

<ul>
<li>`.cmd` prevents inadvertent execution on non-NT systems.</li>
<li>`.cmd` enables built-in commands to change Errorlevel to 0 on success.</li>
</ul>

There used to also be a number of additional features enabled in .cmd files.  However, Command Extensions are on by default in both .bat and .cmd files under Windows 2000 or later.  

Bottom line: in 2012 and beyond, I recommend using `.cmd` exclusively.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: How to connect from windows command prompt to mysql command line (score [419573](https://stackoverflow.com/q/13752424) in 2012)

#### Question
I'm trying to connect to mysql server command line from my windows prompt  

I write the next line in cmd but i get an error.  

```sh
cd C:\MYSQL\bin\
```

And then i execute   

```sh
mysql.exe -u=root -p=admin
```

but i getting this error  

```sh
ERROR 1045: <28000>: Access denied for user 'root'@'localhost' <using password:YES>
```

Thanks,   

#### Answer accepted (score 76)
The `cd` in your question is invalid (quoting it here because you've removed it once, and it was there when this answer was posted):  

```sh
cd CD:\MYSQL\bin\
```

You can't `cd` to `CD:\` anything, because `CD:\` isn't a valid directory in Windows. `CD:` would indicate a drive, except that drives are restricted to a single letter between `A` and `Z`.   

If your `\MYSQL\BIN` is on drive `C:`, then your commands need to be:  

```sh
C:\>cd \MYSQL\Bin
C:\MYSQL\Bin>mysql -u root -p admin
```

If you're not already on `C:` (which you'll know by looking at the prompt in the cmd window), or your MySQL folder is on another drive (for instance, `D:`), change to that drive too:  

```sh
C:\> cd /d D:\MYSQL\Bin
D:\MYSQL\Bin>mysql -u root -p admin
```

The `.exe` after `mysql` is optional, since `.exe` is an executable extension on Windows. If you type `mysql`, Windows will automatically look for an executable file with that name and run it if it finds it.  

Note that in both my examples of running `mysql`, there are no `=` signs. You should just use `-p` with no password, and wait to be prompted for it instead.  

#### Answer 2 (score 14)
Use this :  

```sh
mysql -u user_name -p  then press_enter_key
```

then type password  

i.e.  

```sh
line-1 : mysql -u root -p

line-2 : admin
```

#### Answer 3 (score 6)
first type `cmd` then the windows command prompt will appear:  

```sh
PATH C:\XAMPP\MYSQL\BIN;%PATH%;
mysql -u root -p
```

where:  

<ul>
<li>-u is the user id</li>
<li>-p is the password, if you will not using a password just leave it blank.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: What's the fastest way to delete a large folder in Windows? (score [417534](https://stackoverflow.com/q/186737) in 2014)

#### Question
I want to delete a folder that contains thousands of files and folders. If I use Windows Explorer to delete the folder it can take 10-15 minutes (not always, but often). Is there a faster way in Windows to delete folders?   

Other details:  

<ul>
<li>I don't care about the recycle bin.</li>
<li>It's an NTFS drive.</li>
</ul>

#### Answer accepted (score 326)
Use Windows Command Prompt:   

```sh
rmdir /s /q folder
```

#### Answer 2 (score 942)
The worst way is to send to Recycle Bin: you still need to delete them. Next worst is shift+delete with Windows Explorer: it wastes loads of time checking the contents before starting deleting anything.   

Next best is to use `rmdir /s/q foldername` from the command line. `del /f/s/q foldername` is good too, but it leaves behind the directory structure.  

The best I've found is a two line batch file with a first pass to delete files and outputs to nul to avoid the overhead of writing to screen for every singe file. A second pass then cleans up the remaining directory structure:  

```sh
del /f/s/q foldername > nul
rmdir /s/q foldername
```

This is nearly three times faster than a single rmdir, based on time tests with a Windows XP encrypted disk, deleting ~30GB/1,000,000 files/15,000 folders: `rmdir` takes ~2.5 hours, `del+rmdir` takes ~53 minutes. More info at <a href="https://superuser.com/questions/19762/mass-deleting-files-in-windows/289399#289399">Super User</a>.   

This is a regular task for me, so I usually move the stuff I need to delete to C:\stufftodelete and have those `del+rmdir` commands in a deletestuff.bat batch file. This is scheduled to run at night, but sometimes I need to run it during the day so the quicker the better.  

Technet documentation for `del` command can be found <a href="https://technet.microsoft.com/en-us/library/cc771049(v=ws.11).aspx" rel="noreferrer">here</a>.  Additional info on the parameters used above:  

<ul>
<li>`/f` - Force (i.e. delete files even if they're read only)</li>
<li>`/s` - Recursive / Include Subfolders (this definition from <a href="https://ss64.com/nt/del.html" rel="noreferrer">SS64</a>, as technet simply states "specified files", which isn't helpful).</li>
<li>`/q` - Quiet (i.e. do not prompt user for confirmation)</li>
</ul>

Documentation for `rmdir` <a href="https://technet.microsoft.com/en-us/library/cc726055(v=ws.11).aspx" rel="noreferrer">here</a>.  Parameters are:  

<ul>
<li>`/s` - Recursive (i.e. same as del's /s parameter)</li>
<li>`/q` - Quiet (i.e. same as del's /q parameter)</li>
</ul>

#### Answer 3 (score 6)
<p>use <a href="http://www.ipmsg.org/tools/fastcopy.html.en" rel="noreferrer">fastcopy</a>, a free tool.
 it has a delete option that is a lot faster then the way windows deletes files.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: Using parameters in batch files at Windows command line (score [417385](https://stackoverflow.com/q/14286457) in 2017)

#### Question
In Windows, how do you access arguments passed when a batch file is run?    

For example, let's say I have a program named `hello.bat`.  When I enter `hello -a` at a Windows command line, how do I let my program know that `-a` was passed in as an argument?  

#### Answer accepted (score 277)
As others have already said, parameters passed through the command line can be accessed in batch files with the notation `%1` to `%9`. There are also two other tokens that you can use:  

<ul>
<li>`%0` is <strong>the executable (batch file) name as specified in the command line</strong>.</li>
<li>`%*` is <strong>all parameters specified in the command line</strong> -- this is very useful if you want to forward the parameters to another program.</li>
</ul>

There are also lots of important techniques to be aware of in addition to simply how to access the parameters.  

<h5>Checking if a parameter was passed</h3>

This is done with constructs like `IF "%~1"==""`, which is true if and only if no arguments were passed at all. Note the tilde character which causes any surrounding quotes to be removed from the value of `%1`; without a tilde you will get unexpected results if that value includes double quotes, including the possibility of syntax errors.  

<h5>Handling more than 9 arguments (or just making life easier)</h3>

If you need to access more than 9 arguments you have to use the command `SHIFT`. This command shifts the values of all arguments one place, so that `%0` takes the value of `%1`, `%1` takes the value of `%2`, etc. `%9` takes the value of the tenth argument (if one is present), which was not available through any variable before calling `SHIFT` (enter command `SHIFT /?` for more options).  

`SHIFT` is also useful when you want to easily process parameters without requiring that they are presented in a specific order. For example, a script may recognize the flags `-a` and `-b` in any order. A good way to parse the command line in such cases is  

```sh
:parse
IF "%~1"=="" GOTO endparse
IF "%~1"=="-a" REM do something
IF "%~1"=="-b" REM do something else
SHIFT
GOTO parse
:endparse
REM ready for action!
```

This scheme allows you to parse pretty complex command lines without going insane.  

<h5>Substitution of batch parameters</h3>

For parameters that represent file names the shell provides lots of functionality related to working with files that is not accessible in any other way. This functionality is accessed with constructs that begin with `%~`.  

For example, to get the size of the file passed in as an argument use  

```sh
ECHO %~z1
```

To get the path of the directory where the batch file was launched from (very useful!) you can use  

```sh
ECHO %~dp0
```

You can view the full range of these capabilities by typing `CALL /?` in the command prompt.  

#### Answer 2 (score 54)
<strong>Using parameters in batch files: %0 and %9</strong>  

Batch files can refer to the words passed in as parameters with the tokens: `%0` to `%9`.  

```sh
%0 is the program name as it was called.
%1 is the first command line parameter
%2 is the second command line parameter
and so on till %9.
```

parameters passed in on the commandline must be alphanumeric characters and delimited by spaces.  Since `%0` is the program name as it was called, in DOS `%0` will be empty for AUTOEXEC.BAT if started at boot time.  

<strong>Example:</strong>  

Put the following command in a batch file called `mybatch.bat`:  

```sh
@echo off
@echo hello %1 %2
pause
```

Invoking the batch file like this: `mybatch john billy` would output:  

```sh
hello john billy
```

<strong>Get more than 9 parameters for a batch file, use: %*</strong>  

The Percent Star token `%*` means "the rest of the parameters".  You can use a for loop to grab them, as defined here:  

<a href="http://www.robvanderwoude.com/parameters.php">http://www.robvanderwoude.com/parameters.php</a>  

<strong>Notes about delimiters for batch parameters</strong>  

Some characters in the command line parameters are ignored by batch files, depending on the DOS version, whether they are "escaped" or not, and often depending on their location in the command line:  

```sh
commas (",") are replaced by spaces, unless they are part of a string in 
double quotes

semicolons (";") are replaced by spaces, unless they are part of a string in 
double quotes

"=" characters are sometimes replaced by spaces, not if they are part of a 
string in double quotes

the first forward slash ("/") is replaced by a space only if it immediately 
follows the command, without a leading space

multiple spaces are replaced by a single space, unless they are part of a 
string in double quotes

tabs are replaced by a single space

leading spaces before the first command line argument are ignored
```

#### Answer 3 (score 5)
Batch Files automatically pass the text after the program so long as their are variables to assign them to. They are passed in order they are sent; e.g. %1 will be the first string sent after the program is called, etc.  

If you have Hello.bat and the contents are:  

```sh
@echo off
echo.Hello, %1 thanks for running this batch file (%2)
pause
```

and you invoke the batch in command via  

<blockquote>
  hello.bat APerson241 %date%  
</blockquote>

you should receive this message back:  

Hello, APerson241 thanks for running this batch file (01/11/2013)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: How to convert DOS/Windows newline (CRLF) to Unix newline (LF) in a Bash script? (score [416217](https://stackoverflow.com/q/2613800) in 2018)

#### Question
How can I programmatically (i.e., not using `vi`) convert DOS/Windows newlines to Unix?  

The `dos2unix` and `unix2dos` commands are not available on certain systems. How can I emulate these with commands like `sed`/`awk`/`tr`?  

#### Answer 2 (score 303)
You can use `tr` to convert from DOS to Unix; however, you can only do this safely if CR appears in your file only as the first byte of a CRLF byte pair.  This is usually the case.  You then use:  

```sh
tr -d '\015' <DOS-file >UNIX-file
```

Note that the name `DOS-file` is different from the name `UNIX-file`; if you try to use the same name twice, you will end up with no data in the file.  

You can't do it the other way round (with standard 'tr').  

If you know how to enter carriage return into a script (<kbd>control-V</kbd>, <kbd>control-M</kbd> to enter control-M), then:  

```sh
sed 's/^M$//'     # DOS to Unix
sed 's/$/^M/'     # Unix to DOS
```

where the '^M' is the control-M character.  You can also use the `bash` <a href="http://www.gnu.org/software/bash/manual/bash.html#ANSI_002dC-Quoting" rel="noreferrer">ANSI-C Quoting</a> mechanism to specify the carriage return:  

```sh
sed $'s/\r$//'     # DOS to Unix
sed $'s/$/\r/'     # Unix to DOS
```

However, if you're going to have to do this very often (more than once, roughly speaking), it is far more sensible to install the conversion programs (e.g. <a href="http://linux.die.net/man/1/dos2unix" rel="noreferrer">`dos2unix`</a> and <a href="http://linux.die.net/man/1/unix2dos" rel="noreferrer">`unix2dos`</a>, or perhaps <a href="http://www.delorie.com/djgpp/doc/utils/utils_4.html" rel="noreferrer">`dtou`</a> and <a href="http://www.delorie.com/djgpp/doc/utils/utils_5.html" rel="noreferrer">`utod`</a>) and use them.  

#### Answer 3 (score 56)
```sh
tr -d "\r" < file
```

take a look <a href="http://sed.sourceforge.net/sed1line.txt" rel="noreferrer">here</a> for examples using `sed`:  

```sh
# IN UNIX ENVIRONMENT: convert DOS newlines (CR/LF) to Unix format.
sed 's/.$//'               # assumes that all lines end with CR/LF
sed 's/^M$//'              # in bash/tcsh, press Ctrl-V then Ctrl-M
sed 's/\x0D$//'            # works on ssed, gsed 3.02.80 or higher

# IN UNIX ENVIRONMENT: convert Unix newlines (LF) to DOS format.
sed "s/$/`echo -e \\\r`/"            # command line under ksh
sed 's/$'"/`echo \\\r`/"             # command line under bash
sed "s/$/`echo \\\r`/"               # command line under zsh
sed 's/$/\r/'                        # gsed 3.02.80 or higher
```

Use <a href="http://www.gnu.org/software/sed/manual/html_node/Invoking-sed.html" rel="noreferrer">`sed -i`</a> for in-place conversion e.g. `sed -i 's/..../' file`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: Get Date in YYYYMMDD format in windows batch file (score [412942](https://stackoverflow.com/q/14810544) in 2013)

#### Question
I need to get the date in YYYYMMDD format in batch file.   

I am doing this using :  

```sh
set mydate=%date:~6,4%%date:~3,2%%date:~0,2%
echo %mydate%
```

I need it to be consistent across system, even on changing the time settings.  

Please advise.  

#### Answer 2 (score 32)
If, after reading the other questions and viewing the links mentioned in the comment sections, you still can't figure it out, read on.  

First of all, where you're going wrong is the offset.  

It should look more like this...  

```sh
set mydate=%date:~10,4%%date:~6,2%/%date:~4,2%
echo %mydate%
```

If the date was `Tue 12/02/2013` then it would display it as `2013/02/12`. to remove the slashes, the code would look more like `set mydate=%date:~10,4%%date:~7,2%%date:~4,2%` which would output `20130212`  

And a hint for doing it in the future, if `mydate` equals something like `%date:~10,4%%date:~7,2%` or the like, you probably forgot a tilde (~).   

#### Answer 3 (score 2)
You can try this ! This should work on windows machines.  

```sh
for /F "usebackq tokens=1,2,3 delims=-" %%I IN (`echo %date%`) do echo "%%I" "%%J" "%%K"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: How can I open Java .class files in a human-readable way? (score [412591](https://stackoverflow.com/q/76314) in 2011)

#### Question
I'm trying to figure out what a Java applet's class file is doing under the hood. Opening it up with Notepad or Textpad just shows a bunch of gobbledy-gook.  

Is there any way to wrangle it back into a somewhat-readable format so I can try to figure out what it's doing?  

<ul>
<li>Environment == Windows w/ VS 2008 installed.</li>
</ul>

#### Answer accepted (score 200)
<a href="http://jd.benow.ca/" rel="noreferrer">jd-gui</a> is the best decompiler at the moment. it can handle newer features in Java, as compared to the getting-dusty JAD.  

#### Answer 2 (score 73)
If you don't mind reading bytecode, javap should work fine. It's part of the standard JDK installation.  

```sh
Usage: javap <options> <classes>...

where options include:
   -c                        Disassemble the code
   -classpath <pathlist>     Specify where to find user class files
   -extdirs <dirs>           Override location of installed extensions
   -help                     Print this usage message
   -J<flag>                  Pass <flag> directly to the runtime system
   -l                        Print line number and local variable tables
   -public                   Show only public classes and members
   -protected                Show protected/public classes and members
   -package                  Show package/protected/public classes
                             and members (default)
   -private                  Show all classes and members
   -s                        Print internal type signatures
   -bootclasspath <pathlist> Override location of class files loaded
                             by the bootstrap class loader
   -verbose                  Print stack size, number of locals and args for methods
                             If verifying, print reasons for failure
```

#### Answer 3 (score 7)
You want a java decompiler, you can use the command line tool `javap` to do this.  Also, <a href="http://www.faqs.org/docs/Linux-HOWTO/Java-Decompiler-HOWTO.html" rel="noreferrer">Java Decompiler HOW-TO</a> describes how you can decompile a class file.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: Run a task every x-minutes with Windows Task Scheduler (score [412366](https://stackoverflow.com/q/4249542) in 2017)

#### Question
I'm trying to get Windows Task Scheduler to run a particular .exe every 10 minutes or so, but the options only allow for once a day execution.  

Is there a way I can get it to run a .exe every 10 or 20 minutes?  

#### Answer accepted (score 365)
The task must be configured in two steps.  

First you create a simple task that start at 0:00, every day. Then, you go in `Advanced...` (or similar depending on the operating system you are on) and select the `Repeat every X minutes` option for 24 hours.  

The key here is to find the advanced properties. If you are using the XP wizard, it will only offer you to launch the advanced dialog once you created the task.  

On more recent versions of Windows (7+ I think?):  

<ol>
<li>Double click the task and a property window will show up.</li>
<li>Click the `Triggers` tab.</li>
<li>Double click the trigger details and the Edit Trigger window will show up.</li>
<li>Under `Advanced settings` panel, tick `Repeat task every` xxx minutes, and set `Indefinitely` if you need.</li>
<li>Finally, click ok.</li>
</ol>

#### Answer 2 (score 38)
After you select the minimum repeat option (5 minutes or 10 minutes) you can highlight the number and write whatever number you want   

#### Answer 3 (score 29)
You can also create a batch file like the following if you need finer granularity between calls:  

```sh
:loop
CallYour.Exe
timeout /t timeToWaitBetweenCallsInSeconds /nobreak
goto :loop
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: "X does not name a type" error in C++ (score [409958](https://stackoverflow.com/q/2133250) in 2018)

#### Question
I have two classes declared as below:  

```sh
class User
{
public:
  MyMessageBox dataMsgBox;
};

class MyMessageBox
{
public:
  void sendMessage(Message *msg, User *recvr);
  Message receiveMessage();
  vector<Message> *dataMessageList;
};
```

When I try to compile it using gcc, it gives the following error:  

<blockquote>
  MyMessageBox does not name a type  
</blockquote>

#### Answer accepted (score 190)
When the compiler compiles the class `User` and gets to the `MyMessageBox` line, `MyMessageBox` has not yet been defined. The compiler has no idea `MyMessageBox` exists, so cannot understand the meaning of your class member.  

You need to make sure `MyMessageBox` is defined <em>before</em> you use it as a member. This is solved by reversing the definition order. However, you have a cyclic dependency: if you move `MyMessageBox` above `User`, then in the definition of `MyMessageBox` the name `User` won't be defined!  

<p>What you can do is <em>forward declare</em> `User`; that is, declare it but don't define it. During compilation, a type that is declared but not defined is called an <em>incomplete type</em>.
Consider the simpler example:</p>

```sh
struct foo; // foo is *declared* to be a struct, but that struct is not yet defined

struct bar
{
    // this is okay, it's just a pointer;
    // we can point to something without knowing how that something is defined
    foo* fp; 

    // likewise, we can form a reference to it
    void some_func(foo& fr);

    // but this would be an error, as before, because it requires a definition
    /* foo fooMember; */
};

struct foo // okay, now define foo!
{
    int fooInt;
    double fooDouble;
};

void bar::some_func(foo& fr)
{
    // now that foo is defined, we can read that reference:
    fr.fooInt = 111605;
    fr.foDouble = 123.456;
}
```

By forward declaring `User`, `MyMessageBox` can still form a pointer or reference to it:  

```sh
class User; // let the compiler know such a class will be defined

class MyMessageBox
{
public:
    // this is ok, no definitions needed yet for User (or Message)
    void sendMessage(Message *msg, User *recvr); 

    Message receiveMessage();
    vector<Message>* dataMessageList;
};

class User
{
public:
    // also ok, since it's now defined
    MyMessageBox dataMsgBox;
};
```

You <em>cannot</em> do this the other way around: as mentioned, a class member needs to have a definition. (The reason is that the compiler needs to know how much memory `User` takes up, and to know that it needs to know the size of its members.) If you were to say:  

```sh
class MyMessageBox;

class User
{
public:
    // size not available! it's an incomplete type
    MyMessageBox dataMsgBox;
};
```

It wouldn't work, since it doesn't know the size yet.  

<hr>

On a side note, this function:  

```sh
 void sendMessage(Message *msg, User *recvr);
```

Probably shouldn't take either of those by pointer. You can't send a message without a message, nor can you send a message without a user to send it to. And both of those situations are expressible by passing null as an argument to either parameter (null is a perfectly valid pointer value!)  

Rather, use a reference (possibly const):  

```sh
 void sendMessage(const Message& msg, User& recvr);
```

#### Answer 2 (score 8)
<ol>
<li>Forward declare User</li>
<li>Put the declaration of MyMessageBox before User</li>
</ol>

#### Answer 3 (score 2)
C++ compilers process their input once. Each class you use must have been defined first. You use `MyMessageBox` before you define it. In this case, you can simply swap the two class definitions.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: C compiler for Windows? (score [405559](https://stackoverflow.com/q/116368) in 2013)

#### Question
I'm fine working on Linux using gcc as my C compiler but would like a Windows solution. Any ideas? I've looked at <a href="http://en.wikipedia.org/wiki/Dev-C%2B%2B" rel="noreferrer">Dev-C++ from Bloodshed</a> but looking for more options.  

#### Answer accepted (score 78)
You can use GCC on Windows by downloading <a href="http://www.mingw.org/" rel="nofollow noreferrer">MingW</a> (<em>discontinued</em>) or its successor <a href="https://mingw-w64.org/" rel="nofollow noreferrer">Mingw-w64</a>.  

#### Answer 2 (score 36)
You can get <a href="http://www.microsoft.com/express/vc/" rel="noreferrer">Visual C++ Express Edition</a> straight from Microsoft, if you want something targeting Win32. Otherwise MinGW or lcc, as suggested elsewhere.  

#### Answer 3 (score 24)
GCC is ubiquitous. It is trusted and well understood by thousands of folks across dozens of communities.  

Visual Studio is perhaps the best IDE ever developed. It has a great compiler underneath it. But it is strictly Windows-only.  

If you're just playing, get GCC --it's free. If you're concerned about multiple platfroms, it's GCC. If you're talking serious Windows development, get Visual Studio.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Windows batch file file download from a URL (score [403449](https://stackoverflow.com/q/4619088) in 2017)

#### Question
I am trying to download a file from a website (ex. <a href="http://www.example.com/package.zip" rel="noreferrer">http://www.example.com/package.zip</a>) using a Windows batch file.  I am getting an error code when I write the function below:  

```sh
xcopy /E /Y "http://www.example.com/package.zip"
```

The batch file doesn't seem to like the "/" after the http.  Are there any ways to escape those characters so it doesn't assume they are function parameters?  

#### Answer 2 (score 115)
With PowerShell 2.0 (Windows 7 preinstalled) you can use:  

```sh
(New-Object Net.WebClient).DownloadFile('http://www.example.com/package.zip', 'package.zip')
```

Starting with PowerShell 3.0 (Windows 8 preinstalled) you can use <a href="https://technet.microsoft.com/en-us/library/hh849901(v=wps.620).aspx" rel="noreferrer">`Invoke-WebRequest`</a>:  

```sh
Invoke-WebRequest http://www.example.com/package.zip -OutFile package.zip
```

From a batch file they are called:  

```sh
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://www.example.com/package.zip', 'package.zip')"
powershell -Command "Invoke-WebRequest http://www.example.com/package.zip -OutFile package.zip"
```

(PowerShell 2.0 is available for installation on XP, 3.0 for Windows 7)  

#### Answer 3 (score 91)
There's a standard Windows component which can achieve what you're trying to do: <a href="http://en.wikipedia.org/wiki/Background_Intelligent_Transfer_Service" rel="noreferrer">BITS</a>. It has been included in Windows since XP and 2000 SP3.  

Run:  

```sh
bitsadmin.exe /transfer "JobName" http://download.url/here.exe C:\destination\here.exe
```

The job name is simply the display name for the download job - set it to something that describes what you're doing.  
</section>

