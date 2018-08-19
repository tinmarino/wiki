
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

HAS_MATH=$(grep -o "\$\$.\+\$\$" "$INPUT")
if [ ! -z "$HAS_MATH" ]; then
    MATH="--mathjax=https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
else
    MATH=""
fi

# >&2 echo "MATH: $MATH"

munix(){
sed -r 's/(\[.+\])\(([^#)]+)\)/\1(\2.html)/g' <"$INPUT" | \
  # Double the new line before code
  perl -0pe 's/((^|\n\S)[^\n]*)\n\t([^*])/\1\n\n\t\3/g;' | \
  perl -0pe '
    # begining of line
    $bol = "(?:^|\\n)";
    # Pillar is a line starting at bof
    $pillar = "(?:(?:$bol)\\S[^\\n]*|\$)" ;
    # Chrimp start of line 
    sub chin {
      my $r = $2;
      $r =~ s/\n\t/\n/g ;
      return $r;
    };
    # delete the start of line (\t) for list items
    s/($pillar)\n\t\*(.*?)(?=$pillar)/$1 . "\n\n*" . chin($2)/ges
  ' | \
  # Remove void lines
  perl -lpe 's/^\s*$//' | \

  tee test2.md | \
  # Compile
	pandoc $MATH -s -f $SYNTAX -t html -c $CSSFILENAME | \
	sed -r 's/<li>(.*)\[ \]/<li class="todo done0">\1/g; s/<li>(.*)\[X\]/<li class="todo done4">\1/g' \
	>"$OUTPUT.html"
}

mtermux(){
sed -r 's/(\[.+\])\(([^)]+)\)/\1(\2.html)/g' <"$INPUT" | \
	python -m markdown | \
	sed -r 's/<li>(.*)\[ \]/<li class="todo done0">\1/g; s/<li>(.*)\[X\]/<li class="todo done4">\1/g' >"$OUTPUT.html"



	# pandoc $MATH -s -f $SYNTAX -t html -c $CSSFILENAME | \
}

mchoose(){

# Choose which compiler : in termux no pandoc yet
# Better no to compile on termux
tmp=$(uname -a)

shopt -s nocasematch
if [[ "$tmp" =~ "android" ]] ; then
	mtermux
else
	munix
fi
}

mchoose
