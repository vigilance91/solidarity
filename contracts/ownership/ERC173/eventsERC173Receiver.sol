// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC173 Receiver Events Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
/// @dev events and emitter library for ERC173 Ownership transfer receiver implementations
///
library eventsERC173Receiver
{
    event ReceivedERC173(
        address receiver,
        address from,
        uint time,
        uint blockNumber
    );
    function emitReceivedERC173(
        address receiver,
        address from
    )internal
    {
        emit ReceivedERC173(
            receiver,
            from,
            block.timestamp,
            block.number
        );
    }
}