// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/apoptosis/encoder/abiEncoderApoptosis.sol";

import "https://github.com/vigilance91/solidarity/contracts/apoptosis/encoder/iEncoderApoptosis.sol";
///
/// @title Encoder Apoptosis Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
///
abstract contract EncoderApoptosisABC is iEncoderApoptosis
{
    constructor(
    )internal
    {
    }
    /// 
    /// @return {bytes} payload for calling apoptosis on an external contract or proxy
    /// 
    function apoptosis(
    )public pure virtual override returns(
        bytes memory
    ){
        return abiEncoderApoptosis.SIG_APOPTOSIS;
    }
}