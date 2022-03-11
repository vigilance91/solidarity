// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableSet.sol";

import "https://github.com/vigilance91/solidarity/contracts/ContractConstraintsABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/nonces/NoncesABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControlABC.sol";
///
/// @title Access Control Address Whitelist View Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 9/12/2021, All Rights Reserved
///
/// deployment cost:
///     = transaction cost: 1,891,498 gas + execution cost 1,399,630 gas 
///     = 3,291,128 gas
///
abstract contract WhitelistViewABC is ContractConstraintsABC,
    NoncesABC,
    AccessControlABC
{
    using EnumerableSet for EnumerableSet.AddressSet;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    using Bytes32Constraints for bytes32;
    
    using stringUtilities for string;
    
    using addressToString for address;
    
    string private constant _NAME = ' - WhitelistViewABC: ';
    
    //bytes32 private _NAMESPACE_HASH = bytes32(uint256(keccak256('solidarity.accessControl.')) - 1);
    
    //bytes32 private constant _STORAGE_SLOT = _NAMESPACE_HASH ^ bytes32(uint256(
        //keccak256('WhitelistABC.STORAGE_SLOT')
    //) - 1);
    
    //= _NAMESPACE_HASH ^ bytes32(uint256(
        //keccak256('WhitelistABC.STORAGE_SLOT')
    //) - 1);
    bytes32 private constant _STORAGE_SLOT = keccak256('solidarity.accessControl.whitelistABC.STORAGE_SLOT');   //_NAMESPACE_HASH ^ bytes32(uint256(keccak256('whitelistABC.STORAGE_SLOT') ) - 1);
    //
    //bytes32 public constant ROLE_WHITELIST_ADMIN = _NAMESPACE_HASH ^ bytes32(uint256(
        //keccak256('WhitelistViewABC.role.ADMIN')
    //) - 1);     //has both assignor and revoker rights but can not assign other admins
    //
    //bytes32 public constant ROLE_ASSIGNOR = _NAMESPACE_HASH ^ bytes32(uint256(
        //keccak256('WhitelistViewABC.role.ASSIGNOR')
    //) - 1);     //assigns permission
    //bytes32 public constant ROLE_REVOKER = _NAMESPACE_HASH ^ bytes32(uint256(
        //keccak256('WhitelistViewABC.role.REVOKER')
    //) - 1);       //revokes permission
    //
    //bytes32 public constant ROLE_PERMITTED = _NAMESPACE_HASH ^ bytes32(uint256(
        //keccak256('WhitelistViewABC.role.PERMITTED')
    //) -1);     //role granted to whitelisted addresses permitted to access network resources
    bytes32 public constant ROLE_PERMITTED = keccak256('solidarity.accessControl.whitelistABC.ROLE_PERMITTED');     //role granted to whitelisted addresses permitted to access network resources
    
    string private constant _ERR_STR_ADRS = ", address: ";
    
    string private constant _ERR_IS_WHITELISTED = string(
        abi.encodePacked(
            _NAME,
            "white-listed",
            _ERR_STR_ADRS
        )
    );
    
    string private constant _ERR_NOT_WHITELISTED = string(
        abi.encodePacked(
            _NAME,
            "not white-listed",
            _ERR_STR_ADRS
        )
    );
    
    /*
    string private constant _ERR_IS_REVOKER = string(
        abi.encodePacked(
            _NAME,
            "cannot be a revoker",
            _ERR_STR_ADRS
        )
    );
    string private constant _ERR_NOT_REVOKER = string(
        abi.encodePacked(
            _NAME,
            "not revoker",
            _ERR_STR_ADRS
        )
    );
    
    string private constant _ERR_IS_ASSIGNOR = string(
        abi.encodePacked(
            _NAME,
            "cannot be an assignor",
            _ERR_STR_ADRS
        )
    );
    string private constant _ERR_NOT_ASSIGNOR = string(
        abi.encodePacked(
            _NAME,
            "not assignor",
            _ERR_STR_ADRS
        )
    );
    
    */
    
    constructor(
    )internal
        ContractConstraintsABC()
        NoncesABC()
        AccessControlABC(
            //_STORAGE_SLOT
        )
    {
        ////_setRoleAdmin(ROLE_WHITELIST_ADMIN, ROLE_DEFAULT_ADMIN);
        
        //_setRoleAdmin(ROLE_ASSIGNOR, ROLE_WHITELIST_ADMIN_ROLE);
        //_setRoleAdmin(ROLE_REVOKER, ROLE_WHITELIST_ADMIN_ROLE);
        _setRoleAdmin(ROLE_PERMITTED, ROLE_DEFAULT_ADMIN);  //ROLE_WHITELIST_ADMIN_ROLE);
        
        //address sender = _msgSender();
        
        _setupRole(ROLE_PERMITTED, _msgSender());
        _setupRole(ROLE_PERMITTED, address(this));
        //
        //_setupRole(ROLE_REVOKER, sender);
        //_setupRole(ROLE_ASSIGNOR, sender);
        //
        ////_setupRole(ROLE_ASSIGNOR, address(this));
        ////_setupRole(ROLE_REVOKER, address(this));
    }
    //function init(
        //address[] calldata permitted,
        ////address[] calldata assignors
        ////address[] calldata revokers
    //){
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
    //}
    /*
	/// @dev admin grants `account` permission
    /// emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - caller must have `role`'s admin role or be default admin
    ///     - caller must not be the recovered singer's address
    ///     - reverts if `account` has previously been white-listed
    /// 
    function _grantPermission(
        address account
    )internal virtual override //returns(address)  //,bytes32,bytes32, bytes32)  //override nonReentrant
    {
        address sender = _msgSender();
        //sender must be admin and also be permitted to use this contract
        //_requirePermitted(sender);
        _requireHasAdminRole(ROLE_PERMITTED, sender);
        //
        //ensure the recovered signer's address matchs the original hash sent in the message,
        //otherwise, someone who isn't the hashed account tried to send a fraudulent messsage,
        //signed by a different account
        _requireNotHasRole(ROLE_PERMITTED,account);
        
        _incrementNonce(account);
        
        _grantRole(ROLE_PERMITTED, account);
        
        //return signer;
    }
    */
    ///
    ///constraints
    ///
    function _requirePermitted(
        address account
    )internal view
    {
        //_requireHasRole(
            //ROLE_PERMITTED,
            //account,
            //_ERR_NOT_WHITELISTED,
        //);
        
        _hasRole(ROLE_PERMITTED, account).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_NOT_WHITELISTED,
                    account
                )
            )
        );
    }
    function _requireNotPermitted(
        address account
    )internal view
    {
        //_requireNotHasRole(
            //ROLE_PERMITTED,
            //account,
            //_ERR_IS_WHITELISTED
        //);
        
        _hasRole(ROLE_PERMITTED, account).requireFalse(
            string(
                abi.encodePacked(
                    _ERR_IS_WHITELISTED,
                    account
                )
            )
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
    //function _requireAssignor(
        //address account
    //)internal view
    //{
        //_requireHasRole(
            //ROLE_ASSIGNOR,
            //account,
            //_ERR_NOT_ASSIGNOR
        //);
    //}
    //function _requireNotAssignor(
        //address account
    //)internal view
    //{
        //_requireNotHasRole(
            //ROLE_ASSIGNOR,
            //account,
            //_ERR_IS_ASSIGNOR
        //);
    //}
    //
    //function _requireRevoker(
        //address account
    //)internal view
    //{
        //_requireHasRole(
            //ROLE_REVOKER,
            //account,
            //_ERR_NOT_REVOKER,
        //);
    //}
    //function _requireNotRevoker(
        //address account
    //)internal view
    //{
        //_requireHasRole(
            //ROLE_REVOKER,
            //account,
            //_ERR_IS_REVOKER
        //);
    //}
}