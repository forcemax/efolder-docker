#!/bin/bash

HOSTIP=$HOSTIPADDR

/bin/cp -f /app/tmp/update*.dat /tmp/
/bin/sed "s/z.embian.com/$HOSTIP/g" /app/tmp/server.dat > /tmp/server.dat
/bin/chmod -R a+rwx /eFolder
/bin/sed -i "s/\(^\$cfg->CookieDomain = \).*/\1\"$HOSTIP\"/" /app/www/eFolderAdmin/Config/setup.php
