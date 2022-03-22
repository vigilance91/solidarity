// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256ArrayLogic.sol";
/// 
/// @title Uint256 Array Contraints Library
/// @author Tyler R. Drury - 22/3/2022, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require) for
/// uint256 arrays, reverting on failure
/// 
library uint256ArrayConstraints
{
    using logicConstraints for bool;
    
    using uint256ArrayLogic for uint256[];
    
    string private constant _NAME = ' uint256ArrayConstraints: ';
    
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
            'uint256[] is empty'
        )
    );
    
    string private constant _ERR_NOT_EMPTY = string(
        abi.encodePacked(
            _NAME,
            'uint256[] is not empty'
        )
    );
    
    function requireEqual(
        uint256[] memory lhs,
        uint256[] memory rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            _ERR_NOT_EQUAL
        );
    }
    
    function requireNotEqual(
        uint256[] memory lhs,
        uint256[] memory rhs
    )public pure
    {
        lhs.equal(rhs).requireFalse(
            _ERR_EQUAL
        );
    }
    
    function requireEmpty(
        uint256[] memory lhs
    )public pure
    {
        lhs.empty().requireTrue(
            _ERR_NOT_EMPTY
        );
    }
    
    function requireNotEmpty(
        uint256[] memory lhs
    )public pure
    {
        lhs.notEmpty().requireTrue(
            _ERR_EMPTY
        );
    }
    
    function requireNotEmptyAndNotEqual(
        uint256[] memory lhs,
        uint256[] memory rhs
    )public pure
    {
        lhs.notEmptyAndNotEqual(rhs).requireTrue(
            //_NAME,
            //'(lhs == empty || rhs == empty) || lhs == rhs'
        );
    }
    
    function requireNotEmptyAndAreEqual(
        uint256[] memory lhs,
        uint256[] memory rhs
    )public pure
    {
        lhs.notEmptyAndAreEqual(rhs).requireTrue(
            //'(lhs == empty || rhs == empty) || lhs != rhs')')
        );
    }
}