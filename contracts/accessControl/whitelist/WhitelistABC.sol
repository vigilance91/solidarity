// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableSet.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/cryptography/ECDSA.sol";

//import "https://github.com/vigilance91/solidarity/contracts/finances/NonPayable.sol";

import "https://github.com/vigilance91/solidarity/contracts/nonces/NoncesABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControlABC.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/whitelist/iWhitelist.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title Access Control Address Whitelist Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 9/12/2021, All Rights Reserved
///
/// deployment cost:
///     = transaction cost: 1,891,498 gas + execution cost 1,399,630 gas 
///     = 3,291,128 gas
///
abstract contract WhitelistABC is NoncesABC,
    AccessControlABC
    //NonPayable,
    //ContractConstraints
{
    using EnumerableSet for EnumerableSet.AddressSet;
    
    using LogicConstraints for bool;
    using AddressConstraints for address;
    using Bytes32Constraints for bytes32;
    
    using stringUtilities for string;
    
    using addressToString for address;

    bytes32 private constant _STORAGE_SLOT = keccak256('solidarity.accessControl.whitelistABC.STORAGE_SLOT');
    //
    //bytes32 public constant ROLE_WHITELIST_ADMIN = keccak256('solidarity.accessControl.whitelistABC.role.ADMIN');     //has both assignor and revoker rights but can not assign other admins
    //
    //bytes32 public constant ROLE_ASSIGNOR = keccak256('solidarity.accessControl.whitelistABC.role.ASSIGNOR');     //assigns permission
    //bytes32 public constant ROLE_REVOKER = keccak256('solidarity.accessControl.whitelistABC.role.REVOKER');       //revokes permission
    //
    bytes32 public constant ROLE_PERMITTED = keccak256('solidarity.accessControl.whitelistABC.role.PERMITTED');     //role granted to whitelisted addresses permitted to access network resources
    
    string private _thisHex;
    
    //string private constant _NAME = ' WhitelistABC: ';
    
    constructor(
        //address[] memory permitted,
        ////address[] memory assignors
        ////address[] memory revokers
    )internal
        NoncesABC()
        AccessControlABC(
            //_STORAGE_SLOT
        )
    {
        _thisHex = address(this).hexadecimal();
        
        ////_setRoleAdmin(ROLE_WHITELIST_ADMIN, DEFAULT_ADMIN_ROLE);
        
        //_setRoleAdmin(ROLE_ASSIGNOR, ROLE_WHITELIST_ADMIN_ROLE);
        //_setRoleAdmin(ROLE_REVOKER, ROLE_WHITELIST_ADMIN_ROLE);
        _setRoleAdmin(ROLE_PERMITTED, DEFAULT_ADMIN_ROLE);  //ROLE_WHITELIST_ADMIN_ROLE);
        
        _setupRole(ROLE_PERMITTED, _msgSender());
        _setupRole(ROLE_PERMITTED, address(this));
        //
        //_setupRole(ROLE_REVOKER, _msgSender());
        //_setupRole(ROLE_ASSIGNOR, _msgSender());
        //
        ////_setupRole(ROLE_ASSIGNOR, address(this));
        ////_setupRole(ROLE_REVOKER, address(this));
        //
        //address a;
        //
        //if(permitted.length > 0){
            //for(uint i; i < permitted.length; i++){
                //a = permitted[i];
                //
                //_setupRole(ROLE_PERMITTED, a);
            //}
        //}
        
        //if(assignors.length > 0){
            ////for(uint i; i < assignors.length; i++){
                ////a = assignors[i];
                ////
                ////_setupRole(ROLE_ASSIGNOR, a);
            ////}
        ////}
        
        ////if(revokers.length > 0){
            ////for(uint i; i < revokers.length; i++){
                ////a = revokers[i];
                ////
                ////_setupRole(ROLE_REVOKER, a);
            ////}
        ////}
    }
    /*
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
    function _grantPermission(
        bytes32 signerHash,
        bytes memory signature
    )internal virtual override //returns(address)  //,bytes32,bytes32, bytes32)  //override nonReentrant
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
    */
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
    
    //function _requireAssignor(
        //address account
    //)internal view
    //{
        //_hasRole(ROLE_ASSIGNOR, account).requireTrue(
            ////_NAME.concatentate("address not a role assignor")
        //);
    //}
    //function _requireNotAssignor(
        //address account
    //)internal view
    //{
        //_hasRole(ROLE_ASSIGNOR, account).requireFalse(
            ////_NAME.concatentate("address cannot be a role assignor")
        //);
    //}
    //
    //function _requireRevoker(
        //address account
    //)internal view
    //{
        //_hasRole(ROLE_REVOKER, account).requireTrue(
            ////_NAME.concatentate("address not a role revoker")
        //);
    //}
    //function _requireNotRevoker(
        //address account
    //)internal view
    //{
        //_hasRole(ROLE_REVOKER, account).requireFalse(
            ////_NAME.concatentate("address cannot be a role revoker")
        //);
    //}
}