```bash
# Quickstart
sudo airmon-ng start wlan0
sudo airodump-ng --band abg wlan0mon
 
# Bruteforce Hidden ESSID => Extended Service Set Identifier, BSSID: Basic Service Set Identifier.
sudo airodump-ng wlan0mon -c 11
sudo mdk4 wlan0mon p -t F0:9F:C2:6A:88:26 -f rockyouwifi.txt
 
# Monitor
sudo ip link set wlan0 down
sudo iw wlan0 set monitor control
sudo ip link set wlan0 up
 
# Managed
sudo ip link set wlan0 down
sudo iw wlan0 set type managed
sudo ip link set wlan0 up
 
# Monitor 1
sudo ip link set wlan0 down
sudo iw dev wlan0 set monitor none
sudo ip link set wlan0 up
 
 
sudo iw dev wlan0 set channel 13
sudo aireplay-ng --test wlan0
sudo iw list | less
sudo iw reg get
```
 
# Previous
sudo airmon-ng # Mostrar interfaces disponibles
sudo airmon-ng start <interfaz>
sudo airmon-ng check kill
 
Luego,
sudo airodump-ng <interfaz> --band ab
sudo airodump-ng <interfaz> --band g
 
Si funciona los bssid (mac) de un AP y cliente (en lo posible que sean nuestros xD):
 
Si hasta este paso va todo bien, excelente! Sino, ya sabes drivers o no nos sirve :c
 
Continuando:
sudo aireplay-ng <interfaz> -0 10 -a <AP>  -c <cliente>
 
En este paso podemos obtener diversos errores, como de channel invalido o (inserte error) el cual nos indica que no podemos realizar este tipo de ataques.
 
Para el primero, hay varias soluciones, la primera usar el parametro channel para indicarlo y dejarlo fijo:
 
sudo airodump-ng <interfaz> --band <abg> --channel <>
 
Otra alternativa es realizarlo manual:
sudo ifconfig <interfaz> down
sudo ifconfig <interfaz>
 
# TODO Refactor a little
