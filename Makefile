# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: caeduard <caeduard>                        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/11/09 00:50:15 by caeduard          #+#    #+#              #
#    Updated: 2023/11/09 00:50:58 by caeduard         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

up:
	docker-compose up -d

down:
	docker-compose down

build:
	docker-compose build

re: down build up

ps:
	docker-compose ps

logs:
	docker-compose logs

stop:
	docker-compose stop
	
rm:
	docker-compose rm