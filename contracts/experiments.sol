pragma solidity ^0.4.23;

contract Experiments {

    struct Experiment {
        address experimenter;
        string nullHypothesis;
    }

    mapping (address => Experiment) public experiment;

    event createExperimentEvent(address indexed from, string indexed nullHypothesis);

    function () public {}

    function createExperiment(string _nullHypothesis) public{
        //require(!experiment[msg.sender].experimenter);

        experiment[msg.sender].experimenter = msg.sender;
        experiment[msg.sender].nullHypothesis = _nullHypothesis;

        emit createExperimentEvent(msg.sender, _nullHypothesis);
    }
}
