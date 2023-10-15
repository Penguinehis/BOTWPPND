#!/bin/bash
[[ $(awk -F" " '{print $2}' /usr/lib/botchave) == "@ntechsystem" ]] &>/dev/null && {
while :
do
[[ "$(date +%d)" != "$(cat /etc/botvendas/RESET)" ]] && {
   	echo $(date +%d) > /etc/botvendas/RESET
   	rm -rf /etc/botvendas/whatsappbot/usuarios/database_users_testers.json
  }
  bash /etc/botvendas/updatepagamentos.sh
  sleep 10
done
} || clear && echo -e "\E[41;1;37m         VOCÊ NÃO TEM PERMISSÃO        \E[0m" && sleep 4 && exit 0
