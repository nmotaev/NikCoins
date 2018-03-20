var Contract = artifacts.require("./Exchange.sol");
var SafeMath = artifacts.require("./SafeMath.sol");

module.exports = function(deployer) {
    deployer.link(SafeMath, Contract);
    deployer.deploy(Contract);
};
