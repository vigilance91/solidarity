// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/libraries/block/now/nowLogic.sol";

import "https://github.com/vigilance91/solidarity/libraries/block/now/nowLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/block/now/nowConstraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/block/number/blockNumberLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/block/number/blockNumberConstraints.sol";
/// 
/// @title chronological Logic Library based on utilizing both block.timestamp and block.height for determining timepoints
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/3/2021, All Rights Reserved
/// @dev safely validates time based consensus between as average of both block.timestamp and block.number,
/// where even if a hostile miner forges the block's timestamp, they can not forge the block number of the transaction on the blockchain
/// also by averaging the block timestamp and number, this techniques provides a more acurate time point reference for
/// performing timed actions such as administrative tasks or ico launches in a provably fair manner
/// 
library blockTimeLogic
{
    using uint256Logic for uint;

    using nowLogic for uint;
    using nowConstraints for uint;
    
    using blockNumberLogic for uint;
    using blockNumberConstraints for uint;
    
    //ideal target hash rate for ethereum, however due to miner participation/hashrate vs block difficulty,
    //it varies and should, on average not be more than 30 and not less than 10,
    //according to
    uint256 internal constant MEDIAN_TARGET_HASHES_PER_SECOND = 15;
    //
    //uint256 internal constant MEDIAN_TARGET_HASHES_PER_SECOND = 10;
    //
    //uint256 internal constant SOFT_MAX_HASHES_PER_SECOND = 30;
    
    /// == and != are not useful
    
    /// >
    function blockTimeNowGreaterThan(
        uint rhs
        //uint avgBlockDuration
    )internal view returns(
        bool
    ){
        return rhs.nowGreaterThan() && rhs.blockNumberPastDelta(
            //avgBlockDuration
        ).greaterThanZero();
    }
    function blockTimeNowGreaterThanOrEqual(
        uint rhs
        //uint avgBlockDuration
    )internal view returns(
        bool
    ){
        return rhs.nowGreaterThanOrEqual(); //&& rhs.blockNumberPastDelta(
            //avgBlockDuration
        //).greaterThanOrEqualToZero();
    }
    /// <
    function blockTimeNowLessThan(
        uint rhs
        //uint avgBlockDuration
    )internal view returns(
        bool
    ){
        return rhs.nowLessThan() && rhs.blockNumberFutureDelta(
            //avgBlockDuration
        ).greaterThanZero();
    }
    function blockTimeNowLessThanOrEqual(
        uint rhs
        //uint avgBlockDuration
    )internal view returns(
        bool
    ){
        return rhs.nowLessThanOrEqual(); // && rhs.blockNumberFutureDelta(
            //avgBlockDuration
        //).greaterThanOrEqualToZero();
    }
}