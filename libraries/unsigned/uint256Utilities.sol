// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
/// 
/// @title uint256 Utilities
/// @author Tyler R. Drury - 9/12/2021, All Rights Reserved
/// @notice trivial library for encoding and hash operations on uint256 using native Solidity operations.
/// 
library uint256Utilities
{
    //raw encodes the arguments as bytes, concatenating them together then returning the resulting sha3 hash
    function encodeAndHash(
        uint256 lhs,
        uint256 rhs
    )internal pure returns(
        bytes32
    ){
        return keccak256(abi.encode(
            lhs,
            rhs
        ));
    }
    //raw encodes the arguments as bytes packed to 32 bytes each, then concatenates them together, returning the resulting sha3 hash
    function encodePackedAndHash(
        uint256 lhs,
        uint256 rhs
    )internal pure returns(
        bytes32
    ){
        return keccak256(abi.encodePacked(
            lhs,
            rhs
        ));
    }
    function encodeAndHashSignature(
        uint256 lhs,
        uint256 rhs
    )internal pure returns(
        bytes4
    ){
        return bytes4(
            encodeAndHash(lhs,rhs)
        );
    }
    function encodePackedAndHashSignature(
        uint256 lhs,
        uint256 rhs
    )internal pure returns(
        bytes4
    ){
        return bytes4(
            encodePackedAndHash(lhs,rhs)
        );
    }
}