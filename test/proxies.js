var Experiments = artifacts.require("./Experiments.sol");
var Proxies = artifacts.require("./Proxies.sol");

contract('Proxies', function(accounts){

    it("Initialized the Proxies.", function(){
        return Proxies.deployed().then(function(instance){
            ProxiesInstance = instance;
            return ProxiesInstance.address;
        }).then((address)=>{
            //console.log(address);
            assert.notEqual(address, 0x0, 'Has Contract Address');
            return ProxiesInstance.version();
        }).then((version)=>{
            assert.equal(version, "0.0.1", "Version is correct");
            ProxiesInstance.updateVersion("0.0.2", { from: accounts[0] })
            return ProxiesInstance.version();
        }).then((version)=>{
            assert.equal(version, "0.0.2", "Version has changed correctly");
            return ProxiesInstance.updateVersion("0.0.3", { from: accounts[2] })
        }).then(assert.fail).catch(function(error) {
            assert(error.message.indexOf('revert') >= 0, 'error message must contain revert');
            return ProxiesInstance.version();
        }).then((version)=>{
            assert.equal(version, "0.0.2", "Version is still the same.");
            return ProxiesInstance.contractOwner();
        }).then((owner)=>{
            assert.equal(owner, accounts[0], "We have the correct owner.");
        })
    });

    it("Create Experiment", function(){
        return Proxies.deployed().then(function(instance){
            ProxiesInstance = instance;
            return ProxiesInstance.experimentsContract();
        }).then((address)=>{
            assert.notEqual(address, 0x0, 'Has Experiments Contract Address');
            return ProxiesInstance.createExperiment("Testing the Experiment", {from: accounts[0]});
        }).then((receipt)=>{
            console.log(receipt);
            assert.equal(receipt.logs.length, 1, 'triggers one event');
            assert.equal(receipt.logs[0].event, 'createExperimentEvent', 'should be the "createExperimentEvent" event');
            assert.equal(receipt.logs[0].args.from, accounts[0], 'logs the account that purchased the tokens');
            assert.equal(receipt.logs[0].args.nullHypothesis, "Testing the Experiment", 'has the correct message');
            return "ll";//ProxiesInstance.experimentsContract().experiment(accounts[0])
        }).then((results)=>{
            console.log(results);
        })
    })
});