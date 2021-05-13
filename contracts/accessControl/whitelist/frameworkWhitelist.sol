// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/whitelist/iWhitelist.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/frameworkAccessControl.sol";
///
/// @title Framework Whitelist Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
library frameworkWhitelist
{
    using frameworkERC165 for address;
    using frameworkAccessControl for address;
    using AddressConstraints for address;
    
    string private constant _NAME = 'frameworkWhitelist: ';
    
    bytes private constant _CALLER_ADDRESS_HASH_SIGNATURE = abi.encodeWithSignature(
        'callerAddressHash()'
    );
    
    bytes private constant _ROLE_PERMITTED_SIGNATURE = abi.encodeWithSignature(
        'ROLE_PERMITTED()'
    );
    
    bytes private constant _GET_PERMITTED_MEMBER_COUNT_SIGNATURE = abi.encodeWithSignature(
        'getPermittedMemberCount()'
    );
    
    bytes4 private constant _iWHITELIST_ID = type(iWhitelist).interfaceId;
    
    function _supportsInterface(
        address target
    )private view
    {
        target.supportsInterface(_iWHITELIST_ID).requireTrue(
            'contract does not implement iWhitelist'
        );
    }
    
    function _requirePermitted(
        address target,
        address account
    )internal view
    {
        isPermitted(target, account).requireTrue(
            //"sender does not have role"
        );
    }
    function _requireNotPermitted(
        address target,
        bytes32 role,
        address account
    )internal view
    {
        isPermitted(target, account).requireFalse(
            //"sender already has role"
        );
    }
    function _requireHasAdminRole(
        bytes32 role,
        address account
    )internal view
    {
        hasRole(target, _roleAt(role).adminRole, account).requireTrue(
            //"sender must be an admin"
        );
    }
    function _requireNotHasAdminRole(
        address target,
        bytes32 role,
        address account
    )internal view
    {
        hasRole(target, _roleAt(role).adminRole, account).requireFalse(
            //"sender must not be an admin"
        );
    }
    /**
    modifier onlyPermitted(
        bytes32 role
    )internal view
    {
        _requireHasRole(role, _msgSender());
        _;
    }
    modifier onlyNotPermitted(
        bytes32 role
    ){
        _requireNotHasRole(role, _msgSender());
    }
    */
    ///
    ///read-only/staticcall interface
    ///
    
    ///
    /// @return ret {bool} true if account is whitelisted, granted access to network
    ///
    function isPermitted(
        address target,
        address account
    )public view returns(
        bool ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'isPermitted(address)',
                account
            )
        );
        success.requireTrue('staticcall failed');
        
        (ret) = abi.decode(result, (bool));
    }
    ///
    ///mutable interface
    ///
    
    ///
    /// @dev Grants `role` to `account`
    /// If `account` had not been already granted `role`, emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///
    function grantPermission(
        bytes32 signerHash,
        bytes memory signature
    )public
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'grantPermission(bytes32,bytes)',
                signerHash,
                signature
            )
        );
        success.requireTrue('call failed');
    }
    ///
    /// @dev Revokes `role` from `account`
    /// If `account` had been granted `role`, emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///
    function revokePermission(
        address target,
        address account
    )public
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'revokePermission(address)',
                account
            )
        );
        success.requireTrue('call failed');
    }
    ///
    /// @dev Revokes `role` from the calling account
    /// Roles are often managed via {grantRole} and {revokeRole}:
    /// this function's purpose is to provide a mechanism for accounts to lose their privileges
    /// if they are compromised (such as when a trusted device is misplaced)
    /// If the calling account had been granted `role`, emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must be `account`
    ///
    //function renouncePermission(
        //address target,
        //address account
    //)public
    //{
        //account.requireEquals(
            //_msgSender()
            //"can only renounce roles for self"
        //);
        //
        //revokePermission(target, account);
    //}
    //useful if a whitelisted contract or addresses changes/upgrades and wishes to revoke the current address,
    //transfering permission to the new contract
    //
    //function transferPermission(
        //address from,
        //address to
    //)public
    //{
        //_requireSupportsInterface(target);
        //
        //(bool success, ) = target.call(
            //abi.encodeWithSignature(
                //'transferPermission(address,address)',
                //from,
                //to
            //)
        //);
        //success.requireTrue('call failed');
    //}
    function rolePermitted(
        address target
    )public view returns(
        bytes32 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _ROLE_PERMITTED_SIGNATURE
        );
        success.requireTrue('static call failed');
        
        (ret) = abi.decode(result, (bytes32));
    }
    
    function callerAddressHash(
    )public view returns(
        bytes32
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _CALLER_ADDRESS_HASH_SIGNATURE
        );
        success.requireTrue('static call failed');
        
        (ret) = abi.decode(result, (bytes32));
    }
    function getPermittedMemberCount(
    )public view returns(
        uint256 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _GET_PERMITTED_MEMBER_COUNT_SIGNATURE
        );
        success.requireTrue('static call failed');
        
        (ret) = abi.decode(result, (uint256));
    }
}