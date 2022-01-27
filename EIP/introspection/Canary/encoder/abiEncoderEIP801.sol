// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

///
/// @title EIP-801 Canary Transaction Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev ligi, "EIP-801: ERC-801 Canary Standard [DRAFT]," Ethereum Improvement Proposals, no. 801, December 2017. [Online serial].
/// Available: https://eips.ethereum.org/EIPS/eip-801
/// 
library abiEncoderEIP801
{
    bytes public constant SIG_IS_ALIVE = abi.encodeWithSignature('isAlive()');
    //
    bytes public constant SIG_CREATED_TIMESTAMP = abi.encodeWithSignature('createdTimestamp()');
    bytes public constant SIG_CREATED_BLOCK = abi.encodeWithSignature('createdBlock()');
    //
    bytes public constant SIG_AGE = abi.encodeWithSignature('age()');
    bytes public constant SIG_BLOCK_AGE = abi.encodeWithSignature('blockAge()');
}