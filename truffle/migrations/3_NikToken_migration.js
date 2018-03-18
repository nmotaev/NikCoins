var NikToken = artifacts.require("./NikToken.sol");
var SafeMath = artifacts.require("./SafeMath.sol");

module.exports = function(deployer) {
  deployer.link(SafeMath, NikToken);
  deployer.deploy(NikToken);
};
