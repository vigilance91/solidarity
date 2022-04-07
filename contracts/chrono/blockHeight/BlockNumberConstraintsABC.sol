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
    function _requireBlockNumberGreaterThan(
        uint rhs
    )internal view
    {
        rhs.requireBlockNumberGreaterThan();
    }
    ///  block.number >= rhs
    function _requireNowBlockGreaterThanOrEqual(
        uint rhs
    )internal view
    {
        rhs.requireBlockNumberGreaterThanOrEqual();
    }
    ///  block.number < rhs
    function _requireBlockNumberLessThan(
        uint rhs
    )internal view
    {
        rhs.requireBlockNumberLessThan();
    }
    ///  block.number <= rhs
    function _requireBlockNumberLessThanOrEqual(
        uint rhs
    )internal view
    {
        rhs.requireBlockNumberLessThanOrEqual();
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