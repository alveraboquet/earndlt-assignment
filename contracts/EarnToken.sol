// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

/**
  @title EarnToken custom ERC20 Token contract for EarnDLT, based on OpenZeppelin contracts
  @notice Token transfers are only possible among authorised accounts, 
        which in the context of this contract are called "token users"
  @author @dvinubius
 */
contract EarnToken is ERC20, AccessControlEnumerable {
    uint256 public constant TOTAL_SUPPLY = 1e18 * 1e6; // 1 million tokens

    /// @dev accounts with this role are allowed to be senders or receivers of EARN tokens
    bytes32 public constant TOKEN_USER = keccak256("TOKEN_USER");

    /** 
        @notice The complete token supply is minted to the specified operator, 
            who also becomes a DEFAULT ADMIN and subsequently can grant / revoke TOKEN USER roles
        @param name_ Contract name
        @param symbol_ Contract symbol
        @param operator An account that obtainins ownership of the total token supply
            and is granted the DEFAUTL_ADMIN_ROLE
        @dev Operator should not be implicitly msg.sender, as the contract is inteded to be created from the factory
    */
    constructor(
        string memory name_,
        string memory symbol_,
        address operator
    ) ERC20(name_, symbol_) {
        _mint(operator, TOTAL_SUPPLY);
        _grantRole(DEFAULT_ADMIN_ROLE, operator);
    }

    /**
      @dev Override the ERC721 default in order to only allow transfers between TOKEN USER accounts
     */
    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override {
        _checkRole(TOKEN_USER, from);
        _checkRole(TOKEN_USER, to);
        super._transfer(from, to, tokenId);
    }

    /**
      @notice Convenience function to retrieve all TOKEN USER accounts
        - i.e. the accounts allowed to be senders or receivers of EARN
      @return users An array of the addresses
     */
    function getTokenUsers() external view returns (address[] memory users) {
        uint256 count = getRoleMemberCount(TOKEN_USER);
        users = new address[](count);
        for (uint256 i = 0; i < count; i++) {
            users[i] = getRoleMember(TOKEN_USER, i);
        }
    }

    /**
        @dev Purely for convenience we can add other functions that abstract away 
        the role, such that calling them wouldn't require passing the _role_ bytes32 parameter 
        that represents the TOKEN_USER role. This potentially applies to 
            - checking if an account has the role
            - granting the role to an account
            - revoking the role from an account
    */
}
