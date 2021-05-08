// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableSet.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/eventsAccessControl.sol";
///
/// @title Mixin Access Control Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev mixin for role-based access control mechanisms
///
library mixinAccessControl
{
    struct RoleData {
        EnumerableSet.AddressSet members;
        bytes32 adminRole;
    }
    
    struct AccessControlStorage{
        mapping (bytes32=>RoleData) roles;
    }
    //bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;
    bytes32 internal constant STORAGE_SLOT = keccak256("solidarity.access.control.storage.slot");
    
    function storageAccessControl(
    )internal pure returns(
        AccessControlStorage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
    //function roles(
    //)internal view returns(
        //mapping (bytes32=>RoleData) storage
    //){
        //return storageAccessControl().roles;
    //}
    //function roleAt(
        //bytes32 key
    //)internal view returns(
        //RoleData storage
    //){
        //return roles()[key];
    //}
}