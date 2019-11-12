# Settings for running the kubernetes master
sudo systemctl daemon-reload
sudo systemctl restart kubelet
sudo echo y | sudo kubeadm reset
sudo kubeadm init  --ignore-preflight-errors=all
sleep 3s
# Run these commands to make kubectl work for your non-root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Commands to add nodes. 
# kubeadm join <ip address> --token <token> --discovery-token-ca-cert-hash <hash> --ignore-preflight-errors=all