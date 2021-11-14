import { task } from "hardhat/config";

task("createpegged")
  .setDescription("create a new Pegged token")
  .addParam("symbol", "what is symbol do you want to create")
  .setAction(async (taskArgs, hre) => {
    const symbol: string = taskArgs.symbol.toUpperCase();

    const { ethers, deployments } = hre;

    const { Faucet } = await deployments.all();
    if (!Faucet) {
      throw new Error("should deploy first");
    }

    const [deployer] = await ethers.getSigners();
    const faucet = await ethers.getContractAt(
      "Faucet",
      Faucet.address,
      deployer
    );

    const address = await faucet.getTokenAddress(symbol);
    if (address !== ethers.constants.AddressZero) {
      throw new Error(`${symbol} has been created`);
    }

    console.log("try to create...");
    const tx = await faucet.create(symbol);
    await tx.wait();
    console.log(`Create ${symbol} pegged token successful:`, tx.hash);
  });
