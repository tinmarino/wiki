
FORCE="$1"
SYNTAX="$2"
EXTENSION="$3"
OUTPUTDIR="$4"
INPUT="$5"
CSSFILE="$6" # Not used bad concatenation

FILE=$(basename "$INPUT")
FILENAME=$(basename "$INPUT" .$EXTENSION)
FILEPATH=${INPUT%$FILE}
OUTDIR=${OUTPUTDIR%$FILEPATH*}
OUTPUT="$OUTDIR"/$FILENAME


# Define $MATH
HAS_MATH=$(grep -o "\$\$.\+\$\$" "$INPUT")
if [ ! -z "$HAS_MATH" ]; then
    MATH="--mathjax=https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
else
    MATH=""
fi


# Compile for unix (with pandoc & Perl)
# TODO replace sed and comment
# TODO if no css: yaml in file set a default (include.css)
# TODO css, if on one line, separe by comma filenames
munix(){
  # TODO remove me
  cp -r ~/wiki/wiki/Css/* ~/wiki/wiki_html/Css/
  # TODO clean me too
  echo v2
  vim -e -c'VimwikiIndex 1' -c'let a=vimwiki#base#get_globlinks_escaped()'  -c'let b=join(split(a, "\n"))' -c'call writefile([b], expand("$HOME/wiki/wiki/Src/links.txt"))'  -c'q' || echo "vim failed: $?"
  vim -e -c'VimwikiIndex 2' -c'let a=vimwiki#base#get_globlinks_escaped()'  -c'let b=join(split(a, "\n"))' -c'call writefile([b], expand("$HOME/wiki/todo/Src/links.txt"))'  -c'q'
  # Read `css:` in metadata
  CSSFILE=$(realpath --relative-to=$OUTDIR $HOME/wiki/wiki_html/Css/include.css)
  export CSS_EMBED=$(perl -0777 -ne '$_ =~ /^ *---(.+?)---/s ; $meta=$1; while ($meta =~ /^css:(.+)$/mg) {$css .= " -c " . $1}; print substr $css, 4' "$INPUT")
  [ "$CSS_EMBED" ] && export CSSFILE=$CSS_EMBED && echo Css files are: $CSSFILE

  # Convertion pipeline
  cat "$INPUT" |
  # Add h3-section betewwen h3/h2 headings and end
  # ::::::::: h3
  # :::::::: h3-parent
  # :::::: h2
  perl -pe 'BEGIN { my $open2 = 0; my $open3 = 0; my $open_parent = 0 }
    my $line=$_; my $worked = 0;

    # Open-Close if open
    if ($open3 and $line =~ s/^###[^#]/:::::::::\n::::::::: {.h3-section}\n$&/) { goto FINISH; }
    if ($open2 and $line =~ s/^##[^#]/::::::\n:::::: {.h2-section}\n$&/) {
      if ($open_parent) {
        $line = "::::::::\n$line"; $open_parent = 0;
      }
      if ($open3) {
        $line = ":::::::::\n$line"; $open3 = 0;
      }
      goto FINISH;
    }

    # Open if can
    if ( !$open3 and $line =~ /^###[^#]/ ) {
      $line = "::::::::: {.h3-section}\n$line";
      $open3 = 1;
      if ( !$open_parent ) {
        $line = ":::::::: {.h3-parent}\n$line";
        $open_parent = 1;
        goto FINISH;
      }
    }
    if (!$open2 and $line =~ s/^##[^#]/:::::: {.h2-section}\n$&/m){
      $open2 = 1;
      goto FINISH;
    }

    # Close if open and can
    if ($open3) {
      $line =~ s/^##?#?[^#]/:::::::::\n$&/m and $open3=0;
    }
    if ($open2) {
      $line =~ s/^##?[^#]/::::::\n$&/m and $open2=0
      and $open_parent and $line = "::::::::\n$line" and $open_parent=0;
    }

    # Finish
    FINISH:
    $worked = 0;
    $_ = $line; 
    END {
      $open3 and print "\n:::::::::\n";
      $open_parent and print "\n::::::::\n";
      $open2 and print "\n::::::\n";
    }
  ' |
  # Replace vim by language-vim for prism color higlight
  perl -pe' s/```vim/```language-vim/;' |
  # Surround h2 section by parent
  perl -0777 -pe '
    s/:::::: \{.h2-section}/::: {.parent}\n$&/ ;
    s/^.*::::::\n/$&:::\n/s ;
  ' |
  # Change links: add html
  sed -r 's/(\[.+\])\(([^#)]+)\)/\1(\2.html)/g' |
  # Double the new line before code
  perl -0pe 's/((^|\n\S)[^\n]*)\n\t([^*])/\1\n\n\t\3/g;' |
  # Remove spaces in void lines
  perl -lpe ' s/^\s*$//' |
  # Debug
  # tee test.md |
  # Compile: can add --self-contained and --include-header=<file>
  pandoc $MATH --standalone -f $SYNTAX -t html -T $FILE -c $CSSFILE >"$OUTPUT.html"
}


# Obsolete ?
mtermux(){
sed -r 's/(\[.+\])\(([^)]+)\)/\1(\2.html)/g' <"$INPUT" | \
	python -m markdown | \
	sed -r 's/<li>(.*)\[ \]/<li class="todo done0">\1/g; s/<li>(.*)\[X\]/<li class="todo done4">\1/g' >"$OUTPUT.html"
	# pandoc $MATH -s -f $SYNTAX -t html -c $CSSFILENAME | \
}


# Main
mmain(){
  tmp=$(uname -a)
  
  shopt -s nocasematch
  if [[ "$tmp" =~ "android" ]] ; then
  	mtermux
  else
  	munix
  fi
}


# Start
mmain
