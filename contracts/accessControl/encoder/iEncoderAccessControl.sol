// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Access Control Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 9/12/2021, All Rights Reserved
/// @dev deployment cost: 586,593 gas
///
///read-only interface
///
interface iEncoderAccessControlView
{
    function hasRole(
        bytes32 role,
        address account
    )external pure returns(
        bytes memory
    );
    
    function getRoleMemberCount(
        bytes32 role
    )external pure returns(
        bytes memory
    );
    
    function getRoleMember(
        bytes32 role,
        uint256 index
    )external pure returns(
        bytes memory
    );

    //function sliceRoleMembers(
        //bytes32 role,
        //uint256 start,
        //uint256 end
    //)external pure returns(
        //bytes memory
    //);
    
    function getRoleAdmin(
        bytes32 role
    )external pure returns(
        bytes memory
    );
}
///
///mutable interface
///
interface iEncoderAccessControlMutable
{
    function grantRole(
        bytes32 role,
        address account
    )external pure returns(
        bytes memory
    );
    
    function revokeRole(
        bytes32 role,
        address account
    )external pure returns(
        bytes memory
    );
    
    function renounceRole(
        bytes32 role
    )external pure returns(
        bytes memory
    );
    
    function transferRole(
        bytes32 role,
        address from,
        address to
    )external pure returns(
        bytes memory
    );
}

interface iEncoderAccessControl is iEncoderAccessControlView,
    iEncoderAccessControlMutable
{
}