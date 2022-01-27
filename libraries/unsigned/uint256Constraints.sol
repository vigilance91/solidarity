// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Logic.sol";
/// 
/// @title uint256 Contraints Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require),
/// for arithmetic operations on uint256 types, reverting EVM state on failure
/// 
library uint256Constraints
{
    using logicConstraints for bool;
    
    using uint256Logic for uint256;
    
    string private constant _NAME = "uint256Constraints: ";
    
    //string private constant _ERR_STR_MIN = ', min: ';
    //string private constant _ERR_STR_MAX = ', max: ';
    //string private constant _ERR_STR_MAX = ', value: ';
    
    string private constant _ERR_EQUAL = string(
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
    
    function requireEqual(
        uint256 lhs,
        uint256 rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            _ERR_NOT_EQUAL
        );
    }
    
    function requireNotEqual(
        uint256 lhs,
        uint256 rhs
    )public pure
    {
        lhs.notEqual(rhs).requireTrue(
            _ERR_EQUAL
        );
    }
    //require lhs & rhs is not 0
    //function requireAnd(
        //int256 lhs,
        //int256 rhs
    //) public pure
    //{
        //logicConstraints.requireTrue(
            //lhs.and(rhs) != 0
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
        //);
    //}
    //function requireXor(
        //int256 lhs,
        //int256 rhs
    //) public pure
    //{
        //logicConstraints.requireTrue(
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
        lhs.greaterThan(rhs).requireTrue(
            _ERR_LT_OR_EQ
        );
    }
    function requireGreaterThanOrEqual(
        uint256 lhs,
        uint256 rhs
    ) public pure
    {
        lhs.greaterThanOrEqual(rhs).requireTrue(
            _ERR_LT
        );
    }
    function requireGreaterThanZero(
        uint256 lhs
    )public pure
    {
        lhs.greaterThanZero().requireTrue(
            _ERR_IS_ZERO
        );
    }
    function requireIsZero(
        uint256 lhs
    )public pure
    {
        lhs.isZero().requireTrue(
            _ERR_IS_NOT_ZERO
        );
    }
    /**
     * Less Than < operators
    */
    function requireLessThan(
        uint256 lhs,
        uint256 rhs
    )public pure
    {
        lhs.lessThan(rhs).requireTrue(
            _ERR_GT_OR_EQ
        );
    }
    function requireLessThanOrEqual(
        uint256 lhs,
        uint256 rhs
    )public pure
    {
        lhs.lessThanOrEqual(rhs).requireTrue(
            _ERR_GT
        );
    }
    /// @dev require `lhs` is within the inclusive range between `min` and `max`
    function requireInRange(
        uint256 lhs,
        uint256 min,
        uint256 max
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
        uint256 lhs,
        uint256 min,
        uint256 max
    )public pure
    {
        lhs.inXRange(min, max).requireTrue(
            //string(
                //abi.encodePacked(
                    //_ERR_NOT_IN_XRANGE,
                    //_ERR_STR_MIN,
                    //min,
                    //_ERR_STR_MAX,
                    //MAX_VALUE,
                    //_ERR_STR_VALUE,
                    //lhs
                //)
            //)
        );
    }

    //function requireLessThanMax(uint256 lhs) public pure
    //{
        //requireLessThan(lhs, 0xFF);
    //}
}