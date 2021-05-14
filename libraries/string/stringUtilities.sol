// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
//import "https://github.com/vigilance91/solidarity/constraints/AddressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Logic.sol";
//import "./BytesUtilities.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/StringLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/StringConstraints.sol";

/// @title String Utilities
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @notice trivial strings convenience functions not provided natively by Solidity.
library stringUtilities
{
    //using LogicConstraints for bool;
    //using Bytes32Logic for bytes32;
    //using AddressLogic for address;
    using StringLogic for string;
    
    function concatenate(
        string memory lhs,
        string memory rhs
    )internal pure returns(
        string memory
    ){
        LogicConstraints.requireTrue(
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
        LogicConstraints.requireTrue(
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
        LogicConstraints.requireTrue(
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
        //LogicConstraints.requireTrue(
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
        LogicConstraints.requireTrue(
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
}