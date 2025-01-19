```bash
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 10000 -nodes -subj "/C=XX/ST=StateName/L=CityName/O=CompanyName/OU=CompanySectionName/CN=CommonNameOrHostname"
```
openssl ecparam -name prime256v1 -genkey -noout -out ca.key

openssl req -new -x509 -sha256 -key ca.key -out ca.crt

openssl ecparam -name prime256v1 -genkey -noout -out server.key

openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 1000 -sha256 -extfile server-extensions.txt

openssl ecparam -name prime256v1 -genkey -noout -out client1.key

openssl req -new -sha256 -key client1.key -out client1.csr

openssl x509 -req -in client1.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client1.crt -days 1000 -sha256 -extfile client-extensions.txt
