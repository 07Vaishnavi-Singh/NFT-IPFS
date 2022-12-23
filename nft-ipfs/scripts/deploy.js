const { ethers } = require("hardhat") ;
require("dotenv").config({ path: ".env" });

async function main(){
  
//URL from we expect the metadata of the tokens
const metadataURL = "ipfs://Qmbygo38DWF1V8GttM1zy89KzyZTPU2FLUzQtiDvB7q6i5/";
 
//instance of the contract created 
const LW3Punks = await ethers.getContractFactory("LW3Punks") ;

//deplying the contract by using the instance created 
const deployedLW3PunksContract = await LW3Punks.deploy(metadataURL) ;

//waiting till the contract is deployed
await deployedLW3PunksContract.deployed();

console.log("LW3Punks Contract Address: ", deployedLW3PunksContract.address );

}

//calling the main function and throwing any error if there is 
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
  //LW3Punks Contract Address:  0x00eF735A19bbD17bdE864CCCB73508F18A747351