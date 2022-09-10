// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./EarnToken.sol";

/**
  @title EarnTokenFactory contract to create and index EarnToken contracts
  @notice The contract has minimal functionality, allowing the creation and tracking by index,
    as well as a convenient retrieval.
  @author @dvinubius
 */
contract EarnTokenFactory {
    address[] public tokenContracts;

    /// @dev for frontend convenience
    event CreateToken(
        uint256 index,
        address contractAddress,
        address operator,
        string name,
        string symbol
    );

    /**
      @notice Create EarnToken contract with a specific name and symbol
      @notice The caller of this function becomes the initial operator of the created contract.
      @param name Created EarnToken contract's name
      @param symbol Created EarnToken contract's symbol
     */
    function createEarnToken(string memory name, string memory symbol)
        external
    {
        EarnToken tk = new EarnToken(name, symbol, msg.sender);
        tokenContracts.push();
        emit CreateToken(
            tokenContracts.length - 1,
            address(tk),
            msg.sender,
            name,
            symbol
        );
    }

    /**
    @notice Retrieve token contract within a specific index range
    @param limit The max number of addresses to return
    @param offset The starting index from which to retrieve
   */
    function getTokenContracts(uint256 limit, uint256 offset)
        external
        view
        returns (address[] memory contracts)
    {
        uint256 total = tokenContracts.length;
        uint256 available = total - offset;
        uint256 toReturn = limit > available ? available : limit;
        contracts = new address[](toReturn);
        for (uint256 i = 0; i < toReturn; i++) {
            contracts[i] = tokenContracts[offset + i];
        }
    }
}
