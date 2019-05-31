# Fac dumped from https://wiki.termux.com/wiki/FAQ

```
General questions
Can I contribute?

Yes, contributions are welcome. Termux is an open source application and it is built on users' contributions.

You can browse source code for all Termux parts on Github. However, main components are:

    Termux-app - source code for the Termux application.
    termux-packages - scripts and build environment for the packages.

If you want to request a particular package or submit a bug report, please, open an issue on termux-packages/issues.

Application-related suggestions and bug reports should be submitted to termux-app/issues.
Can I do hacking with Termux?

Main Article: Hacking


Yes, you can.

We have some tools which can help you in hacking like hydra (brute force tool) or nmap (network scanner). We have bunch of compilers (Clang, Rust, Go, etc...) and interpreters (Bash, Perl, Python, etc...). Reverse engineering tool radare2 is available too. Also, Termux can run metasploit-framework which enables Termux users to do some serious hacking stuff!

The tools like aircrack-ng or tcpdump can be found in Termux Root Packages repository. How to enable it, see in Package_Management#Installing_root_packages. But note that Aircrack-ng requires wifi monitor mode which is not available for the most devices.


Important note: We are not teaching how to hack/crack someone or something. We are not hacking/cracking something or someone by request. Just remember - hacking without permission is illegal!

Our official community pages are moderated. All questions like How to hack wifi?, How to hack facebook account?, Can you teach me how to use brute/crack/hack tool ? will be deleted.


Warning: There are a lot "Termux hacking tutorials" on the Internet which provide suspicious software meant to be used as hacking tools. Most of them are done for clickbait and are not working in real world. Some of them force user to install malware on their devices. We are not responsible about broken Termux installations, bricked devices and lost data.
Can Termux be installed on Android <5?

Termux is only available on Android 5.0 or later.

See https://github.com/termux/termux-app/issues/6 for more information.
How do I get help about Termux?

This wiki is a good start to the basics of Termux. Other options include:

    IRC: Channel #Termux on freenode that is mirrored with Gitter.
    Github: Submit bug reports regarding the main app, packages, and addons. Create pull requests for your solutions.
    Gitter: Chatroom that is mirrored with IRC.
    Reddit: Reddit community, ask general questions here.

Consider researching Termux on the Internet too, e.g. Termux site:github.com
I'm a beginner. For what I can use Termux ?

For same purposes as any of the Linux distributions.

You may want to take a look at Bash guide to learn how to use shell. Also, browse the Termux Wiki to learn more about Termux's application usage.


If you searching for specific package, use command pkg search {pkg_name} with changing '{pkg_name}' to the actual name of package. Install needed packages with pkg install {pkg_name}. For example, if you are interested in programming, you may want to try packages like python, nodejs, ruby, clang and others. Code (text) editors are also available: vim, nano, micro, etc...


See related articles:

    Development Environments
    Differences from Linux
    Package Management

Is Termux down?

Is Termux down? I'm getting this error:

    Unable to install

    Termux was unable to install the bootstrap packages.

    Check your network connections and try again


This happens when a new installation cannot connect with the website for some reason to download and install the bootstrap packages. If this message keeps repeating upon consecutive attempts, try resetting your network connections:

1. Turn the airplane mode on.

2. Wait a while.

3. Turn it back off. Make sure that wifi and/or mobile network are enabled.

4. Then tap the Termux icon again.


There are little amount of users that don't have Internet access to the Termux repositories. There are 2 main reasons why this happens:

    Bad ISP. There may be various issues such as domain spoofing or resource IP address/subnet blocking (censorship).

    CloudFlare blacklisted your IP address due to outgoing attack.

All 2 cases listed above can be solved by VPN. Note that IPs of free VPNs may be blacklisted.
What is a Termux ?

Termux is a terminal emulator for Android. It's key difference from other terminal emulators is its own package repository with huge set of various utilities.

Terminal emulator is a program that provides a text-based interface to the shell. For more information, check a Wikipedia page.
Application
How do I use my storage in Termux?

To grant storage permissions in Android goto Settings>Apps>Termux>Permissions and select storage, then run termux-setup-storage in Termux.

Learn more at Internal and external storage.
I have low available space, can Termux be installed to the external SD card ?

No.

External SD cards usually are formatted in FAT32 or exFAT file systems which don't have support for unix permissions (chmod/chown) and special files such as sockets or symlinks. Also, Android enforces noexec mount option for user's storage, so you won't be able to execute binaries.
Is buttons like 'ctrl' or 'esc' are available in Termux ?

Main Article: Touch Keyboard


Yes. You may want to check the Touch Keyboard page to learn about available key combinations and how to enable extra keys row.
Output when attempting to install any addon, "Cannot install due to unknown error".

All Termux addons needs to be signed with the same key, which means that you should install Termux from Google Play and termux-styling from Google Play too, not vice versa between F-Droid and Google Play since the main app and the addons use the same key for signing.
Where is the help in the app?

Long press for the context menu to appear anywhere in the terminal: Tap MORE and select Help from the menu.

See http://tldp.org/LDP/intro-linux/html/sect_02_02.html for Absolute Basics Linux Quickstart.
Why Termux has read only access to the external SD card ?

On recent Android versions, the write access to the external SD card is done over Storage Access Framework. It is not possible to provide it's API to the command line programs.


There several solutions:

    Use root for putting necessary files to external SD.
    Use custom ROMs. Some of them have disabled SD card access restriction, so you can freely access your external SD card.
    Use a Termux private directory on the external SD card. Usually, it's path should be /storage/XXXX-XXXX/Android/data/com.termux.

Packages
Why I'm getting warnings about DT_FLAGS_1=0x8 ? Is something broken ?

Nothing broken, just linker warns that it is not able to handle RTLD_NODELETE section in ELF file. It does not harm anything and happens only on Android 5 devices.

To make this warning disappear you need to use utility "termux-elf-cleaner" on all binaries under $PREFIX:

pkg install findutils termux-elf-cleaner
find $PREFIX/bin $PREFIX/lib -type f -exec "termux-elf-cleaner" "{}" \;

Though, for now it is known that only $PREFIX/lib/libcrypto.so and $PREFIX/lib/libssl.so produce this warning.
Can I install all the Termux packages?

Probably no, some packages are known to conflict with each other, e.g. Dropbear and OpenSSH. But you can still install most of packages, this will take approximately 3.5 GB of space on internal storage.


1. Use apt install * in an empty directory. This will produce an error, and this is exactly the result you want for step one. Study the output to find out conflicting packages, then find a way to select only packages that don't cause conflicts.


2. Install using file globbing. For example apt install [a-h]* will install all packages that begin with the letters a-h. But this will probably cause conflicts too.
How do I get help about a specific package?

Usually packagename -h will display a basic help about usage.

Also install the man tool to view the manual pages of various tools. Use pkg install man to install man. Typing man man or man info might help beginning and advanced users alike. For example, man busybox will output the manual page for the package 'busybox'.


Tips, when reading man page:

    Use q to quit man.
    Use space for next page
    /search for search
    n for repeat search

I need to downgrade package. How I can do that ?

Termux does not provide older package versions. This is what called "rolling-release".

You can try to compile a package with specific version yourself. Scripts and build environment are located on Github in termux-packages repository.
I updated termux packages as root and now I'm getting 'permission denied' as a non-root user.

The core issue is trying to manipulate files that were modified as a superuser. This is likely an SELinux context issue, which can be confirmed by checking that the output of /system/bin/getenforce is 'Enforcing'.

For individual files, we can fix the file context in root (restorecon <file-name>) and revert ownership of the affected file (chown <user>:<group> <file-name>). Note that <user> and <group> are found by running id as a non-root user. In case many files are affected (e.g. due to updating packages), change directory to /data/data/com.termux/ and run restorecon -R . and chown -R <user>:<group> . to recursively apply the changes.
Termux has only few packages. Can I use a Debian repositories instead of Termux one ?

No, you can't.

There a major differences between Termux and regular Linux distributions and packages from these repositories won't work. See Differences from Linux for more information.


If you need a package, you can request it in termux-packages/issues.
Termux environment
Can I run other Linux distributions in Termux?

Yes, see PRoot. The benefits of PRoot include running Linux operating systems in Termux on a smartphone and tablet in Android, Chromebook and Fire OS.
I want to use Termux packages in my own project, can I do that ?

Yes, you can. But make sure that your project won't violate any of the licenses.

It is highly recommended to recompile these packages because of hardcoded environment paths. Build environment and scripts you can find in termux-packages on Github.


Take a look on environment variables defined in build-package.sh:

    TERMUX_PREFIX - a path to the environment's root.
    TERMUX_ANDROID_HOME - a path to the home directory.
    TERMUX_PKG_API_LEVEL - a minimal Android API level.

and change them for your needs.
How do I fix a broken environment?

Main Article: Recover a broken environment


If the only output you see is [Process completed - press Enter] or a variation thereof, your Termux environment is broken. You can try to fix this problem using a Failsafe Session.

If you deleted or modified a binary in the $PREFIX, the best way will be to reinstall Termux or perform procedure described in Recover a broken environment: If the problem is not with the dotfiles.
How do I ssh in Termux?

Main Article: Remote Access#SSH


If you have installed OpenSSH daemon, you can start it with command sshd. Also, the "standard" SSH port in Termux is 8022. So, to connect to the Termux via SSH, you have to use command ssh -p 8022 {ip_address}, with substituting {ip_address} with actual remote device IP.

Note that Termux supports both password and public key authentication. All information can be found on Remote Access#SSH page.
Is Termux a complete Linux Environment?

Main Article: Differences from Linux


Yes, it is! But there are some differences from traditional Linux distributions.

Firstly, Termux is not an operating system, it's terminal application - a text-based interface to the shell. Secondly, Termux is a prefixed environment. It's directory structure is slightely different than one defined by FHS standard. I.e. in Linux distribution we have /bin, but in Termux it is $PREFIX/bin where $PREFIX is referring to /data/data/com.termux/files/usr. This makes a lot of difference in package installation and compilation.

See this "etc is in wrong place" discussion and Main Article: Differences from Linux for more directory structure and $PREFIX environment information.
Why do I keep getting '/bin/sh bad interpreter' error?

The error you are getting while executing third-party scripts would be something like :

{program_name} : ./Configure: /bin/{program} : bad interpreter: Permission denied

Terminal throws error as we don't have access to main /bin of android root directory (for non-rooted) , instead, we use prefixed bin ie $PREFIX/bin.

first line of the script:

#!/bin/{program} 


There are three ways to fix this :

    Install termux-exec by using pkg install termux-exec. After installation it won’t affect the current session, but every future session should work without any setup.

    Use termux-fix-shebang from termux-tools to change the shebang line.

Which will change /bin/{program} to $PREFIX/bin/{program}.

    Use termux-chroot from proot to setup a chroot mimicking a normal Linux file system in Termux.

Why do I keep getting 'Exec format error' for binary copied from my computer?

You are trying to execute binary for different CPU architecture. I.e. it is not possible to execute x86 binaries on ARM or AArch64.

Recompile your binary for correct architecture with Android NDK and it should run fine. It is possible to check your current arch with command uname -m.
Why do I keep getting 'No such file or directory' when trying to execute binary (it's file exists) ?

This happens when you are executing binary compiled for Linux distribution, e.g. Ubuntu or Arch Linux. This is caused by ABI difference between GNU libc and Bionic libc.

Create a proper chroot (proot) environment and try to execute binary from it.
Why do I keep getting 'permission denied' when trying to launch a script?

If you have a problem running bash scripts read the following:

Both the internal shared storage (/sdcard,/storage/emulated/0) and external SD cards do not support executive permissions. You need to move your scripts to the $HOME directory of Termux and set the permissions (chmod +x <scriptname>) before you're able to run it. Alternatively you can call your script with an interpreter: python script.py, bash script.sh 
```
