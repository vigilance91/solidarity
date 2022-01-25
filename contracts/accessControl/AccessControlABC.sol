// SPDX-License-Identifier: MIT

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableSet.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControl.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/mixinAccessControl.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";
///
/// @title Access Control Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 8/12/2021, All Rights Reserved
/// @dev abstract base contract for role-based access control mechanisms
///
abstract contract AccessControlABC is Context
{
    using EnumerableSet for EnumerableSet.AddressSet;
    
    using LogicConstraints for bool;
    
    using Address for address;
    
    using AddressConstraints for address;
    
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
    
    string private constant _NAME = " - AccessControlABC: ";
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
    //
    string private constant _ERR_GRANT_ROLE_FAILED =  string(
        abi.encodePacked(
            _NAME,
            "_grantRole failed, ",
            _ERR_STR_ROLE
        )
    );
    string private constant _ERR_REVOKE_ROLE_FAILED =  string(
        abi.encodePacked(
            _NAME,
            "_revokeRole failed, ",
            _ERR_STR_ROLE
        )
    );

    string internal constant _STR_COMMA = ',';
    string internal constant _ERR_STR_ROLE = " role: ";
    string internal constant _ERR_STR_ADDRESS = " address: ";
    
    constructor(
        //bytes32 storageSlot
    )internal
        Context()
    {
        //_storageSlot = storageSlot;
        
        _setupRole(ROLE_DEFAULT_ADMIN, _msgSender());
    }
    
    function _readOnlyRoles(
    )private view returns(
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
        return _readOnlyRoles()[role];
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
        _hasRole(role, account).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_REQUIRE_ROLE,   //_NAME.concatenate(_ERR_REQUIRE_ROLE)
                    role
                    //_ERR_STR_ADDRESS,
                    //address
                )
            )
        );
    }
    function _requireNotHasRole(
        bytes32 role,
        address account
    )internal view
    {
        _hasRole(role, account).requireFalse(
            string(
                abi.encodePacked(
                    _ERR_REQUIRE_NOT_ROLE,   //_NAME.concatenate(_ERR_REQUIRE_NOT_ROLE)
                    role,
                    _STR_COMMA,
                    _ERR_STR_ADDRESS,
                    account
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
    ///
    /// @dev Grants `role` to `account`
    /// emits a {RoleGranted} event
    ///
    /// NOTE:
    ///     unlike {grantRole}, no checks are performed on the calling account
    /// 
    /// WARNING:
    ///     This function should only be called from the constructor when setting up the initial roles for the system
    ///     Using this function in any other way is effectively circumventing the admin system imposed by {AccessControl}
    ///
    function _setupRole(
        bytes32 role,
        address account
    )internal virtual
    {
        _grantRole(role, account);
    }
    ///
    /// @dev Sets `adminRole` as ``role``'s admin role
    /// 
    /// Emits a {RoleAdminChanged} event
    ///
    function _setRoleAdmin(
        bytes32 role,
        bytes32 adminRole
    )internal virtual
    {
        mapping(bytes32=>mixinAccessControl.RoleData) storage mr = mixinAccessControl.storageAccessControl(
            //_storageSlot
        ).roles;
        
        //aside from ROLE_DEFAULT_ADMIN (which is its own admin), roles can not be their own admin
        //role.requireNotEqual(adminRole);
        ////mr[role].adminRole.requireZero("adminRole already set");
        
        mr[role].adminRole = adminRole;
        
        role.emitRoleAdminChanged(
            mr[role].adminRole,
            adminRole
        );
    }
    function _grantRole(
        bytes32 role,
        //address sender,
        address recipient
    )internal
    {
        //_requireCanReceiveAccessControl(recipient);   //, role);
        
        mixinAccessControl.storageAccessControl(
            //_storageSlot
        ).roles[role].members.add(recipient).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_GRANT_ROLE_FAILED,
                    role,
                    _STR_COMMA,
                    _ERR_STR_ADDRESS,
                    recipient
                )
            )
        );
        
        role.emitRoleGranted(
            recipient,
            _msgSender()
        );
        //
        //_requireOnRoleReceived(recipient, sender, role);
    }
    function _revokeRole(
        bytes32 role,
        address account
    )internal
    {
        mixinAccessControl.storageAccessControl(
            //_storageSlot
        ).roles[role].members.remove(account).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_REVOKE_ROLE_FAILED,
                    role,
                    _STR_COMMA,
                    _ERR_STR_ADDRESS,
                    account
                )
            )
        );
        
        role.emitRoleRevoked(
            account,
            _msgSender()
        );
    }
    ///
    /// @dev Admin forces transfer of `role` from address `from` to address `to`
    /// emits a {RoleRevoked} even for `from` and {RoleGranted} event for `to`
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
    function _transferRole(
        bytes32 role,
        address from,
        address to
    )internal virtual
    {
        //from.requireNotNullAndNotEqual(to);
        
        _requireHasRole(role,from);
        _requireNotHasRole(role,to);
        
        _grantRole(role, to);
        _revokeRole(role, from);
    }
}