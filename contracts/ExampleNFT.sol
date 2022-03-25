// Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; //set solidity version

// inherit OpenZeppelin smart contract classes
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

// create Ownable contract (owner will be contract deployer)
contract ExampleNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter; // set Counter struct to inherit fns from Counters library
    Counters.Counter private _tokenIds; // set private var as counter

    // init constructor,
    // requires contract name and symbol
    // inherits from ERC721URIStorage contract
    constructor() ERC721("ExampleNFT", "NFT") {}

    // create function mintNFT, requires:
    // 1. an address, recipient, which will receive the minted NFT
    // 2. string tokenURI from memory, resolving to a JSON encoding the NFT metadata
    // note: by declaring onlyOwner, only owner of contract may call mintNFT
    function mintNFT(address recipient, string memory tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        // 1. increment tokenId by 1
        _tokenIds.increment();

        // 2. set var newItemId as uint256 with current value of our counter, _tokenIds
        uint256 newItemId = _tokenIds.current();
        // 3. call openzeppelin mint fn
        _mint(recipient, newItemId);
        // 4. set token metadata
        _setTokenURI(newItemId, tokenURI);

        // 5. return ID of newly minted NFT
        return newItemId;
    }
}
