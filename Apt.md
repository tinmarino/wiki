
# Remove

* sudo apt-get clean
* sudo dpkg --configure -a
* sudo apt-get autoremove
* sudo apt-get upgrade && sudo apt-get -f install
* sudo dpkg --remove --force-remove-reinstreq package_name 
 
```
LC_MESSAGES=C dpkg-divert --list '*nvidia-340*' | sed -nre 's/^diversion of (.*) to .*/\1/p' | xargs -rd'\n' -n1 -- sudo dpkg-divert --remove
sudo apt --fix-broken install
```
