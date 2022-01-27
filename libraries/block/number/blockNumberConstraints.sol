// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/unsigned/uint256Constraints.sol";
/// 
/// @title block.number Contraints
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/3/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require),
/// based on the chronological progression of block generation
/// based on the current block.number,
/// reverting EVM state on failure and discarding such block
///
library blockNumberConstraints
{
    using uint256Constraints for uint;
    
    //string private constant _NAME = " - blockNumberConstraints: ";
    
    //require greater Than (>) operators, for requiring transactions to be performed only after a specific block height has been reached
    function requireBlockNumberGreaterThan(
        uint rhs
    )internal pure
    {
        block.number.requireGreaterThan(rhs);
    }
    //require greater than or equal (>=) operator, preventing transactions being performed until a certain block height or higher is reached
    function requireBlockNumberGreaterThanOrEqual(
        uint rhs
    )internal pure
    {
        block.number.requireGreaterThanOrEqual(rhs);
    }
    //require less Than (<) operator, preventing transactions being performed after a certain block height is reached
    function requireBlockNumberLessThan(
        uint rhs
    )internal pure
    {
        block.number.requireLessThan(rhs);
    }
    //require less than or euqal to (<=) operator, preventing transactions being performed after a certain block height or higher is reached
    function requireBlockNumberLessThanOrEqual(
        uint rhs
    )internal pure
    {
        block.number.requireLessThanOrEqual(rhs);
    }
    /**
    * trivial not very useful
    //function requireNowGreaterThanZero(
    //) internal pure
    //{
        //now.requireGreaterThanZero()
    //}
    
    //not very helpful, only applies to 1 possible transaction ever
    function requireBlockNumberEqual(
        uint rhs
    )internal pure
    {
        block.number.requireEqual(rhs);
    }
    
    function requireBlockNumberNotEqual(
        uint rhs
    )internal pure
    {
        block.number.requireNotEqual(rhs);
    }
    */
}