// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
//
import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControl.sol";
///
/// @title Whitelist Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
contract iWhitelist is iAccessControl
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
        bytes32 signerHash,
        bytes memory signature
    )external;
    /// 
    /// @dev concatentate hex repressentation of this contract's address, caller's address,
    /// and caller's nonce, then hash result. Use this result for argument `signerHash` in {permit}
    /// 
    function callerAddressHash(
    )external view returns(
        bytes32
    );
    ///
    /// @return {uint256} the number of white-listed accounts,
    /// can be used together with {getRoleMember} to enumerate all white-listed accounts
    ///
    function getPermittedMemberCount(
    )external view returns(
        uint256
    );
    ///
    /// @dev Revokes `account` from whitelist
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - reverts if `account` has not previously been white-listed
    ///
    function revokePermission(
        address account
    )external;
    ///
    /// @dev caller renounces their inclusion in the whitelist
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must be whitelisted
    ///
    //function renouncePermission(
    //)external;
    ///
    /// @dev transfer caller's permission to address `to`
    ///
    /// Requirements:
    ///     - the caller must be admin
    ///     - `from` must alreaddy be whitelisted
    ///     - `to` must not be whitelisted
    /// 
    //function transferPermission(
        //address from,
        //address to
    //)external;
}