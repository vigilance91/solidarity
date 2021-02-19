// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

/// @title uint256 Logic Utilities
/// @author Tyler R. Drury - 19/2/2021, All Rights Reserved
/// @notice trivial library for logical or bitwise operations on uint256 not provided natively by Solidity.
library uint256Logic
{
    uint256 public constant ZERO = 0x0;
    //uint256 public constant MAX = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    
    function equal(
        uint256 lhs,
        uint256 rhs
    )public pure
        returns(bool)
    {
        //return lhs ^ rhs == 0;
        return lhs == rhs;
    }
    
    function notEqual(
        uint256 lhs,
        uint256 rhs
    )public pure
        returns(bool)
    {
        //return lhs ^ rhs != 0;
        return lhs != rhs;
    }
    
    function and(
        uint256 lhs,
        uint256 rhs
    )public pure
        returns(uint256)
    {
        return lhs & rhs;
    }
    function or(
        uint256 lhs,
        uint256 rhs
    )public pure
        returns(uint256)
    {
        return lhs | rhs;
    }
    function xor(
        uint256 lhs,
        uint256 rhs
    )public pure
        returns(uint256)
    {
        return lhs ^ rhs;
    }
    //function not(
        //uint256 lhs
    //)public pure
        //returns(uint256)
    //{
        //return !lhs;
    //}
    
    function greaterThan(
        uint256 lhs,
        uint256 rhs
    ) public pure
    {
        return lhs > rhs;
    }
    function greaterThanOrEqualTo(
        uint256 lhs,
        uint256 rhs
    ) public pure{
        return lhs >= rhs;
    }
    function lessThan(
        uint256 lhs,
        uint256 rhs
    ) public pure
    {
        return lhs < rhs;
    }
    function lessThanOrEqualTo(
        uint256 lhs,
        uint256 rhs
    ) public pure
    {
        return lhs <= rhs;
    }
    /**
     * Common convenience operations
    */
    function greaterThanZero(
        uint256 lhs
    ) public pure
    {
        return greaterThan(lhs, 0);
    }
    //function lessThanMax(uint256 lhs) public pure{
        //lessThan(lhs, 0xFF);
    //}
}