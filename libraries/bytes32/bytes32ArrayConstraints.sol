// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/bytes32/bytes32ArrayLogic.sol";
/// 
/// @title Bytes32 Array Contraints Library
/// @author Tyler R. Drury - 22/3/2022, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require) for
/// bytes32 arrays, reverting on failure
/// 
library bytes32ArrayConstraints
{
    using logicConstraints for bool;
    
    using bytes32ArrayLogic for bytes32[];
    
    string private constant _NAME = ' bytes32ArrayConstraints: ';
    
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
            'bytes32[] is empty'
        )
    );
    
    string private constant _ERR_NOT_EMPTY = string(
        abi.encodePacked(
            _NAME,
            'bytes32[] is not empty'
        )
    );
    
    function requireEqual(
        bytes32[] memory lhs,
        bytes32[] memory rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            _ERR_NOT_EQUAL
        );
    }
    
    function requireNotEqual(
        bytes32[] memory lhs,
        bytes32[] memory rhs
    )public pure
    {
        lhs.equal(rhs).requireFalse(
            _ERR_EQUAL
        );
    }
    
    function requireEmpty(
        bytes32[] memory lhs
    )public pure
    {
        lhs.empty().requireTrue(
            _ERR_NOT_EMPTY
        );
    }
    
    function requireNotEmpty(
        bytes32[] memory lhs
    )public pure
    {
        lhs.notEmpty().requireTrue(
            _ERR_EMPTY
        );
    }
    
    function requireNotEmptyAndNotEqual(
        bytes32[] memory lhs,
        bytes32[] memory rhs
    )public pure
    {
        lhs.notEmptyAndNotEqual(rhs).requireTrue(
            //_NAME,
            //'(lhs == empty || rhs == empty) || lhs == rhs'
        );
    }
    
    function requireNotEmptyAndAreEqual(
        bytes32[] memory lhs,
        bytes32[] memory rhs
    )public pure
    {
        lhs.notEmptyAndAreEqual(rhs).requireTrue(
            //'(lhs == empty || rhs == empty) || lhs != rhs')')
        );
    }
}