// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableSet.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/eventsAccessControl.sol";

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressLogic.sol";
///
/// @title Mixin Access Control Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev mixin for role-based access control mechanisms
///
library mixinAccessControl
{
    using EnumerableSet for EnumerableSet.AddressSet;
    
    using logicConstraints for bool;
    
    //using Address for address;
    
    //using addressConstraints for address;
    
    bytes32 internal constant ROLE_DEFAULT_ADMIN = 0x00;
    
    struct RoleData {
        bytes32 adminRole;
        
        EnumerableSet.AddressSet members;
    }
    
    string private constant _NAME = " - mixinAccessControl: ";
    //bytes32 public constant ROLE_DEFAULT_ADMIN = 0x00;
    bytes32 internal constant STORAGE_SLOT = bytes32(uint256(
        keccak256("solidarity.contracts.accessControl.STORAGE_SLOT")
    ) - 1);
    //
    string private constant _ERR_STRING_ROLE = ", role: ";
    string private constant _ERR_STRING_ADDRESS = ", address: ";
    //
    //
    string private constant _ERR_REQUIRE_ROLE =  string(
        abi.encodePacked(
            _NAME,
            "sender does not have role",
            _ERR_STRING_ROLE
        )
    );
    string private constant _ERR_REQUIRE_NOT_ROLE = string(
        abi.encodePacked(
            _NAME,
            "sender can not have role",
            _ERR_STRING_ROLE
        )
    );
    //
    string private constant _ERR_GRANT_ROLE_FAILED =  string(
        abi.encodePacked(
            _NAME,
            "grantRole failed",
            _ERR_STRING_ROLE
        )
    );
    string private constant _ERR_REVOKE_ROLE_FAILED =  string(
        abi.encodePacked(
            _NAME,
            "revokeRole failed",
            _ERR_STRING_ROLE
        )
    );
    
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
    function initialize(
        //bytes32 slot,
        address deployer
    )internal
    {
        grantRole(ROLE_DEFAULT_ADMIN, deployer);
        //grantRole(ROLE_DEFAULT_ADMIN, address(this));
    }
    function roleAt(
        bytes32 role
    )internal view returns(
        RoleData storage
    ){
        return storageAccessControl().roles[role];
    }
    function requireHasRole(
        bytes32 role,
        address account
    )internal view
    {
        hasRole(role, account).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_REQUIRE_ROLE,   //_NAME.concatenate(_ERR_REQUIRE_ROLE)
                    role,
                    _ERR_STRING_ADDRESS,
                    account
                )
            )
        );
    }
    function requireNotHasRole(
        bytes32 role,
        address account
    )internal view
    {
        hasRole(role, account).requireFalse(
            string(
                abi.encodePacked(
                    _ERR_REQUIRE_NOT_ROLE,   //_NAME.concatenate(_ERR_REQUIRE_NOT_ROLE)
                    role,
                    _ERR_STRING_ADDRESS,
                    account
                )
            )
        );
    }
    //function _accessControlSlot(
    //)internal view returns(
        //bytes32
    //){
        //return _storageSlot;
    //}
    function hasRole(
        bytes32 role,
        address account
    )internal view returns(
        bool
    ){
        return roleAt(role).members.contains(account);
    }
    ///
    /// @dev Sets `adminRole` as ``role``'s admin role
    /// 
    /// Emits a {RoleAdminChanged} event
    ///
    function setRoleAdmin(
        //byes32 slot,
        bytes32 role,
        bytes32 adminRole
    )internal
    {
        mapping(bytes32=>RoleData) storage mr = storageAccessControl(
            //_storageSlot
        ).roles;
        
        //aside from ROLE_DEFAULT_ADMIN (which is its own admin), roles can not be their own admin
        //role.requireNotEqual(adminRole);
        ////mr[role].adminRole.requireZero("adminRole already set");
        
        mr[role].adminRole = adminRole;
    }
    function grantRole(
        //byes32 slot,
        bytes32 role,
        //address sender,
        address recipient
    )internal
    {
        //_requireCanReceiveAccessControl(recipient);   //, role);
        
        storageAccessControl(
            //slot
        ).roles[role].members.add(recipient).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_GRANT_ROLE_FAILED,
                    role,
                    _ERR_STRING_ADDRESS,
                    recipient
                )
            )
        );
        //
        //_requireOnRoleReceived(recipient, sender, role);
    }
    function revokeRole(
        //byes32 slot,
        bytes32 role,
        address account
    )internal
    {
        storageAccessControl(
            //slot
        ).roles[role].members.remove(account).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_REVOKE_ROLE_FAILED,
                    role,
                    _ERR_STRING_ADDRESS,
                    account
                )
            )
        );
    }
    function grantRoleAll(
        //byes32 slot,
        bytes32 role
    )internal
    {
        grantRole(role, addressLogic.NULL);
    }
    function revokeRoleAll(
        //byes32 slot,
        bytes32 role
    )internal
    {
        revokeRole(role, addressLogic.NULL);
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
    function transferRole(
        //byes32 slot,
        bytes32 role,
        address from,
        address to
    )internal virtual
    {
        //from.requireNotNullAndNotEqual(to);
        
        requireHasRole(role,from);
        requireNotHasRole(role,to);
        
        grantRole(role, to);
        revokeRole(role, from);
    }
}