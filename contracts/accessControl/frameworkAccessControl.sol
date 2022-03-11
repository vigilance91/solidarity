// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControl.sol";

library frameworkAccessControl
{
    using frameworkERC165 for address;
    
    using logicConstraints for bool;
    
    using addressConstraints for address;
    
    string private constant _NAME = 'frameworkAccessControl: ';
    
    string internal constant STUB_HAS_ROLE = 'hasRole(bytes32,address)';
    //
    string internal constant STUB_GET_ROLE_ADMIN = 'getRoleAdmin(bytes32)';
    string internal constant STUB_GET_ROLE_MEMBER = 'getRoleMember(bytes32,uint256)';
    string internal constant STUB_GET_ROLE_MEMBER_COUNT = 'getRoleMemberCount(bytes32)';
    //
    string internal constant STUB_GRANT_ROLE = 'grantRole(bytes32,address)';
    string internal constant STUB_REVOKE_ROLE = 'revokeRole(bytes32,address)';
    string internal constant STUB_TRANSFER_ROLE = 'transferRole(bytes32,address,address)';
    
    bytes4 private constant _iACCESS_CONTROL_ID = type(iAccessControl).interfaceId;
    
    function _requireSupportsInterface(
        address target
    )private view
    {
        target.supportsInterface(_iACCESS_CONTROL_ID).requireTrue(
            'contract does not implement iAccessControl'
        );
    }
    
    function _requireHasRole(
        address target,
        bytes32 role,
        address account
    )internal view
    {
        hasRole(target, role, account).requireTrue(
            //"sender does not have role"
        );
    }
    function _requireNotHasRole(
        address target,
        bytes32 role,
        address account
    )internal view
    {
        hasRole(target, role, account).requireFalse(
            //"sender already has role"
        );
    }
    /**
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
    */
    //function _roleAt(
        //address target,
        //bytes32 role
    //)internal view returns(
        //bytes32
    //){
        //return _roleAt(target, role);
    //}
    /**
    modifier onlyDefaultAdmin(
    )internal view
    {
        _requireIsDefaultAdmin(_msgSender());
        _;
    }
    modifier onlyRole(
        bytes32 role
    )internal view
    {
        _requireHasRole(role, _msgSender());
        _;
    }
    modifier _requireNotHasRole(
        bytes32 role
    ){
        _requireNotHasRole(role, _msgSender());
    }
    modifier onlyAdminRole(
        bytes32 role
    ){
        _requireHasAdminRole(role, _msgSender());
        _;
    }
    modifier requireNotHasAdminRole(
        bytes32 role
    )internal view
    {
        _requireNotHasAdminRole(role, _msgSender());
        _;
    }
    */
    ///
    ///read-only/staticcall interface
    ///
    function roleDefaultAdmin(
        address target
    )internal view returns(
        bytes32 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'ROLE_DEFAULT_ADMIN()'
            )
        );
        success.requireTrue('staticcall failed');
        
        (ret) = abi.decode(result, (bytes32));
    }
    /// @return ret {bool} `true` if `account` has been granted `role`
    function hasRole(
        address target,
        bytes32 role,
        address account
    )internal view returns(
        bool ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                STUB_HAS_ROLE,
                role,
                account
            )
        );
        success.requireTrue('staticcall failed');
        
        //ret = result.decodeBool();
        (ret) = abi.decode(result, (bool));
    }
    ///
    /// @return ret {uint256} the number of accounts that have `role`,
    /// can be used together with {getRoleMember} to enumerate all bearers of a role
    ///
    function getRoleMemberCount(
        address target,
        bytes32 role
    )internal view returns(
        uint256 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                STUB_GET_ROLE_MEMBER_COUNT,
                role
            )
        );
        success.requireTrue('staticcall failed');
        
        //ret = result.decodeUint256();
        (ret) = abi.decode(result, (uint256));
    }
    ///
    /// @return ret {address} one of the accounts that have `role`.
    /// `index` must be a value between 0 and {getRoleMemberCount}, non-inclusive
    /// Role bearers are not sorted in any particular way,
    /// and their ordering may change at any point
    ///
    /// WARNING:
    ///     When using {getRoleMember} and {getRoleMemberCount},
    ///     make sure you perform all queries on the same block
    ///
    ///     for more information see:
    ///         https://forum.openzeppelin.com/t/iterating-over-elements-on-enumerableset-in-openzeppelin-contracts/2296[forum post]
    ///
    function getRoleMember(
        address target,
        bytes32 role,
        uint256 index
    )internal view returns(
        address ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                STUB_GET_ROLE_MEMBER,
                role,
                index
            )
        );
        success.requireTrue('staticcall failed');
        
        //ret = result.decodeAddress();
        (ret) = abi.decode(result, (address));
    }
    ///
    /// @return ret {bytes32} admin role that controls `role`
    /// See {grantRole} and {revokeRole}
    /// To change a role's admin, use {_setRoleAdmin}
    ///
    function getRoleAdmin(
        address target,
        bytes32 role
    )internal view returns(
        bytes32 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                STUB_GET_ROLE_ADMIN,
                role
            )
        );
        success.requireTrue('staticcall failed');
        
        (ret) = abi.decode(result, (bytes32));
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
    function grantRole(
        address target,
        bytes32 role,
        address account
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                STUB_GRANT_ROLE,
                role,
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
    function revokeRole(
        address target,
        bytes32 role,
        address account
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                STUB_REVOKE_ROLE,
                role,
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
    function renounceRole(
        address target,
        bytes32 role,
        address account
    )internal
    {
        //account.requireEquals(
            //_msgSender()
            //"can only renounce roles for self"
        //);

        revokeRole(target, role, account);
    }
    
    function transferRole(
        address target,
        bytes32 role,
        address from,
        address to
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                STUB_TRANSFER_ROLE,
                role,
                from,
                to
            )
        );
        success.requireTrue('call failed');
    }
}
/*
library frameworkAccessControlInterfaceSupport
{
    using frameworkERC165 for address;
    
    using logicConstraints for bool;
    
    using addressConstraints for address;
    
    string private constant _NAME = 'frameworkAccessControlInterfaceSupport: ';
    
    //bytes4 internal constant IID_ACCESS_CONTROL_VIEW = type(iAccessControlView).interfaceId;
    //bytes4 internal constant IID_ACCESS_CONTROL_MUTABLE = type(iAccessControlMutable).interfaceId;
    bytes4 internal constant _iACCESS_CONTROL_ID = type(iAccessControl).interfaceId;
    
    function requireSupportsInterfaceAccessControl(
        address target
    )internal view
    {
        target.supportsInterface(_iACCESS_CONTROL_ID).requireTrue(
            'contract does not implement iAccessControl'
        );
    }
    
    
}
*/

library frameworkAccessControlView
{
    //using frameworkAccessControlInterfaceSupport for address;
    using frameworkERC165 for address;
    
    using logicConstraints for bool;
    
    using addressConstraints for address;
    
    string private constant _NAME = 'frameworkAccessControlView: ';
    
    string internal constant STUB_HAS_ROLE = 'hasRole(bytes32,address)';
    //
    string internal constant STUB_GET_ROLE_ADMIN = 'getRoleAdmin(bytes32)';
    string internal constant STUB_GET_ROLE_MEMBER = 'getRoleMember(bytes32,uint256)';
    string internal constant STUB_GET_ROLE_MEMBER_COUNT = 'getRoleMemberCount(bytes32)';
    
    bytes4 private constant _iACCESS_CONTROL_ID = type(iAccessControl).interfaceId;
    
    function _requireSupportsInterface(
        address target
    )private view
    {
        target.supportsInterface(_iACCESS_CONTROL_ID).requireTrue(
            'contract does not implement iAccessControl'
        );
    }
    
    function _requireHasRole(
        address target,
        bytes32 role,
        address account
    )internal view
    {
        hasRole(target, role, account).requireTrue(
            //"sender does not have role"
        );
    }
    function _requireNotHasRole(
        address target,
        bytes32 role,
        address account
    )internal view
    {
        hasRole(target, role, account).requireFalse(
            //"sender already has role"
        );
    }
    /**
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
    */
    //function _roleAt(
        //address target,
        //bytes32 role
    //)internal view returns(
        //bytes32
    //){
        //return _roleAt(target, role);
    //}
    /**
    modifier onlyDefaultAdmin(
    )internal view
    {
        _requireIsDefaultAdmin(_msgSender());
        _;
    }
    modifier onlyRole(
        bytes32 role
    )internal view
    {
        _requireHasRole(role, _msgSender());
        _;
    }
    modifier _requireNotHasRole(
        bytes32 role
    ){
        _requireNotHasRole(role, _msgSender());
    }
    modifier onlyAdminRole(
        bytes32 role
    ){
        _requireHasAdminRole(role, _msgSender());
        _;
    }
    modifier requireNotHasAdminRole(
        bytes32 role
    )internal view
    {
        _requireNotHasAdminRole(role, _msgSender());
        _;
    }
    */
    ///
    ///read-only/staticcall interface
    ///
    function roleDefaultAdmin(
        address target
    )internal view returns(
        bytes32 ret
    ){
        //target.requireSupportsInterfaceAccessControl();
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'ROLE_DEFAULT_ADMIN()'
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
        
        (ret) = abi.decode(result, (bytes32));
    }
    /// @return ret {bool} `true` if `account` has been granted `role`
    function hasRole(
        address target,
        bytes32 role,
        address account
    )internal view returns(
        bool ret
    ){
        //target.requireSupportsInterfaceAccessControl();
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                STUB_HAS_ROLE,
                role,
                account
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target,
                    _ERR_STR_ROLE,
                    role,
                    _ERR_STR_ACCOUNT,
                    account
                )
            )
        );
        
        //ret = result.decodeBool();
        (ret) = abi.decode(result, (bool));
    }
    ///
    /// @return ret {uint256} the number of accounts that have `role`,
    /// can be used together with {getRoleMember} to enumerate all bearers of a role
    ///
    function getRoleMemberCount(
        address target,
        bytes32 role
    )internal view returns(
        uint256 ret
    ){
        //target.requireSupportsInterfaceAccessControl();
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                STUB_GET_ROLE_MEMBER_COUNT,
                role
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target,
                    _ERR_STR_ROLE,
                    role
                )
            )
        );
        
        //ret = result.decodeUint256();
        (ret) = abi.decode(result, (uint256));
    }
    ///
    /// @return ret {address} one of the accounts that have `role`.
    /// `index` must be a value between 0 and {getRoleMemberCount}, non-inclusive
    /// Role bearers are not sorted in any particular way,
    /// and their ordering may change at any point
    ///
    /// WARNING:
    ///     When using {getRoleMember} and {getRoleMemberCount},
    ///     make sure you perform all queries on the same block
    ///
    ///     for more information see:
    ///         https://forum.openzeppelin.com/t/iterating-over-elements-on-enumerableset-in-openzeppelin-contracts/2296[forum post]
    ///
    function getRoleMember(
        address target,
        bytes32 role,
        uint256 index
    )internal view returns(
        address ret
    ){
        //target.requireSupportsInterfaceAccessControl();
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                STUB_GET_ROLE_MEMBER,
                role,
                index
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target,
                    _ERR_STR_ROLE,
                    role
                    //_ERR_STR_INDEX,
                    //index
                )
            )
        );
        
        //ret = result.decodeAddress();
        (ret) = abi.decode(result, (address));
    }
    ///
    /// @return ret {bytes32} admin role that controls `role`
    /// See {grantRole} and {revokeRole}
    /// To change a role's admin, use {_setRoleAdmin}
    ///
    function getRoleAdmin(
        address target,
        bytes32 role
    )internal view returns(
        bytes32 ret
    ){
        //target.requireSupportsInterfaceAccessControl();
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                STUB_GET_ROLE_ADMIN,
                role
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target,
                    _ERR_STR_ROLE,
                    role
                )
            )
        );
        
        (ret) = abi.decode(result, (bytes32));
    }
}

/*
library frameworkAccessControlMutable
{
    using frameworkAccessControlInterfaceSupport for address;
    
    using frameworkERC165 for address;
    
    using logicConstraints for bool;
    
    using addressConstraints for address;
    
    string private constant _NAME = 'frameworkAccessControlMutable: ';
    string private constant _ERR_STR_TARGET = ', target: ';
    string private constant _ERR_STR_ROLE = ', role: ';
    string private constant _ERR_STR_TO = ', to: ';
    
    string internal constant STUB_GRANT_ROLE = 'grantRole(bytes32,address)';
    string internal constant STUB_REVOKE_ROLE = 'revokeRole(bytes32,address)';
    string internal constant STUB_TRANSFER_ROLE = 'transferRole(bytes32,address,address)';
    
    bytes4 private constant _iACCESS_CONTROL_ID = type(iAccessControl).interfaceId;
    //bytes4 internal constant IID_ACCESS_CONTROL_MUTABLE = type(iAccessControlMutable).interfaceId;
    string private constant _ERR_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            '.call failed',
            _ERR_STR_TARGET
        )
    );
    ///
    /// @dev Grants `role` to `account`
    /// If `account` had not been already granted `role`, emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///
    function grantRole(
        address target,
        bytes32 role,
        address account
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                frameworkAccessControlMutable.STUB_GRANT_ROLE,
                role,
                account
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target,
                    _ERR_STR_ROLE,
                    role,
                    _ERR_STR_TO,
                    account
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
    function revokeRole(
        address target,
        bytes32 role,
        address account
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                frameworkAccessControlMutable.STUB_REVOKE_ROLE,
                role,
                account
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target,
                    _ERR_STR_ROLE,
                    role,
                    _ERR_STR_TO,
                    account
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
    function renounceRole(
        address target,
        bytes32 role,
        address account
    )internal
    {
        //account.requireEquals(
            //_msgSender()
            //"can only renounce roles for self"
        //);

        revokeRole(target, role, account);
    }
    
    function transferRole(
        address target,
        bytes32 role,
        address from,
        address to
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                frameworkAccessControlMutable.STUB_TRANSFER_ROLE,
                role,
                from,
                to
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target,
                    _ERR_STR_ROLE,
                    role,
                    //_ERR_STR_FROM,
                    //from,
                    _ERR_STR_TO,
                    to
                )
            )
        );
    }
}

library frameworkAccessControlDelegate
{
    //using frameworkAccessControlInterfaceSupport for address;
    
    using frameworkERC165 for address;
    
    using logicConstraints for bool;
    
    using addressConstraints for address;
    
    string private constant _NAME = 'frameworkAccessControlDelegate: ';
    string private constant _ERR_STR_DELEGATE = ', delegate: ';
    string private constant _ERR_STR_ROLE = ', role: ';
    string private constant _ERR_STR_TO = ', to: ';
    
    bytes4 private constant _iACCESS_CONTROL_ID = type(iAccessControl).interfaceId;
    //bytes4 internal constant IID_ACCESS_CONTROL_VIEW = type(iAccessControlView).interfaceId;
    //bytes4 internal constant IID_ACCESS_CONTROL_MUTABLE = type(iAccessControlMutable).interfaceId;
    string private constant _ERR_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            '.delegatecall failed',
            _ERR_STR_DELEGATE
        )
    );
    ///
    /// @dev Grants `role` to `account`
    /// If `account` had not been already granted `role`, emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///
    function grantRole(
        address target,
        bytes32 role,
        address account
    )internal
    {
        target.requireSupportsInterfaceAccessControl();
        
        (bool success, ) = target.delegatecall(
            abi.encodeWithSignature(
                frameworkAccessControlMutable.STUB_GRANT_ROLE,
                role,
                account
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target,
                    _ERR_STR_ROLE,
                    role,
                    _ERR_STR_TO,
                    account
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
    function revokeRole(
        address target,
        bytes32 role,
        address account
    )internal
    {
        target.requireSupportsInterfaceAccessControl();
        
        (bool success, ) = target.delegatecall(
            abi.encodeWithSignature(
                frameworkAccessControlMutable.STUB_REVOKE_ROLE,
                role,
                account
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target,
                    _ERR_STR_ROLE,
                    role,
                    _ERR_STR_TO,
                    account
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
    function renounceRole(
        address target,
        bytes32 role,
        address account
    )internal
    {
        //account.requireEquals(
            //_msgSender()
            //"can only renounce roles for self"
        //);

        revokeRole(target, role, account);
    }
    
    function transferRole(
        address target,
        bytes32 role,
        address from,
        address to
    )internal
    {
        target.requireSupportsInterfaceAccessControl();
        
        (bool success, ) = target.delegatecall(
            abi.encodeWithSignature(
                frameworkAccessControlMutable.STUB_TRANSFER_ROLE,
                role,
                from,
                to
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target,
                    _ERR_STR_ROLE,
                    role,
                    //_ERR_STR_FROM,
                    //from,
                    _ERR_STR_TO,
                    to
                )
            )
        );
    }
}
*/