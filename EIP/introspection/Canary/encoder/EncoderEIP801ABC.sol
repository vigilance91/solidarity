// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/encoder/iEncoderEIP801.sol";
import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/encoder/abiEncoderEIP801.sol";
///
/// @title EIP-801 Canary Transaction Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// @dev ligi, "EIP-801: ERC-801 Canary Standard [DRAFT]," Ethereum Improvement Proposals, no. 801, December 2017. [Online serial].
/// Available: https://eips.ethereum.org/EIPS/eip-801
/// 
abstract contract EncoderEIP801ABC is iEncoderEIP801
{
    constructor(
    )internal
    {
    }
    
    function isAlive(
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEIP801.SIG_IS_ALIVE;
    }
    /// 
    /// @return {bytes} payload for a `createdTimestamp` call to an external contract or proxy
    /// 
    function createdTimestamp(
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEIP801.SIG_CREATED_TIMESTAMP;
    }
    /// 
    /// @return {bytes} payload for a `createdBlock` call to an external contract or proxy
    /// 
    function createdBlock(
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEIP801.SIG_CREATED_BLOCK;
    }
    /// 
    /// @return {bytes} payload for a `age` call to an external contract or proxy
    /// 
    function age(
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEIP801.SIG_AGE;
    }
    /// 
    /// @return {bytes} payload for a `blockAge` call to an external contract or proxy
    /// 
    function blockAge(
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEIP801.SIG_BLOCK_AGE;
    }
    /**
    /// @return {bytes} payload for a `blockAdjustedAge` call to an external contract or proxy
    /// 
    function blockAdjustedAge(
    )public pure returns(
        bytes memory
    ){
        return abiEncoderEIP801.SIG_BLOCK_ADJUSTED_AGE;
    }
    */
}