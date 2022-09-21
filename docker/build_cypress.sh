#!/bin/bash

#Note: run this from project root: ./docker/build_cypress.sh
docker build --build-arg UID=$(id -u) --build-arg GID=$(getent group docker | cut -d: -f3) -f docker/Dockerfile_cypress -t cloudinary_cy3 .
