# HPA
# Selain secara deklaratif, kita juga bisa menggunakan HPA dengan menjalankan perintah “kubectl autoscale …”.
kubectl apply -f metric-server.yaml

# konfirmasi bahwa Metrics Server sudah berjalan sebagaimana mestinya
kubectl get pods -n kube-system

# melihat daftar penggunaan CPU dan memory untuk setiap Pod pada suatu Namespace
kubectl top pods -n deployments

# setelah edit app-tier
kubectl apply -f app-tier.yaml -n deployments

# periksa kondisi Deployment app-tier secara real-time
kubectl get deployment -n deployments --watch

# Periksa HPA lebih detail
kubectl describe hpa -n deployments

# HPA dalam versi lebih ringkas
kubectl get hpa -n deployments

# Periksa kondisi Deployment
kubectl get deployment -n deployments
