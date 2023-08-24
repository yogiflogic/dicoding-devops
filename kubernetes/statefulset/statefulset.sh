# statefulset

kubectl create namespace statefulset-ns

kubectl apply -f mysql-secret.yaml -n statefulset-ns

# buatlah berkas manifest untuk Persistent Volume dengan nama mysql-pv.yaml.

kubectl apply -f mysql-pv.yaml -n statefulset-ns

# untuk Persistent Volume Claim
mysql-pvc.yaml

kubectl apply -f mysql-pvc.yaml -n statefulset-ns

kubectl apply -f mysql-service.yaml -n statefulset-ns

kubectl apply -f mysql-statefulset.yaml -n statefulset-ns

kubectl get statefulset,service,po,pv,pvc -n statefulset-ns

# periksa semua object yang dibuat.
kubectl get statefulset,service,po,pv,pvc -n statefulset-ns

# cek juga semua Pod yang dibuat oleh StatefulSet
kubectl get pod -o wide -n statefulset-ns

# hapus salah satu Pod, misalnya mysql-0
kubectl delete pod mysql-0 -n statefulset-ns

# periksa lagi kondisi dari Pod Anda
kubectl get pod -o wide -n statefulset-ns