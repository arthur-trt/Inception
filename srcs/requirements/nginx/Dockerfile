FROM	debian:buster

RUN 	apt-get update &&	\
		apt-get install -y nginx openssl

RUN		mkdir /run/nginx /www && \
	 	openssl req -x509 -nodes -subj '/CN=localhost' -days 365 -newkey rsa:4096 \
		 -keyout /etc/ssl/private/server.key -out /etc/ssl/certs/server.crt && \
		rm -rf /etc/nginx/nginx.conf /etc/nginx/sites-available/default

COPY	./conf/nginx.conf /etc/nginx/nginx.conf
COPY	./conf/default	/etc/nginx/sites-available/default

RUN		ln -sf /dev/stdout /var/log/nginx/access.log \
		&& ln -sf /dev/stderr /var/log/nginx/error.log

CMD [ "nginx", "-g", "daemon off;" ]
