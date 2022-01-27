// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC-173 Events Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
///
library eventsERC173
{
    event TransferOwnership(
        address previousOwner,
        address newOwner,
        uint time,
        uint blockNumber
    );
    
    function emitTransferOwnership(
        address previousOwner,
        address newOwner
    )internal
    {
        emit TransferOwnership(
            previousOwner,
            newOwner,
            now,
            block.number
        );
    }
}