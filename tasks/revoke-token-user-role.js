task("revoke-token-user-role", "Revokes TOKEN USER role from given account")
  .addParam("contract", "The address of the EarnToken contract")
  .addParam("account", "The account to have TOKEN USER role revoked")
  .setAction(async ({ contract, account }, { ethers }) => {
    try {
      const earnTokenContract = await ethers.getContractAt(
        "EarnToken",
        contract
      );
      const role = await earnTokenContract.TOKEN_USER();
      await earnTokenContract.revokeRole(role, account);
      console.log(`Revoked TOKEN USER role from ${account}`);
    } catch (e) {
      console.log(`Something went wrong: `, e);
    }
  });
