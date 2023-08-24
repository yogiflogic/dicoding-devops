# Sebelum lanjut, hapus Pod, dan Service yang pernah dibuat terlebih dahulu
kubectl delete pod mypod && kubectl delete service webserver

# Lanjut, deploy berkas manifest namespace
kubectl apply -f namespace.yaml

kubectl get namespace

# kita buat Pod dan Service pada Namespace webserver-ns
kubectl apply -f pod.yaml -n webserver-ns && kubectl apply -f service.yaml -n webserver-ns

# periksa detail Pod dan Service, sekarang berada di Namespace webserver-ns
# pod
kubectl describe pod mypod -n webserver-ns
# service
kubectl describe service webserver -n webserver-ns

# melihat daftar object yang bisa disimpan pada namespace
kubectl api-resources --namespaced=true

# melihat daftar object yang tidak bisa disimpan pada namespace
kubectl api-resources --namespaced=false