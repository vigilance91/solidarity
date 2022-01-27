// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/iERC20Receiver.sol";
///
/// @title ERC20 NonTransferable Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
/// @dev inherit from this abstract base contract if the contract should reject ERC-20 transfers to it
///
abstract contract ERC20NonReceivableABC is iERC20Receiver
{
    bytes4 internal constant _ERC20_DENIED = bytes4(0);
    
    constructor(
    )internal
    {
    }
    
    function onERC20Received(
        address from,
        uint256 amount
    )public virtual override returns(
        bytes4
    ){
        return _ERC20_DENIED;
    }
    function canReceiveERC20(
    )external view virtual override returns(    // nonReentrant?
        bool
    ){
        return false;
    }
}