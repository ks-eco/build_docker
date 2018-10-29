FROM alpine:3.8

RUN mkdir -p /ks-eco/binaries/cni/plugin
COPY VERSIONS /ks-eco/VERSIONS
# TODO do not hardcode version number
COPY etcd-3.2.24/ /ks-eco/binaries/
COPY k8s-1.11.0 /ks-eco/binaries/
COPY cni/bridge cni/flannel cni/ipvlan cni/macvlan cni/ptp cni/tuning cni/dhcp cni/host-local cni/loopback cni/portmap cni/sample cni/vlan /ks-eco/binaries/cni/plugin/
COPY cni/bin/ /ks-eco/binaries/cni/bin/

# idle 
CMD ["sh", "-c", "tail -f /dev/null"]