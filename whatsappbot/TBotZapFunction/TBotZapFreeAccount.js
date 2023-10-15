const { delay } = require('@adiwajshing/baileys')
const {TBotZapLoginTest} = require('../TBotZapClass/TBotZapCreateTest')
const TBotZapFreeAccount = async (jid) => {
    return new Promise(async (resolve, reject) => {
        TBotZapLoginTest.create(jid)
        .then((response) => {
            if(response.status.includes("user_not_exists")){
                TBotZapLoginTest.createTest({userId: jid})
                .then((account_ssh) => {
                    resolve({status: true, payload: `
🆓✅ *CONTA TESTE CRIADA!* ✅🆓
🌍 *Servidor:* ${account_ssh.servidor}
👤 *Usuário:* ${account_ssh.usuario}
🔑 *Senha:* ${account_ssh.senha}
⏱ *Expira em:* ${account_ssh.expira}
📲 *Limite:* ${account_ssh.limite}
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
Obrigado pela preferência.`})
                })
            }else if(response.status.includes("database_not_exists")){
                TBotZapLoginTest.createTestAndDatabase({userId: jid})
                .then((account_ssh) => {
                    resolve({status: true, payload: `
🆓✅ *CONTA TESTE CRIADA!* ✅🆓
🌍 *Servidor:* ${account_ssh.servidor}
👤 *Usuário:* ${account_ssh.usuario}
🔑 *Senha:* ${account_ssh.senha}
⏱ *Expira em:* ${account_ssh.expira}
📲 *Limite:* ${account_ssh.limite}
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
Obrigado pela preferência.`})
                })

            }else if(response.status.includes("user_already_exists")){
                resolve({status: false})
            }


        })
    })
}
module.exports.TBotZapFreeAccount = TBotZapFreeAccount