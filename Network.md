# Protocol layers

1. Physical : cable
2. Link : MAC data
3. Network : IP
4. Transport : TCP | UDP
5. Session
6. Presentation
7. Application


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
