const networkConfig = {
  default: {
      name: "hardhat",
      interval: "30",
  },
  31337: {
      name: "localhost",
      subscriptionId: "588",
      gasLane: "0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15", // 30 gwei
      interval: "30",
      entranceFee: "100000000000000000", // 0.1 ETH
      callbackGasLimit: "500000", // 500,000 gas
  },
  5: {
      name: "goerli",
      subscriptionId: "2298",
      gasLane: "0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15", // 30 gwei
      interval: "30",
      entranceFee: "100000000000000000", // 0.1 ETH
      callbackGasLimit: "500000", // 500,000 gas
      vrfCoordinatorV2: "0x6168499c0cFfCaCD319c818142124B7A15E857ab",
  },
}

const developmentChains = ["hardhat", "localhost"]
const VERIFICATION_BLOCK_CONFIRMATIONS = 6

module.exports = {
  networkConfig,
  developmentChains,
  VERIFICATION_BLOCK_CONFIRMATIONS,
}
