// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/whitelist/iWhitelist.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/frameworkAccessControl.sol";
///
/// @title Framework Whitelist Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
library frameworkWhitelist
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using frameworkERC165 for address;
    using frameworkAccessControl for address;
    
    string private constant _NAME = ' frameworkWhitelist: ';
    
    string private constant _ERR_INTERFACE_NOT_IMPLEMENTED = string(
        abi.encodePacked(
            _NAME,
            'iWhitelist not implemented',
            _ERR_STR_ADRS
        )
    );
    
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
            "not white-listed: ",
            _ERR_STR_ADRS
        )
    );
    
    string private constant _STUB_IS_PERMITTED = 'isPermitted(address)';
    string private constant _STUB_GRANT_PERMISSION = 'grantPermission(address)';
    string private constant _STUB_REVOKE_PERMISSION = 'revokePermission(address)';
    
    string private constant _STUB_IS_PERMITTED_ARRAY = 'isPermitted(address[])';
    string private constant _STUB_GRANT_PERMISSION_ARRAY = 'grantPermission(address[])';
    string private constant _STUB_REVOKE_PERMISSION_ARRAY = 'revokePermission(address[])';
    
    string private constant _ERR_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            "call failed",
            _ERR_STR_ADRS
        )
    );
    string private constant _ERR_STATIC_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            "static call failed",
            _ERR_STR_ADRS
        )
    );
    //string private constant _ERR_DELEGATE_CALL_FAILED = string(
        //abi.encodePacked(
            //_NAME,
            //"delegate call failed",
            //_ERR_STR_ADRS
        //)
    //);
    
    bytes private constant _ROLE_PERMITTED_SIGNATURE = abi.encodeWithSignature(
        'ROLE_PERMITTED()'
    );
    
    bytes private constant _GET_PERMITTED_MEMBER_COUNT_SIGNATURE = abi.encodeWithSignature(
        'getPermittedMemberCount()'
    );
    
    bytes4 private constant _iWHITELIST_ID = type(iWhitelist).interfaceId;
    //bytes4 private constant _iACCESS_CONTROL_ID = type(iAccessControl).interfaceId;
    
    function _requireSupportsInterface(
        address target
    )private view
    {
        target.supportsInterface(_iWHITELIST_ID).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_INTERFACE_NOT_IMPLEMENTED,
                    target
                )
            )
        );
    }
    
    function _requirePermitted(
        address target,
        address account
    )internal view
    {
        isPermitted(target, account).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_NOT_WHITELISTED,
                    account
                )
            )
        );
    }
    function _requireNotPermitted(
        address target,
        address account
    )internal view
    {
        isPermitted(target, account).requireFalse(
            string(
                abi.encodePacked(
                    _ERR_IS_WHITELISTED,
                    account
                )
            )
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
    )internal view returns(
        bool ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                _STUB_IS_PERMITTED,
                account
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_STATIC_CALL_FAILED,
                    target
                )
            )
        );
        
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
        address target,
        address account
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                _STUB_GRANT_PERMISSION,
                account
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
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
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                _STUB_REVOKE_PERMISSION,
                account
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
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
    )internal view returns(
        bytes32 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _ROLE_PERMITTED_SIGNATURE
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_STATIC_CALL_FAILED,
                    target
                )
            )
        );
        
        (ret) = abi.decode(result, (bytes32));
    }
    
    function getPermittedMemberCount(
        address target
    )internal view returns(
        uint256 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _GET_PERMITTED_MEMBER_COUNT_SIGNATURE
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_STATIC_CALL_FAILED,
                    target
                )
            )
        );
        
        (ret) = abi.decode(result, (uint256));
    }
}