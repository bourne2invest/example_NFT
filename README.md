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

Having made a new Ethereum wallet address, "Example NFT Wallet", make sure to switch over to the "Ropsten Test Network" (allows us to not use real funds).

## 4. Add Ether from a Faucet.
We'll need some fake ETH in order to deploy our smart contract on the test network.

If you have a Google account you can get up to 5 Ropsten testnet ETH at a time from https://ropsten.oregonctf.org/. 
Another faucet is https://faucet.egorfine.com/, which limits you to .2 rETH per day.

## 5. Check your balance.
We can check our balance by making an `eth_getBalance` request using Alchemy' composer tool.
If everything worked correctly, we should see a response like this:
`{"jsonrpc": "2.0", "id": 0, "result": "0x482a1c7300080000"}`

Note: this result is in wei, not ETH. 1 Ether = 1000000000000000000 Wei (10^-18). 
If we convert the result from hexadecimal to decimal, we should get 5200000000000000000 Wei = 5.2 ETH.

We can also check our balance in our Metamask while on the Ropsten Test Network, or on the Ropsten Testnet Explorer: https://ropsten.etherscan.io/.

## 6. Initialize our project.
Clone this or your NFT git repository, or make a new directory for your NFT project in your workspace (directory of choice), e.g: `/home/user/Code/example_NFT`.

To install npm, follow these instructions: https://docs.alchemy.com/alchemy/guides/alchemy-for-macs#1-install-nodejs-and-npm.
Open a new terminal and in your `/home` directory run the command:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Next, we will need to permanently add Homebrew to our `PATH` by placing the following in our `.zshrc` or `.bashrc` files:
```
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/user/.zprofile && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

We can test our installation with
```
brew help
```
or
```
brew doctor
```

Next, install `NodeJS` and `npm` using Homebrew (npm will be installed with Node) with:
```
brew install node
```
You can now run Javascript in the terminal by running the command:
```
node
```

### Optionally, we may want to install Alchemy Web3:
Alchemy Web3 is a drop-in replacement for web3.js, built and configured to work seamlessly with Alchemy (e.g: automatic retries and WebSocket support).
If you wish to do so, in the command line in your home directory run:
```
npm install @alch/alchemy-web3
```

### Optionally, install WebSockets:
WebSockets are a way to subscribe to events and changes. First, install WebSocket cat:
```
npm install -g wscat
```

Now connect to Alchemy's infrastructure using WebSockets with:
```
wscat -c wss://eth-mainnet.ws.alchemyapi.io/ws/demo
```
or
```
wscat -c wss://eth-mainnet.alchemyapi.io/ws/<api-key>
```
Create a Web3 instance and set your provider as Alchemy:
```
const web3 = new Web3("wss://eth-mainnet.ws.alchemyapi.io/ws/demo");
```

### Finally, after all those installations, in the root of our project repo run the command:
```
npm init
```
This will walk us through making a `package.js` file, and will initialize the project.

Here is how we answered the installation questions:
```
package name: (example_nft) 
version: (1.0.0) 
description: An example NFT template.
entry point: (index.js) 
test command: 
git repository: (https://github.com/bourne2invest/example_NFT.git) 
keywords: 
author: Creative Dev
license: (ISC) 
About to write to /home/user/Code/example_NFT/package.json:

{
  "name": "example_nft",
  "version": "1.0.0",
  "description": "An example NFT template.",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/bourne2invest/example_NFT.git"
  },
  "author": "Creative Dev",
  "license": "ISC",
  "bugs": {
    "url": "https://github.com/bourne2invest/example_NFT/issues"
  },
  "homepage": "https://github.com/bourne2invest/example_NFT#readme"
}
```

Last, but certainly not least, approve the `package.json` and it's off to the races!

## 7. Install Hardhat.
