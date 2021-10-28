// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/IERC165.sol";

library eventsERC721
{
    /// @dev Emitted when `tokenId` token is transferred from `from` to `to`
    event Transfer(
        address from,
        address to,
        uint256 tokenId
    );
    /// @dev Emitted when `owner` enables `approved` to manage the `tokenId` token
    event Approval(
        address owner,
        address approved,
        uint256 tokenId
    );
    /// @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets
    event ApprovalForAll(
        address owner,
        address operator,
        bool approved
    );
    ///
    ///emitter functions
    ///
    function emitTransfer(
        address from,
        address to,
        uint256 tokenId
    )internal
    {
        emit Transfer(
            from,
            to,
            tokenId
        );
    }
    /// @dev Emitted when `owner` enables `approved` to manage the `tokenId` token
    function emitApproval(
        address owner,
        address approved,
        uint256 tokenId
    )internal
    {
        emit Approval(
            owner,
            approved,
            tokenId
        );
    }
    /// @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets
    function emitApprovalForAll(
        address owner,
        address operator,
        bool approved
    )internal
    {
        emit ApprovalForAll(
            owner,
            operator,
            approved
        );
    }
}