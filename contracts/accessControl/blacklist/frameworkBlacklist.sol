// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/blacklist/iBlacklist.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/frameworkAccessControl.sol";
///
/// @title Framework Blacklist Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
library frameworkBlacklist
{
    using LogicConstraints for bool;
    using AddressConstraints for address;
    
    using frameworkERC165 for address;
    using frameworkAccessControl for address;
    
    string private constant _NAME = 'frameworkBlacklist: ';
    
    bytes private constant _CALLER_ADDRESS_HASH_SIGNATURE = abi.encodeWithSignature(
        'callerAddressHash()'
    );
    
    bytes private constant _ROLE_BANNED_SIGNATURE = abi.encodeWithSignature(
        'ROLE_BANNED()'
    );
    
    bytes private constant _GET_BANNED_MEMBER_COUNT_SIGNATURE = abi.encodeWithSignature(
        'getBannedMemberCount()'
    );
    
    bytes4 private constant _iBLACKLIST_ID = type(iBlacklist).interfaceId;
    
    function _requireSupportsInterface(
        address target
    )private view
    {
        target.supportsInterface(_iBLACKLIST_ID).requireTrue(
            'contract does not implement iBlacklist'
        );
    }
    
    function _requireBanned(
        address target,
        address account
    )internal view
    {
        isBanned(target, account).requireTrue(
            //"sender is not banned"
        );
    }
    function _requireNotBanned(
        address target,
        bytes32 role,
        address account
    )internal view
    {
        isBanned(target, account).requireFalse(
            //"sender is banned"
        );
    }
    //function _requireHasAdminRole(
        //bytes32 role,
        //address account
    //)internal view
    //{
        //hasRole(target, _roleAt(role).adminRole, account).requireTrue(
            ////"sender must be an admin"
        //);
    //}
    //function _requireNotHasAdminRole(
        //address target,
        //bytes32 role,
        //address account
    //)internal view
    //{
        //hasRole(target, _roleAt(role).adminRole, account).requireFalse(
            ////"sender must not be an admin"
        //);
    //}
    /**
    modifier onlyBanned(
        bytes32 role
    )internal view
    {
        _requireHasRole(role, _msgSender());
        _;
    }
    modifier onlyNotBanned(
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
    function isBanned(
        address target,
        address account
    )public view returns(
        bool ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'isBanned(address)',
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
    function ban(
        address target,
        address account
    )public
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'ban(address)',
                account
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
    function revokeBan(
        address target,
        address account
    )public
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'revokeBan(address)',
                account
            )
        );
        success.requireTrue('call failed');
    }
    
    function roleBanned(
        address target
    )public view returns(
        bytes32 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _ROLE_BANNED_SIGNATURE
        );
        success.requireTrue('static call failed');
        
        (ret) = abi.decode(result, (bytes32));
    }
    
    function getBannedMemberCount(
        address target
    )public view returns(
        uint256 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _GET_BANNED_MEMBER_COUNT_SIGNATURE
        );
        success.requireTrue('static call failed');
        
        (ret) = abi.decode(result, (uint256));
    }
}