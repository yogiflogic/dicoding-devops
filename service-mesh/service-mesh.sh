#Instalasi Istio :
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

minikube tunnel

#simpan nilai-nilai yang diperlukan ke dalam environment variable di terminal window sebelumnya
#(sambil proses minikube tunnel tetap berjalan di terminal window yang baru)
#export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
#export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
#export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

#memastikan IP address dan port untuk Istio Ingress Gateway sukses tersimpan ke tiap environment variable.
echo "$INGRESS_HOST" "$INGRESS_PORT" "$SECURE_INGRESS_PORT"
127.0.0.1 80 443

#menentukan nilai untuk environment variable bernama GATEWAY_URLdari nilai IP address dan port Istio Ingress Gateway sebelumnya.
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