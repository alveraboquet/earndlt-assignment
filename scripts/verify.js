const fs = require("fs");
const { exec } = require("child_process");

verify = async (contractName) => {
  const networkName = process.argv[2];

  try {
    const deploymentData = fs.readFileSync(
      `deployments/${networkName}/${contractName}.json`,
      {
        encoding: "utf8",
        flag: "r",
      }
    );
    const deployment = JSON.parse(deploymentData);
    const address = deployment.address;
    const constructorArgs = deployment.args;

    console.log(
      `Found ${contractName} deployed at: ${address} with args: ${constructorArgs}`
    );

    const contractArg = `--contract contracts/${contractName}.sol:${contractName}`;
    const constructorArgsArg = constructorArgs.length
      ? constructorArgs.join(" ")
      : "";

    exec(
      `npx hardhat verify --network ${networkName} ${contractArg} ${address} ${constructorArgsArg}`,
      (error, stdout, stderr) => {
        if (error) {
          console.log(`error: ${error.message}`);
          return;
        }
        if (stderr) {
          console.log(`stderr: ${stderr}`);
          return;
        }
        console.log(`stdout: ${stdout}`);
      }
    );
  } catch (e) {
    console.error(e);
    console.log("No deployment was found");
  }
};

const main = async () => {
  try {
    await verify("EarnToken");
    // add other contracts
  } catch (e) {
    console.log(e);
  }
};

main();
