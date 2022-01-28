// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/iERC721Receiver.sol";
///
/// @title ERC721 Non-Receivable Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 10/12/2021, All Rights Reserved
/// @dev inherit from this abstract base contract if the contract should reject ERC-721 transfers to it
///
abstract contract ERC721NonReceivableABC is iERC721Receiver
{
    bytes4 internal constant _ERC721_DENIED = bytes4(0);
    
    constructor(
    )internal
    {
    }
    
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    )public virtual override returns(
        bytes4
    ){  
        return _ERC721_DENIED;
    }
    function canReceiveERC721(
    )external view virtual override returns(
        bool
    ){
        return false;
    }
}