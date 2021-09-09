// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

import "https://github.com/vigilance91/solidarity/EIP/announcements/encoder/EncoderEIP1129ABC.sol";

//interface iEncoderEIP1129Announcements is iERC165,
//    iEncoderEIP1129
//{
//}

///
/// @title EIP-1129 Announcements Transaction Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
/// 
contract EncoderEIP1129Announcements is ERC165,
    EncoderEIP1129ABC
{
    constructor(
    )public
        ERC165()
        EncoderEIP1129ABC()
    {
        //_registerInterface(type(iEncoderEIP1129).interfaceId);
        //_registerInterface(type(iEncoderEIP1129Announcements).interfaceId);
    }
}