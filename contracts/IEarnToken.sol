// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
  @title Interface for the assignment-specific functionality
  @author @dvinubius
 */
interface IEarnToken {
    function getTokenUsers() external view returns (address[] memory);
}
