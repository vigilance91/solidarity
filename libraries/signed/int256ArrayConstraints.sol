// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/signed/int256ArrayLogic.sol";
/// 
/// @title Int256 Array Contraints Library
/// @author Tyler R. Drury - 22/3/2022, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require) for
/// int256 arrays, reverting on failure
/// 
library int256ArrayConstraints
{
    using logicConstraints for bool;
    
    using int256ArrayLogic for int256[];
    
    string private constant _NAME = ' int256ArrayConstraints: ';
    
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
            'int256[] is empty'
        )
    );
    
    string private constant _ERR_NOT_EMPTY = string(
        abi.encodePacked(
            _NAME,
            'int256[] is not empty'
        )
    );
    
    function requireEqual(
        int256[] memory lhs,
        int256[] memory rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            _ERR_NOT_EQUAL
        );
    }
    
    function requireNotEqual(
        int256[] memory lhs,
        int256[] memory rhs
    )public pure
    {
        lhs.equal(rhs).requireFalse(
            _ERR_EQUAL
        );
    }
    
    function requireEmpty(
        int256[] memory lhs
    )public pure
    {
        lhs.empty().requireTrue(
            _ERR_NOT_EMPTY
        );
    }
    
    function requireNotEmpty(
        int256[] memory lhs
    )public pure
    {
        lhs.notEmpty().requireTrue(
            _ERR_EMPTY
        );
    }
    
    function requireNotEmptyAndNotEqual(
        int256[] memory lhs,
        int256[] memory rhs
    )public pure
    {
        lhs.notEmptyAndNotEqual(rhs).requireTrue(
            //_NAME,
            //'(lhs == empty || rhs == empty) || lhs == rhs'
        );
    }
    
    function requireNotEmptyAndAreEqual(
        int256[] memory lhs,
        int256[] memory rhs
    )public pure
    {
        lhs.notEmptyAndAreEqual(rhs).requireTrue(
            //'(lhs == empty || rhs == empty) || lhs != rhs')')
        );
    }
}