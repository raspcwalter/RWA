import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: process.env.RPC_NODE_S,
      chainId: Number(process.env.CHAIN_ID_S),
      accounts: {
        mnemonic: process.env.SECRET
      }
    },
    holesky: {
      url: process.env.RPC_NODE_H,
      chainId: Number(process.env.CHAIN_ID_H),
      accounts: {
        mnemonic: process.env.SECRET
      }
    }  
  },
  etherscan: {
    apiKey: process.env.API_KEY
  }
};

export default config;
