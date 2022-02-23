chmod o+w /dev/stdout
chmod o+w /dev/stderr

if [ ! -f /var/www/html/wp-config.php ]; then
	cd /var/www/html
	wp core download --allow-root
	until mysqladmin -hmariadb -u${DB_WP_USER} -p${DB_WP_PASS} ping; do
		sleep 2
	done

	wp config create --dbname="${DB_WP_NAME}" --dbuser="${DB_WP_USER}" --dbpass="${DB_WP_PASS}" --dbhost="mariadb" --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	wp core install --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASS}" --admin_email="${WP_ADMIN_MAIL}" --skip-email --allow-root
	wp user create "${WP_USER_NAME}" "${WP_USER_MAIL}" --role=author --user_pass="${WP_USER_PASS}" --allow-root
	wp theme install inspiro --activate --allow-root
fi;

php-fpm7.3 -F -R
