// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-801 Canary Standard Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev ligi, "EIP-801: ERC-801 Canary Standard [DRAFT]," Ethereum Improvement Proposals, no. 801, December 2017. [Online serial].
/// Available: https://eips.ethereum.org/EIPS/eip-801
/// 
interface iEIP801
{
    function isAlive(
    )external view returns(
        bool
    );
    //timestamp (in seconds) of the transaction mined after the implementing contract is deployed
    function createdTimestamp(
    )external view returns(
        uint
    );
    //block number of the transaction mined after the implementing contract is deployed
    function createdBlock(
    )external view returns(
        uint
    );
    /// difference (in seconds) between created timestamp and now
    function age(
    )external view returns(
        uint
    );
    /// difference (in blocks) between created block and the current block
    function blockAge(
    )external view returns(
        uint
    );
}