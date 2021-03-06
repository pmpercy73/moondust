FROM alpine

ENV Nginx_PORT=8080 RAY_PORT=38080
ENV RAY_UUID=021dbdd1-6842-467b-8724-3397e80faa5a RAY_PATH=downloads

RUN apk update 
RUN apk upgrade
RUN apk add --no-cache --virtual .build-deps ca-certificates git nginx curl wget unzip

ADD default.conf /etc/nginx/http.d/default.conf
ADD index.html /var/lib/nginx/html/index.html

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
