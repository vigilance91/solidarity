// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
//
import "https://github.com/vigilance91/solidarity/contracts/accessControl/encoder/iEncoderAccessControl.sol";
///
/// @title Whitelist Transaction Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
interface iEncoderWhitelist //is iEncoderAccessControl
{
    //function isPermitted(
    //)external pure returns(
        //bytes memory
    //);
    ///
	/// @dev Encodes a transaction which can be used to determine if the signer is whitelisted
    ///
    function isPermitted(
        address account
    )external pure returns(
        bytes memory
    );
    ///
	/// @dev Encode a transaction to grant the signer of the hashed address and signature access to this contract
    /// transaction cost: 195,085 gas + execution cost 166,837 gas === 361,922 total gas
    /// 
    function grantPermission(
        bytes32 signerHash,
        bytes memory signature
    )external pure returns(
        bytes memory
    );
    /// 
    /// @dev Encode a transaction to get the concatentated hex repressentation of this contract's address, caller's address,
    /// and caller's nonce, then hash result.
    /// 
    function callerAddressHash(
    )external pure returns(
        bytes memory
    );
    ///
    /// @dev Encode transaction to get the total count of the currently whitelisted accounts
    ///
    function getPermittedMemberCount(
    )external pure returns(
        bytes memory
    );
    ///
    /// @dev Encodes transaction to revoke `account` from whitelist
    ///
    function revokePermission(
        address account
    )external pure returns(
        bytes memory
    );
    ///
    /// @dev caller renounces their inclusion in the whitelist
    ///
    //function renouncePermission(
    //)external;
    ///
    /// @dev transfer caller's permission to address `to`
    /// 
    //function transferPermission(
        //address from,
        //address to
    //)external;
}