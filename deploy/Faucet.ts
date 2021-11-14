import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async function ({
  getNamedAccounts,
  deployments,
}) {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy("Faucet", {
    from: deployer,
    args: [],
    waitConfirmations: 1,
    log: true,
  });
};

func.tags = ["Faucet"];

export default func;
