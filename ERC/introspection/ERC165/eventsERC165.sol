// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC-165 Events
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
///
library eventsERC165
{
    event interfaceSupported(
        bytes4 interfaceId,
        bool supported
    );
    
    function emitInterfaceSupported(
        bytes4 interfaceId,
        bool supported
    )internal
    {
        emit interfaceSupported(
            interfaceId,
            supported
        );
    }
}