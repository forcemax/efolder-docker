efolder-docker
==============
# Docker build for efolder

This Docker image is for people who would like to try
[efolder](https://github.com/forcemax/efolder).

To use it, you will need an OS which can run
[Docker](http://docker.io).


## How to build

```
git clone https://github.com/forcemax/efolder-docker.git
cd efolder-docker
sudo docker build -t efolder:lastest .
```


## How to use it

Start a container with this command:

```
./run.sh
```


## Docker Registry Hub

If you don't want to build your own, you can get the image which I
have built from the Docker Hub.

```
sudo docker pull forcemax/efolder
```
