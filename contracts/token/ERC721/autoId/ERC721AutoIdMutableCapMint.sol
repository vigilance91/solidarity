// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/mints/ERC721MintAutoIdABC.sol";

//import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/EtherTransactorABC.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/MutableTokenSupplyABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/MutableSupplyCapABC.sol";

//interface iERC721AutoIdMutableCapMint is iERC721MintAutoIdABC
    //iEtherReceiver,
    //iMutableTokenSupplyABC,
    //iMutableSupplyCapABC
//{
//}
///
/// @title ERC721 Auto ID Mutable Cap Mint Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/10/2021, All Rights Reserved
/// @dev ERC721 Auto ID token with a mutable cap and supply
///
abstract contract ERC721AutoIdMutableSupplyMint is ERC721MintAutoIdABC
    ////EtherTransactorABC,
    //MutableTokenSupplyABC,
    //MutableSupplyCapABC
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
        ERC721MintAutoIdABC(
            collectionName,
            collectionSymbol,
            baseURI
        )
        //MutableTokenSupplyABC(initialSupply)
        //MutableSupplyCapABC(supplyCap)
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
            //supplyCap()
            ////'total supply cannot exceed cap'
        //);
        
        //_registerInterface(type(iMutableSupplyToken).interfaceId);
        //_registerInterface(type(iMutableSupplyCap).interfaceId);
        
        //_registerInterface(type(iERC721AutoIdMutableCapMint).interfaceId);
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
            //sender
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
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
        
        //TS.requireLessThan(CAP);
        
        //_mint(
            //sender,
            //data
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
    //}
    
    //function mint(
        //address to
    //)external virtual override nonReentrant{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //sender.requireNotEqual(to);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_mint(
            //to
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
    //}
    
    //function mint(
        //address to,
        //bytes calldata data
    //)external virtual override nonReentrant{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //sender.requireNotEqual(to);
        
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
    //}
    
    //function safeMint(
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
        
        //_safeMint(
            //sender
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
    //}
    
    //function safeMint(
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
        
        //_safeMint(
            //sender,
            //data
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
    //}
    //
    //mint token giving ownership to account `to`
    //function safeMint(
        //address to
    //)external virtual override nonReentrant{
        //address sender = _msgSender();
        
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //sender
        //);
        
        //sender.requireNotEqual(to);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_safeMint(
            //to
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
    //}
    //
    //mint token giving ownership to account `to`
    //function safeMint(
        //address to,
        //bytes calldata data
    //)external virtual override nonReentrant{
        //address sender = _msgSender();
        
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //sender
        //);
        
        //sender.requireNotEqual(to);
        
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
    
    //function increase increaseCapBy(
        //uint256 amount
    //)external virtual override nonReentrant returns(
        //uint256
    //){
        //_requireOwnerOrAdmin(_msgSender());
        
        ////maximum value the cap may be increased by for a given interval
        ////uint256 IA = _inflationAmount();
        ////amount.requireLessThanOrEqual(IA);
        
        //_increaseCapBy(amount);
        
        //return cap();
    //}
    
    //function decreaseCapBy(
        //uint256 amount
    //)external virtual override nonReentrant returns(
        //uint256
    //){
    //{
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //CAP.requireGreaterThanZero(
            ////'cap cannot be reduced further'
        //);
        
        //CAP.sub(TS).requireGreaterThanOrEqual(
            //amount
        //);
        
        //_decreaseCapBy(amount);
        
        //return _cap;
    //}
    
    function setCap(
        uint256 newCap
    )external virtual override nonReentrant
    returns(
        uint256
    ){
        //_requireOwnerOrAdmin(_msgSender());
        
        newCap.requireGreaterThanZero();
        
        uint256 CAP = cap();
        
        CAP.requireNotEqual(newCap);
        
        if(newCap > CAP){
            _increaseCapBy(newCap.sub(CAP));
        }
        else if(newCap < CAP){
            uint256 amount = CAP.sub(newCap);
            
            CAP.sub(totalSupply()).requireGreaterThanOrEqual(
                amount
            );
            
            _decreaseCapBy(amount);
        }
        
        return _cap;
    }
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