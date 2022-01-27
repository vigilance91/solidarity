// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ther Receiver Events Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 27/4/2021, All Rights Reserved
/// @dev events and emitter library for ther Receiver implementations
///
library eventsEtherReceiver
{
    event ReceivedEther(
        address receiver,
        address from,
        uint256 amount,
        uint time,
        uint blockNumber
    );
    function emitReceivedEther(
        address receiver,
        address from,
        uint256 amount
    )internal
    {
        emit ReceivedEther(
            receiver,
            from,
            amount,
            block.timestamp,
            block.number
        );
    }
}