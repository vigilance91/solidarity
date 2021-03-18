// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/stringUtilities.sol";
//import "./abiEncode.sol";

/// @title Uint256 To String Utilities
/// @author Tyler R. Drury - 12/1/2021, All Rights Reserved
/// @notice trivial functions for converting uint256 and address types to strings,
/// and/or combining uint256 and address types, which are not provided natively by Solidity.
/// These operations may consume relatively large amount of gas due to string operations, looping and repeated calls to abi.encodePacked,
/// however they can be used to securely salt then hash an address for use as a key in a mapping without directly exposing the client's address on the blockchain
library uint256ToString
{
    using SafeMath for uint256;
    
    using Secure for string;
    
    //uint8 public constant ASCII_NUMBERS_START = 0x30;
    //uint8 public constant ASCII_NUMBERS_END = 0x39;
    
    /**
     * encodings (decimal, hexadecimal, octal etc)
    */
    
    /// @return octal formatted string [0-7]
    function octal(
        uint256 value
    ) public pure
        returns(string memory)
    {
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
        uint256 value
    ) public pure
        returns(string memory)
    {
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
        uint256 value
    ) public pure
        returns(string memory)
    {
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
    function concatenateAsOctal(
        uint256 lhs,
        uint256 rhs
    ) public pure
        returns(string memory)
    {
        return octal(lhs).concatenate(
            octal(rhs)
        );
    }
    function concatenateAsDecimal(
        uint256 lhs,
        uint256 rhs
    ) public pure
        returns(string memory)
    {
        return decimal(lhs).concatenate(
            decimal(rhs)
        );
    }
    /// @dev concatenate the string hexadecimal repressentation of lhs,
    /// with the hexadecimal repressentation of rhs
    function concatenateAsHex(
        uint256 lhs,
        uint256 rhs
    ) public pure
        returns(string memory)
    {
        return hexadecimal(lhs).concatenate(
            hexadecimal(rhs)
        );
    }
    /**
     * salt and hash functions
    */
    function saltAndHash(
        uint256 lhs,
        uint256 rhs
    ) public pure
        returns(bytes32)
    {
        //return Secure.saltAndHash(hexadecimal(lhs),hexadecimal(uint256(rhs)));
        return keccak256(abi.encodePacked(
            hexadecimal(lhs),
            hexadecimal(uint256(rhs))
        ));
    }
    
    //function saltAsDecimalAndHash(
        //string memory salt,
        //uint256 rhs
    //) public pure
        //returns(string memory)
    //{
        //return keccak256(abi.encodePacked(
            //salt,
            //decimal(rhs)
        //));
    //}
    //function saltAsHexAndHash(
        //string memory salt,
        //uint256 rhs
    //) public pure
        //returns(string memory)
    //{
        //return keccak256(abi.encodePacked(
            //salt,
            //hexadecimal(rhs)
        //));
    //}
    
    //function saltAsDecimalAndHashAsString(
    //    address lhs,
    //    address rhs
    //) public pure
    //    returns(string memory)
    //{
    //    return string(saltAsDecimalAndHash(
    //        lhs,
    //        rhs
    //    ));
    //}
   
   //function saltAsHexAndHashAsString(
    //    address lhs,
    //    address rhs
    //) public pure
    //    returns(string memory)
    //{
    //    return string(saltAndHash(
    //        lhs,
    //        rhs
    //    ));
    //}
   
    /**
     * Masked salted hashes
    */
    //function saltAsDecimalHashAndMask(
        //uint256 lhs,
        //uint256 rhs,
        //bytes32 mask
    //) public pure
        //returns(string memory)
    //{
        //return  LogicalBytes.xor(
            //keccak256(abi.encodePacked(
                //decimal(lhs),
                //decimal(rhs)
            //)),
            //mask
        //);
    //}
    //function saltAsHexHashAndMask(
        //uint256 lhs,
        //uint256 rhs,
        //bytes32 mask
    //) public pure
        //returns(string memory)
    //{
        //return  LogicalBytes.xor(
            //keccak256(abi.encodePacked(
                //hexadecimal(lhs),
                //hexadecimal(rhs)
            //)),
            //mask
        //);
    //}
}