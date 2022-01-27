// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256ToString.sol";
///
/// @title block.number To String Utilities
/// @author Tyler R. Drury - 10/4/2021, All Rights Reserved
/// @notice trivial functions for converting block.number to strings or bytes32 hashes, etc,
/// which are not provided natively by Solidity
///
/// NOTE:
///     Some of these operations may consume relatively large amount of gas due to string operations,
///     looping and repeated calls to abi.encodePacked under the hood
///
library blockNumberToString
{   
    using uint256ToString for uint;
    
    ///
    /// encodings (decimal, hexadecimal, octal etc)
    ///
    
    /// @return octal formatted string [0-7]
    function octal(
    )public pure returns(
        string memory
    ){
        return block.number.octal();
    }
    /// @return decimal formatted string [0-9] (without leading '0x')
    function decimal(
    )public pure returns(
        string memory
    ){
        return block.number.decimal();
    }
    /// @return hex string [0-F] (without leading '0x')
    function hexadecimal(
    )public pure returns(
        string memory
    ){
        return block.number.hexadecimal();
    }
    
    ///
    /// string concatenation
    ///
    
    /// @dev concatenate the string octal repressentation of block.number,
    /// with the octal repressentation of rhs
    function prefixAsOctal(
        uint rhs
    )public pure returns(
        string memory
    ){
        return block.number.concatenateAsOctal(
            rhs
        );
    }
    /// @dev concatenate the string decimal repressentation of block.number,
    /// with the decimal repressentation of rhs
    function prefixAsDecimal(
        uint256 rhs
    )public pure returns(
        string memory
    ){
        return block.timestamp.concatenateAsDecimal(
            rhs
        );
    }
    /// @dev concatenate the string hexadecimal repressentation of block.number,
    /// with the hexadecimal repressentation of rhs
    function prefixAsHex(
        uint256 rhs
    )public pure returns(
        string memory
    ){
        return lhs.concatenateAsHexadecimal(
            rhs
        );
    }
    /// @dev concatenate the string octal repressentation of lhs,
    /// with the octal repressentation of block.number
    function suffixAsOctal(
        uint lhs
    )public pure returns(
        string memory
    ){
        return lhs.concatenateAsOctal(
            block.number
        );
    }
    /// @dev concatenate the string decimal repressentation of lhs,
    /// with the decimal repressentation of block.number
    function suffixAsDecimal(
        uint256 lhs
    )public pure returns(
        string memory
    ){
        return lhs.concatenateAsDecimal(
            block.number
        );
    }
    /// @dev concatenate the string hexadecimal repressentation of lhs,
    /// with the hexadecimal repressentation of block.number
    function suffixAsHexadecimal(
        uint256 lhs
    )public pure returns(
        string memory
    ){
        return lhs.concatenateAsHexadecimal(
            block.number
        );
    }
    ///
    /// salt and hash functions
    ///
    function prefixSaltAndHash(
        uint256 rhs
    ) public pure returns(
        bytes32
    ){
        return block.number.saltAndHash(
            rhs
        );
    }
    function suffixSaltAndHash(
        uint256 lhs
    )public pure returns(
        bytes32
    ){
        return lhs.saltAndHash(
            block.number
        );
    }
}