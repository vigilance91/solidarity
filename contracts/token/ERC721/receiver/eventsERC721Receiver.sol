// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC721 Receiver Events Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
/// @dev events and emitter library for ERC721 Receiver implementations
///
library eventsERC721Receiver
{
    event ReceivedERC721(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data,
        uint time,
        uint blockNumber
    );
    function emitReceivedERC20(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    )internal
    {
        emit ReceivedERC721(
            operator,
            from,
            tokeId,
            data,
            block.timestamp,
            block.number
        );
    }
}