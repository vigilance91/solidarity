// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableSet.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/cryptography/ECDSA.sol";

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/access/AccessControl.sol";

//import "https://github.com/vigilance91/solidarity/contracts/finances/NonPayable.sol";

import "https://github.com/vigilance91/solidarity/contracts/nonces/NoncesABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControl.sol";

//import "https://github.com/vigilance91/solidarity/contracts/accessControl/whitelist/WhitelistABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/whitelist/iWhitelist.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

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
/// deployment cost:
///     = transaction cost: 1,891,498 gas + execution cost 1,399,630 gas 
///     = 3,291,128 gas
///
///
/// inspired by OpenZeppelin's AccessControl contract at:
///    https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/access/AccessControl.sol
/// 
/// This contract is similar to a black list, but rather than banning malicious addresses,
/// a white-list provides a mechanism to confirm trusted address can be granted access to restricted functionality,
/// automatically denying access to non-whitelisted addresses
/// 
/// This is the preferred method, oppossed to using a black-list,
/// since a white-list requires explicit granting of access before being granted access to functionality,
/// where as a black list, by deafault allows access, unless an address is on the black list,
/// which is reactive, first requiring being the victim of a hostile action to know what addresses to blacklist,
/// oppossed to a whitelist, which is proactive (dnying all access by default)
///
/// Additionally, both black and white lists can be used in concert,
/// with the blacklist banning malicious, buggy or nefarious contracts or known hackers by default,
///     and then by allowing only non-blacklisted addresses to be permitted onto the whitelist to access functionality
///
contract Whitelist is ERC165,   //SafeMortalCanary
    WhitelistABC,
    //NonPayable,
    //ContractConstraints,
    iWhitelist
{
    using EnumerableSet for EnumerableSet.AddressSet;
    
    using LogicConstraints for bool;
    using AddressConstraints for address;
    using Bytes32Constraints for bytes32;
    
    using stringUtilities for string;
    
    using addressToString for address;

    bytes32 private constant _WHITELIST_STORAGE_SLOT = keccak256('solidarity.accessControl.whitelistABC.STORAGE_SLOT');
    
    //string private constant _NAME = ' Whitelist: ';
    
    constructor(
    )public
        ERC165()
        //MortalCanary()
        //WhitelistABC(_STORAGE_SLOT, [])
        WhitelistABC()
    {
        _thisHex = address(this).hexadecimal();
        
        _setRoleAdmin(ROLE_PERMITTED, DEFAULT_ADMIN_ROLE);
        
        _setupRole(ROLE_PERMITTED, _msgSender());
        _setupRole(ROLE_PERMITTED, address(this));
        
        _registerInterface(type(iWhitelist).interfaceId);
        //_registerInterface(type(iAccessControl).interfaceId);
        //_registerInterface(iAccessControlWhitelist).interfaceId);
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
        bytes32 signerHash,
        bytes memory signature
    )external virtual override //returns(address)  //,bytes32,bytes32, bytes32)  //override nonReentrant
    {
        address sender = _msgSender();
        //sender must be admin and also be permitted to use this contract
        //_requirePermitted(sender);
        //_requireIsAssignorOrAdmin(sender);
        _requireHasAdminRole(ROLE_PERMITTED, sender);
        
        address signer = ECDSA.recover(
            ECDSA.toEthSignedMessageHash(signerHash),   //messageHash,
            signature
        );
        //prevent signer from self-permitting
        signer.requireNotEqual(
            sender
            //'admin can not be signer'
        );
        
        //ensure the recovered signer's address matchs the original hash sent in the message,
        //otherwise, someone who isn't the hashed account tried to send a fraudulent messsage,
        //signed by a different account
        //_addressHash(signer).requireEqual(
            //signerHash
        //);
        require(
            _addressHash(signer) == signerHash,
            'invalid signer hash'
        );
        // require signer has not already been granted permission
        _requireNotHasRole(ROLE_PERMITTED, signer);
        
        //caller of permit() can not be the transaction signer
        //return (
            //signer,
            //signerHash,
            //_addressHash(signer),
            //messageHash
        //);
        
        _incrementNonce(signer);
        
        _grantRole(ROLE_PERMITTED, signer);
        
        //return signer;
    }
    /// @dev `sender` whitelists an external, verified, contract `target`, granting permission to utilize the network's infrastructure
    function _grantContractPermission(
        address sender,
        address target,
        bytes32 targetHash,
        bytes memory signature
    )internal //returns(address)  //,bytes32,bytes32, bytes32)  //override nonReentrant
    {
        //address sender = _msgSender();
        //sender must be admin and also be permitted to use this contract
        //_requirePermitted(sender);
        _requireHasAdminRole(ROLE_PERMITTED, sender);
        
        address signer = ECDSA.recover(
            ECDSA.toEthSignedMessageHash(targetHash),
            signature
        );
        //signer must be the sender and also a permitted admin
        signer.requireEqual(
            sender
            //'admin can not be signer'
        );
        
        //ensure the recovered traget contract address matchs the original hash sent in the signed message by the admin,
        //otherwise, any contract can be aritrarily signed and granted permission
        //_addressHash(signer).requireEqual(
            //signerHash
        //);
        require(
            _addressHash(target) == targetHash,
            'invalid signer hash'
        );
        // require signer has not already been granted permission
        _requireNotHasRole(ROLE_PERMITTED,target);
        
        //caller of permit() can not be the transaction signer
        //return (
            //signer,
            //signerHash,
            //_addressHash(signer),
            //messageHash
        //);
        
        _incrementNonce(target);
        
        _grantRole(ROLE_PERMITTED, target);
        
        //return signer;
    }
    // @dev owner may use this to whitelist external,
    // verified contracts (such as other Solidarity products, Tether, Uniswap, 1inch, Bancor, etc),
    // in combination with Whitelist's `grantPermission` signed message function
    //function _contractAddressHash(
        //address target
    //)internal view returns(
        //bytes32
    //){
        //target.isContract().requireTrue(
            //'target must be contract address'
        //);
        //return _addressHash(target);
    //}
    /// 
    /// @return {bytes32} hash of the hexadecimal string of this address concatentated with account's hexadecimal repressentation, combined with that account's current nonce
    /// @dev this will be unique after each successful call to permit, or similar transactions, which increments the account's nonce
    /// 
    function _addressHash(
        address account
    )internal view returns(
        bytes32
    ){
        account.requireNotNull();
        
        return _thisHex.saltAndHash(
            _asHexAndSalt(account)
        );
    }
    /// 
    /// @dev concatentate hex repressentation of this contract's address, caller's address,
    /// and caller's nonce, then hash result. Use this result for argument `signerHash` in {permit}
    /// 
    function callerAddressHash(
    )external view override returns(
        bytes32
    ){
        return _addressHash(_msgSender());
    }
    ///
    ///constraints
    ///
    function _requirePermitted(
        address account
    )internal view
    {
        _hasRole(ROLE_PERMITTED, account).requireTrue(
            //_NAME.concatentate("address not white-listed")
        );
    }
    function _requireNotPermitted(
        address account
    )internal view
    {
        _hasRole(ROLE_PERMITTED, account).requireFalse(
            //_NAME.concatentate("address is white-listed")
        );
    }
    function _requireThisPermitted(
    )internal view
    {
        _requirePermitted(
            address(this)
        );
    }
    function _requireThisNotPermitted(
    )internal view
    {
        _requireNotPermitted(
            address(this)
        );
    }
    function isPermitted(
        address account
    )public view virtual override returns(
        bool
    ){
        //if(account.equal(owner())){
            //return true;
        //}
        
        return _hasRole(ROLE_PERMITTED, account);
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
    )external virtual virtual override  //NonReentrant
        //onlyOwnerAdminOrRole(ROLE_REVOKER)
    {
        //address sender = _msgSender();
        //address O = owner();
        
        //if(sender.equal(O) || _hasDefaultAdminRole(sender)){
            //prevent owner from or admin from revoking owner's permissions
            //_requireNotOwner(account);
        //}
        //
        _requireHasAdminRole(ROLE_PERMITTED, _msgSender());
        //
        //if(!_hasDefaultAdminRole(sender)){
            _requireNotHasAdminRole(ROLE_PERMITTED, account);
        //}
        _requireHasRole(ROLE_PERMITTED, account);
        
        _incrementNonce(account);
        
        _revokeRole(ROLE_PERMITTED, account);
    }
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
}