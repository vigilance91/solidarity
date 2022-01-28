// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/token/ERC721/ERC721Token.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/PausableAccessControl.sol";
///
/// @title ERC721 Auto ID Token Mint ABstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/10/2021, All Rights Reserved
/// @dev Abstract Base Contract for an ERC721 Token Mint
///
abstract contract ERC721MintAutoIdABC is PausableAccessControl,
    ERC721Token
{
    using logicConstraints for bool;
    using AddressConstraint for address;
    
    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIdTracker;
    //mapping(uint256=>bool) _burnedTokenIds;
    //Counters.Counter private _burnedTokenTracker;
    
    //string private constant _NAME = ' ERC721MintAUtoId: ';
    bytes32 public constant ROLE_MINTER = keccak256("ERC-721.Mint.ROLE_MINTER");
    bytes32 public constant ROLE_BURNER = keccak256("ERC-721.Mint.ROLE_BURNER");
    
    //string private _version;
    
    constructor(
        string memory name,
        string memory symbol,
        string memory baseURI
        //string memory version
    )internal
        PausableAccessControl()
        ERC721Token(
            collectionName,
            collectionSymbol
        )
    {
        address sender = _msgSender();
        
        _setRoleAdmin(ROLE_MINTER, ROLE_DEFAULT_ADMIN);
        _setRoleAdmin(ROLE_BURNER, ROLE_DEFAULT_ADMIN);
        
        _setupRole(ROLE_MINTER, sender);
        _setupRole(ROLE_BURNER, sender);
        
        _setBaseURI(baseURI);
        
        //_registerInterface(type(iPausableAccessControl).interfaceId);
    }
    /// 
    ///@ dev NOTE:
    ///     _exists() is  already called natively by _mint and _burn
    ///     this just serves as an additonal check to maintain consistent state
    ///     between the auto generated IDs which exist and the token IDs which have been burned
    ///  
    function _tokenExists(
        uint256 tokenId
    )internal view returns(
        bool
    ){
        uint256 CTID = _tokenIdTracker.current();
        
        if(CTID == 0){
            return false;
        }
        
        return _burnedTokenIds[tokenId] == false && tokenId < CTID; //&& _exists(tokenId);
    }
    function _requireExists(
        uint256 tokenId
    )internal view
    {
        _tokenExists(tokenId).requireTrue(
            'token does not exist'
        );
    }
    function _requireDoesNotExist(
        uint256 tokenId
    )internal view
    {
        _tokenExists(tokenId).requireFalse(
            'token already exists'
        );
    }
    function _mint(
        address to
    )internal
    {
        to.requireNotNull();
        
        uint256 TID = _tokenIdTracker.current();
        
        _mint(
            to,
            TID
        );
        
        _tokenIdTracker.increment();
    }
    /// @dev token transfers, minting and burning are all disabled when paused
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    )internal virtual override
    {
        require(
            !paused(),  //.requireFalse(
            "mint is paused"
        );
        
        //from.requireNotEqual(to);
        
        //if(from.equalsNull()){    // address(0)){
            //mint
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