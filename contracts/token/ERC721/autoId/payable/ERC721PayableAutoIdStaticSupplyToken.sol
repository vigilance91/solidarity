// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/mints/ERC721MintAutoIdABC.sol";
//import "https://github.com/vigilance91/solidarity/contracts/token/PausableAccessControl.sol";

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/EtherTransactorABC.sol";

//interface iERC721PayableAutoIdStaticSupplyToken is iERC721MintAutoIdABC
    //iEtherReceiver,
    //iStaticTokenSupplyABC,
    //iStaticSupplyCapABC
//{
//}

///
/// @title ERC721 Payable Auto ID Static Supply Token Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/10/2021, All Rights Reserved
/// @dev ERC721 Payable Auto ID static supply token
///
abstract contract ERC721PayableAutoIdStaticSupplyToken is ERC721MintAutoIdABC
    //EtherReceiverABC,
    //EtherReceiverConstraintsABC,
    //StaticTokenSupplyABC,
    //StaticSupplyCapABC
{
    using logicConstraints for bool;
    using AddressConstraint for address;
    
    using Counters for Counters.Counter;
    
    constructor(
        //uint256 supplyCap,
        //uint256 floorPrice,
        //
        string memory name,
        string memory symbol,
        string memory baseURI
        //string memory version
    )internal payable
        //EtherReceiverABC()
        //EtherReceiverConstraintsABC()
        ERC721MintAutoIdABC(
            collectionName,
            collectionSymbol,
            baseURI
        )
        //StaticTokenSupplyABC(supplyCap)
        //StaticSupplyCapABC(supplyCap)
    {
        address sender = _msgSender();
        
        //while(_tokenIdTracker.length < supplyCap){
            //_safeMint(sender);
        //}
        
        //requireTotalSupplyEqual(
            //_tokenIdTracker.length
            ////'invalid token count'
        //);
        
        //_registerInterface(type(iStaticSupplyToken).interfaceId);
        //_registerInterface(type(iStaticSupplyCap).interfaceId);
        
        //_registerInterface(type(iERC721PayableAutoIdStaticSupplyToken).interfaceId);
        
        //_requireCanReceiverEther(sender);
        //_requireCanReceiverEther(_this);
        
        //_this.call{
            //value:msg.value
        //}("");
    }
    
    /// @dev token transfers, minting and burning are all disabled when paused
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    )internal virtual override
    {
        //from.requireNotEqual(to);
        
        //if(from.equalsNull()){    // address(0)){
            //mint
            //_requireTotalSupplyLessThan(cap());
            //require the tokenID to not already exist before being minted
            //_requireDoesNotExist(tokenId);
        //}
        //else if(to.equalsNull()){   //== address(0)){
            //burn
            // require the token to exist before being burned
            //alwaysRevert('cannot burn static supply token');
            ////_requireExists(tokenId);
        //}
        //else{
            //transfer
            //prevent transfering tokenIDs which either:
            //    * do not exist ie, havent been minted yet
            //    * no longer exit, due to being previously burned
            //_requireExists(tokenId);
        //}
        
        super._beforeTokenTransfer(
            from,
            to,
            tokenId
        );
    }
}