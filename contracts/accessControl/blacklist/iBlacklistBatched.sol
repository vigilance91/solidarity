// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/blacklist/iBlacklist.sol";
///
/// @title Batched Blacklist View Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
interface iBlacklistViewBatched is iBlacklistView
{
    ///
    /// @return {bool} true if account is banned, otherwise false
    ///
    function isBanned(
        address[] calldata account
    )external view returns(
        bool[] memory
    );
}
///
/// @title Batched Blacklist Mutable Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
interface iBlacklistMutableBatched is iBlacklistMutable
{
    ///
    /// @dev blacklist `account`
    /// emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - reverts if `account` has previously been banned
    ///
    function ban(
        address[] calldata accounts
    )external;
    ///
    /// @dev Revokes each account in `account` from blacklist, if they have been previousyl banned
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - atomic, reverts if an account in `accounts` has not previously been banned
    ///
    function revokeBan(
        address[] calldata accounts
    )external;
}
///
/// @title Batched Blacklist Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
interface iBlacklistBatched is iBlacklistViewBatched,
    iBlacklistMutableBatched
{
}