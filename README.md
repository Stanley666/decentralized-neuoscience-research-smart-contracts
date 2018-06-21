# Decentralized Neuroscience Research Smart Contracts

These are basic smart contracts for running decentralized neuroscience experiments, public and private, over the Ethereum Ropsten network. Anyone can submit an experiment and choose whether to make the data public or private only to them. These contracts are/will-be used in Project Oblio's proof-of-concept demo in conjunction with Vybuds or any other EEG tool an experimenter may be interested in. However, note that consumer EEGs on the market do not have a tACS component attached, meaning that they are limited in their ability to self-validate data. 

These smart contracts are *not* the underlying smart contracts used in human detection, identification, and maintaining a one-person-one-vote budget system within the Project Oblio. These smart contracts, including the fork of geth used to maintain the network ("go-oblio") are under private development. 
 
## Features
- [x] Basic experiments smart contract, including listing null hypotheses, paying subjects for data, broadcasting completions, ratings, and other important experiment events. 
- [x] Enable both Public and Private experiments. Public Experiments will post subject data over IPFS and can be funded by Project Oblio's budget system, while private experiments allow the experiment creator to maintain control over the data.
- [x] Basic subjects contract that records a subject's relevant data, if applicable. 
- [x] Draft of a proxies contract controlled by benevelant centralization until Project Oblio's budget system can vote on experiment updates. 

## TODO 
- [ ] Compile, launch, test... This is mostly just a proof-of-concept for explaining the Project Oblio, right now. 
- [ ] Enable uPort integration for improving quality of subject participation
- [ ] Modify the proxy contract for easily updating the subject/experiment smart contracts when launched, including updating the versions of contracts
- [ ] Enable communication between experiments and subjects contract so that experiments can be tailored only to subjects with particular features 
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

