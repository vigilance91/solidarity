// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256ToString.sol";
//import "./abiEncode.sol";
/// 
/// @title Address To String Utilities
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/1/2021, All Rights Reserved
/// @notice trivial functions for converting address types to strings,
/// and/or combining uint256 and address types, which are not provided natively by Solidity
/// 
/// These operations may consume relatively large amount of gas due to string operations,
/// looping and repeated calls to abi.encodePacked,
/// however they can be used to securely salt then hash an address for use as a key in a mapping
/// without directly exposing the client's address on the blockchain
/// 
library addressToString
{   
    using uint256ToString for uint256;
    using stringUtilities for string;
    //using bytes32... for bytes32;
    /**
    *string encodings (decimal, hexadecimal, octal etc)
    */
    /// @return octal formatted string [0-7]
    function octal(
        address value
    )internal pure returns(
        string memory
    ){
        return uint256(value).octal();
    }
    /// @return decimal formatted string [0-9] (without leading '0x')
    function decimal(
        address value
    )internal pure returns(
        string memory
    ){
        return uint256(value).decimal();
    }
    /// @return hex string [0-F] (without leading '0x')
    function hexadecimal(
        address value
    )internal pure returns(
        string memory
    ){
        return uint256(value).hexadecimal();
    }
    
    function concatenateAsOctal(
        address lhs,
        address rhs
    )internal pure returns(
        string memory
    ){
        return uint256(lhs).octal().concatenate(
            uint256(rhs).octal()
        );
    }
    function concatenateAsDecimal(
        address lhs,
        address rhs
    )internal pure returns(
        string memory
    ){
        return uint256(lhs).decimal().concatenate(
            uint256(rhs).decimal()
        );
    }
    /// @dev concatenate the string hexadecimal repressentation of lhs,
    /// with the hexadecimal repressentation of rhs
    function concatenateAsHex(
        address lhs,
        address rhs
    )internal pure returns(
        string memory
    ){
        return uint256(lhs).hexadecimal().concatenate(
            uint256(rhs).hexadecimal()
        );
    }
    function saltAsOctalAndHash(
        address lhs,
        address rhs
    )internal pure returns(
        bytes32
    ){
        return keccak256(abi.encodePacked(
            uint256(lhs).octal(),
            uint256(rhs).octal()
        ));
    }
    function saltAsDecimalAndHash(
        address lhs,
        address rhs
    )internal pure returns(
        bytes32
    ){
        return keccak256(abi.encodePacked(
            uint256(lhs).decimal(),
            uint256(rhs).decimal()
        ));
    }
    //raw encodes the arguments as bytes, concatenating them together then returning the resulting sha3 hash
    //function encodeAndHash(
        //address lhs,
        //address rhs
    //)internal pure returns(
        //bytes32
    //){
        //return keccak256(abi.encode(
            //lhs,
            //rhs
        //));
    //}
    //raw encodes the arguments as bytes packed to 32 bytes each, then concatenates them together, returning the resulting sha3 hash
    //function encodePackedAndHash(
        //address lhs,
        //address rhs
    //)internal pure returns(
        //bytes32
    //){
        //return keccak256(abi.encodePacked(
            //lhs,
            //rhs
        //));
    //}
    
    function encodeAndHashSignature(
        address lhs,
        address rhs
    )internal pure returns(
        bytes4
    ){
        return bytes4(
            encodeAndHash(lhs,rhs)
        );
    }
    function encodePackedAndHashSignature(
        address lhs,
        address rhs
    )internal pure returns(
        bytes4
    ){
        return bytes4(
            encodePackedAndHash(lhs,rhs)
        );
    }
    
    function saltAndHash(
        address lhs,
        address rhs
    )internal pure returns(
        bytes32
    ){
        //return Secure.saltAndHash(uint256(lhs).hexadecimal(),uint256(rhs).hexadecimal());
        return keccak256(abi.encodePacked(
            uint256(lhs).hexadecimal(),
            uint256(rhs).hexadecimal()
        ));
    }
    
    //function saltAsOctalAndHashAsString(
    //    address lhs,
    //    address rhs
    //)internal pure
    //    returns(string memory ret)
    //{
    //    bytes32 res = saltAsOctalAndHash(
    //        lhs,
    //        rhs
    //    );
    //    
    //    ret = string(res);
    //}
    
    //function saltAsDecimalAndHashAsString(
    //    address lhs,
    //    address rhs
    //)internal pure
    //    returns(string memory ret)
    //{
    //    bytes32 res = saltAsDecimalAndHash(
    //        lhs,
    //        rhs
    //    );
    //    
    //    ret = string(res);
    //}
    
    //function saltAsHexAndHashAsString(
    //    address lhs,
    //    address rhs
    //)internal pure
    //    returns(string memory)
    //{
    //    return string(saltAsHexAndHash(
    //        lhs,
    //        rhs
    //    ));
    //}
   
    /**
     * Masked Hashes
    */
    //function saltAsOctalHashAndMask(
        //address lhs,
        //address rhs,
        //bytes32 mask
    //)internal pure returns(
        //string memory
    //){
        //return LogicalBytes.xor(
            //keccak256(abi.encodePacked(
                //uint256(lhs).octal(),
                //uint256(rhs).octal()
            //)),
            //mask
        //);
    //}
    //function saltAsDecimalHashAndMask(
        //uint256 lhs,
        //address rhs,
        //bytes32 mask
    //)internal pure returns(
        //string memory
    //){
        //return LogicalBytes.xor(
            //keccak256(abi.encodePacked(
                //decimal(lhs),
                //decimal(uint256(rhs))
            //)),
            //mask
        //);
    //}
    //function saltAsHexHashAndMask(
        //uint256 lhs,
        //address rhs,
        //bytes32 mask
    //)internal pure returns(
        //string memory
    //){
        //return LogicalBytes.xor(
            //keccak256(abi.encodePacked(
                //hexadecimal(lhs),
                //hexadecimal(uint256(rhs))
            //)),
            //mask
        //);
    //}
}