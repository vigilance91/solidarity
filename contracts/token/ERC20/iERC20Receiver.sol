// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC20 token receiver interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
/// @dev Any contract capable of receiving ERC20 token transfers should inherit and implement this interface
///
interface iERC20Receiver
{
    ///
    /// @return {bytes4} function selector of `iERC20Receiver.onERC20Received`, used to confirm token transfer
    /// @dev used as a post-check, if any value other than the function selector is returned or the interface is not implemented by the recipient,
    /// revert the transfer
    ///
    function onERC20Received(
        address from,
        uint256 amount
    )external returns(
        bytes4
    );
    ///@return {bool} true if the implementing contract accepts ERC20 tokens, used as a pre-check
    function canReceiveERC20(
    )external view returns(
        bool
    );
}