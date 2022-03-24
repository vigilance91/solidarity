// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/block/gas/blockGasLogic.sol";
/// 
/// @title gas()/gasleft() Contraints Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 27/4/2021, All Rights Reserved
///
library blockGasConstraints
{
    //now is same as block.timestamp
    using logicConstraints for bool;
    
    using uint256Constraints for uint;
    using blockGasLogic for uint;
    
    //require now greater than (>) `rhs`
    function requireGasLeftGreaterThan(
        uint rhs
    )public pure
    {
        rhs.gasLeftGreaterThan().requireTrue(
            //'insufficient gas'
        );
    }
    //require now greater Than or equal to (>=) `rhs`
    function requireGasLeftGreaterThanOrEqual(
        uint rhs
    )public pure
    {
        rhs.gasLeftGreaterThanOrEqual().requireTrue(
            //'insufficient gas'
        );
    }
    //require now less than (<) `rhs`
    function requireGasLeftLessThan(
        uint rhs
    )public pure
    {
        rhs.gasLeftLessThan().requireTrue(
            //'insufficient gas'
        );
    }
    //require now greater than or equal to (<=) `rhs`
    function requireGasLeftLessThanOrEqual(
        uint rhs
    )public pure
    {
        rhs.gasLeftLessThanOrEqual().requireTrue(
            //'insufficient gas'
        );
    }
    function requireGasLeftGreaterThanZero(
    )public pure
    {
        type(uint).min.gasLeftGreaterThan().requireTrue(
        );
    }
    /// @dev trivial and redundant
    function requireTransactionPriceGreaterThanZero(
    )public pure
    {
        blockGasLogic.transactionPriceGreaterThanZero().requireTrue(
        );
    }
    /// @dev trivial and redundant
    function requireGasLimitGreaterThanZero(
    )public pure
    {
        blockGasLogic.gasLimitGreaterThanZero().requireTrue(
        );
    }
    function requireGasLeftLessThanMax(
        uint rhs
    )public pure
    {
        blockGasLogic.gasLeftLessThanMax().requireTrue(
        );
    }
    function requireGasLeftInBounds(
        uint rhs
    )public pure
    {
        blockGasLogic.gasLeftInBounds().requireTrue(
        );
    }
    //
    //gas limit
    // note: the block gaslimit should never be exceeded, these checks are trivial and redundant
    //
    /// @dev price of transaction should always be less than the block gas limit
    function requireGasLeftLessThanGasLimit(
    )internal pure returns(
        bool ret
    ){
        blockGasLogic.gasLeftLessThanGasLimit().requireTrue(
        );
    }
    function requireGasLeftLessThanOrEqualGasLimit(
    )internal pure returns(
        bool ret
    ){
        blockGasLogic.gasLeftLessThanOrEqualGasLimit().requireTrue(
        );
    }
    function requireTransactionPriceLessThanGasLimit(
    )internal pure returns(
        bool ret
    ){
        blockGasLogic.transactionPriceLessThanGasLimit().requireTrue(
        );
    }
    function requireTransactionPriceLessThanOrEqualGasLimit(
    )internal pure returns(
        bool ret
    ){
        blockGasLogic.transactionPriceLessThanOrEqualGasLimit().requireTrue(
        );
    }
    //
    //transaction price
    //
    function requireGasLeftGreaterThanTransactionPrice(
    )public pure
    {
        blockGasLogic.gasLeftGreaterThanTransactionPrice().requireTrue(
            //'insufficient gas'
        );
    }
    //require now greater Than or equal to (>=) `rhs`
    function requireGasLeftGreaterThanOrEqualTransactionPrice(
    )public pure
    {
        blockGasLogic.gasLeftGreaterThanOrEqualTransactionPrice().requireTrue(
            //'insufficient gas'
        );
    }
    //require now less than (<) `rhs`
    function requireGasLeftLessThanTransactionPrice(
    )public pure
    {
        blockGasLogic.gasLeftLessThanTransactionPrice().requireTrue(
            //'insufficient gas'
        );
    }
    //require now greater than or equal to (<=) `rhs`
    function requireGasLeftLessThanOrEqualTransactionPrice(
    )public pure
    {
        blockGasLogic.gasLeftLessThanOrEqualTransactionPrice().requireTrue(
            //'insufficient gas'
        );
    }
    
    function requireGasLeftLessThanMax(
        uint rhs
    )public pure
    {
        blockGasLogic.gasLeftLessThanMax().requireTrue(
        );
    }
    function requireGasLeftInBounds(
        uint rhs
    )public pure
    {
        blockGasLogic.gasLeftInBounds().requireTrue(
        );
    }
    
    //
    /**
    //trivial not very useful
    function requireGasLeftEqual(
        uint rhs
    )public pure
    {
        rhs.gasLeftEqual().requireTrue(
        );
    }
    function requireNGasLeftNotEqual(
        uint rhs
    )public pure
    {
        rhs.gasLeftNotEqual().requireTrue(
        );
    }
    */
}