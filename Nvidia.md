GUI : NVIDIA X server settings

* `nvidia-smi` : system management interface
* `nvidia-smi --query-gpu=driver_version --format=csv,noheader`
* `modinfo nvidia | grep version`
* `lspci -k | grep -A 2 -i "VGA"`
* `nvidia-settings -q all`
