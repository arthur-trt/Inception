FROM debian:buster

RUN apt-get update && \
	apt-get install -y mariadb-server mariadb-client &&\
	mkdir -p /var/run/mysqld/ ; mkdir -p /run/mysqld/ && \
	chown -R mysql:root /var/run/mysqld/; chown -R mysql:root /run/mysqld/

COPY ./conf/script.sh /root/
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN		ln -sf /dev/stdout /var/log/mysql/mariadb.log	&& \
		ln -sf /dev/stderr /var/log/mysql/error.log

CMD [ "bash", "/root/script.sh" ]
