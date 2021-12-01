// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
//import "./BytesUtilities.sol";
import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Logic.sol";
import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Constraints.sol";
//
//import "https://github.com/vigilance91/solidarity/libraries/string/StringLogic.sol";
//import "https://github.com/vigilance91/solidarity/libraries/string/StringConstraints.sol";
/// 
/// @title bytes32 Utilities
/// @author Tyler R. Drury - 30/11/2021, All Rights Reserved
/// @notice trivial bytes32 convenience utility functions not provided natively by Solidity.
/// 
library bytes32Utilities
{
    using Bytes32Logic for bytes32;
    using Bytes32Constraints for bytes32;
    
    //using AddressLogic for address;
    //using StringLogic for string;
    
    function concatenate(
        bytes32 lhs,
        bytes32 rhs
    )internal pure returns(
        bytes memory
    ){
        return abi.encodePacked(lhs, rhs);
    }
    function concatenateAndHash(
        bytes32 lhs,
        bytes32 rhs
    )internal pure returns(
        bytes32
    ){
        return keccak256(
            abi.encodePacked(lhs, rhs)
        );
    }
    function hash(
        bytes32 self
    )internal pure returns(
        bytes32
    ){
        return keccak256(
            abi.encodePacked(self)
        );
    }
    /// convenience function to get first 4 bytes of a hash of a bytes32,
    function hashSignature(
        bytes32 self
    )internal pure returns(
        bytes4
    ){
        return bytes4(
            hash(self)
        );
    }
    function hashSignatureEquals(
        bytes32 lhs,
        bytes4 rhs
    )internal pure returns(
        bool
    ){
        return hashSignature(lhs) == rhs;
    }
    
    function hashSignatureEquals(
        bytes32 lhs,
        bytes32 rhs
    )internal pure returns(
        bool
    ){
        return hashSignature(lhs) ^ hashSignature(rhs) == 0;
    }
}