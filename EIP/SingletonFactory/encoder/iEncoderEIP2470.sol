// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-2470 Singleton Factory Transaction Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
/// @dev based on EIP-2470 https://eips.ethereum.org/EIPS/eip-2470 by, Ricardo Guilherme Schmidt (Status Research & Development GmbH)
///     Ethereum Improvments Proposal: Singleton Factory - https://eips.ethereum.org/EIPS/eip-2470
///
interface iEIP2470
{
    ///
    /// read-only interface
    ///
    function deployedContracts(
    )external pure returns(
        bytes memory
    );
    ///
    /// pure interface
    ///
    function deploy(
        bytes memory byteCode,
        bytes32 salt
    )external pure returns(
        bytes memory
    );
    
    function deployPayable(
        bytes memory byteCode,
        bytes32 salt
    )external pure returns(
        bytes memory
    );
}