#!/bin/bash

source "./build_common.sh"

# Fix the version number for now
download_k8s 1.11.0
download_etcd 3.2.24

echo "k8s:" 1.11.0 > VERSIONS
echo "etcd:" 3.2.24 >> VERSIONS

# push to the docker image
docker build . -t codemk8/ksbins:1.11.0
docker push codemk8/ksbins:1.11.0