
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
