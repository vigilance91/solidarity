// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/frameworkERC721.sol";
///
/// @title ERC721 Receiver Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 20/4/2021, All Rights Reserved
///
abstract contract ERC721ReceiverConstraintsABC //is ContractConstraintsABC
{
    using logicConstraints for bool;
    
    using frameworkERC721 for address;
    
    string private constant _TRANSFER_FAILED = " ERC721ReceiverConstraintsABC: contract cannot receive ERC721 transfers";
    
    constructor(
    )internal{
    }
    
    function _requireCanReceiveERC721(
        address recipient
    )internal view
    {
        recipient.canReceiveERC721().requireTrue(
            _TRANSFER_FAILED
        );
    }
    function _requireOnERC721Received(
        address recipient,
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    )internal
    {
        recipient.onERC20Received(
            operator,
            from,
            tokenId,
            data
        ).requireTrue(
            _TRANSFER_FAILED
        );
    }
}