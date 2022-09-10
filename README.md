# OpenZeppelin ERC20 Assignment

> Create a smart-contract application that generates a token (ERC20) from a factory contract. Override the ERC20 standard (imported from OpenZeppelin) to only enable transfers within a list of wallets. The list of wallets is controlled by Access role (again, use the OpenZeppelin framework). Write tests that verify both successful and failed cases.

## Completion Status

🏁 Assignment is completed (contracts + tests)

🛠 Contains considerations about production-grade improvements (see this README and the code commentaries in contracts & tests)

🚧 Contains stubs that demonstrate how we might build out the repo going further, depending on project needs TBD
  - contract deployment
  - contract verification
  - contract OPS (see `/tasks`)

## Assumptions while completing the assignment

### Dev Env & Testing

The dev framework is Hardhat, using JS. We can port to TS if needed.

Tests are written in JS with mocha/chai. Alternatively we can write them in Solidity with Foundry if deemed worth it.

We have **EarnToken unit tests**.

If deemed necessary we can add
- EarnTokenFactory unit tests
- integration tests
These are not included since they were not explicitly required in the assignment and the associated logic is fairly simple and transparent.

### EarnToken.sol

Regarding **token minting** there were no specific requirements, so on contract creation a complete supply of 1 Million is minted to the **operator specified in the constructor**.

Having no specific requirements in this regard, an **EarnToken can be created/deployed** by any account. It is not aware of the EarnTokenFactory. Restrictions in this regard can be added (such that only the contract should be able to create EarnTokens). However, there are tradeoffs to consider in terms of testing flexibility and the increase in development overhead.

For brevity, wallets who are authorised to transfer tokens among themselves are called ***token users*** in the context of this document and the code comments.

Since the wording of the requirements was *"list of wallets"*, the solution offers a convenience function that **enumerates all *token users*** , even though OZ `AccessControlEnumerable.sol` doesn't offer that.

Since nothing was specified regarding the authorisation to add / remove *token users*, we're going with the simplest solution of granting the DEFAULT_ADMIN_ROLE to the operator specified on contract creation.

Requirements are understood such that transfers can only **occur** between *token users*, but this does not mean transfers have to be **initiated** by token users. Therefore, accounts with an allowance may also perform token transfers. The limitation remains that, **at the time of transfer**, the sender and receiver of the transfer must be *token users*

### EarnTokenFactory.sol

Regarding the token factory our requirements are vague, so we chose a minimal solution that allows 
- contract creation while providing intended operator
- tracking of created contracts by index and via events
- convenient retrieval of contract addresses by index range

With no requirements regarding access control, the creation of contracts via the factory was left unrestricted.

# Installation

`npm install`

# Tests

`npm run test`

# Deployment

🚧 local dev chain only

In a separate terminal

`npm run devchain`

Then

`npm run deploy`

# Verification 

🚧 stub

`npm run verify`

# Operations

Stub 🚧 

@dev Convenience vs. Flexibility

The operations below can be made more convenient by wrapping the commands in dedicated hardhat scripts, especially if we add specific scripts for factory interaction.

The currently available scripts only refer to EarnToken contracts and require explicitly passing the contract address.

## Read current token users

  - `npx hardhat --network localhost is-token-user --contract <DEPLOYMENT_ADDRESS> --account <USER_ADDRESS>`
  - `npx hardhat --network localhost get-token-users --contract <DEPLOYMENT_ADDRESS>`
  
## Add/Remove token users 
  
  - `npx hardhat --network localhost grant-token-user-role --contract <DEPLOYMENT_ADDRESS> --account <USER_ADDRESS>`
  - `npx hardhat --network localhost revoke-token-user-role --contract <DEPLOYMENT_ADDRESS> --account <USER_ADDRESS>`

Try locally:

```
npm run deploy

npx hardhat --network localhost is-token-user --contract 0x5FbDB2315678afecb367f032d93F642f64180aa3 --account 0x807F402e39e997b62C2b15abad508Ebc6F75d1Ea

npx hardhat --network localhost grant-token-user-role --contract 0x5FbDB2315678afecb367f032d93F642f64180aa3 --account 0x807F402e39e997b62C2b15abad508Ebc6F75d1Ea

npx hardhat --network localhost is-token-user --contract 0x5FbDB2315678afecb367f032d93F642f64180aa3 --account 0x807F402e39e997b62C2b15abad508Ebc6F75d1Ea

npx hardhat --network localhost revoke-token-user-role --contract 0x5FbDB2315678afecb367f032d93F642f64180aa3 --account 0x807F402e39e997b62C2b15abad508Ebc6F75d1Ea

npx hardhat --network localhost is-token-user --contract 0x5FbDB2315678afecb367f032d93F642f64180aa3 --account 0x807F402e39e997b62C2b15abad508Ebc6F75d1Ea

```





