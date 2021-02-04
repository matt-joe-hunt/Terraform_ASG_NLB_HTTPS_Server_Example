## Introduction



# TEST

curl -k -v https://localhost:443

curl -k -v http://localhost:80

curl -k -v --key ./user.key --cert ./user.crt https://localhost:443

curl -k -v --key ./server.key --cert ./server.crt https://localhost:443


openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=UK/ST=_/L=_/O=_/CN=example" -keyout ca1.key -out ca1.crt

openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=UK/ST=_/L=_/O=_/CN=example" -keyout user1.key

openssl req -new -key user1.key -out user1.csr -subj "/C=UK/ST=_/L=_/O=_/OU=_/CN=example"

openssl x509 -req -days 365 -in user1.csr -CA ca1.crt -CAkey ca1.key -set_serial 01 -out user1.crt

curl -k -v --key ./user1.key --cert ./user1.crt https://localhost:443
