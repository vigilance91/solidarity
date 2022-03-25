// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Access Control View Transaction ABI Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 15/3/2021, All Rights Reserved
/// @dev convenience library for creating encoded signatures for low-level address call operations
///
library abiEncoderAccessControlView
{
    string internal constant STUB_HAS_ROLE = 'hasRole(bytes32,address)';
    string internal constant STUB_HAS_ROLE_ALL = 'hasRole(bytes32)';
    //
    string internal constant STUB_GET_ROLE_MEMBER_COUNT = 'getRoleMemberCount(bytes32)';
    string internal constant STUB_GET_ROLE_MEMBER = 'getRoleMember(bytes32,uint256)';
    //
    string internal constant STUB_GET_ROLE_ADMIN = 'getRoleAdmin(bytes32)';
    
    function hasRole(
        bytes32 role,
        address account
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_HAS_ROLE,
            role,
            account
        );
    }
    
    //function hasRoleAll(
        //bytes32 role
    //)internal pure returns(
        //bytes memory
    //){
        //return abi.encodeWithSignature(
            //STUB_HAS_ROLE_ALL,
            //role
        //);
    //}
    
    function getRoleMemberCount(
        bytes32 role
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_GET_ROLE_MEMBER_COUNT,
            role
        );
    }
    
    function getRoleMember(
        bytes32 role,
        uint256 index
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_GET_ROLE_MEMBER,
            role,
            index
        );
    }

    //function sliceRoleMembers(
        //bytes32 role,
        //uint256 start,
        //uint256 end
    //)internal pure returns(
        //bytes memory
    //){
        //return abi.encodeWithSignature(
            //STUB_SLICE_ROLE_MEMBERS,
            //role,
            //start,
            //end
        //);
    //}
    
    function getRoleAdmin(
        bytes32 role
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_GET_ROLE_ADMIN,
            role
        );
    }
}