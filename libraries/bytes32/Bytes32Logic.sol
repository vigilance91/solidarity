// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
/**
 * todo create struct or contract for a mapping of addresses to byte32, for user account passwords!
 * libraries with internal functions have to function body injected into all callsites (this increases size and gas cost)
 * however, internal libraries do not need to be deployed, only included with the contracts that use them
*/

/// @title Bytes32 Logic Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @notice This library provides trivial functions for the bytes32 data type not provided natively by Solidity.
/// @dev This library is NOT vulnerable to timing attacks and thus,
/// is highly recommended as it is designed and intended for use in cryptographically secure applications,
/// which require generating hashes, validating, masking or otherwise operating on Bytes32 types.
/// Not only is this library secure, it is also fast and thus efficient in terms of gas,
/// since it utilizes bitwise operators to evaluate equality or manipulate Bytes32 types,
/// as oppossed to the insecure alternative of iterating over each element in a Bytes32 and,
/// sequentially performing an equality check on each element
library Bytes32Logic
{
    //bytes32 public constant EMPTY = bytes32("");
    //bytes32 public constant EMPTY_HASH = keccak256(EMPTY);
    
    function equal(
        bytes32 lhs,
        bytes32 rhs
    )internal pure returns(
        bool ret
    ){
        //return _xor(lhs, rhs) == 0;
        assembly{
            ret := iszero(xor(lhs, rhs))
        }
    }
    function notEqual(
        bytes32 lhs,
        bytes32 rhs
    )internal pure returns(
        bool ret
    ){
        //return _xor(lhs, rhs) != 0;
        assembly{
            ret := not(iszero(xor(lhs, rhs)))
        }
    }
    //function requireSecretFormat(string memory secret) public pure{
        //require(secret.length >= 8, "secret must be at least 8 characters long");
        //require(secret ..., "invalid secret characters");
    //}
    function _and(
        bytes32 lhs,
        bytes32 rhs
    )internal pure returns(
        bytes32 ret
    ){
        assembly{
            ret := and(lhs, rhs)
        }
    }
    function _or(
        bytes32 lhs,
        bytes32 rhs
    )internal pure returns(
        bytes32 ret
    ){
        assembly{
            ret := or(lhs, rhs)
        }
    }
    function _xor(
        bytes32 lhs,
        bytes32 rhs
    )internal pure returns(
        bytes32 ret
    ){
        assembly{
            ret := xor(lhs, rhs)
        }
    }
    
    function empty(
        bytes32 lhs
    )internal pure returns(
        bool
    ){
        return Bytes32Logic.equal(
            lhs,
            bytes32("")
        );
    }
    
    function notEmpty(
        bytes32 lhs
    )internal pure returns(
        bool
    ){
        return Bytes32Logic.notEqual(
            lhs,
            bytes32("")
        );
    }
    
    function notEmptyAndNotEqual(
        bytes32 lhs,
        bytes32 rhs
    )internal pure returns(
        bool
    ){
        return notEmpty(lhs) &&
            notEmpty(rhs) &&
            notEqual(lhs,rhs);
    }
    
    function notEmptyAndAreEqual(
        bytes32 lhs,
        bytes32 rhs
    )internal pure returns(
        bool
    ){
        return notEmpty(lhs) &&
            notEmpty(rhs) && 
            equal(lhs,rhs);
    }
}