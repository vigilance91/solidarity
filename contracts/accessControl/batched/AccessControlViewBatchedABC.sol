// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/batched/iAccessControlBatched.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControlABC.sol";
///
/// @title Access Control Batched View Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 24/3/2022, All Rights Reserved
///
abstract contract AccessControlViewBatchedABC is AccessControlABC,    //AccessControlViewABC
    iAccessControlViewBatched
{
    using EnumerableSet for EnumerableSet.AddressSet;
    using Address for address;
    
    using eventsAccessControl for bytes32;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    
    //using mixinAccessControl for address;

    bytes4 internal constant _IID_ACCESS_CONTROL_VIEW_BATCHED = type(iAccessControlViewBatched).interfaceId;
    
    constructor(
    )internal
        AccessControlABC()
    {
        //_registerInterface(_IID_ACCESS_CONTROL_VIEW_BATCHED);
    }
    ///
    ///read-only interface
    ///
    /// @return result {bool} `true` if `account` has been granted `role`
    /// 
    /// Requirements:
    ///     -account can not be zero address
    ///
    function hasRoles(
        bytes32[] calldata roles,
        address[] calldata accounts
    )external view returns(
        bool[] memory result
    ){
        if(roles.length > 1 && accounts.length == 1){
            //account.requireNotNull();
            //return _roleAt(role).members.contains(account);
            address account = accounts[0];

            result = new bool[](roles.length);
            
            for(uint i; i < roles.length; i++){
                result[i] = _hasRole(roles[i], account);
            }
        }
        else if(roles.length == 1 && accounts.length > 1){
            //account.requireNotNull();
            //return _roleAt(role).members.contains(account);
            bytes32 role = roles[0];

            result = new bool[](accounts.length);

            for(uint i; i < accounts.length; i++){
                result[i] = _hasRole(role, accounts[i]);
            }
        }
        else if(roles.length == 1 && accounts.length == 1){
            result = new bool[](1);
            
            result[0] = _hasRole(roles[0], accounts[0]);
        }
        //else if(roles.length > 1 && accounts.length > 1){
            //result = new bool[](RL.mul(AL));
            //bytes32 role;

            //for(uint i; i < role.length; i++){
                //role = roles[i];
                
                //for(uint i; i < accounts.length; j++){
                    //result[i] = _hasRole(role, accounts[j]);
                //}
            //}
        //}
        //else{
            //logicConstraints.alwaysRevert('invalid arguments');
        //}
    }
    ///
    /// @return result {bool} `true` if `account` has been granted `role`
    /// 
    /// Requirements:
    ///     -account can not be zero address
    ///
    function hasRoles(
        bytes32[] calldata roles,
        address account
    )external view override returns(
        bool[] memory result
    ){
        //account.requireNotNull();
        //return _roleAt(role).members.contains(account);
        result = new bool[](roles.length);
        
        for(uint256 i; i < roles.length; i++){
            result[i] = _hasRole(roles[i], account);
        }
    }
    ///
    /// @return result {bool} `true` if `account` has been granted `role`
    /// 
    /// Requirements:
    ///     -account can not be zero address
    ///
    function hasRole(
        bytes32 role,
        address[] calldata accounts
    )external view override returns(
        bool[] memory result
    ){
        //account.requireNotNull();
        //return _roleAt(role).members.contains(account);
        result = new bool[](accounts.length);
        
        for(uint256 i; i < accounts.length; i++){
            result[i] = _hasRole(role, accounts[i]);
        }
    }
    ///
    /// @return result {bool[]} `true` for each role in `roles` if AddressLogic.NULL has been granted that role, otherwise `false`
    ///
    function hasRolesAll(
        bytes32[] calldata roles
    )external view override returns(
        bool[] memory result
    ){
        result = new bool[](roles.length);
        
        for(uint256 i; i < roles.length; i++){
            result[i] = _hasRoleAll(roles[i]);
        }
    }
    ///
    /// @return result {bytes32[]} admin role for each role in `roles`
    ///
    function getRoleAdmin(
        bytes32[] calldata roles
    )external view override returns(
        bytes32[] memory result
    ){
        result = new bytes32[](roles.length);
        bytes32 role;

        for(uint256 i; i < roles.length; i++){
            role = roles[i];

            result[i] = _roleAt(role).adminRole;
        }
    }
    ///
    /// @return result {uint256[]} the number of accounts assigned each role in `roles`,
    ///
    function getRoleMemberCount(
        bytes32[] calldata roles
    )external view override returns(
        uint256[] memory result
    ){
        result = new uint256[](roles.length);
        
        for(uint256 i; i < roles.length; i++){
            result[i] = _roleAt(roles[i]).members.length();
        }
    }
}