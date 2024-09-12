FROM alpine:3.19

RUN apk update && apk upgrade && apk add \
		openssl	\
		nginx	\
		curl	\
		vim		\
		sudo

COPY		./conf/nginx.conf /etc/nginx/nginx.conf

RUN			openssl req -x509 -nodes -out /etc/nginx/inception.crt -keyout /etc/nginx/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42Paris/OU=malancar.42.fr/CN=malancar"

RUN (delgroup www-data || true) 

RUN adduser -H -D -u 1000 -g www-data www-data

RUN mkdir /var/www/html

RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 777 /var/www/html

EXPOSE		443

CMD ["nginx", "-g", "daemon off;"]
