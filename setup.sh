apt update
apt upgrade -y

# Add the kubernetes package
echo "deb  http://apt.kubernetes.io/  kubernetes-xenial  main" > \
    /etc/apt/sources.list.d/kubernetes.list

curl -s \
    https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | apt-key add -

KUBE_VERSION=1.15.3-00

apt update
apt install -y \
    kubeadm=$KUBE_VERSION \
    kubelet=$KUBE_VERSION \
    kubectl=$KUBE_VERSION

# Diable the swap partition
swapoff -a

# Disable the firewall
systemctl stop ufw
systemctl disable ufw
