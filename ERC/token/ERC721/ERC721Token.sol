// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/token/ERC721/ERC721.sol";
///
/// @title ERC721 Non-Fungible Token Standard basic implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/5/2021, All Rights Reserved
/// @dev ERC721 compliant token contract
///
abstract contract ERC721Token is ERC721
{
    //todo: adapt ERC20Snapshot for ERC721 tokens
    using SafeMath for uint256;
    using Address for address;
    
    using EnumerableSet for EnumerableSet.UintSet;
    using EnumerableMap for EnumerableMap.UintToAddressMap;
    
    using Strings for uint256;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using addressLogic for address;
    
    using eventsERC721 for address;

    string private constant _NAME = " ERC721Token: ";
    //string private constant _TOKEN_DOES_NOT_EXIST = _NAME.concatenate("token does not exist");
    
    string private constant _ERR_NOT_OWNER_NOR_APPROVED = string(
        abi.encodePacked(
            _NAME,
            "caller is not owner nor approved for all"
        )
    );
    
    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `iERC721Receiver.onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = iERC721Receiver.onERC721Received.selector;   //0x150b7a02;
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
    
    /// @dev Initialize contract, setting `name` and `symbol` for the token collection
    constructor(
        string memory collectionName,
        string memory collectionSymbol,
        string memory baseURI
    )internal
        //EIP801Canary()
        ERC721(
            collectionName,
            collectionSymbol,
            baseURI
        )
    {
        // register the supported interfaces to conform to ERC721 via ERC165
        //_registerInterface(_INTERFACE_ID_ERC721);
        //_registerInterface(_INTERFACE_ID_ERC721_METADATA);
        //_registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
        
        //_registerInterface(_IID_ERC721_TOKEN);
    }
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
    /// @dev See {iERC721.approve}
    function approve(
        address to,
        uint256 tokenId
    )external virtual override nonReentrant
    {
        address owner = ownerOf(tokenId);
        address sender = _msgSender();
        
        require(
            sender.equal(owner) || isApprovedForAll(owner, sender),
            _ERR_NOT_OWNER_NOR_APPROVED
        );

        _approve(sender, to, tokenId);
    }
    /// @dev non-standard function for caller to revoke a previously approved token transfer,
    /// if they own token with `tokenId` and a previous approval was permitted
    function revokeApproval(
        uint256 tokenId
    )external virtual override nonReentrant
    {
        address owner = ownerOf(tokenId);
        address sender = _msgSender();
        
        require(
            sender.equal(owner) || isApprovedForAll(owner, sender),
            _ERR_NOT_OWNER_NOR_APPROVED
        );

        _clearApproval(sender, tokenId);
    }
    /// @dev See {iERC721.setApprovalForAll}
    function setApprovalForAll(
        address operator,
        bool approved
    )external virtual override nonReentrant
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
    /// 
    /// @dev See {iERC721.transferFrom}
    /// 
    /// NOTE:
    ///     recommended for use, unless `to` is explicitly known to not be a contract
    ///     prefer using the safe* family of transfer functions
    ///
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    )external virtual override nonReentrant
        //onlyApprovedOrOwner(tokenId)
    {
        //solhint-disable-next-line max-line-length
        _isApprovedOrOwner(
            _msgSender(),
            tokenId
        ).requireTrue(
            string(
                abi.encdoePacked(
                    _NAME,
                    "transferFrom(address,address,uint256)",
                    _ERR_NOT_OWNER_NOR_APPROVED
                )
            )
        );

        _transfer(
            from,
            to,
            tokenId
        );
    }
    //
    //safeTransferFrom functions
    //
    /// @dev See {iERC721.safeTransferFrom}
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    )external virtual override nonReentrant
        //onlyApprovedOrOwner(tokenId)
    {
        _safeTransferFrom(
            from,
            _msgSender(),
            to,
            tokenId,
            data
        );
    }
    /// @dev See {iERC721.safeTransferFrom}
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    )external virtual override nonReentrant
    {
        _safeTransferFrom(
            from,
            to,
            tokenId,
            ""
        );
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
    )internal virtual
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
}