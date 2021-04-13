// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/mixinTokenSupply.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/StaticTokenSupply/iStaticTokenSupply.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";
///
/// @title Static Token Supply Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev provide immutable (view/read-only) token supply mechanics, logic and constraints to derived contracts
///
abstract contract StaticTokenSupplyABC is iStaticTokenSupply
{
    using uint256Logic for uint256;
    using uint256Constraints for uint256;
    //set the total supply on construction, then never change it
    constructor(
        uint256 tokenSupply
    )internal
    {
        mixinTokenSupply.initialize(
            tokenSupply
        );
    }
    /// @dev See {iERC20-totalSupply}
    function totalSupply(
    )public view override returns(
        uint256
    ){
        return mixinTokenSupply.totalSupply();
    }
    //
    //Total Supply Logic
    //
    // >
    function _totalSupplyGreaterThan(
        uint256 amount
    )internal view returns(
        bool
    ){
        return totalSupply().greaterThan(amount);
    }
    // > 0
    function _totalSupplyGreaterThanZero(
    )internal view returns(
        bool
    ){
        return totalSupply().greaterThan(0);
    }
    // >=
    function _totalSupplyGreaterThanOrEqual(
        uint256 amount
    )internal view returns(
        bool
    ){
        return totalSupply().greaterThanOrEqual(amount);
    }
    // <
    function _totalSupplyLessThan(
        uint256 amount
    )internal view returns(
        bool
    ){
        return totalSupply().lessThan(amount);
    }
    // <=
    function _totalSupplyLessThanOrEqual(
        uint256 amount
    )internal view returns(
        bool
    ){
        return totalSupply().lessThanOrEqual(amount);
    }
    //
    //Total Supply Constraints
    //
    // >
    function _requireTotalSupplyGreaterThan(
        uint256 amount
    )internal
    {
        _totalSupplyGreaterThan(amount).requireTrue(
            //""
        );
    }
    // > 0
    function _requireTotalSupplyGreaterThanZero(
    )internal
    {
        _totalSupplyGreaterThanZero().requireTrue(
            //""
        );
    }
    // >=
    function _requireTotalSupplyGreaterThanOrEqual(
        uint256 amount
    )internal
    {
        _totalSupplyGreaterThanOrEqual(amount).requireTrue(
            //""
        );
    }
    // <
    function _requireTotalSupplyLessThan(
        uint256 amount
    )internal
    {
        _totalSupplyLessThan(amount).requireTrue(
            //""
        );
    }
    // <=
    function _requireTotalSupplyLessThanOrEqual(
        uint256 amount
    )internal
    {
        _totalSupplyLessThanOrEqual(amount).requireTrue(
            //""
        );
    }
}