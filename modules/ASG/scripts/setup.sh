#!/bin/bash

sudo su

cd /var/run
rm -f yum.pid
yum update -y

yum install -y ssm-agent
systemctl enable --now amazon-ssm-agent

cd ~

amazon-linux-extras enable nginx1

yum clean metadata

yum -y install nginx

unalias cp

## COPY OVER nginx.conf

aws s3 cp s3://data-bucket-32567czd6543rfdbd/nginx.conf /etc/nginx/nginx.conf

## OPENSSL

openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=UK/ST=_/L=_/O=_/CN=example" -keyout ca.key -out ca.crt

## SERVER

openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=UK/ST=_/L=_/O=_/CN=example" -keyout server.key

openssl req -new -key server.key -out server.csr -subj "/C=UK/ST=_/L=_/O=_/OU=_/CN=example"

openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt

# USER

openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=UK/ST=_/L=_/O=_/CN=example" -keyout user.key

openssl req -new -key user.key -out user.csr -subj "/C=UK/ST=_/L=_/O=_/OU=_/CN=example"

openssl x509 -req -days 365 -in user.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out user.crt

# Moving certs to correct location

mkdir /etc/nginx/certs

mkdir /etc/nginx/certs/private

cp server.crt /etc/nginx/certs/server.crt

cp server.key /etc/nginx/certs/private/server.key

cp ca.crt /etc/nginx/certs/private/ca.crt

nginx

nginx -s reload
