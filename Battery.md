[Battery script example 1](Battery-script-example-1.md)

```bash
for ((i=4;i<16;i++)); do echo 0 | sudo dd of=/sys/devices/system/cpu/cpu$i/online; done
for ((i=0;i<16;i++)); do echo 1 | sudo dd of=/sys/devices/system/cpu/cpu$i/online; done
tail -n +1 /sys/devices/system/cpu/cpu*/online

for i in 0..16; do sudo cpufreq-set -c $i -g powersave; done
cpufreq-info | sed 's/current CPU frequency.*/\x1b[31m&\x1b[0m/'

sudo cpupower frequency-set -g powersave -d 0.8G -u 1.2G

# Screen brigthness
echo 30 | sudo dd of=/sys/class/backlight/amdgpu_bl0/brightness
cat /sys/class/backlight/amdgpu_bl0/brightness

# Sound
echo 1 | sudo dd of=/sys/module/snd_hda_intel/parameters/power_save
cat /sys/module/snd_hda_intel/parameters/power_save

# Monitor power consumption
cat /sys/class/power_supply/BAT0/power_now | awk '{print $0 / 10^6 " W"}'
cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT0/power_now | awk '{print $0 / 10^6}'
find /sys/class/power_supply/BAT0/ -type f -readable | xargs tail -n +1

# Disable boost
echo 0 | sudo dd of=/sys/devices/system/cpu/cpufreq/boost
sudo tlp-stat -p

powertop

sudo cpulimit --limit 20 /snap/firefox/2356/usr/lib/firefox/firefox

# Charge only until 60%
echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004\:00/conservation_mode 
cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004\:00/conservation_mode

```

# TPD: Tandberg Linux Package

```bash
sudo tlp-stat
sudo tlp-stat -b
sudo systemctl restart tlp

# See all scaling modes: conservative ondemand userspace powersave performance schedutil
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors


# Sound
echo 0 | sudo dd of=/sys/module/snd_hda_intel/parameters/power_save
echo Y | sudo dd of=/sys/module/snd_hda_intel/parameters/power_save_controller
lsof /dev/snd/*



```

In file /etc/tlp.conf

START_CHARGE_THRESH_BAT0=60
STOP_CHARGE_THRESH_BAT0=90
DEVICES_TO_DISABLE_ON_LAN_CONNECT="wifi"
