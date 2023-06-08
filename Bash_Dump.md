# Fast
```bash

# Print binary data
local escaped='' i=0 num=0
if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  escaped="$(printf "%s" "$1" | sed 's/\([0-9A-F]\{2\}\)/\\x\1/gI')"
else  # Including POSIX sh, not printf "\x41" allowed, So go octal
  while [ "$i" -lt "${#1}" ]; do
    local num=$((0x$(printf "%s" "$1" | cut -c$(( i+1 ))-$(( i+2 )))))
    escaped="$escaped\\$(printf "%o" "$num")"
    i=$(( i+2 ))
  done
fi
    
  # shellcheck disable=SC2059  # Don't use variables in the p...t string
  printf "$escaped"
printf "%s" "$1" | cut -c$(( i+1 ))-$(( i+2 )))
#echo /lib64/ld-linux-x86-64.so.2 <(base64 -d <<< "$bin_encoded")


syscall_memfd_create2(){
  perl -e "
    require qw/syscall.ph/;
    my \$fn = \"memfd\";
    print(
      syscall(SYS_memfd_create(), \$fn, 0)
    );
  "
}

```

# Harvest pipe fork output stream from child

```bash
produce() {
  echo; echo "ll in produce => $$ + $BASHPID"; ls -l --color /proc/$$/fd/; echo
  echo "ba ba ba   baanannna" "more    space" d e
  echo -e "to42\nto42_bis" >&42
  sleep 1
  echo produce OK
}

# Tuto from sO
# start a background pipeline with two processes running forever
tail -f /dev/null | tail -f /dev/null &
# save the process ids
PID2=$!
PID1=$(jobs -p %+)
# hijack the pipe's file descriptors using procfs
# 42 for Write
exec 42>/proc/$PID1/fd/1
# 43 for Read
exec 43</proc/$PID2/fd/0
# kill the background processes we no longer need
# (using disown suppresses the 'Terminated' message)
disown $PID2
kill $PID1 $PID2

# Fork stuff
exec {fd1}< <(produce)

# So can close 42
exec 42>&-

# Sleep for test
echo; echo "ll many stream => $$ + $BASHPID"; ls -l --color /proc/$$/fd/; echo

# Wait
echo stdout1; cat <&"$fd1"

# Close stdout fd
exec {fd1}>&-

echo mystream; cat <&43

# So can close 43
exec 43>&-

echo ; echo nothing left ?; ls -l --color /proc/$$/fd/

exit
```


# Dirty pipe test

```bash

# TODO dirty dump

# Duplicate stdout
exec {fd}>&1

# Start consuming in background from fd
sed "s/[0-9]\+/\x1b[31m&\x1b[0m/" <&"$fd" &

exec 3> >(tee configure.log) 2>&1
echo "configure" >&3

exec 4> >(tee make.log) 2>&1
echo "make" >&4

exec 5> >(tee make_test.log) 2>&1
echo "make test" >&5

exec 1>&5-


```

