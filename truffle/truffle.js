var HDWalletProvider = require("truffle-hdwallet-provider");
function getMnemonic() {
    var jsonContent = require('fs').readFileSync("./secrets.json", "utf8").trim();

    return JSON.parse(jsonContent);
}

module.exports = {
    networks: {
        main: {
            network_id: 1,
            provider: new HDWalletProvider(getMnemonic().mnemonic, 'https://mainnet.infura.io/'),
            gas: 4700000,
            gasPrice: 1000000000
        },
        rinkeby:{
            network_id:4,
            provider: new HDWalletProvider(getMnemonic().mnemonic, 'https://rinkeby.infura.io/'),
            gas: 4700000,
            gasPrice: 10000000000
        },
        development: {
            host: "127.0.0.1",
            port: 8545,
            network_id: "*" // Match any network id
        }
    }
};
