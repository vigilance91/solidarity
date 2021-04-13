// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/StaticTokenSupply/StaticTokenSupplyABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/TokenIdentifier/TokenIdentifierABC.sol";
/**
interface iStaticSupplyToken is iTokenIdentifier,
    iStaticTokenSupply
{
}
*/
abstract contract StaticSupplyTokenABC is TokenIdentifierABC,
    iStaticTokenSupply
{
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    )internal
        TokenIdentifierABC(name,symbol)
        StaticTokenSupplyABC(initialSupply)
    {
        //_registerSupport(type(iTokenIdentifier).interfaceId);
        //_registerSupport(type(iStaticTokenSupply).interfaceId);
    }
}