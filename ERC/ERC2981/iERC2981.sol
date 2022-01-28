// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.7.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/iERC165.sol";
///
/// @title iERC2981
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 28/7/2021, All Rights Reserved
/// @dev {iERC2981} interface declaration
///
interface iERC2981 //is iERC165
{
    /// 
    /// bytes4(keccak256("royaltyInfo(uint256,uint256)")) == 0x2a55205a
    /// bytes4 public constant INTERFACE_ID = type(iERC2981).interfaceId;
    /// _registerInterface(iERC2981.INTERFACE_ID);
    ///
    
    /// 
    /// @notice determine how much royalty fees are owed based on sale price and to whom
    /// 
    /// @param tokenId {uint256} NFT asset queried for royalty information
    /// @param salePrice {uint256} sale price of the NFT asset specified by _tokenId
    /// 
    /// @return receiver {address} receiver of the royalty payment
    /// @return royaltyAmount {uint256} royalty payment amount for salePrice
    /// 
    function royaltyInfo(
        uint256 tokenId,
        uint256 salePrice
    )external view returns(
        address receiver,
        uint256 royaltyAmount
    );
}