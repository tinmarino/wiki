
gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor true

# Path

* /etc/systemd/logind.conf
* /etc/security/limits.conf

# Ubuntu cannot run `su` by default

sudo su - root
sudo -i

# Sortcut

* Super + Q : Show number of window app in dock (left launcher)
* Alt + f2 : Run command
* OS + (~ or tick) : Change window of same program (Friefox or terminal)
* Invert fn behavior: Press fn + Esc Key (Or look for a key with a lock sign on it)


# Mouse

modprobe -r psmouse

# Restart

* DISPLAY=:0 gnome-shell [replace](--replace)
* alt f2 + r  or `restart`


# Power management : suspend then hibernate

* `systemctl suspend-then-hibernate` # test
* `dconf-editor` : /org/gnome/settings-daemon/plugins/power/
* `sudoedit /etc/UPower/UPower.conf`
* `service upower restart`
* In `/etc/systemd/sleep.conf` new file:
  ```
  [Sleep]
  HibernateDelaySec=3600
  ```
* In `/etc/systemd/logind.conf`
  ```
  HandleLidSwitch=suspend-then-hibernate
  ```
* `systemctl restart systemd-logind.service`
* `gconftool-2 -t string -s /apps/gnome-power-manager/buttons/lid_ac nothing` # Nothing on battery


## Power : stop sleeping

* `sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target` # Disable
* `sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target` # Enable
* Add the kernel options acpi=off apm=off to the contents of GRUB_CMDLINE_LINUX_DEFAULT in file /etc/default/grub.  Then run sudo update-grub 
