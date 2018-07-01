pragma solidity ^0.4.23;

/* TODO: decentralized neuroscience */


contract Proxies {

    enum rewardTypes {OBL,ETH}

    struct Experiment {
        address client;
        uint prev;
        uint next;
        bool isActive;
    }
    
    mapping(uint => string) public experimentTitles;
    mapping(uint => string) public experimentDescriptions;
    mapping(uint => Experiment) public experiments;

    mapping(address => Experiment[] ) public experimentsListByIds;

    uint public experimentSize;
    uint public lastExperimentIndex;

    uint public EXPERIMENT_DAYS = 3 days;

    string public version = "0.0.1";
    address public owner;
    

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function updateVersion(string _ver) public onlyOwner {
        version = _ver;
    }

    function postExperiment(string _title, string _description) public {
        experimentSize++;

        experimentTitles[experimentSize] = _title;
        experimentDescriptions[experimentSize] = _description;

        experiments[experimentSize].client = msg.sender; 
        experiments[experimentSize].isActive = true;

        experimentsListByIds[msg.sender].push(Experiment(msg.sender, 1, 1, true));


        //linked list connecting
        experiments[experimentSize].prev = lastExperimentIndex;
        if(lastExperimentIndex > 0) {
            experiments[experimentSize].next = experimentSize;
        }
        lastExperimentIndex = experimentSize;

    }

}
