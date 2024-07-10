#!/bin/bash
rig_pw="test123"

hw_model=$(cat /sys/firmware/devicetree/base/model | awk '{print $1;}')
hw_brand=$(cat /sys/firmware/devicetree/base/model | awk '{print $2 $3;}')

bat_stats=""

ip_addr_wlan0=$(ip -4 addr show wlan0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
ip_addr_eth0=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

if [ -z "$ip_addr_wlan0"]
then 
  ip_addr=$ip_addr_eth0
else
  ip_addr=$ip_addr_wlan0
  
ccminer_summary=$(echo 'summary' | nc 127.0.0.1 4068 | tr -d '\0' | sed -r 's/=/\":\"/g; s/;/\",\"/g' | sed 's/|/\"}/g' | sed 's/^/{\"/g' | jq)
ccminer_pool=$(echo 'pool' | nc 127.0.0.1 4068 | tr -d '\0' | sed -r 's/=/\":\"/g; s/;/\",\"/g' | sed 's/|/\"}/g' | sed 's/^/{\"/g' | jq)

cpu_temp=$(~/vcgencmd measure_temp 2>/dev/null | tr -d '\0' | sed 's/^/{\"/g' | sed -r 's/=/\":\"/g; s/;/\",\"/g' | sed "s/'C/\"}/g" | sed 's/""/"0"/g' | jq)

curl -d "hw_model=$hw_model&hw_brand=$hw_brand&ip=$ip_addr&password=$rig_pw&battery=$bat_stats&summary=$ccminer_summary&pool=$ccminer_pool&cpu_temp=$cpu_temp" -H "Content-Type: application/x-www-form-urlencoded" -X POST https://api.rg3d.eu:8443/api.php --insecure
