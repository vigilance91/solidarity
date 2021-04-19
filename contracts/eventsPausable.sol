// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Pausable Events Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 20/3/2021, All Rights Reserved
/// @dev Pausable related events and convenience emitter functions
///
library eventsPausable
{
    /// @dev Emitted when the pause is triggered by `account`
    event Paused(
        address account
        //uint time,
        //uint blockNumber
    );
    ///@dev Emitted when the pause is lifted by `account`
    event Unpaused(
        address account
        //uint time,
        //uint blockNumber
    );
    ///
    ///emitter functions
    ///
    function emitPaused(
        address account
    )internal
    {
        emit Paused(
            account
            //block.timestamp
            //block.number
        );
    }
    function emitUnpaused(
        address account
    )internal
    {
        emit Unpaused(
            account
            //block.timestamp
            //block.number
        );
    }
}