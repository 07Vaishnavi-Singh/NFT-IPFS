// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract LW3Punks is ERC721Enumerable , Ownable {

using Strings for uint256 ;

string baseTokenURI ;

//price of one LW3 NFT Punk
uint public price = 0.01 ether ;

//if contract is paused in any case
bool public paused ;

//maximmum number o ftOken IDs that can be issued 
uint public maxTokenId = 10 ;

//token Ids minted at a prticular time 
uint public tokenIds ; 


modifier onlyWhenNotPaused(){

require( !paused , "The Owner of the contract has paused the contract for some time please try again after some time ");

    _;
}
 // base URI will be set by the owner of the contract and will automatically be added to the prefix to token IDs
 //setting the name and symbol of the ERC721 token name will be LW3NFTPunks and symbol wwill be LW3P  
constructor( string memory _baseTokenURI ) ERC721( "LW3NFTPunks" ,  "LW3P" ) {
     baseTokenURI = _baseTokenURI ;
}

function mint() public payable onlyWhenNotPaused {
    require( maxTokenId > tokenIds , "All the tokens have been minted ");
    require( msg.value >= price , "You need more ether to mint the NFT ");
    tokenIds += 1 ;
    _safeMint(msg.sender , tokenIds );
}

function _baseURI() internal view override returns(string memory ){
    return baseTokenURI ; 
} 


function setPaused(bool _paused) public onlyOwner{
    paused = _paused ;
} 

function tokenURI(uint tokenId) public view  override returns( string memory  )  {
require( _exists(tokenId) , "ERC721Metadata: URI query for nonexistent token");

string memory  baseURI = _baseURI();

return  bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI , tokenId , ".json")) : "" ;

} 


function withdraw() public onlyOwner{

 address _owner = owner();
 uint amount = address(this).balance;
 ( bool set , ) = _owner.call{value : amount}("");
require( set , "Failed to send Ether");

}

 // Function to receive Ether. msg.data must be empty
    receive() external payable {}
 // Fallback function is called when msg.data is not empty
    fallback() external payable {

}
}