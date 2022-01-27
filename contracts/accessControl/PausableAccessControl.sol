// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControl.sol";
import "https://github.com/vigilance91/solidarity/contracts/Pausable.sol";

//import "https://github.com/vigilance91/solidarity/contracts/accessConstrol/iPausableAccessControl.sol";

//interface iPausableAccessControl is iAccessControl,
//    iPausable
//{
//}

///
/// @title Pausable Access Control
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 22/4/2021, All Rights Reserved
///
abstract contract PausableAccessControl is AccessControl,
    Pausable
    //iPausableAccessControl
{
    //string private constant _NAME = ' PausableAccessControl: ';
    
    bytes32 public constant ROLE_PAUSER = keccak256("solidarity.accessControl.PausableAccessControl.ROLE_PAUSER");
    
    constructor(
    )internal 
        AccessControl()
        Pausable()
    {
        //
        //set pause role admin to default admin
        _setRoleAdmin(ROLE_PAUSER, ROLE_DEFAULT_ADMIN);
        //
        _setupRole(ROLE_PAUSER, _msgSender());
        //
        //allow contract to pause/unpause itself
        //_setupRole(ROLE_PAUSER, address(this));
    }
    ///
    /// @dev Pauses Contract
    ///
    /// Requirements:
    ///     - the caller must have `ROLE_PAUSER`
    ///
    function pause(
    )public virtual
    {
        address sender = _msgSender();
        
        _requireHasRole(ROLE_PAUSER, sender);
        
        _pause(sender);
    }
    ///
    /// @dev Unpauses Contract
    ///
    /// Requirements:
    ///     - the caller must have `ROLE_PAUSER`
    ///
    function unpause(
    )public virtual
    {
        address sender = _msgSender();
        
        _requireHasRole(ROLE_PAUSER, sender);
        
        _unpause(sender);
    }
    function _hasRolePauser(
        address account
    )internal view returns(
        bool
    ){
        return _hasRole(ROLE_PAUSER, account);
    }
}