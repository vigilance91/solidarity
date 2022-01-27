// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/block/now/nowConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/block/number/blockNumberConstraints.sol";
/// 
/// @title Block timestamp Based Chonologic Math Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/3/2021, All Rights Reserved
/// @brief  based on utilizing both block.timestamp and block.height for determining time points,
/// safely validating time based consensus between an average of both block.timestamp and block.number,
/// where even if a hostile miner forges the block's timestamp, they can not forge the block number of the transaction on the blockchain
/// 
/// Also, by averaging the block timestamp and number, this techniques provides a more acurate time point reference for
/// performing timed actions such as administrative tasks or ico launches in a provably fair manner,
/// however it is still inaccurate, since it is only an average of two estimates based on a deterministic block hash rate,
/// which is not linear and subject to drift, there is a still, more accurate, approach to take when representing time
/// 
library blockTimeMath
{
    using nowLogic for uint;
    using nowConstraints for uint;
    
    using blockNumberLogic for uint;
    using blockNumberConstraints for uint;
    
    //ideal target hash rate for ethereum, however due to miner participation/hashrate vs block difficulty,
    //it varies and should, on average not be more than 30 and not less than 10,
    //according to
    uint256 internal constant MEDIAN_TARGET_HASHES_PER_SECOND = 15;
    //uint256 internal constant SOFT_MIN_SECONDS_PER_HASH = 10;
    //uint256 internal constant SOFT_MAX_SECONDS_PER_HASH = 30;
    
    /// @return {uint} approximate time in seconds, in the past, between now and a specified timestamp
    function blockTimeAdjustedSecondsSince(
        uint rhs,
        uint avgBlockDuration
    )internal pure returns(
        uint256
    ){
        //now >= rhs
        if(rhs.nowGreaterThanOrEqual()){
            return 0;
        }
        //( (now - rhs) + avgBlocksInPast) / 2
        //average between system default target of 1 block per 15 seconds,
        //and a user provided duration which more closely resemebles the solving duration over the desired duration
        uint AVG_BLOCKS = rhs.aproxBlocksInPastAverage(avgBlockDuration);
        //avgBlock
        uint AVG_S = AVG_BLOCKS.mul(MEDIAN_TARGET_HASHES_PER_SECOND).add(
            AVG_BLOCKS.mul(avgBlockDuration)
        ) >> 1;
        
        //(time:block timestamp time + block number time) / 2, blockNumber:block.number - AVG_BLOCKS
        //return (
            //rhs.nowSub().add(
                //AVG_S.nowSub()
            //) >> 1,
            //AVG_BLOCKS.blockNumberNowSub()
        //);
        
        //((now - rhs) + (now - blocktime)) / 2 (rounded down to the nearest whole second)
        return rhs.nowSub().add(
            AVG_S.nowSub()
        ) >> 1;
    }
    //total time in seconds, in the future, between now and the timestamp specified
    function blockTimeAverageSecondsUntil(
        uint lhs,
        uint avgBlockDuration
    )internal pure returns(
        bool
    ){
        //now <= rhs
        if(lhs.nowLessThanOrEqual(){
            return 0;
        }
        //( (now + rhs) + avgBlocksInFuture) / 2
        uint AVG_BLOCKS = lhs.aproxBlocksInFuture(avgBlockDuration);
        uint AVG_S = AVG_BLOCKS.mul(MEDIAN_TARGET_HASHES_PER_SECOND).add(
            AVG_BLOCKS.mul(avgBlockDuration)
        ) >> 1;
        
        return lhs.sub(now).add(
            AVG_S.sub(now)
        ) >> 1;
    }
    /// 
    /// @return {uint} aprox. time in seconds, in the future, from now relative to the block timestamp and,
    /// an average of block solving duration supplied by a user timestamp in future
    ///
    function blockTimeAverageSecondsUntil(
        uint tsFuture,
        uint avgBlockDuration
    )internal pure returns(
        bool
    ){
        //( (now + rhs) + (blocksInFuture * avgBlockDuration) ) / 2
        return chronoSecondsUntil(
            tsFuture,
            avgBlockDuration
        ).nowAdd();
    }
    /// 
    /// @return {uint} aprox. time in seconds, in the past, from now relative to the block timestamp and,
    /// an average of block solving duration supplied by a user timestamp in past
    /// 
    function blockTimeAdjustedSecondsSince(
        uint tsPast,
        uint avgBlockDuration
    )internal pure returns(
        bool
    ){
        return chronoSecondsSince(
            tsPast,
            avgBlockDuration
        ).nowSub();
    }
    /**
    *rhs and returns are in blocks
    
    function blockTimeAdjustedSecondsSinceNow(
        uint tsPast,
        uint avgBlockDuration
    )internal pure returns(
        bool
    ){
        return tsPast.blocksSince(avgBlockDuration).nowSub();
    }
    //total time in seconds, in the future, until the timestamp specified
    function blockTimeAdjustedFromNow(
        uint tsFuture,
        uint avgBlockDuration
    ) internal pure returns(
        bool
    ){
        return tsFuture.blocksUntil(avgBlockDuration).nowAdd();
    }
    */
}