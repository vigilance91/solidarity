// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC20 Receiver Events Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
/// @dev events and emitter library for ERC20 Receiver implementations
///
library eventsERC20Receiver
{
    event ReceivedERC20(
        address receiver,
        address from,
        uint256 amount,
        uint time,
        uint blockNumber
    );
    function emitReceivedERC20(
        address receiver,
        address from,
        uint256 amount
    )internal
    {
        emit ReceivedERC20(
            receiver,
            from,
            amount,
            block.timestamp,
            block.number
        );
    }
}