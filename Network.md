# OSI Protocol layers

| N | Name         | Ex    | Description |
| - | ---          | ---   | --- |
| 7 | Application  | HTTP  | Ensure app are working |
| 6 | Presentation | TLS   | Crypt and Compress |
| 5 | Session      | TLS   | Open and close communcations: sessions and ports |
| 4 | Transport    | TCP   | Transmit data: segments |
| 3 | Network      | IP    | Decide the physical path: packet, routes: VLAN |
| 2 | Link         | MAC   | Define the format of data into frames: switch, brigdes, VRF |
| 1 | Physical     | cable | Transmit Raw bytes |


# Unbound : DNS server

## Unbound files
* `/etc/hosts`
* `/etc/hostname`
* `/etc/resolv.conf` : fastly write : `nameserver 127.0.0.1`
* `/etc/network/interfaces`

## Unbound test

* `route add default gw 80.81.82.22`
* `unbound-checkconf /etc/unbound/unbound.conf`

## Unbound | Dns cache

* systemd-resolve --flush-caches
* unbound-control flush_zone google.com

# Nginx : proxy

## Nginx debug
* `sudo /etc/init.d/apache2 stop` if impossible to bind to 443 or 80
