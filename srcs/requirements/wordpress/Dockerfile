FROM alpine:3.18


RUN apk update && apk upgrade && apk add \
        wget  \  
        sudo \
        php82 \
        php82-fpm \
        php82-mysqli \
        php82-phar    \
        php82-mbstring \
        mariadb-client  

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp-cli.phar

RUN (delgroup www-data || true) 

RUN adduser -H -D -u 1000 -g www-data www-data

RUN mkdir -p /var/www/html

RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 777 /var/www/html

EXPOSE 9000

COPY ./tools/setup_wordpress.sh ./
RUN chmod +x ./setup_wordpress.sh

COPY ./conf/wordpress.conf /etc/php/82/fpm/pool.d/www.conf

RUN chmod 755 /etc/php/82/fpm/pool.d/www.conf

RUN ln -s /usr/bin/php82 /usr/bin/php

ENTRYPOINT ["sh", "./setup_wordpress.sh"]