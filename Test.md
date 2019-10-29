zeazeaz 
even more modifyed, testing igt
zea
Still working, must change for html

[True test2](/home2/tourneboeuf/Test/test2.md)

# Contents

  - [Test1](#Test1)
  - [Test2](#Test2)
  - [Test3](#Test3)

# Test1

  - [Test1](#Test1)
  - [Test2](#Test2)
  - [Test3](#Test3)

# Test2

  - [Test1](#Test1)
  - [Test2](#Test2)
  - [Test3](#Test3)

# Test3

  - [Math](Math)
  - [This is a diary test](diary/2019-02-10)

* [Self](Test)

# Array test

| 1               | 2 |
| -               | - |
| [Test1](#Test1) | [Test2](#Test2) |


# Languages

((( ( (here $1 is matched for  [[name]]) ) ))) 

{{{python
   for i in range(10):
       print("hello world")
}}}

```sh
  echo "totot"
  cat this is > bash 

```


```python
class toto:
		def __init__(self):
				self.a = 3
				print("I am initiated")
```

```perl
sub titi {
  if 
}

```

```class="brush: python"
for i in range(1, 5):
   print(i)
```

```class="brush: cpp"
#include "helloworld.h"
int helloworld()
{
  printf("hello world");
}
```

or in: >
```cpp
#include "helloworld.h"
int helloworld()
{
  printf("hello world");
}
```

```python
for i in range(1, 5):
   print(i)
```

def 

Consider the following example: >
 = Toggleable list of todo items =
  * [ ] Toggle list item on/off.
     * [ ] Simple toggling between [ ] and [X].
     * [ ] All list's subitems should be toggled on/off appropriately.
     * [ ] Toggle child subitems only if current line is list item
     * [ ] Parent list item should be toggled depending on it's child items.
   * [ ] Make numbered list items toggleable too
   * [ ] Add highlighting to list item boxes
   * [ ] Add [ ] to the next list item created with o, O and <CR>.


This sould be followed by code  
	
	Here is the code
	and yes 
	this shoudl be co
	de
	
This is a table

| Name      |  Size |    Cost |
|-----------+------:+--------:|
| Africans  |    22 |      31 |
| Normandie |    33 | 2066.55 |
| Nord      |    84 |      33 |
| Total     | 117.0 |    2099 |
%% tmf: $4,2=Sum(2:-1) ; $4,3=float2nr(Sum(2:-1))

From CSV 

| Name    | Pay1 | Pay2 |
|---------+-----:+-----:|
| Frinde1 |  221 |   33 |
| Frinde2 |   22 |   33 |
| Frinde3 |   22 |   33 |


aza azeazea 

```sh
if [[ $TERM = *[xeEk]term* ||
      $TERM = *mlterm* ||
      $TERM = *rxvt* ||
      $TERM = *screen* ||
      ($TERM = *linux* && -S /dev/gpmctl)
   ]]; then

  set-status() { return $1; }

  handle-mouse-event() {
    emulate -L zsh
    local bt=$1

    case $bt in
      3)
	return 0;; # Process on press, discard release
	# mlterm sends 3 on mouse-wheel-up but also on every button
	# release, so it's unusable
      64)
	# eterm, rxvt, gnome/KDE terminal mouse wheel
	zle up-line-or-history
	return;;
      4|65)
	# mlterm or eterm, rxvt, gnome/KDE terminal mouse wheel
	zle down-line-or-history
	return;;
    esac
    local mx=$2 my=$3 last_status=$4
    local cx cy i
    setopt extendedglob

    print -n '\e[6n' # query cursor position

    local match mbegin mend buf=

		while ( read -k i && buf+=$i && [[ $buf != "*\[([0-9]##)\;[0-9]##R" ]] ) ; do :; done
    # read response from terminal.
    # note that we may also get a mouse tracking btn-release event,
    # which would then be discarded.

    [[ $buf = "(#b)*\[([0-9]##)\;[0-9]##R" ]] || return
    cy=$match[1] # we don't need cx

    local cur_prompt

    # trying to guess the current prompt
    case $CONTEXT in
      (vared)
        if [[ $0 = zcalc ]]; then
	  cur_prompt=${ZCALCPROMPT-'%1v> '}
	  setopt nopromptsubst nopromptbang promptpercent
	  # (ZCALCPROMPT is expanded with (%))
	fi;;
	# if vared is passed a prompt, we're lost
      (select)
        cur_prompt=$PS3;;
      (cont)
	cur_prompt=$PS2;;
      (start)
	cur_prompt=$PS1;;
    esac

    # if promptsubst, then we need first to do the expansions (to
    # be able to remove the visual effects) and disable further
    # expansions
    [[ -o promptsubst ]] && cur_prompt=${${(e)cur_prompt}//(#b)([\\\$\`])/\\$match}

    # restore the exit status in case $PS<n> relies on it
    set-status $last_status

    # remove the visual effects and do the prompt expansion
    cur_prompt=${(S%%)cur_prompt//(#b)(%([BSUbsu]|{*%})|(%[^BSUbsu{}]))/$match[3]}

    # we're now looping over the whole editing buffer (plus the last
    # line of the prompt) to compute the (x,y) position of each char. We
    # store the characters i for which x(i) <= mx < x(i+1) for every
    # value of y in the pos array. We also get the Y(CURSOR), so that at
    # the end, we're able to say which pos element is the right one
    
    local -a pos # array holding the possible positions of
		 # the mouse pointer
    local -i n x=0 y=1 cursor=$((${#cur_prompt}+$CURSOR+1))
    local Y

    buf=$cur_prompt$BUFFER
    for ((i=1; i<=$#buf; i++)); do
      (( i == cursor )) && Y=$y
      n=0
      case $buf[i] in
	($'\n') # newline
	  : ${pos[y]=$i}
	  (( y++, x=0 ));;
	($'\t') # tab advance til next tab stop
	  (( x = x/8*8+8 ));;
	([$'\0'-$'\037'$'\200'-$'\237'])
	  # characters like ^M
	  n=2;;
	(*)
	  n=1;;
      esac
      while
	(( x >= mx )) && : ${pos[y]=$i}
	(( x >= COLUMNS )) && (( x=0, y++ ))
	(( n > 0 ))
      do
	(( x++, n-- ))
      done
    done
    : ${pos[y]=$i} ${Y:=$y}

    local mouse_CURSOR
    if ((my + Y - cy > y)); then
      mouse_CURSOR=$#BUFFER
    elif ((my + Y - cy < 1)); then
      mouse_CURSOR=0
    else
      mouse_CURSOR=$(($pos[my + Y - cy] - ${#cur_prompt} - 1))
    fi

    case $bt in
      (0)
	# Button 1.  Move cursor.
	CURSOR=$mouse_CURSOR
      ;;

      (1)
	# Button 2.  Insert selection at mouse cursor postion.
	get-x-clipboard
	BUFFER=$BUFFER[1,mouse_CURSOR]$CUTBUFFER$BUFFER[mouse_CURSOR+1,-1]
	(( CURSOR = $mouse_CURSOR + $#CUTBUFFER ))
      ;;

      (2)
	# Button 3.  Copy from cursor to mouse to cutbuffer.
	killring=("$CUTBUFFER" "${(@)killring[1,-2]}")
	if (( mouse_CURSOR < CURSOR )); then
	  CUTBUFFER=$BUFFER[mouse_CURSOR+1,CURSOR+1]
	else
	  CUTBUFFER=$BUFFER[CURSOR+1,mouse_CURSOR+1]
	fi
	set-x-clipboard $CUTBUFFER
      ;;
    esac
  }
  
  zle -N handle-mouse-event

  handle-xterm-mouse-event() {
    local last_status=$?
    emulate -L zsh
    local bt mx my
    
    # either xterm mouse tracking or bound xterm event
    # read the event from the terminal
    read -k bt # mouse button, x, y reported after \e[M
    bt=$((#bt & 0x47))
    read -k mx
    read -k my
    if [[ $mx = $'\030' ]]; then
      # assume event is \E[M<btn>dired-button()(^X\EG<x><y>)
      read -k mx
      read -k mx
      read -k my
      (( my = #my - 31 ))
      (( mx = #mx - 31 ))
    else
      # that's a VT200 mouse tracking event
      (( my = #my - 32 ))
      (( mx = #mx - 32 ))
    fi
    handle-mouse-event $bt $mx $my $last_status
  }

  zle -N handle-xterm-mouse-event

  if [[ $TERM = *linux* && -S /dev/gpmctl ]]; then
    # GPM mouse support
    if zmodload -i zsh/net/socket; then

      zle-update-mouse-driver() {
	if [[ -n $ZLE_USE_MOUSE ]]; then
	  if (( ! $+ZSH_GPM_FD )); then
	    if zsocket -d 9 /dev/gpmctl; then
	      ZSH_GPM_FD=$REPLY
	      # gpm initialisation:
	      # request single click events with given modifiers
	      local -A modifiers
	      modifiers=(
	        none        0
		shift       1
		altgr       2
		ctrl        4
		alt         8
		left-shift  16
		right-shift 32
		left-ctrl   64
		right-ctrl  128
		caps-shift  256
	      )
	      local min max
	      # modifiers that need to be on
	      min=$((modifiers[none]))
	      # modifiers that may be on
	      max=$min

	      # send 16 bytes:
	      #   1-2: LE short: requested events (btn down = 0x0004)
	      #   3-4: LE short: event passed through (~GPM_HARD=0xFEFF)
	      #   5-6: LE short: min modifiers
	      #   7-8: LE short: max modifiers
	      #  9-12: LE int: pid
	      # 13-16: LE int: virtual console number

	      print -u$ZSH_GPM_FD -n "\4\0\377\376\\$(([##8]min&255
	      ))\\$(([##8]min>>8))\\$(([##8]max&255))\\$(([##8]max>>8
	      ))\\$(([##8]$$&255))\\$(([##8]$$>>8&255))\\$((
	      [##8]$$>>16&255))\\$(( [##8]$$>>24))\\$((
	      [##8]${TTY#/dev/tty}))\0\0\0"
	      zle -F $ZSH_GPM_FD handle-gpm-mouse-event
            else
	      zle-error 'Error: unable to connect to GPM'
	      ZLE_USE_MOUSE=
	    fi
	  fi
	else
	  # ZLE_USE_MOUSE disabled, close GPM connection
	  if (( $+ZSH_GPM_FD )); then
	    eval "exec $ZSH_GPM_FD>&-"
	    # what if $ZSH_GPM_FD > 9 ?
	    zle -F $ZSH_GPM_FD # remove the handler
	    unset ZSH_GPM_FD
	  fi
	fi
      }

      handle-gpm-mouse-event() {
	local last_status=$?
	local event i
	if read -u$1 -k28 event; then
	  local buttons x y
	  (( buttons = ##$event[1] ))
	  (( x = ##$event[9] + ##$event[10] << 8 ))
	  (( y = ##$event[11] + ##$event[12] << 8 ))
	  zle handle-mouse-event $(( (5 - (buttons & -buttons)) / 2 )) $x $y $last_status
	  zle -R # redraw buffer
	else
	  zle -M 'Error: connection to GPM lost'
	  ZLE_USE_MOUSE=
	  zle-update-mouse-driver
	fi
      }
    fi 
  else
    # xterm-like mouse support
    zmodload -i zsh/parameter # needed for $functions

    zle-update-mouse-driver() {
      if [[ -n $WIDGET ]]; then
	if [[ -n $ZLE_USE_MOUSE ]]; then
	  print -n '\e[?1000h'
	else
	  print -n '\e[?1000l'
	fi
      fi
    }

    if [[ $functions[precmd] != *ZLE_USE_MOUSE* ]]; then
      functions[precmd]+='
      [[ -n $ZLE_USE_MOUSE ]] && print -n '\''\e[?1000h'\'
    fi
    if [[ $functions[preexec] != *ZLE_USE_MOUSE* ]]; then
      functions[preexec]+='
      [[ -n $ZLE_USE_MOUSE ]] && print -n '\''\e[?1000l'\'
    fi

    bindkey -M emacs '\e[M' handle-xterm-mouse-event
    bindkey -M viins '\e[M' handle-xterm-mouse-event
    bindkey -M vicmd '\e[M' handle-xterm-mouse-event

    if [[ $TERM = *Eterm* ]]; then
      # Eterm sends \e[5Mxxxxx on drag events, be want to discard them
      discard-mouse-drag() {
        local junk
        read -k5 junk
      }
      zle -N discard-mouse-drag
      bindkey -M emacs '\e[5M' discard-mouse-drag
      bindkey -M viins '\e[5M' discard-mouse-drag
      bindkey -M vicmd '\e[5M' discard-mouse-drag
    fi
  fi

fi
```

