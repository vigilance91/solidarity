// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/signed/int256Logic.sol";

/// @title int256 Contraints Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require),
/// for arithmetic operations on int256 types, reverting EVM state on failure.
library int256Constraints
{
    using LogicConstraints for bool;
    using int256Logic for int256;
    
    function requireEqual(
        int256 lhs,
        int256 rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            'not equal'
        );
    }
    
    function requireNotEqual(
        int256 lhs,
        int256 rhs
    )public pure
    {
        lhs.notEqual(rhs).requireTrue(
            'equal'
        );
    }
    function requireNotEqualToZero(
        int256 lhs
    )public pure
    {
        lhs.notEqualToZero().requireTrue(
            'equals 0'
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
    /**
     * Greater Than > Operatiors
    */
    function requireGreaterThan(
        int256 lhs,
        int256 rhs
    ) public pure
    {
        lhs.greaterThan(rhs).requireTrue(
            //''
        );
    }
    function requireGreaterThanOrEqual(
        int256 lhs,
        int256 rhs
    ) public pure
    {
        lhs.greaterThanOrEqualTo(rhs).requireTrue(
            //''
        );
    }
    function requireGreaterThanZero(
        int256 lhs
    ) public pure
    {
        lhs.greaterThanZero().requireTrue(
            //''
        );
    }
    function requireGreaterThanOrEqualToZero(
        int256 lhs
    ) public pure
    {
        lhs.greaterThanOrEqualToZero().requireTrue(
            //''
        );
    }
    /**
     * Less Than < Operatiors
    */
    function requireLessThan(
        int256 lhs,
        int256 rhs
    ) public pure
    {
        lhs.lessThan(rhs).requireTrue(
            //''
        );
    }
    function requireLessThanOrEqual(
        int256 lhs,
        int256 rhs
    ) public pure
    {
        lhs.lessThanOrEqualTo(rhs).requireTrue(
            //''
        );
    }
    function requireLessThanZero(
        int256 lhs
    ) public pure
    {
        lhs.lessThanZero().requireTrue(
            //'greater than or equal to 0'
        );
    }
    function requireLessThanOrEqualToZero(
        int256 lhs
    ) public pure
    {
        lhs.lessThanOrEqualToZero().requireTrue(
            //'greater than 0'
        );
    }
    //function requireLessThanMax(int256 lhs) public pure{
        //requireLessThan(lhs, 0x00);
    //}
    //function requireGreaterThanMin(int256 lhs) public pure{
        //requireGreaterThan(lhs, 0xFFFFF);
    //}
}