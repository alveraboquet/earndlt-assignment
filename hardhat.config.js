require("@nomiclabs/hardhat-waffle");
require("hardhat-deploy");
require("./tasks");
require("dotenv").config();
require("@nomiclabs/hardhat-etherscan");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.9",
  settings: {
    optimizer: {
      enabled: true,
      runs: 2000,
    },
  },
  namedAccounts: {
    deployer: 0,
  },
  networks: {
    // TODO Eearn network
  },
};
