#!/bin/bash
curl http://192.168.100.43:8500/v1/kv/bookstack.conf | jq -r '.[].Value' | base64 -d > /etc/nginx/conf.d/bookstack.conf
curl http://192.168.100.43:8500/v1/kv/nginx.conf | jq -r '.[].Value' | base64 -d > /etc/nginx/nginx.conf
service nginx start
while true
do
        sleep 1000
done