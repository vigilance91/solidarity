// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Ether Receiver Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 27/4/2021, All Rights Reserved
/// @dev Any contract capable of receiving Ether transfers should inherit and implement this interface
///
interface iEtherReceiver
{
    ///
    /// @return {bytes4} function selector of `iEtherReceiver.onEtherReceived`, used to confirm transfers
    /// @dev used as a post-check, if any value other than the function selector is returned or the interface is not implemented by the recipient,
    /// revert the transfer
    ///
    function onEtherReceived(
        address from,
        uint256 amount
    )external returns(
        bytes4
    );
    ///@return {bool} true if the implementing contract accepts Ether, used as a pre-check
    function canReceiveEther(
    )external view returns(
        bool
    );
}