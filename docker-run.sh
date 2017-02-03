#!/bin/bash
export DOCKERHOST=$(ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1)
docker rm ngs-mediaserver-container
PWD=`pwd`
docker run -ti \
    -p 8000:8000 \
    --privileged \
    --env-file $PWD/.env \
    --add-host dockerhost:$DOCKERHOST \
    --name ngs-mediaserver-container \
    ngs-mediaserver:latest \
    "$@"
