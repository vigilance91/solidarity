// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControl.sol";
import "https://github.com/vigilance91/solidarity/contracts/Pausable.sol";

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
{
    //string private constant _NAME = ' PausableAccessControl: ';
    
    bytes32 public constant PAUSER_ROLE = keccak256("ACCESS_CONTROL.PAUSER_ROLE");
    
    constructor(
    )internal 
        AccessControl()
        Pausable()
    {
        _setupRole(PAUSER_ROLE, _msgSender());
    }
    ///
    /// @dev Pauses Contract
    ///
    /// Requirements:
    ///     - the caller must have `PAUSER_ROLE`
    ///
    function pause(
    )public virtual
        //onlyRole(PAUSER_ROLE)
    {
        require(
            hasRole(PAUSER_ROLE, _msgSender())
            //_NAME.concatenate("must have pauser role to pause")
        );
        _pause();
    }
    ///
    /// @dev Unpauses Contract
    ///
    /// Requirements:
    ///     - the caller must have `PAUSER_ROLE`
    ///
    function unpause(
    )public virtual
        //onlyRole(PAUSER_ROLE)
    {
        require(
            hasRole(PAUSER_ROLE, _msgSender())
            //_NAME.concatenate("must have pauser role to unpause")
        );
        _unpause();
    }
}