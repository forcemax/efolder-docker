#!/bin/bash

/usr/sbin/dpkg-reconfigure mysql-server-5.5

service mysql start

/usr/bin/mysqladmin -uroot password OWNMYSQLDBPASSWORD
/usr/bin/mysqladmin -uroot -pOWNMYSQLDBPASSWORD create eAccountManager
/usr/bin/mysqladmin -uroot -pOWNMYSQLDBPASSWORD create eFolder
/usr/bin/mysqladmin -uroot -pOWNMYSQLDBPASSWORD create rss
/usr/bin/mysql -uroot -pOWNMYSQLDBPASSWORD eAccountManager < /app/doc/db/eAccountManager.sql
/usr/bin/mysql -uroot -pOWNMYSQLDBPASSWORD eFolder < /app/doc/db/eFolder.sql
/usr/bin/mysql -uroot -pOWNMYSQLDBPASSWORD rss < /app/doc/db/rss.sql
/usr/bin/mysql -uroot -pOWNMYSQLDBPASSWORD < /app/doc/db/uas.sql

service mysql stop

