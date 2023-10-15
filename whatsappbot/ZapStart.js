const { default: makeWASocket, useMultiFileAuthState, MessageRetryMap, Presence, DisconnectReason, delay}  = require('@adiwajshing/baileys')

const { TBotZapNLP  } = require("./TBotZapFunction/TBotZapNLP")
const { TBotZapFreeAccount } = require('./TBotZapFunction/TBotZapFreeAccount')
const {TBotZapLoginTest} = require('./TBotZapClass/TBotZapCreateTest')
const { QRcode} = require('./TBotZapClass/TBotZapQrcode')
const { TBotZapSendLogin } = require('./TBotZapClass/TBotZapSendLogin')
const { TBotZapDBStatus } = require('./TBotZapFunction/TBotZapDatabaseStatus')
const {TBotZapSendAccountSSH} = require('./TBotZapClass/TBotZapSendAccountSSH')
const {TWABotFirstLoginTime, TWABotFileExist, TWABotLinkMediafire, TWABotLinkPlayStore, TWABotLoginLimit, TWABotTextMenu, TWABotLinkSupport, TWABotFirsLoginPrice, TWABotOpenFile} = require('./Util/TBotZapData')
const fs = require('fs')
const P = require('pino')
const path = require('path')
const TBotZapData = require('./Util/TBotZapData')

var msgRetryCounterMap = {};

async function TBotZap(){
   
        const { state, saveCreds } = await useMultiFileAuthState('/etc/botvendas/whatsappbot/auth_info_baileys')
        const conn = makeWASocket({
            logger: P({ level: 'silent' }),
                printQRInTerminal: true,
                auth: state,
                msgRetryCounterMap: MessageRetryMap,
                defaultQueryTimeoutMs: undefined, 
                keepAliveIntervalMs: 1000 * 60 * 10 * 3

        })
    
        conn.ev.on('connection.update', (update) => {
            const { connection, lastDisconnect } = update
            if(connection === 'close') {
                const shouldReconnect = lastDisconnect.output !== DisconnectReason.loggedOut
                console.log('connection closed due to '+ lastDisconnect.output)
                // reconnect if not logged out
                if(shouldReconnect) {
                    TBotZap()
                }
            } else if(connection === 'open') {
                console.log('opened connection')
                TBotZapNLP.train()
                
            }

        })
 
        conn.ev.on("creds.update", saveCreds);
        conn.ev.on('messages.upsert', async (message) => {
            console.log(JSON.stringify(message, undefined, 2));
            let jid = message.messages[0].key.remoteJid
            if(message && !jid.endsWith("@g.us") && message.messages[0].message){
                    
               
                const reply =  message.messages[0]
                var msg = message.messages[0].message.conversation
                const key = message.messages[0].key 
                const user= message.messages[0].pushName
                let isGroup = false
                jid.endsWith("@g.us") ? isGroup = true : isGroup = false
                  
                    console.log(JSON.stringify(message.messages[0].key))
                if(msg){
                    TBotZapNLP.answer(msg.toLowerCase())
                    .then( async (answer) => {
                        switch(answer.intent){
                            case "SAUDACAO.RECEPCAO":
                                const welcomeMessage = {
                                    text: `
🔰 SEJA BEM VINDOª *${user}*

${TWABotTextMenu()}`,
                                    footer: 'Link de suporte: '+TWABotLinkSupport(),
                                    buttons:  [
                                        {buttonId: 'continuar', buttonText: {displayText: 'Continuar'}, type: 1},
                                        {buttonId: 'sair', buttonText: {displayText: 'Sair'}, type: 1},
                                      ],
                                    headerType: 1
                                }
                            
                                delay(500)
                    
                                await conn.readMessages([key])
                                await delay(500)
                                        await conn.sendMessage(jid, welcomeMessage)

                              
                            break
                            case "INTENCAO.CONTAS":
                                await conn.readMessages([key])
                                delay(500)
                                let userId
                                isGroup ? userId = message.messages[0].key.participant : userId = jid
                                if(TWABotFileExist({path: '/etc/botvendas/whatsappbot/usuarios/account_recovery.json'})){
                        
                                    fs.readFile('/etc/botvendas/whatsappbot/usuarios/account_recovery.json', {encoding: 'utf-8'}, async (error, data) => {
                                      if(error == null){
                                        const pedido_json = JSON.parse(data)
                                        if(pedido_json.length > 0){
                                          const userExist = pedido_json.find(findEl => findEl.chat_id == userId)
                                          if(userExist != undefined){
                                            var account_list = ''
                                            for(var i in pedido_json){
                                                if(pedido_json[i].chat_id.includes(userId)){
                                                    await conn.sendPresenceUpdate('composing', userId)
                                                    await delay(100)
                                                    await conn.sendMessage(userId, {text:  `
 🏧✅ *CONTA CRIADA COM SUCESSO!* ✅🏧
 🌍 *Servidor:* ${pedido_json[i].ssh_server}
 👤 *Usuário:* ${pedido_json[i].ssh_account}
 🔑 *Senha:* ${pedido_json[i].ssh_password}
 ⏱ *Expira em:* ${pedido_json[i].ssh_expire}
 🗓️ *Validade:* ${pedido_json[i].ssh_validate}
 📲 *Limite:* ${pedido_json[i].ssh_limit}
 #️⃣ *Pedido Nª:* ${pedido_json[i].order_id}
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
Link de download
PlayStore: ${TWABotLinkPlayStore()}
Link Direto: ${TWABotLinkMediafire()}
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
Obrigado por adquirir nosso produto.`})
                                              
                                                }
                                            }
                                          }else{
                                            await conn.sendPresenceUpdate('composing', jid)
                                            await delay(100)
                                            await conn.sendMessage(jid, {text: '*Ainda não confirmamos o seu pagamento. Tente mais tarde.*'})
                                          }
                                
                                           
                                        }else {
                                        
                                            await conn.sendPresenceUpdate('composing', jid)
                                            await delay(100)
                                            await conn.sendMessage(jid, {text: '*Ainda não confirmamos o seu pagamento. Tente mais tarde.*'})
                                        }
                                      }
                                      
                                    })
                                   
                                }else{
                                    await conn.readMessages([key])
                                    await delay(500)
                                    await conn.sendPresenceUpdate('composing', jid)
                                    await delay(100)
                                    await conn.sendMessage(jid, {text: '*Ainda não confirmamos o seu pagamento. Tente mais tarde.*'})
                                }
                            break

                        }



                        
                    })
                }

                if(message.messages[0].message.buttonsResponseMessage != null ){

                    if(message.messages[0].message.buttonsResponseMessage.selectedButtonId == "continuar"){
                        const buttons = [
                            {buttonId: 'comprar_acesso', buttonText: {displayText: 'COMPRAR ACESSO SSH'}, type: 1},
                            {buttonId: 'teste_gratis', buttonText: {displayText: 'CRIAR TESTE GRÁTIS'}, type: 1},
                            {buttonId: 'verificar_pagamento', buttonText: {displayText: 'VERIFICAR PAGAMENTO'}, type: 1},
                        ]
                    
                        const buttonListMessage = {
                            text: "*"+user+"* veja as opções",
                            buttons: buttons,
                            headerType: 1
                        }

                        await conn.readMessages([key])
                        await delay(500)
                        await conn.sendPresenceUpdate('composing', jid)
                        await delay(500)
                        await conn.sendMessage(jid, buttonListMessage)
                    }
 
                    if(message.messages[0].message.buttonsResponseMessage.selectedButtonId == "comprar_acesso"){
                        const buttons = [
                            {buttonId: 'comprar', buttonText: {displayText: 'Comprar'}, type: 1},
                            {buttonId: 'cancelar', buttonText: {displayText: 'Cancelar'}, type: 1},
                          ]
                    
                        const buttonAccounOne ={ 
                    text: `
📌 DETALHES DA COMPRA 📌

👜 *PRODUTO:* ACESSO VPN

💰 *PREÇO:* ${TWABotFirsLoginPrice()} Reais

📅 *VALIDADE:* ${TWABotFirstLoginTime()} Dias

👤 *LIMITE:* ${TWABotLoginLimit()} Dispositivo´s`,
                    buttons: buttons,
                    headerType: 1
                    
                        }
                    

                        await conn.readMessages([key])
                        await conn.sendPresenceUpdate('composing', jid)
                        await delay(500)
                        await conn.sendMessage(jid, buttonAccounOne)
                    }



                    if(message.messages[0].message.buttonsResponseMessage.selectedButtonId == "teste_gratis"){
                        
                        await conn.readMessages([key])
                        await conn.sendPresenceUpdate('composing', jid)
                        await delay(500)
                        await conn.sendMessage(jid, {text: "*Só um momento estou gerando o seu teste grátis*"})

                        TBotZapFreeAccount(isGroup ? message.messages[0].key.participant : jid)
                        .then(async (response) => {
                            if(response.status){

                                const buttons = [
                                    {buttonId: 'btn_playstore', buttonText: {displayText: 'Play Store'}, type: 1},
                                    {buttonId: 'btn_mediafire', buttonText: {displayText: 'Link Direto'}, type: 1},
                                  ]
                            
                                const buttonAccounOne ={ 
                            text: response.payload,
                            footer: 'Para baixar nosso app escolha um dos botões abaixo.',
                            buttons: buttons,
                            headerType: 1
                            
                                }

                                await delay(500)
                                await conn.sendPresenceUpdate('composing', isGroup ? message.messages[0].key.participant : jid)
                                await delay(500)
                                await conn.sendMessage(isGroup ? message.messages[0].key.participant : jid, buttonAccounOne)
                            }else{
                                await delay(500)
                                await conn.sendPresenceUpdate('composing', jid)
                                await delay(500)
                                await conn.sendMessage(jid, {text:"😟 *Sinto muito, mas você já esgotou seu limite de teste grátis. Mas não fique sem internet, aproveite nosso desconto.*"}, {quoted: reply})
                            
                            }
                        })
                    }

                    if(message.messages[0].message.buttonsResponseMessage.selectedButtonId == "suporte_cliente"){
                   
                        await conn.readMessages([key])
                        delay(500)
                        const link_support = "Envie uma mensagem pelo link: "+TWABotLinkSupport()
                        await delay(500)
                        await conn.sendMessage(jid, {text: link_support})

                       
                    }

                    if(message.messages[0].message.buttonsResponseMessage.selectedButtonId == "verificar_pagamento"){
                        await conn.readMessages([key])
                        await delay(500)

                        if(TWABotFileExist({path: '/etc/botvendas/whatsappbot/usuarios/account_recovery.json'})){
                        
                            fs.readFile('/etc/botvendas/whatsappbot/usuarios/account_recovery.json', {encoding: 'utf-8'}, async (error, data) => {
                              if(error == null){
                                const pedido_json = JSON.parse(data)
                                if(pedido_json.length > 0){
                                  const userExist = pedido_json.find(findEl => findEl.chat_id == jid)
                                  if(userExist != undefined){
                                    var account_list = ''
                                    for(var i in pedido_json){
                                        if(pedido_json[i].chat_id.includes(jid)){
                                            await conn.sendPresenceUpdate('composing', jid)
                                            await delay(100)
                                            await conn.sendMessage(jid, {text:  `
 🏧✅ *CONTA CRIADA COM SUCESSO!* ✅🏧
 🌍 *Servidor:* ${pedido_json[i].ssh_server}
 👤 *Usuário:* ${pedido_json[i].ssh_account}
 🔑 *Senha:* ${pedido_json[i].ssh_password}
 ⏱ *Expira em:* ${pedido_json[i].ssh_expire}
 🗓️ *Validade:* ${pedido_json[i].ssh_validate}
 📲 *Limite:* ${pedido_json[i].ssh_limit}
 #️⃣ *Pedido Nª:* ${pedido_json[i].order_id}
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
Link de download
PlayStore: ${TWABotLinkPlayStore()}
Link Direto: ${TWABotLinkMediafire()}
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
Obrigado por adquirir nosso produto.`})
                                      
                                        }
                                    }
                                  }else{
                                    await conn.sendPresenceUpdate('composing', jid)
                                    await delay(100)
                                    await conn.sendMessage(jid, {text: '*Ainda não confirmamos o seu pagamento. Tente mais tarde.*'})
                                  }
                        
                                   
                                }else {
                                
                                    await conn.sendPresenceUpdate('composing', jid)
                                    await delay(100)
                                    await conn.sendMessage(jid, {text: '*Ainda não confirmamos o seu pagamento. Tente mais tarde.*'})
                                }
                              }
                              
                            })
                           
                        }else{
                            await conn.readMessages([key])
                            await delay(500)
                            await conn.sendPresenceUpdate('composing', jid)
                            await delay(100)
                            await conn.sendMessage(jid, {text: '*Ainda não confirmamos o seu pagamento. Tente mais tarde.*'})
                        }

                    }


                    if(message.messages[0].message.buttonsResponseMessage.selectedButtonId == "btn_playstore"){
                   
                        await conn.readMessages([key])
                        delay(500)
                        await delay(100)
                        await conn.sendPresenceUpdate('composing', jid)
                        const link_playstore = "Baixe nosso aplicativo pela Play Store por este link: "+TWABotLinkPlayStore()
                        await delay(500)
                        await conn.sendMessage(jid, {text:link_playstore})
                       
                    }
    
                    if(message.messages[0].message.buttonsResponseMessage.selectedButtonId == "btn_mediafire"){
                       
                        await conn.readMessages([key])
                        delay(500)
                        const link_mediafire = "Baixe nosso aplicativo por este link: "+TWABotLinkMediafire()
                        await delay(500)
                        await conn.sendMessage(jid, {text: link_mediafire})
                       
                    }
        
                    if(message.messages[0].message.buttonsResponseMessage.selectedButtonId == "comprar"){
                        
                        QRcode.generate({chatId: isGroup ? message.messages[0].key.participant : jid})
                        .then(async (payload) => {
                            console.log(payload)
                            await delay(100)
                            await conn.sendPresenceUpdate('composing', payload.chat)
                            await delay(100)
                            await conn.sendMessage(jid, {text: "*Só um momento estou gerando o QRCode.*"})
                            await delay(500)
                            if(payload.status){
                                await delay(500)
                                await conn.sendPresenceUpdate('composing', payload.chat)
                                await delay(200)
                                await conn.sendMessage(jid, {text: `${payload.qrCode}`})
                            }
                            await delay(100)
                            await conn.sendPresenceUpdate('composing', payload.chat)
                            await conn.sendMessage(jid, {text: `Guarde o número do pedido: ${payload.orderId}`})
                            await conn.sendPresenceUpdate('composing', jid)
                            await delay(100)
                            await conn.sendMessage(jid, {text: "O QRCode foi gerado. Assim que confirmarmos o pagamento, você receberá o seu login. *Ou se preferir clique em:* VERIFICAR PAGAMENTO"})
                           
                        })
                    
                    }
                }


            }
        })
 

}
     

TBotZap()
