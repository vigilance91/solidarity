// SPDX-License-Identifier: MIT

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControl.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControlABC.sol";
//import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControlMutableABC.sol";
///
/// @title Access Control
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev role-based access control mechanisms,
/// inspired by OpenZeppelin's AccessControl contract at:
///    https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/access/AccessControl.sol
/// 
/// OpenZeppelin, respectfully, owns all rights to their original source in respects to its MIT license, however,
/// Solidarity's version of AccessControl has been significantly rewritten from the ground up to not only increase readability but also
/// reduces comment bloat, addes functionality, fixes some logic issues/potential bugs/invariants and reduce contract bytecode size
///
/// Additionally, this version leverages encapsulation techniques pioneered by Solidarity,
/// including the use of Constraints, Mixins, Protocols and Frameworks to extend usability,
/// while still maintaining the neccessary core dependancies on OpenZeppelin, such as utils/Address and GSN/Context
///
/// As such, in good spirits, this file maintains the original MIT license of OpenZeppelin's work from which it is inspired,
/// the rest of the this package (which I personally wrote) is licensed under Apache-2.0
///
/// Vigilance does not claim any ownership of the original source material by OpenZepplin and acknowledges their exclusive rights,
/// in respects to and as outlined by the MIT license.
///
/// As such, this contract is published as free and open source software, as permitted by the MIT license.
/// Vigilance does not profit from the use or distribution of this contract.
/// 
/// Further modification to this software is permitted,
/// only in respects to the original terms specified by the MIT license and must cite the original author, OpenZeppelin,
/// as well as Vigilance and maintain the appropriate copyright notice and license.
///
/// For more information please visit OpenZeppelin's documentation at:
///     https://docs.openzeppelin.com/contracts/3.x/
///
/// NOTE:
///     since Solidity does not allow embbeding comments in the compiled contract binaries.
///     Due to this, in order to comply with the Apache-2.0 requirement to include the License with all binaries/executables, etc
///     using EIP-926 (Global Meta-data Registry) and EIP-1753 (License Standard),
///     it is possible to include/associate such license information on-chain with all contracts on the network which implement the Apache-2.0 License (or similar).
///     However, there is no such requirement for the MIT license
///
/// Roles are used to represent permissions and are repressented as `bytes32` identifiers and
/// should be exposed in a derived contract's external API using `public constant` hash digests:
/// ```
/// bytes32 public constant MY_ROLE = keccak256("MY_ROLE");
/// ```
/// To restrict access to a function call, use {hasRole}:
///
/// ```
/// function foo() public {
///     require(hasRole(MY_ROLE, msg.sender));
///     ...
/// }
/// ```
/// OR as a modifier
/// ```
/// function foo(
/// )public requireRole(
///     MY_ROLE,
///     msg.sender
/// ){
///     ...
/// }
/// ```
///
/// Each role has an associated admin which assigns or revokes roles dynamically via {grantRole} and {revokeRole}
/// 
/// `ROLE_DEFAULT_ADMIN` is the default admin role for all roles,
/// only addresses with this role are able to grant or revoke other roles
///
/// WARNING:
///     `ROLE_DEFAULT_ADMIN` is also its own admin thus,
///     it has permission to grant and revoke this role
///     Extra precautions should be taken to secure accounts that have been granted it,
///     and is recommended that this role should only be assigned to a single address,
///     potentilly either the contract deployer or owner (if ERC-173 compaliant)
///
abstract contract AccessControl is AccessControlABC,    //AccessControlMutableABC,
    iAccessControl
{
    using EnumerableSet for EnumerableSet.AddressSet;
    using Address for address;
    
    using eventsAccessControl for bytes32;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    
    //using mixinAccessControl for address;

    //bytes32 private constant _STORAGE_SLOT = keccak256();
    
    constructor(
    )internal
        //Context()
        AccessControlABC()
    {
    }
    /**
    modifier onlyRole(
        bytes32 role
    )internal
    {
        _requireHasRole(_msgSender(),role);
        _;
    }
    */
    //helpful post-initialization, where it must be enforced 1 or more role members have been assigned a role
    /**
    function _requireRoleHasMembers(
        bytes32 role
    )public view override returns(
        uint256
    ){
        return _roleAt(role).members.length().requireGreaterThanZero();
    }
    //helpful for initialization, where it must be enforced that no role members have been assigned
    function _requireRoleHasNoMembers(
        bytes32 role
    )public view override returns(
        uint256
    ){
        return _roleAt(role).members.length().requireEqualsZero();
    }
    */
    /**
    modifier onlyDefaultAdmin(
    )internal view
    {
        _requireRoleHasMembers(ROLE_DEFAULT_ADMIN);
        _requireIsDefaultAdmin(_msgSender());
        
        _;
    }
    //modifier onlyDefaultAdminOrRoleAdmin(
    //)internal view
    //{
        //
        //_;
    //}
    modifier onlyRole(
        bytes32 role
    )internal view
    {
        //_requireRoleHasMembers(role);
        _requireHasRole(role, _msgSender());
        _;
    }
    modifier _requireNotHasRole(
        bytes32 role
    ){
        _requireNotHasRole(role, _msgSender());
    }
    modifier onlyRoleAdmin(
        bytes32 role
    ){
        _requireHasAdminRole(role, _msgSender());
        _;
    }
    modifier requireIsNotRoleAdmin(
        bytes32 role
    )internal view
    {
        _requireNotHasAdminRole(role, _msgSender());
        _;
    }
    */
    ///
    ///read-only interface
    ///
    /// @return {bool} `true` if `account` has been granted `role`
    /// 
    /// Requirements:
    ///     -account can not be zero address
    ///
    function hasRole(
        bytes32 role,
        address account
    )external view override returns(
        bool
    ){
        //account.requireNotNull();
        //return _roleAt(role).members.contains(account);
        return _hasRole(role, account);
    }
    ///
    /// @return {bool} `true` if AddressLogic.NULL has been granted `role` (meaning all accounts have that role), otherwise `false`
    ///
    function hasRoleAll(
        bytes32 role
    )external view returns(
        bool
    ){
        return _hasRoleAll(role);
    }
    ///
    /// @return {uint256} the number of accounts that have `role`,
    /// can be used together with {getRoleMember} to enumerate all bearers of a role
    ///
    function getRoleMemberCount(
        bytes32 role
    )public view override returns(
        uint256
    ){
        return _roleAt(role).members.length();
    }
    ///
    /// @return {address} the account that have `role`, otherwise null
    /// `index` must be a value between 0 and {getRoleMemberCount}, non-inclusive
    /// 
    /// NOTE:
    ///     Role bearers are not sorted in any particular way,
    ///     and their ordering may change at any point
    /// 
    /// WARNING:
    ///     When using {getRoleMember} and {getRoleMemberCount},
    ///     make sure you perform all queries on the same block
    ///
    /// for more information see:
    ///     https://forum.openzeppelin.com/t/iterating-over-elements-on-enumerableset-in-openzeppelin-contracts/2296[forum post]
    ///
    function getRoleMember(
        bytes32 role,
        uint256 index
    )public view override returns(
        address
    ){
        return _roleAt(role).members.at(index);
    }
    //function sliceRoleMembers(
        //bytes32 role,
        //uint256 start,
        //uint256 end
    //)public view override returns(
        //address
    //){
        //return _roleAt(role).members.at(index);
    //}
    ///
    /// @return {bytes32} admin role that controls `role`
    /// See {grantRole} and {revokeRole}
    /// To change a role's admin, use {_setRoleAdmin}
    ///
    function getRoleAdmin(
        bytes32 role
    )public view override returns(
        bytes32
    ){
        return _roleAt(role).adminRole;
    }
    ///
    ///mutable interface
    ///
    
    ///
    /// @dev Grants `role` to `account`
    /// emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has previously been granted `role`
    ///
    function grantRole(
        bytes32 role,
        address account
    )public virtual override
        //onlyDefaultAdminOrRoleAdmin
    {
        _requireHasAdminRole(role, _msgSender());
        
        _grantRole(role, account);
    }
    ///
    /// @dev Grants `role` to each account in `accounts`
    /// emits multiple {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role or be default admin
    ///     - reverts if an account in `account` has previously been granted `role`
    ///
    function grantRole(
        bytes32 role,
        address[] memory accounts
    )public virtual //override
        //onlyDefaultAdminOrRoleAdmin
    {
        _requireHasAdminRole(role, _msgSender());
        
        for(uint i; i < accounts.length; i++){
            _grantRole(role, accounts[i]);
        }
    }
    ///
    /// @dev Revokes `role` from `account`
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has not previously been granted `role`
    ///
    function revokeRole(
        bytes32 role,
        address account
    )public virtual override
    {
        _requireHasAdminRole(role, _msgSender());
        
        _revokeRole(role, account);
    }
    ///
    /// @dev Revokes `role` from `account`
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has not previously been granted `role`
    ///
    function revokeRole(
        bytes32 role,
        address[] memory accounts
    )public virtual //override
    {
        _requireHasAdminRole(role, _msgSender());
        
        for(uint i; i < accounts.length; i++){
            _revokeRole(role, accounts[i]);
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
    function renounceRole(
        bytes32 role
        //address account
    )public virtual override
    {
        //account.requireEqual(
            //_msgSender()
            //"can only renounce roles for self"
        //);

        _revokeRole(role, _msgSender());
    }
    ///
    /// @dev Admin forces transfer of `role` from address `from` to address `to`
    /// emits a {RoleRevoked} event for `from` and {RoleGranted} event for `to`
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role or be default admin
    ///     - `from` must not be null and currently have the role `role`
    ///     - `to` must not be null and not have been assigned the role `role`
    ///
    /// NOTE:
    ///     Be careful, default admin role can be transfered (only with the privallegaes it provides),
    ///     this is useful along with transfering ownership via ERC173
    ///     however, if default admin role is transfered, this will immediately prevent any further admin operations,
    ///     thus it should be the last role transfered, if at all
    ///
    function transferRole(
        bytes32 role,
        address from,
        address to
    )public virtual override
        //onlyDefaultAdminOrRoleAdmin(role)
    {
        _requireHasAdminRole(role, _msgSender());
        
        _transferRole(role, from, to);
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
/*
contract ExternalAccessControl is AccessControlMutableABC,
    //ReentrancyGuard,
    iAccessControl
{
    using EnumerableSet for EnumerableSet.AddressSet;
    using Address for address;
    
    using eventsAccessControl for bytes32;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    
    //using mixinAccessControl for address;

    //bytes32 private constant _STORAGE_SLOT = keccak256();
    
    constructor(
    )public
        //ReentrancyGuard()
        AccessControlMutableABC()
    {
    }
    ///
    ///read-only interface
    ///
    
    /// @return {bool} `true` if `account` has been granted `role`
    /// 
    /// Requirements:
    ///     -account can not be zero address
    ///
    function hasRole(
        bytes32 role,
        address account
    )external view override returns(
        bool
    ){
        //account.requireNotNull();
        //return _roleAt(role).members.contains(account);
        return _hasRole(role, account);
    }
    ///
    /// @return {bool} `true` if AddressLogic.NULL has been granted `role` (meaning all accounts have that role), otherwise `false`
    ///
    function hasRoleAll(
        bytes32 role
    )external view returns(
        bool
    ){
        return _hasRoleAll(role);
    }
    ///
    /// @return {uint256} the number of accounts that have `role`,
    /// can be used together with {getRoleMember} to enumerate all bearers of a role
    ///
    function getRoleMemberCount(
        bytes32 role
    )external view override returns(
        uint256
    ){
        return _roleAt(role).members.length();
    }
    ///
    /// @return {address} the account that have `role`, otherwise null
    /// `index` must be a value between 0 and {getRoleMemberCount}, non-inclusive
    /// 
    /// NOTE:
    ///     Role bearers are not sorted in any particular way,
    ///     and their ordering may change at any point
    /// 
    /// WARNING:
    ///     When using {getRoleMember} and {getRoleMemberCount},
    ///     make sure you perform all queries on the same block
    ///
    /// for more information see:
    ///     https://forum.openzeppelin.com/t/iterating-over-elements-on-enumerableset-in-openzeppelin-contracts/2296[forum post]
    ///
    function getRoleMember(
        bytes32 role,
        uint256 index
    )external view override returns(
        address
    ){
        return _roleAt(role).members.at(index);
    }
    //function sliceRoleMembers(
        //bytes32 role,
        //uint256 start,
        //uint256 end
    //)public view override returns(
        //address
    //){
        //return _roleAt(role).members.at(index);
    //}
    ///
    /// @return {bytes32} admin role that controls `role`
    /// See {grantRole} and {revokeRole}
    /// To change a role's admin, use {_setRoleAdmin}
    ///
    function getRoleAdmin(
        bytes32 role
    )external view override returns(
        bytes32
    ){
        return _roleAt(role).adminRole;
    }
    ///
    ///mutable interface
    ///
    
    ///
    /// @dev Grants `role` to `account`
    /// emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has previously been granted `role`
    ///
    function grantRole(
        bytes32 role,
        address account
    )external virtual override nonReentrant
        //onlyDefaultAdminOrRoleAdmin
    {
        _requireHasAdminRole(role, _msgSender());
        
        _grantRole(role, account);
    }
    
    ///
    /// @dev Revokes `role` from `account`
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has not previously been granted `role`
    ///
    function revokeRole(
        bytes32 role,
        address account
    )external virtual override nonReentrant
    {
        _requireHasAdminRole(role, _msgSender());
        
        _revokeRole(role, account);
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
    function renounceRole(
        bytes32 role
        //address account
    )external virtual override nonReentrant
    {
        //account.requireEqual(
            //_msgSender()
            //"can only renounce roles for self"
        //);

        _revokeRole(role, _msgSender());
    }
    ///
    /// @dev Admin forces transfer of `role` from address `from` to address `to`
    /// emits a {RoleRevoked} event for `from` and {RoleGranted} event for `to`
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role or be default admin
    ///     - `from` must not be null and currently have the role `role`
    ///     - `to` must not be null and not have been assigned the role `role`
    ///
    /// NOTE:
    ///     Be careful, default admin role can be transfered (only with the privallegaes it provides),
    ///     this is useful along with transfering ownership via ERC173
    ///     however, if default admin role is transfered, this will immediately prevent any further admin operations,
    ///     thus it should be the last role transfered, if at all
    ///
    function transferRole(
        bytes32 role,
        address from,
        address to
    )external virtual override nonReentrant
        //onlyDefaultAdminOrRoleAdmin(role)
    {
        _requireHasAdminRole(role, _msgSender());
        
        _transferRole(role, from, to);
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
*/

/*
contract ExternalAccessControlBatched is ExternalAccessControl,
    iAccessControlMutableBatched
{   
    constructor(
    )internal
        ExternalAccessControl()
    {
    }
    ///
    /// @dev Grants `role` to each account in `accounts`
    /// emits multiple {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role or be default admin
    ///     - reverts if an account in `account` has previously been granted `role`
    ///
    function grantRole(
        bytes32 role,
        address[] memory accounts
    )external virtual override nonReentrant
        //onlyDefaultAdminOrRoleAdmin
    {
        _requireHasAdminRole(role, _msgSender());
        
        for(uint i; i < accounts.length; i++){
            _grantRole(role, accounts[i]);
       }
    }
    ///
    /// @dev Revokes `role` from `account`
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has not previously been granted `role`
    ///
    function revokeRole(
        bytes32 role,
        address[] memory accounts
    )external virtual override nonReentrant
    {
        _requireHasAdminRole(role, _msgSender());
        
        for(uint i; i < accounts.length; i++){
            _revokeRole(role, accounts[i]);
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
        bytes32[] calldata role
    )external virtual override nonReentrant
    {
        //account.requireEqual(
            //_msgSender()
            //"can only renounce roles for self"
        //);
        address sender = _msgSender();
        
        for(uint i; i < accounts.length; i++){
            _revokeRole(roles[i], sender);
        }
    }
}
*/
/*
abstract contract AccessControlBatched is AccessControl,
    iAccessControlBatched
{
    using EnumerableSet for EnumerableSet.AddressSet;
    using Address for address;
    
    using eventsAccessControl for bytes32;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    
    constructor(
    )internal
        AccessControl()
    {
    }
    ///
    /// @return {bool} `true` if `account` has been granted `role`
    /// 
    /// Requirements:
    ///     -account can not be zero address
    ///
    function hasRole(
        bytes32 role,
        address[] calldata accounts
    )external view override returns(
        bool[] memory
    ){
        return _hasRole(role, accounts);
    }
    ///
    /// @return ret {bool[]} `true` for each corresponding `role` in `roles` if it has been granted to AddressLogic.NULL, otherwise `false`
    ///
    function hasRoleAll(
        bytes32[] calldata roles
    )external view returns(
        bool[] memory ret
    ){
        ret = new bool[](roles.length);

        for(uint i; i < roles.length; i++){
            ret[i] = _hasRoleAll(roles[i]);
        }
    }
    ///
    /// @dev Revokes `role` from `account`
    /// emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///     - reverts if `account` has not previously been granted `role`
    ///
    function revokeRole(
        bytes32 role,
        address[] memory accounts
    )public virtual override
    {
        _requireHasAdminRole(role, _msgSender());
        
        for(uint i; i < accounts.length; i++){
            _revokeRole(role, accounts[i]);
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
        bytes32[] calldata role
    )external virtual override
    {
        //account.requireEqual(
            //_msgSender()
            //"can only renounce roles for self"
        //);
        address sender = _msgSender();
        
        for(uint i; i < accounts.length; i++){
            _revokeRole(roles[i], sender);
        }
    }
}
*/