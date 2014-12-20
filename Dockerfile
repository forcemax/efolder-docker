
#
# eFolder Dockerfile
#

# Pull base image.
FROM ubuntu:14.04
MAINTAINER forcemax@gmail.com

# Install apache, mysql, mod-perl, php5
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		apache2 \
		apache2-data \
	&& apt-get install -y --no-install-recommends \
		libapache2-mod-perl2 \
		libncurses5-dev \
		libdbi-perl \
		libtext-iconv-perl \
		libtimedate-perl \
		libdate-calc-perl \
		libdbd-mysql-perl \
		libnet-dns-perl \
		libmime-lite-perl \
		libossp-uuid-perl \
		libemail-address-perl \
		libmailtools-perl \
		libsoap-lite-perl \
		libsphinx-search-perl \
	&& apt-get install -y --no-install-recommends \
		libapache2-mod-php5 \
		php5-mysql \
	&& apt-get install -y --no-install-recommends \
		subversion \
	&& apt-get install -y --no-install-recommends \
		mysql-server \
	&& apt-get install -y --no-install-recommends \
		sphinxsearch \
	&& apt-get install -y --no-install-recommends \
		supervisor \
	&& rm -r /var/lib/apt/lists/*

RUN mkdir -p /var/log/supervisor
RUN mkdir -p /eFolder
RUN chown -R www-data:www-data /eFolder

RUN svn export svn://repo.embian.com/eFolder /app

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY 00.CONFIG /app/etc/00.CONFIG
COPY FILE_crawl.pl /app/etc/FILE_crawl.pl
RUN chmod a+x /app/etc/FILE_crawl.pl
COPY makeSphinxIndex.sh /app/etc/makeSphinxIndex.sh
RUN chmod a+x /app/etc/makeSphinxIndex.sh
COPY sphinx.conf /app/etc/sphinx.conf
COPY searchd.sh /app/etc/searchd.sh
COPY ddns.sh /app/etc/ddns.sh
RUN chmod a+x /app/etc/ddns.sh
COPY setup.php /app/www/eFolderAdmin/Config/setup.php
COPY EmbianSoapHandler.pm /app/src/EmbianSoap/EmbianSoapHandler.pm
COPY CONFIG.pm /app/src/FTPService/lib/perl/eFolder/CONFIG.pm

RUN echo "" >> /etc/crontab
RUN echo "36 4 * * * root ( cd /app/etc ; bash makeSphinxIndex.sh all 2> /dev/null > /dev/null )" >> /etc/crontab
RUN echo "* * * * * root ( cd /app/etc ; bash makeSphinxIndex.sh delta 2> /dev/null > /dev/null )" >> /etc/crontab

RUN service mysql start \
	&& mysqladmin -uroot password OWNMYSQLDBPASSWORD \
	&& mysqladmin -uroot -pOWNMYSQLDBPASSWORD create eAccountManager \
	&& mysqladmin -uroot -pOWNMYSQLDBPASSWORD create eFolder \
	&& mysqladmin -uroot -pOWNMYSQLDBPASSWORD create rss \
	&& mysql -uroot -pOWNMYSQLDBPASSWORD eAccountManager < /app/doc/db/eAccountManager.sql \
	&& mysql -uroot -pOWNMYSQLDBPASSWORD eFolder < /app/doc/db/eFolder.sql \
	&& mysql -uroot -pOWNMYSQLDBPASSWORD rss < /app/doc/db/rss.sql \
	&& mysql -uroot -pOWNMYSQLDBPASSWORD < /app/doc/db/uas.sql \
	&& service mysql stop

RUN ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime

EXPOSE 80
CMD ["/usr/bin/supervisord"]
