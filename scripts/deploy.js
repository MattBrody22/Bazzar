const hre = require('hardhat');
const fs = require('fs');

async function main() {
  const NFTbazzar = await hre.ethers.getContractFactory('NFTbazzar');
  const nftbazzar = await NFTbazzar.deploy();
  await nftbazzar.deployed();
  console.log('nftbazzar deployed to:', nftbazzar.address);

  const NFT = await hre.ethers.getContractFactory('NFT');
  const nft = await NFT.deploy(nftbazzar.address);
  await nft.deployed();
  console.log('nft deploye to:', nft.address);

  let config = `
  export const nftbazzaraddress = "${nftbazzar.address}"
  export const nftaddress = "${nft.address}"
  `
  
  let data = JSON.stringify(config)
  fs.writeFileSync('conig.js', JSON.parse(data))
} 

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });