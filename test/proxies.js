
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
        })
    });

    it("Populate Experiment with data.", function(){
        return Proxies.deployed().then(function(instance){
            ProxiesInstance = instance;
            ProxiesInstance.postExperiment("Post Title 1", "Post Description 1", {from : accounts[0]});
            return ProxiesInstance.experimentSize();
        }).then((experimentSize)=>{
            //console.log("Experiment Size 1", experimentSize.toNumber());
            return ProxiesInstance.experiments(experimentSize.toNumber());
        }).then((addrClient)=>{
            //console.log("struct Data Structure:", addrClient)
            assert.equal(addrClient[0], accounts[0], "Correct Client Ids");
            ProxiesInstance.postExperiment("Post Title 2", "Post Description 2", {from : accounts[0]});
            return ProxiesInstance.experimentSize();
        }).then((experimentSize)=>{
            //console.log("Experiment Size 2", experimentSize.toNumber());
            return ProxiesInstance.experiments(experimentSize.toNumber());
        }).then((addrClient)=>{
            assert.equal(addrClient[0], accounts[0], "Correct Client Ids");
            ProxiesInstance.postExperiment("Post Title 3", "Post Description 3", {from : accounts[0]});
            return ProxiesInstance.experimentSize();
        }).then((experimentSize)=>{
            //console.log("Experiment Size 3", experimentSize.toNumber());
            return ProxiesInstance.experiments(experimentSize.toNumber());
        }).then((addrClient)=>{
            assert.equal(addrClient[0], accounts[0], "Correct Client Ids");
            ProxiesInstance.postExperiment("Post Title 4", "Post Description 4", {from : accounts[2]});
            return ProxiesInstance.experimentSize();
        }).then((experimentSize)=>{
            //console.log("Experiment Size 4", experimentSize.toNumber());
            return ProxiesInstance.experiments(experimentSize.toNumber());
        }).then((addrClient)=>{
            assert.equal(addrClient[0], accounts[2], "Correct Client Ids");
        })
    });


    it("Get back all the Experiment Data.", function(){
        let experimentSize;
        return Proxies.deployed().then(function(instance){
            ProxiesInstance = instance;
            return ProxiesInstance.experimentSize();
        }).then((length)=>{
            experimentSize = length.toNumber();
            //console.log(length.toNumber()) 
            //console.log(experimentSize);
            return ProxiesInstance.experimentTitles(experimentSize);
        }).then((titleStr)=>{
            //console.log(titleStr);
            assert.equal(titleStr, "Post Title 4", "Correct Title");
        })
    });


    it("Get back all the Experiment Data.", function(){
        let experimentSize;
        return Proxies.deployed().then(function(instance){
            ProxiesInstance = instance;
            return "ProxiesInstance.experimentsListByIds(accounts[0]).push(new Array(accounts[0], 1, 1, true));"
        }).then((reply)=>{
            console.log(reply);
            return ProxiesInstance.experimentsListByIds[accounts[0]];
        }).then((reply)=>{
            console.log(reply);
        })
    });


});