

sudo apt-get remove --purge alsa-base pulseaudio
sudo apt-get install alsa-base pulseaudio

pactl info
pw-cli info all
systemctl --user list-units | grep -E 'pulseaudio|pipewire'
