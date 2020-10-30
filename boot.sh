#!/bin/bash
set -e

printf "creating network --->\n"
docker network create restless-api;
printf "network created --->\n"

printf "\n"

printf "starting postgres container --->\n"
docker container run \
    --rm \
    --detach \
    --name=db \
    --env POSTGRES_PASSWORD=secret \
    --env POSTGRES_DB=notesdb \
    --network=restless-api \
    postgres:12;
printf "postgres container started --->\n"


printf "\n"

cd api;
printf "creating api image --->\n"
docker image build --tag node-api .;
printf "api image created --->\n"
printf "starting api container --->\n"
docker container run \
    --rm \
    --detach \
    --name=api \
    --env DB_PASSWORD=secret \
    --env-file .env \
    --network=restless-api \
    --publish=3000:3000 \
    node-api;
printf "api container started --->\n"


cd ..
printf "\n"

printf "all containers are up and running"