# example_NFT
An example NFT project with corresponding solidity smart contract code.

# NFT from A to Z
In this repository, we will go over how to write and deploy an NFT ERC-721 smart contract on the Ropsten test network. 

We will use MetaMask, Solidity, Hardhat, Pinata, and Alchemy.

## 1. Connect to Ethereum network.
There are many ways to interact with the Ethereum blockchain, but to simplify things, we will leverage functionality from Alchemy using one of their free accounts. 

Their blockchain API will enable us to avoid running our own nodes.

## 2. Create your App (and API key).
Create a free account on Alchemy, and follow their prompts to get registered.

I named my app "Example NFT", chose the "Staging" environment and "Ropsten" test network.

## 3. Create an Ethereum Account (Address).
We'll want to make a new Ethereum address which will be associated with our NFT project and contract.

Note: It is important to have separate wallets to promote safety and security of one's assets. 
For example, it is wise to have 3 wallets minimum--one for minting, one for listings/sales, and a cold storage vault. 
However, contract wallets should remain separate from personal wallets to ensure transparency and accurate measurement of KPIs.

Having made a new Ethereum wallet address, "Example NFT Wallet", make sure to switch over to the "Ropsten Test Network" (allows us to not use real funds).

## 4. Add Ether from a Faucet.
We'll need some fake ETH in order to deploy our smart contract on the test network.

Visit https://fauceth.komputing.org/, enter your Ropsten account address, click "Request funds", select "Ethereum Testnet Ropsten, and voila!

## 5. Check your balance.
We can check our balance by making an `eth_getBalance` request using Alchemy' composer tool.
If everything worked correctly, we should see a response like this:
`{"jsonrpc": "2.0", "id": 0, "result": "0xde0b6b3a7640000"}`

Note: this result is in wei, not ETH. 1 Ether = 1000000000000000000 Wei (10^-18). 
If we convert the balance to a float we should get 1*10^18 Wei = 1 ETH.

## 6. Initialize our project.
Clone this or your NFT git repository, or make a new directory for your NFT project in your workspace (directory of choice), e.g: `/home/user/Code/example_NFT`.
Now, change your current directory to the project directory with `cd example_NFT`.

Now at the root of our project folder, we'll use npm to initialize the project.

To install npm, follow these instructions: https://docs.alchemy.com/alchemy/guides/alchemy-for-macs#1-install-nodejs-and-npm.
Open a new terminal and in your home/user (`cd ~`) directory run the command:
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`.
Next, we will need to add Homebrew to our `PATH` with the following commands:
`echo 'eval "$(/home/jmosquera/.linuxbrew/bin/brew shellenv)"' >> /home/jmosquera/.zprofile`
and
`eval "$(/home/jmosquera/.linuxbrew/bin/brew shellenv)"`.
We can test our installation with
`brew help`,
or
`brew install hello`.
Next, instll `NodeJS` and `npm` using Homebrew (npm will be installed with Node):
`brew install node`.
You can now run Javascript in the terminal:
`node`.

### Optionally, we may want to install Alchemy Web3:
Alchemy Web3 is a drop-in replacement for web3.js, built and configured to work seamlessly with Alchemy (e.g: automatic retries and WebSocket support).
If you wish to do so,, in the command line in your home directory run:
`npm install @alch/alchemy-web3`.

### Optionally, install WebSockets:
WebSockets are a way to subscribe to events and changes. First, install WebSocket cat:
`npm install -g wscat`.
Now connect to Alchemy's infrastructure using WebSockets with:
`wscat -c wss://eth-mainnet.ws.alchemyapi.io/ws/demo`
or
`wscat -c wss://eth-mainnet.alchemyapi.io/ws/<api-key>`.
Create a Web3 instance and set your provider as Alchemy:
`const web3 = new Web3("wss://eth-mainnet.ws.alchemyapi.io/ws/demo");`

Finally, after all those installations, in the root of our project repo run the command: `npm init`.

Here is how we answered the installation questions:
`
package name: (example_NFT)
version: (1.0.0)
description: 
entry point: (index.js)
test command:
git repository: https://github.com/bourne2invest/example_NFT.git
keywords:
author:
license: (ISC)
About to write to /home/user/Code/example_NFT/package.json:

{
  "name": "example_NFT",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC"
}
`

Last, but certainly not least, approve the `package.json` and it's off to the races!

## 7. Install Hardhat.
