# example_NFT
## NFT from A to Z
An example NFT project with corresponding solidity smart contract code.

# Part 1: How to write & deploy an NFT smart contract.
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
Hardhat is a development environment to compile, test, deploy and debug our Ethereum software.
It is helpful for building smart contracts and dApps locally before deploying to the mainnet.
It is used through a local installation at the project-level, and helps us make reproducible environments to avoid future version conflicts.

At the root of our project repo run:
```
npm install --save-dev hardhart
```

## 8. Create Hardhat project.
We will use `npx` to run our local installation of Hardhat.
At the root of our project folder run:
```
npx hardhat
```

We will see a welcome message. 
Select the option "create an empty hardhat.config.js".
This will create a hardhat.config.js file, which is where we will structure our project.

## 9. Add project folders.
We will organize our project with folders.
At the root of our project repo, create directories for `contracts` and `scripts`:
```
mkdir contracts
mkdir scripts
```

In `contracts/` we will keep our NFT smart contract code.
In `scripts/` we will keep scripts to deploy and interact with our smart contract.

## 10. Write our contract.
Now that we have successfully set up our NFT development environment, it's time for the fun stuff: developing our smart contract code!

In the contracts folder, create a new file called `ExampleNFT.sol` If you are using an IDE like VSCode, you'll probably need a solidity or Ethereum extension.

Usually, at the beginning of a Solidity smart contract file, you'll see a line:
```
pragma solidity ^0.8.0;
```
This line sets the version of Solidity the contract will be written in.

Next, the lines,
```
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
```
will allow us to leverage existing and packaged smart contract code from the OpenZeppelin contracts library.
This will allow us to simplify our smart contracts and not have to re-invent the wheel so to speak (like using `pandas`, `numpy`, `seaborn`, `sklearn`, etc).

Let's break it down further:
```
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
```
This file contains the implementation of the ERC-721 standard, which our NFT smart contract will inherit.
All smart contracts must implement methods of the ERC-721 standard to be a valid NFT.

```
import "@openzeppelin/contracts/utils/Counters.sol";
```
This file provides counters that can only be incremented or decremented by one.
Our smart contract will use a counter to keep track of the total number of NFTs minted, and set the unique IDs on our NFTs.
For e.g: unique IDs will be determined by the total number of NFTs, and so our first NFT minted will have the ID "1", and so on.

```
import "@openzeppelin/contracts/access/Ownable.sol";
```
This allows us to use "access control" on our smart contract, so only the owner of the smart contract (you) can mint NFTs.
To allow any party to mint an NFT using our smart contract, remove the word `Ownable` on `line 10`, and `onlyOwner` on `line 17`.

After our imports, we have our custom example NFT smart contract.
This is a simple contract which contains only a counter, constructor, and single function.
Again, this is because we are leveraging functionality from OpenZeppelin contracts library, which implements methods needed to create an NFT for us.
For e.g: `ownerOf` which returns the owner of the NFT, and `transferFrom`, which transfers owndership of the NFT from one account to another.

In our ERC-721 constructor, we pass 2 strings: "ExampleNFT" and "NFT". 
The first variable is the smart contract's name.
The second variable is the contract's symbol.

Finally our mint function, `mintNFT`, which actually allows us to mint our NFT, accepts 2 variables:
`address recipient` specifies the address that will receive the newly minted NFT.
`string memory tokenURI` is a string which resolves to a JSON describing the NFT metadata.
I.e: `string memory tokenURI` is responsible for the name, description, image, etc. you see on OpenSea or LooksRare.

`mintNFT` actually calls methods from the ERC-721 libraries we imported and finally returns a number (`uint256`) which represents the ID of the minted NFT.

## 11. Connect Metamask and Alchemy to our project.
Now that we have a MetaMask wallet, Alchemy account and a smart contract, it's time to connect all three.
Every txn sent from your wallet requires a signature using your unique private key.
In order to provide our program with this permission, we can safely store our private key (and Alchemy API key) in an environment file.

First, intall the `dotenv` package in our project dir:
```
npm install dotenv --save
```

Now, create a `.env` file in the root of our project, and we will add our MetaMask private key and HTTP Alchemy API URL.
Our `.env` should now look like this:
```
API_URL="https://eth-ropsten.alchemyapi.io/v2/your-api-key"
PRIVATE_KEY="your-metamask-private-key"
```

Now, to actually connect these to our code, we'll reference these variables in our `hardhat.config.js` file in step 13.

## 12. Install Ethers.js
Ethers.js is a library which makes interacting and making requests to the Ethereum network easier by wrapping the standard JSON-RPC methods with ones that are more user friendly.
Hardhat makes it easy to integrate plugins for additional functionality.
We'll be using the Ethers plugin for contract deployment.

In our project root dir type:
```
npm install --save-dev @nomiclabs/hardhat-ethers ethers@^5.0.0
```

## 13. Update hardhat.config.js
Now that we have added several dependencies and plugins, we need to update our `hardhat.config.js` so our project knows about them.

Update your `hardhat.config.js` so it looks like the following:
```
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
require('dotenv').config();
require("@nomiclabs/hardhat-ethers");
const { API_URL, PRIVATE_KEY } = process.env;
module.exports = {
  solidity: "0.8.1",
  defaultNetwork: "ropsten",
  networks: {
    hardhat: {},
    ropsten: {
      url: API_URL,
      accounts: [`0x${PRIVATE_KEY}`]
    }
  }
};

```

## 14. Compile our contract
In order to make sure everything works so far, we need to compile our contract. 
Fortunately, the compile task is built-in to hardhat.
Simply run:
```
npx hardhat compile
```

Note: I got a warning saying I am using a version of Node.js note supported by Hardhat.
I checked my version with
```
node --version
>>> v17.8.0
```
I ended up trying to update this with:
```
brew update
brew doctor
brew upgrade node
```
but I got an error "Warning: node 17.8.0 is already installed.
So I am just going to ignore this for now given that the other message I got from running `npx hardhat compile` was:
```
Downloading compiler 0.8.1
Compiled 13 Solidity files successfully
```

## 15. Write our Deploy script.
Now that we have a working contract which will compile, and our configuration files are set, it's time to write a script which will deploy our contract on the ethereum (test) network.
In the `scripts` directory, make a file `deploy.js` like this:
```
async function main() {
  const ExampleNFT = await ethers.getContractFactory("ExampleNFT")

  // start deployment, return promise resolving to contract object
  const exampleNFT = await ExampleNFT.deploy()
  await exampleNFT.deployed()
  console.log("Contract deployed to address:", exampleNFT.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
```

Let's break it down:
```
const ExampleNFT = await ethers.getContractFactory("ExampleNFT");
```
A `ContractFactory` in ethers.js is an abstraction used to deploy new smart contracts, so `ExampleNFT` here is a factory for instances of our NFT contract.
```
const exampleNFT = await ExampleNFT.deploy();
```
Calling `.deploy()` on a ContractFactory will start the deployment, and return a Promise that resolves to a Contract.
This is the object that has a method for each of our smart contract functions.

## 16. Deploy our contract
We're finally ready to deploy our contract!
Make sure you are at the repo root and run the command:
```
npx hardhat --network ropsten run scripts/deploy.js
```
Then, we should see something like this:
```
Contract deployed to address:
0x6fC3a7ab7C9E3F2Dd387B71aB942bb4694Cc578e
```
If we go to Ropsten etherscan block explorer, searching for our contract address we'll see it has been deployed successfully.
The From address should match your MetaMask account and the To address will say "Contract Creation".
If we click the Txn Hash, we should see a status that our MM address successfully created this contract.

YASSSSSS! We just deployed our first NFT smart contract to the Ethereum chain!!!

To understand what happened under the hood, we can check the Explorer tab in our Alchemy dashboard.
We'll see that Hardhat/Ethers made JSON-RPC calls for us when we called the `.deploy()` function:
- eth_sendRawTransaction: request to actually write our smart contract onto the Ropsten chain, and
- eth_getTransactionByHash: request to read information about our transaction given the hash (typical pattern when sending transactions).

# Part 2: How to mint an NFT.
Beeple, 3LAU, and Grimes all minted their NFTs using Alchemy's API.

"Minting an NFT" is the act of publishing a unique instance of our ERC-721 token on the blockchain.
Using our smart contract from Part 1, we will flex our web3 skills and mint an NFT.

## 1. Install Web3
Web3 is similar to Ethers, it's a library which makes creating requests to the Ethereum blockchain easier.
In this tutortial, we will use Alchemy Web3, which is an enhanced web3 library that offers *automatic retries* and robust *WebSocket support*.

In our repo root, run:
```
npm install @alch/alchemy-web3
```

## 2. Create a mint-nft.js file.
In our scripts directory, create a `mint-nft.js` file:
```
require("dotenv").config()
const API_URL = process.env.API_URL
const { createAlchemyWeb3 } = require("@alch/alchemy-web3")
const web3 = createAlchemyWeb3(API_URL)

```

## 3. Grab your contract ABI
A contract ABI (Application Binary Interface) is the interface to interact with our smart contract.
Hardhat automatically generates an ABI for us and saves it in the ExampleNFT.json file.
In order to use this, we'll need to parse out the contents by adding the following to our `mint-nft.js` file:
```
const contract = require("../artifacts/contracts/ExampleNFT.sol/ExampleNFT.json")
```
To see the ABI we can print it in the console:
```
console.log(JSON.stringify(contract.abi))
```
To run `mint-nft.js` and see your ABI printed to the console navigate to your terminal and run:
```
node scripts/mint-nft.js
```

## 4. Configure the metadata for your NFT using IPFS
Recall that our `mintNFT` smart contract function accepts a `tokenURI` param that should resolve to a JSON document describing the NFT's metadata.
This JSON is what actually brings to life the NFT, giving it configurable properties such as a name, description, image, and other attributes.

*Interplanetary File System (IPFS) is a decentralized protocol and peer-to-peer network for storing and sharing data in a distributed file system.*

We will use Pinata, a convenient IPFS API and toolkit, to store our NFT asset and metadata to ensure our NFT is truly decentralized.
Once you've signed up for a free account:
- Navigate to the "Files" page and click the blue "Upload" at the top-left
- Upload an image to pinata--this will be the image asset for your NFT. Feel free to name it whatever your heart desires
- After uploading, you should see the file info in the table on the Files page. You'll also see a CID column. You can view the upload at: `https://gateway.pinata.cloud/ipfs/<CID>`.

We'll need to upload one more file to Pinata, but we need to make it first.

In our repo root, make a new file `nft-metadata.json` and add the following json code:
```
{
  "attributes": [
    {
      "trait_type": "Subject",
      "value": "Sapling"
    },
    {
      "trait_type": "Filter",
      "value": "Dusk"
    },
    {
      "trait_type": "Background",
      "value": "Brick Vegetation"
    }
  ],
  "description": "An Example NFT Collection. This NFT is of a small tree branching out.",
  "image": "https://gateway.pinata.cloud/ipfs/QmNWCeWyJQkuJuKj4iw1dokGhQ5Qf1qDmYVK9X1PdNwWox",
  "name": "Example NFT #1"
}
```

Once you had made your desired edits to the json file, save it and upload it to Pinata.
We will follow the same steps we did for uploading the image.

## 5. Create an instance of our contract.
To interact with our contract, we need to create an instance of it in our code.
We will need our contract address to do this.

Use the web3 `contract` method to create our contract using the ABI and address.
Add the following to our `mint-nft.js` file:
```
const contractAddress = 
"0x6fc3a7ab7c9e3f2dd387b71ab942bb4694cc578e"

const nftContract = new web3.eth.Contract(contract.abi, contractAddress)
```

## 6. Update the .env file
To create and send txns on the Ethereum chain, we will use the public ehtereum account address to get the account none.

Add your public key to your `.env` like so:
```
API_URL = "https://eth-ropsten.alchemyapi.io/v2/your-api-key"
PRIVATE_KEY = "your-private-account-address"
PUBLIC_KEY = "your-public-account-address"
```

## 7. Create your transaction
Let's define a function named `mintNFT(tokenData)` and create our txn by doing the following:
  1. Grab your `PRIVATE_KEY` and `PUBLIC_KEY` from the `.env.` file.
  2. Determine the account nonce. The nonce keeps track of the number of txns sent from our address.
  3. Set up our txn with the following info:
     1. 'from': `PUBLIC_KEY` - origin of our tnx is our public address
     2. 'to': `contractAddress` - the contract we wish to interact with and send the txn
     3. 'nonce': `nonce` - the account nonce with the number of txns sent from our address. It is also crucial for security purposes and to prevent replay attacks. We will use getTransactionsCount to get this value.
     4. 'gas': `estimatedGas` - the estimated gas needed to complete the txn
     5. 'data': `nftContract.methods.mintNFT(PUBLIC_KEY, md).econdeABI()` - the computation we wish to perform in this txn (in this case, minting an NFT)

Our `mint-nft.js` file shuld now look like this:
```
require("dotenv").config();
const API_URL = process.env.API_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const PUBLIC_KEY = process.env.PUBLIC_KEY;

const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const web3 = createAlchemyWeb3(API_URL);

const contract = require("../artifacts/contracts/ExampleNFT.sol/ExampleNFT.json");
// console.log(JSON.stringify(contract.abi));
const contractAddress =
    "0x6fc3a7ab7c9e3f2dd387b71ab942bb4694cc578e";
const nftContract = new web3.eth.Contract(contract.abi, contractAddress);

async function mintNFT(tokenURI) {
    const nonce = await web3.eth.getTransactionCount(PUBLIC_KEY, 'latest'); //get latest nonce

    //the transaction
    const tx = {
        'from': PUBLIC_KEY,
        'to': contractAddress,
        'nonce': nonce,
        'gas': 500000, //seems like a bad practice..?
        'data': nftContract.methods.mintNFT(PUBLIC_KEY, tokenURI).encodeABI()
    };
}
```

## 8. Sign the transaction.
