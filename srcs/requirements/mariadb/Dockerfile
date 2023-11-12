FROM debian:bullseye

# Install packages
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

#This is to allow remote connections to the database
RUN sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf

#Create a directory to store scripts
RUN mkdir -p tools 

#This will allow the mysql user to access the database by changing the ownership of the directory
RUN chown mysql:mysql /var/lib/mysql 

WORKDIR /tools #workdir is the directory where the commands will be executed

COPY ./tools/create_db.sh /tools

#This will allow the script to be executed
RUN chmod +x /tools/create_db.sh 

EXPOSE 3306

#Entrypoint is the command that will be executed when the container is created
ENTRYPOINT [ "/tools/create_db.sh" ]