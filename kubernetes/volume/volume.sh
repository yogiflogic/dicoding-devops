# volume & PV/PVC
kubectl apply -f stateful-ns.yaml

kubectl apply -f mysql-pv-pvc.yaml -n stateful-ns

kubectl apply -f mysql-svc-deploy.yaml -n stateful-ns

kubectl describe deployment mysql -n stateful-ns

kubectl describe pvc mysql-pv-claim -n stateful-ns

kubectl describe pv mysql-pv-volume -n stateful-ns

# mengakses aplikasi MySQL. Jalankan sebuah MySQL client untuk terhubung ke server
# Perintah di bawah akan membuat Pod baru yang menjalankan MySQL client dan menghubungkannya ke MySQL server melalui Service
kubectl run -it --rm --image=mysql:5.6 --restart=Never --namespace=stateful-ns mysql-client -- mysql -h mysql -ppassword

# Pertama, buat database bernama my_database

CREATE DATABASE my_database;

USE my_database;

# Buatlah sebuah tabel dengan ketentuan sebagai berikut
#CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20), species VARCHAR(20), sex CHAR(1), birth DATE, death DATE);

SHOW TABLES;

DESCRIBE pet;

# masukkan informasi di bawah ini ke tabel tersebut (boleh disesuaikan)

#INSERT INTO pet VALUES ('Oyen', 'Budi', 'Kucing', 'J', '1945-08-17', NULL);

#SELECT * FROM pet;

exit

kubectl get pod -n stateful-ns

# Catat nama Pod yang muncul

kubectl delete pod mysql-79c846684f-c5r8k -n stateful-ns

# Lihat status Pod kembali, Kubernetes akan menambahkan Pod baru (namanya akan berbeda)
kubectl get pod -n stateful-ns

# Jalankan MySQL client kembali agar kita bisa akses MySQL server
kubectl run -it --rm --image=mysql:5.6 --restart=Never --namespace=stateful-ns mysql-client -- mysql -h mysql -ppassword

#Periksa apakah database yang Anda buat masih tersedia
SHOW DATABASES;

USE my_database;

# Periksa apakah tabel yang kita buat sebelumnya masih ada.

SHOW TABLES;

# Lihat juga apakah data yang tersimpan pada tabel tersebut masih ada

#SELECT * FROM pet;

# Terbukti bahwa Persistent Volume mampu mempertahankan data Anda meski Pod telah dihapus.
