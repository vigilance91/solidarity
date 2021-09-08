// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/token/membershipVerificationToken/encoder/abiEncoderERC1261.sol";
import "https://github.com/vigilance91/solidarity/EIP/token/membershipVerificationToken/encoder/iEncoderEIP1261.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/TokenIdentifier/encoder/EncoderTokenIdentifierABC.sol";

//import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title EIP1261 Transaction ABI Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// convenience library for creating encoded signatures for low-level address call operations
///
abstract contract EncoderEIP1261 is iEncoderEIP1261,
    EncoderTokenIdentifierABC
{
    using abiEncoderERC1261 for address;
    
    constructor(
    )internal
        //ERC165()
        EncoderTokenIdentifierABC()
    {
        //todo register appropriate interface in derived class which inherits from ERC-165
        //_registerInterface(type(iEncoderERC1261).interfaceId);
    }
    function addAttributeSet(
        bytes32 name,
        bytes32[] calldata values
    )internal pure returns(
        bytes memory
    ){
        return abiEncoderERC1261.addAttributeSet(
            name,
            values
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function modifyAttributeByIndex(
        address to,
        uint attributeIndex,
        uint modifiedValueIndex
    )internal pure returns(
        bytes memory
    ){
        return abiEncoderERC1261.modifyAttributeByIndex(
            to,
            attributeIndex,
            modifiedValueIndex
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function requestMembership(
        uint[] calldata attributeIndexes
    )internal pure returns(
        bytes memory
    ){
        return abiEncoderERC1261.requestMembership(
            attributeIndexes
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function approveRequest(
        address account
    )internal pure returns(
        bytes memory
    ){
        return abiEncoderERC1261.approveRequest(
            account
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function discardRequest(
        address account
    )internal pure returns(
        bytes memory
    ){
        return abiEncoderERC1261.discardRequest(
            account
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function assignTo(
        address account,
        uint[] calldata attributeIndexes
    )internal pure returns(
        bytes memory
    ){
        return abiEncoderERC1261.assignTo(
            account,
            attributeIndexes
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function revokeFrom(
        address account
    )internal pure returns(
        bytes memory
    ){
        return abiEncoderERC1261.revokeFrom(
            account
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function isCurrentMember(
        address account
    )internal pure returns(
        bytes memory
    ){
        return abiEncoderERC1261.isCurrentMember(
            account
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function getAttributeExhaustiveCollection(
        bytes32 name
    )internal pure returns(
        bytes memory
    ){
        return abiEncoderERC1261.getAttributeExhaustiveCollection(
            name
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function getAttributes(
        address account
    )internal pure returns(
        bytes memory
    ){
        return abiEncoderERC1261.getAttributes(account);
    }
    /// 
    /// @return {bytes}
    /// 
    function getAttributeByIndex(
        address account,
        uint attributeIndex
    )internal pure returns(
        bytes memory
    ){
        return abiEncoderERC1261.getAttributeByIndex(
            account,
            attributeIndex
        );
    }
}