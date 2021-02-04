// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

import "https://github.com/vigilance91/solidarity/utils/Bytes32Logic.sol";

/// @title Solidity String Logic Utilities
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @notice trivial functions for logical operations on strings not provided natively by Solidity.
/// @dev The official Ethereum StringUtils library (found here https://github.com/ethereum/dapp-bin/blob/master/library/stringUtils.sol) is vulnerable to timing attacks!
/// it is NOT recommend for use, ever, for any reason.
/// This library, on the otherhand, is NOT vulnerable to timing attacks and thus,
/// is recommended as an alternative as it is designed and intended for use in cryptographically secure applications.
library StringLogic
{
    //using Bytes32Logic for bytes32;
    /**
     * compare string hashes using XOR, rather than iteratively compare each element in strings
     * not only is this appraoch generally faster for larger strings but is also NOT vulnerable to timing attacks
     * and is not dependant upon the length of the strings being compared since bitwise ^ is a single asm instruction
     * and hashing algorithms are relatively fast and computationally efficient!
    */
    function equal(
        string memory lhs,
        string memory rhs
    )public pure returns(bool){
        return Bytes32Logic.equal(
            keccak256(bytes(lhs)),
            keccak256(bytes(rhs))
        );
    }
    
    function notEqual(
        string memory lhs,
        string memory rhs
    )public pure returns(bool){
        return Bytes32Logic.notEqual(
            keccak256(bytes(lhs)),
            keccak256(bytes(rhs))
        );
    }
    
    function empty(
        string memory lhs
    )public pure returns(bool){
        return Bytes32Logic.equal(
            keccak256(bytes(lhs)),
            keccak256(bytes(""))
        );
    }
    
    function notEmpty(
        string memory lhs
    )public pure returns(bool){
        return Bytes32Logic.notEqual(
            keccak256(bytes(lhs)),
            keccak256(bytes(""))
        );
    }
    
    function notEmptyAndNotEqual(
        string memory lhs,
        string memory rhs
    )public pure returns(bool){
        return notEmpty(
            lhs
        ) && notEmpty(
            rhs
        ) && notEqual(lhs,rhs);
    }
    
    function notEmptyAndAreEqual(
        string memory lhs,
        string memory rhs
    )public pure returns(bool){
        return notEmpty(
            lhs
        ) && notEmpty(
            rhs
        ) && equal(lhs,rhs);
    }
    /**
     * lhs and rhs MUST be the same length otherwise revert
    //function xor(
        //string memory lhs,
        //string memory rhs
    //)returns(string memory){
        //return string(bytes(lhs) ^ bytes(rhs));
    //}
    //function and(
        //string memory lhs,
        //string memory rhs
    //)returns(string memory){
        //return string(bytes(lhs) & bytes(rhs));
    //}
    //function or(
        //string memory lhs,
        //string memory rhs
    //)returns(string memory){
        //return string(bytes(lhs) | bytes(rhs));
    //}
    */   
}