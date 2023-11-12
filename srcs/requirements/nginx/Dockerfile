FROM debian:bullseye

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install nginx openssl

EXPOSE 443

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/default
COPY ./tools/nginx_start.sh /var/www/html

RUN chmod +x /var/www/html/nginx_start.sh && \
    ln -sf /deb/stdout /var/log/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

ENTRYPOINT [ "/var/www/html/nginx_start.sh" ]

CMD ["nginx", "-g", "daemon off;"]