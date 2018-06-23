# Decentralized Neuroscience Research Smart Contracts

These are basic smart contracts for running decentralized neuroscience experiments, public and private, over the Ethereum Ropsten network. Anyone can submit an experiment and choose whether to make the data public or private only to them. These contracts are/will-be used in Project Oblio's proof-of-concept demo in conjunction with Vybuds or any other EEG tool an experimenter may be interested in. However, note that consumer EEGs on the market do not have a tACS component attached, meaning that they are limited in their ability to self-validate data. 

These smart contracts are *not* the underlying smart contracts used in human detection, identification, and maintaining a one-person-one-vote budget system within the Project Oblio. These smart contracts, including the fork of geth used to maintain the network ("go-oblio") are under private development. 
 
## Features
- [x] Basic experiments smart contract, including listing null hypotheses, paying subjects for data, broadcasting completions, ratings, and other important experiment events. 
- [x] Enable both Public and Private experiments. Public Experiments will post subject data over IPFS and can be funded by Project Oblio's budget system, while private experiments allow the experiment creator to maintain control over the data.
- [x] Basic subjects contract that records a subject's relevant data, if applicable. 
- [x] Draft of a proxies contract controlled by benevelant centralization until Project Oblio's budget system can vote on experiment updates. 

## TODO (short-term)
- [ ] Compile, launch, test... 
- [ ] The proxy contract is intended to point to the "most recent" subject.sol and experiments.sol smart contracts. The owner of the proxies.sol contract should be able to update the ethereum address of these contracts, so apps only have to look at the proxies.sol address for the most recent contract. Modify the proxy contract for easily updating the subject/experiment smart contracts when launched, including updating the versions of contracts. 
- [ ] Enable communication between experiments and subjects contracts. Experimenters must be able to post an experiment with "Subject Requirements" and to read a potential subject's posted data (gender, ethnicity, etc) before allowing them to sign up for an experiment. Experimenters must be able to ONLY rate subjects who are part of their experimenters -- there must be a check to ensure that only valid experimenters can rate subjects and not anyone else. Within a subject's data structure there should be review array of each expeirment that they have participated in (similar to Fiverr). There must be a check to ensure that subjects cannot sign up for an experiment that has run out of ethereum/rewards. There must be checks to ensure that a subject's sent data matches appropriate formats (e.g. the string for birthdate must be in the form MM/DD/YYYY and not MM/DD/YY.). Include a "permissions" structure inside the Experiments contract where Experimenters must list the permissions that their experiments access from a user's cell phone (Microphone, Camera, Etc).
- [ ] Within the subjects contract, create an array of "currently participating experiments" and list any experiments that a subject has done by address. Create an array of "previously participated experiments" and their rating if not done in the last step.
- [ ] Compile, launch test, again


## TODO (long-term)
- [ ] Enable uPort integration for improving quality of subject participation
- [ ] Create an "Anonymous" Contract system, where subject identities are kept private. (This is probably best done off-chain, but should still be an option.)

## Experiments
An experiment is a privately-hosted ionic website that accesses the native vybuds plugins offered by the Project Oblio iOS and Android apps. Basically, a person who wants to host an experiment sends an amount of Ether to the Experiments smart contract, and is then allowed to subtract from the smart contract's balance each time they want to reward a subject for their data. Subjects are able to rate experiments, view null hypotheses, and view whether other subjects have received payment / had a good overrall experience with the research project. The Experiment contract also enables a start and end date for subject sign-ups, but still needs more features, including limiting the maximum number of subjects. An experiment runner (which may be the Project Oblio budget system) is expected to manually distribute rewards to those who have submitted good data. 

## Subjects
A subject is a list of biographical information and a rating for past experiment participation. It keeps track of their race, age, Vybuds version, and total amount earned over the history of the Project Oblio. In a future version, the Subjects contract will be a lot more important, as it will enable Experiments to target specific groups (e.g. targeting users over over the age of 60 for a prevention of Alzheimer's experiment). 

## Proxies
Proxies enable a developer to update Experiments.sol and Subjects.sol, when launched on a blockchain, for fluid engineering of future contracts. It ensures backwards-compatability of previous experiments by keeping a running list of prior releases. 

## Supported Platforms
* Ethereum
* Ethereum testnets
* Project Oblio (when launched)



## License
[MIT License](https://github.com/Project-Oblio/decentralized-neuroscience-research-smart-contracts/blob/master/LICENSE)

