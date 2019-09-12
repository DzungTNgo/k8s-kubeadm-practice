KUBE_VERSION=1.15.3
POD_NETWORK=192.168.0.0/16

# Initialize control plane node
kubeadm init \
    --kubernetes-version $KUBE_VERSION \
    --pod-network-cidr $POD_NETWORK \
    --apiserver-advertise-address 172.25.0.15 \
    | tee kubeadm-init.out

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Set up network solution
wget https://tinyurl.com/yb4xturm -O rbac-kdd.yaml
wget https://tinyurl.com/y8lvqc9g -O calico.yaml

kubectl apply -f rbac-kdd.yaml
kubectl apply -f calico.yaml

# Join nodes to the cluter
kubeadm token list

kubeadm token create

openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt \
    | openssl rsa -pubin -outform der 2>/dev/null \
    | openssl dgst -sha256 -hex | sed 's/^.* //'

kubeadm join 172.25.0.15:6443 --token [token] \
    --discovery-token-ca-cert-hash [hash]