// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/ReentrancyGuard.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControl.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControlMutableABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/iERC165.sol";
import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title External Access Control Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 11/3/2022, All Rights Reserved
/// @dev external implementation for use with proxies,
/// storage is not initialized, since this is a implementation contract its storage gets initialized in the proxy, not here.
/// deploy cost: 964,774 
///
contract AccessControlExternalImplementation is ERC165,
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
        _registerInterface(type(iERC165).interfaceId ^ type(iAccessControlMutable).interfaceId);
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
    /// @dev Grants `role` to all accounts
    /// emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if the null address has previously been granted `role`
    ///
    function grantRoleAll(
        bytes32 role
    )external virtual override nonReentrant
        //onlyDefaultAdminOrRoleAdmin
    {
        _requireHasAdminRole(role, _msgSender());
        
        _grantRole(role, addressLogic.NULL);
    }
    ///
    /// @dev Revokes `role` from `account`
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has previously been granted `role`
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
    /// @dev Revokes `role` from all accounts
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if the null address has not previously been granted `role`
    ///
    function revokeRoleAll(
        bytes32 role
    )external virtual override nonReentrant
    {
        _requireHasAdminRole(role, _msgSender());
        
        _revokeRole(role, addressLogic.NULL);
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