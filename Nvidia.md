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

# Smi

## SMi working

```text
Wed May 20 00:28:45 2020       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 440.64       Driver Version: 440.64       CUDA Version: 10.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 850M    Off  | 00000000:04:00.0 Off |                  N/A |
| N/A   57C    P0    N/A /  N/A |    183MiB /  4046MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|    0       964      G   /usr/lib/xorg/Xorg                           110MiB |
|    0      1353      G   /usr/bin/gnome-shell                          70MiB |
+-----------------------------------------------------------------------------+
```
