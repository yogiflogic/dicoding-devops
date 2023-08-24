
# deployment
# kita bisa membuat beberapa object dengan memisahkannya menggunakan “---”
kubectl apply -f data-tier.yaml -f app-tier.yaml -f support-tier.yaml -n deployments

# periksa status deployment
kubectl get deployment -n deployments

# periksa pod
kubectl get pod -n deployments

# Untuk melihat bagaimana aplikasi beraksi, cek logs pada container poller
# Sesuaikan support-tier-54564dbbc6-v5lv6 dengan nama Pod pada cluster sendiri
# Opsi -f (follow) digunakan untuk melihat aplikasi beraksi secara real time
kubectl logs support-tier-66647868c8-tmltx poller -f -n deployments

# ubah replica set app-tier.yaml dan deploy kembali
kubectl apply -f app-tier.yaml -n deployments

# hapus salah satu pod
kubectl delete pod app-tier-546b9975bc-6xtnp -n deployments

#detail informasi
kubectl describe service app-tier -n deployments
