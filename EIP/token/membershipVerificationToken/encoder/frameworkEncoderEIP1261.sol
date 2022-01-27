// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.7.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/EIP/token/membershipVerificationToken/encoder/iEncoderEIP1261.sol";

//import "../TokenIdentifier/iTokenIdentifier.sol";
///
/// @dev the EIP1261 Transaction Encoder Framework Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
///
library frameworkEncoderEIP1261
    ////iTokenIdentifier
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderEIP1261).interfaceId;
    
    function _requireSupportsInterface(
        address encoder
    )private
    {
        encoder.requireNotNull();
        encoder.isContract().requireTrue(
            'address not a contract'
        );
        
        encoder.supportsInterface(_INTERFACE_ID).requireTrue(
            'contract does not implement iEncoderEIP1261'
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function addAttributeSet(
        address encoder,
        bytes32 name,
        bytes32[] calldata values
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1261(encoder).addAttributeSet(
            name,
            values
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function modifyAttributeByIndex(
        address encoder,
        address to,
        uint attributeIndex,
        uint modifiedValueIndex
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1261(encoder).modifyAttributeByIndex(
            to,
            attributeIndex,
            modifiedValueIndex
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function requestMembership(
        address encoder,
        uint[] calldata attributeIndexes
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1261(encoder).requestMembership(
            attributeIndexes
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function approveRequest(
        address encoder,
        address account
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1261(encoder).approveRequest(
            account
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function discardRequest(
        address encoder,
        address account
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1261(encoder).discardRequest(
            account
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function assignTo(
        address encoder,
        address account,
        uint[] calldata attributeIndexes
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1261(encoder).assignTo(
            account,
            attributeIndexes
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function revokeFrom(
        address encoder,
        address account
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1261(encoder).revokeFrom(
            account
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function isCurrentMember(
        address encoder,
        address account
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1261(encoder).isCurrentMember(
            account
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function getAttributeExhaustiveCollection(
        address encoder,
        bytes32 name
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1261(encoder).getAttributeExhaustiveCollection(
            name
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function getAttributes(
        address encoder,
        address account
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1261(encoder).getAttributes(
            account
        );
    }
    /// 
    /// @return {bytes}
    /// 
    function getAttributeByIndex(
        address encoder,
        address account,
        uint attributeIndex
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1261(encoder).getAttributeByIndex(
            account,
            attributeIndex
        );
    }
}