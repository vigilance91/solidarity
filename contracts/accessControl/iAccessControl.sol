// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
///read-only interface
///
interface iAccessControlView
{
    function hasRole(
        bytes32 role,
        address account
    )external view returns(
        bool
    );
    
    function hasRoleAll(
        bytes32 role
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

    //function sliceRoleMembers(
        //bytes32 role,
        //uint256 start,
        //uint256 end
    //)external view returns(
        //address[] memory
    //);
    
    function getRoleAdmin(
        bytes32 role
    )external view returns(
        bytes32
    );
}
///
///mutable interface
///
interface iAccessControlMutable
{
    function grantRole(
        bytes32 role,
        address account
    )external;
    
    function grantRoleAll(
        bytes32 role
    )external;
    
    function revokeRole(
        bytes32 role,
        address account
    )external;
    
    function revokeRoleAll(
        bytes32 role
    )external;
    
    function renounceRole(
        bytes32 role
    )external;
    
    function transferRole(
        bytes32 role,
        address from,
        address to
    )external;
}
///
/// @title Access Control Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev internface for role-based access control mechanisms
///
/*
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
    
    function hasRole(
        bytes32 role,
        address[] calldata account
    )external view returns(
        bool[] memory
    );
    
    function hasRoleAll(
        bytes32 role
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

    //function sliceRoleMembers(
        //bytes32 role,
        //uint256 start,
        //uint256 end
    //)external view returns(
        //address[] memory
    //);
    
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
        bytes32 role
    )external;
    
    function transferRole(
        bytes32 role,
        address from,
        address to
    )external;
    //
    //batched mutable interface
    //
    function grantRole(
        bytes32 role,
        address[] memory account
    )external;
    
    function revokeRole(
        bytes32 role,
        address[] memory account
    )external;
    
    //function transferRole(
        //bytes32 role,
        //address[] memory from,
        //address[] memory to
    //)external;
}
*/
interface iAccessControl is iAccessControlView,
    iAccessControlMutable
{
}