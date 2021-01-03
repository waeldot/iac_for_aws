FROM alpine:3
RUN mkdir /appdata

#nginx setup
ADD nginx-1.18.0.tar.gz /tmp/
WORKDIR /tmp/nginx-1.18.0
RUN apk update \
 && apk add build-base \
 && apk add pcre pcre-dev \
 && apk add openssl openssl-dev \
 && apk add zlib zlib-dev \
 && ./configure --prefix=/opt/nginx --with-http_ssl_module \
 && make && make install 
COPY nginx.conf /opt/nginx/conf
WORKDIR /opt/nginx

#tomcat setup
ADD apache-tomcat-8.5.57.tar.gz /opt/
RUN apk update \
 && apk add openjdk7-jre \
 && mv /opt/apache-tomcat-8.5.57 /opt/tomcat
WORKDIR /opt/tomcat


