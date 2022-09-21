#!/bin/bash
docker-compose -f docker/docker-compose.cypress.yml run --rm --entrypoint /tmp/docker-cypress-bash-entrypoint.sh cypress_gui
