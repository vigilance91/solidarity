// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/introspection/Consumable/encoder/iEncoderEIP2135.sol";
import "https://github.com/vigilance91/solidarity/EIP/introspection/Consumable/encoder/abiEncoderEIP2135.sol";
///
/// @title EIP-2135 Consumable Transaction Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// @dev ERC-2135 Consumable Standard
/// Available: https://eips.ethereum.org/EIPS/eip-2135
/// 
abstract contract EncoderEIP2135ABC is iEncoderEIP2135
{
    using abiEncoderEIP2135 for uint256;
    
    constructor(
    )internal
    {
    }
    
    function isConsumable(
        uint256 assetId
    )public pure override returns(
        bytes memory
    ){
        return assetId.isConsumable();
    }
    
    function consume(
        uint256 assetId
    )public pure override returns(
        bytes memory
    ){
        return assetId.consume();
    }
}