var experiments = artifacts.require("./Experiments.sol");
var proxies = artifacts.require("./Proxies.sol");

module.exports = function(deployer) {
  deployer.deploy(experiments).then(function(){
    return deployer.deploy(proxies, experiments.address);
  });
};