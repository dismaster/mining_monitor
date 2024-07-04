#!/bin/bash

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

yes | pkg update > /dev/null 2>&1
yes | pkg upgrade > /dev/null 2>&1
yes | pkg install netcat-openbsd jq termux-api iproute2 > /dev/null 2>&1
echo -e "${R}-> ${NC}Software Update/Packages: ${LG}COMPLETE${NC}"

echo -e ""
while :     ## loop continually
do
    read -p "${R}-> ${LP} Enter Rig-Password: ${NC}" password
    read -p "${R}-> ${LP} Re-Enter Rig-Password: ${NC}" verify
    
    if [ "$password" = "$verify" ]      ## check for match
    then
        printf "\nPassword Successful!!\n"
        break;
    fi
    
    ## otherwise loop again
    printf "\nerror: Password does not match. Please try again.\n\n" >&2
done
