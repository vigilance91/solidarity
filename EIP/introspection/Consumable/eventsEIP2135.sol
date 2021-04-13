// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Events Library for EIP-2135 Consumable Standard
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
///
library eventsEIP2135
{
    event OnConsumption(
        address indexed consumer,
        uint256 indexed assetId,
        uint indexed time,
        uint indexed block
    );
    function emitOnComsumption(
        address indexed consumer,
        uint256 indexed assetId
    )public
    {
        emit OnConsumption(
            consumer,
            assetId
            now,
            block.number
        );
    }
}