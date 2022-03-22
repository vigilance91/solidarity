// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressArrayLogic.sol";
/// 
/// @title Address Array Contraints Library
/// @author Tyler R. Drury - 22/3/2022, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require) for
/// address arrays, reverting on failure
/// 
library addressArrayConstraints
{
    using logicConstraints for bool;
    
    using addressArrayLogic for address[];
    
    string private constant _NAME = ' addressArrayConstraints: ';
    
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
            'address[] is empty'
        )
    );
    
    string private constant _ERR_NOT_EMPTY = string(
        abi.encodePacked(
            _NAME,
            'address[] is not empty'
        )
    );
    
    function requireEqual(
        address[] memory lhs,
        address[] memory rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            _ERR_NOT_EQUAL
        );
    }
    
    function requireNotEqual(
        address[] memory lhs,
        address[] memory rhs
    )public pure
    {
        lhs.equal(rhs).requireFalse(
            _ERR_EQUAL
        );
    }
    
    function requireEmpty(
        address[] memory lhs
    )public pure
    {
        lhs.empty().requireTrue(
            _ERR_NOT_EMPTY
        );
    }
    
    function requireNotEmpty(
        address[] memory lhs
    )public pure
    {
        lhs.notEmpty().requireTrue(
            _ERR_EMPTY
        );
    }
    
    function requireNotEmptyAndNotEqual(
        address[] memory lhs,
        address[] memory rhs
    )public pure
    {
        lhs.notEmptyAndNotEqual(rhs).requireTrue(
            //_NAME,
            //'(lhs == empty || rhs == empty) || lhs == rhs'
        );
    }
    
    function requireNotEmptyAndAreEqual(
        address[] memory lhs,
        address[] memory rhs
    )public pure
    {
        lhs.notEmptyAndAreEqual(rhs).requireTrue(
            //'(lhs == empty || rhs == empty) || lhs != rhs')')
        );
    }
}