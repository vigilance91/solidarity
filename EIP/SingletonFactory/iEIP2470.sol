// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-2470 Singleton Factory View Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
/// @dev based on EIP-2470 https://eips.ethereum.org/EIPS/eip-2470 by, Ricardo Guilherme Schmidt (Status Research & Development GmbH)
///     Ethereum Improvments Proposal: Singleton Factory - https://eips.ethereum.org/EIPS/eip-2470
/// 
interface iEIP2470View
{
    function deployedContracts(
    )external view returns(
        address[] memory
    );
}
///
/// @title EIP-2470 Singleton Factory Mutable Interface
/// @notice Exposes CREATE2 (EIP-1014) to deploy bytecode on deterministic addresses based on initialization code and salt.
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
/// @dev based on EIP-2470 https://eips.ethereum.org/EIPS/eip-2470 by, Ricardo Guilherme Schmidt (Status Research & Development GmbH)
///     Ethereum Improvments Proposal: Singleton Factory - https://eips.ethereum.org/EIPS/eip-2470
/// 
interface iEIP2470Mutable
{
    function deploy(
        bytes memory byteCode,
        bytes32 salt
    )external returns(
        address
    );
}
///
/// @title EIP-2470 Singleton Factory Mutable Interface
/// @notice Exposes CREATE2 (EIP-1014) to deploy bytecode on deterministic addresses based on initialization code and salt.
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
/// @dev based on EIP-2470 https://eips.ethereum.org/EIPS/eip-2470 by, Ricardo Guilherme Schmidt (Status Research & Development GmbH)
///     Ethereum Improvments Proposal: Singleton Factory - https://eips.ethereum.org/EIPS/eip-2470
/// 
interface iEIP2470MutableBatched
{
    function deploy(
        bytes[] calldata code,
        bytes32 salt
    )external returns(
        address[] memory deployed
    );

    //function deploy(
        //bytes[] calldata code,
        //bytes32[] calldata salt
    //)external returns(
        //address[] deployed
    //);
}
//interface iEIP2470MutableFull is iEIP2470Mutable,
    //iEIP2470MutableBatched
//{
    //
//}
///
/// @title EIP-2470 Singleton Factory Payable Interface
/// @notice Exposes CREATE2 (EIP-1014) to deploy bytecode on deterministic addresses based on initialization code and salt which require a payment of ETH to be deployed
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
/// @dev based on EIP-2470 https://eips.ethereum.org/EIPS/eip-2470 by, Ricardo Guilherme Schmidt (Status Research & Development GmbH)
///     Ethereum Improvments Proposal: Singleton Factory - https://eips.ethereum.org/EIPS/eip-2470
/// 
interface iEIP2470Payable
{   
    function deployPayable(
        bytes memory byteCode,
        bytes32 salt
    )external payable returns(
        address
    );
}
///
/// @title EIP-2470 Singleton Factory Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
/// @dev based on EIP-2470 https://eips.ethereum.org/EIPS/eip-2470 by, Ricardo Guilherme Schmidt (Status Research & Development GmbH)
///     Ethereum Improvments Proposal: Singleton Factory - https://eips.ethereum.org/EIPS/eip-2470
///
interface iEIP2470 is iEIP2470View,
    iEIP2470Mutable
{
}
///
/// @title Standard and Batched EIP-2470 Singleton Factory Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
/// @dev based on EIP-2470 https://eips.ethereum.org/EIPS/eip-2470 by, Ricardo Guilherme Schmidt (Status Research & Development GmbH)
///     Ethereum Improvments Proposal: Singleton Factory - https://eips.ethereum.org/EIPS/eip-2470
///
//interface iEIP2470Full is iEIP2470View,
    //iEIP2470MutableFull
//{
//
//}