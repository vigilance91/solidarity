// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

/// @title uint256 Logic Library
/// @author Tyler R. Drury - 19/2/2021, All Rights Reserved
/// @notice trivial library for logical or bitwise operations on uint256 not provided natively by Solidity.
library uint256Logic
{
    uint256 public constant ZERO = 0x0;
    //uint256 public constant MAX = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    
    function equal(
        uint256 lhs,
        uint256 rhs
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := eq(lhs, rhs)
        }
    }
    
    function notEqual(
        uint256 lhs,
        uint256 rhs
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := not(eq(lhs, rhs))
        }
    }
    
    function _and(
        uint256 lhs,
        uint256 rhs
    )internal pure returns(
        uint256 ret
    ){
        assembly{
            ret := and(lhs, rhs)
        }
    }
    function _or(
        uint256 lhs,
        uint256 rhs
    )internal pure returns(
        uint256 ret
    ){
        assembly{
            ret := or(lhs, rhs)
        }
    }
    function _xor(
        uint256 lhs,
        uint256 rhs
    )public pure returns(
        uint256 ret
    ){
        assembly{
            ret := xor(lhs, rhs)
        }
    }
    //function not(
        //uint256 lhs
    //)public pure returns(
        //uint256
    //){
        //assembly{
            //ret := not(lhs)
        //}
    //}
    
    function greaterThan(
        uint256 lhs,
        uint256 rhs
    )public pure returns(
        bool ret
    ){
        assembly{
            ret := gt(lhs, rhs)
        }
    }
    function greaterThanOrEqual(
        uint256 lhs,
        uint256 rhs
    ) public pure returns(
        bool ret
    ){
        //return lhs >= rhs;
        assembly{
            ret := or(gt(lhs, rhs),eq(lhs,rhs))
        }
    }
    function lessThan(
        uint256 lhs,
        uint256 rhs
    )public pure returns(
        bool ret
    ){
        assembly{
            ret := lt(lhs, rhs)
        }
    }
    function lessThanOrEqual(
        uint256 lhs,
        uint256 rhs
    )public pure returns(
        bool ret
    ){
        assembly{
            ret := or(lt(lhs, rhs),eq(lhs,rhs))
        }
    }
    /**
     * Common convenience operations
    */
    function greaterThanZero(
        uint256 lhs
    ) public pure returns(
        bool ret
    ){
        assembly{
            ret := not(iszero(lhs))
        }
    }
    //function lessThanMax(
        //uint256 lhs
    //) public pure returns(
        //bool ret
    //){
        //return lessThan(lhs, 0xFF);
        //uint256 MAX = type(uint256).max;
        //assembly{
            //ret := lt(lhs, MAX)
        //}
    //}
}