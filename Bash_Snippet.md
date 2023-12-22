# TODO

```bash
# print dict
for key in "${!gd_from_file[@]}"; do
  echo "Tin: $key=${gd_from_file[$key]}"
done

```

# Lines
```bash
# Print pretty list of BaSh builtins, to go further, use "man bash"
help

# List command in scope with "corr" in their name
compgen -c | grep -i corr

# Print PATH environment variable, one folder per line (instead of ':')
echo "${PATH//:/$'\n'}"

# Find big files
find / -size +500M

# Show 10 most used commands
history | awk '{print $2}' | awk 'BEGIN {FS="|"}{print $1}' | sort | uniq -c | sort -n | tail | sort -nr
history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
 
# Show all accessible machines
ifconfig -a | grep -Po '\b(?!255)(?:\d{1,3}\.){3}(?!255)\d{1,3}\b' | xargs nmap -A -p0-

# Show largest open file
lsof / | awk '{ if($7 > 1048576) print $7/1048576 "MB" " " $9 " " $1 }' | sort -n -u | tail

# Make fast (tk Wawito)
export MAKE_PARS='-j 28 '; export LC_CTYPE=en_US.UTF-8; export MAKE_NOSTATIC=yes; export MAKE_NOIFR_CHECK=on

# Have a decent git log
git log --all --graph --decorate --color=always --abbrev=7 --format='%C(auto)%h %an %C(blue)%s %C(yellow)%cr' | head -n $((LINES-20))
 
# Check if running in terminal (interactive) or script: from https://serverfault.com/questions/146745
[[ $- == *i* ]] && [[ -v PS1 ]]; echo $? 
```


# Alma

```bash
# Display log filesystem hierarchy
find /alma/logs/ -type d | sort

# Show database locations
grep -H archive.tmcdb.connection /alma/ACS-*/acsdata/config/archiveConfig.properties

# Solve many X problem, see ICT-14858 (tk Javarias)
export DBUS_SESSION_BUS_ADDRESS=$(dbus-launch --autolaunch=$(dbus-uuidgen) --binary-syntax --close-stderr)

# Welcome to the data / code
vim $ACSDATA/config/archiveConfig.properties  # ACSDATA=/alma/ACS-current/acsdata
source $ACSROOT/config/.acs/.bash_profile.acs  # ACSROOT=/alma/ACS-current/ACSSW

# Check if hosts are alive
for h in $(getHosts); do ping -c 1 "$h" > /dev/null && echo "OK: $h" || echo "ERROR: $h"; done

# Synchronize extprod
RELEASE=2021JAN; rsync -av --exclude='acsdata*' --exclude='ACSSW*' root@v-bfnode702.sco.alma.cl:/alma/ACS-$RELEASE/ /alma/ACS-$RELEASE/

# Display top process of all hosts
for h in localhost $(getHosts); do
  echo -e "\e[31m$h\e[0m"
  filter="8,10s/((\s*\S+){8})(\s+\S+)/\1\x1b[31m\3\x1b[0m/p"
  [[ "$h" == "localhost" ]] && filter="7s/.*/\x1b[31m\0\x1b[0m/p; $filter"
  timeout 1 ssh $h "top -b -n 1 | sed -rn '$filter'"
done

foreach_gas(){
  ### Execute argument code on all GAS computers
  for h in $(getHosts | grep gas); do
    echo -e "\n=====================================================\n$h"
    ssh "$h" "$@"
  done
}
 
test_foreach_gas(){
  foreach_gas echo \$HOSTNAME \; top -b -n 1 \| head -n 12  \| tail -n 5
}

is_alma(){
  ### Check if current computer is an Alma STE
  local fp_sitename=/alma/ste/etc/sitename
  [[ -f "$fp_sitename" ]] || return 1
  export SITENAME=$(<"$fp_sitename")
  case $SITENAME in
    ACSE*) return 0 ;;
    APE*) return 0 ;;
    TFINT) return 0 ;;
    *) return 1 ;;
  esac
}
 
test_is_alma(){
  is_alma; (( B_IS_ALMA = ! $? )); export B_IS_ALMA
}
```


# One line

```
printf -v timestamp '%(%Y-%m-%dT%H:%M:%S)T'
local timestamp=$(date '+%Y-%m-%dT%H:%M:%S.%3N')
```


# Function

```bash
# Get random element
randArrayElement(){ a=("$@"); echo ${a["$[RANDOM % ${#@}]"]}; };

is_in_array(){
  ### Check if arg1 <string> is in rest of args
  ### Ref: https://stackoverflow.com/a/8574392/2544873
  local element match="$1"; shift
  for element; do [[ "$element" == "$match" ]] && return 0; done
  return 1
}
 
test_is_in_array(){ 
  is_in_array 42 1 3 42 6; echo $?
}

print_args(){
  ### Print argument received with their positional number, for teaching purposes'
  local i_cnt=1
  for s_arg in "$@"; do
    echo "$(( i_cnt++ ))/ $s_arg"
  done
}
 
test_print_args(){
 print_args arg1 "arg with spaces" "${a_arg[@]}" "$not_existing_scalar" arg_sep "${not_existing_array[@]}" end
}


print_stack(){
  ### Print current stack trace to stderr
  local -i i=0 j=0 k=0
  local fstg="%1s/ %s\t\t %15s %15s %15s\n"
  >&2 printf "$fstg" "-" Function File Line Arguments
  for i in "${!FUNCNAME[@]}"; do
    local -a a_argv=(); shopt -q extdebug && { local argc=${BASH_ARGC[i]}; for ((j=0; j<argc; j++)); do a_argv[$((argc-j))]=${BASH_ARGV[$((k++))]}; done; }
    >&2 printf "$fstg" "$i" "${FUNCNAME[$i]}" "${BASH_SOURCE[$i]}" "${BASH_LINENO[$i]}" "${a_argv[*]}"
  done
}
 
test_print_stack(){
  second(){ print_stack; }
  first(){ second; }
  first
}

pipe_one_line(){
  ### Pipe utilility: Only print stdout last line in one updating line (\r trick)'
  {
    local s_line
    tput rmam
    while read -r s_line; do
      printf "\r\e[K%s" "$line"
    done < "${1:-/dev/stdin}"
    tput smam
  }
}
 
test_pipe_one_line(){
  for i in {1..1000}; do echo $i; sleep 0.001; done | pipe_one_line
}

set_color_scheme(){
  ### Map color to nicer color scheme (rgb)
  printf '\e]10;rgb:c5/c8/c6\a'  # foreground
  printf '\e]11;rgb:1d/1f/21\a'  # background
  printf '\e]4;1;rgb:cc/66/66\a'  # red
  printf '\e]4;2;rgb:b5/bd/68\a'  # green
  printf '\e]4;3;rgb:f0/c6/74\a'  # yellow
  printf '\e]4;4;rgb:81/a2/be\a'  # blue
  printf '\e]4;5;rgb:b2/94/bb\a'  # magenta
  printf '\e]4;6;rgb:8a/be/b7\a'  # cyan
}

function teee(){
  ### Imitate tee command. Usage echo 42 | teee -a file1.txt file2.txt
  local a_file=(/dev/stdout) b_append=1 arg fp
  for arg; do [[ "$arg" == -a ]] && b_append=1 || a_file+=("$arg"); done
  (( b_append )) || : > "$1"
  while read -rn1 -d $'\0'; do
    (( ${#REPLY} == 0 )) && { for fp in "${a_file[@]}"; do printf '\0' >> "$fp"; done; continue; }
    for fp in "${a_file[@]}"; do echo -n "$REPLY" >> "$fp"; done
  done
}

print_multiplication_table(){
  for a in {1..15}; do
    for (( b=1; b<=15; b=b+1 )); do
      ((b >=a || b == 1)) && { printf "%4d" $((a*b)); } || { printf "    "; }
      continue || break  # here, break is never executed
    done; echo 
  done
}
```


# Fun

```bash
# https://10print.org: 10 PRINT CHR$(205.5+RND(1)); : GOTO 10
while :; do printf \\$(printf '%o' $[47+45*(RANDOM%2)]); done

# Show ascii table (better man ascii)
awk 'BEGIN {for (i = 32; i < 127; i++) printf "%3d 0x%02x %c\n", i, i, i}' | pr -t6 -w78

# OLD TV
P=(' ' █ ░ ▒ ▓);while :;do printf "\e[$[RANDOM%LINES+1];$[RANDOM%COLUMNS+1]f${P[$RANDOM%5]}";done
 
# Madelbrot
p=\>\>14 e=echo\ -ne\  S=(S H E L L) I=-16384 t=/tmp/m$$; for x in {1..13}; do \
R=-32768; for y in {1..80}; do B=0 r=0 s=0 j=0 i=0; while [ $((B++)) -lt 32 -a \
$(($s*$j)) -le 1073741824 ];do s=$(($r*$r$p)) j=$(($i*$i$p)) t=$(($s-$j+$R));
i=$(((($r*$i)$p-1)+$I)) r=$t;done;if [ $B -ge 32 ];then $e\ ;else #---::BruXy::-
$e"\E[01;$(((B+3)%8+30))m${S[$((C++%5))]}"; fi;R=$((R+512));done;#----:::(c):::-
$e "\E[m\E(\r\n";I=$((I+1311)); done|tee $t;head -n 12 $t| tac  #-----:2 O 1 O:-
 
# Matrix
(echo -e "\033[2J\033[?25l"; R=`tput lines` C=`tput cols`;: $[R--] ; while true
do ( e=echo\ -e s=sleep j=$[RANDOM%C] d=$[RANDOM%R];for i in `eval $e {1..$R}`;
do c=`printf '\\\\0%o' $[RANDOM%57+33]` ### http://bruxy.regnet.cz/web/linux ###
$e "\033[$[i-1];${j}H\033[32m$c\033[$i;${j}H\033[37m"$c; $s 0.1;if [ $i -ge $d ]
then $e "\033[$[i-d];${j}H ";fi;done;for i in `eval $e {$[i-d]..$R}`; #[mat!rix]
do echo -e "\033[$i;${j}f ";$s 0.1;done)& sleep 0.05;done) #(c) 2011 -- [ BruXy ]
 
# Just mosaic
for((y=0;y<$[LINES-1];y++));do for((x=0;x<=$COLUMNS;x++));do printf "\e[${y};${x}f\e[38;5;$[232+(x^y)%24]m\u2588";done;done

# Show Fractal: Sierpinski Triangle
for((y=63;y>0;y-=2));do s="";for((x=64;x--;));do(((x-y/2)&y))&&s+=" "||s+="Δ";done;echo "$s";done
```


# Music

```bash
# Beep
echo -e "\a"
 
# Beep more portable (see Advanced Linux Sound Architecture)
play -n synth 0.1 sine 880 vol 0.5
 
# Music from chaos
python3 -c "while 1:locals().setdefault('t',0);print(chr((((t*((ord('36364689'[t>>13&7])&15)))
//12&128)+(((t>>12)^(t>>12)-2)%11*t//4|t>>13)&127)),end='');t+=1" | aplay -r 44100
 
# ByteBeat: Music from fractal
# -- Wikipedia: https://en.wikipedia.org/wiki/Linear-feedback_shift_register
# -- Sound like this
for((t=0;;t++));do((n=(
t&t>>8
), d=n%255,a=d/64,r=(d%64),b=r/8,c=r%8));printf '%b' "\\$a$b$c";done|aplay
# -- Mistery trans by viznut (Ref: https://www.youtube.com/watch?v=qlrs2Vorw2Y&t=151s)
for((t=0;;t++));do((n=(
(t>>7|t|t>>6)*10+4*(t&t>>13|t>>6)
), d=n%255,a=d/64,r=(d%64),b=r/8,c=r%8));printf '%b' "\\$a$b$c";done| aplay
```
