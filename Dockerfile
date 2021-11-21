FROM alpine

ENV Nginx_PORT=8080 RAY_PORT=38080
ENV RAY_UUID=021dbdd1-6842-467b-8724-3397e80faa5a RAY_PATH=downloads

RUN apk update 
RUN apk upgrade
RUN apk add --no-cache --virtual .build-deps ca-certificates git nginx curl wget unzip

RUN mkdir /run/nginx
# ADD default.conf /etc/nginx/conf.d/default.conf
ADD index.html /var/lib/nginx/html/index.html

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE ${Nginx_PORT}

ENTRYPOINT ["/entrypoint.sh"]
