// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/token/ERC721/iERC721.sol";
//import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/iTokenSupply.sol";
///
/// @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
/// @dev See https://eips.ethereum.org/EIPS/eip-721
///
interface iERC721Enumerable is iERC721
    //iTokenSupply
{
    /// @return {uint256} total amount of tokens stored by the contract
    function totalSupply(
    )external view returns(
        uint256
    );
    ///
    /// @return {uint256} a token ID owned by `owner` at `index` of its token list
    /// @dev Use along with {balanceOf} to enumerate all of ``owner``'s tokens
    ///
    function tokenOfOwnerByIndex(
        address owner,
        uint256 index
    )external view returns(
        uint256 tokenId
    );
    ///
    /// @return {uint256} token ID at `index` of all the tokens stored by the contract
    /// @dev Use along with {totalSupply} to enumerate all tokens
    ///
    function tokenByIndex(
        uint256 index
    )external view returns(
        uint256
    );
}