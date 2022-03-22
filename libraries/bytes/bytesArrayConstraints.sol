// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/bytes/bytesArrayLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
/// 
/// @title Bytes Array Constraints Library
/// @author Tyler R. Drury - 22/3/2022, All Rights Reserved
/// @notice This library provides trivial functions for constaining the state of the EVM (using require) based on the bytes array.
/// 
library bytesArrayConstraints
{
    using logicConstraints for bool;
    
    using bytesArrayLogic for bytes[];
    
    string private constant _NAME = ' bytesArrayConstraints: ';
    
    string private constant _ERR_EQUAL = string(
        abi.encodePacked(
            _NAME,
            '=='
        )
    );
    string private constant _ERR_NOT_EQUAL = string(
        abi.encodePacked(
            _NAME,
            '!='
        )
    );
    
    string private constant _ERR_EMPTY = string(
        abi.encodePacked(
            _NAME,
            'bytes[] is empty'
        )
    );
    
    string private constant _ERR_NOT_EMPTY = string(
        abi.encodePacked(
            _NAME,
            'bytes[] is not empty'
        )
    );
    
    function requireEqual(
        bytes[] memory lhs,
        bytes[] memory rhs
    )internal pure
    {
        lhs.equal(rhs).requireTrue(
            _ERR_NOT_EQUAL
        );
    }
    function requireNotEqual(
        bytes[] memory lhs,
        bytes[] memory rhs
    )internal pure
    {
        lhs.notEqual(rhs).requireTrue(
            _ERR_EQUAL
        );
    }
    
    function requireEmpty(
        bytes[] memory lhs
    )internal pure
    {
        lhs.empty().requireTrue(
            _ERR_NOT_EMPTY
        );
    }
    function requireNotEmpty(
        bytes[] memory lhs
    )internal pure
    {
        lhs.notEmpty().requireTrue(
            _ERR_EMPTY
        );
    }
    
    function requireNotEmptyAndNotEqual(
        bytes[] memory lhs,
        bytes[] memory rhs
    )internal pure
    {
        lhs.notEmptyAndNotEqual(rhs).requireTrue(
            //'(lhs empty || rhs empty) || lhs == rhs'
        );
    }
    
    function requireNotEmptyAndAreEqual(
        bytes[] memory lhs,
        bytes[] memory rhs
    )internal pure
    {
        lhs.notEmptyAndAreEqual(rhs).requireTrue(
            //'(lhs empty || rhs empty) || lhs != rhs'
        );
    }
}