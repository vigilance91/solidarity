// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Upgradeable Proxy Event Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 15/3/2021, All Rights Reserved
/// @dev events and emitter functions for Upgradeable Proxies
///
library eventsUpgradeableProxy
{
    ///
    /// @dev Emitted when the implementation is upgraded
    ///
    event ImplementationUpgraded(
        address proxy,
        address implementation,
        address newImplementation,
        uint time,
        uint blockNumber
    );
    ///
    /// @dev Emits ImplementationUpgraded event
    ///
    function emitImplementationUpgraded(
        address proxy,
        address implementation,
        address newImplementation
    )internal
    {
        emit ImplementationUpgraded(
            proxy,
            implementation,
            newImplementation,
            block.timestamp,
            block.number
        );
    }
}