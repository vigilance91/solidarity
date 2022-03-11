// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
//
import "https://github.com/vigilance91/solidarity/contracts/accessControl/whitelist/iWhitelist.sol";

interface iWhitelistViewBatched is iWhitelistView
{
    ///
	/// @dev admin grants the signer of the hashed address and signature access to this contract
    ///
    /// Requirements:
    ///     - each account in `accounts` must not be null
    ///
    function isPermitted(
        address[] calldata accounts
    )external view returns(
        bool[] memory
    );
}

interface iWhitelistMutableBatched is iWhitelistMutable
{
    ///
	/// @dev admin grants the signer of the hashed address and signature access to this contract
    /// transaction cost: 195,085 gas + execution cost 166,837 gas === 361,922 total gas
    /// emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - caller must have `role`'s admin role or be default admin
    ///     - caller must not be the recovered singer's address
    ///     - reverts if `account` has previously been white-listed
    ///     - reverts if recovered signer's address hash (combined with that acount's nonce) does not equal `signerHash`
    /// 
    function grantPermission(
        address[] calldata accounts
    )external;
    ///
    /// @dev Revokes each account in `accounts` from whitelist
    /// emits a {RoleRevoked} event for each account
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - reverts if an account in `accounts` has not previously been white-listed
    ///
    function revokePermission(
        address[] calldata accounts
    )external;
    //
    // @dev transfer caller's permission to address `to`
    //
    // Requirements:
    //     - the caller must be admin
    //     - each account in `fromAccounts` must already be whitelisted
    //     - each account in `toAccounts` must not be whitelisted
    // 
    //function transferPermission(
        //address[] calldata fromAccounts,
        //address[] calldata toAccounts
    //)external;
}

interface iWhitelistBatched is iWhitelistViewBatched,
    iWhitelistMutableBatched
{
}