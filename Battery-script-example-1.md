if [ "$1" != "ac_adapter" ]
then
    sleep 4
fi

bat0=`cat /sys/devices/platform/smapi/BAT0/state`
bat1=`cat /sys/devices/platform/smapi/BAT1/state`
# List of modules to unload, space seperated. Edit depending on your hardware and preferences.
modlist="uvcvideo"
# Bus list for runtime pm. Probably shouldn't touch this.
buslist="usb i2c pci_express pci"


if [ $bat0 == discharging ] || [ $bat1 == discharging ]
then
       # Enable some power saving settings while on battery
       # Disable NMI watchdog
        echo 0 > /proc/sys/kernel/nmi_watchdog
       # Disable Wake-on-line
        ethtool -s enp0s25 wol d
       # Enable laptop mode
        echo 5 > /proc/sys/vm/laptop_mode
       # Less VM disk activity. Suggested by powertop
        echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
       # Intel power saving
        echo Y > /sys/module/snd_hda_intel/parameters/power_save_controller
        echo 1 > /sys/module/snd_hda_intel/parameters/power_save
       # Set backlight brightness to 20%
        echo 4 > /sys/class/backlight/acpi_video0/device/backlight/acpi_video0/brightness
       # USB powersaving
        for i in /sys/bus/usb/devices/*/power/autosuspend; do
            echo 1 > $i
        done
       # SATA power saving
        for i in /sys/class/scsi_host/host*/link_power_management_policy; do
            echo min_power > $i
        done
       # Disable hardware modules to save power
        for mod in $modlist; do
            grep $mod /proc/modules >/dev/null || continue
            modprobe -r $mod 2>/dev/null
        done
       # Enable runtime power management. Suggested by powertop.
        for bus in $buslist; do
            for i in /sys/bus/$bus/devices/*/power/control; do
                echo auto > $i
            done
        done
else
        #Return settings to default on AC power
        echo 1 > /proc/sys/kernel/nmi_watchdog
        echo 0 > /proc/sys/vm/laptop_mode
        echo 500 > /proc/sys/vm/dirty_writeback_centisecs
        echo Y > /sys/module/snd_hda_intel/parameters/power_save_controller
        echo 1 > /sys/module/snd_hda_intel/parameters/power_save
        echo 12 > /sys/class/backlight/acpi_video0/device/backlight/acpi_video0/brightness
        for i in /sys/bus/usb/devices/*/power/autosuspend; do
            echo 2 > $i
        done
        for i in /sys/class/scsi_host/host*/link_power_management_policy
            do echo max_performance > $i
        done
        for mod in $modlist; do
            if ! lsmod | grep $mod; then
                modprobe $mod 2>/dev/null
            fi
        done
        for bus in $buslist; do
            for i in /sys/bus/$bus/devices/*/power/control; do
                echo on > $i
            done
        done
