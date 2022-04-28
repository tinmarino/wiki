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

# Make fast (tk Wawito)
export MAKE_PARS='-j 28 '; export LC_CTYPE=en_US.UTF-8; export MAKE_NOSTATIC=yes; export MAKE_NOIFR_CHECK=on;
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
  local i
  local fstg="%1s/ %20s %20s %20s\n"
  >&2 printf "$fstg" "" Function File Line
  for i in "${!FUNCNAME[@]}"; do
    >&2 printf "$fstg" "$i" "${FUNCNAME[$i]}" "${BASH_SOURCE[$i]}" "${BASH_LINENO[$i]}"
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
```

