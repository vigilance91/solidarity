// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/ReentrancyGuard.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControl.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControlMutableABC.sol";
///
/// @title External Access Control Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 11/3/2022, All Rights Reserved
/// @dev external implementation for use with proxies.
///
contract ExternalAccessControlImplementation is ERC165,
    ReentrancyGuard,
    AccessControlMutableABC,
    iAccessControlMutable
{
    constructor(
    )public
        //NonreentrantERC165Context()
        ERC165()
        ReentrancyGuard()
        AccessControlMutableABC()
    {
        _registerInterface(type(iAccessControlMutable).interfaceId);
        //_registerInterface(type(iERC165).interfaceId ^ type(iAccessControlMutable).interfaceId);
    }
    ///
    /// @dev Grants `role` to `account`
    /// emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has previously been granted `role`
    ///
    function grantRole(
        bytes32 role,
        address account
    )external virtual override nonReentrant
        //onlyDefaultAdminOrRoleAdmin
    {
        _requireHasAdminRole(role, _msgSender());
        
        _grantRole(role, account);
    }
    ///
    /// @dev Revokes `role` from `account`
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has not previously been granted `role`
    ///
    function revokeRole(
        bytes32 role,
        address account
    )external virtual override nonReentrant
    {
        _requireHasAdminRole(role, _msgSender());
        
        _revokeRole(role, account);
    }
    ///
    /// @dev Revokes `role` from the calling account
    /// Roles are often managed via {grantRole} and {revokeRole},
    /// this function's provides a mechanism for accounts to lose their privileges
    /// if they are compromised (such as when a trusted device is misplaced)
    /// Emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must be `account`
    ///     - caller must have been previously granted Role, otherwise revert
    ///
    function renounceRole(
        bytes32 role
    )external virtual override nonReentrant
    {
        //account.requireEqual(
            //_msgSender()
            //"can only renounce roles for self"
        //);

        _revokeRole(role, _msgSender());
    }
    ///
    /// @dev Admin forces transfer of `role` from address `from` to address `to`
    /// emits a {RoleRevoked} event for `from` and {RoleGranted} event for `to`
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role or be default admin
    ///     - `from` must not be null and currently have the role `role`
    ///     - `to` must not be null and not have been assigned the role `role`
    ///
    /// NOTE:
    ///     Be careful, default admin role can be transfered (only with the privallegaes it provides),
    ///     this is useful along with transfering ownership via ERC173
    ///     however, if default admin role is transfered, this will immediately prevent any further admin operations,
    ///     thus it should be the last role transfered, if at all
    ///
    function transferRole(
        bytes32 role,
        address from,
        address to
    )external virtual override nonReentrant
        //onlyDefaultAdminOrRoleAdmin(role)
    {
        _requireHasAdminRole(role, _msgSender());
        
        _transferRole(role, from, to);
    }
}
///
/// @title Batched External Access Control Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 11/3/2022, All Rights Reserved
/// @dev external implementation for use with proxies which performs batched operations.
///
contract ExternalAccessControlBatchedImplementation is ExternalAccessControlImplementation
    //iAccessControlMutableBatched
{
    using EnumerableSet for EnumerableSet.AddressSet;
    using Address for address;
    
    using eventsAccessControl for bytes32;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    
    constructor(
    )public
        ExternalAccessControlImplementation()
    {
        //_registerInterface(type(iAccessControlBatched).interfaceId);
        //_registerInterface(type(iERC165).interfaceId ^ type(iAccessControlBatched).interfaceId);
    }
    ///
    /// @dev Grants `role` to each account in `accounts`
    /// emits multiple {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role or be default admin
    ///     - reverts if an account in `account` has previously been granted `role`
    ///
    function grantRole(
        bytes32 role,
        address[] calldata accounts
    )external virtual override nonReentrant
        //onlyDefaultAdminOrRoleAdmin
    {
        _requireHasAdminRole(role, _msgSender());
        
        for(uint i; i < accounts.length; i++){
            _grantRole(role, accounts[i]);
       }
    }
    ///
    /// @dev Grants `role` to each account in `accounts`
    /// emits multiple {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role or be default admin
    ///     - reverts if an account in `account` has previously been granted `role`
    ///
    function grantRole(
        bytes32[] calldata roles,
        address account
    )external virtual override nonReentrant
        //onlyDefaultAdminOrRoleAdmin
    {
        bytes32 role;
        address sender = _msgSender();
        
        for(uint i; i < roles.length; i++){
            role = roles[i];
            
            _requireHasAdminRole(role, sender);
            
            _grantRole(role, accounts[i]);
        }
    }
    ///
    /// @dev Revokes `role` from `account`
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has not previously been granted `role`
    ///
    function revokeRole(
        bytes32 role,
        address[] calldata accounts
    )public virtual override
    {
        _requireHasAdminRole(role, _msgSender());
        
        for(uint i; i < accounts.length; i++){
            _revokeRole(role, accounts[i]);
        }
    }
    ///
    /// @dev Revokes each `role` in `roles` from `account`
    /// emits a {RoleRevoked} event for each role removed
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has not previously been granted `role`
    ///
    function revokeRole(
        bytes32[] memory role,
        address account
    )external virtual override
    {
        bytes32 role;
        address sender = _msgSender();
        //
        for(uint i; i < roles.length; i++){
            role = roles[i];
            
            _requireHasAdminRole(role, sender);
            
            _revokeRole(role, account);
        }
    }
    ///
    /// @dev Revokes `role` from the calling account
    /// Roles are often managed via {grantRole} and {revokeRole},
    /// this function's provides a mechanism for accounts to lose their privileges
    /// if they are compromised (such as when a trusted device is misplaced)
    /// Emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must be `account`
    ///     - caller must have been previously granted Role, otherwise revert
    ///
    function renounceRoles(
        bytes32[] calldata role
    )external virtual override
    {
        //account.requireEqual(
            //_msgSender()
            //"can only renounce roles for self"
        //);
        address sender = _msgSender();
        
        for(uint i; i < accounts.length; i++){
            _revokeRole(roles[i], sender);
        }
    }
}