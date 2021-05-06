// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Apoptosis Events Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 6/5/2021, All Rights Reserved
/// 
library eventsApoptosis
{
    event Apoptosis(
        address contract,
        addres receiver,
        uint time,
        uint blockNumber
    );
    
    function emitApoptosis(
        address self,
        addres receiver
    )internal
    {
        emit Apoptosis(
            self,
            receiver,
            block.timestamp,
            block.number
        );
    }
}