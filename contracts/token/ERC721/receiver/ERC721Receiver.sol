// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/iERC721Receiver.sol";
///
/// @dev {iERC721Receiver} interface Implementation
///
/// Accepts all token transfers
/// Make sure the contract is able to use its token with {iERC721.safeTransferFrom}, {iERC721.approve} or {iERC721.setApprovalForAll}
////
abstract contract ERC721Receiver is iERC721Receiver
{
    bytes4 private constant _ON_RECEIVED = iERC721Receiver.onERC721Received.selector
    
    constructor(
    )internal{
    }
    
    function canReceiveERC721(
    )public virtual override returns(
        bool
    ){
        return true;
    }
    ///
    /// @dev See {iERC721Receiver.onERC721Received}
    /// @return {bytes4} `iERC721Receiver.onERC721Received.selector`
    ///
    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    )public virtual override returns(
        bytes4
    ){
        return _ON_RECEIVED;
    }
}