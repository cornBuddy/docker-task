FROM library/java:8u111-alpine
MAINTAINER Heorhi Sakovich (heorhi_sakovich@epam.com)

ENV TOMCAT_VERSION_MAJOR 8
ENV TOMCAT_VERSION_FULL 8.5.29

RUN mkdir -p /opt/
RUN apk add --update curl \
    && curl -LO http://mirrors.standaloneinstaller.com/apache/tomcat/tomcat-${TOMCAT_VERSION_MAJOR}/v${TOMCAT_VERSION_FULL}/bin/apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz \
    && curl -LO https://www.apache.org/dist/tomcat/tomcat-${TOMCAT_VERSION_MAJOR}/v${TOMCAT_VERSION_FULL}/bin/apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz.sha512 \
    && sha512sum -c apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz.sha512 \
    && gunzip -c apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz | tar -xf - -C /opt \
    && ln -s /opt/apache-tomcat-${TOMCAT_VERSION_FULL} /opt/tomcat \
    && apk del curl

ADD tomcat-users.xml /opt/tomcat/conf/
RUN sed -i 's/52428800/5242880000/g' /opt/tomcat/webapps/manager/WEB-INF/web.xml

ENV CATALINA_HOME /opt/tomcat

CMD ${CATALINA_HOME}/bin/catalina.sh run
