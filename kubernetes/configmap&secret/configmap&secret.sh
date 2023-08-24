# ConfigMap dan Secret
# dengan begini, kita dapat mengonfigurasi Redis secara terpisah tanpa harus menyentuh Deployment manifest ini lagi ke depannya
kubectl apply -f data-tier-configmap.yaml -f data-tier.yaml -n deployments

kubectl get pod -n deployments

kubectl exec -it -n deployments data-tier-d7747df69-f99tt -- /bin/bash

cat /etc/redis/redis.conf

kubectl apply -f app-tier-secret.yaml -n deployments

# Setelah itu, coba lihat informasi detail dari Secret tersebut.
kubectl describe secret app-tier-secret -n deployments

# Perhatikan bahwa kita menghapus bagian resources. Ini dilakukan untuk menghindari kegagalan peluncuran Pod karena insufficient cpu.

kubectl apply -f app-tier.yaml -n deployments

# Cek kondisi Pod dan catat salah satu nama Pod untuk app-tier.
kubectl get pod -n deployments

# jalankan perintah env pada salah satu app-tier container untuk melihat semua environment variable yang dimilikinya
# Lihat environment variable untuk PASSWORD. Nilai dari password yang semula base64 encoded pada Secret,
# telah diubah oleh Kubernetes menjadi decoded saat menjalankan container. Tampak jelas bahwa ternyata nilainya adalah admin.
kubectl exec -n deployments app-tier-75d875d498-8dvq8 -- env
