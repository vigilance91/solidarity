// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
//
import "https://github.com/vigilance91/solidarity/libraries/bytes/bytesLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/bytes/bytesConstraints.sol";
/// 
/// @title bytes Utilities
/// @author Tyler R. Drury - 1/12/2021, All Rights Reserved
/// @notice trivial bytes32 convenience utility functions not provided natively by Solidity.
/// 
library bytesUtilities
{
    using bytesLogic for bytes;
    using bytesConstraints for bytes;
    
    //using addressLogic for address;
    //using stringLogic for string;
    
    function concatenate(
        bytes memory lhs,
        bytes memory rhs
    )internal pure returns(
        bytes memory
    ){
        return abi.encodePacked(lhs, rhs);
    }
    //unpacked concatenation (note: inputs will not be padded to 32 bytes)
    //function concatenateAndHash(
        //bytes memory lhs,
        //bytes memory rhs
    //)internal pure returns(
        //bytes memory
    //){
        //return keccak256(
            //abi.encode(lhs, rhs)
        //);
    //}
    function concatenateAndHash(
        bytes memory lhs,
        bytes memory rhs
    )internal pure returns(
        bytes memory
    ){
        return keccak256(
            abi.encodePacked(lhs, rhs)
        );
    }

    //function concatenateAndHashSignature(
        //bytes memory lhs,
        //bytes memory rhs
    //)internal pure returns(
        //bytes4
    //){
        //return bytes4(keccak256(
            //abi.encodePacked(lhs, rhs)
        //));
    //}
    function hash(
        bytes memory self
    )internal pure returns(
        bytes32
    ){
        return keccak256(self);
    }
    /// convenience function to get first 4 bytes of a hash of a bytes32,
    function hashSignature(
        bytes memory self
    )internal pure returns(
        bytes4
    ){
        return bytes4(
            keccak256(self)
        );
    }
    function hashSignatureEquals(
        bytes memory lhs,
        bytes4 rhs
    )internal pure returns(
        bool
    ){
        return hashSignature(lhs) == rhs;
    }
    
    function hashSignatureEquals(
        bytes memory lhs,
        bytes memory rhs
    )internal pure returns(
        bool
    ){
        return hashSignature(lhs) ^ hashSignature(rhs) == 0x00000000;
    }
}