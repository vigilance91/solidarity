// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/iERC20Receiver.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/eventsERC20Receiver.sol";
///
/// @title ERC20 Reciever Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
///
abstract contract ERC20ReceiverABC is iERC20Receiver
    //ERC165,
{
    using eventsERC20Receiver for address;
    
    bytes4 internal constant _ERC20_RECEIVED = iERC20Receiver.onERC20Received.selector;
    
    constructor(
    )internal //ERC165()
    {
        //_registerInterface(type(iERC20Receiver).interfaceId);
    }
    
    function onERC20Received(
        address from,
        uint256 amount
    )public virtual override returns(
        bytes4
    ){
        address(this).emitReceivedERC20(from, amount);
        
        return _ERC20_RECEIVED;
    }
    function canReceiveERC20(
    )external view virtual override returns(
        bool
    ){
        return true;
    }
}