#!/bin/bash

function ProgressBar {
        let _progress=(${1}*100/${2}*100)/100
        let _done=(${_progress}*4)/10
        let _left=40-$_done
        _done=$(printf "%${_done}s")
        _left=$(printf "%${_left}s")
        printf "\rProgress : [${_done// /#}${_left// /-}] ${_progress}%%"
}


NC='\033[0m'
R='\033[0;31m'   #'0;31' is Red's ANSI color code
G='\033[0;32m'   #'0;32' is Green's ANSI color code
Y='\033[1;33m'   #'1;32' is Yellow's ANSI color code
B='\033[0;34m'   #'0;34' is Blue's ANSI color code
P='\033[0;35m'
LG='\033[1;32m'
LB='\033[1;34m'
LP='\033[1;35m'
LC='\033[1;36m'

echo -e "${LC}#############################################${NC}"
echo -e "${LC}#            ${LB}VERUS ${LP}Miner ${G}MONITOR            ${LC}#${NC}"
echo -e "${LC}#                                           ${LC}#${NC}"
echo -e "${LC}#              v1.0 | by Ch3ckr             ${LC}#${NC}"
echo -e "${LC}#############################################${NC}"

echo -e "\n"

while :     ## loop continually
do
    read -p "Enter Rig-Password    : " password
    read -p "Re-Enter Rig-Password : " verify
    
    ## empty password
    if [ -z "$password" ]
    then
      >&2
    else 
      if [ "$password" = "$verify" ]      ## check for match
      then
          break;
      fi
    fi
  
    ## otherwise loop again
    printf "\nerror: Password does not match. Please try again.\n\n" >&2
done
echo -e "${R}-> ${NC}Password: ${LG}MATCH${NC}"

yes | pkg update > /dev/null 2>&1
sleep 0.1
ProgressBar 5 100
yes | pkg upgrade > /dev/null 2>&1
ProgressBar 10 100
yes | pkg install cronie termux-services libjansson screen openssh netcat-openbsd jq termux-api iproute2 tsu shc > /dev/null 2>&1
ProgressBar 20 100
echo -e "${R}-> ${NC}Software Update/Packages: ${LG}COMPLETE${NC}"

ProgressBar 30 100
wget https://raw.githubusercontent.com/dismaster/mining_monitor/main/monitor.sh > /dev/null 2>&1
ProgressBar 40 100
wget https://raw.githubusercontent.com/dismaster/mining_monitor/main/vcgencmd > /dev/null 2>&1
ProgressBar 50 100
chmod 777 monitor.sh > /dev/null 2>&1
chmod 777 vcgencmd > /dev/null 2>&1
(crontab -l 2>/dev/null; echo "*/1 * * * * ~/monitor.sh") | crontab - > /dev/null 2>&1
ProgressBar 60 100
sed -i -e "s/test123/$password/g" monitor.sh

shc -f monitor.sh > /dev/null 2>&1
rm monitor.sh > /dev/null 2>&1
rm monitor.sh.x.c > /dev/null 2>&1
mv monitor.sh.x monitor.sh > /dev/null 2>&1
ProgressBar 80 100
echo -e "${R}-> ${NC}Monitor Script: ${LG}COMPLETE${NC}"
ProgressBar 100 100
