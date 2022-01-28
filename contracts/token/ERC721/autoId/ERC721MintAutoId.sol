// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/token/ERC721/ERC721Token.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/PausableAccessControl.sol";
///
/// @title ERC721 Auto ID Token Mint
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/5/2021, All Rights Reserved
/// @dev ERC721 Token that can be minted or irreversibly burned (destroyed)
///
abstract contract ERC721Mint is PausableAccessControl
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
        
        //_setRoleAdmin(ROLE_MINTER, ROLE_DEFAULT_ADMIN);
        //_setRoleAdmin(ROLE_BURNER, ROLE_DEFAULT_ADMIN);
        
        _setupRole(ROLE_MINTER, sender);
        _setupRole(ROLE_BURNER, sender);
        
        _setBaseURI(baseURI);
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
    ///
    /// @dev mint `tokenId` to the caller's address See {ERC721._mint}
    ///
    /// Requirements:
    ///    - caller must have ROLE_MINTER or ROLE_DEFAULT_ADMIN assigned
    ///
    function mint(
    )external virtual nonReentrant
    {
        //tokenId.requireGreaterThanZero();
        address sender = _msgSender();
        //solhint-disable-next-line max-line-length
        hasRole(ROLE_MINTER, sender).requireTrue(
            'ERC721MintAutoId.mint: caller must have minter role'
        );
        
        _mint(
            sender
        );
    }
    ///
    /// @dev convenience function to mint `tokenId`, then transfering ownership to address `to`,
    /// rather than having to make a seperate set of calls to {ERC721.approve} folowed by {ERC721.transferFrom}
    /// See {ERC721._mint}
    ///
    /// Requirements:
    ///    - caller must have ROLE_MINTER or ROLE_DEFAULT_ADMIN assigned
    ///
    /// NOTE:
    ///     this contract by default does NOT accept ERC721 transfers (when using SafeTransfer family of functons),
    ///     derived contracts should implement ERC721Receiver/ERC721Transactor and register the interface Identifier
    ///     before this contract would be able to accept ERC721 token transfers,
    ///     this is to prevent accidental, unrecoverable loss of tokens
    ///     in the event a transfer is sent to a contract address
    ///
    function mint(
        address to
    )external virtual nonReentrant
    {
        //solhint-disable-next-line max-line-length
        hasRole(ROLE_MINTER, sender).requireTrue(
            'ERC721MintAutoId.mint: caller must have minter role'
        );
        
        _mint(to);
    }
    ///
    /// @dev Burns `tokenId` if caller either owns the token or,
    /// is approved by the owner as an operator
    ///
    /// NOTE:
    ///     this method combines the equivalent {ERC20.burn} and {ERC20.burnFrom} methods into a single function
    ///
    /// See {ERC721._burn}
    ///
    /// Requirements:
    ///     - The caller must either own `tokenId` or be an approved operator
    ///     - `tokenId` must exist
    ///
    function burn(
        uint256 tokenId
    )external virtual nonReentrant
    {
        address sender = _msgSender();
        
        hasRole(ROLE_BURNER, sender).requireTrue(
            'ERC71MintAutoId.burn: caller must have burner role'
        );
        
        _isApprovedOrOwner(sender, tokenId).requireTrue(
            "caller is not owner nor approved"
        );
        
        _burn(tokenId);
        //NOTE:
        //  token tracker does NOT get decremented after token burning
        //  when an NFT is burned, that token ID is gone forever and can not be recreated
        //_burnedTokenTracker.increment();
        //_burnedTokenIds[tokenId] = true;
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