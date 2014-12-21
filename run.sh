#!/bin/bash

HOSTIPADDR=$(/bin/ip route get 8.8.8.8 | /usr/bin/head -1 | /usr/bin/cut -d' ' -f8)

if [ x"$HOSTIPADDR" = x"" ]; then
    echo "Cannot get host ip address"
fi
echo "HOST IP : $HOSTIPADDR"

sudo docker run -p 80:80 -e HOSTIPADDR=$HOSTIPADDR $1 efolder:base $2
