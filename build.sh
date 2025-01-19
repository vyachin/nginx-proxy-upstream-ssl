#!/bin/bash

BOLD=$(tput bold)
CLEAR=$(tput sgr0)

iterate=( )
for dir in "${iterate[@]}"; do
  [[ ! -d "$dir" ]] && mkdir -p "$dir" \
  && echo -e "${BOLD}directory '$dir' was created ${CLEAR}"
done

echo -e "${BOLD}Generating RSA AES-256 Private Key for Root Certificate Authority${CLEAR}"
openssl genrsa -out Root.CA.example.llc.key 4096

echo -e "${BOLD}Generating Certificate for Root Certificate Authority${CLEAR}"
openssl req -x509 -new -nodes -key Root.CA.example.llc.key -sha256 -days 1825 -out Root.CA.example.llc.pem

echo -e "${BOLD}Generating RSA Private Key for Server Certificate${CLEAR}"
openssl genrsa -out example.llc.server.key 4096

echo -e "${BOLD}Generating Certificate Signing Request for Server Certificate${CLEAR}"
openssl req -new -key example.llc.server.key -out example.llc.server.csr

echo -e "${BOLD}Generating Certificate for Server Certificate${CLEAR}"
openssl x509 -req -in example.llc.server.csr -CA Root.CA.example.llc.pem -CAkey Root.CA.example.llc.key -CAcreateserial -out example.llc.server.crt -days 1825 -sha256

echo -e "${BOLD}Generating RSA Private Key for Client Certificate${CLEAR}"
openssl genrsa -out example.llc.client.key 4096

echo -e "${BOLD}Generating Certificate Signing Request for Client Certificate${CLEAR}"
openssl req -new -key example.llc.client.key -out example.llc.client.csr

echo -e "${BOLD}Generating Certificate for Client Certificate${CLEAR}"
openssl x509 -req -in example.llc.client.csr -CA Root.CA.example.llc.pem -CAkey Root.CA.example.llc.key -CAcreateserial -out example.llc.client.crt -days 1825 -sha256

echo "Done!"
