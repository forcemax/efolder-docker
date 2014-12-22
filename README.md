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
sudo docker build -t forcemax/efolder:latest .
```


## How to use it

Setup bash environment with this command:

```
echo "" >> ~/.bashrc
echo "export HOSTIPADDR=\$(/bin/ip route get 8.8.8.8 | /usr/bin/head -1 | /usr/bin/cut -d' ' -f8)" >> ~/.bashrc
source ~/.bashrc
```

Start data volume container for persistent data.

```
sudo docker run -i -t --name efolder_mysql_data -v /var/lib/mysql -v /eFolder busybox /bin/sh
exit
```

Initialize database with this command:

```
sudo docker run -t -i --volumes-from efolder_mysql_data forcemax/efolder:latest /bin/bash
/app/doc/db/init_db.sh
exit
```

Start a container with this command:

```
sudo docker run -d -p 80:80 -e HOSTIPADDR=$HOSTIPADDR --volumes-from efolder_mysql_data forcemax/efolder:latest
```


## Create Account & Group Using eFolder Admin

Using web browser

"http://IPADDRESS/eFolderAdmin/"  

Username : admin

Password : MYPASSWORD (set above)


## Using eFolder Client

You can download client from [eFolder Official Site](http://efolder.embian.com).

Set server ip address to your server's ip address in client's login dialog.
  

# Docker Registry Hub

If you don't want to build your own, you can get the image which I
have built from the Docker Hub.

```
sudo docker pull forcemax/efolder
```

but, Docker Hub's image can't change eFolder Admin's password.
Therefore, it is recommended you build your own docker image.
