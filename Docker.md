# Quickstart

```bash
echo "from ubuntu:latest" > dockerfile_bash
docker build -t bash_image -f dockerfile_bash .
docker run -it --name=bash_container bash_image
docker restart bash_container
docker exec -it bash_container bash 
docker cp bash_test.sh bash_container:bash_test.sh

docker container ls -a
docker ps -a
```




## Tips

* If cannot connect to host, enusre no sudo problem: https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo
* For alma, ensure the env.sh is well loaded otherwise, docker-compose won't be ble to work


```bash
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
```

### Tip: Keep alive

From: https://stackoverflow.com/questions/29599632/container-is-not-running
```bash
docker pull debian

docker run -t -d --name my_debian debian
e7672d54b0c2

docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
e7672d54b0c2        debian              "bash"              3 minutes ago       Up 3 minutes                            my_debian

#now you can execute command on the container
docker exec -it my_debian bash
root@e7672d54b0c2:/# 
```

## Docker vs chroot

* __mnt__ namespace provides a root filesystem (this one can be compared to chroot I guess)
* __pid__ namespace so the process only sees itself and its children
* __network__ namespace which allows the container to have its dedicated network stack
* __user__ namespace (quite new) which allows a non root user on a host to be mapped with the root user within the container
* __uts__ provides dedicated hostname
* __ipc__ provides dedicated shared memory
* There are also cgroups (for cpu and memory limits), reduced capabilities, seccomp, selinux/apparmor, and ulimits. The filesystem is also layered, potentially read only, and allowed to be overlaid with volume mounts. 


## Tips

### Check is running
docker inspect returns a JSON object with a lot of info about the container, and in particular whether the container is currently running or not. The -f flag lets you easily extract the bits needed:

* `docker inspect -f "{{.State.Running}}" $CONTAINER_ID`
* `docker top`

## Command

* __Copy:__ `docker cp foo.txt mycontainer:/foo.txt`
* __List:__ `docker ps -a`

### Stop

```bash
docker stop $(docker ps -a -q)
```

### Run

From: https://docs.docker.com/engine/reference/commandline/run/

* -i : read from stdin
* -t : prompt to terminal
* -e VAR=value : set an environment variable before invoking the command
* -d : run in detached mode
* --name=toto : set the name of container to toto
* --rm : clean up directory at leave 
* --user , -u 		Username or UID (format: <name|uid>[:<group|gid>])
* -v [host_src:]docker_dest : volume mount bind
* -w [pwd] : set working directory


## Location

* var/lib/docker
  * containers
  * image
  * volume
