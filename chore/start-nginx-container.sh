#!/bin/bash

set -e

if [[ ! -f "./nginx.Dockerfile" ]]; then
    cd ../
fi

docker build -t nginx -f nginx.Dockerfile .
docker build -t nginx-data -f nginx-data.Dockerfile .
