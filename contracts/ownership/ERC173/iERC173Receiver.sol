// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC173 ownership receiver interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
/// @dev Any contract capable of receiving ERC173 ownership transfers should inherit from and implement this interface
///
interface iERC173Receiver
{
    ///
    /// @return {bytes4} function selector of `iERC173Receiver.onERC173Received`, used to confirm token transfer
    /// @dev used as a post-check, if any value other than the function selector is returned or the interface is not implemented by the recipient,
    /// revert the transfer
    ///
    function onERC173Received(
        address from
    )external returns(
        bytes4
    );
    ///@return {bool} true if the implementing contract accepts ERC173 tokens, used as a pre-check
    function canReceiveERC173(
    )external view returns(
        bool
    );
}