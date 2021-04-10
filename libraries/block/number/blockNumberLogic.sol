// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/unsigned/uint256Constraints.sol";
//import "Safemath.sol";
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
    )public pure returns(
        bool
    ){
        //block.number.lessThan(rhs);
        return block.number.sub(rhs);
    }
    /// @return {uint} total number of blocks, in the future, from the current block
    function blockNumberFutureDelta(
        uint lhs
    )public pure returns(
        bool
    ){
        //lhs.requireGreatThan(block.number);
        return lhs.sub(block.number);
    }
    /// @return {bool} (>) operator
    function blockNumberGreaterThan(
        uint rhs
    )public pure returns(
        bool
    ){
        return block.number.greaterThan(rhs);
    }
    /// @return {bool} (>=) operator
    function blockNumberGreaterThanOrEqual(
        uint rhs
    )public pure returns(
        bool
    ){
        return block.number.greaterThanOrEqual(rhs);
    }
    /// @return {bool} (<) operator
    function blockNumberLessThan(
        uint rhs
    )public pure returns(
        bool
    ){
        return block.number.lessThan(rhs);
    }
    /// @return {bool} (<=) operator
    function blockNumberLessThanOrEqual(
        uint rhs
    )public pure returns(
        bool
    ){
        return block.number.lessThanOrEqual(rhs);
    }
    ///
    /// intentionally omitted, operations not useful or trivial axioms
    ///
    //function blockNumberGreaterThanZero(
    //) public pure returns(
        //bool
    //){
        //return block.number.greaterThanZero();
    //}
    //function greaterThanMin(
        //uint lhs
    //) public pure returns(
        //bool
    //){
        //return block.number.requireLessThan(
            //type(uint).min
        //);
    //}
    //function lessThanMax(
        //uint lhs
    //) public pure returns(
        //bool
    //){
        //return block.number.requireLessThan(
            //type(uint).max
        //);
    //}
}