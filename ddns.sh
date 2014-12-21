#!/bin/bash

HOSTIP=$HOSTIPADDR

/bin/cp -f /app/tmp/update*.dat /tmp/
/bin/sed "s/z.embian.com/$HOSTIP/g" /app/tmp/server.dat > /tmp/server.dat
/bin/chmod -R a+rwx /eFolder
/bin/sed "s/\(^\$cfg->CookieDomain = \).*/\1\"$HOSTIP\"/" /app/www/eFolderAdmin/Config/setup.php > /app/www/eFolderAdmin/Config/setup.php.tmp
/bin/mv -f /app/www/eFolderAdmin/Config/setup.php.tmp /app/www/eFolderAdmin/Config/setup.php
