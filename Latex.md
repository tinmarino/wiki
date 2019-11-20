

# Htxelatex

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
