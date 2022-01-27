// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/block/number/blockNumberMath.sol";

import "https://github.com/vigilance91/solidarity/contracts/chrono/blockHeight/BlockNumberConstraintsABC.sol";
/// 
/// @title block based chonologic Contract
/// @author Tyler R. Drury - 8/3/2021, All Rights Reserved
/// @dev note you can get a rough estimate of how long an opertaion will take based
/// in the average of 15 blocks per second or 1/15 seconds per 1 block
/// thus:
///     seconds = number of blocks / 15 secondsPerBlock
/// 
contract ExternalBlockHeight is BlockNumberConstraintsABC
    //SafeMortalCanary
    //iBlockHeight
{
    using blockTimeLogic for uint;
    //using blockTimeConstraints for uint;
    
    //using nowMath for uint;
    using blockNumberMath for uint;
    
    uint private _createdBlock;
    //struct blockNumberStorage{
        //uint _createdBlock;
        //bytes32 createdBlockHash;
        //string createdBlockHex;
        //
        //uint8 internal avgBlockDuration; // = 15;
    //}
    
    constructor(
    )public
        BlockNumberConstraintsABC()
    {
        //created = blockTime.initialize();
        _createdBlock = block.number;
        //_createdBlock = keccak256(
            //abi.encodePacked(block.number)
        //);
        //_createdBlockHash = _thisHex.concatenate(
            //block.number.hexadecimal()
        //).hash();
        
        //_setBlockSolveDuration(
            //15  //averageBlockDuration
        //);
    }
    //now block is before `blockNumber`
    function _requirePreBlock(
        uint blockNumber
    )internal view
    {
        blocksUntil(blockNumber).requireGreatherThanZero(
            //_NAME.concatenate("now block: ").concatenate(
                //block.number.decimal()
            //).concatenate(" must be less than block number: ").concatenate(
                //blockNumber.decimal()
            //)
        );
    }
    //now block is after `blockNumber`
    function _requirePostBlock(
        uint blockNumber
    )internal view
    {
        blocksSince(blockNumber).requireGreatherThanZero(
            //_NAME.concatenate("now block: ").concatenate(
                //block.number.decimal()
            //).concatenate(" must be greater than block number: ").concatenate(
                //blockNumber.decimal()
            //);
        );
    }
    function _requirePreBlockAge(
        uint blocks
    )internal
    {
        uint BA = blockAge();
        
        //BA.requireLessThan(
            //blocks
            //_NAME.concatenate("blockAge: ").concatenate(
                //BA.decimal()
            //).concatenate(" must be less than blocks: ").concatenate(
                //blocks.decimal()
            //)
        //);
        
        blocks.sub(BA).requireGreaterThanZero();
    }
    //
    //`blocks` is time period in number of blocks which have been mined since this contract was created
    //eg, ensure an action can only be carried out withing the first 30,00 blocks of this contract's deployment:
    //    _requireNowPreBlockAge(3000);
    //
    function _requirePostBlockAge(
        uint blocks
    )internal
    {
        uint BA = blockAge();
        //
        //BA.requireGreaterThan(
            //blocks
            //_NAME.concatenate("blockAge must be greater than blocks: ").concatenate(
                //blocks.decimal()
            //)
        //);
        
        BA.sub(blocks).requireGreaterThanZero();
    }
    //
    //function averageBlockSolveDuration(
    //)public view returns(
        //uint8
    //){
        //return _avgBlockDuration;
    //}
    //number of block since creation
    //function nowBlock(
    //)public view returns(
        //uint
    //){
        //return block.number;
    //}
    
    function createdBlock(
    )public view returns(
        uint
    ){
        return _createdBlock;
    }
    //function nowBlockHash(
    //)public view returns(
        //uint
    //){
        //return keccak256(
            //abi.encodePacked(block.number)
        //);
    //}
    //number of block since creation
    function blockAge(
    )public returns(
        uint
    ){
        return created.blockNumber.nowBlockSub();
    }
    function blocksUntil(
        uint blockNumber
    )public view returns(
        uint
    ){
        return blockNumber.subNowBlock();
    }
    function blocksSince(
        uint blockNumber
    )public view returns(
        uint
    ){
        return blockNumber.nowBlockSub();
    }
    //
    // past, between now and a specified timestamp
    function _adjustedSecondsSince(
        uint blockNumber
    )internal view returns(
        uint256
    ){
        return blockNumber.blockTimeAdjustedSecondsSince(
            _avgBlockDuration
        );
    }
    //total time in seconds, in the future, between now and the timestamp specified
    function _averageSecondsUntil(
        uint blockNumber
    )internal view returns(
        bool
    ){
        return blockNumber.blockTimeAverageSecondsUntil(
            _avgBlockDuration
        ); //.add(_leapSeconds);
    }
    
    function _averageSecondsUntil(
        uint blockNumber
    )internal view returns(
        uint
    ){
        //( (now + rhs) + (blocksInFuture * avgBlockDuration) ) / 2
        //if(tsFuture <= block.timestamp){
            //return 0;
        //}
        return blockNumber.blockTimeSecondsUntil(
            _averageBlockDuration
        ).nowBlockAdd();  //.add(_leapSeconds);
    }
    //aprox. time in seconds, in the past, from now relative to the block timestamp and an average of block solving duration supplied by a user
    //timestamp in past
    function _adjustedSecondsSince(
        uint blockNumber
    )internal view returns(
        uint
    ){
        //if(tsPast >= block.timestamp){
            //return 0;
        //}
        
        return blockNumber.blockTimeSecondsSince(
            _averageBlockDuration
        ).nowBlockSub();
    }
    
    //aprox. time in seconds, in the future, from now relative to the block timestamp and an average of block solving duration supplied by a user
    //timestamp in future
    function _averageSecondsUntil(
        uint blockNumber
    )internal view returns(
        uint
    ){
        //( (now + rhs) + (blocksInFuture * avgBlockDuration) ) / 2
        return blockNumber.adjustedSecondsUntil(_avgBlockDuration);    //.add(_leapSeconds);
    }
    //aprox. time in seconds, in the past, from now relative to the block timestamp and an average of block solving duration supplied by a user
    //timestamp in past
    function _adjustedSecondsSince(
        uint blockNumber
    )internal view returns(
        uint
    ){
        return blockNumber.adjustedSecondsSince(_avgBlockDuration);  //.add(_leapSeconds);
    }
    /**
    *rhs and returns are in blocks
    
    function _adjustedSecondsSinceNowBlock(
        uint blockNumber
    )internal view returns(
        bool
    ){
        return blockNumber.blocksSince(
            _avgBlockDuration
        ).nowBlockSub();
    }
    //total time in seconds, in the future, until the timestamp specified
    function _adjustedSecondsFromNowBlock(
        uint blockNumber
    )internal view returns(
        bool
    ){
        return blockNumber.blocksUntil(
            _avgBlockDuration
        ).nowBlockAdd();
    }
    */
    /**
    *block number/height
    */
    //average number of blocks mined over lifespan
    //function blocksPerSecondAlive(
    //)public returns(
        //uint,
        //uint
    //){
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
}