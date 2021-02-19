// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

/// @title int256 Logic Utilities
/// @author Tyler R. Drury - 19/2/2021, All Rights Reserved
/// @notice trivial library for logical or bitwise operations on int256 not provided natively by Solidity.
library int256Logic
{
    int256 public constant ZERO = 0x0;
    //int256 public constant MIN = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    //int256 public constant MAX = 0x;
    
    function equal(
        int256 lhs,
        int256 rhs
    )public pure
        returns(bool)
    {
        //return lhs ^ rhs == 0;
        return lhs == rhs;
    }
    
    function notEqual(
        int256 lhs,
        int256 rhs
    )public pure
        returns(bool)
    {
        //return lhs ^ rhs != 0;
        return lhs != rhs;
    }
    
    function notEqualToZero(
        int256 lhs
    )public pure
        returns(bool)
    {
        return lhs != ZERO;
    }
    
    function and(
        int256 lhs,
        int256 rhs
    )public pure
        returns(int256)
    {
        return lhs & rhs;
    }
    function or(
        int256 lhs,
        int256 rhs
    )public pure
        returns(int256)
    {
        return lhs | rhs;
    }
    function xor(
        int256 lhs,
        int256 rhs
    )public pure
        returns(int256)
    {
        return lhs ^ rhs;
    }
    //function not(
        //int256 lhs
    //)public pure
        //returns(int256)
    //{
        //return !lhs;
    //}
    /**
     * Greater Than > operatiors
    */
    function greaterThan(
        int256 lhs,
        int256 rhs
    ) public pure
        returns(bool)
    {
        return lhs > rhs;
    }
    function greaterThanOrEqualTo(
        int256 lhs,
        int256 rhs
    ) public pure
        returns(bool)
    {
        return lhs >= rhs;
    }
    function greaterThanZero(
        int256 lhs
    ) public pure
        returns(bool)
    {
        return greaterThan(lhs, ZERO);
    }
    function greaterThanOrEqualToZero(
        int256 lhs
    ) public pure
        returns(bool)
    {
        return greaterThanOrEqualTo(lhs, ZERO);
    }
    /**
     * Less Than < operatiors
    */
    function lessThan(
        int256 lhs,
        int256 rhs
    ) public pure
        returns(bool)
    {
        return lhs < rhs;
    }
    function lessThanOrEqualTo(
        int256 lhs,
        int256 rhs
    ) public pure
        returns(bool)
    {
        return lhs <= rhs;
    }
    function lessThanZero(
        int256 lhs
    ) public pure
        returns(bool)
    {
        return lessThan(lhs, ZERO);
    }
    function lessThanOrEqualToZero(
        int256 lhs
    ) public pure
        returns(bool)
    {
        return lessThanOrEqualTo(lhs, ZERO);
    }
    //function lessThanMax(
        //int256 lhs
    //) public pure
        //returns(bool)
    //{
        //return lessThan(lhs, 0xFF);
    //}
    //function greaterThanMin(
        //int256 lhs
    //) public pure
        //returns(bool)
    //{
        //greaterThan(lhs, 0xFF);
    //}
}