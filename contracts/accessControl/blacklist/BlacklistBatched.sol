// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/blacklist/iBlacklistBatched.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/blacklist/Blacklist.sol";
///
/// @title External Batched Blacklist Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
contract BlacklistBatched is Blacklist,
    iBlacklistBatched
{
    string private constant _NAME = ' BlacklistBatched: ';
    
    bytes4 internal constant _IID_BLACKLIST_VIEW_BATCHED = type(iBlacklistViewBatched).interfaceId;
    bytes4 internal constant _IID_BLACKLIST_MUTABLE_BATCHED = type(iBlacklistMutableBatched).interfaceId;
    bytes4 internal constant _IID_BLACKLIST_BATCHED = type(iBlacklistBatched).interfaceId;
    
    constructor(
    )public
        Blacklist()
    {
        require(
            (_IID_BLACKLIST_VIEW_BATCHED ^_IID_BLACKLIST_MUTABLE_BATCHED) == _IID_BLACKLIST_BATCHED,
        );
        
        _registerInterface(_IID_BLACKLIST_VIEW_BATCHED);
        _registerInterface(_IID_BLACKLIST_MUTABLE_BATCHED);
        _registerInterface(_IID_BLACKLIST_BATCHED);
        //
        //add ERC165 to blacklist batch interface
        //_registerInterface(_IID_BLACKLIST_BATCHED ^ _IID_ERC165);
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