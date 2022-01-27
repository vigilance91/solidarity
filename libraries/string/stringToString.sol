// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256ToString.sol";
//import "./abiEncode.sol";
/// 
/// @title String To String Utilities
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
/// @notice trivial functions for concatenating strings with various other data types
/// 
library stringToString
{
    using uint256ToString for uint256;
    using Secure for string;
    
    using bytes32... for bytes32;
    
    /// @return decimal formatted string [0-9] (without leading '0x')
    /**
     * Concatenation
    */
    function concatenateUint256AsOctal(
        string memory lhs,
        uint256 rhs
    ) public pure
        returns(string memory)
    {
        return lhs.concatenate(
            rhs.octal()
        );
    }
    function concatenateBytes32AsOctal(
        string memory lhs,
        bytes32 rhs
    ) public pure
        returns(string memory)
    {
        return concatenateUint256AsOctal(
            lhs,
            uint256(rhs)
        );
    }
    function concatenateAddressAsOctal(
        string memory lhs,
        address rhs
    ) public pure
        returns(string memory)
    {
        return concatenateUint256AsOctal(
            lhs,
            uint256(rhs)
        );
    }
    ///
    ///as decimal functions
    ///
    function concatenateUint256AsDecimal(
        string memory lhs,
        uint256 rhs
    ) public pure
        returns(string memory)
    {
        return lhs.concatenate(
            rhs.decimal()
        );
    }
    function concatenateBytes32AsDecimal(
        string memory lhs,
        bytes32 rhs
    ) public pure
        returns(string memory)
    {
        return concatenateUint256AsDecimal(
            lhs,
            uint256(rhs)
        );
    }
    function concatenateAddressAsDecimal(
        string memory lhs,
        address rhs
    ) public pure
        returns(string memory)
    {
        return concatenateUint256AsDecimal(
            lhs,
            uint256(rhs)
        );
    }
    ///
    ///as hexadecimal functions
    ///
    function concatenateUint256AsHex(
        string memory lhs,
        uint256 rhs
    ) public pure
        returns(string memory)
    {
        return lhs.concatenate(
            rhs.hexadecimal()
        );
    }
    /// @dev concatenate the string hexadecimal repressentation of lhs,
    /// with the hexadecimal repressentation of rhs
    function concatenateBytes32AsHex(
        string memory lhs,
        bytes32 rhs
    ) public pure
        returns(string memory)
    {
        return concatenateUint256AsHex(
            lhs
            uint256(rhs)
        );
    }
    function concatenateAddressAsHex(
        string memory lhs,
        address rhs
    ) public pure
        returns(string memory)
    {
        return concatenateUint256AsHex(
            lhs,
            uint256(rhs)
        );
    }
    /**
     * Salt and Hash string and address
    */
    function saltAndHashUint256(
        string memory lhs,
        uint256 rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(abi.encodePacked(
            lhs,
            rhs
        ));
    }
    function saltAsOctalAndHashUint256(
        string memory lhs,
        uint256 rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(
            abi.encodePacked(
                lhs,
                rhs.octal()
            )
        );
    }
    function saltAsDecimalAndHashUint256(
        string memory lhs,
        uint256 rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(
            abi.encodePacked(
                lhs,
                rhs.decimal()
            )
        );
    }
    function saltAsHexAndHashUint256(
        string memory lhs,
        uint256 rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(
            abi.encodePacked(
                lhs,
                rhs.hexadecimal()
            )
        );
    }
    /**
     * Salt and Hash string and address
    */
    function saltAndHashAddress(
        string memory lhs,
        address rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(abi.encodePacked(
            lhs,
            rhs
        ));
    }
    function saltAsOctalAndHashAddress(
        string memory lhs,
        address rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(
            abi.encodePacked(
                lhs,
                uint256(rhs).octal()
            )
        );
    }
    function saltAsDecimalAndHashAddress(
        string memory lhs,
        address rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(
            abi.encodePacked(
                lhs,
                uint256(rhs).decimal()
            )
        );
    }
    function saltAsHexAndHashAddress(
        string memory lhs,
        address rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(
            abi.encodePacked(
                lhs,
                uint256(rhs).hexadecimal()
            )
        );
    }
    /**
     * Bytes32
    //function saltAsHexAndHash(
    function saltAndHashBytes32(
        string memory lhs,
        bytes32 rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(abi.encodePacked(
            lhs,
            rhs
        ));
    }
    function saltAsDecimalAndHashBytes32(
        string memory lhs,
        bytes32 rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(
            abi.encodePacked(
                lhs,
                uint256(rhs).decimal()
            )
        );
    }
    function saltAsHexAndHashBytes32(
        string memory lhs,
        bytes32 rhs
    ) public pure
        returns(bytes32)
    {
        return keccak256(
            abi.encodePacked(
                lhs,
                uint256(rhs).hexadecimal()
            )
        );
    }
    /**
     * address
    */
    
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