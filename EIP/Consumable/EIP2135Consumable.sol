// SPDX-License-Identifier: Apache 2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "../ERC173/ERC173Ownable.sol";
import "./EIP2135.sol";

//interface iEIP2135Consumable is iERC173Ownable,    //EIP801Canary
    //iEIP2135
//{

//}
///
/// @title EIP-2135 Consumable Standard
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
///Ethereum Improvments Proposal: Consumable Interface: https://eips.ethereum.org/EIPS/eip-2135
///consideration of ERC-721 was given when drafting this EIP and is backwards compatible with ERC-721
///one example would be a ticket which is consumed to gain entry to an event
///another would be a consumable, like a potion being used in a role paying game
///this EIP can also be composable with the EIP-1753 (License) purposal,
///to create Consumable Licences, which are issued once and then consumed
///
abstract contract EIP2135Consumable is ERC173Ownable,    //EIP801Canary
    EIP2135
{
    constructor(
    )internal ERC173Ownable()
        EIP2135()
    {
        _registerInterface(type(iEIP2135).interfaceId);
        //_registerInterface(type(iEIP2135Consumable).interfaceId);
    }
}