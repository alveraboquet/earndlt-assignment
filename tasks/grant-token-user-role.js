task("grant-token-user-role", "Grants TOKEN USER role to given account")
  .addParam("contract", "The address of the EarnToken contract")
  .addParam("account", "The account to be granted TOKEN USER role")
  .setAction(async ({ contract, account }, { ethers }) => {
    try {
      const earnTokenContract = await ethers.getContractAt(
        "EarnToken",
        contract
      );
      const role = await earnTokenContract.TOKEN_USER();
      await earnTokenContract.grantRole(role, account);
      console.log(`Granted TOKEN USER role to ${account}`);
    } catch (e) {
      console.log(`Something went wrong: `, e);
    }
  });
