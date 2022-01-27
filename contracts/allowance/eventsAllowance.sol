// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Allowance Events
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev emitter and events relavent for mixinAllownace
///
library eventsAllowance
{
    event Approval(
        address owner,
        address spender,
        uint256 value
    );
    event RevokeAllowance(
        address owner,
        address spender,
        uint256 value
    );
    ///
    ///emitter functions
    ///
    function emitApproveAllowance(
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
    function emitRevokeAllowance(
        address owner,
        address spender,
        uint256 value
    )internal
    {
        emit RevokeAllowance(
            owner,
            spender,
            value
        );
    }
}