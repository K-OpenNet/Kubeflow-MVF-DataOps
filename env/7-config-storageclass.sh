# This is the process of installing Ceph storageclass using the network built in the Netcs lab.
# If you don't use the netcs lab network, you need to construct the storageclass separately in your environment.

# Create a storageclass and apply secrets
# Settings for admin's secret

cat <<EOF | kubectl apply -f -
apiVersion: v1
data:
  key: QVFEcFp5TmJUWjZIT3hBQTFQRTRZenBra2I3TGN6YUpZT3RQa0E9PQ==
kind: Secret
metadata:
  name: ceph-secret-admin
  namespace: default
type: kubernetes.io/rbd
EOF

# Settings for user's secret

cat <<EOF | kubectl apply -f -
apiVersion: v1
data:
  key: QVFCZWZJSmI2bUNlQWhBQXd2Y0xUOFBXQWphVFpUOURzUlhZQkE9PQ==
kind: Secret
metadata:
  name: ceph-secret-user
  namespace: default
type: kubernetes.io/rbd
EOF

# Storageclass rbd-ssd

cat <<EOF | kubectl apply -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: rbd-ssd
parameters:
  adminId: admin
  adminSecretName: ceph-secret-admin
  adminSecretNamespace: default
  fsType: ext4
  imageFeatures: layering
  imageFormat: "2"
  monitors: netcs-cloud-ceph-1p.nm.gist.ac.kr:6789,netcs-cloud-ceph-2p.nm.gist.ac.kr:6789,netcs-cloud-ceph-3p.nm.gist.ac.kr:6789,netcs-cloud-ceph-4p.nm.gist.ac.kr:6789
  pool: netcs-cloud-k8s-ssd
  userId: kube
  userSecretName: ceph-secret-user
  userSecretNamespace: default
provisioner: ceph.com/rbd
reclaimPolicy: Delete
volumeBindingMode: Immediate
EOF


# The installation command for rbd dynamic provisioning
# For master, worker node
sudo apt-get install ceph-common
