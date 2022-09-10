module.exports = async (hre) => {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;

  const { deployer } = await getNamedAccounts();

  await deploy("EarnToken", {
    from: deployer,
    args: ["EarnToken", "EARN", deployer],
    log: true,
  });
};
module.exports.tags = ["EarnToken"];
