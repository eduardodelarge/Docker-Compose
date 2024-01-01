# Docker and Docker Compose

## Docker

Docker is an open-source platform that automates the deployment, scaling, and management of applications. It uses containerization technology to bundle an application and its dependencies into a single object.

### Installation

Follow the instructions on the official Docker website to install Docker on your machine:

- [Install Docker](https://docs.docker.com/get-docker/)

### Basic Commands

- `docker run IMAGE`: Run a Docker container from an image.
- `docker build . -t IMAGE_NAME`: Build a Docker image from a Dockerfile in the current directory.
- `docker ps`: List running Docker containers.
- `docker stop CONTAINER_ID`: Stop a running Docker container.

## Docker Compose

Docker Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application's services.

### Installation

Follow the instructions on the official Docker website to install Docker Compose on your machine:

- [Install Docker Compose](https://docs.docker.com/compose/install/)

### Basic Commands

- `docker-compose up`: Start all services defined in `docker-compose.yml`.
- `docker-compose down`: Stop all services defined in `docker-compose.yml`.
- `docker-compose build`: Build or rebuild services.

For more detailed information, refer to the official Docker and Docker Compose documentation.