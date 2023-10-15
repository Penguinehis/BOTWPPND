#!/bin/bash
[[ $(awk -F" " '{print $2}' /usr/lib/botchave) == "@ntechsystem" ]] &>/dev/null && {
if [ ! -d /etc/SSHPlus/userteste ]; then
mkdir /etc/SSHPlus/userteste
fi
server=$(cat /etc/botvendas/server)
nome="pzap"$(echo $RANDOM | md5sum | head -c 5; echo;)
if [[ -z $nome ]]
then
exit 1
fi
awk -F : ' { print $1 }' /etc/passwd > /tmp/users
if grep -Fxq "$nome" /tmp/users
then
exit 1
fi
pass=$(echo $RANDOM | md5sum | head -c 6; echo;)
if [[ -z $pass ]]
then
exit 1
fi
limite=$(cat /etc/botvendas/acessos)
if [[ -z $limite ]]
then
exit 1
fi
tempo=$(cat /etc/botvendas/tempo-conta)
if [[ -z $tempo ]]
then
exit 1
fi
tuserdate=$(date "+%Y-%m-%d" -d "+$tempo days")
userdate=$(date "+%d/%m/%Y" -d "+$tempo days")
senha=$(perl -e 'print crypt($ARGV[0], "password")' $pass)
useradd -e $tuserdate -M -s /bin/false -p $senha $nome
echo "$pass" > /etc/SSHPlus/senha/$nome
echo "$nome $limite" >> /root/usuarios.db
echo "#!/bin/bash
killall -u $nome > /dev/null 2>&1
userdel -f $nome > /dev/null 2>&1
sed -i "/\b$nome\b/d" /root/usuarios.db
rm /etc/SSHPlus/senha/$nome > /dev/null 2>&1
rm /etc/SSHPlus/userteste/$nome.sh
exit 0
" > /etc/SSHPlus/userteste/$nome.sh
chmod +x /etc/SSHPlus/userteste/$nome.sh
at -f /etc/SSHPlus/userteste/$nome.sh now + $tempo days
[[ $limite -gt 1 ]] && user_limit="Conexões" || user_limit="Conexão"
[[ $tempo -gt 1 ]] && after="dias" || after="dia"
echo '{
"Servidor": "'${server}'",
"Usuario": "'${nome}'",
"Senha": "'${pass}'",
"expira": "'${tempo}' '${after}'",
"validade": "'${userdate}'",
"limite": "'${limite}' '${user_limit}'"
}'
exit 0
} || clear && echo -e "\E[41;1;37m         VOCÊ NÃO TEM PERMISSÃO        \E[0m" && sleep 4 && exit 0
