// SPDX-License-Identifier: MIT

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/eventsPausable.sol";

// interface iPausableView
// {
    // function paused(
    // )external view returns(
        //bool
    //);
//}
// interface iPausableMutable
// {
    // function pause(
    // )external;
    // 
    // function unpause(
    // )external;
// }

//interface iPausable is iPausableView,
    //iPausableMutable
//{
    //
//}

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
abstract contract Pausable
    //iPausable
{
    using logicConstraints for bool;
    
    using eventsPausable for address;

    string private constant _NAME = " - Pausable: ";

    string private constant _ERR_UNPAUSED = string(
        abi.encodePacked(
            _NAME,
            "unpaused"
        )
    );

    string private constant _ERR_PAUSED = string(
        abi.encodePacked(
            _NAME,
            "paused"
        )
    );

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
    function _requirePaused(
    )internal view
    {
        _paused.requireTrue(
            _ERR_UNPAUSED
        );
    }
    function _requireNotPaused(
    )internal view
    {
        _paused.requireFalse(
            _ERR_PAUSED
        );
    }
    /// @dev modified function is only callable when contract is NOT paused
    modifier whenNotPaused(
    ){
        _requireNotPaused();
        
        _;
    }
    /// @dev modified function is only callable when is paused
    modifier whenPaused(
    ){
        _requirePaused();

        _;
    }
    /// @dev modified function is only callable when contract is NOT paused after function is called
    modifier _isNotPausedAfter(
    ){
        _;
        
        _requireNotPaused();
    }
    /// @dev modified function is only callable if contract is paused after function is called
    modifier _isPausedAfter(
    ){
        _;
        
        _requirePaused();
    }
    /// @dev function is only callable when NOT paused state is persistent before and after modified call
    modifier _isNotPausedPersistent(
    ){
        _requireNotPaused();
        
        _;
        
        _requireNotPaused();
    }
    /// @dev function is only callable when paused state is persistent before and after modified call
    modifier _isPausedPersistent(
    ){
        _requirePaused();
        
        _;
        
        _requirePaused();
    }
    /*
    /// @dev execute modified function only if contract is paused, then unpausing after execution
    modifier _unpauseAfter(
    ){
        _requirePaused();
        
        _;
        
        _unpause(_msgSender());
    }
    /// @dev execute modified function only if contract is NOT paused, then pausing after execution
    modifier _pauseAfter(
    ){
        _requireNotPaused();
        
        _;
        
        _pause(_msgSender());
    }
    */
    /// @dev pause, must not already be paused
    function _pause(
        address sender
    )internal virtual whenNotPaused
    {
        _paused = true;
        
        sender.emitPaused();
    }
    /// @dev unpause, must already be paused
    function _unpause(
        address sender
    )internal virtual whenPaused
    {
        _paused = false;
        
        sender.emitUnpaused();
    }

    //derived contract should iherit iPausable and override these functions
    //function pause(
    //)public virtual;
    
    //function unpause(
    //)public virtual;
}