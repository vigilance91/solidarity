// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.7.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/MutableSupplyTokenABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/mixinERC20.sol";
import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/eventsERC20.sol";
///
/// @title EIP1261
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/7/2021, All Rights Reserved
/// @dev {iEIPC1261} interface implementation
///
abstract contract EIP1261 is MutableSupplyTokenABC
    //IERC1261, Ownable, ERC165
{
    //using eventsEIP1261 for address;
    
    struct MemberData {
        bool hasToken;
        uint[] data;
    }

    struct PendingRequest {
        bool isPending;
        uint[] attributes;
    }

    //struct storageEIP1261{
        mapping(uint=>bytes32[]) public attributeValueCollection;

        bytes32[] public attributeNames;

        mapping(address=>MemberData) public _currentHolders;
        mapping(address=>PendingRequest) public pendingRequests;

        address[] public allHolders;

        uint public currentMemberCount;
    //}

    event ApprovedMembership(address to, uint[] attributeIndexes);
    event RequestedMembership(address to);
    //
    event AssignedMembership(address to, uint[] attributeIndexes);
    event RevokedMembership(address to);
    event ForfeitedMembership(address to);
    //
    event ModifiedAttributes(
        address to,
        uint attributeIndex,
        uint prevValueIndex,
        bytes32 prevValue,
        uint modifiedValueIndex,
        bytes32 modifiedValue
    );

    constructor(
        //name,
        //symbol,
        //initialSupply
    )internal
        //MutableSupplyTokenABC(
            //name,
            //symbol,
            //initialSupply
        //)
    {
        //_registerInterface(0x83adfb2d); //Ownable
    }

    modifier isCurrentHolder
    {
        require(
            isCurrentMember(msg.sender),
            "Not a current member"
        );
        _;
    }

    function isCurrentMember(
        address account
    )public view returns(
        bool
    ){
        require(account != address(0), "Zero address can't be a member");
        
        return _currentHolders[account].hasToken;
    }

    function _assign(
        address account,
        uint[] memory attributeIndexes
    )internal
    {
        //account.requireNotNull("Can't assign to zero address");
        require(account != address(0), "Can't assign to zero address");
        require(
            attributeIndexes.length == attributeNames.length,
            "Need to input all attributes"
        );
        
        MemberData memory member;
        
        member.hasToken = true;
        _currentHolders[account] = member;
        
        for(uint index; index < attributeIndexes.length; index++){
            _currentHolders[account].data.push(attributeIndexes[index]);
        }
        
        allHolders.push(account);
        currentMemberCount += 1;
    }

    function _revoke(
        address from
    )internal
    {
        //from.requireNotNull("Can't revoke from zero address");
        require(from != address(0), "Can't revoke from zero address");
        
        MemberData storage member = _currentHolders[from];
        
        member.hasToken = false;
        currentMemberCount -= 1;
    }
}

contract EIP1261MembershipVerificationToken is EIP1261
    //iEIP1261
{
    //using logicConstraints for bool;
    //using addressConstraints for address;
    string private constant _NAME = ' EIP1261MembershipVerificationToken: ';
    
    constructor(
    )public
        EIP1261()
    {
        //_registerInterface(0x912f7bb2); //iERC1261
    }
    function requestMembership(
        uint[] calldata attributeIndexes
    )external payable   //virtual override nonReentrant
    {
        require(!isCurrentMember(msg.sender), "Already a member");
        require(
            attributeIndexes.length == attributeNames.length,
            "Need to input all attributes"
        );
        //Do some checks before assigning membership
        PendingRequest storage request = pendingRequests[msg.sender];
        
        request.isPending = true;
        request.attributes = attributeIndexes;
        
        //sender.emitRequestedMembership();
    }

    function forfeitMembership(
    )external payable isCurrentHolder //override nonReentrant
    {
        _revoke(msg.sender);    //_msgSender()
        
        //sender.emitMembershipForfeited();
    }

    function approveRequest(
        address account
    )external onlyOwner //OrApprover    //override nonReentrant
    {
        PendingRequest storage request = pendingRequests[_user];
        
        require(request.isPending, "Hasn't sent ether yet");
        
        _assign(_user, request.attributes);
        
        //account.emitMembershipApproved(request.attributes);
    }

    function discardRequest(
        address account
    )external onlyOwner  //OrApprover   //override nonReentrant
    {
        PendingRequest storage request = pendingRequests[_user];
        
        require(request.isPending, "Hasn't sent ether yet");
        
        request.isPending = false;
        delete request.attributes;
    }

    function assignTo(
        address account,
        uint[] calldata attributeIndexes
    )external
        onlyOwner //OrAssigner  //override nonReentrant
    {
        _assign(account, attributeIndexes);
        //account.emitMembershipAssigned(attributeIndexes);
    }

    function revokeFrom(
        address from
    )external onlyOwner  //OrAssigner   //override nonReentrant
    {
        _revoke(from);
        
        //from.emitMembershipRevoked();
    }

    function addAttributeSet(
        bytes32 attributeName,
        bytes32[] calldata values
    )external   //override nonReentrant
    {
        attributeNames.push(attributeName);
        
        bytes32[] storage storedValues = attributeValueCollection[attributeNames.length - 1];
        
        storedValues.push(
            0x756e646566696e65640000000000000000000000000000000000000000000000
        );
        
        for(uint index; index < values.length; index++){
            storedValues.push(values[index]);
        }
    }

    function modifyAttributeByIndex(
        address to,
        uint attributeIndex,
        uint modifiedValueIndex
    )external onlyOwner //orCurrentHolder override nonReentrant
    {
        // uint attributeIndex = getIndexOfAttribute(_attributeName);
        
        //storage holder = _currentHolders[to];
        
        require(
            _currentHolders[to].data.length > attributeIndex,
            "data doesn't exist for the user"
        );
        
        //storage attributes = attributeValueCollection[attributeIndex];
        
        uint prevIndex = _currentHolders[to].data[attributeIndex];
        bytes32 prevValue = attributeValueCollection[attributeIndex][prevIndex];
        
        _currentHolders[to].data[attributeIndex] = modifiedValueIndex;
        
        bytes32 modifiedValue = attributeValueCollection[attributeIndex][modifiedValueIndex];
        
        to.emitModifiedAttributes(
            attributeIndex,
            prevIndex,
            prevValue,
            modifiedValueIndex,
            modifiedValue
        );
    }

    function getAllMembers(
    )external view returns( //override
        address[] memory
    ){
        return allHolders;
    }

    function getCurrentMemberCount(
    )external view returns( //override
        uint
    ){
        return currentMemberCount;
    }

    function getAttributeNames(
    )external view returns( //override
        bytes32[] memory
    ){
        return attributeNames;
    }

    function getAttributes(
        address account
    )external view returns( //override
        uint[] memory
    ){
        require(account != address(0), "Address cannot be zero");
        
        return _currentHolders[account].data;
    }

    function getAttributeExhaustiveCollection(
        uint index
    )external view returns( //override
        bytes32[] memory
    ){
        return attributeValueCollection[index];
    }

    function getAttributeByIndex(
        address account,
        uint attributeIndex
    )external view returns( //override
        uint
    ){
        require(
            _currentHolders[account].data.length > attributeIndex,
            "data doesn't exist for the user"
        );
        
        return _currentHolders[account].data[attributeIndex];
    }
}