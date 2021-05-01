// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

/// @title int256 Logic Utilities
/// @author Tyler R. Drury - 19/2/2021, All Rights Reserved
/// @notice trivial library for logical or bitwise operations on int256 not provided natively by Solidity.
library int256Logic
{
    int256 public constant ZERO = 0x0;
    //int256 public constant MIN = type(int256).min;
    //int256 public constant MAX = type(int256).max;
    
    function equal(
        int256 lhs,
        int256 rhs
    )internal pure returns(
        bool
    ){
        //return lhs ^ rhs == 0;
        return lhs == rhs;
    }
    
    function notEqual(
        int256 lhs,
        int256 rhs
    )internal pure returns(
        bool
    ){
        //return lhs ^ rhs != 0;
        return lhs != rhs;
    }
    
    function notEqualToZero(
        int256 lhs
    )internal pure returns(
        bool
    ){
        return lhs != ZERO;
    }
    
    function _and(
        int256 lhs,
        int256 rhs
    )internal pure returns(
        int256 ret
    ){
        assembly{
            ret := and(lhs, rhs)
        }
    }
    function _or(
        int256 lhs,
        int256 rhs
    )internal pure returns(
        int256 ret
    ){
        assembly{
            ret := or(lhs, rhs)
        }
    }
    function _xor(
        int256 lhs,
        int256 rhs
    )internal pure returns(
        int256 ret
    ){
        assembly{
            ret := xor(lhs, rhs)
        }
    }
    //function not(
        //int256 lhs
    //)public pure returns(
        //int256 ret
    //){
        //ret := not(lhs)
    //}
    /**
     * Greater Than > operatiors
    */
    function greaterThan(
        int256 lhs,
        int256 rhs
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := sgt(lhs, rhs)
        }
    }
    function greaterThanOrEqual(
        int256 lhs,
        int256 rhs
    )internal pure returns(
        bool
    ){
        return lhs >= rhs;
    }
    function greaterThanZero(
        int256 lhs
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := sgt(lhs,0)
        }
    }
    function greaterThanOrEqualToZero(
        int256 lhs
    )internal pure returns(
        bool
    ){
        return greaterThanOrEqual(lhs, ZERO);
    }
    /**
     * Less Than < operatiors
    */
    function lessThan(
        int256 lhs,
        int256 rhs
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := slt(lhs,rhs)
        }
    }
    function lessThanOrEqual(
        int256 lhs,
        int256 rhs
    )internal pure returns(
        bool
    ){
        return lhs <= rhs;
    }
    function lessThanZero(
        int256 lhs
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := slt(lhs,0)
        }
    }
    function lessThanOrEqualToZero(
        int256 lhs
    ) public pure returns(
        bool
    ){
        return lessThanOrEqual(lhs, ZERO);
    }
    //function lessThanMax(
        //int256 lhs
    //) public pure returns(
        //bool
    //){
        //assembly{
            //ret := slt(lhs, MAX)
        //}
    //}
    //function greaterThanMin(
        //int256 lhs
    //) public pure
        //returns(bool)
    //{
        //assembly{
            //ret := sgt(lhs, MIN)
        //}
    //}
}