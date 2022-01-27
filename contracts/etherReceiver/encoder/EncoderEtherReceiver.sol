// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/encoder/EncoderEtherReceiverABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title Ether Receiver Transaction Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
/// 
contract EncoderEtherReceiverABC is ERC165
    EncoderEtherReceiverABC
{
    constructor(
    )public
        ERC165()
        EncoderEtherReceiverABC()
    {
        _registerInterface(type(iEncoderEtherReceiver).interfaceId);
    }
}