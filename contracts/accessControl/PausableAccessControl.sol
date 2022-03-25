// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControl.sol";
import "https://github.com/vigilance91/solidarity/contracts/Pausable.sol";

//import "https://github.com/vigilance91/solidarity/contracts/accessConstrol/iPausableAccessControl.sol";

//interface iPausableAccessControl is iAccessControl,
//    iPausable
//{
//}

///
/// @title Pausable Access Control
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 22/4/2021, All Rights Reserved
///
abstract contract PausableAccessControl is AccessControl,
    Pausable
    //iPausableAccessControl
{
    //string private constant _NAME = ' PausableAccessControl: ';
    
    bytes32 public constant ROLE_PAUSER = keccak256("solidarity.accessControl.PausableAccessControl.ROLE_PAUSER");
    
    constructor(
    )internal 
        AccessControl()
        Pausable()
    {
        //
        //set pause role admin to default admin
        _setRoleAdmin(ROLE_PAUSER, ROLE_DEFAULT_ADMIN);
        //
        _setupRole(ROLE_PAUSER, _msgSender());
        //
        //allow contract to pause/unpause itself
        //_setupRole(ROLE_PAUSER, address(this));
    }
    ///
    /// @dev Pauses Contract
    ///
    /// Requirements:
    ///     - the caller must have `ROLE_PAUSER`
    ///
    function pause(
    )public virtual
    {
        address sender = _msgSender();
        
        _requireHasRole(ROLE_PAUSER, sender);
        
        _pause(sender);
    }
    ///
    /// @dev Unpauses Contract
    ///
    /// Requirements:
    ///     - the caller must have `ROLE_PAUSER`
    ///
    function unpause(
    )public virtual
    {
        address sender = _msgSender();
        
        _requireHasRole(ROLE_PAUSER, sender);
        
        _unpause(sender);
    }
    function _hasRolePauser(
        address account
    )internal view returns(
        bool
    ){
        return _hasRole(ROLE_PAUSER, account);
    }
    //
    //access control interface overrides
    //
    ///
    /// @dev Grants `role` to `account`
    /// emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - this contract cannot be paused
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has previously been granted `role`
    ///
    function grantRole(
        bytes32 role,
        address account
    )public virtual override
        //onlyDefaultAdminOrRoleAdmin
    {
        _requireNotPaused();
        _requireHasAdminRole(role, _msgSender());
        
        _grantRole(role, account);
    }
    ///
    /// @dev Grants `role` to each account in `accounts`
    /// emits multiple {RoleGranted} event
    ///
    /// Requirements:
    ///     - this contract cannot be paused
    ///     - the caller must have `role`'s admin role or be default admin
    ///     - reverts if an account in `account` has previously been granted `role`
    ///
    function grantRole(
        bytes32 role,
        address[] memory accounts
    )public virtual override
        //onlyDefaultAdminOrRoleAdmin
    {
        _requireNotPaused();
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
    ///     - this contract cannot be paused
    ///     - the caller must admin role for each role in `roles` or be default admin
    ///     - reverts if an account in `account` has previously been granted `role`
    ///
    function grantRole(
        bytes32[] calldata roles,
        address account
    )external virtual override
        //onlyDefaultAdminOrRoleAdmin
    {
        _requireNotPaused();
        
        address sender =_msgSender();
        
        bytes32 role;
        
        for(uint i; i < roles.length; i++){
            role = roles[i];
            
            _requireHasAdminRole(role, sender);
            
            _grantRole(role, account);
        }
    }
    ///
    /// @dev Revokes `role` from `account`
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - this contract cannot be paused
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has not previously been granted `role`
    ///
    function revokeRole(
        bytes32 role,
        address account
    )public virtual override
    {
        _requireNotPaused();
        _requireHasAdminRole(role, _msgSender());
        
        _revokeRole(role, account);
    }
    ///
    /// @dev Revokes `role` from `account`
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - this contract cannot be paused
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has not previously been granted `role`
    ///
    function revokeRole(
        bytes32 role,
        address[] memory accounts
    )public virtual override
    {
        _requireNotPaused();
        _requireHasAdminRole(role, _msgSender());
        
        for(uint i; i < accounts.length; i++){
            _revokeRole(role, accounts[i]);
        }
    }
    ///
    /// @dev Revokes `role` from `account`
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - this contract cannot be paused
    ///     - the caller must have admin role for each role in `roles` or be default admin
    ///     - reverts if `account` has not previously been granted `role`
    ///
    function revokeRole(
        bytes32[] calldata roles,
        address account
    )external virtual override
    {
        _requireNotPaused();
        
        address sender =_msgSender();
        
        for(uint i; i < accounts.length; i++){
            _requireHasAdminRole(roles, sender);
            _revokeRole(role, accounts[i]);
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
    ///     - this contract cannot be paused
    ///     - caller must have been previously granted Role, otherwise revert
    ///
    function renounceRole(
        bytes32 role
    )public virtual override
    {
        _requireNotPaused();
        //account.requireEqual(
            //_msgSender()
            //"can only renounce roles for self"
        //);

        _revokeRole(role, _msgSender());
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
        bytes32[] calldata roles
        //address account
    )external virtual override
    {
        _requireNotPaused();
        //account.requireEqual(
            //_msgSender()
            //"can only renounce roles for self"
        //);
        
        address sender = _msgSender();
        
        bytes32 role;
        
        for(uint i; i < roles.length; i++){
            role = roles[i];
            
            _revokeRole(role, sender);
    }
    ///
    /// @dev Admin forces transfer of `role` from address `from` to address `to`
    /// emits a {RoleRevoked} event for `from` and {RoleGranted} event for `to`
    ///
    /// Requirements:
    ///     - this contract cannot be paused
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
    )public virtual override
        //onlyDefaultAdminOrRoleAdmin(role)
    {
        _requireNotPaused();
        _requireHasAdminRole(role, _msgSender());
        
        _transferRole(role, from, to);
    }
}