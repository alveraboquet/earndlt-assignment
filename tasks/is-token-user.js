task("is-token-user", "Checks whether given account has the TOKEN USER role")
  .addParam("contract", "The address of the EarnToken contract")
  .addParam("account", "The address to be checked for TOKEN USER role")
  .setAction(async ({ contract, account }, { ethers }) => {
    try {
      const earnTokenContract = await ethers.getContractAt(
        "EarnToken",
        contract
      );
      const role = await earnTokenContract.TOKEN_USER();
      const hasRole = await earnTokenContract.hasRole(role, account);
      console.log(`${account} is ${hasRole ? "" : "not "}a TOKEN USER`);
    } catch (e) {
      console.log(`Something went wrong: `, e);
    }
  });
