// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256ToString.sol";
///
/// @title block.timestamp To String Utilities
/// @author Tyler R. Drury - 27/4/2021, All Rights Reserved
/// @notice trivial functions for converting block.timestamp to strings or bytes32 hashes, etc,
/// which are not provided natively by Solidity
///
/// NOTE:
///     Some of these operations may consume relatively large amount of gas due to string operations,
///     looping and repeated calls to abi.encodePacked under the hood
///
library blockGasToString
{
    using uint256ToString for uint;
    /**
    * gas left
    assembly instructions
        * gas() - gas still available to execution
        * gasprice() - gas price of the transaction
        * gaslimit() -  block gas limit of the current block
    */
    /// @return octal formatted string [0-7]
    function octal(
    )internal pure returns(
        string memory
    ){
        return block.timestamp.octal();
    }
    /// @return decimal formatted string [0-9] (without leading '0x')
    function decimal(
    )internal pure returns(
        string memory
    ){
        return block.timestamp.decimal();
    }
    /// @return hex string [0-F] (without leading '0x')
    function hexadecimal(
    )internal pure returns(
        string memory
    ){
        return block.timestamp.hexadecimal();
    }
    /**
     * string concatenation
    */
    /// @dev concatenate the string octal repressentation of block.timestamp,
    /// with the octal repressentation of rhs
    function prefixAsOctal(
        uint rhs
    )internal pure
        returns(string memory)
    {
        return block.timestamp.concatenateAsOctal(
            rhs
        );
    }
    /// @dev concatenate the string decimal repressentation of block.timestamp,
    /// with the decimal repressentation of rhs
    function prefixAsDecimal(
        uint256 rhs
    )internal pure returns(
        string memory
    ){
        return block.timestamp.concatenateAsDecimal(
            rhs
        );
    }
    /// @dev concatenate the string hexadecimal repressentation of block.timestamp,
    /// with the hexadecimal repressentation of rhs
    function prefixAsHex(
        uint256 rhs
    ) internal pure returns(
        string memory
    ){
        return lhs.concatenateAsHexadecimal(
            rhs
        );
    }
    /// @dev concatenate the string octal repressentation of lhs,
    /// with the octal repressentation of block.timestamp
    function suffixAsOctal(
        uint lhs
    )internal pure returns(
        string memory
    ){
        return lhs.concatenateAsOctal(
            block.timestamp
        );
    }
    /// @dev concatenate the string decimal repressentation of lhs,
    /// with the decimal repressentation of block.timestamp
    function suffixAsDecimal(
        uint256 lhs
    )internal pure returns(
        string memory
    ){
        return lhs.concatenateAsDecimal(
            block.timestamp
        );
    }
    /// @dev concatenate the string hexadecimal repressentation of lhs,
    /// with the hexadecimal repressentation of block.timestamp
    function suffixAsHexadecimal(
        uint256 lhs
    ) internal pure
        returns(string memory)
    {
        return lhs.concatenateAsHexadecimal(
            block.timestamp
        );
    }
    /**
     * salt and hash functions
    */
    function prefixSaltAndHash(
        uint256 rhs
    ) internal pure returns(
        bytes32
    ){
        return block.timestamp.saltAndHash(
            rhs
        );
    }
    function suffixSaltAndHash(
        uint256 lhs
    ) internal pure returns(
        bytes32
    ){
        return lhs.saltAndHash(
            block.timestamp
        );
    }
}