// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/introspection/Consumable/encoder/iEncoderAllowance.sol";
import "https://github.com/vigilance91/solidarity/EIP/introspection/Consumable/encoder/abiEncoderAllowance.sol";
///
/// @title Allowance Transaction Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// 
abstract contract EncoderAllowanceABC is iEncoderAllowance
{
    using abiEncoderAllowance for address;
    
    constructor(
    )internal
    {
    }
    ///
    /// @return {bytes}
    ///
    function allowance(
        address owner,
        address spender
    )public pure override returns(
        bytes memory
    ){
        return owner.allowance(
            spender
        );
    }
    ///
    /// @return {bytes} 
    /// 
    function approve(
        address spender
    )public pure override returns(
        bytes memory
    ){
        return spender.approve();
    }
    ///
    /// @return {bytes} 
    /// 
    function revokeAllowance(
        address spender
    )public pure override returns(
        bytes memory
    ){
        return spender.revokeAllowance();
    }
}