# GUI : NVIDIA X server settings

* `nvidia-smi` : system management interface
* `nvidia-smi --query-gpu=driver_version --format=csv,noheader`
* `modinfo nvidia | grep version`
* `lspci -k | grep -A 2 -i "VGA"`
* `lspci -vnn`  # Will be with 'driver in use'
* `lshw -numeric -C display`
* `nvidia-settings -q all`
* `systemctl` # list many open/boot services
* `cat /proc/driver/nvidia/version`
* `cat /proc/driver/nvidia/gpus/0/info`
* `cat /proc/cpuinfo`

# Install

* `sudo lshw -c display`: Check
* `sudo ubuntu-drivers devices`: See if ubuntu can help
* `sudo ubuntu-drivers autoinstall` if seems good

# Important files

* `/etc/X11/xorg.conf[.d]`
* `/usr/share/X11/xorg.conf.d`
* `/etc/modules`  # modules à charger au démarage


# Ubuntu

* `gpu-manager`


# Log files

cat /var/log/lightdm
cat /var/log/Xorg.0.log
cat /var/log/gpu-manager.log
