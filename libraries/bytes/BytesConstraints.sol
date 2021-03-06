// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/vigilance91/solidarity/libraries/bytes/BytesLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";

/// @title Bytes Constraints Library
/// @author Tyler R. Drury - 4/3/2021, All Rights Reserved
/// @notice This library provides trivial functions for constaining the state of the EVM (using require) based on the bytes data type.
library BytesConstraints
{
    using LogicConstraints for bool;
    using BytesLogic for bytes;
    /**
    function requireEqual(
        bytes lhs,
        bytes rhs
    ) internal pure
    {
        LogicConstraints.requireTrue(
            lhs.equal(rhs)
        );
    }
    function requireNotEqual(
        bytes lhs,
        bytes rhs
    ) internal pure
    {
        LogicConstraints.requireTrue(
            lhs.notEqual(rhs)
        );
    }
    */
    function requireEmpty(
        bytes lhs
    )internal pure
    {
        lhs.empty().requireTrue(
            "not empty"
        );
    }
    function requireNotEmpty(
        bytes lhs
    )internal pure
    {
        lhs.notEmpty().requireTrue(
            "empty"
        );
    }
    
    function requireNotEmptyAndNotEqual(
        bytes lhs,
        bytes rhs
    )internal pure
    {
        lhs.notEmptyAndNotEqual(rhs).requireTrue(
            //'not empty'
        );
    }
    
    function requireNotEmptyAndAreEqual(
        bytes lhs,
        bytes rhs
    )internal pure
    {
        lhs.notEmptyAndAreEqual(rhs).requireTrue(
            //''
        );
    }
}