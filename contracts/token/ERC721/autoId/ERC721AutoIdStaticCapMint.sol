// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/mints/ERC721MintAutoIdABC.sol";
//import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/MutableTokenSupplyABC.sol";

//import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/EtherTransactorABC.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/tokenSupply/tokenSupply/MutableTokenSupplyABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/tokenSupply/supplyCap/StaticSupplyCapABC.sol";

//interface iERC721AutoIdStaticCapMint is iERC721MintAutoIdABC
    ////EtherReceiverABC,
    ////EtherReceiverConstraintsABC,
    //iMutableTokenSupplyABC,
    //iStaticSupplyCapABC
//{
//}
///
/// @title ERC721 Auto ID Static Cap Mint Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/10/2021, All Rights Reserved
/// @dev ERC721 Auto ID mint with a static cap and mutable cap supply, up to and including cap
///
abstract contract ERC721AutoIdStaticCapMint is ERC721MintAutoIdABC
    //EtherTransactorABC,
    //MutableTokenSupplyABC,
    //StaticSupplyCapABC
{
    using logicConstraints for bool;
    
    using uint256Logic for uint256;
    using uint256Constraints for uint256;
    
    using AddressConstraint for address;
    
    using Counters for Counters.Counter;
    
    constructor(
        uint256 initialSupply,
        uint256 supplyCap,
        //
        string memory name,
        string memory symbol,
        string memory baseURI
        //string memory version
    )internal
        EtherTransactorABC()
        ERC721MintAutoIdABC(
            collectionName,
            collectionSymbol,
            baseURI
        )
        //MutableTokenSupplyABC(initialSupply)
        //StaticSupplyCapABC(supplyCap)
    {
        //supplyCap.requireGreaterThanOrEqual(initialSupplyCap);
        
        address sender = _msgSender();
        
        if(initialSupply != 0){
            //while(_tokenIdTracker.length < initialSupply){
                //_safeMint(sender);
            //}
        }
        
        //uint256 TS = totalSupply();
        
        //TS.requireEqual(
            //_tokenIdTracker.length
            ////'invalid token supply'
        //);
        //TS.requireLessThanOrEqual(
            //_cap
            ////'total supply cannot exceed cap'
        //);
        
        //_registerInterface(type(iMutableSupplyToken).interfaceId);
        //_registerInterface(type(iStaticSupplyCap).interfaceId);
        
        //_registerInterface(type(iERC721AutoIdStaticCapMint).interfaceId);
    }
    
    //function totalSupplyAndCap(
    //)public view returns(
        //uint256,
        //uint256
    //){
        //return (
            //totalSupply(),
            //_cap
    //}
    
    //increasing supply
    //function mint(
    //)external virtual override nonReentrant{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_mint(
            //sender,
            //_tokenIdTracker.length
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        ////return (
            ////tokenId,
            ////totalSupply()
        ////);
    //}
    
    //function mint(
        //bytes calldata data
    //)external virtual override nonReentrant{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //_mint(
            //sender,
            //data
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        //return (
            //tokenId,
            //totalSupply()
        //);
    //}
    
    //function mint(
        //address to
    //)external virtual override nonReentrant{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_mint(
            //to,
            //_tokenIdTracker.length
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        //return (
            //tokenId,
            //totalSupply()
        //);
    //}
    
    
    //function mint(
        //address to,
        //bytes calldata data
    //)external virtual override nonReentrant{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_mint(
            //to,
            //data
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        //return (
            //tokenId,
            //totalSupply()
        //);
    //}
    
    
    //function safeMint(
    //)external virtual override nonReentrant
    //{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_safeMint(
            //sender
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        ////return (
            ////tokenId,
            ////totalSupply()
        ////);
    //}
    
    
    //function safeMint(
        //bytes calldata data
    //)external virtual override nonReentrant
    //{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_safeMint(
            //sender,
            //data
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        ////return (
            ////tokenId,
            ////totalSupply()
        ////);
    //}
    
    //function safeMint(
        //address to
    //)external virtual override nonReentrant
    //{
        //adress sender = _msgSender();
        
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //sender
        //);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_safeMint(
            //to
        //);
        
        ////_increaseTotalSupply(uint256Logic.ONE);
        
        ////return (
            ////tokenId,
            ////totalSupply()
        ////);
    //}
    
    //function safeMint(
        //address to,
        //bytes calldata data
    //)external virtual override nonReentrant
    //{
        //adress sender = _msgSender();
        
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //sender
        //);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_safeMint(
            //to,
            //data
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        ////return (
            ////tokenId,
            ////totalSupply()
        ////);
    //}
    
    //todo: ERC721 which is payable to burn and mint
    //function burn(
        //uint256 tokenId
    //)external virtual override nonReentrant
    //{
        //address sender = _msgSender();
        
        //_requireRoleOrAdmin(
            //ROLE_BURNER,
            //sender
        //);
        
        //ownerOf(tokenId).requireEqual(
            //sender
            ////"caller is not token owner or approved spender"
        //);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //CAP.requireGreaterThanZero(
            ////'cap is 0, no tokens to burn'
        //);
        
        //TS.requireGreaterThanZero(
            ////'total supply is 0, no tokens to burn'
        //);
        
        //TS.sub(1).requireGreaterThanZero();
        
        //_burn(
            //tokenId
        //);
        
        //_decreaseTotalSupply(uint256Logic.ONE);
    //}
    
    
    //function burnFrom(
        //address owner,
        //uint256 tokenId
    //)external virtual override nonReentrant
    //{
        //address sender = _msgSender();
        
        //_requireRoleOrAdmin(
            //ROLE_BURNER,
            //sender
        //);
        
        //if(!hasDefaultAdminRole(sender)){
            //(
                //getApproved(tokenId).equal(sender) ||
                //isApprovedForAll(owner, sender)
            //).requireTrue(
                ////"caller is not approved to burnFrom"
            //);
        //}
        //else is admin
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //CAP.requireGreaterThanZero(
            ////'cap is 0, no tokens to burn'
        //);
        
        //TS.requireGreaterThanZero(
            ////'total supply is 0, no tokens to burn'
        //);
        
        //TS.sub(1).requireGreaterThanZero();
        
        //_burn(
            //tokenId
        //);
        
        //_decreaseTotalSupply(uint256Logic.ONE);
    //}
    /// @dev token transfers, minting and burning are all disabled when paused
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    )internal virtual override
    {
        //require(
            // !paused()
            //_NAME.concatenate("paused")
        //);
        
        //from.requireNotEqual(to);
        
        //if(from.equalsNull()){
            //mint
            //_requireTotalSupplyLessThan(cap());
            //require(
                //totalSupply().add(uint256Logic.ONE) <= cap(),
                //"supply cap exceeded"
            //);
            //require the tokenID to not already exist before being minted
            //_requireDoesNotExist(tokenId);
        //}
        //else if(to.equalsNull()){
            //burn
            // require the token to exist before being burned
            //_requireExists(tokenId);
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