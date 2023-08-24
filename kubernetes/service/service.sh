kubectl apply -f service.yaml

kubectl get service

kubectl describe service webserver

# Ada beberapa cara untuk mendapatkan Node IP address. Ini adalah cara pertama. Catat InternalIP yang muncul
kubectl describe node | grep -i address -A 1

# Ada juga cara lain untuk mendapatkan Node IP address. Karena kita menggunakan minikube, Node IP address bisa didapatkan dengan perintah ini
minikube ip

# akses aplikasi <NodeIP>:<NodePort>
curl http://192.168.39.189:32599