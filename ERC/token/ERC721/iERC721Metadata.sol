// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/token/ERC721/iERC721.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/TokenIdentifier/iTokenIdentifier.sol";
///
/// @title optional metadata extension for ERC-721 Non-Fungible Token Standard
/// @dev See https://eips.ethereum.org/EIPS/eip-721
///
interface iERC721Metadata is iERC721
    iTokenIdentifier
{
    /// @return {string} the Uniform Resource Identifier (URI) for `tokenId` token
    function tokenURI(
        uint256 tokenId
    )external view returns(
        string memory
    );
}