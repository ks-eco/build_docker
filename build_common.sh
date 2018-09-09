#!/bin/bash


function download_etcd {
    echo "********" downloading etcd version $1 "********"
    mkdir -p etcd-$1
    ETCD_VER=v$1
    if [ -f etcd-$1/etcd ]; then
        echo found existing etcd binary at etcd-$1/etcd, skip downloading
    else
        rm -rf etcd-${ETCD_VER}-linux-amd64.tar.gz etcd-${ETCD_VER}-linux-amd64
        GOOGLE_URL=https://storage.googleapis.com/etcd
        DOWNLOAD_URL=${GOOGLE_URL}
        echo etcd source url is ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz
        curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o etcd-${ETCD_VER}-linux-amd64.tar.gz
        tar xvfz etcd-${ETCD_VER}-linux-amd64.tar.gz
        cp etcd-${ETCD_VER}-linux-amd64/etcd etcd-${ETCD_VER}-linux-amd64/etcdctl etcd-$1/.
    fi

}

function download_k8s {
    echo "********" downloading k8s version $1 "********"
    mkdir -p k8s-$1
    if [ -f k8s-$1/hyperkube ]; then
        echo found existing k8s binary at k8s-$1/hyperkube, skip downloading
    else
        rm -rf kubernetes.tar.gz kubernetes
        wget https://github.com/kubernetes/kubernetes/releases/download/v$1/kubernetes.tar.gz
        tar xvfz kubernetes.tar.gz
        echo Y | ./kubernetes/cluster/get-kube-binaries.sh
        tar xvfz ./kubernetes/server/kubernetes-server-linux-amd64.tar.gz
        cp ./kubernetes/server/bin/hyperkube k8s-$1/.
    fi
}
