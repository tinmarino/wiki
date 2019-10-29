---
title: Qt <- StackOverflow top 100
category: qt
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How to convert int to QString? (score [432339](https://stackoverflow.com/q/3211771) in 2015)

#### Question
Is there a `QString` function which takes an <strong>int</strong> and outputs it as a `QString`?  

#### Answer accepted (score 616)
Use <a href="http://doc.qt.io/qt-5/qstring.html#number" rel="noreferrer">`QString::number()`</a>:  

```c
int i = 42;
QString s = QString::number(i);
```

#### Answer 2 (score 116)
<p>And if you want to put it into string within some text context, forget about `+` operator. 
Simply do:</p>

```c
// Qt 5 + C++11
auto i = 13;    
auto printable = QStringLiteral("My magic number is %1. That's all!").arg(i);

// Qt 5
int i = 13;    
QString printable = QStringLiteral("My magic number is %1. That's all!").arg(i);

// Qt 4
int i = 13;    
QString printable = QString::fromLatin1("My magic number is %1. That's all!").arg(i);
```

#### Answer 3 (score 24)
<p>Moreover to convert whatever you want, you can use `QVariant`.
For an `int` to a `QString` you get:</p>

```c
QVariant(3).toString();
```

A `float` to a `string` or a `string` to a `float`:  

```c
QVariant(3.2).toString();
QVariant("5.2").toFloat();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: QLabel: set color of text and background (score [298574](https://stackoverflow.com/q/2749798) in 2012)

#### Question
How do I set color of text and background of a `QLabel` ?  

#### Answer accepted (score 247)
The best and recommended way is to use <a href="http://doc.qt.io/qt-5/stylesheet.html" rel="noreferrer">Qt Style Sheet</a>.  

To change the text color and background color of a `QLabel`, here is what I would do :  

```c
QLabel* pLabel = new QLabel;
pLabel->setStyleSheet("QLabel { background-color : red; color : blue; }");
```

You could also avoid using Qt Style Sheets and change the `QPalette` colors of your `QLabel`, but you might get different results on different platforms and/or styles.  

As Qt documentation states :   

<blockquote>
  Using a QPalette isn't guaranteed to work for all styles, because style authors are restricted by the different platforms' guidelines and by the native theme engine.  
</blockquote>

But you could do something like this :  

```c
 QPalette palette = ui->pLabel->palette();
 palette.setColor(ui->pLabel->backgroundRole(), Qt::yellow);
 palette.setColor(ui->pLabel->foregroundRole(), Qt::yellow);
 ui->pLabel->setPalette(palette);
```

But as I said, I strongly suggest not to use the palette and go for Qt Style Sheet.  

#### Answer 2 (score 33)
You can use QPalette, however you must set `setAutoFillBackground(true);` to enable background color  

```c
QPalette sample_palette;
sample_palette.setColor(QPalette::Window, Qt::white);
sample_palette.setColor(QPalette::WindowText, Qt::blue);

sample_label->setAutoFillBackground(true);
sample_label->setPalette(sample_palette);
sample_label->setText("What ever text");
```

It works fine on Windows and Ubuntu, I haven't played with any other OS.  

Note: Please see <a href="http://qt-project.org/doc/qt-4.8/qpalette.html" rel="noreferrer">QPalette</a>, color role section for more details  

#### Answer 3 (score 17)
I add this answer because I think it could be useful to anybody.  

I step into the problem of setting <a href="https://en.wikipedia.org/wiki/RGBA_color_space" rel="nofollow noreferrer">RGBA</a> colors (that is, RGB color with an Alpha value for transparency) for color display labels in  my painting application.  

As I came across the first answer, I was unable to set an RGBA color. I have also tried things like:   

`myLabel.setStyleSheet("QLabel { background-color : %s"%color.name())`   

where `color` is an RGBA color.  

So, my dirty solution was to extend `QLabel` and override `paintEvent()` method filling its bounding rect.  

Today, I've open up the `qt-assistant` and read the <a href="https://doc.qt.io/qt-5/stylesheet-reference.html#list-of-properties" rel="nofollow noreferrer">style reference properties list</a>. Affortunately, it has an example that states the following:  

`QLineEdit { background-color: rgb(255, 0, 0) }`  

Thats open up my mind in doing something like the code below, as an example:  

```c
myLabel= QLabel()
myLabel.setAutoFillBackground(True) # This is important!!
color  = QtGui.QColor(233, 10, 150)
alpha  = 140
values = "{r}, {g}, {b}, {a}".format(r = color.red(),
                                     g = color.green(),
                                     b = color.blue(),
                                     a = alpha
                                     )
myLabel.setStyleSheet("QLabel { background-color: rgba("+values+"); }")
```

Note that `setAutoFillBackground()` set in `False` will not make it work.  

Regards,  

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How to convert QString to std::string? (score [263024](https://stackoverflow.com/q/4214369) in 2015)

#### Question
I am trying to do something like this:  

```c
QString string;
// do things...
std::cout << string << std::endl;
```

<p>but the code doesn't compile.
How to output the content of qstring into the console (e.g. for debugging purposes or other reasons)? How to convert `QString` to `std::string`?</p>

#### Answer accepted (score 213)
One of the things you should remember when converting `QString` to `std::string` is the fact that `QString` is UTF-16 encoded while `std::string`... May have any encodings.  

So the best would be either:  

```c
QString qs;

// Either this if you use UTF-8 anywhere
std::string utf8_text = qs.toUtf8().constData();

// or this if you're on Windows :-)
std::string current_locale_text = qs.toLocal8Bit().constData();
```

The suggested (accepted) method may work if you specify codec.  

See: <a href="http://doc.qt.io/qt-5/qstring.html#toLatin1" rel="noreferrer">http://doc.qt.io/qt-5/qstring.html#toLatin1</a>  

#### Answer 2 (score 256)
You can use:  

```c
QString qs;
// do things
std::cout << qs.toStdString() << std::endl;
```

<a href="http://doc.qt.io/qt-5/qstring.html#toStdString" rel="noreferrer">Here's</a> reference documentation for `QString`.  

#### Answer 3 (score 35)
If your ultimate aim is to get debugging messages to the console, you can use <a href="http://doc.qt.io/qt-5/qdebug.html" rel="nofollow noreferrer">qDebug()</a>.  

You can use like,  

`qDebug()&lt;&lt;string;` which will print the contents to the <em>console</em>.  

This way is better than converting it into `std::string` just for the sake of debugging messages.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How to print to console when using Qt (score [247741](https://stackoverflow.com/q/3886105) in 2015)

#### Question
I'm using Qt4 and C++ for making some programs in computer graphics. I need to be able to print some variables in my console at run-time, not debugging, but `cout` doesn't seem to work even if I add the libraries. Is there a way to do this?  

#### Answer accepted (score 185)
If it is good enough to print to `stderr`, you can use the following streams originally intended for debugging:  

```c
#include<QDebug>

//qInfo is qt5.5+ only.
qInfo() << "C++ Style Info Message";
qInfo( "C Style Info Message" );

qDebug() << "C++ Style Debug Message";
qDebug( "C Style Debug Message" );

qWarning() << "C++ Style Warning Message";
qWarning( "C Style Warning Message" );

qCritical() << "C++ Style Critical Error Message";
qCritical( "C Style Critical Error Message" );

// qFatal does not have a C++ style method.
qFatal( "C Style Fatal Error Message" );
```

Though as pointed out in the comments, bear in mind qDebug messages are removed if `QT_NO_DEBUG_OUTPUT` is defined  

If you need stdout you could try something like this (as Kyle Strand has pointed out):  

```c
QTextStream& qStdOut()
{
    static QTextStream ts( stdout );
    return ts;
}
```

You could then call as follows:  

```c
qStdOut() << "std out!";
```

#### Answer 2 (score 145)
I found <a href="http://www.qtcentre.org/threads/33506-where-is-cout-in-Qt-Creator" rel="noreferrer">this</a> most useful:  

```c
#include <QTextStream>

QTextStream out(stdout);
foreach(QString x, strings)
    out << x << endl;
```

#### Answer 3 (score 33)
<h5>Writing to `stdout`</h3>

If you want something that, like `std::cout`, writes to your application's standard output, you can simply do <a href="http://www.qtcentre.org/threads/33506-where-is-cout-in-Qt-Creator" rel="noreferrer">the following</a> (<a href="https://stackoverflow.com/a/17649741/1858225">credit to CapelliC</a>):  

```c
QTextStream(stdout) << "string to print" << endl;
```

If you want to avoid creating a temporary `QTextStream` object, follow Yakk's suggestion in the comments below of creating a function to return a `static` handle for `stdout`:  

```c
inline QTextStream& qStdout()
{
    static QTextStream r{stdout};
    return r;
}

...

foreach(QString x, strings)
    qStdout() << x << endl;
```

<hr>

<strong>Remember</strong> to `flush` the stream periodically to ensure the output is actually printed.  

<h5>Writing to `stderr`</h3>

Note that the above technique can also be used for other outputs. However, there are more readable ways to write to `stderr` (<a href="https://stackoverflow.com/a/3886128/1858225">credit to Goz</a> and the comments below his answer):  

```c
qDebug() << "Debug Message";    // CAN BE REMOVED AT COMPILE TIME!
qWarning() << "Warning Message";
qCritical() << "Critical Error Message";
qFatal("Fatal Error Message");  // WILL KILL THE PROGRAM!
```

`qDebug()` is closed if `QT_NO_DEBUG_OUTPUT` is turned on at compile-time.  

(Goz notes in a comment that for non-console apps, these can print to a different stream than `stderr`.)  

<hr>

<strong>NOTE:</strong> All of the Qt print methods <a href="http://doc.qt.io/qt-5/qtextstream.html#operator-lt-lt-16" rel="noreferrer">assume that `const char*` arguments</a> are ISO-8859-1 encoded strings with terminating `\0` characters.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Qt 5.1.1: Application failed to start because platform plugin "windows" is missing (score [227971](https://stackoverflow.com/q/20495620) in 2017)

#### Question
<hr>

<p><strong>Edit:</strong>
Some people started to mark my question as a duplicate. Do not forget that many similar questions existed when I asked this one (see e.g. the list below). However, <strong>none of these answers solved my problem</strong>. After a long search I found <strong>a comment</strong> which had been ignored by all users pointing to the missing lib. Now, many months later, the comment has been changed to an answer. However, when I answered this question by msyself I intended to help other people by directly providing the solution. This should not be forgotten and so far my answer helped a lot of people. Therefore my question is definitely not a duplicate.  <strong>By the way: The accepted answer within the provided link on top does not solve the problem</strong>!</p>

<hr>

Yes, i used the search:  

<a href="https://stackoverflow.com/questions/17366967/failed-to-load-platform-plugin-windows-available-platforms-are-error">Failed to load platform plugin &quot;windows&quot;. Available platforms are : Error</a>  

<a href="https://stackoverflow.com/questions/18368826/deploying-qt-c-application-from-visual-studio-qwindows-dll-error">Deploying Qt C++ Application from Visual Studio qwindows.dll error</a>  

<a href="https://stackoverflow.com/questions/14963881/failed-to-load-platform-plugin-windows-available-platforms-are-windows-minim">failed to load platform plugin &quot;windows&quot; Available platforms are: windows, minimal</a>  

However, in my case the problem still persists. I am using Qt 5.1.1 with Visual Studio 2012 and developed my Application on Windows 7 with Qt Creator 2.8.1. Application is compiled in "Release"-mode and can be executed if directly started with Qt Creator.  

However, when starting from the "release"-Folder, i get the following message:  

<blockquote>
  <p>This application failed to start because it could not find or load the
  Qt platform plugin "windows".  Available platform plugins are:
  minimal, offscreen, windows.</p>
</blockquote>

Folder structure looks like this:  

```c
release
+ gui.exe
+ icudt51.dll
+ icuin51.dll
+ icuuc51.dll
+ libGLESv2.dll
+ Qt5Core.dll
+ Qt5Gui.dll
+ Qt5Widgets.dll
+ platforms
```

Platforms is the folder directly copied from <strong>Qt\Qt5.1.1\5.1.1\msvc2012\plugins\platforms</strong> including e.g. qwindows.dll. Does not matter if I rename it to "platform" as some other users did. Qt is still not finding the "platform plugin windows", where is my mistake?  

#### Answer accepted (score 63)
Okay, as posted here <a href="https://stackoverflow.com/a/17271172/1458552">https://stackoverflow.com/a/17271172/1458552</a> without much attention by other users:   

The <strong>libEGL.dll</strong> was missing! Even though this has not been reported when trying to start the application (all other *.dlls such as Qt5Gui.dll had been reported).  

#### Answer 2 (score 35)
I created a platforms directory next to my exe location and put qwindows.dll inside, but I still received the "Failed to load platform plugin "windows".  Available platforms are: windows" error.  

I had copied qwindows.dll from C:\Qt\Qt5.1.1\Tools\QtCreator\bin\plugins\platforms, which is not the right location.  I looked at the debug log from running in Qt Creator and found that my app was looking in C:\Qt\Qt5.1.1\5.1.1\mingw48_32\plugins\platforms when it ran in the debugger.    

When I copied from C:\Qt\Qt5.1.1\5.1.1\mingw48_32\plugins\platforms, everything worked fine.  

#### Answer 3 (score 21)
The release is likely missing a library/plugin or the library is in the wrong directory and or from the wrong directory.   

Create a folder named "platforms" in the same directory as your application.exe file. Copy and paste the qwindows.dll, found in the /bin of whichever compiler you used to release your application, into the "platforms" folder. Like magic it works. If the .dll is not there check plugins/platforms/ ( with plugins/ being in the same directory as bin/ ) : PfunnyGuy's comment.   

It seems like a common issue is that the .dll was taken from the wrong compiler bin. Be sure to copy your the qwindows.dll from the same compiler as the one used to release your app.   

Also another helpful tip, Qt comes with platform console applications that will add all dependencies (including ones like qwindows.dll and libEGL.dll) into the folder of your deployed executable. The application for windows is called windeployqt and the documentation can be found here <a href="http://doc.qt.io/qt-5/windows-deployment.html" rel="nofollow noreferrer">http://doc.qt.io/qt-5/windows-deployment.html</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: Adding external library into Qt Creator project (score [208998](https://stackoverflow.com/q/718447) in 2013)

#### Question
How can I add external library into a project built by Qt Creator RC1 (version 0.9.2)? For example, the win32 function `EnumProcesses()` requires `Psapi.lib` to be added in the project to build.  

#### Answer accepted (score 210)
The proper way to do this is like this:  

```c
LIBS += -L/path/to -lpsapi
```

This way it will work on all platforms supported by Qt. The idea is that you have to separate the directory from the library name (without the extension and without any 'lib' prefix). Of course, if you are including a Windows specific lib, this really doesn't matter.  

In case you want to store your lib files in the project directory, you can reference them with the `$$_PRO_FILE_PWD_` variable, e.g.:  

```c
LIBS += -L"$$_PRO_FILE_PWD_/3rdparty/libs/" -lpsapi
```

#### Answer 2 (score 22)
Are you using `qmake` projects? If so, you can add an external library using the <a href="https://doc.qt.io/qt-5/qmake-variable-reference.html#libs" rel="nofollow noreferrer">`LIBS`</a> variable. E.g:  

```c
win32:LIBS += path/to/Psapi.lib
```

#### Answer 3 (score 11)
<blockquote>
  LIBS += C:\Program Files\OpenCV\lib  
</blockquote>

<p>won't work because you're using white-spaces in Program Files. In this case you have to add quotes, so the result will look like this: <strong>LIBS += "C:\Program Files\OpenCV\lib"</strong>.
I recommend placing libraries in non white-space locations ;-)</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: How to change string into QString? (score [203123](https://stackoverflow.com/q/1814189) in 2016)

#### Question
What is the most basic way to do it?  

#### Answer accepted (score 129)
If by string you mean `std::string` you can do it with this method:  

<a href="http://doc.qt.io/qt-4.8/qstring.html#fromStdString" rel="noreferrer">QString QString::fromStdString(const std::string &amp; str)</a>  

```c
std::string str = "Hello world";
QString qstr = QString::fromStdString(str);
```

<hr>

If by string you mean Ascii encoded `const char *` then you can use this method:  

<a href="http://doc.qt.io/qt-4.8/qstring.html#fromAscii" rel="noreferrer">QString QString::fromAscii(const char * str, int size = -1)</a>  

```c
const char* str = "Hello world";
QString qstr = QString::fromAscii(str);
```

<hr>

If you have `const char *` encoded with system encoding that can be read with <a href="http://doc.qt.io/qt-4.8/qtextcodec.html#codecForLocale" rel="noreferrer">QTextCodec::codecForLocale()</a> then you should use this method:  

<a href="http://doc.qt.io/qt-4.8/qstring.html#fromLocal8Bit" rel="noreferrer">QString QString::fromLocal8Bit(const char * str, int size = -1)</a>  

```c
const char* str = "zażółć gęślą jaźń";      // latin2 source file and system encoding
QString qstr = QString::fromLocal8Bit(str);
```

<hr>

If you have `const char *` that's UTF8 encoded then you'll need to use this method:  

<a href="http://doc.qt.io/qt-4.8/qstring.html#fromUtf8" rel="noreferrer">QString QString::fromUtf8(const char * str, int size = -1)</a>  

```c
const char* str = read_raw("hello.txt"); // assuming hello.txt is UTF8 encoded, and read_raw() reads bytes from file into memory and returns pointer to the first byte as const char*
QString qstr = QString::fromUtf8(str);
```

<hr>

There's also method for `const ushort *` containing UTF16 encoded string:  

<a href="http://doc.qt.io/qt-4.8/qstring.html#fromUtf16" rel="noreferrer">QString QString::fromUtf16(const ushort * unicode, int size = -1)</a>  

```c
const ushort* str = read_raw("hello.txt"); // assuming hello.txt is UTF16 encoded, and read_raw() reads bytes from file into memory and returns pointer to the first byte as const ushort*
QString qstr = QString::fromUtf16(str);
```

#### Answer 2 (score 242)
If compiled with STL compatibility, `QString` has a <a href="http://doc.qt.io/qt-5/qstring.html#fromStdString" rel="noreferrer">static method</a> to convert a `std::string` to a `QString`:  

```c
std::string str = "abc";
QString qstr = QString::fromStdString(str);
```

#### Answer 3 (score 13)
Alternative way:  

```c
std::string s = "This is an STL string";
QString qs = QString::fromAscii(s.data(), s.size());
```

This has the advantage of not using `.c_str()` which might cause the `std::string` to copy itself in case there is no place to add the `'\0'` at the end.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: "Failed to load platform plugin "xcb" " while launching qt5 app on linux without qt installed (score [183978](https://stackoverflow.com/q/17106315) in 2015)

#### Question
I wrote application for linux which uses Qt5.  

But when I am trying to launch it on the linux without Qt SDK installed, the output in console is:  

<blockquote>
  Failed to load platform plugin "xcb". Available platforms are:  
</blockquote>

<p>How can I fix this? May be I need to copy some plugin file?
When I use ubuntu with Qt5 installed, but I rename Qt directory, the same problem occurs. So, it uses some file from Qt directory...</p>

<p>UPDATE:
when I create in the app dir "platforms" folder with the file <strong>libqxcb.so</strong>, the app still doesnot start, but the error message changes:</p>

<blockquote>
  Failed to load platform plugin "xcb". Available platforms are:  
  
  xcb  
</blockquote>

How can this happen? How can platform plugin be available but can't be loaded?  

#### Answer accepted (score 54)
Use ldd (man ldd) to show shared library dependencies. Running this on libqxcb.so   

```c
.../platforms$ ldd libqxcb.so
```

shows that xcb depends on libQt5DBus.so.5 in addition to libQt5Core.so.5 and libQt5Gui.so.5 (and many other system libs). Add libQt5DBus.so.5 to your collection of shared libs and you should be ready to move on.  

#### Answer 2 (score 50)
As was posted earlier, you need to make sure you install the platform plugins when you deploy your application. Depending on how you want to deploy things, there are two methods to tell your application where the platform plugins (e.g. platforms/plugins/libqxcb.so) are at runtime which may work for you.  

The first is to export the path to the directory through the QT_QPA_PLATFORM_PLUGIN_PATH variable.  

```c
QT_QPA_PLATFORM_PLUGIN_PATH=path/to/plugins ./my_qt_app
```

or  

```c
export QT_QPA_PLATFORM_PLUGIN_PATH=path/to/plugins
./my_qt_app
```

The other option, which I prefer is to create a qt.conf file in the same directory as your executable. The contents of which would be:  

```c
[Paths]
Plugins=/path/to/plugins
```

More information regarding this can be found <a href="http://lemirep.wordpress.com/2013/06/01/deploying-qt-applications-on-linux-and-windows-3/">here</a> and <a href="http://qt-project.org/doc/qt-4.8/qt-conf.html">at using qt.conf</a>  

#### Answer 3 (score 19)
I tried to start my binary, compiled with Qt 5.7, on Ubuntu 16.04 LTS where Qt 5.5 is preinstalled. Expectedly, it didn't work as is.  

At first, I inspected the binary itself with `ldd` as was suggested here, and satisfied all "not found" dependencies. Then this notorious `This application failed to start because it could not find or load the Qt platform plugin "xcb"` error was thrown in.  

<strong>What should be done on Linux to resolve this</strong>  

At first, you should create `platforms` directory where your binary is, because it is the place where Qt looks for XCB library. Copy `libqxcb.so` there. I wonder why authors of other answers didn't mention this.  

Then you may want to run your binary with `QT_DEBUG_PLUGINS=1` environment variable set to check what dependencies of `libqxcb.so` unsatisfied. (You may also use `ldd` for this as suggested in the accepted answer).  

The command output may look like this:  

```c
me@xerus:/media/sf_Qt/Package$ LD_LIBRARY_PATH=. QT_DEBUG_PLUGINS=1 ./Binary
QFactoryLoader::QFactoryLoader() checking directory path "/media/sf_Qt/Package/platforms" ...
QFactoryLoader::QFactoryLoader() looking at "/media/sf_Qt/Package/platforms/libqxcb.so"
Found metadata in lib /media/sf_Qt/Package/platforms/libqxcb.so, metadata=
{
    "IID": "org.qt-project.Qt.QPA.QPlatformIntegrationFactoryInterface.5.3",
    "MetaData": {
        "Keys": [
            "xcb"
        ]
    },
    "className": "QXcbIntegrationPlugin",
    "debug": false,
    "version": 329472
}


Got keys from plugin meta data ("xcb")
loaded library "/media/sf_Qt/Package/platforms/libqxcb.so"
QLibraryPrivate::loadPlugin failed on "/media/sf_Qt/Package/platforms/libqxcb.so" : "Cannot load library /media/sf_Qt/Package/platforms/libqxcb.so: (/usr/lib/x86_64-linux-gnu/libQt5DBus.so.5: version `Qt_5' not found (required by ./libQt5XcbQpa.so.5))"
This application failed to start because it could not find or load the Qt platform plugin "xcb"
in "".

Available platform plugins are: xcb.

Reinstalling the application may fix this problem.
Aborted (core dumped)
```

Note the failing `libQt5DBus.so.5` library. Copy it to your libraries path, in my case it was the same directory where my binary is (hence `LD_LIBRARY_PATH=.`). Repeat this process until all dependencies are satisfied.   

P.S. thanks to the author of <a href="https://stackoverflow.com/a/19913885/2202101">this answer</a> for `QT_DEBUG_PLUGINS=1`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: How do I create a pause/wait function using Qt? (score [179030](https://stackoverflow.com/q/3752742) in 2015)

#### Question
I'm playing around with <a href="https://en.wikipedia.org/wiki/Qt_%28software%29" rel="noreferrer">Qt</a>, and I want to create a simple pause between two commands. However it won't seem to let me use `Sleep(int mili);`, and I can't find any obvious wait functions.  

I am basically just making a console application to test some class code which will later be included in a proper Qt GUI, so for now I'm not bothered about breaking the whole event-driven model.  

#### Answer accepted (score 30)
This <a href="https://stackoverflow.com/questions/3149356/qt-make-a-function-to-pause-at-some-moment-for-some-time">previous question</a> mentions using `qSleep()` which is in the `QtTest` module. To avoid the overhead linking in the `QtTest` module, looking at the source for that function you could just make your own copy and call it. It uses defines to call either Windows `Sleep()` or Linux `nanosleep()`.  

```c
#ifdef Q_OS_WIN
#include <windows.h> // for Sleep
#endif
void QTest::qSleep(int ms)
{
    QTEST_ASSERT(ms > 0);

#ifdef Q_OS_WIN
    Sleep(uint(ms));
#else
    struct timespec ts = { ms / 1000, (ms % 1000) * 1000 * 1000 };
    nanosleep(&ts, NULL);
#endif
}
```

#### Answer 2 (score 128)
I wrote a super simple delay function for an application I developed in Qt.  

I would advise you to use this code rather than the sleep function as it won't let your GUI freeze.  

Here is the code:  

```c
void delay()
{
    QTime dieTime= QTime::currentTime().addSecs(1);
    while (QTime::currentTime() < dieTime)
        QCoreApplication::processEvents(QEventLoop::AllEvents, 100);
}
```

To delay an event by n seconds - use `addSecs(n)`.  

#### Answer 3 (score 61)
From Qt5 onwards we can also use  

<a href="http://doc.qt.io/qt-5/qthread.html#static-public-members" rel="noreferrer"><strong>Static Public Members of QThread</strong></a>  

```c
void    msleep(unsigned long msecs)
void    sleep(unsigned long secs)
void    usleep(unsigned long usecs)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: qmake: could not find a Qt installation of '' (score [170258](https://stackoverflow.com/q/16607003) in 2016)

#### Question
I have a software in ubuntu that requires me to run qmake  to generate the Makefile.  

However, running qmake gives back this error,  

```c
qmake: could not find a Qt installation of ''
```

I have installed what I thought to be the required packages using,  

```c
sudo apt-get install qt4-qmake
sudo apt-get install qt5-qmake
```

But the error didn't go away.  

Any help on this would be gladly appreciated!  

#### Answer accepted (score 151)
`sudo apt-get install qt5-default` works for me.  

<p>```c
$ aptitude show qt5-default</pre></code>
tells that</p>

<blockquote>
  <p>This package sets Qt 5 to be the default Qt version to be used when using
   development binaries like qmake. It provides a default configuration for
   qtchooser, but does not prevent alternative Qt installations from being used.</p>
</blockquote>

#### Answer 2 (score 28)
You could check path to qmake using `which qmake`.  

Consider install `qt4-default` or `qt5-default` depends what version of qt you want use.  

You could also use <a href="http://manpages.ubuntu.com/manpages/utopic/man1/qtchooser.1.html">qtchooser</a>  -  a  wrapper  used  to select between Qt development binary versions.  

#### Answer 3 (score 12)
For others in my situation, the solution was:  

```c
qmake -qt=qt5
```

This was on Ubuntu 14.04 after install qt5-qmake. qmake was a symlink to qtchooser which takes the -qt argument.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: Auto-expanding layout with Qt-Designer (score [168660](https://stackoverflow.com/q/3492739) in )

#### Question
I'm using the Qt Designer.  

I want to create a `QVBoxLayout` which will automatically expand to fill the whole window.  

The layout of the `QVBoxLayout` remains fixed.  

How can I cause the `QVBoxLayout` to expand and fill the entire window through the designer?  

#### Answer accepted (score 341)
After creating your `QVBoxLayout` in Qt Designer, right-click on the background of your widget/dialog/window (not the `QVBoxLayout`, but the parent widget) and select <em>Lay Out -> Lay Out in a Grid</em> from the bottom of the context-menu. The `QVBoxLayout` should now stretch to fit the window and will resize automatically when the entire window is resized.  

#### Answer 2 (score 13)
According to the <a href="http://doc.qt.io/qt-5/designer-layouts.html" rel="noreferrer">documentation</a>, there needs to be a top level layout set.  

<blockquote>
  A top level layout is necessary to ensure that your widgets will resize correctly when its window is resized. To check if you have set a top level layout, preview your widget and attempt to resize the window by dragging the size grip.  
</blockquote>

You can set one by clearing the selection and right clicking on the form itself and choosing one of the layouts available in the context menu.  

<a href="https://i.stack.imgur.com/6VO9C.png" rel="noreferrer"><img src="https://i.stack.imgur.com/6VO9C.png" alt="Qt layouts"></a>  

#### Answer 3 (score 2)
I've tried to find a "fit to screen" property but there is no such.  

But setting widget's "maximumSize" to a "some big number" ( like 2000 x 2000 ) will automatically fit the widget to the parent widget space.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How to convert QString to int? (score [164587](https://stackoverflow.com/q/16633555) in 2016)

#### Question
<p>I have a `QString` in my sources. 
So I need to convert it to integer <strong>without "Kb".</strong> </p>

I tried `Abcd.toInt()` but it does not work.  

```c
QString Abcd = "123.5 Kb"
```

#### Answer 2 (score 82)
You don't have all digit characters in your string. So you have to split by space  

```c
QString Abcd = "123.5 Kb";
Abcd.split(" ")[0].toInt();    //convert the first part to Int
Abcd.split(" ")[0].toDouble(); //convert the first part to double
Abcd.split(" ")[0].toFloat();  //convert the first part to float
```

<strong>Update</strong>: I am updating an old answer. That was a straight forward answer to the specific question, with a strict assumption. However as noted by @DomTomCat in comments and @Mikhail in answer, In general one should always check whether the operation is successful or not. So using a boolean flag is necessary.  

```c
bool flag;
double v = Abcd.split(" ")[0].toDouble(&flag); 
if(flag){
  // use v
}
```

Also if you are taking that string as user input, then you should also be doubtful about whether the string is really splitable with space. If there is a possibility that the assumption may break then a regex verifier is more preferable. A regex like the following will extract the floating point value and the prefix character of 'b'. Then you can safely convert the captured strings to double.  

```c
([0-9]*\.?[0-9]+)\s+(\w[bB])
```

You can have an utility function like the following  

```c
QPair<double, QString> split_size_str(const QString& str){
    QRegExp regex("([0-9]*\\.?[0-9]+)\\s+(\\w[bB])");
    int pos = regex.indexIn(str);
    QStringList captures = regex.capturedTexts();
    if(captures.count() > 1){
        double value = captures[1].toDouble(); // should succeed as regex matched
        QString unit = captures[2]; // should succeed as regex matched
        return qMakePair(value, unit);
    }
    return qMakePair(0.0f, QString());
}
```

#### Answer 3 (score 8)
Don't forget to check if the conversion was successful!  

```c
bool ok;
auto str= tr("1337");
str.toDouble(&ok); // returns 1337.0, ok set to true
auto strr= tr("LEET");
strr.toDouble(&ok); // returns 0.0, ok set to false
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: Creating/writing into a new file in Qt (score [159250](https://stackoverflow.com/q/4916193) in 2017)

#### Question
I am trying to write into a file and if the file doesn't exist create it. I have searched on the internet and nothing worked for me.  

My code looks currently like this:  

```c
QString filename="Data.txt";
QFile file( filename );
if ( file.open(QIODevice::ReadWrite) )
{
    QTextStream stream( &file );
    stream << "something" << endl;
}
```

<p>If I create a text file called Data in the directory, it remains empty. If I don't create anything it doesn't create the file either.
I don't know what to do with this, this isn't the first way in which I tried to create/write into a file and none of the ways worked.</p>

Thanks for your answers.  

#### Answer accepted (score 23)
<p>Are you sure you're in the right directory?<br>
Opening a file without a full path will open it in the current working directory. In most cases this is not what you want. Try changing the first line to </p>

<p>`QString filename="c:\\Data.txt"` or<br>
`QString filename="c:/Data.txt"`</p>

and see if the file is created in `c:\`  

#### Answer 2 (score 24)
That is weird, everything looks fine, are you sure it does not work for you? Because this `main` surely works for me, so I would look somewhere else for the source of your problem.  

```c
#include <QFile>
#include <QTextStream>


int main()
{
    QString filename = "Data.txt";
    QFile file(filename);
    if (file.open(QIODevice::ReadWrite)) {
        QTextStream stream(&file);
        stream << "something" << endl;
    }
}
```

The code you provided is also almost the same as the one provided in <a href="http://doc.qt.nokia.com/4.7/qtextstream.html#details" rel="noreferrer">detailed description of QTextStream</a> so I am pretty sure, that the problem is elsewhere :)  

Also note, that the file is not called `Data` but `Data.txt` and should be created/located in the directory from which the program was run (not necessarily the one where the executable is located).  

#### Answer 3 (score 9)
```c
#include <QFile>
#include <QCoreApplication>
#include <QTextStream>

int main(int argc, char *argv[])
{
    // Create a new file     
    QFile file("out.txt");
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&file);
    out << "This file is generated by Qt\n";

    // optional, as QFile destructor will already do it:
    file.close(); 

    //this would normally start the event loop, but is not needed for this
    //minimal example:
    //return app.exec();

    return 0;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: QString to char* conversion (score [153496](https://stackoverflow.com/q/2523765) in 2014)

#### Question
I was trying to convert a QString to char* type by the following methods, but they don't seem to work.  

```c
//QLineEdit *line=new QLineEdit();{just to describe what is line here}

QString temp=line->text();
char *str=(char *)malloc(10);
QByteArray ba=temp.toLatin1();
strcpy(str,ba.data());
```

Can you elaborate the possible flaw with this method, or give an alternative method?  

#### Answer accepted (score 108)
Well, the <a href="https://wiki.qt.io/Technical_FAQ#How_can_I_convert_a_QString_to_char.2A_and_vice_versa.3F" rel="noreferrer">Qt FAQ</a> says:  

```c
int main(int argc, char **argv)
{
 QApplication app(argc, argv);
  QString str1 = "Test";
  QByteArray ba = str1.toLocal8Bit();
  const char *c_str2 = ba.data();
  printf("str2: %s", c_str2);
  return app.exec();
}
```

So perhaps you're having other problems. How exactly doesn't this work?  

#### Answer 2 (score 43)
Maybe   

`my_qstring.toStdString().c_str();`  

or safer, as Federico points out:  

```c
std::string str = my_qstring.toStdString();
const char* p = str.c_str();
```

It's far from optimal, but will do the work.  

#### Answer 3 (score 37)
<p>The easiest way to convert a <a href="http://doc.qt.io/qt-5/qstring.html#details" rel="noreferrer">QString</a> to <strong>char*</strong> is <a href="http://doc.qt.io/qt-5/qtglobal.html#qPrintable" rel="noreferrer">qPrintable(const QString&amp; str)</a>,
which is a macro expanding to `str.toLocal8Bit().constData()`.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: Qt jpg image display (score [152919](https://stackoverflow.com/q/1357960) in 2013)

#### Question
I want to display .jpg image in an Qt UI. I checked it online and found <a href="http://qt-project.org/doc/qt-4.8/widgets-imageviewer.html" rel="noreferrer">http://qt-project.org/doc/qt-4.8/widgets-imageviewer.html</a>. I thought Graphics View will do the same, and also it has codec to display video. How to display images using Graphics View? I went through the libraries, but because I am a totally newbie in Qt, I can't find a clue to start with. Can you direct me to some resources/examples on how to load and display images in Qt?  

Thanks.  

#### Answer accepted (score 39)
```c
#include ...

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QGraphicsScene scene;
    QGraphicsView view(&scene);
    QGraphicsPixmapItem item(QPixmap("c:\\test.png"));
    scene.addItem(&item);
    view.show();
    return a.exec();
}
```

This should work. :) List of supported formats can be <a href="http://qt-project.org/doc/qt-5.0/qtgui/qpixmap.html#reading-and-writing-image-files" rel="noreferrer">found here</a>  

#### Answer 2 (score 42)
You could attach the image (as a pixmap) to a label then add that to your layout...  

```c
...

QPixmap image("blah.jpg");

QLabel imageLabel = new QLabel();
imageLabel.setPixmap(image);

mainLayout.addWidget(imageLabel);

...
```

Apologies, this is using Jambi (Qt for Java) so the syntax is different, but the theory is the same.  

#### Answer 3 (score 12)
If the only thing you want to do is drop in an image onto a widget withouth the complexity of the graphics API, you can also just create a new QWidget and set the background with StyleSheets. Something like this:  

<pre>
MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent)
{
    ...
    QWidget *pic = new QWidget(this);
    pic->setStyleSheet("background-image: url(test.png)");
    pic->setGeometry(QRect(50,50,128,128));
    ...
}
</pre>

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: How to install PyQt5 on Windows? (score [136283](https://stackoverflow.com/q/16846501) in 2018)

#### Question
When I try installing the PyQt5 on Windows using the command   

```c
python configure.py
```

I get this error:  

<blockquote>
```c
Error: Make sure you have a working Qt qmake on your PATH.
```
</blockquote>

I got the pyQt5 from <a href="http://www.riverbankcomputing.co.uk/software/pyqt/download5" rel="noreferrer">PyQt5 Download</a>.  

How can I install PyQt5?  

<hr>

<strong>Update:</strong>  

I installed `Qt 5.0.2 for Windows 64-bit (VS 2012, 500 MB)` from the <a href="http://qt-project.org/downloads" rel="noreferrer">Qt Download page</a> and now I have this error:  

<blockquote>
```c
Querying qmake about your Qt installation...
Determining the details of your Qt installation...
Error: Failed to determine the detail of your Qt installation. Try again using
the --verbose flag to see more detail about the problem.
```
</blockquote>

And when I execute the command `python configure.py --verbose`:  

<blockquote>
```c
Querying qmake about your Qt installation...
Determining the details of your Qt installation...
C:\Qt\Qt5.0.2\5.0.2\msvc2012_64\bin\qmake.exe -spec win32-msvc2008 -o qtdetail.m
k qtdetail.pro
nmake -f qtdetail.mk release
'nmake' não é reconhecido como um comando interno
ou externo, um programa operável ou um arquivo em lotes.
Error: Failed to determine the detail of your Qt installation. Try again using
the --verbose flag to see more detail about the problem.
```
</blockquote>

I added `C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin` (contains `nmake.exe`) to PATH and I got this error:  

<blockquote>
```c
Querying qmake about your Qt installation...
Determining the details of your Qt installation...
C:\Qt\Qt5.0.2\5.0.2\msvc2012_64\bin\qmake.exe -spec win32-msvc2008 -o qtdetail.mk qtdetail.pro
nmake -f qtdetail.mk release


Microsoft (R) Program Maintenance Utility Version 11.00.50727.1

Copyright (C) Microsoft Corporation.  All rights reserved.


  "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\nmake.exe" -f qtdetail.mk.Release


Microsoft (R) Program Maintenance Utility Version 11.00.50727.1

Copyright (C) Microsoft Corporation.  All rights reserved.

  cl -c -nologo -Zm200 -Zc:wchar_t -O2 -MD -GR -W3 -w34100 -w34189 -EHsc -DUNICODE -DWIN32 -DQT_NO_DEBUG -DQT_CORE_LIB -I"..\..\..\..\..\..\..\Qt\Qt5.0.2\5.0.2\msvc2012_64\include" -I"..\..\..\..\..\..\..\Qt\Qt5.0.2\5.0.2\msvc2012_64\include\QtCore" -I"release" -I"..\..\..\..\..\..\..\Qt\Qt5.0.2\5.0.2\msvc2012_64\mkspecs\win32-msvc2008" -Forelease\ @C:\Users\Victor\AppData\Local\Temp\nm68EA.tmp

NMAKE : fatal error U1077: '"C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\cl.EXE"' : return code '0xc0000135'

Stop.

NMAKE : fatal error U1077: '"C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\nmake.exe"' : return code '0x2'

Stop.
```
</blockquote>

#### Answer accepted (score 12)
The easiest way to install PyQt is to just use the installer (Link in your answer, step #5).  If you install python 3.3, the installer will add all of the PyQt5 extras to that python installation automatically.  You won't need to do any compiling (none of: nmake, nmake install, python configure).    

All of the build options are available for if you need a custom install (for instance, using a different version of python, where there isn't an installer provided by riverbank computing).  

If you do need to compile your own version of PyQt5, the steps (as you have found) are <a href="http://pyqt.sourceforge.net/Docs/PyQt5/installation.html">here</a>, but assume you have python and a compiler installed and in your path.  The installed and in your path have been where you have been running into trouble it seems.  I'd recommend using the installer version, but you need to install <a href="http://www.python.org/getit/">python 3.3</a> first.  

#### Answer 2 (score 27)
Mainly I use the following command under the `cmd`  

```c
pip install pyqt5
```

And it works with no problem!  

#### Answer 3 (score 8)
First try this in your Windows cmd window:  

```c
pip3 install pyqt5
```

If that is successful, it will look something like this:  

```c
C:\Windows\System32>pip3 install pyqt5
Collecting pyqt5
  Downloading PyQt5-5.9-5.9.1-cp35.cp36.cp37-none-win_amd64.whl (77.2MB)
    100% |################################| 77.2MB 13kB/s
Collecting sip<4.20,>=4.19.3 (from pyqt5)
  Downloading sip-4.19.3-cp35-none-win_amd64.whl (49kB)
    100% |################################| 51kB 984kB/s
Installing collected packages: sip, pyqt5
Successfully installed pyqt5-5.9 sip-4.19.3
```

If that did not work, you might try this link from SourceForge.  

<a href="https://sourceforge.net/projects/pyqt/files/PyQt5/" rel="nofollow noreferrer">PyQt5 .exe installers for Windows</a>  

<strong>How to find the installer that's right for you?</strong>  

<p>First, determine what version of Python you have and whether you have 32-bit or 64-bit Python.
Next, open one of the directories. I'm on Python 3.5 64-bit so I'm looking for a .exe with those specs. When you open a directory on SourceForge, you will see some directories with ONLY <em>.zip</em> or <em>.tar.gz</em>. That's not what you're looking for. A good indication of which directory you should click is given by the "Downloads/Week" column.
I'll open the <strong>PyQt-5.6</strong> directory in my case.</p>

Here we notice some .exe files:  

```c
PyQt-5.6
|_PyQt5-5.6-gpl-Py3.5-Qt5.6.0-x32-2.exe
|_PyQt5-5.6-gpl-Py3.5-Qt5.6.0-x64-2.exe
|_PyQt5_gpl-5.6.zip
|_PyQt5_gpl-5.6.tar.gz
```

I know these are Python 3.5 by `Py3.5` in the file name. I am also looking for the 64-bit version so I'll download `PyQt5-5.6-gpl-Py3.5-Qt5.6.0-x64-2.exe`. Final answer!  

Note: if you try to install a version that's not compatible with your system, a dialog box will appear immediately after running the .exe. That's an indication that you've chosen the wrong one. I'm not trying to sound like a dbag... I did that several times!  

To test a successful install, in your Python interpreter, try to import:  

```c
from PyQt5 import QtCore, QtGui, QtWidgets
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: Yes/No message box using QMessageBox (score [135833](https://stackoverflow.com/q/13111669) in 2018)

#### Question
How do I show a message box with Yes/No buttons in Qt, and how do I check which of them was pressed?  

I.e. a message box that looks like this:  

<img src="https://i.stack.imgur.com/h92PA.png" alt="enter image description here">  

#### Answer accepted (score 172)
You would use <a href="http://qt-project.org/doc/qt-5.0/qtwidgets/qmessagebox.html#question">`QMessageBox::question`</a> for that.  

Example in a hypothetical widget's slot:  

```c
#include <QApplication>
#include <QMessageBox>
#include <QDebug>

// ...

void MyWidget::someSlot() {
  QMessageBox::StandardButton reply;
  reply = QMessageBox::question(this, "Test", "Quit?",
                                QMessageBox::Yes|QMessageBox::No);
  if (reply == QMessageBox::Yes) {
    qDebug() << "Yes was clicked";
    QApplication::quit();
  } else {
    qDebug() << "Yes was *not* clicked";
  }
}
```

<sub>Should work on Qt 4 and 5, requires `QT += widgets` on Qt 5, and `CONFIG += console` on Win32 to see `qDebug()` output.</sub>  

See the <a href="http://qt-project.org/doc/qt-5.0/qtwidgets/qmessagebox.html#StandardButton-enum">`StandardButton`</a> enum to get a list of buttons you can use; the function returns the button that was clicked. You can set a default button with an extra argument (Qt "<em>chooses a suitable default automatically</em>" if you don't or specify `QMessageBox::NoButton`).  

#### Answer 2 (score 38)
You can use the QMessage object to create a Message Box then add buttons :   

```c
QMessageBox msgBox;
msgBox.setWindowTitle("title");
msgBox.setText("Question");
msgBox.setStandardButtons(QMessageBox::Yes);
msgBox.addButton(QMessageBox::No);
msgBox.setDefaultButton(QMessageBox::No);
if(msgBox.exec() == QMessageBox::Yes){
  // do something
}else {
  // do something else
}
```

#### Answer 3 (score 17)
QT can be as simple as that of Windows. The equivalent code is  

```c
if (QMessageBox::Yes == QMessageBox(QMessageBox::Information, "title", "Question", QMessageBox::Yes|QMessageBox::No).exec()) 
{

}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: Qt - reading from a text file (score [135498](https://stackoverflow.com/q/2612103) in )

#### Question
I have a table view with three columns; I have just passed to write into text file using this code  

```c
QFile file("/home/hamad/lesson11.txt");
if(!file.open(QIODevice::WriteOnly)) {
    QMessageBox::information(0,"error",file.errorString());
}
QString dd;

for(int row=0; row < model->rowCount(); row++) {
     dd = model->item(row,0)->text() +  ","
                 + model->item(row,1)->text() +  ","
                 + model->item(row,2)->text();

     QTextStream out(&file);
     out << dd << endl;
 }
```

But I'm not succeed to read the same file again, I tried this code but I don't know where is the problem in it  

```c
QFile file("/home/hamad/lesson11.txt");
QTextStream in(&file);
QString line = in.readLine();
while(!in.atEnd()) {

    QStringList  fields = line.split(",");

    model->appendRow(fields);

}
```

Any help please ?  

#### Answer 2 (score 87)
You have to replace string line  

```c
QString line = in.readLine();
```

into <em>while</em>:  

```c
QFile file("/home/hamad/lesson11.txt");
if(!file.open(QIODevice::ReadOnly)) {
    QMessageBox::information(0, "error", file.errorString());
}

QTextStream in(&file);

while(!in.atEnd()) {
    QString line = in.readLine();    
    QStringList fields = line.split(",");    
    model->appendRow(fields);    
}

file.close();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Get current working directory in a Qt application (score [135066](https://stackoverflow.com/q/7402576) in 2016)

#### Question
I'm writing a program in C++ using the Qt library. There is a symbolic link in my home bin directory to the executable. I would like the current working directory of my program to be the directory in which I am with my terminal (ie. the result of the `pwd` command). I saw the `QDir::currentPath()` function, but it gives back the directory where the binary is.  

How can I find my current working directory?  

#### Answer accepted (score 3)
Thank you RedX and Kaz for your answers. I don't get why by me it gives the path of the exe. I found an other way to do it :   

```c
QString pwd("");
char * PWD;
PWD = getenv ("PWD");
pwd.append(PWD);
cout << "Working directory : " << pwd << flush;
```

It is less elegant than a single line... but it works for me.  

#### Answer 2 (score 90)
Just tested and `QDir::currentPath()` does return the path from which I called my executable.  

And a symlink does not "exist". If you are executing an exe from that path you are effectively executing it from the path the symlink points to.  

#### Answer 3 (score 53)
Have you tried <a href="http://doc.qt.io/qt-4.8/qcoreapplication.html#applicationDirPath" rel="noreferrer">QCoreApplication::applicationDirPath()</a><br>  

```c
qDebug() << "App path : " << qApp->applicationDirPath();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: How to enable C++11 in Qt Creator? (score [133748](https://stackoverflow.com/q/16948382) in 2015)

#### Question
The title is pretty self-descriptive. I've downloaded Qt Creator 2.7.0, and I am trying to compile some basic C++11 code:  

```c
int my_array[5] = {1, 2, 3, 4, 5};
for(int &x : my_array)
{
  x *= 2;
}
```

I'm receiving the following error:  

```c
range based for loops are not allowed in c++ 98 mode
```

Yet, according to <a href="http://blog.qt.digia.com/blog/2013/03/21/qt-creator-2-7-0-released/">this article</a> this version of Qt Creator supports C++11. So how do I enable it?  

#### Answer accepted (score 259)
According to <a href="http://woboq.com/blog/cpp11-in-qt5.html" rel="noreferrer">this site</a> add  

`CONFIG += c++11`  

to your .pro file (see at the bottom of that web page). <strong>It requires Qt 5.</strong>  

<hr>

The other answers, suggesting   

`QMAKE_CXXFLAGS += -std=c++11` (or `QMAKE_CXXFLAGS += -std=c++0x`)  

also work with <strong>Qt 4.8 and gcc / clang.</strong>  

#### Answer 2 (score 32)
Add this to your <strong>.pro file</strong>  

```c
QMAKE_CXXFLAGS += -std=c++11
```

or    

```c
CONFIG += c++11
```

#### Answer 3 (score 19)
As an alternative for handling both cases addressed in Ali's excellent answer, I usually add   

```c
# With C++11 support
greaterThan(QT_MAJOR_VERSION, 4){    
CONFIG += c++11
} else {
QMAKE_CXXFLAGS += -std=c++0x
}
```

to my project files. This can be handy when you don't really care much about which Qt version is people using in your team, but you want them to have C++11 enabled in any case.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: Qt. get part of QString (score [131962](https://stackoverflow.com/q/7584699) in 2017)

#### Question
<p>I want to get `QString` from another `QString`, when I know necessary indexes.
For example:
Main string: <em>"This is a string"</em>.
I want to create new `QString` from first 5 symbols and get <em>"This "</em>.<br>
<strong>input :</strong> first and last char number.<br>
<strong>output :</strong> new `QString`.</p>

How to create it ?    

<strong>P.S.</strong> Not only first several letters, also from the middle of the line, for example from 5 till 8.  

#### Answer 2 (score 101)
If you do not need to modify the substring, then you can use `QStringRef`.  The `QStringRef` class is a read only wrapper around an existing `QString` that references a substring within the existing string.  This gives much better performance than creating a new `QString` object to contain the sub-string. E.g.  

```c
QString myString("This is a string");
QStringRef subString(&myString, 5, 2); // subString contains "is"
```

If you do need to modify the substring, then `left()`, `mid()` and `right()` will do what you need...  

```c
QString myString("This is a string");
QString subString = myString.mid(5,2); // subString contains "is"
subString.append("n't"); // subString contains "isn't"
```

#### Answer 3 (score 44)
Use the `left` function:  

```c
QString yourString = "This is a string";
QString leftSide = yourString.left(5);
qDebug() << leftSide; // output "This "
```

Also have a look at `mid()` if you want more control.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: 'cl' is not recognized as an internal or external command, (score [129230](https://stackoverflow.com/q/8800361) in 2012)

#### Question
I am trying to compile a hello world program in Qt Using Qt Creator.  

I am getting 'cl' is not recognized as an internal or external command.  

<p>I am using Windows 7 and Both Vs 2008 and 2010 installed in it.
When I use Mingw it is compiling fine but if use vs 2008 it is giving this error.</p>

After Setting Env Path =..;..;C:\Program Files\Microsoft Visual Studio 9.0\VC\bin also it is showing the same error.  

#### Answer accepted (score 44)
I think `cl` isn't in your path. You need to add it there. The recommended way to do this is to launch a <em>developer command prompt</em>.  

Quoting the article <em><a href="https://msdn.microsoft.com/en-us/library/f2ccy3wt%28v=vs.140%29.aspx" rel="noreferrer">Setting the Path and Environment Variables for Command-Line Builds</a></em>:  

<blockquote>
  To open a Developer Command Prompt window  
  
  <ol>
  <li><p>With the Windows 8 Start screen showing, type <strong>Visual Studio Tools</strong>. Notice that the search results change as you type; when <strong>Visual Studio
  Tools</strong> appears, choose it.</p>
  
  <p>On earlier versions of Windows, choose <strong>Start</strong>, and then in the search box, type <strong>Visual Studio Tools</strong>. When <strong>Visual Studio Tools</strong> appears
  in the search results, choose it.</p></li>
  <li><p>In the <strong>Visual Studio Tools</strong> folder, open the <strong>Developer Command Prompt</strong> for your version of Visual Studio. (To run as administrator,
  open the shortcut menu for the Developer Command Prompt and choose <strong>Run
  as Administrator</strong>.)</p></li>
  </ol>
</blockquote>

As the article notes, there are several different shortcuts for setting up different toolsets - you need to pick the suitable one.  

If you already have a plain Command Prompt window open, you can run the batch file `vcvarsall.bat` with the appropriate argument to set up the environment variables. Quoting the same article:  

<blockquote>
  To run vcvarsall.bat  
  
  <ol>
  <li><p>At the command prompt, change to the Visual C++ installation directory. (The location depends on the system and the Visual Studio
  installation, but a typical location is C:\Program Files
  (x86)\Microsoft Visual Studio version\VC.) For example, enter:</p>

```c
cd "\Program Files (x86)\Microsoft Visual Studio 12.0\VC"
```</li>
  <li><p>To configure this Command Prompt window for 32-bit x86 command-line builds, at the command prompt, enter:</p>

```c
vcvarsall x86
```</li>
  </ol>
</blockquote>

From the article, the possible arguments are the following:  

<ul>
<li>`x86` (x86 32-bit native)</li>
<li>`x86_amd64` (x64 on x86 cross)</li>
<li>`x86_arm` (ARM on x86 cross)</li>
<li>`amd64` (x64 64-bit native)</li>
<li>`amd64_x86` (x86 on x64 cross)</li>
<li>`amd64_arm` (ARM on x64 cross)</li>
</ul>

#### Answer 2 (score 6)
<p>I had the same problem. 
Try to make a bat-file to start the Qt Creator. Add something like this to the bat-file:</p>

```c
call "C:\Program Files\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"  
"C:\QTsdk\qtcreator\bin\qtcreator" 
```

Now I can compile and get:  

```c
jom 1.0.8 - empower your cores
11:10:08: The process "C:\QTsdk\qtcreator\bin\jom.exe" exited normally.
```

#### Answer 3 (score 4)
Make sure you restart your computer after you install the Build Tools.  

This was what was causing the error for me.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: How can I get the selected VALUE out of a QCombobox? (score [126983](https://stackoverflow.com/q/2056915) in 2018)

#### Question
<p>In Qt, I can get the <strong>`selected text`</strong> of a `QComboBox` by using the 
`combobox-&gt;currentText()` method.
How can I get the <strong>`selected value`</strong>?</p>

I searched for help but I couldn't find a method `currentData()` which I expected to find. I could only find `combobox-&gt;currentIndex()`  

Is there a smarter way to do it other than `combobox-&gt;itemData(combobox-&gt;currentIndex())`?  

Update: This is no longer necessary as of Qt 5. A `currentData()` method has been added <a href="http://doc.qt.io/qt-5/qcombobox.html#currentData-prop" rel="noreferrer">http://doc.qt.io/qt-5/qcombobox.html#currentData-prop</a>  

#### Answer accepted (score 78)
It seems you need to do `combobox-&gt;itemData(combobox-&gt;currentIndex())` if you want to get the current data of the QComboBox.  

If you are using your own class derived from QComboBox, you can add a `currentData()` function.  

#### Answer 2 (score 24)
This one can get the text of current index:  

```c
QString cb = cbChoice ->currentText();
```

#### Answer 3 (score 20)
you can set QVariant data for all items, then you can get the value when you need it.  

there is an example code for this situation:  

```c
ui.comboBoxSheetSize->addItem("128 m", QVariant(128));
ui.comboBoxSheetSize->addItem("256 m", QVariant(256));
ui.comboBoxSheetSize->addItem("512 m", QVariant(512));
ui.comboBoxSheetSize->addItem("1024 m", QVariant(1024));

...

void Page::onComboSheetSizeChanged( int index )
{
 int value = ui.comboBoxSheetSize->itemData(index).toInt();
}
```

<hr>

by the way, i think i misunderstood your question. i think the way you get data is smart enough?  

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: QtCreator: No valid kits found (score [126122](https://stackoverflow.com/q/26499404) in 2016)

#### Question
Installed just the IDE on Windows 7.  I want to create a Plain C++ Project (Non-QT Project); however I get an error: <strong>No valid kits found</strong>.  When I click on Options->Kits, I see the <em>Desktop (default)</em> kit, and it shows no errors.    

Am I getting the error because I didn't install a Qt library?  If so, is there any way I can bypass downloading/installing that and just use the IDE?  

#### Answer accepted (score 42)
Found the issue.  Qt Creator wants you to use a compiler listed under one of their Qt libraries. Use the Maintenance Tool to install this.  

To do so:  

<blockquote>
  <p>Go to Tools -> Options.... Select Build &amp; Run on left. Open Kits tab.
  You should have Manual -> Desktop (default) line in list. Choose it.
  Now select something like Qt 5.5.1 in PATH (qt5) in Qt version
  combobox and click Apply button. From now you should be able to
  create, build and run empty Qt project.</p>
</blockquote>

#### Answer 2 (score 46)
Though OP is asking about Windows, this error also occurs on Ubuntu Linux and Google lists this result first when you search for the error"QtCreator: No valid kits found".    

On Ubuntu this is solved by running:  

For Qt5:  

```c
sudo apt-get install qt5-default
```

For Qt4:  

```c
sudo apt-get install qt4-dev-tools libqt4-dev libqt4-core libqt4-gui
```

This question is answered <a href="https://stackoverflow.com/questions/14581528/qt-version-is-not-properly-installed-please-run-make-install">here</a> and <a href="https://askubuntu.com/questions/694436/qt-version-is-not-properly-installed">here</a>, though those entries are less SEO-friendly...  

#### Answer 3 (score 2)
For QT 5.* if you face error at Kits, like `No Valid Kits Found`, go to <strong>Options->Build&amp;Run-></strong> (Kits tab) then you see a Manual category which should list Desktop as the default.   

Just go to your OS Terminal and write `sudo apt-get install qt5-default`, go back to QT Creator and Start your New Project, and there you see the kit option Desktop included in the list.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: Correct way to quit a Qt program? (score [122572](https://stackoverflow.com/q/8026101) in 2013)

#### Question
How should I quit a Qt Program, e.g when loading a data file, and discovered file corruption, and user need to quit this app or re-initiate data file?  

Should I:  

<ol>
<li>call `exit(EXIT_FAILURE)`</li>
<li>call `QApplication::quit()`</li>
<li>call `QCoreApplication::quit()`</li>
</ol>

And difference between (2) and (3)?  

#### Answer accepted (score 132)
QApplication is derived from QCoreApplication and thereby inherits `quit()` which is a public slot of `QCoreApplication`, so there is no difference between `QApplication::quit()` and `QCoreApplication::quit()`.  

As we can read in the documentation of <a href="http://doc.qt.io/qt-5/qcoreapplication.html#quit" rel="noreferrer">`QCoreApplication::quit()`</a> it <em>"tells the application to exit with return code 0 (success)."</em>. If you want to exit because you discovered file corruption then you may not want to exit with return code zero which means success, so you should call <a href="http://doc.qt.io/qt-5/qcoreapplication.html#exit" rel="noreferrer">`QCoreApplication::exit()`</a> because you can provide a non-zero returnCode which, by convention, indicates an error.  

It is important to note that <em>"if the event loop is not running, this function (QCoreApplication::exit()) does nothing"</em>, so in that case you should call `exit(EXIT_FAILURE)`.  

#### Answer 2 (score 29)
You can call `qApp.exit();`. I always use that and never had a problem with it.  

If you application is a command line application, you might indeed want to return an exit code. It's completely up to you what the code is.  

#### Answer 3 (score 0)
If you're using Qt Jambi, this should work:  

```c
QApplication.closeAllWindows();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How to format a QString? (score [122452](https://stackoverflow.com/q/4784155) in 2015)

#### Question
I'd like to format a string for Qt label, I'm programming in C++ on Qt.  

In ObjC I would write something like:   

```c
NSString *format=[NSString stringWithFormat: ... ];
```

How to do something like that in Qt?  

#### Answer 2 (score 151)
You can use QString.arg like this  

```c
QString my_formatted_string = QString("%1/%2-%3.txt").arg("~", "Tom", "Jane");
// You get "~/Tom-Jane.txt"
```

This method is preferred over sprintf because:  

Changing the position of the string without having to change the ordering of substitution, e.g.  

```c
// To get "~/Jane-Tom.txt"
QString my_formatted_string = QString("%1/%3-%2.txt").arg("~", "Tom", "Jane");
```

Or, changing the type of the arguments doesn't require changing the format string, e.g.  

```c
// To get "~/Tom-1.txt"
QString my_formatted_string = QString("%1/%2-%3.txt").arg("~", "Tom", QString::number(1));
```

As you can see, the change is minimal. Of course, you generally do not need to care about the type that is passed into QString::arg() since most types are correctly overloaded.  

One drawback though: QString::arg() doesn't handle std::string. You will need to call: QString::fromStdString() on your std::string to make it into a QString before passing it to QString::arg(). Try to separate the classes that use QString from the classes that use std::string. Or if you can, switch to QString altogether.  

UPDATE: Examples are updated thanks to Frank Osterfeld.  

UPDATE: Examples are updated thanks to alexisdm.  

#### Answer 3 (score 28)
You can use the `sprintf` method, however the `arg` method is preferred as it supports unicode.  

```c
QString str;
str.sprintf("%s %d", "string", 213);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: How to set image on QPushButton? (score [122196](https://stackoverflow.com/q/3137805) in 2012)

#### Question
I want to set an image on `QPushButton`, and the size of `QPushButton` should depend on the size of the image. I am able to do this when using `QLabel`, but not with `QPushButton`.  

So, if anyone has a solution, then please help me out.  

#### Answer 2 (score 62)
What you can do is use a pixmap as an icon and then put this icon onto the button.  

To make sure the size of the button will be correct, you have to reisze the icon according to the pixmap size.  

Something like this should work :  

```c
QPixmap pixmap("image_path");
QIcon ButtonIcon(pixmap);
button->setIcon(ButtonIcon);
button->setIconSize(pixmap.rect().size());
```

#### Answer 3 (score 40)
```c
QPushButton *button = new QPushButton;
button->setIcon(QIcon(":/icons/..."));
button->setIconSize(QSize(65, 65));
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: Error QApplication: no such file or directory (score [120687](https://stackoverflow.com/q/8995399) in 2014)

#### Question
I have installed C++SDK that have Qt but when I try compiling a code linking QApplication it gives me the error:  

```c
Error QApplication: no such file or directory
```

How do I link these libraries? I searched into the directories and there is a file named QApplication.h; So I tried to link it with -I (linking the directory) but it was still giving me that error.  

#### Answer accepted (score 57)
To start things off, the error `QApplication: no such file or directory` means your compiler was not able to find this header. It is not related to the linking process as you mentioned in the question.  

The `-I` flag (uppercase <strong>i</strong>) is used to specify the include (headers) directory (which is what you need to do), while the `-L` flag is used to specify the libraries directory. The `-l` flag (lowercase L) is used to link your application with a specified library.  

But you can <strong>use Qt to your advantage</strong>: Qt has a build system named <strong>qmake</strong> which makes things easier. For instance, when I want to compile <em>main.cpp</em> I create a <strong>main.pro</strong> file. For educational purposes, let's say this source code is a simple project that uses only `QApplication` and `QDeclarativeView`. An appropriate <em>.pro</em> file would be:  

```c
TEMPLATE += app
QT += gui declarative
SOURCES += main.cpp
```

Then, execute the `qmake` inside that directory to create the Makefile that will be used to compile your application, and finally execute `make` to get the job done.  

On my system this `make` outputs:  

```c
g++ -c -pipe -O2 -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_DECLARATIVE_LIB -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/opt/qt_47x/mkspecs/linux-g++ -I. -I/opt/qt_47x/include/QtCore -I/opt/qt_47x/include/QtGui -I/opt/qt_47x/include/QtDeclarative -I/opt/qt_47x/include -I/usr/X11R6/include -I. -o main.o main.cpp
g++ -Wl,-O1 -Wl,-rpath,/opt/qt_47x/lib -o main main.o -L/opt/qt_47x/lib -L/usr/X11R6/lib -lQtDeclarative -L/opt/qt_47x/lib -lQtScript -lQtSvg -L/usr/X11R6/lib -lQtSql -lQtXmlPatterns -lQtNetwork -lQtGui -lQtCore -lpthread
```

Note: I installed Qt in another directory --> `/opt/qt_47x`  

<strong>Edit: Qt 5.x and later</strong>  

Add `QT += widgets` to the .pro file and solve this problem.  

#### Answer 2 (score 100)
In Qt 5 you now have to add `widgets` to the `QT` qmake variable (in your `MyProject.pro` file).  

```c
 QT += widgets
```

#### Answer 3 (score 29)
<strong>For QT 5</strong>  

<p><strong>Step1:</strong>
`.pro` (in pro file, add these 2 lines)</p>

```c
QT       += core gui
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets
```

<p><strong>Step2:</strong>
In `main.cpp` replace code: </p>

```c
#include <QtGui/QApplication> 
```

with:   

```c
#include <QApplication>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: Checking if a folder exists (and creating folders) in Qt, C++ (score [119925](https://stackoverflow.com/q/2241808) in 2017)

#### Question
<p>In Qt, how do I check if a given folder exists in the current directory?<br>
If it doesn't exist, how do I then create an empty folder?</p>

#### Answer accepted (score 214)
To check if a directory named "Folder" exists use:  

```c
QDir("Folder").exists();
```

To create a new folder named "MyFolder" use:  

```c
QDir().mkdir("MyFolder");
```

#### Answer 2 (score 137)
To both check if it exists and create if it doesn't, including intermediaries:  

```c
QDir dir("path/to/dir");
if (!dir.exists())
    dir.mkpath(".");
```

#### Answer 3 (score 12)
When you use QDir.mkpath() it returns true if the path already exists, in the other hand QDir.mkdir() returns false if the path already exists. So depending on your program you have to choose which fits better.  

You can see more on <a href="http://qt-project.org/doc/qt-4.8/qdir.html#mkpath">Qt Documentation</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: Display QImage with QtGui (score [116001](https://stackoverflow.com/q/4474086) in 2013)

#### Question
I am new to Qt, and I am trying to create a simple GUI Application that displays an image once a button has been clicked on.  

I can read the image in a `QImage` object, but is there any simple way to call a Qt function that takes the `QImage` as an input, and displays it?  

#### Answer accepted (score 6)
Thanks All, I found how to do it, which is the same as Dave and Sergey:  

I am using QT Creator:  

In the main GUI window create using the drag drop GUI and create label (e.g. "myLabel")  

In the callback of the button (clicked) do the following using the (*ui) pointer to the user interface window:  

```c
void MainWindow::on_pushButton_clicked()
{
     QImage imageObject;
     imageObject.load(imagePath);
     ui->myLabel->setPixmap(QPixmap::fromImage(imageObject));

     //OR use the other way by setting the Pixmap directly

     QPixmap pixmapObject(imagePath");
     ui->myLabel2->setPixmap(pixmapObject);
}
```

#### Answer 2 (score 68)
Simple, but complete example showing how to display QImage might look like this:  

```c
#include <QtGui/QApplication>
#include <QLabel>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QImage myImage;
    myImage.load("test.png");

    QLabel myLabel;
    myLabel.setPixmap(QPixmap::fromImage(myImage));

    myLabel.show();

    return a.exec();
}
```

#### Answer 3 (score 24)
Drawing an image using a `QLabel` seems like a bit of a kludge to me. With newer versions of Qt you can use a `QGraphicsView` widget. In Qt Creator, drag a `Graphics View` widget onto your UI and name it something (it is named `mainImage` in the code below). In `mainwindow.h`, add something like the following as `private` variables to your `MainWindow` class:  

```c
QGraphicsScene *scene;
QPixmap image;
```

Then just edit `mainwindow.cpp` and make the constructor something like this:  

```c
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent), ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    image.load("myimage.png");
    scene = new QGraphicsScene(this);
    scene->addPixmap(image);
    scene->setSceneRect(image.rect());

    ui->mainImage->setScene(scene);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: Interpreting segfault messages (score [115638](https://stackoverflow.com/q/2549214) in )

#### Question
What is the correct interpretation of the following segfault messages?  

```c
segfault at 10 ip 00007f9bebcca90d sp 00007fffb62705f0 error 4 in libQtWebKit.so.4.5.2[7f9beb83a000+f6f000]
segfault at 10 ip 00007fa44d78890d sp 00007fff43f6b720 error 4 in libQtWebKit.so.4.5.2[7fa44d2f8000+f6f000]
segfault at 11 ip 00007f2b0022acee sp 00007fff368ea610 error 4 in libQtWebKit.so.4.5.2[7f2aff9f7000+f6f000]
segfault at 11 ip 00007f24b21adcee sp 00007fff7379ded0 error 4 in libQtWebKit.so.4.5.2[7f24b197a000+f6f000]
```

#### Answer accepted (score 86)
This is a segfault due to following a null pointer trying to find code to run (that is, during an instruction fetch).  

<h5>If this were a program, not a shared library</h2>

Run `addr2line -e yourSegfaultingProgram 00007f9bebcca90d` (and repeat for the other instruction pointer values given) to see where the error is happening. Better, get a debug-instrumented build, and reproduce the problem under a debugger such as gdb.  

<h5>Since it's a shared library</h2>

You're hosed, unfortunately; it's not possible to know where the libraries were placed in memory by the dynamic linker after-the-fact. Reproduce the problem under `gdb`.  

<h5>What the error means</h2>

Here's the breakdown of the fields:  

<ul>
<li>`address` (after the `at`) - the location in memory the code is trying to access (it's likely that `10` and `11` are offsets from a pointer we expect to be set to a valid value but which is instead pointing to `0`)</li>
<li>`ip` - instruction pointer, ie. where the code which is trying to do this lives</li>
<li>`sp` - stack pointer</li>
<li><p>`error` - An error code for page faults; see below for what this means on x86.</p>

```c
/*
 * Page fault error code bits:
 *
 *   bit 0 ==    0: no page found       1: protection fault
 *   bit 1 ==    0: read access         1: write access
 *   bit 2 ==    0: kernel-mode access  1: user-mode access
 *   bit 3 ==                           1: use of reserved bit detected
 *   bit 4 ==                           1: fault was an instruction fetch
 */
```</li>
</ul>

#### Answer 2 (score 46)
Error 4 means "The cause was a user-mode read resulting in no page being found.". There's a tool that decodes it <a href="http://rgeissert.blogspot.com/p/segmentation-fault-error.html" rel="noreferrer">here</a>.  

Here's the definition from the kernel. Keep in mind that 4 means that bit 2 is set and no other bits are set. If you convert it to binary that becomes clear.  

```c
/*
 * Page fault error code bits
 *      bit 0 == 0 means no page found, 1 means protection fault
 *      bit 1 == 0 means read, 1 means write
 *      bit 2 == 0 means kernel, 1 means user-mode
 *      bit 3 == 1 means use of reserved bit detected
 *      bit 4 == 1 means fault was an instruction fetch
 */
#define PF_PROT         (1<<0)
#define PF_WRITE        (1<<1)
#define PF_USER         (1<<2)
#define PF_RSVD         (1<<3)
#define PF_INSTR        (1<<4)
```

Now then, "ip 00007f9bebcca90d" means the instruction pointer was at 0x00007f9bebcca90d when the segfault happened.  

"libQtWebKit.so.4.5.2[7f9beb83a000+f6f000]" tells you:  

<ul>
<li>The object the crash was in:  "libQtWebKit.so.4.5.2"</li>
<li>The base address of that object "7f9beb83a000"</li>
<li>How big that object is:  "f6f000"</li>
</ul>

If you take the base address and subtract it from the ip, you get the offset into that object:  

```c
0x00007f9bebcca90d - 0x7f9beb83a000 = 0x49090D
```

Then you can run addr2line on it:  

```c
addr2line -e /usr/lib64/qt45/lib/libQtWebKit.so.4.5.2 -fCi 0x49090D
??
??:0
```

In my case it wasn't successful, either the copy I installed isn't identical to yours, or it's stripped.  

#### Answer 3 (score 10)
Let's go to the source -- <a href="http://lxr.free-electrons.com/source/arch/x86/mm/fault.c?v=2.6.32#L683">2.6.32, for example</a>.  The message is printed by show_signal_msg() function in arch/x86/mm/fault.c if the show_unhandled_signals sysctl is set.  

"error" is not an errno nor a signal number, it's a "page fault error code" -- see definition of enum x86_pf_error_code.  

"[7fa44d2f8000+f6f000]" is starting address and size of virtual memory area where offending object was mapped at the time of crash.  Value of "ip" should fit in this region.  With this info in hand, it should be easy to find offending code in gdb.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: How to get the current TimeStamp? (score [112703](https://stackoverflow.com/q/2781119) in 2016)

#### Question
I'm trying to get the current time as TimeStamp without success.  

I have this code:  

```c
QDateTime setTime = QDateTime::fromString (QString("1970-07-18T14:15:09"), Qt::ISODate);
QDateTime current = QDateTime::currentDateTime();
uint msecs = setTime.time().msecsTo(current.time());

return  QString::number(msecs);
```

The output is  

```c
Sunday, January 25th 1970, 03:17:35 (GMT)
```

#### Answer accepted (score 35)
I think you are looking for this function:  

<a href="http://doc.qt.io/qt-5/qdatetime.html#toTime_t" rel="noreferrer">http://doc.qt.io/qt-5/qdatetime.html#toTime_t</a>  

<blockquote>
  uint QDateTime::toTime_t () const  
  
  Returns the datetime as the number of seconds that have passed since 1970-01-01T00:00:00, > Coordinated Universal Time (Qt::UTC).  
  
  On systems that do not support time zones, this function will behave as if local time were Qt::UTC.  
  
  See also setTime_t().  
</blockquote>

#### Answer 2 (score 77)
In Qt 4.7, there is the <a href="http://qt-project.org/doc/qt-5.0/qtcore/qdatetime.html#currentMSecsSinceEpoch" rel="noreferrer">`QDateTime::currentMSecsSinceEpoch()`</a> static function, which does exactly what you need, without any intermediary steps. Hence I'd recommend that for projects using Qt 4.7 or newer.  

#### Answer 3 (score 4)
Since Qt 5.8, we now have <a href="http://doc.qt.io/qt-5/qdatetime.html#currentSecsSinceEpoch" rel="nofollow noreferrer">`QDateTime::currentSecsSinceEpoch()`</a> to deliver the seconds directly, a.k.a. as real Unix timestamp. So, no need to divide the result by 1000 to get seconds anymore.  

Credits: also posted as comment to <a href="https://stackoverflow.com/a/4460647">this answer</a>. However, I think it is easier to find if it is a separate answer.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: Linking a qtDesigner .ui file to python/pyqt? (score [112212](https://stackoverflow.com/q/2398800) in 2010)

#### Question
So if I go into QtDesigner and build a UI, it'll be saved as a .ui file.  How can I make this as a python file or use this in python?  

#### Answer accepted (score 58)
Another way to use .ui in your code is:  

```c
from PyQt4 import QtCore, QtGui, uic
class MyWidget(QtGui.QWidget)
    ...
    #somewhere in constructor:
    uic.loadUi('MyWidget.ui', self)
```

both approaches are good. Do not forget, that if you use Qt resource files (extremely useful) for icons and so on, you must compile it too:  

```c
pyrcc4.exe -o ui/images_rc.py ui/images/images.qrc
```

Note, when `uic` compiles interface, it adds 'import images_rc' at the end of .py file, so you must compile resources into the file with this name, or rename it in generated code.  

#### Answer 2 (score 45)
Combining <a href="https://stackoverflow.com/a/2500905/544059">Max's answer</a> and <a href="http://www.riverbankcomputing.com/pipermail/pyqt/2007-April/015902.html" rel="noreferrer">Shriramana Sharma's mailing list post</a>, I built a small working example for loading a `mywindow.ui` file containing a `QMainWindow` (so just choose to create a Main Window in Qt Designer's `File-New` dialog).  

This is the code that loads it:  

```c
import sys
from PyQt4 import QtGui, uic

class MyWindow(QtGui.QMainWindow):
    def __init__(self):
        super(MyWindow, self).__init__()
        uic.loadUi('mywindow.ui', self)
        self.show()

if __name__ == '__main__':
    app = QtGui.QApplication(sys.argv)
    window = MyWindow()
    sys.exit(app.exec_())
```

#### Answer 3 (score 28)
You need to generate a python file from your ui file with the pyuic tool (site-packages\pyqt4\bin)  

```c
pyuic form1.ui > form1.py
```

with pyqt4  

```c
pyuic4.bat form1.ui > form1.py
```

Then you can import the form1 into your script.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: Qt c++ aggregate 'std::stringstream ss' has incomplete type and cannot be defined (score [110931](https://stackoverflow.com/q/11751486) in 2018)

#### Question
I have this function in my program that converts integers to strings:  

```c
    QString Stats_Manager::convertInt(int num)
    {
        stringstream ss;
        ss << num;
        return ss.str();
    }
```

But when ever i run this i get the error:  

```c
aggregate 'std::stringstream ss' has incomplete type and cannot be defined
```

Im not really sure what that means. But if you know how to fix it or need any more code please just comment. Thanks.  

#### Answer accepted (score 137)
You probably have a forward declaration of the class, but haven't included the header:  

```c
#include <sstream>

//...
QString Stats_Manager::convertInt(int num)
{
    std::stringstream ss;   // <-- also note namespace qualification
    ss << num;
    return ss.str();
}
```

#### Answer 2 (score 6)
Like it's written up there, you forget to type `#include &lt;sstream&gt;`  

```c
#include <sstream>
using namespace std;

QString Stats_Manager::convertInt(int num)
{
   stringstream ss;
   ss << num;
   return ss.str();
}
```

You can also use some other ways to convert `int` to `string`, like  

```c
char numstr[21]; // enough to hold all numbers up to 64-bits
sprintf(numstr, "%d", age);
result = name + numstr;
```

check <a href="https://stackoverflow.com/questions/191757/c-concatenate-string-and-int">this!</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: Console output in a Qt GUI app? (score [109338](https://stackoverflow.com/q/3360548) in 2015)

#### Question
I have a Qt GUI application running on Windows that allows command-line options to be passed and under some circumstances I want to output a message to the console and then quit, for example:  

```c
int main(int argc, char *argv[])
{
  QApplication a(argc, argv);

  if (someCommandLineParam)
  {
    std::cout << "Hello, world!";
    return 0;
  }

  MainWindow w;
  w.show();

  return a.exec();
}
```

However, the console messages do not appear when I run the app from a command-prompt.  Does anyone know how I can get this to work?  

#### Answer accepted (score 46)
Windows does not really support dual mode applications.   

To see console output you need to create a console application  

```c
CONFIG += console
```

However, if you double click on the program to start the GUI mode version then you will get a console window appearing, which is probably not what you want. To prevent the console window appearing you have to create a GUI mode application in which case you get no output in the console.  

One idea may be to create a second small application which is a console application and provides the output. This can call the second one to do the work.   

Or you could put all the functionality in a DLL then create two versions of the .exe file which have very simple main functions which call into the DLL. One is for the GUI and one is for the console.  

#### Answer 2 (score 12)
Add:  

```c
#ifdef _WIN32
if (AttachConsole(ATTACH_PARENT_PROCESS)) {
    freopen("CONOUT$", "w", stdout);
    freopen("CONOUT$", "w", stderr);
}
#endif
```

at the top of `main()`. This will enable output to the console only if the program is started in a console, and won't pop up a console window in other situations. If you want to create a console window to display messages when you run the app outside a console you can change the condition to:  

```c
if (AttachConsole(ATTACH_PARENT_PROCESS) || AllocConsole())
```

#### Answer 3 (score 6)
```c
void Console()
{
    AllocConsole();
    FILE *pFileCon = NULL;
    pFileCon = freopen("CONOUT$", "w", stdout);

    COORD coordInfo;
    coordInfo.X = 130;
    coordInfo.Y = 9000;

    SetConsoleScreenBufferSize(GetStdHandle(STD_OUTPUT_HANDLE), coordInfo);
    SetConsoleMode(GetStdHandle(STD_OUTPUT_HANDLE),ENABLE_QUICK_EDIT_MODE| ENABLE_EXTENDED_FLAGS);
}

int main(int argc, char *argv[])
{
    Console();
    std::cout<<"start@@";
    qDebug()<<"start!";
```

You can't use std::cout as others have said,my way is perfect even for some code can't include "qdebug" !  

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: How do I create a simple Qt console application in C++? (score [102046](https://stackoverflow.com/q/4180394) in 2010)

#### Question
I was trying to create a simple console application to try out Qt's XML parser. I started a project in VS2008 and got this template:  

```c
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    return a.exec();
}
```

Since I don't need event processing, I was wondering whether I may get into trouble if I neglect to create a QCoreApplication and running the event loop. The docs state that it's recommended in most cases.  

For the sake of curiosity however, I am wondering how could I make some generic task execute on the event loop and then terminate the application. I was unable to google a relevant example.  

#### Answer accepted (score 99)
Here is one simple way you could structure an application if you want an event loop running.  

```c
// main.cpp
#include <QtCore>

class Task : public QObject
{
    Q_OBJECT
public:
    Task(QObject *parent = 0) : QObject(parent) {}

public slots:
    void run()
    {
        // Do processing here

        emit finished();
    }

signals:
    void finished();
};

#include "main.moc"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    // Task parented to the application so that it
    // will be deleted by the application.
    Task *task = new Task(&a);

    // This will cause the application to exit when
    // the task signals finished.    
    QObject::connect(task, SIGNAL(finished()), &a, SLOT(quit()));

    // This will run the task from the application event loop.
    QTimer::singleShot(0, task, SLOT(run()));

    return a.exec();
}
```

#### Answer 2 (score 18)
Don't forget to add the   

```c
CONFIG += console 
```

flag in the qmake .pro file.  

<p>For the rest is just using some of Qt classes. 
One way I use it is to spawn processes cross-platform.</p>

#### Answer 3 (score 4)
You don't need the `QCoreApplication` at all, just include your Qt objects as you would other objects, for example:  

```c
#include <QtCore>

int main()
{
    QVector<int> a; // Qt object

    for (int i=0; i<10; i++)
    {
        a.append(i);
    }

    /* manipulate a here */

    return 0;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: How to specify different Debug/Release output directories in QMake .pro file (score [101236](https://stackoverflow.com/q/2580934) in )

#### Question
I have a Qt project and I would like to output compilation files outside the source tree.  

I currently have the following directory structure:  

```c
/
|_/build
|_/mylib
  |_/include
  |_/src
  |_/resources
```

Depending on the configuration (debug/release), I will like to output the resulting files inside the build directory under build/debug or build/release directories.  

How can I do that using a .pro file?  

#### Answer accepted (score 3)
The short answer is: <strong>you don't</strong>.  

You should run `qmake` followed by `make` in whatever build directory you want to build in. So, run it once in a `debug` directory, once in a `release` directory.  

That's how anyone building your project would expect it to work, and that's how Qt itself is set up to build, that's also how Qt Creator expects your `.pro` file to behave: it simply starts `qmake` and then `make` in the build folder for your target's chosen configuration.  

If you wish to create these folders and perform the two (or more) builds in them, you'll need a top-level makefile, possibly created from a top-level project file via qmake.  

It's not uncommon to have more than two build configurations, so you're unnecessarily committing yourself to only differentiating between a build and a release; you might have builds with different optimization levels, etc. <strong>The debug/release dichotomy is best left to rest in peace.</strong>  

#### Answer 2 (score 147)
For my Qt project, I use this scheme in *.pro file:  

```c
HEADERS += src/dialogs.h
SOURCES += src/main.cpp \
           src/dialogs.cpp

Release:DESTDIR = release
Release:OBJECTS_DIR = release/.obj
Release:MOC_DIR = release/.moc
Release:RCC_DIR = release/.rcc
Release:UI_DIR = release/.ui

Debug:DESTDIR = debug
Debug:OBJECTS_DIR = debug/.obj
Debug:MOC_DIR = debug/.moc
Debug:RCC_DIR = debug/.rcc
Debug:UI_DIR = debug/.ui
```

It`s simple, but nice! :)  

#### Answer 3 (score 49)
To change the directory for target dll/exe, use this in your pro file:  

```c
CONFIG(debug, debug|release) {
    DESTDIR = build/debug
} else {
    DESTDIR = build/release
}
```

You might also want to change directories for other build targets like object files and moc files (check <a href="http://qt-project.org/doc/qt-5/qmake-variable-reference.html" rel="noreferrer">qmake variable reference</a> for details or <a href="http://doc.qt.io/qt-4.8/qmake-function-reference.html#config-config" rel="noreferrer">qmake CONFIG() function reference</a>).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How to show another window from mainwindow in QT (score [101105](https://stackoverflow.com/q/1518317) in 2013)

#### Question
Platform: QT, Windows XP  

I am new to Qt. I want to show another window(what to do to open it as dialog) from `mainwindow`. I did "`add New Item -&gt;Qt Designer Form Class`", named it say `MyWindow`. But how to show this `MyWindow` from `mainwindow` ?  

#### Answer 2 (score 54)
<ol>
<li>Implement a slot in your QMainWindow where you will open your new Window,</li>
<li>Place a widget on your QMainWindow,</li>
<li>Connect a signal from this widget to a slot from the QMainWindow (for example: if the widget is a QPushButton connect the signal `click()` to the QMainWindow custom slot you have created).</li>
</ol>

Code example:  

<strong>MainWindow.h</strong>  

```c
// ...
include "newwindow.h"
// ...
public slots:
   void openNewWindow();
// ...
private:
   NewWindow *mMyNewWindow;
// ...
}
```

<strong>MainWindow.cpp</strong>  

```c
// ...
   MainWindow::MainWindow()
   {
      // ...
      connect(mMyButton, SIGNAL(click()), this, SLOT(openNewWindow()));
      // ...
   }
// ...
void MainWindow::openNewWindow()
{
   mMyNewWindow = new NewWindow(); // Be sure to destroy your window somewhere
   mMyNewWindow->show();
   // ...
}
```

This is an example on how display a custom new window. There are a lot of ways to do this.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: How to give a delay in loop execution using Qt (score [98368](https://stackoverflow.com/q/3831439) in 2015)

#### Question
In my application I want that when a loop is being executed, each time the control transfers to the loop, each execution must be delayed by a particular time. How can I do this?  

#### Answer accepted (score 48)
<p>EDIT (removed wrong solution).
EDIT (to add this other option):</p>

Another way to use it would be subclass QThread since it has protected *sleep methods.  

```c
QThread::usleep(unsigned long microseconds);
QThread::msleep(unsigned long milliseconds);
QThread::sleep(unsigned long second);
```

Here's the code to create your own *sleep method.  

```c
#include <QThread>    

class Sleeper : public QThread
{
public:
    static void usleep(unsigned long usecs){QThread::usleep(usecs);}
    static void msleep(unsigned long msecs){QThread::msleep(msecs);}
    static void sleep(unsigned long secs){QThread::sleep(secs);}
};
```

and you call it by doing this:  

```c
Sleeper::usleep(10);
Sleeper::msleep(10);
Sleeper::sleep(10);
```

This would give you a delay of 10 microseconds, 10 milliseconds or 10 seconds, accordingly. If the underlying operating system timers support the resolution.  

#### Answer 2 (score 25)
As an update of <a href="https://stackoverflow.com/a/3831460/1290438">@Live's answer</a>, for Qt ≥ 5.2 there is no more need to subclass `QThread`, as now the sleep functions are public:  

<blockquote>
  <h5>Static Public Members</h2>
  
  <ul>
  <li>`QThread *  currentThread()`</li>
  <li>`Qt::HANDLE     currentThreadId()`</li>
  <li>`int    idealThreadCount()`</li>
  <li>`void   msleep(unsigned long msecs)`</li>
  <li>`void   sleep(unsigned long secs)`</li>
  <li>`void   usleep(unsigned long usecs)`</li>
  <li>`void   yieldCurrentThread()`</li>
  </ul>
</blockquote>

cf <a href="http://qt-project.org/doc/qt-5/qthread.html#static-public-members" rel="noreferrer">http://qt-project.org/doc/qt-5/qthread.html#static-public-members</a>  

#### Answer 3 (score 8)
C++11 has some portable timer stuff. Check out <a href="http://en.cppreference.com/w/cpp/thread/sleep_for" rel="noreferrer">`sleep_for.`</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: Qt: How do I handle the event of the user pressing the 'X' (close) button? (score [97062](https://stackoverflow.com/q/17480984) in 2017)

#### Question
I am developing an application using Qt. I don't know which slot corresponds to the event of "the user clicking the 'X'(close) button of the window frame" i.e. this button:  

<img src="https://i.stack.imgur.com/rgFqm.png" alt="Close button of the window">  

If there isn't a slot for this, can anyone suggest me some other method by which I can start a function after the user presses that close button.  

#### Answer accepted (score 145)
If you have a `QMainWindow` you can override `closeEvent` method.  

```c
#include <QCloseEvent>
void MainWindow::closeEvent (QCloseEvent *event)
{
    QMessageBox::StandardButton resBtn = QMessageBox::question( this, APP_NAME,
                                                                tr("Are you sure?\n"),
                                                                QMessageBox::Cancel | QMessageBox::No | QMessageBox::Yes,
                                                                QMessageBox::Yes);
    if (resBtn != QMessageBox::Yes) {
        event->ignore();
    } else {
        event->accept();
    }
}
```

<br>If you're subclassing a `QDialog`, the `closeEvent` will not be called and so you have to override `reject()`:  

```c
void MyDialog::reject()
{
    QMessageBox::StandardButton resBtn = QMessageBox::Yes;
    if (changes) {
        resBtn = QMessageBox::question( this, APP_NAME,
                                        tr("Are you sure?\n"),
                                        QMessageBox::Cancel | QMessageBox::No | QMessageBox::Yes,
                                        QMessageBox::Yes);
    }
    if (resBtn == QMessageBox::Yes) {
        QDialog::reject();
    }
}
```

#### Answer 2 (score 15)
Well, I got it. One way is to override the <a href="http://doc.qt.io/qt-5/qwidget.html#closeEvent" rel="noreferrer">`QWidget::closeEvent`</a>`(QCloseEvent *event)` method in your class definition and add your code into that function. Example:  

```c
class foo : public QMainWindow
{
    Q_OBJECT
private:
    void closeEvent(QCloseEvent *bar);
    // ...
};


void foo::closeEvent(QCloseEvent *bar)
{
    // Do something
    bar->accept();
}
```

#### Answer 3 (score 12)
You can attach a SLOT to the  

```c
void aboutToQuit();
```

signal of your QApplication. This signal should be raised just before app closes.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: Convert a double to a QString (score [93114](https://stackoverflow.com/q/5940846) in 2017)

#### Question
I am writing a program in QT. I want to convert a `double` into a `Qstring` in C++.  

#### Answer accepted (score 82)
Use QString's number method (docs are <a href="https://doc.qt.io/qt-5/qstring.html#number-2" rel="noreferrer">here</a>):  

```c
double valueAsDouble = 1.2;
QString valueAsString = QString::number(valueAsDouble);
```

#### Answer 2 (score 16)
Instead of `QString::number()` i would use <a href="https://doc.qt.io/qt-5/qlocale.html#toString-6" rel="noreferrer">`QLocale::toString()`</a>, so i can get locale aware group seperatores like german "1.234.567,89".  

#### Answer 3 (score 8)
You can use arg(), as follow:  

```c
double dbl = 0.25874601;
QString str = QString("%1").arg(dbl);
```

This overcomes the problem of: "Fixed precision" at the other functions like: setNum() and number(), which will generate random numbers to complete the defined precision  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How to change the Title of the window in Qt? (score [91005](https://stackoverflow.com/q/10598269) in 2012)

#### Question
How to change the title of the window in Qt? (Both for `QDialog` and `QMainWindow`.)  

#### Answer accepted (score 102)
```c
void    QWidget::setWindowTitle ( const QString & )
```

EDIT: <strong>If you are using QtDesigner</strong>, on the property tab, there is an editable property called <strong><em>windowTitle</em></strong> which can be found under the QWidget section. The property tab can usually be found on the lower right part of the designer window.  

#### Answer 2 (score 45)
For new Qt users this is a little more confusing than it seems if you are using QT Designer and `.ui` files.  

Initially I tried to use `ui-&gt;setWindowTitle`, but that doesn't exist.  `ui` is not a `QDialog` or a `QMainWindow`.  

The owner of the `ui` is the `QDialog` or `QMainWindow`, the `.ui` just describes how to lay it out. In that case, you would use:  

```c
this->setWindowTitle("New Title");
```

I hope this helps someone else.  

#### Answer 3 (score 2)
I know this is years later but I ran into the same problem. The solution I found was to change the window title in main.cpp. I guess once the `w.show();` is called the window title can no longer be changed. In my case I just wanted the title to reflect the current directory and it works.  

```c
int main(int argc, char *argv[]) 
{
QApplication a(argc, argv);
MainWindow w;
w.setWindowTitle(QDir::currentPath());
w.show();

return a.exec();
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Cannot connect to X server :0.0 with a Qt application (score [90554](https://stackoverflow.com/q/646930) in 2012)

#### Question
Compiling on Fedora 10.  

I have just started my first qt GUI application. I used all the default settings.  

Its just a simple form. It builds OK without any errors. But when I try and run the application. I get the following message:  

```c
Starting /home/rob/projects/qt/test1/test1/test1...
No protocol specified
test1: cannot connect to X server :0.0
```

Thanks for any advice,  

#### Answer accepted (score 41)
The general causes for this are as follows:   

<ol>
<li><p>DISPLAY not set in the environment.<br>
<strong>Solution</strong>:   </p>

```c
export DISPLAY=:0.0
./myQtCmdHere
```

( This one doesn't appear to be the one at fault though, as its saying which X display its trying to connect to. Also, its not always 0.0, but most of the time it is )  </li>
<li><p>Non-Authorised User trying to run the X Application<br>
<strong>Solution</strong> ( as X owning user, ie: yourself )</p>

```c
xhost +local:root   # where root is the local user you want to grant access to. 
```</li>
</ol>

#### Answer 2 (score 5)
Also, if you'd like your X server to be able to receive connection over TCP, these days you must almost always explicitly enable this. To test whether you're server is allowing remote TCP connections try:  

telnet 127.0.0.1 6000  

If telnet is able to connect, then your X server is listening. If it can't, then neither will any remote X application and you need to enable remote TCP connections on your server.  

#### Answer 3 (score 2)
<p>Adding to above answers. 
I was in a similar situation while running tests for <a href="https://github.com/tushar-rishav/code2pdf" rel="nofollow">Code2Pdf</a> at travis.
I solved the problem using <a href="http://manpages.ubuntu.com/manpages/lucid/man1/xvfb-run.1.html" rel="nofollow">xvfb-run</a>. Quoting from the manpage,</p>

<blockquote>
  xvfb-run is a wrapper for the Xvfb(1x)  command  which  simplifies the task of running commands (typically an X client, or a script containing a list of clients to be run) within a virtual X server environment.  
</blockquote>

The script that I wrote was:  

```c
check_install_xvfb() { # check and install xvfb
    if hash xvfb-run 2>/dev/null; then
        :
    else
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get install xvfb
    fi
}
check_install_xvfb
export DISPLAY=localhost:1.0
xvfb-run -a bash .misc/tests.sh
# .misc/tests.sh is script that runs unit tests. You can replace it with something suitable to you.
```

<blockquote>
  Please bear with my bash code style. I am a noob bash programmer.   
</blockquote>

<p>Running the above script helped me.
You can see the <a href="https://travis-ci.org/tushar-rishav/code2pdf/builds/120957939" rel="nofollow">failing build</a> and <a href="https://travis-ci.org/tushar-rishav/code2pdf/builds/120988164" rel="nofollow">passing build</a>. </p>

Hope it helps  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: 'for' loop vs Qt's 'foreach' in C++ (score [89778](https://stackoverflow.com/q/771008) in 2013)

#### Question
Which is better (or faster), a C++ `for` loop or the `foreach` operator provided by Qt? For example, the following condition  

```c
QList<QString> listofstrings;
```

Which is better?  

```c
foreach(QString str, listofstrings)
{
    //code
}
```

or  

```c
int count = listofstrings.count();
QString str = QString();
for(int i=0;i<count;i++)
{
    str = listofstrings.at(i);
    //Code
}
```

#### Answer accepted (score 148)
It really doesn't matter in most cases.  

The large number of questions on StackOverflow regarding whether this method or that method is faster, belie the fact that, in the vast majority of cases, code spends most of its time sitting around waiting for users to do something.  

If you <em>are</em> really concerned, profile it for yourself and act on what you find.  

But I think you'll most likely find that only in the most intense data-processing-heavy work does this question matter. The difference may well be only a couple of seconds and even then, only when processing huge numbers of elements.  

Get your code working <em>first</em>. Then get it working <em>fast</em> (and only if you find an actual performance issue).  

Time spent optimising before you've finished the functionality and can properly profile, is mostly wasted time.  

#### Answer 2 (score 23)
First off, I'd just like to say I agree with Pax, and that the speed probably doesn't enter into it. foreach wins hands down based on readability, and that's enough in 98% of cases.  

<p>But of course the Qt guys have looked into it and actually done some profiling: 
<a href="http://blog.qt.io/blog/2009/01/23/iterating-efficiently/" rel="noreferrer">http://blog.qt.io/blog/2009/01/23/iterating-efficiently/</a></p>

The main lesson to take away from that is: use const references in read only loops as it avoids the creation of temporary instances. It also make the purpose of the loop more explicit, regardless of the looping method you use.  

#### Answer 3 (score 14)
<strong>It really doesn't matter</strong>. Odds are if your program is slow, this isn't the problem. However, it should be noted that you aren't make a completely equal comparison. Qt's `foreach` is more similar to this (this example will use `QList&lt;QString&gt;`):  

```c
for(QList<QString>::iterator it = Con.begin(); it != Con.end(); ++it) {
    QString &str = *it;
    // your code here
}
```

The macro is able to do this by using some compiler extensions (like GCC's `__typeof__`) to get the type of the container passed. Also imagine that boost's `BOOST_FOREACH` is very similar in concept.  

The reason why your example isn't fair is that your non-Qt version is adding extra work.  

You are indexing instead of really iterating. If you are using a type with non-contiguous allocation (I suspect this might be the case with `QList&lt;&gt;`), then indexing will be more expensive since the code has to calculate "where" the n-th item is.  

That being said. It <strong>still</strong> doesn't matter. The timing difference between those two pieces of code will be negligible if existent at all. Don't waste your time worrying about it. Write whichever you find more clear and understandable.  

<strong>EDIT:</strong> As a bonus, currently I strongly favor the C++11 version of container iteration, it is clean, concise and simple:  

```c
for(QString &s : Con) {
    // you code here
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: How to link opencv in QtCreator and use Qt library (score [89274](https://stackoverflow.com/q/15881913) in 2013)

#### Question
<p>This question must be duplicate many times, but it just doesn't work and sometimes it still remains unanswered. Sources of information are mainly these<br>
<a href="http://www.laganiere.name/opencvCookbook/chap1s1_2.shtml">http://www.laganiere.name/opencvCookbook/chap1s1_2.shtml</a><br>
<a href="http://www.youtube.com/watch?v=dgcXYQijV6c">http://www.youtube.com/watch?v=dgcXYQijV6c</a><br></p>

This is the summation of what I think one should/can do. (And now it works for me.) Hopefully I mentioned everything from the very beginning, the aim is to write a very clear tutorial.<br>  

<strong>Installation of OpenCV for QtCreator</strong><br>  

<ol>
<li>I have already MS Visual Studio 2010 Professional installed. (I have a free licence as a student) - I think this is not necessary, just a mention</li>
<li><strong>Download:</strong> Qt 5.0.1 for Windows 32-bit (MinGW 4.7, 823 MB)<br>
2.1 <strong>Install:</strong> Warning, everything that Qt uses (e.g. OpenCV) must be in directories that don't contain white-spaces in their names. - i.e. "Program Files" is wrong. (But I don't want different program files to accumulate directly on C, so I've only made a folder "Programs" in which everything important is installed)</li>
<li><strong>Download:</strong> cmake-2.8.10.2-win32-x86.exe - Install for all users (this can be in Program Files)   </li>
<li><strong>Download:</strong> OpenCV-2.4.0.exe, extract to: <i>C:\Programs\opencv24</i> - it'll create a dir "opencv"; add another folder "opencv_bin". Now it looks like this:<br> 
<i>C:\Programs\opencv24\opencv*</i><br>
<i>C:\Programs\opencv24\opencv_bin</i></li>
<li><strong>Set PATH environment variable</strong>, so that there be a link to MinGW compiler. e.g. <i>C:\Programs\Qt\Qt5.0.1\Tools\MinGW\bin;</i></li>
<li><strong>Start cmake-gui.exe</strong><br>
6.1 <strong>source code:</strong> set the default dir for OpenCV; <i>C:\Programs\opencv24\opencv</i><br>
6.2 <strong>binaries:</strong> set the opencv_bin dir; C:\Programs\copencv24\opencv_bin<br>
6.3 <strong>click configure:</strong><ul>
<li> Choose <strong>MinGW Makefiles</strong> and <strong>Specify native compilers</strong>, click next</li>
<li> Field C is for gcc.exe; <i>C:/Programs/Qt/Qt5.0.1/Tools/MinGW/bin/gcc.exe</i></li>
<li> Field C++ is for g++.exe; <i>C:/Programs/Qt/Qt5.0.1/Tools/MinGW/bin/g++.exe</i></li>
Field fortran can be empty, click finish
</ul>
6.4 <strong>Many red lines will appear</strong> To the search field enter one by one: WITH_QT, WITH_TBB, WITH_IPP, WITH_CUDA, CMAKE_BUILD_TYPE<ul>
<li> WITH_QT - must be selected. </li>
<li> WITH_TBB, WITH_IPP, WITH_CUDA - must be unselected</li>
<li> CMAKE_BUILD_TYPE - click and enter a text "Debug" (without quotes).</li>
Clear the text from the Search field.
</ul>
6.5 <strong>click configure</strong> and keep clicking configure until all red lines are gone, then <strong>click generate</strong> and <strong>close</strong> <em>cmake-gui.exe</em></li>
<li>Go to the <strong><em>terminal (~command prompt)</em></strong>, cd to the directory where are the builds <i>(opencv_bin)</i> and type <strong><em>mingw32-make</em></strong><br></li>
<li>When the process ends after a long time, type <strong>mingw32-make install</strong><br></li>
<li>Add into Path variable the path to the QtCreator/bin<i> C:\Programs\Qt\Qt5.0.1\Tools\QtCreator\bin</i></li>
</ol>

Now I have created a new console app in QtCreator.  

```c
//cvHello.pro
QT       += core
QT       -= gui

TARGET = cvHello
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app
INCLUDEPATH += C:/Programs/opencv24/opencv_bin2/install/include
LIBS += "C:/Programs/opencv24/opencv_bin2/bin/*.dll"

SOURCES += main.cpp
OTHER_FILES += \
    img.JPG
```

And the main file:  

```c
//main.cpp
#include <iostream>
#include "opencv2/core/core.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv/cv.h"

using namespace std;

int main()
{
    cout << "Hello World!" << endl;

    cv::Mat mat;
    mat = cv::imread("img.JPG");
    cvNamedWindow("hello");
    cv::imshow("hello",mat);

    cvWaitKey(0);

    return 0;
}
```

#### Answer accepted (score 13)
Finally I am starting to be happy. When adjusting this question I had to try all ways, how to define LIBS. Listing them manually helped, at first I wrote them somehow wrongly.  

This is how it works finally:  

```c
LIBS += -LC:\\Programs\\opencv24\\opencv_bin2\\bin \
    libopencv_core240d \
    libopencv_highgui240d \
    libopencv_imgproc240d \
    libopencv_features2d240d \
    libopencv_calib3d240d \
```

Btw if I've made any grammar mistakes, I am sorry for my english. :)  

#### Answer 2 (score 2)
The originally accepted answer did not work for me, I am running MSVC2013 Professional and QT5.9. I found SIMPLE and SUREFIRE CROSS-PLATFORM solution that should help anyone who is trying to link an external library (like openCV) with QT.   

The steps listed below are found in the Qt5 documentation: <a href="http://doc.qt.io/qtcreator/creator-project-qmake-libraries.html" rel="nofollow noreferrer">http://doc.qt.io/qtcreator/creator-project-qmake-libraries.html</a> under the "To Add Library" section.  

<ol>
<li>Right click on the project file located in the 'project pane' on the left side of the creator... and select "Add Library..."</li>
<li>Follow the instructions of the wizard</li>
</ol>

Let me add some specificity from here:  

<ol start="3">
<li>Select "External Library"</li>
<li>For the "Library File" navigate to your opencv_worldXXX.lib file (or opencv_worldXXXd.lib file, you will notice that by specifying only one or the other the wizard has a checkbox which includes the other automatically) <strong>[ex. ...\opencv\build\x64\vc12\lib\opncv_world310.lib]</strong></li>
<li>For the "Include Folder" navigate to the "include" folder within the build. <strong>[ex. ...\opencv\build\include]</strong></li>
<li>Select your operating system, dynamic/static library (whichever is appropriate)</li>
<li>Hit NEXT, CLEAN UP, and RUN!</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: QByteArray to QString (score [87770](https://stackoverflow.com/q/14131127) in 2017)

#### Question
I'm having issues with `QByteArray` and `QString`.  

I'm reading a file and stores its information in a `QByteArray`. The file is in unicode, so it contains something like: `t\0 e\0 s\0 t\0 \0 \0`  

I'm trying to compare this value to my specified value, but it fails, because in the debugger I see it's not an unicode string.  

The code will explain everything:  

```c
QByteArray Data; //contains unicode string "t\0 e\0 s\0 t\0 \0 \0"
QString myValue = "test"; //value to compare.
if(Data.contains(myValue))
    //do some stuff.
else
    //do other stuff.
```

In the debugger, it shows me that the variable `Data` has the value `"t\0 e\0 s\0 t\0 \0 \0"` and `myValue` has the value `"test"`. How can I fix it?  

#### Answer accepted (score 26)
You can use <a href="http://doc.qt.io/qt-5/qtextcodec.html#codecForMib">QTextCodec</a> to convert the bytearray to a string:  

```c
QString DataAsString = QTextCodec::codecForMib(1015)->toUnicode(Data);
```

(1015 is UTF-16, 1014 UTF-16LE, 1013 UTF-16BE, 106 UTF-8)  

From your example we can see that the string `"test"` is encoded as  `"t\0 e\0 s\0 t\0 \0 \0"` in your encoding, i.e. every ascii character is followed by a `\0`-byte, or resp. every ascii character is encoded as 2 bytes. The only  unicode encoding in which ascii letters are encoded in this way, are UTF-16 or UCS-2 (which is a restricted version of UTF-16), so in your case the 1015 mib is needed (assuming your local endianess is the same as the input endianess).  

#### Answer 2 (score 14)
you can use `QString::fromAscii()`  

```c
QByteArray data = entity->getData();
QString s_data = QString::fromAscii(data.data());
```

with `data()` returning a `char*`  

for QT5, you should use `fromCString()` instead, as `fromAscii()` is deprecated, see <strike><a href="https://bugreports.qt-project.org/browse/QTBUG-21872" rel="noreferrer">https://bugreports.qt-project.org/browse/QTBUG-21872</a></strike> <a href="https://bugreports.qt.io/browse/QTBUG-21872" rel="noreferrer">https://bugreports.qt.io/browse/QTBUG-21872</a>  

#### Answer 3 (score 11)
You can use:  

```c
QString::fromStdString(byteArray.toStdString())
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Read a text file line by line in Qt (score [86068](https://stackoverflow.com/q/5444959) in 2015)

#### Question
How can I read a text file line by line in Qt?  

I'm looking for the Qt equivalent to:  

```c
std::ifstream infile;
std::string line;
while (std::getline(infile, line))
{
   ...
}
```

#### Answer accepted (score 85)
Use this code:  

```c
QFile inputFile(fileName);
if (inputFile.open(QIODevice::ReadOnly))
{
   QTextStream in(&inputFile);
   while (!in.atEnd())
   {
      QString line = in.readLine();
      ...
   }
   inputFile.close();
}
```

#### Answer 2 (score 3)
```c
QFile inputFile(QString("/path/to/file"));
inputFile.open(QIODevice::ReadOnly);
if (!inputFile.isOpen())
    return;

QTextStream stream(&inputFile);
QString line = stream.readLine();
while (!line.isNull()) {
    /* process information */

    line = stream.readLine();
};
```

#### Answer 3 (score 1)
Since Qt 5.5 you can use `QTextStream::readLineInto`. It behaves similar to `std::getline` and is maybe faster as `QTextStream::readLine`, because it reuses the string:  

```c
QIODevice* device;
QTextStream in(&device);

QString line;
while (in.readLineInto(&line)) {
  // ...
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: How to use QTimer (score [85340](https://stackoverflow.com/q/11651852) in 2014)

#### Question
In Qt I'm trying to set a `QTimer` that calls a function called "update" every second. Here is my .cpp file:  

```c
#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QTimer>
#include "QDebug"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(update()));
    timer->start(1000);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::update()
{
    qDebug() << "update";
}
```

and the main:  

```c
#include <QtGui/QApplication>
#include "mainwindow.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}
```

The project is being build, but it doesn't execute update, since the line "update" is not showing anywhere... Does anybody see what I´m doing wrong?  

#### Answer accepted (score 12)
<ol>
<li><p>It's good practice to give a parent to your `QTimer` to use Qt's memory management system.</p></li>
<li><p>`update()` is a <em>QWidget</em> function - is that what you are trying to call or not? <a href="http://qt-project.org/doc/qt-4.8/qwidget.html#update" rel="nofollow noreferrer">http://qt-project.org/doc/qt-4.8/qwidget.html#update</a>. </p></li>
<li><p>If number 2 does not apply, make sure that the function you are trying to trigger is declared as a slot in the header.</p></li>
<li><p>Finally if none of these are your issue, it would be helpful to know if you are getting any run-time connect errors.</p></li>
</ol>

#### Answer 2 (score 15)
Other way is using of built-in method start timer &amp; event TimerEvent.  

Header:  

```c
#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    Ui::MainWindow *ui;
    int timerId;

protected:
    void timerEvent(QTimerEvent *event);
};

#endif // MAINWINDOW_H
```

Source:  

```c
#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    timerId = startTimer(1000);
}

MainWindow::~MainWindow()
{
    killTimer(timerId);
    delete ui;
}

void MainWindow::timerEvent(QTimerEvent *event)
{
    qDebug() << "Update...";
}
```

#### Answer 3 (score 0)
mytimer.h:  

```c
    #ifndef MYTIMER_H
    #define MYTIMER_H

    #include <QTimer>

    class MyTimer : public QObject
    {
        Q_OBJECT
    public:
        MyTimer();
        QTimer *timer;

    public slots:
        void MyTimerSlot();
    };

    #endif // MYTIME
```

mytimer.cpp:  

```c
#include "mytimer.h"
#include <QDebug>

MyTimer::MyTimer()
{
    // create a timer
    timer = new QTimer(this);

    // setup signal and slot
    connect(timer, SIGNAL(timeout()),
          this, SLOT(MyTimerSlot()));

    // msec
    timer->start(1000);
}

void MyTimer::MyTimerSlot()
{
    qDebug() << "Timer...";
}
```

main.cpp:  

```c
#include <QCoreApplication>
#include "mytimer.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    // Create MyTimer instance
    // QTimer object will be created in the MyTimer constructor
    MyTimer timer;

    return a.exec();
}
```

If we run the code:  

```c
Timer...
Timer...
Timer...
Timer...
Timer...
...
```

<a href="https://www.bogotobogo.com/Qt/Qt5_QTimer.php" rel="nofollow noreferrer">resources</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: Hide console of Windows Application (score [85169](https://stackoverflow.com/q/2139637) in 2012)

#### Question
<p>I have a Qt application, and when I run this application, there is a console opening behind it. In development it is nice because i see debug outputs on the console, but when I want to give this executable to the customer there should be no console window.
how do I hide it?</p>

(I am using Visual Studio 2008)  

#### Answer accepted (score 49)
It sounds like your linker configuration is incorrect.  Right-click the project, Properties, Linker, System, SubSystem setting.  Make sure "Windows" is selected, not "Console".  

And, change main() to WinMain().  

#### Answer 2 (score 109)
In the project build linker options set  

```c
/SUBSYSTEM:windows
/ENTRY:mainCRTStartup
```

Or use the following <em>#pragma</em> in the source file with the `int main(...)`  

```c
#pragma comment(linker, "/SUBSYSTEM:windows /ENTRY:mainCRTStartup")
```

#### Answer 3 (score 15)
You can get rid of the console by calling:  

```c
FreeConsole();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: How to create/read/write JSon files in Qt5 (score [83939](https://stackoverflow.com/q/15893040) in 2014)

#### Question
Qt5 has a new JSon parser and I want to use it.  The problem is that it isn't too clear about what the functions do in layman's terms and how to write code with it.  That or I could be reading it wrong.  

I want to know the code on creating a Json file in Qt5 and what "encapsulates" mean.  

#### Answer accepted (score 91)
<strong>Example: Read json from file</strong>  

```c
/* test.json */
{
   "appDesc": {
      "description": "SomeDescription",
      "message": "SomeMessage"
   },
   "appName": {
      "description": "Home",
      "message": "Welcome",
      "imp":["awesome","best","good"]
   }
}


void readJson()
   {
      QString val;
      QFile file;
      file.setFileName("test.json");
      file.open(QIODevice::ReadOnly | QIODevice::Text);
      val = file.readAll();
      file.close();
      qWarning() << val;
      QJsonDocument d = QJsonDocument::fromJson(val.toUtf8());
      QJsonObject sett2 = d.object();
      QJsonValue value = sett2.value(QString("appName"));
      qWarning() << value;
      QJsonObject item = value.toObject();
      qWarning() << tr("QJsonObject of description: ") << item;

      /* in case of string value get value and convert into string*/
      qWarning() << tr("QJsonObject[appName] of description: ") << item["description"];
      QJsonValue subobj = item["description"];
      qWarning() << subobj.toString();

      /* in case of array get array and convert into string*/
      qWarning() << tr("QJsonObject[appName] of value: ") << item["imp"];
      QJsonArray test = item["imp"].toArray();
      qWarning() << test[1].toString();
   }
```

<hr>

<strong>OUTPUT</strong>  

```c
QJsonValue(object, QJsonObject({"description": "Home","imp": ["awesome","best","good"],"message": "YouTube"}) ) 
"QJsonObject of description: " QJsonObject({"description": "Home","imp": ["awesome","best","good"],"message": "YouTube"}) 
"QJsonObject[appName] of description: " QJsonValue(string, "Home") 
"Home" 
"QJsonObject[appName] of value: " QJsonValue(array, QJsonArray(["awesome","best","good"]) ) 
"best" 
```

<hr>

<strong>Example: Read json from string</strong>  

Assign json to string as below and use the `readJson()` function shown before:  

```c
val =   
'  {
       "appDesc": {
          "description": "SomeDescription",
          "message": "SomeMessage"
       },
       "appName": {
          "description": "Home",
          "message": "Welcome",
          "imp":["awesome","best","good"]
       }
    }';
```

<hr>

<strong>OUTPUT</strong>  

```c
QJsonValue(object, QJsonObject({"description": "Home","imp": ["awesome","best","good"],"message": "YouTube"}) ) 
"QJsonObject of description: " QJsonObject({"description": "Home","imp": ["awesome","best","good"],"message": "YouTube"}) 
"QJsonObject[appName] of description: " QJsonValue(string, "Home") 
"Home" 
"QJsonObject[appName] of value: " QJsonValue(array, QJsonArray(["awesome","best","good"]) ) 
"best" 
```

#### Answer 2 (score 2)
Sadly, many JSON C++ libraries have APIs that are non trivial to use, while JSON was intended to be easy to use.  

So I tried <a href="http://www.genivia.com/doc/xml-rpc-json/html/index.html" rel="nofollow">jsoncpp</a> from the <a href="http://www.genivia.com/tutorials.html" rel="nofollow">gSOAP tools</a> on the JSON doc shown in one of the answers above and this is the code generated with jsoncpp to construct a JSON object in C++ which is then written in JSON format to std::cout:  

```c
value x(ctx);
x["appDesc"]["description"] = "SomeDescription";
x["appDesc"]["message"] = "SomeMessage";
x["appName"]["description"] = "Home";
x["appName"]["message"] = "Welcome";
x["appName"]["imp"][0] = "awesome";
x["appName"]["imp"][1] = "best";
x["appName"]["imp"][2] = "good";
std::cout << x << std::endl;
```

and this is the code generated by jsoncpp to parse JSON from std::cin and extract its values (replace `USE_VAL` as needed):  

```c
value x(ctx);
std::cin >> x;
if (x.soap->error)
  exit(EXIT_FAILURE); // error parsing JSON
#define USE_VAL(path, val) std::cout << path << " = " << val << std::endl
if (x.has("appDesc"))
{
  if (x["appDesc"].has("description"))
    USE_VAL("$.appDesc.description", x["appDesc"]["description"]);
  if (x["appDesc"].has("message"))
    USE_VAL("$.appDesc.message", x["appDesc"]["message"]);
}
if (x.has("appName"))
{
  if (x["appName"].has("description"))
    USE_VAL("$.appName.description", x["appName"]["description"]);
  if (x["appName"].has("message"))
    USE_VAL("$.appName.message", x["appName"]["message"]);
  if (x["appName"].has("imp"))
  {
    for (int i2 = 0; i2 < x["appName"]["imp"].size(); i2++)
      USE_VAL("$.appName.imp[]", x["appName"]["imp"][i2]);
  }
}
```

This code uses the JSON C++ API of gSOAP 2.8.28. I don't expect people to change libraries, but I think this comparison helps to put JSON C++ libraries in perspective.  

#### Answer 3 (score 0)
An example on how to use that would be great. There is a couple of examples at the <a href="http://www.qtcentre.org/threads/52857-reading-JSON-file-in-Qt5" rel="nofollow">Qt forum</a>, but you're right that the official documentation should be expanded.  

`QJsonDocument` on its own indeed doesn't produce anything, you will have to add the data to it. That's done through the `QJsonObject`, `QJsonArray` and `QJsonValue` classes. The top-level item needs to be either an array or an object (because `1` is not a valid json document, while `{foo: 1}` is.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: Get elapsed time in Qt (score [83913](https://stackoverflow.com/q/244646) in 2015)

#### Question
I'm looking for the equivalent in Qt to `GetTickCount()`  

Something that will allow me to measure the time it takes for a segment of code to run as in:  

```c
uint start = GetTickCount();
// do something..
uint timeItTook = GetTickCount() - start;
```

any suggestions?  

#### Answer accepted (score 90)
How about <a href="http://doc.qt.io/qt-5/qtime.html" rel="noreferrer">`QTime`</a>?  Depending on your platform it should have 1 millisecond accuracy.  Code would look something like this:  

```c
QTime myTimer;
myTimer.start();
// do something..
int nMilliseconds = myTimer.elapsed();
```

#### Answer 2 (score 115)
I think it's probably better to use <a href="http://doc.qt.io/qt-5/qelapsedtimer.html" rel="noreferrer">`QElapsedTimer`</a> since that is why the class exists in the first place. It was introduced with Qt 4.7. Note that it is also immuned to system's clock time change.  

Example usage:  

```c
#include <QDebug>
#include <QElapsedTimer>
...
...
QElapsedTimer timer;
timer.start();
slowOperation();  // we want to measure the time of this slowOperation()
qDebug() << timer.elapsed();
```

#### Answer 3 (score 37)
<p>Even if the first answer was accepted, the rest of the people who read the answers should consider `sivabudh`'s suggestion. <br/>
<a href="http://doc.qt.io/qt-5/qelapsedtimer.html" rel="nofollow noreferrer">`QElapsedTimer`</a> can also be used to calculate the time in nanoseconds. <br/>
Code example:</p>

```c
QElapsedTimer timer;
qint64 nanoSec;
timer.start();
//something happens here
nanoSec = timer.nsecsElapsed();
//printing the result(nanoSec)
//something else happening here
timer.restart();
//some other operation
nanoSec = timer.nsecsElapsed();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: QComboBox - set selected item based on the item's data (score [83818](https://stackoverflow.com/q/4340415) in 2018)

#### Question
What would be the best way of selecting an item in a QT combo box out of a predefined list of `enum` based unique values.  

In the past I have become accustomed to .NET's style of selection where the item can be selected by setting the selected property to the item's value you wish to select:  

```c
cboExample.SelectedValue = 2;
```

Is there anyway to do this with QT based on the item's data, if the data is a C++ enumeration?  

#### Answer accepted (score 97)
You lookup the value of the data with `findData()` and then use `setCurrentIndex()`  

```c
QComboBox* combo = new QComboBox;
combo->addItem("100",100.0);    // 2nd parameter can be any Qt type
combo->addItem .....

float value=100.0;
int index = combo->findData(value);
if ( index != -1 ) { // -1 for not found
   combo->setCurrentIndex(index);
}
```

#### Answer 2 (score 22)
<p>You can also have a look at the method findText(const QString &amp; text) from QComboBox; it returns the index of the element which contains the given text, (-1 if not found).
The advantage of using this method is that you don't need to set the second parameter when you add an item.</p>

Here is a little example :  

```c
/* Create the comboBox */
QComboBox   *_comboBox = new QComboBox;

/* Create the ComboBox elements list (here we use QString) */
QList<QString> stringsList;
stringsList.append("Text1");
stringsList.append("Text3");
stringsList.append("Text4");
stringsList.append("Text2");
stringsList.append("Text5");

/* Populate the comboBox */
_comboBox->addItems(stringsList);

/* Create the label */
QLabel *label = new QLabel;

/* Search for "Text2" text */
int index = _comboBox->findText("Text2");
if( index == -1 )
    label->setText("Text2 not found !");
else
    label->setText(QString("Text2's index is ")
                   .append(QString::number(_comboBox->findText("Text2"))));

/* setup layout */
QVBoxLayout *layout = new QVBoxLayout(this);
layout->addWidget(_comboBox);
layout->addWidget(label);
```

#### Answer 3 (score 3)
If you know the text in the combo box that you want to select, just use the setCurrentText() method to select that item.  

```c
ui->comboBox->setCurrentText("choice 2");
```

From the Qt 5.7 documentation  

<blockquote>
  <p>The setter setCurrentText() simply calls setEditText() if the combo
  box is editable. Otherwise, if there is a matching text in the list,
  currentIndex is set to the corresponding index.</p>
</blockquote>

So as long as the combo box is not editable, the text specified in the function call will be selected in the combo box.  

Reference: <a href="http://doc.qt.io/qt-5/qcombobox.html#currentText-prop" rel="nofollow noreferrer">http://doc.qt.io/qt-5/qcombobox.html#currentText-prop</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: Qt: resizing a QLabel containing a QPixmap while keeping its aspect ratio (score [83053](https://stackoverflow.com/q/8211982) in 2017)

#### Question
I use a QLabel to display the content of a bigger, dynamically changing QPixmap to the user. It would be nice to make this label smaller/larger depending on the space available. The screen size is not always as big as the QPixmap.  

How can I modify the `QSizePolicy` and `sizeHint()` of the QLabel to resize the QPixmap while keeping the aspect ratio of the original QPixmap?  

I can't modify `sizeHint()` of the QLabel, setting the `minimumSize()` to zero does not help. Setting `hasScaledContents()` on the QLabel allows growing, but breaks the aspect ratio thingy...  

Subclassing QLabel did help, but this solution adds too much code for just a simple problem...  

Any smart hints how to accomplish this <em>without</em> subclassing?  

#### Answer accepted (score 86)
In order to change the label size you can select an appropriate size policy for the label like expanding or minimum expanding.   

You can scale the pixmap by keeping its aspect ratio every time it changes:  

```c
QPixmap p; // load pixmap
// get label dimensions
int w = label->width();
int h = label->height();

// set a scaled pixmap to a w x h window keeping its aspect ratio 
label->setPixmap(p.scaled(w,h,Qt::KeepAspectRatio));
```

There are two places where you should add this code:  

<ul>
<li>When the pixmap is updated</li>
<li>In the `resizeEvent` of the widget that contains the label</li>
</ul>

#### Answer 2 (score 29)
I have polished this missing subclass of `QLabel`.  It is awesome and works well.  

aspectratiopixmaplabel.h  

```c
#ifndef ASPECTRATIOPIXMAPLABEL_H
#define ASPECTRATIOPIXMAPLABEL_H

#include <QLabel>
#include <QPixmap>
#include <QResizeEvent>

class AspectRatioPixmapLabel : public QLabel
{
    Q_OBJECT
public:
    explicit AspectRatioPixmapLabel(QWidget *parent = 0);
    virtual int heightForWidth( int width ) const;
    virtual QSize sizeHint() const;
    QPixmap scaledPixmap() const;
public slots:
    void setPixmap ( const QPixmap & );
    void resizeEvent(QResizeEvent *);
private:
    QPixmap pix;
};

#endif // ASPECTRATIOPIXMAPLABEL_H
```

aspectratiopixmaplabel.cpp  

```c
#include "aspectratiopixmaplabel.h"
//#include <QDebug>

AspectRatioPixmapLabel::AspectRatioPixmapLabel(QWidget *parent) :
    QLabel(parent)
{
    this->setMinimumSize(1,1);
    setScaledContents(false);
}

void AspectRatioPixmapLabel::setPixmap ( const QPixmap & p)
{
    pix = p;
    QLabel::setPixmap(scaledPixmap());
}

int AspectRatioPixmapLabel::heightForWidth( int width ) const
{
    return pix.isNull() ? this->height() : ((qreal)pix.height()*width)/pix.width();
}

QSize AspectRatioPixmapLabel::sizeHint() const
{
    int w = this->width();
    return QSize( w, heightForWidth(w) );
}

QPixmap AspectRatioPixmapLabel::scaledPixmap() const
{
    return pix.scaled(this->size(), Qt::KeepAspectRatio, Qt::SmoothTransformation);
}

void AspectRatioPixmapLabel::resizeEvent(QResizeEvent * e)
{
    if(!pix.isNull())
        QLabel::setPixmap(scaledPixmap());
}
```

<p>Hope that helps!
(Updated `resizeEvent`, per @dmzl's answer)</p>

#### Answer 3 (score 12)
I just use `contentsMargin` to fix the aspect ratio.  

```c
#pragma once

#include <QLabel>

class AspectRatioLabel : public QLabel
{
public:
    explicit AspectRatioLabel(QWidget* parent = nullptr, Qt::WindowFlags f = Qt::WindowFlags());
    ~AspectRatioLabel();

public slots:
    void setPixmap(const QPixmap& pm);

protected:
    void resizeEvent(QResizeEvent* event) override;

private:
    void updateMargins();

    int pixmapWidth = 0;
    int pixmapHeight = 0;
};
```



```c
#include "AspectRatioLabel.h"

AspectRatioLabel::AspectRatioLabel(QWidget* parent, Qt::WindowFlags f) : QLabel(parent, f)
{
}

AspectRatioLabel::~AspectRatioLabel()
{
}

void AspectRatioLabel::setPixmap(const QPixmap& pm)
{
    pixmapWidth = pm.width();
    pixmapHeight = pm.height();

    updateMargins();
    QLabel::setPixmap(pm);
}

void AspectRatioLabel::resizeEvent(QResizeEvent* event)
{
    updateMargins();
    QLabel::resizeEvent(event);
}

void AspectRatioLabel::updateMargins()
{
    if (pixmapWidth <= 0 || pixmapHeight <= 0)
        return;

    int w = this->width();
    int h = this->height();

    if (w <= 0 || h <= 0)
        return;

    if (w * pixmapHeight > h * pixmapWidth)
    {
        int m = (w - (pixmapWidth * h / pixmapHeight)) / 2;
        setContentsMargins(m, 0, m, 0);
    }
    else
    {
        int m = (h - (pixmapHeight * w / pixmapWidth)) / 2;
        setContentsMargins(0, m, 0, m);
    }
}
```

Works perfectly for me so far. You're welcome.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: How do I set the background color of a widget like combobox or double spin box? (score [82434](https://stackoverflow.com/q/177778) in 2017)

#### Question
I am trying to set the background color for a double spin box, and I am not sure what function I should use.  

I saw some function called `SetBackgroundRole` which accepts a `Qt::ColorRole`, but I am not sure how to use this one as well.  

Kindly let me know, what's the simple way to change the background color of a `QComboBox` or `QDoubleSpinBox`?  

#### Answer accepted (score 37)
Using a `QPalette` isn't guaranteed to work for all styles, because style authors are restricted by the different platforms' guidelines and by the native theme engine.  

To make sure your background color will be correct, I would suggest to use the <a href="http://doc.qt.io/qt-4.8/stylesheet.html" rel="noreferrer">Qt Style Sheet</a>. Here is what I did to change the background color of a `QComboBox`:  

`myComboBox-&gt;setStyleSheet("QComboBox { background-color: blue; }");`  

I haven't specifically tried for a `QSpinBox`, but I guess it'll work the same !  

#### Answer 2 (score 42)
fhe is generally correct, but doesn't account for the widgets (like spin boxes and buttons/comboboxes) that use a different background role in the palette.  A more general solution would be something like this:  

```c
QPalette pal = widget.palette();
pal.setColor(widget.backgroundRole(), Qt::blue);
widget.setPalette(pal);
```

Alternatively, you could look into the descriptions of the various palette roles and figure out the one you want, then apply it to the widget containing the others you want changed.  The palette changes should propagate to the children widgets.  

#### Answer 3 (score 12)
Actually, if you look at the Qt docs for QPalette in the case of a QComboBox the background role is probably not what you want.  What you want is:  

<blockquote>
  <strong>QPalette::Base</strong>  Used mostly as the background color for text entry widgets, but can also be used for other painting - such as the background of combobox drop down lists and toolbar handles. It is usually white or another light color.  
</blockquote>

So here is the code I am using to set the background color of a combo box I am using to match the color of the widget it is on:  

```c
QPalette pal = myComboBox->palette();
pal.setColor(QPalette::Base, pal.color(QPalette::Window));
myComboBox->setPalette(pal);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Cannot launch AVD in emulator:QT library not found (score [82177](https://stackoverflow.com/q/42554337) in 2018)

#### Question
I am new to Android Studio and I am having problems while using the emulator. When I try to run it keeps crashing saying:  

<blockquote>
  <p>"Cannot launch AVD in emulator" [6816]:ERROR:./android/qt/qt_setup.cpp:28:Qt library not found at
  C:\Users\Jay\AppData\Local\Android\Sdk\emulator\lib64\qt\lib</p>
  
  <p>Could not launch 'C:\Users\Jay\AppData\Local\Android\Sdk\emulator/qemu/windows-x86_64/qemu-system-i386.exe':
  No such file or directory</p>
</blockquote>

I have enabled VT-x from BIOS settings yet I am having the problem. I have searched a lot and cannot find an answer. Any help will be much appreciated. Can anyone give me a solution?  

<p>Screenshot of error
<a href="https://i.stack.imgur.com/IVWIk.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/IVWIk.jpg" alt="Log Snapshot"></a></p>

#### Answer 2 (score 145)
This seems to be an issue relating to the recent update. A temporary solution is to launch emulator from within the `/path/to/android-sdk/tools` directory in the commandline.  

See <a href="https://code.google.com/p/android/issues/detail?id=235461" rel="noreferrer">https://code.google.com/p/android/issues/detail?id=235461</a> to follow the issue.  

#### Answer 3 (score 100)
All other answers did not work for me as "Android Emulator" was not installed with a standard installation of Android Studio. Make sure you have installed it and then try other answers if required.<a href="https://i.stack.imgur.com/UVnup.png" rel="noreferrer"><img src="https://i.stack.imgur.com/UVnup.png" alt="enter image description here"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: Set QLineEdit to accept only numbers (score [82113](https://stackoverflow.com/q/13422995) in 2013)

#### Question
I have a `QLineEdit` where the user should input only numbers.   

So is there a numbers-only setting for `QLineEdit`?  

#### Answer accepted (score 113)
`QLineEdit::setValidator()`, for example:  

```c
myLineEdit->setValidator( new QIntValidator(0, 100, this) );
```

or  

```c
myLineEdit->setValidator( new QDoubleValidator(0, 100, 2, this) );
```

See: <a href="http://doc.qt.io/qt-5/qintvalidator.html" rel="noreferrer">QIntValidator</a>, <a href="http://doc.qt.io/qt-5/qdoublevalidator.html" rel="noreferrer">QDoubleValidator</a>, <a href="http://doc.qt.io/qt-5/qlineedit.html#setValidator" rel="noreferrer">QLineEdit::setValidator</a>  

#### Answer 2 (score 22)
The best is <a href="http://doc.qt.io/qt-4.8/qspinbox.html" rel="noreferrer">`QSpinBox`</a>.  

And for a double value use <a href="http://doc.qt.io/qt-4.8/qdoublespinbox.html" rel="noreferrer">`QDoubleSpinBox`</a>.  

```c
QSpinBox myInt;
myInt.setMinimum(-5);
myInt.setMaximum(5);
myInt.setSingleStep(1);// Will increment the current value with 1 (if you use up arrow key) (if you use down arrow key => -1)
myInt.setValue(2);// Default/begining value
myInt.value();// Get the current value
//connect(&myInt, SIGNAL(valueChanged(int)), this, SLOT(myValueChanged(int)));
```

#### Answer 3 (score 7)
Why don't you use a `QSpinBox` for this purpose ? You can set the up/down buttons invisible with the following line of codes:  

```c
// ...
QSpinBox* spinBox = new QSpinBox( this );
spinBox->setButtonSymbols( QAbstractSpinBox::NoButtons ); // After this it looks just like a QLineEdit.
//...
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Qt Creator needs a compiler set up to build. Configure a compiler in the kit options (score [81825](https://stackoverflow.com/q/14700965) in 2016)

#### Question
<p>I Have Installed Qt Creator5 with latest binaries.
but when i am running any program it is giving me this error.</p>

<strong>:-1: error: Qt Creator needs a compiler set up to build. Configure a compiler in the kit options.</strong>  

<p>i have searched the whole internet for answer but its inadequate and not helping.
kindly reply the way to get rid of this error.</p>

#### Answer accepted (score 43)
i was also having the same problem so what i did is   

<strong>For linux</strong>   

```c
sudo apt-get install g++ 
sudo apt-get install libgl1-mesa-dev libglu1-mesa-dev
```

and then closed the qt creator and restarted it and it worked  

i do not know which of the above two made it work  but it worked !!  

<strong>For Windows</strong>  

Below given solution have worked for few people. so it is worth a try.  

<p>Delete this file
`C:\Users\AppData\Roaming\QtProject\qtcreator\toolchains.xml`
to solve the problem.</p>

#### Answer 2 (score 13)
For me on Windows 7 this was solved by clicking on the arrow icon next to the computer icon on the bottom left of the Qt Creator screen above green arrows and then double clicked a compiler on the list and rebuild the project.  

#### Answer 3 (score 8)
<strong>* for windows users only *</strong>  

Before continuing to next steps make sure u have downloaded latest version of Qt.  

<ol>
<li>Download and install minGW-64-bit from link: 
<a href="https://sourceforge.net/projects/mingw-w64/files/latest/download" rel="noreferrer">https://sourceforge.net/projects/mingw-w64/files/latest/download</a></li>
<li>Remember The directory to which you install minGW.</li>
<li>Open Qt creator and go to tools -> options -> Build and Run</li>
<li><p>In Compilers tab Select add -> MinGW -><br> Name: MinGW <br> path: Browse for <strong>mingw-w64.bat</strong> (you will find this file in the directory in which you have installed MinGW).<br>ABI: x86   Windows   msvc2015   pe   64bit   <br> <br> Don't forget to apply your edits. </p></li>
<li><p>Go to Kit -> add <br> Name: GCC <br> Device Type: Desktop<br> Device: Local PC (Default for desktop)<br> Compiler: minGW<br> Qt Version: select newest version<br><br> Apply changes and restart qt</p></li>
</ol>

<p>While creating new project make sure you use GCC as kit
<br><br> If it still doesn't works Click computer icon on bottom left above play button -> GCC -> Build</p>

<br> OR <br>  

Go to projects (It is in the menu on left hand side) -> Build Steps -> make -> Override minGw31-make.exe -> browse to path in which you have installed minGW/bin\mingw32-make.exe<br>Do the same for clean steps too  

<br>  

If u Still get any error after these steps try setting <strong>Environment Variables</strong>  

<ol>
<li>Press Win+Q</li>
<li>Type " Environment variables "</li>
<li>click on " Edit the system environment variables "</li>
<li>System Properties -> Advance -> Environment Variables</li>
<li>Click on path (<strong>NOTE : Use These steps very carefully and do not mess with other options</strong>)</li>
<li>Click edit</li>
<li>press right arrow to go to end of text</li>
<li>type a semi-colon (if it isn't at the end of it because all the system paths are distinguished by a semi-colon)</li>
<li>paste path "MinGW_installation_directory\bin" (In my case it was "G:\Qt\Tools\mingw32\bin"). <strong>Make sure you copy and paste CORRECT path</strong></li>
<li>Click OK and apply the changes.</li>
</ol>

<br>That should do it !!!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: How to emit cross-thread signal in Qt? (score [81768](https://stackoverflow.com/q/638251) in 2018)

#### Question
Qt documentation states that signals and slots can be `direct`, `queued` and `auto`.   

It also stated that if object that owns slot 'lives' in a thread different from object that owns signal, emitting such signal will be like posting message - signal emit will return instantly and slot method will be called in target thread's event loop.   

Unfortunately, documentation do not specify that 'lives' stands for and no examples is available. I have tried the following code:  

<strong>`main.h:`</strong>  

```c
class CThread1 : public QThread
{
Q_OBJECT
public:
    void run( void )
    {
        msleep( 200 );
        std::cout << "thread 1 started" << std::endl;
        MySignal();
        exec();
    }
signals:
    void MySignal( void );
};

class CThread2 : public QThread
{
Q_OBJECT
public:
    void run( void )
    {
        std::cout << "thread 2 started" << std::endl;
        exec();
    }
public slots:
    void MySlot( void )
    {
        std::cout << "slot called" << std::endl;
    }
};
```

<strong>`main.cpp:`</strong>  

```c
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    CThread1 oThread1;
    CThread2 oThread2;
    QObject::connect( & oThread1, SIGNAL( MySignal() ),
        & oThread2, SLOT( MySlot() ) );
    oThread1.start();
    oThread2.start();
    oThread1.wait();
    oThread2.wait();
    return a.exec();
}
```

Output is:  

```c
thread 2 started
thread 1 started
```

`MySlot()` is never called :(. What I'm doing wrong?  

#### Answer accepted (score 46)
There are quite a few problems with your code :  

<ul>
<li>like said by Evan the emit keyword is missing</li>
<li>all your objects live in the main thread, only the code in the run methods live in other threads, which means that the MySlot slot would be called in the main thread and I'm not sure that's what you want</li>
<li>your slot will never be called since the main event loop will never been launched : your two calls to wait() will only timeout after a very long time (and you'll probably kill your application before that happens) and I don't think that's what you want either, anyway they really have no use in your code.</li>
</ul>

This code would most likely work (though I have not tested it) and I think it does what you want it to do :  

```c
class MyObject : public QObject
{
    Q_OBJECT
public slots:
    void MySlot( void )
    {
        std::cout << "slot called" << std::endl;
    }
};

class CThread1 : public QThread
{
    Q_OBJECT
public:
    void run( void )
    {
        std::cout << "thread 1 started" << std::endl;
        int i = 0;
        while(1)
        {
           msleep( 200 );
           i++;
           if(i==1000)
              emit MySignal();
        }
    }
signals:
    void MySignal( void );
};

class CThread2 : public QThread
{
    Q_OBJECT
public:
    void run( void )
    {
        std::cout << "thread 2 started" << std::endl;
        exec();
    }
};

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    CThread1 oThread1;
    CThread2 oThread2;
    MyObject myObject;
    QObject::connect( & oThread1, SIGNAL( MySignal() ),
        & myObject, SLOT( MySlot() ) );
    oThread2.start();
    myObject.moveToThread(&oThread2)
    oThread1.start();
    return a.exec();
}
```

Now MyObject will live in thread2 (thanks to moveToThread).  

MySignal should be sent from thread1 (thought I'm not sure on that one, it might be sent from main thread, it doesn't really matter).  

No event loop is needed in thread1 since emitting a signal doesn't need an event loop. An event loop is needed in thread2 (lanched by exec()) to receive the signal.  

MySlot will be called in thread2.  

#### Answer 2 (score 36)
<h5>Do not subclass QThread for Qt 4.4+</h2>

While Aiua's answer is good, I want to point out some issues with QThread and Qt 4.6 or 4.7.  

This article sums it up: <a href="http://blog.qt.io/blog/2010/06/17/youre-doing-it-wrong/" rel="noreferrer">http://blog.qt.io/blog/2010/06/17/youre-doing-it-wrong/</a>  

<h5>Lack of Documentation on Qt's part</h2>

Unfortunately the problem stems from a lack of updates to documentation.  Prior to Qt 4.4 QThread had no default run() implementation, which meant that you had to subclass QThread in order to use it.  

If you're using Qt 4.6 or 4.7 then you almost certainly should <em>not</em> subclass QThread.  

<h5>Use moveToThread</h2>

The key to getting slots to execute in a worker thread is to use the moveToThread method as Aiua pointed out.  

#### Answer 3 (score 0)
you should emit the signal to start your thread function like   

```c
emit operateCut(examId,examName_examTemplate[examName].studentIdRec,examName_examTemplate[examName].choiceRecA,examName_examTemplate[examName].choiceRecB,examName_examTemplate[examName].objectRecA,examName_examTemplate[examName].objectRecB);
```

you can add more than one argument in this signal  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: Qt static linking and deployment (score [81137](https://stackoverflow.com/q/1011197) in )

#### Question
I am trying to deploy(release to public) a simple qt application I made recently, but got stuck at static linking qt libs.  

I followed the guide on qt docs to re-build qt and my app statically. But the release build still require qtgui / qtcore dll for no apparent reasons, I wonder if anyone has seen this kind of problems before ? Or even better, has successfully resolved it ?  

<a href="http://doc.qtsoftware.com/4.5/deployment-windows.html" rel="noreferrer">http://doc.qtsoftware.com/4.5/deployment-windows.html</a>  

#### Answer 2 (score 42)
I wrote <a href="http://web.archive.org/web/20161222135358/http://www.formortals.com/how-to-statically-link-qt-4/" rel="noreferrer">a guide to static linking</a>  

<p>and
<a href="http://web.archive.org/web/20161222125623/http://www.formortals.com/build-qt-static-small-microsoft-intel-gcc-compiler/" rel="noreferrer">How to build Qt static with multiple compilers and keep it small</a></p>

<p>(because it can get pretty big, especially for simple programs).
You may also want to check out the BitRock installer, which is free for open source projects.</p>

<p>In short, it turns out to be a little more complex if you are using anything Qt thinks of as a plugin, such as support for most image types (JPEG, GIF) or databases.
For example, if you want to include support for Oracle DBMS and GIF images for your icons, you add the following to your .PRO file:</p>

```c
QTPLUGIN += qsqloci qgif
CONFIG += static
```

You will then need to:  

```c
#include <QtPlugin>
```

in your project, and import any plugins used. You need to change these settings back order to get it to compile with dynamic linking again (like when debugging or adding features), though this can be easily automated. There are also considerations when building the Qt libraries for use with static linking, though the Qt instructions will at least get you started.  

#### Answer 3 (score 16)
With Qt 5.5, things are quite easy. There are following orthogonal settings that you pass to `configure` when building Qt:  

<ol>
<li><p>Do you want a static Qt library?</p>

`-static` option should be passed to `configure`  </li>
<li><p>Do you want the build of Qt, and of your application, to use a static C++ runtime?</p>

`-static-runtime` option should be passed to `configure`  </li>
<li><p>Do you want XP targeting?</p>

`-target xp` option should be passed to `configure`  

Additionally, follow the instructions from <a href="http://blogs.msdn.com/b/vcblog/archive/2012/10/08/windows-xp-targeting-with-c-in-visual-studio-2012.aspx" rel="noreferrer">this blog post</a>.  

Qt Creator didn't support XP targeting automagically at least until v.3.5.0 since it doesn't set up the environment for the build tools properly. You have to modify the build environment manually <a href="http://blogs.msdn.com/b/vcblog/archive/2012/10/08/windows-xp-targeting-with-c-in-visual-studio-2012.aspx" rel="noreferrer">per the blog post</a>.  </li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: can the Open File dialog be used to select a Folder? (score [80712](https://stackoverflow.com/q/3941917) in 2010)

#### Question
The "Browse For Folder" Windows dialog is very inconvenient because:  

<ul>
<li>it has no Path box where I can paste the path I want (eg from Total Commander)</li>
<li>it always starts from the Desktop with everything closed</li>
</ul>

Is there a way to use the "Open File" dialog (which is much better) to select a Folder? Some flag or option or something?  

Context: the <a href="http://bugs.calibre-ebook.com/ticket/7160" rel="noreferrer">calibre eLibrary manager</a> which is written in Python and Qt.  

<p>It currently displays as on the left. I'd like it to display as on the right
<img src="https://i.stack.imgur.com/CzxbK.gif" alt="BrowserFileDialog"></p>

<p>or even better, as the Open File dialog:
<img src="https://i.stack.imgur.com/oy8zG.png" alt="OpenFileDialog"></p>

#### Answer 2 (score 90)
You can try this one:  

```c
QString QFileDialog::getExistingDirectory ( QWidget * parent = 0, const QString & caption = QString(), const QString & dir = QString(), Options options = ShowDirsOnly ) [static]
```

This one is used to choose a directory, and will popup a dialog like you show at last.  

Demo:  

```c
 QString dir = QFileDialog::getExistingDirectory(this, tr("Open Directory"),
                                             "/home",
                                             QFileDialog::ShowDirsOnly
                                             | QFileDialog::DontResolveSymlinks);
```

#### Answer 3 (score 22)
You can set the file mode in `QFileDialog` to `QFileDialog::Directory`  

see <a href="http://qt-project.org/doc/qt-5.0/qtwidgets/qfiledialog.html#FileMode-enum" rel="noreferrer">http://qt-project.org/doc/qt-5.0/qtwidgets/qfiledialog.html#FileMode-enum</a>  

Or You can use `QFileDialog::setOption` with value `QFileDialog::ShowDirsOnly`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: How to configure CDB in Qt Creator? (score [80287](https://stackoverflow.com/q/9975949) in 2017)

#### Question
The question <a href="https://stackoverflow.com/q/5318691/559085">here</a> is the same as mine but the solution there is not working for me. I am using QtCreator 2.4.1 on Windows 7. When i try to debug a simple hello world app the message displayed is: "The preferred debugger engine for debugging binaries of type 'x86-windows-msvc2010-pe-32bit' is not available....Details: There is no CDB binary available for binaries in format 'x86-windows-msvc2010-pe-32bit"    

When i found that cdb.exe was not on my system i had Windows SDK installed with debugger tools and the current location of cdb.exe is "C:\Program Files (x86)\Windows Kits\8.0\Debuggers\x86\cdb.exe" and "C:\Program Files (x86)\Windows Kits\8.0\Debuggers\x64\cdb.exe",  

In the CDB tab i configured symbol server as well as the path of CDB.exe, but in vain!  

<p>QtCreator->Tools->options->Debugger->CDB Tab->has the following fields:<br>
Additional arguments<br>
use CDB console<br>
Symbol Paths<br>
Source Paths<br>
Correct breakpoint location  etc...</p>

Can somebody kindly explain in detail what these mean and what values are expected here. Has anybody successfully debugged any applicaiton using Qt Creator.  

<hr>

<p>Please refer this link:<br>
<a href="http://qt-project.org/forums/viewthread/16018/" rel="noreferrer">http://qt-project.org/forums/viewthread/16018/</a></p>

#### Answer accepted (score 58)
I was having the same problems too, and finally figured out how to solve this. Styne666 gave me a hint. Do the following:  

<ol>
<li>Tools</li>
<li>Options...</li>
<li>Build &amp; Run</li>
<li>Tool Chains</li>
<li>Use the "Clone" button to make a copy of each of the auto-detected MSVC items</li>
<li>In each of the cloned items, you can specify the debugger in the "Debugger" field (e.g. C:\Program Files\Windows Kits\8.0\Debuggers\x64\cdb.exe)</li>
<li>After this everything seems to work...</li>
</ol>

I should further mention that if you are running a 64-bit version of Windows and a 32-bit version of Qt Creator like I am, you need to make sure that you are pointing to the 32-bit versions of cdb (of which there are x86 and x64 <em>target</em> versions). So for the 32-bit target builds I run this:  

```c
C:\Program Files (x86)\Windows Kits\8.0\Debuggers\x86\cdb.exe
```

And for x64 builds I run this:  

```c
C:\Program Files (x86)\Windows Kits\8.0\Debuggers\x64\cdb.exe
```

The tricky part is that it is somewhat difficult to get Microsoft to install the 32-bit version of the debugging tools on your 64-bit machine. A co-worker tried to do so recently and said that he needed to install the Windows 8 tools in order to have the option to do that - the Windows 7 versions would not let you.   

#### Answer 2 (score 4)
Took me some time to figure out this with Qt Creator 2.6.0 (on Windows 7), so here it is:  

<ul>
<li>Tools, Options...</li>
<li>Build &amp; Run, Kits tab, select "Desktop (default)" (under Manual)</li>
<li>Click the Manage button and select Edit on the right side of
"Debugger:"</li>
<li>Engine: CDB, Binary: C:\Program Files\Debugging Tools for Windows
(x64)\cdb.exe</li>
</ul>

#### Answer 3 (score 2)
Depending on the version of Visual Studio you have installed you can find the CDB.exe in different locations. Check if it is available in your system by searching in C:\ drive.  

In my case I have Windows 7 (x64) with Visual Studio 2012 Express and Visual Studio 2013 installed and I had to install Microsoft Windows SDK for Windows 7 available <a href="http://www.microsoft.com/en-au/download/confirmation.aspx?id=8279" rel="nofollow">here</a> in order to have CDB.exe in my system. After the install, QT Creator was able to detect CDB.exe in this location: C:\Program Files\Debugging Tools for Windows (x64)\cdb.exe.   

The only thing you need from the SDK is the Common Utilities | Debugging Tools For Windows.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: Qt tutorials for beginners (score [79516](https://stackoverflow.com/q/5734253) in 2015)

#### Question
I want to ask about resources for learning `Qt` for <strong>beginners</strong>. What resources do you recommend for that?  

#### Answer 2 (score 26)
Have also a look at the <a href="https://www.youtube.com/watch?v=6KtOzh0StTc&amp;list=PL2D1942A4688E9D63&amp;spfreload=10" rel="noreferrer">Qt programming videos</a> on <em>VoidRealms</em>' Youtube channel.  

#### Answer 3 (score 9)
The transition from C++ to QT may seem bit awkward at first. But don't be afraid its somewhat easier than c++ when you get more familiar with it.   

<p>To start of I would like to recommend the first few videos of
<a href="http://www.youtube.com/watch?v=6KtOzh0StTc&amp;playnext=1&amp;list=PL2D1942A4688E9D63&amp;feature=results_main" rel="noreferrer">voidRealms youvideos on c++ QT</a> to get a feel on QT framework. All of them are really good. Try to do the examples by your own. You will be quite comfortable with the framework after watching these videos. </p>

<p>Next if possible try to refer <a href="https://rads.stackoverflow.com/amzn/click/com/1590598318" rel="noreferrer" rel="nofollow noreferrer">Foundations of Qt Development (Expert's Voice in Open Source)</a> which is also a very good reference for QT.
After going through few chapters you will be very accustomed to the Framework.</p>

Reading C++ GUI Programming with Qt 4 which is a usually recommended book will look good if you have this basic background on QT.  

I would also like to recommend the On-line Reference Documentation which will give a great depth in to QT when  going forward.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: Undefined reference to vtable. Trying to compile a Qt project (score [78650](https://stackoverflow.com/q/1552069) in 2017)

#### Question
I'm using <a href="http://en.wikipedia.org/wiki/Code::Blocks" rel="noreferrer">Code::Blocks</a> 8.02 and the mingw 5.1.6 compiler. I'm getting this error when I compile my Qt project:  

<blockquote>
  <p>C:\Documents and Settings\The
  Fuzz\Desktop\GUI\App_interface.cpp|33|undefined
  reference to `vtable for AddressBook'</p>
</blockquote>

File AddressBook.h:  

```c
 #ifndef ADDRESSBOOK_H
 #define ADDRESSBOOK_H

 #include <QWidget>

 class QLabel;
 class QLineEdit;
 class QTextEdit;

 class AddressBook : public QWidget
 {
     Q_OBJECT

 public:
     AddressBook(QWidget *parent = 0);

 private:
     QLineEdit *nameLine;
     QTextEdit *addressText;
 };

 #endif
```

File AddressBook.cpp:  

```c
#include <QtGui>
#include "addressbook.h"

AddressBook::AddressBook(QWidget *parent)
     : QWidget(parent)
{
    QLabel *nameLabel = new QLabel(tr("Name:"));
    nameLine = new QLineEdit;

    QLabel *addressLabel = new QLabel(tr("Address:"));
    addressText = new QTextEdit;

    QGridLayout *mainLayout = new QGridLayout;
    mainLayout->addWidget(nameLabel, 0, 0);
    mainLayout->addWidget(nameLine, 0, 1);
    mainLayout->addWidget(addressLabel, 1, 0, Qt::AlignTop);
    mainLayout->addWidget(addressText, 1, 1);

    setLayout(mainLayout);
    setWindowTitle(tr("Simple Address Book"));
}
```

#### Answer accepted (score 43)
<strong>Warning: Do not do this if you already have a .pro file - you'll lose it!</strong>  

In order to automatically ensure that all moc cpp files are generated, you can get qmake to automatically generate a .pro file for you instead of writing one yourself.  

Run  

```c
qmake -project
```

in the project directory, and qmake will scan your directory for all C++ headers and source files to generate moc cpp files for.  

#### Answer 2 (score 47)
When using Qt Creator:  

<ol>
<li>Build → Run qmake</li>
<li>Build → Rebuild All</li>
</ol>

#### Answer 3 (score 16)
The problem is almost certainly that you are not compiling or not linking in the generated moc_AddressBook.cpp file.  (It should have been generated for you -- you are running Qt's `moc` on your code before compiling, right?)  

To answer a little more thoroughly, the `Q_OBJECT` macro signals Qt's `moc` tool to create an extra implementation file that contains the code necessary to support `QObject`'s meta-information system.  If you had any signals or slots, it would do a few things for those as well.  

An alternative solution might be to remove the `Q_OBJECT` macro.  You probably don't want to do this, but it would help the immediate problem, and it isn't strictly necessary with the code that you've presented.  

Also, I would note that your line:  

```c
#include "addressbook.h"
```

Should probably be:  

```c
#include "AddressBook.h"
```

based on how you presented the filenames in the question.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: Convert an int to a QString with zero padding (leading zeroes) (score [77961](https://stackoverflow.com/q/2618414) in 2014)

#### Question
I want to "stringify" a number and add zero-padding, like how `printf("%05d")` would add leading zeros if the number is less than 5 digits.  

#### Answer accepted (score 163)
Use this:  

```c
QString number = QString("%1").arg(yourNumber, 5, 10, QChar('0'));
```

5 here corresponds to 5 in `printf("%05d")`. 10 is the radix, you can put 16 to print the number in hex.  

#### Answer 2 (score 31)
QString QString::rightJustified ( int width, QChar fill = QLatin1Char( ' ' ), bool truncate = false ) const  

```c
int myNumber = 99;
QString result;
result = QString::number(myNumber).rightJustified(5, '0');
```

result is now 00099  

#### Answer 3 (score 17)
<strong>The Short Example:</strong>  

```c
int myNumber = 9;

//Arg1: the number
//Arg2: how many 0 you want?
//Arg3: The base (10 - decimal, 16 hexadecimal - if you don't understand, choose 10)
//      It seems like only decimal can support negative numbers.
QString number = QString("%1").arg(myNumber, 2, 10, QChar('0')); 

Output will be: 09
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: Qt: can't find -lGL error (score [76629](https://stackoverflow.com/q/18406369) in 2014)

#### Question
I just reinstalled QtCreator, created new project (<em>Qt Application</em>) an got this after compilation:   

```c
/usr/bin/ld: **cannot find -lGL**
collect2: error: ld returned 1 exit status
make: *** [untitled1] Error 1
18:07:41: The process "/usr/bin/make" exited with code 2.
Error while building/deploying project untitled1 (kit: Desktop Qt 5.1.0 GCC 32bit)
When executing step 'Make'
```

(<em>Project is empty, I did'n commit any changes</em>)  

<blockquote>
  <p>Qt Creator 2.7.2<br>
  Based on Qt 5.1.0 (32 bit)<br>
  Ubuntu 13.04</p>
</blockquote>

How do I solve this problem?  

#### Answer accepted (score 142)
You should install package "libgl1-mesa-dev":  

```c
sudo apt install libgl1-mesa-dev
```

#### Answer 2 (score 62)
you don't need to install anything. `libGL` is already installed with Ubuntu, you just need to soft link it. (tested for ubuntu 14.x and 15.x, might work for later versions)  

<ol>
<li>First locate the GL library</li>
<li>Then link it under /usr/lib</li>
<li>If the library is missing, it can be installed via libgl1-mesa-dev package</li>
</ol>

Here is how you could do this:  

```c
$ locate libGL
/usr/lib/i386-linux-gnu/mesa/libGL.so.1
/usr/lib/i386-linux-gnu/mesa/libGL.so.1.2.0
/usr/lib/x86_64-linux-gnu/libGLEW.so.1.10
/usr/lib/x86_64-linux-gnu/libGLEW.so.1.10.0
/usr/lib/x86_64-linux-gnu/libGLEWmx.so.1.10
/usr/lib/x86_64-linux-gnu/libGLEWmx.so.1.10.0
/usr/lib/x86_64-linux-gnu/libGLU.so.1
/usr/lib/x86_64-linux-gnu/libGLU.so.1.3.1
/usr/lib/x86_64-linux-gnu/mesa/libGL.so.1
/usr/lib/x86_64-linux-gnu/mesa/libGL.so.1.2.0
/usr/lib/x86_64-linux-gnu/mesa-egl/libGLESv2.so.2
/usr/lib/x86_64-linux-gnu/mesa-egl/libGLESv2.so.2.0.0
$ sudo ln -s /usr/lib/x86_64-linux-gnu/mesa/libGL.so.1 /usr/lib/libGL.so
```

#### Answer 3 (score 2)
write:   

```c
yum provides */libGL.so 
```

after providing:   

```c
yum install mesa-libGL-devel mesa-libGLU-devel
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: How to set application icon in a Qt-based project? (score [75456](https://stackoverflow.com/q/1460361) in 2013)

#### Question
How do you set application icon for application made using Qt? Is there some easy way? It's a qmake-based project.  

#### Answer accepted (score 88)
For <strong>Qt 5</strong>, this process is automated by qmake. Just add the following to the project file:  

```c
win32:RC_ICONS += your_icon.ico
```

The automated resource file generation also uses the values of the following qmake variables: `VERSION, QMAKE_TARGET_COMPANY, QMAKE_TARGET_DESCRIPTION, QMAKE_TARGET_COPYRIGHT, QMAKE_TARGET_PRODUCT, RC_LANG, RC_CODEPAGE`.  

For <strong>Qt 4</strong>, you need to do it manually. On Windows, you need to create a .rc file and add it to your project (.pro). The RC file should look like this:  

```c
IDI_ICON1 ICON DISCARDABLE "path_to_you_icon.ico"
```

The .pro entry should also be win32 specific, e.g.:  

```c
win32:RC_FILE += MyApplication.rc
```

#### Answer 2 (score 3)
One more way to do that. Verified in Linux (Qt 4.8.6) and Windows (Qt 5.6):  

1) Add the icon file to your project folder;  

2) In the main function call setWindowIcon() method. For example:  

```c
QApplication a(argc, argv);
a.setWindowIcon(QIcon("./images/icon.png"));
```

#### Answer 3 (score 2)
To extend Rob's answer, you can set an application icon for macOS by adding and modifying the following line onto your `.pro` file.  

```c
macx: ICON = <app_icon>.icns
```

Note that the <a href="https://doc.qt.io/qt-5/qmake-variable-reference.html#icon" rel="nofollow noreferrer">`ICON` qmake variable</a> is only meant to target macOS.  

For Windows, use   

<ul>
<li>`RC_ICONS = &lt;app_icon&gt;.ico` if you're attaching a `.ico` file </li>
<li><strong>or</strong> `RC_FILE = &lt;app_icon&gt;.rc` if you want to attach your icon through a `.rc` file. (Be sure to add `IDI_ICON1               ICON    DISCARDABLE     "myappico.ico"` into the rc file. Indentation not mine.)</li>
</ul>

For further reading, see <a href="https://doc.qt.io/qt-5/appicon.html" rel="nofollow noreferrer">Setting the Application Icon</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: QTcpSocket: reading and writing (score [75373](https://stackoverflow.com/q/20546750) in )

#### Question
I know some similar questions may have been asked already, but the answers to those I found covered very specific problems and I still haven't figured it out.  

In my program I'm creating a QObject (called QPeer) that uses a QTcpSocket to communicate with another such object over a network. QPeer has a slot that accepts a QByteArray with data (`sendData(QByteArray)`). The entire contents of that array are considered to be one 'message' and they are written to the socket. I want to do the following: every time a message is written, I want the receiving QPeer to emit its signal `dataReceived(QByteArray)` exactly once, that QByteArray containing the entire message. (NOTE: all signals/slots, both private ones connecting the QPeer with its socket and the public ones such as `sendData(QByteArray)` are serialized by using `Qt::QueuedConnection` whenever necessary.)  

I use the signal `QTcpSocket::readyRead()` for asynchronous reading from the socket. Now I know I can't just call `QTcpSocket::write()` once in sendData and then assume that for every write I do, the QTcpSocket on the other side produces exactly one readyRead signal. So what should I do?  

This is my idea, please tell me if this will work:  

WRITING:  

```c
void QPeer::sendData(QByteArray data)
{
    // TODO: write data.size() as raw int of exactly 4 bytes to socket
    const char *bytes = data.constData();
    int bytesWritten = 0;
    while (bytesWritten < data.size())
        bytesWritten += _socket->write(bytes + bytesWritten);
}
```

READING:  

now I want the read function (connected to `QTcpSocket::readyRead()`) to use the header (the 4 byte int specifying the length of the message) and then read that amount of bytes; next emit dataReceived with exactly those bytes. I'm having serious trouble trying to do this. <em>For example: what to do if readyRead is emitted and I can read the header of a message, but not the amount of bytes specified? Or what if a header has only been received partially?</em>  

<strong>1. How do I correctly write the header (4 byte int) to the socket?</strong>  

<strong>2. How do I correctly implement the read function so that it does what I want?</strong>  

Any tips are welcome. Thanks!  

#### Answer accepted (score 37)
I worked on a project that does what you expect, see here the solution that I developed to our problems, simplified to be easier to understand:  

<strong>Edited, added support to the server deal with multiple clients.</strong>  

Client.h:  

```c
#include <QtCore>
#include <QtNetwork>

class Client : public QObject
{
    Q_OBJECT
public:
    explicit Client(QObject *parent = 0);

public slots:
    bool connectToHost(QString host);
    bool writeData(QByteArray data);

private:
    QTcpSocket *socket;
};
```

Client.cpp:  

```c
#include "client.h"

static inline QByteArray IntToArray(qint32 source);

Client::Client(QObject *parent) : QObject(parent)
{
    socket = new QTcpSocket(this);
}

bool Client::connectToHost(QString host)
{
    socket->connectToHost(host, 1024);
    return socket->waitForConnected();
}

bool Client::writeData(QByteArray data)
{
    if(socket->state() == QAbstractSocket::ConnectedState)
    {
        socket->write(IntToArray(data.size())); //write size of data
        socket->write(data); //write the data itself
        return socket->waitForBytesWritten();
    }
    else
        return false;
}

QByteArray IntToArray(qint32 source) //Use qint32 to ensure that the number have 4 bytes
{
    //Avoid use of cast, this is the Qt way to serialize objects
    QByteArray temp;
    QDataStream data(&temp, QIODevice::ReadWrite);
    data << source;
    return temp;
}
```

Server.h:  

```c
#include <QtCore>
#include <QtNetwork>

class Server : public QObject
{
    Q_OBJECT
public:
    explicit Server(QObject *parent = 0);

signals:
    void dataReceived(QByteArray);

private slots:
    void newConnection();
    void disconnected();
    void readyRead();

private:
    QTcpServer *server;
    QHash<QTcpSocket*, QByteArray*> buffers; //We need a buffer to store data until block has completely received
    QHash<QTcpSocket*, qint32*> sizes; //We need to store the size to verify if a block has received completely
};
```

Server.cpp:  

```c
#include "server.h"

static inline qint32 ArrayToInt(QByteArray source);

Server::Server(QObject *parent) : QObject(parent)
{
    server = new QTcpServer(this);
    connect(server, SIGNAL(newConnection()), SLOT(newConnection()));
    qDebug() << "Listening:" << server->listen(QHostAddress::Any, 1024);
}

void Server::newConnection()
{
    while (server->hasPendingConnections())
    {
        QTcpSocket *socket = server->nextPendingConnection();
        connect(socket, SIGNAL(readyRead()), SLOT(readyRead()));
        connect(socket, SIGNAL(disconnected()), SLOT(disconnected()));
        QByteArray *buffer = new QByteArray();
        qint32 *s = new qint32(0);
        buffers.insert(socket, buffer);
        sizes.insert(socket, s);
    }
}

void Server::disconnected()
{
    QTcpSocket *socket = static_cast<QTcpSocket*>(sender());
    QByteArray *buffer = buffers.value(socket);
    qint32 *s = sizes.value(socket);
    socket->deleteLater();
    delete buffer;
    delete s;
}

void Server::readyRead()
{
    QTcpSocket *socket = static_cast<QTcpSocket*>(sender());
    QByteArray *buffer = buffers.value(socket);
    qint32 *s = sizes.value(socket);
    qint32 size = *s;
    while (socket->bytesAvailable() > 0)
    {
        buffer->append(socket->readAll());
        while ((size == 0 && buffer->size() >= 4) || (size > 0 && buffer->size() >= size)) //While can process data, process it
        {
            if (size == 0 && buffer->size() >= 4) //if size of data has received completely, then store it on our global variable
            {
                size = ArrayToInt(buffer->mid(0, 4));
                *s = size;
                buffer->remove(0, 4);
            }
            if (size > 0 && buffer->size() >= size) // If data has received completely, then emit our SIGNAL with the data
            {
                QByteArray data = buffer->mid(0, size);
                buffer->remove(0, size);
                size = 0;
                *s = size;
                emit dataReceived(data);
            }
        }
    }
}

qint32 ArrayToInt(QByteArray source)
{
    qint32 temp;
    QDataStream data(&source, QIODevice::ReadWrite);
    data >> temp;
    return temp;
}
```

<strong>Note:</strong> Do not use this method to transfer large files because with this method the entire contents of the message is put inside the memory before  sent and this causes a high memory usage. And because 32 bits signed INT has max value to <a href="https://stackoverflow.com/a/94608/2014561">2,147,483,647</a>, if your input data has a value higher than that in bytes it won't work. Take care.  

#### Answer 2 (score 2)
As you said, you need to wait that your header is entirely sent, before reading it, and then read the good number of bytes and emit a signal for data availability.  

Here an example (untested) :  

```c
//header file

class Peer {
//[...]
protected:
   bool m_headerRead; //initialize to false
   unsigned int m_size_of_data_to_read;
//[...]
};

//source file
void QPeer::sendData(QByteArray data)
{
  int size = data.size();
  _socket->write((const char*) &size, sizeof(int);
  //use directly QIODevice::write(QByteArray)
  _socket->write(data);
}

void QPeer::readData()
{
    int bytes = _socket->bytesAvailable();
    bool contains_enough_data = true;

    while (contains_enough_data) {
       if (! m_headerRead && _socket->bytesAvailable() >= sizeof(int)) {
         //read header only and update m_size_of_data_to_read
         m_headerRead = true;
        } else if (m_headerRead && _socket->bytesAvailable >= m_size_of_data_to_read) {
          //read data here
          m_headerRead = false;
          emit dataAvailable();
       } else {
           contains_enough_data = false; //wait that further data arrived
       }
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: How to build Qt for Visual Studio 2010 (score [75051](https://stackoverflow.com/q/5601950) in 2011)

#### Question
I struggled finding a how-to which provides a stable solution for using Qt with Visual Studio 2010, so after collecting all the bits of information and some trial and error, I would like to write my solution into a guide.  

<h5>The problem, or why is it not possible to use prebuilt binaries?</h2>

It seems that using binaries built for Visual Studio 2008 might work in some special cases, but I found them not to work. In my case they compiled OK, but they produce runtime errors, like this:  

<img src="https://i.stack.imgur.com/LvWOd.png" alt="problem2">  

or when started from Visual Studio 2010:  

<img src="https://i.stack.imgur.com/cXTle.png" alt="problem">  

<p><strong>Update</strong>: I found a blog post analysing why does it work for some people, while it does not for others. In one word, it depends on whether you have Visual Studio 2008 installed on the same machine, or not.
<a href="http://blog.paulnettleship.com/2010/11/11/troubleshooting-visual-studio-2010-and-qt-4-7-integration/" rel="noreferrer">http://blog.paulnettleship.com/2010/11/11/troubleshooting-visual-studio-2010-and-qt-4-7-integration/</a></p>

<blockquote>
  The most important thing (that I stupidly didn’t realize) was the fact that you CANNOT use the Visual Studio 2008 compiled libraries and dll’s (available on the Qt webpage) if you don’t have Visual Studio 2008 installed. The reason is because the Qt SDK you download is a debug build which is dependant on the VC9.0 DebugCRT, meaning it needs the Visual C++ 2008 Debug Runtime installed, which is NOT available as a redistributable installer. The only way to install the DebugCRT is to install the entirety of Visual Studio 2008.  
</blockquote>

#### Answer accepted (score 142)
First of all, it’s very important to understand that <strong>for using Qt with Visual Studio 2010, it's not possible to use the pre-built binaries which were made for Visual Studio 2008</strong>, but you have to compile it from source.  

<h5>Downloading Qt</h2>

On <a href="https://www.qt.io/download/" rel="noreferrer">https://www.qt.io/download/</a>  

<strong>Update 2017:</strong> the latest Qt 4.x branch (Qt 4.8.6) has 2 pre-built packages, which are now in the archive section:  

<ol>
<li><a href="http://download.qt.io/archive/qt/4.8/4.8.6/qt-opensource-windows-x86-vs2010-4.8.6.exe" rel="noreferrer">http://download.qt.io/archive/qt/4.8/4.8.6/qt-opensource-windows-x86-vs2010-4.8.6.exe</a></li>
<li><a href="http://download.qt.io/archive/qt/4.8/4.8.6/qt-opensource-windows-x86-vs2008-4.8.6.exe" rel="noreferrer">http://download.qt.io/archive/qt/4.8/4.8.6/qt-opensource-windows-x86-vs2008-4.8.6.exe</a></li>
</ol>

You should not download Qt by clicking <em>"Qt libraries 4.8.6 for Windows (Visual Studio 2008, 218 MB)"</em>, but by clicking on the <em>"zip"</em> link above it.  

<img src="https://i.stack.imgur.com/odCKO.png" alt="link-selection">  

On that link, you get a big zip file like <em>"qt-everywhere-opensource-src-4.8.6.zip"</em>. Unzip this into a folder and make its path something nice and small, for example <em>"E:\Qt"</em>  

<h5>Visual Studio Command Prompt</h2>

Now that we have the sources, we need to build the binaries. To do it, open the `Microsoft Visual Studio 2010\Visual Studio Tools\Visual Studio Command Prompt (2010)` link from your start menu, or even pin it to the taskbar (a good idea). This is a special command prompt which has all the variables set for building with Visual Studio 2010 tools.  

Once within the command prompt, navigate to your extracted Qt folder using old-school DOS way, which means you have to change drive letter by `E:`, enter directories by `cd Qt` and list dir contents by `dir`. You can use the tab key for helping you with the directory names. When you have arrived at the correct directory, a `dir` command should return something like this.  

<img src="https://i.stack.imgur.com/O6VWe.png" alt="command line">  

<h5>Building Qt</h2>

Now it’s time for configure and build. For configuring a minimalist Qt, I'm using the following flags with `configure.exe`. Just copy and paste it into the command line. Look in the <a href="http://doc.qt.io/qt-4.8/configure-options.html" rel="noreferrer">Qt reference manual</a> for what flag to use or not to use.  

```c
configure.exe -release -no-webkit -no-phonon -no-phonon-backend -no-script -no-scripttools -no-qt3support -no-multimedia -no-ltcg
```

Once `configure.exe` has finished (it was 10 minutes for me), you'll need to start the build process. It will take about 20-30 minutes with the above flags. To start it, just type:  

```c
nmake
```

<h5>Setting environment variables</h2>

Basically, we are done. All you need to do is to set your environment variables (`QTDIR` and `PATH`), which tell programs where to find Qt. If you are on Windows 7, you can use the following command to set `QTDIR` to your installation dir.  

```c
setx QTDIR e:\Qt
```

For setting the `PATH`, I strongly recommend using <a href="https://patheditor2.codeplex.com/" rel="noreferrer">Path Editor</a>. Within Path Editor  

```c
add the directory of Qt\bin to your PATH
```

(it doesn't matter if it's in system path or user path)  

If you prefer to use `Control Panel\System\Environment Variables`, then you can set these there, too.  

<h5>Qt Visual Studio Add-in</h2>

Here you go, after a logoff-logon or a restart, all the Qt demo applications should start correctly (I recommend have a look at <em>bin\qtdemo.exe</em>). Now you can download and install the Visual Studio Add-in (qt-vs-addin-1.1.9.exe) from the Qt download page, it will work perfectly.  

<img src="https://i.stack.imgur.com/2STpj.png" alt="addin">  

<h5>Appendix A: Official Instructions:</h2>

There is a page at the official wiki at the Qt website called <a href="http://doc.qt.io/qt-4.8/install-win.html" rel="noreferrer"><em>Qt 4.8 Installing Qt for Windows</em></a>, but I found it lacking important information.  

<h5>References</h2>

<blockquote>
  <p><a href="http://developer.qt.nokia.com/forums/" rel="noreferrer">Qt DevNet forums</a><br>
  <a href="https://stackoverflow.com/questions/5587141/recommended-flags-for-minimalistic-qt-build">Recommended flags for a minimalistic Qt build</a><br>
  <a href="https://stackoverflow.com/questions/1644172/building-qt-4-5-with-visual-c-2010">Building Qt 4.5 with Visual C++ 2010</a><br>
  <a href="https://stackoverflow.com/questions/4112972/how-to-compile-qt-as-static">How to compile Qt as static</a><br>
  <a href="http://doc.qt.io/qt-4.8/configure-options.html" rel="noreferrer">Qt 4.8: Configure options for Qt</a><br>
  <a href="http://op111.net/82/" rel="noreferrer">Edit the PATH environment variable in<br>
  Windows without pain - op111.net</a>  </p>
</blockquote>

#### Answer 2 (score 25)
<p>Qt V4.8.0 contains prebuilt binaries for Visual Studio 2010 so you don't need to do this anymore:
<a href="http://qt.nokia.com/downloads/windows-cpp-vs2010">http://qt.nokia.com/downloads/windows-cpp-vs2010</a></p>

#### Answer 3 (score 1)
<p>Refer below link and it might be useful
1)<a href="https://www.slicer.org/slicerWiki/index.php/Documentation/Nightly/Developers/Build_Instructions/Prerequisites/Qt#Windows_3" rel="nofollow">https://www.slicer.org/slicerWiki/index.php/Documentation/Nightly/Developers/Build_Instructions/Prerequisites/Qt#Windows_3</a>
2)<a href="http://eecs.vanderbilt.edu/research/hmtl/wp/index.php/qt-vs/" rel="nofollow">http://eecs.vanderbilt.edu/research/hmtl/wp/index.php/qt-vs/</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: QT Repaint/Redraw/Update/Do Something (score [74789](https://stackoverflow.com/q/2052907) in 2017)

#### Question
I'm New to QT.  I understand that you can force a display refresh, but I've pulled all my hair out trying to figure out how. Here is what I'm specifically trying to do.  

I press a button (onClick signal event), which runs code that changes an image (QLabel) on the display, waits for input, and then proceeds by changing a new image (different QLabel).  I've tried everything and the display doesn't refresh until the onclick signal event code is complete.  Right now, I'm not waiting for user input, I'm using usleep(~500 ms) for testing purposes.  

From what I read, QT is event driven meaning that I'm basically creating a bunch of events, that get put in a que, and executed when the (onClick signal event) returns to the (main loop)/(event handler).  I don't want to wait until the function is complete, it's going to make programming extremely painful if I have to accomplish this routine entirely based on events.  

How can I force the QLabel pixmap to refresh.  I've tried everything.  Below is all the code I have tried in my onClick signal event handler. (upButton is the name of the QLabel which is a pixmap)  

```c
update();
repaint();
ui->upButton->setUpdatesEnabled(TRUE);
update();
repaint();
QPaintEvent paintevent(ui->upButton->childrenRegion());
QPaintEvent * test = &paintevent;
paintEvent(test);
this->changeEvent(test);
ui->upButton->update();
ui->upButton->repaint();
ui->upButton->repaint(ui->upButton->childrenRegion());
repaint();
QApplication::sendPostedEvents();
this->parentWidget()->update();
usleep(100000);
```

As you can see, I'm just shooting in the dark at this point.  I've tried to look at sample code and do all my homework, but I'm lost.  Appreciate any help, advice, and or sample code.  

#### Answer 2 (score 22)
I was using sleep to emulate a brief amount of time the computer was waiting for something to happen.    

As I stated in my question, I didn't want to use events because it's a whole lot of unnecessary work to accomplish something extremely simply.  

Also, the 'event' that needs to take place for the program to continue, is a USB event.  Since I'm using an HID class device, there is no way to set an event to happen without a wait loop.  USB HID classes don't permit setting interrupts, the OS claims the device.    

I managed to get the above to work.  I walked through the debugger and noticed the display would refresh before the sleep function.  Running the program independently, I got random results with the display refreshing 1% of the time.  I got rid of the sleep function, and added some other code in it's place to emulate a delay, and it was fine.    

Just for everyone's knowledge, this is possible, it's not forbidden, and it's easy to do with the following:   

```c
qApp->processEvents();
```

qApp is a global external variable in the QApplication header.  

Because this USB event is making my flow tricky, I stumbled upon the QWaitCondition Class.  I was going to start a process waiting for the USB event.  I would wait until the process releases the wait condition for my routine to continue.    

But if anyone thinks this is a bad idea, please, speak out.  I really do appreciate your feedback PiedPiper and Hostile Fork.  

Thank you.  

#### Answer 3 (score 7)
You shouldn't be waiting for input in your event handler. You need to rethink the logic of your program to use events the way they were intended. All the update() and repaint() calls in your code are unnecessary if you return to the event loop.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: How to make a QPushButton disabled (score [74644](https://stackoverflow.com/q/5714404) in 2013)

#### Question
I created lots of <a href="http://qt-project.org/doc/qt-5.0/qtwidgets/qpushbutton.html" rel="noreferrer">QPushButtons</a>, added clicked signal and a slot name ´deneme()´ to all of the buttons with `QT DESIGNER` and the thing I want to do is; when I clicked any button, some operation should be done and lastly the button should be disabled but we do not know which button is clicked. I know I can disable the buttons with `setEnabled()` and `isEnabled()` but I do not know how to disable them.  

#### Answer accepted (score 28)
<p>If I understood correctly you connected various `QPushButtons` to the same slot. Inside of the slot `deneme()` you want to know which of the buttons was `clicked`. 
You can do something like:</p>

```c
  void deneme() {
    QPushButton * b = qobject_cast<QPushButton *>(sender());
    if (b) {
       if (b == button1) { //button1 clicked
           //doSomething();
       } 
       else {
          if (b == button2) {
             //doSomething();
          }
       }
       b->setEnabled(false);
    }
  }
```

#### Answer 2 (score 7)
Why is setEnabled not working then? <a href="http://doc.trolltech.com/4.7/qwidget.html#enabled-prop" rel="noreferrer">The reference</a>.  

So a simple setEnabled(false); is enough.  

```c
QPushButton* button = new QPushButton(someParent);
button->setEnabled(false);
```

<p>If the connecting a event handler on the click event of the button maybe you should look at the QT documentation:
<a href="http://doc.qt.nokia.com/4.7/signalsandslots.html" rel="noreferrer">Signal and slots</a></p>

#### Answer 3 (score 2)
You mean Button has to be disabled right after clicking on it? I guess in that case you probably want to do something like this:  

```c
class MyWidget : public QWidget 
{
Q_OBJECT

// ...

private slots:
  void disableButton();

private:
  QPushButton *myButton;

// ...
};

MyWidget::MyWidget(QWidget *parent = NULL) : QWidget(parent) 
{

///...
myButton = new QPushButton("click me", this);
connect(myButton, SIGNAL(clicked), this, SLOT(disableButton));
// ...
}

void MyWidget::disableButton() 
{
myButton->setEnabled(false);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: How to check whether file exists in Qt in c++ (score [74605](https://stackoverflow.com/q/10273816) in 2015)

#### Question
How do I check whether a file exists in a given path or not in Qt?  

My current code is below:  

```c
QFile Fout("/Users/Hans/Desktop/result.txt");

if(!Fout.exists()) 
{       
  eh.handleError(8);
}  
else
{
  // ......
}
```

But when I run the code it is not giving the error message specified in `handleError` even though the file I mentioned in the path does not exist.  

#### Answer 2 (score 92)
<strong>(TL;DR at the bottom)</strong>  

I would use the `QFileInfo`-class (<a href="http://qt-project.org/doc/qt-5/qfileinfo.html" rel="noreferrer">docs</a>) - this is exactly what it is made for:  

<blockquote>
  The QFileInfo class provides system-independent file information.  
  
  <p>QFileInfo provides information about a file's name and position (path)
  in the file system, its access rights and whether it is a directory or
  symbolic link, etc. The file's size and last modified/read times are
  also available. QFileInfo can also be used to obtain information about
  a Qt resource.</p>
</blockquote>

This is the source code to check whether a file exists:  

```c
#include <QFileInfo>
```

<em>(don't forget to add the corresponding `#include`-statement)</em>  

```c
bool fileExists(QString path) {
    QFileInfo check_file(path);
    // check if file exists and if yes: Is it really a file and no directory?
    if (check_file.exists() && check_file.isFile()) {
        return true;
    } else {
        return false;
    }
}
```

Also consider: Do you only want to check if the path exists (`exists()`) or do you want to also make sure that this is a file and not a directory (`isFile()`)?  

<strong>Be careful</strong>: The documentation of the `exists()`-function says:  

<blockquote>
  Returns true if the file exists; otherwise returns false.  
  
  Note: If file is a symlink that points to a non-existing file, false is returned.  
</blockquote>

<strong>This is not precise.</strong> It should be:  

<blockquote>
  Returns true if the path (i.e. file or directory) exists; otherwise returns false.  
</blockquote>

<hr>

<strong>TL;DR</strong>  

<em>(with shorter version of the function above, saving a few lines of code)</em>  

```c
#include <QFileInfo>

bool fileExists(QString path) {
    QFileInfo check_file(path);
    // check if path exists and if yes: Is it really a file and no directory?
    return check_file.exists() && check_file.isFile();
}
```

<strong>TL;DR for Qt >=5.2</strong>  

<em>(using `exists` as a `static` which was introduce in Qt 5.2; the docs say the static function is faster, though I'm not sure this is still the case when also using the `isFile()` method; at least this is a one-liner then)</em>  

```c
#include <QFileInfo>

// check if path exists and if yes: Is it a file and no directory?
bool fileExists = QFileInfo::exists(path) && QFileInfo(path).isFile();
```

#### Answer 3 (score 11)
You can use the `QFileInfo::exists()` method:  

```c
#include <QFileInfo>
if(QFileInfo("C:\\exampleFile.txt").exists()){
    //The file exists
}
else{
    //The file doesn't exist
}
```

<hr>

If you want it to return `true` only if the <em>file</em> exists and `false` if the path exists but is a folder, you can combine it with `QDir::exists()`:  

```c
#include <QFileInfo>
#include <QDir>
QString path = "C:\\exampleFile.txt";
if(QFileInfo(path).exists() && !QDir(path).exists()){
    //The file exists and is not a folder
}
else{
    //The file doesn't exist, either the path doesn't exist or is the path of a folder
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: What should I choose: GTK+ or Qt? (score [74518](https://stackoverflow.com/q/1887070) in 2009)

#### Question
Can someone suggest what's the best uses for those libraries today? Is it just GUI, or do they have database, XML, networking, threading, etc support too?  

I was reading about them, and considered starting to learning/using one of them.  

What is the most common one? What's the difference between them? Why would you choose one over the other?  

#### Answer accepted (score 89)
As you seem to primarily target Linux, then the choice mostly depends on the programming language you want to use.  

If you code in C, then obviously go for GTK+  

If you code in C++, go for Qt, otherwise you will need <a href="http://www.gtkmm.org/" rel="noreferrer">Gtkmm</a> (a C++ wrapper over GTK+)  

If you code in Python, both GTK+ and Qt have bindings for the language: see <a href="http://www.pygtk.org/" rel="noreferrer">PyGtk</a>, <a href="http://www.riverbankcomputing.co.uk/software/pyqt/intro" rel="noreferrer">PyQt</a> and <a href="http://www.pyside.org/" rel="noreferrer">PySide</a> (the one launched by Nokia themselves).  

If you code in Java, Qt is no more a viable option imho as <a href="https://web.archive.org/web/20090221105007/http://www.qtsoftware.com/about/news/preview-of-final-qt-jambi-release-available" rel="noreferrer">Nokia discontinued Qt Jambi</a> (the Java bindings for Qt).  

Also, Qt is more top-notch regarding its scenegraph <a href="http://doc.qt.io/qt-5/qgraphicsscene.html" rel="noreferrer">QGraphicsScene</a> API, its scripting engine built over Javascript Core (the engine powering WebKit), its state machine and animations framework, and the <a href="http://blog.qt.io/blog/2009/05/13/qt-declarative-ui/" rel="noreferrer">declarative UI</a>.  

GTK+ doesn't offer that much although you can use <a href="http://www.clutter-project.org/" rel="noreferrer">Clutter</a> alongside with it.  

If you're specifically looking into DB, XML (GTK+ has a parser for a subset of XML) and threading (GTK+ has <a href="http://library.gnome.org/devel/glib/" rel="noreferrer">GLib</a>) features then Qt will offer all that in <a href="http://doc.qt.io/qt-5/qtsql-index.html" rel="noreferrer">QtSql</a>, <a href="http://doc.qt.io/qt-5/qtxml-index.html" rel="noreferrer">QtXml</a> and <a href="http://doc.qt.io/qt-5/qtconcurrent-index.html" rel="noreferrer">QtConcurrent</a>.  

All in all, I would say Qt is a sure choice. But GTK+ is very capable as well.  

I'm not sure you will get a crystal clear answer for your question, which explains why some people keep preferring Gnome over KDE or vice-versa. <strong>Choose what works best for you.</strong>  

PS: I you plan to also target Symbian, then go for Qt.  

EDIT: Something that is also great with Qt is `QtWebView`: it brings Chromium into your Qt application to display web content. Others are embedding web content into their application using for instance Awesomium or Berkelium.  

#### Answer 2 (score 42)
I've used GTK+, QT and wxWidgets before. Here's a brief summary:  

For my first cross platform UI project I decided to go for wxWidgets mainly because at the time the license wasn't as restrictive as QT's (QT was GPL and only for Linux) and it had platform specific UI (unlike GTK). The project worked out well but there were quite a few glitches getting it to compile and run properly in other platforms - sometimes some events were fired up differently and such. Also GDI in wxWidgets was pretty slow.  

Next I used GTK for a different project in python. For this I used the python bindings and everything worked out more or less smoothly. I didn't quite like the fact that the UI didn't look native on Windows and Mac and also when you launch a GTK+ app it always debug outputs loads of CRITICAL warnings which seem fine to ignore. :S  

Finally, I did a very simple QT project now that Nokia has acquired it and was brilliant. The best of the three. First off, if you're not an old schooler who prefers VI or Emacs, QtCreator is brilliant. I really love VI and used it for years but I much prefer QtCreator for C++ QT projects. Regarding the library I also liked a lot the documentation and the APIs provided. QT has a concept of slots and signals which introduce new C++ keywords and a preprocessor. Basically, after reading a tutorial you'll get it easily and will start to love it. I'm now doing iPhone dev and it does feel a bit like Cocoa's/Interface Builder's UI paradigm.  

Summary: I'd go for QT hands down. The license is pretty good and the SDK and documentation really nice.  

#### Answer 3 (score 24)
I have never used GTK, but from my personal experience using Qt:  

It is much more than a simple GUI.  It's a whole application framework.  I used to think of it as the Java libraries for C++.  It provides all you mention -- database, XML, networking and threading, and more.  It also provides things such as containers and iterators, and counterparts to a number of boost libraries.  

The thing that impressed me most when starting to use Qt was the extremely extensive documentation.  You get a program called Qt Assistant, which provides fully indexed and searchable API documentation on your desktop, as well as numerous code examples and tutorials.  I found it made a big difference in searching the web each time for API info.  Very quick access when you need to remember a method signature.  

I am not sure which is most common; that's probably hard to measure accurately.  They're certainly both popular.  As Gnome is the default desktop of Ubuntu, and Gnome sits on top of GTK, it obviously has widespread usage.  Of course, KDE is very popular as well.  Nokia is heavily pushing Qt in the mobile space -- their Maemo OS, used on the new N900 for example, is soon to switch to Qt as the default toolkit (currently it is GTK.)  I believe Qt will also soon become the default toolkit for Symbian OS.  

I have not used Qt Creator, but I have heard many good things about it.  It is a C++ IDE with obvious heavy integration with Qt.  It also has fake vim emulation which is always nice if you like that kind of thing!  

Qt uses qmake for build configuration.  I found this much nicer than having to write your own makefiles. I do not know what GTK uses for building.  

A couple of things I found a bit offputting with Qt at first was its big uses of preprocessor macros.  The signal/slots system provides a nice mechanism for event/message passing in your application, but it does feel a bit like magic that may not be easily portable to another toolkit if you ever want to. Also, the moc (meta-object compiler), while I'm not entirely sure what it does, also feels a bit too much like magic going on behind the scenes.  

All in all, though, I would recommend Qt, particularly if you are learning.  It has really amazing documentation and a nice IDE, and busy forums.  You'll be able to build C++ apps very rapidly with it, particularly with the QML coming in 4.7.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: "Symbol(s) not found for architecture x86_64" on QtCreator project (score [72955](https://stackoverflow.com/q/18973042) in )

#### Question
I'm getting the error  

```c
Symbol(s) not found for architecture x86_64
```

Trying to compile a project on QtCreator. It happens when I try to create an instance of an user defined class, `Layer`. That class consists of a header, `layer.h`, and a implementation, `layer.cpp`. It was tested and works in another programs. On my project, it is included in `qtwidget.h` and the error happens when I try to use it on `qtwidget.cpp`. For example:  

```c
Layer<double> text("pq.txt",0.5,0.5,0.5);
```

Having this line on `qtwidget.cpp` is enough for the error to show up.  

This is such a generic error that I'm clueless on how to isolate it any further, but if it helps, I've included the whole project on <a href="http://github.com/viclib/3d_multilayer_viewer">this git repo</a>.  

#### Answer 2 (score 46)
In my opinion, the error message that Qt Creator displays is quite misleading until you understand it, but does not prevent splitting the template class into a header and implementation file. If you think about the message:  

```c
Symbol(s) not found for architecture x86_64
```

the problem, I originally thought when I saw this, is that it states this error on its own in the <em>Issues</em> output and can lead the user into thinking that the problem is due to the architecture. Actually, all its saying is that there's a defined symbol (often function) whose matching implementation wasn't found.  

If you change from <em>Issues</em> to the <em>Compile Output</em> window and scroll up, you'll be able to see exactly what symbols can't be found; mine's displayed in red. It's just annoying that the detail of the missing symbol(s) doesn't show up in the <em>Issues</em> view.  

It's easy to replicate this error by just adding a function definition into a header and without implementing the function, call it from the .cpp file. You'll then see something like this in the Issues window  

<img src="https://i.stack.imgur.com/7zemK.png" alt="symbol not found">  

Switching to the Compile Output view and scrolling up displays this: -  

<img src="https://i.stack.imgur.com/xHpYU.png" alt="enter image description here">  

So now we see that tthe actual problem is that the function DoSomeStuff in the class called PGGui is being called from the constructor PGGui::PGGui, but the body of DoSomeStuff is missing, as its symbol is not found.  

#### Answer 3 (score 8)
Fortunately I've managed to solve my problem before any answers, so, if anyone is experiencing anything similar, the issue was that it seems you <strong>can't split a templated class into a .cpp and a .h file</strong>. Putting all declarations of the `.cpp` file back into the `.h` solved the issue.  

I still had a leftover problem, though: duplicated symbols (which was the reason I split it). This time, declaring a variable as `external` in the `.h`, and redeclaring it without the `external` keyword in one (and only one) `.cpp` file solved the issue for good.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Configuring the GCC compiler switches in Qt, QtCreator, and QMake (score [72633](https://stackoverflow.com/q/2987062) in 2011)

#### Question
I recently tried to use <a href="http://en.wikipedia.org/wiki/Qt_Creator" rel="noreferrer">Qt Creator</a> 1.3.2, Qt 4.6.2, and GCC 4.4.0 (32-bit version) on Windows 7 (64-bit) to compile an application using some of the experimental C++0x extensions and encountered the following (fatal) error:  

<blockquote>
  <p>This file requires compiler and library support for the upcoming
  ISO C++ standard, C++0x. This support is currently experimental, and must be
  enabled with the -std=c++0x or -std=gnu++0x compiler options.</p>
</blockquote>

In my search for a solution, I came across the thread <em><a href="http://lists.trolltech.com/qt-interest/2004-05/thread00001-0.html" rel="noreferrer">qmake and compiler flags?</a></em>, and added the following to the .pro file:  

```c
CXXFLAGS += -std=c++0x
```

but that didn't seem to make a difference.  

So, I expect there's some tag I need to add to the .pro (project) file, but I've never messed with the GCC compiler switches in Qt, QMake, and QtCreator before, and I am uncertain about the proper invokation / incantation.  So, my question is how do you set GCC compiler switches when using QtCreator, QMake, and Qt?  

#### Answer accepted (score 104)
It boils down to reading the <a href="http://qt-project.org/doc/qt-5/qmake-variable-reference.html#qmake-cxxflags" rel="noreferrer">manual</a>.  Instead of using `CXXFLAGS` in the .pro file, you need to use `QMAKE_CXXFLAGS` as in:  

main.cpp:  

```c
#include <cinttypes>

int main() { return 0; }
```

main.pro:  

```c
SOURCES += main.cpp
QMAKE_CXXFLAGS += -std=c++0x
```

#### Answer 2 (score 5)
You should use  

```c
CONFIG += c++11
```

to enable C++11 compiler flags automatically.  

Look for `.prf` files in your qt installation. I don't know where they might be on windows, but on my Linux installation they are under `/opt/Qt/5.4/gcc_64/mkspecs/features`.  

You might want to read the <a href="http://doc.qt.io/qt-4.8/qmake-project-files.html#configuration-features" rel="noreferrer">qmake documentation</a> for that:  

<blockquote>
  <p>qmake can be set up with extra configuration features that are
  specified in feature (.prf) files. These extra features often provide
  support for custom tools that are used during the build process. To
  add a feature to the build process, append the feature name (the stem
  of the feature filename) to the CONFIG variable.</p>
</blockquote>

You can <a href="http://doc.qt.io/qt-4.8/qmake-advanced-usage.html#adding-new-configuration-features" rel="noreferrer">add your own features</a>.  

Here is what I found on my system. CONFIG += <em>name</em> will enable the feature:  

```c
./android/android_deployment_settings.prf
./android/android.prf
./build_pass.prf
./c++11.prf
./c++14.prf
./cmake_functions.prf
./configure.prf
./create_cmake.prf
./ctest_testcase_common.prf
./ctest_testcase_installed.prf
./ctest_testcase.prf
./dbusadaptors.prf
./dbusinterfaces.prf
./declarative_debug.prf
./default_post.prf
./default_pre.prf
./designer_defines.prf
./device_config.prf
./egl.prf
./exceptions_off.prf
./exceptions.prf
./exclusive_builds_post.prf
./exclusive_builds.prf
./gcov.prf
./include_source_dir.prf
./incredibuild_xge.prf
./java.prf
./lex.prf
./link_ltcg.prf
./link_pkgconfig.prf
./ltcg.prf
./mac/default_post.prf
./mac/default_pre.prf
./mac/objective_c.prf
./mac/rez.prf
./mac/sdk.prf
./moc.prf
./no_debug_info.prf
./precompile_header.prf
./qfeatures.prf
./qlalr.prf
./qml1_module.prf
./qml1_plugin.prf
./qml_debug.prf
./qml_module.prf
./qml_plugin.prf
./qmltestcase.prf
./qpa/basicunixfontdatabase.prf
./qpa/genericunixfontdatabase.prf
./qt_android_deps.prf
./qt_app.prf
./qt_build_config.prf
./qt_build_paths.prf
./qt_common.prf
./qt_config.prf
./qt_docs.prf
./qt_docs_targets.prf
./qt_example_installs.prf
./qt_functions.prf
./qt_headersclean.prf
./qt_helper_lib.prf
./qt_installs.prf
./qt_module_headers.prf
./qt_module.prf
./qt_module_pris.prf
./qt_parts.prf
./qt_plugin.prf
./qt.prf
./qt_targets.prf
./qt_tool.prf
./resolve_config.prf
./resolve_target.prf
./resources.prf
./silent.prf
./simd.prf
./spec_post.prf
./spec_pre.prf
./testcase.prf
./testcase_targets.prf
./testcocoon.prf
./testlib_defines.prf
./uic.prf
./unix/bsymbolic_functions.prf
./unix/dylib.prf
./unix/hide_symbols.prf
./unix/largefile.prf
./unix/opengl.prf
./unix/openvg.prf
./unix/separate_debug_info.prf
./unix/thread.prf
./unix/x11inc.prf
./unix/x11lib.prf
./unix/x11.prf
./unix/x11sm.prf
./use_c_linker.prf
./vxworks.prf
./warn_off.prf
./warn_on.prf
./wayland-scanner.prf
./win32/console.prf
./win32/default_pre.prf
./win32/dumpcpp.prf
./win32/idcidl.prf
./win32/msvc_mp.prf
./win32/opengl.prf
./win32/openvg.prf
./win32/qt_config.prf
./win32/qt_dll.prf
./win32/rtti_off.prf
./win32/rtti.prf
./win32/stl_off.prf
./win32/stl.prf
./win32/windeployqt.prf
./win32/windows.prf
./winrt/console.prf
./winrt/font_deployment.prf
./winrt/package_manifest.prf
./yacc.prf
```

#### Answer 3 (score 3)
The only way that really works for me is to <em>add it to</em> `QMAKE_CXXFLAGS`.   

The `CONFIG += c++11` <strong>does not add</strong> `-std=c++11` to the compile command.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: QDialog exec() and getting result value (score [71773](https://stackoverflow.com/q/12470806) in 2019)

#### Question
I have subclassed `QDialog` to implement functionality similar to `QMessageBox` ( I needed this to allow for customization). It has a text message and OK, Cancel buttons. I am showing the dialog using `exec()` to make it blocking. Now, how do I return values of true/false when the user clicks on OK/Cancel?  

I tried connecting the buttons to `setResult()` and then, return the result value when clicked, but  

<ol>
<li>Clicking the buttons does not close the dialog box</li>
<li>the return value is incorrect. 
Following is the code I have written. I think I am wrong in the exec/result part - but I am not sure how to fix it.</li>
</ol>

```c
class MyMessageBox : public QDialog {
    Q_OBJECT

private slots:

    void onOKButtonClicked() { this->setResult(QDialog::Accepted); }
    void onCancelButtonClicked() { this->setResult(QDialog::Rejected); }

public:
    MyMessageBox(QMessageBox::Icon icon, const QString& title,
        const QString& text, bool showCancelButton = true,
        QWidget* parent = 0);

    virtual void resizeEvent(QResizeEvent* e);

    QDialog::DialogCode showYourself()
    {
        this->setWindowModality(Qt::ApplicationModal);
        this->exec();
        return static_cast<QDialog::DialogCode>(this->result());
    }
};
```

The user will instantiate the class and call `showYourself()` which is expected to return the value and also close(and delete) the dialog.  

I have posted partial code. Let me know if you need more and I will post the complete version.  

#### Answer accepted (score 26)
Some points :  

<ol>
<li>Rather than using `setResult()` yourself, use <a href="http://qt-project.org/doc/qt-4.8/qdialog.html#accept">QDialog::accept()</a> and <a href="http://qt-project.org/doc/qt-4.8/qdialog.html#reject">QDialog::reject()</a>. </li>
<li>It seems you are not taking full advantage of the signals and slots. You need the object which create the dialog (or another one) to listen to the signals of the dialog. </li>
<li>In your code you are not connecting signals to slots either.</li>
<li>With my fix `onOKButtonClicked` and `onCancelButtonClicked` are unnecessary.</li>
<li>With my fix you don't need `showYourself()`. Just call `exec` and with the events 
information will flow.</li>
</ol>

You need to add this code before showing the dialog (`this` assume it is in a dialog method):  

```c
QObject::connect(acceptButton, SIGNAL(clicked()), this, SLOT(accept()));
QObject::connect(rejectButton, SIGNAL(clicked()), this, SLOT(reject()));
```

In the caller object you have   

```c
void someInitFunctionOrConstructor(){
   QObject::connect(mydialog, SIGNAL(finished (int)), this, SLOT(dialogIsFinished(int)));
}

void dialogIsFinished(int){ //this is a slot
   if(result == QDialog::Accepted){
       //do something
       return
   }
   //do another thing
}
```

#### Answer 2 (score 18)
Another solution:     

```c
    // set signal and slot for "Buttons"
    connect(YesButton, SIGNAL(clicked()), dlg, SLOT(accept()));
    connect(NoButton, SIGNAL(clicked()), dlg, SLOT(reject()));

    // show modal window event loop and wait for button clicks
    int dialogCode = dlg->exec();

    // act on dialog return code
    if(dialogCode == QDialog::Accepted) { // YesButton clicked }
    if(dialogCode == QDialog::Rejected) { // NoButton clicked }
```

#### Answer 3 (score 9)
<strong>Case 1</strong> Clicking the buttons does not close the dialog box.  

For this you have to close the dialog on respective `SLOTS`, so Use   

```c
void onOKButtonClicked(){ this->setResult(QDialog::Accepted); this->close();}
void onCancelButtonClicked(){ this->setResult(QDialog::Rejected);this->close();}  
```

<em>Note: Only after you have clicked the Ok button or Cancel button in a standard QMessageBox,  setResult() function is triggered and the status is changed. It's not the same effect when done vice versa.</em>  

<strong>Case 2</strong> The return value is incorrect.  

I think only after your dialog gets closed, you will have the result available in `result()` function. So I guess it will be solved, after you have made the changes specified in Case 1.   

If it still persists, use your own private member function to resolve it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Unresolved external symbol "public: virtual struct QMetaObject const * __thiscall Parent (score [71464](https://stackoverflow.com/q/14170770) in 2016)

#### Question
I inherited a class from QObject :   

```c
class Parent: public QObject
{
    Q_OBJECT
    QObject* cl;

public:
    Parent(QObject *parent=0):QObject(parent) {
        cl = NULL;
    }

    QObject* getCl() const {
        return cl;
    }
    void setCl(QObject *obj) {
        cl = obj;
    }
};
```

But when I write :  

```c
Parent ev;
```

I get the following error:  

```c
main.obj:-1: error: LNK2001: unresolved external symbol "public: virtual struct QMetaObject const * __thiscall Parent::metaObject(void)const " (?metaObject@Parent@@UBEPBUQMetaObject@@XZ)

main.obj:-1: error: LNK2001: unresolved external symbol "public: virtual void * __thiscall Parent::qt_metacast(char const *)" (?qt_metacast@Parent@@UAEPAXPBD@Z)

main.obj:-1: error: LNK2001: unresolved external symbol "public: virtual int __thiscall Parent::qt_metacall(enum QMetaObject::Call,int,void * *)" (?qt_metacall@Parent@@UAEHW4Call@QMetaObject@@HPAPAX@Z)
```

#### Answer accepted (score 67)
You should delete the `debug` folder of your application and run it again to correct this problem.  

#### Answer 2 (score 58)
If you're using Visual Studio, delete the line `Q_OBJECT` from the header file, save the file, put `Q_OBJECT` back into the header file, save the file again.  This should generate the `moc_*` file and should build and link correctly.  

#### Answer 3 (score 30)
I noticed some answers are based on Visual Studio.  

This answer is based on Qt Creator.  

Unlike the name suggest, `Rebuild Project` will not wipe out everything and build from scratch. If you recently added `QObject` (and/or Q_OBJECT) to your class, you'll have to run `qmake` again, e.g.  

<ol>
<li>Clean Project</li>
<li>Run qmake</li>
<li>Build Project</li>
</ol>

This is because, by default, `qmake` only runs when you do significant changes to your solution like adding new source files or modify the `.pro` file. If you make edits to an existing file, it doesn't know it needs to run `qmake`.  

As a fall back, to brute force Qt to build everything from scratch, delete the `Debug` or `Release` folder.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: Non-resizeable QDialog with fixed size in Qt? (score [70946](https://stackoverflow.com/q/696209) in 2014)

#### Question
I have a Qt dialog application. Now I dont want that dialog to be resizeable. I am not sure how to achieve this. I tried a bunch of things but still when the dialog launches this dialog can be resized.   

What is the property that i should set to disable the dialog/Widget resize.  

I also tried  

```c
setSizePolicy(QSizePolicy::Fixed);
```

But i get an error saying..   

<pre>
source\nimcac_settingsMain.cpp(36) : error C2248:
**'QSizePolicy::QSizePolicy' : cannot access private member declared in class 'QSizePolicy'**
        p:\ThirdPartyExports\Qt\export\4.3\4.3.1f14\include\QtGui\../../src\gui\
kernel\qsizepolicy.h(177) : see declaration of 'QSizePolicy::QSizePolicy'
        p:\ThirdPartyExports\Qt\export\4.3\4.3.1f14\include\QtGui\../../src\gui\
kernel\qsizepolicy.h(34) : see declaration of 'QSizePolicy'
</pre>

Kindly help me out with this.  

#### Answer accepted (score 52)
I don't know if you already tried it, but `QWidget::setFixedSize` should do what you want  

#### Answer 2 (score 105)
The compile error you get is because you try to pass a `QSizePolicy::Policy` to `setSizePolicy(QSizePolicy)`, but there's no implicit conversion from `QSizePolicy::Policy` (which is the policy for one dimension) to `QSizePolicy` (which is a class containing, among other things, one `Policy` per dimension (height, width)). `QSizePolicy` doesn't work on top-level widgets (windows) anyway, though.  

`setFixedSize()` only works if you know the size of the dialog in advance (and usually you don't, what with changing font sizes and languages). You can do  

```c
window()->setFixedSize( window()->sizeHint() );
```

but it's much better to use  

```c
window->layout()->setSizeConstraint( QLayout::SetFixedSize );
```

That lets the layout determine the size of the dialog, but doesn't allow resizing, which I assume is what you were asking for.  

#### Answer 3 (score 23)
```c
this->setFixedSize(this->width(),this->height());
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: How to Compare two Qstrings? (score [70623](https://stackoverflow.com/q/19264712) in 2013)

#### Question
I have to compare two Qstrings in qt,  

say,  

```c
Qstring str1="1005",str2="1006";
```

I have tried using ,  

```c
if(str1==str2){
   return true;
}
```

&amp;  

```c
if(str1.compare(str2)==0)
{
    return true;
}
```

still both methods goes inside if condition &amp;  returns true.  

#### Answer accepted (score 2)
It worked after Rebuilding the Project , I think this is the problem with QT CREATOR  

#### Answer 2 (score 33)
You can use :   

```c
int x = QString::compare(str1, str2, Qt::CaseInsensitive);  // if strings are equal x should return 0
```

#### Answer 3 (score 12)
The code below works fine for me.  

```c
int main(int argv, char **args)
 {
    QString str1="1005",str2="1006";
    if(str1 == str2)
        qDebug()<<"This should not print";
    qDebug()<<"Everything Ok";

}
```

Output:  

```c
Everything Ok
```

I don't know, why your code is not working, when is should have been fine. Recheck other parts of your code.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: Error: C2228: left of '' must have class/struct/union (score [70493](https://stackoverflow.com/q/20871225) in )

#### Question
I'm a long time Java user learning C++ with Qt and I'm having a lot of trouble understanding how methods work. Right now, I'm trying to figure out databases, and tried to simplify my code with a header. Normally in Java I would just have a class called DatabaseControl with a void method that would execute whatever I wanted. For example, adding an employee to a database, as I'm doing now. I'd instantiate the class, by doing something like  

```c
DatabaseControl myDBControl = new DatabaseControl();
```

and then execute the method with  

```c
myDBControl.addEmploye();
```

which would bring up the series of input boxes for the user to input the information on the employee - name, department, etc.  

So, now over to C++. I have my header  

```c
class DatabaseControl
{
public:
    DatabaseControl();
    ~DatabaseControl();

    //Methods
    void addEmployee();
};
```

I don't have any parameters in my constructors because all I want to do is call the "addEmployee" method in my main as I've shown above. In the same header file I have this below my class declaration  

```c
void DatabaseControl::addEmployee(){
QSqlQuery qry;
bool ok;
QString firstName = QInputDialog::getText(NULL, "QInputDialog::getText()",
                                     "Employee first name:", QLineEdit::Normal,
                                     NULL, &ok);
if (ok && !firstName.isEmpty()){}
else{
    QMessageBox msgBox;
    msgBox.setWindowTitle("Error");
    msgBox.setText("Failed to add employee.\nReason: No employee name given.");
    msgBox.exec();
}
QString lastName = QInputDialog::getText(NULL, "QInputDialog::getText()",
                                     "Employee last name:", QLineEdit::Normal,
                                     NULL, &ok);
     if (ok && !lastName.isEmpty()){
         qry.prepare("INSERT INTO employees (firstname, lastname)" "VALUES (:f1, :f2)");
         qry.bindValue(":f1", firstName);
         qry.bindValue(":f2", lastName);
         qry.exec();
     }
     else{
         QMessageBox msgBox;
         msgBox.setWindowTitle("Error");
         msgBox.setText("Failed to add employee.\nReason: No employee name given.");
         msgBox.exec();
     }
```

}  

and then in my main I have this:  

```c
void MainWindow::on_addEmployee_clicked()
{
    DatabaseControl myDBControl();
    myDBControl.addEmployee();
}
```

which I expected to just run the addEmployee method I wrote in the header file. However, when I compile, I get the error Error: C2228: left of '.addEmployee' must have class/struct/union  

I've looked at other instances of this error and don't really understand exactly what's wrong, and I feel it comes from my misunderstanding of methods in C++, because I know in Java something like this would work without issue (assuming the code in the header is correct which it very well may not be)  

#### Answer accepted (score 34)
You made an error here:  

```c
DatabaseControl myDBControl();
```

You declared a function called `myDBControl` taking no arguments and returning a `DatabaseControl`.  

Object declarations without any constructor arguments must omit the `()`:  

```c
DatabaseControl myDBControl;
```

This is related to (but is not precisely) the "<a href="http://en.wikipedia.org/wiki/Most_vexing_parse">most vexing parse</a>", in that it's caused by the same language rule that <em>statements are function declarations if they can be so parsed</em>.  

#### Answer 2 (score 1)
You need to say this:  

```c
 DatabaseControl myDBControl;
 myDBControl.addEmployee();
```

#### Answer 3 (score 1)
You need to say this:  

```c
 DatabaseControl myDBControl;
 myDBControl.addEmployee();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Converting QString to char* (score [70483](https://stackoverflow.com/q/5505221) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://stackoverflow.com/questions/2523765/qstring-to-char-conversion">QString to char conversion</a>  </p>
</blockquote>



I have a function (fopen in STL) that gives a char* argument as a path in my computer, but I must use QString in that place so it doesn't work.  

How can I convert QString to char* to solve this problem?  

#### Answer accepted (score 47)
See <a href="http://developer.qt.nokia.com/faq/answer/how_can_i_convert_a_qstring_to_char_and_vice_versa" rel="nofollow noreferrer">here at How can I convert a QString to char* and vice versa?</a>  

<blockquote>
  <p>In order to convert a QString to a
  char*, then you first need to get a
  latin1 representation of the string by
  calling toLatin1() on it which will
  return a QByteArray. Then call data()
  on the QByteArray to get a pointer to
  the data stored in the byte array. See
  the documentation:</p>
  
  <p><a href="https://doc.qt.io/qt-5/qstring.html#toLatin1" rel="nofollow noreferrer">https://doc.qt.io/qt-5/qstring.html#toLatin1</a>
  <a href="https://doc.qt.io/qt-5/qbytearray.html#data" rel="nofollow noreferrer">https://doc.qt.io/qt-5/qbytearray.html#data</a></p>
  
  <p>See the following example for a
  demonstration:</p>

```c
int main(int argc, char **argv)
{
 QApplication app(argc, argv);
  QString str1 = "Test";
  QByteArray ba = str1.toLatin1();
  const char *c_str2 = ba.data();
  printf("str2: %s", c_str2);
  return app.exec();
}
```
  
  <p>Note that it is necessary to store the
  bytearray before you call data() on
  it, a call like the following</p>

```c
const char *c_str2 = str2.toLatin1().data();
```
  
  <p>will make the application crash as the
  QByteArray has not been stored and
  hence no longer exists</p>
  
  <p>To convert a char* to a QString you
  can use the QString constructor that
  takes a QLatin1String, e.g:</p>

```c
QString string = QString(QLatin1String(c_str2)) ;
```
  
  See the documentation:  
  
  <a href="https://doc.qt.io/qt-5/qlatin1string.html" rel="nofollow noreferrer">https://doc.qt.io/qt-5/qlatin1string.html</a>  
</blockquote>

Of course, I discovered there is another way from this <a href="https://stackoverflow.com/questions/4214369/how-to-convert-qstring-to-stdstring/4644922#4644922">previous SO answer</a>:  

```c
QString qs;

// Either this if you use UTF-8 anywhere
std::string utf8_text = qs.toUtf8().constData();

// or this if you on Windows :-)
std::string current_locale_text = qs.toLocal8Bit().constData();
```

#### Answer 2 (score 2)
You could use <a href="http://doc.qt.nokia.com/4.7/qfile.html" rel="nofollow">QFile</a> rather than std::fstream.  

```c
QFile           file(qString);
```

Alternatively convert the QString into a char* as follows:  

```c
std::ifstream   file(qString.toLatin1().data());
```

The <a href="http://doc.qt.nokia.com/latest/qstring.html" rel="nofollow">QString</a> is in UTF-16 so it is converted toLatin1() here but QString has a couple of different conversions including toUtf8() (check your file-system it may use UTF-8).  

As noted by @0A0D above: <strong>don't</strong> store the char* in a variable without also getting a local copy of the QByteArray.  

```c
char const*      fileName = qString.toLatin1().data();
std::ifstream    file(fileName);  // fileName not valid here.
```

This is because toLatin1() returns an object of QByteArray. As it is not actually bound to a variable it is a temporary that is destroyed at the end of the expression. Thus the call to data() here returns a pointer to an internal structure that no longer exists after the ';'.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: How do I configure Qt for cross-compilation from Linux to Windows target? (score [69935](https://stackoverflow.com/q/10934683) in 2013)

#### Question
I want to cross compile the Qt libraries (and eventually my application) for a Windows x86_64 target using a Linux x86_64 host machine. I feel like I am close, but I may have a fundamental misunderstanding of some parts of this process.  

I began by installing all the mingw packages on my Fedora machine and then modifying the `win32-g++` qmake.conf file to fit my environment. However, I seem to be getting stuck with some seemingly obvious configure options for Qt: `-platform` and `-xplatform`. Qt documentation says that `-platform` should be the host machine architecture (where you are compiling) and `-xplatform` should be the target platform for which you wish to deploy. In my case, I set `-platform linux-g++-64` and `-xplatform linux-win32-g++` where linux-win32-g++ is my modified win32-g++ configuration.  

My problem is that, after executing configure with these options, I see that it invokes my system's compiler instead of the cross compiler (x86_64-w64-mingw32-gcc). If I omit the `-xplatform` option and set `-platform` to my target spec (linux-win32-g++), it invokes the cross compiler but then errors when it finds some Unix related functions aren't defined.  

Here is some output from my latest attempt: <a href="http://pastebin.com/QCpKSNev" rel="noreferrer">http://pastebin.com/QCpKSNev</a>.  

Questions:  

<ol>
<li><p>When cross-compiling something like Qt for Windows from a Linux host, should the native compiler <em>ever</em> be invoked? That is, during a cross compilation process, shouldn't we use <em>only</em> the cross compiler? I don't see why Qt's configure script tries to invoke my system's native compiler when I specify the `-xplatform` option.</p></li>
<li><p>If I'm using a mingw cross-compiler, when will I have to deal with a specs file? Spec files for GCC are still sort of a mystery to me, so I am wondering if some background here will help me.</p></li>
<li><p>In general, beyond specifying a cross compiler in my qmake.conf, what else might I need to consider?</p></li>
</ol>

#### Answer accepted (score 65)
Just use <a href="http://mxe.cc/" rel="noreferrer">M cross environment (MXE)</a>. It takes the pain out of the whole process:  

<ul>
<li><p>Get it:</p>

```c
$ git clone https://github.com/mxe/mxe.git
```</li>
<li><p>Install <a href="http://mxe.cc/#requirements" rel="noreferrer">build dependencies</a></p></li>
<li><p>Build Qt for Windows, its dependencies, and the cross-build tools;
this will take about an hour on a fast machine with decent internet access;
the download is about 500MB:</p>

```c
$ cd mxe && make qt
```</li>
<li><p>Go to the directory of your app and add the cross-build tools to the <strong>PATH</strong> environment variable:</p>

```c
$ export PATH=<mxe root>/usr/bin:$PATH
```</li>
<li><p>Run the Qt Makefile generator tool then build:</p>

```c
$ <mxe root>/usr/i686-pc-mingw32/qt/bin/qmake && make
```</li>
<li><p>You should find the binary in the ./release directory:</p>

```c
$ wine release/foo.exe
```</li>
</ul>

<strong>Some notes</strong>:  

<ul>
<li><p>Use the master branch of the MXE repository; it appears to get a lot more love from the development team.</p></li>
<li><p>The output is a 32-bit static binary, which will work well on 64-bit Windows.</p></li>
</ul>

#### Answer 2 (score 16)
(This is an update of @Tshepang's answer, as MXE has evolved since his answer)  

<h5>Building Qt</h1>

Rather than using `make qt` to build Qt, you can use `MXE_TARGETS` to control your target machine and toolchain (32- or 64-bit). MXE started using `.static` and `.shared` as a part of the target name to show which type of lib you want to build.  

```c
# The following is the same as `make qt`, see explanation on default settings after the code block.
make qt MXE_TARGETS=i686-w64-mingw32.static   # MinGW-w64, 32-bit, static libs

# Other targets you can use:
make qt MXE_TARGETS=x86_64-w64-mingw32.static # MinGW-w64, 64-bit, static libs
make qt MXE_TARGETS=i686-w64-mingw32.shared   # MinGW-w64, 32-bit, shared libs

# You can even specify two targets, and they are built in one run:
# (And that's why it is MXE_TARGET**S**, not MXE_TARGET ;)
# MinGW-w64, both 32- and 64-bit, static libs
make qt MXE_TARGETS='i686-w64-mingw32.static x86_64-w64-mingw32.static'
```

In @Tshepang's original answer, he did not specify an `MXE_TARGETS`, and the default is used. At the time he wrote his answer, the default was `i686-pc-mingw32`, now it's `i686-w64-mingw32.static`. If you explicitly set `MXE_TARGETS` to `i686-w64-mingw32`, omitting `.static`, a warning is printed because this syntax is now deprecated. If you try to set the target to `i686-pc-mingw32`, it will show an error as MXE has removed support for MinGW.org (i.e. i686-pc-mingw32).  

<h5>Running `qmake`</h1>

As we changed the `MXE_TARGETS`, the `&lt;mxe root&gt;/usr/i686-pc-mingw32/qt/bin/qmake` command will no longer work. Now, what you need to do is:  

```c
<mxe root>/usr/<TARGET>/qt/bin/qmake
```

If you didn't specify `MXE_TARGETS`, do this:  

```c
<mxe root>/usr/i686-w64-mingw32.static/qt/bin/qmake
```

<strong>Update:</strong> The new default is now `i686-w64-mingw32.static`  

#### Answer 3 (score 4)
Ok I think I've got it figured out.  

Based in part on <a href="https://github.com/mxe/mxe/blob/master/src/qt.mk" rel="nofollow noreferrer">https://github.com/mxe/mxe/blob/master/src/qt.mk</a> and <a href="https://www.videolan.org/developers/vlc/contrib/src/qt4/rules.mak" rel="nofollow noreferrer">https://www.videolan.org/developers/vlc/contrib/src/qt4/rules.mak</a>  

It appears that "initially" when you run configure (with -xtarget, etc.), it configures then runs your "hosts" gcc to build the local binary file ./bin/qmake  

```c
 ./configure -xplatform win32-g++ -device-option CROSS_COMPILE=$cross_prefix_here -nomake examples ...
```

then you run normal "make" and it builds it for mingw  

```c
  make
  make install
```

so  

<ol>
<li><p>yes</p></li>
<li><p>only if you need to use something other than msvcrt.dll (its default).  Though I have never used anything else so I don't know for certain.</p></li>
<li><p><a href="https://stackoverflow.com/a/18792925/32453">https://stackoverflow.com/a/18792925/32453</a> lists some configure params.</p></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: What does the Q_OBJECT macro do? Why do all Qt objects need this macro? (score [69320](https://stackoverflow.com/q/1368584) in 2016)

#### Question
I just started using Qt and noticed that all the example class definitions have the macro `Q_OBJECT` as the first line. What is the purpose of this preprocessor macro?  

#### Answer accepted (score 129)
From the <a href="http://doc.qt.io/qt-4.8/moc.html" rel="noreferrer">Qt documentation</a>:  

<blockquote>
  <p>The Meta-Object Compiler, moc, is the
  program that handles Qt's C++
  extensions.</p>
  
  <p>The moc tool reads a C++ header file.
  If it finds one or more class
  declarations that contain the Q_OBJECT
  macro, it produces a C++ source file
  containing the meta-object code for
  those classes. Among other things,
  meta-object code is required for the
  signals and slots mechanism, the
  run-time type information, and the
  dynamic property system.</p>
</blockquote>

#### Answer 2 (score 17)
<p>It simply tells the pre-compiler that this class has gui elements and needs to be run through the 'moc' you only need to add this to classes that use the signal/slot mechanism.<br>
But it will be quietly ignored in any other classes - it just adds to the build time.</p>

#### Answer 3 (score 8)
<p>The MOC (meta object compiler) converts the Q_OBJECT macro included header files in to C++ equivalent source code.
It basically controls the signal-slot mechanism, and makes it understandable to the C++ compiler</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: Qt parsing JSON using QJsonDocument, QJsonObject, QJsonArray (score [69072](https://stackoverflow.com/q/19822211) in 2019)

#### Question
I'm using Qt5. I am trying to obtain values from a json object. Here is what the json object looks like that I am trying to get data from:  

```c
{
    "success": true,
    "properties": [
        {
            "ID": 1001,
            "PropertyName": "McDonalds",
            "key": "00112233445566778899aabbccddeeff"
        },
        {
            "ID": 1002,
            "PropertyName": "Burger King",
            "key": "10112233445566778899aabbccddeeff"
        },
        {
            "ID": 1003,
            "PropertyName": "Taco Bell",
            "key": "20112233445566778899aabbccddeeff"
        }
    ]
}
```

How can I create three arrays that contain `properties[x].ID`, `properties[x].PropertyName`, and `properties[x].key` in Qt?  

Edit:  

Using `QScriptEngine` I tried this:  

```c
QString data = (QString)reply->readAll();

QScriptEngine engine;

QScriptValue result = engine.evaluate(data);

qDebug() << result.toString();
```

Debug is saying "SyntaxError: Parse error"  

#### Answer accepted (score 55)
I figured it out:  

```c
QStringList propertyNames;
QStringList propertyKeys;
QString strReply = (QString)reply->readAll();
QJsonDocument jsonResponse = QJsonDocument::fromJson(strReply.toUtf8());
QJsonObject jsonObject = jsonResponse.object();
QJsonArray jsonArray = jsonObject["properties"].toArray();

foreach (const QJsonValue & value, jsonArray) {
    QJsonObject obj = value.toObject();
    propertyNames.append(obj["PropertyName"].toString());
    propertyKeys.append(obj["key"].toString());
}
```

#### Answer 2 (score 3)
<p>Here is an example from 
<a href="http://erickveil.github.io/2016/04/06/How-To-Manipulate-JSON-With-C++-and-Qt.html" rel="nofollow noreferrer">How To Manipulate JSON With C++ and Qt</a>.</p>

```c
// reads a json file from disk to QVariantMap
// originally from http://erickveil.github.io/2016/04/06/How-To-Manipulate-JSON-With-C++-and-Qt.html
bool readJsonFile(std::string file_path, QVariantMap& result)
{
    // step 1
    QFile file_obj(QString::fromStdString(file_path));
    if (!file_obj.open(QIODevice::ReadOnly)) {
    std::cout << "Failed to open " << file_path << std::endl;
    exit(1);
    }

    // step 2
    QTextStream file_text(&file_obj);
    QString json_string;
    json_string = file_text.readAll();
    file_obj.close();
    QByteArray json_bytes = json_string.toLocal8Bit();

    // step 3
    auto json_doc = QJsonDocument::fromJson(json_bytes);

    if (json_doc.isNull()) {
        std::cout << "Failed to create JSON doc." << std::endl;
        return false;
    }
    if (!json_doc.isObject()) {
        std::cout << "JSON is not an object." << std::endl;
        return false;
    }

    QJsonObject json_obj = json_doc.object();

    if (json_obj.isEmpty()) {
        std::cout << "JSON object is empty." << std::endl;
        return false;
    }

    // step 4
    result = json_obj.toVariantMap();
    return true;
}

// writes a QVariantMap to disk
bool writeJsonFile(QVariantMap point_map, std::string file_path)
{
    QJsonObject json_obj = QJsonObject::fromVariantMap(point_map);
    QJsonDocument json_doc(json_obj);
    QString json_string = json_doc.toJson();

    QFile save_file(QString::fromStdString(file_path));
    if (!save_file.open(QIODevice::WriteOnly)) {
        std::cout << "failed to open save file" << std::endl;
        return false;
    }
    save_file.write(json_string.toLocal8Bit());
    save_file.close();
    return true;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: what is the correct way to implement a QThread... (example please...) (score [68687](https://stackoverflow.com/q/4093159) in 2018)

#### Question
The Qt documentation for QThread says to create a class from QThread, and to implement the run method.   

Below is taken from the 4.7 Qthread documentation...  

<blockquote>
  To create your own threads, subclass QThread and reimplement run(). For example:   
</blockquote>

```c
 class MyThread : public QThread
 {
 public:
     void run();
 };

 void MyThread::run()
 {
     QTcpSocket socket;
     // connect QTcpSocket's signals somewhere meaningful
     ...
     socket.connectToHost(hostName, portNumber);
     exec();
 }
```

So in every single thread I've created, I've done just that and for most things it works just fine (I do not implement moveToThread(this) in any of my objects and it works great).  

I hit a snag last week (managed to get through it by working around where I created my objects) and found the <a href="http://blog.qt.io/blog/2010/06/17/youre-doing-it-wrong/" rel="noreferrer">following blog post</a>. Here is basically says that subclassing QThread really isn't the correct way to do it (and that the documentation is incorrect).  

This is coming from a Qt developer so at first glance I was interested and upon further reflection, agree with him. Following OO principles, you really only want to subclass a class to further enhance that class... not to just use the classes methods directly... thats why you instantiate...   

Lets say I wanted to move a custom QObject class to a thread... what would be the 'correct' way of doing it? In that blog post, he 'says' he has an example somewhere... but if someone could further explain it to me it'd be greatly appreciated!  

<strong>Update:</strong>  

Since this question gets so much attention, here is a copy and paste of the 4.8 documentation with the 'proper' way to implement a QThread.  

```c
class Worker : public QObject
 {
     Q_OBJECT
     QThread workerThread;

 public slots:
     void doWork(const QString &parameter) {
         // ...
         emit resultReady(result);
     }

 signals:
     void resultReady(const QString &result);
 };

 class Controller : public QObject
 {
     Q_OBJECT
     QThread workerThread;
 public:
     Controller() {
         Worker *worker = new Worker;
         worker->moveToThread(&workerThread);
         connect(workerThread, SIGNAL(finished()), worker, SLOT(deleteLater()));
         connect(this, SIGNAL(operate(QString)), worker, SLOT(doWork(QString)));
         connect(worker, SIGNAL(resultReady(QString)), this, SLOT(handleResults(QString)));
         workerThread.start();
     }
     ~Controller() {
         workerThread.quit();
         workerThread.wait();
     }
 public slots:
     void handleResults(const QString &);
 signals:
     void operate(const QString &);
 };
```

I still believe that it is worthwhile to point out that they include an extra `Worker::workerThread` member that is unnecessary and is never used in their example. Remove that piece and it is a proper example of how to do threading in Qt.  

#### Answer accepted (score 31)
About the only thing I can think of to add is to further state that `QObject`s have an affinity with a single thread. This is usually the thread that creates the `QObject`. So if you create a `QObject` in the app's main thread and want to use it in another thread, you need to use `moveToThread()` to change the affinity.  

This saves having to subclass `QThread` and creating your objects in the `run()` method, thus keeping your stuff nicely encapsulated.  

That blog post does include a link to an <a href="http://blog.qt.io/blog/2006/12/04/threading-without-the-headache/" rel="noreferrer">example</a>. It is pretty short but it shows the basic idea. Create your `QObject`s, connect your signals, create your `QThread`, move your `QObjects` to the `QThread` and start the thread. The signal/slot mechanisms will ensure that thread boundaries are crossed properly and safely.   

You may have to introduce synchronization if you have to call methods on your object outside of that mechanism.  

I know Qt has some other nice <a href="http://qt-project.org/doc/qt-4.8/threads-qtconcurrent.html" rel="noreferrer">threading facilities</a> beyond threads that are probably worth getting familiar with but I have yet to do so :)  

#### Answer 2 (score 9)
Here's <a href="http://mayaposch.wordpress.com/2011/11/01/how-to-really-truly-use-qthreads-the-full-explanation/" rel="noreferrer">one example of how to use QThread correctly</a>, but it has some issues with it, which are reflected in the comments. In particular, since the order in which the slots are executed isn't strictly defined, it could lead to various problems. The comment posted on August 6, 2013 gives a nice idea how to deal with this issue. I use something like that in my program, and here's some example code to clarify.  

The basic idea is the same: I create a QThread instance that lives in my main thread, a worker class instance that lives in the new thread I created, and then I connect all the signals.  

```c
void ChildProcesses::start()
{
    QThread *childrenWatcherThread = new QThread();
    ChildrenWatcher *childrenWatcher = new ChildrenWatcher();
    childrenWatcher->moveToThread(childrenWatcherThread);
    // These three signals carry the "outcome" of the worker job.
    connect(childrenWatcher, SIGNAL(exited(int, int)),
            SLOT(onChildExited(int, int)));
    connect(childrenWatcher, SIGNAL(signalled(int, int)),
            SLOT(onChildSignalled(int, int)));
    connect(childrenWatcher, SIGNAL(stateChanged(int)),
            SLOT(onChildStateChanged(int)));
    // Make the watcher watch when the thread starts:
    connect(childrenWatcherThread, SIGNAL(started()),
            childrenWatcher, SLOT(watch()));
    // Make the watcher set its 'stop' flag when we're done.
    // This is performed while the watch() method is still running,
    // so we need to execute it concurrently from this thread,
    // hence the Qt::DirectConnection. The stop() method is thread-safe
    // (uses a mutex to set the flag).
    connect(this, SIGNAL(stopped()),
            childrenWatcher, SLOT(stop()), Qt::DirectConnection);
    // Make the thread quit when the watcher self-destructs:
    connect(childrenWatcher, SIGNAL(destroyed()),
            childrenWatcherThread, SLOT(quit()));
    // Make the thread self-destruct when it finishes,
    // or rather, make the main thread delete it:
    connect(childrenWatcherThread, SIGNAL(finished()),
            childrenWatcherThread, SLOT(deleteLater()));
    childrenWatcherThread->start();
}
```

Some background:  

The ChildProcesses class is a child process manager that starts new child processes with spawn() calls, keeps the list of the processes currently running and so on. However, it needs to keep track of the children states, which means using waitpid() call on Linux or WaitForMultipleObjects on Windows. I used to call these in non-blocking mode using a timer, but now I want more prompt reaction, which means blocking mode. That's where the thread comes in.  

The ChildrenWatcher class is defined as follows:  

```c
class ChildrenWatcher: public QObject {
    Q_OBJECT
private:
    QMutex mutex;
    bool stopped;
    bool isStopped();
public:
    ChildrenWatcher();
public slots:
    /// This is the method which runs in the thread.
    void watch();
    /// Sets the stop flag.
    void stop();
signals:
    /// A child process exited normally.
    void exited(int ospid, int code);
    /// A child process crashed (Unix only).
    void signalled(int ospid, int signal);
    /// Something happened to a child (Unix only).
    void stateChanged(int ospid);
};
```

Here how it works. When all this stuff is started, the ChildProcess::start() method is called (see above). It creates a new QThread and a new ChildrenWatcher, which is then moved to the new thread. Then I connect three signals which inform my manager about the fate of its child processes (exited/signalled/god-knows-what-happened). Then starts the main fun.  

I connect QThread::started() to the ChildrenWatcher::watch() method so it is started as soon as the thread is ready. Since the watcher lives in the new thread, that's where the watch() method is executed (queued connection is used to call the slot).  

Then I connect the ChildProcesses::stopped() signal to the ChildrenWatcher::stop() slot using Qt::DirectConnection because I need to do it asynchronously. This is needed so my thread stops when the ChildProcesses manager is no longer needed. The stop() method looks like this:  

```c
void ChildrenWatcher::stop()
{
    mutex.lock();
    stopped = true;
    mutex.unlock();
}
```

And then ChildrenWatcher::watch():  

```c
void ChildrenWatcher::watch()
{
  while (!isStopped()) {
    // Blocking waitpid() call here.
    // Maybe emit one of the three informational signals here too.
  }
  // Self-destruct now!
  deleteLater();
}
```

Oh, and the isStopped() method is just a convenient way to use a mutex in the while() condition:  

```c
bool ChildrenWatcher::isStopped()
{
    bool stopped;
    mutex.lock();
    stopped = this->stopped;
    mutex.unlock();
    return stopped;
}
```

So what happens here is that I set the stopped flag when I need to finish, and then the next time isStopped() is called it returns false and the thread ends.  

So what happens when the watch() loop ends? It calls deleteLater() so the object self-destructs as soon as control is returned to the thread event loop which happens just right after the deleteLater() call (when watch() returns). Going back to ChildProcesses::start(), you can see that there is a connection from the destroyed() signal of the watcher to the quit() slot of the thread. This means that the thread automatically finishes when the watcher is done. And when it's finished, it self-destructs too because its own finished() signal is connected to its deleteLater() slot.  

This is pretty much the same idea as Maya posted, but because I use the self-destruct idiom, I don't need to depend on the sequence in which the slots are called. It's always self-destruct first, stop thread later, then it self-destructs too. I could define a finished() signal in the worker, and then connect it to its own deleteLater(), but that would only mean one connection more. Since I don't need a finished() signal for any other purpose, I chose to just call deleteLater() from the worker itself.  

Maya also mentions that you shouldn't allocate new QObjects in the worker's constructor because they won't live in the thread you move the worker to. I'd say do it anyway because that's the way OOP works. Just make sure all those QObjects are children of the worker (that is, use the QObject(QObject*) constructor) - moveToThread() moves all the children along with the object being moved. If you really need to have QObjects that aren't children of your object, then override moveToThread() in your worker so it moves all the necessary stuff too.  

#### Answer 3 (score 3)
Not to detract from @sergey-tachenov's excellent answer, but in Qt5 you can stop using SIGNAL and SLOT, simplify your code and have the advantage of compile time checking:  

```c
void ChildProcesses::start()
{
    QThread *childrenWatcherThread = new QThread();
    ChildrenWatcher *childrenWatcher = new ChildrenWatcher();
    childrenWatcher->moveToThread(childrenWatcherThread);
    // These three signals carry the "outcome" of the worker job.
    connect(childrenWatcher, ChildrenWatcher::exited,
            ChildProcesses::onChildExited);
    connect(childrenWatcher, ChildrenWatcher::signalled,
            ChildProcesses::onChildSignalled);
    connect(childrenWatcher, ChildrenWatcher::stateChanged,
            ChildProcesses::onChildStateChanged);
    // Make the watcher watch when the thread starts:
    connect(childrenWatcherThread, QThread::started,
            childrenWatcher, ChildrenWatcher::watch);
    // Make the watcher set its 'stop' flag when we're done.
    // This is performed while the watch() method is still running,
    // so we need to execute it concurrently from this thread,
    // hence the Qt::DirectConnection. The stop() method is thread-safe
    // (uses a mutex to set the flag).
    connect(this, ChildProcesses::stopped,
            childrenWatcher, ChildrenWatcher::stop, Qt::DirectConnection);
    // Make the thread quit when the watcher self-destructs:
    connect(childrenWatcher, ChildrenWatcher::destroyed,
            childrenWatcherThread, QThread::quit);
    // Make the thread self-destruct when it finishes,
    // or rather, make the main thread delete it:
    connect(childrenWatcherThread, QThread::finished,
            childrenWatcherThread, QThread::deleteLater);
    childrenWatcherThread->start();
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: How to build a full path string (safely) from separate strings? (score [68494](https://stackoverflow.com/q/6297738) in 2011)

#### Question
Does C++ have any equivalent to python's function `os.path.join`? Basically, I'm looking for something that combines two (or more) parts of a file path so that you don't have to worry about making sure the two parts fit together perfectly. If it's in Qt, that would be cool too.  

Basically I spent an hour debugging some code and at least part of it was because `root + filename` had to be `root/ + filename`, and I'm looking to avoid that in the future.  

#### Answer accepted (score 38)
Check out <a href="http://qt-project.org/doc/qt-5/qdir.html#filePath">QDir</a> for that:  

```c
QString path = QDir(dirPath).filePath(fileName);
```

#### Answer 2 (score 94)
Only as part of <a href="http://www.boost.org/doc/libs/release/libs/filesystem/index.html" rel="noreferrer">Boost.Filesystem</a> library. Here is an example:  

```c
#include <iostream>
#include <boost/filesystem.hpp>

namespace fs = boost::filesystem;

int main ()
{
    fs::path dir ("/tmp");
    fs::path file ("foo.txt");
    fs::path full_path = dir / file;
    std::cout << full_path << std::endl;
    return 0;
}
```

Here is an example of compiling and running (platform specific):  

```c
$ g++ ./test.cpp -o test -lboost_filesystem -lboost_system
$ ./test 
/tmp/foo.txt
```

#### Answer 3 (score 19)
Similar to <strong>@user405725</strong>'s answer (but not using boost), and mentioned by <strong>@ildjarn</strong> in a comment, this functionality is available as part of <a href="http://en.cppreference.com/w/cpp/experimental/fs/path/append" rel="noreferrer">std::experimental::filesystem</a>. The following code compiles using Microsoft Visual Studio 2015 Community Edition:  

```c
#include <iostream>
#include <filesystem>
namespace fs = std::experimental::filesystem;

int main() 
{
    fs::path dir ("/tmp");
    fs::path file ("foo.txt");
    fs::path full_path = dir / file;
    std::cout << full_path << std::endl;
    return 0;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: C++ signal to QML slot in Qt (score [68457](https://stackoverflow.com/q/8834147) in 2017)

#### Question
<p>I want to send a Signal from C++ to a Slot in my QML File.
I already got it working without and primitive type parameters, although if I want to send a `QString` to my QML Slot I get an error whilst connecting.</p>

I connect in main.cpp   

```c
QObject *contentView = rootObject->findChild<QObject*>(QString("contentView"));
QObject::connect(&myObj,      SIGNAL(finishedGatheringDataForItem(QString)), 
                 contentView, SLOT(updateViewWithItem(QString)));
```

the relavant part of my qml File  

```c
Rectangle {
        objectName: "contentView"
        function updateViewWithItem(string) { console.log('got some Items'); }  // slot
}
```

Error:  

```c
Object::connect: No such slot QDeclarativeRectangle_QML_2::updateViewWithItem(QString)
```

#### Answer accepted (score 35)
I think it would be best if you check this tutorial:  

<a href="http://doc.qt.io/qt-4.8/qtbinding.html" rel="noreferrer">http://doc.qt.io/qt-4.8/qtbinding.html</a>  

especially this section:  

<a href="http://doc.qt.io/qt-4.8/qtbinding.html#receiving-signals" rel="noreferrer">http://doc.qt.io/qt-4.8/qtbinding.html#receiving-signals</a>  

I think your mistake in this case might either be that you didn't declare it as a slot or you didn't make it invocable. Both options are explained in the Qt Tutorial.  

<p>Also, you need to use a QVariant in order to exchange data between C++ and QML. 
You can also register types, e.g. Widgets and stuff, so that you can use them in QML as a "native" type like a rectangle. In most cases this is not recommended, except if you need some certain extern class or some data that you cannot display otherwise in your QML Interface. </p>

The reason for the QVariant is the Script based approach of QML. The QVariant basically contains your data and a desription of the data type, so that the QML knows how to handle it properly. That's why you have to specify the parameter in QML with String, int etc.. But the original data exchange with C++  remains a QVariant  

I have used the qmlRegisterType before, but it is a very inconvenient Solution for simple data types. It is rather used for more complex data, such as custom Widgets, Canvas or Video elements that QML does not natively support or extended `QStandardItemModels` . It is a more convenient way to exchange data between QML and C++ and does not need Signals or Slots in first instance, because the QStandardItemModel updates the GUI automatically. For using the QStandardItemModel you need to register the Type with qmlRegisterType.. . The Model can then be used in Model based Views such as the ListView etc.   

I attached a tutorial for this topic, it describes how to use the QListModel.  

<a href="http://doc.qt.io/qt-4.8/qdeclarativemodels.html" rel="noreferrer">http://doc.qt.io/qt-4.8/qdeclarativemodels.html</a>  

#### Answer 2 (score 36)
You should use <a href="http://doc.qt.io/qt-5/qml-qtqml-connections.html" rel="nofollow noreferrer"><strong>Connections</strong></a> in this case (maybe it's the only way to connect).  

<ol>
<li><p>Put your object <strong>myObj</strong> to QML file by `setContextProperty`</p>

```c
qmlVectorForm->rootContext()->setContextProperty("YourObject", myOb);
```</li>
<li><p>Your signal is</p>

```c
finishedGatheringDataForItem(QString signalString)
```</li>
<li><p>In QML file, add Connectios likes below:</p>

```c
Connections {
    target: YourObject 
    onFinishedGatheringDataForItem: {
        qmlString = signalString
    }
}
```</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: switch/case statement in C++ with a QString type (score [68450](https://stackoverflow.com/q/5452188) in 2019)

#### Question
I want to use switch-case in my program but the compiler gives me this error:  

```c
switch expression of type 'QString' is illegal
```

How can I use the `switch` statement with a `QString`?  

My code is as follows:  

```c
bool isStopWord( QString word )
{
bool flag = false ;

switch( word )
{
case "the":
    flag = true ;
    break ;
case "at" :
    flag = true ;
    break ;
case "in" :
    flag = true ;
    break ;
case "your":
    flag = true ;
    break ;
case "near":
    flag = true ;
    break ;
case "all":
    flag = true ;
    break ;
case "this":
    flag = true ;
    break ;
}

return flag ;
}
```

#### Answer accepted (score 29)
<blockquote>
  How can I use the switch statement with a QString?  
</blockquote>

You can't. In C++ language `switch` statement can only be used with integral or enum types. You can formally put an object of class type into a `switch` statement, but that simply means that the compiler will look for a user-defined conversion to convert it to integral or enum type.  

#### Answer 2 (score 25)
You can, creating an QStringList before iteration, like this:  

```c
QStringList myOptions;
myOptions << "goLogin" << "goAway" << "goRegister";

/*
goLogin = 0
goAway = 1
goRegister = 2
*/
```

Then:  

```c
switch(myOptions.indexOf("goRegister")){
  case 0:
    // go to login...
    break;

  case 1:
    // go away...
    break;

  case 2:
    //Go to Register...
    break;

  default:
    ...
    break;
}
```

#### Answer 3 (score 4)
It's not possible to switch directly on strings in C++. However it's possible in Qt using <a href="http://doc.qt.io/qt-4.8/qmetaenum.html" rel="nofollow noreferrer">`QMetaEnum`</a> as shown here: <a href="https://www.youtube.com/watch?v=Fr6BDQD68ZE" rel="nofollow noreferrer">`Q_ENUM` and how to switch on a string</a>  

To do that, first <strong>declare an enum</strong> with the <em>strings to be used in switch cases</em> as enumerator name in your class declaration. Then add the enum to the metadata with `Q_ENUMS` in order for the program to search later.  

```c
#include <QMetaEnum>

class TestCase : public QObject
{
    Q_OBJECT
    Q_ENUMS(Cases)        // metadata declaration

public:
    explicit Test(QObject *parent = 0);

    enum Cases
    {
        THE, AT, IN, THIS // ... ==> strings to search, case sensitive
    };

public slots:
    void SwitchString(QString word);
};
```

Then in the `.cpp` file implement the needed switch after converting the string to the corresponding value with <a href="http://doc.qt.io/qt-4.8/qmetaenum.html#keyToValue" rel="nofollow noreferrer"></a>.  

The comparison is case sensitive so if you want a case insensitive search, convert the input string to upper/lower case first. You can also do other transformations needed to the string. For example in case you need to switch strings with blank spaces or unallowed characters in C/C++ identifiers, you may convert/remove/replace those characters to make the string a valid identifier.  

```c
void TestCase::SwitchString(QString word)
{
    // get information about the enum named "Cases"
    QMetaObject MetaObject = this->staticMetaObject;
    QMetaEnum MetaEnum = MetaObject.enumerator(MetaObject.indexOfEnumerator("Cases"));

    switch (MetaEnum.keyToValue(word.toUpper().toLatin1()))
    // or simply switch (MetaEnum.keyToValue(word)) if no string modification is needed
    {
        case THE:  /* do something */ break;
        case AT:   /* do something */ break;
        case IN:   /* do something */ break;
        case THIS: /* do something */ break;
        default:   /* do something */ break;
    }
}
```

Then just use the class for switching the strings. For example:  

```c
TestCase test;
test.SwitchString("At");
test.SwitchString("the");
test.SwitchString("aBCdxx");
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: How do I set a background color for the whole window of a Qt application? (score [68078](https://stackoverflow.com/q/1675992) in 2017)

#### Question
Does anyone know how one would be able to set a background color for the whole window of a Qt application?  

So far I am using stylesheets but can only figure out how to assign a background color to a widget such as `QGroupBox` or `QPushButton`. Basically, if I want a black background how would I make it seamless without any borders of the original background?  

#### Answer accepted (score 26)
I would simply use a Style Sheet for the whole window.  

For instance, if your window is inheriting from QWidget, here is what I'm doing :  

```c
MainWindow::MainWindow(QWidget *parent) : QWidget(parent), ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    this->setStyleSheet("background-color: black;");
}
```

On my Mac, my whole application window is black (except the title bar).  

EDIT : according to comment, here is a solution without using ui files and loading an external style sheet  

```c
#include <QtGui/QApplication>
#include <QtGui/QMainWindow>
#include <QtGui/QVBoxLayout>
#include <QtGui/QPushButton>
#include <QtCore/QFile>

int main(int ArgC, char* ArgV[])
{
QApplication MyApp(ArgC, ArgV);

QMainWindow* pWindow = new QMainWindow;
QVBoxLayout* pLayout = new QVBoxLayout(pWindow);
pWindow->setLayout(pLayout);

QPushButton* pButton = new QPushButton("Test", pWindow);
pLayout->addWidget(pButton);

QFile file(":/qss/default.qss");
file.open(QFile::ReadOnly);
QString styleSheet = QLatin1String(file.readAll());

qApp->setStyleSheet(styleSheet);

pWindow->setVisible(true);
MyApp.exec();
}
```

The style sheet file (default.qss) is as follow :  

```c
QWidget {
  background-color: black;
}
```

This file is part of a resource file (stylesheet.qrc) :  

```c
<RCC>
  <qresource prefix="/qss">
    <file>default.qss</file>
  </qresource>
</RCC>
```

And here is my project file :  

```c
TARGET = StyleSheet
TEMPLATE = app
SOURCES += main.cpp
RESOURCES += stylesheet.qrc
```

#### Answer 2 (score 13)
This has worked for me:  

```c
a = new QApplication(argc, argv);
QPalette pal = a->palette();
pal.setColor(QPalette::Window, Qt::white);
a->setPalette(pal);
```

#### Answer 3 (score 4)
Simply just add   

```c
setStyleSheet("background-color: white;");
```

to your code, you can give any color directly.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Iterating over a QMap with for (score [67619](https://stackoverflow.com/q/8517853) in 2015)

#### Question
I've a `QMap` object and I am trying to write its content to a file.  

```c
QMap<QString, QString> extensions;
//.. 

for(auto e : extensions)
{
  fout << e.first << "," << e.second << '\n';
}  
```

Why do I get: `error: 'class QString' has no member named 'first' nor 'second'`  

Is `e` not of type `QPair`?  

#### Answer accepted (score 47)
If you want the STL style with `first` and `second`, do this:  

```c
for(auto e : extensions.toStdMap())
{
  fout << e.first << "," << e.second << '\n';
}
```

If you want to use what Qt offers, do this:  

```c
for(auto e : extensions.keys())
{
  fout << e << "," << extensions.value(e) << '\n';
}
```

#### Answer 2 (score 46)
<p>C++11 range-based-for uses the type of the dereferenced iterator as the automatically deduced "cursor" type. Here, it is the type of the expression `*map.begin()`.
<br>And since `QMap::iterator::operator*()` returns a reference to the value (of type `QString &amp;`), the key isn't accessible using that method.</p>

You should use one of the iterator methods described in the documentation but you should avoid using   

<ul>
<li>`keys()` because it involves creating a list of keys and then searching the value for each key, or,</li>
<li>`toStdMap()` because it copies all the map elements to another one,</li>
</ul>

<p>and that wouldn't be very optimal.
<hr>You could also use a wrapper to get `QMap::iterator` as the `auto` type:</p>

```c
template<class Map>
struct RangeWrapper {
    typedef typename Map::iterator MapIterator;
    Map &map;

    RangeWrapper(Map & map_) : map(map_) {}

    struct iterator {
        MapIterator mapIterator;
        iterator(const MapIterator &mapIterator_): mapIterator(mapIterator_) {}
        MapIterator operator*() {
            return mapIterator;
        }
        iterator & operator++() {
            ++mapIterator;
            return *this;
        }
        bool operator!=(const iterator & other) {
            return this->mapIterator != other.mapIterator;
        }
    };
    iterator begin() {
        return map.begin();
    }
    iterator end() {
        return map.end();
    }
};

// Function to be able to use automatic template type deduction
template<class Map>
RangeWrapper<Map> toRange(Map & map)
{
    return RangeWrapper<Map>(map);
}

// Usage code
QMap<QString, QString> extensions;
...
for(auto e : toRange(extensions)) {
    fout << e.key() << "," << e.value() << '\n';
}
```

There is another wrapper <a href="https://stackoverflow.com/q/6953128/894321">here</a>.  

#### Answer 3 (score 23)
For people interested in optimizations, I have tried several approaches, did some micro benchmarks, and I can conclude that <strong>STL style approach is significantly faster</strong>.  

I have tried adding integers with these methods :  

<ul>
<li>QMap::values()</li>
<li>Java style iterator (as advised in the documentation)</li>
<li>STL style iterator (as advised in the documentation too)</li>
</ul>

And I have compared it with summing integers of a QList/QVector  

Results :   

```c
Reference vector :   244  ms
Reference list :     1239  ms

QMap::values() :     6504  ms
Java style iterator :    6199  ms
STL style iterator :     2343  ms
```

Code for those interested :   

```c
#include <QDateTime>
#include <QMap>
#include <QVector>
#include <QList>
#include <QDebug>

void testQMap(){
    QMap<int, int> map;
    QVector<int> vec;
    QList<int> list;

    int nbIterations = 100;
    int size = 1000000;
    volatile int sum = 0;

    for(int i = 0; i<size; ++i){
        int randomInt = qrand()%128;
        map[i] = randomInt;
        vec.append(randomInt);
        list.append(randomInt);
    }


    // Rererence vector/list
    qint64 start = QDateTime::currentMSecsSinceEpoch();
    for(int i = 0; i<nbIterations; ++i){
        sum = 0;
        for(int j : vec){
            sum += j;
        }
    }
    qint64 end = QDateTime::currentMSecsSinceEpoch();
    qDebug() << "Reference vector : \t" << (end-start) << " ms";

    qint64 startList = QDateTime::currentMSecsSinceEpoch();
    for(int i = 0; i<nbIterations; ++i){
        sum = 0;
        for(int j : list){
            sum += j;
        }
    }
    qint64 endList = QDateTime::currentMSecsSinceEpoch();
    qDebug() << "Reference list : \t" << (endList-startList) << " ms";

    // QMap::values()
    qint64 start0 = QDateTime::currentMSecsSinceEpoch();
    for(int i = 0; i<nbIterations; ++i){
        sum = 0;
        QList<int> values = map.values();
        for(int k : values){
            sum += k;
        }
    }
    qint64 end0 = QDateTime::currentMSecsSinceEpoch();
    qDebug() << "QMap::values() : \t" << (end0-start0) << " ms";


    // Java style iterator
    qint64 start1 = QDateTime::currentMSecsSinceEpoch();
    for(int i = 0; i<nbIterations; ++i){
        sum = 0;
        QMapIterator<int, int> it(map);
        while (it.hasNext()) {
            it.next();
            sum += it.value();
        }
    }
    qint64 end1 = QDateTime::currentMSecsSinceEpoch();
    qDebug() << "Java style iterator : \t" << (end1-start1) << " ms";


    // STL style iterator
    qint64 start2 = QDateTime::currentMSecsSinceEpoch();
    for(int i = 0; i<nbIterations; ++i){
        sum = 0;
        QMap<int, int>::const_iterator it = map.constBegin();
        auto end = map.constEnd();
        while (it != end) {
            sum += it.value();
            ++it;
        }
    }
    qint64 end2 = QDateTime::currentMSecsSinceEpoch();
    qDebug() << "STL style iterator : \t" << (end2-start2) << " ms";


    qint64 start3 = QDateTime::currentMSecsSinceEpoch();
    for(int i = 0; i<nbIterations; ++i){
        sum = 0;
        auto end = map.cend();
        for (auto it = map.cbegin(); it != end; ++it)
        {
            sum += it.value();
        }
    }
    qint64 end3 = QDateTime::currentMSecsSinceEpoch();

    qDebug() << "STL style iterator v2 : \t" << (end3-start3) << " ms";
}
```

Edit July 2017 : I ran this code again on my new laptop (Qt 5.9, i7-7560U) and got some interesting changes  

```c
Reference vector :   155  ms 
Reference list :     157  ms
QMap::values():      1874  ms 
Java style iterator: 1156  ms 
STL style iterator:  1143  ms
```

STL style and Java style have very similar performances in this benchmark  

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: How to print string literal and QString with qDebug? (score [67586](https://stackoverflow.com/q/18427191) in )

#### Question
Is there any easy way to get the following work? I mean is there any helper class in `Qt` which prepares the string for `qDebug`?  

```c
QString s = "value";
qDebug("abc" + s + "def");
```

#### Answer accepted (score 21)
No really easy way I am aware of. You can do:  

```c
QByteArray s = "value";
qDebug("abc" + s + "def");
```

or  

```c
QString s = "value";
qDebug("abc" + s.toLatin1() + "def");
```

#### Answer 2 (score 24)
You can use the following:  

```c
qDebug().nospace() << "abc" << qPrintable(s) << "def";
```

The `nospace()` is to avoid printing out spaces after every argument (which is default for `qDebug()`).  

#### Answer 3 (score 11)
According to <a href="http://doc.qt.io/qt-5/qtglobal.html#qUtf8Printable" rel="noreferrer">Qt Core 5.6 documentation</a> you should use `qUtf8Printable()` from `&lt;QtGlobal&gt;` header to print `QString` with `qDebug`.  

You should do as follows:  

```c
QString s = "some text";
qDebug("%s", qUtf8Printable(s));
```

or shorter:  

```c
QString s = "some text";
qDebug(qUtf8Printable(s));
```

See:  

<ul>
<li><p><a href="http://doc.qt.io/qt-5/qtglobal.html#qPrintable" rel="noreferrer">http://doc.qt.io/qt-5/qtglobal.html#qPrintable</a></p></li>
<li><p><a href="http://doc.qt.io/qt-5/qtglobal.html#qUtf8Printable" rel="noreferrer">http://doc.qt.io/qt-5/qtglobal.html#qUtf8Printable</a></p></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: fatal error: QtGui/QApplication: No such file or directory (score [67138](https://stackoverflow.com/q/5535661) in 2019)

#### Question
I'm using Qt Creator, and this line is generated automatically by the Qt Creator:  

`#include &lt;QtGui/QApplication&gt;`  

But, why am I getting this message?  

`QtGui/QApplication:  No such file or directory`  

#### Answer 2 (score 17)
Depending on the Qt-version (5) QtGui was moved to QtWidgets; so it becomes   

```c
#include <QtWidgets/QApplication>
```

#### Answer 3 (score 14)
You can try to add 'declarative' to the Project file:  

```c
QT += gui declarative
```

then  

```c
#include <QApplication>
```

It helps me  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: How do i use Qt in my Visual Studio 2015 projects? (score [66140](https://stackoverflow.com/q/32894097) in )

#### Question
We have large project that used .NET Framework for showing forms/windows. Recently i decided to deprecate CLR dependency and move to Qt.   

While learning Qt, we've migrated from Visual studio 2013 to 2015 and then i noticed that there is no qt support for MSVC 14 version which vs2015 use.  

Additionally, Qt vs addin was not working jn visual studio express/community edition we use. Is there any chance for me to use Qt and qt addin in our projects?  

Searching web did not help, and it looks like no one use Qt with latest Visual Studio?  

#### Answer accepted (score 12)
As of now, you can just download Qt for Visual Studio 2015. <a href="https://marketplace.visualstudio.com/items?itemName=TheQtCompany.QtVisualStudioTools2015#overview" rel="nofollow noreferrer">Here</a>.  

#### Answer 2 (score 44)
<h5>Building</h3>

You can use Qt in Visual Studio 2015 without any problems. As already stated in the comments, you have to build it from source but Qt is pretty straightforward to build. You can download the current (5.5) sources <a href="http://download.qt.io/official_releases/qt/5.5/5.5.0/single/qt-everywhere-opensource-src-5.5.0.zip" rel="noreferrer">here</a> and then follow <a href="http://doc.qt.io/qt-5/windows-building.html" rel="noreferrer">this</a> step by step example on building it.  

I would also suggest reading <a href="http://doc.qt.io/qt-5/configure-options.html" rel="noreferrer">more about the configure options</a>, this might save you a lot of time. It might possibly save you some external dependencies as well if you skip components you do not need. My configuration for instance contains `-skip qtwebkit -skip qtwebchannel` so I do not need ruby or python.  

I could totally omit step 3 from the link. Just be sure to open the Visual Studio Command Prompt (32/64 is important here) for `configure` and `nmake`.  

<h5>Usage</h3>

For Visual Studio 2015, <a href="https://forum.qt.io/topic/56108/how-to-install-qt-vs-add-in-for-vs-2015-rc/6" rel="noreferrer">the Qt Add-In is not available anymore</a>. But there is an Extension (`Tools &gt; Extensions &amp; Updates`) called <strong>Qt5Package</strong> or <strong>QtPackage</strong> which has the same functionality. After installing it, you have the Qt entry on your main toolbar where you have to specify a version and the path to the directory where you built it. This version will also be associated with the current project via the same menu.  

If you load an existing project, you also have to convert it so the whole Qt functionality is used automatically. You can do this by opening the solution and right click on it; there should be an entry for the conversion to a <strong>QtAddin</strong> generated project.  

I am using Qt 5.5 on Visual Studio 2015 with an old project and it is working without any issues.  

#### Answer 3 (score 0)
Qt have finally added support for Visual Studio 2013 and 2015 although it's only in beta right now. See <a href="https://bugreports.qt.io/browse/QTVSADDINBUG-404" rel="nofollow">QTVSADDINBUG-404</a> for progress and read the blog post <a href="https://blog.qt.io/blog/2016/08/11/from-visual-studio-add-in-to-qt-vs-tools-beta/" rel="nofollow">From Visual Studio Add-In To Qt VS Tools (Beta)</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: How to create a bold, red text label in Qt? (score [66101](https://stackoverflow.com/q/1464591) in )

#### Question
I want to write a single, bold red line in my application using Qt.  

As far as I understand, I would create a QLabel, set its textFormat to rich text and give it a rich text string to display:  

```c
QLabel *warning = new QLabel;
warning->setTextFormat(Qt::RichText);
warning->setText("{\\rtf1\\ansi\\ansicpg1252 {\\fonttbl\\f0\\fswiss\\fcharset0 Helvetica;} {\\colortbl;\\red255\\green0\\blue0;} \\f0 \\cf0 this is bold red text}");
```

I tested this rich text string in a rich text editor and it displays fine.  

But Qt displays the whole string with all braces, keywords and backslashes instead of "this is bold red text". What am I doing wrong?  

Thank you for your help.  

#### Answer accepted (score 59)
Try using HTML formatting: `&lt;b&gt;&lt;font... etc &lt;/b&gt;`.    

Qt Designer does it like this: `&lt;span style=" font-size:8pt; font-weight:600; color:#aa0000;"&gt;TextLabel&lt;/span&gt;`  

#### Answer 2 (score 22)
You can use <a href="http://doc.qt.io/qt-4.8/stylesheet.html" rel="noreferrer">Qt StyleSheets</a> and set the `styleSheet` property of `QLabel`  

```c
warning->setStyleSheet("font-weight: bold; color: red");
```

Qt supports most CSS styles on its `QWidget`-derived classes. You don't need to set the text format to `Qt::RichText` for this to work.  

#### Answer 3 (score 13)
Qt uses a simple <a href="http://qt-project.org/doc/qt-5/richtext-html-subset.html" rel="nofollow noreferrer">HTML subset</a> for formatting.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: How can I concatenate QStrings? (score [65515](https://stackoverflow.com/q/18826007) in 2013)

#### Question
I have a problem with printing in Qt.  

I have HTML code in QString variables. In this code I want to insert data from a database.  

I get an error:  

```c
E:\apprendreQt\gestionstock6\vente.cpp:117: error: invalid operands of types 
  'const char*' and 'const char [27]' to binary 'operator+'
```

How can I fix this?  

Here is my code:  

```c
int num_bl = ui->numeroBLlineEdit->text().toInt() ;
QString html;
QString requette = "select num_facture,date,nom,prenom,code_fiscale,designation,qte_out, prix,(qte_out * prix ) as Montant, sum(qte_out * prix) as Total from ventes join produits_en_ventes join clients  join produits on ventes.vente_id = produits_en_ventes.vente_id and ventes.client_id = clients.client_id and produits_en_ventes.produit_id = produits.produit_id where ventes.client_id = :client_id ";

if(!m_db->isOpen())
    QMessageBox::critical(this,tr("Inventoria Solution"),m_db->lastError().text()) ;
else{
    m_query->clear();
    m_query->prepare(requette);
    m_query->bindValue(":client_id ", num_bl);

    if(!m_query->exec())
        QMessageBox::critical(this,tr("Inventoria Solution"),m_query->lastError().text()) ;
    else{
        html += "       <table>"
                "<thead>"
                "<tr>"
                "<th>N°</th>"
                "<th>Désignation</th>"
                "<th>Qte</th>"
                "<th>Prix Unitaire</th>"
                "<th>Montant</th>"
                "   </tr>"
                "</thead>";
        while(m_query->next())
        {
            int num_article = 1;

            html += "<tr> <td>" + num_article + "</td> <td>"+m_query->value(5).toString()+"</td> <td>"+m_query->value(6).toInt() + "</td> <td>"+m_query->value(7).toInt() + "</td> <td>" + m_query->value(8).toInt() + "</td></tr>";
            num_article++;

        }
            html += "<tfoot>"
                "<tr>"
                "<td>Total:"+ m_query->value(9).toInt()+"</td>"
                "</tr>"
                "</tfoot>"
                "</table>";
    }
    print_Html(html);


}
```

#### Answer accepted (score 11)
If you use `operator+`, you need to provide QString as an argument, but you use integer values instead: `html += "&lt;tr&gt; &lt;td&gt;" + num_article`, where `num_article` is declared as integer. You can replace it with, for example: `QString::number(num_article)`. The same in this line:  

```c
"<td>Total:"+ m_query->value(9).toInt()+"</td>"
```

should be replaced with  

```c
"<td>Total:"+ m_query->value(9).toString()+"</td>"
```

#### Answer 2 (score 23)
I'm not sure about your error. However, AFAIK a Qstring cannot be concatenated with an int as such.  

```c
int myInt = 0;
QString text = "someString" + myInt; // WRONG

int myInt = 0;
QString text = "someString" + QString::number( myInt ); // CORRECT
```

or  

```c
int myInt = 0;
QString text = "someString" % QString::number( myInt ); // CORRECT
```

#### Answer 3 (score 3)
in Qt5 you can use the <a href="http://qt-project.org/doc/qt-5.0/qtcore/qstring.html#QStringLiteral" rel="nofollow">`QStringLiteral` macro</a> for each string that doesn't need to be localized to transform all the string literals from `const char*` (the C++ default) into QString, this will also make creation of those `QStrings` cheaper (on compilers that support it)   

for Qt4 you can use the `QString(const char*)` constructor or `QString::fromAscii(const char*)` static function   

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: Qt Layout on QMainWindow (score [64119](https://stackoverflow.com/q/1508939) in 2017)

#### Question
I designed a `QMainWindow` with `QtCreator's` designer. It consists of the default central widget (a `QWidget`) which contains a `QVBoxLayout` with all the other widgets in it. Now everything I want, is that the `QVBoxLayout` automatically occupies the whole central widgets rectangle space.  

How can I do this? I didn't find any usable property neither in the central widgets properties nor the `QVBoxLayout's` ones.  

#### Answer accepted (score 41)
You don't have to create a `QVBoxLayout` manually. Just select your central `QWidget` and press a make-layout button.  

<img src="https://i.stack.imgur.com/XT9N7.png" alt="alt text">  

#### Answer 2 (score 68)
If you want to do it with code instead of using `QtCreator`, you could set the layout in a `QWidget` and then set the `QWidget` as the central widget of the main window like this:  

```c
#include <QtGui>
#include <QWidget>
#include <QHBoxLayout>
#include "mainwindow.h"

MainWindow::MainWindow() {  

        // Set layout
        QHBoxLayout *layout = new QHBoxLayout;
        layout->addWidget(myWidget1);
        layout->addWidget(myWidget2);

        // Set layout in QWidget
        QWidget *window = new QWidget();
        window->setLayout(layout);

        // Set QWidget as the central layout of the main window
        setCentralWidget(window);

}
```

#### Answer 3 (score 13)
Add at least one widget on your `MainWindow`. Then select your window by clicking on it and click on the `VerticalLayout` Button at the top of `QTCreator`. You Vertical Layout is automatically added to the central widget and fills all the surface.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: Convert std::string to QString (score [64084](https://stackoverflow.com/q/4338067) in 2016)

#### Question
I've got an `std::string content` that I know contains UTF-8 data. I want to convert it to a <a href="http://doc.qt.io/qt-4.8/qstring.html" rel="noreferrer">`QString`</a>. How do I do that, avoiding the from-ASCII conversion in Qt?  

#### Answer accepted (score 82)
There's a `QString` function called <a href="http://doc.qt.io/qt-4.8/qstring.html#fromUtf8">`fromUtf8`</a> that takes a `const char*`:  

```c
QString str = QString::fromUtf8(content.c_str());
```

#### Answer 2 (score 77)
`QString::fromStdString(content)` is better since it is more robust. Also note, that if `std::string` is encoded in UTF-8, then it should give exactly the same result as `QString::fromUtf8(content.data(), int(content.size()))`.  

#### Answer 3 (score 6)
Usually, the best way of doing the conversion is using the method <a href="http://doc.qt.io/qt-5/qstring.html#fromUtf8" rel="noreferrer">fromUtf8</a>, but the problem is when you have strings locale-dependent.  

In these cases, it's preferable to use <a href="http://doc.qt.io/qt-5/qstring.html#fromLocal8Bit" rel="noreferrer">fromLocal8Bit</a>. Example:  

```c
std::string str = "ëxample";
QString qs = QString::fromLocal8Bit(str.c_str());
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: how to get selected rows in QTableView (score [63806](https://stackoverflow.com/q/5927499) in 2016)

#### Question
After watching many threads about getting selected rows numbers, I am really confused.  

How do you get ROW numbers in `QTableView` using `QStandardItemModel` I used below selection model and behavior as  

```c
setSelectionBehavior(QAbstractItemView::SelectRows);
setSelectionMode(QAbstractItemView::SingleSelection);
```

<p>and if you have your own way of selecting can you explain how it works.
Thanks for the help!</p>

#### Answer 2 (score 58)
The method `selectionModel()` return a `QItemSelectionModel`.  

You can use `QItemSelectionModel` class to check/change/other selection(s)  

Example:  

```c
QItemSelectionModel *select = table->selectionModel();

select->hasSelection() //check if has selection
select->selectedRows() // return selected row(s)
select->selectedColumns() // return selected column(s)
...
```

#### Answer 3 (score 13)
Check <a href="http://doc.qt.io/qt-5/qitemselectionmodel.html#selectedRows" rel="noreferrer">`selectedRows`</a> method of the <a href="http://doc.qt.io/qt-5/qitemselectionmodel.html" rel="noreferrer">`QItemSelectionModel`</a> Class .  

```c
QModelIndexList selection = yourTableView->selectionModel()->selectedRows();

// Multiple rows can be selected
for(int i=0; i< selection.count(); i++)
{
    QModelIndex index = selection.at(i);
    qDebug() << index.row();
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: QVBoxLayout: How to vertically align widgets to the top instead of the center (score [63577](https://stackoverflow.com/q/10082299) in )

#### Question
In Qt, When I add widgets to my layout, they are vertically centered by default. Is there a way to "List" the widgets from top to bottom instead of centering them vertically?  

#### Answer accepted (score 39)
use `void QLayout::setAlignment ( Qt::Alignment alignment )` method to set alignment according to your choice.  

#### Answer 2 (score 21)
I find this a little more complicated than just using `layout.setAlignment()`.  It kept not working for me until just now, when I figured out that if you have expanding widgets that you set a maximum height for, then that widget will not be aligned the way you want.    

Here is example code that does <em>not</em> top align the `QTextBrowser()` widget even though I call `layout.setAlignment(Qt.AlignTop)`.  Sorry that it is in Python, but it is pretty easy to translate to C++ (I have gone the other way many times).  

```c
from PyQt4.QtCore import *
from PyQt4.QtGui import *

class MyWidget(QWidget):
    """
    Create a widget that aligns its contents to the top.
    """

    def __init__(self, parent=None):

        QWidget.__init__(self, parent)

        layout = QVBoxLayout()

        label = QLabel('label:')
        layout.addWidget(label)

        info = QTextBrowser(self)
        info.setMinimumHeight(100)
        info.setMaximumHeight(200)
        layout.addWidget(info)        
        # Uncomment the next line to get this to align top.
#         layout.setAlignment(info, Qt.AlignTop)

        # Create a progress bar layout.
        button = QPushButton('Button 1')        
        layout.addWidget(button)        

        # This will align all the widgets to the top except
        # for the QTextBrowser() since it has a maximum size set.
        layout.setAlignment(Qt.AlignTop)

        self.setLayout(layout)


if __name__ == '__main__':

    import sys

    app = QApplication(sys.argv)

    widget = MyWidget()
    widget.show()
    widget.resize(QSize(900, 400))

    app.exec_()
```

The following explicitly calls `layout.setAlignment(info, Qt.AlignTop)` to get the expending text widget to work.  

```c
from PyQt4.QtCore import *
from PyQt4.QtGui import *

class MyWidget(QWidget):
    """
    Create a widget that aligns its contents to the top.
    """

    def __init__(self, parent=None):

        QWidget.__init__(self, parent)

        layout = QVBoxLayout()

        label = QLabel('label:')
        layout.addWidget(label)

        info = QTextBrowser(self)
        info.setMinimumHeight(100)
        info.setMaximumHeight(200)
        layout.addWidget(info)        
        # Uncomment the next line to get this to align top.
        layout.setAlignment(info, Qt.AlignTop)

        # Create a progress bar layout.
        button = QPushButton('Button 1')        
        layout.addWidget(button)        

        # This will align all the widgets to the top except
        # for the QTextBrowser() since it has a maximum size set.
        layout.setAlignment(Qt.AlignTop)

        self.setLayout(layout)


if __name__ == '__main__':

    import sys

    app = QApplication(sys.argv)

    widget = MyWidget()
    widget.show()
    widget.resize(QSize(900, 400))

    app.exec_()
```

#### Answer 3 (score 20)
If you have a `QVBoxLayout` and want your fixed size widgets to be stacked at the top, you can simply append a vertical stretch add the end:  

```c
layout.addStretch()
```

If you have multiple stretchers or other stretch items, you can specify an integer stretch factor argument that defines their size ratio.  

See also <a href="http://doc.qt.io/qt-4.8/qboxlayout.html#addStretch" rel="noreferrer">addStretch</a> and <a href="http://doc.qt.io/qt-4.8/qboxlayout.html#addSpacerItem" rel="noreferrer">addSpacerItem</a>.  

Not sure whether this answers your original question, but it is the answer to the one that I had when googling and being led to this page - so it might be useful for others too.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Qt5 Static Build yields Failed to load platform plugin "windows" (score [63348](https://stackoverflow.com/q/16773789) in 2013)

#### Question
<p>I am writing a Qt application on Windows using <strong>Visual Studio 2012</strong>. 
Using the Qt Add-in and a custom built <strong>static</strong> distribution of <strong>Qt 5.0.2</strong>.
I am running into the dreaded `"Failed to load platform plugin windows"` error whenever I run the application.
I have added the following to the linker input:</p>

```c
imm32.lib
winmm.lib
Ws2_32.lib
qtmaind.lib
Qt5Cored.lib
Qt5Guid.lib
Qt5Widgetsd.lib
```

At first I thought that maybe I should add "qwindowsd.lib" to that list as well however that did not fix the problem. What do I need to do in order to make my application run?  

#### Answer accepted (score 25)
I solved it. Thanks to <a href="http://qt-project.org/forums/viewthread/27037">this</a> I was able to get everything to work. I added the following libraries:  

```c
opengl32.lib
Qt5PlatformSupport.lib
qwindows.lib
```

I also added the following to my code:  

```c
#include <QtPlugin>
Q_IMPORT_PLUGIN (QWindowsIntegrationPlugin);
```

#### Answer 2 (score 28)
For dynamic build only: Make sure you move the qwindows.dll to the following directory:  

```c
yourapp.exe
Qt5Core.dll
...
platforms/qwindows.dll
...
```

<p>Note that the plugins directory is missing! You put all the needed folders from QT_BASE/.../plugins/* directly together with your binaries.
BTW: I did not need libEGL.dll, but my application almost has no GUI.</p>

My source: <a href="http://qt-project.org/forums/viewthread/27056/#122588" rel="noreferrer">http://qt-project.org/forums/viewthread/27056/#122588</a>  

#### Answer 3 (score 12)
I had the same error with MinGW version of Qt (not static): "Failed to load platform plugin windows".  

The solution for me was to add the DLLs `libEGL.dll` and `libEGLd.dll`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Qt: Set size of QMainWindow (score [63091](https://stackoverflow.com/q/16280323) in 2016)

#### Question
I'm new to Qt, so I wonder whether there is a way to set the size of a `QMainWindow` to (for example) 70% of the user's desktop.<br>I tried the stretch factor but it didn't work. `QWidget::setFixedSize` worked but only with a pixel number, I think.  

#### Answer accepted (score 27)
Thanks to Amir eas. The problem is solved. Here's the code for it:  

```c
#include <QDesktopWidget>
#include <QMainWindow>
...
QDesktopWidget dw;
MainWindow w;
...
int x=dw.width()*0.7;
int y=dw.height()*0.7;
w.setFixedSize(x,y);
```

#### Answer 2 (score 39)
Somewhere in your QMainWindow constructor, do this:  

`resize(QDesktopWidget().availableGeometry(this).size() * 0.7);`  

This will resize the window to 70% of the available screen space.  

#### Answer 3 (score 4)
You can use the `availableGeometry(QWidget*)` method in `QDesktopWidget`, this will give you the geometry of the screen that this widget is currently on. <br>For example:  

```c
QRect screenSize = desktop.availableGeometry(this);
this->setFixedSize(QSize(screenSize.width * 0.7f, screenSize.height * 0.7f));
```

<p>Where `this` is the MainWindow pointer.
This will work when using multiple screens.</p>

</section>

