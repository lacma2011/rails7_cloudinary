#!/bin/bash

#Note: run this from project root: ./docker/build.sh

# make tmp folder, before postgres container makes it for you with root priveleges
#mkdir -p tmp/
#mkdir -p tmp/db

docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -f docker/Dockerfile_rails . -t cloudinary_rails3
docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -f docker/Dockerfile_fe . -t cloudinary_fe3
#docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -f docker/Dockerfile_psql . -t psql3
