#!/usr/bin/env bash

# 1/ Grammar
############

variable(){  # Declaration and assignment
  declare    string="a b"; echo "$string"
  declare -i int=21; echo "$(( int * 2 ))"
  declare -a array=(a "b c"); for string in "${array[@]}"; do echo "$string"; done
  declare -A dict=([a]="b c" ["d e"]=f); for key in "${!dict[@]}"; do echo "$key: ${dict[$key]}"; done
}

condiction(){  # If statement
  if true; then
    echo as simple as that
  fi

  if (( 1 > 1)); then echo no
  elif [[ "$a" == toto ]]; then echo no
  elif true; then echo yes
  else echo no
  fi
}

loop(){  # For statement
  for string in a "b c"; do
    echo "$string"
  done

  while :; do echo "$((i++))"; done
}

func(){  # Function
  func(){
    for i; do echo "$((j++)): $i|"; done
  }
  
  func a "b c"
}

switch(){  # Switch statement is case
  while [[ "$#" -gt 0 ]]; do
    case $1 in
      --ant) antenna=$2; shift;;
      -v) verbose=1;;
      *) echo "unknown argument";;
    esac
    shift
  done
  echo "antenna:$antenna, verbose:$verbose"
}

redirection(){
  exec 3<> /tmp/file  # Open fd 3
  echo value >&3      # Write to fd
  cat <&3             # Read from fd 3
  exec 3>&-           # Close fd 3.
}

# 2/ Line
#########

# List command in scope with "corr" in their name
compgen -c | grep -i corr

# Print line separated PATH variable
echo "${PATH//:/$'\n'}"

# Slurp: read file to string
string=$(<file.txt)


# 3/ Advanced
#############

# Forking pipe generic
exec {fd}>&1
out=$(echo toto | tee "/dev/fd/$fd")  # or tee /dev/tty, or tee >(cat - >&{fd})
exec {fd}>&-
echo "$out"
