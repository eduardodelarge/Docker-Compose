# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: caeduard <caeduard>                        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/11/09 00:50:15 by caeduard          #+#    #+#              #
#    Updated: 2024/01/01 13:06:48 by caeduard         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			= inception

DOCKER_COMPOSE	= docker-compose -f srcs/docker-compose.yml

DOCKER			= docker

all:			unix
				${DOCKER_COMPOSE} build
				${DOCKER_COMPOSE} up -d

unix:
#Add entries to the /etc/hosts file to map the hostnames caeduard.42.fr and www.caeduard.42.fr to the local loopback IP address.
				echo "127.0.0.1 caeduard.42.fr" >> /etc/hosts
				
				echo "127.0.0.1 www.caeduard.42.fr" >> /etc/hosts
#This is done to redirect network requests made to these hostnames to the local machine, which is useful for testing.
ls:
				${DOCKER} ps -a

build: 
				${DOCKER_COMPOSE} build

up:
				${DOCKER_COMPOSE} up -d
	
down:
				${DOCKER_COMPOSE} down

pause:
				${DOCKER_COMPOSE} pause

unpause:
				${DOCKER_COMPOSE} unpause

clean:			down
				rm -rf ~/Desktop/inception
				${DOCKER_COMPOSE} down -v --rmi all --remove-orphans

fclean: 		clean
				${DOCKER} system prune -f

re:				fclean all

.PHONY:			linux stop clean prune all build up