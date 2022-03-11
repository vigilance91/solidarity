// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControl.sol";

interface iAccessControlViewBatched is iAccessControlView
{
    function hasRole(
        bytes32 role,
        address[] calldata accounts
    )external view returns(
        bool[] memory
    );
    
    function hasRoles(
        bytes32[] calldata role,
        address accounts
    )external view returns(
        bool[] memory
    );
    function hasRoleAll(
        bytes32[] calldata roles
    )external view returns(
        bool[] memory
    );
    
    function getRoleAdmin(
        bytes32[] calldata roles
    )external view returns(
        bytes32[] memory
    );
    
    function getRoleMemberCount(
        bytes32[] calldata roles
    )external view returns(
        uint256[] memory
    );
}
///
///mutable interface
///
interface iAccessControlMutableBatched is iAccessControlMutable
{
    /// @dev grant role `role` to each address in `accounts`
    function grantRole(
        bytes32 role,
        address[] calldata accounts
    )external;
    
    /// @dev grant multiple roles to a single address
    function grantRoles(
        bytes32[] calldata roles,
        address account
    )external;
    
    /// @dev grant all accounts each role in `roles`
    function grantRolesAll(
        bytes32[] calldata roles
    )external;
    
    
    /// @dev for each `role` in `roles` revoke each from address `account`
    function revokeRoles(
        bytes32[] calldata role,
        address account
    )external;
    
    /// @dev revoke role `role` from each address in `accounts`
    function revokeRole(
        bytes32 role,
        address[] calldata accounts
    )external;
    
    /// @dev revoke multiple roles to a single address
    function revokeRoles(
        bytes32[] calldata role,
        address account
    )external;
    
    /// @dev revoke each role in `roles` from all accounts
    function revokeRolesAll(
        bytes32[] calldata roles
    )external;
    
    /// @dev transfer role `role` from each address in `from` to the corresponding address in `to`
    //function transferRole(
        //bytes32 role,
        //address[] calldata from,
        //address[] calldata to
    //)external;
    
    /// @dev transfer multiple roles from address `from` to address `to`
    //function transferRole(
        //bytes32[] calldata roles,
        //address from,
        //address to
    //)external;
}
///
/// @title Access Control Batched Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev internface for role-based access control mechanisms
///
interface iAccessControlBatched is iAccessControlViewBatched,
    iAccessControlMutableBatched
{
}