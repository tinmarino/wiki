

# Démarage:

* Execute le code @F000:FFF0. Cette addresse haute représente la ROM
* Test l'architecture
* Install une table d'interuption dans les 1024 premiers octets
* Intall une zome de données BIOS just après, c'est à dire @0040:0000
* Changement de stockage (RAM -> DD) : le BISO cherche à lire le premier sectuer (piste 0, ête 0, secteur 1) d'une diskette et le copie vers 0000:7C00
* Si le secteur se termine par 0x55AA, le BISO met l'IP à 0000:7C00
* Ce secteur mesure 512 octet, il charge le reste du BIOS et lui donne le contrôle

Les 3 premiers fichiers :

1. Command.com
2. IO.sys
3. MsDos.sys


