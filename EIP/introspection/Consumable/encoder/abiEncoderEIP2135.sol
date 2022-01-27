// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-2135 Consumable Transaction Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// @dev Ethereum Improvments Proposal: Consumable Interface: https://eips.ethereum.org/EIPS/eip-2135
/// consideration of ERC-721 was given when drafting this EIP and is backwards compatible with ERC-721
/// one example would be a ticket which is consumed to gain entry to an event
/// another would be a consumable, like a potion being used in a game
/// this EIP can also integrate with EIP1753, to create Consumable Licences
///
library abiEncoderEIP2135
{
    string internal constant STUB_IS_CONSUMABLE = 'isConsumable(uint256)';
    string internal constant STUB_CONSUME = 'consume(uint256)';
    
    function isConsumable(
        uint256 assetId
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_IS_CONSUMABLE,
            assetId
        );
    }
    
    function consume(
        uint256 assetId
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_CONSUME,
            assetId
        );
    }
}