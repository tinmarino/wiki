
FORCE="$1"
SYNTAX="$2"
EXTENSION="$3"
OUTPUTDIR="$4"
INPUT="$5"
CSSFILE="$6"

FILE=$(basename "$INPUT")
FILENAME=$(basename "$INPUT" .$EXTENSION)
FILEPATH=${INPUT%$FILE}
OUTDIR=${OUTPUTDIR%$FILEPATH*}
OUTPUT="$OUTDIR"/$FILENAME
CSSFILENAME=$(basename "$6")


# Define $MATH
HAS_MATH=$(grep -o "\$\$.\+\$\$" "$INPUT")
if [ ! -z "$HAS_MATH" ]; then
    MATH="--mathjax=https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
else
    MATH=""
fi


# Compile for unix (with pandoc & Perl)
# TODO replace sed and comment
# TODO all in one perl script
# TODO if no css: yaml in file set a default (include.css)
munix(){
  # Read `css:` in metadata
  export CSS_EMBED=$(perl -0777 -ne '$_ =~ /^ *---(.+?)---/s ; $meta=$1; while ($meta =~ /^css:(.+)$/mg) {$css .= " -c " . $1}; print substr $css, 4' "$INPUT")
  [ "$CSS_EMBED" ] && export CSSFILENAME=$CSS_EMBED && echo Css files are: $CSSFILENAME

  cat "$INPUT" |
  perl -pe 's/^###[^#]/:::::::::\n::::::::: {.h3-sections}\n$&/g' |  # Make h3 section
  perl -pe 's/^##[^#]/:::::::::\n$&/g' | # Close before hight headings
  perl -pe '++$stop if m/:::::::::\s*\S+/; !$stop && s/^::::::::://' | # Remove the first one closing nothing
  sed -r 's/(\[.+\])\(([^#)]+)\)/\1(\2.html)/g' |
  perl -0pe 's/((^|\n\S)[^\n]*)\n\t([^*])/\1\n\n\t\3/g;' |  # Double the new line before code
  perl -lpe 's/^\s*$//' | tee test1.md |  # Remove spaces in void lines
  pandoc $MATH -s -f $SYNTAX -t html -T $FILE -c $CSSFILENAME >"$OUTPUT.html" # Compile: missing -c $CSSFILENAME
}

bck() {
  echo toto
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
