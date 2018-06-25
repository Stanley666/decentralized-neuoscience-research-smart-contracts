contract Proxies{
	address contractOwner = ""; // SQ's address for updating contracts
	address public experimentsAddress;
	address public subjectsAddress;
	address[] public pastExperimentsAddress;
	address[] public pastSubjectsAddress;
	event ContractUpdated(
		address experimentAddress;
		address subjectAddress;
	)
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
}
