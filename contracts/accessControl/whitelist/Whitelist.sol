// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableSet.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/cryptography/ECDSA.sol";

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/access/AccessControl.sol";

import "https://github.com/vigilance91/solidarity/contracts/nonces/NoncesABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControl.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/whitelist/iWhitelist.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title Access Control Address Whitelist
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/5/2021, All Rights Reserved
/// @dev 0x3Da96cE2b76C6ffFa7704FC4A29821ABAC096adB
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
contract Whitelist is ERC165,
    AccessControl,
    NoncesABC,
    iWhitelist
{
    using EnumerableSet for EnumerableSet.AddressSet;
    
    using LogicConstraints for bool;
    using AddressConstraints for address;
    using Bytes32Constraints for bytes32;
    
    using stringUtilities for string;
    
    using addressToString for address;

    bytes32 public constant ROLE_PERMITTED = keccak256('solidarity.whitelist.role.permitted');
    
    string private _thisHex;
    
    //string intnernal constant _NAME = ' Whitelist: ';
    
    constructor(
    )public
        ERC165()
        AccessControl()
        NoncesABC()
    {
        _thisHex = address(this).hexadecimal();
        
        _setupRole(ROLE_PERMITTED, _msgSender());
        _setupRole(ROLE_PERMITTED, address(this));
        
        _registerInterface(type(iAccessControl).interfaceId);
        _registerInterface(type(iWhitelist).interfaceId);
    }
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
        _requireNotHasRole(ROLE_PERMITTED,signer);
        
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
        hasRole(ROLE_PERMITTED, account).requireTrue(
            //"address not white-listed"
        );
    }
    function _requireNotPermitted(
        address account
    )internal view
    {
        hasRole(ROLE_PERMITTED, account).requireFalse(
            //"address is white-listed"
        );
    }
    function isPermitted(
        address account
    )public view override returns(
        bool
    ){
        return hasRole(ROLE_PERMITTED, account);
    }
    ///
    /// @return {uint256} the number of white-listed accounts,
    /// can be used together with {getRoleMember} to enumerate all white-listed accounts
    ///
    function getPermittedMemberCount(
    )public view override returns(
        uint256
    ){
        //return _roleAt(ROLE_PERMITTED).members.length();
        return getRoleMemberCount(ROLE_PERMITTED);
    }
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
    )external virtual override
        //onlyDefaultAdminOrRoleAdmin
    {
        _requireHasAdminRole(ROLE_PERMITTED, _msgSender());
        _requireHasRole(ROLE_PERMITTED,account);
        
        _revokeRole(ROLE_PERMITTED, account);
    }
}