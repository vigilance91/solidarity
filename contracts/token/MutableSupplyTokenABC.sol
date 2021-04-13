// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/TokenIdentifier/TokenIdentifierABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/StaticSupplyABC.sol";

//interface iMutableSupplyToken is iTokenIdentifier,
    //iMutableTokenSupply
//{
    //
//}

abstract contract MutableSupplyTokenABC is StaticSupplyTokenABC
{
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    )internal StaticSupplyTokenABC(
        name,
        symbol,
        initialSupply
    ){
        //_registerSupport(type(iMutableSupplyToken).interfaceId);
    }
}