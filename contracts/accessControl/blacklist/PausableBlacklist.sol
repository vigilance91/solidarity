// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/blacklist/Blacklist.sol";
import "https://github.com/vigilance91/solidarity/contracts/Pausable.sol";

//interface iPausableBlacklist is iBlacklist,
//    iPausable
//{
//}

///
/// @title Pausable Blacklist
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 7/5/2021, All Rights Reserved
///
abstract contract PausableBlacklist is Blacklist,
    Pausable
{
    string private constant _NAME = ' PausableBlacklist: ';
    string private constant _ERR_CALLER_NOT_PAUSER = string(
        abi.encodePacked(
            _NAME,
            "caller not assigned role pauser"
        )
    );
    
    bytes32 public constant ROLE_PAUSER = keccak256("solidarity.contracts.accessConstrol.PausableBlacklist.ROLE_PAUSER");
    
    constructor(
    )internal 
        Blacklist()
        Pausable()
    {
        _setupRole(ROLE_PAUSER, _msgSender());
    }
    ///
    /// @dev Pauses Contract
    ///
    /// Requirements:
    ///     - the caller must have `ROLE_PAUSER`
    ///
    function pause(
    )public virtual
        //onlyRole(ROLE_PAUSER)
    {
        require(
            hasRole(ROLE_PAUSER, _msgSender())
            //_ERR_CALLER_NOT_PAUSER
        );
        _pause();
    }
    ///
    /// @dev Unpauses Contract
    ///
    /// Requirements:
    ///     - the caller must have `ROLE_PAUSER`
    ///
    function unpause(
    )public virtual
        //onlyRole(ROLE_PAUSER)
    {
        require(
            hasRole(ROLE_PAUSER, _msgSender())
            //_ERR_CALLER_NOT_PAUSER
        );
        _unpause();
    }
    //todo, override other operations for being paused, such as calls to `grantPermission` prevent modification to a contract's state while paused
}