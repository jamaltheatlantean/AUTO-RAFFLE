const networkConfig = {
  default: {
      name: "hardhat",
      interval: "30",
  },
  31337: {
      name: "localhost",
      subscriptionId: "588",
      gasLane: "", // 30 gwei
      interval: "30",
      entranceFee: "100000000000000000", // 0.1 ETH
      callbackGasLimit: "500000", // 500,000 gas
  },
  5: {
      name: "goerli",
      subscriptionId: "2298",
      gasLane: "0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc", // 30 gwei
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
