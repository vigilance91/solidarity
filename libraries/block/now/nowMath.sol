// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";
/// 
/// @title block.timestamp Math Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/3/2021, All Rights Reserved
/// @notice math operations specialized for block.timestamp
/// 
library nowMath
{
    //uint256 private _targetSecondsPerBlock = 15;
    
    using SafeMath for uint;

    using uint256Constraints for uint;

    /// @return {uint} total time, in seconds, in the past, since a specified timestamp
    function pastDelta(
        uint rhs
    )internal view returns(
        uint
    ){
        //block.timestamp.requireGreaterThan(rhs);
        return block.timestamp.sub(rhs);
    }
    /// @return {uint} total time, in seconds, in the future, until the timestamp specified
    function futureDelta(
        uint lhs
    )internal view returns(
        uint
    ){
        //lhs.requireGreaterThan(block.timestamp);
        return lhs.sub(block.timestamp);
    }
    /// @return {uint} now + `rhs`, timestamp, in seconds, in the future
    function nowAdd(
        uint rhs
    )internal view returns(
        uint
    ){
        return block.timestamp.add(rhs);
    }
    /// @return {uint} now - `rhs`, timestamp, in seconds, in the future
    function nowSub(
        uint rhs
    ) internal view returns(
        uint
    ){
        return block.timestamp.sub(rhs);
    }
    /// @return {uint} `lhs` - now, timestamp, in seconds, in the future
    //function subNow(
        //uint lhs
    //) internal pure returns(
        //uint
    //){
        //return lhs.sub(now);
    //}
    /// @return {uint} now * `rhs`, timestamp, in seconds, in the future
    function nowMul(
        uint rhs
    ) internal view returns(
        uint
    ){
        return block.timestamp.mul(rhs);
    }
    /// @return {uint} now / `rhs`, timestamp, in seconds, in the future
    function nowDiv(
        uint rhs
    )internal view returns(
        uint
    ){
        return block.timestamp.div(rhs);
    }
    /// @return {uint} now % `rhs`, timestamp, in seconds, in the future
    function nowMod(
        uint rhs
    )internal view returns(
        uint
    ){
        return block.timestamp.mod(rhs);
    }
    //function nowLShift(
        //uint8 rhs
    //) internal view returns(
        //uint
    //){
        //return block.timestamp << rhs;
    //}
    //function nowRShift(
        //uint8 rhs
    //)internal view returns(
        //uint
    //){
        //return block.timestamp >> rhs;
    //}
    function aproxBlocksInFuture(
        uint futureTimestamp,
        uint avgBlockDuration
    )internal view returns(
        uint
    ){
        avgBlockDuration.requireGreaterThanZero();
        //futureTimestamp.requireGreaterThan(block.timestamp);
        //avgBlockDuration.requireInRange(1,30);
        //future block estimate based on timestamp, relative to now and the average blocks processed per seconds across the range of timestamps
        //avgBlockDuration (in seconds) should be between 10-20 and should preferably be provided by an external oracle source
        //aprox number of blocks rendered between future timestamp and now
        return futureTimestamp.sub(block.timestamp).div(avgBlockDuration);
    }
    //returns current block number - aprox blocks which have been calculated
    function aproxBlocksInPast(
        uint pastTimestamp,
        uint avgBlockDuration
    )internal view returns(
        uint
    ){
        avgBlockDuration.requireGreaterThanZero();
        //block.timestamp.requireGreaterThan(pastTimestamp);
        //past block estimate relative to now and the average blocks processed per second across the range of timestamps
        //aprox number of blocks rendered between now and past timestamp
        return nowSub(pastTimestamp).div(avgBlockDuration);
    }
    /// Default/Target block computing time based functions
    function aproxBlocksInFutureDefault(
        uint futureTimestamp
    )internal view returns(
        uint
    ){
        return aproxBlocksInFuture(
            futureTimestamp,
            15
        );
    }
    /// @return {uint} current block number - aprox blocks which have been calculated
    function aproxBlocksInPastDefault(
        uint pastTimestamp
    )internal view returns(
        uint
    ){
        return aproxBlocksInPast(
            pastTimestamp,
            15
        );
    }
    //
    // Averaging functions between the default block solving duration and some user provided duration
    //
    function aproxBlocksInFutureAverage(
        uint futureTimestamp,
        uint avgBlockDuration
    )internal view returns(
        uint
    ){
        return aproxBlocksInFutureDefault(futureTimestamp).add(
            aproxBlocksInFuture(futureTimestamp, avgBlockDuration)
        ) >> 1;
    }
    function aproxBlocksInPastAverage(
        uint pastTimestamp,
        uint avgBlockDuration
    )internal view returns(
        uint
    ){
        return aproxBlocksInPastDefault(pastTimestamp).add(
            aproxBlocksInPast(pastTimestamp, avgBlockDuration)
        ) >> 1;
    }
}