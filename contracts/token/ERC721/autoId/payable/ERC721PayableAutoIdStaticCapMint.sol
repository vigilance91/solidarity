// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/mints/ERC721MintAutoIdABC.sol";
//import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/MutableTokenSupplyABC.sol";

//import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/EtherTransactorABC.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/StaticSupplyCapABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/PausableAccessControl.sol";

//interface iERC721PayableAutoIdStaticCapMint is iERC721MintAutoIdABC
    //iEtherReceiver,
    //iMutableTokenSupplyABC,
    //iStaticSupplyCapABC
//{
//}
///
/// @title ERC721 Payble Auto ID Static Cap Mint Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/10/2021, All Rights Reserved
/// @dev ERC721 Payable Auto ID mint with a static cap and mutable cap supply, up to and including cap
///
abstract contract ERC721PayableAutoIdStaticCapMint is ERC721MintAutoIdABC
    //EtherReceiverTransactorABC,
    //MutableTokenSupplyABC,
    //StaticSupplyCapABC
{
    using logicConstraints for bool;
    
    using uint256Logic for uint256;
    using uint256Constraints for uint256;
    
    using AddressConstraint for address;
    
    using Counters for Counters.Counter;
    
    uint256 internal _mintFee;
    uint256 internal _burnFee;
    uint256 internal _minWei;
    
    uint8 private constant _MAX_CUT_FACTOR = 127;
    
    uint8 internal _mintCutFactor;
    uint8 internal _feeFactor;
    
    constructor(
        uint256 initialSupply,
        uint256 supplyCap,
        //
        uint256 mintFee,
        uint256 burnFee,
        uint256 floorPrice,
        //
        uint8 mintCutFactor,
        uint8 feeFactor,
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
        //StaticSupplyCapABC(supplyCap)
    {
        //supplyCap.requireGreaterThanOrEqual(initialSupplyCap);
        
        //msg.value.requireGreaterThanZero();
        
        mintFee.requireGreaterThanZero();
        burnFee.requireGreaterThanZero();
        floorPrice.requireGreaterThanZero();
        
        _mintFee = mintFee;
        _burnFee = burnFee;
        
        _minWei = floorPrice;
        
        // Owner:contract payments 
        //setting to 0 will split all payable operations 100:0
        //setting to 1 will split all payable operations 50:50
        //setting to 2 will split all payable operations 25:75
        //setting to 3 will split all payable operations 17:87
        //setting to 4 will split all payable operations 7:93
        //etc
        //setting to 4 will split all payable operations 0.00...01:99.99...99
        _mintCutFactor = mintCutFactor;
        //factor used to determine minting and burning price based on this contrac's balance
        //a factor of 0 requires at least 100% of the current balance to paid
        //a factor of 1 requires at least 50% (1/2) of the current balance to paid
        //a factor of 2 requires at least 25% (1/4th) of the current balance to paid
        //a factor of 3 requires at least 12% (1/8th) of the current balance to paid
        //a factor of 4 requires at least 6% (1/16th) of the current balance to paid
        //etc...
        //
        _feeFactor = feeFactor;
        
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
        //
        
        //_registerInterface(type(iMutableSupplyToken).interfaceId);
        //_registerInterface(type(iStaticSupplyCap).interfaceId);
        
        //_registerInterface(type(iERC721PayableAutoIdStaticCapMint).interfaceId);
        
        //_requireCanReceiverEther(sender);
        //_requireCanReceiverEther(_this);
        
        //_this.call{
            //value:msg.value
        //}("");
    }
    
    function mintFee(
    )public view returns(
        uint256
    ){
        return _mintFee;
    }
    
    function burnFee(
    )public view returns(
        uint256
    ){
        return _burnFee;
    }
    function priceFloor(
    )public view returns(
        uint256
    ){
        return _minWei;
    }
    //function setPriceFloor(
        //uint256 floor
    //)public virtual override
    //{
        //_requireOwnerAdminOrThis(
            //_msgSender()
        //);
        
        //floor.requireGreaterThanZero();
        
        //_minWei.requireNotEqual(floor);
        
        //_minWei = floor;
        
        ////return _minWei;
    //}
    
    //function _setFeeFactor(
        //uint8 factor
    //)internal
    //{
        //_feeFactor.requireNotEqual(factor);
        
        //if(factor <= _MAX_CUT_FACTOR){
            //_feeFactor = factor;
        //}
        //else{
            //_feeFactor = _MAX_CUT_FACTOR;
        //}
        
        ////return _feeFactor;
    //}
    
    //function _setCutFactor(
        //uint8 factor
    //)internal
    //{
        //_mintCutFactor.requireNotEqual(factor);
        
        //if(factor <= _MAX_CUT_FACTOR){
            //_mintCutFactor = factor;
        //}
        //else{
            //_mintCutFactor = _MAX_CUT_FACTOR;
        //}
        
        ////return _mintCutFactor;
    //}
    
    //function priceFloor(
    //)public view virtual override returns(
        //uint256
    //){
        //return _minWei;
    //}
    
    //function minMintFee(
    //)public view virtual override returns(
        //uint256
    //){
        //_this.balance.requireGreaterThanZero();
        
        //return _this.balance > ((1 << _feeFactor)).add(_minWei) ? (_this.balance >> _feeFactor).add(_minWei) : _minWei;
    //}
    
    //function minBurnFee(
    //)public view virtual override returns(
        //uint256
    //){
        //_this.balance.requireGreaterThanZero();
        
        //return _this.balance > ((1 << _feeFactor)).add(_minWei) ? (_this.balance >> _feeFactor).add(_minWei) : _minWei;
    //}
    
    
    //function setFeeFactor(
        //uint8 newFactor
    //)public virtual override
    //{
        //_requireOwnerAdminOrThis(
            //_msgSender()
        //);
        //require(
            //newFactor != _feeFactor
        //);
        
        //if(factor <= _MAX_CUT_FACTOR){
            //_feeFactor = _MAX_CUT_FACTOR;
        //}
        //else{
            //_feeFactor = newFactor;
        //}
    //}
    
    //function setMintFee(
        //uint256 newMintFee
    //)public virtual override returns(
        //uint256
    //){
        //_requireOwnerAdminOrThis(
            //_msgSender()
        //);
        
        //newMintFee.requireGreaterThanZero();
        //newMintFee.requireNotEqual(_mintFee);
        //newMintFee.requireGreaterThanOrEqual(minMintFee());
        //
        //_mintFee = newMintFee;
        
        //return _mintFee;
    //}
    
    //function setBurnFee(
        //uint256 newBurnFee
    //)public virtual override returns(
        //uint256
    //){
        //_requireOwnerAdminOrThis(
            //_msgSender()
        //);
        
        //newBurnFee.requireGreaterThanZero();
        //newBurnFee.requireNotEqual(_burnFee);
        //newBurnFee.requireGreaterThanOrEqual(minBurnFee());
        //
        //_burnFee = newBurnFee;
        //
        //return _burnFee;
    //}
    
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
    //)external virtual override payable nonReentrant
    //{
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
                
                //if(!_isContract(O)){
                    //_requireOnEtherReceived(O, sender, val);
                //}
                //
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
    //)external virtual override payable nonReentrant
    //{
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
                
                ////payable(O).call{
                    ////value:val
                ////}("");
                
                //if(!_isContract(O)){
                    //_requireOnEtherReceived(O, sender, val);
                //}
                //
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
        //bytes calldata data
    //)external virtual override payable nonReentrant
    //{
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
            //data
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        //address O = owner();
        
        //if(O.notNull()){
            //if(sender.notEqual(O)){
                //uint256 val = msg.value >> _mintCutFactor;
                //
                //_requireCanReceiveEther(O);
                
                ////payable(O).call{
                    ////value:val
                ////}("");
                
                //if(!_isContract(O)){
                    //_requireOnEtherReceived(O, sender, val);
                //}
                //
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
        //address to
    //)external virtual override payable nonReentrant
    //{
        //adress sender = _msgSender();
        
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
            //to
        //);
        
        //_increaseTotalSupply(uint256Logic.ONE);
        
        //address O = owner();
        
        //if(O.notNull()){
            //if(sender.notEqual(O)){
                //uint256 val = msg.value >> _mintCutFactor;
                //
                //_requireCanReceiveEther(O);
                
                ////payable(O).call{
                    ////value:val
                ////}("");
                
                //if(!_isContract(O)){
                    //_requireOnEtherReceived(O, sender, val);
                //}
                //
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
    //)external virtual override payable nonReentrant
    //{
        //adress sender = _msgSender();
        
        //_requireRoleOrAdmin(
            //ROLE_MINTER,
            //sender
        //);
        
        //address O = owner();
        
        //bool notOwner = sender.notEqual(O);
        
        //msg.value.requireGreaterThanOrEqual(_mintFee);
        
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
        
        //address O = owner();
        
        //if(O.notNull()){
            //if(sender.notEqual(O)){
                //uint256 val = msg.value >> _mintCutFactor;
                //
                //pay half to owner
                
                //_requireCanReceiveEther(O);
                
                ////payable(O).call{
                    ////value:val
                ////}("");
                
                //if(!_isContract(O)){
                    //_requireOnEtherReceived(O, sender, val);
                //}
                //
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
        
        //TS.sub(1).requireGreaterThanZero();
        
        //_burn(
            //tokenId
        //);
        
        //_decreaseTotalSupply(uint256Logic.ONE);
        
        //address O = owner();
        
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
        //address owner,
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
            //msg.value.requireGreaterThanOrEqual(_burnFee);
            
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
        
        //address O = owner();
        
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