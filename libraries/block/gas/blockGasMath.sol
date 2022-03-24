// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/block/gas/blockGasLogic.sol";
/// 
/// @title gas/gasleft() Assembly and Utility Math Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 27/4/2021, All Rights Reserved
/// @notice math operations specialized for block.timestamp
/// 
library blockGasMath
{
    //using uint256SafeMath for uint;
    
    using SafeMath for uint;
    //using blockGasLogic for uint;
    
    uint private constant _MIN_GAS = 21000;   //approximate gas consumed by executing gasLeft function
    
    //function remaining(
    //)internal pure returns(
        //uint ret
    //){
        //assembly{
            //ret := gas()
        //}
    //}
    
    function limit(
    )internal pure returns(
        uint ret
    ){
        assembly{
            ret := gaslimit()
        }
    }
    
    function price(
    )internal pure returns(
        uint ret
    ){
        assembly{
            ret := gasprice()
        }
    }
    
    //function gasLessThanOrEqualToLimit(
    //)internal pure returns(
        //uint ret
    //){
        //return remaining() <= limit();
    //}
    /// @return {uint} total time, in seconds, in the past, since a specified timestamp
    function gasDelta(
        uint rhs
    )internal pure returns(
        uint
    ){
        ////rhs.requireLessThan();
        assembly{
            ret := sub(gas(), rhs)
        }
    }
    /// @return {uint} now + `rhs`, timestamp, in seconds, in the future
    function gasLeftAdd(
        uint rhs
    )internal pure returns(
        uint ret
    ){
        assembly{
            ret := add(gas(), rhs)
        }
    }
    /// @return {uint} now - `rhs`, timestamp, in seconds, in the future
    function gasLeftSub(
        uint rhs
    )internal pure returns(
        uint ret
    ){
        assembly{
            ret := sub(gas(), rhs)
        }
    }
    /// @return {uint} `lhs` - now, timestamp, in seconds, in the future
    //function subGasLeft(
        //uint lhs
    //)internal pure returns(
        //uint
    //){
        //assembly{
            //ret := sub(lhs, gas())
        //}
    //}
    /// @return {uint} now * `rhs`, timestamp, in seconds, in the future
    function gasLeftMul(
        uint rhs
    )internal pure returns(
        uint ret
    ){
        assembly{
            ret := mul(gas(), rhs)
        }
    }
    /// @return {uint} now / `rhs`, timestamp, in seconds, in the future
    function gasLeftDiv(
        uint rhs
    )internal pure returns(
        uint
    ){
        assembly{
            ret := div(gas(), rhs)
        }
    }
    /// @return {uint} now % `rhs`, timestamp, in seconds, in the future
    function gasLeftMod(
        uint rhs
    )internal pure returns(
        uint
    ){
        assembly{
            ret := mod(gas(), rhs)
        }
    }
    //function gasLeftLShift(
        //uint8 rhs
    //)internal pure returns(
        //uint ret
    //){
        //assembly{
            //ret := shl(gas(), rhs)
        //}
    //}
    //function gasLeftRShift(
        //uint8 rhs
    //)internal pure returns(
        //uint ret
    //){
        //assembly{
            //ret := shr(gas(), rhs)
        //}
    //}
    
    //uint256 gasStart = gasleft();
    //_;
    function gasSpent(
        uint initialGas
        //uint256 dataGasFactor,
        //uint256 dataLength
    )internal pure returns(
        uint
    ){
        uint GR = gasleft();
        uint _dataFactor = 16;
        
        return MIN_GAS.add(
            initialGas.sub(GR)
        ).add(
            _dataFactor.mul(msg.data.length)    //msg.data.length affects gas consumption, requiring 16 gas per byte of data in transaction
        );  //price();  //???
    }
    //freeFromUpTo(
        //msg.sender,
        //(gasSpent + 14154) / 41947
    //);
}