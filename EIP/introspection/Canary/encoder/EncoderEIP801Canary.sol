// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/encoder/EncoderEIP801ABC.sol";

interface iEncoderEIP801Canary is iERC165,
    iEncoderEIP801
{
}

///
/// @title EIP-801 Canary Transaction Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/9/2021, All Rights Reserved
/// 
contract EncoderEIP801Canary is ERC165,
    EncoderEIP801ABC
{
    constructor(
    )public
        ERC165()
        EncoderEIP801ABC()
    {
        _registerInterface(type(iEncoderEIP801).interfaceId);
        //_registerInterface(type(iEncoderEIP801Canary).interfaceId);
    }
}