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

function download_cni {
    echo "********" downloading cni "********"
    mkdir -p cni
    if [ -f cni/cni-plugins-amd64-v0.6.0.tgz ]; then
    	echo found cni-plugin, skip downloading
    else
        echo "********" downloading cni-plugins 0.6.0 "********"
        wget https://github.com/containernetworking/plugins/releases/download/v0.6.0/cni-plugins-amd64-v0.6.0.tgz -O cni/cni-plugins-amd64-v0.6.0.tgz
    fi
    tar xvfz cni/cni-plugins-amd64-v0.6.0.tgz -C cni/

    if [ -f cni/containerd-1.2.0-rc.0.linux-amd64.tar.gz ]; then
	    echo found containerd, skip downloading
    else
        echo "********" downloading containerd-1.2.0 "********"
        wget https://github.com/containerd/containerd/releases/download/v1.2.0-rc.0/containerd-1.2.0-rc.0.linux-amd64.tar.gz -O cni/containerd-1.2.0-rc.0.linux-amd64.tar.gz
    fi
    tar xvfz cni/containerd-1.2.0-rc.0.linux-amd64.tar.gz -C cni/

    wget https://github.com/opencontainers/runc/releases/download/v1.0.0-rc5/runc.amd64 -O cni/runc.amd64
    wget https://storage.googleapis.com/kubernetes-the-hard-way/runsc-50c283b9f56bb7200938d9e207355f05f79f0d17 -O cni/runsc.amd64
}
