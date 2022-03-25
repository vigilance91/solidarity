// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/batched/iAccessControlBatched.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/batched/AccessControlViewBatchedABC.sol";
///
/// @title Access Control Batched
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev batched role-based access control mechanisms
///
abstract contract AccessControlBatched is AccessControlViewBatchedABC,    //AccessControlMutableABC,
    iAccessControlBatched
{
    using EnumerableSet for EnumerableSet.AddressSet;
    using Address for address;
    
    using eventsAccessControl for bytes32;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    
    //using mixinAccessControl for address;

    //bytes32 private constant _STORAGE_SLOT = keccak256();
    //bytes4 internal constant _IID_ACCESS_CONTROL_MUTABLE_BATCHED = type(iAccessControlMutableBatched).interfaceId;
    //bytes4 internal constant _IID_ACCESS_CONTROL_BATCHED = type(iAccessControlBatched).interfaceId;
    
    constructor(
    )internal
        AccessControlViewBatchedABC()
    {
        //assert(_IID_ACCESS_CONTROL_VIEW_BATCHED ^ _IID_ACCESS_CONTROL_MUTABLE_BATCHED == _IID_ACCESS_CONTROL_BATCHED);
        
        //_registerInterface(_IID_ACCESS_CONTROL_MUTABLE_BATCHED);
        //_registerInterface(_IID_ACCESS_CONTROL_BATCHED);
    }
    ///
    /// @dev Grants each role in `roles` to all accounts
    /// emits multiple {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role or be default admin
    ///     - reverts if any has previously been granted any role in `roles`
    ///
    function grantRolesAll(
        bytes32[] calldata roles
    )external virtual override
        //onlyDefaultAdminOrRoleAdmin
    {
        address sender = _msgSender();
        
        bytes32 role;
        
        for(uint i; i < roles.length; i++){
            role = roles[i];
            
            _requireHasAdminRole(role, sender);
        
            //_grantRoleAll(role);
        }
    }
    ///
    /// @dev Grant each role in `roles` to each account in `accounts`
    /// emits a {RoleGranted} event for each role granted to each account
    ///
    /// Requirements:
    ///     - this contract cannot be paused
    ///     - roles and accounts must have non-zero length
    ///     - the caller must have admin role for each role in `roles` or be default admin
    ///     - reverts if an account in `accounts` has been previously granted role
    ///
    function grantRoles(
        bytes32[] calldata roles,
        address[] calldata accounts
    )external virtual override
    {
        address sender = _msgSender();
        uint RL = roles.length;
        uint AL = accounts.length;
        bytes32 role;

        require(
            RL > 0 && AL > 0,
            string(
                abi.encodePacked(
                    'invalid argument, roles: ',
                    roles,
                    ', accounts: ',
                    accounts
                )
            )
        );

        if(RL == 1 && AL > 1){
            role = roles[0];

            _requireHasAdminRole(role, sender);
            
            for(uint i; i < AL; i++){
                _grantRole(role, accounts[i]);
            }
        }
        else if(RL > 1 && AL == 1){
            address account = accounts[0];

            for(uint i; i < RL; i++){
                role = roles[i];
                
                _requireHasAdminRole(role, sender);
                
                _grantRole(role, account);
            }
        }
        else if(RL == 1 && AL == 1){
            role = roles[0];

            _requireHasAdminRole(role, sender);
            
            _grantRole(role, accounts[0]);
        }
        else if(RL > 1 && AL > 1){
            for(uint i; i < RL; i++){
                role = roles[i];
                
                _requireHasAdminRole(role, sender);
                
                for(uint j; j < AL; j++){
                    _grantRole(role, accounts[j]);
                }
            }
        }
        //else{
            //logicConstraints.alwaysRevert('invalid arguments');
        //}
    }
    ///
    /// @dev Revoke each role in `roles` from each account in `accounts`
    /// emits a {RoleRevoked} event for each role revoked from each account
    /// 
    /// Requirements:
    ///     - this contract cannot be paused
    ///     - roles and accounts must have non-zero length
    ///     - the caller must have admin role for each role in `roles` or be default admin
    ///     - reverts if `account` has not previously been granted `role`
    ///
    function revokeRoles(
        bytes32[] calldata roles,
        address[] calldata accounts
    )external virtual override
    {
        address sender = _msgSender();
        uint RL = roles.length;
        uint AL = accounts.length;
        bytes32 role;

        require(
            RL > 0 && AL > 0,
            string(
                abi.encodePacked(
                    'invalid argument, roles: ',
                    roles,
                    ', accounts: ',
                    accounts
                )
            )
        );

        if(RL == 1 && AL > 1){
            role = roles[0];

            _requireHasAdminRole(role, sender);
            
            for(uint i; i < AL; i++){
                _revokeRole(role, accounts[i]);
            }
        }
        else if(RL > 1 && AL == 1){
            address account = accounts[0];

            for(uint i; i < RL; i++){
                role = roles[i];
                
                _requireHasAdminRole(role, sender);
                
                _revokeRole(role, account);
            }
        }
        else if(RL == 1 && AL == 1){
            role = roles[0];

            _requireHasAdminRole(role, sender);
            
            _revokeRole(role, accounts[0]);
        }
        else if(RL > 1 && AL > 1){
            for(uint i; i < RL; i++){
                role = roles[i];
                
                _requireHasAdminRole(role, sender);
                
                for(uint j; j < AL; j++){
                    _revokeRole(role, accounts[j]);
                }
            }
        }
        //else{
            //logicConstraints.alwaysRevert('invalid arguments');
        //}
    }
    ///
    /// @dev Revoke each role in `roles` from all accounts
    /// emits multiple {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role or be default admin
    ///     - reverts if all has not been previously granted each role in `roles`
    ///
    function revokeRolesAll(
        bytes32[] calldata roles
    )external virtual override
        //onlyDefaultAdminOrRoleAdmin
    {
        address sender = _msgSender();
        
        bytes32 role;
        
        for(uint i; i < roles.length; i++){
            role = roles[i];
            
            _requireHasAdminRole(role, sender);
        
            //_revokeRoleAll(role);
        }
    }
    ///
    /// @dev Revokes `role` from the calling account
    /// Roles are often managed via {grantRole} and {revokeRole},
    /// this function's provides a mechanism for accounts to lose their privileges
    /// if they are compromised (such as when a trusted device is misplaced)
    /// Emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must be `account`
    ///     - caller must have been previously granted Role, otherwise revert
    ///
    function renounceRoles(
        bytes32[] calldata roles
        //address account
    )external virtual override
    {
        //account.requireEqual(
            //_msgSender()
            //"can only renounce roles for self"
        //);
        
        address sender = _msgSender();
        
        for(uint i; i < roles.length; i++){
            //role = roles[i];
            
            _revokeRole(roles[i], sender);
        }
    }
    ///
    /// @dev Admin forces transfer of each role in `roles` from address `from` to address `to`
    /// emits a {RoleRevoked} event for `from` and {RoleGranted} event for `to`
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role or be default admin
    ///     - `from` must not be null and currently have the role `role`
    ///     - `to` must not be null and not have been assigned the role `role`
    /// 
    function transferRoles(
        bytes32[] calldata roles,
        address from,
        address to
    )public virtual override
        //onlyDefaultAdminOrRoleAdmin(role)
    {
        address sender = _msgSender();
        
        bytes32 role;
        
        for(uint i; i < roles.length; i++){
            role = roles[i];
            
            _requireHasAdminRole(role, sender);
        
            _transferRole(role, from, to);
        }
    }
    /// 
    /// @dev caller transfers their role `role` to address `to`
    /// emits a {RoleRevoked} event for `from` and {RoleGranted} event for `to`
    /// 
    /// Requirements:
    ///     - the caller must have role `role`, `role`'s admin or default admin
    ///     - `to` must not be null and not have been assigned the role `role`
    ///
    //function callerTransferRole(
        //bytes32 role,
        //address to
    //)public virtual override
        ////onlyDefaultAdminOrRoleAdmin(role)
    //{
        //address sender = _msgSender();
        //
        ////_requireHasAdminRole(role, sender);
        //
        //_transferRole(role, sender, to);
    //}
}
/// @dev deploy gas cost: 1,491,302
contract TACB is AccessControlBatched
{
    constructor(
    )public
        AccessControlBatched(){
    }
}