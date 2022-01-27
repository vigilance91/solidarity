// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/ERC173/encoder/EncoderERC173ABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title ERC-173 Ownership Transaction Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
contract EncoderERC173Ownership is ERC165,
    EncoderERC173ABC
{
    constructor(
    )public
        ERC165()
        EncoderERC173ABC()
    {
        //_registerInterface(type(iEncoderERC173).interfaceId);
    }
}