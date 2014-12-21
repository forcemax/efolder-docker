efolder-docker
==============
# Docker build for efolder

This Docker image is for people who would like to try
[efolder](https://github.com/forcemax/efolder).

To use it, you will need an OS which can run
[Docker](http://docker.io).


## How to build it

Clone github repository
```
git clone https://github.com/forcemax/efolder-docker.git efolder-docker

```

Change admin password
```
cd efolder-docker
sed -i "s/test/MYPASSWORD/g" setup.php
```

Build image
```
sudo docker build -t efolder:latest .
```


## How to use it

Start a container with this command:

```
echo "" >> ~/.bashrc
echo "export HOSTIPADDR=\$(/bin/ip route get 8.8.8.8 | /usr/bin/head -1 | /usr/bin/cut -d' ' -f8)" >> ~/.bashrc
source ~/.bashrc
sudo docker run -t -i -p 80:80 -e HOSTIPADDR=$HOSTIPADDR efolder:latest
```


## Create Account & Group

Using web browser
"http://IPADDRESS/eFolderAdmin/"  


## Docker Registry Hub

If you don't want to build your own, you can get the image which I
have built from the Docker Hub.

```
sudo docker pull forcemax/efolder
echo "" >> ~/.bashrc
echo "export HOSTIPADDR=\$(/bin/ip route get 8.8.8.8 | /usr/bin/head -1 | /usr/bin/cut -d' ' -f8)" >> ~/.bashrc
source ~/.bashrc
sudo docker run -t -i -p 80:80 -e HOSTIPADDR=$HOSTIPADDR forcemax/efolder

```
