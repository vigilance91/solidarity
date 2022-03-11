// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableSet.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControlViewABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/mixinAccessControl.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
///
/// @title Access Control Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 8/12/2021, All Rights Reserved
/// @dev abstract base contract for role-based access control mechanisms
///
abstract contract AccessControlMutableABC is Context,
    AccessControlViewABC
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
    
    string private constant _NAME = " - AccessControlMutableABC: ";
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

    //string internal constant _STR_COMMA = ',';
    //string internal constant _ERR_STR_ROLE = " role: ";
    //string internal constant _ERR_STR_ADDRESS = " address: ";
    
    constructor(
        //bytes32 storageSlot
    )internal
        Context()
        AccessControlViewABC()
    {
        //_storageSlot = storageSlot;
        
        _setupRole(ROLE_DEFAULT_ADMIN, _msgSender());
    }
    
    //function _accessControlSlot(
    //)internal view returns(
        //bytes32
    //){
        //return _storageSlot;
    //}
    ///
    /// @dev Grants `role` to `account`
    /// emits a {RoleGranted} event
    ///
    /// NOTE:
    ///     unlike {grantRole}, no checks are performed on the calling account
    /// 
    /// WARNING:
    ///     This function should only be called internally from the constructor (or those of derived contracts) when setting up the initial roles for the system.
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
    function _grantRoleAll(
        bytes32 role
    )internal
    {
        _grantRole(role, AddressLogic.NULL);
    }
    function _revokeRoleAll(
        bytes32 role
    )internal
    {
        _revokeRole(role, AddressLogic.NULL);
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