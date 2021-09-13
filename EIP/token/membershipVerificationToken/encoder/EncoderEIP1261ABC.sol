// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/token/membershipVerificationToken/encoder/abiEncoderEIP1261.sol";
import "https://github.com/vigilance91/solidarity/EIP/token/membershipVerificationToken/encoder/iEncoderEIP1261.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/TokenIdentifier/encoder/EncoderTokenIdentifierABC.sol";
///
/// @title EIP-1261 MembershipVerification Token Transaction ABI Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// convenience library for creating encoded signatures for low-level address call operations
///
abstract contract EncoderEIP1261ABC is iEncoderEIP1261,
    EncoderTokenIdentifierABC
{
    using abiEncoderEIP1261 for address;
    
    constructor(
    )internal
        EncoderTokenIdentifierABC()
    {
    }
    function addAttributeSet(
        bytes32 name,
        bytes32[] calldata values
    )external view override returns(
        bytes memory
    ){
        return abiEncoderEIP1261.addAttributeSet(
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
    )public view override returns(
        bytes memory
    ){
        return to.modifyAttributeByIndex(
            attributeIndex,
            modifiedValueIndex
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function requestMembership(
        uint[] calldata attributeIndexes
    )external view returns(
        bytes memory
    ){
        return abiEncoderEIP1261.requestMembership(
            attributeIndexes
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function approveRequest(
        address account
    )public view override returns(
        bytes memory
    ){
        return account.approveRequest();
    }
    /// 
    /// @return {bytes}
    /// 
    function discardRequest(
        address account
    )public view override returns(
        bytes memory
    ){
        return account.discardRequest();
    }
    /// 
    /// @return {bytes}
    /// 
    function assignTo(
        address account,
        uint[] calldata attributeIndexes
    )external view override returns(
        bytes memory
    ){
        return account.assignTo(
            attributeIndexes
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function revokeFrom(
        address account
    )public view override returns(
        bytes memory
    ){
        return account.revokeFrom();
    }
    /// 
    /// @return {bytes}
    /// 
    function isCurrentMember(
        address account
    )public view override returns(
        bytes memory
    ){
        return account.isCurrentMember();
    }
    /// 
    /// @return {bytes}
    /// 
    function getAttributeExhaustiveCollection(
        bytes32 name
    )public view override returns(
        bytes memory
    ){
        return abiEncoderEIP1261.getAttributeExhaustiveCollection(
            name
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function getAttributes(
        address account
    )public view override returns(
        bytes memory
    ){
        return account.getAttributes();
    }
    /// 
    /// @return {bytes}
    /// 
    function getAttributeByIndex(
        address account,
        uint attributeIndex
    )public view override returns(
        bytes memory
    ){
        return account.getAttributeByIndex(
            attributeIndex
        );
    }
}