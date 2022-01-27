// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";
/// 
/// @title block.timestamp Contraints
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/3/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require),
/// based on chronological operations on block.timestamp/now, reverting EVM state on failure
///
library nowConstraints
{
    //now is same as block.timestamp
    //using logicConstraints for bool;
    using uint256Constraints for uint;
    
    //string private constant _NAME = " - nowConstraints: ";
    
    //require now greater than (>) `rhs`
    function requireNowGreaterThan(
        uint rhs
    )internal view
    {
        block.timestamp.requireGreaterThan(rhs);
    }
    //require now greater Than or equal to (>=) `rhs`
    function requireNowGreaterThanOrEqual(
        uint rhs
    )internal view
    {
        block.timestamp.requireGreaterThanOrEqual(rhs);
    }
    //require now less than (<) `rhs`
    function requireNowLessThan(
        uint rhs
    )internal view
    {
        block.timestamp.requireLessThan(rhs);
    }
    //require now greater than or equal to (<=) `rhs`
    function requireNowLessThanOrEqual(
        uint rhs
    )internal view
    {
        block.timestamp.requireLessThanOrEqual(rhs);
    }
    //function requireLessThanMax(uint lhs) public pure{
        //requireLessThan(lhs, 0xFF);
    //}
    /**
    //trivial not very useful
    //function requireNowGreaterThanZero(
    //) public pure
    //{
        //block.timestamp.requireGreaterThanZero()
    //}
    
    function requireNowEqual(
        uint rhs
    )internal pure
    {
        block.timestamp.requireEqual(rhs);
    }
    function requireNowNotEqual(
        uint rhs
    )internal pure
    {
        block.timestamp.requireNotEqual(rhs);
    }
    
    function requireNowGreaterThanMin(
        uint rhs
    )internal pure
    {
        block.timestamp.requireGreaterThan(type(uint).min);
    }
    function requireNowLessThanMax(
        uint rhs
    )internal pure
    {
        block.timestamp.requireLessThan(type(uint).max);
    }
    */
}