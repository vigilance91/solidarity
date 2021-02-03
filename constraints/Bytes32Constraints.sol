// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.6.2;

import "https://github.com/vigilance91/solidarity/utils/Bytes32Logic.sol";
import "https://github.com/vigilance91/solidarity/constraints/LogicConstraints.sol";

/// @title Bytes32 Contraints
/// @author Tyler R. Drury - 3/1/2021, ALl Rights Reserved
/// @notice This library provides trivial functions for constaining the state of the EVM (using require) based on the bytes32 data type.
/// @dev This library is base on utils Btyes32Logic and is NOT vulnerable to timing attacks,
/// and is designed and intended for use in cryptographically secure applications,
/// which require constraining the state of the EVM for Bytes32 types, reverting on failure.
library Bytes32Contraints
{
    //using LogicConstraints for bool;
    //using Bytes32Logic for bytes32;
    
    function requireEqual(bytes32 lhs, bytes32 rhs) internal pure{
        require(Bytes32Logic.equal(lhs,rhs));
    }
    function requireNotEqual(bytes32 lhs, bytes32 rhs) internal pure{
        require(Bytes32Logic.notEqual(lhs,rhs));
    }
      function requireEmpty(
        bytes32 lhs
    )internal pure{
        require(Bytes32Logic.empty(lhs));
    }
    
    function requireNotEmpty(
        bytes32 lhs
    )internal pure{
        require(Bytes32Logic.notEmpty(lhs));
    }
    
    function requireNotEmptyAndNotEqual(
        bytes32 lhs,
        bytes32 rhs
    )internal pure{
        require(Bytes32Logic.notEmptyAndNotEqual(lhs,rhs));
    }
    
    function requireNotEmptyAndAreEqual(
        bytes32 lhs,
        bytes32 rhs
    )internal pure{
        require(Bytes32Logic.notEmptyAndAreEqual(lhs,rhs));
    }
}