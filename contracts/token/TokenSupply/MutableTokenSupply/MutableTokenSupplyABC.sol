// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/MutableTokenSupply/iMutableTokenSupply.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/StaticTokenSupply/StaticTokenSupplyABC.sol";
///
/// @title Mutable Token Supply Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev provide fully realized, mutable, token supply mechanics to derived contracts
///
abstract contract MutableTokenSupplyABC is StaticTokenSupplyABC
    iMutableTokenSupply
{   
    constructor(
        uint256 totalSupply
    )internal StaticTokenSupplyABC(totalSupply)
    {
    }
    /// @dev See {iERC20-totalSupply}
    function _setTotalSupply(
        uint256 newSupply
    )internal
    {
        mixinTokenSupply.setTotalSupply(newSupply);
        //_requireTotalSupplyGreaterThanZero();
    }
    
    function increaseTotalSupply(
        uint256 amountBy
    )public virtual override
    {
        mixinTokenSupply.increaseTotalSupply(amountBy);
    }
    function decreaseTotalSupply(
        uint256 amountBy
    )public virtual override
    {
        mixinTokenSupply.decreaseTotalSupply(amountBy);
        //token supply should never be 0
        //_requireTotalSupplyGreaterThanZero();
    }
}