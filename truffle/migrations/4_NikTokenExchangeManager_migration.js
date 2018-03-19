var Contract = artifacts.require("./TokenExchangeManager.sol");

module.exports = function(deployer) {
    deployer.deploy(Contract);
};
