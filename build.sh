#!/bin/bash

BOLD=$(tput bold)
CLEAR=$(tput sgr0)
BITS=4096
DAYS=10000

echo -e "${BOLD}Generating RSA Private Key for Root Certificate Authority${CLEAR}"
openssl genrsa -out Root.CA.example.llc.key $BITS

echo -e "${BOLD}Generating Certificate for Root Certificate Authority${CLEAR}"
openssl req -x509 -new -nodes -key Root.CA.example.llc.key -sha256 -days $DAYS -out Root.CA.example.llc.pem -subj "/C=US/ST=Acme State/L=Acme City/O=Acme Inc./CN="

echo -e "${BOLD}Generating RSA Private Key for Server Certificate${CLEAR}"
openssl genrsa -out example.llc.server.key $BITS

echo -e "${BOLD}Generating Certificate Signing Request for Server Certificate${CLEAR}"
openssl req -new -key example.llc.server.key -out example.llc.server.csr -subj "/C=US/ST=Acme State/L=Acme City/O=Acme Inc./CN=web"

echo -e "${BOLD}Generating Certificate for Server Certificate${CLEAR}"
openssl x509 -req -in example.llc.server.csr -CA Root.CA.example.llc.pem -CAkey Root.CA.example.llc.key -CAcreateserial -out example.llc.server.crt -days $DAYS -sha256

echo -e "${BOLD}Generating RSA Private Key for Client Certificate${CLEAR}"
openssl genrsa -out example.llc.client.key $BITS

echo -e "${BOLD}Generating Certificate Signing Request for Client Certificate${CLEAR}"
openssl req -new -key example.llc.client.key -out example.llc.client.csr -subj "/C=US/ST=Acme State/L=Acme City/O=Acme Inc./CN="

echo -e "${BOLD}Generating Certificate for Client Certificate${CLEAR}"
openssl x509 -req -in example.llc.client.csr -CA Root.CA.example.llc.pem -CAkey Root.CA.example.llc.key -CAcreateserial -out example.llc.client.crt -days $DAYS -sha256 -subj "/C=US/ST=Acme State/L=Acme City/O=Acme Inc./CN="

echo "Done!"
