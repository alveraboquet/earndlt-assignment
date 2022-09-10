// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
  @title Interface for the assignment-specific functionality
  @author @dvinubius
 */
interface IEarnTokenFactory {
    function tokenContracts(uint256 index) external view returns (address);

    /**
        @notice Create EarnToken contract with a specific name and symbol
     */
    function createEarnToken(string memory name, string memory symbol) external;

    /**
        @notice Retrieve token contract within a specific index range
        @param limit The max number of addresses to return
        @param offset The starting index from which to retrieve
   */
    function getTokenContracts(uint256 limit, uint256 offset)
        external
        view
        returns (address[] memory contracts);
}
