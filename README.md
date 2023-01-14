## A DEMO RAFFLE CONTRACT
Using Chainlink keepers this raffle contracts automatically picks a winner and transfers the bounty to the winners wallet.
Once players enter the lottery, all they have to do is wait while a Chainlink keeper listens for events in the contract and the decentralized VRF selects one of the addresses and declares it the winner. The Chainlink VRF function is tamper proof and cryptographically ensures randomness, this blocks all sorts of manipulation from competitors and the raffle organizers. Read more about Chainlinks' *Verifiable Random Function* [here](https://chain.link/vrf).
                                                                                                                                                                
The keeper is a decentralized transaction automation solution that enables smart contracts to automate key functions and DevOps tasks in a highly reliable, trust-minimized, and cost-efficient manner.                                                                                                                      
Once a winner is selected the keeper fires the event that gets the winner address paid automatically, without the need of a manual operator.                  
 
Read more about Chainlink keepers [here](https://docs.chain.link/docs/chainlink-keepers/introduction)
                                                     

## Getting Started
### Prerequisites
* npm
  ```sh
  npm install npm@latest -g
  ```
  
  
### Installation
  i. Get a free API Key at [Alchemy](https://alchemyapi.io)
  
  ii. Clone the repo
   ```sh
   git clone https://github.com/jamaltheatlantean/community-we-fund.git
   ```
   
  iii. Install NPM packages
   ```sh
   npm install
   ```
                                                                                                                                                           
   iv. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
   ```
   
   ## INSTALL HARDHAT DEPENDENCIES
```sh
npx save --dev @nomiclabs/hardhat-ethers@npm:hardhat-deploy-ethers ethers @nomiclabs/hardhat-etherscan @nomiclabs/hardhat-waffle chai ethereum-waffle hardhat hardhat-contract-sizer hardhat-deploy hardhat-gas-reporter prettier prettier-plugin-solidity solhint solidity-coverage dotenv
```
   
### Deploy on goerli testnet
  ```
  npx hardhat deploy --network goerli
  ```
  
  You can get some goerli faucet by following steps:
  
  i. Go to https://faucets.chain.link/rinkeby                                                                                                               
  ii. Connect your wallet                                                                                                                                   
  iii. Copy and Paste your address.                                                                                                                         
  iv. Pass the Captcha.                                                                                                                                     
  v. Click on send request and wait confirmation.                                                                                                           
  
  Or for quicker testing on an IDE copy, paste, and hit the compile on [Remix](https://Remix.ethereum.org)
  
  ## ACKNOWLEDGEMENTS
  Big thanks to PatrickCAlpha for his guidance.
  
  Author - JamalTheAtlantean                                                                                                                           
  Reach me [On twitter](https://twitter.com/ThatAtlantean)                                                                                                   
  [Mail](https://gmail.com/jamaltheatlantean)

  Project Link: https://github.com/jamaltheatlantean/AUTO-RAFFLE
