// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.7.0;
pragma experimental ABIEncoderV2;
///
/// @dev the EIP-1261 Transaction Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
///
library abiEncoderEIP1261
{
    //
    //void getter function signatures
    //
    bytes internal constant SIG_FORFEIT_MEMBERSHIP = 'forfeitMembership()';
    //
    bytes internal constant SIG_GET_ALL_MEMBERS = abi.encodeWithSignature('getAllMembers()');
    bytes internal constant SIG_GET_CURRENT_MEMBER_COUNT = abi.encodeWithSignature('getCurrentMemberCount()');
    //
    bytes internal constant SIG_GET_ATTRIBUTE_NAMES = abi.encodeWithSignature('getAttributeNames()');
    //
    //function stubs
    //
    string internal constant STUB_ADD_ATTRIBUTE_SET = 'addAttributeSet(bytes32,bytes32[])';
    string internal constant STUB_MODIFY_ATTRIBUTE_SET = 'modifyAttributeByIndex(address,uint,uint)'; 
    //
    string internal constant STUB_REQUEST_MEMBERSHIP = 'requestMembership(uint[])'; 
    //
    string internal constant STUB_APPROVE_REQUEST = 'approveRequest(address)'; 
    string internal constant STUB_DISCARD_REQUEST = 'discardRequest(address)'; 
    //
    string internal constant STUB_ASSIGN_TO = 'assignTo(address,uint[])'; 
    string internal constant STUB_REVOKE_FROM = 'revokeFrom(address)'; 
    //
    string internal constant STUB_IS_CURRENT_MEMBER = 'isCurrentMember(address)'; 
    //
    string internal constant STUB_GET_ATTRIBUTE_EXHAUSTIVE_COLLECTION = 'getAttributeExhaustiveCollection(bytes32)'; 
    //
    //string internal constant STUB_ = 'getAllMembers()'; 
    //string internal constant STUB_ = 'getCurrentMemberCount()'; 
    //
    //string internal constant STUB_ = 'getAttributeNames()';
    string internal constant STUB_GET_ATTRIBUTES = 'getAttributes(address)';
    string internal constant STUB_GET_ATTRIBUTE_BY_INDEX = 'getAttributeByIndex(address,uint)';
    /// 
    /// @return {bytes}
    /// 
    function addAttributeSet(
        bytes32 name,
        bytes32[] calldata values
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_ADD_ATTRIBUTE_SET,
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
        return abi.encodeWithSignature(
            STUB_MODIFY_ATTRIBUTE_SET,
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
        return abi.encodeWithSignature(
            STUB_REQUEST_MEMBERSHIP,
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
        return abi.encodeWithSignature(
            STUB_APPROVE_REQUEST,
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
        return abi.encodeWithSignature(
            STUB_DISCARD_REQUEST,
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
        return abi.encodeWithSignature(
            STUB_ASSIGN_TO,
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
        return abi.encodeWithSignature(
            STUB_REVOKE_FROM,
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
        return abi.encodeWithSignature(
            STUB_IS_CURRENT_MEMBER,
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
        return abi.encodeWithSignature(
            STUB_GET_ATTRIBUTE_EXHAUSTIVE_COLLECTION,
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
        return abi.encodeWithSignature(
            STUB_GET_ATTRIBUTES,
            account
        );
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
        return abi.encodeWithSignature(
            STUB_GET_ATTRIBUTE_BY_INDEX,
            account,
            attributeIndex
        );
    }
}