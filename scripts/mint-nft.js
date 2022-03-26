require("dotenv").config();
const API_URL = process.env.API_URL;

const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const web3 = createAlchemyWeb3(API_URL);

const contract = require("../artifacts/contracts/ExampleNFT.sol/ExampleNFT.json");
// console.log(JSON.stringify(contract.abi));
const contractAddress =
    "0x6fc3a7ab7c9e3f2dd387b71ab942bb4694cc578e";
const nftContract = new web3.eth.Contract(contract.abi, contractAddress);