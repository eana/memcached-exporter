FROM alpine:3.11.6

RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
        git \
        bash \
        gcc \
        musl-dev \
        openssl \
        go \
        curl \
    \
    && go get -v  github.com/prometheus/memcached_exporter \
    && cp /root/go/bin/memcached_exporter /usr/local/bin \
    && rm -fr /root/go \
    && apk del .build-deps

EXPOSE 9150

CMD if [ -z ${INSTANCE+x} ]; then memcached_exporter; else memcached_exporter --memcached.address ${INSTANCE}; fi
