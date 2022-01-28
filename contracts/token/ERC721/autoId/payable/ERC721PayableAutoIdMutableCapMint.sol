// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/mints/ERC721MintAutoIdABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/PausableAccessControl.sol";

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/EtherTransactorABC.sol";

//interface iERC721PayableAutoIdMutableCapMint is iERC721MintAutoIdABC
    //iEtherReceiver,
    //iMutableTokenSupplyABC,
    //iMutableSupplyCapABC
//{
//}

///
/// @title ERC721 Payable Auto ID Mutable Cap Mint Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/10/2021, All Rights Reserved
/// @dev ERC721 Payable Auto ID token with a mutable cap and supply, which requires a payment of $ETH to perform
///
abstract contract ERC721PayableAutoIdMutableSupplyMint is ERC721MintAutoIdABC
    //EtherTransactorABC,
    //MutableTokenSupplyABC,
    //MutableSupplyCapABC
{
    using logicConstraints for bool;
    
    using uint256Logic for uint256;
    using uint256Constraints for uint256;
    
    using AddressConstraint for address;
    
    using Counters for Counters.Counter;
    
    uint256 _mintFee;
    uint256 _burnFee;
    
    constructor(
        uint256 initialSupply,
        uint256 supplyCap,
        //
        uint256 mintFee,
        uint256 burnFee,
        uint256 floorPrice,
        //
        string memory name,
        string memory symbol,
        string memory baseURI
        //string memory version
    )internal payable
        //EtherTransactorABC()
        ERC721MintAutoIdABC(
            collectionName,
            collectionSymbol,
            baseURI
        )
        //MutableTokenSupplyABC(initialSupply)
        //MutableSupplyCapABC(supplyCap)
    {
        //supplyCap.requireGreaterThanOrEqual(initialSupplyCap);
        
        //msg.value.requireGreaterThanZero();
        mintFee.requireGreaterThanZero();
        burnFee.requireGreaterThanZero();
        
        _mintFee = mintFee;
        _burnFee = burnFee;
        
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
        
        //_registerInterface(type(iERC721PayableAutoIdMutableCapMint).interfaceId);
        
        //_requireCanReceiverEther(sender);
        //_requireCanReceiverEther(_this);
        
        //_this.call{
            //value:msg.value
        //}("");
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
    //)external virtual override payable nonReentrant{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //msg.value.requireGreaterThanOrEqual(_mintFee);
        
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
        
        //address O = owner();
        
        //if(O.notNull()){
            //if(sender.notEqual(O)){
                //uint256 val = msg.value >> _mintCutFactor;
                //
                //_requireCanReceiveEther(O);
                //
                //pay half to owner
                ////payable(O).call{
                    ////value:val
                ////}("");
                //
                //if(!_isContract(O)){
                    //_requireOnEtherReceived(O, sender, val);
                //}
                //pay remainder to contract to back NFT's value if it is greater than 0
                //uint256 remainder = msg.value.sub(val);
                
                //if(remainder > 0){
                    ////_this.call{
                        ////value:remainder
                    ////}("");
                //}
            //}
            //else{
                //when owner mints, all $ETH goes to the contract
                ////_this.call{
                    ////value:msg.value
                ////}("");
            //}
        //}
    //}
    
    //function mint(
        //bytes calldata data
    //)external virtual override payable nonReentrant{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //msg.value.requireGreaterThanOrEqual(_mintFee);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_mint(
            //sender,
            //_tokenIdTracker.length,
            //data
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        //address O = owner();
        
        //if(O.notNull()){
            //if(sender.notEqual(O)){
                //uint256 val = msg.value >> _mintCutFactor;
                //
                //_requireCanReceiveEther(O);
                //
                //pay half to owner
                ////payable(O).call{
                    ////value:val
                ////}("");
                //
                //if(!_isContract(O)){
                    //_requireOnEtherReceived(O, sender, val);
                //}
                //pay remainder to contract to back NFT's value if it is greater than 0
                //uint256 remainder = msg.value.sub(val);
                
                //if(remainder > 0){
                    ////_this.call{
                        ////value:remainder
                    ////}("");
                //}
            //}
            //else{
                //when owner mints, all $ETH goes to the contract
                ////_this.call{
                    ////value:msg.value
                ////}("");
            //}
        //}
    //}
    
    //function mint(
        //address to
    //)external virtual override nonReentrant{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //msg.value.requireGreaterThanOrEqual(_mintFee);
        
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
        
        //address O = owner();
        
        //if(O.notNull()){
            //if(sender.notEqual(O)){
                //uint256 val = msg.value >> _mintCutFactor;
                //
                //_requireCanReceiveEther(O);
                //
                //pay half to owner
                ////payable(O).call{
                    ////value:val
                ////}("");
                //
                //if(!_isContract(O)){
                    //_requireOnEtherReceived(O, sender, val);
                //}
                //pay remainder to contract to back NFT's value if it is greater than 0
                //uint256 remainder = msg.value.sub(val);
                
                //if(remainder > 0){
                    ////_this.call{
                        ////value:remainder
                    ////}("");
                //}
            //}
            //else{
                //when owner mints, all $ETH goes to the contract
                ////_this.call{
                    ////value:msg.value
                ////}("");
            //}
        //}
    //}
    
    //function mint(
        //address to,
        //bytes calldata data
    //)external virtual override nonReentrant{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //msg.value.requireGreaterThanOrEqual(_mintFee);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_mint(
            //to,
            //_tokenIdTracker.length,
            //data
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        //address O = owner();
        
        //if(O.notNull()){
            //if(sender.notEqual(O)){
                //uint256 val = msg.value >> _mintCutFactor;
                //
                //_requireCanReceiveEther(O);
                //
                //pay half to owner
                ////payable(O).call{
                    ////value:val
                ////}("");
                //
                //if(!_isContract(O)){
                    //_requireOnEtherReceived(O, sender, val);
                //}
                //pay remainder to contract to back NFT's value if it is greater than 0
                //uint256 remainder = msg.value.sub(val);
                
                //if(remainder > 0){
                    ////_this.call{
                        ////value:remainder
                    ////}("");
                //}
            //}
            //else{
                //when owner mints, all $ETH goes to the contract
                ////_this.call{
                    ////value:msg.value
                ////}("");
            //}
        //}
    //}
    
    
    //function safeMint(
    //)external virtual override payable nonReentrant{
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //_msgSender()
        //);
        
        //msg.value.requireGreaterThanOrEqual(_mintFee);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_safeMint(
            //sender,
            //_tokenIdTracker.length
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        //address O = owner();
        
        //if(O.notNull()){
            //if(sender.notEqual(O)){
                //uint256 val = msg.value >> _mintCutFactor;
                //
                //_requireCanReceiveEther(O);
                //
                //pay half to owner
                ////payable(O).call{
                    ////value:val
                ////}("");
                //
                //if(!_isContract(O)){
                    //_requireOnEtherReceived(O, sender, val);
                //}
                //pay remainder to contract to back NFT's value if it is greater than 0
                //uint256 remainder = msg.value.sub(val);
                
                //if(remainder > 0){
                    ////_this.call{
                        ////value:remainder
                    ////}("");
                //}
            //}
            //else{
                //when owner mints, all $ETH goes to the contract
                ////_this.call{
                    ////value:msg.value
                ////}("");
            //}
        //}
    //}
    //
    //mint token giving ownership to account `to`
    //function safeMint(
        //address to
    //)external virtual override payable nonReentrant{
        //address sender = _msgSender();
        
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //sender
        //);
        
        //msg.value.requireGreaterThanOrEqual(_mintFee);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_safeMint(
            //to,
            //_tokenIdTracker.length
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        //address O = owner();
        
        //if(O.notNull()){
            //if(sender.notEqual(O)){
                //uint256 val = msg.value >> _mintCutFactor;
                //
                //_requireCanReceiveEther(O);
                //
                //pay half to owner
                ////payable(O).call{
                    ////value:val
                ////}("");
                //
                //if(!_isContract(O)){
                    //_requireOnEtherReceived(O, sender, val);
                //}
                //pay remainder to contract to back NFT's value if it is greater than 0
                //uint256 remainder = msg.value.sub(val);
                
                //if(remainder > 0){
                    ////_this.call{
                        ////value:remainder
                    ////}("");
                //}
            //}
            //else{
                //when owner mints, all $ETH goes to the contract
                ////_this.call{
                    ////value:msg.value
                ////}("");
            //}
        //}
    //}
    //function safeMint(
        //address to,
        //bytes calldata data
    //)external virtual override payable nonReentrant{
        //address sender = _msgSender();
        
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //sender
        //);
        
        //msg.value.requireGreaterThanOrEqual(_mintFee);
        
        //(
            //uint256 TS,
            //uint256 CAP
        //) = totalSupplyAndCap();
        
        //TS.requireLessThan(CAP);
        
        //_safeMint(
            //to,
            //_tokenIdTracker.length,
            //data
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        //address O = owner();
        
        //if(O.notNull()){
            //if(sender.notEqual(O)){
                //uint256 val = msg.value >> _mintCutFactor;
                //
                //_requireCanReceiveEther(O);
                //
                //pay half to owner
                ////payable(O).call{
                    ////value:val
                ////}("");
                //
                //if(!_isContract(O)){
                    //_requireOnEtherReceived(O, sender, val);
                //}
                //pay remainder to contract to back NFT's value if it is greater than 0
                //uint256 remainder = msg.value.sub(val);
                
                //if(remainder > 0){
                    ////_this.call{
                        ////value:remainder
                    ////}("");
                //}
            //}
            //else{
                //when owner mints, all $ETH goes to the contract
                ////_this.call{
                    ////value:msg.value
                ////}("");
            //}
        //}
    //}
    
    //todo: ERC721 which is payable to burn and mint
    //function burn(
        //uint256 tokenId
    //)external virtual override payable nonReentrant
    //{
        //address sender = _msgSender();
        
        //_requireRoleOrAdmin(
            //ROLE_BURNER,
            //sender
        //);
        
        //msg.value.requireGreaterThanOrEqual(_burnFee);
        
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
        
        //TS.requireGreaterThanZero();
        
        //_burn(
            //tokenId
        //);
        
        //_decreaseTotalSupply(uint256Logic.ONE);
        
        //O.requireNotNull();
        
        //if(sender.notEqual(O)){
            //_requireCanReceiveEther(O);
            
            ////payable(O).call{
                ////value:msg.value
            ////}("");
            
            //if(!_isContract(O)){
                //_requireOnEtherReceived(O, sender, msg.value);
            //}
        //}
        //note: owner does not pay to burn tokens
    //}
    
    //function burnFrom(
        //address from,
        //uint256 tokenId
    //)external virtual override payable nonReentrant
    //{
        //address sender = _msgSender();
        
        //_requireRoleOrAdmin(
            //ROLE_BURNER,
            //sender
        //);
        
        //msg.value.requireGreaterThanOrEqual(_burnFee);
        
        //if(!hasDefaultAdminRole(sender)){
            //(
                //isApprovedForAll(owner, sender) ||
                //getApproved(tokenId).equal(sender) ||
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
        
        //...
        
        //TS.requireGreaterThanZero();
        
        //_decreaseTotalSupply(uint256Logic.ONE);
        
        //O.requireNotNull();
        
        //if(sender.notEqual(O)){
            //_requireCanReceiveEther(O);
            
            ////payable(O).call{
                ////value:msg.value
            ////}("");
            
            //if(!_isContract(O)){
                //_requireOnEtherReceived(O, sender, msg.value);
            //}
        //}
        //note: owner does not pay to burn tokens
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