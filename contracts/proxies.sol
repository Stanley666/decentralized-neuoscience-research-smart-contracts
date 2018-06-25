/*contract Proxies{
	address contractOwner = ""; // SQ's address for updating contracts
	address public experimentsAddress;
	address public subjectsAddress;
	address[] public pastExperimentsAddress;
	address[] public pastSubjectsAddress;
	event ContractUpdated(
		address experimentAddress;
		address subjectAddress;
	)

	modifier isOwner(){
		require(msg.sender == owner);
		_;
	}
	function updateContracts(address expAddr, address subjAddr){
		if(msg.sender==contractOwner){
			// Allow scripts to search prior experiments in case a smart contract update breaks an experiment
			pastExperimentsAddress.push(experimentAddress);
			pastSubjectsAddress.push(subjectsAddress);
			// New scripts will look here first for experiments/subjects
			experimentAddress=expAddr;
			subjectsAddress=subjAddr;
			ContractUpdated(expAddr,subjAddr);
		}
	}
}*/

pragma solidity ^0.4.23;

import "./Experiments.sol";

contract Proxies {
    string public version = "0.0.1";
    address public contractOwner;
    address[] public pastExperimentsAddress;
    address[] public pastSubjectsAddress;

    Experiments public experimentsContract;

    event ContractUpdated(address experimentAddr, address subjectAddr);

    modifier isContractOwner() {
        require(msg.sender == contractOwner);
        _;
    }

    constructor(Experiments _experimentsContract) public {
        contractOwner = msg.sender;
        experimentsContract = _experimentsContract;
    }

    function updateContracts(address _experimentAddr, address _subjectAddr) public {
        require(msg.sender == contractOwner);
        pastExperimentsAddress.push(_experimentAddr);
        pastSubjectsAddress.push(_subjectAddr);
        emit ContractUpdated(_experimentAddr,_subjectAddr);
    }

    function updateVersion(string _version) public isContractOwner {
        //require(msg.sender == contractOwner);
        version = _version;
    }

    function createExperiment(string __nullHypothesis) public {
        experimentsContract.createExperiment(__nullHypothesis);
    }

}
