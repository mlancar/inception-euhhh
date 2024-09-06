
# sleep 10
cd /var/www/html/wordpress
# if ! wp-cli.phar core is-installed; then
wp-cli.phar cli update  --yes \
						--allow-root && echo update success 1

# wp-cli.phar core download --allow-root

wp-cli.phar config create	--allow-root \
					--dbname=$SQL_DATABASE \
					--dbuser=$SQL_USER \
					--dbpass=$SQL_PASSWORD \
					--dbhost=$SQL_HOSTNAME \
					--url=https://${DOMAIN_NAME}

wp-cli.phar core install	--allow-root \
			--url=https://${DOMAIN_NAME} \
			--title=${SITE_TITLE} \
			--admin_user=${ADMIN_USER} \
			--admin_password=${ADMIN_PASSWORD} \
			--admin_email=${ADMIN_EMAIL};

wp-cli.phar user create		--allow-root \
			${USER1_LOGIN} ${USER1_MAIL} \
			--role=author \
			--user_pass=${USER1_PASS} ;

wp-cli.phar theme install twentytwentytwo --activate --allow-root

ls /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/*
# fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

exec /usr/sbin/php-fpm82 -F -R
