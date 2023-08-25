#add resource memory RAM minikube
minikube config set memory 4000

#Instalasi Istio :

curl -L https://istio.io/downloadIstio | sh -
cd istio-1.17.1
export PATH=$PWD/bin:$PATH
or
nano .bashrc
export PATH="$PATH:/home/xxxx/istio-1.18.2/bin"

#menginstal Istio mengunakan profile bertipe demo
istioctl install --set profile=demo -y

#Deploy Aplikasi Bookinfo :
kubectl label namespace default istio-injection=enabled

kubectl apply -f bookinfo.yaml

#Verifikasi bahwa semuanya berfungsi normal
kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"

#hasil dari response
#<title>Simple Bookstore App</title>

#Memasang Istio Ingress Gateway :
kubectl apply -f bookinfo-gateway.yaml

#memastikan tak ada issue pada konfigurasi Istio
istioctl analyze

#Minikube tunnel yang akan mengirim traffic ke Istio Ingress Gateway
#Proses ini akan memberikan kita sebuah external load balancer (EXTERNAL-IP)
#untuk Kubernetes service bernama istio-ingressgateway di dalam namespace istio-system.
minikube tunnel

#simpan nilai-nilai yang diperlukan ke dalam environment variable di terminal window sebelumnya
#(sambil proses minikube tunnel tetap berjalan di terminal window yang baru)
#export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
#export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
#export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

#memastikan IP address dan port untuk Istio Ingress Gateway sukses tersimpan ke tiap environment variable.
echo "$INGRESS_HOST" "$INGRESS_PORT" "$SECURE_INGRESS_PORT"
127.0.0.1 80 443

#menentukan nilai untuk environment variable bernama GATEWAY_URL dari nilai IP address dan port Istio Ingress Gateway sebelumnya.
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

#Cek apakah nilai IP address dan port untuk Istio Ingress Gateway sudah benar tersimpan pada GATEWAY_URL
echo "$GATEWAY_URL"

#periksa apakah aplikasi Bookinfo sudah bisa diakses dari luar cluster
#mendapatkan alamat eksternal dari aplikasi Bookinfo (kemudian akses alamat tersebut via web browser)
#Pastikan halaman produk dari aplikasi Bookinfo tampil
echo "http://$GATEWAY_URL/productpage"

# Mengakses Dashboard :

#Instal semua addons yang ada di direktori samples/addons
kubectl apply -f samples/addons

#pastikan status rollout untuk Kiali sudah berhasil
kubectl rollout status deployment/kiali -n istio-system

#akses Kiali dashboard
#Pada menu navigasi sebelah kiri, pilih Graph. Klik Select Namespaces drop down, lalu centang default
#Agar mempermudah proses visualisasi trace data, ubah Traffic metrics per refresh menjadi Last 1h dan Refresh interval menjadi Every 10s
istioctl dashboard kiali
http://localhost:20001/kiali


#untuk melihat trace data, kita harus mengirim sejumlah request ke aplikasi
#Dengan default sampling rate sebesar 1%, kita harus mengirim setidaknya 100 request sebelum trace pertama dapat terlihat
#untuk mengirim 100 request ke aplikasi (tepatnya ke productpageservice)
#coba hentikan dulu Kiali dashboard di terminal (dengan kombinasi CTRL+C), kemudian jalankan perintah berikut
for i in $(seq 1 100); do curl -s -o /dev/null "http://$GATEWAY_URL/productpage"; done

#jalankan kembali Kiali dashboard
istioctl dashboard kiali

#Menerapkan Request Routing :
