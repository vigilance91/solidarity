// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/ERC/token/ERC721/iERC721.sol";
import "https://github.com/vigilance91/solidarity/ERC/token/ERC721/iERC721Metadata.sol";
import "https://github.com/vigilance91/solidarity/ERC/token/ERC721/iERC721Enumerable.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/receiver/iERC721Receiver.sol";

import "https://github.com/vigilance91/solidarity/ERC/token/ERC721/ERC721MetaDataABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/token/ERC721/eventsERC721.sol";

import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/EIP801Canary.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableSet.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableMap.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Strings.sol";
//import "https://github.com/vigilance91/solidarity/libraries/unsignedéuint256ToString.sol";

//28/10/2021

library mixinERC721
{
    using SafeMath for uint256;
    using Address for address;
    
    using EnumerableSet for EnumerableSet.UintSet;
    using EnumerableMap for EnumerableMap.UintToAddressMap;
    
    //bytes32 private constant _NAMESPACE_HASH = bytes32(uint256(
        //keccak256("solidarity.mixin.")
    //) - 1);
    //_STORAGE_SLOT = _NAMESPACE_HASH ^ bytes32(uint256(
        //keccak256("eip721.STORAGE_SLOT")
    //) - 1);
    
    bytes32 private constant STORAGE_SLOT = keccak256("solidarity.mixin.ERC-721.STORAGE_SLOT");
    
    struct ERC721Storage{
        // Mapping from holder address to their (enumerable) set of owned tokens
        mapping(address=>EnumerableSet.UintSet) holderTokens;
        // Enumerable mapping from token ids to their owners
        EnumerableMap.UintToAddressMap tokenOwners;
        // Mapping from owner to operator approvals
        mapping(address=>mapping(address=>bool)) operatorApprovals;
        //
        // Mapping from token ID to approved address
        mapping (uint256=>address) tokenApprovals;
        // Optional mapping for token URIs
        mapping (uint256=>string) tokenURIs;
    }
    
    function storageERC721(
        bytes32 slot
    )internal pure returns(
        ERC721Storage storage ret
    ){
        assembly {
            ret_slot := slot
        }
    }
    /**
    function holderTokens(
        address account
    )internal view returns(
        EnumerableSet.UintSet storage
    ){
        return storageERC721().holderTokens;
    }
    function tokenURIs(
        address account
    )internal view returns(
        EnumerableSet.UintSet storage
    ){
        return storageERC721().tokenURIs;
    }
    */
}

//interface iERC721AutoId is 
    //iEIP801Canary,
    //iERC721,
    //iERC721Metadata,
    //iERC721Enumerable
//{
    //
//}

//interface iERC721AutoIdTransactor is iEtherTransactor,
    //iERC721Transactor
//{
    //
//}
///
/// @title ERC721 Non-Fungible Token Standard basic implementation
/// @dev see https://eips.ethereum.org/EIPS/eip-721
///
abstract contract ERC721 is EIP801Canary,   //ERC165, //Ownable OR Canary
    ERC721MetaDataABC,
    //iERC721,
    //iERC721Metadata,
    iERC721Enumerable
    //ERC721TransactorABC
{
    //using mixinERC721 for bytes32;
    //todo: adapt ERC20Snapshot for ERC721 tokens
    using SafeMath for uint256;
    
    using Address for address;
    
    using EnumerableSet for EnumerableSet.UintSet;
    using EnumerableMap for EnumerableMap.UintToAddressMap;
    
    using Strings for uint256;
    //using uint256ToString for uint256;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using addressLogic for address;
    
    using eventsERC721 for address;

    string private constant _NAME = " ERC721: ";
    //string private constant _TOKEN_DOES_NOT_EXIST = _NAME.concatenate("token does not exist");
    
    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `iERC721Receiver.onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = iERC721Receiver.onERC721Received.selector;   //0x150b7a02;
    
    //
    //struct DataStorage{
        // Mapping from holder address to their (enumerable) set of owned tokens
        mapping(address=>EnumerableSet.UintSet) internal _holderTokens;
        // Enumerable mapping from token ids to their owners
        EnumerableMap.UintToAddressMap internal _tokenOwners;
        // Mapping from owner to operator approvals
        mapping(address=>mapping(address=>bool)) internal _operatorApprovals;
        //
        // Mapping from token ID to approved address
        mapping(uint256=>address) internal _tokenApprovals;
        // Optional mapping for token URIs
        mapping(uint256=>string) internal _tokenURIs;
    //}
    //
    /*
     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
     *
     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
     *        0xa22cb465 ^ 0xe985e9c5 ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
     */
    bytes4 private constant _INTERFACE_ID_ERC721 = type(iERC721).interfaceId;    //0x80ac58cd;
    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = type(iERC721Metadata).interfaceId;   //0x5b5e139f;
    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = type(iERC721Enumerable).interfaceId;    //0x780e9d63;
    /*
     *     bytes4(keccak256('name()')) == 0x06fdde03
     *     bytes4(keccak256('symbol()')) == 0x95d89b41
     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd
     *
     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
     */
    
    /*
     *     bytes4(keccak256('totalSupply()')) == 0x18160ddd
     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59
     *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7
     *
     *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63
     */
    
    string private constant _ERR_TOKEN_EXISTS = "token exists";
    string private constant _ERR_TOKEN_DOES_NOT_EXIST = "token does not exist";
    string private constant _ERR_CALLER_NOT_APPROVED = "approve caller is not owner, nor approved for all";
    
    string private constant _ERR_IERC721_RECEIVER_NOT_IMPLEMENT = "iERC721Receiver not implemented"
    
    /// @dev Initialize contract, setting `name` and `symbol` for the token collection
    constructor(
        string memory collectionName,
        string memory collectionSymbol,
        string memory baseURI
        //uint256 majorVersion,
        //uint256 minorVersion
    )internal
        //ERC721TransactorABC()
        EIP801Canary()  //collectionName, majorVersion, minorVersion)
        ERC721MetaDataABC(
            collectionName,
            collectionSymbol,
            baseURI
        )
    {
        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721);
        _registerInterface(_INTERFACE_ID_ERC721_METADATA);
        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
        //_registerInterface(type(iERC721AutoId).interfaceId);
    }
    //function _storageERC721(
        //bytes32 slot
    //)private pure returns(
        //mixinERC721.ERC721Storage storage
    //){
        //return mixinERC721.storageERC721(slot);
    //}
    
    //modifier onlyApprovedOrOwner(
        //uint256 tokenId
    //){
        //_isApprovedOrOwner(
            //_msgSender(),
            //tokenId
        //).requireTrue(
            //"caller is not owner, nor approved"
        //);
        //_;
    //}
    
    function _requireExists(
        uint256 tokenId
    )internal view
    {
        _exists(tokenId).requireTrue(
            _ERR_TOKEN_EXISTS
        );
    }
    function _requireNotExists(
        uint256 tokenId
    )internal view
    {
        _exists(tokenId).requireFalse(
            _ERR_TOKEN_EXISTS
        );
    }
    //function _holderTokens(
    //)internal view returns(
        //mapping(address=>EnumerableSet.UintSet) storage
    //){
        //return _slot.holderTokens();
    //}
    // Enumerable mapping from token ids to their owners
    //function _tokenOwners(
    //)internal view returns(
        //EnumerableMap.UintToAddressMap storage
    //){
        //return _slot.tokenOwners();
    //}
    // Mapping from owner to operator approvals
    //function _operatorApprovals(
    //)internal view returns(
        //mapping(address=>mapping(address=>bool)) storage
    //){
        //return _slot._operatorApprovals;
    //}
    //
    // Mapping from token ID to approved address
    //function _tokenApprovals(    
    //)internal view returns(
        //mapping(uint256=>address) storage
    //{
        //return _slot._tokenApprovals();
    //}
    //
    // Optional mapping for token URIs
    //function _tokenURIs(    
    //)internal view returns(
        //mapping(uint256=>string) storage
    //){
        //return _slot.tokenURIs();
    //}
    
    /// @dev See {iERC721.balanceOf}
    function balanceOf(
        address owner
    )public view override returns(
        uint256
    ){
        owner.requireNotNull(
            //"balance query for the zero address"
        );

        return _holderTokens[owner].length();
    }
    function balanceOf(
    )public view returns(
        uint256
    ){
        return balanceOf(_msgSender());
    }
    //function balanceOfOwner(
    //)public view override returns(
        //uint256
    //){
        //return balanceOf(owner());
    //}
    //get any ERC721 tokens owned by this contract
    function _ERC721BalanceOfThis(
    )internal view returns(
        uint256
    ){
        return balanceOf(_this);
    }
    
    /// @dev See {iERC721.ownerOf}
    function ownerOf(
        uint256 tokenId
    )public view override returns(
        address
    ){
        return _tokenOwners.get(
            tokenId,
            "owner query for nonexistent token"
        );
    }
    //// @dev See {iERC721Metadata.tokenURI}
    function tokenURI(
        uint256 tokenId
    )public view returns(
        string memory
    ){
        _exists(tokenId).requireTrue(
            //"tokenURI: token does not exist"
            _ERR_TOKEN_DOES_NOT_EXIST
        );

        string memory URI = _tokenURIs[tokenId];
        string memory uriRoot = baseURI();
        // If there is no base URI, return the token URI.
        //if(bytes(_baseURI).length == 0){
        if(bytes(uriRoot).length == 0){
            return URI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked)
        if(bytes(URI).length > 0){
            //return _baseURI.concatenate(URI);
            return string(
                abi.encodePacked(uriRoot, URI)
            );
        }
        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI
        //return _baseURI.concatenate(tokeId,toHexadecimal());
        return string(
            abi.encodePacked(uriRoot, tokenId.toString())
        );
    }
    /// @dev See {iERC721Enumerable.tokenOfOwnerByIndex}
    function tokenOfOwnerByIndex(
        address owner,
        uint256 index
    )public view override returns(
        uint256
    ){
        owner.requireNotNull(
        );
        
        return _holderTokens[owner].at(index);
    }
    //function tokenOfOwnerByIndex(
        //uint256 index
    //)public view override returns(
        //uint256
    //){
        //return tokenOfOwnerByIndex(_msgSender(), index);
    //}
    ///
    /// @dev See {iERC721Enumerable.totalSupply}
    /// _tokenOwners are indexed by tokenIds, so .length() returns the number of tokenIds
    ///
    function totalSupply(
    )public view override returns(
        uint256
    ){
        return _tokenOwners.length();
    }
    /// @dev See {iERC721Enumerable.tokenByIndex}
    function tokenByIndex(
        uint256 index
    )public view override returns(
        uint256 //tokenId
    ){
        //(tokenId, ) = _tokenOwners.at(index);
        (uint256 tokenId, ) = _tokenOwners.at(index);
        
        return tokenId;
    }
    /// @dev See {iERC721.approve}
    function approve(
        address to,
        uint256 tokenId
    )external virtual override nonReentrant
    {
        address owner = ownerOf(tokenId);
        
        to.requireNotEqual(
            owner
            //"approval to current owner"
        );
        address sender = _msgSender();
        
        //if(_notOwner(sender)){
            //_isApprovedOrOwner(sender).requireTrue(
                //"approve caller is not owner, nor approved for all"
            //);
            require(
                sender.equal(owner) || isApprovedForAll(owner, sender) || getApproved(tokenId).equal(sender),
                "approve caller is not owner, nor approved for all"
            );
        //}
        
        _approve(owner, to, tokenId);
    }
    /*
    //approve address `to` to transfer token `tokenId` owned by this contract
    function thisApprove(
        address to,
        uint256 tokenId
    )public virtual override
    {
        //_requireOwnerAdminOrThis();
        
        address owner = ownerOf(tokenId);
        
        to.requireNotEqual(
            owner
            //"approval to current owner"
        );
        
        address sender = _msgSender();
        
        //if(_notOwner(sender)){
            require(
                isApprovedForAll(owner, sender) || getApproved(tokenId).equal(sender),
                "approve caller is not owner, nor approved for all"
            );
        //}
        
        _approve(_this, to, tokenId);
    }
    */
    ///@dev See {iERC721.getApproved}
    function getApproved(
        uint256 tokenId
    )public view override returns(
        address
    ){
        _requireExists(tokenId);

        return _tokenApprovals[tokenId];
    }
    /*
    //caller approves this contract for transfering token `tokenId`
    function approveThis(
        uint256 tokenId
    )external virtual override
    {
        address owner = ownerOf(tokenId);
        
        _this.requireNotEqual(
            owner
            //"approval to current owner"
        );
        
        owner.equal(
            _msgSender()
        ).requireTrue();
        
        _approve(owner, _this, tokenId);
    }
    //approve this contract to transfer all tokens owned by `sender`
    function _setApproveThisForAll(
        address sender,
        bool approved
    )internal virtual override
    {
        _this.requireNotEqual(
            sender
            //"cannot approve to caller"
        );

        _operatorApprovals[sender][_this] = approved;
        
        sender.emitApprovalForAll(
            _this,
            approved
        );
    }
    */
    /// @dev See {iERC721.setApprovalForAll}
    function setApprovalForAll(
        address operator,
        bool approved
    )public virtual override nonReentrant
    {
        address sender = _msgSender();
        
        operator.requireNotEqual(
            sender
            //"cannot approve to caller"
        );

        _operatorApprovals[sender][operator] = approved;
        
        sender.emitApprovalForAll(
            operator,
            approved
        );
    }
    
    /// @dev See {iERC721.setApprovalForAll}
    function _thisSetApprovalForAll(
        address operator,
        bool approved
    )internal
    {
        //address sender = _msgSender();
        
        operator.requireNotEqualAndNotNull(
            _this
            //"cannot approve caller"
        );

        _operatorApprovals[_this][operator] = approved;
        
        _this.emitApprovalForAll(
            operator,
            approved
        );
    }
    
    /// @dev See {iERC721.setApprovalForAll}
    function _thisSetApproveOwnerForAll(
        bool approved
    )internal
    {
        //address sender = _msgSender();
        address O = owner();
        
        O.requireNotEqualAndNotNull(
            _this
            //"cannot approve caller"
        );

        _operatorApprovals[_this][O] = approved;
        
        _this.emitApprovalForAll(
            O,
            approved
        );
    }
    
    /// @dev See {IERC721-isApprovedForAll}
    function isApprovedForAll(
        address owner,
        address operator
    )public view override returns(
        bool
    ){
        operator.requireNotNull();
        owner.requireNotNull();  
        owner.requireNotEqual(
            operator
        );
        
        return _operatorApprovals[owner][operator];
    }
    //is this contract's approved to transfer all of `owners` tokens
    function _isThisApprovedForAll(
        address owner
    )internal view returns(
        bool
    ){
        //_this.requireNotNull();
        owner.requireNotEqualAndNotNull(
            _this
        );
        
        return _operatorApprovals[owner][_this];
    }
    //is this contract's owner approved to transfer all this contract's tokens
    function _thisIsOwnerApprovedForAll(
    )internal view returns(
        bool
    ){
        address O = owner();
        
        O.requireNotEqualAndNotNull(
            _this
        );
        
        return _operatorApprovals[_this][O];
    }
    //is caller approved for all token transfer from `owner` account
    function isApprovedForAll(
        address owner
    )public view returns(
        bool
    ){
        owner.requireNotNull();
        
        address sender = _msgSender();
        
        sender.requireNotNull();
        
        owner.requireNotEqual(
            sender
        );
        
        return _operatorApprovals[owner][sender];
    }
    function _safeTransferFrom(
        address from,
        address sender,
        address to,
        uint256 tokenId,
        bytes memory data
    )internal
        //onlyApprovedOrOwner(tokenId)
    {
        _isApprovedOrOwner(
            sender,
            tokenId
        ).requireTrue(
            _ERR_CALLER_NOT_APPROVED    //"caller is not owner, nor approved"
        );
        
        _safeTransfer(
            from,
            to,
            tokenId,
            data
        );
    }
    ///
    /// @dev Safely transfers `tokenId` token from `from` to `to`,
    /// checking first that contract recipients are aware of the ERC721 protocol to prevent tokens from being forever locked
    ///
    /// `data` optional payload with no specified format, is sent in call to `to`
    ///
    /// This internal function is equivalent to {safeTransferFrom}, and can be used to
    /// implement alternative mechanisms to perform token transfer, such as signature-based
    ///
    /// Requirements:
    ///     - `from` cannot be null
    ///     - `to` cannot be null
    ///     - `from` cannot be `to`
    ///     - `tokenId` token must exist and be owned by `from`
    ///     - If `to` refers to a smart contract, it must implement {iERC721Receiver.onERC721Received}, which is called upon a safe transfer
    ///
    /// Emits a {Transfer} event
    ///
    function _safeTransfer(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    )internal virtual
    {
        //_requireCanReceiveERC721(to, from, tokenId, data);
        
        _transfer(
            from,
            to,
            tokenId
        );
        
        _checkOnERC721Received(
            from,
            to,
            tokenId,
            data
        ).requireTrue(
            _ERR_IERC721_RECEIVER_NOT_IMPLEMENT
        );
    }
    ///
    /// @dev Safely transfers `tokenId` token from `from` to `to`,
    /// checking first that contract recipients are aware of the ERC721 protocol to prevent tokens from being forever locked
    ///
    /// This is a convenience function which is equivalent to {safeTransfer}, and can be used to
    /// when an additional binary payload is not needed for executionan auxillary transaction
    ///
    /// Requirements:
    ///     - `from` cannot be null
    ///     - `to` cannot be null
    ///     - `from` cannot be `to`
    ///     - `tokenId` token must exist and be owned by `from`
    ///     - If `to` refers to a smart contract, it must implement {iERC721Receiver.onERC721Received}, which is called upon a safe transfer
    ///
    /// Emits a {Transfer} event
    ///
    function _safeTransfer(
        address from,
        address to,
        uint256 tokenId
    )internal virtual
    {
        _safeTransfer(
            from,
            to,
            tokenId,
            ""  //stringLogic.EMPTY
        );
    }
    ///
    /// @return {bool} true if `tokenId` exists otherwise false
    ///
    /// Tokens can ONLY be managed by their owner or approved accounts via {approve} or {setApprovalForAll}
    ///
    /// Tokens start existing when they are minted (`_mint`),
    /// and stop existing when they are burned (`_burn`).
    ///
    function _exists(
        uint256 tokenId
    )internal view returns(
        bool
    ){
        return _tokenOwners.contains(tokenId);
    }
    ///
    /// @return {bool} true if `spender` is allowed to manage `tokenId` otherwise false
    ///
    /// Requirements:
    ///     - `spender` cannot be null
    ///     - `tokenId` must exist
    ///
    function _isApprovedOrOwner(
        address spender,
        uint256 tokenId
    )internal view returns(
        bool
    ){
        _requireExists(tokenId);
        
        address owner = ownerOf(tokenId);
        
        return (spender.equal(owner) || spender.equal(getApproved(tokenId)) || isApprovedForAll(owner, spender));
    }
    ///
    /// @dev Safely mints `tokenId` and transfers it to `to`
    /// Emits a {Transfer} event
    ///
    /// Requirements:
    ///     - `to` cannot be null
    ///     - `tokenId` must not exist
    ///     - If `to` refers to a smart contract, it must implement {iERC721Receiver.onERC721Received}, which is called upon a safe transfer
    ///
    function _safeMint(
        address to,
        uint256 tokenId
    )internal virtual
    {
        _safeMint(
            to,
            tokenId,
            ""  //stringLogic.EMPTY
        );
    }
    ///
    /// @dev Same as {xref-ERC721-_safeMint-address-uint256-}[`_safeMint`],
    /// with an additional `data` parameter which is forwarded in {iERC721Receiver.onERC721Received} to contract recipients
    ///
    function _safeMint(
        address to,
        uint256 tokenId,
        bytes memory data
    )internal virtual
    {
        //_requireCanReceiveERC721(to, tokenId, data);
        
        _mint(
            to,
            tokenId
        );
        
        _checkOnERC721Received(
            addressLogic.NULL,
            to,
            tokenId,
            data
        ).requireTrue(
            _ERR_IERC721_RECEIVER_NOT_IMPLEMENT
        );
    }
    function _mintToThis(
        uint256 tokenId
    )internal virtual
    {
        _mint(_this, tokenId);
    }
    function _mintToOwner(
        uint256 tokenId
    )internal virtual
    {
        _mint(owner(), tokenId);
    }
    function _safeMintToThis(
        uint256 tokenId
    )internal virtual
    {
        _safeMint(_this, tokenId);
    }
    function _safeMintToOwner(
        uint256 tokenId
    )internal virtual
    {
        _safeMint(owner(), tokenId);
    }
    ///
    /// @dev Mints `tokenId` and transfers it to `to`
    ///
    /// WARNING:
    ///     Usage of this method is discouraged, use {_safeMint} whenever possible
    ///
    /// Requirements:
    ///     - `tokenId` must not exist.
    ///     - `to` cannot be the zero address.
    ///
    /// Emits a {Transfer} event
    ///
    function _mint(
        address to,
        uint256 tokenId
    )internal virtual
    {
        to.requireNotNull(
            //"cannot mint to null address"
        );
        //tokenId cannot already exist
        _requireNotExists(tokenId);

        _beforeTokenTransfer(
            addressLogic.NULL,
            to,
            tokenId
        );

        _holderTokens[to].add(
            tokenId
        );

        _tokenOwners.set(tokenId, to);

        addressLogic.NULL.emitTransfer(
            to,
            tokenId
        );
    }
    ///
    /// @dev Destroy `tokenId`
    /// Any previous approval is cleared when burning tokens
    ///
    /// Requirements:
    ///     - `tokenId` must exist
    ///
    /// Emits a {Transfer} event
    ///
    function _burn(
        uint256 tokenId
    )internal virtual
    {
        _requireExists(tokenId);
        
        address owner = ownerOf(tokenId);

        _beforeTokenTransfer(
            owner,
            addressLogic.NULL,
            tokenId
        );
        // Clear approvals
        _approve(
            owner,
            addressLogic.NULL,
            tokenId
        );
        // Clear metadata (if any)
        if(bytes(_tokenURIs[tokenId]).length != 0){
            delete _tokenURIs[tokenId];
        }

        _holderTokens[owner].remove(tokenId);

        _tokenOwners.remove(tokenId);

        owner.emitTransfer(
            addressLogic.NULL,
            tokenId
        );
    }
    ///
    /// @dev Transfers `tokenId` from `from` to `to`
    /// As opposed to {transferFrom}, this imposes no restrictions on msg.sender
    /// and is generally considered NOT safe for use
    ///
    /// Requirements:
    ///     - `from` cannot be `to`
    ///     - `tokenId` token must be owned by `from`
    ///
    /// Emits a {Transfer} event
    ///
    function _transfer(
        address from,
        address to,
        uint256 tokenId
    )internal virtual
    {
        //from.requireNotNull();
        //to.requireNotNull();
        
        from.requireNotEqual(
            to
        );
        
        ownerOf(tokenId).requireEqual(
            from
            //"_transfer: caller is not token owner"
        );
        
        _beforeTokenTransfer(
            from,
            to,
            tokenId
        );
        // Clear approvals from the previous owner
        _approve(
            from,
            addressLogic.NULL,
            tokenId
        );

        _holderTokens[from].remove(tokenId);
        _holderTokens[to].add(
            tokenId
        );

        _tokenOwners.set(tokenId, to);

        from.emitTransfer(
            to,
            tokenId
        );
    }
    ///
    /// @dev Transfers `tokenId` from this contract to this contract's owner
    ///
    /// Requirements:
    ///     - `to` must not be null
    ///     - `to` must be a wallet address or a contract which supports iERC721Receiver
    ///     - `tokenId` must exist and be owned by this contract
    ///
    /// Emits a {Transfer} event
    ///
    function _transferFromThisTo(
        address to,
        uint256 tokenId
    )internal
    {
        to.requireNotEqualAndNotNull(_this);
        
        ownerOf(tokenId).requireEqual(
            _this
            //"_transfer: caller is not token owner"
        );
        
        //_requireCanReceiveERC721(to);
        
        _beforeTokenTransfer(
            _this,
            to,
            tokenId
        );
        // Clear approvals from the previous owner
        _approve(
            _this,
            addressLogic.NULL,
            tokenId
        );

        _holderTokens[_this].remove(tokenId);
        _holderTokens[to].add(
            tokenId
        );

        _tokenOwners.set(tokenId, to);

        _this.emitTransfer(
            to,
            tokenId
        );
    }
    function _transferFromThisToOwner(
        uint256 tokenId
    )internal
    {
        _transferFromThisTo(owner(), tokenId);
    }
    ///
    /// @dev Sets `_tokenURI` as the tokenURI of `tokenId`
    ///
    /// Requirements:
    ///     - `tokenId` must exist
    ///
    function _setTokenURI(
        uint256 tokenId,
        string memory _tokenURI
    )internal virtual
    {
        _requireExists(tokenId);
        //_tokenURIs[tokenId].requireNotEqual(_tokenURI);
        
        _tokenURIs[tokenId] = _tokenURI;
    }
    
    function _approve(
        address owner,
        address to,
        uint256 tokenId
    )internal
    {
        //to.requireNotNull();
        //can't approve for self
        owner.requireNotEqual(to);
        owner.requireEqual(ownerOf(tokenId));
        
        _tokenApprovals[tokenId] = to;
        
        owner.emitApproval(
            to,
            tokenId
        );
    }
    function _thisApprove(
        address to,
        uint256 tokenId
    )internal
    {
        _approve(_this, to, tokenId);
    }
    function _thisApproveOwner(
        uint256 tokenId
    )internal
    {
        _thisApprove(owner(), tokenId);
    }
    //
    function _ownerApprove(
        address to,
        uint256 tokenId
    )internal
    {
        _approve(owner(), to, tokenId);
    }
    function _ownerApproveThis(
        uint256 tokenId
    )internal
    {
        _ownerApprove(_this, tokenId);
    }
    /// 
    /// @dev sets the approved address to null,
    /// effectively clearing the previously set approval,
    /// can be used to either revoke an approved transfer or simply
    /// disable an approval after a succesful token transfer
    /// 
    function _clearApproval(
        address owner,
        uint256 tokenId
    )internal
    {
        _approve(
            owner,
            addressLogic.NULL,
            tokenId
        );
    }
    //function _thisClearApproval(
        //uint256 tokenID
    //)internal
    //{
        //_clearApproval(
            //_this,
            //tokenId
        //);
    //}
    //function _ownerClearApproval(
        //uint256 tokenID
    //)internal
    //{
        //_clearApproval(
            //owner(),
            //tokenId
        //);
    //}
    ///
    /// @dev Internal function to invoke {iERC721Receiver-onERC721Received} on a target address.
    /// The call is not executed if the target address is not a contract
    ///
    /// @param `from` previous owner of the given token ID
    /// @param `to` target address that will receive the tokens
    /// @param `tokenId` ID of the token to be transferred
    /// @param `data` optional, data to send along with the call, data should be the result of calling abi.encodePacked()
    ///     it is up to the implementation to abi.decode data as requried
    /// @return {bool} whether the call correctly returned the expected magic value
    ///
    function _checkOnERC721Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    )private returns(
        bool
    ){
        if(!to.isContract()){
            return true;
        }
        
        bytes memory returndata = to.functionCall(
            abi.encodeWithSelector(
                iERC721Receiver.onERC721Received.selector,
                _msgSender(),
                from,
                tokenId,
                data
            ),
            _ERR_IERC721_RECEIVER_NOT_IMPLEMENT
        );
        
        bytes4 retval = abi.decode(returndata, (bytes4));
        
        return (retval == _ERC721_RECEIVED);
    }
    ///
    /// @dev Hook that is called before any token transfer,
    /// this includes minting and burning
    ///
    /// Calling conditions:
    ///     - `from` and `to` cannot be the same address
    ///     - When `from` and `to` are both non-zero:
    ///         *token `tokenId` will be transferred from `from`, to `to`
    ///     - When `from` is zero:
    ///         * `tokenId` will be minted for `to`
    ///     - When `to` is zero:
    ///         * `tokenId` will be burned from `from`
    ///
    /// read more about hooks here: xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks]
    ///
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    )internal virtual;
}