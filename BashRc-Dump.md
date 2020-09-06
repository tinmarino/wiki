# Bashrc stuff I stopped using, in case (alias Backup)


```sh


# Profiling, Helper to profile, very very slow
  # https://stackoverflow.com/questions/5014823/how-to-profile-a-bash-shell-script-slow-startup
  exec 3>&2 2> >( tee /tmp/bash-$$.log |
                    sed -u 's/^.*$/now/' |
                    date -f - +%s.%N >/tmp/bash-$$.tim)
  set -x



# Works super bad => Better instal bash_completion as sudo
complete -cf sudo

# Languages
# Perl
export PERL5LIB="$PERL5LIB:$HOME/Program/Perl/Lib/lib/perl5/x86_64-linux-gnu-thread-multi"
export PERL5LIB="$PERL5LIB:$HOME/Software/Perl/Lib:$HOME/Program/Komodo/Komodo-PerlRemoteDebugging-8.0.2-78971-linux-x86_64"
export PERL5DB="BEGIN { require q($PERL5LIB/perl5db.pl)}"
export PERLDB_OPTS="RemotePort=localhost:9000"
export DBGP_IDEKEY="whatever"

# Git
# Removed: because I need different commiters, not only Tinmarino but also mtourneb
# and the env variable override the other
# Android
if [ "$os" = "termux" ] ; then
  export GIT_AUTHOR_NAME=tinmux
  export GIT_AUTHOR_EMAIL=tin@ter.mux
# Windows
elif [ "$os" = "windows" ] ; then
  export GIT_AUTHOR_NAME=tinwin
  export GIT_AUTHOR_EMAIL=tin@win.dows
# Linux
else
  if [ "$USER" = "tourneboeuf" ] ; then
    export GIT_AUTHOR_NAME=Tinmarino
    export GIT_AUTHOR_EMAIL=tinmarino@gmail.com
  elif [ "$USER" = "almamgr" ] ; then
    export GIT_AUTHOR_NAME=tinhat
    export GIT_AUTHOR_EMAIL=tin@red.hat
  else
    export GIT_AUTHOR_NAME=$USER
    export GIT_AUTHOR_EMAIL=$USER@his.pc
  fi
fi
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
```


