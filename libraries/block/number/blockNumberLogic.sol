// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";
/// 
/// @title block.number Logic Library for use with the chronological generation of blocks on the blockchain
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 6/3/2021, All Rights Reserved
/// @notice logical operations on uint/block.number, not provided natively by Solidity
/// 
library blockNumberLogic
{
    using SafeMath for uint;
    
    using uint256Logic for uint;
    using uint256Constraints for uint;
    
    /// @return {uint} total number of blocks, in the past, since the current block
    function blockNumberPastDelta(
        uint rhs
    )internal view returns(
        uint
    ){
        if(block.number.greaterThan(rhs)){
            return 0;
        }
        
        return block.number.sub(rhs);
    }
    /// @return {uint} total number of blocks, in the future, from the current block
    function blockNumberFutureDelta(
        uint lhs
    )internal view returns(
        uint
    ){
        if(lhs.lessThan(block.number)){
            return 0;
        }
        
        return lhs.sub(block.number);
    }
    /// @return {bool} (>) operator
    function blockNumberGreaterThan(
        uint rhs
    )internal view returns(
        bool
    ){
        return block.number.greaterThan(rhs);
    }
    /// @return {bool} (>=) operator
    function blockNumberGreaterThanOrEqual(
        uint rhs
    )internal view returns(
        bool
    ){
        return block.number.greaterThanOrEqual(rhs);
    }
    /// @return {bool} (<) operator
    function blockNumberLessThan(
        uint rhs
    )internal view returns(
        bool
    ){
        return block.number.lessThan(rhs);
    }
    /// @return {bool} (<=) operator
    function blockNumberLessThanOrEqual(
        uint rhs
    )internal view returns(
        bool
    ){
        return block.number.lessThanOrEqual(rhs);
    }
    ///
    /// intentionally omitted, operations not useful or trivial axioms
    ///
    //function blockNumberGreaterThanZero(
    //)internal view returns(
        //bool
    //){
        //return block.number.greaterThanZero();
    //}
    //function greaterThanMin(
        //uint lhs
    //)internal view returns(
        //bool
    //){
        //return block.number.requireLessThan(
            //type(uint).min
        //);
    //}
    //function lessThanMax(
        //uint lhs
    //)internal view returns(
        //bool
    //){
        //return block.number.requireLessThan(
            //type(uint).max
        //);
    //}
    
    //function blockNumberInRange(
        //uint lhs
        //uint min,
        //uint max
    //)internal view returns(
        //bool
    //){
        //return block.number.inRange(
            //min
            //max
        //);
    //}
    
    //function blockNumberInXRange(
        //uint value,
        //uint min,
        //uint max
    //)internal view returns(
        //bool
    //){
        //return block.number.inXRange(
            //value,
            //min
            //max
        //);
    //}
}