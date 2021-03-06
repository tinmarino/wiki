[Tickz](Tickz.md)
### Crossword

* Change page color
%\usepackage{xcolor}                         % pagecolor
%\pagecolor{yellow!30}


### Charcode

\makeatletter : transform @ as a letter so it can be ised in a macro name. so not use it in .sty or .cls class

    0 = Escape character, normally \
    1 = Begin grouping, normally {
    2 = End grouping, normally }
    3 = Math shift, normally $
    4 = Alignment tab, normally &
    5 = End of line, normally <return>
    6 = Parameter, normally #
    7 = Superscript, normally ^
    8 = Subscript, normally _
    9 = Ignored character, normally <null>
    10 = Space, normally <space> and <tab>
    11 = Letter, normally only contains the letters a,...,z and A,...,Z. These characters can be used in command names
    12 = Other, normally everything else not listed in the other categories
    13 = Active character, for example ~
    14 = Comment character, normally %
    15 = Invalid character, normally <delete>

### Math

```tex
\usepackage{pgf}
\pgfmathparse
\pgfmathsetmacro{\x}{int(2 * 2)}
```

```tex
\usepackage{calc}

\newlength\len
\setlength{\textwidth+1cm}

\newcounter{cnt}
\setcounter{cnt}{1+1}
```



# Tex4ht or Htxelatex

```sh
htxelatex martin_tourneboeuf_cv_english.tex  && iconv -t utf-8  martin_tourneboeuf_cv_english.html | pandoc --self-contained -o  martin_tourneboeuf_cv_english.html
```

```tex
% Css for html
\ifx\HCode\undefined \else
    \Css{table.longtable{margin-left:0; margin-right:0;}}
    \Css{table.tabular{margin-left:0; margin-right:0;}}
\fi
```



% Doc : https://texfaq.org/FAQ-patch && http://texblog.net/latex-archive/plaintex/full-justification-with-typewriter-font/ && https://tex.stackexchange.com/questions/264224/increase-word-space-between-words-in-small-caps/264248#264248
ebb -x TestImage.png to get .xbb file (image size)
# Font

\Huge
\huge
\LARGE
\Large
\large
\normalsize (default)
\small
\footnotesize
\scriptsize
\tiny

### Texlive

```                      
                      texlive-latex-extra
                         |   |   :   :
       +-----------------+   |   :   :..................
       |                     |   :                     :
       v                     |   :                     v
texlive-pictures             |   :           texlive-plain-generic
       |                     |   :
       |    +----------------+   :...............
       |    |                                   :
       |    |              texlive              :
       |    |               | | |               :
       |    |    +----------+ | +----------+    :
       |    |    |            |            |    :
       v    v    v            |            v    v
texlive-latex-recommended     |  texlive-fonts-recommended
                 |            |            :
                 |            |            v
                 |            |           tipa
                 |            |            |
                 +----------+ | +----------+
                            | | |
                            v v v
                     texlive-latex-base
```

Package                    Archives  Disk Space
-------------------------  --------  ----------
texlive-latex-base            59 MB      216 MB
texlive-latex-recommended     74 MB      248 MB
texlive-pictures              83 MB      277 MB
texlive-fonts-recommended     83 MB      281 MB
texlive                       98 MB      314 MB
texlive-plain-generic         82 MB      261 MB
texlive-latex-extra          144 MB      452 MB
texlive-full                2804 MB     5358 MB
