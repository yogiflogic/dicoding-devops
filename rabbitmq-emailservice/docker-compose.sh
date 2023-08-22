docker-compose up -d
docker-compose down

# open http://localhost:15673

#login RabbitMq
Username: guest
Password: guest

#mengirim sejumlah message ke queue
#Perintah ini akan mengirim 15 message ke queue menggunakan bash loop
docker-compose exec consumer /bin/bash -c 'for ((i=1;i<=15;i++)); do node producer.js; done'

#Semua message tersebut kemudian akan diproses oleh consumer (yang berjalan dalam container yang sama)
#lihat logs dari consumer service
docker-compose logs -f consumer