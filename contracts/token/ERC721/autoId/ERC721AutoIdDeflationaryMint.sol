// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/mints/ERC721MintAutoIdABC.sol";
//import "https://github.com/vigilance91/solidarity/contracts/token/PausableAccessControl.sol";

//import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/EtherTransactorABC.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/MutableTokenSupplyABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/StaticSupplyCapABC.sol";

//interface iERC721AutoIdDeflationaryMint is iERC721MintAutoIdABC
    //iEtherReceiver,
    //iMutableTokenSupplyABC,
    //iStaticSupplyCapABC
//{
//}

///
/// @title ERC721 Auto ID Static Supply Token Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/10/2021, All Rights Reserved
/// @dev ERC721 Auto ID token with a static supply cap but a mutable supply which can only ever decrease after deployment
///
abstract contract ERC721AutoIdDeflationaryMint is ERC721MintAutoIdABC
    ////EtherTransactorABC,
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
        //
        string memory name,
        string memory symbol,
        string memory baseURI
        //string memory version
    )internal
        //EtherTransactorABC()
        ERC721MintAutoIdABC(
            collectionName,
            collectionSymbol,
            baseURI
        )
        //MutableTokenSupplyABC(initialSupply)
        //StaticSupplyCapABC(initialSupply)
    {
        //initialSupply.requireGreaterThanZero(
        //);
        
        address sender = _msgSender();
        
        //while(_tokenIdTracker.length < initialSupply){
            //_safeMint(sender);
        //}
        
        //uint256 TS = totalSupply();
        
        //TS.requireEqual(
            //_tokenIdTracker.length
            ////'invalid token supply'
        //);
        //TS.requireEqual(
            //_cap
            ////'total supply must equal cap'
        //);
        
        //_registerInterface(type(iMutableSupplyToken).interfaceId);
        //_registerInterface(type(iStaticSupplyCap).interfaceId);
        
        //_registerInterface(type(iERC721AutoIdDeflationaryMint).interfaceId);
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
    
    //note: cannot increasing supply after contract is deployed
    //todo: ERC721 which is payable to burn and mint
    //function burn(
        //uint256 tokenId
    //)external virtual override nonReentrant{
        //address sender = _msgSender();
        
        //_requireRoleOrAdmin(
            //ROLE_BURNER,
            //sender
        //);
        
        //if(!hasDefaultAdminRole(sender)){
            //ownerOf(tokenId).requireEqual(
                //sender
                ////"only the owner may burn"
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
    
    //function burnFrom(
        ////address from,
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
    
    //don't decrease or modify (set) the cap after deployment, so that it can be used as a metric for how many tokens remain
    
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
        
        //if(from.equalsNull()){    // address(0)){
            //mint
            //_requireTotalSupplyLessThan(cap());
            //require the tokenID to not already exist before being minted
            //_requireDoesNotExist(tokenId);
        //}
        //else if(to.equalsNull()){   //== address(0)){
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