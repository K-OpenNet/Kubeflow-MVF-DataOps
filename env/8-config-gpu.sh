# Set rbd Storageclass to default for kubeflow
  
kubectl patch storageclass rbd-ssd -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

# Device plugin installation processes to use GPU

# Install the repository for your distribution by following the instructions

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update

# Install the nvidia-docker2 package and reload the Docker daemon configuration

sudo apt-get install nvidia-docker2 -y
sudo pkill -SIGHUP dockerd

# Time for waiting docker recovery
sleep 1m

# The Setting for nvidia-docker2

sudo sed -i '2 i\    "default-runtime": "nvidia",' /etc/docker/daemon.json
sudo systemctl restart docker

# Time for waiting docker restart
sleep 1m

# NVIDIA-device-plugin installation
# If you do not have a GPU and run the following command, you will get a container initialize error.

kubectl create -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/1.0.0-beta/nvidia-device-plugin.yml
