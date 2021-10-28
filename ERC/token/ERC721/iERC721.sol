// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/iERC165.sol";
//import "https://github.com/vigilance91/solidarity/contracts/token/iTokenSupply.sol";
///
/// @title ERC721 Compliant Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
///
interface iERC721 is iERC165
    //iTokenBalance
{
    /// @return {uint256} number of `owner`'s tokens
    function balanceOf(
        address owner
    )external view returns(
        uint256 balance
    );
    
    /// @return {uint256} number of `caller`'s tokens
    //function balanceOf(
    //)external view returns(
        //uint256 balance
    //);
    ///
    /// @return {address} owner of token `tokenId`
    ///
    /// Requirements:
    ///     - `tokenId` must exist
    ///
    function ownerOf(
        uint256 tokenId
    )external view returns(
        address owner
    );
    ///
    /// @dev Safely transfers `tokenId` token from `from` to `to`,
    /// checking first that contract recipients are aware of the ERC721 protocol to prevent tokens from being lost forever
    /// Emits a {Transfer} event
    ///
    /// Requirements:
    ///     - `from` cannot be null
    ///     - `to` cannot be null
    ///     - `from` cannot be `to`
    ///     - `tokenId` token must exist and be owned by `from`
    ///     - If caller is not `from`, it must be have been allowed to move this token by either {approve} or {setApprovalForAll}
    ///     - If `to` refers to a smart contract, it must implement {iERC721Receiver.onERC721Received}, which is called upon a safe transfer
    ///
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    )external;
    ///
    /// @dev Transfer `tokenId` token from `from` to `to`
    /// Emits a {Transfer} event
    /// 
    /// WARNING:
    ///     Usage of this method is discouraged and may cause permanent, unrecoverable loss of tokens,
    ///     using {safeTransferFrom} is preferred
    ///
    /// Requirements:
    ///     - `from` cannot be null
    ///     - `to` cannot be null
    ///     - `from` cannot be `to`
    ///     - `tokenId` token must exist and be owned by `from`
    ///     - If caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}
    ///
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    )external;
    ///
    /// @dev Gives permission to `to` to transfer `tokenId` token to another account
    /// The approval is cleared when the token is transferred
    /// Emits an {Approval} event
    ///
    /// Only a single account can be approved at a time
    ///
    /// NOTE:
    ///     approving the zero address clears previous approvals
    ///
    /// Requirements:
    ///     - The caller must own the token or be an approved operator
    ///     - `tokenId` must exist
    ///
    function approve(
        address to,
        uint256 tokenId
    )external;
    ///
    /// @return {address} account approved for `tokenId` token
    ///
    /// Requirements:
    ///     - `tokenId` must exist
    ///
    function getApproved(
        uint256 tokenId
    )external view returns(
        address operator
    );
    ///
    /// @dev Approve or remove `operator` as an operator for the caller
    /// Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller
    /// Emits an {ApprovalForAll} event
    /// 
    /// Requirements:
    ///     - `operator` cannot be null or the caller
    ///
    function setApprovalForAll(
        address operator,
        bool _approved
    )external;
    ///
    /// @return {bool} true if `operator` is allowed to manage all of the assets of `owner`
    /// See {setApprovalForAll}
    ///
    /// Requirements:
    ///     - `owner` cannot be null
    ///     - `operator` cannot be null
    ///     - `owner` cannot be `operator`
    ///
    function isApprovedForAll(
        address owner,
        address operator
    )external view returns(
        bool
    );
    ///
    /// @dev Safely transfer token `tokenId` from `from` to `to`
    /// Emits a {Transfer} event
    /// 
    /// Requirements:
    ///     - `from` cannot be null
    ///     - `to` cannot be null
    ///     - `from` cannot be `to`
    ///     - `tokenId` must exist and be owned by `from`
    ///     - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}
    ///     - If `to` refers to a smart contract, it must implement {iERC721Receiver.onERC721Received}, which is called upon a safe transfer
    ///
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    )external;
}