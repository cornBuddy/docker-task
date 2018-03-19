FROM busybox
MAINTAINER Heorhi Sakovich (heorhi_sakovich@epam.com)
ARG wwwdir=/data/html
RUN mkdir -p $wwwdir
VOLUME $wwwdir
ADD chore/tomcat.conf /etc/nginx/conf.d/
ADD index.html $wwwdir
