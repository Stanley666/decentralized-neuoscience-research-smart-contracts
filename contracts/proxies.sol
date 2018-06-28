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

    function updateContracts(address _experimentAddr, address _subjectAddr) public isContractOwner {
        
        pastExperimentsAddress.push(_experimentAddr);
        pastSubjectsAddress.push(_subjectAddr);

        emit ContractUpdated(_experimentAddr,_subjectAddr);
    }

    function updateVersion(string _version) public isContractOwner {
        version = _version;
    }

    function createExperiment(string __nullHypothesis) public {
        experimentsContract.createExperiment(__nullHypothesis);
    }

    function getExperiment() public returns (bool success) {
        experimentsContract.experiment[msg.sender] ;
        return true
    }

}
