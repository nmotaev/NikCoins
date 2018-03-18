var Contract = artifacts.require("./SafeMath.sol");

module.exports = function(deployer) {
  deployer.deploy(Contract);
};
