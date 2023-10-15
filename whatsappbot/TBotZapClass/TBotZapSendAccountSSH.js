
const { default: makeWASocket, useMultiFileAuthState, MessageRetryMap, Presence, DisconnectReason, delay}  = require('@adiwajshing/baileys')
const P = require('pino')

class TBotZapSendAccountSSH{
    connection = () => {
      return new Promise( async (resolve, reject) => {
        const { state, saveCreds } = await useMultiFileAuthState('/etc/botvendas/whatsappbot/auth_info_baileys')
        this.conn = makeWASocket({
            logger: P({ level: 'silent' }),
                printQRInTerminal: true,
                auth: state,
                msgRetryCounterMap: MessageRetryMap,
                defaultQueryTimeoutMs: undefined, 
                keepAliveIntervalMs: 1000 * 60 * 10 * 3
    
        })

        this.conn.ev.on('connection.update', (update) => {
            const { connection, lastDisconnect } = update
           if(connection === 'open') {
                console.log('opened connection')
                resolve({status: true, connection: this.conn})
                
            }else if(connection === 'close'){
                resolve({status: false})
            }

        })
      })
    }
  

    sendMessage = ({account}) => {
        return new Promise((receive, reject) => {
            const buttons = [
                {buttonId: 'btn_playstore', buttonText: {displayText: 'Play Store'}, type: 1},
                {buttonId: 'btn_mediafire', buttonText: {displayText: 'Link Direto'}, type: 1},
              ]
              console.log("============== PREPARANDO SSH PARA ENVIAR AO CLIENTE ===================")
            const button_buy ={ 
            text: `
 🏧✅ *CONTA CRIADA COM SUCESSO!* ✅🏧
 🌍 *Servidor:* ${account.payload.ssh_server}
 👤 *Usuário:* ${account.payload.ssh_account}
 🔑 *Senha:* ${account.payload.ssh_password}
 ⏱ *Expira em:* ${account.payload.ssh_expire}
 🗓️ *Validade:* ${account.payload.ssh_validate}
 📲 *Limite:* ${account.payload.ssh_limit}
 #️⃣ *Pedido Nª:* ${account.payload.order_id}
 ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
 Obrigado por adquirir nosso produto.`,
            footer: 'Para baixar nosso app escolha um dos botões abaixo.',
            buttons: buttons,
            headerType: 1
            
            }
            this.conn.sendMessage(account.payload.chat_id, button_buy)
            receive(true)
        })
    }

    
}

module.exports.TBotZapSendAccountSSH = new TBotZapSendAccountSSH()