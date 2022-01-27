// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-801 Canary Transaction Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// @dev ligi, "EIP-801: ERC-801 Canary Standard [DRAFT]," Ethereum Improvement Proposals, no. 801, December 2017. [Online serial].
/// Available: https://eips.ethereum.org/EIPS/eip-801
/// 
interface iEncoderEIP801
{
    function isAlive(
    )external pure returns(
        bytes memory
    );
    //timestamp (in seconds) of the transaction mined after the implementing contract is deployed
    function createdTimestamp(
    )external pure returns(
        bytes memory
    );
    //block number of the transaction mined after the implementing contract is deployed
    function createdBlock(
    )external pure returns(
        bytes memory
    );
    /// difference (in seconds) between created timestamp and now
    function age(
    )external pure returns(
        bytes memory
    );
    /// difference (in blocks) between created block and the current block
    function blockAge(
    )external pure returns(
        bytes memory
    );
}