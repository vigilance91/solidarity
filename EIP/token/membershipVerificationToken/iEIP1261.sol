// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.7.0;
pragma experimental ABIEncoderV2;

//import "../TokenIdentifier/iTokenIdentifier.sol";
///
/// @dev Interface for the EIP1261 standard
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/7/2021, All Rights Reserved
///
interface iEIP1261
    ////iTokenIdentifier
{
    /// @notice Adds a new attribute (key, value) pair to the set of pre-existing attributes.
    /// @dev Adds a new attribute at the end of the array of attributes and maps it to `values`.
    ///  Contract can set a max number of attributes and throw if limit is reached.
    /// @param name hash of the attribute to be added.
    /// @param values List of values of the specified attribute.
    function addAttributeSet(
        bytes32 name,
        bytes32[] calldata values
    )external;

    /// @notice Modifies the attribute value of a specific attribute for a given `_to` address.
    /// @dev Use appropriate checks for whether a user/admin can modify the data.
    ///  Best practice is to use onlyOwner modifier from ERC173.
    /// @param _to The address whose attribute is being modified.
    /// @param _attributeIndex The index of attribute which is being modified.
    /// @param _modifiedValueIndex The index of the new value which is being assigned to the user attribute.
    function modifyAttributeByIndex(
        address to,
        uint attributeIndex,
        uint modifiedValueIndex
    )external;

    /// @notice Requests membership from any address.
    /// @dev Throws if the `msg.sender` already has the token.
    ///  The individual `msg.sender` can request for a membership if some existing criteria are satisfied.
    ///  When a membership is requested, this function emits the RequestedMembership event.
    ///  dev can store the membership request and use `approveRequest` to assign membership later
    ///  dev can also oraclize the request to assign membership later
    /// @param _attributeIndexes the attribute data associated with the member.
    ///  This is an array which contains indexes of attributes.
    function requestMembership(
        uint[] calldata attributeIndexes
    )external payable;

    /// @notice User can forfeit his membership.
    /// @dev Throws if the `msg.sender` already doesn't have the token.
    ///  The individual `msg.sender` can revoke his/her membership.
    ///  When the token is revoked, this function emits the Revoked event.
    function forfeitMembership(
    )external payable;

    /// @notice Owner approves membership from any address.
    /// @dev Throws if the `_user` doesn't have a pending request.
    ///  Throws if the `msg.sender` is not an owner.
    ///  Approves the pending request
    ///  Make oraclize callback call this function
    ///  When the token is assigned, this function emits the `ApprovedMembership` and `Assigned` events.
    /// @param _user the user whose membership request will be approved.
    function approveRequest(
        address account
    )external;

    /// @notice Owner discards membership from any address.
    /// @dev Throws if the `_user` doesn't have a pending request.
    ///  Throws if the `msg.sender` is not an owner.
    ///  Discards the pending request
    ///  Make oraclize callback call this function if criteria are not satisfied
    /// @param _user the user whose membership request will be discarded.
    function discardRequest(
        address account
    )external;

    /// @notice Assigns membership of an MVT from owner address to another address.
    /// @dev Throws if the member already has the token.
    ///  Throws if `_to` is the zero address.
    ///  Throws if the `msg.sender` is not an owner.
    ///  The entity assigns the membership to each individual.
    ///  When the token is assigned, this function emits the Assigned event.
    /// @param _to The address to which the token is assigned.
    /// @param _attributeIndexes The attribute data associated with the member.
    ///  This is an array which contains indexes of attributes.
    function assignTo(
        address account,
        uint[] calldata attributeIndexes
    )external;

    /// @notice Only Owner can revoke the membership.
    /// @dev This removes the membership of the user.
    ///  Throws if the `_from` is not an owner of the token.
    ///  Throws if the `msg.sender` is not an owner.
    ///  Throws if `_from` is the zero address.
    ///  When transaction is complete, this function emits the Revoked event.
    /// @param _from The current owner of the MVT.
    function revokeFrom(
        address account
    )external;

    /// @notice Queries whether a member is a current member of the organization.
    /// @dev MVT's assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _to An address for whom to query the membership.
    /// @return Whether the member owns the token.
    function isCurrentMember(
        address account
    )external view returns(
        bool
    );

    /// @notice Gets the value collection of an attribute.
    /// @dev Returns the values of attributes as a bytes32 array.
    /// @param _name Name of the attribute whose values are to be fetched
    /// @return The values of attributes.
    function getAttributeExhaustiveCollection(
        bytes32 name
    )external view returns(
        bytes32[] memory
    );

    /// @notice Returns the list of all past and present members.
    /// @dev Use this function along with isCurrentMember to find wasMemberOf() in Js.
    ///  It can be calculated as present in getAllMembers() and !isCurrentMember().
    /// @return List of addresses who have owned the token and currently own the token.
    function getAllMembers(
    )external view returns(
        address[]
    );

    /// @notice Returns the count of all current members.
    /// @dev Use this function in polls as denominator to get percentage of members voted.
    /// @return Count of current Members.
    function getCurrentMemberCount(
    )external view returns(
        uint256
    );

    /// @notice Returns the list of all attribute names.
    /// @dev Returns the names of attributes as a bytes32 array.
    ///  AttributeNames are stored in a bytes32 Array.
    ///  Possible values for each attributeName are stored in a mapping(attributeName => attributeValues).
    ///  AttributeName is bytes32 and attributeValues is bytes32[].
    ///  Attributes of a particular user are stored in bytes32[].
    ///  Which has a single attributeValue for each attributeName in an array.
    ///  Use web3.toAscii(data[0]).replace(/\u0000/g, "") to convert to string in JS.
    /// @return The names of attributes.
    function getAttributeNames(
    )external view returns(
        bytes32[] memory
    );

    /// @notice Returns the attributes of `_to` address.
    /// @dev Throws if `_to` is the zero address.
    ///  Use web3.toAscii(data[0]).replace(/\u0000/g, "") to convert to string in JS.
    /// @param _to The address whose current attributes are to be returned.
    /// @return The attributes associated with address `account`.
    function getAttributes(
        address account
    )external view returns(
        bytes32[] memory
    );

    /// @notice Returns the `attribute` stored against `_to` address.
    /// @dev Finds the index of the `attribute`.
    ///  Throws if the attribute is not present in the predefined attributes.
    ///  Returns the attributeValue for the specified `attribute`.
    /// @param _to The address whose attribute is requested.
    /// @param _attributeIndex The attribute Index which is required.
    /// @return The attribute value at the specified name.
    function getAttributeByIndex(
        address account,
        uint attributeIndex
    )external view returns(
        bytes32
    );
}