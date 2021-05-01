// SPDX-License-Identifier: MIT

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/eventsPausable.sol";

// interface iPausable
// {
    // function pause(
    // )external;
    // 
    // function unpause(
    // )external;
// }

///
/// @title Pausable Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 20/3/2021
/// @dev Allows derived contracts to implement a contract wide emergency stop
/// mechanism that can be triggered by an authorized account
///
/// inspired by OpenZepplin's Pausable.sol, available here:
///     https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Pausable.sol,
///
/// This contract has been rewritten to implement solidarity's LogicConstrains and PausableEvents,
/// the original MIT license is maintained.
/// 
/// Vigilance does not claim any ownership of the original source material by OpenZepplin and acknowledges their exclusive rights,
/// in respects to and as outlined by the MIT license.
///
/// As such, this contract is published as free and open source software, as permitted by the MIT license.
/// Vigilance does not profit from the use or distribution of this contract.
/// 
/// Further modification to this software is permitted,
/// only in respects to the terms specified by the MIT license and must cite the original author, OpenZeppelin,
/// as well as Vigilance
/// 
/// For more information please visit OpenZeppelin's documentation at:
///     https://docs.openzeppelin.com/contracts/3.x/
///
/// to utilize this functionality, apply modifiers:
///     `whenNotPaused`, `whenPaused`, `pauseAfter` or `unpauseAfer`
/// to functions of derived contracts
///
abstract contract Pausable is Context
{
    using LogicConstraints for bool;
    using eventsPausable for address payable;

    bool private _paused;
    /// @dev Initializes contract in unpaused state
    constructor(
    )internal
    {
        _paused = false;
    }
    /// @return {bool} true if the contract is paused, otherwise false
    function paused(
    )public view returns(
        bool
    ){
        return _paused;
    }
    /// @dev modified function is only callable when contract is NOT paused
    modifier whenNotPaused(){
        _paused.requireFalse(
            "paused"
        );
        _;
    }
    /// @dev modified function is only callable when is paused
    modifier whenPaused(){
        _paused.requireTrue(
            "not paused"
        );
        _;
    }
    /**
    /// @dev execute modified function only if contract is paused, then unpausing after execution
    modifier unpauseAfter(){
        _paused.requireTrue(
            "not paused"
        );
        
        _;
        
        _unpause();
    }
    /// @dev execute modified function only if contract is NOT paused, then pausing after execution
    modifier pauseAfter(){
        _paused.requireFalse(
            "paused"
        );
        
        _;
        
        _pause();
    }
    */
    /// @dev pause, must not already be paused
    function _pause(
    )internal virtual whenNotPaused
    {
        _paused = true;
        _msgSender().emitPaused();
    }
    /// @dev unpause, must already be paused
    function _unpause(
    )internal virtual whenPaused
    {
        _paused = false;
        _msgSender().emitUnpaused();
    }
}