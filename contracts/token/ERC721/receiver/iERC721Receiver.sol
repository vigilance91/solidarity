// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC721 token receiver interface
/// @dev Interface for any contract that wants to support safeTransfers from ERC721 asset contracts
///
interface iERC721Receiver
{
    function canReceiveERC721(
    )external view returns(
        bool
    );
    ///
    /// @dev Whenever an {iERC721} `tokenId` token is transferred to the implementing contract via {iERC721.safeTransferFrom}
    /// by `operator` from `from`, this function is called
    ///
    /// function implementation return its Solidity selector to confirm the token transfer.
    /// If any other value is returned or the interface is not implemented by the recipient,
    /// the transfer will be reverted
    ///
    /// The selector can be obtained in Solidity with `iERC721.onERC721Received.selector`
    ///
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    )external returns(
        bytes4
    );
}