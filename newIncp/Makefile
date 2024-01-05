# Makefile to build, run, stop, and clean up the Nginx container

# Variables
DOCKER_IMAGE_NAME = my-nginx
DOCKER_CONTAINER_NAME = nginx-container

# Default target (when 'make' is run without arguments)
all: build run

# Build the Nginx container
build:
	docker build -t $(DOCKER_IMAGE_NAME) -f ~/Desktop/newIncp/srcs/requirements/nginx .

# Run the Nginx container
run:
	docker run -d --name $(DOCKER_CONTAINER_NAME) -p 443:443 $(DOCKER_IMAGE_NAME)

# Stop and remove the Nginx container
stop:
	docker stop $(DOCKER_CONTAINER_NAME) && docker rm $(DOCKER_CONTAINER_NAME)

# Clean up everything, including volumes
clean: stop
	docker rmi $(DOCKER_IMAGE_NAME)

# .PHONY indicates that these targets don't represent files
.PHONY: all build run stop clean
