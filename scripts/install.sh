#!/bin/bash


#read -p "Press [Enter] to start installation..."


#build images
./docker/build.sh
./docker/build_cypress.sh

docker-compose -f docker/docker-compose.cypress.yml up -d
docker-compose --env-file ./.env up -d

echo $'\nInstallation complete. Containers are running.\n'
