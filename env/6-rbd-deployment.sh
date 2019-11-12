# RBD deployment processes

git clone https://github.com/kubernetes-incubator/external-storage

sudo sed -i '$a\  - apiGroups: [""]' /home/netcs/external-storage/ceph/rbd/deploy/rbac/clusterrole.yaml
sudo sed -i '$a\    resources: ["secrets"]' /home/netcs/external-storage/ceph/rbd/deploy/rbac/clusterrole.yaml
sudo sed -i '$a\    verbs: ["list", "get"]' /home/netcs/external-storage/ceph/rbd/deploy/rbac/clusterrole.yaml

cd /home/netcs/external-storage/ceph/rbd/deploy
NAMESPACE=default
sudo sed -r -i "s/namespace: [^ ]+/namespace: $NAMESPACE/g" ./rbac/clusterrolebinding.yaml ./rbac/rolebinding.yaml
kubectl -n $NAMESPACE apply -f ./rbac
cd
