// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/TokenIdentifier/TokenIdentifierABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/MutableTokenSupplyABC.sol";
///
/// @title Mutable Supply Token Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev Abstract Base Contract for a token with a dynamic supply
///
abstract contract MutableSupplyTokenABC is MutableTokenSupplyABC
{
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    )internal
        TokenIdentiferABC(name, symbol)
        MutableTokenSupplyABC(initialSupply)
    {
    }
}