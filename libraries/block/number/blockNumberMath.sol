// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title uint Logic Utilities for use with block.timestamp for chronological operations
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/3/2021, All Rights Reserved
/// @notice inspired by the technique outlined here, https://blog.cotten.io/timing-future-events-in-ethereum-5fbbb91264e7
/// 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";
///
/// @title Utility Library for block.number Based Chronological Math Operations
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/12/2021, All Rights Reserved
/// 
library blockNumberMath
{
    using uint256Constraints for uint;
    //using NowMath for uint;
    
    using SafeMath for uint;
    
    //uint internal constant AVG_SOLVE_DURATION = 15;
    //uint internal constant SOFT_MIN_SOLVE_DURATION = 10;
    //uint internal constant SOFT_MAX_SOLVE_DURATION = 30;
    //can only generate hash and access last 255 blocks
    //uint internal constant PREVIOUS_BLOCK_HARD_LIMIT = 256;
    /**
    //total number of blocks, in the past, since the current block
    function nowBlockPastDelta(
        uint rhs
    ) internal pure
        returns(bool)
    {
        //block.number.lessThan(rhs);
        return block.number.sub(rhs);
    }
    //total number of blocks, in the future, from the current block
    function nowBlockFutureDelta(
        uint lhs
    ) internal pure
        returns(bool)
    {
        //lhs.requireGreatThan(block.number);
        return lhs.sub(block.number);
    }
    */
    /// @return {uint} current block number + `rhs`, number of blocks in the future, from the current block
    function nowBlockAdd(
        uint rhs
    )internal view returns(
        uint
    ){
        return block.number.add(rhs);
    }
    /// @return {uint} current block number - `rhs`, number of blocks in the past, from the current block
    function nowBlockSub(
        uint rhs
    )internal view returns(
        uint
    ){
        return block.number.sub(rhs);
    }
    /// @return {uint} `lhs` - current block, delta of blocks in the future between now and block number lhs
    function subNowBlock(
        uint lhs
    )internal view returns(
        uint
    ){
        return lhs.sub(block.number);
    }
    /// @return {uint} current block number * `rhs`
    function blockNowMul(
        uint rhs
    )internal view returns(
        uint
    ){
        return block.number.mul(rhs);
    }
    /// @return {uint} current block number / `rhs`
    function nowBlockDiv(
        uint rhs
    )internal view returns(
        uint
    ){
        return block.number.div(rhs);
    }
    /// @return {uint} `lhs` / current block number
    function divNowBlock(
        uint lhs
    )internal view returns(
        uint
    ){
        return lhs.div(block.number);
    }
    /// @return {uint} current block number % `rhs`
    function nowBlockMod(
        uint rhs
    )internal view returns(
        uint
    ){
        return block.number.mod(rhs);
    }
    /// @return {uint} current block number % `rhs`
    function modNowBlock(
        uint lhs
    )internal view returns(
        uint
    ){
        return lhs.mod(block.number);
    }
    //2x in this future from this point past the epoch
    //function nowBlockLShift(
        //uint8 rhs
    //) internal pure returns(
        //uint
    //){
        //return block.number << rhs;
    //}
    //function nowBlockRShift(
        //uint8 rhs
    //) internal pure returns(
        //uint
    //){
        //return block.number >> rhs;
    //}
    //returns current block number + aprox blocks to be calculated in the future
    //function aproxBlockNumberFromNow(
        //uint futureTimestamp,
        //uint avgBlockDuration
    //)internal pure returns(
        //uint
    //){
        //avgBlockDuration.requireGreaterThanZero();
        ////require(futureTimestamp > block.timestamp);
        ////future block estimate based on timestamp, relative to now and the average blocks processed per seconds across the range of timestamps
        ////avgBlockDuration (in seconds) should be between 10-20 and should preferably be provided by an external oracle source
        //return block.number.add(
            ////aprox number of blocks rendered between future timestamp and now
            //futureTimestamp.aproxBlocksFromNow(avgBlockDuration)
        //);
    //}
    //returns current block number - aprox blocks which have been calculated
    //function aproxBlockNumberSinceNow(
        //uint pastTimestamp,
        //uint avgBlockDuration
    //)internal pure returns(
        //uint
    //){
        //avgBlockDuration.requireGreaterThanZero();
        ////now.requireGreatThan(pastTimestamp);
        ////past block estimate relative to now and the average blocks processed per second across the range of timestamps
        //return block.number.sub(
            ////aprox number of blocks rendered between now and past timestamp
            //pastTimestamp.aproxBlocksSinceNow(avgBlockDuration)
        //);
    //}
    /// impose default block solve duration of 15 seconds
    //function aproxBlockNumberFromNowDefault(
        //uint futureTimestamp
    //)internal pure returns(
        //uint
    //){
        //return aproxBlockNumberFromNow(
            //futureTimestamp,
            //15
        //);
    //}
    /// impose default block solve duration of 15 seconds
    //function aproxBlockNumberSinceNowDefault(
        //uint pastTimestamp
    //)internal pure returns(
        //uint
    //){
        //return aproxBlockNumberSinceNow(
            //pastTimestamp,
            //15
        //);
    //}
    //generate hash for one of the last 256 block (excluding current)
    function _blockHash(
        uint blockNumber
    )internal view returns(
        bytes32
    ){
        blockNumber.requireLessThan(block.number);
        blockNumber.requireGreaterThan(
            nowBlockSub(256)
        );
        
        return blockhash(blockNumber);
    }
    //function isMerkelProof(
        //uint blockNumber
    //)internal returns(
        //bool
    //){
        //guarentee this block number is present in the blockchain
        //failure of this function implies a network fork,
        //where block.number does not exist, invalidating the merkle proof
        //block
    //}
}