                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                #!/bin/bash
[[ $(awk -F" " '{print $2}' /usr/lib/botchave) == "@ntechsystem" ]] &>/dev/null && {
verificar_chave(){
clear
[[ -e /etc/botvendas/version ]] && versao=$(cat /etc/botvendas/version) || versao="1.0.0"
[[ -e /bin/infochavebot ]] && key=$(cat /bin/infochavebot) || key=""
[[ $(uname -m) == "aarch64" ]] && arc=aarch64 || arc=x86_64
IP=$(wget -qO- ipv4.icanhazip.com)
resultkey=$(curl -s -X POST "http://chave.imperialnet.xyz/validarchave.php" -d key=$key -d IP=$IP -d arcsys=$arc -d veratual=$versao) &>/dev/null

if [ $(echo $resultkey | jq -r '.validate') == "Success" ] > /dev/null 2>&1
then
if [ ! -e "/etc/botvendas/version" ]; then
echo -e 1.0.0 >/etc/botvendas/version
ver=$(cat /etc/botvendas/version)
else
ver=$(cat /etc/botvendas/version)
fi
check_att
veratt=$(cat /etc/botvendas/attversion)
menu_principal
else
echo -e "\033[1;31m         VOCÊ NÃO TEM PERMISSÃO        \033[0m"
read -p "Enter para retornar!"
clear && exit 1
fi
}
#================ CODIGOS ESTILOS ============|
Bold=$(tput bold)
Norm=$(tput sgr0)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Yellow=$(tput setaf 3)
Blue=$(tput setaf 4)
#=============== CONSTANTES =============#
file=/etc/botvendas
file_mp="$file/info-mp"
file_revenda="$file/revenda-link"
file_valor_login="$file/valor-login"
file_temp_teste="$file/tempo-test"
file_temp_conta="$file/tempo-conta"
check_att () {
vrs1=$(cat /etc/botvendas/version)
[[ -e /etc/botvendas/attversion ]] && vrs2=$(wget -qO- bitbucket.org/nandoslayer/botpago/downloads/version) || wget -qO- bitbucket.org/nandoslayer/botpago/downloads/version -O /etc/botvendas/attversion > /dev/null 2>&1
[[ "$vrs1" != "$vrs2" ]] && wget -qO- bitbucket.org/nandoslayer/botpago/downloads/version -O /etc/botvendas/attversion > /dev/null 2>&1
}
logo(){
[[ "$ver" == "$veratt" ]]  && {
clear
cat <<FECHA
########   #######  ########    ########    ###    ########
##     ## ##     ##    ##            ##    ## ##   ##     ##
##     ## ##     ##    ##           ##    ##   ##  ##     ##
########  ##     ##    ##          ##    ##     ## ########
##     ## ##     ##    ##         ##     ######### ##
##     ## ##     ##    ##        ##      ##     ## ##
########   #######     ##       ######## ##     ## ##
VERSÃO ATUAL: ${Green}$ver${Norm}                        BY: @nandoslayer
FECHA
} || {
clear
cat <<FECHA
########   #######  ########    ########    ###    ########
##     ## ##     ##    ##            ##    ## ##   ##     ##
##     ## ##     ##    ##           ##    ##   ##  ##     ##
########  ##     ##    ##          ##    ##     ## ########
##     ## ##     ##    ##         ##     ######### ##
##     ## ##     ##    ##        ##      ##     ## ##
########   #######     ##       ######## ##     ## ##
VERSÃO ATUAL: ${Green}$ver${Norm}                        BY: @nandoslayer

EXISTE UMA ATUALIZAÇÃO: ${Green}$veratt${Norm}
FECHA
}
}
banner(){
clear
if [[ "$ver" != "$veratt" ]]
then
logo
#============================== COLUNA 1 ================================================|
tput cup 3 1
tput setab 7
tput setaf 0
tput sgr0
echo " "
tput cup 11 1
echo "${Red}[${Norm}${Bold}01${Norm}${Red}]${Norm} ${Yellow}${Bold}INICIAR BOT${Norm}${Norm}[${Green}${twabot_vazio}${Norm}]"
tput sgr0
tput cup 12 1
echo "${Red}[${Norm}${Bold}02${Norm}${Red}]${Norm} ${Yellow}${Bold}PARAR BOT${Norm}${Norm}"
tput sgr0
tput cup 13 1
echo "${Red}[${Norm}${Bold}03${Norm}${Red}]${Norm} ${Yellow}${Bold}TOKEN MERCADOPAGO${Norm}${Norm} [${Green}${mp_vazio}${Norm}]"
tput sgr0
tput cup 14 1
echo "${Red}[${Norm}${Bold}04${Norm}${Red}]${Norm} ${Yellow}${Bold}LINK REVENDA${Norm}${Norm} [${Green}${revenda_vazio}${Norm}]"
tput sgr0
tput cup 15 1
echo "${Red}[${Norm}${Bold}05${Norm}${Red}]${Norm} ${Yellow}${Bold}LINK DE SUPORTE${Norm}${Norm} [${Green}${suporte_vazio}${Norm}]"
tput sgr0
tput cup 16 1
echo "${Red}[${Norm}${Bold}06${Norm}${Red}]${Norm} ${Yellow}${Bold}LINK DOWNLOAD${Norm}${Norm} [${Green}${link_vazio}${Norm}]"
tput sgr0
tput cup 17 1
echo "${Red}[${Norm}${Bold}07${Norm}${Red}]${Norm} ${Yellow}${Bold}NOME DO SERVIDOR${Norm}${Norm} [${Green}${server_vazio}${Norm}]"
tput sgr0
tput cup 18 1
echo "${Red}[${Norm}${Bold}08${Norm}${Red}]${Norm} ${Yellow}${Bold}PALAVRA CHAVE${Norm}${Norm} [${Green}${palavra_vazio}${Norm}]"
tput sgr 0
#================================== COLUNA 2 ================================================|
tput cup 11 32
echo "${Red}[${Norm}${Bold}09${Norm}${Red}]${Norm} ${Yellow}${Bold}TEXTO MENU${Norm}${Norm} [${Green}${textomenu_vazio}${Norm}]"
tput sgr 0
tput cup 12 32
echo "${Red}[${Norm}${Bold}10${Norm}${Red}]${Norm} ${Yellow}${Bold}VALIDADE DA CONTA${Norm}${Norm} [${Green}${validade_conta_vazio}${Norm}]"
tput sgr 0
tput cup 13 32
echo "${Red}[${Norm}${Bold}11${Norm}${Red}]${Norm} ${Yellow}${Bold}TEMPO DO TESTE${Norm}${Norm} [${Green}${test_vazio}${Norm}]"
tput sgr0
tput cup 14 32
echo "${Red}[${Norm}${Bold}12${Norm}${Red}]${Norm} ${Yellow}${Bold}VALOR DA CONTA${Norm}${Norm} [${Green}${valor_vazio}${Norm}]"
tput sgr0
tput cup 15 32
echo "${Red}[${Norm}${Bold}13${Norm}${Red}]${Norm} ${Yellow}${Bold}Nª DE CONEXÃO${Norm}${Norm} [${Green}${acesso_vazio}${Norm}]"
tput sgr0
tput cup 16 32
echo "${Red}[${Norm}${Bold}14${Norm}${Red}]${Norm} ${Yellow}${Bold}REFAZER BOT${Norm}${Norm}"
tput sgr0
tput cup 17 32
echo "${Red}[${Norm}${Bold}15${Norm}${Red}]${Norm} ${Yellow}${Bold}EXCLUIR BOT${Norm}${Norm}"
tput sgr0
tput cup 18 32
echo "${Red}[${Norm}${Bold}00${Norm}${Red}]${Norm} ${Yellow}${Bold}SAIR${Norm}${Norm}"
tput sgr0
tput cup 20 22
echo "${Red}[${Norm}${Bold}A${Norm}${Red}]${Norm} ${Yellow}${Bold}ATUALIZAR BOTZAP${Norm}${Norm}"
tput sgr0
else
logo
#============================== COLUNA 1 ================================================|
tput cup 3 1
tput setab 7
tput setaf 0
tput sgr0
echo " "
tput cup 11 1
echo "${Red}[${Norm}${Bold}01${Norm}${Red}]${Norm} ${Yellow}${Bold}INICIAR BOT${Norm}${Norm}[${Green}${twabot_vazio}${Norm}]"
tput sgr0
tput cup 12 1
echo "${Red}[${Norm}${Bold}02${Norm}${Red}]${Norm} ${Yellow}${Bold}PARAR BOT${Norm}${Norm}"
tput sgr0
tput cup 13 1
echo "${Red}[${Norm}${Bold}03${Norm}${Red}]${Norm} ${Yellow}${Bold}TOKEN MERCADOPAGO${Norm}${Norm} [${Green}${mp_vazio}${Norm}]"
tput sgr0
tput cup 14 1
echo "${Red}[${Norm}${Bold}04${Norm}${Red}]${Norm} ${Yellow}${Bold}LINK REVENDA${Norm}${Norm} [${Green}${revenda_vazio}${Norm}]"
tput sgr0
tput cup 15 1
echo "${Red}[${Norm}${Bold}05${Norm}${Red}]${Norm} ${Yellow}${Bold}LINK DE SUPORTE${Norm}${Norm} [${Green}${suporte_vazio}${Norm}]"
tput sgr0
tput cup 16 1
echo "${Red}[${Norm}${Bold}06${Norm}${Red}]${Norm} ${Yellow}${Bold}LINK DOWNLOAD${Norm}${Norm} [${Green}${link_vazio}${Norm}]"
tput sgr0
tput cup 17 1
echo "${Red}[${Norm}${Bold}07${Norm}${Red}]${Norm} ${Yellow}${Bold}NOME DO SERVIDOR${Norm}${Norm} [${Green}${server_vazio}${Norm}]"
tput sgr0
tput cup 18 1
echo "${Red}[${Norm}${Bold}08${Norm}${Red}]${Norm} ${Yellow}${Bold}PALAVRA CHAVE${Norm}${Norm} [${Green}${palavra_vazio}${Norm}]"
tput sgr 0
#================================== COLUNA 2 ================================================|
tput cup 11 32
echo "${Red}[${Norm}${Bold}09${Norm}${Red}]${Norm} ${Yellow}${Bold}TEXTO MENU${Norm}${Norm} [${Green}${textomenu_vazio}${Norm}]"
tput sgr 0
tput cup 12 32
echo "${Red}[${Norm}${Bold}10${Norm}${Red}]${Norm} ${Yellow}${Bold}VALIDADE DA CONTA${Norm}${Norm} [${Green}${validade_conta_vazio}${Norm}]"
tput sgr 0
tput cup 13 32
echo "${Red}[${Norm}${Bold}11${Norm}${Red}]${Norm} ${Yellow}${Bold}TEMPO DO TESTE${Norm}${Norm} [${Green}${test_vazio}${Norm}]"
tput sgr0
tput cup 14 32
echo "${Red}[${Norm}${Bold}12${Norm}${Red}]${Norm} ${Yellow}${Bold}VALOR DA CONTA${Norm}${Norm} [${Green}${valor_vazio}${Norm}]"
tput sgr0
tput cup 15 32
echo "${Red}[${Norm}${Bold}13${Norm}${Red}]${Norm} ${Yellow}${Bold}Nª DE CONEXÃO${Norm}${Norm} [${Green}${acesso_vazio}${Norm}]"
tput sgr0
tput cup 16 32
echo "${Red}[${Norm}${Bold}14${Norm}${Red}]${Norm} ${Yellow}${Bold}REFAZER BOT${Norm}${Norm}"
tput sgr0
tput cup 17 32
echo "${Red}[${Norm}${Bold}15${Norm}${Red}]${Norm} ${Yellow}${Bold}EXCLUIR BOT${Norm}${Norm}"
tput sgr0
tput cup 18 32
echo "${Red}[${Norm}${Bold}00${Norm}${Red}]${Norm} ${Yellow}${Bold}SAIR${Norm}${Norm}"
tput sgr0
fi
}
menu_principal(){
[[ -z $(cat /etc/botvendas/link_mediafire ) ]] || [[ -z $(cat /etc/botvendas/link_playstore ) ]] && {
link_vazio="${Red}OFF"
} || {
link_vazio="ON"
}
if [[ -f /etc/botvendas/info-mp ]]
then
[[ -z $(cat /etc/botvendas/info-mp) ]] && mp_vazio="${Red}OFF" || mp_vazio="ON"
fi
if [[ -f /etc/botvendas/tempo-test ]]
then
[[ -z $(cat /etc/botvendas/tempo-test) ]] && test_vazio="${Red}OFF" || test_vazio="ON"
fi
if [[ -f /etc/botvendas/server ]]
then
[[ -z $(cat /etc/botvendas/server) ]] && server_vazio="${Red}OFF" || server_vazio="ON"
fi
if [[ -f /etc/botvendas/valor-login ]]
then
[[ -z $(cat /etc/botvendas/valor-login) ]] && valor_vazio="${Red}OFF" || valor_vazio="ON"
fi
if [[ -f /etc/botvendas/tempo-conta ]]
then
[[ -z $(cat /etc/botvendas/tempo-conta) ]] && validade_conta_vazio="${Red}OFF" || validade_conta_vazio="ON"
fi
if [[ -f /etc/botvendas/revenda-link ]]
then
[[ -z $(cat /etc/botvendas/revenda-link ) ]] && revenda_vazio="${Red}OFF" || revenda_vazio="ON"
fi
if [[ -f /etc/botvendas/info-bot ]]
then
[[ -z $(cat /etc/botvendas/info-bot ) ]] && bot_vazio="${Red}OFF" || bot_vazio="ON"
fi
if [[ -f /etc/botvendas/palavra ]]
then
[[ -z $(cat /etc/botvendas/palavra ) ]] && palavra_vazio="${Red}OFF" || palavra_vazio="ON"
fi
if [[ -f /etc/botvendas/textomenu ]]
then
[[ -z $(cat /etc/botvendas/textomenu ) ]] && textomenu_vazio="${Red}OFF" || textomenu_vazio="ON"
fi
if [[ -f /etc/botvendas/acessos ]]
then
[[ -z $(cat /etc/botvendas/acessos ) ]] && acesso_vazio="${Red}OFF" || acesso_vazio="ON"
fi
if [[ -f /etc/botvendas/link_app_download ]]
then
[[ -z $( cat /etc/botvendas/link_app_download) ]] && link_download="${Red}OFF" || link_download="ON"
fi
if [[ -n $( screen -ls | grep twabot ) ]]
then
twabot_vazio="ON"
else
twabot_vazio="${Red}OFF"
fi
if [[ -f /etc/botvendas/link_suporte ]]
then
[[ -z $( cat /etc/botvendas/link_suporte) ]] && suporte_vazio="${Red}OFF" || suporte_vazio="ON"
fi
banner
echo -e "\n"
read -p "${Blue}Escolha uma opção:> ${Norm}" INPUT_STRING
if [[ "$ver" != "$veratt" ]]
then
case $INPUT_STRING in
1|01)
ativar_bot_WhatsApp
exit;
;;
2|02)
pararBot_whatsapp
exit;
;;
3|03)
pedir_token_mp
exit;
;;
4|04)
link_revenda
exit;
;;
5|05)
link_suporte
exit;
;;
6|06)
menu_app_download
exit;
;;
7|07)
server_conta
exit;
;;
8|08)
palavra_bot
exit;
;;
9|09)
textomenu_bot
exit;
;;
10)
validade_conta
exit;
;;
11)
tempo_teste
exit;
;;
12)
valor_login
exit;
;;
13)
numero_acesso
exit;
;;
14)
echo ""
echo "${Red}${Bold}DESEJA REALMENTE REFAZER O BOT? [S/N]: ${Norm}${Norm}"; read x
[[ $x = @(S|s) ]] && show_error
menu_principal
exit;
;;
15)
echo ""
echo "${Red}${Bold}ESSA OPÇÃO PERDE A LICENÇA!${Norm}${Norm}"
echo "${Red}${Bold}DESEJA REALMENTE EXCLÚIR TUDO? [S/N]: ${Norm}${Norm}"; read x
[[ $x = @(S|s) ]] && excluir_bot
exit;
;;
A|a)
echo ""
echo "${Red}${Bold}DESEJA REALMENTE ATUALIZAR O BOT? [S/N]: ${Norm}${Norm}"; read x
[[ $x = @(S|s) ]] && bash <(wget -qO- bitbucket.org/nandoslayer/install/downloads/attbot.sh)
exit;
;;
0|00)
fechar
;;
*)
echo "${Red}${Bold}OPÇÃO INVÁLIDA!${Norm}${Norm}"
sleep 2
esac
menu_principal
else
case $INPUT_STRING in
1|01)
ativar_bot_WhatsApp
exit;
;;
2|02)
pararBot_whatsapp
exit;
;;
3|03)
pedir_token_mp
exit;
;;
4|04)
link_revenda
exit;
;;
5|05)
link_suporte
exit;
;;
6|06)
menu_app_download
exit;
;;
7|07)
server_conta
exit;
;;
8|08)
palavra_bot
exit;
;;
9|09)
textomenu_bot
exit;
;;
10)
validade_conta
exit;
;;
11)
tempo_teste
exit;
;;
12)
valor_login
exit;
;;
13)
numero_acesso
exit;
;;
14)
echo ""
echo "${Red}${Bold}DESEJA REALMENTE REFAZER O BOT? [S/N]: ${Norm}${Norm}"; read x
[[ $x = @(S|s) ]] && show_error
menu_principal
exit;
;;
15)
echo ""
echo "${Red}${Bold}ESSA OPÇÃO PERDE A LICENÇA!${Norm}${Norm}"
echo "${Red}${Bold}DESEJA REALMENTE EXCLÚIR TUDO? [S/N]: ${Norm}${Norm}"; read x
[[ $x = @(S|s) ]] && excluir_bot
exit;
;;
0|00)
fechar
;;
*)
echo "${Red}${Bold}OPÇÃO INVÁLIDA!${Norm}${Norm}"
sleep 2
esac
menu_principal
fi
}
#============= FUNÇÕES ===============#
tempo_teste(){
validade=$(cat /etc/botvendas/tempo-test)
while :
do
echo ""
echo "${Yellow}${Bold}DIGITE O TEMPO DO TESTE${Norm}${Norm}"
echo ""
echo "${Blue}${Bold}[-] TEMPO ATUAL: ${Green}$validade${Norm}${Norm}"
echo ""
echo "${Magenta}Ex: 1 = [1] Hora | 2 = [2] Horas${Norm}"
echo ""
read -p "NOVO TEMPO:> " validade
if [[ -z $(echo $validade | egrep '[0-9]' ) ]]
then
echo -e "\n${Red}[!] DIGITE UM TEMPO VÁLIDO!${Norm}"
sleep 3
clear
menu_principal
break
exit 0
else
[[ $validade < 1 ]] && {
	echo -e "\n${Red}[!] NÃO PODE SER 0 (ZERO)!${Norm}"
	sleep 3
	menu_principal
break
exit 0
}
echo $validade > /etc/botvendas/tempo-test
echo -e "\n${Green}[-] SALVO COM SUCESSO!${Norm}"
sleep 3
clear
menu_principal
break
exit 0
fi
done
}
menu_app_download(){
[[ -n $(cat /etc/botvendas/link_playstore) ]] && link_playstore="ON" || link_playstore="${Red}OFF"
[[ -n $(cat /etc/botvendas/link_mediafire) ]] && link_mediafire="ON" || link_mediafire="${Red}OFF"
logo
tput sgr0
tput cup 11 1
tput setab 7
tput setaf 0
echo "               ADICIONAR LINK PARA DOWNLOAD                 "
tput sgr0
tput cup 12 1
tput sgr0
tput cup 13 1
echo "${Bold}${Red}[${Norm}01${Red}]${Norm} ${Yellow}${Bold}LINK PLAY STORE${Norm}${Norm} [${Green}${link_playstore}${Norm}]"
tput sgr0
tput cup 14 1
echo "${Bold}${Red}[${Norm}02${Red}]${Norm} ${Yellow}${Bold}LINK DIRETO${Norm}${Norm} [${Green}${link_mediafire}${Norm}]"
tput sgr0
tput cup 15 1
echo "${Bold}${Red}[${Norm}00${Red}]${Norm} ${Yellow}${Bold}VOLTAR${Norm}${Norm}"
tput sgr0
link_app
}
link_app(){
echo -e "\n"
read -p "${Blue}Escolha uma opção:> ${Norm}" INPUT_STRING
case $INPUT_STRING in
1|01)
play_store
exit;
;;
2|02)
link_direto
exit;
;;
0|00)
echo -e "\n${Red}${Bold}[-] RETORNANDO!${Norm}${Norm}"
sleep 2
menu_principal
exit;
;;
*)
echo -e "\n${Red}${Bold}OPÇÃO INVÁLIDA!${Norm}${Norm}"
sleep 2
esac
menu_app_download
}
play_store(){
link=$(cat /etc/botvendas/link_playstore)
echo ""
echo "${Yellow}${Bold}[-] DIGITE O LINK DO SEU APP NA PLAY STORE${Norm}${Norm}"
echo ""
echo "${Blue}${Bold}[-] LINK ATUAL: ${Green}$link${Norm}${Norm}"
echo ""
echo "${Cyan}Ex: https://linkdaplay/seuapp${Norm}"
echo ""
read -p "NOVO LINK:> " link
if [[ -z $(echo $link | egrep '^http' ) ]]
then
echo -e "\n${Red}[!] DIGITE UMA URL VÁLIDA${Norm}"
sleep 3
clear
menu_app_download
break
exit 1
else
echo $link > /etc/botvendas/link_playstore
echo -e "\n${Green}${Bold}[-] SALVO COM SUCESSO!${Norm}${Norm}"
sleep 3
clear
menu_app_download
break
exit 1
fi
}
link_direto(){
link=$(cat /etc/botvendas/link_mediafire)
echo ""
echo "${Yellow}${Bold}[-] DIGITE O LINK DO SEU APP FORA DA PLAYSTORE${Norm}${Norm}"
echo "${Yellow}${Bold}[-] PODE SER MEDIAFIRE/MEGA ${Norm}${Norm}"
echo ""
echo "${Blue}${Bold}[-] LINK ATUAL: ${Green}$link${Norm}${Norm}"
echo ""
echo "${Cyan}Ex: https://linkdoapp/seuapp${Norm}"
echo ""
read -p "NOVO LINK:> " link
if [[ -z $(echo $link | egrep '^http' ) ]]
then
echo -e "\n${Red}[!] DIGITE UMA URL VÁLIDA${Norm}"
sleep 3
clear
menu_app_download
break
exit 1
else
echo $link > /etc/botvendas/link_mediafire
echo -e "\n${Green}${Bold}[-] SALVO COM SUCESSO!${Norm}${Norm}"
sleep 3
clear
menu_app_download
break
exit 1
fi
}
pararBot(){
echo -e "${Magenta}[-] SÓ UM MOMENTO O WHATSAPPBOT ESTÁ SENDO PARADO!${Norm}"
screen -r -S "twabot" -X quit >/dev/null 2>&1
screen -wipe 1>/dev/null 2>/dev/null
sleep 3
screen -r -S "tbotzapcheck" -X quit >/dev/null 2>&1
screen -wipe 1>/dev/null 2>/dev/null
echo -e "\n${Magenta}[-] WHATSAPPBOT PARADO!${Norm}"
sleep 3
}
show_error(){
pararBot
rm -rf /etc/botvendas/whatsappbot/auth_info_baileys /etc/botvendas/model.nlp /root/model.nlp >/dev/null 2>&1
echo -e "\n${Yellow}${Bold}[-] REFAZENDO O BOT!${Norm}${Norm}"
sleep 3
echo -e "\n${Green}[-] BOT REFEITO COM SUCESSO!${Norm}"
sleep 3
clear
menu_principal
exit;
}
#========================= LINK SUPORTE / REVENDA ===============================
link_suporte(){
link=$(cat /etc/botvendas/link_suporte)
while :
do
echo ""
echo "${Yellow}${Bold}[-] DIGITE UM LINK DE SUPORTE${Norm}${Norm}"
echo "${Yellow}${Bold}[-] O LINK PODE SER DO TELEGRAM OU UM SITE${Norm}${Norm}"
echo ""
echo "${Blue}${Bold}[-] LINK ATUAL: ${Green}$link${Norm}${Norm}"
echo ""
echo "${Cyan}Ex: https://t.me/seu_user_aqui${Norm}"
echo ""
read -p "NOVO LINK:> " link
if [[ -z $(echo $link | egrep '^http' ) ]]
then
echo -e "\n${Red}[!] DIGITE UMA URL VÁLIDA!${Norm}"
sleep 3
clear
menu_principal
break
exit 0
else
echo $link > /etc/botvendas/link_suporte
echo -e "\n${Green}[-] SALVO COM SUCESSO!${Norm}"
sleep 3
clear
menu_principal
break
exit 0
fi
done
}
link_revenda(){
link=$(cat /etc/botvendas/revenda-link)
while :
do
echo ""
echo "${Yellow}${Bold}[-] DIGITE UM LINK DE REVENDA${Norm}${Norm}"
echo "${Yellow}${Bold}[-] O LINK PODE SER DO TELEGRAM OU UM SITE${Norm}${Norm}"
echo ""
echo "${Blue}${Bold}[-] LINK ATUAL: ${Green}$link${Norm}${Norm}"
echo ""
echo "${Cyan}Ex: https://t.me/seu_user_aqui${Norm}"
echo ""
read -p "NOVO LINK:> " link
if [[ -z $(echo $link | egrep '^http' ) ]]
then
echo -e "\n${Red}[!] DIGITE UMA URL VÁLIDA!${Norm}"
sleep 3
clear
menu_principal
break
exit 0
else
echo $link > /etc/botvendas/revenda-link
echo -e "\n${Green}[-] SALVO COM SUCESSO!${Norm}"
sleep 3
clear
menu_principal
break
exit 0
fi
done
}
palavra_bot(){
palavratext=$(cat /etc/botvendas/palavra)
while :
do
echo ""
echo "${Yellow}${Bold}[-] DIGITE UMA PALAVRA CHAVE${Norm}${Norm}"
echo ""
echo "${Blue}${Bold}[-] PALAVRA ATUAL: ${Green}$palavratext${Norm}${Norm}"
echo ""
read -p "NOVA PALAVRA:> " ptext
sizemin=$(echo ${#ptext})
[[ $sizemin -lt 1 ]] && {
	echo -e "\n${Red}[!] VOCÊ DIGITOU UMA PALAVRA MUITO CURTA!${Norm}\n"
	sleep 1
	echo -e "${Red}[!] USE NO MÍNIMO 1 CARACTERES!${scor}\n"
	sleep 3
	menu_principal
break
exit 0
}
echo $ptext > /etc/botvendas/palavra
wget -qO- bitbucket.org/nandoslayer/botpago/downloads/training.json -O /etc/botvendas/whatsappbot/NLP/training.json > /dev/null 2>&1
sed -i "s;internet;$ptext;g" /etc/botvendas/whatsappbot/NLP/training.json > /dev/null 2>&1
echo -e "\n${Green}[-] SALVO COM SUCESSO!${Norm}\n"
sleep 3
pararBot
echo -e "\n${Green}[-] INICIANDO BOT NOVAMENTE!${Norm}\n"
sleep 3
ativar_bot_WhatsApp
break
exit 0
done
}
textomenu_bot(){
textmenu=$(cat /etc/botvendas/textomenu)
while :
do
echo ""
echo "${Yellow}${Bold}[-] DIGITE UM TEXTO PARA O MENU${Norm}${Norm}"
echo ""
echo "${Cyan}Ex: Para quebra de linha utilize \n${Norm}"
echo ""
echo "${Blue}${Bold}[-] TEXTO ATUAL: ${Green}$textmenu${Norm}${Norm}"
echo ""
read -r -p "NOVO TEXTO:> " textmenu
[[ -z $textmenu ]] && {
	echo -e "\n${Red}[!] TEXTO VÁZIO OU INVÁLIDO!${Norm}"
	sleep 3
	menu_principal
break
exit 0
}
sizemin=$(echo ${#textmenu})
[[ $sizemin -lt 2 ]] && {
	echo -e "\n${Red}[!] VOCÊ DIGITOU UM TEXTO MUITO CURTO!${Norm}\n"
	sleep 1
	echo -e "${Red}[!] USE NO MÍNIMO 2 CARACTERES!${scor}\n"
	sleep 3
	menu_principal
break
exit 0
}
echo -e $textmenu > /etc/botvendas/textomenu
echo -e "\n${Green}[-] SALVO COM SUCESSO!${Norm}"
sleep 3
menu_principal
break
exit 0
done
}
server_conta(){
link=$(cat /etc/botvendas/server)
while :
do
echo ""
echo "${Yellow}${Bold}[-] DIGITE UM NOME PARA O SERVIDOR${Norm}${Norm}"
echo ""
echo "${Blue}${Bold}[-] NOME ATUAL: ${Green}$link${Norm}${Norm}"
echo ""
read -p "NOVO NOME:> " link
[[ -z $link ]] && {
	echo -e "\n${Red}[!] NOME DO SERVIDOR VÁZIO OU INVÁLIDO!${Norm}"
	sleep 3
	menu_principal
break
exit 0
}
sizemin=$(echo ${#link})
[[ $sizemin -lt 4 ]] && {
	echo -e "\n${Red}[!] VOCÊ DIGITOU UM NOME DE SERVIDOR MUITO CURTO!${Norm}\n"
	sleep 1
	echo -e "${Red}[!] USE NO MÍNIMO 4 CARACTERES!${scor}\n"
	sleep 3
	menu_principal
break
exit 0
}
sizemax=$(echo ${#link})
[[ $sizemax -gt 10 ]] && {
	echo -e "\n${Red}[!] VOCÊ DIGITOU UM NOME DE SERVIDOR MUITO GRANDE!${Norm}\n"
	sleep 1
	echo -e "${Red}[!] USE NO MÁXIMO 12 CARACTERES!${Norm}\n"
	sleep 3
	menu_principal
break
exit 0
}
echo $link > /etc/botvendas/server
echo -e "\n${Green}[-] SALVO COM SUCESSO!${Norm}"
sleep 3
menu_principal
break
exit 0
done
}
#====================================================================================#
excluir_bot(){
pararBot
rm -rf /etc/botvendas
rm -rf /bin/bvendas
rm -rf /root/model.nlp
fechar
}
numero_acesso(){
quantidade=$(cat /etc/botvendas/acessos)
while :
do
echo ""
echo "${Yellow}${Bold}[-] DIGITE O Nª DE CONEXÃO SIMULTANEA!${Norm}${Norm}"
echo ""
echo "${Blue}${Bold}[-] Nª ATUAL: ${Green}$quantidade${Norm}${Norm}"
echo ""
echo "${Cyan}Ex: 1 = [1] Conexão | 2 = [2] Conexões${Norm}"
echo ""
read -p "NOVO Nª:> " quantidade
if [[ -z $(echo $quantidade | egrep '^[0-9]') ]]
then
echo -e "\n${Red}[!] DIGITE UM Nª VÁLIDO!${Norm}"
sleep 3
menu_principal
break
exit 0
else
[[ $quantidade < 1 ]] && {
	echo -e "\n${Red}[!] O Nª NÃO PODE SER 0 (ZERO)!${Norm}"
	sleep 3
	menu_principal
break
exit 0
}
echo $quantidade > /etc/botvendas/acessos
echo -e "\n${Green}[-] SALVO COM SUCESSO!${Norm}"
sleep 3
menu_principal
break
exit 0
fi
done
}
validade_conta(){
validade=$(cat /etc/botvendas/tempo-conta)
while :
do
echo ""
echo "${Yellow}${Bold}[-] DIGITE QUANTOS DIAS O LOGIN SERÁ VÁLIDO${Norm}${Norm}"
echo ""
echo "${Blue}${Bold}[-] ATUAL: ${Green}$validade${Norm}${Norm}"
echo ""
echo "${Cyan}Ex: 1 = [1] Dia | 10 = [10] Dias | 20 = [20] Dias${Norm}"
echo ""
read -p "QUANTIDADE:> " validade
if [[ -z $(echo $validade | egrep '^[0-9]' ) ]]
then
echo -e "\n${Red}[!] DIGITE UMA QUANTIDADE VÁLIDA!${Norm}"
sleep 3
menu_principal
break
exit 0
else
[[ $validade < 1 ]] && {
	echo -e "\n${Red}[!] NÃO PODE SER 0 (ZERO)!${Norm}"
	sleep 3
	menu_principal
break
exit 0
}
echo $validade > /etc/botvendas/tempo-conta
echo -e "\n${Green}[-] SALVO COM SUCESSO!${Norm}"
sleep 3
menu_principal
break
exit 0
fi
done
}
fechar(){
echo -e "\n${Red}[!] ATÉ MAIS!${Norm}"
sleep 2
exit 1
}
valor_login(){
valor=$(cat /etc/botvendas/valor-login)
while :
do
echo ""
echo "${Yellow}${Bold}[-] DIGITE UM VALOR PARA CONTA${Norm}${Norm}"
echo "${Yellow}${Bold}[-] ESSE VALOR SERÁ PAGO PELO CLIENTE${Norm}${Norm}"
echo ""
echo "${Blue}${Bold}[-] ATUAL: ${Green}$valor${Norm}${Norm}"
echo ""
echo "${Cyan}Ex: 10.00${Norm}"
echo ""
read -p "NOVO VALOR:> " valor
if [[ -z $(echo $valor | egrep '[0-9]{2}.[0-9]' ) ]]
then
echo -e "\n${Red}[!] DIGITE UM VALOR VÁLIDO!${Norm}"
sleep 3
menu_principal
break
exit 0
else
echo $valor > /etc/botvendas/valor-login
echo -e "\n${Green}[-] SALVO COM SUCESSO!${Norm}"
sleep 3
menu_principal
break
exit 0
fi
done
}
pararBot_whatsapp(){
echo -e "${Magenta}[-] SÓ UM MOMENTO O WHATSAPPBOT ESTÁ SENDO PARADO!${Norm}"
sleep 2
screen -r -S "twabot" -X quit >/dev/null 2>&1
screen -wipe 1>/dev/null 2>/dev/null
sleep 2
screen -r -S "tbotzapcheck" -X quit >/dev/null 2>&1
screen -wipe 1>/dev/null 2>/dev/null
echo -e "${Magenta}[-] WHATSAPPBOT PARADO!${Norm}"
sleep 3
clear
menu_principal
exit 0
}
ativar_bot_WhatsApp(){
if [[ -z $( screen -ls | grep twabot ) ]]
then
bash /etc/botvendas/whatsappbot/shell/run.sh
else
echo ""
cat << FECHA
========================== 
    ${Green}BOT JÁ ESTÁ ONLINE${Norm}
==========================
FECHA
sleep 3
menu_principal
exit 0
fi
}
pedir_token_mp(){
token=$(cat /etc/botvendas/info-mp)
while :
do
echo ""
echo -e "${Yellow}${Bold}[-] DIGITE O TOKEN DO MERCADO PAGO!\n${Magenta}[-]Ex: APP_USR6702162676543402-063018-f604ce2bfa1461cd7876c6fb8fa395a0-484048xxx
${Norm}${Norm}${Norm}"
echo ""
echo "${Blue}${Bold}[-] TOKEN ATUAL: ${Green}$token${Norm}${Norm}"
echo ""
read -p "NOVO TOKEN:> " token
if [[ -z $(echo $token | egrep '^APP_USR|TEST' ) ]]
then
echo -e "\n${Red}[!] DIGITE UM TOKEN VÁLIDO!${Norm}"
sleep 3
menu_principal
break
exit 0
else
echo $token > /etc/botvendas/info-mp
if [[ $? == "0" ]]
then
echo -e "\n${Green}[-] SALVO COM SUCESSO!${Norm}"
sleep 3
menu_principal
break
exit 0
else
echo -e "\n${Red}[!] NÃO FOI POSSÍVEL SALVAR!${Norm}"
sleep 3
menu_principal
break
exit 0
fi
fi
done
}
verificar_chave
} || clear && echo -e "\E[41;1;37m         VOCÊ NÃO TEM PERMISSÃO        \E[0m" && sleep 4 && exit 0