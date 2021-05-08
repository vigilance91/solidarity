// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Access Control Events Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev events and emitter functions associated with role based access control mechanisms
///
library eventsAccessControl
{
    ///
    /// @dev Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`
    ///
    /// `DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
    /// {RoleAdminChanged} not being emitted signaling this.
    ///
    ///
    event RoleAdminChanged(
        bytes32 role,
        bytes32 previousAdminRole,
        bytes32 newAdminRole
    );
    ///
    /// @dev Emitted when `account` is granted `role` by `sender`
    /// `sender` is the Admin that originated the contract call,
    /// except when using {_setupRole}
    ///
    event RoleGranted(
        bytes32 role,
        address account,
        address sender
    );
    ///
    /// @dev Emitted when `account` is revoked `role`
    /// `sender` is the account initiating the call:
    ///   - if using `revokeRole`, it is the admin role bearer
    ///   - if using `renounceRole`, it is the role bearer (i.e. `account`)
    ///
    event RoleRevoked(
        bytes32 role,
        address account,
        address sender
    );
    /// @dev Emitted when `account`'s admin role is changed to `newAdminRole`
    function emitRoleAdminChanged(
        bytes32 role,
        bytes32 previousAdminRole,
        bytes32 newAdminRole
    )internal
    {
        emit RoleAdminChanged(
            role,
            previousAdminRole,
            newAdminRole
        );
    }
    /// @dev Emitted when `account`'s is granted role `role` by `sender`
    function emitRoleGranted(
        bytes32 role,
        address account,
        address sender
    )internal
    {
        emit RoleGranted(
            role,
            account,
            sender
        );
    }
    /// @dev Emitted when `account`'s role `role` is revoked by `sender`
    function emitRoleRevoked(
        bytes32 role,
        address account,
        address sender
    )internal
    {
        emit RoleRevoked(
            role,
            account,
            sender
        );
    }
}