// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256ToString.sol";
//import "./abiEncode.sol";

/// @title bytes32 To String Utilities
/// @author Tyler R. Drury - 17/3/2021, All Rights Reserved
/// @notice trivial functions for converting bytes32 to various string encodings
library bytes32ToString
{
    using uint256ToString for uint256;
    using stringUtilities for string;
    
    /**
     * string encodings (decimal, hexadecimal, octal etc)
    */
    /// @return octal formatted string [0-7]
    function octal(
        bytes32 value
    ) public pure
        returns(string memory)
    {
        return uint256(value).octal();
    }
    /// @return decimal formatted string [0-9] (without leading '0x')
    function decimal(
        bytes32 value
    ) public pure
        returns(string memory)
    {
        return uint256(value).decimal();
        
    }
    /// @return hex string [0-F] (without leading '0x')
    function hexadecimal(
        bytes32 value
    ) public pure
        returns(string memory)
    {
        return uint256(value).hexadecimal();
    }
    /**
     * Concatenation
    */
    //function concatenate(
        //bytes32 lhs,
        //bytes32 rhs
    //) public pure
        //returns(string memory)
    //{
        //return string(lhs).concatenate(
            //string(rhs)
        //);
    //}
    
    function concatenateAsDecimal(
        bytes32 lhs,
        bytes32 rhs
    ) public pure
        returns(string memory)
    {
        return uint256(lhs).decimal().concatenate(
            uint256(rhs).decimal()
        );
    }
    /// @dev concatenate the string hexadecimal repressentation of lhs,
    /// with the hexadecimal repressentation of rhs
    function concatenateAsHex(
        bytes32 lhs,
        bytes32 rhs
    ) public pure
        returns(string memory)
    {
        return uint256(lhs).hexadecimal().concatenate(
            uint256(rhs).hexadecimal()
        );
    }
    //function saltAsHexAndHash(
    function saltAndHash(
        bytes32 lhs,
        bytes32 rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(abi.encodePacked(
            lhs,
            rhs
        ));
    }
    function saltAsDecimalAndHash(
        bytes32 lhs,
        bytes32 rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(
            abi.encodePacked(
                uint256(lhs).decimal(),
                uint256(rhs).decimal()
            )
        );
    }
    function saltAsHexAndHash(
        bytes32 lhs,
        bytes32 rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(
            abi.encodePacked(
                uint256(lhs).hexadecimal(),
                uint256(rhs).hexadecimal()
            )
        );
    }
    
    //function saltAsDecimalAndHashAsString(
        //bytes32 lhs,
        //bytes32 rhs
    //) public pure
        //returns(string memory)
    //{
        //return string(saltAsDecimalAndHash(
    //        lhs,
    //        rhs
    //    ));
    //}
    //function saltAsHexAndHashAsString(
    //    bytes32 lhs,
    //    bytes32 rhs
    //) public pure
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
    //function saltAsDecimalHashAndMask(
        //bytes32 lhs,
        //bytes32 rhs,
        //bytes32 mask
    //) public pure
        //returns(string memory)
    //{
        //return LogicalBytes.xor(
            //saltAsDecimalAndHash
                //lhs,
                //rhs
            //),
            //mask
        //);
    //}
    //function saltAsHexHashAndMask(
        //bytes32 lhs,
        //bytes32 rhs,
        //bytes32 mask
    //) public pure
        //returns(string memory)
    //{
        //return LogicalBytes.xor(
            //saltAsHexAndHash(
                //lhs,
                //rhs
            //),
            //mask
        //);
    //}
}