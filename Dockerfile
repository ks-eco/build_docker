FROM alpine:3.8

RUN mkdir -p /ks-eco/binaries/
COPY VERSIONS /ks-eco/VERSIONS
# TODO do not hardcode version number
COPY etcd-3.2.24/ /ks-eco/binaries/
COPY k8s-1.11.0 /ks-eco/binaries/

