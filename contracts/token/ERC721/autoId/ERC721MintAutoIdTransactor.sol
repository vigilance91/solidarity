// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/token/ERC721/ERC721Token.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/PausableAccessControl.sol";
///
/// @title ERC721 Token Mint Auto Id Transactor
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/5/2021, All Rights Reserved
/// @dev ERC721 Token Mint capable of sending and receiving ERC721 transfers,
/// either to/from this contract itself or other ERC721 compatible contracts,
/// allowing this contract to hold or distribute any NFTs in its custody,
/// similar to an Escrow (like SafeERC20Transactor)
///
abstract contract ERC721MintAutoIdTransactor is ERC721MintAutoId
    ERC721TransactorABC
{
    using logicConstraints for bool;
    using AddressConstraint for address;
    
    constructor(
        string memory name,
        string memory symbol,
        string memory baseURI
        //string memory version
    )internal
        ERC721MintAutoId(
            name,
            symbol,
            baseURI
            //version
        )
        ERC721TransactorABC()
    {
    }
    
    /// @dev token transfers, minting and burning are all disabled when paused
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    )internal virtual override
    {
        super._beforeTokenTransfer(
            from,
            to,
            tokenId
        );
    }
}