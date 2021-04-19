// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC20 Events
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev emitter and events relavent to ERC20 standard
///
library eventsERC20
{
    event Transfer(
        address from,
        address to,
        uint256 value
    );
    event Approval(
        address owner,
        address spender,
        uint256 value
    );
    ///
    ///emitter functions
    ///
    function emitTransfer(
        address from,
        address to,
        uint256 value
    )internal
    {
        emit Transfer(
            from,
            to,
            value
        );
    }
    function emitApproval(
        address owner,
        address spender,
        uint256 value
    )internal
    {
        emit Approval(
            owner,
            spender,
            value
        );
    }
}