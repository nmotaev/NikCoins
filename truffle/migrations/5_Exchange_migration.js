var Contract = artifacts.require("./Exchange.sol");

module.exports = function(deployer) {
    deployer.deploy(Contract);
};
