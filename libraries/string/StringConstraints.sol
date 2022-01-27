// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/stringLogic.sol";
//import "https://github.com/vigilance91/solidarity/libraries/string/stringUtilities.sol";

/// @title String Contraints Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require) for
/// Solidity's string type, reverting on failure
library stringConstraints
{
    using logicConstraints for bool;
    
    using stringLogic for string;
    
    //using stringUtilities for string;
    
    string private constant _NAME = ' stringConstraints: ';
    
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
            'string is empty'
        )
    );
    
    string private constant _ERR_NOT_EMPTY = string(
        abi.encodePacked(
            _NAME,
            'string is not empty'
        )
    );
    
    
    function requireEqual(
        string memory lhs,
        string memory rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            _ERR_NOT_EQUAL
        );
    }
    
    function requireNotEqual(
        string memory lhs,
        string memory rhs
    )public pure
    {
        lhs.equal(rhs).requireFalse(
            _ERR_EQUAL
        );
    }
    
    function requireEmpty(
        string memory lhs
    )public pure
    {
        lhs.empty().requireTrue(
            _ERR_NOT_EMPTY
        );
    }
    
    function requireNotEmpty(
        string memory lhs
    )public pure
    {
        lhs.notEmpty().requireTrue(
            _ERR_EMPTY
        );
    }
    
    function requireNotEmptyAndNotEqual(
        string memory lhs,
        string memory rhs
    )public pure
    {
        lhs.notEmptyAndNotEqual(rhs).requireTrue(
            //_NAME.concatenate(
                //'(lhs not empty || rhs nor empty) || lhs == rhs'
            //)
        );
    }
    
    function requireNotEmptyAndAreEqual(
        string memory lhs,
        string memory rhs
    )public pure
    {
        lhs.notEmptyAndAreEqual(rhs).requireTrue(
            //_NAME.concatenate('(lhs not empty || rhs nor empty) || lhs != rhs')')
        );
    }
}