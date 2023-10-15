#!/bin/bash
[[ $(awk -F" " '{print $2}' /usr/lib/botchave) == "@ntechsystem" ]] &>/dev/null && {
whatsappbot.payment(){
local resultado=$(
curl -s -X GET \
'https://api.mercadopago.com/v1/payments/'$1 \
-H 'Authorization: Bearer '$(cat /etc/botvendas/info-mp)
)
echo $resultado
}
if [[ -f /etc/botvendas/whatsappbot/usuarios/pedidos.json ]]
then
while :
do
database=$(cat /etc/botvendas/whatsappbot/usuarios/pedidos.json | jq '.[]')
total=$(cat /etc/botvendas/whatsappbot/usuarios/pedidos.json | jq '. | length')
result=$(echo  $database | jq 'select(.status == "pending")')
[[ $result != '0' ]] && {
id=$(echo $result | jq '.order_id')
for i in $id; do
pagamento_status=$(whatsappbot.payment $i)
current_status=$(echo $pagamento_status | jq -r '.status')
if [[ $current_status == "approved" ]]
then
user=$(echo  $database | jq 'select(.order_id == '$i')')
chat_id=$(echo $user  | jq -r '.chat_id')
node /etc/botvendas/whatsappbot/Pay_Update.js $chat_id $i
echo "MENSAGEM ENVIADA E SCRIPT FINALIZADO"
fi
done
exit;
}
done
fi
} || clear && echo -e "\E[41;1;37m         VOCÊ NÃO TEM PERMISSÃO        \E[0m" && sleep 4 && exit 0
