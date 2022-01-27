// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.7.0;
pragma experimental ABIEncoderV2;

//import "../TokenIdentifier/iTokenIdentifier.sol";
///
/// @dev Interface for the EIP1261 Transaction Encoder
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
///
interface iEncoderEIP1261
    ////iTokenIdentifier
{
    /// 
    /// @notice Adds a new attribute (key, value) pair to the set of pre-existing attributes.
    /// @dev Adds a new attribute at the end of the array of attributes and maps it to `values`.
    ///  Contract can set a max number of attributes and throw if limit is reached.
    /// 
    /// @param name hash of the attribute to be added.
    /// @param values List of values of the specified attribute.
    /// 
    function addAttributeSet(
        bytes32 name,
        bytes32[] calldata values
    )external view returns(
        bytes memory
    );
    /// 
    /// @notice Modifies the attribute value of a specific attribute for a given `_to` address.
    /// @dev Use appropriate checks for whether a user/admin can modify the data.
    ///  Best practice is to use onlyOwner modifier from ERC173.
    /// 
    /// @param to The address whose attribute is being modified.
    /// @param attributeIndex The index of attribute which is being modified.
    /// @param modifiedValueIndex The index of the new value which is being assigned to the user attribute.
    /// 
    function modifyAttributeByIndex(
        address to,
        uint attributeIndex,
        uint modifiedValueIndex
    )external view returns(
        bytes memory
    );
    /// 
    /// @notice Requests membership from any address.
    /// @dev Throws if the `msg.sender` already has the token.
    ///  The individual `msg.sender` can request for a membership if some existing criteria are satisfied.
    ///  When a membership is requested, this function emits the RequestedMembership event.
    ///  dev can store the membership request and use `approveRequest` to assign membership later
    ///  dev can also oraclize the request to assign membership later
    /// 
    /// @param {uint[]} attributeIndexes the attribute data associated with the member.
    ///  This is an array which contains indexes of attributes.
    /// 
    function requestMembership(
        uint[] calldata attributeIndexes
    )external view returns(
        bytes memory
    );
    /// 
    /// @notice User can forfeit his membership.
    /// @dev Throws if the `msg.sender` already doesn't have the token.
    ///  The individual `msg.sender` can revoke his/her membership.
    ///  When the token is revoked, this function emits the Revoked event.
    function forfeitMembership(
    )external view returns(
        bytes memory
    );

    /// @notice Owner approves membership from any address.
    /// @dev Throws if the `_user` doesn't have a pending request.
    ///  Throws if the `msg.sender` is not an owner.
    ///  Approves the pending request
    ///  Make oraclize callback call this function
    ///  When the token is assigned, this function emits the `ApprovedMembership` and `Assigned` events.
    /// @param account {address} address whose membership request will be approved.
    function approveRequest(
        address account
    )external view returns(
        bytes memory
    );
    /// 
    /// @notice Owner discards membership from any address.
    /// @dev Throws if the `account` doesn't have a pending request.
    ///  Throws if the `msg.sender` is not an owner.
    ///  Discards the pending request
    ///  Make oraclize callback call this function if criteria are not satisfied
    /// 
    /// @param account {address} address whose membership request will be discarded.
    /// 
    function discardRequest(
        address account
    )external view returns(
        bytes memory
    );
    /// 
    /// @notice Assigns membership of an MVT from owner address to another address.
    /// @dev Throws if the member already has the token.
    ///  Reverts if `to` is the zero address.
    ///  Throws if the `msg.sender` is not an owner.
    ///  The entity assigns the membership to each individual.
    ///  When the token is assigned, this function emits the Assigned event.
    /// 
    /// @param account {address} address to assign the MVT
    /// @param attributeIndexes {uint[]} attribute data associated with the member
    ///  This is an array which contains indexes of attributes.
    /// 
    function assignTo(
        address account,
        uint[] calldata attributeIndexes
    )external view returns(
        bytes memory
    );
    /// 
    /// @return {bytes}
    /// 
    function revokeFrom(
        address account
    )external view returns(
        bytes memory
    );
    /// 
    /// @return {bytes}
    /// 
    function isCurrentMember(
        address account
    )external view returns(
        bytes memory
    );
    /// 
    /// @return {bytes}
    /// 
    function getAttributeExhaustiveCollection(
        bytes32 name
    )external view returns(
        bytes memory
    );
    /// 
    /// @return {bytes}
    /// 
    function getAllMembers(
    )external view returns(
        bytes memory
    );
    /// 
    /// @return {bytes}
    /// 
    function getCurrentMemberCount(
    )external view returns(
        bytes memory
    );
    /// 
    /// @return {bytes}
    /// 
    function getAttributeNames(
    )external view returns(
        bytes memory
    );
    /// 
    /// @return {bytes}
    /// 
    function getAttributes(
        address account
    )external view returns(
        bytes memory
    );
    /// 
    /// @return {bytes}
    /// 
    function getAttributeByIndex(
        address account,
        uint attributeIndex
    )external view returns(
        bytes memory
    );
}