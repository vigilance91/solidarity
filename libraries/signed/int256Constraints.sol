// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/signed/int256Logic.sol";

/// @title int256 Contraints Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require),
/// for arithmetic operations on int256 types, reverting EVM state on failure
library int256Constraints
{
    using LogicConstraints for bool;
    using int256Logic for int256;
    
    //string private constant _NAME = " int256Constraints: ";
    
    function requireEqual(
        int256 lhs,
        int256 rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            //LIB_NAME
        );
    }
    
    function requireNotEqual(
        int256 lhs,
        int256 rhs
    )public pure
    {
        lhs.equal(rhs).requireFalse(
            //LIB_NAME    //.concatenate('equal')
        );
    }
    function requireNotEqualToZero(
        int256 lhs
    )public pure
    {
        lhs.notEqualToZero().requireTrue(
            //LIB_NAME    //.concatenate('equals 0')
        );
    }
    //require lhs & rhs is not 0
    //function requireAnd(
        //int256 lhs,
        //int256 rhs
    //) public pure
    //{
        //LogicConstraints.requireTrue(
            //lhs.and(rhs) != 0,
            ////LIB_NAME    //.concatenate('');
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
            ////LIB_NAME    //.concatenate('');
        //);
    //}
    //function requireXor(
        //int256 lhs,
        //int256 rhs
    //) public pure
    //{
        //LogicConstraints.requireTrue(
            //lhs.xor(rhs) == 0
            ////LIB_NAME    //.concatenate('');
        //);
    //}
    /**
     * Greater Than > Operatiors
    */
    function requireGreaterThan(
        int256 lhs,
        int256 rhs
    )public pure
    {
        lhs.greaterThan(rhs).requireTrue(
            //LIB_NAME    //.concatenate("lhs not great than rhs")
        );
    }
    function requireGreaterThanOrEqual(
        int256 lhs,
        int256 rhs
    )public pure
    {
        lhs.greaterThanOrEqual(rhs).requireTrue(
            //LIB_NAME    //.concatenate("lhs < rhs"
        );
    }
    function requireGreaterThanZero(
        int256 lhs
    )public pure
    {
        lhs.greaterThanZero().requireTrue(
            //LIB_NAME    //.concatenate('');
        );
    }
    function requireGreaterThanOrEqualToZero(
        int256 lhs
    )public pure
    {
        lhs.greaterThanOrEqualToZero().requireTrue(
            //LIB_NAME    //.concatenate('');
        );
    }
    /**
     * Less Than < Operatiors
    */
    function requireLessThan(
        int256 lhs,
        int256 rhs
    )public pure
    {
        lhs.lessThan(rhs).requireTrue(
            //LIB_NAME    //.concatenate('');
        );
    }
    function requireLessThanOrEqual(
        int256 lhs,
        int256 rhs
    )public pure
    {
        lhs.lessThanOrEqual(rhs).requireTrue(
            //LIB_NAME    //.concatenate('');
        );
    }
    function requireLessThanZero(
        int256 lhs
    )public pure
    {
        lhs.lessThanZero().requireTrue(
            //LIB_NAME    //.concatenate('greater than or equal to 0');
        );
    }
    function requireLessThanOrEqualToZero(
        int256 lhs
    )public pure
    {
        lhs.lessThanOrEqualToZero().requireTrue(
            //LIB_NAME    //.concatenate(''greater than 0');
        );
    }
    //function requireLessThanMax(
        //int256 lhs
    //)public pure
    //{
        //requireLessTMax(lhs, 0x00);
    //}
    //function requireGreaterThanMin(
        //int256 lhs
    //)public pure
    //{
        //requireGreaterMin(lhs, 0xFFFFF);
    //}
}