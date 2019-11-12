# You MUST install a pod network add-on so that your pods can communicate with each other.
  
kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml

# Remove the taints on the master so that you can schedule pods on it.

kubectl taint nodes --all node-role.kubernetes.io/master-

# A delay is required for the application of the settings.

sleep 30s
