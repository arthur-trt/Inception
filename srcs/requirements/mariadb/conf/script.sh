
chmod o+w /dev/stdout
chmod o+w /dev/stderr
if [ ! -f /var/lib/mysql/conf_done ]; then
	mysqld&
	until mysqladmin ping; do
		sleep 2
	done

	#mysql -u root -e "SET GLOBAL general_log=1;"
	#mysql -u root -e "SET GLOBAL general_log_file='/var/log/mysql/mariadb.log';"
	mysql -u root -e "CREATE DATABASE ${DB_WP_NAME};"
	mysql -u root -e "CREATE USER '${DB_ROOT_USER}'@'%' IDENTIFIED BY '${DB_ROOT_PASS}';"
	mysql -u root -e "GRANT ALL ON *.* TO '${DB_ROOT_USER}'@'%';"
	mysql -u root -e "CREATE USER '${DB_WP_USER}'@'%' IDENTIFIED BY '${DB_WP_PASS}';"
	mysql -u root -e "GRANT ALL ON ${DB_WP_NAME}.* TO '${DB_WP_USER}'@'%';"
	mysql -u root -e "FLUSH PRIVILEGES;"

	killall mysqld
	touch /var/lib/mysql/conf_done
fi;

mysqld --slow-query-log-file=/dev/stderr --slow-query-log
