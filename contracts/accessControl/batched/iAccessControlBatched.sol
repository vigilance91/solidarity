// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControl.sol";

interface iAccessControlBatchedView
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
    function hasRolesAll(
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
/// @title Full Access Control View Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev batched and non-batched view interface for role-based access control mechanisms
///
interface iAccessControlFullView is iAccessControlView,
    iAccessControlBatchedView
{
}
///
///mutable interface
///
interface iAccessControlBatchedMutable
{
    /// @dev grant all accounts each role in `roles`
    function grantRolesAll(
        bytes32[] calldata roles
    )external;

    function grantRoles(
        bytes32[] calldata roles,
        address[] calldata accounts
    )external;
    /*
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
    */
    /*
    /// @dev revoke role `role` from each address in `accounts`
    function revokeRole(
        bytes32 role,
        address[] calldata accounts
    )external;
    
    /// @dev revoke multiple roles to a single address
    function revokeRoles(
        bytes32[] calldata roles,
        address account
    )external;
    */
    /// @dev revoke each role in `roles` from all accounts
    function revokeRolesAll(
        bytes32[] calldata roles
    )external;
    /// @dev revoke each role in `roles` from all accounts
    function revokeRoles(
        bytes32[] calldata roles,
        address[] calldata accounts
    )external;

    /// @dev caller renounces each role in `roles`
    function renounceRoles(
        bytes32[] calldata roles
    )external;
    
    /// @dev transfer role `role` from each address in `from` to the corresponding address in `to`
    //function transferRole(
        //bytes32 role,
        //address[] calldata from,
        //address[] calldata to
    //)external;
    
    /// @dev transfer multiple roles from address `from` to address `to`
    function transferRoles(
        bytes32[] calldata roles,
        address from,
        address to
    )external;
}
///
/// @title Full Access Control View Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev batched and non-batched view interface for role-based access control mechanisms
///
interface iAccessControlBatched is iAccessControlBatchedView,
    iAccessControlBatchedMutable
{
}
///
/// @title Full Access Control Mutable Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev batched and non-batched mutable interface for role-based access control mechanisms
///
interface iAccessControlFullMutable is iAccessControlMutable,
    iAccessControlBatchedMutable
{
}
///
/// @title Access Control Batched Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev internface for role-based access control mechanisms
///
interface iAccessControlFull is iAccessControlFullView,
    iAccessControlFullMutable
{
}