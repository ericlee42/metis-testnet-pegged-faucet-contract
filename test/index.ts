import { expect } from "chai";
import { ethers } from "hardhat";

describe("Faucet", function () {
  it("Owner is msg.sender", async function () {
    const [deployed] = await ethers.getSigners();
    const Faucet = await ethers.getContractFactory("Faucet");
    const faucet = await Faucet.deploy();
    await faucet.deployed();

    expect(await faucet.admin()).to.equal(deployed.address);
  });
});
