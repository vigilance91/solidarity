// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/iEtherReceiver.sol";
///
/// @title NonPayable Contract Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
/// @dev contracts which inherit from this abstract base contract actively rejects all ETH payments when using iEtherReceiver 
/// for verified safe ether transfers between accounts
///
abstract contract NonPayable is iEtherReceiver
{
    
    bytes4 internal constant _ETHER_DENIED = bytes4(0);
    
    string internal constant _REJECTED = " NonPayable::receive(): ether rejected";   //_NAME.concatenate("");
    
    receive(
    )external payable
    {
        LogicConstraints.alwaysRevert(
            _REJECTED
        );
    }
    
    constructor(
    )internal
    {
    }
    
    function onEtherReceived(
        address from,
        uint256 amount
    )public virtual override returns(
        bytes4
    ){
        return _ETHER_DENIED;
    }
    function canReceiveEther(
    )external view virtual override returns(    // nonReentrant?
        bool
    ){
        return false;   //LogicConstraints.FALSE
    }
}