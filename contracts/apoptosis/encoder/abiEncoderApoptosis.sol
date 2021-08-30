// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Apoptosis ABI Transaction Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// convenience library for creating encoded signatures for low-level address call operations on external contracts or proxies
///
library abiEncoderApoptosis
{
    //string private constant _NAME = ' abiEncoderApoptosis: ';
    //
    //getter stubs
    //
    //string internal constant _STUB_TOTAL_SUPPLY = 'apoptosis()';
    //
    //void getter signatures, these signatures are always the same, so precompute them
    //
    bytes public constant SIG_APOPTOSIS = abi.encodeWithSignature('apoptosis()');
    //
}