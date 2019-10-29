---
title: Linux <- StackOverflow top 100
category: linux
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How do I find all files containing specific text on Linux? (score [6026154](https://stackoverflow.com/q/16956810) in 2017)

#### Question
I'm trying to find a way to scan my entire Linux system for all files containing a specific string of text. Just to clarify, I'm looking for text within the file, not in the file name.  

When I was looking up how to do this, I came across this solution twice:  

```sh
find / -type f -exec grep -H 'text-to-find-here' {} \;
```

However, it doesn't work. It seems to display every single file in the system.  

Is this close to the proper way to do it? If not, how should I? This ability to find text strings in files would be extraordinarily useful for some programming projects I'm doing.  

#### Answer accepted (score 8685)
Do the following:  

```sh
grep -rnw '/path/to/somewhere/' -e 'pattern'
```

<ul>
<li>`-r` or `-R` is recursive, </li>
<li>`-n` is line number, and </li>
<li>`-w` stands for match the whole word. </li>
<li>`-l` (lower-case L) can be added to just give the file name of matching files.</li>
</ul>

Along with these, `--exclude`, `--include`, `--exclude-dir` flags could be used for efficient searching:  

<ul>
<li><p>This will only search through those files which have .c or .h extensions:</p>

```sh
grep --include=\*.{c,h} -rnw '/path/to/somewhere/' -e "pattern"
```</li>
<li><p>This will exclude searching all the files ending with .o extension:</p>

```sh
grep --exclude=*.o -rnw '/path/to/somewhere/' -e "pattern"
```</li>
<li><p>For directories it's possible to exclude a particular directory(ies) through `--exclude-dir` parameter. For example, this will exclude the dirs dir1/, dir2/ and all of them matching *.dst/:</p>

```sh
grep --exclude-dir={dir1,dir2,*.dst} -rnw '/path/to/somewhere/' -e "pattern"
```</li>
</ul>

This works very well for me, to achieve almost the same purpose like yours.  

For more options check `man grep`.  

#### Answer 2 (score 1380)
You can use `grep -ilR`:  

```sh
grep -Ril "text-to-find-here" /
```

<ul>
<li>`i` stands for ignore case (optional in your case).  </li>
<li>`R` stands for recursive.  </li>
<li>`l` stands for "show the file name, not the result itself".</li>
<li>`/` stands for starting at the root of your machine.</li>
</ul>

#### Answer 3 (score 303)
You can use <a href="http://beyondgrep.com/">ack</a>. It is like <a href="http://en.wikipedia.org/wiki/Grep">grep</a> for source code. You can scan your entire file system with it.  

Just do:  

```sh
ack 'text-to-find-here'
```

In your root directory.  

You can also use <a href="http://en.wikipedia.org/wiki/Regular_expression">regular expressions</a>, specify the filetype, etc.  

<hr>

<strong>UPDATE</strong>  

I just discovered <a href="https://github.com/ggreer/the_silver_searcher">The Silver Searcher</a>, which is like ack but 3-5x faster than it and even ignores patterns from a `.gitignore` file.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How do I change permissions for a folder and all of its subfolders and files in one step in Linux? (score [3802221](https://stackoverflow.com/q/3740152) in 2019)

#### Question
I would like to change permissions of a folder and all its sub folders and files in one step (command) in Linux.  

I have already tried the below command but it works only for the mentioned folder:  

```sh
chmod 775 /opt/lampp/htdocs
```

Is there a way to set `chmod 755` for `/opt/lampp/htdocs` and all of its content including subfolders and files?  

Also, in the future, if I create a new folder or file inside `htdocs`, how can the permissions of that automatically be set to `755`?   

I had a look at this link too:  

<a href="http://stackoverflow.com/questions/3740187/how-to-set-default-chmod-in-linux-terminal">http://stackoverflow.com/questions/3740187/how-to-set-default-chmod-in-linux-terminal</a>  

#### Answer accepted (score 2775)
The other answers are correct, in that `chmod -R 755` will set these permissions to all files and subfolders in the tree. <strong>But why on earth would you want to</strong>? It might make sense for the directories, but why set the execute bit on all the files?   

I suspect what you really want to do is set the directories to 755 and either leave the files alone or set them to 644. For this, you can use the `find` command. For example:  

To change all the directories to 755 (`drwxr-xr-x`):  

```sh
find /opt/lampp/htdocs -type d -exec chmod 755 {} \;
```

To change all the files to 644 (`-rw-r--r--`):  

```sh
find /opt/lampp/htdocs -type f -exec chmod 644 {} \;
```

#### Answer 2 (score 750)
Check the -R option   

`chmod -R &lt;permissionsettings&gt; &lt;dirname&gt;`  

In the future, you can save a lot of time by checking the man page first:  

```sh
man <command name>
```

So in this case:  

```sh
man chmod
```

#### Answer 3 (score 365)
If you want to set permissions on all files to `a+r`, and all directories to `a+x`, and do that recursively through the complete subdirectory tree, use:  

```sh
chmod -R a+rX *
```

The `X` (that is capital `X`, not small `x`!) is ignored for files (unless they are executable for someone already) but is used for directories.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How do I copy folder with files to another folder in Unix/Linux? (score [2371756](https://stackoverflow.com/q/14922562) in 2017)

#### Question
I am having some issues to copy a folder with files in that folder into another folder. Command `cp -r` doesn't copy files in the folder.  

#### Answer accepted (score 1861)
The option you're looking for is `-R`.  

```sh
cp -R path_to_source path_to_destination/
```

<ul>
<li>If `destination` doesn't exist, it will be created.</li>
<li>`-R` means `copy directories recursively`. You can also use `-r` since it's case-insensitive.</li>
<li>Note the nuances with adding the trailing `/` as per @muni764's <a href="https://stackoverflow.com/questions/14922562/how-do-i-copy-folder-with-files-to-another-folder-in-unix-linux#comment90054461_14922600">comment</a>.</li>
</ul>

#### Answer 2 (score 364)
You are looking for the `cp` command.  You need to change directories so that you are outside of the directory you are trying to copy.  If the directory you're copying is called `dir1` and you want to copy it to your `/home/Pictures` folder:  

```sh
cp -r dir1/ ~/Pictures/
```

Linux is case-sensitive and also needs the `/` after each directory to know that it isn't a file.  `~` is a special character in the terminal that automatically evaluates to the current user's home directory.   If you need to know what directory you are in, use the command `pwd`.  

When you don't know how to use a Linux command, there is a manual page that you can refer to by typing  

```sh
man [insert command here]
```

at a terminal prompt.  

Also, to auto complete long file paths when typing in the terminal, you can hit <kbd>Tab</kbd> after you've started typing the path and you will either be presented with choices, or it will insert the remaining part of the path.  

#### Answer 3 (score 101)
Use:  

```sh
$ cp -R SRCFOLDER DESTFOLDER/
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How can I recursively find all files in current and subfolders based on wildcard matching? (score [2158446](https://stackoverflow.com/q/5905054) in 2016)

#### Question
How can I recursively find all files in current and subfolders based on wildcard matching?  

#### Answer accepted (score 2420)
Use <a href="http://linux.die.net/man/1/find" rel="noreferrer">find</a> for that:  

```sh
find . -name "foo*"
```

`find` needs a starting point, and the `.` (dot) points to the current directory.  

#### Answer 2 (score 202)
Piping find into grep is often more convenient; it gives you the full power of regular expressions for arbitrary wildcard matching.  

For example, to find all files with case insensitive string "foo" in the filename:  

```sh
~$ find . -print | grep -i foo
```

#### Answer 3 (score 134)
`find` will find all files that match a pattern:  

```sh
find . -name "*foo"
```

However, if you want a picture:  

```sh
tree -P "*foo"
```

Hope this helps!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: How to symlink a file in Linux? (score [1958525](https://stackoverflow.com/q/1951742) in 2016)

#### Question
I want to make a symbolic link in Linux.  I have written this bash command where the first path is the folder I want link into and the second path is the compiled source.   

```sh
ln -s '+basebuild+'/IpDome-kernel/kernel /home/build/sandbox/gen2/basebuild/IpDome-kernel/kernal 
```

Is this correct?  

#### Answer accepted (score 3555)
To create a new symlink (will fail if symlink exists already):  

```sh
ln -s /path/to/file /path/to/symlink
```

To create or update a symlink:  

```sh
ln -sf /path/to/file /path/to/symlink
```

#### Answer 2 (score 285)
```sh
ln -s TARGET LINK_NAME
```

Where the `-s` makes it symbolic.  

#### Answer 3 (score 275)
```sh
ln -s EXISTING_FILE_OR_DIRECTORY SYMLINK_NAME
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: Chmod 777 to a folder and all contents (score [1793940](https://stackoverflow.com/q/8328481) in 2018)

#### Question
I have a web directory `/www` and a folder in that directory called `store`.  

Within `store` are several files and folders. I want to give the folder `store` and all files and folders within the `store` folder all permissions.   

How do I do this? I am guessing via .htaccess.  

#### Answer accepted (score 723)
If you are going for a console command it would be:   

`chmod -R 777 /www/store`. The `-R` (or `--recursive`) options make it recursive.  

Or if you want to make all the files in the current directory have all permissions type:  

`chmod -R 777 ./`  

If you need more info about `chmod` command see: <a href="https://www.linux.org/threads/file-permissions-chmod.4124/" rel="noreferrer">File permission</a>  

#### Answer 2 (score 162)
If by all permissions you mean 777  

Navigate to folder and  

```sh
chmod -R 777 .
```

#### Answer 3 (score 100)
<h5>You can give permission to folder and all its contents using option `-R` i.e Recursive permissions.</h2>

But I would suggest not to give 777 permission to all folder and it's all contents. You should give specific permission to each sub-folder in www directory folders.  

<h5>Ideally, give `755` permission for security reasons to the web folder.</h2>

```sh
sudo chmod -R 755 /www/store
```

Each number has meaning in permission. Do not give full permission.  

```sh
N   Description                      ls   binary    
0   No permissions at all            ---  000
1   Only execute                     --x  001
2   Only write                       -w-  010
3   Write and execute                -wx  011
4   Only read                        r--  100
5   Read and execute                 r-x  101
6   Read and write                   rw-  110
7   Read, write, and execute         rwx  111
```

<ul>
<li>First Number 7 - Read, write, and execute for the user.</li>
<li>Second Number 5 - Read and execute for the group.</li>
<li>Third Number 5 - Read and execute for others.</li>
</ul>

If your production web folder has multiple users, then you can set permissions and user groups accordingly.   

More info :  

<ol>
<li><a href="http://www.surfsafely.com/file-permissions-what-does-chmod-777-mean/" rel="noreferrer">Understanding File Permissions: What Does “Chmod 777″ Mean?</a></li>
<li><a href="https://askubuntu.com/questions/9402/what-file-permissions-should-i-set-on-web-root">What file permissions should I set on web root?</a></li>
<li><a href="https://askubuntu.com/questions/20105/why-shouldnt-var-www-have-chmod-777/20110#20110">Why shouldn't /var/www have chmod 777</a></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: How to create a file in Linux from terminal window? (score [1564036](https://stackoverflow.com/q/9381463) in 2018)

#### Question
What's the easiest way to create a file in Linux terminal?  

#### Answer accepted (score 548)
Depending on what you want the file to contain:  

<ul>
<li>`touch /path/to/file` for an empty file</li>
<li><p>`somecommand &gt; /path/to/file` for a file containing the output of some command.</p>

```sh
  eg: grep --help > randomtext.txt
      echo "This is some text" > randomtext.txt
```</li>
<li><p>`nano /path/to/file` or `vi /path/to/file` (or `any other editor emacs,gedit etc`)<br>
It either opens the existing one for editing or creates &amp; opens the empty file to enter, if it doesn't exist</p></li>
</ul>

#### Answer 2 (score 118)
Use <a href="http://en.wikipedia.org/wiki/Touch_(Unix)" rel="noreferrer">touch</a>  

```sh
touch filename
```

#### Answer 3 (score 85)
<strong>Create the file using `cat`</strong>  

`$ cat &gt; myfile.txt`  

Now, just type whatever you want in the file:  

`Hello World!`  

CTRL-D to save and exit  

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: How to permanently set $PATH on Linux/Unix? (score [1467227](https://stackoverflow.com/q/14637979) in 2018)

#### Question
I'm trying to add a directory to my path so it will always be in my Linux path. I've tried:  

```sh
export PATH=$PATH:/path/to/dir
```

This works, however each time I exit the terminal and start a new terminal instance, this path is lost, and I need to run the export command again.  

How can I do it so this will be set permanently?  

#### Answer accepted (score 998)
<strong>You need to add it to your `~/.profile` or `~/.bashrc` file.</strong>&nbsp;  

```sh
export PATH="$PATH:/path/to/dir"
```

Depending on what you're doing, you also may want to symlink to binaries:  

```sh
cd /usr/bin
sudo ln -s /path/to/binary binary-name
```

<strong>Note that this will not automatically update your path for the remainder of the session.</strong> To do this, you should run:  

```sh
source ~/.profile 
or
source ~/.bashrc
```

#### Answer 2 (score 237)
<p>In Ubuntu, edit `/etc/environment`. Its sole purpose is to store Environment Variables. Originally the $PATH variable is defined here.
This is a paste from my `/etc/environment` file:</p>

```sh
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
```

So you can just open up this file as root and add whatever you want.  

<p>For Immediate results,
Run (try as normal user <em>and</em> root):</p>

```sh
source /etc/environment && export PATH
```

<strong>UPDATE:</strong>  

If you use `zsh` (a.k.a Z Shell), add this line right after the comments in `/etc/zsh/zshenv`:  

```sh
source /etc/environment
```

<em>I encountered this little quirk on Ubuntu 15.10, but if your <strong>zsh</strong> is not getting the correct <strong>PATH</strong>, this could be why</em>  

#### Answer 3 (score 152)
There are multiple ways to do it. The actual solution depends on the purpose.  

The variable values are usually stored in either a list of assignments or a shell script that is run at the start of the system or user session. In case of the shell script you must use a specific shell syntax.  

<h5>System wide</h2>

<ol>
<li>`/etc/environment` List of unique assignments. Perfect for adding system-wide directories like `/usr/local/something/bin` to `PATH` variable or defining `JAVA_HOME`.</li>
<li>`/etc/xprofile` Shell script executed while starting X Window System session. This is run for every user that logs into X Window System. It is a good choice for `PATH` entries that are valid for every user like `/usr/local/something/bin`. The file is included by other script so use POSIX shell syntax not the syntax of your user shell.</li>
<li>`/etc/profile` and `/etc/profile.d/*` Shell script. This is a good choice for shell-only systems. Those files are read only by shells.</li>
<li>`/etc/&lt;shell&gt;.&lt;shell&gt;rc`. Shell script. This is a poor choice because it is single shell specific.</li>
</ol>

<h5>User session</h2>

<ol>
<li>`~/.pam_environment`. List of unique assignments. Loaded by <a href="http://www.linux-pam.org/" rel="noreferrer">PAM</a> at the start of every user session irrelevant if it is an X Window System session or shell. You cannot reference other variable including `HOME` or `PATH` so it has limited use.</li>
<li>`~/.xprofile` Shell script. This is executed when the user logs into X Window System system. The variables defined here are visible to every X application. Perfect choice for extending `PATH` with values such as `~/bin` or `~/go/bin` or defining user specific `GOPATH` or `NPM_HOME`. The file is included by other script so use POSIX shell syntax not the syntax of your user shell. Your graphical text editor or IDE started by shortcut will see those values.</li>
<li>`~/.profile` Shell script. It will be visible only for programs started from terminal or terminal emulator. It is a good choice for shell-only systems.</li>
<li>`~/.&lt;shell&gt;rc`. Shell script. This is a poor choice because it is single shell specific.</li>
</ol>

<h5>Distribution specific documentation</h2>

<ul>
<li><a href="https://help.ubuntu.com/community/EnvironmentVariables#Persistent_environment_variables" rel="noreferrer">Ubuntu</a></li>
<li><a href="https://wiki.archlinux.org/index.php/Environment_variables" rel="noreferrer">archlinux</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: How do I grep recursively? (score [1461938](https://stackoverflow.com/q/1987926) in 2018)

#### Question
How do I recursively `grep` all directories and subdirectories?  

```sh
find . | xargs grep "texthere" *
```

#### Answer accepted (score 2401)
```sh
grep -r "texthere" .
```

The first parameter represents the regular expression to search for, while the second one represents the directory that should be searched. In this case, `.` means the current directory.  

Note: This works for GNU grep, and on some platforms like Solaris you must specifically use GNU grep as opposed to legacy implementation.  For Solaris this is the `ggrep` command.     

#### Answer 2 (score 651)
If you know the extension or pattern of the file you would like, another method is to use `--include` option:  

```sh
grep -r --include "*.txt" texthere .
```

You can also mention files to exclude with `--exclude`.  

<h5>Ag</h3>

If you frequently search through code, <a href="https://github.com/ggreer/the_silver_searcher">Ag (The Silver Searcher)</a> is a much faster alternative to grep, that's customized for searching code. For instance, it's recursive by default and automatically ignores files and directories listed in `.gitignore`, so you don't have to keep passing the same cumbersome exclude options to grep or find.  

#### Answer 3 (score 122)
Also:  

```sh
find ./ -type f -print0 | xargs -0 grep "foo"
```

but `grep -r` is a better answer.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: Looping through the content of a file in Bash (score [1415142](https://stackoverflow.com/q/1521462) in 2018)

#### Question
How do I iterate through each line of a text file with <a href="http://en.wikipedia.org/wiki/Bash" rel="noreferrer">Bash</a>?  

With this script:  

```sh
echo "Start!"
for p in (peptides.txt)
do
    echo "${p}"
done
```

I get this output on the screen:  

```sh
Start!
./runPep.sh: line 3: syntax error near unexpected token `('
./runPep.sh: line 3: `for p in (peptides.txt)'
```

(Later I want to do something more complicated with `$p` than just output to the screen.)  

<hr>

The environment variable <strong>SHELL</strong> is (from env):  

```sh
SHELL=/bin/bash
```

`/bin/bash --version` output:  

```sh
GNU bash, version 3.1.17(1)-release (x86_64-suse-linux-gnu)
Copyright (C) 2005 Free Software Foundation, Inc.
```

`cat /proc/version` output:  

```sh
Linux version 2.6.18.2-34-default (geeko@buildhost) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #1 SMP Mon Nov 27 11:46:27 UTC 2006
```

The file peptides.txt contains:  

```sh
RKEKNVQ
IPKKLLQK
QYFHQLEKMNVK
IPKKLLQK
GDLSTALEVAIDCYEK
QYFHQLEKMNVKIPENIYR
RKEKNVQ
VLAKHGKLQDAIN
ILGFMK
LEDVALQILL
```

#### Answer accepted (score 1891)
One way to do it is:  

```sh
while read p; do
  echo "$p"
done <peptides.txt
```

As pointed out in the comments, this has the side effects of trimming leading whitespace, interpretting backslash sequences, and skipping the trailing line if it's missing a terminating linefeed. If these are concerns, you can do:  

```sh
while IFS="" read -r p || [ -n "$p" ]
do
  printf '%s\n' "$p"
done < peptides.txt
```

<hr>

Exceptionally, if the <a href="https://unix.stackexchange.com/questions/107800/using-while-loop-to-ssh-to-multiple-servers">loop body may read from standard input</a>, you can open the file using a different file descriptor:  

```sh
while read -u 10 p; do
  ...
done 10<peptides.txt
```

Here, 10 is just an arbitrary number (different from 0, 1, 2).  

#### Answer 2 (score 374)
```sh
cat peptides.txt | while read line
do
   # do something with $line here
done
```

and the one-liner variant:  

```sh
cat peptides.txt | while read line; do something_with_$line_here; done
```

#### Answer 3 (score 137)
<strong>Option 1a:</strong> While loop:  Single line at a time:  Input redirection  

```sh
#!/bin/bash
filename='peptides.txt'
echo Start
while read p; do 
    echo $p
done < $filename
```

<p><strong>Option 1b:</strong> While loop:  Single line at a time:<br>
Open the file, read from a file descriptor (in this case file descriptor #4).  </p>

```sh
#!/bin/bash
filename='peptides.txt'
exec 4<$filename
echo Start
while read -u4 p ; do
    echo $p
done
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: Error: Could not find or load main class (score [1353834](https://stackoverflow.com/q/7485670) in 2012)

#### Question
I am having trouble compiling and running my Java code, intended to allow me to interface Java with a shared object for Vensim, a simulation modeling package.  

The following code compiles without error:  

```sh
javac -d . -cp ./apache-log4j-1.2.16/log4j-1.2.16.jar:./vensim.jar SpatialModel.java     VensimHelper.java VensimException.java VensimContextRepository.java
```

However, when I try to run the following:  

```sh
java -cp ./apache-log4j-1.2.16/log4j-1.2.16.jar:./vensim.jar SpatialModel vars
```

<p>I get the following error: "Error: Could not find or load main class SpatialModel
".  My SpatialModel.java code does contain a 'main' method (below), so I'm not sure what the problem is - can anyone please help me out?  Thanks.</p>

```sh
import java.io.File;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.log4j.Logger;

public class SpatialModel {

    private VensimHelper vh;

    public static final String DLL_LIBNAME_PARAM = "vensim_lib_nam";

    public static final String MODEL_PATH_PARAM = "vensim_model_path";

    private final static int VENSIM_CONTEXT_CREATION_MAX_FAILURE_COUNT = 10;

    public SpatialModel() throws SpatialException {

        String libName = System.getProperty(DLL_LIBNAME_PARAM);
        String modelPath = System.getProperty(MODEL_PATH_PARAM);        

        if(libName == null || libName.trim().equals("")) {
            log.error("Vensim library name has to be set with -D" + DLL_LIBNAME_PARAM);
            throw new SpatialException("Vensim library name has to be set with -D" + DLL_LIBNAME_PARAM);
        }

        if(modelPath == null || modelPath.trim().equals("")) {
            log.error("Model path has to set with -D" + MODEL_PATH_PARAM);
            throw new SpatialException("Model path ahs to be set with -D" + MODEL_PATH_PARAM);
        }

        for (int i = 0; i < VENSIM_CONTEXT_CREATION_MAX_FAILURE_COUNT && vh == null; i++) {
            try {
                log.info("creating new vensim helper\n\tdll lib: " + libName + "\n\tmodel path: " + modelPath);
                vh = new VensimHelper(libName, modelPath);
            } catch (Throwable e) {
                log.error("An exception was thrown when initializing Vensim, try: " + i, e);
            }
        }
        if (vh == null) {
            throw new SpatialException("Can't initialize Vensim");
        }

    }

    public static void main(String[] args) throws VensimException {

        long before = System.currentTimeMillis();   
        String libName = System.getProperty(DLL_LIBNAME_PARAM);
        String modelPath = System.getProperty(MODEL_PATH_PARAM);

        if (libName == null) {
            libName = "libvensim";
        }
        if(modelPath == null) {
            modelPath = "~/BassModel.vmf";
        }

        System.setProperty(DLL_LIBNAME_PARAM, libName);
        System.setProperty(MODEL_PATH_PARAM, modelPath);

        if (args.length > 0 && args[0].equals("info")) {
            System.out.println(new VensimHelper(libName, modelPath).getVensimInfo());
        } else if (args.length > 0 && args[0].equals("vars")) {
            VensimHelper helper = new VensimHelper(libName, modelPath);
            String[] vars = helper.getVariables();
            for (String var : vars) {
                System.out.println(helper.getVariableInfo(var));
            }
        } else {

            File f = new File(".");
            System.out.println(f.getAbsolutePath());

            SpatialModel sm = new SpatialModel();
        }

        System.out.println("Execution time: " + (System.currentTimeMillis() - before));
    }

}
```

#### Answer accepted (score 263)
<p>You must ensure that you add the location of your `.class` file to your classpath. So, if its in the current folder, add `.` to your classpath.
Note that the Windows classpath separator is a semi-colon, i.e. a `;`.</p>

#### Answer 2 (score 133)
If the class is in a package  

```sh
package thepackagename;

public class TheClassName {
  public static final void main(String[] cmd_lineParams)  {
     System.out.println("Hello World!");
  } 
}
```

Then calling:   

```sh
java -classpath . TheClassName
```

results in `Error: Could not find or load main class TheClassName`. This is because it must be called with its fully-qualified name:  

```sh
java -classpath . thepackagename.TheClassName
```

And this `thepackagename` directory must exist in the classpath. In this example, `.`, meaning the current directory, is the entirety of classpath. Therefore this particular example must be called from the directory in which `thepackagename` exists.   

To be clear, the name of this class is not `TheClassName`, It's `thepackagename.TheClassName`. Attempting to execute `TheClassName` does not work, because <em>no class having that name exists</em>. Not on the current classpath anyway.  

Finally, note that the compiled (<em>.class) version is executed, not the source code (</em>.java) version. Hence “CLASSPATH.”  

#### Answer 3 (score 59)
You can try these two when you are getting the error: 'could not find or load main class'  

<p>If your class file is saved in following directory with `HelloWorld` program name
`d:\sample`</p>

<ol>
<li>`java -cp d:\sample HelloWorld`</li>
<li>`java -cp . HelloWorld`</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: Kill detached screen session (score [1279942](https://stackoverflow.com/q/1509677) in 2019)

#### Question
I learned from somewhere a detached screen can be killed by  

```sh
screen -X -S [session # you want to kill] kill
```

where [session # you want to kill] can be gotten from  

```sh
screen -ls
```

But this doesn't work. Anything wrong? What's the correct way?  

#### Answer accepted (score 1247)
"kill" will only kill one screen window. To "kill" the complete session, use `quit`.  

<h5>Example</h3>

```sh
$ screen -X -S [session # you want to kill] quit
```

<p>For dead sessions use:
    $ screen -wipe</p>

#### Answer 2 (score 496)
You can kill a detached session which is not responding within the screen session by doing the following.  

<ol>
<li><p>Type `screen -list` to identify the detached screen session.</p>

<pre>
~$ screen -list  
    There are screens on:  
         20751.Melvin_Peter_V42  (Detached)  
</pre>

Note: `20751.Melvin_Peter_V42` is your session id.  </li>
<li><p>Get attached to the detached screen session</p>

<pre>screen -r 20751.Melvin_Peter_V42</pre></li>
<li><p>Once connected to the session press <kbd>Ctrl</kbd> + <kbd>A</kbd> then type `:quit`</p></li>
</ol>

#### Answer 3 (score 141)
<strong>List screens:</strong>  

```sh
screen -list
```

<strong>Output:</strong>  

```sh
There is a screen on:
23536.pts-0.wdzee       (10/04/2012 08:40:45 AM)        (Detached)
1 Socket in /var/run/screen/S-root.
```

<strong>Kill screen session:</strong>  

```sh
screen -S 23536 -X quit
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How to get the current date and time in the terminal and set a custom command in terminal for it? (score [1254767](https://stackoverflow.com/q/18458839) in 2016)

#### Question
<p>I have to check the time in linux terminal.<br/>
What is the command for getting date and time in  Linux terminal ?<br/>
Is there any way in which we can set custom function ?</p>

#### Answer accepted (score 1058)
The command is `date`  

To customise the output there are a myriad of options available, see `date --help` for a list.  

For example, `date '+%A %W %Y %X'` gives `Tuesday 34 2013 08:04:22` which is the name of the day of the week, the week number, the year and the time.  

#### Answer 2 (score 72)
You can use `date` to get time and date of a day:   

```sh
[pengyu@GLaDOS ~]$date
Tue Aug 27 15:01:27 CST 2013
```

Also `hwclock` would do:  

```sh
[pengyu@GLaDOS ~]$hwclock
Tue 27 Aug 2013 03:01:29 PM CST  -0.516080 seconds
```

For customized output, you can either redirect the output of `date` to something like `awk`, or write your own program to do that.   

Remember to put your own executable scripts/binary into your `PATH` (e.g. /usr/bin) to make it invokable anywhere.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: How to count lines in a document? (score [1222035](https://stackoverflow.com/q/3137094) in 2015)

#### Question
I have lines like these, and I want to know how many lines I actually have...  

```sh
09:16:39 AM  all    2.00    0.00    4.00    0.00    0.00    0.00    0.00    0.00   94.00
09:16:40 AM  all    5.00    0.00    0.00    4.00    0.00    0.00    0.00    0.00   91.00
09:16:41 AM  all    0.00    0.00    4.00    0.00    0.00    0.00    0.00    0.00   96.00
09:16:42 AM  all    3.00    0.00    1.00    0.00    0.00    0.00    0.00    0.00   96.00
09:16:43 AM  all    0.00    0.00    1.00    0.00    1.00    0.00    0.00    0.00   98.00
09:16:44 AM  all    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
09:16:45 AM  all    2.00    0.00    6.00    0.00    0.00    0.00    0.00    0.00   92.00
```

Is there a way to count them all using linux commands?  

#### Answer accepted (score 1840)
Use `wc`:  

```sh
wc -l <filename>
```

This will output the number of lines in `&lt;filename&gt;`:  

```sh
$ wc -l /dir/file.txt
3272485 /dir/file.txt
```

Or, to omit the `&lt;filename&gt;` from the result use `wc -l &lt; &lt;filename&gt;`:  

```sh
$ wc -l < /dir/file.txt
3272485
```

You can also pipe data to `wc` as well:  

```sh
$ cat /dir/file.txt | wc -l
3272485
$ curl yahoo.com --silent | wc -l
63
```

#### Answer 2 (score 133)
To count all lines use:  

```sh
$ wc -l file
```

To filter and count only lines with pattern use:  

```sh
$ grep -w "pattern" -c file  
```

Or use -v to invert match:  

```sh
$ grep -w "pattern" -c -v file 
```

See the grep man page to take a look at the -e,-i and -x args...  

#### Answer 3 (score 70)
```sh
wc -l <file.txt>
```

Or  

```sh
command | wc -l
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: How to download a file from server using SSH? (score [1214123](https://stackoverflow.com/q/9427553) in 2016)

#### Question
I need to download a file from server to my desktop. (UBUNTU 10.04) I don't have a web access to the server, just ssh.  

If it helps, my OS is Mac OS X and iTerm 2 as a terminal.  

#### Answer accepted (score 1166)
In your terminal, type:  

```sh
scp your_username@remotehost.edu:foobar.txt /local/dir
```

replacing the username, host, remote filename, and local directory as appropriate.  

If you want to access EC2 (or other service that requires authenticating with a private key), use the `-i` option:  

```sh
scp -i key_file.pem your_username@remotehost.edu:/remote/dir/foobar.txt /local/dir
```

From: <a href="http://www.hypexr.org/linux_scp_help.php">http://www.hypexr.org/linux_scp_help.php</a>  

#### Answer 2 (score 322)
You can do this with the `scp` command. `scp` uses the SSH protocol to copy files across system by extending the syntax of `cp`.    

Copy something from another system to this system:    

```sh
scp username@hostname:/path/to/remote/file /path/to/local/file
```

Copy something from this system to some other system:    

```sh
scp /path/to/local/file username@hostname:/path/to/remote/file          
```

Copy something from some system to some other system:    

```sh
scp username1@hostname1:/path/to/file username2@hostname2:/path/to/other/file   
```

#### Answer 3 (score 96)
scp is certainly the way to go, but for completeness you can also do:  

```sh
$ ssh host 'cat /path/on/remote' > /path/on/local
```

or  

```sh
$ cat /path/on/local | ssh host 'cat > /path/on/remote'
```

Note, this is UUOC, but `&lt; /path/on/local ssh host 'cat &gt; /path'` could cause unnecessary confusion.  

And to proxy between two hosts:  

```sh
$ ssh host1 'cat /path/on/host1' | ssh host2 'cat > /path/on/host2'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: Sleep for milliseconds (score [1182180](https://stackoverflow.com/q/4184468) in 2015)

#### Question
I know the POSIX `sleep(x)` function makes the program sleep for x seconds. Is there a function to make the program sleep for x <em>milliseconds</em> in C++?  

#### Answer accepted (score 433)
Note that there is no standard C API for milliseconds, so (on Unix) you will have to settle for `usleep`, which accepts microseconds:  

```sh
#include <unistd.h>

unsigned int microseconds;
...
usleep(microseconds);
```

#### Answer 2 (score 1138)
In C++11, you can do this with standard library facilities:  

```sh
#include <chrono>
#include <thread>
```



```sh
std::this_thread::sleep_for(std::chrono::milliseconds(x));
```

Clear and readable, no more need to guess at what units the `sleep()` function takes.  

#### Answer 3 (score 80)
To stay portable you could use <a href="http://www.boost.org/doc/libs/1_44_0/doc/html/thread.html" rel="noreferrer">Boost::Thread</a> for sleeping:  

```sh
#include <boost/thread/thread.hpp>

int main()
{
    //waits 2 seconds
    boost::this_thread::sleep( boost::posix_time::seconds(1) );
    boost::this_thread::sleep( boost::posix_time::milliseconds(1000) );

    return 0;
}
```

<em>This answer is a duplicate and has been posted in <a href="https://stackoverflow.com/questions/4103707/need-a-better-wait-solution/4103842#4103842">this question</a> before. Perhaps you could find some usable answers there too.</em>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: How to measure actual memory usage of an application or process? (score [1147677](https://stackoverflow.com/q/131303) in 2017)

#### Question
<strong>This question is covered <a href="https://stackoverflow.com/q/63166/15161">here</a> in great detail.</strong>  

How do you measure the memory usage of an application or process in Linux?  

From the blog article of <a href="http://virtualthreads.blogspot.com/2006/02/understanding-memory-usage-on-linux.html" rel="noreferrer">Understanding memory usage on Linux</a>, `ps` is not an accurate tool to use for this intent.  

<blockquote>
  <strong>Why `ps` is "wrong"</strong>  
  
  Depending on how you look at it, `ps` is not reporting the real memory usage of processes. What it is really doing is showing how much real memory each process would take up <strong>if it were the only process running</strong>. Of course, a typical Linux machine has several dozen processes running at any given time, which means that the VSZ and RSS numbers reported by `ps` are almost definitely <em>wrong</em>.  
</blockquote>

#### Answer accepted (score 343)
With `ps` or similar tools you will only get the amount of memory pages allocated by that process. This number is correct, but:  

<ul>
<li><p>does not reflect the actual amount of memory used by the application, only the amount of memory reserved for it</p></li>
<li><p>can be misleading if pages are shared, for example by several threads or by using dynamically linked libraries</p></li>
</ul>

If you really want to know what amount of memory your application actually uses, you need to run it within a profiler. For example, `valgrind` can give you insights about the amount of memory used, and, more importantly, about possible memory leaks in your program. The heap profiler tool of valgrind is called 'massif':  

<blockquote>
  Massif is a heap profiler. It performs detailed heap profiling by taking regular snapshots of a program's heap. It produces a graph showing heap usage over time, including information about which parts of the program are responsible for the most memory allocations. The graph is supplemented by a text or HTML file that includes more information for determining where the most memory is being allocated. Massif runs programs about 20x slower than normal.  
</blockquote>

As explained in the <a href="http://valgrind.org/docs/manual/ms-manual.html" rel="noreferrer">valgrind documentation</a>, you need to run the program through valgrind:  

```sh
valgrind --tool=massif <executable> <arguments>
```

<p>Massif writes a dump of memory usage snapshots (e.g. `massif.out.12345`). These provide, (1) a timeline of memory usage, (2) for each snapshot, a record of where in your program memory was allocated.
A great graphical tool for analyzing these files is <a href="https://github.com/KDE/massif-visualizer" rel="noreferrer">massif-visualizer</a>. But I found `ms_print`, a simple text-based tool shipped with valgrind, to be of great help already.</p>

To find memory leaks, use the (default) `memcheck` tool of valgrind.  

#### Answer 2 (score 269)
Try the <a href="http://linux.die.net/man/1/pmap" rel="noreferrer">pmap</a> command:  

```sh
sudo pmap -x <process pid>
```

#### Answer 3 (score 188)
Hard to tell for sure, but here are two "close" things that can help.  

```sh
$ ps aux 
```

will give you Virtual Size (VSZ)  

You can also get detailed stats from /proc file-system by going to `/proc/$pid/status`  

The most important is the VmSize, which should be close to what `ps aux` gives.  

<pre>
/proc/19420$ cat status
Name:   firefox
State:  S (sleeping)
Tgid:   19420
Pid:    19420
PPid:   1
TracerPid:  0
Uid:    1000    1000    1000    1000
Gid:    1000    1000    1000    1000
FDSize: 256
Groups: 4 6 20 24 25 29 30 44 46 107 109 115 124 1000 
VmPeak:   222956 kB
VmSize:   212520 kB
VmLck:         0 kB
VmHWM:    127912 kB
VmRSS:    118768 kB
VmData:   170180 kB
VmStk:       228 kB
VmExe:        28 kB
VmLib:     35424 kB
VmPTE:       184 kB
Threads:    8
SigQ:   0/16382
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: 0000000020001000
SigCgt: 000000018000442f
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000
Cpus_allowed:   03
Mems_allowed:   1
voluntary_ctxt_switches:    63422
nonvoluntary_ctxt_switches: 7171

</pre>

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: error: 'Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)' -- Missing /var/run/mysqld/mysqld.sock (score [1145574](https://stackoverflow.com/q/11990708) in 2018)

#### Question


My problem started off with me not being able to log in as root any more on my mysql install.  I was attempting to run mysql without passwords turned on... but whenever I ran the command   

```sh
# mysqld_safe --skip-grant-tables &
```

I would never get the prompt back. I was trying to follow <a href="http://www.cyberciti.biz/tips/recover-mysql-root-password.html" rel="noreferrer">these instructions to recover the password</a>.  

The screen just looks like this:   

```sh
root@jj-SFF-PC:/usr/bin# mysqld_safe --skip-grant-tables
120816 11:40:53 mysqld_safe Logging to syslog.
120816 11:40:53 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
```

and I don't get a prompt to start typing the SQL commands to reset the password.   

When I kill it by pressing <kbd>CTRL</kbd> + <kbd>C</kbd>, I get the following message:   

```sh
error: 'Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)'

Check that mysqld is running and that the socket: '/var/run/mysqld/mysqld.sock' exists!
```

If I retry the command and leave it long enough, I do get the following series of messages:  

```sh
root@jj-SFF-PC:/run/mysqld# 120816 13:15:02 mysqld_safe Logging to syslog.
120816 13:15:02 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
120816 13:16:42 mysqld_safe mysqld from pid file /var/run/mysqld/mysqld.pid ended

[1]+  Done                    mysqld_safe --skip-grant-tables
root@jj-SFF-PC:/run/mysqld#
```

But then if I try to log in as root by doing:   

```sh
# mysql -u root
```

I get the following error message:   

```sh
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)
```

I checked and `/var/run/mysqld/mysqld.sock` file doesn't not exist. The folder does, but not the file.    

Also, I dunno if this helps or not, but I ran `find / -name mysqld` and it came up with:  

```sh
/var/run/mysqld - folder
/usr/sbin/mysqld - file
/run/mysqld - folder
```

I'm new to Linux and MySQL, so I don't know if this is normal or not. But I'm including this info just in case it helps.  

<strong>I finally decided to uninstall and reinstall mysql.</strong>  

```sh
apt-get remove mysql-server
apt-get remove mysql-client
apt-get remove mysql-common
apt-get remove phpmyadmin
```

After reinstalling all packages again in the same order as above, during the phpmyadmin install, I got the same error:          

```sh
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)
```

So I tried again to uninstall/reinstall. This time, after I uninstalled the packages, I also manually renamed all mysql files and directories to `mysql.bad` in their respective locations.  

```sh
/var/lib/mysql 
/var/lib/mysql/mysql
/var/log/mysql
/usr/lib/perl5/DBD/mysql
/usr/lib/perl5/auto/DBD/mysql
/usr/lib/mysql
/usr/bin/mysql
/usr/share/mysql
/usr/share/dbconfig-common/internal/mysql
/etc/init.d/mysql
/etc/apparmor.d/abstractions/mysql
/etc/mysql
```

Then I tried to reinstall `mysql-server` and `mysql-client` again.  But I've noticed that it doesn't prompt me for a password.  Isn't it supposed to ask for an admin password?   

#### Answer accepted (score 178)
To find all socket files on your system run:  

```sh
sudo find / -type s
```

My Mysql server system had the socket open at `/var/lib/mysql/mysql.sock`  

Once you find where the socket is being opened, add or edit the line to your /etc/my.cnf file with the path to the socket file:  

```sh
socket=/var/lib/mysql/mysql.sock
```

Sometimes the system startup script that launched the command line executable specifies a flag `--socket=path`. This flag could override the my.cnf location, and that would result in a socket not being found where the my.cnf file indicates it should be.  Then when you try to run the mysql command line client, it will read my.cnf to find the socket, but it will not find it since it deviates from where the server created one.  So, Unless you care where the socket resides, just changing the my.cnf to match should work.    

Then, stop the mysqld process.  How you do this will vary by system.  

If you're super user in the linux system, try one of the following if you don't know the specific method your Mysql setup uses:  

<ul>
<li>`service mysqld stop`</li>
<li>`/etc/init.d/mysqld stop`</li>
<li>`mysqladmin -u root -p shutdown`</li>
<li>Some systems aren't setup to have an elegant way to stop mysql (or for some reason mysql doesn't respond) and you can force terminate mysql with either:

<ul>
<li>One step: `pkill -9 mysqld`</li>
<li>Two step (least preferred):

<ul>
<li>Find the process id of mysql with either `pgrep mysql` or `ps aux | grep mysql | grep -v grep`</li>
<li>Assuming the process id is `4969` terminate with `kill -9 4969`</li>
</ul></li>
</ul></li>
</ul>

After you do this you might want to look for a pid file in `/var/run/mysqld/` and delete it  

Make sure the permissions on your socket is such that whatever user mysqld is running as can read/write to it.  An easy test is to  open it up to full read/write and see if it still works:  

```sh
chmod 777 /var/run/mysqld/mysqld.sock
```

If that fixes the issue, you can tailor the permissions and ownership of the socket as needed based on your security settings.    

Also, the directory the socket resides in has to be reachable by the user running the mysqld process.  

#### Answer 2 (score 220)
Try this command,  

```sh
sudo service mysql start
```

#### Answer 3 (score 110)
<p>This error occurs due to multiple installations of mysql. 
Run the command: </p>

```sh
ps -A|grep mysql
```

Kill the process by using:  

```sh
sudo pkill mysql
```

and then run command:  

```sh
ps -A|grep mysqld
```

Also Kill this process by running:  

```sh
sudo pkill mysqld
```

Now you are fully set just run the following commands:  

```sh
service mysql restart
mysql -u root -p
```

Have very well working mysql again  

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Is there a command to list all Unix group names? (score [1057247](https://stackoverflow.com/q/14059916) in 2017)

#### Question
I know there is the `/etc/group` file that lists all users groups.  

I would like to know if there is a simple command to list all user group names in spite of parsing the world readable `/etc/group` file. I am willing to create an administrator web page that lists Linux accounts' group names.  

#### Answer accepted (score 855)
To list all local groups which have users assigned to them, use this command:   

```sh
cut -d: -f1 /etc/group | sort
```

<p>For more info- >
<a href="http://www.udel.edu/it/help/unix/unixgroups.html" rel="noreferrer">Unix groups</a>,
<a href="https://www.geeksforgeeks.org/cut-command-linux-examples/" rel="noreferrer">Cut command</a>,
<a href="https://www.geeksforgeeks.org/sort-command-linuxunix-examples/" rel="noreferrer">sort command</a></p>

#### Answer 2 (score 256)
If you want <em>all groups</em> known to the system, I would recommend using `getent` instead of parsing `/etc/group`. On networked systems, groups may not only read from `/etc/group` file but also obtained through LDAP or Yellow Pages, i.e. the list of known groups comes from the local group file plus groups received via LDAP or YP.  

`getent group` will give you a list of <em>all</em> groups in the same format the `/etc/group` file uses.  

If you want just the group names, `getent group | cut -d: -f1` will do the job (same as above).  

#### Answer 3 (score 47)
On Linux, macOS and Unix to display the groups to which you belong, use:  

```sh
id -Gn
```

which is equivalent to `groups` utility which has been obsoleted on Unix (as per <a href="https://www.unix.com/man-page/FreeBSD/1/groups/" rel="noreferrer">Unix manual</a>).  

On macOS and Unix, the command `id -p` is suggested for normal interactive.  

Explanation of the parameters:  

<blockquote>
  `-G`, `--groups` - print all group IDs  
  
  `-n`, `--name` - print a name instead of a number, for `-ugG`  
  
  `-p` - Make the output human-readable.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: Lost httpd.conf file located apache (score [1043824](https://stackoverflow.com/q/12202021) in 2017)

#### Question
How can I find where my `httpd.conf` file is located?  

I am running an Ubuntu Linux server from the Amazon Web Services EC2 (Elastic Compute Cloud) and I can't find my Apache config.  

#### Answer accepted (score 641)
Get the path of running Apache  

```sh
$ ps -ef | grep apache
apache   12846 14590  0 Oct20 ?        00:00:00 /usr/sbin/apache2
```

Append `-V` argument to the path   

```sh
$ /usr/sbin/apache2 -V | grep SERVER_CONFIG_FILE
-D SERVER_CONFIG_FILE="/etc/apache2/apache2.conf"
```

<p>Reference:<br>
<a href="http://commanigy.com/blog/2011/6/8/finding-apache-configuration-file-httpd-conf-location" rel="noreferrer">http://commanigy.com/blog/2011/6/8/finding-apache-configuration-file-httpd-conf-location</a></p>

#### Answer 2 (score 208)
See <a href="http://wiki.apache.org/httpd/DistrosDefaultLayout">http://wiki.apache.org/httpd/DistrosDefaultLayout</a> for discussion of where you might find Apache httpd configuration files on various platforms, since this can vary from release to release and platform to platform. The most common answer, however, is either /etc/apache/conf or /etc/httpd/conf  

Generically, you can determine the answer by running the command:  

<blockquote>
  httpd -V  
</blockquote>

(That's a capital V). Or, on systems where httpd is renamed, perhaps `apache2ctl -V`  

This will return various details about how httpd is built and configured, including the default location of the main configuration file.  

One of the lines of output should look like:  

<blockquote>
  -D SERVER_CONFIG_FILE="conf/httpd.conf"  
</blockquote>

which, combined with the line:  

<blockquote>
  -D HTTPD_ROOT="/etc/httpd"  
</blockquote>

will give you a full path to the default location of the configuration file  

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: Linux error while loading shared libraries: cannot open shared object file: No such file or directory (score [1027980](https://stackoverflow.com/q/480764) in 2009)

#### Question
Program is part of the Xenomai test suite, cross-compiled from Linux PC into Linux+Xenomai ARM toolchain.  

```sh
# echo $LD_LIBRARY_PATH                                                                                                                                          
/lib                                                                                                                                                             
# ls /lib                                                                                                                                                        
ld-2.3.3.so         libdl-2.3.3.so      libpthread-0.10.so                                                                                                       
ld-linux.so.2       libdl.so.2          libpthread.so.0                                                                                                          
libc-2.3.3.so       libgcc_s.so         libpthread_rt.so                                                                                                         
libc.so.6           libgcc_s.so.1       libstdc++.so.6                                                                                                           
libcrypt-2.3.3.so   libm-2.3.3.so       libstdc++.so.6.0.9                                                                                                       
libcrypt.so.1       libm.so.6                                                                                                                                    
# ./clocktest                                                                                                                                                    
./clocktest: error while loading shared libraries: libpthread_rt.so.1: cannot open shared object file: No such file or directory                                 
```

<strong>Edit:</strong> OK I didn't notice the .1 at the end was part of the filename. What does that mean anyway?  

#### Answer accepted (score 129)
<p><strong>Update</strong><br>
While what I write below is true as a general answer about shared libraries, I think the most frequent cause of these sorts of message is because you've installed a package, but not installed the "-dev" version of that package. </p>

<hr>

Well, it's not lying - there is no `libpthread_rt.so.1` in that listing.  You probably need to re-configure and re-build it so that it depends on the library you have, or install whatever provides `libpthread_rt.so.1`.  

Generally, the numbers after the .so are version numbers, and you'll often find that they are symlinks to each other, so if you have version 1.1 of libfoo.so, you'll have a real file libfoo.so.1.0, and symlinks foo.so and foo.so.1 pointing to the libfoo.so.1.0.  And if you install version 1.1 without removing the other one, you'll have a libfoo.so.1.1, and libfoo.so.1 and libfoo.so will now point to the new one, but any code that requires that exact version can use the libfoo.so.1.0 file.  Code that just relies on the version 1 API, but doesn't care if it's 1.0 or 1.1 will specify libfoo.so.1.  As <a href="https://stackoverflow.com/users/37020/orip">orip</a> pointed out in the comments, this is explained well at <a href="http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html" rel="noreferrer">http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html</a>.  

In your case, you <em>might</em> get away with symlinking `libpthread_rt.so.1` to `libpthread_rt.so`.  No guarantees that it won't break your code and eat your TV dinners, though.  

#### Answer 2 (score 288)
<p>Your library is a dynamic library.
You need to tell the operating system where it can locate it at runtime.</p>

<p>To do so,
we will need to do those easy steps:</p>

(1 ) Find where the library is placed if you don't know it.  

```sh
sudo find / -name the_name_of_the_file.so
```

(2) Check for the existence of the dynamic library path environment variable(`LD_LIBRARY_PATH`)  

```sh
$ echo $LD_LIBRARY_PATH
```

if there is nothing to be displayed, add a default path value (or not if you wish to)  

```sh
$ LD_LIBRARY_PATH=/usr/local/lib
```

(3) We add the desire path, export it and try the application.  

<p>Note that the path should be the directory where the `path.so.something` is.
So if `path.so.something` is in `/my_library/path.so.something` it should be :</p>

```sh
$ LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/my_library/
$ export LD_LIBRARY_PATH
$ ./my_app
```

source : <a href="http://www.gnu.org/software/gsl/manual/html_node/Shared-Libraries.html" rel="noreferrer">http://www.gnu.org/software/gsl/manual/html_node/Shared-Libraries.html</a>  

#### Answer 3 (score 139)
Here are a few solutions you can try:  

<h5>ldconfig</h2>

As AbiusX pointed out: If you have just now installed the library, you may simply need to run <a href="http://linux.die.net/man/8/ldconfig" rel="noreferrer">ldconfig</a>.  

```sh
sudo ldconfig
```

<blockquote>
  <p>ldconfig creates the necessary links and cache to the most recent
  shared libraries found in the directories specified on the command
  line, in the file /etc/ld.so.conf, and in the trusted directories
  (/lib and /usr/lib).</p>
</blockquote>

Usually your package manager will take care of this when you install a new library, but not always, and it won't hurt to run ldconfig even if that is not your issue.  

<h5>Dev package or wrong version</h2>

If that doesn't work, I would also check out <a href="https://stackoverflow.com/a/480786/22781">Paul's suggestion</a> and look for a "-dev" version of the library. Many libraries are split into dev and non-dev packages. You can use this command to look for it:  

```sh
apt-cache search <libraryname>
```

This can also help if you simply have the wrong version of the library installed. Some libraries are published in different versions simultaneously, for example, Python.  

<h5>Library location</h2>

If you are sure that the right package is installed, and ldconfig didn't find it, it may just be in a nonstandard directory. By default, ldconfig looks in `/lib`, `/usr/lib`, and directories listed in `/etc/ld.so.conf` and `$LD_LIBRARY_PATH`. If your library is somewhere else, you can either add the directory on its own line in `/etc/ld.so.conf`, append the library's path to `$LD_LIBRARY_PATH`, or move the library into `/usr/lib`. Then run `ldconfig`.  

To find out where the library is, try this:  

```sh
sudo find / -iname *libraryname*.so*
```

(Replace `libraryname` with the name of your library)  

If you go the `$LD_LIBRARY_PATH` route, you'll want to put that into your `~/.bashrc` file so it will run every time you log in:  

```sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/path/to/library
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: Redirect all output to file (score [1007650](https://stackoverflow.com/q/6674327) in 2015)

#### Question
I know that in Linux, to redirect output from the screen to a file, I can either use the `&gt;` or `tee`. However, I'm not sure why part of the output is still output to the screen and not written to the file.   

Is there a way to redirect all output to file?  

#### Answer accepted (score 1122)
That part is written to stderr, use `2&gt;` to redirect it. For example:  

```sh
foo > stdout.txt 2> stderr.txt
```

or if you want in same file:  

```sh
foo > allout.txt 2>&1
```

Note: this works in (ba)sh, check your shell for proper syntax  

#### Answer 2 (score 141)
All POSIX operating systems <a href="http://en.wikipedia.org/wiki/Standard_streams" rel="noreferrer">have 3 streams</a>: stdin, stdout, and stderr. stdin is the input, which can accept the stdout or stderr. stdout is the primary output, which is redirected with `&gt;`, `&gt;&gt;`, or `|`. stderr is the error output, which is handled separately so that any exceptions do not get passed to a command or written to a file that it might break; normally, this is sent to a log of some kind, or dumped directly, even when the stdout is redirected. To redirect both to the same place, use:  

<strike>`<em>command</em> &amp;> /some/file`</strike>  

<strong>EDIT</strong>: thanks to Zack for pointing out that the above solution is not portable--use instead:      

```sh
*command* > file 2>&1 
```

If you want to silence the error, do:  

```sh
*command* 2> /dev/null
```

#### Answer 3 (score 84)
To get the output on the console AND in a file `file.txt` for example.  

```sh
make 2>&1 | tee file.txt
```

Note: `&amp;` (in `2&gt;&amp;1`) specifies that `1` is not a file name but a file descriptor.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: C++ IDE for Linux? (score [967131](https://stackoverflow.com/q/24109) in 2017)

#### Question
I want to expand my programming horizons to Linux. A good, dependable basic toolset is important, and what is more basic than an IDE?  

I could find these SO topics:  

<ul>
<li><a href="https://stackoverflow.com/questions/2756/lightweight-ide-for-linux">Lightweight IDE for linux</a> and</li>
<li><a href="https://stackoverflow.com/questions/17228/what-tools-do-you-use-to-develop-c-applications-on-linux">What tools do you use to develop
C++ applications on Linux?</a></li>
</ul>

I'm not looking for a <em>lightweight</em> IDE. If an IDE is worth the money, then I will pay for it, so it need not be free.  

My question, then:  

<blockquote>
  <em>What good, C++ programming IDE is available for Linux?</em>  
</blockquote>

<p>The minimums are fairly standard: syntax highlighting, code completion (like <a href="http://en.wikipedia.org/wiki/IntelliSense" rel="nofollow noreferrer">intellisense</a> or its Eclipse counterpart) and integrated debugging (e.g., basic
breakpoints).</p>

I have searched for it myself, but there are so many that it is almost impossible to separate the good from the bads by hand, especially for someone like me who has little  C++ coding experience in Linux. I know that <a href="http://www.eclipse.org/cdt/" rel="nofollow noreferrer">Eclipse supports C++</a>, and I really like that IDE for Java, but is it any good for C++ and is there something better?  

The second post actually has some good suggestions, but what I am missing is what exactly makes the sugested IDE so good for the user, what are its (dis)advantages?  

Maybe my question should therefore be:  

<blockquote>
  <em>What IDE do you propose (given your experiences), and why?</em>  
</blockquote>

#### Answer accepted (score 261)
<h5>Initially: confusion</h2>

When originally writing this answer, I had recently made the switch from Visual Studio (with years of experience) to Linux and the first thing I did was try to find a reasonable IDE. At the time this was impossible: no good IDE existed.  

<h5>Epiphany: UNIX is an IDE. <em>All of it.</em><sup>1</sup></h2>

And then I realised that the IDE in Linux is the command line with its tools:  

<ul>
<li>First you set up your shell

<ul>
<li>Bash, in my case, but many people prefer</li>
<li><a href="https://fishshell.com/" rel="noreferrer">fish</a> or</li>
<li><a href="https://github.com/robbyrussell/oh-my-zsh" rel="noreferrer">(Oh My) Zsh</a>;</li>
</ul></li>
<li>and your editor; pick your poison — both are state of the art:

<ul>
<li><a href="https://neovim.io/" rel="noreferrer">Neovim</a><sup>2</sup> or</li>
<li><a href="https://www.gnu.org/software/emacs/" rel="noreferrer">Emacs</a>.</li>
</ul></li>
</ul>

Depending on your needs, you will then have to install and configure several plugins to make the editor work nicely (that’s the one annoying part). For example, most programmers on Vim will benefit from the <a href="https://valloric.github.io/YouCompleteMe/" rel="noreferrer">YouCompleteMe</a> plugin for smart autocompletion.  

Once that’s done, the shell is your command interface to interact with the various tools — Debuggers (gdb), Profilers (gprof, valgrind), etc. You set up your project/build environment using <a href="https://www.gnu.org/software/make/" rel="noreferrer">Make</a>, <a href="https://bitbucket.org/snakemake/snakemake/wiki/Home" rel="noreferrer">CMake</a>, <a href="https://bitbucket.org/snakemake/snakemake/wiki/Home" rel="noreferrer">SnakeMake</a> or any of the various alternatives. And you manage your code with a version control system (most people use <a href="https://git-scm.com/" rel="noreferrer">Git</a>). You also use <a href="https://tmux.github.io/" rel="noreferrer">tmux</a> (previously also screen) to multiplex (= think multiple windows/tabs/panels) and persist your terminal session.  

The point is that, thanks to the shell and a few tool writing conventions, these all <em>integrate with each other</em>. And that way <strong>the Linux shell is a truly integrated development environment</strong>, completely on par with other modern IDEs. (This doesn’t mean that individual IDEs don’t have features that the command line may be lacking, but the inverse is also true.)  

<h5>To each their own</h2>

I cannot overstate how well the above workflow functions once you’ve gotten into the habit. But some people simply prefer graphical editors, and in the years since this answer was originally written, Linux has gained a suite of excellent graphical IDEs for several different programming languages (but not, as far as I’m aware, for C++). Do give them a try even if — like me — you end up not using them. Here’s just a small and biased selection:  

<ul>
<li>For Python development, there’s <a href="https://www.jetbrains.com/pycharm/" rel="noreferrer">PyCharm</a></li>
<li>For R, there’s <a href="https://www.rstudio.com/" rel="noreferrer">RStudio</a></li>
<li>For JavaScript and TypeScript, there’s <a href="https://code.visualstudio.com/" rel="noreferrer">Visual Studio Code</a> (which is also a good all-round editor)</li>
<li>And finally, many people love the <a href="https://www.sublimetext.com/" rel="noreferrer">Sublime Text editor</a> for general code editing.</li>
</ul>

Keep in mind that this list is far from complete.  

<hr>

<sup>1</sup> I stole that title from dsm’s comment.  

<sup>2</sup> I used to refer to Vim here. And while plain Vim is still more than capable, Neovim is a promising restart, and it’s modernised a few old warts.  

#### Answer 2 (score 86)
My personal favorite is the <strong>CodeLite 2.x</strong> IDE.  

see: <a href="http://www.codelite.org/" rel="noreferrer" title="codelite website">http://www.codelite.org</a>  

The decision to use CodeLite was based on a research regarding the following C++ IDE for Linux:  

<ul>
<li>Eclipse Galileo with CDT Plugin</li>
<li>NetBeans 6.7 (which is also the base for the SunStudio IDE)</li>
<li>KDevelop4</li>
<li>CodeBlocks 8.02</li>
<li>CodeLite 2.x</li>
</ul>

After all I have decided to use <em>CodeLite 2.x</em>.  

Below I have listed some Pros and Cons regarding the mentioned C++ IDEs. Please note, that this reflects my personal opinion only!  

<strong>EDIT</strong>: what a pity that SOF doesn't support tables, so I have to write in paragraphs ...  

<strong>Eclipse Galileo with CDT Plugin</strong>  

Pros:  

<ul>
<li>reasonable fast</li>
<li>also supports Java, Perl(with E.P.I.C plugin)</li>
<li>commonly used and well maintained</li>
<li>also available for other OS flavours (Windows, MacOS, Solaris, AIX(?))</li>
</ul>

Cons:  

<ul>
<li>GUI is very confusing and somewhat inconsistent - not very intuitive at all</li>
<li>heavy weight</li>
<li>Only supports CVS (AFAIK)</li>
</ul>

<strong>NetBeans 6.7</strong> (note this is also the base for the SunStudio IDE)  

Pros:  

<ul>
<li>one of the most intuitive GUI I have ever seen</li>
<li>also supports Java, Python, Ruby</li>
<li>integrates CVS, SVN, Mercurial</li>
<li>commonly used and well maintained</li>
<li>also available for other OS flavours (Windows, MacOS, Solaris)</li>
</ul>

Cons:  

<ul>
<li>extremly slow</li>
<li>heavy weight</li>
<li>uses Spaces for indentation, which is not the policy at my work. I'm sure this is configurable, but I couldn't find out how to to that</li>
</ul>

<strong>KDevelop4</strong> (note: I did not much testing on it)  

Pros:  

<ul>
<li>commonly used on Linux</li>
<li>integrates CVS, SVN, Mercurial</li>
</ul>

Cons:  

<ul>
<li>the GUI looks somewhat old fashioned</li>
<li>heavy weight</li>
<li>very specific to the KDE environment</li>
</ul>

<strong>CodeBlocks 8.02</strong> (note: I did not much testing on it)  

Pros:  

<ul>
<li>reasonable fast</li>
</ul>

Cons:  

<ul>
<li>the GUI looks somewhat old fashioned (although it has a nice startup screen)</li>
<li>the fonts in the editor are very small</li>
<li>some icons (e.g. the debugger related icons starting/stepping) are very small</li>
<li>no source control integration</li>
</ul>

<strong>CodeLite 2.x</strong> (note: this is my personal favorite)  

Pros:  

<ul>
<li>the best, modern looking and intuitive GUI I have seen on Linux</li>
<li>lightweight</li>
<li>reasonable fast</li>
<li>integrates SVN</li>
<li>also available on other OS flavours(Windows, MacOS, Solaris(?))</li>
</ul>

Cons:  

<ul>
<li>no CVS integration (that's important for me because I have to use it at work)</li>
<li>no support for Java, Perl, Python (would be nice to have)</li>
</ul>

#### Answer 3 (score 75)
<ol>
<li><a href="http://www.codeblocks.org/" rel="noreferrer">Code::Blocks</a> </li>
<li><a href="http://www.eclipse.org/cdt/" rel="noreferrer">Eclipse CDT</a></li>
</ol>

Soon you'll find that IDEs are not enough, and you'll have to learn the GCC toolchain anyway (which isn't hard, at least learning the basic functionality). But no harm in reducing the transitional pain with the IDEs, IMO.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: How to kill a process running on particular port in Linux? (score [954064](https://stackoverflow.com/q/11583562) in 2017)

#### Question
I tried to close the tomcat using `./shutdown.sh` from tomcat `/bin` directory. But found that the server was not closed properly. And thus I was unable to restart<br>My tomcat is running on port `8080`.  

I want to kill the tomcat process running on `8080`. I first want to have the list of processes running on a specific port (8080) in order to select which process to kill.  

#### Answer accepted (score 238)
Use the command  

```sh
 sudo netstat -plten |grep java
```

used `grep java` as `tomcat` uses `java` as their processes.  

It will show the list of processes with port number and process id  

```sh
tcp6       0      0 :::8080                 :::*                    LISTEN      
1000       30070621    16085/java
```

the number before `/java` is a process id. Now use `kill` command to kill the process  

```sh
kill -9 16085
```

`-9` implies the process will be killed forcefully.  

#### Answer 2 (score 807)
This `fuser 8080/tcp` will print you PID of process bound on that port.  

And this `fuser -k 8080/tcp` will kill that process.  

Works on Linux only. More universal is use of `lsof -i4` (or 6 for IPv6).   

#### Answer 3 (score 571)
To list any process listening to the port 8080:  

```sh
lsof -i:8080
```

To kill any process listening to the port 8080:  

```sh
kill $(lsof -t -i:8080)
```

or more violently:  

```sh
kill -9 $(lsof -t -i:8080)
```

(`-9` corresponds to the `SIGKILL - terminate immediately/hard kill` signal: see <a href="https://unix.stackexchange.com/q/317492/16704">List of Kill Signals</a> and <a href="https://askubuntu.com/q/184071/44876">What is the purpose of the -9 option in the kill command?</a>. If no signal is specified to `kill`, the TERM signal a.k.a. `-15` or `soft kill` is sent, which sometimes isn't enough to kill a process.).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: How to force cp to overwrite without confirmation (score [937183](https://stackoverflow.com/q/8488253) in 2016)

#### Question
I'm trying to use the `cp` command and force an overwrite.  

I have tried `cp -rf /foo/* /bar`, but I am still prompted to confirm each overwrite.  

#### Answer accepted (score 1020)
You can do `yes | cp -rf xxx yyy`, but my gutfeeling says that if you do it as root - your `.bashrc` or `.profile` has an alias of `cp` to `cp -i`, most modern systems (primarily RH-derivatives) do that to root profiles.   

You can check existing aliases by running `alias` at the command prompt, or `which cp` to check aliases only for `cp`.  

If you do have an alias defined, running `unalias cp` will abolish that for the current session, otherwise you can just remove it from your shell profile.  

You can temporarily bypass an alias and use the non-aliased version of a command by prefixing it with `\`, e.g. `\cp whatever`  

#### Answer 2 (score 260)
This is probably caused by `cp` being already aliased to something like `cp -i`. Calling `cp` directly should work:  

```sh
/bin/cp -rf /zzz/zzz/* /xxx/xxx
```

Another way to get around this is to use the `yes` command:  

```sh
yes | cp -rf /zzz/zzz/* /xxx/xxx
```

#### Answer 3 (score 109)
As some of the other answers have stated, you probably use an alias somewhere which maps `cp` to `cp -i` or something similar. You can run a command without any aliases by preceding it with a backslash. In your case, try  

```sh
\cp -r /zzz/zzz/* /xxx/xxx
```

The backslash will temporarily disable any aliases you have called `cp`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How do I prompt for Yes/No/Cancel input in a Linux shell script? (score [926403](https://stackoverflow.com/q/226703) in 2016)

#### Question
I want to pause input in a shell script, and prompt the user for choices. The standard 'Yes, No, or Cancel' type question. How do I accomplish this in a typical bash prompt?  

#### Answer accepted (score 1490)
The simplest and most widely available method to get user input at a shell prompt is the <a href="http://www.gnu.org/software/bash/manual/bashref.html#index-read" rel="noreferrer">`read`</a> command. The best way to illustrate its use is a simple demonstration:  

```sh
while true; do
    read -p "Do you wish to install this program?" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
```

Another method, <a href="https://stackoverflow.com/a/226946/9084">pointed out</a> by <a href="https://stackoverflow.com/users/28604/steven-huwig">Steven Huwig</a>, is Bash's <a href="http://www.gnu.org/software/bash/manual/bashref.html#index-select" rel="noreferrer">`select`</a> command. Here is the same example using `select`:  

```sh
echo "Do you wish to install this program?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) make install; break;;
        No ) exit;;
    esac
done
```

With `select` you don't need to sanitize the input &ndash; it displays the available choices, and you type a number corresponding to your choice. It also loops automatically, so there's no need for a `while true` loop to retry if they give invalid input.  

Also, <a href="https://stackoverflow.com/users/7939871/l%c3%a9a-gris">Léa Gris</a> demonstrated a way to make the request language agnostic in <a href="https://stackoverflow.com/a/57739142/9084">her answer</a>. Adapting my first example to better serve multiple languages might look like this:  

```sh
set -- $(locale LC_MESSAGES)
yesptrn="$1"; noptrn="$2"; yesword="$3"; noword="$4"

while true; do
    read -p "Install (${yesword} / ${noword})? " yn
    case $yn in
        ${yesptrn##^} ) make install; break;;
        ${noptrn##^} ) exit;;
        * ) echo "Answer ${yesword} / ${noword}.";;
    esac
done
```

Obviously other communication strings remain untranslated here (Install, Answer) which would need to be addressed in a more fully completed translation, but even a partial translation would be helpful in many cases.  

Finally, please check out the <a href="https://stackoverflow.com/a/27875395/9084">excellent answer</a> by <a href="https://stackoverflow.com/users/1765658/f-hauri">F. Hauri</a>.  

#### Answer 2 (score 483)
<h5>At least five answers for one generic question.</h1>

Depending on  

<ul>
<li><a href="/questions/tagged/posix" class="post-tag" title="show questions tagged &#39;posix&#39;" rel="tag">posix</a> compliant: could work on poor systems with generic <a href="/questions/tagged/shell" class="post-tag" title="show questions tagged &#39;shell&#39;" rel="tag">shell</a> environments</li>
<li><a href="/questions/tagged/bash" class="post-tag" title="show questions tagged &#39;bash&#39;" rel="tag">bash</a> specific: using so called <em>bashisms</em></li>
</ul>

and if you want  

<ul>
<li>simple ``in line'' question / answer (generic solutions)</li>
<li>pretty formatted interfaces, like <a href="/questions/tagged/ncurses" class="post-tag" title="show questions tagged &#39;ncurses&#39;" rel="tag">ncurses</a> or more graphical using libgtk or libqt...</li>
<li>use powerful readline history capability</li>
</ul>

<h5>1. POSIX generic solutions</h2>

You could use the `read` command, followed by `if ... then ... else`:  

```sh
echo -n "Is this a good question (y/n)? "
read answer
```

<s>  

```sh
# if echo "$answer" | grep -iq "^y" ;then
```

</s>  

```sh
if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo Yes
else
    echo No
fi
```

(Thanks to <a href="https://stackoverflow.com/posts/comments/86532780?noredirect=1">Adam Katz's comment</a>: Replaced the test above with one that is more portable and avoids one fork:)  

<h5>POSIX, but single key feature</h3>

But if you don't want the user to have to hit <kbd>Return</kbd>, you could write:  

(<strong>Edited:</strong> As @JonathanLeffler rightly suggest, <em>saving</em> stty's configuration could be better than simply force them to <em>sane</em>.)  

```sh
echo -n "Is this a good question (y/n)? "
old_stty_cfg=$(stty -g)
stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg # Careful playing with stty
if echo "$answer" | grep -iq "^y" ;then
    echo Yes
else
    echo No
fi
```

<strong>Note:</strong> This was tested under <a href="/questions/tagged/sh" class="post-tag" title="show questions tagged &#39;sh&#39;" rel="tag">sh</a>, <a href="/questions/tagged/bash" class="post-tag" title="show questions tagged &#39;bash&#39;" rel="tag">bash</a>, <a href="/questions/tagged/ksh" class="post-tag" title="show questions tagged &#39;ksh&#39;" rel="tag">ksh</a>, <a href="/questions/tagged/dash" class="post-tag" title="show questions tagged &#39;dash&#39;" rel="tag">dash</a> and <a href="/questions/tagged/busybox" class="post-tag" title="show questions tagged &#39;busybox&#39;" rel="tag">busybox</a>!  

Same, but waiting explicitly for <kbd>y</kbd> or <kbd>n</kbd>:  

```sh
#/bin/sh
echo -n "Is this a good question (y/n)? "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
    echo Yes
else
    echo No
fi
```

<h5>Using dedicated tools</h3>

There are many tools which were built using `libncurses`, `libgtk`, `libqt` or other graphical libraries. For example, using `whiptail`:  

```sh
if whiptail --yesno "Is this a good question" 20 60 ;then
    echo Yes
else
    echo No
fi
```

Depending on your system, you may need to replace `whiptail` with another similiar tool:  

```sh
dialog --yesno "Is this a good question" 20 60 && echo Yes

gdialog --yesno "Is this a good question" 20 60 && echo Yes

kdialog --yesno "Is this a good question" 20 60 && echo Yes
```

where `20` is height of dialog box in number of lines and `60` is width of  the dialog box. These tools all have <em>near same</em> syntax.  

```sh
DIALOG=whiptail
if [ -x /usr/bin/gdialog ] ;then DIALOG=gdialog ; fi
if [ -x /usr/bin/xdialog ] ;then DIALOG=xdialog ; fi
...
$DIALOG --yesno ...
```

<h5>2. Bash specific solutions</h2>

<h5>Basic <em>in line</em> method</h3>

```sh
read -p "Is this a good question (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        echo Yes
    ;;
    * )
        echo No
    ;;
esac
```

I prefer to use `case` so I could even test for `yes | ja | si | oui` if needed...  

<h5><em>in line</em> with <em>single key</em> feature</h3>

Under bash, we can specify the length of intended input for for the `read` command:  

```sh
read -n 1 -p "Is this a good question (y/n)? " answer
```

Under bash, `read` command accepts a <em>timeout</em> parameter, which could be useful.  

```sh
read -t 3 -n 1 -p "Is this a good question (y/n)? " answer
[ -z "$answer" ] && answer="Yes"  # if 'yes' have to be default choice
```

<h5>Some tricks for <em>dedicated tools</em></h3>

More sophisticated dialog boxes, beyond simple <em>`yes - no`</em> purposes:  

```sh
dialog --menu "Is this a good question" 20 60 12 y Yes n No m Maybe
```

Progress bar:  

```sh
dialog --gauge "Filling the tank" 20 60 0 < <(
    for i in {1..100};do
        printf "XXX\n%d\n%(%a %b %T)T progress: %d\nXXX\n" $i -1 $i
        sleep .033
    done
) 
```

Little demo:  

```sh
#!/bin/sh
while true ;do
    [ -x "$(which ${DIALOG%% *})" ] || DIALOG=dialog
    DIALOG=$($DIALOG --menu "Which tool for next run?" 20 60 12 2>&1 \
            whiptail       "dialog boxes from shell scripts" >/dev/tty \
            dialog         "dialog boxes from shell with ncurses" \
            gdialog        "dialog boxes from shell with Gtk" \
            kdialog        "dialog boxes from shell with Kde" ) || exit
    clear;echo "Choosed: $DIALOG."
    for i in `seq 1 100`;do
        date +"`printf "XXX\n%d\n%%a %%b %%T progress: %d\nXXX\n" $i $i`"
        sleep .0125
      done | $DIALOG --gauge "Filling the tank" 20 60 0
    $DIALOG --infobox "This is a simple info box\n\nNo action required" 20 60
    sleep 3
    if $DIALOG --yesno  "Do you like this demo?" 20 60 ;then
        AnsYesNo=Yes; else AnsYesNo=No; fi
    AnsInput=$($DIALOG --inputbox "A text:" 20 60 "Text here..." 2>&1 >/dev/tty)
    AnsPass=$($DIALOG --passwordbox "A secret:" 20 60 "First..." 2>&1 >/dev/tty)
    $DIALOG --textbox /etc/motd 20 60
    AnsCkLst=$($DIALOG --checklist "Check some..." 20 60 12 \
        Correct "This demo is useful"        off \
        Fun        "This demo is nice"        off \
        Strong        "This demo is complex"        on 2>&1 >/dev/tty)
    AnsRadio=$($DIALOG --radiolist "I will:" 20 60 12 \
        " -1" "Downgrade this answer"        off \
        "  0" "Not do anything"                on \
        " +1" "Upgrade this anser"        off 2>&1 >/dev/tty)
    out="Your answers:\nLike: $AnsYesNo\nInput: $AnsInput\nSecret: $AnsPass"
    $DIALOG --msgbox "$out\nAttribs: $AnsCkLst\nNote: $AnsRadio" 20 60
  done
```

More sample? Have a look at <a href="https://stackoverflow.com/questions/50560500/linux-shell-get-device-id-from-user-input/50577400#50577400">Using whiptail for choosing USB device</a> and <a href="https://unix.stackexchange.com/questions/119759/removable-usb-stick-listed-as-non-removable-in-sys-block/119816#119816">USB removable storage selector: USBKeyChooser</a>  

<h5>5. Using readline's history</h3>

Example:  

```sh
#!/bin/bash

set -i
HISTFILE=~/.myscript.history
history -c
history -r

myread() {
    read -e -p '> ' $1
    history -s ${!1}
}
trap 'history -a;exit' 0 1 2 3 6

while myread line;do
    case ${line%% *} in
        exit )  break ;;
        *    )  echo "Doing something with '$line'" ;;
      esac
  done
```

This will create a file `.myscript.history` in your `$HOME` directory, than you could use readline's history commands, like <kbd>Up</kbd>,  <kbd>Down</kbd>, <kbd>Ctrl</kbd>+<kbd>r</kbd> and others.  

#### Answer 3 (score 346)
```sh
echo "Please enter some input: "
read input_variable
echo "You entered: $input_variable"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: How can I generate a list of files with their absolute path in Linux? (score [923845](https://stackoverflow.com/q/246215) in 2019)

#### Question
I am writing a shell script that takes file paths as input.  

For this reason, I need to generate recursive file listings with full paths. For example, the file `bar` has the path:  

```sh
/home/ken/foo/bar
```

but, as far as I can see, both `ls` and `find` only give relative path listings:  

```sh
./foo/bar   (from the folder ken)
```

It seems like an obvious requirement, but I can't see anything in the `find` or `ls` man pages.  

How can I generate a list of files in the shell including their absolute paths?  

#### Answer accepted (score 264)
If you give `find` an absolute path to start with, it will print absolute paths. For instance, to find all .htaccess files in the current directory:  

```sh
find "$(pwd)" -name .htaccess
```

or if your shell expands `$PWD` to the current directory:  

```sh
find "$PWD" -name .htaccess
```

`find` simply prepends the path it was given to a relative path to the file from that path.   

<a href="https://stackoverflow.com/users/893/greg-hewgill">Greg Hewgill</a> also suggested using `pwd -P` if you want to resolve symlinks in your current directory.  

#### Answer 2 (score 189)
```sh
readlink -f filename 
```

gives the full absolute path. but if the file is a symlink, u'll get the final resolved name.  

#### Answer 3 (score 107)
Use this for dirs (the `/` after `**` is needed in bash to limit it to directories):  

```sh
ls -d -1 "$PWD/"**/
```

this for files and directories directly under the current directory, whose names contain a `.`:  

```sh
ls -d -1 "$PWD/"*.*
```

this for everything:  

```sh
ls -d -1 "$PWD/"**/*
```

<p>Taken from here
  <a href="http://www.zsh.org/mla/users/2002/msg00033.html" rel="noreferrer">http://www.zsh.org/mla/users/2002/msg00033.html</a></p>

In bash, `**` is recursive if you enable `shopt -s globstar`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: Remove a symlink to a directory (score [921379](https://stackoverflow.com/q/210120) in 2014)

#### Question
I have a symlink to an important directory. I want to get rid of that symlink, while keeping the directory behind it.    

<p>I tried `rm` and get back `rm: cannot remove 'foo'`.<br>
I tried `rmdir` and got back `rmdir: failed to remove 'foo': Directory not empty`<br>
I then progressed through `rm -f`, `rm -rf` and `sudo rm -rf`</p>

Then I went to find my back-ups.  

Is there a way to get rid of the symlink with out throwing away the baby with the bathwater?     

#### Answer accepted (score 1280)
```sh
# this works
rm foo
# versus
rm foo/
```

Basically, you need to tell it to delete a file, not delete a directory. I believe the difference between `rm` and `rmdir` exists because of differences in the way the C library treats each.  

At any rate, the first should work, while the second should complain about foo being a directory.  

If it doesn't work as above, then check your permissions. You need write permission to the containing directory to remove files.  

#### Answer 2 (score 827)
use the "unlink" command and make sure <strong>not</strong> to have the / at the end  

```sh
$ unlink mySymLink
```

<blockquote>
  <p>unlink() deletes a name from the file system. <strong>If that name was the last link to a file and no processes have the file open the file is deleted and the space it was using is made available for reuse.</strong>
  If the name was the last link to a file but any processes still have the file open the file will remain in existence until the last file descriptor referring to it is closed.</p>
</blockquote>

I think this may be problematic if I'm reading it correctly.  

<blockquote>
  <strong>If the name referred to a symbolic link the link is removed.</strong>  
  
  If the name referred to a socket, fifo or device the name for it is removed but processes which have the object open may continue to use it.  
</blockquote>

<a href="https://linux.die.net/man/2/unlink" rel="noreferrer">https://linux.die.net/man/2/unlink</a>  

#### Answer 3 (score 17)
rm should remove the symbolic link.  

```sh
skrall@skrall-desktop:~$ mkdir bar
skrall@skrall-desktop:~$ ln -s bar foo
skrall@skrall-desktop:~$ ls -l foo
lrwxrwxrwx 1 skrall skrall 3 2008-10-16 16:22 foo -> bar
skrall@skrall-desktop:~$ rm foo
skrall@skrall-desktop:~$ ls -l foo
ls: cannot access foo: No such file or directory
skrall@skrall-desktop:~$ ls -l bar
total 0
skrall@skrall-desktop:~$ 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: HTTP POST and GET using cURL in Linux (score [908003](https://stackoverflow.com/q/14978411) in 2019)

#### Question
I have a server application written in ASP.NET on Windows that provides a web service.  

How can I call the web service in Linux with cURL?  

#### Answer 2 (score 676)
*nix provides a nice little command which makes our lives a lot easier.  

<strong>GET:</strong>  

<em>with JSON:</em>  

```sh
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://hostname/resource
```

<em>with XML:</em>  

```sh
curl -H "Accept: application/xml" -H "Content-Type: application/xml" -X GET http://hostname/resource
```

<strong>POST:</strong>  

<em>For posting data:</em>  

```sh
curl --data "param1=value1&param2=value2" http://hostname/resource
```

<em>For file upload:</em>  

```sh
curl --form "fileupload=@filename.txt" http://hostname/resource
```

<em>RESTful HTTP Post:</em>  

```sh
curl -X POST -d @filename http://hostname/resource
```

<em>For logging into a site (auth):</em>  

```sh
curl -d "username=admin&password=admin&submit=Login" --dump-header headers http://localhost/Login
curl -L -b headers http://localhost/
```

<strong>Pretty-printing the curl results:</strong>  

<em>For JSON:</em>  

If you use `npm` and `nodejs`, you can install `json` package by running this command:  

```sh
npm install -g json
```

Usage:  

```sh
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://hostname/resource | json
```

If you use `pip` and `python`, you can install `pjson` package by running this command:  

```sh
pip install pjson
```

Usage:  

```sh
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://hostname/resource | pjson
```

If you use Python 2.6+, json tool is bundled within.  

Usage:  

```sh
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://hostname/resource | python -m json.tool
```

If you use `gem` and `ruby`, you can install `colorful_json` package by running this command:  

```sh
gem install colorful_json
```

Usage:  

```sh
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://hostname/resource | cjson
```

If you use `apt-get` (aptitude package manager of your Linux distro), you can install `yajl-tools` package by running this command:  

```sh
sudo apt-get install yajl-tools
```

Usage:  

```sh
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://hostname/resource |  json_reformat
```

<em>For XML:</em>  

If you use *nix with Debian/Gnome envrionment, install `libxml2-utils`:  

```sh
sudo apt-get install libxml2-utils
```

Usage:  

```sh
curl -H "Accept: application/xml" -H "Content-Type: application/xml" -X GET http://hostname/resource | xmllint --format -
```

or install `tidy`:  

```sh
sudo apt-get install tidy
```

Usage:  

```sh
curl -H "Accept: application/xml" -H "Content-Type: application/xml" -X GET http://hostname/resource | tidy -xml -i -
```

<strong>Saving the curl response to a file</strong>  

```sh
curl http://hostname/resource >> /path/to/your/file
```

or  

```sh
curl http://hostname/resource -o /path/to/your/file
```

For detailed description of the curl command, hit:  

```sh
man curl
```

For details about options/switches of the curl command, hit:  

```sh
curl -h
```

#### Answer 3 (score 50)
I think Amith Koujalgi is correct but also, in cases where the webservice responses are in JSON then it might be more useful to see the results in a clean JSON format instead of a very long string. Just add | grep }| python -mjson.tool  to the end of curl commands here is two examples:  

<strong>GET approach with JSON result</strong>  

```sh
curl -i -H "Accept: application/json" http://someHostName/someEndpoint | grep }| python -mjson.tool 
```

<strong>POST approach with JSON result</strong>  

```sh
curl -X POST  -H "Accept: Application/json" -H "Content-Type: application/json" http://someHostName/someEndpoint -d '{"id":"IDVALUE","name":"Mike"}' | grep }| python -mjson.tool
```

<img src="https://i.stack.imgur.com/T2FqW.png" alt="enter image description here">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: How to run a shell script at startup (score [904087](https://stackoverflow.com/q/12973777) in 2018)

#### Question
On an amazon linux instance, I have two scripts called `start_my_app` and `stop_my_app` which start and stop <em><a href="https://www.npmjs.com/package/forever" rel="noreferrer">forever</a></em> (which in turn runs my node.js app). I use these scripts to manually start and stop my node app. So far so good.  

My problem: I also want to set it up such that `start_my_app` is run whenever the system boots up. I know that I need to add a file inside `init.d` and I know how to symlink it to the proper directory within `rc.d`, but can't figure out what actually needs to go inside the file that I place in `init.d`. I'm thinking it should be just one line, like, `start_my_app`, but that hasn't been working for me.  

#### Answer accepted (score 276)
In the file you put in `/etc/init.d/` you have to set it executable with:  

```sh
chmod +x /etc/init.d/start_my_app
```

Thanks to @meetamit, if this does not run you have to create a symlink to `/etc/rc.d/`  

```sh
ln -s /etc/init.d/start_my_app /etc/rc.d/
```

<p>Please note that on latest Debian, this will not work as your script have to be LSB compliant (provide, at least, the following actions: start, stop, restart, force-reload, and status):
<a href="https://wiki.debian.org/LSBInitScripts" rel="noreferrer">https://wiki.debian.org/LSBInitScripts</a></p>

As a note, you should put the absolute path of your script instead of a relative one, it may solves unexpected issues:  

```sh
/var/myscripts/start_my_app
```

And don't forget to add on top of that file:   

```sh
#!/bin/sh
```

#### Answer 2 (score 298)
Set a crontab for this   

```sh
#crontab -e
@reboot  /home/user/test.sh
```

after every startup it will run the test script.  

#### Answer 3 (score 121)
A simple approach is to add a line in `/etc/rc.local` :  

```sh
/PATH/TO/MY_APP &
```

or if you want to run the command as a special user :  

```sh
su - USER_FOOBAR -c /PATH/TO/MY_APP &
```

(the trailing ampersand backgrounds the process and allows the rc.local to continue executing)  

If you want a full init script, debian distro have a template file, so :  

```sh
cp /etc/init.d/skeleton /etc/init.d/your_app
```

and adapt it a bit.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: How to exclude a directory in find . command (score [899880](https://stackoverflow.com/q/4210042) in 2018)

#### Question
I'm trying to run a `find` command for all JavaScript files, but how do I exclude a specific directory?  

Here is the `find` code we're using.  

```sh
for file in $(find . -name '*.js')
do 
  java -jar config/yuicompressor-2.4.2.jar --type js $file -o $file
done
```

#### Answer accepted (score 969)
Use the `-prune` switch. For example, if you want to exclude the `misc` directory just add a `-path ./misc -prune -o` to your find command:  

```sh
find . -path ./misc -prune -o -name '*.txt' -print
```

Here is an example with multiple directories:  

```sh
find . -type d \( -path dir1 -o -path dir2 -o -path dir3 \) -prune -o -print
```

Here we exclude <em>dir1</em>, <em>dir2</em> and <em>dir3</em>, since in `find` expressions it is an action that acts on the criteria `-path dir1 -o -path dir2 -o -path dir3` (if <em>dir1</em> or <em>dir2</em> or <em>dir3</em>), ANDed with `type -d`.  

Further action is `-o print`, just print.   

#### Answer 2 (score 1810)
If `-prune` doesn't work for you, this will:  

```sh
find -name "*.js" -not -path "./directory/*"
```

<strong>Caveat:</strong> requires traversing all of the unwanted directories.  

#### Answer 3 (score 429)
I find the following easier to reason about than other proposed solutions:  

```sh
find build -not \( -path build/external -prune \) -name \*.js
# you can also exclude multiple paths
find build -not \( -path build/external -prune \) -not \( -path build/blog -prune \) -name \*.js
```

<strong>Important Note:</strong> the paths you type after `-path` must exactly match what `find` would print without the exclusion. If this sentence confuses you just make sure to use full paths through out the <em>whole</em> command like this: `find <strong>/full/path/</strong> -not \( -path <strong>/full/path/exclude/this</strong> -prune \) ...`. See note [1] if you'd like a better understanding.  

Inside `\(` and `\)` is an expression that will match <em>exactly</em> `build/external` (see important note above), and will, on success, <em>avoid traversing anything below</em>. This is then grouped as a single expression with the escaped parenthesis, and prefixed with `-not` which will make `find` skip anything that was matched by that expression.  

One might ask if adding `-not` will not make all other files hidden by `-prune` reappear, and the answer is no. The way `-prune` works is that anything that, once it is reached, the files below that directory are permanently ignored.  

This comes from an actual use case, where I needed to call yui-compressor on some files generated by wintersmith, but leave out other files that need to be sent as-is.  

<hr>

<strong>Note [1]</strong>: If you want to exclude `/tmp/foo/bar` and you run find like this "`find /tmp \(...`" then you must specify `-path /tmp/foo/bar`. If on the other hand you run find like this `cd /tmp; find . \(...` then you must specify `-path ./foo/bar`.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: How to change the output color of echo in Linux (score [896232](https://stackoverflow.com/q/5947742) in 2017)

#### Question
I am trying to print a text in the terminal using echo command.   

I want to print the text in a red color. How can I do that?  

#### Answer 2 (score 2055)
You can use these <a href="https://en.wikipedia.org/wiki/ANSI_escape_code" rel="noreferrer">ANSI escape codes</a>:  

```sh
Black        0;30     Dark Gray     1;30
Red          0;31     Light Red     1;31
Green        0;32     Light Green   1;32
Brown/Orange 0;33     Yellow        1;33
Blue         0;34     Light Blue    1;34
Purple       0;35     Light Purple  1;35
Cyan         0;36     Light Cyan    1;36
Light Gray   0;37     White         1;37
```

And then use them like this in your script:  

```sh
#    .---------- constant part!
#    vvvv vvvv-- the code from above
RED='\033[0;31m'
NC='\033[0m' # No Color
printf "I ${RED}love${NC} Stack Overflow\n"
```

which prints `love` in red.  

From @james-lim's comment, <strong>if you are using the `echo` command, be sure to use the -e flag to allow backslash escapes</strong>.  

```sh
# Continued from above example
echo -e "I ${RED}love${NC} Stack Overflow"
```

(don't add `"\n"` when using echo unless you want to add additional empty line)  

#### Answer 3 (score 868)
You can use the awesome `tput` command (suggested in <a href="https://stackoverflow.com/a/5947788/24874">Ignacio's answer</a>) to produce terminal control codes for all kinds of things.  

<hr>

<h5>Usage</h1>

Specific `tput` sub-commands are discussed later.  

<h5>Direct</h3>

Call `tput` as part of a sequence of commands:  

```sh
tput setaf 1; echo "this is red text"
```

Use `;` instead of `&amp;&amp;` so if `tput` errors the text still shows.  

<h5>Shell variables</h3>

Another option is to use shell variables:  

```sh
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
echo "${red}red text ${green}green text${reset}"
```

`tput` produces character sequences that are interpreted by the terminal as having a special meaning. They will not be shown themselves. Note that they can still be saved into files or processed as input by programs other than the terminal.  

<h5>Command substitution</h3>

It may be more convenient to insert `tput`'s output directly into your `echo` strings using <a href="http://tldp.org/LDP/abs/html/commandsub.html" rel="noreferrer">command substitution</a>:  

```sh
echo "$(tput setaf 1)Red text $(tput setab 7)and white background$(tput sgr 0)"
```

<hr>

<h5>Example</h1>

The above command produces this on Ubuntu:  

<img src="https://i.stack.imgur.com/6tYnk.png" alt="Screenshot of colour terminal text">  

<hr>

<h5>Foreground &amp; background colour commands</h1>

```sh
tput setab [1-7] # Set the background colour using ANSI escape
tput setaf [1-7] # Set the foreground colour using ANSI escape
```

Colours are as follows:  

```sh
Num  Colour    #define         R G B

0    black     COLOR_BLACK     0,0,0
1    red       COLOR_RED       1,0,0
2    green     COLOR_GREEN     0,1,0
3    yellow    COLOR_YELLOW    1,1,0
4    blue      COLOR_BLUE      0,0,1
5    magenta   COLOR_MAGENTA   1,0,1
6    cyan      COLOR_CYAN      0,1,1
7    white     COLOR_WHITE     1,1,1
```

There are also non-ANSI versions of the colour setting functions (`setb` instead of `setab`, and `setf` instead of `setaf`) which use different numbers, not given here.  

<h5>Text mode commands</h1>

```sh
tput bold    # Select bold mode
tput dim     # Select dim (half-bright) mode
tput smul    # Enable underline mode
tput rmul    # Disable underline mode
tput rev     # Turn on reverse video mode
tput smso    # Enter standout (bold) mode
tput rmso    # Exit standout mode
```

<h5>Cursor movement commands</h1>

```sh
tput cup Y X # Move cursor to screen postion X,Y (top left is 0,0)
tput cuf N   # Move N characters forward (right)
tput cub N   # Move N characters back (left)
tput cuu N   # Move N lines up
tput ll      # Move to last line, first column (if no cup)
tput sc      # Save the cursor position
tput rc      # Restore the cursor position
tput lines   # Output the number of lines of the terminal
tput cols    # Output the number of columns of the terminal
```

<h5>Clear and insert commands</h1>

```sh
tput ech N   # Erase N characters
tput clear   # Clear screen and move the cursor to 0,0
tput el 1    # Clear to beginning of line
tput el      # Clear to end of line
tput ed      # Clear to end of screen
tput ich N   # Insert N characters (moves rest of line forward!)
tput il N    # Insert N lines
```

<h5>Other commands</h1>

```sh
tput sgr0    # Reset text format to the terminal's default
tput bel     # Play a bell
```

With <a href="https://extensions.gnome.org/extension/669/wobbly-windows/" rel="noreferrer">compiz wobbly windows</a>, the `bel` command makes the terminal wobble for a second to draw the user's attention.  

<hr>

<h5>Scripts</h1>

`tput` accepts scripts containing one command per line, which are executed in order before `tput` exits.  

Avoid temporary files by echoing a multiline string and piping it:  

```sh
echo -e "setf 7\nsetb 1" | tput -S  # set fg white and bg red
```

<hr>

<h5>See also</h1>

<ul>
<li>See <a href="http://unixhelp.ed.ac.uk/CGI/man-cgi?tput+1" rel="noreferrer">`man 1 tput`</a></li>
<li>See <a href="http://www.manpagez.com/man/5/terminfo/" rel="noreferrer">`man 5 terminfo`</a> for the complete list of commands and more details on these options. (The corresponding `tput` command is listed in the `Cap-name` column of the huge table that starts at line 81.)</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES) (score [860136](https://stackoverflow.com/q/21944936) in 2019)

#### Question
I am an electrical engineer who mainly plays around with power systems instead of programming. Recently, I have been following a manual to install a software suite on Ubuntu. I have no knowledge of `mySQL` at all, actually. I have done the following installations on my Ubuntu.  

```sh
sudo apt-get update
sudo apt-get install mysql-server-5.5
sudo apt-get install mysql-client-5.5
sudo apt-get install mysql-common
sudo apt-get install glade
sudo apt-get install ntp
```

Then I do  

```sh
me@ubuntu:~/Desktop/iPDC-v1.3.1/DBServer-1.1$ mysql -uroot -proot <"Db.sql"
```

I ended up with the following error message.  

```sh
ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)
```

How may I fix it and continue?  

#### Answer accepted (score 140)
<strong>Note:</strong> For <strong>MySQL 5.7+</strong> please see <a href="/a/42967789">answer from @Lahiru</a> to this question.  That contains more current information.  

For MySQL &lt; 5.7:  

The default root password is blank (i.e. empty string) not `root`. So you can just login as:  

```sh
mysql -u root
```

You should obviously change your root password after installation  

```sh
mysqladmin -u root password [newpassword]
```

In most cases you should also set up individual user accounts before working extensively with the DB as well.  

#### Answer 2 (score 112)
I was able to solve this problem by executing this statement  

```sh
sudo dpkg-reconfigure mysql-server-5.5
```

Which will change the root password.  

#### Answer 3 (score 68)
You have to reset the password! steps for mac osx(tested and working) and ubuntu  

Stop MySQL using  

```sh
sudo service mysql stop
```

or  

```sh
$ sudo /usr/local/mysql/support-files/mysql.server stop
```

Start it in safe mode:  

```sh
$ sudo mysqld_safe --skip-grant-tables --skip-networking
```

(above line is the whole command)  

This will be an ongoing command until the process is finished so open another shell/terminal window, log in without a password:  

```sh
$ mysql -u root

mysql> UPDATE mysql.user SET Password=PASSWORD('password') WHERE User='root';
```

As per @IberoMedia's comment, for newer versions of MySQL, the field is called `authentication_string`:  

```sh
mysql> UPDATE mysql.user SET authentication_string =PASSWORD('password') WHERE User='root';
```

Start MySQL using:  

```sh
sudo service mysql start
```

or  

```sh
sudo /usr/local/mysql/support-files/mysql.server start
```

your new password is 'password'.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: usr/bin/ld: cannot find -l<nameOfTheLibrary> (score [838868](https://stackoverflow.com/q/16710047) in 2016)

#### Question
I'm trying to compile my program and it returns this error :  

```sh
usr/bin/ld: cannot find -l<nameOfTheLibrary>
```

in my makefile I use the command `g++` and link to my library which is a symbolic link to my library located on an other directory.  

Is there an option to add to make it work please?  

#### Answer accepted (score 172)
If your library name is say `libxyz.so` and it is located on path say:  

```sh
/home/user/myDir
```

then to link it to your program:  

```sh
g++ -L/home/user/myDir -lxyz myprog.cpp -o myprog
```

#### Answer 2 (score 416)
To figure out what the linker is looking for, run it in verbose mode.    

For example, I encountered this issue while trying to compile MySQL with ZLIB support.  I was receiving an error like this during compilation:  

```sh
/usr/bin/ld: cannot find -lzlib
```

I did some Googl'ing and kept coming across different issues of the same kind where people would say to make sure the .so file actually exists and if it doesn't, then create a symlink to the versioned file, for example, zlib.so.1.2.8.  But, when I checked, zlib.so DID exist.  So, I thought, surely that couldn't be the problem.    

I came across another post on the Internets that suggested to run make with LD_DEBUG=all:  

```sh
LD_DEBUG=all make
```

Although I got a TON of debugging output, it wasn't actually helpful.  It added more confusion than anything else.  So, I was about to give up.  

Then, I had an epiphany.  I thought to actually check the help text for the ld command:  

```sh
ld --help
```

From that, I figured out how to run ld in verbose mode (imagine that):  

```sh
ld -lzlib --verbose
```

This is the output I got:  

```sh
==================================================
attempt to open /usr/x86_64-linux-gnu/lib64/libzlib.so failed
attempt to open /usr/x86_64-linux-gnu/lib64/libzlib.a failed
attempt to open /usr/local/lib64/libzlib.so failed
attempt to open /usr/local/lib64/libzlib.a failed
attempt to open /lib64/libzlib.so failed
attempt to open /lib64/libzlib.a failed
attempt to open /usr/lib64/libzlib.so failed
attempt to open /usr/lib64/libzlib.a failed
attempt to open /usr/x86_64-linux-gnu/lib/libzlib.so failed
attempt to open /usr/x86_64-linux-gnu/lib/libzlib.a failed
attempt to open /usr/local/lib/libzlib.so failed
attempt to open /usr/local/lib/libzlib.a failed
attempt to open /lib/libzlib.so failed
attempt to open /lib/libzlib.a failed
attempt to open /usr/lib/libzlib.so failed
attempt to open /usr/lib/libzlib.a failed
/usr/bin/ld.bfd.real: cannot find -lzlib
```

Ding, ding, ding...  

So, to finally fix it so I could compile MySQL with my own version of ZLIB (rather than the bundled version):  

```sh
sudo ln -s /usr/lib/libz.so.1.2.8 /usr/lib/libzlib.so
```

Voila!  

#### Answer 3 (score 38)
There does not seem to be any answer which addresses the very common beginner problem of failing to install the required library in the first place.  

On Debianish platforms, if `libfoo` is missing, you can frequently install it with something like  

```sh
apt-get install libfoo-dev
```

The `-dev` version of the package is required for development work, even trivial development work such as compiling source code to link to the library.  

The package name will sometimes require some decorations (`libfoo0-dev`?  `foo-dev` without the `lib` prefix? etc), or you can simply use your distro's <a href="https://packages.debian.org/search?searchon=contents&amp;keywords=libfoo.so&amp;mode=exactfilename&amp;suite=stable&amp;arch=any" rel="noreferrer">package search</a> to find out precisely which packages provide a particular file.  

(If there is more than one, you will need to find out what their differences are. Picking the coolest or the most popular is a common shortcut, but not an acceptable procedure for any serious development work.)  

For other architectures (most notably RPM) similar procedures apply, though the details will be different.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: How to run a shell script on a Unix console or Mac terminal? (score [838291](https://stackoverflow.com/q/733824) in 2017)

#### Question
I know it, forget it and relearn it again. Time to write it down.  

#### Answer accepted (score 918)
To run a non-executable `sh` script, use:  

```sh
sh myscript
```

To run a non-executable `bash` script, use:  

```sh
bash myscript
```

To start an executable (which is any file with executable permission); you just specify it by its path:  

```sh
/foo/bar
/bin/bar
./bar
```

To make a script executable, give it the necessary permission:  

```sh
chmod +x bar
./bar
```

When a file is executable, the <strong>kernel</strong> is responsible for figuring out how to execte it.  For non-binaries, this is done by looking at the first line of the file.  It should contain a `hashbang`:  

```sh
#! /usr/bin/env bash
```

The hashbang tells the kernel what program to run (in this case the command `/usr/bin/env` is ran with the argument `bash`).  Then, the script is passed to the program (as second argument) along with all the arguments you gave the script as subsequent arguments.  

That means <strong>every script that is executable should have a hashbang</strong>.  If it doesn't, you're not telling the kernel what it <em>is</em>, and therefore the kernel doesn't know what program to use to interprete it.  It could be `bash`, `perl`, `python`, `sh`, or something else.  (In reality, the kernel will often use the user's default shell to interprete the file, which is very dangerous because it might not be the right interpreter at all or it might be able to parse some of it but with subtle behavioural differences such as is the case between `sh` and `bash`).  

<h5>A note on `/usr/bin/env`</h1>

Most commonly, you'll see hash bangs like so:  

```sh
#!/bin/bash
```

The result is that the kernel will run the program `/bin/bash` to interpret the script.  Unfortunately, `bash` is not always shipped by default, and it is not always available in `/bin`.  While on Linux machines it usually is, there are a range of other POSIX machines where `bash` ships in various locations, such as `/usr/xpg/bin/bash` or `/usr/local/bin/bash`.  

To write a portable bash script, we can therefore not rely on hard-coding the location of the `bash` program.  POSIX already has a mechanism for dealing with that: `PATH`.  The idea is that you install your programs in one of the directories that are in `PATH` and the system should be able to find your program when you want to run it by name.  

Sadly, you <strong><em>cannot</em></strong> just do this:  

```sh
#!bash
```

The kernel won't (some might) do a `PATH` search for you.  There is a program that can do a `PATH` search for you, though, it's called `env`.  Luckily, nearly all systems have an `env` program installed in `/usr/bin`.  So we start `env` using a hardcoded path, which then does a `PATH` search for `bash` and runs it so that it can interpret your script:  

```sh
#!/usr/bin/env bash
```

This approach has one downside: According to POSIX, the hashbang can have <strong>one argument</strong>.  In this case, we use `bash` as the argument to the `env` program.  That means we have no space left to pass arguments to `bash`.  So there's no way to convert something like `#!/bin/bash -exu` to this scheme.  You'll have to put `set -exu` after the hashbang instead.  

This approach also has another advantage: Some systems may ship with a `/bin/bash`, but the user may not like it, may find it's buggy or outdated, and may have installed his own `bash` somewhere else.  This is often the case on OS X (Macs) where Apple ships an outdated `/bin/bash` and users install an up-to-date `/usr/local/bin/bash` using something like Homebrew.  When you use the `env` approach which does a `PATH` search, you take the user's preference into account and use his preferred bash over the one his system shipped with.  

#### Answer 2 (score 80)
To start the shell-script 'file.sh':  

```sh
sh file.sh

bash file.sh
```

Another option is set executable permission using chmod command:  

```sh
chmod +x file.sh
```

Now run .sh file as follows:  

```sh
./file.sh
```

#### Answer 3 (score 15)
For the bourne shell:  

```sh
sh myscript.sh
```

For bash:  

```sh
bash myscript.sh
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: How to get full path of a file? (score [837153](https://stackoverflow.com/q/5265702) in 2014)

#### Question
Is there an easy way I can print the full path of `file.txt` ?  

```sh
file.txt = /nfs/an/disks/jj/home/dir/file.txt
```

The `&lt;command&gt;`   

```sh
dir> <command> file.txt  
```

should print  

```sh
/nfs/an/disks/jj/home/dir/file.txt
```

#### Answer accepted (score 1073)
Use <a href="http://man7.org/linux/man-pages/man1/readlink.1.html" rel="noreferrer"><strong>readlink</strong></a>:  

```sh
readlink -f file.txt
```

#### Answer 2 (score 183)
I suppose you are using Linux.  

I found a utility called `realpath` in coreutils 8.15.  

```sh
realpath file.txt
/data/ail_data/transformed_binaries/coreutils/test_folder_realpath/file.txt
```

As per @styrofoam-fly and @arch-standton comments, `realpath` alone doesn't check for file existence, to solve this add the `e` argument: `realpath -e file`  

#### Answer 3 (score 75)
The following usually does the trick:  

```sh
 echo $(cd $(dirname "$1") && pwd -P)/$(basename "$1")
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: performing HTTP requests with cURL (using PROXY) (score [833120](https://stackoverflow.com/q/9445489) in 2017)

#### Question
I have this proxy address: `125.119.175.48:8909`  

How can I perform a HTTP request using cURL like `curl http://www.example.com`, but specifying the proxy address of my network?   

#### Answer accepted (score 393)
General way:  

```sh
export http_proxy=http://your.proxy.server:port/
```

Then you can connect through proxy from (many) application.  

And, as per comment below, for https:  

```sh
export https_proxy=https://your.proxy.server:port/
```

#### Answer 2 (score 605)
From `man curl`:  

```sh
-x, --proxy <[protocol://][user:password@]proxyhost[:port]>

     Use the specified HTTP proxy. 
     If the port number is not specified, it is assumed at port 1080.
```

#### Answer 3 (score 114)
The above solutions might not work with some curl versions I tried them for myself(curl 7.22.0). But what worked for me was:  

```sh
curl -x http://proxy_server:proxy_port --proxy-user username:password -L http://url
```

Hope it solves the issue better!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: Shell command to tar directory excluding certain files/folders (score [811337](https://stackoverflow.com/q/984204) in 2019)

#### Question
Is there a simple shell command/script that supports excluding certain files/folders from being archived?  

I have a directory that need to be archived with a sub directory that has a number of very large files I do not need to backup.  

<strong>Not quite solutions:</strong>  

The `tar --exclude=PATTERN` command matches the given pattern and excludes those files, but I need specific files &amp; folders to be ignored (full file path), otherwise valid files might be excluded.  

I could also use the find command to create a list of files and exclude the ones I don't want to archive and pass the list to tar, but that only works with for a small amount of files. I have tens of thousands.  

I'm beginning to think the only solution is to create a file with a list of files/folders to be excluded, then use rsync with `--exclude-from=file` to copy all the files to a tmp directory, and then use tar to archive that directory.  

Can anybody think of a better/more efficient solution?  

EDIT: <strong>Charles Ma</strong>'s solution works well. The big gotcha is that the `--exclude='./folder'` <strong>MUST</strong> be at the beginning of the tar command. Full command (cd first, so backup is relative to that directory):  

```sh
cd /folder_to_backup
tar --exclude='./folder' --exclude='./upload/folder2' -zcvf /backup/filename.tgz .
```

#### Answer accepted (score 953)
You can have multiple exclude options for tar so  

```sh
$ tar --exclude='./folder' --exclude='./upload/folder2' -zcvf /backup/filename.tgz .
```

etc will work. Make <strong>sure</strong> to put `--exclude` <strong>before</strong> the source and destination items.   

#### Answer 2 (score 129)
You can exclude directories with `--exclude` for tar.  

If you want to archive everything except `/usr` you can use:  

```sh
tar -zcvf /all.tgz / --exclude=/usr
```

In your case perhaps something like  

```sh
tar -zcvf archive.tgz arc_dir --exclude=dir/ignore_this_dir
```

#### Answer 3 (score 60)
Possible options to exclude files/directories from backup using tar:  

Exclude files using multiple patterns  

```sh
tar -czf backup.tar.gz --exclude=PATTERN1 --exclude=PATTERN2 ... /path/to/backup
```

Exclude files using an exclude file filled with a list of patterns  

```sh
tar -czf backup.tar.gz -X /path/to/exclude.txt /path/to/backup
```

Exclude files using tags by placing a tag file in any directory that should be skipped  

```sh
tar -czf backup.tar.gz --exclude-tag-all=exclude.tag /path/to/backup
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: How do I delete an exported environment variable? (score [805227](https://stackoverflow.com/q/6877727) in 2017)

#### Question
Before installing gnuplot, I set the environment variable `GNUPLOT_DRIVER_DIR = /home/gnuplot/build/src`. During the installation, something went wrong.  

I want to remove the `GNUPLOT_DRIVER_DIR` environment variable. How can I achieve it?  

#### Answer accepted (score 2247)
`unset` is the command you're looking for.  

```sh
unset GNUPLOT_DRIVER_DIR
```

#### Answer 2 (score 160)
<h5><strong>Walkthrough of creating and deleting an environment variable in bash:</strong></h2>

<strong>Test if the DUALCASE variable exists:</strong>  

```sh
el@apollo:~$ env | grep DUALCASE
el@apollo:~$ 
```

<strong>It does not, so create the variable and export it:</strong>  

```sh
el@apollo:~$ DUALCASE=1
el@apollo:~$ export DUALCASE
```

<strong>Check if it is there:</strong>  

```sh
el@apollo:~$ env | grep DUALCASE
DUALCASE=1
```

<strong>It is there.  So get rid of it:</strong>  

```sh
el@apollo:~$ unset DUALCASE
```

<strong>Check if it's still there:</strong>  

```sh
el@apollo:~$ env | grep DUALCASE
el@apollo:~$ 
```

The DUALCASE exported environment variable is deleted.  

<h5>Extra commands to help clear your local and environment variables:</h2>

<strong>Unset all local variables back to default on login:</strong>  

```sh
el@apollo:~$ CAN="chuck norris"
el@apollo:~$ set | grep CAN
CAN='chuck norris'
el@apollo:~$ env | grep CAN
el@apollo:~$
el@apollo:~$ exec bash
el@apollo:~$ set | grep CAN
el@apollo:~$ env | grep CAN
el@apollo:~$
```

`exec bash` command cleared all the local variables but not environment variables.  

<strong>Unset all environment variables back to default on login:</strong>  

```sh
el@apollo:~$ export DOGE="so wow"
el@apollo:~$ env | grep DOGE
DOGE=so wow
el@apollo:~$ env -i bash
el@apollo:~$ env | grep DOGE
el@apollo:~$
```

`env -i bash` command cleared all the environment variables to default on login.  

#### Answer 3 (score 5)
<p>Because the original question doesn't mention how the variable was set, 
and because I got to this page looking for this specific answer, I'm adding the following:</p>

<strong>In C shell (csh/tcsh)</strong> there are two ways to set an environment variable:  

<ol>
<li>`set x = "something"`</li>
<li>`setenv x "something"`</li>
</ol>

The difference in the behaviour is that variables set with <strong><em>setenv</em></strong> command are automatically exported to subshell while variable set with <strong><em>set</em></strong> aren't.  

To unset a variable set with <strong><em>set</em></strong>, use  

```sh
unset x
```

To unset a variable set with <strong><em>setenv</em></strong>, use  

```sh
unsetenv x
```

<em>Note:</em> in all the above, I assume that the variable name is 'x'.  

credits:  

<p><a href="https://www.cyberciti.biz/faq/unix-linux-difference-between-set-and-setenv-c-shell-variable/" rel="nofollow noreferrer">https://www.cyberciti.biz/faq/unix-linux-difference-between-set-and-setenv-c-shell-variable/</a>
<a href="https://www.oreilly.com/library/view/solaristm-7-reference/0130200484/0130200484_ch18lev1sec24.html" rel="nofollow noreferrer">https://www.oreilly.com/library/view/solaristm-7-reference/0130200484/0130200484_ch18lev1sec24.html</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: How does "cat << EOF" work in bash? (score [797520](https://stackoverflow.com/q/2500436) in 2017)

#### Question
I needed to write a script to enter multi-line input to a program (`psql`).  

After a bit of googling, I found the following syntax works:  

```sh
cat << EOF | psql ---params
BEGIN;

`pg_dump ----something`

update table .... statement ...;

END;
EOF
```

This correctly constructs the multi-line string (from `BEGIN;` to `END;`, inclusive) and pipes it as an input to `psql`.  

But I have no idea how/why it works, can some one please explain?  

I'm referring mainly to `cat &lt;&lt; EOF`, I know `&gt;` outputs to a file, `&gt;&gt;` appends to a file, `&lt;` reads input from file.   

What does `&lt;&lt;` exactly do?  

And is there a man page for it?  

#### Answer accepted (score 466)
This is called <strong><em>heredoc</strong> format</em> to provide a string into stdin. See <a href="https://en.wikipedia.org/wiki/Here_document#Unix_shells" rel="noreferrer">https://en.wikipedia.org/wiki/Here_document#Unix_shells</a> for more details.  

<hr>

From `man bash`:  

<blockquote>
  <h5>Here Documents</h2>
  
  <p>This type of redirection instructs the shell to read input from
  the current source until a line
  containing only word (with no trailing
  blanks)  is  seen.</p>
  
  <p>All of the lines read up to that point are then used as the
  standard input for a command.</p>
  
  The format of here-documents is:  

```sh
          <<[-]word
                  here-document
          delimiter
```
  
  <p>No parameter expansion, command substitution, arithmetic expansion, or
  pathname expansion is performed on
  <strong>word</strong>.  If any characters in <strong>word</strong> are
  quoted, the
  <strong>delimiter</strong> is the result of quote removal on <strong>word</strong>, and the lines
  in the <strong>here-document</strong> are not expanded.
  If <strong>word</strong> is unquoted, all lines of  the
  <strong>here-document</strong>  are  subjected  to  parameter  expansion,  command
  substitution, and arithmetic
  expansion.  In the latter case, the
  character sequence `\&lt;newline&gt;` is
  ignored, and `\` must be used to quote the characters `\`, `$`, and ```.</p>
  
  <p>If the redirection operator is `&lt;&lt;-`, then all leading tab characters
  are stripped from input lines and the
  line containing <strong>delimiter</strong>.   This 
  allows  here-documents within shell scripts to be indented in a natural fashion.</p>
</blockquote>

#### Answer 2 (score 441)
The `cat &lt;&lt;EOF` syntax is very useful when working with multi-line text in Bash, eg. when assigning multi-line string to a shell variable, file or a pipe.  

<h5>Examples of `cat &lt;&lt;EOF` syntax usage in Bash:</h1>

<h5>1. Assign multi-line string to a shell variable</h2>



```sh
$ sql=$(cat <<EOF
SELECT foo, bar FROM db
WHERE foo='baz'
EOF
)
```

<em>The `$sql` variable now holds the new-line characters too. You can verify with `echo -e "$sql"`.</em>  

<h5>2. Pass multi-line string to a file in Bash</h2>

```sh
$ cat <<EOF > print.sh
#!/bin/bash
echo \$PWD
echo $PWD
EOF
```

<em>The `print.sh` file now contains:</em>  

```sh
#!/bin/bash
echo $PWD
echo /home/user
```

<h5>3. Pass multi-line string to a pipe in Bash</h2>

```sh
$ cat <<EOF | grep 'b' | tee b.txt
foo
bar
baz
EOF
```

<em>The `b.txt` file contains `bar` and `baz` lines. The same output is printed to `stdout`.</em>  

#### Answer 3 (score 215)
In your case, "EOF" is known as a "Here Tag". Basically `&lt;&lt;Here` tells the shell that you are going to enter a multiline string until the "tag" `Here`. You can name this tag as you want, it's often `EOF` or `STOP`.  

Some rules about the Here tags:  

<ol>
<li>The tag can be any string, uppercase or lowercase, though most people use uppercase by convention.</li>
<li>The tag will not be considered as a Here tag if there are other words in that line. In this case, it will merely be considered part of the string. The tag should be by itself on a separate line, to be considered a tag.</li>
<li>The tag should have no leading or trailing spaces in that line to be considered a tag. Otherwise it will be considered as part of the string.</li>
</ol>

example:   

```sh
$ cat >> test <<HERE
> Hello world HERE <-- Not by itself on a separate line -> not considered end of string
> This is a test
>  HERE <-- Leading space, so not considered end of string
> and a new line
> HERE <-- Now we have the end of the string
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: Dude, where's my php.ini? (score [754046](https://stackoverflow.com/q/8684609) in 2019)

#### Question
A few years ago I installed Apache 2.2x and PHP 5.3.1 on a Linux server I maintain.  I used .tar.gz's and built them as instructed (instead of rpms and what-have-you). And all was fine.  

Today I need to install <a href="http://us2.php.net/ibm_db2" rel="noreferrer">this</a> which seems like a PHP library.  I went through all the steps up to make install, and I find ibm_db2.so in `$PHP_HOME/lib/extensions/somecomplicatedname/ibm_db2.so`  

The great catch is the last step is to configure php.ini but there is NO php.ini on my system. Horror of horrors. PHP works fine, except of course for this new-fangled ibm_db2 thingamagic that I want to use so somebody can use a GUI to tinker with `DB2`. (I tried a small php script which fails and indicates that the ibm_db2 functions are not available).  

I have to deal with PHP once every few years, so please enlighten me at a very basic level about what I could do to enable web-based GUI access to `DB2`.  

#### Answer accepted (score 439)
<p>Best way to find this is:
create a php file and add the following code:</p>

```sh
<?php phpinfo(); ?>
```

and open it in browser, it will show the file which is actually being read!  

Updates by OP:  

<ol>
<li>The previously accepted <a href="https://stackoverflow.com/questions/8684609/dude-wheres-my-php-ini/8684638#8684638">answer</a> is likely to be faster and more convenient for you, but it is not always correct. See comments on that answer.</li>
<li>Please also note the more convenient alternative `&lt;?php echo php_ini_loaded_file(); ?&gt;` mentioned in <a href="https://stackoverflow.com/questions/8684609/dude-wheres-my-php-ini/24342463#24342463">this answer</a>.</li>
</ol>

#### Answer 2 (score 795)
On the command line execute:  

```sh
php --ini
```

You will get something like:  

```sh
Configuration File (php.ini) Path: /etc/php5/cli
Loaded Configuration File:         /etc/php5/cli/php.ini
Scan for additional .ini files in: /etc/php5/cli/conf.d
Additional .ini files parsed:      /etc/php5/cli/conf.d/curl.ini,
/etc/php5/cli/conf.d/pdo.ini,
/etc/php5/cli/conf.d/pdo_sqlite.ini,
/etc/php5/cli/conf.d/sqlite.ini,
/etc/php5/cli/conf.d/sqlite3.ini,
/etc/php5/cli/conf.d/xdebug.ini,
/etc/php5/cli/conf.d/xsl.ini
```

That's from my local dev-machine. However, the second line is the interesting one. If there is nothing mentioned, have a look at the first one. That is the path, where PHP looks for the `php.ini`.  

You can grep the same information using `phpinfo()` in a script and call it with a browser. Its mentioned in the first block of the output. `php -i` does the same for the command line, but its quite uncomfortable.  

#### Answer 3 (score 124)
This works for me:  

```sh
php -i | grep 'php.ini'
```

You should see something like:  

```sh
Loaded Configuration File => /usr/local/lib/php.ini
```

<p>p.s.
To get only the php.inin path</p>

```sh
php -i | grep /.+/php.ini -oE
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How do I find the MySQL my.cnf location (score [752753](https://stackoverflow.com/q/2482234) in 2018)

#### Question
Is there a MySQL command to locate the `my.cnf` configuration file, similar to how PHP's `phpinfo()`  locates its `php.ini`?  

#### Answer accepted (score 512)
There is no internal MySQL command to trace this, it's a little too abstract.  The file might be in 5 (or more?) locations, and they would all be valid because they load cascading.  

<ul>
<li>/etc/my.cnf</li>
<li>/etc/mysql/my.cnf</li>
<li>$MYSQL_HOME/my.cnf</li>
<li>[datadir]/my.cnf</li>
<li>~/.my.cnf</li>
</ul>

Those are the default locations MySQL looks at.  If it finds more than one, it will load each of them &amp; values override each other (in the listed order, I think).  Also, the `--defaults-file` parameter can override the whole thing, so... basically, it's a huge pain in the butt.  

But thanks to it being so confusing, there's a good chance it's just in /etc/my.cnf.  

(if you just want to see the values: <a href="http://dev.mysql.com/doc/refman/5.0/en/show-variables.html" rel="noreferrer">`SHOW VARIABLES`</a>, but you'll need the permissions to do so.)  

#### Answer 2 (score 179)
You can actually "request" MySQL for a list of all locations where it searches for my.cnf (or my.ini on Windows). It is not an SQL query though. Rather, execute:  

```sh
$ mysqladmin --help
```

or, prior 5.7:  

```sh
$ mysqld --help --verbose
```

In the very first lines you will find a message with a list of all my.cnf locations it looks for. On my machine it is:  

```sh
Default options are read from the following files in the given order:
/etc/my.cnf
/etc/mysql/my.cnf
/usr/etc/my.cnf
~/.my.cnf
```

Or, on Windows:  

```sh
Default options are read from the following files in the given order:
C:\Windows\my.ini
C:\Windows\my.cnf
C:\my.ini
C:\my.cnf
C:\Program Files\MySQL\MySQL Server 5.5\my.ini
C:\Program Files\MySQL\MySQL Server 5.5\my.cnf
```

Note however, that <strong>it might be the case that there is no my.cnf file at any of these locations</strong>. So, you can create the file on your own - use one of the sample config files provided with MySQL distribution (on Linux - see `/usr/share/mysql/*.cnf` files and use whichever is appropriate for you - copy it to `/etc/my.cnf` and then modify as needed).  

Also, note that <strong>there is also a command line option `--defaults-file`</strong> which may define custom path to my.cnf or my.ini file. For example, this is the case for MySQL 5.5 on Windows - it points to a my.ini file in the data directory, which is not normally listed with `mysqld --help --verbose`. On Windows - see service properties to find out if this is the case for you.  

Finally, check the <a href="https://dev.mysql.com/doc/refman/8.0/en/option-files.html" rel="noreferrer">https://dev.mysql.com/doc/refman/8.0/en/option-files.html</a> - it is described there in more details.  

#### Answer 3 (score 57)
You could always run find in a terminal.  

```sh
find / -name my.cnf
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: open() in Python does not create a file if it doesn't exist (score [749514](https://stackoverflow.com/q/2967194) in 2016)

#### Question
What is the best way to open a file as read/write if it exists, or if it does not, then create it and open it as read/write? From what I read, `file = open('myfile.dat', 'rw')` should do this, right?  

It is not working for me (Python 2.6.2) and I'm wondering if it is a version problem, or not supposed to work like that or what.  

The bottom line is, I just need a solution for the problem. I am curious about the other stuff, but all I need is a nice way to do the opening part.  

UPDATE: the enclosing directory was writeable by user and group, not other (I'm on a Linux system... so permissions 775 in other words), and the exact error was:  

<blockquote>
  IOError: no such file or directory.  
</blockquote>

#### Answer accepted (score 733)
You should use `open` with the `w+` mode:  

```sh
file = open('myfile.dat', 'w+')
```

#### Answer 2 (score 119)
The advantage of the following approach is that the file is <strong>properly closed</strong> at the block's end, even if an exception is raised on the way. It's equivalent to `try-finally`, but much shorter.  

```sh
with open("file.dat","a+") as f:
    f.write(...)
    ...
```

<blockquote>
  <p><strong>a+</strong> Opens a file for both appending and reading. The file pointer is
  at the end of the file if the file exists. The file opens in the
  append mode. If the file does not exist, it creates a new file for
  reading and writing. -<a href="http://www.tutorialspoint.com/python/python_files_io.htm" rel="noreferrer">Python file modes</a></p>
</blockquote>

<a href="http://www.tutorialspoint.com/python/file_seek.htm" rel="noreferrer">seek() method</a> sets the file's current position.  

```sh
f.seek(pos [, (0|1|2)])
pos .. position of the r/w pointer
[] .. optionally
() .. one of ->
  0 .. absolute position
  1 .. relative position to current
  2 .. relative position from end
```

<blockquote>
  Only "rwab+" characters are allowed; there must be exactly one of "rwa" - see Stack&nbsp;Overflow question <em><a href="https://stackoverflow.com/a/656289/985454">Python file modes detail</a></em>.  
</blockquote>

#### Answer 3 (score 30)
Good practice is to use the following:  

```sh
import os

writepath = 'some/path/to/file.txt'

mode = 'a' if os.path.exists(writepath) else 'w'
with open(writepath, mode) as f:
    f.write('Hello, world!\n')
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: How to set the environmental variable LD_LIBRARY_PATH in linux (score [746566](https://stackoverflow.com/q/13428910) in 2015)

#### Question
I have first executed the command: `export LD_LIBRARY_PATH=/usr/local/lib`  

<p>Then I have opened `.bash_profile` file: `vi ~/.bash_profile`.
In this file, I put:</p>

```sh
LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH
```

Then if the terminal is closed and restarted, typing `echo $LD_LIBRARY_PATH` displays no result.  

How to set the path permanently?  

#### Answer 2 (score 180)
You should add more details about your distribution, for example under Ubuntu the right way to do this is to add a custom `.conf` file to `/etc/ld.so.conf.d`, for example  

```sh
sudo gedit /etc/ld.so.conf.d/randomLibs.conf
```

inside the file you are supposed to write the complete path to the directory that contains all the libraries that you wish to add to the system, for example  

```sh
/home/linux/myLocalLibs
```

remember to add only the path to the dir, not the full path for the file, all the libs inside that path will be automatically indexed.  

Save and run `sudo ldconfig` to update the system with this libs.  

#### Answer 3 (score 75)
Keep the previous path, don't overwrite it:  

```sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/your/custom/path/
```

You can add it to your ~/.bashrc:  

```sh
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/your/custom/path/' >> ~/.bashrc
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: How to run Node.js as a background process and never die? (score [716866](https://stackoverflow.com/q/4797050) in 2018)

#### Question
I connect to the linux server via putty SSH. I tried to run it as a background process like this:  

```sh
$ node server.js &
```

However, after 2.5 hrs the terminal becomes inactive and the process dies.  Is there anyway I can keep the process alive even with the terminal disconnected?  

<hr>

<strong>Edit 1</strong>  

Actually, I tried `nohup`, but as soon as I close the Putty SSH terminal or unplug my internet, the server process stops right away.   

Is there anything I have to do in Putty?  

<hr>

<strong>Edit 2 (on Feb, 2012)</strong>  

There is a `node.js` module, <a href="https://github.com/nodejitsu/forever" rel="noreferrer">forever</a>. It will run node.js server as daemon service.   

#### Answer accepted (score 506)
<strong>Simple solution</strong> (if you are not interested in coming back to the process, just want it to keep running):   

```sh
nohup node server.js &
```

<strong>Powerful solution</strong> (allows you to reconnect to the process if it is interactive):   

```sh
screen
```

You can then detach by pressing Ctrl+a+d and then attach back by running `screen -r`  

Also consider the newer alternative to screen, tmux.  

#### Answer 2 (score 1104)
`nohup node server.js &gt; /dev/null 2&gt;&amp;1 &amp;`  

<ol>
<li>`nohup` means: <em>Do not terminate this process even when the stty is cut
off.</em></li>
<li>`&gt; /dev/null` means: <em>stdout goes to /dev/null (which is a dummy
device that does not record any output).</em> </li>
<li>`2&gt;&amp;1` means: <em>stderr also goes to the stdout (which is already redirected to `/dev/null`). You may replace &amp;1 with a file path to keep a log of errors, e.g.: `2&gt;/tmp/myLog`</em></li>
<li>`&amp;` at the end means: <em>run this command as a background task.</em></li>
</ol>

#### Answer 3 (score 137)
You really should try to use `screen`. It is a bit more complicated than just doing `nohup long_running &amp;`, but understanding screen once you never come back again.   

Start your screen session at first:  

```sh
user@host:~$ screen
```

Run anything you want:  

```sh
wget http://mirror.yandex.ru/centos/4.6/isos/i386/CentOS-4.6-i386-binDVD.iso
```

Press ctrl+A and then d. Done. Your session keeps going on in background.  

You can list all sessions by `screen -ls`, and attach to some by `screen -r 20673.pts-0.srv` command, where 0673.pts-0.srv is an entry list.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: How can I see the size of files and directories in linux? (score [707520](https://stackoverflow.com/q/11720079) in 2019)

#### Question
How can I see the size of files and directories in Linux? If use `df -m`, then it shows the size of all the directory at the top level, but, for the directories and files inside the directory, how do I check the size?  

#### Answer accepted (score 409)
It's simple. Use `ls` command for files and `du` command for directories.  

<strong>Checking File Sizes</strong>  

```sh
ls -l filename /* Size of the file*/
ls -l *        /* Size of All the files in the current directory */
ls -al *       /* Size of All the files including hidden files in the current directory */
ls -al dir/    /* Size of All the files including hidden files in the 'dir' directory */
```

`ls` command will not list the actual size of directories(<a href="https://unix.stackexchange.com/questions/55/what-does-size-of-a-directory-mean-in-output-of-ls-l-command">why?</a>). Therefore, we use `du` for this purpose.  

<strong>Checking Directory sizes</strong>  

```sh
du -sh directory_name    /* Gives you the summarized(-s) size of the directory in human readable(-h) format*/
du -bsh *                /* Gives you the apparent(-b) summarized(-s) size of all the files and directories in the current directory in human readable(-h) format*/
```

Including `-h` option in any of the above commands (for Ex: `ls -lh *` or `du -sh`) will give you size in human readable format (`kb`, `mb`,`gb`, ...)  

For more information see `man ls` and `man du`  

#### Answer 2 (score 128)
There is `du` command.   

Size of a directory and/or file:  

```sh
$ du -sh .bashrc /tmp
```

<hr>

`--apparent-size` command line switch makes it measure apparent sizes (what `ls` shows) rather than actual disk usage.  

#### Answer 3 (score 64)
Use `ls -s` to list file size, or if you prefer `ls -sh` for human readable sizes.  

For directories use `du`, and again, `du -h` for human readable sizes.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Using ls to list directories and their total sizes (score [698469](https://stackoverflow.com/q/1019116) in 2009)

#### Question
Is it possible to use `ls` in Unix to list the total size of a sub-directory and all its contents as opposed to the usual 4K that (I assume) is just the directory file itself?  I.E.  

```sh
total 12K
drwxrwxr-x  6 *** *** 4.0K 2009-06-19 10:10 branches
drwxrwxr-x 13 *** *** 4.0K 2009-06-19 10:52 tags
drwxrwxr-x 16 *** *** 4.0K 2009-06-19 10:02 trunk
```

After scouring the man pages I'm coming up empty.  

#### Answer accepted (score 1434)
Try something like:  

```sh
du -sh *
```

short version of:  

```sh
du --summarize --human-readable *
```

<h5>Explanation:</h3>

`du`: <strong>D</strong>isk <strong>U</strong>sage  

`-s`: Display a summary for each specified file.  (Equivalent to `-d 0`)  

`-h`: "Human-readable" output.  Use unit suffixes: <strong>B</strong>yte, <strong>K</strong>ibibyte (KiB), <strong>M</strong>ebibyte (MiB), <strong>G</strong>ibibyte (GiB), <strong>T</strong>ebibyte (TiB) and <strong>P</strong>ebibyte (PiB). (BASE2)  

#### Answer 2 (score 302)
`du -sk * | sort -n` will sort the folders by size. Helpful when looking to clear space..  

#### Answer 3 (score 99)
```sh
du -sh * | sort -h
```

This will be displayed in human readable format.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: How can I redirect and append both stdout and stderr to a file with Bash? (score [692374](https://stackoverflow.com/q/876239) in 2015)

#### Question
To redirect <em>stdout</em> to a truncated file in Bash, I know to use:  

```sh
cmd > file.txt
```

To redirect <em>stdout</em> in Bash, appending to a file, I know to use:  

```sh
cmd >> file.txt
```

To redirect both <em>stdout</em> and <em>stderr</em> to a truncated file, I know to use:  

```sh
cmd &> file.txt
```

How do I redirect both <em>stdout</em> and <em>stderr</em> appending to a file? `cmd &amp;&gt;&gt; file.txt` did not work for me.  

#### Answer accepted (score 1853)
```sh
cmd >>file.txt 2>&1
```

Bash executes the redirects from left to right as follows:  

<ol>
<li>`&gt;&gt;file.txt`: Open `file.txt` in append mode and redirect `stdout` there.</li>
<li>`2&gt;&amp;1`: Redirect `stderr` to <em>"where `stdout` is currently going"</em>. In this case, that is a file opened in append mode. In other words, the `&amp;1` reuses the file descriptor which `stdout` currently uses.</li>
</ol>

#### Answer 2 (score 344)
There are two ways to do this, depending on your Bash version.  

The classic and portable (<strong>Bash pre-4</strong>) way is:  

```sh
cmd >> outfile 2>&1
```

A nonportable way, starting with <strong>Bash 4</strong> is  

```sh
cmd &>> outfile
```

(analog to `&amp;&gt; outfile`)  

For good coding style, you should  

<ul>
<li>decide if portability is a concern (then use classic way)</li>
<li>decide if portability even to Bash pre-4 is a concern (then use classic way)</li>
<li>no matter which syntax you use, not change it within the same script (confusion!)</li>
</ul>

If your script already starts with `#!/bin/sh` (no matter if intended or not), then the Bash 4 solution, and in general any Bash-specific code, is not the way to go.  

Also remember that Bash 4 `&amp;&gt;&gt;` is just shorter syntax — it does not introduce any new functionality or anything like that.  

The syntax is (beside other redirection syntax) described here: <a href="http://bash-hackers.org/wiki/doku.php/syntax/redirection#appending_redirected_output_and_error_output" rel="noreferrer">http://bash-hackers.org/wiki/doku.php/syntax/redirection#appending_redirected_output_and_error_output</a>  

#### Answer 3 (score 84)
In Bash you can also explicitly specify your redirects to different files:  

```sh
cmd >log.out 2>log_error.out
```

Appending would be:  

```sh
cmd >>log.out 2>>log_error.out
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: How to set JAVA_HOME in Linux for all users (score [675722](https://stackoverflow.com/q/24641536) in 2014)

#### Question
I am new to Linux system and there seem to be too many Java folders.   

java -version gives me:  

<ul>
<li>java version "1.7.0_55"</li>
<li>OpenJDK Runtime Environment (rhel-2.4.7.1.el6_5-x86_64 u55-b13)</li>
<li>OpenJDK 64-Bit Server VM (build 24.51-b03, mixed mode)</li>
</ul>

When I am trying to build a Maven project , I am getting error:  

```sh
Error: JAVA_HOME is not defined correctly.
We cannot execute /usr/java/jdk1.7.0_05/bin/java
```

Could you please tell me which files I need to modify for root as well as not-root user and where exactly is java located?  

#### Answer accepted (score 289)
<ol>
<li>`find /usr/lib/jvm/java-1.x.x-openjdk`</li>
<li><p>`vim /etc/profile`</p>

Prepend sudo if logged in as not-privileged user, ie. `sudo vim`  </li>
<li>Press 'i' to get in insert mode</li>
<li><p>add:</p>

```sh
export JAVA_HOME="path that you found"

export PATH=$JAVA_HOME/bin:$PATH
```</li>
<li>logout and login again, reboot, or use `source /etc/profile` to apply changes immediately in your current shell</li>
</ol>

#### Answer 2 (score 92)
For all users, I would recommend placing the following line in `/etc/profile`  

```sh
export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
```

This will update dynamically and works well with the <em>alternatives</em> system. Do note though that the update will only take place in a new login shell.  

#### Answer 3 (score 34)
You could use /etc/profile or better a file like /etc/profile.d/jdk_home.sh  

```sh
export JAVA_HOME=/usr/java/jdk1.7.0_05/
```

You have to remember that this file is only loaded with new login shells.. So after bash -l or a new gnome-session and that it doesn't change with new Java versions.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: How do I change the root directory of an apache server? (score [667193](https://stackoverflow.com/q/5891802) in 2016)

#### Question
Does anyone know how to change the document root of the Apache server? I basically want `localhost` to come from `/users/spencer/projects` directory instead of `/var/www`.  

<h5>Edit</h3>

I ended up figuring it out. Some suggested I change the `httpd.conf` file, but I ended up finding a file in `/etc/apache2/sites-available/default` and changed the root directory from `/var/www` to `/home/myusername/projects_folder` and that worked.   

#### Answer accepted (score 202)
You need to change the `DocumentRoot` setting in your `httpd.conf` file.  Chances are it will be under something like `/etc/apache2/conf/httpd.conf`  

Use your favourite editor (I recommend <a href="http://www.vim.org/" rel="noreferrer">Vim</a>) and look for the `DocumentRoot` and change it to `/users/spencer/projects`. Also look a little further down for a setting that looks like this:  

```sh
<Directory "/var/www">
```

You will also want to change what is in the quotes to your new directory. This gives Apache access to read from that directory when a user makes a request that call on it.  

Now restart your apache service (`httpd -k restart`) and you should be good to go.  

<strong>Edit</strong>: Apache2 site config files are now typically kept in `/etc/apache2/sites-available/`  (Debian, Ubuntu, etc.).  

#### Answer 2 (score 254)
<strong>Please note, that this only applies for Ubuntu 14.04 LTS and newer releases.</strong>  

In my Ubuntu 14.04 LTS, the document root was set to `/var/www/html`. It was configured in the following file:   

```sh
/etc/apache2/sites-available/000-default.conf
```

So just do a  

```sh
sudo nano /etc/apache2/sites-available/000-default.conf
```

and change the following line to what you want:  

```sh
DocumentRoot /var/www/html
```

Also do a   

```sh
sudo nano /etc/apache2/apache2.conf
```

and find this   

```sh
<Directory /var/www/html/>
Options Indexes FollowSymLinks
AllowOverride None
Require all granted
</Directory>
```

and change `/var/www/html` to your preferred directory  

and save it.  

After you saved your changes, just restart the apache2 webserver and you'll be done :)  

```sh
sudo service apache2 restart
```

<p><hr>
If you prefer a graphical text editor, you can just replace the `sudo nano` by a `gksu gedit`.</p>

#### Answer 3 (score 42)
I had to edit `/etc/apache2/sites-available/default`. The lines are the same as mentioned by RDL.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: How to fix 'sudo: no tty present and no askpass program specified' error? (score [655921](https://stackoverflow.com/q/21659637) in 2018)

#### Question
I am trying to compile some sources using a makefile. In the makefile there is a bunch of commands that need to be ran as `sudo`.   

When I compile the sources from a terminal all goes fine and the make is paused the first time a `sudo` command is ran waiting for password. Once I type in the password, make resumes and completes.  

But I would like to be able to compile the sources in NetBeans. So, I started a project and showed netbeans where to find the sources, but when I compile the project it gives the error:  

```sh
sudo: no tty present and no askpass program specified
```

The first time it hits a `sudo` command.  

I have looked up the issue on the internet and all the solutions I found point to one thing: disabling the password for this user. Since the user in question here is root. I do not want to do that.  

Is there any other solution?  

#### Answer 2 (score 233)
Granting the user to use that command without prompting for password should resolve the problem. First open a shell console and type:  

```sh
sudo visudo
```

Then edit that file to add to the very end:  

```sh
username ALL = NOPASSWD: /fullpath/to/command, /fullpath/to/othercommand
```

eg  

```sh
john ALL = NOPASSWD: /sbin/poweroff, /sbin/start, /sbin/stop
```

will allow user `john` to sudo `poweroff`, `start` and `stop` without being prompted for password.  

Look at the bottom of the screen for the keystrokes you need to use in visudo - this is not vi by the way - and exit without saving at the first sign of any problem. Health warning: corrupting this file will have serious consequences, edit with care!  

#### Answer 3 (score 170)
Try:  

<ol>
<li><p>Use `NOPASSWD` line for all commands, I mean:</p>

```sh
jenkins ALL=(ALL) NOPASSWD: ALL
```</li>
<li><p>Put the line after all other lines in the `sudoers` file.</p></li>
</ol>

That worked for me (Ubuntu 14.04).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: Merge / convert multiple PDF files into one PDF (score [649302](https://stackoverflow.com/q/2507766) in 2017)

#### Question
How could I merge / convert multiple PDF files into one large PDF file?  

I tried the following, but the content of the target file was not as expected:  

```sh
convert file1.pdf file2.pdf merged.pdf
```

I need a very simple/basic command line (CLI) solution. Best would be if I could pipe the output of the merge / convert straight into `pdf2ps` ( as originally attempted in my previously asked question here: <a href="https://stackoverflow.com/questions/2507596/linux-piping-convert-pdf2ps-lp">Linux piping ( convert -&gt; pdf2ps -&gt; lp)</a> ).  

#### Answer accepted (score 476)
I'm sorry, I managed to find the answer myself using google and a bit of luck : )  

For those interested;  

I installed the pdftk (pdf toolkit) on our debian server, and using the following command I achieved desired output:  

```sh
pdftk file1.pdf file2.pdf cat output output.pdf
```

OR   

```sh
gs -q -sPAPERSIZE=letter -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=output.pdf file1.pdf file2.pdf file3.pdf ...
```

This in turn can be piped directly into pdf2ps.  

#### Answer 2 (score 1277)
Considering that `pdfunite` is part of poppler it has a higher chance to be installed, usage is also simpler than `pdftk`:  

```sh
pdfunite in-1.pdf in-2.pdf in-n.pdf out.pdf
```

#### Answer 3 (score 480)
Try the good ghostscript:  

```sh
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=merged.pdf mine1.pdf mine2.pdf
```

or even this way for an improved version for low resolution PDFs (thanks to Adriano for pointing this out):  

```sh
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=merged.pdf mine1.pdf mine2.pdf
```

In both cases the ouput resolution is much higher and better than this way using convert:  

```sh
convert -density 300x300 -quality 100 mine1.pdf mine2.pdf merged.pdf
```

In this way you wouldn't need to install anything else, just work with what you already have installed in your system (at least both come by default in my rhel).  

Hope this helps,  

<strong>UPDATE:</strong> first of all thanks for all your nice comments!! just a tip that may work for you guys, after googling, I found a superb trick to shrink the size of PDFs, I reduced with it one PDF of 300 MB to just 15 MB with an acceptable resolution! and all of this with the good ghostscript, here it is:  

```sh
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=output.pdf input.pdf
```

cheers!!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: How do I send a file as an email attachment using Linux command line? (score [635793](https://stackoverflow.com/q/17359) in 2016)

#### Question
I've created a script that runs every night on my Linux server that uses `mysqldump` to back up each of my MySQL databases to .sql files and packages them together as a compressed .tar file.  The next step I want to accomplish is to send that tar file through email to a remote email server for safekeeping.  I've been able to send the raw script in the body an email by piping the backup text file to `mailx` like so:  

```sh
$ cat mysqldbbackup.sql | mailx backup@email.com
```

`cat` echoes the backup file's text which is piped into the `mailx` program with the recipient's email address passed as an argument.  

While this accomplishes what I need, I think it could be one step better, <strong>Is there any way, using shell scripts or otherwise, to send the compressed .tar file to an outgoing email message as an <em>attachment</em>?</strong>  This would beat having to deal with very long email messages which contain header data and often have word-wrapping issues etc.  

#### Answer accepted (score 291)
None of the mutt ones worked for me.  It was thinking the email address was part of the attachemnt. Had to do:  

```sh
echo "This is the message body" | mutt -a "/path/to/file.to.attach" -s "subject of message" -- recipient@domain.com
```

#### Answer 2 (score 79)
Or, failing mutt:  

```sh
gzip -c mysqldbbackup.sql | uuencode mysqldbbackup.sql.gz  | mail -s "MySQL DB" backup@email.com
```

#### Answer 3 (score 41)
Depending on your version of linux it may be called mail.  To quote @David above:  

```sh
mail -s "Backup" -a mysqldbbackup.sql backup@email.com < message.txt
```

or also:  

```sh
cat message.txt | mail -s "Backup" -a mysqldbbackup.sql backup@email.com 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: UnicodeDecodeError: 'utf8' codec can't decode byte 0x9c (score [605641](https://stackoverflow.com/q/12468179) in 2019)

#### Question
I have a socket server that is supposed to receive UTF-8 valid characters from clients.  

The problem is some clients (mainly hackers) are sending all the wrong kind of data over it.  

I can easily distinguish the genuine client, but I am logging to files all the data sent so I can analyze it later.  

Sometimes I get characters like this `œ` that cause the `UnicodeDecodeError` error.  

I need to be able to make the string UTF-8 with or without those characters.  

<hr>

<strong>Update:</strong>  

For my particular case the socket service was an MTA and thus I only expect to receive ASCII commands such as:  

```sh
EHLO example.com
MAIL FROM: <john.doe@example.com>
...
```

I was logging all of this in JSON.  

Then some folks out there without good intentions decided to sell all kind of junk.  

That is why for my specific case it is perfectly OK to strip the non ASCII characters.  

#### Answer accepted (score 311)
<a href="http://docs.python.org/howto/unicode.html#the-unicode-type" rel="noreferrer">http://docs.python.org/howto/unicode.html#the-unicode-type</a>  

```sh
str = unicode(str, errors='replace')
```

or  

```sh
str = unicode(str, errors='ignore')
```

<strong>Note:</strong> <em>This will strip out (ignore) the characters in question returning the string without them.</em>  

<em>For me this is ideal case since I'm using it as protection against non-ASCII input which is not allowed by my application.</em>  

<strong>Alternatively:</strong> Use the open method from the <a href="https://docs.python.org/2/library/codecs.html#codecs.open" rel="noreferrer">`codecs`</a> module to read in the file:  

```sh
import codecs
with codecs.open(file_name, 'r', encoding='utf-8',
                 errors='ignore') as fdata:
```

#### Answer 2 (score 60)
Changing the engine from C to Python did the trick for me.  

Engine is C:  

```sh
pd.read_csv(gdp_path, sep='\t', engine='c')
```

<blockquote>
  'utf-8' codec can't decode byte 0x92 in position 18: invalid start byte  
</blockquote>

Engine is Python:  

```sh
pd.read_csv(gdp_path, sep='\t', engine='python')
```

No errors for me.  

#### Answer 3 (score 54)
This type of issue crops up for me now that I've moved to Python 3. I had no idea Python 2 was simply steam rolling any issues with file encoding.   

I found this nice explanation of the differences and how to find a solution after none of the above worked for me.   

<a href="http://python-notes.curiousefficiency.org/en/latest/python3/text_file_processing.html" rel="noreferrer">http://python-notes.curiousefficiency.org/en/latest/python3/text_file_processing.html</a>  

In short, to make Python 3 behave as similarly as possible to Python 2 use:  

```sh
with open(filename, encoding="latin-1") as datafile:
    # work on datafile here
```

However, read the article, there is no one size fits all solution.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: How to pass password to scp? (score [596751](https://stackoverflow.com/q/50096) in 2019)

#### Question
I know it is not recommended, but is it at all possible to pass the user's password to scp?  

I'd like to copy a file via scp as part of a batch job and the receiving server does, of course, need a password and, no, I cannot easily change that to key-based authentication.  

#### Answer accepted (score 27)
You can script it with a tool like <a href="http://expect.sourceforge.net/" rel="noreferrer">expect</a> (there are handy bindings too, like <a href="http://www.noah.org/wiki/Pexpect" rel="noreferrer">Pexpect</a> for Python).    

#### Answer 2 (score 468)
Use <a href="http://sshpass.sourceforge.net/" rel="noreferrer">sshpass</a>:  

```sh
sshpass -p "password" scp -r user@example.com:/some/remote/path /some/local/path
```

or so the password does not show in the bash history  

```sh
sshpass -f "/path/to/passwordfile" scp -r user@example.com:/some/remote/path /some/local/path
```

The above copies contents of path from the remote host to your local.   

<strong>Install :</strong>  

<ul>
<li>ubuntu/debian

<ul>
<li>`apt install sshpass`</li>
</ul></li>
<li>centos/fedora

<ul>
<li>`yum install sshpass`</li>
</ul></li>
<li>mac w/ macports

<ul>
<li>`port install sshpass`</li>
</ul></li>
<li>mac w/ brew

<ul>
<li>`brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master‌​/Library/Formula/ssh‌​pass.rb`</li>
</ul></li>
</ul>

#### Answer 3 (score 42)
just generate a ssh key like:  

```sh
ssh-keygen -t rsa -C "your_email@youremail.com"
```

<p>copy the content of `~/.ssh/id_rsa.pub`
and lastly add it to the remote machines `~/.ssh/authorized_keys`</p>

make sure remote machine have the permissions `0700 for ~./ssh folder` and `0600 for ~/.ssh/authorized_keys`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: How do I test if a variable is a number in Bash? (score [596633](https://stackoverflow.com/q/806906) in 2017)

#### Question
I just can't figure out how do I make sure an argument passed to my script is a number or not.  

All I want to do is something like this:  

```sh
test *isnumber* $1 && VAR=$1 || echo "need a number"
```

Any help?  

#### Answer accepted (score 720)
One approach is to use a regular expression, like so:  

```sh
re='^[0-9]+$'
if ! [[ $yournumber =~ $re ]] ; then
   echo "error: Not a number" >&2; exit 1
fi
```

If the value is not necessarily an integer, consider amending the regex appropriately; for instance:  

```sh
^[0-9]+([.][0-9]+)?$
```

...or, to handle numbers with a sign:  

```sh
^[+-]?[0-9]+([.][0-9]+)?$
```

#### Answer 2 (score 257)
Without bashisms (works even in the System V sh),  

```sh
case $string in
    ''|*[!0-9]*) echo bad ;;
    *) echo good ;;
esac
```

This rejects empty strings and strings containing non-digits, accepting everything else.  

Negative or floating-point numbers need some additional work. An idea is to exclude `-` / `.` in the first "bad" pattern and add more "bad" patterns containing the inappropriate uses of them (`?*-*` / `*.*.*`)  

#### Answer 3 (score 170)
The following solution can also be used in basic shells such as Bourne without the need for regular expressions.  Basically any numeric value evaluation operations using non-numbers will result in an error which will be implicitly considered as false in shell:  

```sh
"$var" -eq "$var"
```

as in:  

```sh
#!/bin/bash

var=a

if [ -n "$var" ] && [ "$var" -eq "$var" ] 2>/dev/null; then
  echo number
else
  echo not a number
fi
```

You can can also test for $? the return code of the operation which is more explicit:  

```sh
[ -n "$var" ] && [ "$var" -eq "$var" ] 2>/dev/null
if [ $? -ne 0 ]; then
   echo $var is not number
fi
```

Redirection of standard error is there to hide the "integer expression expected" message that bash prints out in case we do not have a number.  

<strong>CAVEATS</strong> (thanks to the comments below):  

<ul>
<li>Numbers with decimal points are <em>not</em> identified as valid "numbers"</li>
<li>Using `[[ ]]` instead of `[ ]` will always evaluate to `true`</li>
<li>Most non-Bash shells will always evaluate this expression as `true`</li>
<li>The behavior in Bash is undocumented and may therefore change without warning</li>
<li>If the value includes spaces after the number (e.g. "1 a") produces error, like `bash: [[: 1 a: syntax error in expression (error token is "a")`</li>
<li>If the value is the same as var-name (e.g. i="i"), produces error, like `bash: [[: i: expression recursion level exceeded (error token is "i")`</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Using openssl to get the certificate from a server (score [591147](https://stackoverflow.com/q/7885785) in )

#### Question
I am trying to get the certificate of a remote server, which I can then use to add to my keystore and use within my java application.  

A senior dev (who is on holidays :(  ) informed me I can run this:  

```sh
openssl s_client -connect host.host:9999
```

To get a raw certificate dumped out, which I can then copy and export. I receive the following output:  

```sh
depth=1 /C=NZ/ST=Test State or Province/O=Organization Name/OU=Organizational Unit Name/CN=Test CA
verify error:num=19:self signed certificate in certificate chain
verify return:0
23177:error:14094410:SSL routines:SSL3_READ_BYTES:sslv3 alert handshake failure:s3_pkt.c:1086:SSL alert number 40
23177:error:140790E5:SSL routines:SSL23_WRITE:ssl handshake failure:s23_lib.c:188:
```

I have also tried with this option  

```sh
-showcerts 
```

and this one (running on debian mind you)  

```sh
-CApath /etc/ssl/certs/ 
```

But get the same error.  

<a href="http://gagravarr.org/writing/openssl-certs/personal.shtml" rel="noreferrer">This source</a> says I can use that CApath flag but it doesn't seem to help. I tried multiple paths to no avail.  

Please let me know where I'm going wrong.  

#### Answer accepted (score 38)
It turns out there is more complexity here: I needed to provide many more details to get this rolling. I think its something to do with the fact that its a connection that needs client authentication, and the hankshake needed more info to continue to the stage where the certificates were dumped.  

Here is my working command:  

```sh
openssl s_client -connect host:port -key our_private_key.pem -showcerts \
                 -cert our_server-signed_cert.pem
```

Hopefully this is a nudge in the right direction for anyone who could do with some more info.   

#### Answer 2 (score 409)
<h5>With SNI</h1>

If the remote server is using SNI (that is, sharing multiple SSL hosts on a single IP address) you will need to send the correct hostname in order to get the right certificate.  

```sh
openssl s_client -showcerts -servername www.example.com -connect www.example.com:443 </dev/null
```

<h5>Without SNI</h1>

If the remote server is not using SNI, then you can skip `-servername` parameter:  

```sh
openssl s_client -showcerts -connect www.example.com:443 </dev/null
```

<br/>  

To view the full details of a site's cert you can use this chain of commands as well:  

```sh
$ echo | \
    openssl s_client -servername www.example.com -connect www.example.com:443 2>/dev/null | \
    openssl x509 -text
```

#### Answer 3 (score 66)
While I agree with Ari's answer (and upvoted it :), I needed to do an extra step to get it to work with Java on Windows (where it needed to be deployed):  

```sh
openssl s_client -showcerts -connect www.example.com:443 < /dev/null | openssl x509 -outform DER > derp.der
```

Before adding the `openssl x509 -outform DER` conversion, I was getting an error from keytool on Windows complaining about the certificate's format.  Importing the .der file worked fine.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: Why doesn't "cd" work in a shell script? (score [584778](https://stackoverflow.com/q/255414) in 2018)

#### Question
I'm trying to write a small script to change the current directory to my project directory:  

```sh
#!/bin/bash
cd /home/tree/projects/java
```

<p>I saved this file as proj, added execute permission with `chmod`, and copied it to `/usr/bin`. When I call it by:
`proj`, it does nothing. What am I doing wrong?</p>

#### Answer accepted (score 607)
Shell scripts are run inside a subshell, and each subshell has its own concept of what the current directory is. The `cd` succeeds, but as soon as the subshell exits, you're back in the interactive shell and nothing ever changed there.  

One way to get around this is to use an alias instead:  

```sh
alias proj="cd /home/tree/projects/java"
```

#### Answer 2 (score 475)
You're doing nothing wrong!  You've changed the directory, but only within the subshell that runs the script.  

You can run the script in your current process with the "dot" command:  

```sh
. proj
```

But I'd prefer Greg's suggestion to use an alias in this simple case.  

#### Answer 3 (score 213)
The `cd` in your script technically <em>worked</em> as it changed the directory of the shell that ran the script, but that was a separate process forked from your interactive shell.  

A Posix-compatible way to solve this problem is to define a <em>shell procedure</em> rather than a shell-invoked <em>command script</em>.  

```sh
jhome () {
  cd /home/tree/projects/java
}
```

You can just type this in or put it in one of the various shell startup files.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: ld cannot find an existing library (score [583334](https://stackoverflow.com/q/335928) in 2010)

#### Question
I am attempting to link an application with g++ on this Debian lenny system. ld is complaining it cannot find specified libraries. The specific example here is ImageMagick, but I am having similar problems with a few other libraries too.  

I am calling the linker with:  

```sh
g++ -w (..lots of .o files/include directories/etc..) \
-L/usr/lib -lmagic
```

ld complains:  

```sh
/usr/bin/ld: cannot find -lmagic
```

However, libmagic exists:  

```sh
$ locate libmagic.so
/usr/lib/libmagic.so.1
/usr/lib/libmagic.so.1.0.0
$ ls -all /usr/lib/libmagic.so.1*
lrwxrwxrwx 1 root root    17 2008-12-01 03:52 /usr/lib/libmagic.so.1 -> libmagic.so.1.0.0
-rwxrwxrwx 1 root root 84664 2008-09-09 00:05 /usr/lib/libmagic.so.1.0.0
$ ldd /usr/lib/libmagic.so.1.0.0 
    linux-gate.so.1 =>  (0xb7f85000)
    libz.so.1 => /usr/lib/libz.so.1 (0xb7f51000)
    libc.so.6 => /lib/i686/cmov/libc.so.6 (0xb7df6000)
    /lib/ld-linux.so.2 (0xb7f86000)
$ sudo ldconfig -v | grep "libmagic"
    libmagic.so.1 -> libmagic.so.1.0.0
```

How do I diagnose this problem further, and what could be wrong? Am I doing something completely stupid?  

#### Answer accepted (score 153)
The problem is the linker is looking for `libmagic.so` but you only have `libmagic.so.1`  

A quick hack is to symlink `libmagic.so.1` to `libmagic.so`  

#### Answer 2 (score 66)
As just formulated by grepsedawk, the answer lies in the `-l` option of `g++`, calling `ld`. If you look at the man page of this command, you can either do:  

<ul>
<li>`g++ -l:libmagic.so.1 [...]`</li>
<li>or: `g++ -lmagic [...]` , if you have a symlink named libmagic.so in your libs path</li>
</ul>

#### Answer 3 (score 31)
It is Debian convention to separate shared libraries into their runtime components (`libmagic1: /usr/lib/libmagic.so.1 → libmagic.so.1.0.0`) and their development components (`libmagic-dev: /usr/lib/libmagic.so → …`).  

Because the library's soname is `libmagic.so.1`, that's the string that gets embedded into the executable so that's the file that is loaded when the executable is run.  

However, because the library is specified as `-lmagic` to the linker, it looks for `libmagic.so`, which is why it is needed for development.  

See <a href="http://blog.flameeyes.eu/2010/10/08/linkers-and-names">Diego E. Pettenò: Linkers and names</a> for details on how this all works on Linux.  

<hr>

In short, you should `apt-get install libmagic-dev`.  This will not only give you `libmagic.so` but also other files necessary for compiling like `/usr/include/magic.h`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: Recursively counting files in a Linux directory (score [580138](https://stackoverflow.com/q/9157138) in 2015)

#### Question
How can I recursively count files in a Linux directory?  

I found this:  

```sh
find DIR_NAME -type f ¦ wc -l
```

But when I run this it returns the following error.  

<blockquote>
  find: paths must precede expression: ¦  
</blockquote>

#### Answer accepted (score 1180)
This should work:  

```sh
find DIR_NAME -type f | wc -l
```

<strong>Explanation:</strong>  

<ul>
<li>`-type f` to include only files.</li>
<li>`|` (<strong>and not `¦`</strong>) redirects `find` command's standard output to `wc` command's standard input.</li>
<li>`wc` (short for word count) counts newlines, words and bytes on its input (<a href="http://man7.org/linux/man-pages/man1/wc.1.html" rel="noreferrer">docs</a>).</li>
<li>`-l` to count just newlines.</li>
</ul>

<strong>Notes:</strong>   

<ul>
<li>Replace `DIR_NAME` with `.` to execute the command in the current folder.</li>
<li>You can also remove the `-type f` to include directories (and symlinks) in the count.</li>
<li>It's possible this command will overcount if filenames can contain newline characters.</li>
</ul>

<strong>Explanation of why your example does not work:</strong>  

In the command you showed, you do not use the "Pipe" (`|`) to kind-of connect two commands, but the broken bar (`¦`) which the shell does not recognize as a command or something similar. That's why you get that error message.  

#### Answer 2 (score 87)
For the current directory:  

```sh
find -type f | wc -l
```

#### Answer 3 (score 64)
If you want a breakdown of how many files are in each dir under your current dir:  

```sh
for i in */ .*/ ; do 
    echo -n $i": " ; 
    (find "$i" -type f | wc -l) ; 
done
```

That can go all on one line, of course.  The parenthesis clarify whose output `wc -l` is supposed to be watching (`find $i -type f` in this case).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Why do you need to put #!/bin/bash at the beginning of a script file? (score [573690](https://stackoverflow.com/q/8967902) in 2018)

#### Question
I have made <a href="http://en.wikipedia.org/wiki/Bash_%28Unix_shell%29" rel="noreferrer">Bash</a> scripts before and they all ran fine without this at the beginning. What's the point of putting it in? Would things be any different?  

Also, how do you pronounce `#`? I know that `!` is pronounced as "bang."  

How is `#!` pronounced?  

#### Answer accepted (score 398)
It's a convention so the *nix shell knows what kind of interpreter to run.  

For example, older flavors of ATT defaulted to <em>sh</em> (the Bourne shell), while older versions of BSD defaulted to <em>csh</em> (the C shell).  

Even today (where most systems run bash, the <em>"Bourne Again Shell"</em>), scripts can be in bash, python, perl, ruby, PHP, etc, etc.  For example, you might see `#!/bin/perl` or `#!/bin/perl5`.  

<p>PS:
The exclamation mark (`!`) is affectionately called <em>"bang"</em>.  The shell comment symbol (`#`) is sometimes called <em>"hash"</em>.</p>

<p>PPS:
Remember - under *nix, associating a suffix with a file type is merely a <em>convention</em>, not a <em>"rule"</em>.  An <em>executable</em> can be a binary program, any one of a million script types and other things as well. Hence the need for `#!/bin/bash`.</p>

#### Answer 2 (score 124)
To be more precise the <a href="https://en.wikipedia.org/wiki/Shebang_%28Unix%29" rel="noreferrer">shebang</a> `#!`, when it is the first two bytes of an <em>executable</em> (`x` <a href="https://en.wikipedia.org/wiki/Modes_%28Unix%29" rel="noreferrer">mode</a>) file, is interpreted by the <a href="http://linux.die.net/man/2/execve" rel="noreferrer">execve(2)</a> system call (which execute programs). But <a href="http://pubs.opengroup.org/onlinepubs/009695299/functions/execve.html" rel="noreferrer">POSIX specification for `execve`</a> don't mention the shebang.  

It must be followed by a file path of an interpreter executable (which BTW could even be relative, but most often is absolute).  

A nice trick (or perhaps <a href="https://unix.stackexchange.com/a/29620/50557">not so nice</a> one) to find an interpreter (e.g. `python`) in the user's `$PATH` is to use the `env` program (always at `/usr/bin/env` on all Linux) like e.g.  

```sh
 #!/usr/bin/env python
```

Any ELF executable can be an interpreter. You could even use `#!/bin/cat` or `#!/bin/true` if you wanted to! (but that would be often useless)  

#### Answer 3 (score 47)
It's called a <a href="http://en.wikipedia.org/wiki/Shebang_%28Unix%29">shebang</a>. In unix-speak, # is called sharp (like in music) or hash (like hashtags on twitter), and ! is called bang. (You can actually reference your previous shell command with !!, called bang-bang). So when put together, you get haSH-BANG, or shebang.  

The part after the #! tells Unix what program to use to run it. If it isn't specified, it will try with bash (or sh, or zsh, or whatever your $SHELL variable is) but if it's there it will use that program. Plus, # is a comment in most languages, so the line gets ignored in the subsequent execution.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: How can I use grep to show just filenames on Linux? (score [572766](https://stackoverflow.com/q/6637882) in 2019)

#### Question
How can I use `grep` to show just file-names (no in-line matches) on Linux?  

I am usually using something like:  

```sh
find . -iname "*php" -exec grep -H myString {} \;
```

How can I just get the file-names (with paths), but without the matches? Do I have to use `xargs`? I didn't see a way to do this on my `grep` man page.  

#### Answer accepted (score 1448)
The standard option `grep -l` (that is a lowercase L) could do this.  

From the <a href="http://pubs.opengroup.org/onlinepubs/007908799/xcu/grep.html" rel="noreferrer">Unix standard</a>:  

```sh
-l
    (The letter ell.) Write only the names of files containing selected
    lines to standard output. Pathnames are written once per file searched.
    If the standard input is searched, a pathname of (standard input) will
    be written, in the POSIX locale. In other locales, standard input may be
    replaced by something more appropriate in those locales.
```

You also do not need `-H` in this case.  

#### Answer 2 (score 130)
From the `grep(1)` man page:  

<blockquote>
```sh
  -l, --files-with-matches
          Suppress  normal  output;  instead  print the name of each input
          file from which output would normally have  been  printed.   The
          scanning  will  stop  on  the  first match.  (-l is specified by
          POSIX.)
```
</blockquote>

#### Answer 3 (score 30)
For a simple file search you could use grep's `-l` and `-r` options:  

```sh
grep -rl "mystring"
```

All the search is done by grep. Of course, if you need to select files on some other parameter, find is the correct solution:  

```sh
find . -iname "*.php" -execdir grep -l "mystring" {} +
```

The `execdir` option builds each grep command per each directory, and concatenates filenames into only one command (`+`).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: How to obtain the number of CPUs/cores in Linux from the command line? (score [571310](https://stackoverflow.com/q/6481005) in 2015)

#### Question
I have this script, but I do not know how to get the last element in the printout:  

```sh
cat /proc/cpuinfo | awk '/^processor/{print $3}'
```

The last element should be the number of CPUs, minus 1.  

#### Answer accepted (score 595)
```sh
cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l
```

or simply  

```sh
grep -c ^processor /proc/cpuinfo     
```

which will count the number of lines starting with "processor" in `/proc/cpuinfo`  

For systems with hyper-threading, you can use  

```sh
grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}' 
```

which should return (for example) `8` (whereas the command above would return `16`)  

#### Answer 2 (score 596)
Processing the contents of `/proc/cpuinfo` is needlessly baroque. Use <a href="http://www.gnu.org/software/coreutils/manual/html_node/nproc-invocation.html" rel="noreferrer"><strong>nproc</strong></a> which is part of coreutils, so it should be available on most Linux installs.  

Command `nproc` prints the number of processing units available to the current process, which may be less than the number of online processors.  

To find the number of all installed cores/processors use `nproc --all`  

On my 8-core machine:  

```sh
$ nproc --all
8
```

#### Answer 3 (score 243)
The most portable solution I have found is the `getconf` command:  

```sh
getconf _NPROCESSORS_ONLN
```

This works on both Linux and Mac OS X. Another benefit of this over some of the other approaches is that getconf has been around for a long time. Some of the older Linux machines I have to do development on don't have the `nproc` or `lscpu` commands available, but they have `getconf`.  

<p><sup>Editor's note: While <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/getconf.html" rel="noreferrer">the `getconf` <em>utility</em> is POSIX-mandated</a>, the specific `_NPROCESSORS_ONLN` and `_NPROCESSORS_CONF` <em>values</em> are not. 
That said, as stated, they work on Linux platforms as well as on macOS; on FreeBSD/PC-BSD, you must omit the leading `_`.</sup></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: How to redirect output to a file and stdout (score [560328](https://stackoverflow.com/q/418896) in 2014)

#### Question
In bash, calling `foo` would display any output from that command on the stdout.  

Calling `foo &gt; output` would redirect any output from that command to the file specified (in this case 'output').  

Is there a way to redirect output to a file <em>and</em> have it display on stdout?  

#### Answer accepted (score 1200)
The command you want is named <strong><a href="http://www.gnu.org/software/coreutils/manual/html_node/tee-invocation.html" rel="noreferrer">`tee`</a></strong>:  

```sh
foo | tee output.file
```

For example, if you only care about stdout:  

```sh
ls -a | tee output.file
```

If you want to include stderr, do:  

```sh
program [arguments...] 2>&1 | tee outfile
```

`2&gt;&amp;1` redirects channel 2 (stderr/standard error) into channel 1 (stdout/standard output), such that both is written as stdout. It is also directed to the given output file as of the `tee` command.  

Furthermore, if you want to <em>append</em> to the log file, use `tee -a` as:  

```sh
program [arguments...] 2>&1 | tee -a outfile
```

#### Answer 2 (score 481)
```sh
$ program [arguments...] 2>&1 | tee outfile
```

<p>`2&gt;&amp;1` dumps the stderr and stdout streams.
`tee outfile` takes the stream it gets and writes it to the screen and to the file "outfile".</p>

This is probably what most people are looking for. The likely situation is some program or script is working hard for a long time and producing a lot of output. The user wants to check it periodically for progress, but also wants the output written to a file.  

The problem (especially when mixing stdout and stderr streams) is that there is reliance on the streams being flushed by the program. If, for example, all the writes to stdout are <em>not</em> flushed, but all the writes to stderr <em>are</em> flushed, then they'll end up out of chronological order in the output file and on the screen.  

It's also bad if the program only outputs 1 or 2 lines every few minutes to report progress. In such a case, if the output was not flushed by the program, the user wouldn't even see any output on the screen for hours, because none of it would get pushed through the pipe for hours.  

Update: The program `unbuffer`, part of the `expect` package, will solve the buffering problem. This will cause stdout and stderr to write to the screen and file immediately and keep them in sync when being combined and redirected to `tee`. E.g.:  

```sh
$ unbuffer program [arguments...] 2>&1 | tee outfile
```

#### Answer 3 (score 117)
Another way that works for me is,   

```sh
<command> |& tee  <outputFile>
```

as shown in <a href="http://www.gnu.org/software/bash/manual/bashref.html#Pipelines" rel="noreferrer">gnu bash manual</a>  

Example:  

```sh
ls |& tee files.txt
```

<blockquote>
  <em>If ‘|&amp;’ is used, command1’s <strong>standard error</strong>, in addition to its <strong>standard output</strong>, is connected to command2’s standard input through the pipe; it is <strong>shorthand for 2>&amp;1</strong> |. This implicit redirection of the standard error to the standard output is performed after any redirections specified by the command.</em>   
</blockquote>

For more information, refer <a href="http://www.gnu.org/software/bash/manual/bashref.html#Redirections" rel="noreferrer">redirection</a>   

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: Write to .txt file? (score [558915](https://stackoverflow.com/q/11573974) in 2014)

#### Question
<p>How can I write a little piece of text into a `.txt` file?
I've been Googling for over 3-4 hours, but can't find out how to do it.</p>

`fwrite();` has so many arguments, and I don't know how to use it.  

What's the easiest function to use when you only want to write a name and a few numbers to a `.txt` file?  

Edit: Added a piece of my code.  

```sh
    char name;
    int  number;
    FILE *f;
    f = fopen("contacts.pcl", "a");

    printf("\nNew contact name: ");
    scanf("%s", &name);
    printf("New contact number: ");
    scanf("%i", &number);


    fprintf(f, "%c\n[ %d ]\n\n", name, number);
    fclose(f);
```

#### Answer accepted (score 251)
```sh
FILE *f = fopen("file.txt", "w");
if (f == NULL)
{
    printf("Error opening file!\n");
    exit(1);
}

/* print some text */
const char *text = "Write this to the file";
fprintf(f, "Some text: %s\n", text);

/* print integers and floats */
int i = 1;
float py = 3.1415927;
fprintf(f, "Integer: %d, float: %f\n", i, py);

/* printing single chatacters */
char c = 'A';
fprintf(f, "A character: %c\n", c);

fclose(f);
```

#### Answer 2 (score 20)
```sh
FILE *fp;
char* str = "string";
int x = 10;

fp=fopen("test.txt", "w");
if(fp == NULL)
    exit(-1);
fprintf(fp, "This is a string which is written to a file\n");
fprintf(fp, "The string has %d words and keyword %s\n", x, str);
fclose(fp);
```

#### Answer 3 (score -1)
Well, you need to first get a good book on C and understand the language.  

```sh
FILE *fp;
fp = fopen("c:\\test.txt", "wb");
if(fp == null)
   return;
char x[10]="ABCDEFGHIJ";
fwrite(x, sizeof(x[0]), sizeof(x)/sizeof(x[0]), fp);
fclose(fp);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: How to grep a string in a directory and all its subdirectories' files in LINUX? (score [553700](https://stackoverflow.com/q/15622328) in )

#### Question
How to grep a string or a text in a directory and all its subdirectories'files in  LINUX ??  

#### Answer accepted (score 398)
If your grep supports `-R`, do:  

```sh
grep -R 'string' dir/
```

If not, then use `find`:  

```sh
find dir/ -type f -exec grep -H 'string' {} +
```

#### Answer 2 (score 47)
```sh
grep -r -e string directory
```

`-r` is for recursive; `-e` is optional but its argument specifies the regex to search for.  Interestingly, <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html">POSIX `grep`</a> is not required to support `-r` (or `-R`), but <s>I'm practically certain that System V `grep` did, so</s> in practice they (almost) all do.  Some versions of `grep` support `-R` as well as (or conceivably instead of) `-r`; AFAICT, it means the same thing.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: Install tkinter for Python (score [552246](https://stackoverflow.com/q/4783810) in 2019)

#### Question
I am trying to import Tkinter. However, I get an error stating that Tkinter has not been installed:  

```sh
ImportError: No module named _tkinter, please install the python-tk package
```

I could probably install it using synaptic manager (can I?), however, I would have to install it on every machine I program on. Would it be possible to add the Tkinter library into my workspace and reference it from there?  

#### Answer accepted (score 365)
It is not very easy to install Tkinter locally to use with system-provided Python. You may build it from sources, but this is usually not the best idea with a binary package-based distro you're apparently running.  

<p>It's safer to `apt-get install python-tk` on your machine(s).
(Works on Debian-derived distributions like for Ubuntu; refer to your package manager and package list on other distributions.)</p>

#### Answer 2 (score 72)
Actually, you just need to use the following to install the tkinter for python3:  

```sh
sudo apt-get install python3-tk
```

In addition, for Fedora users, use the following command:  

```sh
sudo dnf install python3-tkinter
```

#### Answer 3 (score 62)
If, like me, you don't have root privileges on your network because of your wonderful friends in I.S., and you are working in a local install you may have some problems with the above approaches.  

I spent ages on Google - but in the end, it's easy.   

Download the tcl and tk from <a href="http://www.tcl.tk/software/tcltk/download.html" rel="noreferrer">http://www.tcl.tk/software/tcltk/download.html</a> and install them locally too.   

To install locally on Linux (I did it to my home directory), extract the .tar.gz files for tcl and tk.  Then open up the readme files inside the ./unix directory.  I ran  

```sh
cd ~/tcl8.5.11/unix
./configure --prefix=/home/cnel711 --exec-prefix=/home/cnel711
make
make install

cd ~/tk8.5.11/unix
./configure --prefix=/home/cnel711 --exec-prefix=/home/cnel711 --with-tcl=/home/cnel711/tcl8.5.11/unix
make
make install
```

It may seem a pain, but the files are tiny and installation is very fast.  

Then re-run `python setup.py build` and `python setup.py install` in your python installation directory - and it should work. It worked for me - and I can now import Tkinter etc to my heart's content - yipidy-yay. An entire afternoon spent on this - hope this note saves others from the pain.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: grep, but only certain file extensions (score [550776](https://stackoverflow.com/q/12516937) in 2017)

#### Question
I am working on writing some scripts to `grep` certain directories, but these directories contain all sorts of file types.  

I want to `grep` just `.h` and `.cpp` for now, but maybe a few others in the future.  

So far I have:  

```sh
{ grep -r -i CP_Image ~/path1/;

grep -r -i CP_Image ~/path2/;

grep -r -i CP_Image ~/path3/;

grep -r -i CP_Image ~/path4/;

grep -r -i CP_Image ~/path5/;} 

| mailx -s GREP email@domain.com
```

Can anyone show me how I would now add just the specific file extensions?  

#### Answer accepted (score 1201)
Just use the `--include` parameter, like this:  

```sh
grep -r -i --include \*.h --include \*.cpp CP_Image ~/path[12345] | mailx -s GREP email@domain.com
```

that should do what you want.  

Syntax notes:  

<ul>
<li>`-r` - search recursively</li>
<li>`-i` - case-<strong>insensitive</strong> search</li>
<li>`--include=\*.${file_extension}` - search files that match the extension(s) or file pattern only</li>
</ul>

#### Answer 2 (score 256)
Some of these answers seemed too syntax-heavy, or they produced issues on my Debian Server.  This worked perfectly for me:  

<a href="https://phprevolution.blogspot.com/2018/08/how-to-grep-files-in-linux-but-only.html" rel="noreferrer">PHP Revolution: How to Grep files in Linux, but only certain file extensions?</a>  

Namely:  

```sh
grep -r --include=\*.txt 'searchterm' ./
```

...or case-insensitive version...  

```sh
grep -r -i --include=\*.txt 'searchterm' ./
```

<ul>
<li><p>`grep`: command</p></li>
<li><p>`-r`: recursively</p></li>
<li><p>`-i`: ignore-case</p></li>
<li><p>`--include`: all *.txt: text files (escape with \ just in case you have a directory with asterisks in the filenames)</p></li>
<li><p>`'searchterm'`: What to search</p></li>
<li><p>`./`: Start at current directory.</p></li>
</ul>

#### Answer 3 (score 48)
How about:  

```sh
find . -name '*.h' -o -name '*.cpp' -exec grep "CP_Image" {} \; -print
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: Undefined reference to pthread_create in Linux (score [550266](https://stackoverflow.com/q/1662909) in 2017)

#### Question
I picked up the following demo off the web from <a href="https://computing.llnl.gov/tutorials/pthreads/" rel="noreferrer">https://computing.llnl.gov/tutorials/pthreads/</a>  

```sh
#include <pthread.h>
#include <stdio.h>
#define NUM_THREADS     5

void *PrintHello(void *threadid)
{
   long tid;
   tid = (long)threadid;
   printf("Hello World! It's me, thread #%ld!\n", tid);
   pthread_exit(NULL);
}

int main (int argc, char *argv[])
{
   pthread_t threads[NUM_THREADS];
   int rc;
   long t;
   for(t=0; t<NUM_THREADS; t++){
      printf("In main: creating thread %ld\n", t);
      rc = pthread_create(&threads[t], NULL, PrintHello, (void *)t);
      if (rc){
         printf("ERROR; return code from pthread_create() is %d\n", rc);
         exit(-1);
      }
   }
   pthread_exit(NULL);
}
```

But when I compile it on my machine (running Ubuntu Linux 9.04) I get the following error:  

```sh
corey@ubuntu:~/demo$ gcc -o term term.c
term.c: In function ‘main’:
term.c:23: warning: incompatible implicit declaration of built-in function ‘exit’
/tmp/cc8BMzwx.o: In function `main':
term.c:(.text+0x82): undefined reference to `pthread_create'
collect2: ld returned 1 exit status
```

This doesn't make any sense to me, because the header includes `pthread.h`, which should have the `pthread_create` function. Any ideas what's going wrong?  

#### Answer 2 (score 630)
<p>Both answers to this question so far are <em>incorrect</em>.<br>
For Linux the correct command is:</p>

```sh
gcc -pthread -o term term.c
```

In general, libraries should follow sources and objects on command line, and `-lpthread` is not an "option", it's a library specification. On a system with only `libpthread.a` installed,   

```sh
gcc -lpthread ...
```

will fail to link.  

#### Answer 3 (score 35)
in eclipse   

properties->c/c++Build->setting->GCC C++ linker->libraries in top part add "pthread"  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: How to create a link to a directory (score [529086](https://stackoverflow.com/q/9587445) in 2016)

#### Question
How to create a link `xxx` to `/home/jake/doc/test/2000/something/`?  

Assume the `xxx` is created under `/home/jake` and you're currently in `/home/jake`. When you do `cd xxx`, you directly go to `/home/jake/doc/test/2000/something/`.  

#### Answer accepted (score 509)
Symbolic or soft link (files or directories, more flexible and self documenting)  

```sh
#     Source                             Link
ln -s /home/jake/doc/test/2000/something /home/jake/xxx
```

Hard link (files only, less flexible and not self documenting)  

```sh
#   Source                             Link
ln /home/jake/doc/test/2000/something /home/jake/xxx
```

More information: <a href="https://www.google.com/search?&amp;q=man%20ln" rel="noreferrer">man ln</a>  

#### Answer 2 (score 44)
you should use :  

```sh
ln -s /home/jake/doc/test/2000/something xxx
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Command to change the default home directory of a user (score [524721](https://stackoverflow.com/q/20797819) in 2014)

#### Question
I would like to know whether there is any simple shell command to change the user home directory in Linux/Unix (one similar to <strong>chsh</strong> which changes the default login shell of an existing valid user) without touching the `/etc/passwd` file. Thanks  

#### Answer 2 (score 318)
Ibrahim's comment on the other answer is the correct way to alter an existing user's home directory.   

<h5>Change the user's home directory:</h3>

```sh
usermod -d /newhome/username username
```

<p>`usermod` is the command to edit an existing user. <br>
`-d` (abbreviation for `--home`) will change the user's home directory.<br>
<br></p>

<h5>Change the user's home directory + Move the contents of the user's current directory:</h3>

```sh
usermod -d -m /newhome/username username
```

`-m` (abbreviation for `--move-home`) will move the content from the user's current directory to the new directory.  

#### Answer 3 (score 26)
From <a href="http://www.cyberciti.biz/faq/howto-change-default-home-directory/">Linux Change Default User Home Directory While Adding A New User</a>:  

<blockquote>
  Simply open this file using a text editor, type:  

```sh
vi /etc/default/useradd
```
  
  <p>The default home directory defined by HOME variable, find line that
  read as follows:</p>

```sh
HOME=/home
```
  
  Replace with:  

```sh
HOME=/iscsi/user
```
  
  <p>Save and close the file. Now you can add user using regular useradd
  command:</p>

```sh
# useradd vivek
# passwd vivek
```
  
  Verify user information:  

```sh
# finger vivek
```
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: Argument list too long error for rm, cp, mv commands (score [523283](https://stackoverflow.com/q/11289551) in 2018)

#### Question
I have several hundred PDFs under a directory in UNIX. The names of the PDFs are really long (approx. 60 chars).  

When I try to delete all PDFs together using the following command:  

```sh
rm -f *.pdf
```

I get the following error:  

```sh
/bin/rm: cannot execute [Argument list too long]
```

<p>What is the solution to this error?
Does this error occur for `mv` and `cp` commands as well? If yes, how to solve for these commands?</p>

#### Answer accepted (score 794)
The reason this occurs is because bash actually expands the asterisk to every matching file, producing a very long command line.  

Try this:  

```sh
find . -name "*.pdf" -print0 | xargs -0 rm
```

<strong>Warning:</strong> this is a recursive search and will find (and delete) files in subdirectories as well. Tack on `-f` to the rm command only if you are sure you don't want confirmation.  

You can do the following to make the command non-recursive:  

```sh
find . -maxdepth 1 -name "*.pdf" -print0 | xargs -0 rm
```

Another option is to use find's `-delete` flag:  

```sh
find . -name "*.pdf" -delete
```

#### Answer 2 (score 352)
<h5>tl;dr</h2>

It's a kernel limitation on the size of the command line argument. Use a `for` loop instead.  

<h5>Origin of problem</h2>

This is a system issue, related to `execve` and `ARG_MAX` constant. There is plenty of documentation about that (see <a href="http://linux.die.net/man/2/execve" rel="noreferrer">man execve</a>, <a href="https://wiki.debian.org/CommonErrorMessages/ArgumentListTooLong" rel="noreferrer">debian's wiki</a>).   

<p>Basically, the expansion produce a <em>command</em> (with its parameters) that exceeds the `ARG_MAX` limit.
On kernel `2.6.23`, the limit was set at `128 kB`. This constant has been increased and you can get its value by executing:</p>

```sh
getconf ARG_MAX
# 2097152 # on 3.5.0-40-generic
```

<h5>Solution: Using `for` Loop</h2>

Use a `for` loop as it's recommended on <a href="http://mywiki.wooledge.org/BashFAQ/095" rel="noreferrer">BashFAQ/095</a> and there is no limit except for RAM/memory space:  

```sh
for f in *.pdf; do rm "$f"; done
```

Also this is a portable approach as glob have strong and consistant behavior among shells (<a href="http://man7.org/linux/man-pages/man7/glob.7.html" rel="noreferrer">part of POSIX spec</a>).   

<strong>Note:</strong> As noted by several comments, this is indeed slower but more maintainable as it can adapt more complex scenarios, <em>e.g.</em> where one want to do more than just one action.  

<h5>Solution: Using `find`</h2>

If you insist, you can use `find` but really <strong>don't use xargs</strong> as it <em>"is dangerous (broken, exploitable, etc.) when reading non-NUL-delimited input"</em>:  

```sh
find . -maxdepth 1 -name '*.pdf' -delete 
```

Using `-maxdepth 1 ... -delete` instead of `-exec rm {} +` allows `find` to simply execute the required system calls itself without using an external process, hence faster (thanks to <a href="https://stackoverflow.com/questions/11289551/argument-list-too-long-error-for-rm-cp-mv-commands/18647755?noredirect=1#comment69166385_11302033">@chepner comment</a>).  

<h5>References</h2>

<ul>
<li><a href="http://mywiki.wooledge.org/BashFAQ/095" rel="noreferrer">I'm getting "Argument list too long". How can I process a large list in chunks?</a> @ wooledge</li>
<li><a href="http://linux.die.net/man/2/execve" rel="noreferrer">execve(2) - Linux man page</a> (search for ARG_MAX) ;</li>
<li><a href="https://wiki.debian.org/CommonErrorMessages/ArgumentListTooLong" rel="noreferrer">Error: Argument list too long</a> @ Debian's wiki ;</li>
<li><a href="https://superuser.com/questions/240183/how-to-work-around-shell-limitation-of-argument-list-too-long%29">Why do I get “/bin/sh: Argument list too long” when passing quoted arguments?</a> @ SuperUser</li>
</ul>

#### Answer 3 (score 176)
`find` has a `-delete` action:  

```sh
find . -maxdepth 1 -name '*.pdf' -delete
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: How to set proxy for wget? (score [523259](https://stackoverflow.com/q/11211705) in 2019)

#### Question
I want to download something with `wget` using a proxy:  

```sh
HTTP Proxy: 127.0.0.1
Port: 8080
```

The proxy does not need username and password.  

How can I do this?  

#### Answer 2 (score 382)
For all users of the system via the `/etc/wgetrc` or for the user only with the `~/.wgetrc` file:  

```sh
use_proxy=yes
http_proxy=127.0.0.1:8080
https_proxy=127.0.0.1:8080
```

or via `-e` options placed after the URL:  

```sh
wget ... -e use_proxy=yes -e http_proxy=127.0.0.1:8080 ...
```

#### Answer 3 (score 76)
Type in command line :  

```sh
$ export http_proxy=http://proxy_host:proxy_port
```

for authenticated proxy,   

```sh
$ export http_proxy=http://username:password@proxy_host:proxy_port
```

and then run  

```sh
$ wget fileurl
```

for https, just use https_proxy instead of http_proxy. You could also put these lines in your ~/.bashrc file so that you don't need to execute this everytime.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Convert DOS line endings to Linux line endings in vim (score [517407](https://stackoverflow.com/q/82726) in 2016)

#### Question
<p>If I open files I created in Windows, the lines all end with `^M`.<br>
How do I delete these characters all at once?</p>

#### Answer accepted (score 1029)
<a href="https://sourceforge.net/projects/dos2unix" rel="noreferrer">dos2unix</a> is a commandline utility that will do this, or `:%s/^M//g` will if you use <kbd>Ctrl</kbd>-<kbd>v</kbd> <kbd>Ctrl</kbd>-<kbd>m</kbd> to input the ^M, or you can `:set ff=unix` and vim will do it for you.  

Docs on the 'fileformat' setting are <a href="http://www.vim.org/htmldoc/options.html#%27fileformat%27" rel="noreferrer">here</a>, and the vim wiki has a comprehensive <a href="http://vim.wikia.com/wiki/Change_end-of-line_format_for_dos-mac-unix" rel="noreferrer">page on line ending conversions</a>.  

Alternately, if you move files back and forth a lot, you might not want to convert them, but rather to do `:set ff=dos`, so vim will know it's a DOS file and use DOS conventions for line endings.  

#### Answer 2 (score 261)
Change the line endings in the view:  

```sh
:e ++ff=dos
:e ++ff=mac
:e ++ff=unix
```

This can also be used as saving operation (:w alone will not save using the line endings you see on screen):  

```sh
:w ++ff=dos
:w ++ff=mac
:w ++ff=unix
```

And you can use it from the command-line:  

```sh
for file in *.cpp
do 
    vi +':w ++ff=unix' +':q' "$file"
done
```

#### Answer 3 (score 155)
I typically use  

```sh
:%s/\r/\r/g
```

which seems a little odd, but works because of the way that vim matches linefeeds.  I also find it easier to remember :)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: how to log in to mysql and query the database from linux terminal (score [516111](https://stackoverflow.com/q/6200215) in 2011)

#### Question
<p>I am using debian linux.
I have a linux machine on which mysql is install.
I can log in to my linux machine using root user as well as other user.
I can connect to mysql database on linux machine from windows machine using sqlyog.
Now I want to execute queries on linux machine only using linux terminal</p>

I tried some following things on terminal  

I went to root directory then I went to /var/lib directory  

I run following commands on terminal  

```sh
mysqladmin -u root -p
mysqladmin -u root -ppassword
```

everytime I have get following error message  

<blockquote>
  <p>ERROR 1045 (28000) Access denied for
  user 'root'@'localhost' (Using
  password NO)</p>
</blockquote>

please guide me for following  

<ol>
<li>How do I get mysql prompt in linux terminal?</li>
<li>How I stop the mysql server from linux terminal?</li>
<li>How I start the mysql server from linux terminal?</li>
<li>How do I get mysql prompt in linux terminal?</li>
<li>How do I login to mysql server from linux terminal?</li>
<li>How do I solve following error?</li>
</ol>

<blockquote>
  <p>ERROR 1045 (28000) Access denied for
  user 'root'@'localhost' (Using
  password NO)</p>
</blockquote>

<p>Please give me solutions for above question.
Thank You</p>

#### Answer accepted (score 170)
<strong>1.- How do I get mysql prompt in linux terminal?</strong>  

```sh
mysql -u root -p
```

At the `Enter password:` prompt, well, enter root's password :)  

You can find further reference by typing `mysql --help` or at the <a href="http://dev.mysql.com/doc/refman/5.5/en/programs-client.html" rel="noreferrer">online manual</a>.  

<strong>2. How I stop the mysql server from linux terminal?</strong>  

It depends. Red Hat based distros have the `service` command:  

```sh
service mysqld stop
```

Other distros require to call the init script directly:  

```sh
/etc/init.d/mysqld stop
```

<strong>3. How I start the mysql server from linux terminal?</strong>  

Same as #2, but with `start`.  

<strong>4. How do I get mysql prompt in linux terminal?</strong>  

Same as #1.  

<strong>5. How do I login to mysql server from linux terminal?</strong>  

Same as #1.  

<strong>6. How do I solve following error?</strong>  

Same as #1.  

#### Answer 2 (score 9)
To your first question:  

```sh
mysql -u root -p
```

or  

```sh
mysqladmin -u root -p "your_command"
```

depending on what you want to do. The password will be asked of you once you hit enter! I'm guessing you really want to use <strong>mysql</strong> and not <strong>mysqladmin</strong>.  

For restarting or stopping the MySQL-server on linux, it depends on your installation, but in the common debian derivatives this will work for starting, stopping and restarting the service:  

```sh
sudo /etc/init.d/mysql start
sudo /etc/init.d/mysql stop
sudo /etc/init.d/mysql restart
sudo /etc/init.d/mysql status
```

In some newer distros this might work as well if MySQL is set up as a deamon/service.  

```sh
sudo service mysql start
sudo service mysql stop
sudo service mysql restart
sudo service mysql status
```

But the question is really impossible to answer without knowing your particular setup.  

#### Answer 3 (score 5)
At the command prompt try:  

```sh
mysql -u root -p
```

give the password when prompted.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: How to determine whether a given Linux is 32 bit or 64 bit? (score [510809](https://stackoverflow.com/q/246007) in 2011)

#### Question
When I type `uname -a`, it gives the following output.  

```sh
Linux mars 2.6.9-67.0.15.ELsmp #1 SMP Tue Apr 22 13:50:33 EDT 2008 i686 i686 i386 GNU/Linux
```

How can I know from this that the given OS is 32 or 64 bit?  

This is useful when writing `configure` scripts, for example: what architecture am I building for?  

#### Answer accepted (score 732)
Try <a href="http://linuxmanpages.net/manpages/fedora16/man1/uname.1.html" rel="noreferrer">`uname -m`</a>. Which is short of `uname --machine` and it outputs:   

```sh
x86_64 ==> 64-bit kernel
i686   ==> 32-bit kernel
```

<hr>

Otherwise, <strong>not for the Linux kernel, but for the CPU</strong>, you type:  

```sh
cat /proc/cpuinfo
```

or:  

```sh
grep flags /proc/cpuinfo
```

<p>Under "flags" parameter, you will see various values: see "<a href="https://unix.stackexchange.com/a/43540">What do the flags in /proc/cpuinfo mean?</a>"
Among them, one is named `lm`: `Long Mode` (<a href="http://en.wikipedia.org/wiki/X86-64" rel="noreferrer">x86-64</a>: amd64, also known as Intel 64, i.e. 64-bit capable)</p>

```sh
lm ==> 64-bit processor
```

Or <a href="http://linux.die.net/man/1/lshw" rel="noreferrer">using `lshw`</a> (as mentioned <a href="https://stackoverflow.com/a/32717681/6309">below</a> by <a href="https://stackoverflow.com/users/4637585/rolf-of-saxony">Rolf of Saxony</a>), without `sudo` (just for grepping the cpu width):  

```sh
lshw -class cpu|grep "^       width"|uniq|awk '{print $2}'
```

<p><strong>Note: you can have a 64-bit CPU with a 32-bit kernel installed</strong>.<br>
(as <a href="https://stackoverflow.com/users/637866/ysdx">ysdx</a> mentions in <a href="https://stackoverflow.com/a/32665383/6309">his/her own answer</a>, "Nowadays, a system can be <strong><a href="https://wiki.debian.org/Multiarch" rel="noreferrer">multiarch</a></strong> so it does not make sense anyway. You might want to find the default target of the compiler")</p>

#### Answer 2 (score 154)
If you were running a 64 bit platform you would see x86_64 or something very similar in the output from <a href="http://manpages.ubuntu.com/manpages/intrepid/man1/uname.html" rel="noreferrer" title="uname">uname</a> -a  

To get your specific machine hardware name run  

```sh
uname -m
```

You can also call  

```sh
getconf LONG_BIT
```

which returns either 32 or 64  

#### Answer 3 (score 42)
<a href="http://linuxmanpages.net/manpages/fedora16/man1/lscpu.1.html" rel="noreferrer">`lscpu`</a> will list out these among other information regarding your CPU:  

```sh
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
...
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: How do I connect to a terminal to a serial-to-USB device on Ubuntu 10.10 (Maverick Meerkat)? (score [507010](https://stackoverflow.com/q/5347962) in 2018)

#### Question
I am trying to connect minicom to a serial device that is connected via a USB-to-serial adapter. This is a PL2303 and from everything I've read no additional drivers are required. The device is recognised as a PL2303.  

I'm a beginner at minicom. Is this the correct command to execute? Or do I need to configure something?  

```sh
$ sudo minicom --device /dev/ttyUSB0
minicom: cannot open /dev/ttyUSB0: No such file or directory

$ sudo lsusb -v

Bus 002 Device 006: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port
Device Descriptor:
  bLength                18
  bDescriptorType         1

$ tail /var/log/syslog  #then removed and attached the device.
Mar 13 23:31:49 ubuntu kernel: [807996.786805] usb 2-1: pl2303 converter now attached to ttyUSB0
Mar 13 23:34:44 ubuntu kernel: [808172.155129] usb 2-1: USB disconnect, address 7
Mar 13 23:34:44 ubuntu kernel: [808172.156321] pl2303 ttyUSB0: pl2303 converter now disconnected from ttyUSB0
Mar 13 23:34:44 ubuntu kernel: [808172.156374] pl2303 2-1:1.0: device disconnected
Mar 13 23:34:52 ubuntu kernel: [808179.497856] usb 2-1: new full speed USB device using uhci_hcd and address 8
Mar 13 23:34:52 ubuntu kernel: [808179.785845] pl2303 2-1:1.0: pl2303 converter detected
Mar 13 23:34:52 ubuntu kernel: [808179.872309] usb 2-1: pl2303 converter now attached to ttyUSB0
```

#### Answer accepted (score 78)
<p>First check with `dmesg | grep tty` if system recognize your adapter.
Then try to run minicom with `sudo minicom -s`, go to "Serial port setup" and change the first line to `/dev/ttyUSB0`. </p>

Don't forget to save config as default with "Save setup as dfl". It works for me on Ubuntu 11.04 on VirtualBox.   

#### Answer 2 (score 16)
<p>You will need to set the permissions every time you plug the converter in.
I use <a href="http://en.wikipedia.org/wiki/PuTTY" rel="nofollow noreferrer">PuTTY</a> to connect. In order to do so, I have created a little Bash script to sort out the permissions and launch PuTTY:</p>

```sh
#!/bin/bash
sudo chmod 666 /dev/ttyUSB0

putty
```

P.S. I would never recommend that permissions are set to 777.  

#### Answer 3 (score 6)
The serial port communication programs `moserial` or `gtkterm` provide an easy way to check connectivity and modify `/dev/ttyUSB0` (or `/dev/ttyUSB1`!) settings. Even though there maybe only a single USB to RS232 adapter, the `n` designation `/dev/ttyUSBn` can and does change periodically! Both `moserial` and `gtkterm` will show what port designation is relevant in their respective pull down menus when selecting an appropriate `port` to use.  

Check out <a href="https://help.ubuntu.com/community/Minicom" rel="noreferrer">help.ubuntu.com/community/Minicom</a> for details on `minicom`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: Changing default shell in Linux (score [504666](https://stackoverflow.com/q/13046192) in 2019)

#### Question
How is it possible to change the default shell? The `env` command currently says:  

```sh
SHELL=/bin/tcsh
```

and I want to change that to Bash.  

#### Answer accepted (score 391)
Try linux command `chsh`.  

<p>The detailed command is `chsh -s /bin/bash`.
It will prompt you to enter your password.
Your default login shell is `/bin/bash` now. <strong>You must log out and log back in to see this change.</strong></p>

The following is quoted from man page:  

<blockquote>
  <p>The chsh command changes the user login shell. This determines the
  name
         of the users initial login command. A normal user may only change the
         login shell for her own account, the superuser may change the login
         shell for any account</p>
</blockquote>

This command will change the default login shell permanently.  

Note: If your user account is remote such as on Kerberos authentication (e.g. Enterprise RHEL) then you will not be able to use `chsh`.   

#### Answer 2 (score 142)
You can change the passwd file directly for the particular user or use the below command  

```sh
chsh -s /usr/local/bin/bash username
```

<strong>Then log out and log in</strong>  

#### Answer 3 (score 16)
You should have a 'skeleton' somewhere in `/etc`, probably `/etc/skeleton`, or check the default settings, probably `/etc/default` or something. Those are scripts that define standard environment variables getting set during a login.   

If it is just for your own account: check the (hidden) file `~/.profile` and `~/.login`. Or generate them, if they don't exist. These are also evaluated by the login process.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: Chmod recursively (score [502035](https://stackoverflow.com/q/13377606) in 2017)

#### Question
I have an archive, which is archived by someone else, and I want to automatically, after I download it, to change a branch of the file system within the extracted files to gain read access. (I can't change how archive is created).  

I've looked into this thread: <a href="https://stackoverflow.com/questions/6937885/chmod-how-to-recursively-add-execute-permissions-only-to-files-which-already-ha">chmod: How to recursively add execute permissions only to files which already have execute permission</a> as into some others, but no joy.  

The directories originally come with multiple but all wrong flags, they may appear as:  

```sh
drwx------
d---r-x---
drwxrwxr-x
dr--r-xr--
```

Those are just the few I've discovered so far, but could be more.  

`find` errors when tries to look into a directory with no `x` permission, and so doesn't pass it to `chmod`. What I've been doing so far, is manually change permissions on the parent directory, then go into the child directories and do the same for them and so on. But this is a lot of hand labour. Isn't there some way to do this automatically?  

I.e. how I am doing it now:  

do:  

```sh
$ chmod -R +x
$ chmod -R +r
```

until I get no errors, then  

```sh
$ find -type f -exec chmod -x {} +
```

But there must be a better way.  

#### Answer accepted (score 124)
You need read access, in addition to execute access, to list a directory. If you only have execute access, then you can find out the names of entries in the directory, but no other information (not even types, so you don't know which of the entries are subdirectories). This works for me:  

```sh
find . -type d -exec chmod +rx {} \;
```

#### Answer 2 (score 166)
You can use chmod with the `X` mode letter (the capital X) to set the executable flag only for directories.  

In the example below the executable flag is cleared and then set for all directories recursively:  

```sh
~$ mkdir foo
~$ mkdir foo/bar
~$ mkdir foo/baz
~$ touch foo/x
~$ touch foo/y

~$ chmod -R go-X foo 
~$ ls -l foo
total 8
drwxrw-r-- 2 wq wq 4096 Nov 14 15:31 bar
drwxrw-r-- 2 wq wq 4096 Nov 14 15:31 baz
-rw-rw-r-- 1 wq wq    0 Nov 14 15:31 x
-rw-rw-r-- 1 wq wq    0 Nov 14 15:31 y

~$ chmod -R go+X foo 
~$ ls -l foo
total 8
drwxrwxr-x 2 wq wq 4096 Nov 14 15:31 bar
drwxrwxr-x 2 wq wq 4096 Nov 14 15:31 baz
-rw-rw-r-- 1 wq wq    0 Nov 14 15:31 x
-rw-rw-r-- 1 wq wq    0 Nov 14 15:31 y
```

A bit of explaination:  

<ul>
<li>`chmod -x foo` - clear the <em>eXecutable</em> flag for `foo`</li>
<li>`chmod +x foo` - set the <em>eXecutable</em> flag for `foo`</li>
<li>`chmod go+x foo` - same as above, but set the flag only for <em>Group</em> and <em>Other</em> users, don't touch the <em>User</em> (owner) permission</li>
<li>`chmod go+X foo` - same as above, but apply only to directories, don't touch files</li>
<li>`chmod -R go+X foo` - same as above, but do this <em>Recursively</em> for all subdirectories of `foo`</li>
</ul>

#### Answer 3 (score 78)
Try to change all the persmissions at the same time:  

```sh
chmod -R +xr
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Docker can't connect to docker daemon (score [499935](https://stackoverflow.com/q/21871479) in 2017)

#### Question
After I update my Docker version to `0.8.0`, I get an error message while entering `sudo docker version`:  

```sh
Client version: 0.8.0
Go version (client): go1.2
Git commit (client): cc3a8c8
2014/02/19 12:54:16 Can't connect to docker daemon. Is 'docker -d' running on this host?
```

And I've followed the instructions and entered command `sudo docker -d`, and I got this:  

```sh
[/var/lib/docker|2462000b] +job initserver()
[/var/lib/docker|2462000b.initserver()] Creating server
open /var/lib/docker/aufs/layers/cf2414da53f9bcfaa48bc3d58360d7f1cfd3784e4fe51fbef95197709dfc285d: no such file or directory[/var/lib/docker|2462000b] -job initserver() = ERR (1)
2014/02/19 12:55:57 initserver: open /var/lib/docker/aufs/layers/cf2414da53f9bcfaa48bc3d58360d7f1cfd3784e4fe51fbef95197709dfc285d: no such file or directory
```

How do I solve the problem?  

#### Answer 2 (score 597)
<h5>Linux</h2>

The <a href="https://docs.docker.com/install/linux/linux-postinstall/" rel="noreferrer">Post-installation steps for Linux</a> documentation reveals the following steps:  

<ol>
<li>Create the <strong>docker</strong> group.<pre>
sudo groupadd docker</pre></li>
<li>Add the user to the <strong>docker</strong> group.<pre>
sudo usermod -aG docker $(whoami)</pre></li>
<li>Log out and log back in to ensure docker runs with correct permissions.</li>
<li>Start docker.<pre>
sudo service docker start</pre></li>
</ol>

<h5>Mac OS X</h2>

As <a href="https://stackoverflow.com/users/1978931/dayel-ostraco">Dayel Ostraco</a> says is necessary to add environments variables:  

```sh
docker-machine start # Start virtual machine for docker
docker-machine env  # It's helps to get environment variables
eval "$(docker-machine env default)" # Set environment variables
```

The `docker-machine start` command outputs the comments to guide the process.  

#### Answer 3 (score 141)
If you are running Docker on OS&nbsp;X, running the following eval has worked for me.  

```sh
eval "$(docker-machine env default)"
```

If you'd prefer not to have to run this eval statement on every terminal session, you can add this to your `bash_profile`:  

```sh
#Docker
eval "$(docker-machine env default)"
```

Be sure to restart the terminal session or run source on `bash_profile` for the changes to take effect.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: Command-line Tool to find Java Heap Size and Memory Used (Linux)? (score [494555](https://stackoverflow.com/q/12797560) in )

#### Question
Is there a Command-line Tool (Linux) to check Heap Size (and Used Memory) of a Java Application?  

I have tried jmap. But it gives info. about internal memory areas like Eden/PermGen etc., which is not useful to me.   

<p>I am looking for something like:<br>
    Max Memory: 1GB <br>
    Min Memory: 256 MB <br>
    Heap Memory: 700 MB <br>
    Used Memory: 460 MB</p>

Thats all. I know i can see this in JConsole etc., but i need a command-line tool (cannot enable JMX etc.)  

Any such tool/command?  

#### Answer 2 (score 135)
Each Java process has a `pid`, which you first need to find with the `jps` command.   

Once you have the pid, you can use `jstat -gc [insert-pid-here]` to find statistics of the behavior of the garbage collected heap.  

<ul>
<li><p>`jstat -gccapacity [insert-pid-here]` will present information about memory pool generation and space capabilities.</p></li>
<li><p>`jstat -gcutil [insert-pid-here]` will present the utilization of each generation as a percentage of its capacity. Useful to get an at a glance view of usage.</p></li>
</ul>

See <a href="https://docs.oracle.com/javase/8/docs/technotes/tools/unix/jstat.html" rel="noreferrer">jstat docs</a> on Oracle's site.  

#### Answer 3 (score 61)
<a href="https://github.com/patric-r/jvmtop" rel="noreferrer">jvmtop</a> is a command-line tool which provides a live-view at several metrics, including heap.  

<h5>Example output of the VM overview mode:</h3>

```sh
 JvmTop 0.3 alpha (expect bugs)  amd64  8 cpus, Linux 2.6.32-27, load avg 0.12
 http://code.google.com/p/jvmtop

  PID MAIN-CLASS      HPCUR HPMAX NHCUR NHMAX    CPU     GC    VM USERNAME   #T DL
 3370 rapperSimpleApp  165m  455m  109m  176m  0.12%  0.00% S6U37 web        21
11272 ver.resin.Resin [ERROR: Could not attach to VM]
27338 WatchdogManager   11m   28m   23m  130m  0.00%  0.00% S6U37 web        31
19187 m.jvmtop.JvmTop   20m 3544m   13m  130m  0.93%  0.47% S6U37 web        20
16733 artup.Bootstrap  159m  455m  166m  304m  0.12%  0.00% S6U37 web        46
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: How to see top processes sorted by actual memory usage? (score [492906](https://stackoverflow.com/q/4802481) in 2018)

#### Question
I have a server with 12G of memory. A fragment of top is shown below:  

```sh
PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                                                                                                                                                                                                                                      
12979 frank  20   0  206m  21m  12m S   11  0.2  26667:24 krfb                                                                                                                                                                                                                                                          
13 root      15  -5     0    0    0 S    1  0.0  36:25.04 ksoftirqd/3                                                                                                                                                                                                                                                   
59 root      15  -5     0    0    0 S    0  0.0   4:53.00 ata/2                                                                                                                                                                                                                                                         
2155 root      20   0  662m  37m 8364 S    0  0.3 338:10.25 Xorg                                                                                                                                                                                                                                                          
4560 frank  20   0  8672 1300  852 R    0  0.0   0:00.03 top                                                                                                                                                                                                                                                           
12981 frank  20   0  987m  27m  15m S    0  0.2  45:10.82 amarok                                                                                                                                                                                                                                                        
24908 frank  20   0 16648  708  548 S    0  0.0   2:08.84 wrapper                                                                                                                                                                                                                                                       
1 root      20   0  8072  608  572 S    0  0.0   0:47.36 init                                                                                                                                                                                                                                                          
2 root      15  -5     0    0    0 S    0  0.0   0:00.00 kthreadd
```

The `free -m` shows the following:  

```sh
             total       used       free     shared    buffers     cached
Mem:         12038      11676        362          0        599       9745
-/+ buffers/cache:       1331      10706
Swap:         2204        257       1946
```

If I understand correctly, the system has only 362 MB of available memory. My question is: How can I find out which process is consuming most of the memory?  

Just as background info, the system is running `64bit OpenSuse 12`.  

#### Answer accepted (score 274)
First, repeat this mantra for a little while: "unused memory is wasted memory". The Linux kernel keeps around <em>huge</em> amounts of file metadata and files that were requested, until something that looks more important pushes that data out. It's why you can run:  

```sh
find /home -type f -name '*.mp3'
find /home -type f -name '*.aac'
```

and have the second `find` instance run at ridiculous speed.  

Linux only leaves a little bit of memory 'free' to handle spikes in memory usage without too much effort.  

Second, you want to find the processes that are eating all your memory; in `top` use the `M` command to sort by memory use. Feel free to ignore the `VIRT` column, that just tells you how much virtual memory has been allocated, not how much memory the process is using. `RES` reports how much memory is <em>resident</em>, or currently in ram (as opposed to swapped to disk or never actually allocated in the first place, despite being requested).  

But, since `RES` will count e.g. `/lib/libc.so.6` memory once for nearly every process, it isn't exactly an awesome measure of how much memory a process is using. The `SHR` column reports how much memory is <em>shared</em> with other processes, but there is no guarantee that another process is actually sharing -- it could be sharable, just no one else wants to share.  

The <a href="http://www.selenic.com/smem/">`smem`</a> tool is designed to help users better gage just how much memory should <em>really</em> be blamed on each individual process. It does some clever work to figure out what is really unique, what is shared, and proportionally tallies the shared memory to the processes sharing it. `smem` may help you understand where your memory is going better than `top` will, but `top` is an excellent first tool.  

#### Answer 2 (score 310)
use quick tip using top command in linux/unix  

```sh
$ top
```

and then hit <kbd>Shift</kbd>+<kbd>m</kbd> (i.e. write a capital `M`).  

From `man top`  

```sh
SORTING of task window
  For compatibility, this top supports most of the former top sort keys.
  Since this is primarily a service to former top users, these commands do
  not appear on any help screen.
    command   sorted-field                  supported
      A         start time (non-display)      No
      M         %MEM                          Yes
      N         PID                           Yes
      P         %CPU                          Yes
      T         TIME+                         Yes
```

Or alternatively: hit <kbd>Shift</kbd> + <kbd>f</kbd> , then choose the display to order by memory usage by hitting key <kbd>n</kbd> then press <kbd>Enter</kbd>. You will see active process ordered by memory usage  

#### Answer 3 (score 37)
```sh
ps aux | awk '{print $2, $4, $11}' | sort -k2rn | head -n 10
```

(Adding -n numeric flag to sort command.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: How do I change the number of open files limit in Linux? (score [491550](https://stackoverflow.com/q/34588) in 2012)

#### Question
When running my application I sometimes get an error about `too many files open`.  

Running `ulimit -a` reports that the limit is 1024.  How do I increase the limit above 1024?    

<p><strong>Edit</strong>
`ulimit -n 2048` results in a permission error.</p>

#### Answer accepted (score 148)
You could always try doing a `ulimit -n 2048`.  This will only reset the limit for your current shell and the number you specify must not exceed the hard limit  

Each operating system has a different hard limit setup in a configuration file.  For instance, the hard open file limit on Solaris can be set on boot from /etc/system.  

```sh
set rlim_fd_max = 166384
set rlim_fd_cur = 8192
```

On OS X, this same data must be set in /etc/sysctl.conf.  

```sh
kern.maxfilesperproc=166384
kern.maxfiles=8192
```

Under Linux, these settings are often in /etc/security/limits.conf.  

There are two kinds of limits:  

<ul>
<li><strong>soft</strong> limits are simply the currently enforced limits</li>
<li><strong>hard</strong> limits mark the maximum value which cannot be exceeded by setting a soft limit</li>
</ul>

<p>Soft limits could be set by any user while hard limits are changeable only by root.
Limits are a property of a process. They are inherited when a child process is created so system-wide limits should be set during the system initialization in init scripts and user limits should be set during user login for example by using pam_limits.</p>

There are often defaults set when the machine boots.  So, even though you may reset your ulimit in an individual shell, you may find that it resets back to the previous value on reboot.  You may want to grep your boot scripts for the existence ulimit commands if you want to change the default.   

#### Answer 2 (score 97)
If you are using Linux and you got the permission error, you will need to raise the allowed limit in the `/etc/limits.conf` or `/etc/security/limits.conf` file (where the file is located depends on your specific Linux distribution).   

For example to allow anyone on the machine to raise their number of open files up to 10000 add the line to the `limits.conf` file.   

`* hard nofile 10000`  

Then logout and relogin to your system and you should be able to do:  

`ulimit -n 10000`   

without a permission error.   

#### Answer 3 (score 36)
1) Add the following line to `/etc/security/limits.conf`  

```sh
webuser hard nofile 64000
```

then login as webuser  

```sh
su - webuser
```

2) Edit following two files for webuser  

append <strong>.bashrc and .bash_profile</strong> file by running  

```sh
echo "ulimit -n 64000" >> .bashrc ; echo "ulimit -n 64000" >> .bash_profile
```

3) Log out, then log back in and verify that the changes have been made correctly:  

```sh
$ ulimit -a | grep open
open files                      (-n) 64000
```

Thats it and them boom, boom boom.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: Check If a Particular Service Is Running on Ubuntu (score [490966](https://stackoverflow.com/q/18721149) in 2016)

#### Question
I do not know the service's name, but would like to stop the service by checking its status. For example, if I want to check if the <a href="http://en.wikipedia.org/wiki/PostgreSQL">PostgreSQL</a> service is running or not, but I don't know the service's name, then how could I check its status?  

I know the command to check the status if the service name is known.  

#### Answer accepted (score 415)
I don't have an Ubuntu box, but on <a href="http://en.wikipedia.org/wiki/Red_Hat_Linux">Red Hat Linux</a> you can see all running services by running the following command:  

```sh
service --status-all
```

On the list the `+` indicates the service is running, `-` indicates service is not running, `?` indicates the service state cannot be determined.  

#### Answer 2 (score 71)
For Ubuntu (checked with 12.04)  

You can get list of all services and select by color one of them with 'grep':  

```sh
sudo service --status-all | grep postgres
```

Or you may use another way if you know correct name of service:  

```sh
sudo service postgresql status
```

#### Answer 3 (score 38)
Maybe what you want is the ps command;  

```sh
ps -ef
```

will show you all processes running. Then if you have an idea of what you're looking for use grep to filter;  

```sh
ps -ef | grep postgres
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: apt-get: command not found (score [490087](https://stackoverflow.com/q/32592956) in )

#### Question
I'm trying to install an apache server on my AWS instance, however, it seems that it doesn't have the apt package installed.  

I googled and all I found was some broken links to this package. I am using Putty on a windows machine if that information helps.  

I currently have low to none experience in linux enviroments.  

I am running the following version of Linux  

```sh
Linux ip-172-31-37-96 3.14.48-33.39.amzn1.x86_64 #1 SMP Tue Jul 14 23:43:07 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
```

Can anyone help with that?  

#### Answer accepted (score 212)
If you're using Amazon Linux it's CentOS-based, which is RedHat-based. RH-based installs use `yum` not `apt-get`. Something like `yum search httpd` should show you the available Apache packages - you likely want `yum install httpd24`.  

<blockquote>
  Note: Amazon Linux 2 has <a href="https://serverfault.com/questions/798427/what-linux-distribution-is-the-amazon-linux-ami-based-on">diverged from CentOS</a> since the writing of this answer, but still uses `yum`.  
</blockquote>

#### Answer 2 (score 14)
<p>Try to install your application by using `yum` command
`yum install application_name`</p>

#### Answer 3 (score 4)
I faced the same issue regarding `apt-get: command not found` here are the steps how I resolved it on ubuntu xenial  

<ul>
<li><p>Search the appropriate version of <strong>apt</strong> from <a href="http://security.ubuntu.com/ubuntu/pool/main/a/apt/" rel="nofollow noreferrer">here</a>
(`apt_1.4_amd64.deb` for ubuntu xenial)</p></li>
<li><p>Download the apt.deb</p>

`wget http://security.ubuntu.com/ubuntu/pool/main/a/apt/apt_1.4_amd64.deb`  </li>
<li><p>Install the apt.deb package </p>

`sudo dpkg -i apt_1.4_amd64.deb`  </li>
</ul>

Now we can easily run  

`sudo apt-get install htop`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: How to unmount a busy device (score [483674](https://stackoverflow.com/q/7878707) in 2019)

#### Question
I've got some samba drives that are being accessed by multiple users daily. I already have code to recognize shared drives (from a SQL table) and mount them in a special directory where all users can access them.   

I want to know, if I remove a drive from my SQL table (effectively taking it offline) how, or even is, there a way to unmount a busy device? So far I've found that any form of `umount` does not work.   

Ignoring the possibility of destroying data - is it possible to unmount a device that is currently being read?   

#### Answer accepted (score 387)
YES!! There is a way to detach a busy device immediately (even if it is busy and cannot be unmounted forcefully). You may cleanup all later:  

```sh
umount -l /PATH/OF/BUSY-DEVICE
umount -f /PATH/OF/BUSY-NFS(NETWORK-FILE-SYSTEM)
```

<strong>NOTE:</strong>  

<ol>
<li>These commands can disrupt a running process, cause data loss OR corrupt open files. Programs accessing target DEVICE/NFS files may throw errors OR could not work properly after force unmount.</li>
<li>Try to execute these commands when NOT inside mounted Folder/Drive/Device.</li>
</ol>

#### Answer 2 (score 89)
If possible, let's locate/identify the busy the process, kill the process and then unmount the samba share to minimize damage.  

<ul>
<li><p>`lsof | grep '&lt;mountpoint of /dev/sda1&gt;'` (or whatever the mounted device is)</p></li>
<li><p>`pkill target_process` (kills busy proc. by name | `kill PID` | `killall target_process`) </p></li>
<li><p>`umount /dev/sda1` (or whatever the mounted device is)</p></li>
</ul>

#### Answer 3 (score 58)
Make sure that you aren't still in the mounted device when you are trying to umount.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: ./configure : /bin/sh^M : bad interpreter (score [480455](https://stackoverflow.com/q/2920416) in 2010)

#### Question
I've been trying to install lpng142 on my fed 12 system. Seems like a problem to me. I get this error  

```sh
[root@localhost lpng142]# ./configure
bash: ./configure: /bin/sh^M: bad interpreter: No such file or directory
[root@localhost lpng142]# 
```

How do I fix this? The `/etc/fstab` file:  

```sh
#
# /etc/fstab
# Created by anaconda on Wed May 26 18:12:05 2010
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/VolGroup-lv_root /                       ext4    defaults        1 1
UUID=ce67cf79-22c3-45d4-8374-bd0075617cc8 /boot                   ext4    
defaults        1 2
/dev/mapper/VolGroup-lv_swap swap                    swap    defaults        0 0
tmpfs                   /dev/shm                tmpfs   defaults        0 0
devpts                  /dev/pts                devpts  gid=5,mode=620  0 0
sysfs                   /sys                    sysfs   defaults        0 0
proc                    /proc                   proc    defaults        0 0
```

#### Answer accepted (score 717)
To fix, open your script with vi or vim and enter in vi command mode (key <KBD>Esc</KBD>), then type this:  

```sh
:set fileformat=unix
```

Finally save it  

`:x!` or `:wq!`  

#### Answer 2 (score 360)
Looks like you have a dos line ending file. The clue is the `^M`.  

You need to re-save the file using Unix line endings.  

You might have a `dos2unix` command line utility that will also do this for you.  

#### Answer 3 (score 94)
Or if you want to do this with a script:  

```sh
sed -i 's/\r//' filename
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: Given two directory trees, how can I find out which files differ? (score [474513](https://stackoverflow.com/q/4997693) in )

#### Question
If I want find the differences between two directory trees, I usually just execute:  

```sh
diff -r dir1/ dir2/
```

This outputs exactly what the differences are between corresponding files.  I'm interested in just getting a list of corresponding files whose content differs.  I assumed that this would simply be a matter of passing a command line option to `diff`, but I couldn't find anything on the man page.  

Any suggestions?  

#### Answer accepted (score 1052)
You said Linux, so you luck out (at least it should be available, not sure when it was added):  

```sh
diff --brief --recursive dir1/ dir2/ # GNU long options
diff -qr dir1/ dir2/ # common short options
```

Should do what you need.  

If you also want to see differences for files that may not exist in either directory:  

```sh
diff --brief --recursive --new-file dir1/ dir2/ # GNU long options
diff -qrN dir1/ dir2/ # common short options
```

#### Answer 2 (score 284)
The command I use is:  

```sh
diff -qr dir1/ dir2/
```

It is exactly the same as Mark's :) But his answer bothered me as it uses different <em>types</em> of flags, and it made me look twice. Using Mark's more verbose flags it would be:  

```sh
diff  --brief --recursive dir1/ dir2/
```

<sub>I apologise for posting when the other answer is perfectly acceptable. Could not stop myself... working on being less pedantic.</sub>   

#### Answer 3 (score 96)
I like to use `git diff --no-index dir1/ dir2/`, because it can show the differences in color (if you have that option set in your git config) and because it shows all of the differences in a long paged output using "less".  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Execute combine multiple Linux commands in one line (score [471680](https://stackoverflow.com/q/13077241) in 2019)

#### Question
<p>I am trying to merge multiple linux commands in one line to perform deployment operation.
For example</p>

```sh
cd /my_folder
rm *.jar
svn co path to repo
mvn compile package install
```

#### Answer accepted (score 690)
If you want to execute each command only if the previous one succeeded, then combine them using the `&amp;&amp;` operator:  

```sh
cd /my_folder && rm *.jar && svn co path to repo && mvn compile package install
```

If one of the commands fails, then all other commands following it won't be executed.  

If you want to execute all commands regardless of whether the previous ones failed or not, separate them with semicolons:  

```sh
cd /my_folder; rm *.jar; svn co path to repo; mvn compile package install
```

In your case, I think you want the first case where execution of the next command depends on the success of the previous one.  

You can also put all commands in a script and execute that instead:  

```sh
#! /bin/sh
cd /my_folder \
&& rm *.jar \
&& svn co path to repo \
&& mvn compile package install
```

(The backslashes at the end of the line are there to prevent the shell from thinking that the next line is a new command; if you omit the backslashes, you would need to write the whole command in a single line.)  

Save that to a file, for example `myscript`, and make it executable:  

```sh
chmod +x myscript
```

You can now execute that script like other programs on the machine. But if you don't place it inside a directory listed in your `PATH` environment variable (for example `/usr/local/bin`, or on some Linux distributions `~/bin`), then you will need to specify the path to that script. If it's in the current directory, you execute it with:  

```sh
./myscript
```

The commands in the script work the same way as the commands in the first example; the next command only executes if the previous one succeeded. For unconditional execution of all commands, simply list each command on its own line:  

```sh
#! /bin/sh
cd /my_folder
rm *.jar
svn co path to repo
mvn compile package install
```

#### Answer 2 (score 44)
I've found that using ; to separate commands only works in the foreground.  eg :  

<p>`cmd1; cmd2; cmd3 &amp;`  -  will only execute `cmd3` in the background, whereas
`cmd1 &amp;&amp; cmd2 &amp;&amp; cmd3 &amp;` - will execute the entire chain in the background IF there are no errors. </p>

To cater for unconditional execution, using parenthesis solves this :  

`(cmd1; cmd2; cmd3) &amp;` - will execute the chain of commands in the background, even if any step fails.  

#### Answer 3 (score 10)
You can separate your commands using a semi colon:  

```sh
cd /my_folder;rm *.jar;svn co path to repo;mvn compile package install
```

Was that what you mean?  

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Automatically enter SSH password with script (score [471660](https://stackoverflow.com/q/12202587) in 2017)

#### Question
I need to create a script that automatically inputs a password to OpenSSH `ssh` client.  

Let's say I need to SSH into `myname@somehost` with the password `a1234b`.  

I've already tried...  

```sh
#~/bin/myssh.sh
ssh myname@somehost
a1234b
```

...but this does not work.  

How can I get this functionality into a script?  

#### Answer 2 (score 248)
First you need to install <a href="http://sourceforge.net/projects/sshpass/" rel="noreferrer">sshpass</a>.  

<ul>
<li>Ubuntu/Debian: `apt-get install sshpass`  </li>
<li>Fedora/CentOS: `yum install sshpass`  </li>
<li>Arch: `pacman -S sshpass`</li>
</ul>

<hr>

<strong>Example:</strong>  



```sh
sshpass -p "YOUR_PASSWORD" ssh -o StrictHostKeyChecking=no YOUR_USERNAME@SOME_SITE.COM
```

<strong>Custom port example:</strong>  

```sh
sshpass -p "YOUR_PASSWORD" ssh -o StrictHostKeyChecking=no YOUR_USERNAME@SOME_SITE.COM:2400
```

<strong>Notes:</strong>  

<ul>
<li>`sshpass` can also read a password from a file when the `-f` flag is passed.

<ul>
<li>Using `-f` prevents the password from being visible if the `ps` command is executed.</li>
<li>The file that the password is stored in should have secure permissions.</li>
</ul></li>
</ul>

#### Answer 3 (score 81)
After looking for an answer for the question for months, I finally found a better solution: writing a simple script.  

```sh
#!/usr/bin/expect

set timeout 20

set cmd [lrange $argv 1 end]
set password [lindex $argv 0]

eval spawn $cmd
expect "assword:"
send "$password\r";
interact
```

Put it to `/usr/bin/exp`, then you can use:  

<ul>
<li>`exp &lt;password&gt; ssh &lt;anything&gt;`</li>
<li>`exp &lt;password&gt; scp &lt;anysrc&gt; &lt;anydst&gt;`</li>
</ul>

Done!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: Easily measure elapsed time (score [469449](https://stackoverflow.com/q/2808398) in 2013)

#### Question
I am trying to use <a href="http://en.cppreference.com/w/cpp/chrono/c/time" rel="noreferrer">time()</a> to measure various points of my program.  

What I don't understand is why the values in the before and after are the same?  I understand this is not the best way to profile my program, I just want to see how long something take.    

```sh
printf("**MyProgram::before time= %ld\n", time(NULL));

doSomthing();
doSomthingLong();

printf("**MyProgram::after time= %ld\n", time(NULL));
```

I have tried:  

```sh
struct timeval diff, startTV, endTV;

gettimeofday(&startTV, NULL); 

doSomething();
doSomethingLong();

gettimeofday(&endTV, NULL); 

timersub(&endTV, &startTV, &diff);

printf("**time taken = %ld %ld\n", diff.tv_sec, diff.tv_usec);
```

How do I read a result of `**time taken = 0 26339`?  Does that mean 26,339 nanoseconds = 26.3 msec?  

What about `**time taken = 4 45025`, does that mean 4 seconds and 25 msec?  

#### Answer 2 (score 263)
```sh
#include <ctime>

void f() {
  using namespace std;
  clock_t begin = clock();

  code_to_time();

  clock_t end = clock();
  double elapsed_secs = double(end - begin) / CLOCKS_PER_SEC;
}
```

The `time()` function is only accurate to within a second, but there are <a href="http://en.cppreference.com/w/cpp/chrono/c/CLOCKS_PER_SEC" rel="noreferrer">`CLOCKS_PER_SEC`</a> "clocks" within a second.  This is an easy, portable measurement, even though it's over-simplified.  

#### Answer 3 (score 261)
You can <strong>abstract the time measuring mechanism</strong> and have each callable's run time measured with <strong>minimal extra code</strong>, just by being called through a timer structure. Plus, at compile time you can <strong>parametrize the timing type</strong> (milliseconds, nanoseconds etc).   

<p><sup>Thanks to the review by <a href="https://stackoverflow.com/users/14065/loki-astari">Loki Astari</a> and the suggestion to use variadic templates.</sup>
<sup><a href="https://stackoverflow.com/q/31253334/2567683">This</a> is why the forwarded function call.</sup></p>

```sh
#include <iostream>
#include <chrono>

template<typename TimeT = std::chrono::milliseconds>
struct measure
{
    template<typename F, typename ...Args>
    static typename TimeT::rep execution(F&& func, Args&&... args)
    {
        auto start = std::chrono::steady_clock::now();
        std::forward<decltype(func)>(func)(std::forward<Args>(args)...);
        auto duration = std::chrono::duration_cast< TimeT> 
                            (std::chrono::steady_clock::now() - start);
        return duration.count();
    }
};

int main() {
    std::cout << measure<>::execution(functor(dummy)) << std::endl;
}
```

<a href="http://ideone.com/JbUkPq" rel="noreferrer"><kbd><strong>Demo</strong></kbd></a>  

According to the comment by <a href="https://stackoverflow.com/users/576911/howard-hinnant"><strong>Howard Hinnant</strong></a> it's best not to escape out of the chrono system until we have to. So the above class could give the user the choice to call `count` manually by providing an extra static method (shown in C++14)  

```sh
template<typename F, typename ...Args>
static auto duration(F&& func, Args&&... args)
{
    auto start = std::chrono::steady_clock::now();
    std::forward<decltype(func)>(func)(std::forward<Args>(args)...);
    return std::chrono::duration_cast<TimeT>(std::chrono::steady_clock::now()-start);
} 

// call .count() manually later when needed (eg IO)
auto avg = (measure<>::duration(func) + measure<>::duration(func)) / 2.0;
```

and be most useful for clients that   

<blockquote>
  "want to post-process a bunch of durations prior to I/O (e.g. average)"  
</blockquote>

<hr>

The complete <a href="https://github.com/picanumber/bureaucrat/blob/master/time_lapse.h" rel="noreferrer"><strong>code can be found here</strong></a>. My attempt to build a <strong>benchmarking tool</strong> based on chrono is recorded <a href="https://isocpp.org/blog/2015/04/https-ngathanasiou.wordpress.com-2015-04-01-benchmarking-in-c" rel="noreferrer"><strong>here</strong></a>.  

<hr>

If C++17's <a href="http://en.cppreference.com/w/cpp/utility/functional/invoke" rel="noreferrer">`std::invoke`</a> is available, the invocation of the callable in `execution` could be done like this :   

```sh
invoke(forward<decltype(func)>(func), forward<Args>(args)...);
```

to provide for callables that are pointers to member functions.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: Extract file basename without path and extension in bash (score [465033](https://stackoverflow.com/q/2664740) in 2017)

#### Question
Given file names like these:  

```sh
/the/path/foo.txt
bar.txt
```

I hope to get:  

```sh
foo
bar
```

Why this doesn't work?  

```sh
#!/bin/bash

fullfile=$1
fname=$(basename $fullfile)
fbname=${fname%.*}
echo $fbname
```

What's the right way to do it?  

#### Answer accepted (score 587)
You don't have to call the external `basename` command. Instead, you could use the following commands:  

```sh
$ s=/the/path/foo.txt
$ echo ${s##*/}
foo.txt
$ s=${s##*/}
$ echo ${s%.txt}
foo
$ echo ${s%.*}
foo
```

Note that this solution should work in all recent (<em>post 2004</em>) <em>POSIX</em> compliant shells, (e.g. `bash`, `dash`, `ksh`, etc.).  

Source: <a href="http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02" rel="noreferrer">Shell Command Language 2.6.2 Parameter Expansion</a>  

More on bash String Manipulations:  <a href="http://tldp.org/LDP/LG/issue18/bash.html" rel="noreferrer">http://tldp.org/LDP/LG/issue18/bash.html</a>  

#### Answer 2 (score 267)
The <a href="http://opengroup.org/onlinepubs/007908799/xcu/basename.html">basename</a> command has two different invocations; in one, you specify just the path, in which case it gives you the last component, while in the other you also give a suffix that it will remove. So, you can simplify your example code by using the second invocation of basename. Also, be careful to correctly quote things:  

<pre>
fbname=$(basename "$1" .txt)
echo "$fbname"
</pre>

#### Answer 3 (score 57)
A combination of basename and cut works fine, even in case of double ending like `.tar.gz`:  

```sh
fbname=$(basename "$fullfile" | cut -d. -f1)
```

Would be interesting if this solution needs less arithmetic power than Bash Parameter Expansion.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: Find all storage devices attached to a Linux machine (score [460866](https://stackoverflow.com/q/200960) in 2013)

#### Question
I have a need to find all of the writable storage devices attached to a given machine, <strong>whether or not</strong> they are mounted.  

The dopey way to do this would be to <em>try</em> every entry in `/dev` that corresponds to a writable devices (`hd* and sd*`)......  

Is there a better solution, or should I stick with this one?  

#### Answer accepted (score 78)
`/proc/partitions` will list all the block devices and partitions that the system recognizes.  You can then try using `file -s &lt;device&gt;` to determine what kind of filesystem is present on the partition, if any.  

#### Answer 2 (score 71)
You can always do `fdisk -l` which seems to work pretty well, even on strange setups such as EC2 xvda devices.  

Here is a dump for a m1.large instance:  

```sh
root@ip-10-126-247-82:~# fdisk -l

Disk /dev/xvda1: 10.7 GB, 10737418240 bytes
255 heads, 63 sectors/track, 1305 cylinders, total 20971520 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

Disk /dev/xvda1 doesn't contain a valid partition table

Disk /dev/xvda2: 365.0 GB, 365041287168 bytes
255 heads, 63 sectors/track, 44380 cylinders, total 712971264 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

Disk /dev/xvda2 doesn't contain a valid partition table

Disk /dev/xvda3: 939 MB, 939524096 bytes
255 heads, 63 sectors/track, 114 cylinders, total 1835008 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

Disk /dev/xvda3 doesn't contain a valid partition table
```

While `mount` says:  

```sh
root@ip-10-126-247-82:~# mount
/dev/xvda1 on / type ext4 (rw)
proc on /proc type proc (rw,noexec,nosuid,nodev)
sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
fusectl on /sys/fs/fuse/connections type fusectl (rw)
none on /sys/kernel/debug type debugfs (rw)
none on /sys/kernel/security type securityfs (rw)
udev on /dev type devtmpfs (rw,mode=0755)
devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
tmpfs on /run type tmpfs (rw,noexec,nosuid,size=10%,mode=0755)
none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=5242880)
none on /run/shm type tmpfs (rw,nosuid,nodev)
/dev/xvda2 on /mnt type ext3 (rw)
```

And `/proc/partitions` says:  

```sh
root@ip-10-126-247-82:~# cat /proc/partitions
major minor  #blocks  name

 202        1   10485760 xvda1
 202        2  356485632 xvda2
 202        3     917504 xvda3
```

<h5>Side Note</h1>

How `fdisk -l` works is something I would love to know myself.  

#### Answer 3 (score 35)
you can also try <strong>lsblk</strong> ... is in util-linux ... but i have a question too  

```sh
fdisk -l /dev/sdl
```

no result  

```sh
grep sdl /proc/partitions      
   8      176   15632384 sdl
   8      177   15628288 sdl1

lsblk | grep sdl
sdl       8:176  1  14.9G  0 disk  
`-sdl1    8:177  1  14.9G  0 part  
```

fdisk is good but not that good ... seems like it cannot "see" everything  

in my particular example i have a stick that have also a card reader build in it and i can see only the stick using fdisk:  

```sh
fdisk -l /dev/sdk

Disk /dev/sdk: 15.9 GB, 15931539456 bytes
255 heads, 63 sectors/track, 1936 cylinders, total 31116288 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xbe24be24

   Device Boot      Start         End      Blocks   Id  System
/dev/sdk1   *        8192    31116287    15554048    c  W95 FAT32 (LBA)
```

but not the card (card being /dev/sdl)  

also, file -s is inefficient ...   

```sh
file -s /dev/sdl1
/dev/sdl1: sticky x86 boot sector, code offset 0x52, OEM-ID "NTFS    ", sectors/cluster 8, reserved sectors 0, Media descriptor 0xf8, heads 255, hidden sectors 8192, dos < 4.0 BootSector (0x0)
```

that's nice ... BUT  

```sh
fdisk -l /dev/sdb
/dev/sdb1            2048   156301487    78149720   fd  Linux raid autodetect
/dev/sdb2       156301488   160086527     1892520   82  Linux swap / Solaris

file -s /dev/sdb1
/dev/sdb1: sticky \0
```

to see information about a disk that cannot be accesed by fdisk, you can use parted:  

```sh
parted /dev/sdl print

Model: Mass Storage Device (scsi)
Disk /dev/sdl: 16.0GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type     File system  Flags
 1      4194kB  16.0GB  16.0GB  primary  ntfs




arted /dev/sdb print 
Model: ATA Maxtor 6Y080P0 (scsi)
Disk /dev/sdb: 82.0GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type     File system     Flags
 1      1049kB  80.0GB  80.0GB  primary                  raid
 2      80.0GB  82.0GB  1938MB  primary  linux-swap(v1)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Get current time in seconds since the Epoch on Linux, Bash (score [459374](https://stackoverflow.com/q/1092631) in 2018)

#### Question
I need something simple like `date`, but in seconds since 1970 instead of the current date, hours, minutes, and seconds.  

`date` doesn't seem to offer that option. Is there an easy way?  

#### Answer accepted (score 1026)
This should work:  

```sh
date +%s
```

#### Answer 2 (score 119)
<p>Just to add.<br><BR>
Get the seconds since epoch(Jan 1 1970) for any given date(e.g Oct 21 1973).</p>

```sh
date -d "Oct 21 1973" +%s
```

<p><br>
 Convert the number of seconds back to date</p>

```sh
date --date @120024000
```

<p><br>
  The command `date` is pretty versatile. Another cool thing you can do with date(shamelessly copied from `date --help`).
  Show the local time for 9AM next Friday on the west coast of the US</p>

```sh
date --date='TZ="America/Los_Angeles" 09:00 next Fri'
```

<p>Better yet, take some time to read the man page 
<a href="http://man7.org/linux/man-pages/man1/date.1.html" rel="noreferrer">http://man7.org/linux/man-pages/man1/date.1.html</a></p>

#### Answer 3 (score 36)
So far, all the answers use the external program `date`.  

Since Bash 4.2, `printf` has a new modifier `%(dateformat)T` that, when used with argument `-1` outputs the current date with format given by `dateformat`, handled by `strftime(3)` (`man 3 strftime` for informations about the formats).  

So, for a pure Bash solution:  

```sh
printf '%(%s)T\n' -1
```

or if you need to store the result in a variable `var`:  

```sh
printf -v var '%(%s)T' -1
```

No external programs and no subshells!  

Since Bash 4.3, it's even possible to not specify the `-1`:  

```sh
printf -v var '%(%s)T'
```

(but it might be wiser to always give the argument `-1` nonetheless).  

If you use `-2` as argument instead of `-1`, Bash will use the time the shell was started instead of the current date (but why would you want this?).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: How to add a default include path for GCC in Linux? (score [455167](https://stackoverflow.com/q/558803) in 2017)

#### Question
I'd like gcc to include files from `$HOME/include` in addition to the usual include directories, but there doesn't seem to be an analogue to `$LD_LIBRARY_PATH`.  

I know I can just add the include directory at command line when compiling (or in the makefile), but I'd really like a universal approach here, as in the library case.  

#### Answer accepted (score 365)
Try setting `C_INCLUDE_PATH` (for C header files) or `CPLUS_INCLUDE_PATH` (for C++ header files).  

As Ciro mentioned, `CPATH` will set the path for both C and C++.  

More details <a href="http://www.network-theory.co.uk/docs/gccintro/gccintro_23.html" rel="noreferrer">here</a>.  

#### Answer 2 (score 53)
Create an alias for gcc with your favorite includes.  

```sh
alias mygcc='gcc -I /whatever/'
```

#### Answer 3 (score 7)
A gcc spec file can do the job, however all users on the machine will be affected.  

See <a href="http://www.mingw.org/node/25" rel="noreferrer">here</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: How to replace a string in multiple files in linux command line (score [453048](https://stackoverflow.com/q/11392478) in 2017)

#### Question
I need to replace a string in a lot of files in a folder, with only `ssh` access to the server. How can I do this?  

#### Answer accepted (score 519)
```sh
cd /path/to/your/folder
sed -i 's/foo/bar/g' *
```

Occurrences of "foo" will be replaced with "bar".  

#### Answer 2 (score 218)
Similar to Kaspar's answer but with the g flag to replace all the occurrences on a line.   

```sh
find ./ -type f -exec sed -i 's/string1/string2/g' {} \;
```

For global case insensitive:  

```sh
find ./ -type f -exec sed -i 's/string1/string2/gI' {} \;
```

#### Answer 3 (score 128)
@kev's answer is good, but only affects files in the immediate directory.The example below uses grep to recursively find files. It works for me everytime.  

```sh
grep -rli 'old-word' * | xargs -i@ sed -i 's/old-word/new-word/g' @
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: Pipe to/from the clipboard in Bash script (score [452594](https://stackoverflow.com/q/749544) in 2018)

#### Question
Is it possible to pipe to/from the clipboard in Bash?  

Whether it is piping to/from a device handle or using an auxiliary application, I can't find anything.  

For example, if `/dev/clip` was a device linking to the clipboard we could do:  

```sh
cat /dev/clip        # Dump the contents of the clipboard
cat foo > /dev/clip  # Dump the contents of "foo" into the clipboard
```

#### Answer accepted (score 793)
There's a wealth of clipboards you could be dealing with.  I expect you're probably a Linux user who wants to put stuff in the X Windows primary clipboard.  Usually, the clipboard you want to talk to has a utility that lets you talk to it.  

In the case of X, there's `xclip` (and others). `xclip -selection c` will send data to the clipboard that works with <kbd>Ctrl + C</kbd>, <kbd>Ctrl + V</kbd> in most applications.  

If you're on Mac OS X, there's `pbcopy`.  

If you're in Linux terminal mode (no X) then look into `gpm` or <a href="http://www.gnu.org/software/screen/" rel="noreferrer">screen</a> which has a clipboard.  Try the `screen` command `readreg`.  

Under Windows 10+ or cygwin, use `/dev/clipboard` or `clip`.  

#### Answer 2 (score 257)
<p>Make sure you are using alias `xclip="xclip -selection c"`
otherwise you can't just use to <kbd>Ctrl</kbd>+<kbd>v</kbd> to paste it back in a different place.</p>

```sh
echo test | xclip    
```

<kbd>Ctrl</kbd>+<kbd>v</kbd> `=== test`  

#### Answer 3 (score 165)
<h5>Install</h1>

```sh
# You can install xclip using `apt-get`
apt-get install xclip

# or `pacman`
pacman -S xclip

# or `dnf`
dnf install xclip
```

If you do not have access to `apt-get` nor `pacman`, nor `dnf`, the sources are available on <a href="http://sourceforge.net/projects/xclip/" rel="noreferrer">sourceforge</a>.  

<h5>Set-up</h1>

<h5>Bash</h2>

In `~/.bash_aliases`, add:  

```sh
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"
```

<em>Do not forget to load your new configuration using `. ~/.bash_aliases` or by restarting your profile.</em>  

<h5>Fish</h2>

In `~/.config/fish/config.fish`, add:  

```sh
abbr setclip "xclip -selection c"
abbr getclip "xclip -selection c -o"
```

<em>Do not forget to restart your fish instance by restarting your terminal for changes to apply.</em>  

<h5>Usage</h1>

You can now use `setclip` and `getclip`, e.g:  

```sh
$ echo foo | setclip
$ getclip
foo
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: How to recursively download a folder via FTP on Linux (score [452057](https://stackoverflow.com/q/113886) in 2016)

#### Question
I'm trying to ftp a folder using the command line ftp client, but so far I've only been able to use 'get' to get individual files.   

#### Answer accepted (score 604)
You could rely on wget which usually handles ftp get properly (at least in my own experience). For example:  

```sh
wget -r ftp://user:pass@server.com/
```

You can also use `-m` which is suitable for mirroring. It is currently equivalent to `-r -N -l inf`.  

If you've some special characters in the credential details, you can specify the `--user` and `--password` arguments to get it to work. Example with custom login with specific characters:  

```sh
wget -r --user="user@login" --password="Pa$$wo|^D" ftp://server.com/
```

<p><strong>EDIT</strong>
As pointed out by @asmaier, watch out that even if `-r` is for recursion, it has a default max level of 5:</p>

<blockquote>
```sh
       -r
       --recursive
           Turn on recursive retrieving.

       -l depth
       --level=depth
           Specify recursion maximum depth level depth.  The default maximum depth is 5.
```
</blockquote>

If you don't want to miss out subdirs, better use the mirroring option, `-m`:  

<blockquote>
```sh
       -m
       --mirror
           Turn on options suitable for mirroring.  This option turns on recursion and time-stamping, sets infinite
           recursion depth and keeps FTP directory listings.  It is currently equivalent to -r -N -l inf
           --no-remove-listing.
```
</blockquote>

#### Answer 2 (score 159)
Just to complement the answer given by Thibaut Barrère.  

I used  

```sh
wget -r -nH --cut-dirs=5 -nc ftp://user:pass@server//absolute/path/to/directory
```

Note the double slash after the server name. If I don't put an extra slash the path is relative to the home directory of user.  

<ul>
<li>-nH avoids the creation of a directory named after the server name</li>
<li>-nc avoids creating a new file if it already exists on the destination (it is just skipped)   </li>
<li>--cut-dirs=5 allows me to take the content of /absolute/path/to/directory and to put it in the directory where I launch wget. The number 5 is used to filter out the 5 components of the path. The double slash means an extra component.</li>
</ul>

#### Answer 3 (score 25)
```sh
ncftp -u <user> -p <pass> <server>
ncftp> mget directory
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Count number of files within a directory in Linux? (score [451411](https://stackoverflow.com/q/20895290) in 2018)

#### Question
To count the number of files in a directory, I typically use  

```sh
ls directory | wc -l
```

But is there another command that doesn't use `wc` ?  

#### Answer accepted (score 430)
this is one:    

```sh
ls -l . | egrep -c '^-'
```

Note:  

```sh
ls -1 | wc -l
```

<p>Which means:
`ls:` list files in dir </p>

`-1:` (that's a ONE) only one entry per line. Change it to -1a if you want hidden files too  

`| :` pipe output onto...  

`wc:` "wordcount"  

`-l:` count `l`ines.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Exploring Docker container's file system (score [448919](https://stackoverflow.com/q/20813486) in 2017)

#### Question
I've noticed with docker that I need to understand what's happening inside a container or what files exist in there. One example is downloading images from the docker index - you don't have a clue what the image contains so it's impossible to start the application.  

What would be ideal is to be able to ssh into them or equivalent. Is there a tool to do this, or is my conceptualisation of docker wrong in thinking I should be able to do this.  

#### Answer accepted (score 634)
<strong>Method 1: snapshoting</strong>  

You can evaluate container filesystem this way:  

```sh
# find ID of your running container:
docker ps

# create image (snapshot) from container filesystem
docker commit 12345678904b5 mysnapshot

# explore this filesystem using bash (for example)
docker run -t -i mysnapshot /bin/bash
```

This way, you can evaluate filesystem of the running container in the precise time moment. Container is still running, no future changes are included.  

You can later delete snapshot using (filesystem of the running container is not affected!):  

```sh
docker rmi mysnapshot
```

<strong>Method 2: ssh</strong>  

If you need continuous access, you can install sshd to your container and run the sshd daemon:  

```sh
 docker run -d -p 22 mysnapshot /usr/sbin/sshd -D

 # you need to find out which port to connect:
 docker ps
```

This way, you can run your app using ssh (connect and execute what you want).  

<strong>UPDATE - Method 3: nsenter</strong>  

Use `nsenter`, see <a href="http://blog.docker.com/2014/06/why-you-dont-need-to-run-sshd-in-docker/" rel="nofollow noreferrer">http://blog.docker.com/2014/06/why-you-dont-need-to-run-sshd-in-docker/</a>  

<blockquote>
  <p><em>The short version is: with nsenter, you can get a shell into an
  existing container, even if that container doesn’t run SSH or any kind
  of special-purpose daemon</em></p>
</blockquote>

<strong>UPDATE - Method 4: docker exec</strong>  

Docker version 1.3 or newer supports the command `exec` that behave similar to `nsenter`. This command can run new process in already running container (container must have PID 1 process running already). You can run `/bin/bash` to explore container state:  

```sh
docker exec -t -i mycontainer /bin/bash
```

see <a href="https://docs.docker.com/v1.3/reference/commandline/cli/#exec" rel="nofollow noreferrer">Docker command line documentation</a>  

#### Answer 2 (score 216)
<strong>UPDATE: EXPLORING!</strong>  

This command should let you <strong>explore a running docker container</strong>:  

```sh
docker exec -it name-of-container bash
```

The equivalent for this in docker-compose would be:  

```sh
docker-compose exec web bash
```

(web is the name-of-service in this case and it has tty by default.)  

Once you are inside do:  

```sh
ls -lsa
```

or any other bash command like:  

```sh
cd ..
```

<hr>

This command should let you <strong>explore a docker image</strong>:  

```sh
docker run --rm -it --entrypoint=/bin/bash name-of-image
```

once inside do:  

```sh
ls -lsa
```

or any other bash command like:  

```sh
cd ..
```

The `-it` stands for interactive... and tty.  

<hr>

This command should let you <strong>inspect a running docker container or image</strong>:  

`docker inspect name-of-container-or-image`  

You might want to do this and find out if there is any `bash` or `sh` in there. Look for entrypoint or cmd in the json return.  

see <a href="https://docs.docker.com/engine/reference/commandline/exec/#usage" rel="noreferrer">docker exec documentation</a>  

see <a href="https://docs.docker.com/compose/reference/exec/" rel="noreferrer">docker-compose exec documentation</a>  

see <a href="https://docs.docker.com/engine/reference/commandline/inspect/" rel="noreferrer">docker inspect documentation</a>  

#### Answer 3 (score 145)
You may archive your container' filesystem into tar file:  

```sh
docker export adoring_kowalevski > contents.tar
```

This way works even if your container is stopped and doesn't have any shell program like `/bin/bash`. I mean images like hello-world from <a href="https://docs.docker.com/installation/ubuntulinux/#installing-docker-on-ubuntu" rel="noreferrer">Docker documentation</a>.  
</section>

