// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

import "https://github.com/vigilance91/solidarity/constraints/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/utils/StringLogic.sol";

/// @title String Contraints
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require) for
/// Solidity's string type, reverting on failure.
library StringConstraints
{
    //using LogicConstraints for bool;
    //using LogicConstraints for bool;
    using StringLogic for string;
    
    function requireEqual(
        string memory lhs,
        string memory rhs
    )public pure
    {
        //lhs.equal(rhs).requireTrue();
        LogicConstraints.requireTrue(lhs.equal(rhs));
    }
    
    function requireNotEqual(
        string memory lhs,
        string memory rhs
    )public pure
    {
        //lhs.notEqual(rhs).requireTrue();
        LogicConstraints.requireTrue(lhs.notEqual(rhs));
    }
    
    function requireEmpty(
        string memory lhs
    )public pure
    {
        //lhs.empty().requireTrue();
        LogicConstraints.requireTrue(lhs.empty());
    }
    
    function requireNotEmpty(
        string memory lhs
    )public pure
    {
        //lhs.notEmpty(rhs).requireTrue();
        LogicConstraints.requireTrue(lhs.notEmpty());
    }
    
    function requireNotEmptyAndNotEqual(
        string memory lhs,
        string memory rhs
    )public pure
    {
        //lhs.notEmptyAndNotEqual(rhs).requireTrue();
        LogicConstraints.requireTrue(lhs.notEmptyAndNotEqual(rhs));
    }
    
    function requireNotEmptyAndAreEqual(
        string memory lhs,
        string memory rhs
    )public pure
    {
        //lhs.notEmptyAndAreEqual(rhs).requireTrue();
        LogicConstraints.requireTrue(lhs.notEmptyAndAreEqual(rhs));
    }
}