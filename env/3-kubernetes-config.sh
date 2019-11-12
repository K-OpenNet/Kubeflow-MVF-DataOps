# If swap is not disabled, kubelet service will not start on the masters and nodes. 
# First, you need to edit kubernetes configure file 
sudo sed -i '$a\Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# For Master
# Run the following command to disable swap immediately.
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
