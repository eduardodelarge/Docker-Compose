#!/bin/sh

# This script waits for the MariaDB server to be ready, sets up WordPress if it's not already set up, and then starts PHP-FPM.

# Wait for the MariaDB server to be ready
# The script tries to connect to the MariaDB server using the provided credentials and database name
# If the connection fails, it waits for 3 seconds and then tries again
while ! mariadb -h$MYSQL_HOST -u$WP_DATABASE_USR -p$WP_DATABASE_PWD $WP_DATABASE_NAME &>/dev/null; do
    sleep 3
done

# Check if WordPress is already set up
# The script checks if the main WordPress index file exists
# If the file doesn't exist, it assumes that WordPress is not set up and proceeds with the setup
if [ ! -f "/var/www/html/index.html" ]; then
    # Download the WordPress core files
    wp core download
    # Create the WordPress configuration file with the provided database credentials and settings
    wp config create --dbname=$WP_DATABASE_NAME --dbuser=$WP_DATABASE_USR --dbpass=$WP_DATABASE_PWD --dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci"
    # Install WordPress with the provided site settings and admin user credentials
    wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL
    # Create a new WordPress user with the provided credentials and assign them the 'author' role
    wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD
    # Install and activate the 'inspiro' theme
    wp theme install inspiro --activate
    # Update all WordPress plugins
    wp plugin update --all 
fi

# Start PHP-FPM in the foreground
# The '--nodaemonize' option causes PHP-FPM to stay in the foreground so that Docker can track the process properly
php-fpm7 --nodaemonize


# In summary, this script waits for MariaDB to be ready, then checks if WordPress is already set up. If not, it downloads and installs WordPress, creates a new user, installs a theme, and updates all plugins. Finally, it starts PHP-FPM in the foreground.