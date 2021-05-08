// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/Whitelist.sol";
import "https://github.com/vigilance91/solidarity/contracts/Pausable.sol";

//interface iPausableAccessControl is iWhitelist,
//    iPausable
//{
//}

///
/// @title Pausable Whitelist
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 7/5/2021, All Rights Reserved
///
abstract contract PausableWhitelist is Whitelist,
    Pausable
{
    //string private constant _NAME = ' PausableWhitelist: ';
    
    bytes32 public constant PAUSER_ROLE = keccak256("Solidarity.PAUSEABLE_WHITELIST.PAUSER_ROLE");
    
    constructor(
    )internal 
        Whitelist()
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
    //todo, prevent other operations while paused, such as calls to `grantPermission` or anything which modifies contract state
}