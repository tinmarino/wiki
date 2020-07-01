
## Tips

* If cannot connect to host, enusre no sudo problem: https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo
* For alma, ensure the env.sh is well loaded otherwise, docker-compose won't be ble to work

## Docker vs chroot

* __mnt__ namespace provides a root filesystem (this one can be compared to chroot I guess)
* __pid__ namespace so the process only sees itself and its children
* __network__ namespace which allows the container to have its dedicated network stack
* __user__ namespace (quite new) which allows a non root user on a host to be mapped with the root user within the container
* __uts__ provides dedicated hostname
* __ipc__ provides dedicated shared memory
* There are also cgroups (for cpu and memory limits), reduced capabilities, seccomp, selinux/apparmor, and ulimits. The filesystem is also layered, potentially read only, and allowed to be overlaid with volume mounts. 
* 


## Command

* __Copy:__ `docker cp foo.txt mycontainer:/foo.txt`
* __List:__ `docker ps -a`

### Run

* -i : read from stdin
* -t : prompt to terminal
* -e VAR=value : set an environment variable before invoking the command
* -d : run in detached mode
* --name=toto : set the name of container to toto


## Location

* var/lib/docker
  * containers
  * image
  * volume
