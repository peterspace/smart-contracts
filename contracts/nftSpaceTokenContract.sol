// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";


contract nftSpaceToken is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address contractAddress;

    constructor () ERC721("nftSpaceToken", "NSXX"){
    }

    struct Item {
        uint256 id;
        address creator;
        string uri;


    }

    mapping (uint256 => Item) public Items;

    function createItem(string memory uri) public returns (uint256){
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);

        Items[newItemId] = Item(newItemId, msg.sender, uri);
        setApprovalForAll(contractAddress, true); //to automatically approve the transfer of minted tokens to marketplace

        return newItemId;
    }

    // create automatic approval of createdItems (minted tokens) to marketplace, to transfer the item on behalf of the the user to save more gas fees.
    // Because the tokens are not automatically transferred to the market place, the market place just acts on behalf of the user 

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        return Items[tokenId].uri;

    }
}