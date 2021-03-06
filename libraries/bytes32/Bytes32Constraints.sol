// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Logic.sol";
import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";

/// @title Bytes32 Constraints Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @notice This library provides trivial functions for constaining the state of the EVM (using require) based on the bytes32 data type.
/// @dev This library is base on utils Btyes32Logic and is NOT vulnerable to timing attacks,
/// and is designed and intended for use in cryptographically secure applications,
/// which require constraining the state of the EVM for Bytes32 types, reverting on failure.
library Bytes32Constraints
{
    using LogicConstraints for bool;
    using Bytes32Logic for bytes32;
    
    function requireEqual(
        bytes32 lhs,
        bytes32 rhs
    ) internal pure
    {
        lhs.equal(rhs).requireTrue(
            //''
        );
    }
    function requireNotEqual(
        bytes32 lhs,
        bytes32 rhs
    ) internal pure
    {
        lhs.notEqual(rhs).requireTrue(
            //''
        );
    }
    function requireEmpty(
        bytes32 lhs
    )internal pure
    {
        lhs.empty().requireTrue(
            //''
        );
    }
    function requireNotEmpty(
        bytes32 lhs
    )internal pure
    {
        lhs.notEmpty().requireTrue(
            //''
        );
    }
    
    function requireNotEmptyAndNotEqual(
        bytes32 lhs,
        bytes32 rhs
    )internal pure
    {
        lhs.notEmptyAndNotEqual(rhs).requireTrue(
            //''
        );
    }
    
    function requireNotEmptyAndAreEqual(
        bytes32 lhs,
        bytes32 rhs
    )internal pure
    {
        lhs.notEmptyAndAreEqual(rhs).requireTrue(
            //''
        );
    }
}