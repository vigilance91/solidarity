// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/libraries/block/time/blockTimeMath.sol";
//import "https://github.com/vigilance91/solidarity/libraries/block/now/nowMath.sol";

import "https://github.com/vigilance91/solidarity/contracts/chrono/blockTime/blockTimeConstraintsABC.sol";
/// 
/// @title fully realized block timestamp based chonologic contract
/// @author Tyler R. Drury - 8/3/2021, All Rights Reserved
/// 
contract ExternalBlockTime is BlockTimeConstraintsABC
    //SafeMortalCanary
{
    using blockTimeLogic for uint;
    //using blockTimeConstraints for uint;
    
    using nowMath for uint;
    using blockNumberMath for uint;
    
    //blockTime.Storage public created;
    
    constructor(
    )public
        BlockTimeConstraints()
    {
        //created = blockTime.initialize();
    }
    function ageSeconds(
    )public returns(
        uint
    ){
        return created.time.nowSub();   //.add(_leapSeconds);
    }
    //number of block since creation
    function ageBlocks(
    )public returns(
        uint
    ){
        return created.blockNumber.blockNumberNowSub();
    }
    //number of block since creation
    //function now(
    //)public
        //returns(uint time, uint blockNumber)
    //{
        //return (now, block.number);
    //}
    
    function age(
    )public view returns(
        uint time,
        uint blockNumber
    ){
        return (
            ageSeconds(),
            ageBlocks()
        );
    }
    //function timepointUntil(
        //uint time
    //)public view returns(
        //uint timeUntil,
        //uint blockNumber
    //){
        //return (
            //_adjustedSecondsUntil(time),
            //_aproxBlocksUntil(time)
        //);
    //}
    //function timepointSince(
        //uint time
    //)public view returns(
        //uint timeSince,
        //uint blockNumber
    //){
        //return (
            //_adjustedSecondsSince(time),
            //_aproxBlocksSince(time)
        //);
    //}
    
    //
    //timestamp/seconds
    //
    
    //approximate time in seconds, in the past, between now and a specified timestamp
    function _adjustedSecondsSince(
        uint time
    )internal view returns(
        uint256
    ){
        return time.blockTimeAdjustedSecondsSince();    //.add(_leapSeconds);
    }
    //total time in seconds, in the future, between now and the timestamp specified
    function _averageSecondsUntil(
        uint lhs
    )internal view returns(
        bool
    ){
        return lhs.blockTimeAverageSecondsUntil(_avgBlockDuration); //.add(_leapSeconds);
    }
    
    function _averageSecondsUntil(
        uint tsFuture
    )internal view returns(
        uint
    ){
        //( (now + rhs) + (blocksInFuture * avgBlockDuration) ) / 2
        //if(tsFuture <= block.timestamp){
            //return 0;
        //}
        return tsFuture.blockTimeSecondsUntil(_averageBlockDuration).nowAdd();  //.add(_leapSeconds);
    }
    //aprox. time in seconds, in the past, from now relative to the block timestamp and an average of block solving duration supplied by a user
    //timestamp in past
    function _adjustedSecondsUntil(
        uint tsFuture
    )internal view returns(
        uint
    ){
        //if(tsPast >= block.timestamp){
            //return 0;
        //}
        
        return tsFuture.blockTimeSecondsUntil(_averageBlockDuration).nowSub();    //.add(_leapSeconds);
    }
    
    //aprox. time in seconds, in the future, from now relative to the block timestamp and an average of block solving duration supplied by a user
    //timestamp in future
    function _averageSecondsSince(
        uint tsPast
    )internal view returns(
        uint
    ){
        //( (now + rhs) + (blocksInFuture * avgBlockDuration) ) / 2
        return tsPast.adjustedSecondsSince(_avgBlockDuration);    //.add(_leapSeconds);
    }
    //aprox. time in seconds, in the past, from now relative to the block timestamp and an average of block solving duration supplied by a user
    //timestamp in past
    function _adjustedSecondsSince(
        uint tsPast
    )internal view returns(
        uint
    ){
        return tsPast.adjustedSecondsSince(_avgBlockDuration);  //.add(_leapSeconds);
    }
    /**
    *rhs and returns are in blocks
    
    function _adjustedSecondsSinceNow(
        uint tsPast
    )internal view returns(
        bool
    ){
        return tsPast.blocksSince(_avgBlockDuration).nowSub();
    }
    //total time in seconds, in the future, until the timestamp specified
    function _adjustedSecondsFromNow(
        uint tsFuture
    )internal view returns(
        bool
    ){
        return tsFuture.blocksUntil(_avgBlockDuration).nowAdd();
    }
    */
    /**
    *block number/height
    */
    //average number of blocks mined over lifespan
    //function blocksPerSecondAlive(
    //)public
        //returns(uint)
    //{
        //return ageBlocks().div(
            //ageSeconds()
        //);
    //}
    
    //aprox number of blocks, which have been mined in the past, between this block and the timestamp specified
    function _aproxBlocksSince(
        uint time
    )internal view returns(
        uint256
    ){
        return time.blockTimeAproxBlocksSince(_avgBlockDuration);
    }
    //aprox number of blocks, to be mined in the future, between this block and the timestamp specified
    function _aproxBlocksUntil(
        uint lhs
    )internal view returns(
        bool
    ){
        return lhs.blockTimeAproxBlocksUntil(_avgBlockDuration);
    }
    /**
    /// get the aprox. block number associated with the timestamp lhs, in the future otherwise 0
    function _aproxFutureBlockNumber(
        uint lhs
    )internal view returns(
        bool
    ){
        return lhs.blockTimeAproxFutureBlockNumber(_avgBlockDuration);
    }
    /// get aprox. block number associated with the timestamp lhs, in the past otherwise 0
    function _aproxPastBlockNumber(
        uint lhs
    )internal view returns(
        bool
    ){
        return lhs.blockTimeAproxPastBlockNumber(_avgBlockDuration);
    }
    */
    function _requirePreTime(
        uint time
    )internal view
    {
        secondsBefore(time).requireGreatherThanZero(
            //_NAME.concatenate("now block: ").concatenate(
                //block.number.decimal()
            //).concatenate(" must be greater than block number: ").concatenate(
                //blockNumber.decimal()
            //);
        );
    }
    //now block is after `blockNumber`
    function _requirePostTime(
        uint time
    )internal view
    {
        secondsSince(time).requireGreatherThanZero(
            //_NAME.concatenate("now block: ").concatenate(
                //block.number.decimal()
            //).concatenate(" must be greater than block number: ").concatenate(
                //blockNumber.decimal()
            //);
        );
    }
    /// 
    /// @dev require this contract's age to be less than `ageSeconds`
    /// 
    function _requirePreAge(
        uint ageSeconds
    )internal
    {
        uint A = age();
        
        //BA.requireLessThan(
            //blocks
            //_NAME.concatenate("blockAge: ").concatenate(
                //BA.decimal()
            //).concatenate(" must be less than blocks: ").concatenate(
                //blocks.decimal()
            //)
        //);
        
        ageSeconds.requireGreaterThan(A);
    }
    ///
    /// @dev require this contract's age to be greater than `ageSeconds`
    /// `blocks` is time period in number of blocks which have been mined since this contract was created
    /// eg, ensure an action can only be carried out withing the first 30,00 blocks of this contract's deployment:
    ///    _requireNowPreBlockAge(3000);
    ///
    function _requirePostAge(
        uint ageSeconds
    )internal
    {
        uint A = age();
        //
        //A.requireGreaterThan(
            //seconds
            //_NAME.concatenate("age must be greater than seconds: ").concatenate(
                //blocks.decimal()
            //)
        //);
        
        A.requireGreaterThan(ageSeconds);
    }
}