// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/ERC20Token.sol";
import "https://github.com/vigilance91/solidarity/EIP/EIP1046/EIP1046.sol";
/// https://eips.ethereum.org/EIPS/eip-1046

//interface iEIP1046TokenMetadata is iERC20,
//  iEIP1046{
//}
///
/// @title EIP-1046 ERC20 Token Metadata Extension Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 7/4/2021, All Rights Reserved
/// @dev https://eips.ethereum.org/EIPS/eip-1046 by: Tommy Nicholas, Matt Russo, John Zettler, Matt Condon
///
abstract contract EIP1046TokenMetadata is ERC20Token,
    EIP1046
{
    constructor(
        string memory name,
        string memory symbol,
        uint256 totalSupply,
        string memory externalTokenURI
    )internal ERC20Token(name, symbol, totalSupply)
        EIP1046(externalTokenURI)
    {
        _registerInterface(type(iEIP1046).interfaceId);
        //_registerInterface(type(iEIP1046TokenMetadata).interfaceId);
    }
}