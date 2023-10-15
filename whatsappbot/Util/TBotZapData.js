const fs = require("fs")

const getFirstLoginPremiumPrice = () =>{
    return fs.readFileSync("/etc/botvendas/valor-login", "utf-8").replace("\n", "")
}
const getFirstLoginPremiumTime = () =>{
    return fs.readFileSync("/etc/botvendas/tempo-conta", "utf-8").replace("\n", "")
}

const getFirstLoginPremiumLimit = () => {
    return fs.readFileSync("/etc/botvendas/acessos", "utf-8").replace("\n", "")
}

const getFirstTextoMenu = () => {
    return fs.readFileSync("/etc/botvendas/textomenu", "utf-8").replace("\n", "")
}

const getFirstLoginMPInfo = () =>{
    return fs.readFileSync("/etc/botvendas/info-mp", "utf-8").replace("\n", "")
}

const getFirstLoginTestTime = () =>{
    return fs.readFileSync("/etc/botvendas/tempo-test", "utf-8").replace("\n", "")
}
const getLinkSupport = () =>{
    return fs.readFileSync("/etc/botvendas/link_suporte", "utf-8").replace("\n", "")
}
const getLinkPlayStore = () =>{
    return fs.readFileSync("/etc/botvendas/link_playstore", "utf-8").replace("\n", "")
}
const getLinkMediafire = () =>{
    return fs.readFileSync("/etc/botvendas/link_mediafire", "utf-8").replace("\n", "")
}

const fileExists = ({path}) => {
    return fs.existsSync(path)
}

const openFile  = ({path}) => { 
   return fs.readFileSync(path, "utf-8")
}

const writeFile = ({path, file}) => {
    try {
        fs.writeFileSync(path, JSON.stringify(file, null, 4))
        return {status: true}
    } catch (error) {
        return {status: false}
    }
}

module.exports = {
    TWABotFirsLoginPrice : getFirstLoginPremiumPrice,
    TWABotFirstLoginTime : getFirstLoginPremiumTime,
    TWABotLoginMPInfo    : getFirstLoginMPInfo,
    TWABotLoginTestTime  : getFirstLoginTestTime,
    TWABotLoginLimit     : getFirstLoginPremiumLimit,
	TWABotTextMenu       : getFirstTextoMenu,
    TWABotLinkSupport    : getLinkSupport,
    TWABotLinkPlayStore  : getLinkPlayStore,
    TWABotLinkMediafire  : getLinkMediafire,
    TWABotFileExist      : fileExists,
    TWABotOpenFile       : openFile,
    TWABoWriteFile       : writeFile
}