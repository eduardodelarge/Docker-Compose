FROM debian:bullseye

# Install packages
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y install wget curl php7.3 php-cli php-fpm php-mysql mariadb-client sendmail && \
    rm -rf /var/lib/apt/lists/*

#Curl will download wordpress cli https://github.com/wp-cli/wp-cli
RUN mkdir -p tools && \
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
chmod +x wp-cli.phar && \
mv wp-cli.phar /usr/local/bin/wp && \
wp cli update

COPY ./conf/www.conf /tools/www.conf
COPY ./conf/php-fpm.conf /tools/php-fpm.conf
COPY ./tools/create_wordpress.sh /tools/create_wordpress.sh

RUN chmod +x /tools/create_wordpress.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/tools/create_wordpress.sh"]