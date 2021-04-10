// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/StringLogic.sol";
//import "https://github.com/vigilance91/solidarity/libraries/string/stringUtilities.sol";

/// @title String Contraints Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require) for
/// Solidity's string type, reverting on failure.
library StringConstraints
{
    using LogicConstraints for bool;
    using StringLogic for string;
    
    //using stringUtilities for string;
    
    //string private constant LIB_NAME = 'stringConstraints: ';
    
    function requireEqual(
        string memory lhs,
        string memory rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            //LIB_NAME.concatenate('not equal')
        );
        //LogicConstraints.requireTrue(lhs.equal(rhs));
    }
    
    function requireNotEqual(
        string memory lhs,
        string memory rhs
    )public pure
    {
        lhs.equal(rhs).requireFalse(
            //LIB_NAME.concatenate('equal')
        );
        //LogicConstraints.requireTrue(lhs.notEqual(rhs));
    }
    
    function requireEmpty(
        string memory lhs
    )public pure
    {
        lhs.empty().requireTrue(
            //LIB_NAME.concatenate('not empty')
        );
        //LogicConstraints.requireTrue(lhs.empty());
    }
    
    function requireNotEmpty(
        string memory lhs
    )public pure
    {
        lhs.notEmpty().requireTrue(
            //LIB_NAME.concatenate('empty')
        );
        //LogicConstraints.requireTrue(lhs.notEmpty());
    }
    
    function requireNotEmptyAndNotEqual(
        string memory lhs,
        string memory rhs
    )public pure
    {
        lhs.notEmptyAndNotEqual(rhs).requireTrue(
            //LIB_NAME.concatenate('(lhs not empty || rhs nor empty) || lhs == rhs')
        );
        //LogicConstraints.requireTrue(lhs.notEmptyAndNotEqual(rhs));
    }
    
    function requireNotEmptyAndAreEqual(
        string memory lhs,
        string memory rhs
    )public pure
    {
        lhs.notEmptyAndAreEqual(rhs).requireTrue(
            //LIB_NAME.concatenate('(lhs not empty || rhs nor empty) || lhs != rhs')')
        );
        //LogicConstraints.requireTrue(lhs.notEmptyAndAreEqual(rhs));
    }
}