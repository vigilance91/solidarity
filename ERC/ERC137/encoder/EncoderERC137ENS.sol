// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/ERC137/encoder/EncoderERC137ABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title Full ERC-137 Ethereum Domain Name Service Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 11/30/2021, All Rights Reserved
///
//interface iEncoderERC137ENS is iERC165,
//    iEncoderERC137
//{
//}

///
/// @title ERC-137 Ethereum Domain Name Service Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/11/2021, All Rights Reserved
///
contract EncoderERC137ENS is ERC165,
    EncoderERC137ABC
{
    constructor(
    )public
        ERC165()
        EncoderERC137ABC()
    {
        //_registerInterface(type(iEncoderERC137).interfaceId);
        //_registerInterface(type(iEncoderERC137ENS).interfaceId);
    }
}