// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Static Token Supply Transaction Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
/// @dev immutable (view/read-only) token supply interface
///
interface abiEncoderStaticTokenSupply
{
    /// 
    /// @return {bytes}
    /// 
    bytes internal constant SIG_TOTAL_SUPPLY = abi.encodeWithSignature('totalSupply()');
}