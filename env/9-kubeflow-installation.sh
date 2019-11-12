# Kubeflow installation processes from https://kubeflow.org
# Prerequisites for kubeflow installation - Deploy MetalLB

kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.1/manifests/metallb.yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 192.168.1.240-192.168.1.250
EOF

# Install kfctl 0.6.2v with kfctl_existing_arrikto

wget https://github.com/kubeflow/kubeflow/releases/download/v0.6.2/kfctl_v0.6.2_linux.tar.gz
tar -xvf kfctl_v0.6.2_linux.tar.gz

# Add kfctl to PATH, to make the kfctl binary easier to use

export KFAPP="kubeflow1"
export PATH=$PATH:`pwd | awk -F / '{print $NF}'`/$KFAPP
export CONFIG="https://raw.githubusercontent.com/kubeflow/kubeflow/v0.6-branch/bootstrap/config/kfctl_existing_arrikto.0.6.2.yaml"

# Specify credentials for the default user

export KUBEFLOW_USER_EMAIL="admin@kubeflow.org"
export KUBEFLOW_PASSWORD="admin1234"

# Deploy kubeflow

./kfctl init ${KFAPP} --config=${CONFIG} -V
cp kfctl kfctl_temp
sudo mv kfctl_temp ./$KFAPP/kfctl
cd ${KFAPP}
./kfctl generate all -V
./kfctl apply all -V
sleep 1m

