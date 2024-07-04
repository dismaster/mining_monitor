#!/bin/bash

rig_pw="admin123"


hw_model=$(getprop ro.product.model)
hw_brand=$(getprop ro.product.brand)
#bat_stats=$(termux-battery-status | tr -d '\n' | tr -d ' ' | sed -r 's/\"/\\\"/g')
bat_stats=$(termux-battery-status | tr -d '\n' | tr -d ' ' | jq)
ip_addr=$(ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127.0.0.1)
ccminer_summary=$(echo 'summary' | nc 127.0.0.1 4068 | tr -d '\0' | sed -r 's/=/\":\"/g; s/;/\",\"/g' | sed 's/|/\"}/g' | sed 's/^/{\"/g' | jq)
ccminer_pool=$(echo 'pool' | nc 127.0.0.1 4068 | tr -d '\0' | sed -r 's/=/\":\"/g; s/;/\",\"/g' | sed 's/|/\"}/g' | sed 's/^/{\"/g' | jq)

curl -d "hw_model=$hw_model&hw_brand=$hw_brand&ip=$ip_addr&password=$rig_pw&battery=$bat_stats&summary=$ccminer_summary&pool=$ccminer_pool" -H "Content-Type: application/x-www-
form-urlencoded" -X POST https://api.rg3d.eu:8443/api.php --insecure

echo -e ""
