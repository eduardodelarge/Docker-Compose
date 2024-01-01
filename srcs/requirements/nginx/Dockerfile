# Dockerfile

# Use the alpine:3.17 image as the base
FROM alpine:3.17

# Update the package list, upgrade all packages, and install nginx and openssl
RUN	apk update && apk upgrade && apk add --no-cache \
        nginx openssl

# Create a directory for the SSL certificate and key
RUN mkdir /etc/nginx/ssl

# Generate a new self-signed SSL certificate and key with openssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/caeduard.pem \
        -keyout /etc/nginx/ssl/caeduard.key \
        -subj "/C=BR/ST=SAOPAULO/L=SAOPAULO/O=42 School/OU=caeduard/CN=caeduard/"

# Create a directory for nginx to store its PID file
RUN mkdir -p /run/nginx

# Copy the nginx configuration file into the image
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Set the command to run when the container starts
ENTRYPOINT ["nginx", "-g", "daemon off;"]