#!/usr/bin/env bash

if [ -z "$1" ]
then
    echo "You have to inform the container"
    exit 1
fi

docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1
