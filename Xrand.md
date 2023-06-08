```bash
# Displaying the Attached Monitors
xrandr --listmonitors

# Displaying Information About the Monitors
xrandr -q

# Setting a Monitor to Receive an Output
xrandr --output DVI-D-O --mode 1024x768


# Xrandr Setting Monitor Refresh Rate
# -- use the --rate flag
xrandr --output XWAYLAND0 --mode 2560x1600 --rate 60.00

# Adjusting the Monitor’s Brightness
randr --output LVDS-1 --brightness 0.5

# Changing the Position of the Monitor Display
xrandr --output DVI-D-0 --right-of HDM1-1


# Mirroiring: Setting the Same Display Screen
xrandr --output DVI-D-0 –same-as HDMI-1
```
