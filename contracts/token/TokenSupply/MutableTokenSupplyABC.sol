// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/staticTokenSupply/StaticTokenSupplyABC.sol";
///
/// @title Mutable Token Supply Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev provide fully realized, mutable, token supply mechanics to derived contracts
///
abstract contract MutableTokenSupplyABC is StaticTokenSupplyABC
{   
    constructor(
        uint256 totalSupply
    )internal StaticTokenSupplyABC(totalSupply)
    {
    }
    function _setTotalSupply(
        uint256 newSupply
    )internal
    {
        mixinTokenSupply.setTotalSupply(newSupply);
        //_requireTotalSupplyGreaterThanZero();
    }
    
    function _increaseTotalSupply(
        uint256 amountBy
    )internal
    {
        mixinTokenSupply.increaseTotalSupply(amountBy);
    }
    function _decreaseTotalSupply(
        uint256 amountBy
    )internal
    {
        mixinTokenSupply.decreaseTotalSupply(amountBy);
        //token supply should never be 0
        //_requireTotalSupplyGreaterThanZero();
    }
}