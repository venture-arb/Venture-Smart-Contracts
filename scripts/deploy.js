const { ethers } = require("hardhat");

async function main() {
    // Deploy VNT Token
    const VNTToken = await ethers.getContractFactory("VNTToken");
    const vnt = await VNTToken.deploy();
    await vnt.deployed();
    console.log(`VNT Token deployed at: ${vnt.address}`);

    // Deploy Staking Contract
    const Staking = await ethers.getContractFactory("Staking");
    const staking = await Staking.deploy(vnt.address);
    await staking.deployed();
    console.log(`Staking Contract deployed at: ${staking.address}`);

    // Deploy Arbitrage Contract
    const VentureArbitrage = await ethers.getContractFactory("VentureArbitrage");
    const arbitrage = await VentureArbitrage.deploy();
    await arbitrage.deployed();
    console.log(`Arbitrage Contract deployed at: ${arbitrage.address}`);

    // Deploy Lending Contract
    const VentureLending = await ethers.getContractFactory("VentureLending");
    const lending = await VentureLending.deploy(vnt.address);
    await lending.deployed();
    console.log(`Lending Contract deployed at: ${lending.address}`);

    // Deploy Governance Contract
    const VentureGovernance = await ethers.getContractFactory("VentureGovernance");
    const governance = await VentureGovernance.deploy();
    await governance.deployed();
    console.log(`Governance Contract deployed at: ${governance.address}`);
}

// Execute deployment
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
