# Memcached Exporter

A [memcached](https://memcached.org/) exporter for prometheus.

The memcached exporter exports metrics from a memcached server for
consumption by prometheus. The server is specified as `-memcached.address` flag
to the program (default is `localhost:11211`).

There is also optional support to export metrics about the memcached process
itself by setting the `-memcached.pid-file <path>` flag. If the
memcached\_exporter process has the rights to read /proc information of the
memcached process, then the following metrics will be exported additionally.

## Building and running it

```bash
HOSTIP=$(ip -4 a s dev docker0 | grep inet | awk '{print $2}' | cut -d / -f 1)
TAG=$(curl -s https://api.github.com/repos/prometheus/memcached_exporter/tags | jq --raw-output '.[].name')

docker build -t memcached-exporter:${TAG} github.com/eana/memcached-exporter
```
Assuming you already have a docker container running a memcached instance:

```bash
docker run --name memcached-exporter -d -p ${HOSTIP}:9150:9150 \
    --restart=always \
    -e INSTANCE=${HOSTIP}:11211 \
    memcached-exporter:${TAG}
```
