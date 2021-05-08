// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Access Control Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev internface for role-based access control mechanisms
///
interface iAccessControl
{
    ///
    ///read-only interface
    ///
    function hasRole(
        bytes32 role,
        address account
    )external view returns(
        bool
    );
    
    function getRoleMemberCount(
        bytes32 role
    )external view returns(
        uint256
    );
    
    function getRoleMember(
        bytes32 role,
        uint256 index
    )external view returns(
        address
    );
    
    function getRoleAdmin(
        bytes32 role
    )external view returns(
        bytes32
    );
    ///
    ///mutable interface
    ///
    function grantRole(
        bytes32 role,
        address account
    )external;
    
    function revokeRole(
        bytes32 role,
        address account
    )external;
    
    function renounceRole(
        bytes32 role,
        address account
    )external;
    
    function transferRole(
        bytes32 role,
        address from,
        address to
    )external;
}