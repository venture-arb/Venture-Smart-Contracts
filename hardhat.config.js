require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config(); // Load private keys from .env

module.exports = {
  solidity: "0.8.19",
  networks: {
    bsctestnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545", // BSC Testnet RPC
      accounts: [process.env.PRIVATE_KEY], // Use your private key from .env
    },
  },
};
