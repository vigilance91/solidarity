// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @dev Interface for the ERC20 standard
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
///
interface iEncoderTokenIdentifier
{
    /// 
    /// @return {bytes} payload for calling `name()` on an an external address/proxy which support the TokenIdentifier interface
    ///
    function name(
    )external pure returns(
        bytes memory
    );
    ///
    /// @return {bytes} payload for calling `symbol()` on an an external address/proxy which support the TokenIdentifier interface
    ///
    function symbol(
    )external pure returns(
        bytes memory
    );
}