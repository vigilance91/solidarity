// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/encoder/EncoderEtherTransactorABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title Ether Transactor Transaction Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
/// 
contract EncoderEtherTransactor is iEncoderEtherReceiver,
    EncoderEtherReceiver,
    EncoderEtherTransactorABC
{
    constructor(
    )public
        EncoderEtherReceiver()
        EncoderEtherTransactorABC()
    {
        _registerInterface(type(iEncoderEtherTransactor).interfaceId);
    }
}