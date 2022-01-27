// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/block/number/blockNumberConstraints.sol";

abstract contract BlockNumberConstraintsABC
{
    using blockNumberConstraints for uint;
    //using blockNumberMath for uint;
    //
    //average time in seconds it takes to solve a single block on ethereum
    //struct storact BlockTime{
        //uint8 internal _avgBlockDuration; // = 15;
        //uint256 _leapSeconds;
    //}
    
    constructor(
        //uint8 averageBlockDuration
    )internal
    {
    }
    ///  block.number > rhs
    function _requireNowBlockGreaterThan(
        uint rhs
    )internal view
    {
        rhs.requireNowBlockGreaterThan();
    }
    ///  block.number >= rhs
    function _requireNowBlockGreaterThanOrEqual(
        uint rhs
    )internal view
    {
        rhs.requireNowBlockGreaterThanOrEqual();
    }
    ///  block.number < rhs
    function _requireNowBlockLessThan(
        uint rhs
    )internal view
    {
        rhs.requireNowBlockLessThan();
    }
    ///  block.number <= rhs
    function _requireNowBlockLessThanOrEqual(
        uint rhs
    )internal view
    {
        rhs.requireNowBlockLessThanOrEqual();
    }
    /// lhs > block.number
    function _requireGreaterThanNowBlock(
        uint lhs
    )internal view
    {
        lhs.requireGreaterThanNowBlock();
    }
    /// lhs >= block.number
    function _requireGreaterThanOrEqualToNowBlock(
        uint lhs
    )internal view
    {
        lhs.requireGreaterThanOrEqualToNowBlock();
    }
    /// lhs < block.number
    function _requireLessThanNowBlock(
        uint lhs
    )internal view
    {
        lhs.requireLessThanNowBlock();
    }
    /// lhs <= block.number
    function _requireLessThanOrEqualToNowBlock(
        uint lhs
    )internal view
    {
        lhs.requireLessThanOrEqualNowBlock();
    }
    
    //function _requireSecondsUntil(
        //uint time
    //)internal view
    //{
        //rhs.requireBlockTimeNowLessThanOrEqual(_avgBlockDuration);
    //}
    //function _requireSecondsSince(
        //uint time
    //)internal view
    //{
        //rhs.requireBlockTimeNowLessThanOrEqual(_avgBlockDuration);
    //}
}