#!/bin/bash

sleep 10

# cd /var/www/html/wordpress
# if ! wp-cli.phar core is-installed; then
wp-cli.phar cli update  --yes \
						--allow-root && echo update success 1

wp-cli.phar core download --allow-root

# echo 	QWJROQWEJHROQWEJRQWEJRQWOERJWQEO $SQL_DATABASE \
# 	$SQL_USER \
# 	$SQL_PASSWORD \
# 	$SQL_HOSTNAME 

/usr/local/bin/wp-cli.phar config create	--allow-root\
					--dbname=$SQL_DATABASE \
					--dbuser=$SQL_USER \
					--dbpass=$SQL_PASSWORD \
					--dbhost=$SQL_HOSTNAME #--path='/var/www/html/wordpress'
					# --config-file=/var/www/html/wordpress

/usr/local/bin/wp-cli.phar core install	--allow-root \
			--url=https://${DOMAIN_NAME} \
			--title=${SITE_TITLE} \
			--admin_user=${ADMIN_USER} \
			--admin_password=${ADMIN_PASSWORD} \
			--admin_email=${ADMIN_EMAIL};

/usr/local/bin/wp-cli.phar config path

/usr/local/bin/wp-cli.phar user create		--allow-root \
			${USER1_LOGIN} ${USER1_MAIL} \
			--role=author \
			--user_pass=${USER1_PASS} ;


/usr/local/bin/wp-cli.phar cache flush --allow-root

/usr/local/bin/wp-cli.phar plugin install contact-form-7 --activate

/usr/local/bin/wp-cli.phar language core install en_US --activate

/usr/local/bin/wp-cli.phar theme delete twentynineteen twentytwenty
/usr/local/bin/wp-cli.phar plugin delete hello

/usr/local/bin/wp-cli.phar rewrite structure '/%postname%/'

# fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

exec /usr/sbin/php-fpm82 -F -R
