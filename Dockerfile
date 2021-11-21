FROM alpine

ENV Nginx_PORT=8080 RAY_PORT=38080
ENV RAY_UUID=021dbdd1-6842-467b-8724-3397e80faa5a RAY_PATH=downloads

RUN set -ex \
        && apk update \
        && apk upgrade \
        && apk add --no-cache --virtual .build-deps ca-certificates git nginx curl wget unzip \
        && mkdir /tmp/v2ray \
        && git clone https://github.com/xiongbao/we.dog \
        && mv we.dog/* /var/lib/nginx/html/ \
        && rm -rf /we.dog
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE ${Nginx_PORT}

ENTRYPOINT ["/entrypoint.sh"]
