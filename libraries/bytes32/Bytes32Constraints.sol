// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Logic.sol";
import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
/// 
/// @title Bytes32 Constraints Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @notice This library provides trivial functions for constaining the state of the EVM (using require) based on the bytes32 data type.
/// @dev This library is base on utils Btyes32Logic and is NOT vulnerable to timing attacks,
/// and is designed and intended for use in cryptographically secure applications,
/// which require constraining the state of the EVM for Bytes32 types, reverting on failure.
/// 
library Bytes32Constraints
{
    using logicConstraints for bool;
    using Bytes32Logic for bytes32;
    
    //using stringUtilities for string;
    
    //string private constant _NAME = 'bytes32Constraints: ';
    
    function requireEqual(
        bytes32 lhs,
        bytes32 rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            //_NAME.concatenate('lhs != rhs');
        );
    }
    function requireNotEqual(
        bytes32 lhs,
        bytes32 rhs
    )public pure
    {
        lhs.equal(rhs).requireFalse(
            //_NAME.concatenate('lhs == rhs');
        );
    }
    function requireEmpty(
        bytes32 lhs
    )public pure
    {
        lhs.empty().requireTrue(
            //_NAME.concatenate('lhs != 0x0')
        );
    }
    
    function requireEmpty(
        bytes32[] memory lhs
    )public pure
    {
        for(uint i; i < lhs.length; i++){
            lhs[i].empty().requireTrue(
                //_NAME.concatenate('lhs != 0x0')
            );
        }
    }
    function requireNotEmpty(
        bytes32 lhs
    )public pure
    {
        lhs.empty().requireFalse(
            //_NAME.concatenate('lhs == 0x0')
        );
    }
    
    function requireNotEmpty(
        bytes32[] memory lhs
    )public pure
    {
        for(uint i; i < lhs.length; i++){
            lhs[i].empty().requireFalse(
                //_NAME.concatenate('lhs == 0x0')
            );
        }
    }
    
    function requireNotEmptyAndNotEqual(
        bytes32 lhs,
        bytes32 rhs
    )public pure
    {
        lhs.notEmptyAndNotEqual(rhs).requireTrue(
            //_NAME.concatenate('(lhs == 0x0 || rhs == 0x0) || lhs == rhs');
        );
    }
    
    function requireNotEmptyAndAreEqual(
        bytes32 lhs,
        bytes32 rhs
    )public pure
    {
        lhs.notEmptyAndAreEqual(rhs).requireTrue(
            //_NAME.concatenate('(lhs == 0x0 || rhs == 0x0) || lhs != rhs');
        );
    }
}