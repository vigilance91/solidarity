// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-2135 Consumable Transaction Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
///
interface iEncoderEIP2135
{
    //
    //read-only interface
    //
    //check whether an asset is consumable
    function isConsumable(
        uint256 assetId
    )external pure returns(
        bytes memory
    );
    ///
    ///mutable interface
    ///
    //consume asset
    function consume(
        uint256 assetId
    )external pure returns(
        bytes memory
    );
}