#!/bin/sh

tomcat_id=$(docker build -q -f tomcat.Dockerfile .)
nginx_id=$(docker build -q -f nginx.Dockerfile .)

docker network create --subnet=192.168.0.0/16 tomcat-net

nginx_src="$(pwd)/nginx-conf"
docker run --rm -d --network=tomcat-net --ip 192.168.1.20 "$tomcat_id"
docker run -d --network=tomcat-net --ip 192.168.1.10 -p 8080:80 \
    --mount type=bind,src="$nginx_src/tomcat.conf",dst=/etc/nginx/conf.d/tomcat.conf,readonly \
    --mount type=bind,src="$nginx_src/nginx.conf",dst=/etc/nginx/nginx.conf,readonly \
    "$nginx_id"
