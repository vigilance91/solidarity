// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/encoder/iEncoderAccessControl.sol";
///
/// @title Blacklist Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 9/12/2021, All Rights Reserved
///
interface iEncoderBlacklist //is iEncoderAccessControl
{
    ///
    /// @dev Encodes the transaction to determine if the calling account is currently blacklisted
    ///
    //function isBanned(
    //)external pure returns(
        //bytes memory
    //);
    ///
    /// @dev Encodes the transaction to determine if `account` is currently blacklisted
    ///
    function isBanned(
        address account
    )external pure returns(
        bytes memory
    );
    ///
    /// @dev Encodes the transaction to get the count of all currently blacklisted addresses
    ///
    function bannedAddressCount(
    )external pure returns(
        bytes memory
    );
    ///
    /// @dev Encodes a transaction to blacklist `account`
    ///
    function ban(
        address account
    )external pure returns(
        bytes memory
    );
    ///
    /// @dev Encodes a transaction to revoke `account` from blacklist
    ///
    function revokeBan(
        address account
    )external pure returns(
        bytes memory
    );
}