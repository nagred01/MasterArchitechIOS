const blacklist = require('metro').createBlacklist;

module.exports = {
    getBlacklistRE: function(){
        return blacklist([/src\/*.*/]);
    }
}