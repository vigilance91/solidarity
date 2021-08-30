// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/encoder/abiEncoderEtherReceiver.sol";
import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/encoder/iEncoderEtherReceiver.sol";
///
/// @title ERC-173 Ownership Transaction Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
abstract contract EncoderEtherReceiverABC is iEncoderEtherReceiver
{
    constructor(
    )internal
    {
    }
    
    function canReceiverEther(
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherReceiver.SIG_CAN_RECEIVER_ETHER;
    }
    
    function onEtherReceiver(
        address from,
        uint256 amount
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherReceiver.onEtherReceived(
            from,
            amount
        );
    }
}