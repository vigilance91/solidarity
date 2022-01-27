// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/block/time/blockTimeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/block/time/blockTimeConstraints.sol";

abstract contract BlockTimeConstraintsABC
{
    using blockTimeConstraints for uint;
    //
    //average time in seconds it takes to solve a single block on ethereum
    //struct storact BlockTime{
        uint8 internal _avgBlockDuration; // = 15;
        //uint256 _leapSeconds;
    //}
    
    // = keccak256('BlockTime(uint8 avgBlockDuration,uint256 _leapSeconds)');
    
    constructor(
        //uint8 averageBlockDuration
    )internal
    {
        //_leapSeconds = 0;
        _setBlockSolveDuration(
            15  //averageBlockDuration
        );
    }
    function averageBlockSolveDuration(
    )public view returns(
        uint8
    ){
        return _avgBlockDuration;
    }
    function _setBlockSolveDuration(
        uint8 averageBlockDuration
    )internal
    {
        //logicConstraints.requireTrue(
            //averageBlockDuration > 0 &&
            //averageBlockDuration < 30 &&
            //averageBlockDuration != _avgBlockDuration
        //);
        _avgBlockDuration = averageBlockDuration;
    }
    //function _addLeapSecond(
    //)internal
    //{
        //_leapSeconds = _leapSeconds.add(1);
    //}
    
    ///todo modifiers?
    
    /// >
    function _requireNowGreaterThan(
        uint rhs
    )internal view
    {
        rhs.requireBlockTimeNowGreaterThan(_avgBlockDuration);
    }
    function _requireNowGreaterThanOrEqual(
        uint rhs
    )internal view
    {
        rhs.requireBlockTimeNowGreaterThanOrEqual(_avgBlockDuration);
    }
    /// <
    function _requireNowLessThan(
        uint rhs
    )internal view
    {
        rhs.requireBlockTimeNowLessThan(_avgBlockDuration);
    }
    function _requireNowLessThanOrEqual(
        uint rhs
    )internal view
    {
        rhs.requireBlockTimeNowLessThanOrEqual(_avgBlockDuration);
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