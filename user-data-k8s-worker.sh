#!/bin/bash
apt-get remove docker docker-engine docker.io containerd runc # desinstalar posibles versiones de docker 
apt-get update # actualizar repositorios 
apt-get -y install ca-certificates curl gnupg lsb-release # instalar dependencias 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg  # añadir repositorio de docker 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
systemctl start docker
systemctl enable docker
echo -e '{\n    "exec-opts": ["native.cgroupdriver=systemd"]\n}' >> /etc/docker/daemon.json
systemctl restart docker
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

apt-get update 
apt-get install -y apt-transport-https ca-certificates curl
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
systemctl start kubelet
systemctl enable kubelet
kubeadm reset -f
echo 1 > /proc/sys/net/ipv4/ip_forward

#kubeadm join 10.0.3.10:6443 --token ejgmtl.014dnoigzw6mrvds --discovery-token-ca-cert-hash sha256:4b0d25347395ae2dce19fb3fc74cb617b0f92b3490d9df90047452fb9a4f6fe3