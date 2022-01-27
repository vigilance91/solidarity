// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/string/stringUtilities.sol";
/// 
/// @title msgValue To String Utilities
/// @author Tyler R. Drury - 12/1/2021, All Rights Reserved
/// @notice trivial functions for converting uint256 and address types to strings,
/// and/or combining uint256 and address types, which are not provided natively by Solidity.
/// These operations may consume relatively large amount of gas due to string operations, looping and repeated calls to abi.encodePacked,
/// however they can be used to securely salt then hash an address for use as a key in a mapping without directly exposing the client's address on the blockchain
/// 
library msgValueToString
{
    using SafeMath for uint256;
    
    using stringUtilities for string;
    /**
     * encodings (decimal, hexadecimal, octal etc)
    */
    //function encode(
    //)internal view returns(
        //bytes memory
    //){
        //return abi.encode(msg.value);
    //}
    
    /// @return octal formatted string [0-7]
    function octal(
    )internal pure returns(
        string memory
    ){
        uint256 value = msg.value;
        
        if(value == 0){
            return "0";
        }
        
        string memory str = '';
        
        while(value > 0){
            //0x30 is the ascii/utf-8 code for '0',
            //begining the range of values repressenting numbers as a string
            str = string(abi.encodePacked(
                uint8( (value % 8) + 0x30), str)
            );
            value = value >> 3;
        }
        return str;
    }
    
    /// @return decimal formatted string [0-9] (without leading '0x')
    function decimal(
    )internal pure returns(
        string memory
    ){
        uint256 value = msg.value;
        
        if(value == 0){
            return "0";
        }
        
        string memory str;
        
        while(value > 0){
            str = string(abi.encodePacked(
                uint8( (value % 10) + 0x30), str)
            );
            value = value.div(10);
        }
        return str;
    }
    /// @return hex string [0-F] (without leading '0x')
    function hexadecimal(
    )internal pure returns(
        string memory
    ){
        uint256 value = msg.value;
        
        if(value == 0){
            return "0";
        }
        
        string memory str;
        
        while(value > 0){
            //value % 16 == value & (16 - 1), IF AND ONLY IF modulo is power of 2
            uint256 M = value & 15;
            
            str = string(abi.encodePacked(
                uint8(M + (M < 10 ? 0x30 : 0x57)), str)
                //uint8(M + (M < 10 ? 48 : 87)), str)
            );
            //x = x.div(16);
            value = value >> 4;
        }
        return str;
    }
    /**
     * string concatenation
    */
    /*
    //raw value encoding
    //function msgValueEncode(
    //)internal pure returns(
        //bytes memory
    //){
        //return abi.encode(
            //msg.value
        //);
    //}
    
    //function msgValueHash(
    //)internal pure returns(
        //bytes32
    //){
        //return keccak256(
            //msgValueEncode()
        //);
    //}
    
    //function msgValuePackedHash(
    //)internal pure returns(
        //bytes32
    //){
        //return keccak256(
            //msgValueEncodePacked()
        //);
    //}
    //encoded, arguments packed/padded to 32 bytes
    //function msgValueEncodePacked(
    //)internal pure returns(
        //bytes memory
    //){
        //return abi.encodePacked(
            //msg.value
        //);
    //}
    function msgValueEncode(
    )internal pure returns(
        bytes memory
    ){
        return abi.encode(
            msg.value
        );
    }
    //encoded, arguments packed/padded to 32 bytes
    function msgValueEncodePacked(
    )internal pure returns(
        bytes memory
    ){
        return abi.encodePacked(
            msg.value
        );
    }
    */
    function msgValueConcatenateAsOctal(
        uint256 rhs
    )internal pure returns(
        string memory
    ){
        return msgValueAsOctal().concatenate(
            rhs.octal()
        );
    }
    function msgValueAsConcatenateAsDecimal(
        uint256 rhs
    )internal pure returns(
        string memory
    ){
        return msgValueAsDecimal().concatenate(
            rhs.decimal()
        );
    }
    /// @dev concatenate the string hexadecimal repressentation of lhs,
    /// with the hexadecimal repressentation of rhs
    function msgValueAsConcatenateAsHex(
        uint256 rhs
    )internal pure returns(
        string memory
    ){
        return msgValueAsHexadecimal().concatenate(
            rhs.hexadecimal()
        );
    }
    /**
     * salt and hash functions
    */
    function saltAndHash(
        uint256 rhs
    )internal pure returns(
        bytes32
    ){
        return keccak256(abi.encodePacked(
            msg.value,
            rhs
        ));
    }
    function saltAsHexAndHash(
        uint256 rhs
    )internal pure returns(
        bytes32
    ){
        return keccak256(abi.encodePacked(
            msgValueAsHexadecimal(),
            rhs.hexadecimal()
        ));
    }
    
    //function saltAsDecimalAndHash(
        //string memory salt,
        //uint256 rhs
    //)internal pure returns(
        //bytes32
    //){
        //return keccak256(abi.encodePacked(
            //msgValueAsDecimal(),
            //rhs.decimal()
        //));
    //}
    
    //function saltAsDecimalAndHashAsString(
    //    address lhs,
    //    address rhs
    //)internal pure returns(
        //string memory
    //){
    //    return string(saltAsDecimalAndHash(
    //        lhs,
    //        rhs
    //    ));
    //}
   
   //function saltAsHexAndHashAsString(
    //    address lhs,
    //    address rhs
    //)internal pure returns(
        //string memory
    //){
    //    return string(saltAndHash(
    //        lhs,
    //        rhs
    //    ));
    //}
   
    /**
     * Masked salted hashes
    */
    //function saltHashAndMask(
        //uint256 rhs,
        //bytes32 mask
    //)inernal pure returns(
        string memory
    //){
        //return  LogicalBytes.xor(
            //keccak256(abi.encodePacked(
                //msg.value,
                //rhs
            //)),
            //mask
        //);
    //}
    //function saltAsOctalHashAndMask(
        //uint256 rhs,
        //bytes32 mask
    //)inernal pure returns(
        string memory
    //){
        //return  LogicalBytes.xor(
            //keccak256(abi.encodePacked(
                //msgValueAsOctal(),
                //rhs.octal()
            //)),
            //mask
        //);
    //}
    //function saltAsDecimalHashAndMask(
        //uint256 rhs,
        //bytes32 mask
    //)inernal pure returns(
        string memory
    //){
        //return  LogicalBytes.xor(
            //keccak256(abi.encodePacked(
                //msgValueAsDecimal(),
                //rhs.decimal()
            //)),
            //mask
        //);
    //}
    //function saltAsHexHashAndMask(
        //uint256 rhs,
        //bytes32 mask
    //)internal pure returns(
        //string memory
    //){
        //return  LogicalBytes.xor(
            //keccak256(abi.encodePacked(
                //msgValueAsHexadecimal(),
                //rhs.hexadecimal()
            //)),
            //mask
        //);
    //}
}