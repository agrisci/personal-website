#!/bin/bash

# Add a 2G swapfile
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

# Install Docker Engine
apt-get update && apt-get upgrade -y
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
usermod -aG docker ubuntu

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

# Install cri-dockerd
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.4/cri-dockerd_0.3.4.3-0.ubuntu-jammy_amd64.deb
dpkg -i cri-dockerd_0.3.4.3-0.ubuntu-jammy_amd64.deb

# Install conntrack
apt-get install conntrack -y

# Install crictl
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.27.1/crictl-v1.27.1-linux-amd64.tar.gz
tar zxvf crictl-v1.27.1-linux-amd64.tar.gz -C /usr/local/bin
rm -f crictl-v1.27.1-linux-amd64.tar.gz

# Install minikube and cni-plugins
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
curl -LO "https://github.com/containernetworking/plugins/releases/download/v1.3.0/cni-plugins-linux-amd64-v1.3.0.tgz"
mkdir -p /opt/cni/bin
tar -xf cni-plugins-linux-amd64-v1.3.0.tgz -C /opt/cni/bin

# Create and start minikube systemd service
echo "[Unit]
Description=Start Minikube Cluster
After=docker.service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/minikube start --listen-address='0.0.0.0' --addons=ingress --extra-config=kubeadm.ignore-preflight-errors=NumCPU --force --cpus=1 --embed-certs=true --disable-metrics=true --apiserver-names=`curl -s http://169.254.169.254/latest/meta-data/public-hostname`
RemainAfterExit=true
ExecStop=/usr/local/bin/minikube stop
StandardOutput=journal
User=ubuntu
Group=ubuntu

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/minikube.service
systemctl enable minikube.service
systemctl start minikube.service