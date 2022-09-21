#!/bin/bash
docker-compose -f docker/docker-compose.cypress.yml run --rm cypress_gui cypress run --project .
