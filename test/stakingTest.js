const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Staking Contract", function () {
    let VNTToken, vnt, Staking, staking, owner, user1, user2;

    beforeEach(async function () {
        [owner, user1, user2] = await ethers.getSigners();

        // Deploy VNT Token
        VNTToken = await ethers.getContractFactory("VNTToken");
        vnt = await VNTToken.deploy();
        await vnt.deployed();

        // Deploy Staking Contract
        Staking = await ethers.getContractFactory("Staking");
        staking = await Staking.deploy(vnt.address);
        await staking.deployed();

        // Transfer tokens to users
        await vnt.transfer(user1.address, ethers.utils.parseEther("1000"));
        await vnt.transfer(user2.address, ethers.utils.parseEther("1000"));
    });

    it("Should allow users to stake VNT tokens", async function () {
        await vnt.connect(user1).approve(staking.address, ethers.utils.parseEther("100"));
        await staking.connect(user1).stake(ethers.utils.parseEther("100"));

        const stakedAmount = await staking.stakers(user1.address);
        expect(stakedAmount.stakedAmount).to.equal(ethers.utils.parseEther("100"));
    });
});
