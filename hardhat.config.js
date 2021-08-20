require("@nomiclabs/hardhat-waffle");
require('dotenv').config()

module.exports = {
  networks:{
    hardhat:{
      chainId: 1337
    },
    mumbai:{
      url: 'https://polygon-mumbai.infura.io/v3/${MUMBAI_ID}'
      accounts: []
    },
    mainnet:{
      url: 'https://polygon-mainnet.infura.io/v3/${MUMBAI_ID}'
      accounts: []
    }
  }
  solidity: "0.8.4",
};
