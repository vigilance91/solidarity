// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

import "https://github.com/vigilance91/solidarity/EIP/introspection/Consumable/encoder/EncoderEIP2135ABC.sol";

interface iEncoderEIP2135Consumable is iERC165,
    iEncoderEIP2135
{
}

///
/// @title EIP-2135 Consumable Transaction Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/9/2021, All Rights Reserved
/// 
contract EncoderEIP2135Consumable is ERC165,
    EncoderEIP2135ABC
{
    constructor(
    )public
        ERC165()
        EncoderEIP2135ABC()
    {
        _registerInterface(type(iEncoderEIP2135).interfaceId);
        //_registerInterface(type(iEncoderEIP2135Consumable).interfaceId);
    }
}