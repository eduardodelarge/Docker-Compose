#!/bin/sh

# Check if the MySQL runtime directory exists
if [ ! -d "/run/mysqld" ]; then
    # If not, create it
    mkdir -p /run/mysqld
    # Change the owner of the directory to the MySQL user
    chown -R mysql:mysql /run/mysqld
fi

# Check if the main MySQL directory exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # If not, change the owner of the directory to the MySQL user
    chown -R mysql:mysql /var/lib/mysql

    # Initialize the database
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

    # Create a temporary file
    tfile=`mktemp`
    # If the temporary file wasn't created successfully, exit with an error
    if [ ! -f "$tfile" ]; then
        return 1
    fi

    # Write SQL commands to the temporary file
    cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM	mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PWD';

CREATE DATABASE $WP_DATABASE_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$WP_DATABASE_USR'@'%' IDENTIFIED by '$WP_DATABASE_PWD';
GRANT ALL PRIVILEGES ON $WP_DATABASE_NAME.* TO '$WP_DATABASE_USR'@'%';

FLUSH PRIVILEGES;
EOF
    # Run the MySQL server with the commands from the temporary file
    /usr/bin/mysqld --user=mysql --bootstrap < $tfile
fi

# Update the MariaDB configuration to allow connections from any IP address
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

# Start the MySQL server
exec /usr/bin/mysqld --user=mysql --console