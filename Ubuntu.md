# Power management : suspend then hibernate
  * In `/etc/systemd/sleep.conf` new file:
    ```
    [Sleep]
    HibernateDelaySec=3600
    ```
  * `systemctl suspend-then-hibernate` # test
  * In `/etc/systemd/logind.conf`
    ```
    HandleLidSwitch=suspend-then-hibernate
    ```
  * `systemctl restart systemd-logind.service`
