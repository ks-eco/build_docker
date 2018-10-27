#!/bin/bash

source "./build_common.sh"

# Fix the version number for now
download_k8s 1.11.0
download_etcd 3.2.24
download_cni

echo "k8s:" 1.11.0 > VERSIONS
echo "etcd:" 3.2.24 >> VERSIONS
echo "cni-plugin: 0.6.0" >> VERSIONS
echo "containerd: 1.2.0" >> VERSIONS

# push to the docker image
docker build . -t codemk8/ksbins:1.11.0
docker push codemk8/ksbins:1.11.0
