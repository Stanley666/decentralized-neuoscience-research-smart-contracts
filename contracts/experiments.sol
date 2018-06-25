contract Experiments{

    struct Experiment {
        uint8 experimentType; // 0 for public, 1 for private
        string nullHypothesis;
        string longDetails;
        string pluginLink; // link to the ionic-cordova plugin URL where the experiment is loaded from 
        string openSourceLink; // link to the github / bitbucket where its code is hosted, if applicable.
        uint8 rewardType; // OBL or ETH 
        uint8 rewardFrequency; // 0 for single, 1 for ongoing
        uint8 maxReward; // 0 for infinite, other for maximum earned. Per user
        uint256 rewardPool; // Amount of reward left, must be 
        uint256 startBlock; // When to start the experiment
        uint256 endBlock; // When to end the experiment
        // Performed by experimenters:
        uint256 paidOut; 
        
        // Performed by users: 
        uint8 rating; 
        mapping (address => uint8) subjects; 
       
        // Only for public experiments:
        mapping (address => string[]) subjectData; // IPFS links where data will be hosted
        
        
    }
	mapping (address => Experiment) public experiments;
   	string public subjectsContractAddress; 
  	event Signup(
		address experimentAddress;
		address subjectAddress;
        )
	event PublicDataSubmitted(
		address experimentAddress;
		address subjectAddress;
		string IPFSaddress;
	)
	event PrivateDataSubmitted(
		address experimentAddress;
		address subjectAddress;
	)
	event RatingChanged(
		address experimentAddress;
		address subjectAddress;
		uint8 ratingChangedByAmount;
		uint8 UpOrDown; // 0 for down, 1 for up 
	)
	event SubjectBanned(
		address experimentAddress;
		address subjectAddress; 
	)
 	event ExperimentOver(
		address experimentAddress; 
	)
    

    function createExperiment(uint8 experimentType,string nullHypothesis,string longDetails, 
    string pluginLink,uint8 rewardType, string openSourceLink) public{
        experiments[msg.sender].nullHypothesis=nullHypothesis;
        experiments[msg.sender].longDetails=longDetails;
        experiments[msg.sender].pluginLink=pluginLink;
        experiments[msg.sender].rewardType=rewardType;
        experiments[msg.sender].rewardFrequency=rewardFrequency;
        experiments[msg.sender].maxReward=maxReward;
        experiments[msg.sender].rewardPool=msg.value; // msg.value is added to smart contract's balance
        experiments[msg.sender].startBlock=startBlock;
        experiments[msg.sender].endBlock=endBlock;
        expeirments[msg.sender].openSourceLink=openSourceLink;
    }
    
    // Experimenter functions:
    function sendReward(unit256 amount, address subjectAddress){
        if(experiments[msg.sender].subjects[subjectAddress]>0){
            if(experiments[msg.sender].rewardPool=
            experiments[msg.sender].rewardPool=experiments[msg.sender].rewardPool-amount;
            
            subjectAddress.transfer(amount);
            experiments[msg.sender].paidOut = experiments[msg.sender].paidOut+amount;
        }
    }
    function banSubject(address subjectAddress){
        // Ban a subject from posting data
       experiments[msg.sender].subjects[subjectAddress]=0;
	emit SubjectBanned(experiment,subjectAddress);
    }
    // User functions:
    function signUp(address experimentAddress){
        if(experiment[experiment].subjects[msg.sender]>0){
		experiments[experimentAddress].subjects[msg.sender]=1;
		emit Signup(experimentAddress,msg.sender);
	}
    }
    function rateUp(uint8 rating, address experiment){
	if(experiment[experiment].subjects[msg.sender]>0 && experiment[experiment].subjects[msg.sender] < 2){
     	   experiments[msg.sender].rating=experiments[msg.sender]+rating;
	   emit RatingChanged(experiment,msg.sender,rating,1);
		experiment[experiment].subjects[msg.sender]=2; // prevent same subject from rating multiple times
        }
    }
    function rateDown(uint8 rating, address experiment){
	if(experiment[experiment].subjects[msg.sender]>0 && experiment[experiment].subjects[msg.sender]< 2){
		experiments[msg.sender].rating=experiments[msg.sender]-rating;
		emit RatingChanged(experiment,msg.sender,rating,0);
		experiment[experiment].subjects[msg.sender] =2;  // prevent same subject from rating multiple times
	}
    }
    function postData(string IPFSaddress,address experiment){
       if(experiments[experiment].subjects[msg.sender]>0){
	   if(experiments[experiment].experimentType==0){
		   experiments[experiment].subjectData[msg.sender].push(IPFSaddress);
		   emit PublicDataSubmitted(experiment,msg.sender,IPFSaddress);
	   }else{
			emit PrivateDataSubmitted(experiment,msg.sender);
		}
       }
    }
}
