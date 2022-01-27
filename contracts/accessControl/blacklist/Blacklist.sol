// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/blacklist/iBlacklist.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/blacklist/BlacklistABC.sol";

//import "https://github.com/vigilance91/solidarity/contracts/finance/NonPayable.sol";

import "https://github.com/vigilance91/solidarity/contracts/introspection/mortalCanary/MortalCanary.sol";

//interface iAccessControlBlacklist is iAccessControl,
//    iBlacklist
//{
//}

//interface iSafeMortalBlacklist is iSafeMortalCanary,
//    iBlacklist
//{
//}

///
/// @title External Blacklist Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
contract Blacklist is MortalCanary,
    BlacklistABC,
    //NonPayable,
    iBlacklist
{
    string private constant _NAME = ' Blacklist: ';
    
    constructor(
    )public
        MortalCanary()
        BlacklistABC()  //_STORAGE_SLOT, [])
    {
        _registerInterface(type(iBlacklist).interfaceId);
    }
    //function init(
        //address[] memory banned,
        //address[] memory assignors,
        //address[] memory revokers
    //)external _onlyDefaultAdmin initializer
    //{
        //for(uint i; i < banned.length; i++){
            //_setupRole(ROLE_BANNED, banned[i]);
        //}
        
        //for(uint i; i < assignors.length; i++){
            //_setupRole(ROLE_ASSIGNORS, assignors[i]);
        //}
        
        //address a;
        //
        //for(uint i; i < revokers.length; i++){
            //_setupRole(ROLE_REVOKERS, revokers[i]);
        //}
    //}
    
    function isBanned(
        address account
    )public view virtual override returns(
        bool
    ){
        _requireNotBanned(_msgSender());
        
        return _isBanned(account);
    }
    ///
    /// @dev Grants `role` to each account in `accounts`, if not already banned
    /// emits multiple {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role or be default admin
    ///     - reverts if an account in `account` has previously been granted `role`
    ///
    function isBanned(
        address[] memory accounts
    )public virtual override returns(
        bool[] memory ret
    ){
        _requireThisNotBanned();
        //
        address sender = _msgSender();
        //
        _requireNotBanned(sender);
        _requireHasAdminRole(role, sender);
        
        ret = new bool[](accounts.length);
        
        for(uint i; i < accounts.length; i++){
            ret[i] = _isBanned(role, accounts[i]);
        }
    }
    
    ///
    /// @return {uint256} the number of black-listed accounts,
    /// can be used together with {getRoleMember} to enumerate all banned accounts
    ///
    function bannedAddressCount(
    )external virtual override view returns(
        uint256
    ){
        _requireThisNotBanned();
        
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
    {
        _requireThisNotBanned();
        
        address sender = _msgSender();
        
        _requireNotBanned(sender);
        _requireHasAdminRole(role, sender);
        
        _ban(account);
    }
    ///
    /// @dev blacklist each account `accounts`, if not already blacklisted
    /// emits multiple {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - atomic operation, reverts if an account in `accounts` has previously been banned
    ///
    function ban(
        address[] memory accounts
    )external virtual override nonReentrant
    {
        _requireThisNotBanned();
        
        address sender = _msgSender();
        //
        //account.requireNotEqual(owner());
        //
        _requireNotBanned(sender);
        _requireHasAdminRole(role, sender);
        
        address a;
        
        for(uint i; i < accounts.length; i++){
            a = accounts[i];
            //
            //_requireNotEqual(sender, a);
            //_requireNotEqual(_this(), a);
            //
            _ban(a);
        }
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
    {
        _requireThisNotBanned();
        //
        _requireNotBanned(sender);
        _requireHasAdminRole(role, _msgSender());
        
        _revokeBan(account);
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
        address[] memory accounts
    )external virtual override nonReentrant
    {
        _requireThisNotBanned();
        //
        address sender = _msgSender();
        
        _requireNotBanned(sender);
        _requireHasAdminRole(role, sender);
        
        for(uint i; i < accounts.length; i++){
            _revokeBan(accounts[i]);
        }
    }
}