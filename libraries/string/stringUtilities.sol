// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
//import "https://github.com/vigilance91/solidarity/constraints/addressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Logic.sol";
//import "./BytesUtilities.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/stringLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/stringConstraints.sol";

/// @title String Utilities
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @notice trivial strings convenience functions not provided natively by Solidity.
library stringUtilities
{
    //using logicConstraints for bool;
    //using Bytes32Logic for bytes32;
    //using addressLogic for address;
    
    using stringLogic for string;
    
    function concatenate(
        string memory lhs,
        string memory rhs
    )internal pure returns(
        string memory
    ){
        logicConstraints.requireTrue(
            lhs.notEmpty() && rhs.notEmpty(),
            "empty string"
        );
        
        return string(abi.encodePacked(lhs, rhs));
    }
    /// @dev convert rhs direct to string() and then concatenate with lhs
    /**
    function concatenate(
        string memory lhs,
        bytes32 rhs
    )internal pure returns(
        string memory
    ){
        logicConstraints.requireTrue(
            lhs.notEmpty(), //&& rhs.notEmpty(),
            //ErrorString.empty
            'empty string'
        );
        return string(
            abi.encodePacked(lhs, string(bytes(rhs)))
        );
    }
    */
    function hash(
        string memory self
    )internal pure returns(
        bytes32
    ){
        return keccak256(bytes(self));
    }
    /// todo change to concatenateAndHash
    function saltAndHash(
        string memory lhs,
        string memory rhs
    )internal pure returns(
        bytes32
    ){
        //salting empty string is point and a waste of gas
        logicConstraints.requireTrue(
            lhs.notEmpty() && rhs.notEmpty(),
            "empty string"
        );
        
        return keccak256(
            abi.encodePacked(lhs, rhs)
        );
    }
    /// convenience function to get first 4 bytes of a string's hash,
    /// if the string is a function identifier/signature,
    /// the return of this function is considered that function's selector by the EVM
    function hashSignature(
        string memory self
    )internal pure returns(
        bytes4
    ){
        //logicConstraints.requireTrue(
            //lhs.notEmpty(),
            //"empty string"
        //);
        return bytes4(
            hash(self)
        );
    }
    function hashSignatureEquals(
        string memory lhs,
        bytes4 rhs
    )internal pure
        returns(bool)
    {
        return hashSignature(lhs) == rhs;
    }
    
    //function hashSignatureEquals(
        //string memory lhs,
        //string memory rhs
    //)internal pure returns(
        //bool
    //){
        //return hashSignature(lhs) ^ hashSignature(rhs) == 0;
    //}
    
    /**
    /// abi endcode does not currently work as intended
    /// @return the hashed value of lhs + rhs, as a string instead of bytes32
    function hashAsString(
        string memory self
    )internal pure returns(
        string memory
    ){
        return string(
            abi.encodePacked(
                keccak256(bytes(self))
            )
        );
    }
    /// @return the hashed value of lhs + rhs, as a string instead of bytes32
    function saltAndHashAsString(
        string memory lhs,
        string memory rhs
    )internal pure returns(
        string memory
    ){
        //salting empty string is point and a waste of gas
        logicConstraints.requireTrue(
            lhs.notEmpty() && rhs.notEmpty(),
            "empty string"
        );
        
        return string(
            abi.encodePacked(
                saltAndHash(
                    lhs,
                    rhs
                )
            )
        );
    }
    */
    
    /// 
    /// @dev this method does not take into consideration character encodings (only raw bytes),
    /// thus does not return the expected number if wanting to get the total
    /// number of human readable characters in a string.
    /// Please use characterCount for that use case.
    /// 
    /// @return {uint} number in individual bytes within a string `s`
    /// 
    /// @param s {string}
    /// 
    function byteLength(
        string memory s
    )internal pure returns(
        uint
    ){
        return bytes(s).length;
    }
    /// 
    /// @dev determines the number of characters in a string (the string's true length)
    /// as used in the ENS domain repository here:
    ///     https://github.com/ensdomains/ens-contracts/blob/52d8297b1634dbed7dc1b4b8a2c3b9faa6b7de77/contracts/wrapper/BytesUtil.sol
    /// 
    /// @return {uint} length of string `s` in characters
    /// 
    /// @param s {string}
    /// 
    function characterCount(
        string memory s
    )internal pure returns(
        uint
    ){
        uint len;   //defaults to 0
        uint i = 0; //defaults to 0
        
        bytes B = bytes(s);
        uint L = B.length;
        
        bytes1 b = 0x00;
        
        //todo make constants and move to library bytes1Logic
        bytes1 _80 = 0x80;  //> 128 range characters (uft-8 characters above ascii DEL)
        bytes1 _E0 = 0xE0;  //> 224 range characters (3 bytes)
        bytes1 _F0 = 0xF0;  //> 240 range characters (4 bytes)
        bytes1 _F8 = 0xF8;  //> 248 range characters (5 bytes)
        bytes1 _FC = 0xFC;  //> 252 range characters (6 bytes)
        
        for(len = 0; i < L; len++){
            b = B[i];
            
            if(b < _80){
                i += 1;
            }
            else if(b < _E0){
                i += 2;
            }
            else if(b < _F0){
                i += 3;
            }
            else if(b < _F8){
                i += 4;
            }
            else if(b < _FC){
                i += 5;
            }
            else{
                i += 6;
            }
        }
        
        return len;
    }
}