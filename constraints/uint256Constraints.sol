// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

import "https://github.com/vigilance91/solidarity/constraints/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/utils/uint256Logic.sol";

/// @title uint256 Contraints
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require),
/// for arithmetic operations on uint256 types, reverting EVM state on failure.
library uint256Constraints
{
    //using LogicConstraints for bool;
    using uint256Logic for uint256;
    
    function requireEqual(
        uint256 lhs,
        uint256 rhs
    )public pure
    {
        LogicConstraints.requireTrue(
            lhs.equal(rhs)
        );
    }
    
    function requireNotEqual(
        uint256 lhs,
        uint256 rhs
    )public pure
    {
        LogicConstraints.requireTrue(
            lhs.notEqual(rhs)
        );
    }
    //require lhs & rhs is not 0
    //function requireAnd(
        //int256 lhs,
        //int256 rhs
    //) public pure
    //{
        //LogicConstraints.requireTrue(
            //lhs.and(rhs) != 0
        //);
    //}
    //require lhs | rhs is not 0
    //function requireOr(
        //int256 lhs,
        //int256 rhs
    //) public pure
    //{
        //LogicConstraints.requireTrue(
            //lhs.or(rhs) != 0
        //);
    //}
    //function requireXor(
        //int256 lhs,
        //int256 rhs
    //) public pure
    //{
        //LogicConstraints.requireTrue(
            //lhs.xor(rhs) == 0
        //);
    //}
    //arithmetic equality operators
    /**
     * Greater Than > operators
    */
    function requireGreaterThan(
        uint256 lhs,
        uint256 rhs
    ) public pure
    {
        LogicConstraints.requireTrue(
            lhs.greaterThan(rhs)
        );
    }
    function requireGreaterThanOrEqualTo(
        uint256 lhs,
        uint256 rhs
    ) public pure
    {
        LogicConstraints.requireTrue(
            lhs.greaterThanOrEqualTo(rhs)
        );
    }
    function requireGreaterThanZero(
        uint256 lhs
    ) public pure
    {
        LogicConstraints.requireTrue(
            lhs.greaterThanZero()
        );
    }
    /**
     * Less Than < operators
    */
    function requireLessThan(
        uint256 lhs,
        uint256 rhs
    ) public pure
    {
        LogicConstraints.requireTrue(
            lhs.lessThan(rhs)
        );
    }
    function requireLessThanOrEqualTo(
        uint256 lhs,
        uint256 rhs
    ) public pure
    {
        LogicConstraints.requireTrue(
            lhs.lessThanOrEqualTo(rhs)
        );
    }
    //function requireLessThanMax(uint256 lhs) public pure{
        //requireLessThan(lhs, 0xFF);
    //}
}