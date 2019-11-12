# This script will automatically perform the following steps 1 through 9 of the AI cluster installation script.
# Therefore, you do not need to run 1 to 10 times, you only need to run this script.

sudo ./1-docker-installation.sh
sleep 3s

sudo ./2-kubernetes-installation.sh 
sleep 3s

sudo ./3-kubernetes-config.sh 
sleep 3s

sudo ./4-running-k8s-master.sh
sleep 3s

sudo ./5-network-addon-calico.sh 
sleep 3s

sudo ./6-rbd-deployment.sh
sleep 3s

sudo ./7-config-storageclass.sh
sleep 3s

sudo ./8-config-gpu.sh 
sleep 3s

sudo ./9-kubeflow-installation.sh
sleep 3s

./10-permission-issue.sh
