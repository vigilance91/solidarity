// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/iERC721Receiver.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/eventsERC721Receiver.sol";
///
/// @title ERC721 Reciever Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
///
abstract contract ERC721ReceiverABC is iERC721Receiver
    //ERC165,
{
    using eventsERC721Receiver for address;
    
    bytes4 internal constant _ERC721_RECEIVED = iERC721Receiver.onERC721Received.selector;
    
    constructor(
    )internal //ERC165()
    {
        //_registerInterface(type(iERC20Receiver).interfaceId);
    }
    
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    )public virtual override returns(
        bytes4
    ){
        address(this).emitReceivedERC721(
            operator,
            from,
            tokenId,
            data
        );
        
        return _ERC721_RECEIVED;
    }
    function canReceiveERC721(
    )external view virtual override returns(
        bool
    ){
        return true;
    }
}