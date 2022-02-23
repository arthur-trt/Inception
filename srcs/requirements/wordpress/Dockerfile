FROM debian:buster


RUN apt-get update && \
	apt-get install -y php7.3 php7.3-fpm php7.3-mysql curl mariadb-client && \
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	mkdir -p /var/www/html; mkdir -p /run/php

COPY ./conf/www.conf ./etc/php/7.3/fpm/pool.d/www.conf
COPY ./conf/conf.sh	/root/conf.sh

RUN		ln -sf /dev/stdout /var/log/php7.3-fpm.access.log \
		&& ln -sf /dev/stderr /var/log/php7.3-fpm.log

CMD [ "bash", "/root/conf.sh" ]
