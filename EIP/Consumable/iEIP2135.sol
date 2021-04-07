// SPDX-License-Identifier: Apache 2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-2135 Consumable Standard Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
///
interface iEIP2135
{
    //read-only interface
    //check whether an asset is consumable
    function isConsumable(
        uint256 assetId
    )external view returns(
        bool
    );
    ///
    ///mutable interface
    ///
    function consume(
        uint256 assetId
    )external returns(
        bool
    );
}