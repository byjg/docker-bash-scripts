#!/usr/bin/env bash

# remove exited containers:
docker ps --filter status=dead --filter status=exited -aq | xargs -r docker rm -v

# remove unused images:
docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi

# remove unused volumes:
docker volume ls -qf dangling=true | xargs -r docker volume rm

if [ "$1" == "--force" ]
then
    images=$(docker images --no-trunc | grep '<none>' | awk '{ print $3 }')
    for image in $images
    do
        docker inspect --format='{{.Id}} {{.Parent}}' $(docker images --filter since=$image -q) | xargs -r docker rmi
    done
fi

