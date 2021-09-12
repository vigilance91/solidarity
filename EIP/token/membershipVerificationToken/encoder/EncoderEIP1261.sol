// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/token/membershipVerificationToken/encoder/EncoderEIP1261ABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

//interface iEncoderEIP1261MVT is iEncoderEIP1261
//{
//}
///
/// @title EIP-1261 Membership Verification Token Transaction ABI Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// convenience library for creating encoded signatures for low-level address call operations
///
abstract contract EncoderEIP1261 is ERC165,
    EncoderEIP1261ABC
{
    constructor(
    )public
        ERC165()
        EncoderTokenIdentifierABC()
    {
        //todo register appropriate interface in derived class which inherits from ERC-165
        //_registerInterface(type(iEncoderTokenIdentifier).interfaceId);
        _registerInterface(type(iEncoderEIP1261).interfaceId);
    }
}