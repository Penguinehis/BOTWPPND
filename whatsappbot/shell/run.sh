#!/bin/bash
[[ $(awk -F" " '{print $2}' /usr/lib/botchave) == "@ntechsystem" ]] &>/dev/null && {
Bold=$(tput bold)
Norm=$(tput sgr0)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Yellow=$(tput setaf 3)
Blue=$(tput setaf 4)
dir=$(pwd | sed 's/shell//g')
if [[ ! -d /etc/botvendas/whatsappbot/auth_info_baileys ]]
then
echo ""
cat << FECHA
========================== 
    ${Yellow}GERANDO QR-CODE${Norm} 
==========================
FECHA
sleep 3
node /etc/botvendas/whatsappbot/index.js
fi
if [[ -d /etc/botvendas/whatsappbot/auth_info_baileys ]]
then
echo ""
cat << FECHA
========================== 
        ${Green}BOT ONLINE${Norm}
==========================
FECHA
screen -r -S twabot -X quit >/dev/null 2>&1
screen -r -S tbotzapcheck -X quit >/dev/null 2>&1
sleep 3
screen -dmS twabot node /etc/botvendas/whatsappbot/ZapStart.js
screen -dmS tbotzapcheck bash /etc/botvendas/crontab.sh
bvendas
exit 0
fi
} || clear && echo -e "\E[41;1;37m         VOCÊ NÃO TEM PERMISSÃO        \E[0m" && sleep 4 && exit 0
