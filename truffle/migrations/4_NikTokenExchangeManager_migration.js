var Contract = artifacts.require("./NikTokenExchangeManager.sol");

module.exports = function(deployer) {
  deployer.deploy(Contract);
};
