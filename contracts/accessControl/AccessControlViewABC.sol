// SPDX-License-Identifier: MIT

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableSet.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControl.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/mixinAccessControl.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
///
/// @title Access Control View Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 8/12/2021, All Rights Reserved
/// @dev abstract base contract for role-based access control mechanisms
///
abstract contract AccessControlViewABC  //is AccessControlConstraints
{
    using EnumerableSet for EnumerableSet.AddressSet;
    
    using logicConstraints for bool;
    
    using Address for address;
    
    using addressConstraints for address;
    
    //using stringUtilities for string;
    
    //using mixinAccessControl for bytes32;
    using eventsAccessControl for bytes32;
    
    //struct RoleData {
        //EnumerableSet.AddressSet members;
        //bytes32 adminRole;
    //}
    
    //bytes32 private _storageSlot;
    
    //mapping (bytes32 => RoleData) private _roles;

    bytes32 public constant ROLE_DEFAULT_ADMIN = 0x00;
    
    string private constant _NAME = " - AccessControlViewABC: ";
    //
    string private constant _ERR_REQUIRE_ROLE_DEFAULT_ADMIN = string(
        abi.encodePacked(
            _NAME,
            "must be default admin, ",
            _ERR_STR_ADDRESS
        )
    );
    string private constant _ERR_REQUIRE_NOT_ROLE_DEFAULT_ADMIN = string(
        abi.encodePacked(
            _NAME,
            "can not be default admin, ",
            _ERR_STR_ADDRESS
        )
    );
    //
    string private constant _ERR_REQUIRE_ROLE =  string(
        abi.encodePacked(
            _NAME,
            "sender does not have role, ",
            _ERR_STR_ROLE
        )
    );
    string private constant _ERR_REQUIRE_NOT_ROLE = string(
        abi.encodePacked(
            _NAME,
            "sender can not have role, ",
            _ERR_STR_ROLE
        )
    );
    
    string private constant _ERR_REQUIRE_HAS_ROLE_ALL =  string(
        abi.encodePacked(
            _NAME,
            "role must be assigned to all, ",
            _ERR_STR_ROLE
        )
    );
    string private constant _ERR_REQUIRE_NOT_HAS_ROLE_ALL = string(
        abi.encodePacked(
            _NAME,
            "role must not be assigned to all, ",
            _ERR_STR_ROLE
        )
    );
    string internal constant _STR_COMMA = ',';
    string internal constant _ERR_STR_ROLE = " role: ";
    string internal constant _ERR_STR_ADDRESS = " address: ";
    
    constructor(
        //bytes32 storageSlot
    )internal
    {
        //_storageSlot = storageSlot;
    }
    
    function _readOnlyRoles(
    )internal view returns(
        mapping(bytes32=>mixinAccessControl.RoleData) storage
    ){
        return mixinAccessControl.storageAccessControl(
            //_storageSlot
        ).roles;
    }
    //function _accessControlSlot(
    //)internal view returns(
        //bytes32
    //){
        //return _storageSlot;
    //}
    
    function _roleAt(
        bytes32 role
    )internal view returns(
        mixinAccessControl.RoleData storage
    ){
        return mixinAccessControl.roleAt(role);
    }
    ///
    ///constraints
    ///
    function _requireIsDefaultAdmin(
        address account
    )internal view
    {
        _hasRole(ROLE_DEFAULT_ADMIN, account).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_REQUIRE_ROLE_DEFAULT_ADMIN,     //_NAME.concatenate(_ERR_REQUIRE_ROLE_DEFAULT_ADMIN)
                    //_ERR_STR_ADDRESS,
                    account
                )
            )
        );
    }
    function _requireIsNotDefaultAdmin(
        address account
    )internal view
    {
        _hasRole(ROLE_DEFAULT_ADMIN, account).requireFalse(
            string(
                abi.encodePacked(
                    _ERR_REQUIRE_NOT_ROLE_DEFAULT_ADMIN, //_NAME.concatenate(_ERR_REQUIRE_NOT_ROLE_DEFAULT_ADMIN)
                    //_ERR_STR_ADDRESS,
                    account
                )
            )
        );
    }
    function _requireHasRole(
        bytes32 role,
        address account
    )internal view
    {
        mixinAccessControl.requireHasRole(role, account);
    }
    function _requireNotHasRole(
        bytes32 role,
        address account
    )internal view
    {
        mixinAccessControl.requireNotHasRole(role, account);
    }
    function _requireHasRoleAll(
        bytes32 role
    )internal view
    {
        _hasRoleAll(role).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_REQUIRE_NOT_HAS_ROLE_ALL,
                    role
                    //_ERR_STR_ADDRESS,
                    //AddressLogic.NULL
                )
            )
        );
    }
    function _requireNotHasRoleAll(
        bytes32 role
    )internal view
    {
        _hasRoleAll(role).requireFalse(
            string(
                abi.encodePacked(
                    _ERR_REQUIRE_HAS_ROLE_ALL,
                    role
                    //_ERR_STR_ADDRESS,
                    //AddressLogic.NULL
                )
            )
        );
    }
    function _requireHasAdminRole(
        bytes32 role,
        address account
    )internal view
    {
        //(_hasRole(_roleAt(role).adminRole, account) || _isDefaultAdmin(account))
        _hasRole(_roleAt(role).adminRole, account).requireTrue(
            //_ERR_"sender must be an admin")
        );
    }
    function _requireNotHasAdminRole(
        bytes32 role,
        address account
    )internal view
    {
        //(!_hasRole(_roleAt(role).adminRole, account) && !_isDefaultAdmin(account))
        _hasRole(_roleAt(role).adminRole, account).requireFalse(
            //_ERR_"sender must not be an admin")
        );
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
    function _hasRole(
        bytes32 role,
        address account
    )internal view returns(
        bool
    ){
        return _roleAt(role).members.contains(account);
    }
    ///
    /// @return {bool} `true` if AddressLogic.NULL has been granted `role` (meaning all accounts have that role), otherwise `false`
    ///
    function _hasRoleAll(
        bytes32 role
    )internal view returns(
        bool
    ){
        return _hasRole(role, addressLogic.NULL);
    }
    ///
    /// @return ret {bool[]} `true` for each corresponding`account in `accounts` has been granted `role`, otherwise false
    /// 
    /// Requirements:
    ///     -account can not be zero address
    ///
    function _hasRole(
        bytes32 role,
        address[] memory accounts
    )internal view returns(
        bool[] memory ret
    ){
        ret = new bool[](accounts.length);

        for(uint i; i < accounts.length; i++){
            ret[i] = _hasRole(role, accounts[i]);
        }
    }
    ///
    /// @return {uint256} the number of accounts that have `role`,
    /// can be used together with {getRoleMember} to enumerate all bearers of a role
    ///
    function _roleMemberCount(
        bytes32 role
    )internal view returns(
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
    function _roleMember(
        bytes32 role,
        uint256 index
    )internal view returns(
        address
    ){
        //_roleMemberCount(role).requireGreaterThanOrEqual(
            //index
        //);
        
        return _roleAt(role).members.at(index);
    }
    ///
    /// @return {bytes32} admin role that controls `role`
    /// See {grantRole} and {revokeRole}
    /// To change a role's admin, use {_setRoleAdmin}
    ///
    function _roleAdmin(
        bytes32 role
    )internal view returns(
        bytes32
    ){
        return _roleAt(role).adminRole;
    }
}