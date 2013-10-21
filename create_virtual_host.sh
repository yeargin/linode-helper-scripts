#!/bin/bash
# Apache
###########################################################

function apache_virtualhost {
	# Configures a VirtualHost

	# $1 - required - the hostname of the virtualhost to create 

	if [ ! -n "$1" ]; then
		echo "apache_virtualhost() requires the hostname as the first argument"
		return 1;
	fi

	if [ -e "/etc/apache2/sites-available/$1" ]; then
		echo /etc/apache2/sites-available/$1 already exists
		return;
	fi

	mkdir -p /srv/www/$1/public_html /srv/www/$1/logs
	chown -fR root:www-data /srv/www/$1

	echo "<VirtualHost *:80>" > /etc/apache2/sites-available/$1
	echo "    ServerName $1" >> /etc/apache2/sites-available/$1
	echo "    ServerAlias www.$1" >> /etc/apache2/sites-available/$1
	echo "    DocumentRoot /srv/www/$1/public_html/" >> /etc/apache2/sites-available/$1
	echo "    ErrorLog /srv/www/$1/logs/error.log" >> /etc/apache2/sites-available/$1
        echo "    CustomLog /srv/www/$1/logs/access.log combined" >> /etc/apache2/sites-available/$1
	echo "</VirtualHost>" >> /etc/apache2/sites-available/$1

	a2ensite $1

	touch /tmp/restart-apache2
}

apache_virtualhost $1
