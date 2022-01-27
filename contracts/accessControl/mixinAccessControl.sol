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
        bytes32 adminRole;
        
        EnumerableSet.AddressSet members;
    }
    
    //bytes32 public constant ROLE_DEFAULT_ADMIN = 0x00;
    bytes32 internal constant STORAGE_SLOT = keccak256("solidarity.access.control.storage.slot");
    
    struct AccessControlStorage{
        mapping(bytes32=>RoleData) roles;
    }
    
    function storageAccessControl(
        //bytes32 slot
    )internal pure returns(
        AccessControlStorage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
    //function roles(
        //bytes32 slot
    //)internal view returns(
        //mapping (bytes32=>RoleData) storage
    //){
        //return _storageAccessControl(slot).roles;
    //}
    //function roleAt(
        //bytes32 slot,
        //bytes32 key
    //)internal view returns(
        //RoleData storage
    //){
        //return roles(slot)[key];
    //}
    
    //function roleAdmin(
        //bytes32 slot,
        //bytes32 role
    //)internal view returns(
        //bytes32
    //){
        //return roleAt(slot, role).adminRole;
    //}
    
    //function has...
        //bytes32 slot,
        //bytes32 role
        //address account
    //)internal view returns(
        //bool
    //){
        //return hasRole(slot, roleAt(slot, role).adminRole, account);
    //}
    
    //function hasRole(
        //bytes32 slot,
        //bytes32 role
        //address account
    //)internal view returns(
        //bool
    //){
        //return hasRole(slot, role, account);
    //}
    //
    //get all role members
    //note this function is not reccommended for use
    //function roleMembers(
        //bytes32 slot,
        //bytes32 role
    //)internal view returns(
        //address[] memory
    //){
        //return roleAt(slot, role).members;
    //}
    //function sliceRoleMembers(
        //bytes32 slot,
        //bytes32 role
        //uint256 start,
        //uint256 endS
    //)internal view returns(
        //address[] memory ret
    //){
        //ret = new address[](...);
        //address[] M = roleAt(slot, role).members;
    //}
}