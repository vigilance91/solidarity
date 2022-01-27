// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

//import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/NonPayable.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/whitelist/WhitelistABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/whitelist/iWhitelist.sol";

//interface iAccessControlWhitelist is iAccessControl,
//    iWhitelist
//{
//}

//interface iSafeMortalWhitelist is iSafeMortalCanary,
//    iWhitelist
//{
//}
///
/// @title Access Control Address Whitelist
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/5/2021, All Rights Reserved
///
/// deplpoyment cost: 1,988,787 (previous version required 1,399,630 gas)
///
/// inspired by OpenZeppelin's AccessControl contract at:
///    https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/access/AccessControl.sol
/// 
/// This contract is similar to a black list, but rather than banning malicious addresses,
/// a white-list provides a mechanism to confirm trusted address can be granted access to restricted functionality,
/// automatically denying access to non-whitelisted addresses
/// 
/// This is the preferred method, oppossed to using a black-list,
/// since a white-list requires explicit granting of access before accessesing functionality,
/// where as a black list, by deafault allows access, unless an address is on the black list,
/// which is reactive, first requiring being the victim of a hostile action to know what addresses to blacklist,
/// oppossed to a whitelist, which is proactive (denying all access by default)
///
/// Additionally, both black and white lists can be used in concert,
/// with the blacklist banning malicious, buggy or nefarious contracts or known hackers by default,
///     and then by allowing only non-blacklisted addresses to be permitted onto the whitelist to access functionality
///
contract Whitelist is ERC165,   //SafeCanary
    //NonPayable
    WhitelistABC,
    iWhitelist
{
    bytes32 private constant _WHITELIST_STORAGE_SLOT = keccak256('solidarity.accessControl.whitelistABC.STORAGE_SLOT');
    
    //string private constant _NAME = ' Whitelist: ';
    
    constructor(
    )public
        ERC165()
        //MortalCanary()
        //WhitelistABC(_STORAGE_SLOT, [])
        WhitelistABC()
    {
        _registerInterface(type(iWhitelist).interfaceId);
    }
    //function init(
        //address[] memory permitted,
        //address[] memory assignors,
        //address[] memory revokers
    //)external _onlyDefaultAdmin initializer
    //{
        //for(uint i; i < permitted.length; i++){
            //_setupRole(ROLE_PERMITTED, permitted[i]);
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
        address account
    )external virtual override //returns(address)  //,bytes32,bytes32, bytes32)  //override nonReentrant
    {
        _requireThisPermitted();

        address sender = _msgSender();
        //sender must be admin and also be permitted to use this contract
        //_requirePermitted(sender);
        //_requireThisPermitted();
        //_requireIsAssignorOrAdmin(sender);
        _requireHasAdminRole(ROLE_PERMITTED, sender);
        //
        // require signer has not already been granted permission
        _requireNotHasRole(ROLE_PERMITTED, account);

        _incrementNonce(account);
        
        _grantRole(ROLE_PERMITTED, account);
    }
    
    ///
	/// @dev whitelists all the addresses in `accounts`
    /// transaction cost: 195,085 gas + execution cost 166,837 gas === 361,922 total gas
    /// emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - caller must have `role`'s admin role or be default admin
    ///     - caller must not be the recovered singer's address
    ///     - reverts if any address in `accounts` has previously been white-listed
    /// 
    function grantPermission(
        address[] memory accounts
    )external virtual override //returns(address)  //,bytes32,bytes32, bytes32)  //override nonReentrant
    {
        _requireThisPermitted();

        address sender = _msgSender();
        //sender must be admin and also be permitted to use this contract
        //_requirePermitted(sender);
        //_requireIsAssignorOrAdmin(sender);
        _requireHasAdminRole(ROLE_PERMITTED, sender);
        //
        uint L = accounts.length;
        address account;
        
        for(uint i; i < L; i++){
            // require signer has not already been granted permission
            account = accounts[i];
            
            _requireNotHasRole(ROLE_PERMITTED, account);

            _incrementNonce(account);
            
            _grantRole(ROLE_PERMITTED, account);
        }
    }
    
    function isPermitted(
        address account
    )public view virtual override returns(
        bool
    ){
        _requireThisPermitted();

        //if(account.equal(owner())){
            //return true;
        //}
        
        return _hasRole(ROLE_PERMITTED, account);
    }
    
    function isPermitted(
        address[] memory accounts
    )public view virtual override returns(
        bool[] memory ret
    ){
        _requireThisPermitted();

        //if(account.equal(owner())){
            //return true;
        //}
        uint L = accounts.length;
        
        ret = new bool[](L);
        
        for(uint i; i < L; i++){
            ret[i] = _hasRole(ROLE_PERMITTED, account);
        }
    }
    //function isAssignor(
        //address account
    //)public view override returns(
        //bool
    //){
        //if(account.equal(owner())){
            //return true;
        //}
        //
        //return _hasRole(ROLE_ASSIGNOR, account);
    //}
    //function isRevoker(
        //address account
    //)public view override returns(
        //bool
    //){
        //if(account.equal(owner())){
            //return true;
        //}
        //
        //return _hasRole(ROLE_REVOKER, account);
    //}
    ///
    /// @return {uint256} the number of white-listed accounts,
    /// can be used together with {getRoleMember} to enumerate all white-listed accounts
    ///
    //function permittedAddresses(
    //)public view returns(
        //address[] memory
    //){
        //_requireHasAdminRole(ROLE_PERMITTED, _msgSender());
        //
        //return _roleAt(ROLE_PERMITTED).members;
    //}
    ///
    /// @return {uint256} the number of white-listed accounts,
    /// can be used together with {getRoleMember} to enumerate all white-listed accounts
    ///
    function getPermittedMemberCount(
    )public view override returns(
        uint256
    ){
        //return _roleAt(ROLE_PERMITTED).members.length();
        return _roleMemberCount(ROLE_PERMITTED);
    }
    ///
    /// @return {uint256} the number of role assignors,
    /// 
    //function getAssignorMemberCount(
    //)public view override returns(
        //uint256
    //){
        //return _roleMemberCount(ROLE_ASSIGNOR);
    //}
    ///
    /// @return {uint256} the number of role assignors,
    /// 
    //function getRevokerMemberCount(
    //)public view override returns(
        //uint256
    //){
        //return _roleMemberCount(ROLE_REVOKER);
    //}
    
    //get the addresses associated with the assignor's admin role
    //function assignorAdmin(
    //)public view override returns(
        //address
    //){
        // return ;
    //}
    
    //get the addresses associated with the revoker's admin role
    //function revokerAdmin(
    //)public view override returns(
        //address
    //){
        // return ;
    //}
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
    )external virtual override  //NonReentrant
        //onlyOwnerAdminOrRole(ROLE_REVOKER)
    {
        //revoke this contract's permission to disable functionality permanently!
        _requireThisPermitted();

        address sender = _msgSender();
        //address O = owner();
        
        //if(sender.equal(O) || _hasDefaultAdminRole(sender)){
            //prevent owner from or admin from revoking owner's permissions
            //_requireNotOwner(account);
        //}
        //
        //if(account == _this()){
            //_requireDefaultAdmin(sender);
        //}
        //else{
            _requireHasAdminRole(ROLE_PERMITTED, sender);
        //}
        //
        //if(!_hasDefaultAdminRole(sender)){
            _requireNotHasAdminRole(ROLE_PERMITTED, account);
        //}
        _requireHasRole(ROLE_PERMITTED, account);
        //
        //if(role.equal(ROLE_PERMITTED)){
            //if(_hasRole(ROLE_REVOKER)){
                //_renounceRole(ROLE_REVOKER, sender);
            //}
            //
            //if(_hasRole(ROLE_ASSIGNOR)){
                //_renounceRole(ROLE_ASSIGNOR, sender);
            //}
            
            //if(_hasRole(ROLE_ADMIN)){
                //_renounceRole(ROLE_ADMIN, sender);
            //}
        //}
        //
        _incrementNonce(account);
        
        _revokeRole(ROLE_PERMITTED, account);
    }
    ///
    /// @dev Revokes `account` from whitelist
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - reverts if account in `accounts` has not previously been white-listed
    ///
    //function revokePermission(
        //address[] memory accounts
    //)external virtual override  //NonReentrant
        //onlyOwnerAdminOrRole(ROLE_REVOKER)
    //{
    //}
    ///
    /// @dev Caller renounces their access to whitelist
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - caller cannot be this contract
    ///     - reverts if caller has not previously been white-listed
    ///
    //function renouncePermission(
    //)external virtual override  //NonReentrant
    //{
        //address sender = _msgSender();
        //
        //this contract must have permission revoked, can not renounce own permission, otherwise bugs
        //_requireNotNullAndNotThis(sender);
        //_requireHasRole(ROLE_PERMITTED, sender);
        //
        //if(role.equal(ROLE_PERMITTED)){
            //if(_hasRole(ROLE_REVOKER)){
                //_renounceRole(ROLE_REVOKER, sender);
            //}
            //
            //if(_hasRole(ROLE_ASSIGNOR)){
                //_renounceRole(ROLE_ASSIGNOR, sender);
            //}
            
            //if(_hasRole(ROLE_ADMIN)){
                //_renounceRole(ROLE_ADMIN, sender);
            //}
        //}
        //
        //_incrementNonce(sender);
        //
        //_revokeRole(ROLE_PERMITTED, sender);
    //}
    ///
    /// @dev Transfers permission from caller to `account`
    /// emits a {RoleRevoked} and {RoleGranted} events
    ///
    /// Requirements:
    ///     - reverts if caller is not an admin
    ///     - reverts if caller is not whitelisted
    ///     - reverts if `account` is null, caller or has previously been whitelisted
    ///
    //function transferPermission(
        //address account
    //)external virtual override  //NonReentrant
        //onlyDefaultAdminOrRoleAdmin
    //{
        //_requireHasAdminRole(ROLE_PERMITTED, _msgSender());
        //_requireNotHasRole(ROLE_PERMITTED, account);
        //
        //_transferRole(ROLE_PERMITTED, sender, account);
        //
        //_incrementNonce(sender);
        //_incrementNonce(account);
        //
        //NOTE: if caller is an admin they will retain the admin role for this contract
    //}
    ///
    /// @dev Atomic transfers of permission from `from` to addresses in `to`
    /// emits a {RoleRevoked} and {RoleGranted} events for each transfered role
    ///
    /// Requirements:
    ///     - reverts if caller is not an admin
    ///     - reverts if caller is not whitelisted
    ///     - reverts if account in `from` is null, caller, this contract or is not whitelisted
    ///     - reverts if account in `to` is null, caller, this contract or has previously been whitelisted
    ///
    //function transferPermission(
        //address[] calldata fromAccounts,
        //address[] calldata toAccounts
    //)external virtual override  //NonReentrant
        //onlyDefaultAdminOrRoleAdmin
    //{
        //_requireHasAdminRole(ROLE_PERMITTED, _msgSender());
        
        //address from;
        //address to;
        
        //bytes32 RP = ROLE_PERMITTED;
        //uint L = from.length;
        
        //L.requireGreaterThanZero();
        //L.requireEqual(to.length);
        
        //for(uint i; i < L; i++){
            //from = fromAccounts[i];
            //to = toAccounts[i];
            
            //from.requireNotEqual(to);
            
            //_requireAddressesNotEqual(sender, from, to);
            
            ////if(sender.notEqual(this)){
                //_requireAddressesNotNotNullAndNotThis(from, to);
            ////}
            
            //_requireHasRole(RP, from);
            //_requireNotHasRole(RP, to);
            //
            //_transferRole(RP, from, to);
            //
            //_incrementNonce(from);
            //_incrementNonce(to);
            
            ////_requireNotHasRole(RP, from);
            ////_requireHasRole(RP, to);
        //}
        //
        //_incrementNonce(sender);
        //
        //NOTE: if caller is an admin they will retain the admin role for this contract
    //}
}