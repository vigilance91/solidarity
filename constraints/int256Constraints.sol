// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

import "https://github.com/vigilance91/solidarity/constraints/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/utils/int256Logic.sol";

/// @title int256 Contraints
/// @author Tyler R. Drury - 3/1/2021, ALl Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require),
/// for arithmetic operations on int256 types, reverting EVM state on failure.
library int256Constraints
{
    //using LogicConstraints for bool;
    using int256Logic for int256;
    
    function requireEqual(
        int256 lhs,
        int256 rhs
    )public pure
    {
        LogicConstraints.requireTrue(
            lhs.equal(rhs)
        );
    }
    
    function requireNotEqual(
        int256 lhs,
        int256 rhs
    )public pure
    {
        LogicConstraints.requireTrue(
            lhs.notEqual(rhs)
        );
    }
    function requireNotEqualToZero(
        int256 lhs
    )public pure
    {
        LogicConstraints.requireTrue(
            lhs.notEqualToZero()
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
        LogicConstraints.requireTrue(
            lhs.greaterThan(rhs)
        );
    }
    function requireGreaterThanOrEqualTo(
        int256 lhs,
        int256 rhs
    ) public pure
    {
        LogicConstraints.requireTrue(
            lhs.greaterThanOrEqualTo(rhs)
        );
    }
    function requireGreaterThanZero(
        int256 lhs
    ) public pure
    {
        LogicConstraints.requireTrue(
            lhs.greaterThanZero()
        );
    }
    function requireGreaterThanOrEqualToZero(
        int256 lhs
    ) public pure
    {
        LogicConstraints.requireTrue(
            lhs.greaterThanOrEqualToZero()
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
        LogicConstraints.requireTrue(
            lhs.lessThan(rhs)
        );
    }
    function requireLessThanOrEqualTo(
        int256 lhs,
        int256 rhs
    ) public pure
    {
        LogicConstraints.requireTrue(
            lhs.lessThanOrEqualTo(rhs)
        );
    }
    function requireLessThanZero(
        int256 lhs
    ) public pure
    {
        LogicConstraints.requireTrue(
            lhs.lessThanZero()
        );
    }
    function requireLessThanOrEqualToZero(
        int256 lhs
    ) public pure
    {
        LogicConstraints.requireTrue(
            lhs.lessThanOrEqualToZero()
        );
    }
    //function requireLessThanMax(int256 lhs) public pure{
        //requireLessThan(lhs, 0x00);
    //}
    //function requireGreaterThanMin(int256 lhs) public pure{
        //requireGreaterThan(lhs, 0xFFFFF);
    //}
}