// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/bytes/bytesLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

/// @title Bytes Constraints Library
/// @author Tyler R. Drury - 4/3/2021, All Rights Reserved
/// @notice This library provides trivial functions for constaining the state of the EVM (using require) based on the bytes data type.
library bytesConstraints
{
    using logicConstraints for bool;
    using bytesLogic for bytes;
    
    //using stringUtilities for string;
    
    //string private constant LIB_NAME = 'bytesConstraints: ';
    /**
    function requireEqual(
        bytes lhs,
        bytes rhs
    ) internal pure
    {
        logicConstraints.requireTrue(
            lhs.equal(rhs)
        );
    }
    function requireNotEqual(
        bytes lhs,
        bytes rhs
    ) internal pure
    {
        logicConstraints.requireTrue(
            lhs.notEqual(rhs)
        );
    }
    */
    function requireEmpty(
        bytes lhs
    )internal pure
    {
        lhs.empty().requireTrue(
            "not empty"     //LIB_NAME.concatenate('not empty')
        );
    }
    function requireNotEmpty(
        bytes lhs
    )internal pure
    {
        lhs.notEmpty().requireTrue(
            "empty"     //LIB_NAME.concatenate('empty')
        );
    }
    
    function requireNotEmptyAndNotEqual(
        bytes lhs,
        bytes rhs
    )internal pure
    {
        lhs.notEmptyAndNotEqual(rhs).requireTrue(
            //'not empty'   //LIB_NAME.concatenate('(lhs empty || rhs empty) || lhs == rhs')
        );
    }
    
    function requireNotEmptyAndAreEqual(
        bytes lhs,
        bytes rhs
    )internal pure
    {
        lhs.notEmptyAndAreEqual(rhs).requireTrue(
            //LIB_NAME.concatenate('(lhs empty || rhs empty) || lhs != rhs')
        );
    }
}