// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "./uint256Logic.sol";
/// 
/// @title Utilities for block.timestamp
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/3/2021, All Rights Reserved
/// @notice specialized uint256 logic operations for block.timestamps, not provided natively by Solidity
/// 
library nowLogic
{
    using uint256Logic for uint;
    
    function nowGreaterThan(
        uint rhs
    )public pure returns(
        bool
    ){
        return block.timestamp.greaterThan(rhs);
    }
    function nowGreaterThanOrEqual(
        uint rhs
    )public pure returns(
        bool
    ){
        return block.timestamp.greaterThanOrEqual(rhs);
    }
    function nowLessThan(
        uint rhs
    )public pure returns(
        bool
    ){
        return block.timestamp.lessThan(rhs);
    }
    function nowLessThanOrEqual(
        uint rhs
    )public pure returns(
        bool
    ){
        return block.timestamp.lessThanOrEqual(rhs);
    }
    /**
    // Common convenience operations
    //
    function nowGreaterThanZero(
    )public pure returns(
        bool
    ){
        return block.timestamp.greaterThanZero();
    }
    //function lessThanMax(
        //uint lhs
    //) public pure returns(
        //bool
    //){
        //return block.timestamp.lessThanMax();
    //}
    */
}