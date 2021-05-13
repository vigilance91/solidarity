// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experiemental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/blacklist/iAccessControl.sol";
///
/// @title Blacklist Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
interface iBlacklist is iAccessControl
{
    ///
    /// @return {bool} true if msg.sender is banned, otherwise false
    ///
    function isBanned(
    )external view returns(
        bool
    );
    ///
    /// @return {bool} true if account is banned, otherwise false
    ///
    function isBanned(
        address account
    )external view returns(
        bool
    );
    ///
    /// @return {uint256} the number of black-listed accounts,
    /// can be used together with {getRoleMember} to enumerate all banned accounts
    ///
    function bannedAddressCount(
    )external view returns(
        uint256
    );
    ///
    /// @dev blacklist `account`
    /// emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has previously been banned
    ///
    function ban(
        address account
    )external;
    ///
    /// @dev Revokes `account` from whitelist
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has not previously been banned
    ///
    function revokeBan(
        address account
    )external;
}