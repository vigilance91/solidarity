// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experiemental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/blacklist/iBlacklist.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/blacklist/BlacklistABC.sol";

import "https://github.com/vigilance91/solidarity/contracts/introspection/mortalCanary/MortalCanary.sol";

//interface iExternalBlacklist is iMortalCanary,
//    iBlacklist
//{
//}

///
/// @title External Blacklist Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
contract ExternalBlacklist is MortalCanary,
    BlacklistABC,
    iBlacklist
{
    string private constant _NAME = ' ExternalBlacklist: ';
    
    constructor(
    )public
        MortalCanary()
        BlacklistABC()
    {
        _registerInterface(type(iAccessControl).interfaceId);
        _registerInterface(type(iBlacklist).interfaceId);
    }
    function isBanned(
        address account
    )public view virtual override returns(
        bool
    ){
        return _isBanned(account);
    }
    ///
    /// @return {uint256} the number of black-listed accounts,
    /// can be used together with {getRoleMember} to enumerate all banned accounts
    ///
    function bannedAddressCount(
    )external virtual override nonReentrant view returns(
        uint256
    ){
        return _bannedAddressCount();
    }
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
    )external virtual override nonReentrant
        //onlyDefaultAdminOrRoleAdmin
    {
        //_requireHasAdminRole(role, _msgSender());
        _ban(account);
    }
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
    )external virtual override nonReentrant
        //onlyDefaultAdminOrRoleAdmin
    {
        //_requireHasAdminRole(role, _msgSender());
        
        _revokeBan(ROLE_BANNED, account);
    }
}