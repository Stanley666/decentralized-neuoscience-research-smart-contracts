contract Subjects{

    struct Subject {
        string uPortAddress; // for a more verifiable online account
	string birthday; // In MM/DD/YYYY format
        string ethnicity; // Pick one
	string[] hardwareName; // Allow users to 
        uint8 gender; // 0 for male, 1 for female
       	uint256 amountEarned; // amount of ETH or OBL earned
	uint256 experimentsCompleted; // number of experiments completed
	uint256 rating; // The rating provided by experimenters;  
	mapping (address => uint8) experiments; // experiments signed up for        
        
    }
	mapping (address => Subject) public subjects;
	string public experimentsContractAddress; 
	function newSubject(string uPortAddress, string birthday, string ethnicity, uint8 gender){
		subjects[msg.sender].uPortAddress=uPortAddress;
		subjects[msg.sender].birthday=birthday;
		subjects[msg.sender].ethnicity=ethnicity;
		subjects[msg.sender].gender=gender;
		subjects[msg.sender].amountEarned=0;
		subjects[msg.sender].experimentsCompleted=0;
		subjects[msg.sender].rating=0;
	}
	// For Subjects
	function signup(address experimentAddress){
		subjects[msg.sender].experiments[experimentAddress]=1;
	}

	// For Experiments
	// Allow experimenters to rate up / rate down a subject for experiments they have signed up for. Ensure the sending address is the owner of the experiment before allowing rates. 

}
