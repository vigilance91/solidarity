// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControl.sol";

interface iBlacklistView
{
    //
    // @return {bool} true if caller is banned, otherwise false
    //
    //function isBanned(
        //address account
    //)external view returns(
        //bool
    //);
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
    
    //function bannedAddresses(
    //)external view returns(
        //address[] memory
    //);
}

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

interface iBlacklistMutable
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
        address account
    )external;
    ///
    /// @dev Revokes `account` from blacklist
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - atomic, reverts if any account in `accounts` has not previously been banned
    ///
    function revokeBan(
        address account
    )external;
}

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
/// @title Blacklist Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
interface iBlacklist is iBlacklistView,
    iBlacklistMutable
{
    /*
    // @return {bool} true if msg.sender is banned, otherwise false
    //
    //function isBanned(
    //)external view returns(
        //bool
    //);
    ///
    /// @return {bool} true if account is banned, otherwise false
    ///
    function isBanned(
        address account
    )external view returns(
        bool
    );
    ///
    /// @return {bool} true if account is banned, otherwise false
    ///
    function isBanned(
        address[] memory account
    )external view returns(
        bool[] memory
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
    ///     - the caller must have `role`'s admin role
    ///     - reverts if `account` has previously been banned
    ///
    function ban(
        address account
    )external;
    ///
    /// @dev blacklist `account`
    /// emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - reverts if `account` has previously been banned
    ///
    function ban(
        address[] memory accounts
    )external;
    ///
    /// @dev Revokes `account` from blacklist
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - atomic, reverts if any account in `accounts` has not previously been banned
    ///
    function revokeBan(
        address account
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
        address[] memory accounts
    )external;
    */
}

interface iBlacklistBatched is iBlacklistViewBatched,
    iBlacklistMutableBatched
{
}