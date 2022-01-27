// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/signed/int256Logic.sol";
/// 
/// @title int256 Contraints Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require),
/// for arithmetic operations on int256 types, reverting EVM state on failure
/// 
library int256Constraints
{
    using logicConstraints for bool;
    
    using int256Logic for int256;
    
    string private constant _NAME = " int256Constraints: ";
    
    //string private constant _ERR_STR_MIN = ', min: ';
    //string private constant _ERR_STR_MAX = ', max: ';
    //string private constant _ERR_STR_MAX = ', value: ';
    
    string private constant _ERR_NOT_EQUAL = string(
        abi.encodePacked(
            _NAME,
            '=='
        )
    );
    
    string private constant _ERR_NOT_EQUAL = string(
        abi.encodePacked(
            _NAME,
            '!='
        )
    );
    
    string private constant _ERR_GT = string(
        abi.encodePacked(
            _NAME,
            '>'
        )
    );
    
    string private constant _ERR_GT_OR_EQ = string(
        abi.encodePacked(
            _NAME,
            '>='
        )
    );
    
    string private constant _ERR_LT = string(
        abi.encodePacked(
            _NAME,
            '<'
        )
    );
    
    string private constant _ERR_LT_OR_EQ = string(
        abi.encodePacked(
            _NAME,
            '<='
        )
    );
    
    string private constant _ERR_IS_ZERO = string(
        abi.encodePacked(
            _NAME,
            '== 0'
        )
    );
    
    string private constant _ERR_IS_NOT_ZERO = string(
        abi.encodePacked(
            _NAME,
            '!= 0'
        )
    );
    
    string private constant _ERR_GT_ZERO = string(
        abi.encodePacked(
            _NAME,
            '> 0'
        )
    );
    
    string private constant _ERR_LT_ZERO = string(
        abi.encodePacked(
            _NAME,
            '< 0'
        )
    );
    
    function requireEqual(
        int256 lhs,
        int256 rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            _ERR_NOT_EQUAL
        );
    }
    
    function requireNotEqual(
        int256 lhs,
        int256 rhs
    )public pure
    {
        lhs.equal(rhs).requireFalse(
            _ERR_EQUAL
        );
    }
    function requireNotEqualToZero(
        int256 lhs
    )public pure
    {
        lhs.notEqualToZero().requireTrue(
            //_ERR_IS_ZERO
        );
    }
    //require lhs & rhs is not 0
    //function requireAnd(
        //int256 lhs,
        //int256 rhs
    //) public pure
    //{
        //logicConstraints.requireTrue(
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
        //logicConstraints.requireTrue(
            //lhs.or(rhs) != 0
            ////LIB_NAME    //.concatenate('');
        //);
    //}
    //function requireXor(
        //int256 lhs,
        //int256 rhs
    //) public pure
    //{
        //logicConstraints.requireTrue(
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
            _ERR_LT_OR_EQ
        );
    }
    function requireGreaterThanOrEqual(
        int256 lhs,
        int256 rhs
    )public pure
    {
        lhs.greaterThanOrEqual(rhs).requireTrue(
            _ERR_LT
        );
    }
    function requireGreaterThanZero(
        int256 lhs
    )public pure
    {
        lhs.greaterThanZero().requireTrue(
            //_NAME
        );
    }
    function requireGreaterThanOrEqualToZero(
        int256 lhs
    )public pure
    {
        lhs.greaterThanOrEqualToZero().requireTrue(
            //_NAME
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
            _ERR_GT_OR_EQ
        );
    }
    function requireLessThanOrEqual(
        int256 lhs,
        int256 rhs
    )public pure
    {
        lhs.lessThanOrEqual(rhs).requireTrue(
            _ERR_GT
        );
    }
    function requireLessThanZero(
        int256 lhs
    )public pure
    {
        lhs.lessThanZero().requireTrue(
            //_NAME    //.concatenate('greater than or equal to 0');
        );
    }
    function requireLessThanOrEqualToZero(
        int256 lhs
    )public pure
    {
        lhs.lessThanOrEqualToZero().requireTrue(
            //_NAME    //.concatenate(''greater than 0');
        );
    }
    //function requireLessThanMax(
        //int256 lhs
    //)public pure
    //{
        //requireLessThanMax(lhs, 0x00);
    //}
    //function requireGreaterThanMin(
        //int256 lhs
    //)public pure
    //{
        //requireGreaterThanMin(lhs, 0xFFFFF);
    //}
    /// @dev require `lhs` is within the inclusive range between `min` and `max`
    function requireInRange(
        int256 lhs,
        int256 min,
        int256 max
    )public pure
    {
        lhs.inRange(min, max).requireTrue(
            //string(
                //abi.encodePacked(
                    //_ERR_NOT_IN_RANGE,
                    //_ERR_STR_MIN,
                    //min,
                    //_ERR_STR_MAX,
                    //max,
                    //_ERR_STR_VALUE,
                    //lhs
                //)
            //)
        );
    }
    /// @dev require `lhs` is within the exclusive range between `min` and `max`
    function requireInXRange(
        int256 lhs,
        int256 min,
        int256 max
    )public pure
    {
        lhs.inXRange(min, max).requireTrue(
            //string(
                //abi.encodePacked(
                    //_ERR_NOT_IN_RANGE,
                    //_ERR_STR_MIN,
                    //min,
                    //_ERR_STR_MAX,
                    //max,
                    //_ERR_STR_VALUE,
                    //lhs
                //)
            //)
        );
    }
}